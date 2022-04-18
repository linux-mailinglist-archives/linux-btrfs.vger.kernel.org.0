Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF920504D87
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiDRIHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 04:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiDRIHV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 04:07:21 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A401929D
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650269080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YktKdI36eM51oL93gq2bGT7Su0bt3tnzH1bwvVd0pvM=;
        b=NojfdgcNcN7axs61B1RtPkqV+r9pvVl2KW1xXKgV7U6w5KAowwKcASTr7oy6XL7pq7LOjl
        vaG3vyx6mrWrmXXiQbzUMqnn/guDGxtI2AtM5eLCMYDsOY8Z+S3bVn34Q/5LgOPyBMuC21
        +IlvSFxT4tRh9VJas3hZ8OsqoMNo4fY=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-pRo8eI9cPtyE7cngnrZbmQ-1; Mon, 18 Apr 2022 10:04:39 +0200
X-MC-Unique: pRo8eI9cPtyE7cngnrZbmQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4SYLLbOe2x8/lyFntnDdzYvcQIAIwO3EuvdhkwG/KKJIgqc1aIr4JarqLnxol8RCpOBbj2q/X8FSCSxdm/10iOK8cVET/Sh8tIQ3lWJds6nflLRQ6Q8fEiDHXDPDY1cdHVS/8yI7tLVIIRiVpKwzDBY9TimL8HRvE/V4JY5g6OLYLnv1Fc3+1aq1IlDaBy3h93bh2W4dDXUWZL8MGna5j1UeLAW1c3WOdd6AvEaHnikc2ffiIH5kQWGTEhvyaiFNP2OJOmOc8Ch2AYeqdkvzM7NonOUPz+jx4vAQYesnfiifLbzhJHmKDBAUx223DS9sILHt5nwNM1nO9rn82WYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YktKdI36eM51oL93gq2bGT7Su0bt3tnzH1bwvVd0pvM=;
 b=fLVzHXkcckrAWaaoGD6AHS7+RO6mTd2Ywc5KmdJ8GyIQMPcToP2U3ql/wipEZ1S+cCJUq4GO+WO6fL6epwxQUCTxxIO0dZwGJto3rAoTxqO7OFB4EjREUevPc4QuLVqCnXQEe4PTUfKPyOucqb4i3u4fbLaKGlIkY5EBB+ge30XD7MWUJhTYwBIHFWVOaQXKUfxnN9+/odTCowQIwfhBcE1nC54zFanwPccE3Js9DdsHOmLoF9+2VYsfzbcZsOcNnee0Am27xxGR6OUr8MArfXPN2NedddMRV15d7ToL9pyx6OJ2qVqJZXJsH25CoMrPTV/97y6/dqO6dnRKv0I96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by HE1PR0402MB2859.eurprd04.prod.outlook.com (2603:10a6:3:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 08:04:37 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 08:04:37 +0000
Message-ID: <c2cc0ce9-08ad-0107-b0cc-bbd47d8c8e1a@suse.com>
Date:   Mon, 18 Apr 2022 16:04:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] btrfs: use normal workqueues for scrub
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220418044311.359720-1-hch@lst.de>
 <20220418044311.359720-3-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220418044311.359720-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0175.namprd05.prod.outlook.com
 (2603:10b6:a03:339::30) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aab4d5e1-df69-4a41-1a09-08da21121501
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2859:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <HE1PR0402MB28597DFA68B59F9E5E07E4C0D6F39@HE1PR0402MB2859.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwVrabeKxY1xiDr85gAunY6Vt8ehgycKXgm+TuJxnq8iRoavwUzFdceIX/VpFxNPF3aL5k2unZZsdIzqG9p/O+UK8TXnK4M59VUrmwse4r/Qe3iB7Joeo4NArIcJhJ0MS8Qml9JA4BBkW1T1fnu6rzjQ6hg/VujORqrQ1BBB05fXzT3ktNgM6qlY/swlg+j/lK+9BaCooN6o2zyHBlZEaGQ//XjScM4VkDk8YOb5+qrrhrqZbY2Kn5eci4i5tz0m73JXNKSWVkhq1aljLEIkpo9VsBZZ2akZG8jB7sGoZ7AZ3nfl6n2ibzCAwiKxKT/TVlBJ7AaFXrQGo78gsTIbrMaGAD1pzx4DOT8T6Q43eNjzWdEph8Smj07884XXtBos2vyRJQOH/jdULdOGy7iQEuEG78yAtMQzbEASPUuu4mMr2+m6SGzIQrb/QEwRiY75dDXdOfT4VNkW9J/yB+o4wEo6VDTqklOIPiw1hM27VPCyS8FqZGzpqximru7k3mnyCDiHVpZDmzDDB7z95jSTUpKiA38PVS7/z1IyYEAqmUk4voXvcb8+y9flxS08FcPNYi7x2TFnLk4+8cezp+2d2FEAc4IE5xtu0zIyOe1D/e/TcCoOp+75XW/IMdLY40Vh4cuLjFczC+Nc8iPbn8pmdeDQEKPM9SUN7ExnjCPF1CzT1j4E3tYwZWXhYE8t/KShyoss4QYmcfgbYc9MFakzbSTUh5zY5fO+EA+1SO76wqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(6512007)(6636002)(186003)(30864003)(26005)(4326008)(38100700002)(31686004)(8936002)(36756003)(6486002)(5660300002)(2616005)(2906002)(508600001)(8676002)(66946007)(66556008)(86362001)(66476007)(31696002)(83380400001)(6666004)(6506007)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wjc5Z3ZHS0x4bk5MemVYK2ZxTW85ZVlaR2ltK3dsZit2ZStYVG5SM1U2VXJV?=
 =?utf-8?B?Q1BMbTlWa3d1a3MzdHFyVWd0eFg0bVducUlMK1N6S0VXc3E1SVl6N2ZuekpE?=
 =?utf-8?B?TU5vRGVlVjdHLzdHSU8xSGRIZzlFc1ptQlR0dTVYeEJCYjE4YjMzNVJVN2pM?=
 =?utf-8?B?ZjB1Q0pyRGlPc2F3SmJCUm5MOFpQZ3JIMDE0SG9PdDc2N1h4dlR5NmxMZkhk?=
 =?utf-8?B?WkFwK2xaeis4bm8zZ3AyVmZWUzJkYU5ib3kxK0hGMDV1TVlWSUF0L1A5MkdN?=
 =?utf-8?B?MW5pZHNYNG1PbEw4NlVEVkNhQkFQR3lha2ZxamhLcWtGNkc5U3dKRHlDcW55?=
 =?utf-8?B?d1ZhY1BsZjRVc2l2RWtBQnlBTmh1bGs2b2kyQW9EeWlFSkVudkdZTlJ5ZndK?=
 =?utf-8?B?V3dEK3l4UDlMT1BuakR0S1AzY3MvQWlvWlNHaGhoUk9GN1BkVi81akkyUWlS?=
 =?utf-8?B?NW10ZWVnbXliS08xQldUajJydWlQNTVTWVNHZWE3UzNmS3ZmZnZUQXhmRUZl?=
 =?utf-8?B?STBGTzVwejh5MDFtdVZvNXROenJRTzV5VVFtRzZwUGFVUCtVdmRITmJ6UFds?=
 =?utf-8?B?ZDlRNHlYS1N0citXN2dMSkY3SFpkbUlMVjBMRm9rNzUvUEdEREhKNUxzK1Vp?=
 =?utf-8?B?S3h4VXhZL2YveWRacDJLNEg3UFFCZGJIVWV3K1p4eGxDVkQ1dXEzTXJrZnBD?=
 =?utf-8?B?TDBYd3Z2eWM1Z3lYazJjaWpXdXdjUUZuNFVWTWI5d3lFb0Jud0pJa09ydXRx?=
 =?utf-8?B?bU41WUhiTStLKzRna2hubENla3ZQelVGOWs4MWZVZUFqQitKT1ZRVytTQ3RE?=
 =?utf-8?B?WE50d0RsTm9OendybnJ3d0Y5cjBvYzB1LzJmQ21zVDZwdGxuRGEvU1RCSFpr?=
 =?utf-8?B?NnRnek0renJ5ekRwaFBjeTM0V2laQ3Q4REhXVGtBUjh5dUIrbVlBWEd6V2hl?=
 =?utf-8?B?M2RWUVlac25iblJpYkpJTlYvTE4rdVE2cTZSYXBwTk1SWllncFFTR2diVjVk?=
 =?utf-8?B?SmJLeXFoQmRGc29wek1CM0NuTUNHTDNpN0tHaUcxN09wcmFvQ0l1eStSOFJ1?=
 =?utf-8?B?U042bGxCLzRiOStEdEdBd3VVamFrUktuOFRHZzA3M0FVY09CZWowcDVITzZU?=
 =?utf-8?B?L1AvaklvYmNhREdBejRMQnNFRlJVekpoa2F1bVBob1IvcGFIUndHTHZrVnp0?=
 =?utf-8?B?Z0ZmOVI1M3ZzN0dHN2ZURjB0eG0yZFlrdlFWV3dqcDRiTzVXRThWZ0lXUTBy?=
 =?utf-8?B?YnhRTUFaRzRVR2dsZC96dGNCYSszYzhOMEUwYTZDblJsRHFyVXVQSlpIYUNG?=
 =?utf-8?B?OG5VSmhTd2d6cW1lVSs0SG5OazlrZnNWRkhCTTF1TUpNZWRPT2ZPZ2NIaWlR?=
 =?utf-8?B?eFZ6a0szbGdLTkNWa2JmdWw0VzJkZXE0VHppV0tpUjFjWlE5TVZZQldtN0o4?=
 =?utf-8?B?bDRCRWRyd2xVVTJ6OHc0QS9ERUFNa3VBZFNMdFJkMUY3VllYWlNsbU5YZ2Fi?=
 =?utf-8?B?bE9HemtPb0ZGRmVMSG5zV3JKT2s5U3pwRTVXQTJzODVGU3ZhTmN1cVlrK0VL?=
 =?utf-8?B?SlhnRVBBRm1laVJncm1rUWdEREx0dkxJZWd2bm9WN21wRVppUk5scTJkT1JY?=
 =?utf-8?B?RHBNZkVYN1pmM0l6dzFMZGdXQTZwM2xwRGV5RkFsVnhqU0RSUVNkUXJxZHRR?=
 =?utf-8?B?OEpWeGN2M21pS0Jnd2RMbEUxY3BNd09kcjJOUXdYdjc3QVAveElYZDZERDYv?=
 =?utf-8?B?aXRYS3E5RTE5NXFGQkdKQUxxZGplenFEUEtEZ0trelZEdjQ0Z0g1WjJPRXp1?=
 =?utf-8?B?eU1NQTZ6b0JJY1FFbWxES1B2R2E5emU1Q2lYM1lvYWtLSUVEcmZ6eXpZMm5o?=
 =?utf-8?B?M3dCZXdoa3d4VFhDbHZaaEg5T1MzMGxoYjVFaFJiaFZRMmJjTFJyamgrdEdv?=
 =?utf-8?B?d3EwMktpMlQyU1FNN0ZjdXBFZ2xwMzY5ciswTEl5YVdYREp1Wk1HTmUxZDFj?=
 =?utf-8?B?Z1pHbXBjcVU0azNaV1FTRmxJT0ptRjRYeE0vRFZuSTg1Q3hmRWQ1ZVNkV2dl?=
 =?utf-8?B?Q2Q5ZU5wdnZ6UytiSzYwZm1EVFY0NjBJQ21ldUZpdGZVVExpTDlrUVlvYUdV?=
 =?utf-8?B?MWhxTTRLVEQ2RDRIV3VibmJsdVpPTVh2eW1ERlBUaVQ2dWx1bG9FZGFEVVk0?=
 =?utf-8?B?bnBNL1JWeFplT2Fkek1McVlxRk1Dd1hnME8wT3lSN29rckhOMlRBZ0FNRHVl?=
 =?utf-8?B?OVdUcUxDczNZRUUwbU4vK3lKbUtBRGhHNGRhUHNGQ2pUMXhLSWIzZUtNSjhD?=
 =?utf-8?Q?ADZcwAhNHAgJs1aO4Z?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab4d5e1-df69-4a41-1a09-08da21121501
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 08:04:37.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txzv3M9ggnwGOqOon18t5TxTuOQL04eMeDt4Xg9PqNIDJFQYcTzbp8uC5cTJiKoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2859
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/18 12:43, Christoph Hellwig wrote:
> All three scrub workqueues don't need ordered execution or thread
> disabling threshold (as the thresh parameter is less than DFT_THRESHOLD).
> Just switch to the normal workqueues that use a lot less resources,
> especially in the work_struct vs btrfs_work structures.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/ctree.h |  6 ++--
>   fs/btrfs/scrub.c | 76 ++++++++++++++++++++++--------------------------
>   fs/btrfs/super.c |  2 --
>   3 files changed, 38 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 383aba168e1d2..59135f0850a6e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -946,9 +946,9 @@ struct btrfs_fs_info {
>   	 * running.
>   	 */
>   	refcount_t scrub_workers_refcnt;
> -	struct btrfs_workqueue *scrub_workers;
> -	struct btrfs_workqueue *scrub_wr_completion_workers;
> -	struct btrfs_workqueue *scrub_parity_workers;
> +	struct workqueue_struct *scrub_workers;
> +	struct workqueue_struct *scrub_wr_completion_workers;
> +	struct workqueue_struct *scrub_parity_workers;
>   	struct btrfs_subpage_info *subpage_info;
>   
>   	struct btrfs_discard_ctl discard_ctl;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 13ba458c080ce..0be910baf2235 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -90,7 +90,7 @@ struct scrub_bio {
>   	struct scrub_sector	*sectors[SCRUB_SECTORS_PER_BIO];
>   	int			sector_count;
>   	int			next_free;
> -	struct btrfs_work	work;
> +	struct work_struct	work;
>   };
>   
>   struct scrub_block {
> @@ -110,7 +110,7 @@ struct scrub_block {
>   		/* It is for the data with checksum */
>   		unsigned int	data_corrected:1;
>   	};
> -	struct btrfs_work	work;
> +	struct work_struct	work;
>   };
>   
>   /* Used for the chunks with parity stripe such RAID5/6 */
> @@ -132,7 +132,7 @@ struct scrub_parity {
>   	struct list_head	sectors_list;
>   
>   	/* Work of parity check and repair */
> -	struct btrfs_work	work;
> +	struct work_struct	work;
>   
>   	/* Mark the parity blocks which have data */
>   	unsigned long		*dbitmap;
> @@ -231,7 +231,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>   			 u64 gen, int mirror_num, u8 *csum,
>   			 u64 physical_for_dev_replace);
>   static void scrub_bio_end_io(struct bio *bio);
> -static void scrub_bio_end_io_worker(struct btrfs_work *work);
> +static void scrub_bio_end_io_worker(struct work_struct *work);
>   static void scrub_block_complete(struct scrub_block *sblock);
>   static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
>   			       u64 extent_logical, u32 extent_len,
> @@ -242,7 +242,7 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
>   				      struct scrub_sector *sector);
>   static void scrub_wr_submit(struct scrub_ctx *sctx);
>   static void scrub_wr_bio_end_io(struct bio *bio);
> -static void scrub_wr_bio_end_io_worker(struct btrfs_work *work);
> +static void scrub_wr_bio_end_io_worker(struct work_struct *work);
>   static void scrub_put_ctx(struct scrub_ctx *sctx);
>   
>   static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
> @@ -587,8 +587,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
>   		sbio->index = i;
>   		sbio->sctx = sctx;
>   		sbio->sector_count = 0;
> -		btrfs_init_work(&sbio->work, scrub_bio_end_io_worker, NULL,
> -				NULL);
> +		INIT_WORK(&sbio->work, scrub_bio_end_io_worker);
>   
>   		if (i != SCRUB_BIOS_PER_SCTX - 1)
>   			sctx->bios[i]->next_free = i + 1;
> @@ -1718,11 +1717,11 @@ static void scrub_wr_bio_end_io(struct bio *bio)
>   	sbio->status = bio->bi_status;
>   	sbio->bio = bio;
>   
> -	btrfs_init_work(&sbio->work, scrub_wr_bio_end_io_worker, NULL, NULL);
> -	btrfs_queue_work(fs_info->scrub_wr_completion_workers, &sbio->work);
> +	INIT_WORK(&sbio->work, scrub_wr_bio_end_io_worker);
> +	queue_work(fs_info->scrub_wr_completion_workers, &sbio->work);
>   }
>   
> -static void scrub_wr_bio_end_io_worker(struct btrfs_work *work)
> +static void scrub_wr_bio_end_io_worker(struct work_struct *work)
>   {
>   	struct scrub_bio *sbio = container_of(work, struct scrub_bio, work);
>   	struct scrub_ctx *sctx = sbio->sctx;
> @@ -2119,10 +2118,10 @@ static void scrub_missing_raid56_end_io(struct bio *bio)
>   
>   	bio_put(bio);
>   
> -	btrfs_queue_work(fs_info->scrub_workers, &sblock->work);
> +	queue_work(fs_info->scrub_workers, &sblock->work);
>   }
>   
> -static void scrub_missing_raid56_worker(struct btrfs_work *work)
> +static void scrub_missing_raid56_worker(struct work_struct *work)
>   {
>   	struct scrub_block *sblock = container_of(work, struct scrub_block, work);
>   	struct scrub_ctx *sctx = sblock->sctx;
> @@ -2208,7 +2207,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
>   		raid56_add_scrub_pages(rbio, sector->page, sector->logical);
>   	}
>   
> -	btrfs_init_work(&sblock->work, scrub_missing_raid56_worker, NULL, NULL);
> +	INIT_WORK(&sblock->work, scrub_missing_raid56_worker);
>   	scrub_block_get(sblock);
>   	scrub_pending_bio_inc(sctx);
>   	raid56_submit_missing_rbio(rbio);
> @@ -2328,10 +2327,10 @@ static void scrub_bio_end_io(struct bio *bio)
>   	sbio->status = bio->bi_status;
>   	sbio->bio = bio;
>   
> -	btrfs_queue_work(fs_info->scrub_workers, &sbio->work);
> +	queue_work(fs_info->scrub_workers, &sbio->work);
>   }
>   
> -static void scrub_bio_end_io_worker(struct btrfs_work *work)
> +static void scrub_bio_end_io_worker(struct work_struct *work)
>   {
>   	struct scrub_bio *sbio = container_of(work, struct scrub_bio, work);
>   	struct scrub_ctx *sctx = sbio->sctx;
> @@ -2761,7 +2760,7 @@ static void scrub_free_parity(struct scrub_parity *sparity)
>   	kfree(sparity);
>   }
>   
> -static void scrub_parity_bio_endio_worker(struct btrfs_work *work)
> +static void scrub_parity_bio_endio_worker(struct work_struct *work)
>   {
>   	struct scrub_parity *sparity = container_of(work, struct scrub_parity,
>   						    work);
> @@ -2782,9 +2781,8 @@ static void scrub_parity_bio_endio(struct bio *bio)
>   
>   	bio_put(bio);
>   
> -	btrfs_init_work(&sparity->work, scrub_parity_bio_endio_worker, NULL,
> -			NULL);
> -	btrfs_queue_work(fs_info->scrub_parity_workers, &sparity->work);
> +	INIT_WORK(&sparity->work, scrub_parity_bio_endio_worker);
> +	queue_work(fs_info->scrub_parity_workers, &sparity->work);
>   }
>   
>   static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
> @@ -3930,22 +3928,20 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
>   {
>   	if (refcount_dec_and_mutex_lock(&fs_info->scrub_workers_refcnt,
>   					&fs_info->scrub_lock)) {
> -		struct btrfs_workqueue *scrub_workers = NULL;
> -		struct btrfs_workqueue *scrub_wr_comp = NULL;
> -		struct btrfs_workqueue *scrub_parity = NULL;
> -
> -		scrub_workers = fs_info->scrub_workers;
> -		scrub_wr_comp = fs_info->scrub_wr_completion_workers;
> -		scrub_parity = fs_info->scrub_parity_workers;
> +		struct workqueue_struct *scrub_workers = fs_info->scrub_workers;
> +		struct workqueue_struct *scrub_wr_comp =
> +			fs_info->scrub_wr_completion_workers;
> +		struct workqueue_struct *scrub_parity =
> +			fs_info->scrub_parity_workers;
>   
>   		fs_info->scrub_workers = NULL;
>   		fs_info->scrub_wr_completion_workers = NULL;
>   		fs_info->scrub_parity_workers = NULL;
>   		mutex_unlock(&fs_info->scrub_lock);
>   
> -		btrfs_destroy_workqueue(scrub_workers);
> -		btrfs_destroy_workqueue(scrub_wr_comp);
> -		btrfs_destroy_workqueue(scrub_parity);
> +		destroy_workqueue(scrub_workers);
> +		destroy_workqueue(scrub_wr_comp);
> +		destroy_workqueue(scrub_parity);
>   	}
>   }
>   
> @@ -3955,9 +3951,9 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
>   static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
>   						int is_dev_replace)
>   {
> -	struct btrfs_workqueue *scrub_workers = NULL;
> -	struct btrfs_workqueue *scrub_wr_comp = NULL;
> -	struct btrfs_workqueue *scrub_parity = NULL;
> +	struct workqueue_struct *scrub_workers = NULL;
> +	struct workqueue_struct *scrub_wr_comp = NULL;
> +	struct workqueue_struct *scrub_parity = NULL;
>   	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
>   	int max_active = fs_info->thread_pool_size;
>   	int ret = -ENOMEM;
> @@ -3965,18 +3961,16 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
>   	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
>   		return 0;
>   
> -	scrub_workers = btrfs_alloc_workqueue(fs_info, "scrub", flags,
> -					      is_dev_replace ? 1 : max_active, 4);
> +	scrub_workers = alloc_workqueue("btrfs-scrub", flags,
> +					is_dev_replace ? 1 : max_active);
>   	if (!scrub_workers)
>   		goto fail_scrub_workers;
>   
> -	scrub_wr_comp = btrfs_alloc_workqueue(fs_info, "scrubwrc", flags,
> -					      max_active, 2);
> +	scrub_wr_comp = alloc_workqueue("btrfs-scrubwrc", flags, max_active);
>   	if (!scrub_wr_comp)
>   		goto fail_scrub_wr_completion_workers;
>   
> -	scrub_parity = btrfs_alloc_workqueue(fs_info, "scrubparity", flags,
> -					     max_active, 2);
> +	scrub_parity = alloc_workqueue("btrfs-scrubparity", flags, max_active);
>   	if (!scrub_parity)
>   		goto fail_scrub_parity_workers;
>   
> @@ -3997,11 +3991,11 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
>   	mutex_unlock(&fs_info->scrub_lock);
>   
>   	ret = 0;
> -	btrfs_destroy_workqueue(scrub_parity);
> +	destroy_workqueue(scrub_parity);
>   fail_scrub_parity_workers:
> -	btrfs_destroy_workqueue(scrub_wr_comp);
> +	destroy_workqueue(scrub_wr_comp);
>   fail_scrub_wr_completion_workers:
> -	btrfs_destroy_workqueue(scrub_workers);
> +	destroy_workqueue(scrub_workers);
>   fail_scrub_workers:
>   	return ret;
>   }
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2236024aca648..b1fdc6a26c76e 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1913,8 +1913,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
>   	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->scrub_wr_completion_workers,
> -				new_pool_size);
>   }
>   
>   static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,

