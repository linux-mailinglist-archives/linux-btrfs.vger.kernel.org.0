Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4A269A52A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 06:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBQFhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 00:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQFhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 00:37:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9205BDB0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 21:37:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00BCC3401D
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 05:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676612242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9gbQEBUL3AWvepX11HVWNN9gJ4WJ3tf1beqpQtsApM0=;
        b=W0yxet+SPexzTkdjLSDAiP+5dp0HnUJTR2c4wI7iLmGKp87UoAHow6xRSBCIiEiSFg6Ta6
        Y9RAd/k/YWuoRjkgQiSGRAi5C49GvjSIHtWAENpURbOwrhlTam/n9NDqES5VdgRYjryhrD
        w8czuXqRP4Moa0ex1NNZZ1dl1NL1Rss=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 564DB1323E
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 05:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kkldCJES72PTSQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 05:37:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: cleanup and small refactors around __btrfs_map_block()
Date:   Fri, 17 Feb 2023 13:36:57 +0800
Message-Id: <cover.1676611535.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series is based on the current misc-next branch, and can be fetched
from github:

  https://github.com/adam900710/linux/tree/map_block_refactor


This is the rebased and merged version of two patchset:

  btrfs: reduce div64 calls for __btrfs_map_block() and its variants
  btrfs: reduce the memory usage for btrfs_io_context, and reduce its variable sized members

Originally the 2nd patchset has some dependency on the first one, but
the first one is causing some conflicts with newer cleanups, thus only
the 2nd patchset get merged into for-next.

This updated version would resolve the conflicts, and use the modified
version from for-next.

Qu Wenruo (6):
  btrfs: remove map_lookup->stripe_len
  btrfs: reduce div64 calls by limiting the number of stripes of a chunk
    to u32
  btrfs: simplify the bioc argument for handle_ops_on_dev_replace()
  btrfs: reduce type width of btrfs_io_contexts
  btrfs: use a more space efficient way to represent the source of
    duplicated stripes
  btrfs: replace btrfs_io_context::raid_map with a fixed u64 value

 fs/btrfs/block-group.c            |  22 +-
 fs/btrfs/raid56.c                 |  68 ++++--
 fs/btrfs/scrub.c                  |  85 +++----
 fs/btrfs/tests/extent-map-tests.c |   1 -
 fs/btrfs/tree-checker.c           |  14 ++
 fs/btrfs/volumes.c                | 385 ++++++++++++++----------------
 fs/btrfs/volumes.h                |  79 +++++-
 include/trace/events/btrfs.h      |   2 +-
 8 files changed, 362 insertions(+), 294 deletions(-)

-- 
2.39.1

