Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328C9749200
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjGEXni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjGEXnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:43:37 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE912A;
        Wed,  5 Jul 2023 16:43:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 723195C00D6;
        Wed,  5 Jul 2023 19:43:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600615; x=
        1688687015; bh=z/o+C8Lp/wlRnbZolAKi5uQOd7m7A61QQAEehWIPAB8=; b=W
        oJhSrGypwKXWuTTuri1myvUCqLx/F3dyQbeSvRvXAzqbGxCHfzjklGaFL01ynkez
        W8Lns7zl2OEyYS8ALfalivj00fF+Kolc0i5x6879WKtPFMaZuIHlQqLkDMMVfC+V
        ifNK6FLwcByVJ3j4/Rnc3VUShZPFSocIaS7xcwq3pRd0ppVb6c/xrMtV84aGGKiX
        my80emK0ck7YNq35G9JpwGdmnJlVXMf+g8S1QCUNlWN5Csf/xSsMfp/8HePph+st
        vmhgItvsxXX0AlBljhTkoDt2Y5PBwsIL8+cPL4y7KpBZ6hwxBiEdA3k3+xM/qMOo
        PLVWljaXxcsO/UEHsa7Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600615; x=1688687015; bh=z
        /o+C8Lp/wlRnbZolAKi5uQOd7m7A61QQAEehWIPAB8=; b=kodMsaA9cCQD4zj1Q
        zNlYnDvy/s+GEksrsSMWoiOS+7EGAVZL06P7/MprWLEghVg4E8aSie3KS++QE2VQ
        ASOcaiL2AKqCuFCdhyVnHMBJBueCFYyGYTY9o+IxiZNylSlsVfYymVx+41+I1WIo
        LkTmxxghiOdLs7IqmGQxlgANycYRmKYhP8koDHrz/+Gq2OUfm1516N1X9LsSxli2
        L2dUdDLu/UJ+HjK67E/iyUnQeqIsHT6rPhJ/0BQIUrS66TDyhw8AUwo7XeptcrSI
        BGotT5T2kd6deuq/d2IvwJks8/trq4yxtLzAF8N4ETEVx05pYoMAEi0xQgvTVgB5
        qh2iQ==
X-ME-Sender: <xms:JwCmZEJVVAmK7aZwXwBE4VRh8mnKkQNVYcgj059RiVKDDyBS2AXkSg>
    <xme:JwCmZEK1T9oCiCDaEj0c9AOnBIBkoRNy36tAR5b2ygxctuA9wCDgJmCPOoNOnDTKR
    sUrF3OnjQB5NTjcGos>
X-ME-Received: <xmr:JwCmZEvRAd3vfFfHiVExJ7s1gnTa2jxdmpoWkonpbVSYnsYPPaludDyW1W9mK8eiKq8Dv-4egnbCHye7O-XHGmq6TYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:JwCmZBbr1vuxcA65ClqmlJgfmaf4LibLzEnJmThQilbyr8WWq3792w>
    <xmx:JwCmZLagQ1qQor0_oorG1zT3p2TGJ5yEj24uFZEqLFJyUpjrxtx-zg>
    <xmx:JwCmZNCN3a3he5sjgYGKwIPeAJ4v51bkdMPQ0YdmuCH7EnNxn1iDAw>
    <xmx:JwCmZCwDPLJX7X72WTIXCyeW70gH7nO-HVT0OFlJcckg3rQF7l_O6Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:43:34 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH 1/5] btrfs/400: new test for simple quotas
Date:   Wed,  5 Jul 2023 16:42:23 -0700
Message-ID: <9df2554d5e427e47290a10cbfccf20305472c958.1688600422.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688600422.git.boris@bur.io>
References: <cover.1688600422.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 tests/btrfs/400     | 439 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/400.out |   2 +
 2 files changed, 441 insertions(+)
 create mode 100755 tests/btrfs/400
 create mode 100644 tests/btrfs/400.out

diff --git a/tests/btrfs/400 b/tests/btrfs/400
new file mode 100755
index 000000000..c3548d42e
--- /dev/null
+++ b/tests/btrfs/400
@@ -0,0 +1,439 @@
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
+
+SUBV=$SCRATCH_MNT/subv
+NESTED=$SCRATCH_MNT/subv/nested
+SNAP=$SCRATCH_MNT/snap
+K=1024
+M=$(($K * $K))
+NR_FILL=1024
+FILL_SZ=$((8 * $K))
+TOTAL_FILL=$(($NR_FILL * $FILL_SZ))
+EB_SZ=$((16 * $K))
+EXT_SZ=$((128 * M))
+LIMIT_NR=8
+LIMIT=$(($EXT_SZ * $LIMIT_NR))
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
+	echo $(($count * $EB_SZ))
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
+	echo "trigger cleaner" > /dev/kmsg
+	$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+	sleep 1
+	$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+	echo "cleaner triggered" > /dev/kmsg
+}
+
+cycle_mount_check_subvol_usage()
+{
+	echo "cycle mounting" > /dev/kmsg
+	_scratch_cycle_mount
+	check_subvol_usage $@
+	echo "cycle mount done" > /dev/kmsg
+}
+
+
+do_write()
+{
+	local file=$1
+	local sz=$2
+
+	echo "write" > /dev/kmsg
+	$XFS_IO_PROG -fc "pwrite -q 0 $sz" $file
+	local ret=$?
+	echo "write done" > /dev/kmsg
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
+	echo "preparing" > /dev/kmsg
+	_scratch_mkfs >> $seqres.full
+	_scratch_mount
+	enable_quota "s"
+	$BTRFS_UTIL_PROG subvolume create $SUBV >> $seqres.full
+	set_subvol_limit 256 $LIMIT
+	check_subvol_usage 256 0
+
+	echo "filling" > /dev/kmsg
+	# Create a bunch of little filler files to generate several levels in
+	# the btree, to make snapshotting sharing scenarios complex enough.
+	$FIO_PROG --name=filler --directory=$SUBV --rw=randwrite --nrfiles=$NR_FILL --filesize=$FILL_SZ >/dev/null 2>&1
+	echo "filled" > /dev/kmsg
+	check_subvol_usage 256 $TOTAL_FILL
+
+	# Create a single file whose extents we will explicitly share/unshare.
+	do_write $SUBV/f $EXT_SZ
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	echo "prepared" > /dev/kmsg
+}
+
+prepare_snapshotted()
+{
+	echo "prepare snapshotted" > /dev/kmsg
+	prepare
+	$BTRFS_UTIL_PROG subvolume snapshot $SUBV $SNAP >> $seqres.full
+	echo "snapshot" >> $seqres.full
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	check_subvol_usage 257 0
+	echo "prepared snapshotted" > /dev/kmsg
+}
+
+prepare_nested()
+{
+	echo "prepare nested" > /dev/kmsg
+	prepare
+	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup assign 0/256 1/100 $SCRATCH_MNT >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume create $NESTED >> $seqres.full
+	do_write $NESTED/f $EXT_SZ
+	check_subvol_usage 257 $EXT_SZ
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	local subv_usage=$(get_subvol_usage 256)
+	local nested_usage=$(get_subvol_usage 257)
+	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
+	echo "prepared nested" > /dev/kmsg
+}
+
+basic_accounting()
+{
+	echo "basic" > /dev/kmsg
+	prepare
+	echo "basic" >> $seqres.full
+	echo "delete file" >> $seqres.full
+	rm $SUBV/f
+	check_subvol_usage 256 $TOTAL_FILL
+	cycle_mount_check_subvol_usage 256 $TOTAL_FILL
+	do_write $SUBV/tmp 512M
+	rm $SUBV/tmp
+	do_write $SUBV/tmp 512M
+	rm $SUBV/tmp
+	do_enospc_falloc $SUBV/large_falloc 2G
+	do_enospc_write $SUBV/large 2G
+	_scratch_unmount
+}
+
+reservation_accounting()
+{
+	echo "rsv" > /dev/kmsg
+	prepare
+	for i in $(seq 10); do
+		do_write $SUBV/tmp 512M
+		rm $SUBV/tmp
+	done
+	do_enospc_write $SUBV/large 2G
+	_scratch_unmount
+}
+
+snapshot_accounting()
+{
+	echo "snap" > /dev/kmsg
+	prepare_snapshotted
+	echo "unshare snapshot metadata" >> $seqres.full
+	touch $SNAP/f
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	check_subvol_usage 257 0
+	echo "unshare snapshot data" >> $seqres.full
+	do_write $SNAP/f $EXT_SZ
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	check_subvol_usage 257 $EXT_SZ
+	echo "delete snapshot file" >> $seqres.full
+	rm $SNAP/f
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	check_subvol_usage 257 0
+	echo "delete original file" >> $seqres.full
+	rm $SUBV/f
+	check_subvol_usage 256 $TOTAL_FILL
+	check_subvol_usage 257 0
+	cycle_mount_check_subvol_usage 256 $TOTAL_FILL
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+delete_subvol_file()
+{
+	echo "del sv ref" > /dev/kmsg
+	prepare_snapshotted
+	echo "delete subvol file first" >> $seqres.full
+	rm $SUBV/f
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	check_subvol_usage 257 0
+	rm $SNAP/f
+	trigger_cleaner
+	check_subvol_usage 256 $TOTAL_FILL
+	check_subvol_usage 257 0
+	cycle_mount_check_subvol_usage 256 $TOTAL_FILL
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+delete_snapshot_file()
+{
+	echo "del snap ref" > /dev/kmsg
+	prepare_snapshotted
+	echo "delete snapshot file first" >> $seqres.full
+	rm $SNAP/f
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	check_subvol_usage 257 0
+	rm $SUBV/f
+	check_subvol_usage 256 $TOTAL_FILL
+	check_subvol_usage 257 0
+	cycle_mount_check_subvol_usage 256 $TOTAL_FILL
+	check_subvol_usage 257 0
+	_scratch_unmount
+}
+
+delete_subvol()
+{
+	echo "del sv" > /dev/ksmg
+	prepare_snapshotted
+	echo "delete subvol first" >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume delete $SUBV >> $seqres.full
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	check_subvol_usage 257 0
+	rm $SNAP/f
+	trigger_cleaner
+	check_subvol_usage 256 $TOTAL_FILL
+	check_subvol_usage 257 0
+	$BTRFS_UTIL_PROG subvolume delete $SNAP >> $seqres.full
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
+	$BTRFS_UTIL_PROG subvolume delete $SNAP >> $seqres.full
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	check_subvol_usage 257 0
+	$BTRFS_UTIL_PROG subvolume delete $SUBV >> $seqres.full
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
+	rm $SUBV/f
+	check_subvol_usage 256 $TOTAL_FILL
+	check_subvol_usage 257 $EXT_SZ
+	local subv_usage=$(get_subvol_usage 256)
+	local nested_usage=$(get_subvol_usage 257)
+	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
+	rm $NESTED/f
+	check_subvol_usage 256 $TOTAL_FILL
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
+	$BTRFS_UTIL_PROG subvolume create $SUBV >> $seqres.full
+	do_write $SUBV/f $EXT_SZ
+	sync
+	enable_quota "s"
+	set_subvol_limit 256 $LIMIT
+	_scratch_cycle_mount
+	usage=$(get_subvol_usage 256)
+	[ $usage -lt $EXT_SZ ] || _fail "captured usage from before enable $usage"
+	do_write $SUBV/g $EXT_SZ
+	usage=$(get_subvol_usage 256)
+	[ $usage -lt $EXT_SZ ] && "failed to capture usage after enable $usage"
+	check_subvol_usage 256 $EXT_SZ
+	rm $SUBV/f
+	check_subvol_usage 256 $EXT_SZ
+	_scratch_cycle_mount
+	rm $SUBV/g
+	check_subvol_usage 256 0
+	_scratch_unmount
+}
+
+reflink_accounting()
+{
+	echo "reflink" > /dev/kmsg
+	prepare
+	# do more reflinks than would fit
+	for i in $(seq $((NR_LIMIT * 2))); do
+		cp --reflink=always $SUBV/f $SUBV/f.i
+	done
+	# no additional data usage from reflinks
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	_scratch_unmount
+}
+
+delete_link()
+{
+	echo "delete link first" > /dev/kmsg
+	prepare
+	cp --reflink=always $SUBV/f $SUBV/f.link
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	rm $SUBV/f.link
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	rm $SUBV/f
+	check_subvol_usage 256 $(($TOTAL_FILL))
+	_scratch_unmount
+}
+
+delete_linked()
+{
+	echo "delete linked first" > /dev/kmsg
+	prepare
+	cp --reflink=always $SUBV/f $SUBV/f.link
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	rm $SUBV/f
+	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
+	rm $SUBV/f.link
+	check_subvol_usage 256 $(($TOTAL_FILL))
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
2.41.0

