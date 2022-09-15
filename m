Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3145B971A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIOJM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIOJMU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:12:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136E298CA4
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj6CNSg5m3ILSuwhgOILBN5266Yi65fdQr52x3XZ6gXX2/y8ebyxbCrH6EY8Sn/XhOCq6+41TkBmf59RyRB44oVVCVK9O0C8R71WKnp2GWPdWN8+93tcAamp4QpYzk/vbcvUnRQkp3TY33CA+1YNHQ7GYno0fjt/hfbuLwBghMwCe8U0Ix710gXvXA2An2Ly2F1RSgUYajPi6AO1fK33IwqUm3xX8iGOtKUyIrsGLtqt1TpdMEJQSHq/B4EHEg5IHdQdLEzqWbHVn06EDAYvwAgE70xzH3RMoQap0ItFxVBxzkek/yMPooVE/T0YOVgbAvZ2WihW3j3vwx2GpGbCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg+AMoFdsUOctqnP9jCNf1+rHyCNZPI5O97LJf4V4Us=;
 b=iyaiiEuu67+HlVW1f4UmPtKdJz/1+5GLPqDjq8s8heSde3zpZZ7x+AbieE7qUDHMENO2FwvcDFXgekxPbebS9R7rhUpDMnZF1dHlvHrVznxPuOUKu00Wz7BRTZeUxqmJzcTOhhRqWcaEa+ChwkARGJ2wMAd2NJBJ5lcLT1LyDIegqLPy+KuSWxMnc+BbWuBaBZRZ9U9A6C2ftN37N/Qk4yp6a3UUdTFkHZs2W4h43LNYzPvzXsyJEmMT/0TDeJXM8a3KgFItpiRIyYHyTVxVQBxpLikILQtY5pUcQ1lk9lrcIfto5I9kIdKN/oe+HY3q4dDj8cD0T/AG9PB1QVhThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg+AMoFdsUOctqnP9jCNf1+rHyCNZPI5O97LJf4V4Us=;
 b=yvZLDGDF3Hx9yUz5dbWFvJWugwe1/xjvO5Fk1k8Dh1a0qbAt3l13dmjv6hSjUoAlgeNthNhRB83TbE3Kr7Bn65rY5PEhyiTCuarA5DBulrtNvX/4HhY9RpTyFE4RD90Gzpliqh5i75w01pE6vMuQp2Hi/3ugJKYqw1jGR2DHqPKZLpVL7JTidsavC8tr5Lku01hJ0qum0ZdvBnzCEfJ9G3L8fvJ9odwzy8iA3WZvIr7tSZx3dtqogu3jFi+S6fQdi53uDRfXFA126dBOVgn4pjtW8UyqIVI0Ok4yRd+cpw1Rk9KaNwOF+pVewWZXvXaY495Zo3BMpCtTtVzGj6uRWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB6846.eurprd04.prod.outlook.com (2603:10a6:803:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:12:04 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:12:04 +0000
Message-ID: <732e8497-5de4-b29a-e625-161e04538e2a@suse.com>
Date:   Thu, 15 Sep 2022 17:11:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 07/17] btrfs: move BTRFS_MAX_MIRRORS into scrub.c
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <37fa62e6907f1eff71e2c77b9dadb324a408d9a2.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <37fa62e6907f1eff71e2c77b9dadb324a408d9a2.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VI1PR04MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: df11259f-044a-48bb-6d84-08da96fa5b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjtvPaND2cQXp5lPUDGUnPjho5GBBPdWOHIPMMlBIFsSRUDK14VbuZXEn1YHJ/4X72nG2nZg8p3ABH9VhWqkXgO0l0wYqqQ6I7Kx91TCPuSJWXiNdmB6kCzGtlfCJwhLsbYH77GHs18TH8dUFVKx2XndL6OtSzrJLimgf5BD9UOdCtSlTNut6tKds9X8mlyAn1q7v8OnJ9dGefvgcizxvA9IYhz6NRNMGx+/t3w4uGLVPHEskowj+tCy4mzf7iiWvQiBaOC+WLtjwCg/C49Hj2ajX3F8Y1sobFNw6bbRK7Aj/hPfyrZGBLIQzya/6Uc0uzPipsxQnmKKPhqys6hFDZcWW57v5L2lQNmtGeEU3nf+RJbcf9CW2fgEshTaNisHxexyWtSPy/8/fc9Q34PUBzs8tn46jp8yc0w5RVpiZVVc3oNakTNh/wLA3gTaOvy8LNgleEB2zrBgAFFofA/JPr7TjdE55lfJg6vFq96lh8hIGiSaf774dcglADuCWaqfMnLMjnTcp59t/iL3vEE3ScTD4g2Rcc8AIbHlimvHf1ETpdVkAoPl+wd9kq2hiFHyjtXrJkmFQjvMHatsskvaQqmQreoq2iYd1unLPatJDJkuS4NEErvbDriGubcn/B9hAzco4L/KgSAnnVXLg3fGF7MU3U47QqT6dGD4fpvnKZMjtKGLPF+YxUq8N87SzRwwTFM0P9gcWLe72JICtUAlH5gJty5HCTuTBhOz5kCNSs6onNtReDBGY95+IOZ/KZlvz0H/odjil16fKEjEScm4He+l2tVcQjxyk19LvQfy39A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(66476007)(6486002)(2616005)(6506007)(8676002)(31686004)(31696002)(36756003)(53546011)(2906002)(6512007)(186003)(83380400001)(86362001)(38100700002)(5660300002)(6666004)(8936002)(66556008)(316002)(66946007)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlVoNC9Xd1VhMFcveEZjUldTNVN4N0lkSzdyYjhDa3orcUJDUFlaaG42bjBp?=
 =?utf-8?B?cEFlMGZyMFM5SGNSaFpzNWdHRFA0Zk43QU91dURRSkpxK0V3OXJ3SWg4UHl2?=
 =?utf-8?B?eEN0SFFwOWoxaG9DanpjZ1E2ZWt3dWNIcUl5Y0VGQ093c0VYSVZ3TVhlYlNn?=
 =?utf-8?B?RUg0L2lXeWZvcExqZGdXUFA2NkJDZldTUzdMaWRWOXdKTmhRM0xCR2FpRE9t?=
 =?utf-8?B?QnZGZTdyN1EwRTVsNFRrdnYxOThzeGQ4ampmU0p4SENmbUpPajdLLzRWSlFL?=
 =?utf-8?B?T0lpL1RSQjBwYnpBdzFFSm1LenFyR3oyREhXVlg2RC9QanVuT25QWkZ4T2RM?=
 =?utf-8?B?MVgyS0EzNVNIb0lGMHVvQXUya2w3KytGYTdNUnl1c1RqbUEwMkgrSUVsSkRP?=
 =?utf-8?B?RHZWMUpyUFZOaTAweUlOYldYYmRSOGlMK003bWVYVHZVOHF4QU5Va1dDOGlu?=
 =?utf-8?B?K1M2T0dBUDdHVTZxdHhxdkZMVXNLbVFBcVFGZG5DbFdvQ1haM0RVYjBKa2pU?=
 =?utf-8?B?TEl2azdnT1p4UUZ2c3VFVFJvcGxuTHlzV2ZWV2RTOVNjZ3ZMYlFSaEFCakxx?=
 =?utf-8?B?SzZmMnRmeW0rVkU0ZGRsblN3MmlFeHNsT1VHLytMajl0aHBDS3k1NUkwS2d6?=
 =?utf-8?B?UElZOFhMeXIwMjlaU01ZY2VsaVJPclNpMStuMDV5ZVFKTmRLR3dndzQwSDFu?=
 =?utf-8?B?d0VlWGVMV2dZb20rMFgrekxiYWVSZ3dTQUkxbDNySmtEbHZ0eVdqTnJNQXVs?=
 =?utf-8?B?OXlySXdvOWdFaXUzTjc4ckFaanNyeFdxdGJaYmFucWs0VEhTelQ1V1NwY1ZL?=
 =?utf-8?B?K3dIUWIrbHBMZmlXMGE4aUhXWFZ3dkNIQ1BCTHRaRkZmcDZkZTNld1NQdllh?=
 =?utf-8?B?SzltYjF1dHl4YXFiUlhtWGZOWFNtenVMc0l2UEpvZURqYmV2bFUyeEdIK2Vi?=
 =?utf-8?B?elpwTVNGYVM4eUhyZXRKWGJPSGc2bFNVak5PTnpQaWtxTlYwTHYrd2RCdjc5?=
 =?utf-8?B?VDVoVFRGT1EvVWdtNWZCTWduNGpNWk5ZaDZTN1hCVG9zb3diRWNwK0ZVTFNH?=
 =?utf-8?B?bmJUejY4MVVIWi9qMWJNNGNIaWVVVjVudUVWZ1doOCsxYWJ5UG5RVThBOWM0?=
 =?utf-8?B?RlhjMjVCczV3MlhYUW9EOWZUbWFqM1RQTzNhTmhiRDBhU0VocGhKbkc2M2NZ?=
 =?utf-8?B?enN3VGNmVHVydGxrdUJacmVlSk8wb0xUSG5WSG1hdUtVb1ZvdWk3ZHdJMEJi?=
 =?utf-8?B?NzRaYnpoS2c4bkpncC9OS3Z4YVB0bE9jajNKcDdhN2NFb1Foc1JGK0NtREN3?=
 =?utf-8?B?UWhuMFhPTG94Qll2b0hROHpYcTliZi9DcVp4TzlDMVE1QlFsTmVNaTQ3TkNi?=
 =?utf-8?B?bFVZSU1QdXpwQ2VGMGY0ZVMvdzVEKzhGQnk5SWY3Y3Y5NTc3YUkxMVpTYXRX?=
 =?utf-8?B?djk0ZmJJOG9hMlUzY1ZGb09uLzY5V3k0dVpRQkw4NDQ2MUF6WFRyWDFZS3c5?=
 =?utf-8?B?emIzREIzUHExYW1CeFI5cGREUjZFbTh1TnNJcWhBRWpqYnExU21OVzNUL3p4?=
 =?utf-8?B?UVFyTDRMZ1RnNlNRUWxWUG50b3Frd0JHNVJMTWJnTmk5YlNCeHZtYUR3VVdh?=
 =?utf-8?B?KzdEcW1LNzcxY3BsSTQxS0MxWW9rRnVUOHhQdkdKYkdVTWs3SXRSajc3L2dC?=
 =?utf-8?B?Z3ZIOTc5a1ExeFFhYU1RVVl3UXNTa2E4TCt4cEpSbTVEcWlUVHRmZ1VsUExR?=
 =?utf-8?B?bmtwdWowaWlJZndZYUhSbXgrbkp5c2lQN1cra0VXbytCMnAxdmhWdzcxeXhK?=
 =?utf-8?B?ZnB2clpsUlVubUxBZGtEc015dERUd3JDdVQzOVNsYzdjUld6dTVrNldCcEtM?=
 =?utf-8?B?bUIxbnJjVW55R1hzcHNhVGdZUXJwYlgwQVRQcEEyaWNSbFFHalJNMTgzSERt?=
 =?utf-8?B?MGJvZitEOFdPMm0yU0U1WDRVOEkxSVp1MHZ6cGpaQ3VXMU9YMnYvQmU0ejcy?=
 =?utf-8?B?UHcxcWFoU0wyOHBLcE52Q1gyYTBMdlBTM0NJRExFT1B3b0R0U3pGN0pDQnVl?=
 =?utf-8?B?eW5ONzhITkJXUlN3dDNWcXNTODk2MkJSaDJiWWthQmNuS09BWXMzZ2VXcytP?=
 =?utf-8?B?c3dDSHR2cmo2SWMxTEh6L3o1aXNIZll6bnpIOUNTeVVhZWtSeUM2bllJNzU2?=
 =?utf-8?Q?F/KYcAVGjkXc/arMUpvqT8c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df11259f-044a-48bb-6d84-08da96fa5b24
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:12:04.5970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0blv+msM4ariQbr5Mqb+5mI0AYUJWf2PnmYKzcSp0Gb83uRnBB9EtmRLXQR15xU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6846
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
> This is only used locally in scrub.c, move it out of ctree.h into
> scrub.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h | 11 -----------
>   fs/btrfs/scrub.c | 11 +++++++++++
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 5e6b025c0870..e1ec047deff6 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -50,17 +50,6 @@ struct btrfs_ref;
>   struct btrfs_bio;
>   struct btrfs_ioctl_encoded_io_args;
>   
> -/*
> - * Maximum number of mirrors that can be available for all profiles counting
> - * the target device of dev-replace as one. During an active device replace
> - * procedure, the target device of the copy operation is a mirror for the
> - * filesystem data as well that can be used to read data in order to repair
> - * read errors on other disks.
> - *
> - * Current value is derived from RAID1C4 with 4 copies.
> - */
> -#define BTRFS_MAX_MIRRORS (4 + 1)
> -
>   #define BTRFS_OLDEST_GENERATION	0ULL
>   
>   #define BTRFS_EMPTY_DIR_SIZE 0
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 9b6a0adccc7b..35fca65f0f2a 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -56,6 +56,17 @@ struct scrub_ctx;
>   
>   #define SCRUB_MAX_PAGES			(DIV_ROUND_UP(BTRFS_MAX_METADATA_BLOCKSIZE, PAGE_SIZE))
>   
> +/*
> + * Maximum number of mirrors that can be available for all profiles counting
> + * the target device of dev-replace as one. During an active device replace
> + * procedure, the target device of the copy operation is a mirror for the
> + * filesystem data as well that can be used to read data in order to repair
> + * read errors on other disks.
> + *
> + * Current value is derived from RAID1C4 with 4 copies.
> + */
> +#define BTRFS_MAX_MIRRORS (4 + 1)
> +
>   struct scrub_recover {
>   	refcount_t		refs;
>   	struct btrfs_io_context	*bioc;
