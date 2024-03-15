Return-Path: <linux-btrfs+bounces-3330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB34687D4ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 21:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F59828425A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 20:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995053E30;
	Fri, 15 Mar 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ms3gq4Ux"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35011F922
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534086; cv=none; b=E0igejCzolbn86Co7S9xEhQUpwtzal7oXx8FA5lAE8kv7dOFRdRq4btLQK/iUIkruJ2jm3NfWSu9gFkGuRYVA2t0roruKuH6e2220+bq+jyaq/slO2oY2WbJFtezMtJYGY6B5VCa/ZkXV9k21vAs0GIGuT+yINSngOT+Q7fIqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534086; c=relaxed/simple;
	bh=GDL6GJ7t8h3DJind3iP5oKGmr2gXLchOJA+3+gsUQQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW9CoPc8Bznke22cM63TRyKjBketyCuooTGBpLU3pota8AqNAGavswaZIMvB5076hAeRUgX8i7PWnMLJfMEorRQ/9TDbax6J9imBFYa8a2uSi+/gxhn9O2wnBnnMLDGYjWnJyOJEimGAYsTxsSFXmSo0Z5GSO3fjpnJfQSGgcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ms3gq4Ux; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710534079; x=1711138879; i=quwenruo.btrfs@gmx.com;
	bh=9hWAm075+BZbJeS/SBe7URx3QNanrTv+7Wwsz4rKCNI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Ms3gq4UxMu73sb842m05izAn3lKIpiZ0HcYNiHwFmphc8QDb/Spzms8b8FB1pZlP
	 Drb/jTx3hqT9e1Fgaox+jQzU5yVXtlsfm7nZJHMAZzIuTReIfj+fFZQlcW2EJaoDH
	 XLH1N2k0B12FR3CUaLy3+9wl7VauW6gn54M6u3+S4SNx4KW4WIt03x/0AhZNsL36S
	 5LQIlKZnOgXoLlvQ+dNRPLHTzlbOwcJ7FE3YGdn9enuYbjy0eSFFqXblE18vdF6da
	 XXdnTAT0fwU38lJDr4BqT/OCRHsG5y24/cXIYjx83iu8FzMLAbdNUQPQRpypG5Iui
	 PT+Ul9E9cvFKVeVfXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1riTxJ0sgQ-008MHe; Fri, 15
 Mar 2024 21:21:19 +0100
Message-ID: <0d03ff62-7841-4559-b41e-173bf5dd848b@gmx.com>
Date: Sat, 16 Mar 2024 06:51:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About the weird tree block corruption
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com>
 <CABg4E-nKSZR4kvAGfxKLwAoH1_fJXwQb91spFAMsU9L1vqEpiA@mail.gmail.com>
 <CABg4E-mRsvA5DWnwajpQzr2dbb6Efv=wxP+KCyVYHd2OqiMP_w@mail.gmail.com>
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
In-Reply-To: <CABg4E-mRsvA5DWnwajpQzr2dbb6Efv=wxP+KCyVYHd2OqiMP_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J5Zxsu4UrEEA/VuEr8DiWOYrTv3GMejKp6Ma45LgRDFbZi8u2rJ
 dwf8b0lPqcNtgKZSxC8YZHTWqjqPC7liKgluVim9d1RJJzRHzu+SdTQ+7JIWxel8zUpuEYV
 PNoOyNqfYZD85HsQp/tCV6DMb0gjdwCWQlgA46Ptzd9qy95Pbp1DxD7JZkfCnxv6f0EIZ0m
 3+pzbw7k+c60ezGvOjlxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5CdGs6IhKH4=;8o0UAY21Z5VPcqMzlI3D1QVt5EI
 Z8GMCP9BJcuW5sX0erry5U1NLQu4RxHoyVivqKehCkxpzpF9SuMsvhDq3i2kx/Paor8tLEkPe
 akJ0ZAb7dobQ6eL+UwsuNmN/3M2eSqORZVdyyJXon6D8vlwbX+8Y2F/o1pifHBXIWZFnvnrJ4
 su9rpQHj/8KxXdtm18iSVWTTg7sKwTDSR56pNAPaMeucfReCnHC383xf+JipM5Kex6zwxWbL1
 jjOVMRAHg9qVcc9sqJBQ/PRCTSsKkobKh+n3vrmchJ/+ZpAzqXQl9bTyqIu7/OwP/AVwJMI3d
 zSXAIeT26l9fA0e1zbsXIlTmrgQ98lXinXcdSjz5D93Rp5o/5o80TdeQ5WkrxbzcMiEf+j8C8
 XO9pMES1eVkY44DWRsjtBT5gdHPSmDZayz0n7/mpk+2YCJUCCABV+24Fy6Q4M98LVotUi8DBm
 +fuhyLsxx294dM5Lc6GHgM84dyN+62bThFgtb10OcR9oH8l8d7gSMtBPuiKJIXjqh4NkI64ZA
 pvNDowsakOzCZacdyvLOWInlf73ooNzvmZRnLXKHzhFQAU1QDyrWnMg1tyhEysDQ6i7Fev7yR
 SyfwpRx2apGbvMdTQtQ2AVA+XmuhPy9j4ev535nNzDamot9Qq8uq8ZE0cHzUSnslDQA0/ru3k
 G7TyzWSoIjmi3l3H/FeWoH/18rx5oBLISTNaNKRRI8qSJQMdpeIk+Y5+C4H75CkZ2N8SUl4qO
 FvRKZTRtS+1CwGoiYVUFMgOpvWFJM8cMqrFbWHwMX/VfmXsWO18xSReD2jJxd/mEIwPE3FfYz
 H0Fw0bL6nGpJYCzKR0IocNGmbA9RmMgP1OGzr0qtM18F8=



=E5=9C=A8 2024/3/16 06:31, Tavian Barnes =E5=86=99=E9=81=93:
> On Fri, Mar 15, 2024 at 11:23=E2=80=AFAM Tavian Barnes
> <tavianator@tavianator.com> wrote:
>> On Wed, Mar 13, 2024 at 2:07=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>> [SNIP]
>>>
>>> The second patch is to making tree-checker to BUG_ON() when something
>>> went wrong.
>>> This patch should only be applied if you can reliably reproduce it
>>> inside a VM.
>>
>> Okay, I have finally reproduced this in a VM.  I had to add this hunk
>> to your patch 0002 in order to trigger the BUG_ON:
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index c8fbcae4e88e..4ee7a717642a 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -2047,6 +2051,7 @@ int btrfs_check_eb_owner(const struct
>> extent_buffer *eb, u64 root_owner)
>>                                  btrfs_header_level(eb) =3D=3D 0 ? "lea=
f" : "node",
>>                                  root_owner, btrfs_header_bytenr(eb), e=
b_owner,
>>                                  root_owner);
>> +                       BUG_ON(1);
>>                          return -EUCLEAN;
>>                  }
>>                  return 0;
>> @@ -2062,6 +2067,7 @@ int btrfs_check_eb_owner(const struct
>> extent_buffer *eb, u64 root_owner)
>>                          btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "no=
de",
>>                          root_owner, btrfs_header_bytenr(eb), eb_owner,
>>                          BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OBJ=
ECTID);
>> +               BUG_ON(1);
>>                  return -EUCLEAN;
>>          }
>>          return 0;
>>
>>> When using the 2nd patch, it's strongly recommended to enable the
>>> following sysctl:
>>>
>>>    kernel.ftrace_dump_on_oops =3D 1
>>>    kernel.panic =3D 5
>>>    kernel.panic_on_oops =3D 1
>>
>> I also set kernel.oops_all_cpu_backtrace =3D 1, and ran with nowatchdog=
,
>> otherwise I got watchdog backtraces (due to slow console) interspersed
>> with the traces which was hard to read.
>>
>>> And you need a way to reliably access the VM (either netconsole or a
>>> serial console setup).
>>> In that case, you would got all the ftrace buffer to be dumped into th=
e
>>> netconsole/serial console.
>>>
>>> This has the extra benefit of reducing the noise. But really needs a
>>> reliable VM setup and can be a little tricky to setup.
>>
>> I got this to work, the console logs are attached.  I added
>>
>>      echo 1 > $tracefs/buffer_size_kb
>>
>> otherwise it tried to dump 48MiB over the serial console which I
>> didn't have the patience for.  Hopefully that's a big enough buffer, I
>> can re-run it if you need more logs.
>>
>>> Feel free to ask for any extra help to setup the environment, as you'r=
e
>>> our last hope to properly pin down the bug.
>>
>> Hopefully this trace helps you debug this.  Let me know whenever you
>> have something else for me to test.
>>
>> I can also try to send you the VM, but I'm not sure how to package it
>> up exactly.  It has two (emulated) NVMEs with LUKS and BTRFS raid0 on
>> top.
>
> I added eb->start to the "corrupted node/leaf" message so I could look
> for relevant lines in the trace output.  From another run, I see this:
>
> $ grep 'eb=3D15302115328' typescript-5
> [ 2725.113804] BTRFS critical (device dm-0): corrupted leaf, root=3D258
> block=3D15302115328 owner mismatch, have 13709377558419367261 expect
> [256, 18446744073709551360] eb=3D15302115328
> [ 2740.240046] iou-wrk--173727   15..... 2649295481us :
> alloc_extent_buffer: alloc_extent_buffer: alloc eb=3D15302115328
> len=3D16384
> [ 2740.301767] kworker/-322      15..... 2649295735us :
> end_bbio_meta_read: read done, eb=3D15302115328 page_refs=3D3 eb level=
=3D0
> fsid=3Db66a67f0-8273-4158-b7bf-988bb5683000
> [ 2740.328424] kworker/-5095     31..... 2649295941us :
> end_bbio_meta_read: read done, eb=3D15302115328 page_refs=3D8 eb level=
=3D0
> fsid=3Db66a67f0-8273-4158-b7bf-988bb5683000
>
> I am surprised to see two end_bbio_meta_read lines with only one
> matching alloc_extent_buffer.  That made me check the locking in
> read_extent_buffer_pages() again, and I think I may have found
> something.
>
> Let's say we get two threads simultaneously call
> read_extent_buffer_pages() on the same eb.  Thread 1 starts reading:
>
>      if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>          return 0;
>
>      /*
>       * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
>       * operation, which could potentially still be in flight.  In this =
case
>       * we simply want to return an error.
>       */
>      if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
>          return -EIO;
>
>      /* (Thread 2 pre-empted here) */
>
>      /* Someone else is already reading the buffer, just wait for it. */
>      if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
>          goto done;
>      ...
>
> Meanwhile, thread 2 does the same thing but gets preempted at the
> marked point, before testing EXTENT_BUFFER_READING.  Now the read
> finishes, and end_bbio_meta_read() does
>
>              btrfs_folio_set_uptodate(fs_info, folio, start, len);
>      ...
>      clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
>      smp_mb__after_atomic();
>      wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
>
> Now thread 2 resumes executing, atomically sets EXTENT_BUFFER_READING
> (again) and starts reading into the already-filled-in extent buffer.
> This might normally be a benign race, except end_bbio_meta_read() has
> also set EXTENT_BUFFER_UPTODATE.  So now if a third thread tries to
> read the same extent buffer, it will do
>
>      if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>          return 0;
>
> and return 0 *while the eb is still under I/O*.  The caller will then
> try to read data from the extent buffer which is concurrently being
> updated by the extra read started by thread 2.

Awesome! Not only you got a super good trace, but even pinned down the
root cause.

The trace indeed shows duplicated metadata read endio finishes, which
means we indeed have race where we shouldn't.

Although I'm not 100% sure about the fix, the normal way we handle it
would be locking the page before IO, and unlock it at endio time.

I believe we can do that and properly solve it.
And go with fallbacks to use spinlock to make all the bits testing in a
critical section if the page lock one is no feasible.

Thank you so much!
You really saved us all!

Thanks,
Qu
>
> I attached a candidate patch.  So far only compile-tested.
>

