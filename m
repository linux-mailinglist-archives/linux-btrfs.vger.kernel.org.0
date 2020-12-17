Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534072DCCBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgLQGuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 01:50:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:54337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgLQGub (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 01:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608187737;
        bh=r2tUlVXDUCzxVEgfz1AQd8bR8XjpfxWbfBylMZzkQwQ=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=fn95IXr7WiMIo/CwkLLjCZDBh6PXBNJkWLOGiVvFPRirHfaQZ8qyXB8NZsIEru4S4
         myCNtrg2opLsBUru+9KZXf2ROc9mOZM3Gi5Gys6lO8a3t4TEtwuUV7FdN0WW8nOKTP
         A4rxgDunWxSDAVP4HpphAkRO/212nOos70pR33SA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQjH-1ktIfd2RK9-00GmTc; Thu, 17
 Dec 2020 07:48:57 +0100
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-7-wqu@suse.com>
 <4dd63414-5e74-77d1-723b-6fb61ffca5fb@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 06/18] btrfs: extent_io: make
 attach_extent_buffer_page() to handle subpage case
Message-ID: <419d9a59-4f3a-eaf0-a312-5985b4421704@gmx.com>
Date:   Thu, 17 Dec 2020 14:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <4dd63414-5e74-77d1-723b-6fb61ffca5fb@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4WZadfIuyskc6iRT1Sq897TcemU7u4zKlK/islBbmJiZPt0yEXH
 MY/GV8vAGRZXc8Hxizr56c5hmHX60OkMr6pYZahjVPBzBE8xHOe0LVour6iUjk16LWDuXWX
 OQIZL6HrMEyQtdej++D9xd2xgGNOC6ZqHKcCYZMLjVXm2mpJf2vAfyKe/SeK7DAbCGZjxv/
 Yg/CR46Y9YarNyGJ7sx3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KfdkPesrHOI=:CIVpRnzPmKz7bdQYKrACLL
 NODaXaAkQ5Psvin1+I5LWYCIbWknhAxdIfU3vYcNAwwtY9Oiu5yDaEYaOqmKyBHPNT81c22bG
 +FigrED3eaaV8g7IHh+pU4+hpZ+Eqrj6YcFCxGtouqXTlPZTk7GpCIcvEWUMWoxoIyzYXJYkW
 enkY1bEScmuqUPLje5es4nwzVovd4vNmtc4WM/HruZRoKpSF0XbbQwwmOoJnskA/LEAV4FqYC
 F0TC3WVYrinU/huFo7RvF3+nw4X1AUyBg5dqq9YDhV4sncSOsmlXDLy7oHluixgXrNDmIjnk7
 CntTQMho64kTXWMVG8Tir1NoQuDIM38injVjOpbQ2m14v+cMZwGZRbLBpqbmpI1j3q+Ika77I
 lX5qzHaIgG9lcifeUM254i98KZDQUo0cNyGo8KpRyVDtUvb8AVnOYz7xhqb9IwBlLsjeZu7qi
 9ToFYeJqyXlVxcy40j9nIXHGlWKjQFOZypG8MkP+cncMWV+Nz3tY+NLfG47ZgMZJFYqP9efpI
 2FtshS2VoPsmYa1ukAKM9vRCVyzKPPs4v+K2ayQyCfBasF0HtvO37D6pKaka16s62iJsGnRsX
 YtoaHF4qJvz1HQQuH1T7bSkhmfnMlM3+8GK/K0HG11A+E+IlfO/4jkwb6BG4vCE41hZkdvqlU
 jWW8NZHLbXYsA8UyWDOR6hPSI2j3IFzWKjIoM2OJNtxc00uxWtYR/LsxrHmIxdfZ4NZaJ5/qf
 e0mCcNXNT6PfedaUMN1tb/tMYQ2Fc00AEGw14x9NWBBPrjebz6shn2KUfn17/750V0Tgz5z80
 T83kbXWTer0BJQ3Nfm/WNF5qTTR6zIO93Ipi2zMN04mbLH1/qXIos74EsiSuo+GttW2EaKqRb
 L1yE/xAjXilzJe6VucQg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/10 =E4=B8=8B=E5=8D=8811:30, Nikolay Borisov wrote:
>
>
> On 10.12.20 =D0=B3. 8:38 =D1=87., Qu Wenruo wrote:
>> For subpage case, we need to allocate new memory for each metadata page=
.
>>
>> So we need to:
>> - Allow attach_extent_buffer_page() to return int
>>    To indicate allocation failure
>>
>> - Prealloc page->private for alloc_extent_buffer()
>>    We don't want to call memory allocation with spinlock hold, so
>>    do preallocation before we acquire the spin lock.
>>
>> - Handle subpage and regular case differently in
>>    attach_extent_buffer_page()
>>    For regular case, just do the usual thing.
>>    For subpage case, allocate new memory and update the tree_block
>>    bitmap.
>>
>>    The bitmap update will be handled by new subpage specific helper,
>>    btrfs_subpage_set_tree_block().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 69 +++++++++++++++++++++++++++++++++++--------=
-
>>   fs/btrfs/subpage.h   | 44 ++++++++++++++++++++++++++++
>>   2 files changed, 99 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 6350c2687c7e..51dd7ec3c2b3 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -24,6 +24,7 @@
>>   #include "rcu-string.h"
>>   #include "backref.h"
>>   #include "disk-io.h"
>> +#include "subpage.h"
>>
>>   static struct kmem_cache *extent_state_cache;
>>   static struct kmem_cache *extent_buffer_cache;
>> @@ -3142,22 +3143,41 @@ static int submit_extent_page(unsigned int opf,
>>   	return ret;
>>   }
>>
>> -static void attach_extent_buffer_page(struct extent_buffer *eb,
>> +static int attach_extent_buffer_page(struct extent_buffer *eb,
>>   				      struct page *page)
>>   {
>> -	/*
>> -	 * If the page is mapped to btree inode, we should hold the private
>> -	 * lock to prevent race.
>> -	 * For cloned or dummy extent buffers, their pages are not mapped and
>> -	 * will not race with any other ebs.
>> -	 */
>> -	if (page->mapping)
>> -		lockdep_assert_held(&page->mapping->private_lock);
>> +	struct btrfs_fs_info *fs_info =3D eb->fs_info;
>> +	int ret;
>>
>> -	if (!PagePrivate(page))
>> -		attach_page_private(page, eb);
>> -	else
>> -		WARN_ON(page->private !=3D (unsigned long)eb);
>> +	if (fs_info->sectorsize =3D=3D PAGE_SIZE) {
>> +		/*
>> +		 * If the page is mapped to btree inode, we should hold the
>> +		 * private lock to prevent race.
>> +		 * For cloned or dummy extent buffers, their pages are not
>> +		 * mapped and will not race with any other ebs.
>> +		 */
>> +		if (page->mapping)
>> +			lockdep_assert_held(&page->mapping->private_lock);
>> +
>> +		if (!PagePrivate(page))
>> +			attach_page_private(page, eb);
>> +		else
>> +			WARN_ON(page->private !=3D (unsigned long)eb);
>> +		return 0;
>> +	}
>> +
>> +	/* Already mapped, just update the existing range */
>> +	if (PagePrivate(page))
>> +		goto update_bitmap;
>
> How can this check ever be false, given btrfs_attach_subpage is called
> unconditionally  in alloc_extent_buffer so that you can avoid allocating
> memory with private lock held, yet in this function you check if memory
> hasn't been allocated and you proceed to do it? Also that memory
> allocation is done with GFP_NOFS under a spinlock, that's not atomic i.e
> IO can still be kicked which means you can go to sleep while holding a
> spinlock, not cool.

There are two callers of attach_extent_buffer_page(), one in
alloc_extent_buffer(), which we pre-allocate page::private before
calling attach_extent_buffer_page().

And the pre-allocation happens out of the spinlock.
Thus there is no memory allocation at all for that call site.

The other caller is in btrfs_clone_extent_buffer(), which needs proper
memory allocation.

>
>> +
>> +	/* Do new allocation to attach subpage */
>> +	ret =3D btrfs_attach_subpage(fs_info, page);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +update_bitmap:
>> +	btrfs_subpage_set_tree_block(fs_info, page, eb->start, eb->len);
>> +	return 0;
>
> Those are really 2 functions, demarcated by the if. Given that
> attach_extent_buffer is called in only 2 places, can't you opencode the
> if (fs_info->sectorize) check in the callers and define 2 functions:
>
> 1 for subpage blocksize and the other one for the old code?

Tried, looks much worse than current code, especially we need to add one
indent in btrfs_clone_extent_buffer().

>
>>   }
>>
>
> <snip>
>
>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>> index 96f3b226913e..c2ce603e7848 100644
>> --- a/fs/btrfs/subpage.h
>> +++ b/fs/btrfs/subpage.h
>> @@ -23,9 +23,53 @@
>>   struct btrfs_subpage {
>>   	/* Common members for both data and metadata pages */
>>   	spinlock_t lock;
>> +	union {
>> +		/* Structures only used by metadata */
>> +		struct {
>> +			u16 tree_block_bitmap;
>> +		};
>> +		/* structures only used by data */
>> +	};
>>   };
>>
>>   int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *=
page);
>>   void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page =
*page);
>>
>> +/*
>> + * Convert the [start, start + len) range into a u16 bitmap
>> + *
>> + * E.g. if start =3D=3D page_offset() + 16K, len =3D 16K, we get 0x00f=
0.
>> + */
>> +static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_i=
nfo,
>> +			struct page *page, u64 start, u32 len)
>> +{
>> +	int bit_start =3D (start - page_offset(page)) >> fs_info->sectorsize_=
bits;
>> +	int nbits =3D len >> fs_info->sectorsize_bits;
>> +
>> +	/* Basic checks */
>> +	ASSERT(PagePrivate(page) && page->private);
>> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>> +	       IS_ALIGNED(len, fs_info->sectorsize));
>
> Separate aligns so if they feel it's evident which one failed.

I guess we are going to forget when ASSERT() should be used.
It's for something which shouldn't fail.

It's not used as a less-terrible BUG_ON(), but really to indicate what's
expected, thus I don't really expect it to be triggered, nor would it
matter if it's two lines or one line.

what's your idea on this David?

>
>> +	ASSERT(page_offset(page) <=3D start &&
>> +	       start + len <=3D page_offset(page) + PAGE_SIZE);
>
> ditto. Also instead of checking 'page_offset(page) <=3D start' you can
> simply check 'bit_start is >=3D 0' as that's what you ultimately care ab=
out.

Despite the ASSERT() usage, the start + len and page_offset() is much
easier to grasp without the need to refer to bit_start.

Thanks,
Qu

>
>> +	/*
>> +	 * Here nbits can be 16, thus can go beyond u16 range. Here we make t=
he
>> +	 * first left shift to be calculated in unsigned long (u32), then
>> +	 * truncate the result to u16.
>> +	 */
>> +	return (u16)(((1UL << nbits) - 1) << bit_start);
>> +}
>> +
>> +static inline void btrfs_subpage_set_tree_block(struct btrfs_fs_info *=
fs_info,
>> +			struct page *page, u64 start, u32 len)
>> +{
>> +	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->priva=
te;
>> +	unsigned long flags;
>> +	u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
>> +
>> +	spin_lock_irqsave(&subpage->lock, flags);
>> +	subpage->tree_block_bitmap |=3D tmp;
>> +	spin_unlock_irqrestore(&subpage->lock, flags);
>> +}
>> +
>>   #endif /* BTRFS_SUBPAGE_H */
>>
>
