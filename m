Return-Path: <linux-btrfs+bounces-13337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBAAA99499
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62F11BC6635
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133612857C5;
	Wed, 23 Apr 2025 16:08:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailfilter06-out21.webhostingserver.nl (mailfilter06-out21.webhostingserver.nl [141.138.168.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA527B4EE
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=141.138.168.87
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424480; cv=pass; b=jGNQBfVuhQ3rYWlXgQojlhrv5GhIYEGRuhae4vNbCyeYQreLYFmccN6FtcNhYNARO2qefZrTIp0fhVTEzt4RarInyUYvJbBfyLKLHhBDIPI95k9ZLHwG0NBwxFrvfRm9Fgz+7a8yqd+ie5QvPJKriQCwjVXDUbTGdqm1I6ayf/w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424480; c=relaxed/simple;
	bh=lunTwmJkHEIi9/6UGz2wQMisHChqfja335Ic8YJ3hNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsZ6oOPCy3LLQCaRHEXX6tK5sNWvcxpVWLAZmPGvP7wb8iW1mPO98bLd4JwIzie3TCYuWbaDMs6+QwHv2gJgOkhCVgSSIsPukLCbouC+O4yh9mOkxt2hMwkq6cU3J3IZtNuFbgnb1ofdpE7x9NzMjpNrYHvWnFeQJq1X1I+UdWc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=141.138.168.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1745424409; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=NZZy5xP88dERHCNkkeiKKIJRrD0UPtKoP4viqVixR5sF6q+FfTrhzpuHbsyuS7wJwku/EDo/KNbj2
	 0DhotuAq0g5sz2N525zlJM//XEED3Qc/plFzNB6ZXh3s4tio5HEu7imqiFAahbITv1Fe8tGR7s91YE
	 Uxh/NY1kPY2qaKAKeMWdC9WuljHRStpFk6kFWM0x2wqjbT9f0RS9owtv2V4tzZSbtsqJjzBLjaU1WG
	 SjTdgk3Xvg2fjr6ut75u3NmQAHjv5rlcDfc6M1TLI1sO0W73VOVkRjrJyZLTOcarX1Zz1tKEEz7pDW
	 KDUcM5A1EBArcWVxPUlTqjH+/azP2CA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-type:mime-version:references:in-reply-to:message-id:date:subject:to:
	 from:from;
	bh=Nl69xl8vbHQjBaPnM83chyemx8CdnAw4GM+m+f5Lt0A=;
	b=f3UXebP8xnA5kf1ZLKkx89BQ05uRw+9qWsowPWHqfk8u6Z66G8I8mDfkgb+yVPUyuFRUnDfmhGyaW
	 nbu+SFdNVHjnGVKMy63rEinsx9Bw5YPfu4wcKvSLvbTdxhFrtekCiIx1uFDzDnp8mlAecVDfPjeZP1
	 IQ0QZNpV4bvDQ/aQdpiaP/2AdylngWQiUguG57pR9mTBXgQS1rBd/80nIhWq6Dcfg7Kp2A2GGH+7dD
	 NH4HxtwErQebVKuvzK7u05Xjyfmf2bAcMnZ8akR4VDTGenciPc2yhs5Mvn0z7Tq0fMpcccFIQjhSv/
	 gS7m0aAnewd5Z2nDogiYQSggAaq8HKQ==
ARC-Authentication-Results: i=2; mailfilter06.webhostingserver.nl;
	spf=softfail smtp.mailfrom=gmail.com smtp.remote-ip=141.138.168.154;
	dmarc=fail header.from=gmail.com;
	arc=pass header.oldest-pass=0;
X-Halon-ID: f5006913-205c-11f0-8839-001a4a4cb958
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter06.webhostingserver.nl (Halon) with ESMTPSA
	id f5006913-205c-11f0-8839-001a4a4cb958;
	Wed, 23 Apr 2025 18:06:46 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1745424406;
	 b=kihDPNOa05xm97SfOxvd2PCXPEYRccgDZrvu/J1pVGb415NcB6A8Ce7GUX+dpzemGbjUWO3g8t
	  XJDUlyHFd8xvdSoZR3g7QVZ2E3Vme8B1enjMf8ziSN2cI7kMdtRK/rlNfwofSmyo03a4kbz/nh
	  aa3SdM1Bur7cWkDzKxfxIqpKzEwFvcfD0DALqWqxQjwgR/2DPt+fBfFo37kUFEeosGDuJ6PAxe
	  SdFoNvjKlm44u+dIel+s4+7UWl8EzlFNqqC4e6pBRf7zejQIDqZQB0elXY5Jl+J9IXdqjktjXE
	  BqdbjKsjwOYQM/utlVDEqpcHtWmcEs0Uyp0mS1H9ksHOIA==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=178.250.146.69;
	iprev=pass (cust-178-250-146-69.breedbanddelft.nl) smtp.remote-ip=178.250.146.69;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=gmail.com;
	dmarc=skipped header.from=gmail.com;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1745424406;
	bh=lunTwmJkHEIi9/6UGz2wQMisHChqfja335Ic8YJ3hNE=;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	  From;
	b=XsSHJXLQSETj5B5ymQYqIzPUWOdY2IaNtuEw+xgZBy0OkmRqFp+2rc54X1gTJ3SUKETiEVMhn9
	  EXyFgPBbGZZpI8CgdJf2q0V5UopIya4eAYJlIHfx/S969iRIpzsjpLmNOLkeYdnjaJL+bRku0U
	  RfxVfoQOLVf2oa24QmZjKI8RrdrcYJEgaD5Wl2y9pFNBOk+LhEavoItOA6Cl4VVdVFy4kX5cM/
	  mth1gm45XDRa9UMEg7pFiUdg3qRTzHt38wpVUBXgzoo+ius7rqX7F+4jfe/JHbqIhk1E84VqQy
	  ZcZGP2YtRWNToOU0CiZMrM7Fc+6Q4EXBoqa1PqVAbcP3ew==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (cust-178-250-146-69.breedbanddelft.nl) smtp.remote-ip=178.250.146.69;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=gmail.com;
	dmarc=skipped header.from=gmail.com;
	arc=none
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=smtp)
	by s198.webhostingserver.nl with esmtpa (Exim 4.98.2)
	(envelope-from <fntoth@gmail.com>)
	id 1u7ccY-0000000EN6S-2h8q;
	Wed, 23 Apr 2025 18:06:46 +0200
From: Ferry Toth <fntoth@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>
Subject: Re: Errors on newly created file system
Date: Wed, 23 Apr 2025 18:06:42 +0200
Message-ID: <2366963.X513TT2pbd@ferry-quad>
In-Reply-To: <aee691cc-4536-40a7-8d98-b31040e0b1d6@suse.com>
References:
 <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <cdf268c1-b031-488e-a2f3-d68cc88f4d16@gmail.com>
 <aee691cc-4536-40a7-8d98-b31040e0b1d6@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3162908.4XsnlVU6TS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

--nextPart3162908.4XsnlVU6TS
Content-Type: multipart/alternative; boundary="nextPart2810006.C4sosBPzcN";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Ferry Toth <fntoth@gmail.com>
Subject: Re: Errors on newly created file system
Date: Wed, 23 Apr 2025 18:06:42 +0200
Message-ID: <2366963.X513TT2pbd@ferry-quad>
In-Reply-To: <aee691cc-4536-40a7-8d98-b31040e0b1d6@suse.com>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart2810006.C4sosBPzcN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Op woensdag 23 april 2025 00:00:36 CEST schreef Qu Wenruo:
>=20
> =E5=9C=A8 2025/4/23 07:02, Ferry Toth =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > Op 21-04-2025 om 00:00 schreef Qu Wenruo:
> >>
> >>
> >> =E5=9C=A8 2025/4/21 07:15, Ferry Toth =E5=86=99=E9=81=93:
> >>> The following is originally done by Yocto's bitbake, but when I try=20
> >>> manually it reproduces.
> >>>
> >>> I create a new fs on  a file using -r as ordinary user, then btrfs=20
> >>> check the file (before or after mounting makes no difference), also=20
> >>> as an ordinary user.
> >>>
> >>> The fs has 1000's of errors, I cut most because it seems the same=20
> >>> type of errors. The files system is unrepaired bootable, but can be=20
> >>> repaired using --repair, in which 1000's of files are moved to=20
> >>> lost+found.
> >>>
> >>> The below was mkfs on a non-existing file, but writing to 16GB dduped=
=20
> >>> file (rootfs is 1.4GB) makes no difference. Neither does dropping --=
=20
> >>> shrink, -m or -n.
> >>>
> >>> Also, writing the file to an actual disk and then check the disk=20
> >>> gives the same errors.
> >>>
> >>> What could this be?
> >>>
> >>> ferry@delfion:~/tmp/edison/edison-scarthgap$ mkfs.btrfs -n 4096 --=20
> >>> shrink -M -v -r /home/ferry/tmp/edison-intel/my/edison-morty/out/=20
> >>> linux64/build/ tmp/work/edison-poky-linux/edison-image/1.0/rootfs=20
> >>> edison-image- edison.rootfs.btrfs
> >>> btrfs-progs v6.6.3
> >>> See https://btrfs.readthedocs.io for more information.
> >>>
> >>> ERROR: zoned: unable to stat edison-image-edison.rootfs.btrfs
> >>> NOTE: several default settings have changed in version 5.15, please=20
> >>> make sure
> >>>        this does not affect your deployments:
> >>>        - DUP for metadata (-m dup)
> >>>        - enabled no-holes (-O no-holes)
> >>>        - enabled free-space-tree (-R free-space-tree)
> >>>
> >>> Rootdir from: /home/ferry/tmp/edison-intel/my/edison-morty/out/=20
> >>> linux64/ build/tmp/work/edison-poky-linux/edison-image/1.0/rootfs
> >>>    Shrink:           yes
> >>> Label:              (null)
> >>> UUID:               c2ecfaca-168a-401b-a12a-e73694d7485a
> >>> Node size:          4096
> >>> Sector size:        4096
> >>> Filesystem size:    1.43GiB
> >>> Block group profiles:
> >>>    Data+Metadata:    single            1.42GiB
> >>>    System:           single            4.00MiB
> >>> SSD detected:       no
> >>> Zoned device:       no
> >>> Incompat features:  mixed-bg, extref, skinny-metadata, no-holes,=20
> >>> free- space-tree
> >>> Runtime features:   free-space-tree
> >>> Checksum:           crc32c
> >>> Number of devices:  1
> >>> Devices:
> >>>     ID        SIZE  PATH
> >>>      1     1.43GiB  edison-image-edison.rootfs.btrfs
> >>>
> >>> ferry@delfion:~/tmp/edison/edison-scarthgap$ btrfs check edison-=20
> >>> image- edison.rootfs.btrfs
> >>> Opening filesystem to check...
> >>> Checking filesystem on edison-image-edison.rootfs.btrfs
> >>> UUID: c2ecfaca-168a-401b-a12a-e73694d7485a
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space tree
> >>> [4/7] checking fs roots
> >>> root 5 inode 252551099 errors 2000, link count wrong
> >>>          unresolved ref dir 260778488 index 2 namelen 11 name=20
> >>> COPYING.MIT filetype 1 errors 0
> >>
> >> Looks like exactly the nlink bugs related to --rootdir option.
> >>
> >> And that's fixed in v6.10 first, by the commit c6464d3f99ed ("btrfs-=20
> >> progs: mkfs: rework how we traverse rootdir"), then further improved=20
> >> in v6.12 with the commit ef1157473372 ("btrfs-progs: mkfs: add hard=20
> >> link support for --rootdir").
> >>
> >>
> >> So in short, if the directory contains hardlinks out of the directory,=
=20
> >> then you have to use btrfs-progs newer than v6.12.
> >=20
> > Hi Qu I am confirming v6.12 resolves this issue. Afaik Yocto uses=20
> > reflinks. I'm guessing that generates the same issue?
>=20
> Reflink should not cause the problem, shared extents (reflinks) are not=20
> longer shared inside the new btrfs.
>=20
> E.g. if two inodes shares the same data extent, it will be created as=20
> two data extents, one for each inode.
> Thus it will cause extra space usage.
>=20
>=20
> It's only the hard links causing problems, as older progs directly uses=20
> the st_nlink reported from the host fs, but it's very possible that,=20
> some hard links are not inside the rootdir, thus causing missing nlinks=20
> inside the created btrfs.
>=20
> >=20
> > As a work around for people on Ubuntu Noble (20.04 LTS) with btrfs-prog=
s=20
> > version 6.6.3-1.1build2, installing the package from Plucky (no other=20
> > dependencies) with version 6.12-1build1 solves this issue.
>=20
> Sorry we didn't notice the bug early enough, thus the fixes are only=20
> landed into v6.12, and we do not maintain backports for older progs.

I never noticed either, while I was in a very good position to do so.

Times when I noticed filesystem errors I attributed these to unstable kerne=
l crash. Which was probably true, never noticed errors at T0 until now.

> Thus I'm afraid Yocto or similar projects have to require a much newer=20
> progs instead.

Yes that is the workaround below. You can copy the newer =E2=80=9Drecipe=E2=
=80=9D and that overrides the older one. Of course goes all the way and bri=
ngs in new headers which can break dependencies (btrfs-compsize in this cas=
e).

> Thanks,
> Qu
>=20
> >=20
> > Yocto users on Scarthgap (5.0 LTS) with version 6.7.1 may copy the=20
> > recipe meta/recipes-devtools/btrfs-tools/btrfs-tools_6.13.bb from=20
> > walnascar or 6.14 from master. If they are building additional tools=20
> > that use headers from this package like btrfs-compsize these may break.
> >> Thanks,
> >> Qu

While here, am I right that we can not generate the rootfs with compression=
 on?

Reason I ask is, Yocto of course builds the rootfs and than has mkfs.btrfs =
create the image. But it runs as unprivileged user, so can not do mount.
And then can not do defrag.

> >=20
> >=20
>=20
>=20



--nextPart2810006.C4sosBPzcN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

<html>
<head>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8">
</head>
<body><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Op woensdag 23 april 2025 00:00:36 CEST schreef Qu Wenruo:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; =E5=9C=A8 2025/4/23 07:02, Ferry Toth =E5=86=99=E9=81=93:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; Hi,</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; Op 21-04-2025 om 00:00 schreef Qu Wenruo:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; =E5=9C=A8 2025/4/21 07:15, Ferry Toth =E5=86=99=E9=81=93:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; The following is originally done by Yocto's bitbake, but whe=
n I try </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; manually it reproduces.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; I create a new fs on=C2=A0 a file using -r as ordinary user,=
 then btrfs </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; check the file (before or after mounting makes no difference=
), also </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; as an ordinary user.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; The fs has 1000's of errors, I cut most because it seems the=
 same </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; type of errors. The files system is unrepaired bootable, but=
 can be </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; repaired using --repair, in which 1000's of files are moved =
to </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; lost+found.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; The below was mkfs on a non-existing file, but writing to 16=
GB dduped </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; file (rootfs is 1.4GB) makes no difference. Neither does dro=
pping -- </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; shrink, -m or -n.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Also, writing the file to an actual disk and then check the =
disk </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; gives the same errors.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; What could this be?</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; ferry@delfion:~/tmp/edison/edison-scarthgap$ mkfs.btrfs -n 4=
096 -- </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; shrink -M -v -r /home/ferry/tmp/edison-intel/my/edison-morty=
/out/ </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; linux64/build/ tmp/work/edison-poky-linux/edison-image/1.0/r=
ootfs </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; edison-image- edison.rootfs.btrfs</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; btrfs-progs v6.6.3</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; See https://btrfs.readthedocs.io for more information.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; ERROR: zoned: unable to stat edison-image-edison.rootfs.btrf=
s</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; NOTE: several default settings have changed in version 5.15,=
 please </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; make sure</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this does not affect yo=
ur deployments:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - DUP for metadata (-m =
dup)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enabled no-holes (-O =
no-holes)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enabled free-space-tr=
ee (-R free-space-tree)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Rootdir from: /home/ferry/tmp/edison-intel/my/edison-morty/o=
ut/ </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; linux64/ build/tmp/work/edison-poky-linux/edison-image/1.0/r=
ootfs</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0 Shrink:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 yes</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Label:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (null)</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c2ecfaca-168a-401b-a12a-e73694d7485a</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Node size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 4096</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Sector size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096<=
/p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Filesystem size:=C2=A0=C2=A0=C2=A0 1.43GiB</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Block group profiles:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0 Data+Metadata:=C2=A0=C2=A0=C2=A0 single=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.42GiB</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0 System:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 4.00MiB</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; SSD detected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Zoned device:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Incompat features:=C2=A0 mixed-bg, extref, skinny-metadata, =
no-holes, </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; free- space-tree</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Runtime features:=C2=A0=C2=A0 free-space-tree</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Checksum:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 crc32c</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Number of devices:=C2=A0 1</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Devices:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 SIZE=C2=A0 PATH</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0 1.43GiB=
=C2=A0 edison-image-edison.rootfs.btrfs</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; ferry@delfion:~/tmp/edison/edison-scarthgap$ btrfs check edi=
son- </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; image- edison.rootfs.btrfs</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Opening filesystem to check...</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; Checking filesystem on edison-image-edison.rootfs.btrfs</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; UUID: c2ecfaca-168a-401b-a12a-e73694d7485a</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; [1/7] checking root items</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; [2/7] checking extents</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; [3/7] checking free space tree</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; [4/7] checking fs roots</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; root 5 inode 252551099 errors 2000, link count wrong</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved =
ref dir 260778488 index 2 namelen 11 name </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;&gt; COPYING.MIT filetype 1 errors 0</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; Looks like exactly the nlink bugs related to --rootdir option.</=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; And that's fixed in v6.10 first, by the commit c6464d3f99ed (&qu=
ot;btrfs- </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; progs: mkfs: rework how we traverse rootdir&quot;), then further=
 improved </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; in v6.12 with the commit ef1157473372 (&quot;btrfs-progs: mkfs: =
add hard </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; link support for --rootdir&quot;).</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; So in short, if the directory contains hardlinks out of the dire=
ctory, </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; then you have to use btrfs-progs newer than v6.12.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; Hi Qu I am confirming v6.12 resolves this issue. Afaik Yocto uses </=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; reflinks. I'm guessing that generates the same issue?</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Reflink should not cause the problem, shared extents (reflinks) are not <=
/p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; longer shared inside the new btrfs.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; E.g. if two inodes shares the same data extent, it will be created as </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; two data extents, one for each inode.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Thus it will cause extra space usage.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; It's only the hard links causing problems, as older progs directly uses <=
/p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; the st_nlink reported from the host fs, but it's very possible that, </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; some hard links are not inside the rootdir, thus causing missing nlinks <=
/p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; inside the created btrfs.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; As a work around for people on Ubuntu Noble (20.04 LTS) with btrfs-p=
rogs </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; version 6.6.3-1.1build2, installing the package from Plucky (no othe=
r </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; dependencies) with version 6.12-1build1 solves this issue.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Sorry we didn't notice the bug early enough, thus the fixes are only </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; landed into v6.12, and we do not maintain backports for older progs.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">I never noticed either, while I was in a very good position to do so.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Times when I noticed filesystem errors I attributed these to unstable ke=
rnel crash. Which was probably true, never noticed errors at T0 until now.<=
/p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">&gt; Thus I'm afraid Yocto or similar projects have to require a much ne=
wer </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; progs instead.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Yes that is the workaround below. You can copy the newer =E2=80=9Drecipe=
=E2=80=9D and that overrides the older one. Of course goes all the way and =
brings in new headers which can break dependencies (btrfs-compsize in this =
case).</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">&gt; Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Qu</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; Yocto users on Scarthgap (5.0 LTS) with version 6.7.1 may copy the <=
/p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; recipe meta/recipes-devtools/btrfs-tools/btrfs-tools_6.13.bb from </=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; walnascar or 6.14 from master. If they are building additional tools=
 </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; that use headers from this package like btrfs-compsize these may bre=
ak.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt;&gt; Qu</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">While here, am I right that we can not generate the rootfs with compress=
ion on?</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Reason I ask is, Yocto of course builds the rootfs and than has mkfs.btr=
fs create the image. But it runs as unprivileged user, so can not do mount.=
</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">And=
 then can not do defrag.</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">&gt; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<br /><br /></body>
</html>
--nextPart2810006.C4sosBPzcN--

--nextPart3162908.4XsnlVU6TS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEqR7zuEuxfQFO1Tt5OB30JY3rOi0FAmgJEBIACgkQOB30JY3r
Oi0SIQgAjIhMy/RIEg/MoqN+sUM6v/h97SbW8rrzDdKmUGia6/5XZKcOx15tWkMp
wzUs55kngd46XbQ5FlbFPWAuTydp+FYEFprdxX2jXvHo4mdZYSTDVT1JRJraT6hV
MmFMQsS++EekYbF6TWVO0qjL/hE/YcGR0pKXCU9jwfpDtiYCbwlp0P6ysuPBAxcF
G73F33odhEviwasKgxPBFoaLNTxn5yNMqQu/Aw9rBuHYm72IYJ2Kok7kiXiuXVU3
b9t6UdB5tCWtR3klg5jTF4zU9dABBh/6BvsJfGLcoW+s3Lwbh15ocdgHJJOSKOdU
vVdCTxlAnSXpi4mXFl9FgSXWQyH67w==
=3hmV
-----END PGP SIGNATURE-----

--nextPart3162908.4XsnlVU6TS--




