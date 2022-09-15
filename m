Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089045B970D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIOJLE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiIOJLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:11:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED85F115
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh2JdL86VSTkvOWY2JWwW2yT6XiMzCZozrrIzVEoZW2U0qLR++Nj2Pg+WGHOuAcEczc/bLNn7IRfTuIjgC2d6OhCeeY43yJTmlVI6k78wbCkxTnuZmu99vaK49HQB06Zjdf988o713XZFaGtOdWzHON7ea9g0d+lDz++ttJY20ozcJtPD4vSmD3fwqVVVfC1xZVaGemC59vTY9up6Gy3uelr3cYrxVB/Q7yWEykuW1x6gGb1qsczZxxDNX4CPoMo7yjF/f5yT/5R6zAX8BCBscHOUI+t7dVCCoV4zSV0of84HSBBtqn08QmgtTLPDhUuwpZvCuW01a0AwgLKuQUgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmThLNPg2qrPiPJtflwuoWnUXrHv+aEWuzIw1vu58bE=;
 b=XhlXUqJTsb8h2OP7xWcY59PmsuPisJKIdybyylr+HxD3rGtn1R7D6okaP5wpaK2qyTVFpXtsQ+QIJqUtRxSjFUj6LIFBVVf/yzsJMc9v6LXGB7Wz0fgBNwMAFKtxkImQ+3xqVq1HUm3u18uF7SH+BAdhY5w+SULQKhSGf0hIRSgc1DXYQXJIW1zLiDVrmxKCyAKtHF4meNiveXi/NT5IPvToZxv5EtxExEBbN8xxc4lHDUYKAxXmNKlPwsnxtTHw35NbeFBWlAcE/BkQ/9sQwlsLNTf5fXGt5Rniju0y8eMWOa2JvlTjj6QvudObBjfo3AZDIsnOT23S3Bz1KeTngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmThLNPg2qrPiPJtflwuoWnUXrHv+aEWuzIw1vu58bE=;
 b=mONtinDlel/h7FWEzmDGJJBKXAXzJ9G02YDKqbmhp3R0mH2gDjT6yoriEG470kw08+YaSzdBt1ldXSr6+1EqNbJBqrtGv8KKtXsgkS5F9Fl0qMEB1a0ZDYvv19yd20Sb3FmqvY+BBSh8q7jGTmYezavb1HEXjBryTA2uyXcIbafSl7Ir6jUCEaJS/at2vuVd70uFY5G7+hPQvgtd3AVVSwHG7OHqEAK0K5v0/TYe6tYapm+VXbOa854zWrjlYzYxUR1UHNCHaVBC+7RvW7E6WIqbcrG7MT3qzGlOlivZWaPOS2vDu4L3xw+oA8ackB7a4qdowmNe5jfWovH2kTN//g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB8662.eurprd04.prod.outlook.com (2603:10a6:10:2dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:10:56 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:10:53 +0000
Message-ID: <56b893d8-aaef-a556-af16-7a323e9f51a1@suse.com>
Date:   Thu, 15 Sep 2022 17:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 06/17] btrfs: move maximum limits to btrfs_tree.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <e0640b40762be99c72f7bfbb295431d405624f1d.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <e0640b40762be99c72f7bfbb295431d405624f1d.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:510:4::7) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a75e8d-cee9-4100-0011-08da96fa30b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKvAuDdY9VfmttJDlnukDbUCdDRSyosxWdBTscqBNJIMdDLloVG2YGWB5wiMV3T39vJHU19z6wLnoMKZxeCJm9i5NwazYirwJcRM+DpI8zca2ePyCYS6kSGx0JmeKVUJt1i8aEJWyiLsuBiHF5ylR7lquMgQ73+/rhZlxIWv9ZLuHRTNPfYeL99SRmKYqpxbQUPhJxE0HRtohtaWhpRKwBGI39Jw01qYdvM/P4l6BDaUwbYXU8pPMneWUBx2fP/yjOwFuc2iw1Ggs87bIrhsvLYL+lohyweJ56fPh+iK3Sc3lxI/9XYwxTxNyraQSxszJ/24rQqQgpvP+hqefVQH6Kdi5HyOccFQEDunMLg8FISoNmEYg9uCivqtz11o2NUrUN9PfampaNO+EuAv49R/0fkbubwjs8Cod3gOmpSdStwUhYK8fnqoEgxtqeDXkeC1Xlqo3nKQuhIf9M0ymEzWFTuwW96J/nlwO2ISG9L088xWKliz9hffAhPf5iINR+AJgKKLQtFUAoedi9tAjpgQythwX4scsvqdPJKjrfIYAuksOqyvGOZ4jCn2+6trbFRsIA+aQP16vD9fOGTUeUEbQg8PM2ZckZ8o60BkkWQxYYe0tGASmRuE3aLP/VGq5yptOwcrAoiDo7t0pxJ0vLLU2YbLq+Rf/l3uEqykxsNyD0q8Yy3NrPjrW6+uCWzDjQ5aAOAN42GJMcr+eT/MFHo/af7CmGtSHpKHRd/ZwG1ASNONsZLdKnFjv2Vc1eBWmllWNP9HVItA5GwHmZNbFgbmdjyjES8Zct2f/uVI+ohVxKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199015)(66946007)(6506007)(31696002)(53546011)(66476007)(86362001)(66556008)(6666004)(5660300002)(41300700001)(31686004)(36756003)(2906002)(6512007)(38100700002)(478600001)(316002)(8936002)(83380400001)(6486002)(8676002)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWQwWjI5aEEyRTdMcDFkTTNIcW5BQ3dWRjhjdkVwU2U4RzBTS0VZUmswdGdM?=
 =?utf-8?B?Z1ZnemVxWW5sc3E2djh2YTN4OUE5L21QRitwRHljYklSNFh5NVVwcUs0Mkg5?=
 =?utf-8?B?VUVRR2VMdUZJVmhheUt6KytPNHZ6eWNrSmdyVWQ2ZFJ2dGVURDY0MlFEWml6?=
 =?utf-8?B?WkhHKytPUi83bWlHSFMvYXludzEwcVo1TlYwVkhZUDZtRlNEU0RUbzQrS2Fu?=
 =?utf-8?B?bW8wTEpDM3o2NkgwQ0pCK1MwaXgyM0RTYjFzSG1sdUtsZUU3UlVpUC96L3o4?=
 =?utf-8?B?R2U0N0xYQTFBK05pZndnYkhsREM1K1E2SXo2TmFTWTdZNHp6TDBFbE1uQVpy?=
 =?utf-8?B?UW1hYXZIaTdscFB5Y292ckVZdlNpSTByYXJiQlBxa0RkV3BnUjNpVkcyNHhX?=
 =?utf-8?B?NFdyUDVUTlBzc1Y4Ym1wRWIwTGg5MkgrYU9Sb21GamRseTVIYlVDNTNjRHZO?=
 =?utf-8?B?TitnenFwZFQrbTlmK20wZENnd3kyTFhqMldxNVFRMTExRUZFNFNldm9JR1JP?=
 =?utf-8?B?V0FNMmw3Tm9ab1NUWkVvVDJHaW05SzF5bUVRbU10YTU3dmtSSS9aMmFnRU5L?=
 =?utf-8?B?YXhjclVDcnNSVXJnbXJpZXNsQ09UdlJpY1hYV0V1bUJIenI2c0ZqVU1WOWhy?=
 =?utf-8?B?Y0dERTZLREdySjhtSmYyaE0rMWR6V09TVXpKRlV3VG4wZVBUTFpNM0hpSUY5?=
 =?utf-8?B?eFBYZjR4WUk4NGZkS1ErY2dlWUdlYUppWlp6eGh6VTlkUGoyRlBZRVd1UlZM?=
 =?utf-8?B?OTVEVUZicnpOak14cmt3d0xRSzVEQWtORU1lL0lER08zQ0tnVnJheTRESHBx?=
 =?utf-8?B?UHBzRm9ScXFLS25LL1llNjVQVTJ5SnRsWElJT1ZjZVZkaEtJcWZaTlIxWFBH?=
 =?utf-8?B?WnViUHRjS2xHVzE2cXVLMmNEenc1aUNrVnM0TldmQm5idmRmYmJNT3kvWU5G?=
 =?utf-8?B?ZjZyb09RWWw3YytUa0ZsUWZJTjFZMmt1eGpvYVk1Uk1lN0pzejRMUnVVdnJT?=
 =?utf-8?B?KzAwTUM0OWhHTU5nanN6SXVvbjY4TmJ3RjNWT0pLNmNQUmlQaktaWnJYaHQ2?=
 =?utf-8?B?ckV1V25ORnBqcWZFeFpZb3U2ZGc1K1NOUVlsbGw2Z1VFUlBJZjIzOXQvYXRm?=
 =?utf-8?B?bHRmRE0vdklZTWFNbXdIZTU5VThPRndmRGNqVDYrMTI4WnVhQUFVMEdSODhu?=
 =?utf-8?B?N0c5MjJzUC82QnlzRzgzL3YyMVhGY3dEc0NQblZsSUJraGF0U3E3QXlTWjBa?=
 =?utf-8?B?dnJCeFNSYVpZSmYxbVQxczFaVmo0MW5UT1NBQ1NlaWVTanVRejMyQmNOR0lM?=
 =?utf-8?B?eDNaQ2JaTkN6U0ViSVhFLzdCMmxxeVlyWVlLb2Y2cGREQmVDdWZPSHdvbTQw?=
 =?utf-8?B?QjcvMHZPdE5PWjU3akprUXloQ0hYaFJibk1XYlNXVTRuUDhPajFwMi9EZ3d1?=
 =?utf-8?B?NUtLc1YycWlNU1lyaXNpOEhmYkE2S1hDeTJ5M1VRWWtiUVdZaHhDYVhldTV0?=
 =?utf-8?B?bVUwNnN6bUtUUlNJM1pVZXNQM0poUk81a2tMTmZqZjVxcnZMSXJVeXgvcFhv?=
 =?utf-8?B?NFYwa2NtNVBEUEhZWFc3cUpzQ0dqSTZKZGpBNkNGaFA4TlhHTFE0REVuM2xH?=
 =?utf-8?B?UzY4cWo2YTd4bjk3WkRpRDhhait0elE0K2dZNTFxL0JKajhiYU83Q2g0a3Rw?=
 =?utf-8?B?dkFSVjVrWEZWRlNybnk5QUM3ekxwTlpvZVZzaWMxdEdwbzFIUVZZTVl5YlhI?=
 =?utf-8?B?UWswZUNVUHdXbVJRd1FwZWFBeXhGSnMrYlhCQUNPOFB2cjJHM3MrVldrTW5G?=
 =?utf-8?B?dktVaVZYQWhqdnRFUlZnM1VjOWg1dlBESlhST3RQOE4wNVErWGJvZHQ3VmFL?=
 =?utf-8?B?VlNRa1drM2g4aG9XdzVoSzBTTU1IcG4ya2p0d1p4SzRmNmV4WjgzRUFZUzRP?=
 =?utf-8?B?U0s5R21uM1VrRCs1YTRDT1B2M05XNmJyWWtKOGNoZzloQjVxNVptUmNQMjZy?=
 =?utf-8?B?MGtmWTdaK3NlR2Fpd1lqNTk5UzZGMGJFZWs3VVVzRHBlN01UK1NTMHJXL1Ns?=
 =?utf-8?B?alB4ODhteDBNekFYcnZVT2dNaWsvNW9Id2hRQ2pWdFEvQnJpRkh2TmZXQ0E2?=
 =?utf-8?B?UzlyT0xIeUNwVCtsMXpLRXh0UDdGVGdjZkx3YjRVcFhJclUrM1RMMVUzRFM0?=
 =?utf-8?Q?JfaiDZeh5MZjG3q7kI1HauY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a75e8d-cee9-4100-0011-08da96fa30b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:10:53.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cHBP7tAlGNgAJMHcuxqGPEZSNutBmXirQQq74rmMLYuJLLQ1ZBQaCpUb2USrebb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8662
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 23:06, Josef Bacik wrote:
> We have maximum link and name length limits, move these to btrfs_tree.h
> as they're on disk limitations.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.h                | 13 -------------
>   include/uapi/linux/btrfs_tree.h | 13 +++++++++++++
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index c3a8440d3223..5e6b025c0870 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -63,19 +63,6 @@ struct btrfs_ioctl_encoded_io_args;
>   
>   #define BTRFS_OLDEST_GENERATION	0ULL
>   
> -/*
> - * we can actually store much bigger names, but lets not confuse the rest
> - * of linux
> - */
> -#define BTRFS_NAME_LEN 255
> -
> -/*
> - * Theoretical limit is larger, but we keep this down to a sane
> - * value. That should limit greatly the possibility of collisions on
> - * inode ref items.
> - */
> -#define BTRFS_LINK_MAX 65535U
> -
>   #define BTRFS_EMPTY_DIR_SIZE 0
>   
>   #define BTRFS_DIRTY_METADATA_THRESH	SZ_32M
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index e6bf902b9c92..c85e8c44ab92 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -14,6 +14,19 @@
>   
>   #define BTRFS_MAX_LEVEL 8
>   
> +/*
> + * we can actually store much bigger names, but lets not confuse the rest
> + * of linux
> + */
> +#define BTRFS_NAME_LEN 255
> +
> +/*
> + * Theoretical limit is larger, but we keep this down to a sane
> + * value. That should limit greatly the possibility of collisions on
> + * inode ref items.
> + */
> +#define BTRFS_LINK_MAX 65535U
> +
>   /*
>    * This header contains the structure definitions and constants used
>    * by file system objects that can be retrieved using
