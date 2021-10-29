Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6C43FC22
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 14:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhJ2MU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 08:20:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55850 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhJ2MU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 08:20:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 12A232196F;
        Fri, 29 Oct 2021 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635509909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9+iSz6ZxCX5bpyCjTv0yyev2kAAKQ2R39mBVeMmTFMM=;
        b=hwEFOETDkJG2HsVXIjUVADf2us4hHwdowZ4jl+DRMmeUNwKO+gTgn9wmKTcdB6OL62GX20
        8ZuwNYAvl5E0QfwsndQWZtIDQ6KfmI7d9cL1E0iIuKy26eka+59o/d8Y7ES2zHcY/C0GSx
        LUO97gHmhWL6ighu27ePpem5eClfSk4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0B65CA3B81;
        Fri, 29 Oct 2021 12:18:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0CDFFDA7A9; Fri, 29 Oct 2021 14:17:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.15-rc8
Date:   Fri, 29 Oct 2021 14:17:55 +0200
Message-Id: <cover.1635506911.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

last minute fixes for crash on 32bit architectures when compression is
in use. It's a regression introduced in 5.15-rc and I'd really like not
let this into the final release, fixes via stable trees would add
unnecessary delay.

The problem is on 32bit architectures with highmem enabled, the pages
for compression may need to be kmapped, while the patches removed that
as we don't use GFP_HIGHMEM allocations anymore.  The pages that don't
come from local allocation still may be from highmem. Despite being on
32bit there's enough such ARM machines in use so it's not a marginal
issue.

I did full revert of the patches one by one instead of a huge one.
There's one exception for the "lzo" revert as there was an intermediate
patch touching the same code to make it compatible with subpage.  I
can't revert that one too, so the revert in lzo.c is manual.  Qu Wenruo
has worked on that with me and verified the changes.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 4afb912f439c4bc4e6a4f3e7547f2e69e354108f:

  btrfs: fix abort logic in btrfs_replace_file_extents (2021-10-07 22:08:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc7-tag

for you to fetch changes up to ccaa66c8dd277ac02f96914168bb7177f7ea8117:

  Revert "btrfs: compression: drop kmap/kunmap from lzo" (2021-10-29 13:25:43 +0200)

----------------------------------------------------------------
David Sterba (4):
      Revert "btrfs: compression: drop kmap/kunmap from generic helpers"
      Revert "btrfs: compression: drop kmap/kunmap from zstd"
      Revert "btrfs: compression: drop kmap/kunmap from zlib"
      Revert "btrfs: compression: drop kmap/kunmap from lzo"

 fs/btrfs/compression.c |  3 ++-
 fs/btrfs/inode.c       |  3 ++-
 fs/btrfs/lzo.c         | 36 +++++++++++++++++++++++++-----------
 fs/btrfs/zlib.c        | 36 +++++++++++++++++++++++++-----------
 fs/btrfs/zstd.c        | 27 ++++++++++++++++++---------
 5 files changed, 72 insertions(+), 33 deletions(-)
