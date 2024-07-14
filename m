Return-Path: <linux-btrfs+bounces-6445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1FF930BD4
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 23:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A5F1C20F69
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 21:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34413C80A;
	Sun, 14 Jul 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Z1RtzNUU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBCDDAD
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720994056; cv=none; b=FacQkL4q4HLhijrOF/IYZwIlmA2qzWFcmfvrc+4kB8zuhbsThqrAhH/C6m1Sp5EAYA25KYIMr+xSpZuQyr/umEPCwt9GemHB1j7PZQB6mWt3zCtwjwfPKPqLZ22b03ZbnN27G/WaGvlI13qSVjQlXYV1SPHpHJvS6B+F35uasdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720994056; c=relaxed/simple;
	bh=7rB2nmOYDdLIysya+xXtghEZDCWBy/1h6oWtLWpZZ2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QJm2RTAta3Uf+b9UbgcTAKvcjMzUY3GImaErhJLM5pWMPa+STcbc+2Fr1yT2MI2NK7LQ1tb2wapyW0Kk40e5y5SYTBYEVBpT6oRarwwK463EwVi9NseG4NBdpm3JsAKKZvt0YZTybIGQn9MAQs0YR140ihBYPQIaznDYP1Guy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Z1RtzNUU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720994041; x=1721598841; i=quwenruo.btrfs@gmx.com;
	bh=7rB2nmOYDdLIysya+xXtghEZDCWBy/1h6oWtLWpZZ2M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z1RtzNUUevksEZFvwVuT/gYla1kJfCKifakzhK8/j41rnO6GxZfyTyvbHRgkqA8X
	 rq0wEcaJodeyFYvGEimbAVuiiM2axaAa1hbha+TTUd4xXvurK7vKv34bt9YfJhznZ
	 2lc/MH0zfsLYKSbOgO/wWYqXNNp5zVAKF5w73MSi64f8dK1U9dscDm5PxOfvetUAq
	 XEz7Iz+WWL4VHDvIpMd4zbvOvcAbfHHmBctGsc204rt4BfDL9AYT1KkV6H9Pmd0Fz
	 cSM+FbXenIZIEKad8dEBNLbYxBpO8NvolhpgeppO/+HnzAWpPsJG6l866q9xHWBzj
	 Bo4POsR1axTBHaTDCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowGa-1s09WY3V9i-00hqaP; Sun, 14
 Jul 2024 23:54:01 +0200
Message-ID: <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com>
Date: Mon, 15 Jul 2024 07:23:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Kai Krakow <hurikhan77@gmail.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, Oliver Wien <ow@netactive.de>
References: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
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
In-Reply-To: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gX6l/9Ta56rucqMpVPOgYhC0VXk4HSreNv9TKcU8br5NgbFb217
 l9DXFROfzKuQkoFrKw5xJ89T3ui6kikubqGeSIY700/uBJpJW3HZxVuzBqwX9OX+rHzsvvY
 bUqHMazEzKHua4CbIgSrcdIaH/PI9pYhOlwJio+hQK/B8dQKrRUKofPhQ3+qU4ked2+R8oj
 WqTMGj4Z+yuqBKOZwku+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wl3CtgAAcUI=;mZ0OMPq8uzWzkMCNzf1S+D6XEIM
 a92mypjfW/9LRp0Ho3AQuoIP7Os+7kJeMa5VgLhjnlt/dbisqg2dW8Ymvorv5wVKY/VChJg/k
 pXLc6mba79HGNqa2Dw41cLmOsZ9JHd22e/JCm8CBrM+2suZIUDvawUVb2FrKzz6MOzg1bJ6yI
 Keaj7UscQ5ga5cwRrSvpdLMO5yvJwupHUBcvh4+pDWtZf/la5CoOTLLGiNDTrvlN7sdSquhCL
 Fvn+gTfHWLo4Norhrafu1wlXRCSCyfMFcBHTawEYDEUCefd3lKu1wZO8RVNuHxQkjSCrYJn3B
 FriU9/aIUa5PqIDtVJJTvgRWNOe3Kvnm2mULZdatkk6qqB4GbBJXjpec70Ljzjsy2TkvSd52g
 2f66ZrqJwDvlw2gUFWFVSrpLmtLmeUnWcf2RSayohLNALJ/BC6QxAzmIca9TNjhnUQLM2gmIE
 sncfweo27TZ67pWS+ui0F0BDNptimkXqlamATE8eKa6N5Am13m46NwCURKVsHrDRjFNqcryZ5
 tTgQXKgeBV0DROwBmhfzrobkVWN/eTZQ3WTFKYIxJEAef8d6ZohaJpYWHV4ceQk2pSqHfIGdS
 2R5Kywj5bLohajE367sbtR2zveriY0A8vpBSpXvqwATWlhNicpGVimgj6Dmo8igrKfi/OPqjE
 V4sTh5DRuZndO/G2w4HI1Alzp7rgXah6Tdz6oEn6aENLP6BQVCfwz2FXU9jxUbbdrVYbky9EO
 +XhtPeUjxrjffA6ZaVsmVrEW2IqPP+YzpdYN2SaD4MeEMOibGBACfcJb8hI0N0Mw/nAYgwmjX
 xvlOIvf0cUTRkCcaJ8w04AfvzCweAVHL1AWBaVBGiimIQ=



=E5=9C=A8 2024/7/15 01:43, Kai Krakow =E5=86=99=E9=81=93:
> Hello btrfs list!
>
> (also reported in irc)
>
> Our btrfs pool crashed during a routine btrfs-balance-least-used.
> Maybe of interest: bees is also running on this filesystem, snapper
> takes hourly snapshots with retention policy.
>
> I'm currently still collecting diagnostics, "btrfs check" log is
> already 3 GB and growing.
>
> The btrfs runs on three devices vd{c,e,f}1 with data=3Dsingle meta=3Drai=
d1.
>
> Here's an excerpt from dmesg (full log https://gist.tnonline.net/TE):

Unfortunately the full log is not really full.

There should be extent leaf dump, and after that dump, showing the
reason why we believe it's a problem.

Is there any true full dmesg dump?

But overall, most of the errors inside __btrfs_free_extent() would be
extent tree corruption.

> [...]
>
> "btrfs check" can only run in lowmem mode, it will crash with "out of
> memory" (the system has 74G of RAM). Here's the beginning of the log:
>
> [1/7] checking root items
> [2/7] checking extents
> ERROR: shared extent 15929577472 referencer lost (parent: 1147747794944)

I believe that's the cause, some extent tree corruption.

> ERROR: shared extent 15929577472 referencer lost (parent: 1148095201280)
> ERROR: shared extent 15929577472 referencer lost (parent: 1175758274560)
> (repeating thousands of similar lines)
>
> Last gist: https://gist.tnonline.net/Z4 (meanwhile, this log is over
> 3GB, I can upload it somewhere later).
>
> We have backups (daily backups stored inside borg on a remote host).
>
> Is there anything we can do? Restoring from backup will probably take
> more than 24h (3 TB). The system runs web and mail hosts for more than
> 100 customers.
>
> We did not try to run "btrfs check --repair" yet, nor
> "--init-extent-tree". I'd rather try a quick repair before restoring.
> But OTOH, I don't want to make it worse and waste time by trying.

Considering the size of the metadata, I do not believe --repair nor
=2D-init-extent-tree is going to fully fix the problem.

>
> Unfortunately, the btrfs has been mounted rw again after unmounting
> following the incident. This restarted the balance, and it seems it
> changed the first error "btrfs check" found. I'll try
> "ro,skip-balance" after btrfs-check finished. I think the file-system
> is still fully readable and we can take one last backup.
>
> Also, I happily provide the logs collected if a dev wanted to look into =
it.

I guess there is no real full dmesg of that incident?

The corrupted extent leaf has 260 items, but the dump only contains 36,
nor the final reason line.

The other thing is, does the server has ECC memory?
It's not uncommon to see bitflips causing various problems (almost
monthly reports).

If the machine doesn't have ECC memory, then a memtest would be preferable=
.

Thanks,
Qu
>
>
> Thanks in advance
> Kai
>

