Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EDD68BB23
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBFLTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 06:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBFLTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 06:19:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979E9ECB
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 03:19:10 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03A2F21ACA
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675682349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uVb8aF5/EjwVL4EUVAuUE8kRcn0EhNWqvnhAzs9ePDM=;
        b=i8ENYQxXAL4lWq2olmWA50XLPhaj4F2/DQvP8twJff78tB6UzSeVKERsscSYqvrvsIO6vX
        yMaEgvvdtIn0/0bN/Ng81+Xug5/OOU8960l0AJ7BSnotJdvhFEH6dY9OiKlfptkLUsGsnJ
        PxBvMqAvQS+9Fq7ZKv0PL4GETwtXu0w=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B7458133A6
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 11:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qJ7BHivi4GMdKgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Feb 2023 11:19:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: reduce div64 calls for __btrfs_map_block() and its variants
Date:   Mon,  6 Feb 2023 19:18:47 +0800
Message-Id: <cover.1675681212.git.wqu@suse.com>
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

Changelog:
v3:
- Move more BTRFS_STRIPE_LEN_SHIFT cleanup to patch 1
- Use const_ilog2() to define BTRFS_STRIPE_LEN_SHIFT
- Introduce BTRFS_STRIPE_LEN_MASK to make offset calculation easier.
- Convert all "u64 stripe_nr" to "u32 stripe_nr"
  Previously there is one in get_raid56_logic_offset() not converted.

v2:
- Fix a linkage error for 32bits platform in block-group.c
  We have a line "stripe_nr = (stripe_nr * num_stripes + i) /
		  sub_stripes."
  In that case, @stripe_nr itself is already u64, thus the division
  is dividing u64 with u32.

  And we can not easily do a forced u32 conversion, as we only have
  ensured @stripe_nr can be contained in u32.
  Even with 10G chunk size in mined, if the RAID10 array has over 26
  devices, then we can overflow U32 and cause problems.

  For now, keeps the old div_u64 call.

Div64 is much slower than 32 bit division, and only get improved in
the most recent CPUs, that's why we have dedicated div64* helpers.

One usage of div64 is in __btrfs_map_block() and its variants, where we
got @stripe_nr as u64, and all later division has to go the div64
helpers.

But the truth is, with our current chunk size limit (10G) and fixed
stripe length (64K), we can have at most 160K stripes in a chunk, which
is small enough for u32 already.

So this patchset would reduce div64 calls by:

- Remove map_lookup::stripe_len first
  So now we don't need to call div64 to calculate @stripe_nr, just a
  simple right shift, then truncate to u32.

  This is a prerequisite for the 2nd patch, without the fixed stripe
  length, we have to rely on div64.

- Reduce the width of various @stripe_nr from u64 to u32

- Use regular division and modulo to do the calculation
  Now we can get rid of the fear that we missed some div64 helpers.


Qu Wenruo (2):
  btrfs: remove map_lookup->stripe_len
  btrfs: reduce div64 calls by limiting the number of stripes of a chunk
    to u32

 fs/btrfs/block-group.c            |  22 +++---
 fs/btrfs/scrub.c                  |  55 +++++++-------
 fs/btrfs/tests/extent-map-tests.c |   1 -
 fs/btrfs/tree-checker.c           |  14 ++++
 fs/btrfs/volumes.c                | 118 +++++++++++++++---------------
 fs/btrfs/volumes.h                |   6 +-
 6 files changed, 116 insertions(+), 100 deletions(-)

-- 
2.39.1

