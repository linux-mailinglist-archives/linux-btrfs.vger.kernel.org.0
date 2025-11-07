Return-Path: <linux-btrfs+bounces-18804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A15C4197B
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 21:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94D43B9DF7
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 20:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B530E853;
	Fri,  7 Nov 2025 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Dzk3rBGR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383427B32B
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547959; cv=none; b=rtqsVy95xuWaulo4urWIeo4KHc/CxjVwvykTcy2orL1Dw22VlrjViM2bY0nvkcEI3G8xTcayGIC+++MWPZ/3MSB8X4ZWqyMYa+sNPSwHj244bE7uN3TbF0VuhmOUzW9Tdt4nULiKtPSMLzRBTpJlabWjM4u9EUHstbbbbuX6psc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547959; c=relaxed/simple;
	bh=AFp3/DEX9irHw1MvmzOALcOYOr/BZLZeQ8KaAcHvpcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU5Tm7nqZ54bm0cDMfkVPxy0aKTHQGHH/W6kMBAomQG0+qzPZ19adPUIg6YnRbEabmZ82pAOs/nff+u0EHlA7YR1JZ2u4Gg1C+GaG0WHVoZPAl8cznvuydd5h8tm/ysByQe3O+KpF5xKmYVKJofhLVrGhG7jiDVjD+CfgERH1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Dzk3rBGR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762547953; x=1763152753; i=quwenruo.btrfs@gmx.com;
	bh=X/psikGgfcGqZDx/6ZjiF7y6AOgYRLBi/4ZdQhcO+wI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Dzk3rBGRijJxnsZD9iJy6oICLeFPBvDGzfIplW1hVT0WVihnXyuQcqStZzpsIefL
	 IEJuLZ7GMzlYWOHpF2jGAuE52V2tft06ogStjHg6X2fQJTunSHxM6JQHRioVgNU6+
	 TRt34mmV3jDxlWbG6ozpA5csu9YhcDAxuwcAfDFEa0WcGCO6K4dcteGQ6ZZXKmSwj
	 TmZ/oDFjQhNxoqqC8Nzpe0CymMvDXoTW77DKF4puSzlCw5pZK8OKjpxVqE8NtDL8j
	 MGDrIZcS+HmMT1vPiLG8gcgQTihtlVn3Ok68oGkalYOPRFQ1UAtfMWpwMWf8MvSZd
	 lb1DZ1AwRGd35Uzmag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hVB-1vM84939CT-00HEvq; Fri, 07
 Nov 2025 21:39:13 +0100
Message-ID: <9d62106c-e871-4387-a664-d60e32161e06@gmx.com>
Date: Sat, 8 Nov 2025 07:09:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: use guard for btrfs_folio_state::lock
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <58baf1fc6d077aacc5db3b2bf42677fc3fbbb6a8.1762503411.git.wqu@suse.com>
 <CAPjX3FdP4=NgEASSh+oOTAkWgggd98Zbhs=XU9chF364m573xQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAPjX3FdP4=NgEASSh+oOTAkWgggd98Zbhs=XU9chF364m573xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yQJRy2uSaZYodu4fTT/LqOLtrOCkgbfcdpnNZws2B336F78VyXf
 ZafKeN4S6enFia1GR2C+yfjYWRw32A61EccLUFBNzOo6AR76MEIYEKK3tM/fNBJ8RJu+4M5
 BRnvb8SwT0sGKzjYFPu1vsY55KRVyMwvRIjq9bSorRe2k0QZNeznvWSN4bwvMHt/F7BPoaN
 klXOCKwOlJbl2gbd3cNLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7eSGsF8scx8=;T4VTe+2EaQQ28zUnbEyS8oAQ1ze
 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



=E5=9C=A8 2025/11/7 22:49, Daniel Vacek =E5=86=99=E9=81=93:
> On Fri, 7 Nov 2025 at 09:18, Qu Wenruo <wqu@suse.com> wrote:
>>
>> Most call sites are fine for a simple guard(), some call sites need
>> scoped_guard().
>>
>> For the scoped_guard() usage, it increase one indent for the code,
>> personally speaking I like the extra indent to make the critical sectio=
n
>> more obvious, but I also understand not all call site can afford the
>> extra indent.
>>
>> Thankfully for subpage cases, it's completely fine.
>>
>> Overall this makes code much shorter, and we can return without
>> bothering manually unlocking, saving several temporary variables.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>> We're still not yet determined if we should brace the new auto-cleanup
>> scheme.
>>
>> Now I'm completely on the boat of the scoped based auto-cleanup, even
>> for the subpage code where the lock is already super straightforward.
>> For more complex cases the benefit will be more obvious.
>>
>> So far the only disadvantage is my old mindset, but I believe time will
>> get it fixed.
>> ---
>>   fs/btrfs/subpage.c | 112 +++++++++++++++-----------------------------=
-
>>   1 file changed, 36 insertions(+), 76 deletions(-)
>>
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> index 80cd27d3267f..85d44a6ece87 100644
>> --- a/fs/btrfs/subpage.c
>> +++ b/fs/btrfs/subpage.c
>> @@ -225,14 +225,12 @@ static bool btrfs_subpage_end_and_test_lock(const=
 struct btrfs_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          const int start_bit =3D subpage_calc_start_bit(fs_info, folio,=
 locked, start, len);
>>          const int nbits =3D (len >> fs_info->sectorsize_bits);
>> -       unsigned long flags;
>>          unsigned int cleared =3D 0;
>>          int bit =3D start_bit;
>> -       bool last;
>>
>>          btrfs_subpage_assert(fs_info, folio, start, len);
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          /*
>>           * We have call sites passing @lock_page into
>>           * extent_clear_unlock_delalloc() for compression path.
>> @@ -240,19 +238,15 @@ static bool btrfs_subpage_end_and_test_lock(const=
 struct btrfs_fs_info *fs_info,
>>           * This @locked_page is locked by plain lock_page(), thus its
>>           * subpage::locked is 0.  Handle them in a special way.
>>           */
>> -       if (atomic_read(&bfs->nr_locked) =3D=3D 0) {
>> -               spin_unlock_irqrestore(&bfs->lock, flags);
>> +       if (atomic_read(&bfs->nr_locked) =3D=3D 0)
>>                  return true;
>> -       }
>>
>>          for_each_set_bit_from(bit, bfs->bitmaps, start_bit + nbits) {
>>                  clear_bit(bit, bfs->bitmaps);
>>                  cleared++;
>>          }
>>          ASSERT(atomic_read(&bfs->nr_locked) >=3D cleared);
>> -       last =3D atomic_sub_and_test(cleared, &bfs->nr_locked);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>> -       return last;
>> +       return atomic_sub_and_test(cleared, &bfs->nr_locked);
>>   }
>>
>>   /*
>> @@ -307,7 +301,6 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs=
_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          const unsigned int blocks_per_folio =3D btrfs_blocks_per_folio=
(fs_info, folio);
>>          const int start_bit =3D blocks_per_folio * btrfs_bitmap_nr_loc=
ked;
>> -       unsigned long flags;
>>          bool last =3D false;
>>          int cleared =3D 0;
>>          int bit;
>> @@ -323,14 +316,14 @@ void btrfs_folio_end_lock_bitmap(const struct btr=
fs_fs_info *fs_info,
>>                  return;
>>          }
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> -       for_each_set_bit(bit, &bitmap, blocks_per_folio) {
>> -               if (test_and_clear_bit(bit + start_bit, bfs->bitmaps))
>> -                       cleared++;
>> +       scoped_guard(spinlock_irqsave, &bfs->lock) {
>> +               for_each_set_bit(bit, &bitmap, blocks_per_folio) {
>> +                       if (test_and_clear_bit(bit + start_bit, bfs->bi=
tmaps))
>> +                               cleared++;
>> +               }
>> +               ASSERT(atomic_read(&bfs->nr_locked) >=3D cleared);
>> +               last =3D atomic_sub_and_test(cleared, &bfs->nr_locked);
>>          }
>> -       ASSERT(atomic_read(&bfs->nr_locked) >=3D cleared);
>> -       last =3D atomic_sub_and_test(cleared, &bfs->nr_locked);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>          if (last)
>>                  folio_unlock(folio);
>=20
> This is really different to the well known and established linear code s=
tyle.
>=20
> One idea - how about closing the scope with something like:
>=20
>          } /* bfs->lock restore irq */

I don't think this is even needed.

I prefer the scoped_guard() scheme, one extra indent shows better where=20
the critical section is.

So to me the extra indent is not a problem at all.

>=20
> But then we're close to back to before. So what's the added value? Is
> there any reason for this change? I guess that's the best question.
> Simply, why?
>=20
> I'm not sure the scope_guard is worth it here.
>=20
> But I'm sure I can get used to the change if we really need it.
>=20
> Finally, my take would be to stay away from using the guards style
> unless absolutely needed. They hardly solve any real issue. So far we
> were perfectly fine without them and we did not miss them. Or did we?

My attribute towards guards is different, I believe it's a good idea=20
overall, freeing us from doing repetitive pairing checks and push them=20
into the work of compiler, exactly what things should be.

I'm 100% sure that we all hit some missing unlock during development,=20
and definitely cursing ourselves why we missed such an obvious unlock.


You mentioned in another thread that guard-until-the-end behavior is=20
going to cause problems if we're adding new code out of the critical=20
section, and I agree that's a problem, but isn't it always a problem no=20
matter using guard/auto-cleanup or not?

E.g.=20
https://lore.kernel.org/linux-btrfs/83ada67a04aee0542397e7442f6c6dd1d0719e=
60.1762336672.git.wqu@suse.com/
And if we're using auto-cleanup/guard for local paths, it will not happen.

Adding new code out of critical section will introduce new/different=20
error handling path anyway, and to me that means either:

1) The original code is already too large
    Thus needs better refactor.
    One example is=20
https://lore.kernel.org/linux-btrfs/a07e2c42e9f29dce1bb50a9b875cf29dfa909a=
fd.1762421429.git.wqu@suse.com/

    But still, as long as there are enough space for indent,
    scoped_guard() can still help when possible.

2) The original code should use scoped_guard() in the first place
    Which makes it pretty straightfoward for where the critical section
    is, and no extra error handling needed.


This RFC patch is almost showing the worst case scenario of using guard,=
=20
where the original code is already doing a pretty good job of keeping=20
critical section small, minimal error handling and minimal amount of=20
indents.

Even for the worst cases scenario, it's still not any worse (as long as=20
you get familiar with the guard() patterns).

I'm pretty confident for more complex multiple locks scenario it will be=
=20
a much obvious improvement.

Thanks,
Qu
>=20
> --nX
>=20
>>   }
>> @@ -359,13 +352,11 @@ void btrfs_subpage_set_uptodate(const struct btrf=
s_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          uptodate, star=
t, len);
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize=
_bits);
>>          if (subpage_test_bitmap_all_set(fs_info, folio, uptodate))
>>                  folio_mark_uptodate(folio);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>=20
> Here I'd add a blank like after the guard. Kind of making it like a
> variable declaration.
>=20
> ditto. for the other changes below.
>=20
>>   void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info=
,
>> @@ -374,12 +365,10 @@ void btrfs_subpage_clear_uptodate(const struct bt=
rfs_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          uptodate, star=
t, len);
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsi=
ze_bits);
>>          folio_clear_uptodate(folio);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
>> @@ -388,11 +377,9 @@ void btrfs_subpage_set_dirty(const struct btrfs_fs=
_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          dirty, start, =
len);
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> -       bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_=
bits);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>> +       scoped_guard(spinlock_irqsave, &bfs->lock)
>> +               bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sec=
torsize_bits);
>>          folio_mark_dirty(folio);
>>   }
>>
>> @@ -412,15 +399,12 @@ bool btrfs_subpage_clear_and_test_dirty(const str=
uct btrfs_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          dirty, start, =
len);
>> -       unsigned long flags;
>> -       bool last =3D false;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsi=
ze_bits);
>>          if (subpage_test_bitmap_all_zero(fs_info, folio, dirty))
>> -               last =3D true;
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>> -       return last;
>> +               return true;
>> +       return false;
>>   }
>>
>>   void btrfs_subpage_clear_dirty(const struct btrfs_fs_info *fs_info,
>> @@ -439,10 +423,9 @@ void btrfs_subpage_set_writeback(const struct btrf=
s_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          writeback, sta=
rt, len);
>> -       unsigned long flags;
>>          bool keep_write;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize=
_bits);
>>
>>          /*
>> @@ -454,7 +437,6 @@ void btrfs_subpage_set_writeback(const struct btrfs=
_fs_info *fs_info,
>>          keep_write =3D folio_test_dirty(folio);
>>          if (!folio_test_writeback(folio))
>>                  __folio_start_writeback(folio, keep_write);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_inf=
o,
>> @@ -463,15 +445,13 @@ void btrfs_subpage_clear_writeback(const struct b=
trfs_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          writeback, sta=
rt, len);
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsi=
ze_bits);
>>          if (subpage_test_bitmap_all_zero(fs_info, folio, writeback)) {
>>                  ASSERT(folio_test_writeback(folio));
>>                  folio_end_writeback(folio);
>>          }
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
>> @@ -480,12 +460,10 @@ void btrfs_subpage_set_ordered(const struct btrfs=
_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          ordered, start=
, len);
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize=
_bits);
>>          folio_set_ordered(folio);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
>> @@ -494,13 +472,11 @@ void btrfs_subpage_clear_ordered(const struct btr=
fs_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          ordered, start=
, len);
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsi=
ze_bits);
>>          if (subpage_test_bitmap_all_zero(fs_info, folio, ordered))
>>                  folio_clear_ordered(folio);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
>> @@ -509,13 +485,11 @@ void btrfs_subpage_set_checked(const struct btrfs=
_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          checked, start=
, len);
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize=
_bits);
>>          if (subpage_test_bitmap_all_set(fs_info, folio, checked))
>>                  folio_set_checked(folio);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
>> @@ -524,12 +498,10 @@ void btrfs_subpage_clear_checked(const struct btr=
fs_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io,
>>                                                          checked, start=
, len);
>> -       unsigned long flags;
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsi=
ze_bits);
>>          folio_clear_checked(folio);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   /*
>> @@ -543,14 +515,10 @@ bool btrfs_subpage_test_##name(const struct btrfs=
_fs_info *fs_info,       \
>>          struct btrfs_folio_state *bfs =3D folio_get_private(folio);   =
    \
>>          unsigned int start_bit =3D subpage_calc_start_bit(fs_info, fol=
io, \
>>                                                  name, start, len);    =
  \
>> -       unsigned long flags;                                           =
 \
>> -       bool ret;                                                      =
 \
>>                                                                        =
  \
>> -       spin_lock_irqsave(&bfs->lock, flags);                   \
>> -       ret =3D bitmap_test_range_all_set(bfs->bitmaps, start_bit,     =
   \
>> +       guard(spinlock_irqsave)(&bfs->lock);                           =
 \
>> +       return bitmap_test_range_all_set(bfs->bitmaps, start_bit,      =
 \
>>                                  len >> fs_info->sectorsize_bits);     =
  \
>> -       spin_unlock_irqrestore(&bfs->lock, flags);                     =
 \
>> -       return ret;                                                    =
 \
>>   }
>>   IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
>>   IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
>> @@ -688,7 +656,6 @@ void btrfs_folio_assert_not_dirty(const struct btrf=
s_fs_info *fs_info,
>>          struct btrfs_folio_state *bfs;
>>          unsigned int start_bit;
>>          unsigned int nbits;
>> -       unsigned long flags;
>>
>>          if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
>>                  return;
>> @@ -702,13 +669,12 @@ void btrfs_folio_assert_not_dirty(const struct bt=
rfs_fs_info *fs_info,
>>          nbits =3D len >> fs_info->sectorsize_bits;
>>          bfs =3D folio_get_private(folio);
>>          ASSERT(bfs);
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          if (unlikely(!bitmap_test_range_all_zero(bfs->bitmaps, start_b=
it, nbits))) {
>>                  SUBPAGE_DUMP_BITMAP(fs_info, folio, dirty, start, len)=
;
>>                  ASSERT(bitmap_test_range_all_zero(bfs->bitmaps, start_=
bit, nbits));
>>          }
>>          ASSERT(bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbi=
ts));
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   /*
>> @@ -722,7 +688,6 @@ void btrfs_folio_set_lock(const struct btrfs_fs_inf=
o *fs_info,
>>                            struct folio *folio, u64 start, u32 len)
>>   {
>>          struct btrfs_folio_state *bfs;
>> -       unsigned long flags;
>>          unsigned int start_bit;
>>          unsigned int nbits;
>>          int ret;
>> @@ -734,7 +699,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_inf=
o *fs_info,
>>          bfs =3D folio_get_private(folio);
>>          start_bit =3D subpage_calc_start_bit(fs_info, folio, locked, s=
tart, len);
>>          nbits =3D len >> fs_info->sectorsize_bits;
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          /* Target range should not yet be locked. */
>>          if (unlikely(!bitmap_test_range_all_zero(bfs->bitmaps, start_b=
it, nbits))) {
>>                  SUBPAGE_DUMP_BITMAP(fs_info, folio, locked, start, len=
);
>> @@ -743,7 +708,6 @@ void btrfs_folio_set_lock(const struct btrfs_fs_inf=
o *fs_info,
>>          bitmap_set(bfs->bitmaps, start_bit, nbits);
>>          ret =3D atomic_add_return(nbits, &bfs->nr_locked);
>>          ASSERT(ret <=3D btrfs_blocks_per_folio(fs_info, folio));
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>>
>>   /*
>> @@ -779,21 +743,19 @@ void __cold btrfs_subpage_dump_bitmap(const struc=
t btrfs_fs_info *fs_info,
>>          unsigned long ordered_bitmap;
>>          unsigned long checked_bitmap;
>>          unsigned long locked_bitmap;
>> -       unsigned long flags;
>>
>>          ASSERT(folio_test_private(folio) && folio_get_private(folio));
>>          ASSERT(blocks_per_folio > 1);
>>          bfs =3D folio_get_private(folio);
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> -       GET_SUBPAGE_BITMAP(fs_info, folio, uptodate, &uptodate_bitmap);
>> -       GET_SUBPAGE_BITMAP(fs_info, folio, dirty, &dirty_bitmap);
>> -       GET_SUBPAGE_BITMAP(fs_info, folio, writeback, &writeback_bitmap=
);
>> -       GET_SUBPAGE_BITMAP(fs_info, folio, ordered, &ordered_bitmap);
>> -       GET_SUBPAGE_BITMAP(fs_info, folio, checked, &checked_bitmap);
>> -       GET_SUBPAGE_BITMAP(fs_info, folio, locked, &locked_bitmap);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>> -
>> +       scoped_guard(spinlock_irqsave, &bfs->lock) {
>> +               GET_SUBPAGE_BITMAP(fs_info, folio, uptodate, &uptodate_=
bitmap);
>> +               GET_SUBPAGE_BITMAP(fs_info, folio, dirty, &dirty_bitmap=
);
>> +               GET_SUBPAGE_BITMAP(fs_info, folio, writeback, &writebac=
k_bitmap);
>> +               GET_SUBPAGE_BITMAP(fs_info, folio, ordered, &ordered_bi=
tmap);
>> +               GET_SUBPAGE_BITMAP(fs_info, folio, checked, &checked_bi=
tmap);
>> +               GET_SUBPAGE_BITMAP(fs_info, folio, locked, &locked_bitm=
ap);
>> +       }
>>          dump_page(folio_page(folio, 0), "btrfs folio state dump");
>>          btrfs_warn(fs_info,
>>   "start=3D%llu len=3D%u page=3D%llu, bitmaps uptodate=3D%*pbl dirty=3D=
%*pbl locked=3D%*pbl writeback=3D%*pbl ordered=3D%*pbl checked=3D%*pbl",
>> @@ -811,13 +773,11 @@ void btrfs_get_subpage_dirty_bitmap(struct btrfs_=
fs_info *fs_info,
>>                                      unsigned long *ret_bitmap)
>>   {
>>          struct btrfs_folio_state *bfs;
>> -       unsigned long flags;
>>
>>          ASSERT(folio_test_private(folio) && folio_get_private(folio));
>>          ASSERT(btrfs_blocks_per_folio(fs_info, folio) > 1);
>>          bfs =3D folio_get_private(folio);
>>
>> -       spin_lock_irqsave(&bfs->lock, flags);
>> +       guard(spinlock_irqsave)(&bfs->lock);
>>          GET_SUBPAGE_BITMAP(fs_info, folio, dirty, ret_bitmap);
>> -       spin_unlock_irqrestore(&bfs->lock, flags);
>>   }
>> --
>> 2.51.2
>>
>>
>=20


