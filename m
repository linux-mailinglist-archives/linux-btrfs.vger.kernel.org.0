Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE03F51E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhHWUPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhHWUPw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:52 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66451C061757
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:09 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dt3so10429027qvb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YGYGP5RQD+adbEB++MiprG5RWu+nlbYewivpOwHIuYI=;
        b=UgshwOXnD3ZC8THeXBgByu3GIzBA8vh3WhSemIFjZXeHWJuL5XYV4gJuNu76j5kZda
         TQugV++auYZImsPTBplD2t0uN0Ep7wqHwhcy2Gjuy7u0WeqNMS6WRJoXJmdJRIqhfxH4
         PXjNPQ/mVHZxtWTY9Zb9jfvLhc795/9a0D//JWorFHOC5srFpg4unaLR8radSIc616bO
         tZWYvopA0IIGSyGuGR0S+Z/tajuB2jjFnWpsE95UmekFxHEzTAPiPwfpkHq5m4FqXP/U
         cZcq5q8oMNy9ly020VQFan1fhxnFO274r7cJwPcOaxWtkKGXBbFAOL448IFjYSvpo3sK
         mTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGYGP5RQD+adbEB++MiprG5RWu+nlbYewivpOwHIuYI=;
        b=OQAk2QEMoYr0TpYuiM4uWe6Gx9YyvW7fb8Y6HAW2kQVRJEzyJT7QWusQqhBt5nt2Kv
         +UpwOKUg5nEdAYbdHQoO7hT6/xlfw1tB0THYFrWPv+doF0cGQQBasEcdrfkXy7loW8X0
         EcYJIcl7gXmpQ5ckt4s+8wTo7xV9z9VRCFvoOR7m+5YlG7e194rG+ckMopeRtLcSpL7y
         Md9DeiddgUdipzmtVDpK3X3i3NBZpxDFZdgmv75NNE9tHRI1nLy+qzScubREk71Mphi4
         V/81a/Th3PyHsWNoe7v9MKavsvUSbGE9SodWeVwVsWQiu8j89Ki2cNaNgVapBcr2wt9q
         sueA==
X-Gm-Message-State: AOAM533zry3S7xdFfgYpmXZlRty0clvRy+gmbohKqkLMgWW0hFtmKuVT
        hgwtLLGuzSzj2AinDGsqEmXmbeS/0aaCNg==
X-Google-Smtp-Source: ABdhPJwKbrufqjW4NoLOqrPzY2eRQvKhVZdYpsFp6u+btfBM2Rc7neiaULdwuUZdLE/6X+8MKWT9xg==
X-Received: by 2002:a05:6214:2408:: with SMTP id fv8mr35317961qvb.4.1629749708205;
        Mon, 23 Aug 2021 13:15:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x25sm7242181qtj.77.2021.08.23.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:15:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/10] btrfs-progs: mkfs: add the block group item in make_btrfs()
Date:   Mon, 23 Aug 2021 16:14:52 -0400
Message-Id: <291a31ef4666c1f3b7fb265ec8dcecdd10943722.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we build a bare-bones file system in make_btrfs(), and then we
load it up and fill in the rest of the file system after the fact.  One
thing we omit in make_btrfs() is the block group item for the temporary
system chunk we allocate, because we just add it after we've opened the
file system.

However I want to be able to generate the free space tree at
make_btrfs() time, because extent tree v2 will not have an extent tree
that has every block allocated in the system.  In order to do this I
need to make sure that the free space tree entries are added on block
group creation, which is annoying if we have to add this chunk after
I've created a free space tree.

So make future work simpler by simply adding our block group item at
make_btrfs() time, this way I can do the right things with the free
space tree in the generic make block group code without needing a
special case for our temporary system chunk.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 31 +++++++++++++++++++++++++++++++
 mkfs/main.c   |  9 ++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index a392a5b0..9b5f96e3 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -188,6 +188,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u64 num_bytes;
 	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
 	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	bool add_block_group = true;
 
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
 		system_group_offset = cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
@@ -276,6 +277,36 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
 
+		/* Add the block group item for our temporary chunk. */
+		if (cfg->blocks[blk] > system_group_offset &&
+		    add_block_group) {
+			struct btrfs_block_group_item *bg_item;
+
+			add_block_group = false;
+
+			itemoff -= sizeof(*bg_item);
+			btrfs_set_disk_key_objectid(&disk_key,
+						    system_group_offset);
+			btrfs_set_disk_key_offset(&disk_key,
+						  system_group_size);
+			btrfs_set_disk_key_type(&disk_key,
+						BTRFS_BLOCK_GROUP_ITEM_KEY);
+			btrfs_set_item_key(buf, &disk_key, nritems);
+			btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
+					      itemoff);
+			btrfs_set_item_size(buf, btrfs_item_nr(nritems),
+					    sizeof(*bg_item));
+
+			bg_item = btrfs_item_ptr(buf, nritems,
+						 struct btrfs_block_group_item);
+			btrfs_set_block_group_used(buf, bg_item, total_used);
+			btrfs_set_block_group_flags(buf, bg_item,
+						    BTRFS_BLOCK_GROUP_SYSTEM);
+			btrfs_set_block_group_chunk_objectid(buf, bg_item,
+					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+			nritems++;
+		}
+
 		item_size = sizeof(struct btrfs_extent_item);
 		if (!skinny_metadata)
 			item_size += sizeof(struct btrfs_tree_block_info);
diff --git a/mkfs/main.c b/mkfs/main.c
index eab93eb3..ea53e9c7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -67,7 +67,6 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	struct btrfs_trans_handle *trans;
 	struct btrfs_space_info *sinfo;
 	u64 flags = BTRFS_BLOCK_GROUP_METADATA;
-	u64 bytes_used;
 	u64 chunk_start = 0;
 	u64 chunk_size = 0;
 	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
@@ -90,16 +89,12 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 
 	trans = btrfs_start_transaction(root, 1);
 	BUG_ON(IS_ERR(trans));
-	bytes_used = btrfs_super_bytes_used(fs_info->super_copy);
 
 	root->fs_info->system_allocs = 1;
 	/*
-	 * First temporary system chunk must match the chunk layout
-	 * created in make_btrfs().
+	 * We already created the block group item for our temporary system
+	 * chunk in make_btrfs(), so account for the size here.
 	 */
-	ret = btrfs_make_block_group(trans, fs_info, bytes_used,
-				     BTRFS_BLOCK_GROUP_SYSTEM,
-				     system_group_offset, system_group_size);
 	allocation->system += system_group_size;
 	if (ret)
 		return ret;
-- 
2.26.3

