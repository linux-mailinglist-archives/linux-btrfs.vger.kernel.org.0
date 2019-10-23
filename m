Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E84E20ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfJWQsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 12:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfJWQsJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 12:48:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3440DADCB;
        Wed, 23 Oct 2019 16:48:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C971DA734; Wed, 23 Oct 2019 18:48:20 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/6] btrfs: rename extent buffer block group item accessors
Date:   Wed, 23 Oct 2019 18:48:20 +0200
Message-Id: <71dd3d16f7ca38a3aa5adc33c13f24b19d049c6a.1571848791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571848791.git.dsterba@suse.com>
References: <cover.1571848791.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Accessors defined by BTRFS_SETGET_FUNCS take a raw extent buffer and
manipulate the items there, there's no special prefix required. The
block group accessors had _disk_ because previously the names were
occupied by the on-stack accessors. As this has been addressed in the
previous patch, we can now unify the naming.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h      | 6 +++---
 fs/btrfs/print-tree.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 09f404ce70fd..50deb2b64789 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1521,14 +1521,14 @@ static inline u64 btrfs_stripe_devid_nr(struct extent_buffer *eb,
 /* struct btrfs_block_group_item */
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_used, struct btrfs_block_group_item,
 			 used, 64);
-BTRFS_SETGET_FUNCS(disk_block_group_used, struct btrfs_block_group_item,
+BTRFS_SETGET_FUNCS(block_group_used, struct btrfs_block_group_item,
 			 used, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_chunk_objectid,
 			struct btrfs_block_group_item, chunk_objectid, 64);
 
-BTRFS_SETGET_FUNCS(disk_block_group_chunk_objectid,
+BTRFS_SETGET_FUNCS(block_group_chunk_objectid,
 		   struct btrfs_block_group_item, chunk_objectid, 64);
-BTRFS_SETGET_FUNCS(disk_block_group_flags,
+BTRFS_SETGET_FUNCS(block_group_flags,
 		   struct btrfs_block_group_item, flags, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
 			struct btrfs_block_group_item, flags, 64);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 9cb50577d982..873b6b694107 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -266,9 +266,9 @@ void btrfs_print_leaf(struct extent_buffer *l)
 					    struct btrfs_block_group_item);
 			pr_info(
 		   "\t\tblock group used %llu chunk_objectid %llu flags %llu\n",
-				btrfs_disk_block_group_used(l, bi),
-				btrfs_disk_block_group_chunk_objectid(l, bi),
-				btrfs_disk_block_group_flags(l, bi));
+				btrfs_block_group_used(l, bi),
+				btrfs_block_group_chunk_objectid(l, bi),
+				btrfs_block_group_flags(l, bi));
 			break;
 		case BTRFS_CHUNK_ITEM_KEY:
 			print_chunk(l, btrfs_item_ptr(l, i,
-- 
2.23.0

