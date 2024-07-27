Return-Path: <linux-btrfs+bounces-6793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F290593DCB0
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 02:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED0828423A
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6115C9;
	Sat, 27 Jul 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cnT39G1i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE6620
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Jul 2024 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722040975; cv=none; b=Nwd5hQLZ6Zb0GxevRK0FUOLmR5a58jN7nAZzP0WRHZIRpOTXqh18ygzWgBqhDQDj6OrmnpAbhtRP/OsM/dIPimYvC7lojJZzpgKnOAtI3wvdCcJV0Xkn2jWQ156a2EjjdehYFBIwG0/QSeguOwW+3AiNcsk/YVBsrNQLgDG1r/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722040975; c=relaxed/simple;
	bh=XrYoYBETkhsBmWAP7Tjju79glHK9roJFKGcBQQGQLgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+rgL7Ks5tpRDLpyG+TnYmMUXSlaF45raDUFFt0+4lxYy+MEOPO52SzDmsCJSD49SaAyixZAH1tahzN0aUq3qe6tIrIN/aNdKneKLYy7HjEYf4X4FjCc5gF4n8Vj39m7kmRNMZxeCLgisnJ1fk1Zlqctp0k6BYSs1FMrDO8s6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cnT39G1i; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722040959; x=1722645759; i=quwenruo.btrfs@gmx.com;
	bh=XrYoYBETkhsBmWAP7Tjju79glHK9roJFKGcBQQGQLgA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cnT39G1ild3WlU4yHLA7RMQSIZK+ERRf+XMpEASOZrhL5TOahWhSNEkqEr8CD2Qn
	 0daUwCL9t52hRWZfoG192Wln0C3SteXQXViQrOzbPUuSl33A9sTaInwAAtcv+3sr8
	 JeEvce+7unZyAN+gwXP/m6vEMMe+9vhty82TX49kxYlAgdTs1emUp713RGtgqNgdm
	 MWJZoO6bH0aihrVmnCC71ciJaniup74C6MK9Jpr32Pp3dZf5z2G73rD8z81BhCt2R
	 uLv353ricY5t7KNvv9Q8GFlAUobPSq1hFry0mYQN+y2+5vBLonM/ABi1Vt2+g3Hzs
	 cTGGrzsvV0ApAF09TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK4f-1sGFmZ39qT-014va0; Sat, 27
 Jul 2024 02:42:39 +0200
Message-ID: <e91b02e2-4a90-4bbf-ad49-44f855220013@gmx.com>
Date: Sat, 27 Jul 2024 10:12:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force remove of broken extent/subvolume? (Crash in
 btrfs_run_delayed_refs)
To: "Emil.s" <emil@sandnabba.se>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <CAEA9r7DVO8gCRz-9vbwaNWznz9AOFxOyPLO0ukOJh-6Ef0o5Bw@mail.gmail.com>
 <20240725224757.GD17473@twin.jikos.cz>
 <aeed4735-f6f2-49ef-9a02-816a3b74cbd3@gmx.com>
 <CAEA9r7AzYtQ9BifUPcW3=1zz=RmS9Fb3CnProGMg6GVkmd14TQ@mail.gmail.com>
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
In-Reply-To: <CAEA9r7AzYtQ9BifUPcW3=1zz=RmS9Fb3CnProGMg6GVkmd14TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c7eGiQL5RkKqLD2MGEmVSFbCQpUXcDj2r+/vuDH3QvFTG15WeO0
 ug+fM6Er4d/SyPRfA7pi9N0NGK0Qh6A/jztBy1gxlLXhGV3/yPDSGVVL8bbfVIcUfguajM0
 sAxcovNaFle3yg9bivogqn4hZbyssCpZslYwhki2TNFAK+FR7zaW+K4psVcBsfVx438hTkF
 OOmCx7gIbsYKJcgB6SQ1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RkYA0nlPDzA=;o+BdqlJBnW2+DQCOo8t6dejcrnF
 NRm8n0EsyXDVJvPku3WVoZlSpUCpGvT2YbSL9o4Bt24lsMwBqsoXj5sxVhD0H04/WhdtBkHbp
 sbGtIGZY2+G3SLkj6Eqb7iamHIw6dNAJ4RpgYsuEahopyfUuRc9X264ksLd0xh4aG3ZH7YdoQ
 7iovPCcZZi9RnUELOPrxzzBV1+fZHJclkNffcbJlMwWUPzHTSvVlfDWTJj9ncYyb45MaioNsc
 3ILCvLZUSVs6oWjv6N6KK4Hi7xL9zTipPKdPlclSKkFxqqm5jkCXiO6x3vAIeSmfzwMPcgj9q
 Ni6zdKhTfv+VZPVfAg2v4LP45/7bCNmbHspQ91vxlkjNn0J5qfbGzxgd/hOxeS27S1V1/MKw8
 80Zj4ruwKrt4Bp8Uh0WYnegiGVQz1vXbCS5lWLuC5KZAc9FhXjqyoWnGgsoHl7AHzCjy5EtQH
 tM8hP5ZYfEqE3YcmqCGKEDsjjzZdqzW+t8uzJRLxm5RIztpoLRCD6yvN/oEofB4fIijs4YjOQ
 C8i0D+BAm0WlDl0axB1GJdraQPbNlgRxR9ERGyvevdsaoT+aQFeJz2fTNKh8pXjQV+sm/G4Oq
 GKflWyYgpsvjY4IsY/vGBV9rag6UdB7bZbJtLZy7y0PDgi+F3AomGCwhZsfF5lVoDt0g4GwE+
 Wo1wIlmCYrpnsjtFMzwdxWtch6uv+UXyMDNnWHVjkLzDyWoM9LmqrItGIDOsmMVcP8DNZ6Igu
 U/U94NR0yM9/9rvhRY74zLsd6zhC5rniWCUfkOCxd0EU1MSZkVoCgmUte3heCkPr1LexWyZd4
 vminUI632nH0cVHEVG7BI5Cw==



=E5=9C=A8 2024/7/26 20:22, Emil.s =E5=86=99=E9=81=93:
>> As for any bitflip induced errors, it's hard to tell how far it got
>> propagated, this could be the only instance or there could be other
>> items referring to that one too.
>
> Right, yeah that sounds a bit more challenging then I initially thought.
> Maybe it is easier to just rebuild the array after all.
>
> And in regards to Qu's question, that is probably a good idea anyhow.
>
>> - History of the fs
>> - The hardware spec
>
> This has been my personal NAS / home server for quite some time.
> It's basically a mix of just leftover desktop hardware (without ECC memo=
ry).
>
> It was a 12 year old Gigabyte H77-D3H motherboard, an Intel i7-2600 CPU
> and 4 DDR3 DIMMs, all of different types and brands.
> The disks are WD red series, and I see now that one of them has over
> 80k power on hours.

I wasn't expecting this, as the normal "memory chip seldom dies" mostly
applies to a much smaller time span, like around 5 years.

>
> I know I did a rebuild about 5 years ago so the FS was probably
> created using Ubuntu server 18.04 (Linux 4.15), which has been
> upgraded to the major LTS versions since then.

And I believe this is where the corruption happened, before any
tree-checker was even introduced.

Thus we didn't catch it early enough and wrote the corrupted data onto
the disk.

> I actually hit this error when I was doing the "final backup" before
> retiring this setup, and it seems it was about time! (Was running
> Ubuntu 22.04 / Linux 5.15)

Thankfully that specific corruption is only on extent tree, you should
still be able to do the backup with it mounted RO, or with "rescue=3Dall"
to be extra safe.

Thanks,
Qu

>
> The Arch setup on the Thinkstation is my workstation where I attempted
> the data recovery.
>
> So due to the legacy hardware and crappy setup I think it's worth
> wasting more time here.
>
> But thanks a lot for the detailed answer, much appreciated!
>
> Best,
> Emil
>
> On Fri, 26 Jul 2024 at 01:19, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>

