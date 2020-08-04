Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038C523B519
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 08:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHDGl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 02:41:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:44321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgHDGl4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Aug 2020 02:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596523308;
        bh=OfXCtDf3D0oe/OLRtODIUfZkDJn9PkeE5hQwfRM7T8E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TZR5py/vaF5PQHYcPk2zZOgXbPyzC73pRI3PCOC/oIBRBgJA8DULfhZzZp02dgFRz
         010k352qvhjKlEbX2Mr9fBkwAHd9Yk9lXc1NvgTK6RlUNlezt7Y/YIopeLmTMnLXU8
         78UZVK3jFq0hTriI8vv1B4VZ958RZGPWfypIKllM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59GA-1k3x6d04Wq-0016S4; Tue, 04
 Aug 2020 08:41:48 +0200
Subject: Re: [PATCH] btrfs: inode: Fix NULL pointer dereference if inode
 doesn't need compression
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Luciano Chavez <chavez@us.ibm.com>
References: <20200728083926.19518-1-wqu@suse.com>
 <6b8fa62c-0c42-a49b-3961-b247ef8abeb2@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <a2479cf1-9b62-6122-52e3-d6c37f44a1f5@gmx.com>
Date:   Tue, 4 Aug 2020 14:41:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6b8fa62c-0c42-a49b-3961-b247ef8abeb2@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Wym95LBR5if509SOK0pD2IYplMhg1pLdqdgyIP5N5RUjtiVLhq
 kLjSIS+ikKCbfHnW0uqeKiK/Yhp6UoPzNCaDDSzSP1M8OpocUhc2z7k+QFGFIV3wEW6I8xb
 wkcRc3TOSJBCLNa6CJQN3gNsDHnDloAsiLy/CWN/CG/pHHyXY3EwInCqUuhm4J4GVULu9LD
 HPwCWxzi7azflLWzhronw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iBRISfiVEuU=:kBpddrzTFW/j+xt4IZF7KZ
 ApQNWjl2/4Cc/b5EsiSbQjYgcuG8NxMeXMOSS4SZff4abEsplsvyf+vDNYxY8TntR66zDa0AM
 dsJnqY9EMbVLR6K/sZ3GJd7ZGEXalzhzoVpO3MRgqdV+ZJ/Yh6ye9rAGJLd0Ox4W+mcVvQKGQ
 bptTS+60loQ7E9I7qHFRCBuqnqQLuhEQGkIPT4WKNlwkz22tN/NB4xzYr0bKng/HAC0Zi6FXD
 siXvjnrsnu2wKj3KO2P5zuRbQrzIQr3oW2V3c9AyAAFGRW1yU4wPT409bV3vt3lkkvIgyY0Sv
 k2pJ/uRrY8jy5rH6o1RZ/MGiATJAyDqKrTPy92uocB/eydTo0CQpB9kXtxZCvjJqIdNM4XEWn
 foeI9Y/o+06kO0+6YeiCsb5U2BczDP9f0FvKKOaKOJikfYZhxaelZYQHiyHbWNrIo/8kujY3L
 Yns6TOyzy/0gH4PFlkdotbf5jOg5DoG5iCvVrqnX5X4CxwzYVDY+QvySw+r7wo50xxjSD9Hsr
 vIL/b6pSscbX17G/Nk9VPE3JAuhhs+dpfm5GwWCX8XhjM9VW9Bx5QjtdUiffWsUJ3lyVxUGKK
 utt+FTCVG8WhhMhAJe80giAYqv8wCXn2rrqGxOU2LJhvLsUE0JpKoTjETvueiU1Xwvn21AhiK
 Xd1PK1I/9brG8AjUZKcNIbRLzqvuJBX5EgQn6sozg75JIdtA8iUCy5792PIF2++mivq6cC0bX
 uB6FigI9rX78xzL7xpHYqTbzKuzmFT09T/ec6ylbZF8J2ZJuNnaP5qWpWIoL7dZKUz4pHpiu0
 ahZrRs3VsP+q0gS51dOLTL7LML3Tyb7Qj1nb9IkJWwxMO3e2qE8WPHprqhhXI9zuGT2HyyuYP
 y6AXKqZ8UckAVNMDy9MciSDbe1XH2m1/Hv+B+Uc77XWTbf+Qs92HNKNRsereYSfwC83UsVi4M
 ZU9A71Fwcecbb2N4JPgz1ED+OwuWMQvQv0IUFJfO8rqGIzmmP4RQn8xiIgU+A7cLdfzurEzmE
 O/p221r5/W+6cVsuPvI3B7A3OMlKFkOv6vIjkaKBNt23zbJbRrStpl7ugfv19+BpZ+ll3nUIt
 1dJQH1/hUBTi26x5Ql9b6tXwtx0B264d6f1BPUfd/0b9QDX/JG1wBMndJPX7qQw4wc7wyITMq
 F1/8QKFNyGFlrwHMUwVR+xextDGs+du1Wo8rLEeYTNL+gUwIySldGSfMcYugV15vWlzka+G8D
 Lm0hbyQi/lGMArwlgshTXNc4ERDo0uAHEOLWdjg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/3 =E4=B8=8A=E5=8D=883:16, Nikolay Borisov wrote:
>
>
> On 28.07.20 =D0=B3. 11:39 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> There is a bug report of NULL pointer dereference caused in
>> compress_file_extent():
>>
>>   Oops: Kernel access of bad area, sig: 11 [#1]
>>   LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
>>   Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
>>   NIP [c008000006dd4d34] compress_file_range.constprop.41+0x75c/0x8a0 [=
btrfs]
>>   LR [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [b=
trfs]
>>   Call Trace:
>>   [c000000c69093b00] [c008000006dd4d1c] compress_file_range.constprop.4=
1+0x744/0x8a0 [btrfs] (unreliable)
>>   [c000000c69093bd0] [c008000006dd4ebc] async_cow_start+0x44/0xa0 [btrf=
s]
>>   [c000000c69093c10] [c008000006e14824] normal_work_helper+0xdc/0x598 [=
btrfs]
>>   [c000000c69093c80] [c0000000001608c0] process_one_work+0x2c0/0x5b0
>>   [c000000c69093d10] [c000000000160c38] worker_thread+0x88/0x660
>>   [c000000c69093db0] [c00000000016b55c] kthread+0x1ac/0x1c0
>>   [c000000c69093e20] [c00000000000b660] ret_from_kernel_thread+0x5c/0x7=
c
>>   ---[ end trace f16954aa20d822f6 ]---
>>
>> [CAUSE]
>> For the following execution route of compress_file_range(), it's
>> possible to hit NULL pointer dereference:
>>
>>  compress_file_extent()
>>  |- pages =3D NULL;
>>  |- start =3D async_chunk->start =3D 0;
>>  |- end =3D async_chunk =3D 4095;
>>  |- nr_pages =3D 1;
>>  |- inode_need_compress() =3D=3D false; <<< Possible, see later explana=
tion
>>  |  Now, we have nr_pages =3D 1, pages =3D NULL
>>  |- cont:
>>  |- 		ret =3D cow_file_range_inline();
>>  |- 		if (ret <=3D 0) {
>>  |-		for (i =3D 0; i < nr_pages; i++) {
>>  |-			WARN_ON(pages[i]->mapping);	<<< Crash
>>
>> To enter above call execution branch, we need the following race:
>>
>>     Thread 1 (chattr)     |            Thread 2 (writeback)
>> --------------------------+------------------------------
>>                           | btrfs_run_delalloc_range
>>                           | |- inode_need_compress =3D true
>>                           | |- cow_file_range_async()
>> btrfs_ioctl_set_flag()    |
>> |- binode_flags |=3D        |
>>    BTRFS_INODE_NOCOMPRESS |
>>                           | compress_file_range()
>>                           | |- inode_need_compress =3D false
>>                           | |- nr_page =3D 1 while pages =3D NULL
>>                           | |  Then hit the crash
>>
>> [FIX]
>> This patch will fix it by checking @pages before doing accessing it.
>> This patch is only designed as a hot fix and easy to backport.
>>
>> More elegant fix may make btrfs only check inode_need_compress() once t=
o
>> avoid such race, but that would be another story.
>
> So why not do the elegant fix in the first place rather than adding
> cruft like this hotfix which later has to be cleaned up when the
> 'proper' fix lands?

Tried that "elegant" method, but there are several hidden problems:

- We still need to check @pages anyway
  That @pages check is for kcalloc() failure, so what we really get is
just removing
  one indent from the if (inode_need_compress()).
  Everything else is still the same (in fact, even worse, see below
problems)

- Behavior change
  Before that change, every async_chunk does their check on
INODE_NO_COMPRESS flags.
  If we hit any bad compression ratio, all incoming async_chunk will
fall back to plain text
  write.

  But if we remove that inode_need_compress() check, then we still try
to compress, and
  lead to potentially wasted CPU times.

- Still race between compression disable
  There is a hidden race, mostly exposed by btrfs/071 test case, that we
have
  "compress_type =3D fs_info->compress_type", so we can still hit case
where that
  compress_type is NONE, and cause btrfs_compress_pages() return -E2BIG.

  This would leave @pages uninitialized, and cause NULL pointer
dereferences again.
  I would fix this bug anyway, since it's still possible to hit even
without the
  inode_need_compress() removal.

I will still try to send out the patch, but the benefit is really small.

I hope some refactor can happen for compress_file_range(), which is
really far from elegant, and race-prone already.

Thanks,
Qu
>
>>
>> Fixes: 4d3a800ebb12 ("btrfs: merge nr_pages input and output parameter =
in compress_pages")
>> Reported-by: Luciano Chavez <chavez@us.ibm.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/inode.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 611b3412fbfd..9988d754e465 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -653,12 +653,18 @@ static noinline int compress_file_range(struct as=
ync_chunk *async_chunk)
>>  						     page_error_op |
>>  						     PAGE_END_WRITEBACK);
>>
>> -			for (i =3D 0; i < nr_pages; i++) {
>> -				WARN_ON(pages[i]->mapping);
>> -				put_page(pages[i]);
>> +			/*
>> +			 * Ensure we only free the compressed pages if we have
>> +			 * them allocated, as we can still reach here with
>> +			 * inode_need_compress() =3D=3D false.
>> +			 */
>> +			if (pages) {
>> +				for (i =3D 0; i < nr_pages; i++) {
>> +					WARN_ON(pages[i]->mapping);
>> +					put_page(pages[i]);
>> +				}
>> +				kfree(pages);
>>  			}
>> -			kfree(pages);
>> -
>>  			return 0;
>>  		}
>>  	}
>>
