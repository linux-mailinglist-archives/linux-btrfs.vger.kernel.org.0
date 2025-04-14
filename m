Return-Path: <linux-btrfs+bounces-12998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF8A8898B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB9A1761AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF24289379;
	Mon, 14 Apr 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OFscpAJS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62528B509
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650916; cv=none; b=FdBvqZWZnq7bnmdvfUEA+niN2yWufLL/CDZ59LQgZ2c4zC4aDQUSU8iox3yN6+dvaGqP0pr2uCQ7FjyyZH4+j+YeYa2WzEcA3vf7A2Kc6SVceAn/Bu+bCpCOmTyFQUvZDC/xNsb9tCm2dWq3yH1dWsKpxOjjmYDSHCuDNm5stwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650916; c=relaxed/simple;
	bh=jQ1CRy1tanxnsYl5mHMW73dBJeqHXCHF8AMl3LsjoGs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPhbDq1nXnAJzjucSVf5YhyBwF22DCCNAG4R5xcGhOu7k3lSw3l7IHFAdWq4b+vx0FF1c4vPe/6A1n0wgfm2tHlnxhfBlUVEjd1klrET74pELQ4uLqbr2bNeqPJh/FewrXlPLbCGIU5uxFMIOB7xZoLZ/ZhJ/VWIVQqI0qMD6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OFscpAJS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:To:From:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pQvUzCkKgnnh8D3v8xgx+dN4sZIlqx/OnHlC5kyVkvM=; b=OFscpAJSB95LEyIOy5Y+9Rhlek
	tUi2igtCyV4nmY3ORr98/pxKkCiJ3oU7rXD+SuEc3yA7TprZdWSG78eMYaRy0ZOV4oRkePUMcL615
	3ROHI/wcqdZubWVJbn/p2Nu196IFUQnYVHiIYIp62PQwyvjTNTQaFk9rSNDGPljpDS8pRzQK5qpAQ
	WslvKLxRIEuAj5et2yc2AIQKLiKFnSdWFS2wWfPOgczBieNctZp3JXPLSC2WYB98WQzFzzwo2gnnt
	ED0cJKshurttxaG1oZfUcW6Y8kvlZ3LWHKnD+N01U+1Ex3pMMSQ05NSauap/K1QPNTeVxVNrc1OTX
	Cw1B8oWQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1u4NOk-003DCS-Ff; Mon, 14 Apr 2025 17:15:06 +0000
From: Nicholas D Steeves <sten@debian.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-btrfs@vger.kernel.org
Subject: Re: Odd snapshot subvolume
In-Reply-To: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
References: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
Date: Mon, 14 Apr 2025 13:14:57 -0400
Message-ID: <87friais1a.fsf@navis.mail-host-address-is-not-set>
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

Hi Brian,

"Brian J. Murrell" <brian@interlinx.bc.ca> writes:

> On my Fedora system I have the following:
>
> $ sudo btrfs subvolume show /
> fedora_root
> 	Name: 			fedora_root
> 	UUID: 			c08a988c-ddd5-164e-b01e-51ac26bf018b
> 	Parent UUID: 		-
> 	Received UUID: 		-
> 	Creation time: 		2021-08-10 18:30:03 -0400
> 	Subvolume ID: 		258
> 	Generation: 		5029586
> 	Gen at creation: 	10
> 	Parent ID: 		5
> 	Top level ID: 		5
> 	Flags: 			-
> 	Send transid: 		0
> 	Send time: 		2021-08-10 18:30:03 -0400
> 	Receive transid: 	0
> 	Receive time: 		-
> 	Snapshot(s):
> 				fedora_root/previous-releases/f38_root
> 				fedora_root/previous-releases/f39_root
> 				fedora_root/previous-releases/f40_root.old
> 				fedora_root/previous-releases/f41_root
> 				previous-releases/f33_root
> 	Quota group:		n/a
[snip]
> How can I access that "previous-releases/f33_root" snapshot or even
> just remove it?

  # mkdir -p /btrfs-admin
  # mount -o subvolid=5 /dev/disk/by-uuid/c08a988c-ddd5-164e-b01e-51ac26bf018b /btrfs-admin
  # cd /btrfs-admin
  # mv previous-releases/f33_root fedora_root/previous_releases/f33_root
  OR
  # btrfs subvolume delete /btrfs-admin/previous-releases/f33_root

To anyone else reading this:

Are there any reasons why distributions shouldn't set this up by
default?  What are the arguments against exposing the full structure in
/dev or in /sys (with permissions like 700)?

Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmf9QpIQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYSb/EACZyHGTlll0FWDC91nlIc0H2L6PUedzJLTu
EDtoRMXuOomqR+dGH7aIHL7oRzD9me9YLEBZh0vEU3+fExfW6zvlYnRDpbVo+3KQ
J59QfmmKC+40s5TevMna0SqoFLEqv+GgirKDE5LpjQNU8vHoHUhxwM7aaNKRwzY7
aU6iCcPUFkMI6766JKAMJ1UcYmr8eFHu3v03OnicnfAjyoeOULfn/v3wOEqjkSft
DZiwpMwk4MqRJeezqrGJKDwapLXKrf+fgKQL6ZtrulM9FuKbSuJy50Ps1nmyDk7G
WNGzuB+RRa7XKx3p6sG6Dgxng39eQ6IQ2ha6k3joo7tBM0m91OyR3voy5dey0cK8
7PiFtx1DOx8I6SIn8QHOcw8MlWDsTRZSOIebMZa/hM44CyXD+HxUz5NcjNpnetKB
cGhDNX352rq0Sq6CUm4xrA8a+wHA6CHTzutRb/RPGBi7Sz0/GQh7AiCv2TR9Ql1P
pr+juyanMlHCOQ5uK7VIxBosVPjCafP0eI9X+AkkgHFt3WD1YiOaCDScKBApzQwG
GowPJz1cWQAcPB3GzrjNSfK5F6Xu53cdHD4q3s/dzUtPMmlF8Nf2GGIcs3Z/OFoN
TnQYskFwGC9c/+dcelvt59m/E9UP1KAQYU8eDq9AY2T4oAlPi8XgQEbc8GIMKJ7Z
V4W7tM38lg==
=YqZv
-----END PGP SIGNATURE-----
--=-=-=--

