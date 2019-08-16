Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3443D8FEED
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfHPJ0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 05:26:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40744 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfHPJ0A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 05:26:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id i128so3300197vsc.7;
        Fri, 16 Aug 2019 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=31oNeg5j+cKXVU0R9ZOo0jztvI2AFxLLmdytNPWqqeA=;
        b=HXgpFUXYl5ufwlcdW4i0KNnS22yllkTz/5jF+i/SB/RnS+AE8U5bMQDTg0PRI+4/pZ
         CnnxFAU2sRnt1wDvZyvGdvKZJdeafhCci6ZhPf/B1OZ5gcj8LauP0fvvZvFgx1YyqfL4
         GRQHuzFF6SzAsBlaXpJS/m5P9HwCY8fEXvBlBcq8PG/g/IHst3JtCC5Z+eKq6L3IYvin
         RMjeqckKUaSctksG6h8TORLzCIrLil4Zn3/jSBHCd0n5QqKxnsubtFSxD77FGAeBPuiA
         wudZyKazUIBW8tQGIgE4ixOECQHvuMh9zGcSlgrLkRePTNTkWVKc2vQkDldn3C8oZfoo
         J03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=31oNeg5j+cKXVU0R9ZOo0jztvI2AFxLLmdytNPWqqeA=;
        b=JstNqDJ7392OYhMWY4hSbOxxcx2xyCcVi8VrrDe4H/ZnUuwZDGjeU0ag/w3MW2HfNN
         vUXjMdfdAJE+6e51kBpFOrUmO1lWEkTpWR8AwJ3FTCk2HIw9ku2exXxDI3X9G04SccUb
         XP7jyTjGkVmjTvSl4EU0K0P9WLkN5yMcpplg3hAzXk3UtbReW5JbwLg94QTnZU8dmUrD
         jgMHw197o6u9WJ7YjZWynoK5dPy9MlI136so0ych+1+VsTpOUYk8e34mrqx+sskP4koP
         VktTRe9xY1q6XXv00jcjTA+7Lwma3Zd6wTbntFaCmiGKefd31m6HDXAeui+TvaLh0PIJ
         LKOg==
X-Gm-Message-State: APjAAAU56bjvI1hqTv50Fgv5FKdKnCZv4cNkRZEJTWI45YqDq7voN88V
        MW0bjLI6ehsPcvAVmwxMC621HCAI34Ddl1NTHUI=
X-Google-Smtp-Source: APXvYqxdjv6vBA+sUi/K8LikkAsAJ6okQNP2BxP3nqgCg9605RM1TxtghXIvH9P86b7EhaoflSz9AmXx2FvI8lRYITQ=
X-Received: by 2002:a05:6102:414:: with SMTP id d20mr5017890vsq.99.1565947559080;
 Fri, 16 Aug 2019 02:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190814105544.18318-1-wqu@suse.com>
In-Reply-To: <20190814105544.18318-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 16 Aug 2019 10:25:47 +0100
Message-ID: <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: Check snapshot creation and deletion with dm-logwrites
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 14, 2019 at 11:56 AM Qu Wenruo <wqu@suse.com> wrote:
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
> but just run btrfs check on the fs is enough.
>
> So introduce a similar test case but for btrfs only.
>
> The test case will stress btrfs by:
> - Using small nodesize to bump tree height
> - Creating a base tree which is already high enough
> - Trimming tree blocks to find possible trim bugs
> - Calling snapshot creation and deletion along with fsstress
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
>   Thankfully, replay-log has already addressed it by providing --fsck and
>   --check command, thus we won't lose the replay status.
>
> Please note, for fast storage (e.g. fast NVME or unsafe cache mode),
> it's recommended to use log devices larger than 15G, or we can't record
> the full log of just 30s fsstress run.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> For the log devices size problem, I have submitted dm-logwrites bio flag
> filter support, to filter out data bios on the fly.
>
> But that is not yet merged into kernel, thus we need a large log device
> for short run.
> ---
>  common/config               |   1 +
>  common/dmlogwrites          |  28 ++++++++
>  src/log-writes/replay-log.c |   2 +
>  tests/btrfs/192             | 135 ++++++++++++++++++++++++++++++++++++
>  tests/btrfs/192.out         |   2 +
>  tests/btrfs/group           |   1 +
>  6 files changed, 169 insertions(+)
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
> index ae2cbc6a..5eca7142 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -175,3 +175,31 @@ _log_writes_replay_log_range()
>                 >> $seqres.full 2>&1
>         [ $? -ne 0 ] && _fail "replay failed"
>  }
> +
> +# Replay log range to specified entry
> +# Replay and check each fua/flush point.
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
> +       local fsck_command
> +
> +       [ -z "$check_point" -o -z "$blkdev" ] && _fail \
> +       "check_point and blkdev must be specified for _log_writes_fast_re=
play_check"
> +
> +       # Check program must not treat dirty log as a problem.
> +       # So only btrfs can use this feature
> +       if [ $FSTYP =3D "btrfs" ]; then
> +               fsck_command=3D"$BTRFS_PROG check $blkdev"
> +       else
> +               _notrun "fsck of $FSTYP may report false alert of dirty l=
og"

"false alert of dirty log" gives the idea fsck thinks there's a dirty
log (named journal is most filesystems) when there isn't any.
Rephrasing that as something like "fsck of $FSTYP reports dirty
journal/log as error, skipping test" would be more clear.

> +       fi
> +       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \"
> +               --replay $blkdev --check $check_point --fsck "$fsck_comma=
nd" \
> +               >> $seqres.full 2>&1
> +       [ $? -ne 0 ] && _fail "fsck failed during replay"
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
>                                 fprintf(stderr, "Fsck errored out on entr=
y "
>                                         "%llu\n",
>                                         (unsigned long long)log->cur_entr=
y - 1);
> +                               ret =3D -EUCLEAN;
>                                 break;
>                         }
>                 }
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> new file mode 100755
> index 00000000..e919f703
> --- /dev/null
> +++ b/tests/btrfs/192
> @@ -0,0 +1,135 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 YOUR NAME HERE.  All Rights Reserved.
> +#
> +# FS QA Test 192
> +#
> +# Test btrfs consistency after each FUA operation
> +# Mostly the same test as generic/482, with some btrfs specific operatio=
ns
> +# like snapshot creation and deletion.
> +# Alone with some btrfs specific workaround.

"Test btrfs consistency after each FUA for a workload with snapshot
creation and removal."

Much simpler and shorter.


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
> +       wait
> +       $KILLALL_PROG -q $FSSTRESS_PROG &> /dev/null
> +       _log_writes_cleanup &> /dev/null
> +       rm -f $tmp.*
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
> +_require_log_writes
> +_require_scratch
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
> +# Discard the whole devices so when some tree pointer is wrong, it won't=
 point
> +# to some older tree blocks, and we can detect it.
> +blkdiscard $LOGWRITES_DMDEV 2>&1
> +
> +# Workaround minor file extent discountinous.
> +# Also, use small node size 4K to bump up tree height.
> +_log_writes_mkfs -O no-holes -n 4k >> $seqres.full 2>&1

If using no-holes, then it misses the following at the top:

_require_btrfs_fs_feature "no_holes"
_require_btrfs_mkfs_feature "no-holes"

That will also make the test fail on systems with a page size > 4Kb.
So either make it "_notrun" for systems with a page size !=3D 4Kb or,
preferably make the test independent of the page size.
If you want to increase the tree height easily, you can set large
xattrs for files, like I did in btrfs/187, where even if with a 64Kb
page size, I get a 3 levels fs tree.

> +
> +# We need inline extents to quickly bump the tree height
> +_log_writes_mount -o max_inline=3D2048

Again, setting large xatts (3800 bytes so that it works for any page
size) is even faster then inline extents.

> +
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/src > /dev/null 2>&1

We should catch failures here. Just remove the redirection, pass the
_filter_scratch filter and update the golden output.

> +mkdir -p $SCRATCH_MNT/snapshots
> +mkdir -p $SCRATCH_MNT/src/padding
> +
> +random_file() {

The coding style is "{" on the beginning of the next line.
Like the _cleanup() function, and the _log_writes_fast_replay_check()
function you added previously.

> +       local basedir=3D$1
> +       echo "$basedir/$(ls $basedir | sort -R | tail -1)"
> +}
> +
> +snapshot_workload() {

Same comment as above.

> +       while true; do
> +               $BTRFS_UTIL_PROG subvolume snapshot \
> +                       $SCRATCH_MNT/src $SCRATCH_MNT/snapshots/$i \
> +                       > /dev/null 2>&1
> +               # Remove two random padding so each snapshot is different
> +               rm "$(random_file $SCRATCH_MNT/src/padding)"

I would pass -f to rm. Having an alias "alias rm=3D'rm -i'" is not very
uncommon (I have such alias for my accounts).

> +               rm "$(random_file $SCRATCH_MNT/src/padding)"

Might be interesting to add a few files to each snapshot too (modify
existing ones, etc).

> +               sleep 1
> +       done
> +}
> +
> +delete_workload() {

Same comment as above.

> +       while true; do
> +               sleep 2
> +               $BTRFS_UTIL_PROG subvolume delete \
> +                       "$(random_file $SCRATCH_MNT/snapshots)" \
> +                       > /dev/null 2>&1
> +       done
> +}
> +
> +# Bump the tree height to 2 at least
> +for ((i =3D 0; i < 256; i++)); do
> +       _pwrite_byte 0xcd 0 2k "$SCRATCH_MNT/src/padding/inline_$i" > /de=
v/null 2>&1
> +       _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/src/padding/regular_$i" > /d=
ev/null 2>&1
> +done
> +sync

Why the call to 'sync'?
Not needed, snapshot creation flushes delalloc and commits a transaction.

> +
> +_log_writes_mark prepare
> +
> +snapshot_workload &
> +pid1=3D$!
> +delete_workload &
> +pid2=3D$!
> +
> +$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
> +sleep $runtime
> +
> +$KILLALL_PROG -q $FSSTRESS_PROG &> /dev/null

You're very inconsistent within the same test :) Using both ">
/dev/null 2>&1" and "&> /dev/null".

> +kill $pid1 &> /dev/null
> +kill $pid2 &> /dev/null
> +wait
> +_log_writes_unmount
> +_log_writes_remove
> +
> +# Since we have a lot of work to replay, and relay-log will search
> +# from the first record to the needed entry, we need to use --fsck optio=
n
> +# to reduce unnecessary search, or it will be too slow
> +$here/src/log-writes/replay-log --log $LOGWRITES_DEV --replay $SCRATCH_D=
EV \
> +       --fsck "btrfs check $SCRATCH_DEV" --check fua >> $seqres.full 2>&=
1
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
> index 2474d43e..24723bf1 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -194,3 +194,4 @@
>  189 auto quick send clone
>  190 auto quick replay balance qgroup
>  191 auto quick send dedupe
> +192 auto replay

Missing "snapshot" group.

Thanks.

> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
