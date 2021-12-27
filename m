Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9D47FC64
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Dec 2021 13:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhL0MBO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Dec 2021 07:01:14 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:41507 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhL0MBN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Dec 2021 07:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1640606472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XM+6vw9qmIGSm4MbWS7SnI4j7UqIFdY0yaUB4rhsgNc=;
        b=M3cehssYGgyEBiPdkcT+S0jJ/YkeDwPaCqULCTrTf5WXbweHU/h0J9Yzl6e4ljpdPNjgW/
        Gk1724fOxLOyP8IzVvL4lRY4DcU8SnLzwZQ6TbgARGdlnt9RwMwOGw5IHFtf2q0lFWB42l
        w2s4y/zTbtslgO6tZq2WQQ6sjytKTT4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-oaLV4-CuNwaGJn2je5ouhg-1; Mon, 27 Dec 2021 13:01:10 +0100
X-MC-Unique: oaLV4-CuNwaGJn2je5ouhg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgfdI9vEdscYM6ke4GVJsKpUhDijxzd+AXiEGghVoSiRE2+DP4ab9/ZjQtcaV4EVgut7T2+14yerxlrqGpbyOD6J8zgKe6nsQS3QMyTzFbgPNVEVnfWoHS7fCo7MglvWJ8Jg2YeKZCWYMPObhZNhezX6a9XneXGnQ432r8Mck4CkMWLmyh89/EiuL+eLFsn7VXaf2qttJE3p4ASzufcUGvWh970ACuYwioIHRpottajTAVHjMobH4ZQWjjyqdoGw8vpL2VKovY7qzKAhJff+xg3yrZBu2nID7ZImZjvxo3mx2UObBLEidERJhY1p1MYIID5SpFg+23xKCMEuRSX+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM+6vw9qmIGSm4MbWS7SnI4j7UqIFdY0yaUB4rhsgNc=;
 b=ImChbyzL+GRhx5h888TSTa9elclvtLR4qFXhpD3tL4orrSSfntPbgqosUEMd1xkj2ay0ZlNutWE2TrFo9Epsog2Qu3BqiKJvvUSkDcGkD6yWom623nBhLhNnCzmhnwOy5z4QlmWK+/78a5W0vIxiGXqWCDIS2ohmLlbu4YSaQbKyIqVqKBhA/eqEzi/72iFPg30yuOmSJkI6uy0bzBD9uq2n5W4GOyoUIxTEJydGJuk5aP1vQeT/Q+ttI1RUODvPHjyhgS/FrAR3Y4A0QCOPpiw5R5HhuswL0zFTkCbUaN9kKxQJGRmsBsL31fVvj/hPAo8GFgJBVcxbSLVZqhnyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Mon, 27 Dec
 2021 12:01:09 +0000
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::830:e01a:7a86:6caa]) by PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::830:e01a:7a86:6caa%3]) with mapi id 15.20.4778.016; Mon, 27 Dec 2021
 12:01:09 +0000
Message-ID: <f10847fc-d3c5-0f95-da49-001681f3d19f@suse.com>
Date:   Mon, 27 Dec 2021 20:01:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] btrfs: remove unnecessary parameter type from
 compression_decompress_bio
Content-Language: en-US
To:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <20211227101839.77682-1-l@damenly.su>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20211227101839.77682-1-l@damenly.su>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To PAXPR04MB9423.eurprd04.prod.outlook.com
 (2603:10a6:102:2b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1b1f926-e597-42db-67b3-08d9c93091f0
X-MS-TrafficTypeDiagnostic: PAXPR04MB8814:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB88149FA1951220B6A670E3ABD6429@PAXPR04MB8814.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D//By1Cf3Xo0bm7eRurYfPJS64C17ByzDPlJDF+qiAKcZynK2RtqEJ6XWB6LQUG5fW/IUgILqeZPOiC7KI5DcKuNQqXkdCU5DDTxyZxLPnZ/KQHn04NH0r/TOz4HuCK9NP+SUOffO/9wSNHVJ1+3gl5sZxwiVZ8sVoDGBFrnJxDZk9kPrugaQ+DoQaTrK8AX6383tWtr0vqHnFHB2pqkF0YxWb8UCcPEing+ibAJl1+cGqrWl+4HlUiyYBLX647M5oVlNv454AmyFESPrWo63gUcjWOjNfdRBqA8s8PGfEgx1KDHmv8rdT+hVAWRzjd2zceugyzDNL9E8cLt59y1BmRIBmWmjs3hzkJGQhQ8V5Yx8ZO20zmUMYk8RP+lxPDrFzHcbvVmL5JX3o/gCL4uV/Vdx9UNYkpNsNQKN/aJlK5/Qso9XpFQKbFAatKURY4LMt/Guxd9SPMYQTDssiuvwtHYohO3awTD+08PLP89bIjGYHsbIERL2XF1n4Q2+zAM0NOJvf3IzbjV2lXBeID4KIm8wpX3SySn+PVBtt8dNl3P/TaOypx3L8W6YHz8ZDWsP0Rz0NxzSFS+W72KybsVF6zvl7FQddEwdfiw+Tb2gzxEtIDNtPVlLscZZbjTPJuRRtKKjBeTQWiMwB9ggCMC+pGh/clEQ9cJx5dz99byjzh5TSrSif0D0enly2OvdUUMk6Yba9veQql5vuSjfaVtB7hUFgVbeWq6UuuklRq2RyMRUxhiUEquYCB4SoLxy5jN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9423.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6512007)(6506007)(53546011)(508600001)(38100700002)(6486002)(31686004)(86362001)(83380400001)(8676002)(66946007)(8936002)(186003)(26005)(31696002)(2906002)(36756003)(316002)(66476007)(66556008)(2616005)(6666004)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEViZ1BUK1dLcG1GMDI4aG1yT1RSU0hTdHRIMVIxQVExSTdvdFE5bjI1Nzc0?=
 =?utf-8?B?NEhIYnAzL3RVTVBsWHR5emc4R2dvM25OTk4veUdGWFJTTnV2Q2tGOXZWbTJv?=
 =?utf-8?B?VjdUcStvUm1kTmZwNEp0dVhDWnJJTHBPc3VtUkxIL01Sc1RCSWpPUjFkc3VM?=
 =?utf-8?B?dHhkL09rOHQrQ1E4ejF5U3ZlUHAzVVNvcHFvaXlCaGhTYXp4aVFZazBrc2hl?=
 =?utf-8?B?ZU56V2lmOTNENkJiRHZFcXJrenBjZk1jdTBtS3NpVExqNEZaSVUvY2p2ZTBH?=
 =?utf-8?B?QlNQMVJxZjNHSE1abWlsWWdmb2xYK1FtdlhxYi9pOVJjL1dSa2NpSVhhclc0?=
 =?utf-8?B?VGs5RVpGczhrSHZvSzJzS3hzSU5IaWZDcGdvcWQrcWhyeGpRV1dmV01xWVVr?=
 =?utf-8?B?RTk1bGdXdWRiTGFycmdJa2p6dk1maDU5RjVVNmY5TktVdlBlWWFackFiYUhx?=
 =?utf-8?B?U0d3NWl3WGlEemsyZGUxV3ZpVDV6dEJPeEJKZDRRMWx2NWh5VkJOSmo3NkNM?=
 =?utf-8?B?N21ZcCsxRG1qZkM3SmxCT3BaL0NEdWJ3UzlmYmhmdGVZYkxXSG51M21Ob29D?=
 =?utf-8?B?KzhmRHBsZjdHRUV6bWdRdmtGK3RJNTRMRjA2b3k4d09mdVRJOHBQRlBWdmln?=
 =?utf-8?B?L0wwN2FqMU5ZaWxvdVFCcDQ3QmdTMXJtMVZ4akpJbTcvYW8ycnd3WCtqNGFu?=
 =?utf-8?B?VThVczlHOTJPS3h5UURXK1dWSzlTL0FYckVSdTFZMWxSZ0tGeFBTd0dzQ1RC?=
 =?utf-8?B?b3owcTY0bEF2K2hwTTdScGNTem9HYjFSNFYrVjVvdzVEZ2NKZHAvVTR3Zklq?=
 =?utf-8?B?VElMVy91VXJITEROd2dVTmgyMkFYcmJ5ZUhmZXRsWkVXTFdTd2ZtaWt5ZVpL?=
 =?utf-8?B?Z0xtRXRrNUJWKy9IYUxuMFNodm5sYVN0SXZYMXlDandxZWp5N3NpbFRGZDFj?=
 =?utf-8?B?eU9NNmVRSHVOdjU4ejA1M0t5K2JEcXhtamVHVXFWOVh2K0JNK0lZVHN2di9z?=
 =?utf-8?B?OTg4YWE0SXk1ZHd0NTc1QXQzbHJJUStFT3NaVzlMRE5kKzZFVERuK1JJdkk2?=
 =?utf-8?B?eEVkd1hLSFArbWt1R0dtV05tTzE3NHlmUVl2YW1RTUJLRW43MnNRbjJaNEd5?=
 =?utf-8?B?RjdTazhWdEEzSFVvNTQwRFJqcGhUaWxUNHFIVHVkOEpJamoybGZDeE40b3FW?=
 =?utf-8?B?MGNHMjVlVzJqdGNiRlJKZlA4T1hLb0hVVEZlR1hkSExhcW5pNjViYkFKNG9p?=
 =?utf-8?B?S21FVE1PNStqM2hDM1h4Wml6WCtHWEl0aGJlZkxiNzdVdGhRVHpQc25xRTJW?=
 =?utf-8?B?dER5VFFJQWdxMjRyWWF5dTRaOTdxbnB0SCtXK0djei9qYTEzQlRVWGlsNDgz?=
 =?utf-8?B?UGh5dFVUT3hkSXcrTDEzZGZWK2lsc0FXODhlUlVoenJnY2c1MUlrUzJHb0x3?=
 =?utf-8?B?NC96WENCRkRnd0EzaU1jSnIyenYvcWJDbU1yUnJRdkE1RVpaTHN2WndtT3Ur?=
 =?utf-8?B?VW1uTkxEMC81Z0dsV0VFdFo3TE9CRzJKQ24wQittUm42alVJTWVWVm94T2No?=
 =?utf-8?B?M2t2STE4UVVCNXJKdjhEcllnNklkb0pyZmcxazJsR09WTllUZDhvSDNzcysr?=
 =?utf-8?B?aFF3V1J0YnVIdDQ5NVp0UnFONUJXUlh2VkRvRks5dHJNOTZTTnVwU3gvSTdK?=
 =?utf-8?B?OWMrTWhYelNRRFFaTTN6YXBQMlFla3ZSZkVqNHBzWFFlU3o3OG5xd0JOOGho?=
 =?utf-8?B?d09RbTFXRVRzM2VOS2lLWWxGS08wRHVLd29PdnhveXFVVW1OT0dMSWErdmlL?=
 =?utf-8?B?bVhEeFpKbGJuWjFrZlUvQUhOaTRkYTJhS2hIQnFPYm9TZEd6SEo3UERNWStp?=
 =?utf-8?B?dkZyMkRmSFpHVUNOdFNqdjZSNUpESEFlVlNrNGJYYUhkQlNCN0FhVTRZK0Jw?=
 =?utf-8?B?VDFSKzJaRTRWa3NuMkI4bmJTR1RSRlM2WTRFUm1BQU9WVURvYkVuTnMxWW95?=
 =?utf-8?B?cWhEbW56TTdnK1hURHk5Mng5a09sZXFCa1VlY2lXa0E1bG9vdDhkeHJhcWxa?=
 =?utf-8?B?Sjd2Z01abUF3MFU5cEQwTzd0blV2NlM3OVlWQXNCcEw3Uy9DVzVvV0daQ2ND?=
 =?utf-8?Q?uU6M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b1f926-e597-42db-67b3-08d9c93091f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9423.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 12:01:09.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J0tEgxw7ptjVquU+P0JEaPBRpU5GdlNnN7qjp7RUAyUMdTUhMx8T7FTPz7lzX/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/27 18:18, Su Yue wrote:
> btrfs_decompress_bio, the only caller of compression_decompress_bio gets
> type from @cb and passes it to compression_decompress_bio.
> However, compression_decompress_bio can get compression type directly
> from @cb.
> 
> So remove the parameter and access it through @cb.
> No functional change.
> 
> Signed-off-by: Su Yue <l@damenly.su>

Reviewed-by: Qu Wenruo <wqu@suse.com>

And since it's decompression time, cb->compress_type should have already 
been initialized.

Thanks,
Qu
> ---
>   fs/btrfs/compression.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 32da97c3c19d..f941b7ed23f5 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -96,10 +96,10 @@ static int compression_compress_pages(int type, struct list_head *ws,
>   	}
>   }
>   
> -static int compression_decompress_bio(int type, struct list_head *ws,
> -		struct compressed_bio *cb)
> +static int compression_decompress_bio(struct list_head *ws,
> +				      struct compressed_bio *cb)
>   {
> -	switch (type) {
> +	switch (cb->compress_type) {
>   	case BTRFS_COMPRESS_ZLIB: return zlib_decompress_bio(ws, cb);
>   	case BTRFS_COMPRESS_LZO:  return lzo_decompress_bio(ws, cb);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_decompress_bio(ws, cb);
> @@ -1359,7 +1359,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
>   	int type = cb->compress_type;
>   
>   	workspace = get_workspace(type, 0);
> -	ret = compression_decompress_bio(type, workspace, cb);
> +	ret = compression_decompress_bio(workspace, cb);
>   	put_workspace(type, workspace);
>   
>   	return ret;

