Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA8BE0066
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbfJVJJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:09:19 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46954 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbfJVJJS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:09:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id l64so5925937ywe.13;
        Tue, 22 Oct 2019 02:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1Q/3A6bIET+6gmqp6pP3kabzVK4Yje+u+6+e7jKuig=;
        b=YVo3ABl/pX+9EvX/TZ2CwO8Aeu3GYFPnzmHlmqkQUeHybIoCGIhwIixglKTo9+WKMC
         3FarvOr0xSLbzxn454Kv4hLRGbpA3VUoAgTaak9IjY32MDQp6Y2Z7g8Q7Ch6tg4sNgj2
         ObmdN/6voPSi05WhIH2JbEFMmaWdE8gByMCLctk3UMq3ugtPU118gWjIhCbpQMlkt3AY
         cXqVPVmavd9bHFTcbnNTBB9ZVqzlffdgr8I/5jn3pcerU0ijG3By85lct1HmIEIp0Wul
         BBRiiXN2MZZlWElBzY9ScSkDYf3zmVCBDLv6Fa2iXHch+qZ7HBfw36LzhmswJZDs4jvv
         KYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1Q/3A6bIET+6gmqp6pP3kabzVK4Yje+u+6+e7jKuig=;
        b=bPbgiMd/A9p76U6P1lfAzgtj4cNpV2J7rBivyM34DZmLgEuYEzLnSAjHoGv6Hlv2bb
         UVlfA19OysilEnVuFlXX0h2emcwn0KZptzrAWSwCc6FGP+5CLtj3WQ3CPRCHuaKDX6c0
         zkVvLiab3TBZ2C68ikBtBKZyvIduZMKHZrvsftB6Owe9mz8ptyyywHUh2CV6jxIxEl+C
         HgZ1MV21PV6G9sHUDoisqYcWB80jOojEFoVRcNEfJGVicOrKMbZmiaD0uh9GmVXDEuKg
         AstePFeBS6GnxMNbvKjly2lGLh4DKXRbbdqIKUiPf3qdbMFJbOIn1G3PsEy5SKHkOz+O
         wbkQ==
X-Gm-Message-State: APjAAAV9zCIdYCCUMN5u45cxcJWXlmzoySQLPPGLs3gVxq7pTIZE+weg
        WgPNs5m5oX5wKIT1S875wX6hjtXUzGan228UARnbNb82
X-Google-Smtp-Source: APXvYqyuyZ2GEhbbrdxRWmRwNuaIWXjoiKEoImRUINrBqSPuacerCe4wNRBL37EhX4fDMcuzF6NP14mMErcdTXz9xP4=
X-Received: by 2002:a81:9a0c:: with SMTP id r12mr1355262ywg.25.1571735357448;
 Tue, 22 Oct 2019 02:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191022075806.16616-1-wqu@suse.com> <20191022075806.16616-3-wqu@suse.com>
In-Reply-To: <20191022075806.16616-3-wqu@suse.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Oct 2019 12:09:06 +0300
Message-ID: <CAOQ4uxigD20UtLwa8fvmAQVSkYtLxN2J71oYzw5pGXr1hTkn5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fstests: btrfs: dm-logwrites test for fstrim and
 fsstress workload
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 11:00 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a fs corruption report of a tree block in use get trimmed, and
> cause fs corruption.
>
> Although I haven't found the cause from the source code, it won't hurt
> to add such test case.
>
> The test case is limited to btrfs due to the replay-log --check|--fsck
> hack to reduce runtime.

I am not sure why this is referred to as a hack?

> Other fs can't go with the replay-log --check|--fsck hack as their fsck
> will report dirty journal as error.

This doesn't make the test btrfs specific.
The helper you use log_writes_fast_replay_check() is already dupliacte
code from btrfs/192 and it should be in common/dmlogwrites.
The helper itself would be quite generic if it didn't hardcode btrfs check
tool.

I think a better solution would be to _require_fast_check_fs and it is
possible that other fs will have a future flag for fsck to not fail if
journal needs to be replayed, but the check whatever is possible to check
in that state (e.g. the super block and the consistency of the journal).

However, regarding requiring no_holes, I am not sure how you would
encode that in a generic test???

Thanks,
Amir.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Due to recent change in btrfs side, already trimmed tree blocks won't
> get trimmed again until new data is written.
>
> This makes things safer, and I'm not sure if it's the reason why the
> test never fails on latest kernel.
> ---
>  tests/btrfs/197     | 131 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/197.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 134 insertions(+)
>  create mode 100755 tests/btrfs/197
>  create mode 100644 tests/btrfs/197.out
>
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> new file mode 100755
> index 00000000..c86af7b6
> --- /dev/null
> +++ b/tests/btrfs/197
> @@ -0,0 +1,131 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +
> +# FS QA Test 197
> +#
> +# Test btrfs consistency after each DISCARD for a workload with fstrim and
> +# fsstress.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       kill -q $fstrim_pid &> /dev/null
> +       "$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
> +       wait
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
> +_require_command "$KILLALL_PROG" killall
> +_require_command "$BLKDISCARD_PROG" blkdiscard
> +_require_btrfs_fs_feature "no_holes"
> +_require_btrfs_mkfs_feature "no-holes"
> +_require_fstrim
> +_require_log_writes
> +_require_scratch
> +
> +runtime=30
> +nr_cpus=$("$here/src/feature" -o)
> +# cap nr_cpus to 8 to avoid spending too much time on hosts with many cpus
> +if [ $nr_cpus -gt 8 ]; then
> +       nr_cpus=8
> +fi
> +fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 99999 -p $nr_cpus \
> +               $FSSTRESS_AVOID)
> +
> +fstrim_workload()
> +{
> +       trap "wait; exit" SIGTERM
> +
> +       while  true; do
> +               $FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full
> +       done
> +}
> +
> +# Replay and check each fua/flush (specified by $2) point.
> +#
> +# Since dm-log-writes records bio sequentially, even just replaying a range
> +# still needs to iterate all records before the end point.
> +# When number of records grows, it will be unacceptably slow, thus we need
> +# to use relay-log itself to trigger fsck, avoid unnecessary seek.
> +log_writes_fast_replay_check()
> +{
> +       local check_point=$1
> +       local blkdev=$2
> +       local fsck_command="$BTRFS_UTIL_PROG check $blkdev"
> +       local ret
> +
> +       [ -z "$check_point" -o -z "$blkdev" ] && _fail \
> +       "check_point and blkdev must be specified for log_writes_fast_replay_check"
> +
> +       # Replay to first mark
> +       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> +               --replay $blkdev --end-mark prepare
> +       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> +               --replay $blkdev --start-mark prepare \
> +               --check $check_point --fsck "$fsck_command" \
> +               &> $tmp.full_fsck
> +       ret=$?
> +       tail -n 150 $tmp.full_fsck > $seqres.full
> +       [ $ret -ne 0 ] && _fail "fsck failed during replay"
> +}
> +
> +_log_writes_init $SCRATCH_DEV
> +
> +# Discard the whole devices so when some tree pointer is wrong, it won't point
> +# to some older valid tree blocks, so we can detect it.
> +$BLKDISCARD_PROG $LOGWRITES_DMDEV > /dev/null 2>&1
> +
> +# The regular workaround to avoid false alert on unexpected holes
> +_log_writes_mkfs -O no-holes >> $seqres.full
> +_log_writes_mount
> +
> +$FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full || _notrun "FSTRIM not supported"
> +
> +_log_writes_mark prepare
> +
> +fstrim_workload &
> +fstrim_pid=$!
> +
> +"$FSSTRESS_PROG" $fsstress_args > /dev/null &
> +sleep $runtime
> +
> +"$KILLALL_PROG" -q "$FSSTRESS_PROG" &> /dev/null
> +kill $fstrim_pid
> +wait
> +
> +_log_writes_unmount
> +_log_writes_remove
> +
> +# The best checkpoint is discard, however since there are a lot of
> +# discard, using discard check point is too time consuming.
> +# Here trade coverage for a much shorter runtime
> +log_writes_fast_replay_check flush "$SCRATCH_DEV"
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/197.out b/tests/btrfs/197.out
> new file mode 100644
> index 00000000..3bbd3143
> --- /dev/null
> +++ b/tests/btrfs/197.out
> @@ -0,0 +1,2 @@
> +QA output created by 197
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index c2ab3e7d..ee35fa59 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -199,3 +199,4 @@
>  194 auto volume
>  195 auto volume
>  196 auto metadata log volume
> +197 auto replay trim
> --
> 2.23.0
>
