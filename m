Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D558C422285
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhJEJnP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 05:43:15 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:47558 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232658AbhJEJnP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Oct 2021 05:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1633426883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0TUxsv2aMwocV9uAdGCL81ymUictQ1/X2DguC5z0YQ=;
        b=a+0pdK2HFuL/eYGrqd2TeMiZs44EmOwXoM6k70RiEE+GKSV/imBisn3qxm7rVENLtJIp0O
        S0JZdqz7mOqXYMeBp7Iw16e4BkOmlOv5v2wLKOoXXkbBdp8RLiGChAxvb/ki2ZyZ+ZDPNC
        IExb95H22PnvCTXEtAp35d4UaWoPE5s=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-37--7vnaWWUNCqBn3G-A9IL1Q-2; Tue, 05 Oct 2021 11:41:22 +0200
X-MC-Unique: -7vnaWWUNCqBn3G-A9IL1Q-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoUsVOurNo0T0BnAmQyC/j19mvrUdwed4fmHwbrJ9axgimwkjpY+5YNXQ1XxPYzLMFtVvMHgyrxR6+7IM2SgOjYBKAseINvt+l+T08dgFIbhYL0ZekAQ1c1OFJyr1IHChcEeyRwDwOwQf3blKspGe/XI1VEWLb9A7WXbmL7mr0xl95zJ2QYvuMWyxIr/pnQuS6P0DHS5dQS+8yL5T7eU9SrJ+SoNvwjSnqJSz6jcmFvCnQ6j6kkujyMRuymsPxbtDLiE+y/hoMQXFFeiZd2jPAsfkTWPwawPF+l/rZZBA6zId/ojojZEq1o6f6tR2NVp/gaRZf5Et+KNSOg21+AWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0TUxsv2aMwocV9uAdGCL81ymUictQ1/X2DguC5z0YQ=;
 b=Fa+xp5G/evIiVZK7vTFXjCwvTP3RqoeZx0bUde9e4HeYoQcVDYgwEmtat4OJXKoVsBCSRUeBessPxMpsuTHElS67G/nnww4kW3M+j5beRaj04gG0Jng9brCaksmUuYgIvPPlwJJrLaZKE1wCQXtbz3t/+wYJYmMkPIm+4b4Iny3DDzNp76DIMWbxQyPYO+fdrJL4jbr0QmxE/+8k9nDRio5fAAnbV9LeeScgajaorMS2VYhfg95x00Trw13aOrMLhAmJ1EyAO97HnatNVLb4yWYaZm3WmJAT+3oL5KaDL59cCKg3dJPVl3+54V5cxbdDVEP1+yHRjMcPpjO+KTYlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3155.eurprd04.prod.outlook.com (2603:10a6:206:4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 09:41:19 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 09:41:19 +0000
Message-ID: <2011fda4-281a-b735-4af0-9f2baee5921d@suse.com>
Date:   Tue, 5 Oct 2021 17:41:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH -next] btrfs: lzo: Mask instead of divide to fix 32-bit
 build
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        noreply@ellerman.id.au
References: <20211005093406.1241222-1-geert@linux-m68k.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20211005093406.1241222-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR02CA0024.namprd02.prod.outlook.com (2603:10b6:a02:ee::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 09:41:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b8f16c3-cb57-4ca0-5359-08d987e448b1
X-MS-TrafficTypeDiagnostic: AM5PR04MB3155:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR04MB3155DEFD08B960CDBC7BDAEBD6AF9@AM5PR04MB3155.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCB+Vo+TyZKVLXYwevXwUXopUaFQdp0MLxGry2vEG+MK8vscU5FYELnWKjkavJszQFybFjw2qGHYCj7RHdGip8GUfiuXMJqxgB8X+/JXEF7lenqAITCAoAnSdRAzupho0zhiRx2UMkRqmqpvoOSO9dMEqS0W4t3OvW67rr7TORlcmtdneGljrJC4j79gayEC/FAUew/iYHjaiV0gpLVIP2PAJhbNrkbEmEWbKmb1JJYBok1KtW3MqkEjTX5oFDuxP6HprrfXju1EfO6s20KSSiNFLMPoYBlqbmUJPGoEjupRr5+bbZv4pj++BpnoNREgfeivlru6LWiQdlEjds27VRqpPOsRKNbAsWI1JlMCg0Vq2CFbcVuLZUG1cU9iTI/3ZvqNDRIZDy6HqrZwpXhAALZvwCU2AbXkMeB+ZzTHp4jWmKUcEZFXVymah+0jlIapIo2pD838tjLl5IWpz2NekTYzUKvXm1NAd4hpLeVGM7suhFDEJ7646FRe7RXTjKDjv/ck9Q9AysBXbJ0X5p1FXnVeGDKxIqp4v5y/mZBL2rJAQ9A6FlFVqpbVebZqqTqWorocrbrG5pbBYagED56G7f6qnFDNvidCCSPXw8k4Z+4RmPx/++HWAkmzE5V101JZKCeORuVgmU3LTQOwWVsxCft2pD7BByjHxCd6Dq5xZS6xUVzwLBH2rX/MoIvPNugRJxoH5Ui0w9+YVzYzCkw6Irijx92BpFnyBaHYBpeE2MkrhOsucmzLtiTiD0Y0VcVn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(36756003)(186003)(956004)(5660300002)(6706004)(83380400001)(31696002)(6666004)(53546011)(16576012)(2616005)(2906002)(31686004)(316002)(110136005)(86362001)(8676002)(38100700002)(4326008)(66556008)(6486002)(66946007)(6636002)(8936002)(26005)(66476007)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTgveDhnQmFzWWxRQXc1Z1FSajJkVndMSFg3Nkp5QS9nc00xVmI1WEM3OHMz?=
 =?utf-8?B?V0J6VlRzQkRTZmxwRGtnUlpSZUV2ZTM3ZDdQdmV3WWk0d0wzNkZZZEdjanE2?=
 =?utf-8?B?bTRrcFR6ZEMyYW83ZXNJRmo1K0pwSzBKTzh3cmQzTHV0ajlSMmR1KzJoNUYz?=
 =?utf-8?B?Z0NWVVdGZFB0enh2NHNKVU5NSGNSd2ZsRHc2Sm1ieTlkOUNrSnIxV3g5a1ZI?=
 =?utf-8?B?S1lINTZ5ZW4yN0s0R0FNaitwcG9zQlF1c0Z1OGZyR1owZ0VyRFBZOWhHOUIr?=
 =?utf-8?B?d1BnUXJsNTUzMmhES3k3UDc2UmgzUDRwdFdlbkFBeWxEUWxBYUxLSTlReHZD?=
 =?utf-8?B?d0lJT0pxMXV5MFk5QnVJMko4SnRMbEEwSDFDeUo4WWlRcnV4dzRIYi9ZQXFN?=
 =?utf-8?B?SVRIQVZoUEU4TnhSWXZTWkQwM3FmNXhBV24zdzNGdms1Y2tTelBrM2VKK0wz?=
 =?utf-8?B?ZzlrMkZPSGhpZHhCamJtb1FnbHJaTG5rWGR2eEdPZWtvSEh3M2xOemQ2NTFL?=
 =?utf-8?B?Ky9ZNWRvT04wYnR5d2pKN1BoaTRESytQM0pHQzgxTFR5V0dvaU9BaEFRYkNG?=
 =?utf-8?B?dlFtMXBIQWk2R2V0Ymo1Y2Ivck1yN2IwMjhXaXpNelB1bmhFTFdyU0RxRGF2?=
 =?utf-8?B?K2pPRE5DQ1pTMk1LUEVhelRTNkVKUlpmVGMzVUJucUxTaGVYOEV0Ulg0SDZF?=
 =?utf-8?B?UjVzaTFabDczQWpLc2laVkZQSU5HTW14bm5NN3RZdFhTNXpkb3JXcm9nN0o5?=
 =?utf-8?B?M0I3dmIyWVpiMnVMNWd4NGdYbnBsalVrVk9hKzRvSW92WHBVMlc2aGlqdnpp?=
 =?utf-8?B?ZFJ5MFRTSmQrNjMwTDdEa01vS1dYaCsxdXQ4ejUzRjNoQ3hoa2ZUOUFVaEVC?=
 =?utf-8?B?SkJlSFQvckdSbE1vOUxtdW9FQUtvR0c3ek9tNVo2REFKMWpIbmxYT012YmpY?=
 =?utf-8?B?TVo3a0xPeEExMVA3WTNMVit5UnVybmpEUUdnVC9PNVBoUUxuMmg5ZzVwZjBh?=
 =?utf-8?B?MWE5b3A0MDdhTm9SVU9TR1gwanBPTTV3UkNwWVhQc0lyaVFpNWNpS2VaeXRp?=
 =?utf-8?B?amJvOVR1OFZnNzJjNFR6a1JyMFFwZ3IxTk9GVGZicW1oNGZuMm5NeUxkR0FC?=
 =?utf-8?B?bFd6d3AwVXM1RFczak04cjZQTjdzMkE0NDZwMkY1d1p4QXJubkNuQTV3ZnBM?=
 =?utf-8?B?SUROaTlJR05lN2g5THZmSHhkOVNSaENLZW0vaVM1TXFhR3lVaFpJV2tlM0dJ?=
 =?utf-8?B?QUJuTHNIYTVDNUs1MEF3SDNyTTBITHZLNGxNV2MvS290MlBXMnFZRDFxRWF3?=
 =?utf-8?B?SUV3UXo3M2NweUUyZG4vdGRSUXRRN0ZpMTF1QXB0MHdSd3NsZG1yVnZ6Rlpr?=
 =?utf-8?B?bHRkNnZ1eEpUTkR5L0E1MVozVnE4aXV3eUFhWDBHeGs1MTV3RlR6dGRISjhG?=
 =?utf-8?B?NXhUaUx5VGd0SHdlKzgyVHVWVlZkZkcveUd6OFA3WHp0NDJRS1JzOTQreHdH?=
 =?utf-8?B?L3h6MXd0WEF0TE1wcWhIRzhKOXQwVmRGTjhoaFFNRTc1NVY1QStEa2lGaUlK?=
 =?utf-8?B?WGQ1UmhIWlFtNVRtaUl4TC9VN2V3VXNhclB5S2QxclB0cDdZZzlwb1JmMy9L?=
 =?utf-8?B?YXViVWg4YXMxR2JiNTgyMW5VNytDa2hRRGZVVzJSTTZZQ0tWK3FxWTEwUlAw?=
 =?utf-8?B?SU9NUkFTRkJRU25qTVIyMVpuMTk2RFBTYllDZFJKVnFTRWlwczQxdENhMm9G?=
 =?utf-8?Q?6QgLkhjfqfhhAQ04lwPaxv5E9OPFtIz6MVoONuD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8f16c3-cb57-4ca0-5359-08d987e448b1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 09:41:19.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e97VtgMpNYTYgyLf3+zd7VYwHTjaaRj9vcyrH1MfzXTMp/o9XwCGD8h2WYB/+ynS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3155
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/5 17:34, Geert Uytterhoeven wrote:
> On 32-bit builds (e.g. m68k):
> 
>      ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!
> 
> "cur_in - start" is 64-bit, while sectorsize is u32.
> 
> As sectorsize is always a power of two, the 64-by-32 modulo operation
> can be replaced by a much cheaper bitwise AND with "sectorsize - 1".
> 
> Fixes: 0078783c7089fc83 ("btrfs: rework lzo_compress_pages() to make it subpage compatible")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Oh, thanks for catching this.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> Compile-tested only.
> ---
>   fs/btrfs/lzo.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index 47003cec4046f13e..d08f9eba49dab3cd 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -211,7 +211,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	 */
>   	cur_out += LZO_LEN;
>   	while (cur_in < start + len) {
> -		u32 sector_off = (cur_in - start) % sectorsize;
> +		u32 sector_off = (cur_in - start) & (sectorsize - 1);
>   		u32 in_len;
>   		size_t out_len;
>   
> 

