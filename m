Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209F548D1D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 06:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiAMFWV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 00:22:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiAMFWV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 00:22:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DF4F61F3A3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 05:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642051339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GDic8SXhDhUvQiI5sTeh+cEtr2nfIQ+c9Hj+7Zhq5Ec=;
        b=gQBcRpiU10zxHYcJqiSu4bWKdJ9ajcl0k5ripVqIFJzENL5aEJ/qbL7wZyMKmwZtR0nRU6
        lVgD28j0eI1a1I8sqcX73LhDtF6ZI2CoQOPIiFQ3oKzy3b0KmUOr/syIdk++Fb5U0NBusV
        tqxKf8q+T4qgFMOLVsmTjfWsakk3Bb4=
Received: from adam-pc.suse.de (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id CBC09A3B83
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 05:22:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3] btrfs: support more pages sizes for the subpage support
Date:   Thu, 13 Jan 2022 13:22:07 +0800
Message-Id: <20220113052210.23614-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The series can be fetched from github:
https://github.com/adam900710/linux/tree/metadata_subpage_switch

Previously we only support 64K page size with 4K sector size for subpage
support.

There are two reasons for such requirement:

- Make sure no matter what the nodesize is, metadata can be fit into one
  page
  This is to avoid multi-page metadata handling.

- We use u16 as bitmap
  That means we will waste extra memory for smaller page sizes.

The 2nd problem is already solved by compacting all bitmap into one
large bitmap, in commit 72a69cd03082 ("btrfs: subpage: pack all subpage
bitmaps into a larger bitmap").

And this patchset will address the first problem by going to non-subpage
routine if nodesize >= PAGE_SIZE.

This will still leave a small limitation, that for nodesize >= PAGE_SIZE
and sectorsize < PAGE_SIZE case, the tree block must be page aligned.

Thankfully we have btrfs-check to detect such problem, and mkfs and
kernel chunk allocator have already ensured all our metadata will not
cross such page boundaries.

The following combinations has been tested:
(p: page_size s: sectorsize, n: nodesize)

- p=64K s=4K n=64K (aarch64, RK3399/CM4)
  To cover the new metadata path

- p=64K s=4K n=16K (aarch64, RK3399/CM4)
- p=4k s=4k n=16k (x86_64)
  The make sure no new bugs in the old path

- p=16K s=4K n=16K (aarch64, M1)
- p=16K s=4K n=64K (aarch64, M1)
  Special thanks to Su Yue. He contributes his VM on M1 to me to do
  extra tests, and exposed a bug in the btrfs_read_sys_array() affecting
  16K page size cases.

Changelog:
RFC->v1:
- Remove one ASSERT() which is causing false alert
  As we have no way to distinguish unmapped extent buffer with anonymous
  page used by DIO/compression.

- Expand the subpage support to any PAGE_SIZE > 4K
  There is still a limitation on not allowing metadata block crossing page
  boundaries, but that should already be rare nowadays.

  Another limit is we still don't support 256K page size due to it's
  beyond max compressed extent size.

v2:
- Add extra supported sectorsizes in sysfs interface
  Now for page size > 4K, all sector sizes up to page size will be
  supported.

- Fix a bug in btrfs_read_sys_array() that would cause false alert
  Now btrfs_read_sys_array() will use dummy eb, and
  set/clear_extent_buffer_uptodate() will handle both dummy and subpage
  cases properly.

- Fix a bug in check_eb_alignment() that would cause false alert
  Since we handle nodesize >= PAGE_SIZE cases with the same page based
  metadata routine, we need to make sure metadata is page aligned for
  that case.

v3:
- Fix the wrong page boundary check for nodesize >= PAGE_SIZE
  And update the commit message for the 1st path.

- Add an artificial limit to only support 4K and PAGE_SIZE as
  sectorsizes
  There is no problem supporting any sectorsize < PAGE_SIZE, e.g.
  support 16K seectorsize with 64K page size works pretty fine.

  But that combination will not be supported by x86_64 anyway, and
  the extra combination will slow down the already slow testing
  on weaker ARM boards.

  We will push 4k as default sectorsize.


Qu Wenruo (3):
  btrfs: use dummy extent buffer for super block sys chunk array read
  btrfs: make nodesize >= PAGE_SIZE case to reuse the non-subpage
    routine
  btrfs: expand subpage support to any PAGE_SIZE > 4K

 fs/btrfs/disk-io.c   |  17 +++++---
 fs/btrfs/extent_io.c | 102 ++++++++++++++++++++++++++++---------------
 fs/btrfs/inode.c     |   2 +-
 fs/btrfs/subpage.c   |  30 ++++++-------
 fs/btrfs/subpage.h   |  25 +++++++++++
 fs/btrfs/sysfs.c     |   6 +--
 fs/btrfs/volumes.c   |  25 +++--------
 7 files changed, 125 insertions(+), 82 deletions(-)

-- 
2.34.1

