Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C980258D155
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 02:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbiHIAXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 20:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244535AbiHIAXI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 20:23:08 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20058.outbound.protection.outlook.com [40.107.2.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D9BDEBD
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 17:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7xt9iL/CcFmeegdjIyG5qwhIe5kDm2ggjueS+vfb2TDcA/c3x+ZhpktTYOFtHhl7Ri/P8pZZDUsOEsf63JFfI0Qx8XrZ3Pst2PNTOUi64qhv7IKfOt7LUVI3WgaltJb7qHfihewjkjbHnAez84sn1O5gwJYraUQw23vqU+EYNKk6i07uprkeS3UEtvOHpS6k67pUzLEanoSKd58tUtZrMA9HJBo50KTi921TR8tpApzMgmhYZor9FmIV4paEwMQeKNLm7NE5ALDrq+zP3oJZ85f0FNpbDgBHwQx/G+RzoOlzLFQWItWwUnhfm+nIResUmMX57DuQqhOOz/tWHnCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P692dgW9xL97LVWUNfzn0Zqqpf7CYGJtJWhL1nmCFk8=;
 b=maSx/jUWpIrRVTNFBbToVa2UQlHDJRITHwxOF4N+rH0AaNQ7px879274tdpyM8OMyQIWt1G5kJxgCPPxY29aS1MU95i/G9nGMdcCcX4OWMiaND9VD5lTj4urEItVHUEAJ21WCuhInFFpzruoO88crldqfz8V5P33bXLhhriLVTlOOg6L3H7p6n4HHIPyZcKNviSCRdZVe2ZNc5R6dK/BeinHvmhMUAhZpthuHYH35bxdnCNkkk5OG432GaK4KXYf10cAzliqNwf8YlkrdrdxKz4qjYOsAvnY6T45A6p7vag7QgIVhtweBT4OnMYOFyoWLnO0ecIbGy5T6fzgAqMgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P692dgW9xL97LVWUNfzn0Zqqpf7CYGJtJWhL1nmCFk8=;
 b=uIuS8HOH3r5Y4AcLYqHvYjY1+YEJd9tovtaF6ayFF240wug4wxnaQcLe51Yfjdpa2E07guklVSLgW4+es0Z2fpbQbpITXN7EI7v7k9WjHo6y+BMQ4CmP4c5MhrZ1mGC8RSVTrU/DdZ+2ZZkHR3TE0YCL6A+qTbwLi7IK/SF1bSlFBguxu816kLfYiJpwIOrQznYiRL+pzhHKLWp6ab32Xt35Flr4IRY2fcouPA5sm+2TafkKXvmH0Othgru6VlN5pfq+/VejYJYeJa0dUcRGVJWjyL0nvTWZZ7PM4tswhSXmEPpbICxT8yr+On6nhuhaewV7bgGKVBmQ8d9rgDF+MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB7PR04MB4940.eurprd04.prod.outlook.com (2603:10a6:10:22::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 00:23:03 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c4b3:5f3a:8bf5:f6e9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c4b3:5f3a:8bf5:f6e9%9]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 00:23:03 +0000
Message-ID: <162fc903-e122-3365-671d-84c8d9897b92@suse.com>
Date:   Tue, 9 Aug 2022 08:22:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Corrupted btrfs (LUKS), seeking advice
Content-Language: en-US
To:     Michael Zacherl <ubu@bluemole.com>, linux-btrfs@vger.kernel.org
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86b2557-3e48-408e-05d0-08da799d5285
X-MS-TrafficTypeDiagnostic: DB7PR04MB4940:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gys79dkLvu3WwM1bibl3Tpgf5yrPS0pZ8sFMYjEVB5iuoWnR+nTL7awMndf5L1wjtJ47mRR5f+FpOvjyI869gUAQvO3SBvNFL0HW6fq4GzQTqTqTInuKT64PxQKPLJ/ehZB2G9feFc/3iPfrKmUCphdMNICg6FG2V7VI2iMG7qv+0202y2VIUmb0WysQRW84OZ7bhbREq0V1nkHOVMjX9Kt03sbx7QQ8E1sZyb0NjfNcQzcKKHzIWLmTEf9616KApvM91LTzWFecZ1kLbmXb31HjWhMxy4OFOztEPDBLA7PeItIYRraAeAuaqcxEym6xX8wxS/LXQES/7n9bSFHUt0N725G2yfoEIPlOeq/QfNyksEMhbfrDkJSrxYGHB7StQC/8cLVjnfXlGbsc/pPJM7ZvKQvySyQmpQcxtv52legowJ/T53R/YQ1NYuooLiiEPz939UWgBk5QF4SYj1TOzB7RwskQsuN66OeVmPbkK2BKrgS//VjQWUxpUjXcm/hjeCC+tYo1sgbaUphMXOkJ50QkJRXYJPKJ5KWHcadVuz1WAI4W1n5F40iUD6AyiCSSEmeXVObl9DAHbUaYuZxs2idrv5T+pviF8YLujcbfavAPWJmZHkoTX5+zETybTTqgUghU/2L8VBaLyIU6ScQ4ixA+t/KxRVjnRan+SU5EqojrpsDgleZ3MaT6Rb6tgxzluozg/5II2vNn4B9S268lzEBUlnuqPwClprFTGUMAoUFOJkWHULvd1UpVQDhIMbzGBOciGbZP/gMfZzpFnd8HTwwvf8/bNMK4rU/6CTldFZxjUvyDn1UdF65+Flx10ZY1GP8yTXDU9y+0do4BOItYAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(346002)(396003)(5660300002)(2906002)(36756003)(6486002)(316002)(478600001)(66946007)(31686004)(8936002)(38100700002)(86362001)(2616005)(6512007)(31696002)(41300700001)(6666004)(53546011)(6506007)(66556008)(8676002)(66476007)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUlOazNueXovenJncEh5TXM3ekhidjYydzBaNUozNXhGN2wrWXNCdWpNVTB1?=
 =?utf-8?B?UzJaOHBPRU9SMzBvTVcwUEVWcGtESFlSVDZ2ZVZaTUY3ZkgwRTVYZGRaSG5D?=
 =?utf-8?B?V1N6NEdacDJpRnJianluVVluanlpWlVhOUZzSTNnZ0dHVzVqOHg0WFQvVlhr?=
 =?utf-8?B?MlFBOUw0cEVJaEppMkpxMSsxZ2R4UUNZbkI2ODVWUVFxc243ZmlrWlg3NE1v?=
 =?utf-8?B?T2tYZUFRRjkzR1FMY2VJU1IxTlU4eTFzK0d2aWljR3RmSWhWVEwrNEhBTDBl?=
 =?utf-8?B?dzRLN2VTMnQ2MVhpQ1Awb2ozbXBGMCs0K0RpRVo2Qko2alh6U1pJNFczOTAx?=
 =?utf-8?B?V0VGR1gvaS9GWEdLVFlqVTR4YzVKSFJmK0FrYTBBSEN3UGpKdEZaTmlULzc2?=
 =?utf-8?B?VGNSMUY3dFNXN1dBajJmMUNjU0pQbkpHMlF2QWdJQUlkUkNXSVBrMlpMU0Qx?=
 =?utf-8?B?dDI2MFpQWHhkMHJkYmMvdkZ1cUl1cTRPYTdLQXR1WFNSZmhESmVnNlFTVjRa?=
 =?utf-8?B?OXRQNWdadjZxdzZWaXAweHVYdWhTMDFvZHRGeDQ2aldOYmZiRUUwVEJyT20x?=
 =?utf-8?B?akU3NFlRRks1cnBCZC9yNTQ4akJVdUtNeCtXMHhYbC9QSkx1Z2tuak9yRVFr?=
 =?utf-8?B?L1ZEaW9YRUlCNzMwZUhLdXRRczlXVlJRVkNwcnlzS0pUVE0xYTlCeU9RQVVU?=
 =?utf-8?B?bjczNkhJYUZGSDJ5aFRTeVVzaGZDL1ZBRWRsemxZSnM0ZXRmdW83dzdxMVla?=
 =?utf-8?B?N08xMm1FY3RldjRwL0dRbDFrWTFOUXZ1cGJ6azRWUnk3RC9pWXpSb1lSbDZU?=
 =?utf-8?B?LzI5d09CY1luQkM3ZzJ2cjlONmVSclNmejVvbG4rb2pLRlcyUm5uRlZmcnBC?=
 =?utf-8?B?WEFKRzVrUytXMGFSYmtRSFdzNmx3N0xENnM4MzRsR29zaDJhcDhYWnE5Y0NT?=
 =?utf-8?B?dDkraUtuLzhsdm5XT0V5SGRvOWZoNEYxak5VWDFDekIwUlhkYWFxVk9aYWNO?=
 =?utf-8?B?b3dObDI4aUpTMU1YbVFhWmdSa3BYekhNenJOVlFqMEp1S2ovbXNkZnQva0ZF?=
 =?utf-8?B?V0MxSmRaZjhsc0VtakVvdU4vZHlGS3c0Y1F1R2JPeWd3L2xVRDZKVTZjdlRr?=
 =?utf-8?B?ZXFXMUxBSUdhalJZL1BkY1dodDlIbDdlZVc5VXRhZXpnN2ZXUEwrdnl6ZFlj?=
 =?utf-8?B?S20waDhyZXBwTG85dG5ZZ3Nsd2xlVFZqQ0dXM0lna2NGTHVLbVVMZGR6L3Jx?=
 =?utf-8?B?S2w0YTRvYXQrdGtiS2dOeHZOdkxkMmJxSDVpd1dqb3R5WkdldUtmdzg2SFkr?=
 =?utf-8?B?MnNGa0UrRk05cjM5TnhYQkc1MDdBRFRRVjZxbEtNVDFQWXFXQ25XZVhUSlhM?=
 =?utf-8?B?clowZ0xQcmloTWRBRXZLUnlHRUNmdEM4aWlZTld5TFBqa2lNS3VQbEpkaHox?=
 =?utf-8?B?c3BmNzZkRTgxa0RUS0FqazM4b0IzVmhaYUY5amNULzdVUlFvdUZ6QkIrbitz?=
 =?utf-8?B?WkNlR0JYK2ZMMXpETnozWWdKSWZIeS9CSURxN0c3c0NRQzcyNWsxMWRSa1N1?=
 =?utf-8?B?UC85UGxnSUpobitZSzZiMkdld2YwWDZDZ05HNW9KOFN4WjZhUE9oMXZVV1Fj?=
 =?utf-8?B?Y1NOYXZsL3diWHllYkQ1U3lFVmlJVVMwWXBTanlyYlFwUmIwR09IeHdjVFlU?=
 =?utf-8?B?aDEyZnMwNDUzNi9wRHl3VnhXZmlVTWFNcWhzRHhUL1Z2TjR0cG9sYkk1Z0xI?=
 =?utf-8?B?NXRGaEpZZG1uVmk2aStEemk0OG8rQ0VFWDZCcmJYQ29ENSsrZlNIWmhwZTBU?=
 =?utf-8?B?UXdVWFBGTXZLdEx6Mzc0cG1sbVN1SCtiNVYya1JacDcrUVRnVmFnNUJRdjBs?=
 =?utf-8?B?bExUQXFRcFFiOWwwWnNDRFgyc2VUQjJ5OFR5bHdvTWk5RGJmeE9HWElINjZm?=
 =?utf-8?B?WHBPOGh0S2ZyeUtCZ3NnK0FFdnlKNHl2STg3TnVDcWsrTE1jd0JFcFphdFRY?=
 =?utf-8?B?QzZEcHlCYWwzUHBObUw3MmdDV2xkK2llUUluOWtHWXZxQTdlTTBlSHB0bjQx?=
 =?utf-8?B?ejJCbGR6WWloYXk2VGlBQmI5V0FxQU5yNG1QNWFONkNLSi9lQWRYUVFlQTMr?=
 =?utf-8?B?MHhqZnQzbHF2RkR4SnF5UDIzZVdOQzFHRVp6RGxSTC9GL080Z0lielM1d2Nv?=
 =?utf-8?Q?0gFL6Zf56E2Vr6sHvoD7htw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86b2557-3e48-408e-05d0-08da799d5285
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 00:23:03.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUGp+a2PyafM64MIVipEFgTCwce4KnwRRz98X7AsJYankldOANlNpP/C+VhjVZcS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4940
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/8 21:06, Michael Zacherl wrote:
> Hello,
> on the occasion of retrofitting a 2TB ssd for my old XPS13 9350 I 
> decided to give btrfs w/ encryption a try (this was in June).
> Now, by a dumb mistake, I have a corrupted btrfs (LUKS encrypted).
> Since I can't boot from this partition anymore I'm using the distro's 
> live system.
> This partition can't be mounted.
> 
> # uname -a
> Linux EndeavourOS 5.18.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 16 Jun 2022 
> 20:40:45 +0000 x86_64 GNU/Linux
> 
> # btrfs --version
> btrfs-progs v5.18.1
> 
> What I did so far:
> 
> # cryptsetup open /dev/nvme0n1p2 luks-test
> Enter passphrase for /dev/nvme0n1p2:
> [worked]
> # mount -o ro,rescue=usebackuproot  /dev/mapper/luks-test /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on 
> /dev/mapper/luks-test, missing codepage or helper program, or other error.
>         dmesg(1) may have more information after failed mount system call.
> 
>       dmesg after this mount attempt:
> [ 5179.422225] BTRFS info (device dm-1): flagging fs with big metadata 
> feature
> [ 5179.422248] BTRFS info (device dm-1): trying to use backup root at 
> mount time
> [ 5179.422255] BTRFS info (device dm-1): using free space tree
> [ 5179.422260] BTRFS info (device dm-1): has skinny extents
> [ 5179.431117] BTRFS error (device dm-1): parent transid verify failed 
> on 334692352 wanted 14761 found 14765
> [ 5179.431338] BTRFS error (device dm-1): parent transid verify failed 
> on 334692352 wanted 14761 found 14765
> [ 5179.431358] BTRFS error (device dm-1): failed to read block groups: -5
> [ 5179.433358] BTRFS error (device dm-1): open_ctree failed
> 
> # btrfs check /dev/mapper/luks-test 2>&1|less -I
> parent transid verify failed on 334692352 wanted 14761 found 14765
> parent transid verify failed on 334692352 wanted 14761 found 14765
> parent transid verify failed on 334692352 wanted 14761 found 14765
> Ignoring transid failure
> [1/7] checking root items
> parent transid verify failed on 334643200 wanted 14761 found 14765
> parent transid verify failed on 334643200 wanted 14761 found 14765
> parent transid verify failed on 334643200 wanted 14761 found 14765
> Ignoring transid failure
> parent transid verify failed on 334659584 wanted 14761 found 14765
> parent transid verify failed on 334659584 wanted 14761 found 14765
> parent transid verify failed on 334659584 wanted 14761 found 14765
> Ignoring transid failure
> parent transid verify failed on 334430208 wanted 6728 found 14763
> parent transid verify failed on 334430208 wanted 6728 found 14763
> parent transid verify failed on 334430208 wanted 6728 found 14763
> Ignoring transid failure
> parent transid verify failed on 334675968 wanted 14761 found 14765
> parent transid verify failed on 334675968 wanted 14761 found 14765
> parent transid verify failed on 334675968 wanted 14761 found 14765
> Ignoring transid failure
> parent transid verify failed on 335216640 wanted 6728 found 14765
> parent transid verify failed on 335216640 wanted 6728 found 14765
> parent transid verify failed on 335216640 wanted 6728 found 14765
> Ignoring transid failure
> parent transid verify failed on 320847872 wanted 14323 found 14763
> parent transid verify failed on 320847872 wanted 14323 found 14763
> parent transid verify failed on 320847872 wanted 14323 found 14763
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=119848960 item=49 parent 
> level=1 child bytenr=320847872 child level=1
> ERROR: failed to repair root items: Input/output error
> [2/7] checking extents
> parent transid verify failed on 340246528 wanted 14741 found 14764
> parent transid verify failed on 340246528 wanted 14741 found 14764
> parent transid verify failed on 340246528 wanted 14741 found 14764
> Ignoring transid failure
> [... skipping many lines]
> root 257 inode 1866942 errors 2001, no inode item, link count wrong
>          unresolved ref dir 5719 index 9016 namelen 28 name 
> SiteSecurityServiceState.txt filetype 1 errors 4, no inode ref
> root 257 inode 1866943 errors 2001, no inode item, link count wrong
>          unresolved ref dir 5719 index 9018 namelen 21 name 
> AlternateServices.txt filetype 1 errors 4, no inode ref
> root 257 inode 1866989 errors 2001, no inode item, link count wrong
>          unresolved ref dir 346 index 16043 namelen 4 name user filetype 
> 1 errors 4, no inode ref
> root 257 inode 1866990 errors 2001, no inode item, link count wrong
>          unresolved ref dir 1216 index 11701 namelen 46 name 
> 0_3_1920_1080_8b47947fd8179de11b12e22fa2a454c8 filetype 1 errors 4, no 
> inode ref
> root 257 inode 1866991 errors 2001, no inode item, link count wrong
>          unresolved ref dir 5720 index 6961 namelen 16 name 
> recovery.jsonlz4 filetype 1 errors 4, no inode ref
> root 257 inode 1866995 errors 2001, no inode item, link count wrong
>          unresolved ref dir 6765 index 134 namelen 42 name 
> 3647222921wleabcEoxlt-eengsairo.sqlite-wal filetype 1 errors 4, no inode 
> ref
> parent transid verify failed on 348258304 wanted 14749 found 14766
> Ignoring transid failure
> parent transid verify failed on 348258304 wanted 14749 found 14766
> Ignoring transid failure
> parent transid verify failed on 348258304 wanted 14749 found 14766
> Ignoring transid failure
> parent transid verify failed on 348258304 wanted 14749 found 14766
> Ignoring transid failure
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks-test
> UUID: 2d1dc6b4-84ab-4c64-91a0-669b6228c516
> found 83720974336 bytes used, error(s) found
> total csum bytes: 50467580
> total tree bytes: 266665984
> total fs tree bytes: 186236928
> total extent tree bytes: 17317888
> btree space waste bytes: 40645922
> file data blocks allocated: 87345299456
>   referenced 47847440384
> [less: lines 1364572-1364611/1364611 byte 90015202/90015202 (END)  
> (press RETURN)]
> 
> # btrfs-find-root /dev/mapper/luks-test
> parent transid verify failed on 334692352 wanted 14761 found 14765
> parent transid verify failed on 334692352 wanted 14761 found 14765
> ERROR: failed to read block groups: Input/output error
> Superblock thinks the generation is 14761
> Superblock thinks the level is 0
> Found tree root at 444612608 gen 14761 level 0
> Well block 347160576(gen: 14768 level: 0) seems good, but 
> generation/level doesn't match, want gen: 14761 level: 0
> Well block 348192768(gen: 14766 level: 0) seems good, but 
> generation/level doesn't match, want gen: 14761 level: 0
> Well block 347865088(gen: 14765 level: 0) seems good, but 
> generation/level doesn't match, want gen: 14761 level: 0
> Well block 418840576(gen: 14758 level: 0) seems good, but 
> generation/level doesn't match, want gen: 14761 level: 0
> Well block 417120256(gen: 14749 level: 0) seems good, but 
> generation/level doesn't match, want gen: 14761 level: 0
> Well block 352256000(gen: 14743 level: 0) seems good, but 
> generation/level doesn't match, want gen: 14761 level: 0
> [end]
> 
> This is what I found out by reading.
> A fix - if possible - is out of my league now and don't want to poke 
> around and make things worse.
> Any chance to get this FS at least mounted for RO?

You can try "mount -o ro,rescue=all", which will skip the block group 
item search, but still there will be other corruptions.

I'm more interested in how this happened.
The main point here is, the found transid is newer than the on-disk 
transid, which means metadata COW is not working at all.

Are you using unsafe mount options like disabling barriers?

Thanks,
Qu

> 
> Thanks a lot, Michael.
