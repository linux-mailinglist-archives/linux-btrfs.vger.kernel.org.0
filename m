Return-Path: <linux-btrfs+bounces-10605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F19F7A5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 12:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E487A3441
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294D223C67;
	Thu, 19 Dec 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iBWFMpQ6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9F1C5CD5
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607663; cv=none; b=oI3Sotw2s5tAz1g9To5A0SV8WfUrkXPrexbfovYWH4vd30+bRQh3jXXgoSZTnCjwlSLXbzwty287Yf4YkcRAsH5jq9ZKZevXiQJ0GlEVLGRY5JZVovCCEEUvDwojvdf09ybTyX5/dCezJQQBLPQFG4Y4uejzsgYHLX9yvoyGaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607663; c=relaxed/simple;
	bh=obQQj7xJJ4xvc0GD3D2eCU6m4MtHiAZKP7TLYTBaHhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2OIfZ4OsxOtJ0O0rFN7mJbhYUHnRl498YeWU85il0R/D1qHz/HWicLQKEAGPUTSAeOEo4iBnhXtcAyxG8NDhVaCv4GP8mlN8kVu6m1CDinOmUHVX9stiH7NlcBzSv1kOzY2+oyytJW3WWk1sYjKigIudt49w/fGWO6XIc+ZRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iBWFMpQ6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0Gs3
	3kdH0d94z4eYQ6TbXxfPFkVifuZ2PLsD5d/dAE4=; b=iBWFMpQ6bxzCq0hutXl2
	LaKDswl9oiMvibQ1OlZR+HIZfa9jIXuqVUZpx4EApH/HHK1zDbx+wiAYcRrq+kCU
	i2abFAtMMgao9Q6Omvq8RTls3sUSnVY9JeQWUgLKVif2WwKA7VKXMt+qCFc8FFHk
	bPqaowkuB/hj6o+BVWC90/KeY4SZHVK79PwL/ts1AThalRBXCChfiZ1WnuTxA5sf
	M2p+S5T4898svR0KFqp8zL6qz6Ivav7tKKt47wWFZxPv8ky+/B5lVXc+WEAWRyqQ
	H5VYyeXkFCOFnl1b2oZbnMw8JdXLHAEgzTPJjcbsjo0AyDDqoIBZhBy7ruDOYOAI
	MA==
Received: (qmail 651549 invoked from network); 19 Dec 2024 12:27:39 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Dec 2024 12:27:39 +0100
X-UD-Smtp-Session: l3s3148p1@UrFf0Z0pPqsgAwDPXwAQAA/MfjDm1Sk8
Date: Thu, 19 Dec 2024 12:27:39 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't include '<linux/rwlock_types.h>' directly
Message-ID: <Z2QDK9uFrXUIhJn2@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20241217070542.2483-2-wsa+renesas@sang-engineering.com>
 <0199c644-dfd7-43ce-b02a-459461299fb7@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rGSDjvVyfiw1oLIc"
Content-Disposition: inline
In-Reply-To: <0199c644-dfd7-43ce-b02a-459461299fb7@gmx.com>


--rGSDjvVyfiw1oLIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> > -#include <linux/rwlock_types.h>
> > +#include <linux/spinlock_types.h>
>=20
> I think we can just remove the *_type.h include header completely.

I agree, spinlock.h is enough.

> For non-RT build, spinlock.h will include linux/rwlock.h, and
> spinlock_types.h unconditionally.

Yet, isn't it always included unconditionally?

spinlock.h -> spinlock_types.h -> rwlock_types.h

I don't see any conditionals there.

Thanks for the review and happy hacking,

   Wolfram


--rGSDjvVyfiw1oLIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmdkAysACgkQFA3kzBSg
Kba79A/9F7NWNXg5FJC+A57xbLq3sdd64THZECrpL80mgjZhFoUUfc7i3AxvJM+o
2B8pNsj6V8hME02sHnkH46vpqCaEHl4KqP3zlcPNfjFreTQTBoMC+9XlnODUlF1S
AOges2BEn2Vgcfp4HiphYvoAq0auBXjT3TODV/5S5mcs6yYWfvj+Mvzuga03lB5z
LPKr/vBiU/C8/VmKOfZDC72Pa+5jf0LRsHIg9MecEyVPqYOCHyydQYB9tSIrzBe5
4yy+ouzMKLZLupS0upa6+gHU0SIN04j7oAhNhFuzIcBz+x8qYnqJAGXmBgX6+ADy
87Mr3qW83KZqJc//Qtl117AckSLsoDyMGN+CMy1C0H41rE+VOf0qgddY0rE1FSgj
THQlMtHmOHI2IJVOW+kKJMtrHG2uOapHsfMd1sx3xxQ+Cw1C6xkMQPGM8i7Y6du4
eMi7p7kI220Mczrbt+JFPU9Aeb+dAJF2ZVtASXoq1GmdoI6M06gYjSTk8CGjvE9g
Vnz4Y0RehPS8nJEE4gDQq053L8wzNsho51ONlbQ/Os/fzoGLAdGHjKYPbsVNxUWK
DXt79ZATusuFbdgB1CU5g6XzObYf6AfFExVLfV+alU7jwT6XmCwZQSKo16M2lwGe
Q2hhlnuFW8i4o5IZwb6L7XHk/6YYDyZ79WklWGJPTDBX2Gqbk/A=
=SnX3
-----END PGP SIGNATURE-----

--rGSDjvVyfiw1oLIc--

