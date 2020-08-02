Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD68239CF6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 01:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHBXOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Aug 2020 19:14:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:40083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgHBXOj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Aug 2020 19:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596410072;
        bh=qOoMHx0UV1YUHJCK/E/cEa2drUzkdzSaGfNS3Ak78BE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PxDnnqcP+d+tqSM1QH5be5NJOWrPRgZFgc5TA8Hdg7gWS4KlyG0CL+nqvq+regWbw
         AYV90DyumjjHYu01a/nlMmClZvNABTC9S0K5VQjBtHo8SJTcV7it/xvhhNyM8XBhiG
         IuDuOWBKFkw8bsOTU/Q7cnRa+UHPAb2dXTx2uJL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1kYBIo1HET-00qAgv; Mon, 03
 Aug 2020 01:14:31 +0200
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
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <25e2bcc7-efb8-f9bc-ac00-c8d5f5bbba53@gmx.com>
Date:   Mon, 3 Aug 2020 07:14:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6b8fa62c-0c42-a49b-3961-b247ef8abeb2@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KyuluIF7zmWHAYcar8eIGKV1skOmPnEzWuNPw5H07szn1veaG1V
 xtyyUKYRnRmWK7cSQrpk+xd6x89MtG7oliNBzMFHS90iNL8kK+sjMZbg44yRpvkI2kBxTms
 mxEgVlHWTNMlQHy3Md1sy9cRMI+cGwXhB2pi2xwVH+pcZO3BHOzbzpTZYNGILDL7skarCbN
 WUuVFbvx1ho6lTQHzrAog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vw4MzuewKCM=:v7InWGQV4jZ9fa7dhjq4l4
 PtfPCAUilfZXSGlgrG5xatX8Q4FxoJMtKLO4g0IEmRYJbuodAsjES6f1ZpQjJIof+TTeajnas
 wMEpagWXqaOLcCN/Jp56Dlm0EjFl1J/cYoBqLkV8ai32V3JrVNGZBIT2er05eKctzDDLYsM7d
 9hpQxxVVYsO8QMs5vg4xF8GUXVi4OfgnAWezxM5CpBG+IO+FxUYBBlV+mqwaasN3ao7wor5rc
 R8l+Qc3Eze33T7d8ynp/GA/kL7O1b9BtRV3jppDmpDC8F5OT2z964ftLhRdY1NVuEq5z7DViy
 PdkvDHYpbcV6s5IJKZUBLuvS0UfsoxnWk08pVslTxuflCnywXhhk/SNjZauQH2DJIuR3QsiLb
 MiA/vW1sQp3yDd5C99DMoHKMC4MDTuce7uf9pc4kXGUOCe2SdEaZbJ5+O7wsHQ9MZRssb+nLc
 0mko3cUqBnb/6LYA2Kt71KuEwmD/Ts+g1RV4aZXQ3oEOMLZmGiWVAffpfAB0Mrz/JcY+H/J6o
 hrCet5Lbb9g+QtlkzXqnMDYpBms2v4pMisHRmFSyoAK7B0BULUrwD1MZUV2CsZbRhH+6umy7+
 t/miLdtQXFZH57zmE50QfznwEU5ZI38R6kMUO4+6OowXDAv3u+6JeuH3rq+KGK5R/UOSQxsfN
 NUY2Up7Vb4b7IL8fazOdLE9kgd9d8c/apgaT+VsDEq2cU9oWevmT2En0b7IXc/odnbi/c/5YH
 6YHqT1E9qS77aJwgPNsa2hGmzKzNrTIUXp+rnggUKN/d3x+RYb50weDw5NWmc+JoZA8ccXGnb
 m7A5jiVw/KtBXS8KpA5EZRcFVFKYJDFVvLyQ4dC4H+MwZTN+mylf60zMMEMFYG5mJuisPrVZP
 MjHGFxgjCf7nAfdGkEkpFdHw8FUGz3MqbTRPyMSicsf9ku0lbUNOtzAk+Yw1emdkGmByi+pHF
 q+Rjpx1eeDPkhbZ7NeYBPenk7zHUvbId5lcfsF3PeI7b8h202UhKaELlNXIyVX9x/OoWZQ6LX
 HxspV9vFjhwES+6qdvUW2u9H9q+MGjBT5Te93t5KGpnT/xecWpKfvQR0yR6d1yrbGlolA8Oi/
 r/N0MhAJLrgK+p1/WQ49bOo2Rlkr7F7QBwPWkbX/nMUDgp4n7ez6V2s8YHcwrRmkvX2Cc5O0p
 e4LiI6oxhfaB1+uOh3wL6FneWYyY8X/17APlcb2xzZXju/30wRFQGEGK3JGNPg9X0sgRM93IO
 2U+hX87LB/pR4aUmtC4xvv19T4H2J9PCVBTtP6g==
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

For backport purpose.

This is reported from one vendor kernel, not upstream.
Thus backport is definitely required.

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
