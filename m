Return-Path: <linux-btrfs+bounces-6348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1092DEDB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 05:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F0BB212F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 03:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6AD199BC;
	Thu, 11 Jul 2024 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="B5CujZsM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5210A0C
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669331; cv=none; b=kfvl6F4uFJoSB3fpsXVPIsEw64qLj7LZV/DMAsNVcyPbc5XsOaZNtsXJKBp0XT0WTKT+GI+34ZpAuz+9iudT6fKdPUWr/J/lmZ+fWAkt/bk69ABwWtv0VcioNMUa0MwEA07hEmRrZ2MoRaaFu02PVi30D2jlpCrtD8ypGA8Bbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669331; c=relaxed/simple;
	bh=tiZ+hX0SBP9jEmWJ5vaElKX6CVJs9Yk1q4ro+F60f5M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shU9vShnBRpgcF1BNlh0gW97A6F5/xfxd/mQBZv1TFixz2KwClqfSqaZN7+4Y0QI6527fgt1c/ByWxf4RucHggYjIcPBuvYdVgnMuU90vbY5P8dkEJepMiMzeAcm1OczhDKnSkH7dlsOFRR1JHD84+Pl1w6WgtqBFd2AmF1nA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=B5CujZsM; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1720669326;
	bh=rZJc+TCjxaTpvvfSYsKTbnZn91XIacIo8eA1Thmx5l4=; l=1975;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B5CujZsMgflcFMUa43rI4rtQLLncsZNbC3QhEsRLvO60r+p0Lrb1ghH9Pm/kA256r
	 b9K1dpxpzuP9S9KcXuhtX3HLCivghBAipyk2p5LagvNWsq0dPaiPBzQi8VQ/tIvUeu
	 Qm5aGxyKxoLJZTaBwGC71CrGGdZraAfF+NaE/apI=
Received: from liv.coker.com.au (247.234.70.115.static.exetel.com.au [115.70.234.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id B38FFF315;
	Thu, 11 Jul 2024 13:42:05 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject:
 Re: btrfs-progs: btrfs dev usa as non-root is wrong and should just abort
Date: Thu, 11 Jul 2024 13:42:02 +1000
Message-ID: <4914581.rnE6jSC6OK@cupcakke>
In-Reply-To: <96677547-0177-4226-92bd-174c167269b3@gmx.com>
References:
 <2159193.PIDvDuAF1L@cupcakke> <96677547-0177-4226-92bd-174c167269b3@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, 11 July 2024 07:13:25 AEST Qu Wenruo wrote:
> =E5=9C=A8 2024/7/10 21:22, Russell Coker =E5=86=99=E9=81=93:
> > Below is the difference between running btrfs dev usa as root and non-r=
oot
> > on a laptop with kernel 6.8.12-amd64.  When run as non-root it gets
> > everything wrong and in my tests I have never been able to see it give
> > nay accurate data as non-root.  I think it should just abort with an
> > error in that situation, there's no point in giving a wrong answer.
> >=20
> > # btrfs dev usa /
> > /dev/mapper/root, ID: 1
> >=20
> >     Device size:           476.37GiB
> >     Device slack:            1.50KiB
> >     Data,single:           216.01GiB
> >     Metadata,DUP:            6.00GiB
> >     System,DUP:             64.00MiB
> >     Unallocated:           254.29GiB
> >=20
> > $ btrfs dev usa /
> > WARNING: cannot read detailed chunk info, per-device usage will not be
> > shown, run as root
> > /dev/mapper/root, ID: 1
> >=20
> >     Device size:           952.73MiB
> >     Device slack:           16.00EiB
> >     Unallocated:           476.37GiB
>=20
> Mind to post the raw result?
>=20
> The 16EiB output definitely means something wrong.
>=20
> So far the result looks like btrfs-progs is interpret the result wrong
> with some offset of the result.
>=20
> In my case, non-root call of "btrfs dev usage" always shows the slack as
> 0, and unallocated as N/A, so the 16EiB looks like some shift.

# btrfs dev usa -b /
/dev/mapper/root, ID: 1
   Device size:          511493395968
   Device slack:               1536
   Data,single:          231936622592
   Metadata,DUP:         6442450944
   System,DUP:             67108864
   Unallocated:          273047212032

$ btrfs dev usa -b /
WARNING: cannot read detailed chunk info, per-device usage will not be show=
n,=20
run as root
/dev/mapper/root, ID: 1
   Device size:           999010539
   Device slack:         18446743563215167723
   Unallocated:          511493394432

> And what's the version of the btrfs-progs?

The Debian package version is 6.6.3-1.2+b1.

=2D-=20
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




