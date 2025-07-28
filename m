Return-Path: <linux-btrfs+bounces-15721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99DDB1450E
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 01:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1795168559
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E58235BEE;
	Mon, 28 Jul 2025 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ipO+PyZg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7CD27E;
	Mon, 28 Jul 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746963; cv=none; b=WFLEl5ZehbdYlZDH3D4TzcIM/MeTFnarlgCtVv6FHuinQoNtushl9icmt9OeGlMwVfgKjku9QlF3K3PTkHu+2ZOXZ12K2uvGIjX0uWa+i5ppK6vE+uzfqQKVlMROgLhJO/8/3eM5UXez3F4nMOoZW1T+++6zVn6IQI+S6tyC9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746963; c=relaxed/simple;
	bh=RcLh+MszlNhjcX8HX1WjD43FEcWOgVJ3DAd6Nv6m844=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAyKj/HzzxNiTcULXpOO6z+oP/NJbU4HIY/7HkFzcr1wTqWkx6SU8ITNsE1eAxM+CqRU90/1v+apWk9yhXsDojPHcWlRv9q9RKhfGCjmGmheFORF5MlWVPbEsYXArhP/CmyW9nBD+J3CbKfo1SVTfOA68ybSetbwczbxmpTMc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ipO+PyZg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1753746751;
	bh=H0F390pxwdtIa41vnoqaKWBaQIq2b+l89tRmHkpGU2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ipO+PyZgUI6G8zT1nz7leZoJ79sHAOrC+cNlCqw18kfKQHJaiFNvaxRzGCw1jtghH
	 rvBbSs1Fi86Yq3b3TIv6+VnbrmxKGnl44STsyFMx4oPuKMyBqIAM1hdBj3r5F9oAWU
	 2c7DiLYofAr+IwalbeG99C8zc1ML2raC6+gvrlUd0C+++hWr/QU2pLoTo55Jsm2xqL
	 ggkTtQ4uhtWgNBRwMPvUZBpEGVA8exHvcKaoh48Z0aWkm22EfC6q/b4qOAu9fHzem5
	 P5FX5YIaaCY9MjGFeFsESgyTxj/UOD7VuyPKgcjEnML/z491WYFSDyyLr2ouYGCrkl
	 DDgTc0V9TdSSw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4brZz2712xz4wb0;
	Tue, 29 Jul 2025 09:52:30 +1000 (AEST)
Date: Tue, 29 Jul 2025 09:55:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.17
Message-ID: <20250729095557.30be0750@canb.auug.org.au>
In-Reply-To: <cover.1753226358.git.dsterba@suse.com>
References: <cover.1753226358.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n8Y5k22YP7zojwmAF1sRl1A";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/n8Y5k22YP7zojwmAF1sRl1A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, 23 Jul 2025 01:23:47 +0200 David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>=20
> there's are number of usability and feature updates, scattered
> performance improvements and fixes.  Highlight of the core changes is
> getting closer to enabling large folios (now behind a config option).

It looks like this was all rebased from what is in linux-next :-(

Please clean up the btrfs trees in linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/n8Y5k22YP7zojwmAF1sRl1A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiIDg0ACgkQAVBC80lX
0GzAzwgAirm5fxgQtl7o18ZLJO6EtHmvkHgGBsA4r/uGHHnKSMITXD73yZHgyajD
S4FuiD3JzTldF0rYJdNREL4ONxqxehyL1LFzYU+kmHgsE0PQcgHiGjnITO2+c/qZ
ggrSBd7B4Si+OAOkkJkDlbmzKmYybWFmbdiSFwQkRfCeg5v5WM/yKRYzlsD+qFxE
05ItxghlUfkIu0njHOzrsj70VljvE+bcvojdFXUBZzEgb+106mImnGDHhWXRw/jx
9c6UctNSb6IhmcJMjnrGc1TAqk6mnyIPhsz4ri27yGcltdcWCPQZ86C9htmjY3gv
RbYVSa69i5Y3V47lBepSNkQ6MVrHIw==
=SQmI
-----END PGP SIGNATURE-----

--Sig_/n8Y5k22YP7zojwmAF1sRl1A--

