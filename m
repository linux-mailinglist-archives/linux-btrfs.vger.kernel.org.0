Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD84B15332C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgBEOii (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 09:38:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34704 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBEOii (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 09:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580913518; x=1612449518;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3UQyNOZPY9ZmSyLkXUlEzo7I23OK+G7VhKaVroTFWlU=;
  b=LGxVgyolrsTyTusT52tLweo4zQ7rSAfT1Lw31Xt5kGxJknTgHyzmzMni
   46Bywi0VvHTXu3UooIr/E3XcaR7zW1me2GeOlMCqhY+5fGTpySSZ7NWSV
   edLbTi6WlwLN9irqZbkuiabM8ekKUDf4+fzoSK7pDkmv4nQwZz8UB3jmJ
   7UDQXOoVJwC8rLpofnw9/TLITQeMYnjeVWK/dF45aVKZhHvGTi7m0eDU3
   fK6c0qw7rJty2QkZH9AkL6gxLgsiqnLBZ07CQpHsvdiMWz1i5lrNOp8HI
   Znl235Gbht/zvJ3iy7lZ68MkCjZlahvAHje2067V23N25g8adAEyglyZk
   g==;
IronPort-SDR: GYI9StNYB0iGD+Jgof1Gzs6b98qR+eiOIFZ2/fV6D0xWABXuWxLi/SZ1XfZAxCfOe3yBZtnhh0
 bso3x4Ecx9FCSY/S5yEiIkCkwd3+jFaACjuqSZF2HJGz6w1mKCMzbBlNuBqtnZj3250Pedm48k
 BXmtObzCNwO7BEmDzdIi4VaPWku9edG6LEuW0MmKc7fwCH4UC6KFBIky6S6Bovvqy4nEcTY3O+
 ao010TD06u7SUEPZdlHklQ2pl9fKiOBIMyqE6R1M30KFNRkozm8IimZwSaH1YWULG+5syG0F7n
 Mw8=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="133512040"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 22:38:37 +0800
IronPort-SDR: nyYHv7Nnbc07ErSt1Jf6ltgpihCA8pf0ODNvoyXJnZS2u0pB7LNhP1eAHEv+Mi5I6kikU2A3In
 jxTeZJK5Zubk4w7P+qyYrgYI43vzYQm3K5hagwVFhHgFVZxWh2nR+/kgjy0/7PtrhKHGauj/qs
 kdBHHjvE6Fbsq5i3l/0zUaeFW/IWiEgVrTS3f+XDjp6b49QsWaU+zQTv6UW7gyoP0QSbnSH6dn
 Mg1c0Sw5UWFQ57MBKQrIlWvEVUGXfb9lz23gqOH0YiyGiFvLdupwCX8tGkXDrq+sUOqawHRRCz
 yFhaUHjvgRzYk97jB1jweBQD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 06:31:37 -0800
IronPort-SDR: CilWTUSaM2TCxnDJjj3/RY29wHrQ2ZmrpsqU+riXzNoWo0ArP2Q5pVVfG5N+Gn1duzBYArhNNQ
 MPvU0Qet7RwC9ZhExhj4nEWnJXtZVmeNdwAPb8GE1i/5wPFwLeywxNTU/a8GoTrhqx/+U4Dxur
 aBieMdRTmjeZb6OTNwfir7DUwXptUsKWavnMRxMUbn+jQvjIs6cUQoFhhhxWX+VSXbjwFzcCi2
 wjvvA4UyrKy25JHSPiAzDOmVJ1DeO6DPq4P5FgeTdceugAG2MEyzfbnjJ1iRP+DJrgkP702xK7
 C18=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Feb 2020 06:38:36 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/5] btrfs: remove buffer heads form superblock handling
Date:   Wed,  5 Feb 2020 23:38:26 +0900
Message-Id: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series removes the use of buffer_heads from btrfs' super block read
and write paths. It also converts the integrity-checking code to only work
with pages and BIOs.

Compared to buffer heads, this gives us a leaner call path, as the
buffer_head code wraps around getting pages from the page-cache and adding
them to BIOs to submit.

The first patch removes buffer_heads from superblock reading.  The second
removes it from super_block writing and the subsequent patches remove the
buffer_heads from the integrity check code.

It's based on misc-next from Wednesday February 5, and doesn't show any
regressions in xfstests to the baseline.

This is more or less a consolidation submission, as I lost track what changes
have been requested.

Changes to v3:
- Incroporated feedback from Christoph

Changes to v2:
- Removed patch #1 again
- Added Reviews from Josef
- Re-visited page locking, but not changes, it retains the same locking scheme
  the buffer_heads had
- Incroptorated comments from David regarding open-coding functions
- For more details see the idividual patches.

Changes to v1:
- Added patch #1
- Converted sb reading and integrity checking to use the page cache
- Added rationale behind the conversion to the commit messages.
- For more details see the idividual patches.


Johannes Thumshirn (5):
  btrfs: use the page-cache for super block reading
  btrfs: use BIOs instead of buffer_heads from superblock writeout
  btrfs: remove btrfsic_submit_bh()
  btrfs: remove buffer_heads from btrfsic_process_written_block()
  btrfs: remove buffer_heads form superblock mirror integrity checking

 fs/btrfs/check-integrity.c | 218 +++++++++++--------------------------
 fs/btrfs/check-integrity.h |   2 -
 fs/btrfs/disk-io.c         | 195 +++++++++++++++++++--------------
 fs/btrfs/disk-io.h         |   4 +-
 fs/btrfs/volumes.c         |  57 +++++-----
 fs/btrfs/volumes.h         |   2 -
 6 files changed, 210 insertions(+), 268 deletions(-)

-- 
2.24.1

