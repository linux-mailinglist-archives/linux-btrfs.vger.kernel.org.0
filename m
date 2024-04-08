Return-Path: <linux-btrfs+bounces-4026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D12D89CDDA
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 23:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D011C21BB0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7B14885F;
	Mon,  8 Apr 2024 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="s+pDDPmh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B2148FE3;
	Mon,  8 Apr 2024 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613204; cv=none; b=Byxjv/wHd80xBa+Nn/b/FizTKKEuilITD0rwqHpjsZx/ccAxi964qWcJI/PcubhHT84sx372Jfw2QEUFEyMayYRDcPrQ8DPFzDvSj4/ZKpcBw7TImMw/Ve38WHvMJnOaP9D/myMh4gyRzj6QF0doBRk4almOQ3aSnKLKm/m8TTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613204; c=relaxed/simple;
	bh=YjGHY2dbCfdGDa3Lw660KotbmkmshbLyRcZjxHfRwGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ivmkz7eZ9Wxk3bYr120SG7JEPyfReJDlph0mI0c86otFeHBNTuhjkzASXPgeX2PtbPW7guA/i8MXESSVamky0swN0WfYa5zrhEbYzG1s42lDqMFGySEWCJcMFSAtZPy5f584K3rquV6r10dCNr6ypcrQRQoCLNRofQOI4vP8M4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=s+pDDPmh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712613194; x=1713217994; i=quwenruo.btrfs@gmx.com;
	bh=b+v00xKGGq5lYzgq9lapnfXRvaewjwTb2kJ/7tv+adE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=s+pDDPmhY2PjWatbKKOrnoJBCK2Z1bUQalP2QCJVP1Dn0atgtgf69o2XdYRisqqH
	 7ic1ARXksdA0F9xJAKHTL/2j7h/8JQHjpbEpcsbbYA/Si2Z+rGXfUY+e63Fw+fTRU
	 PqLv5SQdk5koJw8HnWwYcbO2y9sZ+vmYJ5BEUqIDf0hGG80R3hZ7lwcvdl08M1OXh
	 NaJSA7DB53eIJN+XeEBX9jkW73Fd8DrDjgBmhNYL7wkAiA1GqPhLKb2GwiiKHQMhx
	 UyBwMAF1NT607v+x496XX00Hz8waGBjpmxbSJ4CH0Qth0EE/z2hfxkR4HGklDBKgB
	 eaa5EdUCyFHWA6WLwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MyKDe-1shXLK0bsq-00yf7p; Mon, 08
 Apr 2024 23:53:14 +0200
Message-ID: <3d6004d9-1c68-405e-b078-f03f7a67e4b8@gmx.com>
Date: Tue, 9 Apr 2024 07:23:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix wrong block_start calculation for
 btrfs_drop_extent_map_range()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <4240e179e2439dd1698798e2de79ec59990cbaa0.1712452660.git.wqu@suse.com>
 <CAL3q7H6u_wa14tny7yFt0p6POoocnnAf4VHm9xBSioMtOYP66A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6u_wa14tny7yFt0p6POoocnnAf4VHm9xBSioMtOYP66A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7eu1MMOGidHeXA781VHiFoTydhsB9fDKu7edbt+DW4zoW+uTALW
 Hwyyb6uqToNN6JJUkMKY51wKkyqK8zpoBYXGWrdRSAHWkiPzlDgunkCS7Li0eaGCrOOTiv9
 igQ0xDOpfMreju2KRX8f9wjkE/9rtjjtt7kAQvz8M6dVKZELpwDTDQxIUVGZS4MYAPkhZk1
 kqJaY8iQiQK+BtqGqPz/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X6wJhGnJP+0=;oX0FoyvewxZhezmBPvOha/CNHyS
 39l9us0J1rus3rClqUaHWGCQg+L4QUdkifLw4S945YfJWFUHaO5tV4V4r41YfFP5iVvZ5c8qI
 uyA3oKb1L7B/yLVU1WPShDUIXZ3Iiy7IZ82GdR71es7zUTC2+nCApNJ0BrtZrmS4wCw3Z/2cr
 vYJH7DFPPFTgJORzsWQwb33j3xdJG6ieNczo4PARG68CwgXmNUPGNGqDq/faXZfE/ZdiL3LuQ
 pud8AcF7imJQR+2a/LMV4q1QDtlYl8IS1ZiEWUefiEB99Q9/Ead+ed6GfVD8G8heRJXsaW3Hs
 0F9mOXeF+Xwb+PWW0Snv5FqKo+FczrbWOG/WONZl1BKPuIJAEdD664JTf8ngkSa8AOE+V4uuY
 Oe1WFF8RTvwVrqctHLv6Go3P4irK5YJAgUuXhL17I8bwajBo009oGwI4eL+BO3qAQjtYb94Gk
 oe3pvet1RNwG0oBpZZgnjw56Zi4EELiYfUA49xRJ3rurtmbljttBSd5sPFFvv9R5zTe00lQgT
 DUhaXDxoy7xLXqmhbVrmYr/ZHc7GoDGdwDLlkyqxxRFAzipNEak5+7UgliAIO0gu8hhb+nbqI
 1gM0vuACC1CaffCleGepncu52gNQ/00L9iE3+v46hPEed+ynI0U0Fwy6O1bMD+lYtYLNuFFA1
 alJZeK5n3d+TrmscCk6FCgR8q4ovCMjdzS1q/MuQKEVY9XNlCYB+2jk9bDiy1LY6oDTb7SW4n
 MFiyK0FzhELfWOg8XXs2og5Y3lM2rRDQ2nxjc6w3LgFbPEV2bqZEIGn+JP+715hdaDxCIxp7a
 MEMXFTSc01FJCdrJaIt4XIYyb0/oWDSMAF+XZZqSrexQw=



=E5=9C=A8 2024/4/8 20:18, Filipe Manana =E5=86=99=E9=81=93:
> On Sun, Apr 7, 2024 at 2:18=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> During my extent_map cleanup/refactor, with more than too strict sanity
>> checks, extent-map-tests::test_case_7() would crash my extent_map sanit=
y
>> checks.
>>
>> The problem is, after btrfs_drop_extent_map_range(), the resulted
>> extent_map has a @block_start way too large.
>> Meanwhile my btrfs_file_extent_item based members are returning a
>> correct @disk_bytenr along with correct @offset.
>>
>> The extent map layout looks like this:
>>
>>       0        16K    32K       48K
>>       | PINNED |      | Regular |
>>
>> The regular em at [32K, 48K) also has 32K @block_start.
>>
>> Then drop range [0, 36K), which should shrink the regular one to be
>> [36K, 48K).
>> However the @block_start is incorrect, we expect 32K + 4K, but got 52K.
>>
>> [CAUSE]
>> Inside btrfs_drop_extent_map_range() function, if we hit an extent_map
>> that covers the target range but is still beyond it, we need to split
>> that extent map into half:
>>
>>          |<-- drop range -->|
>>                   |<----- existing extent_map --->|
>>
>> And if the extent map is not compressed, we need to forward
>> extent_map::block_start by the difference between the end of drop range
>> and the extent map start.
>>
>> However in that particular case, the difference is calculated using
>> (start + len - em->start).
>>
>> The problem is @start can be modified if the drop range covers any
>> pinned extent.
>>
>> This leads to wrong calculation, and would be caught by my later
>> extent_map sanity checks, which checks the em::block_start against
>> btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::offset.
>>
>> And unfortunately this is going to cause data corruption, as the
>> splitted em is pointing an incorrect location, can cause either
>> unexpected read error or wild writes.
>
> It can't happen for either reads or writes actually.
>
> As for writes, it can't happen because:
>
> 1) The issue only happens when skip_pinned is true, which is the only
> case that adjusts the 'start' variable (parameter);
>
> 2) All IO paths pass false for the skip_pinned parameter, only
> relocation passes true when replacing the bytenr in file extent items,
> and the range it uses for btrfs_drop_extent_map_range() matches the
> extent item's range, so it won't cover extent maps outside the range;

Thankfully that's what I missed.

In that case we're fine.

>
> 3) Extent maps for writes in progress are always pinned;
>
> 4) Before doing IO on a range we lock the range and wait for any
> existing ordered extents in the range to complete, which results in
> unpinning extent maps;
>
> 5) Extent maps for writes are created when running delalloc (or during
> the write for direct IO), along with the ordered extent, and are
> created as pinned.
>
> With all these, I don't see how we can get a "wild write" or any
> problem in a write path.
>
> As for reads, it doesn't happen because of what's said in 2 regarding
> the range passed to btrfs_drop_extent_map_range().
>
> So as far as I can see, it's currently a harmless bug, and maybe it
> always has been because the bad calculation has been there since 2008,
> see below.
> If it affected reads or writes, it would be easy to trigger with
> fstests and fsx for example (fstests).
>
> It's certainly a bug, it just doesn't have any consequences as far as
> I can see, so the changelog should be updated.
>
>>
>> [FIX]
>> Fix it by avoiding using @start completely, and use @end - em->start
>> instead, which @end is exclusive bytenr number.
>>
>> And update the test case to verify the @block_start to prevent such
>> problem from happening.
>>
>> CC: stable@vger.kernel.org # 6.7+
>> Fixes: c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_exte=
nt_map_range")
>
> That commit doesn't influence how split->block_start is updated, only
> split->start and split->len.
> So I can't understand why you chose to blame that commit.

That patch removed the @len update when updating @start.

Before that patch every time we update @start, @len would be changed to
keep the end the same.

>
> The bug was actually introduced in 2008 by the following commit:
>
> 3b951516ed70 ("Btrfs: Use the extent map cache to find the logical
> disk block during data retries")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D3b951516ed703af0f6d82053937655ad69b60864

Nope, just before the offending patch, the code looks like this for
pinned extent maps:

                 if (skip_pinned && test_bit(EXTENT_FLAG_PINNED,
&em->flags)) {
                         start =3D em_end;
                         if (end !=3D (u64)-1)
                                 len =3D start + len - em_end;
                         goto next;
                 }

Which is correct.

Thanks,
Qu

>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_map.c             | 2 +-
>>   fs/btrfs/tests/extent-map-tests.c | 6 +++++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>> index 471654cb65b0..955ce300e5a1 100644
>> --- a/fs/btrfs/extent_map.c
>> +++ b/fs/btrfs/extent_map.c
>> @@ -799,7 +799,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode, u64 start, u64 end,
>>                                          split->block_len =3D em->block=
_len;
>>                                          split->orig_start =3D em->orig=
_start;
>>                                  } else {
>> -                                       const u64 diff =3D start + len =
- em->start;
>> +                                       const u64 diff =3D end - em->st=
art;
>>
>>                                          split->block_len =3D split->le=
n;
>>                                          split->block_start +=3D diff;
>> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-=
map-tests.c
>> index 253cce7ffecf..80e71c5cb7ab 100644
>> --- a/fs/btrfs/tests/extent-map-tests.c
>> +++ b/fs/btrfs/tests/extent-map-tests.c
>> @@ -818,7 +818,6 @@ static int test_case_7(struct btrfs_fs_info *fs_inf=
o)
>>                  test_err("em->len is %llu, expected 16K", em->len);
>>                  goto out;
>>          }
>> -
>
> Please avoid such accidental changes.
>
> Thanks.
>
>>          free_extent_map(em);
>>
>>          read_lock(&em_tree->lock);
>> @@ -847,6 +846,11 @@ static int test_case_7(struct btrfs_fs_info *fs_in=
fo)
>>                  goto out;
>>          }
>>
>> +       if (em->block_start !=3D SZ_32K + SZ_4K) {
>> +               test_err("em->block_start is %llu, expected 36K", em->b=
lock_start);
>> +               goto out;
>> +       }
>> +
>>          free_extent_map(em);
>>
>>          read_lock(&em_tree->lock);
>> --
>> 2.44.0
>>
>>
>

