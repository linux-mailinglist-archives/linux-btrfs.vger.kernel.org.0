Return-Path: <linux-btrfs+bounces-3365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A887F0B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CC51F23DC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9DC57878;
	Mon, 18 Mar 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k8G2xOcm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67A957862
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792019; cv=none; b=B2D7F50mzu6LJRr9LTcOwjY8OEHVqhCcXJUjb2cRpiAZ9wNVXQEEX9fNkuifeL0qqPbDS0dj2+z3lBe5zCNoAzqj7oMHbCarTkI4d3TAKd7hrQuIny4NFRO2IgDVUOeMlP/tyDHVksB2wNko8ojFIru32WRHJJAHyxfS3SvRz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792019; c=relaxed/simple;
	bh=m0pE0CcA4fYvkrOAkXDfdmaVmX5TomAb6azp1K1Mns4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmp8PPuYSZEpx1DFREEfVnfNTkGzRo2SEIRdNbkRKx/Y8cFwTvz7MV1vAU2PgW3+3TBr60qzjlVGYWOfp1jmarAh0P4YaTaA9m7QV1WRO2BGRd5uv32GbfxML42qRIxf1iIKF/EElqAIIMPsl8v9f7rMKjGuAytqZFtZZKqFnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k8G2xOcm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710792010; x=1711396810; i=quwenruo.btrfs@gmx.com;
	bh=ia68V57ODtTNb/FhkovQZ+YHLpTYlrwhIdU9qzbBNB8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=k8G2xOcmIldiIyCyC6rHTFGjK6rh/KFj/BP459fdEB0Md/WQMox7naxiS9izE0X0
	 qn4nfE07+fuoO9aFbrcyJiLb/S5tP1zMduHQ7iP5iQTFWOoZf+fKla7FaEEVp+CP1
	 hK8f5wb8Jedjx6FPVtIqTFaA8BGYM3kGLarGo9fHxBO+/fydCpPTarbkfBN9UPAO7
	 KpbskebKI9AcegKj/+XKHb09ranqOpkxL6OkbC4QKHkttPJiPLGA1C2J7+ACBBH4H
	 TNs3/8RQG5EFgou3MLhfXbOjB/rrB+D8m4XAj/wrBuKHVJxIUMCDt7vzosGhq17Ub
	 mU7bgWasJI/BqvR0iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFsUv-1rYq6I39HL-00HMd0; Mon, 18
 Mar 2024 21:00:10 +0100
Message-ID: <7da22b7e-8842-4ce7-b64f-1ce67d877452@gmx.com>
Date: Tue, 19 Mar 2024 06:30:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710409033.git.wqu@suse.com>
 <6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu@suse.com>
 <CAL3q7H7wLB4wp+H-BYv1zi0ReywAJ2aiKf7LWyysb2rH44BZfg@mail.gmail.com>
 <a645407f-4308-48cf-9c7b-6a2e5fc8501e@suse.com>
 <CAL3q7H4sBDKqaRO-xA0itaVN=b3ooOMQ7nfP3Ra4hY3er1jyDA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4sBDKqaRO-xA0itaVN=b3ooOMQ7nfP3Ra4hY3er1jyDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yLIUz9G1DCooO2UKmCp0w7+vAazjSdm0Pen3eCNeiSj1ojlaYqF
 0jTLfizdAldVhBB6xd0ZK7CLdHLuhUmniTbgzQDsL5gCtNP9KGAohmuCu2Pue4xJte4LFQt
 usPigs/t5woptZKfuyJQXppS5Y1D2fqHE6Dv40xZEIsCZDl7ibCPh74DWuohT5DpzE8S1yf
 OnRbyyjZ2Pl944GLbntTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zxUnqa84QmA=;oc2kLLzqyDKmAYguB7ZowIpnIBd
 nXB0IrjrN2XX8YCmlWhgaANu2rRiTEBZgKoGNc1QUE/7QuRdHkPQUFGai+0XG52J69HQQvnOn
 LKtT7rAg/gXJ6iOstwWbJumlbgMvIjMA0g/dG6QUNqqt8nGtcvUL47K0wSXFmTLZwIh41ANbK
 tgEO/LcsZdOuZsxvKV1KnEthTA4QIgeFZ7B/YkMK+8po4jE/9/CGNZD05ahwDsyH1VySPGcu2
 ItUJnOtILsKUTzC2fzf4t1iYiFdej6a5O+/MqCM8dxdqzL9etU+OCfJRJtysAWONx/K5DCfHq
 AKhOibTWJcBl+0TQ7WzbAFCa8D+mHnKcIwg/BL9eSg1EWHfcTQBeh305zIZYGQyl6O4yyUz4N
 cpZGCQvnrd1SxyxuT6W24tcUhH3Ci0CnbLOBqMYetV4tGSox4CoQvCurDuHqtvnzDtlU/X4FL
 M7GofhHv5NjjN6kyP5QHBEToHv5uJ++KsJs9ou4VRGsCtfiXpj879NX3MqmO7jrata0hzskOB
 SY9F0UqFfr00bmiTCic0tScxVhopGEEgkci9MItujdNOYgN421IA6KvKn5SkJiHcVJBu/23Jy
 lERVPfjecp4uqppEoGavRATvpI1bZjkGFCi7FqQ1tjDxpnkkdoY8Z/V5ZAfodEebYEyXqYiMw
 sVf8IZnFGChw7V+uYW+JT5rbop+29J5vQV4MwAjYCdR8IxjIAtAtDpkK1QOUxaFu4/RGpqKR8
 zVzKAkaWV+l4LwFNf2ybyGEhI8kPZSVUxAD06J6O7kehXQ3S1JhuL7jU9vGPFeFjYvp6mEXBT
 nkmCODUFgf2tBcd/qxwrzal2U5n0lhfu/R/59h8MDkoRE=



=E5=9C=A8 2024/3/19 02:56, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Mar 14, 2024 at 8:56=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/3/15 04:10, Filipe Manana =E5=86=99=E9=81=93:
>>> On Thu, Mar 14, 2024 at 9:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>
>>>> Currently the scrub error report is pretty long:
>>>>
>>>>    BTRFS error (device dm-2): unable to fixup (regular) error at logi=
cal 13647872 on dev /dev/mapper/test-scratch1 physical 13647872
>>>>    BTRFS warning (device dm-2): checksum error at logical 13647872 on=
 dev /dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offs=
et 16384, length 4096, links 1 (path: file1)
>>>>
>>>> Since we have so many things to output, it's not a surprise we got lo=
ng
>>>> error lines.
>>>>
>>>> To make the lines a little shorter, and make important info more
>>>> obvious, change the unify output to something like this:
>>>>
>>>>    BTRFS error (device dm-2): unable to fixup (regular) error at logi=
cal 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
>>>>    BTRFS warning (device dm-2): checksum error at inode 5/257(file1) =
fileoff 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13=
647872
>>>
>>> I find that hard to read because:
>>>
>>> 1) Please leave spaces before opening parenthesis.
>>>      That makes things less cluttered and easier to the eyes, more
>>> consistent with what we generally do and it's the formal way to do
>>> things in English (see
>>> https://www.scribens.com/grammar-rules/typography/spacing.html);
>>
>> Yep, I can do that, but I also want to keep the involved members
>> together thus closer.
>>
>> Not sure if adding spaces would still keep the close relationships
>> between the values.
>>
>> E.g: inode 5/256 (file1) fileoff 16384, logical 123456 (1) physical 1
>> (scratch1) 123456
>>
>> It makes it a little harder to indicate that "(1)" is related to logica=
l
>> address (thus mirror number).
>>
>>>
>>> 2) Instead of "inode 5/257(file1)", something a lot easier to
>>> understand like "inode 5 root 257 path \"file1\"", which leaves no
>>> margin for doubt about what each number is;
>>>
>>> 3) Same with "logical 13647872(1)" - what is the 1? That will be the
>>> question anyone reading such a log message will likely have.
>>>       Something like "logical 13647872 mirror 1" makes it clear;
>>>
>>> 4) Same with "physical 1(/dev/mapper/test-scratch1)13647872".
>>>       Something like "physical 13647872 device ID 1 device path
>>> \"/dev/mapper/test-scratch1\"", makes it clear what each number is and
>>> easier to read.
>>
>> I totally understand the original output format is much easier to read
>> on its own.
>>
>> However if we have hundreds lines of similar output, it's a different
>> story, a small change in any of the value is much harder to catch, and
>> the extra helpful prompt is in fact a burden other than a bless.
>>
>> (That's why things like spreadsheet is much easier to reader for
>> multiple similarly structured data, and in that case it's much better t=
o
>> craft a script to convert the lines into a csv)
>>
>> Unfortunately we don't have the benefit (at least yet) to structure all
>> these info into a structured output.
>>
>>
>> But what I'm doing here is to reduce the prompts to minimal (at most 4
>> prompts, "inode", "fileoff", "logical", "physical"), so less duplicated
>> strings for multiple lines of similar error messages.
>>
>> The patchset is in the middle ground between fully detailed output (the
>> old one, focusing on single line) and the fully script orient output (n=
o
>> prompt at all, just all numbers/strings, focusing on CSV like output).
>>
>>
>> Furthermore, I would also argue that, for entry level end users, they
>> can still catch the critical info (like file path and device path)
>> without much difficult, and those info is enough for them to take actio=
n.
>> (E.g. deleting the file, or replace the disk)
>>
>> Yes, they would get confused on the devid or rootid, but that's fine an=
d
>> everyone can learn something new.
>>
>> For experienced users who understand basics of btrfs, or us developers,
>> the split in values are already arranged in a way similar sized values
>> are never close together (aka, string/large/small value split).
>
> Well, I'm a developer and I can tell you if I ever see such log
> messages, I'll have to go to the source code to figure out what each
> value is supposed to be.
> I'll be able to memorize for some hours or even a few days, but after
> that I'll forget again and have to look at the source code again.

As the core problem is, if you just see one such error, and you need to
investigate, yes it needs more digging.

But in the real world, the support cases I hit are all have tons of
similar lines almost flooding the dmesg (well, in that case they don't
include any useful info either).

In that case, digging the format once is not a big deal at all, in fact
the main heavy lifting part is to determine how severe the corruption is.

And I'm not going full csv-like output, we still have several prompts to
provide some help.

Thanks,
Qu

>
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks.
>>>
>

