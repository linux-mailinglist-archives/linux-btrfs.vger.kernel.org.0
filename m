Return-Path: <linux-btrfs+bounces-5700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53585906592
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 09:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC231C2303F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B313C80C;
	Thu, 13 Jun 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="lOuxfiY+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-usa2.onexmail.com (smtp-usa2.onexmail.com [35.173.142.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953312C53D
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.173.142.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264921; cv=none; b=dZ2EktQH+jwuYPlW7D7UrbwYwVuk7yJA6x2KnhPl9YEb9N6ZbGQ0yKuwiGa5bP0XPbSsoJG9Jegbue4RUn1NP6h3AlWBbYdBuZVymQZ3DH7hrnlRyEVIUWOW8G8HRRn5/cwv8ZSBrgce7zsAXjJozVDn1me5gmQ+y1dzoII1lcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264921; c=relaxed/simple;
	bh=wVWX15mQ5nuAMN5M3OY0d7dPtJ0ndxn56dXcq/tsdfc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SeJVY7LZvO8vKnkpKzq9EYEJ+9wwHnuavDqkVJEC0tmkhXLPbTsuMOqYYEmY6sj+mP8bmkQCemZVcWuh1Z4N/EnAI0rbEUNgVy4Vb8p2++GX3y0/Z7mmuOMFXDit4PQRduqeM+Gq/IEaQegoUb0xC1QJ/1U8p/DpN0koG3J8+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=lOuxfiY+; arc=none smtp.client-ip=35.173.142.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1718264873;
	bh=wVWX15mQ5nuAMN5M3OY0d7dPtJ0ndxn56dXcq/tsdfc=;
	h=Message-ID:Date:MIME-Version:To:Subject:From;
	b=lOuxfiY+AeKPxYfjtPiOfzx7EGpRC0BJIWDxDdSaxTVv+tOwcHdLkIoYWx1T+HARb
	 RzGyUulTThKB5Ey750DtXVbtF6siHiBRsUWJxK+g2IXxbdIaXelgCI3X2sWEnaMB/5
	 ovTx49pb/rQNMc0uihlezQJISJcUOkfoDfgraOr0=
X-QQ-mid: bizesmtp81t1718264870tydiw1h2
X-QQ-Originating-IP: zbXtmbf5fLzbewYktpEsAI/MkzgqVZOMeTFwtF73N38=
Received: from [192.168.1.5] ( [223.150.250.85])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Jun 2024 15:47:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10558964354201705296
Message-ID: <3E9580E891A06375+d6a5f369-32e8-467c-a230-82298a979d10@bupt.moe>
Date: Thu, 13 Jun 2024 15:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org
References: <cover.1718238120.git.wqu@suse.com>
Subject: Re: [PATCH 0/4] btrfs-progs: move RST feature back to experimental
Content-Language: en-US
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <cover.1718238120.git.wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rsUQxoHRPjjVcLVOVblvu0mf"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rsUQxoHRPjjVcLVOVblvu0mf
Content-Type: multipart/mixed; boundary="------------jqxBM0vifxMktKUXFNNRYg7P";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org
Message-ID: <d6a5f369-32e8-467c-a230-82298a979d10@bupt.moe>
Subject: Re: [PATCH 0/4] btrfs-progs: move RST feature back to experimental
References: <cover.1718238120.git.wqu@suse.com>
In-Reply-To: <cover.1718238120.git.wqu@suse.com>
Autocrypt-Gossip: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=

--------------jqxBM0vifxMktKUXFNNRYg7P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBUaGlzIHBhdGNoc2V0IHdvdWxkIGhpZGUgUlNUIGZlYXR1cmUgYmFjayBiZWhpbmQgZXhw
ZXJpbWVudGFsIGJ1aWxkcyBmb3INCj4gbWtmcywgYW5kIGNvbXBsZXRlbHkgZGlzYWJsZSBy
c3QgZm9yIGNvbnZlcnQsIHNvIGVuZCB1c2VycyB3b24ndCBhbmQNCj4gY2FuJ3QgZW5hYmxl
IFJTVCBieSBhY2NpZGVudC4NCkhvdyBhYm91dCBpbnRyb2R1Y2UgYSBvcHRpb24gbmFtZWQg
bGlrZSAiLS1leHBlcmltZW50YWwiIHRvIGVuYWJsZSB0aGVzZSANCmZlYXR1cmU/DQoNCkl0
IGNhbiB3b3JrIHBlcmZlY3RseSBhbmQgZG9uJ3QgbmVlZCBtZSB0byByZS1jb21waWxpbmcg
YW5vdGhlciBidHJmcy1wcm9ncy4NCg0KSEFOIFl1d2VpDQoNCg==

--------------jqxBM0vifxMktKUXFNNRYg7P--

--------------rsUQxoHRPjjVcLVOVblvu0mf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZmqkJAAKCRBLkKfpYfpB
U6GpAP0VZwA5THRVdKOiGEaxPUxRwl8pmf9GJDKkGh/PmHxRYgEAoxYirOBmajo4
B4X+vAOfxQQHAXNjB9v0YfOWXZD9dQo=
=sPa6
-----END PGP SIGNATURE-----

--------------rsUQxoHRPjjVcLVOVblvu0mf--

