Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A89BE69
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2019 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfHXPMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Aug 2019 11:12:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32975 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfHXPMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Aug 2019 11:12:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so8690628pfq.0;
        Sat, 24 Aug 2019 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dopxpir0RER7R+Chd1vkNtFR9HCbjI81XGxHHbDgoqA=;
        b=rvZ0vNBxWIe8IZfPvec4Nlqx/QUYY/6dnu2nNnLgU+H1NWRKK3AvPKpKCdPDVglm8V
         Gr+G6V6UtGAv2rig2oMioeqtfyvx1o6ORqnEtsp6fW+7L5CPcaxep6+qXVm9SDWzfYhj
         4ZkgkL2pkYDSFiq+EzqxumSniVnjrodwgD9RF/tCwh389TpBhs/m6E06UXHfk5rE9WYl
         ATpfsrqq8O6BRxa6hAHUUJv2vz7cXPqQMaxXNbaR1YPduL33+OJft8jwBV+irYdoYBJh
         vdR8fKrHGYIi1R7DxjBepQxRrExkTwFMbS4tHJqDrSi+hVxLNIE69CSJHq7UZ5pvM0LY
         f+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dopxpir0RER7R+Chd1vkNtFR9HCbjI81XGxHHbDgoqA=;
        b=LwjFlE/soOAyCf9L2S0lYa9m7YmvS6QQ7fpxmyqsm7v6v7RJ69h50e+imcbJw0zZz2
         WzuA06olEoqS+YlK0RpyQbJkvIy1XbDscDgqTpxAjFgLAHV3wa8rjbz3LIdr8xdGDZPo
         XUaHyCB2drZCBWE9TNm2cw9OwhE1f6tvEYQG8Gn866IbZa1lcnCHjhxi8vr39UuXUXAp
         pKd77504t9s99b0cZPaeHz8E0PjfoKkBZuyCy5kfapdKL+Yt6mlKIDsEfV0u/9Fk04Jh
         YsuSDtFkjjFmj1+OdxbPuck+72yXEAVb4XxzDBjv94Lv0IWkG1CmjHG1vqL41QCfl8Dm
         5g2w==
X-Gm-Message-State: APjAAAWumkgrdvoPjH4nB8b9R1NhR120cTuhlYh4C2ZNHb5QU1MXh4LQ
        RQfaS0IGLx62P8pGMxuPEMM=
X-Google-Smtp-Source: APXvYqw4h9lEDSbhONCyCLgzHO5LlmBwNCInrQlWQexFLJKHYN9vo0InwYR0fO3OnN8dKBVyqMfGRg==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr8710497pgt.365.1566659570968;
        Sat, 24 Aug 2019 08:12:50 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id r27sm5574677pgn.25.2019.08.24.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 08:12:49 -0700 (PDT)
Date:   Sat, 24 Aug 2019 23:12:35 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs: Check snapshot creation and deletion
 with dm-logwrites
Message-ID: <20190824151235.GA2622@desktop>
References: <20190819081806.32728-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819081806.32728-1-wqu@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 19, 2019 at 04:18:06PM +0800, Qu Wenruo wrote:
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
> Changelog:
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
> ---
>  common/config               |   1 +
>  common/dmlogwrites          |  28 +++++++
>  src/log-writes/replay-log.c |   2 +
>  tests/btrfs/192             | 149 ++++++++++++++++++++++++++++++++++++
>  tests/btrfs/192.out         |   2 +
>  tests/btrfs/group           |   1 +
>  6 files changed, 183 insertions(+)
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
> index ae2cbc6a..3292544a 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -175,3 +175,31 @@ _log_writes_replay_log_range()
>  		>> $seqres.full 2>&1
>  	[ $? -ne 0 ] && _fail "replay failed"
>  }
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
> +	[ -z "$check_point" -o -z "$blkdev" ] && _fail \
> +	"check_point and blkdev must be specified for _log_writes_fast_replay_check"
> +
> +	# Check program must not treat dirty log as an error.
> +	# So only btrfs can use this feature
> +	if [ $FSTYP = "btrfs" ]; then
> +		fsck_command="$BTRFS_UTIL_PROG check $blkdev"
> +	else
> +		_notrun "fsck of $FSTYP reports dirty jounal/log as error, skipping test"
> +	fi

Hmm, it'd better to introduce a new require rule and call it in the test
instead of calling _notrun in a do_something function.

> +	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> +		--replay $blkdev --check $check_point --fsck "$fsck_command" \
> +		2>&1 | tail -n 128 >> $seqres.full
> +	[ $? -ne 0 ] && _fail "fsck failed during replay"
> +}
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

This part is not mentioned in commit log.

>  				break;
>  			}
>  		}
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> new file mode 100755
> index 00000000..85cdb43f
> --- /dev/null
> +++ b/tests/btrfs/192
> @@ -0,0 +1,149 @@
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
> +	wait
> +	$KILLALL_PROG -q $FSSTRESS_PROG &> /dev/null

Seems you should kill fsstress first then wait for all background
processes.

> +	_log_writes_cleanup &> /dev/null
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
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
> +_require_log_writes
> +_require_scratch

_require_attrs

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
> +# to some older tree blocks, and we can detect it.
> +blkdiscard $LOGWRITES_DMDEV

$BLKDISCARD_PROG $LOGWRITES_DMDEV >/dev/null 2>&1

Use $BLKDISCARD_PROG you just defined :) And blkdiscard will print error
messages if the device doesn't support discard.

> +
> +# Workaround minor file extent discountinous.
> +# And use 4K nodesize to bump tree height
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

Add a trap to make sure all sub-commands exit before exiting this
function? Like what btrfs/187 does, i.e.

	trap "wait; exit" SIGTERM

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

Same here.

Thanks,
Eryu

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
