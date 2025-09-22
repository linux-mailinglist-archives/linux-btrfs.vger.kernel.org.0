Return-Path: <linux-btrfs+bounces-17041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8481B8F680
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA5B1755BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5952FCBF3;
	Mon, 22 Sep 2025 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=lukasstraub2@web.de header.b="fXql496u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB4244685
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528458; cv=none; b=tMdA+9n1wmcmrWMxx4x/w3RcK0d1cRZ3quiY2V+qWOPgkHpzEURZS4PqMQgX+Nw2K5nspRXs+h2NNgBKWlvNVtT0902n3Ta3naJhvz+JVwdpf5cO9oUq38Pvj/8DFlZhNkRMpsOoihO3KkoSkcWnXmeRY7OeH5qKXXqTdPUx3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528458; c=relaxed/simple;
	bh=8SEyte1DUl+ypoxs59pJHgeMAOmEvAZAAK7TXZdHntU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3UQKQP4sDUrUcnAzOl+poB1XXDxko/6GllKnovrPfi3OMMAk2YZtXOgiPqbA4tCeEQuS2K3Mqki0pv4+fLHpzDTsjsyrd4CfpnDdRob1OaMvVO8g0qtikoUaG0AGSXhcaI+TPvwqYd/MeviCE+9vqcDZ/nF1FzDlPY/lWwEJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=lukasstraub2@web.de header.b=fXql496u; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758528446; x=1759133246; i=lukasstraub2@web.de;
	bh=8SEyte1DUl+ypoxs59pJHgeMAOmEvAZAAK7TXZdHntU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fXql496uCayL53WFf4Bp+BsrgJLcKNxhBT/UXcbyWyg9umUXUi9IOD9FkjswMqnY
	 pDMhNp9M9KY26prRVhhAj1VLvFwflNtd0jbYFG9dbDrK+lphBI30uBxpHHL/9TNB0
	 BIyQ50mg1IUb2DpBvACSsu83K8P2tzUtGepxRRZ5mJ5O1WQIjZBoVAkN9kLABST7M
	 mJ2oqRYnXqnkdkOi19KQKEWac8y3DD5aCdw/nDhQXahku/DoWbiABQCAq+ofWgXl+
	 MMVPDaFfxMW5lgp37Q7vAXB2CD/NzNuw7GuHPdyc7cYOzQPaWJFedwxLARNn+trHZ
	 WX0fUQKd9of9W6HBpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([84.133.46.123]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d3k-1uL3ZO0tT6-011lPz; Mon, 22
 Sep 2025 10:07:26 +0200
Date: Mon, 22 Sep 2025 10:07:15 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
Message-ID: <20250922100715.7f847dc0@penguin>
In-Reply-To: <20250922070956.GA2624931@tik.uni-stuttgart.de>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+gDkQy2XVUmKZF0iFKIdg+r";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pAFOjH1gqu1ltWMfdsII6vqn/G0DVVPYlDmBXL7zXRtm06taBXB
 63D6rJweeF7jKlWTZRz/Np3ZRnthmnHKkFZ40q3WgJ0UWPpj+ryf4Kyu8H41wCIWVpK+VKO
 O/vbK0Iz+OWuVLhcUcjQpL1kVojUxBfvZ2PNmT9iLxMCaVMWFZdwplzsZKv4AVBXbQOhW/B
 XfecjBu460MGO3paSkLYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xv8hqRwE3W0=;SOveMDF+r5mLKQiA7IOseqJhgjW
 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

--Sig_/+gDkQy2XVUmKZF0iFKIdg+r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Sep 2025 09:09:56 +0200
Ulli Horlacher <framstag@rus.uni-stuttgart.de> wrote:

> I have 4 x 4 TB SAS SSD (from a deactivated Netapp system) which I want to
> recycle in my workstation PC (Ubuntu 24 with kernel 6.14).
>=20
> Is btrfs RAID5 ready for production usage or shall I use non-RAID btrfs on
> top of a md RAID5?
>=20
> What is the current status?
>=20

Hi,

md RAID5 with Partial Parity Log is perfect for btrfs:
https://www.kernel.org/doc/html/latest/driver-api/md/raid5-ppl.html

When a stripe is partially updated with new data, PPL ensures that the
old data in the stripe will not be corrupted by the write-hole. The new
data on the other hand is still affected by the write hole, but for
btrfs that is not a problem.

Regards,
Lukas

--Sig_/+gDkQy2XVUmKZF0iFKIdg+r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmjRA7MACgkQNasLKJxd
sljEJg//cV6cvxAHOBsu2xDT304cG9bQ/w0VCPnPB0o+tRBiVBfX5e2bjirvni/d
a3obhunzxnFvO+6h7ewp2MRXWXEY96HMOx9i2REapGBzey4IkZAYQO9iRu74WkUq
D3Fm2UkdMxwy6CyvZ1LOFalPZywfQIZcXz3FMlNs4UlyzRkOBtAJMP7LCEr6SWeJ
gSNPQDZ4zBMoBSe3Bd/hDXljbM2XYq/djaCbALEBia+ssZW9aeO18+x+0wS5SYws
YZzS3R/686HtmhPWH+tsCuOuDlx8uG9ITxY9fNmXQxgg8vWS2v/gf0fOc5mtr25T
avb+YRiIbiBT277Pge6Wye6F6ibw1v1huvmiVKBqi4X+ACMud24BqXFCvpdZhLJz
2gn+WDigw04J0/Q8F3MO85AkpDNpr4GVpISFOIMKnmz4Y51phYd6VYbblWtsyL+q
IL9Emyz+gEo6EPkw+OOfDXQWogkU1W4zEgOGBR0n5pUIu+hnYKJhViyMUancqqf3
fQxQJONY/aPfMPZ5VVlztATA/0d2Ewy4DoVDIyCjHv2WQEN2UvrIlx2qyW2acNr8
8r370BYH10FD5oM9gN9rjy6BTv/OlfSJ1GVUKtpf9CQx++5e4UoAVtT7IDSAE3K1
2XVrgDhdJUs9qzlv7PWUQ6kJ4ZgAldroh2/c2eOWnhLRFR75iAA=
=Lt1n
-----END PGP SIGNATURE-----

--Sig_/+gDkQy2XVUmKZF0iFKIdg+r--

