Return-Path: <linux-btrfs+bounces-10109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34449E804B
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 15:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E91883837
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F11474BF;
	Sat,  7 Dec 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b="XE96rnzT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-200160.simplelogin.co (mail-200160.simplelogin.co [176.119.200.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D880BFF
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Dec 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733582233; cv=pass; b=f0APR1G3+ATiR41it7D/z8uwVw1tzyYsyxsLfoVKFn5bHViuc0R5WpkrmhJWcNeR8G+OMG+U+/OW7uXvIRhXZspzvkVP7yMVZzEqBl7tXPumM6Sq7axh3U7hqmmqrrMk/ANB6duqIgSv0BbQu0pBZ3mMMLzKTqbsM4WcWsSrRcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733582233; c=relaxed/simple;
	bh=XLJIr9TE0d1isUEdg1SK9dFs1VRkAT4bOTd5iwuKEOY=;
	h=Date:Subject:In-Reply-To:MIME-Version:Content-Type:From:To:
	 Message-ID:References; b=XfP559Q8Go+bzVAqd3OgaqSdOZ2y8KBEZxehxKST70fUfwphjn37N5effHn30w/4tX5I8oPyxkMAHuvSjc22Ik8AH7aEn5atb8B0ManbC7ZhHfUQcUUi3RRI7esKMtoc+dCz89cxrtblFsuZv88r1q0PNMlytNgJUY7eG3u40+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me; spf=pass smtp.mailfrom=slmail.me; dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b=XE96rnzT; arc=pass smtp.client-ip=176.119.200.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=slmail.me
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1733581668;
	cv=none; b=QlNwPpoahaHyA7nvBa4oB1ur9PTFmdjZfIWtC7OujwtLAmoXW6QPT4LwouDNSsFjL2ykoHzX89wKJxDATkqlnG23KydWtJXjGSnFhjns6O3DQ3ECXsnv+Vsdl7hHIpYbk/usL3oFCKWEtScp5r49HVc6/DnFwaeojSh2aJCUHKaCzGnFdjNYq2FR877glRugvWrBwtuPXtzEJN3ZJZ+XF9QTN8Fy8MprRn4MhC8GNBzeWka/VOAuKHYGyS+VcI0lGhsC0XU9RCqVoI6tESD0tIaKUNYh/uZg9w7dojNKuJLZ1MQ0BCulchukVGF9lXbmoDbSjyr9LempZ216kBMwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1733581668; c=relaxed/simple;
	bh=XLJIr9TE0d1isUEdg1SK9dFs1VRkAT4bOTd5iwuKEOY=;
	h=Date:Subject:In-Reply-To:From:To:References; b=uHzGXnu9eurzDHrpn2F5Ax7zcHo69es36Bic62MkPoajJlwD7nx6kvV/6KpsvpVVqVqb65fOBSoHV6RvaGuQVLwOKOpDPCsz+H2KOlCVfOVbgGvOVSXfwaV28/NzAier6dMxxa1F9e2vP3E1h4P+bsAQbh7ZM8N7r9Jne/72E0Mipv27Gj/cjerNm9tm+fDUdYPpdAuZbTzzmCHFUqA1ymtZE+x42e8Zv4ID54xts9vCqDIGF1ZKDt8qEzBpTwWPfqZVaz+tW02e5UTpWm26chlRfO0MTEZGx7eRZ5Cn1RheEp0FdoBoAlcM+LAQg2zEYNtxUdFLzf99Ng6aMrlX6g==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slmail.me; s=dkim;
	t=1733581668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLJIr9TE0d1isUEdg1SK9dFs1VRkAT4bOTd5iwuKEOY=;
	b=XE96rnzT53a6Ma5tdT87PtzFiX62FJVdTeLAS8QouUcPjrOsofSYmNHPtNJC5VRoSsvBlV
	XhVEGQ/mjVO+VaJrBa+OP9D/acqe6R/SbqXJA1mlWrhlLy56oB3QgsV6tQpECTknTiP0ta
	NojusbseJpJbPZ4sBpJPQEbf3jsPLmA=
Date: Sat, 07 Dec 2024 14:27:40 +0000
Subject: Re: Balance failed with tree block error
In-Reply-To: <a78e6eab-88a6-4287-b5bc-ba5552cc8726@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aldo Gutierrez <btrfs.spry594@slmail.me>
To: linux-btrfs@vger.kernel.org
Message-ID: <173358166800.7.9767075912845312020.523411723@slmail.me>
References: <173323215268.7.6782695832944219711.518128798@slmail.me>
 <a78e6eab-88a6-4287-b5bc-ba5552cc8726@gmx.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 523411723
X-SimpleLogin-Want-Signing: yes

> The numbers look a little possible for bitflip:
> hex(15648439500800) =3D 0xe3b6fad8000
> hex(15648439517184) =3D 0xe3b6fadc000
>=20
> The same 0x8000 -> 0xc0000 just like Neil.

Isn't that suspicious? Why are the numbers so similar? Is it possible to fl=
ip the bit back?

> Did you ran full balance regularly before switching the kernel?
> If not, the corruption may already be there for some time, just the last
> balance chose to touch that block group and exposed the corruption.

I do a -dusage=3D50 a couple of times a month. This time I did 85.
Haven't run a full balance in ages as it takes a long time.=20

> Mind to run memtest first to make sure it's not some faulty hardware
> ruining the day?

I ran memtest 10 days ago and yesterday I ran memtester. 0 errors found.

> For your data, I believe most of them can be read out without problem,
> just write into the fs may trigger the fs to RO.
> Thus it's recommended to back up your data immediately. (After making
> sure your hardware memory is fine).

The issue happened 10 days ago and I have used the fs since
without any issues (have made copies). I had expected such an error to RO i=
mmediately.

Within a week or so before this error I had run clear-ino-cache and changed=
 to space-cache v2.

While going through the logs I found this happened about a month ago:
Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): block group 121571=
69172480 has wrong amount of free space
Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): failed to load fre=
e space cache for block group 12157169172480, rebuilding it now
Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): block group 121786=
44008960 has wrong amount of free space
Nov 09 14:11:37 P14 kernel: BTRFS warning (device sdb4): failed to load fre=
e space cache for block group 12178644008960, rebuilding it now



