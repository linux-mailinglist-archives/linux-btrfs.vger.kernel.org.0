Return-Path: <linux-btrfs+bounces-6965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B66894663A
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2024 01:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22B4281E74
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A7613B297;
	Fri,  2 Aug 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="TVBcHkfn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AA1ABEA4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642238; cv=none; b=bs/qaogV0vTgbdbJjStnz7WgLuZyfKjScZNsQ8HnCqSx5QbruiZScXabh41POFLGjnSxSiXezf7tOCrZIexDzGXdHE4+c9Z5mQsBQY/hBG5ejcc0KnbiXRUVYpBSUNLWBxw/qNjYxwCcnjvXKLY9QEjoD5NE25zUAscg1TdyLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642238; c=relaxed/simple;
	bh=5FjUAaEq7iXrI22knMCdCXisrNW1wZfhf466fJpLGrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=co7uwssHNP7fwxaSmvYGTl3GisiuOSUzbSG2oAe9CDN7RuaRwp9QnYOHxTWHylUUmULFzfx1Jxnx6gJiDhWc0p1spI/JalRtWNx8f2lHgc3O8/Yj99WcbLY1PYw1VBHsQ7ZA3jAs0sYI1YfEDa9RoyxmN22fffM+feLrtu/IMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TVBcHkfn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R8mxbwQFvuRzdTEYZtnJs+bo9TuKID7l6Fy4ciYILOs=; b=TVBcHkfnW5J3amNG2Wl5kXi3K3
	7nRxNw6robdsEsWcy1OLZRiWQFlyWCOyd1jH2/YlEoCsJxn3oqzPryT2wLyB1kjSD/dzbKWOlJKCG
	QdPZz5P+mgEuY6d6ijzumYHWLflHGFdXbkCt+u8ykCyJLFhGK/8y+DTvNI9OJvFEsM4DssEY0yrEb
	NiiQbdK8mDXXU0Yx9s1GDEkjR1cuOdCbjEn3Uvsi7pB3W50Mb2ecrz+l1tnnowhK/cAH+iJFKcbp5
	ixbpfx76Hylv9rsgBD2rGqI4m2ZesqKGUkzMsSzz7Atk8ThvJ1VNEe+Ndo/NRBCCQUaspy9+wpJD1
	/vt2dk3w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1sa1w2-00F12i-2o; Fri, 02 Aug 2024 23:43:45 +0000
From: Nicholas D Steeves <sten@debian.org>
To: kreijack@inwind.it, Mark Harmstone <maharmstone@fb.com>,
 linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <maharmstone@meta.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: RFC: mkfs.btrfs --subvols UI [was Re: [PATCH] btrfs-progs: add
 --subvol option to mkfs.btrfs]
In-Reply-To: <eb3642fd-963b-4a14-9cd2-8339adcb58b7@libero.it>
References: <20240627095455.315620-1-maharmstone@fb.com>
 <eb3642fd-963b-4a14-9cd2-8339adcb58b7@libero.it>
Date: Fri, 02 Aug 2024 19:43:27 -0400
Message-ID: <87plqqqyn4.fsf@digitalmercury.freeddns.org>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Qu Wenruo <quwenruo.btrfs@gmx.com> writes:

> =E5=9C=A8 2024/6/27 19:24, Mark Harmstone =E5=86=99=E9=81=93:
>> From: Mark Harmstone <maharmstone@meta.com>
>>
>> This patch adds a --subvol option, which tells mkfs.btrfs to create the
>> specified directories as subvolumes.
>
> I have considered this feature in the past, but I do not have a good
> enough UI for that.

Recursive subvol backup & restore seems to be a desired feature, so I've
considered that in the following:

Goffredo Baroncelli <kreijack@libero.it> writes:

> On 27/06/2024 11.54, Mark Harmstone wrote:
>
> Could be possible to decouple the "--rootdir" and the "--subvol" options ?
> I.e. doing a first iteration where only the subvolume/subdir are created =
and a second one where
> all the subvolume are populated.
>

This also makes the most sense to me.  In terms of UI, what are the
downsides to the following:

mkfs.btrfs --subvols 1 2 3 4 5 $device
# Creates a flat layout

mkfs.btrfs --subvols subdir/1 subdir/2 subdir/3 subdir/subsubdir/4 \
  subdir/subsubdir/5 $device
# Creates subvols inside plain directories

unless this is specified:

mkdir.btrfs --subvols sv_cont0 sv_cont1 \
 --subvols sv_cont0/1 sv_cont0/2 sv_cont1/3 sv_cont1/4 \
   sv_cont2/5

This creates nested subvolumes, and "sv_cont2/5" will create subvol=3D5 in
a plain-dir named "sv_cont2" (the gotcha!/pitfall).  Each subsequent
"--subvols foo bar baz" argument creates deeper level of nested
subvolumes.  If the necessary parents haven't yet been created as
subvolumes, they are always created as directories.

And then "--rootdir" unpacks (yes, I'm conceptualising of rootdir as a
tarball).  That said, I wonder if rootdir.img is a special
high-performance format, and wonder if it could benefit from a TOC to
collate subvolumes.  This also seems orthogonal to a future btrfs send
image type would recurse and store subvol layout in a TOC of some kind.

Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmatbx8QHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYU/NEACLaMv60iLQnneSpTher4+YMNzFCraoSGdp
dlxG1O/5uMDtUeMCYa50SCWpQKl1mEtVkc+LGtnWOVfKrBzAtSxDZjunzgqORHS+
WBdyHc5OsPu49PP9IPZ+e3p+mT7T1MAJrsRZwyAgWLDw9Yr4lyMA0ntZeheVArY2
+pwz5Pty5KUQTIdLDrA3zltjPUe6QpeS3pXKcP7Y9JxDoWJ6dPHH1q1486pioymr
T9vNxFwlTpOeuLH9jsXqNiXwZOkeeia5Tj5YlG16/AEicqbRAF6lQGJMIv4es+wu
oq8oGmpACr4R4Rk20WBI0lLa1bzfIofygtfJxjOvWszPksSyX4kEgNDwE+yeZH+8
b9bOLdmDeZFnEgfAuMc19tzhcIe+3MtVQS//3jTHG7tK/rISzshpdZrLS/TK8gCi
YQOtNBdSFED2TYUppSJb6qUXh+v/ekojr91iczmGL9IuVkwxURLb5VeqEHrCfQkZ
m2gQMkWmTE7kchszDR7bxbedF88/TKmyjEBwZcpCADW50ByzdSsJSqq3eQNRI9/T
Ptum8S2Fkb9oaIEd8wlAx9HXm7Mzca7GdOu1eufmKxw+RZcg679i//M/8zugoXPH
p1X8xJEZHmle4jNgFUf6AwjR/36xljKyZM3dFDTNMwJeVIXvagXcnFvIzJF6BVoL
7beZNq4vUw==
=rjEL
-----END PGP SIGNATURE-----
--=-=-=--

