Return-Path: <linux-btrfs+bounces-17637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D3EBCF51B
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Oct 2025 14:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F1EE34C020
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Oct 2025 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1952773EF;
	Sat, 11 Oct 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JvFdu9kc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE63225F7A5
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Oct 2025 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760185235; cv=none; b=d3eiRXzO2TjLgUYFU8k7pRbc/OJx0lE/TgLMS8yOU8zvbcT8YMqpHAJpikc0q5BlY5oTZt2srhDdxh+Lbrghxw98Dog06wc88wLzsA1O+4tEpX85tOsbnBoLgo41sowYMbSnPlppVXoz8MxNDf/nKeWD/lc48ZykP2xD9b8Jk6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760185235; c=relaxed/simple;
	bh=HWetXrRsW6cjbcvii/yxP6dmBiR1DRFs484sS+Y24XY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LhTBEqqM8x6EQJcKrv5qsp54Lr0FWMvyqvoaJ66oAjFH9StbrIS4GUpiTO02umXY+BivTT5FS0rUBDeiJ7TJLCMlm/3I3g264Z1RRLRwSFiMpMG1P/aW2Wb1r5s1hwhnQ4hGnTTJ5gkL2er6yp2zYzwacfUFK1e8Bn6vp+OggUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JvFdu9kc; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ckN3s6Zd3z9tWV;
	Sat, 11 Oct 2025 14:20:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760185225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9nGlYKaJ1bDbpYkjRnRW4lgfVoyIlAmE6GNeiShdq0=;
	b=JvFdu9kcekVjzKajrHd6yCSHFoXxLvqXOPkg2fKlWeOiiXG7ihT6O6xZuR1/MP92UH/u5K
	MsvK/2QhCiNHNVsICFVaXYxwARoPIl3lvYnrLhT6dFtjnv72pTgPukPoV4OOuQ7m4TJN07
	Mh26/In5XVUWc6QMZPSNph98wuL8Z1PgK+9Ou3tn3hrxcfZffigxmZt3ALmMgnkWUpPgec
	MmXosKTDP4f+Gk56ONHEshXEY2KQBKKEwFQDxCjCj2V10nvKSKoP4XSqMFjyRHszet7JnA
	3JAHd1zu71jy0ieT5qSUG5m338SQ9PrxoloMvjAwgVSRo5IykE1BVjIfcNC/Vw==
Date: Sat, 11 Oct 2025 14:20:22 +0200
From: =?ISO-8859-1?Q?Ra=FAl_S=E1nchez_Siles?= <rasasi78@mailbox.org>
To: Qu Wenruo <wqu@suse.com>
CC: linux-btrfs@vger.kernel.org
Subject: Re: Trying to tackle https://github.com/kdave/btrfs-progs/issues/541
In-Reply-To: <ebeebd7b-4075-4b30-b40f-ff8f218b52cd@suse.com>
References: <2800637.mvXUDI8C0e@prox> <ebeebd7b-4075-4b30-b40f-ff8f218b52cd@suse.com>
Message-ID: <EC0337DC-5C31-4475-BC81-0AF302A7DC20@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: d8b15929189a727a3d2
X-MBO-RS-META: si5xwsg9jrjj4iqn7yqsspnmjd33rakb

Hi!

Thanks for the reply=2E

El 10 de octubre de 2025 22:47:15 CEST, Qu Wenruo <wqu@suse=2Ecom> escribi=
=C3=B3:
>
>
>=E5=9C=A8 2025/10/10 19:25, Ra=C3=BAl S=C3=A1nchez Siles =E5=86=99=E9=81=
=93:
[=2E=2E=2E]
>>=20
>> Currently I have a reproducible scenario to look into the issue and pro=
vided
>> lack of activity in the issue I thought I may be of help to provide mor=
e
>> information so issue can be fixed=2E The btrfs consistency issue looks =
serious
>> so even in case of successful debugging I don't expect to recover acces=
s to
>> that partition=2E
>>=20
[=2E=2E=2E]
>>=20
>> Mount error:
>> [  120=2E652356] BTRFS: device fsid 06dc5f24-a16f-4520-993a-xxxxxxxxxxx=
x devid
>> 1 transid 968758 /dev/sda3 (8:3) scanned by pool-2 (4449)
>> [  120=2E653973] BTRFS info (device sda3): first mount of filesystem 06=
dc5f24-
>> a16f-4520-993a-xxxxxxxxxxxx
>> [  120=2E653994] BTRFS info (device sda3): using crc32c (crc32c-x86) ch=
ecksum
>> algorithm
>> [  123=2E225415] BTRFS info (device sda3): start tree-log replay
>> [  123=2E523786] BTRFS error (device sda3): parent transid verify faile=
d on
>> logical 229603573760 mirror 1 wanted 968173 found 966625
>> [  123=2E538334] BTRFS error (device sda3): parent transid verify faile=
d on
>> logical 229603573760 mirror 2 wanted 968173 found 966625
>
>Extent tree corruption, metadata COW is broken=2E
>
>It looks like some writes are lost=2E Btrfs check should report the same =
problem=2E
>

It is right that btrfs check gave the same report (I forgot to mention it)

>It is not log tree causing the bug=2E
>
>I'd recommend posting the device model and check if there is any known re=
port with transid mismatch=2E
>

The HD model is Toshiba DTB420 2TB=2E Is there a specific place to look fo=
r transid mismatch reports or do you mean just a generic search?

>Sometimes you can not really just trust their firmwares=2E
>

I have been using this drive for at least a couple of years=2E There has b=
een several power outages, but none of them lead to a such serious trouble=
=2E Actually I think when the FS stalled, the power supply was OK=2E

>Thanks,
>Qu
>

So still, let me know if I can be of help debugging/managing this kind of =
scenarios=2E

Best Regards,

