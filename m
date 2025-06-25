Return-Path: <linux-btrfs+bounces-14946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082BAE807B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F773AA8EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46BF27FB10;
	Wed, 25 Jun 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzV4wXFk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D033595D
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849163; cv=none; b=J2ebBkwJdZCnhY6e1V/wDAndtCnqYJuTboPXFkfB9EEUohwihsoep5M2Lwo0ddZvMSu8yfyLCuvrqTLwhku8GGOg5mHBpMEVS8ntuVDdEmvWu8yXIs0Pdzf8Mq+XKoLmGJ0MkT1VqEATsUTntuyxjmqs4K+cuPnUpB4SIdQM41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849163; c=relaxed/simple;
	bh=ndseuXiQkSOeSlYl99qG6OfVDKck5eMwvKMjF4cBD4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojp48sidk+blnre3gEJPEMytzTEe1qVplQ7Z819s4UmA+7RkICrXAx8LPpifDtgkY1Gd9encvvdyjmHB9pBaksFPhGGHNunEhwgqcouL47/mv4AAxx16nZcGfIaSgI4D6kclomCIcO2d9+HfZZpmAJ+lM0fO03ej2TS7vRc0Wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzV4wXFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0ADC4CEEA
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750849162;
	bh=ndseuXiQkSOeSlYl99qG6OfVDKck5eMwvKMjF4cBD4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MzV4wXFkLPxytYzqhqNuqCis0Oicl5raAmaZBUIcxFihiQXLtKlB54RjJ8gpTN615
	 zwAr89D5p/X4wz7FX7OKl9LbbAGRWibwW773qNfXji6hg3kvD714Y2CfK/IxRYaTrB
	 1nQXCyk3X8ItxRCwLS4AkxPNVS7UFfmFtfdB/3dTRtncxe9ouJPXPm7A804LXsvulP
	 Ulqi4j61YF1KKKqxSs6S23xIAhXRBvSYvYthFqvIttL7iThpcuOQthfkaWx27JaIIV
	 Dp2jf8cjHebGIWtCy0yy4qISYXfLob6hIGg37OqPEOTfx1BjXVc0PATTYkWEfstIx1
	 vhZ0lkhHOXk1Q==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so3888293a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 03:59:22 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx8cFxH7h5ay7WdToJBRv7QRlXouA6ZH9xMaG+6Kgg8aSIP112h
	vBv4wW52f6XAT8t5QPECd/SWw0n+MI5MA7jDmsbuiXTvE9X8kwSCv68D1+I3nAyBXYtIsQ15IEC
	JSeoenTm7NI/TdhNohzONBFCxjC3JcoE=
X-Google-Smtp-Source: AGHT+IG7fjeUOdwWpLumD3czS0q1YflpzVrjoU/6HX+s7tu4vkwY2Gw/Og1/GVFf1aeMDHF628wXBIGLj+M+Gw5d1mY=
X-Received: by 2002:a17:907:db0a:b0:ade:4121:8d32 with SMTP id
 a640c23a62f3a-ae0bea938a7mr263513266b.3.1750849161175; Wed, 25 Jun 2025
 03:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750709410.git.fdmanana@suse.com> <78786d6de8f9d4564abaee440ed6260d5c9afd8e.1750709410.git.fdmanana@suse.com>
 <4c76858f-ee2d-4462-9668-d788950ca795@wdc.com>
In-Reply-To: <4c76858f-ee2d-4462-9668-d788950ca795@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 25 Jun 2025 11:58:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H77qpeSaXB+niVXViaNPs=Pnxurm=WNLtUxDfJOea2nkQ@mail.gmail.com>
X-Gm-Features: Ac12FXx4eJXUP5xXFVvaOIqM8id16yNvFICTg6f8COhEDpX891K8GQ0YOkSvws8
Message-ID: <CAL3q7H77qpeSaXB+niVXViaNPs=Pnxurm=WNLtUxDfJOea2nkQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] btrfs: fix missing error handling when searching
 for inode refs during log replay
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 10:45=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 24.06.25 16:56, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > During log replay, at __add_inode_ref(), when we are searching for inod=
e
> > ref keys we totally ignore if btrfs_search_slot() returns an error. Thi=
s
> > may make a log replay succeed when there was an actual error and leave
> > some metadata inconsistency in a subvolume tree. Fix this by checking i=
f
> > an error was returned from btrfs_search_slot() and if so, return it to
> > the caller.
> >
> > Fixes: e02119d5a7b4 ("Btrfs: Add a write ahead tree log to optimize syn=
chronous operations")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/tree-log.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 839252881138..08948803c857 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -1073,7 +1073,9 @@ static inline int __add_inode_ref(struct btrfs_tr=
ans_handle *trans,
> >       search_key.type =3D BTRFS_INODE_REF_KEY;
> >       search_key.offset =3D parent_objectid;
> >       ret =3D btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
> > -     if (ret =3D=3D 0) {
> > +     if (ret < 0) {
> > +             return ret;
> > +     } else if (ret =3D=3D 0) {
>
> Technically the else is not needed after the return.

Yes, but I don't think we have any rule that dictates to not use the else.
Just a matter of personal preference.

Thanks.
>
> Otherwise:
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

