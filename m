Return-Path: <linux-btrfs+bounces-10939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C42A0BCAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 16:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5678164690
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B70204583;
	Mon, 13 Jan 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+1b0QmJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BFD1420DD;
	Mon, 13 Jan 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783772; cv=none; b=eD4s0r3DKGon61qGKlIehdtA6eFUiO18QxNK5WEeaohqdSKIt/fHTRxfFhll37/W5eVZM0hOVl3actKjwFoe2Si9WrM7mxEmVKHmlvxV2R/t7YEDxpv72UtxdlSEiXIOLSxe2q6sc7XoY+toP8yk0K27d8XzPWwjkXkTo9tqwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783772; c=relaxed/simple;
	bh=2DyQJQtg2jTz+shuWvjjwZuE4kOwj/cguYbgJDjyRWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efa4TXsGdX3GQQhRUuvMLaks4GTRrf3NjQxAvQ8gG3TX3b+fomNwYTdaWvffDmUl3h1D/9lQ6+hTv1ePrvTuWwNVJnSqmgA4sGvvB5gLGYiFmMWaZ6yelQ4qN49PgKJ4PcH8nGBzudm4ewbI00erPZ2mntgf/8rGOgB1QDN6xr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+1b0QmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CF8C4CEE3;
	Mon, 13 Jan 2025 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783771;
	bh=2DyQJQtg2jTz+shuWvjjwZuE4kOwj/cguYbgJDjyRWk=;
	h=From:To:Cc:Subject:Date:From;
	b=g+1b0QmJXM6WW2jKwcy67te5aCHRMIbiegQMInjqHmkDioOnqxv2h9Z50NUZW1AIV
	 t2n0CMbHDqeefJU9QgTAXcuvFhTc1AtLiUA6+Eq/3e+2/yPRD0l6psqPipwQg/iWxi
	 01VpOz5RdFuAd7+hsTnfGHUSZnCG7q9ncvzklVz7lfhwD6BDeVUaJCzDMdRc4T5Cxe
	 +eSkLusdQgDs9CJuD3qx6vEsIs4IU4Q8TRKz5Z9lWyfGbnK4Tbkp3vV7qj4XlWaLs5
	 EKFJ+FNqn076VSv2Yc3fi/8eSO+xDFTilM/TE6dv07xxYHLj0LkNg02/crIZPg0rcv
	 pdmUfApoJ2FpQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	zlang@redhat.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] generic: test swap activation on file that used to have clones
Date: Mon, 13 Jan 2025 15:55:57 +0000
Message-ID: <2c9ff99c2bcaec4412b0903e03949d5a3ad0d817.1736783467.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that we are able to activate a swap file on a file that used to have
its extents shared multiple times.

This exercises a bug on btrfs' extent sharedness detection during swap
file activation, which is fixed by the following kernel commit:

  03018e5d8508 ("btrfs: fix swap file activation failure due to extents that used to be shared")

The fails sporadically on XFS and the bug was already reported to the XFS
mailing list:

   https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/

   https://lore.kernel.org/fstests/dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com/

So for now skip the test on XFS and add comments with references to these
threads.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Add git commit ID now that the btrfs fix landed in Linus' tree.
    Skip the test on XFS and add a comment about it.

 tests/generic/370     | 109 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/370.out |  25 ++++++++++
 2 files changed, 134 insertions(+)
 create mode 100755 tests/generic/370
 create mode 100644 tests/generic/370.out

diff --git a/tests/generic/370 b/tests/generic/370
new file mode 100755
index 00000000..67af7b6e
--- /dev/null
+++ b/tests/generic/370
@@ -0,0 +1,109 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 370
+#
+# Test that we are able to create and activate a swap file on a file that used
+# to have its extents shared multiple times.
+#
+. ./common/preamble
+_begin_fstest auto quick clone swap
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	test -n "$swap_file" && swapoff $swap_file &> /dev/null
+}
+
+. ./common/reflink
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
+    "btrfs: fix swap file activation failure due to extents that used to be shared"
+
+# Skip XFS for now because this exposes an issue that is hard to fix.
+# See the following threads for details about it:
+#
+# https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
+# https://lore.kernel.org/fstests/dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com/
+#
+_supported_fs ^xfs
+
+_require_scratch_swapfile
+_require_scratch_reflink
+_require_cp_reflink
+
+run_test()
+{
+	local sync_after_add_reflinks=$1
+	local sync_after_remove_reflinks=$2
+	local first_swap_file="$SCRATCH_MNT/swap"
+	local swap_size=$(($(_get_page_size) * 32))
+	local num_clones=50
+	local swap_file="$SCRATCH_MNT/clone_${num_clones}"
+
+	_scratch_mkfs >> $seqres.full 2>&1 || _fail "failed to mkfs"
+	_scratch_mount
+
+	echo "Creating swap file..."
+	_format_swapfile $first_swap_file $swap_size >> $seqres.full
+
+	echo "Cloning swap file..."
+	# Create a large number of clones so that on btrfs we get external ref
+	# items in the extent tree and not just inline refs (33 is currently the
+	# treshold after which external refs are created).
+	for ((i = 1; i <= $num_clones; i++)); do
+		# Create the destination file and set +C (NOCOW) on it before
+		# copying into it with reflink. This is because when cp needs to
+		# create the destination file, it first copies/clones the data
+		# and then sets the +C attribute, and on btrfs we can't clone a
+		# NOCOW file into a COW file, both must be NOCOW or both COW.
+		touch $SCRATCH_MNT/clone_$i
+		# 0600 is required for swap files, do the same as _format_swapfile.
+		chmod 0600 $SCRATCH_MNT/clone_$i
+		$CHATTR_PROG +C $SCRATCH_MNT/clone_$i > /dev/null 2>&1
+		_cp_reflink $first_swap_file $SCRATCH_MNT/clone_$i
+	done
+
+	if [ $sync_after_add_reflinks -ne 0 ]; then
+		# Force a transaction commit on btrfs to flush all delayed
+		# references and commit the current transaction.
+		_scratch_sync
+	fi
+
+	echo "Deleting original file and all clones except the last..."
+	rm -f $first_swap_file
+	for ((i = 1; i < $num_clones; i++)); do
+		rm -f $SCRATCH_MNT/clone_$i
+	done
+
+	if [ $sync_after_remove_reflinks -ne 0 ]; then
+		# Force a transaction commit on btrfs to flush all delayed
+		# references and commit the current transaction.
+		_scratch_sync
+	fi
+
+	# Now use the last clone as a swap file.
+	echo "Activating swap file..."
+	_swapon_file $swap_file
+	swapoff $swap_file
+
+	_scratch_unmount
+}
+
+echo -e "\nTest without sync after creating and removing clones"
+run_test 0 0
+
+echo -e "\nTest with sync after creating clones"
+run_test 1 0
+
+echo -e "\nTest with sync after removing clones"
+run_test 0 1
+
+echo -e "\nTest with sync after creating and removing clones"
+run_test 1 1
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/370.out b/tests/generic/370.out
new file mode 100644
index 00000000..36b2dc27
--- /dev/null
+++ b/tests/generic/370.out
@@ -0,0 +1,25 @@
+QA output created by 370
+
+Test without sync after creating and removing clones
+Creating swap file...
+Cloning swap file...
+Deleting original file and all clones except the last...
+Activating swap file...
+
+Test with sync after creating clones
+Creating swap file...
+Cloning swap file...
+Deleting original file and all clones except the last...
+Activating swap file...
+
+Test with sync after removing clones
+Creating swap file...
+Cloning swap file...
+Deleting original file and all clones except the last...
+Activating swap file...
+
+Test with sync after creating and removing clones
+Creating swap file...
+Cloning swap file...
+Deleting original file and all clones except the last...
+Activating swap file...
-- 
2.45.2


