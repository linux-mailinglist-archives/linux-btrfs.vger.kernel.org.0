Return-Path: <linux-btrfs+bounces-4014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5274489B5C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 04:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D281CB21365
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 02:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A717C2;
	Mon,  8 Apr 2024 02:00:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831610E9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541656; cv=pass; b=ts9+Jo65GfuDxw7B7MOHn/GlMO0JV1BHggqkPv5CRWeblNvRvS0gO4yC1RXbujEwgPvK4+cY7JQ0t89qVZkEqsV/wXVwCeanxW49KmzbsWIT5UKOXmMIpoHy5IL5UHH+E7f7XW+zCwnpnnRWiIIIp8BZttHwRapiArJ1v7lYKy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541656; c=relaxed/simple;
	bh=bONSnSPHFUm4+sX9QC1b7amGedaBpKMxisn9BaOafzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eb12qRr2bZcGBahWoMlF9TGbhc3VfmfzMzPxxnmTQe6Xm2c0JkVwqGgTe2H+SlWQtwklfLDlNCcHDntqMOGRA4Vx//mPDdCK0KL25VcrRZEUbtQZXlOSquRp5tVNfOqOE9zw2iYmYoM3R0Jg7ZHgC9eqMsG16YTMykXWEficFSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 258007A2BF2;
	Mon,  8 Apr 2024 02:00:46 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 348F57A2B8A;
	Mon,  8 Apr 2024 02:00:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1712541645; a=rsa-sha256;
	cv=none;
	b=5ID7TGNG3SFsx7qlLppDcF2GMDZkehlgkk38i6pPKo4mutm/fNvZstK/hPLiEL2xCB3KBT
	as3GFGABZ+cvk3xJBT/1gTlTwvEUpvwUpy5Ov20VYkHPLKvMjcPpOn17NN7oW8jzYPFKfp
	DR40KpciRBYRM4syLhqoKpAejyxAknoYoBmgC395J1sAC0xm+HxVJylxAAiyUvaYMPNcXu
	OdlBZ0KII9ERRLZeo+2B5GxDkIt1NYhzdPiQKISu03knubl5ljOjjlq0U8jxLEbrn9oESl
	TY6pZQOflToo6Au16vuN2t0+ae1Psdt0FEKRlCyQeyFIqX5V7nGB5Tlmmr1WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1712541645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0x0GKomZhaYYttMi3qgXyVkqnZvY7ev1B/zurqRTkrE=;
	b=jPHG7ZQhhEqv93KOMs6Cpa7wp2Te6Gbll/EzZNXUfeHZf9rQOPPtk3IL12qnYps3ZRQ19k
	yRj8/dOqLnaAQRw+4QBe0P9Q+PeqgDHOnOf8lvu/JSoc8Yvn7/qFatli8JSygxJVLtedwq
	8ofDXJf8r4fPyYcx9Sxh7iUCEr7DCRQgqQNsDlbVZmFH6RqxYbY6hAMKaHSUDEHP/Bra3R
	PqWpYHr8RZqxd1mamKlW+XEbEOKlsM4eCBiQxps8EkUEi24yUvD6Y4ZoehNyBNWRbJa2V5
	JYMfhXmgDirVFuL61RUl3O92Fv/GbjyDCv6GHVEkbQThBHKlMdUZdD+r0DOjDA==
ARC-Authentication-Results: i=1;
	rspamd-687b9dd446-xkpsv;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Squirrel-Stupid: 7164503138b4cf31_1712541645854_3253637536
X-MC-Loop-Signature: 1712541645854:1009842038
X-MC-Ingress-Time: 1712541645854
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.102.214.137 (trex/6.9.2);
	Mon, 08 Apr 2024 02:00:45 +0000
Received: from p5090f899.dip0.t-ipconnect.de ([80.144.248.153]:45000 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rteJL-0007cV-2E;
	Mon, 08 Apr 2024 02:00:43 +0000
Message-ID: <1c043fdf6f4cb771fb38f45615263f660656cfc4.camel@scientia.org>
Subject: Re: exactly shrinking btrfs on a device?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Roman Mamedov <rm@romanrm.net>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date: Mon, 08 Apr 2024 04:00:38 +0200
In-Reply-To: <20240407192913.0682fa4d@nvm>
References: <896a5d36071a30605c38779dd03103b6429ebcae.camel@scientia.org>
	 <20240406033700.2c2404c1@nvm>
	 <0c9f96442083fe6e5ad387adbc496ff2f3370270.camel@scientia.org>
	 <bba42153-f4d9-4fb6-8252-a5cd1929b901@gmail.com>
	 <d7c9378abccd7a7c243fc10938c6ba1ba48db232.camel@scientia.org>
	 <20240407192913.0682fa4d@nvm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Sun, 2024-04-07 at 19:29 +0500, Roman Mamedov wrote:
> Try "btrfs fi show /mnt/point/ --raw". It will show the device size
> in
> bytes, as used by Btrfs.=20
>=20
> ...
> 	devid=C2=A0=C2=A0=C2=A0 1 size 503251058688 used 400023945216 path
> /dev/sda3
> ...
>=20
> # blockdev --getsize64 /dev/sda3
> 503251060736
>=20
> This seems to be the number you're looking for.

Thanks for the hint. I think it's the same as what I already had seen
from dump-super.

I've submitted https://github.com/kdave/btrfs-progs/pull/775 cause I
think that should go into the documentation.

Thanks,
Chris.

