Return-Path: <linux-btrfs+bounces-12999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC8A889B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A5E3ADE4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8828936B;
	Mon, 14 Apr 2025 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hBQgGFI2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F176289366
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651505; cv=none; b=eLWryDh2QTyx34h6eFr9sk4knHAXh6U97YboSTAbxkTTixBNyA6fArfD64I2MeQ4NEFrPVtGdmgnAU5/HE/kYW6RzP4NM1Ms6PjSTbRkJZHeaCHxXzL8cufI3ItgaUFoKYxy6vu8TYGBXuLiZ0cT7Nbezqfk27nJnZD7HjsvX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651505; c=relaxed/simple;
	bh=vYghHVbI7hwsuy3aemUdW+QPVbuYUWbFMBK5YaURmLM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=npRF6j1/eiA4P7hV60XrN5QRJEEhYfNdPVIc/dAYpGbVpP7laoC55zwN7sCQ2Zi6F2qtewC3VHhmDl6tvMVl4lmMvvVmhSM1dpRADFaJ+b3AQTx6AM4h00lXhMaCzLxtsd7JTLNMxbQK0skfkfD01Vm9nr4CTEjHw4ipYuWlvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hBQgGFI2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:To:From:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pvMhqn2cPbvSfsyTZqKJ9JsVi3uAYrIeR8xrPPSpz/k=; b=hBQgGFI2DCIvQZaF10UfKeV5tb
	+t87dFsjdxo20RPI2zQik0I2nICcXsI1bKY8rl8DYNBlgNyYPQdfzGSQLN3A8Ab8tZvoOqcfivYkn
	xrNYWpVq9+9j0uEH5+wvhOsMfEu18smNbQWUdyjsQX+OUaKo9CS2UMHJ3N9CURtvkOGdtX/XZFvYS
	1PC4R6bZy8s3Sgfo/ajkfLiTO+o8MxgoCuNQEqY1VCbFnaPuFVCPmQn4jP7ssr9xYaC8I4vlOXwG9
	vVXTfmv1gM61RvdjSa0Ii04aJAjMGEHI3MPOQLuglQ7b8GbWEjP9/H9hu9JEyNhjqjUdTvWThJ77t
	mjx4hsjA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1u4NYL-003DYG-5f; Mon, 14 Apr 2025 17:25:01 +0000
From: Nicholas D Steeves <sten@debian.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-btrfs@vger.kernel.org
Subject: P.S. Re: Odd snapshot subvolume
In-Reply-To: <87friais1a.fsf@navis.mail-host-address-is-not-set>
References: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
 <87friais1a.fsf@navis.mail-host-address-is-not-set>
Date: Mon, 14 Apr 2025 13:24:58 -0400
Message-ID: <87cydeirkl.fsf@navis.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: sten

--=-=-=
Content-Type: text/plain

P.S.

Nicholas D Steeves <sten@debian.org> writes:

>> just remove it?
>
>   # mkdir -p /btrfs-admin
>   # mount -o subvolid=5 /dev/disk/by-uuid/c08a988c-ddd5-164e-b01e-51ac26bf018b /btrfs-admin

Oops!  This /\ is wrong, because btrfs subvolume show / returns the
filesystem UUID, and the command above uses the disk UUID.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmf9ROoQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYUqrEADLFE8/neS7tO3J65XImtHqVTnYfoWySGeX
yc/g/VNJ04SpF0YDCf0CWwI+sAlOUPUzd8WDU3NN6JljK0P9YGYqSikkJHGB4pra
PLhlD1vaZIKeqbpZP8FtOQFoTX+ihIEAUJ0pckwAzkrt4PlBZnM36ie/izdkBmht
EG5BC7DoCrBZDkrCqhvbiD2j2SGs2+ysqJ1mJ9ojjqYSYVxcY7CTTfp4Y8jDmamN
yG5Y1LiN4d6gJLpUJarmFL1tlnUg5+SNQZUEAyDW3fd02uBEXDf9qTa+vOVSm33J
imzZ30RK/7uDOCmohjyKeJQ7AvfqD30UJmhaVCFD/NZcBcoU8a1zZ9L4DEd38WZJ
VZAw37/31uMVrTRXQAHcTKskrt059L9Ca2oegSbMmaqhw7LEefuFr7B1acTHnTkh
XC09NG8WK3aG67exxKSAoNTB5x10A/gniq2bB8+KsEELk67agqMXF0jjp+CNiyH0
/Dbepi67li01OgHmeiSO3wMbNCXyqH0cBcc8y+w2a2cRXZo6rPG/6nkUKPQI5Xlw
9nbg3rsE7nNKFhSwpHFszr1ytdnAvvfqrEmMuffHsTlKKF2nJM98N1dRBOf0XE3Y
9R5dmohyXeHsjkHUHbye09sTIxkWxTpSNLy1zJM/Exv77RSeXxeyhaUwYt1mFASq
5JM651U2Sg==
=1gPM
-----END PGP SIGNATURE-----
--=-=-=--

