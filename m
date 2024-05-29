Return-Path: <linux-btrfs+bounces-5352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F296D8D3733
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 15:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBFF1C20D78
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E94E576;
	Wed, 29 May 2024 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwVxwnNx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11CDDAD
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988280; cv=none; b=MhnJWLXdJeZpKCe3wF1fX9gbGal2qQJWyO1VnavX5SHifDH4HLE6vQnGowCklmHS8SXRgqGk2Z8BMBODFa/weTrKJ8BC7z8Sk4/4xiPwpYgMDeYjAXjgLIHbODyIxl2p0pU9Qh9wWF3FRolYpF89NYdXIDJhuukT2xnAlrMOirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988280; c=relaxed/simple;
	bh=QZp74ROHFmKWb9OQK9JMHn6Q6kxJbW+xd9i4+GxFIdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1rsxSzAdt2ck7t6ReFDmnGhzztDAEgivKh1E8TgDj+hcj9DviSRyM99K/x+Qim7FyW06HReh/1cj8/mYMB58g098cpw1B022MlxcFDqh/qaVdhkf3LYqfA2XoxyYBO38PNqMfyTZnaOOcl9jgz5YGoremuJqEI37BEg+0ZXTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwVxwnNx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a033c2e9fso1140943a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716988278; x=1717593078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccPGwUk8Cu1wb0Kh7iyrKILbOcObgFFDFAEwXw1odPA=;
        b=fwVxwnNxH1uOryeFo8KYlERsr8IEBPfdEuGvLJd0YuygSbRtAb2T6i1tal0B7dOapi
         yRb3rSmOVd2A2xPEp+3MyNxnlldC5f2bPMpGzywZiXFK0AakrP6PKVJknX8wmXvaZ0vh
         qIgJE6HgaBSaa3TkJwj8ZZJeI+uHnaKuU05yVShJ7VMvUOws7JLzv0qWqt7kYF6vM/lg
         H2Nphy/8r6FosrARvUvd1bDl45amvM2LchHY3kaWb+MCJ0SCghsH+EVQXIie1RelI35j
         aQi1adx0VDE+iJc8Ge2aZSZaHaj9xyVTkNIJqmNIOoPEjRtaZV6YqCKiUWYrpDeo1EDY
         SeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716988278; x=1717593078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccPGwUk8Cu1wb0Kh7iyrKILbOcObgFFDFAEwXw1odPA=;
        b=WpdaVDMD6TyE1bWDuya9Tls9UP/yK+anZL5Bi1rgwgJgMCzsb9tD9Vizds/W6T3+CG
         4SsW0b6xR7HYCsNsjSBgALbrg0W7T8vP7KBoLdSgk96LLqg9VqU9eoBVb3BNPe8CtNi3
         M7RcTo+aD1vfQtDyWthXa/MLZdCziCGy5U/UNSB60m3vdj1G35y+RYsbQWjeP5t8WsND
         5XPIuyKAFa3+H0otoMYmb/GRHgQyxh+kKCBEfOXEbJVo3Mk8as3Kptf05w0H9YK/sVU8
         tvFrFHgouzvsOTNipMt5iv4AGehnEjJThcnlytAFK12vl75hXITzzUZXD33awkpEWbzT
         gpWQ==
X-Gm-Message-State: AOJu0Yy4YCQE4niMWBmvfyDkFcK+kE/4iRC9vsaVUJmigD0pclGyC2pc
	C5IQ+aRJ3/HdA+z95vWsE3cxJ8/9y9k1tb1FOeycr+Hb2uL/NrEOTcIEbMxbvrXuQoQKcG9k0rz
	f6tuHSMZM6zgI39BAPkHCdtwAno8=
X-Google-Smtp-Source: AGHT+IF/EidELD9L7mGusdGyQUgoCp9rC7xLxufMBXqeRieuNqeOeGkEC5Q1R3dTL3EV7Hcx+YrAPbEgco2BkstpjSw=
X-Received: by 2002:a50:9f6a:0:b0:579:a956:76fd with SMTP id
 4fb4d7f45d1cf-579a95677d4mr12103307a12.8.1716988277478; Wed, 29 May 2024
 06:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528062343.795139-1-sunjunchao2870@gmail.com> <42631f4d-97ca-4f7b-a851-c06383b35065@gmx.com>
In-Reply-To: <42631f4d-97ca-4f7b-a851-c06383b35065@gmx.com>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Wed, 29 May 2024 21:11:05 +0800
Message-ID: <CAHB1NaidZ1WjkpshMC3zWwX1_3nL3AULG46fc4gmygb9TAa82A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: delete a todo about using kmem cache to
 alloc structure
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C 14:42=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =E5=9C=A8 2024/5/28 15:53, Junchao Sun =E5=86=99=E9=81=93:
> > Generic slub works fine so far. And it's not necessary to create a
> > dedicated kmem cache and leave it unused if quotas are disabled.
> > So let's delete the todo line.
> >
> > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> My bad, at the time of writing I didn't notice that qgroup is not always
> enabled.
>
> > Furthermore nowadays squota won't utilize that structure either, making
> > it less meaningful to go kmemcache.
Thank you for your further explanation. By the way, is there anything
meaningful todo? I saw some in code, but I can't ensure if they are
still meaningful. I'd like to try contributing to btrfs and improve my
understanding of it.
Also, is it a meaningful to view the contents of snapshots without
rolling them back? The company I work for is considering implementing
it recently...
>
> Thanks,
> Qu
> > ---
> >   fs/btrfs/qgroup.h | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> > index 706640be0ec2..7874c972029c 100644
> > --- a/fs/btrfs/qgroup.h
> > +++ b/fs/btrfs/qgroup.h
> > @@ -123,7 +123,6 @@ struct btrfs_inode;
> >
> >   /*
> >    * Record a dirty extent, and info qgroup to update quota on it
> > - * TODO: Use kmem cache to alloc it.
> >    */
> >   struct btrfs_qgroup_extent_record {
> >       struct rb_node node;

