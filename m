Return-Path: <linux-btrfs+bounces-7532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A22E95FDBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 01:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C95D1C22505
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 23:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2862E19CCED;
	Mon, 26 Aug 2024 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iRO4GO50"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A580027
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724714337; cv=none; b=umx24SaiScNSgmqK43Nb18KdJ0GeGXESmet38FenzgiF9rvjdKCyjY0MLpk/HKJqjOW9ZDyLYpvwkc1J2Sd1dL1winxTLkdW4tEY5/eEdntaJAgOUAhXACUWoRPxBpypXz8ISAb7H3oN8J6eRH7BzvWBMez0/orTe5M95Iwd+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724714337; c=relaxed/simple;
	bh=aOZ8rBFEO/5cqDuRw9fQjtPw9ImePl/3ZZ7Sohj3yMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UCP6XOr5tl9hURLzn3PcCynJ7yDOLpxBsmkl69p/ggU46RwOiVDqyj7lFwUApvQBHF/GeZz7ngQHU8ZMYTb3/xfBdQVGr2NC1Kz6a3gwi4K4YnaKEHjbN7ywcAR/k7qNL7brYP0PJdDMP7kSJVJDFRtqF8gvFar3IxkeDcVmxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iRO4GO50; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724714329; x=1725319129; i=quwenruo.btrfs@gmx.com;
	bh=HKeHcTh0Hhg+VHGw1+TJs32hdu9Au9BxZGlIAZcXTLI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iRO4GO50DvtgkOSYfHDVXAoDSB24b2+e6Ch6TNgL+InWcEvvzqTXeXdRDIG25wPX
	 GaePbAq3SxXqllGBttGDpIT2jtaqSDRPujxBEu3gcrd2xMgGNiaVGvsJyblWW+9LU
	 YsxvdqY61gn1R4ZcYC8MruaMYmt4ANUBo/2xIQJL2eJi9ROFaDQpBt17/fnbBkZpp
	 mYSjnr/iDjdehYBiyOsmYPJUST9FfgJTP7a4hnlF5tC+JjD2LygyNqH1xJJ4lrNvn
	 TPbSueVOVPBDqb96KKMTHsptNRsLlnPhk/cal6qaSKumPV2L6wxfETtce+/v5tyJm
	 3mREVu9qVm3RhQKVYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLR1f-1sRTDO0QFv-00KQMt; Tue, 27
 Aug 2024 01:18:49 +0200
Message-ID: <012717c6-4e7e-44e9-9906-5f13e4273c35@gmx.com>
Date: Tue, 27 Aug 2024 08:48:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
To: Pieter P <pieter.p.dev@outlook.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
 <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
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
In-Reply-To: <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jum/qjcineDyDOJW0o+ExHwfmLfXudD74U6UGxf0bfS7JYMeYgJ
 4qp3OShh27jriRu9sHLqpsJ6YviHrWqfFR/1YGxuoPCZnr2ivihZf02PE8eEO7lXmsjgQuJ
 my/LuCMuFaQuWERKuWor1vOb03TjeW4dDNrirQ+9uAdk8yiwRKVWbMOvvY4XPF26SEb/3Zq
 4y5/YGIXJsNkqrMg3rv0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S7/rx9x4jig=;M/uVDpyrUmK7WBc+ghV7R8nNrhb
 3v3qk7ri59KKmEMcIRFehJbAdcExcvXRCRFls59S5Lt9mNpQhEzFIZb7KZusdyS1TvTiEzI+G
 kynbeE5NpDCL4GMhQMS+xMfOgz0uQYPSDo9KjqjwN+SAQvaBj0PQ/oW1laQArTOKz7odR/hc5
 sNMhMXCyaU4HWSVEs7rgKkr1H5fFpA3Ffc2V6pnTqjk1GU2bEd3e0nJLKIK84b8arfRX6UzCb
 z8FCiBJeTtD73cULcvGFhguwiPVZ+QkiUYxK9N16QletoQA64D/Gpfby+GsPX8mgM5GjiP7w+
 OlrS/teslBkkSCLICaI/va6FigDMbPaUg377oF618hD8e6LOGdmF+IoCl6dCUIpTQ6QJPux36
 72skixcxIaG2E72GUfVNZIVODQ0+w2JQ1Avc30M4re0dfYBbszdmAlXzDKMqBtJLDQy4qu3Sa
 rtLhkCGH54HpJA1hxRnXyoWqz2UgkbVQiiqWEXKikECmAEZOad2zaZ291Gwsg4KtguHjQm1pN
 9/o+NkwZX0UB2zqWKQajt2tszNvCQCMyb5aqTfQnIueHOHmLouqCCBTt1ncCau+wt8a5AAkYr
 sc0qzhoL5v0GKzbbYyx8sMZ5y9UKugv0i+TbLau9gty+Mjhktm6A3Vxb9KthzKvibBNROBZSr
 yh/wsfEi19RdLbTGVWNNAdHRp3JFuPYQQzyBF/jqkxUeBhnUEwMxiSYpzSs89Dtgcvxutm0df
 2PtuiMKaschVvaVkEoNw/2x2PQgr09MwKKJCNKbFYQKVL8OiJmph6u3zdLnkdFBeVRNn4IrUN
 7qXzf2qFrvCMakmZte+gv8mg==



=E5=9C=A8 2024/8/27 08:34, Pieter P =E5=86=99=E9=81=93:
> Thanks for the help!
>
> On 21/08/2024 00:55, Qu Wenruo wrote:
>
>> And in that case, "btrfs check --mode=3Dlowmem" output may help a littl=
e
>> more, and the same for "btrfs check --repair --mode=3Dlowmem".
>
> I've attached the output from both commands, unfortunately, that didn't
> fix the issue.
>
> Subvolume 257 is my /home directory, and the broken inode is a temporary
> file in a Chromium cache folder. I've tried deleting and overwriting
> that file, but this causes the file system to go read-only a couple of
> seconds later, and after re-mounting, the file re-appears. Reading the
> file is not possible (input/output error).
>
> Is there a way to restore the file system by simply deleting this
> inode+data entirely?

After your latest --repair try, the fs should be more or less fine, you
can try remove the offending file.

Just a minor problem left with the superblock used bytes, that can be
fixed by another "btrfs check --repair" run very safely.

>
>> If above lowmem mode still doesn't work, I can craft a tool for your
>> specific corruption if really needed.
>>
>> But that will need the dump of your subvolume 257 inode 50058751.
>
> Which data would you need specifically? How do I get such a dump?

No need anymore, the latest result contains the all the info I need.

>
>> Unless the system is using ECC memories, I doubt if that diagnostic too=
l
>> makes any difference.
>>
>> If there is already a strong indication of bitflip (and yes, it is), a
>> full memtest is highly recommended.
>
> No ECC memory, but I did perform the "thorough" memory test using the
> Dell diagnostic tool multiple times. It included data bus stress tests,
> march C- tests, ground bounce tests, random pattern tests, and some
> others; all passed without issues. Since I haven't noticed any other
> problems (the system works fine when booting from another drive), I'm
> blaming an unfortunate cosmic ray for now :)

Unfortunately it's indeed a bitflip, from your latest lowmem repair
result (which mostly solves the problem).

 > ERROR: extent[2216718336, 4096] referencer count mismatch (root: 257,
owner: 50058751, offset: 0) wanted: 1, have: 0

This is the original extent item, which looks sane to me.

 > Add one extent data backref [576460754520141824 4096]

This is the one to be added according to the subvoluem tree. The huge
value itself is already a little concerning.

Furthermore:

hex(576460754520141824) =3D 0x800000084207000
hex(2216718336)         =3D 0x000000084207000

It's an obvious bitflip.

Another possibility is, the fs is old and you just migrated the drive/fs
to the current platform, but I doubt about the case considering the file
is some browser cache, which shouldn't be that old.

Just in case, mind to try something like memtest86+ (UEFI payload) or
memtester (inside the OS) to rule out the hardware problem?

Hope it's really a cosmic ray, not a persistent hardware problem.

Thanks,
Qu
>
> Thank you!
> Pieter

