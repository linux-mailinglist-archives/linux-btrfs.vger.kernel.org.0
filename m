Return-Path: <linux-btrfs+bounces-11870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E67A45BF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849123A6AE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B912459F9;
	Wed, 26 Feb 2025 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXXPRJG1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA42036EB;
	Wed, 26 Feb 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566280; cv=none; b=AbOnDdu86Vte1wPcOCotVqXG/nT5YUSzw6Afsx5wS5VdwCTPGvNufAJOEJIfKtf3kS8UcAtnITgngcoZu9Y+LKB2UZfB/BZ+U6ybS7w6+rXBI76CpAhELqhqT6f12oUKdf8J4uWcQRYaTePP3U8xJ9IdT0tLLeEX1SBoKP54xp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566280; c=relaxed/simple;
	bh=ui7DHzBTx6t+D3309JMTsc6xXEBHTLAOINLBbMbYhyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6FUgyhsrAwYBXhvVTvqT5Dpwq+YX+b4gz3m/x+CwzajC94uvNhsN+3YaSpFexTMzJ2wwBxin+8KrEEoQBkt8iEjWALSVT1P+Zdws0Ue30eVnbFRStgzwymV8Lg3O/an4QpXc00GgwamiRJmokzEH4v9EX+rA+kdOg2QxQlrBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXXPRJG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9206DC4CEE2;
	Wed, 26 Feb 2025 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740566279;
	bh=ui7DHzBTx6t+D3309JMTsc6xXEBHTLAOINLBbMbYhyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eXXPRJG10+CH6EDkcHTOMezYIBbRz/Bq4fJLBT2FiA9hH/11kvNUFuEnKvL558Nrl
	 xEWH0sxAiPx6z3h2WnLGyG4bul+Tjy0UxYmAHg/BI2h+VnrXW2tHWg58DimFRcx7Ku
	 +tCg19yLaKBkf+skWVQ7dwndBbZmlDl5xowsG+O74dtQQFqkfriv0UINPac/wHp+L1
	 wltYiqdVZ3jlGWoBMzXbGy6RKhBUPsxuz560V5AAJRkpQfFeOyq0Ir0X/OGnHyjDfs
	 wdvM8F92V1ulk1nap3NQnsOKQAMTmTMV8jqS7cil1etO4uU352jbfBwxmD38cyus2C
	 0RrHoCHWk77bg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso1311443866b.2;
        Wed, 26 Feb 2025 02:37:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvP9WLu1PnxRaQllO8J8A0ak3mXZ5rLfbIgrtrPRaOZuksf2O9WMGE4T1RlifvhwnzS/D80hce@vger.kernel.org, AJvYcCXP2sCd1Ixv6VQe7QO36UAuX1Jm6AUuSMi41SW0WZPRhqt042UPTc/p8vAZVnUt4cjCCBnSJdZSJksdjx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Igt0dz7mAr4qUr38MmpZe80LNYacyLcD8UcO9PgEy45L0tnf
	0b41CrwIbvQu8eUhIsVH45/aqVzdXmd5n8rCJ/7TBRldWgk3iev8ek75NJphkyXFxsW8FQVJ2fw
	jtvlnRvmW1l8GxLWQbYwJ3Hr6lFo=
X-Google-Smtp-Source: AGHT+IE3dZxXiyW9IgN4z1ZljXnzJpdMVDU88FDSMC6xJ4vll5u0n0nAk+55V5ph858mALRukr9pp5xkkGVsV2I0MGQ=
X-Received: by 2002:a17:907:9494:b0:ab6:36fd:942a with SMTP id
 a640c23a62f3a-abc0de57fe9mr2176690266b.50.1740566277421; Wed, 26 Feb 2025
 02:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739989076.git.fdmanana@suse.com> <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com> <20250220170333.GV21799@frogsfrogsfrogs>
 <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
 <20250221041819.GX21799@frogsfrogsfrogs> <Z75B38rmY9TPsftf@dread.disaster.area>
In-Reply-To: <Z75B38rmY9TPsftf@dread.disaster.area>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 26 Feb 2025 10:37:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H41a=gzDtQDX8L4ep5PhD4ZpuSCUiNGzx5eK2h_N6bQXQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqgKdaHIkrb2RMjvNRCaKWme7SWHR3d2JTHwOjMQYmvCbyFCJ7_aeWJnrw
Message-ID: <CAL3q7H41a=gzDtQDX8L4ep5PhD4ZpuSCUiNGzx5eK2h_N6bQXQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: finish UMOUNT_PROG to _unmount conversion
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, 
	Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:19=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Thu, Feb 20, 2025 at 08:18:19PM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 20, 2025 at 06:22:57PM +0000, Filipe Manana wrote:
> > > On Thu, Feb 20, 2025 at 5:03=E2=80=AFPM Darrick J. Wong <djwong@kerne=
l.org> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 01:27:32PM +0800, Anand Jain wrote:
> > > > > On 20/2/25 02:19, fdmanana@kernel.org wrote:
> > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > >
> > > > > > If the test fails or is interrupted after mounting $scratch_dev=
3 inside
> > > > > > the test filesystem and before unmounting at test_add_device(),=
 we leave
> > > > > > without being unable to unmount the test filesystem since it ha=
s a mount
> > > > > > inside it. This results in the need to manually unmount $scratc=
h_dev3,
> > > > > > otherwise a subsequent run of fstests fails since the unmount o=
f the
> > > > > > test device fails with -EBUSY.
> > > > > >
> > > > > > Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup=
()
> > > > > > function.
> > > > > >
> > > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > > ---
> > > > > >   tests/btrfs/254 | 1 +
> > > > > >   1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/tests/btrfs/254 b/tests/btrfs/254
> > > > > > index d9c9eea9..6523389b 100755
> > > > > > --- a/tests/btrfs/254
> > > > > > +++ b/tests/btrfs/254
> > > > > > @@ -21,6 +21,7 @@ _cleanup()
> > > > > >   {
> > > > > >     cd /
> > > > > >     rm -f $tmp.*
> > > > > > +   $UMOUNT_PROG $seq_mnt > /dev/null 2>&1
> > > >
> > > > This should use the _unmount helper that's in for-next.
> > >
> > > Sure, it does the same, except that it redirects stdout and stderr to
> > > $seqres.full.
> > >
> > > Some tests are still calling  $UMOUNT_PROG directly. And that's often
> > > what we want, so that if umount fails we get a mismatch with the
> > > golden output instead of ignoring the failure.
> > > But in this case it's fine.
> >
> > <groan> You're right, I'd repressed that Chinner decided to introduce
> > _unmount so that he could improve logging of unmount failures but then
> > he only bothered converting tests/{generic,xfs} because he didn't give
> > a damn about anyone else.
>
> That's uncalled for, Darrick.
>
> You know very well that I posted an incomplete RFC that I was asking
> for reveiw on, not for it to be merged. The maintainer decided to
> merge it and did not wait for me to finish the conversions.
>
> > Now fstests is stuck with a half finished conversion and no clarity
> > about whether the rest of the $UMOUNT_PROG invocations should be
> > converted to _umount or if those are somehow intentional.
> >
> > Hey Zorro, do you have any opinion on this?  Should someone just finish
> > the $UMOUNT_PROG -> _unmount conversion next week?
>
> Why put it off? With the logging fixes to _unmount() that are
> already merged, it's a purely mechanical change using sed. Patch
> below.
>
> -Dave.
>
> --
> Dave Chinner
> david@fromorbit.com
>
> fstests: finish UMOUNT_PROG to _unmount conversion
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Because only tests/generic and tests/xfs have been converted so far
> and the conversion needs finishing. _unmount is a drop-in
> replacement for $UMOUNT_PROG, so we can simply do a mechanical
> conversion like so:
>
> $ sed -i s/\$UMOUNT_PROG/_unmount/g tests/*/*
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/btrfs/020   |  2 +-
>  tests/btrfs/029   |  2 +-
>  tests/btrfs/031   |  2 +-
>  tests/btrfs/060   |  2 +-
>  tests/btrfs/065   |  2 +-
>  tests/btrfs/066   |  2 +-
>  tests/btrfs/067   |  2 +-
>  tests/btrfs/068   |  2 +-
>  tests/btrfs/075   |  2 +-
>  tests/btrfs/089   |  2 +-
>  tests/btrfs/124   |  2 +-
>  tests/btrfs/125   |  2 +-
>  tests/btrfs/185   |  4 ++--
>  tests/btrfs/197   |  4 ++--
>  tests/btrfs/219   | 12 ++++++------
>  tests/btrfs/254   |  2 +-
>  tests/btrfs/311   |  2 +-
>  tests/btrfs/313   |  2 +-
>  tests/btrfs/314   |  2 +-
>  tests/btrfs/315   |  2 +-
>  tests/btrfs/318   |  6 +++---
>  tests/btrfs/326   | 10 +++++-----
>  tests/btrfs/330   |  4 ++--
>  tests/ext4/032    |  4 ++--
>  tests/ext4/052    |  4 ++--
>  tests/ext4/053    | 32 ++++++++++++++++----------------
>  tests/ext4/056    |  2 +-
>  tests/overlay/003 |  2 +-
>  tests/overlay/004 |  2 +-
>  tests/overlay/005 |  6 +++---
>  tests/overlay/014 |  4 ++--
>  tests/overlay/022 |  2 +-
>  tests/overlay/025 |  4 ++--
>  tests/overlay/029 |  6 +++---
>  tests/overlay/031 |  8 ++++----
>  tests/overlay/035 |  2 +-
>  tests/overlay/036 |  8 ++++----
>  tests/overlay/037 |  6 +++---
>  tests/overlay/040 |  2 +-
>  tests/overlay/041 |  2 +-
>  tests/overlay/042 |  2 +-
>  tests/overlay/043 |  2 +-
>  tests/overlay/044 |  2 +-
>  tests/overlay/048 |  4 ++--
>  tests/overlay/049 |  2 +-
>  tests/overlay/050 |  2 +-
>  tests/overlay/051 |  4 ++--
>  tests/overlay/052 |  2 +-
>  tests/overlay/053 |  4 ++--
>  tests/overlay/054 |  2 +-
>  tests/overlay/055 |  4 ++--
>  tests/overlay/056 |  2 +-
>  tests/overlay/057 |  4 ++--
>  tests/overlay/059 |  2 +-
>  tests/overlay/060 |  2 +-
>  tests/overlay/062 |  2 +-
>  tests/overlay/063 |  2 +-
>  tests/overlay/065 | 22 +++++++++++-----------
>  tests/overlay/067 |  2 +-
>  tests/overlay/068 |  4 ++--
>  tests/overlay/069 |  6 +++---
>  tests/overlay/070 |  6 +++---
>  tests/overlay/071 |  6 +++---
>  tests/overlay/076 |  2 +-
>  tests/overlay/077 |  2 +-
>  tests/overlay/078 |  2 +-
>  tests/overlay/079 |  2 +-
>  tests/overlay/080 |  2 +-
>  tests/overlay/081 | 14 +++++++-------
>  tests/overlay/083 |  2 +-
>  tests/overlay/084 | 10 +++++-----
>  tests/overlay/085 |  2 +-
>  tests/overlay/086 |  8 ++++----
>  73 files changed, 153 insertions(+), 153 deletions(-)
>
> diff --git a/tests/btrfs/020 b/tests/btrfs/020
> index 7e5c6fd7b..badb76f75 100755
> --- a/tests/btrfs/020
> +++ b/tests/btrfs/020
> @@ -17,7 +17,7 @@ _cleanup()
>  {
>         cd /
>         rm -f $tmp.*
> -       $UMOUNT_PROG $loop_mnt
> +       _unmount $loop_mnt
>         _destroy_loop_device $loop_dev1
>         losetup -d $loop_dev2 >/dev/null 2>&1
>         _destroy_loop_device $loop_dev3
> diff --git a/tests/btrfs/029 b/tests/btrfs/029
> index c37ad63fb..1f8201af3 100755
> --- a/tests/btrfs/029
> +++ b/tests/btrfs/029
> @@ -74,7 +74,7 @@ cp --reflink=3Dalways $orig_file $copy_file >> $seqres.=
full 2>&1 || echo "cp refli
>  md5sum $orig_file | _filter_testdir_and_scratch
>  md5sum $copy_file | _filter_testdir_and_scratch
>
> -$UMOUNT_PROG $reflink_test_dir
> +_unmount $reflink_test_dir

This isn't equivalent to directly calling UMOUNT_PROG since the
_unmount helper always redirects stdout and stderr to $seqres.full.
Meaning failures may often be ignored or not immediately obvious as before.

This applies to many other places, just picking the first to comment.

>
>  # success, all done
>  status=3D0
> diff --git a/tests/btrfs/031 b/tests/btrfs/031
> index 8ac73d3a8..12ad84c64 100755
> --- a/tests/btrfs/031
> +++ b/tests/btrfs/031
> @@ -99,7 +99,7 @@ mv $testdir2/file* $subvol2/
>  echo "Verify the file contents:"
>  _checksum_files
>
> -$UMOUNT_PROG $cross_mount_test_dir
> +_unmount $cross_mount_test_dir
>
>  # success, all done
>  status=3D0
> diff --git a/tests/btrfs/060 b/tests/btrfs/060
> index 21f15ec89..fff9bed81 100755
> --- a/tests/btrfs/060
> +++ b/tests/btrfs/060
> @@ -76,7 +76,7 @@ run_test()
>         fi
>
>         # in case the subvolume is still mounted
> -       $UMOUNT_PROG $subvol_mnt >/dev/null 2>&1
> +       _unmount $subvol_mnt >/dev/null 2>&1

And here there's no point of having the redirections, since the helper
always redirects stdout/stderr to $seqres.full.
So it could be removed to make things more readable.

This also applies to many other places, just picking the first to comment.

Thanks.

>         _scratch_unmount
>         # we called _require_scratch_nocheck instead of _require_scratch
>         # do check after test for each profile config
> diff --git a/tests/btrfs/065 b/tests/btrfs/065
> index f0c9ffb04..77ec89038 100755
> --- a/tests/btrfs/065
> +++ b/tests/btrfs/065
> @@ -84,7 +84,7 @@ run_test()
>         fi
>
>         # in case the subvolume is still mounted
> -       $UMOUNT_PROG $subvol_mnt >/dev/null 2>&1
> +       _unmount $subvol_mnt >/dev/null 2>&1
>         _scratch_unmount
>         # we called _require_scratch_nocheck instead of _require_scratch
>         # do check after test for each profile config
> diff --git a/tests/btrfs/066 b/tests/btrfs/066
> index e3a083b94..07ed799a5 100755
> --- a/tests/btrfs/066
> +++ b/tests/btrfs/066
> @@ -76,7 +76,7 @@ run_test()
>         fi
>
>         # in case the subvolume is still mounted
> -       $UMOUNT_PROG $subvol_mnt >/dev/null 2>&1
> +       _unmount $subvol_mnt >/dev/null 2>&1
>         _scratch_unmount
>         # we called _require_scratch_nocheck instead of _require_scratch
>         # do check after test for each profile config
> diff --git a/tests/btrfs/067 b/tests/btrfs/067
> index 768993116..17c772d04 100755
> --- a/tests/btrfs/067
> +++ b/tests/btrfs/067
> @@ -77,7 +77,7 @@ run_test()
>         fi
>
>         # in case the subvolume is still mounted
> -       $UMOUNT_PROG $subvol_mnt >/dev/null 2>&1
> +       _unmount $subvol_mnt >/dev/null 2>&1
>         _scratch_unmount
>         # we called _require_scratch_nocheck instead of _require_scratch
>         # do check after test for each profile config
> diff --git a/tests/btrfs/068 b/tests/btrfs/068
> index 3d221259f..37b6b6ba8 100755
> --- a/tests/btrfs/068
> +++ b/tests/btrfs/068
> @@ -77,7 +77,7 @@ run_test()
>         fi
>
>         # in case the subvolume is still mounted
> -       $UMOUNT_PROG $subvol_mnt >/dev/null 2>&1
> +       _unmount $subvol_mnt >/dev/null 2>&1
>         _scratch_unmount
>         # we called _require_scratch_nocheck instead of _require_scratch
>         # do check after test for each profile config
> diff --git a/tests/btrfs/075 b/tests/btrfs/075
> index 917993ca2..328dc5f68 100755
> --- a/tests/btrfs/075
> +++ b/tests/btrfs/075
> @@ -15,7 +15,7 @@ _cleanup()
>  {
>         cd /
>         rm -f $tmp.*
> -       $UMOUNT_PROG $subvol_mnt >/dev/null 2>&1
> +       _unmount $subvol_mnt >/dev/null 2>&1
>  }
>
>  . ./common/filter
> diff --git a/tests/btrfs/089 b/tests/btrfs/089
> index 8f8e37b6f..8c06535d9 100755
> --- a/tests/btrfs/089
> +++ b/tests/btrfs/089
> @@ -35,7 +35,7 @@ mount --bind "$SCRATCH_MNT/testvol/testdir" "$SCRATCH_M=
NT/testvol/mnt"
>  $BTRFS_UTIL_PROG subvolume delete "$SCRATCH_MNT/testvol" >>$seqres.full =
2>&1
>
>  # Unmount the bind mount, which should still be alive.
> -$UMOUNT_PROG "$SCRATCH_MNT/testvol/mnt"
> +_unmount "$SCRATCH_MNT/testvol/mnt"
>
>  echo "Silence is golden"
>  status=3D0
> diff --git a/tests/btrfs/124 b/tests/btrfs/124
> index af079c286..7c33a8fab 100755
> --- a/tests/btrfs/124
> +++ b/tests/btrfs/124
> @@ -132,7 +132,7 @@ if [ "$checkpoint1" !=3D "$checkpoint3" ]; then
>         echo "Inital sum does not match with data on dev2 written by bala=
nce"
>  fi
>
> -$UMOUNT_PROG $dev2
> +_unmount $dev2
>  _scratch_dev_pool_put
>  _btrfs_rescan_devices
>  _test_mount
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index c8c0dd422..790f35d55 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -144,7 +144,7 @@ if [ "$checkpoint1" !=3D "$checkpoint3" ]; then
>         echo "Inital sum does not match with data on dev2 written by bala=
nce"
>  fi
>
> -$UMOUNT_PROG $dev2
> +_unmount $dev2
>  _scratch_dev_pool_put
>  _btrfs_rescan_devices
>  _test_mount
> diff --git a/tests/btrfs/185 b/tests/btrfs/185
> index 8d0643450..f52608852 100755
> --- a/tests/btrfs/185
> +++ b/tests/btrfs/185
> @@ -15,7 +15,7 @@ mnt=3D$TEST_DIR/$seq.mnt
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -       $UMOUNT_PROG $mnt > /dev/null 2>&1
> +       _unmount $mnt > /dev/null 2>&1
>         rm -rf $mnt > /dev/null 2>&1
>         cd /
>         rm -f $tmp.*
> @@ -62,7 +62,7 @@ $BTRFS_UTIL_PROG device scan $device_1 >> $seqres.full =
2>&1
>         _fail "if it fails here, then it means subvolume mount at boot ma=
y fail "\
>               "in some configs."
>
> -$UMOUNT_PROG $mnt > /dev/null 2>&1
> +_unmount $mnt > /dev/null 2>&1
>  _scratch_dev_pool_put
>
>  # success, all done
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> index 9f1d879a4..111589913 100755
> --- a/tests/btrfs/197
> +++ b/tests/btrfs/197
> @@ -15,7 +15,7 @@ _begin_fstest auto quick volume
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -       $UMOUNT_PROG $TEST_DIR/$seq.mnt >/dev/null 2>&1
> +       _unmount $TEST_DIR/$seq.mnt >/dev/null 2>&1
>         rm -rf $TEST_DIR/$seq.mnt
>         cd /
>         rm -f $tmp.*
> @@ -67,7 +67,7 @@ workout()
>         grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stal=
e device"
>
>         $BTRFS_UTIL_PROG device remove "${SCRATCH_DEV_NAME[1]}" "$TEST_DI=
R/$seq.mnt"
> -       $UMOUNT_PROG $TEST_DIR/$seq.mnt
> +       _unmount $TEST_DIR/$seq.mnt
>         _scratch_unmount
>         _spare_dev_put
>         _scratch_dev_pool_put
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index 052f61a39..58384957e 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -21,8 +21,8 @@ _cleanup()
>         rm -f $tmp.*
>
>         # The variables are set before the test case can fail.
> -       $UMOUNT_PROG ${loop_mnt1} &> /dev/null
> -       $UMOUNT_PROG ${loop_mnt2} &> /dev/null
> +       _unmount ${loop_mnt1} &> /dev/null
> +       _unmount ${loop_mnt2} &> /dev/null
>         rm -rf $loop_mnt1
>         rm -rf $loop_mnt2
>
> @@ -66,7 +66,7 @@ loop_dev2=3D`_create_loop_device $fs_img2`
>  # Normal single device case, should pass just fine
>  _mount $loop_dev1 $loop_mnt1 > /dev/null  2>&1 || \
>         _fail "Couldn't do initial mount"
> -$UMOUNT_PROG $loop_mnt1
> +_unmount $loop_mnt1
>
>  _btrfs_forget_or_module_reload
>
> @@ -75,15 +75,15 @@ _btrfs_forget_or_module_reload
>  # measure.
>  _mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>         _fail "Failed to mount the second time"
> -$UMOUNT_PROG $loop_mnt1
> +_unmount $loop_mnt1
>
>  _mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 || \
>         _fail "We couldn't mount the old generation"
> -$UMOUNT_PROG $loop_mnt2
> +_unmount $loop_mnt2
>
>  _mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>         _fail "Failed to mount the second time"
> -$UMOUNT_PROG $loop_mnt1
> +_unmount $loop_mnt1
>
>  # Now try mount them at the same time, if kernel does not support
>  # temp-fsid feature then mount will fail.
> diff --git a/tests/btrfs/254 b/tests/btrfs/254
> index d9c9eea9c..548224894 100755
> --- a/tests/btrfs/254
> +++ b/tests/btrfs/254
> @@ -96,7 +96,7 @@ test_add_device()
>         $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>                                         _filter_btrfs_filesystem_show
>
> -       $UMOUNT_PROG $seq_mnt
> +       _unmount $seq_mnt
>         _scratch_unmount
>         cleanup_dmdev
>  }
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> index 51147c59f..3161e62db 100755
> --- a/tests/btrfs/311
> +++ b/tests/btrfs/311
> @@ -14,7 +14,7 @@ _begin_fstest auto quick subvol tempfsid
>  _cleanup()
>  {
>         cd /
> -       $UMOUNT_PROG $mnt1 > /dev/null 2>&1
> +       _unmount $mnt1 > /dev/null 2>&1
>         rm -r -f $tmp.*
>         rm -r -f $mnt1
>  }
> diff --git a/tests/btrfs/313 b/tests/btrfs/313
> index 5a9e98dea..bf62af7b2 100755
> --- a/tests/btrfs/313
> +++ b/tests/btrfs/313
> @@ -12,7 +12,7 @@ _begin_fstest auto quick clone tempfsid
>  _cleanup()
>  {
>         cd /
> -       $UMOUNT_PROG $mnt1 > /dev/null 2>&1
> +       _unmount $mnt1 > /dev/null 2>&1
>         rm -r -f $tmp.*
>         rm -r -f $mnt1
>  }
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 76dccc41f..f3e5c504b 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -13,7 +13,7 @@ _begin_fstest auto quick snapshot send tempfsid
>  _cleanup()
>  {
>         cd /
> -       $UMOUNT_PROG $tempfsid_mnt 2>/dev/null
> +       _unmount $tempfsid_mnt 2>/dev/null
>         rm -r -f $tmp.*
>         rm -r -f $sendfile
>         rm -r -f $tempfsid_mnt
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index e6589abec..0ea2e8b35 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -13,7 +13,7 @@ _begin_fstest auto quick volume seed balance tempfsid
>  _cleanup()
>  {
>         cd /
> -       $UMOUNT_PROG $tempfsid_mnt 2>/dev/null
> +       _unmount $tempfsid_mnt 2>/dev/null
>         rm -r -f $tmp.*
>         rm -r -f $tempfsid_mnt
>  }
> diff --git a/tests/btrfs/318 b/tests/btrfs/318
> index df5a4a072..ad3040d64 100755
> --- a/tests/btrfs/318
> +++ b/tests/btrfs/318
> @@ -22,8 +22,8 @@ _require_loop
>
>  _cleanup() {
>         cd /
> -       $UMOUNT_PROG $MNT
> -       $UMOUNT_PROG $BIND
> +       _unmount $MNT
> +       _unmount $BIND
>         losetup -d $DEV0 $DEV1 $DEV2
>         rm -f $IMG0 $IMG1 $IMG2
>         rm -rf $MNT $BIND
> @@ -58,7 +58,7 @@ $MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 >>$se=
qres.full 2>&1 || _fail "
>  rm -rf $MNT
>  mkdir -p $MNT
>  _mount $D0P1 $MNT
> -$UMOUNT_PROG $MNT
> +_unmount $MNT
>
>  # Swap the partition dev_ts. This leaves the dev_t in the cache out of d=
ate.
>  $PARTED_PROG $DEV0 'rm 1' --script
> diff --git a/tests/btrfs/326 b/tests/btrfs/326
> index 1fc4db06b..51f769f9a 100755
> --- a/tests/btrfs/326
> +++ b/tests/btrfs/326
> @@ -25,8 +25,8 @@ _cleanup()
>         [ -n "$mount_pid" ] && kill $mount_pid &> /dev/null
>         [ -n "$remount_pid" ] && kill $remount_pid &> /dev/null
>         wait
> -       $UMOUNT_PROG "$subv1_mount" &> /dev/null
> -       $UMOUNT_PROG "$subv2_mount" &> /dev/null
> +       _unmount "$subv1_mount" &> /dev/null
> +       _unmount "$subv2_mount" &> /dev/null
>         rm -rf -- "$subv1_mount" "$subv2_mount"
>  }
>
> @@ -80,7 +80,7 @@ mount_workload()
>         trap "wait; exit" SIGTERM
>         while true; do
>                 _mount "$SCRATCH_DEV" "$subv2_mount"
> -               $UMOUNT_PROG "$subv2_mount"
> +               _unmount "$subv2_mount"
>         done
>  }
>
> @@ -94,12 +94,12 @@ wait
>  unset remount_pid mount_pid
>
>  # Subv1 is always mounted, thus the umount should never fail.
> -$UMOUNT_PROG "$subv1_mount"
> +_unmount "$subv1_mount"
>
>  # Subv2 may have already been unmounted, so here we ignore all output.
>  # This may hide some errors like -EBUSY, but the next rm line would
>  # detect any still mounted subvolume so we're still safe.
> -$UMOUNT_PROG "$subv2_mount" &> /dev/null
> +_unmount "$subv2_mount" &> /dev/null
>
>  # If above unmount, especially subv2 is not properly unmounted,
>  # the rm should fail with some error message
> diff --git a/tests/btrfs/330 b/tests/btrfs/330
> index 92cc498f2..07de58698 100755
> --- a/tests/btrfs/330
> +++ b/tests/btrfs/330
> @@ -48,7 +48,7 @@ echo "making sure bar allows writes"
>  touch $TEST_DIR/$seq/bar/qux
>  ls $TEST_DIR/$seq/bar
>
> -$UMOUNT_PROG $TEST_DIR/$seq/foo
> -$UMOUNT_PROG $TEST_DIR/$seq/bar
> +_unmount $TEST_DIR/$seq/foo
> +_unmount $TEST_DIR/$seq/bar
>
>  status=3D0 ; exit
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 690fcf066..e6f8c22ba 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -63,7 +63,7 @@ ext4_online_resize()
>         fi
>         cat $tmp.resize2fs >> $seqres.full
>         echo "+++ umount fs" | tee -a $seqres.full
> -       $UMOUNT_PROG ${IMG_MNT}
> +       _unmount ${IMG_MNT}
>
>         echo "+++ check fs" | tee -a $seqres.full
>         _check_generic_filesystem $LOOP_DEVICE >> $seqres.full 2>&1 || \
> @@ -77,7 +77,7 @@ _cleanup()
>         cd /
>         [ -n "$LOOP_DEVICE" ] && _destroy_loop_device $LOOP_DEVICE > /dev=
/null 2>&1
>         rm -f $tmp.*
> -       $UMOUNT_PROG ${IMG_MNT} > /dev/null 2>&1
> +       _unmount ${IMG_MNT} > /dev/null 2>&1
>         rm -f ${IMG_FILE} > /dev/null 2>&1
>  }
>
> diff --git a/tests/ext4/052 b/tests/ext4/052
> index 0df8a6513..4c02f75cb 100755
> --- a/tests/ext4/052
> +++ b/tests/ext4/052
> @@ -18,7 +18,7 @@ _cleanup()
>         cd /
>         rm -r -f $tmp.*
>         if [ ! -z "$loop_mnt" ]; then
> -               $UMOUNT_PROG $loop_mnt
> +               _unmount $loop_mnt
>                 rm -rf $loop_mnt
>         fi
>         [ ! -z "$fs_img" ] && rm -rf $fs_img
> @@ -64,7 +64,7 @@ then
>      status=3D1
>  fi
>
> -$UMOUNT_PROG $loop_mnt || _fail "umount failed"
> +_unmount $loop_mnt || _fail "umount failed"
>  loop_mnt=3D
>
>  $E2FSCK_PROG -fn $fs_img >> $seqres.full 2>&1 || _fail "file system corr=
upted"
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 5922ed571..3e2cda099 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -20,7 +20,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _cleanup()
>  {
>         cd /
> -       $UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +       _unmount $SCRATCH_MNT > /dev/null 2>&1
>         if [ -n "$LOOP_LOGDEV" ];then
>                 _destroy_loop_device $LOOP_LOGDEV 2>/dev/null
>         fi
> @@ -236,7 +236,7 @@ not_mnt() {
>         if simple_mount -o $1 $SCRATCH_DEV $SCRATCH_MNT; then
>                 print_log "(mount unexpectedly succeeded)"
>                 fail
> -               $UMOUNT_PROG $SCRATCH_MNT
> +               _unmount $SCRATCH_MNT
>                 return
>         fi
>         ok
> @@ -247,7 +247,7 @@ not_mnt() {
>                 return
>         fi
>         not_remount $1
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  mnt_only() {
> @@ -269,7 +269,7 @@ mnt() {
>         fi
>
>         mnt_only $*
> -       $UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +       _unmount $SCRATCH_MNT 2> /dev/null
>
>         [ "$t2fs" -eq 0 ] && return
>
> @@ -288,7 +288,7 @@ mnt() {
>                                     -e 's/data=3Dwriteback/journal_data_w=
riteback/')
>         $TUNE2FS_PROG -o $op_set $SCRATCH_DEV > /dev/null 2>&1
>         mnt_only "defaults" $check
> -       $UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +       _unmount $SCRATCH_MNT 2> /dev/null
>         if [ "$op_set" =3D ^* ]; then
>                 op_set=3D${op_set#^}
>         else
> @@ -308,12 +308,12 @@ remount() {
>         do_mnt remount,$2 $3
>         if [ $? -ne 0 ]; then
>                 fail
> -               $UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +               _unmount $SCRATCH_MNT 2> /dev/null
>                 return
>         else
>                 ok
>         fi
> -       $UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +       _unmount $SCRATCH_MNT 2> /dev/null
>
>         # Now just specify mnt
>         print_log "mounting $fstype \"$1\" "
> @@ -327,7 +327,7 @@ remount() {
>                 ok
>         fi
>
> -       $UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +       _unmount $SCRATCH_MNT 2> /dev/null
>  }
>
>  # Test that the filesystem cannot be remounted with option(s) $1 (meanin=
g that
> @@ -363,7 +363,7 @@ mnt_then_not_remount() {
>                 return
>         fi
>         not_remount $2
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>
> @@ -399,8 +399,8 @@ LOGDEV_DEVNUM=3D`echo "${majmin%:*}*2^8 + ${majmin#*:=
}" | bc`
>  fstype=3D
>  for fstype in ext2 ext3 ext4; do
>
> -       $UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> -       $UMOUNT_PROG $SCRATCH_DEV 2> /dev/null
> +       _unmount $SCRATCH_MNT 2> /dev/null
> +       _unmount $SCRATCH_DEV 2> /dev/null
>
>         do_mkfs $SCRATCH_DEV ${SIZE}k
>
> @@ -417,7 +417,7 @@ for fstype in ext2 ext3 ext4; do
>                 continue
>         fi
>
> -       $UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +       _unmount $SCRATCH_MNT 2> /dev/null
>
>         not_mnt failme
>         mnt
> @@ -551,7 +551,7 @@ for fstype in ext2 ext3 ext4; do
>         # dax mount options
>         simple_mount -o dax=3Dalways $SCRATCH_DEV $SCRATCH_MNT > /dev/nul=
l 2>&1
>         if [ $? -eq 0 ]; then
> -               $UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
> +               _unmount $SCRATCH_MNT 2> /dev/null
>                 mnt dax
>                 mnt dax=3Dalways
>                 mnt dax=3Dnever
> @@ -632,7 +632,7 @@ for fstype in ext2 ext3 ext4; do
>         not_remount jqfmt=3Dvfsv1
>         not_remount noquota
>         mnt_only remount,usrquota,grpquota ^usrquota,^grpquota
> -       $UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +       _unmount $SCRATCH_MNT > /dev/null 2>&1
>
>         # test clearing/changing quota when enabled
>         do_mkfs -E quotatype=3D^prjquota $SCRATCH_DEV ${SIZE}k
> @@ -653,7 +653,7 @@ for fstype in ext2 ext3 ext4; do
>         mnt_only remount,usrquota,grpquota usrquota,grpquota
>         quotaoff -f $SCRATCH_MNT >> $seqres.full 2>&1
>         mnt_only remount,noquota ^usrquota,^grpquota,quota
> -       $UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +       _unmount $SCRATCH_MNT > /dev/null 2>&1
>
>         # Quota feature
>         echo "=3D=3D Testing quota feature " >> $seqres.full
> @@ -695,7 +695,7 @@ for fstype in ext2 ext3 ext4; do
>
>  done #for fstype in ext2 ext3 ext4; do
>
> -$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +_unmount $SCRATCH_MNT > /dev/null 2>&1
>  echo "$ERR errors encountered" >> $seqres.full
>
>  status=3D$ERR
> diff --git a/tests/ext4/056 b/tests/ext4/056
> index fb5bbe93e..d22aebfa6 100755
> --- a/tests/ext4/056
> +++ b/tests/ext4/056
> @@ -72,7 +72,7 @@ do_resize()
>         # delay
>         sleep 0.2
>         _scratch_unmount >> $seqres.full 2>&1 \
> -               || _fail "$UMOUNT_PROG failed. Exiting"
> +               || _fail "_unmount failed. Exiting"
>  }
>
>  run_test()
> diff --git a/tests/overlay/003 b/tests/overlay/003
> index 41ad99e79..0b5660b8e 100755
> --- a/tests/overlay/003
> +++ b/tests/overlay/003
> @@ -56,7 +56,7 @@ rm -rf ${SCRATCH_MNT}/*
>  ls ${SCRATCH_MNT}/
>
>  # unmount overlayfs but not base fs
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  echo "Silence is golden"
>  # success, all done
> diff --git a/tests/overlay/004 b/tests/overlay/004
> index bea4bb543..e97e9ddd9 100755
> --- a/tests/overlay/004
> +++ b/tests/overlay/004
> @@ -53,7 +53,7 @@ _user_do "chmod u-X ${SCRATCH_MNT}/attr_file2 > /dev/nu=
ll 2>&1"
>  stat -c %a ${SCRATCH_MNT}/attr_file2
>
>  # unmount overlayfs but not base fs
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # check mode bits of the file that has been copied up, and
>  # the file that should not have been copied up.
> diff --git a/tests/overlay/005 b/tests/overlay/005
> index 4c11d5e1b..1495999b7 100755
> --- a/tests/overlay/005
> +++ b/tests/overlay/005
> @@ -75,14 +75,14 @@ $XFS_IO_PROG -f -c "o" ${SCRATCH_MNT}/test_file \
>         >>$seqres.full 2>&1
>
>  # unmount overlayfs
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # check overlayfs
>  _overlay_check_scratch_dirs $lowerd $upperd $workd
>
>  # unmount undelying xfs, this tiggers panic if memleak happens
> -$UMOUNT_PROG ${OVL_BASE_SCRATCH_MNT}/uppermnt
> -$UMOUNT_PROG ${OVL_BASE_SCRATCH_MNT}/lowermnt
> +_unmount ${OVL_BASE_SCRATCH_MNT}/uppermnt
> +_unmount ${OVL_BASE_SCRATCH_MNT}/lowermnt
>
>  # success, all done
>  echo "Silence is golden"
> diff --git a/tests/overlay/014 b/tests/overlay/014
> index f07fc6855..aeb1467a7 100755
> --- a/tests/overlay/014
> +++ b/tests/overlay/014
> @@ -46,7 +46,7 @@ _overlay_scratch_mount_dirs $lowerdir1 $lowerdir2 $work=
dir2
>  rm -rf $SCRATCH_MNT/testdir
>  mkdir -p $SCRATCH_MNT/testdir/visibledir
>  # unmount overlayfs but not base fs
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # check overlayfs
>  _overlay_check_scratch_dirs $lowerdir1 $lowerdir2 $workdir2
> @@ -59,7 +59,7 @@ touch $SCRATCH_MNT/testdir/visiblefile
>
>  # umount and mount overlay again, buggy kernel treats the copied-up dir =
as
>  # opaque, visibledir is not seen in merged dir.
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  _overlay_scratch_mount_dirs "$lowerdir2:$lowerdir1" $upperdir $workdir
>  ls $SCRATCH_MNT/testdir
>
> diff --git a/tests/overlay/022 b/tests/overlay/022
> index d33bd2978..8b26a2cd0 100755
> --- a/tests/overlay/022
> +++ b/tests/overlay/022
> @@ -17,7 +17,7 @@ _begin_fstest auto quick mount nested
>  _cleanup()
>  {
>         cd /
> -       $UMOUNT_PROG $tmp/mnt > /dev/null 2>&1
> +       _unmount $tmp/mnt > /dev/null 2>&1
>         rm -rf $tmp
>         rm -f $tmp.*
>  }
> diff --git a/tests/overlay/025 b/tests/overlay/025
> index dc819a393..3b6cf987b 100755
> --- a/tests/overlay/025
> +++ b/tests/overlay/025
> @@ -19,8 +19,8 @@ _begin_fstest auto quick attr
>  _cleanup()
>  {
>         cd /
> -       $UMOUNT_PROG $tmpfsdir/mnt
> -       $UMOUNT_PROG $tmpfsdir
> +       _unmount $tmpfsdir/mnt
> +       _unmount $tmpfsdir
>         rm -rf $tmpfsdir
>         rm -f $tmp.*
>  }
> diff --git a/tests/overlay/029 b/tests/overlay/029
> index 4bade9a0e..b0ed7285f 100755
> --- a/tests/overlay/029
> +++ b/tests/overlay/029
> @@ -22,7 +22,7 @@ _begin_fstest auto quick nested
>  _cleanup()
>  {
>         cd /
> -       $UMOUNT_PROG $tmp/mnt
> +       _unmount $tmp/mnt
>         rm -rf $tmp
>         rm -f $tmp.*
>  }
> @@ -56,7 +56,7 @@ _overlay_mount_dirs $SCRATCH_MNT/up $tmp/{upper,work} \
>    overlay $tmp/mnt
>  # accessing file in the second mount
>  cat $tmp/mnt/foo
> -$UMOUNT_PROG $tmp/mnt
> +_unmount $tmp/mnt
>
>  # re-create upper/work to avoid ovl_verify_origin() mount failure
>  # when index is enabled
> @@ -66,7 +66,7 @@ mkdir -p $tmp/{upper,work}
>  _overlay_mount_dirs $SCRATCH_MNT/low $tmp/{upper,work} \
>    overlay $tmp/mnt
>  cat $tmp/mnt/bar
> -$UMOUNT_PROG $tmp/mnt
> +_unmount $tmp/mnt
>
>  rm -rf $tmp/{upper,work}
>  mkdir -p $tmp/{upper,work}
> diff --git a/tests/overlay/031 b/tests/overlay/031
> index dd9dfcdb9..88299ebe2 100755
> --- a/tests/overlay/031
> +++ b/tests/overlay/031
> @@ -28,7 +28,7 @@ create_whiteout()
>
>         rm -f $SCRATCH_MNT/testdir/$file
>
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  # Import common functions.
> @@ -68,7 +68,7 @@ rm -rf $SCRATCH_MNT/testdir 2>&1 | _filter_scratch
>
>  # umount overlay again, create a new file with the same name and
>  # mount overlay again.
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  touch $lowerdir1/testdir
>
>  _overlay_scratch_mount_dirs $lowerdir1 $upperdir $workdir
> @@ -77,7 +77,7 @@ _overlay_scratch_mount_dirs $lowerdir1 $upperdir $workd=
ir
>  # it will not clean up the dir and lead to residue.
>  rm -rf $SCRATCH_MNT/testdir 2>&1 | _filter_scratch
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # let lower dir have invalid whiteouts, repeat ls and rmdir test again.
>  rm -rf $lowerdir1/testdir
> @@ -92,7 +92,7 @@ _overlay_scratch_mount_dirs "$lowerdir1:$lowerdir2" $up=
perdir $workdir
>  ls $SCRATCH_MNT/testdir
>  rm -rf $SCRATCH_MNT/testdir 2>&1 | _filter_scratch
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # let lower dir and upper dir both have invalid whiteouts, repeat ls and=
 rmdir again.
>  rm -rf $lowerdir1/testdir
> diff --git a/tests/overlay/035 b/tests/overlay/035
> index 0b3257c4c..14e62ca2e 100755
> --- a/tests/overlay/035
> +++ b/tests/overlay/035
> @@ -43,7 +43,7 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
>  _overlay_scratch_mount_opts -o"lowerdir=3D$lowerdir2:$lowerdir1"
>  touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
>  $MOUNT_PROG -o remount,rw $SCRATCH_MNT 2>&1 | _filter_ro_mount
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Make workdir immutable to prevent workdir re-create on mount
>  $CHATTR_PROG +i $workdir
> diff --git a/tests/overlay/036 b/tests/overlay/036
> index 19a181bbd..d94a86c49 100755
> --- a/tests/overlay/036
> +++ b/tests/overlay/036
> @@ -34,8 +34,8 @@ _cleanup()
>         cd /
>         rm -f $tmp.*
>         # unmount the two extra mounts in case they did not fail
> -       $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> -       $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +       _unmount $SCRATCH_MNT 2>/dev/null
> +       _unmount $SCRATCH_MNT 2>/dev/null
>  }
>
>  # Import common functions.
> @@ -66,13 +66,13 @@ _overlay_mount_dirs $lowerdir $upperdir $workdir \
>  # with index=3Doff - expect success
>  _overlay_mount_dirs $lowerdir $upperdir $workdir2 \
>                     overlay0 $SCRATCH_MNT -oindex=3Doff && \
> -                   $UMOUNT_PROG $SCRATCH_MNT
> +                   _unmount $SCRATCH_MNT
>
>  # Try to mount another overlay with the same workdir
>  # with index=3Doff - expect success
>  _overlay_mount_dirs $lowerdir2 $upperdir2 $workdir \
>                     overlay1 $SCRATCH_MNT -oindex=3Doff && \
> -                   $UMOUNT_PROG $SCRATCH_MNT
> +                   _unmount $SCRATCH_MNT
>
>  # Try to mount another overlay with the same upperdir
>  # with index=3Don - expect EBUSY
> diff --git a/tests/overlay/037 b/tests/overlay/037
> index 834e17638..70aecb065 100755
> --- a/tests/overlay/037
> +++ b/tests/overlay/037
> @@ -39,17 +39,17 @@ mkdir -p $lowerdir $lowerdir2 $upperdir $upperdir2 $w=
orkdir
>  # Mount overlay with lowerdir, upperdir, workdir and index=3Don
>  # to store the file handles of lowerdir and upperdir in overlay.origin x=
attr
>  _overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -oindex=3Don
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Try to mount an overlay with the same upperdir and different lowerdir =
- expect ESTALE
>  _overlay_scratch_mount_dirs $lowerdir2 $upperdir $workdir -oindex=3Don \
>         2>&1 | _filter_error_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  # Try to mount an overlay with the same workdir and different upperdir -=
 expect ESTALE
>  _overlay_scratch_mount_dirs $lowerdir $upperdir2 $workdir -oindex=3Don \
>         2>&1 | _filter_error_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  # Mount overlay with original lowerdir, upperdir, workdir and index=3Don=
 - expect success
>  _overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -oindex=3Don
> diff --git a/tests/overlay/040 b/tests/overlay/040
> index 11c7bf129..aeb4cdc93 100755
> --- a/tests/overlay/040
> +++ b/tests/overlay/040
> @@ -48,7 +48,7 @@ _scratch_mount
>  # modify lower origin file.
>  $CHATTR_PROG +i $SCRATCH_MNT/foo > /dev/null 2>&1
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # touching origin file in lower, should succeed
>  touch $lowerdir/foo
> diff --git a/tests/overlay/041 b/tests/overlay/041
> index 36491b8fa..3517d3652 100755
> --- a/tests/overlay/041
> +++ b/tests/overlay/041
> @@ -142,7 +142,7 @@ subdir_d=3D$($here/src/t_dir_type $pure_lower_dir $pu=
re_lower_subdir_st_ino)
>  [[ $subdir_d =3D=3D "subdir d" ]] || \
>         echo "Merged dir: Invalid d_ino reported for subdir"
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # check overlayfs
>  _overlay_check_scratch_dirs $lowerdir $upperdir $workdir -o xino=3Don
> diff --git a/tests/overlay/042 b/tests/overlay/042
> index aaa10da33..538b87ef9 100755
> --- a/tests/overlay/042
> +++ b/tests/overlay/042
> @@ -45,7 +45,7 @@ _scratch_mount -o index=3Doff
>  # Copy up lower and create upper hardlink with no index
>  ln $SCRATCH_MNT/0 $SCRATCH_MNT/1
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Add lower hardlinks while overlay is offline
>  ln $lowerdir/0 $lowerdir/2
> diff --git a/tests/overlay/043 b/tests/overlay/043
> index 7325c653a..1683738d7 100755
> --- a/tests/overlay/043
> +++ b/tests/overlay/043
> @@ -126,7 +126,7 @@ echo 3 > /proc/sys/vm/drop_caches
>  check_inode_numbers $testdir $tmp.after_copyup $tmp.after_move
>
>  # Verify that the inode numbers survive a mount cycle
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  _overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o redirect_dir=
=3Don,xino=3Don
>
>  # Compare inode numbers before/after mount cycle
> diff --git a/tests/overlay/044 b/tests/overlay/044
> index 4d04d883e..e19613c1c 100755
> --- a/tests/overlay/044
> +++ b/tests/overlay/044
> @@ -99,7 +99,7 @@ cat $FILES
>  check_ino_nlink $SCRATCH_MNT $tmp.before $tmp.after_one
>
>  # Verify that the hardlinks survive a mount cycle
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  _overlay_check_scratch_dirs $lowerdir $upperdir $workdir -o index=3Don,x=
ino=3Don
>  _overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o index=3Don,x=
ino=3Don
>
> diff --git a/tests/overlay/048 b/tests/overlay/048
> index 897e797e2..3de1fa795 100755
> --- a/tests/overlay/048
> +++ b/tests/overlay/048
> @@ -32,7 +32,7 @@ report_nlink()
>                 _ls_l $SCRATCH_MNT/$f | awk '{ print $2, $9 }' | _filter_=
scratch
>         done
>
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  # Create lower hardlinks
> @@ -101,7 +101,7 @@ touch $SCRATCH_MNT/1
>  touch $SCRATCH_MNT/2
>
>  # Perform the rest of the changes offline
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  test_hardlinks_offline
>
> diff --git a/tests/overlay/049 b/tests/overlay/049
> index 3ee500c5d..c7f93cb93 100755
> --- a/tests/overlay/049
> +++ b/tests/overlay/049
> @@ -32,7 +32,7 @@ create_redirect()
>         touch $SCRATCH_MNT/origin/file
>         mv $SCRATCH_MNT/origin $SCRATCH_MNT/$redirect
>
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  # Import common functions.
> diff --git a/tests/overlay/050 b/tests/overlay/050
> index ec936e2a7..bff002286 100755
> --- a/tests/overlay/050
> +++ b/tests/overlay/050
> @@ -76,7 +76,7 @@ mount_dirs()
>  # Unmount the overlay without unmounting base fs
>  unmount_dirs()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  # Check non-stale file handles of lower/upper files and verify
> diff --git a/tests/overlay/051 b/tests/overlay/051
> index 9404dbbab..d99d19678 100755
> --- a/tests/overlay/051
> +++ b/tests/overlay/051
> @@ -28,7 +28,7 @@ _cleanup()
>         # Cleanup overlay scratch mount that is holding base test mount
>         # to prevent _check_test_fs and _test_umount from failing before
>         # _check_scratch_fs _scratch_umount
> -       $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +       _unmount $SCRATCH_MNT 2>/dev/null
>  }
>
>  # Import common functions.
> @@ -103,7 +103,7 @@ mount_dirs()
>  # underlying dirs
>  unmount_dirs()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>
>         _overlay_check_scratch_dirs $middle:$lower $upper $work \
>                                 -o "index=3Don,nfs_export=3Don"
> diff --git a/tests/overlay/052 b/tests/overlay/052
> index 37402067d..9b53cd78a 100755
> --- a/tests/overlay/052
> +++ b/tests/overlay/052
> @@ -73,7 +73,7 @@ mount_dirs()
>  # Unmount the overlay without unmounting base fs
>  unmount_dirs()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  # Check non-stale file handles of lower/upper moved files
> diff --git a/tests/overlay/053 b/tests/overlay/053
> index f7891aced..13a4873ee 100755
> --- a/tests/overlay/053
> +++ b/tests/overlay/053
> @@ -30,7 +30,7 @@ _cleanup()
>         # Cleanup overlay scratch mount that is holding base test mount
>         # to prevent _check_test_fs and _test_umount from failing before
>         # _check_scratch_fs _scratch_umount
> -       $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +       _unmount $SCRATCH_MNT 2>/dev/null
>  }
>
>  # Import common functions.
> @@ -99,7 +99,7 @@ mount_dirs()
>  # underlying dirs
>  unmount_dirs()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>
>         _overlay_check_scratch_dirs $middle:$lower $upper $work \
>                                 -o "index=3Don,nfs_export=3Don,redirect_d=
ir=3Don"
> diff --git a/tests/overlay/054 b/tests/overlay/054
> index 8d7f026a2..260c95d50 100755
> --- a/tests/overlay/054
> +++ b/tests/overlay/054
> @@ -87,7 +87,7 @@ mount_dirs()
>  # Unmount the overlay without unmounting base fs
>  unmount_dirs()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  # Check encode/decode/read file handles of dir with non-indexed ancestor
> diff --git a/tests/overlay/055 b/tests/overlay/055
> index 87a348c94..84ce631f0 100755
> --- a/tests/overlay/055
> +++ b/tests/overlay/055
> @@ -37,7 +37,7 @@ _cleanup()
>         # Cleanup overlay scratch mount that is holding base test mount
>         # to prevent _check_test_fs and _test_umount from failing before
>         # _check_scratch_fs _scratch_umount
> -       $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +       _unmount $SCRATCH_MNT 2>/dev/null
>  }
>
>  # Import common functions.
> @@ -109,7 +109,7 @@ mount_dirs()
>  # underlying dirs
>  unmount_dirs()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>
>         _overlay_check_scratch_dirs $middle:$lower $upper $work \
>                                 -o "index=3Don,nfs_export=3Don,redirect_d=
ir=3Don"
> diff --git a/tests/overlay/056 b/tests/overlay/056
> index 158f34d05..72da81fe0 100755
> --- a/tests/overlay/056
> +++ b/tests/overlay/056
> @@ -73,7 +73,7 @@ mkdir $lowerdir/testdir2/subdir
>  _overlay_scratch_mount_dirs $lowerdir $upperdir $workdir
>  touch $SCRATCH_MNT/testdir1/foo
>  touch $SCRATCH_MNT/testdir2/subdir
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  remove_impure $upperdir/testdir1
>  remove_impure $upperdir/testdir2
>
> diff --git a/tests/overlay/057 b/tests/overlay/057
> index da7ffda30..325675d54 100755
> --- a/tests/overlay/057
> +++ b/tests/overlay/057
> @@ -48,7 +48,7 @@ _overlay_scratch_mount_dirs $lowerdir $lowerdir2 $workd=
ir2 -o redirect_dir=3Don
>  # Create opaque parent with absolute redirect child in middle layer
>  mkdir $SCRATCH_MNT/pure
>  mv $SCRATCH_MNT/origin $SCRATCH_MNT/pure/redirect
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  _overlay_scratch_mount_dirs $lowerdir2:$lowerdir $upperdir $workdir -o r=
edirect_dir=3Don
>  mv $SCRATCH_MNT/pure/redirect $SCRATCH_MNT/redirect
>  # List content of renamed merge dir before mount cycle
> @@ -56,7 +56,7 @@ ls $SCRATCH_MNT/redirect/
>
>  # Verify that redirects are followed by listing content of renamed merge=
 dir
>  # after mount cycle
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  _overlay_scratch_mount_dirs $lowerdir2:$lowerdir $upperdir $workdir -o r=
edirect_dir=3Don
>  ls $SCRATCH_MNT/redirect/
>
> diff --git a/tests/overlay/059 b/tests/overlay/059
> index c48d2a82c..9b9263c09 100755
> --- a/tests/overlay/059
> +++ b/tests/overlay/059
> @@ -33,7 +33,7 @@ create_origin_ref()
>         _scratch_mount -o redirect_dir=3Don
>         mv $SCRATCH_MNT/origin $SCRATCH_MNT/$ref
>
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  # Import common functions.
> diff --git a/tests/overlay/060 b/tests/overlay/060
> index bb61fcfa6..05dab179d 100755
> --- a/tests/overlay/060
> +++ b/tests/overlay/060
> @@ -130,7 +130,7 @@ mount_ro_overlay()
>
>  umount_overlay()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  # Assumes it is called with overlay mounted.
> diff --git a/tests/overlay/062 b/tests/overlay/062
> index e44628b74..4290fbc85 100755
> --- a/tests/overlay/062
> +++ b/tests/overlay/062
> @@ -18,7 +18,7 @@ _cleanup()
>  {
>         cd /
>         rm -f $tmp.*
> -       $UMOUNT_PROG $lowertestdir
> +       _unmount $lowertestdir
>  }
>
>  # Import common functions.
> diff --git a/tests/overlay/063 b/tests/overlay/063
> index d9f30606a..b0468cd58 100755
> --- a/tests/overlay/063
> +++ b/tests/overlay/063
> @@ -40,7 +40,7 @@ rm ${upperdir}/file
>  mkdir ${SCRATCH_MNT}/file > /dev/null 2>&1
>
>  # unmount overlayfs
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  echo "Silence is golden"
>  # success, all done
> diff --git a/tests/overlay/065 b/tests/overlay/065
> index fb6d6dd1b..08ada3242 100755
> --- a/tests/overlay/065
> +++ b/tests/overlay/065
> @@ -30,7 +30,7 @@ _cleanup()
>  {
>         cd /
>         rm -f $tmp.*
> -       $UMOUNT_PROG $mnt2 2>/dev/null
> +       _unmount $mnt2 2>/dev/null
>  }
>
>  # Import common functions.
> @@ -63,7 +63,7 @@ mkdir -p $lowerdir/lower $upperdir $workdir
>  echo Conflicting upperdir/lowerdir
>  _overlay_scratch_mount_dirs $upperdir $upperdir $workdir \
>         2>&1 | _filter_error_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  # Use new upper/work dirs for each test to avoid ESTALE errors
>  # on mismatch lowerdir/upperdir (see test overlay/037)
> @@ -75,7 +75,7 @@ mkdir $upperdir $workdir
>  echo Conflicting workdir/lowerdir
>  _overlay_scratch_mount_dirs $workdir $upperdir $workdir \
>         -oindex=3Doff 2>&1 | _filter_error_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  rm -rf $upperdir $workdir
>  mkdir -p $upperdir/lower $workdir
> @@ -85,7 +85,7 @@ mkdir -p $upperdir/lower $workdir
>  echo Overlapping upperdir/lowerdir
>  _overlay_scratch_mount_dirs $upperdir/lower $upperdir $workdir \
>         2>&1 | _filter_error_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  rm -rf $upperdir $workdir
>  mkdir $upperdir $workdir
> @@ -94,7 +94,7 @@ mkdir $upperdir $workdir
>  echo Conflicting lower layers
>  _overlay_scratch_mount_dirs $lowerdir:$lowerdir $upperdir $workdir \
>         2>&1 | _filter_error_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  rm -rf $upperdir $workdir
>  mkdir $upperdir $workdir
> @@ -103,7 +103,7 @@ mkdir $upperdir $workdir
>  echo Overlapping lower layers below
>  _overlay_scratch_mount_dirs $lowerdir:$lowerdir/lower $upperdir $workdir=
 \
>         2>&1 | _filter_error_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  rm -rf $upperdir $workdir
>  mkdir $upperdir $workdir
> @@ -112,7 +112,7 @@ mkdir $upperdir $workdir
>  echo Overlapping lower layers above
>  _overlay_scratch_mount_dirs $lowerdir/lower:$lowerdir $upperdir $workdir=
 \
>         2>&1 | _filter_error_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  rm -rf $upperdir $workdir
>  mkdir -p $upperdir/upper $workdir $mnt2
> @@ -129,14 +129,14 @@ mkdir -p $upperdir2 $workdir2 $mnt2
>  echo "Overlapping with upperdir of another instance (index=3Don)"
>  _overlay_scratch_mount_dirs $upperdir/upper $upperdir2 $workdir2 \
>         -oindex=3Don 2>&1 | _filter_busy_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  rm -rf $upperdir2 $workdir2
>  mkdir -p $upperdir2 $workdir2
>
>  echo "Overlapping with upperdir of another instance (index=3Doff)"
>  _overlay_scratch_mount_dirs $upperdir/upper $upperdir2 $workdir2 \
> -       -oindex=3Doff && $UMOUNT_PROG $SCRATCH_MNT
> +       -oindex=3Doff && _unmount $SCRATCH_MNT
>
>  rm -rf $upperdir2 $workdir2
>  mkdir -p $upperdir2 $workdir2
> @@ -146,14 +146,14 @@ mkdir -p $upperdir2 $workdir2
>  echo "Overlapping with workdir of another instance (index=3Don)"
>  _overlay_scratch_mount_dirs $workdir/work $upperdir2 $workdir2 \
>         -oindex=3Don 2>&1 | _filter_busy_mount
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  rm -rf $upperdir2 $workdir2
>  mkdir -p $upperdir2 $workdir2
>
>  echo "Overlapping with workdir of another instance (index=3Doff)"
>  _overlay_scratch_mount_dirs $workdir/work $upperdir2 $workdir2 \
> -       -oindex=3Doff && $UMOUNT_PROG $SCRATCH_MNT
> +       -oindex=3Doff && _unmount $SCRATCH_MNT
>
>  # Move upper layer root into lower layer after mount
>  echo Overlapping upperdir/lowerdir after mount
> diff --git a/tests/overlay/067 b/tests/overlay/067
> index bb09a6042..4b57675e2 100755
> --- a/tests/overlay/067
> +++ b/tests/overlay/067
> @@ -70,7 +70,7 @@ stat $testfile >>$seqres.full
>  diff -q $realfile $testfile >>$seqres.full &&
>         echo "diff with middle layer file doesn't know right from wrong! =
(cold cache)"
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  # check overlayfs
>  _overlay_check_scratch_dirs $middle:$lower $upper $work -o xino=3Doff
>
> diff --git a/tests/overlay/068 b/tests/overlay/068
> index 0d33cf12d..66b1b49ca 100755
> --- a/tests/overlay/068
> +++ b/tests/overlay/068
> @@ -28,7 +28,7 @@ _cleanup()
>         cd /
>         rm -f $tmp.*
>         # Unmount the nested overlay mount
> -       $UMOUNT_PROG $mnt2 2>/dev/null
> +       _unmount $mnt2 2>/dev/null
>  }
>
>  # Import common functions.
> @@ -100,7 +100,7 @@ mount_dirs()
>  unmount_dirs()
>  {
>         # unmount & check nested overlay
> -       $UMOUNT_PROG $mnt2
> +       _unmount $mnt2
>         _overlay_check_dirs $SCRATCH_MNT $upper2 $work2 \
>                 -o "index=3Don,nfs_export=3Don,redirect_dir=3Don"
>
> diff --git a/tests/overlay/069 b/tests/overlay/069
> index 373ab1ee3..b145ad8e2 100755
> --- a/tests/overlay/069
> +++ b/tests/overlay/069
> @@ -28,7 +28,7 @@ _cleanup()
>         cd /
>         rm -f $tmp.*
>         # Unmount the nested overlay mount
> -       $UMOUNT_PROG $mnt2 2>/dev/null
> +       _unmount $mnt2 2>/dev/null
>  }
>
>  # Import common functions.
> @@ -108,12 +108,12 @@ mount_dirs()
>  unmount_dirs()
>  {
>         # unmount & check nested overlay
> -       $UMOUNT_PROG $mnt2
> +       _unmount $mnt2
>         _overlay_check_dirs $SCRATCH_MNT $upper2 $work2 \
>                 -o "index=3Don,nfs_export=3Don,redirect_dir=3Don"
>
>         # unmount & check underlying overlay
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>         _overlay_check_dirs $lower $upper $work \
>                 -o "index=3Don,nfs_export=3Don,redirect_dir=3Don"
>  }
> diff --git a/tests/overlay/070 b/tests/overlay/070
> index 36991229f..078dda417 100755
> --- a/tests/overlay/070
> +++ b/tests/overlay/070
> @@ -26,7 +26,7 @@ _cleanup()
>         cd /
>         rm -f $tmp.*
>         # Unmount the nested overlay mount
> -       $UMOUNT_PROG $mnt2 2>/dev/null
> +       _unmount $mnt2 2>/dev/null
>         [ -z "$loopdev" ] || _destroy_loop_device $loopdev
>  }
>
> @@ -93,12 +93,12 @@ mount_dirs()
>  unmount_dirs()
>  {
>         # unmount & check nested overlay
> -       $UMOUNT_PROG $mnt2
> +       _unmount $mnt2
>         _overlay_check_dirs $SCRATCH_MNT $upper2 $work2 \
>                 -o "redirect_dir=3Don,index=3Don,xino=3Don"
>
>         # unmount & check underlying overlay
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>         _overlay_check_scratch_dirs $lower $upper $work \
>                 -o "index=3Don,nfs_export=3Don"
>  }
> diff --git a/tests/overlay/071 b/tests/overlay/071
> index 2a6313142..1954d0cb1 100755
> --- a/tests/overlay/071
> +++ b/tests/overlay/071
> @@ -29,7 +29,7 @@ _cleanup()
>         cd /
>         rm -f $tmp.*
>         # Unmount the nested overlay mount
> -       $UMOUNT_PROG $mnt2 2>/dev/null
> +       _unmount $mnt2 2>/dev/null
>         [ -z "$loopdev" ] || _destroy_loop_device $loopdev
>  }
>
> @@ -103,12 +103,12 @@ mount_dirs()
>  unmount_dirs()
>  {
>         # unmount & check nested overlay
> -       $UMOUNT_PROG $mnt2
> +       _unmount $mnt2
>         _overlay_check_dirs $SCRATCH_MNT $upper2 $work2 \
>                 -o "redirect_dir=3Don,index=3Don,xino=3Don"
>
>         # unmount & check underlying overlay
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>         _overlay_check_dirs $lower $upper $work \
>                 -o "index=3Don,nfs_export=3Don"
>  }
> diff --git a/tests/overlay/076 b/tests/overlay/076
> index fb94dff68..a137ac803 100755
> --- a/tests/overlay/076
> +++ b/tests/overlay/076
> @@ -47,7 +47,7 @@ _scratch_mount
>  # on kernel v5.10..v5.10.14.  Anything but hang is considered a test suc=
cess.
>  $CHATTR_PROG +i $SCRATCH_MNT/foo > /dev/null 2>&1
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # success, all done
>  echo "Silence is golden"
> diff --git a/tests/overlay/077 b/tests/overlay/077
> index 00de0825a..a322709e8 100755
> --- a/tests/overlay/077
> +++ b/tests/overlay/077
> @@ -65,7 +65,7 @@ mv $SCRATCH_MNT/f100 $SCRATCH_MNT/former/
>
>  # Remove the lower directory and mount overlay again to create
>  # a "former merge dir"
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  rm -rf $lowerdir/former
>  _scratch_mount
>
> diff --git a/tests/overlay/078 b/tests/overlay/078
> index d6df11f68..0ee9e54d9 100755
> --- a/tests/overlay/078
> +++ b/tests/overlay/078
> @@ -61,7 +61,7 @@ do_check()
>
>         echo "Test chattr +$1 $2" >> $seqres.full
>
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>
>         # Add attribute to lower file
>         $CHATTR_PROG +$attr $lowertestfile
> diff --git a/tests/overlay/079 b/tests/overlay/079
> index cfcafceea..2ea9ba93b 100755
> --- a/tests/overlay/079
> +++ b/tests/overlay/079
> @@ -156,7 +156,7 @@ mount_ro_overlay()
>
>  umount_overlay()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  test_no_access()
> diff --git a/tests/overlay/080 b/tests/overlay/080
> index ce5c2375f..77fd8dbfe 100755
> --- a/tests/overlay/080
> +++ b/tests/overlay/080
> @@ -264,7 +264,7 @@ mount_overlay()
>
>  umount_overlay()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>
> diff --git a/tests/overlay/081 b/tests/overlay/081
> index 2270a0475..39eac6466 100755
> --- a/tests/overlay/081
> +++ b/tests/overlay/081
> @@ -46,7 +46,7 @@ ovl_fsid=3D$(stat -f -c '%i' $test_dir)
>         echo "Overlayfs (uuid=3Dnull) and upper fs fsid differ"
>
>  # Keep base fs mounted in case it has a volatile fsid (e.g. tmpfs)
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Test legacy behavior is preserved by default for existing "impure" ove=
rlayfs
>  _scratch_mount
> @@ -55,7 +55,7 @@ ovl_fsid=3D$(stat -f -c '%i' $test_dir)
>  [[ "$ovl_fsid" =3D=3D "$upper_fsid" ]] || \
>         echo "Overlayfs (after uuid=3Dnull) and upper fs fsid differ"
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Test unique fsid on explicit opt-in for existing "impure" overlayfs
>  _scratch_mount -o uuid=3Don
> @@ -65,7 +65,7 @@ ovl_unique_fsid=3D$ovl_fsid
>  [[ "$ovl_fsid" !=3D "$upper_fsid" ]] || \
>         echo "Overlayfs (uuid=3Don) and upper fs fsid are the same"
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Test unique fsid is persistent by default after it was created
>  _scratch_mount
> @@ -74,7 +74,7 @@ ovl_fsid=3D$(stat -f -c '%i' $test_dir)
>  [[ "$ovl_fsid" =3D=3D "$ovl_unique_fsid" ]] || \
>         echo "Overlayfs (after uuid=3Don) unique fsid is not persistent"
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Test ignore existing persistent fsid on explicit opt-out
>  _scratch_mount -o uuid=3Dnull
> @@ -83,7 +83,7 @@ ovl_fsid=3D$(stat -f -c '%i' $test_dir)
>  [[ "$ovl_fsid" =3D=3D "$upper_fsid" ]] || \
>         echo "Overlayfs (uuid=3Dnull) and upper fs fsid differ"
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Test fallback to uuid=3Dnull with non-upper ovelray
>  _overlay_scratch_mount_dirs "$upperdir:$lowerdir" "-" "-" -o ro,uuid=3Do=
n
> @@ -110,7 +110,7 @@ ovl_unique_fsid=3D$ovl_fsid
>  [[ "$ovl_fsid" !=3D "$upper_fsid" ]] || \
>         echo "Overlayfs (new) and upper fs fsid are the same"
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  # Test unique fsid is persistent by default after it was created
>  _scratch_mount -o uuid=3Don
> @@ -119,7 +119,7 @@ ovl_fsid=3D$(stat -f -c '%i' $test_dir)
>  [[ "$ovl_fsid" =3D=3D "$ovl_unique_fsid" ]] || \
>         echo "Overlayfs (uuid=3Don) unique fsid is not persistent"
>
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>
>  echo "Silence is golden"
>  status=3D0
> diff --git a/tests/overlay/083 b/tests/overlay/083
> index d037d4c85..551471d45 100755
> --- a/tests/overlay/083
> +++ b/tests/overlay/083
> @@ -52,7 +52,7 @@ $MOUNT_PROG -t overlay | grep ovl_esc_test  | tee -a $s=
eqres.full | grep -v spac
>
>  # Re-create the upper/work dirs to mount them with a different lower
>  # This is required in case index feature is enabled
> -$UMOUNT_PROG $SCRATCH_MNT
> +_unmount $SCRATCH_MNT
>  rm -rf "$upperdir" "$workdir"
>  mkdir -p "$upperdir" "$workdir"
>
> diff --git a/tests/overlay/084 b/tests/overlay/084
> index 28e9a76dc..d0bf06ecb 100755
> --- a/tests/overlay/084
> +++ b/tests/overlay/084
> @@ -15,7 +15,7 @@ _cleanup()
>  {
>         cd /
>         # Unmount nested mounts if things fail
> -       $UMOUNT_PROG $OVL_BASE_SCRATCH_MNT/nested  2>/dev/null
> +       _unmount $OVL_BASE_SCRATCH_MNT/nested  2>/dev/null
>         rm -rf $tmp
>  }
>
> @@ -44,7 +44,7 @@ nesteddir=3D$OVL_BASE_SCRATCH_MNT/nested
>
>  umount_overlay()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  test_escape()
> @@ -88,12 +88,12 @@ test_escape()
>         echo "nested xattr mount with trusted.overlay"
>         _overlay_mount_dirs $SCRATCH_MNT/layer2:$SCRATCH_MNT/layer1 - - o=
verlayfs $nesteddir
>         stat $nesteddir/dir/file  2>&1 | _filter_scratch
> -       $UMOUNT_PROG $nesteddir
> +       _unmount $nesteddir
>
>         echo "nested xattr mount with user.overlay"
>         _overlay_mount_dirs $SCRATCH_MNT/layer2:$SCRATCH_MNT/layer1 - - -=
o userxattr overlayfs $nesteddir
>         stat $nesteddir/dir/file  2>&1 | _filter_scratch
> -       $UMOUNT_PROG $nesteddir
> +       _unmount $nesteddir
>
>         # Also ensure propagate the escaped xattr when we copy-up layer2/=
dir
>         echo "copy-up of escaped xattrs"
> @@ -164,7 +164,7 @@ test_escaped_xwhiteout()
>
>         do_test_xwhiteout $prefix $nesteddir
>
> -       $UMOUNT_PROG $nesteddir
> +       _unmount $nesteddir
>  }
>
>  test_escaped_xwhiteout trusted
> diff --git a/tests/overlay/085 b/tests/overlay/085
> index 046d01d16..95665fba8 100755
> --- a/tests/overlay/085
> +++ b/tests/overlay/085
> @@ -157,7 +157,7 @@ mount_ro_overlay()
>
>  umount_overlay()
>  {
> -       $UMOUNT_PROG $SCRATCH_MNT
> +       _unmount $SCRATCH_MNT
>  }
>
>  test_no_access()
> diff --git a/tests/overlay/086 b/tests/overlay/086
> index 9c8a00588..d0b2a76ca 100755
> --- a/tests/overlay/086
> +++ b/tests/overlay/086
> @@ -38,21 +38,21 @@ $MOUNT_PROG -t overlay none $SCRATCH_MNT \
>         2>> $seqres.full && \
>         echo "ERROR: invalid combination of lowerdir and lowerdir+ mount =
options"
>
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  $MOUNT_PROG -t overlay none $SCRATCH_MNT \
>         -o"lowerdir=3D$lowerdir,datadir+=3D$lowerdir_colons" \
>         -o redirect_dir=3Dfollow,metacopy=3Don 2>> $seqres.full && \
>         echo "ERROR: invalid combination of lowerdir and datadir+ mount o=
ptions"
>
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  $MOUNT_PROG -t overlay none $SCRATCH_MNT \
>         -o"datadir+=3D$lowerdir,lowerdir+=3D$lowerdir_colons" \
>         -o redirect_dir=3Dfollow,metacopy=3Don 2>> $seqres.full && \
>         echo "ERROR: invalid order of lowerdir+ and datadir+ mount option=
s"
>
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  # mount is expected to fail with escaped colons.
>  $MOUNT_PROG -t overlay none $SCRATCH_MNT \
> @@ -60,7 +60,7 @@ $MOUNT_PROG -t overlay none $SCRATCH_MNT \
>         2>> $seqres.full && \
>         echo "ERROR: incorrect parsing of escaped colons in lowerdir+ mou=
nt option"
>
> -$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
> +_unmount $SCRATCH_MNT 2>/dev/null
>
>  # mount is expected to succeed without escaped colons.
>  $MOUNT_PROG -t overlay ovl_esc_test $SCRATCH_MNT \

