Return-Path: <linux-btrfs+bounces-13386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D952A9ABD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D067AEC2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A7223DE5;
	Thu, 24 Apr 2025 11:32:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailfilter05-out21.webhostingserver.nl (mailfilter05-out21.webhostingserver.nl [141.138.168.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57120C030
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=141.138.168.204
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494334; cv=pass; b=gx48s2EkRO/UyRl3JRqCDS8HklwADAO5EXoSHCX1Z2eaBq0MT7+w8GY7ooZg98/p4JQdyLsajG4nOYbwqgxG9hqAlAjaZIKBkuWCB0Oi+/bgcynzJs+k575kmNOr7KznACho/8gCbo34mud7aVrZqAkfeWLno4DptrLhFgH4eng=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494334; c=relaxed/simple;
	bh=TUf4VKaJcyfoEDg3646O2WtAZvgEUG8mIBFC1e3e9qU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoDtZAJICOTgBH3tW8ZS/CIT47nbv93zo8leTP1KHDxql+ExlqeEfQvvCE4j9jsr2CWppJ1Nd8MgHB0Ekri9f+Xr9I7HkMUdJbg1fhFUcY3jrKimnPLal2tUycy2rmFoL8AX9jG8VbmWc5wOhpk+rbl9WYsUhCk/8NLLZJYANyU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=141.138.168.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1745494263; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=H2NWlk9esKnVk3FiqFSs9RC64v/qkX+aU5cegWsEp8SCFGmZb3BXpLsBcFiWGT05l8pwbisICAAER
	 zxvlApFgEimzzxda4I/b0BTzcLfJ59Y4AwcRez7nvX++Np5XueEiw29r6C6YlOpJCk7E91uhWJxLEw
	 AyvW6Y25h8zfNk1FuhtojnM7YYPSuqLn4lLGgrXy5YlqZqVq6SFp8heBGs83RE4pWCriafx3MDSsmD
	 OrFlBpbIJoWKiUF9uh//2yVOcI1g84rvP6VslpqnlNgeTxA3DQuMRnWdsLv7I25twfCnxnSoVXI7kl
	 vYxV/E2q8I38eUHCn4qDgUZZMbPlsyA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-type:mime-version:references:in-reply-to:message-id:date:subject:to:
	 from:from;
	bh=f1cAYTVR7qza7LQmzJ7GIfYjLcA6cQHWUZfgnBUqIjs=;
	b=Pt4g/76sWJXIiyXBb9SaqUmsEn8aoc+ypX+R+nHQ3ZEOhFQtrp4xiwn9yWXQSjiUxEDkr0JMVfaE/
	 FbzSVjDhNIJTNfs2vsXhY3kHbndp+46brtb/GvEfSrIsEnoR+2XF1E/XCMvj4dauL+1lHgZFMV8SN+
	 Zj0NmtSLDnEEuH0acVETm3JWE+lfpI6MNveEcN1+rSgZW3lpZybvw1jbv2OF6QYT3XcV5PpIbATkRW
	 2xatx5ZTzDRkHU0A+Dogjbs+wb+rgjjrfSDz9b6Oy03of1xiPCClE4WYdX4r1hl1r4wF1Y4KLt+fTo
	 nROIbvhMSa5KKG+0kacfOCpXMFO+ehQ==
ARC-Authentication-Results: i=2; mailfilter05.webhostingserver.nl;
	spf=softfail smtp.mailfrom=gmail.com smtp.remote-ip=141.138.168.154;
	dmarc=fail header.from=gmail.com;
	arc=pass header.oldest-pass=0;
X-Halon-ID: 99c181c6-20ff-11f0-b451-001a4a4cb933
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter05.webhostingserver.nl (Halon) with ESMTPSA
	id 99c181c6-20ff-11f0-b451-001a4a4cb933;
	Thu, 24 Apr 2025 13:31:01 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1745494261;
	 b=Fx7naW5zDMpHkXFlePfaArwzOqZXHLxN68m/vrq7wl0vFXi73zkLf+TdOHQa22VoS9lMZiOlA8
	  XRcoJrRR7V8tgWZmJ2pFRlXQzxhZA8sKqjA9YxQGKVQtq0jBoADll2h4XPdtvPiEEVl+p/hDQB
	  uc1mAcWuGv9m4eCrBF7r0/vBnHpE+GZS84SoTtpX1oEqeDXrnKqrxfz2iAduP5pKI6MahN0y+3
	  5iYlsRfOZfaCWe++MvAoYj0IZca13MfBP4aB0ZGuUvXjWes5xJSvzyRiVv2dSHyVV3l8jtvPvN
	  455ijWctog+kaLvbIo2OuQoQ3A7zL/ii/1uOAKwPVNl2IQ==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=178.250.146.69;
	iprev=pass (cust-178-250-146-69.breedbanddelft.nl) smtp.remote-ip=178.250.146.69;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=gmail.com;
	dmarc=skipped header.from=gmail.com;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1745494261;
	bh=TUf4VKaJcyfoEDg3646O2WtAZvgEUG8mIBFC1e3e9qU=;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	  From;
	b=R5cWgGpfwRoCDsvrgUW9TKOrRfWLhOKVR9yR2o2L/tX1zo1urVuos8NGJMibl1HgCdgeofYeGB
	  FCz0vf23z7k8tEkXOFh9Ygmno5jGLKYD31AelD6LYmu4s+z91tmuGBGSx0UrMTSXfvyh6+K7VA
	  /1dWgriGR0wXlkGyhm4Gb9qBCDgowCiU6hDioJjkIaPHKR9K9Xylq5VpLJvJHgSLNdy3pZ6+p5
	  bxVd4pqbbcr5QdZ1FwX42QQP1bMv16O2xuD6HeEj8Njug22HBwTtcUcUHffRhKeoDgEAmH8UCL
	  pRH7TtgYDX1WfM9upxvCEwNJ/6eA7L8Dxqmin7zdhopqYw==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (cust-178-250-146-69.breedbanddelft.nl) smtp.remote-ip=178.250.146.69;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=gmail.com;
	dmarc=skipped header.from=gmail.com;
	arc=none
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=smtp)
	by s198.webhostingserver.nl with esmtpa (Exim 4.98.2)
	(envelope-from <fntoth@gmail.com>)
	id 1u7unF-0000000GINH-1zBZ;
	Thu, 24 Apr 2025 13:31:01 +0200
From: Ferry Toth <fntoth@gmail.com>
To: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Errors on newly created file system
Date: Thu, 24 Apr 2025 13:31:00 +0200
Message-ID: <3309589.KRxA6XjA2N@ferry-quad>
In-Reply-To: <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
References:
 <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <2366963.X513TT2pbd@ferry-quad>
 <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3906875.N7aMVyhfb1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

--nextPart3906875.N7aMVyhfb1
Content-Type: multipart/alternative; boundary="nextPart3939090.VqM8IeB0Os";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Ferry Toth <fntoth@gmail.com>
Subject: Re: Errors on newly created file system
Date: Thu, 24 Apr 2025 13:31:00 +0200
Message-ID: <3309589.KRxA6XjA2N@ferry-quad>
In-Reply-To: <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart3939090.VqM8IeB0Os
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Op donderdag 24 april 2025 01:24:23 CEST schreef Qu Wenruo:
>=20
> =E5=9C=A8 2025/4/24 01:36, Ferry Toth =E5=86=99=E9=81=93:
> > Op woensdag 23 april 2025 00:00:36 CEST schreef Qu Wenruo:
> >=20
> [...]
>=20
> >=20
> >  > > Yocto users on Scarthgap (5.0 LTS) with version 6.7.1 may copy the
> >=20
> >  > > recipe meta/recipes-devtools/btrfs-tools/btrfs-tools_6.13.bb from
> >=20
> >  > > walnascar or 6.14 from master. If they are building additional too=
ls
> >=20
> >  > > that use headers from this package like btrfs-compsize these may b=
reak.
> >=20
> >  > >> Thanks,
> >=20
> >  > >> Qu
> >=20
> >=20
> > While here, am I right that we can not generate the rootfs with=20
> > compression on?
> >=20
> >=20
> > Reason I ask is, Yocto of course builds the rootfs and than has=20
> > mkfs.btrfs create the image. But it runs as unprivileged user, so can=20
> > not do mount.
> >=20
> > And then can not do defrag.
>=20
> We have this feature recently thanks to Mark!
>=20
> In the latest release v6.13, there is a new option "--compress" added to=
=20
> mkfs.btrfs, which must be used with "--rootdir".
>=20
> And the result is exactly what you expected, mkfs.btrfs will try to=20
> compress the file extents at runtime.
> For uncompressible data, it will detect at the beginning and fallback to=
=20
> uncompressed data instead, exactly like the kernel.

That is great, thanks!

> But considering how new this feature this, it will be appreciated if=20
> Yocto guys can do some extra testing to make sure nothing is broken.
> (Normally a btrfs check after the mkfs will be good enough)
>=20

I will test this.

In the meanwhile I found another problem (and I am not the first it seems s=
ee
/https://stackoverflow.com/questions/79475262/yocto-root-filesystem-ownersh=
ip-issue/79590289#79590289/[1])

Yocto uses pseudo to fake root ownership. Even though the directory to be c=
opied into the new fs is owned by an unprivileged user inside the btrfs ima=
ge the files are owned by root, when created by mkfs.ext4 and mkfs.btrfs.

Except with newer mkfs.btrfs (I tested using 6.13) the files are owned by t=
he unprivileged user.=20

The result is, the image will not boot correctly.

> Thanks,
> Qu
>=20
>=20
> >=20
> >=20
> >  > >
> >=20
> >  > >
> >=20
> >  >
> >=20
> >  >
> >=20
> >=20
> >=20
>=20
>=20



=2D-------
[1] https://stackoverflow.com/questions/79475262/yocto-root-filesystem-owne=
rship-issue/79590289#79590289

--nextPart3939090.VqM8IeB0Os
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

<html>
<head>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8">
</head>
<body><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Op donderdag 24 april 2025 01:24:23 CEST schreef Qu Wenruo:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; =E5=9C=A8 2025/4/24 01:36, Ferry Toth =E5=86=99=E9=81=93:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; Op woensdag 23 april 2025 00:00:36 CEST schreef Qu Wenruo:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; [...]</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt; &gt; Yocto users on Scarthgap (5.0 LTS) with version 6.7.=
1 may copy the</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt; &gt; recipe meta/recipes-devtools/btrfs-tools/btrfs-tools=
_6.13.bb from</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt; &gt; walnascar or 6.14 from master. If they are building =
additional tools</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt; &gt; that use headers from this package like btrfs-compsi=
ze these may break.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt; &gt;&gt; Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt; &gt;&gt; Qu</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; While here, am I right that we can not generate the rootfs with </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; compression on?</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; Reason I ask is, Yocto of course builds the rootfs and than has </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; mkfs.btrfs create the image. But it runs as unprivileged user, so ca=
n </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; not do mount.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; And then can not do defrag.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; We have this feature recently thanks to Mark!</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; In the latest release v6.13, there is a new option &quot;--compress&quot;=
 added to </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; mkfs.btrfs, which must be used with &quot;--rootdir&quot;.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; And the result is exactly what you expected, mkfs.btrfs will try to </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; compress the file extents at runtime.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; For uncompressible data, it will detect at the beginning and fallback to =
</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; uncompressed data instead, exactly like the kernel.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">That is great, thanks!</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">&gt; But considering how new this feature this, it will be appreciated i=
f </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Yocto guys can do some extra testing to make sure nothing is broken.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; (Normally a btrfs check after the mkfs will be good enough)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">I will test this.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">In the meanwhile I found another problem (and I am not the first it seem=
s see</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;"><a =
href=3D"https://stackoverflow.com/questions/79475262/yocto-root-filesystem-=
ownership-issue/79590289#79590289"><em>https://stackoverflow.com/questions/=
79475262/yocto-root-filesystem-ownership-issue/79590289#79590289</em></a>)<=
/p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Yocto uses pseudo to fake root ownership. Even though the directory to b=
e copied into the new fs is owned by an unprivileged user inside the btrfs =
image the files are owned by root, when created by mkfs.ext4 and mkfs.btrfs=
=2E</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Except with newer mkfs.btrfs (I tested using 6.13) the files are owned b=
y the unprivileged user. </p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">The result is, the image will not boot correctly.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">&gt; Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Qu</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt; &gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt; &gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&nbsp; &gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<br /><br /></body>
</html>
--nextPart3939090.VqM8IeB0Os--

--nextPart3906875.N7aMVyhfb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEqR7zuEuxfQFO1Tt5OB30JY3rOi0FAmgKIPQACgkQOB30JY3r
Oi2jKgf+NKqn0+jDbBxTHvLs6dWdH47Bp1Gg9yBR+fZQq8MzCT0wnuX8CycXKyTA
c4o7YznkQOlRvxjn8BQclnCbpqRXPNf6faYBnNA5wXUmF/FM3nWMfL9nMXYvKBXK
AACWMeCnlU/08pZ/7CyD1BDb+H1wHF0C1s+PS4aBF+NxdGupheyDZwYqHVTn1jQV
JGbYYhsuTXcf5fexNOHiF9e4OZrdbfrz//ZTLnLRH0ghIk0fWkknLfIhzBh3DmnI
rj6X050DYKIQlbMS04WuoVdcaBh3yIvyTnbephiyPfqSUnQDUYhgBVrrbKHk1H5O
igiPSFAEA+2lu5zJX1NpGw4fY7Objg==
=ELa2
-----END PGP SIGNATURE-----

--nextPart3906875.N7aMVyhfb1--




