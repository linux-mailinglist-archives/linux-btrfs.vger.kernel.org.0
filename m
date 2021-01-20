Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2022FCFD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbhATMPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:15:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:36142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbhATK0P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:26:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yu3/18LdguZ3RMrz114/sO3tdPeMlJMbHqeJbxB0vJY=;
        b=oY6OoUFK3DfPRj0QgLGRZLVsVu6jMFF7mhQ5IG8QdXBLInwyFIjWO/jKTQjJ44IEgB2tHp
        z/rglYW34HkjuhifWQpTtpvU26c12jffdMB2zw27ohpTbSXjaQBHykWDgiQuGCKlTkaWE5
        QpMblkQ1wrsz2Bt1jzFm1tOrdVBN6pM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54F6DAF28;
        Wed, 20 Jan 2021 10:25:28 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 02/14] btrfs: Fix parameter description of btrfs_add_extent_mapping
Date:   Wed, 20 Jan 2021 12:25:14 +0200
Message-Id: <20210120102526.310486-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120102526.310486-1-nborisov@suse.com>
References: <20210120102526.310486-1-nborisov@suse.com>
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
 fs/btrfs/extent_map.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index aa1ff6f2ade9..90ae3c31e7fb 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -577,11 +577,11 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 
 /**
  * btrfs_add_extent_mapping - add extent mapping into em_tree
- * @fs_info - used for tracepoint
- * @em_tree - the extent tree into which we want to insert the extent mapping
- * @em_in   - extent we are inserting
- * @start   - start of the logical range btrfs_get_extent() is requesting
- * @len     - length of the logical range btrfs_get_extent() is requesting
+ * @fs_info:  used for tracepoint
+ * @em_tree:  the extent tree into which we want to insert the extent mapping
+ * @em_in:   extent we are inserting
+ * @start:    start of the logical range btrfs_get_extent() is requesting
+ * @len:      length of the logical range btrfs_get_extent() is requesting
  *
  * Note that @em_in's range may be different from [start, start+len),
  * but they must be overlapped.
-- 
2.25.1

