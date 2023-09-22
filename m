Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C637AB049
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjIVLOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjIVLN7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:13:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE47AF
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:13:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7F46E21879;
        Fri, 22 Sep 2023 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FN+JscVgHn+GC++sOHK/tLagAogHMh6Or360f115JEU=;
        b=PTK68TjAINaurwYRCXtEfjElifV05qRiAiGDlOj0QKTg351zYaL85+9GbvDRLlOIpVQJRD
        KW2WvZphJJ5xN/eHR1bwEjomEjDglic4Yp0LSJjpyJ7ou83YAgo9iqSPhtQeRYN+1gJbl7
        Ve9c+W0F8LVVxlRhAyww802GLGpo2S0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 648812C149;
        Fri, 22 Sep 2023 11:13:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96EA4DA832; Fri, 22 Sep 2023 13:07:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/8] btrfs: relocation: use enum for stages
Date:   Fri, 22 Sep 2023 13:07:16 +0200
Message-ID: <e20220675e8d2501f4b98bae12a105615abe634b.1695380646.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695380646.git.dsterba@suse.com>
References: <cover.1695380646.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an enum type for data relocation stages.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9ff3572a8451..3afe499f00b1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -125,6 +125,12 @@ struct file_extent_cluster {
 	u64 owning_root;
 };
 
+/* Stages of data relocation. */
+enum reloc_stage {
+	MOVE_DATA_EXTENTS,
+	UPDATE_DATA_PTRS
+};
+
 struct reloc_control {
 	/* block group to relocate */
 	struct btrfs_block_group *block_group;
@@ -156,16 +162,12 @@ struct reloc_control {
 	u64 search_start;
 	u64 extents_found;
 
-	unsigned int stage:8;
+	enum reloc_stage stage;
 	unsigned int create_reloc_tree:1;
 	unsigned int merge_reloc_tree:1;
 	unsigned int found_file_extent:1;
 };
 
-/* stages of data relocation */
-#define MOVE_DATA_EXTENTS	0
-#define UPDATE_DATA_PTRS	1
-
 static void mark_block_processed(struct reloc_control *rc,
 				 struct btrfs_backref_node *node)
 {
@@ -4054,7 +4056,7 @@ static void describe_relocation(struct btrfs_fs_info *fs_info,
 		   block_group->start, buf);
 }
 
-static const char *stage_to_string(int stage)
+static const char *stage_to_string(enum reloc_stage stage)
 {
 	if (stage == MOVE_DATA_EXTENTS)
 		return "move data extents";
@@ -4170,7 +4172,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	WARN_ON(ret && ret != -EAGAIN);
 
 	while (1) {
-		int finishes_stage;
+		enum reloc_stage finishes_stage;
 
 		mutex_lock(&fs_info->cleaner_mutex);
 		ret = relocate_block_group(rc);
-- 
2.41.0

