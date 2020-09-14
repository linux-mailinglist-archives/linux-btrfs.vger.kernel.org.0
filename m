Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA5268720
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 10:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgINIW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 04:22:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:38909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgINIWw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 04:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600071762;
        bh=w9/bKl4l0gm6TaZN4ABpgZKAIYwVaJjqbn/9BpZuoqE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dNEJRfkqbSHsy7BBBsWA2Jehz2uZALJon67uamoJcXcjz5hkO52wH3G9Mwafswhp8
         IVjdsTaD55ck5r7dH2TY/pw8hrwYwJWs8Ti+wrvcS7gX2Siovr8luAzhFgpxUapU7z
         FPRBCbJ3QunQUKZVEOEmcWPwxVZp/1M6BgqFNVYk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtfNf-1kVPtV0eTf-00v4OP; Mon, 14
 Sep 2020 10:22:42 +0200
Subject: Re: [PATCH 03/10] btrfs: Simplify metadata pages reading
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-4-nborisov@suse.com>
 <d4a8e47d-04ea-79dd-3dd9-0080b611112b@gmx.com>
 <7a1ae6a0-30d9-63de-f3f9-2b6f3c9653f2@suse.com>
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
Message-ID: <81ec5378-3ed0-7cfb-eab1-93c958fa426b@gmx.com>
Date:   Mon, 14 Sep 2020 16:22:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7a1ae6a0-30d9-63de-f3f9-2b6f3c9653f2@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w3WJDfPwtRXhQjt4qQu2CR+CpQ5pG//SZsTDguHFpJa3Fx9h7HG
 6wALGuL2rzNAxWGbLBzIgXD4Nn7UY2huN7sPVPeIgCLs9e3qezlkzJrTH3gcPmuHgBkyLXb
 7ZG2saRxLQoySprC7J2eW/xSTNbEj/cetlz2WdpVOw5eU1lMglEXOo1bnVz9TrW3ygKmEuE
 wODhs6JXdSKzvINJwy5pw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYmASMgrghA=:SpAyugTKjGV09RebBE8NiH
 Q6BAPmVu5NzaScGOM8vqcfxj8ZtGul7FnNqDVta3Z7PoxtztaKm0moX3R1QjXdfvJDeEJDSnV
 fjGtx5XEVhOk7Oo4pufsvZQMs0AmRr++qZpS8kHEg551lYUPbTWiRizdLyE7mPyoN7J+BTvcm
 HjanTPn1Vg2ukqAiPON9QalnkpdHyK4qaCBHMK2/8jjKdVSmfnIMIudtuFDko/+l11wh9y0UX
 W+3oSFSXGGc2odjYo1N/0eZOd22S6B/rRlV7rZJbHZjEfRiJzTCKqLrOW2HmUGPeVlF/ag9PV
 kQcY9IZPuxCgeVwbbyQjRtRxDxFmrI5JhLEPMf7J4Y/t2MtQ/dd03mD1n9yO8RxptEioxwMro
 LggLNLC/Wg9i17v+H1314cCK1EYQbPxq6Bd2B8e//VX48VXDoQEoc6USmcNItRG86jDcCxSYZ
 vZCGbjlcr+YOe+j4nodLXGNTsDCDI5GkpLsA1dq0UTIQ65jmxzd/p3Tp5/liwIaQZMJEdgT03
 PLxhd5/PolRBkK8hMn0oEXD8Pl+uega/7lsKicxIHlwnYhTY61oNDKbIcAslamho6slfxSAKC
 if0ExM6OM/dbhFJ0/99qVkHbxAu9aznJAaUDtT8/TqmG7J7+6Bsx1NQblGwIbayOzKyS10cq1
 4iHq7Ll5Id+frkdvva4BLOTleFyPsLnsH5ICXgWTW7gPgFkbk/Lzbw2AQ2aNflJZiZEgXNYQ5
 9zl/8CbZle0BfGpR4kui7hi4RxXTGpg1PvpSYhoiMCa4TkGCmRmT7oqUzACVtBZbC6WFPyVJc
 WzaDkX9PDLjaYfeen/XlmYP7pWMr6CmJmg0XynuA4ZGb4eb5QUhatlxnnNwx/1jXggy1v8vaH
 +cN9E+eSSN7ATzF4toEd1jRQj6Nqb9MCrcBMGcVJYhWXu3cP+MBk+UGfYPo88Gs2WzOuTgqMU
 7f0PSGvP0/0+xQ8gaV3yFr1eJG/fULuEbMyMNCcxSfwFbZJDNN7D11DDuc7ijZ8+LY32bwpJX
 VX/OIin0YDYwl1jMjTXScqIXlkE/rmNtamYnWQpPk2vVeZf4qmd2dOiGBhATFl4P3accFKVB7
 JUJZpO9FcAEy1bZhuhJXHmoWzIMccUOWR7wR2ZbH+nmN+0Siij0WmDr32PRYb1NJtqW81c3ek
 qD2y4dee7FSxqfbdQAkHKvRTjB6C1ukYY0o3OuxV+34izaPKTFHBs6cS80yDUPdVF3AdoRCew
 T3RpbeYUk6e0YVOkBTBZUH2plqctmsDgC1FpjvQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/14 =E4=B8=8B=E5=8D=884:08, Nikolay Borisov wrote:
>
>
> On 9.09.20 =D0=B3. 14:20 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/9/9 =E4=B8=8B=E5=8D=885:49, Nikolay Borisov wrote:
>>> Metadata pages currently use __do_readpage to read metadata pages,
>>> unfortunately this function is also used to deal with ordinary data
>>> pages. This makes the metadata pages reading code to go through multip=
le
>>> hoops in order to adhere to __do_readpage invariants. Most of these ar=
e
>>> necessary for data pages which could be compressed. For metadata it's
>>> enough to simply build a bio and submit it.
>>>
>>> To this effect simply call submit_extent_page directly from
>>> read_extent_buffer_pages which is the only callpath used to populate
>>> extent_buffers with data. This in turn enables further cleanups.
>>
>> This is awesome!!!
>>
>> And the code also looks pretty good to me.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Just a note for further enhancement inlined below.
>>
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>  fs/btrfs/extent_io.c | 18 ++++++------------
>>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index ac92c0ab1402..1789a7931312 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -5575,20 +5575,14 @@ int read_extent_buffer_pages(struct extent_buf=
fer *eb, int wait, int mirror_num)
>>>  			}
>>>
>>>  			ClearPageError(page);
>>> -			err =3D __extent_read_full_page(page,
>>> -						      btree_get_extent, &bio,
>>> -						      mirror_num, &bio_flags,
>>> -						      REQ_META);
>>> +			err =3D submit_extent_page(REQ_OP_READ | REQ_META, NULL,
>>> +					 page, page_offset(page), PAGE_SIZE, 0,
>>
>> It would be better to enhance the comment for submit_extent_page() of
>> @offset.
>> It's in fact btrfs logical bytenr.
>>
>> For metadata, page_offset(page) is also the btrfs logical bytenr so it'=
s
>> completely fine.
>> But it can be different for data inodes, so it's better to make it more
>> clear in the comment.
>
> How can it be different for data node? page_offset is always page->index
> << PAGE_SHIFT, meaning it's the offset in the file that this page refers
> to. I.e page 5 would refer to 20k.

For data inode, its page_offset() is the file offset, not logical bytenr.

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>
>>> +					 &bio, end_bio_extent_readpage,
>>> +					 mirror_num, 0, 0, false);
>>>  			if (err) {
>>>  				ret =3D err;
>>> -				/*
>>> -				 * We use &bio in above __extent_read_full_page,
>>> -				 * so we ensure that if it returns error, the
>>> -				 * current page fails to add itself to bio and
>>> -				 * it's been unlocked.
>>> -				 *
>>> -				 * We must dec io_pages by ourselves.
>>> -				 */
>>> +				SetPageError(page);
>>> +				unlock_page(page);
>>>  				atomic_dec(&eb->io_pages);
>>>  			}
>>>  		} else {
>>>
>>
