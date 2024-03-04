Return-Path: <linux-btrfs+bounces-3002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACAE870AB9
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0651C22195
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA27979DAD;
	Mon,  4 Mar 2024 19:30:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3C79957
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580625; cv=none; b=To6H7y5NX3XFdtmpPANd+8O8aOlcofJlgfgAQAZUaLcOriv53EjN+MylixXmGlfS6pAnytrRjPooetLgVVOcaU0i1cUuF5bjF9DtwsxB9NknFAZCAarc9dD5SvfzQ4IiGjXLG0oHuT+emh9B9eXNjRxYJh+qpHKJkA1ZMzmvtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580625; c=relaxed/simple;
	bh=AdW0/tW95RBkxCFAirggl0Fqq0EOM+u6JhOzEZaEKK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvqRVPwUb1gbGZf+rfeN/RC77BtKQSeScuOCQoq++f1/6fJiQnWXcPl1IE/ZnP4530Md6pNwJ2+rZRwupqnR3WVpQy8IFM082PTc4bSHZPVSpQXzFeyeexlSScMwLNlp9Xerf0JGxqRHs1/QofRhqvTeIlE6Gih9tEix8i1NBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 00000000000200AF.0000000065E62146.00336F5A; Mon, 04 Mar 2024 19:30:14 +0000
Date: Mon, 4 Mar 2024 19:30:14 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Issues in man pages of btrfs-progs
Message-ID: <ZeYhRgJvwOjAhOgk@meinfjell.helgefjelltest.de>
References: <ZeRuEH029j3enMr0@meinfjell.helgefjelltest.de>
 <20240304182252.GN2604@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-3370842-1709580614-0001-2"
Content-Disposition: inline
In-Reply-To: <20240304182252.GN2604@twin.jikos.cz>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-3370842-1709580614-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,
Am Mon, Mar 04, 2024 at 07:22:52PM +0100 schrieb David Sterba:
> On Sun, Mar 03, 2024 at 12:33:20PM +0000, Helge Kreutzmann wrote:
> If there's a validation tool that would identify such problems I can add
> it to the documentation build pipeline or at least to the CI. Please let
> me know.

None that I know of, sorry.

Thanks for the swift handling.

Greetings

       Helge

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-3370842-1709580614-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmXmIUAACgkQQbqlJmgq
5nDTBw/9FZuicK/9JNqEsERaiZVlgpNd5L4Rs2LzWYoJl6nzFln/f12xDk/QrKAV
niZaV8szEyyT4A4Sn14bNxdl9AA7DIEPoY4ZVoOK0dA1BAMzXP/2bBugbUkQHAtc
NiIc1BdxmhdISIoG7XlQEM5QG7RKyj4Hs1dIKlKdLrCd9tzp6U9IdE3K2FrPje9y
mCJZYikKQqOEyDYpnGiuBcbaULlzH+zp3Lj54ka9m/Ix3+Cy/OsYwbp+a+o3NNlq
1roAIareGj6eWIgp48q8p5VqsDmaWhc68o7y+C3DyXf1PcX8i0bbvvDrqrhtHmyC
z0Jjky+PZhKV1VPa8SlpOy8Dres4LA7KzIMcGu5G+9PVZq79/CCxvJeOz84HyDuJ
T7YQzoUNDYDAQ1puQpRlCPiUTD2SR/SIglSbSRcXymrKvGaO4ePQ7QW3f0addryf
k0/SfC0Vd1euFljRDCm2iN+ZRAYZ/aiCzjQYnDIwCt8YJZVclMeEcFic2w5S5+LX
YXQSu03Ymrg+IyRXySk4sOhUSEnKNvV7n1IlWyv6kyoPLMyy0NgRWhRWdkr+aB3h
9jkfFVUXcvtIWao4rtm2BZ4Z60osn2EqlI3oxyeyYxfLPGvtc95L2yaEGLhsTenZ
vuhBWoHbKf5wbZzhBqKfCDRmWiYNQFTGqX/6HtPZ2tj6QHuRAX4=
=YjM/
-----END PGP SIGNATURE-----

--=_meinfjell-3370842-1709580614-0001-2--

