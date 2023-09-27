Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E27B0F73
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjI0XG3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjI0XG2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:06:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E0F4;
        Wed, 27 Sep 2023 16:06:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 75D435C2931;
        Wed, 27 Sep 2023 19:06:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 19:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695855985; x=
        1695942385; bh=U4hSwe1KPPRF70A9d8dI+BO2yNaRJe5pWjFKvfF+vhc=; b=g
        2Oej8OgENulv6f/Lp7lDBNG9ipauUegDQWHmHdP+Gq0kG9ygESHjZKcWTFzVBMhC
        XcKBIWJQVrRIlF7vvICXs+AjzZpgxPl4jp5Z+UjAC3vtxwk5xthcXWCj1xSVtCf4
        GwW6v5u6lwUTOmcjcfN5KkWV9fhYk7Wl5F4YUYP8u7y5DjYEY76HV7JHP8jPYun1
        viN/MvIR9CePRQdkHxcSB8rfJzCMTDZm0svLr6JhDS10lyNaNHuB9SeXKOP1MQ4B
        E+Ic/WwqwK0a/sYVlhicgOD0Pe/Tzf6aK1g3D2ib+ju5q+GTH7yJ1HErqUaDZT4j
        CACbPo8L91i9VKzM3cj/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695855985; x=1695942385; bh=U
        4hSwe1KPPRF70A9d8dI+BO2yNaRJe5pWjFKvfF+vhc=; b=S0mKTJj7fcoNCpy/e
        ds+eEFRx7U6ZenhV7eNayg8hxWJl06xRismVU/GAaVcb8ucGd3Z0cfpp6Koh5ybZ
        0S1SG0urn3FDosKfkSnGbOAyHOtcvlMjJ+KKcDIZf/vaF7xTv57/M6NrR9ts4kYd
        pCHdVp4MS6DKBowLuv0BpT6yQpvBCE+0EqP48o/XxONLjV++vXqG19J6o0CfPpxZ
        ZnUeMy2uXmwYyqv2Q4mXghxr4Y7TN7Z/TX+dLE48Ym229Je9o3L2da/aUuOyxHIW
        R7eJi/5CofAJW0e4rwk622+PO5RGrP++Wg1Sk2OTJVXlP3hl82BSIEc/CZac+u7e
        VGRnw==
X-ME-Sender: <xms:cbUUZYPMZQPR4fZZXUJaUNgcwUUGoC2_d4LtCE1PcqiXNQnUYnhTNw>
    <xme:cbUUZe_hz1KS74jZPySyhSepw71fa4lRFzvCkdffz8kf5JlXysbhVNmDZs4-lE77B
    edJCGGlmAxlbGPDrdw>
X-ME-Received: <xmr:cbUUZfRENInEUPP_U4K-KtXfkSHpg9H6E-8xKU9Sk3WyKpfY-8x0Ae6kXh0S7fEifLBsBxonlxV6IvOGRHaaHzZyKsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:cbUUZQsACM957NOKyWnsJtxi1rOSmYwY7_FCnsbaVtHTxxvuIgg3OQ>
    <xmx:cbUUZQer2Saiu_FhBV77QcFTFK3WHZ8ODHHms2OtwNk0BY9BPcxOOg>
    <xmx:cbUUZU24sFf5iBor-QgMqYHRqGCy3LzEOr32nh3V5p4GmCYxwf-PxQ>
    <xmx:cbUUZcHh_Jk3CbtrQf8fAZ2pKbduT0L8aH0FL6QysDYHxD3wzoB4hw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:06:24 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2 3/6] btrfs/400: new test for simple quotas
Date:   Wed, 27 Sep 2023 16:07:15 -0700
Message-ID: <4dc83ab4c30bd8a46bf9dbbfbee94a08092d24ae.1695855635.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695855635.git.boris@bur.io>
References: <cover.1695855635.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
 tests/btrfs/400     | 418 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/400.out |   2 +
 2 files changed, 420 insertions(+)
 create mode 100755 tests/btrfs/400
 create mode 100644 tests/btrfs/400.out

diff --git a/tests/btrfs/400 b/tests/btrfs/400
new file mode 100755
index 000000000..a6d59ba5e
--- /dev/null
+++ b/tests/btrfs/400
@@ -0,0 +1,418 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 400
+#
+# Test common btrfs simple quotas scenarios involving sharing extents and
+# removing them in various orders.
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup copy_range snapshot
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+_require_scratch_enable_simple_quota
+
+subv=$SCRATCH_MNT/subv
+nested=$SCRATCH_MNT/subv/nested
+snap=$SCRATCH_MNT/snap
+k=1024
+m=$(($k * $k))
+nr_fill=1024
+fill_sz=$((8 * $k))
+total_fill=$(($nr_fill * $fill_sz))
+eb_sz=$((16 * $k))
+ext_sz=$((128 * m))
+limit_nr=8
+limit=$(($ext_sz * $limit_nr))
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
+	# find nodes and leaves owned by the subvol, then get unique offsets
+	# to account for snapshots sharing metadata.
+	count=$($BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV | \
+		grep "owner $subvolid" | awk '{print $2}' | sort | uniq | wc -l)
+	# output bytes rather than number of metadata blocks
+	echo $(($count * $eb_sz))
+}
+
+check_qgroup_usage()
+{
+	local qgroupid=$1
+	local expected=$2
+	local actual=$(get_qgroup_usage $qgroupid)
+
+	[ $expected -eq $actual ] || _fail "qgroup $qgroupid mismatched usage $actual vs $expected"
+}
+
+check_subvol_usage()
+{
+	local subvolid=$1
+	local expected_data=$2
+	# need to sync to see updated usage numbers.
+	# could probably improve by placing syncs only where they are strictly
+	# needed after actual operations, but it is more error prone.
+	sync
+
+	local expected_meta=$(count_subvol_owned_metadata $subvolid)
+	local actual=$(get_subvol_usage $subvolid)
+	local expected=$(($expected_data + $expected_meta))
+
+	[ $expected -eq $actual ] || _fail "subvol $subvolid mismatched usage $actual vs $expected (expected data $expected_data expected meta $expected_meta diff $(($actual - $expected)))"
+	echo "OK $subvolid $expected_data $expected_meta $actual" >> $seqres.full
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
+sync_check_subvol_usage()
+{
+	sync
+	check_subvol_usage $@
+}
+
+trigger_cleaner()
+{
+	$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+	sleep 1
+	$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
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
+	local ret=$?
+	return $ret
+}
+
+do_enospc_write()
+{
+	local file=$1
+	local sz=$2
+
+	do_write $file $sz 2>/dev/null && _fail "write expected enospc"
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
+	do_falloc $file $sz 2>/dev/null && _fail "falloc expected enospc"
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
+	$FIO_PROG --name=filler --directory=$subv --rw=randwrite --nrfiles=$nr_fill --filesize=$fill_sz >/dev/null 2>&1
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
+	echo "snapshot" >> $seqres.full
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+}
+
+prepare_nested()
+{
+	prepare
+	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
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
+basic_accounting()
+{
+	prepare
+	echo "basic" >> $seqres.full
+	echo "delete file" >> $seqres.full
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
+reservation_accounting()
+{
+	prepare
+	for i in $(seq 10); do
+		do_write $subv/tmp 512M
+		rm $subv/tmp
+	done
+	do_enospc_write $subv/large 2G
+	_scratch_unmount
+}
+
+snapshot_accounting()
+{
+	prepare_snapshotted
+	echo "unshare snapshot metadata" >> $seqres.full
+	touch $snap/f
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+	echo "unshare snapshot data" >> $seqres.full
+	do_write $snap/f $ext_sz
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 $ext_sz
+	echo "delete snapshot file" >> $seqres.full
+	rm $snap/f
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	check_subvol_usage 257 0
+	echo "delete original file" >> $seqres.full
+	rm $subv/f
+	check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	cycle_mount_check_subvol_usage 256 $total_fill
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+delete_subvol_file()
+{
+	prepare_snapshotted
+	echo "delete subvol file first" >> $seqres.full
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
+delete_snapshot_file()
+{
+	prepare_snapshotted
+	echo "delete snapshot file first" >> $seqres.full
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
+delete_subvol()
+{
+	echo "del sv" > /dev/ksmg
+	prepare_snapshotted
+	echo "delete subvol first" >> $seqres.full
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
+delete_snapshot()
+{
+	echo "del snap" > /dev/ksmg
+	prepare_snapshotted
+	echo "delete snapshot first" >> $seqres.full
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
+nested_accounting()
+{
+	echo "nested" > /dev/ksmg
+	prepare_nested
+	echo "nested" >> $seqres.full
+	echo "delete file" >> $seqres.full
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
+	_scratch_unmount
+}
+
+enable_mature()
+{
+	echo "mature" > /dev/ksmg
+	_scratch_mkfs >> $seqres.full
+	_scratch_mount
+	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
+	do_write $subv/f $ext_sz
+	sync
+	enable_quota "s"
+	set_subvol_limit 256 $limit
+	_scratch_cycle_mount
+	usage=$(get_subvol_usage 256)
+	[ $usage -lt $ext_sz ] || _fail "captured usage from before enable $usage"
+	do_write $subv/g $ext_sz
+	usage=$(get_subvol_usage 256)
+	[ $usage -lt $ext_sz ] && "failed to capture usage after enable $usage"
+	check_subvol_usage 256 $ext_sz
+	rm $subv/f
+	check_subvol_usage 256 $ext_sz
+	_scratch_cycle_mount
+	rm $subv/g
+	check_subvol_usage 256 0
+	_scratch_unmount
+}
+
+reflink_accounting()
+{
+	prepare
+	# do more reflinks than would fit
+	for i in $(seq $(($limit_nr * 2))); do
+		cp --reflink=always $subv/f $subv/f.i
+	done
+	# no additional data usage from reflinks
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	_scratch_unmount
+}
+
+delete_link()
+{
+	prepare
+	cp --reflink=always $subv/f $subv/f.link
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	rm $subv/f.link
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	rm $subv/f
+	check_subvol_usage 256 $(($total_fill))
+	_scratch_unmount
+}
+
+delete_linked()
+{
+	prepare
+	cp --reflink=always $subv/f $subv/f.link
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	rm $subv/f
+	check_subvol_usage 256 $(($total_fill + $ext_sz))
+	rm $subv/f.link
+	check_subvol_usage 256 $(($total_fill))
+	_scratch_unmount
+}
+
+basic_accounting
+reservation_accounting
+snapshot_accounting
+delete_subvol_file
+delete_snapshot_file
+delete_subvol
+delete_snapshot
+nested_accounting
+enable_mature
+reflink_accounting
+delete_link
+delete_linked
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/400.out b/tests/btrfs/400.out
new file mode 100644
index 000000000..c940c6206
--- /dev/null
+++ b/tests/btrfs/400.out
@@ -0,0 +1,2 @@
+QA output created by 400
+Silence is golden
-- 
2.42.0

