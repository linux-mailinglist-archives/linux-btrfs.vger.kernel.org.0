Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784E393B61
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhE1CaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 22:30:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:60448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236126AbhE1CaA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 22:30:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622168905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FW91rQm7vIhfXcOa4QMMeyWH3eGQYoyiU0s6quIejkI=;
        b=fcufMWappvhJq8tIw74OeAmvs/dueV5fsl3XX0+P/r4pImshT6WnWk/oVm9hr746qv3Ato
        zZJWfFkhj8nFb85mdxE0pBfi4uts0vR55svBRWv7VfhHPXCKCNuGIxRmpB1t9SzE+/84fg
        VHZrVTBz2aB2Te+bGZ/XuD3o236Mc9o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61DD4AC3A
        for <linux-btrfs@vger.kernel.org>; Fri, 28 May 2021 02:28:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: defrag: rework to support sector perfect defrag
Date:   Fri, 28 May 2021 10:28:14 +0800
Message-Id: <20210528022821.81386-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This branch is based on subpage RW branch, as the 4th patch needs to use
subpage helpers to support sector perfect defrag for subpage.

But the core rework should be applied for all cases.

[BACKGROUND]
In subpage rw branch, although we implemented defrag support for
subpage, but it's still doing defrag in full page size.

This means, if we want to defrag a 64K page which contains one 4K sector
and 60K holes, we will re-write the full page back to disk, causing
extra space usage.

This is far from ideal, and will cause generic/018 to fail due to above
reason.

[SOLUTION]
To defrag a file range, what we do is pretty much like buffered write,
except we don't really write any new data to page cache, but just mark
the range dirty.

Then let later writeback to merge the range into a larger extent.

But current defrag code is working on per-page basis, not per-sector,
thus we have to refactor it a little to make it to work properly for
subpage.

This patch will separate the code into 3 layers:
Layer 0:	btrfs_defrag_file()
		The defrag entrace
		Just do proper inode lock and split the file into
		page aligned 256K clusters to defrag

Layer 1:	defrag_one_cluster()
		Will collect the targets file extents, and pass each
		continuous target to defrag_one_range()

Layer 2:	defrag_one_range()
		The real work.
		Do almost all the same work as btrfs_buffered_write(),
		except we don't copy any content into page cache, but
		just mark the range dirty, defrag and delalloc.

[BEHAVIOR CHANGE]
In the refactor, there is one behavior change:

- It's no longer ensured we won't defrag holes
  This is caused by the timing when targets are collected.
  At that time, we don't have page/extent/inode locked, thus
  the result got can be volatile.

  But considering this greatly simplify the workflow, and sane users
  should never run defrag on files under heavy IO, I think it's worthy
  to change the behavior a little for a more readable code.

[PATCH STRUTURE]
Patch 01~02:	Small independent refactor to improve readability
Patch 03~06:	Implement the more readable and subpage friendly defrag
Patch 07:	Cleanup of old infrastruture

Qu Wenruo (7):
  btrfs: defrag: pass file_ra_state instead of file for
    btrfs_defrag_file()
  btrfs: defrag: extract the page preparation code into one helper
  btrfs: defrag: introduce a new helper to collect target file extents
  btrfs: defrag: introduce a helper to defrag a continuous range
  btrfs: defrag: introduce a new helper to defrag one cluster
  btrfs: defrag: use defrag_one_cluster() to implement
    btrfs_defrag_file()
  btrfs: defrag: remove the old infrastructure

 fs/btrfs/ctree.h |   4 +-
 fs/btrfs/ioctl.c | 815 ++++++++++++++++++++---------------------------
 2 files changed, 342 insertions(+), 477 deletions(-)

-- 
2.31.1

