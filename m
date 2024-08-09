Return-Path: <linux-btrfs+bounces-7063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4394CB5E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 09:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1C22833D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 07:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CA71741FB;
	Fri,  9 Aug 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sjHBwcI8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B40167D95
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188684; cv=none; b=IkK7PMhJ+JdHuvbMdE/mhTUqG+W+R5yMkXjFhnuD/kKPLOZh3UKn4XMqP9kQPg/jCd/pP1fxg5G+KnIM5P3EHk26QKEEXNybcOz+0w1QTtk3KG7/D5YaoFwuIqO9cHCbWws1S/8JzJyNyYJkBtCy9J2GpBYB4iDXJBSiNXI3kKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188684; c=relaxed/simple;
	bh=xOAKS8B+Bdk8HceGl1To48NBLuicEpq2Pmmj3v1mrsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pNRVjx0TwFupb5iPoFoA0f6uY56uej5rDnO+MiUG6HXixUv+njAIlnZreZfFvhqGj969I/hUbY9jOWTXNHz3ATygRCFVNYdffdFzbp1J/gaTN1yN7HCmBfU0Nd3Vg+UHgwlEcgf6cv5DgE4bdwWFTeMga8562+1l4VOwv4hy9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sjHBwcI8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723188678; x=1723793478; i=quwenruo.btrfs@gmx.com;
	bh=xOAKS8B+Bdk8HceGl1To48NBLuicEpq2Pmmj3v1mrsA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sjHBwcI8VgkDuktm1RAlh2yuR3+QiJeiUmTb1X292uMNuc/YRdydfPqLOHYJwmcz
	 gTJkCm85lziDAav0JqvUcXiP6P0/uHWa5/deXh2JNrwYv0j3PklWc7/M6jd1uIML5
	 8cq5J9e3x1DTonaY4BvWxh9qdy5qhQSB3q8pdy0NLpkvHAltzITj7B2ggbC0N5ocA
	 ER3W6ySV9xU597KBTns8+vXip46IfkWehSNO6R1jUMTCANLfbmlNoDPJGIZ/98yiw
	 KssdDIZb0vxGrtoleLZpL/tnpPcP1ThQ+EJgUZYqGZ7bmM76BgMH8hSjPgZTL6/zp
	 +HxzKEv4soCfzPjl1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlw3N-1ruUxp17tz-00is9G; Fri, 09
 Aug 2024 09:31:18 +0200
Message-ID: <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
Date: Fri, 9 Aug 2024 17:01:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Andre KALOUGUINE <andre.kalouguine@ensta-paris.fr>,
 Qu Wenruo <wqu@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
 <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
 <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
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
In-Reply-To: <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HFn8povVxC35f8vqIpptJRssjUWZfg+Bj3+kbPGIyEzn4WOlCi8
 o4s9Y0twb0shQgLhgAcbyy3dyF1IxghezB7JK1+GI9yFZMf9lC5KUUYf5IHsnc6n2NVHr2x
 tWskVuWLj1Nyikt/fcEPt7Tt5D3N/MushKS+USkaEOVavR55T8O72M3QJLbAjzo/FklX8Ot
 DXfrvGfxKruUmXWhBk0Ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SPPOiPiTLzo=;67mn9QBecALQ6F1EnH5Cg/Qpcuk
 6XG5upn5XjjFctpdXA5VL4sHhEy3XHXgylAqOXwyJdemg1MKhbekgpbPsmSNpgXdEMD376+oS
 P1UBioqRa4929nmcmK202gXLTeT7RpsZsyNJ2pouOH89gX1H8ThW7SJvBOw+FYnU3E4yA1ka7
 mJ+h9FnXaL0H3UYcaFGvbRo097lerTmVUOLIgFJJsZ4xNdXdm3tygHDWATZObcdhKrujeV/S8
 Ykd7+VXyqc1hL45BFu66tJea4XyoY/v/Eesmjm33ADaaGpyVbbZAtviH6AY9QRzUR9dp+IHDC
 UKC857AcMff2DkI/DF+afVQLzozTO53NLu9Bhx/LAwRFhZKIi4aCAYq1B7WV7RZaNhKdSPf4B
 Ty0q3xdgmt3EZDjE2dt2IXM4idWx0IlFiNOPKN3F4vssV+7AlLYi6ANCpAyHOey2tykZlLV7Q
 JfUlvNywJIPowg4i2I3rBWieWzBPb/KtcBE0/eiprhmYwcaeTfd3IbetMPEG4wycXpDU7XDlN
 2hSWcVJJ28yGF0HQyIPfLNc6fKhFgwBKsw4zynt41Eins9f2Pjef38lr1dUTZR7qgN/Q4FFzT
 K5s7BsQrPQZAlV79ivLhKL9uVxxIVpmjkMKKOYhGHlZrioRrDHj2APu5t45kYPxviJ2TuSxnH
 NipaiIx6XqsdQDr1LNltClpNcFWJrQCVNennpZ14jCH6R78DqUDI+ShMUIThMWUsee7xYwfTc
 Pf9eytsN6GLVr1dApTQieiPIjlbn82x9USIYLAh4+FgU9aeb7B9KICiFbwOrpVST6bFUsySuL
 GpjU4rvDENPXh5msEObrD7Fg==



=E5=9C=A8 2024/8/9 15:56, Andre KALOUGUINE =E5=86=99=E9=81=93:
> On 8/9/24 1:23 AM, Qu Wenruo wrote:
>> Then I guess you may want to disable discard, and move to fstrim
>> routine, just to be extra safe.
> You mean to avoid such an issue in the future?

Yes. Since the most possible two reasons are either the discard, or the
nvme device itself.

If you run "nodiscard" and still hit such data loss in the future, you
know exactly what to blame.

>> So it's the corruption of a critical subvolume tree.
>> I guess it's fs tree.
>>
>> Then it's pretty hard to salvage.
>> "btrfs-restore" is your last chance.
>
> I attempted that with the dry-run clause and it gave essentially the
> same error repeated 3 times (iirc it tried three supers). Does it make
> sense to attempt it for real (and is there a risk)? I located a suitable
> HDD on which I can start to dd the data later today so I'll be able to
> do it anyways, just wondering if there is chance it will work seeing as
> the dry run didn't.

Then I guess the corrupted tree block is really critical (the fs tree
root or something like that).

>
> Is there any sort of worst-case scenario data recovery tools (maybe 3rd
> party?) that does pattern-matching of the raw data or something? It's
> not like I need to recover videos or something, it's only a few text
> files with known names, locations and partially known content.
Unfortunately no.

In theory we can scan the whole disk (or at least the metadata chunks)
to grab whatever metadata we still have, and try to salvage data from that=
.

But we do not have such tool, so normally one may go with
btrfs-find-root, trying to salvage a good fs or your home subvolume root.

Then go with btrfs-restore to salve data.

But if it's really the device's fault, I doubt there is only one wiped
metadata, but multiple...

Thanks,
Qu

>
> Thanks
>
> Best regards,
>
> Andre
>
>

