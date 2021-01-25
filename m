Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C5302594
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 14:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbhAYNhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 08:37:12 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:39260 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728935AbhAYNhC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 08:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611581745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pkeXNb3MAOCYEvqm/1+KIily0SObGY1hi9CYEBmfVs=;
        b=PfS2VWqvFhlHrzh2kK6f4F7rrrRrYyGZFOfT/DN79X0Z3SBEKlO3DYTtwPHRdDiXFYbQz4
        OGbprqJRtiSLHtuXQ6yx/25B5RpZg5+3wojmTJoidEmreAky/MQxAEpN0xQGzzSXNIFJS7
        RGIbE3AgkEHjYf1EaDMLS138N5ajC/o=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-8VyWRjvwOUOF_xkQkyT9yw-1; Mon, 25 Jan 2021 14:35:43 +0100
X-MC-Unique: 8VyWRjvwOUOF_xkQkyT9yw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY4/w6VkOMGok2oqhs7eunpQbhM8cm61nVC+ZKjMWYBPuPzCmpNQGTYYpmq+qwM7yQwbzPXBLkeqY2AxDkfb1uF1S89VVPvJvY7neH4qn1mlfAd4/gMeL0Jaq9el86tj7gcsP3QkoSHXfQeynP51QPHpNEhaCSwVP4jFpMS5esgCBaSLVec+OUrxJ4nFu8rXK7zuyKFcjBk3bKuzIDYwNoi0sVeVLVrZ+3KuEsH29kqnaFE27g+L9qYqfkBzQBkemvFbU4DsqbWV0RXCZcyJ6vQm8ZrgJ6MRZc3bE5Fk26Mgvv3APvZcAdtypjCFxpW56rUOvi9OPqkKLvj87G2IXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APeJ7HVW7yc3dv7u1iS98AbUHkU69xmEl4YpAO9Kkfc=;
 b=BSZkme129pbSrsnhdB8ZNMypY4X/SAnEVM7NtU26TDUtGlGPZ/4CM/5VwbH5rqXxsrq0x1MkxvYHiWu4OiTEsE0Jm7dBZvTfEo6kH3JXUugR96Kk8DudxKfRi4UCRGc7Zfi+0RIWFWWxrR+DiqyXfkIJyPZbQ5To1GrjKLpLaL7ODExr6dR1/jqbCbJ9DzyBxB9XKYAgIBNVj7SUk2ph8VtjDYy/cUGvYn7pxGZp+8mYlgQEL14PBJdke2RPenVjrEplvB0fEXT1dIsmXEcmJ712qaowvinK40aUW21P+DnH5pOxasq/JmhQkgjQ2kLNQBuC/IP82b8mzU5aYISTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VE1PR04MB6653.eurprd04.prod.outlook.com
 (2603:10a6:803:122::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 13:35:42 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 13:35:42 +0000
Subject: Re: [PATCH] btrfs: rework the order of btrfs_ordered_extent::flags
To:     fdmanana@gmail.com, dsterba@suse.cz,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210121061354.61271-1-wqu@suse.com>
 <20210121164706.GD6430@twin.jikos.cz>
 <CAL3q7H4D_Hu=Xk0+dazruwnqwW7+kqdS3VXTxQ5kWSe+EuT8kg@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <616293a7-1bee-f256-ac47-02d5c0750da6@suse.com>
Date:   Mon, 25 Jan 2021 21:35:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CAL3q7H4D_Hu=Xk0+dazruwnqwW7+kqdS3VXTxQ5kWSe+EuT8kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::13) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0128.namprd03.prod.outlook.com (2603:10b6:a03:33c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 13:35:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 434a943c-4735-46b0-c595-08d8c1361be6
X-MS-TrafficTypeDiagnostic: VE1PR04MB6653:
X-Microsoft-Antispam-PRVS: <VE1PR04MB6653A7792319595227C39FD1D6BD0@VE1PR04MB6653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jpz2VIsUen4sjd5LbYuNJO7xXEoeD986PByeyJu7OMkY0j69Atn20L3DBUyI116CBIdFX/Frc5niWs4vrz91d1oSXt6gyWM+q0fuMuFgTBMr8dvDj7ScWxcxfqOd6sgtzNh0G7wr+5MfKFMYjLAKk7WQ1r1uU1i/EA0eW/lx3RaLmoot3zA6PezTwDeKBhGnnFCeZpjY94HJGMv0CGXV6N5FQgd54+DZYn8Yj+u5K/MIy9oFcbAi3mnGIEIxJxsxboaykx7DJ0Qh0p6MQkvczRhisl1wRC1zc7ddXAzmL9irItDElbPlZQMVSgpUWlLg2pab9N08b5pN2HXt/774kVQMZIYOFnjb8S5tlDIdWumYiYnKjLEsnrrLXyukMdRvlIv8TQ7X1MY+HjJnXutD8synyj9g3LV6h+hGJX1TNRB7VOwcDLhL04PDyMN10jjrY9/pR6ymjjgdswScWWVCcH41NE9aqfo2Ll8HYdZbFluQQElr25N3DFZ3BMmsVae/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39850400004)(136003)(366004)(8936002)(6706004)(6916009)(478600001)(66556008)(5660300002)(86362001)(36756003)(6666004)(26005)(83380400001)(8676002)(31686004)(66946007)(316002)(2616005)(66476007)(53546011)(52116002)(6486002)(16526019)(186003)(956004)(16576012)(31696002)(2906002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?clQPdKWyVGLSNdAt7WzXzz3gjb9srot9PyFUO8/vEzblnmDWd1plNoR9gUG4?=
 =?us-ascii?Q?8UltY1arteRVKVTFymO/Ixm67gLhE1rTxcsMNGk0tpUoaCmmY8CSiWmRmvNc?=
 =?us-ascii?Q?VUhrFyaBg9+IGnFEnmx7lBKmGJqX/aCC53767gDvSvNyIVKDHAV41Kmlt4bY?=
 =?us-ascii?Q?inQniqMTaEslvVMeP+b3vv32dkgnceBoGdFxVqXTxPMpQifyosIrd5ZvdxDr?=
 =?us-ascii?Q?t9uIQoABPJiX/0YC0Wpe5SYCmxy9yX+EInZKauqA3Ww8Wd91azW/GZKYXG9R?=
 =?us-ascii?Q?BlOLhm1dYT2HKYBA/gOZqH8TUQXw0X2xREOJTZk5iMR5qjyg9ETrVPBGMULY?=
 =?us-ascii?Q?uhGx6J7gCvOoTlqzO4t7t98c98mB2xdylF1VcQJKPEUhNTMSx6ZnMwGbuk6j?=
 =?us-ascii?Q?69EeXAHKL6G6dimBHkNZvlEl23OMmTtlGv0nrvMdH1Oo5HxYIImcyGSrmR6v?=
 =?us-ascii?Q?WT/H1Rk/zBf3biUYVXVAtV3Oy9+J5AzasYW6lpgrfl45j+GlBDfg0i8EnzbP?=
 =?us-ascii?Q?8jKHqA/beVxDXOwUi2kTF7l/zjzcjqEvbrr68/Nyh2cUyXY/maG1QrPiWLBo?=
 =?us-ascii?Q?Ek5Hhyis/focTFmhtSQ/F4b4ZN5hX2+R3Y0hTc6OeaYvPg5+2UbJgkpjaBDf?=
 =?us-ascii?Q?zr8biakstNB4+SbIeEo0Y3rQM2svGbSq386A0BcU5iihwTedqOWmgfD0atR/?=
 =?us-ascii?Q?zMS+zyezwv+tG0r6T2fTqCfjyL71Tf8SgB6bqo8skJp2IFvXcCzleqGj7aTn?=
 =?us-ascii?Q?IE7n1uw4244gCjfqSBPSsdYGCh4SsXZfMP/buj6d7XFsJo/Py9jxoczAJCvI?=
 =?us-ascii?Q?VL8XzYhT4uMovgWMzO//JhwB2I7V7p0VqWV2mNfgKB8wOriH7l491wKlIWTw?=
 =?us-ascii?Q?ZX0XfKMe4uzGp4BX9SU17DibnktOpwY3hdT7m153iGr/BfTgUwBZKILV+0Sd?=
 =?us-ascii?Q?LkomsaAiVmvfxKA/UdTdPnhpAL9WaHlPJ7Cv5CiwLJQgz6MDFLIkudft3ejv?=
 =?us-ascii?Q?ouBzUq85b7pdMcdlDh8p54rg9aOfQmkua2/3SXJ3BM6D+xmVuJHEZGkNcNVT?=
 =?us-ascii?Q?msSYeAi3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434a943c-4735-46b0-c595-08d8c1361be6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:35:41.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqBclCk6SM+ulWjjvOKuj1OuP3DPb5Ef4gW2fTuP3X6nDgaFaIOkuR6vVWy3gLcL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6653
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/25 =E4=B8=8B=E5=8D=888:15, Filipe Manana wrote:
> On Thu, Jan 21, 2021 at 4:52 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Thu, Jan 21, 2021 at 02:13:54PM +0800, Qu Wenruo wrote:
>>> [BUG]
>>> There is a long existing bug in the last parameter of
>>> btrfs_add_ordered_extent(), in commit 771ed689d2cd ("Btrfs: Optimize
>>> compressed writeback and reads") back to 2008.
>>>
>>> In that ancient commit btrfs_add_ordered_extent() expects the @type
>>> parameter to be one of the following:
>>> - BTRFS_ORDERED_REGULAR
>>> - BTRFS_ORDERED_NOCOW
>>> - BTRFS_ORDERED_PREALLOC
>>> - BTRFS_ORDERED_COMPRESSED
>>>
>>> But we pass 0 in cow_file_range(), which means BTRFS_ORDERED_IO_DONE.
>>>
>>> Ironically extra check in __btrfs_add_ordered_extent() won't set the bi=
t
>>> if we're seeing (type =3D=3D IO_DONE || type =3D=3D IO_COMPLETE), and a=
void any
>>> obvious bug.
>>>
>>> But this still leads to regular COW ordered extent having no bit to
>>> indicate its type in various trace events, rendering REGULAR bit
>>> useless.
>>>
>>> [FIX]
>>> This patch will change the following aspects to avoid such problem:
>>> - Reorder btrfs_ordered_extent::flags
>>>    Now the type bits go first (REGULAR/NOCOW/PREALLCO/COMPRESSED), then
>>>    DIRECT bit, finally extra status bits like IO_DONE/COMPLETE/IOERR.
>>>
>>> - Add extra ASSERT() for btrfs_add_ordered_extent_*()
>>>
>>> - Remove @type parameter for btrfs_add_ordered_extent_compress()
>>>    As the only valid @type here is BTRFS_ORDERED_COMPRESSED.
>>>
>>> - Remove the unnecessary special check for IO_DONE/COMPLETE in
>>>    __btrfs_add_ordered_extent()
>>>    This is just to make the code work, with extra ASSERT(), there are
>>>    limited values can be passed in.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Added to misc-next thanks.
>=20
> Btw, I see that you added a Reviewed-by tag from me to the patch.
> However I did not give the tag, not because I forgot but because there
> was a small detail in a comment that should be fixed, which was not
> addressed in misc-next.

And that comment update should not mention directIO completely.

Should I resend the patch with proper comment updated?

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>>> ---
>>>   fs/btrfs/inode.c             |  4 ++--
>>>   fs/btrfs/ordered-data.c      | 18 +++++++++++++-----
>>>   fs/btrfs/ordered-data.h      | 37 +++++++++++++++++++++++------------=
-
>>>   include/trace/events/btrfs.h |  7 ++++---
>>>   4 files changed, 43 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index ef6cb7b620d0..ea9056cc5559 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -917,7 +917,6 @@ static noinline void submit_compressed_extents(stru=
ct async_chunk *async_chunk)
>>>                                                ins.objectid,
>>>                                                async_extent->ram_size,
>>>                                                ins.offset,
>>> -                                             BTRFS_ORDERED_COMPRESSED,
>>>                                                async_extent->compress_t=
ype);
>>>                if (ret) {
>>>                        btrfs_drop_extent_cache(inode, async_extent->sta=
rt,
>>> @@ -1127,7 +1126,8 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
>>>                free_extent_map(em);
>>>
>>>                ret =3D btrfs_add_ordered_extent(inode, start, ins.objec=
tid,
>>> -                                            ram_size, cur_alloc_size, =
0);
>>> +                                            ram_size, cur_alloc_size,
>>> +                                            BTRFS_ORDERED_REGULAR);
>>>                if (ret)
>>>                        goto out_drop_extent_cache;
>>>
>>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>>> index d5d326c674b1..bd7e187d9b16 100644
>>> --- a/fs/btrfs/ordered-data.c
>>> +++ b/fs/btrfs/ordered-data.c
>>> @@ -199,8 +199,11 @@ static int __btrfs_add_ordered_extent(struct btrfs=
_inode *inode, u64 file_offset
>>>        entry->compress_type =3D compress_type;
>>>        entry->truncated_len =3D (u64)-1;
>>>        entry->qgroup_rsv =3D ret;
>>> -     if (type !=3D BTRFS_ORDERED_IO_DONE && type !=3D BTRFS_ORDERED_CO=
MPLETE)
>>> -             set_bit(type, &entry->flags);
>>> +
>>> +     ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
>>> +            type =3D=3D BTRFS_ORDERED_PREALLOC ||
>>> +            type =3D=3D BTRFS_ORDERED_COMPRESSED);
>>
>> I've reformatted that so that all the checks are on separate lines, it's
>> easier to read though it does not fill the whole line.
>>
>>> +     set_bit(type, &entry->flags);
>>>
>>>        if (dio) {
>>>                percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes,
>>> @@ -256,6 +259,8 @@ int btrfs_add_ordered_extent(struct btrfs_inode *in=
ode, u64 file_offset,
>>>                             u64 disk_bytenr, u64 num_bytes, u64 disk_nu=
m_bytes,
>>>                             int type)
>>>   {
>>> +     ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
>>> +            type =3D=3D BTRFS_ORDERED_PREALLOC);
>>>        return __btrfs_add_ordered_extent(inode, file_offset, disk_byten=
r,
>>>                                          num_bytes, disk_num_bytes, typ=
e, 0,
>>>                                          BTRFS_COMPRESS_NONE);
>>> @@ -265,6 +270,8 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode=
 *inode, u64 file_offset,
>>>                                 u64 disk_bytenr, u64 num_bytes,
>>>                                 u64 disk_num_bytes, int type)
>>>   {
>>> +     ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_ORD=
ERED_NOCOW ||
>>> +            type =3D=3D BTRFS_ORDERED_PREALLOC);
>>>        return __btrfs_add_ordered_extent(inode, file_offset, disk_byten=
r,
>>>                                          num_bytes, disk_num_bytes, typ=
e, 1,
>>>                                          BTRFS_COMPRESS_NONE);
>>> @@ -272,11 +279,12 @@ int btrfs_add_ordered_extent_dio(struct btrfs_ino=
de *inode, u64 file_offset,
>>>
>>>   int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 =
file_offset,
>>>                                      u64 disk_bytenr, u64 num_bytes,
>>> -                                   u64 disk_num_bytes, int type,
>>> -                                   int compress_type)
>>> +                                   u64 disk_num_bytes, int compress_ty=
pe)
>>>   {
>>> +     ASSERT(compress_type !=3D BTRFS_COMPRESS_NONE);
>>>        return __btrfs_add_ordered_extent(inode, file_offset, disk_byten=
r,
>>> -                                       num_bytes, disk_num_bytes, type=
, 0,
>>> +                                       num_bytes, disk_num_bytes,
>>> +                                       BTRFS_ORDERED_COMPRESSED, 0,
>>>                                          compress_type);
>>>   }
>>>
>>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>>> index 46194c2c05d4..151ec6bba405 100644
>>> --- a/fs/btrfs/ordered-data.h
>>> +++ b/fs/btrfs/ordered-data.h
>>> @@ -27,7 +27,7 @@ struct btrfs_ordered_sum {
>>>   };
>>>
>>>   /*
>>> - * bits for the flags field:
>>> + * Bits for btrfs_ordered_extent::flags.
>>>    *
>>>    * BTRFS_ORDERED_IO_DONE is set when all of the blocks are written.
>>>    * It is used to make sure metadata is inserted into the tree only on=
ce
>>> @@ -38,24 +38,36 @@ struct btrfs_ordered_sum {
>>>    * IO is done and any metadata is inserted into the tree.
>>>    */
>>>   enum {
>>> +     /*
>>> +      * Different types for direct io, one and only one of the 4 type =
can
>>
>> direct io
>>
>>> +      * be set when creating ordered extent.
>>> +      *
>>> +      * REGULAR:     For regular non-compressed COW write
>>> +      * NOCOW:       For NOCOW write into existing non-hole extent
>>> +      * PREALLOC:    For NOCOW write into preallocated extent
>>> +      * COMPRESSED:  For compressed COW write
>>> +      */
>>> +     BTRFS_ORDERED_REGULAR,
>>> +     BTRFS_ORDERED_NOCOW,
>>> +     BTRFS_ORDERED_PREALLOC,
>>> +     BTRFS_ORDERED_COMPRESSED,
>>> +
>>> +     /*
>>> +      * Extra bit for DirectIO, can only be set for
>>
>> DirectIO
>>
>>> +      * REGULAR/NOCOW/PREALLOC. No DIO for compressed extent.
>>
>> DIO
>>
>> Three different ways to spell that but one is enough. Fixed.
>=20
>=20
>=20

