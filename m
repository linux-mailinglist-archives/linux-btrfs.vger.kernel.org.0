Return-Path: <linux-btrfs+bounces-20386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC7D103B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 02:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588393027A43
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 01:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3802139CE;
	Mon, 12 Jan 2026 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EsNiNXRM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92142A96
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768180201; cv=none; b=RDfueLKpIuKMPpr/3qNQyhJf3xBjrOfCStCtkfnwJC/zWvupZOOVgyLwnu72C9EhgpjyVqhjf4bft54h9JDiXXCgBfij0KF4HAySEltofZZde3braqhx03Rm8El4a+rgkcVaysY+267lsUv/aLBFe39Fz42/zN8rtLykqbAHpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768180201; c=relaxed/simple;
	bh=hO7CLzS1wret1KOm483nTxc1YUbModlpO2pvN8pRDmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JaiZwTqe1+VgiZuHv2I4LvkKt5teNUn2WZP3DDpJCCCgU9mZDdZA1jMPGJoGhZD+7b0/zMRtYT+BVTIt8yvG2BA/A+uNbadtk7KR8/jcjjH9wF/VV/UHy8l11C6tQakFbv88NgY6vTuVmjZek8EJtganWrxoCa5M1ksbVCKYh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EsNiNXRM; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768180197; x=1768784997; i=quwenruo.btrfs@gmx.com;
	bh=JvKO8V8Mzmvmo9vU6RwdxIITG3Bt5tV7kHkBusSSBWU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EsNiNXRMfJA360Irhgsa6v9ClsCqx2Crj0ffg7BeuPVUbtBw2v0KuXHZYrHKJeCs
	 mCTqXCpCF06YekCazXp3bRJbeR2Js0An2XVh/vDV4EoSZnxB64cfXGWXRFfqqtwCo
	 xa2cy6tbNSTUUskXDeLtFUEj0ilKeXTk7GXFZbsUGZAXAJk1XmWdbzbYxrsxw/vII
	 Hzfsx4hwNXrpw2uU2hbcGBL6nq2ONRREigKTssybVdPjgPpljhoKrmy0UxHfyobXL
	 kDO9WxrKeLhn6elCubhDJoDTY7Az+NpX0Y69RJ4uLIt/hO264sYti82XOr1Kdueyd
	 EQ43kh0oOb5/zlDdsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZktZ-1vIoj54ApL-00Qaut; Mon, 12
 Jan 2026 02:09:57 +0100
Message-ID: <f6bb03fa-ed85-41ff-b8d9-f89013469e3a@gmx.com>
Date: Mon, 12 Jan 2026 11:39:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] btrfs-progs 6.17.1: btrfs check --repair aborts with ASSERT
 in delete_duplicate_records() due to overlapping metadata extent
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CABXGCsN7SjNjnn9BRPXr6OK_aZUxs89RVWyX5HFi=S+Ri3tadA@mail.gmail.com>
 <CABXGCsP1dXnutvM9pUNyZavJTTRpEeJsVNzzyVJqbVasz0=dXg@mail.gmail.com>
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
In-Reply-To: <CABXGCsP1dXnutvM9pUNyZavJTTRpEeJsVNzzyVJqbVasz0=dXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oOfZlEJAO+vXhhaGABcXAzDmXrjAEcIUJw6iHKvHLZArUGVMeqa
 9eo0dGgxZrSLcsAwp/qSFsQGtAcH8SDLA4309vQuULuPMqZxLxc2okHs7ePSjiAigSOb+Hy
 AnHMlUhnb6dzsE+NsoWklyB0p4/iLalIUzWmqC+UtFgt6ijnwbvEXuMBv2WMRLCKuCac+5s
 CAiq4fijzQ4nuADgpt6KA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m/uT12ZR4YA=;P+/uczKWQm0hx4BpHRry/cMj0a5
 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



=E5=9C=A8 2026/1/12 10:52, Mikhail Gavrilov =E5=86=99=E9=81=93:
> On Tue, Nov 25, 2025 at 2:15=E2=80=AFAM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> Hello,
>>
>> btrfs check --repair crashes 100% reproducibly with:
>> well this shouldn't happen, extent record overlaps but is metadata?
>> [17101544210432, 16384]
>>
>> The crash is triggered by the ASSERT in delete_duplicate_records() at
>> check/main.c:7583:
>> ASSERT(!extent_record_is_metadata(rec) || !found_overlap);
>>
>> Backtrace attached as backtrace.txt
>> Full output of "btrfs check --readonly" attached as readonly.log
>>
>> Environment
>> -----------
>> btrfs-progs-6.17.1-1.fc44.x86_64
>> Filesystem was unmounted
>>
>> Image
>> -----
>> http://213.136.82.171/dumps/sda.btrfs-image
>> Size: 5.4 GB
>> SHA256: cebc3493672d166726c8e05c2492882492cbc9a957be5d1c056dd47b76eaaba=
9
>>   sda.btrfs-image
>>
>> Superblock + btrfs fi show attached as superblock.txt
>>
>> Key symptoms
>> ------------
>> - thousands of transid verification failures (wanted 213059, found 2130=
19)

This is already a very critical error.

Normally I won't recommend to do any write operation (including repair)=20
on it already.

>> - hundreds of duplicate extent backrefs in the 17101544xxxxx range
>> - multiple inodes in root 5 report "some csum missing"

If that's the only problem reported from the subvolume trees, at least=20
you can grab most (if not all) of your data by a "ro,rescue=3Dall" mount.

>> - extent tree contains conflicting metadata backrefs
>>
>> Request
>> -------
>> Please relax or remove the fatal ASSERT and add a repair path that can
>> safely handle/delete overlapping metadata extent records.

I'd say it's not that easy, or it will already have been done.

The biggest problem of repair is, we have too many factors all combined=20
together so that any seemingly simple operation can even further corrupt=
=20
the fs.

E.g. if extent/free space tree is corrupted, a simple metadata COW may=20
overwrite some existing metadata, further corrupting the fs, even=20
causing more corruptions.

That's why current btrfs check --repair is only designed to handle a=20
single error at a time, not really several different ones combined.

And unfortunately for your case, it's multiple ones combined.


Furthermore, if your system doesn't have ECC memories, it's strongly=20
recommended to run a memtest first to rule out bad memories.

Hardware memories has its life limit, especially for DDR4 ones that=20
lacks any kind of ECC, and due to their ages some are already causing=20
problems.

My estimation is around one bitflip related report per month on the=20
mailing list, thus it's always recommended to do such check especially=20
when your fs is hitting very bad corruptions.

Thanks,
Qu

>>
>> The image will stay online at least until the end of February 2026
>> (can extend if needed).
>>
>> Thank you very much!
>>
>=20
> Hello,
>=20
> Sorry for the gentle ping =E2=80=94 I=E2=80=99m trying to understand my =
options and
> don=E2=80=99t want to spam the list.
>=20
> Right now `btrfs check --repair` aborts (ASSERT in
> `delete_duplicate_records()`) due to overlapping metadata extent
> records. This filesystem contains a large personal library, so I=E2=80=
=99m
> trying to understand whether there is any realistic recovery path.
>=20
> Is this ASSERT considered an expected =E2=80=9Cstop here, too risky to
> proceed=E2=80=9D situation for `--repair`, or would it make sense to han=
dle it
> more gracefully (even if that means skipping something or continuing
> in a degraded way)?
>=20
> If `--repair` is not expected to handle this, what would you recommend
> as the best next step:
> `btrfs restore`, `rescue` commands, mounting read-only with specific
> options, etc.?
>=20
> The filesystem is unmounted. The btrfs-image and logs/backtrace are
> still available at the same location from the original email, and I
> can provide additional info or run tests if needed.
>=20
> Thank you for your time and for maintaining btrfs.
>=20


