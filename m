Return-Path: <linux-btrfs+bounces-15196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAFAF12DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 13:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3BB16CB33
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1AD240604;
	Wed,  2 Jul 2025 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="NrBYula1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194F1DFE20
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453978; cv=none; b=NPm9apQnZCxZ4akb1JbCwwwZb6tsVOrz3077qMIiUNedusUVgaKHdbCgnr7yfoQYSFB/XsOuU/JkNFqwNKVKV42Wz40fMdqQ0I9ZK45bpZUDn1An5EU7CAl56hkA/0WUeQtzsDFJOvPHHqL8IE+dujeFcPWr3MEZIsaNXKJLZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453978; c=relaxed/simple;
	bh=mWdPYGDB0ctwp5WjQEk5rvWjbKS+GE0AmuaIaFivaxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW0wYYWAi5KewaSAF9nxWRnbWVxR60qSNXNKu8gKJ9VUWuz3dsTMPNEWrN6ili7/TaHoqBHBwpp0DjFGa9rxCNfFqKJiyna1w8z23sP8FSkvweQ4WhZRBBKvSlVQq9R8/ArkXaZNtRXdOM/+1sctOXVzLp7vdxX99SM8BdTHwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=NrBYula1; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1751453966; x=1752058766; i=christian@heusel.eu;
	bh=mWdPYGDB0ctwp5WjQEk5rvWjbKS+GE0AmuaIaFivaxo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NrBYula1e5pJ90pGvX6vdRmdvFSd++vrMm+I2YWtBRv4/E8PxBNzwhR6tnmF6T7E
	 USOBU/xvfdG6kJMZkW317ZK/icVFMmmtO4T+JPefZVJRV3by23i++6tNpI385IXkL
	 bU88FMzMvW2/OP96UfBakni1D0N9e3jm+MG3CLSO0lp35L2U3bgxdbVsYGYj5uLzQ
	 6ThfSDyMtLtwg/9WcKq3SKmtmG1dRh+curolcXPwfa7ZMQbuYJgjMkXB7fNubcxkF
	 KLN3vHP7VBM+Ww9sJeMcg9YitbMyiGcv6ClPNzyxlzhIIgFJbJRvL/xeeqt3uok5q
	 ilp85+bFYiwKEdOqUg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([147.142.138.253]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mbiak-1v7tDY1qus-00kuMn; Wed, 02 Jul 2025 12:54:10 +0200
Date: Wed, 2 Jul 2025 12:54:09 +0200
From: Christian Heusel <christian@heusel.eu>
To: Mio <mio-19@outlook.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: multiple devices btrfs filesystem device detection on recent
 distro updates
Message-ID: <7aa130d3-7772-47ba-97ea-9f5002c037d3@heusel.eu>
References: <TY4PR01MB13853B64BF6DB7BEA98170AE99240A@TY4PR01MB13853.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c42n666wgeyzguk5"
Content-Disposition: inline
In-Reply-To: <TY4PR01MB13853B64BF6DB7BEA98170AE99240A@TY4PR01MB13853.jpnprd01.prod.outlook.com>
X-Provags-ID: V03:K1:uJrCbVUWTvkmgc02fzH7c0LYstQF6s/9MqGfY677h+HX3Whk4Q8
 xvckzQ8zp5ctwLVRNYzup2efr4KHkV92WQiPHn59VcKhIQMUPjSftfKhdfuwrHPK4OJc7Ie
 TNnBAIfDE2lVHhqEs92CojbrQG9k0lQuhAYzRAa0o70vlBr3rMfSz6zCksG9BM4qObYOEOY
 FxIM5pFZ1WkZMvzDU2fsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3jwRnsyWaoA=;WeEgNXq9D9l955zX17ogyespm8G
 +unmg1uXC0bASBu6FukAn3NGccT7k8sY1eHa+XutPQCFXn5e7rBCflpA6ICmr4wz1xR1/A6lu
 1MvYi8EMTUji/Fh3kiJcM+gZuXJ2aCom23NOfu4YPpA/vVC5qbdwJRUOQNqvmk+gY2k1ndSmf
 rxYefpBzdBM5KgAAnHR85K+U6B23y10OJFxYN3yQi9AKvOKbqOHoyfd9ql9bWnbGo1z8falaf
 5141Y+fZRaCyd01eXAjO6wFMLX2FuNTUM/MA9Rxmruwnqbv8C8TZO9OeMXUtxTSG6OAdv5lJx
 Ie6j+7hDqyFpT1f4h4cO7jPRxQhLFjrO+y/HclBCxTJmBlzU0kBaIa9kqIYZsV/mGKW1eXklF
 kimr+LDyg9BtSTwVYVMZs5LZehlOPi6RNDNrYzXnP21Uf36jEqwYnrHaK0M05JlA21Tqieapj
 TxmKkMGfjCfCbuN08zJh2dhBPyuFuQsz4MbYqbMurnDgxDIXmYCrfDZTsmRGsrOOVa/PYxwvI
 QLK9QRk5+tJikZbP5nq2rxBkCSQNXsYQxqkENPSRuVJEucnw7QKB7i44qP8RYa101BNUTX4tb
 MyfEiJPah5dulLr6nDZpEhQQ+2x/gg7+hU9Z1ZReNtXhIdhHPH29wR7fP3ob3rOKVe7iQswGW
 Bsf5lPEtgEJYiON4DHaInGI4VM2ArkX44q1MAlnSP221iBGRcJz7rKGE6UIW255nCe4/nAFro
 8qoTtEwr24Z8mHgt/V9nvj460zpbjQGwdK0pYnNQ1NQ5obOhhQCCdrtPw5uY8zRz4MaCieyEs
 7tJx3JN9ABCbvRSDIUURMyDTBKAz1uY6XnKFQF/b406qV8PUdCXNuggS/Or0vjfpHGXJDMpBg
 e6jDx9eA1dGvG5jqVYX/uRWMmWF8OA6r2H7w31ONXeaCY8yvX1CCvn40qRyodw8GCWAimZm6I
 1+oM05o88dgauFpp5MQlBYpWJ7z8kQkoMc4j/IMPwAKl6eOjB84JwbfKZV+VejDEVB502Dn5G
 kpsnNfyT1Qd+dj7O7NrQjyWHjFGpMkKSWPupxPoHdYgaV1AqV2eGpuokKgUjciGyc3SKk6i2n
 5C/USnfV+/xI8vSjX0aehbssbEhMrjfVQ0IrtYM5f/ngQ/nghnV3EVO6XA8wYK1HBkc0PTIHU
 IScII4/Wpx//dFW6pcvtZahSvLzHsD10JrQ91cNLAiWQuPE8JpN6y8eteStS9jfOuH0cZgQNh
 55lyIxsX0UKEDHAsPfZhWnhXk4u6hhx5ybOWcMck10BvqpTuzbYAl/I8tbkXi/SewuN3KiYk3
 YrwUDHepDI2EdtWSq2iA86vdwuwkReDgmu0vuYD/aUyfK0XjR6XuRU5FD4wlUOhjmtDotT40L
 PSlFnZtVh0sH9AWB69Lcd6aW90sdMdeLrD3Ocgh8Wm7dBqr/DEdUQE8RwJIwW9jxvJHOrQBzQ
 Iu8SQH1EBBT3xcNXG5C0yBy2fdaN2WhjLUByWhdcDAMp59qyzXCJ08vb6uLDAr+4cBAgAqxFF
 CU14CEK8u1z26jcAKvo34BHfDvS0Yxu1Mk0lU8HRFqj3VxQ1h4skglOKs6VtOuo5AcOmZtkVL
 ioRvE4Xf/yYTHtj8r7RGtN/GpzsdlI4


--c42n666wgeyzguk5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: multiple devices btrfs filesystem device detection on recent
 distro updates
MIME-Version: 1.0

On 25/07/02 09:40PM, Mio wrote:
> Hello btrfs mailing list
>=20
> I am facing a device detection bug on multiple recent distro releases and
> rolling linux distro. It is a bug in userspace and not a bug in linux
> kernel. I was able to test different linux kernel versions from 6.6 to 6.=
14
> on some distros. The userspace with the problem shows errors on all linux
> kernels and the userspace without the problem works fine with any linux
> kernel.

Could you re-test with the 6.15 kernel (i.e. included in the archiso
released on 2025-07-01) or even the latest mainline released candidate
(which is 6.16-rc4 at the time)?

I have a prebuilt version of it ready here, but you'll need to find a
way to run it on your system:

https://pkgbuild.com/~gromit/linux-bisection-kernels/linux-mainline-6.16rc4=
-1-x86_64.pkg.tar.zst

https://wiki.archlinux.org/title/Archiso#Kernel

> The problem is that lsblk -f command can only detect one device in my btr=
fs
> filesystem. The filesystem has 3 devices. When I run the btrfs fi show
> command, it shows a "Some devices missing" error message. However I am ab=
le
> to mount it by using the device option and specifying all 3 devices
> manually. After that I can see my filesystem correctly displayed in the
> output of btrfs fi show but lsblk -f still can detect one device.
>=20
> How could I inverstigate this issue further?
>=20
> I previously reported this problem on
> https://bbs.archlinux.org/viewtopic.php?id=3D306625 and
> https://github.com/NixOS/nixpkgs/issues/408631
>=20
>=20
> I copied following output with OCR so the result might be slightly incorr=
ect
>=20
> btrfs fi show on archlinux 2025.06.01 livecd
>=20
> Label: 'HDDPool-data' uuid: cae95f2?-f8c3-48c5-96d6-e263458efda2
> Total devices 3 FS bytes used 10.49TiB
> devid 3 size 9.00TiB used 6.96TiB path /dev/sdb
> *** Some devices missing
>=20
> btrfs fi show on archlinux 2025.01.01 livecd
>=20
> Label: ' Rescue3' uuid: 623630d3-64d8-4917-ade8-412101d23b40
> Total devices 3 =E2=80=A2 FS bytes used 10.48TiB
> devid 1 size 10.91TiB used 10.48TiB path / dev/sde
> devid 2 size 14.55TiB used 10.50TiB path /dev/sdc
> devid 3 size 476.94GiB used 28.00GiB path /dev/sdd
>=20
>=20

--c42n666wgeyzguk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhlD9EACgkQwEfU8yi1
JYWJAQ/6AyDhu+M9X4YFPsey+ZQe3ZT5wztpLcGynVbpfBPr44boQPVoYzeaeyxg
R64MJXZdGq6SND6c70D+HGeWLHnACHRpyKIIJ52ifmzr2dtvhgM7hD0BwNWH/jG6
K5+GYk34vPpLMCSMHHd3s35KvSzyvwU8ErdC+elkEcJQyJNZ4ous6CdrH1Rt/Ggg
Vqs+252wCekJVuL6zbBxgfFj+GliZmR21rTYqJCXeicf2118NlWTE58XgIU/sk+l
CsC9a6pnlFag6OJ6WKrrQGJiPCvUXlrWUehcJ5VxJ1E6qm3sT2/TRqXdup/GHzEK
PpfWRFD1V9ffd+R5IbpNZ916fKK5urccoEFM09get+5fPcnjH63GCUhgNuLvpOr8
U0CErnBZgz1Afobw4nsK+qkzzjIfhGah6/e1Tk1fHfrH0iouJr3UfQVE5DgMN8AO
g5NW5Sl6P56OjJHSdorkAMZ3vTWJFIWS9yT79ghVd6BLIBvY31Zmz/Ujp8TPF8Ca
n4yV0ZApNY2PFlS6bX70ii3zI/f6jCMie50AHYlNYeNGDwR4iX6d0irjuai7Uwdh
BEY2kcZc/ll9EMUlOskQFp4/nEXXPQ1mLLBTnDs1wd4Frw2w+t8iz/5lPwGLWo0x
hgDbr2qjRC8GgoBazqQ/aKGfexHuaWJI8ucmDeiRTN8iTCnuDuQ=
=niSR
-----END PGP SIGNATURE-----

--c42n666wgeyzguk5--

