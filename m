Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278BB7AB04B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjIVLOE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjIVLOA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:14:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97FFB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:13:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A037C21A56;
        Fri, 22 Sep 2023 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTVlFOxoGyy/2m2d0o8c/Cwf+n1PYPdkU23UTxfXqG8=;
        b=dk/pj7RaIIJkCS9X1ATMymreFlfgnSyrgYY516r2XjAw4uC3de7gLKUcrmdk4A/fNKLHbr
        NbAY9FjQYFFEgVPUAKLrW0w1RGjLlRwb+VQafjvsfW+WHOOL/xzE3A5YUHIsDmCKRGDNWw
        7aTc6Vhu2rOzwxGIO01Jn59Ra+XAnt4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 85EDE2C142;
        Fri, 22 Sep 2023 11:13:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9A14DA832; Fri, 22 Sep 2023 13:07:18 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/8] btrfs: relocation: switch bitfields to bool in reloc_control
Date:   Fri, 22 Sep 2023 13:07:18 +0200
Message-ID: <28dd578b57ecb9270fe60b2170b4cac5c1ad77bf.1695380646.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695380646.git.dsterba@suse.com>
References: <cover.1695380646.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use bool types for the indicators instead of bitfields. The structure
size slightly grows but the new types are placed within the padding.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3afe499f00b1..87ac8528032c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -163,9 +163,9 @@ struct reloc_control {
 	u64 extents_found;
 
 	enum reloc_stage stage;
-	unsigned int create_reloc_tree:1;
-	unsigned int merge_reloc_tree:1;
-	unsigned int found_file_extent:1;
+	bool create_reloc_tree;
+	bool merge_reloc_tree;
+	bool found_file_extent;
 };
 
 static void mark_block_processed(struct reloc_control *rc,
@@ -1902,7 +1902,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		}
 	}
 
-	rc->merge_reloc_tree = 1;
+	rc->merge_reloc_tree = true;
 
 	while (!list_empty(&rc->reloc_roots)) {
 		reloc_root = list_entry(rc->reloc_roots.next,
@@ -3659,7 +3659,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 	if (ret)
 		return ret;
 
-	rc->create_reloc_tree = 1;
+	rc->create_reloc_tree = true;
 	set_reloc_control(rc);
 
 	trans = btrfs_join_transaction(rc->extent_root);
@@ -3786,7 +3786,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 		if (rc->stage == MOVE_DATA_EXTENTS &&
 		    (flags & BTRFS_EXTENT_FLAG_DATA)) {
-			rc->found_file_extent = 1;
+			rc->found_file_extent = true;
 			ret = relocate_data_extent(rc->data_inode,
 						   &key, &rc->cluster);
 			if (ret < 0) {
@@ -3823,7 +3823,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			err = ret;
 	}
 
-	rc->create_reloc_tree = 0;
+	rc->create_reloc_tree = false;
 	set_reloc_control(rc);
 
 	btrfs_backref_release_cache(&rc->backref_cache);
@@ -3841,7 +3841,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 	merge_reloc_roots(rc);
 
-	rc->merge_reloc_tree = 0;
+	rc->merge_reloc_tree = false;
 	unset_reloc_control(rc);
 	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);
 
@@ -4355,7 +4355,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		goto out_unset;
 	}
 
-	rc->merge_reloc_tree = 1;
+	rc->merge_reloc_tree = true;
 
 	while (!list_empty(&reloc_roots)) {
 		reloc_root = list_entry(reloc_roots.next,
-- 
2.41.0

