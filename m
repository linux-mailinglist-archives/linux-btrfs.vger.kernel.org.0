Return-Path: <linux-btrfs+bounces-2504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7760585A2E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 13:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26478284603
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF4D2E63B;
	Mon, 19 Feb 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewb6TjyA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A922E620;
	Mon, 19 Feb 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344757; cv=none; b=ajKRlCjGbykY3LNISLL+pR7K5OmWtQXTVhkfpqVBYejnnnl0etaXCerUO4cwW/gYtzcY5iC/V9rKcd0mT9MOOz/F4dVKwDyT7RvtUixVTiU/M9Cwyk5AtC46mGaFgue4HnJYq2Ug+XVg+eViJ16v22kyPIld8Yb3gIFB38Zgda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344757; c=relaxed/simple;
	bh=z6jp3CY0GaKsqK8dwyOQX0uBMqrjyZNNLTEvdVRdYlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/xNsmD7E6hhHdgMRm1FmJDHbDXg/3VHuN7YZaLoL8sCVwdIQ0gEkUAaWlR5eKD321dFi5WvgtM2VfmztdRTX2asJzQcwVeWqPI/1hpEqr29tZ8TlgIejTOfVrZXt2h0XhXiDWZpStDIiyJwIqW1OUb0IG+YK6p1Ju5pbdgsIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewb6TjyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63561C433F1;
	Mon, 19 Feb 2024 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708344757;
	bh=z6jp3CY0GaKsqK8dwyOQX0uBMqrjyZNNLTEvdVRdYlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ewb6TjyAqmiN+KNS+1fAk+KX6ZZaDm3s81LsaaQmvr7JT1BSj6+B9gg7NUG3l2WpU
	 X2I3ACWaQNQcxE3Dn575HDsJxanIjEVVjExbowjLxLttAVfsll5PCeTOLjxU8owG92
	 S3IuzkpWTiemF3P7u6+gOxlc0rTXBPa387bk1rYIXb/8T8lAFDoTsM2nh6SPV/9IbK
	 qv+SDF0h3sTmEDqFraFk/H6xtQ+/EfRMS0R/bkkZ+R9zW66GLBg5guAhypfO4kvrmb
	 TOBA9wktWkw3q0svt1hKl0kFx3pb0XIqOa1OiP6PL4FVfxutUHAXQYxFAgq9muVLtd
	 VdrTJaG+6Latw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a36126ee41eso559223866b.2;
        Mon, 19 Feb 2024 04:12:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFmsbEJk0vhNzmbKn7TU8FCIAbZ95Mn1bYQutucmgGWvFW8Vfz5ixVuATHfJtHLVtt1MrsoOiXLZl49nwjz38ZbMWHxBc4Nw==
X-Gm-Message-State: AOJu0YwXrAV+NC0V7GwVSGv8bUNnzZa2dn0KJk9idxk3EMLcf/1Lg7yy
	khUSNTFKbCc15MLxvgb/MrjDSCEyaoODNdvof6R/+pgzMi5PSeiijZECaSMiZZBAgLIAaVnvtK0
	W2n2acXucBtweI7ubDAkcJUi+jtI=
X-Google-Smtp-Source: AGHT+IEeyJ2w88JbVusXtZ30xx469nhIopberr76JjLS87AgryMP5Nt1kF1YhRKy3l/XxAV1UZzTaF0yW/FFlVQU23I=
X-Received: by 2002:a17:906:b309:b0:a3d:48cf:65a6 with SMTP id
 n9-20020a170906b30900b00a3d48cf65a6mr8901363ejz.18.1708344755733; Mon, 19 Feb
 2024 04:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219080007.70318-1-wqu@suse.com>
In-Reply-To: <20240219080007.70318-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 19 Feb 2024 12:11:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H69SsWkmvysP-mDm1h6DJ1YMFSRkzs87yyQG2YbgRt26Q@mail.gmail.com>
Message-ID: <CAL3q7H69SsWkmvysP-mDm1h6DJ1YMFSRkzs87yyQG2YbgRt26Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs/016: fix a false alert due to xattrs mismatch
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:18=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/016 after any other test case, it would fail on a
> SELinux enabled environment:
>
>   btrfs/015 1s ...  0s
>   btrfs/016 1s ... [failed, exit status 1]- output mismatch (see ~/xfstes=
ts-dev/results//btrfs/016.out.bad)
>       --- tests/btrfs/016.out   2023-12-28 10:39:36.481027970 +1030
>       +++ ~/xfstests-dev/results//btrfs/016.out.bad     2023-12-28 15:53:=
10.745436664 +1030
>       @@ -1,2 +1,3 @@
>        QA output created by 016
>       -Silence is golden
>       +fssum failed
>       +(see ~/xfstests-dev/results//btrfs/016.full for details)
>       ...
>       (Run 'diff -u ~/xfstests-dev/tests/btrfs/016.out ~/xfstests-dev/res=
ults//btrfs/016.out.bad'  to see the entire diff)
>   Ran: btrfs/015 btrfs/016
>   Failures: btrfs/016
>   Failed 1 of 2 tests
>
> [CAUSE]
> The test case itself would try to use a blank SELinux context for the
> SCRATCH_MNT, to control the xattrs.
>
> But the initial send stream is generated from $TEST_DIR, which may still
> have the default SELinux mount context.
>
> And such mismatch in the SELinux xattr (source on $TEST_DIR still has
> the extra xattr, meanwhile the receve end on $SCRATCH_MNT doesn't) would
> lead to above mismatch.
>
> [FIX]
> Fix the false alerts by disable XATTR checks.
>
> Furthermore instead of doing all the edge juggling using $TEST_DIR, this
> time we do all the work on $SCRATCH_MNT.
>
> This means we would generate the initial send stream from $SCRATCH_MNT,
> then reformat the fs, mount scratch again, receive and verify.
>
> We no longer needs to cleanup the extra file for the initial send
> stream, as they are on the scratch device and would be formatted anyway.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add -T option to avoid xattrs checks
>   Since this test case is only verify the hole punching behavior, XATTR
>   is not our interest.
> ---
>  tests/btrfs/016 | 53 ++++++++++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 31 deletions(-)
>
> diff --git a/tests/btrfs/016 b/tests/btrfs/016
> index 35609329..37119363 100755
> --- a/tests/btrfs/016
> +++ b/tests/btrfs/016
> @@ -12,58 +12,48 @@ _begin_fstest auto quick send prealloc
>  tmp=3D`mktemp -d`
>  tmp_dir=3Dsend_temp_$seq
>
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -       $BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/snap > /dev/=
null 2>&1
> -       $BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/snap1 > /dev=
/null 2>&1
> -       $BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/send > /dev/=
null 2>&1
> -       rm -rf $TEST_DIR/$tmp_dir
> -       rm -f $tmp.*
> -}
> -
>  # Import common functions.
>  . ./common/filter
>
>  # real QA test starts here
>  _supported_fs btrfs
> -_require_test
>  _require_scratch
>  _require_fssum
>  _require_xfs_io_command "falloc"
>
>  _scratch_mkfs > /dev/null 2>&1
> -
> -#receive needs to be able to setxattrs, including the selinux context, i=
f we use
> -#the normal nfs context thing it screws up our ability to set the
> -#security.selinux xattrs so we need to disable this for this test
> -export SELINUX_MOUNT_OPTIONS=3D""
> -
>  _scratch_mount
>
> -mkdir $TEST_DIR/$tmp_dir
> -$BTRFS_UTIL_PROG subvolume create $TEST_DIR/$tmp_dir/send \
> +mkdir $SCRATCH_MNT/$tmp_dir
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/$tmp_dir/send \
>         > $seqres.full 2>&1 || _fail "failed subvolume create"
>
> -_ddt of=3D$TEST_DIR/$tmp_dir/send/foo bs=3D1M count=3D10 >> $seqres.full=
 \
> +_ddt of=3D$SCRATCH_MNT/$tmp_dir/send/foo bs=3D1M count=3D10 >> $seqres.f=
ull \
>         2>&1 || _fail "dd failed"
> -$BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
> -       $TEST_DIR/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "failed sna=
p"
> -$XFS_IO_PROG -c "fpunch 1m 1m" $TEST_DIR/$tmp_dir/send/foo
> -$BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
> -       $TEST_DIR/$tmp_dir/snap1 >> $seqres.full 2>&1 || _fail "failed sn=
ap"
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/$tmp_dir/send \
> +       $SCRATCH_MNT/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "failed =
snap"
> +$XFS_IO_PROG -c "fpunch 1m 1m" $SCRATCH_MNT/$tmp_dir/send/foo
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/$tmp_dir/send \
> +       $SCRATCH_MNT/$tmp_dir/snap1 >> $seqres.full 2>&1 || _fail "failed=
 snap"
>
> -$FSSUM_PROG -A -f -w $tmp/fssum.snap $TEST_DIR/$tmp_dir/snap >> $seqres.=
full \
> +# -A disable access time check.
> +# And -T disable xattrs to prevent SELinux changes causing false alerts,=
 and the
> +# test case only cares about hole punching.
> +$FSSUM_PROG -AT -f -w $tmp/fssum.snap $SCRATCH_MNT/$tmp_dir/snap >> $seq=
res.full \
>         2>&1 || _fail "fssum gen failed"
> -$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $TEST_DIR/$tmp_dir/snap1 >> $seqre=
s.full \
> +$FSSUM_PROG -AT -f -w $tmp/fssum.snap1 $SCRATCH_MNT/$tmp_dir/snap1 >> $s=
eqres.full \
>         2>&1 || _fail "fssum gen failed"
>
> -$BTRFS_UTIL_PROG send -f $tmp/send.snap $TEST_DIR/$tmp_dir/snap >> \
> +$BTRFS_UTIL_PROG send -f $tmp/send.snap $SCRATCH_MNT/$tmp_dir/snap >> \
>         $seqres.full 2>&1 || _fail "failed send"
> -$BTRFS_UTIL_PROG send -p $TEST_DIR/$tmp_dir/snap \
> -       -f $tmp/send.snap1 $TEST_DIR/$tmp_dir/snap1 \
> +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/$tmp_dir/snap \
> +       -f $tmp/send.snap1 $SCRATCH_MNT/$tmp_dir/snap1 \
>         >> $seqres.full 2>&1 || _fail "failed send"
>
> +_scratch_unmount
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
>  $BTRFS_UTIL_PROG receive -f $tmp/send.snap $SCRATCH_MNT >> $seqres.full =
2>&1 \
>         || _fail "failed recv"
>  $BTRFS_UTIL_PROG receive -f $tmp/send.snap1 $SCRATCH_MNT >> $seqres.full=
 2>&1 \
> @@ -75,4 +65,5 @@ $FSSUM_PROG -r $tmp/fssum.snap1 $SCRATCH_MNT/snap1 >> $=
seqres.full 2>&1 \
>         || _fail "fssum failed"
>
>  echo "Silence is golden"
> -status=3D0 ; exit
> +status=3D0
> +exit

This hunk is unrelated and unnecessary.

But other than that, it looks good to me:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> --
> 2.43.1
>
>

