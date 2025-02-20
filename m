Return-Path: <linux-btrfs+bounces-11671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98CEA3E3BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 19:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F240F70062A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC62144C3;
	Thu, 20 Feb 2025 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUJHyxPm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9A213E6E;
	Thu, 20 Feb 2025 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075816; cv=none; b=vEH7dyd600aiJOoBIxoYVh1liWWBCmu9QReqzGjmFfBfeReEfovn7q9RlVKvejg+ITjiMCqEXG+heHKX94qFJdpM+T46NvBVwaxvV0GON99Xck/jk6cfDkfZnKWvfU0EZb1PA619gijQNrxxg3o8TBLCIVXJMkGKGvhRyH5xm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075816; c=relaxed/simple;
	bh=bGRsuGCjBaxlke4IY42bXBVPlj0MwrjZiMm/l5TxlHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sn5xN+VGckHYsZ6+i+8kccWyFRRUedNo1rqzJRX+liH8yowPQbyE8ReD7kEG8pk7INKPp34PKXu08RndoitCzNIoCCwvXuWocsPMUuTplusX3Vufov+anmjunAMy7ZD8jf4fWeOezFbFd8DXbK4d5w/KiHK8a/89SxvRZTC1xLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUJHyxPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC56C4CEE2;
	Thu, 20 Feb 2025 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075815;
	bh=bGRsuGCjBaxlke4IY42bXBVPlj0MwrjZiMm/l5TxlHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LUJHyxPmMwBeFlE2MW6Aa4IcUZAVJcmhBuL4nP9xupp0MCB0JLa0NRzY/FkAeCD6q
	 ioZGeNd4pXZxe2+H4Ha2pS9nXqyIROAs+4QzPFGOwLW9+x3k61wY3VHINv2PumU6mO
	 ojpTveZxyiJZ5zt3t60IU8L/VrqiWiL+qy71PuNEGh0Gnf9k1nFL64QSTJAf9+NzWB
	 XOw86mrQaIfoR61ZVvtEW8GqP/3ELLC30gYQrQWWFlQKhKctmYgZ4qxYPgypreWhar
	 +X9nxqdMB8PGUoOsIHK58iVNgBkhexkMtFhtZdvcviS/DG/xnyjjF5slFsTGPiyP5Q
	 b2DN0PORYt+qg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb7f539c35so260044366b.1;
        Thu, 20 Feb 2025 10:23:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgkFSESP8qEyJO/xsTUIffweebIay0Bl3Lds6RlnFi1xDQtdzpcTsCRYgGAX8O22R9jcLuD9VY@vger.kernel.org, AJvYcCXT3HgoJpTGSc/5lxeyMt3BBbmFjVaznH2ETM2kk3A81wallLTkykEpPsAHgQkTAgXXipMzCnAQNDfRq2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFE4dTHEnqvKnxWIMQCOUTK1/N0o89C2apnpoWwee2d4/sg7+l
	VHSlv/QjNRvvoGPB7dfPrA2buYPSk2Vx0/aCycwcDeIbF6i3zOr1vlraiG9ZAZDIAZNSA/U7Q1F
	0TjLHqBLnkD8Fy53PJ82ts9NjB6U=
X-Google-Smtp-Source: AGHT+IHBEMCjuYLgwwSiZhMz1RYFkLx2xXuRM9jCSE4/Z1LuyLW3SrVGXm7UG33uEJp2hEczhkXZb+x6bievDGOwP00=
X-Received: by 2002:a17:907:7214:b0:ab7:d801:86a7 with SMTP id
 a640c23a62f3a-abc099b847amr38506766b.3.1740075814280; Thu, 20 Feb 2025
 10:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739989076.git.fdmanana@suse.com> <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com> <20250220170333.GV21799@frogsfrogsfrogs>
In-Reply-To: <20250220170333.GV21799@frogsfrogsfrogs>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 20 Feb 2025 18:22:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
X-Gm-Features: AWEUYZmkkQ6iKDCeLBhCsgmegiWibgSWGodk-YAj_vDV-_cbqHDvJajqHWVKwtQ
Message-ID: <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of failure/interruption
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 5:03=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Feb 20, 2025 at 01:27:32PM +0800, Anand Jain wrote:
> > On 20/2/25 02:19, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > If the test fails or is interrupted after mounting $scratch_dev3 insi=
de
> > > the test filesystem and before unmounting at test_add_device(), we le=
ave
> > > without being unable to unmount the test filesystem since it has a mo=
unt
> > > inside it. This results in the need to manually unmount $scratch_dev3=
,
> > > otherwise a subsequent run of fstests fails since the unmount of the
> > > test device fails with -EBUSY.
> > >
> > > Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
> > > function.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >   tests/btrfs/254 | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tests/btrfs/254 b/tests/btrfs/254
> > > index d9c9eea9..6523389b 100755
> > > --- a/tests/btrfs/254
> > > +++ b/tests/btrfs/254
> > > @@ -21,6 +21,7 @@ _cleanup()
> > >   {
> > >     cd /
> > >     rm -f $tmp.*
> > > +   $UMOUNT_PROG $seq_mnt > /dev/null 2>&1
>
> This should use the _unmount helper that's in for-next.

Sure, it does the same, except that it redirects stdout and stderr to
$seqres.full.

Some tests are still calling  $UMOUNT_PROG directly. And that's often
what we want, so that if umount fails we get a mismatch with the
golden output instead of ignoring the failure.
But in this case it's fine.

Anand, since you've already merged this patch into your repo, can you
please replace that line with the following?

_unmount $seq_mnt

Thanks.

>
> --D
>
> > >     rm -rf $seq_mnt > /dev/null 2>&1
> > >     cleanup_dmdev
> > >   }
> >
> >
> > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> >
> >
> >

