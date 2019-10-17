Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E5BDA3E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 04:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407242AbfJQCiq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 22:38:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392198AbfJQCiq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 22:38:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3501B203
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2019 02:38:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: qgroup: Fix bad entry members of qgroup trace events
Date:   Thu, 17 Oct 2019 10:38:37 +0800
Message-Id: <20191017023837.32264-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017023837.32264-1-wqu@suse.com>
References: <20191017023837.32264-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For btrfs:qgroup_meta_reserve event, the trace event can output garbage:
qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=5(FS_TREE) type=DATA diff=2
qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=5(FS_TREE) type=0x258792 diff=2

The @type can be completely garbage, as DATA type is not possible for
trace_qgroup_meta_reserve() trace event.

[CAUSE]
Ther are several problems related to qgroup trace events:
- Unassigned entry member
  Member entry::type of trace_qgroup_update_reserve() and
  trace_qgourp_meta_reserve() is not assigned

- Redundant entry member
  Member entry::type is completely useless in
  trace_qgroup_meta_convert()

[FIX]
Fix these stupid bugs.

Fixes: 4ee0d8832c2e ("btrfs: qgroup: Update trace events for metadata reservation")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/trace/events/btrfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 5df604de4f11..75ae1899452b 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1688,6 +1688,7 @@ TRACE_EVENT(qgroup_update_reserve,
 		__entry->qgid		= qgroup->qgroupid;
 		__entry->cur_reserved	= qgroup->rsv.values[type];
 		__entry->diff		= diff;
+		__entry->type		= type;
 	),
 
 	TP_printk_btrfs("qgid=%llu type=%s cur_reserved=%llu diff=%lld",
@@ -1710,6 +1711,7 @@ TRACE_EVENT(qgroup_meta_reserve,
 	TP_fast_assign_btrfs(root->fs_info,
 		__entry->refroot	= root->root_key.objectid;
 		__entry->diff		= diff;
+		__entry->type		= type;
 	),
 
 	TP_printk_btrfs("refroot=%llu(%s) type=%s diff=%lld",
@@ -1726,7 +1728,6 @@ TRACE_EVENT(qgroup_meta_convert,
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	refroot			)
 		__field(	s64,	diff			)
-		__field(	int,	type			)
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
-- 
2.23.0

