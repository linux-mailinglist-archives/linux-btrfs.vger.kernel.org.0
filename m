Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE05B90B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiINXDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiINXDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:03:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC486C3A
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LezxnU0WKrO7oA/6dlPcgs30tih214C09k99bl3E/wHK1DYOu0VbQv4Izw/znXv+CSq5S5Oi1lNZ2fl70RUAYFhlKehEoLi8BwY4KftNE/yE3ZCQCiGWi/D3To2EiIfkl0FFXHPSDFwbcaWewyrSgDAJxxTGJGL4d9vI7xZ3E0nu9QscoUAINhVcba34bhF3/MLJKo+mCpoNuwUL/5uIF2+zETyBSAyFH5SBMmOCoWEeo0LAhdBWVImPbQBSoU05p/Dz7PtbFGOuOC/GQCqvL3geQK0s4lAD1NN4hM39Z+sSdnF+q8N2TiHfa1xOpIGRfdFFuDJy/Fb4MWT9wTibfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkd1VwtpkqTmRI/1X97ezIgVreUL+yuVAe9ZK51WraY=;
 b=EDTboDZt+yMt6H4pGeHA+m/XcqsWCDLU+pwGTHtdR+qqFRNo7oBgIIRBpGQ3ULnaRaRSQcxRTnc/qHuLWsnhw3UrZsRMw+FFBDY+1PmSwSARsQBzGlGjks6vmoHVzB76CcUFI/FUo5m3xMXqGi4h5wD9fHmAFZoT4H0f8ZiUQ1nxNj5fQGbs10trP38iYWigBQtOfGY3LYyubrcotfd0wVS6g6YmUlQcMe+LgA6h/dKyzjkj4emNOeHjmgy6iWK1S8ORCT6Db8wOSAA8tgk+2mbl9hnMQoj/QRwUqdE4NV3sCDewrCdMIb3f7aAE5y8AbHvVirJX4h6CCf4LB2GOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkd1VwtpkqTmRI/1X97ezIgVreUL+yuVAe9ZK51WraY=;
 b=17fHRkVxe8W53nEdqiLcatmSDlKMqq0xgx4JC4PMPXyauqczHN50cyJzOlqYa7FGIDMUr4mD47LMp3DTkzI5Gvhdn1ZinzSy2RXQEzAwhzaFXxHelyDHS1CL4x/YXI9U9hfUDezgmsqqxIleOCREHITo4SsoC8Z6shlSdLTtWYu/GVVl3kx77YCPQJg428Fo3dqlJqW8uqLltvD0GQJHUZni72xrqaaJFpMALr0VNnK4IEXpi5HyqQYQYpoMsF1iV4f4D9mKk8jDVwO4UIfVsWwih8slMFNMOFo5l/afWpPHTyuUe6b34vHzG3mzcUANmBYbWSMXpolODUcIY+B3HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com (2603:10a6:10:2c4::13)
 by PAXPR04MB8336.eurprd04.prod.outlook.com (2603:10a6:102:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 23:03:11 +0000
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::5913:2f6a:33a4:1968]) by DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::5913:2f6a:33a4:1968%5]) with mapi id 15.20.5632.014; Wed, 14 Sep 2022
 23:03:11 +0000
Message-ID: <aaa5ad8a-20e2-eefd-6f2e-026a1cdc626a@suse.com>
Date:   Thu, 15 Sep 2022 07:03:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1780f977-2717-8ea8-c5ec-6cf30d98d261@gmx.com>
 <YyJUUQjLj6z19lP0@casper.infradead.org>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Is it possible to force an address_space to always allocate pages
 in specific order?
In-Reply-To: <YyJUUQjLj6z19lP0@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To DB9PR04MB8478.eurprd04.prod.outlook.com
 (2603:10a6:10:2c4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8478:EE_|PAXPR04MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 15072036-9d3d-46d1-42f0-08da96a54bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvkzloioEBVGFYwQizebboI1NJj/IZNSYnG41FkAujZy4ctmFCZXKSiejo8pZyKD1XGLjf+QPKlK0PN6mWiQFlq9PtAQCIJWfjCDD32B5WqyMyQwSG8DJE42Zom7FN8B9Jv3yG7kzx9j6+4ecqtlnoRrxU/wtMA3bx4vw7iRluMfUL5UaRW5xHU1SKJG+ROmH04gChM66JEE0fu/fK+dPmlES/KmJapYAW01H2BkalHeQzhr/8+4L1AcOv4CVSapTzQBS0C1hSMykBiF22EsVCzJ9qS8Q8kl6nRU1YXc9ZLawMt3bqIDVkmdu7ChnHhXbqcr7203eznS9B0vUomWqnhx3KRnnGz2VP6Rs73fIx2bGWtOfke4Ia3ImFNKmFQSQLTbtotShS8I2rMG/RWbK19fqQL04x9ZYb0rG0FDQ7I4f3CtwBVESCvwEsR9WB/oVKYCS8tB/NJfRQQMdwIXlretrAZcTjJ5hrJerYJgshuO7E97IB3CwPaTJeDgh5M+Uo2a92Dajb7AXmMYLpbHHG8rjMvuLPtNZ8OXLbDfkbohbLibHzN4/43zEa7T/rVlm8Q56zBKByfazGeWBhqeHt+JDlTFvBlhhAxM3I6PUhXU0peJK77W61Fir74FPReFgM1+HlJZpkG/IgkBtmkQSjofdneI2Ot2obzMweDDx0FB07AX2BBUp07u6+HrKT0lQGh0Hh4ymjmJDAUx+IXL6NfIeIhkB1zj7azruP+qaeYopNJAiPbgRxIETfx4M7lHoBcCcuK6io02soHBMKPhoQRc8CyEag3jD3dLksJB/EA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8478.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(2616005)(66476007)(31686004)(6506007)(8676002)(6486002)(2906002)(31696002)(53546011)(36756003)(6512007)(54906003)(186003)(86362001)(83380400001)(110136005)(8936002)(38100700002)(5660300002)(6666004)(66556008)(316002)(66946007)(41300700001)(478600001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ams2TjB5TCtmaGlMMjVmT0tCeVY2WWo2bjlSY0M1YTVHWnNkbi8xOEVwV0Y5?=
 =?utf-8?B?bk90VFN3S3RMeGVCanpVZUNtKzNhVUNGQ3NUcVlKb3M1Y3pVeTlvMThndFpG?=
 =?utf-8?B?YVIrUCtmRGlCay9ybGtFem9RQ0dQYkFiV2F2MmlpMlFRTnRoVFZRN1JORE9Y?=
 =?utf-8?B?cG5hWmNOMnJURUxBTHZoeGdEUEdpSS9ZbVF6WlpscndnWmNhS3BSMkNsTGlN?=
 =?utf-8?B?WjFqNXZvcHBJVmRCTGJYUG5UOWM5cHE5NVAwSmRkbGJiVEJsU1Q5aFFCT1Ix?=
 =?utf-8?B?ajcxaFJ1QWtKRTI0eGlKNUNCYk9mcDJOQTB0WWZrZitMYTdRMmR1eXlZKzVU?=
 =?utf-8?B?ckJ5cE9UODZSK2dsVE9pY1FhVnFuYjVsNXRYaHErRmZMaEJ6a2lIZkxrS0VZ?=
 =?utf-8?B?QU1vS09ZekkybVlRckNHdVN6Yi90WXVDWnpvYW0xOGNlWWlGTzcyNHVyZ3N4?=
 =?utf-8?B?d2k0blo3NkZmVUV6VE4vWXVEUytIa2NiWXUyV1QrOEdCeWxyVEZEMXk0Qkps?=
 =?utf-8?B?dkExNTh6b2dSMkx2Y2FSQkNGRkRaMllWUHBnSjRXdEFST3FZRTVYOTYvNkRl?=
 =?utf-8?B?clhacUlxVHV6SmtZOEdKd0ZMeDNLb1dKaFhLa3hXRDFmRFRrWGdRMWM1UytW?=
 =?utf-8?B?clFUeXJpWUltcUhHN1EvVVQweW0wZHZVOFZtaGxQQURSMjFKME9uL05ndFcz?=
 =?utf-8?B?V2dIMWl6dlpPR3NsRTZkRHkvMVQxL29rd2ZFcnBkTmcwcjR0M0JWQmVoeWhz?=
 =?utf-8?B?MGE4SjN6SW1FWnNBNUd5QkhDZzRtM3Z5YmJVT0pIYzhGZlJzMUFpV0VlREdr?=
 =?utf-8?B?dnplSXRPRVZ0TjRVMUJwbktWYXMrS1dEdWdwRXJZQjZqK0loUzBPUVp3VTI3?=
 =?utf-8?B?MmlHMDlMK1doaEJLQzB5eG8vSWRCZVZQR2tTZjh4Q1RPU1BVSndnSGdLV3Ba?=
 =?utf-8?B?c3VPb1pwQ2xWdjFINFdkUXc4Q3NvczJSczlybmFuRWkvcHJ0UWhvYXZYRTdw?=
 =?utf-8?B?U0xMOFVnNGp0RnhSWWhydjFUNnpoaDRIWFRtS1JBUk5ZekhKY2FzT05ERCtq?=
 =?utf-8?B?REFKRDFCNzhJUVIyRktWblAyQktmSzhLT0puRDBzemR0VlFJTGdMd0JKUkYv?=
 =?utf-8?B?WlJxQzY2T1RzNzFtUnZZbDgxbDVqcHczeHVwT1VoWndtZXhuMFBMSGtyb2Uw?=
 =?utf-8?B?Umw3dDlHR1BiOHkzamZyTzBTcy9xOCs0VEdnSVN0WXA3d1lSQ2ZmeEFDWHJ1?=
 =?utf-8?B?VzgzVjJpcnh3d3RTZlMzb05veE14bEZMV2wrdHBqODhjZzlpTHB2YlZxTHhI?=
 =?utf-8?B?WXRnYitiTURGR21YblBTbHQ3dFVrZ0k2dnJ2TWJHeGFXVHhGaHhWV2ZGaTl0?=
 =?utf-8?B?am8rd2dBalFsZjZESDZnazRrVnpMbVFRRk1SYzRneFdKY1o2bWUwVXh2N1RS?=
 =?utf-8?B?Z3dOTzVmT0kzU0NHWFZlRVl5SlZrUVQ3KzZ6NVRhdE54OTkwdk0zZG5BaUJl?=
 =?utf-8?B?NlFqaUpHN2dCTkphMTB6REZJN0o4LzFLNjY4QUhXc21YUDB3eTlCWUphQmZ2?=
 =?utf-8?B?aUREKzhkK0VoMjAyeS9sdHlsemZTVVplaE1WT1NNd1pLVklVMWh4eUNYL1NV?=
 =?utf-8?B?Z0p3am5oQWNpTmhNemRqVmpxOXBsWi91czFvbk9hWHZVTFBDbDR4YndiQ1hr?=
 =?utf-8?B?Q09mRGpBVkNvaVY5dFlPNnl5d2lXRDNKZThxWFRvNzE3enBxYVM2L0tITG5w?=
 =?utf-8?B?WU9sdDk4WnFiL2I4SXVlMEEwa3oyUTRWdkRCVTAyUld5K0pFbE5ONktZNU0v?=
 =?utf-8?B?TFJqODFvdjVkeTBmbnVvMU5VVENEbUgyNlZadmFSaWdCYTBvcUcxNDhob1Bl?=
 =?utf-8?B?bHEvZjBXTFhyZnVid09XY1U2ZHJGd0YrZFhNNkNKZ1lsM3lZNC9ITmpoTlJX?=
 =?utf-8?B?b1FNZXRpME14WndqS0tPR0Y3cEhGOEYvcHR6bFFkYklXWUNuR2h4Y2FjcjlL?=
 =?utf-8?B?TG9HdzJoVVdMa0VnTWJPRHhIRG9Zbzd6UGJBTTE3ZFVOa1VRbi9NZHFaZ1g2?=
 =?utf-8?B?ODBXcjBLSWlUNXFUS2ovd0dzclhXZkZHbzd1T01xbWE5K2pQWlBGQkhOYW52?=
 =?utf-8?B?M0VWdkZ4eER6clQ3MWxWc2FyY0lJcXVOelBVeWRYekpvSnlMRnc5STFFTklt?=
 =?utf-8?Q?Vzxlvh02zU480rrkGk9h1z4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15072036-9d3d-46d1-42f0-08da96a54bf1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 23:03:11.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0v9OUK8M+t2qis/j19+sJbmlZ7sKnFjtus9gbq6zQj6QjQgTiFn2nGZR9+oBRYv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8336
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/15 06:23, Matthew Wilcox wrote:
> On Wed, Sep 14, 2022 at 02:17:24PM +0800, Qu Wenruo wrote:
>> With recent folio MM changes, I'm wondering if it's possible to force an
>> address space to always allocate a folio in certain order?
> 
> You're the second person to ask me about this today.  Well, actually,
> the first because the other person asked me in-person after you sent
> this email.
> 
> We have most of the infrastructure in place to do this now.  There
> are some places still missing, such as allocating-pages-on-buffered-write.
> I don't think any of them will be _hard_, we just need to do the work.
> 
>> E.g. For certain inode, we always allocate pages (folios) in the order
>> of 2 for its page cache.
>>
>> I'm asking this seemingly weird question for the following reasons:
>>
>> - Support multi-page blocksize of various filesystems
>>    Currently most file systems only go support sub-page, not multi-page
>>    blocksize.
>>
>>    Thus if there is forced order for all the address space, it would be
>>    much easier to implement multi-page blocksize support.
>>    (Although I strongly doubt if we need such multi-page blocksize
>>     support for most fses)
> 
> It makes the MM people nervous when we *have* to do high-order
> allocations.  For XFS, Dave Chinner has/had a patch set that uses base
> page size to cache smaller pieces of larger blocks.  That approach works
> for fs blocksize > page size, but doesn't work for storage LBA size >
> page size.
> 
> It's definitely going to be easier to use large folios to solve your
> use case, and since the page cache is usually a large part of the
> memory consumption of a system, maybe it won't be as bad as the MM
> people believe.
> 
> I have the beginnings of support for this (allowing the fs to set both a
> minimum and maximum folio allocation order).  It's not tested, incomplete,
> and as I mention above, it doesn't do the write-into-a-cache-miss
> allocation.  Maybe there would also be other places that need to be
> fixed too.  Would this API work for you?

That is already the perfect interface for btrfs metadata at least.
(Although I still need to do more digging and testing for btrfs to
  migrate to folio interface, other than the compat one)

The point of btrfs metadata address space is, all of its page cache is 
pre-allocated before any read/write.

And that address space is only internally used, thus we will never go 
into write-into-a-cache-miss case.

Thanks,
Qu

> 
> (as you can see, i've been sitting on it for a while)
> 
>  From 1aeee696f4d322af5f34544e39fc00006c399fb8 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Tue, 15 Dec 2020 10:57:34 -0500
> Subject: [PATCH] fs: Allow fine-grained control of folio sizes
> 
> Some filesystems want to be able to limit the maximum size of folios,
> and some want to be able to ensure that folios are at least a certain
> size.  Add mapping_set_folio_orders() to allow this level of control
> (although it is not yet honoured).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/pagemap.h | 41 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index cad81db32e61..9cbb8bdbaee7 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -198,9 +198,15 @@ enum mapping_flags {
>   	AS_EXITING	= 4, 	/* final truncate in progress */
>   	/* writeback related tags are not used */
>   	AS_NO_WRITEBACK_TAGS = 5,
> -	AS_LARGE_FOLIO_SUPPORT = 6,
> +	AS_FOLIO_ORDER_MIN = 8,
> +	AS_FOLIO_ORDER_MAX = 13,
> +	/* 8-17 are used for FOLIO_ORDER */
>   };
>   
> +#define AS_FOLIO_ORDER_MIN_MASK	0x00001f00
> +#define AS_FOLIO_ORDER_MAX_MASK 0x0002e000
> +#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
> +
>   /**
>    * mapping_set_error - record a writeback error in the address_space
>    * @mapping: the mapping in which an error should be set
> @@ -290,6 +296,29 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>   	m->gfp_mask = mask;
>   }
>   
> +/**
> + * mapping_set_folio_orders() - Set the range of folio sizes supported.
> + * @mapping: The file.
> + * @min: Minimum folio order (between 0-31 inclusive).
> + * @max: Maximum folio order (between 0-31 inclusive).
> + *
> + * The filesystem should call this function in its inode constructor to
> + * indicate which sizes of folio the VFS can use to cache the contents
> + * of the file.  This should only be used if the filesystem needs special
> + * handling of folio sizes (ie there is something the core cannot know).
> + * Do not tune it based on, eg, i_size.
> + *
> + * Context: This should not be called while the inode is active as it
> + * is non-atomic.
> + */
> +static inline void mapping_set_folio_orders(struct address_space *mapping,
> +		unsigned int min, unsigned int max)
> +{
> +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> +			(min << AS_FOLIO_ORDER_MIN) |
> +			(max << AS_FOLIO_ORDER_MAX);
> +}
> +
>   /**
>    * mapping_set_large_folios() - Indicate the file supports large folios.
>    * @mapping: The file.
> @@ -303,7 +332,12 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>    */
>   static inline void mapping_set_large_folios(struct address_space *mapping)
>   {
> -	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	mapping_set_folio_orders(mapping, 0, 31);
> +}
> +
> +static inline unsigned mapping_max_folio_order(struct address_space *mapping)
> +{
> +	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
>   }
>   
>   /*
> @@ -312,8 +346,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
>    */
>   static inline bool mapping_large_folio_support(struct address_space *mapping)
>   {
> -	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	return mapping_max_folio_order(mapping) > 0;
>   }
>   
>   static inline int filemap_nr_thps(struct address_space *mapping)
