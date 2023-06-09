Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA45572978B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 12:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjFIKwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFIKwB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 06:52:01 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9BB9
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 03:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l62EOIT/WbH6QHUExYe/bzHFouCAyNg0qJ9BRedJDOeqy89s1HJ50iNThy2s5hKdovqxLtNKrpjL9zF0C/4MMjBPuCi2+PH2UKIwIqrFRx3zam+ojbOKiIBDCUScCuxgpHBFV6DjCNN9ws+otN222HrTuz2VdZm00QpfZ87qerf8cNwHPt2+X/JBO1KXavoMolhQCuO2mri+EGfgBTFGrM8NlDcuD3B54W6iz0dYNk5Do0+M2fMx2KtBLM1bsNfD6NhpqCuUVXQ8C31/f+shf9EinMl3CKE6SPuJDBC9IrPVTouuVwdtKlJ45/8uFRqRUrFyy6rYOW74qp0+BRMgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQwULGsdQzDf3kE1gO4NPEVSAz+LvJRT23xp4umyF98=;
 b=aWQnxUtIiOjE5sXAeWUQuNHTBWq0gmvWS3DAG3BbK2l1V3vzw/rBC2FDbPMB6amZkdmc1yGxFDAIOMwtIk4P6sH80pTUnEJ1h9XCcS2YzS7yIS0CDy7Xq8Q7WUv4cM0kuIskTTuQ1FL0AHJyJ67UaFhJfz1mKYxp7IbqtfQWWE35rSfpM3SaKoi1ov7qJhVMsllBi1DBTs6rKw6b2eVTOwdYhARfl3m9Js+3B2YxfkKfXnZL6Y+3o3W5sm71EGqUN7rZjrBAhOIB/w90WXZrdzhQR8+GzzIfSbPkKCf7Xz4GhnARKSQxRtmzDCMF7InGULlz8iyeCnK+xCDztsuiMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQwULGsdQzDf3kE1gO4NPEVSAz+LvJRT23xp4umyF98=;
 b=N7NrNVcZ37WHfH2UWTwDZ0PiTsgY9T0r3Ft2n0KTGyOQI2yCogUB2Xn73VSCVnd7knYr8dd3JdpT5cUF7u/yaSHnYpTvqU6d9hqZmXrekh57bcpOQWMxBFL1+cQUQRs/JIVF7DBsPjSgk3XTkAvTlkn6BE8fosQOLJsbItDOnHyJRFR5HB1h8MhFV9NtqsQleMKU/DDGBWu3aSKZjR33ZBnXZYThZ8nDMg7LlG4iXs6tqm4/71XJY6cP6Ti+tD+8VTm3tMYOdi6WhLBMe86s8fLVuRE/hXxZiMi6pziy6+TIJzB1hfADuLzda2ptGpXQlQn3l9SN1hpqGOUGLrUc1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB8043.eurprd04.prod.outlook.com (2603:10a6:10:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 10:51:57 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%6]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 10:51:57 +0000
Message-ID: <76b314a0-cc1e-f163-5968-8304aeab308d@suse.com>
Date:   Fri, 9 Jun 2023 18:51:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs: replace BUG_ON() at split_item() with proper error
 handling
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <5891832d9130694cc60cffac74b95db92521728c.1686307630.git.fdmanana@suse.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <5891832d9130694cc60cffac74b95db92521728c.1686307630.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f444b6c-19cc-4c1a-7654-08db68d78b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BT35g5U83d9mSPZtv1cJdq8yrY2/qZzHOGmEozEzvba7Y6ANRabjBpClhxdk0A+ERVZrfKZHDMAG/gDIesonWijH789zUM+5KRBJ6MR6DHKVFlzFrx8zS5C7rF3hyoJseAiddFSbpXXZSssVZHfEPBrTNCwWoMLqUhql3rIB04+wpiFThtOkgFNPEa3RRJL1C4fevGqMM3/bc1I1DaC2+bzAQSTDIHB3TG55/bRG44n2aToWYme9XAkpkvPYfKE5tH0Pdpt8G27nIN/AgqTf6IFDcvfdbJOTfhVDzXtA7uqzINjGId+ra0tn0Ai8aQof2DooQ2xfsRG5qrUwrGZvPNFQAc5WIMtVaEPXfQXtayDxB+NB35RMQGswvj8De8ZvmyTo5mDrHC18RsAnQMc70oYLPAzFz4wrpUWfg3xJUZ3eIKonaMR3KnSPwYQoKHZ4JVv9NEilK0nngBxfgN2Z0SiAlvudkYovqPhHis3JBfhD0ltenwtwY6uO90/JemWWT3yIHMmuDo8TaL92MsUMmuvA0HiBPPvraOLlpMCmjGvrfISGTPM8pn5GdCsXO46t2Ss7/cm9U9ddIqCf2YQb9guQmhjYXyJ1EqxLq7WUr5Gv2FEsES639/j5cJsoMJsTkB2zphaxG73gdWCcjPCTrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(186003)(6506007)(6512007)(53546011)(31686004)(2616005)(66899021)(83380400001)(6666004)(36756003)(6486002)(2906002)(8676002)(8936002)(38100700002)(478600001)(41300700001)(5660300002)(31696002)(86362001)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U213OUMyZ3NzcWRDVSt4d1hma0NVUXVPVy82L2JPUEVtNElYOHZQMXEyREMy?=
 =?utf-8?B?d1VWRkJ4OHI0YjdWdHE3R2t2eXNVa2p3SVEyT0N5bnFXMzZ1aDFRdjBaWFdI?=
 =?utf-8?B?THFRVWxIQUlnNFNBUzVFR0JOMEpyOVVaZC9vaGl6MU5SYU4vS3VjaktJc2ov?=
 =?utf-8?B?Sit5c1JjWVhJK0o3S3VDSVBGRmRkWm9ZMWJUTzhvbzRpbUJjcGhCK0JoN2Ur?=
 =?utf-8?B?RXVsUCtseE00UG9LMXZpUUVIMVNJbS9GQVNnSTRRQmNpaTNNdTN6K3VVZVZz?=
 =?utf-8?B?azhNYU1HY3RhOTQyODZZRGdKRlNqcGxYaTlYa3dESGFOT0VkVHdSWmhXOWZl?=
 =?utf-8?B?elh0T2YrbkVORFd2aHEwbVA1LzdaTjkwdzY5VFBaMDl2VVg0S0hJa3Z4QXVm?=
 =?utf-8?B?YnlBaFloM3Vpbk1aVU01RGsyODFzVGNHZVhpYXZJM1FHMGQ3Znk1MVUzYW5h?=
 =?utf-8?B?N1NuMG9vYnpoYnUvQ0NrR0hZS3d5SU1XbURORmxCZmhPOGlhQ1ZFSDVnK2ps?=
 =?utf-8?B?Z0N1dnBWOTBKbWRDeGxQelh4SHAyalBnVVpmc3MwVXhwUE1td0swTURPelNG?=
 =?utf-8?B?bGExeVUxdGt4bDhtRmZ3b2Z6VHk3U2lvajFoMWtOcUVjUG9YYnZvOVJreTA1?=
 =?utf-8?B?dFQvMHU4N0NZT2dvQTJhT0VkN09PZzUyVy9OdjdUaHhNOHNSbENUWlBxc2J2?=
 =?utf-8?B?dEVabWNiTEY2MmxVWkpoSUJHNU9kV1RmL0ZFdzJ6bVZoZGthSmtCb3VVRUtW?=
 =?utf-8?B?VjdEdUJoMjdWV3RWdFNlZ2Z4K0ZYYzNZaGgvNW9TNkdlcGRPcHlTQ3I5alhR?=
 =?utf-8?B?M09CeDZKVUVLVjhmWU1EazZ0a1pXYTUzbHl4bkZYajhtS3RGR2dPOFpFdHRX?=
 =?utf-8?B?aHJZenBUUkhidkEycERwUWJIeUV6NlpPNDZVbWZNMGdDQkxsSmdkQlpYN1Zt?=
 =?utf-8?B?S1FPRjlXNHkzU3g4YzNVNWxUcUV6ZmtkWFVWNmtDSnhrOE5icktCVXhZZWZG?=
 =?utf-8?B?cVgvYlNhNHFBRXhYc09iU2ZLSjVVamJsUDBTbklzTGtNT3Z0YVhWWEZRVERU?=
 =?utf-8?B?MHNPRUEyWVJkdlVybk01dFVSRzlGa2llb2pabUpCRlUvQ2NUZndZV3IyVm1O?=
 =?utf-8?B?aWdTVWEvRlRpcUIzYUxzVHlmcVh3MzIxWks3amhhc3JYZGE5cUdudnp6dHJE?=
 =?utf-8?B?TWdDYUY0Q3JjZTU0VzdCYnUwQzdjL1dTZ2pwMEpXa0J2R1ZULzhFTlJBaFRx?=
 =?utf-8?B?OGc1SExZdGIrdXFFenFwOUs3RG1OQ2RqOWRvNTJ6SnV6bEFJd0hURHJTREJi?=
 =?utf-8?B?QXAzR0J2YStsK3R3TE53UUZxMUppR0N4RDBPcitaV2FFY3Z5LzhqMGZHUUEv?=
 =?utf-8?B?d2Jrc2hZVU0zeXp4TFByc0FRS2VOaXdBM3ZmNmY5VGk2Mmh1Q0JjekcxeUVh?=
 =?utf-8?B?Q3dHaEJvQXc5NWdFb1YrZVVITElNR0tRajJoVy96U2tGektUVkxwbU8vOTVZ?=
 =?utf-8?B?aGQ0QXFzVEZXVnArWjA1ZWY1ZXJnUTRta3JCdWovTmVDZkJyUFBhU2ZHZGVK?=
 =?utf-8?B?bUNrOEVjMnNHNVk2RTNROEczRDhjZEVwY1hnQlNSY29oSW53dldmY2ROd0Ry?=
 =?utf-8?B?b3ljWFVTYjM2V3ZWU0lZckxSUmtMbkNLY3BkcXBtYmlDUWF4VHZ1aHNYT3hy?=
 =?utf-8?B?MVVYaUY5YjJWc0loTUFMcklDQUU0NUthR0xYWjJVeWJWd2ZrS1N4Nmt5alQ1?=
 =?utf-8?B?M0RyelE2TGFGeFpUWVZ5cVJ2cTZzRmlsQXJuRVRCaFlXaUFmdGs2dWgwZlBt?=
 =?utf-8?B?b21DVytzdVlZRXQwOHU5MDErSnJ6WkN3YmVZckpRNmJuUitmNlB1Vy80TFIw?=
 =?utf-8?B?cVp6YUFLYXZkQ0tiT0lQUnFmQit2WFJkYXlLODFtajk5ZmJvU0h5bEVVL2NI?=
 =?utf-8?B?K01aaG9oNXdUb3hVMFFkNzhYcG0rZitFNXlCSThZNVc5dEhVc2owbytBM2Y0?=
 =?utf-8?B?cFdSK0g0eS9FdXlnM0VtS1ROck5TbTBnY3k0dlhNOGh3RVdRRDNyMnU5Ujl5?=
 =?utf-8?B?dFJiQnZDMUo5ZlNJdEZNM05ROHFzY3FPSFoxL01TSGlXQ09BMVR0eERZMGJ1?=
 =?utf-8?Q?zZwMpH6kybjFyUnzJXO7GMrTh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f444b6c-19cc-4c1a-7654-08db68d78b77
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:51:57.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVP/GaFniJRpVeEZZXKLaR+uE2uTiXBPjSx0Cq97ExRY+BY8Pu0kTgyWDTgcS7i9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8043
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/9 18:49, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need to BUG_ON() at split_item() if the leaf does not have
> enough free space for the new item, we can just return -ENOSPC since
> the caller can deal with errors from split_item(). Also, as this is a
> very unlikely condition to happen, because the caller has invoked
> setup_leaf_for_split() before calling split_item(), surround the
> condition with a WARN_ON() which makes it easier to notice this
> unexpected condition and tags the if branch with 'unlikely' as well.
> 
> I've actually once hit this BUG_ON() with some incorrect code changes
> I had, which was very inconvenient as it required rebooting the VM.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 29c5fa252eb1..e6009da34835 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4000,7 +4000,12 @@ static noinline int split_item(struct btrfs_path *path,
>   	struct btrfs_disk_key disk_key;
>   
>   	leaf = path->nodes[0];
> -	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
> +	/*
> +	 * Shouldn't happen because the caller must have previously called
> +	 * setup_leaf_for_split() to make room for the new item in the leaf.
> +	 */
> +	if (WARN_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item)))
> +		return -ENOSPC;
>   
>   	orig_slot = path->slots[0];
>   	orig_offset = btrfs_item_offset(leaf, path->slots[0]);
