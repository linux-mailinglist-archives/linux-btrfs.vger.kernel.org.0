Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86062B1B72
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKMMxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:53:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:47906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgKMMxR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:53:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRnmX5u5dF4TU/dBTUS5IsLxUbG2OCEPstN64Y6iAME=;
        b=IW86EOl/WIjAX0DzzeQYaxwwuLIqqkxNPkniy3WTjmaWE/pJQDJ3biiRY0eg1ivby+sEim
        vxYxCIPiu89TuT+BU1GMOiv/EpZh7nK0/wlAzmcscqb/JTHUWZYQ2A7vugRGfAZQaq+gA3
        kEyeP2213cxRgxCsQYK9175z2LJA630=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1064FABD9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:53:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 23/24] btrfs: scrub: allow scrub to work with subpage sectorsize
Date:   Fri, 13 Nov 2020 20:51:48 +0800
Message-Id: <20201113125149.140836-24-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just remove the restriction on (sectorsize != PAGE_SIZE) error out
branch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4be376f2a82f..f712a40ee77c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3872,14 +3872,6 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
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

