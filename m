Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9537B529
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 06:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhELEym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 00:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhELEym (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 00:54:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620795214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=U0wSxQgtWQltNujxPyI1VmP2OLbUeoW2swxrZDIj3d8=;
        b=cIsFlBdZ2tL1eqCHEPMT6tTX919Otgx3MC7joRF+vsgrqYvUcYaHEno7PxfS5ceQYmVcyd
        it37pNvml7thsNBZdEnbzQMQm/mungKvq3tDlT5aibauAtD1UTfJUxWAChK3lUA1ElnZpb
        n395UBLrWYvxxwnjU5lbWdjIOVG923A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15F48AE8D
        for <linux-btrfs@vger.kernel.org>; Wed, 12 May 2021 04:53:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 0/3] btrfs: make read time repair to be only submitted for each corrupted sector
Date:   Wed, 12 May 2021 12:53:27 +0800
Message-Id: <20210512045330.40329-1-wqu@suse.com>
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

v5:
- Fix a bug where we grab wrong fs_info from DIO page
  Exposed by btrfs/215.
  And for DIO case we don't need end_page_read() and extent unrelease
  call at all.

- Unexport btrfs_submit_read_repair(), export btrfs_repair_one_sector()
  Since DIO only needs to repair one sector, unexport
  btrfs_submit_read_repair() and just export btrfs_repair_one_sector().

Qu Wenruo (3):
  btrfs: make btrfs_verify_data_csum() to return a bitmap
  btrfs: submit read time repair only for each corrupted sector
  btrfs: remove io_failure_record::in_validation

 fs/btrfs/ctree.h     |   4 +-
 fs/btrfs/extent_io.c | 348 +++++++++++++++++++++----------------------
 fs/btrfs/extent_io.h |  13 +-
 fs/btrfs/inode.c     |  27 ++--
 4 files changed, 191 insertions(+), 201 deletions(-)

-- 
2.31.1

