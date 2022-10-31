Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DA5613435
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJaLLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJaLLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 07:11:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D394BE12;
        Mon, 31 Oct 2022 04:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9BB2611B1;
        Mon, 31 Oct 2022 11:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6710AC433D6;
        Mon, 31 Oct 2022 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667214694;
        bh=sOkBrdDnXcDZdgQNhP5o5ExoUYCFtnwmRn4CHam5tqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdNdG6YTqP9Mi65Xfs20VoMuYjjONVVgpepdJWePkyrm2oABFNPLZQLdtDy0favcP
         gmHrpBWLEnagRZgSoFUo3uvTThJmqdN5hkjNHtpjTYBVUqbb4PaO2jm5w804bBCV2S
         0SG/raqkcla8bc/Uw72EC78hh0h1GLzymxa9fte2bu7VM23b3eRHJ0S+Hvo0noW8EZ
         5RbFWmiS+LhoRm150zZfY/qrzSM4IvyNR0YPb4WTe3wF6xCU01u8mIVRrieX9wEjc6
         m/9EPTa9s02JFag2NgSZqhlSVDewmCnOd1zAj28gKokduBdF2G1EFKry8kodGLc8M8
         ZThFwQH8xQeLg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/3] btrfs: test fiemap reports extent as not shared after COWing it in snapshot
Date:   Mon, 31 Oct 2022 11:11:21 +0000
Message-Id: <e5ae81c52ccbd5245014564b6fbe370ec33c966b.1667214081.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667214081.git.fdmanana@suse.com>
References: <cover.1667214081.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we have a large file, with file extent items spanning several
leaves in the fs tree, and that is shared due to a snapshot, if we COW one
of the extents, doing a fiemap will report the respective file range as
not shared.

This exercises the processing of delayed references for metadata extents
in the backref walking code, used by fiemap to determine if an extent is
shared.

This used to fail until very recently and was fixed by the following
kernel commit that landed in 6.1-rc2:

  943553ef9b51 (""btrfs: fix processing of delayed tree block refs during backref walking")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/280     | 64 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/280.out | 21 +++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100755 tests/btrfs/280
 create mode 100644 tests/btrfs/280.out

diff --git a/tests/btrfs/280 b/tests/btrfs/280
new file mode 100755
index 00000000..06ef221e
--- /dev/null
+++ b/tests/btrfs/280
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 280
+#
+# Test that if we have a large file, with file extent items spanning several
+# leaves in the fs tree, and that is shared due to a snapshot, if we COW one of
+# the extents, doing a fiemap will report the respective file range as not
+# shared.
+#
+# This exercises the processing of delayed references for metadata extents in
+# the backref walking code, used by fiemap to determine if an extent is shared.
+#
+. ./common/preamble
+_begin_fstest auto quick compress snapshot fiemap
+
+. ./common/filter
+. ./common/punch # for _filter_fiemap_flags
+
+_supported_fs btrfs
+_require_scratch
+_require_xfs_io_command "fiemap"
+
+_fixed_by_kernel_commit 943553ef9b51 \
+	"btrfs: fix processing of delayed tree block refs during backref walking"
+
+_scratch_mkfs >> $seqres.full 2>&1
+# We use compression because it's a very quick way to create a file with a very
+# large number of extents (compression limits the maximum extent size to 128K)
+# and while using very little disk space.
+_scratch_mount -o compress
+
+# A 128M file full of compressed extents results in a fs tree with a heigth
+# of 2 (root at level 1), so we'll end up with tree block references in the
+# extent tree (if the root was a leaf, we would have only data references).
+$XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Create a RW snapshot of the default subvolume.
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+
+echo
+echo "File foo fiemap before COWing extent:"
+echo
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
+
+echo
+echo "Overwriting file range [120M, 120M + 128K) in the snapshot"
+echo
+$XFS_IO_PROG -c "pwrite -b 128K 120M 128K" $SCRATCH_MNT/snap/foo | _filter_xfs_io
+# Now fsync the file to force COWing the extent and the path from the root of
+# the snapshot tree down to the leaf where the extent is at.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/snap/foo
+
+echo
+echo "File foo fiemap after COWing extent in the snapshot:"
+echo
+# Now we should have all extents marked as shared except the 128K extent in the
+# file range [120M, 120M + 128K).
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
new file mode 100644
index 00000000..c3f82966
--- /dev/null
+++ b/tests/btrfs/280.out
@@ -0,0 +1,21 @@
+QA output created by 280
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+
+File foo fiemap before COWing extent:
+
+0: [0..261887]: shared
+1: [261888..262143]: shared|last
+
+Overwriting file range [120M, 120M + 128K) in the snapshot
+
+wrote 131072/131072 bytes at offset 125829120
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+File foo fiemap after COWing extent in the snapshot:
+
+0: [0..245759]: shared
+1: [245760..246015]: none
+2: [246016..261887]: shared
+3: [261888..262143]: shared|last
-- 
2.35.1

