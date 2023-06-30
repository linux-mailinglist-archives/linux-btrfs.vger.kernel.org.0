Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE34743E32
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjF3PD6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjF3PD5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 11:03:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32CF3583
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 08:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B9336174C
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DA4C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688137434;
        bh=e1QJyFbIxMtLL1AMcEt/nhsr8uO6d2m6Au16WWZVwe4=;
        h=From:To:Subject:Date:From;
        b=mr0cRCHxxc8hrZHBBOArT1NP5qSo7ekst5sGAWrLEusgJfvCLdFYJdAMsH+Z0oTIx
         RY9VeY/1Lfb9LvCADZNBdfPvUvreAFR6KnL9C1isyLyng241Ctl/HDpoXATg6d1+rU
         +AGEgyAM/De5OW3fX3Mv5q8KiirJHSnpC+hrphzinMdmqHKwANejuTxXzJ8jf4l8mD
         JEQHkInailij+ikyspzgbqjOGPT6U7lTWAj9O1SwSmU2iSFSsmJDAY/91n/aa26t+0
         rV/2Nglg89O7rfOlZ8nYXhvZ513l07E2mJabOEM9Es6r3eYAEL68t8H8mIz1FDjlyo
         lxU7hdmqN2UKQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: remove a couple BUG_ON()s and cleanups
Date:   Fri, 30 Jun 2023 16:03:43 +0100
Message-Id: <cover.1688137155.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

The first patch removes  a couple unnecessary BUG_ON()'s, since all
callers are able to properly deal with errors, which are triggered by
syzbot with error injection (-ENOMEM). The rest are just some followup
cleanups. More details in the changelogs.

Filipe Manana (8):
  btrfs: remove BUG_ON()'s in add_new_free_space()
  btrfs: update documentation for add_new_free_space()
  btrfs: rename add_new_free_space() to btrfs_add_new_free_space()
  btrfs: make btrfs_destroy_marked_extents() return void
  btrfs: make btrfs_destroy_pinned_extent() return void
  btrfs: make find_first_extent_bit() return a boolean
  btrfs: open code trivial btrfs_add_excluded_extent()
  btrfs: move btrfs_free_excluded_extents() into block-group.c

 fs/btrfs/block-group.c      | 91 +++++++++++++++++++++++++------------
 fs/btrfs/block-group.h      |  4 +-
 fs/btrfs/dev-replace.c      |  6 +--
 fs/btrfs/disk-io.c          | 31 ++++---------
 fs/btrfs/extent-io-tree.c   | 14 +++---
 fs/btrfs/extent-io-tree.h   |  6 +--
 fs/btrfs/extent-tree.c      | 26 +----------
 fs/btrfs/extent-tree.h      |  3 --
 fs/btrfs/free-space-cache.c |  7 ++-
 fs/btrfs/free-space-tree.c  | 27 ++++++++---
 fs/btrfs/relocation.c       | 10 ++--
 fs/btrfs/transaction.c      |  8 ++--
 fs/btrfs/volumes.c          |  6 +--
 13 files changed, 124 insertions(+), 115 deletions(-)

-- 
2.34.1

