Return-Path: <linux-btrfs+bounces-6458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE6930DB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956FA1C21021
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885C13B5BD;
	Mon, 15 Jul 2024 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OOy4UDcw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D5291E
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721022654; cv=none; b=UmYJqaiUHHr0Z3SaW9mmAbFeB/GMYzVR3ZJhyDXHp4OfFJDFyM6YFY70j0iUiAOSu3HmTnhE1TM/FHpHLQ87uH4UKZbLiUoxyD1ppmpxgkTps+PxDB5hp/YAoK+enYiU6qN81yP70Ci45ArGHqlWrDs6+TiUs831J/HvUWJXIMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721022654; c=relaxed/simple;
	bh=hlcJlRPx6AFWK0lpX68Py5t/Dln+Kzj2pD4CHRYVbE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnKZgs7njxFIv6CWzOC3E/qTxSbboa7ySkZ4hZGXq7rntBRRTfz6pW8TTvgPc3rMFYoBeCdiprI6E9yFrHfqCcIpfBvyG3Kuku2ZHRmxiGgPdr0Zi9a1La8tcOSM5LxGeSOp1DcirioYRIpNI9y3lFrC7UbQHoEb5f6QCbI/fWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OOy4UDcw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721022636; x=1721627436; i=quwenruo.btrfs@gmx.com;
	bh=jZhJqsYfgzGd/OWUjXxzX6lMlC6nnKMSORuSWKfJjLA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OOy4UDcwzM6b0wq3dIzuf0xf2Fr1/qFlizd1csg91lkArpLO9De11kpuf/u3BulP
	 ptoqOgVsUphfqxwzegD8BHd7DEzTfP0hWql5Tnj1MB7suWa3A1EvzqCGDknMsjmPC
	 1D3XY/h7oDaPhK7LN56uuUweyo4EcaqMG/69hx7Q1RJ3cPxe20YaU3MFPep3d4mOs
	 NFLGU4ZdxqD8CiJC0M6QYP2WVp2JoZ12p4o5V96BP5dcEIW/qhyM1bFtnWIilNa26
	 fZfCVvFNeTT1Rf7/3HG9/TzK0QnFHIO14yF/RVCpldEkoJEzvc5nBmmqMVgrhg9Bh
	 q45Erdnx9NHhjoxWqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwbp-1seT0E124n-004DE8; Mon, 15
 Jul 2024 07:50:35 +0200
Message-ID: <1728bb6e-9dd0-4a2c-be16-41cd01231484@gmx.com>
Date: Mon, 15 Jul 2024 15:20:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Kai Krakow <hurikhan77@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, Oliver Wien <ow@netactive.de>
References: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
 <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com>
 <CAMthOuNk273pZUSU1Npr-Zx7LscBxOsXeyWcQCgbYP=82TfreA@mail.gmail.com>
 <d30126ba-a9fc-44ea-bba8-1f42b242ca91@suse.com>
 <CAMthOuMWvFWNEJkOWQiP2eNwWap8H4z7Gb6qzS8M-WkTUk2=Mw@mail.gmail.com>
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
In-Reply-To: <CAMthOuMWvFWNEJkOWQiP2eNwWap8H4z7Gb6qzS8M-WkTUk2=Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7aHfrUbFYYPoh0QSBDAdesusY1SFHBVKW4HNpj2EPku2EPj0pz9
 FsL7V7Yho4BY3fTPR0dQrwEgreXNGSHikcBDJFTA9AYMnsMgwQsEayROQ4fMSReGNtV39kS
 W0x4fbt0ua+7kchrhiTjJp023vZVl8teqOpH81iayspUY6wC1IX5Kkn3bF7Bb+ggc7/yU0+
 YIljOFq9jHyGtbVG7dNyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IOMAJ5QHgRo=;wBJSetb+RDxfDbA3JD/bZyT/i6T
 GbeydXzuFnVVFJsR824/yPee+qE0hiIsjYSwNXGgW1b3Y484QxWg9G2SvHs6Ruk+azQcGwVz8
 xCCR42cr9Gz0qYqDEZN0qQvztZMxy+YhD6Ao9qcRC9UtMRpMYj2JT8ZTR6o/vQ95eG9wZwSXG
 lSGkfTMNzLkSZd5WbhPc48kTvfTc5aSiSZ+I84GyFYIgB36rMorvY1nc6XfM1ByeMozBCU181
 1DXJ8IdEfCDmq7Ku3SsmbS/rMWhZBCshUjuHDMJJQgQHcomUPiklEHPkXHNswXsUoS5y3+XQ0
 wAoIT7fY0H9rTpqq3YdzikC7hfsacaA08C3HhHz3vls9H2YOUKuxpG9KFABlZOrfOujNhzd8/
 Sul2FY2PozAqt3TaSxcU8lQy7Lg653dUTg+7p4mjOHPw8lu9JcIUD6ezhVlIiw26bxXqFMl8k
 Wqlqc79rjxqWxUB1tEWxJZo380nxsi3KagIw3/5HHXNclv0/I6yS97bJqzGw7ZLbecOl58l3f
 HUxFrZvQVycMfX1zPmJqt04v15LldkTAzZiTG4zM8k5O2NB5YTqFZDnSccCNxL2FyQCcgPYws
 ShD9jwlKoSUl8IJthZv5P4ALn+fV+xVLXBPmJmsNG4b42cqwatBvFx0rL8WPR7diZRc7D+abF
 TmXdTHNQe31vCFBlowocZCBcDrHqloWkQSGvKBfgKLoMoUWKbgsLqcBI00TwOvQ3dCvNjr8K4
 B0VYfzy/05U6XtWxS9HoHbeieg1Jy78sy95JLTDoZiofxDaYtI+R43gBIom18DxLK1p8sPAin
 Vii+Mx6rqKkqV9sljkJ5gx4qL430GcjIOZPs16zlKBeLY=



=E5=9C=A8 2024/7/15 15:01, Kai Krakow =E5=86=99=E9=81=93:
> Am Mo., 15. Juli 2024 um 07:00 Uhr schrieb Qu Wenruo <wqu@suse.com>:
[...]
>> The last line is the problem.
>>
>> Firstly we shouldn't even have a root with that high value.
>> Secondly that root number 13835058055282163977 is a very weird hex valu=
e
>> too (0xc000000000000109), the '0xc' part means it's definitely not a
>> simple bitflip.
>
> Oh wow, I didn't even notice that. I skimmed through the logs to
> resolve the root numbers to subvolids, hoping for an idea where the
> "corrupted extents" are - but they were all over the place in
> seemingly unrelated subvols.
>
> This host runs several systemd-nspawn containers with various
> generations of PHP, MySQL containers (MySQL data itself is on a
> different partition because btrfs and mysql don't play well), a huge
> maildir storage, a huge web vhost storage, and some mail filter / mail
> services containers. Just to give you an idea of what kind of data and
> workload is used...

That shouldn't be a problem, as the only thing can access btrfs metadata
is, btrfs itself.

Although in theory, anything can access the host memory can also access
the kernel memory of the guest...

>
>> Furthermore, the objectid value is also very weird (0xffffa11315e3).
>> No wonder the extent tree is not going to handle it correctly.
>>
>> But I have no idea why this happens, it passes csum thus I'm assuming
>> it's runtime corruption.
>
> We had some crashes in the past due to OOM, sometimes btrfs has been
> involved. This was largely solved by disabling huge pages, updating
> from kernel 6.1 to 6.6, and running with a bees patch that reduces the
> memory used for ref lookups:
> https://github.com/Zygo/bees/issues/260
>
>> [...]
>>>
>>>> The other thing is, does the server has ECC memory?
>>>> It's not uncommon to see bitflips causing various problems (almost
>>>> monthly reports).
>>>
>>> I don't know the exact hosting environment, we are inside of a QEMU
>>> VM. But I'm pretty sure it is ECC.
>>
>> And considering it's some virtualization environment, you do not have
>> any out-of-tree modules?
>
> No, the system is running Gentoo, the kernel is manually configured
> and runs without module support. Everything is baked in.
>
>>> The disk images are hosted on DRBD, with two redundant remote block
>>> devices on NVMe RAID. Our VM runs on KVM/QEMU. We are not seeing DRBD
>>> from within the VM. Because the lower storage layer is redundant, we
>>> are not running a data raid profile in btrfs but we use multiple block
>>> devices because we are seeing better latency behavior that way.
>>>
>>>> If the machine doesn't have ECC memory, then a memtest would be prefe=
rable.
>>>
>>> I'll ask our data center operators about ECC but I'm pretty sure the
>>> answer will be: yes, it's ECC.
>>>
>>> We have been using their data centers for 20+ years and have never
>>> seen a bit flip or storage failure.
>>
>> Yeah, I do not think it's the hardware corruption either now.
>
> Yes, what you found above looks really messed up - that's not a bitflip.
>
>>> I wonder if parallel use of snapper (hourly, with thinning after 24h),
>>> bees (we are seeing dedup rates of 2:1 - 3:1 for some datasets in the
>>> hosting services)
>>
>> Snapshotting is done in a very special timing (at the end of transactio=
n
>> commit), thus it should not be related to balance operations.
>>
>>> and btrfs-balance-least-used somehow triggered this.
>>> I remember some old reports where bees could trigger corruption in
>>> balance or scrub, and evading that by pausing if it detected it. I
>>> don't know if this is an issue any longer (kernel 6.6.30 LTS).
>>
>> No recent bugs come up to me immediately, but even if we have, the
>> corruption looks too special.
>> It still matches the item size and ref count, but in the middle the dat=
a
>> it got corrupted with seemingly garbage.
>
> I think Zygo has some notes of it in the bees github:
> https://github.com/Zygo/bees/blob/master/docs/btrfs-kernel.md

Wow, the first time I know there is such a well maintained matrix on
various problems.

>
> I think it was about btrfs-send and dedup at the same time... Memory
> fades faster if one gets older... ;-)

Nope, this is completely a different one.

>
>> As the higher bits of u64 is store in higher address in x86_64 memory,
>> the corruption looks to cover the following bits:
>>
>> 0                       8                       16
>> |        le64 root      |      le64 objectid    |
>> |09 01 00 00 00 00 00 0c|e3 15 13 a1 ff ff 00 00|
>>                         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> 16                      24          28
>> |        le64 offset    | le32 refs |
>> |00 09 da 04 00 00 00 00|01 00 00 00|
>>
>> So far the corruption looks like starts from byte 7 ends at byte 14.
>>
>> In theory, if you have kept the image, we can spend enough time to find
>> out the correct values, but so far it really looks like some garbage
>> filling the range.
>>
>> For now what I can do is add extra checks (making sure the root number
>> seems valid), but it won't really catch all randomly corrupted data.
>
> This could be useful. Will this be in btrfs-check, or in the kernel?

Kernel, and it would catch the error at write time, so that such obvious
corruption would not even reach disks.
Although it would still make the fs RO, it will not cause any corruption
on-disk.

For btrfs-progs, it's already detecting such mismatch, but that's
already too late, isn't it?

>
>> And as my final struggle, did this VM experienced any migration?
>
> No. It has been sitting there for 4 or 5 years. But we are slowly
> approaching the capacity of the hardware. What happens then: Our data
> center operator would shut the VM down, rewire the DRBD to another
> hardware, and boot it again. No hot migration, if you meant that.

OK, then definitely something weird happened inside btrfs code.
But I'm out of any clue...

>
> I'm not sure how reliable DRBD is, but I researched it a little while
> ago and it seems to prefer reliability over speed, so it looks very
> solid. I don't think anything broke there, and even then 8 bytes of
> garbage looks strange. Well, that's 64 bits of garbage - if that means
> anything.

Even if it's really some lower level storage corruption, it has to pass
the btrfs metadata csum first.
You really need a super lucky random corruption that still matches the csu=
m.

Then you still need to pass tree-checker, which doesn't sounds
reasonable to me at all.

>
>> As that's the only thing not btrfs I can think of, that would corrupt
>> data at runtime.
>
> I'm using btrfs in various workloads, and even with partially broken
> hardware (raid1 on spinning rust with broken sectors). And while it
> had its flaws like 10+ years ago, it has been rock solid for me during
> the last 5 years at least - even if I handled the hardware very
> impatiently (like hitting the reset button or cycling power). Of
> course, this system we're talking about has been handled seriously.
> ;-)

And we're also enhancing our handling on bad hardwares (except when they
cheat on FLUSH), the biggest example is tree-checker.

But I really run out of ideas for such a huge corruption.
Your setup really rules out almost everything, from out-of-tree (Nv*dia
drivers) to bad hot memory migration implementation.

I'll let you know when the new tree-checker patch come out, and
hopefully it can catch the root cause.

Thanks,
Qu
>
> Thanks,
> Kai

