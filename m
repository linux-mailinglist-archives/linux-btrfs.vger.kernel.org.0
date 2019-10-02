Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06085C4B44
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfJBKWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 06:22:54 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35003 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfJBKWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 06:22:54 -0400
Received: by mail-vk1-f194.google.com with SMTP id d66so4190522vka.2;
        Wed, 02 Oct 2019 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+Wbqxo/BeH/zMkrTQTUl7uHwrMI+PkJkcnhshOECgkY=;
        b=iUBdohqAtwOV7KKehjwtbrau41VkXEggYkoi4THeLuge98a8Btfb8q3Wa65DhkboCc
         66OJyqaqJNgDcLhTR27SGRxDPQdkksTiuPHkUnM42inPHALnsS8ZhokFpw/cPcygSKdP
         eypGxaGnxF4TPfQk+j/E5joQ2D2pbVxt9740I913yZI3sYYA/bQuO+oA60g/uekyGUWF
         XpHPP6q8c+p31cjpukr5yFfFCSc6mZgIAZCGQm6XzZZbAUQbs58TRcTJ9oJ/cxT3lJxX
         ZQVu7H6wME9Qvp04IcbKg0yqLorHcv+Fu1zSd9CZv6lLsaXHwj+lxf2bqVZCd89uxc5M
         vD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+Wbqxo/BeH/zMkrTQTUl7uHwrMI+PkJkcnhshOECgkY=;
        b=KYn1QGQi3uXgrWV2ighvn0NIZK2dM8sUijCovZAxBt+NMEPTja17FnvNFKeatqLsqR
         eI1nknBU0AlAmc397JJDOHtu7q2pjEIsWmpBo5CHcumpEK9fCHEmRGfR5Wd5xeSstPo+
         Xbv/OuHFW41skAdzANVgjRe3YsJfQG+QBqHK0OYhLuWnIYps0Fmrf14YpTBnWC1L/H9X
         FNUHbBZ+MjEF096PRs9qfsZOOSHAZ3dv+aprh5PSAfWFGDyPEHQSyWleMqCWSq+JG0gG
         Orm84VZ5Hdeg4TvWmZguiZLAxC0e896Yd5Pm7Bh8rzrPMgjip7eIIi99ln/Ljr1nEH+4
         T60Q==
X-Gm-Message-State: APjAAAXoGe3OTuyh5drN4ZsgFYsqx9Hh0gEwCSJAqgxRxw0oYQFCUR+6
        H52gcRZq58fLH1ZcZXXtALw88btxuaIbACNNkxE=
X-Google-Smtp-Source: APXvYqw4oAiVVs4jKquAw0og59Jcr930D6wQ6+gTSwUtW3Wqh7x3s9zb0vgfqDjCCzns8TbO8k24AAgdEZxsABBwOGQ=
X-Received: by 2002:a1f:2b8c:: with SMTP id r134mr1552528vkr.23.1570011771272;
 Wed, 02 Oct 2019 03:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191001200551.1513-1-josef@toxicpanda.com>
In-Reply-To: <20191001200551.1513-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 2 Oct 2019 11:22:40 +0100
Message-ID: <CAL3q7H4CD8A+WjQbeT=MZ_k7ibiT9fe_+NvPpQ2m2=+99Mt9FQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs/194: add a test for multi-subvolume fsyncing
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        fstests <fstests@vger.kernel.org>, Josef Bacik <jbacik@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 2, 2019 at 5:29 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> From: Josef Bacik <jbacik@fb.com>
>
> I discovered a problem in btrfs where we'd end up pointing at a block we
> hadn't written out yet.  This is triggered by a race when two different
> files on two different subvolumes fsync.  This test exercises this path
> with dm-log-writes, and then replays the log at every FUA to verify the
> file system is still mountable and the log is replayable.

Please mention in the changelog, or in the test's description, the
subject of the patch that fixes the problem.
Otherwise people running the test and seeing failures will have a hard
time figuring things out (think of QA teams
for example, or anyone some weeks or months after, where context is
lost and mailing list search is not that great).

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/194     | 102 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/194.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 105 insertions(+)
>  create mode 100755 tests/btrfs/194
>  create mode 100644 tests/btrfs/194.out
>
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 00000000..d5edb313
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,102 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test multi subvolume fsync to test a bug where we'd end up pointing at=
 a block
> +# we haven't written.
> +#
> +# Will do log replay and check the filesystem.
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +fio_config=3D$tmp.fio

This isn't used anywhere.

> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       $KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null

This line can go away, the test doesn't use fsstress.

> +       _log_writes_cleanup &> /dev/null
> +       _dmthin_cleanup
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmthin
> +. ./common/dmlogwrites
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +
> +# Use thin device as replay device, which requires $SCRATCH_DEV
> +_require_scratch_nocheck
> +# and we need extra device as log device
> +_require_log_writes
> +_require_dm_target thin-pool
> +
> +_require_fio

All existing tests I could see, do "_require_fio $fio_config", where
$fio_config is not empty.

> +
> +# Use a thin device to provide deterministic discard behavior. Discards =
are used
> +# by the log replay tool for fast zeroing to prevent out-of-order replay=
 issues.
> +_test_unmount
> +_dmthin_init $devsize $devsize $csize $lowspace
> +_log_writes_init $DMTHIN_VOL_DEV
> +_log_writes_mkfs >> $seqres.full 2>&1
> +_log_writes_mark mkfs
> +
> +_log_writes_mount
> +
> +# First create all the subvolumes
> +for i in $(seq 0 49)
> +do

The style followed by fstests is "for i in $(seq 0 49); do", just like
you did in the while loop below.


> +       $BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/sub$i" > /dev/nul=
l
> +done
> +
> +# Then run 100 fio jobs in parallel
> +for i in $(seq 0 49)
> +do

Same here.

> +       fio --name=3Dseq --readwrite=3Dwrite --fallocate=3Dnone --bs=3D4k=
 --fsync=3D1 \
> +               --size=3D64k --filename=3D"$SCRATCH_MNT/sub$i/file" \
> +               > /dev/null 2>&1 &

fio -> $FIO_PROG

And then $FIO_PROG $fio_config, as all other tests using fio do.

> +done
> +wait
> +_log_writes_unmount
> +
> +_log_writes_remove
> +prev=3D$(_log_writes_mark_to_entry_number mkfs)
> +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> +cur=3D$(_log_writes_find_next_fua $prev)
> +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> +
> +while [ ! -z "$cur" ]; do
> +       _log_writes_replay_log_range $cur $DMTHIN_VOL_DEV >> $seqres.full
> +
> +       # We need to mount the fs because btrfsck won't bother checking t=
he log.
> +       _dmthin_mount
> +       _dmthin_check_fs
> +
> +       prev=3D$cur
> +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
> +       [ -z "$cur" ] && break
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> new file mode 100644
> index 00000000..7bfd50ff
> --- /dev/null
> +++ b/tests/btrfs/194.out
> @@ -0,0 +1,2 @@
> +QA output created by 194
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b92cb12c..0d0e1bba 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>  191 auto quick send dedupe
>  192 auto replay snapshot stress
>  193 auto quick qgroup enospc limit
> +194 auto metadata log volume

Other than that it looks fine to me.

However, on a VM with 8Gb of ram, I can't run the test:

root 11:09:10 /home/fdmanana/git/hub/xfstests (master)> ./check btrfs/194
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian5 5.3.0-rc8-btrfs-next-58 #1 SMP
Tue Sep 17 18:18:55 WEST 2019
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/194 [failed, exit status 137]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad)
    --- tests/btrfs/194.out 2019-10-02 10:51:45.485575789 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad
2019-10-02 11:12:11.382533722 +0100
    @@ -1,2 +1,2 @@
     QA output created by 194
    -Silence is golden
    +./check: line 513:  1324 Killed                  bash -c "test -w
${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/194.out
/home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad'  to see
the entire diff)
Ran: btrfs/194
Failures: btrfs/194
Failed 1 of 1 tests

root 11:12:22 /home/fdmanana/git/hub/xfstests (master)> cat
/home/fdmanana/git/hub/xfstests/results//btrfs/194.out.bad
QA output created by 194
./check: line 513:  1324 Killed                  bash -c "test -w
${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
root 11:19:39 /home/fdmanana/git/hub/xfstests (master)>


8Gb is a very reasonable amount of ram. This is on a debug kernel
(kmemleak, kasan, debug_pagealloc, etc, enabled). Not uncommon among
developers at least (even 4Gb of ram is common).

Thanks.

> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
