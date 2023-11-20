Return-Path: <linux-btrfs+bounces-203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A35B7F1D7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 20:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745911C21835
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAAF36B11;
	Mon, 20 Nov 2023 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuFhzRw7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D7358AB;
	Mon, 20 Nov 2023 19:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A3BC433C8;
	Mon, 20 Nov 2023 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700509540;
	bh=qzthE/euQv92ve+qR1oTetru0oXTE0Py74tr27iFzGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IuFhzRw7QrG3FO89PyYBy9fTOqQ+3VVTx57pc7a3XASjrSO+FqqedaMRMsx+pERbQ
	 GqykPXL5DV+T5BZeWDFNvU+QhmHynUxwTNd/0fSi0GZ6EMIblYqbhRR+Ne23cC53rr
	 b52SghpbTuZwM9A8YHfBiXBJllDejNcVT0cRQiQAtoTvHd+opIJMNq2z7QwLBwX981
	 U0wHKF25Vew7IFCsnfWLCAKlLISb13xiZ0Y4Lnnw7s5XY173zP1Pb1XyUThZWThPn0
	 WF50EUx/o6jie9KAJl0TwjyHFOi5QpJbI8Yfv8qSEj+ju09GHd03F4wKPSzwMnVvXV
	 gRSos3q3ZDmrg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c72e275d96so59729881fa.2;
        Mon, 20 Nov 2023 11:45:40 -0800 (PST)
X-Gm-Message-State: AOJu0YzJSapFJ8AtaA5DZMjS8v0/qpvMjvka9eIbOjnTk5HJ2QYuhkko
	Hvn2Yl+bBd7W7c2+tKDlOo4rMolDuHSDNgtYlHE=
X-Google-Smtp-Source: AGHT+IE1KwQqphDesp1yT2doYEoZ9wDk7aFtvCuyJtQFaa9Z+bufip6GZVkecGnz+yOd1WDxcHhT8k5Lxk3VcAASraQ=
X-Received: by 2002:a2e:b80f:0:b0:2c6:f2c1:a22e with SMTP id
 u15-20020a2eb80f000000b002c6f2c1a22emr5717507ljo.34.1700509538682; Mon, 20
 Nov 2023 11:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700505679.git.boris@bur.io> <da0104f52b8253be8b905f77ce467acaf6afc9cd.1700505679.git.boris@bur.io>
In-Reply-To: <da0104f52b8253be8b905f77ce467acaf6afc9cd.1700505679.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 Nov 2023 19:45:01 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5XcFeFFTYjm84y+uc_Jz2eUSzcfq9OyxX3cs=gv2UDfw@mail.gmail.com>
Message-ID: <CAL3q7H5XcFeFFTYjm84y+uc_Jz2eUSzcfq9OyxX3cs=gv2UDfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs/301: fix hardcoded subvolids
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 6:44=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> Hardcoded subvolids break noholes test runs, so change the test to use
> _btrfs_get_subvolid instead of assuming 256, 257, etc...

How exactly does no-holes affect the assigned IDs to subvolumes?
It's a default feature for quite a while and the test passes with it
and without it (-O ^no-holes).

Aren't you confusing this with enabling or disabling features that add
some tree?
Like disabling the free space tree (which is a default for quite a
while now), for example.

For me it fails with -O ^free-space-tree, and it fails even with this
patch applied:

$ MKFS_OPTIONS=3D"-O ^free-space-tree" ./check btrfs/301
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.6.0-rc5-btrfs-next-140+ #1 SMP
PREEMPT_DYNAMIC Thu Oct 19 16:55:42 WEST 2023
MKFS_OPTIONS  -- -O ^free-space-tree /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/301 70s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/301.out.bad)
    --- tests/btrfs/301.out 2023-10-18 23:29:06.029292800 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/301.out.bad
2023-11-20 19:33:04.988824928 +0000
    @@ -13,6 +13,16 @@
     fallocate: Disk quota exceeded
     pwrite: Disk quota exceeded
     enable mature
    +ERROR: unable to limit requested quota group: No such file or director=
y
    +/home/fdmanana/git/hub/xfstests/tests/btrfs/301: line 373: [:
-lt: unary operator expected
    +captured usage from before enable  >=3D 134217728
    +/home/fdmanana/git/hub/xfstests/tests/btrfs/301: line 377: [:
-lt: unary operator expected
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/301.out
/home/fdmanana/git/hub/xfstests/results//btrfs/301.out.bad'  to see
the entire diff)
Ran: btrfs/301
Failures: btrfs/301
Failed 1 of 1 tests

I see variables like subvid below being declared as global in one
function and then used in other functions.
Maybe there's something wrong with that... it would be cleaner to make
the variable local and pass the subvolume id as an argument to other
functions.

Thanks.

>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/btrfs/301 | 138 ++++++++++++++++++++++++------------------------
>  1 file changed, 70 insertions(+), 68 deletions(-)
>
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 7a0b4c0e1..5bb6b16a6 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -172,25 +172,27 @@ prepare()
>         _scratch_mount
>         enable_quota "s"
>         $BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
> -       set_subvol_limit 256 $limit
> -       check_subvol_usage 256 0
> +       subvid=3D$(_btrfs_get_subvolid $SCRATCH_MNT subv)
> +       set_subvol_limit $subvid $limit
> +       check_subvol_usage $subvid 0
>
>         # Create a bunch of little filler files to generate several level=
s in
>         # the btree, to make snapshotting sharing scenarios complex enoug=
h.
>         $FIO_PROG $prep_fio_config --output=3D$fio_out
> -       check_subvol_usage 256 $total_fill
> +       check_subvol_usage $subvid $total_fill
>
>         # Create a single file whose extents we will explicitly share/uns=
hare.
>         do_write $subv/f $ext_sz
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
>  }
>
>  prepare_snapshotted()
>  {
>         prepare
>         $BTRFS_UTIL_PROG subvolume snapshot $subv $snap >> $seqres.full
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       check_subvol_usage 257 0
> +       snapid=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap)

Make the variable local please.

> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       check_subvol_usage $snapid 0
>  }
>
>  prepare_nested()
> @@ -198,13 +200,13 @@ prepare_nested()
>         prepare
>         $BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
>         $BTRFS_UTIL_PROG qgroup limit $limit 1/100 $SCRATCH_MNT
> -       $BTRFS_UTIL_PROG qgroup assign 0/256 1/100 $SCRATCH_MNT >> $seqre=
s.full
> +       $BTRFS_UTIL_PROG qgroup assign 0/$subvid 1/100 $SCRATCH_MNT >> $s=
eqres.full
>         $BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
>         do_write $nested/f $ext_sz
> -       check_subvol_usage 257 $ext_sz
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       local subv_usage=3D$(get_subvol_usage 256)
> -       local nested_usage=3D$(get_subvol_usage 257)
> +       check_subvol_usage $snapid $ext_sz
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       local subv_usage=3D$(get_subvol_usage $subvid)
> +       local nested_usage=3D$(get_subvol_usage $snapid)
>         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
>  }
>
> @@ -214,8 +216,8 @@ basic_accounting()
>         echo "basic accounting"
>         prepare
>         rm $subv/f
> -       check_subvol_usage 256 $total_fill
> -       cycle_mount_check_subvol_usage 256 $total_fill
> +       check_subvol_usage $subvid $total_fill
> +       cycle_mount_check_subvol_usage $subvid $total_fill
>         do_write $subv/tmp 512M
>         rm $subv/tmp
>         do_write $subv/tmp 512M
> @@ -245,19 +247,19 @@ snapshot_accounting()
>         echo "snapshot accounting"
>         prepare_snapshotted
>         touch $snap/f
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       check_subvol_usage $snapid 0
>         do_write $snap/f $ext_sz
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       check_subvol_usage 257 $ext_sz
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       check_subvol_usage $snapid $ext_sz
>         rm $snap/f
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       check_subvol_usage $snapid 0
>         rm $subv/f
> -       check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> -       cycle_mount_check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid 0
> +       cycle_mount_check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid 0
>         _scratch_unmount
>  }
>
> @@ -267,14 +269,14 @@ delete_snapshot_src_ref()
>         echo "delete src ref first"
>         prepare_snapshotted
>         rm $subv/f
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       check_subvol_usage $snapid 0
>         rm $snap/f
>         trigger_cleaner
> -       check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> -       cycle_mount_check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid 0
> +       cycle_mount_check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid 0
>         _scratch_unmount
>  }
>
> @@ -284,13 +286,13 @@ delete_snapshot_ref()
>         echo "delete snapshot ref first"
>         prepare_snapshotted
>         rm $snap/f
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       check_subvol_usage $snapid 0
>         rm $subv/f
> -       check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> -       cycle_mount_check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid 0
> +       cycle_mount_check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid 0
>         _scratch_unmount
>  }
>
> @@ -300,18 +302,18 @@ delete_snapshot_src()
>         echo "delete snapshot src first"
>         prepare_snapshotted
>         $BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       check_subvol_usage $snapid 0
>         rm $snap/f
>         trigger_cleaner
> -       check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid 0
>         $BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
>         trigger_cleaner
> -       check_subvol_usage 256 0
> -       check_subvol_usage 257 0
> -       cycle_mount_check_subvol_usage 256 0
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid 0
> +       check_subvol_usage $snapid 0
> +       cycle_mount_check_subvol_usage $subvid 0
> +       check_subvol_usage $snapid 0
>         _scratch_unmount
>  }
>
> @@ -321,12 +323,12 @@ delete_snapshot()
>         echo "delete snapshot first"
>         prepare_snapshotted
>         $BTRFS_UTIL_PROG subvolume delete $snap >> $seqres.full
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       check_subvol_usage $snapid 0
>         $BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
>         trigger_cleaner
> -       check_subvol_usage 256 0
> -       check_subvol_usage 257 0
> +       check_subvol_usage $subvid 0
> +       check_subvol_usage $snapid 0
>         _scratch_unmount
>  }
>
> @@ -337,16 +339,16 @@ nested_accounting()
>         echo "nested accounting"
>         prepare_nested
>         rm $subv/f
> -       check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 $ext_sz
> -       local subv_usage=3D$(get_subvol_usage 256)
> -       local nested_usage=3D$(get_subvol_usage 257)
> +       check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid $ext_sz
> +       local subv_usage=3D$(get_subvol_usage $subvid)
> +       local nested_usage=3D$(get_subvol_usage $snapid)
>         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
>         rm $nested/f
> -       check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> -       subv_usage=3D$(get_subvol_usage 256)
> -       nested_usage=3D$(get_subvol_usage 257)
> +       check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $snapid 0
> +       subv_usage=3D$(get_subvol_usage $subvid)
> +       nested_usage=3D$(get_subvol_usage $snapid)
>         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
>         do_enospc_falloc $nested/large_falloc 2G
>         do_enospc_write $nested/large 2G
> @@ -365,21 +367,21 @@ enable_mature()
>         # we did before enabling.
>         sync
>         enable_quota "s"
> -       set_subvol_limit 256 $limit
> +       set_subvol_limit $subvid $limit
>         _scratch_cycle_mount
> -       usage=3D$(get_subvol_usage 256)
> +       usage=3D$(get_subvol_usage $subvid)
>         [ $usage -lt $ext_sz ] || \
>                 echo "captured usage from before enable $usage >=3D $ext_=
sz"
>         do_write $subv/g $ext_sz
> -       usage=3D$(get_subvol_usage 256)
> +       usage=3D$(get_subvol_usage $subvid)
>         [ $usage -lt $ext_sz ] && \
>                 echo "failed to capture usage after enable $usage < $ext_=
sz"
> -       check_subvol_usage 256 $ext_sz
> +       check_subvol_usage $subvid $ext_sz
>         rm $subv/f
> -       check_subvol_usage 256 $ext_sz
> +       check_subvol_usage $subvid $ext_sz
>         _scratch_cycle_mount
>         rm $subv/g
> -       check_subvol_usage 256 0
> +       check_subvol_usage $subvid 0
>         _scratch_unmount
>  }
>
> @@ -394,7 +396,7 @@ reflink_accounting()
>                 _cp_reflink $subv/f $subv/f.i
>         done
>         # Confirm that there is no additional data usage from the reflink=
s.
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
>         _scratch_unmount
>  }
>
> @@ -404,11 +406,11 @@ delete_reflink_src_ref()
>         echo "delete reflink src ref"
>         prepare
>         _cp_reflink $subv/f $subv/f.link
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
>         rm $subv/f
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
>         rm $subv/f.link
> -       check_subvol_usage 256 $(($total_fill))
> +       check_subvol_usage $subvid $(($total_fill))
>         _scratch_unmount
>  }
>
> @@ -418,11 +420,11 @@ delete_reflink_ref()
>         echo "delete reflink ref"
>         prepare
>         _cp_reflink $subv/f $subv/f.link
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
>         rm $subv/f.link
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
>         rm $subv/f
> -       check_subvol_usage 256 $(($total_fill))
> +       check_subvol_usage $subvid $(($total_fill))
>         _scratch_unmount
>  }
>
> --
> 2.42.0
>
>

