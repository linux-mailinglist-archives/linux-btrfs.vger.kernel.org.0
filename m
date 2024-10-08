Return-Path: <linux-btrfs+bounces-8639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D73995045
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 15:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54351C24F67
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58191DF274;
	Tue,  8 Oct 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U96uYX14"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3871DF24B;
	Tue,  8 Oct 2024 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394594; cv=none; b=O+4JzFVMg7sK8Q7BFWlrjYAlXABguZcwWlC2BhB/sSLlFHKTKA5RDZAssPPtLEobjiB+vfqS/JEOuXnhVtvovUk1dteBN7fgekNBehjnGpRTzG+IFJdIMRNUMeNdVYh2cGg/qnluHitneKNP8gvyze30qg9Jo16T+aPwsK14Ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394594; c=relaxed/simple;
	bh=eVYETAdoCJdtJS95XqhtvYy5lW1DfMyqNMjDN6qWrIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqVB3L1+Chd1eBABvHqylQYC2kOnbebuz+/oJTtia2jnTDnorygTNkkgRHbREdW4V0cxfAxoCKPqdB2/673NvwC9V+oLMpS6Y2TLEG+uFrgaxGxOtsicWWgyBEy5pDmO7u+WkBb/n9qTgKeI2Dhd8DkqcPjiOlOb2X5/wPqTgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U96uYX14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9350CC4CECC;
	Tue,  8 Oct 2024 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394593;
	bh=eVYETAdoCJdtJS95XqhtvYy5lW1DfMyqNMjDN6qWrIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U96uYX14JABx536eF3wc1tDZA8frHJDdmno2Gzu+JWseobI+VKkdMKDA63P0EjQvp
	 dgCv3ilLYEmaDl69wMIGdHyI/1N1Hk3nR8yAHmM77x95eC0yMmE7qFvRMTmsrp05PF
	 8xziKu2bbCzD/h3yN2tLb9inXmQVLkSbvhfIaFaUIZOiU1g0wOujwLFjFtZB2MLKeP
	 /JhjgwM0d3ZwcXPJzq63zb3O3qTzsRo4fxY4K88IV4JNyUNJkDKH8k2q9G3ir0rrqM
	 G3mLMIR/qPvIphCNbzqJ9X3h2SVtZLebeKmWbpmn35DqmMGT1T91Nma12deiEHEzS6
	 vGIuMFbvAjYow==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398fb1a871so5566834e87.3;
        Tue, 08 Oct 2024 06:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsmALNrAmvbvoifjEqnPW4Gt1jO4QtIWzEAEM3CJOZcveqrkhYThu3JGKIz0I5SKBGU9OL+Jf3gF5MfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRf2GPPrC1BjNuOiZC9912L0UvKzQu0ljD+4MYtRHY80KImC6
	FDOqGx6wZIrjsyu14bUlHZRqrdSTJnep7cUwF9JlO+wCFP+y0HsWPi/6YHaCvTHsU2vXqydSlKC
	zvJFSVMFcODzcDqXVsEBFT825Rq4=
X-Google-Smtp-Source: AGHT+IF35qhVYYhTLJ7azuzHtubGteu2oMw/n2JJOeZW0OI3xTLWbb9kQIHv5wuhFSzX41NFbAC9kDByIDvNQ128CEU=
X-Received: by 2002:a05:6512:3e01:b0:530:aea3:4659 with SMTP id
 2adb3069b0e04-539ab84a2f2mr8471974e87.9.1728394591828; Tue, 08 Oct 2024
 06:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112302.2757404-1-maharmstone@fb.com>
In-Reply-To: <20241008112302.2757404-1-maharmstone@fb.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Oct 2024 14:35:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4oGiDQ4bahbJmxw9zp8CuzAF+VzJvqqdx10A8qyNk1Ag@mail.gmail.com>
Message-ID: <CAL3q7H4oGiDQ4bahbJmxw9zp8CuzAF+VzJvqqdx10A8qyNk1Ag@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add test for missing csums in log when doing async
 on subpage vol
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 12:26=E2=80=AFPM Mark Harmstone <maharmstone@fb.com>=
 wrote:
>
> Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
> race could mean that csums weren't getting written to the log tree,
> leading to corruption when it was replayed.
>
> The patches to detect log this tree corruption are in btrfs-progs 6.11.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  common/dmlogwrites  | 24 ++++++++++++++++++
>  tests/btrfs/192     | 26 +-------------------
>  tests/btrfs/333     | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/333.out |  2 ++
>  4 files changed, 86 insertions(+), 25 deletions(-)
>  create mode 100755 tests/btrfs/333
>  create mode 100644 tests/btrfs/333.out
>
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index c1c85de9..f7faf244 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -203,3 +203,27 @@ _log_writes_replay_log_range()
>                 >> $seqres.full 2>&1
>         [ $? -ne 0 ] && _fail "replay failed"
>  }
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
> +       local fsck_command=3D$3
> +       local ret
> +
> +       [ -z "$check_point" -o -z "$blkdev" ] && _fail \
> +       "check_point and blkdev must be specified for log_writes_fast_rep=
lay_check"
> +
> +       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> +               --replay $blkdev --check $check_point --fsck "$fsck_comma=
nd" \
> +               &> $tmp.full_fsck
> +       ret=3D$?
> +       tail -n 150 $tmp.full_fsck >> $seqres.full
> +       [ $ret -ne 0 ] && _fail "fsck failed during replay"
> +}
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> index f7fb65b8..449f0459 100755
> --- a/tests/btrfs/192
> +++ b/tests/btrfs/192
> @@ -96,30 +96,6 @@ delete_workload()
>         done
>  }
>
> -# Replay and check each fua/flush (specified by $2) point.
> -#
> -# Since dm-log-writes records bio sequentially, even just replaying a ra=
nge
> -# still needs to iterate all records before the end point.
> -# When number of records grows, it will be unacceptably slow, thus we ne=
ed
> -# to use relay-log itself to trigger fsck, avoid unnecessary seek.
> -log_writes_fast_replay_check()
> -{
> -       local check_point=3D$1
> -       local blkdev=3D$2
> -       local fsck_command=3D"$BTRFS_UTIL_PROG check $blkdev"
> -       local ret
> -
> -       [ -z "$check_point" -o -z "$blkdev" ] && _fail \
> -       "check_point and blkdev must be specified for log_writes_fast_rep=
lay_check"
> -
> -       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> -               --replay $blkdev --check $check_point --fsck "$fsck_comma=
nd" \
> -               &> $tmp.full_fsck
> -       ret=3D$?
> -       tail -n 150 $tmp.full_fsck >> $seqres.full
> -       [ $ret -ne 0 ] && _fail "fsck failed during replay"
> -}
> -
>  xattr_value=3D$(printf '%0.sX' $(seq 1 3800))
>
>  # Bumping tree height to level 2.
> @@ -145,7 +121,7 @@ wait
>  _log_writes_unmount
>  _log_writes_remove
>
> -log_writes_fast_replay_check fua "$SCRATCH_DEV"
> +_log_writes_fast_replay_check fua "$SCRATCH_DEV" "$BTRFS_UTIL_PROG check=
 $SCRATCH_DEV"
>
>  echo "Silence is golden"
>
> diff --git a/tests/btrfs/333 b/tests/btrfs/333
> new file mode 100755
> index 00000000..13f113ca
> --- /dev/null
> +++ b/tests/btrfs/333
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test 333
> +#
> +# Test async dio with fsync to test a bug where a race meant that csums =
weren't
> +# getting written to the log tree, causing corruptions on remount. This =
can be
> +# seen on subpage FSes on 6.4.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick metadata log volume

Why the volume group? The test isn't doing any volume management stuff.

However it should be in the "recoveryloop" group.

> +
> +_fixed_by_kernel_commit e917ff56c8e7 \
> +       "btrfs: determine synchronous writers from bio or writeback contr=
ol"
> +
> +fio_config=3D$tmp.fio
> +
> +. ./common/dmlogwrites
> +
> +_require_scratch
> +_require_log_writes
> +
> +cat >$fio_config <<EOF
> +[global]
> +iodepth=3D128
> +direct=3D1
> +ioengine=3Dlibaio
> +rw=3Drandwrite
> +runtime=3D1s
> +[job0]
> +rw=3Drandwrite
> +filename=3D$SCRATCH_MNT/file
> +size=3D1g
> +fdatasync=3D1
> +EOF
> +
> +_require_fio $fio_config
> +
> +cat $fio_config >> $seqres.full
> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs >> $seqres.full 2>&1
> +_log_writes_mark mkfs
> +
> +_log_writes_mount
> +
> +$FIO_PROG $fio_config > /dev/null 2>&1
> +_log_writes_unmount
> +
> +_log_writes_remove
> +_log_writes_replay_log mkfs $SCRATCH_DEV
> +
> +_log_writes_fast_replay_check fua "$SCRATCH_DEV" "$BTRFS_UTIL_PROG check=
 $SCRATCH_DEV"


Why do we need to do the replays twice? Once with
_log_writes_replay_log mkfs and then again with
_log_writes_fast_replay_check fua.

There's also nothing in this test that is btrfs specific, it could be
made a generic test instead.

Thanks.

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/333.out b/tests/btrfs/333.out
> new file mode 100644
> index 00000000..60a15898
> --- /dev/null
> +++ b/tests/btrfs/333.out
> @@ -0,0 +1,2 @@
> +QA output created by 333
> +Silence is golden
> --
> 2.44.2
>
>

