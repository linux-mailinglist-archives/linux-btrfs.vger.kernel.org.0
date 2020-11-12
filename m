Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C772B0153
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 09:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKLIsE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 03:48:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:39850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgKLIsE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 03:48:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605170881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FGtHf2tRxBzWWOgbsgeNAMSI8mTj/vjqT3iGhNwpfYU=;
        b=afZ3YKeGA3wWrBQ9YOR/c6hG/qo45sjYrZyB/6eHxjKxrE8cnwEWrPE+4ChzpwtzQDV/bs
        +bLldc+VZ/u6CCkf05LvOG0HwQP402vhn2HmMlSo0ZiZewGb2b/99yER5rW311aTgVIBj3
        gZ7eG7LO5F9AydP17ly8a9uFbDwXdNo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7626ABD1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 08:48:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: paramater refactors for data and metadata endio call backs
Date:   Thu, 12 Nov 2020 16:47:56 +0800
Message-Id: <20201112084758.73617-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is another cleanup exposed when I'm fixing my subpage patchset.

Dating back to the old time where we still have hooks for data/metadata
endio, we have a parameter called @phy_offset for both hooks.

That @phy_offset is the number of sectors compared to the bio on-disk
bytenr, and is used to grab the csum from btrfs_io_bio.

This is far from straightforward, and costs reader tons of time to grasp
the basic.

This patchset will change it by:
- Remove phy_offset completely for metadata
  Since metadata doesn't use btrfs_io_bio::csums[] at all, there is no
  need for it.

- Use @disk_bytenr to replace @phy_offset/@icsum
  Let the callee, check_data_csum() to calculate the offset from
  @disk_bytenr and bio to get the csum offset.

Changelog:
v2:
- Update commit message to remove the wrong comment on
  btrfs_io_bio->logical
  That logical is mess, it has different meanings for different use
  cases.
  What we should refer to is bio->bi_iter.bi_sector.

- Remove the false-alert prone ASSERT()
  Even at endio time. bio->bi_iter.bi_size can change due to incoming
  finished IOs.
  This means we can't really rely on bio->bi_iter.bi_size to check if
  our disk_bytenr is still valid.

v3:
- Rename the @offset/phy_offset to @bio_offset to avoid confusion
  It turns out that, the name used in v2, @disk_bytenr, can also be
  confusing, as in endio time, the bi_sector can be remapped for
  real device offset.
  Although it doesn't cause problem since we're only using that value to
  calculate the offset to the beginning of the bio.

  But still, we're trying to remove confusion, not adding more, thus
  rename them to bio_offset.


Qu Wenruo (2):
  btrfs: remove the phy_offset parameter for
    btrfs_validate_metadata_buffer()
  btrfs: pass bio_offset to check_data_csum() directly

 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/disk-io.h   |  2 +-
 fs/btrfs/extent_io.c | 16 +++++++++-------
 fs/btrfs/inode.c     | 26 ++++++++++++++++----------
 4 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.29.2

