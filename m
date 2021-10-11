Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9761429989
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhJKW6S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 18:58:18 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50694 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234328AbhJKW6R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 18:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1633992975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nf24uf3M5eFaHh3+xuIOt5i7nYeDVuO7qIbfa9UCnxw=;
        b=k/sLuiUXIZ3qM0B+dfgZ4JaDk/GpRBsUHprYSBzdWbIxczJlzc/BS/yle+41nghQUFlFH7
        Ei3jMmLmHNkZMmH8VfNT+Mm2r92fDEy1s1f8NAzJBM2BzZh+pPV2LoL22d8ySJKM6ioTJD
        jDD9DI3gO70PfyKLF3wXKSgVmJ/rYkY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-VX6a7ePmP8Odg5D26RCG2A-1; Tue, 12 Oct 2021 00:56:13 +0200
X-MC-Unique: VX6a7ePmP8Odg5D26RCG2A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Djb7Thr08wcHyAJpK4xoTXtKk2cltRDaNCFbLvgK1VTyd8UdzqNrz2En9QTZqkrzVB2WpsbvMpojDtlwjGP9WqFZHKUpgd/yJnCGgP5pLewZwT0koowWaK1MOT9WcEVrsNI4Pb4vCu71CnjgrL0i1M2XJcuRp4I63d5RVe7R9+2DJFZjsj0paQ9CV9Gm2jK4A3bUPtooP5/ENZIgcUpk3jE7pK6+QO+8iIFL9aeZnfI6QKjeZaBBTbYsJedVDB+JAixqYpm+g1oR8iuWD5/RB0OamSyF+mpkmOait5aueGUhRoHxt6k6ReuuE9gIxCPLK2f87G7RJs1wyzbxeIVCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf24uf3M5eFaHh3+xuIOt5i7nYeDVuO7qIbfa9UCnxw=;
 b=MyK/8COQN02DER71urYSfGbhz8h73rkU/8nTUirK9ElVsqBiikbHv5R5nQknjXF745ZS6dBBRQplYzEJ2d9rOv13w6dXprD3AxqVar3yADPGWwwo8y09YNPeZdj13SMXnRsb7+Z2n4GUE2UlGBDEvjXwp66JLUHU6drzsP4xLquxupQa5QwRqInJ6sQuM/0OBUtF+21w4m16PZnluCBYIzoftplrgF8ZTBRRIoxINA6UiKyo3LmeBVgQPQzmq24Oep19qPnJQfeRrclbYOkhoDQerh1v8yoKygPOoTH7YCIXtD+EKJ1Roffff0KXXhUT3M435BWNVzS55lhJgRlIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5414.eurprd04.prod.outlook.com (2603:10a6:20b:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 22:56:12 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 22:56:12 +0000
Message-ID: <86b55875-05e1-9ae6-0612-95eba2a2ba88@suse.com>
Date:   Tue, 12 Oct 2021 06:56:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 0/3] btrfs-progs: mkfs: make sure we can clean up all
 temporary chunks
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20211011120650.179017-1-wqu@suse.com>
 <20211011140517.GI9286@twin.jikos.cz> <20211011143927.GL9286@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20211011143927.GL9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 22:56:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a80ec151-30ac-4d69-a96a-08d98d0a529a
X-MS-TrafficTypeDiagnostic: AM6PR04MB5414:
X-Microsoft-Antispam-PRVS: <AM6PR04MB541420B485985B563BA4DF2BD6B59@AM6PR04MB5414.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CptiTvIcOsGuLLpMY9yZe41yD/k25k6bs+Km9HovWrQGU0agDyWekBvjjcDPPeZ/UmBCEu/a3wEY7kIIplsXRGNe/xWRcBw4p8TpIHzhFpj4h2yqybp3MGI2GOm9Q4yF2uEhePdo8h67wjLbR9LJ9nBCqLvBL1aCwlmvbOm46dNB14L+s/cy4BBCQGwidBY/dweOH6q2eaDU35FoHfFrzKRY86sZWBwqv5C+/Vs+bcMxMabdyn2h6mL935Z+/fxyIRlrk50gFh/ViVP3DmLxZSYBTuBXbj2LO0UhUUrjpIccoscsBmPYllvpAqkRW+xRaL5C7VFAMVSf7r0Al179y99cTRay0qJnMirOEVwDkli2coKXHW+ekSl/Yn7d0hj73atyzuJ1EEDwa26y5ryR6S5tr6hRFy1m7Kf886M69MH25IkGiR9CcoSGScgh9kosTnE4E0A6biZgx7E3ZPFXEGWHHEeKY8F2dh9jbL74LkwZqJUgCDOCMdzhpR43VP9htmxCNQINnM7NZhoJ//ShnDbeGqyhWnVoK+PRBZVJBnpb9tBG0JaEO1bVZvUsLYLXkGt+p1ZkcnBftiyTdT/2qz6XGedXn3XSRbg2gyKe7GEjV/5K4F0uY77LkgBoiBTogpYhE9HYjwND+v59YG4lVlfPx8cOmxYvAphV+ysv19E0YS6SREJO1EHScylQGHbCosB0muClNdThpatiYk0aEGFVuqJmNo3s+6PiHxkHz6GAyzbxTjVRPB6H8q437WUblhT19jzo7AY17VqyIJuYkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(38100700002)(36756003)(508600001)(8936002)(5660300002)(8676002)(6486002)(66946007)(66476007)(66556008)(86362001)(83380400001)(956004)(31686004)(186003)(26005)(6706004)(2616005)(2906002)(53546011)(316002)(6666004)(16576012)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDIyWGkzenlLR1pjVTBYcUxPZXlsb0c3MFBER1JHWHh0MzVBYW9zTStpbml3?=
 =?utf-8?B?bDBaTHM4UExtZFZaN0N1em5xNHA1MklaM3RIaS9VTjhiTGZPWGN0NTUyMzMv?=
 =?utf-8?B?NFRhb3hTcG8vSHhKbFpJeUM4dXdzODdibUZQUW9MaWY0T2JJK2liUW8wa1Y4?=
 =?utf-8?B?bEhhR3BJbDZMZ2NDejB5MU92cWdMUWcvb3JsaDRtMWJ3dmFpeERjSkJlQTB5?=
 =?utf-8?B?R1NoWXhzbHVvSFJPQzVnM1hNeW5QN25lV282TWdESU1nZ2FEMUk1Q1RyV0lx?=
 =?utf-8?B?MEdjM0YwWUZ3bWxhUXNVeWVGNVNtNG1vK2VKbGdJazBBODZJWnh2R210UGpT?=
 =?utf-8?B?WlFDUDJXSEFWN2lxaEZmWnoxRFBEWjY2OHlQRTI3SEZHdThMVWtYZ1liVHV0?=
 =?utf-8?B?ZllYYy8vTmVvYTh2WEVzNXBpb1VXM2crZ1ZKdkxxZGhjSkxtV1dnYy9aNnVp?=
 =?utf-8?B?RTlicStKbnJVM3haQk5lRmMzR2NJck1waWZhOFJScjhaYUtlWXZxeDczUUxs?=
 =?utf-8?B?bVRtU0F5cFNnVEZYQ0paUEVOK2RKTUppWUNZNlMvNWk1N2I3bHNIZU50UEFU?=
 =?utf-8?B?aDU1NW9nOVo1OUhwcFlQbWk1SFZjV09XYjFFdkpqTTY1MS80RmY3WDd4dFRW?=
 =?utf-8?B?SDFsL0xpTE1SeGwyWGsySmgyL1dxbFo4N3NSSzdHdWlkVGY1Rmxad3Z2WDZt?=
 =?utf-8?B?d1NNbFp6c0ZJRzgwRG55SUJKOTVJcSt2NmdoTlZ0V3lsS3V1TXlHNHM4Lzh1?=
 =?utf-8?B?VFFmYjR2M2NyTkQ0SXVaUlZuUHh3cjBRWjJiSithVURPK2pQUlhTRlNJTTQ0?=
 =?utf-8?B?WVRCdVAzeWtwYlNjMWFhdWFHRVo2cGx4SmxEQUM2a3d5TytXZHUwSGdmSHNv?=
 =?utf-8?B?WWtBNHRndVlScXo0bHY0c0hPbzYyeDdjek5hOEtUUHlPS0xCZ056WHlsSlZC?=
 =?utf-8?B?RU9zS1RYajhRd2w1a3UxNDBTV2sySnF0ZXZtdWQ4cTVsWXpMNDJ1ZzZpQlp0?=
 =?utf-8?B?MlZnSjhrM21uVW9kYzdZakNaQ3JKODlYS2h5b2IvbWhaWEhkamFJWTQrOENh?=
 =?utf-8?B?NjZFcVQveVI3bC83U2xZc0JOVHlCd0xCK1AwQnYvSHBRZlh3SlVlNmFSMjNG?=
 =?utf-8?B?UmZsNFkrai9ZbTlCQkl6V3hGYTZCK0s1QVU3cmU3WXFlWDdiUXBndDROenZL?=
 =?utf-8?B?d3ZDbGpoeFN6Nk8zS1VuSjJiOUhSbFBwY2pNVUVRL0RMWW1pUU9nT3pHb29B?=
 =?utf-8?B?aUpvU0dXWXF6OWY5alNCUjNvaGZWVmZueWR2YzdjVWd6d1lxdDgxTEVqeEU5?=
 =?utf-8?B?UVV0QXFmdHQ0NVk1S1N1WWY2SXlyQXpqMnVGM2xMVE4xbTBrZFJrYy9vN3Az?=
 =?utf-8?B?NDNMUlRpZlpFNWcwNDRqS1Noa2FidGZQbzN1all1Q3htaUV5ai9nMTJQakFV?=
 =?utf-8?B?c05Hd0tpYmU1YWZrdTdHeVIrWXZWdVUydmV4MGxDNE9xQTdDZTBOR044WGtQ?=
 =?utf-8?B?V014R1V5VmJWelNNQUxOVEZtUHh0UThDaUQ4ekxlVXphMjZ4K2lBekREMXpG?=
 =?utf-8?B?ajByWGtMK3lXcVZDS2ZhWjdtUW01bi9EZk5oQjh4RUJiLzhaVmYxaTFFaXVa?=
 =?utf-8?B?d3B0bmdscXhvUFpGL1duMzZLYko3cEZSTFFzcUJicFdielA3UkMzazdRTUpn?=
 =?utf-8?B?QjhVK1JzWkdrY3hRZXMxRGVPV0RoNFdGcXJha1dHWHM4Wk4zeDQyWGhUR1ho?=
 =?utf-8?Q?uBQp6Livx+bIea9I7R/xgxCNi/2KFuozXpSNEJ5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80ec151-30ac-4d69-a96a-08d98d0a529a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 22:56:12.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+anfil3XludYlUA+dmNuwwPHvmajJpY6klaTZp662be/vGDQPg47pJY9fzUdQXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5414
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/11 22:39, David Sterba wrote:
> On Mon, Oct 11, 2021 at 04:05:18PM +0200, David Sterba wrote:
>> On Mon, Oct 11, 2021 at 08:06:47PM +0800, Qu Wenruo wrote:
>>> There is a bug report that with certain mkfs options, mkfs.btrfs may
>>> fail to cleanup some temporary chunks, leading to "btrfs filesystem df"
>>> warning about multiple profiles:
>>>
>>>    WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
>>>    WARNING:   Metadata: single, raid1
>>>
>>> The easiest way to reproduce is "mkfs.btrfs -f -R free-space-tree -m dup
>>> -d dup".
>>>
>>> It turns out that, the old _recow_root() can not handle tree levels > 0,
>>> while with newer free space tree creation timing, the free space tree
>>> can reach level 1 or higher.
>>>
>>> To fix the problem, Patch 2 will do the proper full tree re-CoW, with
>>> extra transaction commitment to make sure all free space tree get
>>> re-CoWed.
>>
>> The extra commit breaks assumptions of test misc/038 that looks up the
>> backup roots in particular slot(s). I already had to fix it once due to
>> the additional commit with free space tree. Now it broke again, the test
>> is too fragle, I'm not sure we want to keep doing the whack-a-mole.
> 
> I've check it with the v2, no change, so I'll disable the test.
> 

I'll update the test case to make it more flex to handle the extra commits.

The proper way to test the behavior is not to use the hardcoded slot 
number, but auto-detect the slot.

Thanks,
Qu

