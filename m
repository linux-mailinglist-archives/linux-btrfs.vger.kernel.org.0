Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC54D0A84
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbiCGWFa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbiCGWF1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:05:27 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D7142EF0
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:04:32 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d194so3608303qkg.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VpYKRZKiTa0FLj/PMZXG6QFmlmKny8enBAOVfwxol3w=;
        b=6zwNbUk+FT9SyQBMcdggLPl/AlmSK0Uu2xUN1dPD23MNecxHoR01XGWbj8Wkk05V2f
         qquwgOMcT71GO5DlsCCyrpDqIw5D6alwr+LKyaPABAFUEH2Mx/p0ZYB0OOFY8fGde+AA
         zXI2bD1U0O3U6qJdC5nw1Li6FtZHm8zveCERjQJnsuOCZ+vprqk7JvHj91/OURRiW4Xe
         gq9kP+Rb789zBh/FNrmbpL+JET2ZSzqIjyV8Mwssx8dotMQWVDBS53p8mGqVFVNUdiZC
         mR8lWPUbBzBb7Nt7wH58Z26dF9MQD5i+sxSdiOgemIbzMMLBJy3sRbJCOqsqmV2UncXq
         4U3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpYKRZKiTa0FLj/PMZXG6QFmlmKny8enBAOVfwxol3w=;
        b=Ryd7cW7onQ0D2kgsuvi9nDr7S10S5b/1MsBiSIwJZw5/4+6KOmcqtfR44ovEsAiyRx
         74NiCGvn/57Npn653THk/t1HvcrJK5tMqs58dAzqP7s8Z8wGla8HlWdFnEaMLqzi+tB+
         3vV7nCh69yY3QOQ3WtpyZ4urQGBUJCdfB8jHFcZhDu/6LOQuGFfKP2nFyXG/jb4j01AG
         llCU1RSa9zGqHZhNH5+oBB1ek0+Tt7sqWjuZMZMw+aOT8XTqOXfeuZ1uwc+jqexNWAg/
         1i4utt5br0WBScZ9p0O8VSNIyHm2AOH/bwE1bDASaOdBzBNZgfL588w+BdgUZdiajTiU
         yfuQ==
X-Gm-Message-State: AOAM532jWIHS6HbjYrxVVNK+xg2vfZ1xYGDpj2CqGJ4v8V8+cXXpn8DT
        fF+hXmM5dwMII+yCV/pHYBTF/EPZyAUHZOXb
X-Google-Smtp-Source: ABdhPJyRG4YSJn1L4SrioOghjmtRbAijHn6q4SB6I4+JMu7FsgihePIKmrTNFSNE5/H94OqA6mCY9g==
X-Received: by 2002:a05:620a:450a:b0:67b:286:af6a with SMTP id t10-20020a05620a450a00b0067b0286af6amr7080969qkp.29.1646690671420;
        Mon, 07 Mar 2022 14:04:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v14-20020a05622a014e00b002cf75f5b11esm9449565qtw.64.2022.03.07.14.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:04:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/6] btrfs: don't do backref modification for metadata for extent tree v2
Date:   Mon,  7 Mar 2022 17:04:23 -0500
Message-Id: <ecb9f30aae0ea04e04ce529f484c68c836065f88.1646690556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690555.git.josef@toxicpanda.com>
References: <cover.1646690555.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For extent tree v2 we will no longer track references for metadata in
the extent tree.  Make changes at the alloc and free sides so the proper
accounting is done but skip the extent tree modification parts.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f477035a2ac2..309d8753bf41 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2955,7 +2955,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_extent_item *ei;
 	struct btrfs_extent_inline_ref *iref;
 	int ret;
-	int is_data;
 	int extent_slot = 0;
 	int found_extent = 0;
 	int num_to_del = 1;
@@ -2964,6 +2963,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	u64 bytenr = node->bytenr;
 	u64 num_bytes = node->num_bytes;
 	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
+	bool is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
+
+	if (btrfs_fs_incompat(info, EXTENT_TREE_V2) && !is_data)
+		return do_free_extent_accounting(trans, bytenr, num_bytes,
+						 is_data);
 
 	extent_root = btrfs_extent_root(info, bytenr);
 	ASSERT(extent_root);
@@ -2972,8 +2976,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
-
 	if (!is_data && refs_to_drop != 1) {
 		btrfs_crit(info,
 "invalid refs_to_drop, dropping more than 1 refs for tree block %llu refs_to_drop %u",
@@ -4703,6 +4705,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	u64 flags = extent_op->flags_to_set;
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		goto out;
+
 	ref = btrfs_delayed_node_to_tree_ref(node);
 
 	extent_key.objectid = node->bytenr;
@@ -4756,7 +4761,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
-
+out:
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
 
-- 
2.26.3

