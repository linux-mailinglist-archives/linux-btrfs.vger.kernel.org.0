Return-Path: <linux-btrfs+bounces-2473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D27858F55
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918381F22985
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D56A030;
	Sat, 17 Feb 2024 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKt6Ou5+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FD81E;
	Sat, 17 Feb 2024 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172760; cv=none; b=gLy6IMhwakiyZfvGDib5GbI4owXBwE6RMwJyfsob2IzHhQ2QHFS3ykJjBv03WOOjPFI/8Jsg3VxpodrSN+Zy2oQZGmGoJ4uPF3YEkM5VzqpQ5Lto400Re+kPPEUJidEYKiqd3DB489Y52rFzpjT6PYapC5gY38dXGcZIK2DtrrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172760; c=relaxed/simple;
	bh=lzLlfa+DZESssHTLkres7VJ0/xzuUqx2IN8La690YqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/Qtp5QPX+s3/Q5eRk5z819M3pwAUwXKkpRHFhdVhxPK5hfn8pOhw8HmRjp1PNp1DSHeLW7D6hC1h9tm3Sl8uWhQaKelKgR21uVS2qpLl/yhyUx2kyZ8kQJPyCbFVWwMcHlaviYRX8zf38gdOT+Ee1E9oHSwNReOnP9l6e+sOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKt6Ou5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D11C433C7;
	Sat, 17 Feb 2024 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708172759;
	bh=lzLlfa+DZESssHTLkres7VJ0/xzuUqx2IN8La690YqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hKt6Ou5+EbqtJx4uvCWsLzKoOWg2RNS/9C8XOmybxrXrkmeNF6uWoQeFmX3m+EW0Y
	 un74oMLleyZZ1Yttd8N4KfOABAgTm3QG7QUKi89bIcKSNKAbnOKqH9hXi4tcNxEqyJ
	 4UJpCMVU5NKId88gHLgXIAn/b/9tuglppW3kbbckzvPjV0eXu55yOXVUWfIgfMpD6r
	 KdxxsDjq+eilCOG678/AA2ojT5F67BFxpbOvKGvFoaJu42s22NcbgQaTs1NMF63oim
	 9nah+aNjZU4KRvHb9wfjcdImRy2Wn4JkLxQWZy19/PVtttnZc1JyfRzEUF6revG6i/
	 v17svil4j6L+g==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3de25186fbso171746866b.0;
        Sat, 17 Feb 2024 04:25:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOjNTq/O/nOl+eJxc3xNtvg/8am3iJvqZFFysq6Kg83FxVZ3j0sUWO/Ghn4k7vTSB6fWtNZgJeJQjwwSG/7HEFA7jfWti1vQ==
X-Gm-Message-State: AOJu0Yz75nuhoqjPW5qEOQvIMOpe3qEDG/9gF5jSIJ2ju7nMY6pAqLLn
	R1F7RKnrlYwMy3PSOcblyxZHgX/37cL3yvoMVhMgMYgO/4XvSsnkz77/vlHUawjrrghade9uE0G
	Snrl7O4mWSyLhBtnhbZ1wuqKGDJ0=
X-Google-Smtp-Source: AGHT+IH//Kss3+xikeArBfo3/+s3dHSEbQgM201o2xc0+IYDs1rVaiLF5BXuD7Q96SFT2VvIOU9q6lGF6jKXiyKu7zI=
X-Received: by 2002:a17:906:7fd5:b0:a3d:b100:cdc1 with SMTP id
 r21-20020a1709067fd500b00a3db100cdc1mr4343838ejs.57.1708172758152; Sat, 17
 Feb 2024 04:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae441bd376587124becd9141ed690598d4ed281a.1703741660.git.wqu@suse.com>
In-Reply-To: <ae441bd376587124becd9141ed690598d4ed281a.1703741660.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 17 Feb 2024 12:25:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4SoEdTUNpkkotux5ZbNmmjsN8vJsC_JCBsJvsXM_y3Qg@mail.gmail.com>
Message-ID: <CAL3q7H4SoEdTUNpkkotux5ZbNmmjsN8vJsC_JCBsJvsXM_y3Qg@mail.gmail.com>
Subject: Re: [PATCH] btrfs/016: fix a false alert due to xattrs mismatch
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 5:36=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> Instead of doing all the edge juggling using $TEST_DIR, this time we do
> all the work on $SCRATCH_MNT.
>
> This means we would generate the initial send stream from $SCRATCH_MNT,
> then reformat the fs, mount scratch again, receive and verify.
>
> This does not only fix the above false alerts, but also simplify the
> cleanup.
> We no longer needs to cleanup the extra file for the initial send
> stream, as they are on the scratch device and would be formatted anyway.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/016 | 46 ++++++++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/tests/btrfs/016 b/tests/btrfs/016
> index 35609329ba0e..9371b3316332 100755
> --- a/tests/btrfs/016
> +++ b/tests/btrfs/016
> @@ -12,22 +12,11 @@ _begin_fstest auto quick send prealloc
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
> @@ -41,29 +30,33 @@ export SELINUX_MOUNT_OPTIONS=3D""
>
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
> +$FSSUM_PROG -A -f -w $tmp/fssum.snap $SCRATCH_MNT/$tmp_dir/snap >> $seqr=
es.full \
>         2>&1 || _fail "fssum gen failed"
> -$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $TEST_DIR/$tmp_dir/snap1 >> $seqre=
s.full \
> +$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $SCRATCH_MNT/$tmp_dir/snap1 >> $se=
qres.full \
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
> @@ -74,5 +67,10 @@ $FSSUM_PROG -r $tmp/fssum.snap $SCRATCH_MNT/snap >> $s=
eqres.full 2>&1 \
>  $FSSUM_PROG -r $tmp/fssum.snap1 $SCRATCH_MNT/snap1 >> $seqres.full 2>&1 =
\
>         || _fail "fssum failed"
>
> +# Unset the selinux mount options and restore whatever the default one f=
or
> +# test device.
> +unset SELINUX_MOUNT_OPTIONS
> +_test_cycle_mount

Why do we need to _test_cycle_mount?

We're not using the test device anymore after this change, so
unsetting SELINUX_MOUNT_OPTIONS should be enough.

A simpler alternative fix would be just to pass -T to fssum, so that
it ignores xattrs when computing/verifying checksums, which is ok
since the tests' goal is to verify file data and that the hole
punching worked. Or just not use fssum and compare md5sum in the
original fs and the new fs.

Either way, it looks good to me except that confusing part of the
_test_cycle_mount which seems irrelevant to me.

Thanks.

> +
>  echo "Silence is golden"
>  status=3D0 ; exit
> --
> 2.43.0
>
>

