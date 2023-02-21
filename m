Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE869DE9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjBULTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 06:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjBULTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 06:19:12 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F457D8D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 03:19:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grq7uM0D1x5Sb0GIGzsSr7wspuZywypY+yIriVLH3FruaXoEi4YA58TtZ8EYC10iBX7nys0b7+1PH6v/TsGJ11UzJuPnwwpbC6sYfUznZwTfSUAm+OP0ilqs7gjovV2xL88tHMgTwJo9dZGPcAh0DEP8NnR9pgl9+dN8jiR+THCelbfBs4AXGmAbkyDTDwQbojdu6xajBBizetD6vhQ4GqcqKApDcaWxsYQCX7QQqp8lOdOUQc7+/GUpHXdgR+1t9ehVLPtCzuqpklb24D2TpReynw9KF9fWdXYj/d8M9Z07Fxi80pPdsjEjVMfqmwOV9VH1rGabU6nZw57jc6T3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89O+k1YftgXClCm1KzRtyE0A/F8bsEuHaqywVGGDffk=;
 b=M9cK4DuFY19ewx6nevRjoaTJSC5IoJM1e+Qsd6pXFLKFRhFsm9PXopchlk4ZWs7E+p8tR9Qu70HhVj8m+xA5I2slzgXK/BHpA88Ipad4hxwkjc/ar8G47/uJ9KfsKBMLZcZnxJrNgbI6cAY1MBIAmcVcPO7oAvJS0NZ6TzNIMdqEyv9VBdmYDEx5up9DPN0zi87AyFCy0fdKDUx+TQzQGPOIEgq7MmskfBkmRQmp1EILBgQ18PIZ7rOjPb/tjxSOBWZyiUVzLjMxngEYnpIDUArqOAq6XQQW7s9S/kEkId2SRyfJJp24awiK97+Wx5dRhLK+vy+EB7qADMCFWc5vHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89O+k1YftgXClCm1KzRtyE0A/F8bsEuHaqywVGGDffk=;
 b=veAX6D9+XtPqkN04rXT7M/lTaGq02UFU8keejzS9TsduEJkRQfvhCf/HQGTt9UoCW+Imfn3WlNgphI/oMqem3Eu7erh3uerkELXJz9tk4STmJfCMH4t0qw7EOm6HjL2zYbRzNhP1dO/+JsyUna3xjIv6P6qV6ZBF2dRmkyEfF4zx1tMwvGBPbwTlw77RF3wJnnPQ80bg2XYuJQ2lqb7UMwlLy6hgSOtavhVokklKCdFw+kWjsqC6QLD/1taM2/TSd5yMiL1+tJvcgUHy0WJDfUyg6Ix+fR85NG5D2lQd9W9a+z0giIm4Ois3g9fkf2f1DIClPxKu8Czxbi2OrKXuTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 11:19:05 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 11:19:05 +0000
Message-ID: <737667ca-cd16-756d-dab4-fff77f1acf23@suse.com>
Date:   Tue, 21 Feb 2023 19:18:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/12] btrfs: add a wbc pointer to struct btrfs_bio_ctrl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-6-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230216163437.2370948-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 668abe37-fb82-4c7c-4423-08db13fd7150
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dv6RtqxxnYREB4WUxwj8LC33/Tc0xFLpEctDISNY+/mryg6fx0fYwUSAi5wbpYWvJeErCLxQf1tI1ku0seLCFBTcZxSvWbX35tM+oSP0UU7hdDfGabFLjfE3pm+XQTmstodpOW9M74JrQiPo5ZynNc3RKHcPxLcWImT0NzqzHnsdbl8P22CrwyLnECsDc+Vv5BWeWjRRJDkmyDgZTAXFFrDwLWuW9ApBfbuQOwjNrLRFIGryVnMUquRBDYAQahsYQcHfGI4QZO/8YwmmeRy1Ea3c2CxVuVfAoQM+XFjHIfONnptfTFkuXx1w5WbdEO8DReCQTfJTnv9er29DO+cuW+7UUkGEusxcoN157zCPIk2c2Wmc6YuXh6oq/Sg3VQZfAxVVMFeMDc9f2+WqSVVqdkayhdI6ZturoNIxiC7DcCrDMahlBEf/uKDPHRX/OpsVLkyp+b8uaCiOIukw6ZI65CS5bjTzlBtUqE/VPnrbasVD9enGuTaP/x+xiO/0y66eiS+Nm2813dFcIq4jeBsmsvZT5iJGtWKTbbhq6+Usf83YINy0FMlALr+vFqGDiAuigjstAxC0royIF+5ZdeMxn8CVeEIIImnCtdoQzylXMpZJNhBtLtd+tbOfHwFq0QyPEUMIhJqyBvh4cvroYPlHsVPmS+gMk0Cs2tXb5c95hep7LmK+v9IsXmh6u6XwrHCQ/s9DJuW09sanA2oCCZScRHVdOMQuRLPkkOzpeKDZgNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(31686004)(36756003)(31696002)(86362001)(30864003)(5660300002)(41300700001)(2906002)(8936002)(38100700002)(83380400001)(478600001)(6636002)(66556008)(66946007)(66476007)(8676002)(6486002)(110136005)(6512007)(53546011)(186003)(4326008)(316002)(2616005)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BUYkN3aFplZXB5cUM0aTBBVXp6d2dJczhzSHQ3RFVCVC91anJVZnMremd0?=
 =?utf-8?B?QUhVUHNYRFBsS2R4M1Nmbnh1ekV0ZmJ4ZmhjdHpoaHlHOEhNUGcwdFlIZWVo?=
 =?utf-8?B?RnN6QlZONHpmYllpbG1FUWkrbzJ4SnUrOWd6Nzc1cXhBOUN4a0g2NDczd0pv?=
 =?utf-8?B?cmtiVEp5TEtCSUVYcnBUWmR2NkpiZWlYTFQ3QU92L1dxOXg2Mkkzc2pKR1ZT?=
 =?utf-8?B?QzFWM0xsMVJ3dG9ZVXhuTW9iOUREYmZhQ2dBMlVvRy9PeEJBZ2g2dElYMHRB?=
 =?utf-8?B?aFVJMXVVNit2bnp4bWd5ZjhxN01PU3RlNWxXYURpN3Y4RkRTYUZnTGZBTjZl?=
 =?utf-8?B?bzZRUFBRTnljRmhOc3kxb3VLbDdtRkVxQkJEa014YU44U3E3MjhrdG41c0Zw?=
 =?utf-8?B?YXBEaDFFa2dJUnN4WnhNRUVoUDVYSmxka0RjS21wRDc5N3JwdmR4VDdSVS9F?=
 =?utf-8?B?Qy9LdnhieURVOEpqbkVHZmp2ODkveURRTW5OeWxoU1N1MzA4Slg0MW4zbU1x?=
 =?utf-8?B?cmxzQjVXSmpXUHdSM2sxekNlU0JPSmhhUlV0QnkxMCttUEVTQ1dvdXJqdWhJ?=
 =?utf-8?B?SjVQWDRlU2dlRFdkSHdYU2YxMk1jMkV3bW14RVRpTkREZXA1Rlk5bEk0cEZt?=
 =?utf-8?B?SlJOYzJkYkpaL1ViNE5pSlpWNTVGakdQaElQREdoRFByWUM3WUk4di80QWxQ?=
 =?utf-8?B?dDdPaWM0dnBlUXV2SGxTeDBCc2ZrMWxidlNiSy8xTHFjaENHWERwUVFQTzVD?=
 =?utf-8?B?c2tSdUVpcCsxNDhvVE8vbWhHREg5WVlWN01YajFoM2hmVXg1S0htSzhCank1?=
 =?utf-8?B?ZkVNRzFaL3pMTld3Z2JWeko0dHA4VjM2MHBSZk5CSU9VdzVPYlA3RitkMTda?=
 =?utf-8?B?UVJ4TTE3L0g1dTdYUDd3VVZ3THhJa2w4RXJDb09RUldWQ0ROTmdwUDljRkdJ?=
 =?utf-8?B?TWpZbWdPUFRYMjBWaFJwemxyNTIzcFJSSDBkZlBEM0FuMEJTT1dWYVBMNSs2?=
 =?utf-8?B?RjZwZ0I1RFFjK3NvVDRtU2RyS2U0d3ZNazE3Szcvb0xLeWtGUExuZVBIcHNZ?=
 =?utf-8?B?UXBTL1ZnM0JuTEZHNnovMXRqZEFaVlNvc2RCT3JVTThrNnhnOG9FNHNMLyti?=
 =?utf-8?B?a0dQcm14Y3NySnR0WHEwNXdjMzAvdTRNRXgvUDZEelhHdTZmbVFEei9XMGZF?=
 =?utf-8?B?Wm5jeDhJUmd5THlyTWloMEJscWxvemdKZ0tlTFUwWGMrVlhtOTRYcnNBalo0?=
 =?utf-8?B?M25LTlRwZDRPNUVSYTNDQ0VMSXJmUXQzdXVPQWVOTWR1MVUzMEtrMjhLWFdE?=
 =?utf-8?B?ZGJ3TUxiVmJJTURNMk1JNXl1WWNrSFpqZDdzQmt1ejZDcmI0N01sTCsyeWEy?=
 =?utf-8?B?SVZ1WEg0WmZoN29CL2dlWEZrZzFWdkdaRlpTaG01TlVkb3dhTnVsSFZLdnhq?=
 =?utf-8?B?eUtpSkxYbFc1cVVwTS9zMVFGZGFMTTBUNUlDZlpWQXZ0OXdYQ25oQzVBeWxW?=
 =?utf-8?B?SXBOREo3UHV3R2hpcEFaSFdpRjZyU0NkdXZFMFd0dHNvSkcvYmJ2UEp0cUsy?=
 =?utf-8?B?d2gwWUM1M1BsOGxPK2xaU096UHVENGVQc2x4ellNdkZBNklVU0JueWlkYWZx?=
 =?utf-8?B?T0J4N1Y2QjFtN1gySzc3aTdKUkdIUFE5MW1BanZ1d2lQV1dzb3pkSWdUM05i?=
 =?utf-8?B?TlhvNjNNSzdhckE5RFFSUytmQ25zek52NzE2WGYyTlV4V05WZURaYkNEUzVR?=
 =?utf-8?B?VUM4b20xRndhOVFkRWRwUVFMTG9WNzVhZmlLRy9LMXBtbnlGWVIyVnhvYng3?=
 =?utf-8?B?cHp3Nk5wME5mV1ozeE5EQ2FKTjdkWE4xYVFrVUxwVmFmdWNaWU13TmxzQ1Bn?=
 =?utf-8?B?RWNyZ2dBVUdUTHc0SzNnZTU1cENTRW1XWGN2OG52RHpUUld3dDRNN0s0NW9W?=
 =?utf-8?B?M0xwNk96YUpzTWxpSFlSQUVaY0c0eUs0ZWxjemNYUkJnSVQrVkJ3TENLanlJ?=
 =?utf-8?B?VWwyQ0E2TXJ5eSsrRWJlUWh3OEs3c2JZWnFYYUg1Y3pqQjFrR2FvRy9yZGVX?=
 =?utf-8?B?bFRtclRndC90RGFZM2V6ZE5tREFLRzJCekc0emN3SlVWVVJDZFowM3pvZkF3?=
 =?utf-8?B?bjJjSjArREtVeDRuNUlYMG1Cd2QyUnJEZFpMUy90dDBkalhtcWtBS0Y4V1Zm?=
 =?utf-8?Q?yLIvbLGpGtnWQqS5U51VOzw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668abe37-fb82-4c7c-4423-08db13fd7150
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 11:19:05.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yamXrLERumGRr78Iwxb0LdgAnrVpjdwT+fXAKB/jfaa7a9nR+upG5TPpI7a9CvW0
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
> Instead of passing down the wbc pointer the deep callchain, just
> add it to the btrfs_bio_ctrl structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'd prefer to get this folded into the previous patch.

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 81 ++++++++++++++++++++++----------------------
>   1 file changed, 40 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c27770b76ccd1b..2d30a9bab4fc62 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -103,6 +103,7 @@ struct btrfs_bio_ctrl {
>   	u32 len_to_oe_boundary;
>   	blk_opf_t opf;
>   	btrfs_bio_end_io_t end_io_func;
> +	struct writeback_control *wbc;
>   
>   	/*
>   	 * This is for metadata read, to provide the extra needed verification
> @@ -971,7 +972,6 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>   
>   static void alloc_new_bio(struct btrfs_inode *inode,
>   			  struct btrfs_bio_ctrl *bio_ctrl,
> -			  struct writeback_control *wbc,
>   			  u64 disk_bytenr, u32 offset, u64 file_offset,
>   			  enum btrfs_compression_type compress_type)
>   {
> @@ -993,7 +993,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   	bio_ctrl->compress_type = compress_type;
>   	calc_bio_boundaries(bio_ctrl, inode, file_offset);
>   
> -	if (wbc) {
> +	if (bio_ctrl->wbc) {
>   		/*
>   		 * Pick the last added device to support cgroup writeback.  For
>   		 * multi-device file systems this means blk-cgroup policies have
> @@ -1001,12 +1001,11 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   		 * This is a bit odd but has been like that for a long time.
>   		 */
>   		bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
> -		wbc_init_bio(wbc, bio);
> +		wbc_init_bio(bio_ctrl->wbc, bio);
>   	}
>   }
>   
>   /*
> - * @wbc:	optional writeback control for io accounting
>    * @disk_bytenr: logical bytenr where the write will be
>    * @page:	page to add to the bio
>    * @size:	portion of page that we want to write to
> @@ -1019,8 +1018,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>    * The mirror number for this IO should already be initizlied in
>    * @bio_ctrl->mirror_num.
>    */
> -static int submit_extent_page(struct writeback_control *wbc,
> -			      struct btrfs_bio_ctrl *bio_ctrl,
> +static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>   			      u64 disk_bytenr, struct page *page,
>   			      size_t size, unsigned long pg_offset,
>   			      enum btrfs_compression_type compress_type)
> @@ -1041,7 +1039,7 @@ static int submit_extent_page(struct writeback_control *wbc,
>   
>   		/* Allocate new bio if needed */
>   		if (!bio_ctrl->bio) {
> -			alloc_new_bio(inode, bio_ctrl, wbc, disk_bytenr,
> +			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
>   				      offset, page_offset(page) + cur,
>   				      compress_type);
>   		}
> @@ -1063,8 +1061,8 @@ static int submit_extent_page(struct writeback_control *wbc,
>   			ASSERT(added == 0 || added == size - offset);
>   
>   		/* At least we added some page, update the account */
> -		if (wbc && added)
> -			wbc_account_cgroup_owner(wbc, page, added);
> +		if (bio_ctrl->wbc && added)
> +			wbc_account_cgroup_owner(bio_ctrl->wbc, page, added);
>   
>   		/* We have reached boundary, submit right now */
>   		if (added < size - offset) {
> @@ -1324,7 +1322,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   
>   		if (force_bio_submit)
>   			submit_one_bio(bio_ctrl);
> -		ret = submit_extent_page(NULL, bio_ctrl, disk_bytenr, page, iosize,
> +		ret = submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
>   					 pg_offset, this_bio_flag);
>   		if (ret) {
>   			/*
> @@ -1511,7 +1509,6 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>    */
>   static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   				 struct page *page,
> -				 struct writeback_control *wbc,
>   				 struct btrfs_bio_ctrl *bio_ctrl,
>   				 loff_t i_size,
>   				 int *nr_ret)
> @@ -1531,7 +1528,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   	ret = btrfs_writepage_cow_fixup(page);
>   	if (ret) {
>   		/* Fixup worker will requeue */
> -		redirty_page_for_writepage(wbc, page);
> +		redirty_page_for_writepage(bio_ctrl->wbc, page);
>   		unlock_page(page);
>   		return 1;
>   	}
> @@ -1540,7 +1537,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   	 * we don't want to touch the inode after unlocking the page,
>   	 * so we update the mapping writeback index now
>   	 */
> -	wbc->nr_to_write--;
> +	bio_ctrl->wbc->nr_to_write--;
>   
>   	bio_ctrl->end_io_func = end_bio_extent_writepage;
>   	while (cur <= end) {
> @@ -1631,7 +1628,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   		 */
>   		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
>   
> -		ret = submit_extent_page(wbc, bio_ctrl, disk_bytenr, page,
> +		ret = submit_extent_page(bio_ctrl, disk_bytenr, page,
>   					 iosize, cur - page_offset(page), 0);
>   		if (ret) {
>   			has_error = true;
> @@ -1668,7 +1665,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>    * Return 0 if everything goes well.
>    * Return <0 for error.
>    */
> -static int __extent_writepage(struct page *page, struct writeback_control *wbc,
> +static int __extent_writepage(struct page *page,
>   			      struct btrfs_bio_ctrl *bio_ctrl)
>   {
>   	struct folio *folio = page_folio(page);
> @@ -1682,7 +1679,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>   	loff_t i_size = i_size_read(inode);
>   	unsigned long end_index = i_size >> PAGE_SHIFT;
>   
> -	trace___extent_writepage(page, inode, wbc);
> +	trace___extent_writepage(page, inode, bio_ctrl->wbc);
>   
>   	WARN_ON(!PageLocked(page));
>   
> @@ -1707,14 +1704,14 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>   	}
>   
>   	if (!bio_ctrl->extent_locked) {
> -		ret = writepage_delalloc(BTRFS_I(inode), page, wbc);
> +		ret = writepage_delalloc(BTRFS_I(inode), page, bio_ctrl->wbc);
>   		if (ret == 1)
>   			return 0;
>   		if (ret)
>   			goto done;
>   	}
>   
> -	ret = __extent_writepage_io(BTRFS_I(inode), page, wbc, bio_ctrl, i_size,
> +	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size,
>   				    &nr);
>   	if (ret == 1)
>   		return 0;
> @@ -1759,6 +1756,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>   	if (PageError(page))
>   		end_extent_writepage(page, ret, page_start, page_end);
>   	if (bio_ctrl->extent_locked) {
> +		struct writeback_control *wbc = bio_ctrl->wbc;
> +
>   		/*
>   		 * If bio_ctrl->extent_locked, it's from extent_write_locked_range(),
>   		 * the page can either be locked by lock_page() or
> @@ -1799,7 +1798,6 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
>    * Return <0 if something went wrong, no page is locked.
>    */
>   static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
> -			  struct writeback_control *wbc,
>   			  struct btrfs_bio_ctrl *bio_ctrl)
>   {
>   	struct btrfs_fs_info *fs_info = eb->fs_info;
> @@ -1815,7 +1813,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
>   
>   	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
>   		btrfs_tree_unlock(eb);
> -		if (wbc->sync_mode != WB_SYNC_ALL)
> +		if (bio_ctrl->wbc->sync_mode != WB_SYNC_ALL)
>   			return 0;
>   		if (!flush) {
>   			submit_write_bio(bio_ctrl, 0);
> @@ -2101,7 +2099,6 @@ static void prepare_eb_write(struct extent_buffer *eb)
>    * Page locking is only utilized at minimum to keep the VMM code happy.
>    */
>   static int write_one_subpage_eb(struct extent_buffer *eb,
> -				struct writeback_control *wbc,
>   				struct btrfs_bio_ctrl *bio_ctrl)
>   {
>   	struct btrfs_fs_info *fs_info = eb->fs_info;
> @@ -2123,7 +2120,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
>   
>   	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
>   
> -	ret = submit_extent_page(wbc, bio_ctrl, eb->start, page, eb->len,
> +	ret = submit_extent_page(bio_ctrl, eb->start, page, eb->len,
>   			eb->start - page_offset(page), 0);
>   	if (ret) {
>   		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
> @@ -2140,12 +2137,11 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
>   	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
>   	 */
>   	if (no_dirty_ebs)
> -		wbc->nr_to_write--;
> +		bio_ctrl->wbc->nr_to_write--;
>   	return ret;
>   }
>   
>   static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
> -			struct writeback_control *wbc,
>   			struct btrfs_bio_ctrl *bio_ctrl)
>   {
>   	u64 disk_bytenr = eb->start;
> @@ -2162,7 +2158,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   
>   		clear_page_dirty_for_io(p);
>   		set_page_writeback(p);
> -		ret = submit_extent_page(wbc, bio_ctrl, disk_bytenr, p,
> +		ret = submit_extent_page(bio_ctrl, disk_bytenr, p,
>   					 PAGE_SIZE, 0, 0);
>   		if (ret) {
>   			set_btree_ioerr(p, eb);
> @@ -2174,7 +2170,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   			break;
>   		}
>   		disk_bytenr += PAGE_SIZE;
> -		wbc->nr_to_write--;
> +		bio_ctrl->wbc->nr_to_write--;
>   		unlock_page(p);
>   	}
>   
> @@ -2204,7 +2200,6 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>    * Return <0 for fatal error.
>    */
>   static int submit_eb_subpage(struct page *page,
> -			     struct writeback_control *wbc,
>   			     struct btrfs_bio_ctrl *bio_ctrl)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> @@ -2258,7 +2253,7 @@ static int submit_eb_subpage(struct page *page,
>   		if (!eb)
>   			continue;
>   
> -		ret = lock_extent_buffer_for_io(eb, wbc, bio_ctrl);
> +		ret = lock_extent_buffer_for_io(eb, bio_ctrl);
>   		if (ret == 0) {
>   			free_extent_buffer(eb);
>   			continue;
> @@ -2267,7 +2262,7 @@ static int submit_eb_subpage(struct page *page,
>   			free_extent_buffer(eb);
>   			goto cleanup;
>   		}
> -		ret = write_one_subpage_eb(eb, wbc, bio_ctrl);
> +		ret = write_one_subpage_eb(eb, bio_ctrl);
>   		free_extent_buffer(eb);
>   		if (ret < 0)
>   			goto cleanup;
> @@ -2301,7 +2296,7 @@ static int submit_eb_subpage(struct page *page,
>    * previous call.
>    * Return <0 for fatal error.
>    */
> -static int submit_eb_page(struct page *page, struct writeback_control *wbc,
> +static int submit_eb_page(struct page *page,
>   			  struct btrfs_bio_ctrl *bio_ctrl,
>   			  struct extent_buffer **eb_context)
>   {
> @@ -2314,7 +2309,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
>   		return 0;
>   
>   	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
> -		return submit_eb_subpage(page, wbc, bio_ctrl);
> +		return submit_eb_subpage(page, bio_ctrl);
>   
>   	spin_lock(&mapping->private_lock);
>   	if (!PagePrivate(page)) {
> @@ -2347,7 +2342,8 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
>   		 * If for_sync, this hole will be filled with
>   		 * trasnsaction commit.
>   		 */
> -		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
> +		if (bio_ctrl->wbc->sync_mode == WB_SYNC_ALL &&
> +		    !bio_ctrl->wbc->for_sync)
>   			ret = -EAGAIN;
>   		else
>   			ret = 0;
> @@ -2357,7 +2353,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
>   
>   	*eb_context = eb;
>   
> -	ret = lock_extent_buffer_for_io(eb, wbc, bio_ctrl);
> +	ret = lock_extent_buffer_for_io(eb, bio_ctrl);
>   	if (ret <= 0) {
>   		btrfs_revert_meta_write_pointer(cache, eb);
>   		if (cache)
> @@ -2372,7 +2368,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
>   		btrfs_schedule_zone_finish_bg(cache, eb);
>   		btrfs_put_block_group(cache);
>   	}
> -	ret = write_one_eb(eb, wbc, bio_ctrl);
> +	ret = write_one_eb(eb, bio_ctrl);
>   	free_extent_buffer(eb);
>   	if (ret < 0)
>   		return ret;
> @@ -2384,6 +2380,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>   {
>   	struct extent_buffer *eb_context = NULL;
>   	struct btrfs_bio_ctrl bio_ctrl = {
> +		.wbc = wbc,
>   		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
>   		.extent_locked = 0,
>   	};
> @@ -2428,7 +2425,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>   		for (i = 0; i < nr_pages; i++) {
>   			struct page *page = pvec.pages[i];
>   
> -			ret = submit_eb_page(page, wbc, &bio_ctrl, &eb_context);
> +			ret = submit_eb_page(page, &bio_ctrl, &eb_context);
>   			if (ret == 0)
>   				continue;
>   			if (ret < 0) {
> @@ -2511,9 +2508,9 @@ int btree_write_cache_pages(struct address_space *mapping,
>    * existing IO to complete.
>    */
>   static int extent_write_cache_pages(struct address_space *mapping,
> -			     struct writeback_control *wbc,
>   			     struct btrfs_bio_ctrl *bio_ctrl)
>   {
> +	struct writeback_control *wbc = bio_ctrl->wbc;
>   	struct inode *inode = mapping->host;
>   	int ret = 0;
>   	int done = 0;
> @@ -2614,7 +2611,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
>   				continue;
>   			}
>   
> -			ret = __extent_writepage(page, wbc, bio_ctrl);
> +			ret = __extent_writepage(page, bio_ctrl);
>   			if (ret < 0) {
>   				done = 1;
>   				break;
> @@ -2679,6 +2676,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
>   		.no_cgroup_owner = 1,
>   	};
>   	struct btrfs_bio_ctrl bio_ctrl = {
> +		.wbc = &wbc_writepages,
>   		.opf = REQ_OP_WRITE | wbc_to_write_flags(&wbc_writepages),
>   		.extent_locked = 1,
>   	};
> @@ -2701,7 +2699,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
>   		ASSERT(PageLocked(page));
>   		ASSERT(PageDirty(page));
>   		clear_page_dirty_for_io(page);
> -		ret = __extent_writepage(page, &wbc_writepages, &bio_ctrl);
> +		ret = __extent_writepage(page, &bio_ctrl);
>   		ASSERT(ret <= 0);
>   		if (ret < 0) {
>   			found_error = true;
> @@ -2725,6 +2723,7 @@ int extent_writepages(struct address_space *mapping,
>   	struct inode *inode = mapping->host;
>   	int ret = 0;
>   	struct btrfs_bio_ctrl bio_ctrl = {
> +		.wbc = wbc,
>   		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
>   		.extent_locked = 0,
>   	};
> @@ -2734,7 +2733,7 @@ int extent_writepages(struct address_space *mapping,
>   	 * protect the write pointer updates.
>   	 */
>   	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
> -	ret = extent_write_cache_pages(mapping, wbc, &bio_ctrl);
> +	ret = extent_write_cache_pages(mapping, &bio_ctrl);
>   	submit_write_bio(&bio_ctrl, ret);
>   	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
>   	return ret;
> @@ -4430,7 +4429,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
>   
>   	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
> -	ret = submit_extent_page(NULL, &bio_ctrl, eb->start, page, eb->len,
> +	ret = submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
>   				 eb->start - page_offset(page), 0);
>   	if (ret) {
>   		/*
> @@ -4540,7 +4539,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   			}
>   
>   			ClearPageError(page);
> -			err = submit_extent_page(NULL, &bio_ctrl,
> +			err = submit_extent_page(&bio_ctrl,
>   						 page_offset(page), page,
>   						 PAGE_SIZE, 0, 0);
>   			if (err) {
