Return-Path: <linux-btrfs+bounces-980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3A814DDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876571F21BAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A493F8CC;
	Fri, 15 Dec 2023 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="0QwGPTT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HFAqJOzK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421A43EA89
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgianit.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 1B4133200AD3;
	Fri, 15 Dec 2023 12:07:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Dec 2023 12:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1702660034;
	 x=1702746434; bh=+6lPpHAP+Hyj2ZQL9R3Ibes9y7w4RMkVoTJpwGogtaM=; b=
	0QwGPTT0v6sw7WQeGx9XqZoRCy7Up7dn82bSeufhZMvYtZrGsM5vf0Ixzgvf6PMH
	UNnFmzTOACHZSi7G5WzKdQJjyBEqPSUdMsF0OSeBcUTurr1kvv04ci+MtsM5wRpz
	TF2ACvlEF57Of2hU8is0zH2btbQkGV5DnleFk9WgNJ3bboBShlq8VWlKMTkjohi3
	Galq4FgdlFHJICFIRWLytVsRA5IQTscQZPtB0WAY7NZcNXzqDY4u3Ex95aWwcow5
	2FIx+ru3wMEq8nbSEsNpXbtZncy0G0h+DHf3CQ5HgWg/L1CsDxsRcU5mfzdWdCFZ
	+lQcN6zHSnDQBM57rbrCDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702660034; x=
	1702746434; bh=+6lPpHAP+Hyj2ZQL9R3Ibes9y7w4RMkVoTJpwGogtaM=; b=H
	FAqJOzKOWHt6Xsnj0QJgcIeIkf8NWO8Z5l8fDsJa5DJMrOX4Ld5h/YfwJ5QPFh9v
	jrrZQYU2kBfMaUqTla8Wzk0DXxtZ+djUeajy6KSsegBC0BVWhQge3FssSHRLMO/7
	7kMpii72/AHFayyv9vXdGHJ+HO4cxtfXv+AfmvewxaaDlsGPA5TMfg/D025KVH/d
	t64Ct3dO0oUuRlmoe2deaUBn0CWtlbalv6ITXP3IHZeGlMc3iiQQyJUAG/q9tJRN
	m6oNTzA8PsVtkK3VnsI9WEpzJyHWC+beiuV6osMGagd4cl+dhV3nHrQX8qo8rd4c
	pLswFJHxHErrXByA+b5lw==
X-ME-Sender: <xms:wod8ZYXymcNkpwKwcTX8L2RsNZk1907APzYLKyjajXUvCoAQyJtVmA>
    <xme:wod8ZcncAck_hRRPukprrqmNrOMMtVVPocE-mX0fRE1jeLnksNO-r0UXtLYRxFABV
    d9_KMZ59kla1dkDMA>
X-ME-Received: <xmr:wod8Zcbv0xDi_psUjsEMoHQSXKsYkt7zzBbUNp3huDqbyAF6g8YFbEhKXK0kUp3LIn99T_vUcy4bL1hgGv69ENI7YwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvfhfhuffkffgfgggjtgfgsehtqh
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhepvdffkefgudejieduvddvvedtve
    egiefhledvvdfghefhvefgleeiuddvtdduffffnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:wod8ZXVnFJdZMYTYd4SA2yK-MTg752Gb7nNwzm0tdFoc6SKFJMTihQ>
    <xmx:wod8ZSnvwrr6AqW7sZsAHqzVySOBMGFocTvhwnqTBz1yPFMJP-CmXA>
    <xmx:wod8ZcdGkTBJu4mOXd_lHy20iLTMfm8yoYeIgmYzeZa_rMXpSsQmDQ>
    <xmx:wod8ZZv_KJfkfesC8N9ondt3ejXkVdWt_YRMzo__q-J40M1fO7UhfA>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 12:07:13 -0500 (EST)
To: Grigori Efimovitch <etlp6@yandex.com>, linux-btrfs@vger.kernel.org
References: <2320801702653223@yjd3yivcrkgrkrlg.iva.yp-c.yandex.net>
From: Remi Gauvin <remi@georgianit.com>
Subject: Re: Can't mount clone of btrfs partition at the same time as the
 original.
Message-ID: <33af4105-4c34-7a34-cbe5-833ad95a4ce9@georgianit.com>
Date: Fri, 15 Dec 2023 12:07:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2320801702653223@yjd3yivcrkgrkrlg.iva.yp-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

First, I think there were safeguards added to kernel within the past few
years, but last time I checked, it was not safe, (as in, probably
immediately disastrous) to mount a btrfs filesystem while an exact clone
of the raw disk even existed.=C2=A0 I would suggest taking care that this=
 is
never the case.


On 2023-12-15 10:13 a.m., Grigori Efimovitch wrote:
> Hi,
> =20
> 1 - I do that all the time with ext4 to clone my boot partition:
> =20
> sudo mount /dev/sdb2 /mnt
> sudo rsync -aAXv --delete /boot/ /mnt
> sudo sync
> sudo umount /mnt
> =20
> 2 - System is standard bios boot Fedora 38 with sda2 as boot partition =
and sda3 as luks encrypted data/program partition.
> I usually clone it to external hard drive sdb by issuing sudo sh -c 'pv=
 < /dev/sda > dev/sdb && halt'.
> However it's a 500GB HD with only 50GB of data and it takes an hour.

I'm confused about the process here.=C2=A0 First, you copy files from you=
r
boot directory to a mount point on sdb.=C2=A0 Presumably, /boot resides o=
n
sda.=C2=A0 Then you make a raw copy of the entire sda disk to sdb?=C2=A0 =
(That
will completely overwrite anything you might have copied over in step 1.

But then, from your description, I have to ask, are you trying to copy
the raw disk image over while sda is still mounted and active?

> =20
>
> =20
> sudo rsync -aAXv --delete /mnt/source/root /mnt/dest/root
> sudo rsync -aAXv --delete /mnt/source/home /mnt/dest/home
> =20
> # Or use btrsync instead of rsync
> # sudo btrsync /mnt/source/root /mnt/dest/root=20
> # sudo btrsync /mnt/source/home /mnt/dest/home
> =20
>
> =20
> 5 - I cannot change the disk uuid because the external hard drive sdb i=
s the backup, has to be a clone and grub expects those very uuids to be b=
ootable.  Hence I tried to change the label to circumvent the mounting er=
ror but to no avail.


My suggestion would be to change the UUID of sdb3, manually fix the
/mnt/desk/root/boot/grub/grub.cfg file, then exclude that file from your
rsync.=C2=A0 (Alternatively, you can script a very simple search and repl=
ace
that will swap out the UUID inside that file to run at the end of your
backup rsync.)




