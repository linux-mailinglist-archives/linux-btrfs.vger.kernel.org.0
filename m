Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46F36EF438
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbjDZMZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbjDZMZ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 08:25:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D5170E;
        Wed, 26 Apr 2023 05:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpsLwbyxLE/dsxckviWMD0WuWKnlljUA9PfEG+mmb7hIUIrIvtjAwKhj/t+OZkPV2PYb7MrAQXtsXlz/ZhVz/mCZVvdTCZk17mUeV1dmgCYi8ZOO0gKYj9gIBqzAGiOABBKw6zJb3fF8yG9dnoHlWa+z6v8wCWuiN7Ge4/irgB04iqXu9QJh589Bll1IiHcQjKar6KKxFYJbmgBPtIfhpQYTTPcNMA8CHI+8g7ch8I5Y22KDvbtYgKk+LVBmQ8kaIwebOe5geDDX4NTCrB7eb28o/dC3342RX3aR4I1xylO9nyKjkBaLVcDJWqs8i/CqPeav1fRtalb5BmPrIcf1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4TqX9a4h9RrF8SuiQNO6FFTi94LJGkckEcuawG3G7o=;
 b=iUkYlYeKwwFL+HhHrYMc0CWlvVuc8YLz2BrW/z6OEXwedkY9ELDxM89255Ii6WxiHsTSre4WALYAth7UHccXJPw/QRwHhFfVFGtguZHSMj71i+hgRLsHoZVk8wFfhbaOvik8A/9xQlMxBcLYndf7h+KihO2jQ46s2jWZooRHxTsRk/+thKDue2XF51/kNojQ31+/1qLskQPfhR3/NeOL1CLcRhCKhdfI44JXQHCcFOsqs1VYKPw32sQ8Cn8XhJELIRrYV7xZmIyGTOXWUO/L9wZnQS8kzwvR7WttGZ+pf+RntvY2/gtWw8AUfB/zPsA21s9bgYs+SvES3N198sHVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4TqX9a4h9RrF8SuiQNO6FFTi94LJGkckEcuawG3G7o=;
 b=ModdNjrpnyHZrpPXa1f5/B4h5JL52qRehdnD03RkA7Y+ebttTBz3pcvBT6V6auchlAc0qVOmt76Yip3kxsN1K4Y8krKu/EprqOEdlC2G3PzKti3ns0HNLF6p8BxmPelAWKUIUqDI3RCrkEPgWXxebTDfpPmGdQwLN0wkRDt+E4XDD4IQGA7ibx2na1vaLoUBb94grUSCwMVUsJ6y/fEDZAmAs+twCqcQymYTb8acQg89zxj6DmDBmqSPBjv3H2e21ghDS1qzx+NDomn8rQjtzLiwEg3sgirJlu6YtwKVTuM3Ac+f8CJMs8riO0oKTCMrqWZIMMs2+I6tlhWgMXwQnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 12:25:23 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 12:25:23 +0000
Message-ID: <8fb6638f-1e99-a1c1-3fa1-f814d08d2659@suse.com>
Date:   Wed, 26 Apr 2023 20:25:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: parent bytenr must be aligned to sector size
Content-Language: en-US
To:     =?UTF-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCR0LXQu9C+0LLQsA==?= 
        <abelova@astralinux.ru>, Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230426115323.9455-1-abelova@astralinux.ru>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230426115323.9455-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0018.prod.exchangelabs.com (2603:10b6:a02:80::31)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 04112229-4613-4b8d-b558-08db46514efc
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1RJz2N88/R+6OykRGVW7EZlKXyzkCMdLFzak8awrrqG11VLJt/PA+JeL8ryQW5G24xIGNBR4OBxPMZG4IcU5cy7Eqvm0gcL4Hsp0gXSOjit81mkGsnZr/Z2WlFGeUsdJ+PWAvVBxLvHuSV4kumAR739dbLhUwpN2ddFRA1xRrfKxQrS8rmrBWKs9w4c29NhSXtHyPTQNEZSCCPRmbufr8OgdozXrhv5/rbqIODb+sAmVsaEbYzAv7NU4Hyr1qmGyz5Ew6q9Bry3gYj+7ItmpqqiKvum33/JX4tFXjJ4hQ/0iovlmUvnV1LroXgSLmx8hYOph9kcVYC43C1G/mB4cheMfdNVeJyMmz3XEIjILgQxW+z6lIrQXaLreec//99A3r0c58f49JjcoCF94Mf6fRYRcyYuWeI6j+UeKQkvxo2DU6fwWACRUoCrYTQnvCChy7BT2mUFheFW693EY9eTdjVWzzscGds4jL9ZQx5T4BE0j8PIYpaIBknMT3V1k0fd/I9G3IxA4HJTGvKidHJYJ/QKNHO3J3cJNapCpact3sD84nBOqCpZZLoBhcK//fppCM5vAvuG0bzXVFs88VwUQ3pdosRn+3pePG+jXgRTLKVdFc99kEQB9u8FzGsOISiIB1LtDsSOvIqlpaXkBgGRGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(53546011)(6512007)(6506007)(186003)(2616005)(31686004)(110136005)(83380400001)(6486002)(6666004)(36756003)(54906003)(316002)(41300700001)(5660300002)(2906002)(478600001)(38100700002)(86362001)(31696002)(4326008)(8936002)(66476007)(8676002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNJanBaeWRPajlqMGNCNlQ3THJ5SU50TExreDk2bDh2OGZIbC9Rcyt0YTJu?=
 =?utf-8?B?Y1UrcEdWTUU5cGRNYU9HOHlOTFRhWHhsZTZCdS9CRDg4cXVIR0hKVG8zS1JW?=
 =?utf-8?B?QUd5c3JTdE8yZEJra2pLU3lmR2JhMVA5ejZ5eENlUm9xRSt4SGlsbEhEWTJ1?=
 =?utf-8?B?WHBnVWRXR3cvS3l3M2JZMTIyNlA1bmpVbkN3UzlsQW9kckhnM1ozUkdyalhQ?=
 =?utf-8?B?UHkzb1NTY2NDV0xvNGFoZENNNGFsUjBWTzRiRTFvK1BQT2dzem8yaE9jeHg4?=
 =?utf-8?B?dmhCbDU5YUNQSXp0UjRrK2ZJWFVuNE1QdVZGTXNxS3Y5ODFhODhKTGFKVXo3?=
 =?utf-8?B?N3hlRXgxZE1iWlVuNUN0ZW16K1QrNG9vUnZReHp5UDhtajlhM1NpNm5hakw4?=
 =?utf-8?B?VncxTU5wY05Cb0FDeHFQZG1ZTi9PVzJnc1RqSm1NVlhkazY5SVQ1R0pnZWh5?=
 =?utf-8?B?Qm92TnZlNVpRTlBSNklMdk9wVTdFcnFpZ1Z4eGE1aExoOWhza2xGZ1I2dSt4?=
 =?utf-8?B?WWF5L1d1bWsveFdpQzFGNVZ5K045cFdyeUpJb1ZEdnNJYWpoSVJlbnlEU0Ru?=
 =?utf-8?B?Tk0xSGFSQjFKMkQzdUFVelk1NTkxL0VpdmtiRGpLSEhjK1FBR3hrQ0tzWWFY?=
 =?utf-8?B?ZnYwM3g1TFQ1VnY0Wjcyek16c0FZSThRM3JuU21pakRxWnAzT1Z1dXdmbWZt?=
 =?utf-8?B?Y3FMSnRicWhkRUVlQlV0NHpJdHFZWE1haGQ5TE55N1NEYlJIOVEwVGZOcGxL?=
 =?utf-8?B?TitIZHFLcy92cnRGUm5EUldRNzRDOFgxMWoyUVFwZ3c5Wm5TczlNVjdwY2do?=
 =?utf-8?B?UklTbStQeFhtOEdKd2FPRDY0Z3g4VGdwYWFIM1BOYU5LT201MmVyWXZiWmti?=
 =?utf-8?B?dHMra3Ewb2ZQenpIUkpEd1JhdXVVTmdoNjVlUm5RcVVXVjBpbG9HbE5SbzZX?=
 =?utf-8?B?SFgwV05wdjNmZzdTOFRFajdFRGhReXVScWk5YUZ0WmpUcVQ2NkxOQnVDN29s?=
 =?utf-8?B?ckhkeFl0czhFS3hlS2ZYSFllbUFRdlQ5U0NDdSs1TWVRa3puOWIxM1c0WWJ2?=
 =?utf-8?B?cE5OQnhjWlZObGpVU1pObHJuOUFUNDFPczFDM0swVHdOc3ErejUxVWhLd1hM?=
 =?utf-8?B?SW8xT0hjZjVWSHZaN25lcG93NlRkRFZjczRzRmtqMDVDeHo2YmdzR25Dd0lj?=
 =?utf-8?B?bng0Y0FZZHVmMUI1bmJyOExiL0pZeEk4cUE0VjNPaEZHZ29PQUVTOFJ1UVRU?=
 =?utf-8?B?Q1RvbHBmMFhKUmcwYUpxY0dLK294SWNMS1g4N3NzdXVVR3k4NUtCdmMxdVFJ?=
 =?utf-8?B?RU5iTVlFQk94NjRuSWthWFpIRWVESzlrUW01TDR1VlJOVUVtUDlpdTBzUGxO?=
 =?utf-8?B?dlJiVElnam14K1ArbjZLNXp2amJEREZJQzRONEhuNGozdzRGcFVQZzdqSjE5?=
 =?utf-8?B?cCsyTjBLdDYrZytpeTQzRmtnbWpUcUtaV3Y5SHlpVWpUMERQVE94WDBTRTU2?=
 =?utf-8?B?YnRkY3I2YkROYkR2YTlpKytJbFlDY3ZMc2JhcW5qcWdlRlFmc0lIdXRYTjRs?=
 =?utf-8?B?VlUzUS9heFpENU1PaFU2eVJIejlrc2dvVWswVXlmT2QxaVFad1duT3ZhOUZF?=
 =?utf-8?B?aHlWQ0NYdlhaOUkxU05oRFFsQjhuMVU5bWgvWE5jMHBsanF3SzJNUko4L1FV?=
 =?utf-8?B?NHl4M0ZxbkUvL2wrUmEyd3JwbWpFMkFhd3A1c3NvNjJpb3YzTUMxTk5WYXM0?=
 =?utf-8?B?TCsybEptZVFITVIvUElxcVZFODVaMEtsdlJCQ3cvRjJUNVAyV3JQbmF3VG5G?=
 =?utf-8?B?YngyckF3TkJmalhoVnFobWoza0dRcktad1Z6M0Rib0ZlNno5Q3hUWmRUOGRj?=
 =?utf-8?B?eVhpNlNWM2Z1R2hqbnp6N2xQdExEQ2RyckRENWg4NzMzREREemJFdml0N2dK?=
 =?utf-8?B?L2ZjR0t3a1U1bTg4Q2NkcW9ldUhtWWVDbWxWa1hUcmh5TTNqc2JRRXNRS1BG?=
 =?utf-8?B?MHZRWEhnWXZGQURmdkNaRVpla3pxa2RqOFpaTUNFVG00Q2tQSUx5ajRkajVo?=
 =?utf-8?B?VTZ6VUR5WW1Zdjg2SnZzRS83dENwMEFrV3kzWWt0TFZiVTM2MDdVdU54ZStJ?=
 =?utf-8?B?WjBnQjU2WFA0aERqWTJzKyt1UGFQZDFCZjZrYWlZT1UrY3pQUzQxNjhHNDhH?=
 =?utf-8?Q?dixojdejeeD5QajzEokGGOA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04112229-4613-4b8d-b558-08db46514efc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:25:23.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BCKZcwtCoFHpk+LLatYGtzLDaXnwSbHwKXEM8qPMHOPbJfzYeAi+6Ug+NN52p+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/26 19:53, Анастасия Белова wrote:
> From: Anastasia Belova <abelova@astralinux.ru>
> 
> Change nodesize to sectorsize in alignment check
> in print_extent_item. Change requirement in comment.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: ea57788eb76d ("btrfs: require only sector size alignment for parent eb bytenr")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Reviewed-by: Qu Wenruo <wqu@suse.com>

A little surprised that a static checker can even find such hidden problem.

Thanks,
Qu
> ---
>   fs/btrfs/print-tree.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index b93c96213304..cee005fb8209 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -152,9 +152,9 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
>   			       offset, btrfs_shared_data_ref_count(eb, sref));
>   			/*
>   			 * offset is supposed to be a tree block which
> -			 * must be aligned to nodesize.
> +			 * must be aligned to sectorsize.
>   			 */
> -			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
> +			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
>   				pr_info(
>   			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
>   				     offset, eb->fs_info->sectorsize);
