Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7732769DE95
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 12:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjBULRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 06:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjBULRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 06:17:46 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B483BB773
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 03:17:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhEGiAldqYdGhPd6gYEm9NOFMPMK98BoPu8CV5m0fckR3ebQnZ4VAlvrHNTAvxImVDvB+nCFHSoXLp+NSqw9JQbh6snjTptl+HiGs7aHQ8v4Vcm5lKtMOxhOeDMlmozfyD/5p+cs/vEwPWRaFVDbGEYHvdbDWREp0C/6922tEc+H48vOHWcetVzKjH/lS832s/C+CxV/w8uIjNEkXOFyxvWSLgoixDLcMguEUJdlTi+glXKpvVzfU+iWeWr9/+fEdh0MZCpTIKRyJg13t5AtvjEMW3i+Htstcqu+xXbm/eY0WpI9FMVu0Irr7Ux1GJX/HStdduAtzDlgK2ZIQr07og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujGMZ2qvsf32ExtkrCxkVFOVRV2++3xnFF4rAEOKEzk=;
 b=bPqf29i82L/epdSUz2OPMTjrxL5I83BeHrlQT+EQuwhV2eV/Ar7V3F4FOmhjOI+jzs2DO/dKgk0wKCXuwDk6ZrGs4wbiHWsm4FjwHndHiuTfzGcvrVw9DI6xeEz9R9EMPSyk7hBNd4TL6Nk1bXkPHTgHmoIOIobrf5lMFzULANph1Jy6+0RrI6QFnChq4+HcQc0GRPwbeViV8w+ulIwCMkUQkiqfBg1UO5lJSOHNCECnEh/KLoYmDFelHfx+QcfKkhpm3ZCCYiHRHVAHgq6dVmrTwLkZxmEeU4fCELxCXwbpSUjhLcefkF+No3unauiP/PuZqLJl/2PIhp5tZ5gPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujGMZ2qvsf32ExtkrCxkVFOVRV2++3xnFF4rAEOKEzk=;
 b=ugl9GrBOALEKL9ovMPLRmHoMdq53Ntuvg93XlTPlvw4wjb75iVGf7JcrNTNIUfAE2QPmZyK/o5CISDgtjeN/5PTlWZwJncpTzjUBu0Hjqu4h6Cfwc1g+vjNqCxp3GUDsADf29wXqLit7/aHE8r+6Ft7oizVwRotcq1uTjmq6nll14PsTP3h3RhzDk17VdUiU6vSfplLbhdhKQG6I7D827vfizeXy5Au5uyvZgrDV6rRPa3H+l1GLozFtb2DZKdWowghxKd75xAZkTkh9xDqVHvnA6SAJj0mYumhr7qSK00Lv6GHX04vVsz24dPEoNkqL+joX1HbKc0lIzo+Fu634lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 11:17:38 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 11:17:38 +0000
Message-ID: <785b1af1-e7cb-2ef9-c8ed-61b622c880da@suse.com>
Date:   Tue, 21 Feb 2023 19:17:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 03/12] btrfs: store the bio opf in struct btrfs_bio_ctrl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-4-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230216163437.2370948-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: e16a212d-cbe9-4215-35fa-08db13fd3d63
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86ks//QK6WOB0pxQIMK01ft2Sn6EXFj8EXm9tEmsGLCkRjbdwJIE1Tn+iAx8Lw0aN3GJPRP6gGOPdqt3baw0KpEj7IdYt2Fa0rEcDqxvUKN+DdC+uKQPRmWG+6hAOi1ysRctj6XBt6Qnm+5w08SkUYJaQ+JDnSaJ/SXRsOxQLEzOrOCZk1MELEmwnX58DVdpuUcX0g7vuZhB2Aah1+55u7Mx8zVR0VNZ9SaqLOUbqtC6d4gmohSlVqlQ6y9cZRhUdw3iEUBT5nt1xz/V7kf6Ze8fXUUdFLxjU7IG3Ln+brqFuWM1AvfeCLuzcoNXzM4Xo8XjdSoXWKECjZTCzCHsUOaRWp4oMt+L/LgQMZA7jz2gEpnW6dz+TzsE36ZhlJr/Vf0kL5JjUXRh3QHR73mfZKwFKee4Mgm6B04qISjbazJmai4IlEVHMEsSQ/j5a3eQD0iq/ZD+NI2FwCmrUWSRw2s7ei9sbSzdqzRkhA90azX45DHT1qOBiT/zSpYP1DYO9aMdiG9e+VCFtsQphiP62viCyS1x+BGV6/KVbYlG7Ya7/4r7xQ32h4WxF9GvASjwLemtE2rservlfyMNyb8W1shqoNcn9TE9Ht72uMi968LKQKrdx9Y5N54qjyHQDz2GInD8LY4rxhUkucyt4mTc0H3psv7/KnzIQ7KGw4qY8Ea1UOCJiUHy15EYYLzSqZLaH2gg9bF9kllS3REqTq3Xc7RMjaV2shYRIVHZqezRkv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(31686004)(36756003)(31696002)(86362001)(5660300002)(41300700001)(2906002)(8936002)(38100700002)(83380400001)(478600001)(6636002)(66556008)(66946007)(66476007)(8676002)(6486002)(110136005)(6512007)(53546011)(186003)(4326008)(316002)(2616005)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2N2Y2lTYkV4K2ZtVnViMXgzRGtMaSs0eGQ1NGs5MHJrTnZIMCtVeHVTV0E1?=
 =?utf-8?B?U0pmYlNBeHlpbzZYQzdId3RZRTVWUFNHOWVqQkJQREFWeFNvckNNQ1FJU21E?=
 =?utf-8?B?azRqQXREVmpKTWRPR04rQXN1WDcrMGVGUUlmN3dOY2E0dUIrMmZvTG9tMjVG?=
 =?utf-8?B?TzcrY285UlNaSlltWGdhanU4OHpxTTEzVjM0TktKbDExdDhvK2NHcG05SG44?=
 =?utf-8?B?UWlpaGxINXBGcE1oZ0o1b0tjRjJva1ZLM2dBQ3M5MUFqVFVIQWpJQyt1ZVVZ?=
 =?utf-8?B?VkhrazB5Vkw4TEtxcnpQdFBvbjlEelArT2lySnRRK2plRWVQVnVtemlQSkt6?=
 =?utf-8?B?QlAxV200UFRDTVljU0s2bkEra3prSkYrUlkrWDlzSEtJZUNNZlpaYVJjS25x?=
 =?utf-8?B?enRmYlFkVGtOMU5jOGM5bUhTMS9GeE5UWnN4TVFvMzdoWnIxZDFHUjd4UnVL?=
 =?utf-8?B?ZUcvblZ1QzhIQUpCMWc4QUtIZ3hRS2taaGd3QkZMQXoxemdycWFUVS90eWNQ?=
 =?utf-8?B?bXpZVGRNZllIMnhHVG8yZVdZdUtTeG1aMGg0ek5pdDJOQk5tZW5QUWtVN0dq?=
 =?utf-8?B?Z1FWelZqWGREKzlNd2R1ckZ3NVNoYVpXVnlYZTRlcVR3UmxReHlBbGZyOEVM?=
 =?utf-8?B?eUFKaGEyZHZQdEVCY0syYmRpMmxYczE4eFJvNUpvYjVJZzFrMituK0xwZVpS?=
 =?utf-8?B?K2hzWG5WQjhySG1uNENpTU9ZMWwyZHcvWVRXTUw0YUNOYitsUFNWdU1YN3RD?=
 =?utf-8?B?UUF5MGpLc3NianZyY2dCN0lJOGhHUTJxSDB2N2Q3ZStIZEtya3ppM1JVNml6?=
 =?utf-8?B?OVhKNUtqZUFJM3JYODQra0VxcDkvTlhibDRTaUtLWU1scktRa0VRL09Yb0tB?=
 =?utf-8?B?WURhcFZsdzJ4aFlhWUdRdURDVjEybzFJcnFMZHdnRGpSOS9jQ2RneWxsTGQx?=
 =?utf-8?B?M1RvZW5Jem5rUnorbFBiSDgvdVRpY1NqU0EwWHVrK2RvQXV2cUEyeDN2dnFp?=
 =?utf-8?B?RW1NMVpuQWxiSVF4dVhaYk9aaE5DK1NlcENPNHM5YmQ1bkRnTFhwUXV5Nnpz?=
 =?utf-8?B?ODlrNFIrZmZGcFNaMGxESlk0STJ2Q3FBYUh2cktPanMzOFVTYXpiY2drM0ts?=
 =?utf-8?B?Mnh2czUzZ0tKZFZnOG55b3ZtNjVkY2pxYlNPSnBBNGlwMTN5MC9KWlp5L2VQ?=
 =?utf-8?B?RjNPZTdpRmEyZGZ1M2ZpYjZhRGI2R3AxUHNlZXhlLzhkTzBWZ2FzMGlkWTJT?=
 =?utf-8?B?RTRxWm5RdTN4Qk4rZVQvemZIdk5YeFp0d1FaTDQ3aEp6clptS3lTdWZLSFpx?=
 =?utf-8?B?N2trMEFqUVhqeDFIZ09zWWZsazFmRGhJT3VycVAvRXorU0dqUzc0alZFcmVF?=
 =?utf-8?B?Tk5qYkd3MTN4dlVVSTI1QnFLVllpc1l6ZllNTitGdmNrZExBQjV1SWdHYmJG?=
 =?utf-8?B?b2U1T3Z0dWJxT0hMeVVreUxmc1hDY2M4d3NUUDB3ZG53RUpIMVZMWDQxTjls?=
 =?utf-8?B?dWtPZnh2Y0ZWYkdQMnZlMm5SK1BzT2hmOHFDRm11UEZid2FaMGkwUTF4M3l2?=
 =?utf-8?B?clpaWkZodEZEdC9FNFV3MzhndmNwRzFYRVhDMitXWjl1RVdVNEczT3Z5VWNG?=
 =?utf-8?B?U3BGbWdPQWtWTFZtQ0RnZnd2cEdxS1BMcjFIeStuYlNwcTZ6dnUyRGlGMHp3?=
 =?utf-8?B?Q2J3WFlQWmUxcnFhUEQ1bXkvalVKaXVSMDJaUW9CSmRxR0IydWs1ZUxsMURz?=
 =?utf-8?B?YUEwY2FwQko1YitZbnRxV1JWVDgwSG1sTWJleWl5K3FRMHZkbHhJSzcwTFJk?=
 =?utf-8?B?Tm9rNlpjNWdzeW4wTEJOSnJqQThreis4SlZkdHB4MEVLNkQ0V0doNGtmSk5U?=
 =?utf-8?B?QW5EU09Eck03dmtkRDlKejZZRmhKVjBsekhRZk1OeGxhdFRiYmRPbU4rNUpP?=
 =?utf-8?B?VllaSFZ0b2dVZDQ0WGlJRk1oUXowdjg4eEZsYk5VR25sTU5qUlRERmFCenV2?=
 =?utf-8?B?c01vUlpEQlZYTlMwQ1IxNGh5aUEwSTMrSjNQcloxVHByU2EvVEc3c2x1UDNv?=
 =?utf-8?B?YzRwSElwVkF6dEJIL3hCdEt6V1JUUDNMMUd0Vm5vbG1YR2ZBMzdFWURCY1VI?=
 =?utf-8?B?aUlCYXc3cEVzZW1iQThiYlU3MHAzdUxDaFl5aUN4bXVFYmV6M1hzQkdsSjNK?=
 =?utf-8?Q?5yBRnDNvJvgQN2jy3EfZ2GQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16a212d-cbe9-4215-35fa-08db13fd3d63
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 11:17:38.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylIEEf0CdjUmhJpi/L1EOnkz/jKyjrlUEoH0m9w/G2Y/PYYbDVBdetI2E6DkjGpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/17 00:34, Christoph Hellwig wrote:
> The bio op and flags never change over the life time of a bio_ctrl,
> so move it in there instead of passing it down the deep callchain
> all the way down to alloc_new_bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One less argument again, great.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 65 ++++++++++++++++++++------------------------
>   1 file changed, 29 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e9639128962c99..1539ecea85812e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -101,6 +101,7 @@ struct btrfs_bio_ctrl {
>   	int mirror_num;
>   	enum btrfs_compression_type compress_type;
>   	u32 len_to_oe_boundary;
> +	blk_opf_t opf;
>   	btrfs_bio_end_io_t end_io_func;
>   
>   	/*
> @@ -973,15 +974,15 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>   
>   static void alloc_new_bio(struct btrfs_inode *inode,
>   			  struct btrfs_bio_ctrl *bio_ctrl,
> -			  struct writeback_control *wbc, blk_opf_t opf,
> +			  struct writeback_control *wbc,
>   			  u64 disk_bytenr, u32 offset, u64 file_offset,
>   			  enum btrfs_compression_type compress_type)
>   {
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct bio *bio;
>   
> -	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, inode, bio_ctrl->end_io_func,
> -			      NULL);
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
> +			      bio_ctrl->end_io_func, NULL);
>   	/*
>   	 * For compressed page range, its disk_bytenr is always @disk_bytenr
>   	 * passed in, no matter if we have added any range into previous bio.
> @@ -1008,7 +1009,6 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   }
>   
>   /*
> - * @opf:	bio REQ_OP_* and REQ_* flags as one value
>    * @wbc:	optional writeback control for io accounting
>    * @disk_bytenr: logical bytenr where the write will be
>    * @page:	page to add to the bio
> @@ -1022,8 +1022,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>    * The mirror number for this IO should already be initizlied in
>    * @bio_ctrl->mirror_num.
>    */
> -static int submit_extent_page(blk_opf_t opf,
> -			      struct writeback_control *wbc,
> +static int submit_extent_page(struct writeback_control *wbc,
>   			      struct btrfs_bio_ctrl *bio_ctrl,
>   			      u64 disk_bytenr, struct page *page,
>   			      size_t size, unsigned long pg_offset,
> @@ -1045,7 +1044,7 @@ static int submit_extent_page(blk_opf_t opf,
>   
>   		/* Allocate new bio if needed */
>   		if (!bio_ctrl->bio) {
> -			alloc_new_bio(inode, bio_ctrl, wbc, opf, disk_bytenr,
> +			alloc_new_bio(inode, bio_ctrl, wbc, disk_bytenr,
>   				      offset, page_offset(page) + cur,
>   				      compress_type);
>   		}
> @@ -1189,8 +1188,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
>    * return 0 on success, otherwise return error
>    */
>   static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
> -		      struct btrfs_bio_ctrl *bio_ctrl,
> -		      blk_opf_t read_flags, u64 *prev_em_start)
> +		      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
>   {
>   	struct inode *inode = page->mapping->host;
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> @@ -1329,8 +1327,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   
>   		if (force_bio_submit)
>   			submit_one_bio(bio_ctrl);
> -		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
> -					 bio_ctrl, disk_bytenr, page, iosize,
> +		ret = submit_extent_page(NULL, bio_ctrl, disk_bytenr, page, iosize,
>   					 pg_offset, this_bio_flag);
>   		if (ret) {
>   			/*
> @@ -1354,12 +1351,12 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
>   	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>   	u64 start = page_offset(page);
>   	u64 end = start + PAGE_SIZE - 1;
> -	struct btrfs_bio_ctrl bio_ctrl = { 0 };
> +	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
>   	int ret;
>   
>   	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>   
> -	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
> +	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, NULL);
>   	/*
>   	 * If btrfs_do_readpage() failed we will want to submit the assembled
>   	 * bio to do the cleanup.
> @@ -1381,7 +1378,7 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
>   
>   	for (index = 0; index < nr_pages; index++) {
>   		btrfs_do_readpage(pages[index], em_cached, bio_ctrl,
> -				  REQ_RAHEAD, prev_em_start);
> +				  prev_em_start);
>   		put_page(pages[index]);
>   	}
>   }
> @@ -1531,8 +1528,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   	int saved_ret = 0;
>   	int ret = 0;
>   	int nr = 0;
> -	enum req_op op = REQ_OP_WRITE;
> -	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
>   	bool has_error = false;
>   	bool compressed;
>   
> @@ -1639,10 +1634,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   		 */
>   		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
>   
> -		ret = submit_extent_page(op | write_flags, wbc,
> -					 bio_ctrl, disk_bytenr,
> -					 page, iosize,
> -					 cur - page_offset(page), 0);
> +		ret = submit_extent_page(wbc, bio_ctrl, disk_bytenr, page,
> +					 iosize, cur - page_offset(page), 0);
>   		if (ret) {
>   			has_error = true;
>   			if (!saved_ret)
> @@ -2115,7 +2108,6 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
>   {
>   	struct btrfs_fs_info *fs_info = eb->fs_info;
>   	struct page *page = eb->pages[0];
> -	blk_opf_t write_flags = wbc_to_write_flags(wbc);
>   	bool no_dirty_ebs = false;
>   	int ret;
>   
> @@ -2133,8 +2125,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
>   
>   	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
>   
> -	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
> -			bio_ctrl, eb->start, page, eb->len,
> +	ret = submit_extent_page(wbc, bio_ctrl, eb->start, page, eb->len,
>   			eb->start - page_offset(page), 0);
>   	if (ret) {
>   		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
> @@ -2161,7 +2152,6 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   {
>   	u64 disk_bytenr = eb->start;
>   	int i, num_pages;
> -	blk_opf_t write_flags = wbc_to_write_flags(wbc);
>   	int ret = 0;
>   
>   	prepare_eb_write(eb);
> @@ -2174,8 +2164,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   
>   		clear_page_dirty_for_io(p);
>   		set_page_writeback(p);
> -		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
> -					 bio_ctrl, disk_bytenr, p,
> +		ret = submit_extent_page(wbc, bio_ctrl, disk_bytenr, p,
>   					 PAGE_SIZE, 0, 0);
>   		if (ret) {
>   			set_btree_ioerr(p, eb);
> @@ -2397,6 +2386,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>   {
>   	struct extent_buffer *eb_context = NULL;
>   	struct btrfs_bio_ctrl bio_ctrl = {
> +		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
>   		.extent_locked = 0,
>   		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
>   	};
> @@ -2683,10 +2673,6 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
>   	u64 cur = start;
>   	unsigned long nr_pages;
>   	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.extent_locked = 1,
> -		.sync_io = 1,
> -	};
>   	struct writeback_control wbc_writepages = {
>   		.sync_mode	= WB_SYNC_ALL,
>   		.range_start	= start,
> @@ -2695,6 +2681,11 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
>   		.punt_to_cgroup	= 1,
>   		.no_cgroup_owner = 1,
>   	};
> +	struct btrfs_bio_ctrl bio_ctrl = {
> +		.opf = REQ_OP_WRITE | wbc_to_write_flags(&wbc_writepages),
> +		.extent_locked = 1,
> +		.sync_io = 1,
> +	};
>   
>   	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
>   	nr_pages = (round_up(end, PAGE_SIZE) - round_down(start, PAGE_SIZE)) >>
> @@ -2738,6 +2729,7 @@ int extent_writepages(struct address_space *mapping,
>   	struct inode *inode = mapping->host;
>   	int ret = 0;
>   	struct btrfs_bio_ctrl bio_ctrl = {
> +		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
>   		.extent_locked = 0,
>   		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
>   	};
> @@ -2755,7 +2747,7 @@ int extent_writepages(struct address_space *mapping,
>   
>   void extent_readahead(struct readahead_control *rac)
>   {
> -	struct btrfs_bio_ctrl bio_ctrl = { 0 };
> +	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
>   	struct page *pagepool[16];
>   	struct extent_map *em_cached = NULL;
>   	u64 prev_em_start = (u64)-1;
> @@ -4402,6 +4394,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   	struct page *page = eb->pages[0];
>   	struct extent_state *cached_state = NULL;
>   	struct btrfs_bio_ctrl bio_ctrl = {
> +		.opf = REQ_OP_READ,
>   		.mirror_num = mirror_num,
>   		.parent_check = check,
>   	};
> @@ -4442,8 +4435,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
>   
>   	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
> -	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
> -				 eb->start, page, eb->len,
> +	ret = submit_extent_page(NULL, &bio_ctrl, eb->start, page, eb->len,
>   				 eb->start - page_offset(page), 0);
>   	if (ret) {
>   		/*
> @@ -4478,6 +4470,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   	int num_pages;
>   	unsigned long num_reads = 0;
>   	struct btrfs_bio_ctrl bio_ctrl = {
> +		.opf = REQ_OP_READ,
>   		.mirror_num = mirror_num,
>   		.parent_check = check,
>   	};
> @@ -4552,9 +4545,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   			}
>   
>   			ClearPageError(page);
> -			err = submit_extent_page(REQ_OP_READ, NULL,
> -					 &bio_ctrl, page_offset(page), page,
> -					 PAGE_SIZE, 0, 0);
> +			err = submit_extent_page(NULL, &bio_ctrl,
> +						 page_offset(page), page,
> +						 PAGE_SIZE, 0, 0);
>   			if (err) {
>   				/*
>   				 * We failed to submit the bio so it's the
