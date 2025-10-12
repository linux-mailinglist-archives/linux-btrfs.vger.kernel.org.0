Return-Path: <linux-btrfs+bounces-17646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F325BD0DC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 01:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B440C3B68E0
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD72EB5C6;
	Sun, 12 Oct 2025 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EopE74LR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB8231827
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760313390; cv=none; b=XELVhIAfNAa7B5ciFdGunR8iF6BOLiDoeWPZlNiWhLT6h2xwNEbOU786t0ZvYpUk/dL6mUUGk+a9DJBRCd44w0ls1dRn1UGD9ueJvJDnF3lZ7NDB6hzwZYqoZEsCTlFV7zcYpLG3fRiSOtTj/j0o457+/CXXelj7+RUfogY0wQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760313390; c=relaxed/simple;
	bh=k6V/1E7a/stk0pkU2xrSSPAIAcKJpuvJSkceq1NAg5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dms1Krf8WaEMzqT2dRw6q4A1ZRuDwFRU4fmFye58FY8JgFlnk04Yc/co36DTJEILmZyKkj12kloam+S/Lqa3uTMqtuOX4nOT3MF1KpIpJjevDxEvGAe9EcbD3weXJPntj9yeTG4n56WHZH5wJrpFZyPDJeKUlZIIc3Q8bAxquVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EopE74LR; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760313382; x=1760918182; i=quwenruo.btrfs@gmx.com;
	bh=k6V/1E7a/stk0pkU2xrSSPAIAcKJpuvJSkceq1NAg5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EopE74LRSzy94pKxNe9+14rxn+xte3ie9EafczjgRdR2tbYWulfhJVzAimH9VT5g
	 eNptwM1/eQ8iUvBGlj286YKbSlf8w2iBpAe1rdJXo1ILsGZuJsSta85QfFLvKLf3T
	 XpXSmdJT8B1crK+56MsMf+3hT21A1sfpWGKV3qdevrVxzCDg0eUBWylZHslscaxSd
	 VxvASiNsk9zaR7Hc7leKBRvmUwyHjxpOk6lb3pNFM/YxIXXJqkiWnLxPkaTaiNH8J
	 tj1/AIbpsR5YP1+eSSlwRvBq9H71LZDtjsUDj+Z3VB0PEA3Stu/coJd00UD3Zq/Dw
	 RtdEoh41HxiQ3HWqHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvK4Z-1uHdxc3QUj-00vnFm; Mon, 13
 Oct 2025 01:56:22 +0200
Message-ID: <bb658f9d-510a-4265-944e-88b2ba83d134@gmx.com>
Date: Mon, 13 Oct 2025 10:26:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: Askar Safin <safinaskar@gmail.com>, wqu@suse.com
Cc: linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
 David Sterba <dsterba@suse.com>
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
 <20251012082355.5226-1-safinaskar@gmail.com>
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
In-Reply-To: <20251012082355.5226-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mxawc9TQkOw34wDQ+rSK+k4+013FRbjcEUFk6xrN0E9iFMelB60
 zdMEVUwv+4UCnC+yANG8Z6xWC/OLTsA9CrVGcv2KCDh3JzIV3MR1qkGOie3mJ+OEDGeK+Wb
 XSy+IJu4fwrRV2RJCkiyyF/lzO+wfHSbQ2g2LTso1WTxonz87tsQjvxYyiAqxSGuVCjr/dP
 d06OFqjaQEynugzQWZaMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:50IPv/drETg=;lijmuKHUuTVmujJQU7yJxq3P9d0
 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



=E5=9C=A8 2025/10/12 18:53, Askar Safin =E5=86=99=E9=81=93:
> Qu Wenruo <wqu@suse.com>:
>> There are some reports that btrfs is unable to be frozen if there is a
>=20
> I tested your patch on real hardware.
>=20
> I applied it to current Linux mainline.
>=20
> I have btrfs-raid on two big disks.
>=20
> I started "sudo btrfs scrub start -B -d /" and pressed "Suspend" in GUI.
>=20
> If /sys/power/freeze_filesystems is 0 (this is default), then your patch=
 doesn't work.
>=20
> If /sys/power/freeze_filesystems is 1, then the system stops to respond =
for a minute
> and then suspends. Here is journalctl:
> https://zerobin.net/?e3376d7d056dcb04#LyzGFYeVdWsbZfgC25G4TuSct6QDyZ278g=
QlZgCfR94=3D .
>=20
> As well as I understand from journalctl, systemd tries to freeze userspa=
ce
> process "btrfs scrub" and fails. Then systemd times out after a minute,
> and then suspend proceeds.
>=20
> So, in short, this is not complete solution yet.
>=20
> Also I tested Sterba's patch, and it doesn't work either:
> https://lore.kernel.org/linux-btrfs/20250720194803.3661-1-safinaskar@zoh=
omail.com/ .
>=20
> I really want this bug to be fixed. Please, CC me with your future attem=
pts.

I'll send you new experimental patch(es) first for test.

In fact I already have some idea how to address it, but unfortunately it=
=20
may take some time.

And it will address scrub first, then addressing balance related operation=
s.

Thanks,
Qu
>=20


