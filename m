Return-Path: <linux-btrfs+bounces-17922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE9BE73FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 10:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC83D6202D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B52641FB;
	Fri, 17 Oct 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="ZMXTo7Ub"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23814409
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690826; cv=none; b=B6/HN9TEPXRaxEvPShcaF9/u3anPnYbecwzwO/Q7ZSILNjpzfOlU0Ojb3noQLTKjx1fmMzB1FoZezOMPEcBxRE4+AXcYqJt3osP/p0S7do8P+R9FzmI1Qy0sMDCj6xYdKaV//72m5hWM25jRgFUr8W69+Qpv0kYL6JPlav7tG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690826; c=relaxed/simple;
	bh=Z0sx2Mmaswvj+zLX8r36af7CXy7u5sl34uFrKjCxbMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otsm7NLiMk4PKp8nHLEvM7z2tbqIEC8ysgh23OEs6lRDIYA9NmiaVN01xyDlfed25pCMjOMw0d4rzVO70P7o004pDfZZ/owxFCqNRCr5VwUoPo4eMImFIMhrlDW/Yn7sz1K/vwJwGta4IQzpQxzYMA4ZfDGNyvz65k2lyetbaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=ZMXTo7Ub; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1760690818; x=1761295618; i=christian@heusel.eu;
	bh=Z0sx2Mmaswvj+zLX8r36af7CXy7u5sl34uFrKjCxbMY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZMXTo7Ub0TK99+RlCI76ZiKYVnCzkh49M0DZnb43dG5DN3TrI94sEW0GWKuGVi7M
	 E3B8tocKrRlDaBFSB5bnWUaU3a5lpfP6ebGzJTlk4adivnKT2UOFycV0ZSO3jHWO5
	 PkIDnJ5dMV8x/DpRlhvribNpz1gg+AEXpQgKjBWT67itNlZpDLF7mApcPhiLWJYpc
	 ay57grR9XO+1/psAJST9U19XY2W8jwPJ63gt98A2iMoDWxbkj6JZjMUxAB3D/YcMc
	 QlwZ4VP0dFc5pjNha8cSfYFiwfND6XWwe5jZDZjI5ASB6U4P4+vqMB9Cu/UAkG9ft
	 JCWt3o/E7nFW37cBAg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.113.46]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MDQqk-1v1T6U0AOk-00Ad0L; Fri, 17 Oct 2025 10:41:44 +0200
Date: Fri, 17 Oct 2025 10:41:43 +0200
From: Christian Heusel <christian@heusel.eu>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: systemd-devel@lists.freedesktop.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Any proper way to prevent system from power management
 suspension/hibernation?
Message-ID: <2e47f358-69d7-43b2-985f-c2484be9469b@heusel.eu>
References: <32690b57-86ac-49bd-b913-b080aab03b42@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrbrvrbkae5zvp4o"
Content-Disposition: inline
In-Reply-To: <32690b57-86ac-49bd-b913-b080aab03b42@gmx.com>
X-Provags-ID: V03:K1:kQ8pZYdxPcmDUxYUEfJgwLPAMbyNbeUVX1SaHXbG27U3mrBsd2g
 +JOfSi1ZyoVbtW/a5TuHjb4PZ+kfHn/+ycDAoP77Q+S5/lBUzTWQqVRqWQuywcf/Fa1ICxp
 98Nku8iLq619XUtA65nNZPLXu+ki9ny4nI+o6jWiUq6m6MfQKfYysDxpyH5Z4ihNfCfImaL
 opIwfpOMdngsOob672ICg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8KtbKeL1Qz8=;C4eBRU0faHTaEdTIZ/e9lGXR0Ip
 MviJ5sSzqsucLTIdlCyEOJONxWByFR5+Uw2+dFhSd5hWkAvlbqMQKEMTWxpeTWZvP4PA9a5f6
 OANEzEanx8z1IHMBZlXimZW0tL4vgFg7sjwMe5HAGKMBYfnOQZnJSBYtxKm2FgvCPuYqH5KAi
 DPr2XHQAH00TxRmHe9BDtKkv3U4rh4utP1SN2APzwhyHFlAE3FeKxV2jsA9jhZZsaq84X8l56
 fQlN8R/73MyZnImysqEc9wOAKnf7h4HgQEPDjwvUMjDT9KCaB82agvT89a900VHo/4HbjnvOW
 fwwGLy3rWLIBaQhggl4TQfD43HA4cy4dGLs7+XcqE9atJHfurEMAbMJJFrWhdbrunHo8yL8W9
 tEHM14yQ5i+hDTMzVh4hOWUBst/T/irnei3RBjkQwxLbQ3wAQd1MgVeIAdN0nfK0bvjZ2sHAO
 bAqUkv8mlUJAYL+RM65dyRzdgE/Sb2KKf55YUiXWzYQ1rpo3Y7qXDvMI47QtHhv3pwSDL+TP5
 WvSP9j6qmqh8IH7n+LQdvrag5plugfgiwrWqfb8jJ5cRBxXKa2v3iY1o+cTAJLkmS3qvb7yP8
 tU3vHCnCpzAaJuemOGON7m0hWnavdCz/9250vxXJ0/N84D/JU6+iNykI9uSaX7TRGE7H/oBYW
 EVOSPI0+YtHmyr57CIwa6yewFM7QSYNhfwY0YbVa8NupFwEADwnpfGKcCu+r3H704cWJHIMnn
 JdB/UsmkY5iKgAUCm2Yt8kM190KJtnpztqb0CxdK/vHVepW2KqGRV1j0orRmgBbwe79eHqCR2
 2pbEnEFTZ3TAL0XbDhkthNGZ6EuHvNXlyz275GAshO/k5aKffCPj9xyJSAwwbSSTt36lbwvIB
 rQUejr3E0HwLr3al8kS2xxpXgODxR9BBGKLt13lM/oAjCuOyeCj6Z5nyXgGS4x8Nn90Ge2Vli
 DK7HGbDhmDK7oIgwY7vNS/XEfv4hRLq4uZ9b/Ja4e1t7QukxN9mfZJXhDCfoH/NEQq7dF97+h
 K0ykN20XwvGtnvxgc5nVf9lX/2xRFBQEdgH7Z9GQI7nhxMG3EtSTndbs8JaQy0EXD/gsJmm8Q
 bpprFoeC0rt6m+klB8oLD0tmds1oKyZBXY6mYEZzSHjRMn40R/2FRgsJ4/feC3SLfsXMdTW2c
 RiBFc83UH11QDW47qm1XIzzDto6iRcbjRb9iOgHfbnzwm9iUiAWBjzlruMdKV/50JYWgfe2Ah
 ipTItrQDovtWhnAfaRJjJUJfKOxY0xRTPuK2/l+xWGEGN42XtFdGEY3KpSWyoPI5gAzXttJzF
 BtqDR3o05DXQ1F6e4OpAvoQsiG9hvv0w7Eu7d5fi2qTFKnHJka2DDS2Kwi+7ihh/DQvEcycme
 2y4kdStg6JucC+i9G5TiLAJP11inmvK266FiRKMHSo6oHIEvveWZMl+IaQAvkiAAe3oVJX6up
 2GrIYWtS9Db7olEhNs7B9+knTS9dL0HaHeFbmiHmFTMw8BGMSaaKXfhbB46+Ozc4nJBgPG8C/
 84VWF46tvJhgIeI4L8mpNTMElQcTIrh8pVtONNdEksoftV6vJXiLwR3MclNaULZ3qdq7darGB
 H497Hl2mw1Gbre1FnpuvyWYGwyFjfWc58OHNXPb0th882WZK9I4AoyeDiQOtYgi7VVr4uRhrq
 gUmDPSOCKaRWFwTutgUKdK+QNwf1uDkTenSqbac/T5uBnYWND5O1x5dwX053lYOTc=


--xrbrvrbkae5zvp4o
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Any proper way to prevent system from power management
 suspension/hibernation?
MIME-Version: 1.0

On 25/10/17 03:08PM, Qu Wenruo wrote:
> Hi,

Hey Qu,

> Recently I'm fixing a bug in btrfs scrub/replace where long running
> scrub/dev-replace ioctl will prevent systems from suspension/hibernation.
>=20
> With that fixed, btrfs scrub/dev-replace will abort the current run if the
> filesystem or the process is being frozen, thus allowing pm to freeze the=
 fs
> then the process.
>=20
>=20
> However this exposed another problem, now PM suspension/hibernation will
> always interrupt scrub/dev-replace runs, and it's not that easy to resume
> from the last handled bytes.
>=20
> I'm wonder if there is any generic solution to prevent power management f=
rom
> entering suspension/hibernation (using systmed), and is generic enough to
> handle not only pure systemd, but also various GUI environments (like
> KDE/GNOME).

I think this could be a good fit for [systemd-inhibit][0][1] which could be
used to wrap the relevant command in the systemd unit.

> If there is such solution, we can provide different systemd services files
> to end users, and they can choose what version they want, either gives pm
> the priority and accept scrub/dev-replace can be interrupted, or prevent =
pm
> actions in the first place (no attempt to even suspend, thus no extra
> timeout).
>=20
> Thanks,
> Qu

Cheers,
Chris

[0]: https://www.freedesktop.org/software/systemd/man/latest/systemd-inhibi=
t.html
[1]: https://systemd.io/INHIBITOR_LOCKS/

--xrbrvrbkae5zvp4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmjyAUcACgkQwEfU8yi1
JYVb2hAAnGD1xo6CYXN+06HZ+l+il9XeVXLC1+bG36H8Z1lP826Z+vLFKmbU802/
c/AdozRtQbEGK9k/MRZHTq1ZNM0akQDHzq96+xKqJiJx9XU7VZ/xWnOv5X7iJZPT
t8TmoA2Q9tLLwaah7neNy37IvVso8j6pU1/HleFdERoImIbv1c9y8S2RWwEHXbI2
ZCMipPeTQ9RZuCmOb/hFfkXSoQjgMvmDxQBy3icxGH/9uyXO1nxtCMMtHKoKUERy
z5FbTPJCPBezWVORY0LM7IwwM/aY/27fM9fCPSFeqGLAbPH4qNwklUGaQiKtuXlq
hc3dr/ms7itP3YVFxIMfSzGbSFit0embI+P2nVi2QQjQgO+97H+JgrCAJiNgS466
+aithykDXbxV9KigFBFHcAyeAhnIsPijDUn0HaNf5+rl0LbXPFifcYBGNssbroek
pxrMVbAq8Y2Guoe+uothfkk4Gir8RYNbWLTt8JrqRSunGLKAqMkDt1u3E6FmxhQO
b6o+avoQu4/jogKXz3tgP2atrKIfS7v0lKRB1RWFmtycMrqfbxhwcPGQE3jvTmo7
A9BsGW1z+0OJ3dZcLYZSpw30CSyL/ANANhFTNWLwWGGp+LilTmwR+53eiMPzc3Sn
UX/Nj4F7d5KImBInqAarTFDcWcr3ZPKABVU9j4aI8FPnNEXhW/8=
=u4yl
-----END PGP SIGNATURE-----

--xrbrvrbkae5zvp4o--

