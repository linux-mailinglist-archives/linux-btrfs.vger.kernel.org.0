Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B24EA9E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiC2I57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiC2I56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 04:57:58 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220A190B50
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 01:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648544175; x=1680080175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7r3bFulFm5HSh5ZEEaTNtvYgAFmtlq20nh1R3oOQicw=;
  b=pXb5TkYsc0aQ/8K9+KbFg0lsole7Vznigzz8T6fvuaZjeMI/Jgc6AJNL
   rKWuk3OgGYWjhmVArjAAE6PThqa3Nb6R6k+9UHqk1IlOou/BjK1BWLpn7
   gVDKJiOls5OGp9V8aUUp9fYxY58TQGZf+lHev60Cah5/QqDBsnx1t9awa
   HNN/Ays4djTrYxCQ/XrjPrFpu8f9sjRqM3N6O5oE6qtnOdgxlr1+r/efg
   p7WeNbyR9ngdYrI1tV86b0NNdcXOlapEi294abOF0svplFtmPG8fTQ9EZ
   9oTJd/6MDl+SOsbfXCrp+wno+H1aphe9rqi8KOQQLfZclfCldup1y3BZK
   g==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="308481644"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:56:15 +0800
IronPort-SDR: ESowbTtWTOQHLGwzYkAtHUorD4SE/CuevBB0PAFe379edVUFdMC4eBI8lCqD2gCVU/uVj0I9S6
 RcBh5QD7R4eA1lehZN/02GScTJXVNwbgM3lU7wlZ4pHfdfhbuzjc86urM/TeGFt7zucd3PKTVU
 rDLkSXvFz0on4ihJiiQtnodzGSjCpoanQu5vJkejcZ+fy2UzJ4is2UW241FHOgXbvFuMAJPNNv
 pKLZ1TJCCMFbBiKChUsS14yJE/IibSkh6qTlScPQ69w+zE1hgBqiRQSziDeMaYlr/m11L7wUXD
 9cyKt1LW8u9aaeZLMmIkaE1w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 01:27:59 -0700
IronPort-SDR: P3ScKWfspW8eAnqzkGvF+GSfMlmri6/cAUxzmS7rhPSZWpFGXhRgZ0haUnMfWVk237i7/M7oL2
 gjwCbAhCgYYwnXoTBsJ0xW0nzZ+scR7MVuN1QJ5Xsf5YkiGXpGXO0jVGHZdyCEhDANOTjSNYif
 iFurSsztoF3L9pwjKi8wAo7diJs2SP6h/Gh50VY1DI1onSH4XqnDwnNUNkF+dC/5csZZ1/Lugd
 uNPNV20auI86H0SEQP9tHyqXbgEFuHqOERvMYwISJVgN5OQzxnlyLpOb+bcEsHCahxjJjGZCYE
 J+Y=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2022 01:56:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH v2 0/4] btrfs: rework background block group relocation
Date:   Tue, 29 Mar 2022 01:56:05 -0700
Message-Id: <cover.1648543951.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a combination of Josef's series titled "btrfs: rework background
block group relocation" and my patch titled "btrfs: zoned: make auto-reclaim
less aggressive" plus another preparation patch to address Josef's comments.

I've opted for rebasinig my path onto Josef's series to avoid and fix
conflicts, as we're both touching the same code.

Here's the original cover letter from Josef:

Currently the background block group relocation code only works for zoned
devices, as it prevents the file system from becoming unusable because of block
group fragmentation.

However inside Facebook our common workload is to download tens of gigabytes
worth of send files or package files, and it does this by fallocate()'ing the
entire package, writing into it, and then free'ing it up afterwards.
Unfortunately this leads to a similar problem as zoned, we get fragmented data
block groups, and this trends towards filling the entire disk up with partly
used data block groups, which then leads to ENOSPC because of the lack of
metadata space.

Because of this we have been running balance internally forever, but this was
triggered based on different size usage hueristics and stil gave us a high
enough failure rate that it was annoying (figure 10-20 machines needing to be
reprovisioned per week).

So I modified the existing bg_reclaim_threshold code to also apply in the !zoned
case, and I also made it only apply to DATA block groups.  This has completely
eliminated these random failure cases, and we're no longer reprovisioning
machines that get stuck with 0 metadata space.

However my internal patch is kind of janky as it hard codes the DATA check.
What I've done here is made the bg_reclaim_threshold per-space_info, this way
a user can target all block group types or just the ones they care about.  This
won't break any current users because this only applied in the zoned case
before.

Additionally I've added the code to allow this to work in the !zoned case, and
loosened the restriction on the threshold from 50-100 to 0-100.

I tested this on my vm by writing 500m files and then removing half of them and
validating that the block groups were automatically reclaimed.

https://lore.kernel.org/linux-btrfs/cover.1646934721.git.josef@toxicpanda.com/

Changes to v1:
* Fix zoned threshold calculation (Pankaj)
* Drop unneeded patch

Johannes Thumshirn (1):
  btrfs: zoned: make auto-reclaim less aggressive

Josef Bacik (3):
  btrfs: make the bg_reclaim_threshold per-space info
  btrfs: allow block group background reclaim for !zoned fs'es
  btrfs: change the bg_reclaim_threshold valid region from 0 to 100

 fs/btrfs/block-group.c      | 41 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.c |  7 +++++--
 fs/btrfs/space-info.c       |  9 ++++++++
 fs/btrfs/space-info.h       |  6 ++++++
 fs/btrfs/sysfs.c            | 37 +++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c            | 28 +++++++++++++++++++++++++
 fs/btrfs/zoned.h            | 12 ++++++-----
 7 files changed, 133 insertions(+), 7 deletions(-)

-- 
2.35.1

