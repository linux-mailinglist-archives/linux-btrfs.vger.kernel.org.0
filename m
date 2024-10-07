Return-Path: <linux-btrfs+bounces-8589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3854992B2D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 14:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B36E284428
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6475F1D270D;
	Mon,  7 Oct 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0LVl9pk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812591D26E8;
	Mon,  7 Oct 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303135; cv=none; b=e1rH08PZIm5qn1WpG1CCNyFRuFRHzSL1FgsSfdDmo74OOiEQCf86d+BHwMhQPWLP4gxsQ+VmCDrJdbz3tAssuujEDMDQPUnh2C4JzLSR/oCrqX3a6CQH4QY9jB0SkrpsjcMcqD+33PDTPQNSZP7r9LIuQauyHC00RZC4PAQDFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303135; c=relaxed/simple;
	bh=V6yNriPwJca0vuleHIn5JooXjwd+KTF6OF/rmfP/64k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI0+3mMH129KlP2Mz3yAjm3SWcq0QnFsS01iqdATmPKiiE9au6Hsiwi2GDdj096bCeHNWiECIDxqP+CmgwaO0IpI6POe+m2Cem5G1JVcYcM2jqSh6RwB1iuxpxH21GKJenWtuh+BPrPjoJ3y9VaTFBYH44exzNbBmus+/YEFQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0LVl9pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15888C4CECF;
	Mon,  7 Oct 2024 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728303135;
	bh=V6yNriPwJca0vuleHIn5JooXjwd+KTF6OF/rmfP/64k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F0LVl9pklLNuN2KWUjHYd6gsPlgPfvMd1DW0ii2YuioKnlRQPWe3o9VMr+owmX5Sw
	 0A+4gM7PFAtV3hiLsaTsw3r/MrHVSpPyo+Jpfe2LT5qsER2BC/d5RnI2Q3kdlMN/Cp
	 VdFOORYqIDzEEITkQNDX8lc12H+yIGJC2srcWzCHhC8yy+yvV3OhwATntY392VmCXj
	 1RT0NEAsJXkTTs7WkbvctYldHozdmJOay8k/dvQ30ZGFLHXA+1/hlvhxVqxJAfOFQM
	 x9F8moDL6lJWvrBTSzqx8ly2+T1B73ioxp5k1Nj6JA78de1DeeaKElQ6YSQ8InNIso
	 tZ56igG53Ud7A==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a994ecf79e7so157777566b.0;
        Mon, 07 Oct 2024 05:12:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgrwPnMYL7JVy9o5gd7WwUHvoA3OMGfo9TMSN3LtQZP3EL/99cVNWTeaM9S07W0A8QkUBV+Pchq84IKeg=@vger.kernel.org, AJvYcCXfP23u5WN7Zf8pb6iLfNYEwfgwnF5sUtV44I/uPn5a+xIfzV2p/8/a9CnCSE+NbQZ0Akbz1BnI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kLV7XrRxwamgeYlNKZAn0LdDep9J9fT0ucSzR7/zsKyQPjmD
	UGFrY+N7m+l/kAxWSGGVyl+McZ2VMvkFgEbvP3LOmIRw6OzuYTDfueb7aZR8lrWgsDtGWgzz36x
	4TQbt4mjjj9+129c/DSUQCvaQToQ=
X-Google-Smtp-Source: AGHT+IE9DYW9GoqjFT2dlVLrDE64H16Ge4pU6uAWBll7sMmXSRAJH+zzuS6F8NArKK1BuMHwfQrOXNUG1aCTslsoPCU=
X-Received: by 2002:a17:907:94c3:b0:a86:96f5:fa81 with SMTP id
 a640c23a62f3a-a991bd757admr1513080766b.32.1728303133709; Mon, 07 Oct 2024
 05:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com> <20240923133011.cmv63zpd3yg37yw2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240923133011.cmv63zpd3yg37yw2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 7 Oct 2024 13:11:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4f4-3=0OUwYQiFC3hDY=k3SDUsGEJm1S7iro5+pD9yyw@mail.gmail.com>
Message-ID: <CAL3q7H4f4-3=0OUwYQiFC3hDY=k3SDUsGEJm1S7iro5+pD9yyw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/315: update filter to match mount cmd
To: Zorro Lang <zlang@redhat.com>
Cc: An Long <lan@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 2:30=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Mon, Sep 23, 2024 at 03:57:13PM +0800, An Long wrote:
> > Mount error info changed since util-linux v2.40
> > (91ea38e libmount: report failed syscall name).
> > So update _filter_mount_error() to match it.
> >
> > Signed-off-by: An Long <lan@suse.com>
> > ---
> >  tests/btrfs/315 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/btrfs/315 b/tests/btrfs/315
> > index 5852afad..5101a9a3 100755
> > --- a/tests/btrfs/315
> > +++ b/tests/btrfs/315
> > @@ -39,7 +39,11 @@ _filter_mount_error()
> >         # mount: <mnt-point>: fsconfig system call failed: File exists.
> >         # dmesg(1) may have more information after failed mount system
> > call.
> >
> > -       grep -v dmesg | _filter_test_dir | sed -e
> > "s/mount(2)\|fsconfig//g"
> > +       # For util-linux v2.4 and later:
> > +       # mount: <mountpoint>: mount system call failed: File exists.
> > +
> > +       grep -v dmesg | _filter_test_dir | sed -e
> > "s/mount(2)\|fsconfig//g" | \
> > +        sed -E "s/mount( system call failed:)/\1/"
>
> Oh, there's a local _filter_mount_error() in btrfs/315. I thought you can
> change the common helper _filter_error_mount() in common/filter. So maybe
> you can merge this _filter_mount_error into that common helper in another
> patch, then other test cases can use it.

This patch missed the last update.
Was the cleanup to use the filter from common/filter required before
merging this?

Thanks.

>
> Thanks,
> Zorro
>
>
> >  }
> >
> >  seed_device_must_fail()
> > --
> > 2.43.0
> >
> >
>
>

