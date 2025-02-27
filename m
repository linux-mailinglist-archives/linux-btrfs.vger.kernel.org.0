Return-Path: <linux-btrfs+bounces-11917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B7A486DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 18:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3334D3AA1FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 17:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEFB1DF73C;
	Thu, 27 Feb 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igg2eB6i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19811DEFEB
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678130; cv=none; b=OhRn2val9TcvDKJEGYHuHiNAShEJ+GImQce5uBAERyip9Vjm6hfaO/36weYSo6EPeVGimcz8urhNczn0Hy/lb8Z4QbyrmZaSufEbwCsP/fFDD4iFsmelXjacqhuSWR7pJpMi6JU1hf2HqJVHqK2CSdw+czQW4e+MrNmQFZ2wLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678130; c=relaxed/simple;
	bh=TuThdLVpl7DrfyPJ0k5DGKyC6FRp1HFVi9wiVN3mKs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mpmesoy7mxUsT0tzY5VwHoFmHog21ILwxcejA02giKkEIoUPx80U2F8z4BdwZQD/iv15rblogaBpS7TIluD6CDvvhye9cSPSf+cP3cHW5gsd9SnmSeshyWee8rKaRGDXaw0zucQCWyAHC7tcj2xg3bAS98e47ZjOPAr2SfoqwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igg2eB6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA15C4CEE9
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678130;
	bh=TuThdLVpl7DrfyPJ0k5DGKyC6FRp1HFVi9wiVN3mKs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=igg2eB6iufSU3seXlNEaXuNN6LHQxQnZwc9XiekHXg5YngKzKmpFZrN0MkDpWNpw/
	 wZ2u5QMs3nX8WteFq/5diM8kYdvlZkDkubNzNhCFpsY7jn8Yfo2m9EuZGfOjfQouSY
	 bK+XKU4Htt1JXYbX/xg4xi9z++v7bKWJ0i/CiOGrVchM2IHpzvtfe4igwxvsUWYFMW
	 j8irGzOeSx6kTDC6M1UaKTtKcenkqpse9DPKiBvrg1a5JniXvHTR+CtdQB1mOHigJV
	 c+OSPcaxCGreKlLO7N0hVZLFVhCRK/EB2+XraKqnJ1sn4jy3tcpbA9K6G254w6U91B
	 fLih8si1R+Nxw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso1952294a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 09:42:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUqwsw5S3yz7pvyytIgAmWYWV/krGH3Ef82jcZu2g1dCPinclPsNOCWByC2gJDn7YlGL9SwpbZaXPUXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwh2AnrfhM1NAa/ovxmAEwdCshHA66MFuBiRVS+mPvNtzbd21I
	2QgwiszLgQMNsZ2ReyNusIvvtWPMAkRbLExUk5hHC2xub0WglZmHSXXgDTbgnyeCtTHuLQGzUjL
	Tc3qeWjqUBtb5KOiROFhTPZzGMPY=
X-Google-Smtp-Source: AGHT+IE0JM/YT+GLbXIPdRZvcTxap0PeTDIeQfDMe5vuaEfjR7yGW2eFnfd3mg37tjACHnw1oYYuNmhXsQnj5pWZf8g=
X-Received: by 2002:a17:907:868d:b0:ab7:d946:99ef with SMTP id
 a640c23a62f3a-abf25fa8e6dmr39021866b.16.1740678128768; Thu, 27 Feb 2025
 09:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6TsUwR7tyKJrZ7w@merlins.org> <20250227170220.GA2202481@zen.localdomain>
 <20250227172113.GA2210558@zen.localdomain> <20250227173323.GD11500@merlins.org>
In-Reply-To: <20250227173323.GD11500@merlins.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Feb 2025 17:41:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4n0Akdk22ecLvdj87mP6iET1F9uUFB1Uzm+t+hCE_DHw@mail.gmail.com>
X-Gm-Features: AQ5f1Jr-FxsJBDKfng95CEixpW8uBZaS7_itLCTFwRNId-vBoRu-dbcPEQfmJeM
Message-ID: <CAL3q7H4n0Akdk22ecLvdj87mP6iET1F9uUFB1Uzm+t+hCE_DHw@mail.gmail.com>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel 6.11.2)
To: Marc MERLIN <marc@merlins.org>
Cc: Boris Burkov <boris@bur.io>, Josef Bacik <josef@toxicpanda.com>, QuWenruo <wqu@suse.com>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	Chris Murphy <lists@colorremedies.com>, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, 
	Roman Mamedov <rm@romanrm.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:33=E2=80=AFPM Marc MERLIN <marc@merlins.org> wrot=
e:
>
> On Thu, Feb 27, 2025 at 09:21:13AM -0800, Boris Burkov wrote:
> > > https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249=
db912a2.1727212293.git.josef@toxicpanda.com/
> > > and
> > > https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876=
637af69.1731513908.git.josef@toxicpanda.com/
> > >
> > > I'll dig through the rest of the emails now, confirm whether you have
> > > the fixes, etc. but just wanted to get that on your radar.
> >
> > Your kernel is 6.11.2 and those fixes went in to 6.12-rc2:
> > https://lore.kernel.org/linux-btrfs/cover.1728050979.git.dsterba@suse.c=
om/
> > and 6.12-rc8:
> > https://lore.kernel.org/linux-btrfs/cover.1731619157.git.dsterba@suse.c=
om/
> >
> > so unless you have backported those fixes, that is almost certainly the=
 issue.
>
> Thanks much Boris, I was not aware of this bug or patch, so indeed I
> will need to merge in the patch.
>
> Not sure if the 6.11 tree is closed or if the patch can also be added
> there. Cc'ing Joseph.
>
> I will merge the patch and report back since I seem to be able to
> reproduce easily.

The patch was backported to 6.11.3, you're on 6.11.2... can't you
update the kernel to 6.11.11 (the last 6.11 stable kernel)?

>
> Marc
> --
> "A mouse is a device used to point at the xterm you want to type in" - A.=
S.R.
>
> Home page: http://marc.merlins.org/
>

