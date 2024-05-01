Return-Path: <linux-btrfs+bounces-4658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D438B8BCD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD3F1F22298
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 14:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193512F589;
	Wed,  1 May 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wolfsden.cz header.i=@wolfsden.cz header.b="GblQ8tnJ";
	dkim=pass (4096-bit key) header.d=wolfsden.cz header.i=@wolfsden.cz header.b="osEkSCi+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wolfsden.cz (wolfsden.cz [37.205.8.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2112EBEE
	for <linux-btrfs@vger.kernel.org>; Wed,  1 May 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573420; cv=none; b=BQPjnPDv+A95CDxWX7GYdM0jCpjuNiIWQawKWKRQJfQDYRfdSvr/8Y59QFhzEqjgrjRdSofEEe5a6GtjG+3P7nGtnC8ZO/WpSRQC1ltVlSZbpB/fDTX8H07tbpVRtgXHd93TTboS1nCydT72SNqIOBxUMUpQNt+j9d/BRl+Gnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573420; c=relaxed/simple;
	bh=TZUH3a4Q2CnFtJa+MAvzu+ttY/GA5zsIePUkelR9VuU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thlg5MiE1teSj44y2G4FrFoGF7wJ0Ym7REKe7uS5yfokd/rkO78Th1mJJVLbKFJk0es6ZOM6g0OkarEKfQ1t8I7pNJUG2ZuSz8tpyLH/5ZirY8x8kQmNHR7HQY+QiRbUOHJKprKnut1f+zKzStIdCcVNH2Akk4jHagvNInAVUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfsden.cz; spf=pass smtp.mailfrom=wolfsden.cz; dkim=pass (4096-bit key) header.d=wolfsden.cz header.i=@wolfsden.cz header.b=GblQ8tnJ; dkim=pass (4096-bit key) header.d=wolfsden.cz header.i=@wolfsden.cz header.b=osEkSCi+; arc=none smtp.client-ip=37.205.8.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfsden.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfsden.cz
Received: by wolfsden.cz (Postfix, from userid 104)
	id 58A55B970; Wed,  1 May 2024 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfsden.cz; s=mail;
	t=1714572988; bh=TZUH3a4Q2CnFtJa+MAvzu+ttY/GA5zsIePUkelR9VuU=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=GblQ8tnJjBj+lERdWK50cr7ST4Emwzgn7yQMcFlE0npgbm9TpmLegDlXN/PMJBN/K
	 2UQ6dks8v16/iS9DkEMMlmheXuLKTcyVYsTaBcxzylB3VH0Z1t37uQ7PHhddALOYpy
	 ruuLrZR8pKtSAGMbYtwxW1b4i1WqlYZTPQ6ipFAzS/1nffB3j/PgSTPdTp1KYoZQOU
	 a9iWTsvDvQ+IUtyiUOjlVJMZslBD4P9OhuBMDgyk/F1vEcmOzggxosvmtpSdpjpMhG
	 0XUxToyYjzjj+aGLTm7EIvIxM7iIbHwv5euFuAmH5qVZ1kwWLtHIJfz07QY95bkUtF
	 QxVRsbr2Tf6QEA4qVfQtsp6bwX1eE8VKz4+0MVU/QM656zEZP+bkuYAOO9LhTaMnUe
	 6szGY5x89wiWx9za3D8hDAUSgmX7VOebl/QxeyNbg2+4IHy/hx+xMbyGqpcovQXnBi
	 DAXFehPkLc7GuHkdjsx2uQBc4kaOakRqYUG9EWY1sXNbFMA4s5KFxdMR/woqGmSYff
	 pYbWoCBpKuqb/iyI/ToQgupfL1I7xWPA+igkXRQDGsZim7jAygXy9YC9nx8nfKnwHK
	 NcBl8TiWn6NtmkkUAUoLVtYgJuz3dc6LKT3VEVO5RhyrWjNmaCOqzHPOSgG/WAuOGz
	 6oCkTGMP7KpIgU7mSbP/Es0o=
X-Spam-Level: 
Received: from localhost (unknown [193.32.127.142])
	by wolfsden.cz (Postfix) with ESMTPSA id 6DF53C5BE
	for <linux-btrfs@vger.kernel.org>; Wed,  1 May 2024 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfsden.cz; s=mail;
	t=1714572987; bh=TZUH3a4Q2CnFtJa+MAvzu+ttY/GA5zsIePUkelR9VuU=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=osEkSCi+YRSKnfWdSHQKinXYibTU0Ew6NShg4FqKJAV4djFouchy1gZNbNeCf6pch
	 d8s4KuyKr/ipJpb26SH70vAmH+rrKxHCmsoQcj0cPBiDGlvTie4uuIYylgPlbqUbOe
	 TQ8Y5dOFHFhh8YAz6cUDmHVlqHnjH+KFaLu8bDQ2dVR6Vo3nsShEavT2EsF48FUbim
	 oH06HJbi0iB62ksivaAciUGp2AAnBx+EVGk+wp7XELrxU0ekxRwsdYQS9cxO2lQwn8
	 0FuPSkXjQ8JuE7oS0gLp3ilxQU5B4JHXqRM6I9FKqtGU+oq4s/ubgf9qBzxNkFHfG8
	 aLoUwzakCi8bVRZuOpLQmeM1IkJdHiBbAVq9Zx8uUWNwh91xiNMS0tVIVbpGN/VdLw
	 v0IbyLDi3WTO2JHdYJ3Gt3GUDly6nQkTD+n+FYcEmfRvL7VK1qxBjxD1U+IbbjXMiF
	 OqAiYNCQUYXS1SClUeFwXW/kzHBuPxeQaD63XrYsXtzqJWHPxobs6vzyFt0cGhQt6u
	 R2Z6BkDfE8deEYryn3PdFSARAQzTHbAcPwrUcZ0Xb9g7WfnURHTmpLmD1O1+fUsWeL
	 77qFkNtIxTn5MgaAstA/YWtsvg0mrmIiCqQr2MPB9FmDEdRgvkh7t184aE7k8XUoGs
	 VYSGe9rZ5hmA9HD88qOARBvM=
Date: Wed, 1 May 2024 16:16:26 +0200
From: Tomas Volf <~@wolfsden.cz>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 2 PB filesystem ok?
Message-ID: <ZjJOuiu0o1PqV3jA@ws>
Mail-Followup-To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20240428233134.GA355040@tik.uni-stuttgart.de>
 <6609017e-8931-4559-b613-4b3e28d9fb48@wdc.com>
 <20240501085012.GA393383@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MsggIOXU6ct5hIIk"
Content-Disposition: inline
In-Reply-To: <20240501085012.GA393383@tik.uni-stuttgart.de>


--MsggIOXU6ct5hIIk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2024-05-01 10:50:12 +0200, Ulli Horlacher wrote:
> On Mon 2024-04-29 (12:34), Johannes Thumshirn wrote:
>
> > I have used 2PB filesystems in my RAID Stripe Tree test environment, but
> > for practical uses, I suggest you to enable the block-group tree feature
> > during mkfs time.
>
> I cannot find such an option in man-page for mkfs.btrfs

    $ mkfs.btrfs  -O list-all
    Filesystem features available:
    mixed-bg            - mixed data and metadata block groups (compat=2.6.37, safe=2.6.37)
    quota               - quota support (qgroups) (compat=3.4)
    extref              - increased hardlink limit per file to 65536 (compat=3.7, safe=3.12, default=3.12)
    raid56              - raid56 extended format (compat=3.9)
    skinny-metadata     - reduced-size metadata extent refs (compat=3.10, safe=3.18, default=3.18)
    no-holes            - no explicit hole extents for files (compat=3.14, safe=4.0, default=5.15)
    free-space-tree     - free space tree (space_cache=v2) (compat=4.5, safe=4.9, default=5.15)
    raid1c34            - RAID1 with 3 or 4 copies (compat=5.5)
    zoned               - support zoned devices (compat=5.12)
    block-group-tree    - block group tree to reduce mount time (compat=6.1)

So I believe it would be `mkfs.btrfs -O block-group-tree ...'.

>
>
> --
> Ullrich Horlacher              Server und Virtualisierung
> Rechenzentrum TIK
> Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
> Allmandring 30a                Tel:    ++49-711-68565868
> 70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
> REF:<6609017e-8931-4559-b613-4b3e28d9fb48@wdc.com>
>

--
There are only two hard things in Computer Science:
cache invalidation, naming things and off-by-one errors.

--MsggIOXU6ct5hIIk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEt4NJs4wUfTYpiGikL7/ufbZ/wakFAmYyTroACgkQL7/ufbZ/
walxbxAAp+JDRGQaIC0Ry2SrPwUDIsW5ACy0TGq8m3n/8l12qW4248fv/SMR6N2G
2CI63gya2v8wYwrV7kKwlrZnzs2S7b8k31Xm8zXfWkJqSsIcMCEs/fHsHHx3wMB+
4nMK+2P19lvRSQMCOtKk7h9klgqFrngxEe4kSGQBJEBxoc61WWUYKmQdO/x1kI0E
AhiXNJ+WRN12/gZ54R2EzE6VGGA69MbayJGO4MTSc1vrIsJ6ltnLIwcBR13QeSU0
TtVHKSpO/YIiLEBeZrPZQlZy0+A13Zym5HQZWBUzLO6AQO3FIoMFllh7Zzr1S64D
jZnVZRjtIoiDISZm7nyYh/v9LHX2bQFhoM5Nx5+QcJi7hR42rbhgmoExA/zM05WN
u3R85QywHwkS4sw2cOO4YSqr3JD7KApQ7SDHVs+Xrsgi7Du3g6Z3KRTV5VBkXd1s
1RE7IbJkXcXArUd+nmoyZpwgMfy8zsVWxjeqHkBez4Y/SGX1lW4pHYaJxbnOn5Aw
UFZrgd5/oThMiP0C0dFgTwyNNr6XtyCjkL78IUc+U8ZA+7+dsYEqEPlUJli4C7dA
ZUkl8w9FkgBKV48UdoSv8TEG86Nipb3HTZP0JnJedDuycFeZTVQjo8oNJksDhZzM
noV4g/v3aDYbTW+GIKoCxIlcUbknkFWYCJqkLVkEhdktM0WSSu0=
=HPGK
-----END PGP SIGNATURE-----

--MsggIOXU6ct5hIIk--

