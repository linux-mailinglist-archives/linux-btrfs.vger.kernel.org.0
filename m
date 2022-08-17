Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3842C596D7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiHQLXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiHQLW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:22:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AC069F6A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EDFDB81CD1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D2C433D6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735374;
        bh=/Z1LiLaL4deSZoiS//l9bnf7pNilCu+r3EGBPQkyUa4=;
        h=From:To:Subject:Date:From;
        b=GxRDCPWVsOyeHpwdgWFNVriu8rn6542puupbadeOe9OX+41t3vNdVQ7AXRubWv6To
         U/HDziRI41fyqrR8JrhI70UVQ4pNmJ9zaV6n1PElhfh8XtYtqjuSL7pkqPCvURixNY
         K5wUwcjwExUs0UpXZ2IFg7YVmPcNUMyAgiJYzsMsCbyfwtc0caUn05w1j5mE19vzaS
         JPTE4YShH3SdsH1AvwTHiaE8VTJ8LyYk+KYOE6CYi9Hpd+91uOItZHG3pKgV4q2gAN
         yWVTnEVofhRUaB7uGGuk2RTP41Xg2AGp6g7yHDFVRXanDQiWlgpNuCdQfue4vH/a9N
         JauVM3Dj2rhiA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/15] btrfs: some updates to delayed items and inode logging
Date:   Wed, 17 Aug 2022 12:22:33 +0100
Message-Id: <cover.1660735024.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

This patchset brings some optimizations to inode logging, especially for
logging directories, but also when logging a regular file that happens to
have the name of another file that was previously deleted in the current
transaction (triggered very often by the workloads simulated by dbench).
It brings along some cleanups to delated items and logging in general too.
More details in the changelogs of the patches. Thanks.

Filipe Manana (15):
  btrfs: don't drop dir index range items when logging a directory
  btrfs: remove the root argument from log_new_dir_dentries()
  btrfs: update stale comment for log_new_dir_dentries()
  btrfs: free list element sooner at log_new_dir_dentries()
  btrfs: avoid memory allocation at log_new_dir_dentries() for common
    case
  btrfs: remove root argument from btrfs_delayed_item_reserve_metadata()
  btrfs: store index number instead of key in struct btrfs_delayed_item
  btrfs: remove unused logic when looking up delayed items
  btrfs: shrink the size of struct btrfs_delayed_item
  btrfs: search for last logged dir index if it's not cached in the
    inode
  btrfs: move need_log_inode() to above log_conflicting_inodes()
  btrfs: move log_new_dir_dentries() above btrfs_log_inode()
  btrfs: log conflicting inodes without holding log mutex of the initial
    inode
  btrfs: skip logging parent dir when conflicting inode is not a dir
  btrfs: use delayed items when logging a directory

 fs/btrfs/delayed-inode.c |  329 +++++-----
 fs/btrfs/delayed-inode.h |   36 +-
 fs/btrfs/file.c          |    1 +
 fs/btrfs/tree-log.c      | 1337 ++++++++++++++++++++++++++------------
 fs/btrfs/tree-log.h      |    6 +
 5 files changed, 1146 insertions(+), 563 deletions(-)

-- 
2.35.1

