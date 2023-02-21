Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6569DEA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjBULVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 06:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjBULVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 06:21:37 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19792332F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 03:21:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7l0j8Ni7XZQzgnAwlLXDD8vOJLDE2dLSVdLPzS6xcCMiem4ZSwogIGGRxI57pHcdCXr79spsQ7LySZe3qFPgcRAMn56n3ZODO7jf0PjFou2kwW/rxLSiED7Vz4LHPEXHJK1pthuK0pZXK4nnh7ABoAyPC0VrxcDWHtYfCeZmFm3e6Z5aZCgg9erdps7OOd075cSiioV3mjF12NlDo0S8CspTdWknm3g9yZ6BGMAZfcUUtjPHlvPkni2WUcZYCZsp4wfxBRzyJg35XYXkgFRnywRGO9orFL9xi3TbRoeAQ1g25IrD4+qRul0zVUufhwfxjTqeCdljuI7HWk1Zbwh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8902+wUrXks2sIxS0ey2hMYN2j541dAmb3AaZF6YVvM=;
 b=bn21vE4pO7Qu1Qyni1wSTnHRZ27L/c+cvwEKVPawSZ5ifnmW9PTvSmsji2IUK0wFYVGsPW0YL+CwNCrAHjA1f+IwXK6rJT3QuJ9gHxJVM11kBua7LfijDe4jQomJdW3zGWuN+1IzTUgffW/vqyh56z5b/HqQSputih1YZmFJDYvvs9wLpsgac/6mAPnjj9bTLfVNAKTyy9H9BVW0YAEkFAbN3crWnnFKo61kjjzXqPIUE2q9biyZmycHgovw4p8fUDLnaYQNnTB6QvD5sQhDZvKyRhKTY3vAXrWxY3c6XAkS4si1NYt3QeLJLaUBbVYyzl+0Qjt+Z4AggqJuyXJAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8902+wUrXks2sIxS0ey2hMYN2j541dAmb3AaZF6YVvM=;
 b=sVT5GjPIl66sO+CZIgzL8DT0Ga+KMVzwoQLPp3ceZIjij2j3QAfXZjNUzBf4lHFhEMd/epM8svWrzNF1o+uZ2rOf2HcLBmQ1xURX+o24c365ZvGhVMW3waMRfxFsFqSttktJ/lWqMtHTcJEE9VxQKYV8Msf3KHZUCfOEV3GB0uWlqUuxrxxRzWS/PTkHaKechMIWgwM7uVZ6qF45Q0C4yKb6XetR6ExPyjtAcIamJwjOZtPYR+VSAi/V/UmvztXUxx8Sq10PTVGWpYpCZrMn+MXxBCETOotPVKjK0u19RTp7gqa1sw1aE/EAOmsaO9eZT66WeJYNIZe7BSxvPvig3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8268.eurprd04.prod.outlook.com (2603:10a6:10:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 11:21:30 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 11:21:30 +0000
Message-ID: <2a038ad1-8b90-42b2-1ee5-d95c2e1602b0@suse.com>
Date:   Tue, 21 Feb 2023 19:21:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/12] btrfs: rename the this_bio_flag variable in
 btrfs_do_readpage
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-8-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230216163437.2370948-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::28) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d121f0-c5a2-46fa-6603-08db13fdc808
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUAAFjYPUOQ1YrvxSE8BWtXSvbRf8/FfVc1KVpfLy4OTEpFycCPFaiozHI1dbiKd6qGYY+AOw8xOnLrMUUPPGhtb4RdFAEk9QpW74x2VniAYolOQahRVEe03KR0D+S0EdQWsTbtm9sszs71/hoTomUAcMKboErilth34eTCu4EVkwjr6unyga/jAcw10aWH/Q+HHy9jMcJwGPywJcTW7L5SjsF3h5IoZpZk9tA9wNgiUhHA2ubutQFlFqDTykAjAgimsyFmubze9fI8x64pKC2JdaqinDM+ZJHa3b60aekobe+bC4ozs8mpHPFpwbn3C52q9sgK5pEBimY7d2WyTcpnvnJdz9Hv22ebVFgW521BD8QEVLOQflhDAVnsMUiECzAyRhB4fYx+52/s8geBblMJYZHTMcGpF/KZUNJgwIRlS1fi7xJ4+uu1vil0Y4rROJw45BpBDXVwuq/CyYFT5r+pyCfEh9Ae4RSTN2Vhau0xQtSZALOucppLjHLsujNEvvgGVLMxqNTC2N8HQ7WwOCGr+cBW9UDEGMhcjkEx0DFr4IIyLSMOiM6ThW5luSF+YzO9Ulphldw1PuwTjrY1UnNmg6vKqnYIQyEtcj3i6rh58xKPiXQBfrbcUdi5G3YTbti+ZYQR1GJLQBElkSXuDZrHVBM+g967MhP5EWgJiyKSra5XzKgUAv60VNQap22e1AQWxBDRaK32M15Y1bZ6HR9+IZGqyhlHR8GS9940U52s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199018)(83380400001)(38100700002)(36756003)(86362001)(31696002)(2906002)(41300700001)(5660300002)(186003)(8936002)(53546011)(6666004)(6506007)(6512007)(2616005)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6636002)(110136005)(8676002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk5hWHN1TFVuVGxvd1hwNHdBdGZkejRjTjFiaXhTWkUyTlFUNXVDdzhrN21E?=
 =?utf-8?B?YVl3ZlVuWFF3VDdHU3k5SU9DbWZkT3Y3QklPLzBxUzhMYTZtcTY0YXVBSmpC?=
 =?utf-8?B?aVJxQWxQcXNQTk9naHRNMDRuYnlncUJKbHZLaXVFRzNHNFpPZEFGQmxpdWpN?=
 =?utf-8?B?TFQ5UytPRDlZYndxQ2ZtOXZTRHAzTXkzeTRkeDh3QU11Z00rTDVubm5oWmNP?=
 =?utf-8?B?bUdYbzlIekNwWTdHMFdtMXZPemlWZ0RZdEhCb1h1RXV6TzV4a2NGNCtiRVpr?=
 =?utf-8?B?TUNMUnpSRmRkV2ZDbU5jOGtwT3BBaE9xUnRFa0VMbFVhNkFQNzRVN1Vscklj?=
 =?utf-8?B?N2JubDN6RXpuNHZxU1lkcDBoemt2YStvVlhpVTNuejczZkdRUzlpUGhYS25X?=
 =?utf-8?B?S1FvTjltUkl5SGRkUkwxN2JmNnl1cWZJZUFMZDBMSTZCcFdqRDhZOW55cFBK?=
 =?utf-8?B?YlN2MHBQL3ZvTU1aV1NBZHNnOTBhUWNoVVFyODdaS3kvZnlmUkYwODZ4amg1?=
 =?utf-8?B?bXUwTEhzWTl2aFQvQjRIOGtkNU8xdS9KTzM2YXlRSE1DYTdZNjBFRVllcXBN?=
 =?utf-8?B?NDgzVm83MjRxbEhWelhEZithM2FTeFkzMVAvK09JaFVFUmVlRUtXWHB4S3hw?=
 =?utf-8?B?dXU1V1Z0M2hudTlqQytwcjVCZ2Vqb0tlUlpGMEFKd29nQmlHbTlPSXZUU21l?=
 =?utf-8?B?YnlmZ1B0NUU1akZXNEJIRW5oVUg4RDRPTng0Ty9Rd3IvRzdqeE1zakdKVndC?=
 =?utf-8?B?OUVITVAzNUFvM1NRRit3VWhMNXVCdXZzdVB4ZGZyQU9zMUpWcDVqTG9wT3Ra?=
 =?utf-8?B?RDRSbE9UU293MDFJR29lTHFyMGlYdDgwS3IrcStSbWVhdlRSUS9rRld5Z2Rk?=
 =?utf-8?B?WGdDOWxNTGZDUDZiRVpQUi9keUdHWWFVdml4cjBUUklGa0pSbDZOSy94NU9i?=
 =?utf-8?B?ekZxREl5YkdyZDNGMk1UMTRTaHIwbkJhZFk3a0NuV25qRTQxV0pUb3B6c0pk?=
 =?utf-8?B?c2lRYTREVWtJUVRkWGZoaFB4aEtKSVpNVEZrWGpSdVhZV1NSM244cmlLdDMw?=
 =?utf-8?B?R0VNQ0x3NVNFY0tFVFdUelZISnM0cG02UytocUJ5eTFzazJ5NS9MUkFjWE42?=
 =?utf-8?B?Qi9VMisvUGc0d01vT3RweXlvaWlYTDJqRGIwbU90dVNMYzNPTFVka2JnWkNz?=
 =?utf-8?B?M1RGMzIwYUs3QlR0MUdkeVFPZ0xmRW8rSmw0dmQ3b2cza1VRRjdJTElqM3d1?=
 =?utf-8?B?QmFlUjQySW9sN0RRVVlHcjNnTHdiNzRkanc5L1U3LzZWVzJ5RWtEb29DWE5W?=
 =?utf-8?B?VXdkTi90bXc4UjJ0cFRIeXIzWDBLeEp6dlBiYkZtR0JhVmZnak5uWXRiVHZR?=
 =?utf-8?B?cEdzcjVWTmxTWFJ6b1A3T29BMnNDZ1NHaDlaRHJwNVViWERVMCsydTNWbitz?=
 =?utf-8?B?Q0xSRnFTNHhzTmF0NEVTaER1VDNEMnlUNGluVXYyRWZpYWZaR1pNUHRaZVcz?=
 =?utf-8?B?VDJlLzNtUTZsQ3BvMWR0V0k1SG0rOHlUTmJ6ek1WRmVRc09sZUN4VVQxRjUz?=
 =?utf-8?B?RVgxWmtXVzdqQlVqSmpaVjd5NXZTOHgrck9DMGtzbE1vclRKcU4xdlpjYy9P?=
 =?utf-8?B?cDhqK3gvT3J3YXBkWmpiWTlaL21hZEF5YksxMjNnUXJuL0dLeU1YamtUQlFM?=
 =?utf-8?B?Yk4zczF3QVpXT0h4YncvaDJPdVRmdWJ0MEtLVnI0c09HTE5wMjRCd2tlK2tG?=
 =?utf-8?B?UmhkZGdrdWRoMkNlcEFpZTFITllvLzdSZXRBUG1zaU4rZHFVTjRkc1pkTk5k?=
 =?utf-8?B?ZVBQREFyQThab1o1azF0RmN3bzBEZ1FjN1NGdGlRVnJDdERxaG5zK2pneWtO?=
 =?utf-8?B?Y0xOMVp2Nzl6UmlTeG9ETjJEQTNCbHFoQzBYWWVLbzZBK0dNS1JhN1VlZ3ly?=
 =?utf-8?B?aW9JbzBRb2xNK29GQWZjNHpjS2kyNDdMMjgxRnN4VyticSs2WFZHSWlLdE93?=
 =?utf-8?B?bnU3MUs0dzBHTTRLMElHZVUxUVFaYTlHWmFmY2FWMlBrMnBLM0htWW04SzI1?=
 =?utf-8?B?N21wbDRuTVJIRHcrUVVLVjJ6eEhPemFzMzVkc04vSXRsVElzWGlvMzIrcGk4?=
 =?utf-8?B?NTRwaWFOS2NqVHZpNVdRREVlVk5WVmlVVWdIbmt5K0l5Y2l2NVJXdUlUU2Vn?=
 =?utf-8?Q?A0fgtwlL67vgQc/ajxzWl1o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d121f0-c5a2-46fa-6603-08db13fdc808
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 11:21:30.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1lHYX/ddWzqlVkRYbMQcY9Alkn/ua12WxaRhW/q9yV6nhMYhK745+6dYC9HK3Ex
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/17 00:34, Christoph Hellwig wrote:
> Rename this_bio_flag to compress_type to match the surrounding code
> and better document the intent.  Also use the proper enum type instead
> of unsigned long.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4fe128d2895f88..24a1e988dd0fab 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1213,7 +1213,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   	bio_ctrl->end_io_func = end_bio_extent_readpage;
>   	begin_page_read(fs_info, page);
>   	while (cur <= end) {
> -		unsigned long this_bio_flag = 0;
> +		enum btrfs_compression_type compress_type = BTRFS_COMPRESS_NONE;
>   		bool force_bio_submit = false;
>   		u64 disk_bytenr;
>   
> @@ -1238,11 +1238,11 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   		BUG_ON(end < cur);
>   
>   		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
> -			this_bio_flag = em->compress_type;
> +			compress_type = em->compress_type;
>   
>   		iosize = min(extent_map_end(em) - cur, end - cur + 1);
>   		iosize = ALIGN(iosize, blocksize);
> -		if (this_bio_flag != BTRFS_COMPRESS_NONE)
> +		if (compress_type != BTRFS_COMPRESS_NONE)
>   			disk_bytenr = em->block_start;
>   		else
>   			disk_bytenr = em->block_start + extent_offset;
> @@ -1314,13 +1314,13 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   			continue;
>   		}
>   
> -		if (bio_ctrl->compress_type != this_bio_flag)
> +		if (bio_ctrl->compress_type != compress_type)
>   			submit_one_bio(bio_ctrl);
>   	
>   		if (force_bio_submit)
>   			submit_one_bio(bio_ctrl);
>   		ret = submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
> -					 pg_offset, this_bio_flag);
> +					 pg_offset, compress_type);
>   		if (ret) {
>   			/*
>   			 * We have to unlock the remaining range, or the page
