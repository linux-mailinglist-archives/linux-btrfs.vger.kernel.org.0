Return-Path: <linux-btrfs+bounces-13548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD2AA4C1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD641BA0ACE
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E525B25E445;
	Wed, 30 Apr 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gDEA+84Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72325A642
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017637; cv=none; b=uY2rvBvbBo7pwZ68VdJPWJg+XJomTmgQSHvoigWbbF+FfvG4PPOzD29uBL5Xp0JGt+kQmYEmie8N6NaKlzjT8zic433ehjknoxAvSjcuWD/tYjptb3TcTwT1zPXwZ+WM9bzAYDDbZtH7jro1wXlK9J88h/qkVmw7Y2hJHEDHNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017637; c=relaxed/simple;
	bh=0Gcyv0t7u3IFe4ds+zRFzU+eMDj6dYuG9QCJ+3jJn2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmNTqsL5rLcjYz3G5qdv1QE0VEe3JvqRtEOIZ2F1DnXBc6fdPUFNqaqt/hHvWLIGkawrAfbG/M97iQ5M1XoDEym+zpD+xWfIQwkaG1CxuTROehFKesps7WS31OjgSCqCcjn4EvHQacXmOlx0xIQ96ZhFnHrVXbeszZClLkq2U+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gDEA+84Q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac7bd86f637so172843066b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746017633; x=1746622433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU1/SOmNaSIoaOP5Y27zEp7SD6Xio7q26DsiVHZeov4=;
        b=gDEA+84QbiZBRrmRjLqiJ0p4e1w3lHznRInkERl8sy+ZIh1UxEI08qXPaO8leuIBDB
         RdGqD8HSCErKPB3p8YfVgiONfXc1A3C/CPS12bhoCI8pQXGS2N8b0hibBLgXhhojcgqR
         tn0W6WI9D3VzmFBf2bIbo7UvWJvO3C7eDta4uqnexx2KZBCgFPk7l2UmJ6LO/qoTvbr4
         TJWNGmjuDe3wvJ9o49G1RK0A0qC6XsaCP12K8r00pnRFBlCa+P0+QsFX67rfCI10EqDF
         2publKEpaeat24k2yCWVY/UP+1Pi/1eaH5kEbShB5TF4MdYaIWSeynWaRFHYJByChctb
         6pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017633; x=1746622433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jU1/SOmNaSIoaOP5Y27zEp7SD6Xio7q26DsiVHZeov4=;
        b=dyPjZJVnYJk/Jf0RRRglvWQ1+uQi5Oj6tx0JWzNRUjCeJWMou4mUnFqTMfvoNW+s90
         SK3bS3TYPHivr07VyzXMelRGyPlJ3jjR2IRozKrrtddQMnbUqtqsIrLfro2E5HapmDix
         mUAM9fLZHu12rLXboErDPGyGjEYYd7QMkElflBVLU18nsLDDg7S5YjxW5sY7Yi+LFhTR
         IebDIB90LQaExrrt+Pqxfdb12cfQpoNHyKmtPww3Gj1o3dzFwFg56rhaVd864ulneuTd
         n02E/r6/x+njYZR23qqZu6C1xcruy5wF3IJSv3dej2EwlIw4Dpp24Ge6K05z0KD74lJk
         YhYg==
X-Forwarded-Encrypted: i=1; AJvYcCW+NSVJm8cbE6fpANKKU1J6NnDRAKso6Z9mPup4Rf7ypLAbJhFnxruU1zZOpi1nx+gSjSQSozaAqOm5mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nzm1FcSRVJfqA93jkJvyef6ubsXqrI/OPT9X8akRK9xwZze3
	pbq/a157m+8qR06kRwXPed4iLSUuuokRX2vJZNhV6rWUn0BMwNpIklfZr7ToS9HeYA7QEj+esEw
	ge4dANbIgdW7spFx4jxXssyXvC4Jo3jlLRMubww==
X-Gm-Gg: ASbGncu/tiCJz76arZsTtXth7WGbAFgshMgPcEsCyv4VfqccHFjBdDywVXKgTrrSljF
	pQknKNjI8RVn9vEFRDiysCAXMbmRNNWABZADrBZyjclYBpi+bjGjQmlzlsNPhooDyfx3SF5DshK
	Bs2SSDXC6RyVbMICR+fIGk
X-Google-Smtp-Source: AGHT+IG9qpcftd1aayWu9vFb4z/gWoKjR7q12+JoPdMxvKpLqxOLyOzue9OLcoE6x4sfYxG3ywWV9sCyO5W7RkUtb3Q=
X-Received: by 2002:a17:907:748:b0:acb:aa43:e82d with SMTP id
 a640c23a62f3a-acedf65b742mr271332566b.3.1746017633009; Wed, 30 Apr 2025
 05:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <CAL3q7H7WPE+26v1uCKa5C=BwcGpUN3OjnaPUkexPGD=mpJbkSA@mail.gmail.com>
 <CAPjX3FevwHRzyHzgLjcZ8reHtJ3isw3eREYrMvNCPLMDR=NJ4g@mail.gmail.com>
 <CAL3q7H56LC5ro+oshGaVVCV9Gvxfnz4dLaq6bwVW=t0P=tLUCg@mail.gmail.com>
 <CAPjX3Fe3BZ8OB2ZVMn58pY5E9k9j=uNAmuqM4R1tO=sPvx7-pA@mail.gmail.com>
 <CAL3q7H5Bzvew9kGXBRLJNtZm+0_eMOyrgUvC1ZK544DunAPEsA@mail.gmail.com>
 <CAPjX3FcDrr7D7nwh3=fyyOCxnp0iv+jeyPcGRX+gpw9zGHJ3vA@mail.gmail.com> <CAL3q7H5TVPG-KiwZfEmndAQh8g+CT1tMPSYcT1Omhc3om6EHEg@mail.gmail.com>
In-Reply-To: <CAL3q7H5TVPG-KiwZfEmndAQh8g+CT1tMPSYcT1Omhc3om6EHEg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 30 Apr 2025 14:53:42 +0200
X-Gm-Features: ATxdqUHcnnktzz_nyjFwpopx0IbJ2raQjutFLzw5OVpk3l9FdukKyXPjbNQFZag
Message-ID: <CAPjX3FfJqH9ErubwMkWfjYTZr6f0vFfShu=JghxHqZ4aVbNK3g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: Filipe Manana <fdmanana@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 at 14:34, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, Apr 30, 2025 at 1:06=E2=80=AFPM Daniel Vacek <neelx@suse.com> wro=
te:
> >
> > On Wed, 30 Apr 2025 at 12:26, Filipe Manana <fdmanana@kernel.org> wrote=
:
> > >
> > > On Wed, Apr 30, 2025 at 9:50=E2=80=AFAM Daniel Vacek <neelx@suse.com>=
 wrote:
> > > >
> > > > On Wed, 30 Apr 2025 at 10:34, Filipe Manana <fdmanana@kernel.org> w=
rote:
> > > > >
> > > > > On Wed, Apr 30, 2025 at 9:26=E2=80=AFAM Daniel Vacek <neelx@suse.=
com> wrote:
> > > > > >
> > > > > > On Wed, 30 Apr 2025 at 10:06, Filipe Manana <fdmanana@kernel.or=
g> wrote:
> > > > > > >
> > > > > > > On Tue, Apr 29, 2025 at 4:19=E2=80=AFPM Daniel Vacek <neelx@s=
use.com> wrote:
> > > > > > > >
> > > > > > > > Even super block nowadays uses nodesize for eb->len. This i=
s since commits
> > > > > > > >
> > > > > > > > 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent=
_buffer()")
> > > > > > > > da17066c4047 ("btrfs: pull node/sector/stripe sizes out of =
root and into fs_info")
> > > > > > > > ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_bu=
ffer")
> > > > > > > > a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_fin=
d_create_tree_block")
> > > > > > > >
> > > > > > > > With these the eb->len is not really useful anymore. Let's =
use the nodesize
> > > > > > > > directly where applicable.
> > > > > > > >
> > > > > > > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > > > > > > ---
> > > > > > > > [RFC]
> > > > > > > >  * Shall the eb_len() helper better be called eb_nodesize()=
? Or even rather
> > > > > > > >    opencoded and not used at all?
> > ...
> > > > > > > > +static inline u32 eb_len(const struct extent_buffer *eb)
> > > > > > > > +{
> > > > > > > > +       return eb->fs_info->nodesize;
> > > > > > > > +}
> > > > > > >
> > > > > > > Please always add a "btrfs_" prefix to the name of exported f=
unctions.
> > > > > >
> > > > > > It's static inline, not exported. But I'm happy just opencoding=
 it
> > > > > > instead. Thanks.
> > > > >
> > > > > Exported in the sense that it's in a header and visible to any C =
files
> > > > > that include it, not in the sense of being exported with
> > > > > EXPORT_SYMBOL_GPL() for example.
> > > > > This is our coding style convention:
> > > > >
> > > > > https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html=
#function-declarations
> > > > >
> > > > > static functions inside a C file can omit the prefix.
> > > >
> > > > Nah, thanks again. I was not aware of that. Will keep it in mind.
> > > >
> > > > Still, it doesn't make sense to me to be honest. I mean specificall=
y
> > > > with this example. The header file is also private to btrfs, no pub=
lic
> > > > API. Personally I wouldn't differentiate if it's a source or a head=
er
> > > > file. The code can be freely moved around. And with the prefix the
> > > > code would end up more bloated and less readable, IMO. But let's no=
t
> > > > start any flamewars here.
> > >
> > > I'd disagree about less readability. Reading code that calls a
> > > function with the btrfs prefix makes it clear it's a btrfs specific
> > > function.
> > > Looking at ext4 and xfs, functions declared or defined in their
> > > headers have a "ext4_", "ext_" or "xfs_" prefix.
> >
> > I see. Makes sense.
> > Does this also apply to preprocessor macros? I don't see them
> > mentioned in the development notes.
> > I'm asking as I did consider using a macro which would look a bit
> > cleaner perhaps, just one line instead of four. But it would also miss
> > the type checking.
> > So I guess the naming convention should also apply to macros, right?
> >
> > Finally quickly checking I see a lot of functions like eg.
> > free_extent_buffer(), free_extent_buffer_stale() and many others
> > violating the rule. I guess we should also clean up and rename them,
> > right?
>
> Haven't you seen patchsets from me in the last few weeks renaming
> functions from extent-io-tree.h and extent_map.h?

Yeah, I noticed and I like them. That's great stuff. I think we're
moving in the right direction.

> You'll see examples of where the prefix is missing, and this happens
> for very old code, we rename things from time to time.
> In those two cases I was motivated due to the need to add more
> functions soon, or having added some new ones not long ago, to make
> everything consistent in those headers/modules by making sure all have
> the "btrfs_" prefix.

