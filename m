Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F96444B96C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 00:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhKIXr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 18:47:58 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:28699 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229772AbhKIXrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 18:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636501505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bmfXaDkmBxZNUWeJ31yftFcJZclfotwqBIaX1zaBfA=;
        b=CvzI6th/gUJM6n4De8PZXDE+EyrVrGMz7Jq6cUY1IJU1C8czANmMGwyWk3A+6WaaT+wPsZ
        1wBdb4BbVaDEXFW7jjKrpADidNllMxBy2YVsldLm0e4qvZT2U/Ksh2XV3l5CUaXtDX2SNF
        pV8ESbwphaXItdvd0c8UtjDegGgaaRA=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-26fFoL0VPXOjq9n29RKiRQ-1;
 Wed, 10 Nov 2021 00:45:04 +0100
X-MC-Unique: 26fFoL0VPXOjq9n29RKiRQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il2cJsQDebyoFV0LJ3V3QZF4E2MN6RvJEucZQsymkkfWkNB6mfZ2NlWmrSIlafsE9/3FPj6MtAep2wza2mbAmUfrrVtHBVgHAHtqxh+fRA6oN5/BCsGMTceGWT+2Q2tj72/TX7iL/hcg0awnHFZJ22rLhs8fXeESQSc+956L+wF2Kzy8QXQbzJI3hu57HYWxjEQX5BdLgerCCKNHCLiira9SI0OPXQriHq7qWEpTzKjEGpSJdEsSTO3bQ97RaERW55E98B6rGrzQMEjIIaoLhw8SY/BKsTxG7619Utfq2iCA/FmdrkrNUCKGUsKvABEDLl4qOtOi+TqE/Ran17c5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bmfXaDkmBxZNUWeJ31yftFcJZclfotwqBIaX1zaBfA=;
 b=nQaTOi7Ve9WZYvee4UAxjzjseKODAlQaMkv4Fe8ft6+kt78eqgCgBdU9m0ywpBj6CUQa8obGOaYWuPcwBVdZdZS4HJmxmjIKRjpJZw+QPOHvCdhAxGBqzN8sKN809uGJYqUJS2PBaIJDf3T6UMbDG5xiAzqpq6DmiJLHEghKu2Ti6H0yn0jsecDXQ2F6f0rPUQssp9tTP9UnR+Zr84boux+Atqw0nAm/CLH8B5Sc4W4Jqu/6wV3FuBAq7rtMP2xmp2wq4z/g9OPMs1J/RihxYRlDF1F+XSnXCM9q5tHyMqxYdrFK65Bp/PVEJEkrccrYxCoRavrdsbx8RraGGx8MzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 23:45:01 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 23:45:01 +0000
Message-ID: <6563adc9-9606-1100-344a-53236ee3185a@suse.com>
Date:   Wed, 10 Nov 2021 07:44:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 7/8] btrfs: add code to support the block group root
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636145221.git.josef@toxicpanda.com>
 <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
 <749db638-d703-fd30-4835-d539806197cb@gmx.com>
 <YYl8QTnLySc5hDRV@localhost.localdomain>
 <d9ada670-7d11-c1fd-2e15-b1794375c45b@suse.com>
 <YYrK1QVmJhiG2vDc@localhost.localdomain>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <YYrK1QVmJhiG2vDc@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:a03:333::32) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 23:44:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3988f72e-0626-459b-7455-08d9a3daf233
X-MS-TrafficTypeDiagnostic: DU2PR04MB8838:
X-Microsoft-Antispam-PRVS: <DU2PR04MB8838BAEFD8EC21F47FB1FA82D6929@DU2PR04MB8838.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5Q/MclrM2IBJfhJ71NTxOqfAk9JW3oiBQEsS6VkbPv4EfbPEMjbbGzFaoXmw82Ykvq7u5X/zY2G/YTCxraa5Bclogv6W7uvk9VojE16c+mlxtvvRKHAH63otjB6a2smwZhXwv1vWBREhKvvmeYkruY4MGRrSSFkk173NOf0nANCreSLEgOziKigSLJCdvjy4oYqUJyBEJXz9lG+rZFgp/WHjyzvxgtY0meUwmSjoZ5kjcejJq7eBPUGupB4BEX6HYSgJbYZEH1FqVRlwhJxiUs9Di1EYoaeHg37rhPTEnePnSfUzfUb3wAUn28hpnQFcbFwv2JxxtPSV9NZIMmIlRCQ5WSpvNp/kuEWrEle0HbqyUzroUailaVeaNk9jn+i5Wswc4keryDGH8U2DS59nhZxb5U099YUE74Hx6pfGb6A0r4wxKltLpwVakDo7jXz3StoE7eCZE+HmbVTzWeHPVz8UsrWgEfrk/R4qibxYbNHo20xcZ0fSwuYBWJy11rM1xG87ltNodr3auza7m4Zg9uZXaO3h0shkQ57s1ufkUtyWZKol/jdgn9j9DlTQc5i7dnY5iCBJB7tnbn3895sPr5Vr3WhwtZVGCibs279jg9cNFBY9tB7MrK6SK8aCFsLvScn6+3WvILzu5pm5FIJ4R4gQPUl3d9syDYvci/LAERvKlpQRLv8GRN/4STAUFGpbUDe6NFeVhn8vKsTZbZh/sPc2IOW0MwF3fCbMHJnFfj7FIVJVPl5w2Ph3BAPdc3m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(16576012)(186003)(31696002)(66556008)(2616005)(4326008)(6706004)(26005)(8676002)(53546011)(86362001)(31686004)(316002)(8936002)(38100700002)(36756003)(6666004)(508600001)(956004)(66946007)(83380400001)(2906002)(5660300002)(6486002)(66476007)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3BqKytYcXBCRmFtOUJCaUZWL1BCa0MxazVoSld2U2E2a09ITUFJRzN0eFdl?=
 =?utf-8?B?cmUyUldPcVB6TWkvMGg4dXlnYk5aeEtBZkhacEFkWmNzUFpGT2ROMjlyVlJO?=
 =?utf-8?B?b09UZWhXeWZwbm81MW45NkMvWitPWlA2S2VDSE1RZHNmRFBCUW0wMElKKy9p?=
 =?utf-8?B?d3FlY1Rkem1rajdPbXJmTUpkM3JoT0VJVys2Q0JHeVIrWGJKRm1pZ2xoanJW?=
 =?utf-8?B?U2xaeW9nL0lPTUsvdVY2Um9kRVBsaWEycTlHTEZpdWc5MmtKY2F6ZXQ0THY2?=
 =?utf-8?B?OWxpYjBXcUFqVUpWL3lleE4vNU4vQnRDQkFtbzdNcW1xQzBCSDhSN1hGbEZB?=
 =?utf-8?B?S0E2bHE1TmpnbXFoTmJ3MlBZS1NoSFFIeFpiUHFOdHc0MUlDNi9vZng1Y3hC?=
 =?utf-8?B?aTJzd01wQWJhY2l6eDVKY3JnQS9JcTV3enpqNVFxVkRRQ3Bpb2t6eWNCbmtO?=
 =?utf-8?B?aXl5WkpTNy8yQ3VOM3l5TGd5VGtnd3VDbzJXalNSbncyczFraEJJUXpVeVBZ?=
 =?utf-8?B?b2FhWUo5endEeHlMK0l6UDcvazBMTW9nZGFqMlQxNGxadTVPakZRTVVQazZt?=
 =?utf-8?B?RGpodW9wVWlXUWM3bVRZWmtvdUhKSUFYMDloeUdOS3NmV3BUaXU4ZS9WeEZr?=
 =?utf-8?B?SWlod2tSa0NTUWcyOFB1ZysxTXlJNG4yUlhTd0FMaEoyU2lITnUwRGFGTCt5?=
 =?utf-8?B?SXlzeUJHQW5tYTdrNlRNajBvL2RYU0E3MnFQbFFSMlpZVis1cEM1NXcvTUFp?=
 =?utf-8?B?Q1NHVnlUY2s2U3VYS0lDano5YVk1alNsYW1mVGhWZWUxVzNlUWxCc0RnZmdi?=
 =?utf-8?B?bW1lMHU0VThIZzFxQ0l0QVBLaDhtOVdaMXV5L2UrK241T2tFNy82MEl6SnNm?=
 =?utf-8?B?SXFSWXlWWCtldjNRU2NLblJFVkpmVEx4WklFeDBDNWRYamVrRGphTVZzVE9X?=
 =?utf-8?B?R3FsQUp1a0doTVArSUxuZTdIOXB0cW5GbFJ5cWZ6MnVEeGZxWlU4WDJSS2RT?=
 =?utf-8?B?eFBGT2svcGptNG1VNy9KbkxlYTI2RWxCNWYvUlA1bVdhbTRsTUhZTUhpRUho?=
 =?utf-8?B?VGZCR2JGU2w2V2ZYVXNEd01HT2NNYk52SFJlQTlYTlVDcGVCVUtZd0QrRGQ0?=
 =?utf-8?B?VVpaTUJiUWhRM2FoYndvdTFSR1lGZE9xQURjSld3WnJVN0loN3BRK3VvSC9y?=
 =?utf-8?B?ek1hQTZNSUZrNkpmWjZVQ1E2TDhYYWNxSTZiMmZUeXYraDkraUxvTHpjMlIy?=
 =?utf-8?B?K1o3NTQvNXRCK1JKWUlNNmdSNERscGNhejNRZHBqTithS09acDJ3NzNmL1dq?=
 =?utf-8?B?QU02Z1hHN0cyUlVuUnlTckQ2L3ZvdEpZbmdyczBBSm9GL1ZXWCtjM1RTa3Q5?=
 =?utf-8?B?MmpscUE4aWYrb2p4b1NxYS9UVlE5L1ZHMHphcXJpMDgyb0FvMW5XejdLQXJG?=
 =?utf-8?B?VW1STCtBRzdieWEwdStlUmVaTXhoc1RTU1hYdCtyYlhiQ2FlR2twdWZlOTAy?=
 =?utf-8?B?dzRTYzVySmViNkFBejhtY0hrVG9icTlYOHF1Rm5URzNjOUIwbHlqOFcvanJY?=
 =?utf-8?B?OW5UanBDL2VKOEJPd3I1L1JJZ1V5SERaaVhRYWtmcytnMUFPRyswOVM5cytD?=
 =?utf-8?B?VWNOS1hKMWVmcnhoVVNrWXd0K0ZhT1krSU9PUVFRRUxsNmEwcTRRT0RGM0kr?=
 =?utf-8?B?WFFPMEh5YWp0VGtVUnlBb1kya2xSOHh4bWdCWGJ6SWNTdGpuOXVlSHFuOHE2?=
 =?utf-8?B?eVZpRDdNVk9ZSjhPYTdHWHJWQ251dFhJanJ2dmNsczFXcDBtUDdSQ0pvb2tr?=
 =?utf-8?B?NWkxM0g5MVpZcExNcWFZd0VScTZURDVvcjcvSExZUzBMUWIzM2FhUFV0WVQ3?=
 =?utf-8?B?ZFdnYmxaYWdBSWdtSURZTWhscG1tUjVLWXRYeTcwR2RGUUFYSlFKdnhIbmpK?=
 =?utf-8?B?R202NHFJWkFVQ2VEdGpmMFFTZDN0WHFaeC9IRnBNbngzRkxuNWcxeGNURkZC?=
 =?utf-8?B?Z2ZjY2xIYkpUdTZXSnJXR3FkN0c1U1U4ZjJQREF6NlRvZWR3K3llZEx4RTVM?=
 =?utf-8?B?RktCa3pudlI2YlJsU0tjeS9TVkFjYW0rQllhNVBSVThXOSthQUp1bkRNYWNV?=
 =?utf-8?Q?vN+o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3988f72e-0626-459b-7455-08d9a3daf233
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 23:45:01.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYyd5DJv0gHRYjgWOHJMFWBxHwspw66GNzWhXCvzCB4t/zTT5Vtf/jkMOtYHYEeh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/10 03:24, Josef Bacik wrote:
> On Tue, Nov 09, 2021 at 09:14:06AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/11/9 03:36, Josef Bacik wrote:
>>> On Sat, Nov 06, 2021 at 09:11:44AM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/11/6 04:49, Josef Bacik wrote:
>>>>> This code adds the on disk structures for the block group root, which
>>>>> will hold the block group items for extent tree v2.
>>>>>
>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>> ---
>>>>>     fs/btrfs/ctree.h                | 26 ++++++++++++++++-
>>>>>     fs/btrfs/disk-io.c              | 49 ++++++++++++++++++++++++++++-----
>>>>>     fs/btrfs/disk-io.h              |  2 ++
>>>>>     fs/btrfs/print-tree.c           |  1 +
>>>>>     include/trace/events/btrfs.h    |  1 +
>>>>>     include/uapi/linux/btrfs_tree.h |  3 ++
>>>>>     6 files changed, 74 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>>> index 8ec2f068a1c2..b57367141b95 100644
>>>>> --- a/fs/btrfs/ctree.h
>>>>> +++ b/fs/btrfs/ctree.h
>>>>> @@ -271,8 +271,13 @@ struct btrfs_super_block {
>>>>>     	/* the UUID written into btree blocks */
>>>>>     	u8 metadata_uuid[BTRFS_FSID_SIZE];
>>>>>
>>>>> +	__le64 block_group_root;
>>>>> +	__le64 block_group_root_generation;
>>>>> +	u8 block_group_root_level;
>>>>> +
>>>>
>>>> Is there any special reason that, block group root can't be put into
>>>> root tree?
>>>>
>>>
>>> Yes, I'm so glad you asked!
>>>
>>> One of the planned changes with extent-tree-v2 is how we do relocation.  With no
>>> longer being able to track metadata in the extent tree, relocation becomes much
>>> more of a pain in the ass.
>>
>> I'm even surprised that relocation can even be done without proper metadata
>> tracking in the new extent tree(s).
>>
>>>
>>> In addition, relocation currently has a pretty big problem, it can generate
>>> unlimited delayed refs because it absolutely has to update all paths that point
>>> to a relocated block in a single transaction.
>>
>> Yep, that's also the biggest problem I attacked for the qgroup balance
>> optimization.
>>
>>>
>>> I'm fixing both of these problems with a new relocation thing, which will walk
>>> through a block group, copy those extents to a new block group, and then update
>>> a tree that maps the old logical address to the new logical address.
>>
>> That sounds like the proposal from Johannes for zoned support of RAID56.
>> An FTL-like layer.
>>
>> But I'm still not sure how we could even get all the tree blocks in one
>> block group in the first place, as there is no longer backref in the extent
>> tree(s).
>>
>> By iterating all tree blocks? That doesn't sound sane to me...
>>
> 
> No, iterating the free areas in the free space tree.  We no longer care about
> the metadata itself, just the space that is utilized in the block group.  We
> will mark the block group as read only, search through the free space tree for
> that block group to find extents, copy them to new locations, insert a mapping
> object for that block group to say "X range is now at Y".

OK, this makes sense now.

> 
> As extent's are free'd their new respective ranges are freed.  Once a relocated
> block groups ->used hits 0 its mapping items are deleted.
> 
>>>
>>> Because of this we could end up with blocks in the tree root that need to be
>>> remapped from a relocated block group into a new block group.  Thus we need to
>>> be able to know what that mapping is before we go read the tree root.  This
>>> means we have to store the block group root (and the new mapping root I'll
>>> introduce later) in the super block.
>>
>> Wouldn't the new mapping root becoming a new bottleneck then?
>>
>> If we relocate the full fs, then the mapping root (block group root) would
>> be no different than an old extent tree?
>>
>> Especially the mapping is done in extent level, not chunk level, thus it can
>> cause tons of mapping entries, really not that better than old extent tree
>> then.
>>
> 
> Except the problem with the old extent tree is we are constantly modifying it.
> The mapping's are never modified once they're created, unless we're remapping
> and already remapped range.  Once the remapped extent is free'd it's new
> location will be normal, and won't update anything in the mapping tree.

Oh, so the block group tree would be an colder version of extent tree, 
that would be really much nicer.

But that also means, to determine if a tree block/data extent is really 
belonging to a chunk/bg, we need to search for the new tree to be sure.

Would there be something to do reverse search? Or it may be a problem 
for balance again.

> 
>>>
>>> These two roots will behave like the chunk root, they'll have to be read first
>>> in order to know where to find any remapped metadata blocks.  Because of that we
>>> have to keep pointers to them in the super block instead of the tree root.
>>
>> Got the reason now, but I'm not yet convinced the block group root mapping
>> is the proper way to go....
>>
>> And still not sure how can we find out all tree blocks in one block group
>> without backref for each tree blocks...
>>
> 
> We won't, we'll find allocated ranges.  It's certainly less precise than the
> backref tree, but waaaaaaaay faster, because we only care about the range that
> is allocated and moving that range.
> 
> Also it gives us another neat ability, we can relocate parts of extents instead
> of being required to move full extents.  Before we had to move the whole extent
> because we have to modify the file extent items to point at exactly the same
> range.
> 
> Here the translation happens at the logical level, so we can easily split up
> large extents and simply split up any bio's across the new logical locations and
> stitch it back together at the end.  Thanks,

That really sounds better, and is what I'm going to do as a preparation 
for the iomap work.

Move all the bio split part into chunk layer, not in the current layer.

Thanks,
Qu

> 
> Josef
> 

