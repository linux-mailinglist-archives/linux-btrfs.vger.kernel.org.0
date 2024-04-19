Return-Path: <linux-btrfs+bounces-4425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430798AAB4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 11:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21F5282EC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EDC77F10;
	Fri, 19 Apr 2024 09:17:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1DF9CD;
	Fri, 19 Apr 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518247; cv=none; b=YWWax9fAdjswT9TX292lZCu16HwQ/vfDF5NT6o4aJZp08bUXiHwqjZYtC3mt2dDSNPpyDfD8GpLFfgThDNjQg6B2ylphoe762TfUHoVZaGwxxDGnbLCVaEy3Gw63Xxeq7oa3j5QFxsxCLpfU2Ttor3mXuf3fhi/tLk6U7LOgZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518247; c=relaxed/simple;
	bh=fVtm2MQDOR/x6RlSD7/xIApw8gEH7eq2JLBMAl1iBLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcLGPH8+HpfxIeBtOyAhzyIFvt0IATGdongaG7t1mks1XanLFSRH7nXNwXKn1mWc8PfgLGQ6XWTgAW5Yx1p1uhLN/HQoxZu1mx9/PPbAbE5WaTKLqkoRw7k2+AgpIVE/gKSqZ7Zx2C53maNcUYmQoUCKbsHhxEoz5qCLmSiFrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CD4911C0080; Fri, 19 Apr 2024 11:17:16 +0200 (CEST)
Date: Fri, 19 Apr 2024 11:17:16 +0200
From: Pavel Machek <pavel@denx.de>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Pavel Machek <pavel@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: add missing mutex_unlock in
 btrfs_relocate_sys_chunks()
Message-ID: <ZiI2nIYK0X6RLciF@duo.ucw.cz>
References: <20240419-btrfs_unlock-v1-1-c3557976a691@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d/xyR8aY9qMuo2Dt"
Content-Disposition: inline
In-Reply-To: <20240419-btrfs_unlock-v1-1-c3557976a691@codewreck.org>


--d/xyR8aY9qMuo2Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2024-04-19 11:22:48, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
>=20
> The previous patch forgot to unlock in the error path
>=20
> Link: https://lore.kernel.org/all/Zh%2fHpAGFqa7YAFuM@duo.ucw.cz
> Reported-by: Pavel Machek <pavel@denx.de>
> Cc: stable@vger.kernel.org
> Fixes: 7411055db5ce ("btrfs: handle chunk tree lookup error in btrfs_relo=
cate_sys_chunks()")
> Signed-off-by: Dominique Martinet<dominique.martinet@atmark-techno.com>

Reviewed-by: Pavel Machek <pavel@denx.de>

Thank you!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--d/xyR8aY9qMuo2Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiI2nAAKCRAw5/Bqldv6
8sZaAJ4xe8Los8Q9+crUyfsKAtYLU9NzHQCgsXwYrzAz9gTdBy8Cqqum4uHMIYA=
=t1ta
-----END PGP SIGNATURE-----

--d/xyR8aY9qMuo2Dt--

