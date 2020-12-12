Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712152D83DC
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 02:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406860AbgLLBat (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 20:30:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:34223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406542AbgLLBaO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 20:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607736516;
        bh=lKqX6Ow6ek7h1JAZs5R7ZQ+mAatI5ieRXosLzPrRBuk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q8McJfD3545d7mCdNhCh2yKGirwvFQI3AZWYFmtPgubDLIkZyb5gjKvMiyGH//I3S
         gpE8C7IH+ZZlHu7y8DyUHXPVI6DpQmLdXh6+GeFUvsxDLCzr0lLcnqGifv03cEgEAa
         Qj5v50KmnV+1peiihvbFvIaTsfTonCAz5Fn6VcVY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MacOW-1kHa251DMA-00c5ZW; Sat, 12
 Dec 2020 02:28:35 +0100
Subject: Re: [PATCH v2 12/18] btrfs: extent_io: implement
 try_release_extent_buffer() for subpage metadata support
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-13-wqu@suse.com>
 <d6684ad3-875e-53f1-cf1d-a4490c35c4f9@suse.com>
 <a2732cae-4dea-744e-2eda-8b8e5f2b6710@suse.com>
 <047a66b1-5804-ac05-26ac-4eaf71f5c4df@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <00601760-4e7d-935a-e2bb-056593ff5a39@gmx.com>
Date:   Sat, 12 Dec 2020 09:28:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <047a66b1-5804-ac05-26ac-4eaf71f5c4df@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y8xm/Rx8Pn0laUJSa/N1jOP3iWZjziY2zXxOeGNQI0/hOeT++cx
 vVf+vlogLM+dQiv2kKK6eVDEXTCeXdkHuECu9xrqsiPwJWTUOygjb4HDXiuzHJTP2JxRGk7
 0R/9QaYdMGW5ujzBhsdsalUpAy1F4gL54IrQDlCxKOcW5R8tsqXUAzx7uiOuaEh8koOi1gm
 jo1E7DeHpJeivU705Ktvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5CqD1vl7/pg=:0xCzOCRcXLNMjO8DeF0gdY
 xQFLy0PXOZe8UMkRm5f4ZEHeLv3ndM4A42ZTeM6PpvoE+pQevH7K6CePHBKwBw9rYRk3TjFKw
 lAGFkjpHMVYc46FWf9SFKYIOqEmTl+KikYloBKjnAYh8DaAgetIrtsy+cUf7UFYf7Idssfcp9
 8qztSGpwv4x7nd0A+k1xMiIoB0uXysq2cjuAr67pRx8SKngpskW3Q9BM1h0q7t9Z3pxnnyvf9
 gs/P8vM74nu4sLP1NaHINso1BaJ/Y5aNQX4Yhz1iQzEA4xpVhmVawrhPq7nuxk0qqeXJ3pSu9
 llB/LSGNny+GmlgO6xreEbF8zVV3pf8PV6htcG3vO+VdIeUHPlF2iz112q3l+3q4CDIp5y5VU
 Zh8jUFFMMBo020X4J05K0atKnZqcIBFiCqg4yjWc2GLx7AyJN/SM3I86Vl70tWG2YPLKkfddd
 2MeAcrAt2wFyZji2ukqrdc8LzUsL1NDuzWd96ARHl3v8SF67DsOfvlEBc4AO6oWE1/fjtHkBj
 B/kSQ9QnDEQdQqSpl5WCDL2F+pqVEp6m/195kyVtLai7Ma92WWmvRksiKueAOlyfifQPfZF7i
 EcM1qHWVzRkaeKRv10QpCAL1I3JA9J3VCiKbnw+Jm4IsIk0vi2X0y8fiXoDnk+FSQQhVZTw4b
 uqtySF71cyDS3yDSqveKbL3PMqDokUkNzBrRY4TaIVlxHgzGNIxysE5Xmb5D6uRtld7nUNacb
 z1/BaZxPR4n2XMHhKIFrOiilijGPepj5m7bgrfgz12w/C9dvJYaSr+BpP9ccyncEmUfkQsl5i
 k51IPiJTwRUpD/8oHYs97PR595djJ7exRdHaRejg+kSTf1LfjPXw7K4yHh1nlZ33AnS6gXDcz
 bg+AVE3A4fcVRx1oy8tQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/12 =E4=B8=8A=E5=8D=8812:57, Nikolay Borisov wrote:
>
>
> On 11.12.20 =D0=B3. 14:11 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/12/11 =E4=B8=8B=E5=8D=888:00, Nikolay Borisov wrote:
>>>
>>>
>>> On 10.12.20 =D0=B3. 8:38 =D1=87., Qu Wenruo wrote:
>>>> Unlike the original try_release_extent_buffer,
>>>> try_release_subpage_extent_buffer() will iterate through
>>>> btrfs_subpage::tree_block_bitmap, and try to release each extent buff=
er.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>   fs/btrfs/extent_io.c | 73 +++++++++++++++++++++++++++++++++++++++++=
+++
>>>>   1 file changed, 73 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index 141e414b1ab9..4d55803302e9 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -6258,10 +6258,83 @@ void memmove_extent_buffer(const struct exten=
t_buffer *dst,
>>>>   	}
>>>>   }
>>>>
>>>> +static int try_release_subpage_extent_buffer(struct page *page)
>>>> +{
>>>> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_s=
b);
>>>> +	u64 page_start =3D page_offset(page);
>>>> +	int bitmap_size =3D BTRFS_SUBPAGE_BITMAP_SIZE;
>>>
>>> Remove this variable and directly use BTRFS_SUBPAGE_BITMAP_SIZE as a
>>> terminating condition
>>>
>>>> +	int bit_start =3D 0;
>>>> +	int ret;
>>>> +
>>>> +	while (bit_start < bitmap_size) {
>>>
>>> You really want to iterate for a fixed number of items so switch that =
to
>>> a for loop.
>>
>> The problem here is, it's not always fixed.
>>
>> If it finds one bit set, it will skip (nodesize >> sectorsize_bits) bit=
s.
>>
>> But if not found, it will skip to just next bit.
>>
>> Thus I'm not sure if for loop is really a good choice here for
>> differential step.
>>
>>>
>>>> +		struct btrfs_subpage *subpage;
>>>> +		struct extent_buffer *eb;
>>>> +		unsigned long flags;
>>>> +		u16 tmp =3D 1 << bit_start;
>>>> +		u64 start;
>>>> +
>>>> +		/*
>>>> +		 * Make sure the page still has private, as previous run can
>>>> +		 * detach the private
>>>> +		 */
>>>
>>> But if previous run has run it would have disposed of this eb and you
>>> won't find this page at all, no ?
>>
>> For the "previous run" I mean, previous iteration in the same loop.
>>
>> E.g. the page has 4 bits set, just one eb (16K nodesize).
>
> Isn't it guaranteed that if you iterate the eb's in a page if you meet
> an empty block then the whole extent buffer is gone, hence instead of
> doing bit_start++ you ought to also increment by the size of nodesize.
>
> For example, assume a page contains 4 EBs:
>
> 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
> x|x|x|x|0|0|0|0|x|x| x|x |0 | 0|0 |0
>
> So first bit is set, so you proceed to call release_extent_buffer on it,
> which clears the first 4 bits in tree_block_bitmap, in this case you've
> incremented by nodesize so next iteration begins at index 4. You detect
> it's unset (0) hence you increment it byte 1 and you repeat this for the
> next 3 bits, then you free the whole of the next eb. I argue that you
> also need to increment by nodesize in the case of a bit which is not
> set, because you cannot really see partially freed eb i.e you cannot see
> the following state:
>
> 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
> x|x|x|x|x|0|0|0|x|x| x|x |0 | 0|0 |0
>
> Am I missing something?

It's not for partly freed eb, but nodesize unaligned eb.

E.g. if we have a eb starts at sector 1 of a page, your nodesize based
iteration would go crazy.
Although we have ensured no subpage eb can cross page boundary, but it's
not the same requirement for nodesize alignment.

Thus I uses the extra safe way for the empty bit.

Thanks,
Qu
>
>
>
>
>>
>> For the first run, it release the only eb of the page, and cleared page
>> private.
>> For the second run, since private is cleared, we need to break out.
>>
>>>
>>>> +		spin_lock(&page->mapping->private_lock);
>>>> +		if (!PagePrivate(page)) {
>>>> +			spin_unlock(&page->mapping->private_lock);
>>>> +			break;
>>>> +		}
>
> Aren't we guaranteed that a page has private if this function is called =
?
>
>>>> +		subpage =3D (struct btrfs_subpage *)page->private;
>>>> +		spin_unlock(&page->mapping->private_lock);
>>>> +
>>>> +		spin_lock_irqsave(&subpage->lock, flags);
>>>> +		if (!(tmp & subpage->tree_block_bitmap))  {
>>>> +			spin_unlock_irqrestore(&subpage->lock, flags);
>>>> +			bit_start++;
>>>> +			continue;
>>>> +		}
>>>> +		spin_unlock_irqrestore(&subpage->lock, flags);
>>>> +
>>>> +		start =3D bit_start * fs_info->sectorsize + page_start;
>>>> +		bit_start +=3D fs_info->nodesize >> fs_info->sectorsize_bits;
>
> <snip>
>
>> Thanks,
>> Qu
>>>
>>>
>>>> +		/*
>>>> +		 * Here we can't call find_extent_buffer() which will increase
>>>> +		 * eb->refs.
>>>> +		 */
>>>> +		rcu_read_lock();
>>>> +		eb =3D radix_tree_lookup(&fs_info->buffer_radix,
>>>> +				start >> fs_info->sectorsize_bits);
>>>> +		rcu_read_unlock();
>
> Your usage of radix_tree_lookup + rcu lock is wrong. rcu guarantees that
> an EB you get won't be freed while the rcu section is active, however
> you get a reference to the EB and you do not increment the ref count
> WHILE holding the RCU critical section, consult find_extent_buffer
> what's the correct usage pattern.
>
> Frankly the locking in this function is insane, first mapping->private
> lock is acquired to check if Page_private is set and then page->private
> is referenced but that is not signalled at all. Then subpage->lock is
> taken to check the tree_block_bitmap, then the lock is dropped. At that
> point no locks are held so this page could possibly be referenced by
> someone else? Then the buggy locking is used to get the eb, then you
> lock refs_lock and call release_extent_buffer...
>
>>>> +		ASSERT(eb);
>
> Doing this outside of the rcu read side critical section _without_
> incrementing the ref count is buggy!
>
>>>> +		spin_lock(&eb->refs_lock);
>>>> +		if (atomic_read(&eb->refs) !=3D 1 || extent_buffer_under_io(eb) ||
>>>> +		    !test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
>>>> +			spin_unlock(&eb->refs_lock);
>>>> +			continue;
>>>> +		}
>>>> +		/*
>
>
> <snip>
>
