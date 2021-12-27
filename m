Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4212147FC4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Dec 2021 12:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhL0LtS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Dec 2021 06:49:18 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:37802 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236492AbhL0LtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Dec 2021 06:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1640605755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W//EnDTeNz1kbNUTkiwYe/SspeFrNirzlGl4RnFR/Eg=;
        b=T/aSeVcl3kiJ4JKtBeoo6PLD8jbfazuDcuWzKAcH2HTGgOmf4KA+QKoTyH7jHRiDnQdRG3
        EW7VEf2gi3s7RT0E9VjvhG/P7kAFdVBwAWrpx+GU7ykovh5Vhkyh7LoRa6gpN5rmp0PJO6
        Ae+55HnO+18HLeB6c6kSvFYGk0otER8=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-PeVBrM7gPMSFMAMTtBSUWw-1; Mon, 27 Dec 2021 12:49:14 +0100
X-MC-Unique: PeVBrM7gPMSFMAMTtBSUWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHRC6ay+iNxNk7+v0sDHjf8wYFhYivh9U0lUBsDMprzDGLl3pWMI8ACqG83xiByVwR7Bgkwmvfw288MlxOaSbTrq/tyLON/8+kafxzeKS8TCaotT5uJAL/gUYjB1vw6xDW7hc8tgjcazNTUaWTAYwhSDO4d13K9VAp6gs/Kl0XaQ26s2LzqclKnZnCFxGSsyWS+JVvRFAANSnU0yPgNK65qQA96JakPNlX8w0PFsVsTyawWRl14WtCNuYlShQoY80biAoqWytNZc8qZ0prXi0pQJpq9RrOOL190CwXjODq7VO8fE7SxjQGPmBvKFvxgekfKycV3ofKRxuX0ZI9F8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W//EnDTeNz1kbNUTkiwYe/SspeFrNirzlGl4RnFR/Eg=;
 b=Qx/Aq9SSwWUBp4/pU+wG12EhJeVrgNcrxyEKFA0HYIh16Cx1FQ5yFvX0nINQvo7+R0Uc7VsLIqKkjrfNrtTyRpFF11oqilB+4zeukDrn9efCdkF/58DJjKn1JUbw9qfVGtA3HvGLfHI2Uhhp+Zehaf2jRvA8SeYdEnIe1BoL0u/uAIednsSmTAVUguGKVoRtg/JPi+x9v3fN2Gk5LWwk8tov2fftaMWAYI7vy2fuHRyVtxphqfSp/JLn6zWXxapnDv1PAOyQEeFTAq8SVZj7f8bacJ3w9OrHYrAE/uPxPxzjdtuTUwpx9C2KDDCgpWBF8uGe6bViS+D6YpvuylEhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7)
 by PA4PR04MB9270.eurprd04.prod.outlook.com (2603:10a6:102:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 27 Dec
 2021 11:49:13 +0000
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::830:e01a:7a86:6caa]) by PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::830:e01a:7a86:6caa%3]) with mapi id 15.20.4778.016; Mon, 27 Dec 2021
 11:49:12 +0000
Message-ID: <7a37b841-3b82-ce8d-0459-ebaea539fc89@suse.com>
Date:   Mon, 27 Dec 2021 19:49:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20211227113435.88262-1-jiapeng.chong@linux.alibaba.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: Use min() instead of doing it manually
In-Reply-To: <20211227113435.88262-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::23) To PAXPR04MB9423.eurprd04.prod.outlook.com
 (2603:10a6:102:2b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 401a3f60-404b-4359-9fe5-08d9c92ee6a8
X-MS-TrafficTypeDiagnostic: PA4PR04MB9270:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <PA4PR04MB9270D1C79147BE5B553AD363D6429@PA4PR04MB9270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GF598qCJPJPpAw7c6EKEOar0O1T3CIpwe/NfuWr7cjvMhAx6901pUqNm5sf6ZDbumDX/26ILjHkokf9mF0rt8sCsXhi8VV5Avq8ZvHEWEdNout+bt/63VES31WMDEDyivTRDgEsB4vZmliDLTTulxaPeImv1dVDlDB/OrnHgOMpbfneMdEAkmUdPL/y2Fqh633jXffhTKPtqw1MW6YeedLEp/GQPfwqFIuHfeOO0VNLhygMSGi2sni6onpJvz+lTj06jWWAsO5lWRLMaeqCHD78IZk6cb9SP+cxIYCQkv8htYXlF0vRMV+hgxfX5AiFTzjclTZ78FPu4DCDoqgtWwgFAQz5lOkypAXRoZ0JydPqfhA79+9L7umgUEP68yoWq7bLvv/szd8W09Sr7jY7iV9zxQ3tc6/UaakqVEF91SDh/PVHIsx2Q3fSk2Xc4bGqT4BbtKQBQEbbcnRqdp0MO0rnXmbVuom8gK7ryYiYP7/CtuX1Bp2pzB1zI7tXfjG1CfQoZXYLaEsHvCfw6wdcmNHCdla+sk/SQ4wqutLUed480lc/QRT2aHVgr9zdagNmdMTnkuDF4u0AODZEM887mkKZWLJ2N+mf+a1gVOumVVYF7i164tz6qCAjBeU/rHFn7+LVmX85MT9Wh9VUCzRAcZrVCfg7WFYzMu5iXFP5EySern0rvxw4vQwo9WWlQng2xasQKkWfF9t+GBgtFItQAaeH6WLBK31Bbo5/z1voHMZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9423.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(36756003)(2906002)(8936002)(2616005)(66556008)(83380400001)(31686004)(508600001)(6506007)(5660300002)(53546011)(316002)(6486002)(8676002)(31696002)(6666004)(86362001)(4326008)(26005)(38100700002)(6512007)(186003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhacVB3SUhWUEhpUmxWM1BmQ25DVE5pVzQ1SFVwV2FYT01KWFBuSDY5ZVNR?=
 =?utf-8?B?RTN0NkRxcysyd2dNd2J4QjFhZjV1V3JTSEZxeXVrMGhGK21rNno3elkvZ0lG?=
 =?utf-8?B?LytIZFI5TG9mVi92K08vcFZUUHBqRm1aVmxCbElhWjJBZHN1NU52ZmF6Y0RY?=
 =?utf-8?B?cDNUYWxyd0V3Tmd1QklzUkNuYVhaV3BuZWplZklQVUJZc05ZTEkzbkVsNGJJ?=
 =?utf-8?B?R0pRK3YwZ2hKSzZEK0R5dmt5VzRjV09MR1VlYjFVcEJjZ2YvTWRyVHVWOStm?=
 =?utf-8?B?eHZoaW4vYUpUaFQzT1V0M24rN3pRcTZ0dnZrK0pPbzRDbm1mRWJ6UFJLNTFU?=
 =?utf-8?B?ZU9qSWtSckhqR3dsN1Y5REhQVHYrNDJZTXpKejY5elBIR0pFVzUzYzJQbk9J?=
 =?utf-8?B?U1Jnb1lZT2VoK25KbllFSHFZT0FVVGhXckVJMXhnK0NQV3c4N2xVem5DcFdi?=
 =?utf-8?B?b2VjdHdXSzJVZHV0b1N6TFB1RTFiU1RBdVk5SXhGLys0N2cwOVAzVVlFRGUr?=
 =?utf-8?B?MWk0alVBL0JUc2Z3bG1EY21uRkJ5OFdxZEgvdFh1T2JrenVBRCtJRFRrZ3ZL?=
 =?utf-8?B?QytJR0FkNlZTd1l4QjFRNWh6dXJHeTBkWFpiMUpCazBjL0ltQUR4OEc3eGxy?=
 =?utf-8?B?YThTMS9ra2VJSW01NytlTHYrT3liWjI1NWF2KzhrOWFiK2dXZVp4aUEwY3lo?=
 =?utf-8?B?bzE5UTcrYzc5cy9JV3JYZVVuSmcyYVpza3hXVHgvRzdpSGwybERVN2U0SWsz?=
 =?utf-8?B?SmNIYXlxNUNFUVVWSHB6Z3VyVHFQNHZjSWpBUTVKZjBROWxIMlNQc0hxQTRF?=
 =?utf-8?B?WnlaRDJTaGNQU1hTQ1I0bkE4WlZhKzd4RW5TQW1KYktYdWRpY0FBcTlwSHE4?=
 =?utf-8?B?M3cyVWhyOHdMdUNGMWEwbzdyaWZvZDgvSHVmZWk5Wld1eUlGazlBVDMvdlQ2?=
 =?utf-8?B?dUl0VGk4dEUvUXNYOTdlYVFFU2JDSGNkMzFYbHQwVGVFaGs1UGk3TkRSTFVJ?=
 =?utf-8?B?VWdENjJiRDFpSmUvWEpQMmF5MmU0MlF0Qlg4OTh2RkIva280VXk5VWU1Qk9B?=
 =?utf-8?B?NERQZ2dlMGJ0UFhPN1R4cnJIcmVIczNZVVF3OHBkZnF6bm5BbitlMzUzWlRr?=
 =?utf-8?B?cngzTVhiTTRYWFM4T0s5YTJtMVNCNnhZU2dpMXllcGNGSzFRb1pnRWIxTEo0?=
 =?utf-8?B?UW1LNDR5eHNObndsamRvZzFmaHFHRkdyL0JOMHg4d3BOVUo0dGt3VmV5R0J4?=
 =?utf-8?B?aWhyaGRvV2xDUHpWMndBNXBGaTN0ZkRqS3hrcGUxSjZsYzUrU2M2UEd5elhr?=
 =?utf-8?B?OTBlNEk4UW5LSzNibXJQN2g5R0RQVEFOSnhvakRnNjEwMUQveXhPMUFlOTVp?=
 =?utf-8?B?VHU4akorQk9YdDBnRmJyMkttZzJCNEtiZlNnRFhSNjk4QndKbHFtTGFnUkJT?=
 =?utf-8?B?MXVUMytrdms3bjlFczhNV1licXVaSHNTZElSQ1dUczFwR0piazBObmQwZ0h4?=
 =?utf-8?B?VndXQnFMMStJVkV4aDkyS1JpWVlXKzFFbll0aVF4OFZpWWZlQ1pxdWJvZW5j?=
 =?utf-8?B?Wng2MHFyNk90RU5yalJYQXB0Q3ZUcnpUM0MwSHF0TEN5R1pLckZTVWtEd1hE?=
 =?utf-8?B?Uk16YTIyUTh3ZkxIdml3aGR2blZ5UFloTnlLVGMwZkpKZE1XdVNqcFhnTkpm?=
 =?utf-8?B?ZWpqcVBVZEJhWGRrUmVqZ3F0NTFEd2d6UXhsY2Nnakh2ZHZ5c0RKbzltdktE?=
 =?utf-8?B?cXBadjNUMU0vTHFMN05MdXJVMkcyRHFxdlJxS21wdk1Pd0daNGxIbkdmZWZZ?=
 =?utf-8?B?L0d2dkpycFFURnpaNE8xMWJlSTJ1d0t0bEpSSi9ZWGs1aTFRdHVNelRhM1hw?=
 =?utf-8?B?clo1UFd2VGxKVTJFTi96NGMxT3FIdjBWUWRsbzNBU3IxcERqcDVwNDRkSmpw?=
 =?utf-8?B?Z2IwRzAxWVAxdVIrSFYyVUtFQkNRRE01VjdKZ2ZsV0hJbWtGeU80RENTaUx6?=
 =?utf-8?B?MHBxTFBKMW8yaytWQnpxcyt4ZS9OZmF2SzBjNURHa3plaURGdzNsZlF5Wjlq?=
 =?utf-8?B?Q3IxOXpwd0VManpiQWtIQUlmcVVMQVJVVkFSbm8vVElsaHQrMUErVHFQZTdT?=
 =?utf-8?Q?tnug=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a3f60-404b-4359-9fe5-08d9c92ee6a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9423.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 11:49:12.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKf3sUKuEk0z+w7MpQpavrhXcryCw1zfFbC2knJtBK2WP4LaKyOXz/4YIINi2PmX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9270
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/27 19:34, Jiapeng Chong wrote:
> Eliminate following coccicheck warning:
> 
> ./fs/btrfs/volumes.c:7768:13-14: WARNING opportunity for min().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 730355b55b42..dca3f0cedff9 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7765,7 +7765,7 @@ static int btrfs_device_init_dev_stats(struct btrfs_device *device,
>   			btrfs_dev_stat_set(device, i, 0);
>   		device->dev_stats_valid = 1;
>   		btrfs_release_path(path);
> -		return ret < 0 ? ret : 0;
> +		return min(ret, 0);

Nope, please don't blindly follow whatever the static checker reports, 
but spend sometime on the code.

In this particular case, min(ret, 0) is not really making the code any 
easier to read.

The "if (ret)" branch means, either we got a critical error (ret < 0) or 
we didn't find the dev status item

For no dev status item case, it's no big deal and we can continue 
returning 0. For fatal error case, it mostly means the device tree is 
corrupted, and we return @ret directly.

Are you really thinking we're calculating a minimal value between 0 and ret?


And I have already stated that, there is no need to CC maintainers.
Especially you didn't even bother to check who is the one pushing the 
code to Linus.

Thanks,
Qu
>   	}
>   	slot = path->slots[0];
>   	eb = path->nodes[0];

