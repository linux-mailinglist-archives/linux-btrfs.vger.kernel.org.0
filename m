Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61186A8BB0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCBWZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCBWZE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531101A943
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC97022379
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 22:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N/83Ky0we0kSAhfL0L+Fkza+ehkjknBgdlr8OZVmNcQ=;
        b=noRX4j1EKaX6zSuxz6RMCaCpiZtukwyHdGZyegKasxiDwc+fZZu4BbYQJcf6EQ/4Tzuy69
        heJRkHU9pebizlXls2VdPCtUQavOoB5dclf6DQkX5+yIiNqFILf3ryPzalIpWvuQ8JLhRs
        B1rgx3MjsCW+RaP4R3iQLnzl0WyJQag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N/83Ky0we0kSAhfL0L+Fkza+ehkjknBgdlr8OZVmNcQ=;
        b=0wLikaiJN2r6OhHEKGD6+vWghbEZlxld6yg/bVBL4RVgQlpN6UYS4vmL6wq3TPxL5LH4r9
        Th7Xzz98u8Jt+rDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 970B213349
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 22:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NNMDHTwiAWR6SQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Mar 2023 22:25:00 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/21] Lock extents before pages
Date:   Thu,  2 Mar 2023 16:24:45 -0600
Message-Id: <20230302222506.14955-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.39.2
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

The main idea is that instead of handling extent locks per page, lock
the extents before handling the pages. This will help in calling iomap
functions from within extent locks, so all page/folio handling is
performed by iomap code.

The patch "debug extent locking" was added to debug this code to check
where the locks were initiated in case of deadlock. No need to add
this patch.

Changes since v1:
 - qgroup flush reversal, instead pass nowait=true and handle
   qgroup flush if qgroup reservations return EDQUOT
 - relocation - locking extents before pages
 - async code locking fix: async code deadlocked because parallel
   writebacks could set HAS_ASYNC_EXTENTS flag while other thread was
   performing a sync writeback. This required re-writing the async writeback
   path
 - incorporated lock range checks using WARN_ON(), though I must
   admit locking during truncate still looks ugly
 - added readahead_begin() for locking extents before calling readahead()
   since readahead is called with pages locked.

Goldwyn Rodrigues (21):
  fs: readahead_begin() to call before locking folio
  btrfs: add WARN_ON() on incorrect lock range
  btrfs: Add start < end check in btrfs_debug_check_extent_io_range()
  btrfs: make btrfs_qgroup_flush() non-static
  btrfs: Lock extents before pages for buffered write()
  btrfs: wait ordered range before locking during truncate
  btrfs: lock extents while truncating
  btrfs: no need to lock extent while performing invalidate_folio()
  btrfs: lock extents before folio for read()s
  btrfs: lock extents before pages in writepages
  btrfs: locking extents for async writeback
  btrfs: lock extents before pages - defrag
  btrfs: Perform memory faults under locked extent
  btrfs: writepage fixup lock rearrangement
  btrfs: lock extent before pages for encoded read ioctls
  btrfs: lock extent before pages in encoded write
  btrfs: btree_writepages lock extents before pages
  btrfs: check if writeback pages exist before starting writeback
  btrfs: lock extents before pages in relocation
  btrfs: Add inode->i_count instead of calling ihold()
  btrfs: debug extent locking

 fs/btrfs/compression.c       |   9 +-
 fs/btrfs/defrag.c            |  48 +---
 fs/btrfs/disk-io.c           |  28 ++-
 fs/btrfs/extent-io-tree.c    |  32 +--
 fs/btrfs/extent-io-tree.h    |  46 ++--
 fs/btrfs/extent_io.c         |  74 +-----
 fs/btrfs/extent_io.h         |   2 +
 fs/btrfs/extent_map.c        |   2 +-
 fs/btrfs/file.c              | 100 +++-----
 fs/btrfs/free-space-cache.c  |   2 +-
 fs/btrfs/inode.c             | 431 ++++++++++++++++++-----------------
 fs/btrfs/ordered-data.c      |   8 +-
 fs/btrfs/ordered-data.h      |   3 +-
 fs/btrfs/qgroup.c            |   6 +-
 fs/btrfs/qgroup.h            |   1 +
 fs/btrfs/relocation.c        |  44 ++--
 include/linux/fs.h           |   1 +
 include/trace/events/btrfs.h |  18 +-
 mm/readahead.c               |   3 +
 19 files changed, 397 insertions(+), 461 deletions(-)

-- 
2.39.2


