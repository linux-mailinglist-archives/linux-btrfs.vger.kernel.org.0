Return-Path: <linux-btrfs+bounces-2457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D0858175
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDAAB222CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35071131750;
	Fri, 16 Feb 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qplysR5q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E152130E4A
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097774; cv=none; b=uUGxFlWOGxjRjnY1+9ACOLYVjR+2vhrr/gvsRMtuvacXiR9bi2ADR8OVjpTEk0GH9yXxIngMsCTTz+6yRkS0K6ZDBhDbImDMOB1D3lRPtXpevtCPBYU/72GONt5Jw0Ze1p8wOYkxzqcqI//s8oiyWkVj3qETQ28g6wAfKuDj3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097774; c=relaxed/simple;
	bh=upE5npUkd6W3gH18uW+PoDmZGjjIl6bKbcpiJyyaBic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXzTAimLCJrLWXhCyrpWW4sH1x5fVb9AJyDOLBjDLHPn7piaRp3h2GZMhfvw+yNUKjO4aR/J7oYzDjwoFM5cpMCagjMVwKJYTaXFyaDk3kiL0gBk9RkXWACTm+g2yTyp/QoqUmW9YCQ+C0bNPwib+g2niy1tEIl7dJ0KM9MCtwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qplysR5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C912AC43394
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708097773;
	bh=upE5npUkd6W3gH18uW+PoDmZGjjIl6bKbcpiJyyaBic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qplysR5qu6dEIHHP2xz9ADh/zBSssrOcgChLvXWunvUko87yrFxzs2B3A2rCCmYGX
	 IsYUMRbz7rqe1dJlNimm1p4teL4QLPHN3wvUV9D7Inm9Psv8hPmLDKy4ZUB/aLsKGS
	 /kicfBo9YdDG5FswCQCccxr4BpKqV4w9P322XVJRFeS3k2Ogv2PHOjI9LJExd4cfA7
	 /L9crsipFRzvuIwW786dchVXdZFkwgIHQ1XCNTZ4CE4pYGooivrfK5lgdXwvUpgDtD
	 1P5BKhApemtCiS/9+w78WHPQE2K9vX4gsRiIzTgKns4EYjtvi0745pPQP23Wh3WjHJ
	 LE8rF8lXUd+Tw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5101cd91017so2863082e87.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 07:36:13 -0800 (PST)
X-Gm-Message-State: AOJu0Yy7px0myUgZoMz7JgZu6dXMDvSGDl7FJ5Pa5meVaktsUzBtpiUq
	MNpmeNWcwnmhIxB6ypp0o67NaHsBIPyDciRtbYCsBJIrjER/PZ0D9bdNXF2D3ysvp65UuZK3sMf
	Rr+y96QLNquBIcnrY0sXVdUAseAY=
X-Google-Smtp-Source: AGHT+IF3aGR6xgU9mFSHs+d2GBAl55pZVpH0tKsbiHrIvYHZCBYX9xEqa6zX4S28o4+9YglPpREECerD6BJj+GHd1I0=
X-Received: by 2002:a05:6512:2253:b0:512:999e:671b with SMTP id
 i19-20020a056512225300b00512999e671bmr1051055lfu.54.1708097771956; Fri, 16
 Feb 2024 07:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me> <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
 <20b3b98b-b165-4fd7-b026-8f3c8440a631@inix.me> <29b50a95-025d-41c3-bee6-f51888b28487@inix.me>
In-Reply-To: <29b50a95-025d-41c3-bee6-f51888b28487@inix.me>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 16 Feb 2024 15:35:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H41FJ1KV281OQKpozbtONLcEFoaMpZ2nCKhgTNR36GUCg@mail.gmail.com>
Message-ID: <CAL3q7H41FJ1KV281OQKpozbtONLcEFoaMpZ2nCKhgTNR36GUCg@mail.gmail.com>
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
To: Dorai Ashok S A <dash.btrfs@inix.me>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:04=E2=80=AFPM Dorai Ashok S A <dash.btrfs@inix.me=
> wrote:
>
>
>  > seq 10000000 > 76mb.file
>
> This should be: seq 10000000 > thin-mount/76mb.file
>
> Either ways, I get a large send stream (2.5GB / 2.8GB)

Ok, now I understand your use case.
So I simplified the script to:

#!/bin/bash

DEV=3D/dev/sdh
MNT=3D/mnt/sdh

umount $DEV &> /dev/null
mkfs.btrfs -f $DEV >/dev/null
mount $DEV $MNT

pushd .
cd $MNT

truncate -s +3G thin-disk
mkfs.btrfs thin-disk >& /dev/null
mkdir thin-mount
mount thin-disk thin-mount/

fstrim thin-mount

btrfs subvolume snapshot -r . 1.s
btrfs subvolume snapshot -r . 2.s
seq 10000000 > thin-mount/76mb.file
btrfs filesystem sync thin-mount
btrfs subvolume snapshot -r . 3.s

tree -h

btrfs send 1.s | wc -c | numfmt --to=3Diec

btrfs send 2.s | wc -c | numfmt --to=3Diec

btrfs send 3.s | wc -c | numfmt --to=3Diec

btrfs send -p 1.s 2.s | wc -c | numfmt --to=3Diec

btrfs send -p 2.s 3.s | wc -c | numfmt --to=3Diec
du -hs thin-disk
fstrim thin-mount
du -hs thin-disk
btrfs send -p 2.s 3.s | wc -c | numfmt --to=3Diec

tree -h

btrfs subvolume delete *.s
umount thin-mount
rm -f thin-disk
rmdir thin-mount

popd

umount $DEV


Which reproduces the 2.5G stream:

$ ./test.sh
Create a readonly snapshot of '.' in './1.s'
Create a readonly snapshot of '.' in './2.s'
Create a readonly snapshot of '.' in './3.s'
[  56]  .
=E2=94=9C=E2=94=80=E2=94=80 [  38]  1.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [3.0G]  thin-disk
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 [   0]  thin-mount
=E2=94=9C=E2=94=80=E2=94=80 [  44]  2.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [   0]  1.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [3.0G]  thin-disk
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 [   0]  thin-mount
=E2=94=9C=E2=94=80=E2=94=80 [  50]  3.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [   0]  1.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [   0]  2.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [3.0G]  thin-disk
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 [   0]  thin-mount
=E2=94=9C=E2=94=80=E2=94=80 [3.0G]  thin-disk
=E2=94=94=E2=94=80=E2=94=80 [  18]  thin-mount
    =E2=94=94=E2=94=80=E2=94=80 [ 75M]  76mb.file

11 directories, 5 files
At subvol 1.s
1.3M
At subvol 2.s
1.3M
At subvol 3.s
77M
At subvol 2.s
170
At subvol 3.s
2.5G
77M thin-disk
77M thin-disk
At subvol 3.s
2.5G
[  56]  .
=E2=94=9C=E2=94=80=E2=94=80 [  38]  1.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [3.0G]  thin-disk
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 [   0]  thin-mount
=E2=94=9C=E2=94=80=E2=94=80 [  44]  2.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [   0]  1.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [3.0G]  thin-disk
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 [   0]  thin-mount
=E2=94=9C=E2=94=80=E2=94=80 [  50]  3.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [   0]  1.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [   0]  2.s
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 [3.0G]  thin-disk
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 [   0]  thin-mount
=E2=94=9C=E2=94=80=E2=94=80 [3.0G]  thin-disk
=E2=94=94=E2=94=80=E2=94=80 [  18]  thin-mount
    =E2=94=94=E2=94=80=E2=94=80 [ 75M]  76mb.file

11 directories, 5 files
Delete subvolume (no-commit): '/mnt/sdh/1.s'
Delete subvolume (no-commit): '/mnt/sdh/2.s'
Delete subvolume (no-commit): '/mnt/sdh/3.s'
/mnt

So this is normal, because the file backing the thin device has holes,
its size is 3G but only about ~77M are used.
The thing is send doesn't support hole punching, so holes are sent as
writes full of zeroes in most cases.

>
> Regards,
> -Ashok.
>

