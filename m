Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E9C294858
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440859AbgJUG2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:44834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440851AbgJUG2P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+V7xTM+bicWnG+rnFsGWgbovgTAljsJQMEONgX30nzk=;
        b=Uct/hxKYzG9e+QpHQyNA61FGuOSvwUb19ZDO7tggcmK7oK35dYUYwMG2MHWR+GSRMzMSBM
        tbYQ+w+5zDmI4Y8BbTSdmiVVm+UDWJxxjzHxZdRgrCA/gj+vklXjt3zGRkLZ2NUwdUowXX
        ihCoOlXjN1Y/cIf5qPxOjWw6oZnnZpk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4465AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 60/68] btrfs: scrub: allow scrub to work with subpage sectorsize
Date:   Wed, 21 Oct 2020 14:25:46 +0800
Message-Id: <20201021062554.68132-61-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 354ab9985a34..806523515d2f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3821,14 +3821,6 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
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
2.28.0

