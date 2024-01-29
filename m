Return-Path: <linux-btrfs+bounces-1911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A76C84116A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA51C23A82
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF0157054;
	Mon, 29 Jan 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="KbRJi9XX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EA157028
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550969; cv=none; b=LHzmtNfznK2GJe/2yw2GUUYOaaKbAHF1TRT8aj8SRNaOmq+ycwCJat1RRl0Z8wKhlgIFA1O2In+bVBII0ZBwWJryl/pQb0vS7gwY0h0xTyVqXWuMp7iuL8iO7KqR39mHNorH6j/YP5ca7mbsXWA5U/Paw3+wS+bfo36ja0g/48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550969; c=relaxed/simple;
	bh=r83xgyafE2tec+3yybX9UcQuYb4YftwRKoCqkzv93KM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7PPUnyB5gEY4zRHgzYwc52qHaO2h12bmlNm/J6Nsb8tpon83Y09mD0+DczW4kyvvrESi2/li1tr1SSIWVD7Zt75NqsqZXkAslhTLgiXy4rOb0AxBSC4WWwT4ijXuOkxhi4gugQ70aafn+CwKi0Uy2NmimreCXGDVgGWgTrL/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=KbRJi9XX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40efcd830f6so2143295e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1706550964; x=1707155764; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r83xgyafE2tec+3yybX9UcQuYb4YftwRKoCqkzv93KM=;
        b=KbRJi9XXrxXPpjK18icShopT/uTfKWjRX9c95lP/mc3gXcTtoLAjeVpoIPAvXYglmg
         tf2ananlyIUXKueGPEJaZ3zbw2U5QVILSQQdI2N7fALQO5y6rvR8MVC8AbhX1o5wFLU6
         Cdh1pemotCbGCK7Or98eL2aSTM8lrCwhE9QJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550964; x=1707155764;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r83xgyafE2tec+3yybX9UcQuYb4YftwRKoCqkzv93KM=;
        b=HuuQLNIGMWPLNzsKsWTIh9p/U6hHw1zypw16+r6F6fwROo9iRCqOqrjFSu9/EIFBaK
         ApTTgz61ardkUkp2kCBWeBf8XOscKS8ihVs/oGi1Mer8SMGFMoMdGsoaRDdpbXIbWW7O
         dpUWd40d1XqBGJ8kHG7YNmtaJwBUe00l2yjZIehWVUOB9U+FExDgXSQbojN0lhV+NSM+
         Tx7HRTlogRCnbGeQnldE5zSruaedY1UQeFfIMJaJ429m5UFyOLe6JWk+dAFTuXOsTTbM
         WGvYFbflWzmK3GFFtl9tsqljGs06AiBVag6HE/lSC9nUKOf80et7P2ldu6zVija2S544
         J8LA==
X-Gm-Message-State: AOJu0Yw1eY4q5yKdn3IgtLZbH7cgSqtfrrcliaavg7Xrr55JGItjoSHA
	7n/hKX1cvhqPWMaruHIaoGjrr9Nm98cHxICBzr6VbEqKSrF05XePwAAXZi8ZDHeGvO56exoTs7t
	Gh00=
X-Google-Smtp-Source: AGHT+IHBWxIhieoq5jYNav3vUMvqaKQenDExZuCjj6/fr6mjCENbygVHQe8HvX4R62oSJVdq52yqJg==
X-Received: by 2002:a5d:6186:0:b0:33a:e919:f406 with SMTP id j6-20020a5d6186000000b0033ae919f406mr3770409wru.52.1706550963596;
        Mon, 29 Jan 2024 09:56:03 -0800 (PST)
Received: from able.exile.i.intelfx.name ([178.134.111.230])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b00337d67a85c1sm8585153wrm.62.2024.01.29.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:56:02 -0800 (PST)
Message-ID: <2c1c21479e8998953541708648d0c02e21d7fd6e.camel@intelfx.name>
Subject: Re: [PATCH 0/5] btrfs: some fixes around unused block deletion
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Date: Mon, 29 Jan 2024 18:56:00 +0100
In-Reply-To: <CAL3q7H6802ayLHUJFztzZAVzBLJAGdFx=6FHNNy87+obZXXZpQ@mail.gmail.com>
References: <cover.1706177914.git.fdmanana@suse.com>
	 <c0649a6d95144ca7040762efe467ac6ee707ac0b.camel@intelfx.name>
	 <CAL3q7H6802ayLHUJFztzZAVzBLJAGdFx=6FHNNy87+obZXXZpQ@mail.gmail.com>
Autocrypt: addr=intelfx@intelfx.name; prefer-encrypt=mutual; keydata=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
 NzAT4cw
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jZOufdffuxbAs8MnK52H"
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-jZOufdffuxbAs8MnK52H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2024-01-29 at 12:49 +0000, Filipe Manana wrote:
> On Sat, Jan 27, 2024 at 9:39=E2=80=AFPM Ivan Shapovalov
> <intelfx@intelfx.name> wrote:
> >=20
> > On 2024-01-25 at 10:26 +0000, fdmanana@kernel.org=C2=A0wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >=20
> > > These fix a couple issues regarding block group deletion, either
> > > deleting
> > > an unused block group when it shouldn't be deleted due to
> > > outstanding
> > > reservations relying on the block group, or unused block groups
> > > never
> > > getting deleted since they were created due to pessimistic space
> > > reservation and ended up never being used. More details on the
> > > change
> > > logs of each patch.
> > >=20
> > > Filipe Manana (5):
> > > =C2=A0 btrfs: add and use helper to check if block group is used
> > > =C2=A0 btrfs: do not delete unused block group if it may be used soon
> > > =C2=A0 btrfs: add new unused block groups to the list of unused block
> > > groups
> > > =C2=A0 btrfs: document what the spinlock unused_bgs_lock protects
> > > =C2=A0 btrfs: add comment about list_is_singular() use at
> > > btrfs_delete_unused_bgs()
> > >=20
> > > =C2=A0fs/btrfs/block-group.c | 87
> > > +++++++++++++++++++++++++++++++++++++++++-
> > > =C2=A0fs/btrfs/block-group.h |=C2=A0 7 ++++
> > > =C2=A0fs/btrfs/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 ++
> > > =C2=A03 files changed, 95 insertions(+), 2 deletions(-)
> > >=20
> >=20
> > Still broken for me, unfortunately.
>=20
> I'm curious about your workload. Is it something like continuous,
> non-stop deduplication or cloning for example?
>=20
> Did you actually experience -ENOSPC errors?
>=20
> Also, if you unmount and then mount again the fs, any unused block
> groups should be scheduled for deletion once the cleaner thread runs,
> at least if there's not a huge workload for a minute or two.

Apologies, I must have clarified the workload.

The easiest way to reproduce the original problem was to run a metadata
balance, e. g. `btrfs balance start -m /` or
`for u in {0..75..5}; do btrfs balance start -musage=3D$u /`.

I originally spotted this regression by observing an abnormally low
metadata space utilization and trying to run the above balance, only to
discover that it makes overallocation even worse.

So, with the patchset applied, the _metadata balance_ is still broken.
I cannot say anything about normal usage, but any attempt to balance
metadata immediately explodes the metadata allocation. I did not
experience a -ENOSPC per se, but the balance (that I used as a
reproducer) eventually consumed *all* unallocated space on the volume
and stopped making progress. Attempting to cancel that balance RO'ed
the filesystem and I had to reboot.

>=20
> On top of this patchset, can you try the following patch?
>=20
> https://pastebin.com/raw/U7b0e03g
>=20
> If that still doesn't help, try the following the following patch on
> top of this patchset:
>=20
> https://pastebin.com/raw/rKiSmG5w

Should I still try these patches to see if they help with metadata
balance, or is that a different problem then?

Thanks,
--=20
Ivan Shapovalov / intelfx /

--=-jZOufdffuxbAs8MnK52H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmW35rAACgkQe94XyOTj
Dp3jMRAAwJnNSYDMHZVAtvfx3sxuflrlRHInQxEcv5WFfQKHIjlrO16Yaz7R+Cc5
fApWX0eLVEKSIskkL5ojvz9PWs6xRvRePbyAxOw9eavYbIC0xdPLhLsK6JSbB0K1
2vw+U5wdqbgIl+W7ga179k+t69Oe0+yYlKLIvzn8lRz1KQ2hOA8dQtkTACw9w5AA
TYSsLENdaKbCVUK6T/gf/WXBLLwLs3sOiXiqiqJWCZVm6pZ3qOMIloMIUWp9KPxF
ij54w5dFwzQYCDz6xY7Rn3BNkJQNhSdmGHi+eCem4h0bGGmCJDPrJc8ZWIncknPj
4Ho5Y/UUopcPcKhd7LSa7xhjz/TJgJ+QsYMmXB1GvgMFGPfjShTZMH+ah8IOIsnG
d4iVGIuK2m7ywyF2mTNilIvLXpvUI00XzXVwiFdPcjGqrIbzAAsHapTgPeEajbXp
rTKweIV97g6168v5Hhzg2cnYfppesW5IGXTTZ2PIvddFGoxJZPFnvrooxcKoohuk
y5dfGBzzBSgrtP4Mx4waBEu8Rajwvq6q+lhmy9UGJvzquUKcGhSdFgvB2zo7Pq6F
AIgfyucq8M7KT54McwSNnuAI9/J3AkXTHW56NqMgixgglpfxisbqXegU6pYJiMez
Y5qo9uRUvS5l1Oi2fIhyWwsOtyPBNobiaalYpq2/djrabv0iGxA=
=Hzyr
-----END PGP SIGNATURE-----

--=-jZOufdffuxbAs8MnK52H--

