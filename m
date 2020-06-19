Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1120089A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 14:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbgFSMZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 08:25:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:45558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732990AbgFSMY7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 08:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F4F3B170;
        Fri, 19 Jun 2020 12:24:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/6] btrfs: tracepoints: Fix qgroup reservation type printing
Date:   Fri, 19 Jun 2020 15:24:49 +0300
Message-Id: <20200619122451.31162-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619122451.31162-1-nborisov@suse.com>
References: <20200619122451.31162-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since qgroup's reservation types are define in a macro they must be
exported to user space in order for user space tools to convert raw
binary data to symbolic names. Currently trace-cmd report produces
the following output:

kworker/u8:2-459   [003]  1208.543587: qgroup_update_reserve:
2b742cae-e0e5-4def-9ef7-28a9b34a951e: qgid=5 type=0x2 cur_reserved=54870016 diff=-32768

With this fix the output is:

kworker/u8:2-459   [003]  1208.543587: qgroup_update_reserve:
2b742cae-e0e5-4def-9ef7-28a9b34a951e: qgid=5 type=BTRFS_QGROUP_RSV_META_PREALLOC cur_reserved=54870016 diff=-32768

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/trace/events/btrfs.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index e13c25598057..e6881ad5550a 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -78,6 +78,11 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 	EM (BTRFS_FILE_EXTENT_REG,		"REG")		\
 	EMe (BTRFS_FILE_EXTENT_PREALLOC,	"PREALLOC")
 
+#define QGROUP_RSV_TYPES					\
+	EM( BTRFS_QGROUP_RSV_DATA,	  "DATA"	)	\
+	EM( BTRFS_QGROUP_RSV_META_PERTRANS, "META_PERTRANS")	\
+	EMe( BTRFS_QGROUP_RSV_META_PREALLOC, "META_PREALLOC")
+
 #undef EM
 #undef EMe
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
@@ -85,6 +90,7 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 
 FLUSH_ACTIONS
 FI_TYPES
+QGROUP_RSV_TYPES
 
 #undef EM
 #undef EMe
@@ -92,13 +98,6 @@ FI_TYPES
 #define EM(a, b)        {a, b},
 #define EMe(a, b)       {a, b}
 
-
-#define show_qgroup_rsv_type(type)					\
-	__print_symbolic(type,						\
-		{ BTRFS_QGROUP_RSV_DATA,	  "DATA"	},	\
-		{ BTRFS_QGROUP_RSV_META_PERTRANS, "META_PERTRANS" },	\
-		{ BTRFS_QGROUP_RSV_META_PREALLOC, "META_PREALLOC" })
-
 #define show_extent_io_tree_owner(owner)				       \
 	__print_symbolic(owner,						       \
 		{ IO_TREE_FS_PINNED_EXTENTS, 	  "PINNED_EXTENTS" },	       \
@@ -1704,7 +1703,7 @@ TRACE_EVENT(qgroup_update_reserve,
 	),
 
 	TP_printk_btrfs("qgid=%llu type=%s cur_reserved=%llu diff=%lld",
-		__entry->qgid, show_qgroup_rsv_type(__entry->type),
+		__entry->qgid, __print_symbolic(__entry->type, QGROUP_RSV_TYPES),
 		__entry->cur_reserved, __entry->diff)
 );
 
@@ -1728,7 +1727,7 @@ TRACE_EVENT(qgroup_meta_reserve,
 
 	TP_printk_btrfs("refroot=%llu(%s) type=%s diff=%lld",
 		show_root_type(__entry->refroot),
-		show_qgroup_rsv_type(__entry->type), __entry->diff)
+		__print_symbolic(__entry->type, QGROUP_RSV_TYPES), __entry->diff)
 );
 
 TRACE_EVENT(qgroup_meta_convert,
@@ -1749,8 +1748,8 @@ TRACE_EVENT(qgroup_meta_convert,
 
 	TP_printk_btrfs("refroot=%llu(%s) type=%s->%s diff=%lld",
 		show_root_type(__entry->refroot),
-		show_qgroup_rsv_type(BTRFS_QGROUP_RSV_META_PREALLOC),
-		show_qgroup_rsv_type(BTRFS_QGROUP_RSV_META_PERTRANS),
+		__print_symbolic(BTRFS_QGROUP_RSV_META_PREALLOC, QGROUP_RSV_TYPES),
+		__print_symbolic(BTRFS_QGROUP_RSV_META_PERTRANS, QGROUP_RSV_TYPES),
 		__entry->diff)
 );
 
@@ -1776,7 +1775,7 @@ TRACE_EVENT(qgroup_meta_free_all_pertrans,
 
 	TP_printk_btrfs("refroot=%llu(%s) type=%s diff=%lld",
 		show_root_type(__entry->refroot),
-		show_qgroup_rsv_type(__entry->type), __entry->diff)
+		__print_symbolic(__entry->type, QGROUP_RSV_TYPES), __entry->diff)
 );
 
 DECLARE_EVENT_CLASS(btrfs__prelim_ref,
-- 
2.17.1

