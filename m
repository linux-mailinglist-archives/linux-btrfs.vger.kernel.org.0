Return-Path: <linux-btrfs+bounces-20869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKSIKv1AcWn2fgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20869-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:11:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E17C5DD94
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6ECFB2AF5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858244266BD;
	Wed, 21 Jan 2026 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rWIY6AEP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37613425CF2
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029508; cv=none; b=PzxaVjyrrQSqGspnml2P6R+l51u4dM+pHT7qW4Q+pbeKWGz2AfTexKfKT6h+O2HNpb/F0IDCVe54ZUxE4cM/14aIUNESKDGKL+AJ5kBizqbwSWtO871HbSr589dRr3BhKzDG6aer2usSjkS5v74XOYQuYP+MkOA+j+MDChbFaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029508; c=relaxed/simple;
	bh=NKQnZqcEyXGVs/ZARG4GacTnuuRyM18GLeVJKlMbrkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nym4YgDpIJphchVIm+HSxalE0KmD4WMsYNMLV8GdFxzTbRO8gsXqxpXgK+rM3SyxW7WTW1RfgiUQgXIjG/XOvwKYlycTS3zHZeRFzByfJsQ9XJK85hHGd3WsKgnQUQ32QO78tvdMDtwX0HTnEW+mzSbUd/cFxmkmkcyrEJ1Coq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rWIY6AEP; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769029497; x=1769634297; i=quwenruo.btrfs@gmx.com;
	bh=RRNn//Bo0OCqh2yF8G1EncdRgn2zSzH9RYabnxxd+Vk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rWIY6AEPsSv0SGPxlIYVw/BoY7mJNuFGqDrLkxDsMrDn6giwulLBSPImy5oPRLgG
	 7Rqa6ubUglEl/71zbOGDcn0WePiELduCEL6ssLImGpsI4ZkWaVBHvbgmAoYxI+/iH
	 DKHaS9+6vLKrGNd6jcXB8dKXPyQajX6j8HZydwpx9OCmKS33pgi2yrkljI/+TrQKq
	 yXJScQKKOPzTDN0n8KuXDm4jA4sycvAh/1ctnTq3IjeMzrbLdzEpTEfPMcogiOTZ3
	 H+UVWYNwHdiTRmIVWAUvtivkU37TjgUwut1Gx3U+ZkKlGrUJhoC36TGJxvA7UvsST
	 HvEYDrihkAXQp9FwMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulmF-1w0kAN3MId-00wB30; Wed, 21
 Jan 2026 22:04:57 +0100
Message-ID: <452070b2-ba54-4136-b45a-fe385cb5a73c@gmx.com>
Date: Thu, 22 Jan 2026 07:34:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: tests: remove invalid file extent map tests
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1768714131.git.wqu@suse.com>
 <86b8394ca75b3e8ac35b08e8ee8b4617d5f44331.1768714131.git.wqu@suse.com>
 <CAL3q7H6dBONyBSO08RjH_K3fWHOLFwQ7aRQrGMUTh9xebn_eZw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6dBONyBSO08RjH_K3fWHOLFwQ7aRQrGMUTh9xebn_eZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SJQCbRZDHwHqibQ+7ovclfNW7ddB6ATLXBlD6yVQDjziyHGAgjw
 DbeTu9zD+GFiuCOAmBX9MD7T0V1hEZCxopOteELNu0kIpP5Qike45HI8TrGc2c1ClqlPrfp
 d6O/x3I33DDzIBd7P1a2gBwV1V2rtEWFjMmOLRGGPVjI/U9MOwjdL0ie3AxQrFGC1J+mjCE
 nbhzAK3fK2zUHCsKZEAyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uwYi5a8brW4=;H1L9EDAGGHVRnXbv/yV2vdReg6x
 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
 k1bS3ij9/lSP8NPW7gk/AC0wsmK9QGrraBI3LZ
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20869-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmx.com,quarantine];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 2E17C5DD94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



=E5=9C=A8 2026/1/22 03:39, Filipe Manana =E5=86=99=E9=81=93:
> On Sun, Jan 18, 2026 at 5:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> In the inode self tests, there are several problems:
>>
>> - Several invalid cases that will be rejected by tree-checkers
>=20
> by tree-checkers -> by the tree-checker
>=20
> Also missing punctuation at the end of the sentence, and this is a
> pattern in every first sentence below too.

It's an item of a list, not a full sentence.

Remove the "that" part, the item is just "Several invalid cases", why=20
you want to put a punctuation for something that is not a full sentence?

For a lot cases, we just want to express some short values/items without=
=20
a full sentence, and there is no subject-verb-object at all.
Thus I don't think we want to put a punctuation for everything.

[...]
>>    */
>>   static void setup_file_extents(struct btrfs_root *root, u32 sectorsiz=
e)
>>   {
>> @@ -100,40 +103,49 @@ static void setup_file_extents(struct btrfs_root =
*root, u32 sectorsize)
>>          u64 offset =3D 0;
>>
>>          /*
>> +        * Start 0, length 6, inlined.
>> +        *
>>           * Tree-checker has strict limits on inline extents that they =
can only
>>           * exist at file offset 0, thus we can only have one inline fi=
le extent
>>           * at most.
>>           */
>> +       ASSERT(offset =3D=3D 0);
>=20
> Err, what's the point? We have just assigned 0 to offset right above.

Already explained in the commit message:

- Super hard to modify sequence in setup_file_extents()
   If some unfortunate person, just like me, needs to modify
   setup_file_extents(), good luck not screwing up the file offset.

If one has to add/remove some file extent items just like this patch,=20
@offset will be changed and good luck counting it manually.

The ASSERT() is an explicit way to tell what's the current offset.

>=20
>>          insert_extent(root, offset, 6, 6, 0, 0, 0, BTRFS_FILE_EXTENT_I=
NLINE, 0,
>>                        slot);
>>          slot++;
>>          offset =3D sectorsize;
>>
>> -       /* Now another hole */
>> -       insert_extent(root, offset, 4, 4, 0, 0, 0, BTRFS_FILE_EXTENT_RE=
G, 0,
>> -                     slot);
>> +       /* Start 1 * blocksize, length 1 * blocksize, regular */
>=20
> End sentence with punctuation (done in most other comments below).
>=20
>> +       ASSERT(offset =3D=3D 1 * sectorsize);
>=20
> Same here, we just assigned sectorsize to offset right above.

The same as explained.

It's easy to grab the offset for the first one or two items, then please=
=20
tell me the offset in a quick glance for the last few items.

Thanks,
Qu


