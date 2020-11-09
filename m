Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F132AB790
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 12:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgKILyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 06:54:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:43042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgKILyQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 06:54:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604922855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PwwvCdxn1AvxiwzVqsTWnfI9fSgRlmi97j6d7wuMNbc=;
        b=L3rccRvXa6lNFWT25byrnR3y41cKRf8UVghr7fcotfr3a/jHWb22wXkukg7OD0cGeucy6N
        uvsXkuf4kJFECxFQ7/EqkZkbfETg9RWXhFJyMwB6W6tozXkcZAi6FeYdeJWaH2RI2RQwXp
        zwrQGBN+fJMXwDZmjFaammsh8UXDU8Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85050ABDE
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 11:54:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: paramater refactors for data and metadata endio call backs
Date:   Mon,  9 Nov 2020 19:54:08 +0800
Message-Id: <20201109115410.605880-1-wqu@suse.com>
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

Also, since we know the @disk_bytenr should alwasy be inside the bio
range, add ASSERT() to check such assumption.

Qu Wenruo (2):
  btrfs: remove the phy_offset parameter for
    btrfs_validate_metadata_buffer()
  btrfs: use more straightforward disk_bytenr to replace icsum for
    check_data_csum()

 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/disk-io.h   |  2 +-
 fs/btrfs/extent_io.c | 16 +++++++++-------
 fs/btrfs/inode.c     | 35 ++++++++++++++++++++++++++---------
 4 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.29.2

