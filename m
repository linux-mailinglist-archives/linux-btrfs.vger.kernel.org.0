Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216A85421EF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiFHDR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 23:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349258AbiFHDOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 23:14:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A755812A98
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 17:35:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04C8321A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654648495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nuUrIZkjKRGvvi4HyOga0e4igSYR752S1oJqFNJuM3M=;
        b=YeNSlhkMlFuGJ1lbteZBnHmCY+QY2JFXBxDy1vlFBg71LtWqnWstjtOYCCwya6lSD7OVhv
        hMD7XfWPlVht0Icnz1L7UwV2P9Mhd/w584xfQ3wFqqPzIhvo9QhulLRWJngGyxo7YWr3Eb
        vMNc3Giuo5t1vOqK31/vO1j7pYkQXmU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A2B2137FA
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 82RYCa7un2LiHQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 00:34:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/5] btrfs: avoid unnecessary double loop usage in RAID56
Date:   Wed,  8 Jun 2022 08:34:31 +0800
Message-Id: <cover.1654648358.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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
v3:
- Fix a crash in btrfs/125
  This is caused by the 4th patch, which the original code is only
  iterating data sectors, but not touching P/Q stripes.
  This triggeres a BUG_ON().

v2:
- Fix a bug in the 2nd patch that @stripe_nsector should be used
  instead of @nr_sectors
  This can cause btrfs/157 crash reliably

There are a lot of call patterns used in RAID56 like this:

	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
			struct sector_ptr *sector;
			
			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
			/* Do something with the sector */
		}
	}

Such double for loop could cause problems for continue/break, as we have
to keep in mind which layer we're continuing or breaking out.

In fact, for most call sites, they are just iterating all the sectors in
their bytenr order.

Thus there is really no need to do such double for loop.

This patchset will convert all these unnecessary call sites to something
like this:

	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
	     total_sector_nr++) {
		struct sector_ptr *sector;

		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
		/* Do something with the sector */
	}

So we don't need to bother if the break/continue is for which layer, and
reduce one indent.

There are some cases that, we may want to skip the full stripe.
In that case, it can be done by modifying @total_sector_nr manually.

Since modifying the iterator is not a good practice, every time we do
that, there will be an ASSERT() (making sure we're the first sector),
and a comment on the fact we're skipping the whole stripe.

There are still call sites doing much smaller double loop, mostly for
cases that explicitly want to handling a vertical stripe.
For those call sites, just keep them as is.


Qu Wenruo (5):
  btrfs: avoid double for loop inside finish_rmw()
  btrfs: avoid double for loop inside __raid56_parity_recover()
  btrfs: avoid double for loop inside alloc_rbio_essential_pages()
  btrfs: avoid double for loop inside raid56_rmw_stripe()
  btrfs: avoid double for loop inside raid56_parity_scrub_stripe()

 fs/btrfs/raid56.c | 284 ++++++++++++++++++++++++----------------------
 1 file changed, 147 insertions(+), 137 deletions(-)

-- 
2.36.1

