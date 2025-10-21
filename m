Return-Path: <linux-btrfs+bounces-18111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3ABF64CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52A9E34E190
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8FF331A55;
	Tue, 21 Oct 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwf7vn1m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC54F9EC
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047391; cv=none; b=Luz3wZCxInXlnp1ImDNMrVuQmEKWM2hfT0T4JDToT8D+zuhRM+XPiS5/XTqMoWbC9DzQth7rKG3ReAHL7MKjFDAfqLpnonvIOpjPDmqgfFRMT1+ukqmlZQCzKUxXU5xFaFCgYgNE7lfuDVyGpVG9x5cCt175H3+LfKxmghU7f6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047391; c=relaxed/simple;
	bh=6fK9ZwgT3t4LLqiADvxNVM2XFSPOusIwN+zkGcy/CTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/h4ejO+/6f6sn7G0sj7A0d6sZ5uRl3Hc0G388U43kijXEngw/pxd6pDVO/Jn+r9lqC0rsVh8bMnOs0/yUNzPiKFXaNd/eWK8X41SCrxw/xADrDerykoJnxauP9bOb6Sewz06wS9mEg0NFMqttomjc6AQ03kJ4HEXtniY1G/8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwf7vn1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A46C4CEFD
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047391;
	bh=6fK9ZwgT3t4LLqiADvxNVM2XFSPOusIwN+zkGcy/CTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jwf7vn1myrNPMcv+kxzE9XqNFF7miiknS2pW9mWrVpcfoCehmQf2yAnDFgv/8VtXi
	 jeCGiS2Z3J9dlBVaz5+++g9Ei/kksEU87ZOlJEpSePNv6YGqkvqzxDYywYszFKdk72
	 zkKq3AmbOI8y7S6/0xTfLObtv/DdyHH7lXG9/Pg4Ilia2A77Ltqj8DdFX7BHt2T4lO
	 U6s6SZQNBhmQfdF+pQTSvO73vis6PcpCqOKJrNLdpMa2DBl8QI5/3KmLzD1HVMEz23
	 egJRiJ3/2+OlQxAKpE/zhs5sszYJWGejEijJcFcmhUVqm28NsgIVjYcbolwAZCOaeN
	 Dr0mZD46fgWCg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b5e19810703so904811666b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 04:49:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLMuC6PXDyqRfy4+fkDTFxGVWZIEWOIY8VnRvyKfW+aW41+P9rDPrrC4lv1ci5BfKmgOSGrHnFiu+BbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywww6X7EwwmcNiL0c0miiumsKahMmZfSYejxHzkG0cPS13oI8Et
	ZFJxlud/yKMnZjOOVBiW3jR6UVqRbH7280MrEYtg5sc5UuUV4JgdchrMZ2OZyRwK9bdqndqA7jW
	49xfKPBFJK0xjoEBW6a0o0o80OYw4TPw=
X-Google-Smtp-Source: AGHT+IHZVhb65fPVD2ZhEaHIaEpkDLVDlwn3vfr18Qf55qv8p4pHPmgkXgncRevRYcwqXJllbRQNekqzEIL/UpuxbH4=
X-Received: by 2002:a17:907:7241:b0:b58:98ca:f32f with SMTP id
 a640c23a62f3a-b6472a6a151mr1974199866b.16.1761047389569; Tue, 21 Oct 2025
 04:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760332925.git.nirjhar.roy.lists@gmail.com>
 <9849006dd25950d390a8b300ad056e0d4be00394.1760332925.git.nirjhar.roy.lists@gmail.com>
 <e4d6a3d9-2a19-4d89-ac7f-899189329f18@gmail.com>
In-Reply-To: <e4d6a3d9-2a19-4d89-ac7f-899189329f18@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 21 Oct 2025 12:49:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7qdRskeaKOSxAiaqbb+TvCdUfpfh06-WiZFdG9n1Mr_w@mail.gmail.com>
X-Gm-Features: AS18NWC00uwSV66uW4ZNBTDAFqUtFxNL2Fw7mo_Wxv13Mc7oA-CFcO4iGZqJEhE
Message-ID: <CAL3q7H7qdRskeaKOSxAiaqbb+TvCdUfpfh06-WiZFdG9n1Mr_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btrfs/290: Make the test compatible with all
 supported block sizes
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org, 
	quwenruo.btrfs@gmx.com, zlang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:44=E2=80=AFAM Nirjhar Roy (IBM)
<nirjhar.roy.lists@gmail.com> wrote:
>
>
> On 10/13/25 11:09, Nirjhar Roy (IBM) wrote:
> > This test fails with 64k block size with the following error:
> >
> >       punch
> >       pread: Input/output error
> >       pread: Input/output error
> >      +ERROR: couldn't find extent 4096 for inode 261
> >       plug
> >      -pread: Input/output error
> >      -pread: Input/output error
> >      ...
> >
> > The reason is that, some of the subtests are written with 4k blocksize
> > in mind. Fix the test by making the offsets and sizes to multiples of
> > 64k so that it becomes compatible/aligned with all supported block size=
s.
>
> Hi Filipe,
>
> Do you have any additional feedback on this? I have made the changes
> suggested by you in [v1]

Looks good  now, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>
> [v1]
> https://lore.kernel.org/all/CAL3q7H58hDCrYMqDwdO_Lf7B2J+Wdv5FpAw6u5NkDK0E=
xZ8K0A@mail.gmail.com/
>
> --NR
>
> >
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > ---
> >   tests/btrfs/290 | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tests/btrfs/290 b/tests/btrfs/290
> > index 04563dfe..471b6617 100755
> > --- a/tests/btrfs/290
> > +++ b/tests/btrfs/290
> > @@ -106,15 +106,15 @@ corrupt_reg_to_prealloc() {
> >   # corrupt a file by punching a hole
> >   corrupt_punch_hole() {
> >       local f=3D$SCRATCH_MNT/punch
> > -     $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> > +     $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
> >       local ino=3D$(get_ino $f)
> >       # make a new extent in the middle, sync so the writes don't coale=
sce
> >       $XFS_IO_PROG -c sync $SCRATCH_MNT
> > -     $XFS_IO_PROG -fc "pwrite -q -S 0x59 4096 4096" $f
> > +     $XFS_IO_PROG -fc "pwrite -q -S 0x59 64k 64k" $f
> >       _fsv_enable $f
> >       _scratch_unmount
> >       # change disk_bytenr to 0, representing a hole
> > -     $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr --value =
0 \
> > +     $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr --value=
 0 \
> >                                                                   $SCRA=
TCH_DEV
> >       _scratch_mount
> >       validate $f
> > @@ -123,14 +123,14 @@ corrupt_punch_hole() {
> >   # plug hole
> >   corrupt_plug_hole() {
> >       local f=3D$SCRATCH_MNT/plug
> > -     $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> > +     $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
> >       local ino=3D$(get_ino $f)
> > -     $XFS_IO_PROG -fc "falloc 4k 4k" $f
> > +     $XFS_IO_PROG -fc "falloc 64k 64k" $f
> >       _fsv_enable $f
> >       _scratch_unmount
> >       # change disk_bytenr to some value, plugging the hole
> > -     $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
> > -                                                --value 13639680 $SCRA=
TCH_DEV
> > +     $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr \
> > +                                                --value 218234880 $SCR=
ATCH_DEV
> >       _scratch_mount
> >       validate $f
> >   }
> > @@ -166,7 +166,7 @@ corrupt_root_hash() {
> >   # corrupt the Merkle tree data itself
> >   corrupt_merkle_tree() {
> >       local f=3D$SCRATCH_MNT/merkle
> > -     $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> > +     $XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
> >       local ino=3D$(get_ino $f)
> >       _fsv_enable $f
> >       _scratch_unmount
>
> --
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
>

