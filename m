Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214497B28AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 01:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjI1XQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 19:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1XQF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 19:16:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD1AAC;
        Thu, 28 Sep 2023 16:16:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A71D45C0D7F;
        Thu, 28 Sep 2023 19:16:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 28 Sep 2023 19:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695942961; x=
        1696029361; bh=x2QHxuH8lObiGj2LOCOlk8XB1T+HkuJFk5TsMTDz7T0=; b=P
        dsJ1YsNkdEcorYqyT8qd17n/4zqSM1d6QH3RhHwbMQ8M3B3hrQqPqkwm2lYaI2sF
        7YMCv8aur/DmkYn6jb7HAiZo7iVKubKBf4P+4gzjmQTgP2bgWRBzEpcYJULVZHHT
        zsjGTNeMG9bVdCZ6LXTZ9icf67/iKHWJAZhEpu7nKAwU+zMjtVzQo5ArLu9esLAC
        q+SN7xuSFnGtrG3y2ghEDG8cvgIT4MflPYrUIwlxHiyvlgVqPPn4q5f4iPwrNOyO
        YjHDeIqGXH3sbvZK+Qm7MYOdCGfZszpB/5aXvTTX4gKEMLd7+ELz4zIRL7q3HWT/
        mHgieDRpeNj0BMYhJd64A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695942961; x=1696029361; bh=x
        2QHxuH8lObiGj2LOCOlk8XB1T+HkuJFk5TsMTDz7T0=; b=NFteT+sSN05eM+1DM
        u8Wbcxh4FF66oLPXPVEbdE4ZxTOxA2lzVD4L/P+8HQw/BPNAnuHc6xXCEwylJW9X
        VNYDqTq3pkz2f7GV4RLd0pPvU9amdRN6PT3VC3VkDxXWU9miN7G95iFhd4oilice
        /wM64/2VNqhwc38m7eWJ2bOFXnKOcOV9P46lEenDtIKtwO8/lAW5C+xVhJ74QYdM
        tNgoA4vJLhs52kC1Od+kc4mhE/G8BDdoTz7rSCPfiDDm17SlS//EOhJJWjmj54fR
        CRSAFeilKbZpWCruJMW6qQJGLKYgKFK4tk58dDXnawKgn05aJCNh7GmTGhhsxG+Q
        b4OsQ==
X-ME-Sender: <xms:MQkWZRCu2dkURh9FlXmJVCB64QasmpbnyxNVLeKXvNgY3q44qOOG1w>
    <xme:MQkWZfiYx_KDkCmMuecLLr06lESEaXkbEITQ41S6QshjM0G3DzZ1uBt0E2bS6azLO
    cK32LipcacRvAB0Pck>
X-ME-Received: <xmr:MQkWZclJa742X67JuvYkzGWpAZpGq8d_rr884MbTfjNSXzl4jach7na6H6k4-K6YN6MQCnf06MjfhtlmoD-sq07W4H4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:MQkWZbxsKBDzXFcpaTs4Dr2mGsHO3hH1YgS_u2ipq9wzXQ7MJJaftg>
    <xmx:MQkWZWT4erSwEVXlcD5D3cedQfOMTzjaXS5J8GQRZkmzV17MwhSnOA>
    <xmx:MQkWZeY2nIjmyKbkoBIdjOOMdLa_NwHD0A4_mpRWUkkTIMIfDFA2qw>
    <xmx:MQkWZZLTQcef2bvNRriTuOtcCmqC16lt2Xh1hS5TXt9hCP3lSo8LzQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 19:16:01 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v4 3/6] btrfs/301: new test for simple quotas
Date:   Thu, 28 Sep 2023 16:16:45 -0700
Message-ID: <f5ef8dfbc07c5a3265268f75caeb0a15b0e54d6a.1695942727.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695942727.git.boris@bur.io>
References: <cover.1695942727.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test some interesting basic and edge cases of simple quotas.

To some extent, this is redundant with the alternate testing strategy of
using MKFS_OPTIONS to enable simple quotas, running the full suite and
relying on kernel warnings and fsck to surface issues.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/301     | 435 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/301.out |  18 ++
 2 files changed, 453 insertions(+)
 create mode 100755 tests/btrfs/301
 create mode 100644 tests/btrfs/301.out

diff --git a/tests/btrfs/301 b/tests/btrfs/301
new file mode 100755
index 000000000..227ce9fc5
--- /dev/null
+++ b/tests/btrfs/301
@@ -0,0 +1,435 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 301
+#
+# Test common btrfs simple quotas scenarios involving sharing extents and
+# removing them in various orders.
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup clone subvol prealloc snapshot
+
+# Import common functions.
+. ./common/reflink
+
+# Real QA test starts here.
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch_reflink
+_require_cp_reflink
+_require_btrfs_command inspect-internal dump-tree
+_require_xfs_io_command "falloc"
+_require_scratch_enable_simple_quota
+
+subv=$SCRATCH_MNT/subv
+nested=$SCRATCH_MNT/subv/nested
+snap=$SCRATCH_MNT/snap
+nr_fill=512
+fill_sz=$((8 * 1024))
+total_fill=$(($nr_fill * $fill_sz))
+nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep nodesize | $AWK_PROG '{print $2}')
+ext_sz=$((128 * 1024 * 1024))
+limit_nr=8
+limit=$(($ext_sz * $limit_nr))
+
+prep_fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+cat >$prep_fio_config <<EOF
+[randwrite]
+name=filler
+directory=${subv}
+rw=randwrite
+nrfiles=${nr_fill}
+filesize=${fill_sz}
+EOF
+_require_fio $fio_config
+
+get_qgroup_usage()
+{
+	local qgroupid=$1
+
+	$BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | grep "$qgroupid" | $AWK_PROG '{print $3}'
+}
+
+get_subvol_usage()
+{
+	local subvolid=$1
+	get_qgroup_usage "0/$subvolid"
+}
+
+count_subvol_owned_metadata()
+{
+	local subvolid=$1
+	# We need to sync so that the metadata extents are on disk and visible to dump-tree.
+	sync
+	# Find nodes and leaves owned by the subvol, then get unique offsets
+	# to account for snapshots sharing metadata.
+	count=$($BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV | \
+		grep "owner $subvolid" | $AWK_PROG '{print $2}' | sort | uniq | wc -l)
+	# Output bytes rather than number of metadata blocks.
+	echo $(($count * $nodesize))
+}
+
+check_qgroup_usage()
+{
+	local qgroupid=$1
+	local expected=$2
+	local actual=$(get_qgroup_usage $qgroupid)
+
+	[ $expected -eq $actual ] || echo "qgroup $qgroupid mismatched usage $actual vs $expected"
+}
+
+check_subvol_usage()
+{
+	local subvolid=$1
+	local expected_data=$2
+
+	local expected_meta=$(count_subvol_owned_metadata $subvolid)
+	local actual=$(get_subvol_usage $subvolid)
+	local expected=$(($expected_data + $expected_meta))
+
+	[ $expected -eq $actual ] || echo "subvol $subvolid mismatched usage $actual vs $expected (expected data $expected_data expected meta $expected_meta diff $(($actual - $expected)))"
+}
+
+set_subvol_limit()
+{
+	local subvolid=$1
+	local limit=$2
+
+	$BTRFS_UTIL_PROG qgroup limit $2 0/$1 $SCRATCH_MNT
+}
+
+# We need the cleaner thread to run to actually delete extents for test
+# cases that care about that. The remount wakes up the cleaner thread and sets
+# the commit interval to 1s, so the 1.5s sleep is enough to wait for the cleaner
+# thread to run.
+trigger_cleaner()
+{
+	_scratch_remount commit=1
+	sleep 1.5
+}
+
+cycle_mount_check_subvol_usage()
+{
+	_scratch_cycle_mount
+	check_subvol_usage $@
+}
+
+
+do_write()
+{
+	local file=$1
+	local sz=$2
+
+	$XFS_IO_PROG -fc "pwrite -q 0 $sz" $file
+}
+
+do_enospc_write()
+{
+	local file=$1
+	local sz=$2
+
+	do_write $file $sz
+}
+
+do_falloc()
+{
+	local file=$1
+	local sz=$2
+
+	$XFS_IO_PROG -fc "falloc 0 $sz" $file
+}
+
+do_enospc_falloc()
+{
+	local file=$1
+	local sz=$2
+
+	do_falloc $file $sz
+}
+
+enable_quota()
+{
+	local mode=$1
+
+	[ $mode == "n" ] && return
+	arg=$([ $mode == "s" ] && echo "--simple")
+
+	$BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
+}
+
+prepare()
+{
+	_scratch_mkfs >> $seqres.full
+	_scratch_mount
+	enable_quota "s"
+	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
+	set_subvol_limit 256 $limit
+	check_subvol_usage 256 0
+
+	# Create a bunch of little filler files to generate several levels in
+	# the btree, to make snapshotting sharing scenarios complex enough.
+	$FIO_PROG $prep_fio_config --output=$fio_out
+	check_subvol_usage 256 $total_fill
+
+	# Create a single file whose extents we will explicitly share/unshare.
+	do_write $subv/f $ext_sz
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+}
+
+prepare_snapshotted()
+{
+	prepare
+	$BTRFS_UTIL_PROG subvolume snapshot $subv $snap >> $seqres.full
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+}
+
+prepare_nested()
+{
+	prepare
+	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup limit $limit 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup assign 0/256 1/100 $SCRATCH_MNT >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
+	do_write $nested/f $ext_sz
+	check_subvol_usage 257 $ext_sz
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	local subv_usage=$(get_subvol_usage 256)
+	local nested_usage=$(get_subvol_usage 257)
+	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
+}
+
+# Write in a single subvolume, including going over the limit.
+basic_accounting()
+{
+	echo "basic accounting"
+	prepare
+	rm $subv/f
+	check_subvol_usage 256 $total_fill
+	cycle_mount_check_subvol_usage 256 $total_fill
+	do_write $subv/tmp 512M
+	rm $subv/tmp
+	do_write $subv/tmp 512M
+	rm $subv/tmp
+	do_enospc_falloc $subv/large_falloc 2G
+	do_enospc_write $subv/large 2G
+	_scratch_unmount
+}
+
+# Write to the same range of a file a bunch of times in a row
+# to test extent aware reservations.
+reservation_accounting()
+{
+	echo "reservation accounting"
+	prepare
+	for i in $(seq 10); do
+		do_write $subv/tmp 512M
+		rm $subv/tmp
+	done
+	do_enospc_write $subv/large 2G
+	_scratch_unmount
+}
+
+# Write in a snapshot.
+snapshot_accounting()
+{
+	echo "snapshot accounting"
+	prepare_snapshotted
+	touch $snap/f
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+	do_write $snap/f $ext_sz
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 $ext_sz
+	rm $snap/f
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+	rm $subv/f
+	check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	cycle_mount_check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+# Delete the original ref first after a snapshot.
+delete_snapshot_src_ref()
+{
+	echo "delete src ref first"
+	prepare_snapshotted
+	rm $subv/f
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+	rm $snap/f
+	trigger_cleaner
+	check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	cycle_mount_check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+# Delete the snapshot ref first after a snapshot.
+delete_snapshot_ref()
+{
+	echo "delete snapshot ref first"
+	prepare_snapshotted
+	rm $snap/f
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+	rm $subv/f
+	check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	cycle_mount_check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+# Delete the snapshotted subvolume after a snapshot.
+delete_snapshot_src()
+{
+	echo "delete snapshot src first"
+	prepare_snapshotted
+	$BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+	rm $snap/f
+	trigger_cleaner
+	check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	$BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
+	trigger_cleaner
+	check_subvol_usage 256 0
+	check_subvol_usage 257 0
+	cycle_mount_check_subvol_usage 256 0
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+# Delete the snapshot subvolume after a snapshot.
+delete_snapshot()
+{
+	echo "delete snapshot first"
+	prepare_snapshotted
+	$BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+	$BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
+	trigger_cleaner
+	check_subvol_usage 256 0
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+# Write to a subvolume nested in another subvolume.
+# Exercises the auto-inheritance feature of simple quotas.
+nested_accounting()
+{
+	echo "nested accounting"
+	prepare_nested
+	rm $subv/f
+	check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 $ext_sz
+	local subv_usage=$(get_subvol_usage 256)
+	local nested_usage=$(get_subvol_usage 257)
+	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
+	rm $nested/f
+	check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	subv_usage=$(get_subvol_usage 256)
+	nested_usage=$(get_subvol_usage 257)
+	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
+	do_enospc_falloc $nested/large_falloc 2G
+	do_enospc_write $nested/large 2G
+	_scratch_unmount
+}
+
+# Enable simple quotas on a filesystem with existing extents.
+enable_mature()
+{
+	echo "enable mature"
+	_scratch_mkfs >> $seqres.full
+	_scratch_mount
+	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
+	do_write $subv/f $ext_sz
+	# Sync before enabling squotas to reliably *not* count the writes
+	# we did before enabling.
+	sync
+	enable_quota "s"
+	set_subvol_limit 256 $limit
+	_scratch_cycle_mount
+	usage=$(get_subvol_usage 256)
+	[ $usage -lt $ext_sz ] || echo "captured usage from before enable $usage >= $ext_sz"
+	do_write $subv/g $ext_sz
+	usage=$(get_subvol_usage 256)
+	[ $usage -lt $ext_sz ] && echo "failed to capture usage after enable $usage < $ext_sz"
+	check_subvol_usage 256 $ext_sz
+	rm $subv/f
+	check_subvol_usage 256 $ext_sz
+	_scratch_cycle_mount
+	rm $subv/g
+	check_subvol_usage 256 0
+	_scratch_unmount
+}
+
+# Reflink a file within the subvolume.
+reflink_accounting()
+{
+	echo "reflink"
+	prepare
+	# Do enough reflinks to prove that they're free. If they counted, then this wouldn't fit in the limit.
+	for i in $(seq $(($limit_nr * 2))); do
+		_cp_reflink $subv/f $subv/f.i
+	done
+	# Confirm that there is no additional data usage from the reflinks.
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	_scratch_unmount
+}
+
+# Delete the src ref of a reflink first.
+delete_reflink_src_ref()
+{
+	echo "delete reflink src ref"
+	prepare
+	_cp_reflink $subv/f $subv/f.link
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	rm $subv/f
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	rm $subv/f.link
+	check_subvol_usage 256 $(($total_fill))
+	_scratch_unmount
+}
+
+# Delete the link ref of a reflink first.
+delete_reflink_ref()
+{
+	echo "delete reflink ref"
+	prepare
+	_cp_reflink $subv/f $subv/f.link
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	rm $subv/f.link
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	rm $subv/f
+	check_subvol_usage 256 $(($total_fill))
+	_scratch_unmount
+}
+
+basic_accounting
+reservation_accounting
+snapshot_accounting
+delete_snapshot_src_ref
+delete_snapshot_ref
+delete_snapshot_src
+delete_snapshot
+nested_accounting
+enable_mature
+reflink_accounting
+delete_reflink_src_ref
+delete_reflink_ref
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/301.out b/tests/btrfs/301.out
new file mode 100644
index 000000000..1c502689d
--- /dev/null
+++ b/tests/btrfs/301.out
@@ -0,0 +1,18 @@
+QA output created by 301
+basic accounting
+fallocate: Disk quota exceeded
+pwrite: Disk quota exceeded
+reservation accounting
+pwrite: Disk quota exceeded
+snapshot accounting
+delete src ref first
+delete snapshot ref first
+delete snapshot src first
+delete snapshot first
+nested accounting
+fallocate: Disk quota exceeded
+pwrite: Disk quota exceeded
+enable mature
+reflink
+delete reflink src ref
+delete reflink ref
-- 
2.42.0

