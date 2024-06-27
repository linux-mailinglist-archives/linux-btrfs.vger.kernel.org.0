Return-Path: <linux-btrfs+bounces-6016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9EA91A39B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 12:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0961C21D4D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDC913C90F;
	Thu, 27 Jun 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kACOQOrU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB74C3C3
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483315; cv=none; b=OaV38sOx/MDaZ8g837zquFWuJ4PPvku7HJz7C/C2sUP7ZlY6AOYM6zRhHyycsTDty6pQroEOE1cyS/Hwp9b7amCeQ91PpXs/oDwdUQ6i3vep3YBMCSVzyGouHXCCHQsuINuMkmsQiQObQBQM3oWvbH1TswW2yTT4ECgcXh+Issw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483315; c=relaxed/simple;
	bh=HmMFd5N282FR0s9jAGZx35N+76Ql+QVIdy0UTbdqAnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HElwG+0l5rQGhtG5c+WGPHkU4AqUOsabKSF8P2aC0Sl4nsx5hoqbQQUiigl0pPfhmjLY4jOQmqxcHT4H60hiOtRdcE9w6XK4dybHXq4mEcXfpsSKo+igQIRjynylbCpbBFET5spuQuqYTDo4Iyw7C97Iv6/qRE9nUrOYYVETQGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kACOQOrU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719483305; x=1720088105; i=quwenruo.btrfs@gmx.com;
	bh=/YBnClv8uwtRyqk/jdbztJ3X4gxTd45epBOv5hYDuU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kACOQOrUFC2e1ulmnZjuRt2FuSa5CdMab8Vhjr8L+LX8NwX0a11KO54CZ6BxDr4b
	 f9VvJQ2uPL8DK7lUcuNDQv7GbdUiZOxOMhHaP7msPVi1vJY/6piVBH/EySTKTz1pp
	 DVnVLW4zGwC75jnrRGPHp/mB5T1jNfzc3tYOeopj+LrkLgDEKUErlkNep6JyCkryv
	 8TSmnfUxwvl3IflM8beVyO+xO05m4HpFhdkXrLQpZPaTi96PRgl/7WMuBOzU1j7y3
	 qNh1VIzM5mVoZVXibXB6dH+VSouoH9MXtzqiX1eMrQceIxzSqt+js+MlIAn29Vk7K
	 W87WBhUjQls9A7peDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3HU-1s7JgH0RJo-001qTb; Thu, 27
 Jun 2024 12:15:05 +0200
Message-ID: <a6238bf2-4560-47ab-9daf-769d12be05dd@gmx.com>
Date: Thu, 27 Jun 2024 19:45:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: remove the extra_gfp parameter from
 btrfs_alloc_page_array()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1719462554.git.wqu@suse.com>
 <1b08b3f46e29dbb6c88a6f7cf038c2487386bdb0.1719462554.git.wqu@suse.com>
 <CAL3q7H5OywgMv=BRRFwmNW5pEVLs7AfnuO+jDuz5hsV9CCGX5A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5OywgMv=BRRFwmNW5pEVLs7AfnuO+jDuz5hsV9CCGX5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rU4MBEo2GC7u4Rn81oBsobkVQpBsCpJi8dWGc2pslMppLvN1nCu
 sGGEgW47JKMZONk327dBlrl4qMLTSMdT9zdCPfRCjRHO3G8Oz00/F41K4LizV0QWPj1rFCi
 mMhUnNUn6E5ebfz3IEMbXJn8P8uGqQwejgwC+LH05ngq4Jo6CtyNRHGDUDRcAVwVFs0PpJV
 6xZmH40Ia9bU0YAaWSg+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:76V24SgCTHo=;kDM1SlGi1Mc32SqBmjsWv/R/CKP
 UDdzBSysKtp1Q/vx5LGpOJbPYurekSpl45EOAvu6JpVNzp3xJxWvpSe+UR87cY6B563H3c3NT
 UKlvtmsPuhpK0847cbCmNQ9ITWyP5YtBP//J+xWTWv632QZOhgsShbVnEPK8vE8z6n3AG/H7e
 zUN4Lpr+lyrSmd0lGYuoOZo+S4NqVOMRegbo9T18ZX6RGzM4NngZq95R3Q1guAAx+69LpsLpW
 AeUpSyWCSXHqZn2wh9I6MsrTyB+DuiacfXnpvqqrfCi3ZxPFOTqfxLfSnP/sB6Q73vrf9y0zY
 38bZoa0snvcpmX7Zmj32pfaIVrePmTw3d6Qm6fKr7fNGXXXcPXQNAm9aJReIiBnffOO7+O6vy
 hLfsBWOsd/GOF4qgHDgpINYynjTpgs2stA84xv6JCO4SFsDpk8qkGMEMLpS01j1v5NbbCdPDH
 3YfUqaDByF7linsyWZyr6mLODAh8R1l3H0VJxHzTbCGivafqveHvUCODyhQInRIA44yLMtOy+
 5unKdsGKhn+CNzQbc+4qjIGcNiZ1HphDvEV3KR82CH8O2Om4UUnmAiRnAw7WOndQ4hPpLtlM8
 QF3Qfh+OZu8Z4kDD92GNK4d2BgOEf6p40B/vKfdhoNFBki9NXirXuK+XZTstTrYq1KUXyoBKK
 mkO2THAA/IF/bmJBCmTjcTFIg8psS9+8k+K9KShllX7KJWL+nNqtE4lYUxQD1plP8XI80GPq3
 YHZxLzYW7J5sAq8J9HsR5m160YdD4+3s1jmQl9QQK6sqIU0cT69kpidyKSFzrcWtH7O+2AhQO
 cKoUc1hjLTacIP6uPP0xdKY90QxqQKVRnE0gSDX0vQ/os=



=E5=9C=A8 2024/6/27 18:20, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Jun 27, 2024 at 5:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is only one caller utilizing the @extra_gfp parameter,
>> alloc_eb_folio_array(). All the other callers do not really bother the
>> @extra_gfp at all.
>>
>> This patch removes the parameter from the public function, meanwhile
>> implement an internal version with @nofail parameter just for
>> alloc_eb_folio_array() to utilize.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 43 +++++++++++++++++++++++--------------------
>>   fs/btrfs/extent_io.h |  3 +--
>>   fs/btrfs/inode.c     |  2 +-
>>   fs/btrfs/raid56.c    |  6 +++---
>>   fs/btrfs/scrub.c     |  2 +-
>>   5 files changed, 29 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index dc416bad9ad8..64f8e7b4d553 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -695,22 +695,10 @@ int btrfs_alloc_folio_array(unsigned int nr_folio=
s, struct folio **folio_array)
>>          return -ENOMEM;
>>   }
>>
>> -/*
>> - * Populate every free slot in a provided array with pages.
>> - *
>> - * @nr_pages:   number of pages to allocate
>> - * @page_array: the array to fill with pages; any existing non-null en=
tries in
>> - *             the array will be skipped
>> - * @extra_gfp: the extra GFP flags for the allocation.
>> - *
>> - * Return: 0        if all pages were able to be allocated;
>> - *         -ENOMEM  otherwise, the partially allocated pages would be =
freed and
>> - *                  the array slots zeroed
>> - */
>> -int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_a=
rray,
>> -                          gfp_t extra_gfp)
>> +static int __btrfs_alloc_page_array(unsigned int nr_pages,
>> +                                   struct page **page_array, bool nofa=
il)
>
> Please don't use functions prefixed with __, we have abandoned that
> practice, it's against our preferred coding style.
>
> Also instead of adding a wrapper function, why not just change the
> extra_gfp parameter of btrfs_alloc_page() to the "bool nofail" thing?
>
> You mentioned in the cover letter "callers have to pay for the extra
> parameter", but really are you worried about performance?
> On x86_64 the argument is passed in a register, which is super
> efficient, almost certainly better than the overhead of an extra
> function call.

It's not about performance, but the burden on us reviewing/writing code
using that function.
As everytime we need to call that function, we have to check if we need
to use any special value for the extra parameter.

The basic idea is, to keep the most common call to be simple (aka, less
parameters), and only for those special call sites to use the more
complex one.

This is the only time I miss function overloading in C++.

Thanks,
Qu

>
> Thanks.
>
>>   {
>> -       const gfp_t gfp =3D GFP_NOFS | extra_gfp;
>> +       const gfp_t gfp =3D nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NO=
FS;
>>          unsigned int allocated;
>>
>>          for (allocated =3D 0; allocated < nr_pages;) {
>> @@ -728,19 +716,34 @@ int btrfs_alloc_page_array(unsigned int nr_pages,=
 struct page **page_array,
>>          }
>>          return 0;
>>   }
>> +/*
>> + * Populate every free slot in a provided array with pages, using GFP_=
NOFS.
>> + *
>> + * @nr_pages:   number of pages to allocate
>> + * @page_array: the array to fill with pages; any existing non-null en=
tries in
>> + *             the array will be skipped
>> + *
>> + * Return: 0        if all pages were able to be allocated;
>> + *         -ENOMEM  otherwise, the partially allocated pages would be =
freed and
>> + *                  the array slots zeroed
>> + */
>> +int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_a=
rray)
>> +{
>> +       return __btrfs_alloc_page_array(nr_pages, page_array, false);
>> +}
>>
>>   /*
>>    * Populate needed folios for the extent buffer.
>>    *
>>    * For now, the folios populated are always in order 0 (aka, single p=
age).
>>    */
>> -static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra_=
gfp)
>> +static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
>>   {
>>          struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] =3D { 0 };
>>          int num_pages =3D num_extent_pages(eb);
>>          int ret;
>>
>> -       ret =3D btrfs_alloc_page_array(num_pages, page_array, extra_gfp=
);
>> +       ret =3D __btrfs_alloc_page_array(num_pages, page_array, nofail)=
;
>>          if (ret < 0)
>>                  return ret;
>>
>> @@ -2722,7 +2725,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
onst struct extent_buffer *src)
>>           */
>>          set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>>
>> -       ret =3D alloc_eb_folio_array(new, 0);
>> +       ret =3D alloc_eb_folio_array(new, false);
>>          if (ret) {
>>                  btrfs_release_extent_buffer(new);
>>                  return NULL;
>> @@ -2755,7 +2758,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer=
(struct btrfs_fs_info *fs_info,
>>          if (!eb)
>>                  return NULL;
>>
>> -       ret =3D alloc_eb_folio_array(eb, 0);
>> +       ret =3D alloc_eb_folio_array(eb, false);
>>          if (ret)
>>                  goto err;
>>
>> @@ -3121,7 +3124,7 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
>>
>>   reallocate:
>>          /* Allocate all pages first. */
>> -       ret =3D alloc_eb_folio_array(eb, __GFP_NOFAIL);
>> +       ret =3D alloc_eb_folio_array(eb, true);
>>          if (ret < 0) {
>>                  btrfs_free_subpage(prealloc);
>>                  goto out;
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>> index 8364dcb1ace3..0da5f1947a2b 100644
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -363,8 +363,7 @@ int extent_invalidate_folio(struct extent_io_tree *=
tree,
>>   void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
>>                                struct extent_buffer *buf);
>>
>> -int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_a=
rray,
>> -                          gfp_t extra_gfp);
>> +int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_a=
rray);
>>   int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **fo=
lio_array);
>>
>>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 92ef9b01cf5e..6dfcd27b88ac 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -9128,7 +9128,7 @@ static ssize_t btrfs_encoded_read_regular(struct =
kiocb *iocb,
>>          pages =3D kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
>>          if (!pages)
>>                  return -ENOMEM;
>> -       ret =3D btrfs_alloc_page_array(nr_pages, pages, 0);
>> +       ret =3D btrfs_alloc_page_array(nr_pages, pages);
>>          if (ret) {
>>                  ret =3D -ENOMEM;
>>                  goto out;
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 3858c00936e8..294bf7349f96 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -1051,7 +1051,7 @@ static int alloc_rbio_pages(struct btrfs_raid_bio=
 *rbio)
>>   {
>>          int ret;
>>
>> -       ret =3D btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pag=
es, 0);
>> +       ret =3D btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pag=
es);
>>          if (ret < 0)
>>                  return ret;
>>          /* Mapping all sectors */
>> @@ -1066,7 +1066,7 @@ static int alloc_rbio_parity_pages(struct btrfs_r=
aid_bio *rbio)
>>          int ret;
>>
>>          ret =3D btrfs_alloc_page_array(rbio->nr_pages - data_pages,
>> -                                    rbio->stripe_pages + data_pages, 0=
);
>> +                                    rbio->stripe_pages + data_pages);
>>          if (ret < 0)
>>                  return ret;
>>
>> @@ -1640,7 +1640,7 @@ static int alloc_rbio_data_pages(struct btrfs_rai=
d_bio *rbio)
>>          const int data_pages =3D rbio->nr_data * rbio->stripe_npages;
>>          int ret;
>>
>> -       ret =3D btrfs_alloc_page_array(data_pages, rbio->stripe_pages, =
0);
>> +       ret =3D btrfs_alloc_page_array(data_pages, rbio->stripe_pages);
>>          if (ret < 0)
>>                  return ret;
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 4677a4f55b6a..2d819b027321 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -261,7 +261,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *=
fs_info,
>>          atomic_set(&stripe->pending_io, 0);
>>          spin_lock_init(&stripe->write_error_lock);
>>
>> -       ret =3D btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->page=
s, 0);
>> +       ret =3D btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->page=
s);
>>          if (ret < 0)
>>                  goto error;
>>
>> --
>> 2.45.2
>>
>>
>

