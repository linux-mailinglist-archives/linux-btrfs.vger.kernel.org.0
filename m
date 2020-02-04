Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7FF151ED4
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgBDRAm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 12:00:42 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41185 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBDRAm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 12:00:42 -0500
Received: by mail-ua1-f68.google.com with SMTP id f7so6994202uaa.8;
        Tue, 04 Feb 2020 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Y3Gu57aTqRvDmHSkxeoVWh8nA1QeUVJELfh/b5I4Brg=;
        b=VhrHYpxH2WFKjfBgWdVGKxFEjk6OCHRY9n3cT3Rq5O0xEG0G05lAe8rAci/M77ptf8
         io2089x7ljFTQts47RXwKlZZmbpqjHE7Mkxj6fRqp5Q3bwsJZoVzFbRtcgMZusQycgLA
         APB864QbPSdDThbSxNrYEEslTkwB2ZAIGWD80Avfhm/Je17TKsa/RRPSD9cV7liMiJHW
         u0h0hFMx+Wy8+ZaJ2mSdUajIX+R1YuKut9YTTI+MykBrDc+zqGV8DS0xbC4k2Eh8zLCM
         7DiXli3wd6rfpJgjvhfEHnzltVeYdDNoXDgEtrSgCVnbTLKtdfDsSD9IH4V/vsrEvtCh
         VazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Y3Gu57aTqRvDmHSkxeoVWh8nA1QeUVJELfh/b5I4Brg=;
        b=dtBscBqzt2wgvHY8Io6hNn4RRC5L8Qme3zgV6jFwTK1ceZxSKaQg54r08cVnE49vX0
         13PYuLZiWoYsTiUlyGGeOKzx8jQKD6v+YsN2+vI/ygD7GN6bTL9xIbeB2nnZ65HzX62X
         YSyEY4jhdasCW0sfdLNlIKYuo9nvh8hreYWGVs19oLAzUH5EbmNpDB+EsEz8X/s06SKi
         UfX0o8DlA/JfaFJbTF9KD1hySbbIIZF+1sH0kra2Wump2CZnyaEW9gNn5e031QkNPLDV
         yc5rdqN0/JkZFgTxh2B+bKEwNs3Z/Jo0IR7HIr+3GAZ8coea3qnVP3sD31ZE5nI6RTc8
         SOfQ==
X-Gm-Message-State: APjAAAWR6nMTZKDY3sw4/u9PNqnU+gf4uzLIiEgikqWU7+wv6QlabSvf
        HQepMpbkeNicR6Shhv+5Rd7bNx1VI0HWWLgPpLvwK3vw
X-Google-Smtp-Source: APXvYqwOFufUYy74IerdGdQ9QqO0kPZ07+YmrMrZW27YwVg1saHG+gzil11tGcnM0D/6U0xb8JtrXMIuunQ8sTCrFFk=
X-Received: by 2002:ab0:724c:: with SMTP id d12mr18469254uap.0.1580835638832;
 Tue, 04 Feb 2020 09:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20200204143759.697376-1-josef@toxicpanda.com>
In-Reply-To: <20200204143759.697376-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 4 Feb 2020 17:00:25 +0000
Message-ID: <CAL3q7H7S2amma2OWGVujPM-jdLcor4zb5suXWsa_LHrwL-x8DA@mail.gmail.com>
Subject: Re: [PATCH][v2] xfstest: add a test for the btrfs file extent gap issue
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 4, 2020 at 2:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This is a test to validate that we're not adjusting up i_size before we
> have the appropriate file extents on disk.  We had a problem where
> i_size would be adjusted up without a contiguous range of file extents,
> which isn't ok without a special option enabled.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
> v1->v2:
> - adjusted the commit interval time to make the test shorter
> - adjusted the write range so we didn't get tripped up by btrfs's delallo=
c
>   behavior
> - integrated all of Filipe's suggestions
>
>  tests/btrfs/172     | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/172.out |  3 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 80 insertions(+)
>  create mode 100755 tests/btrfs/172
>  create mode 100644 tests/btrfs/172.out
>
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> new file mode 100755
> index 00000000..cae5f623
> --- /dev/null
> +++ b/tests/btrfs/172
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 172
> +#
> +# Validate that without no-holes we do not get an i_size that is after a=
 gap in
> +# the file extents on disk.  This is fixed by the following patches
> +#
> +#     btrfs: use the file extent tree infrastructure
> +#     btrfs: replace all uses of btrfs_ordered_update_i_size
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
> +_require_scratch
> +_require_log_writes
> +_require_xfs_io_command "sync_range"
> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
> +
> +# There's not a straightforward way to commit the transaction without al=
so
> +# flushing dirty pages, so shorten the commit interval to 1 so we're sur=
e to get
> +# a commit with our broken file
> +_log_writes_mount -o commit=3D1
> +
> +$XFS_IO_PROG -f -c "pwrite 0 5m" $SCRATCH_MNT/file | _filter_xfs_io
> +$XFS_IO_PROG -f -c "sync_range -abw 4m 1m" $SCRATCH_MNT/file | _filter_x=
fs_io
> +
> +# Now wait for a transaction commit to happen, wait 2x just to be super =
sure
> +sleep 2
> +
> +_log_writes_unmount
> +_log_writes_remove
> +
> +cur=3D$(_log_writes_find_next_fua 0)
> +echo "cur=3D$cur" >> $seqres.full
> +while [ ! -z "$cur" ]; do
> +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
> +
> +       # We only care about the fs consistency, so just run fsck, we don=
't have
> +       # to mount the fs to validate it
> +       _check_scratch_fs
> +
> +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
> +done
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
> new file mode 100644
> index 00000000..45051739
> --- /dev/null
> +++ b/tests/btrfs/172.out
> @@ -0,0 +1,3 @@
> +QA output created by 172
> +wrote 5242880/5242880 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 4b64bf8b..53cb3451 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -174,6 +174,7 @@
>  169 auto quick send
>  170 auto quick snapshot
>  171 auto quick qgroup
> +172 auto quick log replay
>  173 auto quick swap
>  174 auto quick swap
>  175 auto quick swap volume
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
