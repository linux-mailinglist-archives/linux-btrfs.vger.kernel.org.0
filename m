Return-Path: <linux-btrfs+bounces-9762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E139D2108
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 08:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67059282470
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55FB197A88;
	Tue, 19 Nov 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=atemu.net header.i=@atemu.net header.b="uNb/7yRL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5D1531D2
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732002912; cv=none; b=CWln/FcWTtxML32vx+zDdFndj567Zf37CLgSd8dRSbNFi1SY0lJOiU2PBXQfPfzmXl4/1emsAJOjFODiSsh02EnON8gHtvNSL7/aUWqhcWvgeun0Gd0/EZSN1BYkag1q1nwI6kaC1IB0QyWaFQm2hF2iceJ7w/QQSkf4VMgLTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732002912; c=relaxed/simple;
	bh=kWVeBiVXwayvPrhjxPRTL9ZXv/hyXh5MX10g57FU4m8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkvOSdwQsTQlffpi1eM1K5Wx8rTGFCgDnaSN7JFXlqE+XNdblSPVGz8xrPmPuSNSw1fzz0coGUT5BoptjMdOu/2IP5P0zmlf3AsuYlhMNMwsn8L+y0KdrIosHunhj8/JYIF9zjsSFCqYukSdXVO+CuMv93KF+Cl6nGFNH5YEKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atemu.net; spf=pass smtp.mailfrom=atemu.net; dkim=pass (2048-bit key) header.d=atemu.net header.i=@atemu.net header.b=uNb/7yRL; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atemu.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atemu.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atemu.net;
	s=protonmail; t=1732002902; x=1732262102;
	bh=kWVeBiVXwayvPrhjxPRTL9ZXv/hyXh5MX10g57FU4m8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=uNb/7yRLBrRQGeAx0QXEYUEsbxFml0NrVmTNdEI66tLNRydIm/b58U3D6HNV9FNeC
	 CJG2SoVmR8sTP7z0iTtZiQn8zr/pXIgzgCgVDZnazT4mrUIIqaQ6YhUK2sVHWtCr45
	 WsM7mx0L8EtimhFc5dwoWSS1hOMMUgBR3RHbGPG/OsnNCSEDw9wKOQpm5kyJYKfvYo
	 rAtz4Fn/C6RNblpE6nPNJg9lYD5Mp63lGvbVeDSrkZ+JGZlYANsS8I1x0MSnng+AdW
	 NaZxI0p8+gyikZWtHbk/NqD0196W3OmbQxl1KvB0cv+Drt9i4o3/0rVgWZyFp8FG+u
	 6OVNRwzdReSoA==
Date: Tue, 19 Nov 2024 07:54:58 +0000
To: Luca Stefani <luca.stefani.ge1@gmail.com>
From: git@atemu.net
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 2/2] btrfs: Don't block system suspend during fstrim
Message-ID: <SICOALIt6xFGz_7VCBwGpUxENKZz_3Em604Vvgvh8Pi79wpvimQFBQNkDxa1kE5lwfkOU0ZSYRaiIugTDLAfM1j3HMUgM25s1rgpmmRQ9TI=@atemu.net>
In-Reply-To: <20240917203346.9670-3-luca.stefani.ge1@gmail.com>
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com> <20240917203346.9670-3-luca.stefani.ge1@gmail.com>
Feedback-ID: 115536826:user:proton
X-Pm-Message-ID: 83f096bfceef981217715656edaa16007a8c928d
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------e53d6de09d4dc89fe932b4f735c155aa0d5c2320e0d5c0382c23e6bfb0c4902d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e53d6de09d4dc89fe932b4f735c155aa0d5c2320e0d5c0382c23e6bfb0c4902d
Content-Type: multipart/mixed;boundary=---------------------7367a1cbdde9f3d1ab7931db9731db0d

-----------------------7367a1cbdde9f3d1ab7931db9731db0d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi,

forgive my ignorance of the kernel patch workflow but it appears this seco=
nd patch was only ported to 6.11? Only the first patch here was ported to =
LTS kernels (i.e. f00545e8386e228aac739588b40a6f200e0f0ffc).

I just hit the bug this fixes on 6.6.59 (I need to update, I know) but als=
o checked Greg's v6.6.62 tree and it's not in there either.

Thanks,
Atemu
-----------------------7367a1cbdde9f3d1ab7931db9731db0d--

--------e53d6de09d4dc89fe932b4f735c155aa0d5c2320e0d5c0382c23e6bfb0c4902d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnQEARYKACcFgmc8RDkJkC0PmHbu18WeFiEEtYzCY6YbbjouhlYsLQ+Ydu7X
xZ4AAFhzAPdoPsNNsBa+T/T26HxkvnFWSU1LjCeVFda3YVMC08rrAQCknfqG
imeccyu4DQF4RhoTwNYuz8310ijuwmRRvEgiAA==
=xCai
-----END PGP SIGNATURE-----


--------e53d6de09d4dc89fe932b4f735c155aa0d5c2320e0d5c0382c23e6bfb0c4902d--


