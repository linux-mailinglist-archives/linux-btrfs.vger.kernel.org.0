Return-Path: <linux-btrfs+bounces-4136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B608A0B99
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 10:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A93A284001
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0A1419A6;
	Thu, 11 Apr 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HyhgnJan"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6F13DB8D;
	Thu, 11 Apr 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825356; cv=none; b=tYD2khx7q/n57DP040HOzL4yCO6dJUcZYPpJTptjlIxUZ7EbTC8LEONf5k00Vb0QjQjyaNdOSUAqu1URjQDuD9/FywMkc3EdDyckRHqeERVlGvnmZUhRhCGkl7SltUViPhN0krWQVuJR4JuuU/wd6HkVjpO/sBotutlZOJ01NZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825356; c=relaxed/simple;
	bh=tjWqFJo2pagpKUsxJOdjR2FFG43tpZHbRkhyNNaMKsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAZCvFUl+yHVscdyrJz83tajGG7DzeHS1Q75ETw3V69RpudegzdlGAXGDTFrK0iTNbWfERkwYEAsbrjAYwwSbv0wPZO+W0vnrokwGIS0ykOxAkLoIJDyhvOrBvhdvS7AlfJndDt7nMpldvFOmLRKh2o8EtDrq5RnHCR5NyO3Bj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HyhgnJan; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712825347; x=1713430147; i=quwenruo.btrfs@gmx.com;
	bh=v+3ZBVk7QveFXkR/fI84unXXsmSPL1P/WHl9lk4jRWg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=HyhgnJangCZpGpjC8ko5qDu3dQjsdSiUuqHBf+T+m8nqnr97j1KIeBdJPBzcbhq5
	 WPylmlMt8wE/h2yfIoaBn0BLkbY88f0r2RJyVZbJFcMlDwm6vu6S6a1Mgah1UPlX3
	 NXdFDIcZ9ae9ZlfRu0HGvAJqfIR6ifoYzrlIWs2qDw+GX0/4SOn/ZSWAVlWTbIrh3
	 o8faN5ZOdrD7Xn/VLE0EvdNPprgQiYKYudSCM7AyRpEj7B0AJ4KdORqL3DQ0wrppE
	 T308JjjI34V0qnbZZfFWEOS7A4EUNIdv9Vj3vbpuBO3+CwQEKWSsOtYjS7AkDTZ/6
	 bXzr5r3gRbkUEamvBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGRp-1s8xIM0Yqz-00PgNs; Thu, 11
 Apr 2024 10:49:07 +0200
Message-ID: <ac9c80d0-bc78-459b-aa38-4f2b6ed34b65@gmx.com>
Date: Thu, 11 Apr 2024 18:19:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
To: Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240406051847.75347-1-wqu@suse.com>
 <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
 <20240409111319.GA3492@twin.jikos.cz>
 <f113ab1f-58b4-453b-a6eb-7b4cce765287@oracle.com>
 <e9576dfb-c3ce-4adc-bb32-f7efa235907a@suse.com>
 <20240410162635.GN3492@suse.cz>
 <d756b8f2-5f55-4482-9a83-e2ab740e11ed@oracle.com>
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
In-Reply-To: <d756b8f2-5f55-4482-9a83-e2ab740e11ed@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tNpz28qij0LGRKSkSL11RSc0xOXF3ZQci2B0YAOWKPswlvhQ9cn
 beSgpPxWQgco1GPyl6WvoLNe2Y2QpPXv4yuCCMxRWsJVmYisHIciKndDYYrI99B89x0WW37
 DMhUideZawZpXHeUft+O74uqO/V3sZQ7TvOjwTdAmtkgWEcM/1HLxn8zwLxx9bVn4yNdMgt
 8WmpD5l49E8u2ckmaN8sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wirs3ct0wd4=;BlXyrrT8kB2FTWfJZFF+T0bACgw
 pAiw2HsFhKDNLmPUse9RoNs92VDWl7Qe1TqY60pvHduqYYQXHCZESen8Y3gnS+L5BHu3Zp8IA
 Nlcp07+vatUMWa660ijEQe2hx3Pjt/ypMPcV5i6H50j4NeJ1EKlBEZ4FH1GYdXuoBqtQtiuoy
 P7Jm1a9SFNAMi5fMX8G3YqWygezbs3YdW9iAvCCs4TS56pnJC4eORKc5bPBHFAN/Uf9xy2bFl
 FmeYTR7jBlsuOqNjkyKR9hZp4VkumehRABNRgPy2Tg4y/1yWIbkJQ27ZKKQ/YvHxI74ojSLWd
 Tj2xpdcdTj/KGSHsg96KTCLi+Hf26VMdocexNtQVvI3o204TWjz4TRdEuiM7dhmKX4eeJKZdM
 YpZbj9vt13CRJoRddzEBk2ysQBk61R4RGlNOeNVK9tI32GzHKGtGfyOtVDwU8nhY5vvekBY7B
 4sxYtMyzirWAOuAntz89/95eo1+Woww7YTtFVREz1QSZk5YuS5iYInTTUUBGNXqfYxP4jBjwR
 Pardd5aA9oXGA+YRSBaUU1FZ5JCzxIEH3GjhyVrPk/xhlZAS7jyui7Qf/DKDgC0+MHGHaxdGH
 ThanDJd6RUpfMzgnnhdXpAneqP/5NTPgOM4jtG9xHLkiEjlCYtaYE2V2MhOSz92/AaukkFdSo
 V6QQfp71IAi6hej+2k4jrbpa1gI3KzNOwAHtGsYSifNltLaYpb5jEf3BWoZDVhLt5T7QPVJu6
 jsgocYmBoU1CAQ5pV/SduA0apBncQbW6uAgj6xMEQy+GJaKjCP5wPydkEeFNyDwcC8wthjZoO
 KnHcxfIptBhY2NIMwFxlq1lQoLljb6fcaUd/Vpd8820uM=



=E5=9C=A8 2024/4/11 18:14, Anand Jain =E5=86=99=E9=81=93:
>
>
> On 4/11/24 00:26, David Sterba wrote:
>> On Wed, Apr 10, 2024 at 03:18:49PM +0930, Qu Wenruo wrote:
>>>>> What past discussions favored does not seem to satisfy our needs
>>>>> and as
>>>>> btrfs-progs are evolving we're hitting random test breakage just
>>>>> because
>>>>> some message has changed. The testsuite should verify what matters,
>>>>> ie.
>>>>> return code, state of the filesystem etc, not exact command output.
>>>>> There's high correlation between output and correctness, yes, but th=
is
>>>>> is too fragile.
>>>>
>>>> Agreed. So, why don't we use `_run_btrfs_util_prog subvolume
>>>> snapshot`, which makes it consistent with the rest of the test cases,
>>>> and also remove the golden output for this command?
>>>
>>> For `_run_btrfs_util_prog`, the only thing I do not like is the name
>>> itself.
>>>
>>> I also do not like how fstests always go $BTRFS_UTIL_PROG neither,
>>> however I understand it's there to make sure we do not got weird bash
>>> function name like "btrfs()" overriding the real "btrfs".
>>>
>>> If we can make the name shorter like `_btrfs` or something like it, I'=
m
>>> totally fine with that, and would be happy to move to the new interfac=
e.
>>>
>>> In fact, `_run_btrfs_util_prog` is pretty helpful to generate a debug
>>> friendly seqres.full, which is another good point.
>>
>> I did not realize the _run_btrfs_util_prog helper was there and actuall=
y
>> the run_check as well. I vaguely remember this from many years ago and
>> this somehow landed in btrfs-progs testsuite but fstests was against it=
.
>> Using such helpers sounds like a plan to me (with renames etc).
>
> We can do the renaming part in the separate patch. Qu, are
> you sending the revised patch?

Sure, I can prepare them pretty soon.

Just to be noticed, if we really determine to rename
`_run_btrfs_util_prog`, it would be pretty large as there are tons of
such calls still there.

And I really hope we can get a good naming before doing the conversion.
Updating it again and again for a different name may not be a good use
of time.

My candidate is `_btrfs` or `_run_btrfs`. Any good candidates?

Thanks,
Qu
>
> I use run command in some of my local test scripts it help debug,
> switch on / off the output easily and verifies the success return
> code.
>
>  =C2=A0=C2=A0=C2=A0 https://github.com/asj/run
>
> Thanks, Anand
>

