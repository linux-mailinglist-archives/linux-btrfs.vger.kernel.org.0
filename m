Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DDD8971F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 08:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHLGT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 02:19:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:50316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfHLGT0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 02:19:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B5C6AC63
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 06:19:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs-progs: check/original: Check and repair root item geneartion
Date:   Mon, 12 Aug 2019 14:19:07 +0800
Message-Id: <20190812061908.21002-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190812061908.21002-1-wqu@suse.com>
References: <20190812061908.21002-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add such ability to original mode to fix root generation mismatch, which
can be rejected by kernel.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/check/main.c b/check/main.c
index 98b07fcb58c8..ae3ce13e9466 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3437,8 +3437,10 @@ static int check_fs_root(struct btrfs_root *root,
 {
 	int ret = 0;
 	int err = 0;
+	bool generation_err = false;
 	int wret;
 	int level;
+	u64 super_generation;
 	struct btrfs_path path;
 	struct shared_node root_node;
 	struct root_record *rec;
@@ -3449,6 +3451,23 @@ static int check_fs_root(struct btrfs_root *root,
 	struct unaligned_extent_rec_t *urec;
 	struct unaligned_extent_rec_t *tmp;
 
+	super_generation = btrfs_super_generation(root->fs_info->super_copy);
+	if (btrfs_root_generation(root_item) > super_generation + 1) {
+		error(
+	"invalid generation for root %llu, have %llu expect (0, %llu]",
+		      root->root_key.objectid, btrfs_root_generation(root_item),
+		      super_generation + 1);
+		generation_err = true;
+		if (repair) {
+			root->node->flags |= EXTENT_BAD_TRANSID;
+			ret = recow_extent_buffer(root, root->node);
+			if (!ret) {
+				printf("Reset generation for root %llu\n",
+					root->root_key.objectid);
+				generation_err = false;
+			}
+		}
+	}
 	/*
 	 * Reuse the corrupt_block cache tree to record corrupted tree block
 	 *
@@ -3597,6 +3616,8 @@ skip_walking:
 
 	free_corrupt_blocks_tree(&corrupt_blocks);
 	root->fs_info->corrupt_blocks = NULL;
+	if (!ret && generation_err)
+		ret = -1;
 	return ret;
 }
 
-- 
2.22.0

