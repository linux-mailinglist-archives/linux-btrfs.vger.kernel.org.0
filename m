Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4872ACAE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 03:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgKJCJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 21:09:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJCJQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 21:09:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604974155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3O9/D8xFJSUfMAOoxjDsugdC30Pxu7e32VLvA99cac4=;
        b=vXSUE0pedFzc5u8uS91ZNMlmfKAE3qjyiBr4P+bOH73N72c2k9z/pvxpFDICBmXCnWgAJd
        KsJKWXI/B/mGaI1mLr2wTSP7uFUOEBtwMTxm5LXQYd3nnjKpMw2YPiBEsQC7++ABrQfCFg
        c5xYcT5zyRI+G3whs/PCbzMJ5GXrT5c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 034A5AC24
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Nov 2020 02:09:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: paramater refactors for data and metadata endio call backs
Date:   Tue, 10 Nov 2020 10:09:07 +0800
Message-Id: <20201110020909.23438-1-wqu@suse.com>
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

Qu Wenruo (2):
  btrfs: remove the phy_offset parameter for
    btrfs_validate_metadata_buffer()
  btrfs: pass disk_bytenr directly for check_data_csum()

 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/disk-io.h   |  2 +-
 fs/btrfs/extent_io.c | 16 +++++++++-------
 fs/btrfs/inode.c     | 26 +++++++++++++++++---------
 4 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.29.2

