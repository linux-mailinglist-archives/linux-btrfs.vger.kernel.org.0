Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15AB61E7BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 00:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKFX4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 18:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKFX4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 18:56:35 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20082.outbound.protection.outlook.com [40.107.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1935BB850
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 15:56:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFM65ATqjcqdItsSKgjDA9BNIa4KFi7QLm09m++QFeRKSnhNWcORd7WZUu9PP6sRHz6SdL9HdMOBtdOJeeEQQXeFqil67TFWNMro3kLdSKOi85jUgaEV/o6U+R6tuWelPqR9L1jwdcb5AfliyuLtjOJhxCiQMjcIhkw/c6AOYl/WxjED0oUCq378TqRgcdiUi4hRBWl79km0rvhgUWbSffLsK02gknVc42yLQ901xPvRtLDDyikVBXQ4IKcf26HYUaDhWiwBl6JrF92T//aLaoD6507GsZiFYzn7Av9XsSaj/q7DCbWLCXLox7ULc4KHXcBEFWbqglxNXe8LuVeh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yMujZ+eUUTBk5QAaIWm1I/FNsvRf53cnGnLkX6jteA=;
 b=K2E/F65y4AAhcTVY1S5IKHi67I6VPhdXj8iZ+2hPgLlMfQajYFqvLk5KCmrJJZvu/xLj6HdOCt6DtiZvyZmupnEtPDwvGuNixJgiyKI1jIEPh100xea2jUeuMZJ0gum60ZmBYiLIalHO+ND0XwK8g1vHZ7kN6aFK2RNW9zL3hxJw1+8xOS+okUOHtuTyoF5ceI5SX4I/DKs5T9LZQUreZ5lo6vqTafjoD6s6PO2tVGbGReeYosiqiYpICC/BuAgZVJj2ek4tuQ04S9baByLgZXp+HCt3V6sJTaUCdi+Q4CDJntQFQLqqxRamwVrV8lUrr7aMhSRByail+NSlZRj2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yMujZ+eUUTBk5QAaIWm1I/FNsvRf53cnGnLkX6jteA=;
 b=ICnB3pr+/yLEk4AA4ujUo9C38Hepp+vQrAvcW0ySRlgSejya9McPj4jDDCnBkdTbmqjldMy48HaAHFQGDWFZTMQUPkLpnVmwEPSAeaBP9e9rsmIKLV4ZvL0sIzt350rqhrSTlWKWfcdCvvu/3Mm0AtUSYhIw+jUxdnM6lc6XC4WGFIDDSqgLYGvumzVvdjQJQRCkcRByjtOual67O4r49LqaOcdiCAZkQJG9jBf6dOqHRHhZMGMab1wcmsLwEe7GK6dxFk/SugWWtNqmlOXsrsu33Wv7PCCYKT7e2ophHoXRCUQ4TQrj/S+A84AgXf9Z1l7chWLz46v76cRD50s47w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7917.eurprd04.prod.outlook.com (2603:10a6:102:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Sun, 6 Nov
 2022 23:56:30 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::411e:e463:2c22:e220]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::411e:e463:2c22:e220%7]) with mapi id 15.20.5791.026; Sun, 6 Nov 2022
 23:56:30 +0000
Message-ID: <5cb4957f-6eaa-535b-501e-1a43060b0013@suse.com>
Date:   Mon, 7 Nov 2022 07:56:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] Revert "btrfs: scrub: use larger block size for data
 extent scrub"
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, Li Zhang <zhanglikernel@gmail.com>
References: <97622c5c2e2dbb2316901c6ebd9792cbf58385fd.1667776994.git.wqu@suse.com>
In-Reply-To: <97622c5c2e2dbb2316901c6ebd9792cbf58385fd.1667776994.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 9872ca63-b2dc-42c3-702e-08dac05286a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bv1KinCCAGLE3QNbjKkUqx39Z9P2FotbLZgrOfMx+7XnAI3PYnQzBf9S6X4Ah5Tq1kLq3KW76bq62SIkwkHYJRtbbcrstbqVLcNh9YSea9qq9Pk8LTNuG15PRfAbjI4j/FSFfw9IpQYdrKtBxmSFz5JtWU5ooO319jDoqVhBTgTPzSKye74CKGx6K1kaP94tmtuEpom9Ue0py2/o7bt2osljFhlFyzg2XCKJk3MMAQl+OUDt8ch+fZtYYUKWzlUFzfidWHUaRTHBrtVxX1O5+wfwbMxjO8qFy7wmqxJrZeg+Ynmq2X2CiP+mvwjyw2KisWaMvydf9vk+zUpquOA6wII6dv7KeuIqjMfoo7JZiV8reLRjcEB7dhG4ohG8lEJJ0aaQV/7R5wkXsdAincyJVUah8YB3GSqfDFdCADHDOJs0pIS6hjHleYVJ3OtfzpJPm7sQyQBASml5PYQoqaokrzdAwcdPoxYaFEpdQxhJ4czXLC97ZOqgRB2i7rNWYwjRpVVupYy8kz6Ose7rrNngmgw3E4pXfqG6N4iuu9Ytwtd3egYQ563Sybl8O7O9jUyiLlN0uQLn0WwBV+zFz9l0ElJrW36xpQP7P+Y10opwFJu5/y8VYRIukvBnGwFeobmzrV+uq36dAHSmXdEEhWVcBgLGneIUj4u7o5q2m0N02b5lIiDeoJ7H97+YAGrrwElyABIGi9vDu6Y5b3czf5P41VYQsN4ySte1UfFCAa87B31Q5ZZeXyG3MeqUMp9uEjAL+Rc7Us/G2DFQf1WjnTL3y+UCe3pnRlURxA+oVvd6fs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(8936002)(5660300002)(31686004)(38100700002)(41300700001)(83380400001)(6666004)(6506007)(53546011)(66946007)(66556008)(66476007)(2906002)(8676002)(6916009)(6512007)(316002)(36756003)(86362001)(6486002)(31696002)(478600001)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBWdVovaDNlTlR6OXpKbWRtOVpMbnJteXRITE1nRFpCZ3N3QkZqSmRmanYy?=
 =?utf-8?B?T2I0d0VCVjgzSm41aFVXekgzNHl2NTN1RWhhc0t6UGNOV2p0SEhKS1pOaDIv?=
 =?utf-8?B?dTFHUURMUHR4VUx6VXRSblQ1R2FNenFkQWNzYzJmZW5TU1hJZjZudWxpcVkv?=
 =?utf-8?B?THU4N1U5eU1ZZmhPck9hOFF1SnlqVmk2c1BmVlZ0U0NQQ2ZGdWYxdEw4aFNp?=
 =?utf-8?B?dmdpMnRhVERsY1BYYWQyWUNaZlVKTnZhZk9MTzFOdmJNY3U2akcrK1FOOGt3?=
 =?utf-8?B?MmE5VTFOc3ltRC9YbkF3Vmh2ZkxVTlZ0cHBFUTZQWEJKaTNvY0ljQXFLcXJs?=
 =?utf-8?B?MWdaQldkMWtvajBoU1kvb3Btc0ZpL3BVWGhoVFl2NnJDcW1kbzBvSWwrdG9i?=
 =?utf-8?B?TXQ5N3cyYk9wRWlIaDVvbHRyQ29KUGhMUEs2dUtDd3UyRmgrSFhVdVRsL1dT?=
 =?utf-8?B?L0dnWDBJM01LcmpVZ3pSd29WNnpQeVpBeGt2dVJxTm5QZ3dnZHV6NjVYTWd1?=
 =?utf-8?B?S2JBMUk0NzFpTXJQNi95UmltaEpyVDdBcWlNcjd5WjFKYVoxR3ZtNzZNNmtx?=
 =?utf-8?B?Z2pGWnA1czRWRE1wTEVRT3E3S3JNR2dXeWdoQk5halpFTFc2TENPb0VLWWQx?=
 =?utf-8?B?L2tSM0I4ZG1jVkd0QTY3UG5TL0VDc3cxVmVwb08xaWNpL1lydjJIVDQwOUpo?=
 =?utf-8?B?T1JodVhDTVp0UEd0RjdlbHNub21GNHF2dlo2TW9PdnI4RFpRd0VsU1ZsZjFB?=
 =?utf-8?B?dWU1MkxhL2dqN2J3MkYzNXZqQk1zZkJ3MERpWW5yV1NLUW55UDhKbFgwR1lZ?=
 =?utf-8?B?aWdrSXdWaVhpT2FYL2c0OVZwRWh1aTVIWnNtR253WjdOTGp3UTEvNzhadEVV?=
 =?utf-8?B?MXFOd0duZ09LSU5ndHJkK2hTQmpBWGQ5c21lQ0N4V2FMMk9kbjJ1OGlVRlQ5?=
 =?utf-8?B?SEVuVFY3eFlxQXNicElvVjBqTHZueENpN1JSYTNLV04rUDdmRm5NN1l5ZERq?=
 =?utf-8?B?RTRYZEZNN3FST3B6WEp6ZTFPTGpaL2lyUFllZFA1NWlMeGVLWWhNM2RvOTNy?=
 =?utf-8?B?VWdSdUc3S3FQOVRIYktDeXZQeFpNdWUvRVRKWFBaTldZeVpyKzd6eFo2L1BU?=
 =?utf-8?B?bVlNTnlScjU4a2ZYSHIxM3NVNXN0R05GYmQyOTR5MitZM0prMUt4NzlIQjFa?=
 =?utf-8?B?SEIyMUNMWWNVTjhERE8yUWFrajM0a2ZLOHVveTJSdkhlc0JsWEowaG9OYXNq?=
 =?utf-8?B?cmUvbFlPc2l0Y01KT01pQkVjbTNOcDFLOXlHNEd4b1ZtczJxK1VHNDhrZXRP?=
 =?utf-8?B?TlZtV1A0Z0l1NzRBcEhNci9NaWhvQ1VDOUZwMXRjRkZPcFYzQi9tNllBWVpD?=
 =?utf-8?B?c3QwSVFsUEw5SXc1UXVubHN5eDdSNFpJMkxJSXJyUjRxbFZLeTdnSDZnRS94?=
 =?utf-8?B?bytjNzgySlErQW5OOG8xZFI3amdESlBPQzVWbjhUSlJoOWdNV0ZDTzFqSS9u?=
 =?utf-8?B?WDd6SzNtNlZ6YkN1bW1CS3d0M2pESzZyV1Z4R2NCSzIzOUhZcHBQcTB5dEFM?=
 =?utf-8?B?eEVOTXhxOGtlZlk4NlNBMXZpOVFMblI0NFErMVRaSGdUbjBGYXFUYXgrZFpz?=
 =?utf-8?B?STVaMmM4RHZUMEdVbU50V053UURTRkl5YTA3ZkNWV3dSbmxVbnpoSDM2WW40?=
 =?utf-8?B?c3BVK3pFbnVYWnhBcnFKUFJoMlQ4UkxzaldwRjkyT2FsTHRJcmwwZ2Z4NWhy?=
 =?utf-8?B?YWphckJiSUdwaE5KQzhnUTk5cytqdmdEMFJraEptZVJaZnhsYVdFTHFOSHN1?=
 =?utf-8?B?aFRodnNSRklPd3JJZWVlUFdJL3pEenJKdlpYenRxSWJZOTJDcXliUXU5eWZF?=
 =?utf-8?B?TDByQ29hV3REc1NNd0dHcSs3cU5OcldKVWxnM1NHdzF5QitnMS83TGlMa3cv?=
 =?utf-8?B?ek1GTk1OU1hhTEZJaVdlSFpZVTlzUjhhQW15YVphdEw4ZytXQTU0Uy9hSzgv?=
 =?utf-8?B?MzRuS0thVEFYVWpBR1UySDVra0hOQTFwVEN1VEF1V3lXSnRJNk51d1pqVXJM?=
 =?utf-8?B?dzk3UlQzY3BCZUZQUTNHZTBsVkk4Q1AyN2M2dzE3TS82Mm5RbWNRNmFqem5p?=
 =?utf-8?B?Qm5NYWZvQ0RiWEw0VHp3Zng1SCt3MUFYd2liTzgxT2RDcE0xQmo0Ym80c3RP?=
 =?utf-8?Q?tRE2rC3vSPK88gV5M+8bNKo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9872ca63-b2dc-42c3-702e-08dac05286a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2022 23:56:30.6280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+0/9iMz09mMXGBfKmMEtqSrtWF4MnAUFecmg2LTuq28GSkgysUdSq8+FXgtVcKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/7 07:23, Qu Wenruo wrote:
> This reverts commit 786672e9e1a39a231806313e3c445c236588ceef.
> 
> [BUG]
> Since commit 786672e9e1a3 ("btrfs: scrub: use larger block size for data
> extent scrub"), btrfs scrub no longer reports errors if the corruption
> is not in the first sector of a STRIPE_LEN.
> 
> The following script can expose the problem:
> 
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   xfs_io -f -c "pwrite -S 0xff 0 8k" $mnt/foobar
>   umount $mnt
> 
>   # 13631488 is the logical bytenr of above 8K extent
>   btrfs-map-logical -l 13631488 -b 4096 $dev
>   mirror 1 logical 13631488 physical 13631488 device /dev/test/scratch1
> 
>   # Corrupt the 2nd sector of that extent
>   xfs_io -f -c "pwrite -S 0x00 13635584 4k" $dev
> 
>   mount $dev $mnt
>   btrfs scrub start -B $mnt
>   scrub done for 54e63f9f-0c30-4c84-a33b-5c56014629b7
>   Scrub started:    Mon Nov  7 07:18:27 2022
>   Status:           finished
>   Duration:         0:00:00
>   Total to scrub:   536.00MiB
>   Rate:             0.00B/s
>   Error summary:    no errors found <<<
> 
> [CAUSE]
> That offending commit enlarge the data extent scrub size from sector
> size to BTRFS_STRIPE_LEN, to avoid extra scrub_block to be allocated.
> 
> But unfortunately the data extent scrub is still heavily relying on the
> fact that there is only one scrub_sector per scrub_block.
> 
> Thus it will only check the first sector, and ignoring the remaining
> sectors.
> 
> Furthermore the error reporting is not able to handle multiple sectors
> either.
> 
> [FIX]
> For now just revert the offending commit.
> 
> The consequence is just extra memory usage during scrub.
> We will need a proper change to make the remaining data scrub path to
> handle multiple sectors before we enlarging the data scrub size.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reported-by: Li Zhang <zhanglikernel@gmail.com>

> ---
>   fs/btrfs/scrub.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 06c6626eae3d..e5dbf875f6d9 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2691,17 +2691,11 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   	u8 csum[BTRFS_CSUM_SIZE];
>   	u32 blocksize;
>   
> -	/*
> -	 * Block size determines how many scrub_block will be allocated.  Here
> -	 * we use BTRFS_STRIPE_LEN (64KiB) as default limit, so we won't
> -	 * allocate too many scrub_block, while still won't cause too large
> -	 * bios for large extents.
> -	 */
>   	if (flags & BTRFS_EXTENT_FLAG_DATA) {
>   		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>   			blocksize = map->stripe_len;
>   		else
> -			blocksize = BTRFS_STRIPE_LEN;
> +			blocksize = sctx->fs_info->sectorsize;
>   		spin_lock(&sctx->stat_lock);
>   		sctx->stat.data_extents_scrubbed++;
>   		sctx->stat.data_bytes_scrubbed += len;
