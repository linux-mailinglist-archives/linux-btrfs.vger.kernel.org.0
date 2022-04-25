Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A050DB84
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 10:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiDYItS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiDYItQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 04:49:16 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0813DD1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650876364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLLFazl1DpFIQcROhxLo6V1JROMDL+z5X9JDTpdwmeg=;
        b=dXi6AxYAkcZroME5+QW1Du8naiCBlv42dmYIvqq+4/aP+rFhd37Tn29zST618bmMlkNrQR
        Nmey/ti/7vLadsEODLuYRLCjrnxyX+slxBiFp+fE0PfQVVg4p7EBQtlT5fTwmlpNZRyBFJ
        hWkSS5yoyo+B6j1JDVirrzNYgxJ9Xq4=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2175.outbound.protection.outlook.com [104.47.51.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-yi2uxW38Mpuc39r1YqF0hg-1; Mon, 25 Apr 2022 10:46:03 +0200
X-MC-Unique: yi2uxW38Mpuc39r1YqF0hg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6yytm8uxvEujRNa/Vj1cYPrMmFCaKF9sK3mQdmzJVG9buKqJgT92WXSF2Bc2GSibNQfDrGvu5bcktmPfC/q0rd1bLqav4mPnT/csMRqaB4J9Yx0YBVP7VEj8yZgr6puoLKrN8DhEaOfu4zYnv7MPBKj+Txzp5Ec4g3i6MZX42MX8XbRrjv0ILoxGlM4mHGksjwZQf6npWSqEc0rUyIQKakjhlDgRHZ9AAwpCM0mnYUcdgQDIWy36BFksyJddoC7lkcfMJNT5zYa3ElHB02Zck5N06QLGob5Df3X5RrYJo/bSo9pxoZOnZ8b0Uk4sFyWbbZ2FWE1wr7gw6gAeuzT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLLFazl1DpFIQcROhxLo6V1JROMDL+z5X9JDTpdwmeg=;
 b=HxzHNkQGIv4BaxKu4PPQJ+c4gREUyZnfVkzuxj9SNYAvx9p49lCcQINPImHx3tsv6NB/1GDMNaiQ2nJWLnesOckVsq033PHyxTVDeGSqHy87dRnSMASzeBaHh2u6Pkrfsx2TgRFA1+vGSqGuKi6Gk/cCCWMxq8zUeX/HMYnGfX1sVQIVXdn8IY1Pju41BdySSvVAvnTqq8yfUq/BVCaYeeVzAeRMT0oFLq6s8lrY/8RuZmfbYI92tIWhpznJ9pC/d1AEd4xtYH4IAVdT54bo3eusXIqyWYyVazGORgJGmfG4Dxnl3eLfpZYzFUQADUHM2fRjrKXU0l4DMsEroYtR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB8PR04MB6522.eurprd04.prod.outlook.com (2603:10a6:10:10a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 08:46:02 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::21fb:190b:867a:67d2]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::21fb:190b:867a:67d2%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 08:46:02 +0000
Message-ID: <b0a743b7-81d8-f019-2df0-c94c0fa51287@suse.com>
Date:   Mon, 25 Apr 2022 16:45:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 02/10] btrfs: cleanup btrfs_submit_dio_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-3-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220425075418.2192130-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:510:4::6) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c671e7ce-35cc-4f53-7529-08da269806ca
X-MS-TrafficTypeDiagnostic: DB8PR04MB6522:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DB8PR04MB652235F1B4DB3E256C1F85BBD6F89@DB8PR04MB6522.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9DuUCbnmk88HfWsuQG9OAzUleLJpKL5Okz6xkRet4M4sBLVLHvMF1RHYGXTN2IoKJo23yckNPSh+dknG1F7EkyAN0Zn0pmS2RpBu1fvieMokipZC8Gxd4NkHWex13fmqHqKdweMJpfaWYW4MakeQFZPByc054tJrUxn57mGsIHiDS6AY1PubvuJrFMAXUwj1OHPISWV+X8SgeoHYnmKiRRkAXb2/Ma/P1sVMsmWAknEmb4t2hPsbEw11x0ULbmg+XYfSflMnrpR4MLxwKLw6LKtyc9D94bEY8rY3I8G9Lb8AtxVCnszbvLrL5ntw9WEdbBRkqVh7Xh69tuy+ScYQvMCe4/yGobHLDCwpfLPjw+Q0ZnLQUlVkgIx6YNBZZKBzJDFsYJ2NPJz48v1mFWqF2LTMMIfwszSHALBjHBEjjqxCbWBWRrUoVuevSZ/3qDRzNBLZ7bENLgLKu7OVgWbEyWmDEqHqNOtF5FWIqDpIYMAlxk05XpySwlSKNvhI2oxrWy/H6ojW69GLSe3Jk/lwdPbyNc0OJ1/U4FQ1VBTcQCGc1AiHZd7G7zbwCdCmwH3qchUAdQObBYPNPLPKlnVZ22h2K7b3JVDnqdNML1a/GpdjUN+h60y3uk+MkxKtHKMlKlPHcHiBb326rTIR5JldfcOhD11v4DoJFVbBsJbKy/4P/0zZ7Ua1AghuNkA68UJincvQRsHIj3wfNnm46+yRzNj1LM+nQwLkWFNLYoEvss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(5660300002)(8676002)(31696002)(508600001)(86362001)(2616005)(4326008)(31686004)(6636002)(316002)(66556008)(66946007)(66476007)(110136005)(38100700002)(36756003)(83380400001)(53546011)(6486002)(26005)(186003)(6666004)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRrdGRRZ1JuWEJDU2wzNVdBMW5hY0RBaXNxaG1ISUR2bXlsUE5Da3JlVFYz?=
 =?utf-8?B?QTA5SFQ0TElmUEkwRFdCOUhyVjUyTCtqTC9qTWNGZUEzSGdNQWtmK1RWQW41?=
 =?utf-8?B?d3JZZkZKTUZndXhnU1VQOXVQakQzcFgrNmk2bnk0c1FacGpKd0hVZWFSVXNN?=
 =?utf-8?B?SWt4T2dMYmRHcjY4MmZBbFRNeFFtV2RyN2kxeE1MNm5MMHNlUFFvbUVYamVG?=
 =?utf-8?B?V090Q05hN0gvRXFPWU1vd0NlMGp3RWZXNFZPaUZoa2RONkJiTFZzdGVONmpT?=
 =?utf-8?B?VmxhbmNVK0RsMzFuYjJPYlA0ME1aOENML0pJc0lCeExRb0ZTY2RPUlJSbFRU?=
 =?utf-8?B?TnVVQjgxb0ZpejFkS3RUWFUreG9ZTFdIYUVINEFkQjlXVUVsVU4xSXhSMDNt?=
 =?utf-8?B?WWtSVHhsWkFtQXlFelFsYmdsbVpIZVlEK2dHa0Voc1VSeXUyV0EzZHBWb1dl?=
 =?utf-8?B?cExRUGFjV3lnQUFUQmJlWU01V2NmMkZSSHl5Mk5aaHFZVWpmZS9ZYUZ5cisy?=
 =?utf-8?B?N05jVUprSWxhZSs0WGZMdE85Q09JNTVrdlhpUnNtS3JYcWlUcHhCeFNsZmJI?=
 =?utf-8?B?bmdXTXRqNHVYWFI0dmVTWVpTRUdMODVOcWlyZ08xM1NLejFGWWtrNFo0anBr?=
 =?utf-8?B?VHQwTWF0aHJSSHp4eWpKZ2dtNGk0amtvMUdqNWQvbDV3SjJuY3JLa3RUZ044?=
 =?utf-8?B?NXkwR1BZQkNjMStxUFhmdGZkYWZZeEwvMEZiNHF2N0l5Qy94OEpGbUlPaDhH?=
 =?utf-8?B?dW9lakhaRzF2NUc5ZDF1dGNLdThEZGUrbW0rMnlqbVgzaVhIVE5PcEwwMFJj?=
 =?utf-8?B?Zy9MdTkvT1NpVElhRjJhcXkweExFWVExRG9YUzdkWW5pc1BpZmtXVFlLNkV3?=
 =?utf-8?B?UHdPUVg0MHZnZ0FOMGNHbW1WZElROFVlMHJpNjk4dDczWVdqYUFIZUlZWC9I?=
 =?utf-8?B?Qk4rdm05U3duTWxMTEl3MTJ2MTc5RHRJenF4ajhISE9QYWFPMzF6SG5BRmJP?=
 =?utf-8?B?bWZFbTUvQ205b0NOUkNrT1FzZEpQTEhmMjhieURrZmdzanc1cStXeDBCSHJm?=
 =?utf-8?B?eS9OeWMyNXUzbHcxNno1dXRDakpRZ0xSYjk1MWxOMmk4b1YzdGMxU0dvdXNM?=
 =?utf-8?B?cnlBaFlhZGJqRm5HcjZpUVQ0MzkybEhRakN4eDV2SWFtaFgwN0l4N2RKSFlu?=
 =?utf-8?B?NlFQcThGUHJKWHkyc0hoRzcyNXp5K1g3MXdZcFpWL3lkdGdnQmVmeGd1aDVs?=
 =?utf-8?B?b0Jhb1ByL1RleUZUdVNyRG5sMVVrd2NDU0RUZk5iQmJrUmlnSlgrNTJDL2xW?=
 =?utf-8?B?V1AveTNFQkt5MzlCSjQvTDdjUVBVaENUSjBxWjZNTTJDT0lFMEdBVnc5ME00?=
 =?utf-8?B?a3NrTzR6REs0c0VZUW82Ty9QczNBKzgvUFJnVnlRNHJJQWo3Z1RrbWswTnhx?=
 =?utf-8?B?SEtEcDQ2WEJMemNPQkM0SFdESlM4VnU0bno0NXlucXVxU2pvL1k0enY5Vk41?=
 =?utf-8?B?SFVWSmRzYlVoY2hTZGN6MTBBc2M1UDVMKzFaT0RVaHZKUC9mekIreWJhNFhu?=
 =?utf-8?B?RU9Wcnl5YUNraWdGT25UQm96bjk0QTVBOGFtZDEvcGZGSGYzcHV2VW83YWEv?=
 =?utf-8?B?dGZ5SHpKenZ0T3RvcFpNdkpvVVdOS2E1dEZyVnR3YmVUYjdKUm9PeFc4YVhL?=
 =?utf-8?B?SDg3V0hNTWprdTF3SmRBaVpEejlVWTI4dzdxWDluOHREYkhsWll2VWFZUWhu?=
 =?utf-8?B?eU02eFBVeHZJQUczYmRoVzBSSndkWW9BRTVwM1cya1FYcTBQanF3Z0hxTUxU?=
 =?utf-8?B?Tzg3YXhUMVJTUmRxZ3VaZzJCY0ZmaE5GOXhxNm9IQ05DWEt1djBvNENGSHFn?=
 =?utf-8?B?VktzVlY3dFlKc2hzcS96cis4b0sra1crekxXR3B2eExubEkvelBIcmlqbDhw?=
 =?utf-8?B?R2xiVXR2L3I5QnNCdStyMUJhc0tUVXR4amV2b2J3T2htZHhtMERVSXdKRG83?=
 =?utf-8?B?c01QcGh1b2FsNXlDNXN3UnZLVGtsZnBxY3Rqb0lXdHFhZ3J5bE90UXdNMmNo?=
 =?utf-8?B?VFNoSmQwMkRmWmg2VDhNM2QxWC9GeGFrVzc5TFoyOG1leGNrRFpGcFNUUGVJ?=
 =?utf-8?B?Y3dHS0FkZnErNEErYkorS2c0ajFOdEJzYjJXU2VaZWZtMWw0VERreTkyREE3?=
 =?utf-8?B?VERWVmlPalJrVTdDZ3Yra1M4MEVGTFhKclVTUXJrVHduNHF6VFg5Z1d0b1Y3?=
 =?utf-8?B?NXlOWVpyZkc2Ym8vVGtmQmZFODJGd0htQU8wY29BcWdmaDB6MXltcE1VandI?=
 =?utf-8?Q?XJnDXMeKeGwzWm//lU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c671e7ce-35cc-4f53-7529-08da269806ca
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 08:46:01.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5/1osZWXh84uCMWkdoxTwYDGszP4Nlm3XIYjqGqws7TAqhXUcJolucK/+IRh8/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6522
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 15:54, Christoph Hellwig wrote:
> Remove the pointless goto just to return err and clean up the code flow
> to be a little more straight forward.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 23 +++++++++--------------
>   1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ef3bee1cbc6db..b188f724eff2d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7899,31 +7899,28 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>   	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
>   	blk_status_t ret;
>   
> -	/* Check btrfs_submit_bio_hook() for rules about async submit. */
> -	if (async_submit)
> -		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
> -
>   	if (!write) {
>   		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
>   		if (ret)
> -			goto err;
> +			return ret;
>   	}
>   
>   	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
>   		goto map;
>   
> -	if (write && async_submit) {
> -		ret = btrfs_wq_submit_bio(inode, bio, 0, 0, file_offset,
> -					  btrfs_submit_bio_start_direct_io);
> -		goto err;
> -	} else if (write) {
> +	if (write) {
> +		/* check btrfs_submit_data_bio() for async submit rules */
> +		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
> +			return btrfs_wq_submit_bio(inode, bio, 0, 0,
> +					file_offset,
> +					btrfs_submit_bio_start_direct_io);
>   		/*
>   		 * If we aren't doing async submit, calculate the csum of the
>   		 * bio now.
>   		 */
>   		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
>   		if (ret)
> -			goto err;
> +			return ret;
>   	} else {
>   		u64 csum_offset;
>   
> @@ -7933,9 +7930,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>   		btrfs_bio(bio)->csum = dip->csums + csum_offset;
>   	}
>   map:
> -	ret = btrfs_map_bio(fs_info, bio, 0);
> -err:
> -	return ret;
> +	return btrfs_map_bio(fs_info, bio, 0);
>   }
>   
>   /*

