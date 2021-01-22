Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DCA2FFFF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbhAVKPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:15:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:56148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbhAVJ7J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 04:59:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcrhPWIyjx0XK+NOmqVj/44JWO8Crt6PiVrYwj5og3Y=;
        b=iGdvsncYXGYcb7BRZ9ukNXeGv9UfM47WBqFG2Fih93OTcWDMF+EY39+GXTOajmgDWy3lYF
        tv0eIdIj4ct7II97Gp7xO2XuS83kcJqp8u2SPcLWiRPZh34mSdOVB0zjlOGY5fDRhEEIvt
        ARttYSXMcI7EckOibtG+KVB/jAc6hQk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D0C3AEAC;
        Fri, 22 Jan 2021 09:58:07 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 02/14] btrfs: Fix parameter description of btrfs_add_extent_mapping
Date:   Fri, 22 Jan 2021 11:57:53 +0200
Message-Id: <20210122095805.620458-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fixes the following compiler warnings:

fs/btrfs/extent_map.c:601: warning: Function parameter or member 'fs_info' not described in 'btrfs_add_extent_mapping'
fs/btrfs/extent_map.c:601: warning: Function parameter or member 'em_tree' not described in 'btrfs_add_extent_mapping'
fs/btrfs/extent_map.c:601: warning: Function parameter or member 'em_in' not described in 'btrfs_add_extent_mapping'
fs/btrfs/extent_map.c:601: warning: Function parameter or member 'start' not described in 'btrfs_add_extent_mapping'
fs/btrfs/extent_map.c:601: warning: Function parameter or member 'len' not described in 'btrfs_add_extent_mapping'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_map.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index c540a37cbdb2..fc6503218caa 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -577,12 +577,13 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 }
 
 /**
- * btrfs_add_extent_mapping - add extent mapping into em_tree
- * @fs_info - used for tracepoint
- * @em_tree - the extent tree into which we want to insert the extent mapping
- * @em_in   - extent we are inserting
- * @start   - start of the logical range btrfs_get_extent() is requesting
- * @len     - length of the logical range btrfs_get_extent() is requesting
+ * Add extent mapping into em_tree
+ *
+ * @fs_info:  the filesystem
+ * @em_tree:  the extent tree into which we want to insert the extent mapping
+ * @em_in:    extent we are inserting
+ * @start:    start of the logical range btrfs_get_extent() is requesting
+ * @len:      length of the logical range btrfs_get_extent() is requesting
  *
  * Note that @em_in's range may be different from [start, start+len),
  * but they must be overlapped.
-- 
2.25.1

