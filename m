Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2ED5A985E
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiIANUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiIANTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:19:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02130DBF
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B27D8B82636
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4410C433B5
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038318;
        bh=e7JfRz9MVLADtz9aiDm9l+a6Xqq3EyutPjCq/Ozdbag=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mjczeLS2/nbcWy9+nr53R4AJbcmJDguyQqrXjQ4af/EoMGU3CptnNrMemao81bBi6
         qzje9iWDBM0y4L5yHfLh8dyM2Qi5jbIFGlad2iC9LZp0XPv89oHsB530oovT/XlBXx
         h1vOsL+LIqBGEmnHLDN00l7Xh52CMW0zLATAAfi3s+r7vsFmE4IxBSuOSsuaX6m6TV
         dcd0KxA858tktBFWBC6L0DbWe0sevGCFKaB5//8BVpnZU5PawDjOWLDGlgvivWThFX
         zowTNLn2PT4A+SMyS6wg6wByLaWRuRi3J2O7rV6XvdKu1rfPJIY52H3ybSUFEMz7KE
         FHNWsmQvOpBCQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: properly flush delalloc when entering fiemap
Date:   Thu,  1 Sep 2022 14:18:25 +0100
Message-Id: <dd926ea5086a8c5d0bd627bb07d8f83eb492a2f6.1662022922.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
References: <cover.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If the flag FIEMAP_FLAG_SYNC is passed to fiemap, it means all delalloc
should be flushed and writeback complete. We call the generic helper
fiemap_prep() which does a filemap_write_and_wait() in case that flag is
given, however that is not enough if we have compression. Because a
single filemap_fdatawrite_range() only starts compression (in an async
thread) and therefore returns before the compression is done and writeback
is started.

So make btrfs_fiemap(), actually wait for all writeback to start and
complete if FIEMAP_FLAG_SYNC is set. We start and wait for writeback
on the whole possible file range, from 0 to LLONG_MAX, because that is
what the generic code at fiemap_prep() does.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 493623c81535..2c7d31990777 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8258,6 +8258,26 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (ret)
 		return ret;
 
+	/*
+	 * fiemap_prep() called filemap_write_and_wait() for the whole possible
+	 * file range (0 to LLONG_MAX), but that is not enough if we have
+	 * compression enabled. The first filemap_fdatawrite_range() only kicks
+	 * in the compression of data (in an async thread) and will return
+	 * before the compression is done and writeback is started. A second
+	 * filemap_fdatawrite_range() is needed to wait for the compression to
+	 * complete and writeback to start. Without this, our user is very
+	 * likely to get stale results, because the extents and extent maps for
+	 * delalloc regions are only allocated when writeback starts.
+	 */
+	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
+		ret = btrfs_fdatawrite_range(inode, 0, LLONG_MAX);
+		if (ret)
+			return ret;
+		ret = filemap_fdatawait_range(inode->i_mapping, 0, LLONG_MAX);
+		if (ret)
+			return ret;
+	}
+
 	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
 }
 
-- 
2.35.1

