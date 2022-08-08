Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18858C2F6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 07:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiHHFqK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 01:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHHFqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 01:46:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD5DFD5
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 22:46:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8236E1FE75
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659937561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=omkubcNeZtOEWPeheUm/aALe9RIEwG6+FzQSyJvr5ZU=;
        b=lF3GxE8tKgrs3M10oecPkodTspLfdqq7S6mQIxlkliMaMB0MK7syeTeUPBXUK9BrvJsuCB
        Ky46JMsziF02WI2hKPyCDgm46m+HvRp7WYvezPZrw6OaEpVW7x31uw+Fz8ajREjSWuEsyE
        sIQJJMyhahvmz9Wf2tdVt3vGqD7Kv6o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBF2613523
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 05:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TBx6KRij8GJpfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 05:46:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/7] btrfs: scrub: changes to reduce memory usage for both regular and subpage sectorsize.
Date:   Mon,  8 Aug 2022 13:45:36 +0800
Message-Id: <cover.1659936510.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Changelog]
v3:
- Move various members from scrub_sector to scrub_block
  This reduce memory usage as now those members are per-block instead of
  per-sector.

- Enlarge blocksize for data extent scrub
  This will greatly benefit from above change.

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

And since we're here, also move several members from scrub_sector to
scrub_block, and further enlarge the blocksize for data extent scrub.

[MEMORY USAGE CHANGE]

For 4K page systems
The memory usage for scrubbing a 16KiB metadata is:

Old:	240 + 4 * 128 = 752
New:	408 + 4 * 96  = 792
Diff:			+5.3%

This is a slight memory usage increase due to the extra page pointer
array.

The memory usage for scrubbing a 64KiB data is (the best case):
Old:   16 * (240 + 128) = 5888
New:   480 + 16 * 96    = 1944
Diff:			  -67.0%

In this case, the reduce in memory usage is awesome, almost cut 2/3 of
the memory.

The memory usage for scrubbing a 4KiB data is (the worst case):
Old    240 + 128 = 368
New:   408 + 96  = 504
Diff:		   +37.0%

The memory usage for scrubbing a 8KiB data is:
Old:   2 * (240 + 128) = 736
New:   480 + 2 * 96    = 672
Diff:			 -8.7%

So as long as the extent is larger than 4KiB, the new patchset will use
less memory usage, and the larger extent is, the better.

This is especially good as btrfs by default inline small (<=2K) data
extents, thus we have much higher chance to larger data extents.

[PATCHSET STRUCTURE]
The first 3 patches are just cleanups, mostly to make scrub_sector
allocation much easier.

The 4th patch is to introduce the new page array for sblock, and
the 5th one to completely remove the usage of scrub_sector::page.

The last two are optimizations for both regular and subpage cases.

Qu Wenruo (7):
  btrfs: scrub: use pointer array to replace @sblocks_for_recheck
  btrfs: extract the initialization of scrub_block into a helper
    function
  btrfs: extract the allocation and initialization of scrub_sector into
    a helper
  btrfs: scrub: introduce scrub_block::pages for more efficient memory
    usage for subpage
  btrfs: scrub: remove scrub_sector::page and use scrub_block::pages
    instead
  btrfs: scrub: move logical/physical/dev/mirror_num from scrub_sector
    to scrub_block
  btrfs: use larger blocksize for data extent scrub

 fs/btrfs/scrub.c | 546 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 353 insertions(+), 193 deletions(-)

-- 
2.37.0

