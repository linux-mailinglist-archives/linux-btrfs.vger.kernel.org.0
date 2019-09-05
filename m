Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3FA9C71
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfIEH6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 03:58:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:48076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731732AbfIEH6V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 03:58:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97C84AD6B
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2019 07:58:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/6] btrfs-progs: tests/fsck: Add new images for inode mode repair functionality
Date:   Thu,  5 Sep 2019 15:58:00 +0800
Message-Id: <20190905075800.1633-7-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190905075800.1633-1-wqu@suse.com>
References: <20190905075800.1633-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add new test image for imode repair in subvolume trees.

Also rename the existing test case 039-bad-free-space-cache-inode-mode
to 039-bad-inode-mode, since now we can fix all bad imode.

And add the beacon file for lowmem test.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../039-bad-inode-mode/.lowmem_repairable        |   0
 .../bad_free_space_cache_imode.raw.xz}           | Bin
 .../bad_regular_file_imode.img.xz                | Bin 0 -> 2060 bytes
 3 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable
 rename tests/fsck-tests/{039-bad-free-space-cache-inode-mode/test.raw.xz => 039-bad-inode-mode/bad_free_space_cache_imode.raw.xz} (100%)
 create mode 100644 tests/fsck-tests/039-bad-inode-mode/bad_regular_file_imode.img.xz

diff --git a/tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable b/tests/fsck-tests/039-bad-inode-mode/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/fsck-tests/039-bad-free-space-cache-inode-mode/test.raw.xz b/tests/fsck-tests/039-bad-inode-mode/bad_free_space_cache_imode.raw.xz
similarity index 100%
rename from tests/fsck-tests/039-bad-free-space-cache-inode-mode/test.raw.xz
rename to tests/fsck-tests/039-bad-inode-mode/bad_free_space_cache_imode.raw.xz
diff --git a/tests/fsck-tests/039-bad-inode-mode/bad_regular_file_imode.img.xz b/tests/fsck-tests/039-bad-inode-mode/bad_regular_file_imode.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..bbdd17de1fb9e59d26d2b0502fff326f019be011
GIT binary patch
literal 2060
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

literal 0
HcmV?d00001

-- 
2.23.0

