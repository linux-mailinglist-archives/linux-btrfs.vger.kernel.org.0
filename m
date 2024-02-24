Return-Path: <linux-btrfs+bounces-2704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B09EC8623FB
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 10:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0360FB22794
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882111B81F;
	Sat, 24 Feb 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nq5jqG9Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B081B7E8
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767978; cv=none; b=d9TIJu+IhvGCfPkA919z0L0Q/lTXBPYD8/qFEpTVi54TECMu8i7JtebuBHkw60JVr4wibE8Hhs20hn+dff1PgKzWJfkbduAKwcs6NRyfsO3ktk4Sh78Ckdwus9eBjrylTfY/2kUzQrfXacirfw0wmS4SBBDbQKstSGShfYrV+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767978; c=relaxed/simple;
	bh=7zIrVADWGmsjM8ZryRs8CQzaKo1O3FtkBCc0LFleuAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qL6RX47CD+UXwlV8PJCwbkS9UCJcJyX6R23m4rIyWtBX7blhOSOKYDZ2N96gPYiDvzxb3AVJxKsLb1UcGQjR19HssLxuVckY2+xGYitLZyqMPZZ//9e2l6wkjeqNPQV3qc2zJBrR3Qhw3rFFOKkDHQbqUR7pGWN0OsP7nxoNPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nq5jqG9Y; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708767904; x=1709372704; i=quwenruo.btrfs@gmx.com;
	bh=7zIrVADWGmsjM8ZryRs8CQzaKo1O3FtkBCc0LFleuAw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=nq5jqG9YplmPWO0S0z1jBwhb784IxfQMxmTqAsRHODbWh8wwKw5aU4BU9OAs4D2V
	 sz6mujQ+IurOjzYdGLz+9c3eXiQrNmwbscdG8iDpWAXhV/IqSZ1+dwt40+W2WyD4V
	 q41gMi7jINDO3BwM9bSe3t4mA2oYPXS4A35OBWQIGn94+L9yVwzZ9tcjT6lA/3Hd+
	 JL7ueK37XPmyfasHtd/X9kMwSxDNcn6FsXtLBzqHGFr8EWbrU0grKiTBvo4LAG9QE
	 YnfTLnS72/D7zmiZgK99cWMh4OfiwobI2A8phX4/okl0GYl5nob/JUQYvZeT+jRgY
	 HBHA5AeYUALMbx+CQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1qviMZ22rI-00zo8N; Sat, 24
 Feb 2024 10:45:03 +0100
Message-ID: <09cfb22a-597c-4fbe-939f-aa10d8d461a6@gmx.com>
Date: Sat, 24 Feb 2024 20:14:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Matthew Jurgens <mjurgens@edcint.co.nz>,
 Matthew Jurgens <default@edcint.co.nz>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
 <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
 <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
 <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
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
In-Reply-To: <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a6Kx+DUWhd/qsUsWk/sKRgGxV+fQPL3fuvgQmDD2rwDtg0rFxzD
 +woGrk7oZOAtXj4n5uHKh+Z0fw209iGbBQ0qYVef0IW6nuHN5D9HWmxKUP8DEOGg+YkTpbR
 id/DPjJwpFaM234qJe91q+Na6YgWBGtUuOpZtZ8OQpTmaiZJKimeUTM4/y2safN4PHrM3Mc
 w1AkBTJ/xNEIKaHTldG3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aOFCbsRr5cc=;m5JYNzp+MIunRwoG91I3ECzOHJ8
 /HG31P7uubcsaBfiNY30j2hj9DPFEcPJ85UhhEJHbqhBqScDKtY2lCijVuKYN+zRQufWZ63Ef
 VvaOOQ5aafWTuCXI3V1ewVkpQVzT1y+PUU6fnGTQJm6PAWULH8hPUHERerzA7/UIyOxmMimLR
 W6Xa6WQyz3FG33jCiAh6Eiz7rxScofZX1bU328XXsebDsqRQXlEoOpf9q6cSMZITZC6HiTWNs
 OCCZPzdxAnOB7Anq9zbGMpwz4aRORQpFwTbHnoe7N2KI6WC7bqumhuYpdYiU82VitAKPdAq6E
 avAXV4MyQaWT5+xc/+LTS+BzyrKIJolG0JJgbjFcP45ofigRbnZZXGSkEx2xCa0ZWraR3Ytc2
 7Q1+AIaLierUkjzmaXUhIiGIXcJXp1AOe01qf2AElCBeOne02vrzyPe6KGtzk3vP3tlmlgJbf
 v1J9edoINq/IES+dL1kjDwCP6FM0VTRgR5/CUagizNI32JPXuCiec0+9zc5SALuDbgThWNcKX
 17eraegmpefdekT+tIcxpGsHHCdgQ4OmlfHtyOt59kWauWf923N7/mFDAugyKVXMD5+wTa08S
 vxoT1Fs65T2LPfNGFFzSWiigtoOe9x5ZiLViuw9KWf/B/iVMcCbB0yVyPqlMVPamNcLez9cVt
 dm95Z8MBNJFTIt4yswopaeE5yN3+M4h61AYiJsMotJhfRLU92HF5udZ/Ra4QAf1KQNdoHUWlz
 w+rCPeUuqIgsRNY/RJt0cZDgPvPrs3jk9MSZKJsLbcXxtV8/wEyerwPVeCeUkz7M+2gNhZc0Y
 KFdO4jUKnWB1pguwp4Ur0micjI1oHqMR3sXYMgw3NfNc8=



=E5=9C=A8 2024/2/24 20:11, Matthew Jurgens =E5=86=99=E9=81=93:
>
> On 24/02/2024 2:15 pm, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/2/24 12:21, Matthew Jurgens =E5=86=99=E9=81=93:
>>>
>>> On 24/02/2024 12:22 pm, Matthew Jurgens wrote:
>>>> As I understand rescue=3Dall, I don't need it for allowing me to moun=
t
>>>> (since I can already mount the file system) but it will allow me to
>>>> copy damaged files out of the file system. However, I don't know what
>>>> is damaged. I do have backups.
>>>>
>>>> Commands like=C2=A0 btrfs inspect-internal logical-resolve 2064708789=
8624
>>>> /export/shared
>>>>
>>>> just return
>>>> ERROR: logical ino ioctl: No such file or directory
>>
>> The damaged ones are tree blocks, thus logical resolve won't give a dat=
a
>> inode at all.
>>
>>>>
>>> Having said this, I think I can find which files are damaged by trying
>>> to read every single file on the file system.
>>
>> The problem is, since the corruption is in tree blocks, it can cover
>> quite some files with a single tree block.
>>
>>>
>>> I was just doing some space calculations using du and it started
>>> throwing errors like:
>>>
>>> du: cannot access '/export/shared/backups/xyz': Input/output error
>>>
>>> which also resulted in entries in the messages file like:
>>>
>>> kernel: BTRFS warning (device sdg): checksum verify failed on logical
>>> 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
>>>
>>> where 20647087931392 is a number that appears in other messages eg dme=
sg
>>>
>>> I figure I can then just run a du on the whole file system and any fil=
es
>>> it complains about are probably problematic.
>>>
>>> If it turns out that I can do without the files, can I fix the problem
>>> just by deleting them or is there something else I must do?
>>
>> Not really much you can do (at least safely).
>>
>> As mentioned, the corruption a tree block, not on-disk data of a file
>> (which scrub can easily give you the path).
>>
>> Furthermore, a single corrupted tree block can lead to tons of
>> cross-reference problem (that's why btrfs check is reporting tons of
>> problems).
>>
>> It's hard to make the fs back to sane RW status.
>> You can try "btrfs check --repair", and you may need to do it several
>> times until no more repair or no more errors.
>>
>> And without a full memtest run, if it's really some runtime memory
>> corruption, it will happen again.
>>
>> Thanks,
>> Qu
>>
> I have run a memtest for 5 hours with 4 passes and 0 errors
>
> Is it safe to run "btrfs check --repair" now?
>

OK, not hardware problem, then not sure how the problem happened.

You can "try" --repair, but as mentioned, you may want to run it
multiple times until it reports no error or no new repair.

Thanks,
Qu

