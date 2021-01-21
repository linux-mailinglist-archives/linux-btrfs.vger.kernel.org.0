Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A72FE894
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 12:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbhAULT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 06:19:57 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:39859 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730227AbhAULIZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 06:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611227236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CxcfEEcEDG5eMbT14O0rD/djX9jsaDvws4J6RDv1Sg=;
        b=DU1gG1nSNqX15X6QQA+IrJctywj6DCC9/gQB6zTsPLeeVmUPA40hk+f0LghHSYpEEgjZyt
        QoIb8QZMH5pdv00ih9YC5wKHoeGMII67EE2Pfw6xBDk4iBp93UPCXu3uYqLIUa2bXgwoUz
        vkZjVM9DVMzpSK4fhngW1nAaILT4Lz8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-9-tJ0hAWDzMb2tJd0vnWUfDA-1; Thu, 21 Jan 2021 12:07:13 +0100
X-MC-Unique: tJ0hAWDzMb2tJd0vnWUfDA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo47V/SaGTNQTbRkfDEkgk6NuKYIwV5kdGnkUn4ecVaDMRRe73Wk/xYsfqZl3TfAR4F5L1Y1tn1CzmXMcfHKZbwopcD3o13NEJSvlgpvy2HQPnwa7LmOu13GO+hMjuP9Z4HPBxGx2D5BlZvRvTvunZrYslvJJoIzmMk4HkVsuGb1/sBSB4n+HVSS0swAbA7UyV3bJ+9i1g5lYNRbLaak/iUteueKzep/3OOcdt7WBn4t9JBsQ+AFqhPQl2yV8ea95lDMWF9LWBdXls23jRFGLNRpnVdBuCtTeIouCyr05y45gqYruJ1u6421rx69LufHYWXakkCLUFyUNSAf40XrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCgrcIG9ysfywFJO6Y5YsFRJYi/+mS92dzMWO4uqZPY=;
 b=krtiKwdEPdvB8yICjxpfvtM1jQgYDvzg+uvMP3zTPOON0YPOUR5ArY/83ZQTrMfpYHQhZeai2VXnBV/KuCqRjGq0FNIjF6FUDZ603Z16daKNqq61OJjJOS8ZoDPhGIZXkmPZxvLfCSv3Ahw/JGGuEv0Yn7j1FP2isMD1NP6PPtKYC//mYEnP73j1iqKCN2GwSplzMu3PGWKcghFhy4jEsHNmJHMnfxVGEdXZmieXGdBu3JnqyUcdomCWxXr191UMJaIDdPeks20/dY+PF2rYFPA6T2w/1/IyVpCKF5ja6U6ilGEf6tWw8f5d7a2NboJe4keHYiUyItEpdrCQRH+srQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VI1PR0402MB3518.eurprd04.prod.outlook.com
 (2603:10a6:803:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 21 Jan
 2021 11:07:12 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 11:07:12 +0000
Subject: Re: [PATCH] btrfs: rework the order of btrfs_ordered_extent::flags
To:     fdmanana@gmail.com
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210121061354.61271-1-wqu@suse.com>
 <CAL3q7H4Pa1P71EVGQBV+sXiXN62obRbA8b-8WMhgarjLaYk7zA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <8be0ecaa-cab2-5e4b-1163-9f2743a50546@suse.com>
Date:   Thu, 21 Jan 2021 19:07:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CAL3q7H4Pa1P71EVGQBV+sXiXN62obRbA8b-8WMhgarjLaYk7zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::33) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0020.namprd06.prod.outlook.com (2603:10b6:a03:d4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 11:07:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f52e1a-a4b8-4544-f233-08d8bdfcb3d7
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3518:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3518F44DB98AE664519AEAC6D6A10@VI1PR0402MB3518.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ciDyLHeagKWaSW8DvZ/ydnIS3Pyjib4OINkb/7GbaQtwnFcntNHIaePD5mr5UWWTAiWrzEECRJSm56pElPg09xlPBlxLMbeemwMa3NyhWIOhg5sfqEJJYzFvM03kPokpmzAbdO4Is24gSba7SyTf1O5+5QYFZAKL2+t1j6/GswJmlXjInyPe7mEd8sak9TTnqp8dAEO8mJkPaYC9wCwe9bGuV8OZm4rgv72n+r5YjrxERTNq48MQ4HqLCFIfV5+NKowuVlSybPjgtMz3zJTQUw+YjPFYqaS/q2sK3Gxd4QFu8XSD50VFdNxM1gODjP7zx6fbRW6kLg8ZZCmFORC/EOq7XTAxE/a9NCpNL1gZvwI1Z755gDGv9LBXBK34HlyHMtSqTZLKfcfjsIXTjLMaticc5gBK1aRQvUzgTPkfbfbE7i6gZU041FCMreOr5pbXm0cmEEc3omf6jOsFD71+mehMaNk/jB6UkNXUBa2LX8B0ymFRq8QZMpDamKc3DIRm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(52116002)(66476007)(66556008)(66946007)(478600001)(36756003)(4326008)(6486002)(6666004)(31696002)(31686004)(86362001)(8936002)(2616005)(16526019)(16576012)(6706004)(5660300002)(53546011)(316002)(26005)(186003)(2906002)(8676002)(956004)(83380400001)(6916009)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O/LHi2/j6Ylbu395fSTHPasTosiNdxdfL9BSMj+G7E1o+MGEncRmTorBZ/zc?=
 =?us-ascii?Q?UAFb3a7qW+CxOLSajFyhZTwzHXvKyw0GhV79cp7UgiC23sNMDOL4kt6t+gY6?=
 =?us-ascii?Q?0gi+bg2YXl90DFMsSlOlsrZ9JdsBHOV2KSSzZbxHEJO9JXAL3zp88hK1bqaW?=
 =?us-ascii?Q?C466hPhwHMCjqJGhyTcPqW+wKggf/YktbnzmcMj4kBfpHigypTfrMybV0e0p?=
 =?us-ascii?Q?WY7h6EBX7CTXiGCxMSDFN6Ux/nNQ0BIxf4BUFw+i6lZN8RLSai/dHHTdd+f7?=
 =?us-ascii?Q?a8XGPDtsQGKYjkbo/PjfpDpMJVW62NvtZlMzNom9yyhoSskKMsOtbM0Q5dj5?=
 =?us-ascii?Q?Rwz+uJ/U5xFem7hdGn6eyi8qHeR99k9rKSzwxWFMSYdN7QZ8lhcqzrRb+mGH?=
 =?us-ascii?Q?med3Fq9ZH24U2XboqU11aD44+6bvDneywJoAizSMmrX2PI5F/NjbwcEy1Qvp?=
 =?us-ascii?Q?/4VIecC7jFnq5nfUd3gsKAFhE6s2MUEgkPIDp2QHNNNalmxT4PmATFS1l3NL?=
 =?us-ascii?Q?SPupJvrmxN3rACTAn0e7+GmxqPJ7xdpiOE/z/iURTMDJJPjfYdabk7IOr/Qj?=
 =?us-ascii?Q?/VkuEtUd/9PeSQsP+dURPfBiVKlIaV/VoktvEeKUKKm3YSSRgF+7IRFyn5pM?=
 =?us-ascii?Q?OqdxVxPcaSaTBRigZo8IsfRQfPeC5M6WokuME3MXKAueAmF7JeP0JcrT2NFl?=
 =?us-ascii?Q?gPMPT0gG12Y4BmTnvEVRbU+jvdV8OKE3GTcEyxey4euERFpQdKHjd8HreJN1?=
 =?us-ascii?Q?loLvqPXim32cmcIl3sQz4HwjKm/fYSsy6zLpzrlwVPfJT4fmllliQDUqSeHf?=
 =?us-ascii?Q?Gk0UvaJOy+2wLBGjYr4iVOw/VOiIH4sUMarWAgPYJMzo66Z8Ed6a2o3yL5pa?=
 =?us-ascii?Q?BfNFj3f9bIjGRL6NfsWPzmm0P8RRMotyjtC1hjOiUuKcPvOx1bb5WIjPGKkO?=
 =?us-ascii?Q?25Iyh2kBh/Q74SJkPai5GRK+oMJgMiJyr++UHIXW329/pjeu0oT7DRFgxrGN?=
 =?us-ascii?Q?yMw2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f52e1a-a4b8-4544-f233-08d8bdfcb3d7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 11:07:12.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXO6GTKQsz4+sHPRqQ2MhawmuEEvEfkMY0l/+lLdcXvi1kp9FepEd2gofuARqD/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3518
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/21 =E4=B8=8B=E5=8D=886:32, Filipe Manana wrote:
> On Thu, Jan 21, 2021 at 6:27 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> There is a long existing bug in the last parameter of
>> btrfs_add_ordered_extent(), in commit 771ed689d2cd ("Btrfs: Optimize
>> compressed writeback and reads") back to 2008.
>>
>> In that ancient commit btrfs_add_ordered_extent() expects the @type
>> parameter to be one of the following:
>> - BTRFS_ORDERED_REGULAR
>> - BTRFS_ORDERED_NOCOW
>> - BTRFS_ORDERED_PREALLOC
>> - BTRFS_ORDERED_COMPRESSED
>>
>> But we pass 0 in cow_file_range(), which means BTRFS_ORDERED_IO_DONE.
>>
>> Ironically extra check in __btrfs_add_ordered_extent() won't set the bit
>> if we're seeing (type =3D=3D IO_DONE || type =3D=3D IO_COMPLETE), and av=
oid any
>> obvious bug.
>>
>> But this still leads to regular COW ordered extent having no bit to
>> indicate its type in various trace events, rendering REGULAR bit
>> useless.
>>
>> [FIX]
>> This patch will change the following aspects to avoid such problem:
>> - Reorder btrfs_ordered_extent::flags
>>    Now the type bits go first (REGULAR/NOCOW/PREALLCO/COMPRESSED), then
>>    DIRECT bit, finally extra status bits like IO_DONE/COMPLETE/IOERR.
>>
>> - Add extra ASSERT() for btrfs_add_ordered_extent_*()
>>
>> - Remove @type parameter for btrfs_add_ordered_extent_compress()
>>    As the only valid @type here is BTRFS_ORDERED_COMPRESSED.
>>
>> - Remove the unnecessary special check for IO_DONE/COMPLETE in
>>    __btrfs_add_ordered_extent()
>>    This is just to make the code work, with extra ASSERT(), there are
>>    limited values can be passed in.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c             |  4 ++--
>>   fs/btrfs/ordered-data.c      | 18 +++++++++++++-----
>>   fs/btrfs/ordered-data.h      | 37 +++++++++++++++++++++++-------------
>>   include/trace/events/btrfs.h |  7 ++++---
>>   4 files changed, 43 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index ef6cb7b620d0..ea9056cc5559 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -917,7 +917,6 @@ static noinline void submit_compressed_extents(struc=
t async_chunk *async_chunk)
>>                                                  ins.objectid,
>>                                                  async_extent->ram_size,
>>                                                  ins.offset,
>> -                                               BTRFS_ORDERED_COMPRESSED=
,
>>                                                  async_extent->compress_=
type);
>>                  if (ret) {
>>                          btrfs_drop_extent_cache(inode, async_extent->st=
art,
>> @@ -1127,7 +1126,8 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>>                  free_extent_map(em);
>>
>>                  ret =3D btrfs_add_ordered_extent(inode, start, ins.obje=
ctid,
>> -                                              ram_size, cur_alloc_size,=
 0);
>> +                                              ram_size, cur_alloc_size,
>> +                                              BTRFS_ORDERED_REGULAR);
>>                  if (ret)
>>                          goto out_drop_extent_cache;
>>
>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>> index d5d326c674b1..bd7e187d9b16 100644
>> --- a/fs/btrfs/ordered-data.c
>> +++ b/fs/btrfs/ordered-data.c
>> @@ -199,8 +199,11 @@ static int __btrfs_add_ordered_extent(struct btrfs_=
inode *inode, u64 file_offset
>>          entry->compress_type =3D compress_type;
>>          entry->truncated_len =3D (u64)-1;
>>          entry->qgroup_rsv =3D ret;
>> -       if (type !=3D BTRFS_ORDERED_IO_DONE && type !=3D BTRFS_ORDERED_C=
OMPLETE)
>> -               set_bit(type, &entry->flags);
>> +
>> +       ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_OR=
DERED_NOCOW ||
>> +              type =3D=3D BTRFS_ORDERED_PREALLOC ||
>> +              type =3D=3D BTRFS_ORDERED_COMPRESSED);
>> +       set_bit(type, &entry->flags);
>>
>>          if (dio) {
>>                  percpu_counter_add_batch(&fs_info->dio_bytes, num_bytes=
,
>> @@ -256,6 +259,8 @@ int btrfs_add_ordered_extent(struct btrfs_inode *ino=
de, u64 file_offset,
>>                               u64 disk_bytenr, u64 num_bytes, u64 disk_n=
um_bytes,
>>                               int type)
>>   {
>> +       ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_OR=
DERED_NOCOW ||
>> +              type =3D=3D BTRFS_ORDERED_PREALLOC);
>>          return __btrfs_add_ordered_extent(inode, file_offset, disk_byte=
nr,
>>                                            num_bytes, disk_num_bytes, ty=
pe, 0,
>>                                            BTRFS_COMPRESS_NONE);
>> @@ -265,6 +270,8 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode =
*inode, u64 file_offset,
>>                                   u64 disk_bytenr, u64 num_bytes,
>>                                   u64 disk_num_bytes, int type)
>>   {
>> +       ASSERT(type =3D=3D BTRFS_ORDERED_REGULAR || type =3D=3D BTRFS_OR=
DERED_NOCOW ||
>> +              type =3D=3D BTRFS_ORDERED_PREALLOC);
>>          return __btrfs_add_ordered_extent(inode, file_offset, disk_byte=
nr,
>>                                            num_bytes, disk_num_bytes, ty=
pe, 1,
>>                                            BTRFS_COMPRESS_NONE);
>> @@ -272,11 +279,12 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inod=
e *inode, u64 file_offset,
>>
>>   int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 f=
ile_offset,
>>                                        u64 disk_bytenr, u64 num_bytes,
>> -                                     u64 disk_num_bytes, int type,
>> -                                     int compress_type)
>> +                                     u64 disk_num_bytes, int compress_t=
ype)
>>   {
>> +       ASSERT(compress_type !=3D BTRFS_COMPRESS_NONE);
>>          return __btrfs_add_ordered_extent(inode, file_offset, disk_byte=
nr,
>> -                                         num_bytes, disk_num_bytes, typ=
e, 0,
>> +                                         num_bytes, disk_num_bytes,
>> +                                         BTRFS_ORDERED_COMPRESSED, 0,
>>                                            compress_type);
>>   }
>>
>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>> index 46194c2c05d4..151ec6bba405 100644
>> --- a/fs/btrfs/ordered-data.h
>> +++ b/fs/btrfs/ordered-data.h
>> @@ -27,7 +27,7 @@ struct btrfs_ordered_sum {
>>   };
>>
>>   /*
>> - * bits for the flags field:
>> + * Bits for btrfs_ordered_extent::flags.
>>    *
>>    * BTRFS_ORDERED_IO_DONE is set when all of the blocks are written.
>>    * It is used to make sure metadata is inserted into the tree only onc=
e
>> @@ -38,24 +38,36 @@ struct btrfs_ordered_sum {
>>    * IO is done and any metadata is inserted into the tree.
>>    */
>>   enum {
>> +       /*
>> +        * Different types for direct io, one and only one of the 4 type=
 can
>=20
> Different types for both buffered and direct IO (except the compressed ty=
pe).

My bad, no direct io should be mentioned here, just 4 types of IO.

The direct IO has good enough explanation already for its bit.

Thanks for the review,
Qu
>=20
> Also "4 type" -> "4 types".
>=20
> Other than that, it looks good, thanks.
>=20
>> +        * be set when creating ordered extent.
>> +        *
>> +        * REGULAR:     For regular non-compressed COW write
>> +        * NOCOW:       For NOCOW write into existing non-hole extent
>> +        * PREALLOC:    For NOCOW write into preallocated extent
>> +        * COMPRESSED:  For compressed COW write
>> +        */
>> +       BTRFS_ORDERED_REGULAR,
>> +       BTRFS_ORDERED_NOCOW,
>> +       BTRFS_ORDERED_PREALLOC,
>> +       BTRFS_ORDERED_COMPRESSED,
>> +
>> +       /*
>> +        * Extra bit for DirectIO, can only be set for
>> +        * REGULAR/NOCOW/PREALLOC. No DIO for compressed extent.
>> +        */
>> +       BTRFS_ORDERED_DIRECT,
>> +
>> +       /* Extra status bits for ordered extents */
>> +
>>          /* set when all the pages are written */
>>          BTRFS_ORDERED_IO_DONE,
>>          /* set when removed from the tree */
>>          BTRFS_ORDERED_COMPLETE,
>> -       /* set when we want to write in place */
>> -       BTRFS_ORDERED_NOCOW,
>> -       /* writing a zlib compressed extent */
>> -       BTRFS_ORDERED_COMPRESSED,
>> -       /* set when writing to preallocated extent */
>> -       BTRFS_ORDERED_PREALLOC,
>> -       /* set when we're doing DIO with this extent */
>> -       BTRFS_ORDERED_DIRECT,
>>          /* We had an io error when writing this out */
>>          BTRFS_ORDERED_IOERR,
>>          /* Set when we have to truncate an extent */
>>          BTRFS_ORDERED_TRUNCATED,
>> -       /* Regular IO for COW */
>> -       BTRFS_ORDERED_REGULAR,
>>          /* Used during fsync to track already logged extents */
>>          BTRFS_ORDERED_LOGGED,
>>          /* We have already logged all the csums of the ordered extent *=
/
>> @@ -167,8 +179,7 @@ int btrfs_add_ordered_extent_dio(struct btrfs_inode =
*inode, u64 file_offset,
>>                                   u64 disk_num_bytes, int type);
>>   int btrfs_add_ordered_extent_compress(struct btrfs_inode *inode, u64 f=
ile_offset,
>>                                        u64 disk_bytenr, u64 num_bytes,
>> -                                     u64 disk_num_bytes, int type,
>> -                                     int compress_type);
>> +                                     u64 disk_num_bytes, int compress_t=
ype);
>>   void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>>                             struct btrfs_ordered_sum *sum);
>>   struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_=
inode *inode,
>> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
>> index ecd24c719de4..b9896fc06160 100644
>> --- a/include/trace/events/btrfs.h
>> +++ b/include/trace/events/btrfs.h
>> @@ -499,12 +499,13 @@ DEFINE_EVENT(
>>
>>   #define show_ordered_flags(flags)                                     =
    \
>>          __print_flags(flags, "|",                                      =
    \
>> -               { (1 << BTRFS_ORDERED_IO_DONE),         "IO_DONE"       =
}, \
>> -               { (1 << BTRFS_ORDERED_COMPLETE),        "COMPLETE"      =
}, \
>> +               { (1 << BTRFS_ORDERED_REGULAR),         "REGULAR"       =
}, \
>>                  { (1 << BTRFS_ORDERED_NOCOW),           "NOCOW"        =
 }, \
>> -               { (1 << BTRFS_ORDERED_COMPRESSED),      "COMPRESSED"    =
}, \
>>                  { (1 << BTRFS_ORDERED_PREALLOC),        "PREALLOC"     =
 }, \
>> +               { (1 << BTRFS_ORDERED_COMPRESSED),      "COMPRESSED"    =
}, \
>>                  { (1 << BTRFS_ORDERED_DIRECT),          "DIRECT"       =
 }, \
>> +               { (1 << BTRFS_ORDERED_IO_DONE),         "IO_DONE"       =
}, \
>> +               { (1 << BTRFS_ORDERED_COMPLETE),        "COMPLETE"      =
}, \
>>                  { (1 << BTRFS_ORDERED_IOERR),           "IOERR"        =
 }, \
>>                  { (1 << BTRFS_ORDERED_TRUNCATED),       "TRUNCATED"    =
 })
>>
>> --
>> 2.30.0
>>
>=20
>=20

