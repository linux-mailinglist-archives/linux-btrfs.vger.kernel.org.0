Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18BA37104F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 03:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhECBaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 May 2021 21:30:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhECBaU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 May 2021 21:30:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620005367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dF1a94JiREd+3V33kQDluGnvjwuQ1heOC/3QuMw6jac=;
        b=JZP7CJn2FbJOK3mT7DH7YC3bCQP1YW2nhyIzsqSxwAjt2lYMsFkDbjuv8KHs9apaVDf7VH
        s2WBmSKHR9wBNXeGzdu3rJclegtX8LY0Kc1pLKVmKJzAuS3hjSuYwv6Svb9V+p85dcLKQ6
        aFGQEbNcsGYeAWxtigvmBw84kotAp9w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F47BB05E
        for <linux-btrfs@vger.kernel.org>; Mon,  3 May 2021 01:29:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: make read time repair to be only submitted for each corrupted sector
Date:   Mon,  3 May 2021 09:29:20 +0800
Message-Id: <20210503012924.77865-1-wqu@suse.com>
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

Qu Wenruo (4):
  btrfs: remove the dead branch in btrfs_io_needs_validation()
  btrfs: make btrfs_verify_data_csum() to return a bitmap
  btrfs: submit read time repair only for each corrupted sector
  btrfs: remove io_failure_record::in_validation

 fs/btrfs/ctree.h     |   4 +-
 fs/btrfs/extent_io.c | 256 +++++++++++++++++++------------------------
 fs/btrfs/extent_io.h |   4 +-
 fs/btrfs/inode.c     |  19 +++-
 4 files changed, 131 insertions(+), 152 deletions(-)

-- 
2.31.1

