Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862DE7514DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 01:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjGLX6e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 19:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjGLX6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 19:58:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE7C1FC7
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 16:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+2idI5SfqFIbgpcRorKppmJtGyZuRLpOzofzKMCMpPN1A15hfNBVtV9QbQmZMvFmkc3qcBBr2fn6bT7kZRnHeO22yG/rkT2jwUB2eHoCJPuzB2tDKotg7q3UWCbZ9ns5Fy4qnMmJYJHZHyMh8keRJI6bMgFQiOqYQH02Xw652+xpbSERrvlUZry2YdJfUlFbt4zRy9gWS2MROF9j6jqwhILInvQCLY7+/5ciLpa4xtPynGY2nHaQF3jHoEkhcHF5zOaosga/o/X3Ovjqe0bmVCEvY9NMCaO9P/WsCyp9DXFB8GmXzeDD5PbH0yOH3X25eg7v2CcHTei1gBOXtRWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKse2AM2astk6C1yLU0DTdo+Gv1eXB6ZQDhNdgP9sFg=;
 b=KlqFHYY8r2yyPCHWQqgOhjTQyLcijRaiKsYzMJCeZC4z3Ip26g/UGlBwcfhl9FqrKS1R0bsRF9tLFQQdtZ8S0+coxWDPpVPIkPPq8Qb1+GzChobdWdcA4bfASTzoGnagsXvlYlEOclE+Qfj6SsgFcgZqIwmL8GhbGL741FzENC3DT7Sg4K+LnUue0L9xcoOzmFSDY2dQWrfeTvjnKhbyIOtoEODnVQdg9I0mVGP/red3SkcMJbwArvMVaUSnNZNzlPTFKo6ArIFrsyQaLJM5rS5mbubza3Nq7eopeX/MpfcaFOEinYMB9OHbATieZNSGGtdKjsHvkLQiNAWj/P3OqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKse2AM2astk6C1yLU0DTdo+Gv1eXB6ZQDhNdgP9sFg=;
 b=ovTe+AvgEr+GuuOdLxiGN5sREgDZILsQll4iDdVPEcO+pODWxVsVgex9Rhz2JaKh1mKVXWVB48KfY8wJNsQZw5YfkbGouC5yWcUvD8hNsJeg7NF0ONmj9Rqm2b5Ver//BBmky6DwEoTsTOhvO9K+r6rE2NL+q5AnOcvZt5HBfyz9JCwGPPszfeVyYV7jZeNlCeSotY8LMQrhEzXkDn5coOVC34ryMijR0k9pkfGTHwlUiLUYk9rznZFQGjhOwP0D2THfYVNoeh/D9D2VAm0PyT5km0wd5IdVYAiqfKGq2SgUdfh3Lk1Y3y0sEPJyn5GLsEqaQAbZYTiVuV8AJYyjjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8121.eurprd04.prod.outlook.com (2603:10a6:10:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 23:58:28 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6588.024; Wed, 12 Jul 2023
 23:58:28 +0000
Message-ID: <ff78f3e8-6438-4b29-02c0-c14fb5949360@suse.com>
Date:   Thu, 13 Jul 2023 07:58:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org
References: <cover.1689143654.git.wqu@suse.com>
 <ZK7XwgBJZDpWFuz6@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
In-Reply-To: <ZK7XwgBJZDpWFuz6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccf7678-66d8-4b59-825b-08db8333e2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zB5VyndG5z9bHz3/GKc8PIFw+IApKdxm2we0TAGGacTwGW6phf5o6UdORh22n46x1UZaAj/Xg6uKcAnAxpozpy/hof+Ffy67ncmR18H7fahEz2hpxQN3dtXP2u3Mx8wcBD7p2q9DOGRL9N/WT6M8CqD8ltjbPq3APdbWsKImnYWSYNwDJltcNFlM7O1hFFoDp7AuCOZMDgKlOzZYefB0NRdDMKxEwYCwSTC7YwjmBzuxuUKeqMdxqIAuPvbpGfB+MplvDIgUR1JtOjlnsGrqxIPEX5r+o3k8H5ntz/cMcd0+H0ABcwMRNphkVfYMajY/dECV5EPz4zbYFsP+RUbmNRnncBtCydBNHh8UeSfh8iX9i16MhrvPEfDYkXk2o8ABYjeWIRimdWpvqIGQ7LbJtAc1ffuFxLAfElfKKxCPYscRU88mJGNAkk1CODx/VUpFIlwoQFazciTh7ZJyALZ2mTBcjPC1BjqYzImOsTu2oQ+2iG4nJjLJVjven8vgeG7z3pcKXq9wAQwPRknrIVM+YnmfPHVhPvur1q4Z2ehjGMbqkK23J9gJFR78W8ttmRGLNAR0UJguo6EYNOPY9FlCDMxZOPzoe3+kLJQbDCrhWu8j3DXx3+QOUl5dKe+CaBijsfl4Qku/WhWMtwWj4MTK3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(66946007)(6916009)(66556008)(4326008)(66476007)(36756003)(478600001)(86362001)(6506007)(31696002)(186003)(53546011)(6666004)(6512007)(6486002)(83380400001)(2616005)(41300700001)(38100700002)(8936002)(8676002)(31686004)(316002)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5obnBQQUsyL3NvbUFkUUttSGFEbjVjSHpGYWtJZDhJZTd4UXlJdFpNVUhT?=
 =?utf-8?B?SHdFNVFlZXpkVU9BWmRxNFFkSS9ZWmdibFErdWEvRWdUWG1kalBzQXpSNTNa?=
 =?utf-8?B?VUpDSk0rdGdGVHcxRFJkYk5IYnU4aldoemZDODVLQXUrOC9rSW95MUtVTUh2?=
 =?utf-8?B?NmFJMUhrUzBEc0dZWUVIaWRGdktvTXBpdnVFcXpUeWdWWWUxMFdNVDJCQmZO?=
 =?utf-8?B?MVd0bTlHdHRCbG9nQVkrRDFKMEJ4TWVoNlZncHdwMXpnV3Zhc2dxelhTMEJQ?=
 =?utf-8?B?bVplQ0VMT1lnUzRPS1ZYZVczYWM5anhIOFdlN3BDKytMRWxyQXE1WGZsTUI2?=
 =?utf-8?B?NjFZY0pTaWFzVnVnWmgvWXBpZ0ZtZFd3Yk5KZW8wakQ3ZTFVK0ZYOHRuUnpZ?=
 =?utf-8?B?K2ZtaEc0R01Ncy9ybmVaUVdIMUNVbGpPNU1DVDcrYlJ4WXpaUjNURTRHVk1B?=
 =?utf-8?B?T2hwQ1BIRnZZQWtXUTFBRlJoQWc0T3VOZFdxanIrMXhKbmJVTldNeStaYjdI?=
 =?utf-8?B?L2VJZlgzRi9INU80UEpsOGo3UHdocWJmMGJyb0tFU0FubnRjSXdsa1NXNG5M?=
 =?utf-8?B?b3hOclRZL1dTekEwcU1zeXZpSDlSaFBOVmFoNGtjM29BOHhZVSs3ZkpnNmZT?=
 =?utf-8?B?UzZLRmljME9BaXF5Z0k2bE9uTDFPOFlxOFh3RkdNa2RHdnkvV20zcHZobkxK?=
 =?utf-8?B?VnFPblNyRVhMRlhvSTBveGNpSmtvemtvMFYrdmY3bjN5WVl0S3JXVVBQZjJF?=
 =?utf-8?B?dlRsaGZwaTVNTVJNZnMxRUZsakpSeEU0bnRLVUNiODBRbW5iaTljRkF2dG15?=
 =?utf-8?B?R01YYSs1UTFyOWE0UFRqcDQ2bDhUS01Jd0srZ0lnSitwbkF3R1FrdUtpYXpB?=
 =?utf-8?B?OWcxR2ZVWnRaeVVCSHNCMzNheTczQWt4dTFDdFRVZGRWTnh1Y05Yb2xFUEps?=
 =?utf-8?B?TFhrakVUZFg2alBEbGJ3aVVXTjJLL0hiZzYwRkQ1TlpUTlo1R0g4ejlIb1Iw?=
 =?utf-8?B?QWNuSG42UXNYYkkzUVRuNXBBUENRTGU5aUZOZjJuclV1c2lURFkwY0NscWhv?=
 =?utf-8?B?MmxIdEpPVXowQXowTWxTcDVma2hlblorT0pYVUdXKy9OWm4vc2x2dnVxZEMz?=
 =?utf-8?B?cXpPdWhuR1liTmxOcUQxMndMUEFZMkhGR0h5QXFKeDA5NHlBRWR5NFRQb09P?=
 =?utf-8?B?RTlxdG02NkRGNCtRaHFiTjZZem5VKzdLWjJmOW1ZYUpMOUw3U01xRUUvMmVT?=
 =?utf-8?B?WkJhU000eTZJK0NDcUpTMjhCWGh5Z1RIOHc1eGJyeVp2alE5a1d0T05WRVAx?=
 =?utf-8?B?RDByUHBEVm1wYTkwM3ZQNVhrZ3BwVXg5ZWZnVVhDdVN6c3l5Q0VVZ1FocE1n?=
 =?utf-8?B?YU9OT3FVZmFtcGJZUUpOa0NxL3podTBQZlZkZVRiWGg2b2ovK01ENFVrTVJl?=
 =?utf-8?B?YUdiRGx2V0RYZ3c3UVJKMmVuOFRQRmlQZ2o3WHU5QXBiOVkwVnFzRWx3UGRH?=
 =?utf-8?B?QVprQ25iejkwRm5Nek5OdWxYQktEZXh6aTNlN3VpS2FJTHdRTEliNWtja1RR?=
 =?utf-8?B?cmpKYjhXM0tWM3hIVmhobXYyRys5K2w2bEwyNlg5WXJqamViRDJZQ3pzdUZT?=
 =?utf-8?B?Mm10V3NZbVl3Ty9CNFd3Ym55RTNWL2FORnB6WmNqYlNKeWFRakp2S0N5U1B1?=
 =?utf-8?B?VGtqYXBSUnRQTUV5REQwbU10ZG5VWkh6azJWL2xvYzcrMlRpUTFaR1FKaFBa?=
 =?utf-8?B?bDhqNGErREJ3aCt6TFN4dzdwd2FKQkxnSFk1Tjl4N1dvdW9hSU1xMHUvejh4?=
 =?utf-8?B?UjZ0VmlRZVhYY2grTmFHSENaWmNGM3Fxd09pV1dzNm0vVTVyamx5ZzRQa1p4?=
 =?utf-8?B?S3FlM2tDZ2lwQk1xUlIvR3JrQWEzOC84TjdwZHhjbjNSQkNJeXNPZGltQUJw?=
 =?utf-8?B?clljZzJCenVpZnZ0QWxwcGxnbW5memdiR2NuWWlYS09uK0FScUFqN3JkMHoy?=
 =?utf-8?B?UTNxaUlkbWRhVHdTNWpENFBUUEk2bDdpdHlpWTd4Yis4Zndaa1Y1RGZyVk01?=
 =?utf-8?B?VzVPRWVWT0M5U3NZTGxVOU52UkZrWkV2YS82dTZVQkJoRFN2a2FtWFd3K2dk?=
 =?utf-8?Q?6r3j+4v2Oih7sYlzQ8ecqZRrp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccf7678-66d8-4b59-825b-08db8333e2df
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 23:58:28.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eRszLKf9xd7ZsKpOQzy36T+o1E0Gt6oSEHwxxtkbm8goYYZNNdnKmdTN7edRGkF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8121
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/13 00:41, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 02:37:40PM +0800, Qu Wenruo wrote:
>> One of the biggest problem for metadata folio conversion is, we still
>> need the current page based solution (or folios with order 0) as a
>> fallback solution when we can not get a high order folio.
> 
> Do we?  btrfs by default uses a 16k nodesize (order 2 on x86), with
> a maximum of 64k (order 4).  IIRC we should be able to get them pretty
> reliably.

If it can be done as reliable as order 0 with NOFAIL, I'm totally fine 
with that.

> 
> If not the best thning is to just a virtually contigous allocation as
> fallback, i.e. use vm_map_ram.

That's also what Sweet Tea Dorminy mentioned, and I believe it's the 
correct way to go (as the fallback)

Although my concern is my lack of experience on MM code, and if those 
pages can still be attached to address space (with PagePrivate set).

>  That's what XFS uses in it's buffer
> cache, and it already did so before it stopped to use page cache to
> back it's buffer cache, something I plan to do for the btrfs buffer
> cache as well, as the page cache algorithms tend to not work very
> well for buffer based metadata, never mind that there is an incredible
> amount of complex code just working around the interactions.
Thus we have the preparation patchset as the first step.
It should help no matter what the next step we go.

Thanks,
Qu
