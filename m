Return-Path: <linux-btrfs+bounces-9770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC789D3442
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 08:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73207B2312D
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D8160783;
	Wed, 20 Nov 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=atemu.net header.i=@atemu.net header.b="O6Ne+6dd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714963F9C5
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088508; cv=none; b=q7r9xNk/Zto6VeSts5oy0W39l3xZ650pKC8CnrnUb/N6e5EPuo86X7wV0xFpDwr6sZ9gMQ9+4smOG6+yg8L2hcI8YyuVm68mN8stmRBdVuEK7eqrcY0ttCEVE2kViraWvN55zca9aJWw91vm8uTRb3/bUJpUoyz33bhMbpHaeCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088508; c=relaxed/simple;
	bh=DfOMndIjGsv34/aBSKaqCXwWx2QvU2bdgOtVEzv6jYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGCLj+OB8d+nsvzfZj7p6NX960/nLsQpYl66+drmTpEqb5uzkhPiGb8Sr6TDL1G/ue211HSjCgSk6l7K1MEsBc1f5HOmNEHQOAiNeNbvzbNNx+4ltFLdkTWRmyXmfjhWG9ewp/WvMwLwHuSghkRlaTFxkZuq0FVUmSWoQajJ7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atemu.net; spf=pass smtp.mailfrom=atemu.net; dkim=pass (2048-bit key) header.d=atemu.net header.i=@atemu.net header.b=O6Ne+6dd; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atemu.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atemu.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atemu.net;
	s=protonmail; t=1732088496; x=1732347696;
	bh=DfOMndIjGsv34/aBSKaqCXwWx2QvU2bdgOtVEzv6jYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=O6Ne+6ddD2piPpdu0SnWjciKh7z+oyT0xy/WufV9MSBwYjVSXjym8/NAag99cvaxW
	 F2hc2R+HN6Im7X4xiY+Ns4ej5zQP9MceZv7ugNwflgPyPKJs+hI8xQAAZmIRgP+9Xu
	 kgf1/38Eij7PoeAYgyiwueY6wTVUuDIfhlpOJ8oXOQEblE7vuhFr+IA5NoqrciFXho
	 nHdOilv+ocn6XBQRC9cBqBjpimma5fit6JRVYpaSjg8UCdsHhU0hfQU900UjAWnu0M
	 mwZa6GyUyGFcC1nGwBSySu+oAu62unOVLGV4r/kLmUTJ8rtepDGq5m2K7ZSUcDCV4J
	 RxIvmAIF8hRMA==
Date: Wed, 20 Nov 2024 07:41:32 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Atemu <git@atemu.net>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] btrfs: Don't block system suspend during fstrim
Message-ID: <wnPVOgJfpl_-T0Kmx_rLagKGYDUVPe2v9-dL75Pn8evLxtS0h1PY3OGUSihwcMAJ4Q5A3heeKnYQZcPaX81_ieEwyKirOcV2ZdutRF8JgrI=@atemu.net>
In-Reply-To: <2024111923-capsize-resonant-eed6@gregkh>
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com> <20240917203346.9670-3-luca.stefani.ge1@gmail.com> <SICOALIt6xFGz_7VCBwGpUxENKZz_3Em604Vvgvh8Pi79wpvimQFBQNkDxa1kE5lwfkOU0ZSYRaiIugTDLAfM1j3HMUgM25s1rgpmmRQ9TI=@atemu.net> <2024111923-capsize-resonant-eed6@gregkh>
Feedback-ID: 115536826:user:proton
X-Pm-Message-ID: 511bcd18c705e0d7dc66634b07d64c7984fea09f
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------96f118910c6e996d752378763fb02220b244965101fa83695a6dcd1715c36a86"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------96f118910c6e996d752378763fb02220b244965101fa83695a6dcd1715c36a86
Content-Type: multipart/mixed;boundary=---------------------017ddf27874286d9994ecd49e37022ec

-----------------------017ddf27874286d9994ecd49e37022ec
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi, =



> What is the git commit id in LInus's tree you are referring to here?

It's 69313850dce33ce8c24b38576a279421f4c60996. Apparently marked for backp=
ort to 5.15+.

Thanks,
Atemu
-----------------------017ddf27874286d9994ecd49e37022ec--

--------96f118910c6e996d752378763fb02220b244965101fa83695a6dcd1715c36a86
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc9kpMJkC0PmHbu18WeFiEEtYzCY6YbbjouhlYsLQ+Ydu7X
xZ4AAJEhAP9ct6rmEBwv28OTpquRB5Lr+wSQtbBLzGnmccfIqFnlSQD/YFAr
2s4RFt90lVC6pBlYWyJPmY8aijshMd04cagsGw0=
=YEVU
-----END PGP SIGNATURE-----


--------96f118910c6e996d752378763fb02220b244965101fa83695a6dcd1715c36a86--


