Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA553752AC
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhEFK4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 06:56:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:48640 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234566AbhEFK4E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 May 2021 06:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620298506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlqSbgr/3HRHutLF+xH0bsOgniZzVxnwuvUig0RXRuc=;
        b=a6wjLtXJ+x369Ad1hRcKvkQwbukqu8MKXP0lYUH5RiDwwjtRPN2EZE13/vxuZYAgLRm4fU
        2Rv+ic2vw0etQtyBm4/g+b3POfCVgNcRmB2HBcliGuOVMDTySDeIemWP8DGLTsEgbk2+fI
        wY0r0TKLMWYjIHuH60Eq5p1Yd8cwnHU=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2052.outbound.protection.outlook.com [104.47.0.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-NyIE_gMiO4mkDAPlwwLJzA-1; Thu, 06 May 2021 12:55:05 +0200
X-MC-Unique: NyIE_gMiO4mkDAPlwwLJzA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8/fghCkeA4EK+hGLqUc/TyjP1+PxdJilD0DDzTHX4M0SDqwjOLqnG6YjHrFDDiKaev5T/rG+TUmvTvsx5LJPJcjIrSYvHobpYZhFnhTUT6X2oauZqkjuFN0CY5i+3o6A3UZz6I6gFjJR38VKP58Fn754152fipZC86WNguysi38Ut7AxPLtndWdo5LsdKZMXjCtytdNEr1meX9h/uoYE4Sd+n21sFdquQm7++IdvbtVINF78Uq2SlfMw5lkVJYoWBOnOjXTlzygVn37AezjBW6VccnupHiM4wqNS9kiGhFiMqI6uaQCdJIVWrVLNoSll2W2GozlQy1ZOLy1FndLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVrlpXj/syfoNDHzCSjzLuMtmU3WxB7zwQjPr5uLWSo=;
 b=NZSqGcvRnPOplu/IHJXKd8WBfd48Q7djwJ8Gam/2lX5tTo26+Gl7gxdNBkoj1B7udg5wer4zOyrhAvSVqQd38/KteinGDNHXKFsq9H7fj+oYdOMKAcvGr1mvmQ1lVJMAUhLRogGApIQFG7UHxyJFjF5YcYSZFtoI3ZO3Lq+N4MeE+6tGjyvAZgeZm75nmV+ZW+cFKrGkT954QiySbwObYV5JoTnuv6EJkc8Ytz8RUmlxgYO1JSrddWbgeKy1SHpQUjXVxHVhVA5P5vtmdvBVQTFGruggEhZnMKCritb3/WMYGwCeNlyCcBB/qbf84S7vJXiVU8HdbjUakNE7xefs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB3973.eurprd04.prod.outlook.com (2603:10a6:209:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 10:55:03 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%7]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 10:55:03 +0000
To:     fdmanana@gmail.com
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210506070458.168945-1-wqu@suse.com>
 <CAL3q7H7TY9c=dzcJw62-nZh-fSieb3gQyqjdXLv+-rMVmQ+ZJg@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH RFC] btrfs: temporary disable inline extent creation for
 fallocate and reflink
Message-ID: <1b3c38fa-122e-47ad-5d83-f45064de714b@suse.com>
Date:   Thu, 6 May 2021 18:54:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAL3q7H7TY9c=dzcJw62-nZh-fSieb3gQyqjdXLv+-rMVmQ+ZJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [45.77.180.217]
X-ClientProxiedBy: TY2PR0101CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::17) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TY2PR0101CA0005.apcprd01.prod.exchangelabs.com (2603:1096:404:92::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 10:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f34da34-9b93-4fcf-9812-08d9107d66b8
X-MS-TrafficTypeDiagnostic: AM6PR04MB3973:
X-Microsoft-Antispam-PRVS: <AM6PR04MB3973376E03FCABF51BE9C65FD6589@AM6PR04MB3973.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/4EqCI9CrhLPEhtcB3N22d+PkFp9E2p2+bUg/MB/2ms0dy7dngzqUe+LBFAqIj+UPkce86DyXh9L9l3quZxZ8BdlV2hb1BoJ5OdE8Tknj9qGpIA8dB5vxJ/Sh4tQrx5qZpk/yLcZMA+cAN6JwOjouibB34G+tMQxAkLjlBr93fzg6aONciwpx6Ks5jzmzU2X8yBlybYc83D1Jqd/njbz7kgdpVUWzkdGX9u9jnUt5FiNiYr+MBs6KTTsbPypkorPrEcEjOmpnv/nFshB1AwxsRNS8Vp2FrxOvJXKfKA1qj7q81bCd6XckkLD0y+M/wlJHix/MS+7Lt+gfLaadLsVeSE9uA4SOOBEfRo4724AbfQLsVBr3NPOp7H4vRnywqIaO9wwQQugZSRnt5nMrIcDGSObvcnd0i2REaitzyZ3sOmU7U0SQ1tHotCcX0snk51/WeKOwKQzuDq9y3248sNftqhq4JtdsDHYith5XwXFXxPzKU8E78RiIt6BXe3N2v2/uwrAjTQgTTs7QXzM6mJ9Gp88NhJ2eMiyicoFtp0Vz0GNpKQlu3r6nhZ84FMJ6Qbaq9WwTOG2zgSOl6hsSSKWxmFPaEddDMOC6rGXV4QnDojytOQ4pVjTfkuaV9/xBRatBwf5MMVVHCdqMtAQLeYL3FS4y+xnFIjDIYh1PNZggVsMxa9AC9jYgC0dj+/0EHPSGMwaB0JUh3kd+1iJCA3Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(376002)(366004)(136003)(186003)(16526019)(53546011)(6666004)(16576012)(8936002)(55236004)(26005)(2906002)(6706004)(31696002)(6916009)(86362001)(8676002)(83380400001)(36756003)(5660300002)(316002)(66476007)(956004)(66556008)(2616005)(31686004)(66946007)(6486002)(30864003)(478600001)(52116002)(38100700002)(4326008)(38350700002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vqQvbA/g3zf2aJ8Kzyq7Nz6LyVAhTKtpLXUBPI8BvFkQBIQqLb3HygVLsvca?=
 =?us-ascii?Q?2LYvlKSOyB31+4RAYyEOcbg7yHRnua8rsK6Zk4WOsEtb+71shBKaGRcwDGiO?=
 =?us-ascii?Q?nfK0jgGtSQ2/dpBeU9n6FOxj/GjNgnDkYPP9lPSqvvxbMyt/wYX9D+0MXkAx?=
 =?us-ascii?Q?FRJUDzHJYtws+UagmCkZ2OLC31DI3r7RVFKmhKZW8ipQLEUzYrcqD3LckQvp?=
 =?us-ascii?Q?iIa0leZJ7DvNYpa1cVmGPF0Rn5LD9klyTGqFdiyf1ReZKo/YaloZa/O5EX8q?=
 =?us-ascii?Q?BUhLudT5S56vIHuzOVTQKWJHjshh+HFq3YTO/LlBPhEqssMSSGk9YH+9vL+O?=
 =?us-ascii?Q?r/7TydMvYgQfeaIkz3e5CwS+WLeWKWBBsZjgqel3yImp1Hjzdd/FOZtBfNbi?=
 =?us-ascii?Q?Z9yGXs93unXNEMDfLyYy0hiZbfhez1zsHM5P0bnD7YpFJupMK8QEb/sllIwD?=
 =?us-ascii?Q?HUgiX/EiWi615Rd1eVwAOAQ9haKGyas4MH+kQpQjNeBydxXejMcll2/nWpIS?=
 =?us-ascii?Q?9JcpiDpYcOIia5tAtpC7ikB9lRTHnzfUGN354j/p4C2r/7FIxVYZnEgSo8zC?=
 =?us-ascii?Q?FthAQHSKuLZGtRJ09J7nGn3DSjMtN2xEGjnrFsJ7tIeOkKeZN4FZ3/iW4qEw?=
 =?us-ascii?Q?cHAlPpWIZg0SKveRS8kiI+gal0MsIPydh6ICNGtx3lRwhITes5lD+QYOpMzy?=
 =?us-ascii?Q?lFOJwBALHLQDUgT60mtLIngkjsykSEk+NhagaekwP3Y2Xn7maM1nrghbEzyd?=
 =?us-ascii?Q?LaVYGgMh0Kr1tGRbd3Wb1DX3KHFV7T9AU8SqECyyzL6YRDs+xkEyM5pzYeuc?=
 =?us-ascii?Q?Kv66AFMeWBrCFtafmTUQlnStQFjH4PR166H/nT7ba64Tvj5hMUrnyFMJDtAF?=
 =?us-ascii?Q?xYt4Aah7Cf7ufl38sjyRvt05R65iHOQBd4jwCsFyOU2kcrkTbe2XlYp/zO1m?=
 =?us-ascii?Q?2kOkFHS1lcqV5DHHv8/uxiERaZY/LFm017M8LYEjxxxBm4F4QWipYnKIOFmN?=
 =?us-ascii?Q?OWyHYGBMQvVyrYIeEcqGgDZMxW7CDjZygF7BNIYDvCMtZszOgqK330udadRz?=
 =?us-ascii?Q?J2OyJAkbbjaY2twIlUwWDCht7ZijRYCVU0sJYNn5UDQYdvsZP/rQdJcLUHpr?=
 =?us-ascii?Q?v7V1UK7F0GW9NLPZ74AWdVRB4HFDK1Jg2OrOmlOoK4rJHV6NFrBeLgE1Izr/?=
 =?us-ascii?Q?KK7ewZaBtSmasD+Q/wcD29ukH0UR6fWhPD9mjqH11zYAHj5IbPtDs39Mu5jG?=
 =?us-ascii?Q?nragnuZzZzn+2n3fYc+Xu3jI0HLIvjuemQJDb1gLHovAh2d3cffmadsS5OgF?=
 =?us-ascii?Q?oJ7T4lkVGV/U4yUYQYlTVkjj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f34da34-9b93-4fcf-9812-08d9107d66b8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 10:55:03.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7zA2a1+rmAfJ+YUp7qD26woVnnsiYU2My+MZfFauii5rDAvovND4qDCds1dGD9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3973
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/6 =E4=B8=8B=E5=8D=886:07, Filipe Manana wrote:
> On Thu, May 6, 2021 at 8:07 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Previously we disable inline extent creation completely for subpage
>> case, due to the fact that writeback for subpage still happens for full
>> page.
>>
>> This makes btrfs_wait_ordered_range() trigger writeback for larger
>> range, thus can writeback the first sector even we don't want.
>>
>> But the truth is, even for regular sectorsize, we still have a race
>> window there operations where fallocate and reflink can cause inline
>> extent being created.
>=20
> Yes, but why is it a problem for when sectorsize =3D=3D page size?

Well, it doesn't affect the on-disk data, but purely break the on-disk=20
data schema.

We don't really expect inline extent with regular extent, right?

> There were problems in the past with send, clone, and fsync due their
> expectations of never having a regular extent following an inline
> extent, but all the ones I'm aware of were fixed long ago.
>=20
>>
>> For example, for the following operations:
>>
>>   # xfs_io -f -c "pwrite 0 2k" -c "falloc 4k 4k" $file
>>
>> The first "pwrite 0 2k" dirtied the first sector, while inode size is
>> updated to 2k.
>> At this point, if the first sector is written back, it will be inlined.
>>
>> Then we enter "falloc 4k 4k" which will:
>> a) call btrfs_cont_expand() to insert holes
>> b) do the mainline to insert preallocated extents
>> c) call btrfs_fallocate_update_isize() to enlarge the isize
>>
>> Until c), the isize is still 2K, and during that window, if the first
>> sector is written back due to whatever reasons (from memory pressure to
>> fadvice to writeback the pages), since the isize is still 2K, we will
>=20
> fadvice -> fadvise
>=20
>> write the first sector as inlined.
>>
>> Then we have a case where we get mixed inline and regular extents.
>=20
> Again, the change log should mention why it is a problem, how it affects =
users?

It doesn't affect the end user, just like the a log bugs exposed by=20
tree-checker, like the inode transid/generation problems.

But shouldn't we still follow the on-disk data schema that, if we have=20
regular extents, then there shouldn't be an inline extent.

> Some data corruption, reads returning wrong data, some crash, something e=
lse?

Just a scheme breakage, kernel can handle mixed types without problem.

> Is it only a problem for pagesize > sectorsize, or for pagesize =3D=3D
> sectorsize too?

Both.
But for pagesize =3D=3D sectorsize it's much harder.

In fact, with the btrfs-progs patches to report such mixed extent type,=20
on x86 I just hit a such problem on generic/476.

>=20
>>
>> Fix the problem by introducing a new runtime inode flag,
>> BTRFS_INODE_NOINLINE, to temporarily disable inline extent creation
>> until the isize get enlarged.
>>
>> So that we don't need to disable inline extent creation completely for
>> subpage.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> I'm not sure if this is the best solution, as the original race window
>> for regular sector has existed for a long long time.
>=20
> Yes, but as mentioned before, it does not cause bug, does it?

Depends on whether schema breakage is a big thing or not.

Personally I prefer to consider as schema breakage as a bug, even it=20
doesn't cause any problem to end user.

That's why I'm enhancing tree-checker to detect things that are invalid=20
even it doesn't break anything.

But I kinda get your point, it's definitely not a high priority thing,=20
unlike real data corruption.

>=20
>>
>> I have also tried other solutions like switching the timing of
>> btrfs_cont_expand() and btrfs_wait_ordered_range(), to make
>> btrfs_wait_ordered_range() happens before btrfs_cont_expand().
>>
>> So that we will writeback the first sector for subpage as inline, then
>> btrfs_cont_expand() will re-dirty the first sector.
>>
>> This would solve the problem for subpage, but not the race window.
>>
>> Another idea is to enlarge inode size first, but that would greatly
>> change the error path, may cause new regressions.
>=20
> I think I would prefer it that way. I don't see why it would change
> the error paths so much.
> Instead of clearing the bit, it would be just assigning the old i_isize v=
alue.

What would happen if one is calling btrfs_setsize() to resize the inode=20
during fallocate call?
Wouldn't we restore some out-of-data isize then?
btrfs_setsize() doesn't hold inode lock, thus it can sneak in.

If there is something else ensuring we're the only one modifying isize,=20
I'm more happy to go this direction.

Thanks,
Qu

>=20
> But I don't have a strong preference.
>=20
>>
>> I'm all ears for advice on this problem.
>> ---
>>   fs/btrfs/ctree.h         | 10 ++++++++++
>>   fs/btrfs/delayed-inode.c |  3 ++-
>>   fs/btrfs/file.c          | 19 +++++++++++++++++++
>>   fs/btrfs/inode.c         | 21 ++++-----------------
>>   fs/btrfs/reflink.c       | 14 ++++++++++++--
>>   fs/btrfs/root-tree.c     |  3 ++-
>>   fs/btrfs/tree-log.c      |  3 ++-
>>   7 files changed, 51 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 7bb4212b90d3..7c74d57ad8fc 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -1488,6 +1488,16 @@ do {                                             =
                      \
>>   #define BTRFS_INODE_DIRSYNC            (1 << 10)
>>   #define BTRFS_INODE_COMPRESS           (1 << 11)
>>
>> +/*
>> + * Runtime bit to temporary disable inline extent creation.
>> + * To prevent the first sector get written back as inline before the is=
ize
>> + * get enlarged.
>> + *
>> + * This flag is for runtime only, won't reach disk, thus is not include=
d
>> + * in BTRFS_INODE_FLAG_MASK.
>> + */
>> +#define BTRFS_INODE_NOINLINE           (1 << 30)
>> +
>>   #define BTRFS_INODE_ROOT_ITEM_INIT     (1 << 31)
>>
>>   #define BTRFS_INODE_FLAG_MASK                                         =
 \
>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>> index 1a88f6214ebc..64d931da083d 100644
>> --- a/fs/btrfs/delayed-inode.c
>> +++ b/fs/btrfs/delayed-inode.c
>> @@ -1717,7 +1717,8 @@ static void fill_stack_inode_item(struct btrfs_tra=
ns_handle *trans,
>>                                         inode_peek_iversion(inode));
>>          btrfs_set_stack_inode_transid(inode_item, trans->transid);
>>          btrfs_set_stack_inode_rdev(inode_item, inode->i_rdev);
>> -       btrfs_set_stack_inode_flags(inode_item, BTRFS_I(inode)->flags);
>> +       btrfs_set_stack_inode_flags(inode_item,
>> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
>=20
> If it's a runtime flag, not meant to be persisted, then it should be
> set in btrfs_inode->runtime flags and not on btrfs_inode->flags,
> which not only makes it more clear, but avoids doing this sort of bit
> manipulation.
>=20
>>          btrfs_set_stack_inode_block_group(inode_item, 0);
>>
>>          btrfs_set_stack_timespec_sec(&inode_item->atime,
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 70a36852b680..a3559ce93780 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -3357,6 +3357,24 @@ static long btrfs_fallocate(struct file *file, in=
t mode,
>>                          goto out;
>>          }
>>
>> +       /*
>> +        * Disable inline extent creation until we enlarged the inode si=
ze.
>=20
> until we enlarged -> until we increase (or update)
>=20
>> +        *
>> +        * Since the inode size is only increased after we allocated all
>=20
> So this is a bit confusing to read. You'll want to mention that happens o=
nly
> for fallocate and cloning.
>=20
> As I read it, if I had little or no knowledge of the code, I would
> interpret that that happens for all cases.
> But those two cases, fallocate and cloning, are the exceptions to the
> rule, which is we update the i_size and then fill in the file extent
> items (like in the write path).
>=20
>> +        * extents, there are several cases to writeback the first secto=
r,
>> +        * which can be inlined, leaving inline extent mixed with regula=
r
>> +        * extents:
>> +        *
>> +        * - btrfs_wait_ordered_range() call for subpage case
>> +        *   The writeback happens for the full page, thus can writeback
>> +        *   the first sector of an inode.
>> +        *
>> +        * - Memory pressure
>> +        *
>> +        * So here we temporarily disable inline extent creation for the=
 inode.
>=20
> Same as commented before, I would like to know why is it a problem,
> how does it affect correctness, if there's some corruption, crash, or
> something else affecting users.
>=20
>> +        */
>> +       BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
>> +
>>          /*
>>           * TODO: Move these two operations after we have checked
>>           * accurate reserved space, or fallocate can still fail but
>> @@ -3501,6 +3519,7 @@ static long btrfs_fallocate(struct file *file, int=
 mode,
>>          unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, loc=
ked_end,
>>                               &cached_state);
>>   out:
>> +       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>>          btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
>>          /* Let go of our reservation. */
>>          if (ret !=3D 0 && !(mode & FALLOC_FL_ZERO_RANGE))
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 4fc6e6766234..59972cb2efce 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -666,11 +666,7 @@ static noinline int compress_file_range(struct asyn=
c_chunk *async_chunk)
>>                  }
>>          }
>>   cont:
>> -       /*
>> -        * Check cow_file_range() for why we don't even try to create
>> -        * inline extent for subpage case.
>> -        */
>> -       if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
>> +       if (start =3D=3D 0 && !(BTRFS_I(inode)->flags & BTRFS_INODE_NOIN=
LINE)) {
>>                  /* lets try to make an inline extent */
>>                  if (ret || total_in < actual_end) {
>>                          /* we didn't compress the entire range, try
>> @@ -1068,17 +1064,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
>>
>>          inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
>>
>> -       /*
>> -        * Due to the page size limit, for subpage we can only trigger t=
he
>> -        * writeback for the dirty sectors of page, that means data writ=
eback
>> -        * is doing more writeback than what we want.
>> -        *
>> -        * This is especially unexpected for some call sites like falloc=
ate,
>> -        * where we only increase isize after everything is done.
>> -        * This means we can trigger inline extent even we didn't want.
>> -        * So here we skip inline extent creation completely.
>> -        */
>> -       if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
>> +       if (start =3D=3D 0 && !(inode->flags & BTRFS_INODE_NOINLINE)) {
>>                  /* lets try to make an inline extent */
>>                  ret =3D cow_file_range_inline(inode, start, end, 0,
>>                                              BTRFS_COMPRESS_NONE, NULL);
>> @@ -3789,7 +3775,8 @@ static void fill_inode_item(struct btrfs_trans_han=
dle *trans,
>>          btrfs_set_token_inode_sequence(&token, item, inode_peek_iversio=
n(inode));
>>          btrfs_set_token_inode_transid(&token, item, trans->transid);
>>          btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
>> -       btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags)=
;
>> +       btrfs_set_token_inode_flags(&token, item,
>> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
>>          btrfs_set_token_inode_block_group(&token, item, 0);
>>   }
>>
>> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
>> index e5680c03ead4..48f8bdd185de 100644
>> --- a/fs/btrfs/reflink.c
>> +++ b/fs/btrfs/reflink.c
>> @@ -701,12 +701,19 @@ static noinline int btrfs_clone_files(struct file =
*file, struct file *file_src,
>>          if (off + len =3D=3D src->i_size)
>>                  len =3D ALIGN(src->i_size, bs) - off;
>>
>> +       /*
>> +        * Temporarily disable inline extent creation, check btrfs_fallo=
cate()
>> +        * for details
>> +        */
>> +       BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
>>          if (destoff > inode->i_size) {
>>                  const u64 wb_start =3D ALIGN_DOWN(inode->i_size, bs);
>>
>>                  ret =3D btrfs_cont_expand(BTRFS_I(inode), inode->i_size=
, destoff);
>> -               if (ret)
>> +               if (ret) {
>> +                       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE=
;
>>                          return ret;
>> +               }
>>                  /*
>>                   * We may have truncated the last block if the inode's =
size is
>>                   * not sector size aligned, so we need to wait for writ=
eback to
>> @@ -718,8 +725,10 @@ static noinline int btrfs_clone_files(struct file *=
file, struct file *file_src,
>>                   */
>>                  ret =3D btrfs_wait_ordered_range(inode, wb_start,
>>                                                 destoff - wb_start);
>> -               if (ret)
>> +               if (ret) {
>> +                       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE=
;
>>                          return ret;
>> +               }
>>          }
>>
>>          /*
>> @@ -745,6 +754,7 @@ static noinline int btrfs_clone_files(struct file *f=
ile, struct file *file_src,
>>                                  round_down(destoff, PAGE_SIZE),
>>                                  round_up(destoff + len, PAGE_SIZE) - 1)=
;
>>
>> +       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>>          return ret;
>>   }
>>
>> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
>> index 702dc5441f03..5ce3a1dfaf3f 100644
>> --- a/fs/btrfs/root-tree.c
>> +++ b/fs/btrfs/root-tree.c
>> @@ -447,7 +447,8 @@ void btrfs_check_and_init_root_item(struct btrfs_roo=
t_item *root_item)
>>
>>          if (!(inode_flags & BTRFS_INODE_ROOT_ITEM_INIT)) {
>>                  inode_flags |=3D BTRFS_INODE_ROOT_ITEM_INIT;
>> -               btrfs_set_stack_inode_flags(&root_item->inode, inode_fla=
gs);
>> +               btrfs_set_stack_inode_flags(&root_item->inode,
>> +                               inode_flags & BTRFS_INODE_FLAG_MASK);
>=20
> Same as before, using btrfs_inode->runtime_flags would eliminate the
> need for this.
>=20
>>                  btrfs_set_root_flags(root_item, 0);
>>                  btrfs_set_root_limit(root_item, 0);
>>          }
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>> index c1353b84ae54..f7e6abfc89c0 100644
>> --- a/fs/btrfs/tree-log.c
>> +++ b/fs/btrfs/tree-log.c
>> @@ -3943,7 +3943,8 @@ static void fill_inode_item(struct btrfs_trans_han=
dle *trans,
>>          btrfs_set_token_inode_sequence(&token, item, inode_peek_iversio=
n(inode));
>>          btrfs_set_token_inode_transid(&token, item, trans->transid);
>>          btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
>> -       btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags)=
;
>> +       btrfs_set_token_inode_flags(&token, item,
>> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
>=20
> Same as before, using btrfs_inode->runtime_flags would eliminate the
> need for this.
>=20
> Thanks.
>=20
>>          btrfs_set_token_inode_block_group(&token, item, 0);
>>   }
>>
>> --
>> 2.31.1
>>
>=20
>=20

