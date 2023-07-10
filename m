Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161C574D26E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGJJ7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGJJ6t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 05:58:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451DCF9
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jul 2023 02:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awYthL9aG8LGfDzTNYlKIlYOB7l5Mlu/lbNXiTWyp6Z6x+Jjj5WGyEpPxalQYGz+FrN2q+ezl/IHGNb859599rqpegAb0PGQsroB2e6SpUluzQIVXtntQ/YXuwW5jF3lS7b0TkCZGpOgXfy5pIyL/rX3mBSBumWinwCOaP54sqBolE3fFDV51PHmv7RJMRaK1m0s8mOvW1PRWgnCeAwCi+VlAzUpBExhU21dgTHEJJ++aMd71BYWrfLirCr5AkmvNAQzf4jd45k/L6z+T/IcxiI9wcY6SUMGL+LFIUxEXgtcMx3OvWdqQ66zGRoodFXre+XCoCtZ2cBk6GrBYjpESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7RwZJsVhpBusmROwJJZFpLxe67BNw2hNZvW1V3T7NU=;
 b=dXhmqzAmoQnLQkISskqMxyQAyci9oYnlar/Asi4rG2nAFjRraaedISQpU4m/xKllYG3WYL5MZ3NFA2VTDVT3cb9hd6OK77TprOkyeC1L8T8PKEAo/x2KLanIsZUeIdFIcqK/jkwHYgvxC2Xg1PaYjByY/+cSHYdCybh6+yYdarQcukoI1rK+s+7bjpeLg9O41I49kCHboy6oSuJLLG2ML3aY7QyLyVH3r/w+B7BaUtIl/5Ee/gq8ObbtWEEU36/0hbb8xDQ6YN4PpHRNrLFwJRDMJAvLVEmjjxabDGl1+7MneeoAEp3ergm6nxYQmX2KdTXQ0wrOBhOY60th55tqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7RwZJsVhpBusmROwJJZFpLxe67BNw2hNZvW1V3T7NU=;
 b=RA7fPXWQR5nzpjA1HpfN5dddLzX6ScoTbDwwpaK+R/IVTRik0VSoyjJvA9AEfTGP08t/LO4elslAqQdWtnDnPkmlw+if/cR1MkQnsDoIWAHcxm2FYzfs+N4Q/5MnOxgpmFrrvF0r1LmphKc9Z739jsNz/SzoZzYmv7sWLW9gY0IJxULQrUqCAnMt52uLbEKxPrEtR0ZCyjPvIN68g+zUXh4cXIM/MAt7dJ7OLwiCJefOLh6z3lBzGLpPmdjsJGreWVNDStfbOd+wH9UMBPjeBwRycD+rDLcO9IHRH4qAD3ssZwhgyemuSeoRcyHGTURplIYD/JWQXcl7E4t0fOG+Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5392.eurprd04.prod.outlook.com (2603:10a6:803:cb::18)
 by AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Mon, 10 Jul
 2023 09:56:21 +0000
Received: from VI1PR04MB5392.eurprd04.prod.outlook.com
 ([fe80::73fa:aa26:2499:5931]) by VI1PR04MB5392.eurprd04.prod.outlook.com
 ([fe80::73fa:aa26:2499:5931%7]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 09:56:21 +0000
Message-ID: <365b60d2-32f2-9b60-a326-d3959592cb67@suse.com>
Date:   Mon, 10 Jul 2023 10:56:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 8/8] btrfs: move btrfs_free_excluded_extents() into
 block-group.c
To:     Boris Burkov <boris@bur.io>
References: <cb507b1dbff5ee7f776d98a9ea1da0d40ddeacfc.1688137156.git.fdmanana@suse.com>
 <20230707221740.GH2565448@zen>
Content-Language: en-US
Cc:     linux-btrfs@vger.kernel.org
From:   Filipe Manana <fdmanana@suse.com>
In-Reply-To: <20230707221740.GH2565448@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::12) To VI1PR04MB5392.eurprd04.prod.outlook.com
 (2603:10a6:803:cb::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5392:EE_|AM9PR04MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c1bd1f-e225-4ef3-0630-08db812bea07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xChXaYiJY9GqT5735ICrRBoQmQP9V5HII1Nled8p8loBf/9e7WQ6dPQH8tKpfntEx5w3Q2eZB/2UpYuuSAucPonLjNqKXaXKIwOnVp3rpBKXNpbcoVCOO8SV8M85fx/SshrAcHVvmd/fi0QYRsEDVFKgCUGYiwFIUqg1yszXolN/ynG8t8LJd71Bie1Ref6VkdsbB70qtVAOwYuLr2Kbgagas577qkMrhhR3N6sgayJwZt6fmfjVhnV/qheGVbcCzuTqr278pQdAzmsp07Mi87jx3MSYs2tUWbN6WQni6scYsfRWiAyZGavVXGoH5nJR0toFx/PQsnhhGNpFG0cm9Nbcff897OO5ITHOTZSrK30gD1jjctz+yh8wS5VkjfhQqMLYXD7Mbb3iQb39kGnzFlYhOKeYLe79vxEvq/aNT/OlCuZ+l/n/3kxi3nO+cihnCCD7Bv6Q/KVu1TDWOLzhbMhUNYZYaFQYliNIeh6C0k8/F7exImPPzHd4GnhYhHNiCfsuMkkEoI+FpHwnug/YBMjvbDlxfY5c0Sd3MhO+UPqQi6bAo2yCEHN2hr4zd2pJmAgsV0UaTgAp8Wm12fzahs0S++7XtptAsS2FJOOln++Z4PNcYfRdr85XT7Maa4SqftSsly9edgtp7Vzs8PurNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5392.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(5660300002)(8936002)(8676002)(316002)(2906002)(41300700001)(83380400001)(31686004)(66556008)(53546011)(2616005)(6506007)(4326008)(38100700002)(6916009)(66476007)(66946007)(86362001)(36756003)(186003)(478600001)(6512007)(26005)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ZTdDM4dGZlR2ZMV2t6aHMraDR4QTdNUjNRMHc5cFlqWmtqd2Z3RzVWUkhO?=
 =?utf-8?B?SWY1YldpbUFPbXpxcmZ0Sys0WENPZVc1emRHcE9JVTZtcmlIdDhLMHFXa0lY?=
 =?utf-8?B?WjQwbmEyeUY2UGgzdWVXckhOR1RCUE9lNjRNWkg0d0ttd2VNdDV2bFhOb3ox?=
 =?utf-8?B?bU9NWXJheTU2MmFrMksrUzJuU2VsQXdtZm1lalgxSVg2YWFnUlUwNzF5TFMw?=
 =?utf-8?B?L0t0TVNFZXhoOS9ZM1BBdlJvbnBidmhGc0NpMjBObDF2OUxrcGhaVTF1bm8x?=
 =?utf-8?B?UG4yWEJuVHJhb2ZjRFNYbHdnNmx4YmRFV2tqTnNqZElYaVdTMnpUMmc5ZG1q?=
 =?utf-8?B?bFRIUUgvSEsrQ3RvRnp2M0lvd0Qrazhqc3d0RWxWTXFiSDN0NnVYR21JWjFa?=
 =?utf-8?B?dXlNVm1ncmFIczlUT3ZhUXc5RWlZTE90anhDd0NnK25rcUxMM1Fjci84SnNw?=
 =?utf-8?B?SE5UK2lzQlRFTDRTeWpnSjRpL3pWSWZ4bmZGaHJGaVh0RW1NS21rckRwb2VD?=
 =?utf-8?B?b3hKZ2JuUU9ad0g5NE9Ha2t0WUhTUUhvUmtTd1Y2WXJkeGdXVTRSaVRBOUtk?=
 =?utf-8?B?S1EwMkV6VHlzcklzQTVlVlpuNklXOThQNXlVZUcweEJ3RGFxaUV1djNCR3FQ?=
 =?utf-8?B?VGxBMlJ4Z0lGNzNSTkNXdDBNUXVoRlM5SGxPR1BWdWxSZnBJY0JPRkNqZG9O?=
 =?utf-8?B?OTMxcC9DRTY5OVJscS9jM3VhUExOTVpkdmRwTUZSR0d1VXhaaEVxVktSbWNk?=
 =?utf-8?B?QjY0ampYanJDd3p5aEJDVmtjVnh4eUpUTDJtT1NLY0o0M0krNUZGNG5tTjdP?=
 =?utf-8?B?clBnM2k0aksrZnhqZlJFUG56MktTK2lYdWYxVVY4V1c5eFlPc2RZb3ZvaWh4?=
 =?utf-8?B?MEtWdDY3R3Y0YVRSbjJQTndHSlBlSGNhSlJDTlNqS1drbWpzUGhjV3MzV1dz?=
 =?utf-8?B?Snk3anRBMXJoTmI1VzdXZnBPQi9ka3A4SHRncjFiRUJuQzFnS0tnWG1aSVgy?=
 =?utf-8?B?UlpLeW43NkZGMGVJemFhRkxadEJKbVAyOTNmcndheElUcmU5WDdTdTV6Zy9j?=
 =?utf-8?B?bmVHbjRiSWk5VHZ1REYzcVlEcjh0cTRsci9sSlBKUEZKYk5rRWk2eVRDM0lR?=
 =?utf-8?B?dzQ5ZVMra1FweDYya2c4WC9kRnhOSE54RCtYVXhhYjZNRXFnbkZ5RHJYenRp?=
 =?utf-8?B?RkFLTkxxM1M4S2Y1N1loR01DYVlyN0lNNDlnSHEzSFgydjdVUFIzZ3k4NVl4?=
 =?utf-8?B?MUw0cnhncmpvMW9lL2R6TmFvZzlRa2R0dFFYSW1wS3JYRy80Rnh4Z2dhSkFv?=
 =?utf-8?B?NW9ITXpTN1JpaG9oa3hLUnpPMUxhelBhQTFTaFo1OU93aEtNcXVPZ3RDaUg5?=
 =?utf-8?B?Y29uK0x4ZTRaNnV1cXlQSitrYkUwMkZYbjlTMmRNRDIrbGdsSXo3dUZteDcw?=
 =?utf-8?B?ODNENEVpQUN0dmEwYVZTTzhGQ1lmdGVvMUtOMDV2c2cvZzU2cEJhSGR1UlZs?=
 =?utf-8?B?Q1ZFdy9WbFUwZnh0UVU0VC9jOFlwcjduS0JnelIrTzhlNjk2d0tyTy9QS2lH?=
 =?utf-8?B?VEtHOUR1MTA1ZG8vUEw4cUd4elc5eENEa1NvT0RObkY3NVJ5Q1FJR09rbHQv?=
 =?utf-8?B?bFpjOTJkUjFuZE5EajJ3a3d3YWgzZ2xhUEpYTVRrWXVRcytSUUxFWTZVTTVl?=
 =?utf-8?B?UkljeDlweHRQdmlxZU03bTBxUnIyOGpVMldGTEQ4QzdRMzZpL1RtVTZmUTJl?=
 =?utf-8?B?S1c5ZVZDbEhqVGgzMVd6cG9Wcld2S1Q4Y3RjaEtyVmU1SDlFVVBmMFBwRDVp?=
 =?utf-8?B?bTNEOUNJRUdobXdacWJEYUJnbGFNcUVzUWNTOVhRNk9tY3RuVDN5UlYyMndW?=
 =?utf-8?B?OEcyN3Vmd3NicFdKSThuNFNHZ2ZpUEJkWXZudkNFSFYwUHg3WERPSDJ3Wk1k?=
 =?utf-8?B?WDJCMWsvMDFKSTdvcHlzWGFxbFZ5S2c1clZ0RjltQ0J4TkNJSFYva1lYdFNp?=
 =?utf-8?B?dTBTYnA2enZkVkttZkMvNFUyVnRQNTBOR1ZmeCtBdTJobSttTG8xNm1EdVY0?=
 =?utf-8?B?dnlyRzZlcGNka0s3V1hpdU5JWEZsby9SY0lmcUNxeEcxM0NPbUFxRjg5dFVk?=
 =?utf-8?Q?yrpRaHMbntU0L7IPjn7w80Uzu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c1bd1f-e225-4ef3-0630-08db812bea07
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5392.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:56:21.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FgpJc0c5qaHAzgnkmWwgRBDGb/0sENJf0AV0af7B9T3Kg8sq6Rmn7t69JI3LEhFwGGxtKZcf59IyOZBjDSc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8954
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 07/07/23 23:17, Boris Burkov wrote:
> On Fri, Jun 30, 2023 at 04:03:51PM +0100, Filipe Manana wrote:
>> The function btrfs_free_excluded_extents() is only used by block-group.c,
>> so move it into block-group.c and make it static. Also removed unnecessary
>> variables that are used only once.
> 
> Since you added the btrfs_ for the function that's exported in the
> header earlier I think it would be nice to also drop it from this
> one as it goes static in block_group.c.

I don't think we have a policy to make static function without the 
"btrfs_" prefix mandatory. We have plenty of cases with and without the 
prefix.

Personally I prefer to have the prefix, because when reading a function 
call it makes it obvious that it's btrfs code and not generic code being 
called.

However I'm not against dropping the prefix, if that's what everyone 
prefers.

Also btw, you forgot to CC the list... for all patches in the same 
series. I'm CC'ing back the list here, but not for the other patches.

Thanks.

> 
>>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>   fs/btrfs/block-group.c |  6 ++++++
>>   fs/btrfs/extent-tree.c | 12 ------------
>>   fs/btrfs/extent-tree.h |  1 -
>>   3 files changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 7485660a1529..796e4be167a0 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -823,6 +823,12 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
>>   	return ret;
>>   }
>>   
>> +static inline void btrfs_free_excluded_extents(const struct btrfs_block_group *bg)
>> +{
>> +	clear_extent_bits(&bg->fs_info->excluded_extents, bg->start,
>> +			  bg->start + bg->length - 1, EXTENT_UPTODATE);
>> +}
>> +
>>   static noinline void caching_thread(struct btrfs_work *work)
>>   {
>>   	struct btrfs_block_group *block_group;
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 701fa08cffb6..b0fcc2a042ad 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -69,18 +69,6 @@ static int block_group_bits(struct btrfs_block_group *cache, u64 bits)
>>   	return (cache->flags & bits) == bits;
>>   }
>>   
>> -void btrfs_free_excluded_extents(struct btrfs_block_group *cache)
>> -{
>> -	struct btrfs_fs_info *fs_info = cache->fs_info;
>> -	u64 start, end;
>> -
>> -	start = cache->start;
>> -	end = start + cache->length - 1;
>> -
>> -	clear_extent_bits(&fs_info->excluded_extents, start, end,
>> -			  EXTENT_UPTODATE);
>> -}
>> -
>>   /* simple helper to search for an existing data extent at a given offset */
>>   int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
>>   {
>> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
>> index 3b2f265f4653..b9e148adcd28 100644
>> --- a/fs/btrfs/extent-tree.h
>> +++ b/fs/btrfs/extent-tree.h
>> @@ -96,7 +96,6 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>>   				     enum btrfs_inline_ref_type is_data);
>>   u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
>>   
>> -void btrfs_free_excluded_extents(struct btrfs_block_group *cache);
>>   int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, unsigned long count);
>>   void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
>>   				  struct btrfs_delayed_ref_root *delayed_refs,
>> -- 
>> 2.34.1
