# 如何將 SteamOS 安裝到 microSD

<p align="center">
  <span>中文</span> |
  <a href="https://github.com/ryanrudolfoba/SteamOS-microSD/blob/main/README.md">English</a>
</p>

## 簡介

此儲存庫包含有關如何將 SteamOS 安裝到 microSD 的說明和指令碼。

這主要對將 Windows 安裝於內部 SSD 的 Steam Deck 使用者有用處。

## 這個指令碼是用來做什麼的？

- 將 SteamOS 安裝到 microSD。
- 設定 deck 帳戶的 sudo 密碼為 deck。
- 刪除 microSD 自動掛載規則。
- 解除掛載 SteamOS 在更新過程中試圖掛載並導致失敗的 microSD 分區 (/run/media/var)。
- 重新以 noatime 掛載分區來減少 microSD 的寫入操作。
- 禁用 swap。
- 在每次開機時執行上述指令。
- 它可以在下一次的 SteamOS 更新後保持運作。
  > 20230326：成功更新 SteamOS 至版本 3.4.6
- 只需要執行一個指令碼！

## 警告

> **Warning**\
> 這個方法只能在內部 SSD 沒有安裝 SteamOS 時使用（不論是雙重啟動還是單一啟動）

如果在內部 SSD 上已經安裝了 SteamOS， microSD 也會嘗試掛載這些分區，導致啟動失敗！目前的指令碼無法修復此問題，因爲這是在初始 SteamOS 更新後的第一次啟動時發生的。

> **Warning**\
> 如果你已在內部 SSD 上安裝了 SteamOS，請勿使用此指令碼。

再次，\
***如果你在內部 SSD 上安裝了 SteamOS，請勿使用此指令碼。***

## 免責聲明

1. 請自行承擔風險！
2. 你**將會**失去 microSD 上的所有資料。\
   你**可能**會丟失機器內部的資料，要是你搞砸了什麼的話。
3. 我不會為資料丟失或是損壞 microSD 卡等問題負責。
4. 僅供教育和研究之用。

## 但是爲什麼？！？

我做了這個的幾個原因

1. 使用通常只有在 SteamOS beta / preview 分支上才可用的 BIOS / 韌體更新。
2. 切換到測試版 / 預覽版分支，進行測試，而不影響主機上安裝的操作系統。
3. 我沒有看到有人以一種「乾淨」的方式在 microSD 上安裝 SteamOS，並能使更新正常運作。最接近的方法是將安裝好的系統複製到 microSD 上。

## 前置需求

1. [SteamOS 復原映像](https://help.steampowered.com/en/faqs/view/1b71-edf2-eb6d-2bb3).
2. 用於 Steam 復原映像的 USB，建議使用至少 8GB USB3。
3. USB C Hub / 底座、鍵盤和滑鼠。 （如果你使用無線鍵盤和滑鼠，請跳過 USB C Hub / 底座）。
4. 將備用的 microSD 卡插入 microSD 插槽 - 這是安裝 SteamOS 的地方。建議使用至少 32GB A1 / A2 microSD。

## 操作說明

> **Note**\
> 如果指示要「關機」然後再打開，請不要只是「重新啟動」。\
> 只是「重新啟動」的話它會跳過啟動選單，直接啟動安裝在內部 SSD 上的作業系統。

> **Warning**\
> 指令碼將建立一個名爲 .ryanrudolf 的目錄。請勿刪除此資料夾！\
> 指令碼將設定「deck」帳戶的 sudo 密碼為 "deck"（不帶引號）

1. [按照以下步驟建立官方的 SteamOS 復原映像檔。](https://help.steampowered.com/en/faqs/view/1b71-edf2-eb6d-2bb3)
2. 當 SteamOS 復原映像檔創建完成後，將其插入 Steam Deck 的 USB C 埠（也可以插入你使用的 USB C 集線器或底座）。
3. 當 Steam Deck 關機時，按下「音量減 + 電源」按鈕，直到聽到提示音。
4. 開機選單將會出現，選擇包含 SteamOS 復原映像檔的 USB，按下 A 鍵（或鍵盤上的 enter 鍵）。
5. 等待直到 SteamOS 復原映像啟動到桌面。
6. 將要安裝 SteamOS 系統的 microSD 插入機器 - 請確認它至少是一張 32GB A1 / A2 卡。
7. 將 Steam Deck 連線至 Wi-Fi 網絡。
8. 開啟 konsole 終端機，將此 git 儲存庫 clone 到你的 home 目錄中。

    ```bash
    cd
    git clone https://github.com/ryanrudolfoba/SteamOS-microSD.git
    ```

    ![image](https://user-images.githubusercontent.com/98122529/210011557-6ba7290d-96e2-4760-b33c-5c6c5b75c1f7.png)

9. 運行指令碼！

    ```bash
    ~/SteamOS-microSD/install_sdcard.sh
    ```

10. 在對話方塊提示上按下 *Proceed* 。等待系統重建完成。

    ![image](https://user-images.githubusercontent.com/98122529/210011817-8d4a2495-8f75-44c3-95cb-2d0769f9d623.png)

11. 系統重建進行中。根據 microSD 的速度，這將需要幾分鐘的時間。

    ![image](https://user-images.githubusercontent.com/98122529/210011958-4aa53d56-ec83-4dca-9a99-814719b10524.png)

12. 系統重建完成後，在提示窗口上按下 *Cancel*，以 *不* 重啟 Steam Deck。

    ![image](https://user-images.githubusercontent.com/98122529/210012527-7f5ab7f4-d723-4091-93ec-589200d552a5.png)

## 首次啟動

1. 將 Steam Deck *關機*，拔出包含 SteamOS 復原映像的 USB。
1. 按下「音量減 + 電源」按鈕，直到聽到提示音。
1. 開機選單將會出現，選擇安裝 SteamOS 的 microSD，並按下 A 鍵 (或鍵盤上的 Enter)。
1. 等待 SteamOS 載入。這將需要大約 1-2 分鐘，具體時間取決於 microSD 的速度。
1. 完成開機歡迎步驟 - 設定語言、時區和 WiFi 連線。
1. SteamOS 將繼續進行安裝。

    > **Note**\
    > 安裝時顯示的 "Remain 1 second." 只是在唬你。\
    > 我想這是基於 SSD 而不是 microSD 去計算的。\
    > 請耐心等待安裝完成。

1. 它可能會卡在 "Starting Steam Deck update download"\
   請至少等待約3分鐘。\
   如果狀況沒有變化，請在 Steam 選單中將 SteamDeck *關機* ，然後重複步驟 1-3。

1. 關機並重新開機後，它可能會卡在「黑畫面 + VALVE logo」。\
   這是安裝過程的一部分，它確實需要花費一些時間。\
   請至少等待約5分鐘。\
   如果散熱風扇停止運作且你被卡在這裏，請 ***嘗試按下 A 或 B 按鈕數次***，並等待幾分鐘。\
   我不確定為什麼會這樣，但根據經驗這種方法有效。

1. 更新進度完成後，你將被要求登入。\
   然後就完成囉！

## 驗證結果

1. 開機進入桌面模式。
2. 打開 konsole 終端機。
3. 確認 /var 只被掛載一次。

    df -h | grep var

    ![image](https://user-images.githubusercontent.com/98122529/210036264-fc56e052-7989-4064-a3f4-fa5e4887599d.png)

4. 確認交換swap的總計 / 已使用 / 空閒顯示爲 0。

    free -h | grep -vi mem

    ![image](https://user-images.githubusercontent.com/98122529/210036292-ad78e0fe-94f5-4156-b449-9e2afcb89836.png)

5. 確認 microSD / mmcblk0 已掛載為 noatime。

    mount | grep mmcblk0

    ![image](https://user-images.githubusercontent.com/98122529/210036335-4d50cbe3-e252-46c7-b605-73f6561d3cbb.png)

6. 如果一切看起來都很好，那麼恭喜你！ SteamOS 現在已經安裝在你的 microSD 上了！

![image](https://user-images.githubusercontent.com/98122529/210017005-6daddcf1-66af-4e69-afbf-364460c7ddd3.png)

## 從穩定版更新至測試版、預覽版等等

**Stable 3.4.4**
![image](https://user-images.githubusercontent.com/98122529/210036714-89bfe0e6-6497-46e5-a553-b65c76d624b4.png)

![image](https://user-images.githubusercontent.com/98122529/210036657-64f8463d-f644-4f79-84c9-f2deab4ca441.png)

**Preview / MAIN 3.5**
![image](https://user-images.githubusercontent.com/98122529/210037882-0e9c0ee0-9766-41e6-af6a-d31ec806bcd4.png)

![image](https://user-images.githubusercontent.com/98122529/210037947-5331a9f4-b4a8-4691-8eaf-45cf06774cdf.png)

![image](https://user-images.githubusercontent.com/98122529/210078810-16bf8b5f-5534-4439-891d-5cefcc58eee9.png)

![image](https://user-images.githubusercontent.com/98122529/210078972-06cb8f9f-234c-4bf9-b725-bede64101cfa.png)

## 故障排除

### 在歡迎設定步驟時按鈕無法使用

我不知道爲什麼。\
在我的情況下，只有觸控式螢幕可以使用。\
如果你不太幸運，請連上鍵盤和滑鼠來操作它。

在我的情況下，這個問題只在歡迎設定時發生。\
在那之後一切都運作正常。

### /dev/mmcblk0p8 is mounted; will not make a filesystem here

![Screenshot_20230101_124055](https://user-images.githubusercontent.com/16995691/210184088-393afff4-673c-4266-8f47-4f6f2224d6f6.png)

在安裝過程進行格式化以前，這個分區已經被掛載。\
當你的 microSD 在格式化之前被分割成相同的分區列表時，可能會發生這種情況。\
使用 *fdisk* 刪除所有分區並創建一個新的分區，然後格式化它。\
這樣可以防止它自動掛載分區。

跟著下一節操作就行👇

### 我搞砸了我的 microSD 卡，我要如何重置它？

1. 解除安裝所有已掛載的分區。

    > 使用 `lsblk` 檢查是否有任何已掛載的分區。

    ```bash
    sudo umount /dev/mmcblk0p8
    sudo umount /dev/mmcblk0p7
    sudo umount /dev/mmcblk0p6
    sudo umount /dev/mmcblk0p5
    sudo umount /dev/mmcblk0p4
    sudo umount /dev/mmcblk0p3
    sudo umount /dev/mmcblk0p2
    sudo umount /dev/mmcblk0p1
    ```

2. 刪除 microSD 上的所有分區，並建立一個新的分區。

    ```bash
    sudo fdisk /dev/mmcblk0
    ```

    > 使用「d」刪除分區，使用「n」建立新分區。\
    > 使用「w」儲存更改並退出。\
    > 我不會深入講解如何使用 fdisk。

3. 執行 mkfs.ext4 命令來格式化建立的分區。

    ```bash
    sudo mkfs.ext4 /dev/mmcblk0p1
    ```

4. 你現在可以回到[操作說明](#操作說明)，從第9步開始。
