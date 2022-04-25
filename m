Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1850DBCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 10:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbiDYI7s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 04:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiDYI7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 04:59:45 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E544713D61
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650876995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w70q/opNbY73C9RA3Abwe0XibG+yE9qXGnlBdLE5F2Y=;
        b=aeuwU8hroBY1JAIw7wSdN4wSSnQF1ck8TgJgrT2l5AzRecNSe1kSkbjYZexAYyq25Wcy26
        V//uptIf/IMhTvaCvAcRAbBWWkj+/RZ6bvRAUBA/oInGixFIq7xncJ36Iu1sRg+oZ/snuK
        J9AOyBo5zQEiNiGzL4dR0r9F5EDhHAM=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-MjeiwF-rNS-rC5xxgwruiA-1; Mon, 25 Apr 2022 10:56:32 +0200
X-MC-Unique: MjeiwF-rNS-rC5xxgwruiA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAW8358agpnk63K8C8xyNqWStuJwkdnULjPq+RXGVzmIx/ZP+ratbS/3g/xcF3xVVUri2Z1EDB14/Dm2CL5M9Ek6fctnhAA6Qw4AFjCHI+ICyrElGF6Reo3aiqTEcZg7NgZNahxglUg+z3O/r3gw3NF4Uoz8LDpXx8/PGcC6ukh6+cH/3OQ6o6o0zE93ewOLle7pEbNVzjSIgwdhgfYJKdQlkn3uYAbWQ4ZpVlazWPJkHfkvr4XH8II6OkDeNvglmq33YIPDA47o267u05uGWEI3P/QY0jU2bQGCkn6K6sLdNcNzH6B1XCaySMXFwAGDNzEXyzhWDu4vsJOTwpqSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w70q/opNbY73C9RA3Abwe0XibG+yE9qXGnlBdLE5F2Y=;
 b=n1qGRg01I5BZGNwfNn+IfE7WnrzwUUoPArEGp5x5u/AQwLFAGfZTbRcTqamsk8IFPFuDbHwJkymmkpjHPNWe0kKkP8CwBZFZp6HK8mXubSSS5Emzjnbl/zzv30qFzOBveeaXWE7ONuGDQ8aI7PvtPY8coq9yNW/Yet6g/x5Fiy4Mv9lURwdXjuLtYE9+EemqajhIscPB/b/SqJrj/+N6GhxvJzF5n2JSHy8CoWuLJ3CmtFFCr56pcHEXnxY9bwESxHTYPSCF8VvjRGJ+ii8ZG38u9lqPU+qR5qEQ5HW0dnRIpBncGobAAfLSuJVqma7d+2wGUlzKXqtoeKPV8gU15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 08:56:31 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::21fb:190b:867a:67d2]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::21fb:190b:867a:67d2%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 08:56:31 +0000
Message-ID: <9ae89d00-7047-a207-6fd0-3223871576ca@suse.com>
Date:   Mon, 25 Apr 2022 16:56:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-10-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 09/10] btrfs: refactor btrfs_map_bio
In-Reply-To: <20220425075418.2192130-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1fa77f5-de91-480a-a98c-08da26997daf
X-MS-TrafficTypeDiagnostic: DU2PR04MB8839:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DU2PR04MB88398DE7F5EA950CC92AC6F5D6F89@DU2PR04MB8839.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWeP4+9mGvJLAOiL3OfjDLRy/IBUVM1lxMHIqT9f8IB/OaB4PVPK+D1NjginseDdHqVIkxCxxn9Qh8easDtL2SLmSCKCoiXtC8eAYpTV+tbIMEnYbMsiVExwbv2pAM4uzehpBTWmtYzha7wFFABRlUxWN4CbqyGlBiPmnBq0rvZ3eKKC9xQwgltByuH+KCrdjoEmSld0p+Fj6zEonMd8Tv+P5evKh5Y3ElJ+6T5aEDrI2V9LM3r7+Oqgdb4VuOqdWXlbHG0huELc4/65iBhHJvVH9qtna8TEheIVGozVXBGFjuGqhsBLOoodYCm+Nm5X7YBM60MM7Q30gNgekshxe60vLZO37goqSk3KtTd8few3l4v50NkuGKKuCwWeqP5bt3IvJGt3/oow4rVMTJGVfK6COPDKxkwJGsBxPX1GlfSEhftReTiO8chMa3ok5MtW4LZtmT1ajzWzG//GiotM+ylMN2eJh4qC1CBJ9AqGWeOyDYu+9Qvs+D99lz5k9i0+tXakoskzHD/nrkZ8m/wR/A9qvoO3J4+VaG8DtQpR4sSXUjddrZWieN8Qzr7t55YkrhFGvJuuAnmkSJXiRVFtq+JOyyGvO1tTm6E6r34amsfJ7f/wzxJYRE3Z7eJ/jJf26XYIKD8hpWccT6ALm7vPG6Wnktrgv99xI0s5ZHto77W3Ch6oPWHAWerttMfci1dPI4slrmWH249qoUSg/m6wvEC4xb6ZwvSveWEfJSFIP/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(4326008)(8676002)(66476007)(2616005)(31696002)(86362001)(66946007)(83380400001)(26005)(6636002)(110136005)(186003)(6512007)(38100700002)(5660300002)(508600001)(36756003)(2906002)(6486002)(6666004)(8936002)(53546011)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJRTEhnOEk4NUs2L1ZEcGFRZEZhT3BWQzhiTVkra1FMMTdHcndFTFErOXhJ?=
 =?utf-8?B?SitCZEJPbXhjZEExOGlOT2lWYjhIdFMzU3k3amF3OEprL2d4cmFSQnN4Q2l5?=
 =?utf-8?B?OE5Za1NRS1MvaFZWMnpOaGJ3YVk4ZGQzRTRpcnNxcmVRc0RYUlFCKzFqaDlV?=
 =?utf-8?B?RHlHRGc2M0dFZWFvbGRhcm1YZnY3aDhGZDhiUEFjVWZTb1dEY0tJNmZ1Z2Ju?=
 =?utf-8?B?bmsvVktHT3dwZHVVUlZWZTRZMVduNXRjQnJsYTA2L3ZmZFJCRkQ0TVpvN1li?=
 =?utf-8?B?TE85UzF4bUNLQkJIZmpWektWYkdQeE9HQXN6YTNZWDBSOEVZSExHbnJFdUI5?=
 =?utf-8?B?VlhTbkRpcmxxL1d3cUJUb3NndnV3bUNRRXNNWmN0ZkZZbE9LRWRsRzhSUGpy?=
 =?utf-8?B?bUJFbUtCVGdkVE5hS240Q3lLVnZ2NkZwTVNJQWJjMDVldXlvUkR4c3UvRmhY?=
 =?utf-8?B?N1N3ZTRuWUlXeEJYc1FBR3hGT3hkQkM0eVJmUkMwQVp4aEVlOXRQcjVRVU9m?=
 =?utf-8?B?bnU1ajc0a1owVUJjcUpHdmcrQ3pzaVBzc21NNUpydjNsWTBjUWhjYUttVENr?=
 =?utf-8?B?SE1VREkrdytlNGtVR0Zod3k4Rmo4L3ZhT2JNMlhBanpHcTFJRkx5WTVsenNt?=
 =?utf-8?B?Ykw5V2diTGkvbFFSeURsV0xtRjJhWWMraVRocUFIUTlrd2lzYy9iN0k5eWJF?=
 =?utf-8?B?TkpHbTlRcTBBSzd5T1l0ZU9idDNyTGVoZm9sU284U0UvNkJ5REl6bHRaWnUx?=
 =?utf-8?B?dGpFeW5MMm11T0xpYWFWbk50UU1DT2cxL1dsb3ZhcE5lSEF2TS9sMHBhSXZ5?=
 =?utf-8?B?RGZWdC9BVUh5S1JNSVJaTzRPNi95Zi9oOEt4aGoxSUc4ZThyVXlQbXhQU3Az?=
 =?utf-8?B?ejZmT0t2K2VMZHo5MU1mWjU2TERtUE5XOC9jU08zMTA1OElmeDNRaHFBZldE?=
 =?utf-8?B?Qm1PWGZrbFM3cStUenJIcFp4MVVscmJodGJlN3pjM3VVTXg0UnRTUjUxaldl?=
 =?utf-8?B?S2RBZGxZdzM4aUsxdmo3c3ZDYU5IR2p2bVVQVExlSEc0cVArY0dySllIS3Yv?=
 =?utf-8?B?YzVuMEhZYUJLdHoyeXFpeFlMaE4zZVV4V21jYjk0eDFRcVQyeVRGK2Z0eUM1?=
 =?utf-8?B?bzJNYXg0ZUhiZ3YzYy9KR0d4TlZmTGsxc3pKakZIL2c2NitkSm5Xb1h2WWs0?=
 =?utf-8?B?TWpkNW0wRWJqVGl5YmRyT2RSd0hmZ0ZkYzY4VEtieS9hQ1RPRWk1SE8rQ1lK?=
 =?utf-8?B?WXpyUFd3Tk5MY3BRa2NNVjQ5UVhMbXZCbFFMOGF4RTZsaCs1U29BMzFvVFF6?=
 =?utf-8?B?ZjlMZHc4MllmV2NEb25BVFhMeUZsYzRoUUw1NjQ4S1VvSmVHRHF3RXRGRmV0?=
 =?utf-8?B?UkdRU1V4OXprTzRJYUNyTTBabEpGVHlrYy9jdjJqNmk1NnBTUWdRVjlMcytE?=
 =?utf-8?B?bFh5QWVBbUY5VkRwR2VYUmt5VGZ0alRGbC96MXMvUzczdGdKb3k2bUt6R3JR?=
 =?utf-8?B?bXNRcGo4Q2JLcUhEQk1FbXhFQ3phRExjNDliUS9XU1lIZlVqem9BQm1veW1R?=
 =?utf-8?B?SHZXZklUVEVTSjJwUWszSmxjaHl6Z3R0QndDVkVKMUYvY0hPL3ZGc2NkM0JG?=
 =?utf-8?B?Z1JmZ0dlYVhmbkltVDdhN0kzUmxVUDE2dlJrSzRCSUIrRTBhZGxQUTBJemxz?=
 =?utf-8?B?eThjNENrUkxFTHJpMDJPRUxFYXpLQWR5cm5nMlpJWC8rMkRMWk1HSUdaTlhy?=
 =?utf-8?B?SWVFdnFIU1JSMWpsY1c0NmpSWGgzeGNRUFY5MHVPY0M3VTBGUy9wam85UzVP?=
 =?utf-8?B?SzhQd0xOaWZ0OExwdVlza2ZaQkhNM1UyS0JmbjVwazdjTjdaaXpsa2g1VnVN?=
 =?utf-8?B?bW1nU3A2MG1jYjV2b0EwWWV2MllEYnppZm5BN01scjJLY3I0Y2JqcllZVkRl?=
 =?utf-8?B?N1ZibFl5MWMzNWlZcUM1M0dPWjNtL24rNWw1eEhGQWV0b1N1ZzNWL3lKVUFp?=
 =?utf-8?B?bEwxMGlEMVV2bSthRnRnWjN5Ym9zZjB2aldPaW0vMWlWWXJZSTFZekludnZ3?=
 =?utf-8?B?UVlRTnpXRzNjVnBhNUhvQWFIczZrSE5VS1lrMjV1d1NWNjAxQnhMak8xVXdu?=
 =?utf-8?B?clVncVFoT3ZLVCs2QldyMkpmRFJreWRmWXlMWlYxWFB1ZkRIaVE4alFXR3Vx?=
 =?utf-8?B?N25qV1BQRldHU1Iybmp5TytaWVFva2tnbDBiVkFhN0JyOFJ4UTNaS1R4aUcr?=
 =?utf-8?B?R3Y1RS8yVzkzZnpmZGdHTFFhVmdxLzJkVUtQRjE4TTZ1bG5NNzBVNGsrMTRJ?=
 =?utf-8?Q?fkzEciBntiVtsVDFqr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fa77f5-de91-480a-a98c-08da26997daf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 08:56:31.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3y1Ud634287IpRlyHb7SQzl7xjADc02SlKXvlGuvsa1ESyGUkddXS1qRaozwC8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 15:54, Christoph Hellwig wrote:
> Use a label for common cleanup, untangle the conditionals for parity
> RAID and move all per-stripe handling into submit_stripe_bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/volumes.c | 96 +++++++++++++++++++++++-----------------------
>   1 file changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5f18e9105fe08..d54aacb4f05f2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6695,10 +6695,30 @@ static void btrfs_end_bio(struct bio *bio)
>   		btrfs_end_bioc(bioc, true);
>   }
>   
> -static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
> -			      u64 physical, struct btrfs_device *dev)
> +static void submit_stripe_bio(struct btrfs_io_context *bioc,
> +		struct bio *orig_bio, int dev_nr, bool clone)
>   {
>   	struct btrfs_fs_info *fs_info = bioc->fs_info;
> +	struct btrfs_device *dev = bioc->stripes[dev_nr].dev;
> +	u64 physical = bioc->stripes[dev_nr].physical;
> +	struct bio *bio;
> +
> +	if (!dev || !dev->bdev ||
> +	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> +	    (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
> +	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> +		atomic_inc(&bioc->error);
> +		if (atomic_dec_and_test(&bioc->stripes_pending))
> +			btrfs_end_bioc(bioc, false);

The bioc is allocated by btrfs_map_block(), but freed inside a helper.

This makes the allocation and free happening at different levels, not 
sure if it's a good idea.

> +		return;
> +	}
> +
> +	if (clone) {
> +		bio = btrfs_bio_clone(dev->bdev, orig_bio);
> +	} else {
> +		bio = orig_bio;
> +		bio_set_dev(bio, dev->bdev);
> +	}
>   
>   	bio->bi_private = bioc;
>   	btrfs_bio(bio)->device = dev;
> @@ -6733,46 +6753,44 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
>   blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>   			   int mirror_num)
>   {
> -	struct btrfs_device *dev;
> -	struct bio *first_bio = bio;
>   	u64 logical = bio->bi_iter.bi_sector << 9;
> -	u64 length = 0;
> -	u64 map_length;
> +	u64 length = bio->bi_iter.bi_size;
> +	u64 map_length = length;
>   	int ret;
>   	int dev_nr;
>   	int total_devs;
>   	struct btrfs_io_context *bioc = NULL;
>   
> -	length = bio->bi_iter.bi_size;
> -	map_length = length;
> -
>   	btrfs_bio_counter_inc_blocked(fs_info);
>   	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
>   				&map_length, &bioc, mirror_num, 1);
> -	if (ret) {
> -		btrfs_bio_counter_dec(fs_info);
> -		return errno_to_blk_status(ret);
> -	}
> +	if (ret)
> +		goto out_dec;
>   
>   	total_devs = bioc->num_stripes;
> -	bioc->orig_bio = first_bio;
> -	bioc->private = first_bio->bi_private;
> -	bioc->end_io = first_bio->bi_end_io;
> -	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
> -
> -	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
> -	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
> -		/* In this case, map_length has been set to the length of
> -		   a single stripe; not the whole write */
> +	bioc->orig_bio = bio;
> +	bioc->private = bio->bi_private;
> +	bioc->end_io = bio->bi_end_io;
> +	atomic_set(&bioc->stripes_pending, total_devs);
> +
> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		/*
> +		 * In this case, map_length has been set to the length of a
> +		 * single stripe; not the whole write.
> +		 */
>   		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
>   			ret = raid56_parity_write(bio, bioc, map_length);
> -		} else {
> +			goto out_dec;
> +		}
> +		if (mirror_num > 1) {
>   			ret = raid56_parity_recover(bio, bioc, map_length,
>   						    mirror_num, 1);
> +			goto out_dec;
>   		}
> -
> -		btrfs_bio_counter_dec(fs_info);
> -		return errno_to_blk_status(ret);
> +		/*
> +		 * Normal reads do not require special parity read handling, so
> +		 * fall through here.
> +		 */

I doubt this fallback would improve the readability.

But you're also right, the original check condition for the RAID56 
branch is also not ideal.

>   	}
>   
>   	if (map_length < length) {
> @@ -6782,29 +6800,11 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>   		BUG();
>   	}
>   
> -	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
> -		dev = bioc->stripes[dev_nr].dev;
> -		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
> -						   &dev->dev_state) ||
> -		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
> -		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {

Maybe just make the complex if () condition into a helper?

In fact I see some other locations uses similar complex expressions to 
check it's a missing device.

Thus it should help a lot of call sites.

Thanks,
Qu

> -			atomic_inc(&bioc->error);
> -			if (atomic_dec_and_test(&bioc->stripes_pending))
> -				btrfs_end_bioc(bioc, false);
> -			continue;
> -		}
> -
> -		if (dev_nr < total_devs - 1) {
> -			bio = btrfs_bio_clone(dev->bdev, first_bio);
> -		} else {
> -			bio = first_bio;
> -			bio_set_dev(bio, dev->bdev);
> -		}
> -
> -		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
> -	}
> +	for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
> +		submit_stripe_bio(bioc, bio, dev_nr, dev_nr < total_devs - 1);
> +out_dec:
>   	btrfs_bio_counter_dec(fs_info);
> -	return BLK_STS_OK;
> +	return errno_to_blk_status(ret);
>   }
>   
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,

