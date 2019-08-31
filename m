Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02069A45BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2019 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfHaSKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Aug 2019 14:10:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45091 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfHaSKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Aug 2019 14:10:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so6565395pfq.12;
        Sat, 31 Aug 2019 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oG2eXxvrfCi1DE0FvLc2DS638FcAVaHdC23lrBIAz2s=;
        b=dAgncP9JueV+GT2BhDm+pB9810w4vdsJfcujAw+RT1v3xIiiL5z6WrWMY4xce9n/qx
         u15mkO0KHqzG07ikCRdewj1vQmUQDznlEnyApQHFwZWMfYih6P35S96BHD0wqXINhQEZ
         BzNPB13h7UgH2AL9Gz18JKHoRFijK9hg63+W/9qSSN3KXgiZoi6vNRscG5EdqAxQ+bvK
         LYaU/2pdRKczQxwbAYbQERYb7XO1pDiLAIFXDSGgLyWCoDSGrS2wVs0+0aKBWgT6an3F
         WYbn9NyJKmC+rRbvJ9LZLzPgCH134fS2olw+LpVamxBrQE7xuJPqSQyJqrALYJhYy3v0
         +cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oG2eXxvrfCi1DE0FvLc2DS638FcAVaHdC23lrBIAz2s=;
        b=YfUNuzJXjYNiIsWt2+6IsYYMcvvrrahE2HlMqb6ul0Tcz//tIBJmS/Fu7TD/P/b1lK
         WneYg3Z7gMEVhx4vhM5nnh19lbJqwocaCHyLQw9IfYLMK1bt9ZJPmsxBlwJTZzXZHh3D
         F+QjjugzyGlqNk7d+hJTCClofHrssHm+qpvsqgz85BolhSk5xPEDHQlVHnoBDNR4MAON
         YpX7WBSgO9gMSk4GGbHuyfSDu/7iLHjIDCrM3UlodhBZ3cRW1uLSclWYD8Ms+ROyRw8n
         3WF6MA3+hWgbcWzQMhZChI7Zvq23lhLvO9vZvnOb7TxvzCWF34tC/fY0oycXyqGK3o5/
         g4RQ==
X-Gm-Message-State: APjAAAVqX3WfikXTgfEPrYvS+Et7o2STHMn1oloaxlFQRFvbxqxGeQf8
        1ijxW6z3ZhU4apFohj/1qMY=
X-Google-Smtp-Source: APXvYqxGhmcsZG/ISErGZCiBQzPh8XAk6qAyz/JzeUS0fKRMmOfbqK0X6BYahOJWYU2YXthSNf4ZvA==
X-Received: by 2002:a63:2887:: with SMTP id o129mr17895211pgo.179.1567275017896;
        Sat, 31 Aug 2019 11:10:17 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id p1sm11056285pff.44.2019.08.31.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 11:10:16 -0700 (PDT)
Date:   Sun, 1 Sep 2019 02:10:08 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs: Check snapshot creation and deletion
 with dm-logwrites
Message-ID: <20190831181008.GD2622@desktop>
References: <20190826062045.18670-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826062045.18670-1-wqu@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 02:20:45PM +0800, Qu Wenruo wrote:
> We have generic dm-logwrites with fsstress test case (generic/482), but
> it doesn't cover fs specific operations like btrfs snapshot creation and
> deletion.
> 
> Furthermore, that test is not heavy enough to bump btrfs tree height by
> its short runtime.
> 
> And finally, btrfs check doesn't consider dirty log as an error, unlike
> ext*/xfs, that's to say we don't need to mount the fs to replay the log,
> but just run btrfs check on the fs is enough.
> 
> So introduce a similar test case but for btrfs only.
> 
> The test case will stress btrfs by:
> - Use small nodesize to bump tree height
> - Create a base tree which is already high enough
> - Trim tree blocks to find possible trim bugs
> - Call snapshot creation and deletion along with fsstress
> 
> To utilize replay-log --check and --fsck command, we fix one bug in
> replay-log first:
> - Return 1 when fsck failed
>   Original when fsck failed, run_fsck() returns -1, but to make
>   replay_log prog to return 1, we need to return a minus value, so
>   fix it by setting @ret to -EUCLEAN when run_fsck() failed, so that
>   we can detect the fsck failure by simply checking the return value
>   of replay-log.

Sorry, I didn't quite get this. run_fsck() already returns a negative
value (-1) on fsck failure (thus @ret is -1 in this case), and
replay_log exits with 1 if @ret < 0. All seem fine to me, setting
-EUCLEAN doesn't seem necessary to me. Did I miss anything?

Anyway, I think this bugfix could be in a separate patch.

> 
> Also it includes certain workaround for btrfs:
> - Use no-holes feature
>   To avoid missing hole file extents.
>   Although that behavior doesn't follow the on-disk format spec, it
>   doesn't cause data loss. And will follow the new on-disk format spec
>   of no-holes feature, so it's better to workaround it.
> 
> And an optimization for btrfs only:
> - Use replay-log --fsck/--check command
>   Since dm-log-writes records bios sequentially, there is no way to
>   locate certain entry unless we iterate all entries.
>   This is becoming a big performance penalty if we replay certain a
>   range, check the fs, then re-execute replay-log to replay another
>   range.
> 
>   We need to records the previous entry location, or we need to
>   re-iterate all previous entries.
> 
>   Thankfully, replay-log has already address it by providing --fsck and
>   --check command, thus we don't need to break replay-log command.
> 
> Please note, for fast storage (e.g. fast NVME or unsafe cache mode),
> it's recommended to use log devices larger than 15G, or we can't record
> the full log of just 30s fsstress run.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> For the log devices size problem, I have submitted dm-logwrites bio flag
> filter support, to filter out data bios.
> 
> But that is not yet merged into kernel, thus we need a large log device
> for short run.
> 
> For reference, if using unsafe cache mode for all test devices, on a
> system with 32G dual-channel DDR4 3200 RAM, 5G log device will be
> filled up in less than 15 seconds.
> So to ensure dm-log-writes covers all the operations, one needs at least
> 15G log device, and even more if using RAM with more channels.
> 
> Changelog:
> v2
> - Better expression/words for comment
> - Add requirement for no-holes features
> - Use xattr to bump up tree height
>   So no need for max_inline mount option
> - Coding style fixes for function definition
> - Add -f for rm to avoid user alias setting
> - Add new workload (update time stamp and create new files) for snapshot
>   workload
> - Remove an unnecessary sync call
> - Get rid of wrong 2>&1 redirection
> - Add to group "snapshot" and "stress"
> 
> v3:
> - Add '_require_attrs' and source common/attr
> - Introduce '_require_fsck_not_report_dirty_logs_as_error'
> - Add comment for the replay-log code fix
> - Wait after killing all background fsstress
> - Use $BLKDISCARD_PROG instead of plain 'blkdiscard'
> - Add trap for snapshot and delete workload
> ---
>  common/config               |   1 +
>  common/dmlogwrites          |  44 ++++++++++
>  src/log-writes/replay-log.c |   2 +
>  tests/btrfs/192             | 156 ++++++++++++++++++++++++++++++++++++
>  tests/btrfs/192.out         |   2 +
>  tests/btrfs/group           |   1 +
>  6 files changed, 206 insertions(+)
>  create mode 100755 tests/btrfs/192
>  create mode 100644 tests/btrfs/192.out
> 
> diff --git a/common/config b/common/config
> index bd64be62..4c86a492 100644
> --- a/common/config
> +++ b/common/config
> @@ -183,6 +183,7 @@ export LOGGER_PROG="$(type -P logger)"
>  export DBENCH_PROG="$(type -P dbench)"
>  export DMSETUP_PROG="$(type -P dmsetup)"
>  export WIPEFS_PROG="$(type -P wipefs)"
> +export BLKDISCARD_PROG="$(type -P blkdiscard)"
>  export DUMP_PROG="$(type -P dump)"
>  export RESTORE_PROG="$(type -P restore)"
>  export LVM_PROG="$(type -P lvm)"
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index ae2cbc6a..474ec570 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -175,3 +175,47 @@ _log_writes_replay_log_range()
>  		>> $seqres.full 2>&1
>  	[ $? -ne 0 ] && _fail "replay failed"
>  }
> +
> +# Require fsck not to report dirty logs as error
> +#
> +# This is a special requirement to use _log_writes_fast_replay_check
> +# The reasons are:
> +# - To avoid unnecessary seek when there are a lot of entries
> +#   replay-log doesn't have a tree-like structure to do fast index,
> +#   thus it iterate all entries one by one, this can be very slow
> +# - No way to revert the log replay for next check
> +#   A lot of fsck will replay the log, which will pollute the replay device
> +#   for next entry
> +_require_fsck_not_report_dirty_logs_as_error()
> +{
> +	if [ $FSTYP != "btrfs" ]; then
> +		_notrun "fsck of $FSTYP reports dirty jounal/log as error, skipping test"
> +	fi
> +}

The rule name seems ugly :)

> +
> +# Replay and check each fua/flush (specified by $2) point.
> +#
> +# Since dm-log-writes records bio sequentially, even just replaying a range
> +# still needs to iterate all records before the end point.
> +# When number of records grows, it will be unacceptably slow, thus we need
> +# to use relay-log itself to trigger fsck, avoid unnecessary seek.
> +_log_writes_fast_replay_check()
> +{
> +	local check_point=$1
> +	local blkdev=$2
> +	local fsck_command
> +
> +	_require_fsck_not_report_dirty_logs_as_error
> +
> +	[ -z "$check_point" -o -z "$blkdev" ] && _fail \
> +	"check_point and blkdev must be specified for _log_writes_fast_replay_check"
> +	case $FSTYP in
> +	btrfs)
> +		fsck_command="$BTRFS_UTIL_PROG check $blkdev"
> +		;;
> +	esac
> +	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> +		--replay $blkdev --check $check_point --fsck "$fsck_command" \
> +		2>&1 | tail -n 128 >> $seqres.full
> +	[ $? -ne 0 ] && _fail "fsck failed during replay"
> +}

And I think we could make _log_writes_fast_replay_check(), which seems
only useful to btrfs, a local function in the test, so we avoid all
these $FSTYP == btrfs checks.

Thanks,
Eryu

> diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c
> index 829b18e2..1e1cd524 100644
> --- a/src/log-writes/replay-log.c
> +++ b/src/log-writes/replay-log.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
> +#include <errno.h>
>  #include <unistd.h>
>  #include <getopt.h>
>  #include <stdlib.h>
> @@ -375,6 +376,7 @@ int main(int argc, char **argv)
>  				fprintf(stderr, "Fsck errored out on entry "
>  					"%llu\n",
>  					(unsigned long long)log->cur_entry - 1);
> +				ret = -EUCLEAN;
>  				break;
>  			}
>  		}
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> new file mode 100755
> index 00000000..db9bc40e
> --- /dev/null
> +++ b/tests/btrfs/192
> @@ -0,0 +1,156 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 192
> +#
> +# Test btrfs consistency after each FUA for a workload with snapshot creation
> +# and removal
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	kill -q $pid1 &> /dev/null
> +	kill -q $pid2 &> /dev/null
> +	"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
> +	wait
> +	_log_writes_cleanup &> /dev/null
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +. ./common/dmlogwrites
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +
> +_require_command "$KILLALL_PROG" killall
> +_require_command "$BLKDISCARD_PROG" blkdiscard
> +_require_btrfs_fs_feature "no_holes"
> +_require_btrfs_mkfs_feature "no-holes"
> +_require_fsck_not_report_dirty_logs_as_error
> +_require_log_writes
> +_require_scratch
> +_require_attrs
> +
> +# To generate 3 level fs tree for 64K nodesize, we need 32768 xattr items.
> +# That will cause too many transactions, bumping replay check time
> +# from ~60s to ~300s. (VM alreayd using unsafe cache for the test devices)
> +# So here we skip non-4K page size system, in favor of a shorter default
> +# test time
> +if [ $(get_page_size) -ne 4096 ]; then
> +	_notrun "This test doesn't support non-4K page size yet"
> +fi
> +
> +runtime=30
> +nr_cpus=$("$here/src/feature" -o)
> +# cap nr_cpus to 8 to avoid spending too much time on hosts with many cpus
> +if [ $nr_cpus -gt 8 ]; then
> +	nr_cpus=8
> +fi
> +fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 99999 -p $nr_cpus \
> +		$FSSTRESS_AVOID)
> +_log_writes_init $SCRATCH_DEV
> +
> +# Discard the whole devices so when some tree pointer is wrong, it won't point
> +# to some older valid tree blocks, so we can detect it.
> +$BLKDISCARD_PROG $LOGWRITES_DMDEV > /dev/null 2>&1
> +
> +# Workaround minor file extent discountinous.
> +# And use 4K nodesize to bump tree height.
> +_log_writes_mkfs -O no-holes -n 4k >> $seqres.full
> +_log_writes_mount
> +
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/src > /dev/null
> +mkdir -p $SCRATCH_MNT/snapshots
> +mkdir -p $SCRATCH_MNT/src/padding
> +
> +random_file()
> +{
> +	local basedir=$1
> +	echo "$basedir/$(ls $basedir | sort -R | tail -1)"
> +}
> +
> +snapshot_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +
> +	local i=0
> +	while true; do
> +		$BTRFS_UTIL_PROG subvolume snapshot \
> +			$SCRATCH_MNT/src $SCRATCH_MNT/snapshots/$i \
> +			> /dev/null
> +		# Do something small to make snapshots different
> +		rm -f "$(random_file $SCRATCH_MNT/src/padding)"
> +		rm -f "$(random_file $SCRATCH_MNT/src/padding)"
> +		touch "$(random_file $SCRATCH_MNT/src/padding)"
> +		touch "$SCRATCH_MNT/src/padding/random_$RANDOM"
> +
> +		i=$(($i + 1))
> +		sleep 1
> +	done
> +}
> +
> +delete_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +
> +	while true; do
> +		sleep 2
> +		$BTRFS_UTIL_PROG subvolume delete \
> +			"$(random_file $SCRATCH_MNT/snapshots)" \
> +			> /dev/null 2>&1
> +	done
> +}
> +
> +xattr_value=$(printf '%0.sX' $(seq 1 3800))
> +
> +# Bumping tree height to level 2.
> +for ((i = 0; i < 64; i++)); do
> +	touch "$SCRATCH_MNT/src/padding/$i"
> +	$SETFATTR_PROG -n 'user.x1' -v $xattr_value \
> +		"$SCRATCH_MNT/src/padding/$i"
> +done
> +
> +_log_writes_mark prepare
> +
> +snapshot_workload &
> +pid1=$!
> +delete_workload &
> +pid2=$!
> +
> +"$FSSTRESS_PROG" $fsstress_args > /dev/null &
> +sleep $runtime
> +
> +"$KILLALL_PROG" -q "$FSSTRESS_PROG" &> /dev/null
> +kill $pid1 &> /dev/null
> +kill $pid2 &> /dev/null
> +wait
> +_log_writes_unmount
> +_log_writes_remove
> +
> +_log_writes_fast_replay_check fua "$SCRATCH_DEV"
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/192.out b/tests/btrfs/192.out
> new file mode 100644
> index 00000000..6779aa77
> --- /dev/null
> +++ b/tests/btrfs/192.out
> @@ -0,0 +1,2 @@
> +QA output created by 192
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 2474d43e..cab10d19 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -194,3 +194,4 @@
>  189 auto quick send clone
>  190 auto quick replay balance qgroup
>  191 auto quick send dedupe
> +192 auto replay snapshot stress
> -- 
> 2.22.0
> 
