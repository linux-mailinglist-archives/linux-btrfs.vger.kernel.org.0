Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13B6C2FB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCULDC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCULDB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:03:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E13A85D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV+xufpSvgOohJ8TIziyJbtF9Kj2R76exupD5fypFCIM3V3g6AyZbUKQDyks5gitZXrfY1/E4iEMO8yNmE2LQF+xXWfJG52B7E7enpfFDK0I92miE8dnewUzOWfpZ2imEP/2W5sKFzDBZfNxqk7P+fxcTq5Jwl/zxPPTNS0lo9SPNtLSAnWt/RzfpomTDh1Jv2SZvwbeULR2Ra0g4qVYpXB3c7yzu96dzUiXEOC/9A2VTF2Q3R/8t7WkKIRKXS5y9/RzYycQhwlcO7XqByO9+IoL7zt3HTGKQ3Xlv/uQpHApm2nMUS21YP1q/EBZuRa0oPb67rj+jltDx6uNnSEKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhcZq0x1OIIJ7MOaSdny3IsTtw8lUMyji+LWZzptiTQ=;
 b=mu4dbCAAg2nqjHDWrt4chQBQ0fzgaJ3RganMXJ3A84v0SEZYa6k/uGLHsNNXhPlf2gl5VvOZxU55b7Yr4O85IqD9itHYsfKgMDdv9emonj9+CrtleZfqCZ3+kpR+aoWm3arj4jaLBSTRGXAbnh264CCkxBl9Jp6svqYvRdh57fBQCcbSYjayJUyYu8MGVIMLQpTgqg93gN2VMjhQqJpFn0NaiphqDhmWAxXAkcp/19v+28C+qJpJqonzF1CIqIwx2J04eIhLIKA56t7ftIW8S611/HjMjt475lueXYI0lEbiPlLffw6poZpKBH8SSkTKCR8+3hV/Z+wTuG0gPF1lTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhcZq0x1OIIJ7MOaSdny3IsTtw8lUMyji+LWZzptiTQ=;
 b=4EPRLXviYQVIbo4MYp7TkceGGfuXQXRa2fU7up4JwTneU+3+/Mj71SJeJ6E9EubCTcG8olhqtmIm/hsJSZAVn5qLmAPohoDoJAcjPPc2LxhskmugRXPg3U/L8f9imrg2GP6J/9MQpomJys+tMDABN9lMRgi7NGq5AyPiJvJ3ZW/S/NnwimLq5FgZfCvuJ9aFLZSIm+/u8tGN9u0RlR8hA/NLQzDc6OHX9uCeNUiWQS0yknRgJuqk1DDmvFTgTzknkXXOewdwUClRRFZ06DmqhWW66C6SnmkbUzxparEcM2sk7gC7cygccnj4lI1OEKjlISKYqWCm9hJlTmpVYg5EPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8094.eurprd04.prod.outlook.com (2603:10a6:102:1c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:02:55 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:02:54 +0000
Message-ID: <fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com>
Date:   Tue, 21 Mar 2023 19:02:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Neal Gompa <neal@gompa.dev>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>,
        Davide Cavalca <davide@cavalca.name>,
        Sven Peter <sven@svenpeter.dev>, "axboe@fb.com" <axboe@fb.com>,
        Asahi Linux <asahi@lists.linux.dev>
References: <20230321020320.2555362-1-neal@gompa.dev>
 <b4329200-650e-f46e-505a-e5248f187be6@gmx.com>
 <8a52f55e-9b91-c6da-f2f6-eb8ccb87093d@marcan.st>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [RFC PATCH] btrfs-progs: mkfs: Enforce 4k sectorsize by default
In-Reply-To: <8a52f55e-9b91-c6da-f2f6-eb8ccb87093d@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: b13baa86-61de-4f8a-072e-08db29fbd232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqpjW7b+DHNCmOxGKfAu6xhKGHpkMmSfWxUMB7F/8YTnBqEvnBfcBNgzuB0I12LiPrTCOu7pTBgxG1V/2TYzsHylone6EVH/ALucM9VW4cM4v3nWWuRlbmK9zSjqfU6xSoRWjnxAPZjczcPU+D7iAwGyTTAqiZW7WWEiYW/SJLdg4isIxm9fWpDihA2aYKXf4guJ3tZkWz0hg0BYC6JM2SPNrSK9PxDkCM8V4Cw5bnp3vo6bcO3/d+NrWR0+W18el1SKYhH95xkMPdKinJxZneBWNZyscf3CTm1VY1p2bFjN7DfVZfSRyeopgX8vKG5+WEbcInKkc/5lTKpqf+mS1gM7DQb1q7HsX90H3uhYoDefNZloQxD5vKG7m7wIIYAA7XbyKKX4FLevX+qjuZiUJROt/gVkG/33WkiYOpiJgzi1b8x649S45lIg5lZxZkfIDo16eAdamKEbAOjiaR0wpoCO1YYXNVheHp18PS/SkXA3/RYNAn9TXX58XxHHTbhBVfkKvFPjkgR9J9Ko2YmoSDt9H3PlLdMK2AGpciP/H2hZMU+k9l/TGPW/zWNaSTk1lfxeh7Rw/KrcWNQ2K83M/Ga8LqSLNBjZTzowbO22AZ5kcT6jZPxN9AFY6CAk31Kycogci/26s7N2A43W7uQp1ELtY2I7gAex0SssnrqwNACfbdNDB9N+QaG587duR0TRDcK8wshVhs4AQ99uxAnzbNhxpU8fLaL5OnHD1lSdKcJkZYGK+yCZnbVJq6kkBq0SwbMMhrL2JPodLRQHoVcHiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(2616005)(6486002)(966005)(4326008)(83380400001)(478600001)(6666004)(316002)(110136005)(6512007)(66476007)(66946007)(66556008)(8676002)(53546011)(6506007)(186003)(54906003)(31686004)(8936002)(41300700001)(5660300002)(38100700002)(2906002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFN1SmlnOWJCN2FMa0gwWkpHaHBCOXhvUFlwS0dlY1JBajNPR21YNWh2QWZi?=
 =?utf-8?B?c2FRNS8yZHdmVEYrYUs4V0RUKyt0Z3hmN0o0RWRUbDlNZ1YzQlRmWEV5YmEr?=
 =?utf-8?B?KzZvK2NiRGpJaXNVMnVLRnpXdElsRDdHY3hjaVMrWTRoVkMvTnJrbUlWUUtz?=
 =?utf-8?B?aUU2ZWwzSzcrMjdwSHVKcWIvS2NCUWxNVXpBejBWQzJpRWFsTnBwc2wvTlNF?=
 =?utf-8?B?NUlCVGF5SmMzZHhEVVVxUUJoNno5ZGN3TDY0Umo4YjJlRVFVMzJGemJDVzVM?=
 =?utf-8?B?aEI0SGVNMXJud0poUkZQdzV0T1Azd3JxUU5qUGtjSkhxTElSSUdxeHo2Wjdh?=
 =?utf-8?B?Y01RUUZ3NzN2WEt6R1Bsc0dTMW93Q0FwN1QvWkZzOVBiZk5QNDdiUGhyS01U?=
 =?utf-8?B?Q3YvNlFRUFZLaDA4Zlp3cHBDVjBoUndaeU03czN1cDNyN0J5Y0l3SGJtOG0r?=
 =?utf-8?B?YVhXNjBaVmNoc0tmTkt6RWNqR2d6dVMxa1VwZTB2NEZJNVEvVHpJWkhFN1M1?=
 =?utf-8?B?L3lNNEJoNXcrWFpab1dGMXBsZDFvZjI0MnNES2ZIOG9SSlF1NHdENnFUQ0pE?=
 =?utf-8?B?WjlzamFlc1Q3UWpGNGxNcWhtb2xFNDE5V21hQVNXMmJ0MHRFenp0ZjkvVlhC?=
 =?utf-8?B?eC9CcEFMYlcvUmdlNXhlbEJqTEZzMEhMR2hRWjFqU2xYUURPRi9FM0RCdmVN?=
 =?utf-8?B?dDdvOXRxbjB4MTc1VThaQ2tWWXBIeEVkSyt6aTlmMHM2enIxMkx0enFtU3VJ?=
 =?utf-8?B?WkhIdk9STllKMDB2Y2xVaEp4RkN4VksxVXQ3TTNZSGFTaENrMVY4ek1pUVMv?=
 =?utf-8?B?Z1BIRlV4VE9BUGVMZWIwbmVZUWplY21zejVHcWN1anNxQVhFTERtdXI3Q0gz?=
 =?utf-8?B?RVlnVEFsV0x0UEhXamhFNGhydDJ6TkxBWHo3cHJ6WDhiU3lkZWdYOHdZdzV0?=
 =?utf-8?B?Y2tkTEVJUFhLbjBUVXpvNTRCMzRjSU40U0N6Umd0cGpjZUllS2xkNjZGRGVC?=
 =?utf-8?B?YjlMd01scUYxSWxvbHo0Z25VMkc1K1VwRGtMSWh2M2ZPZ0NtR2VNVnd2alV3?=
 =?utf-8?B?MFNGckpTNXQyaHFYaTVkWUdnOVJqN2RteTgrWVJtclJiZFN6MU1tUHpSdE5i?=
 =?utf-8?B?eS94azJpbFQyOW5BNEZIK0hWc2E4VUcwMHo5VDRyb2t2UEJkdUdNTU1EaFlm?=
 =?utf-8?B?SjdueHpUd1NoZFVjejd4TUhHT3BldmpEL3ZqcUdMbUdpTXNuUGdreXNESVZq?=
 =?utf-8?B?UzEzVG0zTm9MTGwxUHkvUWpjdU9yTTJoTWEvWXVHYzVqbFZVOG0wUnBDWE9l?=
 =?utf-8?B?WURFeHZLNXlVdDN0Ui83TVI1OUFKUXNPbmhyQVg1WTlDL2hEaUNlSm5yS3F2?=
 =?utf-8?B?NmtmK0pubDFnZlVRUjgxSkJ6WmR3MndIa0FJMkhuU05WZVV1YUFqQjJFWGo0?=
 =?utf-8?B?TFVJdUJlUVZja2M4VzNVYWZCdE5mQVRhY3F6WURVSkNqOHFkMlpVTUJBNldr?=
 =?utf-8?B?VVVyVUc5cytaMzB5M1o1YTFycWc1WEhWMCtBY1l1alJ0OWU0YzY2UWxlQmNm?=
 =?utf-8?B?MXY2ZnI0Q3ZqTHdVektMeitIOHJDQ2tyVFY1ME9iS0s5R1dPVksvcDhabzIy?=
 =?utf-8?B?bFd2VWs5czhNWHh5UXMyUzdrVEdrdHZRUk9ZZDRKc1VtYVVWNjcrcUwyMFZL?=
 =?utf-8?B?Z0NOTVFkN29CRzZrUVdHSjcyTnpLd3libklUd2xTNjF1bmlmNGh3N0tFb1ZF?=
 =?utf-8?B?aytiRjBjS2Q5WTVOT05hN3hXSTdiSWZiL1Jack5IUUdPZ3Z1L0xWZTFVUVAx?=
 =?utf-8?B?UG10aGdjd0hJZlZKTG85WFA2MG5vWk55bUN3QnRtNzdqSERaMzRnejI2YXVN?=
 =?utf-8?B?Mk1mVm1Ca0twTXpDTWdHTU5xTUJ1b3JNNk9xRkRFaGRheXlBOG14bnRwdzkz?=
 =?utf-8?B?cmZyNzJ5ZFg0SVZnSzFFcldFaUN6bjN5bG5xMFdaQVBnVUwzbkRNbDJrZFp1?=
 =?utf-8?B?a2Z3eFY3b1J4YnQyRW1GY0NMUEdhejcydlFyV2diVUhGK3ZrL09jTDFwTzBC?=
 =?utf-8?B?dGhoYVFtbG0zYnVXYmFmalBJemY0VldkM2x0a09hbDZTc1o1Wnk3djhmTTE0?=
 =?utf-8?B?OGNvWDZOV0JlSnFaaVBvZmtmSHpaSnY2N0d4WVpoeVIzSkg4TEpBZzRyNDRP?=
 =?utf-8?Q?igdE6QkvorPxo5n6jEME43s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13baa86-61de-4f8a-072e-08db29fbd232
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:02:54.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5q+uSfTLrA2XqIdENbSgzuxDqxWJ25MbIuuOc4yOhG60JKIWv00wWB8njMp0pt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 18:07, Hector Martin wrote:
> On 21/03/2023 12.21, Qu Wenruo wrote:
[...]
> 
> Note that we already have a bunch of people running Fedora Asahi, and as
> far as I know those images are created on 4K systems and then used on
> 16K systems, so this should be already getting real-world testing (and
> will get a lot more once we get to official announcement/release)
> regardless of the default.
> 
> IOW, this change is mostly about people creating secondary btrfs
> filesystems on Asahi directly, which is relatively niche in comparison.
> So if you have a subpage bug it's going to hit Asahi users whether this
> change happens or not :)

Awesome, nothing happened would already be the best thing.

The worst scenario, in which tons of users reporting subpage crash, is 
already avoided.

> 
>>
>> But on the other hand, I really don't want any big bug screwing up early
>> adopters, and further damage the reputation of btrfs.
>>
>>
>> Would the Asahi guys gives us some early test results?
>> (AKA, full fstests runs with 16K page size and 4K sectorsize).
> 
> Gave it a shot. Tested with options:
> 
> export TEST_DEV=/dev/nvme0n1p6
> export TEST_DIR=/mnt/test
> #export SCRATCH_DEV=/dev/nvme0n1p7
> export SCRATCH_MNT=/mnt/scratch
> export SCRATCH_DEV_POOL="/dev/nvme0n1p7 /dev/nvme0n1p8 /dev/nvme0n1p9
> /dev/nvme0n1p10 /dev/nvme0n1p11"
> export MKFS_OPTIONS="-s 4096"
> export FSTYP=btrfs
> 
> btrfs/012 is broken, the converted FS fails to mount with:
> 
> [  784.588172] BTRFS warning (device nvme0n1p7): v1 space cache is not
> supported for page size 16384 with sectorsize 4096
> [  784.588199] BTRFS error (device nvme0n1p7): open_ctree failed
> 
> btrfs/131 and 136 have the same issue.

This is v1 cache problems, IIRC newer progs from ArchlinuxARM upstream 
should already default to v2 cache, it's the test case itself requesting 
v1 cache, thus causing problems.
(v1 cache is explicitly rejected because I'm a little too lazy to fix 
all the hard coded PAGE_SIZE usage there).

I can update those test cases to avoid if v1 cache is not supported.

> 
> btrfs/106 has a size mismatch in the output, but I get the feeling
> that's just a bad test that assumes 4K somewhere?

Yep, that looks like the case.

Although I'll need dig deeper to find a way to fix the test case.

> 
> btrfs/140 is the first one that looks bad. Looks like the corruption
> correction didn't work for some reason.

This one seems interesting, would definitely bring some machine time for 
16K page sized testsing.

> 
> ... and then btrfs/142 which is similar actually managed to log a bunch
> of errors on our NVMe controller. Nice.
> 
> [ 1240.000104] nvme-apple 393cc0000.nvme: RTKit: syslog message:
> host_ans2.c:1564: cmd parsing error for tag 12 fast decode err 0x1
> [ 1240.000767] nvme0n1: Read(0x2) @ LBA 322753843, 0 blocks, Invalid
> Field in Command (sct 0x0 / sc 0x2)
> [ 1240.000771] nvme-apple 393cc0000.nvme: RTKit: syslog message:
> host_ans2.c:1469: tag 12, completed with err BAD_CMD-
> [ 1240.000775] operation not supported error, dev nvme0n1, sector
> 2582030751 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
> 
> Looks like it tried to read 0 blocks? I'm pretty sure that's not a valid
> block device operation... and then that test hangs because the
> _btrfs_direct_read_on_mirror() common function is completely broken, as
> it infinite loops if the exec'd command fails (which it does here, with
> ENOENT). Cc sven/axboe/asahi: I'm pretty sure we should catch
> upper-layer badness like this before sending it to the controller.

And also very weird, definitely worthy halting my daily runs.
(To be honest, recent misc-next is a little too boring, which means 
David is doing a pretty good job).

I also believe we should catch such zero lengthed bios inside btrfs 
before we had a block layer sanity checks.
(I know btrfs RAID56 code uses zero length bio as a way for completion 
barrier, but it should not reach lower layer, thus this must be a bug)

> 
> Excluding that one and moving on, 143 is broken the same way, as are
> btrfs/265, 266, 267, 269.
> 
> 213 failed to balance with ENOSPC.
> 
> btrfs/246 has an output discrepancy, I don't know what's up with that.
> 
> generic/251 then failed too, with dmesg logs about failing to trim block
> groups.
> 
> generic/520 failed with an EBUSY on umount, but I suspect this might be
> some desktop/systemd stuff trying to use the mount?
> 
> generic/563 suggests there may be cgroup accounting issues
> 
> generic/619 seems known to be pathologically slow on arm64, so I killed
> it (https://www.spinics.net/lists/linux-btrfs/msg131553.html).
> 
> generic/708 failed but that pointed to a known kernel bug that we don't
> have the fix for yet (this is running on 6.2 + asahi patches).
> 
> Run output and some select dmesg sections:
> https://gist.github.com/marcan/822a34266bcaf4f4cffaa6a198b4c616
> 
> Let me know if you need anything else.

Thank you very much for the test results and all your awesome Apple 
enablement work!
Qu

> 
>>
>> If nothing wrong happened, I am very happy to this patch.
>>
>> Thanks,
>> Qu
>>>
>>> Signed-off-by: Neal Gompa <neal@gompa.dev>
>>> ---
>>>    Documentation/Subpage.rst    |  9 +++++----
>>>    Documentation/mkfs.btrfs.rst | 11 +++++++----
>>>    mkfs/main.c                  |  2 +-
>>>    3 files changed, 13 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
>>> index 21a495d5..d7e9b241 100644
>>> --- a/Documentation/Subpage.rst
>>> +++ b/Documentation/Subpage.rst
>>> @@ -9,10 +9,11 @@ to the exactly same size of the block and page. On x86_64 this is typically
>>>    pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
>>>    with 64KiB sector size cannot be mounted on a system with 4KiB page size.
>>>    
>>> -While with subpage support, systems with 64KiB page size can create (still needs
>>> -"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
>>> -allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
>>> -near future.
>>> +Since v6.3, filesystems are created with a 4KiB sectorsize by default,
>>> +though it remains possible to create filesystems with other page sizes
>>> +(such as 64KiB with the "-s 64k" option for mkfs.btrfs). This ensures that
>>> +new filesystems are compatible across other architecture variants using
>>> +larger page sizes.
>>>    
>>>    Requirements, limitations
>>>    -------------------------
>>> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
>>> index ba7227b3..af0b9c03 100644
>>> --- a/Documentation/mkfs.btrfs.rst
>>> +++ b/Documentation/mkfs.btrfs.rst
>>> @@ -116,10 +116,13 @@ OPTIONS
>>>    -s|--sectorsize <size>
>>>            Specify the sectorsize, the minimum data block allocation unit.
>>>    
>>> -        The default value is the page size and is autodetected. If the sectorsize
>>> -        differs from the page size, the created filesystem may not be mountable by the
>>> -        running kernel. Therefore it is not recommended to use this option unless you
>>> -        are going to mount it on a system with the appropriate page size.
>>> +        The default value is 4KiB (4096). If larger page sizes (such as 64KiB [16384])
>>> +        are used, the created filesystem will only mount on systems with a running kernel
>>> +        running on a matching page size. Therefore it is not recommended to use this option
>>> +        unless you are going to mount it on a system with the appropriate page size.
>>> +
>>> +        .. note::
>>> +                Versions up to 6.3 set the sectorsize matching to the page size.
>>>    
>>>    -L|--label <string>
>>>            Specify a label for the filesystem. The *string* should be less than 256
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index f5e34cbd..5e1834d7 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -1207,7 +1207,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>    	}
>>>    
>>>    	if (!sectorsize)
>>> -		sectorsize = (u32)sysconf(_SC_PAGESIZE);
>>> +		sectorsize = (u32)SZ_4K;
>>>    	if (btrfs_check_sectorsize(sectorsize))
>>>    		goto error;
>>>    
>>
> 
> 
> - Hector
