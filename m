Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4AA5A7374
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 03:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiHaBks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 21:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHaBkq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 21:40:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673D61D97
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 18:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8NPb02LtngKgOkCIUNrD2nUWTXbXnS4aU7HxC56jUHkf/ox6bJAsP8q5QtE7LcbMMwPXgpuBrBA1SSDT4HCC9eUMWoWK6tSEi/ZLDdJq0lwWFOwBiEnRTsspCcoE0gJSpVF2Uc3q+q+24zi0+hUeapUyImarkmyaTuRiq+QNKEhlkmlrvYR8Tc6VvmgmRSH3Gb60CUZ92/UALuywhLY95mtHlt0CjWzp4MU59SBa8aofQAtyF7nACRWg8hoEwWLr1ulbsjekG4WMCxSLgX0KzCNxL9w6cpJTkhodza++VamN0eS92ES/gS0opGAA2onzr8qnsEGrHQRwymWHTgtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqPNfQTdp2tbvDSl2MT2aXJXbbNmPxPhNb2bFH0OThA=;
 b=XE03HOVTWMu+F51BhqXi9HmoJFm7yYGV3V3kCOjje+hldwldNO0S5uU0V3JL3o/Qu6zFcCWeLVrHkjLz/7LjsXx214mtnf3j3XAf+qG5rt6kPDXpFXfYzDZLaSiI7I6QS2HTcK/u1RPgirlqhyAnpPIiPeDvyl6TBQBPwOB31Fy4xx3NDquYO6CcMsPrjmALtKP1cGPHntsbyjyqdI7c78r0CVQQC6sJH8oKMM5HdbjxzekTj4rWnIzphketsqOdr9kROfowGD9kJD+8GttECcSX7li4cT/q37f4arA9KAB4v5Wlgcv+KR+PmrCPsUlPLuPypSwl86U7o0oNRKWCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqPNfQTdp2tbvDSl2MT2aXJXbbNmPxPhNb2bFH0OThA=;
 b=SLXp+ePuXruyhF9o702MQdEgJbTtraMYvFvoKDPquWvUvcrzpHD30MpS4j/bMrO9MnYVO04ozRjzksYBptagWDSHAaH2Q1c5uLaZ3il3D7Zy3lvYxNgPWkDSGB1/a1fUnbqxkRGOxV9mHyLIb9PEJWMGtye2ZgyVPMSq890ACAwOOUS3CFE9Vf7yv5nCno5IiIKTESXtARqx+lI3bPUGFw+ilZ2RUcjmkDWRnrkvM0USP0eQ6ELnuwASh9wo9p4hx0XAaE9QpTkYNZF1Q+fZ+XqDSZ3IuSimQH0lnM8gzOP9X8M3pvVp/ffhipE57+LhTkWz3MyPJ8OmxUP46GUBqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB4129.eurprd04.prod.outlook.com (2603:10a6:208:61::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 01:40:42 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 01:40:42 +0000
Message-ID: <2dfc1628-80fa-5ad6-3c78-5fa6dcc3cb6a@suse.com>
Date:   Wed, 31 Aug 2022 09:40:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <d1986a1743d1f0e56a680b6ab4ba92ba225c21db.1661836144.git.wqu@suse.com>
 <20220830175702.GD13489@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH DON'T MERGE] btrfs-progs: crash if eb has leaked for debug
 builds
In-Reply-To: <20220830175702.GD13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 141e5f98-7b85-42d7-4624-08da8af1d084
X-MS-TrafficTypeDiagnostic: AM0PR04MB4129:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zw4WzYQhsMmkA2mrtmxQ/hQsZs5kQeJ80dHG2RZ7dcf/oWdGaKVg/aSG4zLN53xlSKvP+ECEyb65cph0+qkbAv7JOzZ3Zuf4UO5jQdPFxq66ibnTjbn/BLFgzy+ue+vALOpBliW6v7iDG4QshdvnVN6iSFxJBa5rtgBGM5JTD2VOx3ymP1KLzIAh371R8iMAomKkD2p8TL8xG4RtGcVJnhaFLp2RmGbBCyn08LmXmOFK0r+WYNb5qHDnDhl8c2pwA9MZ3R1C5zJiWw3fycW3ZmG2LqRQVXfFK+A2YttiOM0x/k79TQzi5TjWQ174dgZ2qUtnDUDCnzypjhVX9EvBg6HMpgLNxUjpeYRoS+O9i1L35CnJWk77QWWzI26R+iUYD6+w1xy4SG8pMu8n2eDPMLYmxpVg8ti9K9ovjGho1QOe9L5GoqW0WuF/XRXPQVNU/prp54GI4PfYgf5YAVwivuP8Fe8GnqWFXK44U+MeE9uCfPM8RTrOwb0fkeoMETqqi2OhaXH5UBVH3yMtSb7luuVDqbDaZ6GW+/4WT9klXj3cAWKDQJrGuLQ4Ik3/BrmtvFUsn+iVi5lmKwluLpKbtQ7jKXCij976aKxxmhk1jOdOCOcuRZgSWMY/mIwTj/HMJTwsiaSEBEdb8mdaj+VSdpFpZdqSuv/kOGqAKPd0f8IRBQu03D3Kq86m6BawgAK2dcfDxnDi7Vra0JjBBpJrLgAe0SXdJ+UQv7WgSQ4aQNq2uleamBj/e/t5dGsnUdShfGYC5HNC5xHGWiK2/4HpVm2Mp0xIZm9R3sMV+510rQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(376002)(366004)(396003)(53546011)(6506007)(6666004)(6512007)(86362001)(31696002)(36756003)(2616005)(186003)(83380400001)(31686004)(478600001)(41300700001)(6486002)(316002)(8676002)(66946007)(66556008)(66476007)(38100700002)(5660300002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFyT0hhcmU5YkpaQSs0VERNNXY4ditmVjd0OUJWbGZ2N29KbUwyOFg3ZjZT?=
 =?utf-8?B?ajVCaU9pQVk3N2lmSG9JSnpQTFhCL2lyVGxyT3g4bmdXeHhjWFRoMVZJdEN4?=
 =?utf-8?B?YjV0K29ZZzJkbUUrVjErdmFWck5RY2V4YWx0K2JBV1YvUEJWU0JvenhRWXAw?=
 =?utf-8?B?SkNQRVRNNnNtaW1BMGxiaE9La21xMzUza2t1Zy83OXBXelVVbzVCNEJNUUlX?=
 =?utf-8?B?TlRDZmNIOGg4dkIxRmhJWk1OOEdhdzZvVjBMd0d4N0xNdkJXWkxUUnhHVlBu?=
 =?utf-8?B?TVlvSFZJZ0hTK1Q0ald0c1QxTUZYU3RtQ2dJUXZnK3lLcW13cXc1akJBc2RQ?=
 =?utf-8?B?ME45aWsxai9SNThTVDZzVCtEbFRXZGtlUmVUR21mTU1HK01VTUozL1kzMlRn?=
 =?utf-8?B?amVnemljTjhNYS8xNlY2UGsvR2JQblduTjlmOWhWNjhYaVBPRjJyNlExUEtK?=
 =?utf-8?B?RmxxeU9jdjhqeVU1QVZLMExvU2tMN2NGWk5pSEJFSVorRnVLM1lhaHkzVkZF?=
 =?utf-8?B?Tk5JSkxJbXZxbnpJVmMyd1l5NzQwTmtPUmtveDJiUTEydys1WjdjUUE1ZGE2?=
 =?utf-8?B?a09CZjlMVHVhQWJEK1JRTWNFYjNtbWlRbSsrRUI4WUM4L3I3N280RU12T2Ft?=
 =?utf-8?B?R2txVVo1bWZSYlhFa0tKN0lsQ0p2d1dYNUlYR211REhFOFhCdlpKdUxYOHZo?=
 =?utf-8?B?aEx1R1dzTFJleWcvTGp0bEhFYlpxbTQ0N3NNOW9XVVcxVzlmemc0dFQ5YVVs?=
 =?utf-8?B?K3RRSkNhV0NYSjFVSjdmcEl2QW0ySERvbzF2Qko2amJkRjBERmh0L0JCMEdX?=
 =?utf-8?B?ZnRzcTN3Y3B2SFQvdzNNSFIwT0k2UTRQOEpieWtKK3h3ZGVQVmpuL1pmYyt6?=
 =?utf-8?B?aDNIbm9MemhEdk9mUGlhVU5XNm1kRWJObm9rL3BrcU9Gdy84ZjE4MFlpVFZm?=
 =?utf-8?B?WFk5NithN3huTWJ3Rkl5Nlg5dnA5N0NlRFFzd2xvMzhGNzIyNytxWnlaTTRv?=
 =?utf-8?B?R2oxdHZSMlpLazZVMDVtTytxOVA1UU5Ca3QwOVhTMThsZnVPRDNkZlNSelFJ?=
 =?utf-8?B?U2V2amRyQTBnVHUwQ3M0aVhncnp4cWJPcXYxSWRVNUFKSUl5aEd1R3RlM2s5?=
 =?utf-8?B?QUxqTjZHcnl5bm4wd0ZNSjBXTFh6cFdpVE9veHlRUmRleVNRMVg1M3A2MGtS?=
 =?utf-8?B?VEN3VSszTllVMVA0azhzRktXbEVCclhweS95cGt5b0FLMHNuRXU2bXJEdVd1?=
 =?utf-8?B?bmpQY3IyTS9YUHRzUy9sanhvQWV1aVZBWllEcldSNURBMWdEeXZlV0QzZjVX?=
 =?utf-8?B?ZkFDeGE3ZUVncnd6RWJ1cEZWdEFJemNjOEcyd1VaRkdNVmpjS0RJU3FyY1J5?=
 =?utf-8?B?RU54K1VxLy9CNU5nenZ5Um9MRExpOStLTzdsNVhqSW55SXE2dVBXU3dOWU1y?=
 =?utf-8?B?cVRDb1AxdjdzQTMwZEt3MmdSS1BsRjJpU213ZVJrVU05dWlEMUVVNnVxZnd0?=
 =?utf-8?B?OUZwOTM2L2hTT3VwUzJaVEcwTUlrc2hIUFF3bGhaTSszeXV5WEdvcnBLUTJs?=
 =?utf-8?B?N0dEWGVCTk1yZFRFcm1UVnBmcXBQKzlaaUo5anY2NEk1NGlwcDY3UHA0bkZV?=
 =?utf-8?B?a3o0WU15aWllaDg3ZDhPOWYwazczYmRXdFpWaEJZc1YrQlNwOXJqbyt3SnVk?=
 =?utf-8?B?NWFhZVY3UHZxYVA4NDNzbUh5TGxFdWhUOGZvK24raThsWTRoV1E0YVhER0s1?=
 =?utf-8?B?a05GZ1J5ck1Tb2J0Ny9PWmY0Z2ZSWlJkVjlvS08xREJhMzhKSFpKV040ZTVJ?=
 =?utf-8?B?OVBEazJXVjEvQXpjOU1CMlVYTmJ1VnhsdnhzWit6MHNMc2lSOWFBTTNrTGM0?=
 =?utf-8?B?NXVCcXFhSzk0SVJ2OEovYlVBY2h0MEVsRGswYWZFZUlTNTNjZXN5cjBiNzRK?=
 =?utf-8?B?K0ttM0prRmZkdW5OTXErRDNoVjR4TFBhcmlIeFAwNHNpQ0xhaXIwZ0J0OVVO?=
 =?utf-8?B?dVpJN3lMcDh6Z1RyQ1dMMWpkWGlFWS9QY05JdURMZnQxNldxcFIyM1JadjhQ?=
 =?utf-8?B?K3lEY2xKRFdISjlqaXBNWkhxK0s0bGFncm9OSWc5WFJyenBHYnhoQnNrWDFP?=
 =?utf-8?B?OU40U2xjMWROY0pOc0ZFWGU3Z0RZMytQZ3hoWUlrSVBGN0QrM2FQVlNITDM4?=
 =?utf-8?Q?+C7wAWlchu09cGtJm/lZOJA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141e5f98-7b85-42d7-4624-08da8af1d084
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 01:40:41.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJ/MqYocWqM24fZexncbZJMs5FAki/HCRmypWd98sYyQmBiu90VD+IJJWyx1ybeg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/31 01:57, David Sterba wrote:
> On Tue, Aug 30, 2022 at 01:10:29PM +0800, Qu Wenruo wrote:
>> !!! DON'T MERGE !!!
>>
>> Currently if we leaked some extent buffers, btrfs-progs can still work
>> fine, and will only output a not-that-obvious message like:
>>
>>   extent buffer leak: start 30572544 len 16384
>>
>> This is pretty hard to catch and test cases will not be able to catch
>> such regression.
>>
>> This patch will add a new default debug cflags,
>> -DDEBUG_ABORT_ON_EB_LEAK, and in extent_io_tree_cleanup(), if that
>> debug flag is enabled, we will report all the leaked eb first, then
>> crash to make users and test cases to catch this problem.
>>
>> Unfortunately the eb leakage is a big problem, fsck tests can only reach
>> 002 before crashing at that test image.
>>
>> If someone can help fixing all the eb leakage it would be great.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Makefile                  | 2 +-
>>   kernel-shared/extent_io.c | 8 +++++++-
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 2a37d1c6b5eb..beaa31d36f0e 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -65,7 +65,7 @@ include Makefile.extrawarn
>>   EXTRA_CFLAGS :=
>>   EXTRA_LDFLAGS :=
>>   
>> -DEBUG_CFLAGS_DEFAULT = -O0 -U_FORTIFY_SOURCE -ggdb3
>> +DEBUG_CFLAGS_DEFAULT = -O0 -U_FORTIFY_SOURCE -ggdb3 -DDEBUG_ABORT_ON_EB_LEAK
>>   DEBUG_CFLAGS_INTERNAL =
> 
> We have the tests/scan-results.sh script with patterns to look for, the
> extent buffer leak is not there but it could be:

No wonder it's not detected during selftest.

But it's still not as noisy as what we'd like, nor it's not even enabled 
by default.
At least a quick grep "scan-results" inside tests directory only got one 
hit in 'testsuite-files'.

> 
> +                       *extent\ buffer\ leak*) echo "EXTENT BUFFER LEAK: $last" ;;
> 
> The standard assert.h and assert can be used for the leak check but it's
> also in the release build I think so we may use a separate macro for
> that, or maybe add another class for leak checks.

That's why I want to use the new debug macro, mostly for the following 
two reasons:

- Avoid crash in release build
   This leakage won't hurt any end users except our pride and code
   correctness.

- Be included for any debug build
   We have D=* settings, but I doubt if most developers would use
   anything other than D=1 for most of their development.

   I can go something like D=eb_leak_detect, but at least myself won't
   use it in my daily development.

Any better ideas on this?

Thanks,
Qu
