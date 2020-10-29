Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2269629EE35
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgJ2O3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:44244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgJ2O3M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iqOoeo+QhrFAFrJOa3CjtOg1fvFYQ2Msgz5uFfeTnCA=;
        b=bBTrrEkdLArjYz8XJVe/DU1r5ZpW+kbn4FY179afZxRXjF+Jbs9M8yR8LIthi23S5xeZgb
        JFpDybNkNebTRkUAF/nLhPaTtebNAOQ7u270l8s4y85dmIYDwy/wQRIvA+7XWUvEZADtcP
        WSuX4srgwTJMgqEwH4nrvAHoWjvoSnQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A06F9AFEF;
        Thu, 29 Oct 2020 14:29:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 784D2DA7CE; Thu, 29 Oct 2020 15:27:35 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 00/10] Sectorsize, csum_size lifted to fs_info
Date:   Thu, 29 Oct 2020 15:27:35 +0100
Message-Id: <cover.1603981452.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Clean up usage of multiplication or division by sectorsize by shifts,
checksums per leaf are calculated once and csum_size has a copy in
fs_info so we don't have to read it from raw superblocks.

David Sterba (10):
  btrfs: use precalculated sectorsize_bits from fs_info
  btrfs: replace div_u64 by shift in free_space_bitmap_size
  btrfs: replace s_blocksize_bits with fs_info::sectorsize_bits
  btrfs: store precalculated csum_size in fs_info
  btrfs: precalculate checksums per leaf once
  btrfs: use cached value of fs_info::csum_size everywhere
  btrfs: switch cached fs_info::csum_size from u16 to u32
  btrfs: remove unnecessary local variables for checksum size
  btrfs: check integrity: remove local copy of csum_size
  btrfs: scrub: remove local copy of csum_size from context

 fs/btrfs/btrfs_inode.h     |  3 +-
 fs/btrfs/check-integrity.c |  6 +---
 fs/btrfs/compression.c     |  9 ++----
 fs/btrfs/ctree.h           |  5 +++-
 fs/btrfs/disk-io.c         | 11 ++++---
 fs/btrfs/extent-tree.c     | 11 ++-----
 fs/btrfs/extent_io.c       |  4 +--
 fs/btrfs/file-item.c       | 60 ++++++++++++++++++--------------------
 fs/btrfs/file.c            |  3 +-
 fs/btrfs/free-space-tree.c | 30 +++++++++----------
 fs/btrfs/inode.c           | 13 ++++-----
 fs/btrfs/ordered-data.c    | 11 ++++---
 fs/btrfs/ordered-data.h    |  3 +-
 fs/btrfs/scrub.c           | 31 ++++++++++----------
 fs/btrfs/super.c           |  2 +-
 fs/btrfs/tree-checker.c    |  5 ++--
 16 files changed, 95 insertions(+), 112 deletions(-)

-- 
2.25.0

