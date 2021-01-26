Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70610304691
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 19:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbhAZRWb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:22:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:53587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbhAZHXb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 02:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611645710;
        bh=9qEqU01oDsMhy0kSU05mHbYOsKXvWE/duHoyKBvbpvQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BQ7mOftwsNEWDuWo455HMKLu1UCfZYM04CfXT5AZ6cbeXuc6mcj+wg4SWK7o3igWE
         2H3qwVy50mW68G7OlG8yVVyrDpVRjmZtUaX//58FODxtZTFhTLhdChchhqwviwMmC3
         Vqew8G1Hd8vWatZQTiuxlgxNSsS9S8cV+x6eSCP4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmUHp-1llv1o2TkP-00iQpt; Tue, 26
 Jan 2021 08:21:50 +0100
Subject: Re: [PATCH v4 08/18] btrfs: introduce helper for subpage uptodate
 status
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-9-wqu@suse.com>
 <65d45aa9-5a84-9885-2e05-77435161cbbc@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1b5f7a24-e2e7-d289-44e5-b47adeb6b329@gmx.com>
Date:   Tue, 26 Jan 2021 15:21:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <65d45aa9-5a84-9885-2e05-77435161cbbc@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:01VVcY07I9JV1CJW5ZXtxbLqLVqxJk8j8/wZpF2Xn5Q6iwd3/iU
 kmS0dyTcneFqIZ/8mjXEwK3gay4Jr+Z4PC7HdqjIHypvfePMK6OYnbt0dvg0V577vHt+FbB
 3i1f1FLPbMec+EdegRQegnO/Dp8lRHCna0UsjYsvv0YMDqfvkqg/16g4xdPmerI6nsZozBq
 PUcak1ui/W73Gu/wz+NdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rmxQu+pRowM=:cvUiMxp9ALIx7DAyWsK6Jv
 53srx9YuoymLJk83wG9mfIET1Z+QrG8cscAHNX2l7EjRt7VBvlRLX6+KraRIVewYzvrKE7q+K
 +LV+yzycqoApAiOdKFQGnVMSkvYSY9eEEApz+jaZ8EE/sDJjPcjLpcWdaaFNQLEpLysKO6VCS
 hxexQsSlCmkYTDVO9cxnm7DiqQ/p3odBQHQi4WomHVWKovnkUTBdlJTfhs2YuCwRF3U3/Hbto
 ojNlUW9zZ9pSvzCEmZoV+xob+hlEoxhTxlSf1hCGiPovXE3FuWb1ry7xI2u0OnoyFtJAI5+Tt
 L5Rkk/JoWkzIj6pYeQoWlcdw2DFxqdGW6sGrqoUNTmayb7BFIxtWbtUpoo6yuhmJjkO3EW/Wv
 /JyLiTpKtG2lY0ycpgJjWeRGjcJiYQ3HQYqdcH8OZpplNpKMJ96+1aiwlDgEkxy8avmlVpBe7
 5ez7h1xv1E/XdFarJPYOKm08tXhj8YBoRmi2OcoMatmBiKrDoxOpGWT8X5oTf/B3ELX6cwS50
 UVVep0gQNo9i9qaGFyNpS36IvoL/pwIefPj7NH9cDLnmedpR0HKtfO9bNlFCKmEUK7nANUoip
 E1E83yeL+LMsEQXKHM8fQzeXpT7raPxMA4GnsTgZUWOY0rGBHybe9ISJtXiA+Q20vnomeoWhR
 PUJt3ygd/qMw0LM02I3JtLJa6ROMK3D2+cd7JoVKXVoYeb1InA5EW6JJc8bUw7X3+bqjXHOOw
 I39leYneBGyQRpV4G18jJWHfJEX7GvA2oeAf+dwpZhcCE4ZztZq1kWmSZNtb5gXuzgP4xX33Z
 aRs9gcyAjfYHsawsPav0sQQM/GEoiAkFMhzVtC8UHXq9coD17NdWkh84VTV8W437fDnVo1iuD
 kK4l0mWRHlaAQh1LBF2g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8B=E5=8D=8810:55, Josef Bacik wrote:
> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>> This patch introduce the following functions to handle btrfs subpage
>> uptodate status:
>> - btrfs_subpage_set_uptodate()
>> - btrfs_subpage_clear_uptodate()
>> - btrfs_subpage_test_uptodate()
>> =C2=A0=C2=A0 Those helpers can only be called when the range is ensured=
 to be
>> =C2=A0=C2=A0 inside the page.
>>
>> - btrfs_page_set_uptodate()
>> - btrfs_page_clear_uptodate()
>> - btrfs_page_test_uptodate()
>> =C2=A0=C2=A0 Those helpers can handle both regular sector size and subp=
age without
>> =C2=A0=C2=A0 problem.
>> =C2=A0=C2=A0 Although caller should still ensure that the range is insi=
de the page.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/subpage.h | 115 +++++++++++++++++++++++++++++++++++++++=
++++++
>> =C2=A0 1 file changed, 115 insertions(+)
>>
>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>> index d8b34879368d..3373ef4ffec1 100644
>> --- a/fs/btrfs/subpage.h
>> +++ b/fs/btrfs/subpage.h
>> @@ -23,6 +23,7 @@
>> =C2=A0 struct btrfs_subpage {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Common members for both data and meta=
data pages */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t lock;
>> +=C2=A0=C2=A0=C2=A0 u16 uptodate_bitmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Structures on=
ly used by metadata */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool under_alloc=
;
>> @@ -78,4 +79,118 @@ static inline void
>> btrfs_page_end_meta_alloc(struct btrfs_fs_info *fs_info,
>> =C2=A0 int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct p=
age
>> *page);
>> =C2=A0 void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct =
page
>> *page);
>> +/*
>> + * Convert the [start, start + len) range into a u16 bitmap
>> + *
>> + * E.g. if start =3D=3D page_offset() + 16K, len =3D 16K, we get 0x00f=
0.
>> + */
>> +static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info
>> *fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str=
uct page *page, u64 start, u32 len)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int bit_start =3D offset_in_page(start) >> fs_info-=
>sectorsize_bits;
>> +=C2=A0=C2=A0=C2=A0 int nbits =3D len >> fs_info->sectorsize_bits;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Basic checks */
>> +=C2=A0=C2=A0=C2=A0 ASSERT(PagePrivate(page) && page->private);
>> +=C2=A0=C2=A0=C2=A0 ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IS_ALIGNE=
D(len, fs_info->sectorsize));
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The range check only works for mapped page,=
 we can
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * still have unampped page like dummy extent =
buffer pages.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (page->mapping)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(page_offset(page) <=
=3D start &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sta=
rt + len <=3D page_offset(page) + PAGE_SIZE);
>
> Once you gate the helpers on UNMAPPED you'll always have page->mapping
> set and you can drop the if statement.=C2=A0 Thanks,
>

I'd say, if we make ASSERT() to really do nothing if CONFIG_BTRFS_ASSERT
is not selected, we won't really need to bother then.

As in that case, the function will do nothing.

For now, it's a mixed bag as we can still have subpage UNMAPPED eb go
into such subpage helpers, and doing the UNMAPPED checks in so many
helpers itself can be a big load.

Thus I prefer to keep the if here.

Thanks,
Qu

> Josef
