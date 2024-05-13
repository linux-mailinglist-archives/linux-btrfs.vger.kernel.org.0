Return-Path: <linux-btrfs+bounces-4929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C38C3D1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 10:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612C6B213CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A071474AE;
	Mon, 13 May 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="jb9Uz5pl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F231EA8F
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588868; cv=none; b=apGgzb1ZduXsMuZVRys5qRtwr8cSqMHcgj6sD6Hj8OCu1hhdFFxk9V7Pv8+uNESRKZUZ/hsBoiTCQJYKXRqDCOkOxyFRuTIqV5XY3zShPYpPrtvg8TUQXiBLqVhxGLvrP+bEfBYM0cJ6lM6FD3X/zfdP8OwPOkN39okFsQNPNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588868; c=relaxed/simple;
	bh=+7ozgd0Vj0vDk0GEio6sEL62fuQZvFxQG2W+sRRjG0E=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=ExCENLlL8WyjQlxntO/n+62plPRL322pUbA9kUtFVtal3ZcDjMT/gVlr3VSHPi/pdUAzUUl7qvqjuHqS9GUFwWBzxb7/7Y4TyPI4UG5QYRN7Xy0Hbi+FfsdsbYiZ7aXo6dARWjU1OYaUbE4cMLKtcUKMrNmIoyKs3au2ERUNinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=jb9Uz5pl; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1715588847;
	bh=+Oc9iBAWKUiKqEdatqlZ3W6gpq1ELkih6wtpBiW4/Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jb9Uz5pl0pmurltt3VK5Xxw0QAEKmGxLkHDqwgDnNMgGizIhAI7Kc7rH9VqSYRRb3
	 V3eppSR5RVb30J5JHwNvK+JkIpOjQspsObUKUvyVpQObP0C0KU56cVn+2prJiSJR8f
	 CQxD6NXL102e3RuaRHQS1NgightxQfIbkSae8Ar0=
X-QQ-mid: bizesmtpsz9t1715588845t404jv2
X-QQ-Originating-IP: s/URqTmCNRl0kfKhF3vri6vwqK+lqj/vSdTgx/KftQQ=
Received: from [192.168.1.5] ( [223.150.233.37])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 16:27:23 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: DQ0OCu3gog2Gyogx3bb93uegRi8u9GLSNvyOCabjlI7iY0HSCKIe705UcYNJj
	tbN5HDND24He82Mnhz3uX8uwSCSf+jaCjVFud9fi7LwjC3yyKCnPUEf/1JJD7KWsS5FVYSR
	qKJMM1gHRXA4zz8nkL3s60biXuw0ej4N1Re368mxHgR9Dt4ydFVV8wdiZsCmyeXkk0cko/5
	rfgUeQBJ0j9prjBUQhjFe9uFg66vbDfi7ZGDsLjhQoOJ3NxKvfwsMrxTZNWoDin2ezewcyt
	kIbtRGIXs/WfgZgCAbek0h3BrZoAIWpd8Vy4Oyd3FaDOAXMRW8L4xBygf+nB1nXDOTLdQYZ
	AMs8d4rbU4LiC3fh10f/VDx90Zs5sAl/DeR0aqMtg27Lfza8si94PHSotYHKMeCSdJfZrxz
	9mTwG9EuLM0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12241758347879848162
Message-ID: <4177B1D395584346+0c96848e-da45-489b-b349-6fbc5befcefe@bupt.moe>
Date: Mon, 13 May 2024 16:27:22 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: snapshots of subvolumes recursivly?
References: <20240513075016.GC94789@tik.uni-stuttgart.de>
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: HAN Yuwei <hrx@bupt.moe>
In-Reply-To: <20240513075016.GC94789@tik.uni-stuttgart.de>
X-Forwarded-Message-Id: <20240513075016.GC94789@tik.uni-stuttgart.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lGaS0cwrKg70y2X0bn1jwICS"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lGaS0cwrKg70y2X0bn1jwICS
Content-Type: multipart/mixed; boundary="------------NXspK7kfNcRHH7lqQ7YVq9AN";
 protected-headers="v1"
From: HAN Yuwei <hrx@bupt.moe>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <0c96848e-da45-489b-b349-6fbc5befcefe@bupt.moe>
Subject: Fwd: snapshots of subvolumes recursivly?
References: <20240513075016.GC94789@tik.uni-stuttgart.de>
In-Reply-To: <20240513075016.GC94789@tik.uni-stuttgart.de>

--------------NXspK7kfNcRHH7lqQ7YVq9AN
Content-Type: multipart/mixed; boundary="------------FJYV4FlvN6Tte7vxd1f0JXCu"

--------------FJYV4FlvN6Tte7vxd1f0JXCu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Rm9yd2FyZCB0aGlzIG1lc3NhZ2UgdG8gbWFpbGluZy1saXN0DQoNCi0tLS0tLS0tIOi9rOWP
keeahOa2iOaBryAtLS0tLS0tLQ0K5Li76aKYOiAJUmU6IHNuYXBzaG90cyBvZiBzdWJ2b2x1
bWVzIHJlY3Vyc2l2bHk/DQrml6XmnJ86IAlNb24sIDEzIE1heSAyMDI0IDA5OjUwOjE2ICsw
MjAwDQpGcm9tOiAJVWxsaSBIb3JsYWNoZXIgPGZyYW1zdGFnQHJ1cy51bmktc3R1dHRnYXJ0
LmRlPg0K5pS25Lu25Lq6OiAJSEFOIFl1d2VpIDxocnhAYnVwdC5tb2U+DQoNCg0KDQoNCkkg
YW0gbm90IGFibGUgYW55IG1vcmUgdG8gcmVwbHkgdG8gdGhlIG1haWxpbmcgbGlzdDoNCg0K
PGxpbnV4LWJ0cmZzQHZnZXIua2VybmVsLm9yZz46IGhvc3Qgc210cC5zdWJzcGFjZS5rZXJu
ZWwub3JnWzQ0LjIzOC4yMzQuNzhdDQpzYWlkOiA1NTAgNS43LjEgWW91ciBtZXNzYWdlIGxv
b2tlZCBzcGFtbXkgdG8gdXMuIFBsZWFzZSBjaGVjaw0KaHR0cHM6Ly9zdWJzcGFjZS5rZXJu
ZWwub3JnL2V0aXF1ZXR0ZS5odG1sIGFuZCByZXNlbmQuIChpbiByZXBseSB0byBlbmQgb2YN
CkRBVEEgY29tbWFuZCkNCg0KLS0gDQpVbGxyaWNoIEhvcmxhY2hlciAgICAgICAgICAgICAg
U2VydmVyIHVuZCBWaXJ0dWFsaXNpZXJ1bmcNClJlY2hlbnplbnRydW0gVElLDQpVbml2ZXJz
aXRhZXQgU3R1dHRnYXJ0ICAgICAgICAgRS1NYWlsOiBob3JsYWNoZXJAdGlrLnVuaS1zdHV0
dGdhcnQuZGUNCkFsbG1hbmRyaW5nIDMwYSAgICAgICAgICAgICAgICBUZWw6ICAgICsrNDkt
NzExLTY4NTY1ODY4DQo3MDU2OSBTdHV0dGdhcnQgKEdlcm1hbnkpICAgICAgV1dXOiAgICBo
dHRwczovL3d3dy50aWsudW5pLXN0dXR0Z2FydC5kZS8NCg0K
--------------FJYV4FlvN6Tte7vxd1f0JXCu
Content-Type: message/rfc822; name="ForwardedMessage.eml"
Content-Disposition: attachment; filename="ForwardedMessage.eml"
Content-Transfer-Encoding: 7bit

Date: Mon, 13 May 2024 09:37:29 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: snapshots of subvolumes recursivly?
Message-ID: <20240513073729.GA94789@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20240512203921.GA83909@tik.uni-stuttgart.de>
 <6B5555BE532EFFBF+03c904d1-3111-40d6-9266-8c02c35b6cd4@bupt.moe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6B5555BE532EFFBF+03c904d1-3111-40d6-9266-8c02c35b6cd4@bupt.moe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Content-Transfer-Encoding: quoted-printable

On Mon 2024-05-13 (12:19), HAN Yuwei wrote:
> =E5=9C=A8 2024/5/13 4:39, Ulli Horlacher =E5=86=99=E9=81":
>=20
> > I have asked a similar question 2019-07-05, but maybe meanwhile there=
 is a
> > solution...
> >
> > I want to backup btrfs filesystems with IBM Spectrum Protect and rest=
ic,
> > both are file based.
> >
> > Copying files which are in write-open state will lead to file corrupt=
ion.
> > Therefore my idea is: create a snapshot and run the backup on the sna=
pshot.
>=20
> You could use "btrfs send" to send whole snapshot instead of file.

I MUST use IBM Spectrum Protect or restic, because the backup
storage is a (multi-million dollar) tape library.


> > I could write a script which creates snapshots of the subvolumes
> > (recursivly), but maybe there is already such a program?
> > Or another solution for this problem?
>=20
>  From what I understand, subvolume created a way to split your "snapsho=
t
> zone" for better data management(e.g. you can snapshot / without
> including /home or /var). This is intented.
>=20
> So if you want to backup sv1 sv2, why you created subvolume in the firs=
t
> place?

This is only a simple example to explain the problem.
I have hundreds of hosts which use btrfs subvolumes intensivly.
For example SLES splits the / filesystem in a dozen subvolumes.
I cannot change this setup.
And users may create (sub-)subvolumes, too. I cannot stop them in doing s=
o.=20
But I must organize the backup. It's up to me :-}

--=20
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<6B5555BE532EFFBF+03c904d1-3111-40d6-9266-8c02c35b6cd4@bupt.moe>


--------------FJYV4FlvN6Tte7vxd1f0JXCu--

--------------NXspK7kfNcRHH7lqQ7YVq9AN--

--------------lGaS0cwrKg70y2X0bn1jwICS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS1I4nXkeMajvdkf0VLkKfpYfpBUwUCZkHO6gAKCRBLkKfpYfpB
U0mfAQC3rGEFYrmesWikM+obwTl36/C1nqVGSJoTAmje4iymMQD/V0buZx5XpXxK
/ZuKQYJ+A48pJ3QT5V6uCAhKO2liuw4=
=LKW4
-----END PGP SIGNATURE-----

--------------lGaS0cwrKg70y2X0bn1jwICS--

