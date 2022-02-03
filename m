Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281524A871A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 15:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351565AbiBCO4G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 09:56:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48824 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351559AbiBCO4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 09:56:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5F47B83479
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D9DC340E4
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643900158;
        bh=rLU7MQZHp0u0rJWqOxmbhBdpT5FTUJfhmh0Ez2CqCWA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rLoZq6XmYRLQU7BAFM6sjz35B0MAtRPes2GY2sUEcdTB9YMudIusLy4GU/cvUvCI4
         JTDOI3x9ZlEVSR2qC8yh8F9I2ga7dg6l5tLRyRY1y37M03jX6QfR+/BrgdU0ft0uML
         7LJnDGua0eMrldWGl83+y0w4qyEkiB1IB9yHCyVOCs7gjxiU1/sHb1Lboga3Y5iv6z
         NWkdXVrorinQRiHVpGioeXBnjy4LhnXxPFqoDeAY//xlXnHnGTZhVlZHWNCz6BQal5
         Xxtyre6qMW3cq4/Kph8AJx2MfRy/zNaR5tJLZqEmMgBxRemm9qStcUOcfe/cZ9o1MV
         ST2eSbfj/hzVQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: remove useless path release in the fast fsync path
Date:   Thu,  3 Feb 2022 14:55:49 +0000
Message-Id: <5dc19ed9906f9551c734bfed606f6b556608d1b4.1643898314.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643898312.git.fdmanana@suse.com>
References: <cover.1643898312.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's no point in calling btrfs_release_path() after finishing the loop
that logs the modified extents, since log_one_extent() returns with the
path released. In case the list of extents is empty, the path is already
released, so there's no need for that case as well.
So just remove that unnecessary btrfs_release_path() call.

This change if part of a patchset that is comprised of the following
patches:

  1/6 btrfs: remove unnecessary leaf free space checks when pushing items
  2/6 btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
  3/6 btrfs: avoid unnecessary computation when deleting items from a leaf
  4/6 btrfs: remove constraint on number of visited leaves when replacing extents
  5/6 btrfs: remove useless path release in the fast fsync path
  6/6 btrfs: prepare extents to be logged before locking a log tree path

The last patch in the series has some performance test result in its
changelog.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1c8c8e826b7e..492dbc92d37e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4946,7 +4946,6 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
 
-	btrfs_release_path(path);
 	if (!ret)
 		ret = btrfs_log_prealloc_extents(trans, inode, path);
 	if (ret)
-- 
2.33.0

