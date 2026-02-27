Return-Path: <linux-btrfs+bounces-22086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN6FN1cGomkGyQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22086-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 22:02:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 831571BE0B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 22:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4E58306CDB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7772445BD78;
	Fri, 27 Feb 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Zr3Lq7L9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1D2F12A5;
	Fri, 27 Feb 2026 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226132; cv=none; b=lpSIltchMjAgpkt/picn3IgnAVTKYk4fyiKKsZA0LlGcX3PaIGRaMQp4Jsk5WU/mzTYh0g4pVoYzSkpx2y+ZuTO+GEipW89kbEtuKr7WYZ7qDiC5+KS/Fd/y4KNJj9OsQzke6Lm83XEqLEJQXgwQW05XRm8ezI6NFSLVWJ1mnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226132; c=relaxed/simple;
	bh=6TFHdGVWg0uLwJ0Jhci+xoBkLJMhadiRw3rrc3PDbEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGrs0UOH8QbC/S5DPQCylfwf96B6Ms3iYn3tKbnQx25iGXj5cn8wutQb4L1G6L1y51QM6HwS6DN57exOISGJ09TJZvfyMBEiJMuFa2znPOa6+lK6pyscp/q71qKGwfStraFOm110lIT775L+9shby9BVA01qdGqYsoHKaPzihQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Zr3Lq7L9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772226125; x=1772830925; i=quwenruo.btrfs@gmx.com;
	bh=PCEwXoP6NfFnNldhk3xphM1jKC1plrA3qi7joyx89HE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zr3Lq7L9/FEG0sYRWEeG4unNdi3mwPEmZiEXVemc0Wj3IniGTr2oPSVo2MMgH7Bj
	 xoNxmK8n59DpHsoyTlTPdMMtO8NrfFzTv11dJkRixWg016o2tWDlYXjIxWF5LCh3Z
	 D0/tHxGSa/NJwAjDrgD5Cn783qZeQ502NppPVLTAGKPER+7o2BFwHWLketWixSXjX
	 q04Q2Qx83iX8hrSDgSbw9GkjDeI2do3UefQLgmTBN4fc3zVGelGFn3y0zsbvjYDWY
	 p810PWAPIMwRdG8fTPAU0Hjqz/2ANVq8jgPZ5fzRPISW2boFkOadcU8lhFS7qDYwt
	 E3/aDd9EQK/YXH3BKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ygt-1vy0mN2ESR-00HMuL; Fri, 27
 Feb 2026 22:02:05 +0100
Message-ID: <5cd8bfb3-8631-441e-a84a-70de675d2cfd@gmx.com>
Date: Sat, 28 Feb 2026 07:31:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: replace BUG() and BUG_ON() with error handling
To: Adarsh Das <adarshdas950@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: terrelln@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227183111.9311-1-adarshdas950@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20260227183111.9311-1-adarshdas950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gu2gMZXv3zWBnN/Nan57au8y1FpMiWlD64kuHk4pbRefAFu8ReA
 W7Tbrnf3r8XDhPJ5rfNusO+hnpexuVNpS9BnLuS4/EPHIPFHeDPAqleKIuVsf1FG14+7YpR
 UFUWCC6cUD/eujHJB2N0JTWlTRiBKmMHMY4MZwYWHInRo5gv0ydd9FNS19ZsNyQ2lQJ+etQ
 ZSXuG8eV4P2l6zh3+ZoFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Plbfd7Oe2go=;/FgAVk+7Xwhs9XhyV8rdNCK6V6f
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22086-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 831571BE0B9
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/28 05:01, Adarsh Das =E5=86=99=E9=81=93:
> Replace BUG() and BUG_ON() calls in compression.c and extent-tree.c
> with proper error handling so the kernel does not crash on unexpected
> conditions.

I think one needs to distinguish sanity checks and real proper error=20
handling.

I'd say, if some parameter/values are only generated from runtime code,=20
you're doing sanity checks, and it applies to most of your fixes.

In that case, ASSERT() is preferred, and should be checked as early as=20
possible (e.g. checks before adding something to a list/rbtree, other=20
than checking when handling the list/rbtree entry).

And if some developer hits that ASSERT() frequently enough, we can later=
=20
change it to a proper error handling later.



If something is read from the disk, it needs proper error handling, but=20
in that case it should be done in tree-checker, which provides a more=20
concentrated place to do such checks.

In the original location where there is a BUG_ON(), after making sure=20
it's already covered by tree-checker (or adding the missing check),=20
replacing the BUG_ON() with an ASSERT().


> Also fix checkpatch warnings and errors found in both files.

For such code style errors, fix them inside the real helpful patches=20
instead.

Thanks,
Qu

>=20
> Adarsh Das (4):
>    btrfs: replace BUG() with error handling in compression.c
>    btrfs: clean coding style errors and warnings in compression.c
>    btrfs: replace BUG() and BUG_ON() with error handling in extent-tree.=
c
>    btrfs: clean coding style errors in extent-tree.c
>=20
>   fs/btrfs/compression.c | 66 ++++++++++++-------------------
>   fs/btrfs/extent-tree.c | 89 +++++++++++++++++++++++++++++++-----------
>   2 files changed, 91 insertions(+), 64 deletions(-)
>=20


