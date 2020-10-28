Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6099429E319
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJ2CpS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:45:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgJ1Vdo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603869877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=org0HUIzwcciEbWapa/gka6RLbhZK+8eCKsQH1b8EpY=;
        b=VTf0bR109kXAalPdn+lo3boOJy7yyqhWwsujOHVqzFRRXbiHl+3OYNIapC0UE3RsfDnEjH
        zkIshsunHVyMJ9YHMlHcM2gpO9P0kzrwPEcufQQPVh9d5AgWl02hHgLMUuRCb6fZZR/96X
        sH7vhy8iHMeJXo5qs21Kw+P6SB92buE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7609AAF1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 07:24:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: btrfs_lookup_bio_sums() related fixes
Date:   Wed, 28 Oct 2020 15:24:29 +0800
Message-Id: <20201028072432.86907-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the final piece to make subpage read/write patchset to pass all
fsstress tests.

Before this 3 patches, there is a very low chance to hit the following
errors:
- False bad data csum error
  The expected csum is alwasy 0x00000000, which should represents
  something.

- WARN_ON_ONCE(count) hit
  Something is definitely wrong in btrfs_lookup_bio_sums().


After more debugging, even on X86_64, there is definitely something to
notice, the most important thing is, the bvec in btrfs_lookup_bio_sums()
is not always in linear bytenr order:

  btrfs_lookup_bio_sums: file_offset=-1 expected_bvec_offset=532480 page_offset=716800 bv_offset=0
  btrfs_lookup_bio_sums: orig_file_offset=520192 bvec_index=3 root=259 ino=260 page_owner_ino=260

This is from x86_64 run, with extra debug info from the
bio_for_each_segment() loop.
It shows that, also the bio->bi_size is correct and each page is
properly mapped, they are not ensured to be in bytenr order.
This could ruin subpage support, if we hit a bvec which belongs to the
end of the bio, and we found a lot of csums for it, we may skip the
csums for other bvecs.

To address the problem, the 3rd patch is introduced to do bio unrelated
csum search.
This does not only simplify the main loop (just one small main loop),
but also free us from the out-of-order bvec problems.

The other two patches are mostly small enhancement found during the
development.

With the patchset, the subpage can survice (mostly) infinite fsstress
run and the regular page size case can still pass all existing fstests.

Since it has nothing special to subpage at all, and by nature they are
mostly renames and refactor, they can be submitted right now, with or
without subpage patches.

Qu Wenruo (3):
  btrfs: file-item: use nodesize to determine whether we need readhead
    for btrfs_lookup_bio_sums()
  btrfs: ordered-data: rename parameter @len to @nr_sectors
  btrfs: file-item: refactor btrfs_lookup_bio_sums() to handle
    out-of-order bvecs

 fs/btrfs/file-item.c    | 242 ++++++++++++++++++++++++----------------
 fs/btrfs/ordered-data.c |   9 +-
 fs/btrfs/ordered-data.h |   2 +-
 3 files changed, 154 insertions(+), 99 deletions(-)

-- 
2.29.1

