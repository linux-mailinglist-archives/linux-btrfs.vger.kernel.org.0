Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D730366B7B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjAPHEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjAPHEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9B7EEB
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07B3E67470
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cDDotkJQDpIjWHRueH3H9sSRvepzLJkKm0V5o3jS7Vg=;
        b=AUYppykMYt9wx78X3GcA5dfxQpeoVNNVos+IrqYIOs/xARwrT55dSmT5JPq3DrUtqQqsat
        /YxjXDXNi0bs88iWRaac4wG9wcfn8L4s4RjszuNkjry/dsu45BtpzmUvzBDE2WWCBl2KU8
        mp06C0fxqLX65BKZJNJnnLi/pAlrV7o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6456A138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0oVXDAf3xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] btrfs: scrub: use a more reader friendly code to implement scrub_simple_mirror()
Date:   Mon, 16 Jan 2023 15:04:11 +0800
Message-Id: <cover.1673851704.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
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

This is the formal version of the previous PoC patchset "btrfs: scrub:
rework to get rid of the complex bio formshaping"

The idea is pretty straight-forward for scrub:

- Fetch the extent info and csum for the whole BTRFS_STRIPE_LEN range

- Read the full BTRFS_STRIPE_LEN range

- Verify the contents using the extent info and csum at endio time

- Wait for above BTRFS_STRIPE_LEN range read to finish.

- If we have failed sectors, read extra mirrors to repair them.

- If we have failed sectors, writeback the repaired ones.

- If we're doing dev-replace, writeback all good sectors to the target
  device.

Although the workflow is still mostly the same as the old scrub
infrastructure, the implementation goes submit-and-wait method.

Thus it provides a very straight-forward code basis:

		scrub_reset_stripe(stripe);
		ret = scrub_find_fill_first_stripe(extent_root, csum_root, bg,
				cur_logical, logical_end - cur_logical, stripe);
		stripe->physical = physical + stripe->logical - logical_start;
		scrub_throttle_dev_io(sctx, device, BTRFS_STRIPE_LEN);
		scrub_submit_read_one_stripe(stripe);
		wait_scrub_stripe(stripe);
		scrub_repair_one_stripe(stripe);
		scrub_write_repaired_sectors(sctx, stripe);
		scrub_report_stripe_errors(sctx, stripe);
		if (sctx->is_dev_replace)
			scrub_write_replace_sectors(sctx, stripe);
		cur_logical = stripe->logical + BTRFS_STRIPE_LEN;

Thus it covers all the core logic in one function.

By contrast the old code goes various workqueue, endio function jumps,
and extra bio formshaping.

Currently the patchset only covers profiles other than RAID56 parity
stripes.
Thus old infrastructure is still kept for RAID56 parity scrub usage.

But still the patchset is already large enough for review.

The current patchset can already pass all scrub and replace tests.

[BENCHMARK]

However there is a cost.
Since our block size is limited to 64K, it's much smaller block size
compared to the original one.

Thus for the worst case scenario (all data are continuous, and the
profiles is RAID0 for extra splits), the scrub performance got a 20%
drop:

Old:
 
 Duration:         0:00:19
 Total to scrub:   10.52GiB
 Rate:             449.50MiB/s

New:

 Duration:         0:00:24
 Total to scrub:   10.52GiB
 Rate:             355.86MiB/s

The benchmark is using an SATA SSD directly attached to the VM.

[NEED FEEDBACK]

Is 20% drop perf acceptable?

I have seen some customers asking for ways to slow down scrub,
but not to speed it up.
Thus I'm not sure if a native performance drop is a curse or a bless.

Any if needed, I can enlarge the block size by submitting multiple
stripes instead.
But in that case, we will need some extra code to do multiple stripe
scrub.

Qu Wenruo (11):
  btrfs: remove unused @path inside scrub_stripe()
  btrfs: remove @root and @csum_root arguments from
    scrub_simple_mirror()
  btrfs: scrub: use dedicated super block verification function to scrub
    one super block
  btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based
    interface
  btrfs: scrub: introduce a helper to find and fill the sector info for
    a scrub_stripe
  btrfs: scrub: introduce a helper to verify one metadata
  btrfs: scrub: introduce a helper to verify one scrub_stripe
  btrfs: scrub: introduce the repair functionality for scrub_stripe
  btrfs: scrub: introduce a writeback helper for scrub_stripe
  btrfs: scrub: introduce error reporting functionality for scrub_stripe
  btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe
    infrastructure

 fs/btrfs/file-item.c |    9 +-
 fs/btrfs/file-item.h |    3 +-
 fs/btrfs/raid56.c    |    2 +-
 fs/btrfs/scrub.c     | 1521 ++++++++++++++++++++++++++++++------------
 fs/btrfs/volumes.c   |   10 +-
 fs/btrfs/volumes.h   |    2 +
 6 files changed, 1111 insertions(+), 436 deletions(-)

-- 
2.39.0

