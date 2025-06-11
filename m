Return-Path: <linux-btrfs+bounces-14598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD0AD50C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D893A7C8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEF5262FFD;
	Wed, 11 Jun 2025 10:03:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EB26280F
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636201; cv=none; b=scS2lr8EbYQ+zh6GsQBLvZUeftbz5KMxMk4yQW8hvdyJjVqwVMowaGEeCbGQlSeiSzfeFDs04RD+tFJi0pD92ELKUaCXExqlX5pgIFDSmXqBz1OMwjfi/tQRiAj7egJMl1MMPD7KYS5S2RTzxhSclznKuy0+bdHzWX2Y7rkcdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636201; c=relaxed/simple;
	bh=NlOOao6x5oHzbQZUKMFupO3E+QEEttYo6ITQQKfVmd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEJoH+vmibNuApFP3PN/IWhgFiOnb1jQ7P9V4DMqGC4WKhmo3fyOFAkS6Kh+NeTPSAKBt6NMu4v8iokSZhSnJVcvA19KHCYti3xQAjwP6wrqHX6NopdQ0JpwM2XBwPbCBtswNp7qoKw/MhSriFR0FZHIeefQ+wMoCrsPemdZOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a510432236so5060937f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 03:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636198; x=1750240998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o6mYgYM0reNoVieo1JoNCUCX5oT/WNVv4iRRoQhq20=;
        b=FQsxSgnbuIXUBxWxLjQ/KPY4A13AzakipPSGszokdR4xMt1ZtCcqXS72dPii/Tn3DF
         NwVi+8WBCyz4gUfm2/92fI9M+1BIdzCDNVhb3wMdnyYgCwn2z2/aNfeu5P7MQzdbgGv9
         G0vxP+AQEvI7jWmDz2fIHtO5S1jTgR+6tooiLs3NwUHOrt5NgdE8uCpRCsJLQSwKoKDu
         OvbiuiHmDQ+CiipUkIqCEah4vxL7KVs1DfADZbCr/Vb9iCfPSldjyniFdDNbBKPJt5oW
         FW6pCqzaAsdFPYXws40nALa/8vDiIQfwJ7qTzek/1gr/XyWgCNkCRSxuD2ro+U3v642J
         WXtQ==
X-Gm-Message-State: AOJu0YwnSnjJHjyVkQmTStqM2QWRJnkp/U/2N0Z7k7maTKQWHZFtG87S
	JYu1dnFOcd0tSa84gHixyO0unkLoc4DB1CAvTWkS19B2dgg4yygDeXhAW8cYcg==
X-Gm-Gg: ASbGncsJnV/G5DtjWhfDAmtHemNXbm5AkpV+bgBG+xCLS5cTsBDybSXZkoR+j0ZSF90
	luiICdx+zH3UXW5kKHxwutI3PrQy6BK063Oyj687G3abMgJcZPgftV1H6ItRSJMhUTn7O5mh0p/
	TSSTiUJVmBDjSZmVcyBv/3CchJ0hPX3P3dcN2CgiJDrTXXrHPAfvfruPzUlgfNIUUxwiuvgnrwU
	J3z7gAYL4mQSbpZXih/BQ2VgCKBWGVsf4NI1qBrESgHZUK2+J9v6LjsSlJ/Zg7URbTK1Tn8DFfG
	LMjO6fX7H/fpHP7dYnsLGydv00u1xZzN0F/V6pG++mXt83xO0Xe7Qs9Cof4ipm/hDaZInIFaXUW
	Sa8O0+YBW2iZJ7U7zWyZHR9J3LignsycP38wLic2o+GOlSR/N9g==
X-Google-Smtp-Source: AGHT+IHp4HDVRVgZhtjDeo7/Oq0niHJRcEMm7eFPJhX5oyW8G3hq+aB7UHDIL/yoszd4FU3DXIJKdg==
X-Received: by 2002:a5d:64c8:0:b0:3a4:e740:cd72 with SMTP id ffacd0b85a97d-3a5586c9bc7mr1959128f8f.13.1749636197421;
        Wed, 11 Jun 2025 03:03:17 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f02asm14654274f8f.83.2025.06.11.03.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:03:16 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/5] btrfs: always open the device read-only in btrfs_scan_one_device
Date: Wed, 11 Jun 2025 12:02:59 +0200
Message-ID: <20250611100303.110311-2-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100303.110311-1-jth@kernel.org>
References: <20250611100303.110311-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

btrfs_scan_one_device opens the block device only to read the super
block.  Instead of passing a blk_mode_t argument to sometimes open
it for writing, just hard code BLK_OPEN_READ as it will never write
to the device or hand the block_device out to someone else.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c   | 9 ++++-----
 fs/btrfs/volumes.c | 4 ++--
 fs/btrfs/volumes.h | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2d0d8c6e77b4..b9e08a59da4e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -364,10 +364,9 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_device: {
 		struct btrfs_device *device;
-		blk_mode_t mode = btrfs_open_mode(fc);
 
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(param->string, mode, false);
+		device = btrfs_scan_one_device(param->string, false);
 		mutex_unlock(&uuid_mutex);
 		if (IS_ERR(device))
 			return PTR_ERR(device);
@@ -1855,7 +1854,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	 * With 'true' passed to btrfs_scan_one_device() (mount time) we expect
 	 * either a valid device or an error.
 	 */
-	device = btrfs_scan_one_device(fc->source, mode, true);
+	device = btrfs_scan_one_device(fc->source, true);
 	ASSERT(device != NULL);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
@@ -2233,7 +2232,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		 * Scanning outside of mount can return NULL which would turn
 		 * into 0 error code.
 		 */
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		device = btrfs_scan_one_device(vol->name, false);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2251,7 +2250,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		 * Scanning outside of mount can return NULL which would turn
 		 * into 0 error code.
 		 */
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		device = btrfs_scan_one_device(vol->name, false);
 		if (IS_ERR_OR_NULL(device)) {
 			mutex_unlock(&uuid_mutex);
 			if (IS_ERR(device))
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1535a425e8f9..1ebfc69012a2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1440,7 +1440,7 @@ static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
  * the device or return an error. Multi-device and seeding devices are registered
  * in both cases.
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   bool mount_arg_dev)
 {
 	struct btrfs_super_block *disk_super;
@@ -1461,7 +1461,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev_file = bdev_file_open_by_path(path, flags, NULL, NULL);
+	bdev_file = bdev_file_open_by_path(path, BLK_OPEN_READ, NULL, NULL);
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6d8b1f38e3ee..afa71d315c46 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -719,7 +719,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   bool mount_arg_dev);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
-- 
2.49.0


