Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8544C10C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 13:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKJMQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 07:16:11 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:52929 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbhKJMQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 07:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636546399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1lTzEAtgGIJuF5subgbrAnaz5HpMxq3teI++Xi5aDE=;
        b=mWsoZtBo231kbLcPlsajg08iRCeLpnMt3/OBUHMx1tNcUPJXhs+RtxjWk90b2BRuePLQWP
        nOJ72PX1KKiMzlD4OPv2kngsIwPj8HoXn5yTFixOiidixOoqfJqmlbOP1lLjzj9wDBuIn5
        7RWn8m+tpiQU9RAOIextMTgNbQ4TySA=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-jbp8klhaOPOPLBb01xfkVA-1; Wed, 10 Nov 2021 13:13:18 +0100
X-MC-Unique: jbp8klhaOPOPLBb01xfkVA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duLIFdyBnP0rN3v8fwEZj/KVviCnuEjoJ0C9cPK0YZcF4LHWCch1kGx76z9nkpg1bLN8uRGNG9wy6BZplEo1uUT3XyR7FbiuHM/yXrJKgUV1HvNOuT/bQrblZTYWZWtVMAlq9xfx5Dt+bWwHPTQpKYFZgfefB0lv6WrWXHrxobKekRmWQaRDKUPtfmrEv7pYe1qUWMTdJbdhP/H4NmcN7xlkiqzk2PoqhwK14HRgZvBtuGVY4rDykNMWoXaMqPY5g+G3xHbViv9FrYZxielanAUSWwBd9ETOD/IlUYlfLC8XesvHqIDOL6mgceT+kGbMHx6bDQ50/8HPToYtcUox6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1lTzEAtgGIJuF5subgbrAnaz5HpMxq3teI++Xi5aDE=;
 b=DkiXe+/1137cnLbA5rU+XxYIC3GQrWtilKoYVgz4IwemLgw56eUNRJwJOMwZjlgmR+EnIM7/g/qTkEs5UVf5E+l6W7QNzxcN9IIwT56ja5RzzaHiWB5bI6q+RA3UuiikrCQbk84yhMb2TuZBBq1jdl4OsCRXBBXrRC0D2voJqtyN+oUcuz61vqG/nIv5CqEKlDpp2/MG5X2pPW5Pp85PF/rN2qfpvpjnyx5NQ7uPI7YxSSDe5GHnWDyHLjaEFCpb9qTF/uJjcgS/8uWno0t4wzHZaI665iVK/JeSFo5M0C7fkd3N6S/xmiH8uooZY0z052gi14Qt3Nh3W+dJcQzydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB9196.eurprd04.prod.outlook.com (2603:10a6:10:2fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.17; Wed, 10 Nov
 2021 12:13:17 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 12:13:17 +0000
Message-ID: <72a12bb8-c268-046c-1a38-a7017b2228e2@suse.com>
Date:   Wed, 10 Nov 2021 20:13:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] fstests: btrfs: make nospace_cache related test cases
 to work with latest v2 cache
Content-Language: en-US
To:     Eryu Guan <eguan@linux.alibaba.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20211110093417.47185-1-wqu@suse.com>
 <20211110104809.GV60846@e18g06458.et15sqa>
 <e33a7317-d740-b698-61bf-4882bea4a70b@gmx.com>
 <20211110110139.GX60846@e18g06458.et15sqa>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20211110110139.GX60846@e18g06458.et15sqa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::19) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0078.namprd11.prod.outlook.com (2603:10b6:a03:f4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend Transport; Wed, 10 Nov 2021 12:13:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5d49b46-f9ea-49ac-4a4a-08d9a4437a31
X-MS-TrafficTypeDiagnostic: DU2PR04MB9196:
X-Microsoft-Antispam-PRVS: <DU2PR04MB91965EB3A526BCE4E97089A3D6939@DU2PR04MB9196.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esXlPcYp2E4Q6NW7vfw1EE9FoOMz75A+vz93IwaHNDCC0BZqSi541/hNHnBJl2vKGFMLchNIpRU+TB0kHFbolPPOjPi3lw2HqLQKOW2Px6Uu5fxRGMr2DoN4KvP+McS8QBjMEJVr2orM2z0ZbVXzvY/bfvjmTL0oPk55rGsnCJPrjAhmHl/UfOHjLPMK0lnSE/w+kQ07c5dhhLqVNRUSUPVm7gI31HP64DG24F4BpSr3uFRr4CWIMcQT312NqfH6AqJHE54rj75JLln+oQPLtLynU+fFwEpp4C9YBKASEcGPh9aCj51uIySwzovZcyNfMFmBF0LmocCFdLoVCfH/0jraYFl18KY4vKm5WobiR8mC9HrIIWB0+1jZ9T3fCMZUluy6bygwOuz4dDGFxHBcodHnymXnD4hCBnQLvYbkCEJPqDZ1itTl8o6IXoVnEMdUFpJBdVXFINaG+W+11bB9pdPOA6/SBmVlJJIpGxO4WTs38bb+7Api2ilJLT4CoAvBG8vf6uLJPDJl0ZDoN4UKY4s4lpQDpi67y8maey54/Xrap0na7Ox75yhP01bRq50viCdbhEH555/WeMEPNixJzXVgvIOD2m0mCGjREfk92K7WZvDjUyyJmDhwlZF7OD/XKPnD5mR8+Z9cJBXsllEmXuQK7BPGGQWVSHmYnT8ybBRu1ut9+27HwQ1k42F8UQxxDkj0jdB4znLr/HfKgA0H57kYd7nGMp/fLN+nE80+mrNjO+LPvkK89dysoJ2kxQ0Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(31686004)(36756003)(956004)(86362001)(31696002)(83380400001)(66946007)(66476007)(38100700002)(8936002)(66556008)(186003)(26005)(508600001)(8676002)(6666004)(4326008)(53546011)(5660300002)(2906002)(6706004)(6486002)(110136005)(16576012)(316002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxmb1Qxa2MxaGU1dGx6amNyMllxR1c0TW5VNS9yYnFDUWZkWXFLREFTTGI1?=
 =?utf-8?B?Mk8zcFNIQSt0V1VRNm9wd29MeDZLUGtiN2U4WVJjbmJkTldKcml2WXZtK1Ev?=
 =?utf-8?B?TTRmUTJFSmwzM0h1OVR2RXM2NDFiWnZkQmo1TjJXSkJidllGZWc3RXI0dmZO?=
 =?utf-8?B?Uldha1p6MytHWnFHMXhpc090RFRZTFpaTFhDK2tMSXZObVhCNitoNVg3TXF0?=
 =?utf-8?B?U2hXcUZIOHQ1M1ZaOXY1WHl3cDQ2ZkFoTTJaaU1lYlFnVFBXT01zaTFFN1BO?=
 =?utf-8?B?U2J3Q2ptYUFjUVkxNGJ6VUo4a21iUitNenZwTktSS1NyWWpxUUxMUUFXZXUz?=
 =?utf-8?B?a0gwUndnYXBzVFYxNm5FaWNJMDRpOHUxeU45R3VrTzlFNHJQRzVlRzRBRENL?=
 =?utf-8?B?SU1acVcxenUxYXd2VHh6ZTJkcjNJL01WemIydGhOZXBmdFRKM1lvQ1BiYkRL?=
 =?utf-8?B?OHRvNkVvVTZTZ0NNaEhlTzlQSGY2ZUtYcXZ1eXhzanZENytLemx5VDlydGYw?=
 =?utf-8?B?RUtGNHRibFdxSlVwR2ZBVDFXeHk1WXBuWldFR1BRL25BU1cvVmsrbTBmc0w1?=
 =?utf-8?B?NEpsc2VuS3VxOVNjbDlkdzdVSjY2RVhYMGdiNDhCYUNYMElRa25nUTVzQjFN?=
 =?utf-8?B?NHpSekZRRFg3aEFxNEJwQytGbm9XdHl1dkJHZkQ5aXM0NVl1MlVMVUltYTUw?=
 =?utf-8?B?U0pLeWJTalZUY0RPaUwxaFBFVG54RXRmcFdlSlMvcm5SNXJNNGNzbno2L05w?=
 =?utf-8?B?VzNyVVVrUmhjRVZJS1IxMUlTbDR1dTJwNERRc2lPMHUvVXpVajVWcVV3cXlz?=
 =?utf-8?B?VVdlTHI1dmdvbGhKQzZZbHZpZmpQTGxwekRiZDExZXFtWjRJQnlCcEdTcVBl?=
 =?utf-8?B?SjB0ZEJiRGFRTVpDd0thSXlkUkpCK2lEazNndG90K2VNbTJmQjFlb1Y1RkhU?=
 =?utf-8?B?dGNkVVdFb0RUaGZmRFVveUFkMzFkMFBtRTFTSkdTQnJlV2JIN0ZVek11cUJL?=
 =?utf-8?B?WHBBT2RMRUUxY1BLY2ExZHhDOHlPRkRqaFRqczJ5ZzRGMGtRWkF6b3c2SW0w?=
 =?utf-8?B?YTluS2pVcGlUdUlTTVFKa2xlRlR1UlNoUVJ0YzdzaE1WS3cyY1JVZzViZ1ZT?=
 =?utf-8?B?cVUwWldlNW1XRXc3WEt1Umd1aGFkckhDUHFjMTh4OHhVLzZPZGdWbEl1cm5w?=
 =?utf-8?B?cUNvdWd3ZTNKOW5GWkVXcVBQRnFmN1FJMmJJQU1ZaXNZaXlMSVdhMFNZekJt?=
 =?utf-8?B?QXBXUmE0S1IyZWcrT1UwdXJ5cGp2L2Zjekt0eDVNWTFmR2RpSGMxSUZWd0dU?=
 =?utf-8?B?VHpCRUk0czl6bHRDcEVyRHdXdlVLRlBka3lmaUZKYXZzUWN2alBMblA0MGM4?=
 =?utf-8?B?VFZnY1N3MmFCNmRYYjNBQityczJEMVRwbjdpNE9mMEdVdjE0OWpsbG03WTJF?=
 =?utf-8?B?NzlZeUVkMUQrOVQ5UnBMUlVmdUwyWE5lT09IbDhrWXdrU3RCKzg0bmhCL0dV?=
 =?utf-8?B?Y21wNE1XdTE4bWFGN2kyRVk5WFliWnZqQjhIZGUzUkx3Y2ZBS1pxL2Y0TERO?=
 =?utf-8?B?T0FuOTNCZUlPaCtKOStROXRQMjdZOFREU0hIVEVuOTdSaHJTVFpOQzBSY2sv?=
 =?utf-8?B?Vm9hSUluZ0ZjaHZiNXkyNlpIVEJtU2ExdUhBM2NMVmFYeFJORitoRkVBS1F4?=
 =?utf-8?B?bFRScVF4RE85dmtBR2NzWTdnbDdTQnh6VkJhbVpabTcyY3F4UVpsQjUyR2Fu?=
 =?utf-8?B?dm9EOTNmL3REV1lyNXVxcjE1ODZxaWl3L3RWMnFENEREUVdOSDJiR24xT0VH?=
 =?utf-8?B?R2xrR1IxcDNrbkNNa09aa1JReUZ0TkZCS2RyV1lMSE1jVFcxMml3UVJmQVJZ?=
 =?utf-8?B?OGRKMzl2WVNJWjRLbml4WEQ1aXBpWUhtdVVXNGIrY05NcnRiTWRjaStCSVBZ?=
 =?utf-8?B?Z3VRdkVOME1QcmgzUjVGUTBKYmZrWDE5c1hTZ3RaMEF2aTNOclM5bXZhd0ta?=
 =?utf-8?B?ditGdnJ1Nmx2YzYxbThPV0ZrRUhsOEVBdHgwSjBsOERoSWRQdGF2QjBGelV4?=
 =?utf-8?B?MHo0WHplWGZZNzBrcHFlRTk1UmRHUnp0SFlJYkdnZE1SWTF0SWR5TzlILy9U?=
 =?utf-8?Q?hodQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d49b46-f9ea-49ac-4a4a-08d9a4437a31
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 12:13:17.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDO2OTtyJ/O8x5EF5voS/s7KQwgfLXcBElA7VvkcLl/f3/5bEL2oAl3HOH2OTmJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9196
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/10 19:01, Eryu Guan wrote:
> On Wed, Nov 10, 2021 at 06:52:17PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/11/10 18:48, Eryu Guan wrote:
>>> On Wed, Nov 10, 2021 at 05:34:17PM +0800, Qu Wenruo wrote:
>>>> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
>>>> v2 cache by default.
>>>>
>>>> However nospace_cache mount option will not work with v2 cache, as it
>>>> would make v2 cache out of sync with on-disk used space.
>>>>
>>>> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
>>>> to reject the mount.
>>>>
>>>> There are quite some test cases relying on nospace_cache to prevent v1
>>>> cache to take up data space.
>>>>
>>>> For those test cases, we no longer need the "nospace_cache" mount option
>>>> if the filesystem is already using v2 cache.
>>>> Since v2 cache is using metadata space, it will no longer take up data
>>>> space, thus no extra mount options for those test cases.
>>>>
>>>> By this, we can keep those existing tests to run without problem for
>>>> both v1 and v2 cache.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Add _scratch_no_v1_cache_opt() function
>>>> v3:
>>>> - Add _require_btrfs_command for _scratch_no_v1_cache_opt()
>>>> ---
>>>>   common/btrfs    | 11 +++++++++++
>>>>   tests/btrfs/102 |  2 +-
>>>>   tests/btrfs/140 |  5 ++---
>>>>   tests/btrfs/141 |  5 ++---
>>>>   tests/btrfs/142 |  5 ++---
>>>>   tests/btrfs/143 |  5 ++---
>>>>   tests/btrfs/151 |  4 ++--
>>>>   tests/btrfs/157 |  7 +++----
>>>>   tests/btrfs/158 |  7 +++----
>>>>   tests/btrfs/170 |  4 ++--
>>>>   tests/btrfs/199 |  4 ++--
>>>>   tests/btrfs/215 |  2 +-
>>>>   12 files changed, 33 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/common/btrfs b/common/btrfs
>>>> index ac880bdd..e21c452c 100644
>>>> --- a/common/btrfs
>>>> +++ b/common/btrfs
>>>> @@ -445,3 +445,14 @@ _scratch_btrfs_is_zoned()
>>>>   	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
>>>>   	return 1
>>>>   }
>>>> +
>>>> +_scratch_no_v1_cache_opt()
>>>
>>> This name indicates it's a general helper, but it's btrfs-specific, how
>>> about _scratch_btrfs_no_v1_cache_opt ?
>>>
>>>> +{
>>>> +	_require_btrfs_command inspect-internal dump-tree
>>>
>>> This will call _notrun if btrfs command doesn't have inspect-internal
>>> dump-tree sub-command, and _notrun will call exit, but ...
>>>
>>>> +
>>>> +	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV |\
>>>> +	   grep -q "FREE_SPACE_TREE"; then
>>>> +		return
>>>> +	fi
>>>> +	echo -n "-onospace_cache"
>>>> +}
>>>> diff --git a/tests/btrfs/102 b/tests/btrfs/102
>>>> index e5a1b068..c1678b5d 100755
>>>> --- a/tests/btrfs/102
>>>> +++ b/tests/btrfs/102
>>>> @@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
>>>>   # Mount our filesystem without space caches enabled so that we do not get any
>>>>   # space used from the initial data block group that mkfs creates (space caches
>>>>   # used space from data block groups).
>>>> -_scratch_mount "-o nospace_cache"
>>>> +_scratch_mount $(_scratch_no_v1_cache_opt)
>>>
>>> _scratch_no_v1_cache_opt is called in a sub-shell, so the _notrun will
>>> just exit the sub-shell, not the test itself. Should call the _require
>>> rule in test.
>>
>> That means we will have a hard dependency on binding
>> _scratch_btrfs_no_v1_cache_opt() with _require rule then.
>>
>> Then a sudden "_require_btrfs_command inspect-internal dump-tree"
>> without context could be sometimes confusing AFAIK.
> 
> That's true.
> 
>>
>> Considering "inspect-internal" should be in btrfs-progs for a very long
>> time, any non-EOF distro should have them already, can we just remove
>> the _require rule?
> 
> It seems like that dump-tree sub-command was added in 2016 in v4.5, so I
> guess I'm fine with it.

Mind to remove the _require rule at merge time?
Or do I need to resend?

Thanks,
Qu

> 
> Thanks,
> Eryu
> 

