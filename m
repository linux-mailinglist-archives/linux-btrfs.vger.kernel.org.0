Return-Path: <linux-btrfs+bounces-13050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB4A8AC50
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 01:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB4544098B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 23:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347B2D8DAD;
	Tue, 15 Apr 2025 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WbAnDP3G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06929129A78
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744760989; cv=none; b=P66Q/ilqoxzOQIywM4DorfUZx6I9jSaoDNqEXSrV886+2qjDf4wTR4brwH0Q8VSupn9uMa7NlN0VrFedk/MdJkyMnBMx+iPQfqlCQyM+XDwLuPWg09eG7ghXDdWLrqs9hYjLQ9IbbGr6NpQqPMf3OT8hJdBruZ8E9qpFIVkMAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744760989; c=relaxed/simple;
	bh=h/T1LY2W1CSLu73BYQfU2u3QHrAvIgR793B+sIj52uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js+HFVcwAvTefa441SRkHMiYmpK0O14uAgWM2GgSiGoPnEse8R2jJ8Ky7XpQH8RqDWPagpjc8+dh3phqinWpwlDNuJtzI+rOwc5uPtgsB/klHNeKvXGHBJNN5LRINko0XtRGHF8iamnuKgrfV/nm4iOLpTARITHhhfAVDitjcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WbAnDP3G; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744760981; x=1745365781; i=quwenruo.btrfs@gmx.com;
	bh=I6Wu02Rv+c9JV0NxdcATy0RBe+G/nvpps66O94yeTYQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WbAnDP3GHpYx1cC4410eBfqalrIU4hDrcqCZXRFgy87G3ddn4S1SF4U4rtlwMOLI
	 BWLKL5B7dusptljUYmQs12QEY1+mCEfz7ElVzqWYHX4S3Q4iWSzK44+0ITDrg+GzG
	 JzMX7IfGEqKGs9x1t5m4pJf7PiaLgfjSglMtqgBjowrfvZ9Ca26uEh0qALc44Cf/I
	 zyTpiQP+9AKKV043TxvH7909PEBX1rz6xgbPvYHCL5DL6+5mFOcNkR4rmKvJA7MKI
	 SyPxMVk2SatAdrIgvE8A7gXPGJNXQO58juqzLdBKzX99w2l7LQCR4liaRtmUqwl+K
	 r7BS+4WIon/R9vuK7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof57-1tGKw00oSf-00lTYq; Wed, 16
 Apr 2025 01:49:41 +0200
Message-ID: <7ad4df86-866e-40ce-89a1-48f3c49aeeea@gmx.com>
Date: Wed, 16 Apr 2025 09:19:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
To: Boris Burkov <boris@bur.io>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
 <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
 <27440332-2afb-4fb8-9ebe-d36c8c33a89a@gmx.com>
 <20250415161647.GA2164022@zen.localdomain>
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
In-Reply-To: <20250415161647.GA2164022@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:baZLoLD0Fyjp2gUqKWQ7YSYV6yY7gOwKF6qi8XcJblLQ1r4o+Oi
 edT2KHrGRxFl0I4WmrmMGFUzYyWjg05RjFVC0iVf2022AyZ1DqkV/j9u82jsuRQvYyz4ubY
 bPVDnAEC/TCiP08ARBzKoKWWxtHeCtm0MkE2hcB5vp97DZ88RwOd9C/vx1xjeZUalUC+AO/
 Cid8NkYlt2YZNVhqRj3ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6wwD/AAwaTQ=;c5CLkfEiW1kZs7DOeLhO2EK46lg
 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
 VWdzWbgW76PY4xPQVS9P9RS8DZ4vqXc=



=E5=9C=A8 2025/4/16 01:46, Boris Burkov =E5=86=99=E9=81=93:
> On Tue, Apr 15, 2025 at 08:07:08AM +0930, Qu Wenruo wrote:
[...]
>>>
>>> The problem is, we can not ensure all extent buffers are nodesize alig=
ned.
>>>
>=20
> In theory because the allocator can do whatever it wants, or in practice
> because of mixed block groups? It seems to me that in practice without
> mixed block groups they ought to always be aligned.

Because we may have some old converted btrfs, whose allocater may not=20
ensure nodesize aligned bytenr.

For subpage we can still support non-aligned tree blocks as long as they=
=20
do not cross boundary.

I know this is over-complicated and prefer to reject them all, but such=20
a change will need quite some time to reach end users.

>=20
>>> If we have an eb whose bytenr is only block aligned but not node size
>>> aligned, this will lead to the same problem.
>>>
>=20
> But then the existing code for the non error path is broken, right?
> How was this intended to work? Is there any correct way to loop over the
> ebs in a folio when nodesize < pagesize? Your proposed gang lookup?
>=20
> I guess to put my question a different way, was it intentional to mix
> the increment size in the two codepaths in this function?

Yes, that's intended, consider the following case:

32K page size, 16K node size.

0    4K     8K    16K    20K    24K     28K      32K
|           |///////////////////|                |

In above case, for offset 0 and 4K, we didn't find any dirty block, and=20
skip to next block.

For 8K, we found an eb, submit it, and jump to 24K, and that's the=20
expected behavior.

But on the other hand, if at offset 0 we increase the offset by 16K, we=20
will never be able to grab the eb at 8K.

I know this is creepy, but I really do not have any better solution than=
=20
two different increment sizes at that time.

But for now, I believe the gang lookup should be way more accurate and=20
safer.

>=20
>>> We need an extra check to reject tree blocks which are not node size
>>> aligned, which is another big change and not suitable for a quick fix.
>>>
>>>
>>> Can we do a gang radix tree lookup for the involved ranges that can
>>> cover the block, then increase bit_start to the end of the found eb
>>> instead?
>>
>> In fact, I think it's better to fix both this and the missing eb write
>> bugs together in one go.
>>
>> With something like this:
>>
>> static int find_subpage_dirty_subpage(struct folio *folio)
>> {
>> 	struct extent_buffer *gang[BTRFS_MAX_EB_SIZE/MIN_BLOCKSIZE];
>> 	struct extent_buffer *ret =3D NULL;
>>
>> 	rcu_read_lock()
>> 	ret =3D radix_tree_gang_lookup();
>> 	for (int i =3D 0; i < ret; i++) {
>> 		if (eb && atomic_inc_not_zero(&eb->refs)) {
>> 			if (!test_bit(EXTENT_BUFFER_DIRTY) {
>> 				atomic_dec(&eb->refs);
>> 				continue;
>> 			}
>> 			ret =3D eb;
>> 			break;
>> 		}
>> 	}
>> 	rcu_read_unlock()
>> 	return ret;
>> }
>>
>> And make submit_eb_subpage() no longer relies on subpage dirty bitmap,
>> but above helper to grab any dirty ebs.
>>
>> By this, we fix both bugs by:
>>
>> - No more bitmap search
>>    So no increment mismatch, and can still handle unaligned one (as lon=
g
>>    as they don't cross page boundary).
>>
>> - No more missing writeback
>>    As the gang lookup is always for the whole folio, and we always test
>>    eb dirty flags, we should always catch dirty ebs in the folio.
>=20
> I don't see why this is the case. The race Josef fixed is quite narrow
> but is fundamentally based on the TOWRITE mark getting cleared mid
> subpage iteration.
>=20
> If all we do is change subpage bitmap to this gang lookup, but still
> clear the TOWRITE tag whenever the folio has the first eb call
> meta_folio_set_writeback(), then it is possible for other threads to
> come in and dirty a different eb, write it back, tag it TOWRITE, then
> lose the tag before doing the tagged lookup for TOWRITE folios.

The point here is, we ensure all dirty ebs inside the folio will be=20
submitted (maybe except for error paths).

E.g. if there is initially one dirty eb, we do gang lookup, submit that=20
one (which clears the TOWRITE tag of the folio).
Then we will still do another gang lookup.

If a new eb in the folio is dirtied before that, we will found it and=20
submit it.

The gang lookup solution is to ensure, we only exit submit_eb_subpage()=20
with no dirty ebs in the folio.

Thanks,
Qu

>=20
> Thanks,
> Boris
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>
>=20

