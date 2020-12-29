Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B722E6DC7
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 05:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgL2EiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 23:38:23 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:56818 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgL2EiX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 23:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1609216636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qArtFylP1iy14MuCtevQFUs/wWcIBw+NGd3ds3os0HU=;
        b=hE6NdnpqKDHztiyTw+6JgwqYK3dQFodi3V4zM82y508MeVjyN8kLtcQ1IsMcPrjaM/UMou
        9G3DYNKizd6giaV19E7ZXOJAiM0Q8rSLGGc36mov6HIdklCJm6ZLP71UcTE2mNVBHNnxQA
        YrVip+wFNVO0K0TY51GZ34KEDABrUYc=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-TzZIOXYROqa7kFc2p8YGUQ-1; Tue, 29 Dec 2020 05:37:14 +0100
X-MC-Unique: TzZIOXYROqa7kFc2p8YGUQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5jryojos3t9GRMSWDWx/H7bKdQsnaky54WwNnwInKos2azl5P/Vg/Pjw7NyLN93Yq1X1DCCK5U7pMVfc4RHn3Sk+A8jLHisaTxIA5pG9JALy5yL7KCJLo9vm+MYSkxtOqLDI/R3HHSq4EuJJMjoWvJ+Wa8SJKqykNvZ4By+Hu0AgXMA6P41L6O+JDC1motxDzxPPvHBUsM2HbWv/jkh6XtPtXsN7yeek/6OdioaIccmjTJ52KGGBYpClalcHFCz8CLvtbB7CJmRWTLeePcXKuFkBIFhxmC87cxc8eXiVVWf3tfm+fyrcCPnyXDjgphylQMpAU7OhDc8WcNKAFz2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvsiKLUeKu+2yXlfDPUomE8KyCG6XNGhncgpTDsnDzw=;
 b=XDiPEdaFI1tfqMtn2vV1cFL0rZ+DqiTIIXtcFziC4iul6K/DStKfLnor2Si7rTJ9jJrteAcB/v4psCzvBJhgwbmeBFRSm5pEAjpnn8sb9mtrlbpIuPLsjQIs53+7yVw3T4pXx6MEk7t9O82I9s1WWQYOGkqLLJQZXxY3XhpNoqBrlRYpR6tl6KtTkdGhX56TLLdo4GZk79NvIjcSbEbHNnv83OePmtUaIXGeRD8sFRhY9s16jUSobAfPrfZjCtWuyaoPQ/v5PLsyfAicuY01jsdnyQ+TgWdCmXg2utB3rPg9rtijrkoDODRE8bbVdjg6+DyMBz5fLnyLtkAuM43sng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 04:37:12 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%6]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 04:37:12 +0000
To:     David Arendt <admin@prnet.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <518c15d55c3d540b26341a773ff7d99f@lesimple.fr>
 <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
 <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
 <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
 <2846fc85-6bd3-ae7e-6770-c75096e5d547@gmx.com>
 <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
 <1904ed2c92224d38747377b43e462353@lesimple.fr>
 <485db52d-cf4d-3a5c-9253-13cdb40ccd5e@gmx.com>
 <5f819b6c-d737-bb73-5382-370875b599c1@gmx.com>
 <6dc40a44-bc3b-ea9b-327b-e2700b2efd62@prnet.org>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: 5.6-5.10 balance regression?
Message-ID: <5939a796-388e-aa49-3518-ef157e9d65c8@suse.com>
Date:   Tue, 29 Dec 2020 12:36:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <6dc40a44-bc3b-ea9b-327b-e2700b2efd62@prnet.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0111.namprd13.prod.outlook.com (2603:10b6:a03:2c5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.14 via Frontend Transport; Tue, 29 Dec 2020 04:37:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a5b154d-ad1c-449e-9aff-08d8abb3695a
X-MS-TrafficTypeDiagnostic: PR3PR04MB7452:
X-Microsoft-Antispam-PRVS: <PR3PR04MB745221FACA319ED8A36F788FD6D80@PR3PR04MB7452.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e66GcDpW0LD5Hpx0o9N4RNY2BwC0D2JGBpeieDuqxxvVtMccQ0mbzLQrMzw6KtgEVlavN7ere7rBy/tqQ9szpcSH2/hQQxGoc256mmn+P3AYpf5XGP/R7n6M2cED2ZVMyLhNN/b/G8CpR/7fxVDx4ZfrkLDWiACZHxemzxaY34XcM6VGmG1MlULUDvKMCzDDMgAaMMrKZIqE+q52AALn2ieFKnDDbLRjDzAlue8wAvvlDB3TBF/K1hncd5Wtr1JUyRM70rLIox8BhofwLrkrkL+NQDQAHf8BkZyAJipGuIl7i77/jc+yETAlPDMGdATqK86OPrwqi9qMq7JhWhWZssj3bZW+mmrg3LuUWphy1qNiSPkJR9RmRXiEeittMMpnFAMr5HZQgCsACI3jISfbHmHXRTt8IL6Bs30jo8CosT8K3dC0q/kM3/9cdO5MHbZYhOCGqoDMOC8ClNjMW7XHmkBbpoXSBM657a8n5PAlEyWQ6YHFAsbTCjZV1/Ctzgu8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(2906002)(2616005)(6666004)(8936002)(52116002)(6706004)(83380400001)(53546011)(5660300002)(6486002)(31696002)(8676002)(956004)(316002)(16576012)(186003)(36756003)(26005)(66574015)(66946007)(66556008)(66476007)(478600001)(31686004)(16526019)(86362001)(110136005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XXH2R6gYtyHypGy+3aYbTxYzfEQBpzOJYe8XMcBMdsYTwkvWD6I/9Akg1fIv?=
 =?us-ascii?Q?mO4U3hLLLAYPxUxncDS6mNG0ylhfaFQTiAP2A6VYV1Qil2ytgIbpztzjQlmh?=
 =?us-ascii?Q?H/xl+2pOZODFZ15AM6u1AdW/lY/MdYqFDmfytXR/YkAEnFU/cSeYlGXmgqcG?=
 =?us-ascii?Q?Hz3QWiiwXQzJxESAsXaY1dhbzxR7HKhY+1ytmsjfBDgFeZeHA8r8HPYiHQor?=
 =?us-ascii?Q?vwgLB6cCoJ3NdnpCVYNjBcL8LfiIr9JmB1JfwXJffAtZR23Cuz0Wm355s/ZZ?=
 =?us-ascii?Q?g8T+WSlCsHIvyveOoGekrMCKYc5aN0hhiYk84haAiGYOXP0ZjVqfXZhij/dd?=
 =?us-ascii?Q?K1IREkGKhT357P9C+3sffv798l/KxAn6m6B6h1zeW540SVp+gxNNXnyn/yt0?=
 =?us-ascii?Q?6Z9Dm3I1LhnKwHBsImgC6USm4PcXwt47Ir3U8TK4laJfUMjxdTIYyQc/TVvw?=
 =?us-ascii?Q?J+z1YM2tMC/mQswwV5jT/epkKrRrfscs6DAQSUMD66OPcRZX6YqgeHteUpu8?=
 =?us-ascii?Q?IyTS0bNVpEU+SdxmHJyP861oSZbvPeepPseKRkqBa8K79Rba5GI7FgxvrTzn?=
 =?us-ascii?Q?V2jKS5Rxr6wphLjdIetfSc6jIyGR7ZTbgapQGauEVHKUbK+1JeN5UGQpxI2v?=
 =?us-ascii?Q?CiP57+or4FMW6evpKGc1xDEHYEQ/aaGnqCHoqzNZ+dTlcb5rwcOjuRbpbmjJ?=
 =?us-ascii?Q?s8+IubkyKBI2qto0PufeFjlnqAD4ufVL3q6ed1PSNgVCK8RDX3t4qKBwtGv6?=
 =?us-ascii?Q?4p6WtMwSg+bNtEMw92Zu0D3Eab9FX35Pcexuq07GPmiOBd6hqWiKD9X1sqK6?=
 =?us-ascii?Q?RTOnltUkbZ4+XCQ6+1HeRAVVK70fLAtZFOz4h4ae9lFGfg1iBMc6zF8O7Cql?=
 =?us-ascii?Q?u1+2cztamIWzduBcFF5HtAl8OmVW7H++8+9Sy8JR5PntQPhzmj5F2SdYuf3+?=
 =?us-ascii?Q?lpWPdvkd0LtbQXVZzjKukfR+QZ46gn6gX25qoJBBQM0Ws+PsHtDJQzkCZNRj?=
 =?us-ascii?Q?vNdM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 04:37:12.6104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5b154d-ad1c-449e-9aff-08d8abb3695a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctHa4zlG1Jpw3yLvYfoIU776JKWdsqqt0UCOeyRGhT7V796QJ1yX+DiyU0T568mn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8A=E5=8D=888:59, David Arendt wrote:
> Hi,
>=20
> Just for information: On my system the error appeared on a filesystem=20
> using space cache v1. I think my problem might then be unrelated to this=
=20
> one.

Then this is more interesting.

There are two locations which can return -ENOENT in delete_v1_space_cache()=
:

- No file extent found
   This means something is wrong in backref walk.
   I don't believe it's even possible, or qgroup and balance will be
   completely broken.

- delete_block_group_cache() failed to grab the free space cache inode
   There is another possibility that, we have free space cache inode in
   commit root (where data relocation reads from), but it's not in our
   current root.
   In that case, -ENOENT is safe to ignore.

I guess you may hit the 2nd case, as your next balance finishes without=20
problem.

> If it will happen again, I will try to collect more information.=20
> Maybe a should try a clear_cache to ensure that the space cache is not=20
> wrong.

Clear_cache itself won't remove all the existing cache, it just remove=20
the caches when the block group gets dirty.

Thus we use btrfs-check to remove free space cache completely.

Thanks,
Qu

>=20
> Bye,
> David Arendt
>=20
> On 12/29/20 1:44 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/12/29 =E4=B8=8A=E5=8D=887:39, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/12/29 =E4=B8=8A=E5=8D=883:58, St=C3=A9phane Lesimple wrote:
>>>>> I know it fails in relocate_block_group(), which returns -2, I'm
>>>>> currently
>>>>> adding a couple printk's here and there to try to pinpoint that=20
>>>>> better.
>>>>
>>>> Okay, so btrfs_relocate_block_group() starts with stage
>>>> MOVE_DATA_EXTENTS, which
>>>> completes successfully, as relocate_block_group() returns 0:
>>>>
>>>> BTRFS info (device <unknown>): relocate_block_group:
>>>> prepare_to_realocate =3D 0
>>>> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D
>>>> 1, btrfs_start_transaction =3D ok
>>>> [...]
>>>> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D
>>>> 168, btrfs_start_transaction =3D ok
>>>> BTRFS info (device <unknown>): relocate_block_group: returning err =3D=
 0
>>>> BTRFS info (device dm-10): stage =3D move data extents,
>>>> relocate_block_group =3D 0
>>>> BTRFS info (device dm-10): found 167 extents, stage: move data extents
>>>>
>>>> Then it proceeds to the UPDATE_DATA_PTRS stage and calls
>>>> relocate_block_group()
>>>> again. This time it'll fail at the 92th iteration of the loop:
>>>>
>>>> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D
>>>> 92, btrfs_start_transaction =3D ok
>>>> BTRFS info (device <unknown>): relocate_block_group loop:
>>>> extents_found =3D 92, item_size(53) >=3D sizeof(*ei)(24), flags =3D 1,=
 ret=20
>>>> =3D 0
>>>> BTRFS info (device <unknown>): add_data_references:
>>>> btrfs_find_all_leafs =3D 0
>>>> BTRFS info (device <unknown>): add_data_references loop:
>>>> read_tree_block ok
>>>> BTRFS info (device <unknown>): add_data_references loop:
>>>> delete_v1_space_cache =3D -2
>>>
>>> Damn it, if we find no v1 space cache for the block group, it means
>>> we're fine to continue...
>>>
>>>> BTRFS info (device <unknown>): relocate_block_group loop:
>>>> add_data_references =3D -2
>>>>
>>>> Then the -ENOENT goes all the way up the call stack and aborts the
>>>> balance.
>>>>
>>>> So it fails in delete_v1_space_cache(), though it is worth noting that
>>>> the
>>>> FS we're talking about is actually using space_cache v2.
>>>
>>> Space cache v2, no wonder no v1 space cache.
>>>
>>>>
>>>> Does it help? Shall I dig deeper?
>>>
>>> You're already at the point!
>>>
>>> Mind me to craft a fix with your signed-off-by?
>>
>> The problem is more complex than I thought, but still we at least have
>> some workaround.
>>
>> Firstly, this happens when an old fs get v2 space cache enabled, but
>> still has v1 space cache left.
>>
>> Newer v2 mount should cleanup v1 properly, but older kernel doesn't do
>> the proper cleaning, thus left some v1 cache.
>>
>> Then we call btrfs balance on such old fs, leading to the -ENOENT error.
>> We can't ignore the error, as we have no way to relocate such left over
>> v1 cache (normally we delete it completely, but with v2 cache, we can't)=
.
>>
>> So what I can do is only to add a warning message to the problem.
>>
>> To solve your problem, I also submitted a patch to btrfs-progs, to force
>> v1 space cache cleaning even if the fs has v2 space cache enabled.
>>
>> Or, you can disable v2 space cache first, using "btrfs check
>> --clear-space-cache v2" first, then "btrfs check --clear-space_cache
>> v1", and finally mount the fs with "space_cache=3Dv2" again.
>>
>> To verify there is no space cache v1 left, you can run the following
>> command to verify:
>>
>> # btrfs ins dump-tree -t root <device> | grep EXTENT_DATA
>>
>> It should output nothing.
>>
>> Then please try if you can balance all your data.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Regards,
>>>>
>>>> St=C3=A9phane.
>>>>
>=20

