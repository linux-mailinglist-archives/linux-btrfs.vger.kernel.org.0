Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5F2008B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgFSM1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 08:27:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732988AbgFSMY7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 08:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14CA6B033;
        Fri, 19 Jun 2020 12:24:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/6] btrfs: tracepoints: Fix extent type symbolic name print
Date:   Fri, 19 Jun 2020 15:24:47 +0300
Message-Id: <20200619122451.31162-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619122451.31162-1-nborisov@suse.com>
References: <20200619122451.31162-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

extent's type is an enum and this requires that the enum values be
exported to user space so that user space tools can correctly map raw
binary data to the symbolic name. Currently tracepoints using
btrfs__file_extent_item_regular or btrfs__file_extent_item_inline result
in the following output:

fio-443   [002]   586.609450: btrfs_get_extent_show_fi_regular: f0c3bf8e-0174-4bcc-92aa-6c2d62430420:i
root=5(FS_TREE) inode=258 size=2136457216 disk_isize=0 i
file extent range=[2126946304 2136457216] (num_bytes=9510912
ram_bytes=9510912 disk_bytenr=0 disk_num_bytes=0 extent_offset=0
type=0x1 compression=0

E.g type is 0x1 . With this patch applie the output is:

<ommitted for brevity>  disk_bytenr=141348864 disk_num_bytes=4096 extent_offset=0 type=REG compression=0

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/trace/events/btrfs.h | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 2615c7181e8c..937519399f30 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -67,11 +67,24 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 	      (obj >= BTRFS_ROOT_TREE_OBJECTID &&			\
 	       obj <= BTRFS_QUOTA_TREE_OBJECTID)) ? __show_root_type(obj) : "-"
 
-#define show_fi_type(type)						\
-	__print_symbolic(type,						\
-		 { BTRFS_FILE_EXTENT_INLINE,	"INLINE" },		\
-		 { BTRFS_FILE_EXTENT_REG,	"REG"	 },		\
-		 { BTRFS_FILE_EXTENT_PREALLOC,	"PREALLOC"})
+#define FI_TYPES							\
+	EM (BTRFS_FILE_EXTENT_INLINE,		"INLINE")	\
+	EM (BTRFS_FILE_EXTENT_REG,		"REG")		\
+	EMe (BTRFS_FILE_EXTENT_PREALLOC,	"PREALLOC")
+
+#undef EM
+#undef EMe
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define EMe(a, b) TRACE_DEFINE_ENUM(a);
+
+FI_TYPES
+
+#undef EM
+#undef EMe
+
+#define EM(a, b)        {a, b},
+#define EMe(a, b)       {a, b}
+
 
 #define show_qgroup_rsv_type(type)					\
 	__print_symbolic(type,						\
@@ -380,7 +393,7 @@ DECLARE_EVENT_CLASS(btrfs__file_extent_item_regular,
 		__entry->disk_isize, __entry->extent_start,
 		__entry->extent_end, __entry->num_bytes, __entry->ram_bytes,
 		__entry->disk_bytenr, __entry->disk_num_bytes,
-		__entry->extent_offset, show_fi_type(__entry->extent_type),
+		__entry->extent_offset, __print_symbolic(__entry->extent_type, FI_TYPES),
 		__entry->compression)
 );
 
@@ -421,7 +434,7 @@ DECLARE_EVENT_CLASS(
 		"extent_type=%s compression=%u",
 		show_root_type(__entry->root_obj), __entry->ino, __entry->isize,
 		__entry->disk_isize, __entry->extent_start,
-		__entry->extent_end, show_fi_type(__entry->extent_type),
+		__entry->extent_end, __print_symbolic(__entry->extent_type, FI_TYPES),
 		__entry->compression)
 );
 
-- 
2.17.1

