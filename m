Return-Path: <linux-btrfs+bounces-2337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 412A085222E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 00:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0A7B23939
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797A50A66;
	Mon, 12 Feb 2024 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nlgNinP+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8781450A69
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778849; cv=none; b=gZaNCKt3hEvQxEzXl8aEiO/l0QMKv2ecNFih+lJtci136HCN9zOjDuXeugD0SucBDdY2Zqp9xcay7rcTicW+MCgjj27/PqVXrCRgTYG9sj/SAc3htcvXBXkFsHR/70JvA66QmFgZBTdpcwMfkAlDnX/KyGwMe9tVuuLxKfqSjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778849; c=relaxed/simple;
	bh=th2GWYSPuBQICJTa0upLNLL5V8b6vgiwGlna3Ilqlmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naxo3n4dJgSquOMp9JoIl57HzUACY410W2pjY0kuReZkyrVpWjl4ebTiavPbXN+QlhuxdxSNwsQrUAdQs4bTCrB3TmOpBLy8JwTv6WVB6JiF9Z1jn4NKJEWXzwWUD63R46LUiC9BuYMM+Irw8snwwLAy27tvOHOBIrixa7mEh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nlgNinP+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707778833; x=1708383633; i=quwenruo.btrfs@gmx.com;
	bh=th2GWYSPuBQICJTa0upLNLL5V8b6vgiwGlna3Ilqlmc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nlgNinP+F/TbHYS49HP5VZvT7tkd6PVQabkJ+fsuJbobxp7J8ndOHxtTalLSDImL
	 omGKV4jh6kWTtZImN1dlrM2H9JwsulFewddWCFDpt23KZFMGxaLxwDgwydFZQDXDB
	 Kiphe6i7OTDUrEqePr0ituBLidbCdZJQCCgM9JPZc7pGqWcyeiIS8GDY9nYp1WQiN
	 f91z8/UzcLEzoFiNNaXgkMCHNFgRfEDBWTgIdCjrCBG7vlSogJlc9fQcJVKcnkWMh
	 gKffHbfzv4fDODWjZu02+4VucCnWd4yKTmLKIQcH3yEiz/qdd8R8I9WN+jV5rj04Z
	 afDfReM5qzM6+YcgtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1rFwa03ATo-00Jq1f; Tue, 13
 Feb 2024 00:00:33 +0100
Message-ID: <05842b57-d01d-4912-b505-54410ce49b23@gmx.com>
Date: Tue, 13 Feb 2024 09:30:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: mkfs: do not default to 4K sectorsize if the
 fs is zoned
Content-Language: en-US
To: Neal Gompa <neal@gompa.dev>, dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <f679cbd1b09fff494b58f37520a9ab727c3ff313.1707716170.git.wqu@suse.com>
 <20240212120708.GB355@twin.jikos.cz>
 <CAEg-Je-XG5F1Tx=XqRQdL7MYGon_F96vRtZia_qyah=J20-jwA@mail.gmail.com>
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
In-Reply-To: <CAEg-Je-XG5F1Tx=XqRQdL7MYGon_F96vRtZia_qyah=J20-jwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LjSYETsvRsjsFb+TC7467MWm7i/oflehkDn5g5wVaUi5biSVcyC
 xhixf4KLoVGc9OUCLpIvrvdihipgiV9dD7u8Ane6LTzNcI64mvb+wDff8iFqnUVoZGwlByG
 WckdfzSU1NIJ0oTIwcjdwWEOz9w5MJBp4M2eJopprGg/qOBUjkRyZ6NP1TbmSRzFrL0RrF/
 4AxYdpPDpJYkDo9Zx5aHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y9rP0/lvm/s=;Xm/9M6ZuULlEq08ClWDDn2Lm0+P
 Qqh72morYYEpeT2P7L48JQD1lPjC+vMjyNzP0PLtY+6A4DZVgZX2RzI8XTYXBVOoKpv9mNYAH
 CadUrI2yOE1hitsOO9Z/3M0yMlsgj+gMdFym4itlFZtTw4TTV5gRYM6bz0ciC+HsSwnq/39kz
 QQZ5CkMT0VEVJVjBX7En3FpT8q2oRAqMyTOSQnzxEf/ZsaJVFPYApCsK+ImgpYqIh3IziXMHG
 RY71OIanhC6d+uIJddD8OKkBGfQj5n/Ok+bxfB1qcC5fV7wF1EHlnQAqsgyNZsBMnMNVLRZL3
 zmViV7PGVxLyMYcWzbszgp6XZDXszx0DNze5ywk99XS6w2iodnvlMEjnULgrxPbcpZ1mZIBwM
 kJoJw7EsDZ/UxDijHU8ErVo5B0sR63ImnTAjtjjE7N/dgGZXVIZxG8OZxt+ngfRx/ilTn6Kh1
 Xr8EH8FQ3i2yjByQ5AS023+pSUjgRF73hwORRs4/BWcOw1ZK4kVCAtbi2bpf3LDNCO7zoLUGN
 5dfKMN6zsQGDftJYAjTQ9faUouX2K0PYBer4BhxsBcOMgb2G0/qpnJKwG8bOlwCmg51uJIzL7
 BlpKSB+3GUpKpc8n5yEHYT4y2SjRfAn+6gLWV6u9Mr8+4Sea1D2CLNlCn/4cDdEbW4MHoU8Ih
 lsbr5cez/R3VMWpW3rbuzFtAQ/xrB0bcEY3bzFk2ZBLyNqlFlYVVk6XjkCvO86u+Er4LTscER
 +vwjzB3hT2dOaL6xT5zlft8IwQ7wpbZjoRvhLcrxM16KxVTby9xrO6UFPfGDKjtwJSqwi/b8S
 El19Lj/nc0tfX3RaDZo9nprepC0nIAk+ajZLa9k2Awntc=



On 2024/2/13 01:25, Neal Gompa wrote:
> On Mon, Feb 12, 2024 at 7:37=E2=80=AFAM David Sterba <dsterba@suse.cz> w=
rote:
>>
>> On Mon, Feb 12, 2024 at 04:06:30PM +1030, Qu Wenruo wrote:
>>> With some help from a reporter using loongson (with 16K page size), an=
d
>>> a zoned device, it turns out that, zoned code is not compatible with
>>> subpage's requirement.
>>>
>>> Mostly conflicts on the multiple re-entry into the same @locked_page
>>> using extent_write_locked_range().
>>>
>>> The function is only utilized by compression for non-zoned btrfs, but
>>> would be the default entry for all writes for zoned btrfs.
>>>
>>> So we can not default to 4K for subpage zoned combination.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   mkfs/main.c | 32 +++++++++++++++++++++++---------
>>>   1 file changed, 23 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index b50b78b5665a..f54c1a055ae2 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -1383,15 +1383,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>                printf("See %s for more information.\n\n", PACKAGE_URL)=
;
>>>        }
>>>
>>> -     if (!sectorsize)
>>> -             sectorsize =3D (u32)SZ_4K;
>>> -     if (btrfs_check_sectorsize(sectorsize))
>>> -             goto error;
>>> -
>>> -     if (!nodesize)
>>> -             nodesize =3D max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_N=
ODE_SIZE);
>>> -
>>> -     stripesize =3D sectorsize;
>>>        saved_optind =3D optind;
>>>        device_count =3D argc - optind;
>>>        if (device_count =3D=3D 0)
>>> @@ -1470,6 +1461,29 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>                features.incompat_flags |=3D BTRFS_FEATURE_INCOMPAT_ZON=
ED;
>>>        }
>>>
>>> +     if (!sectorsize) {
>>> +             /*
>>> +              * Zoned btrfs utilize extent_write_locked_range(), whic=
h can not
>>> +              * handle multiple entries into the same locked page.
>>> +              *
>>> +              * For non-zoned btrfs, subpage workaround the problem b=
y requiring
>>> +              * full page alignment for compression (the only path ut=
ilizing
>>> +              * that path).
>>> +              * But since zoned btrfs always goes that path, kernel c=
an not support
>>> +              * writes into subpage zoned btrfs.
>>> +              */
>>> +             if (!opt_zoned)
>>> +                     sectorsize =3D (u32)SZ_4K;
>>> +             else
>>> +                     sectorsize =3D (u32)getpagesize();
>>> +     }
>>
>> 6.7 did the change to 4k instead of the auto detection of sectorsize,
>> yet this adds the logic back. I'd rather not do that. We had
>> compatibility issues with zoned when some of the profiles were not
>> supported initially and collided with mkfs defaults, so I'd rather
>> exit mkfs with a message what works with subpage and zoned.
>>
>
> This should also be an impetus for zoned to get subpage support
> working, which throwing an error will hopefully do.

It's too hard to reliably test if subpage + zoned is properly supported.

We only have a simple supported_sectorsize from sysfs, which can not
provide good enough granularity to distinguish zoned and non-zoned.

Of course we can unconditionally throw out a warning, but if we add such
zoned + subpage support in the future, we still need to determine if we
need to throw that warning again.

Any better solution?

Thanks,
Qu
>
>
>
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!
>

