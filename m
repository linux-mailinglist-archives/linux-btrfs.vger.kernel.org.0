Return-Path: <linux-btrfs+bounces-21331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIuWGzlggmkzTQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21331-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 21:53:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD4DEA95
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 21:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B418302A6B8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 20:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED22FC871;
	Tue,  3 Feb 2026 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gNtj/QQm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C342F3C10
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770151983; cv=none; b=rcbRRFsf6w8j50qdEJFqfCDMp43oMP+g3blEiwKGy+N1QOVrxWgS66K4bHqgAnowNWpTLIPTkAAzQY56KDNNzIqViLi7O++DPJprP4NPm/qVCeNr2sLMAm86d6LU6NEvVcTNLVtA+5s4ADvNZcGM5RiasAQck25xJDXH4Rf3PSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770151983; c=relaxed/simple;
	bh=ugNZhouzJe2f4TogisUk91E9+IfB/ZPPH0v437D7xM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4Y1E/o99b2nsXBufX00Vh6uLrBfuI/LRTOoYfOKmGPkUAL0452iGEt3zhFT5IqxCE8SPob2JN0vcyx0C3G6BGGwf+MugX2516CVofbvVyEegW55ASEs1DqM5lld8jDAyuHi/vF28sFB98CXMGZJ/znPmQjRcfV6S//7hUGG2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gNtj/QQm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770151975; x=1770756775; i=quwenruo.btrfs@gmx.com;
	bh=g9lHWpI0mwwTPkJa7nJRd5hfTxbjsXfzu4gty32/1yQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gNtj/QQm3usC4qx1kUC0LRyJDPELhzWtTUI8D7q90kQTEN7ZJIBjDDTScJ1DDQIR
	 P5LG9iL+hgy9VwE6Iipu2JCzgg74YsF6q+qaJ63RssGWvvANO6SrVDiXsxKrttTW1
	 fpHCq5cpGyOwwwvu4jqJoWgYQtP63BdJ15F5Imi0Zt/lBIFWbP0YDzk2LHiDUrJ6m
	 y72Sso//7XCfIaNFPAAxFE2HPyylhWLs4fpXIdSu7il2yTweIWyyAcF5Wh0RlhXcX
	 9eyAMDbtsAJmdsJvVScUg5xq4x3y6Mws2xDjIfNOxrhPxUwmOfz3VF9yYdorZfse3
	 wH5eS9X/Id9JE9jm2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3DM-1w2law2QBs-005gvT; Tue, 03
 Feb 2026 21:52:55 +0100
Message-ID: <10c18271-d154-4314-b74d-a8b149eef0dd@gmx.com>
Date: Wed, 4 Feb 2026 07:22:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: introduce the device layout aware per-profile
 available space
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1770087101.git.wqu@suse.com>
 <eb573bac21a16092d8e9f64533c6b0d6ed6b16a4.1770087101.git.wqu@suse.com>
 <CAL3q7H6udGEXLxX_GWcSzD+T8hChfA5bPC5aYysqp9zOeuu3hA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6udGEXLxX_GWcSzD+T8hChfA5bPC5aYysqp9zOeuu3hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NTVV733V1bsoCfNEfX1vpSKlj+7iZ3zmuCGMQVTPLfpuwy/v0aF
 MbeHgFIz8I5dMYX1seizfHpINDkqKxd3m4sMzsiHvbJY9hkEjm0YxJmgJVBhTTKQUBcJbch
 SiPJj2l3jb/Asbj5Sq/0Z1Tp2IUqkT6wklTlVqExOmKtAWRn7fb5FDMZ+RUPjjZDOZ9kcLQ
 0vQ5xvGG5q0WDnLnkAvBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k2wxdzfysbA=;GEcdSHSNSoFbtPJafXDZGOzVpQq
 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
 ccMMKAxU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21331-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 03BD4DEA95
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/3 23:26, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Feb 3, 2026 at 3:01=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
[...]
>=20
>> +       list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_=
list)
>> +               device->per_profile_allocated =3D 0;
>> +
>> +       while (!alloc_virtual_chunk(fs_info, devices_info, type, &alloc=
ated))
>> +               result +=3D allocated;
>=20
> This can take some time, so:
>=20
> 1) Have a cond_resched() call here somewhere.
>=20
> 2) Compute only for the profiles we are using instead of all possible
> profiles - we can determine which ones are in use by oring
> fs_info->avail_data_alloc_bits, fs_info->avail_metadata_alloc_bits and
> fs_info->avail_system_alloc_bits.

In fact this will take almost no time.

Firstly all core functionality are just integer calculations, which are=20
very fast on modern hardware.
There is no tree search to grab the largest hole, unlike chunk allocator.

Secondly the allocation itself has no maximum size limit, thus even if=20
there are a lot of unallocated space on each device, it will only=20
handled in a huge chunk.


In my quick tests, the fs is small and dev-extent/chunk/bg tree are all=20
in cache, the runtime of btrfs_update_per_profile_avail() is pretty short.

For 2 disks, the runtime for all 9 profiles is around 2~5us,
meanwhile for 4 disks, the runtime is around 5~8us.

Do we still need to consider cond_sched() in this case?

Thanks,
Qu

