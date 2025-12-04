Return-Path: <linux-btrfs+bounces-19530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E69CA5618
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 21:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD1EA315F737
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781D32695D;
	Thu,  4 Dec 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXqTKca8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B13325491
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881475; cv=none; b=bVTg6Op6QSbfWE1IX/iAE42Fn483IcSekt8o0rsD8IqhmliVR1qqxHCfeT/bEiQ2HDqWTydngWVAmDiRdxiTaQgUBgcq1BjmJ8045tiX2R50hL6V3BkgnsagBlw0tz8Goxi4sFQZA5QE6GkFxMvINtAtZmBxnvc7D+Arry4bGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881475; c=relaxed/simple;
	bh=qStRwU3cLntJjUZlqULxIdT4n+7gbhFNns/LaMGRiJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lou9zoZc6EIBcYV5MFc1Gtvpjd7B/SHNfaNnfgVyRthxVADN5n95KWj02PD81ATLCtL1xWGEF9YT2O7BGtogik53S4BgcfEraK88+iprE/0phLnfK/A93dFctxftsMQxcnLS2I1AP41phc2SIaZe2fPiQnuGXh8EZCdcEZLqmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXqTKca8; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b735b7326e5so244901466b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Dec 2025 12:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764881471; x=1765486271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZH+D16UoYb8doKRnFG/JQvXCEGP29ibkCYAyKitbHA=;
        b=nXqTKca85tOtD0x3fC2hEHvIIzwfgnh6HFVr6g8IDqBE2FRIZqr5yN/LCvfp3iQYdg
         MxSHZjzRwTg1YVg+oqUSXI8AFQ+WM5I99TeShS+x0iOM9oCmcvM25nhTSebwnKfolNFj
         brs3Lq/vS0jpq72aEG+7Y5+kHds4GZl+D6Ra4xaQc3Hr4odc3UAcedy/WKTmTTICPZxd
         Bfy9fRwPpaa3uMpRSIa5Nnwny4Z7ISonprjllfoBGu30C42yJa2hISNoA/IDZ9LEHOui
         xOvlNPtMMUfN2rYW5H+yP0JWQw+Ey2+shImIDO2729Dfr8e0wyUbtWAEePz7pHn/+PfR
         CKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764881471; x=1765486271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZH+D16UoYb8doKRnFG/JQvXCEGP29ibkCYAyKitbHA=;
        b=YE/91emBY00iFD9t7h8kHjsxyykKhnTcIDM8eg52VEYStwcZ71vkCJCWCcntDZeCby
         bcwDPVL0V0nHA8BoMB5pib/xSCMNSyvvx0Rnd/GUvTA4jT8GP8lM1C82IU0RJQkDdtPn
         iiwU/9qR785ULyPZ7NdwBxHkjApR8CvYgGqaY/MT8Hjj5SXRdHrHd/dQZbPKXS0ndXwk
         pO2nQpBL5V32q4e8m+yt26hASdoFLdPe9U1EQAY/9TR23kp3G5LWUeYF4B8pXXAFKmEA
         bWJ/UDmz6+OEJvmees1IK8fz6eI9aW80aanCUKBNivFDTdt4yvYJcefpizncJxFwQF1t
         /Z/A==
X-Forwarded-Encrypted: i=1; AJvYcCV1tZIDfMTR6O+joFZvaSCsdp3YaqScfiirUoAKgNto6UmFzZzshudCxNqLyJc3Fowmi739ObIDwdMhew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8ObOdBg0AiFUSZLyjPivRpMFsRX0Wr0mGwX7Jc752Vck7Y09
	gj6+sjbXqENA6Hx44Grv8cWo9e49/nawjx1Om4kaRc+DJTaXJtpbDbN9DpkxyyZMmUOVYr46ISQ
	NGSPsAVV8lvLJmQQCNI5DT1B4XCUZN+LaiTmgn7I=
X-Gm-Gg: ASbGncuVZUb7AStS4PCxljU6EjY3x7xcFnoOEnTsctvb0S1fanMPDN4moKP6q8W9TLs
	3ozrs2FOuS+SXVffMXPlf30NIa45/K8nV4vs7Rf6D18w7CCLUHZPg+mJREAvp0u6CoCb5Tkh4m9
	uwzl5njS56Js51/Ea9eDR753f1uJdiehx+lqjYuXQRxmnRucPzwjbR4qxfLr9B/PamEYJRHhKVo
	ENsa+Dv7P2b/88CtW3eVZypVq7vWNHedpk/T2EsKCRS4mZVSAlLcl6vtc8rqtrjAZ9/
X-Google-Smtp-Source: AGHT+IGDIg6FQbjAtZaT5HsWNQbQk0YasQgl8pQJnaomUsT6faEz/DPedPOXi38PmoJsSTjdAIepT+9VM09mUlzwd6I=
X-Received: by 2002:a17:907:9725:b0:b79:cbbf:7b09 with SMTP id
 a640c23a62f3a-b79eb5d8013mr541401466b.15.1764881471111; Thu, 04 Dec 2025
 12:51:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128174804.293605-1-mpellizzer.dev@gmail.com> <20251203212145.GC3589713@zen.localdomain>
In-Reply-To: <20251203212145.GC3589713@zen.localdomain>
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Date: Thu, 4 Dec 2025 21:51:00 +0100
X-Gm-Features: AWmQ_blCdeefseGUKBr5m-W1tllc8Pmn58vZCk4DhLvy1elZSCIrrkSGWQ0pPGo
Message-ID: <CALUEkOes_HJnWDbM0wHOiU6s0VVL3twQUwkxg+yzt4-OBz1YMw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove dead assignment in prepare_one_folio()
To: Boris Burkov <boris@bur.io>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 10:21=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Nov 28, 2025 at 05:47:55PM +0000, Massimiliano Pellizzer wrote:
> > In the error path of prepare_one_folio(), we assign ret =3D 0
> > before jumping to the again label to retry the operation.
> > However, ret is immediately overwritten by
> > ret =3D set_folio_extent_mapped(folio).
> >
> > The zero assignment is never observerd by any code path,
> > therefore it can be safely removed.
> >
> > No functional change.
>
> This looks fine to me. But given the fact that we are setting ret =3D 0
> before entering the again: loop, this code is maintaining that
> (unneeded) invariant. So I think we should remove both or neither.
>
> I would lean towards removing both, but I don't feel strongly about it.
>
> Thanks,
> Boris
>

Hi Boris,

Good point. You are right, both assignments serve no purpose
since ret is immediately overwritten after the again label.

I'll send a v2 that removes both the initialization and the assignment
before the goto.

Thanks for the review,
Massimiliano

> >
> > Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
> > ---
> >  fs/btrfs/file.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 7a501e73d880..7d875aa261d1 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -877,7 +877,6 @@ static noinline int prepare_one_folio(struct inode =
*inode, struct folio **folio_
> >               /* The folio is already unlocked. */
> >               folio_put(folio);
> >               if (!nowait && ret =3D=3D -EAGAIN) {
> > -                     ret =3D 0;
> >                       goto again;
> >               }
> >               return ret;
> > --
> > 2.51.0
> >

