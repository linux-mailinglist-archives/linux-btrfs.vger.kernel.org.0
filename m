Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B876ADAB2A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439678AbfJQL2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 07:28:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405872AbfJQL2q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 07:28:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47F72B3C9;
        Thu, 17 Oct 2019 11:28:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E75CDA808; Thu, 17 Oct 2019 13:28:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: tracepoints: drop typecasts from printk
Date:   Thu, 17 Oct 2019 13:28:55 +0200
Message-Id: <2084ebaaff9a6a3058052da1eaef8a3036302744.1571311653.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571311653.git.dsterba@suse.com>
References: <cover.1571311653.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove typecasts from trace printk, adjust types and move typecast to
the assignment if necessary. When assigning, the types are more obvious
compared to matching the variables to the format strings.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 include/trace/events/btrfs.h | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c60cf281cb86..11e9a6cc7f63 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -170,7 +170,7 @@ DECLARE_EVENT_CLASS(btrfs__inode,
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  ino			)
-		__field(	blkcnt_t,  blocks		)
+		__field(	u64,  blocks			)
 		__field(	u64,  disk_i_size		)
 		__field(	u64,  generation		)
 		__field(	u64,  last_trans		)
@@ -194,7 +194,7 @@ DECLARE_EVENT_CLASS(btrfs__inode,
 		  show_root_type(__entry->root_objectid),
 		  __entry->generation,
 		  __entry->ino,
-		  (unsigned long long)__entry->blocks,
+		  __entry->blocks,
 		  __entry->disk_i_size,
 		  __entry->last_trans,
 		  __entry->logged_trans)
@@ -574,7 +574,7 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
 		__field(	char,   for_kupdate		)
 		__field(	char,   for_reclaim		)
 		__field(	char,   range_cyclic		)
-		__field(	pgoff_t,  writeback_index	)
+		__field(	unsigned long,  writeback_index	)
 		__field(	u64,    root_objectid		)
 	),
 
@@ -603,7 +603,7 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
 		  __entry->range_start, __entry->range_end,
 		  __entry->for_kupdate,
 		  __entry->for_reclaim, __entry->range_cyclic,
-		  (unsigned long)__entry->writeback_index)
+		  __entry->writeback_index)
 );
 
 DEFINE_EVENT(btrfs__writepage, __extent_writepage,
@@ -622,7 +622,7 @@ TRACE_EVENT(btrfs_writepage_end_io_hook,
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	 ino		)
-		__field(	pgoff_t, index		)
+		__field(	unsigned long, index	)
 		__field(	u64,	 start		)
 		__field(	u64,	 end		)
 		__field(	int,	 uptodate	)
@@ -642,7 +642,7 @@ TRACE_EVENT(btrfs_writepage_end_io_hook,
 	TP_printk_btrfs("root=%llu(%s) ino=%llu page_index=%lu start=%llu "
 		  "end=%llu uptodate=%d",
 		  show_root_type(__entry->root_objectid),
-		  __entry->ino, (unsigned long)__entry->index,
+		  __entry->ino, __entry->index,
 		  __entry->start,
 		  __entry->end, __entry->uptodate)
 );
@@ -1325,17 +1325,17 @@ TRACE_EVENT(alloc_extent_state,
 	TP_STRUCT__entry(
 		__field(const struct extent_state *, state)
 		__field(gfp_t, mask)
-		__field(unsigned long, ip)
+		__field(const void*, ip)
 	),
 
 	TP_fast_assign(
 		__entry->state	= state,
 		__entry->mask	= mask,
-		__entry->ip	= IP
+		__entry->ip	= (const void *)IP
 	),
 
 	TP_printk("state=%p mask=%s caller=%pS", __entry->state,
-		  show_gfp_flags(__entry->mask), (const void *)__entry->ip)
+		  show_gfp_flags(__entry->mask), __entry->ip)
 );
 
 TRACE_EVENT(free_extent_state,
@@ -1346,16 +1346,15 @@ TRACE_EVENT(free_extent_state,
 
 	TP_STRUCT__entry(
 		__field(const struct extent_state *, state)
-		__field(unsigned long, ip)
+		__field(const void*, ip)
 	),
 
 	TP_fast_assign(
 		__entry->state	= state,
-		__entry->ip = IP
+		__entry->ip = (const void *)IP
 	),
 
-	TP_printk("state=%p caller=%pS", __entry->state,
-		  (const void *)__entry->ip)
+	TP_printk("state=%p caller=%pS", __entry->state, __entry->ip)
 );
 
 DECLARE_EVENT_CLASS(btrfs__work,
@@ -1567,8 +1566,7 @@ DECLARE_EVENT_CLASS(btrfs_qgroup_extent,
 	),
 
 	TP_printk_btrfs("bytenr=%llu num_bytes=%llu",
-		  (unsigned long long)__entry->bytenr,
-		  (unsigned long long)__entry->num_bytes)
+		  __entry->bytenr, __entry->num_bytes)
 );
 
 DEFINE_EVENT(btrfs_qgroup_extent, btrfs_qgroup_account_extents,
-- 
2.23.0

