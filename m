Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C558D386BD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfFGJKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 05:10:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:38354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726531AbfFGJKG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jun 2019 05:10:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E0A5ADD5;
        Fri,  7 Jun 2019 09:10:05 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Eryu Guan <guaneryu@gmail.com>, Filipe Manana <fdmanana@gmail.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        fstests@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH fstests v3] btrfs: add validation of compression options to btrfs/048
Date:   Fri,  7 Jun 2019 11:09:37 +0200
Message-Id: <20190607090937.7177-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190606153228.GD4172@x250>
References: <20190606153228.GD4172@x250>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The current btrfs/048 test-case did not check the behavior of properties
with options like compression and with the compression level supplied.

Add test cases for compression with compression level as well so we can be
sure we don't regress there.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Filipe Manana <fdmanana@suse.com>

---
Changes to v2:
- Remove validation of lzo compression with option, lzo doesn't have
  compression levels

Changes to v1:
- Removed output redirection and filtering for the cases we don't expect any
  actual output (Filipe)
---
 tests/btrfs/048     | 13 +++++++++++++
 tests/btrfs/048.out | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 8bb10a904bc9..7294f231e4ed 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -226,5 +226,18 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' 2>&1 | _filter_scrat
 $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
 $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^generation'
 
+echo -e "\nTesting argument validation with options"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zlib:3'
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zstd:0'
+echo "***"
+
+echo -e "\nTesting invalid argument validation with options, should fail"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zl:9' 2>&1 | _filter_scratch
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli:0' 2>&1 | _filter_scratch
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst:3' 2>&1 | _filter_scratch
+
 status=0
 exit
diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
index 16a785a642f7..0923b00c01ed 100644
--- a/tests/btrfs/048.out
+++ b/tests/btrfs/048.out
@@ -92,3 +92,14 @@ Testing generation is unchanged after failed validation
 generation		7
 ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
 generation		7
+
+Testing argument validation with options
+***
+***
+
+Testing invalid argument validation with options, should fail
+ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
+***
+ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
+***
+ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
-- 
2.16.4

