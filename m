Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900FD200896
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgFSMZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 08:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:45498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732987AbgFSMY7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 08:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1DC9AEBF;
        Fri, 19 Jun 2020 12:24:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/6] btrfs: tracepoints: Fix btrfs_trigger_flush printout
Date:   Fri, 19 Jun 2020 15:24:46 +0300
Message-Id: <20200619122451.31162-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619122451.31162-1-nborisov@suse.com>
References: <20200619122451.31162-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When tracepoints use __print_symbolic to print textual representation of
a value that comes from an ENUM each enum value needs to be exported
to user space so that user space tools can convert the binary value
data to the trings as user space does not know what those enums are
about.

Doing a trace-cmd record && trace-cmd report currently results in:

kworker/u8:1-61    [000]    66.299527: btrfs_flush_space:    5302ee13-c65e-45bb-98ef-8fe3835bd943: state=3(0x3) flags=4(METADATA) num_bytes=2621440 ret=0

I.e state is not translated to its symbolic counterpart. With this patch
applied the output is:

fio-370   [002]    56.762402: btrfs_trigger_flush:  d04cd7ac-38e2-452f-a7f5-8157529fd5f0: preempt: flush=3(BTRFS_RESERVE_FLUSH_ALL) flags=4(METADATA) bytes=655360

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/trace/events/btrfs.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index b4453fbbfa4b..2615c7181e8c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1042,11 +1042,24 @@ TRACE_EVENT(btrfs_space_reservation,
 			__entry->bytes)
 );
 
-#define show_flush_action(action)						\
-	__print_symbolic(action,						\
-		{ BTRFS_RESERVE_NO_FLUSH,	"BTRFS_RESERVE_NO_FLUSH"},	\
-		{ BTRFS_RESERVE_FLUSH_LIMIT,	"BTRFS_RESERVE_FLUSH_LIMIT"},	\
-		{ BTRFS_RESERVE_FLUSH_ALL,	"BTRFS_RESERVE_FLUSH_ALL"})
+#define FLUSH_ACTIONS								\
+	EM (BTRFS_RESERVE_NO_FLUSH,		"BTRFS_RESERVE_NO_FLUSH")	\
+	EM (BTRFS_RESERVE_FLUSH_LIMIT,		"BTRFS_RESERVE_FLUSH_LIMIT")	\
+	EM (BTRFS_RESERVE_FLUSH_ALL,		"BTRFS_RESERVE_FLUSH_ALL")	\
+	EMe (BTRFS_RESERVE_FLUSH_ALL_STEAL,	"BTRFS_RESERVE_FLUSH_ALL_STEAL")
+
+#undef EM
+#undef EMe
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define EMe(a, b) TRACE_DEFINE_ENUM(a);
+
+FLUSH_ACTIONS
+
+#undef EM
+#undef EMe
+
+#define EM(a, b)        {a, b},
+#define EMe(a, b)       {a, b}
 
 TRACE_EVENT(btrfs_trigger_flush,
 
@@ -1071,7 +1084,7 @@ TRACE_EVENT(btrfs_trigger_flush,
 
 	TP_printk_btrfs("%s: flush=%d(%s) flags=%llu(%s) bytes=%llu",
 		  __get_str(reason), __entry->flush,
-		  show_flush_action(__entry->flush),
+		  __print_symbolic(__entry->flush, FLUSH_ACTIONS),
 		  __entry->flags,
 		  __print_flags((unsigned long)__entry->flags, "|",
 				BTRFS_GROUP_FLAGS),
-- 
2.17.1

