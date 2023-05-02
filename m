Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242546F433A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjEBMBR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjEBMBQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:01:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD585244
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7I43A6f2fU609Nmyycku27iZrnxgqbT4lvK1ww/WOPVz+/TDQCpOGcjiL0pacHvBn/hx59FpxaAeHleTDdHuDipbtDpD++1aLBl9RmForA3EmMj7aOU4Mbl9Cun6fHcL9xjBj3XhFZQSJIOQVVYjPC3Z8OvrGxScfhv+q0ubeTpRuPuhXTEyli8QLBDFS8HFJAsMNmM7OxO4blguu5UDplFHDLr9aEBZWaIZzeVZq1aVr8DSBITrR512LFWFsl+yvyIZQVcKXW5JYu8GKA9zfcWhnEz5D2SL/PZOTFZD3OL1gQTy1FZDRaHKepswLWzhsW+lq/reZpOptzCALSn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGqPwjIhpn85EMaRENlPVLRwlZi/i2rpTd0cZPGXeww=;
 b=WYdjDvOKecwem1gMGmwBW0lvZ8aZHqIHuhNFpTiOrtNWeX6hGNxTRvRsgjlA+56OsY4xWbPwCeR98gq6U9GwMNPTgoE31WgTk8PaKOdlZ7w52cCBYlXzgr1l/ZBkhPzQXm+SDBptrB/+aZffNikBI9UEMTqh5xNCsowSw4YrIw5GMiWZO87CY+j+bx+l2AUGWc9eKntOVamUmHDhvKq4n3oP8VLFWM5V9KKWbspyNegfER1bnsPcx1w3TKoJYFKwbAfcAtPh/yMyMpBi2Il8YDpuAMLb8R0/3gziJHQfCuXibF9Hk9UNcMnF2hHGTL9FZHCYyrI3ldezg3b3EeNXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGqPwjIhpn85EMaRENlPVLRwlZi/i2rpTd0cZPGXeww=;
 b=vMtwC7kqhi4Zl0KIUg34TxdHBnF7IVDxqn3YPfHQHfMgSzXl9Onx2/jBEr3eBzUM1gEnkDpZs1eM8HLGqPCA/K74tOf74YzXxHt2j5NAqSZwhprl1a6399ZHYnZ5asTLlmv06L2LvPx2NYe977+8Fg9A7ACQ5rBxFvyQt7f29k5xRwUClyJDvtunleWE/VwJrV89h0kRB9dKnkfnIaHkOE+ZzJONWi9bPoJIFm/9R4zqlW7Nb/E2iw7MUvUaRJAuKXnaU/7bzzObrucOUwKjeD2fUA/gpQY6x8bFJwOagq02+ZUzVKPy5/hmZtSxoZPbZKbsCM4VrQqsYXs7Lgt27g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS1PR04MB9309.eurprd04.prod.outlook.com (2603:10a6:20b:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 12:01:07 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:01:07 +0000
Message-ID: <f0af43f7-dd50-85aa-ff92-4bcac5d40ce5@suse.com>
Date:   Tue, 2 May 2023 20:00:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <8cf9b5f14a52067bec9c4bb9f2d2c13821e0d7b6.1682990969.git.wqu@suse.com>
 <20230502114142.GA8111@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs-progs: enable -Wmissing-prototypes for debug builds
In-Reply-To: <20230502114142.GA8111@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::47) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS1PR04MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: 984fc163-287d-4df6-324a-08db4b04e970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: re/Y9O+Hk3CDyjctcewyFaYxnlX9DTT47t5q4KYpH3HeIJjzKBAAT4XFEMK9p6D1XPS480nd1As2Rq/6iUsgi9CTghh4ay+PSfgGx5dHGRMqhHUs4Emim+fA2xnhUqI1obc9juWfNX9BCTtBDim77zvmmLc96beyO+V78Jta2Oxy6TtX37JCzkeJSCkltfmuA4croRTj06EWLD/f6bAeQZNjCFROU6Vgnb/tfLlln/ApBRxMf2S9fxXlW2eZaUYTa9fRm9ddtVDiaFcLEwf/UB1wscUL99K2LZNg1jXUhJZvuDHWZ3Oqa2ms7YVHLxmsomnufn8lz55DsHiVBZsgdn8oNbyTPcTRChr66gZrW3SEr7vNck0Dm1R9Qeisqnwmv2Bask0h6HcZJJfzNG+ANUgaHkf9/RcTKuWwO9PxGQz2a+fCwA1cY0EzknQIR0ogzkC319HU5r/ObVKKc1QtaMDCioWZi4wOfsf5aaeJQTUPPf2GmNKMTosTRdBijThiZ0wKcDqL80M63IWHZHDhek40GFxIkIvrI0w83FzO5RTBZrDydFuP+VaD1MOKSLqqSUOyQp1XVTHLGg0gJqqXI7aNDDHojJndLJTkY9inb2mSl2nXfzTU9k6fmGhSzs2UAkssORFasBjkyULWv/XGeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(31686004)(8676002)(8936002)(2906002)(5660300002)(83380400001)(2616005)(41300700001)(53546011)(6512007)(316002)(186003)(66556008)(66946007)(66476007)(478600001)(31696002)(6486002)(6506007)(36756003)(38100700002)(4326008)(6916009)(86362001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHhYK3Fmc3NsSlFERXhyUHphMWpGS0xhbUJvWElJUHFDbURpcVEyeGdsOE5q?=
 =?utf-8?B?bEpmTHNJY3Q3SnFlNWo5K2JpaytXSXlTTm9UdlRDS1Q2aE1QQ2FlNUhOVGNt?=
 =?utf-8?B?TVZJZ25tMXdqVGpQUHE5ak5qaTUzUGRmaGhpeWczTTJsWGYwMmJqendNS2U1?=
 =?utf-8?B?Z1NyOTQvSXZsbkxWUFJoVDlJUEVhODhGenFIaDJBd3NUT0l5eEs0VGU0TE4z?=
 =?utf-8?B?bW9lRHBEYVE1bnZNTE1OMzJpaWFtZGtRdTQ5cWJDNlllenppWGdldVpmZWdP?=
 =?utf-8?B?aGVZUEJ1ZVZ1R2hLVkZYYlFHL1VQWkhkdVc2VzJVQlZCeXYyNThuTGtnV2Jv?=
 =?utf-8?B?dC8vS1hIRkV0RXlGRWZ1YWRaSWI1TUxUTmkrS2lWZkNpa1NYd0NxVnE1TjZX?=
 =?utf-8?B?ZUZRcWlNejRzYmpjbFdSQWU4eFhpWi9BRFJVRXU4Ti91VFVnZFI0QmJGRnpx?=
 =?utf-8?B?OU03WGo2YUpCNGJoampjY2dsOU03QlZSd0x3cm9XVmtMakdXZTFGdkN1eURR?=
 =?utf-8?B?NnhuUFVjY0pHVWJFUXVvNVB1bnphTXlkWWoycG43VDhaS3NYa3NJTlUzR3lJ?=
 =?utf-8?B?d0lDVjYyVmhIc0lYd3UzMitoVWE4OWtPNkdsKytFVWFtd1cyYlBUN3NkTVdH?=
 =?utf-8?B?QTVrTHdWZTZnK09MWjN5aTRPRDZ4ODJ0TWdhYWNtZjZKSUNYYUhOVnNCWmhv?=
 =?utf-8?B?bkx5V0wzUC82TjJFeEpmWVNwakIxZnhSWHJCTXdZWVFjQW5LUURkYnFQRHYw?=
 =?utf-8?B?dDVxcTNlenVUcnRuVS9RSkx2TU4zcmJsU3RCbG4rcDFFeE0vaWRlRE85eVE1?=
 =?utf-8?B?SzhLVmZyVTEweFBVUE5xNHQ2cGc1VTdBN0xjQmNDa2lpTzNNMEFTM1ZJT1JE?=
 =?utf-8?B?dGJsZjI5N0Vrekd2MzBuYys2UXVuWDZqSWI4Znl1M3lkdi9PWkxVeXpFZW0r?=
 =?utf-8?B?c0ZsRVZTZWY3VWtRL1IwWXNuaDF3TFk5cHVRWGFyYyt5YXN0bUFLM1FIcFVL?=
 =?utf-8?B?VlpXTGF5T3llVGpXTjhvM1VRa3NSUnVRQ2lOQmxlN2RzV0RHWXA0N2I3TVRn?=
 =?utf-8?B?UWFDUmM1emNvajROTTdxY2lTSmNha096Z1djZDNQVkFYSEZ5bmE0dWJLb3RI?=
 =?utf-8?B?dElSMlRnWklnN0FyVnVVemdrdHNaM1JDb2tXbFZ3MXY0L3RQRXNpQmVDenRB?=
 =?utf-8?B?a1VtZnRwUXZ6VnhyS2xaUTFQaXE0MTlhOVJsZEhzWEkrL3VuVmFrbzRWNGYx?=
 =?utf-8?B?cVRzWWxtSXRSRzRUMUpkWWZCNGxOR3MyaXdXUFZMek1sY3FsL0grVitHd3B6?=
 =?utf-8?B?NlU3R3Z6ZkVXTlhsV0F0UG1PbTVLT0xwOTB4dnlJZHF5M25xbHRia29JYlor?=
 =?utf-8?B?S3M3MW45UWlNK2l5TlpGWlNqZU1IWGpKYlRqNzdoMlZBSElyTFJYN2pSZi9D?=
 =?utf-8?B?K2hiR2hhMW9Qd3k4MTBBZTVOVlloY01qUFNLamhoWTQ3ZW9TRmVUL3RYeEU1?=
 =?utf-8?B?WExXeGNFMDZwdmFaUnk2WEovcWI1TnVveEZLSUhZRWMrSmVGVC9aMDRGZFBH?=
 =?utf-8?B?VXliRXpQT2NMTlRNaTE4NnFoMlhyeWszT3NzKy80YnVGSDc1eDJSS1hEZmZK?=
 =?utf-8?B?NWVzMk5jd01xS2hzczVGa2hLc3V0Ym5hZGNUWGw2ZEdUUmN5NFhZWGpaQkFk?=
 =?utf-8?B?U1c2aHdTV0s1STFlTGJETm9xa3Q3anFhbWJyZ0hWdWdPUEpMWURiOFViRFBO?=
 =?utf-8?B?ZVVuRldKSHlRTnRCSDBkZ1dmNEZTLzQrd2FUNFdCVlRmeUd3TnNYQ1puanJ6?=
 =?utf-8?B?WFF0VHJtdGdvWFJsR0pYME5NQ1cxSnJHcVg3eFlIOGQzWEVjOC9KOE5SekRp?=
 =?utf-8?B?Z3E4MU1YVHIzeGdOOEJTNUhkV3FYNUlXak5oZnl6QUdFMWdFM0k0Ry9BdHlM?=
 =?utf-8?B?MnVUSEZVU0tkb3Q1S1ltL1Jid1JJNXRlM1JFQ1lUWFNlT0h5bEM5L1B4K3oz?=
 =?utf-8?B?VzRzNlh1WEk4aGV5MGwwWEoxcG85eFRxRUdlakR1ZHpob2dGRlYvVkRGRG9L?=
 =?utf-8?B?NnRFcis4Mzk2RkR6dm9Dem13SEw4Z0w5UDFOWnlrTEdjZUcvL09BSTJpMHVX?=
 =?utf-8?B?TDVmeUlyaGUrWlRpMkc0RlhydHdod1dCZ2cwQ2w3NXd5MWRZLzRPUFFyWHVD?=
 =?utf-8?Q?0npjl2JHde8JI8hjus3NjZo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984fc163-287d-4df6-324a-08db4b04e970
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 12:01:07.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: By0b4UdhiDVAmXZrlkVyk492vrbLGayOQeeU4H46vmew0YJ2ooiHGju1FP4gie93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9309
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/2 19:41, David Sterba wrote:
> On Tue, May 02, 2023 at 09:29:30AM +0800, Qu Wenruo wrote:
>> During development I'm a little surpirsed we don't have
>> -Wmissing-prototypes enabled even for debug builds.
> 
> The build supports W=levels like kernel and -Wmissing-prototypes is in
> level 1. In some cases we may want to add the warnings to be on by
> default for debugging builds though.

I just did a quick search for the word "missing" of progs Makefile, 
unforunately no hit, thus I doubt if it's even in debug level 1.

And the missing prototypes warning is by default enabled for kernel.

[...]
>>   
>> +#include "sha.h"
> 
> This does not seem necessary, include whole file just for one prototype.

This is necessary as we would define a global function, without 
including the header we got the missing prototype warning.

All the other comments make sense and I would update the patchset.


The only other concern is, would this extra warning causing more hassles 
for Josef to sync the kernel and progs code?

Thanks,
Qu
