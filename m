Return-Path: <linux-btrfs+bounces-21881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fp4Agu8nWklRgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21881-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:56:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DC188B9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F242D3094CD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80973A0E91;
	Tue, 24 Feb 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYhtcaRR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F539E6FB
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944960; cv=none; b=GgTS6m3FH5cGKJY92aV9yq2hfcWcPa/arfAEK5pfyawLrsvJzjG8BK+HU/wirFiFH39FlBgNPSzXGqyWd54q2ykbSAQHXw0edeTB8n4ACzkzglGRkBRWCpn/eJs6X/jSu29OxMOw+39Of5oCK7boZ42K3op4cMKOM/LW/WY8MKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944960; c=relaxed/simple;
	bh=+DLuv7JiulTdryJ7AES8KMKTwVgtjpMXGf/4k1uBCVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVqb76zuG3XZu7h7V/A2obbmM88+AOLlDxh8paM6pB9+sAqGsyqFBgy/IjWKx2i1ogY960qNz6k9dqpfNC+RdXv9+q67onF9B7LdhURZ4vpj5r34jgWXVaJ87ZRYGwUpVfkad2vl4FnvR8C5/FdzTT/WSsGuyik5OnL63eoDfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYhtcaRR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483a233819aso54750665e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 06:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771944957; x=1772549757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hftReuk+BjE4XIZFmQWrSGXEVWyYVhBcp3oc3KbKdkc=;
        b=WYhtcaRR6yrb/7kyYKnNCc6Cr9OlZnn4Rc41IoqocgdDirYDt4putx95tSMRfYq/WU
         1TO3wLkimTgyu+5uQpJBZn6q+A1GmeCaG5Gix2J7xRINloGkksWt/q1Q7YJt8u7PVl/p
         AOQ4qD7ZYUpCDYo30Vszez1+DJkZWcd/lgnh7SeavaoyQO+scd248RE/0vqIY0sxxFuy
         1NHDZOOQot0o416auCWpTSXyngnmcwUabGU/eujNjAKKppsS9Ufc/gZXQi571pm0Oc0G
         mi3moK3DXUAerlNb6vHf21c9zFAJmXW1QXdOccMxyxAnO7bLE1n4ERAE9k0hTxmFdFON
         gopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944957; x=1772549757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hftReuk+BjE4XIZFmQWrSGXEVWyYVhBcp3oc3KbKdkc=;
        b=bSMLal1w4wIq9n8xDIF8pobMV3IVYxyGTLDkYjK6LovNBoLHntKk4pNHz2XHxaW178
         sXSRHC1PS+B6oainBdeGJuUZVu+BHUb6t4uG562Y6d5I2mCv9ZItK7AcUAyJKnqllLeP
         UATAUvEnc2jGcGLLW68KLZazrk1fT5XPv94YnjpQAoLcesStAlKy172JqKrp5pLUt4dr
         HYn+J6cFn8HTG+XYrRGBZuvdAaKyy5dJN99FWLMAizo/gu+jhx4ooJJldgJTWiw5XUTR
         o/w5ZT2MeXbYDj2VuQAULoeJ2XTvjyFwOT5+ZWXGkt9qBnf6EF+27UBsRUmx3DaG47vy
         KzDg==
X-Forwarded-Encrypted: i=1; AJvYcCXsRQ6CQZZadX47lW7ZycumiCXiB7WmgIPfTKjrcBKU1ggpX9Tkw5UIBz7ajIv9GcdpFuMvMERc7OEecw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9TfbERw4RIIB9svPihchaUED2HLO85QrpelPKh+xrlqA5yqcS
	FFD1ifAYvKAjRyzt86JyHMi7pjP3fJXOA3aBsH1Mrcs2tcV3iDd97pK9
X-Gm-Gg: AZuq6aL7nAsroeDzgH0hEkAXZZSsoHFv7+QtrrejJFI591DO4jb9Cgf4V46cHZQqAPL
	+s5m5s0SWnmlMI+DJfXA6Uw6HSLDalka1US2uEbUPOxPscRbelDkCY+eQI1NbweQOkxmRZXB3NE
	P86A+vyOfZPBmVU6l8pVKqn92/odec9iTW2UBv3TONVKdxvbL69r6Wxt788n+aSGT4/atKf7dYK
	lUkujHnmA1xooeKzZXhDHZVnhS+kDi0EOk8b1qUu6JWwYVaVsaKfWRjkHkJIJzEdb10ibJUNvdk
	AVnkkF1WqhaYxiacmoyD0ohlkWq3Zlw3vcSd5SM3Y4P17hYwn1qXXZgJdh07uoW9zRD9eSH+Dy4
	TgxwgUlxES/iiJ+PqmkIbOEOpjjp6IoSNTIRQZZillm39v8zcBsAoJpS2KP1zBo+AO2uZbsDdmV
	tzes0CudUHQZH7WzaMLNML4VmjKvW2zPF8mijY8Rt0KuKHN2JdUzV6e6PrmdxU5U7f
X-Received: by 2002:a05:600c:8b2f:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-483a95fc1c8mr217127005e9.13.1771944956953;
        Tue, 24 Feb 2026 06:55:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm28620552f8f.4.2026.02.24.06.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:55:56 -0800 (PST)
Date: Tue, 24 Feb 2026 14:55:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Miquel =?UTF-8?B?U2FiYXTDqSBTb2zDoA==?= <mssola@mssola.com>,
 dsterba@suse.com, clm@fb.com, naohiro.aota@wdc.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
Message-ID: <20260224145555.44a8096d@pumpkin>
In-Reply-To: <69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
References: <20260223234451.277369-1-mssola@mssola.com>
	<69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21881-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mssola.com:email,gmx.com:email]
X-Rspamd-Queue-Id: BC2DC188B9A
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 15:07:10 +1030
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> =E5=9C=A8 2026/2/24 10:14, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=81=
=93:
> > Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
> > introduced, among many others, the kzalloc_objs() helper, which has some
> > benefits over kcalloc().
> >=20
> > Cc: Kees Cook <kees@kernel.org>
> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
> > ---
> >   fs/btrfs/block-group.c       | 2 +-
> >   fs/btrfs/raid56.c            | 8 ++++----
> >   fs/btrfs/tests/zoned-tests.c | 2 +-
> >   fs/btrfs/volumes.c           | 6 ++----
> >   fs/btrfs/zoned.c             | 5 ++---
> >   5 files changed, 10 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 37bea850b3f0..8d85b4707690 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_inf=
o, u64 chunk_start,
> >   	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> >   		io_stripe_size =3D btrfs_stripe_nr_to_offset(nr_data_stripes(map));
> >  =20
> > -	buf =3D kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
> > +	buf =3D kzalloc_objs(*buf, map->num_stripes, GFP_NOFS); =20
>=20
> Not sure if we should use *buf for the type.
>=20
> I still remember we had some bugs related to incorrect type usage.

The global change really ought to have used u64 to add the type-check.
Otherwise it will have added 'very hard to find' bugs in the very code
it is trying to make better.

Using *buf for the type might be a reasonable pattern for new code.

	David



