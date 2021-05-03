Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C713E371078
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 04:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhECCJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 May 2021 22:09:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232770AbhECCJy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 May 2021 22:09:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620007740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pWCLNfChFcsyNtInu8EIYdp6GVVxaS/39dc1JI2lIoc=;
        b=d2du8Zu0mhqm3LcvTZoFVyyAntBChyPZyZWisXjAj2WIuH0RoM+gVEj+uOGn6iq0JPR8OP
        S9oTbL9apcS91RwDgWaPtVJDsc5Rh8CjgfGQuA+DL8rC9xBg7KweabMEeFD86V4Z4dpp0C
        s7bbuGJRoiw1sGrjtE9br9Riv2e7we8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B84E2B18F
        for <linux-btrfs@vger.kernel.org>; Mon,  3 May 2021 02:09:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/4] btrfs: make read time repair to be only submitted for each corrupted sector
Date:   Mon,  3 May 2021 10:08:52 +0800
Message-Id: <20210503020856.93333-1-wqu@suse.com>
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
allow subpage case to use the same infrastructure.

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

Qu Wenruo (4):
  btrfs: remove the dead branch in btrfs_io_needs_validation()
  btrfs: make btrfs_verify_data_csum() to return a bitmap
  btrfs: submit read time repair only for each corrupted sector
  btrfs: remove io_failure_record::in_validation

 fs/btrfs/ctree.h     |   4 +-
 fs/btrfs/extent_io.c | 262 +++++++++++++++++++------------------------
 fs/btrfs/extent_io.h |   4 +-
 fs/btrfs/inode.c     |  19 +++-
 4 files changed, 134 insertions(+), 155 deletions(-)

-- 
2.31.1

