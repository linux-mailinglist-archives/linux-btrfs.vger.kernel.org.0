Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E565B9743
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIOJQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIOJQA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:16:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BA459B5
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I95TW37mngSGr78hjIsRIl64eetB7ae0SSGQ45ng9f3gyGQ+Nxwi8MsCeqizVLZpUyByqf3OnmImt+JDC3gIqvqoMGcXV7AfigS8WxNmeF1MLkt2bXYnuEPSwcvojfPNmn9uHhn6yLRym3N4GtbIVGr5n0Aoc9q8hEFhRNI6NQOifLIGjy6oh+rP5/zMtpq11kJmjolwMGHeeqwxyZlOm83MwrrFYuDqeIV45htxliF9WgY9abvCmkf+/2bOeqUbz/dOAO08MTwR8dzn/gxofj7sk/wNZVsq15NkLrY9g9tvnsWvWX9hIgvAkk9mu5Enw+BHPl10Posaucl7ltsKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n97VAOko1R+4TU6Gof8aGdg89SM43ys1/mKFPk8q/EU=;
 b=Uj5Hk2WhLY7aY0v2NcmWPRdz/m8khx4ULrmz8LlWZNXS/F8shmkSpOnJyT+ptIKxjhHHcstEDPyWYyqxMPaWx+G3U9fuBdJmD2JxQaGv+BUf6OCDCPjJzAtvw6MkHauwkLP1HkZEqBKM+Cuf0iigM5ElOlMlaZ1mjZGPmNZlBvQoNh9wrOcRrJi0EK+rxCSO279pRw7OZ+Ql3D1UfIpAK41DyFGnKGB2+1XXnoN1CzqTrJqMwMPbybyMK7N2Lx9FWvDw/NcgmlB5FhH1VdSzJlLe5QOYVlWCoN3Euhgkk7r1mR6hFiF92lAP81POY/ntqVnOXVDvEbdTqcPAKS3UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n97VAOko1R+4TU6Gof8aGdg89SM43ys1/mKFPk8q/EU=;
 b=Fg975nDIA3y3LuiIEYQ4njlkTJOA8Y/cF33CHCbCmshh6nsMzseee4DIB0MKEtj5EwQxgnOu7xpGAOK9cXrk7nro6zSF3SW0PlppH/pogcZEvoHEEQKD8fCfozxfydrQNKIcSzey1mn8KhUy/uzVkglx4ivPP/GfkNfT0KIFQjQfF8cpidjhtyriEbYhEiAI6MVhKS4ed4FUdzA7JKk0SuxpHpcfNZwSQwHOjMClgtK1NDBpyN29WzV9sFfRoC188GpOlDBQzEy9hvR8fWKXfuaooOZuGTTAyS8ZvUXcGEeTBqGh24nJSYC98ubVEvhuwvrRLEhGcme7OQdnwOimEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB8662.eurprd04.prod.outlook.com (2603:10a6:10:2dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:14:26 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:14:26 +0000
Message-ID: <57b9689a-0b5a-e819-305b-4f41feaa6985@suse.com>
Date:   Thu, 15 Sep 2022 17:14:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 09/17] btrfs: move btrfs_chunk_item_size out of ctree.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <3744e0ae6f8087daa9608174aeee00c53732f8bb.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <3744e0ae6f8087daa9608174aeee00c53732f8bb.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: ef392c6a-d0c2-4a5f-5acb-08da96faafd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdqfgk2AEtVi1vMEZ3dvoD2scZh5k0GlWfkDyEt1mGxd1NB+6CW99Umt+GRl4p13MF4Cs78VSA7Ipt7btjlJ5vyr9jLIzL0fm+FrdEYivkM/MOXQbgzUQFSMj+caEG1qixsWdnwV/dmrdmWauWQ09QHn9hQzbUxEOnAGQcep+81AcovnuK5lwB3oSxNmPKCN4MI32WhAFENIvE3PK9eV6/Fh1j1WaGsbiyPJ/bHcvbZOw9oXI/UwxrjF7KV2Zg1qcwNGvtOPIZfqDw1nOKyFSE4fA6kJprgau/4Vz6lYYIVaJxcIrjUSn1hoO1C7nBgAL6VDTBIcUMVs/8hc75hdcQm8f8etybyZleWTtcofyuzIpyISYh3eYBC/GjBBe8/PXI/0+k3BPrr+jJ1thuYqD7SI/HUxOfficNuK5vwCCiPdHOUzkuI6Iui0N4rYrQ1pBue6hnw3NnoVqg7XtLiugQogbV9GL9MGNloJW85ivGy2KO+EF1GRugYWUahVLKe/VTd481sv2MtOO2xCAl7xMIeLPgam0vEBy3wSiMi8Ncfc1gj7KYKJNurJKh2aLN5ib3Y56PVuL7GTRdtva5Mq2oCPA3y3GgwNoOSR9cmB+yTfX79eVaZVnAyTw9kwZ8vrt9bB8m+C9oyF0uK2tygfx3/ZkQGsLdWMjETzeKA+z+RYvb4clszh9SQsrjxRS8v1ZRloSBbMJuAOHV2rMVNqOtLa2xlLCw9Ojaz8yyavROUw5kRIpM8mm9UOPf4cKiGVjSc+i4h9PEUaaNIo4M6SjVvfWxT1o2/p0EnuLGMJ09I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199015)(66946007)(6506007)(31696002)(53546011)(66476007)(86362001)(66556008)(6666004)(5660300002)(41300700001)(31686004)(36756003)(2906002)(6512007)(38100700002)(478600001)(316002)(8936002)(83380400001)(6486002)(8676002)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEl5ajJ1SlVTSnNrekNFSTI2ckdVT3plbXpEQ3RhYlRrOEptbXRsVG5qQ2RL?=
 =?utf-8?B?NVhPQXQ1WCtwTEU1MDZOWlRYQzl4YWRlSnBRRURXRjdzck9rSkV1MDNYSlQx?=
 =?utf-8?B?STVVOUNwZlRDSWlMWnNwckxNQVhuUnJ6bDlkcUVURlBlUDhtQTNMUTUwL3VJ?=
 =?utf-8?B?bCtnVmVSWUVXbFBWUUNHSnNFM1IrUnE1eVZMN2hQOExpbWJxa3o4aXptRlZl?=
 =?utf-8?B?MVFwdTBLUm9TMnZ2TEU5REVXcm0vQ1NrL3BKYnJVeFVXaFNoWU53NXV1ZDIx?=
 =?utf-8?B?RGRDdzRrTVNVNmk3cHNneVRjMmVxMlVBWWRkSWpVVjBDMTZQNHoxTDExK0tG?=
 =?utf-8?B?U3ZMZVZML2dGcVJaOXpiNU1CR01hWmtIZllWSVV3cnF2dnlRekNWeXZJZVNW?=
 =?utf-8?B?VE90d05jcmNwMWlwbk1ob0h6TlVsc3kyLzhsVnlGQ0F3ano2MDloazJ5Ukhx?=
 =?utf-8?B?WGVrTFQ1dE9aalFndHNkcGRNeWJiZmRMQVkwa1R3ejcwWTNWVGRnNkhjM1dm?=
 =?utf-8?B?clFGUFdrL2JjVVkrSXhyMGNWYytPMlBMV2dFWU8zMkhnUVdxNEt2aVl2K1dy?=
 =?utf-8?B?Wk4vOERhckhFcjM5c29CKzRud3g5NXZ4VWFvUFVhVXJCMmRwNzYweENyd1Ru?=
 =?utf-8?B?Yi9HamVlaHpJU3huK01uRHhTc1N2dTgvRmFXYlZWTEd5blNZQU0xYlErcDV4?=
 =?utf-8?B?ajFMeFowejFkL3BWU3dkOXpyWGNkZzQ0Y0VUcUhXcThvUEZRMDUzMUVLVFZv?=
 =?utf-8?B?VzNtNkFCNnFOeERxbXk2QW9kdTExY2tzVUpxZWlQRWdPYW1FNXkrZDUrTTdV?=
 =?utf-8?B?ajNrTUdteDE1ODQwUU0xekcrKzZydEFwUWVNcU5uanJkR3F1R0N1eHJZY1Uv?=
 =?utf-8?B?UGgyZGM0b1VvZGNKdkRWcXlabGN1MDlYajlPVmIvZHIvU2RPTm83eHR3QS9X?=
 =?utf-8?B?VWVic2dXRmZmZGhTRUdncWpGOTd3Q1dCOUtyb3pOd1N5emRUVUVGemVXNSt6?=
 =?utf-8?B?SGdZV3ZCdkdBU0Vzak5NRW1vNXB2a1ZGMGF1UGJyclljNWlWYU1Dc2poWjdX?=
 =?utf-8?B?a2FxYUxBMTR2Q2hlUGUyTUt0SEVwL2pibHhBMlJKV2pJNEwyejNOS2lOdHAz?=
 =?utf-8?B?OFVUUjQ3bGpORXYxUGNxT2drNFRQeXMxaEh5bG5ZdS94enhHbFdEWmVnZ3Nw?=
 =?utf-8?B?TW5tQ0UxTFN4S3lsL05uWDhFYlZKNEpaUkl4QkR2VG9walJOeTVEQUNmTEtE?=
 =?utf-8?B?eTdCR0xYNWNqWGJHaVFmS3BFdCthc1FDUXdLQ2FpamxNc2UwRHk3aGJaM1V0?=
 =?utf-8?B?RnpaUEpYaEh2RFZpTm53Z1Jpa0ZvNVNGNU9aSElCN0ZRWGZIWWUyVFluSEdk?=
 =?utf-8?B?K3VSQTQ5UVJMSGorNWdyU0lZeklqWk5vMzNXWWpYc0FnRjB1eE1rRlMzanY1?=
 =?utf-8?B?YjF5YWc3UjlKRVovN01pUFBwVFNZQWRyOXVnU2JiTjNZQ1JkUmJvTy90T3ha?=
 =?utf-8?B?amoyc3dlZmU2aE9uZzZxamRESXJHOWRkZ2ZUdlRZRm1vanQ1Sk1PTjBFNGdR?=
 =?utf-8?B?cUVzbnNuRGUvUDRlZGJzMFl4bHpHTVdBSnA1Wjh3VWxWZ1VGbmFsMVlCbXRS?=
 =?utf-8?B?RFpkNmlJSnk1aFVGNnJES2xqbVlZSjZtdWw2UmJ6bjVxdWYzODdVZzNqYVJN?=
 =?utf-8?B?ajdkdUNkTmhGcXpvTnVuQ1NnaXY3NWlTa21abGRrOW13VFdDT0huWEVybEQ3?=
 =?utf-8?B?Z29JRTBuOGtiYWVDKy9HZlNGUEErQXA1R1h0bWpwN0ZNMjhvbUlRR0l0Z0h1?=
 =?utf-8?B?TmlLVkJoTy96eU5oelhCMU1wdlp6d05nMWgwSEVRcHJUTmR0NkJ2Y1JuakJJ?=
 =?utf-8?B?TlIzajRBMkp0Y3haMTUwWkxHbllrbjB3VTJIZ2JocHdPaE9vNXFEYTFQMk5k?=
 =?utf-8?B?ZCsrZjNvVGdldW9hS0oxMGV5bnFnTlVkaE5JcVpKRmg3VW9SY2tzejIwVFlS?=
 =?utf-8?B?TktUcVR3cUd1OXRGY3o3dFp1RmE1Q2xVS29MeFFjQjZXUnM1Nkg1RHZzQ2pQ?=
 =?utf-8?B?R0FSUUxPY2RSQTFJeXNwRTFrU3ZPMzVZZ3VGay9FVXVSSzRpakE4TndHaU93?=
 =?utf-8?B?dHFIT2VzblEwL1h0NmMyMVd5ZjdZM04yQmIzaU9EMUw5NDc4elJoS1FuMWo4?=
 =?utf-8?Q?T8thDqshAAMR7N+la2je2OU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef392c6a-d0c2-4a5f-5acb-08da96faafd4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:14:26.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGCqT9h4dFFdbXoDV2hiz1mi2tgmCRobtM6RGalAXxE7tR6OKl61CZxLovqxKi29
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
> This is more of a volumes related helper, additionally it has a BUG_ON()
> which isn't defined in the related header.  Move the code to volumes.c,
> change the BUG_ON() to an ASSERT(), and move the prototype to volumes.h.

Again a very small function, can it be inlined instead?

Thanks,
Qu
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ctree.h   | 7 -------
>   fs/btrfs/volumes.c | 7 +++++++
>   fs/btrfs/volumes.h | 2 +-
>   3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2e6a947a48de..60f8817f5b7c 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -58,13 +58,6 @@ struct btrfs_ioctl_encoded_io_args;
>   
>   #define BTRFS_MAX_EXTENT_SIZE SZ_128M
>   
> -static inline unsigned long btrfs_chunk_item_size(int num_stripes)
> -{
> -	BUG_ON(num_stripes == 0);
> -	return sizeof(struct btrfs_chunk) +
> -		sizeof(struct btrfs_stripe) * (num_stripes - 1);
> -}
> -
>   /*
>    * Runtime (in-memory) states of filesystem
>    */
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 94ba46d57920..b4de4d5ed69f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -160,6 +160,13 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>   	},
>   };
>   
> +unsigned long btrfs_chunk_item_size(int num_stripes)
> +{
> +	ASSERT(num_stripes);
> +	return sizeof(struct btrfs_chunk) +
> +		sizeof(struct btrfs_stripe) * (num_stripes - 1);
> +}
> +
>   /*
>    * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
>    * can be used as index to access btrfs_raid_array[].
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index f19a1cd1bfcf..96a7b437ff20 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -730,5 +730,5 @@ int btrfs_bg_type_to_factor(u64 flags);
>   const char *btrfs_bg_type_to_raid_name(u64 flags);
>   int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>   bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
> -
> +unsigned long btrfs_chunk_item_size(int num_stripes);
>   #endif
