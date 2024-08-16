Return-Path: <linux-btrfs+bounces-7231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412049547E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E21C23047
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C61B8EAC;
	Fri, 16 Aug 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="V9hvGrps"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A2191F75
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806986; cv=none; b=cDvANVMRlZT6kNgbHgsv6YLDuXWp9w74I2XJpgNzc442GANfe4+VAVtlMFXMncyC1DJ+Indsn6TPaMVlg8eRWc5yc0my1FQ3OUFBL+3An0444mBl4siIu7/GK0hZbiG7M3vEyOp6YyAbv1bGoKqh9o6GZy9PqFftVLKJLtEt0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806986; c=relaxed/simple;
	bh=dUl1HtKDQhN3EIbS7a4MMSHD3zQmh7SyIBtWzRSlcyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocM4cVdFdbm7qlVgKJ4xanx/Jx9Jj+wgvZ9nTaoAF7r0yu7z7tH4rAXOaEvJO5j1YFIPoFFGSDUMSCEFAp8ge/IwnJAaCOq0WpbatGcGY5fxqEdIhgRzz6YIpnfkS4Hin8IRmG3Lum0hQu7fjMvYvBM4rEhlaqueanagaGsODLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=V9hvGrps; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428141be2ddso12641945e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1723806983; x=1724411783; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dUl1HtKDQhN3EIbS7a4MMSHD3zQmh7SyIBtWzRSlcyg=;
        b=V9hvGrpsUhkuW84QQWWdXDVTKi9Fuoc1YdUB0+UJD9blWTj6ZXqDpxCk0ATET/sHsz
         8RSWHE/sflHogiACYIZHq1e+aOLg54ZEY05Ek+WbzAwMRxL32Cd+x5r+rSijuQuWJWX5
         CYhDs3wmtATSYXVk1UppsdHbo00GBXPmdAoVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806983; x=1724411783;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUl1HtKDQhN3EIbS7a4MMSHD3zQmh7SyIBtWzRSlcyg=;
        b=cChRqsGt6LcQCaXnXCT+lU3c4RaD0zFBNgFw71qN5FrycTAE8NpiaPOpatQtYLOSBG
         PVg+JM5ziAjfwKy6VjvrwYwv2xdWWCAwU+7Pz825tX+PvWRkKRtwfIESqba4EahbdsIA
         FVnswK9Q5Xd49gH33tkSQvnB6cHi1dySjAX+78J9Ya0yfPIddBjM9X2yCOs19Wg7nsAk
         B39+kmq6ja0JfCOsOCb4c+Mz2X2nn0uClBz8JCnRgAl2oVeShsTPqYRJm+2C00gkbdBA
         WqK8W4JO8KmumQWTj/NFS6xkinBBSFuL8qHE8Vaw+LwXR1ArlhDlWi3wZDsNl5tUBn7Y
         YJUA==
X-Forwarded-Encrypted: i=1; AJvYcCXei1QUD8oFIPbKmMmhM2yv2np2tA9sgYkgG9UwW71CgW2wxopRBSNbbayuxH9vJbOfABsUwzU74X9/1yLoiIOyuecO7rea9tQD09g=
X-Gm-Message-State: AOJu0Yy+puBLSRDGHEfSgmuho3oSj1Ibbwg590XmpBX8zYzlePjOxGIx
	7xIyT9ScZvRNF4uSoq51DJdCmrneL1khTxpuZVUng9MJiEYwotwNzsqFmkwm4vQ=
X-Google-Smtp-Source: AGHT+IFmKCzYTCM+3t4wnCLK96lkKAVIemH6mOEI6TJNtckUppFzJFnxeosm+5/WkgLETAoiAV2SHQ==
X-Received: by 2002:adf:b307:0:b0:368:4edc:611e with SMTP id ffacd0b85a97d-37194344041mr1665229f8f.14.1723806982640;
        Fri, 16 Aug 2024 04:16:22 -0700 (PDT)
Received: from able.exile.i.intelfx.name ([109.172.181.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189859d4esm3433562f8f.49.2024.08.16.04.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:16:22 -0700 (PDT)
Message-ID: <c876143d683d356a1c657455e295525f18e08895.camel@intelfx.name>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted
 increased execution time of the kswapd0 process and symptoms as if there is
 not enough memory
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Jannik =?ISO-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>, 
	andrea.gelmini@gmail.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mikhail.v.gavrilov@gmail.com, regressions@lists.linux.dev
Date: Fri, 16 Aug 2024 13:16:19 +0200
In-Reply-To: <CAL3q7H7-04s=j0fwGRx-TxGeP2-7ZeZ5Kdeo2fYdDFLE9ijupA@mail.gmail.com>
References: 
	<CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
	 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com>
	 <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
	 <3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name>
	 <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
	 <CAL3q7H7-04s=j0fwGRx-TxGeP2-7ZeZ5Kdeo2fYdDFLE9ijupA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-k+P2PspMaBe/8arJkmZN"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-k+P2PspMaBe/8arJkmZN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2024-08-16 at 11:58 +0100, Filipe Manana wrote:
> On Fri, Aug 16, 2024 at 12:17=E2=80=AFAM <intelfx@intelfx.name> wrote:
> >=20
> > On 2024-08-16 at 00:21 +0200, intelfx@intelfx.name wrote:
> > > On 2024-08-11 at 16:33 +0100, Filipe Manana wrote:
> > > > <...>
> > > > This came to my attention a couple days ago in a bugzilla report he=
re:
> > > >=20
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219121
> > > >=20
> > > > There's also 2 other recent threads in the mailing about it.
> > > >=20
> > > > There's a fix there in the bugzilla, and I've just sent it to the m=
ailing list.
> > > > In case you want to try it:
> > > >=20
> > > > https://lore.kernel.org/linux-btrfs/d85d72b968a1f7b8538c581eeb8f5ba=
a973dfc95.1723377230.git.fdmanana@suse.com/
> > > >=20
> > > > Thanks.
> > >=20
> > > Hello,
> > >=20
> > > I confirm that excessive "system" CPU usage by kswapd and btrfs-clean=
er
> > > kernel threads is still happening on the latest 6.10 stable with all
> > > quoted patches applied, making the system close to unusable (not to
> > > mention excessive power usage which crosses the line well *into*
> > > "unusable" for low-power systems such as laptops).
> > >=20
> > > With just 5 minutes of uptime on a freshly booted 6.10.5 system, the
> > > cumulative CPU time of kswapd is already at 2 minutes.
>=20
> Less than 24 hours before your message, there was a patch merged to
> Linus' tree, which was not (and is not) yet in any stable release
> (including 6.10.5 of course).
> Have you tried that patch?

Yes, I did =E2=80=94 as I said, I tried 6.10.5 with all combinations of pat=
ches
ever posted in this thread (skipping those that I was not able to
apply; it seems that there were a few mutually incompatible attempts to
improve the extent map shrinker, some of which have already gone into
the stable tree, thus making others inapplicable).

> > As a follow-up, after 1 hour of uptime of this system the total CPU
> > time of kswapd0 is exactly 30 minutes. So whatever is the theoretical
> > OOM issue that the extent map shrinker is trying to solve, the solution
>=20
> It's not a theoretical problem.
> It's a problem that any unprivileged user can trigger provided that
> the amount of available disk space is much higher than total RAM,
> which is by far the most common case.
>=20
> The problem is explained in the commit change log, there's a
> reproducer and it was even reported by a user:
>=20
> https://lore.kernel.org/linux-btrfs/13f94633dcf04d29aaf1f0a43d42c55e@amaz=
on.com/
>=20
> This link was included in the changelog of the patch when submitted to
> the list [1], but somehow it disappeared when it was merged to the git
> repository.
>=20
> Any user can effectively trigger a denial of service by creating an
> unlimited number of extent maps that never get removed while it keeps
> a file descriptor open and doing writes, either with direct IO, which
> is simpler, or even buffered IO in case it creates holes in the files
> (example: keep doing append writes starting after current eof, to
> create a bunch of holes). Even if that task doing that gets killed by
> the OOM, as long as there are idle processes keeping the file open,
> the problem doesn't go away.

Sorry, I did not intend to sound dismissive =E2=80=94 what I wanted to say =
was
that we fixed an edge case (and yes, I acknowledge that this edge case
could be a security problem) by instead pessimizing a common case.

--=20
Ivan Shapovalov / intelfx /

> [1] https://lore.kernel.org/linux-btrfs/1cb649870b6cad4411da7998735ab1141=
bb9f2f0.1712837044.git.fdmanana@suse.com/
>=20
> > in its current form is clearly unacceptable.
> >=20
> > Can we please have it reverted on the basis of this severe regression,
> > until a better solution is found?
>=20
> Disabling the shrinker might be the best for now. I'm on vacation and
> can't write and test code, but I do have plans for making it better
> and solving any remaining issues.
> There's already a patch for that from Qu.

--=-k+P2PspMaBe/8arJkmZN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAma/NQMVHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dHSAP/1BkpltZKUNJDVE7zomlJTj4FZkC
1hFVcsp+kzmxj7DlH4d7xYVfSqq9Vvkccvv6iB99Euj+GolBzI5b6JoY9LoCwxR/
JCT0o3PB6RcoP6DCjyEs5c3a/9D9HLvSTxBoE0y69ySaLIitngiIGP3Ja15UW0hH
Y3boIz9DLUvRpjPMSIk750u7uQSGI+0ryvVqIv70CWNwjjiTCsTYzDQ8dIqLHNrn
3y5B+zpqvwBOu7c1oIIurKq13f5HejV+SnIfzMxzqC3J9SCkBGHXOz2q6rrXFiQC
pxv1VG8nwFUai1JKrLDEB+dYju8PtQRVVbuX0/pHfhqmSzT4wKuJMOrLFomJ+82O
rJo/LOyG5AVea/Yp0jOLLFaW2AguywRRoP/H916eacu8erF5f/HtHFXUgFcEkGlN
KuqMxwtQw5phNpSgMBxMvtMd8XbzQZqrig3HTGZPBKsppnUYWFyMXO342aIaCZUf
NvkaQ0eALBHRfgLa+Qyy0pbN0GpEijZMJH6yRk57eRtw6om2UT0bhcsOV70bBT72
PkdewZ4h8Wu/oPUAukOY3HNhMwpiXzp8qe2YZrhiISkyxVo7P6jztaLXKGmbSDNP
XI947jo1QGHdVkOO8HWtwCygj6gj/v5SaLs5dmR46w4vO0RBbBnw0yLSVQq9qp0P
1PJj5UTecYEiwVfw
=EBDq
-----END PGP SIGNATURE-----

--=-k+P2PspMaBe/8arJkmZN--

