Return-Path: <linux-btrfs+bounces-3332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945887D744
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 00:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43CF282AFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A9E5A10C;
	Fri, 15 Mar 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lIv03mj+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF611CBD
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544471; cv=none; b=RVtsJ8I/W3VPgK+IC8yX/GjS5TDb4hXF4H1BbmyWu/CO+Yl9+ft6RogvZ3r9b84ZGXVfoLAYDuVpE2OwOrqLBSKSWRUU6Mx1Ju+VTh01s7YV5pUku4xvzedaiI6EYJVR2zDgt3TCUxfoFS/cQ3Tdi7p3PjBYgoyBf0aquM/dqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544471; c=relaxed/simple;
	bh=nh5ryz8JMx/ztafADuGEXXxh155Zx94RRm+88f1Np0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTl1xoAdVWY+9zQfnRvdd8g/jnKCCDgV/cUphSe/+5IjpZyV/aAoYBZx7r3PESEeLI9b1DrGtjt20eXs6w/0hnrx7u8dGHX/qoztZWhgydGsfCaVHjyhGcrdooa6gPDGjxR+HRl/jY/LKqu7SOKSJUgEHPbqg0W18HgGU3be19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lIv03mj+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710544464; x=1711149264; i=quwenruo.btrfs@gmx.com;
	bh=cifO1Usx3ZpieNyURnf9JUTeQyM5INQvFeDLRpTL5/E=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=lIv03mj+Zj37jLq2oEse5BRHaMbnIuOCAuwdVi3m3n7xI+8GROg1Koc8kgkz0bBH
	 7gSzYbGv0AkHx4FBmBwfLunPPPwxVCWrycbgoVgTBtbVvbMZPab5+a9UGcUyaxnId
	 bHZgBZq1fhwL50E0rViQUD/cooo965hSFUQmXVla8eXRSppnREHQv8zPYWoztq3e7
	 xzRK0SuMGjbaVA6nmVZH7SsyNdhgu88YR1cc+IaRQWvMNLwGNzv2OEqYQS4/Uhb5r
	 hpneJ/U12Z2WIughARm2ukHDMGnUoUGebyC+mWoPetsztgugW7BtpYZ+CWbA5nKV/
	 uO22KJ718n2RE9zKZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXFx-1rYMbG21sf-00DYLY; Sat, 16
 Mar 2024 00:14:24 +0100
Message-ID: <08e2a247-cb8c-4454-8625-f0279682e18f@gmx.com>
Date: Sat, 16 Mar 2024 09:44:20 +1030
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
 <0d03ff62-7841-4559-b41e-173bf5dd848b@gmx.com>
 <CABg4E-mNTRoTqW9Hj=9tO=8=N3PQx7C-BYee1V6QMtGDiqr9eg@mail.gmail.com>
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
In-Reply-To: <CABg4E-mNTRoTqW9Hj=9tO=8=N3PQx7C-BYee1V6QMtGDiqr9eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jZ1Ak5YJlzhVzoRXVQ/zBKlc494exXGF6P3Nb9CPl0SMJeXbEHc
 71+IbAVOB4MT9iRf+214u0OKpahPJbcngCPdtghdHKrklDffxDFPI9MwUl9KHODSvdKBPYu
 DLgGz9vOk9A39PjmquGCod973GOUbEwM0bDBIa6VX0NzGQT83Rq1OhZm9YO/S4SJ7s2CmT8
 SrXdw+TACyIA/rdNOBntA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OFl/wJAQ840=;VatzRouyxkv8cmAZ5JjmsJDPGQo
 2wC3n+TixzEuIqoSLGJmZQMBdRacSuwfX6W9yXH0aAG551BMM3da2SVfEjo8mV5sHoshZTnHr
 wnBCTCwPy6USwLbqUL/WkloutYTuaBCbR40HTh61SnbFOIucmYHcthwhpzjZkjrezw22hyi0j
 L9+dL+dCSzSs5lpTy3n530hkar7/gjuWOYqg7233OU4gGLkfDE76EbREya0MgsB++oOyUFTVk
 /MYkT0Fz4qYTSu8dJ4xAMtUV0P6SD+BmmohphKhGKoInc7oS8w6VMeJJ2MKzhIzrrMNGtNKJ0
 a/Yq/dhxxCIbI2qbumnjOpi21IMKtHwP7xoIythM70ZY0gbRSPsr3CoND3b1vFBxGqQUDUliQ
 YK2efK5f/NVvDow3YK1lfHPGxDEc/hUt2vYN874VnQ3MKzKlvrIRoDxxbUEDZSW8CKsREYbb/
 tw75ZC7uqeCq45jQyC3i+GCICCekm0Nu+vrDhmbr8HEmGZSYURZkyooBWe4f6JNToABFKkH1o
 ME84I57BIJmaxqJYU9MPAylsNBZX/IRhrdR7gdpg1pE2mMyb4NWzVZOlQh0Y7CNS7dAvzeNym
 piXcs55lXjDT/HXuAzofEezVMVKTUlkZtCqu+TAHNPBAXyhONc4DF6xUYrgjp6yZstpxCM52O
 KHBinPeTgUsABAi1co8DBPzPVW7BZsu143psWxspGuHkYfMDGO9Am14S4OTqL70ekZbURmyeh
 xfp4PffzPiVtgEVeCzL9frUGOwehF4LWlncbqrJ1S2e5Px4N4MNQA2uWq7dC+RDL5qP3D4L6M
 lm3/vcyTK2W39b4TrpW/el1wEDz+rWVagqg2EsfqknJlM=



=E5=9C=A8 2024/3/16 08:45, Tavian Barnes =E5=86=99=E9=81=93:
> On Fri, Mar 15, 2024 at 4:21=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>> =E5=9C=A8 2024/3/16 06:31, Tavian Barnes =E5=86=99=E9=81=93:
>>> On Fri, Mar 15, 2024 at 11:23=E2=80=AFAM Tavian Barnes
>>> <tavianator@tavianator.com> wrote:
>>>> On Wed, Mar 13, 2024 at 2:07=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx=
.com> wrote:
>>>>> [SNIP]
>>>>>
>>>>> The second patch is to making tree-checker to BUG_ON() when somethin=
g
>>>>> went wrong.
>>>>> This patch should only be applied if you can reliably reproduce it
>>>>> inside a VM.
>>>>
>>>> Okay, I have finally reproduced this in a VM.  I had to add this hunk
>>>> to your patch 0002 in order to trigger the BUG_ON:
>>>>
>>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>>> index c8fbcae4e88e..4ee7a717642a 100644
>>>> --- a/fs/btrfs/tree-checker.c
>>>> +++ b/fs/btrfs/tree-checker.c
>>>> @@ -2047,6 +2051,7 @@ int btrfs_check_eb_owner(const struct
>>>> extent_buffer *eb, u64 root_owner)
>>>>                                   btrfs_header_level(eb) =3D=3D 0 ? "=
leaf" : "node",
>>>>                                   root_owner, btrfs_header_bytenr(eb)=
, eb_owner,
>>>>                                   root_owner);
>>>> +                       BUG_ON(1);
>>>>                           return -EUCLEAN;
>>>>                   }
>>>>                   return 0;
>>>> @@ -2062,6 +2067,7 @@ int btrfs_check_eb_owner(const struct
>>>> extent_buffer *eb, u64 root_owner)
>>>>                           btrfs_header_level(eb) =3D=3D 0 ? "leaf" : =
"node",
>>>>                           root_owner, btrfs_header_bytenr(eb), eb_own=
er,
>>>>                           BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_=
OBJECTID);
>>>> +               BUG_ON(1);
>>>>                   return -EUCLEAN;
>>>>           }
>>>>           return 0;
>>>>
>>>>> When using the 2nd patch, it's strongly recommended to enable the
>>>>> following sysctl:
>>>>>
>>>>>     kernel.ftrace_dump_on_oops =3D 1
>>>>>     kernel.panic =3D 5
>>>>>     kernel.panic_on_oops =3D 1
>>>>
>>>> I also set kernel.oops_all_cpu_backtrace =3D 1, and ran with nowatchd=
og,
>>>> otherwise I got watchdog backtraces (due to slow console) intersperse=
d
>>>> with the traces which was hard to read.
>>>>
>>>>> And you need a way to reliably access the VM (either netconsole or a
>>>>> serial console setup).
>>>>> In that case, you would got all the ftrace buffer to be dumped into =
the
>>>>> netconsole/serial console.
>>>>>
>>>>> This has the extra benefit of reducing the noise. But really needs a
>>>>> reliable VM setup and can be a little tricky to setup.
>>>>
>>>> I got this to work, the console logs are attached.  I added
>>>>
>>>>       echo 1 > $tracefs/buffer_size_kb
>>>>
>>>> otherwise it tried to dump 48MiB over the serial console which I
>>>> didn't have the patience for.  Hopefully that's a big enough buffer, =
I
>>>> can re-run it if you need more logs.
>>>>
>>>>> Feel free to ask for any extra help to setup the environment, as you=
're
>>>>> our last hope to properly pin down the bug.
>>>>
>>>> Hopefully this trace helps you debug this.  Let me know whenever you
>>>> have something else for me to test.
>>>>
>>>> I can also try to send you the VM, but I'm not sure how to package it
>>>> up exactly.  It has two (emulated) NVMEs with LUKS and BTRFS raid0 on
>>>> top.
>>>
>>> I added eb->start to the "corrupted node/leaf" message so I could look
>>> for relevant lines in the trace output.  From another run, I see this:
>>>
>>> $ grep 'eb=3D15302115328' typescript-5
>>> [ 2725.113804] BTRFS critical (device dm-0): corrupted leaf, root=3D25=
8
>>> block=3D15302115328 owner mismatch, have 13709377558419367261 expect
>>> [256, 18446744073709551360] eb=3D15302115328
>>> [ 2740.240046] iou-wrk--173727   15..... 2649295481us :
>>> alloc_extent_buffer: alloc_extent_buffer: alloc eb=3D15302115328
>>> len=3D16384
>>> [ 2740.301767] kworker/-322      15..... 2649295735us :
>>> end_bbio_meta_read: read done, eb=3D15302115328 page_refs=3D3 eb level=
=3D0
>>> fsid=3Db66a67f0-8273-4158-b7bf-988bb5683000
>>> [ 2740.328424] kworker/-5095     31..... 2649295941us :
>>> end_bbio_meta_read: read done, eb=3D15302115328 page_refs=3D8 eb level=
=3D0
>>> fsid=3Db66a67f0-8273-4158-b7bf-988bb5683000
>>>
>>> I am surprised to see two end_bbio_meta_read lines with only one
>>> matching alloc_extent_buffer.  That made me check the locking in
>>> read_extent_buffer_pages() again, and I think I may have found
>>> something.
>>>
>>> Let's say we get two threads simultaneously call
>>> read_extent_buffer_pages() on the same eb.  Thread 1 starts reading:
>>>
>>>       if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>>>           return 0;
>>>
>>>       /*
>>>        * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
>>>        * operation, which could potentially still be in flight.  In th=
is case
>>>        * we simply want to return an error.
>>>        */
>>>       if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
>>>           return -EIO;
>>>
>>>       /* (Thread 2 pre-empted here) */
>>>
>>>       /* Someone else is already reading the buffer, just wait for it.=
 */
>>>       if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
>>>           goto done;
>>>       ...
>>>
>>> Meanwhile, thread 2 does the same thing but gets preempted at the
>>> marked point, before testing EXTENT_BUFFER_READING.  Now the read
>>> finishes, and end_bbio_meta_read() does
>>>
>>>               btrfs_folio_set_uptodate(fs_info, folio, start, len);
>>>       ...
>>>       clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
>>>       smp_mb__after_atomic();
>>>       wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
>>>
>>> Now thread 2 resumes executing, atomically sets EXTENT_BUFFER_READING
>>> (again) and starts reading into the already-filled-in extent buffer.
>>> This might normally be a benign race, except end_bbio_meta_read() has
>>> also set EXTENT_BUFFER_UPTODATE.  So now if a third thread tries to
>>> read the same extent buffer, it will do
>>>
>>>       if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>>>           return 0;
>>>
>>> and return 0 *while the eb is still under I/O*.  The caller will then
>>> try to read data from the extent buffer which is concurrently being
>>> updated by the extra read started by thread 2.
>>
>> Awesome! Not only you got a super good trace, but even pinned down the
>> root cause.
>
> Thanks!
>
>> The trace indeed shows duplicated metadata read endio finishes, which
>> means we indeed have race where we shouldn't.
>
> Okay, glad to see I read the trace correctly.  Now that we think we
> understand it, can you think of a more reliable reproducer?  It would
> need lots of read_block_for_search() on the same block in parallel.
>
>> Although I'm not 100% sure about the fix, the normal way we handle it
>> would be locking the page before IO, and unlock it at endio time.
>
> Fair enough, I don't really know the locking rules in btrfs or fs/mm
> generally.  I'm pretty sure the double-checked approach from my patch
> is enough to protect read_extent_buffer_pages() from racing with
> itself in the way I described, but I don't know if a lock may be
> required for other reasons.  It might be nice to avoid taking a lock
> in this path but I'm not sure how important that is.
>
> I do see that this code path used to take page locks until commit
> d7172f52e993 ("btrfs: use per-buffer locking for extent_buffer
> reading").
>
> I'm currently re-running the reproducer with my patch.  If it survives
> the night without crashing, I'll post it formally, unless you'd like
> to do it a different way.

After digging deeper, your fix looks fine.
(Just remove the cleanup, as we need a minimal hot fix for backport, and
don't forget to CC the fix to stable, and if possible find the
regression commit if it's a regression, and I think the commit you
mentioned is the culprit, as previously we have extra page locking to
prevent this from happening)

I can only come up with the following racing cases, and all looks fine
with your fix:

Case 1:
                   T1              |              T2
=2D---------------------------------+-------------------------------
test_bit(UPTODATE) =3D=3D false       |
                                   | test_bit(UPTODATE) =3D=3D false
test_set(READING) =3D=3D true         |
                                   | test_set(READING) =3D=3D false
                                   | goto wait

Everything is fine, the old common case.


Case 2:
                   T1              |              T2
=2D---------------------------------+-------------------------------
test_bit(UPTODATE) =3D=3D false       |
                                   | test_bit(UPTODATE) =3D=3D false
test_set(READING) =3D=3D true         |
end_io:                           |
set_bit(UPTODATE)                 |
clear_bit(READING)                |
                                   | test_set(READING) =3D=3D true
                                   | test_bit(UPTODATE) =3D=3D true
                                   | done

The old case where the double read would happen, and now it's fine.

Case 3:
The extra race between UPTODATE and READING:

                   T1              |              T2
=2D---------------------------------+-------------------------------
test_bit(UPTODATE) =3D=3D false       |
                                   | test_bit(UPTODATE) =3D=3D false
test_set(READING) =3D=3D true         |
end_io:                           |
set_bit(UPTODATE)                 |
                                   | test_set(READING) =3D=3D false
                                   | wait
clear_bit(READING)                |

Still safe, due to the fact that UPTODATE is set before clearing READING.

So yep, your fix should be fine.

Although initially I'd prefer a more straightforward spinlock based
solution like this:

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7441245b1ceb..88fcf1df87c7 100644
=2D-- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4318,20 +4318,28 @@ int read_extent_buffer_pages(struct
extent_buffer *eb, int wait, int mirror_num,
  	struct btrfs_bio *bbio;
  	bool ret;

-	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
+	spin_lock(&eb->refs_lock);
+	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags)) {
+		spin_unlock(&eb->refs_lock);
  		return 0;
+	}

  	/*
  	 * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
  	 * operation, which could potentially still be in flight.  In this case
  	 * we simply want to return an error.
  	 */
-	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
+	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))) {
+		spin_unlock(&eb->refs_lock);
  		return -EIO;
+	}

  	/* Someone else is already reading the buffer, just wait for it. */
-	if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
+	if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags)) {
+		spin_unlock(&eb->refs_lock);
  		goto done;
+	}
+	spin_unlock(&eb->refs_lock);

  	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
  	eb->read_mirror =3D 0;

But this is much larger than your fix.
Although you may want some extra explanation on the fix.

Otherwise pretty happy to see we finally pinned it down.

Thanks,
Qu
>> I believe we can do that and properly solve it.
>> And go with fallbacks to use spinlock to make all the bits testing in a
>> critical section if the page lock one is no feasible.
>>
>> Thank you so much!
>> You really saved us all!
>
> No problem, happy to help :)
>
>> Thanks,
>> Qu
>

