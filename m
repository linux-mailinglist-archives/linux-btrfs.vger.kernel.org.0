Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF67FB43
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436512AbfHBNjx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:60142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404517AbfHBNjx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B07E9AFA4
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8BC24DADC0; Fri,  2 Aug 2019 15:40:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 11/13] btrfs: cleanup kobject.h includes
Date:   Fri,  2 Aug 2019 15:40:26 +0200
Message-Id: <42f6e0b3bd3e1f06bdeabb9bdec5eec2327950ea.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kobject should be pulled in via sysfs.h and that needs to include it
because it needs various definitions like kobj_attribute or kobject.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 1 -
 fs/btrfs/sysfs.c | 1 -
 fs/btrfs/sysfs.h | 2 ++
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a61bf19a7ef6..e32d992a3597 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -16,7 +16,6 @@
 #include <linux/backing-dev.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
-#include <linux/kobject.h>
 #include <trace/events/btrfs.h>
 #include <asm/kmap_types.h>
 #include <asm/unaligned.h>
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b7eb921e3fd3..624ab9e29e21 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -7,7 +7,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/completion.h>
-#include <linux/kobject.h>
 #include <linux/bug.h>
 #include <linux/debugfs.h>
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index aabc67a20ce5..ab5e39b5496a 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_SYSFS_H
 #define BTRFS_SYSFS_H
 
+#include <linux/kobject.h>
+
 /*
  * Data exported through sysfs
  */
-- 
2.22.0

