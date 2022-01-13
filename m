Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B948D1D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 06:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiAMFW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 00:22:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47494 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiAMFW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 00:22:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 48ADE212C7
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 05:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642051347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoV2NP1vxeMFTl16S062EuXBmX4hVW58cJgrMbw/P3w=;
        b=UdAV4I4SDzpxNaaCGBv+1lH6HTLQiTukV27TLBMOn+CIP+8uSphJ/LipsZ2RizS4xbImLM
        VP1JvHSMINO9EZg/E63LJ2MtEuQQC+0OyAXpg3s/08bdMjsZSEK5ZDSqoU3t+o9mc55h5+
        F6EkmMTneojS7G4fEoQQKrgdFqIUIVs=
Received: from adam-pc.suse.de (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id 7F817A3B83
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 05:22:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: expand subpage support to any PAGE_SIZE > 4K
Date:   Thu, 13 Jan 2022 13:22:10 +0800
Message-Id: <20220113052210.23614-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113052210.23614-1-wqu@suse.com>
References: <20220113052210.23614-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the recent change in metadata handling, we can handle metadata in
the following cases:

- nodesize < PAGE_SIZE and sectorsize < PAGE_SIZE
  Go subpage routine for both metadata and data.

- nodesize < PAGE_SIZE and sectorsize >= PAGE_SIZE
  Invalid case for now. As we require nodesize >= sectorsize.

- nodesize >= PAGE_SIZE and sectorsize < PAGE_SIZE
  Go subpage routine for data, but regular page routine for metadata.

- nodesize >= PAGE_SIZE and sectorsize >= PAGE_SIZE
  Go regular page routine for both metadata and data.

Now we can handle any sectorsize < PAGE_SIZE, plus the existing
sectorsize == PAGE_SIZE support.

But here we introduce an artificial limit, any PAGE_SIZE > 4K case, we
will only support 4K and PAGE_SIZE as sector size.

The idea here is to reduce the test combinations, and push 4K as the
default standard in the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 13 ++++++++-----
 fs/btrfs/sysfs.c   |  6 ++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 884e0b543136..340fa1ce11d1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2752,12 +2752,15 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 	}
 
 	/*
-	 * For 4K page size, we only support 4K sector size.
-	 * For 64K page size, we support 64K and 4K sector sizes.
+	 * We only support at most two sectorsizes: 4K and PAGE_SIZE.
+	 *
+	 * We can support 16K sectorsize with 64K page size without problem,
+	 * but such sectorsize/pagesize combination doesn't make much sense.
+	 * 4K will be our future standard, PAGE_SIZE is supported from
+	 * the very beginning.
 	 */
-	if ((PAGE_SIZE == SZ_4K && sectorsize != PAGE_SIZE) ||
-	    (PAGE_SIZE == SZ_64K && (sectorsize != SZ_4K &&
-				     sectorsize != SZ_64K))) {
+	if (sectorsize > PAGE_SIZE ||
+	    (sectorsize != SZ_4K && sectorsize != PAGE_SIZE)) {
 		btrfs_err(fs_info,
 			"sectorsize %llu not yet supported for page size %lu",
 			sectorsize, PAGE_SIZE);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index beb7f72d50b8..f6f5c37fb2ea 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -391,11 +391,9 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 {
 	ssize_t ret = 0;
 
-	/* 4K sector size is also supported with 64K page size */
-	if (PAGE_SIZE == SZ_64K)
+	/* An artificial limit to only support 4K and PAGE_SIZE */
+	if (PAGE_SIZE > SZ_4K)
 		ret += sysfs_emit_at(buf, ret, "%u ", SZ_4K);
-
-	/* Only sectorsize == PAGE_SIZE is now supported */
 	ret += sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE);
 
 	return ret;
-- 
2.34.1

