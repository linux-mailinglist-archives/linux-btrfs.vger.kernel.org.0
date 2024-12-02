Return-Path: <linux-btrfs+bounces-10003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6764F9E02FF
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 14:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A15B28E62
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2401FF5EA;
	Mon,  2 Dec 2024 12:04:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664B1FECAE;
	Mon,  2 Dec 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141049; cv=none; b=Kxv6CLE+1BEWQVoWQzkELn9iFZVZ1P2Pp5qwJ0hEPmkZgRydrS7KUGnCn3QgPXYK/X1I9g20y9DEdPpDY38A7HNxb5cNufLL5ZAxwvYKxCZCRBdegPa2rrrtOPs+k4AtwtBLtN1RDKnjnmYZtV4l3RoGBHxCgjDJFLNnnvCjoqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141049; c=relaxed/simple;
	bh=pM/OrLNxROYcJ7+l2eV3d9qX3VqSYGKWpHph9gbWwFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQTzDyuyRkJ8AvvsKX3mO0K/6dqs6khUFcm/++tae3cf4vqd7O0EAFGDOVhvk7qv1ipz9ib0ihyEs6NTUOFCo8W1WawrL+nFeRCQVG8MFrQXXG20ZBd0204MyflgovmBpoDuqVnftBUSqZm8n+L3U7QhBrVPp4v315+NKeeSjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0D8351C00C4; Mon,  2 Dec 2024 13:04:05 +0100 (CET)
Date: Mon, 2 Dec 2024 13:04:04 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>, clm@fb.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 2/2] btrfs: fix warning on PTR_ERR() against
 NULL device at btrfs_control_ioctl()
Message-ID: <Z02iNPcVHpjPtHXR@duo.ucw.cz>
References: <20241124124231.3337202-1-sashal@kernel.org>
 <20241124124231.3337202-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UBKiVcZwAh2stw7"
Content-Disposition: inline
In-Reply-To: <20241124124231.3337202-2-sashal@kernel.org>


--1UBKiVcZwAh2stw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Filipe Manana <fdmanana@suse.com>
>=20
> [ Upstream commit 2342d6595b608eec94187a17dc112dd4c2a812fa ]
>=20
> Smatch complains about calling PTR_ERR() against a NULL pointer:
>=20
>   fs/btrfs/super.c:2272 btrfs_control_ioctl() warn: passing zero to 'PTR_=
ERR'
>=20
> Fix this by calling PTR_ERR() against the device pointer only if it
> contains an error.

This patch was wrongly ported to 4.19. It is not needed there. Same
test is already performed 2 lines above.

Please drop.

BR,
								Pavel

> +++ b/fs/btrfs/super.c
> @@ -2283,7 +2283,10 @@ static long btrfs_control_ioctl(struct file *file,=
 unsigned int cmd,
>  					       &btrfs_root_fs_type);
>  		if (IS_ERR(device)) {
>  			mutex_unlock(&uuid_mutex);
> -			ret =3D PTR_ERR(device);
> +			if (IS_ERR(device))
> +				ret =3D PTR_ERR(device);
> +			else
> +				ret =3D 0;
>  			break;
>  		}
>  		ret =3D !(device->fs_devices->num_devices =3D=3D

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1UBKiVcZwAh2stw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02iNAAKCRAw5/Bqldv6
8lTgAKC3bd8uzGQArBotjP/A2zgfWt59IwCfULDTDPWvLesqYqqPZ/deicBdlwk=
=2XmC
-----END PGP SIGNATURE-----

--1UBKiVcZwAh2stw7--

