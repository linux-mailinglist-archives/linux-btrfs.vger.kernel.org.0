Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED453B402
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 09:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiFBHHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 03:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiFBHHC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 03:07:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1725DA73
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 00:06:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F52C21B00
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654153616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TqiG7vr9e+QjZ/iqX1bexDgTWRgmcbpmAKq4uI+JZn8=;
        b=Putaxztt9MTXyhv5UBKM/rUaR/IoB3ALrDQ5bfsKDQ55LYRsOWSXcwpoGPrW3L1NlRvl2h
        LUMhPNODXqC18Tvo8D7cTQolIz0liakaokrupnX3NCOrwRMquRJLrRW706k8eckJOD0elR
        6VpjaQFTm202VqpntRaxUpinsIajfpA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AC8C134F3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pu1XD49hmGKSAgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 07:06:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: avoid unnecessary double loop usage in RAID56
Date:   Thu,  2 Jun 2022 15:06:32 +0800
Message-Id: <cover.1654153382.git.wqu@suse.com>
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

 fs/btrfs/raid56.c | 283 ++++++++++++++++++++++++----------------------
 1 file changed, 146 insertions(+), 137 deletions(-)

-- 
2.36.1

