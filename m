Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A256579414
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 09:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiGSHYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 03:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiGSHYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 03:24:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B632BA1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 00:24:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B72833A16
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658215470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l4FV/aVtTOYZPLSRv9GoMKFwl4RvvRpp6FRDRMUnRts=;
        b=KIJO2AlBTjfqjXPl8WGeK00nB42b88J61quGi2h19/OhfTxJ658JUz1P3udRhIOAHUvOJV
        Xyin83ogRkR3dPkhra3/eg1HNl/3RlLFNMCArRvOXx9Ga4l/+1YTbyjLxkLvUvx7QYvQ2D
        u9MVQvA9tGktfwDQv46VfoBbC4Xj8DU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 967C913488
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9xO0GC1c1mKvLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: scrub: make scrub uses less memory for metadata scrub
Date:   Tue, 19 Jul 2022 15:24:07 +0800
Message-Id: <cover.1658215183.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Changelog]
v2:
- Rebased to latest misc-next
  The conflicts are mostly from the member renaming.
  Has re-ran the tests on both aarch64 64K page size, and x86_64.
  For both scrub and replace groups.


Although btrfs scrub works for subpage from day one, it has a small
pitfall:

  Scrub will always allocate a full page for each sector.

This causes increased memory usage, although not a big deal, it's still
not ideal.

The patchset will change the behavior by integrating all pages into
scrub_block::pages[], instead of using scrub_sector::page.

Now scrub_sector will no longer hold a page pointer, but uses its
logical bytenr to caculate which page and page range it should use.

This behavior unfortunately still only affects memory usage on metadata
scrub, which uses nodesize for scrub.

For the best case, 64K node size with 64K page size, we waste no memory
to scrub one tree block.

For the worst case, 4K node size with 64K page size, we are no worse
than the existing behavior (still one 64K page for the tree block)

For the default case (16K nodesize), we use one 64K page, compared to
4x64K pages previously.

For data scrubing, we uses sector size, thus it causes no difference.
In the future, we may want to enlarge the data scrub size so that
subpage can waste less memory.

[PATCHSET STRUCTURE]
The first 3 patches are just cleanups, mostly to make scrub_sector
allocation much easier.

The 4th patch is to introduce the new page array for sblock, and
the last one to completely remove the usage of scrub_sector::page.

Qu Wenruo (5):
  btrfs: scrub: use pointer array to replace @sblocks_for_recheck
  btrfs: extract the initialization of scrub_block into a helper
    function
  btrfs: extract the allocation and initialization of scrub_sector into
    a helper
  btrfs: scrub: introduce scrub_block::pages for more efficient memory
    usage for subpage
  btrfs: scrub: remove scrub_sector::page and use scrub_block::pages
    instead

 fs/btrfs/scrub.c | 398 +++++++++++++++++++++++++++++++----------------
 1 file changed, 266 insertions(+), 132 deletions(-)

-- 
2.37.0

