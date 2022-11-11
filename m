Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01C86259CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiKKLuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiKKLum (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC11818E09
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C32EB82510
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C1FC433D6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167439;
        bh=QSGKGKlaNBMFdl9uEUEJk77blfNSOVcmsoEQ7u9Wddw=;
        h=From:To:Subject:Date:From;
        b=Ijhz+nobRazpQVXuEw3xKoBXx/viLBRpm37YNnGWX4cZ579xMKK9VMpmj04DXDltY
         eX0/elrTo8sQdfEefjZ+E4vGAf6ywdf2TUCI0W6J6NxHNqoCrzdoXhUC5hNmMv/ug4
         9zDDjcAXb7+vvAYCyRfIakFq5vu/gtCn1zxY8tFd/IjzzgnPnuXRk66rNWWKxVhrIr
         +jjjAaR1134Z75pSP2m7s/kuCjreCgHXacowgIXFK4bQ0SLwXoAfuaXpx/qUXFGTFF
         b8bV7dT141fCVgpJdLJIc6vV+p1+EsCbC3bAimUO0apGnta9yfbj9QscpBqsstOsms
         OTduM7E9+P20w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Date:   Fri, 11 Nov 2022 11:50:26 +0000
Message-Id: <cover.1668166764.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Here follows a few more optimizations for lseek and fiemap. Starting with
coreutils 9.0, cp no longer uses fiemap to determine where holes are in a
file, instead it uses lseek's SEEK_HOLE and SEEK_DATA modes of operation.
For very sparse files, or files with lot of delalloc, this can be very
slow (when compared to ext4 or xfs). This aims to improve that.

The cp pattern is not specific to cp, it's common to iterate over all
allocated regions of a file sequentially with SEEK_HOLE and SEEK_DATA,
for either the whole file or just a section. Another popular program that
does the same is tar, when using its --sparse / -S command line option
(I use it like that for doing vm backups for example).

The details are in the changelogs of each patch, and results are on the
changelog of the last patch in the series. There's still much more room
for further improvement, but that won't happen too soon as it will require
broader changes outside the lseek and fiemap code.

Filipe Manana (9):
  btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
  btrfs: add an early exit when searching for delalloc range for lseek/fiemap
  btrfs: skip unnecessary delalloc searches during lseek/fiemap
  btrfs: search for delalloc more efficiently during lseek/fiemap
  btrfs: remove no longer used btrfs_next_extent_map()
  btrfs: allow passing a cached state record to count_range_bits()
  btrfs: update stale comment for count_range_bits()
  btrfs: use cached state when looking for delalloc ranges with fiemap
  btrfs: use cached state when looking for delalloc ranges with lseek

 fs/btrfs/ctree.h          |   1 +
 fs/btrfs/extent-io-tree.c |  73 +++++++++++--
 fs/btrfs/extent-io-tree.h |  10 +-
 fs/btrfs/extent_io.c      |  30 +++---
 fs/btrfs/extent_map.c     |  29 -----
 fs/btrfs/extent_map.h     |   2 -
 fs/btrfs/file.c           | 221 ++++++++++++++++++--------------------
 fs/btrfs/file.h           |   1 +
 fs/btrfs/inode.c          |   2 +-
 9 files changed, 190 insertions(+), 179 deletions(-)

-- 
2.35.1

