Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA5256F4D
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgH3QPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 12:15:36 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:55838 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgH3QPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 12:15:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07438147|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0450223-0.00189839-0.953079;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.IQDSsJp_1598804119;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IQDSsJp_1598804119)
          by smtp.aliyun-inc.com(10.147.41.143);
          Mon, 31 Aug 2020 00:15:20 +0800
Date:   Mon, 31 Aug 2020 00:15:19 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] fstests: btrfs/218 check if mount opts are applied
Message-ID: <20200830161519.GC3853@desktop>
References: <20200804205648.11284-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804205648.11284-1-marcos@mpdesouza.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 04, 2020 at 05:56:48PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This new test will apply different mount points and check if they were applied
> by reading /proc/self/mounts. Almost all available btrfs options are tested
> here, leaving only device=, which is tested in btrfs/125 and space_cache, tested
> in btrfs/131.
> 
> This test does not apply any workload after the fs is mounted, just checks is
> the option was set/unset correctly.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

I'm seeing this diff when testing with v5.9-rc2 kernel and v5.4
btrfs-progs, is that expected?

    +Could not find 'relatime,compress=lzo,space_cache,subvolid' in 'rw,relatime,compress=lzo:3,space_cache,subvolid=5,subvol=/', using 'compress=lzo'
    +Could not find 'relatime,compress=lzo,space_cache,subvolid' in 'rw,relatime,compress=lzo:3,space_cache,subvolid=5,subvol=/', using 'compress=lzo'
    +Could not find 'relatime,compress-force=lzo,space_cache,subvolid' in 'rw,relatime,compress-force=lzo:4,space_cache,subvolid=5,subvol=/', using 'compress-force=lzo'
    +Could not find 'relatime,compress-force=lzo,space_cache,subvolid' in 'rw,relatime,compress-force=lzo:4,space_cache,subvolid=5,subvol=/', using 'compress-force=lzo'
     Silence is golden

Thanks,
Eryu

> ---
>  tests/btrfs/218     | 302 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/218.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 305 insertions(+)
>  create mode 100755 tests/btrfs/218
>  create mode 100644 tests/btrfs/218.out
> 
> diff --git a/tests/btrfs/218 b/tests/btrfs/218
> new file mode 100755
> index 00000000..f6ec1ada
> --- /dev/null
> +++ b/tests/btrfs/218
> @@ -0,0 +1,302 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 218
> +#
> +# Test all existent mount options of btrfs
> +# * device= argument is already being test by btrfs/125
> +# * space cache test already covered by test btrfs/131
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +
> +cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# Compare the mounted flags with $opt_check. When the comparison fails, $opt is
> +# echoed to help to track which option was used to trigger the unexpected
> +# results.
> +test_mount_flags()
> +{
> +	local opt
> +	local opt_check
> +	opt="$1"
> +	opt_check="$2"
> +
> +	active_opt=$(cat /proc/self/mounts | grep $SCRATCH_MNT | \
> +					$AWK_PROG '{ print $4 }')
> +	if [[ "$active_opt" != *$opt_check* ]]; then
> +		echo "Could not find '$opt_check' in '$active_opt', using '$opt'"
> +	fi
> +}
> +
> +# Mounts using opt ($1), remounts using remount_opt ($2), and remounts again
> +# using opt again (1), checking if the mount opts are being enabled/disabled by
> +# using _check arguments ($3 and $4)
> +test_enable_disable_mount_opt()
> +{
> +	local opt
> +	local opt_check
> +	local remount_opt
> +	local remount_opt_check
> +	opt="$1"
> +	opt_check="$2"
> +	remount_opt="$3"
> +	remount_opt_check="$4"
> +
> +	_scratch_mount "-o $opt"
> +
> +	test_mount_flags $opt $opt_check
> +
> +	_scratch_remount $remount_opt
> +
> +	test_mount_flags $remount_opt $remount_opt_check
> +
> +	_scratch_remount $opt
> +
> +	test_mount_flags $opt $opt_check
> +
> +	_scratch_unmount
> +}
> +
> +# Checks if mount options are applied and reverted correctly.
> +# By using options to mount ($1) and remount ($2), this function will mount,
> +# remount, and the mount with the original args, checking if the mount options
> +# match the _check args ($3 and $4).
> +
> +# Later, opt and remount_opt are swapped, testing the counterpart option if used
> +# to first mount the fs.
> +test_roundtrip_mount()
> +{
> +	local opt
> +	local opt_check
> +	local remount_opt
> +	local remount_opt_check
> +	opt="$1"
> +	opt_check="$2"
> +	remount_opt="$3"
> +	remount_opt_check="$4"
> +
> +	# invert the args to make sure that both options work at mount and
> +	# remount time
> +	test_enable_disable_mount_opt $opt $opt_check $remount_opt $remount_opt_check
> +	test_enable_disable_mount_opt $remount_opt $remount_opt_check $opt $opt_check
> +}
> +
> +# Just mount and check if the options were mounted correctly by comparing the
> +# results with $opt_check
> +test_mount_opt()
> +{
> +	local opt
> +	local opt_check
> +	local active_opt
> +	opt="$1"
> +	opt_check="$2"
> +
> +	_scratch_mount "-o $opt"
> +
> +	test_mount_flags $opt $opt_check
> +
> +	_scratch_unmount
> +}
> +
> +# Test mount options that should fail, usually by wrong arguments to options
> +test_should_fail()
> +{
> +	local opt
> +	opt="$1"
> +
> +	# wrong $opt on purpose, should fail
> +	_try_scratch_mount "-o $opt" >/dev/null 2>&1
> +	if [ $? -ne 0 ]; then
> +		return
> +	fi
> +	echo "Option $opt should fail to mount"
> +	_scratch_unmount
> +}
> +
> +# Try to mount using $opt, and bail our if the mount fails without errors. If
> +# the mount succeeds, then compare the mount options with $opt_check
> +test_optional_mount_opts()
> +{
> +	local opt
> +	local opt_check
> +	opt="$1"
> +	opt_check="$2"
> +
> +	# $opt not enabled, return without running any tests
> +	_try_scratch_mount "-o $opt" >/dev/null 2>&1 || return
> +	_scratch_unmount
> +
> +	# option enabled, run the test
> +	test_mount_opt $opt $opt_check
> +}
> +
> +# Testes related to subvolumes, from subvol and subvolid options.
> +test_subvol()
> +{
> +	test_should_fail "subvol=vol2"
> +
> +	_scratch_mount "-o subvol=vol1"
> +	if [ ! -f "$SCRATCH_MNT/file.txt" ]; then
> +		echo "file.txt not found inside vol1 using subvol=vol1 mount option"
> +	fi
> +	_scratch_unmount
> +
> +	test_should_fail "subvolid=222"
> +
> +	_scratch_mount "-o subvolid=256"
> +	if [ ! -f "$SCRATCH_MNT/file.txt" ]; then
> +		echo "file.txt not found inside vol1 using subvolid=256 mount option"
> +	fi
> +	_scratch_unmount
> +
> +	# subvol and subvolid should point to the same subvolume
> +	test_should_fail "-o subvol=vol1,subvolid=1234132"
> +
> +	test_mount_opt "subvol=vol1,subvolid=256" "space_cache,subvolid=256,subvol=/vol1"
> +	test_roundtrip_mount "subvol=vol1" "space_cache,subvolid=256,subvol=/vol1" "subvolid=256" "space_cache,subvolid=256,subvol=/vol1"
> +}
> +
> +# These options are enable at kernel compile time, so no bother if they fail
> +test_optional_kernel_features()
> +{
> +	# Test options that are enabled by kernel config, and so can fail safely
> +	test_optional_mount_opts "check_int" "space_cache,check_int,subvolid"
> +	test_optional_mount_opts "check_int_data" "space_cache,check_int_data,subvolid"
> +	test_optional_mount_opts "check_int_print_mask=123" "space_cache,check_int_print_mask=123,subvolid"
> +
> +	test_should_fail "fragment=invalid"
> +	test_optional_mount_opts "fragment=all" "space_cache,fragment=data,fragment=metadata,subvolid"
> +	test_optional_mount_opts "fragment=data" "space_cache,fragment=data,subvolid"
> +	test_optional_mount_opts "fragment=metadata" "space_cache,fragment=metadata,subvolid"
> +}
> +
> +test_non_revertible_options()
> +{
> +	test_mount_opt "clear_cache" "relatime,space_cache,clear_cache,subvolid"
> +	test_mount_opt "degraded" "relatime,degraded,space_cache,subvolid"
> +
> +	test_mount_opt "inode_cache" "space_cache,inode_cache,subvolid"
> +
> +	# nologreplay should be used only with
> +	test_should_fail "nologreplay"
> +	test_mount_opt "nologreplay,ro" "ro,relatime,rescue=nologreplay,space_cache"
> +
> +	# norecovery should be used only with. This options is an alias to nologreplay
> +	test_should_fail "norecovery"
> +	test_mount_opt "norecovery,ro" "ro,relatime,rescue=nologreplay,space_cache"
> +	test_mount_opt "rescan_uuid_tree" "relatime,space_cache,rescan_uuid_tree,subvolid"
> +	test_mount_opt "skip_balance" "relatime,space_cache,skip_balance,subvolid"
> +	test_mount_opt "user_subvol_rm_allowed" "space_cache,user_subvol_rm_allowed,subvolid"
> +
> +	test_should_fail "rescue=invalid"
> +
> +	# nologreplay requires readonly
> +	test_should_fail "rescue=nologreplay"
> +	test_mount_opt "rescue=nologreplay,ro" "relatime,rescue=nologreplay,space_cache"
> +
> +	test_mount_opt "rescue=usebackuproot,ro" "relatime,space_cache,subvolid"
> +}
> +
> +# All these options can be reverted (with their "no" counterpart), or can have
> +# their values set to default on remount
> +test_revertible_options()
> +{
> +	test_roundtrip_mount "acl" "relatime,space_cache,subvolid" "noacl" "relatime,noacl,space_cache,subvolid"
> +	test_roundtrip_mount "autodefrag" "relatime,space_cache,autodefrag" "noautodefrag" "relatime,space_cache,subvolid"
> +	test_roundtrip_mount "barrier" "relatime,space_cache,subvolid" "nobarrier" "relatime,nobarrier,space_cache,subvolid"
> +
> +	test_should_fail "commit=-10"
> +	# commit=0 sets the default, so btrfs hides this mount opt
> +	test_roundtrip_mount "commit=35" "relatime,space_cache,commit=35,subvolid" "commit=0" "relatime,space_cache,subvolid"
> +
> +	test_should_fail "compress=invalid"
> +	test_should_fail "compress-force=invalid"
> +	test_roundtrip_mount "compress" "relatime,compress=zlib:3,space_cache,subvolid" "compress=lzo" "relatime,compress=lzo,space_cache,subvolid"
> +	test_roundtrip_mount "compress=zstd" "relatime,compress=zstd:3,space_cache,subvolid" "compress=no" "relatime,space_cache,subvolid"
> +	test_roundtrip_mount "compress-force=no" "relatime,space_cache,subvolid" "compress-force=zstd" "relatime,compress-force=zstd:3,space_cache,subvolid"
> +	# zlib's max level is 9 and zstd's max level is 15
> +	test_roundtrip_mount "compress=zlib:20" "relatime,compress=zlib:9,space_cache,subvolid" "compress=zstd:16" "relatime,compress=zstd:15,space_cache,subvolid"
> +	test_roundtrip_mount "compress-force=lzo" "relatime,compress-force=lzo,space_cache,subvolid" "compress-force=zlib:4" "relatime,compress-force=zlib:4,space_cache,subvolid"
> +
> +	# on remount, if we only pass datacow after nodatacow was used it will remain with nodatasum
> +	test_roundtrip_mount "nodatacow" "relatime,nodatasum,nodatacow,space_cache,subvolid" "datacow,datasum" "relatime,space_cache,subvolid"
> +	# nodatacow disabled compression
> +	test_roundtrip_mount "compress-force" "relatime,compress-force=zlib:3,space_cache,subvolid" "nodatacow" "relatime,nodatasum,nodatacow,space_cache,subvolid"
> +
> +	# nodatacow disabled both datacow and datasum, and datasum enabled datacow and datasum
> +	test_roundtrip_mount "nodatacow" "relatime,nodatasum,nodatacow,space_cache,subvolid" "datasum" "relatime,space_cache,subvolid"
> +	test_roundtrip_mount "nodatasum" "relatime,nodatasum,space_cache,subvolid" "datasum" "relatime,space_cache,subvolid"
> +
> +	test_should_fail "discard=invalid"
> +	test_roundtrip_mount "discard" "relatime,discard,space_cache,subvolid" "discard=sync" "relatime,discard,space_cache,subvolid"
> +	test_roundtrip_mount "discard=async" "relatime,discard=async,space_cache,subvolid" "discard=sync" "relatime,discard,space_cache,subvolid"
> +	test_roundtrip_mount "discard=sync" "relatime,discard,space_cache,subvolid" "nodiscard" "relatime,space_cache,subvolid"
> +
> +	test_roundtrip_mount "enospc_debug" "relatime,space_cache,enospc_debug,subvolid" "noenospc_debug" "relatime,space_cache,subvolid"
> +
> +	test_should_fail "fatal_errors=pani"
> +	# fatal_errors=bug is the default
> +	test_roundtrip_mount "fatal_errors=panic" "relatime,space_cache,fatal_errors=panic,subvolid" "fatal_errors=bug" "relatime,space_cache,subvolid"
> +
> +	test_roundtrip_mount "flushoncommit" "relatime,flushoncommit,space_cache,subvolid" "noflushoncommit" "relatime,space_cache,subvolid"
> +
> +	# 2048 is the max_inline default value
> +	test_roundtrip_mount "max_inline=1024" "relatime,max_inline=1024,space_cache" "max_inline=2048" "relatime,space_cache,subvolid"
> +
> +	test_roundtrip_mount "metadata_ratio=0" "relatime,space_cache,subvolid" "metadata_ratio=10" "space_cache,metadata_ratio=10,subvolid"
> +
> +	# ssd_spread implies ssd, while nossd_spread only disables ssd_spread
> +	test_roundtrip_mount "ssd_spread" "relatime,ssd_spread,space_cache" "nossd" "relatime,nossd,space_cache,subvolid"
> +	test_roundtrip_mount "ssd" "relatime,ssd,space_cache" "nossd" "relatime,nossd,space_cache,subvolid"
> +	test_mount_opt "ssd" "relatime,ssd,space_cache"
> +
> +	test_should_fail "thread_pool=-10"
> +	test_should_fail "thread_pool=0"
> +	test_roundtrip_mount "thread_pool=10" "relatime,thread_pool=10,space_cache" "thread_pool=50" "relatime,thread_pool=50,space_cache"
> +
> +	test_roundtrip_mount "notreelog" "relatime,notreelog,space_cache" "treelog" "relatime,space_cache,subvolid"
> +}
> +
> +# real QA test starts here
> +_scratch_mkfs >/dev/null
> +
> +# create a subvolume that will be used later
> +_scratch_mount
> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/vol1" > /dev/null
> +touch "$SCRATCH_MNT/vol1/file.txt"
> +_scratch_unmount
> +
> +test_optional_kernel_features
> +
> +test_non_revertible_options
> +
> +test_revertible_options
> +
> +test_subvol
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/218.out b/tests/btrfs/218.out
> new file mode 100644
> index 00000000..1ef372a2
> --- /dev/null
> +++ b/tests/btrfs/218.out
> @@ -0,0 +1,2 @@
> +QA output created by 218
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 32604e25..04e171ac 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -220,3 +220,4 @@
>  215 auto quick
>  216 auto quick seed
>  217 auto quick volume
> +218 auto quick
> -- 
> 2.27.0
