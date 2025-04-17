Return-Path: <linux-btrfs+bounces-13149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB1A92C97
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 23:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343C33AD9D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044C20A5D3;
	Thu, 17 Apr 2025 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="c0T4Cqa+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00B18D63E
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924975; cv=none; b=kxSkbpKZ8TudWXzKsLHwYACsVZNi8u9N2qJYKPLzTf9t9GAuV8BzQPn9uCNfxlMSBlupzKell+pFZ20ZC7Eza5CQcFBkO6/L+uDfBie1jT3KtHvIf5V4Z/VqiA67xiUFZhvRwUWSgJXfI77Aye5OsUNlbvBnVVt12AnadhZivJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924975; c=relaxed/simple;
	bh=DoHl77Cml3HnQgLqf+pcSjnle9SSpDZnv7x+gLoOQNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dOm/szJFjfF+rCRUpI1egzewfwLJ/ueAu/XZPrjmS1sd5HdrV++/r+dA0RkvRGY7vf6GtymGrmw7P/WO11hsabxXxhfOXW7NT3l/7shN/GZWS0aDyAUBZ09OLdmvZybUiUokLjhZu8R4kxZnAfXqpPlauuunBByQCEIn5iA1BIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=c0T4Cqa+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xCxb2e8bYtwmbSFZ3pwBM4UbXWuUs0fywbgEJ670tyg=; b=c0T4Cqa+g3wVTtcOG23ardgwvL
	miPERzECERSNaRh/uo5Bq/IMIUTAa3Z6amC7+4o9JbLDQL48jvkqbMB8O0RR3m9fWbYt3TEIeE8ze
	jSpbp7TyY+ZXax2tOSRznY8Ei82PnDVr23DfOdw1NJf7U8uTf3zpXTEmzXAYPxp39ayodwUXkJN7R
	x2tYLrKVrN2Nk8sGEEo7GHDvU4QfBfTi14XzYlu71qieGJfDmvREtRpJfDrJVN6RwtRApahnZ3CN1
	eqjSIQwzLODxr2EfYQOiDAvsEBkFJG286qKSKytRVLJEYyE2azS1Hl1WJe8hDsRy/0+a0YbXeodOt
	DUvZ6Dpw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1u5Wgy-005r7N-D4; Thu, 17 Apr 2025 21:22:40 +0000
From: Nicholas D Steeves <sten@debian.org>
To: kreijack@inwind.it
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-btrfs@vger.kernel.org
Subject: Re: P.S. Re: Odd snapshot subvolume
In-Reply-To: <93a7fd2e-d667-4b9c-b2b9-dc4f05e7055d@inwind.it>
References: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
 <87friais1a.fsf@navis.mail-host-address-is-not-set>
 <87cydeirkl.fsf@navis.mail-host-address-is-not-set>
 <72d7150b-4e0b-4e15-bd3f-ab410be4a767@libero.it>
 <87tt6q1tn3.fsf@navis.mail-host-address-is-not-set>
 <93a7fd2e-d667-4b9c-b2b9-dc4f05e7055d@inwind.it>
Date: Thu, 17 Apr 2025 17:22:34 -0400
Message-ID: <87y0vy32lh.fsf@navis.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: sten

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Goffredo,

Goffredo Baroncelli <kreijack@inwind.it> writes:

> On 14/04/2025 20.32, Nicholas D Steeves wrote:
>> To encourage btrfs adoption I think we need to do better.  After
>> considering alternatives, I wonder if there is anything simpler/better
>> than
>>=20
>>    # findmnt -n -o SOURCE /foo | cut -d[ -f1
>>=20
>> to get the device suitable for mounting -o subvolid=3D5 | subvol=3D/ ?  =
Ie:
>> "Just let me see everything with as little fuss as possible. Make it
>> simple!", without relying on fstab.
>
> Below a bit simpler command options set
>
>      # findmnt -n -v -o SOURCE /foo

Oh, nice!  I guess it's been a while since I've read the fine manual.
Findmnt has a very, hmm...unique...definition of the "-v" option.

> However I have to point out that this is not a specific BTRFS problem. Se=
e below
>
[snip reproducer (see previous email)]
> 	ghigo@venice:/tmp/test$ sudo mount -o X-mount.subdir=3Db /dev/loop0 t2
>
> 	ghigo@venice:/tmp/test$ ls t2/
> 	c
>
> 	ghigo@venice:/tmp/test$ findmnt t2/
> 	TARGET       SOURCE         FSTYPE OPTIONS
> 	/tmp/test/t2 /dev/loop0[/b] ext4   rw,relatime
>
> 	ghigo@venice:/tmp/test$ findmnt -n -o FSTYPE,SOURCE t2/
> 	ext4 /dev/loop0[/b]
>
> For *any* filesystem, it is possible to mount a subdir of a filesystem as=
 root.
> BTRFS subvolume has some special properties (e.g. it is a "barrier" for t=
he snapshot).
> However the possibility to be mounted is not one of these BTRFS special p=
roperties.

Ouf, so the complexity has now become a generalised feature?

> If you want to know which subvolume is mounted, you have to look to the "=
subvol"
> option in the mount command. However even a sub directory of a subvole ca=
n be mounted
>
>
> 	ghigo@venice:/tmp/test$ sudo mount -o X-mount.subdir=3Db,subvol=3D/subb =
/dev/loop1 t5
> 	ghigo@venice:/tmp/test$ findmnt t5
> 	TARGET       SOURCE              FSTYPE OPTIONS
> 	/tmp/test/t5 /dev/loop1[/subb/b] btrfs  rw,relatime,ssd,discard=3Dasync,=
space_cache=3Dv2,subvolid=3D256,subvol=3D/subb
>
> This to say that event for the common case "findmnt -n -v -o SOURCE <path=
>" may be
> overkilling, there are some corner case where it is needed. To understand=
 the situation I suggest to use
>
> 	ghigo@venice:/tmp/test$ findmnt -o FSTYPE,FSROOT,SOURCE -v t5
> 	FSTYPE FSROOT  SOURCE
> 	btrfs  /subb/b /dev/loop

Why would someone do this, and what are the circumstances where it would
be required to spend resources engaging such complexity?  I honestly
feel like I'd be triggered into "nope, nope, nope, it's not a good use
of time to deal with this" if a team member did this!  That's one of the
reasons I want to document the simplest, overkilling, corner-case
mitigating workaround ;)

Thank you,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmgBcRsQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYQ1pEACvp5ksjk37GPPWsmtCx6qJGHPSeW3o/nMB
wP2BiLiOZXn2c0nuYO7iJBnN5xUCG07Dpu9q0E/4GDYA1h9Z3Kl2efCl63Fgx2pU
XqOAkzU7tLsrJUMmM46lQWhB5OQOL6vQUY66nyKK81dUGXZL3JL4eDZb3XDwI2nI
+kStFyxk8zUlnEfqtCbW+r/BPe1W78iXVhIbdidL6dTXmz0hJ9rJqo+gZIKdsosB
1euMF9SJx3gpLNOv8Hl4P453MPz0bBxjzF7zoHWAkkPbSnkHl5Vx/bgBhMqQawjd
7Z3QQop/bYh1FXp72VsE7623185rdJ4y/2WHfw4EBRfS5Bb76zJM4PMRi9DS4MU+
HfBzyEL7R3RvEpW0Y1P0VYyRGiu2GTVrN/uhV8uR7moexKR4b62OTKwkhDpYZHvW
PGQxOgHtRAFNeyp0w/hFX1XoW64rkc5U9YaIjMYDp+RKjaweniPy/ZeRKAzdFIUq
QMikGgxKRCrU01tjxLWjdqVvnQkw8IM6cb4QWsUBIADEvLF6WK7lgPnf55/fCdwG
tkE83BgwTIC/lEnaDCbUK1VlP2tZpT2S1ZVDLU/SxyHlxdHByyAzneemBFBvC6sP
UvF6h/eynkkWeuirK5fP2eGGD6a00KXkUt0l2abYyow+9JzWlsycwV7aAq3YJKEZ
fWNpb+m7/w==
=2KZU
-----END PGP SIGNATURE-----
--=-=-=--

