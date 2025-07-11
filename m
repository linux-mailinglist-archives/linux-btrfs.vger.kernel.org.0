Return-Path: <linux-btrfs+bounces-15448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F9B0152A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A313ACE69
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA6E1F4282;
	Fri, 11 Jul 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dF1berks"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBE2628D
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220175; cv=none; b=HFdODEbDFGK9UPg2dKJooSGfFL09tP3Hr4tltvn82hCP1vSB/Mu1M7nO22nhUQ1bxqhGKZkIe54u+RKiM+c1FT5mdNdlG0aLAw3j1YVBu720VN1efZPLBpA+//r6C/7VSnvPjyUprq91Y8grSigRDSM7Gpz+Zc6e/n9XNldSm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220175; c=relaxed/simple;
	bh=AKry45gbUodU5yvg2/Q6QZ2Fq6zedV9Die7NeBUTE6c=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzCofsPkVREBQXfHLYYJA1VzcQc/LBdC+AbdmjWammH8Ds1kLqPN1rjFSUsYqs2IZQe2/HrZNf+MDjCy/r5rA+1nB9xlyeebxlNsmLMl422oljJmyttj66vj3Ijwt4MykoobARofCxStFzUsNqCqcaztbtt2j91wrPFqK6SLQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dF1berks; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1752220164; x=1752479364;
	bh=AKry45gbUodU5yvg2/Q6QZ2Fq6zedV9Die7NeBUTE6c=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dF1berksn0asZZHrHQazg3P2E9BjExTN1Cqtkw8kcnoCKXpMjj/GFz2lNTmqm5BCp
	 /TubziMYPAFI1w/BeosUK3WUT6pm04POJMUx2fEXvZnSAZJ08dtnoIZdyNl6uILMEO
	 FjicjU8IrZw/bZLWgRopEZsFtHzrlMoDevl4Ng5Rm6409xTEwaxWTclRjTHrzBJAiO
	 2+Bk+EbZmIhAAAjdVCuD8JQJNBkzdRuKXFL7azBrGJ624R77dnRHIWCZq394Q2u7X1
	 tl+yfnfZr9Cy9M0USGZgxEYVT3L6duFFNU/nhZMMakqL2YnwbfK3GJpq8rvpwn7+rg
	 1v493x82o6jiQ==
Date: Fri, 11 Jul 2025 07:48:40 +0000
To: Chris Murphy <lists@colorremedies.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Pranshu Tanwar <pranshu.tanwar@proton.me>
Subject: Re: [help needed] parent verity error on HDD
Message-ID: <CV0Cy2IvhJ-cc8hF7MAwDqkOFC-Kn-7nkliHwX9bMVm_0IpHRik_NN5JqpCQTDDiel762J_kQ7AiTSj5NrLrm-7_hWwZJh_OdouDAyWoan8=@proton.me>
In-Reply-To: <da43965b-d22c-405e-bac6-206b36e968be@app.fastmail.com>
References: <CAPYq2E23F7VdgtwCydEVa9wdomEVbQUsQPgfyLVh5ac=KLBEdw@mail.gmail.com> <CAPYq2E2BSbW=8mYOO2NxJtcXPgPZ75nzH8C014-2ncyFb64L2A@mail.gmail.com> <1332fd28-ca5c-43d0-b815-c8da74c0a7b0@app.fastmail.com> <aNH6WIV_zJGBEaJfeLnCw0RqDLyn8O8OMUPMm-S34So8BWqu8xJP4iW8rfm3vGu6dDr8ibw2vt9EOaOfHIUgn5NxNQsuleebWRsBiyGOpYE=@proton.me> <da43965b-d22c-405e-bac6-206b36e968be@app.fastmail.com>
Feedback-ID: 85372792:user:proton
X-Pm-Message-ID: e34eab47587b796c2b1708e6b7e6e06e5ad13309
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------e3e826dae1ccd2055f7866077431f2a09322410327ba016e56f94ce47cb11247"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e3e826dae1ccd2055f7866077431f2a09322410327ba016e56f94ce47cb11247
Content-Type: multipart/mixed;boundary=---------------------11a57c0d5ca1fbd834d7042ae740f2da

-----------------------11a57c0d5ca1fbd834d7042ae740f2da
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

> I don't know how udisks2/mount_options.conf affects anything. It should =
have no effect on the root file system. Anyway, you really want to use eit=
her upstream default mount options or your distribution's default mount op=
tions. You will run into trouble much faster otherwise.
Its not my root filesystem, I keep two external hard drives mirrored with =
btrfs snapshots. One of those with the latest changes got corrupted due to=
 being unplugged.


> I don't think you'll be happy with the performance of commit=3D1 , it's =
too frequent. If there's a firmware bug resulting in flush or FUA transien=
tly being ignored, then decreasing the commit interval just makes it more =
likely you'll run into a problem.
I mean its alright, it freezes every once in a while but its fine
-----------------------11a57c0d5ca1fbd834d7042ae740f2da--

--------e3e826dae1ccd2055f7866077431f2a09322410327ba016e56f94ce47cb11247
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmhwwcQJkAWauRYNs28hRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdPUpg8REQWI8+EH6WKc7URRVdXOyfRvpfwhY3V
vAS98xYhBBxIJHKxg0tc88BSyQWauRYNs28hAADEmwEA5AXo+lhzFbXoBIcU
gbr8zfd6BowAfpNNcAST386PV98BALayTywNvHDj4biDMzJaJzyLEr4GNU3x
FLXoLM4oLXoP
=Qd2q
-----END PGP SIGNATURE-----


--------e3e826dae1ccd2055f7866077431f2a09322410327ba016e56f94ce47cb11247--


