Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D25D29E3EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgJ2HXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:23:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:39186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgJ2HXn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603955544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O29KyhZHBatvsACMkGwT7zhnsOalLk8TW1HmD6aCzHQ=;
        b=PSXwnSU/Dm3ByPCJLfzCxtDCG4yVTOlhWC3PymmLsNIx0vhXMypTWC6UzWMgmGphqC3sno
        utDu4WZpHRallAir2gJa9zLiDAqyzHK2ZMzL41fgQX8ujhMMt4PpM6LkVrC+gkWhc9nTpv
        nD7mrTYe3JCl85R7DJxtIpM5E2ji5k4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5916EACA3
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 07:12:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: btrfs_lookup_bio_sums() related fixes
Date:   Thu, 29 Oct 2020 15:12:15 +0800
Message-Id: <20201029071218.49860-1-wqu@suse.com>
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

It turns out that, bio can be merged as long as their disk_bytenr can be
merged, no need for their page offset to be adjacent.
This means, the file_offset in btrfs_lookup_bio_sums() doesn't make much
sense.

To address the problem, the 3rd patch is introduced to do bio unrelated
csum search.
This does not only simplify the main loop (just one small main loop),
but also free us from the out-of-order bvec problems.

The other two patches are mostly small enhancement found during the
development.

With the patchset, the subpage can survive infinite fsstress
run and the regular page size case can still pass all existing fstests.

Since it has nothing special to subpage at all, and by nature they are
mostly renames and refactor, they can be submitted right now, with or
without subpage patches.

Changelog:
v2:
- Remove the @file_offset parameter completely
- Remove btrfs_find_ordered_sum() completely
- Introduce data reloc inode specific file_offset lookup.

Qu Wenruo (3):
  btrfs: file-item: use nodesize to determine whether we need readhead
    for btrfs_lookup_bio_sums()
  btrfs: file-item: remove the btrfs_find_ordered_sum() call in
    btrfs_lookup_bio_sums()
  btrfs: file-item: refactor btrfs_lookup_bio_sums() to handle
    out-of-order bvecs

 fs/btrfs/compression.c  |   4 +-
 fs/btrfs/ctree.h        |   2 +-
 fs/btrfs/file-item.c    | 274 ++++++++++++++++++++++++++--------------
 fs/btrfs/inode.c        |   5 +-
 fs/btrfs/ordered-data.c |  46 -------
 fs/btrfs/ordered-data.h |   2 -
 6 files changed, 185 insertions(+), 148 deletions(-)

-- 
2.29.1

