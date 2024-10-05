Return-Path: <linux-btrfs+bounces-8573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE91C9918F6
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 19:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED2C2822AE
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749F1591F0;
	Sat,  5 Oct 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ma98UlFw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8814D29B;
	Sat,  5 Oct 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150058; cv=none; b=AK8TVhwYJGXjB1ap56VS5/SjOYZgXOTAkQjj9SjFvQ5mUcx5hcxvUICDuRQpP5gSL/a7WWq6nG4u9dStzJc4bVf9v52Xvb+kkVvjNKECe+o1UJbMfeyZIzuZvc1PHi/q2f6LCAIMWb+xwuAcOZTAIJqnmq8D/EF8mqyXXkwbOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150058; c=relaxed/simple;
	bh=VAd/yLm3XIw5HQaf5ZKgozvfO8p4FW4SgJ4KYjCCJTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifEuwtabuU3AHAdWSAjCKCBOBPqUkbVMAKX6L+8KoXrStUteYgiuRJPznE95Rj5kldRFDq3kH4haPKYKOBYURxr5EP4bHMDHWbPUTw9ONJjwvWZvmqaa1ONFX2M8VRwKpoQ0ouEEbEPD8dZthL49azf1+MBbGrJ3nqDPj5yaz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ma98UlFw; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 05B701C0082; Sat,  5 Oct 2024 19:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1728150053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9vZfUZ8s2oPLQ0d9T0cl/XttnMZ/kA6jZ27FANk90U=;
	b=ma98UlFwwgyHwQW/JPb1qMmH7qbwgN2At3u69m7SUyv1X7fETQPtnotSpchORkcgIxU0eV
	OBmukeo7C2JeVSkrimRGOtM5+ngF8c8fX16msEB6TqA3VAIzrgg7qFJNVxHRjqzMcGVSQC
	GpPONkwfOgrzTbJOQeBmPj1muReAc2Q=
Date: Sat, 5 Oct 2024 19:40:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	linux-pm <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Root filesystem read access for firmware load during hibernation
 image writing
Message-ID: <ZwF6JEHIQda92sIL@duo.ucw.cz>
References: <3c95fb54-9cac-4b4f-8e1b-84ca041b57cb@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AzanCVSKuR7/7bLf"
Content-Disposition: inline
In-Reply-To: <3c95fb54-9cac-4b4f-8e1b-84ca041b57cb@maciej.szmigiero.name>


--AzanCVSKuR7/7bLf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In my case, a USB device (RTL8821CU) gets reset at that stage due to
> commit 04b8c8143d46 ("btusb: fix Realtek suspend/resume") and so it tries
> to request_firmware() from the root filesystem after that thaw/reset,
> when the hibernation image is being written.
>=20
> It usually succeeds, however often it deadlocks somewhere in Btrfs code
> resulting in the system failing to power off after writing the hibernate
> image:
> power_off() calls dpm_suspend_start(), which calls dpm_prepare(), which
> waits for device probe to finish.
>=20
> And device probe is stuck forever trying to load that USB stick firmware
> from the filesystem - so in the end the system never powers off during
> (after) hibernation.
>=20
> That's why I wonder whether this firmware load is supposed to work correc=
tly
> during that hibernation state and so the system may be hitting some kind =
of
> a swsusp/btrfs/block layer race condition.
>=20
> Or, alternatively, maybe  reading files is not supported at this point and
> so this is really a btrtl/rtw88 bug?

I'd say not supported at this point. Reading file may still read to
atime update, etc, and we can't really can't support that easily.

Suggestion is to keep firmware cached in memory, or at least cache it
in memory when hibernation begins.

BR,
										Pavel
									=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--AzanCVSKuR7/7bLf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwF6JAAKCRAw5/Bqldv6
8iNhAJ9rXSgZSqHjgeaD4NEroan26onCyACdG2iw2e9t1Xw164dPfjFJlAMuVa0=
=QhxX
-----END PGP SIGNATURE-----

--AzanCVSKuR7/7bLf--

