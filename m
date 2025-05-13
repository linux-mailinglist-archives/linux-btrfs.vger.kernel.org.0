Return-Path: <linux-btrfs+bounces-13958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C264AB4D57
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60E117CB90
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ACA1F1908;
	Tue, 13 May 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WyfEMidx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B811E5B94
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122626; cv=none; b=ZXs8fYuQ3FIZQsrz/JLsnU3IWEL6jC8uVPbfqpNQGpYVVq6BrVM4GSuotVgmfxeKoVDetT7njjVHfv22v1xa/NWWdNTFe964j/e/1yqmeEwrz0EpR/YKnDid2C5lMR43PL1gS0wp+3bdSd+08FaaSgyox301m+Gix6BsdFj8MIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122626; c=relaxed/simple;
	bh=krU1Sg3RCwMKkG2EHCWcfC+xnsb9o2PFUa/MAVSJCEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifmY3K9qzMSM216uAUvSe6YK2vwV/9ndjikOVce5A4BO/3EHrzZ15yXrNEcObIV/C+/sSIvG1fJTCXusamygDOIyJrR12yl/HEoGCiXGuY6/76i03PtUTjQqbFgCirdiEKcfj149YcdztCg1VF768/k1f9bwFq43ihzHkEEMQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WyfEMidx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad21c5d9db2so673647766b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747122621; x=1747727421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbx15P5bR+V1GlX7KV4xE3K+3/1ghgzLSbo/fj+Lw3M=;
        b=WyfEMidxE48pECEG6aHQbPwQnLVKTEdjFrg1li7A3F3GYQNpoBQQA+l6W1agUMRMA1
         cE+pquGXDNC/9aoe9BZPDl3tIKyWCbgAhfOgpbtGrU6Bq+UO5upr0J5fu5tfFVY6kPaq
         Gkx7JOvh90Fyk3QjL6ksYZCBJk/FIbvxp4vDa5/IwvwxqVk/2dOrrMEY2gmbGSljaPkB
         c28aAeImvtFnNVBBNgQh/StItLNMCYLvRSslGyBS1866PHeBqiqC8AoESybLUiI4K7IN
         hoUd8RoN0E3Hz6o44q4RuFtBTtAxlVl0RYpLD9st6f7Q93TpJT0dwa/02jXHkuBw51xF
         /tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122621; x=1747727421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbx15P5bR+V1GlX7KV4xE3K+3/1ghgzLSbo/fj+Lw3M=;
        b=plK3MRnZVn+pXfrDlD6ABSHvbM+oAwOUTzp642vMdtIbFr0zG7950wMMldqLhhGYwC
         qNJxJgaud6Dq/ktCoCQ/Alei+OrBSfyo05lH3bk68tnQrwqXf/YKJ8537P94LcI8elW0
         OivsPcgS5pACh1MGIgeYFOL+BApDsA4GV3IabvwlHL3I2xvJsGJs1Ti9xfzL+7lcsygU
         5qGFC344M1jreQfwwIXHuYWYEt7gki2eAbmbM9CHZxt6j7y6zCF26AjgN2oTfZAh5jnF
         /u2o4vQ+om2zTuxYF91SPH17Tm2QBi7mUdcloU+aPCrG7lwMkmNTFq/J9C/Ep+wTnQ0M
         HDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPLG17nQjFbJrOyTILbY1A6Ye71hDWy2Tegulke11Ow+hEKG33W3oTNSKHJ1qRcE1KxDa9bWJ/S74wag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1C2kQwyXcSNDMuOPT314KD++CXaxhfP6pAwListpAn2au2d3p
	GI9lf757jKaYmZavBK/v4bY7bxHENG1lZpdXO5bOQYDqIHHt52exvEI65FVg3h0pHEovSvNgJ/P
	RDeG+uzO/56AJMSR70TXhvE548MIM5qSmlTdDDw==
X-Gm-Gg: ASbGncsDTv51jCB9o8l/7xnSei54zlv25t0KE6blvUA6xP/pH1/+OD2W4pl9TvjDidQ
	LDpuizx3JJH+Fc6ahWY5ZbQjh73C/tLBy8Gi22I6A8wn97qsJuZ1N1uERoKcO88mKQ4IN5SvHGu
	3umUKAOILPsKvG6ci0aPyXJJQRJ4SM1Ks=
X-Google-Smtp-Source: AGHT+IESJNifxjTIWbN+YaTvGiDVixINiLHP3D+SQIGf0ilJ+WDW4SxVXcU8CZ4FaumUN8fK3f7r4RyGjM5M61BADus=
X-Received: by 2002:a17:907:3f1b:b0:ad2:51d8:7930 with SMTP id
 a640c23a62f3a-ad251d87b27mr699367966b.12.1747122621134; Tue, 13 May 2025
 00:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512132850.2973032-1-neelx@suse.com> <20250512175353.GA3472716@zen.localdomain>
In-Reply-To: <20250512175353.GA3472716@zen.localdomain>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 13 May 2025 09:50:10 +0200
X-Gm-Features: AX0GCFvpOlnDoiBFJ9GVPix74qGApiZGAyvW8-mPyHiTR65notxoBWDkhFW8lGU
Message-ID: <CAPjX3FeEvwkKWPB+DqZYufmjyAuyXxzHmtL+S6z7o971=yMxWw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: correct the assert for subpage case
To: Boris Burkov <boris@bur.io>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 19:53, Boris Burkov <boris@bur.io> wrote:
>
> On Mon, May 12, 2025 at 03:28:50PM +0200, Daniel Vacek wrote:
> > The assert is only true in !subpage case. We can either fix it this way
> > or completely remove it.
> >
> > This fixes and should be folded into:
> >       btrfs: fix broken drop_caches on extent buffer folios
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
>
> I would lean towards removing it, personally. But LGTM, thanks.

Good. Let's remove it then. Will you amend your patch?

> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > ---
> >  fs/btrfs/extent_io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 80a8563a25add..3b3f73894ffe2 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3411,7 +3411,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >                       continue;
> >               }
> >
> > -             ASSERT(!folio_test_private(folio));
> > +             ASSERT(!btrfs_meta_is_subpage(fs_info) && !folio_test_private(folio));
> >               folio_put(folio);
> >               eb->folios[i] = NULL;
> >       }
> > --
> > 2.47.2
> >

