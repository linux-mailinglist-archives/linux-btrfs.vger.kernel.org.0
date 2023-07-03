Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E974561F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGCHdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGCHdL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA06E78
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:32:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DBCE218FB
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fM11TM2Rj/G1Cxsuot/uvP+HT5akyagTKcxRF89MQoo=;
        b=by1qR4iwl5iTm9558NhSZEMkGb7H/vE+GMkOLjdOKhpyAQbNIwPhO86SwQKAMANgKKxgJF
        gdwlirMe+WjaN1L5G3KXCc0TnWCocUbr2LmT0oNkuwrFPXAck+GJT19yv0RAcWLV0KOat7
        ymyNZH1/OfTTalCdihPnq0wnkFYmryI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B66DE13276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +IWKH6h5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:32:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/14] btrfs: scrub: introduce SCRUB_LOGICAL flag
Date:   Mon,  3 Jul 2023 15:32:24 +0800
Message-ID: <cover.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
RFC->v1:
- Add RAID56 support
  Which is the biggest advantage of the new scrub mode.

- More basic tests around various repair situations

[REPO]
Please fetch from github repo:
https://github.com/adam900710/linux/tree/scrub_logical

This is based on David's misc-next, but still has one extra regression
fix which is not yet merged. ("btrfs: raid56: always verify the P/Q
contents for scrub")

[BACKGROUND]
Scrub originally works in a per-device basis, that means if we want to
scrub the full fs, we would queue a scrub for each writeable device.

This is normally fine, but some behavior is not ideal like the
following:
		X	X+16K	X+32K
 Mirror 1	|XXXXXXX|       |
 Mirror 2	|       |XXXXXXX|

When scrubbing mirror 1, we found [X, X+16K) has corruption, then we
will try to read from mirror 2 and repair using the correct data.

This applies to range [X+16K, X+32K) of mirror 2, causing the good copy
to be read twice, which may or may not be a big deal.

But the problem can easily go crazy for RAID56, as its repair requires
the full stripe to be read out, so is its P/Q verification, e.g.:

		X	X+16K	X+32K
 Data stripe 1	|XXXXXXX|       |	|	|
 Data stripe 2	|       |XXXXXXX|	|	|
 Parity stripe	|       |	|XXXXXXX|	|

In above case, if we're scrubbing all mirrors, we would read the same
contents again and again:

Scrub on mirror 1:
- Read data stripe 1 for the initial read.
- Read data stripes 1 + 2 + parity for the rebuild.

Scrub on mirror 2:
- Read data stripe 2 for the initial read.
- Read data stripes 1 + 2 + parity for the rebuild.

Scrub on Parity
- Read data stripes 1 + 2 for the data stripes verification
- Read data stripes 1 + 2 + parity for the data rebuild
  This step is already improved by recent optimization to use cached
  stripes.
- Read the parity stripe for the final verification

So for data stripes, they are read *five* times, and *three* times for
parity stripes.

[ENHANCEMENT]
Instead of the existing per-device scrub, this patchset introduce a new
flag, SCRUB_LOGICAL, to do logical address space based scrub.

Unlike per-device scrub, this new flag would make scrub a per-fs
operation.

This allows us to scrub the different mirrors in one go, and avoid
unnecessary read to repair the corruption.

This means, no matter what profile, they always read the same data just
once.

This also makes user space handling much simpler, just one ioctl to
scrub the full fs, without the current multi-thread scrub code.

[TODO]
- More testing
  Currently only done functional tests, no stress tests yet.

- Better progs integration
  In theory we can silently try SCRUB_LOGICAL first, if the kernel
  doesn't support it, then fallback to the old multi-device scrub.

  But for current testing, a dedicated option is still assigned for
  scrub subcommand.

  And currently it only supports full report, no summary nor scrub file
  support.

Qu Wenruo (14):
  btrfs: raid56: remove unnecessary parameter for
    raid56_parity_alloc_scrub_rbio()
  btrfs: raid56: allow scrub operation to update both P and Q stripes
  btrfs: raid56: allow caching P/Q stripes
  btrfs: raid56: add the interfaces to submit recovery rbio
  btrfs: add the ability to read P/Q stripes directly
  btrfs: scrub: make scrub_ctx::stripes dynamically allocated
  btrfs: scrub: introduce the skeleton for logical-scrub
  btrfs: scrub: extract the common preparation before scrubbing a block
    group
  btrfs: scrub: implement the chunk iteration code for scrub_logical
  btrfs: scrub: implement the basic extent iteration code
  btrfs: scrub: implement the repair part of scrub logical
  btrfs: scrub: add RAID56 support for queue_scrub_logical_stripes()
  btrfs: scrub: introduce the RAID56 data recovery path for scrub
    logical
  btrfs: scrub: implement the RAID56 P/Q scrub code

 fs/btrfs/disk-io.c         |    1 +
 fs/btrfs/fs.h              |   12 +
 fs/btrfs/ioctl.c           |    6 +-
 fs/btrfs/raid56.c          |  134 +++-
 fs/btrfs/raid56.h          |   17 +-
 fs/btrfs/scrub.c           | 1198 ++++++++++++++++++++++++++++++------
 fs/btrfs/scrub.h           |    2 +
 fs/btrfs/volumes.c         |   50 +-
 fs/btrfs/volumes.h         |   16 +
 include/uapi/linux/btrfs.h |   11 +-
 10 files changed, 1206 insertions(+), 241 deletions(-)

-- 
2.41.0

