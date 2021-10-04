Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFF421503
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhJDRRh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhJDRRg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:17:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FC5C061745
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 10:15:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23-20020a17090a591700b001976d2db364so436707pji.2
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L81qJdqvW17v5Zxu7JKZJAcphkCYwFW0Ls+Kz4RbHhk=;
        b=Pfkuk13csN27ab/IIjrTT/khYCeJtxr2F9Gvv8GDgT6mY0U28L1Ttw9gLOhGf1bzBL
         6B5+IKygeoY6d/Vl2jSAOCGiBcIUCi63JXZJ+WKGirbpLPj9djjtJ3UeAa4nByp7L3Ex
         Qkf+7lemU5w0YCFxX7+7BFmYkDXMB5EJcD3Grtn5XZ1bWJKpDC8lmGa8lizajALz87pZ
         JN9YUtWIpXIApQ3plNhzHpTxFQfYhgKN+FD86h1sNy+SYqbjQTIZKpqsZzREXY+G1IF0
         HgEzeWBYwGVpCnSU0EoT0dy7gJPy2AR7cXtYu1Tt9bq7AroIIqJbP2TuOkDITyszXgGd
         Crxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L81qJdqvW17v5Zxu7JKZJAcphkCYwFW0Ls+Kz4RbHhk=;
        b=LVB62PrNo36RXcViGcRGqJvrC2O+LH9A+Z1y/dhgVzX4lquuAaL5r2R5JumcAU2YMg
         pukfBW5+B4dvQH8iuYoxVAUOi08c5a2EAc03Q7blM66nS6TXiXSJ7l2eYVRbAQjcZcuP
         VhZJBLo232YITp/cCkxrksYQB3lZwHPvulYJvs76xZakfnYSz02RnpKnVyYHW/HGNuT2
         4mjopshBkHKhhwyPWs4mf9e1tkLvnhDMfHgPs0cXSZ1kfmSLsJXjV8CkoFhyTpB7CqOU
         DAl7GKgYDRw52D1uIBTjeZhol7pAmALepwQ+stCLOA4RPGnmx6PCeJaQHxvtvYj+84oR
         8Npg==
X-Gm-Message-State: AOAM531yJuLNRz+8NRR30ZNs0brtSo4/aXasDuoOS3t4IX83/jPQrUt+
        LBQ7rQrb5md1net2HUNC0ckYBNjEFo1yL4AG
X-Google-Smtp-Source: ABdhPJwBTzGTyIGrYPWhR68N/90AkA73PsGR0Nj7edKp+LT4m2tbyk1zE6ezfDKMS64E4XnNwP/7Ag==
X-Received: by 2002:a17:903:1247:b0:139:f1af:c044 with SMTP id u7-20020a170903124700b00139f1afc044mr749972plh.23.1633367746756;
        Mon, 04 Oct 2021 10:15:46 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([223.74.0.87])
        by smtp.gmail.com with ESMTPSA id 4sm13368905pjb.21.2021.10.04.10.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 10:15:46 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] btrfs: clear BTRFS_DEV_STATE_MISSING bit in btrfs_close_one_device
Date:   Tue,  5 Oct 2021 01:15:33 +0800
Message-Id: <1633367733-14671-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

bug: https://github.com/kdave/btrfs-progs/issues/389

The previous patch does not fix the bug right:
https://lore.kernel.org/linux-btrfs/1632330390-29793-1-git-send-email-zhanglikernel@gmail.com
So I write a new one

It seems that the cause of the error is decrementing
fs_devices->missing_devices but not clearing device->dev_state.
Every time we umount filesystem, it would call close_ctree,
And it would eventually involve btrfs_close_one_device to close the device,
but it only decrements fs_devices->missing_devices but does not clear
the device BTRFS_DEV_STATE_MISSING bit. Worse, this bug will cause Integer
Overflow, because every time umount, fs_devices->missing_devices will
decrease. If fs_devices->missing_devices value hit 0, it would overflow.

I add the debug print in read_one_dev
function(not in patch) to print fs_devices->missing_devices value.

[root@zllke test]# truncate -s 10g test1
[root@zllke test]# truncate -s 10g test2
[root@zllke test]# losetup /dev/loop1 test1
[root@zllke test]# losetup /dev/loop2 test2
[root@zllke test]# mkfs.btrfs -draid1 -mraid1 /dev/loop1 /dev/loop2 -f
[root@zllke test]# losetup -d /dev/loop2
[root@zllke test]# mount -o degraded /dev/loop1 /mnt/1
[root@zllke test]# umount /mnt/1
[root@zllke test]# mount -o degraded /dev/loop1 /mnt/1
[root@zllke test]# umount /mnt/1
[root@zllke test]# mount -o degraded /dev/loop1 /mnt/1
[root@zllke test]# umount /mnt/1
[root@zllke test]# dmesg
[  168.728888] loop1: detected capacity change from 0 to 20971520
[  168.751227] BTRFS: device fsid 56ad51f1-5523-463b-8547-c19486c51ebb devid 1 transid 21 /dev/loop1 scanned by systemd-udevd (2311)
[  169.179102] loop2: detected capacity change from 0 to 20971520
[  169.198307] BTRFS: device fsid 56ad51f1-5523-463b-8547-c19486c51ebb devid 2 transid 17 /dev/loop2 scanned by systemd-udevd (2313)
[  190.696579] BTRFS info (device loop1): flagging fs with big metadata feature
[  190.699445] BTRFS info (device loop1): allowing degraded mounts
[  190.701819] BTRFS info (device loop1): using free space tree
[  190.704126] BTRFS info (device loop1): has skinny extents
[  190.708890] BTRFS info (device loop1):  before clear_missing.00000000f706684d /dev/loop1 0
[  190.711958] BTRFS warning (device loop1): devid 2 uuid 6635ac31-56dd-4852-873b-c60f5e2d53d2 is missing
[  190.715370] BTRFS info (device loop1):  before clear_missing.0000000000000000 /dev/loop2 1
[  209.075744] BTRFS info (device loop1): flagging fs with big metadata feature
[  209.079106] BTRFS info (device loop1): allowing degraded mounts
[  209.082042] BTRFS info (device loop1): using free space tree
[  209.084791] BTRFS info (device loop1): has skinny extents
[  209.089172] BTRFS info (device loop1):  before clear_missing.00000000f706684d /dev/loop1 0
[  209.093074] BTRFS warning (device loop1): devid 2 uuid 6635ac31-56dd-4852-873b-c60f5e2d53d2 is missing
[  209.096848] BTRFS info (device loop1):  before clear_missing.0000000000000000 /dev/loop2 0
[  218.778031] BTRFS info (device loop1): flagging fs with big metadata feature
[  218.781504] BTRFS info (device loop1): allowing degraded mounts
[  218.784319] BTRFS info (device loop1): using free space tree
[  218.786902] BTRFS info (device loop1): has skinny extents
[  218.791190] BTRFS info (device loop1):  before clear_missing.00000000f706684d /dev/loop1 18446744073709551615
[  218.795532] BTRFS warning (device loop1): devid 2 uuid 6635ac31-56dd-4852-873b-c60f5e2d53d2 is missing
[  218.799320] BTRFS info (device loop1):  before clear_missing.0000000000000000 /dev/loop2 18446744073709551615

If fs_devices->missing_devices is 0, next time it would be 18446744073709551615

After apply this patch, the fs_devices->missing_devices seems to be right

[root@zllke test]# truncate -s 10g test1
[root@zllke test]# truncate -s 10g test2
[root@zllke test]# losetup /dev/loop1 test1
[root@zllke test]# losetup /dev/loop2 test2
[root@zllke test]# mkfs.btrfs -draid1 -mraid1 /dev/loop1 /dev/loop2 -f
[root@zllke test]# losetup -d /dev/loop2
[root@zllke test]# mount -o degraded /dev/loop1 /mnt/1
[root@zllke test]# umount /mnt/1
[root@zllke test]# mount -o degraded /dev/loop1 /mnt/1
[root@zllke test]# umount /mnt/1
[root@zllke test]# mount -o degraded /dev/loop1 /mnt/1
[root@zllke test]# umount /mnt/1
[root@zllke test]# dmesg
[   80.647739] loop1: detected capacity change from 0 to 20971520
[   81.268113] loop2: detected capacity change from 0 to 20971520
[   90.694332] BTRFS: device fsid 15aa1203-98d3-4a66-bcae-ca82f629c2cd devid 1 transid 5 /dev/loop1 scanned by mkfs.btrfs (1863)
[   90.705180] BTRFS: device fsid 15aa1203-98d3-4a66-bcae-ca82f629c2cd devid 2 transid 5 /dev/loop2 scanned by mkfs.btrfs (1863)
[  104.935735] BTRFS info (device loop1): flagging fs with big metadata feature
[  104.939020] BTRFS info (device loop1): allowing degraded mounts
[  104.941637] BTRFS info (device loop1): disk space caching is enabled
[  104.944442] BTRFS info (device loop1): has skinny extents
[  104.948848] BTRFS info (device loop1):  before clear_missing.00000000975bd577 /dev/loop1 0
[  104.952365] BTRFS warning (device loop1): devid 2 uuid 8b333791-0b3f-4f57-b449-1c1ab6b51f38 is missing
[  104.956220] BTRFS info (device loop1):  before clear_missing.0000000000000000 /dev/loop2 1
[  104.960602] BTRFS info (device loop1): checking UUID tree
[  157.888711] BTRFS info (device loop1): flagging fs with big metadata feature
[  157.892915] BTRFS info (device loop1): allowing degraded mounts
[  157.896333] BTRFS info (device loop1): disk space caching is enabled
[  157.899244] BTRFS info (device loop1): has skinny extents
[  157.905068] BTRFS info (device loop1):  before clear_missing.00000000975bd577 /dev/loop1 0
[  157.908981] BTRFS warning (device loop1): devid 2 uuid 8b333791-0b3f-4f57-b449-1c1ab6b51f38 is missing
[  157.913540] BTRFS info (device loop1):  before clear_missing.0000000000000000 /dev/loop2 1
[  161.057615] BTRFS info (device loop1): flagging fs with big metadata feature
[  161.060874] BTRFS info (device loop1): allowing degraded mounts
[  161.063422] BTRFS info (device loop1): disk space caching is enabled
[  161.066179] BTRFS info (device loop1): has skinny extents
[  161.069997] BTRFS info (device loop1):  before clear_missing.00000000975bd577 /dev/loop1 0
[  161.073328] BTRFS warning (device loop1): devid 2 uuid 8b333791-0b3f-4f57-b449-1c1ab6b51f38 is missing
[  161.077084] BTRFS info (device loop1):  before clear_missing.0000000000000000 /dev/loop2 1

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/volumes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2ec3b8a..56252cc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1122,8 +1122,10 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	if (device->devid == BTRFS_DEV_REPLACE_DEVID)
 		clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 
-	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
+		clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
 		fs_devices->missing_devices--;
+	}
 
 	btrfs_close_bdev(device);
 	if (device->bdev) {
-- 
1.8.3.1

