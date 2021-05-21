Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DEB38BFD3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhEUGog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhEUGoT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VhEooSYURuPgH/s7NuRUfjgR5o3bQkchmng0ZLW6hU=;
        b=ZUlVqtyK2uvywLM9omQmq7NS08htosZJYYLnuLtdhr/XEewI4hl11E0/JRo+XZHMsWhrvL
        BREqlswnZyYmp1ombUTQx3MEtwLWOT8R0wju1ip656+fHpT8YFi9a3hfItwwjK0pVdAUqg
        6mqBOVG5+ZcV0p6K52PgSIa+hUTLAf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2D07AD71
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:41:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 16/31] btrfs: make btrfs_page_mkwrite() to be subpage compatible
Date:   Fri, 21 May 2021 14:40:35 +0800
Message-Id: <20210521064050.191164-17-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Only set_page_dirty() and SetPageUptodate() is not subpage compatible.
Convert them to subpage helpers, so that __extent_writepage_io() can
submit page content correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5011f407c85c..39049a614b7c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8621,8 +8621,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		flush_dcache_page(page);
 	}
 	ClearPageChecked(page);
-	set_page_dirty(page);
-	SetPageUptodate(page);
+	btrfs_page_set_dirty(fs_info, page, page_start, end + 1 - page_start);
+	btrfs_page_set_uptodate(fs_info, page, page_start,
+				end + 1 - page_start);
 
 	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
-- 
2.31.1

