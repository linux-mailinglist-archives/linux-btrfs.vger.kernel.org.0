Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB444CA24
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhKJULH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJULG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:06 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E848C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:18 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id gu12so2621881qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAV+J+0O1cpV0vx7cSMHrMECAGe2QGBaiCpMb7PeMXs=;
        b=cmFi9R+TT3eqMV4IBASAt+AwCDIs1Vs9YSagY4KePbllyNV2PHuGKNnaqsKcEVoku6
         +CYWuyLcPKi4zoxH82R5W4P90RR2zIYCGNpgYQBwmCnRriv5phNooun8CRjsqz5oZsjE
         HF9Z2GI0xbCKrZYsP5oH9l+Cf1SmbOLMLUGdj8Tp+RFImQ23YthSJFsDQtKkNNkGXIvM
         8Vnpw/MtuKLLYjFYBEdBwJAOFt2BxsU52av2SooA2MOWwL+9mYe7vui/Kg+dMu+RtUqj
         9mOOdmIPSIzrUIHblBtAxrTskUZX0TN+iXH/tz3OGIAyFRN65tTK2NpsEPRkaIWuWMwD
         AGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAV+J+0O1cpV0vx7cSMHrMECAGe2QGBaiCpMb7PeMXs=;
        b=j6jiszp1xA6mbqEgErYoTBl7nbQOnzMnVhF1RatpXLR+I8yIz3PlwXrKCWozkTWadb
         bc6USJX+/tOEiAAMHI86I+M9NXjdO+nA9j0HXfTrLj3QIqsvkRgGnjapOvNWpHLei2kU
         BjcK3QKxgJE7/NFNeeFYHMZ/+ebFOcMvhCcBLpCXIcH6EfKP0eAHd/1MDMi+A6PV3c1c
         EhfGFm6xHuZOEgwfYTjkvWKHr3DMpmlkaMi9uGT6ptZxN9GB6Q7N5SQA4XeolPoPb0sS
         ao4VpOtRv12P3ckulX2r4iI3gNjw7iriOsfoIERfpuEEQ7yhHUjvjQkk2o5Nuy0/Ckkm
         mLJw==
X-Gm-Message-State: AOAM533k1Z3NUdaQTf/3IscEHIjY4O4YQZNnRk5A6ym0PjlKTdoF/uOe
        tR4uCis4WEZ0jeag/PRWTEBcapLSlChgvg==
X-Google-Smtp-Source: ABdhPJx4t5KfXkuWQz04LeXOiJNBT8UypeKHD+39q2FnYuENLoEGtPIZH6tzwgWsMLjR8flc8KK5cA==
X-Received: by 2002:a0c:80e4:: with SMTP id 91mr1443854qvb.57.1636574895945;
        Wed, 10 Nov 2021 12:08:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a15sm500618qtb.85.2021.11.10.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 06/13] btrfs-progs: btrfs-shared: stop passing root to csum related functions
Date:   Wed, 10 Nov 2021 15:07:57 -0500
Message-Id: <86c147156b8146901f032d2862bf5dab3c32eaa0.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to need to start looking up the csum root based on the
bytenr with extent tree v2.  To that end stop passing the root to the
csum related functions so that can be done in the helper functions
themselves.

There's an unrelated deletion of a function prototype that no longer
exists, if desired I can break that out from this patch.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c              | 4 ++--
 convert/main.c            | 1 -
 kernel-shared/ctree.h     | 6 +-----
 kernel-shared/file-item.c | 4 ++--
 mkfs/rootdir.c            | 2 +-
 5 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/check/main.c b/check/main.c
index 235a9bab..08810c5f 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9484,8 +9484,8 @@ static int populate_csum(struct btrfs_trans_handle *trans,
 				       &sectorsize, 0);
 		if (ret)
 			break;
-		ret = btrfs_csum_file_block(trans, csum_root, start + len,
-					    start + offset, buf, sectorsize);
+		ret = btrfs_csum_file_block(trans, start + len, start + offset,
+					    buf, sectorsize);
 		if (ret)
 			break;
 		offset += sectorsize;
diff --git a/convert/main.c b/convert/main.c
index 223eebad..7f33d4e1 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -187,7 +187,6 @@ static int csum_disk_extent(struct btrfs_trans_handle *trans,
 		if (ret)
 			break;
 		ret = btrfs_csum_file_block(trans,
-					    root->fs_info->csum_root,
 					    disk_bytenr + num_bytes,
 					    disk_bytenr + offset,
 					    buffer, blocksize);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3c0743cc..73904255 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2847,12 +2847,8 @@ int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root, u64 objectid,
 				u64 offset, const char *buffer, size_t size);
-int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root, u64 alloc_end,
+int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 alloc_end,
 			  u64 bytenr, char *data, size_t len);
-int btrfs_csum_truncate(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root, struct btrfs_path *path,
-			u64 isize);
 
 /* uuid-tree.c, interface for mounted mounted filesystem */
 int btrfs_lookup_uuid_subvol_item(int fd, const u8 *uuid, u64 *subvol_id);
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index c910e27e..5bf6aab4 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -183,9 +183,9 @@ fail:
 }
 
 int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root, u64 alloc_end,
-			  u64 bytenr, char *data, size_t len)
+			  u64 alloc_end, u64 bytenr, char *data, size_t len)
 {
+	struct btrfs_root *root = trans->fs_info->csum_root;
 	int ret = 0;
 	struct btrfs_key file_key;
 	struct btrfs_key found_key;
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 16ff257a..92be32ea 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -403,7 +403,7 @@ again:
 		 * we're doing the csum before we record the extent, but
 		 * that's ok
 		 */
-		ret = btrfs_csum_file_block(trans, root->fs_info->csum_root,
+		ret = btrfs_csum_file_block(trans,
 				first_block + bytes_read + sectorsize,
 				first_block + bytes_read,
 				eb->data, sectorsize);
-- 
2.26.3

