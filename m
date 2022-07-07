Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677255699A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiGGFGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiGGFGD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:06:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D9D30F7E
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1AKnpgmpivklONrHFMlQk6GLBYl3IxYm1pI8Y3/p1AeQ27gJ3RxTRHKhwPuujvxGMiBm2o3Z/VfLTManbA6iGh3URDTBXMUMC3rgAQotF5fFMUyennq4P1E0CYvnQMOfxO0/pCU4aY/21Z/PmNf6q4IQ/cFEdPciqm3ArDER1Li8ZFSu4WQvzXu//BGabs+lFguSkBHwuQ0Cz8mTTqC4xVPp3CHZWlKhNWa9LIDwEIETggpxrrHAqvcQz4yvaDI5+LWAFPpjBBtdRygeotP8VI3BrqlPRVXa3RpbWptopfbRSOMbj2vQCVK3V6nXXIXTFISz+75Codff/0hA7t6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjdhuQnpuvS+D4V2CwA9rvFtckJpTEolJgWMVRv6XDY=;
 b=iT15dLblq2p4nfn7rz1XiSlmpR4W/sJVpFckxzxDK08lzSq+bFV/gfLPrHXb8qOTaw5ais09aYDiy2Vqr59ScSYvZpotctAjp4tXmnbxLJfwJOintIi/f7cfPDAAnZP1gFcFcesKKMmq3cTBhVJN7R/TL4NKrOO2hUiIedvartAzGNnQaouyHXmDjv0miuUjU+dJsrrZH477qRE6fTc7oGGNgWz/jojIkc//A3IWrfNBpAoWnMWLZ85HLLnbazjbTlTm5yLskGQIhOKtLOP1sjVkodHBw76dFvHcUQURRSOVG37pROAGWvUPY9jjSlq6/pJz0Cj+GO6kkf2F/66j8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjdhuQnpuvS+D4V2CwA9rvFtckJpTEolJgWMVRv6XDY=;
 b=1DalCMkBaUmxH9C9yzyflcH8zxXNpAMgqSETNFYgnGSe6VW4yD3AG6nXKnx4UTaumLU6iY/yNEHJwTNxYaINO4a2TJuPfLEFsZqf6IWWr+p6TgcECChPQCBkDCtv07+Vlujkpt4WM70FC8hwJgxZDAi9naHkfjGXMErMkTYMCrIgVKQGgZ31WRJJlrw4ck78tPx35d3mEWfsAfA10utm4Fv8AR4awZnCkQL6/6KiWrcXWlNCWkWt/RGQswMQ3XiPS52tE0wUUHYAPSgb2TusA+1BSUm6lpgx5wUrZVwN3exm5VvGCXxjoTkr1J3xOc9zRCBn78VwpPZgwJyPRbR4jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB7PR04MB4873.eurprd04.prod.outlook.com (2603:10a6:10:18::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 05:05:58 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97%9]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 05:05:58 +0000
Message-ID: <bd94acc1-5c1d-203b-8523-e6986206b267@suse.com>
Date:   Thu, 7 Jul 2022 13:05:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC 00/11] btrfs: introduce write-intent bitmaps for
 RAID56
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220707122446.98D1.409509F4@e16-tech.com>
 <ebdc96e3-56f8-37e3-dba1-79622c860e2a@gmx.com>
 <20220707124019.98D5.409509F4@e16-tech.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220707124019.98D5.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e037ace8-d952-4c7a-a04a-08da5fd66105
X-MS-TrafficTypeDiagnostic: DB7PR04MB4873:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74X6D40NCb7uhao7oe05QbPkzyghJPRPSfbpQ+gOUfS2gTM0+e5FUpAnU3ySG1HGfmxtZyzFhIHq60v24vZKFqG+nLFRet6GlZS5P3pNF2xIhROF3FCdcdvnz6O6q33b5t5lZFgVyW5Ze4SZQuYrQenTbuPY/CfpBzeRn/0P1/qhu8nSnpSDq6jHOdPxembOKOVYy0zlX9k1AQ+apF1pRXG0+KpFoyFmMTjkPMZre154J0NwSSc8lv1GXjEmA3sgsBGU86S2K3fPj2Y0kcIQ53Gk73Jimkuo2qe13w79DZDaupTppnDG/uKWW3f/m9bxj/1wOM+7uxEH6ejllPHKYvcmk2llndMtSyyoRl2WnNFCUlanwsD5Voa5G/7CPez/FPbXSg/QUN86Pp809W7aCzA0YjkP9y80cqDRWYFXIxCgNHSCKLk2A4mMb65tpPiAFwuTovHb/1lHkXXyh/reg/tMEeHTOe2y7gA5vGJYNz96D7ip/Vf/R1B0G5HHdnLc+WeMAjCXHpuXZMmQAw7vITSv2JFWV3AB9D9HRms3x1B/ynng766nOb3c/hKy7qdTlui0ANidvWQ+vJnY/cETgMnhmNL14ibN96dKL6mY1JqYnbyac5vybJhKBV5H/YTwX9WM1yAhqtmd+QyGmZQn79RlNafOQFZRXYCYN9RwmcE1NEHKijV9wEuwz90zAHV0sQKeLoYaJw/0/kj8Vsi3ow2mALd/KhGuiaMBzkvaxfhcrmfNjhZf/NtnwggM8xzJlfCeTdRcssh775X6XDAscShDdJx1inqp5CCP3hq8hTkjmHiIHwUSy3cv8COmxmVy7mQRZGnfk6yEur3kQ1heFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(346002)(376002)(396003)(478600001)(186003)(66556008)(8676002)(66946007)(110136005)(2616005)(66476007)(31686004)(53546011)(6506007)(83380400001)(36756003)(4326008)(6512007)(38100700002)(86362001)(31696002)(316002)(41300700001)(8936002)(6486002)(2906002)(6666004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dExZNE1hU2haR2ZxNU1lMTRtV0FJdlpVYmdqRHErdm5wV1licU02RGZwdWRH?=
 =?utf-8?B?TVVxOVBITGdxb3FLbERVRThoK2Q5dHZuMG4zUWo1SE5Ya2dNVEhBcGNSS0RC?=
 =?utf-8?B?MHBLOS9hTUVaNm9kM1NGU3NJV1hjd3NBTzhCR0tEZit6bHlqWkpaMWFKejNW?=
 =?utf-8?B?d1RyVStiN1dOMW0wckp5ZjBSQzdndzF3Z1QzOE9SL2dpMWlRdXk5MWdSQ0Rj?=
 =?utf-8?B?Tkt3dkMyNmMrWkxtR1U2ZnZBOVNCMSsybHFqY0U5UnVvTmppMWZaZGxjRk90?=
 =?utf-8?B?Ymh4NDBrTjQwUlY1ajRyN3VmRDBoYnd0NXpXQUtFK1ZDM0MxMUROME1VMXdE?=
 =?utf-8?B?amVIbkNlSkJ0VWtiRGQvRFRMVTcvVHhnSWpGTkZNb0xJemZ6ZEJCYWs4d00z?=
 =?utf-8?B?SEg1MlpBSGN4MFhHdmtBS2k4Z0hSamM5ZnZIM3RkZ1l3RDVyUE96YjZGUmVU?=
 =?utf-8?B?OEtWSkxFUUViVHlKS2VvdldSV2oyOUd0c1hzc1FrMCtaZGRZZkJUZEhxSkwy?=
 =?utf-8?B?dVpZMERaenFzRVBEdktXM0ZlbUNuQWYzMVJYVkhnN3pWbXNVUDZESEd1NEY2?=
 =?utf-8?B?VWFraW95VFRlV3MvMm9XM01WZjFRTXg1Ujh3ZDRYOGxqR1JTRVAzQnYxeGph?=
 =?utf-8?B?dDJQODlKVHlUTXArRUNTOGJPSWsvY0c0TXRxeWJ5WlFFbmY0OFR5dzBUNzNN?=
 =?utf-8?B?TTVzR3NEUjdPZTdCRkw1SVJQT1RkaFRuM0JoSTRRZzhJYnViVkYyZmYxUldN?=
 =?utf-8?B?MnllTkowc1RlelNQVUpjWUcyTmpjYUhaVjZGNktOcXUrTTZQcW1ZUzJaZEZz?=
 =?utf-8?B?RGpvKzBUUUNRQlpNY2hRYTRsK2sxTWRMZkQzQ0dSSzZoSkZ5R2FuaTYzSE1G?=
 =?utf-8?B?R2dFR05TNTQ3VUlqektTbkN3TVJwVklzR3o1TmgvOXBxSDFHOXJoQ08za2Js?=
 =?utf-8?B?RVozL0tVMTlMQkFmREtEMUlPZ2poT3h4WjNLdEtrb01KZ1lzU1V1TjBja2xP?=
 =?utf-8?B?d1FIb1FzUms2Y0FzSTgrUDZuUk1IVzV1anQvdDFpS0hLbkZuSHdsRTAwZXNE?=
 =?utf-8?B?NHB2VFlNYVk5S2lxVHNrc28xRTU1S2RCQWJtUzVORnFrSFJnM09yL25XSVV2?=
 =?utf-8?B?OStuWWFVNVZOODNjeGlwam03MDNFbWVTcElwME5GbFoxM0dBTGdZT25IeWRh?=
 =?utf-8?B?VzZFajhoTnJHclpGY0I2R0lLcXp1clIvNUVlTU5XSGhqbDRlVmUxalExVkVU?=
 =?utf-8?B?YlpJODlrdEZMMG9STEZkRU12aXRSZFdaaGh5V0RpNThPT1BOV0J3WkRiUG5L?=
 =?utf-8?B?a21hL2dvRWttYlIzVUtoa0I4bTVCNVM2MUx4YThtVTdZVm83STZaZkcyK0Yz?=
 =?utf-8?B?VElhWHNOVTd2QzJNN2toeDdmY1FpMG1qcjQ2eWYzajdrQmFBbzlrRS9tcENG?=
 =?utf-8?B?biswZWNWOWpseWVuYmlUdDR1M2RVelNTOFRkd3VTYlNtN2FFZ3JoTUxrZ3pD?=
 =?utf-8?B?SENURU05ZndWa0NOLzZrRm0zMHJKc283QXdYNnBCUVdKTUVHMDZMbjNvblc2?=
 =?utf-8?B?NGxZSzdyNFFtN0hXYWtIdzBNV1VkdnlFMlVKRFp1QkcvZmlrcGhvNHZoNGdJ?=
 =?utf-8?B?djB1Qis5Y0hka1F1RGpFVllhd2xFVUVoanUvTVRHb0szMzEvZ1RrK1RXUEdv?=
 =?utf-8?B?N0Zjc1hLQVQyWEoxMUNHQjlHRHNhdkduY3B0Q1NmQzRyYzNuYXcvNHgwYlVm?=
 =?utf-8?B?dVc0OEorcVhmalEzdW5GK0tCRnhaY0ZhNFljcW5FdklpbERZTVhVQnJ4eXpj?=
 =?utf-8?B?NENoaENmQmNjL0pjcUc1V2JpL0g2cFQzVmxzbVJab2dZR1FhcFNWMnRZMEZ5?=
 =?utf-8?B?R2xnVU8wai9IdCtSMWdFMmxwT3AySm1mUUFQcGZDNHhiU0dybEE0SFE3bkRP?=
 =?utf-8?B?eUIzTndKZ3VYTW5NOGV2YkpmMGtTMDFrN1lFWUZpTm52VUJlVFRmNExtc2JS?=
 =?utf-8?B?T0NmMFhVTDM1VXRiblQ3SVF6NGFrRWwzQkwzNWlCMzRZeDNHQS9FSjZtUGQ2?=
 =?utf-8?B?MlFxQmJXU1d1cVJNWGdkRmJaMjEwRmlva0FJd2dNeFVDYmJ4SkZodzZiR3N3?=
 =?utf-8?B?b1Vnek1jUzlHb2o5TkxqSWphdHhZT0pxZU1YUy9yVVI2NGhqWHFuZFdkYitB?=
 =?utf-8?Q?ZopDmJ6sk4hSzk9amqIcgMQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e037ace8-d952-4c7a-a04a-08da5fd66105
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 05:05:58.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3czWrCHiDsrabTI4CzGMMIYLViqf+yhVRJvsHUoQJyKhKQPuBQDUzSb3Uj7/tl6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 12:40, Wang Yugui wrote:
> Hi,
> 
>> On 2022/7/7 12:24, Wang Yugui wrote:
>>> Hi,
>>>
>>>> [BACKGROUND]
>>>> Unlike md-raid, btrfs RAID56 has nothing to sync its devices when power
>>>> loss happens.
>>>>
>>>> For pure mirror based profiles it's fine as btrfs can utilize its csums
>>>> to find the correct mirror the repair the bad ones.
>>>>
>>>> But for RAID56, the repair itself needs the data from other devices,
>>>> thus any out-of-sync data can degrade the tolerance.
>>>>
>>>> Even worse, incorrect RMW can use the stale data to generate P/Q,
>>>> removing the possibility of recovery the data.
>>>>
>>>>
>>>> For md-raid, it goes with write-intent bitmap, to do faster resilver,
>>>> and goes journal (partial parity log for RAID5) to ensure it can even
>>>> stand a powerloss + device lose.
>>>>
>>>> [OBJECTIVE]
>>>>
>>>> This patchset will introduce a btrfs specific write-intent bitmap.
>>>>
>>>> The bitmap will locate at physical offset 1MiB of each device, and the
>>>> content is the same between all devices.
>>>>
>>>> When there is a RAID56 write (currently all RAID56 write, including full
>>>> stripe write), before submitting all the real bios to disks,
>>>> write-intent bitmap will be updated and flushed to all writeable
>>>> devices.
>>>>
>>>> So even if a powerloss happened, at the next mount time we know which
>>>> full stripes needs to check, and can start a scrub for those involved
>>>> logical bytenr ranges.
>>>>
>>>> [NO RECOVERY CODE YET]
>>>>
>>>> Unfortunately, this patchset only implements the write-intent bitmap
>>>> code, the recovery part is still a place holder, as we need some scrub
>>>> refactor to make it only scrub a logical bytenr range.
>>>>
>>>> [ADVANTAGE OF BTRFS SPECIFIC WRITE-INTENT BITMAPS]
>>>>
>>>> Since btrfs can utilize csum for its metadata and CoWed data, unlike
>>>> dm-bitmap which can only be used for faster re-silver, we can fully
>>>> rebuild the full stripe, as long as:
>>>>
>>>> 1) There is no missing device
>>>>      For missing device case, we still need to go full journal.
>>>>
>>>> 2) Untouched data stays untouched
>>>>      This should be mostly sane for sane hardware.
>>>>
>>>> And since the btrfs specific write-intent bitmaps are pretty small (4KiB
>>>> in size), the overhead much lower than full journal.
>>>>
>>>> In the future, we may allow users to choose between just bitmaps or full
>>>> journal to meet their requirement.
>>>>
>>>> [BITMAPS DESIGN]
>>>>
>>>> The bitmaps on-disk format looks like this:
>>>>
>>>>    [ super ][ entry 1 ][ entry 2 ] ... [entry N]
>>>>    |<---------  super::size (4K) ------------->|
>>>>
>>>> Super block contains how many entires are in use.
>>>>
>>>> Each entry is 128 bits (16 bytes) in size, containing one u64 for
>>>> bytenr, and u64 for one bitmap.
>>>>
>>>> And all utilized entries will be sorted in their bytenr order, and no
>>>> bit can overlap.
>>>>
>>>> The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
>>>> can contain at most 4MiB, and the whole bitmaps can contain 224 entries.
>>>
>>> Can we skip the write-intent bitmap log if we already log it in last N records
>>> (logrotate aware) to improve the write performance?  because HDD sync
>>> IOPS is very small.
>>
>> I'm not aware about the logrotate idea you mentioned, mind to explain it
>> more?
>>
>> But the overall idea of journal/write-intent bitmaps are, always ensure
>> there is something recording the full write or the write-intention
>> before the real IO is submitted.
>>
>> So I'm afraid such behavior can not be changed much.
> 
> The basic idea is that we recover the data by scrub, not full log,
> so log *1 is same to log *2, but with less IOPS?
> 
> log *1
> 	write(0-64K) log
> 	wirte(64K-128K) log
> 	wirte(128K-192K) log
> 	wirte(192K-256K) log

It's already done using the 64KiB blocksize.

In that case, a partial write for any range inside the full stripe (for 
3 disk RAID5 it will be in 128KiB), the full stripe will be marked dirty.

So for above log *1 case, it will only be 4 bits set the full stripe 
0-256K (if that's a full stripe) in one go.

> log *2
> 	write(0-256K) log
> 	already write(0-256K), skip
> 	already write(0-256K), skip
> 	already write(0-256K), skip
> 
> we can search the entry we currently used, but can not search the prev
> entry, because it maybe be logrotated?

Logrotation makes no sense. After one entry being written, the next 
write will still trigger a new write for the bitmap, the same amount of 
seek.

And the existing code already has the window to merge different bitmap 
writes into the same event count.

The requirement is only to ensure the bitmaps with corresponding bits 
reach disks before the IO has been submitted.
It leaves a lot of room for us to merge the bits into one write.

Thanks,
Qu

> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/07/07
> 
