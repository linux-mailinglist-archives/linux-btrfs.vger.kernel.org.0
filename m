Return-Path: <linux-btrfs+bounces-3491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9658857E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 12:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803AE1C21283
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455959147;
	Thu, 21 Mar 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPAfs+9h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201057880;
	Thu, 21 Mar 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019621; cv=none; b=IUAbjzv0aRA8iFLsuhs+FdUfCkqrvEQcwxtu7n+r3xV3aQ9+eMzCFjOQqgNRGs5/bm/NUshXzANochpxfQeWOYx9obumlTEErngZklF+aAhAs+SIv299lJVLkiHsBntcSGCID+UNjsdtu5BxCoPYL0VsHtoJ59QJKjvqKJPPU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019621; c=relaxed/simple;
	bh=zcORRXeZsyrhyUorSnQHLjGP1WdcRAIKZmwNeMkuzdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jv6f5Y0LuT9DgUJ2HytxEEX0SB4Y/N4D5oSsmEYWMT2c3FD/+TTFzMRH+8Lh4zveYPsVQFUnuV6Sbv+nn7nI0lZ2xSwhWY9p7dzJwQCSFURyRCYTMiX64uk6XhklUbWuMz4Yrrs47tH4tlCoOHl9+yYMcdGg7VHvObwkoR/vI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPAfs+9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125E3C43394;
	Thu, 21 Mar 2024 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711019621;
	bh=zcORRXeZsyrhyUorSnQHLjGP1WdcRAIKZmwNeMkuzdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fPAfs+9hdhWlPpXEXGH9OVrOgibkXGjXXQTa+lwF+vp6+rk7wZIrGd7nUEFeQQ8+J
	 ZHNdAIyqwp/ArhI5Plt4hKnqiNS+eqk+brBD6GsG6Ikun2x02liDFtTFceBM06VWGw
	 zkfP2CJM0kSoct4mr4KcBIaVQXYzsC9Sz/MDIwfrIzxW0XchGQhyR+hDGufBqjPXFB
	 0WhTmL4xBVOTCp9jcjjXh2zvslMZpAvIVZOgfi0WjcaOaGfNJnGirj9lJj8FPZAvza
	 ljyBCM56PXkUd2FFCIHJ5ha6WeM+drNzO4K0Gicnk9dZBsbzCn90fxNNQvvjCM0/6n
	 sBvrt+EUvRXMQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso100014566b.1;
        Thu, 21 Mar 2024 04:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWR66ow3tcq947pOm/o+55DraNi2iiBa5EzZ477U9jwqT5K7RQrVSPA6oNTJfVxGGPRfEKtxMBWZwhPQAlPDfKDN9/fwP0chm5i1po=
X-Gm-Message-State: AOJu0YzNlSSvsDOGFtUPjpOHGav2R3e66Aj2gdcB8F9G4JYnafO5bUsv
	De6pPI5sp3E2WO8Ov0Z9EyjsA7hF900V5ND1f+K24v+ICdCX9S7sEFitocYKhFyUJh9guH9lh25
	YTqZsgpZKBfIlWIcOtoeWfGylSkQ=
X-Google-Smtp-Source: AGHT+IFJ98T6pWSLW4AOcYOAfH7LbIy0DPHa03CS0+LH5sPmcVRgkrCbcqV6Lzrh41X+jzgGMQeZ16dm42dhGJUIQrw=
X-Received: by 2002:a17:907:9874:b0:a47:1b77:7c4 with SMTP id
 ko20-20020a170907987400b00a471b7707c4mr535097ejc.48.1711019619515; Thu, 21
 Mar 2024 04:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710871719.git.dsterba@suse.com> <eb2493499d2f30f43afa09e980589bb4f15e9789.1710984595.git.anand.jain@oracle.com>
In-Reply-To: <eb2493499d2f30f43afa09e980589bb4f15e9789.1710984595.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 21 Mar 2024 11:13:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4nJgu+b8OPZHp+0TRWpPpnaeTen44udZG7980Lvh028Q@mail.gmail.com>
Message-ID: <CAL3q7H4nJgu+b8OPZHp+0TRWpPpnaeTen44udZG7980Lvh028Q@mail.gmail.com>
Subject: Re: [PATCH] common/btrfs: set BTRFS_CORRUPT_BLOCK_OPT_<VALUE|OFFSET>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:10=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> As btrfs-corrupt-block now uses --value instead of -v, and --offset
> instead of -o, provide backward compatibility for the testcases, by
> storing the option to be used in BTRFS_CORRUPT_BLOCK_OPT_VALUE and
> BTRFS_CORRUPT_BLOCK_OPT_OFFSET. Also, removes the stdout and stderr
> redirection to /dev/null.

This is complex and ugly, but most importantly this is not needed at all.

Just let all users of btrfs-corrupt-block use --value and --offset,
because there was never
a released version of btrfs-progs with the short options available.

The short options were introduced with:

commit b2ada0594116f3f4458581317e226c5976443ad0
Author: Boris Burkov <boris@bur.io>
Date:   Tue Jul 26 13:43:23 2022 -0700

    btrfs-progs: corrupt-block: corrupt generic item data

And then replacing them with long options happened in this commit:

commit 22ffee3c6cf2e6f285e6fd6cb22b88c02510e10e
Author: David Sterba <dsterba@suse.com>
Date:   Wed Jul 27 20:47:57 2022 +0200

    btrfs-progs: corrupt-block: use only long options for value and offset

Both commits landed in btrfs-progs 5.19, meaning there are no released
versions with the short options.

The reason btrfs/290 is using the short options is because the
btrfs-progs patch had just been submitted shortly before the test case
was added.

However what we need is to have a _require_* helper that will make the
test btrfs/290 not run if we're using a btrfs-progs version without
those new options.

Thanks.


>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> This replaces the patch:
>    [PATCH 1/5] common/verity: use the correct options for btrfs-corrupt-b=
lock
>
>  common/btrfs    | 16 ++++++++++++++++
>  common/verity   |  9 ++++++---
>  tests/btrfs/290 | 30 ++++++++++++++++++++++--------
>  3 files changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index ae13fb55cbc6..11d74bea9111 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -660,6 +660,22 @@ _btrfs_buffered_read_on_mirror()
>  _require_btrfs_corrupt_block()
>  {
>         _require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs-corrupt-block
> +
> +       # In the newer version, the option -v is replaced by --value,
> +       # and -o is replaced by --offset, so normalize them.
> +       $BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q "value VALUE"
> +       if [ $? =3D=3D 0 ]; then
> +               export BTRFS_CORRUPT_BLOCK_OPT_VALUE=3D"--value"
> +       else
> +               export BTRFS_CORRUPT_BLOCK_OPT_VALUE=3D"-v"
> +       fi
> +
> +       $BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q "offset OFFSET"
> +       if [ $? =3D=3D 0 ]; then
> +               export BTRFS_CORRUPT_BLOCK_OPT_OFFSET=3D"--offset"
> +       else
> +               export BTRFS_CORRUPT_BLOCK_OPT_OFFSET=3D"-o"
> +       fi
>  }
>
>  _require_btrfs_send_version()
> diff --git a/common/verity b/common/verity
> index 03d175ce1b7a..33a1c12f558e 100644
> --- a/common/verity
> +++ b/common/verity
> @@ -400,9 +400,12 @@ _fsv_scratch_corrupt_merkle_tree()
>                         local ascii=3D$(printf "%d" "'$byte'")
>                         # This command will find a Merkle tree item for t=
he inode (-I $ino,37,0)
>                         # in the default filesystem tree (-r 5) and corru=
pt one byte (-b 1) at
> -                       # $offset (-o $offset) with the ascii representat=
ion of the byte we read
> -                       # (-v $ascii)
> -                       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $a=
scii -o $offset -b 1 $SCRATCH_DEV
> +                       # $offset (-o|--offset $offset) with the ascii
> +                       # representation of the byte we read (-v|--value =
$ascii)
> +                       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 \
> +                               $BTRFS_CORRUPT_BLOCK_OPT_VALUE $ascii \
> +                               $BTRFS_CORRUPT_BLOCK_OPT_OFFSET $offset \
> +                                                       -b 1 $SCRATCH_DEV
>                         (( offset +=3D 1 ))
>                 done
>                 _scratch_mount
> diff --git a/tests/btrfs/290 b/tests/btrfs/290
> index 61e741faeb45..d6f777776838 100755
> --- a/tests/btrfs/290
> +++ b/tests/btrfs/290
> @@ -58,7 +58,7 @@ corrupt_inline() {
>         _scratch_unmount
>         # inline data starts at disk_bytenr
>         # overwrite the first u64 with random bogus junk
> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DE=
V > /dev/null 2>&1
> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DE=
V
>         _scratch_mount
>         validate $f
>  }
> @@ -72,7 +72,8 @@ corrupt_prealloc_to_reg() {
>         _scratch_unmount
>         # ensure non-zero at the pre-allocated region on disk
>         # set extent type from prealloc (2) to reg (1)
> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 1 $SCRATCH_DEV =
>/dev/null 2>&1
> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type \
> +                               $BTRFS_CORRUPT_BLOCK_OPT_VALUE 1 $SCRATCH=
_DEV
>         _scratch_mount
>         # now that it's a regular file, reading actually looks at the pre=
viously
>         # preallocated region, so ensure that has non-zero contents.
> @@ -88,7 +89,8 @@ corrupt_reg_to_prealloc() {
>         _fsv_enable $f
>         _scratch_unmount
>         # set type from reg (1) to prealloc (2)
> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 2 $SCRATCH_DEV =
>/dev/null 2>&1
> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type \
> +                               $BTRFS_CORRUPT_BLOCK_OPT_VALUE 2 $SCRATCH=
_DEV
>         _scratch_mount
>         validate $f
>  }
> @@ -104,7 +106,8 @@ corrupt_punch_hole() {
>         _fsv_enable $f
>         _scratch_unmount
>         # change disk_bytenr to 0, representing a hole
> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 0 $SC=
RATCH_DEV > /dev/null 2>&1
> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
> +                               $BTRFS_CORRUPT_BLOCK_OPT_VALUE 0 $SCRATCH=
_DEV
>         _scratch_mount
>         validate $f
>  }
> @@ -118,7 +121,8 @@ corrupt_plug_hole() {
>         _fsv_enable $f
>         _scratch_unmount
>         # change disk_bytenr to some value, plugging the hole
> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 13639=
680 $SCRATCH_DEV > /dev/null 2>&1
> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
> +                       $BTRFS_CORRUPT_BLOCK_OPT_VALUE 13639680 $SCRATCH_=
DEV
>         _scratch_mount
>         validate $f
>  }
> @@ -132,7 +136,11 @@ corrupt_verity_descriptor() {
>         _scratch_unmount
>         # key for the descriptor item is <inode, BTRFS_VERITY_DESC_ITEM_K=
EY, 1>,
>         # 88 is X. So we write 5 Xs to the start of the descriptor
> -       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 0 -b 5 $SCRA=
TCH_DEV > /dev/null 2>&1
> +       btrfs in dump-tree -t 5 $SCRATCH_DEV > $tmp.desc_dump_tree
> +       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 \
> +                                       $BTRFS_CORRUPT_BLOCK_OPT_VALUE 88=
 \
> +                                       $BTRFS_CORRUPT_BLOCK_OPT_OFFSET 0=
 \
> +                                       -b 5 $SCRATCH_DEV
>         _scratch_mount
>         validate $f
>  }
> @@ -144,7 +152,10 @@ corrupt_root_hash() {
>         local ino=3D$(get_ino $f)
>         _fsv_enable $f
>         _scratch_unmount
> -       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 16 -b 1 $SCR=
ATCH_DEV > /dev/null 2>&1
> +       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 \
> +                                       $BTRFS_CORRUPT_BLOCK_OPT_VALUE 88=
 \
> +                                       $BTRFS_CORRUPT_BLOCK_OPT_OFFSET 1=
6 \
> +                                       -b 1 $SCRATCH_DEV
>         _scratch_mount
>         validate $f
>  }
> @@ -159,7 +170,10 @@ corrupt_merkle_tree() {
>         # key for the descriptor item is <inode, BTRFS_VERITY_MERKLE_ITEM=
_KEY, 0>,
>         # 88 is X. So we write 5 Xs to somewhere in the middle of the fir=
st
>         # merkle item
> -       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v 88 -o 100 -b 5 $SC=
RATCH_DEV > /dev/null 2>&1
> +       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 \
> +                                       $BTRFS_CORRUPT_BLOCK_OPT_VALUE 88=
 \
> +                                       $BTRFS_CORRUPT_BLOCK_OPT_OFFSET 1=
00 \
> +                                       -b 5 $SCRATCH_DEV
>         _scratch_mount
>         validate $f
>  }
> --
> 2.39.3
>
>

