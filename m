Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2205F5B9735
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIOJOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIOJOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:14:11 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB46E99B6A
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjFutMiQ6SqsD8lRUEo3Ip48akS+rSHN9WZCeFiQ2myTK+vWX+vaNJ6Lnlvx+mV+WKYXdZ/vVhf0Rr9Pr1JwaNt+xI8iOcwOu2M1I9Ew+FKZcIBIt2TcQuaAIkLl3jlwQKtIuLUcqCLHxgn8AaL8n4Yy9OpDHcoXRvtvpzYvOdTsGrZ3oTPSJE5X6GXTsgkoMACN4GXMYmWnt2FTh3CyzTnp6W38yXQqvuq333HS+UA8YYkRwzt6Gh0Xaod3iNJ2In5c4aeNece/ey6MG72hT/tvkcPkn+9CH6SJTvdanfgT8H3kCxTtZORCfVUmyAH/1mIRYOlbXqQkdMlXO4X4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJMoAFktcjB0DlqVns8C/kZjjCaHXGmjIGJ7AFADoWU=;
 b=CKrbwPMj15WRKJYv7nKNEXkVvHpTRy5fjLF6atAOXsrj6pppZI5aFrVnaYnkZywgRg1jAogjzQ0Q11742ICaYeMF440jLsKIYfZStnxlOh/uctUZnFH5kZNsgy9U0dTyWnfisVEyNxFeiry3s611MDIm4mw8u8wcVuw/dvIDOobN7L4ET0MXKBH3ZFOAgDWPdUlTW+Bc6vosWdfjUlxIeuEV12dST3xDqhafwUxXtoZKQXyMPgI44ZOWt7w/nn+sOr3Oy6gdYyCotX7foiLG7mzMK9N+VlzlwCrnRXtrBwmloh9Sn5j3WDuQ15w9AlKdzNuLWJePF6WxpvCQRUIlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJMoAFktcjB0DlqVns8C/kZjjCaHXGmjIGJ7AFADoWU=;
 b=d/crbDNmPtozmryxwyH0z8K8y+2OjCItJyR9YdfcY/24cTyLu0H6GCM8Ffo4KWg0wOYxyR7PuO1GQg9EfC/bAJ5qPYKBoFx97EmtqgXNVhZXExMM4udP7BbLirwgXYQ2x1nTMkAxl5KNnf9QeP8e/ZGoVSJXWQ+vG5F2tRApVN/yXZqFOawwnqLJra+TsmE8i1Lq/buYo0spsc6O+cCOJazF8f1DsxygvWRzPPfWLgwWEG7xuYil+ypGgifD4HOrmz8nh2GcnWCinfMe2yYsWoBUXniEVJocuDD3XR98qeThuaOlwy2LCwtT0RhZeahNp9k7bPFyK3wtQM6hP7ZDxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7756.eurprd04.prod.outlook.com (2603:10a6:10:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 09:13:27 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:13:27 +0000
Message-ID: <2b855409-a51a-29b9-3aa7-2e6e65d50e30@suse.com>
Date:   Thu, 15 Sep 2022 17:13:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 08/17] btrfs: move discard stat defs to free-space-cache.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <5e7f34e068513a3a82b3bc810bc92a0eb0254863.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <5e7f34e068513a3a82b3bc810bc92a0eb0254863.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:510:4::16) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ec98e0-d23e-46f1-5016-08da96fa8cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvBrAMKMv0iqTIJiuj4aI1ITYYIhn03/TnXBmg9y19AkZLjQc68gBTfCia/1HVY2HowWnuASmurFgmKFyp3FGSWlpjdHdwqAEkr5vZPaCvm9w+kcjaz/IsFJX4cngpQBfwu8QK0TIpkDVBCgYfJa5AT3kVfF6oaXbxKtuUJWzYQ+FWUgK99aUCcWUW6z+069G66YcIsPITTjteDKVQigC13LSBbQSatFq87YqIitz6lXl7Q/cgR5UIIrFD5AfjOtPtmGu3WUOCu9UjsN++yt6oPgQoNOshdhZFB+LXEWB18PkuxL+ynCF2S1ThYB0lAsjH4wuRGz1RVLC4lFKy9yQG36SbG0ayECe3I7P7Hko3QPbkxFspsnqRH/pGvDoJbw0YsZhQxPYBuj2mc1OKKxBxbZj4BYyhwuIrlcg4Uv00cspuUFFfT8OiKIpmXbRZnNZxjGxQI5P00q/e0zVMzTJKKDb7B5H8Le94rAJjyTxsbB5T9D3yAU0Xt9yqPUYil6qSdwdkWDYYZBDwM8BuVDt9EHiRuQqC6UKri3DpPBLLD7UQZtg/iLolKjkyfqWnfyl1z2Usib5sbc3mEGNZ31ROPb7wnxJ9b6lAii1Kc69Iek1rr/Op1p5G9MiK2HSRjUcKvWmGEzBCRMFcKIIDjExrBtkW3fULX2zjJdWJn9+yP958n7fCXPtzjjOoyRbTKwFx1xnCzA9aIUNO5SGqpmoowng3qkI7yd8Vw4RXfX/pf6Mp9C26/i69eDVKiiyzHaensO7lSlLo1k5oYgqp52DvdTTPs+R8AMt6dtR7XnTVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(31696002)(8936002)(2616005)(31686004)(86362001)(5660300002)(53546011)(6506007)(66476007)(66556008)(83380400001)(66946007)(41300700001)(2906002)(186003)(8676002)(36756003)(478600001)(316002)(6512007)(6666004)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJjTTVvTGVRRUNnVHN6MnMra0VSTWpiUXU4dG1PMStObmFNaFRWRk1ydFli?=
 =?utf-8?B?Sk9KUk9kaUhYSEg5SStEMGJOdnR3RDlLS1ZqcHc2dG14K0xpODZ2QmtRa1Nq?=
 =?utf-8?B?azBJUkJmUkZ5ZEhkRkZBb3lxYnFjakRrSStaSDBvSGJNOVU3bDVVL3JwbWM4?=
 =?utf-8?B?NVRDM0pFSnFyaHNRTUtMU29VYUN5aDY3UUU5cGNlQUU2S0gwaTVHU3JlNjNQ?=
 =?utf-8?B?dGdJK2JOTUUzSy9waG9Yb3V3V1JlOGpSUitYK2NBU1BGaW83OStsdWpYZ3Ji?=
 =?utf-8?B?Y3FQcHBDdk1ZcU5Xc0EvTjY0V01OcWlJbEc1cjNscDVnbk1nRzZxdTc5Y3BG?=
 =?utf-8?B?Sk5kRGpOSk5oMXd4a1BuM3RkOHQ1MEhueVNwNTlzNmYweEZvV0JpUkc1UGZV?=
 =?utf-8?B?THhobDlpc2tKcUFFVTB6RGtNSm5XUWlXek51QUlOYkw0SUNDY1p4OVQ1U09z?=
 =?utf-8?B?QUFLVnZXNWFzY3lWdXpwRDNUbngvSStaZE54akdsUlY4aEE1bTNrUytRY3RU?=
 =?utf-8?B?N0pwNjBTZU1DRnRYYmxxeDJBTjBZQ0pYWkZxYjRmOXFUbWFJY2RJRTNmOE1R?=
 =?utf-8?B?eXM0Ylo1V2NDYmtGc21ZK2xQSDRJUkRjeHEza3VPdndMYk1OYnpBL3d4NW5r?=
 =?utf-8?B?K0VuVmQzY0xBd0owWk5NbW9KaXBQN1VVQ1lOV2N5dWpkWXhOejU0S1FnTE52?=
 =?utf-8?B?aG5xVUdDUDBnaEExSGFHZ0o4YVVSang0Sll4dko0bEE0emp2QXNQaTBNZ0k2?=
 =?utf-8?B?MnM5bFVlNnh5M3FETWlwT2JHZDNyVXlNNi9mS29qdEtJSFllWWRhbjRsVC8r?=
 =?utf-8?B?eS9kdDZFbEY5Z216R3VwYnRVSXJOUWFiQnpxSmswOHE0dW54ZXd3UEROQW83?=
 =?utf-8?B?bUZVS1M4aWF1bGRkeVlxeUhnVjkxQldVdDdzblNEcHltQUVUYmJ6VW9Ra2Zn?=
 =?utf-8?B?MUdWUzZIaDJpQjVLVW9Ed1V6UFZtOXlLaHhhMWQrYVhJelZleHNueFZhVzRB?=
 =?utf-8?B?VkN1VWVDMHdHZlFsaGgzQzlVV0x6MmlWcEIvNEJOQWNnQXd3c3M0Z05KLy9P?=
 =?utf-8?B?a0xSNW9wbWExQk9BcmU2NHZkQ3BIaXJyVGhoM2E1dy9FZ3dJd3VzQVZjR0I5?=
 =?utf-8?B?OUJoelQwYkJFTzhxVWNYSWZ2Ris3LzdjSGQ0WUJTQ25YVUlOd1hJaDR5Z3BK?=
 =?utf-8?B?bHJ1L3kzMkkwQXJNVmU1NGUvME5qTk4rS2ExcEdKNGRRdkJNdE9hS1NmZGNv?=
 =?utf-8?B?MlorZ1oxMUROdUU0RzNvUGJIMGVpSmNaMTFqWWpZTDlyMXk3OFdXUUJNc1Mz?=
 =?utf-8?B?Mng5WW1PRnN1SXMrN3pVeGJOTGRMTUdoWThXNGVwaGFMR056V1g4LzVrTUhl?=
 =?utf-8?B?T3ZINGYwVHQwQW04aHQ2TUJyS2tuVFBobFpxRmpkeGpoUmNCUWZWZklCQUJT?=
 =?utf-8?B?dzZua2tjWU5jRS9rcGgxM0J2SE1FMHhPUVVMaXZ0aDdoUkJYUlZKVCtvQUt2?=
 =?utf-8?B?MERYQnh0Rzlzc09SRTRRcFE4RXpOb0N1Y0Nwa3lqYU5lNGgxZHJLRzZXOW94?=
 =?utf-8?B?U0JNTTZOTWVVdzFTdkJEbTkyaGFjRU5WaWpFRHlVaHpnV3kvclpIV21XL1V5?=
 =?utf-8?B?eHYrT0Fqc1JKaEthYlphWEt0NXYwdit4czhTQnRBdk1qV0xXemVwSXZNa2FY?=
 =?utf-8?B?Sk55Vm5zalJjV0kydXZMV0J4TTk0ZnUwREYrdlRzcEYydGdkL3dpd2JYN1RW?=
 =?utf-8?B?VkJ5VWIzendRUk5mQkFsVVJvUWk1dkZENWpxK3NUOUpHM3VFaW9xNzZaVkNL?=
 =?utf-8?B?QjZneXBGbW5KTFNHOFJ0dm9Fam5ENElMblJtRjU4TWJUKzhQS2VHcE1GSzRK?=
 =?utf-8?B?SGZIOS83Ry94cFljRGhFNk9RVXpYUVVIYWRiMVVKUjNSWHh5RUxaSCtSV1ow?=
 =?utf-8?B?bUE3OXVieFlqOXdoeXZGWlpNbkk1cG0wbldwMmdLTWxiejNuNUhtQ1Y3cEZB?=
 =?utf-8?B?aENXR2VjY2NJcjE3RmdRTGphd1ZrUjlKWEV1d3dkSUVrZk1qZWhFS3JkZkFR?=
 =?utf-8?B?Q2dCSWVNQW5tbVFDNnd0NGpWSnorZzdXeld0Tm11V2V2clphdXNOQy9MWkFK?=
 =?utf-8?B?OThxNEptNzdkYXNNWHhKeVN6bkV4UzRKNGlHSFdsT3FaNTY1d1AyT0tqdHFs?=
 =?utf-8?Q?0yfAGo9YldIlqTGdP7GkCX4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ec98e0-d23e-46f1-5016-08da96fa8cc5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:13:27.6279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwJ/Qu7nzFfycof6TlTT3cuPd0XTZggPcKoKfc46sTReljflbTrReh0lPME5gHHM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7756
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
> These definitions are used for discard statistics, move them out of
> ctree.h and put them in free-space-cache.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.h            | 9 ---------
>   fs/btrfs/free-space-cache.h | 9 +++++++++
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index e1ec047deff6..2e6a947a48de 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -58,15 +58,6 @@ struct btrfs_ioctl_encoded_io_args;
>   
>   #define BTRFS_MAX_EXTENT_SIZE SZ_128M
>   
> -/*
> - * Deltas are an effective way to populate global statistics.  Give macro names
> - * to make it clear what we're doing.  An example is discard_extents in
> - * btrfs_free_space_ctl.
> - */
> -#define BTRFS_STAT_NR_ENTRIES	2
> -#define BTRFS_STAT_CURR		0
> -#define BTRFS_STAT_PREV		1
> -
>   static inline unsigned long btrfs_chunk_item_size(int num_stripes)
>   {
>   	BUG_ON(num_stripes == 0);
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index 6d419ba53e95..eaf30f6444dd 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -43,6 +43,15 @@ static inline bool btrfs_free_space_trimming_bitmap(
>   	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
>   }
>   
> +/*
> + * Deltas are an effective way to populate global statistics.  Give macro names
> + * to make it clear what we're doing.  An example is discard_extents in
> + * btrfs_free_space_ctl.
> + */
> +#define BTRFS_STAT_NR_ENTRIES	2
> +#define BTRFS_STAT_CURR		0
> +#define BTRFS_STAT_PREV		1
> +
>   struct btrfs_free_space_ctl {
>   	spinlock_t tree_lock;
>   	struct rb_root free_space_offset;
