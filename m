Return-Path: <linux-btrfs+bounces-3201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3E8789C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751911C20EB4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791C56B62;
	Mon, 11 Mar 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="lSAnos9U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A44D5AB;
	Mon, 11 Mar 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190856; cv=none; b=XJ0FSypZZ3QAJsZ3EHss00yqlx14yu8T8W+yH1tIGU79liW8tXLI44zQOUZeKvu31hoVNh8XR9aUgBkyom88we83gXGDe6dyC1Fw28gVm1KxvqRrJDI/MeMzibZ3YjHTXRnkx/uk46RwJs0CZUy91V+ySbaBTSTB/LXNiXpC+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190856; c=relaxed/simple;
	bh=huiYCD6OSOOJ73LaTGApkyTSW1a8n0YAyt7Da0lmbuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k90+im5BAoAzKULl5yBSBJM5zY+yx8mxgasR2xTOlYn+glD6amW9z1qcgg1TyG8Pugml5aBBVF+/fbUHwx1L4CBZqRYdAKgbl4ojIMJe79bray4qfuvolKNr5gH8BnTc/GlTlGvIo6o20MT0XUWnUXEl5V3Yko4yxF6sMLHEjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=lSAnos9U; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EDB461C006B; Mon, 11 Mar 2024 22:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710190843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRG5QydhOxCq5Uyj5YlfVbwbsUoHAirIzqiitHT1/Wo=;
	b=lSAnos9UsUozQksq3TeKs8y9lTnD38UPL2hfSMIn1nodKNZZ2qKuCvmjggHhgfCPipB/+8
	WjkRmt25zJVh5E1QPMSqU6aDu06tCP2bp6fq9al+kJnj+/N7Hav69CCv+NzxdN2/PMl/I4
	ZCOIQi1DccJr+BwUjOfRyX00MvZkwnM=
Date: Mon, 11 Mar 2024 22:00:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>, clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 1/7] btrfs: add and use helper to check if
 block group is used
Message-ID: <Ze9w+3cUTI0mSDlL@duo.ucw.cz>
References: <20240229155112.2851155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fhKTT6iKPlPYyrIx"
Content-Disposition: inline
In-Reply-To: <20240229155112.2851155-1-sashal@kernel.org>


--fhKTT6iKPlPYyrIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Filipe Manana <fdmanana@suse.com>
>=20
> [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
>=20
> Add a helper function to determine if a block group is being used and make
> use of it at btrfs_delete_unused_bgs(). This helper will also be used in
> future code changes.

Does not fix a bug and does not seem to be preparation for anything,
so probably should not be here.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--fhKTT6iKPlPYyrIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZe9w+wAKCRAw5/Bqldv6
8sMpAJ0aS87z23pKrfRwqSQ9hkpnZ7ED2QCfZoSpbpYedTtyY1hcI6paA5MRvlY=
=k/uE
-----END PGP SIGNATURE-----

--fhKTT6iKPlPYyrIx--

