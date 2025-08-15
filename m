Return-Path: <linux-btrfs+bounces-16084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73AB27F28
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C133F1C86BF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F92C3264;
	Fri, 15 Aug 2025 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2YWCn+0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E36225A4F
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257371; cv=none; b=mF85Tb9QsQYJohhrqyXfNP33qVjQVAcQ+R06XUdW1xFTp3SRbFuyAsop2B77u4WNzLSGtvaQVNXT0nxTVffKu25IYNBdc2vUQLppefwPQxdcnMyhHwePOQjMgCfSvITTjcOVqVkETtyBeZYJYE3+xhHQVHsJT0ro+tTlWqeksHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257371; c=relaxed/simple;
	bh=CDeivVsdiDxiaIybHw1zGLcvv+GbA/yoFLfuAvFJfco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVt1ems0uUsgkLwMR1b4S9E1da1a/KzIXQQd0LtwC8nk8TGaJ8MNITnw/E/GHJHFsXtV83tu5cMT06QfMLQveeMdw8jjeche/FeQF76iant9WjhllnITlmdXIlFL6Mesyhs9skZNicIT5FziOesM3eewiVjv+jKoLPNxnA0Zo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2YWCn+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DC4C4CEF0
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257371;
	bh=CDeivVsdiDxiaIybHw1zGLcvv+GbA/yoFLfuAvFJfco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A2YWCn+0v/ZvrVNfe6wamoGgk80P6m4LpN5o9E+EYIxE8WewAf08rlYLBqr6KY5+9
	 BPzNWYdz/pKINDDcfNve3ipYWCfCmXoBhj7WaUr6KEEQdwYrR1ZQCUBZuGE08dd5S7
	 5RIBwlBo1f3Sh7ZdLSBHTIDbKkTiYh3/OQrUxij6AxYbEN8PPN1MhqwfFWfpsaQCME
	 YGAdZiAFGed5sTHFj+iEm86Y3OyYeMHW4YrPTbvqqKdrcTp1IsqopteCsMBepNJgzC
	 y0rH2esupgg2tWSYQ0xYhtW7KWFrkbkhdUOKuAMNvSVjh7tG2qFJXoDvvttYEO0TA2
	 d35vhX9IrQWIg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so271867966b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 04:29:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTy/Tj8bVd8Amk2+rF8b3C8EgYvlrEvFuuGxdw3jHl7lcfQ3Xn2W9tq1CgzHQqV2qLPDyiugbIX//2dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YypCHsMF3x3bmiH5Vn1CSHEXhIB7pl6AJCLQcHIQLz1whU7fC3S
	zdJnyyTqZ69Ubi0dfuJ9mB3h7R0CdWwZSDReV5pbm2XS4eXqWCbBV7RM9/WcBUVHvUW3WKFulOl
	0hZjCQWQgNbnLpFzHdihw+vtvun8Zkr4=
X-Google-Smtp-Source: AGHT+IGVAG18SiScSNpOU+vz3V56Xnm7vBs2R38iuxmeQrTu7eHbDdA0LYkHcal1Wuk1wCxogMwCbiLZerFVr0mW+yY=
X-Received: by 2002:a17:906:4794:b0:af9:618f:83e with SMTP id
 a640c23a62f3a-afcdc288e46mr130772466b.37.1755257369556; Fri, 15 Aug 2025
 04:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJ7YkIlcNnv1YKeh@stanley.mountain> <CAL3q7H60EKQbXUm_cfEY+bsv+SpnYV0uLuVSGNKkgMnHKCkiGg@mail.gmail.com>
 <aJ76KSPQYnatNCAd@stanley.mountain>
In-Reply-To: <aJ76KSPQYnatNCAd@stanley.mountain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 15 Aug 2025 12:28:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H75hyXTf0TU4wd9e=aF--BdaVXNqbixt8CVwmmVv-90NA@mail.gmail.com>
X-Gm-Features: Ac12FXyjzIid-3j3rZBsd9QnV724MaOzIm20FVTj8_4Ld7pl3ioRNMY9FBj0wIw
Message-ID: <CAL3q7H75hyXTf0TU4wd9e=aF--BdaVXNqbixt8CVwmmVv-90NA@mail.gmail.com>
Subject: Re: [bug report] btrfs: abort transaction in the process_one_buffer()
 log tree walk callback
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:13=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Fri, Aug 15, 2025 at 09:28:34AM +0100, Filipe Manana wrote:
> > On Fri, Aug 15, 2025 at 7:50=E2=80=AFAM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >
> > > Hello Filipe Manana,
> > >
> > > This is a semi-automatic email about new static checker warnings.
> > >
> > > Commit f6f79221b128 ("btrfs: abort transaction in the
> > > process_one_buffer() log tree walk callback") from Jul 16, 2025,
> > > leads to the following Smatch complaint:
> > >
> > > fs/btrfs/tree-log.c:377 process_one_buffer() warn: variable dereferen=
ced before check 'trans' (see line 375)
> > > fs/btrfs/tree-log.c:388 process_one_buffer() warn: variable dereferen=
ced before check 'trans' (see line 375)
> > >
> > > fs/btrfs/tree-log.c
> > >    374          if (wc->pin) {
> > >    375                  ret =3D btrfs_pin_extent_for_log_replay(trans=
, eb);
> > >                                                               ^^^^^
> > > The patch adds a dereference
> >
> > False alarm. This already happened before that patch, we didn't check
> > if wc->trans was NULL before calling
> > btrfs_pin_extent_for_log_replay(), and that's fine because if wc->pin
> > is true then trans is not NULL.
> >
>
> To be honest, the deleting the NULL check is the most common way to fix
> a "pointless NULL check after a dereference" warning...

Yes, the NULL checks can be removed inside that if block.
I sent earlier a patch to remove them and it will later be folded into
that commit:

https://lore.kernel.org/linux-btrfs/4629b5fcab544101e9b6f935a7856428abe2f56=
d.1755248327.git.fdmanana@suse.com/



>
> regards,
> dan carpenter
>

