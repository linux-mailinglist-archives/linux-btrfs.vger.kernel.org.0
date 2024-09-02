Return-Path: <linux-btrfs+bounces-7720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955E967F86
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 08:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3D6B220ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 06:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505BF1552F6;
	Mon,  2 Sep 2024 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="I8XKNSIx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1014E2F5
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258854; cv=none; b=KyZVW1PNjJVu7SAN9vy0A4E02UVzlgF/FpqVp0dbZhf9XPHbRPERho3voBns9V16a63mx+xyyUq2AKEvKi2g9mQ3AOfaw+nNv9e958QjJnwQFhuhiYOeZoxeYu8zw1GOc/aTenmUGc4MN3yhO6jNQJMgjK29DPfRWh1KsElVkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258854; c=relaxed/simple;
	bh=nmvuH5bf7wFnnWQ0SFy6yMYck1ucaWJ9Josf8UnrQmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CgCqRu5spKeNwpfLD4pSrYpY+mGRQDyBjcc+HywJoz89W5u6TeHlfpG6YqckfEbnfUQG2AqAQyXUvqMIBWE38e9vZ/5NAcu6o8BmdG0vUYU8royF1CVhLv0N9309LoiZYpP0uwWukCvZIniPPSrADp3ZR7Neawpipd1JBHZ/tMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=I8XKNSIx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725258788; x=1725863588; i=quwenruo.btrfs@gmx.com;
	bh=nmvuH5bf7wFnnWQ0SFy6yMYck1ucaWJ9Josf8UnrQmI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I8XKNSIxj+WY13UV/X0Mt8RSyt+uUK3vnM8GrxjxrZ1DGwb9I9YpXThCmwmhIt/I
	 zMVrh/acho1q+HKzXwYu1OhWCkZdjSqX6W7xSUd0yeRqTqCuIwbDxBddJe97qYo0n
	 ZpxtJCKTtE4g78wGLMN7w4jjuke3OKWdiN1+FePWpODQOi8/ob2o7PuGWdLn9qzmI
	 CbaBF2yXMDEzow1YFqkrX+X1VfJW9wnM9UbINsSJhUeMfKpcxdcSX0QYa1fDy/n8x
	 k8mZfqupm2aDwrbcO66fWqYw4jwpxKFGkjkQiWFsI4MLnq3Ov05m3SBRRNrK+PAGw
	 WQDvyi9zlYfm3oZ4KQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6siz-1s042F0DNv-011Z6L; Mon, 02
 Sep 2024 08:33:08 +0200
Message-ID: <b2f812f0-567b-4faf-ab0a-7503f427c034@gmx.com>
Date: Mon, 2 Sep 2024 16:03:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Corrupt BTRFS can't be get into a consistent state
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com>
 <c06d4a06-589a-428d-a50f-93e29254976e@gmx.com>
 <ce3a4dbc-4e81-4b05-b9e5-c92eec9b5d80@wiesinger.com>
 <c70ac7be-c670-4b89-ae8c-bd34fb505997@gmx.com>
 <2a4a6f58-da36-456e-89b1-dde0a7b4f5ea@wiesinger.com>
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
In-Reply-To: <2a4a6f58-da36-456e-89b1-dde0a7b4f5ea@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3cbstjV/rEcl14IuEFXtrBKfxvCPkpHNtYkyeh6KiavaOdwpPG8
 Z+tdG1QKbw6MLH076EU6mxU9LB736n6owDeZrSDzVmiOrj92j5mGza7nZagWAq0L80k8t/o
 BE9vao0jOF6pIqkkMlPpt0zTUI97b2h7IFUatTDv8HtaMyzNLnMT1ScKO06QTGBtRbqN+FZ
 RAqKoHA+v9HnsKOMxocVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x1lyC3Ji1Es=;rfaa3wf131lrTiM7ygp5gtbnKeq
 lEcL7L/UEMyCXVbfBuwlY0aVAzNx8jGqzkLKcNXQC5uF5DFCm684I8TkElqLRA9iVA+BANxaJ
 inzgvLIlRSgU4q6oWSxs6a+jb/OJF/5FjvlwWds9eSFLlpXvqoDJFHZry7J8uqKF+xvSFh9cq
 PBYlBf68qfoC9PIdhiy7Dy1xKHlmVcLn28winfXQzQ4DPB89c0XAacAgrZGX2HvOcfKcXW3od
 4Cxgpbc/u7b7xG1rcvjSRUtioKUzlwP4R857yamdyzhaLkSGQk3kST6E/Y2xUP2zNkFhEqnTD
 tunGM67zy+PA+0lsJOHE5w1NFm59nXioTeox19dO2JcFW2nQRNwEU7ygeEdLP7b1EiaepE5SI
 fevg6quB3XVXAq0Ksr1qLjaxh5vfRkUbffm1GXVSeKoldBn8a3w20Nu6OS38lWSBoLd6p/xH5
 vRui/s2emNYbgBzhh+5AWO0PPa/WDVNJjZvsl0L/qENC4buyPOuyVcli66+z0rIeUfU3aLGW3
 YM31TVup9EsF3g8euA/UHK3NEoqk9J3LBkRwmYvQ+9HNkssyxcgzDNqhGkzMltrlHpfzjUpoI
 XcqH31aYVcvVgZTamYeZJf5rRGFLQ8dVhd9AW2sGvfqjzAjGu6XVyTsiMLq5iBIX5ARtPI8Cu
 0Qzdbt74CBzTbpD029tRU1oAYB2hugPH7VJLck4sRezFxlHqRVyLp9arYpBL3IHcJf6L69SSQ
 aCh1mzqfPSf+6RTIruDh51QJnFD9/fcsE14Ra1NTkhtNV2EUxY/v3K5Se3bx0ily0LxC4GEt/
 GxDp7yhjHjhPg2HVlnSK/k+g==



=E5=9C=A8 2024/9/2 15:54, Gerhard Wiesinger =E5=86=99=E9=81=93:
> On 02.09.2024 07:43, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/9/2 14:58, Gerhard Wiesinger =E5=86=99=E9=81=93:
>>> On 02.09.2024 00:13, Qu Wenruo wrote:
>> [...]
>>>> So it means 60 metadata csum mismatch is fixed, only 145 bad data
>>>> sectors.
>>>
>>> How to get rid of the 145 uncorrectables?
>>
>> Those are all data, at least for my case.
>>
>> It will not be repairable, just as you mentioned, data loss is expected=
.
>
> Yes, but I'm expecting a repaired state and not still an inconsistent
> state with known errors (as command repair states). Other filesystems
> move broken files to e.g. lost+found (expecting at least with a switch).

Even btrfs moves those corrupted files, as long as those data sectors
are still referred by any file, btrfs scrub will always report them as
corrupted.

The only way to get rid of the report is to delete the files, which is
not something that should be done by default at least.

Considering moving the files makes no difference, btrfs check/scrub
won't touch those files, but only inform the end users (with the
filename), and let them to determine what to do next.

>
>
>>
>>>
>>>>
>>>> And after the above scrub, btrfs check reports no more error (at leas=
t
>>>> for metadata):
>>>>
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/test/scratch1
>>>> UUID: c2be653b-6b00-4ed9-925f-258cc7ca5391
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> [3/7] checking free space tree
>>>> [4/7] checking fs roots
>>>> [5/7] checking only csums items (without verifying data)
>>>> [6/7] checking root refs
>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>> found 3776757760 bytes used, no error found
>>>> total csum bytes: 1692008
>>>> total tree bytes: 82444288
>>>> total fs tree bytes: 71237632
>>>> total extent tree bytes: 6455296
>>>> btree space waste bytes: 43819992
>>>> file data blocks allocated: 29158084608
>>>> =C2=A0referenced 4905811968
>>>>
>>>>>
>>>>> Any ideas how to repair and what can be done to get it into a
>>>>> consistent
>>>>> state?
>>>>
>>>> Please give the original "btrfs check" output.
>>>>
>>>> I think your original fs is either using SINGLE metadata profile (the=
n
>>>> very hard to do repair), AND you're using incorrect way to repair
>>>> (scrub
>>>> first, then btrfs check to verify, never --init-extent-tree nor
>>>> --init-csum-tree unless you know what you're really doing).
>>>
>>> I originally did scrub first (forget to mention, but there were still
>>> uncorrectable errors as with my test script)
>>
>> Aren't you expect data corruption?
>
> Yes, but I'm expecting a repaired state and not still an inconsistent
> state with known errors (as command repair states). Other filesystems
> move broken files to e.g. lost+found (expecting at least with a switch)

As explained, that's impossible by just moving them to lost+found.

Btrfs is really in its own realm, on how to properly fix data corruption.

Our choice so far is to let end users to do the work.
Either deleting the file, or find a backup to restore the file.

And repeating your sentence won't really make it any more persuading.

Thanks,
Qu
>

