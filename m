Return-Path: <linux-btrfs+bounces-17510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D678EBC1318
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 13:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 446C2344E9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719A12DA758;
	Tue,  7 Oct 2025 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCbxLW6h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BE2D97A0
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836173; cv=none; b=fXs8JeENXgTTSrlpVsmSNfz65OTT73ZfmUdVEzJI8hy29EZCAM3o4eCK8/2Ey0ZWWXJ/HrrZ72ho5hgLLJv/j3yW1N/6cft1QuqSyxvU6DASDCOCkX9fXUjYxfaaIJfv5JdEMJB01oXl1MV7gd6C73bhFt0Rr5Du7+1UReHftgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836173; c=relaxed/simple;
	bh=eP8q0v1FvPcq0wHEKOWS6F3vyzy+zXD11XS41M4kF7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY5fXkyc6JDmHeK1FKyKvtcf+VLNi70VPRFVotVEz48Wfuw2w8lezqilMgb3KqplIeUU+V0P+T/lCvUieppQFsRl3GAvEkyKqPZRU7DT22tvBpuu4itmItb2HVXG0rGnd+elo5E/F72PPfClju1rkk6kXsDhHWmYdR4y9Cfe54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCbxLW6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D16DC4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759836173;
	bh=eP8q0v1FvPcq0wHEKOWS6F3vyzy+zXD11XS41M4kF7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WCbxLW6hGb+nrAllURetzUA6uYCA0KhyC5xze5Kn3iLV+DmPiPOtQngC9QHHKeSGS
	 S05Rjrh49nGlt1vmtm25O1Tg+Xi0S1YwswNy5kWXYulaM9eo+T2EyzCSZe1Nx4ozZJ
	 lYDpna4FxbAIW4GEPIetAqXXBj5rQ+VnxX24B8feQDVaCyo6SArYoi8CXUIiBOZkgu
	 /sXwF9KPF+vVEN1mXrUP/khzeatSmQua9Nvxs1a65dRBF4nge99DVnhzuvCxXqbtP7
	 SHk4htzvHqGBcQnsns/U2sm9KYR70yXF99ZbHb5FCiszt9g6s0iVSQzLEZk3E7WKxE
	 4PjVe1oSqPglQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so10095572a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Oct 2025 04:22:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTNKH8Sfby1rN64PBSiTspSZDAuTkBNzA7mHS/9Yh6ncV28/Xzm9RQsB2J58Dw+w1hkTZtuzW0LsAAHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCYUSRNoLd0JRFVcyCgFUOGMEkgwdKOzB1tWhMTEdkKaHidEE
	XZJNCq1uzi23aRTnoCnEahKc8PJQp/4tZssAhbV3LzXQoxmKQh5ujzqIb7lMnU+FZd54/wxBXqt
	5wU1HAeDwVk3XRgU4mKZgbU+B6LwNd1k=
X-Google-Smtp-Source: AGHT+IEAyBmWKBCZymSXYUH6FfCCi22wmuxobBDl4XLJitmC8DBKyQh/pBKpqr6PDSwasy3NIWWFtPpBs/y97t4rndw=
X-Received: by 2002:a17:906:f581:b0:b3c:896:abf5 with SMTP id
 a640c23a62f3a-b49c098e2c7mr2025674166b.25.1759836171800; Tue, 07 Oct 2025
 04:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com> <8081c6bcdc56ca2018e51e98e7d3086068f026b9.1758036285.git.nirjhar.roy.lists@gmail.com>
In-Reply-To: <8081c6bcdc56ca2018e51e98e7d3086068f026b9.1758036285.git.nirjhar.roy.lists@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 7 Oct 2025 12:22:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H58hDCrYMqDwdO_Lf7B2J+Wdv5FpAw6u5NkDK0ExZ8K0A@mail.gmail.com>
X-Gm-Features: AS18NWCFVAbvGKfcSze4ubI6ubYZXEspTtvwwJcrbX7X7ER7fk4RBnKMvNI1XvM
Message-ID: <CAL3q7H58hDCrYMqDwdO_Lf7B2J+Wdv5FpAw6u5NkDK0ExZ8K0A@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs/290: Make the test compatible with all
 supported block sizes
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com, 
	djwong@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:31=E2=80=AFPM Nirjhar Roy (IBM)
<nirjhar.roy.lists@gmail.com> wrote:
>
> This test fails with 64k block size with the following error:
>
>      punch
>      pread: Input/output error
>      pread: Input/output error
>     +ERROR: couldn't find extent 4096 for inode 261
>      plug
>     -pread: Input/output error
>     -pread: Input/output error
>     ...
>
> The reason is that, some of the subtests are written with 4k blocksize
> in mind. Fix the test by making the offsets and sizes to 64k so

"... offsets and sizes to 64k..." -> "... offsets and sizes multiples of 64=
K..."

> that it becomes compatible/aligned with all supported block sizes.
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/btrfs/290 | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tests/btrfs/290 b/tests/btrfs/290
> index 04563dfe..fecec473 100755
> --- a/tests/btrfs/290
> +++ b/tests/btrfs/290
> @@ -106,15 +106,15 @@ corrupt_reg_to_prealloc() {
>  # corrupt a file by punching a hole
>  corrupt_punch_hole() {
>         local f=3D$SCRATCH_MNT/punch
> -       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> +       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f

Can you please make this more readable and type 192K instead of 196608?

>         local ino=3D$(get_ino $f)
>         # make a new extent in the middle, sync so the writes don't coale=
sce
>         $XFS_IO_PROG -c sync $SCRATCH_MNT
> -       $XFS_IO_PROG -fc "pwrite -q -S 0x59 4096 4096" $f
> +       $XFS_IO_PROG -fc "pwrite -q -S 0x59 64k 64k" $f

Here you use 64k instead of 65536, which is more readable.

>         _fsv_enable $f
>         _scratch_unmount
>         # change disk_bytenr to 0, representing a hole
> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr --value =
0 \
> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr --value=
 0 \
>                                                                     $SCRA=
TCH_DEV
>         _scratch_mount
>         validate $f
> @@ -123,14 +123,14 @@ corrupt_punch_hole() {
>  # plug hole
>  corrupt_plug_hole() {
>         local f=3D$SCRATCH_MNT/plug
> -       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> +       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f

Same here, 192K.

>         local ino=3D$(get_ino $f)
> -       $XFS_IO_PROG -fc "falloc 4k 4k" $f
> +       $XFS_IO_PROG -fc "falloc 64k 64k" $f
>         _fsv_enable $f
>         _scratch_unmount
>         # change disk_bytenr to some value, plugging the hole
> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
> -                                                  --value 13639680 $SCRA=
TCH_DEV
> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr \
> +                                                  --value 218234880 $SCR=
ATCH_DEV
>         _scratch_mount
>         validate $f
>  }
> @@ -166,7 +166,7 @@ corrupt_root_hash() {
>  # corrupt the Merkle tree data itself
>  corrupt_merkle_tree() {
>         local f=3D$SCRATCH_MNT/merkle
> -       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> +       $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f

Same here, 192K.

Also please always cc the btrfs mailing list for changes to btrfs tests.


>         local ino=3D$(get_ino $f)
>         _fsv_enable $f
>         _scratch_unmount
> --
> 2.34.1
>

