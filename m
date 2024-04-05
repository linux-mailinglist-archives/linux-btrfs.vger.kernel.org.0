Return-Path: <linux-btrfs+bounces-3985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78389A61B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 23:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A75A1C21451
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953C17554A;
	Fri,  5 Apr 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RW+OKQFD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A427174EF3
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353020; cv=none; b=O+y/1FCOrQYq55rArG87nbwpa42r6ZwL90MUL+5r80Bkb4JZaoiPi0RtaGncRn9br+qBD5IWdjPyyrHaXTdwSbsMRZ3JwrbnaO1P4KKuHTFSnpeqL1ntC4jBwGn/KlRP0toQL828SxioMQt69tivBWlfpRJJSfo7iWS8Sb33kXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353020; c=relaxed/simple;
	bh=CDUHDFBvKt7mCK3wpeUYr96v+KrgpXs2lsUofeU8nHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdvuNHMCOePmU/4WKF0q5e7CFcI+nwihv+P5UIwGT27L6H+e+8lrD6qtdk8dtTmQbvcvM3TGGLjBTIOoMgURJzsVZxyCg6Zgx/q2VqntKsA484mgqY26yhiwCiW4VhzzV9QsytmSJ9kvdGPWQuYO3w7CZx50sliuCe4/kG+zT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RW+OKQFD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712353011; x=1712957811; i=quwenruo.btrfs@gmx.com;
	bh=k8m1PTQ1o1rn+xd5S/qAlgemDR7R9re3cN2ndtpwj7Q=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RW+OKQFDDCR21amWeO2xWyGcA1+TuU9mkFXsxKn9eraYKaHJGBHCKplppGNIiRHw
	 rg7DdoeWQWxxQVlIlwtKD2cJqadPm2hfmAWplTaqUgHtvBJ8Sarm+1W34JcQ3cg9J
	 QKCUAI2XW33EztZuNT80Y2lKvci8v9JhuoVR0CvXh60T4ei3rk3oD/Cny8bPUWlpw
	 dEbQtrHe1hZ9n2PECqyhY8oVMLpXCbJE0HFdwqfGqrOFm4PDYR9szzi5aCeGc6O91
	 QPJZv43LQC7YuZCBn019INxbi4YJSias/OzeSNUoOPKv619Br4I/BHFKgZcMZqI9M
	 iuQtw2NUIXDdq5bFfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mnpns-1sZJWK0zBS-00pPGj; Fri, 05
 Apr 2024 23:36:50 +0200
Message-ID: <bbc9acb4-a8a3-4fde-9e55-6b49a009dc00@gmx.com>
Date: Sat, 6 Apr 2024 08:06:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] btrfs: add extra comments on extent_map members
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712287421.git.wqu@suse.com>
 <261cf7744120a2312ce2cdb22dbbfe439a11268a.1712287421.git.wqu@suse.com>
 <CAL3q7H5-2gfkd7xjy9QVrtgDZGv34jhQrTTtuNL8Qs08rNimrA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5-2gfkd7xjy9QVrtgDZGv34jhQrTTtuNL8Qs08rNimrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M6yXVL/+CCfTLD+OUU2TkaUwayMn+p/PT1VqRi1Omf3QtbjBxRy
 ir6mcxlO0VFSp5xkNuBrcMqn8c+JqhcFw7jw8mDD27Qcr230zLg/hpyKURz89NxSwtAC9fI
 TDYYEHZXkuT/PWy7x4jzaprBJnfHCWfsge/Adoa8gDiPRA/0UpJzZ7OG/aujvDNL/1i50Y4
 lIP91BSnaXnPr9rmpnaVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jOFC+JcVoR8=;EARlXqJ4vsSsOMFDeXK07mFX0yb
 AivdHV46yiXKDnGmoCwn77VIf8GOOAcNZmSwsGfon1CLGb9PQCykmUsUr+MFfgNqBDPsLCKwc
 T6PXo1Rwg364ESh1jSMWi7Ri77goto2mkGdNXqnHkeURJMop8OCqhsIzF2LDOrQQ4ZES/4SCc
 KG3ajuDxGNnRHGDGvGLpn6d/hw6oIYgq6vETeRqTvfs1E0xI85kmx+wcoCS5cE8YgAhL805B8
 IH6Ek8rv/lfcu8w1Kx0Quevfi7GeYEjQGgsitDZRMoBCCC64uTyfAO/64bGdZXMrMfVyXRl/Y
 tuBCkaly7P0B3n0vswpV+KHpbKf4iME2ALGo7400whPV0XvrUYGPZ6/io44P5AI8o13/zWB72
 cQeEeWO4fP6HTa+iyXtZUoKOu1ulOZR4OvulVBxsANHkltf6dSvsdlSgO2o0adCrmxGiYjRCP
 MX1BPxUXsXRFBeKa+LMcKqiAZmtAPUOJScYzLjAGpNv5c3XwTYo+skIMBmguwiyW8sO+P1Tex
 z1J3uycB0DHjEIh2V/kJ980+8OfyC+PcMQFIkp6NnvNXndATvVDDmOaE7q9NAZC02r7SDKSVG
 zBxItW43fjANpSvOUXrOzbP3YEhc49RbiqgC5mTFDmJpiYIFRY4RAWFqqPhwA7wyTmfBDEFqD
 syQaRLBq/Cg/INanKnMyXrEr5bV0AthdC41I30SQy8nvUcfw5B2GtmftHy5D5CsdRCkOuOMyO
 aYZu1sTvKRF4kK33Sc1OFjhaLpmUcWhWrKnPSNkpP8i7162+g31jYZuaxec+H0fzxSiynEOxQ
 ZM8b2T1CX3Jk7wfPygL2NPjbMVCZ9I2x1Dky7Mbyb5nhg=



=E5=9C=A8 2024/4/5 22:54, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Apr 5, 2024 at 4:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The extent_map structure is very critical to btrfs, as it is involved
>> for both read and write paths.
>>
>> Unfortunately the structure is not properly explained, making it pretty
>> hard to understand nor to do further improvement.
>>
>> This patch adds extra comments explaining the major members based on
>> my code reading.
>> Hopefully we can find more members to cleanup in the future.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_map.h | 52 ++++++++++++++++++++++++++++++++++++++++++=
-
>>   1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>> index 10e9491865c9..0b938e12cc78 100644
>> --- a/fs/btrfs/extent_map.h
>> +++ b/fs/btrfs/extent_map.h
>> @@ -35,19 +35,69 @@ enum {
>>   };
>>
>>   /*
>> + * This structure represents file extents and holes.
>
> So I clearly forgot this before, but we should add the caveat that
> it's guaranteed that it represents a single file extent only if the
> extent is new and not persisted (in the list of modified extents and
> not fsynced).
> Otherwise it can represent 2 or more extents that were merged (to save
> memory), which adds some caveats I mention below.

In fact I also wanted to address this, especially if I'm going to
introduce disk_bytenr/disk_num_bytes, as they can be merged, the merged
disk_bytenr/disk_num_bytes would not exist on-disk.

But on the other hand, it's a little too obvious, thus I didn't mention
through the whole series.

>
> Holes can also be merged of course (e.g. read part of a hole, we
> create an extent map for that part, read the remainder of the hole,
> create another extent map for that remainder, which then merges with
> the former).
>
[...]
>> +
>> +       /*
>> +        * The full on-disk extent length, matching
>> +        * btrfs_file_extent_item::disk_num_bytes.
>> +        */
>
> So yes and no.
> When merging extent maps, it's not updated, so it's tricky.

And that's already found in my sanity checks.

> But that's ok because an extent map only needs to represent exactly
> one file extent item if it's new and was not fsynced yet.

I can update the comments to add extra comments on merged behavior, and
fix the unexpected handling for merging/split.

>
>>          u64 orig_block_len;
>> +
>> +       /*
>> +        * The decompressed size of the whole on-disk extent, matching
>> +        * btrfs_file_extent_item::ram_bytes.
>> +        */
>>          u64 ram_bytes;
>
> Same here regarding the merging.
>
> Sorry I forgot this before.

No big deal, as my super strict sanity checks are crashing everywhere, I
have already experienced this quirk.

So I would add extra comments on the merging behaviors, but I'm afraid
since the current code doesn't handle certain members correctly (and a
lot of callers even do not populate things like ram_bytes), I'm afraid
those extra comments would only come after I fixed all of them.

Thanks,
Qu

