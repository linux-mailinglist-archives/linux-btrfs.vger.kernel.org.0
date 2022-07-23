Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3057F20F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 01:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiGWXV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 19:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiGWXV5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 19:21:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178712A85
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jul 2022 16:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQs4mN2mKRZEK87CPz5G2c9aW9J+lS0kM3NG5Sa2zJbBt3LisyYorPjZsV0Ya5mqBlHAhX+UQw1QOG5X7LAOVG8Z9WsymxzpjhB56CDo5vIlQcWBOiiIx6R0zvFbQlFZC5zvew+cv4I4mZ/Bam4itQLKv4Rwf0c+NouQ0ZDVKQT8aKPZC29QWAveTE95CH9OQ3wyp15hvva1MzLPsy8F1MO1H0Ia2xQ/6kLldy5aNua99haBJuxIQgn9ZzLG/08DZI8aVAmM7LpQmYaLu63yp42xx9Sy1YM+qhbqjcG/9pCCJLfQxiC9cnfanEvo1k1S8M18h5lP0SrDfgIOL5IFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPqZSF8U8xQoSHMSmuQxEuvEYOAciGrHtgHesqCfbUM=;
 b=kfoYm5a0P/rZ3rTHoI78BKRsQHaCb5ieDsz+lsg18y2HLz7j6XKJaXXkiQPDRgsDjwA/euIs93kjKTmFKwZrW5xNc+nGLP2EkTZAivntFe1Uk9UKLiz0LmCnOceB0YijdgFrbBAeCccPoPt26T+xJHjfHUvAiyTI4NKYq6jqgMuHOhPdeiU9olQsYNbmWQ1U085QRPxz18SdP92NekAreXEPsk147y/3K4j6YW1OM+LIpkmijkBwcbpinOiyw3TvPdT8bgeuRch7U4fIrul7ztFYFU00NOBaFqCbcjBXccZ7A5VBMopHJCC6hhu2HbU2+y/nEhX9XBaAVNsuNonuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPqZSF8U8xQoSHMSmuQxEuvEYOAciGrHtgHesqCfbUM=;
 b=NisEOo55LXdD7TR79PKvby5gVoE3xVH+1DqqQ83hzsg9oFCyTVAQISNEMHcA3F4CMMQm5j3XrDxM+alUXsqEW72cuXL8UYsWSvbzgSDLge3Pe+Psk7aoKVh9xAnrmdjORsWzhzd5siQwWxTQYbjNo1iHVL0bo5M8rud0C5beSGGdvDn2H/WrJ/5Sy/bTH7VQEXFd/DNQ7Q6MCPA+Ui0EjZ/wVfAaWEd3EhA+3H4fWoCbbe04iOEpHPeePet1v042Xjq1lYRqoRylNJXg5V7cJOAi5RqWGm6jaz+F7wfb+p5stlz4gozsVq9Tw6TCluUG2jLJpVRaNZTUiSobB8zeRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB5616.eurprd04.prod.outlook.com (2603:10a6:803:e0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sat, 23 Jul
 2022 23:21:53 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f592:23b0:9094:cd33]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f592:23b0:9094:cd33%9]) with mapi id 15.20.5458.023; Sat, 23 Jul 2022
 23:21:52 +0000
Message-ID: <68debb4f-cc9f-ee01-71c5-ab5e7dff59ab@suse.com>
Date:   Sun, 24 Jul 2022 07:21:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1658577730-11447-1-git-send-email-zhanglikernel@gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs-progs: fix btrfs resize failed.
In-Reply-To: <1658577730-11447-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab8ea5a2-ffa6-4766-05b8-08da6d021f78
X-MS-TrafficTypeDiagnostic: VI1PR04MB5616:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +l2zoBlodQpWQWy0yZ29eouyDng2IydfaogVgSdmIqbYxcIkAK62LhSPMn7dSXmTvLzYkFjj9AZ8hRHMzgpchFQ2MmYNE1Q60BQZ8JGgkbMZI6p7KcInnBrO4Lp4d1jImEdNcOyxw/TuEesSZtkSU0hB38Ufj1x20dwYNgelo5/63hOawCt2UEJr5aMZw6o0/4a/+m/IHwsBD2ti4kyCVlFy1j+KEogu4s6z78nccYVcCJtZl+BhFplbsMv7Ojc4XcURqGC5rk6FWqfhX4R2Y4W1KYBdoIl/s08+QStAxivZie9A8qdp4AkO9EM67nVXz8vzkJGZI2DhKbiXD1GGLV9SWwKi88rpGOMpp8eeXDTooFtrx9CatC0tzRn7vYX0kU2UXgQ/rRJPSG6vVMa+gg2Aut7k0/Btjsp0e/R+fL1hZHG4Tkui0aj0CuTcpgIskUYXJMnNlRGIf9EkhwXOocLXteFNESCU0Dmm/nqPfLnOcg20w/KkspbCMGbYdqVhZQfsiWnttE/SeapiaEOXJEItc4ORjADk7Gwy5A/E0OPkETxGCoPkMw9w62XBbQzYAs58AeWMqQ7qNKvGwV+FOfYwdbSRc2on8ZfObxqKKV1DcQrtxA1rGfMB9C6lHPhrNutTSieTNDdmS/wvrmyYCr+KOR/ranggBKHTU5IRlzrxbUc+djC4KqRFrQepAKZpbfK3sRMerRKhhPIW0AA2clTuLMUBlDbG9P4pRfmTGu49+q5e4MZdCJ6ZxQIaL9XV49ZZpk8X8eL6qvXh+A/AmM2JW6R0finuYENWpUSGn1YHX8uR82BlkOnsqQxmOV6Y3aF71auuOVm2+hDPpCnt8v3ofYQp6/Pn6jIPqWqXZ9KIjcRN0QQ1TwZmOmNtgJl5ILjZSLmlkA2ng8WYKpxkYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(366004)(396003)(346002)(136003)(376002)(66946007)(5660300002)(38100700002)(31686004)(316002)(36756003)(66556008)(66476007)(186003)(53546011)(6506007)(86362001)(966005)(6512007)(2906002)(6666004)(8676002)(31696002)(41300700001)(2616005)(6486002)(83380400001)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJlRTQyRjQzUGZBRE1Wb1FtSFFKRmZ1QXpRVEtLRnBPS2cydWh4ejFjZG9F?=
 =?utf-8?B?R0hpVTI2d3cybnVVb3hvQU9BV0JiVkFhOXNZUzdtRG1XdHJIZHFmREdlUVEr?=
 =?utf-8?B?Z2YxZEJHOEhGSnR5U0xocmVUbUF4TmQ2bXZBQTNtTmR4MkdHN0FueW9Xekw2?=
 =?utf-8?B?SW56WEJtRTdZUnFybnFJbWNpTG0veTcyYkVvQWtBRDNEUWd0aGsyWHhCQm1D?=
 =?utf-8?B?UG1rKytJU04vOTQzd08zT3ZPR05ma283SG9BUGVkSi9LUERkU1I2NG5lR1Vh?=
 =?utf-8?B?R1NYZ0xKVHExWHB3NWhhZ2NSVUk1a1A0YVk5ZXZxS1kzMG9DRHpMQVF3Yngv?=
 =?utf-8?B?OGkzK2NvT2JoNXVHT1Fmd2VkSE1MeTdlOE1GL2RRUUNNQkpIOGd5YytuRWRL?=
 =?utf-8?B?eDVzcTg3a1ROSnhUTUliRmMxM1ZzQUpkRFhrNGRvWlFpdVFpZ2ZkN3VIa2My?=
 =?utf-8?B?bXhYdEFXZ04wL2dKdzFaYlkyVHI0VXl0TGxoVWxsKzJzd3ZsLzlTZmJiWU16?=
 =?utf-8?B?ci9wdkxNek1XNGhpa3lXZmVEQlJBeTdiVUJLR2RKdWppVzltSG9GTVEreGhO?=
 =?utf-8?B?anM1TnlMMlYyTjd4K25zV01XNGhlUCtlRUQxWGd4eGZtWlRlTnJscnpOOFlB?=
 =?utf-8?B?NHZHTjZwNnlYcHlGV2RiTkZUT3RMTkgvM3cwb1JzUUQwWDFUMDFZM2hRNzJt?=
 =?utf-8?B?eVdRSFpHc3BMVGhvOWZyQ3BFRDlyQWErNkowNER1ZzVDeUpRNXcxOUN2eFdL?=
 =?utf-8?B?eFQzOFdxWWtXNGRZN1hveHVsbCtqUXBCVUZPTDdZUnBPc1BsUE9zUm5tR29F?=
 =?utf-8?B?WUxmQStIWEFVa2Z3MjMxanRKejhRRnpjSklzVVpsbzdGNGFYdXltSHdFcG94?=
 =?utf-8?B?RUlNcmxxbFdSeWpReWZxT3pKZzd1TXF6dmN6UzVoOHg1bHRXMmUvMi8zU1Zl?=
 =?utf-8?B?eXdCTXZwd0p0amZPaTJFOU8wWk9LZmRrZ2UrRWkrUXBZSGRaOFppTGhvRERO?=
 =?utf-8?B?SVczWERscTdZUS83VHpPOWxObUZENlBlbE5Va3FlVjhvdlVZSGNpTU1sMzFU?=
 =?utf-8?B?aHR6b01BcWI5VXhLOThzaS9WS2JSdXA2VW4vdVNldTFQYkR6QkZQSnNCTGFK?=
 =?utf-8?B?SnZUYndtNVVlOU5sSXNKbEFMLzRyM1pVTHpnRHhPQ0VWcUVJM2pQbnF2YXJF?=
 =?utf-8?B?WGYvQ1pGc2VLZEErVVQzcFBTQjMrRTdIVllkRFQweUUzKzg1TzJrdzF5L0lO?=
 =?utf-8?B?ZUhSVXpIaDNmUldWOGVnM0lJYTVUazBrL0xCaGVpak1wQUZNdVF3MWFMKytz?=
 =?utf-8?B?NHlwNGYxT21qNDhSaEtHNjhLNjI2QzVRK2xTZkdiUEt4MFpNUjk4b1dMY3lj?=
 =?utf-8?B?WHJCS0tPcFdiUG1jUUVSb2I0cVpIanZ2cTY4QmlBZG9ENTNEVEpBU254b1N6?=
 =?utf-8?B?S0dOdnVxWVowYnd1QlRqK1A0T0dBckRmU2R6QWw2N2tMWE5DL2dNMU93d0pv?=
 =?utf-8?B?RDhtTjhjSEc5OUdqSm1VK2pUREwzZzNUMnVxM3dsMWpTckMvZW8vbTVwK3U4?=
 =?utf-8?B?b0ZLUUtzWVZuZk95b3lmM1BjU2llSkJpbHVUUDlERE03OXdDb2kwOTliNFNL?=
 =?utf-8?B?ekRKc2dNL3BpdjlETmdTMFUySEdNK0xkaHlJNzkxNjFZa2dEc1VEMVRHZ2hn?=
 =?utf-8?B?MmU4UXJiWVRVKytXeDBQVmJ4ZnkwSGx1cFFPSERZdHhVOC95QXlac29HV2NN?=
 =?utf-8?B?dUpBYTdJdjUyNVRzQTFRdUE1NEkyNjFtb3BrdE5uRXpSSlhuRFh3WnYvdmNp?=
 =?utf-8?B?VW55a0EyYVpGRkxCYlFMU00yczZYR01xZ0hQWDJVT1pGSFpWN0VxTzdOcVlw?=
 =?utf-8?B?WGJXQkQwS2tFeVMyRHlsYXVpQ3ZhbUxnby9yaUNPOGc5KzhFMEcyY0p6WlRJ?=
 =?utf-8?B?eXNXT09mcnlsRmgvMHJoeWx4ZVQveVc4dXhOU01TTkxBcFA0QXIwdERQSnJu?=
 =?utf-8?B?dml2ZDFNbFd5UkRjRXdoalRPaVRFN295S3M2U3RKWk5tdkVEL0VSNUtKdEww?=
 =?utf-8?B?WUFyYnRKdDI5aFUvSXl1ZUFGMGpPa29WYnlNMm9oR29BbW0zWW1FOGdWYUhJ?=
 =?utf-8?B?UlJ5TWtFMVRPQjcybHpWU3lzaHdzZllJdzJkVk1saFhwaGtKOVB5Q2hMY0FC?=
 =?utf-8?Q?f1X9Qg0MiPUrd4VI03WQO8s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8ea5a2-ffa6-4766-05b8-08da6d021f78
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 23:21:52.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3Wm5baQNvGWS2r0lpbQwnGPWBbV+HJgTUsF2SNjnE/Z4OvZ5Q+Bl+7N1cj0pNuV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/23 20:02, Li Zhang wrote:
> related issuse:
> https://github.com/kdave/btrfs-progs/issues/470
> 
> V1 link:
> https://www.spinics.net/lists/linux-btrfs/msg126661.html
> 
> [BUG]
> If there is no devid=1, when the user uses the btrfs file system tool,
> the following error will be reported,
> 
> $ sudo btrfs filesystem show /mnt/1
> Label: none  uuid: 64dc0f68-9afa-4465-9ea1-2bbebfdb6cec
>      Total devices 2 FS bytes used 704.00KiB
>      devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
>      devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> $ sudo btrfs filesystem resize -1G /mnt/1
> ERROR: cannot find devid: 1
> ERROR: unable to resize '/mnt/1': No such device
> 
> [CAUSE]
> If the user does not specify the devid id explicitly,
> btrfs will use the default devid 1, so it will report an error when dev 1 is missing.
> 
> [FIX]
> If the file system contains multiple devices, output an error message to the user.
> 
> If the filesystem has only one device, resize should automatically add the unique devid.
> 
> [RESULT]
> 
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
> 	Total devices 2 FS bytes used 144.00KiB
> 	devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> 	devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> 
> $ sudo btrfs filesystem resize -1G /mnt/1
> ERROR: The file system has multiple devices, please specify devid exactly.
> ERROR: The device information list is as follows.
> 	devid    2 size 15.00GiB used 1.16GiB path /dev/loop2
> 	devid    3 size 15.00GiB used 1.16GiB path /dev/loop3
> 
> $ sudo btrfs device delete 2 /mnt/1/
> 
> $ sudo btrfs filesystem show /mnt/1/
> Label: none  uuid: 2025e6ae-0b6d-40b4-8685-3e7e9fc9b2c2
> 	Total devices 1 FS bytes used 144.00KiB
> 	devid    3 size 15.00GiB used 1.28GiB path /dev/loop3
> 
> $ sudo btrfs filesystem resize -1G /mnt/1
> Resize device id 3 (/dev/loop3) from 15.00GiB to 14.00GiB

The new output and logic looks pretty good to me, but still some small 
nitpicks.

> 
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>   cmds/filesystem.c | 63 ++++++++++++++++++++++++++++++++++++++++++++-----------

Shouldn't we also update the man page of "btrfs-filesystem"?
Mostly to make it explicit when we can skip the devid/device path argument.

>   1 file changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 7cd08fc..c26ba2b 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1087,7 +1087,8 @@ static const char * const cmd_filesystem_resize_usage[] = {
>   	NULL
>   };
>   
> -static int check_resize_args(const char *amount, const char *path) {
> +static int check_resize_args(char * const amount, const char *path)
> +{
>   	struct btrfs_ioctl_fs_info_args fi_args;
>   	struct btrfs_ioctl_dev_info_args *di_args = NULL;
>   	int ret, i, dev_idx = -1;
> @@ -1102,7 +1103,8 @@ static int check_resize_args(const char *amount, const char *path) {
>   
>   	if (ret) {
>   		error("unable to retrieve fs info");
> -		return 1;
> +		ret = 1;
> +		goto out;
>   	}
>   
>   	if (!fi_args.num_devices) {
> @@ -1112,11 +1114,14 @@ static int check_resize_args(const char *amount, const char *path) {
>   	}
>   
>   	ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
> +check:
>   	if (strlen(amount) != ret) {
>   		error("newsize argument is too long");
>   		ret = 1;
>   		goto out;
>   	}
> +	if (strcmp(amount, amount_dup) != 0)
> +		strcpy(amount, amount_dup);
>   
>   	sizestr = amount_dup;
>   	devstr = strchr(sizestr, ':');
> @@ -1133,6 +1138,24 @@ static int check_resize_args(const char *amount, const char *path) {
>   			ret = 1;
>   			goto out;
>   		}
> +	} else if (fi_args.num_devices != 1) {
> +		error("The file system has multiple devices, please specify devid exactly.");
> +		error("The device information list is as follows.");
> +		for (i = 0; i < fi_args.num_devices; i++) {
> +			fprintf(stderr, "\tdevid %4llu size %s used %s path %s\n",
> +				di_args[i].devid,
> +				pretty_size_mode(di_args[i].total_bytes, UNITS_DEFAULT),
> +				pretty_size_mode(di_args[i].bytes_used, UNITS_DEFAULT),
> +				di_args[i].path);
> +		}
> +		ret = 1;
> +		goto out;
> +	} else {
> +		memset(amount_dup, 0, BTRFS_VOL_NAME_MAX);
> +		ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%llu:", di_args[0].devid);
> +		ret = snprintf(amount_dup + strlen(amount_dup),
> +			BTRFS_VOL_NAME_MAX - strlen(amount_dup), "%s", amount);
> +		goto check;
>   	}
>   
>   	dev_idx = -1;
> @@ -1200,10 +1223,11 @@ static int check_resize_args(const char *amount, const char *path) {
>   		di_args[dev_idx].path,
>   		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
>   		res_str);
> +	ret = 1;

Previously if we reach this path, we should have everything prepared and 
return 0.

But now it always return 1, is that expected? Especially the only caller 
will just error out if the return value is not 0.

>   
>   out:
>   	free(di_args);
> -	return 0;
> +	return ret;

In fact, this turns out to be an existing bug, there are quite a lot of 
existing paths setting ret to 1, and goto out to return error.

Those error paths are not properly handled previously.

Thus changing the out: label to return @ret is in fact a bug fix.

Not sure if we need to split the patch into two, one to fix the return 
value first, then introduce the new behavior.

>   }
>   
>   static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> @@ -1235,8 +1259,10 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>   		}
>   	}
>   
> -	if (check_argc_exact(argc - optind, 2))
> -		return 1;
> +	if (check_argc_exact(argc - optind, 2)) {
> +		ret = 1;
> +		goto out;
> +	}
>   
>   	amount = argv[optind];
>   	path = argv[optind + 1];
> @@ -1244,7 +1270,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>   	len = strlen(amount);
>   	if (len == 0 || len >= BTRFS_VOL_NAME_MAX) {
>   		error("resize value too long (%s)", amount);
> -		return 1;
> +		ret = 1;
> +		goto out;

This change doesn't look necessary, the new out label is just returning 
the @ret value, not really worthy a new label.

>   	}
>   
>   	cancel = (strcmp("cancel", amount) == 0);
> @@ -1258,7 +1285,8 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>   		"directories as argument. Passing file containing a btrfs image\n"
>   		"would resize the underlying filesystem instead of the image.\n");
>   		}
> -		return 1;
> +		ret = 1;
> +		goto out;

The same here.

>   	}
>   
>   	/*
> @@ -1273,14 +1301,22 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>   				error(
>   			"unable to check status of exclusive operation: %m");
>   			close_file_or_dir(fd, dirstream);
> -			return 1;
> +			goto out;

And here.

>   		}
>   	}
>   
> +	amount = (char *)malloc(BTRFS_VOL_NAME_MAX);

No need to do the type cast, (void *) can be assigned to any pointer 
type without the need to type cast.

> +	if (!amount) {
> +		ret = -ENOMEM;
> +		goto out;

The same here too.

Thanks,
Qu

> +	}
> +	strcpy(amount, argv[optind]);
> +
>   	ret = check_resize_args(amount, path);
>   	if (ret != 0) {
>   		close_file_or_dir(fd, dirstream);
> -		return 1;
> +		ret = 1;
> +		goto free_amount;
>   	}
>   
>   	memset(&args, 0, sizeof(args));
> @@ -1298,7 +1334,7 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>   			error("unable to resize '%s': %m", path);
>   			break;
>   		}
> -		return 1;
> +		ret = 1;
>   	} else if (res > 0) {
>   		const char *err_str = btrfs_err_str(res);
>   
> @@ -1308,9 +1344,12 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
>   			error("resizing of '%s' failed: unknown error %d",
>   				path, res);
>   		}
> -		return 1;
> +		ret = 1;
>   	}
> -	return 0;
> +free_amount:
> +	free(amount);
> +out:
> +	return ret;
>   }
>   static DEFINE_SIMPLE_COMMAND(filesystem_resize, "resize");
>   
