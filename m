Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AAB69DEDC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 12:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjBULcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 06:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBULca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 06:32:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0BA72B1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 03:32:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaO4MtyzwAUWlknuouq8xFQ8RpqX5XJ+KKnjeQZL6rYROR9EPWt1drZMom5fYufcLYjMx/AvExhV3tLolG4mwE8GDMxGL2xStifAqn0gP/4Pgc9Kw9j53e6V7NksSbinfDAn8UF+cjPNTcPK4FnTUYWRcctQyDmwBoMoCSUIom6UlozwWV0E8eTeDhKmFSQork+Y2vZoijsAihXUan2uzPHs8qTb10a1Ns540mEps0GEJ3xuLBBVFoO6oUyFB3ojnuNkZolptvyZ+EBjLzgBwqEOaUYMmhgAIkHgCSpSnnwbbK+v6MxMg0yJ20EEfS124eNjDNEsEBA3hxS1sxp06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHRfV0Yzr9Aufynhqu2EBcRVzNDlQQ9hp56i1AYJslY=;
 b=FYz0YTMApL9bmrKjh15VKxF2aXOej8CEVQYFnXAe24J4Du8ghTlSDH2QhU7QK4rRXcE79J4oVN9JhvmbKq0bcOY+JLO+1gFOVMSTDNPsd5JrUyjPbPqDlHRAdx2xD3DN8PvY/j6DDYCcxapH73ismLyVBtCjcBHiP5rhzYwJfPJ25+QkRq7CkUZIvjNPSe4Ysch2b6S0NVALjYvuVIrBAyA8eTOY9V7NS/puX+UxWZuHGuGFmQLBdgvOcGvY+57Xc2SQ2Q2Q5j1DKQFKwCukxG77FqVI9E8DiNUd9/pzyGSOqMrJ4p+fgacEHJ19WOxAYSA1IwXmTzL018pi+YuNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHRfV0Yzr9Aufynhqu2EBcRVzNDlQQ9hp56i1AYJslY=;
 b=3VYRPlCJA87/g7SC1YlqvPi7y8h050Pkht0FJNrDMov9ADWeg0wVit/USM13ix/Ckm4WYW7D1DLzE3IharpYkhlF+machcM7XXaFkjlJaYI+FIqoVkHAomcy/4kVSh/oKkz6MgYxTPCHq+wuszx9q7awzkpmBbBYYtz9NB1oswVXeP7jnIAzZIpx3slkqoeRSsa7RQf78EPAiZa4YMBxVmA61ciQK8KcZlO87pb/KZH2TCxY00ReAu7e8DiNZXlWa3jm0aeVIVrlaGAwTeAQFh5nuusY6fn2YgDl7z1bALUUCv8vcUnoYa9NluHg2uS5BSXxVKNqM31At0VAM+NRTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB8000.eurprd04.prod.outlook.com (2603:10a6:102:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 11:32:25 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 11:32:25 +0000
Message-ID: <8a536593-943f-46f2-f3df-23c78cd9874a@suse.com>
Date:   Tue, 21 Feb 2023 19:32:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-9-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 08/12] btrfs: remove the compress_type argument to
 submit_extent_page
In-Reply-To: <20230216163437.2370948-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddb5bf1-b95c-46df-0d9e-08db13ff4e3d
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWhiTeAwCQtSIKTqJqLZFVx0HylKGm8t1csHivRISCLs9U6hNCDo3ceWJXeC2efr7bAQSpYzl6g3K6ilSspXF+3ChWnvQgSjNo5QBdcB62RJbR5SHP4qVxGXNuvvH7QmmZ2GI898z666aLvXDoZhoh281OyKkPTeFLMle0aXn6+6r6EWj6kqWHd+I0aDc0qj6CPTOti5zfflem0rZLVuRJd/3zziUIFlA9aRFKIIe0zThywX/QajhUgGPYJ9WK7EzAagOANI1vPKYUh7iaH5f/oizZZfiLNgTCL4ie9EqOPsCGBARq/w7aclID544oHJoDD4nKyNDsh3G9JiTJSF8AqSYFr9l08RfWWMPTYggX3CX0hSJV/jDPJ0QpRzQ+c4OQGELl+P2mv6B7/fDxcmJW1XYSHuK0WCt5VBCuZw3a5gDoUjbJ988/UPqhDZ/QIpLcxqTgFAIm9KPNXTHkE5Axd3Q4OLWFfXNP+lCIAWVQnForfTry5CsQ2zIDWgLuwVo3RQkonvRp3naR1ZaXl9GpXyk72PKBL02uCW0oDfWbPhgrqpTgUe/n11M+dUf1KLZJTNKS1njqiSCgV1IOvg0buFY9kExtNDxJugTp4MUn3wKIwCHyxJ95N3/628PE7ccQU5K1aObV5UKk5M+GCfP45MNY9oVjh7VwwkWVR+zaOI3Lvml/9/ix8vRrrwKdDOwcdldHlu1X2gOlee36pJYtWawwqKhiAiTuoSL9S6ak0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(8936002)(5660300002)(31686004)(2906002)(41300700001)(53546011)(4326008)(66556008)(8676002)(66946007)(66476007)(110136005)(6636002)(316002)(6506007)(478600001)(6486002)(36756003)(6512007)(186003)(6666004)(2616005)(83380400001)(31696002)(38100700002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzRRcEwvYkxuUkR2NWpIS0pFdnJlQTlQUzJ1WFNoaUx2TGdZbTRha2U3TlMz?=
 =?utf-8?B?MGdQaW1oRXp5UWtHY1lCZjkzWXRtUCtMMU05eHd2WnVjd3Z6V1Y4WkE1bDNw?=
 =?utf-8?B?UEFHNkNpZEY4dStra095RWNCYTFaMkc2ajlJQzB3Z09kckxHc213aGJYTUlz?=
 =?utf-8?B?Sm1ON1ZOV3NhRWtUOXJDUXc1YVlERGk1SjlxUE9lY0hiZ1g2dUVyUUkxczBC?=
 =?utf-8?B?L2JzV2RBTTZXYTNUMTI5RmFvSXBwRXNxRFRNR0tHeTZQS1FGYVhtZHFUWmN2?=
 =?utf-8?B?d3pFV3owWHRERjYyL3ZwRzk2VW5XSEc2Mlo3bWd0dXpkS3BqSkNPRGg2K3Fs?=
 =?utf-8?B?OTd4dGxZZFcrWnhoU1h4S1l6VVJLckpreStsZXJUb2VudXJIQzdoVEIzMWFy?=
 =?utf-8?B?Y1FxZGppRC92VWZLblJUVnpvZUQxR250MUdIditrSWFXeEZjc0NVUlFDbHUr?=
 =?utf-8?B?bTdpVStFU2VWWldsOE1VRTBVTDk1ZGVRZVY1SmNoampqd2w0QkpwdkxpcHlj?=
 =?utf-8?B?SWx1UUR5S2h1MDVkc2RoTkx1V1JZd1lmSXhvNDdSdTRMSkljS3lZQkxNZ0Ja?=
 =?utf-8?B?MVl2QTZMYXF1K3hVVlBqaDU0L2pjZ3ZvZlZyMllRcFJqdXIyZ0VXdnlaYzNh?=
 =?utf-8?B?bThVbVVlQ3dnSndNc3NhcTJ2Smk2dWdydlFwVzg2b2dFZHhOc1NhZno3d1dU?=
 =?utf-8?B?ckYxWHM3Rm1qU2pHOWhnR1hoOUxxNlZYK2ZON21OTkQ3YzQ0VXJNVlg2V2s4?=
 =?utf-8?B?dGZpVlVlajZYRmdMUWNzNUx4bC9zaCtCUUM3ZytJVlJKell5Yy84NGZhekRy?=
 =?utf-8?B?SDFJa3dmdC9vRGt1MTlwcHJpSVd6aVdpNE1CU1JSNm5wMDU3Y0dRcWRQMjBK?=
 =?utf-8?B?cVZTTEhKdjVMVEYxaG1aNTdsMXFsdGpnZ1ZaWnBoWWpwbC9uWEhkeFBUUjRh?=
 =?utf-8?B?RGNIOGlxRWxXVWJ3dGdjQU90SEE4RWNtc1pYYlNqc3BHWW5UbnhrSi9NZ0Nv?=
 =?utf-8?B?bGk4QTBIMkt6N1hPQVZXdU4wWEd6SW1UMEluSG53STBuNjloT3oxZHV5OU5O?=
 =?utf-8?B?OTZEWnBVUE1sQU1TOTNaeE9JVGdhNFpBZkhlU1Q1UHczVFdWTWZYSU5MaFZK?=
 =?utf-8?B?SGE0Z1U1MGFqakZ5ZG0vM2JJN2p2MWsyZktIOEhZTGllcjgvd0NRREo0NG1U?=
 =?utf-8?B?MktqV1FLQ3dNSmUranA0UkJDLzBHNnl6bDVrdDVlSkwrSUdpNzY3RnNEcGhQ?=
 =?utf-8?B?dE5sbkpnUnZKZlJJT25rVnN1andycitQcjlGSXM3VWlIMS92VklhSzJNeHY1?=
 =?utf-8?B?ZHVwM0Nna3RSMGFsVThpWU9OdThvNjhTaU04V3NpYUpvRnhWR2cyaGRodllX?=
 =?utf-8?B?dlFwbEdUVDN3RGlDeml0eE1rbEhlSHE4a1hzbkQrb0YrTk5xT3pNUFdGS01z?=
 =?utf-8?B?bjBCeXFwMzMzbWUzSzBQdlk1cVBJaEpTdU4yNFZpR0p5YUNpVWxjUTYyYnNZ?=
 =?utf-8?B?NlFmc3pyZXVybUVCS2YzNjlVbVFrY3pobXdRQkFrbk55YjBVd2Q3MTFTQ09y?=
 =?utf-8?B?Q3Yvd29JenJiaEFpQzF5WnVXRFN0bk1BNHdPZzJoSUJ0dkRzNDBvWnNveHpx?=
 =?utf-8?B?TFpZbTFYNm4rbDFjODhRVmpIdHhuV2pXQVBlY2MrZ05FMGtaYWd3V2djb3Jx?=
 =?utf-8?B?eU1pNHRHcm5nV3VQV2Q1S011TGZFU2tobERDZDZTcEg5T0xCbUcwdSszSXBS?=
 =?utf-8?B?ZVE0VFl3WmhXNnd1emIvUjV0VFBLc2p2OUZLdWhUZGUxRDFIc2tMcFIwdU5w?=
 =?utf-8?B?S3Y3TnZtaUZrZW1PODBWNHVndWdmQ010QzBmQ285Q2F6S0hJR0kzYit5N2R4?=
 =?utf-8?B?akhBRkowSmJ1M0NRTkVPdjdjYlFtVy9UamJOUXpMdHhMWUdkOEhheVBIQ0xQ?=
 =?utf-8?B?aWpHM0dlOU1hZklBYkhmZlRwamNTL3U4a3lXaDZxQUMvUGc2T3ozVlF1ako4?=
 =?utf-8?B?S1I2eW8rUEhYdEZ4N01zUzcvNkFFUFVBeVRDNlZZRCs2Y0k0OXUvRS9IZldI?=
 =?utf-8?B?K2tFS240a1pXUTVrVUhIN0JOblVNTXNXQ1NQMkxiaSs5cGpEMCtRWUJSQVlF?=
 =?utf-8?B?U2lFZXZxK2lTSUIxY0JHdE9Hd1hEUW9NNEdycUxhTGgrb2ZxZDNQSnpBNDUw?=
 =?utf-8?Q?6wiX2w4n7V0DcNtHrxTncGs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddb5bf1-b95c-46df-0d9e-08db13ff4e3d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 11:32:25.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +A4wMMofP6Dqjakxhi4ATddRsnRfuzcWOsR3W3+iMfwS8wHHRd8voXTut2Ogqy7J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8000
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
> Update the compress_type in the btrfs_bio_ctrl after forcing out the
> previous bio in btrfs_do_readpage, so that alloc_new_bio can just use
> the compress_type member in struct btrfs_bio_ctrl instead of passing the
> same information redudantly as a function argument.

I'm never a fan of the bio_ctrl thing, as it always rely on the next 
page to submit the bio (of previous pages).

Thus I'm wondering, can we detects if we're at extent end, and just 
submit the bio if we're at the extent end.
So we don't always need to pass bio_ctrl so deep?

Thanks,
Qu

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 31 ++++++++++++++-----------------
>   1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 24a1e988dd0fab..10134db6057443 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -967,8 +967,7 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>   
>   static void alloc_new_bio(struct btrfs_inode *inode,
>   			  struct btrfs_bio_ctrl *bio_ctrl,
> -			  u64 disk_bytenr, u32 offset, u64 file_offset,
> -			  enum btrfs_compression_type compress_type)
> +			  u64 disk_bytenr, u32 offset, u64 file_offset)
>   {
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct bio *bio;
> @@ -979,13 +978,12 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   	 * For compressed page range, its disk_bytenr is always @disk_bytenr
>   	 * passed in, no matter if we have added any range into previous bio.
>   	 */
> -	if (compress_type != BTRFS_COMPRESS_NONE)
> +	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
>   		bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
>   	else
>   		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
>   	btrfs_bio(bio)->file_offset = file_offset;
>   	bio_ctrl->bio = bio;
> -	bio_ctrl->compress_type = compress_type;
>   	calc_bio_boundaries(bio_ctrl, inode, file_offset);
>   
>   	if (bio_ctrl->wbc) {
> @@ -1006,7 +1004,6 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>    * @size:	portion of page that we want to write to
>    * @pg_offset:	offset of the new bio or to check whether we are adding
>    *              a contiguous page to the previous one
> - * @compress_type:   compress type for current bio
>    *
>    * The will either add the page into the existing @bio_ctrl->bio, or allocate a
>    * new one in @bio_ctrl->bio.
> @@ -1015,8 +1012,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>    */
>   static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>   			      u64 disk_bytenr, struct page *page,
> -			      size_t size, unsigned long pg_offset,
> -			      enum btrfs_compression_type compress_type)
> +			      size_t size, unsigned long pg_offset)
>   {
>   	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>   	unsigned int cur = pg_offset;
> @@ -1035,14 +1031,13 @@ static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>   		/* Allocate new bio if needed */
>   		if (!bio_ctrl->bio) {
>   			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
> -				      offset, page_offset(page) + cur,
> -				      compress_type);
> +				      offset, page_offset(page) + cur);
>   		}
>   		/*
>   		 * We must go through btrfs_bio_add_page() to ensure each
>   		 * page range won't cross various boundaries.
>   		 */
> -		if (compress_type != BTRFS_COMPRESS_NONE)
> +		if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
>   			added = btrfs_bio_add_page(bio_ctrl, page, disk_bytenr,
>   					size - offset, pg_offset + offset);
>   		else
> @@ -1314,13 +1309,15 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   			continue;
>   		}
>   
> -		if (bio_ctrl->compress_type != compress_type)
> +		if (bio_ctrl->compress_type != compress_type) {
>   			submit_one_bio(bio_ctrl);
> +			bio_ctrl->compress_type = compress_type;
> +		}
>   	
>   		if (force_bio_submit)
>   			submit_one_bio(bio_ctrl);
>   		ret = submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
> -					 pg_offset, compress_type);
> +					 pg_offset);
>   		if (ret) {
>   			/*
>   			 * We have to unlock the remaining range, or the page
> @@ -1626,7 +1623,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
>   
>   		ret = submit_extent_page(bio_ctrl, disk_bytenr, page,
> -					 iosize, cur - page_offset(page), 0);
> +					 iosize, cur - page_offset(page));
>   		if (ret) {
>   			has_error = true;
>   			if (!saved_ret)
> @@ -2118,7 +2115,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
>   	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
>   
>   	ret = submit_extent_page(bio_ctrl, eb->start, page, eb->len,
> -			eb->start - page_offset(page), 0);
> +			eb->start - page_offset(page));
>   	if (ret) {
>   		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
>   		set_btree_ioerr(page, eb);
> @@ -2156,7 +2153,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   		clear_page_dirty_for_io(p);
>   		set_page_writeback(p);
>   		ret = submit_extent_page(bio_ctrl, disk_bytenr, p,
> -					 PAGE_SIZE, 0, 0);
> +					 PAGE_SIZE, 0);
>   		if (ret) {
>   			set_btree_ioerr(p, eb);
>   			if (PageWriteback(p))
> @@ -4427,7 +4424,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   
>   	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
>   	ret = submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
> -				 eb->start - page_offset(page), 0);
> +				 eb->start - page_offset(page));
>   	if (ret) {
>   		/*
>   		 * In the endio function, if we hit something wrong we will
> @@ -4538,7 +4535,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   			ClearPageError(page);
>   			err = submit_extent_page(&bio_ctrl,
>   						 page_offset(page), page,
> -						 PAGE_SIZE, 0, 0);
> +						 PAGE_SIZE, 0);
>   			if (err) {
>   				/*
>   				 * We failed to submit the bio so it's the
