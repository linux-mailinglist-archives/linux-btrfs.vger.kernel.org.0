Return-Path: <linux-btrfs+bounces-18166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8BFBFCC24
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0959418C384E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160A337100;
	Wed, 22 Oct 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="odSIJlrI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AC26ED56
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145429; cv=none; b=F/Ejvq4SoU/iYfxwUUA4uR5qV3Ye6KEJ+KDnPwbJ5L6hg4oVcb383kPddl4+Z6TrdyGYlxt7eAIPv3vgUx2sZo0mAlblEOTWMR2XXEUzHOVi33MHCKQwvWWxAgFB0ZHYNCAKLISiuwm4PIr2nYmARGrg9+49YUpsXizFDAT5AXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145429; c=relaxed/simple;
	bh=BwJ0mlPCth007QCjieYRmARf0ePHtB0i117EylkBbo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf07onLWxP8kRh4ueY71+FGW15Oco+zL1eBlmERd3i71s3PPQazxtQL/GxTKJSUPa+aQnYPNumVhJi8nkkCMJXH41FTdOQpOflZ8Nrk0RXag/hLoWjH2qWmL+fb8l6SFYGqN299/iHj7yGlYEnRguPNdGd0omNsFhAza9HUeaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=odSIJlrI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso12347181a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761145425; x=1761750225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Urr0Pwp6g9Q/m24RX2nvnTw5QwDz3nCykIvhIq4UG7w=;
        b=odSIJlrIMzlE4t7xDQhhZrhM7u5WND0A9WBDYEeIeyCfm0bmB1Xlu+pfRFHmzhpZfr
         QMlxwDIDSjh039Erj+E/GmeAD7BkA6A8rQ6At3xS7OADC9n31kga7vFKWMZlxGpCtR+v
         PuaBHixl6haQo7tiW6yQ91aH3ApTt7qovZrvUz5Y1vGItfXwp9Whxj8lhqL5GX9gcLGl
         r+lUsEwQ5cNvA5/AMafZD3trch2z5TiHJA9/r+uI+APZFxp1ZxEDRbPllGAa9k1kg+sF
         yuRA2jbQCqZkVmdveAqGuFV2HOvL4ZuLV+vMJQEQhKzxvvbISIT2yjp94Q2lUMO8q8kl
         U2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145425; x=1761750225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urr0Pwp6g9Q/m24RX2nvnTw5QwDz3nCykIvhIq4UG7w=;
        b=hxJSp04L0leizpwAiaQa21F4kfTNFXnIOqrBNlU/LfmGOHGVvRRjTzk6jth+B07dt6
         Jgrgye1w49oF0jEcL7H6ylvJrca5o3qW9Z0dJkPA0Sgk40A0ACecQixSdj3ItkzpLfNp
         X+gBgA1Oj8TY3Ahnv3fqKd8957pGxIwXYSBcUiGZuM88OW38ymZQJdGirSNcmd6BjiEG
         P0LEzu2QHmdrJyOOXzPad9uIKhKeyGy3+XXYVea0wTuE2An/YDMKv1QHwZeFGL1YV1JL
         D0Zwg1uIctTOwXvuZ+U0S+O7WNSwVDQVhyCApbNzAyRwcX+9rhOoC8QEM8g8kO58Vipr
         JAFA==
X-Forwarded-Encrypted: i=1; AJvYcCVQLd5Mls8yODAD+7hawmHa8dWZocNZsFcwBA6n71htKRdG34s/zN2UH5+cRJQZxp7rqx6Z7hLk+2WxBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJa/IAGlJtH0Hr9RLCPt4RrNgxUez7w6nDouEIdEr+kLuVZh4
	oOVC6h1HRYkoG9i3vSgLmtlKvPFpulyy2mUIqdRClK/uCrNGz1Ln5PHLfcO0J81dSWc=
X-Gm-Gg: ASbGnctcnqP9F9iia/6ssaSV80ewSFws0qwtVGreL/TIJNlFnodaTIyBzMrdn8Mx8yQ
	615qhnHKGZSD3lb2k0avPMTpdkG+RjsJe87DWyGARyvMOqb4UrjNCn08J6fokd240S83FnDJahY
	ezQspDEEsAbVxJqDP4VfFxpalULHhtZTKUlF6vAGHYnup6D7Pq/gEu6JnlV9qkYscGiUc+Gc0AR
	uA2RohFvIRgD58uikh9ZXvmGa/qCEs3q0rXjsx3LHYWDDccsUgGyGnEKdPw/S+7hEP6TWe7y+63
	F36DR83mJg2X5I31qZcW4LW4s0IU0aUnfStsWF/g9ny1OW0rWy6s6TeZGkNNZRTBH+zVFLKU3sK
	Ceyp6kUN6hhMk5+PbONSGYmZQaKxeFDnorVqwnj10bmMOQgb1oVrraeVVlxLECJm0mqa7z5rlnj
	1t+kgG7mWVsTSCC+6wv10PgliT6mM5mdGVdEAtGaeFIg==
X-Google-Smtp-Source: AGHT+IENLxUkWo84QJk4qQJ3XIHF4EhLVGSlJkOmOGRg7JIX7RqDPNnbJ4daCB5dMI3gQO4+6ELuoA==
X-Received: by 2002:a05:6402:268a:b0:63b:f090:ac77 with SMTP id 4fb4d7f45d1cf-63c1f6b51ddmr20606664a12.21.1761145425029;
        Wed, 22 Oct 2025 08:03:45 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63c49430145sm12058147a12.19.2025.10.22.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:03:44 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:03:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: james young <pronoiac@gmail.com>, 1116067@bugs.debian.org
Cc: Salvatore Bonaccorso <carnil@debian.org>, linux-btrfs@vger.kernel.org
Subject: Re: Bug#1116067: linux-image-6.1.0-32-amd64: btrfs compression
 quietly stopped around 60TB in
Message-ID: <gcwabziwxb2u57m7tbku3wnqgsocdi3euyv7cx2yip5t7nyp2y@ncw4nxihp2zx>
References: <175865066509.3489281.5792211607743744274.reportbug@ruoska>
 <aNLr-GKpufof8HME@eldamar.lan>
 <CABaPp_jAFwsobgdk38Qhigqn+Tgb1UQK9RDJF3sCFT1_KH3SQg@mail.gmail.com>
 <CABaPp_j21HxgXFT5JZkKW1QeZmAtxYPAgWKo-nm15mWMvj-7BA@mail.gmail.com>
 <175865066509.3489281.5792211607743744274.reportbug@ruoska>
 <CABaPp_j8VZyLUtiKjnTksKqEzpaYj6vw=TEM_=CkMUvA+O3sfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6tspxdytsebzstcz"
Content-Disposition: inline
In-Reply-To: <CABaPp_j8VZyLUtiKjnTksKqEzpaYj6vw=TEM_=CkMUvA+O3sfw@mail.gmail.com>


--6tspxdytsebzstcz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1116067: linux-image-6.1.0-32-amd64: btrfs compression
 quietly stopped around 60TB in
MIME-Version: 1.0

Hello,

On Tue, Oct 14, 2025 at 09:05:17PM -0500, james young wrote:
> [... some btrfs issues ...]
>=20
> Any thoughts or suggestions?

Last time I seeked for help with an btrfs related problem I was asked to
share the output of

	btrfs filesystem usage /

(replace / with the respective path if this isn't about the rootfs).

Maybe that would be helpful here, too.

Best regards
Uwe

--6tspxdytsebzstcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj48ksACgkQj4D7WH0S
/k5wyQgApksOCWBSuFxQ4E+zhPZnV4LeGpc9OhYsWI1htbW4Ppdj/TOOhBnnyYF8
0d2pi9yKiVNQbGJrhSXtEhljsRI4OwkV9lajCm1eDnmBr1DK1p3uYjEcEaiY2u+7
XY0VzGB3by9Cn/QUEo5+C4LhQxpMHeaoe0rVYXmWMdSYemfNdfbvAY48SDkdpSK9
whUyRacpxsQcq21qHfKt+JzQLNwlhaw1qmFGc0WyDJfWpfIzaidA5R39YGUYcZBS
g778o0o2BQxPV36TuEjyKaiBJZyfftLUpnF0UmO9vb/KIx/eRsrMjGJ2RRJiOtFb
e8NZO01awvGr/plg+Wv9kKe06dZTLw==
=ioqL
-----END PGP SIGNATURE-----

--6tspxdytsebzstcz--

