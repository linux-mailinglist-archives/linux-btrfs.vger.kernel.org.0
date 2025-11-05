Return-Path: <linux-btrfs+bounces-18720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C28C34548
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 08:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FE642247A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 07:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CD28C035;
	Wed,  5 Nov 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tf75jm8L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E113BC0C
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328809; cv=none; b=Vro6AwXtQ5Ez5wU4MVYStY4VbuWD/jTEcbZbnwIzyEYMGfM5gxZeuXMjWG7VcyE9UtUXws2VQPN2vSV7u5rJB70W1xTPOpNup2dVjt4kFWL7159SNdlOq9U57E5U90pSAh5MHhtpNJIRrM8/khBUiQhI1nPf5csgaBUqMkj0haQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328809; c=relaxed/simple;
	bh=edR5vpfjTyxPCQhW/8UKNjpfkt72UaXrgDsrO1C1KQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHlQBS9eQYO4ExexxnA2ywLv4dDJ1fJWV95FaUlOPdmX+g8TBT7V5Uw8mvAlKPZtc/AwDZXYNHXQP/phAF5zRq2z8UBO8yHR50YzWS6d8GlpoQcWW5P7ZTz2qLv2VI2eseqXIHffjha33A8c/msslwYoK7aoTl2HA+R/3R9HSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tf75jm8L; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775ae77516so9427165e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Nov 2025 23:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762328805; x=1762933605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TJu1b+3/YSoza5NYtLgfbc1ZBehafOVkr3zt5ciT+U=;
        b=Tf75jm8LF52ob90/Fd4TEpj5xrXgUUU/WhYg6BqBqG3U/ZKCmyrmRuyGIclGkBxeqo
         eoJIDV+Z6yNIg44L3KPUnP9SU+auu5yVXm3hML2lM/XoZuk5ZMIc/7UIeKfRoCTDmgfu
         Y6At0mbuWnokyxXM62nZ33jAPtpwdgEEkwmt6gQdRYwzI0c0LbWdj8OLSkAJAazqjSMy
         BiAWaTv+DVKiRydNhUKNKWv3ZKw4liJE2xGOrmerdlZBht1GLxFEe+adVdIaawEhyyDh
         9ck9QYzN+KFURe+/iHK8rECug+Tpn3jL/4/OpxUthGeD9uuoSf6xJXBdawK0SzONgxnz
         Rhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328805; x=1762933605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TJu1b+3/YSoza5NYtLgfbc1ZBehafOVkr3zt5ciT+U=;
        b=XkuACrsa3XfrJhERir8TD3KBsgxAGdUFtEvwaduQHjrsLSOZy16ZwhU8aUY7uNYRpA
         1+0bow4o5MpVNVGoK4B8DwGrCwJXod+e6bg2EFQgi5A7ElTOGgWZiEGy+S/OCsH4///s
         JFRyRWzwIw5htG91th2DvuYu/CskzgHHocT2B07UZSdkUXZwoyiyTrwKjeTZToaEeLwA
         IkepCVFsTxvuhFBaEQg1GJD+bfNDzdm/6zOS0smnXFONapubDX624K8mC/sP5XwhtQ0L
         7dOa9ipDtIxYIdUucnqE21zx/87v3uSySckuv7hK6kfsimxMlkXUQKqwU64gbGBEDY31
         bxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKU/3DqrZUzmy0OQ84kn6T/RuFbK1qJmzFCBEcbxPl7cQJFh9KMJUrvsLzENod3fO5k9w3SihwE/+rDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1qQjRAwH3L8LTB3VzWb34I1qxMoL15WMU02ucB4S+bTHAKSX
	qR3bXCxrt8sKJIXX5xZ5okGgBeAYdiIJJMhPPyfWTf77Fdc0O3u5oB5UNb7gc1oPPW8IVWzC8t8
	N002A5yJxjXVowYlV/QwKyJnMIxSnHKerX1rZZaTq+A==
X-Gm-Gg: ASbGncunVos6in/NcITwpVmnZdeucDSJSdqvSVxA1SeMH17ZPHqK1FnJsBzK6+ApYz5
	8bwNbhnsUOrclxsIlgy6v9gzYjabObf6xo16ge6jb/+8P48YxMhXNCBvFL38RTNvQ63Sm6SAXYk
	VOkLbzK+bDH8w9Ohk6Jc6wcJbXOWxgXgP4fJdWhbBQmSPu8vFVm0cgKxsnANGgQl6HWInIcHp2D
	6rprOTsRlP7w3c/6w7qj4qVNCbdy3FqwGR6GFsqaPw1tTUuXJHbZOk3jlR16tsNvpgtgRYHIb38
	ihZq/vWls4+XHEJmDx+DQDUshhq4qtl77OwoqHxLomBME5y54TlyMtdp8Q==
X-Google-Smtp-Source: AGHT+IGXbZ8pwX1WuYUcbJPXGesaytgGdOMIeXadc5AsjGUlh33VxKw3yPS6BvuxuTo50coHejEL9clZvN2DX9O0tMc=
X-Received: by 2002:a05:600c:310c:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-4775cdac841mr17712775e9.7.1762328805021; Tue, 04 Nov 2025
 23:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251015121157.1348124-6-neelx@suse.com>
 <66c4393b-51ae-487a-9e14-a444775b9fa4@suse.com> <CAPjX3Fe1d3T69E3T__wcH0m8RKXtU=hXZVFRQkMEn2PLxid8Dg@mail.gmail.com>
In-Reply-To: <CAPjX3Fe1d3T69E3T__wcH0m8RKXtU=hXZVFRQkMEn2PLxid8Dg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 08:46:34 +0100
X-Gm-Features: AWmQ_blrR9Xd_M36OxT8YzankIYS2xvhKyYj0dbmI0s6dKhpsHzru8uJFXQmip0
Message-ID: <CAPjX3FfJT5FFYucwh5KkGrtgVg00=93rtDLqWm8S1Ei0=cZEgQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] btrfs-progs: interpret encrypted file extents.
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Nov 2025 at 10:57, Daniel Vacek <neelx@suse.com> wrote:
>
> On Sun, 2 Nov 2025 at 23:26, Qu Wenruo <wqu@suse.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2025/10/15 22:41, Daniel Vacek =E5=86=99=E9=81=93:
> > > From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > >
> > > Encrypted file extents now have the 'encryption' field set to a
> > > encryption type plus a context length, and have an extent context
> > > appended to the item.  This necessitates adjusting the struct to have=
 a
> > > variable-length fscrypt_context member at the end, and printing conte=
xts
> > > if one is provided.
> >
> > Unfortunately this patch will cause CI failures on fuzzed/crafted image=
s.
> >
> > The most easy way to trigger it is using misc/032 test case from
> > btrfs-progs.
> > [...]
> > > diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> > > index 2a624a1c..060bf997 100644
> > > --- a/kernel-shared/print-tree.c
> > > +++ b/kernel-shared/print-tree.c
> > > @@ -421,6 +421,25 @@ static void compress_type_to_str(u8 compress_typ=
e, char *ret)
> > >       }
> > >   }
> > >
> > > +static void generate_encryption_string(struct extent_buffer *leaf,
> > > +                                    struct btrfs_file_extent_item *f=
i,
> > > +                                    char *ret)
> > > +{
> > > +     u8 policy =3D btrfs_file_extent_encryption(leaf, fi);
> > > +     u32 ctxsize =3D btrfs_file_extent_encryption_ctx_size(leaf, fi)=
;
> >
> > This is done without proper checks against current item size.
> >
> > > +     const __u8 *ctx =3D (__u8 *)(leaf->data + btrfs_file_extent_enc=
ryption_ctx_offset(fi));
> >
> > And this can easily lead to read out of the eb boundary.
> >
> > Overall we need extra tree-checker for the extra encryption info if we
> > want to stick to the variable file extent item size idea.
> >
> > Thus I prefer to put the encryption info into a dedicated key other tha=
n
> > putting it after btrfs_file_extent_item.
>
> Agreed. I'll do that in the next version.

Checking details about file extent item, it's already variable size in
case of inline data and the data are stored right after the structure
(more precisely the file data starts in the middle of the structure,
overlapping the members which are unused in case of inline extent -
this way the final item size can end up even shorter than the
btrfs_file_extent_item structure size).

With that respect using the same approach for the encryption context
in case of regular extent seems viable to me.

Validation of the size and offset should be added for sure.

> > So unfortunately I have to remove the series from devel branch for now.
> >
> > Thanks,
> > Qu
> >
> > > +
> > > +     ret +=3D sprintf(ret, "(%hhu, %u", policy, ctxsize);
> > > +
> > > +     if (ctxsize) {
> > > +             int i;
> > > +             ret +=3D sprintf(ret, ": context ");
> > > +             for (i =3D 0; i < ctxsize; i++)
> > > +                     ret +=3D sprintf(ret, "%02hhx", ctx[i]);
> > > +     }
> > > +     sprintf(ret, ")");
> > > +}
> > > +
> > >   static const char* file_extent_type_to_str(u8 type)
> > >   {
> > >       switch (type) {
> > > @@ -437,9 +456,11 @@ static void print_file_extent_item(struct extent=
_buffer *eb,
> > >   {
> > >       unsigned char extent_type =3D btrfs_file_extent_type(eb, fi);
> > >       char compress_str[16];
> > > +     char encrypt_str[16];
> > >
> > >       compress_type_to_str(btrfs_file_extent_compression(eb, fi),
> > >                            compress_str);
> > > +     generate_encryption_string(eb, fi, encrypt_str);
> > >
> > >       printf("\t\tgeneration %llu type %hhu (%s)\n",
> > >                       btrfs_file_extent_generation(eb, fi),
> > > @@ -472,6 +493,8 @@ static void print_file_extent_item(struct extent_=
buffer *eb,
> > >       printf("\t\textent compression %hhu (%s)\n",
> > >                       btrfs_file_extent_compression(eb, fi),
> > >                       compress_str);
> > > +     printf("\t\textent encryption %hhu (%s)\n",
> > > +                     btrfs_file_extent_encryption(eb, fi), encrypt_s=
tr);
> > >   }
> > >
> > >   /* Caller should ensure sizeof(*ret) >=3D 16("DATA|TREE_BLOCK") */
> >

