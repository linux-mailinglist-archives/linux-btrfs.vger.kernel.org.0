Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53770377E57
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhEJIjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 04:39:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:35173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhEJIjX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 04:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620635894;
        bh=j+hKTaUX8gxt25R8R/Uqnb3ocyVLSYKH3QydA76Rouo=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=kp9SQBjX4n3xdCtJjto53mtZ92oIXZUVgsQNnWnEv2bNzqUhgjO69DCc+1vrLdcSJ
         9XOuL4CEkJgrAWCOlt3odphPrnJvrIN3FuAcJRUPpfhdkZFCsTZykghJWZvUOkGEs6
         21tQ7NzbaAc7PGd6wklnu6VCMtkErS0/DtbPGs3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRRZ-1m0XLK1Gsl-00Xr1H; Mon, 10
 May 2021 10:38:14 +0200
To:     Ritesh Harjani <riteshh@linux.ibm.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-42-wqu@suse.com>
 <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
 <20210507045735.jjtc76whburjmnvt@riteshh-domain>
 <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <e7e6ebdd-a220-e4ec-64e4-d031d7a9b181@gmx.com>
Date:   Mon, 10 May 2021 16:38:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tS3xvb41RzHIl+uMoePYLPW8GKh4qxP6HwB+UX5F2de4+fFeh8l
 6iDZVRFCZYfFxSwiGNCowvMtfgvo6FALYO/cMCXmCIl5gCZkuVzJLFGBEXjcjmILqdaWyUG
 IXg1DRacTkcfcpxfOlS+EQutPuWsmRHoijgR1ixUwUczZ0Np/GB37gEaM62sv8u3B8/Q+FS
 9F8RiYCBs14S97LvoL2Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BO9pt/deods=:PZAvkk2yA5EOkNDwR7Qd5c
 rnH1LIH3CauiziZOvNeHB6DsaJPEJ/pHt4F+JWgNwNZYiLZSU8jv+lilQuIXXubDJI50R5fin
 SL/xm8y8aCWQcHBA47zA+jccj4jdZnNgh3ulGEungjYDZfiuqy4wTnahP+lrMuxsOJWth1pay
 oFFTO0RLyUdymRYv86NnQ33snP4BcTBUsk+3cZOPwUZXiv0aSxbJ6b+804dQAKoVwMLOsgi2O
 9T7pK7MAuD7rIwWqfxKzBRGh/bxH4QXTf2ws1DYumrErow8kA988TUoJoqC3x2qgEfMmsA/Z1
 wRgknXYIeTWckx9U9kNfA/dgKa4W6puSkAALSqVJZtDJVYoHY7u1sXFXZQsKPWmdcrfydXL1Q
 XL18OwEMKQNXx/8yTt1JjB/HX2Uo+4c0yhAiddXut+PZCTEKKb+UsJeU4KgUOscL0zvxntX32
 aDBHMq4LccNBm/c5oEcoFlJs3v20IEEk/cG/cXIdQGNQGG5Qc0apKNXg+nxCXWObb/fqTryLF
 XVtAAb+Bn5rWhXf7eF2pQcby6fOQW7I+iVGts808v0ohgxdtFTqPwkQvClhKAIEkUEA+iCFOa
 V48DaskCaaLAunHeeIxN7CqJwDccIH+2a57PNpvOdNbDj9y3PBPfkeydw8+8GqR04PhKdb6PQ
 PSglH5kHJvbdnjrPyz9bPrGmwhEyGg/vMPI03nBUz7sreuKC7PXqWE98VR5z9sYYNfcfLylBP
 49L1S9Y+k3EFRUfnqQvTD3NHuCJ9qtT8Vf1CbJQLtW06qiCSuc5xkRpPf/aa93PuT2DqFDza1
 Lr4w981UnviSjo1WwYkCVhdqFzbdqemDsVYZi8D6L3+TC/KPGQOA1yqMhI4G1g0gi7F6hylMw
 gmTo6ZvGkyzHpWOG9zn53rCRHAY9ogs/4TQoyUR2uOrUfmB8lH/4kJPAwYcFmIpkqWy9sUQKt
 Fzkk6VuQ9PMmhvs0+w+Eo3/+FKQrHu9rLwJphL1S1s5rcqSLw0n44zcj9yniwwQth6Dkjc1OG
 HbgOPOJDMR0rt727jdU86Ryry0bfAbIaCczo3pxRC4ev2l0ez6mtmRZncr4+uWNObG6q43hTQ
 HW6LYaf7dzN3TiK8pkc34saNLiaAmVvCH/JiR08lHlmrPK8cE+fOYNaLdvT7oBVXXWgWoabs6
 LWVZ7Zk3VD9YRKlx6zzcObH86amCTv8F/J+RFbp9FA6t5+LkLdExvy3GuGwmwKLePCYMIfTJr
 gwzdwJNvs+VMiC81S
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Ritesh,

I guess no error report so far is a good thing?

Just to report what my result is, I ran my latest github branch for the
full weekend, over 50 hours, and around 20 runs of full generic/auto
without defrag groups.

And I see no crash at all.

But there is a special note, there is a new patch, introduced just
before the weekend (Fri May 7 09:31:43 2021 +0800), titled "btrfs: fix a
possible use-after-free race in metadata read path", is a new fix for a
bug I reproduced once locally.

The bug should only happen when read is slow and only happens for
metadata read path.

The details can be found in the commit message, although it's rare to
hit, I have hit such problem around 3 times in total.

Hopes you didn't hit any crash during your test.

Thanks,
Qu


On 2021/5/7 =E4=B8=8B=E5=8D=881:14, Qu Wenruo wrote:
>
>
> On 2021/5/7 =E4=B8=8B=E5=8D=8812:57, Ritesh Harjani wrote:
>> On 21/05/07 07:46AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/4/28 =E4=B8=8A=E5=8D=887:03, Qu Wenruo wrote:
>>>> [BUG]
>>>> There is a possible use-after-free bug when running generic/095.
>>>>
>>>> =C2=A0=C2=A0 BUG: Unable to handle kernel data access on write at
>>>> 0x6b6b6b6b6b6b725b
>>>> =C2=A0=C2=A0 Faulting instruction address: 0xc000000000283654
>>>> =C2=A0=C2=A0 c000000000283078 do_raw_spin_unlock+0x88/0x230
>>>> =C2=A0=C2=A0 c0000000012b1e14 _raw_spin_unlock_irqrestore+0x44/0x90
>>>> =C2=A0=C2=A0 c000000000a918dc btrfs_subpage_clear_writeback+0xac/0xe0
>>>> =C2=A0=C2=A0 c0000000009e0458 end_bio_extent_writepage+0x158/0x270
>>>> =C2=A0=C2=A0 c000000000b6fd14 bio_endio+0x254/0x270
>>>> =C2=A0=C2=A0 c0000000009fc0f0 btrfs_end_bio+0x1a0/0x200
>>>> =C2=A0=C2=A0 c000000000b6fd14 bio_endio+0x254/0x270
>>>> =C2=A0=C2=A0 c000000000b781fc blk_update_request+0x46c/0x670
>>>> =C2=A0=C2=A0 c000000000b8b394 blk_mq_end_request+0x34/0x1d0
>>>> =C2=A0=C2=A0 c000000000d82d1c lo_complete_rq+0x11c/0x140
>>>> =C2=A0=C2=A0 c000000000b880a4 blk_complete_reqs+0x84/0xb0
>>>> =C2=A0=C2=A0 c0000000012b2ca4 __do_softirq+0x334/0x680
>>>> =C2=A0=C2=A0 c0000000001dd878 irq_exit+0x148/0x1d0
>>>> =C2=A0=C2=A0 c000000000016f4c do_IRQ+0x20c/0x240
>>>> =C2=A0=C2=A0 c000000000009240 hardware_interrupt_common_virt+0x1b0/0x=
1c0
>>>>
>>>> [CAUSE]
>>>> There is very small race window like the following in generic/095.
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0Thread 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thread 2
>>>> --------------------------------+------------------------------------
>>>> =C2=A0=C2=A0=C2=A0 end_bio_extent_writepage()=C2=A0=C2=A0=C2=A0 | btr=
fs_releasepage()
>>>> =C2=A0=C2=A0=C2=A0 |- spin_lock_irqsave()=C2=A0=C2=A0=C2=A0 | |
>>>> =C2=A0=C2=A0=C2=A0 |- end_page_writeback()=C2=A0=C2=A0=C2=A0 | |
>>>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- if (PageWriteback() ||...)
>>>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- clear_page_extent_mapped()
>>>> =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |- kfree(su=
bpage);
>>>> =C2=A0=C2=A0=C2=A0 |- spin_unlock_irqrestore().
>>>>
>>>> The race can also happen between writeback and btrfs_invalidatepage()=
,
>>>> although that would be much harder as btrfs_invalidatepage() has much
>>>> more work to do before the clear_page_extent_mapped() call.
>>>>
>>>> [FIX]
>>>> For btrfs_subpage_clear_writeback(), we don't really need to put
>>>> end_page_writepage() call into the spinlock critical section.
>>>>
>>>> By just checking the bitmap in the critical section and call
>>>> end_page_writeback() outside of the critical section, we can avoid su=
ch
>>>> use-after-free bug.
>>>>
>>>> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>>> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> =C2=A0=C2=A0 fs/btrfs/subpage.c | 5 ++++-
>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>>>> index 696485ab68a2..c5abf9745c10 100644
>>>> --- a/fs/btrfs/subpage.c
>>>> +++ b/fs/btrfs/subpage.c
>>>
>>> Hi Ritesh,
>>>
>>> Unfortunately I have to bother you again for testing the latest subpag=
e
>>> branch.
>>
>> Yes, this was anyway on my mind to test the latest subpage branch.
>> Sure, I will do the testing.
>>
>>>
>>> This particular fix seems to be incomplete, as I have hit several
>>> BUG_ON()s
>>> related to end_page_writeback() called on page without writeback flag.
>>
>> ok.
>>
>>>
>>>> @@ -420,13 +420,16 @@ void btrfs_subpage_clear_writeback(const
>>>> struct btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_subpage *subpage =
=3D (struct btrfs_subpage
>>>> *)page->private;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 tmp =3D btrfs_subpage_calc_b=
itmap(fs_info, page, start, len);
>>>> +=C2=A0=C2=A0=C2=A0 bool finished =3D false;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&subpage->lock=
, flags);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subpage->writeback_bitmap &=3D ~=
tmp;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (subpage->writeback_bitmap =
=3D=3D 0)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_page_writeback(page);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finished =3D true;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&subpage-=
>lock, flags);
>>>> +=C2=A0=C2=A0=C2=A0 if (finished)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_page_writeback(page);
>>>
>>> The race can happen like this:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 T1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T2
>>> ----------------------------------+----------------------------------
>>> __extent_writepage()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> |<< The 1st sector of the page >> |
>>> |- writepage_delalloc()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |
>>> |=C2=A0 Now the subpage range has=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> |=C2=A0 Writeback flag=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> |- __extent_writepage_io()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> |=C2=A0 |- submit_extent_page()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | << endio of the 1st sector >>
>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | end_bio_extent_write=
page()
>>> |<< The 2nd sector of the page >> | |- spin_lock_irqsave()
>>> |- writepage_delalloc()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | |- finished =3D true
>>> |=C2=A0 |- spin_lock()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- spin_unlock_irqstore=
()
>>> |=C2=A0 |- set_page_writeback();=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 |
>>> |=C2=A0 |- spin_unlock()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- end_page_writeback()
>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | << Now page has no w=
riteback >>
>>> |- __extent_writepagE_io()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> =C2=A0=C2=A0=C2=A0 |- submit_extent_page()=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | << endio of the 2nd sector >>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | end_bio_=
extent_writepage()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- finis=
hed =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- end_p=
age_writeback()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!! =
BUG_ON() triggered !!!
>>>
>>> The reproducibility is pretty low, so far I have only hit 3 times such
>>> BUG_ON().
>>> No special test case number for it, all 3 BUG_ON() happens for differe=
nt
>>> test cases.
>>>
>>> Thus newer fix will still keep the end_page_writeback() inside the
>>> spinlock,
>>> but btrfs_releasepage() and btrfs_invalidatepage() will "wait" for the
>>> spinlock to be released before detaching the subpage structure.
>>>
>>> Currently the fix runs fine, but extra test will always help.
>>
>> Sorry, just to be clear, do you mean the latest subpage branch still
>> has some issues where we can hit the BUG_ON() or have you identifed
>> and added
>> some patches to fix it?
>
> Above race is how the old fix (with end_page_writeback() called outside
> of the spinlock) could lead to a BUG_ON().
>
> I believe the new fix, with the same title, can fix the problem.
>
>>
>> Let me clone below branch and re-test xfstests on Power.
>> https://github.com/adam900710/linux/commits/subpage
>>
>> Also if you would like me to test any extra mount option or mkfs
>> option testing
>> too, then pls do let me know. For now I will be testing with default
>> options.
>
> Thanks, let's just focus on the default mount option first.
>
> Thanks for your great help!
> Qu
>
>>
>> -ritesh
>>
