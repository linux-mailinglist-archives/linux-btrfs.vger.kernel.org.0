Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C536B68B3A7
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 02:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBFBKa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Feb 2023 20:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFBK3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 20:10:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C412059
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 17:10:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56F745FE91
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675645826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=t9fI0b/RpsjWEliHA83ApaMhdjNM/8z7PnjgJj/pFuU=;
        b=B6rTtLYTsjMvvK8XQ3E88ND9SOeH47iBurTXj/k0bdoCmDnTTBjES8fRD7nIfypghXDdmQ
        2/HnsWk4INylCUqvpKaqSDxAvs5Wlg0O3z57Y7WRV6ekkcWp9ge/b5muzUt7OatEL+4NOE
        SRr4UfgvLcsrG3kn+1fjNZRBkKZWGQM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C326D138E7
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 01:10:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +WrwJIFT4GNRcwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Feb 2023 01:10:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: reduce div64 calls for __btrfs_map_block() and its variants
Date:   Mon,  6 Feb 2023 09:10:06 +0800
Message-Id: <cover.1675645730.git.wqu@suse.com>
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

- Reduce the width of various @stripe_nr to 32

- Use regular divitsion and module to do the calculation
  Now we can get rid of the fear that we missed some div64 helpers.
  

Qu Wenruo (2):
  btrfs: remove map_lookup->stripe_len
  btrfs: reduce div64 calls by limiting the number of stripes of a chunk
    to u32

 fs/btrfs/block-group.c            |  22 +++---
 fs/btrfs/scrub.c                  |  43 ++++++------
 fs/btrfs/tests/extent-map-tests.c |   1 -
 fs/btrfs/tree-checker.c           |  14 ++++
 fs/btrfs/volumes.c                | 110 +++++++++++++++---------------
 fs/btrfs/volumes.h                |   7 +-
 6 files changed, 106 insertions(+), 91 deletions(-)

-- 
2.39.1

