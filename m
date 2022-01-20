Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF677494C5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 12:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiATLAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 06:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiATLAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 06:00:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD19C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 03:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01460B81D18
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7E1C340E0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642676414;
        bh=dZ+48oa1pUMpc34AIFcr24PEQFxEEjFLdS5irVo23ow=;
        h=From:To:Subject:Date:From;
        b=RPesOjZo9/fNHR66+o0hu+aAGSZX5ke7TjewY1p5n4W8iPCATN+qaEalZUhg5DC63
         opnCt54NrXOfQtzI2iWwQGGFvk5M6MCLDgGr99wX+OqEuf9XfyFWZJGJ5OaeufuWtQ
         7rV3b5o2LoVX1sYMjCK5WkslmIINgOD2i58uTM0o4sRLjNSWM7mvjiOyIO5f/FbILL
         cUAas/UNQHqQ85k+ocPQUlIn/lFkQHHRv75w4yOGRroY8+hliv519Fnho5e6pYMTmz
         5macP0NSHez3GseQ2gagCmOPSgbWnQnB8v10cKidFB8DKDMQbiPIvZF+Lwz5fsNqfr
         r6AR9l21V7E0g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: speedup and avoid inode logging during rename/link
Date:   Thu, 20 Jan 2022 11:00:05 +0000
Message-Id: <cover.1642676248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Often rename and link operations need to update inodes that were logged
before, and often they trigger inode logging when it's not possible to
quickly determine if the inode was previously logged in the current
transaction.

This patchset speedups renames either by updating more efficiently a
previously logged directory or by avoiding triggering inode logging when
not needed. This can make all the difference, specially before all the
recent massive optimizations to directory logging between 5.16, upcoming
5.17 and other other changes in misc-next.

An openSUSE Tumbleweed user recently ran into an issue where package
installation/upgrades with the zypper tool were very slow, and it turned
out zypper was spending over 99% of its time on rename operations, which
were doing directory logging, and some of the packages required renaming
over 1700 files. The issue only happened on a 5.15 kernel, and it was
indirectly caused by excessive inode eviction, happening almost 100x more
when compared to 5.13, 5.14 and 5.16-rc[6,7,8] kernels. That in turn
resulted in logging inodes during renames when that would not happen if
inode eviction hadn't happen. More details on the changelogs of patches
3/6 to 5/6.

Filipe Manana (6):
  btrfs: add helper to delete a dir entry from a log tree
  btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
  btrfs: avoid logging all directory changes during renames
  btrfs: stop doing unnecessary log updates during a rename
  btrfs: avoid inode logging during rename and link when possible
  btrfs: use single variable to track return value at btrfs_log_inode()

 fs/btrfs/inode.c    | 177 ++++++------------
 fs/btrfs/tree-log.c | 431 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/tree-log.h |   7 +-
 3 files changed, 364 insertions(+), 251 deletions(-)

-- 
2.33.0

