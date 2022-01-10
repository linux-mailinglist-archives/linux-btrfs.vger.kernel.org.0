Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E0488D83
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 01:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiAJAny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jan 2022 19:43:54 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:28761 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236630AbiAJAny (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Jan 2022 19:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641775432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FCfFp+HlPQ3P9gkbKz3symtnom6a79u8LLGZ3/RXi8=;
        b=nhatEIIShgEOFHFq2+S51UfM9nrqY1uAAZmI1EdmlYnRSijuR0FsqeHlEAfZm0RDjZvpeW
        36ZWNxrYk/BK2DKxsAADj8nZ6mOQezRM3wffcTBDqu1tb2GZZBwXiuSFNLpcD9lsJsNcaQ
        7Qj340eBoyfov6cY5GWs7sYJaK472yQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-pSjDsPTaP7ShDXC98SUMfA-1; Mon, 10 Jan 2022 01:43:51 +0100
X-MC-Unique: pSjDsPTaP7ShDXC98SUMfA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNEwcJVNfvw29v8XbdFPIIWm38IldKx+XSBDId8cbcJ6u2bAmeOm/H+VbPXeRbIxBFmNN1lUfiZgBbF0nAP101eVhpxVarhMLhDG/rWngtJNJbIfEwUE7+qC6t6fEwcZY2qIXe6vZuZAh0tJz9LzI+oHozczqIEiEM8nvHT9BtrgXXmadNXKXBx1zskAEwLTQJwSfRCqoFJFFT9+KbNBykfdreWWBISfibz9m1g2AoNVrrRlloX+Be8oBBilUfjCUDwpr6c//EHy8wG7UI5I9XocPfLVftM9DjkShGv5tjTCc6bQo26W69xsCCuRYBS1wxqMv9tS4QAHygTBfWIsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FCfFp+HlPQ3P9gkbKz3symtnom6a79u8LLGZ3/RXi8=;
 b=X+4hltTaFRx3QAOb1oUUqBlALXwLFzDz6NAJ7KxBtNnV9KnFUcfHS7VE44/bfvKlUBsTTU83dSzMCJoXdjNAzLHbtZT7jugJTavgWZB8fKTqIbhrdtLaZtpIG/RqT13RA/nnvWZDae5xdW2wp4Jw4BOhM8Kx/7VbZB00qqqWAO+N+eRixXt8G/0RHS5JiBWWzGAJKRlWn5cYZp8K/z2DpyzrGg7IKfG9vFxC5ydDrBN4QfxAOfcg0MEY2L8VdKt35/QYdut3WaPVw/f5da0Snp3bU5JQgSgX/DKefbsoTcWrkOpPBw6+JygeMRLw0p9QxAY0nmsd304Kl3klakYnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 00:43:49 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%6]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 00:43:48 +0000
Message-ID: <648c33f5-5dbe-db8a-ed55-6c5d134b3677@suse.com>
Date:   Mon, 10 Jan 2022 08:43:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/2] btrfs: expand subpage support to any PAGE_SIZE > 4K
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20220105022812.45698-1-wqu@suse.com>
 <20220105022812.45698-3-wqu@suse.com>
In-Reply-To: <20220105022812.45698-3-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa0161d9-ba6b-4828-a710-08d9d3d24392
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB877437703D86C79755890A80D6509@DU2PR04MB8774.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMOGDjESO9dmj/AXx0R+fmVBsfKnsLCWhxfQ4oo1td+L9lK65lD3wwP67gzW5YbT6RtwheeXSwMMZ/OCcBdLVMoXs/6hrSrg8t7um5iV79TwguNnnV21THuKT+WJ0ztrJWkt3M+MXnu9DOfCGlsfTnB/bg14iLYKilf4HXebujJinRL34X4juD9rOCcbB6IJmQAkgG2St8Rkx5iB+a37N8EiYdT4lB1WA3P2xlK7V1HXxVlB+DLlumFc2tJZW/z9RssQX5+ncNcWJzCGbL7NEGoKkP/rxD1yDCTYpWlPvU2BPDK6VFEMX7lNDEFLbYRo1hezqHE5zGK+n8gkji490ApJ3d7Us7VkmfHwAsr4vY+VjMCLJkUycD4+KKPMw28gKIEn+/KoTMRE0FNdv+pH89TLwwW62VejFG8cShd816wFEzREd4iRGc6ZQM1hV3thtGBtOz2tBBX7e7IyFyrNO4H2XGpZ4C08TAwsMrN0HIomiVcBVZc0v0ybKZ2PXrT+6CjHkJf3tmda0u1m41EWn5IY02r/CQQYg83o7MU1Hvc6GQE1pc5O7B7bqAaBmh0ddTM4O1a6jqe9RfoLAH3E8pfSLPwwqve7NIZxFfJmb98VOu07gsml2TI22Ws4mfUAX2F29q98sb4KL8vRSRst5S6h4X+DqvDoCIzidZJQpV7Y7me7FIYHcafa6V+H4wDCJf4TD0FqO+ClzVp5feUxtkD3hIDVQyOg6tBVqyTv+bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2616005)(31686004)(6486002)(31696002)(186003)(6666004)(8676002)(316002)(508600001)(66946007)(66556008)(66476007)(26005)(2906002)(53546011)(6506007)(38100700002)(6916009)(36756003)(83380400001)(8936002)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUQzejV0Vk9KaVFQblRSUzFxRjlxQWJSYnBrSHBQaStaV1FGNTlJYSszc1BZ?=
 =?utf-8?B?TTNicDNmTlUxNUl5ZE5tQ0Q5MUZPRS9xWHJHTnIzbHM1RTJzb1RXUmlLY0o2?=
 =?utf-8?B?NWtJT1lxMW1kbWdCS2J1aEJtSWdnd0h4TjBrQUE3cGNHdjdVT0hiV0l5dlVh?=
 =?utf-8?B?OEVCeGxqeFphdFZranpHQ0xHRkxnNkdHQjVxWHQ1bmFVWFpNb0pTSHBJMm1u?=
 =?utf-8?B?dWtGZ2ltWGxndUFtdkZHLzFwZ05WNVl6b0xkd21vUENLR2lQVVVub3djaUtO?=
 =?utf-8?B?VGF2UUs0eWtic0F5V3VhTkVPWnVUeUhxM3lxL1RXVUtLcmxHbzBmcXNLa1dm?=
 =?utf-8?B?OHBBYmdheDF0aVBNMmYzcFhETUh4RWVCLytaNnc0RXhSZmtsWTJOTVZtR1JY?=
 =?utf-8?B?WVZvNHMyMlJjYitrU00rT0FmK1Q3U3kyQUVnakhJZkxYL1hHK01sRzN3bktY?=
 =?utf-8?B?aWNZZVJqamVPRlVLR3lqVElYaHhibEtmdmpaamlhN3Z1NjNtYURiaEc0U0hJ?=
 =?utf-8?B?Y3FFeUVURjN5c0dsS1Z6N3J1cXlmRFV4WmFlZ2o3K2dKYWRZN1hYUDBmSGVG?=
 =?utf-8?B?YTUxNW16Qk1wZEw3V2haUFRqYW5hS3JQNmc4SDdnOGtDWUhMRGZUa2dMVm8x?=
 =?utf-8?B?MHk0MWl1MXpCdUlyN1kwWEpUa1ZwM012YWNITXlNNXMwS0JKTE5GSUtkVEoz?=
 =?utf-8?B?dkN2Tng0ZTM5SHJNMUsvOTl5Qzk0SHBVQXRseHFkWDRXRTdraW9xSGZVYzlp?=
 =?utf-8?B?aGRCYW1nRkYyaHZENmVEWS9oRjVWQy9wL3ZMeEVmaWVseDVXWFVJUDJvT3gv?=
 =?utf-8?B?SEJySngySDhOdVNqeFd1NEZIb2pjRGduTjNmR1lyMGg3R3Y1Ukd3cHlkTnFn?=
 =?utf-8?B?Ui9rMXFTVkxweUNXTHVHWU1UNStvMkd5c002SnhBdlRVV2l2a0VBd2RoZlBT?=
 =?utf-8?B?WDNDSGZDMUNHd2JLZmNrTEptOWg4N0pHZmVKTElnRE5vK2lTeVZ6bFhxa1BS?=
 =?utf-8?B?cmlRQ1dhMXc3cUZHVkZoZmxDSnJUb20xSW05K0JzbVRweThzRnVTeit2MHNj?=
 =?utf-8?B?MWg2YkpVQWhjcVRiYldQUnUvTkdXVEdXbWdoQnhoRDR0Y1AwamN6WUhRTGhD?=
 =?utf-8?B?blRTQ254SXJnbGVPRTNIV2ZTWWsxT1VFZkVHZlJsS1hMZmcwTVhzeE51dFZj?=
 =?utf-8?B?UHd0WENTeTlROTRCZExwYlJxSVhzSVA0QTg4TWR6MVJBWC9ZTWVmMnNUZnlk?=
 =?utf-8?B?YWEydlZqR0tyUE1VaXlXQXhpQk9TYmo1NzNERW9kQklWTHJPOFJpcGczalRk?=
 =?utf-8?B?d3lndmlaUSt2NWN0d2o4V1FNWVR0M0tDU2MxV2xwZW9sRnpQVnFQRU51UnZG?=
 =?utf-8?B?U2kwczBDa0FOSGFFdjNLREg5TVNwZU5PeHdDTS9yRENjaHh5cnNrWjFHVmRu?=
 =?utf-8?B?TDBzejY1NWQrVXJHeEZLckN5YjdCOWo5R05YUDhDdVI5ZEFKNUZrSzdUcnNS?=
 =?utf-8?B?SjgwWGR1dEhzQU9IZUdHOEtzRk1CZjdEYkdmcDcvRWd1cGsrS1RxTHdXc284?=
 =?utf-8?B?eUxXTTRGd3VIZE4wUEY5WmIwMGk2SEtCL0g4LzAwTk1TUXk0YW9aNTZvTHVk?=
 =?utf-8?B?YnFUaUgxdGJEZU55QVNHNWJaWlVNYnBlNDcrb1RGVzJIK0ZNNVJXU0l4S2xV?=
 =?utf-8?B?L20wNnJiRStwMFhrREpxZHhZaUNLZThaSVp1K2tCTUovSGliL3cvRDJKY2hy?=
 =?utf-8?B?cUZ6d2h2YXZzN2tGbDNpcUNQakN6YlJGTlZKVzVVR09maHBub1BzUHJBZ0d1?=
 =?utf-8?B?SVUvTm45Tk5ZTVBPK0YxTHhucGM3ZVVEY0ZEam1nYmFnT1haVlcvUEhyWEhL?=
 =?utf-8?B?Q09TSW53V0FIM1F1THdQeURHRjEvOXJnaHRXUFJoQ2RyV2o2NEVZenh0OWhi?=
 =?utf-8?B?TGxYckxsMGE5aXQ0QmMxNWdhZ2J6YnFja3FJQmw3cFVmVDlQR0lQejEwY3BU?=
 =?utf-8?B?STl1WVZCWWlwU2hZS1BiZ3pyVzdBNWluTXE4WEY0TkduVFZIMDBEblZUME02?=
 =?utf-8?B?Y1NCNE5lbkZBczN5b1pTdUtoVCtOaXhLeEtaSmtHK1BhV3pYcU1GUjd3YWpa?=
 =?utf-8?Q?1neM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0161d9-ba6b-4828-a710-08d9d3d24392
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 00:43:48.3819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vyHnKONNaPD8Pj9G4prrvijiRXhaAwH1GPgSGz54iJA1exXtYCZfca7+U/BgyxF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8774
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/5 10:28, Qu Wenruo wrote:
> With the recent change in metadata handling, we can handle metadata in
> the following cases:
> 
> - nodesize < PAGE_SIZE and sectorsize < PAGE_SIZE
>    Go subpage routine for both metadata and data.
> 
> - nodesize < PAGE_SIZE and sectorsize >= PAGE_SIZE
>    Invalid case for now. As we require nodesize >= sectorsize.
> 
> - nodesize >= PAGE_SIZE and sectorsize < PAGE_SIZE
>    Go subpage routine for data, but regular page routine for metadata.
> 
> - nodesize >= PAGE_SIZE and sectorsize >= PAGE_SIZE
>    Go regular page routine for both metadata and data.
> 
> Previously we require 64K page size for subpage as we need to ensure any
> tree block can be fit into one page, as at that time, we don't have
> support subpage metadata crossing multiple pages.
> 
> But now since we allow nodesize >= PAGE_SIZE case to regular page
> routine, there is no such limitation any more.

This patch missing the needed sysfs update to indicate all the supported 
sectorsizes.

Commit in github repo has updated to show all sectorsizes in sysfs 
interface.

Thanks,
Qu
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 884e0b543136..ffb8c811aeea 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2752,12 +2752,18 @@ static int validate_super(struct btrfs_fs_info *fs_info,
>   	}
>   
>   	/*
> -	 * For 4K page size, we only support 4K sector size.
> -	 * For 64K page size, we support 64K and 4K sector sizes.
> +	 * We only support sectorsize <= PAGE_SIZE case.
> +	 *
> +	 * For 4K page size (e.g. x86_64), it only supports 4K sector size.
> +	 * For 16K page size (e.g. PPC/ARM), it supports 4K, 8K and 16K
> +	 * sector sizes.
> +	 * For 64K and higher page size (e.g. PPC/ARM), it supports 4K, 8K,
> +	 * 16K, 32K and 64K sector sizes (aka, all sector sizes).
> +	 *
> +	 * For the future, 4K will be the default sectorsize for all btrfs
> +	 * and will get supported on all archtectures.
>   	 */
> -	if ((PAGE_SIZE == SZ_4K && sectorsize != PAGE_SIZE) ||
> -	    (PAGE_SIZE == SZ_64K && (sectorsize != SZ_4K &&
> -				     sectorsize != SZ_64K))) {
> +	if (sectorsize > PAGE_SIZE) {
>   		btrfs_err(fs_info,
>   			"sectorsize %llu not yet supported for page size %lu",
>   			sectorsize, PAGE_SIZE);

