Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8053C18639
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 09:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfEIHb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 03:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:37122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfEIHb4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 May 2019 03:31:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E781AE24
        for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2019 07:31:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: extent-io: Remove the incorrect comment on RO fs when btrfs_run_delalloc_range() fails
Date:   Thu,  9 May 2019 15:31:50 +0800
Message-Id: <20190509073150.13027-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At the context of btrfs_run_delalloc_range(), we haven't started/joined
a transaction, thus even something went wrong, we can't and won't abort
transaction, thus no way to make the fs RO.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13fca7bfc1f2..85023bb322f0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3312,7 +3312,6 @@ static noinline_for_stack int writepage_delalloc(struct inode *inode,
 		}
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
 				delalloc_end, &page_started, nr_written, wbc);
-		/* File system has been set read-only */
 		if (ret) {
 			SetPageError(page);
 			/*
-- 
2.21.0

