Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FD14B9864
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 06:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiBQFm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 00:42:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiBQFm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 00:42:58 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61847229E7D
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 21:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1645076561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/koqUJdKdmrPHsNohAjA/el7dAuB1CAuzcc6duovf4=;
        b=iDwviUeN+fql9dIlMYmfEsgp6MTDzbLVlhR8dkccYShd0gjvjd1nypJ+1+lWEZ06v22Lrm
        8NWxvZZqQUzsH1th5aI7xpVNGMkpp0XuHgYhS8r4fqlN9fjqLAO9a3Ygdl9eUujnWMCd6x
        G9EBw6mRGdg36PUoLNqacf/hCzDQzx8=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-szvrBy0LNNaku8EiyZKDRg-1; Thu, 17 Feb 2022 06:42:40 +0100
X-MC-Unique: szvrBy0LNNaku8EiyZKDRg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/Zn/6ZpdGyTmta7WoLDsOWmDfIbE8YdtbqoyrBp8U8r77TekYIoBH4AHWgwUI82G3lvdG2pxVBn7gPpkvX7P+iK+ugzi/sV4bndY8ZGU3J5/jze0Cm85SWSb1OzSde86z0A1lBzNfov4oPBrFmY2uMtlwQPts37RhlIsMKVDMSsddJ7vCKIUVf+kPFAMOhJDm8ten1ikQ3NONVpnI5UfyRsn8n95fyzh6s5esbkYhN1R8fKlCh3S/8JkqhYFdIyTQ1ayogu61ge0DTXWfaUSt/sFtoWcio80g2YWn8A8Jqxz36E9dy1VtTFeJyj9a6Y7Ln88aFBkjDnEGeIYtClgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/koqUJdKdmrPHsNohAjA/el7dAuB1CAuzcc6duovf4=;
 b=lNSDnAOFm3OLx6rC8QzxEWtDnw35dgoG8mxoYyOJu0Lmw9UkGcn0lvjPYR4rTunTlzq6OmBCXegs07jkgkP5RTEJ7fh4NfTU6140enDESC2NgLKWBmOiT2yKh1uDGXbLVTNX3hnHEXH2zjvEoZsdEGs2u5rL3GbqOPb54DN80xrgPsBNZLK91rnqehzO6Vhf/rzus3wGoz4K3P88MW143wMrJeY8U0tddmvSMHTiKu9EMoFGAmiIOWOaRh5eIG+vjY9qXDHVf4HI1aMRZRyG/ESjAfxcELDb1BNTsXaPyrTEYn9HSvk7MsXd4ibThHEotGG35EmNr37D0tDt+zHDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by HE1PR04MB3161.eurprd04.prod.outlook.com (2603:10a6:7:17::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 17 Feb
 2022 05:42:38 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 05:42:38 +0000
Message-ID: <dbe7eeec-e3ed-0e2a-fb15-6758c2fc56fd@suse.com>
Date:   Thu, 17 Feb 2022 13:42:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] btrfs: remove an ASSERT() which can cause false alert
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <l@damenly.su>
References: <8ff11d24e9650cbaed4f52c4ead6184899bcc7b8.1644900321.git.wqu@suse.com>
In-Reply-To: <8ff11d24e9650cbaed4f52c4ead6184899bcc7b8.1644900321.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:510:f::14) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 149f35de-a890-4943-38c8-08d9f1d84e36
X-MS-TrafficTypeDiagnostic: HE1PR04MB3161:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB31617D912A46B3EE77D30D5CD6369@HE1PR04MB3161.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4hPBKS8T1aEcgp9YBOFYM7z4zhiXJFX5IfhSj58j+TO6J58ajUP9wGZK5FykXG9idbb0Zsd0ns0k5dVkDIrebLayR0Xmxbhlrwm3+JEh9QljHGyGun5a3LJ13QiHdHSQBhMKgu5lGnoQSNblvGj1PZg3rryC317Jxeu3P1huHjioQhK+lADyKEOp94ahJ6BqY/Rg0P4GIBPIki1UQbprA+3PAVXKqFjB9DjS/PpZFt+Mi7IANsIwPV50sn39MU7FdChZ1tTQ942Xy8AdApaVg03jTgyvZMw3Jlv/XwXRZk5YFsUfaAZHRuQ0CRX4WyoOKsyYMfXmGCC4W+EopLXiPxqrqiXVHZECIXmDgBbjsPgxT5lHm36IVkqfgyExHoEq3JKGsWu7/7cNbvp883zCYBzNHUxgZOk91SvQDtCHd/1Dk7qvUzsj350mBEpJPWhjHaAAOBBYUWNu/dMCIX6tJKU0z5q24tzV0+utBMf+8v7v7YVklZkJO9x46MopkF802BUo0kfypIZf1hADYSgwOwqT5tbbk0YDT8wcu2e+FnIFayYJE9dx314S0mqGrD3vxqFEt6Mvlr6fhtEIwdWjpI2vj8/W2/v2u0EdwNBpl/hkyMkjWCyvwHpi5PzoFdlWriJwsPkF1z45Kcl8w/+msGwOqez+cSrwfvp0QoXyTfQsa13N3DA25IiVVvneNNf53Lt+aP0iFiSMlDHw/ye47+AiX4/mSZmdizoZyUzZ2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6486002)(6512007)(83380400001)(2616005)(508600001)(38100700002)(26005)(5660300002)(31686004)(316002)(8676002)(36756003)(86362001)(4326008)(53546011)(6506007)(8936002)(66946007)(66556008)(66476007)(6666004)(6916009)(31696002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVpmVWc2bUZwUDAwcHNLQkY0ei9OTU0wajZhZ3dwK1JVWlR5TWM5THNyMHlO?=
 =?utf-8?B?Wlp3eldzSzF2Q1dwRlljZTlBT0NGSU1FbHpIdXJVQ3lmZFRTYUNMOFk3QWFI?=
 =?utf-8?B?ajl5YkxueVF2cnBxck5VWDFPUzBhNzRoVXBsYllYSHREaXJXZ1R2Y2h4Ullk?=
 =?utf-8?B?S2JjbWFjSFM5bHBFQ2o5bElXK3I0SWdmbm50VzhERXBodldPdzhnc3lNUzBK?=
 =?utf-8?B?bW9rRk1RczdpQkhvaXEzRzlwUzlFOHI4cGxlTjJsWWhyYTU2anFxek5QTGY5?=
 =?utf-8?B?NjR0OHpIem5YUXFwckY1aTNGZlc0MzUxd3dLc29DUVl1bGh0WHhHVTVtcldV?=
 =?utf-8?B?VCtlNjJ1SmdYbStWNWh1aWIzT2tHUTQxOFhPempPMXpUSklOMjNLR3M1Tkpw?=
 =?utf-8?B?YlppZnhwVDdtWFN1ZUJoMGlVVjN2WmdXTytXdUFFUER6Wk9sMFA1TTA4cWNq?=
 =?utf-8?B?R2NaUGcxNHowdndqcVRqZVRrYVJ0aWVkaDlNcXVUdGx4QWdHbWpabzdmN2h4?=
 =?utf-8?B?SVNhNUhuSTJhekdqMFZseWdUaHRvZEJ4RzgzZ2VtbjBrbnl0eUdjaHpvbWtX?=
 =?utf-8?B?a0NWY2Z6VjRHYU9CN2ZsYUdKUXFJZkhJMkFOUXVPck5YVTNEaTJqaGgzL0E1?=
 =?utf-8?B?b1lGY1hoWDFQcFhxZTZIaFAzVG9yOWtrQmM2dmUvUEp5UlRsUkZjcWN6dkpF?=
 =?utf-8?B?YVJZOG8rdmZWQTFFNk5Vb2wwdTZyUzJ3OGFYVitya0R5d0pjYXc4S09tNWxw?=
 =?utf-8?B?am9ERWVPUmdrY2Y4OEw4Y1dFaVF6ZUwyQlJoRUhCcHBHcWRXMXVtSUpPd1pU?=
 =?utf-8?B?aUllWlZOUkdLbnVMQUxoRTRDVzF3RHI0eThXbFh4Z01NR0huRVE2bGoxRTZw?=
 =?utf-8?B?dXg5allHcGNJZVBMRHNmZWI1NzVKT244NzdYWHZycGVSZmVkOHJQOG9SbXVm?=
 =?utf-8?B?STEvNHgyenV0L3ZTeFBQbERDVUFRYkdVQmprYUc5bFN5RW9SRjdOeXNxTUlx?=
 =?utf-8?B?Nlg2OUd6bGNlMFdzak9aMytLcGRodEI0a0p6NSt1cDFIK3BkcERmTFNYUkhT?=
 =?utf-8?B?NHRGd0lqdzE1QS9vZjlkK0Z4NFNHNjhSbzNPVjhZMnpwU3lyV3REbm5jaHhW?=
 =?utf-8?B?YkF0dTJzOWRkNUFDeFRBY0JWMDR2ekZDVUQrcHVxWjk4Wkl3aHorZnRGbmFY?=
 =?utf-8?B?d1JlM2xGOExoOHc2T0xMVk5CRHUwZEFjSVFPYmpWTXJZOXp6RzUvWUpMd1BI?=
 =?utf-8?B?TTJGWmp6SWh6U0dZREF5MG15RTFEU3FZQ0M3VVNWQks4VEhaZEM5WmQrdll5?=
 =?utf-8?B?YWxjWHpkYm5sZDJML2R1ZUhoT2VRb08yS2VBZG42c0swV2RJQzUxTFVPellM?=
 =?utf-8?B?bW45eVZhaGN5eHZXbG1KZzlldklXTmhPT052a0hWUnpVQU5EcmQweVJHNXZy?=
 =?utf-8?B?R3NRN25YVVlTdVJPRjhjdHQ2RVNkT2lVazFDTGxsN1puME1YcjhRd3ZlRG4v?=
 =?utf-8?B?SFU3djAzR3RIUlBkcThvUkZ0M0NJbmxlakJsTFY0SUJpdXdrcXdQQXJJNHZM?=
 =?utf-8?B?ck0zcTNpQnRrSEIrVTgyOHdnNFF2TFY1VXEwa3lvVXkxYzNvamxIbFcxc2k2?=
 =?utf-8?B?RGVZTVJjLzFpbllGckkvU0ZzTEhaNlYremxtalJuOEo5bTA2T29pMHNyZ0Fq?=
 =?utf-8?B?Z3V5ODJUcDZsNHBvQmxrWE9aNjBZWjRkZ2lYcUxwYWxkM1pDV0paOFZ3Yk0v?=
 =?utf-8?B?VXdVOFhybktGQ0tDSUJFVWZEaVVnaGYrWitWUGlPWXIrejVVMnVGQnBFT0xQ?=
 =?utf-8?B?NXdya2x5dmxxZC8rZklnblM4NXozMWVsNkxyMHNBRmhpRDB5dkVsUWlqc2JK?=
 =?utf-8?B?Q0lRMmxVdVBmRXJpcCsxcG9JdjhqVUV5dm03Y3dTb09MbXJUM2JqRCtiK1ZL?=
 =?utf-8?B?SW1lTFJuTDVKL2dCVmlUeStXVXFsRVlta1JMQnlwcHE5OHM4ZVQ4N2o4Y0Yy?=
 =?utf-8?B?WlR5bUxsNE1yWXowOWQwc0ZGOUJqMVdqMEY3TmU0MldIQ3A0M0F0cEhXeDZW?=
 =?utf-8?B?VnFBZUx0YzhLdjJKWXVCN2Q2WXJNU2s4TkU5TFNZWU9RV1c4Wk1PVlA5MHJa?=
 =?utf-8?Q?mWug=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149f35de-a890-4943-38c8-08d9f1d84e36
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:42:37.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MG90uGbpRN7VoVbxf4CIDxeCDDOcBxZKb+1f5jYtb1iyQZ6U0tPg2NOxfFutC9MD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3161
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/15 12:46, Qu Wenruo wrote:
> [BUG]
> Su reported that with his VM running on an M1 mac, it has a high chance
> to trigger the following ASSERT() with scrub and balance test cases:
> 
> 		ASSERT(cache->start == chunk_offset);
> 		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
> 				  dev_extent_len);
> 
> [CAUSE]
> The ASSERT() is making sure that the block group cache (@cache) and the
> chunk offset from the device extent match.
> 
> But the truth is, block group caches and dev extent items are deleted at
> different timing.
> 
> For block group caches and items, after btrfs_remove_block_group() they
> will be marked deleted, but the device extent and the chunk item is
> still in dev tree and chunk tree respectively.
> 
> The device extents and chunk items are only deleted in
> btrfs_remove_chunk(), which happens either a btrfs_delete_unused_bgs()
> or btrfs_relocate_chunk().
> 
> This timing difference leaves a window where we can have a mismatch
> between block group cache and device extent tree, and triggering the
> ASSERT().
> 
> [FIX]
> Just remove the ASSERT().
> 
> In fact there are several checks in scrub_chunk() to skip such device
> extents.
> In scrub_chunk() we do an chunk mapping search, and handling (!em) or
> (em->start != bg->start) case by simply exit with ret = 0.
> 
> So the ASSERT() is really not necessary.
> 
> Please fold this fix into the patch "btrfs: scrub: cleanup the argument
> list of scrub_chunk()".
> 
> Reported-by: Su Yue <l@damenly.su>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/scrub.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 11089568b287..9c6cf1149f08 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3822,7 +3822,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   		dev_replace->item_needs_writeback = 1;
>   		up_write(&dev_replace->rwsem);
>   
> -		ASSERT(cache->start == chunk_offset);

This check still has some sense, as we expect the bg cache to match with 
the dev extent.

>   		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
>   				  dev_extent_len);

And since we have removed chunk_offset passed to scrub_chunk(), we have 
an extra check before we call scrub_stripe() against found_key.offset.

So removing the ASSERT() is still OK.

But it would be better to replace the ASSERT() with a full check between 
cache->start and chunk_offset.

I'd better find a way to reproduce the case, which I can not reproduce 
at all under x86_64 vms.

Thanks,
Qu

>   

