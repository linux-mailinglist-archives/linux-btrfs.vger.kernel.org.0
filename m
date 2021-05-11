Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF5379F95
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 08:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhEKGQB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 02:16:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhEKGP7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 02:15:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620713693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WqCdSefFOtI/2AUHAZICeAMYaPCXWRbUHDtYL+8XelQ=;
        b=kbFfTkWcIwerqXXK5UjF4tX+Ef0x5x1xf58ncL7ZvqZrqZjSaAEpe2u7Ne00tZRdtalqVt
        ZBn4RSsbeY9jZhWu6hZAB0aOF8z7pQNIcBuTa9xYk8S82SP/6F962aA1nxkEeXvf2/o5KC
        n0QbG++PAIb6f5chW6JftCwPoz+WOQc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C9F3B12E
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 06:14:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/3] btrfs: make read time repair to be only submitted for each corrupted sector
Date:   Tue, 11 May 2021 14:14:46 +0800
Message-Id: <20210511061449.228635-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs read time repair has to handle two different cases when a corruption
or read failure is hit:
- The failed bio contains only one sector
  Then it only need to find a good copy

- The failed bio contains several sectors
  Then it needs to find which sectors really need to be repaired

But this different behaviors are not really needed, as we can teach btrfs
to only submit read repair for each corrupted sector.
By this, we only need to handle the one-sector corruption case.

This not only makes the code smaller and simpler, but also benefits subpage,
allow subpage case to use the same infrastructure without any extra
modification.

For current subpage code, we hacked the read repair code to make full
bvec read repair, which has less granularity compared to regular sector
size.

The code is still based on subpage branch, but can be forward ported to
non-subpage code basis with minor conflicts.

Changelog:
v2:
- Split the original patch
  Now we have two preparation patches, then the core change.
  And finally a cleanup.

- Fix the uninitialize @error_bitmap when the bio read fails.

v3:
- Fix the return value type mismatch in repair_one_sector()
  An error happens in v2 patch split, which can lead to hang when
  we can't repair the error.

v4:
- Fix a bug that end_page_read() get called twice for the same range
  This happens when the corrupted sector has no extra copy, thus
  btrfs_submit_read_repair() return -EIO, leaving both
  btrfs_submit_read_repair() and end_bio_extent_readpage() to
  call end_page_read() twice on the good copy.
  Thankfully this only affects subpage.

- Fix a bug that sectors after unrepairable corruption are not released
  Since btrfs_submit_read_repair() is responsible for the page release,
  we can no longer just error out.
  Or some ordered extent will not be able to finish.

- Remove patch "btrfs: remove the dead branch in btrfs_io_needs_validation()"
  The cleanup will break bisect, as DIO can still generate cloned bio.
  Thus remove it and let the final cleanup patch to handle everything.

- Apply the style fixes from David

Qu Wenruo (3):
  btrfs: make btrfs_verify_data_csum() to return a bitmap
  btrfs: submit read time repair only for each corrupted sector
  btrfs: remove io_failure_record::in_validation

 fs/btrfs/ctree.h     |   4 +-
 fs/btrfs/extent_io.c | 337 ++++++++++++++++++++-----------------------
 fs/btrfs/extent_io.h |   4 +-
 fs/btrfs/inode.c     |  20 ++-
 4 files changed, 176 insertions(+), 189 deletions(-)

-- 
2.31.1

