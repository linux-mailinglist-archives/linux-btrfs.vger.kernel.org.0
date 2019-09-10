Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7BAECF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfIJO22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 10:28:28 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42810 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfIJO21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 10:28:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id m22so11374920vsl.9;
        Tue, 10 Sep 2019 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ivcjOItSPVTaJr8mW31KMDqWm4OkMzFtZOZZOWo7SCU=;
        b=ManJy8W98JhB5D0vcWBT5fK3RHx9IX/LT5kPp+4fTYyLGfDb+e21d41inP9ypdZ6aV
         o1NbmLfvyg2E4+pY8V0E8zM+VwNEojGbcF3wJZgCr+QvqJXbFjwlzGKSd0vQ9LAwZ7jO
         ddWjIBLOXotEO0OWRg/eiylVn1Nk9Rqsh/FxAT1ZbG+y+7HPtHLXRt++EP5B/yjU5oZl
         WJTjB+zIhe6ZN3wYA+1EfNQqMmPNBz68CEG3eg2RNSYERB8hsrLY8ZmERJEBGsIdKm17
         MeT/iY2Eic3Eaa6EvhNTFz0JKlfnfNhUV0d74fgzl43C95HdyYdckbjG1bQ+4KWscKKE
         wkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ivcjOItSPVTaJr8mW31KMDqWm4OkMzFtZOZZOWo7SCU=;
        b=HI0NqtCzYtAiD02Hxy1JWWJNy+GafGs/IB9WXQwz1ZZK6mzZLuT0dyfQStCMQXEgRX
         gOHP6+0C0Kqh8/+nqpC9u8BTRJhhOrO/V+fku1WXtaxnRwllrKjgjbX/bJzvCdt+0ieD
         2vFFKdviuJDQNtm+Oz8IO5yOOBtJFc40DxbcgK49htUrhVWbIm3BDB7WOO5b8cT1hJNt
         6AeYfsoB1cLosZ7yTZhEpKlzdzqrSlMkuK3aUYrtXp0dOCf4tbhFKg1L3r2n2BMM0cdn
         pCuLAWu7d65boIllXdZTnU7fhuxhe2OCNGWTytMqnDdViQIjf9gpnDKKwVXRu7TNeopF
         pX+A==
X-Gm-Message-State: APjAAAXJS697cfgCGOZgO6u6p1spKJz2rYOlHAeUdBXfhsw/Gt8rHx06
        dqQlBhNSW5jvf2pRzHzoeZ8UszIKkP8nWcSDKrc=
X-Google-Smtp-Source: APXvYqyE7/KaBRoCMhA8/ftNjOsdBRhiirRvUWxu/SuUnEbUom/cJ6OEtWJdD1tCL1GhOudGSGWXMbXcL0C1zWgiyd0=
X-Received: by 2002:a67:fd08:: with SMTP id f8mr15806901vsr.90.1568125705542;
 Tue, 10 Sep 2019 07:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190910015311.14688-1-wqu@suse.com>
In-Reply-To: <20190910015311.14688-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 10 Sep 2019 15:28:14 +0100
Message-ID: <CAL3q7H6Aac6nTym8WJ2EbefKhrdDF4q3J3P3XdKUcK9DTc-yvg@mail.gmail.com>
Subject: Re: [PATCH v4] fstests: btrfs: Check snapshot creation and deletion
 with dm-logwrites
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 10, 2019 at 11:32 AM Qu Wenruo <wqu@suse.com> wrote:
>
> We have generic dm-logwrites with fsstress test case (generic/482), but
> it doesn't cover fs specific operations like btrfs snapshot creation and
> deletion.
>
> Furthermore, that test is not heavy enough to bump btrfs tree height by
> its short runtime.
>
> And finally, btrfs check doesn't consider dirty log as an error, unlike
> ext*/xfs, that's to say we don't need to mount the fs to replay the log,
> but just running btrfs check on the fs is enough.
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
> - Allow _log_writes_mkfs to accept extra mkfs options
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good to me, thanks.

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
>
> v4:
> - Comment polishment
> - Remove unnecessary fix in replay-log
> - Catch the return value from replay-log properly
> - Move the fast log replay function local as it's only used by btrfs yet
> - Allow _log_writes_mkfs to accept extra options
> ---
>  common/config       |   1 +
>  common/dmlogwrites  |   2 +-
>  tests/btrfs/192     | 175 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/192.out |   2 +
>  tests/btrfs/group   |   1 +
>  5 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100755 tests/btrfs/192
>  create mode 100644 tests/btrfs/192.out
>
> diff --git a/common/config b/common/config
> index bd64be62..4c86a492 100644
> --- a/common/config
> +++ b/common/config
> @@ -183,6 +183,7 @@ export LOGGER_PROG=3D"$(type -P logger)"
>  export DBENCH_PROG=3D"$(type -P dbench)"
>  export DMSETUP_PROG=3D"$(type -P dmsetup)"
>  export WIPEFS_PROG=3D"$(type -P wipefs)"
> +export BLKDISCARD_PROG=3D"$(type -P blkdiscard)"
>  export DUMP_PROG=3D"$(type -P dump)"
>  export RESTORE_PROG=3D"$(type -P restore)"
>  export LVM_PROG=3D"$(type -P lvm)"
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index ae2cbc6a..2a7ff612 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -69,7 +69,7 @@ _log_writes_mark()
>  _log_writes_mkfs()
>  {
>         _scratch_options mkfs
> -       _mkfs_dev $SCRATCH_OPTIONS $LOGWRITES_DMDEV
> +       _mkfs_dev $SCRATCH_OPTIONS $@ $LOGWRITES_DMDEV
>         _log_writes_mark mkfs
>  }
>
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> new file mode 100755
> index 00000000..4414ee67
> --- /dev/null
> +++ b/tests/btrfs/192
> @@ -0,0 +1,175 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 192
> +#
> +# Test btrfs consistency after each FUA for a workload with snapshot cre=
ation
> +# and removal
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       kill -q $pid1 &> /dev/null
> +       kill -q $pid2 &> /dev/null
> +       "$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
> +       wait
> +       _log_writes_cleanup &> /dev/null
> +       rm -f $tmp.*
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
> +_require_log_writes
> +_require_scratch
> +_require_attrs
> +
> +# We require a 4K nodesize to ensure the test isn't too slow
> +if [ $(get_page_size) -ne 4096 ]; then
> +       _notrun "This test doesn't support non-4K page size yet"
> +fi
> +
> +runtime=3D30
> +nr_cpus=3D$("$here/src/feature" -o)
> +# cap nr_cpus to 8 to avoid spending too much time on hosts with many cp=
us
> +if [ $nr_cpus -gt 8 ]; then
> +       nr_cpus=3D8
> +fi
> +fsstress_args=3D$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 99999 -p $n=
r_cpus \
> +               $FSSTRESS_AVOID)
> +_log_writes_init $SCRATCH_DEV
> +
> +# Discard the whole devices so when some tree pointer is wrong, it won't=
 point
> +# to some older valid tree blocks, so we can detect it.
> +$BLKDISCARD_PROG $LOGWRITES_DMDEV > /dev/null 2>&1
> +
> +# Use no-holes to avoid warnings of missing file extent items (expected
> +# for holes due to mix of buffered and direct IO writes).
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
> +       local basedir=3D$1
> +       echo "$basedir/$(ls $basedir | sort -R | tail -1)"
> +}
> +
> +snapshot_workload()
> +{
> +       trap "wait; exit" SIGTERM
> +
> +       local i=3D0
> +       while true; do
> +               $BTRFS_UTIL_PROG subvolume snapshot \
> +                       $SCRATCH_MNT/src $SCRATCH_MNT/snapshots/$i \
> +                       > /dev/null
> +               # Do something small to make snapshots different
> +               rm -f "$(random_file $SCRATCH_MNT/src/padding)"
> +               rm -f "$(random_file $SCRATCH_MNT/src/padding)"
> +               touch "$(random_file $SCRATCH_MNT/src/padding)"
> +               touch "$SCRATCH_MNT/src/padding/random_$RANDOM"
> +
> +               i=3D$(($i + 1))
> +               sleep 1
> +       done
> +}
> +
> +delete_workload()
> +{
> +       trap "wait; exit" SIGTERM
> +
> +       while true; do
> +               sleep 2
> +               $BTRFS_UTIL_PROG subvolume delete \
> +                       "$(random_file $SCRATCH_MNT/snapshots)" \
> +                       > /dev/null 2>&1
> +       done
> +}
> +
> +# Replay and check each fua/flush (specified by $2) point.
> +#
> +# Since dm-log-writes records bio sequentially, even just replaying a ra=
nge
> +# still needs to iterate all records before the end point.
> +# When number of records grows, it will be unacceptably slow, thus we ne=
ed
> +# to use relay-log itself to trigger fsck, avoid unnecessary seek.
> +_log_writes_fast_replay_check()
> +{
> +       local check_point=3D$1
> +       local blkdev=3D$2
> +       local fsck_command=3D"$BTRFS_UTIL_PROG check $blkdev"
> +       local ret
> +
> +       [ -z "$check_point" -o -z "$blkdev" ] && _fail \
> +       "check_point and blkdev must be specified for _log_writes_fast_re=
play_check"
> +
> +       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> +               --replay $blkdev --check $check_point --fsck "$fsck_comma=
nd" \
> +               &> $tmp.full_fsck
> +       ret=3D$?
> +       tail -n 150 $tmp.full_fsck > $seqres.full
> +       [ $ret -ne 0 ] && _fail "fsck failed during replay"
> +}
> +
> +xattr_value=3D$(printf '%0.sX' $(seq 1 3800))
> +
> +# Bumping tree height to level 2.
> +for ((i =3D 0; i < 64; i++)); do
> +       touch "$SCRATCH_MNT/src/padding/$i"
> +       $SETFATTR_PROG -n 'user.x1' -v $xattr_value "$SCRATCH_MNT/src/pad=
ding/$i"
> +done
> +
> +_log_writes_mark prepare
> +
> +snapshot_workload &
> +pid1=3D$!
> +delete_workload &
> +pid2=3D$!
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
> +status=3D0
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


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
