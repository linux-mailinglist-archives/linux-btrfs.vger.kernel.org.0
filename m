Return-Path: <linux-btrfs+bounces-21929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CgVHT8tn2lXZQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21929-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 18:11:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6B319B4D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F0E63012B72
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535B2517AC;
	Wed, 25 Feb 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQr6CjY8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F13E8C54
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039476; cv=none; b=nBsZK2UVW8jfa7pdF6OqgsiMJT12vIyzGs9vFy0VaNwR1/pEeGojfG5xSVzBRBQuEC3tzXQ6QGGR5bAcA/zuypm9RLLIrZjn+e6lV5DAs0ouZegen0L0bl0yVWpj5Umi+M77fy73XeJ3Dt+LXDQhxrrEcE0Z3w7l60N8QhhfIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039476; c=relaxed/simple;
	bh=uPTqY9JgO/N3hTjOibB1QSaxUILQmEOeelzPayjTk/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3CvILUOyQE5o1ho/SOzA2mgaTrr+7hm/wdcch9T2yRwDsWb9hEvh4EGBm9yducW03bWAajZ3pD3CI+LH7hx1OL5KSWwgpfMdMLwjMkTK3ZvXgXON54vv9kdk4S2H4YQ2btrfG8DfyazeZzAxxPXD3Acv9s/rcFsjOy/cELSW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQr6CjY8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371119eacso81183075e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772039473; x=1772644273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIssFQ2vzW/kmoN9DVV+0qSa2AsjIM2tskzI7Qx/Me8=;
        b=LQr6CjY8TtDOQx+Vv1A1W28IXTraePHaxC8M6KKLC2Y2NFFORZ2UZcPvzcdpzBeXyD
         w4VKkLyHQ0PGc70TWaCEKbKJwFvxuP9XDad0FxLKqjcqHfOmcQ+UihE1pYpFgGiuWt13
         fT/Qgl3lybJbsOKir8FkNcNGRuqtPIdBVLQgP4HGyLS4EgqciKiAP5XeW4cKreKNuzCY
         sawai24HqKBCZSoqPpVC+Wknfg3fwvV/JYWURcvWIqiprrecOZZ8wkCg4M0YX8X80cea
         gh+pKhoxL6nslmtmN9fd6GrNEuUiqIejXM8QYpFhrX8f+W2RCJ3tUYzkwc9KkM3BqO8G
         0PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039473; x=1772644273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIssFQ2vzW/kmoN9DVV+0qSa2AsjIM2tskzI7Qx/Me8=;
        b=WDUCgtlstEuXmNajpO7YDrCzH4LxwT5XF0xx2t7O7Kgp19zmFWPtZbDhd7sczTaaPQ
         SpOneYi0GQZ+143yaG1I0P8iDCSnWYVuGp8aNWb4w8Kr/PnNcKS1uqfxrdYWh3jQ3fQ7
         dybcyfKoS3vfDHsu1i/YooZia4G0jtbVX55A+zQIv5oXT/Lxj/sfxdxKAf9Zvft0Tp36
         000lEEU867NxlVke90k/FCD7LkOBKsy2rOSXNM52inThn+IrYaB1bn4KAvdAFCEuakVP
         t5+6uSU2nK82LWeTWgYX5BknBSerOSyw6zCF9ncPU35ScKZpz/UdGfdWgwv5rcD/kGsy
         1/cA==
X-Forwarded-Encrypted: i=1; AJvYcCWAFk9s0x0wEw90HZ/CJCohk24eZkX2hGhyMZ0o4givy1KFhIPQVs9FFBbdv/16Y/R1UzkIT70pUkSUEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzujhT4Z826MT/rRrHRXDf91l+Kr1/UgPwzqNAOeS2WIW8sSTfe
	OHUsXowL7Htqxh93XhHa8FiRoZoa8pzWXpj/ToAC/kw5WVHWv+1SUco0
X-Gm-Gg: ATEYQzw4xolzWO13SKOj/QUgiWy1rEqqqwwT4Gp9wqcsc5qAphlpOFFqEAVwtjzIvGl
	dt1fA9ocMQHQOjBb6jjq7pZn6y0JYknKL7nGogr5ZgDO+TvO6GNNsX7ErdfKzJ85hm11rV3SZ7t
	rMBAFpsOC1DRwidf5/qblwyw3dWgF14i7KXMhImpQ50P5QbD2Sht5hGQ+qZsMjj3bm3IWnY1+9X
	jyIhKjTYgXzPCvdql60mVHGeRkp47tnXnLWfJ4uk+kKlsgodUzibpV79kDH9rQkslBHT/W5MQ9r
	HAC7gewld0Ngow2elCuHVcOU3wmObgFUvvzz2BHmj0npPvLYeCbYYSkqhTDgYcqOWHXAJwqeiJT
	DZpQpGTMSCxmEfSXxk/gAIbF3o8ma816loRSPMIvKMWRcQwwgGsumaalFxyWNFDMpIxpjEI+5cL
	2g/QHK9oWncwavCjdQ08u2596GiZ6cIoAzeyjAQRrzCG/e1ajS5fEtzIlF6GQz86Fr
X-Received: by 2002:a05:600c:450c:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-483a96377b1mr274706305e9.24.1772039472364;
        Wed, 25 Feb 2026 09:11:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm128499385e9.0.2026.02.25.09.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 09:11:11 -0800 (PST)
Date: Wed, 25 Feb 2026 17:11:10 +0000
From: David Laight <david.laight.linux@gmail.com>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Miquel =?UTF-8?B?U2FiYXTDqSBTb2w=?=
 =?UTF-8?B?w6A=?= <mssola@mssola.com>, dsterba@suse.com, clm@fb.com,
 naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kees@kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
Message-ID: <20260225171110.171fad8d@pumpkin>
In-Reply-To: <20260225144446.GE26902@twin.jikos.cz>
References: <20260223234451.277369-1-mssola@mssola.com>
	<69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
	<20260224145555.44a8096d@pumpkin>
	<20260225144446.GE26902@twin.jikos.cz>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21929-lists,linux-btrfs=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.com,mssola.com,suse.com,fb.com,wdc.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.com:email,suse.cz:email,mssola.com:email]
X-Rspamd-Queue-Id: 1A6B319B4D9
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 15:44:46 +0100
David Sterba <dsterba@suse.cz> wrote:

> On Tue, Feb 24, 2026 at 02:55:55PM +0000, David Laight wrote:
> > On Tue, 24 Feb 2026 15:07:10 +1030
> > Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >  =20
> > > =E5=9C=A8 2026/2/24 10:14, Miquel Sabat=C3=A9 Sol=C3=A0 =E5=86=99=E9=
=81=93: =20
> > > > Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
> > > > introduced, among many others, the kzalloc_objs() helper, which has=
 some
> > > > benefits over kcalloc().
> > > >=20
> > > > Cc: Kees Cook <kees@kernel.org>
> > > > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
> > > > ---
> > > >   fs/btrfs/block-group.c       | 2 +-
> > > >   fs/btrfs/raid56.c            | 8 ++++----
> > > >   fs/btrfs/tests/zoned-tests.c | 2 +-
> > > >   fs/btrfs/volumes.c           | 6 ++----
> > > >   fs/btrfs/zoned.c             | 5 ++---
> > > >   5 files changed, 10 insertions(+), 13 deletions(-)
> > > >=20
> > > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > > index 37bea850b3f0..8d85b4707690 100644
> > > > --- a/fs/btrfs/block-group.c
> > > > +++ b/fs/btrfs/block-group.c
> > > > @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs=
_info, u64 chunk_start,
> > > >   	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> > > >   		io_stripe_size =3D btrfs_stripe_nr_to_offset(nr_data_stripes(ma=
p));
> > > >  =20
> > > > -	buf =3D kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
> > > > +	buf =3D kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);   =20
> > >=20
> > > Not sure if we should use *buf for the type.
> > >=20
> > > I still remember we had some bugs related to incorrect type usage. =20
> >=20
> > The global change really ought to have used u64 to add the type-check.
> > Otherwise it will have added 'very hard to find' bugs in the very code
> > it is trying to make better.
> >=20
> > Using *buf for the type might be a reasonable pattern for new code. =20
>=20
> I find this a bit contradictory: I agree that using *buf as the argument
> can cause bugs hard to find, yet the next sentence recommends to use it.

The issue is that mechanically changing:
	buf =3D kzalloc(sizeof(type),...);
to:
	buf =3D kzalloc_obj(*buf, ...);
is that you've silently changed the size of the allocated memory
if 'type' wasn't actually the correct type.
Whereas changing it so:
	buf =3D kzalloc_obj(type, ...);
will give a compiler error if/when the types don't match.
(There may be places where this is exactly what is intended.)

For a big mechanical change you really want to err on the side of caution.

For new code it is a bit different.
kzalloc_obj() will pick up silly mistakes, so both:
	auto buf =3D kzalloc_obj(type, ...);
and:
	type *buf =3D kzalloc_obj(*buf, ...);
are reasonable patterns.
The former may actually read better as 'allocate an object of this type'
and doesn't require that you replicate the type.

	David

>=20
> This kzalloc_obj way is new I'm analyzing what would be a good pattern
> and so far I don't like the "*buf" style of 1st argument. As the
> function is really a macro it does not dereference it but it still
> appears as it does.
>=20
> Writing the type explicitly looks still more like a C to me. Types in
> arguments are in helpers like container_of or rb_entry and it makes it
> obvious that there's something special while for the kzalloc_obj I need
> to remember it.
>=20
> The whole thing would read better as "allocate object of type", so I'm
> probably going to convert it to this pattern in btrfs code.


