Return-Path: <linux-btrfs+bounces-6519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7174933C37
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 13:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0428299B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D1017F4F6;
	Wed, 17 Jul 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHABhL6y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7117F4E1;
	Wed, 17 Jul 2024 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215549; cv=none; b=CYn5akbO9URH/EkGNlktIOsk4yIS//8RsS7K6RRXdHg+KIgKTeDTR8ZPPVIV/VUHWAO1gGbR87yKH66o901VVOmzWKOjh3512++DD1m3lp/8Xz98FkXOAO3i0da2cMf02rYK2E/gjfRHJLzkeAUUCMNbJzSmD37tsE7WVgl0gNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215549; c=relaxed/simple;
	bh=oE3GfBLij17gha9xA7cisteW8Cp27yVeeSWPwlGl5G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiqK0Al9nXsDUL6+JvE+oxssKXidXlQgrFZii+jdbsWNkabQE6uNNoEbtmVSzasl6LxW6q4z9shLO/j59K70hmJjye1eu+hB/YfzQCpj9PFVjgK1fz63WHlZ1TWUP00aR5NiCtNq+SKRn5QSuOTXbgNoMXD5Lih4D1zvBb9kp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHABhL6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD20C32782;
	Wed, 17 Jul 2024 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721215548;
	bh=oE3GfBLij17gha9xA7cisteW8Cp27yVeeSWPwlGl5G4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pHABhL6yK7lTWrMMNvMEl3uOwUw3YyTIFfUzqPm7dE4ldqO41sFt3cvxZBx4YxrGT
	 QcSbeB717zDDjo89hbOyNm9ZOQ433XPkSB67Hl8cC8klFLLFpMFJDnxAX0wBYtL0DW
	 T/lkkYBIwSTHgJk8Xxg4TQAHZ4pRLxMbUBJPLapYaN/meatd6eDpanSsghxwcDPsVm
	 +cm6Rx/zsDIvW/2G6CmR3OIN9iQUIOQVj5kGCiWhLKOHw1LaaywBAw+t/LqqP43sTT
	 qyCPR13PAF61Ggs4CNocRRXcjQHEf+nSh8n2yasYaul6yeoLlbcBl4Lsl41pNXyTCp
	 AjuxGsnmkP/6Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea929ea56so12562038e87.0;
        Wed, 17 Jul 2024 04:25:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaCgo8nf7aoxvD8G1R35D2vzrdIb1QKo/pYxklHAxBi2v4Y7FrxaU6wg3DZ2fCI3wIUtPpQGF95z8C3J549m17ZYmaKRoAVQ==
X-Gm-Message-State: AOJu0Yy/K0Mxs3xtMm61R4UsBTpsD6oTZSsxutz2DDczJT0TjXZvrqgA
	UQ87adT9fr0vOgO/p/8lNLEoVkQj8FY8Q+pE/1To9ajiAQocwFC7M5a6a/VLuDz33ZxxpmeByCi
	BiiKTB7iml5bL1SEAWqczeggnlRk=
X-Google-Smtp-Source: AGHT+IHnZlAEVsGDXnabq4GdqDJeh3nsbiErBDjOVDe7QzZh99dg25ACF56j5eknyo8TPgiB7K0gpZI/4GeqaaaUAoE=
X-Received: by 2002:a05:6512:1081:b0:52e:9904:71e with SMTP id
 2adb3069b0e04-52ee53d7623mr1247386e87.28.1721215546741; Wed, 17 Jul 2024
 04:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717072700.93025-1-wqu@suse.com>
In-Reply-To: <20240717072700.93025-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Jul 2024 12:25:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4W-QHnckrsO_ZLFUCqE3n9KEYCaj0EXmuUP2LseeHQiA@mail.gmail.com>
Message-ID: <CAL3q7H4W-QHnckrsO_ZLFUCqE3n9KEYCaj0EXmuUP2LseeHQiA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/012: fix a false alert due to socket/pipe files
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 8:27=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> On my Archlinux VM, the test btrfs/012 always fail with the following
> output diff:
>
>      QA output created by 012
>     +File /etc/pacman.d/gnupg/S.dirmngr is a socket while file /mnt/scrat=
ch/etc/pacman.d/gnupg/S.dirmngr is a socket
>     +File /etc/pacman.d/gnupg/S.gpg-agent is a socket while file /mnt/scr=
atch/etc/pacman.d/gnupg/S.gpg-agent is a socket
>     +File /etc/pacman.d/gnupg/S.gpg-agent.browser is a socket while file =
/mnt/scratch/etc/pacman.d/gnupg/S.gpg-agent.browser is a socket
>     +File /etc/pacman.d/gnupg/S.gpg-agent.extra is a socket while file /m=
nt/scratch/etc/pacman.d/gnupg/S.gpg-agent.extra is a socket
>     +File /etc/pacman.d/gnupg/S.gpg-agent.ssh is a socket while file /mnt=
/scratch/etc/pacman.d/gnupg/S.gpg-agent.ssh is a socket
>     +File /etc/pacman.d/gnupg/S.keyboxd is a socket while file /mnt/scrat=
ch/etc/pacman.d/gnupg/S.keyboxd is a socket
>     ...
>
> [CAUSE]
> It's a false alerts.
>
> When diff hits two files which are not directory/softlink/regular files
> (aka, socket/pipe/char/block files), they are all treated as
> non-comparable.
> In that case, diff would just do the above message.
>
> And with Archlinux, pacman (the package manager) maintains its gpg
> directory inside "/etc/pacman.d/gnupg", and the test case uses
> "/etc" as the source directory to populate the target ext4 fs.
>
> And the socket files inside "/etc/pacman.d/gnupg" is causing the false
> alerts.
>
> [FIX]
> - Use fsstress to populate the fs
>   That covers all kind of operations, including creating special files.
>   And fsstress is very reproducible, with the seed saved to the full
>   log, it's much easier to reproduce than using the distro dependent
>   "/etc/" directory.
>
> - Use fssum to save the digest and later verify the contents
>   It does not only verify the contents but also other things like
>   timestamps/xattrs/uid/gid/mode/etc.
>   And it's more comprehensive than the content oriented diff tool.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/012     | 29 +++++++++++++++++------------
>  tests/btrfs/012.out |  6 ++++++
>  2 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index a96efeff..d172d93f 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -23,13 +23,13 @@ _require_scratch_nocheck
>  _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
>  _require_command "$MKFS_EXT4_PROG" mkfs.ext4
>  _require_command "$E2FSCK_PROG" e2fsck
> +_require_fssum
>  # ext4 does not support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
>  _require_loop
>  _require_extra_fs ext4
>
> -SOURCE_DIR=3D/etc
> -BASENAME=3D$(basename $SOURCE_DIR)
> +BASENAME=3D"stressdir"
>  BLOCK_SIZE=3D`_get_block_size $TEST_DIR`
>
>  # Create & populate an ext4 filesystem
> @@ -38,17 +38,21 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seq=
res.full 2>&1 || \
>  # Manual mount so we don't use -t btrfs or selinux context
>  mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>
> -_require_fs_space $SCRATCH_MNT $(du -s $SOURCE_DIR | ${AWK_PROG} '{print=
 $1}')
> +echo "populating the initial ext fs:" >> $seqres.full
> +mkdir "$SCRATCH_MNT/$BASENAME"
> +$FSSTRESS_PROG -w -d "$SCRATCH_MNT/$BASENAME" -n 20 -p 500 >> $seqres.fu=
ll
>
> -$TIMEOUT_PROG 10 cp -aRP $SOURCE_DIR $SCRATCH_MNT
> +# Create the checksum to verify later.
> +$FSSUM_PROG -A -f -w $tmp.original "$SCRATCH_MNT/$BASENAME"
>  _scratch_unmount
>
>  # Convert it to btrfs, mount it, verify the data
>  $BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
>         _fail "btrfs-convert failed"
>  _try_scratch_mount || _fail "Could not mount new btrfs fs"
> -# (Ignore the symlinks which may be broken/nonexistent)
> -diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/$BASENAME/ 2>&1
> +
> +echo "Checking converted btrfs against the original one:"
> +$FSSUM_PROG -r $tmp.original $SCRATCH_MNT/$BASENAME
>
>  # Old ext4 image file should exist & be consistent
>  $E2FSCK_PROG -fn $SCRATCH_MNT/ext2_saved/image >> $seqres.full 2>&1 || \
> @@ -58,13 +62,14 @@ $E2FSCK_PROG -fn $SCRATCH_MNT/ext2_saved/image >> $se=
qres.full 2>&1 || \
>  mkdir -p $SCRATCH_MNT/mnt
>  mount -o loop $SCRATCH_MNT/ext2_saved/image $SCRATCH_MNT/mnt || \
>         _fail "could not loop mount saved ext4 image"
> -# Ignore the symlinks which may be broken/nonexistent
> -diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/mnt/$BASENAME/ 2>&1
> +
> +echo "Checking saved ext2 image against the original one:"
> +$FSSUM_PROG -r $tmp.original $SCRATCH_MNT/mnt/$BASENAME
>  umount $SCRATCH_MNT/mnt
>
> -# Now put some fresh data on the btrfs fs
> +echo "genereating new data on the converted btrfs" >> $seqres.full

Typo:  genereating -> generating

With that fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>  mkdir -p $SCRATCH_MNT/new
> -$TIMEOUT_PROG 10 cp -aRP $SOURCE_DIR $SCRATCH_MNT/new
> +$FSSTRESS_PROG -w -d "$SCRATCH_MNT/new" -n 20 -p 500 >> $seqres.full
>
>  _scratch_unmount
>
> @@ -78,8 +83,8 @@ $E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || \
>
>  # Mount the un-converted ext4 device & check the contents
>  mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> -# (Ignore the symlinks which may be broken/nonexistent)
> -diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/$BASENAME/ 2>&1
> +echo "Checking rolled back ext2 against the original one:"
> +$FSSUM_PROG -r $tmp.original $SCRATCH_MNT/$BASENAME
>
>  _scratch_unmount
>
> diff --git a/tests/btrfs/012.out b/tests/btrfs/012.out
> index 7aa5ae94..8ea81fad 100644
> --- a/tests/btrfs/012.out
> +++ b/tests/btrfs/012.out
> @@ -1 +1,7 @@
>  QA output created by 012
> +Checking converted btrfs against the original one:
> +OK
> +Checking saved ext2 image against the original one:
> +OK
> +Checking rolled back ext2 against the original one:
> +OK
> --
> 2.45.2
>
>

