Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5AA36016D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhDOFGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:38206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhDOFGM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNUDlTylMEzbi3r3T/xmB+p/3yibntMa3fEkGs//W7w=;
        b=Nx8WMyGUu66qjYCEyqgPRL0pefgD0Mor6SpOWch6yW4P9yDwDV62XIetKA/hAE5WV0Z5xS
        h5NBucg0wQgJs9qQkkjMyBd/gbeKCEvMg/VoEqIjSKgphIIN7xVTZVEvDt0lhYoUa0DVTJ
        d6qLydzjJ8hp4i+bKYaKL/Q4uyhpr/s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9D3AAF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 30/42] btrfs: make btrfs_page_mkwrite() to be subpage compatible
Date:   Thu, 15 Apr 2021 13:04:36 +0800
Message-Id: <20210415050448.267306-31-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
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
index 38ebb79ee580..67c82de6b96a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8628,8 +8628,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		kunmap(page);
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

