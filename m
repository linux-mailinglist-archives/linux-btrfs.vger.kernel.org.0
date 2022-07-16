Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C2D576E78
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jul 2022 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiGPOLQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPOLP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 10:11:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFE13F20;
        Sat, 16 Jul 2022 07:11:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 084231FD7A;
        Sat, 16 Jul 2022 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657980673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=oWtSQ3iq/eBfO8cWY36mPzg837zTY4BQyIHIDxunfnc=;
        b=DqZIO+BtiutLzd0dvPdk4yLD73rbqsDwOsatqhzBZ1RKmm3RtkpUtNWqFqBnM6yDisUTyx
        4g/aUYH+eNv8qbhLCYwkcba0MaLXmgcrD4iLikMfB5MIvMBR3XGu+bUaHYt9RVRom4Pzmx
        YXRzq6mq6ZMO1pOvtUGBIEBxaw+SlrY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDFC81351D;
        Sat, 16 Jul 2022 14:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jqgrMQDH0mI6XgAAMHmgww
        (envelope-from <dsterba@suse.com>); Sat, 16 Jul 2022 14:11:12 +0000
Date:   Sat, 16 Jul 2022 16:06:20 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [GIT PULL] Btrfs fixes for 5.19-rc7
Message-ID: <cover.1657976305.git.dsterba@suse.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

due to a recent report [1] we need to revert the radix tree to xarray
conversion patches. There's a problem with sleeping under spinlock, when
xa_insert could allocate memory under pressure. We use GFP_NOFS so this
is a real problem that we unfortunately did not discover during review.

I'm sorry to do such change at rc6 time but the revert is IMO the safer
option, there are patches to use mutex instead of the spin locks but
that would need more testing.  The revert branch has been tested on a
few setups, all seem ok.  The conversion to xarray will be revisited in
the future.

[1] https://lore.kernel.org/linux-btrfs/cover.1657097693.git.fdmanana@suse.com/

Note about the xarray API:

The possible sleeping is documented next to xa_insert, however there's
no runtime check for that, like is eg. in radix_tree_preload.  The
context does not need to be atomic so it's not as simple as

  might_sleep_if(gfpflags_allow_blocking(gfp));

or

  WARN_ON_ONCE(gfpflags_allow_blocking(gfp));

Some kind of development time debugging/assertion aid would be nice.

----------------------------------------------------------------
The following changes since commit b3a3b0255797e1d395253366ba24a4cc6c8bdf9c:

  btrfs: zoned: drop optimization of zone finish (2022-07-08 19:18:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc7-tag

for you to fetch changes up to 088aea3b97e0ae5a2a86f5d142ad10fec8a1b80f:

  Revert "btrfs: turn delayed_nodes_tree into an XArray" (2022-07-15 19:15:19 +0200)

----------------------------------------------------------------
David Sterba (4):
      Revert "btrfs: turn fs_roots_radix in btrfs_fs_info into an XArray"
      Revert "btrfs: turn fs_info member buffer_radix into XArray"
      Revert "btrfs: turn name_cache radix tree into XArray in send_ctx"
      Revert "btrfs: turn delayed_nodes_tree into an XArray"

 fs/btrfs/ctree.h             |  18 ++---
 fs/btrfs/delayed-inode.c     |  84 ++++++++++----------
 fs/btrfs/disk-io.c           | 179 ++++++++++++++++++++++++-------------------
 fs/btrfs/extent-tree.c       |   2 +-
 fs/btrfs/extent_io.c         | 122 +++++++++++++++++------------
 fs/btrfs/inode.c             |  15 ++--
 fs/btrfs/send.c              |  40 +++++-----
 fs/btrfs/tests/btrfs-tests.c |  24 +++++-
 fs/btrfs/transaction.c       | 112 +++++++++++++++------------
 9 files changed, 340 insertions(+), 256 deletions(-)
