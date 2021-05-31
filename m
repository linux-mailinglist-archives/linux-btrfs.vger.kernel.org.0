Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3A395777
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhEaIx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:53:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhEaIxT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:53:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+pcEKE8ce+8M721LedDLtEmTln9xHPkzPZZp0ZcXc4=;
        b=BJAHI07VONLjWmldHnHDsVRKNeFfxd0wdg/kErczE/w8tzlym7jaSv9HwLMhwa+5JdJxPU
        +bPFIxmBAq4AC3XyfQHxSQGlL0exJGyXWEAenIXBPDAL8G57IpaMn2g3UDqhAhIJl5ZnWV
        9/P8BT4VbdFa4lZFklcRUsEHo1010lU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4CACB3E8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:51:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 16/30] btrfs: make btrfs_page_mkwrite() to be subpage compatible
Date:   Mon, 31 May 2021 16:50:52 +0800
Message-Id: <20210531085106.259490-17-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
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
index 909aadc098ce..e756423a7a70 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8633,8 +8633,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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

