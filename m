Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B04FF9ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiDMPXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbiDMPXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:23:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB9E0D2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B0EFB82367
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D382C385A3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649863246;
        bh=oirIgyagpFWDdhJ6P5D71jof+XLSCqFuagADEe6Zlew=;
        h=From:To:Subject:Date:From;
        b=So3gQfyLI/7A6EDrTyf5i4rKikCAeV2GqOnuCK5ZSsQK4y+iS9GlyS8OL1qAMxARj
         oXrwYWvas8mIyBTHy0Mh1t0ejM+gFmPVCfcRcwU74JQEEeO0Gf7wDdH0kZ6mvPISXP
         7/mEyKFYujZmrVlgQlGWUVVYFAK/orVC0qlnJSm7gZjCccuHscuLHtvketRR7AICoJ
         I+1efK5FMs/cENp8t+9RWuQtl5/Iv3CzPERnJNpjIJUU2GuMGua9koeXLM/tfCBbFD
         DGQMBwNeL4IB3DqliVoNORfqQP7DPWH2vM4NRqOdpkaycMoiV2gXXHCEUpcphiatCl
         h8fXbwnbHxNlA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: avoid some block group rbtree lock contention
Date:   Wed, 13 Apr 2022 16:20:38 +0100
Message-Id: <cover.1649862853.git.fdmanana@suse.com>
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

This patchset allows for better concurrency when accessing the red black
tree of block groups, which is used very frequently and most accesses are
read-only, as well as avoid some unnecessary searches in the tree during
NOCOW writes. Details in the changelogs.

Filipe Manana (5):
  btrfs: remove search start argument from first_logical_byte()
  btrfs: use rbtree with leftmost node cached for tracking lowest block group
  btrfs: use a read/write lock for protecting the block groups tree
  btrfs: return block group directly at btrfs_next_block_group()
  btrfs: avoid double search for block group during NOCOW writes

 fs/btrfs/block-group.c      | 130 ++++++++++++++++++++----------------
 fs/btrfs/block-group.h      |   5 +-
 fs/btrfs/ctree.h            |   5 +-
 fs/btrfs/disk-io.c          |   5 +-
 fs/btrfs/extent-tree.c      |  29 ++++----
 fs/btrfs/free-space-cache.c |   2 +-
 fs/btrfs/free-space-tree.c  |   2 +-
 fs/btrfs/inode.c            |  26 +++++---
 fs/btrfs/transaction.c      |   4 +-
 9 files changed, 114 insertions(+), 94 deletions(-)

-- 
2.35.1

