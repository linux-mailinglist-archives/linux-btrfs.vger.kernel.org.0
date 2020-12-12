Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126772D84EC
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 06:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbgLLFqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Dec 2020 00:46:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:38461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731406AbgLLFqW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Dec 2020 00:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607751889;
        bh=FZM/d0ciLpG4c+L7bL/RwgdRFiJbIdqCEqj0n5tSIb0=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=WH+iDo46GmlZ3KDQRcxBSl8rR0ZtNsvj3hQ9QQl3c40o9A51b00LxMcED4Zt/OhtA
         drG7uTTXO1f9AV+0VTDt+LdUc/LP4ubjp5vAWDphNlaZ3v9T5Z74UW9OaeLL5+RGSG
         CdCJpQCoeNed9CMlqDsLGnb5XbAuPnQifM5wz2ZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUUm-1kKPj20v3U-00ptGA; Sat, 12
 Dec 2020 06:44:49 +0100
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-13-wqu@suse.com>
 <d6684ad3-875e-53f1-cf1d-a4490c35c4f9@suse.com>
 <a2732cae-4dea-744e-2eda-8b8e5f2b6710@suse.com>
 <047a66b1-5804-ac05-26ac-4eaf71f5c4df@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 12/18] btrfs: extent_io: implement
 try_release_extent_buffer() for subpage metadata support
Message-ID: <dabe26b4-1ab9-04b7-26ed-ac7f186e5d3b@gmx.com>
Date:   Sat, 12 Dec 2020 13:44:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <047a66b1-5804-ac05-26ac-4eaf71f5c4df@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VIsAfFa2qSh4MHrl1Zereli2jzby7BskwsBjvPdG8s1mwT30OWg
 RPFDUcxswLZv0eQLnH+AOKNc1BSI0iL13tr28tPMjdPR9lcZtv3D71xbc+8F2Vzoo2QzKxt
 R0QJv+TLNyw+r1Sy4xh1SMyYzZAc9LBLk27pHRtbbqKEJ7fq3oIBDh1vQYxqBv5JdcWGFyg
 4N6fjZZsVG81gg8nFXbRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cLcilElhn1E=:j+U/6Xenp8P5whu21kNmsZ
 viOuzqADv5Z/Xv14Y4bRh0j1oU+jvEWr88eHKyEuRj1CygMqwI7wdc4s/4Q3RN4fg76Ps+8gg
 4ZiLIk8DS4hnEMKHz8KFayAY0H2lxrlXwPTwhMyHbzXuiuG+60aZbRDiKyJr0HZ4feHiP4cJy
 mxJZ8f9qr4LAqsV//CFK1TQOTMYFE24AzCvcMs6fIZsmsKMYENJOH6QPUCtIfmNKQOZGJZGOy
 WkdKGCT9A4zhIUtx3vJXSUleyHpg6tAZbEYGwGOXVaIwvIMcsLGGAjUtYF9kOrp+Y5vgj17wD
 Ddw2bKSkIv7nHT58CaSizswnF+4+e+8fJWWPco0BgEe64Fzev93KQXnu2BfwwA7WEBYS0xrL9
 KzgVfgXOYcmgQqlVn4xIuRsIS7C9EMcEy99272DhXD8qjaw0MBY55LC7gi29hSkNaUkwEta0W
 9ktsB1K6piEwGslwDIqqeBmFuDAO0Wzf2yNDdB3GvwvjBYTy50r8bjHj9Xw12qJAB1sFGLON2
 KG9lCsAQTp49fgr5OmVh0tuzKhdfflO6OjxVvRI2MFmbQsTJQkeYvCwRFWHIbl3PbgeNATggf
 LPcsyKRrwqFcnv0PnW4urY/EIzQXykxyqpJntzu5K1+bGPRD7lYqggOhe53+C0An/t0HKw/UO
 C2okBqYASIp0fgLvQ7yudc8CIYAFw7vbCrhvAierVF/FHe07gqVVhbTmpbToEd9VDFleL1Iu5
 0KvaYmmnACVvRIe80/7AxaUUs2s5bfoJ3RpEGJub503U3eafJa81nU0mz2/UIsP/JbTAnsW//
 YXdUEXRRKM55lHufkdtffANB+6WjsCy+mz5zNjlOOeh4ME/7Z/f6IbiyAMPDRRfRp5Toegrrb
 pdYd6edTomYqdufsA8RA==
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

Nope, you just fall into the trap what I fell before.

Here if the eb has no other referencer, its refs is just 1 (because it's
still in the tree).

If you go increase the refs, the eb becomes referenced again and
release_extent_buffer() won't free it at all.

Causing no eb to be freed whatever.

>
> Frankly the locking in this function is insane, first mapping->private
> lock is acquired to check if Page_private is set and then page->private
> is referenced but that is not signalled at all.

Because we just want the page::private pointer.

We won't touch page::private until we're really going to detach/attach.
But detach/attach will also modify subpage::tree_block_bitmap which is
protected by subpage::lock.

So here just to grab subpage pointer is completely fine.

> Then subpage->lock is
> taken to check the tree_block_bitmap, then the lock is dropped. At that
> point no locks are held so this page could possibly be referenced by
> someone else?

Does it matter? We have the info we need (the eb bytenr) that's all.

Other metadata operation may touch the page, but that won't cause
anything wrong.

> Then the buggy locking is used to get the eb, then you
> lock refs_lock and call release_extent_buffer...

Nope, eb access is not buggy.
If you increase the refs, that would be buggy.

>
>>>> +		ASSERT(eb);
>
> Doing this outside of the rcu read side critical section _without_
> incrementing the ref count is buggy!

Try increasing refs when we're going to cleanup one eb, that's really bugg=
y.

Thanks,
Qu

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
