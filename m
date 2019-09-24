Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF08BC3EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409379AbfIXILc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 04:11:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:38910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390364AbfIXILb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 04:11:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A27C1B617
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 08:11:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: fsck-tests: Add test image for invalid inode generation repair
Date:   Tue, 24 Sep 2019 16:11:20 +0800
Message-Id: <20190924081120.6283-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924081120.6283-1-wqu@suse.com>
References: <20190924081120.6283-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The image contains one inode item with invalid generation.
The image can be crafted by "btrfs-corrupt-block -i 257 -f generation".
It should emulate the bad inode generation caused by older kernel around
2014.

The image is repairable for both original and lowmem mode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../043-bad-inode-generation/.lowmem_repairable  |   0
 .../bad_inode_geneartion.img.xz                  | Bin 0 -> 2012 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
 create mode 100644 tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.xz

diff --git a/tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable b/tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
new file mode 100644
index 00000000..e69de29b
diff --git a/tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.xz b/tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..d7302fcbabc653885ae1fac438183d7a9908a2f1
GIT binary patch
literal 2012
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

literal 0
HcmV?d00001

-- 
2.23.0

