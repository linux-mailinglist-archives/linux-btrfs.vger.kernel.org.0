Return-Path: <linux-btrfs+bounces-7960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B4D976467
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 10:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E357285846
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD91917E8;
	Thu, 12 Sep 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZQR4MtjI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD6189525
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129568; cv=none; b=O5ExZCKkoYd9v7vn0es7Lsb+MAzrXRElEmf45ogEJP4KAkC3Ob139LC2gzXELBKA7Xf3LfP4VTKEL3GCzfKiCBKfURSwoUrujjwKR3VaoG57aZuzENjs4vq6399mQdAEdAmKhPhwc9qSWukxkqdmrp0FBmbnwQN4Q3qy2OlyZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129568; c=relaxed/simple;
	bh=RQQiQFWlrgqTQZU0cQ/HuZscaQqdgXjVbDLAbzL5Ghc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gHhLSOjUOm72tlqTyBaAVaCRLgdFhzCi1tv+8d0P6k3URSGeChPwN3Jlb/X9gajvFAPiGJT0QZSsLr4X39IYQJxIjSJUXhfq7LTKCYdhQf0UQ/Bm976njEy5RyMr65Sal198X87+ahujoX34y/Wg8Ss3ejz2o+uGAHUxy2W3rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZQR4MtjI; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726129562; x=1726734362; i=quwenruo.btrfs@gmx.com;
	bh=RQQiQFWlrgqTQZU0cQ/HuZscaQqdgXjVbDLAbzL5Ghc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZQR4MtjINEhA9azJE0euGCLludzL7SAkJWq2hnf2bv8gb2Pjv4m+GwXdJYzfSOzQ
	 w4VA+9gZy9xwV3qXmSgWC1/tOlf7W0yKnAoy09lu+te6DuB0CP541lLGXORVQH3SB
	 xGyMmico3hGkY5SDX0CvNG3EkN+H16i8KXECWSbGh+WxxOm1OLxQBmMnBnhP61a4X
	 yxjnVtUbS4BTxMIeG1PoY9Z7sSnt4QlML6JKERFFpcI+y0UrLtTbNOhRHSgbOTvrk
	 vUZtI8TF7JxknSkgX/xOVWtuvzHsmGIcgO0IInlD5tKa2Ldz3eGMD1K6P9YvhRjYG
	 AKa585iU/dIxIXaeeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1s89bM0Nx4-00kziD; Thu, 12
 Sep 2024 10:26:02 +0200
Message-ID: <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
Date: Thu, 12 Sep 2024 17:55:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
To: Archange <archange@archlinux.org>, linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
Content-Language: en-US
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
In-Reply-To: <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TckXupc74R10CwcY5g0PUEKC35ECALGFN2RFKU1FjOzav9QTHGi
 Ng3h9AC1crCtBIDmPLeRSIwV2tnQ3g61zkm4EaAe4sYwOnQG+8YF1Ij8NVU520CfOD9i9W/
 WIVFQ6Qr3R6/jEmEOUqGGVbvYO7ICBJh/QCxKh3yamBDYx55ak+g2mo3ezi6xPBiwyqM3px
 SGN6X+4Rhu5hcu5OyWsiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WEHybrWxbvo=;KQjjKj9NgKPs0qkV5Oro2eudDuK
 nGirRLrk3eTuqlmMDnEGSXThBTjG+G624ntGRKZ+tASWMz1dgu6pNzQm76gQ/PSj9+TJdkcbo
 4exNdQZ+PDEsYvfq7skYB8NrSNXNpoz8ehODNX3OrmJLB4tgm3jmaPzk+0kIuVpFkWPLvvPEh
 mkndJn6KK8PDAmm1qQwULoSuye+0xTEWITceg9/noMT5sRXhqgudoTlwLHZ5DWYOSco6SwGK9
 wUyumTcViauFGmNZt42kTnyptDfNOugdq3Vdg1N0oNJ9x7+CtFT5+jBrcCXNHnIcTGIzmGkzW
 4TnFnYxABs2B4KFzmBAsDt5oJoQoCd1a9AxwujBQ0DFqlfjpGpzaz8KVDBmFYH6t/2Ill68Sr
 Y1PE3Jt453RezUdeRqg61Vw7j3c+/RD537x/dRpwLZFXYsYn9BeMJBV4z+xKS2AznUUdSJVaH
 GHUE6L0bP/ZW5exfd84vL2oE181RLfKaVW49jo4J3NQZHfgfs0ZE0DJ5saNhaBeAaOG8EyLaP
 3Eh8apzhSMF7fKt85Esdkspo9SQY7NVfhBk6G2cu1Vj6GtZoB7G6Qx98LN7Ut9gOJGZWcEI+U
 VTNpEL8Iv0Xa8N0JpdAcZWFg2W5v3kfkryEmNBZ13Vt9MV1mLjfaBA3xWkEFY3c3j7vuD1xyj
 BMnNVQI/tMCNPdG6qRhvKVcdCQE4gJe0FtVnLkftqRFViazR0qiloGr2Ix0NsZ1aOLe1betds
 e1BrhhdpEYNmLFzyeK9rAmDP21T/XnLlMwF9lZqDK6fmxq7awYrIVmpGOBKqQctKBMp6sqUEV
 o+KbSEfhFutfBZxhuk3cI33NHF5qQqSIJtjCTtME4euoE=



=E5=9C=A8 2024/9/12 17:51, Archange =E5=86=99=E9=81=93:
> Le 12/09/2024 =C3=A0 02:34, Qu Wenruo a =C3=A9crit=C2=A0:
>> =E5=9C=A8 2024/9/12 07:35, Archange =E5=86=99=E9=81=93:
>>>
>>> Le 12/09/2024 =C3=A0 01:23, Qu Wenruo a =C3=A9crit=C2=A0:
>> [...]
>>>
>>> While the previous one (see my second message in this thread) had no
>>> error, there is now one:
>>>
>>> # btrfs check /dev/mapper/rootext
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/mapper/rootext
>>> UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> wanted bytes 688128, found 720896 for off 676326604800
>>> cache appears valid but isn't 676326604800
>>
>> Minor problem, still I'd recommend to run
>> =C2=A0`btrfs rescue clear-space-cache v1 <dev>` to clear the v1 cache f=
irst.
>
> I indeed did that as explained in the second part of my message.
>
>> Then you can mount with v2 space cache or keep going with the v1 cache
>> (not recommended, will be deprecated soon)
>
> Done too.
>
>> And if your fs only have subvolumes 5 (the top level one), 257 and 258,
>> then you're totally fine to continue.
>> I guess that's the case?
>
> Indeed!

Just in case, you can run "btrfs check --mode=3Dlowmem" to check if there
is no more inode cache left.

If there is any left, lowmem mode can detect it with errors like:

ERROR: root 5 INODE[18446744073709551604] nlink(1) not equal to
inode_refs(0)
ERROR: invalid imode mode bits: 00
ERROR: invalid inode generation 18446744073709551604 or transid 1 for
ino 18446744073709551605, expect [0, 72)
ERROR: root 5 INODE[18446744073709551605] is orphan item

And I'm already adding the ability to the original mode check to detect
such problem.

Thanks,
Qu
>
> Thanks a lot for your help,
> Archange
>

