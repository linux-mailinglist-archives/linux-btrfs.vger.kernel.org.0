Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3324D2008B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbgFSM1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 08:27:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:45542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732989AbgFSMY6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 08:24:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 263C0B0BA;
        Fri, 19 Jun 2020 12:24:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/6] btrfs: tracepoints: Move FLUSH_ACTIONS define
Date:   Fri, 19 Jun 2020 15:24:48 +0300
Message-Id: <20200619122451.31162-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619122451.31162-1-nborisov@suse.com>
References: <20200619122451.31162-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since all enums used in btrfs' tracepoints are going to be redefined
to allow proper parsing of their values by userspace tools let's
rearrange when they are defined. This will allow to use only a single
set of #define EM/#undef EM sequence. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/trace/events/btrfs.h | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 937519399f30..e13c25598057 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -67,6 +67,12 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 	      (obj >= BTRFS_ROOT_TREE_OBJECTID &&			\
 	       obj <= BTRFS_QUOTA_TREE_OBJECTID)) ? __show_root_type(obj) : "-"
 
+#define FLUSH_ACTIONS								\
+	EM (BTRFS_RESERVE_NO_FLUSH,		"BTRFS_RESERVE_NO_FLUSH")	\
+	EM (BTRFS_RESERVE_FLUSH_LIMIT,		"BTRFS_RESERVE_FLUSH_LIMIT")	\
+	EM (BTRFS_RESERVE_FLUSH_ALL,		"BTRFS_RESERVE_FLUSH_ALL")	\
+	EMe (BTRFS_RESERVE_FLUSH_ALL_STEAL,	"BTRFS_RESERVE_FLUSH_ALL_STEAL")
+
 #define FI_TYPES							\
 	EM (BTRFS_FILE_EXTENT_INLINE,		"INLINE")	\
 	EM (BTRFS_FILE_EXTENT_REG,		"REG")		\
@@ -77,6 +83,7 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define EMe(a, b) TRACE_DEFINE_ENUM(a);
 
+FLUSH_ACTIONS
 FI_TYPES
 
 #undef EM
@@ -1055,25 +1062,6 @@ TRACE_EVENT(btrfs_space_reservation,
 			__entry->bytes)
 );
 
-#define FLUSH_ACTIONS								\
-	EM (BTRFS_RESERVE_NO_FLUSH,		"BTRFS_RESERVE_NO_FLUSH")	\
-	EM (BTRFS_RESERVE_FLUSH_LIMIT,		"BTRFS_RESERVE_FLUSH_LIMIT")	\
-	EM (BTRFS_RESERVE_FLUSH_ALL,		"BTRFS_RESERVE_FLUSH_ALL")	\
-	EMe (BTRFS_RESERVE_FLUSH_ALL_STEAL,	"BTRFS_RESERVE_FLUSH_ALL_STEAL")
-
-#undef EM
-#undef EMe
-#define EM(a, b) TRACE_DEFINE_ENUM(a);
-#define EMe(a, b) TRACE_DEFINE_ENUM(a);
-
-FLUSH_ACTIONS
-
-#undef EM
-#undef EMe
-
-#define EM(a, b)        {a, b},
-#define EMe(a, b)       {a, b}
-
 TRACE_EVENT(btrfs_trigger_flush,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 bytes,
-- 
2.17.1

