Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D087D674C8F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 06:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjATFhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 00:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjATFgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D304DCC2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D00B1B82714
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F86C433EF
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157174;
        bh=PUkXFO0vkBMmkKAioTgVadC6subhRz0l5q6u8bdK+AY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XTgb7xRYqnfWOkro2kEjQMtoIlqo9MYzUjfa95RL5DoyuKfOdAngF0E7ufRAdUyXp
         WKkpKUxJyWyuhbTT1bj03KCx12Dx7cxbIyu+ZpzYwYBo/StQ4QW2xR9vCvvviLZUiy
         2nuLbmu4C2xdJg39Rgle4VAOQiZpoZL/fInRfHP9L9c7ntgPRhQGfgfGylXDe0BNr4
         aqmWEMM7vJyD6Goz1O59XKUwUELnE9IRDumSV5ReHe1b/2nobz9H/ecCiJCn7H6mW8
         6Nkmdt1ae/ysRScgjgrOQcZcldywpzifDUtaykucDbLGzILueHl7Wh6t7PT6GU/tYD
         ZsN3pOLqo4Ukw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/18] btrfs: some optimizations for send
Date:   Thu, 19 Jan 2023 19:39:12 +0000
Message-Id: <cover.1674157020.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673436276.git.fdmanana@suse.com>
References: <cover.1673436276.git.fdmanana@suse.com>
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

V2: Dropped the patch that added the use of MT_FLAGS_LOCK_EXTERN,
    it turns out it does not work how I expected it to, see:
    https://lore.kernel.org/linux-btrfs/20230119151929.GA29005@lst.de/

Filipe Manana (18):
  btrfs: send: directly return from did_overwrite_ref() and simplify it
  btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
  btrfs: send: directly return from will_overwrite_ref() and simplify it
  btrfs: send: avoid extra b+tree searches when checking reference overrides
  btrfs: send: remove send_progress argument from can_rmdir()
  btrfs: send: avoid duplicated orphan dir allocation and initialization
  btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
  btrfs: send: reduce searches on parent root when checking if dir can be removed
  btrfs: send: iterate waiting dir move rbtree only once when processing refs
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

