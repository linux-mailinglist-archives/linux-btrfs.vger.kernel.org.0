Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0703B7B778E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 07:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjJDF4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 01:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjJDF4i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 01:56:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52530A7
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 22:56:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2013021835
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 05:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696398993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=X/nK/BqCsHODH+/YxLzuQUHwaY8pKeAhG8rSlg44Jeg=;
        b=Xw9GKzgY1nU/Qx32XEXz6cjplkvNju+11NkI4mGFli320dnjcyehGlN4RAna/5tEuG+3W/
        bozxgC6Ms1x0KGXl+AvkZS3o59xshxF2zaQjfLekJv+sAT6SClAKA4swuS4uuOilpVRDmd
        JG8jXxUVsIhEdlb/YDZM6DFAzEX1+Uw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5358413A2E
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 05:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZJAHBZD+HGX2UwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Oct 2023 05:56:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: dump-tree: allow using '-' for tree ids
Date:   Wed,  4 Oct 2023 16:26:14 +1030
Message-ID: <a59a24349345a83c7594ea0340278061ce35a912.1696398970.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently for multi-word tree names, we only allow '_' to connect the
two words, like "block_group".

Meanwhile for mkfs features, we go '-' to connect two words, like
"block-group-tree".
This makes users to use different separators for different commands.

This patch would allow using both '-' and '_' for tree ids.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/inspect-dump-tree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 2bfeb25b5482..de271fa6438c 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -169,12 +169,19 @@ static u64 treeid_from_string(const char *str, const char **end)
 		{ "QUOTA", BTRFS_QUOTA_TREE_OBJECTID },
 		{ "UUID", BTRFS_UUID_TREE_OBJECTID },
 		{ "FREE_SPACE", BTRFS_FREE_SPACE_TREE_OBJECTID },
+		{ "FREE-SPACE", BTRFS_FREE_SPACE_TREE_OBJECTID },
 		{ "TREE_LOG_FIXUP", BTRFS_TREE_LOG_FIXUP_OBJECTID },
+		{ "TREE-LOG-FIXUP", BTRFS_TREE_LOG_FIXUP_OBJECTID },
 		{ "TREE_LOG", BTRFS_TREE_LOG_OBJECTID },
+		{ "TREE-LOG", BTRFS_TREE_LOG_OBJECTID },
 		{ "TREE_RELOC", BTRFS_TREE_RELOC_OBJECTID },
+		{ "TREE-RELOC", BTRFS_TREE_RELOC_OBJECTID },
 		{ "DATA_RELOC", BTRFS_DATA_RELOC_TREE_OBJECTID },
+		{ "DATA-RELOC", BTRFS_DATA_RELOC_TREE_OBJECTID },
 		{ "BLOCK_GROUP", BTRFS_BLOCK_GROUP_TREE_OBJECTID },
+		{ "BLOCK-GROUP", BTRFS_BLOCK_GROUP_TREE_OBJECTID },
 		{ "RAID_STRIPE", BTRFS_RAID_STRIPE_TREE_OBJECTID },
+		{ "RAID-STRIPE", BTRFS_RAID_STRIPE_TREE_OBJECTID },
 	};
 
 	if (strncasecmp("BTRFS_", str, strlen("BTRFS_")) == 0)
-- 
2.42.0

