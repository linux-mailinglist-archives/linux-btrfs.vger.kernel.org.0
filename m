Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD460474E2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhLNWpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 17:45:41 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:41248 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238012AbhLNWpT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 17:45:19 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id xGXtm6irDg9rVxGXtmbIxx; Tue, 14 Dec 2021 23:45:17 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639521917; bh=Zg/d4g+0Wmg8pYu67uI0dl9sSe3Q4INsH98cIZFDtOc=;
        h=From;
        b=oR8sBROEgNXTYotvqckqn/soZEPNaPBlEls4KjfVdeEQzqiCKgYfU0XcKY2JJaMM6
         ZeNRDFHTjS3wzt8xgxKEhQb2xjX/lqtXSFvN3C2KTm3cJLMlSy4nfG9eZ4wAOETiXS
         scV3PtFsfzaE+gGcRMy+e2BtFzxcRNnwXa18L/oNAJ9KRKOpEG5dB5ulc25gCc7zMH
         mjKK+M1Jmd0lLpxmGeZTqjTcj7uv835OlJ+p0aTb2t+vn8db9qzYPPUJVz+CNYv987
         rvoDGWcvarmrrwvxq16ZuVtFycSUX8k0MaGJcfw8s9tvs/iGpMkNESL2YbGb26lnnY
         N1n8YYK1ukGZA==
X-CNFS-Analysis: v=2.4 cv=T8hJ89GQ c=1 sm=1 tr=0 ts=61b91e7d cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=32Jw21YboZByhHSgT84A:9 a=QEXdDO2ut3YA:10
Message-ID: <4ff00df9-6651-1643-15c3-ee3515c85b04@libero.it>
Date:   Tue, 14 Dec 2021 23:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Content-Language: en-US
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Subject: BUG: btrfs confused by two different fs with the same UUID mounted in
 different moment
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfK1h73jIqLtfsE6WSo4FNsD04cWoIiXUrMBih8h+gF1Q1qRUaTA0Xgc9tcOWOMo5GXRBOnRBBGEEVd5XYfj4Wgo4QxL5TABK8gY4cMIO06vDRjIwC4Jp
 zdr2LotGdQmshXi/pIlurf4QHoSmwHTcKEOf9L6T0+DnYrzshc71dJcZIRaPAx2ouoa2O1Z/B/i+oq6dP3HX9ZA9R8YUKFy1kpU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I found this bug during a develop of a test for BTRFS. Steps to reproduce


# create a filesystem with TWO loop-devices; mount it then *destroy it*
UUID=292afefb-6e8c-4fb3-9d12-8c4ecb1f2374
rm /tmp/d1
rm /tmp/d2
truncate -s 1G /tmp/d1
truncate -s 1G /tmp/d2
sudo losetup /dev/loop1 /tmp/d1
sudo losetup /dev/loop2 /tmp/d2
sudo mkfs.btrfs -U $UUID /dev/loop1 /dev/loop2
sudo mount /dev/loop1 /mnt/btrfs1
sudo umount /dev/loop1
sudo losetup -d /dev/loop2	# <---- NOTE HERE
sudo losetup -d /dev/loop1	# <---- NOTE HERE

# create a new filesystem with only ONE loop-device; mount it
rm /tmp/d1
truncate -s 1G /tmp/d1
sudo losetup /dev/loop1 /tmp/d1
sudo mkfs.btrfs -U $UUID /dev/loop1
sudo mount /dev/loop1 /mnt/btrfs1

# BUG: now under $UUID/devinfo there are TWO devices
# expected behavior: only one device is showed
ls /sys/fs/btrfs/$UUID/devinfo
1  2

# under $UUID/devices there is ONE device1
ls /sys/fs/btrfs/$UUID/devices
loop1



Obviously this is caused by the fact that the two filesystem have the same UUID. However I think that in any case $UUID/devices and $UUID/devinfo should show the same devices.


BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
