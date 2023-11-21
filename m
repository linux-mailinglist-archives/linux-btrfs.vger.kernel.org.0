Return-Path: <linux-btrfs+bounces-224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C27F2AFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3A11C20DCE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E68482C4;
	Tue, 21 Nov 2023 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObQWcOgY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE74316F;
	Tue, 21 Nov 2023 10:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EEEC433CB;
	Tue, 21 Nov 2023 10:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700563774;
	bh=+FX+RLuW0Hq/xpEYn9pTV5/h06hDb6n+QbLsBtepVeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ObQWcOgYdu3qK9bEuC/X63MtvO5DV1p/wem5XTuGhrddVSe4X4hRITgP2dA5IYLkO
	 XiZKOZk4swUvglX+g/IUniSIXTI/v0JUL0F8j3MYWG9ooP9ZpoQmdxyN9hrmRCtMlD
	 Vel/WEIRTZV63QMQJBi67d5jJiU+D17iwg0ddjydsMdhKahbSjzUQUgDIV1LZQN/JL
	 GX9wFbG07nB0QSoR4bdDSM1ua2F3BONEhbmUxfwpaxocyXgQ/chCkp/X+ozrkq+lmN
	 oUnYEi4ahOTyMnuytkipQepkLNF7isO3t6tncr+LO+iGeDIW975CBvpo/iXkYBHOPa
	 FrvdvZAV5tMaQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so7838196a12.0;
        Tue, 21 Nov 2023 02:49:34 -0800 (PST)
X-Gm-Message-State: AOJu0YxdtrWwpKCNSkOomF01iOuiqagl67gqOEwR0CjuyOBCxuC/VE8H
	bXdKwbsPcXJjZ0uA/XXa18hGscxm35gtCCmDZmo=
X-Google-Smtp-Source: AGHT+IEXukRV5LQ8p+aWHmHEDT/02Yd0OV24M8mQkYhiwrbsXDVfZ8CJcxz5NFq/q32+2vPHvfLF3N+s51+9pjbK+X0=
X-Received: by 2002:a17:907:7e8e:b0:a02:ac5c:775d with SMTP id
 qb14-20020a1709077e8e00b00a02ac5c775dmr759200ejc.6.1700563772514; Tue, 21 Nov
 2023 02:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700514431.git.boris@bur.io> <851c95b3f2a3786dc9b3ca9009ff4b12e93d70d5.1700514431.git.boris@bur.io>
In-Reply-To: <851c95b3f2a3786dc9b3ca9009ff4b12e93d70d5.1700514431.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 21 Nov 2023 10:48:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6ofj51mSmDuU=gJH=UVwubVDpgTRdZUkf5B=xxRx03mw@mail.gmail.com>
Message-ID: <CAL3q7H6ofj51mSmDuU=gJH=UVwubVDpgTRdZUkf5B=xxRx03mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs/301: fix hardcoded subvolids
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 9:10=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> Hardcoded subvolids break test runs with no free-space-tree, so change
> the test to use _btrfs_get_subvolid instead of assuming 256, 257, etc...
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Now it looks good and actually works. Thanks.

> ---
>  tests/btrfs/301 | 171 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 103 insertions(+), 68 deletions(-)
>
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 7a0b4c0e1..dbc6d9aef 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -166,45 +166,63 @@ enable_quota()
>         $BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
>  }
>
> +get_subvid()
> +{
> +       _btrfs_get_subvolid $SCRATCH_MNT subv
> +}
> +
> +get_snapid()
> +{
> +       _btrfs_get_subvolid $SCRATCH_MNT snap
> +}
> +
> +get_nestedid()
> +{
> +       _btrfs_get_subvolid $SCRATCH_MNT subv/nested
> +}
> +
>  prepare()
>  {
>         _scratch_mkfs >> $seqres.full
>         _scratch_mount
>         enable_quota "s"
>         $BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
> -       set_subvol_limit 256 $limit
> -       check_subvol_usage 256 0
> +       local subvid=3D$(get_subvid)
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
> +       check_subvol_usage $(get_subvid) $(($total_fill + $ext_sz))
> +       check_subvol_usage $(get_snapid) 0
>  }
>
>  prepare_nested()
>  {
>         prepare
> +       local subvid=3D$(get_subvid)
>         $BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
>         $BTRFS_UTIL_PROG qgroup limit $limit 1/100 $SCRATCH_MNT
> -       $BTRFS_UTIL_PROG qgroup assign 0/256 1/100 $SCRATCH_MNT >> $seqre=
s.full
> +       $BTRFS_UTIL_PROG qgroup assign 0/$subvid 1/100 $SCRATCH_MNT >> $s=
eqres.full
>         $BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
> +       local nestedid=3D$(get_nestedid)
>         do_write $nested/f $ext_sz
> -       check_subvol_usage 257 $ext_sz
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> -       local subv_usage=3D$(get_subvol_usage 256)
> -       local nested_usage=3D$(get_subvol_usage 257)
> +       check_subvol_usage $nestedid $ext_sz
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
> +       local subv_usage=3D$(get_subvol_usage $subvid)
> +       local nested_usage=3D$(get_subvol_usage $nestedid)
>         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
>  }
>
> @@ -213,9 +231,10 @@ basic_accounting()
>  {
>         echo "basic accounting"
>         prepare
> +       local subvid=3D$(get_subvid)
>         rm $subv/f
> -       check_subvol_usage 256 $total_fill
> -       cycle_mount_check_subvol_usage 256 $total_fill
> +       check_subvol_usage $subvid $total_fill
> +       cycle_mount_check_subvol_usage $subvid $total_fill
>         do_write $subv/tmp 512M
>         rm $subv/tmp
>         do_write $subv/tmp 512M
> @@ -244,20 +263,22 @@ snapshot_accounting()
>  {
>         echo "snapshot accounting"
>         prepare_snapshotted
> +       local subvid=3D$(get_subvid)
> +       local snapid=3D$(get_snapid)
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
> @@ -266,15 +287,17 @@ delete_snapshot_src_ref()
>  {
>         echo "delete src ref first"
>         prepare_snapshotted
> +       local subvid=3D$(get_subvid)
> +       local snapid=3D$(get_snapid)
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
> @@ -283,14 +306,16 @@ delete_snapshot_ref()
>  {
>         echo "delete snapshot ref first"
>         prepare_snapshotted
> +       local subvid=3D$(get_subvid)
> +       local snapid=3D$(get_snapid)
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
> @@ -299,19 +324,21 @@ delete_snapshot_src()
>  {
>         echo "delete snapshot src first"
>         prepare_snapshotted
> +       local subvid=3D$(get_subvid)
> +       local snapid=3D$(get_snapid)
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
> @@ -320,13 +347,15 @@ delete_snapshot()
>  {
>         echo "delete snapshot first"
>         prepare_snapshotted
> +       local subvid=3D$(get_subvid)
> +       local snapid=3D$(get_snapid)
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
> @@ -336,17 +365,19 @@ nested_accounting()
>  {
>         echo "nested accounting"
>         prepare_nested
> +       local subvid=3D$(get_subvid)
> +       local nestedid=3D$(get_nestedid)
>         rm $subv/f
> -       check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 $ext_sz
> -       local subv_usage=3D$(get_subvol_usage 256)
> -       local nested_usage=3D$(get_subvol_usage 257)
> +       check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $nestedid $ext_sz
> +       local subv_usage=3D$(get_subvol_usage $subvid)
> +       local nested_usage=3D$(get_subvol_usage $nestedid)
>         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
>         rm $nested/f
> -       check_subvol_usage 256 $total_fill
> -       check_subvol_usage 257 0
> -       subv_usage=3D$(get_subvol_usage 256)
> -       nested_usage=3D$(get_subvol_usage 257)
> +       check_subvol_usage $subvid $total_fill
> +       check_subvol_usage $nestedid 0
> +       subv_usage=3D$(get_subvol_usage $subvid)
> +       nested_usage=3D$(get_subvol_usage $nestedid)
>         check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
>         do_enospc_falloc $nested/large_falloc 2G
>         do_enospc_write $nested/large 2G
> @@ -360,26 +391,27 @@ enable_mature()
>         _scratch_mkfs >> $seqres.full
>         _scratch_mount
>         $BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
> +       local subvid=3D$(get_subvid)
>         do_write $subv/f $ext_sz
>         # Sync before enabling squotas to reliably *not* count the writes
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
> @@ -388,13 +420,14 @@ reflink_accounting()
>  {
>         echo "reflink"
>         prepare
> +       local subvid=3D$(get_subvid)
>         # Do enough reflinks to prove that they're free. If they counted,=
 then
>         # this wouldn't fit in the limit.
>         for i in $(seq $(($limit_nr * 2))); do
>                 _cp_reflink $subv/f $subv/f.i
>         done
>         # Confirm that there is no additional data usage from the reflink=
s.
> -       check_subvol_usage 256 $(($total_fill + $ext_sz))
> +       check_subvol_usage $subvid $(($total_fill + $ext_sz))
>         _scratch_unmount
>  }
>
> @@ -403,12 +436,13 @@ delete_reflink_src_ref()
>  {
>         echo "delete reflink src ref"
>         prepare
> +       local subvid=3D$(get_subvid)
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
> @@ -417,12 +451,13 @@ delete_reflink_ref()
>  {
>         echo "delete reflink ref"
>         prepare
> +       local subvid=3D$(get_subvid)
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

