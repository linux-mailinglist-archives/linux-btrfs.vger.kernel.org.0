Return-Path: <linux-btrfs+bounces-2764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A954B86695E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 05:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361E41F251E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 04:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195AE1AACC;
	Mon, 26 Feb 2024 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S7dKlnYQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B618E25
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921667; cv=none; b=lneDOaInw0nh8diQwfimYMRmc0OZbl2ru4xgHefUOsahw/ma3G5fZtiGwZbxYVO1pQHCh+1enBtTxKd70uQxPM1xQugeOzya7BBgo43hD63TpVjYK0i40+eYzxc5X05RoQdIZibe44aw/9qqJNhkICkF4w0JEb2+0o/5tWV903M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921667; c=relaxed/simple;
	bh=u3Ds18MBwzKb1qhXCvlqEt52XJRtNTzaR+b6nP9AWVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pk39EZLb9RbMDetR2mc6p+AC0QFAAUrmh5jS23upNGE4Javd7jA0/AJRsNI1w9F1aXkpj0vjFYJeHtnum7r5BBx3ckgzkhgBvPOh+6H6++LXgY1nnL88wfLIAPDHX7TBmFGWx/Ln42Bjhz7Q0LMDwNSGxGldVzi8gKIu8Gb99W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S7dKlnYQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708921614; x=1709526414; i=quwenruo.btrfs@gmx.com;
	bh=u3Ds18MBwzKb1qhXCvlqEt52XJRtNTzaR+b6nP9AWVo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=S7dKlnYQU78v7yn+nuR8SSAmFY2+N1HgZU7cz27pIsUJvrh70WuIhDjbwV13s5XP
	 pn5elDfgEHrntyZ2guhC5byapcposlYS4NRv97b/LdiLNw36gw/orXfy6WNDzi4bX
	 BX0ay0WQKvxGrthE5s5bl4hSaMx3o5MCF1xVUP0hRqGlkE0e3cYZekpohPNIY7p3Y
	 diXbSdDzvgXnkBfhi62vHorYw9YZTpjnQjDgo4H9zPL5ThwuhJ0IK4piQXGY+FJ2U
	 v2ksAyh9gZ39vmOZbaVZos6eyq1073mZdPESAl4COgB6fbOLJ0/5/7sU90J9xOpYY
	 IQzYLxppv+6kvfY4fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhQC-1r8iny052a-00nkYy; Mon, 26
 Feb 2024 05:26:54 +0100
Message-ID: <4ad77de0-b48a-4863-adf0-ea26d69d7eba@gmx.com>
Date: Mon, 26 Feb 2024 14:56:50 +1030
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
 <ad42e7ca-ff37-443f-8469-bec718ba6b80@edcint.co.nz>
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
In-Reply-To: <ad42e7ca-ff37-443f-8469-bec718ba6b80@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tKWSa2/HoAxJaEKaAnD/SsS6o08xMMPtwz4R0jKD/lSdW+/l3to
 e9aGqMDumKj8pkVkhcKE/FQRsBNI5tKjOANwnVrf33Ith5KUItjwGEeUF/Y0TmeUb5iL20Y
 7mWMp9YLzj1EV8dtLBNHM1BZF/Z2fy1rDhiHMv0uhxW7KVi3by/SEwdT8W01VFQ0jatEEOW
 EK7NrJAdGzlkyrVzHOmdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xf08qx7cX/M=;co8rYpP19wkOUDfN5dTCXc08ebJ
 5Puz7uu2/GkNzloALT6oQtyfAs1NuzswbfEiaA3+RIn9K4MYgcf3ZUHa6igrnBXSEqGW5IxcH
 LLvZxGiQHZZBIPl4c8KQu41imPAZ0ObPNo3DUi672uED0VW1Lx0OMVPPlUMe+ISCTrHNMw1be
 HJpGe21MkMzdz+7u6+W1qdTvezMABOD8FXmLwXIhuhalzwlFKlcLhnG6lVkWKmoA1DfgZ6sEK
 J0KsrSHPeivhT9hh7s4nstQYRC/iVRdtF8FAEB34t4qfmQWgc/k/nlxOQNF1j48H0WdBxdeZg
 dTyaB1n5DO6A9mHzKNT3L54wa33bsOzw3bXrgwWrlGMJ7+PLjab6twUc2S/vbQtwzDkJxxfml
 drrTomkv8QF7k9iS5O5LXUUjJrcFixhf6LzJMsQaV+R59flBkwVDu34U4McnoGlvZA03nnpAR
 C5grA7cESitTxgY/5c1MgdaD0Ag+S+QwfrCNgvgZ9ywEGUj1lvnbaSysV2OJ0SUQ3tL6EO2f+
 MpRrlHHx+L19k3qg5btJkBVldoTO2Z5ghz44bU/E6/IAoWk3L1ldaK2/OocF7tH+2MYIJJ9SS
 aNSI4EIKWb9N4/7HBozqodiGxLJMQks26U5fusaV0lLVl4FHjXymIbUHWx47E9D2WdmxMzOFT
 DWTgqZVdgFJMavUY7Oy9pKAKk12KIMNA68janhqg3pnidkaz8IoVOpS+rITlapNi+NHeQMP6+
 k/bDF/odXMvcOnIHZ24x2+AQLtGuYwCDRF6+mTaedfdP2eiXMxNARbbIGT4Vwpl7u3dZlE23v
 sj7jhXGEtxoRPB3rXSSkYbj9hn2KXEZeCxYPN1vwyuEqc=



=E5=9C=A8 2024/2/26 14:55, Matthew Jurgens =E5=86=99=E9=81=93:
>
> On 25/02/2024 8:03 am, Matthew Jurgens wrote:
>>
>>>>
>>>> Is it safe to run "btrfs check --repair" now?
>>>>
>>>
>>> OK, not hardware problem, then not sure how the problem happened.
>>>
>>> You can "try" --repair, but as mentioned, you may want to run it
>>> multiple times until it reports no error or no new repair.
>>>
>>> Thanks,
>>> Qu
>>
>>
>> Repair has been going for many hours now. I take it that even though
>> the repair looks like it is repeating itself a lot, that it is expected=
?
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
> The repair completed after about 36 hours. I started another one
>
> It seems to repeat itself a lot and, if I pick one specific example,
> this line is still appearing in the 2nd --repair run
>
> "ERROR: tree block 20647087931392 has bad backref level, has 227 expect
> [0, 7]"
>
> The exact same line appeared 28 times in the first run
>
> Here is a sample extract:
>
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf0=
90b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf0=
90b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf0=
90b
> Csum didn't match
> metadata level mismatch on [20647087931392, 16384]
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root =
5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> ERROR: tree block 20647087931392 has bad backref level, has 227 expect
> [0, 7]
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf0=
90b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf0=
90b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf0=
90b
> Csum didn't match
> ref mismatch on [20647087931392 16384] extent item 0, found 1
> tree extent[20647087931392, 16384] root 5 has no backref item in extent
> tree
> backpointer mismatch on [20647087931392 16384]
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root =
5
> Repaired extent references for 20647087931392
>
> Is it actually fixing anything?

Unfortunately I don't think it's really fixing anything anymore.

The csum mismatch tree block is still there, thus it can not do much
with it.

Thanks,
Qu

