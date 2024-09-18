Return-Path: <linux-btrfs+bounces-8111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A097BDB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD2D1F2264B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1318BC31;
	Wed, 18 Sep 2024 14:09:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B2189914
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668548; cv=none; b=KdIhC77zJ8vXjPM159wLlevYQxIi6HpZP09EAnnlJIcduLDTNlmdbtygDmMSMkIJBlOkEfnJyEoJ8EfDIu7bP9gMuCYzCTBHEbNXXxOkoFLWuvFj1zql1U8ByFMpomWV8SgTTGNwou/LsscMuEKf8nWZ4qTR2Zfh6UwzYY3usT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668548; c=relaxed/simple;
	bh=0WNv+65dOiIOviCNJzCuUggZHu9ojjNYgMRaqHgQw+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsBaDKk8vYs+AmvLrT9eID1aB4nmQMOf9FH7uVQXyisglviDiw7l5Nzu8W66xkkwbxoTZEMxGuVVICEyIaeHtCByowd5yalG/onLUt0cLok0yiD4eCjDWm/VxS1/xmnBeS2xheR44e4SPlrZEvxIo5KhqfS6GXoSKhMrMtZaumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso53847625e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 07:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726668545; x=1727273345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbwsKGHs5K9UGuhFgwWUG6p1ChJGXLMF8cq52ZvMgp4=;
        b=Zo7O1hAaUlfYY4BijiqJptNt4BVPTQ1u+UTgbAAv+cTxi4GTiWfivO7H/rhVvr66TK
         aEZegWuyYQkOeSpcMqt7EdNUIJ0WTMYLStgAM1sM+Kl5PvemSlub28aw2odPSYBOt+N3
         +xwuVO8l1XxUCpAP1oUG7AouqkkkMDaLcws05R1/rPR6ZL+RxrIlBnUZqPUexG5hhwcC
         oEjzeLtCiCdzBEFhPWcXZYCjmfPBVKeca2EyMgWXHm6byFqeTOBXOUF17rqSh/vFxWHE
         J3hBhbx4vN1k4HkcJFC4KE8lyFeCg9EnDSIwPrOzWGYgbG7BeaWuqKPMxnKd57AMXXRS
         1pCg==
X-Gm-Message-State: AOJu0YxJrHJzguuaU5SvAm+x/Evy9ZfWR2M8amh/yJAEllUALlLvC04V
	34UzUip2DbZdYNX0DBKwljd+4dU62olwY3DDY2Qd7L1j9PL7fgyE
X-Google-Smtp-Source: AGHT+IGmBoZI8Tz/fI+S5Uo4E2Ubbhgzr6CEdUj0Ntjgr6nLblefzSENEAc+SOsvSo2PYaO95ATwlw==
X-Received: by 2002:a05:600c:1c27:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-42cdb572754mr153206865e9.33.1726668545049;
        Wed, 18 Sep 2024 07:09:05 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f72a2100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72a:2100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704f2698sm18282125e9.24.2024.09.18.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:09:04 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC 2/2] btrfs: insert dummy RAID stripe extents for preallocated data
Date: Wed, 18 Sep 2024 16:08:50 +0200
Message-ID: <20240918140850.27261-3-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918140850.27261-1-jth@kernel.org>
References: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
 <20240918140850.27261-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Preallocated extents are not backed by a RAID stripe-tree entry (in
case the filesystem is using the RAID stripe-tree), because there is
no real logical to physical mapping needed for them.

But for instance scrub is performing RAID stripe-tree lookups for all
extents in the extent-tree, even for preallocated ones, so
the stripe-tree lookup code will return -ENOENT for them. This is
causing scrub to mark these extents as I/O errors.

To solve this issue, add a dummy RAID stripe-tree entry for these
extents, so the block mapping performed for scrub operations doesn't fail.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c            | 47 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.c |  4 ++++
 2 files changed, 51 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index edac499fd83d..a8e119809670 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -71,6 +71,7 @@
 #include "backref.h"
 #include "raid-stripe-tree.h"
 #include "fiemap.h"
+#include "volumes.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -8679,6 +8680,44 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
+static int insert_prealloc_rst_entry(struct btrfs_fs_info *fs_info,
+				     struct btrfs_trans_handle *trans_in,
+				     u64 start, u64 len)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_chunk_map *map;
+	u64 map_type;
+	int ret;
+
+	if (!btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE))
+		return 0;
+
+	if (trans_in)
+		trans = trans_in;
+	else
+		trans = btrfs_join_transaction(fs_info->stripe_root);
+
+	map = btrfs_find_chunk_map(fs_info, start, len);
+	if (!map)
+		return -ENOENT;
+
+	map_type = map->type;
+	btrfs_free_chunk_map(map);
+
+	if (!btrfs_need_stripe_tree_update(fs_info, map_type))
+		return 0;
+	ret = btrfs_insert_dummy_raid_extent(trans, start, len);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	if (trans != trans_in)
+		btrfs_end_transaction(trans);
+
+	return 0;
+}
+
 static struct btrfs_trans_handle *insert_prealloc_file_extent(
 				       struct btrfs_trans_handle *trans_in,
 				       struct btrfs_inode *inode,
@@ -8817,6 +8856,14 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			break;
 		}
 
+		ret = insert_prealloc_rst_entry(fs_info, trans, ins.objectid,
+						cur_offset);
+		if (ret) {
+			btrfs_free_reserved_extent(fs_info, ins.objectid,
+						   ins.offset, 0);
+			break;
+		}
+
 		em = alloc_extent_map();
 		if (!em) {
 			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index bbe0689b1d17..f559ea14976f 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -61,6 +61,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		trace_btrfs_raid_extent_delete(fs_info, start, end,
 					       found_start, found_end);
 
+		if (key.type == BTRFS_RAID_STRIPE_DUMMY_KEY)
+			goto delete;
+
 		if (found_start < start) {
 			struct btrfs_key prev;
 			u64 diff = start - found_start;
@@ -112,6 +115,7 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 			break;
 		}
 
+delete:
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;
-- 
2.43.0


