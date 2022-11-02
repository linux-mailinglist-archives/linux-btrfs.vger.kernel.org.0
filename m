Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9616170B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 23:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKBWdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBWc7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 18:32:59 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20041.outbound.protection.outlook.com [40.107.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88ABF56
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 15:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqTK56S5a92slmOadLsLOBCdNFeC8e3JuVY3LfSgtARRG+H122GDyVhzPhba6LA0HSA3GSIrsJmdmowchq0UP4cFfEjFQgkKu1Z6eGPIr4ECnlpqH0Sq6G9Ar4FG8gf1pGCyghtDpRohOikUj28lq6PAr5HmlkRawu2yWv/SLVXZcK+GyEgkLXX0/F7/Kp101LGYL4zROVFgY1RxNH9Wc8V18vetHLiC4fEnzPtS7GetddTe0RQEnPHLFnz4PwynUhSw+7OCa+CsEHa5XUTpAXmwv338JDX9A5guLDbWfIkP580gBctCQxW7QxEpmBWSAChvPcLD+DNaYTX1Oc1HpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwwDc1Nw2C0lY9OFGf38Ug4Ibn52Oizp7BP5AQOGU/A=;
 b=jK9pVBQgjqBcGljgMTHUcFwLphGubipSaHqNiYSOu+DfBjwQJugBnZTuW9SnnIuGp4OBQIcgHdKHz4+6JhSxxHnJfaElz6nHtJykI2Csk9+iQYmmr2n5P2E1iZe+qOPDDKJqw8nR4pTp7dtOr8++lgzRYnkcVfABW6vQrZ2pYWkp5FrJkUlMDTcskmq+oo4flNpE3vMdU+etbbjaPYVpbhLFEtYsif891OajQ8oHk7xLRK+2h5V7+/yri7qbVgmKWbj+WwZwkJIdCgCTAwFwxJB3N9hF8TFb3jfEgSRcehijsjHCLT5JtYkfftbFC7QqWB30KhL8U4lgoIlhabK6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwwDc1Nw2C0lY9OFGf38Ug4Ibn52Oizp7BP5AQOGU/A=;
 b=h+juSnLvlUDjT09GFmxH7UQkSbgsheefVBmuS12IONkGQXi4fdnYj1YBBy2v4XCIs/DVdeYczH36aDAEjAaXdFtcJ6BeCconwdh6qNMr7qCOYAK2jsr6Q/sqRqOk1lFRuiShrZGZWIHIlAC93+dTYjg6xVVD1ARU4tjzQq7pJubYlyRfxtPK84EIOyz4TYRovMcV3SKbbE6tsqmlv9by0arqLQAP4ddWjM5c+ppQA6dX1tzysnTxpjYnTnR6Ka/EtVp8fbbKQpAwTPUZydd1hlmOAKMyTVv/nboNG1z+z+7k6cASoQwrBUSHZChQJr9EG8/CbVrRF9xcchks6GwkpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 22:32:54 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::411e:e463:2c22:e220]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::411e:e463:2c22:e220%7]) with mapi id 15.20.5791.021; Wed, 2 Nov 2022
 22:32:54 +0000
Message-ID: <c95a26a3-09da-4511-9bd8-21d4cf1be1fc@suse.com>
Date:   Thu, 3 Nov 2022 06:32:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 00/12] btrfs: raid56: use submit-and-wait method to
 handle raid56 worload
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1667300355.git.wqu@suse.com>
 <20221102145915.GG5824@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20221102145915.GG5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: c947d1a6-57b6-4af3-9291-08dabd222f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /P5hKbT+bMDtpwVnd9qL4FW4ksFk9CADuGyoKRbt8oJRG4lyivYlATG16Jq4Kqr0IwJofaopH4pwTDZvwBl9UsMNmaDv+mjeg/y7b86XXpMZ4/Wt16wVPCeYmLGtxvNDK2z0UFOK2d+kadxINaat5TTAviYiJyHUjsurrLp1tKznVznqJ5lhd+6+W/JxxrOdwnpgA5CTV9taO8F8VawmuYXwFRCo8gFPkRpvKy6Du/6SPyli6Rb6J7ALKs17zws65oOOj54AdhEIx6uEPNgJb/hdP1xzMVfvc8/EGY5xqqtBvcajzBsB27QbGC4SV74qMxpAQAs5udxjFv6qCoSwAbjsIoNA+Ll2ysYppKJYREoaHYOk5K9afq6TRzwao3b3yFGK8EMYtpERqqJX62/0bOhMYSooGm66oiQYStQHGe34CVFy7uZsEG3cVkmicxDRS6X8MbnlDaSriESiPsaYPkHgdXvYWPbYJgC0++ZkKqoD3FpQhd8Nrvj28qaotGlirkCn8ICCaDh8HGS66tXvkF0knxTmOHc7fJosMActLTF4wYQzH7/WnGi5BKKghpX1zVfPXacWzFQnDxorGI6T6XBuuxCwlRidn3yPY9X0lhu9+CwiwvRTeFtdpu4VKP2EjhPQtLKFKxibr4zG3WNdy24yBLshcYy+XEJyJCriy++zHsSgeby3bd0KO6vWIQvvNYHiC5wLDoh98lz9E0Gk+trhiF6SJnktqtJpRHuuUfW6gS/GOiF13ASTZkQ+2hRkRsTFFEEs2xgthMSjjGm86gVC9s5QIHVD3xw7I4Z745g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(31696002)(478600001)(86362001)(6486002)(8676002)(6666004)(2616005)(6506007)(4326008)(53546011)(66556008)(41300700001)(36756003)(8936002)(6512007)(66476007)(316002)(6916009)(66946007)(38100700002)(186003)(83380400001)(2906002)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhaOU1uVm15RjgvNkJOOVVyUGo5S2hJYmRObGRLWVBXdHFmbFQrSjBrRC85?=
 =?utf-8?B?M2VZQjVlZGNhYmRoK0FLTGMrRTJScTZuVVNrWHU4cmdvc3hGNFg2RHJaOXRk?=
 =?utf-8?B?cUI0K2hjcnZrc3Q4TVV6MC9mWWtuc1ZWRlJoUm1MSHM2QXNJMnFQc1doUzN4?=
 =?utf-8?B?ODFQL09OVzlBNUVOZWxpOCthN09Sb25ZK1JKUGFGZzNYcHFhTi9IT1EyM2Ro?=
 =?utf-8?B?cWptZTEwTktQZFZvSllFY0xTZjFkZVIwNkI1SFB2NWpSRHFUeGdSWjlDbTZZ?=
 =?utf-8?B?VkdmSGljc3dYSGY4NmdrbnhVMnhsZlhZVFlmOW1SZ0tJUVRtSzB1ZnlER1lW?=
 =?utf-8?B?bVNNeXFZU2dFM2E0M3I0bHhGQVczTzZ6K01CanRPZXAzQkJPVjFYZ0ZkaVAw?=
 =?utf-8?B?VmN1c2xzUlA5WEozZDdMSGM3VkN6YVU3NVh4UXl0aFQzZkhXcnlMa2J3bkF1?=
 =?utf-8?B?a0VvelFwKy9LZnFMQ25MU2gvK1hEK0hRUlRJMFE4d3Vuc0R1b0R0bWZhcXA3?=
 =?utf-8?B?S1UyMkpiM2xLQWI3QzFWNHRTU0lxOFhJaVoyajllZjF4RkpRZmFYck1PSFZN?=
 =?utf-8?B?dzgzNnFpWnp3WWVma1NqVnRwcFdBSWtjZ1lvREo3dS9pTllqS1gvaXRKRlF5?=
 =?utf-8?B?SDk4VFhXYzlLWXdLTjZWd1F2YkNESWEzQU9EdFJlaFBZMm1yRTliYktpQUZn?=
 =?utf-8?B?Sk16VUxEL010Tm4yakN3NjgxYjQ4ajU3L1ZuMUNDL1RXUkV3ZTdrdi9ydWtP?=
 =?utf-8?B?MmNNRjNobTE1Q09CYmw4ZzVMdzBhYUkzcGRjdmVJQzRPVmpRQ3lmS0ZMV1pG?=
 =?utf-8?B?K1MwNjNMMlcwTXRGR3oxb1h1NC96WTRhNEppWHRMTzhHWTB1cGZiaW9HODhY?=
 =?utf-8?B?MUxhTnREZm9hRGxORGhhT2psVU9DNG8rdmM4N3hDdFVYcG1mK2I4aDFuV1F4?=
 =?utf-8?B?MGVvRG5NUllvT1RZblBUOGtvdVAxeHkvdnNZL3lvM3R2azc1ekF3ZmZzZGNk?=
 =?utf-8?B?N1FCYUFpb2FNQUNrMHdhNGsrTWUzd2Q5RUVNUXFmalN6Z3d5MHV3emN6M2xP?=
 =?utf-8?B?RnZ6V2xCZmZwRVZuUzNUUGFadFEwTDF3TzZsVGJPYURuR3VMMWNyYWM2MTV6?=
 =?utf-8?B?aFBtbXgxanBRVkdJR3BnZzZtMlBZV3Z2RGRMaXZLQ0MxdU5sUVFKYWMvSElh?=
 =?utf-8?B?L216VEtsTTV0QUpVelRlVGVxL2xTNnlFNVNCenRsdXBJei83T0dPYTJWenUr?=
 =?utf-8?B?TndXOWRQWU95M3pWeWRGMzh2MTA4anQ4MytvZGNtYS9QNnVwZU8vUXRsK3Fv?=
 =?utf-8?B?c3NGam5hamRrN0FrYkcvM0tQZWYvZGVwUWV5Ny9UUjJxRVRQYWt4bnE4ZGlj?=
 =?utf-8?B?T0xCbmFlOWd2RUtXRS9EUW1EaEdnaVV0MEM5UWxldk5DUlV2djhZeS9OVStk?=
 =?utf-8?B?SzdsOUZVVGVYY2lmWTVqQXZvN0h3TmY0bGU5bGNTTGZHc0xPcTZpTVY2TWxl?=
 =?utf-8?B?WG5hWU1HdmpNQyttM1VqMEw1VmtaUWM2d01mYmkzWnVqWCtyNHBNb1UxU3dR?=
 =?utf-8?B?NkZobG5xcEY5M2RiNkU4V3AycE9adlY4MmpIN2pwWWljT29xSGNzTlg4cTdh?=
 =?utf-8?B?YUlvemViemdCcDVoOUc5OGZSbUhXWEpKWFhFYzNhVUdmMStLMWZTQUlxMGwz?=
 =?utf-8?B?dWFaeEt4NWFmZjFUckFVbXFmTXltNHJOa1JzQ3YrOFBjcGJ4MEdrN3psQlVL?=
 =?utf-8?B?ZWFuajJKajlsSnBXajJzdmIvVkY3RUJtdGswUUNtY2M1RjZrV0xVeFQrWjdY?=
 =?utf-8?B?c2kwL0Y0dXR1cU9Ic0JoeGpSVGVzajNCR1NpY09mWHJlQkVIWUlkMmxrbTJs?=
 =?utf-8?B?dlJLTFBEbWlOdFBXRm41bjRub3ZLQVZyWGhXNUIvRUVwaUJveEFBekpTSnMy?=
 =?utf-8?B?WG90bC9NaWM4c1Y2cHBoMmd1NUpXeGlidjkycDlqMC9kdXZiTmZOSWpXK0kw?=
 =?utf-8?B?RzIxeERzekRQU2hvZTh6UVg2WVVtOTJXcisxc2tjZ0hZYlE2N3NNc2tBM0JU?=
 =?utf-8?B?MDMxRmhpUVZTOERCTzZNQkp2VzFpajVpaCtad3JSdHp5TUo5TW8xZnUzMVk2?=
 =?utf-8?B?cVBCU01PbWJXaVlYS2hCUWFRbVlkSmNqWVZEZFA2QUVOOW5uMnhVQnkwampQ?=
 =?utf-8?Q?s6OYODEieLq01v8X4NYKagY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c947d1a6-57b6-4af3-9291-08dabd222f0e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 22:32:54.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdTnhJETw1+fsbbNGVIEH+HLu987E53Sf8jB/CKdGmN5n+5pa/RChqh2D/gubxIs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/2 22:59, David Sterba wrote:
> On Tue, Nov 01, 2022 at 07:16:00PM +0800, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Add coverage for raid56 recover and scrub paths
>>    In fact, with full coverage we can do better cleanups, which gets
>>    reflected to the changed lines.
>>
>> - Better naming schemes
>>    We now have 3 main entrances:
>>    * recover_rbio()
>>    * rmw_rbio()
>>    * scrub_rbio()
>>
>>    And their work related functions will be called:
>>    * {recover|rmw|scrub}_rbio_work()
>>    * {recover|rmw|scrub}_rbio_work_locked()
>>
>>    The later is for unlock_stripe() to call, where we hold the full
>>    stripe lock.
>>
>> - More extracted helpers
>>    Now we have the following helpers:
>>    * {recover|rmw|scrub}_assemble_{read|write}_bios()
>>    * submit_read_bios()
>>    * submit_write_bios()
>>
>> Currently btrfs raid56 has very chaotic jumps using endio functions:
>>
>> E.g. for raid_parity_write(), if we go sub-stripe, the function jumps
>> would be:
>>
>>    raid_parity_write()
>>     |
>>     v
>>    __raid56_parity_write()
>>     |
>>     v
>>    partial_stripe_write()
>>     |
>>     v
>>    start_async_work(rmw_work) <<< Delayed work
>>     |
>>     v
>>    raid56_rmw_stripe()
>>     |
>>     v
>>    raid56_rmw_end_io_work() <<< End io jump
>>     |
>>     v
>>    validate_rbio_for_rmw()
>>     |
>>     v
>>    finish_rmw()
>>     |
>>     v
>>    raid_write_end_io() <<< End io jump
>>     |
>>     v
>>    rbio_orig_end_io()
>>
>> During a simple sub-stripe write, we have to go through over 10
>> functions, two end_io jump, at least one delayed work.
>>
>> With this patchset, we only go like this:
>>
>>    raid_parity_write()
>>     |
>>     v
>>    rmw_rbio_work() <<< Delayed work
>>     |
>>     v
>>    rbio_work()
>>     |
>>     v
>>    rbio_orig_end_io()
>>
>> And inside rbio_work(), there is no more end io jumps or extra delayed
>> work.
>> Everything except IO is single threaded, and the IO is just
>> submit-and-wait.
>>
>> This patchset will rework the raid56 write path (recover and scrub path
>> is not touched yet) by:
>>
>> - Introduce a single entrance for recover/rmw/scrub.
>>    The main function will be called {recover|rmw|scrub}_rbio(),
>>    executed in rmw_worker workqueue.
>>
>> - Unified handling for all writes (full/sub-stripe, cached/non-cached,
>>    degraded or not), recover (dedicated, and in writes/scrub path) and
>>    scrub.
>>
>> - No special handling for cases we can skip some workload
>>    E.g. for sub-stripe write, if we have a cached rbio, we can skip the
>>    read.
>>
>>    Now we just assemble the read bio list, submit all bios (none in
>>    this case) and wait for the IO to finish.
>>
>>    Since we submitted zero bios, the rbio::stripes_pending is 0, the
>>    wait immediately returned, needing no extra handling.
>>
>> - No more need for end_io_work or raid56_endio_workers
>>    Since we don't rely on endio functions to jump to the next step.
>>
>> By this, we have unified entrance for all raid56 writes, and no extra
>> jumping/workqueue mess to interrupt the workflow.
>>
>> This would make later destructive RMW fix much easier to add, as the
>> timing of each step in RMW cycle should be very easy to grasp.
>>
>> Thus I hope this series can be merged before the previous RFC series of
>> destructive RMW fix.
>>
>> Qu Wenruo (12):
>>    btrfs: raid56: extract the vertical stripe recovery code into
>>      recover_vertical()
>>    btrfs: raid56: extract the pq generation code into a helper
>>    btrfs: raid56: extract the recovery bio list build code into a helper
>>    btrfs: raid56: extract sector recovery code into a helper
>>    btrfs: raid56: switch recovery path to a single function
>>    btrfs: raid56: extract the rmw bio list build code into a helper
>>    btrfs: raid56: extract rwm write bios assembly into a helper
>>    btrfs: raid56: introduce the a main entrance for rmw path
>>    btrfs: raid56: switch write path to rmw_rbio()
>>    btrfs: raid56: extract scrub read bio list assembly code into a helper
>>    btrfs: raid56: switch scrub path to use a single function
>>    btrfs: remove the unused btrfs_fs_info::endio_raid56_workers and
>>      btrfs_raid_bio::end_io_work
> 
> Thanks for untangling it. You may want to add some recognizable prefix
> like raid56_ to functions that could block for io,

One thing I am never going to stably handle is the naming...

To me, since it's inside raid56.c, a prefix like "raid56_" looks a 
little redundant, unless it's exported.

But sure, with much less functions it's much easier to add/remove 
prefixes in one go.

> simple helpers do not
> need it and they'll be probably inlined anyway.
> 
> Added to misc-next. Please proceed with the RMW fix series.

That's awesome.

Although I'm afraid I would just come up with extra refactors...

The latest thing that has some impact on RMW fix is the faila/b used in 
the current code.

a) if just one sector failed to be read by somehow, we mark the whole 
stripe failed.

b) since RMW now will handle data csum verification, we have extra 
source of failed sectors.

I'll check if I can migrate the faila/b to an error bitmap, and then 
re-base my RMW fixes.

Thanks,
Qu
