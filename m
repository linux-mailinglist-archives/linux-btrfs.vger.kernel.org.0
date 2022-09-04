Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5569E5AC3AE
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIDJup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIDJun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 05:50:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15D03055C
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 02:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVDfqgz/bsa7nOEunyNbSjBspl/Y84SkeMtzaQRpc/mWCco6N3Sbdz0NkCaJHI9gr6Jr4a7i/4ad8u2uqbr9w5AyvR7afQhj3UjzpmIYXjtDyxkHF2M2p8z0sVFzXP2hsIM6KS3oj2CvLb1OAFtKGWwL1IBQ/Jt3h4VsytBJ6qiMoDR+LyXdX8tiDsspJFOcFOZtsPMnFmTfsrhbsTpgJfSQdSvVruByUyFNRc0MkGjvp4+8mkvdXXlGTftnrEulh1D6nsUQkvwp2bLf4erIP1Xc8jICcopRX+k/ypSIt0eNqsMTTeCB7VxsnlaV1E+0ZBFC7546SLCbVvu2zcQ7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xOfwEoDGdhVf6HO2sKF8H4d6CU5wQuCr46mGwncoGw=;
 b=YEx0J1M4BHJBk3fWozU3vIYq5gAKd0wlJ2W87x722RcA+4UbIz91BhBFyvqw0WT8+ZDSJ8YMpZaKIYCI2ZIZRm7I4NrVwvtpKohJoMUVcAxbyf/oy6sxkAmzudzUgGPuVHRxUyTVmFEzMMm/9Ap2K0Cu5/HID8LKlORE/8PAzKiZ0DAxUrTa68LZFvOmnQlF8V7o3Evntk50OZODwN2D3mrJuP6EeU4CwlwzKQgf5eRpbUeNhvtzMEaeHd/SXuV/PGRijPzEJ9y67+DPKxVuYhkFuUDjCn8pkXCuHcRWrLw3UV9LMtmC2gjZMrNiscc9PTgeqHh9oZ+6fdrgVYe8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xOfwEoDGdhVf6HO2sKF8H4d6CU5wQuCr46mGwncoGw=;
 b=W8qdykOtZlwei6CEBiykdyZDY/WjFjZuJXO3ikc7JjkeVQ2wE4SYd0AI667p8spIA3W5YrRhBpObxS3fXJOu/8RzRT21gRTyFrKcprTSVfLtK5tyRdgVNcjBw5eNhXFs//Dat9L32N41w6ldHUzt7IOv2ILCc5nXs7NJMZkSd/r3UCYq5GOdleB8+3eLyY1TLPIkeoADyocagqzTkIJ8ki+93hBYhN1ayQKG925OoU48oVeeaINyc4IAG7RV9ZyMIACCrvUh+l/ghW6XHTbLOicTx7jswK1tN+tY2rcGcYvDZRvfu/xkxyg0bWuWL8JDnSJ/L5Zp0WzWCGXU9rLQ3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sun, 4 Sep
 2022 09:50:20 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab%5]) with mapi id 15.20.5588.018; Sun, 4 Sep 2022
 09:50:20 +0000
Message-ID: <90233ce0-04a5-d97f-6d64-33db1045b762@suse.com>
Date:   Sun, 4 Sep 2022 17:50:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH V4] btrfs-progs: Make btrfs_prepare_device parallel during
 mkfs.btrfs
Content-Language: en-US
To:     li zhang <zhanglikernel@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1662279863-17114-1-git-send-email-zhanglikernel@gmail.com>
 <c4aa8e99-1613-e453-4a3a-be9d0de4b021@gmx.com>
 <CAAa-AGmyFx470zcd9DgCnRRDoQHC7inLEts4RU2JXww1GeXYsA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAAa-AGmyFx470zcd9DgCnRRDoQHC7inLEts4RU2JXww1GeXYsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a28290bf-019d-4836-85ab-08da8e5ae143
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMmGIjnzzFGnzfU7cnAqgXYNbO155yDO8ndzlXczJi11eyIq0IOtKOD38qzBCnMP3eURt9N4MsJUTDarI3SZFdJfi39nYwAuyDzHhROnbzTxJp/5KLLXmKIy73cy7WwI8kR80h/trACdsRK/OjtTRvv5vrSljutSDS6asusgVv5WQAEHvGyKVJVKr97QmKk7BlPltUbLCjN8XVo2IzesWj0uiFreZN20qBJtmsyWECtL4Z1DdF6dbqweEOeySuXVbNL6i9WdJxU3IFg/z9lP/3o26+fQHqqEGDmbXNECD4s53XPeARvtxFY9l5r14Fq6ItXPJICpstiPU9gJ+37rvwRnMMfEPf+EzKwlE4cYS/ln7EI6MMF1z0Fp+RJkiImWdqvzQDOT9crfvVn/kanS86MuNnmMZEyT7fLiY/2MBGZf9yG3VpkdFaHMfQLpG1jrJFUO32SzaYjLeiBouwLHATrApj46miZLCXfQckeqdZAdBIkeemX7YUbpRR0UTGl0jtgmBeetUUE8jLbF4YBduZeb1ASF4P0he2UERnt0gdYXFNwNDTAyUA4yBNNjHOYYry6LXrhLGhnkD+tgGVd1TWmYQasZYei//RkC2GKxBqgUnYhdREl4EoOpnk5p1a7+98oGuIzvVykLiEaojq9zfHIgxD/36I7Kt2mbT7hP5fNiYpu698jfJzLjnwJ7Q6v+njhE8gOcnXMpORjXe6HA1KXw4bmOHk9d3saS2vMZDBwgulHGc1Guy/mKIwFD8MEFXQjreB37UWzVRnyKGr7T49/pbXT+3F6cIgTflyrixFt3I6vBQRB63Fav4UIoTMrOeREsVvSJbnvgBOwoaJvvLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39850400004)(376002)(346002)(136003)(38100700002)(6666004)(31686004)(36756003)(86362001)(31696002)(83380400001)(2616005)(53546011)(186003)(41300700001)(6506007)(6512007)(66556008)(316002)(4326008)(6486002)(110136005)(8676002)(66946007)(66476007)(478600001)(30864003)(5660300002)(8936002)(2906002)(518174003)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sktybk1QclBscjBBSHNBdFVSUXlJUVdJMnpLblFLYlFUZWdycVo5RFRVUnEr?=
 =?utf-8?B?RjlmcUlFampSZDhDZjZrYnZBMXZoQlp4NUlJc2FIN3ZpZGZWdWdxemhxZzZw?=
 =?utf-8?B?T0RMK05STXdVRk10T0RoVXppcHVGMXNHSzM2YzlXTW9ZUDVLWkFWclN2N3B1?=
 =?utf-8?B?VkNzeTlyNnEwZWVjSFdhQVROWTlsVm1SZElqVDNIVXdtenVNKyt1TzBXRjhq?=
 =?utf-8?B?NTFMNG1Zb3RzRmVLbHNWZmJFNHFDb0ltTzdkS21PN241am14dEFuRzVLUklQ?=
 =?utf-8?B?KytsOXh1c0MwNWorNnRuMzV3YmZqYTl3b256RjJxUnlRdlFmU3h5R1FSK3lv?=
 =?utf-8?B?MTZZeHc5dTVHM2xIdUFZNmhpS3pJMTRQYzluNG92MTlQNmdIRWxVN3BJTHhp?=
 =?utf-8?B?OWlwSDk5eDJ2NWljSk9SWERraldnTXByYXpZOW9HZmJ4UjBxZlNDNjdFNXpB?=
 =?utf-8?B?S3RYamVKUVRWNHlnaUV1RllDdkFwbEliNTFUOEY4WnJzTXEzbENPR0F3bFk5?=
 =?utf-8?B?VktiN0E1Z1RPbU1TbzYrMUZWOTErYStCMDI5aGF5NHJ6ZzFyUmpxYnRLbDFM?=
 =?utf-8?B?WFNWTmh0UlhUS0l2SUlSUEdEdVIvQnRWOWk1blprbm5JYnF0Rk14anVJL2Rx?=
 =?utf-8?B?SC9zRHBUT0VYOCtjSzJZdTJVNFdFd0c1SWVOU3J2V3YrUmRPdy9mbE5iTWF4?=
 =?utf-8?B?cHk0TkZidEdPazlIZHJIWWZhYUkwUnVQY2NNSTRReEdtWk1zQXJDdEJXS3dX?=
 =?utf-8?B?RkVwVkRjQyt3WGluU3R2SStibTZtSU1MVGtqRUJYeVRNK2xFV0ZYdG5ZeVdI?=
 =?utf-8?B?L29RZFFVTHJlNm51TTZna2ZTdXNVV2RndEI4L2dsaTNCWUJFVmp0UWFYdm9Y?=
 =?utf-8?B?bzczd0lOMnVBOE0zYnY0OGtXOUpEQmY2MXBQUTlmNk5rS0lwb0VtNkZaZU8r?=
 =?utf-8?B?MVhsRVgrbWF4QWszQUltKzNYd2RCd21MbjIvakozanhwNFJ6UGlkUlJ5d3Yr?=
 =?utf-8?B?T0xjZFdqd2NiNlZ6TUtEaks1RXpoallCTGh5aytlby9BdlNPQVd3dnRyNW9n?=
 =?utf-8?B?MWczK2drOENQYTgxVWVFQjA3eXFUaFhGTldXb0huTlhDc25RcWRDTVdtZ05w?=
 =?utf-8?B?WGhUMWs0ekNJcU4rWEMwOGhFcXp6cXVFVHRKVEN5Rlg2YXJiNkM2ZllDa1o5?=
 =?utf-8?B?cnpwOVN2R3JCYzFzclhwRVBZd1N6TmhDK3BqMWFOOTQ4TjRsMXhJVGhxUlp3?=
 =?utf-8?B?MGl6aXVRNytPWlVKTmFETjYwcVJUK0FvbllkdDkrdllzRDZoQWJsZFN4OXUw?=
 =?utf-8?B?Q0hRRUtHaklsSFg3Ni82a1lJdHB0cnpsVG8zalYwRjRpUlZVamV1alNQbWRT?=
 =?utf-8?B?OThiMU4zUWhkVTFpZlZWSkRrNzJQbVYyVTNXS05haGpCUVZhUW01V282djdB?=
 =?utf-8?B?ekhRankreEpjV1VlZWQ2ZmZoUTkxSEJiVkJwdnNMSW9zYkoyOGZpcDFVeklQ?=
 =?utf-8?B?dnZkc3Q4TGRSeFFlNUQrOWNiaGQwVU1taDlmR2dNbTJWSjhROFM3blRnTVJz?=
 =?utf-8?B?U3RPUFhGdGQ4T2lSWlUwclBJNzdsNkRPY0lDMnhjNHdmSEF1YlN0QW54NEZJ?=
 =?utf-8?B?SXFmNGhOeURrTVF4TFJJc3dMMFBHRnhub3ZYL3JodU5YQmRGQkJZSjlqbHUy?=
 =?utf-8?B?cEt6TVJJcy9vajhvUGdrL0w0MXNuQmJJYVpJZFI4dFg2R1JFaUk3NDYzRTdD?=
 =?utf-8?B?M2s5RlJTc3lvei8vbVBMLzJ0QXhxcDJxL2gzUWx1bU9NZ2dFalhEM3p2dFQ2?=
 =?utf-8?B?YlFTVlA1cGIzRVZyZSsyMkg2QXRMZ0dSZlFGWVNyaE9kMWFvWW5mbmIyN0lp?=
 =?utf-8?B?NkRDdGllMmFXMldodWlDUC9qUWRibmVnN0gzUVpZUDFBQjg4eGJubFNwalpp?=
 =?utf-8?B?MTBaSHJGV1pmRHM3ZFozQlZPT3l0T01HU2JXNlV5bEVnbGIzOGxEQmFzVHB2?=
 =?utf-8?B?QktTM1JNWlFQaVFES0NuZ0RRN1Y5aGphcStvK0Uwak5LVElWNUU2ejJMSjQ0?=
 =?utf-8?B?NEtRMmdpVTA1bTdvV1Nxend4RHZTcUdCU2ovYWh6ckFURlNnTm5zNUhZdUFt?=
 =?utf-8?B?emE3dkx2UTVkR2xCNkhvL2QwRmFHZXFDMTdydWNwcHhIbVRFQk54KzExYitr?=
 =?utf-8?Q?FtaQL18Nfbyb32pU7sFf2Tc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28290bf-019d-4836-85ab-08da8e5ae143
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2022 09:50:20.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cc6fO0ZH0l2nwwZV0Oy7gUMfL26ARu0eQb694qB4/PWuIjpK5w3AIHwFexOZiMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4838
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/4 17:31, li zhang wrote:
> My first thought was that we should give the default value a least privilege,
> so when others want to use this global value they should think about what
> privileges they really need, so at first I initialized opt_oflags with 0,
> but scripts/checkpatch. pl(btrfs-devel) says I can't initialize global variables
> with 0 and opt_zoned with false.

For checkpatch, I guess the reason is, static global variable is already 
initialized to 0, thus no need to specificially assign it to 0/false.

But if you can provide some context, like the checkpatch error, maybe 
I'm totally wrong.


Another thing related the privillege is, the global variables are only 
for mkfs usage.

I can hardly come up any reason that we want read-only open flags for 
mkfs...

Thanks,
Qu

> So I compromised to initialize opt_oflags
> with O_RDONLY and opt_zoned with false .
> 
> Thanks,
> Li
> 
> Qu Wenruo <quwenruo.btrfs@gmx.com> 于2022年9月4日周日 16:40写道：
>>
>>
>>
>> On 2022/9/4 16:24, Li Zhang wrote:
>>> [enhancement]
>>> When a disk is formatted as btrfs, it calls
>>> btrfs_prepare_device for each device, which takes too much time.
>>>
>>> [implementation]
>>> Put each btrfs_prepare_device into a thread,
>>> wait for the first thread to complete to mkfs.btrfs,
>>> and wait for other threads to complete before adding
>>> other devices to the file system.
>>>
>>> [test]
>>> Using the btrfs-progs test case mkfs-tests, mkfs.btrfs works fine.
>>>
>>> Use tcmu-runner emulation to simulate two devices for testing.
>>> Each device is 2000G (about 19.53 TiB), the region size is 4MB,
>>> Use the following parameters for targetcli
>>> create name=zbc0 size=20000G cfgstring=model-HM/zsize-4/conv-100@~/zbc0.raw
>>>
>>> Call difftime to calculate the running time of the function btrfs_prepare_device.
>>> Calculate the time from thread creation to completion of all threads after
>>> patching (time calculation is not included in patch submission)
>>> The test results are as follows.
>>>
>>> $ lsscsi -p
>>> [10:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdb   -          none
>>> [11:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdc   -          none
>>>
>>> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
>>> ....
>>> time for prepare devices:4.000000.
>>> ....
>>>
>>> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
>>> ...
>>> time for prepare devices:2.000000.
>>> ...
>>>
>>> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
>>> ---
>>> Issue: 496
>>>
>>> V1:
>>> * Put btrfs_prepare_device into threads and make them parallel
>>>
>>> V2:
>>> * Set the 4 variables used by btrfs_prepare_device as global variables.
>>> * Use pthread_mutex to ensure error messages are not messed up.
>>> * Correct the error message
>>> * Wait for all threads to exit in a loop
>>>
>>> V3:
>>> * Add prefix opt to the global variables
>>> * Format code
>>> * Add error handler for open
>>>
>>> V4:
>>> * initialize the global options
>>>
>>>    mkfs/main.c | 154 +++++++++++++++++++++++++++++++++++++++++-------------------
>>>    1 file changed, 107 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index ce096d3..3e16a0e 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -31,6 +31,7 @@
>>>    #include <uuid/uuid.h>
>>>    #include <ctype.h>
>>>    #include <blkid/blkid.h>
>>> +#include <pthread.h>
>>>    #include "kernel-shared/ctree.h"
>>>    #include "kernel-shared/disk-io.h"
>>>    #include "kernel-shared/free-space-tree.h"
>>> @@ -60,6 +61,20 @@ struct mkfs_allocation {
>>>        u64 system;
>>>    };
>>>
>>> +static bool opt_zero_end = true;
>>> +static bool opt_discard = true;
>>> +static bool opt_zoned = true;
>>> +static int opt_oflags = O_RDONLY;
>>
>> Isn't the default one should be O_RDWR?
>>
>> Despite that, feel free to addd my reviewed by tag:
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>> +
>>> +static pthread_mutex_t prepare_mutex;
>>> +
>>> +struct prepare_device_progress {
>>> +     char *file;
>>> +     u64 dev_block_count;
>>> +     u64 block_count;
>>> +     int ret;
>>> +};
>>> +
>>>    static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
>>>                                struct mkfs_allocation *allocation)
>>>    {
>>> @@ -969,6 +984,31 @@ fail:
>>>        return ret;
>>>    }
>>>
>>> +static void *prepare_one_dev(void *ctx)
>>> +{
>>> +     struct prepare_device_progress *prepare_ctx = ctx;
>>> +     int fd;
>>> +
>>> +     fd = open(prepare_ctx->file, opt_oflags);
>>> +     if (fd < 0) {
>>> +             pthread_mutex_lock(&prepare_mutex);
>>> +             error("unable to open %s: %m", prepare_ctx->file);
>>> +             pthread_mutex_unlock(&prepare_mutex);
>>> +             prepare_ctx->ret = fd;
>>> +             return NULL;
>>> +     }
>>> +     prepare_ctx->ret = btrfs_prepare_device(fd,
>>> +                     prepare_ctx->file,
>>> +                     &prepare_ctx->dev_block_count,
>>> +                     prepare_ctx->block_count,
>>> +                     (bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
>>> +                     (opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
>>> +                     (opt_discard ? PREP_DEVICE_DISCARD : 0) |
>>> +                     (opt_zoned ? PREP_DEVICE_ZONED : 0));
>>> +     close(fd);
>>> +     return NULL;
>>> +}
>>> +
>>>    int BOX_MAIN(mkfs)(int argc, char **argv)
>>>    {
>>>        char *file;
>>> @@ -984,7 +1024,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>        u32 nodesize = 0;
>>>        u32 sectorsize = 0;
>>>        u32 stripesize = 4096;
>>> -     bool zero_end = true;
>>>        int fd = -1;
>>>        int ret = 0;
>>>        int close_ret;
>>> @@ -993,11 +1032,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>        bool nodesize_forced = false;
>>>        bool data_profile_opt = false;
>>>        bool metadata_profile_opt = false;
>>> -     bool discard = true;
>>>        bool ssd = false;
>>> -     bool zoned = false;
>>>        bool force_overwrite = false;
>>> -     int oflags;
>>>        char *source_dir = NULL;
>>>        bool source_dir_set = false;
>>>        bool shrink_rootdir = false;
>>> @@ -1006,6 +1042,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>        u64 shrink_size;
>>>        int dev_cnt = 0;
>>>        int saved_optind;
>>> +     pthread_t *t_prepare = NULL;
>>> +     struct prepare_device_progress *prepare_ctx = NULL;
>>>        char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
>>>        u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
>>>        u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
>>> @@ -1126,7 +1164,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>                                break;
>>>                        case 'b':
>>>                                block_count = parse_size_from_string(optarg);
>>> -                             zero_end = false;
>>> +                             opt_zero_end = false;
>>>                                break;
>>>                        case 'v':
>>>                                bconf_be_verbose();
>>> @@ -1144,7 +1182,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>                                        BTRFS_UUID_UNPARSED_SIZE - 1);
>>>                                break;
>>>                        case 'K':
>>> -                             discard = false;
>>> +                             opt_discard = false;
>>>                                break;
>>>                        case 'q':
>>>                                bconf_be_quiet();
>>> @@ -1183,7 +1221,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>        if (dev_cnt == 0)
>>>                print_usage(1);
>>>
>>> -     zoned = !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
>>> +     opt_zoned = !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
>>>
>>>        if (source_dir_set && dev_cnt > 1) {
>>>                error("the option -r is limited to a single device");
>>> @@ -1225,7 +1263,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>
>>>        file = argv[optind++];
>>>        ssd = is_ssd(file);
>>> -     if (zoned) {
>>> +     if (opt_zoned) {
>>>                if (!zone_size(file)) {
>>>                        error("zoned: %s: zone size undefined", file);
>>>                        exit(1);
>>> @@ -1235,7 +1273,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>                        printf(
>>>        "Zoned: %s: host-managed device detected, setting zoned feature\n",
>>>                               file);
>>> -             zoned = true;
>>> +             opt_zoned = true;
>>>                features |= BTRFS_FEATURE_INCOMPAT_ZONED;
>>>        }
>>>
>>> @@ -1302,7 +1340,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>                }
>>>        }
>>>
>>> -     if (zoned) {
>>> +     if (opt_zoned) {
>>>                if (source_dir_set) {
>>>                        error("the option -r and zoned mode are incompatible");
>>>                        exit(1);
>>> @@ -1392,7 +1430,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>         * 1 zone for a metadata block group
>>>         * 1 zone for a data block group
>>>         */
>>> -     if (zoned && block_count && block_count < 5 * zone_size(file)) {
>>> +     if (opt_zoned && block_count && block_count < 5 * zone_size(file)) {
>>>                error("size %llu is too small to make a usable filesystem",
>>>                        block_count);
>>>                error("minimum size for a zoned btrfs filesystem is %llu",
>>> @@ -1422,35 +1460,58 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>        if (ret)
>>>                goto error;
>>>
>>> -     if (zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile) ||
>>> +     if (opt_zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile) ||
>>>                      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | data_profile))) {
>>>                error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
>>>                goto error;
>>>        }
>>>
>>> -     dev_cnt--;
>>> +     t_prepare = calloc(dev_cnt, sizeof(*t_prepare));
>>> +     prepare_ctx = calloc(dev_cnt, sizeof(*prepare_ctx));
>>>
>>> -     oflags = O_RDWR;
>>> -     if (zoned && zoned_model(file) == ZONED_HOST_MANAGED)
>>> -             oflags |= O_DIRECT;
>>> +     if (!t_prepare || !prepare_ctx) {
>>> +             error("unable to alloc thread for preparing dev");
>>> +             goto error;
>>> +     }
>>>
>>> -     /*
>>> -      * Open without O_EXCL so that the problem should not occur by the
>>> -      * following operation in kernel:
>>> -      * (btrfs_register_one_device() fails if O_EXCL is on)
>>> -      */
>>> -     fd = open(file, oflags);
>>> +     pthread_mutex_init(&prepare_mutex, NULL);
>>> +     opt_oflags = O_RDWR;
>>> +     for (i = 0; i < dev_cnt; i++) {
>>> +             if (opt_zoned && zoned_model(argv[optind + i - 1]) ==
>>> +                     ZONED_HOST_MANAGED) {
>>> +                     opt_oflags |= O_DIRECT;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     for (i = 0; i < dev_cnt; i++) {
>>> +             prepare_ctx[i].file = argv[optind + i - 1];
>>> +             prepare_ctx[i].block_count = block_count;
>>> +             prepare_ctx[i].dev_block_count = block_count;
>>> +             ret = pthread_create(&t_prepare[i], NULL,
>>> +                     prepare_one_dev, &prepare_ctx[i]);
>>> +             if (ret) {
>>> +                     error("create thread for prepare devices: %s failed, "
>>> +                                     "errno: %d",
>>> +                                     prepare_ctx[i].file, ret);
>>> +                     goto error;
>>> +             }
>>> +     }
>>> +     for (i = 0; i < dev_cnt; i++)
>>> +             pthread_join(t_prepare[i], NULL);
>>> +     ret = prepare_ctx[0].ret;
>>> +
>>> +     if (ret) {
>>> +             error("unable prepare device: %s\n", prepare_ctx[0].file);
>>> +             goto error;
>>> +     }
>>> +
>>> +     dev_cnt--;
>>> +     fd = open(file, opt_oflags);
>>>        if (fd < 0) {
>>>                error("unable to open %s: %m", file);
>>>                goto error;
>>>        }
>>> -     ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
>>> -                     (zero_end ? PREP_DEVICE_ZERO_END : 0) |
>>> -                     (discard ? PREP_DEVICE_DISCARD : 0) |
>>> -                     (bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
>>> -                     (zoned ? PREP_DEVICE_ZONED : 0));
>>> -     if (ret)
>>> -             goto error;
>>> +     dev_block_count = prepare_ctx[0].dev_block_count;
>>>        if (block_count && block_count > dev_block_count) {
>>>                error("%s is smaller than requested size, expected %llu, found %llu",
>>>                      file, (unsigned long long)block_count,
>>> @@ -1459,7 +1520,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>        }
>>>
>>>        /* To create the first block group and chunk 0 in make_btrfs */
>>> -     system_group_size = zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
>>> +     system_group_size = opt_zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
>>>        if (dev_block_count < system_group_size) {
>>>                error("device is too small to make filesystem, must be at least %llu",
>>>                                (unsigned long long)system_group_size);
>>> @@ -1487,7 +1548,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>        mkfs_cfg.runtime_features = runtime_features;
>>>        mkfs_cfg.csum_type = csum_type;
>>>        mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
>>> -     if (zoned)
>>> +     if (opt_zoned)
>>>                mkfs_cfg.zone_size = zone_size(file);
>>>        else
>>>                mkfs_cfg.zone_size = 0;
>>> @@ -1558,14 +1619,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>                goto raid_groups;
>>>
>>>        while (dev_cnt-- > 0) {
>>> +             int dev_index = argc - saved_optind - dev_cnt - 1;
>>>                file = argv[optind++];
>>>
>>> -             /*
>>> -              * open without O_EXCL so that the problem should not
>>> -              * occur by the following processing.
>>> -              * (btrfs_register_one_device() fails if O_EXCL is on)
>>> -              */
>>> -             fd = open(file, O_RDWR);
>>> +             fd = open(file, opt_oflags);
>>>                if (fd < 0) {
>>>                        error("unable to open %s: %m", file);
>>>                        goto error;
>>> @@ -1578,13 +1635,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>                        close(fd);
>>>                        continue;
>>>                }
>>> -             ret = btrfs_prepare_device(fd, file, &dev_block_count,
>>> -                             block_count,
>>> -                             (bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
>>> -                             (zero_end ? PREP_DEVICE_ZERO_END : 0) |
>>> -                             (discard ? PREP_DEVICE_DISCARD : 0) |
>>> -                             (zoned ? PREP_DEVICE_ZONED : 0));
>>> -             if (ret) {
>>> +             dev_block_count = prepare_ctx[dev_index]
>>> +                     .dev_block_count;
>>> +
>>> +             if (prepare_ctx[dev_index].ret) {
>>> +                     error("unable prepare device: %s.\n",
>>> +                                     prepare_ctx[dev_index].file);
>>>                        goto error;
>>>                }
>>>
>>> @@ -1714,8 +1770,8 @@ raid_groups:
>>>                        btrfs_group_profile_str(metadata_profile),
>>>                        pretty_size(allocation.system));
>>>                printf("SSD detected:       %s\n", ssd ? "yes" : "no");
>>> -             printf("Zoned device:       %s\n", zoned ? "yes" : "no");
>>> -             if (zoned)
>>> +             printf("Zoned device:       %s\n", opt_zoned ? "yes" : "no");
>>> +             if (opt_zoned)
>>>                        printf("  Zone size:        %s\n",
>>>                               pretty_size(fs_info->zone_size));
>>>                btrfs_parse_fs_features_to_string(features_buf, features);
>>> @@ -1763,12 +1819,16 @@ out:
>>>
>>>        btrfs_close_all_devices();
>>>        free(label);
>>> -
>>> +     free(t_prepare);
>>> +     free(prepare_ctx);
>>>        return !!ret;
>>> +
>>>    error:
>>>        if (fd > 0)
>>>                close(fd);
>>>
>>> +     free(t_prepare);
>>> +     free(prepare_ctx);
>>>        free(label);
>>>        exit(1);
>>>    success:
