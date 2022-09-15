Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40BD5B976E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiIOJac (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOJaa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:30:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2212A88
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMyI1FJWx3kmY4Ns+Uy6Uq4fucnh1drZJbqQvHf9aAsIjKum8qaI6OpNbTQMkTQLI+dTcWaYKMXwAQNSh+VavZJP0ZbxPOQPbkjl8CGLCaXmwSxXT4+sYMJu09+3C4nFzUNa0D4KXAm7+tsGSqZYW0Dirp9SA8ywCpAHPONcHSbL/pFWkqw+ptJ20l0Vqxkc60WgrpX9Hl4f6ar6sRWzVbXa4cQU/CQTz6qFvw09P3Ebgr792exrhYI0RBDH7YtsPfCS7AIo8eaMJtPdsrZOqaGkSrmr+i67Hz9ZX1XGCkOt77HMTrqUL+E9xoGUTdnuAWolC2vEkPnkQ9VmeQtkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7CRDsz/qrVNX7x8YgCoboFACEYkXPjIt34Ls9VVMmk=;
 b=lvpPBxVg2sKko0UAYH2yMJMNMzG2qze46TQeuHSU0dg5DS6TMh/mq5meGryyEgzYGxB9zerAiPlnfWbiga6ifrdwOcWlYn3oxjqQk1UGsYgVq5NhV4kOv84FiY4sbRqHU1H2YeXCquYIbUrweUJhMJdVm1cLHN3C/14ejILrU2ydUmec2rjStLP0LO7PiCG4lB5eD4wcJwa7SBwQysI4n1mtqkKnI+aIoyzdQWl67FKADmF2cxER5SIsPUb1oNcLRJcd0K01qbqGkcWOt12CpIItLX2AksMLqSeA20EzXAc6mQ2/bZUrGkLv6SvcovAoTuQqJOF/nWzsBBP6e/HMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7CRDsz/qrVNX7x8YgCoboFACEYkXPjIt34Ls9VVMmk=;
 b=Xt4GOWrHs4SDqbHe1toC3IAYCceAJ8WAdq/AMV+lcgh+6THLSmV6JBrxx3NdiOKBhYuL+b4t1g0YKxwIHjLm2LWU02EVIqV4DTsdux3dOPhThxvpM3Vava6B2DekiVv8Su5UU80a3aGxWuRBxW49azmOFyFkBSBwJvQ4J2X2VYMRjawmamj2bgNWu5B7ZFHyHtFOEwzm+Lajh/lZZdotYhnzVdQga3ELbITH53zvTlDvP5PgHO/LNFNtMCEXVKQMUsZyfrj461dbd6wazIerRzfQKr4DhC/F7wJY9oxb0GJz2eBUUpDb3aZSg4dW9lLRdW+5LnsEcYrj+FsrYfnj1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM7PR04MB7032.eurprd04.prod.outlook.com (2603:10a6:20b:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:30:26 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:30:26 +0000
Message-ID: <8c1945d4-7260-b867-2ee8-165130ecb138@suse.com>
Date:   Thu, 15 Sep 2022 17:30:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 17/17] btrfs: move the btrfs_verity_descriptor_item defs
 up in ctree.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <f86d4f92429b1efe41664e67405ce6266d7d2ea7.1663167824.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <f86d4f92429b1efe41664e67405ce6266d7d2ea7.1663167824.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM7PR04MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d40d562-5def-40ad-aed3-08da96fcec41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7TEr1453fAU8LXfoF0WWdeezoVa8s9F4uD/YfjPEcHDW3ZSb/xDZyE2cQEdMWBg24oSyYXLt6EjLc2vR+SrDfX9stZnSwPeQr3bjm1hnZsR+BDlNAoEqC20+jplBOHHfMFgES3LmTpHfB9pLNrQ+Xh7bah+/yLhxVfF5kAAZ9SXaPxhamzCzDvaEX08rZ2Dj9dT3guDzqayGajFPYodDK0gLPBj17ZXgXDzVqFwi2OAosB3WLSV2t1EjNe3rAcCF6ElDkLL8qXimQ+6BbbYlLfi+k72RmF79cRYi7xf3WkYs3OM7nxajroAH6lb1YyQc5QW2Nxx1L2VuMfZJyPKMky1dqUKCvmQTZ5GpBti3a+kGtK0T1cLKqbLtKkBJdc7OHjQpgQG7sdP6Ztt4SAiVb8z3rpZS7+FUjrpI4TZFM2Iurq/59rhED1y1jchLWI4HuKtExhsGwm7S5DObp0n+d77sRV5ec6D6fDr5kd5/++z1tBeBAFmZdHdtgdTR+KRjojZKm1FhQIWTXePr/aDOur5jf6fo04djEDJx04eLdb0ujQRUSXpowqpRXimF6PiLDFSyY5QTj+YWXt++KyuNJWruJbnIH6byMUqZjRoXTi5lWMdC/6gK3khDjfOzxoE1mbi5CDsXaYKPo6nZrSfs/WE9Kv1+Tiw/XF/+W4/2fLBW1yyAUIVb3G2JxUC5wSOQhzHRgYENgfTyzbr7a8bSx1mdck63yP9o4SmpPlwISPogCxrbKwSV2/AdDC/HyHHaqDhrx54t+Ye+irjxKoD3z8otN2TkSk/2nh7EBC36sk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(2906002)(6486002)(66946007)(316002)(478600001)(86362001)(66476007)(31686004)(83380400001)(36756003)(8936002)(38100700002)(41300700001)(6512007)(5660300002)(6666004)(31696002)(8676002)(66556008)(6506007)(53546011)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUFmaEVwVDlGeGpPZDI3MTFTWDBKWVI4bjZ2UzhmYTF5TDRPVGpMRDcyREt0?=
 =?utf-8?B?eVJJUU5RWVFxKy9QL3N2bFFTYUJFYlVyWWM1NGdQQStxa0ZqVERkTjlBenVu?=
 =?utf-8?B?NFg3Q1hyUmVCL0FUYm1OQWNra3VKcWE4cEtrc1VaUFBOSjNneSt0bCtnNjR1?=
 =?utf-8?B?YjdPUzhOaHJRYmVwZG92NmEzbWkvRTMrNGl2SmhQZUkvSUIrZG9mdWlXa2JV?=
 =?utf-8?B?eFZ4Qmc3WDdaMnIwaC8yS2NKaEZhNS91bXNrMkI0YjY5djJRYTlGTkNCZHlT?=
 =?utf-8?B?WUVSTUIzMDVHWDZZZW8vSzEwZTY2MS9nWHBnQU9CN0RvRUIwOGplS1ZrZDdH?=
 =?utf-8?B?bWhLblF1dCtiNlpvMHhTY2pzYitoaU5wRkFHeGc0cFJaeHgzREtqWDNQYzlq?=
 =?utf-8?B?dW5yUHJnenBabVc5UWRWNlF6R05DUEN0Y0MrVEk3MkJjMWYzajgwQUs3Q1Va?=
 =?utf-8?B?NjRlT0xOSmFRWHNCdUQxNTU0cE9vRmFVelYzaU9tN1hLMkFCVk41NVc4cjNh?=
 =?utf-8?B?OS9TbUREQjFtL0FWeGhHcDU3KzRkVGI1Q3RBbGdpMU9pbGtlVnZubC9peWxa?=
 =?utf-8?B?UnZ6Zi9qRjJBTlRreXdnbUorYXo0S0dwbTZ5ZWhaQW5tZEtaRW5jRkhlUTBH?=
 =?utf-8?B?dExMLzhGdlVWT21RcnkyR0MrY05rMS94Vk1USDltNmIwL3RHcDcyMkdxZkNs?=
 =?utf-8?B?Q2tqYyttdC80cWxJYnV2VG9iTzQ5K1FucG5FalIzMXU5L0pQTEYxams2YUNX?=
 =?utf-8?B?eVpiZXRRWlZrM3A3dk43VlFYZE5tc0R2b2N1Nk91WTJyL1JxMTRPWndWNFBh?=
 =?utf-8?B?Mjl1c3MwY2xpcENMZFcvVFVWdUZhRm5wQ3VTcEpSd2RGRk9kck96L0drTWRN?=
 =?utf-8?B?VHFvRzg4eXM1dkZ6c0JMRTgwL2ZPY3p4dGM5MDVsbGhHbHZqaGdhYzJYQk5l?=
 =?utf-8?B?bGJhZzFiWXVaMWZlWWovRmFiNE9qQnhJMVFMMUZHUHIxYTVrYjF1WktFSGc3?=
 =?utf-8?B?bUtpOFdzVklyaXk2Q3ltOXdZcUhGVnFpQ2UyU3RXUGVPTG5Ock9XY2pxSnNJ?=
 =?utf-8?B?aThZQy9Bbmc5WU8zTUd1Y0R4K3oyZHp3WjdYV3FTZ2Jmb05PL1lZMk9zTWgv?=
 =?utf-8?B?L2g3NWlGQ2tiZG1UVzFaa0hRMTRIWm96NHpBOVN6SWtqMEp6WGwwTmx1Zk1M?=
 =?utf-8?B?VEoyZi9zT2FuM2dicEJzUDkramc5MWl3WnZ1SlNJSnhFMU4wNFNLZnhHVWJv?=
 =?utf-8?B?eDNhVit1SEsyMExhQUhIdmtMRDZWeUh6bWViNGUyYk9MdUk1b0JCazcycFdm?=
 =?utf-8?B?MlQ5cTl4RjgzQzVxb3JyYnREZnI2bTZqOEh2RndKdmVWQ1dzTm9HSGl2WFBu?=
 =?utf-8?B?M0puMXRPWDg0NzEyQThUbXZNa3Z3Sm9qbVMyZkhRSWZ2UEdLSERaalNEdDIv?=
 =?utf-8?B?U2plQU5jYzliYlBYNk1xdmpBRTU1WnV0L3Vrckx3dkZtL1hOWWlHQUgrdXd4?=
 =?utf-8?B?SFhnR0VIWFhVWm5zWHFQdG5jL3NLeTNJenNSUFlYV1JQZW5RRk5YZzZ4SDI1?=
 =?utf-8?B?SUtxUS91eXZFMjFPaEIrSEZjNjMwOGpaL1JmTTk2Q1czMlRSL25OZ2JNZkt0?=
 =?utf-8?B?WmxqRDhJeVhKN013elR3dTkxeGhySmVLMFZ2Mnplcy9OOVdUOEVBNDlNSWVq?=
 =?utf-8?B?S3ZWNEJrd1IrVCs5a292M1J0cEkrKzdjYTVhekRENDVkQ2pyZmkzdjRFNTU4?=
 =?utf-8?B?bEkxQ2VibVJIN2hwT3J3SGVYaUJteUUveHFEU1B1WTBGTW1xakhmTFR5WVJX?=
 =?utf-8?B?dGwybUtQVkNYcXUwS3VMRTlvSU1iRVV4WVMxSm54QmNkZjZkWTFJRjVwNnVn?=
 =?utf-8?B?cVpFWnZ5TTNyMEpFKzJsKzNFenlZTzFjU1RHbmlZTlBITHVzelV5OUVYYzFV?=
 =?utf-8?B?RGtLYmllTlpJZFhTVFdIT3dkMGxQSmp1UnhqTGU4aFJTL3VhS1JNRHRUKzNO?=
 =?utf-8?B?RkM1cmtxMFhhd25oK3VraENHeVBCaWJKRlpOWklqOEtiU1dSZTRFZWlrV1Ir?=
 =?utf-8?B?WjU0ajQvSUZRNzdDRXYvUkhCNkFJaG9VTVFTK1pQR0E0c1RBdUdXaUJ5VzJH?=
 =?utf-8?B?b3lhM084YWRPV2t6dEN5b21lWXltWC9IOGtLVCt5SndlWmJza0FMM0wzTWhM?=
 =?utf-8?Q?PJPHmb8+uNrtCyrzfNgBh1A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d40d562-5def-40ad-aed3-08da96fcec41
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:30:26.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scgOxqJaXJgJ2Mz6ZjQFrxBGRmbm547et5vzKsB2dT7E4ITPht3VfmA28RNskPD0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032
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
> These are wrapped in CONFIG_FS_VERITY, but we can have the definitions
> without verity enabled.  Move these definitions up with the other
> accessor helpers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.h | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 42dec21b3517..cb1ae35c1095 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2499,6 +2499,16 @@ BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_left,
>   BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
>   			 struct btrfs_dev_replace_item, cursor_right, 64);
>   
> +/* btrfs_verity_descriptor_item */
> +BTRFS_SETGET_FUNCS(verity_descriptor_encryption, struct btrfs_verity_descriptor_item,
> +		   encryption, 8);
> +BTRFS_SETGET_FUNCS(verity_descriptor_size, struct btrfs_verity_descriptor_item,
> +		   size, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
> +			 struct btrfs_verity_descriptor_item, encryption, 8);
> +BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
> +			 struct btrfs_verity_descriptor_item, size, 64);
> +
>   /* helper function to cast into the data area of the leaf. */
>   #define btrfs_item_ptr(leaf, slot, type) \
>   	((type *)(BTRFS_LEAF_DATA_OFFSET + \
> @@ -3742,22 +3752,10 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
>   
>   /* verity.c */
>   #ifdef CONFIG_FS_VERITY
> -
>   extern const struct fsverity_operations btrfs_verityops;
>   int btrfs_drop_verity_items(struct btrfs_inode *inode);
>   int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size);
> -
> -BTRFS_SETGET_FUNCS(verity_descriptor_encryption, struct btrfs_verity_descriptor_item,
> -		   encryption, 8);
> -BTRFS_SETGET_FUNCS(verity_descriptor_size, struct btrfs_verity_descriptor_item,
> -		   size, 64);
> -BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
> -			 struct btrfs_verity_descriptor_item, encryption, 8);
> -BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
> -			 struct btrfs_verity_descriptor_item, size, 64);
> -
>   #else
> -
>   static inline int btrfs_drop_verity_items(struct btrfs_inode *inode)
>   {
>   	return 0;
> @@ -3768,7 +3766,6 @@ static inline int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
>   {
>   	return -EPERM;
>   }
> -
>   #endif
>   
>   /* Sanity test specific functions */
