Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188AC6694EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 11:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjAMK7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 05:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241478AbjAMK6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 05:58:24 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8D7D1F8
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 02:54:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR3iZkeSfYvWi7qqvZJBGhTgYulagTc6LLuo+BaMUGZsZpkuf9sVyfNIZXQ9JW1fpb9AwrrRhozGKaBUayWWzK+TfNaCIHHkRhvwDRe/6N4Vba0Jotv7PDoFDrjf9qFNMUhovtLX+752pBgauEHF8Z5mSL3ScWV6hBs6UBkSrbf5TzvfE1YF2pJoicIMZqRneJtuo5wXsWSF0LQXW/MvjzoPPn5FdqNJxK8Tgs23mzeY17qmbR9m7GsxbwDFTiRf6UqQKMU4sIxewClichQ50Uhz2/avcndHw9OXqnB7LxtGZSah2+e5nmSC8oVrlFbj8RgUz807UM7wCM7rRCo2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7kLcSWRP2y09bP/s8tYO/Ks2gykKAQxh+A0oxvXFHw=;
 b=g41QLidgCV8IrXs8fyq/F/ec+H0z1ByskU3Q/1QMsIUiK07xVpYkcJb5tOd/L1sjccxHGaR5YOBqQn83SvGsoIj7i+OVpjRHOCsJfhbXovzg/3Ukmug7B6dyzFxuEmL+98qMvztfFtMmnW5YHcOehE9SdywlYQ/539VYwBGLPDrZmp+vDFnbRmFsg7c4eZutsZcH2gN2SdL3VNC8eTkZh0mkzkMaVJRARYw+UQ1Vi7X9pCCcf87H0nlXVjhXavbt9QlfSNszHJltDZ1Cs4CrTY/rCsS6joKIH2zEzb3+04tUXkjV1uPP7Wuzrhe0f0wXUiHKZCuNrt0Nag85BHWptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7kLcSWRP2y09bP/s8tYO/Ks2gykKAQxh+A0oxvXFHw=;
 b=HlwLjZCmrX8jFq8yPgLO2vcQcgGYCftHTDy3fig4TPVwNx9VQMsaB5ELJvWUZnk8/kq27lh1ZdYJujl3Eoou9qYey3QA0v3uO0/fnJYzHVpJBbSidHqxydplgvhoc9Drejq7KzLLLS26iwSwfpzFiUN6m4UGPUlTvma6ZWAXd7wCrZngssC5GTzu3TYxo4K3aKah0RAURhM9yyOvp4Kr8WTWINWvTZCyM0fXFLxsdQ21QN60cAz25nD1PbfytwIRKJ3Bf47dEei6Yl8styYcKO5jpNm4s5jUEHh9x/YZ+lim3HaYpRMPTJH/3O5h87BPEKGimxZdM2x4pZlGCkgFfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8073.eurprd04.prod.outlook.com (2603:10a6:10:24d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 10:54:13 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%8]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 10:54:13 +0000
Message-ID: <f042f0e7-0c5f-29ba-133c-5688f5ab0c04@suse.com>
Date:   Fri, 13 Jan 2023 18:54:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4] btrfs: update fs features sysfs directory
 asynchronously
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <68670fad66f9e112a19c6f0252cb3bf68979aa2f.1673606471.git.wqu@suse.com>
In-Reply-To: <68670fad66f9e112a19c6f0252cb3bf68979aa2f.1673606471.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 9634f461-e294-430f-26b1-08daf55481a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xqT08ZH9Q//VxiNARB9eHfnQNvndaXrqDq6bgi5uVSqndfctX9DNHstW5tmE8U7WwxvdwBiogOP/29F8E9PqFGI5D0B5Le1Bg8WQinFOi16WJycoQxtRqq9ecuun4YsZEp5hTMMVKTMcAOQ1/yWt9PSDwNGx7vJbJyXdiXoab7Rf7sdLaw5xPdYa+s2pK10TOVrfLKNFB/6OJr8+BMGpK4+whVyrnm7Qu5kO+Ngb54RZImdVXPIh71KRSrRij3jYQCTUtu10uTt6CuaKtAyUga/c9IOEUW3NGD18FiL6Nezqd7BqtJ1/2koUtsKEI46+ciRnDLx574dyTBXjDq2W8qBNbMgvd3w9warXxIn41ZHoXHUGjA4JOCywskegQbYjnAOu6v9sr9947ZZaD9WB+v18CL1GUc6i6y2lrgxl/5Q+aXxoDuz9p+Ris8ay793hUf0sIDSjQOM/Wz7Xaf002y33sNeqrFbp7QBKEyO1qJ1b7HMQHHGX0oyiUfgQ+GC6sgsxpS5W3IMq0ap4BjyZWdLLInpeiPWPP9YvLRcWZ07KstrjVlU49AUcHiIqUG1IkuiDwj+sqPtBQ5oxWDYjDghiF9gKpuXD6j01FDj5mr5awkrKG28VQRWjWkOMFgWKtFjBYF3BvbvYcfCMs4HfmUZ5FkfHvDP/EAZiBNAaHW6jMZ+d+25EpuPjt0DCvM8QwPxNiyqz1BL8gAm3j4xQ58Gc/rvwpkP1a+03blFrKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(5660300002)(316002)(36756003)(15650500001)(2906002)(2616005)(38100700002)(83380400001)(6486002)(31696002)(86362001)(53546011)(6506007)(186003)(6512007)(478600001)(66476007)(66946007)(66556008)(6666004)(31686004)(8936002)(66899015)(6916009)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC9FNWVQZnVTclBTSDlzWEgvRXFaREk5M3JXTzdSL2xtdytTblRCVXd4RnF5?=
 =?utf-8?B?OXJTd3M3ZUI4RVl4SXljeTl0SThkYWhNbFR6Zk5iQjV2cXFWQVpZZk5HK1lP?=
 =?utf-8?B?cHY2elRKUW1tbWNmNkJLZ2JyR0E5VHdFV2NabVBmdmhGd3BtMnY3eVlqem1N?=
 =?utf-8?B?TElReUtMQzZQdU5jQkhJVHNocWg0RkVzMHRTVE5ZMWxYY0pBL0FHeEM4VjIx?=
 =?utf-8?B?bzhNamVpeDd6V3lTYVdwUUlOa0FJcHBBeGtHNXVCOGR0Z0MzUUcwRFBIYkVk?=
 =?utf-8?B?UnR2dnRNTEVmb2tlaFVaaDVuZ0pqR1Yzc1VUSWkvUU00VlpYby9TR0N6MDV1?=
 =?utf-8?B?SEtHcTRXQ0Y3WFhTN0tIekNGMTVCeVp2UlRlNVdtaVIvLzF3WlhRdWd5UzA0?=
 =?utf-8?B?TW5ORDBYNTE3Rjd2OW9XTDdRZ2RhRVJYaFRNYTBWTUFiZCtWemh0d2Z5dk9k?=
 =?utf-8?B?R3QraWRubWJ6Z0JJZDNnQmkyK1hCYU02V0IzVC9HUWNSRm8zV3E1ekpEM1l4?=
 =?utf-8?B?bEpvNEZaKzNhck53TFUwSU16QWpMOVR6OTN3UWsxS281NC9PaUxOdmdJaUM1?=
 =?utf-8?B?VXpRQVlwSXpDMUNsVTg4R01Cc0x4YVFCQWJkeElZa2h5QlVwRFJvRi9BSzdS?=
 =?utf-8?B?ZDYrY0NWM1R5K3p2czBNdXIvMStsM3ZsTmxsajM2RytCVWtEQVBTOHNEVnNB?=
 =?utf-8?B?bXQrMlFhZU1EYzR1bUlRSXZvQ0owU1RTWHhOMVVEcjN2emZOcUN3YWR5U2dm?=
 =?utf-8?B?TjRYcHA1c2k0OTlFdGQwVys0dzBVYW1JM3pId0lRU0VkVzAvVjMrS2lMQkR4?=
 =?utf-8?B?R2FnK0piR0cwOGhkYUd1V2N1V1I3Vlg3K0wxMlpWOWVaODYvek5mQnMyRis4?=
 =?utf-8?B?bnRpeTJ4cERjTkpvc2RPZnRqMTBkSC92UGRQdlY5RGxZenErOGpPaTIzYnRx?=
 =?utf-8?B?WWg5eFJvYnZYSjF0eXByQTBJbS9EVlQ0VTIxZ1Mrc1NOQkZ0L1ZtdzlXS1Fs?=
 =?utf-8?B?TE5wUWFheDA0QTc1UHBkRnFkaDdPbDhXNVV6NFhhTEhZRGFHVDAwTTRYNHhO?=
 =?utf-8?B?a3dUWDU3bk1YcktRa2ZjclV4ZDRtZWhHblp1NXduK0JaaW9iWjhUamdlSGNk?=
 =?utf-8?B?a1dGZWxQck1kSElJVjVXSW1qVkF4dnp6ajVjNjBUdDlqODNuYk55eGxZSEQ2?=
 =?utf-8?B?UDdUdmYzc0tLU0NBNjdqTDJJVlVFNHpaVGFSejZFY1YrSVgxTXpoaUlkbm40?=
 =?utf-8?B?cTEvTlBJZC9zWVJ3YXRMZ053WXVjRW1MWllMNTdhL2x0OC9iWExHYWlDQnZD?=
 =?utf-8?B?UWVadEVjbXFLTWhJSUl3R1Uyd1dHeTFNb2JLdGdyaVJTbnZFYjNxL0tQcDVF?=
 =?utf-8?B?a1pvbmlaUmlkZlBoT3hRRlFya0MyME1lbHpNS0hxSnNCUGJtcDdqcjB5VGRq?=
 =?utf-8?B?bm1IVkpJNDhqV1JmcnlBM28wTEUwUVBXeUl0YmxIOENYQ3ZIU1AwUDJBaDVI?=
 =?utf-8?B?MzMveHVFWWJXUTZ0VzZsREFpVDU4Ti9vSUMrQmk1RTJSa0lUQTFpMitHWXg4?=
 =?utf-8?B?bkNPTXI1eVhjZTFUUlpuYzluNEs3SVhkZnZFR1N0Ty9OOEQxbmtHaHZMK0gx?=
 =?utf-8?B?OUtxcWdhSWZTZXRqdW1kZkJqRFVCRkQzSVI1eWRzQ3hkcHBUa1ZnSW5FQ0Jj?=
 =?utf-8?B?cVVKbStjblVwSGtjekFDTEZKS215MGx0ZUtzRUVBbjVOUE9tRnREWnY5cXp0?=
 =?utf-8?B?bDlwMEZqQURjTWtuL2tTdWVtbHZZcWNRTUNoYnBiaHRHejBmNFEzN3RNTWFC?=
 =?utf-8?B?WEdzS1h1S0lOTDIwTzRORGpUejhZU0JlTWduNFpyMDBMRjQ2d0FYQVZvSU9h?=
 =?utf-8?B?a1dXTWZWUVk4OFdkUkg2V2g3dTIweDhPSVJTdlUwNTI3WWk1TDQxSmRFVVR1?=
 =?utf-8?B?OWZDTlBXZTlWeWI2NHRGaTQvM3hRVTFtQlNhbkZRaGlDdmxLazlVdS9NNkQx?=
 =?utf-8?B?bmRNdkhUektSVE5hY3ZvMXB5VkNLbG9NSmgrSWh3bzh0bzZ4S2RVaVBRM3hx?=
 =?utf-8?B?aTdpTXQ2Q2k5L0dKMzRudWNSNWRyVTBSMVIrNTRIOWtuOHpiRUtIV1IraTdo?=
 =?utf-8?B?VGZldmlrUnlkbjFFY05XT1RDQ0t5bFVaczdZemd4a1JNdzBjdm5WSU9iMDg4?=
 =?utf-8?Q?u+AUCVthx7rm6LeJER+sqCQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9634f461-e294-430f-26b1-08daf55481a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 10:54:13.0944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CrFPMrnD47P3GtdM5E7XO7ATB3TtXxpANzM0Mq3wXnbJCd/+gw5UR7b+2mHBl9F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/13 18:43, Qu Wenruo wrote:
> [BUG]
>  From the introduction of per-fs feature sysfs interface
> (/sys/fs/btrfs/<UUID>/features/), the content of that directory is never
> updated.
> 
> Thus for the following case, that directory will not show the new
> features like RAID56:
> 
>   # mkfs.btrfs -f $dev1 $dev2 $dev3
>   # mount $dev1 $mnt
>   # btrfs balance start -f -mconvert=raid5 $mnt
>   # ls /sys/fs/btrfs/$uuid/features/
>   extended_iref  free_space_tree  no_holes  skinny_metadata
> 
> While after unmount and mount, we got the correct features:
> 
>   # umount $mnt
>   # mount $dev1 $mnt
>   # ls /sys/fs/btrfs/$uuid/features/
>   extended_iref  free_space_tree  no_holes  raid56 skinny_metadata
> 
> [CAUSE]
> Because we never really try to update the content of per-fs features/
> directory.
> 
> We had an attempt to update the features directory dynamically in commit
> 14e46e04958d ("btrfs: synchronize incompat feature bits with sysfs
> files"), but unfortunately it get reverted in commit e410e34fad91
> ("Revert "btrfs: synchronize incompat feature bits with sysfs files"").
> 
> The exported by never utilized function, btrfs_sysfs_feature_update() is
> the leftover of such attempt.
> 
> The problem in the original patch is, in the context of
> btrfs_create_chunk(), we can not afford to update the sysfs group.
> 
> As even if we go sysfs_update_group(), new files will need extra memory
> allocation, and we have no way to specify the sysfs update to go
> GFP_NOFS.
> 
> [FIX]
> This patch will address the old problem by doing asynchronous sysfs
> update in cleaner thread.
> 
> This involves the following changes:
> 
> - Allow __btrfs_(set|clear)_fs_(incompat|compat_ro) functions to return
>    bool
>    This allows us to know if we changed the feature.

Damn it, please remove above 3 lines when merging (if no more next 
version), it's no longer the case.

Thanks,
Qu
> 
> - Make btrfs_(set|clear)_fs_(incompat|compat_ro) functions to set
>    BTRFS_FS_FEATURE_CHANGED flag when needed
> 
> - Update btrfs_sysfs_feature_update() to use sysfs_update_group()
>    And drop unnecessary arguments.
> 
> - Call btrfs_sysfs_feature_update() in cleaner_kthread
>    If we have the BTRFS_FS_FEATURE_CHANGED flag set.
> 
> - Wake up cleaner_kthread in btrfs_commit_transaction if we have
>    BTRFS_FS_FEATURE_CHANGED flag
> 
> By this, all the previously dangerous call sites like
> btrfs_create_chunk() can just call the new
> btrfs_async_update_feature_change() and call it a day.
> 
> The real work happens at cleaner_kthread, thus we pay the cost of
> delaying the update to sysfs directory, but the delayed time should be
> small enough that end user can not distinguish.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix an unused variable in btrfs_parse_options()
>    Add the missing btrfs_async_update_feature_change() call.
> 
> v3:
> - Make btrfs_(set|clear)_fs_(incompat|compat_ro) functions to set
>    BTRFS_FS_FEATURE_CHANGED flag
>    So we don't need to check the return value and manually set the flag.
> 
> - Wake up the cleaner in btrfs_commit_transaction()
>    This can make the sysfs update as fast as happening in
>    btrfs_commit_transaction(), but still doesn't slow down
>    btrfs_commit_transaction().
> 
>    This also means we don't need to wake up the cleaner manually.
> 
> v4:
> - Move set_bit(BTRFS_FS_FEATURE_CHANGED) into
>    __btrfs_(set|clear)_fs_(incompat|compat_ro) helpers
> 
> - Remove unnecessary changes to btrfs_(set|clear)_fs_(incompat|compat_ro)
>    helpers
>    Since we no longer needsto check the return value, they can stay void.
>    This greately reduced the patch size.
> 
> - Update the error message for btrfs_sysfs_feature_update()
>    Now we output the full per-fs feature path.
> 
> - Fix the commit message
>    BTRFS_FS_FEATURE_CHANGING -> BTRFS_FS_FEATURE_CHANGED, only in commit
>    message.
> ---
>   fs/btrfs/disk-io.c     |  3 +++
>   fs/btrfs/fs.c          |  4 ++++
>   fs/btrfs/fs.h          |  6 ++++++
>   fs/btrfs/sysfs.c       | 29 ++++++++---------------------
>   fs/btrfs/sysfs.h       |  3 +--
>   fs/btrfs/transaction.c |  5 +++++
>   6 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7586a8e9b718..a6f89ac1c086 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1914,6 +1914,9 @@ static int cleaner_kthread(void *arg)
>   			goto sleep;
>   		}
>   
> +		if (test_and_clear_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags))
> +			btrfs_sysfs_feature_update(fs_info);
> +
>   		btrfs_run_delayed_iputs(fs_info);
>   
>   		again = btrfs_clean_one_deleted_snapshot(fs_info);
> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> index 5553e1f8afe8..31c1648bc0b4 100644
> --- a/fs/btrfs/fs.c
> +++ b/fs/btrfs/fs.c
> @@ -24,6 +24,7 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   				name, flag);
>   		}
>   		spin_unlock(&fs_info->super_lock);
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
>   	}
>   }
>   
> @@ -46,6 +47,7 @@ void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   				name, flag);
>   		}
>   		spin_unlock(&fs_info->super_lock);
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
>   	}
>   }
>   
> @@ -68,6 +70,7 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   				name, flag);
>   		}
>   		spin_unlock(&fs_info->super_lock);
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
>   	}
>   }
>   
> @@ -90,5 +93,6 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   				name, flag);
>   		}
>   		spin_unlock(&fs_info->super_lock);
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
>   	}
>   }
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 37b86acfcbcf..69ce270c5ff9 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -130,6 +130,12 @@ enum {
>   	BTRFS_FS_32BIT_ERROR,
>   	BTRFS_FS_32BIT_WARN,
>   #endif
> +
> +	/*
> +	 * Indicate if we have some features changed, this is mostly for
> +	 * cleaner thread to update the sysfs interface.
> +	 */
> +	BTRFS_FS_FEATURE_CHANGED,
>   };
>   
>   /*
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 45615ce36498..b9f5d1052c0c 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2272,36 +2272,23 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>    * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
>    * values in superblock. Call after any changes to incompat/compat_ro flags
>    */
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set)
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info)
>   {
> -	struct btrfs_fs_devices *fs_devs;
>   	struct kobject *fsid_kobj;
> -	u64 __maybe_unused features;
> -	int __maybe_unused ret;
> +	int ret;
>   
>   	if (!fs_info)
>   		return;
>   
> -	/*
> -	 * See 14e46e04958df74 and e410e34fad913dd, feature bit updates are not
> -	 * safe when called from some contexts (eg. balance)
> -	 */
> -	features = get_features(fs_info, set);
> -	ASSERT(bit & supported_feature_masks[set]);
> -
> -	fs_devs = fs_info->fs_devices;
> -	fsid_kobj = &fs_devs->fsid_kobj;
> -
> +	fsid_kobj = &fs_info->fs_devices->fsid_kobj;
>   	if (!fsid_kobj->state_initialized)
>   		return;
>   
> -	/*
> -	 * FIXME: this is too heavy to update just one value, ideally we'd like
> -	 * to use sysfs_update_group but some refactoring is needed first.
> -	 */
> -	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
> -	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
> +	ret = sysfs_update_group(fsid_kobj, &btrfs_feature_attr_group);
> +	if (ret < 0)
> +		btrfs_err(fs_info,
> +			  "failed to update /sys/fs/btrfs/%pU/features: %d",
> +			  fs_info->fs_devices->fsid, ret);
>   }
>   
>   int __init btrfs_init_sysfs(void)
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index bacef43f7267..86c7eef12873 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -19,8 +19,7 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device);
>   int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set);
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info);
>   void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
>   
>   int __init btrfs_init_sysfs(void);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 528efe559866..18329ebcb1cb 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2464,6 +2464,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	wake_up(&fs_info->transaction_wait);
>   	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKED);
>   
> +	/* If we have features changed, wake up the cleaner to update sysfs. */
> +	if (test_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags) &&
> +	    fs_info->cleaner_kthread)
> +		wake_up_process(fs_info->cleaner_kthread);
> +
>   	ret = btrfs_write_and_wait_transaction(trans);
>   	if (ret) {
>   		btrfs_handle_fs_error(fs_info, ret,
