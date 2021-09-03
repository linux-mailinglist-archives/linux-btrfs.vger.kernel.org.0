Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD740016C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbhICOqA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:46:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12649 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhICOqA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630680300; x=1662216300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vL4OwgJ4oUnw4MDseafkciIkQaXDPszimvHZr5DXhUQ=;
  b=qdvovzN+ek58XxG3d0kPLBzysLxeRvR0TaLWbRi0bFioIV4pfMCE7y+i
   yOj1jI1943i9D+573Zr0F7vloBsWIxQr6NxaEg4A7Qg99b/Q+xGR9qlCW
   DaSGSRRVUJFlvlliZP4N9J3pI5xC7gHXQBIEkdpg1p1uqomGK2qRxKqPT
   3OcbITIXdZTMMM59uiT6j+cuMZ2jvu7laYD2v6g/bG8fjuKFExcyuL0LY
   Kk/hp5nUrIgJlvXwVTDcODz71PDkPj1bMWZLjxa5pxeevhQXB6pHLlcjd
   fZkYsJniBm2nr3I6JlMQa3DwdIGJ2sNF/IGHOmkZ2uq+u7xth9sRL3cSc
   g==;
X-IronPort-AV: E=Sophos;i="5.85,265,1624291200"; 
   d="scan'208";a="179681167"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2021 22:45:00 +0800
IronPort-SDR: fQpgNXnYJCeeqNC3HvEvKEVY80wlWpe4b77YSKWFjbvjgzdQPt54STgSQRM6rLQpkMOj0Jpn3k
 DssMfG5F75trVdcjS5AC7+pcnkIQw/8oqfe/3nq8ADtFNuUk9eEIfn4SXAZ+kj/nfE6ZwOqC8A
 mk1USgFeUryyf+J7/+qo/yQHgmHzc1XjrK+vSO7Zvlir+f3sr7aYslZcjCQ0pwIxNxN0U+Ro/A
 W01Qu09cfkIJzvAia5RwU76eC5HGHHJ2X1cNGdMa8NvCQLhFsnPIGksTqH5AM7d7Mr/OAMQnj5
 sYkINX9/Ci8EggdKWlnAQmEJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:20:02 -0700
IronPort-SDR: narj/PjfKrwG0voRMnjdd31KMvS4samd0ohObBqu7mgogTDse9DLNhoLXhIFwTK1w5toWzicZg
 7QL4nL9iuH8QpBXZtd8J+Fgn1tETBfUDoIOyaOZZQV9GD/EQnbOkLXLoKc11yUQXbT9h4aGzsq
 r4D3hYWtYEkepF0FSFRf22URdVxIH70js1mrSaQejjqEtO7stvxS4t1VHEkptEb1cubbxBrj/K
 +44AqJJqY3MDCBQdxy4n4xhDN4/4ZsCM+N92ossODQXfwcwu9XnAXtfOtgTub1MXA5hVRoCBhd
 gzc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2021 07:44:58 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/6] btrfs: zoned: unify relocation on a zoned and regular FS
Date:   Fri,  3 Sep 2021 23:44:41 +0900
Message-Id: <cover.1630679569.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A while ago David reported a bug in zoned btrfs' relocation code. The bug is
triggered because relocation on a zoned filesystem does not preallocate the
extents it copies and a writeback process running in parallel can cause a
split of the written extent. But splitting extents is currently not allowed on
relocation as it assumes a one to one copy of the relocated extents.

This causes transaction aborts and the fielssytem switching to read-only in
order to prevent further damage.

The first patch in this series is just a preparation to avoid overly long
lines in follow up patches. Patch number two adds a dedicated block group for
relocation on a zoned filesystem. Patch three switches relocation from
REQ_OP_ZONE_APPEND to regular REQ_OP_WRITE, four prepares an ASSERT()ion that
we can enter the nocow path on a  zoned filesystem under very special
circumstances and the fifth patch then switches the relocation code for a
zoned filesystem to using the same code path as we use on a non zoned
filesystem. As the changes before have made the prerequisites to do so. The
last patch in this series is jsut a simple rename of a function whose name we
have twice in the btrfs codebase but with a different purpose in different
files.

Johannes Thumshirn (6):
  btrfs: introduce btrfs_is_data_reloc_root
  btrfs: zoned: add a dedicated data relocation block group
  btrfs: zoned: use regular writes for relocation
  btrfs: check for relocation inodes on zoned btrfs in should_nocow
  btrfs: zoned: allow preallocation for relocation inodes
  btrfs: rename setup_extent_mapping in relocation code

 fs/btrfs/block-group.c |  1 +
 fs/btrfs/ctree.h       |  7 ++++++
 fs/btrfs/disk-io.c     |  3 ++-
 fs/btrfs/extent-tree.c | 52 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/inode.c       | 22 ++++++++----------
 fs/btrfs/relocation.c  | 43 +++++-----------------------------
 fs/btrfs/zoned.c       |  3 +++
 fs/btrfs/zoned.h       |  9 ++++++++
 8 files changed, 87 insertions(+), 53 deletions(-)

-- 
2.32.0

