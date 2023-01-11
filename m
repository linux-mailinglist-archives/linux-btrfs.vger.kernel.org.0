Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071E0665A57
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjAKLjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbjAKLjC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C6AE4C
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2120B819EF
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C07C433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436983;
        bh=4RYtqwquwGZSYRXB7So8iNQgGGlwTvKWawMqNawnwQ0=;
        h=From:To:Subject:Date:From;
        b=CmgU0wfB+4C+fEZtM0nS/MeCJmdo7k0XexdgSxEBRXY5mdkslPA7ZdFaahEO2ZYw+
         ypllPTQ5F/P7GeSm2K0VWnFnNq83/GioRu6CiKrGPZyUjZTJDEfdh4vs9hIUznwbuM
         6TXIG/cVMfPTDfLNYeUu+x8rRxgBAhAeZ9b9qibM8Y4iNjJkY6TtVa0mRDkN4GwPwf
         x9em4EQP4DJJGxuYE9/OEeyTfzZYQOPg3YM6rxeFchhLReFeA9S8QI2CK2mNGLAwf6
         2qtZGfRM8vGDcs1atb2P662Itv9e5RNTZnLpPa4dTZR4d3kIXS9xu2fOO4zJQwlWNF
         1GxiSe570fDRw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/19] btrfs: some optimizations for send
Date:   Wed, 11 Jan 2023 11:36:01 +0000
Message-Id: <cover.1673436276.git.fdmanana@suse.com>
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

This adds some optimizations for send and some cleanups, mostly around
processing directories. Some of the cleanups are independent.

More details in the individual changelogs, and the last one contains
results for a performance test.

Filipe Manana (19):
  btrfs: send: directly return from did_overwrite_ref() and simplify it
  btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
  btrfs: send: directly return from will_overwrite_ref() and simplify it
  btrfs: send: avoid extra b+tree searches when checking reference overrides
  btrfs: send: remove send_progress argument from can_rmdir()
  btrfs: send: avoid duplicated orphan dir allocation and initialization
  btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
  btrfs: send: reduce searches on parent root when checking if dir can be removed
  btrfs: send: iterate waiting dir move rbtree only once when processing refs
  btrfs: send: use MT_FLAGS_LOCK_EXTERN for the backref cache maple tree
  btrfs: send: initialize all the red black trees earlier
  btrfs: send: genericize the backref cache to allow it to be reused
  btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
  btrfs: send: cache information about created directories
  btrfs: allow a generation number to be associated with lru cache entries
  btrfs: add an api to delete a specific entry from the lru cache
  btrfs: send: use the lru cache to implement the name cache
  btrfs: send: update size of roots array for backref cache entries
  btrfs: send: cache utimes operations for directories if possible

 fs/btrfs/Makefile    |   3 +-
 fs/btrfs/lru_cache.c | 163 +++++++++++
 fs/btrfs/lru_cache.h |  80 ++++++
 fs/btrfs/send.c      | 645 ++++++++++++++++++++++---------------------
 4 files changed, 572 insertions(+), 319 deletions(-)
 create mode 100644 fs/btrfs/lru_cache.c
 create mode 100644 fs/btrfs/lru_cache.h

-- 
2.35.1

