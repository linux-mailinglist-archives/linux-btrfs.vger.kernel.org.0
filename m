Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1DB0717
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 05:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfILDLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 23:11:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729242AbfILDLu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 23:11:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D0ACAFFE
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 03:11:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 6/6] btrfs-progs: tests/fsck: Add new images for inode mode repair functionality
Date:   Thu, 12 Sep 2019 11:11:35 +0800
Message-Id: <20190912031135.79696-7-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912031135.79696-1-wqu@suse.com>
References: <20190912031135.79696-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new test image for imode repair in subvolume trees.

The new test cases including the following cases:
- Regular file with bad imode
  It still has the valid INODE_REF and parent dir has correct DIR_INDEX
  and DIR_ITEM.
  In this case, no matter if the file is empty or not, it should be
  repaired using the info from DIR_INDEX of parent dir.

- Non-empty regular file with bad imode, and without INODE_REF
  The file should be mostly an orphan, so no INODE_REF for imode lookup.
  But it has EXTENT_DATA which should be enough for imode repair.
  The repair also involves moving the orphan to lost+found dir.

- Non-empty dir with bad imode, and without INODE_REF
  Pretty much the same case, but now a directory.
  The repair also involves moving the orphan to lost+found dir.

Also rename the existing test case 039-bad-free-space-cache-inode-mode
to 039-bad-inode-mode, since now we can fix all bad imode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../039-bad-inode-mode/.lowmem_repairable        |   0
 .../bad_free_space_cache_imode.raw.xz}           | Bin
 .../bad_imodes_in_subvolume_tree.img.xz          | Bin 0 -> 2956 bytes
 3 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable
 rename tests/fsck-tests/{039-bad-free-space-cache-inode-mode/test.raw.xz => 039-bad-inode-mode/bad_free_space_cache_imode.raw.xz} (100%)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/bad_imodes_in_subvolume_tree.img.xz

diff --git a/tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable b/tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/fsck-tests/039-bad-free-space-cache-inode-mode/test.raw.xz b/tests/fsck-tests/039-bad-inode-mode/bad_free_space_cache_imode.raw.xz
similarity index 100%
rename from tests/fsck-tests/039-bad-free-space-cache-inode-mode/test.raw.xz
rename to tests/fsck-tests/039-bad-inode-mode/bad_free_space_cache_imode.raw.xz
diff --git a/tests/fsck-tests/039-bad-inode-mode/bad_imodes_in_subvolume_tree.img.xz b/tests/fsck-tests/039-bad-inode-mode/bad_imodes_in_subvolume_tree.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..8c51ceb7703de8ab36ca8cdd95117c0e13174a04
GIT binary patch
literal 2956
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
C1kMfs

literal 0
HcmV?d00001

-- 
2.23.0

