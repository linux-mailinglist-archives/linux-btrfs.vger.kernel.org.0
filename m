Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2B2E05DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 07:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLVGAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 01:00:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:35470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLVGAO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 01:00:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608616768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5UfyOyz39X45kNXaVhz8cSehMIDJvEZWeODwCpdx9PM=;
        b=LpZQVJWzXE3DusMa5DA1fum+pga1LQ6hCRoUauBLC3z82ic6cJxggkmyE5JAtxKoezJZxD
        0FKjMF85z1AAiVvJdaqFjdwyD9wxbNO0N2Vb6iOJMNXZm5khZEHTuU6ZK/dozK4k2YRsG9
        UVRgVr5DP4Snr+fCo4aiId1Aag49IAk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75228AC63
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Dec 2020 05:59:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: btrfs_dec_test_*_ordered_extent() refactor
Date:   Tue, 22 Dec 2020 13:59:22 +0800
Message-Id: <20201222055924.64724-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This small patchset is btrfs_dec_test_*_ordered_extent() refactor during
subpage RW support development.

This is mostly to make btrfs_dev_test_* functions more human readable
and prepare it for calling btrfs_dec_test_first_ordered_extent() in
btrfs_writepage_endio_finish_ordered() where we can have one or more
ordered extents for one bvec.

The first patch is a very safe width reduction, where there is only one
assginment. Thus it should be very safe and won't be involved in other
call sites.

Changelog:
v2:
- Remove the width reduction in the 2nd patch
  The u64->u32 width reduction has too many parts involved, it's really
  hard to do it cleanly just in one patch.
  Remove the width reduction and focus on the existing refactors.

Qu Wenruo (2):
  btrfs: make btrfs_dio_private::bytes to be u32
  btrfs: refactor btrfs_dec_test_* functions for ordered extents

 fs/btrfs/btrfs_inode.h  |  2 +-
 fs/btrfs/inode.c        |  5 +--
 fs/btrfs/ordered-data.c | 99 ++++++++++++++++++++++-------------------
 fs/btrfs/ordered-data.h | 10 ++---
 4 files changed, 60 insertions(+), 56 deletions(-)

-- 
2.29.2

