Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E74A87BE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351897AbiBCPgv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 10:36:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36962 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351889AbiBCPgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 10:36:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F5E5B83425
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEDEC340E4
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643902608;
        bh=e5xak6WV1I8y77Q9iVar/OhrpTsRvbxA41wT3QluA0I=;
        h=From:To:Subject:Date:From;
        b=a1RwfiHyDQXvpVKWhX7SkXculD6p3gTfbzRiJzl+AHzHa119RtKEuP5uRNBnHWXc7
         dii2NFlHwXQ8ZfIzBqnl6HfMNLKTnY2MBvpaidxgqxiIkAEWBL9xb4u19d4IwH1zBr
         VUeu2eTqcx7b1SFkaDmH9Cpyj1/TAfHgGDW6fp2jcdQXwWH0ca5i6DVSjSY226H8Vx
         a14ol9BRTvie8kORF34g03P9txcbuEpyjiQLx5g+HxywWlQPF4qV7nmwx626ssiqxz
         ibWs7maubSRuCh8LuCvGhUQEPvA5tNnKOgSSk1cInp2W4gbItZ/YLKd3z6v70tnXBJ
         aHfA5PO4ZGr3w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: some misc cleanups and a fix around page reading
Date:   Thu,  3 Feb 2022 15:36:41 +0000
Message-Id: <cover.1643902108.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A small set of changes, mostly cleanups, a fix for an error that is not
being returned, and adding a couple lockdep assertions.

Filipe Manana (4):
  btrfs: stop checking for NULL return from btrfs_get_extent()
  btrfs: fix lost error return value when reading a data page
  btrfs: remove no longer used counter when reading data page
  btrfs: assert we have a write lock when removing and replacing extent
    maps

 fs/btrfs/extent_io.c              | 12 +++++-------
 fs/btrfs/extent_map.c             |  4 ++++
 fs/btrfs/inode.c                  |  9 +++++++--
 fs/btrfs/tests/extent-map-tests.c |  2 ++
 4 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.33.0

