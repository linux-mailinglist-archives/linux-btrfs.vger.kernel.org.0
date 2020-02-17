Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52AC160A6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 07:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgBQGbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 01:31:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:46218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgBQGbZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 01:31:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6464CAD21
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 06:31:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3] Btrfs: relocation: Refactor build_backref_tree() using btrfs_backref_iterator infrastructure
Date:   Mon, 17 Feb 2020 14:31:08 +0800
Message-Id: <20200217063111.65941-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is part 1 of the incoming refactor patches for build_backref_tree()

[THE PLAN]
The overall plan of refactoring build_backref_tree() is:
- Refactor how we iterate through backref items
  This patchset, the smallest I guess.

- Make build_backref_tree() easier to read.
  In short, that function is doing breadth-first-search to build a map
  which starts from one tree block, to all root nodes referring it.

  It involves backref iteration part, and a lot of backref cache only
  works.
  At least I hope to make this function less bulky and more structured.

- Make build_backref_tree() independent from relocation
  The hardest I guess.

  Current it even accepts reloc_control as its first parameter.
  Don't have a clear plan yet, but I guess at least I should make
  build_backref_tree() to do some more coverage, other than taking
  certain relocation-dependent shortcut.

[THIS PATCHSET]
For the patchset itself, the main purpose is to change how we iterate
through all backref items of one tree block.

The old way:

  path->search_commit_root = 1;
  path->skip_locking = 1;
  ret = btrfs_search_slot(NULL, extent_root, path, &key, 0, 0);
  ptr = btrfs_item_offset_nr()
  end = btrfs_item_end_nr()
  /* Inline item loop */
  while (ptr < end) {
	/* Handle each inline item here */
  }
  while (1) {
  	ret = btrfs_next_item();
	btrfs_item_key_to_cpu()
	if (key.objectid != bytenr ||
	    !(key.type == XXX || key.type == YYY)) 
		break;
	/* Handle each keyed item here */
  }
  
The new way:

  iterator = btrfs_backref_iterator_alloc();
  for (ret = btrfs_backref_iterator_start(iterator, bytenr);
       ret == 0; ret = btrfs_backref_iterator_next(iterator)) {
	/*
	 * Handle both keyed and inlined item here.
	 *
	 * We can use iterator->key to determine if it's inlined or
	 * keyed.
	 * Even for inlined item, it can be easily converted to keyed
	 * item, just like we did in build_backref_tree().
	 */
  }

Currently, only build_backref_tree() can utilize this infrastructure.

Backref.c has more requirement, as it needs to handle iteration for both
data and metadata, both commit root and current root.
And more importantly, backref.c uses depth first search, thus not a
perfect match for btrfs_backref_iterator.

Extra naming suggestion is welcomed.
The current naming, btrfs_backref_iterator_* looks pretty long to me
already.
Shorter naming would be much better.

Changelog:
v2:
- Fix a completion bug in btrfs_backref_iterator_next()
  It should be btrfs_extent_inline_ref_type().

v3:
- Comment and commit message update
- Move helper definitions to where they get first used
- Use helpers to replace some internal open code

Qu Wenruo (3):
  btrfs: backref: Introduce the skeleton of btrfs_backref_iterator
  btrfs: backref: Implement btrfs_backref_iterator_next()
  btrfs: relocation: Use btrfs_backref_iterator infrastructure

 fs/btrfs/backref.c    | 105 +++++++++++++++++++++++
 fs/btrfs/backref.h    |  96 +++++++++++++++++++++
 fs/btrfs/relocation.c | 195 ++++++++++++++----------------------------
 3 files changed, 265 insertions(+), 131 deletions(-)

-- 
2.25.0

