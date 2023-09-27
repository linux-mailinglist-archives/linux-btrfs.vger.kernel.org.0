Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9917B0F80
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjI0XNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjI0XNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:13:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC71F4;
        Wed, 27 Sep 2023 16:13:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 35ED25C290D;
        Wed, 27 Sep 2023 19:13:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Sep 2023 19:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695856424; x=
        1695942824; bh=tyNyhvTTmIo5w+mGmKoAp84+yMblo611ZQp16wug6UM=; b=f
        xVtkSe1DucgwQprNjV7bmJ6/3jxVId8igwl0m5gIdVt9nZhTka77PJp5F6PtSVnw
        Izdlnfygd2dODVnFuF+oLPDkdS6/+MEXuZ2I9095U4gRlfE0LxEH6ufAVOpkOt9E
        xVHjhwwVS+hhrZz6zR3YWrIhGuwA1gawDmHVerWDpwZR26xI+BeeeSTfFRVBzXRE
        E3bEsxxsjxlrJtDI+iX6+uapyFNiRk1/aDQF/xgvf3Jjka6k6tdnvms69e+r8Yfj
        XKkObJ8l3iREfzFtSB7uHTK0bAvX/u8NdE1lt2S9iqzX/yMmBNvCFws61+E2u7P3
        c5Nv/gCjQruYQo4ogd3dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695856424; x=1695942824; bh=t
        yNyhvTTmIo5w+mGmKoAp84+yMblo611ZQp16wug6UM=; b=KYLMBbRNdug+Td7PW
        VWj1+qkYsggZVCCz1/4zpuoOcLbizSJCrFM3dS5QuUV5rgwTSJCB+C6KMxN3aufQ
        9rLJjG2wa6gOhkiIEf5kCdZoWk9flLPkVQkG5PPYZfFrPoZ0jeVdLK1CvikjAXeR
        g6Sb7xxhW2DhQXuEznQYkqrYg00XpAlkdzdqXeRZjcRr+2Sl1SY53zM8p+qOVzxl
        tB0fVyy/gLeJzMzEIuH2uUhffI+MBpewi9AEYMcYENkHXy1VIKvaAYAXb7usytVy
        wnQpcVjb6jIjZNrpfKE5FnPut8ohLIz0BjbgVFwVyyDRRkYOnkDB/1Wu+NHd8QA7
        Ui4SQ==
X-ME-Sender: <xms:KLcUZQ-M5GPFhJt9Sl62bXRnkfx6EsfQsYOUPCSN2Z1Pc3ZaWvLvsw>
    <xme:KLcUZYs470XP4hU9ihgQC8n_d2dxd69ERL-S4BwaXHi7dR8U_Iah9wL3JqwNCMs1Q
    Y89wH1wfzdLXXtE4JY>
X-ME-Received: <xmr:KLcUZWBNLFWRtZE9PWcowqXsZsCr_KFyFRyXMf3fzdgoOmFXkxj23tQUvJexn-fGbmqUhcifSlMSqX1TXNYX9ve-ytU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:KLcUZQeexOpWFATlqf-OV332Kq9G7KTFFeNMj_eFadqsBuUQIrSqcQ>
    <xmx:KLcUZVNXaZjVh_3zmV8fkE3XQ441eSLvKC5fSsaPiPWcyhFMAf06yg>
    <xmx:KLcUZalcuYTFbavqrO0oZdvxza2iyxQOeg8C1eag6Ino39QEQXa42g>
    <xmx:KLcUZT3D2KyxVzxNuO7ISoOnZYkHOG3qlxb4hQQXHpQPPzv2aQV5Nw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:13:43 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v3 3/6] btrfs/301: new test for simple quotas
Date:   Wed, 27 Sep 2023 16:14:35 -0700
Message-ID: <a1887b9e67676ed2b46f664126aa3ebf6864f9d6.1695856385.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695856385.git.boris@bur.io>
References: <cover.1695856385.git.boris@bur.io>
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
 tests/btrfs/301     | 418 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/301.out |   2 +
 2 files changed, 420 insertions(+)
 create mode 100755 tests/btrfs/301
 create mode 100644 tests/btrfs/301.out

diff --git a/tests/btrfs/301 b/tests/btrfs/301
new file mode 100755
index 000000000..527c25230
--- /dev/null
+++ b/tests/btrfs/301
@@ -0,0 +1,418 @@
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
diff --git a/tests/btrfs/301.out b/tests/btrfs/301.out
new file mode 100644
index 000000000..4025504e4
--- /dev/null
+++ b/tests/btrfs/301.out
@@ -0,0 +1,2 @@
+QA output created by 301
+Silence is golden
-- 
2.42.0

