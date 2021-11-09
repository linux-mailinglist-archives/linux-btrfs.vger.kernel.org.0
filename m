Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF06C44A2B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 02:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242321AbhKIBUl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 20:20:41 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:49501 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242298AbhKIBRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Nov 2021 20:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636420459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cfr5Vu6WO7D7rn1CE/QmnRdabIUdlecxR9D3e7nAd0=;
        b=R5OrbWccaFlHh5mny3dtInbxYF6ZM+eA+wlChkDhsBcddsBAws+Rr3O2NJekh9Of6B8F8h
        h5LNFbjEtt8GEIiBn6GN2nxzaVeLcZNXSLlUIbZtxiTF35OMSfLrcQH+vo0jV4Yz7/nKJL
        GquokrmtX5h0Nrk5xBfe0L7MUMsN1ak=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-3-xlMV7An0Oq-3DAW51Dszxg-1; Tue, 09 Nov 2021 02:14:18 +0100
X-MC-Unique: xlMV7An0Oq-3DAW51Dszxg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3m9ToRp6odBkIW5yk8nqBtLUQInA9OOwPA2o8A6KmXDZMq2NGonM56HypggkxhFz+OC8/jukcq7G9Hmb0jbVXr3/0nm2JLtsmtBVM97Ryj83EcZy1rjBJNkCc2cyUCtX9/Pr0XGG/+Wq5xP6Bfwn/WY140IKPnVjqAKA0YTMDUrEPS3ocHyerV4W9tE+BmLaNSRXl00GTtq/B+9dD7Ykdzpu9vb7wAw7tldmDT8S+t9LKyoGhO5fb5LanwK+pjr98JDm63m7fAdjCiRJLWOStCrq9WFhUowRSv7+NPT9G+OT5wwOSCuM5971vjYwhnO5N18QYslhYagphG6eio3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cfr5Vu6WO7D7rn1CE/QmnRdabIUdlecxR9D3e7nAd0=;
 b=oBE897+0pTn/MiA1z7Jqg3yIlMfdJRbZcb8HfrhMqTdQMePJcyQu/5nAVFVnWUqrtz5u2y+8ufOT4IYYXx93weTODe5s2DfsQVPzKyegCuhYaAYLDGePGwC4mot1IJPyZwWE3TGZXSaOdbTjJO5Jm+aSSC4i30NC09AJ/5fE2d0N5F9sk6ukAY2Mw2z8+iA7Rmn54CgZpK4bZAfc8ixMkNyWClIHAEVtvQXJon8gpztACgn2Vb4FXRwKu+J34Ik+X+GCGB84UtE/gtlXZjGpzhmr2XCi4EVfvN06Alk6F/pr0VZzrLsHCiSBKJd4randeCzvebaF42gO9pd2Kt8Mdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8663.eurprd04.prod.outlook.com (2603:10a6:10:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 01:14:16 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 01:14:16 +0000
Message-ID: <d9ada670-7d11-c1fd-2e15-b1794375c45b@suse.com>
Date:   Tue, 9 Nov 2021 09:14:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636145221.git.josef@toxicpanda.com>
 <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
 <749db638-d703-fd30-4835-d539806197cb@gmx.com>
 <YYl8QTnLySc5hDRV@localhost.localdomain>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 7/8] btrfs: add code to support the block group root
In-Reply-To: <YYl8QTnLySc5hDRV@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 01:14:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a08e4c-99bf-4362-fc86-08d9a31e3f90
X-MS-TrafficTypeDiagnostic: DU2PR04MB8663:
X-Microsoft-Antispam-PRVS: <DU2PR04MB86632BBC0F6DD5FCAFB5478CD6929@DU2PR04MB8663.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znhR7VHQ+croFzCJM/auAIjAd+4iWlEGFcf4f/7gyfVnFUpSleZIO378v3LzZOQBW0bLWE20pAoJn+k5rzi8LjsWMgdweqhWKd6FgKKIuYgYtjxRIXUZsgWvgUHxzBqkc721hxE5hcIWaSgXLK1QesWSxO8rOIkNed16ANimm+FyC4VkSsUzKPF3WduhCuRWhLTk7e8Wn/arEdDCc3KmoanLt49Dizjb0Pg5RyybBLGqDy3a62yk0V+S4F1NfEQJ6yWDJj8ppriozUc1uar2eunEnnLFI2hdGKhupr1eHDQAKYoIl49RiSGMT72h8/8FrYnqYcM9RWTidmiSnA62oDUHbcWsr2pCO4SZkgHffKG6H4ztJ3lGH8lGoIpsDkMAptgzo5rO4kH53NdFMQyOo4mbqRZCBwTcF/ll0RxCzULoCxq5Ez+87V84gavfY4C50eoM7ECyEVtAJoIa0+/TkQttPI21EfhLUQhHT9LP9iIhvjwQUCX3vl7GKtMHG9vaVgAXB9+IEaCRYDKx9bpvO8Hj2zBY6SBFwFWjeBvIzS5QBVqhCJacWqsYUDn8rHt+rLrCjL7A8zsmxt8/JW4nz5J4GdWCoXgGE3WA/WOU5iFYTn8S/0N8bPKjyijLd40KODYcsMXk0aUMLDFXzm5Vk4V1WCdb2ThMniWU+q14hUZL+Dl+dq4XhjEoGGUyq2nMeOgnb0dpBA342hns47Rc4r2Gv+wmlfYJLtOzAGFgOBTV6L4aWFckgK+bXhnVXRoVc/62fQMNQg0WknMJlEbytQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6706004)(66556008)(66476007)(8676002)(5660300002)(31696002)(26005)(508600001)(956004)(53546011)(186003)(6486002)(2616005)(6666004)(2906002)(31686004)(66946007)(16576012)(110136005)(8936002)(4326008)(316002)(38100700002)(86362001)(83380400001)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTg0S1J6WWI4Q0prZVZZZUpJUDFzMW5tR0hCQU9MdHkranVMUmtaeVJtWmRp?=
 =?utf-8?B?bUZwWGtrMHRNWEQ0WkhLWG1qd2V2eWo4bzR5UVdIRnhCQmJVd0ExNHRVQTVK?=
 =?utf-8?B?aDZJOTNGTFRzZDg4Y1Y5V1BWN2V2VnlzUTJjOWwvWW5wNThaRGRiVmNNeVVi?=
 =?utf-8?B?N01UQVFyek1pN2lWNTR2c0ZWcmFaUkZCL0J6YmdHalpoMmo1VHNOSVFIMFJO?=
 =?utf-8?B?MGExOWdGQjY1bThsOVRjTUlISnJ3N3QzeE1qemdLbWRsWTlTOGJMTDJGNnlS?=
 =?utf-8?B?WXdrVVhFd2R3Q1drVVBUMHNMVGg1aHJhUldia0hyamR5MkRiMFoxQzBvYkth?=
 =?utf-8?B?b0dRenFYUXFRZ0QyWFpEcm9PQ1c1b0c0RUUwZG5HZEVUR1N4MnFUdW9kVG1k?=
 =?utf-8?B?U21KSzcrTkVpcUI4anRjYWorV3BrTGNadXF3dWRvWlltMjR5bXdOTjV4SjBX?=
 =?utf-8?B?Z3p1clZKNm45UnBwZk1VdUNjdEdFNEZHdTFUYzJCOVB5RXJDd3NwbDZpL2JW?=
 =?utf-8?B?dVhob0p4cVZZcWhBUE5UZ2xOWGZjZHdvbnA2VVorMVdraWswQ01KU3pkV05O?=
 =?utf-8?B?STZuT1RMWU1xdEIrUldlcy9BR3VDL1E0dzc3ZE5wNnZ4VVl4dUhGbGpwS0xB?=
 =?utf-8?B?eXZQdVY3Ull2bGhFc0VoZnYrR3l0OHJnUkRmNFBibE1xNUtRL0t1dzRtQWQv?=
 =?utf-8?B?b004UWRKYk1GYmRBN1ZtMms1SEtMTVZBMWg4bTFQRWpOY1BFZnVoaXpsWEpX?=
 =?utf-8?B?M2JyRDN3YjkzRkdQckdQZE9XdE5uMVAyQ1VjT09WQTZIaWE1blZrQ2lUK3c4?=
 =?utf-8?B?K2YzSkFlVE14VTl1NFhQNU9SZ1l4MS9NdHd3WS8xQUs3NFBuYzhaV3crc3NK?=
 =?utf-8?B?S1d3WGlmLzNHU29BeFVIeDRhTGpid2R0K3l6N0lMOUQzTTlTam1MbWdUWjY1?=
 =?utf-8?B?UlpvVW1tWm1DT0lrZ0lXUnBrL1p5SGRyblgwWHgvbEdyN0FSUzZzaGcwR2h5?=
 =?utf-8?B?VVRHanRPT2xjWEtya2h0czFsb0N5TVZIM3ZKNmxOKzB4WjU1S1FUUnorT3dm?=
 =?utf-8?B?WjhOakxHeFN6Q2c4VTBIOWpnVURWd0Y0YlAwSytmRzUrZ3R4VUt3RWhqaFRQ?=
 =?utf-8?B?WXNBSWlGSVBaRnhkWm95K0ZZRVJuUG9SamlvZ2d2M3hkdldQcDN1MXBtM3Bx?=
 =?utf-8?B?YUZMNUxUcXdTQnFLQU1PSHNGbDg0alVJWVd2Yk4xcWhhdDdFQ3I1VmRFR3Z2?=
 =?utf-8?B?VGc2dllKUkN6TUR4UnpmOEdPRGZnTGxzeWlpeFVrRmFYSm1LYWErUi9EZVJu?=
 =?utf-8?B?QVR2TnNKTFh2SjBxdkdwdHlvY3J6ajF1ODlDeS9XZmxLTHVWU21wRUJXSUt2?=
 =?utf-8?B?TTZ5TW5uR1hLM2gvRGh1L0JsbjZWVk5NTTJzdmhkMVVoY3IxN3c5bkl6dE9P?=
 =?utf-8?B?eHlYeUY2NzF0ZzhmWExQYzdaRFlMVno4OE85Mm9aekxpaE1rTFIreEE2eTF3?=
 =?utf-8?B?d3ZQS1NuQmttTW9ZOFpSalVua0tHNDJhdlFCYWkvNkJoSGZUcEFmYUNKdnZV?=
 =?utf-8?B?TGpNbWk4YW5hSzZPVC81NXdDOWhaM1RHamQxOWpJT3VnNENldXp4WTJWK210?=
 =?utf-8?B?TjhGU3RHT0FQbE93YndzcjVFT0hVNTdQSHdwNytTcFk3ckNVTDRscDFtbXJh?=
 =?utf-8?B?MDBZcEJuclZkOXlTN0tMci83R2J4U1g2TzU3Ry9qd3poN3RyamVqa0Rvd1VI?=
 =?utf-8?B?UjJPNnhMYjRPZVVsVHV1MCtnRXBlVmt2bW9TcjZ6TG1HaENMVkxhSFdSazcv?=
 =?utf-8?B?YVRTL3Y4SVBQblM4NDZCT1BJUEhNQTJPaVd6U2Rqc2Y3S084THUrUXhBc045?=
 =?utf-8?B?YXdTZXl3bnNPanBHTmFIWG1naHV1NVFBSFQ1N0U5UGM0V3dOWS81ZnBVVElo?=
 =?utf-8?B?WExpd0UxQXBuWXZwb2tvWkJYMjdNTWVXR0NkSjVkczdqdGNveXc0Z3VzZ0RR?=
 =?utf-8?B?a2ZXbGJXTy9KenRzYTVEYXdUNE96T3BhZ0RWTHRhU1piOTNoZTdFd1Bqckpm?=
 =?utf-8?B?WWRPNUpnR2xycE9Qa1RCRWYraTd3bGh4QXEya29FalU4dTZKOVZIWHZsUUM2?=
 =?utf-8?Q?dCUc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a08e4c-99bf-4362-fc86-08d9a31e3f90
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 01:14:16.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEQ5dEq20pcX9Ake/8614wJqd6nx1+vbsnvUzyJ7qtrU5B0ZIGWElrniE0Ppg3j8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8663
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/9 03:36, Josef Bacik wrote:
> On Sat, Nov 06, 2021 at 09:11:44AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/11/6 04:49, Josef Bacik wrote:
>>> This code adds the on disk structures for the block group root, which
>>> will hold the block group items for extent tree v2.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>    fs/btrfs/ctree.h                | 26 ++++++++++++++++-
>>>    fs/btrfs/disk-io.c              | 49 ++++++++++++++++++++++++++++-----
>>>    fs/btrfs/disk-io.h              |  2 ++
>>>    fs/btrfs/print-tree.c           |  1 +
>>>    include/trace/events/btrfs.h    |  1 +
>>>    include/uapi/linux/btrfs_tree.h |  3 ++
>>>    6 files changed, 74 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index 8ec2f068a1c2..b57367141b95 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -271,8 +271,13 @@ struct btrfs_super_block {
>>>    	/* the UUID written into btree blocks */
>>>    	u8 metadata_uuid[BTRFS_FSID_SIZE];
>>>
>>> +	__le64 block_group_root;
>>> +	__le64 block_group_root_generation;
>>> +	u8 block_group_root_level;
>>> +
>>
>> Is there any special reason that, block group root can't be put into
>> root tree?
>>
> 
> Yes, I'm so glad you asked!
> 
> One of the planned changes with extent-tree-v2 is how we do relocation.  With no
> longer being able to track metadata in the extent tree, relocation becomes much
> more of a pain in the ass.

I'm even surprised that relocation can even be done without proper 
metadata tracking in the new extent tree(s).

> 
> In addition, relocation currently has a pretty big problem, it can generate
> unlimited delayed refs because it absolutely has to update all paths that point
> to a relocated block in a single transaction.

Yep, that's also the biggest problem I attacked for the qgroup balance 
optimization.

> 
> I'm fixing both of these problems with a new relocation thing, which will walk
> through a block group, copy those extents to a new block group, and then update
> a tree that maps the old logical address to the new logical address.

That sounds like the proposal from Johannes for zoned support of RAID56.
An FTL-like layer.

But I'm still not sure how we could even get all the tree blocks in one 
block group in the first place, as there is no longer backref in the 
extent tree(s).

By iterating all tree blocks? That doesn't sound sane to me...

> 
> Because of this we could end up with blocks in the tree root that need to be
> remapped from a relocated block group into a new block group.  Thus we need to
> be able to know what that mapping is before we go read the tree root.  This
> means we have to store the block group root (and the new mapping root I'll
> introduce later) in the super block.

Wouldn't the new mapping root becoming a new bottleneck then?

If we relocate the full fs, then the mapping root (block group root) 
would be no different than an old extent tree?

Especially the mapping is done in extent level, not chunk level, thus it 
can cause tons of mapping entries, really not that better than old 
extent tree then.

> 
> These two roots will behave like the chunk root, they'll have to be read first
> in order to know where to find any remapped metadata blocks.  Because of that we
> have to keep pointers to them in the super block instead of the tree root.

Got the reason now, but I'm not yet convinced the block group root 
mapping is the proper way to go....

And still not sure how can we find out all tree blocks in one block 
group without backref for each tree blocks...

Thanks,
Qu

> 
>> If it's to reduce the unnecessary update on tree root, then I guess free
>> space tree root should also have some space in super block.
>>
>> As now free space tree(s) and extent tree(s) are having almost the same
>> hotness, thus one having direct pointer in super block, while the other
>> doesn't would not make much sense.
> 
> The extent tree and free space trees are both in the tree root, the only thing
> that's in the superblock (currently) is the tree root and the chunk root.
> Thanks,
> 
> Josef
> 

