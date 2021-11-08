Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23D449C6B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhKHT3n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhKHT3m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:42 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636AC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:26:57 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id p19so538170qtw.12
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAV+J+0O1cpV0vx7cSMHrMECAGe2QGBaiCpMb7PeMXs=;
        b=1VA9tCEsurG57s4fmlmlnfE4hy67GfHIvJmLzS5OZOoA/UInq3xHa+qDPvVqjKxQLx
         lsToPqhmNcOYVSgEYPpXQbLzfTdSiiYOsTb6OIzUnT97fnc5X+13HMj7Un/agzsMORvG
         dr/I1e6PvcxPtsgXyh51tqJXyjIif1c0jqF5kEABCr7/LkKjKnVTv0zIHjG3cpn57/+m
         27h9Zsvp82bSHoJAok3XNZrnzQRuo4nF/v81jSY22+ep4tLfR/erAoJmbenlEFU0E1uc
         FY27/XgAoOIrKxV0x9ikq/9DNBsLvZzY9jfD6rZGdRBqY3d/y2AfzQjj/OIrZK1LtR/R
         UqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAV+J+0O1cpV0vx7cSMHrMECAGe2QGBaiCpMb7PeMXs=;
        b=oqwwlvFedDKistgTOsTOyEDNw+/6xICB5YbymiVCZKXscIVAnqOpce+QdqRelEjBcz
         MUcrRp3SUvdRuvTpEFFX42k8cDPiAVltHLcSxC1QZC2hUwv7gp9Z3GEEnKOOHJPg1hJ9
         pIrZy5ZEqdfMsxTmkXZ5mek26oeAjXm2+vxCCf7x4m8JmfaRML1JhOCAJXrRn2T31oiJ
         zrwCkqQr8lIgbAfy8XmerTB4cYXFv8ZG6yxb15lqa1yTnt0j4U896hApg/SDEXYqHH8k
         Dj4kxsI7oWlQJasbsLPcUzQFFAFaCzzsSlzLFOenXVlXJptXbrEZlEO0ruHW4NuWZBAs
         b9zw==
X-Gm-Message-State: AOAM532Nx8SmhFgIZyWCLM0iuDesuRiWZUwwwYX0FOXWRO0NwW0qhuUu
        taKybSOcq9tDqawEpa+aGy6AZk4jT7Nghw==
X-Google-Smtp-Source: ABdhPJz93gxN12J9amxBp4H2HpAnJ2z458EmtMdkHdLFeyOC6h51l1mXtI92Cljq2M9TODreo2NO1g==
X-Received: by 2002:ac8:58d2:: with SMTP id u18mr2147604qta.262.1636399616846;
        Mon, 08 Nov 2021 11:26:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 6sm11359540qtz.48.2021.11.08.11.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:26:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 05/20] btrfs-progs: btrfs-shared: stop passing root to csum related functions
Date:   Mon,  8 Nov 2021 14:26:33 -0500
Message-Id: <c5198de638b7933ef967a401c1356793e4529c07.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
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

