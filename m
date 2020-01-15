Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6ED13C28C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 14:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAONWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 08:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgAONWW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 08:22:22 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89EA420728;
        Wed, 15 Jan 2020 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579094541;
        bh=l1DHMLSLR79p0FbO65l1So1ibL0ZKTNzPYvmBE9iOV0=;
        h=From:To:Cc:Subject:Date:From;
        b=iS5dNanf8AB+n2CrFDS2p8/VPxX5fyiOj1LQEgU1hnxiYwNUNh07t0FPl3Fq1XqbT
         FUKS79aMuMI3lbt9Dm1ufKN+TIJAWdKtG3FbsKFsBhTZggZX4caJpE1bGKPDUsSYKs
         YFSa2s8fx+t9ssM26Hji9rzzu09RoSI6MkIMuiSY=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/527: add additional test including a file with a hardlink
Date:   Wed, 15 Jan 2020 13:22:16 +0000
Message-Id: <20200115132216.24041-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a similar test to the existing one but with a file that has a
hardlink as well. This is motivated by a bug found in btrfs where
a fsync on a file that has the old name of another file results
in the logging code to hit an infinite loop. The patch that fixes
the bug in btrfs has the following subject:

  "Btrfs: fix infinite loop during fsync after rename operations"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/527     | 26 ++++++++++++++++++++++++++
 tests/generic/527.out |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/tests/generic/527 b/tests/generic/527
index aacccd91..61dd4f0b 100755
--- a/tests/generic/527
+++ b/tests/generic/527
@@ -45,6 +45,12 @@ mkdir $SCRATCH_MNT/testdir
 echo -n "foo" > $SCRATCH_MNT/testdir/fname1
 echo -n "hello" > $SCRATCH_MNT/testdir/fname2
 
+# For a different variant of the same test but when files have hardlinks too.
+mkdir $SCRATCH_MNT/testdir2
+echo -n "foo" > $SCRATCH_MNT/testdir2/zz
+ln $SCRATCH_MNT/testdir2/zz $SCRATCH_MNT/testdir2/zz_link
+echo -n "hello" > $SCRATCH_MNT/testdir2/a
+
 # Make sure everything done so far is durably persisted.
 sync
 
@@ -57,6 +63,21 @@ ln $SCRATCH_MNT/testdir/fname3 $SCRATCH_MNT/testdir/fname2
 echo -n "bar" > $SCRATCH_MNT/testdir/fname1
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/fname1
 
+# A second variant, more complex, that involves files with hardlinks too.
+
+# The following 3 renames are equivalent to a rename exchange (zz_link to a), but
+# without the atomicity which isn't required here.
+mv $SCRATCH_MNT/testdir2/a $SCRATCH_MNT/testdir2/tmp
+mv $SCRATCH_MNT/testdir2/zz_link $SCRATCH_MNT/testdir2/a
+mv $SCRATCH_MNT/testdir2/tmp $SCRATCH_MNT/testdir2/zz_link
+
+# The following rename and file creation are equivalent to a rename whiteout.
+mv $SCRATCH_MNT/testdir2/zz $SCRATCH_MNT/testdir2/a2
+echo -n "bar" > $SCRATCH_MNT/testdir2/zz
+
+# Fsync of zz should work and produce correct results after a power failure.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir2/zz
+
 # Simulate a power failure and mount the filesystem to check that all file names
 # exist and correspond to the correct inodes.
 _flakey_drop_and_remount
@@ -65,6 +86,11 @@ echo "File fname1 data after power failure: $(cat $SCRATCH_MNT/testdir/fname1)"
 echo "File fname2 data after power failure: $(cat $SCRATCH_MNT/testdir/fname2)"
 echo "File fname3 data after power failure: $(cat $SCRATCH_MNT/testdir/fname3)"
 
+echo "File a data after power failure: $(cat $SCRATCH_MNT/testdir2/a)"
+echo "File a2 data after power failure: $(cat $SCRATCH_MNT/testdir2/a2)"
+echo "File zz data after power failure: $(cat $SCRATCH_MNT/testdir2/zz)"
+echo "File zz_link data after power failure: $(cat $SCRATCH_MNT/testdir2/zz_link)"
+
 _unmount_flakey
 
 status=0
diff --git a/tests/generic/527.out b/tests/generic/527.out
index 3c34e1ff..7397fe88 100644
--- a/tests/generic/527.out
+++ b/tests/generic/527.out
@@ -2,3 +2,7 @@ QA output created by 527
 File fname1 data after power failure: bar
 File fname2 data after power failure: foo
 File fname3 data after power failure: foo
+File a data after power failure: foo
+File a2 data after power failure: foo
+File zz data after power failure: bar
+File zz_link data after power failure: hello
-- 
2.11.0

