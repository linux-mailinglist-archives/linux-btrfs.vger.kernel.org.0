Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40272008B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbgFSM10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 08:27:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:46052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733012AbgFSMZS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 08:25:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 82A13B1C6;
        Fri, 19 Jun 2020 12:24:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/6] btrfs: tracepoints: Switch extent_io_tree_owner to using EM macro
Date:   Fri, 19 Jun 2020 15:24:50 +0300
Message-Id: <20200619122451.31162-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619122451.31162-1-nborisov@suse.com>
References: <20200619122451.31162-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fixes correct pint out of the extent io tree owner in
btrfs_set_extent_bit/btrfs_clear_extent_bit/btrfs_convert_extent_bit
tracepoints.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/trace/events/btrfs.h | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index e6881ad5550a..8a758892bdbe 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -83,6 +83,18 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 	EM( BTRFS_QGROUP_RSV_META_PERTRANS, "META_PERTRANS")	\
 	EMe( BTRFS_QGROUP_RSV_META_PREALLOC, "META_PREALLOC")
 
+#define IO_TREE_OWNER						    \
+	EM( IO_TREE_FS_PINNED_EXTENTS, 	  "PINNED_EXTENTS")	    \
+	EM( IO_TREE_FS_EXCLUDED_EXTENTS,  "EXCLUDED_EXTENTS")	    \
+	EM( IO_TREE_INODE_IO,		  "INODE_IO")		    \
+	EM( IO_TREE_INODE_IO_FAILURE,	  "INODE_IO_FAILURE")	    \
+	EM( IO_TREE_RELOC_BLOCKS,	  "RELOC_BLOCKS")	    \
+	EM( IO_TREE_TRANS_DIRTY_PAGES,	  "TRANS_DIRTY_PAGES")      \
+	EM( IO_TREE_ROOT_DIRTY_LOG_PAGES, "ROOT_DIRTY_LOG_PAGES")   \
+	EM( IO_TREE_INODE_FILE_EXTENT,	  "INODE_FILE_EXTENT")      \
+	EM( IO_TREE_LOG_CSUM_RANGE,	  "LOG_CSUM_RANGE")         \
+	EMe( IO_TREE_SELFTEST,		  "SELFTEST")
+
 #undef EM
 #undef EMe
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
@@ -91,6 +103,7 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 FLUSH_ACTIONS
 FI_TYPES
 QGROUP_RSV_TYPES
+IO_TREE_OWNER
 
 #undef EM
 #undef EMe
@@ -98,18 +111,6 @@ QGROUP_RSV_TYPES
 #define EM(a, b)        {a, b},
 #define EMe(a, b)       {a, b}
 
-#define show_extent_io_tree_owner(owner)				       \
-	__print_symbolic(owner,						       \
-		{ IO_TREE_FS_PINNED_EXTENTS, 	  "PINNED_EXTENTS" },	       \
-		{ IO_TREE_FS_EXCLUDED_EXTENTS,	  "EXCLUDED_EXTENTS" },	       \
-		{ IO_TREE_INODE_IO,		  "INODE_IO" },		       \
-		{ IO_TREE_INODE_IO_FAILURE,	  "INODE_IO_FAILURE" },	       \
-		{ IO_TREE_RELOC_BLOCKS,		  "RELOC_BLOCKS" },	       \
-		{ IO_TREE_TRANS_DIRTY_PAGES,	  "TRANS_DIRTY_PAGES" },       \
-		{ IO_TREE_ROOT_DIRTY_LOG_PAGES,	  "ROOT_DIRTY_LOG_PAGES" },    \
-		{ IO_TREE_INODE_FILE_EXTENT,	  "INODE_FILE_EXTENT" },       \
-		{ IO_TREE_LOG_CSUM_RANGE,	  "LOG_CSUM_RANGE" },          \
-		{ IO_TREE_SELFTEST,		  "SELFTEST" })
 
 #define BTRFS_GROUP_FLAGS	\
 	{ BTRFS_BLOCK_GROUP_DATA,	"DATA"},	\
@@ -1933,7 +1934,7 @@ TRACE_EVENT(btrfs_set_extent_bit,
 
 	TP_printk_btrfs(
 		"io_tree=%s ino=%llu root=%llu start=%llu len=%llu set_bits=%s",
-		show_extent_io_tree_owner(__entry->owner), __entry->ino,
+		__print_symbolic(__entry->owner, IO_TREE_OWNER), __entry->ino,
 		__entry->rootid, __entry->start, __entry->len,
 		__print_flags(__entry->set_bits, "|", EXTENT_FLAGS))
 );
@@ -1972,7 +1973,7 @@ TRACE_EVENT(btrfs_clear_extent_bit,
 
 	TP_printk_btrfs(
 		"io_tree=%s ino=%llu root=%llu start=%llu len=%llu clear_bits=%s",
-		show_extent_io_tree_owner(__entry->owner), __entry->ino,
+		__print_symbolic(__entry->owner, IO_TREE_OWNER), __entry->ino,
 		__entry->rootid, __entry->start, __entry->len,
 		__print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
 );
@@ -2013,7 +2014,7 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 
 	TP_printk_btrfs(
 "io_tree=%s ino=%llu root=%llu start=%llu len=%llu set_bits=%s clear_bits=%s",
-		  show_extent_io_tree_owner(__entry->owner), __entry->ino,
+		  __print_symbolic(__entry->owner, IO_TREE_OWNER), __entry->ino,
 		  __entry->rootid, __entry->start, __entry->len,
 		  __print_flags(__entry->set_bits , "|", EXTENT_FLAGS),
 		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
-- 
2.17.1

