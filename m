Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ACB4469AF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhKEUbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhKEUbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:36 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284DC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:28:55 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id u16so8046919qvk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uDUd9Djc18/EZmjFf2IWDQX1z3kaklI7M8l12xYdp4c=;
        b=SHfepNGii35MlaydK1iFjpYD/pAatPypvs+j1ex6aHke4sJv3veENp9bCAkQG4r3Sm
         vxbMPoReQbrHfOQKouZi6EPh8VyXNyfj831l/pXW6VTqZ3hIO1P58nuE1gJk6Iueh6GA
         3FO0pcDPVe7AtyH9+KsYaRm7qEL7gr3RNYKU9LiERZZ2OlbyTxCbxpvbhDwaHQq4hHuN
         CifT1W34aBI0cdaDYDDlzbZMQ9vcF+Pgpz2M3vlXsI2mAUR5c9ov847gbQv06Ck6M8eL
         PzEtlmn8/GlGkh+uiG4PBW5Qy78hXTh7mb5KFlE/JTLh05Laou1/ckBuieOCK3bSr67i
         1yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDUd9Djc18/EZmjFf2IWDQX1z3kaklI7M8l12xYdp4c=;
        b=tzOAcOAJQ+AWCbGfK7Neg/zGAQaHDp3XWZPs1XgTUKlnWihp5TbggiRGJUtC8ifYlD
         rjhqMMj9NZN+70wPAKM3COuglfgh7/qHZbJPiNjHumM4nhJBTiLnm82KAQKiYUrgjaiu
         EveBFPT5QpeJRd5E4OUXzXr9FvhQdCZub7zq6QigQl/EgcaUdnk7PqYhS6BtHUxk/8DR
         4ambzrbJgZ0NwXC4d29R1HENmrSTJX5/CipVZHMHvUamkrDq2+3DYq3oJXB/Mx6ZRlv2
         IeKejvr3jjvYlWDwVz9gttbinzhIviKWm+y08kwlh79r6ftl/U9FxhBDFx121lOr4UhW
         Vgfg==
X-Gm-Message-State: AOAM531pRXYnM3C0Wjtr1t6G2H1lDphZX7D16nqqj3Y3YYfwehUeiI7F
        f0IiKWCCRIruO5foYB6XS9FNyAkyEKSPZA==
X-Google-Smtp-Source: ABdhPJw+VcAqibaF0ac1M64w5bKBT8wy7Pb0cbTunCxJVE9p71fQgGngOvfSysUOhB30VjbgSlk6XQ==
X-Received: by 2002:a05:6214:906:: with SMTP id dj6mr1415900qvb.11.1636144134689;
        Fri, 05 Nov 2021 13:28:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l15sm6666778qtk.41.2021.11.05.13.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/20] btrfs-progs: btrfs-shared: stop passing root to csum related functions
Date:   Fri,  5 Nov 2021 16:28:30 -0400
Message-Id: <3eb2d14594f36893b7bd4ea28b38b00548f4aca3.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
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

