Return-Path: <linux-btrfs+bounces-2906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D286C485
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 10:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5510B1F24ACC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8C38DE5;
	Thu, 29 Feb 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Hsa50MHA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D205733B
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197809; cv=none; b=QlKJxRvSwIHztF7lLPjY+zimepOObTxFbVd93xByzNl97So6Pz/2zckcx0eyi0PHNsgk2fvI2DWB6bWgC8r5Sl2vd1B4FZ8QBWMBme900h/Y6XWyOUlS9EaTsD5ajNJm7rY+yk0FzV719671oHYcPCAHur5x8z0mTL2Mi3obch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197809; c=relaxed/simple;
	bh=fLsw+wYlgFMg3i3YZJ+8VzoD7+hWhqCWM5sEQkejncA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WUFkOTHBNLr4nrCQzIDI1ESabzHMW/7uWv7RnH/DMuyo6wpQuVorH+0qyOi3OnZKSg92bqP/W8kitdMY1WhNDmJNCiAjR1JfygSZXcxUzTXIJSjbLun0T3diNcRQm8xvunNTBgMpS7CJ3EpV1vWLSfDZrfoe4/kfg/HHi+u2CNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Hsa50MHA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709197755; x=1709802555; i=quwenruo.btrfs@gmx.com;
	bh=fLsw+wYlgFMg3i3YZJ+8VzoD7+hWhqCWM5sEQkejncA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Hsa50MHA5DnIAVu6Ml2jEhg3QBErRjXwGoaUDbVm2L7PLThnMEx4AG9qW6FhGHes
	 pCRo9h0dTu9TKE/jVd+xkZvOGZRcKtrLK8mAH5ygquUiaKUN5vR8uItqnDjq5fSFH
	 WBzeYrpwpRMJQHAYXJeE6UjXwN7w7g+rmoxi0fX3zmEAl0aJcfNGbiJzWX9QO/nZ2
	 llXe/pXqNR7/K4SNLsoHNY3kp7D245AsUEO8KApLcSafK+GmfYCujgBH2NeiDqmRW
	 mp1bkh6kkslOyLaIDTOlVlYyE4dptNRtrxX+Jdzou2g3um04qxw0oiiYTI/qLfI4O
	 LFfbn4uC7F47+Q2XTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMobO-1rP3V83fa0-00IkY6; Thu, 29
 Feb 2024 10:09:15 +0100
Message-ID: <3e5f57d7-a857-415a-ade8-dd92b8380e91@gmx.com>
Date: Thu, 29 Feb 2024 19:39:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Matthew Jurgens <default@edcint.co.nz>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
 <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
 <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
 <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
 <09cfb22a-597c-4fbe-939f-aa10d8d461a6@gmx.com>
 <706e9108-fd37-497d-9638-44cfb64e0365@edcint.co.nz>
 <041f921b-bbf1-40f2-abdf-35f7d1dff723@edcint.co.nz>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <041f921b-bbf1-40f2-abdf-35f7d1dff723@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZS4MKaXcmnoMisF2ACoSUvTn6xssiNf6Su6gRNJIEQqLdTazKF0
 zj8spae8kpqaeYB67Q9ufCguN2oCwNzYItbbaROIGYa/zW9EW8d3cFMI8fadabPjSK47ZH3
 0mNX84jAD0BzuF/R0qScdp8boGexlxovkoocUa6EYLjc8cdHs5Q8l5CZMpubFuzzwe5WXIj
 KMI/+NaYK+lnQOPJ+iiXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7itTiwkwnr0=;LYX9xFY1vNffgs8/8nuNRuyauvm
 Yb7sWP8ve1i3pr4FPV9ce+fpyXsNyE/IQQoUV/SunkwnrlXlD98MrXppFRKaEgo3vvQ25XByz
 t9UWK2Z7iq8d6hKsvonZebXLcyhQByyPmzD8zSKLIWMhnJaBKjg4LRhTfcSywyT3W2dNXwv7w
 1Po4j3A//Sb0mNYrEs5wSiyGPa3XqgVu/ffxSaeU4b/HO2oG+UAYM6AAYud/ve+ysYt6mt1YC
 qtOhwaSWAHfVqwAvfMUmxujB4AfbPB2QCQOGKyQMIUR6Dw8sqsHoCeXhvtDRMzf9WQQ5YhI+K
 bfMbObK1YXbrP+RzeHwBtJEvdA4EFEiQEkIBW8SuC87gG7CAMuMOYEl/zS/FamizaZjJP/UkM
 nFDt7w6kIiB6/FMdQ29i/9eMO654sayO9BkykHHF+KuUfez99oKllFZgruo+Fes37T9uk0vlD
 ByWnnJ3eZtTZ+pZi+UZXET2gmac5BB6EHRIe7YNQSsnQL9MmHFk65zga3MpryW+oaF69b7mea
 SwccjlvF6S8C7pB6NjoTp2fxOTQ/H/zjzpBu12kH3cs0q30TP6V58ZeGSEWrgojC4VEOZ2b4O
 BlkXGhpSDKZy/xAcSgUvWLnHuOP7VxOyTllWtNsECg9xErsr6Iz0iGJg6MTHhZfb9qd69+QZr
 E2qaou9teACw+qQD6N1QTedSsPd1TeS9JNLTX/veJXt+AuS5m/a5BB5gJkrqHu5QIdQiZ1AZI
 fW/3FCTxj1+MloYhwWTmNnjGzrhsjN90+TkjGi2DGTjcUjIYT4yBN7IdkJ27jio5mVo7X4+Tq
 gDs1UahO7ZKm1JPODOfVsejnM+PfBS84DeVZAIYt6VHLE=



=E5=9C=A8 2024/2/29 19:19, Matthew Jurgens =E5=86=99=E9=81=93:
> Repair has been going for many hours now. I take it that even though the
> repair looks like it is repeating itself a lot, that it is expected?
>>
>> Sample below:
>>
>> [2/7] checking extents
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> metadata level mismatch on [20647087931392, 16384]
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> ERROR: tree block 20647087931392 has bad backref level, has 59 expect
>> [0, 7]
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> ref mismatch on [20647087931392 16384] extent item 0, found 1
>> tree extent[20647087931392, 16384] root 5 has no backref item in
>> extent tree
>> backpointer mismatch on [20647087931392 16384]
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> metadata level mismatch on [20647087931392, 16384]
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> ERROR: tree block 20647087931392 has bad backref level, has 116 expect
>> [0, 7]
>>
> check --repair has completed 2 times now
>
> The first time it repaired stuff and ended with
>
> ---- start snippet -----
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 190 key (18494262345728=
 EXTENT_ITEM 77824) itemoff 6355
> itemsize 53
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 refs 1 gen 4412462 flags DATA
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (178 0xdfb591f3915f431) extent data backref root
> FS_TREE objectid 957324618 offset 0 count 1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 191 key (18494262423552=
 EXTENT_ITEM 77824) itemoff 6302
> itemsize 53
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 refs 1 gen 4412800 flags DATA
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (178 0xdfb591ff1229b81) extent data backref root
> FS_TREE objectid 957422004 offset 0 count 1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 192 key (18494262501376=
 EXTENT_ITEM 73728) itemoff 6249
> itemsize 53
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 refs 1 gen 4412869 flags DATA
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (178 0xdfb591f6201a3d4) extent data backref root
> FS_TREE objectid 957424653 offset 0 count 1
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> cache and super generation don't match, space cache will be invalidated
> found 3271103128731648 bytes used, error(s) found
> total csum bytes: 3183087496736
> total tree bytes: 11320535711744
> total fs tree bytes: 6783274287104
> total extent tree bytes: 726347776000
> btree space waste bytes: 2023314930574
> file data blocks allocated: 3603262077198336
>  =C2=A0referenced 3498204970287104
>
> ---- end snippet -----
>
> Full output at https://www.edcint.co.nz/tmp/exportshared_fsck_7.txt
>
> The second time it just had 752 lines of "super bytes used 4971281317888
> mismatches actual used 4971281350656"
>
> and then ended with "double free or corruption (out)"
>
> I am now running it a 3rd time and it has already started putting out
>
> super bytes used 4971281317888 mismatches actual used 4971281350656
>
> Full output at https://www.edcint.co.nz/tmp/exportshared_fsck_8.txt
>
>
> Is it fixed or not? Do I need to do something about this repeated messag=
e?
>
>

I don't think btrfs check --repair is really able to handle mismatched
tree blocks.

Thus I recommend to go "-o ro,rescue=3Dall" mount option to salvage data
first.

Thanks,
Qu

