Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9F17668D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 23:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCBWDD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 17:03:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42396 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWDD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 17:03:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id f5so367920pfk.9
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GoBo/XiL0oJfu5q6secdI5mX9SvJvSEmQoVYAEx/ewA=;
        b=tNvaOe4m/ROD/dWPf5gZi+qqthrf8fKytAiRAk1xGIdEILqONWeASulz//h7c6c916
         WO00Jy8LafoW8UhltvnVtATgP3tQO0wbezkpxJckD4sAJAQ0vKMowrNGsg13Slou/1tR
         5tbZbbnjDZ5nBrlLTVqi6GClqOYqt3ZTvwxz8NpzNnONFFKtTCnwjIEyu6d4GR5H5C0d
         owpnmVclWK8Rf+QfkPDrzwZLAxOvZe5VlMxIrZSxlKimUAK0mQRZYsCvpHgMakGCBcDd
         80yfa+mGXTvhMPxI5AmSDMFtSX4b9G/6jrU/LKXbJh7MiqykuoOWlFfcB1+sI3k2PcXX
         jhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GoBo/XiL0oJfu5q6secdI5mX9SvJvSEmQoVYAEx/ewA=;
        b=Aw8IZ5kzhl7Y7mp7h9bjqj+PlCHLzqUKaQVXl4c3bb4Ii/VInd/DCQmNeyFIvYCKBj
         3f5i4OW5iZulOW3PMh7Lo+Yc4xqhlpfyI5fy1UaMK7v/azft4ZaE1iKILibB0WW43QWm
         5AqLUHXfPwqnMPi6oX5y7cnzk7ibk+dJpG9Ph5Qlsugml7wqoinDfpht2tmioCUNMTTw
         la3UaM3vHybcBoWBWr10vBgag5tpPIguMn4O5H+3yPT+2DUkfV9fdonlFiKGukfnNire
         rpS5ftAFsz2ubeOFhTnTDRwA2jWFvX8RxpdqKwrsMzDuDHL3g9gM6CB31M/vH6gmujul
         TDhg==
X-Gm-Message-State: ANhLgQ1oQ6V/luuPPMO+XQCogliv/mP64/U0rdFRH3P0IYLWnCcUa6wq
        Y2f6V5r/TMLN1xMXwUVftRVe+kpxMu8=
X-Google-Smtp-Source: ADFU+vsmNV+yN7/Bvfus5WYSAVtgMD6dQfJ7xEliyKDHjKaL5LfksAMNH+SAWtKwU6tsoB96dkmLRw==
X-Received: by 2002:a63:c4e:: with SMTP id 14mr932365pgm.444.1583186581331;
        Mon, 02 Mar 2020 14:03:01 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:500::5:755a])
        by smtp.gmail.com with ESMTPSA id 6sm6216303pfx.32.2020.03.02.14.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:03:00 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH] btrfs: fix RAID direct I/O reads with alternate csums
Date:   Mon,  2 Mar 2020 14:02:49 -0800
Message-Id: <b88c888c800d66ad39b4a561ec6601d2db59529e.1583186403.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_lookup_and_bind_dio_csum() does pointer arithmetic which assumes
32-bit checksums. If using a larger checksum, this leads to spurious
failures when a direct I/O read crosses a stripe. This is easy
to reproduce:

  # mkfs.btrfs -f --checksum BLAKE2b -d raid0 /dev/vdc /dev/vdd
  ...
  # mount /dev/vdc /mnt
  # cd /mnt
  # dd if=/dev/urandom of=foo bs=1M count=1 status=none
  # dd if=foo of=/dev/null bs=1M iflag=direct status=none
  dd: error reading 'foo': Input/output error
  # dmesg | tail -1
  [  135.821568] BTRFS warning (device vdc): csum failed root 5 ino 257 off 421888 ...

Fix it by using the actual checksum size.

Fixes: 1e25a2e3ca0d ("btrfs: don't assume ordered sums to be 4 bytes")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
I wasn't sure what commit to point at for the fixes tag (or whether to
just add a stable tag).

Based on misc-next. xfstest to follow.

Thanks,
Omar

 fs/btrfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dacfd17a3121..8a3bc19d83ff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7840,6 +7840,7 @@ static inline blk_status_t btrfs_lookup_and_bind_dio_csum(struct inode *inode,
 {
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
 	struct btrfs_io_bio *orig_io_bio = btrfs_io_bio(dip->orig_bio);
+	u16 csum_size;
 	blk_status_t ret;
 
 	/*
@@ -7859,7 +7860,8 @@ static inline blk_status_t btrfs_lookup_and_bind_dio_csum(struct inode *inode,
 
 	file_offset -= dip->logical_offset;
 	file_offset >>= inode->i_sb->s_blocksize_bits;
-	io_bio->csum = (u8 *)(((u32 *)orig_io_bio->csum) + file_offset);
+	csum_size = btrfs_super_csum_size(btrfs_sb(inode->i_sb)->super_copy);
+	io_bio->csum = orig_io_bio->csum + csum_size * file_offset;
 
 	return 0;
 }
-- 
2.25.1

