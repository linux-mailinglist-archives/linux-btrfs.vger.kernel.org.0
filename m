Return-Path: <linux-btrfs+bounces-18537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D062C2AE35
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 10:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11A73A65A3
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353482FABED;
	Mon,  3 Nov 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fsy3k59E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EAB2F28F1
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163837; cv=none; b=Coo3miTaCTQfkPzWIcyVlcuZHkA4236fJY/3YAah8sWsRy1V3Sfk0X2XaWJAirX0uFhj+hisQRb/6xcdXrn2KzrS4mIFNB+RLub2L8sNE7qHIKZBGYPXfUdD5ER4a/Y/bqz8o64RqLRO1pP7sC8CgkcM7WrcnbdO4vjxM5K8QSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163837; c=relaxed/simple;
	bh=vIfnXT/nn4N7g250wJVeVk+QUxKL6NtgDEvE/H88U0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxVLu9fuU9Zh0bSdJrmi5w6qa5L3FU7ljG6GRk2mcORqwYeOQsZy8lMqJPmaFZvGM0asAtxlyIjIUFpOf38lCldRaZbtAejYId7N55rF4/5Id0jwxmuHEjgNGj1ZxGEZFCy6UK77TO8v3XdPcqBgIB1psuFUaQxS20Crj1XdMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fsy3k59E; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4283be7df63so2191587f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Nov 2025 01:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762163832; x=1762768632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsZbBkSZtTjd1hpgBVfJNzfWUOKD6tuDr/JJ6ZVTmlk=;
        b=fsy3k59EYJEzl9Wql2/z4c7acGEuDVCnUdB3SG21dd4Zcz3et6w0C70i7KNjQCn8+U
         sS6AGiwzTncQieiifLXQHf4BDjoRZ6+qytE+iBPQGhI60n2BtJ+WdswqMw40rPfSkhtH
         +VQOrRMjH05HxqfgoPnp5Y40HP+IjEYSji9zNobypg4JIfuYRJYcUlwpnp1CZstLAh+V
         MDlv92/Mxjy/WwOHuuvZrOATOvMCuGipIMB4jG6sBmg0pjd0/gdseLsCD31UvdsuLKTl
         /C1WivqBeRA9Hzxw9u5DeUhKQXMAWWf1Rx56Pspy6saCh0hrSQv4EmUD2/RR5ObCn7y0
         xn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163832; x=1762768632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsZbBkSZtTjd1hpgBVfJNzfWUOKD6tuDr/JJ6ZVTmlk=;
        b=Dg5Vn88vdUqSoB/XV+7Q/5PT/IAFOU+cOlxBxbTLBh5iMHfJd5rjjLiUnZMgFsuF1U
         dIaeD9rkEjjHtS4ZRgBAQjHKcmSdVJwYdbedkA8/ukbIXQa8sif7k/9413Zd8evavJcv
         fHR7AOTuQ7VcSqTrd6DNCkbVRBYBeZO4rombk0apJRg+ROb9/vYMzn3j9Qkz4JA2oSkJ
         1WsMl2JAONw+FJkO5BVhhbPttap/WyggXW2jqndI5hUxl2lB9NcJFufI7fvrhiDzUL+n
         qN/lhucPt+kNE8vQUz48SzFdlOryIHQV3/+ZMLTgNbnzNQmx3iu6WsjwIP9QKQWPZrx1
         VLpg==
X-Forwarded-Encrypted: i=1; AJvYcCWAS27swRJd4wilfoZxw01k4nnNjWLaSGtC0wvHl3eVwoIwR+mlfQP5CxNJtc0+IedS5uBgsnecxMaDmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWO66hU3AtnOqwcI1BJXiybREAAGbX7YwvWpyLmYlKtri0/Gu
	C8Ub+n9y0ySLTFjmmsPZMjBBlRAZ2gDd7L7QwHauFa2WIT3bHJIfmr11C/XY+WXfd/wYObtnLUX
	XAWqMBZh/P+QwDbLffgNKf6cz1FFzmlCdHXzzDyBY0v8Kgn50MTeM
X-Gm-Gg: ASbGncuH4hu0zmngX+HcOyeUAlwionHYvIp0ORSWn5pX3LN8PlcAd1y56poiWW3MvER
	7YQ/fCIaEtel83FVqnHz5jC2mawviqt5HZQYWPkXHtKg4dWS0GKTYjH1vtBSrAYthVG1rBxAO//
	d7Y9DXi/En8c0KCdg57ZR9dxcBCI5nT+Wg6j1nubUICR/Gf9xWFzQGH2EK2JuZbgWAYGkLxgxO4
	BeUgW4vu3Xpl9rMO48tWEAuDrGRz3RA6T+2Q1UhztOJR+F0L7iLL4kP//p6mGd+jFp1u3cDrL8h
	GbLvg+5c+jCrgeCVLBjZRKBA5XdE5IWyCGvXDTentNQuDiuMIK2+2CYIZQ==
X-Google-Smtp-Source: AGHT+IHInPgNf9A1oPfjOlrHKbk6DQafF07DmZ3X2VNhCVaSAou3mL1KCLaikaRZZmlkFYAciiBJFceI2R61e2V/Yb4=
X-Received: by 2002:a05:6000:2482:b0:429:d742:87d8 with SMTP id
 ffacd0b85a97d-429d7428a9emr971502f8f.20.1762163832416; Mon, 03 Nov 2025
 01:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251015121157.1348124-6-neelx@suse.com>
 <66c4393b-51ae-487a-9e14-a444775b9fa4@suse.com>
In-Reply-To: <66c4393b-51ae-487a-9e14-a444775b9fa4@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 3 Nov 2025 10:57:01 +0100
X-Gm-Features: AWmQ_bmv_jSXguF6Wu-lBFFx8fTbaglS_3-izW5rBNQ6zxwPOhO5y9591yKCsMA
Message-ID: <CAPjX3Fe1d3T69E3T__wcH0m8RKXtU=hXZVFRQkMEn2PLxid8Dg@mail.gmail.com>
Subject: Re: [PATCH 5/8] btrfs-progs: interpret encrypted file extents.
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Nov 2025 at 23:26, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/10/15 22:41, Daniel Vacek =E5=86=99=E9=81=93:
> > From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >
> > Encrypted file extents now have the 'encryption' field set to a
> > encryption type plus a context length, and have an extent context
> > appended to the item.  This necessitates adjusting the struct to have a
> > variable-length fscrypt_context member at the end, and printing context=
s
> > if one is provided.
>
> Unfortunately this patch will cause CI failures on fuzzed/crafted images.
>
> The most easy way to trigger it is using misc/032 test case from
> btrfs-progs.
> [...]
> > diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> > index 2a624a1c..060bf997 100644
> > --- a/kernel-shared/print-tree.c
> > +++ b/kernel-shared/print-tree.c
> > @@ -421,6 +421,25 @@ static void compress_type_to_str(u8 compress_type,=
 char *ret)
> >       }
> >   }
> >
> > +static void generate_encryption_string(struct extent_buffer *leaf,
> > +                                    struct btrfs_file_extent_item *fi,
> > +                                    char *ret)
> > +{
> > +     u8 policy =3D btrfs_file_extent_encryption(leaf, fi);
> > +     u32 ctxsize =3D btrfs_file_extent_encryption_ctx_size(leaf, fi);
>
> This is done without proper checks against current item size.
>
> > +     const __u8 *ctx =3D (__u8 *)(leaf->data + btrfs_file_extent_encry=
ption_ctx_offset(fi));
>
> And this can easily lead to read out of the eb boundary.
>
> Overall we need extra tree-checker for the extra encryption info if we
> want to stick to the variable file extent item size idea.
>
> Thus I prefer to put the encryption info into a dedicated key other than
> putting it after btrfs_file_extent_item.

Agreed. I'll do that in the next version.

> So unfortunately I have to remove the series from devel branch for now.
>
> Thanks,
> Qu
>
> > +
> > +     ret +=3D sprintf(ret, "(%hhu, %u", policy, ctxsize);
> > +
> > +     if (ctxsize) {
> > +             int i;
> > +             ret +=3D sprintf(ret, ": context ");
> > +             for (i =3D 0; i < ctxsize; i++)
> > +                     ret +=3D sprintf(ret, "%02hhx", ctx[i]);
> > +     }
> > +     sprintf(ret, ")");
> > +}
> > +
> >   static const char* file_extent_type_to_str(u8 type)
> >   {
> >       switch (type) {
> > @@ -437,9 +456,11 @@ static void print_file_extent_item(struct extent_b=
uffer *eb,
> >   {
> >       unsigned char extent_type =3D btrfs_file_extent_type(eb, fi);
> >       char compress_str[16];
> > +     char encrypt_str[16];
> >
> >       compress_type_to_str(btrfs_file_extent_compression(eb, fi),
> >                            compress_str);
> > +     generate_encryption_string(eb, fi, encrypt_str);
> >
> >       printf("\t\tgeneration %llu type %hhu (%s)\n",
> >                       btrfs_file_extent_generation(eb, fi),
> > @@ -472,6 +493,8 @@ static void print_file_extent_item(struct extent_bu=
ffer *eb,
> >       printf("\t\textent compression %hhu (%s)\n",
> >                       btrfs_file_extent_compression(eb, fi),
> >                       compress_str);
> > +     printf("\t\textent encryption %hhu (%s)\n",
> > +                     btrfs_file_extent_encryption(eb, fi), encrypt_str=
);
> >   }
> >
> >   /* Caller should ensure sizeof(*ret) >=3D 16("DATA|TREE_BLOCK") */
>

