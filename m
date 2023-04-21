Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A301D6EA56E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 09:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjDUH55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjDUH53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 03:57:29 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4C39760
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 00:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YssM1onypc4Ubuz8zajUlw8XGkD5RXYx2rf6wrt93Wdi0YB0YPvlyt1vNprYgiHM+GI+9NbVY2h5mFEzZsZJejFrpGWxp1VBImBokGvHcHVLwFHpxaj1V31rz6yPaTEPPiQ1HeALzbgYW5KYZJNQ6N+RjGmXaeDLSNPsv54cqS4UclwgSwYyMaQbWHX4rMwK0JutkoWwcoZPL4c+4KW0BXvfh3YUAYs+NXisy8rAdBTkKdlKcOcVgHFj+CGtHtxkWlLyYdO30ZjNCvi4P8sO6T1QWJHylvZbeT/dmYuroQmOqBBtatmUamrZQ2TYtBWoDyB0zQyTjvLSBI0tb2XSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOmm/qgES9L0BCcTIlzkBlh2w6mHmM8vblZRCHfsNOo=;
 b=gjk+0Gue+PfU+6vwJYHaYJNYcWrbEEVGQr/C8TGHQQ8NV7OHB6PiM5u0QVmjPiIGOLsX7sJUhgegVndVJVfQgBB5uEmQcvEuUpgSh5mqoKv5Ely8p2VNsqr9aVEcOMD4eu8enIgHs5ae34LE0p3mFOj5WYJlGQ4jJz8b8QW/EfqGNzRSunvvG172WJr2rccIiDPg8ixOnsf+79ibDs3kde0qwmJXxozMJQ49lquwbe6jEQO+iM37PGrhcik2WPZL/GGdo944BsRFCyllGHNBJpQZEK/yTGAgNmAuzBqArU/ceCe7vK2z4l0UziMkVPamXZcX++HLIk/pdaTdizMUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOmm/qgES9L0BCcTIlzkBlh2w6mHmM8vblZRCHfsNOo=;
 b=CADjxD7R4ctb1was+UC/41rc0Nhj/dK92cnkiW7rB2U+q6q2ncYuA4QNjypJUyHBDJcG7O4UTsX1v8MvOhlehoyRybs5mtJRMRQiBhUeicTXt3jS+l568v6p5cfE7u1GBodP1J5T5LKp0E3YdZtM5l9RE7k2rWeAfu7tvN/4M07vq3Vpqi4W2G5vAtCygAqQTnVmW/tM+85K+oZCbxk0GZ6hEKFZGRTk3SenjPe3nymSRTRoiLm7/fng+5BUhsxa2bftBbOO114CH1DNe0SNayAWM3YWmaasOGBEGcMNG2PAxXWKCJbBsyzk1g89d5+cp+lnMh5ZafZZVjnUBTpa5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by GV1PR04MB9198.eurprd04.prod.outlook.com (2603:10a6:150:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 07:57:25 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 07:57:24 +0000
Message-ID: <6f795670-eae6-6aef-3fd0-dad81bb89700@suse.com>
Date:   Fri, 21 Apr 2023 15:57:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     dsterba@suse.cz, Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <b7c067eb-e828-35f7-4b26-499173fd07d9@georgianit.com>
 <20230420224242.GZ19619@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
In-Reply-To: <20230420224242.GZ19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|GV1PR04MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: b796f181-dc9f-49ab-c071-08db423e0b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTkgbUaeQM8mf+F9SRo237NU1f6SBQBduzidk2QEq5OpN3JtBMuTahmbJDpe2gKrO85VLwo8O0VzsBoI63WZbvC6jL1TVmOYqJbWfZDIIffZs2y34cDTpJtLlAWsOs79hI7iPs3kRrDGHrsk8gReA05iTjvMz2PvuVVjjJZARnh2OHaI9ZQGd1wcYWKQ89bKldv8CAGQ8ARPtgjXvCtIctaVnPSGOj5AZqDQABJBGltrRiCDgEHwO7pqL6VcgVN1I+sdDcIPxq0jIpa+psbr2sGntl8hN7B1DS6qGxCDyV6PxeMlSpA6o0YWkHJZVYiTh2s0aL2+5xrLGbLQW2lXeSt19rQD4KMse/RkMiP3vXuFg/oNu88D+xPW/AssNbfWQkdE0A/7cRadM0PcP1drDeem7ukTMWClqdPBjW0HMWYULNZAhThIoQ0PI0RHkdwG8EtQGj+uxcFAfYiJj5OHN2P6gGR5/2WH6+HFoYqEuNdfC7387KtjUcNwpGbGTHk858qgSnqLCwmpkYc3e6VkRC7wCph5wrMzJtsDIZUPBTzUSiuMes5E7TNniLdSp0rxcxvzNCHV2uZbLVvuHGtcDJYedthh/Mawn12Ltr6HEN9TK9xHpiKH/3BjIKx6YCKraF81KH/zcaobKajhsbbO1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(6486002)(316002)(478600001)(6506007)(186003)(53546011)(6512007)(8676002)(2906002)(5660300002)(66946007)(66476007)(6916009)(2616005)(41300700001)(66556008)(8936002)(4326008)(86362001)(36756003)(31696002)(38100700002)(83380400001)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9xVmgvOW9xNkQ1bEJZV3dObU5IRVcwZkJPV01nRGJ2aXZYR1l6UjU3TXZQ?=
 =?utf-8?B?L3g4dW5tcWFqMUM4aFE5SkVrZW5NT3k1djFEcXJvMEJCMXFFem54bWFYMHVj?=
 =?utf-8?B?TzFCVFAzb1lnNkozLzJDeGZZL3R5S3lFZ2cyWjdMb0kxR1dvOXd1WTFvM2F5?=
 =?utf-8?B?NlhRUXRzVnB1bm5mbVlMeDdnZWRqUFNQaDlTZlYraXVnblZFODlKcnRIZEx5?=
 =?utf-8?B?dXNLOU05dUtyQ21oclFPR3RUNWI3RmM3ZmovRVQxRWptbCtjemxMNVJ5VlNJ?=
 =?utf-8?B?SjVSZE9PNXRudEFkMUZCZ290bzhxSnRRQnlLckF3clFGNEJkdVZINnRiUmg3?=
 =?utf-8?B?Z0FEL29ueCtUYjZ2elVOY3J0V2RDQXcvMTBGeUFuTUUrZnV2T0YrQk5iODQw?=
 =?utf-8?B?SFNtUkw1ZnpIWGZrR2NiY2xpaEMvUGlvOHV2RUM1RlUxUEJhYmFOcG1JRWpF?=
 =?utf-8?B?SDdSTXh6ZU1SdlV1bDYxa1RiZ0RxRUcwWThrOUVCWFJFbjNmdnA3aCt4a0lU?=
 =?utf-8?B?YmFmaGx4UFdRR1d3RExpa3VxS0UzN3VHeHEzRzZQZDEwMm4rdTlPTmRqRG1l?=
 =?utf-8?B?OHRQaHI3U3d0V25GUTNrV1NzOGNpT3dnaTNjK3NYTGRsQVZNNHFGYXhsT1Mr?=
 =?utf-8?B?dXVxblduRFBJaGFZRDlnK0FoQTN0RGhvbS9CenA2VEM4R1BFR2J3Z3YzNW1W?=
 =?utf-8?B?YnVYMEpmRHhUYk5jVHI3NkgrRDcwdkZUTzl1SVBPQ3orYVNrYkE5blFQbEcx?=
 =?utf-8?B?emxmRU5DZERCYmhKNUtYdTg3UVEyZytUam1UTExJZ0tsb2JEYUdLbEduZVdm?=
 =?utf-8?B?cE5oQnFqS0I5SE1HRllOUzlwUVhNdXRZYlVJNjB0SHhWaGl6VDUyOFUrYW5R?=
 =?utf-8?B?OGplOHlnSDJXUi9Ta0k0Qk9vR1ExSjh4K2Q0c3VTZkRNTFJLejhSWWE5cTIz?=
 =?utf-8?B?bUVSeE5mVERON3Vna0pUdzJTeDhCZzVEaXJCeXR6SktETTBmdkI1SUVsR0pw?=
 =?utf-8?B?QUg3ZnJYSFRMUitMNGluRGxITW1hQmh2bHFtVWV1TFhZR1RmcCtyZHlDWkNY?=
 =?utf-8?B?SzNMdzgzUFpVS0IyQ1l6OWtxLzBFbiswRDA2dDhoM0lBaUFjZXhRQjQ2U3Ry?=
 =?utf-8?B?MndTTDVTZGZSQXFGeDZjdWpUbmNKTmEvWHVmR0o4Y1ZtT1A4alpmZXRtRFZC?=
 =?utf-8?B?d2FrcXRaYmdYc2g5ZHRKOVlVR3BnQTRXTUlzbUxpVTNvYnFZMTZHcmhzUGFn?=
 =?utf-8?B?bnBlOGsvMlJYQnk2SXhkcUFJZVVlRjRPWnJsbzVIMit3MHZnL25QOUZNV0x2?=
 =?utf-8?B?SWtJTE9wT0JpSzhaWVdWS1VVdEdQZk5YUjdBam1jYjdyS3JXaHN6bGVtem1i?=
 =?utf-8?B?RFJvTmsveWRLN1l1U1RMd3ZsMkhnT0Z6K0o5MEZhRjBCQTFaS1NIWTZMWlAr?=
 =?utf-8?B?TUp0a0ZHMVFjeTFQL2MzdUgxbDVWRWswUWs3a24yM0ZVSUI1RzBnQ252OWpm?=
 =?utf-8?B?OWwraHBZQktZSnVkNzJLMEYwODI4WTF2MEd5UjIxd3NDTVVmSkY3czhJbmNy?=
 =?utf-8?B?Q0ZUYUJqZnBQZVlFRTdnSU9oTkJQK1k4U3BudzRJMjc5R05XeHE3ZXQrVXFT?=
 =?utf-8?B?dGxJSHRvU28zWVkzTFk4d3pLRjZOMGtNUHkwWjJ1K1R0TS90RlNxbE05cmtW?=
 =?utf-8?B?cUVyRnlxNjBxWFZhNWo3QjN4dHpOVDcvV3RCRkQxbjhBV2h1SExqelBkRFRi?=
 =?utf-8?B?SHdOcGdxR0pPUlFKMHdHZDJiOEpUWnNxNllkVmJOSGVJRWJ5aEkyS0hTVzIy?=
 =?utf-8?B?c1M4MTlCRHZmNC9wa3o4bWNuMWFWTmMwL3VsUC9JRFpPUmJKSXlqN2pRN2gx?=
 =?utf-8?B?NU5RNS9nTlgzZFNRWDdHZVlKSm9Ccm12d2d1eUx4V0lOMHIydnRtc2dsNmR5?=
 =?utf-8?B?eWtvSUhkK0pWcVdsSC9Ib05vcDJTclVGVWNsSG5JRGo0aWFNOHJiQWRBU25x?=
 =?utf-8?B?cDZkRVIvMGhaZUdoSFRzRFRwaWRiMkZjTlNyV2xUZTZSQ3JGb2d1V0FRY2VX?=
 =?utf-8?B?S2pnV2xvOXpHM2VMUlNFdWdpdVVjMVYvWlhnVExnQU9jU0dIUXBlS0pBc0hB?=
 =?utf-8?B?RktYMk03VUcvRUt1dTZ6U1ZqY3ZkS3lMR0Ftc0NNNkJ2bHJZREZUK1Q5T29p?=
 =?utf-8?Q?KvYR+b3jNzZAk0CHfTMc6X4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b796f181-dc9f-49ab-c071-08db423e0b1d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 07:57:24.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSmfSKgcwSpAmhKzxI5OXzMLtbDc6MyOWdwThj5+44XXe5ber8xOrOtdBUQlkpQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9198
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/21 06:42, David Sterba wrote:
> On Thu, Apr 20, 2023 at 08:37:07AM -0400, Remi Gauvin wrote:
>> I have recently experienced that btrfs defragment (by itself, without
>> -r) of a subvolume can dramatically improve performance when accessing
>> very large directories.  I would go so far as to call it critical
>> maintenance when working with gtk3 based file managers.
>>
>> What I am not clear on, however, does adding the -r *also* defragment
>> the subvolume extent tree, or do the two commands needs to be run
>> separately to get the full effect?
> 
> No, -r does not defragment the extent tree, so if you really want to
> defragment the extent tree, then you need to run it separately and
> without -r.

I did a quick glance, btrfs_defrag_root() only defrags the target 
subvolume, thus there is no way to defrag internal trees.

> 
> Originally there was only the extent tree defragmentation which was
> confusing when defrag got a directory as an argument, then it always
> defragmented the extent tree but did not descend recursively. Then the
> -r was added and the bare directory path discouraged. It still works
> though.

My another concern is, does metadata "defrag" make any sense?

Btree itself is never designed for sequential read anyway, and even we 
can pack all metadata into a sequential bytenr, what's the proper order? 
Breadth-first? Depth-first?

Thanks,
Qu

> 
> I've checked if this is documented, it seems to (btrfs-filesystem,
> section defrag):
> 
> "NOTE: Directory  arguments  without -r do not defragment files
> recursively but will defragment certain internal trees (extent tree and
> the subvolume tree). This has been confusing and could be re- moved in
> the future."
> 
> but if you think it's not clear enough please suggest in what way it
> could be extended or what's missing.
