Return-Path: <linux-btrfs+bounces-6352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6028692DEFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 05:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C7D284597
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 03:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB23D548;
	Thu, 11 Jul 2024 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="oDIO0cCM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4E39AC9
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 03:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670146; cv=none; b=FTzN4oYbPdofSwqlXc1EBmA+t92rjbc8VvPG9qTd+Ia2cwPvTvPfZHw1UOWGoAu37D7Nf0W0PYSjb4XiyZwKDxbbaa0Ms0wv2z21X1c5UvhWbLj5kh+sjyVjzM3Uy4r6ik3GfbY+w4Dz0EosuXQZvksSyhjeLWlRlRLTwIWBaX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670146; c=relaxed/simple;
	bh=REVAYpoyHEFs/ad8tKeP5JezMaq9JN64ndpAw8NtIe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9xmyef5CQq4Q3BPVuW9m0tZN5CmtN3mKEoYyvfHtz1qt0+jqGmUKH/9Q4cV7aa/BeNDs3lG1TS742G/zS273YW/aOo/FnlmdcQoW55f4SM1Yb+pstNKGJgjJOooMMOxjnLeH3g/hI/mw2/KnYAv0SafDQZDaedYJO6+oq3iXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=oDIO0cCM; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1720670142;
	bh=4Im922hg0H/di1vJcdM/n/GU5KGOUzHOPKwKAyuaAsI=; l=2113;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oDIO0cCMrGOHBQfZktW2Kp1UASKJX/IX3P12Dp4f8whYMDxwAq0IdOeWPot2rnddd
	 nEjeKDYMpFkss7FfIlCwBG9MTWfOnNqAPvp9Pz/hQAXM83CRzKtrw0o6h2k9F361P2
	 djs7za9vu4IvhOmCR0HJUp3wfhFP7JCKVO3DFr6g=
Received: from liv.coker.com.au (247.234.70.115.static.exetel.com.au [115.70.234.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id BCF7610ADC;
	Thu, 11 Jul 2024 13:55:41 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject:
 Re: btrfs-progs: btrfs dev usa as non-root is wrong and should just abort
Date: Thu, 11 Jul 2024 13:55:38 +1000
Message-ID: <7956171.lvqk35OSZv@cupcakke>
In-Reply-To: <ad3498e5-d41a-40ce-be73-c5d9de4f85a1@gmx.com>
References:
 <2159193.PIDvDuAF1L@cupcakke> <4914581.rnE6jSC6OK@cupcakke>
 <ad3498e5-d41a-40ce-be73-c5d9de4f85a1@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 11 July 2024 13:47:59 AEST Qu Wenruo wrote:
> > # btrfs dev usa -b /
> > /dev/mapper/root, ID: 1
> > 
> >     Device size:          511493395968
> 
> The device size is 4K aligned.
> 
> I guess it's some older fs? As newer mkfs would always round down to the
> sector size.

My recollection is that I had run mkfs on a system running Debian/Bookworm 
which had different hardware and then used dd to copy it to this one.

> >     Device slack:               1536
> >     Data,single:          231936622592
> >     Metadata,DUP:         6442450944
> >     System,DUP:             67108864
> >     Unallocated:          273047212032
> > 
> > $ btrfs dev usa -b /
> > WARNING: cannot read detailed chunk info, per-device usage will not be
> > shown, run as root
> > /dev/mapper/root, ID: 1
> > 
> >     Device size:           999010539
> >     Device slack:         18446743563215167723
> >     Unallocated:          511493394432
> >> 
> >> And what's the version of the btrfs-progs?
> > 
> > The Debian package version is 6.6.3-1.2+b1.
> 
> It may be easier to debug by trying a newer version of btrfs-progs.
> 
> And since I'm not sure if it's the unalignment causing problems, you may
> want to resize the fs by:
> 
> # btrfs device resize -1M <mnt>
> 
> Then resize to max (which should always align the fs correctly):
> 
> # btrfs device resize max <mnt>

root@cupcakke:/tmp# btrfs fi resize 1:-1M  /
Resize device id 1 (/dev/mapper/root) from 476.37GiB to 476.36GiB
root@cupcakke:/tmp# btrfs fi resize 1:max  /
Resize device id 1 (/dev/mapper/root) from 476.36GiB to max

etbe@cupcakke:/tmp$ btrfs dev usa -b /
WARNING: cannot read detailed chunk info, per-device usage will not be shown, 
run as root
/dev/mapper/root, ID: 1
   Device size:           999010539
   Device slack:         18446743563215167723
   Unallocated:          511493394432

etbe@cupcakke:/tmp$ btrfs dev usa /
WARNING: cannot read detailed chunk info, per-device usage will not be shown, 
run as root
/dev/mapper/root, ID: 1
   Device size:           952.73MiB
   Device slack:           16.00EiB
   Unallocated:           476.37GiB

That doesn't seem to have changed anything.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




