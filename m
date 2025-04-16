Return-Path: <linux-btrfs+bounces-13111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE6A90E6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 00:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAF017E3EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 22:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02758235C1D;
	Wed, 16 Apr 2025 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HSc/DpXf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA13946F
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841277; cv=none; b=cmhCEJAcKg2pveiuXXGsoIax+jRdFB7Fq0Q6xYH2/VLem0bT7mHFOHBDgY/8yRMl2OJDO/juqQ5eWNgKmMzOeRoUhjSw3vTISKTlCxcZsKNjeFrCkCxlONmohPN2LeFjHojTYh/ameD48lDEGoQwEW4kYTpfoapOGc4KivlHTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841277; c=relaxed/simple;
	bh=qPn+pvlPH9q5HUbGpMZ7mt5AbJgBfMqHqCQXpSSs8L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFxMz+YqK/VfvCcZZ7T5nKdDwsqYh6AQO0FkYEnx1xB/q1aOARyc2wU4qeFNP6KzPi6/FrGOsEVOJpqg5N4ohGoBLydoBQgrCWoN6+OUfX13/pfX9pO57e+++ojm09nOzHcW9E3NQxu3817UBsEAhoW8iu+9jGe/8czeYqnBdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HSc/DpXf; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744841269; x=1745446069; i=quwenruo.btrfs@gmx.com;
	bh=Np5FkcaMOjYOkCq9gYwzm+wX6iH3PV/J9T3S0+GhIHY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HSc/DpXfbqAmsnzwaf9W37gS4cPr+Wc9pS6WlUJEBIXYbsa+7jDeXH/zDxT9hV1n
	 zOPVICoASkyXb9t+e2QhyFzyO/Re/X388H7LIb3wSNGaDAkcB7ssRImSUsQ0JHAG0
	 km8bUd7qhNOSbQrOKIdvvihxhvU3d/s/5pMb6WbgCce+khCCenF9X4UhM6F0pywCE
	 ZrqWn3IVAe+5nfbZQ8T+hYops9THuepVSFTqJvA2p8NZjddIQUlyBWCCP6QTQhfxI
	 EfSqtwIa4FAAKHB2KQAzM6RtNIXJQWcahbpq+9RdFDEn9yWyL+wqYX6RBz0ugCISN
	 fVRoBD5VQ5/HWCe6EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPXd2-1uRo8c3HXe-00TNy1; Thu, 17
 Apr 2025 00:07:49 +0200
Message-ID: <3c2772a2-f41f-44c0-acc3-989c77d39943@gmx.com>
Date: Thu, 17 Apr 2025 07:37:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
To: Josef Bacik <josef@toxicpanda.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
 <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
 <27440332-2afb-4fb8-9ebe-d36c8c33a89a@gmx.com>
 <20250415161647.GA2164022@zen.localdomain>
 <7ad4df86-866e-40ce-89a1-48f3c49aeeea@gmx.com>
 <20250416141646.GA2778901@perftesting>
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
In-Reply-To: <20250416141646.GA2778901@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M+Nk8Z6vVVigwqfy0oko3sBikXsJXVZTTwwsNuVeFt7eXa+RhPe
 nng5mvy9AO+efosecyxQVOTCh5X1LT245El3icoJPcbyumkivSddijxWxxEPwFXcX2Q3Rjh
 xN+ucqGWjqK5Ll6heJR6LYIFvaJn293SduK/Q4PwSHT7vvN6p3HrUmbsjWpn3o3cfzI7rDE
 gXC088MK3M3/gjSiV0eWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9CZzVxeIz0c=;AJ6ENOcOhmgIVl9V0wyBP7Ry60e
 oPAC7UPvYeBfiotnYDvdUbZvQcdE6rx6cfbaRcDdmqbuL0UoFRu7Di5JKIr4L4OVrIh2A/q+b
 7C0CnluZWIdFqGSJ3TMjhJ15pNuvags0Jpo7xJgecIOQ4k9GTy9UqJV8ibK/iAfWXDLVXx7xw
 QbseNcMiBaskjlqIiHW+n3nl+UUOJ9hdFwt2P5txFB/FzzpvOAc0eKXwsl8B6S8R/oGTR3WYF
 GVH4rHKJ69t3Ebjna0emblyD+/G9XNyNICLXdrDoFmA2+uT/AxqdftbwI+G7gIaCEsuQKfBUp
 y9NtK5PCELUUMn+putXjml9/nXPY9EAe6N1uVSg0VBYyr6VErNERRAHbPTwhexXMajJMomyBj
 u6b1Bo4PI1H75rKfCG+7WFy6CBBUt/WwoqzMU78xD15nnoKT/ehEX3vQnkRJlXx8cZByDbVx4
 K9t0dsxizUlXMpvVSGZxL5RCn/EgBTtnN2Ch3TIkbw/roQYh+2ovKJeq9xPge2eZKoNHRj+F5
 3XObONu76WdHFvuEzgFhqBEHvN1YhoBD/JKbWBRXmkADKsMyHDfvPBu8MvTdQiqq8+cPznfd5
 ESiNtG3y66Xlj7ah2ADzaShlhnuLrbXg2TcX6yWXEvI8XHpTXAAmOhJnpRPU85j9tQZpTonjA
 gJ6JT4OIkdXxn58JMFjFsljra+nGbJFXAmzLkWgD/R4G1NBwX6wyocJstM9YlY1l1lEgS93CC
 LRsBzycEXU5QdQ5RiqJUxe8GdLYRzDbqr+65f9udU0iXnit1M6ip2avSB4yiKFqdgza+Vcf9d
 lx8CDrFFdCZjDLAwhniei/LC7hLKh6hP/y+8Gcqr90AcCWPKfNJHG0fuJbaueW7po2/oMY985
 Cj1Tx4KbDQ99UMnr8/i2hSyQ+ikCE0whRLTNTWDw+H236j1O7SZfbibs5TwFj+Lgpew0vOp09
 YoJJmFlpNCZVwe0rq+mnt33uXYRvIjbQrEGxcp0pJO+FHLNXrte9TEmAT0Z+oyuWIASOVNgsD
 WI4TvB+Ei8HGC4q8qC9XTPbW89TdBSBUtSm2s2CqsUugE9Kkv4ldD/CPf24yNOb5UzP8MRAmn
 rDszKXGPY8SHRQCJHPf5rBYa50GO66PAa72PYrKLy8jGMpdbBXAJyEqkbmUfbChd+PsTlZphY
 82pgU7mSISFf46NnqZGoDvhjdnWKHUPegJlAVppJ4Y/7znpkuIKlmlJk6iYGrwZqEsJwp2X+O
 t2zAek+CMxO7ShLb7LIRyUYAAVl7BJo4MPNhIlpS9fy6iSQptzF2xj8XFb2iRxtMtm/l9cviA
 nrB9Y/56HQ7Wyw61pg153lCmrreGxItXqW8+dEWCf3bSp/UsNVaQqB1ZTP+fQov4hjPLX9jCm
 hbTystJd8glLuRMtqhXICU4MhRONIm7TIGCfSyrRJrMQ9cylwOL7cLSaD/IhPFaroTArFdT9G
 LbjHGWpd+YdXOfq1S/euXvjTGhcq5vexJ3L3Io5J9bN2HqA8EsUs43ulDYcfJRH9Sw3Ahr9V9
 oNnOu8oyt3rDg4I/MduXTIqxOExqpwvuIIvDBemJ8gxfeIT6EZZqh3hi/tXR9C5BetzeMav0f
 Xxebyn+aGrI7Y7E6/DMzN8sGYFNoCN78EQzTHAXomsK6KgkmHVXKetQy6xKFZr9H9fiyGLFGL
 45LQ9Ml4RdBFjKtxzuVsV7B5mIKIQxnA8jzUZGnTbr14pbuVQ7E/xTlEgiPS3x1HotLUPeSCE
 iM6rjQJOS8nW/nuwbWvVgxn8Iark/crx8amVzbqmbACvR+INLbqxq8MSqkokmmpw+HYZjNwQP
 UtP7nPz6GoLg+7qPYBaa0GahabEmYZPDuOg4j6HhVBbAyB5lgN9RPezO/47stcqT+SOFr+QE3
 HOjx6h6hPDtcLFBroxpco7YhwRqEt3CZatW8Hp2QZERwN9J1ddx3lCVnl98GE+e9WI4Irs2CK
 LFnN/psV1+GAsl93DpqbtH2dulRD0eFCMsGTcjMCqimrBqKIwgW5kOd873qTU25tPhfSW6o2+
 twLkozAQ+xek3joi0h/IEInefi+GphauWACOgOKZ8cKJqs3t4//DvMN0TDbqwrqBmbAd0rQ4A
 1LqHPjzJ3+Wva/9rjAcQ4250CWT/7W4TOsY6NE7xigvW62M/tuKGd7p9xUMaFw7jyPQNr4owF
 CZOyaGHGWrMrzPBadHAvUfihSXRKJB81cA1sJP73g6AuliHdOewlQHjyQ69IjTpHb2eP795N5
 7Hafx+PMk5DCrBKK04zeUW0S/Cozspb8rEAC+HdYYs2cp8doq3LIsqfKs7uz2JfyBWaqtJPW+
 TfNUuDZj3O49L+dUYKRYyieafjn7jXGj+YThzSsBEuTfCCQa2uB+Wsr3gEIIVj62aH4+T2wL3
 5be4Q3cmUQKV1VKkZc52UWTxZsbvc8j/9/H9HRjhzQ9zv1SgkTjy9k4k6gfiCishKovw5OcfQ
 Pk0iRoKxuzJU8DFSSdwbP7pd3IBf7Bz+0Yy20L1YffakFY8kYue7DhxA2qV5+0/Fg5ggxisea
 EsGSXd6OQE3toDk9WJSVgJVniFkew+bzCVI+rAxhxbkE3LDycZ+8wwoNn0FpnIgiKgj6gj4vG
 gaXC5BNRQxcu+k6jJzjMaCDxmlpIxbwCAmEWoOxKKJl7rzDqjw9KYHiW8GaHyAOra/aO32MfC
 +vgNbZnvsNCJoFF8x9FZR7VBLUc/ClAFsyphMoItutEoAUTEBpz2DMXWXy+/xZ82yk3IeqEdm
 U7KlSMxbwEgkkvHBAtz5ktS40bhvnWfidBV1dm/XWUkVL+E1pjcqas5ULQ4SSk9KM4tAe4x1i
 ASA80Ck9+aOPPo/bzIdppp2jz3AqQLOvHjI5CS4D4k9VOtLaCA6Drg9/gBzE3ffSGey3Qjqig
 qxDI3NiZOjoWgBx/8cCLGtlYGZU4FgIYgnCJebnEkrTzNyAsG/Yu+q/OXao2oaP+aioyqbXpS
 uVblGwfvmA==



=E5=9C=A8 2025/4/16 23:46, Josef Bacik =E5=86=99=E9=81=93:
> On Wed, Apr 16, 2025 at 09:19:37AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/4/16 01:46, Boris Burkov =E5=86=99=E9=81=93:
>>> On Tue, Apr 15, 2025 at 08:07:08AM +0930, Qu Wenruo wrote:
>> [...]
>>>>>
>>>>> The problem is, we can not ensure all extent buffers are nodesize al=
igned.
>>>>>
>>>
>>> In theory because the allocator can do whatever it wants, or in practi=
ce
>>> because of mixed block groups? It seems to me that in practice without
>>> mixed block groups they ought to always be aligned.
>>
>> Because we may have some old converted btrfs, whose allocater may not e=
nsure
>> nodesize aligned bytenr.
>>
>> For subpage we can still support non-aligned tree blocks as long as the=
y do
>> not cross boundary.
>>
>> I know this is over-complicated and prefer to reject them all, but such=
 a
>> change will need quite some time to reach end users.
>>
>>>
>>>>> If we have an eb whose bytenr is only block aligned but not node siz=
e
>>>>> aligned, this will lead to the same problem.
>>>>>
>>>
>>> But then the existing code for the non error path is broken, right?
>>> How was this intended to work? Is there any correct way to loop over t=
he
>>> ebs in a folio when nodesize < pagesize? Your proposed gang lookup?
>>>
>>> I guess to put my question a different way, was it intentional to mix
>>> the increment size in the two codepaths in this function?
>>
>> Yes, that's intended, consider the following case:
>>
>> 32K page size, 16K node size.
>>
>> 0    4K     8K    16K    20K    24K     28K      32K
>> |           |///////////////////|                |
>>
>> In above case, for offset 0 and 4K, we didn't find any dirty block, and=
 skip
>> to next block.
>>
>> For 8K, we found an eb, submit it, and jump to 24K, and that's the expe=
cted
>> behavior.
>>
>> But on the other hand, if at offset 0 we increase the offset by 16K, we=
 will
>> never be able to grab the eb at 8K.
>=20
> Right, but this can't actually happen can it?  I mean it could happen th=
e first
> eb, but as soon as we allocate eb->start 24k we would fail check_eb_alig=
nment()
> because it straddles a folio and then the fs would flipe RO.  So I don't=
 think
> this is a problem in general.  Thanks,

Yep, that's totally true.

Thus I'm fine to reject such ebs now.

Thanks,
Qu

>=20
> Josef


