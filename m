Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2546043DC39
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhJ1Hiv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 03:38:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:33635 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhJ1Hiu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 03:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1635406582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54llsslzTMpi28+8rNOpOA1tomS438AJro76Mp0JkmU=;
        b=NlkvtipDD3qc1ynFRRC+/S1ppQZO7V2r2WLbHjSMpYYtdhng6l+AQQjNaoCF2yyX0Jghu6
        o+EL7YJRkikIemmYyjWLHVjmweTaRZAsjaHIo+2G+d+p+pheR5hoKHcaO4dpba6Q5TBL7X
        lWty9GBLWXPcr11LN2LWTrG80tGbcgo=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-huVKKkLWPgu-K4n5AlMgsA-1; Thu, 28 Oct 2021 09:36:21 +0200
X-MC-Unique: huVKKkLWPgu-K4n5AlMgsA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJQkZv4zZJKXuS/LOVD7SgA1STTEE4kFyTEvI4M/5FOolqQJAeIJU9TXmXfU4K862SLaORYlhAdPmhMYIIiz/+LKL0IRnODk5GXpcvvbsPy+tu2kinKA3R6IUSPgukTcYhvZ+Zj6tJBYEJu6WZqJleUPKKBeutCEYYFEdYK6tk708QnmH11yC+XgkF1LvXRac47OrJ2uguLRwtUxOC9MrqW9l1/umQXDmbuxcRwUT5HWGCW+quZAcD3RFXYvUSNeo1ZVv2lwPVhoTa+eCe4XnfnP5U9bAWFYEygjDfUcnJVyUyBfK8yuYe+Hlq7w8OYODTGdCXetF1EW+rX4TX0n8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54llsslzTMpi28+8rNOpOA1tomS438AJro76Mp0JkmU=;
 b=UsYFHVH3R7NyZDXq9OripdxbmYwlJrHySaAqFZ3p13YQVQvV/Lm8IJuMeUfwm4zY83isu5pNc9w7y/MRk/6XJrfiBXkZcI+RecS6jQ5c/vTiuiYm5U6Ev7jdN7ga19yN9is+Y1L3VmE8oorNAq+4b2z6hnE7amFcK37gl66Vtlp1hp6GwhHAjQ0YFxRtzpUIAJr0XsI9uZfkr+s1JzJxtrBL4s/wwXMTEszRQnommCgUnkci+m+j+MON2WGx1gWMYMeOsCxzlfsgeHiS6ANMJtZuSVqKA7S/evpeMo8MXDj/ikvf31w2+eFJPZlxdyWXWUWVGcWAiyeQWN6hjvgzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5288.eurprd04.prod.outlook.com (2603:10a6:20b:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 07:36:20 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 07:36:20 +0000
Message-ID: <3845c0be-6ed8-171e-67c2-92a6f80a60cd@suse.com>
Date:   Thu, 28 Oct 2021 15:36:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs/btrfs: Make extent item iteration to handle gaps
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     grub-devel@gnu.org
Cc:     linux-btrfs@vger.kernel.org
References: <20211016014049.201556-1-wqu@suse.com>
In-Reply-To: <20211016014049.201556-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0336.namprd03.prod.outlook.com (2603:10b6:a03:39c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 07:36:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5716fa0-5eeb-4987-3e2a-08d999e5a248
X-MS-TrafficTypeDiagnostic: AM6PR04MB5288:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5288B92F644EE23B805B9C18D6869@AM6PR04MB5288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVpGpu5cZMuEKJPpz6Yh314kPbncFEBQml4F7x936WTnUaQjWRGeWa3X24fJhQZ/e40QlLlNmKoxIEdCWtU8DukIVHANqr36E9RDtYg7aoOKTrtVVhsLx4B7wjc5szI/EJvT6xxA/UF7y/Slp2AW1ntIN7MGA/DCtVfAb0S8dcEBM2mSSjOKxp7d7+ZuA50liwIR3vkFPZICTxP3A0tTffKYDyzsMvi4hRyfdzisP/4TxmOHFjWGAgArghSHZiOOrgNPHjdx2JZqoZwcpAii8MqsRFQUMitK4RfMJxiFX1b/hkd3SJVJpxSIftwM2eQ0tRz0Xlhafwz0Op+0SksuTLxvMBJU+VpRsi3+/SJW89lA4ayPmSoKF410/t3tYdBkbQew3z5Mz7v0rBrKqjq1tkJTsjd0UB9oqIWujQnFzt3fn/5jCv1Wr5wqAypsGURO1zv52O/Fewr6FCV3+dLvxN68nrSYemjECxv1uBTWxr9E6oOTBwVHXc+RUXLgqBtnTpAmNeB1OsXa0HxZRBJj3dNdUJKAxESWERwqNzOjqyc0Gj7Yv7Gm5PsAkvp9jAMHDVTgkw/vzlY2Qw5Xrh6sva3BxofyXqLU4o4iND1sSihruLUnig+ywgS+MqtOgGDNO+VpGTqBfgrszuK4yRwfBoIlnXJK8cnqmp5UGj/wwKd+3sENWN2Nwp7yhlXojbSYqmMawzEtarH1IIYFEv+1KK5xvcmcA73koBXbxNaIY06HPigaZ41OpzNuyxwkiyx+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(956004)(6706004)(2616005)(508600001)(186003)(2906002)(8676002)(38100700002)(6666004)(5660300002)(6916009)(26005)(86362001)(66476007)(66556008)(36756003)(316002)(16576012)(31686004)(4326008)(53546011)(66946007)(6486002)(31696002)(83380400001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHBWKzFzRnZYOFMrZ0tUTVZId3ZwQVpNdUp3eVBEekdLYnRkRURLaytta3Q1?=
 =?utf-8?B?TzliZEZndTY2eWJ2ckt5QmNTUTc5dHdWb1NhVU9sS0xNdkZyT2lySTFtM0Jp?=
 =?utf-8?B?WjNOenZudmNQZGtJMkxUMFByUmY0K1AzejRLOGU1bXdBbExQMFJwL2RLSGVC?=
 =?utf-8?B?R0Qrc25BVzN5dHJBZUZmd1p6RmlPTm96QjZxcHdOQVVIZjIvNW5ubWZBdU5U?=
 =?utf-8?B?ckZvMzZ2eUdGN1N0VnNZS1lBRW5KK3U2MEt3R0pOVmUrS08xaURFTWZpVWo0?=
 =?utf-8?B?OUxZMTU3NnI5QldMVVBUSzdyZm4zVms5QzZ4TVhCbXZ1Uk8xaXJCTS9TTnQ0?=
 =?utf-8?B?L1RHNnQzUGlGbGJsVUZUOWphdjBFN0FqR1ZkdEtFWEVqc0J4dFZBR1hCck9u?=
 =?utf-8?B?K0psa21ia1JDOXpaVElsWFRYUE9SbEVBREJpeTBTRmVVZVVOb1hMQmFKQTlE?=
 =?utf-8?B?Zi9SUEN5RmdtdlRJbTFJWEhVMzFOb01RUGJST016UTdNNUM4dHlhVHF6bE5Q?=
 =?utf-8?B?dlQ5S2dKTTZGTnNCOUxGdVJ1T1VwKzNOZnlOVncyMUl1RzJJTDhEZzI2Rkw2?=
 =?utf-8?B?NXRaS0ZGVlg5MDZjYmo1dTZhSXlOUG5zWlphcXF5a1NpWW5idWh0M09GOFd3?=
 =?utf-8?B?NGRsYmxpTjdRaTNGUlR3azFpMFJUUXo4dUt4RGlpNlNmL1dYalpqeWNMZGdY?=
 =?utf-8?B?RUdwUE4wRGx6OWltN3pCRWw1WUt1K29QRDR4L3VpQUUyekFIVHZDdUlMV0Mx?=
 =?utf-8?B?RDVva0J4c2xkZ0RvaUJIN3FwRlhERTVQSlBvcS9KbjdPa3RKM1VBZHFnWFl1?=
 =?utf-8?B?UXBPSkJ4WjFsM1RhWWVjdXQ5VitRNWNTUVpzWlJFUDllaTgrcGlGV2JuaHRV?=
 =?utf-8?B?dlhjRlhLWEV0U3pjRVZkb3VKUU1pakcxRU0wd2t5UHpwMTBFeFlyblhKV3My?=
 =?utf-8?B?cEJZeUlCQ2kzV1M5dlQ3UjRPYmM5SXU4TUVJd28yWVcxK3gxVTduOFB3VUlH?=
 =?utf-8?B?aDB6Q3MrQjJBS2ZRejl0U1lNYVNNVXlEaWlLRmdnM3RqUGJRV3owdGsvTGhU?=
 =?utf-8?B?Zmpkb0NyOUtIdnNWWHBacEViMVF0akhjTzROd2Q3Q1EzTHhtNU1sV0pwU2tS?=
 =?utf-8?B?NFZTc2E4QjV4Y0xXV2pLeW1pWmpQbmFBcE1hdzVQSGt3UmJ1WVB0a1BJdXFm?=
 =?utf-8?B?Q2Z4ZXQydGdYNFdNZHdNR0JSblVJczFtSzJiMFZzQTBRZGhFc1RjOXZkVDE1?=
 =?utf-8?B?RnhRNG5VbWYrMDNIQVlXVENkRFY5TE1FWkdRN2V6bUdRY0dNSXRuTXlLL1Qv?=
 =?utf-8?B?dGVKVUc1dXZ6UVdiUDRkRndRU1RpY21MeCtxVWk3alJjMHQxeVVBb0NTUEhP?=
 =?utf-8?B?OEg1VTE3Q2pnY2dzK3Y4LzNFLzdETGNwR2FYSFlldWd2aGJLcU9hK000bk9L?=
 =?utf-8?B?clZRdE8zN3VYTFFLSDdVTkdrMWlaVVluNG5zbGsyZXZSVS9LUFRHVWZMWG9H?=
 =?utf-8?B?M0NMTjRLcTlrNmd0LzE2NmFlKzcyN241ekEzUVp2TXZQYUcxTjlQdUpWM09K?=
 =?utf-8?B?Nzh5QkpxcTc3UGNvQzUvWkNMNFdxVm92WHJUK3VxOW9OQUdUYk52YWQ5Tmkr?=
 =?utf-8?B?RWdSSTFuWVp2aEJzRTI3bXFMNUtCTXhiaUlYN0JEcDhsK0gyVDBlSkdNamNK?=
 =?utf-8?B?cXhBeUZCOUJYdjc0TlZITlhNUVNWSGg1OUIzOG9GNzdxTE9rd0JiK3VJV1Vw?=
 =?utf-8?B?R0ZmRGtBWFdoK1FTbEE1b0ROQmxySEp2SVFTNFFBa0FUYzZ2ODViLzdpdWlI?=
 =?utf-8?B?TmVSNkd3NU9NdkkvMVFIZjF6YlkxTHRaM2RpdUZ5MzJqSHVZbEtjM3owWmph?=
 =?utf-8?B?ZSt4RWZvL0d0dDRHaU9RSEUvZkVoazNqNTNUQm1XM0w0QUNTaDY4eHl5YkEy?=
 =?utf-8?B?bjNCUlZDSERpMzRxM0szK0RMRkdUeHI3MnFjRlR0WUdhY00rMllrL1ZDa1dW?=
 =?utf-8?B?clAyM3puZlFvVWJaTGoyT1ExTDJsZENJem9vMGFuMGJmT01oU0I5ZlR5eDZa?=
 =?utf-8?B?QVZ0Q1k4Rm1CejZ3VzFkSjlXYWl6Q2RxUGtCS3k4NGNSOStoKy9ZK3lVbVly?=
 =?utf-8?Q?RP4Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5716fa0-5eeb-4987-3e2a-08d999e5a248
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 07:36:20.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5j9zc80v4BX2oxAPXraPe/MDkho6rW+IUXyN8OGMHC2eh0JHagHRQAoW6LTp9f3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5288
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping?

Without this patch, the new mkfs.btrfs NO_HOLES feature would break any 
kernel/initramfs with hole in it.

And considering the modification is already small, I believe this patch 
is definitely worthy as a bug fix.

Thanks,
Qu

On 2021/10/16 09:40, Qu Wenruo wrote:
> [BUG]
> Grub btrfs implementation can't handle two very basic btrfs file
> layouts:
> 
> 1. Mixed inline/regualr extents
>     # mkfs.btrfs -f test.img
>     # mount test.img /mnt/btrfs
>     # xfs_io -f -c "pwrite 0 1k" -c "sync" -c "falloc 0 4k" \
> 	       -c "pwrite 4k 4k" /mnt/btrfs/file
>     # umount /mnt/btrfs
>     # ./grub-fstest ./grub-fstest --debug=btrfs ~/test.img hex "/file"
> 
>     Such mixed inline/regular extents case is not recommended layout,
>     but all existing tools and kernel can handle it without problem
> 
> 2. NO_HOLES feature
>     # mkfs.btrfs -f test.img -O no_holes
>     # mount test.img /mnt/btrfs
>     # xfs_io -f -c "pwrite 0 4k" -c "pwrite 8k 4k" /mnt/btrfs/file
>     # umount /mnt/btrfs
>     # ./grub-fstest ./grub-fstest --debug=btrfs ~/test.img hex "/file"
> 
>     NO_HOLES feature is going to be the default mkfs feature in the incoming
>     v5.15 release, and kernel has support for it since v4.0.
> 
> [CAUSE]
> The way GRUB btrfs code iterates through file extents relies on no gap
> between extents.
> 
> If any gap is hit, then grub btrfs will error out, without any proper
> reason to help debug the bug.
> 
> This is a bad assumption, since a long long time ago btrfs has a new
> feature called NO_HOLES to allow btrfs to skip the padding hole extent
> to reduce metadata usage.
> 
> The NO_HOLES feature is already stable since kernel v4.0 and is going to
> be the default mkfs feature in the incoming v5.15 btrfs-progs release.
> 
> [FIX]
> When there is a extent gap, instead of error out, just try next item.
> 
> This is still not ideal, as kernel/progs/U-boot all do the iteration
> item by item, not relying on the file offset continuity.
> 
> But it will be way more time consuming to correct the whole behavior
> than starting from scratch to build a proper designed btrfs module for GRUB.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   grub-core/fs/btrfs.c | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/grub-core/fs/btrfs.c b/grub-core/fs/btrfs.c
> index 63203034dfc6..4fbcbec7524a 100644
> --- a/grub-core/fs/btrfs.c
> +++ b/grub-core/fs/btrfs.c
> @@ -1443,6 +1443,7 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
>         grub_size_t csize;
>         grub_err_t err;
>         grub_off_t extoff;
> +      struct grub_btrfs_leaf_descriptor desc;
>         if (!data->extent || data->extstart > pos || data->extino != ino
>   	  || data->exttree != tree || data->extend <= pos)
>   	{
> @@ -1455,7 +1456,7 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
>   	  key_in.type = GRUB_BTRFS_ITEM_TYPE_EXTENT_ITEM;
>   	  key_in.offset = grub_cpu_to_le64 (pos);
>   	  err = lower_bound (data, &key_in, &key_out, tree,
> -			     &elemaddr, &elemsize, NULL, 0);
> +			     &elemaddr, &elemsize, &desc, 0);
>   	  if (err)
>   	    return -1;
>   	  if (key_out.object_id != ino
> @@ -1494,10 +1495,36 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
>   			PRIxGRUB_UINT64_T "\n",
>   			grub_le_to_cpu64 (key_out.offset),
>   			grub_le_to_cpu64 (data->extent->size));
> +	  /*
> +	   * The way of extent item iteration is pretty bad, it completely
> +	   * requires all extents are contiguous, which is not ensured.
> +	   *
> +	   * Features like NO_HOLE and mixed inline/regular extents can cause
> +	   * gaps between file extent items.
> +	   *
> +	   * The correct way is to follow kernel/U-boot to iterate item by
> +	   * item, without any assumption on the file offset continuity.
> +	   *
> +	   * Here we just manually skip to next item and re-do the verification.
> +	   *
> +	   * TODO: Rework the whole extent item iteration code, if not the
> +	   * whole btrfs implementation.
> +	   */
>   	  if (data->extend <= pos)
>   	    {
> -	      grub_error (GRUB_ERR_BAD_FS, "extent not found");
> -	      return -1;
> +	      err = next(data, &desc, &elemaddr, &elemsize, &key_out);
> +	      if (err < 0)
> +		return -1;
> +	      /* No next item for the inode, we hit the end */
> +	      if (err == 0 || key_out.object_id != ino ||
> +		  key_out.type != GRUB_BTRFS_ITEM_TYPE_EXTENT_ITEM)
> +		      return pos - pos0;
> +
> +	      csize = grub_le_to_cpu64(key_out.offset) - pos;
> +	      buf += csize;
> +	      pos += csize;
> +	      len -= csize;
> +	      continue;
>   	    }
>   	}
>         csize = data->extend - pos;
> 

