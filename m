Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B0512ADD
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 07:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiD1FYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 01:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbiD1FYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 01:24:03 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940C21824
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 22:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651123247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YM/gIG8s1nyuKSsKz1W7HUlUnFfQGARjIFEhiRpx/Vg=;
        b=ZGi+2PewDZY+VQRvVNF68zYGuVCtpSRXU6R5GBx0qo1AayaQsZh+AHiJQPhexHoJCWo1Sf
        VnLhKUF+taPgZ9RIRKNdVeiWBWmbXMwksslYPrUO3cfYhUBsBKPUbrXKILZG8++gXe5+qQ
        6PkTnkaCH29Su8EWyudo5cxAUCIn6Kw=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39--UCQ33nwMdG6uCtLLRNALg-1; Thu, 28 Apr 2022 07:20:46 +0200
X-MC-Unique: -UCQ33nwMdG6uCtLLRNALg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHc0ENJhiwsHRUdN6SZgPVdQzPZ49zdiCzGXGtP/ls5hnJUt6S8VMrA1TgW2RS3bsNpF9bb90kf+JAHCEi+GrtaOHf9PoAOUVtv7S5x4+knBExqI9MuN1GgKxpz1ALvpjyv9XC/CB7AfULcTAtvC/o3sj6zxEDwrekysRD6Y4Hy0wEku1Fco84V2sc0DBxUxlu/SW4lXpId5J8PdzvTlZAqi3nGqLWllma10/Vz9GAHUDfQRjVcbZd218RiOK24ctBrh6p2o/I/PU3WNz/Mbl3r1JlQWYXhlJ3wNtpZY9XgjV2U5pNPDb+la1lT623ppMinPdzAX4joVZSxVUbhDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM/gIG8s1nyuKSsKz1W7HUlUnFfQGARjIFEhiRpx/Vg=;
 b=VHJ/Cc0EDG9CAtMyLwruna2SxrFwPk27J6JMfI1PTpYd2J8P6QwRfZlmao7g2URL8ujPLusYycB+X3rEE8FTp0jBpOPcLmE4oFkA4fkFJHGbofAQNKjHI8k1n2lOFR6juXt9pBxOjpNDQXyq3S2CxI494ddSg41gQrSZ+XeWZLq8EPe1rRRSHSOzlXooFkRmn1YgZVu26Cco8vEfr78DfyWTp6RkrPKONijQibm7xh5vKkehPYeRY1I6vf/pTW/YwXl2v1vmLUdH9GFcaUngmFA2ak8lYgpZakXNBJagMa12n224gs1Fh6nKIKdAUqOfU1KD4DsX1WVKfA8uzjtnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM5PR04MB3073.eurprd04.prod.outlook.com (2603:10a6:206:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 05:20:45 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f%7]) with mapi id 15.20.5206.014; Thu, 28 Apr 2022
 05:20:45 +0000
Message-ID: <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
Date:   Thu, 28 Apr 2022 13:20:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
In-Reply-To: <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::22) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0214f280-7063-4448-0527-08da28d6d8ec
X-MS-TrafficTypeDiagnostic: AM5PR04MB3073:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB30736D6D9B79270E72F40C68D6FD9@AM5PR04MB3073.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJsdf6+AlJYqW9rHIwyVEazMqEdHTZ+oUHjtUa3aJ7nr97KEcuPIq+qb4UxXmpCSfQ9N/H/o0ZAXsEsSSP6Qnmit2zqJroFMfl8+ISXrcN6tlu6vFdFdjkIEmM6rXbIiwVQlZSkK9N1+8MG0I1I8QSdUq22WRik5Q2xbQlksWGKSAcFce7GhbLFu8/wODqJ9bI93iM3ACorf7ECHUYEoPfXbfPSh0POUCEREG7qgpjw0qWCqZhJ8ARouQczvLqqekbr3JrBmxlSsZPSL072wfXawxVVqhy69W+567Encwmn85Qv7+FnHgZftleK2Y7qM0OnTZ2+KhPSYgavqJRfL/toLAJ6vuJOpkwyM3FBAuXVHHCDUtmBj+53cFO2dyDcH9DWkUerVe+1c1XRhfb/Q8azOt0zRB9sfGk2XIFVqi2V7YAYxFEgSCVCUL5j8GvbhOYRNAkOFE0jbxSFsA20AQZltM6bXn/U91mYQ+Y0EhkuWFdH5kMeGHTsLgITAbmXu107t9Lig+58D8ohrWP0A+iING/PxjljJeNPaD9GOvx3l72WQI6XoWoPcZYL+3rAbQBkVwWiCUkox9QWWHLko7WDkcKcsQo0Id7X929azLunFoYjDzgjdIO7l/56EZ8s8CNjeDIw4qhOwQ3ec+xysmU/IeJnFuTnJQXjb3ZGGhovvfFuEr1C2f9s1fXZFisB7H8nfY+oTL5ikEXJHpS28Eimh4g+Y0tIB3iH/mcei5Uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(53546011)(6512007)(8936002)(26005)(66946007)(66556008)(66476007)(6506007)(316002)(83380400001)(6666004)(6486002)(31696002)(38100700002)(86362001)(508600001)(2616005)(5660300002)(186003)(8676002)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBPeTVMbm1kMUNxei84bVpYRFA3R2tUaC84OFR4NWhsaHJlVHNlU1RQNkY3?=
 =?utf-8?B?dzI4Y3NqNlR6NTJlamxpaXQ5SnFzUWNUV28yVy9FUVZtaElRVUdCRHNYT0Zn?=
 =?utf-8?B?OGdmOEwxZ1N3cFFuSkw3Y3p4U2hxVGkzOVg2QUtCb0duK2ExSXJZRld0ODE0?=
 =?utf-8?B?ZURmMDhFK1RWQ25xN2h2bXkwNEJGdTZEL2pSSFdCeDdRMUJrRE5TcDM4cFhw?=
 =?utf-8?B?QU56MEg5cVQzdHZSRXJibGp0QzdGZFhrMFJRNC80UlZYMFNGV0h5dyt2VXNY?=
 =?utf-8?B?K25xTldWZGh5M1lWdDhLVGpaQklBQ0o0Z2F1VGtsWFJBSlVUMkdTUXBSd3FM?=
 =?utf-8?B?VWJiRHhNdUo3c2w5N2ZEUmUwVXJZN1RkTFlCZUVxUU9EMVhCdUZ4TlhUZnlB?=
 =?utf-8?B?ODJEMGk0em5Zc2pHandrekdWR2xOdGVFWkpYU01JUUVmM1UybFRuMldQL0NH?=
 =?utf-8?B?SEpBdjVEMG5SQlZ6dTVtTzdPc0xmM3NuWkdGaXZQWGlranBDLzQvb1JKNGV0?=
 =?utf-8?B?K0kyRkFEOHk5TmtCQS9DM3BCeXBiSkV6dGRNWlFlSVh4eE9VL0taMFNtWmk0?=
 =?utf-8?B?K3hrL25LMzFwOFJnVkRlNG5TUThDQy8rMzNwdnlsQ3Y4aFJFMTM4Tmw5cTZw?=
 =?utf-8?B?dWRTKzJmRGFaa1hFNHZScFFsUmlKeG55MU1VeG1HSmNzdTZkUFQ3aEZueGdZ?=
 =?utf-8?B?a2NKU2c5Uk4yV05HM2hFWWt3Y3BHUVVxdEgvMTZNVmZvMHFVN3FFaUFGbVd0?=
 =?utf-8?B?ektTeVQ1NHE4Z2Q3Sll5Y0hWVGlMR2NZMUFzMmlWTmYxWS9aZjZlTG1Yc0cx?=
 =?utf-8?B?ZlRQbm5JYVRJaFBEWmoycG9IT2ZIZGZhTGdoRFUxUzA4VzZ6UDJZeDRXQ04r?=
 =?utf-8?B?OXp4ZXpzTWIraUVMdWJHZ2F1QjRMOWFCUm9iS0NnZFBZRlN5SW0wUFo3dWRj?=
 =?utf-8?B?bk1odERYUTRoQ09VaHQwMVp2OFlXTmlJTUlmQkVjNHdYVDJNRmZjdng2RHdH?=
 =?utf-8?B?VDArMFBkK2VyQVVLblBXNmxPT2NGQVhIdlNod0VuT2hQUFZINFZJR05oL2xI?=
 =?utf-8?B?clM4RzhseDF6Ylp1RlNYMU9aVHluLzh2Ti9MbWZZcm9kM0pXZDhUQjVJWStW?=
 =?utf-8?B?TzUwNFFWWng4bjZMTVZtaVN6bjlEd1RRN3B6clNNOXBQS2pTaGtWMUUrT0oy?=
 =?utf-8?B?bEYwRk1kSnZscFZXSWgvTTdhOHA1Ris5T2VDK2JEMlJKUlZYcEI1WldLd1pP?=
 =?utf-8?B?S2ZnZHFiQ2I2Vno5Z2ZRUTNwaFFRclpuUzNyUksyVERzMGxqeWY5MEgxRTJp?=
 =?utf-8?B?Mk9UclFJZlVuT2tKS1RvT0FrT3ZvQjIwdUU1eXJPMklnajRvbE1BNStKbE9y?=
 =?utf-8?B?dndLaWpnRU5sbW9ibkNhajN3SGVsWTFYUWNxTERQUytjN2tQNEdHQmFIbFdJ?=
 =?utf-8?B?SWR1cDJzbVNIV1dscWdTbitOU1JTbkFpNWNPTU1JdXI1STVuRVNVczBqUjZB?=
 =?utf-8?B?Qm1wM1FvOFlaVHR6N3p3NXVRL1JzckhMUVA4bWp4eTN6eUdVNElGUFJBbTdY?=
 =?utf-8?B?a2huY1R4ZllJanFOZ0pEdFpvWjZhSFhtY0VyMlQzeDAwVWFTcWRvai9wazdD?=
 =?utf-8?B?VE5mcGJKblE5OFlyNHp5ZkpZUmxjSXpIM2pKcTRDQzRHMUp3bDJMUHBna1E5?=
 =?utf-8?B?Y1BFZk1USmYveWNzL0RVdmh3NE1FUkN2ZVdYUnBpd1g0L252dS9NSTBIc0d6?=
 =?utf-8?B?TVZ1emxEdEVtQnZncmV0RnpiTGp4L0MwVEw5dHNYSTJ2c3hEcmxVQTIwd0F1?=
 =?utf-8?B?TTQ5WG9EbVREa3BDeGxNb0dlSWtobTAxckwrM2dNcmdSTzJwaldKY0I0Vlcx?=
 =?utf-8?B?U1FyRVpZci9YbnFTbDM4bUJSbEt3clVGRG11cGIrLzZ3QlhaQnMyZ3ZmdDV2?=
 =?utf-8?B?ZmIyYnNKa1NUcE1MWDkycFpOYnR6eVkrU3NnazdMNWJxNEFINlVzT3pjT21v?=
 =?utf-8?B?bWlFZlFVSmFCSVlCenVmeXQ3SGZIYUxDaFBsVEFRQWhVOGtLK1VmaTdyc0Yz?=
 =?utf-8?B?VXN0dzF0MGhBbUdOUkJ4d0U3S2tJQ09RZk5kZVFlQW51c0pWazBVWktYcElF?=
 =?utf-8?B?dThiZHR0dWJobW93RnlhazlJMHVHMlg1b1Ezd2VLZS9Jc3owSnRRbWJKZkpl?=
 =?utf-8?B?TFFVR0c1U0RYdkpwL0xjZlF2U290SXFqM29HWm5zVkx3ZUxQMlBZd2VWUEtI?=
 =?utf-8?B?VG96SGJLMSt4NDUyYld6b0ZzeGhyQ21uS1BObWo3RjFOL3dLRGJaVjJHMmpo?=
 =?utf-8?Q?Xs9koHF0bzcS0om3z6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0214f280-7063-4448-0527-08da28d6d8ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:20:45.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJI80uicalAAlNVP7FGKDYnVmKxxkfrCEDm/YPx3t75VwhBUdlpWwq9WNPED/pZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3073
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/27 15:18, Qu Wenruo wrote:
> The new helper, read_repair_bio_add_sector(), will grab the page and
> page_offset, and queue the sector into
> btrfs_read_repair_ctrl::read_bios for later usage.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 107 +++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/extent_io.h |   6 +++
>   2 files changed, 113 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6304f694c8d6..fbed78ffe8e1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2732,6 +2732,110 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
>   		btrfs_subpage_end_reader(fs_info, page, start, len);
>   }
>   
> +static struct page *read_repair_get_sector(struct btrfs_read_repair_ctrl *ctrl,
> +					   int sector_nr, unsigned int *pgoff)
> +{
> +	const struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
> +	const u32 target_offset = sector_nr << fs_info->sectorsize_bits;
> +	struct bvec_iter iter;
> +	struct bio_vec bvec;
> +	u32 offset = 0;
> +
> +	ASSERT(pgoff);
> +	ASSERT((sector_nr << fs_info->sectorsize_bits) < ctrl->bio_size);
> +
> +	/*
> +	 * This is definitely not effecient, but I don't have better way
> +	 * to grab a specified bvec from a bio directly.
> +	 */

Also Cc to Christoph.

This function will get called very frequently, and I really want to 
avoid doing such re-search every time from the beginning of the original 
bio.

Maybe we can cache a bvec_iter and using the bi_size to check if the 
target offset is still beyond us (then advance), or re-wind and 
re-search from the beginning.


I guess there is no existing helper to do the same work, right?

Thanks,
Qu

> +	__bio_for_each_segment(bvec, ctrl->failed_bio, iter,
> +			       btrfs_bio(ctrl->failed_bio)->iter) {
> +		if (target_offset - offset < bvec.bv_len) {
> +			*pgoff = bvec.bv_offset + (target_offset - offset);
> +			return bvec.bv_page;
> +		}
> +		offset += bvec.bv_len;
> +	}
> +	return NULL;
> +}
> +
> +static void read_repair_end_bio(struct bio *bio)
> +{
> +	struct btrfs_read_repair_ctrl *ctrl = bio->bi_private;
> +	const struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
> +	struct bvec_iter_all iter_all;
> +	struct bio_vec *bvec;
> +	u64 logical = btrfs_bio(bio)->iter.bi_sector << SECTOR_SHIFT;
> +	u32 offset = 0;
> +	bool uptodate = (bio->bi_status == BLK_STS_OK);
> +
> +	/* We should not have csum in bbio */
> +	ASSERT(!btrfs_bio(bio)->csum);
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		/*
> +		 * If we have a successful read, clear the error bit.
> +		 * In read_repair_finish(), we will re-check the csum
> +		 * (if exists) later.
> +		 */
> +		if (uptodate)
> +			clear_bit((logical + offset - ctrl->logical) >>
> +				  fs_info->sectorsize_bits,
> +				  ctrl->cur_bad_bitmap);
> +		atomic_sub(bvec->bv_len, &ctrl->io_bytes);
> +		wake_up(&ctrl->io_wait);
> +		offset += bvec->bv_len;
> +	}
> +	bio_put(bio);
> +}
> +
> +/* Add a sector into the read repair bios list for later submission */
> +static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
> +				       int sector_nr)
> +{
> +	const struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
> +	struct page *page;
> +	int pgoff;
> +	struct bio *bio;
> +	int ret;
> +
> +	page = read_repair_get_sector(ctrl, sector_nr, &pgoff);
> +	ASSERT(page);
> +
> +	/* Check if the sector can be added to the last bio */
> +	if (!bio_list_empty(&ctrl->read_bios)) {
> +		bio = ctrl->read_bios.tail;
> +		if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) + bio->bi_iter.bi_size ==
> +		    ctrl->logical + (sector_nr << fs_info->sectorsize_bits))
> +			goto add;
> +	}
> +	/*
> +	 * Here we want to know the logical bytenr at endio time, so we can
> +	 * update the bitmap.
> +	 * Unfortunately our bi_private will be used, and bi_iter is not
> +	 * reliable, thus we have to alloc btrfs_bio, even we just want
> +	 * logical bytenr.
> +	 */
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS);
> +	/* It's backed by mempool, thus should not fail */
> +	ASSERT(bio);
> +
> +	bio->bi_opf = REQ_OP_READ;
> +	bio->bi_iter.bi_sector = ((sector_nr << fs_info->sectorsize_bits) +
> +				  ctrl->logical) >> SECTOR_SHIFT;
> +	bio->bi_private = ctrl;
> +	bio->bi_end_io = read_repair_end_bio;
> +	bio_list_add(&ctrl->read_bios, bio);
> +
> +add:
> +	ret = bio_add_page(bio, page, fs_info->sectorsize, pgoff);
> +	/*
> +	 * We allocated the read bio with enough bvecs to contain
> +	 * the original bio, thus it should not fail to add a sector.
> +	 */
> +	ASSERT(ret == fs_info->sectorsize);
> +	atomic_add(fs_info->sectorsize, &ctrl->io_bytes);
> +}
> +
>   static int read_repair_add_sector(struct inode *inode,
>   				  struct btrfs_read_repair_ctrl *ctrl,
>   				  struct bio *failed_bio, u32 bio_offset)
> @@ -2762,6 +2866,9 @@ static int read_repair_add_sector(struct inode *inode,
>   		ctrl->init_mirror = btrfs_bio(failed_bio)->mirror_num;
>   		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
>   						    sectorsize);
> +		init_waitqueue_head(&ctrl->io_wait);
> +		bio_list_init(&ctrl->read_bios);
> +		atomic_set(&ctrl->io_bytes, 0);
>   
>   		ctrl->cur_bad_bitmap = bitmap_alloc(ctrl->bio_size >>
>   					fs_info->sectorsize_bits, GFP_NOFS);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index eff008ba194f..4904229ee73a 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -121,6 +121,12 @@ struct btrfs_read_repair_ctrl {
>   	 */
>   	unsigned long *prev_bad_bitmap;
>   
> +	struct bio_list read_bios;
> +
> +	wait_queue_head_t io_wait;
> +
> +	atomic_t io_bytes;
> +
>   	/* The logical bytenr of the original bio. */
>   	u64 logical;
>   

