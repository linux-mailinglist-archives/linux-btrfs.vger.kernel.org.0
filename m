Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6410714CD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjE2PRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE2PRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50874C9
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D432B60B28
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BECC433EF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373435;
        bh=GsuanzErI+xFeVnvFPLP0FhQLGlZtnxe1/wDGLzioHQ=;
        h=From:To:Subject:Date:From;
        b=XTl5ajlo5917lybBu6rhpmuqzchMF1UQlsqShLUFcOcsyGE38taxeNJzYR/L8U7le
         GXdnXAtfZSXRqjv2DXlrbwFSMwRD5U3+ZOeYv+lDgEz7mdNIq3kA5HMc4OuhxMZoo7
         BDvHKuxf2zD1sbjA8ZgIJFZ9LsfPitT0aOSnbuAWsFLNOh2BZa1kP0m7s0yeTzO9L8
         InFyn6gqRjHYP5RmL1UH6rAXKzO+C7yEQIq4YPPFnaJzVV3dhsQ9V9Z+Rv12G9QB3z
         i4khPJs+EZzjT4k1/qnaMBsxAFFJhAdOIwjb/3HtF2GUcTLaTnVoBEZJbFNFR64vQ+
         sGh90rcKaXDbw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] btrfs: some delayed refs optimizations and cleanups
Date:   Mon, 29 May 2023 16:16:56 +0100
Message-Id: <cover.1685363099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This brings an optimization for delayed ref heads and several cleanups.
These come out while doing some other work around delayed refs, but as
these are independent of that other work, and trivial, I'm sending these
out separately. More details on the changelogs.

Filipe Manana (11):
  btrfs: reorder some members of struct btrfs_delayed_ref_head
  btrfs: remove unused is_head field from struct btrfs_delayed_ref_node
  btrfs: remove pointless in_tree field from struct btrfs_delayed_ref_node
  btrfs: use a bool to track qgroup record insertion when adding ref head
  btrfs: make insert_delayed_ref() return a bool instead of an int
  btrfs: get rid of label and goto at insert_delayed_ref()
  btrfs: assert correct lock is held at btrfs_select_ref_head()
  btrfs: use bool type for delayed ref head fields that are used as booleans
  btrfs: use a single switch statement when initializing delayed ref head
  btrfs: remove unnecessary prototype declarations at disk-io.c
  btrfs: make btrfs_destroy_delayed_refs() return void

 fs/btrfs/delayed-ref.c | 110 ++++++++++++++++++++---------------------
 fs/btrfs/delayed-ref.h |  25 +++++-----
 fs/btrfs/disk-io.c     |  19 ++-----
 fs/btrfs/extent-tree.c |  11 ++---
 4 files changed, 77 insertions(+), 88 deletions(-)

-- 
2.34.1

