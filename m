Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988376BA66D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 06:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCOFBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 01:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOFBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 01:01:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8715D26D
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 22:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaMWECiLxqgApqkHMkCfHSVZkGEuxH24zANpjYSsfL8s6Nw0o4rvW0ROFgwedt2Yh7jKnoSANKcGsljZ7VuOz9kAm1OMODbxUu3mYRLawcBhqJGTKfuU4ExrhbugrJCRMcLeZ6e/nvKijUlpzWx2vsYyDPvsm+q8G3RYtjgytzgvGOIdMECvECWeJ2wJjQd4eJyMOqnMhbMfaSYfFPIWJKSlxuzDn4lKk64T0T1gQNlAuXIx8ixP4BagMQ/imVkqjF3ecR8Y27zws1bTzitQ7yYKqwCqq6IbB7NgxhTlax5ebpMZWbOhiOL01/ZcNhCEbk+0wBCY6KZouDnorc5fPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjDeIKUWK7QEds3UBK8CEtSlJVK4aQLpELMwAZeZ3Lk=;
 b=mr1kPznMtRuv3zKLQAH+01fzrdeqbyJy7QO/+wKGeqezypVELTfdeHjrBMbPSoRmL8YhKZoUzckOXEEFbBxriocvlheBJblkTW7Lm3ojoRn8AU0BxRUSM31JUAcgKCO5lsUwK6p+kbI2PsyfO7OUF7E2q2kzFVTtzd9zb8niyxTlcyrgk8V778ZokTSEOioGlsL3GJG8XPYqan+2PFiTR9ISR+AZR+ep/2Ci6HfgYNl3Vp5Szpab6RtlqTUWq/0REEqkdhevN8IG980yALjZYF6eTOdHJXvVz5XM990fyDb5q7v+mDQomQ6J3e/lePmP2IpP0ajYBMGb7GtgWnidNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjDeIKUWK7QEds3UBK8CEtSlJVK4aQLpELMwAZeZ3Lk=;
 b=x9LgM8+kQEbVx5v8BcyLQQrxUtCNj+fSeOeRecDmnlOI9jweDHBjRczi/KTaYrT95s87bcH+XK9Qx653ncyk3beIy2nhbeb90LMfAJjqZDX8TWntJ7cu91HCil53O4c/1xghhXiUnIvtzUTZdnHlr2lJnL97Ct50MXVIgEtgf0clU9T4dkn5poJ5ckW/SI/jXiURTVWWTON1O259iZsksZxz6WfteMMAti6lYFga5PYROKF1AsMolk3JqHGq2tOPsbzkKcE4Wf6B3ZZPnGsLGOqWW1HYfWN2CxzUB0uTBfTAhDvg9podv+xnvsWrd29u9MtoivrOU8H8h1taUwUwQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB8148.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 05:01:03 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 05:01:03 +0000
Message-ID: <b10b0bc0-f413-cc85-ca51-a03dcf214a95@suse.com>
Date:   Wed, 15 Mar 2023 13:00:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs-progs: mkfs: use flock to prevent udev race
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <61a44fa98c640d93a77c14a7f617f5d68f166002.1678755426.git.wqu@suse.com>
In-Reply-To: <61a44fa98c640d93a77c14a7f617f5d68f166002.1678755426.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 731516af-3d3c-49ba-2c27-08db25124703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIp8G4QS4+gUTEU66GHZZEqlY6dqQOY62UStT6u3bR6t4bwG9HIiNqz7AV1WOqZv1h3wEqAyi8XlvT3fa9iyDTv/HpO6YFfqgr/xqWK6WtnG2C2sI00hjw/mBCUzndep42VdXeIaOLlMJZDZbE+7IWUt+BfKYGCKLPVFP0MKqyIr8dILuqNVqUNXTWcuVVv5uh8VFHxqpaZcaSiHzW7xQvoP3sjvfp4JglChCgDr08ivBHEYQYJn+0bHWJZNyp2IzqCxeG1w/HRgyVz8T0Fg7fK+32cov1TYMsR+g2QnOmEBlTu6OxarI5vK9r4TDH6FKmzEwpR86me7RqzvSrNMvWVFMavltSA9d5nHGrOSQPOmFa7mr9VJt5lZPeDvmFqn+cbnob12p1dAX/vMf94Nq9y08UYINXsLo2rc7Qc8NjTR9owfhUKrTVxpetnarx+5zVO9FXOKioCIHyw/8rOHEfrY+uLJuLpqVd6ivnb8kNOQeD3niPGcEGuxxAIo5vfHMmHt94jX7w8er0Fki4BCFhRXvoVfcmzJSD9mTu/6pu0bo2aor60bcn5t38dF0y5gLceOw9B/GCeAjaCfmPz9g5Eomj3ech2mW23DujIEdcMmVIeQS9JWQSc6BJcfN77pKSWfx9miqtY+n+epqFQHiLjhublF75JjhwjgFv0CbWli9FMNsOU3KciyFkF7EchsFhSO5S9110IlsSXu5EG7xWwZbTTjZWWyhpf1TykeuM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(6666004)(31686004)(6506007)(6512007)(2906002)(53546011)(6486002)(186003)(36756003)(2616005)(83380400001)(478600001)(5660300002)(8936002)(316002)(86362001)(31696002)(38100700002)(66946007)(66476007)(8676002)(66556008)(6916009)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2RQMXRucTVPOFFDSEhHV0xhZmN3bGllU3l3VTdoSVRFOFJxMTB0NDU4c1Qv?=
 =?utf-8?B?K3V1SVdOS0FpWDF1eFQ5dXcveWVva2VRNk1VeS9sc05tdzNDS0VoQVRZMjZB?=
 =?utf-8?B?d2VNd08xcHZzWW1QeTF0aGd0TXVhY3RNaTFGS01kcVRtUnI0NmxOQ21oMVdx?=
 =?utf-8?B?S2NVcEg2NHpzOEVMS0FoK3RXWk5STmZMdDRWemczTlpUVkdWSkQzZ1QySVls?=
 =?utf-8?B?YkhSMlEyaTJBbys1aDI1dGtZTHNYampya3JLY1JZYVdFV3hCaHgxZlZack1P?=
 =?utf-8?B?SUQ0YktwelN1ZjdQY0kwYysyQmRlS0JueHQ2NkorUWhjTzhTYnNQaGltdWJ0?=
 =?utf-8?B?ay84cTNYZ0NDVlpBd1RBcnZVZSsybG52Tmx5NDVXRmhHbVkwRVlqY3RFeTVz?=
 =?utf-8?B?YkdZV2RzWk01QmIzUFBmMVErZm9USFlHUUloOVdwN0JIZTk1MFJ6SDlBdmdj?=
 =?utf-8?B?TlNGL1BKMDU4M2JMaGZ6akZDN0FlcTJZclFjTm9KRmhuemRxNDc2TWE5NDFZ?=
 =?utf-8?B?bmRmb0NEL2tObllHQW9HRHFlRUtFMDlBWmh2THZkWUExVTZFNXdpT0NlVmdm?=
 =?utf-8?B?bGE3M01KMkpLLzFjVzVQNjk3QVRseEZwS3l2SDdtTUV2RnBVd3diNkh2bDNS?=
 =?utf-8?B?K1A5eStvdUhqcktrZmRVdmlUMFRMaVlFZlNidVJMcmlLQ3NaeHQ4MjRqU0gw?=
 =?utf-8?B?RUQ0N1NYaUl2dHhKcXo0WXRJTFNQWVgycnRET3lrT3ducCtDVVZZSU14QW5Y?=
 =?utf-8?B?S2haazBZOWNMOXMrb2k1U0ovL2psN1ZHcUpEQTlVYkRIaW8yVFBZV0lJRzZr?=
 =?utf-8?B?KzVsNHhQVnFiS2tkVW1aU2N2K3BUQXBva3lnMlNoWU9TeEJHaUlDRU1RQTFO?=
 =?utf-8?B?MUFpNjNETzlNZ0tud1BUenBtUGlibGt6b3hmQ2FiVFhLVHlhWkJzTDJUMmtR?=
 =?utf-8?B?TDViVmVpZkk3OVhpMWVxanQyUFR0RkRoOGJsT01jRUk4NzFnOVRlRVRrNk5s?=
 =?utf-8?B?VUIzdEhhalE2ZGJBTk84VysvL2ZmaGFHZ2pJQnMxN1hSSkNyNCtzOEhVWE95?=
 =?utf-8?B?ZndJSy8wVjU0STVyT0xPbzNRVmlRUEtJT3YvUjFDQ04zRHBLZExMQTBJa3hx?=
 =?utf-8?B?d3orKzNIOHBhcUZlM2c0aU5uREgzMVFURlk4WCs3bE9hajM5VXYzR045aER4?=
 =?utf-8?B?UkVkclIxVzRIVm9BSDAyaktKSGdkV2cxVkxLRjM5U3QzUU5WTVhPbFIrL1ha?=
 =?utf-8?B?aUlIWTMxUkY1TXpVTnNHUmNUS2NqN3Jrcm1QOWFSbXhNSGpuNVZ4bEFWQXBw?=
 =?utf-8?B?MTdiT2x2TElZRnZqT0hFc0xDNy9jWE5wN21GZUpZUVZHYno4Mk1qMTZPVzV6?=
 =?utf-8?B?VlFmYWZrbHNFNTlnQldKTUxLc2xHYjdiaFBmNWNJb1J3T0ptRmhITEtIakt2?=
 =?utf-8?B?K3Nud0k3UmI2THNKdTBoL1dKcmF3MjNTS1hJUFprZmhRbEpSMExxZ0NEVzNB?=
 =?utf-8?B?a2pERWo5VTNHRHkwaVo5NTVBbDJPU1dyVVZ3NW9uWUNobElWUC8vdXUxVGt2?=
 =?utf-8?B?Q2UvU1BNb3AvOXBKZjMzaWVOelhwdDJ0ZjJSaTN0am1nNjB3bXhtamppOURr?=
 =?utf-8?B?alNYMHJpQ3lDZWZWRXJodDRqZThhTGxyVXhlWkU0NGc0TWhicm1ub2ZIMUFD?=
 =?utf-8?B?UHFjVmc1a3lsMSt1ajBmQUlGTk1meCtXSWRnZVVEc2xYZjM3MzIrREl3TnpW?=
 =?utf-8?B?OEZTNkxTcG1VKzhVOGg0Q2d5RCtvV3RUOHRkeHJWU05XRGJvbnk3a3ppbmFy?=
 =?utf-8?B?QkVkTmJJMTZJczV5aEk3dlI3dFFFMkdjZUQrNFpBaE9wNlZiL1ZpTjJKOWpj?=
 =?utf-8?B?OEc5Zm9kdHB4eUxMVDVBbWsrK1QvNFhXcUsvMEJIUXpCT2pEQ0dCWXd4Umda?=
 =?utf-8?B?MVlZNFhJZCs2QmFLMWkvR0kvdWN0cmRlVDRGelM5ODBWWXVkeGhpT2U3K0ZJ?=
 =?utf-8?B?SS9GTUVqd2J4Vk1ROG5pTW9YY3lJWVZwWWcrUW5sMTlSUmJ2WUZHV3NjYkhR?=
 =?utf-8?B?NEloNkdaNU5NaS92cTROcUpiTmFLV2tEbEdacUNMU1BCb3JJdEtuQmppcTM3?=
 =?utf-8?B?N2JzTWUyV2pYZkRIQ3lyL21IRkd2U0xXUDdQTXpId00yaDZlYWhZbEd4aURL?=
 =?utf-8?Q?M1JTSd1YVPGGkis3Z5BwaFs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731516af-3d3c-49ba-2c27-08db25124703
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 05:01:03.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TU71vWBy4OWIt3unxdFB10wTvVEKmr6qqeVLGeVcqnUkwHr+uVFlHi1zny5ZzkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Please discard this patch.

There is some extra limits on the flock() usage, especially for dm devices.

- One has to lock the root block device, not the partition one

- flock() on dm devices are mostly ignored

I'll update the patch to a new method to address the problem.

Thanks,
Qu

On 2023/3/14 08:57, Qu Wenruo wrote:
> [BUG]
> There is an internal bug report that, after mkfs.btrfs there is some
> random cases where the uuid soft link (/dev/disk/by-uuid) is not
> created.
> 
> [CAUSE]
> The soft link is created by udev, which monitor those block devices by
> listening to the inotify.
> 
> But during the scan for filesystems, inotify would be temporarily
> disabled until the scan is done.
> 
> However btrfs split the mkfs into several parts, leaving a window for
> udev to got half backed result:
> 
> - Disk prepare
>    This involves discarding the whole disk (by defualt) or previous
>    superblock (-k option).
> 
>    After the prepare is done, we close the fd of each device, which would
>    trigger udev scan on the block device, without any btrfs superblock
>    signature.
> 
> - Temporary btrfs creation
>    Here we create an initial btrfs image on the first device, using
>    the first device, and then close the fd.
> 
>    This would also trigger udev scan, but the temporary superblock
>    contains an invalid magic number.
> 
> - Real btrfs creation
>    Here we call open_ctree() on the initial btrfs, and make it to be
>    a proper btrfs.
>    Then we call close_ctree() to finalize the fs, writing back the real
>    super blocks and close the devices.
> 
>    This is the normal even triggering udev to detect new btrfs and create
>    the soft link.
> 
> However if the first two steps triggered a long enough scan that covers
> the last step, the last step itself can not trigger a scan, thus udev
> only got an empty or invalid btrfs super block, and won't create the
> uuid soft link.
> 
> [FIX]
> To address the problem, follow the advice from systemd
> [BLOCK_DEVICE_LOCKING] section, using flock() to lock an fd of each
> device.
> 
> And only close the locked fd after all operation is done.
> 
> Here we re-use the prepare_ctx[] array, and saves the fd until the end
> of mkfs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   mkfs/main.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f5e34cbda612..e91311bf6eb4 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -18,6 +18,7 @@
>   
>   #include "kerncompat.h"
>   #include <sys/stat.h>
> +#include <sys/file.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <fcntl.h>
> @@ -75,6 +76,7 @@ struct prepare_device_progress {
>   	char *file;
>   	u64 dev_block_count;
>   	u64 block_count;
> +	int fd;
>   	int ret;
>   };
>   
> @@ -965,22 +967,26 @@ fail:
>   static void *prepare_one_device(void *ctx)
>   {
>   	struct prepare_device_progress *prepare_ctx = ctx;
> -	int fd;
>   
> -	fd = open(prepare_ctx->file, opt_oflags);
> -	if (fd < 0) {
> +	prepare_ctx->fd = open(prepare_ctx->file, opt_oflags);
> +	if (prepare_ctx->fd < 0) {
>   		error("unable to open %s: %m", prepare_ctx->file);
>   		prepare_ctx->ret = -errno;
>   		return NULL;
>   	}
> -	prepare_ctx->ret = btrfs_prepare_device(fd, prepare_ctx->file,
> +	/*
> +	 * Take flock() to prevent udev got a half backed scan.
> +	 * This is only an advisory operation, thus no need to handle
> +	 * its failure.
> +	 */
> +	flock(prepare_ctx->fd, LOCK_EX | LOCK_NB);
> +	prepare_ctx->ret = btrfs_prepare_device(prepare_ctx->fd, prepare_ctx->file,
>   				&prepare_ctx->dev_block_count,
>   				prepare_ctx->block_count,
>   				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
>   				(opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
>   				(opt_discard ? PREP_DEVICE_DISCARD : 0) |
>   				(opt_zoned ? PREP_DEVICE_ZONED : 0));
> -	close(fd);
>   
>   	return NULL;
>   }
> @@ -1002,6 +1008,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u64 min_dev_size;
>   	u64 shrink_size;
>   	int device_count = 0;
> +	int orig_device_count;
>   	int saved_optind;
>   	pthread_t *t_prepare = NULL;
>   	struct prepare_device_progress *prepare_ctx = NULL;
> @@ -1217,6 +1224,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	stripesize = sectorsize;
>   	saved_optind = optind;
>   	device_count = argc - optind;
> +	orig_device_count = device_count;
>   	if (device_count == 0)
>   		usage(&mkfs_cmd, 1);
>   
> @@ -1498,6 +1506,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   
>   	/* Start threads */
>   	for (i = 0; i < device_count; i++) {
> +		prepare_ctx[i].fd = -1;
>   		prepare_ctx[i].file = argv[optind + i - 1];
>   		prepare_ctx[i].block_count = block_count;
>   		prepare_ctx[i].dev_block_count = block_count;
> @@ -1838,6 +1847,8 @@ out:
>   	}
>   
>   	btrfs_close_all_devices();
> +	for (i = 0; i < orig_device_count; i++)
> +		close(prepare_ctx[i].fd);
>   	free(t_prepare);
>   	free(prepare_ctx);
>   	free(label);
> @@ -1849,6 +1860,9 @@ error:
>   	if (fd > 0)
>   		close(fd);
>   
> +	if (prepare_ctx)
> +		for (i = 0; i < orig_device_count; i++)
> +			close(prepare_ctx[i].fd);
>   	free(t_prepare);
>   	free(prepare_ctx);
>   	free(label);
