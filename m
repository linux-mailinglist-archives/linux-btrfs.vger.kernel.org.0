Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60E1437B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 08:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAUHe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 02:34:29 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46475 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728767AbgAUHe2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 02:34:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0ToHCIF1_1579592063;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHCIF1_1579592063)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 15:34:23 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove unused macro BTRFS_FEAT_ATTR_COMPAT
Date:   Tue, 21 Jan 2020 15:34:22 +0800
Message-Id: <1579592062-86448-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Which is never used after it was introduced. Better to remove it?

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Chris Mason <clm@fb.com> 
Cc: Josef Bacik <josef@toxicpanda.com> 
Cc: David Sterba <dsterba@suse.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Arnaldo Carvalho de Melo <acme@kernel.org> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com> 
Cc: Jiri Olsa <jolsa@redhat.com> 
Cc: Namhyung Kim <namhyung@kernel.org> 
Cc: linux-btrfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/btrfs/sysfs.c        | 2 --
 kernel/events/uprobes.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5ebbe8a5ee76..22f78dbfc783 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -60,8 +60,6 @@ struct raid_kobject {
 #define BTRFS_FEAT_ATTR_PTR(_name)					     \
 	(&btrfs_attr_features_##_name.kobj_attr.attr)
 
-#define BTRFS_FEAT_ATTR_COMPAT(name, feature) \
-	BTRFS_FEAT_ATTR(name, FEAT_COMPAT, BTRFS_FEATURE_COMPAT, feature)
 #define BTRFS_FEAT_ATTR_COMPAT_RO(name, feature) \
 	BTRFS_FEAT_ATTR(name, FEAT_COMPAT_RO, BTRFS_FEATURE_COMPAT_RO, feature)
 #define BTRFS_FEAT_ATTR_INCOMPAT(name, feature) \
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4a..977cac2574cb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -31,7 +31,6 @@
 #include <linux/uprobes.h>
 
 #define UINSNS_PER_PAGE			(PAGE_SIZE/UPROBE_XOL_SLOT_BYTES)
-#define MAX_UPROBE_XOL_SLOTS		UINSNS_PER_PAGE
 
 static struct rb_root uprobes_tree = RB_ROOT;
 /*
-- 
1.8.3.1

