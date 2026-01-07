Return-Path: <linux-btrfs+bounces-20190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4D8CFDE97
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 14:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B688C313E3FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC13324B33;
	Wed,  7 Jan 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="oLCnYpgR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F4312837
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791775; cv=none; b=Jv5+wBTmpzoNusbpdrBKs+ytEXy61STpJQtMKxO2OgtIFK41tP56SO8SJJtlk2LPWL5b4e6nMrQrd7OWGlGUfiw2nMez5qIL2jJlGacMKdLwXFChxxHJIXGA58VLDvyxy8Sevnlwa44bctZt7xVbngOvD2Ar3jVweEvKYwPoybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791775; c=relaxed/simple;
	bh=g2bpzg0N58vFRxyxOe0ZX8/2xpmR86fmVDqw+8tf3Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOaNKlUnhcPQ3/SQcJGES+BLbROnnhVsgq8X/VxxGHViN6e7X8sirsT1LnAx69egj2gLswBnGdifPLJsypVUFrC0wEM9f+EBIWAczffmWFs4SPsqovC4t7bxgZFyHD264PKgVoBIb5vvGAfhj2vdr94J3s/zMp3xwQPhgmniNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=oLCnYpgR; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1767791760; x=1768396560; i=christian@heusel.eu;
	bh=g2bpzg0N58vFRxyxOe0ZX8/2xpmR86fmVDqw+8tf3Ng=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oLCnYpgRiUZayDkMNj2MNPy3wU89S1ah41vlTW2pLpzUn/plfYAZWgq1v8qy352n
	 3xJWEEDohAFOtlhAxgEABkz5/19R2jHnnLFEAmRz0k/Iy4umFAbQZVKx7O8P1eSAg
	 F3COz72LzYUPAfv0fzVF80hNsxer+AI13EMzLT895VFiQqS8zVpuvZJHexodzgAAq
	 j6wOQnMoC5UWX5Ou1AytEOhQA3vRmRmWtFRlhdustBThXZmkdnpSNeON1UN7TW2Qw
	 62QRWnsw8917whG0F5K0i0A/f6HheCingtMCEQ90vvMB04elEp3WWeRvfiSuooJOS
	 R5up1IFniGiLW4NWwQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.239]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZT2u-1vOZRp3lO2-00YL9t; Wed, 07 Jan 2026 14:16:00 +0100
Date: Wed, 7 Jan 2026 14:15:56 +0100
From: Christian Heusel <christian@heusel.eu>
To: Leo Martins <loemra.dev@gmail.com>
Cc: Gideon Farrell <gideon@solnickfarrell.co.uk>, 
	linux-btrfs@vger.kernel.org, regressions@lists.linux.dev, arch-devops@lists.archlinux.org
Subject: Re: refcount_warn_saturate in __btrfs_release_delayed_node for
 6.18.2-arch2-1
Message-ID: <584c770b-8e59-457c-a8a4-0f9630ec9635@heusel.eu>
References: <DFHUFTKLUCB5.11QUC5R2L77DO@solnickfarrell.co.uk>
 <20260107011054.2694891-1-loemra.dev@gmail.com>
 <46fba8b4-c694-48d8-b20b-6d0fdd18bf8b@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xbscq4523oipo3tj"
Content-Disposition: inline
In-Reply-To: <46fba8b4-c694-48d8-b20b-6d0fdd18bf8b@heusel.eu>
X-Provags-ID: V03:K1:QJh7KtLRMXZEOaSP4it1VKyXyLYjPvkSwz/kkxtZQ0SdAgUr/B8
 CDErthotMgPojfSfNAKbJKhzqOd7u4O6HS4aSMI3REPmvswDzeNT0WJbxT5o6Q3u/VffKJd
 2Y82T7U0yv4sj8b9hUiaQ/id+aM6bDINxrryYW9+EzAr8HAIhrDHU/lTmX0GAjlrevpoVKw
 7fTPTOpb3SX1Kt34jD9Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R4Hqg8Gpb7I=;cJA3veMQUXU4L52l7LKo0Tg5re+
 InohsNdPdI8Uj0y0ik96yc/2s8cVGGGjxuQ79zLVrLX9XqJKra0QKn1jNMiBW9Ck44QgO8Kkn
 1NCmCW//qpUXGHqvAqIVQsHUdHUUC9M/ESK7OvHRBJCS4GDSs276HvsexrNEsMzII1fS+dWuY
 UWKv9sbDHzGeFozRKdOkCi4IprSq4HuzjWMlzBRDpNBIsAR7B5lD0rQ0JoZqHJvWAsSX4wydv
 s8WFfxHoprHamtu/2XR2Ng/GtoTpmtTX3GPaR0KdOGlCaKH+TeJDK1LcAVl19JsCuG79zUK4B
 9Y836BM6LuooKfHXeS5Mec2bVEEcxd9+4/YdE/GXUMOJWWkwQFyRB1C2BX+XHYi/obpEEuRob
 Oh9lfVdThGsPrkcMM4PDXGyhc/hyUNe5k2E9Obob40GMZeMf+TtofyvlsaLc209H1T47Yuo25
 u3rkWIj4tFJKojpLix8Xs5oA5+ak6ttAYUTW/Dxg8e++RqfpmFNxeXBe5rE/l2yTH5QPfzOmR
 hecp8hBVG9QKkzPPsWlGi14tarh6xKoHMp0RI9aAnoPnmWq8+LjdfOEI4ZFB4X02VenNjvw7n
 quhr3IY/5XKqZFGxAZfSLTHEnjRm5xGQWn0RPjOhQttzR2OXrPDqt7bgZu9NnRML8w62pOyKA
 W3rDam318QE9U6Ue4oI4XYskyZn5Y0Z4PEeM+XvB3nDdzqUYEJN5h6gDt8uLXUItA5kC73+Ax
 YTk1UsDRYi0IsXf6NYxbCFJZYHesrvR81iJFmClc76YZFPUA0yaFmrdKTXK2HTjKxNyU2mIcz
 SmtuwJ22KaAfQJcHc1OFBdXFJPTNp3at72ui7FhFRo8tW15WgFISAG/hRMqkK8ZKCO7kKT3LA
 zpfgolx+S+4PXyfjzekaGjlKhVa02H9n3rqEeqs4f8PvqZGBTKrLXs5OUnOKg30bd/NpX8Oo+
 KN8VbAdLzOCnGW2JcWtT6VVfo6QH6f0Eu/LQf4BGdTZ/sYe0XnlyGCz4ty7eOgq9rAzFegUGo
 YVTJH7URiEywD30CZifB9L+Pz+PUYgCjWzTbc5D9vHvzWBc71qnjNOGWkfYpi8MrzB1g1F59w
 RgFfI4G+o5KTrFF8gg7isbVxDQ772G5PiK7KjwFvrLsmTLoJnB7Z1QV9o2uyLSvgmFr77gqsq
 murNZUwwZWt5jOJyKAxZMKjS6S2SSr0YGSFQ6qy4VKVWTU5Ga98bmKotUwjburql0CtWjviVo
 +CAJ30BzwIQA90NdKeIbHNTcwyBA2HgkoDa8AdDCj9q9uY0IhtmtlMvLuvdiA1CRxZhRNJts4
 7p6bP2XXuGooGWfqiRaStsPnYBBe76Ad8j2/ptr9Y7xuROMhQMckQxDRcsjadd2o99jZVrIII
 7yyiuSlE+Mqnj7Y4yAh/2Ub1mzX+LZE5iygPL1uLHOPng8k3ZoPRuUd3DKwvzwosDvIBhT6VD
 vPXa04+PHGb/nPPOXqWYs22F2HdKSsgHKejJ7ZeYLCM9a7iLxFwfwYlGddbzZSH2hEmFffI35
 Lzby7CTthj7iN4hkujBYKqI5RNdOyZFvmDZvYkBjVDY0Uk4GMr919me7PIUa8OjxYOWStfE0v
 QTknaoFKiQ3RENqbZjFwfmqoXeimuZ6WvWXH2ilR/seBZvFW6w4+Upqq4j1XVlNYaJr4Te4YT
 cNNdZW2P5EIx7NV3lFdgpCait5+Xk1dPX+HtILYu9vZgzs6IgGppFGXkJ8m56bEQ2THtk7+dY
 t3+QNb7LCOjL8sfo/o95NF+zFSyzaiF5lLXUgO/gXQqvqng9n/fG9ik0m6BuYZsQsiW7PnaaP
 Qz2e


--xbscq4523oipo3tj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: refcount_warn_saturate in __btrfs_release_delayed_node for
 6.18.2-arch2-1
MIME-Version: 1.0

On 26/01/07 02:52AM, Christian Heusel wrote:
> On 26/01/06 05:10PM, Leo Martins wrote:
> > On Tue, 06 Jan 2026 22:01:58 +0000 "Gideon Farrell" <gideon@solnickfarr=
ell.co.uk> wrote:
> >=20
> > > Hi there,
> > >=20
> > > I recently experienced a type of crash I haven't seen before on this =
system which seems to originate in __btrfs_release_delayed_node on Kernel 6=
=2E18.2-arch2-1.
> >=20
> > Hey, thanks for the report. This looks very similar to a different
> > report that has been fixed in 6.19-rc5.
> > Report: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.=
com/
>=20
> I think this is the issue we have been seeing on the Arch Linux
> infrastructure aswell, see this issue for reference:
>=20
> https://gitlab.archlinux.org/archlinux/infrastructure/-/issues/788#note_3=
85420
>=20
> This has caused us to downgrade the kernel on all hosts in our
> infrastructure due to the crashes caused by this.
>=20
> > Fix: https://lore.kernel.org/linux-btrfs/7c89417ac3352ce3cb0a6373a17461=
55c1e2754d.1765588168.git.loemra.dev@gmail.com/
> >=20
> > Please let me know if this fixes your issue.
>=20
> So far we have not found a good lab-setting to reproduce the issue
> outside of the production machines workloads (but we have also not
> looked into the issue a lot).
>=20
> Do you have a good reproducer already that we could use to verify the
> fix?
>=20
> Also the fix is not yet even scheduled for inclusion in the stable
> trees, since it is still not in linus tree right?

Sorry, I messed up here! I got fooled by the output of `git log --grep`
and therefore missed the commit! As pointed out by heftig on gitlab the
commit already is present in 6.18.3 which I'll try to roll out to our
systems shortly! :)

>=20
> >=20
> > >=20
> > > Here's the stack trace:
> > >=20
> > > ```
> >=20
> > Are these the first refcount_t: warnings in your dmesg? I would
> > expect an earlier warning that looks like
> > refcount_t: addition on 0; use-after-free.
> >=20
>=20
> This is what our stacktrace looks like:
>=20
> [...]
>=20
> Cheers,
> Chris



--xbscq4523oipo3tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmleXIwACgkQwEfU8yi1
JYVgrw/+JaeFMDKO81WKxdImmgz+4Wc4Ucnj8IjVtaPS65Vav/75VTLuRMPfqZ9y
YAoh+dXUcRdR+LYT3pYp3bycd4e8e7CORsJvMV8cm9eiebKBXU1LeZamCQhi4MzZ
EVvZPMXR51CJgkZ/ruME9alzbnIFj2UGMVvUfZL8htvZTTi2R6oWn4otucxxFrKd
OuLO0lXE+48LQs5RCqg4VdxQpHSG6eCcMJHLGczdLEQD3WrMOdUrulHC+xWU73xY
N1+BgYAtHz6iGTptA3+fWcNybuDln9926bzI83g39HY4OYUxHj/PkUh8E2s9wftD
Zo36g+fhf7sHkMPNBku7RyuUzkoNUTKY/G5gF91JLYJ/iAuKAFZ4tH9UgI3XiByv
vnPFG3NPruR7LUeHFRETgovzQNgZ/nmNUQravsejdl8tTgjzPxrWPcxVNoacdfjW
lUj48cIKXiTeIZaGckrk5YOP36zkPQ9d+9i+qPkQhaiM3/w/TuHx8RW49u6Z4Pgo
pPvfX4UpNYZXagWm5A6JMYhM/J890UYnuy7tTPccF1iurw3JZtoeFdJI1TbADFzw
QXJ6f9iSuRwnlVzKyGuwTlw2ZGmjnYcQe/TXkjTj2Pm7exrlxTW/XIRiSxJuBltY
kBBod5gV4xGpiMJZvrSY17PJGTap/Q5G5WDlMdhaROm7iL+9AsM=
=TXE9
-----END PGP SIGNATURE-----

--xbscq4523oipo3tj--

