Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB5375FA7
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 May 2021 07:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhEGFPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 May 2021 01:15:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:42663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhEGFPQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 May 2021 01:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620364452;
        bh=434PC1cGdsd00gx2BwtILvrK67PWPItA7s4AbX87IQQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gA09BBbT3/mUqVPQ4nu6qFBTrD/QI/4kFNdWTTOYfozwaq5q/2cFe0GjMD11HFKaT
         GeLmok4Y4LawdMbyjUq5A2Piv9TLEC09xPcnh5ngaGaiDLD/932Pc3mhKUZ9Ul174+
         +EBTNdZxeYQ8iaq1ohARqR9onBBOzmK8hu4XPdEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmKX-1lysfq1RST-00K9PO; Fri, 07
 May 2021 07:14:12 +0200
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
To:     Ritesh Harjani <riteshh@linux.ibm.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-42-wqu@suse.com>
 <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
 <20210507045735.jjtc76whburjmnvt@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
Date:   Fri, 7 May 2021 13:14:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210507045735.jjtc76whburjmnvt@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SJseENiwRJOqTdwLJ/ZIKrOr7L74yHDNwpufWMFUe+A/kSx7EDo
 J3mLkD3bA0sw3InRCAR3OrCCACXSxbmT3hwkSmT47rVFeoORvzDsbzy0TC49gsY6iATJqs+
 qokgfdza3QmBjmedGldN9FLYZWQE1vgfEfSzZsgiNoUY67Uf7Faf6/q/DCbONiHjiMzQI4b
 yZEd9cl6mVYtXQBi9/tVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5xmL7IGfW08=:oZve1FMtbMLkeh26ywhPyQ
 h9qGUV8ozJNG9QO0bYfcj2wbbtV5GbegLPcnG9FrDqhVHqkTxm2mSXv5PsT8mA6H01ri5L538
 giSU/Vb2FJwQYI9/7dnAcDDkTlpgeqcFTf7dhgs3W/DNaopaf3QWLlHwQ4d4ZoaSBaSNHG8Rj
 uWRL967i/HYOalUsUk5R26/AUg4MUx8hL5V6yY6wKqXCa5l34GgkDVtGoZPVIasgdsBPDYFVF
 YmChs6/GdkdHustPMJaI9sBsxD/+3G2pGPkx/Pl7WIHyiJ26M1t1ZkaMOCT7tl0So8SIB4HDy
 WZN6kWxxCqaiIA0zZBUDzXrojajj3VwzZafHo19B7gA4B+vA0WMYyrXNOn46FCcjNpVP/HcCV
 WwPsLwiD09jJKnBPbHa5E5tP+q0BpGZxt5t20m0t0puUIUG+pnHhcCrFTe2x/BG/hmZwXB5FW
 0+brdQWUKcJauRIuNiM8RUn5IWzZgFnQlHLNFWzfn+pOheGh1VpvJbWEOZsvR0EVePm4SiXha
 lEKUOPlHy0erWdgCOH32K5YWNtpo7WNtlGXZNwW8oTitA5Qgt3vLi+w1EgQoLKOFzIQDYhpxX
 5Qt739kQPljKaNZghAqOyeqNgDiEAstEgEbM0/eGhK41mQjOigPqZzpeY4o6R+0JDRoEWbUYj
 rTeXFUmAi9xHM63zKFkUPOr2JcsWVvAdebycxyoxvziJsCTbnkwLBcTQZ5MVhX2+crSTTmkOS
 fYb8fXH4m95PkQghYlPsczN4uRTolQsfzTC+OyFDzVNEM4VZAzKFpSQSDArzWUXQBC+MOCdqm
 91fYPHiR1uHqW6tFsqHYNd7ppVVvuxO1201cpyAGhAdiIITdmNeSoBey3ilnR/kTyoCWj+jiU
 ykJUp0GRpwr1Mq5s2ut/RhXpYFYCKxoXD95c3XVfa/omS6h9rqcDNaCSDeQs7+/MEd0okBRhR
 qH2tahhwfqBQvLzg72aFynL+R+nUYA4e7jjrgblIGJqlozv0vI+uZY72AqaEVC6sc2pdGCN3i
 xoqnyal91BSYvgFri3qDmV5DJYgbt4ZwlyrlDwoa0XJIBRZYi7SHWpZMQ75yGtrhGJfJmwePo
 8BfzoDhkffjSJ2WMPJNtIdPBEFfJPuDhK4ji2NJ5Zt7SJoFWq9ynQYUR1I6HbMD0ACzDnI0HD
 X+pJd61zTXsPZuwYov9BqvF2JaWsyvMZ59LrwWJMHZ9eYNJC243sbA1mlj8vc/7uz42gbEgJf
 +ZwZsiYKEFI1N0uvE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/7 =E4=B8=8B=E5=8D=8812:57, Ritesh Harjani wrote:
> On 21/05/07 07:46AM, Qu Wenruo wrote:
>>
>>
>> On 2021/4/28 =E4=B8=8A=E5=8D=887:03, Qu Wenruo wrote:
>>> [BUG]
>>> There is a possible use-after-free bug when running generic/095.
>>>
>>>    BUG: Unable to handle kernel data access on write at 0x6b6b6b6b6b6b=
725b
>>>    Faulting instruction address: 0xc000000000283654
>>>    c000000000283078 do_raw_spin_unlock+0x88/0x230
>>>    c0000000012b1e14 _raw_spin_unlock_irqrestore+0x44/0x90
>>>    c000000000a918dc btrfs_subpage_clear_writeback+0xac/0xe0
>>>    c0000000009e0458 end_bio_extent_writepage+0x158/0x270
>>>    c000000000b6fd14 bio_endio+0x254/0x270
>>>    c0000000009fc0f0 btrfs_end_bio+0x1a0/0x200
>>>    c000000000b6fd14 bio_endio+0x254/0x270
>>>    c000000000b781fc blk_update_request+0x46c/0x670
>>>    c000000000b8b394 blk_mq_end_request+0x34/0x1d0
>>>    c000000000d82d1c lo_complete_rq+0x11c/0x140
>>>    c000000000b880a4 blk_complete_reqs+0x84/0xb0
>>>    c0000000012b2ca4 __do_softirq+0x334/0x680
>>>    c0000000001dd878 irq_exit+0x148/0x1d0
>>>    c000000000016f4c do_IRQ+0x20c/0x240
>>>    c000000000009240 hardware_interrupt_common_virt+0x1b0/0x1c0
>>>
>>> [CAUSE]
>>> There is very small race window like the following in generic/095.
>>>
>>> 	Thread 1		|		Thread 2
>>> --------------------------------+------------------------------------
>>>     end_bio_extent_writepage()	| btrfs_releasepage()
>>>     |- spin_lock_irqsave()	| |
>>>     |- end_page_writeback()	| |
>>>     |				| |- if (PageWriteback() ||...)
>>>     |				| |- clear_page_extent_mapped()
>>>     |				|    |- kfree(subpage);
>>>     |- spin_unlock_irqrestore().
>>>
>>> The race can also happen between writeback and btrfs_invalidatepage(),
>>> although that would be much harder as btrfs_invalidatepage() has much
>>> more work to do before the clear_page_extent_mapped() call.
>>>
>>> [FIX]
>>> For btrfs_subpage_clear_writeback(), we don't really need to put
>>> end_page_writepage() call into the spinlock critical section.
>>>
>>> By just checking the bitmap in the critical section and call
>>> end_page_writeback() outside of the critical section, we can avoid suc=
h
>>> use-after-free bug.
>>>
>>> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>    fs/btrfs/subpage.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>>> index 696485ab68a2..c5abf9745c10 100644
>>> --- a/fs/btrfs/subpage.c
>>> +++ b/fs/btrfs/subpage.c
>>
>> Hi Ritesh,
>>
>> Unfortunately I have to bother you again for testing the latest subpage
>> branch.
>
> Yes, this was anyway on my mind to test the latest subpage branch.
> Sure, I will do the testing.
>
>>
>> This particular fix seems to be incomplete, as I have hit several BUG_O=
N()s
>> related to end_page_writeback() called on page without writeback flag.
>
> ok.
>
>>
>>> @@ -420,13 +420,16 @@ void btrfs_subpage_clear_writeback(const struct =
btrfs_fs_info *fs_info,
>>>    {
>>>    	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->pr=
ivate;
>>>    	u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
>>> +	bool finished =3D false;
>>>    	unsigned long flags;
>>>    	spin_lock_irqsave(&subpage->lock, flags);
>>>    	subpage->writeback_bitmap &=3D ~tmp;
>>>    	if (subpage->writeback_bitmap =3D=3D 0)
>>> -		end_page_writeback(page);
>>> +		finished =3D true;
>>>    	spin_unlock_irqrestore(&subpage->lock, flags);
>>> +	if (finished)
>>> +		end_page_writeback(page);
>>
>> The race can happen like this:
>>
>>                T1                  |              T2
>> ----------------------------------+----------------------------------
>> __extent_writepage()              |
>> |<< The 1st sector of the page >> |
>> |- writepage_delalloc()           |
>> |  Now the subpage range has      |
>> |  Writeback flag                 |
>> |- __extent_writepage_io()        |
>> |  |- submit_extent_page()        | << endio of the 1st sector >>
>> |                                 | end_bio_extent_writepage()
>> |<< The 2nd sector of the page >> | |- spin_lock_irqsave()
>> |- writepage_delalloc()           | |- finished =3D true
>> |  |- spin_lock()                 | |- spin_unlock_irqstore()
>> |  |- set_page_writeback();       | |
>> |  |- spin_unlock()               | |- end_page_writeback()
>> |                                 | << Now page has no writeback >>
>> |- __extent_writepagE_io()        |
>>     |- submit_extent_page()        | << endio of the 2nd sector >>
>>                                    | end_bio_extent_writepage()
>>                                    | |- finished =3D true;
>>                                    | |- end_page_writeback()
>>                                     !!! BUG_ON() triggered !!!
>>
>> The reproducibility is pretty low, so far I have only hit 3 times such
>> BUG_ON().
>> No special test case number for it, all 3 BUG_ON() happens for differen=
t
>> test cases.
>>
>> Thus newer fix will still keep the end_page_writeback() inside the spin=
lock,
>> but btrfs_releasepage() and btrfs_invalidatepage() will "wait" for the
>> spinlock to be released before detaching the subpage structure.
>>
>> Currently the fix runs fine, but extra test will always help.
>
> Sorry, just to be clear, do you mean the latest subpage branch still
> has some issues where we can hit the BUG_ON() or have you identifed and =
added
> some patches to fix it?

Above race is how the old fix (with end_page_writeback() called outside
of the spinlock) could lead to a BUG_ON().

I believe the new fix, with the same title, can fix the problem.

>
> Let me clone below branch and re-test xfstests on Power.
> https://github.com/adam900710/linux/commits/subpage
>
> Also if you would like me to test any extra mount option or mkfs option =
testing
> too, then pls do let me know. For now I will be testing with default opt=
ions.

Thanks, let's just focus on the default mount option first.

Thanks for your great help!
Qu

>
> -ritesh
>
