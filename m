Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4964512AD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbiD1FUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 01:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiD1FUT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 01:20:19 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943D41009
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651123022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZH9LjxEq5BtPgKdL3UtVoHGqL1692UiaCJx2ShVP3tY=;
        b=TDswbMhpZaK0TbUN7J+Q5mFW5QULw8bLeAa/8jYHWOoKlMhxXG6RSmnK5daWJLKAtZptXD
        ynePofQf5f7x4Rc1TllsDgPfM4+buBPMvZcbOSX4OUqZWGWYIoKGhO0etpELxHr+NXIJgi
        q7OSosVgHvIPvHnyUE/TcDiQXEWmXUQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-Wk3vvnOcPXqCvrG-6_OvRA-1; Thu, 28 Apr 2022 07:17:01 +0200
X-MC-Unique: Wk3vvnOcPXqCvrG-6_OvRA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuZKVi1SwCrstIALbRODEahirVTnlII+sr2vY7ioGZrFfq8fCoD63D6pNV8rKaHO5mUXRfJNcmtvRzSwpbtujq1ZMhCMiYZILkjXQy4jAPkFDFC//SvD2QFK+m4U++DoJulyyZ3UA8cK/sO95O1p+x+Dyvv2jrETn+7gVNMgGG7vKKofsv9BtqNR0jG+svED4+MSko066DtFUN1ayiSgl5ywJgAYO5J446DkBplyfvlyV0vRzGFIP+6huzNZ+dC/w0PPJ+OGNkjjbKor+/LOtJ5Q4Jqlt2EV9QFyNia2aX62+AyY+RjO7soqIrlj58wh3ShqwgdGNz9P/0X7mpRAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH9LjxEq5BtPgKdL3UtVoHGqL1692UiaCJx2ShVP3tY=;
 b=bqR/sebZBZhudL/8ZIqjqFJuzrWIlnA84s9KPSkY3KcD/n9whg1vXvHc8NI5Jp0ixyRp0WtR8gVwSR1cwJeNdNaPNQWq7h+gn3xYoZT1fa+siGVtTvuUGtV1chphCI7fnKgWQWRBED8FGifuNJ/Lf2LhxRtcfEPhgFBZf5e1OTPIiw75GM2XXxCEHzoyF/US4JvP+RWqy4IOzGdlAV902QA8AqT9L/3rqwkrwArm8ouygOlbOMTjY8xWySDqlNTJTdqTjuVOiwbIKf/v7UeVmytE6tCtcgW6XwzVlr9FxfkT4zsGDuWo4bQO5vYiBz7Xis51mcxumIEyrfXWiIRNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR0402MB3922.eurprd04.prod.outlook.com (2603:10a6:208:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 05:16:59 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f%7]) with mapi id 15.20.5206.014; Thu, 28 Apr 2022
 05:16:59 +0000
Message-ID: <17f04ff8-6591-6057-1607-30ae353b0e0b@suse.com>
Date:   Thu, 28 Apr 2022 13:16:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 02/12] btrfs: always save bio::bi_iter into
 btrfs_bio::iter before submitting
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <b11499d578ab90258d83ec9be6d46df78c1056bf.1651043617.git.wqu@suse.com>
In-Reply-To: <b11499d578ab90258d83ec9be6d46df78c1056bf.1651043617.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f3ed1fd-4f37-4075-5dfe-08da28d6521f
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3922:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3922AFBB9370B935F53D46A1D6FD9@AM0PR0402MB3922.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3O31VcW0jw1/f+3GCJBHJgh9CyhxZ9OHEVyi6xwl0ONJhBOR9NQ3tjprkGk2a24MlFKFYWdogwCc8UCgBfe8NtkAo+zye1eCpHCz3eiQ3f7VIBVBqG+Ph73lBAsre6iQBZrmBf63LA7PvMIBdtSxps2e8bAHd5x5Jl/yIox/xvjc5hVLWMUHAlXj5fI82LZvyz3THkgyY94XErGL35GWEy24Ro3/l9nOZS6N3zuGQwHQCaLKgjfbNo4hGGAyeCB5HwuSQvrH6uwsyiSUb1OrO9kFvId/S71QoRUg+ukh+bE+OSZTg63MC4y2UDeCHMXqkk1zazwQ0iJxBOlZiMvskemp3X/ExmnDd1NNJRSJuC97ydwY7FuUl6ykQM5fh/6JPLL8rXAKK4nNJpE4XVfkx5g1dOFhuXcU40pXBly31PcTFklz/kbkhT6XRx9oeJE9ScEhbeatCsush+Wpzwc+xxFM0yBgNMzPHwJjr5jHTH79VBbCK/V5rmWeKEiTdUlW3GooG9NtLRJqI3ImppmsWRUXJTHAPoxVDqYl8Uik17UNu6+myJPEUGmpC7unV4enmNxFQu13cCEWri4827uaEGs4gGZA9G0mxwxswwbJPT4ltr/i2VOae4F22mzhQI9I8WijBZaILYn+WcG5nvcxqJ8OaIZCSOwxM0HRSVGW5iXtlIjwsigNaGW2KGoOMlK0b0WFy19LtXQkPy4bHbkc4ZPDOV4MJybM5gemAEHdX+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(2616005)(83380400001)(31696002)(6486002)(8936002)(508600001)(36756003)(31686004)(186003)(316002)(6916009)(66476007)(66946007)(6506007)(8676002)(66556008)(6666004)(2906002)(53546011)(38100700002)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVg2Y2NKUVhVSVhkR214cFlXbkdCci8zbEc4Q2Urbzg0S29DVnRKeXJTaXEz?=
 =?utf-8?B?aXNRdzhNSW5xcWJMQjFsQUYrditPNEU1SHI2bnB5RlFYWm1ZbGdRTVBMQlBN?=
 =?utf-8?B?Nm5uODRnL3ltZFV1cEQ1KzAzNFZHeGhlTml0UVlNNmFmYk5iYzZTVis2UnVa?=
 =?utf-8?B?L2paV05SWCtHQ2EyN0JIeTBXWmZWTFpIWExaa3JwYzduNmJ0RVpCZTVVZkN2?=
 =?utf-8?B?L1U3QTFBQlVSSDdhTThvcExYRlJlcWJYM0RCTHRkVXRsMGpVQnZGMW5uVTJV?=
 =?utf-8?B?MFBRYWkvenI3ZHB3OHhMaHlPOTNObWgrNlVDQlB0TnJIY0lGMjZVZy9odk1J?=
 =?utf-8?B?SVkra0Y2VDdVKzdRUHBPRHZmeW5zNTNoQUlPTStscENWQ1hDQW1MMGM3ZVRC?=
 =?utf-8?B?S21Gc3o1VjlNR052R05FanZKa3oxNGM0OFRFMmVML0tXZUdjUTFHQ0tFMGtO?=
 =?utf-8?B?aVNieStJZlZjbjYyVWliWnNHOS9SSmd4RFFsQzVCVHZXdEFnV3pCN0UxSUtw?=
 =?utf-8?B?ME5YMGxBTmxXZEhKbmR1L2t2NGpHTnNUVWYrVHpJUngrS1YwaHh1YWlxcEFt?=
 =?utf-8?B?eG5UR3V1dDM3MVZJUVRYWmlLUVgzS0FBZG5LcE9UeHNCbDZlZ0dxS3o2eXZV?=
 =?utf-8?B?Njdsb1pRSlBvdHRDdGxva095czZrbWU4N3p2Uitrc1p5ZUUrTmI2czdiNDl3?=
 =?utf-8?B?bEhTejdwTXgxb1haVFNOWDl5Zy95ZHc4NjErR21LNTZVVmxheEoybHZPdG8x?=
 =?utf-8?B?MWRuQTZVOW4xdVRla2oyRDBnTFVBRkV2L29PNXFsZ2dQd1ZmS0tLVXpVdlNn?=
 =?utf-8?B?VnBFS2xiSmhtTU5nM0ZpU1pKYWlDaUlxUXdsNlM5YlNVNGxpcDlBdzhMRUQ0?=
 =?utf-8?B?SmJJdTBaWUxQY2VWWDRwMmZCQ2x1Ny9XaVlFeEMwZ1BieFZ1bExlRUo1RGR2?=
 =?utf-8?B?L1IvL1JRSXdIbDBCWm1NbmVjR3FWeGxvNXhpOHpERXA0a3FaWnEzNVB1KzUr?=
 =?utf-8?B?ak13MER6QVBPR1pHb2dkZzZ5aWpBejVER2lVZFFyQWhwV3ZRcVlub3VMQnJx?=
 =?utf-8?B?bUYvQXYrd2g1NVlyeVp3VnVKMnplSGhxdWxnU3V6eTIrMHBLMm1aWE8wbVZP?=
 =?utf-8?B?bDVJTU1ub2pKTFc1Q0dwL0xEVm5TMzNFam1rTFJvOGt6eGVqa1E1SUtkd1ZC?=
 =?utf-8?B?dk9aU0VxNHZZQmNUQ2V4Nnk2NitJOWJCcUtsbW9VZy9aZnc2RE9nZGszNWpL?=
 =?utf-8?B?SFFtTk12b1pCbGN4SE5ZNEpQMG5yMGtPQU1MU2lpQzNoNzlHZXVRQmpZa0pr?=
 =?utf-8?B?SjYzYWVRSlBNTldtTldCUWdqS3o5WlF6cDllZHRmaDY2bllUU3JjdmMzbDlS?=
 =?utf-8?B?bERuT00wNzlOZjFkZTY4bm1ocm1OZzNYSWd5eEhpdXd3YXVYY1RBeEtCT1RV?=
 =?utf-8?B?R1p6Z3ByT3hUMU45MzJQQlJyL1RDTWJ1TWpFQ0JTYVB4YWRwVWlSQnRLOENp?=
 =?utf-8?B?UVRUZkhMSm8vZ2d4djlFU0N5LzI5Zm1nbGVTWitjNzJUL3F1b3FEbmVmeTMy?=
 =?utf-8?B?dGJZN3BqNVVCU1RML1pEK1ZkMzE4K283QVkvWFpRRWpMRmZvYUtEZTBGUVlq?=
 =?utf-8?B?aHlVS3NWTDdwZGhiN1FoSFVhb1YvZklqVTFqNzhuRlFGb3hVd0NtNWJNVnU0?=
 =?utf-8?B?c295RHpjaitlK1BqUGVEUENOTTNHakFhWWVPSHgvMVAveVJ5b05FZGp6WElU?=
 =?utf-8?B?c1JXdjZlT21EYWFXWjM0bStHYlJWUXh5K0JpY0tJVG13MDlWRzhCOE9BZWZt?=
 =?utf-8?B?YXlkMlZKTHJtWUY3UzFvQnprRk94cXZWb1VtWWlQcWVBL2pyYUJkd2hwck9T?=
 =?utf-8?B?RmZFSFEwNERydTBaY3BWQmJBTTRJUU0xQ3BGaXNFRnBPaWwzb1AxL0ZUL1kz?=
 =?utf-8?B?UTlyZWltTkM1MTFNaUFONUFERHZSQVc3blozRjREcWlwUXlyUllqT1Z4Nm8w?=
 =?utf-8?B?dGtjVW9tRXFsRm96M2R5RlU0K1hlajRuNTArQ043RjAyZU5yQjBFYWYrSjdT?=
 =?utf-8?B?SG5tQm5SN2h4K3dpVm9FdTJ1OW90Nk0zQTYrVmVxV2pIN1lWSkZSbFJNQWJl?=
 =?utf-8?B?L1RaVXRhS2tHcHlBL3BCYStkWnFHRXcrN3loU1drUFlGc2RnV0JEVTFqTklh?=
 =?utf-8?B?WVVLNHhENW92ZTJ2RjRUZXFlWTlyNCtTRHZqZGRiOEpna2pVS3d6SldTdXNL?=
 =?utf-8?B?OGwzekdzTHNIUGczMFM2VFlLZ010TmZuSWxVYk94Z0I0YmZNQ0hvZkxIaGdX?=
 =?utf-8?Q?11PTRBV7ouRA0dJNTM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3ed1fd-4f37-4075-5dfe-08da28d6521f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:16:59.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkdSieFvUUuMz7uVv9/xYAgbPpmN7h2inNt0TfL6ljePPbpC6KEV/QxqWxD4sxbK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3922
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/27 15:18, Qu Wenruo wrote:
> Lower level bio mapping, from driver to dm, even btrfs chunk mapping
> can modify bio::bi_iter.
> 
> This prevents us from doing two things:
> 
> - Iterate the bio range of a cloned bio
>    This is only utilized by direct IO, thus it's already using
>    btrfs_bio::iter, which is populated in btrfs_bio_clone_partial().
> 
> - Grab the original logical bytenr of a bio
>    This will be utilized by incoming read repair patches.
> 
> So to make sure all btrfs_bio submitted to own a proper iter, this patch
> will assigned btrfs_bio::iter in the following call sites:
> 
> - btrfs_submit_dio_bio()
> - submit_one_bio()
> - submit_compressed_bio()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Cc Christoph, this is definitely going to conflicts with his further 
cleanups.

Maybe I can update this patch to only set the iter for read bios?

Thanks,
Qu

> ---
>   fs/btrfs/compression.c | 2 ++
>   fs/btrfs/extent_io.c   | 6 ++++++
>   fs/btrfs/inode.c       | 2 ++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 69c060dc024c..559bf53beaed 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -428,6 +428,8 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
>   	blk_status_t ret;
>   
>   	ASSERT(bio->bi_iter.bi_size);
> +	/* Check submit_one_bio() for the reason */
> +	btrfs_bio(bio)->iter = bio->bi_iter;
>   	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
>   	if (ret)
>   		return ret;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 07888cce3bce..a3962df30603 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -186,6 +186,12 @@ static void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_fl
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bio->bi_iter.bi_size);
>   
> +	/*
> +	 * Save current bi_iter into btrfs_bio::iter, as lower level (including
> +	 * btrfs chunk mapping) can modify bi_iter, preventing us from using
> +	 * bi_iter to iterate cloned bio or grab the original logical bytenr.
> +	 */
> +	btrfs_bio(bio)->iter = bio->bi_iter;
>   	if (is_data_inode(tree->private_data))
>   		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
>   					    bio_flags);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b4cfd78f50e8..1b596de0c4e9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7923,6 +7923,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>   	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
>   	blk_status_t ret;
>   
> +	btrfs_bio(bio)->iter = bio->bi_iter;
> +
>   	/* Check btrfs_submit_bio_hook() for rules about async submit. */
>   	if (async_submit)
>   		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);

