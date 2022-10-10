Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965FC5F9CA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiJJKWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiJJKWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:22:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD76B148
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0835B80E7B
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EC7C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665397343;
        bh=bQ5BXv4b1YeupI82D3uR7H08CtSrS7TaFiKPSygsme8=;
        h=From:To:Subject:Date:From;
        b=KKmtKpwceUnr2ZPaUaGBkewiN2HaG/sWLQq2GYk2CdZ+LcrS9Q4o20Ad0g0z+EXKG
         fimg5Y3/t6omgjfS4sVQJ7LFEO8oFzd5akBkgHywt42D0z1eFBBHuPSHWjMOGymTPJ
         uVBiVlk742sYjJHlJ00NJ6oKZQqLRB5AL8Jm5W2/upKH9i5wyXEN5q4QbDp5VYl83U
         tFoTsRBXFq3GzVYt02gTj2RAUnQqJgVNSHQcJZZYIX957lmqjvL9yEnMZFL+WHx82J
         8ztLEdg0t/dGCI+ZUsOar/bmDBgXxQ9FVi+ZS7DGeSkOGpIHBSZiUs1mrnspuTuU5e
         8+G3PRxbmmzhA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/18] btrfs: fixes, cleanups and optimizations around fiemap
Date:   Mon, 10 Oct 2022 11:22:02 +0100
Message-Id: <cover.1665396437.git.fdmanana@suse.com>
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

The first two patches are bug fixes, the first one fixing a bug in backref
walking that has been around for 5 years, while the second one fixes a bug
introduced in this merge window.

The remaining are performance optimizations in the fiemap code path, as
well as some cleanups and refactorings to support them. Results and tests
are found in the changelogs of individual patches (05/18, 15/18, 17/18
and 18/18).

Filipe Manana (18):
  btrfs: fix processing of delayed tree block refs during backref walking
  btrfs: ignore fiemap path cache if we have multiple leaves for a data extent
  btrfs: get the next extent map during fiemap/lseek more efficiently
  btrfs: skip unnecessary extent map searches during fiemap and lseek
  btrfs: skip unnecessary delalloc search during fiemap and lseek
  btrfs: drop pointless memset when cloning extent buffer
  btrfs: drop redundant bflags initialization when allocating extent buffer
  btrfs: remove checks for a root with id 0 during backref walking
  btrfs: remove checks for a 0 inode number during backref walking
  btrfs: directly pass the inode to btrfs_is_data_extent_shared()
  btrfs: turn the backref sharedness check cache into a context object
  btrfs: move ulists to data extent sharedness check context
  btrfs: remove roots ulist when checking data extent sharedness
  btrfs: remove useless logic when finding parent nodes
  btrfs: cache sharedness of the last few data extents during fiemap
  btrfs: move up backref sharedness cache store and lookup functions
  btrfs: avoid duplicated resolution of indirect backrefs during fiemap
  btrfs: avoid unnecessary resolution of indirect backrefs during fiemap

 fs/btrfs/backref.c    | 462 ++++++++++++++++++++++++++++--------------
 fs/btrfs/backref.h    |  55 ++++-
 fs/btrfs/extent_io.c  |  68 +++----
 fs/btrfs/extent_map.c |  31 ++-
 fs/btrfs/extent_map.h |   2 +
 fs/btrfs/file.c       |  69 +++++--
 6 files changed, 462 insertions(+), 225 deletions(-)

-- 
2.35.1

