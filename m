Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA12CB54E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbgLBGuN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:50:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:53474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387543AbgLBGuL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:50:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s86QM7wHGXhcbOUHWVC15k2fWKUBsBgzuX9bmQWim5I=;
        b=b04ebu6nUXp16Ap5nZYXNrmBEyKz/vw9iPAHc8TOXK5hhtjzhLguZ9v1pMEpcPoiQwFObE
        0qwEL7k5TN0k06ccunHz9zb+3VB1t+SkRvx6/X0zhYsYJVi4fS64uvHjoOxehPppkPz1y3
        3IADMelKIHihc+iN0/OniWXfGPDavp8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DDE4AEF8
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 06:48:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 15/15] btrfs: scrub: allow scrub to work with subpage sectorsize
Date:   Wed,  2 Dec 2020 14:48:11 +0800
Message-Id: <20201202064811.100688-16-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since btrfs scrub is utilizing its own infrastructure to submit
read/write, scrub is independent from all other routines.

This brings one very neat feature, allow us to read 4K data into
offset 0 of a 64K page.
So is the writeback routine.

This makes scrub on subpage sector size much easier to implement, and
thanks to previous commits which just changed the implementation to
always do scrub based on sector size, now scrub can handle subpage
filesystem without any problem.

This patch will just remove the restriction on
(sectorsize != PAGE_SIZE), to make scrub finally work on subpage
filesystems.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8a43e8cb10a6..e0ac0009303d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3880,14 +3880,6 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		return -EINVAL;
 	}
 
-	if (fs_info->sectorsize != PAGE_SIZE) {
-		/* not supported for data w/o checksums */
-		btrfs_err_rl(fs_info,
-			   "scrub: size assumption sectorsize != PAGE_SIZE (%d != %lu) fails",
-		       fs_info->sectorsize, PAGE_SIZE);
-		return -EINVAL;
-	}
-
 	if (fs_info->nodesize >
 	    PAGE_SIZE * SCRUB_MAX_PAGES_PER_BLOCK ||
 	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_PAGES_PER_BLOCK) {
-- 
2.29.2

