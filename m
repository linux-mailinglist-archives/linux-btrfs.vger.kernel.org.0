Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AED29873A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 08:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770916AbgJZHLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 03:11:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:51250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770501AbgJZHLZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 03:11:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603696283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bsRBWwnj9rk2xRYs7ld/mb435oGJR8dXzNHifpKX9Ig=;
        b=nfgBjhNJp/L3Tt43ytlOSWUU9qo6jthNiaQ76+ZzdAcYx9txxOwtJuAX4kJc1JJtTjHTz3
        7zCqtCna4qxKuyTkx+Xf5F1fujExFyLkJeS+OQ5VMVrYvo0trXFwYgMfd3bky9C5i/QtSH
        iPkse4pAB5j8t9qunhcD9Rj9L4KsRFU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 360F4AD18
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:11:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: scrub: support subpage scrub (completely independent version)
Date:   Mon, 26 Oct 2020 15:11:07 +0800
Message-Id: <20201026071115.57225-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To my surprise, the scrub functionality is completely independent, thus
it can support subpage much easier than subpage read/write itself.

Thus here comes the independent scrub support for subpage.

== BACKGROUND ==
With my experimental subpage read/write, the scrub is always reporting
my subpage fs is completely corrupted, every tree block and every data
sector is corrupted.

Thus there must be something wrong with the scrub and subpage.

== CAUSE ==
It turns out that, scrub is hard coding tons of PAGE_SIZE, and always
assume PAGE_SIZE == sectorsize.
Structure scrub_page is in fact more like scrub_sector, where it only
stores one sector.

But there is also some good news, since scrub is submitting its own read
write bio, it avoids all the hassles to handle page unaligned sectors.

== WORKAROUND ==
The workaround is pretty straightforward, always store just one sector
in one scrub_page.
And teach the scrub_checksum_*() functions to follow the sector size of
each scrub_page.

The cost is pretty obvious for 64K page size systems.
If using 4K sector size, we need a full page to scrub one 4K sector.
And we will allocate 16 times more space to scrub 4K sectors compared to
4K page size systems.

But still, the cost should be more or less acceptable for now.

== TODO ==
To properly handle the case, we should get rid of scrub_page completely.

The main objective of scrub_page is just to restore the per-sector csum.
In fact all the members like logical/physical/physical_for_replace can
be calculated from scrub_block.

If we can store pages/csums/csums_bitmap in scrub_block, we can easily
do proper page based csum check for both data and metadata, and take the
advantage of much larger page size.

But that work is beyond the scope of subpage support, I will take that
work after the subpage functionality if fully completely.

== PATCHSET STRUCTURE ==
Patch 01~04:	Small refactors and cleanups spotted during the
		development.
Patch 05~08:	Support for subpage scrub.

All these patches will be also included in next subpage patchset update,
but considering they are way more independent than current subpage
patchset, it's still worthy submitting.


The support won't change anything for current sector size == PAGE_SIZE
cases.
Both 4K and 64K page systems tested.

For subpage testing, it's only basic scrub and repair tested, and there
are still some blockage for full fstests run.

Qu Wenruo (8):
  btrfs: scrub: distinguish scrub_page from regular page
  btrfs: scrub: remove the @force parameter of scrub_pages()
  btrfs: scrub: use flexible array for scrub_page::csums
  btrfs: scrub: refactor scrub_find_csum()
  btrfs: scrub: introduce scrub_page::page_len for subpage support
  btrfs: scrub: always allocate one full page for one sector for RAID56
  btrfs: scrub: support subpage tree block scrub
  btrfs: scrub: support subpage data scrub

 fs/btrfs/scrub.c | 292 +++++++++++++++++++++++++++++++----------------
 1 file changed, 192 insertions(+), 100 deletions(-)

-- 
2.29.0

