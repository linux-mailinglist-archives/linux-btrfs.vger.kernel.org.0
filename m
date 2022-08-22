Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6530259BDD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiHVKvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiHVKvt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391162F671
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2C8860FFB
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FEAC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165508;
        bh=uwBCYr1fEEB0DcXu0IFkIak5LJb2SRGdAwBOtwnP1Dw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OF8culDeQpm7DD6L3ZHJoPIXNshVWumsVOtaPswGSWztaUKAB0zZ44tUsdBSXVTpG
         7N60qIsBPtoPSGPEfT1yWjchGcZ+SiKvHvxlPYXCVCBsk9IC2hegeMRJaXdYWA3yo+
         D0rcJnuc7YzeZVU5V7g9F8qRW3uWBH6nTeTDYG1t61emYx6cwAh7943bkhmdh6T6k8
         bHpOuV5MaVfdoadTQaUe4MmXxkTp5v9w0KA2Jgk3faW5my1kUJtfuacIIrIvOzcnsQ
         GPHadA3ycKWkG0nCSMslKY651dq+w4AsY0oWCMDZHBF8/K5tOjlFdYJf1bhY8j/T5F
         d7s/XALeiTl9A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/15] btrfs: some updates to delayed items and inode logging
Date:   Mon, 22 Aug 2022 11:51:29 +0100
Message-Id: <cover.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
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

V2: Updated patch 10/15, added some comments and removed some code made
    obsolete by it.
    Updated patch 15/15 to make sure recursion of btrfs_log_inode() is
    bounded to happen at most once when we have new subdirectories.

Filipe Manana (15):
  btrfs: don't drop dir index range items when logging a directory
  btrfs: remove the root argument from log_new_dir_dentries()
  btrfs: update stale comment for log_new_dir_dentries()
  btrfs: free list element sooner at log_new_dir_dentries()
  btrfs: avoid memory allocation at log_new_dir_dentries() for common case
  btrfs: remove root argument from btrfs_delayed_item_reserve_metadata()
  btrfs: store index number instead of key in struct btrfs_delayed_item
  btrfs: remove unused logic when looking up delayed items
  btrfs: shrink the size of struct btrfs_delayed_item
  btrfs: search for last logged dir index if it's not cached in the inode
  btrfs: move need_log_inode() to above log_conflicting_inodes()
  btrfs: move log_new_dir_dentries() above btrfs_log_inode()
  btrfs: log conflicting inodes without holding log mutex of the initial inode
  btrfs: skip logging parent dir when conflicting inode is not a dir
  btrfs: use delayed items when logging a directory

 fs/btrfs/delayed-inode.c |  292 +++++---
 fs/btrfs/delayed-inode.h |   34 +-
 fs/btrfs/file.c          |    1 +
 fs/btrfs/tree-log.c      | 1418 ++++++++++++++++++++++++++------------
 fs/btrfs/tree-log.h      |    8 +
 5 files changed, 1197 insertions(+), 556 deletions(-)

-- 
2.35.1

