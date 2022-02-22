Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D84BF31B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 09:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiBVIE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 03:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBVIE4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 03:04:56 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD810876F
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 00:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1645517068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PthaI+P7A6uNyC051u9Xrok+FU5MJzVOYMB0saWfU8=;
        b=EGOtXWc6Fh/Ko6RuSFulUfeUzHOjlJjTT4r02NIPVmjInAcOJSjESFGHgQNMQf/cEXmi3E
        7/Ygs5WdaKRj7rH6WNtAWlp6ZC+lSEBbGhxRi/pxKxt17NfSBotp4DadM/56dPg+wk+MzY
        roGPfzWflzTDhPh+fnljaK2/fXxvCgo=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2059.outbound.protection.outlook.com [104.47.0.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-n_HBl-6jNyOqggD0_zRtRQ-2; Tue, 22 Feb 2022 09:04:27 +0100
X-MC-Unique: n_HBl-6jNyOqggD0_zRtRQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHGDI4VJDuzkY38CZYjq94hLxA0khBLlSxyLsVN+MSnlBjlk+bno2JkUlifduZYMoJjvMcjmedDPz4A3d2kjyUIGBoYWXNuLhAFP9DFjzL4wmw89hDafIxLYEJYd8DLOWu6vaA3mqUDQEreDrCpPbpMYndiqZCJYQSQOxyFRQFi4vdvOzGBq6XeajBj/BLcE7g14lWdssMbydaHNYK+/YzwayGPNtTg4RXbEiUfr81DLxDMVEVRkDOAeA+V6nJs11VZEEp1df9F9o6bTjKrxXYYWmZTQKBVMZWtfWM3StKMDwOiL9Ucy+Lk+QqGxbp0pxgSeG4FpKya+vuxBu9tQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PthaI+P7A6uNyC051u9Xrok+FU5MJzVOYMB0saWfU8=;
 b=Ol0fCw7hAq1hMLD28u2PO0+V1OEi7FuInfp1Z+oJk+HrPgjnUe4KD+/wentHV6WGUZQ8nmSEwoLZfthQxBBFbMnI0oSJChGvzrcuquOh1iNagcJdGp8wdrF7GCsohGplf8BhaGrWwl5NMiBNbHE6a3oJw+FbIJM4VQKanoSIqqFjAWgxIwpfCtVWgQbUbUcZlL9yEOcbPCOss8mmik18LO+OZTndMSBGn1dEnrFFt8TILlgZZR4NoE+hfeYZROkPKHRB4zRJtqfqMfVY9Nf6edxCA8VAuDb/M9TRFa3JLZBi0tzEDSnI5HtjzZyl1oYHCYppXEjLVmFV+6sPd6MFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB3PR0402MB3865.eurprd04.prod.outlook.com (2603:10a6:8:12::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 08:04:23 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:04:23 +0000
Message-ID: <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
Date:   Tue, 22 Feb 2022 16:04:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        dsterba@suse.com, nathan@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20220220144606.5695-1-jrdr.linux@gmail.com>
 <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
 <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
In-Reply-To: <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5464afe4-d629-4593-da6f-08d9f5d9efa9
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3865:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3865425CDEC88AFA5D4CED99D63B9@DB3PR0402MB3865.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSceuDqObbzVEdI6tm5nkEaAYnegSmHbA7vmlvTtMHCABLL80383WeUj31tMQ3GnAPpam4iJ0Fx4BuumQEtfmBkOThfJ0htBio9i7/GKwJjVL1EG2nxhdUJB64QMqsp7BfwwGurXKEnoxB1FH/kpvMRhKXKuVhWhHZ3IvgYTFgz6X8sRWKm0/dT4xndFTLsFy3Znw3z8gNPX/lc+4VHNqRLRF06CO2d9UVdt+RneCMGHjMJG9WU3vj5LaTBvIR7/RWrf1Kd3OMeC9alWN9QMTMMeiSNJ1pn/KbQw0SuSOHpM2B71SILMSEdE5OvTVkEfPDlTSj9AwPCMm1GLzh5a6uPQ76PbJ25o6qp8Xg0CaphZzQUHnT6SPDlJ2/D/1W4msScEmbaJbKQACPW1TF1/3VHDZPUhBv4PYR0a3MmCA1MdGxtFxnZm00LPq332aPWaS7wtjsfSOdczg4zKXlshdF/O1Dd+qUzsusHVAtzrYvFWTAvpN1psKvk6XqKdgkwCENCvJKLIZkNTKq9vflCy1/CQhGRYCRQBubMMM6l7qFZuhO9lW0I8lVsVf5cbPn+VHmklrkbvp4+wqwGufDtiYCKpiVyFl6tQxvW4QICrsxRJHhclDz5CoYC9Q6mEWul7iIlOG2kOblutbbGnFXq6c1zzaNSGbj0Nc7Ji336hwU58cJ8euLk1tLJ4pfoZwGitFMIAWqOMPZFMME0TiuJd5Z7e5VkQ16MOnElHyAMHkXPdC+guhP+70bW/6J+AOm67
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(316002)(2616005)(186003)(26005)(2906002)(36756003)(86362001)(110136005)(83380400001)(66556008)(54906003)(53546011)(6512007)(6506007)(5660300002)(31686004)(8936002)(508600001)(7416002)(66476007)(4326008)(31696002)(6666004)(8676002)(6486002)(66946007)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW91N0s3R0k4QnBGYXZxZVduMmEzZUN3aSs0TDNyQmpVa0lyRjNUZjY3YXFu?=
 =?utf-8?B?V1N2bDdUTjZBKzNkS2l4Q2Nkc3BURG9WL2hkZ0tEaGVDUjZ2Z3JmdnphajNs?=
 =?utf-8?B?aFR5elRQbDY4ZHdwT2NGWDdqUk5Ob2ZQQWJZL1o2K1RwOHhXT2htMWVJdC9I?=
 =?utf-8?B?SXdXaGxHMCt2SjgzVCs1dHd4cDV3MGlVdEoxOUdZeXZZbEE1RGhXZVpadVJM?=
 =?utf-8?B?TGNzaitncHhCc1FNeEN2SlBPMEwveEI3YTlJSHozNmJDelFWaUF6YUNENkFZ?=
 =?utf-8?B?MG13bDhnMzZ0bk5ZelM4WEZkcGFaTEFVR3o3Nk9JZWlWcC9mMzUyQmUyQWR6?=
 =?utf-8?B?ZER4Rjlsb3Vaa2xMczlUM1hHZ3g0b3U1RThGZ3U5NnUrd3JVNHpaMDE5YmFk?=
 =?utf-8?B?eWNwZVQxZ0NJVjVObHA5R1dLdENzT2UzbWd0TFJDT3liVlpISW1PSUEwQ3I0?=
 =?utf-8?B?QUFQUWpMTmtLTnU5TmxZSXgrN1B6WVY2c25GWTNrM0RFSmQvZFp6OU55MzZi?=
 =?utf-8?B?bkJ2Y2pzZ1QyRldFYlJaRmQvdjN4YXkzNUVYd1NqUHludkg1eERUYkJlbkJt?=
 =?utf-8?B?RXM0T1J0RjZaVC9ka1Y4Z3hSOUlGbldQc2NhYU1rU0M1eXJRVC9iNFBRTTRk?=
 =?utf-8?B?WXpvM0cyNy8wdVlYc3ErVTg4Z1o1RnplbC9oK3B5bWIvd1hOWVlrVGwzWkdm?=
 =?utf-8?B?ZFJGbzdHV2NCZDFjQzVwTTBnQXRoTFRRbmM1T3RobUMvUzVQVXhsTWROSVRl?=
 =?utf-8?B?VUhtdGY3SnBsT1cxQURETnJlUHRkNGlUT0ZsQWJkMHhOUzZwZ0VoOVhHQjAv?=
 =?utf-8?B?WlhtMzJJTDB2NDAwTCtjSVlvdHJmaWJ3THIvSUdLbXVEL3h2cFZSZVpReDUz?=
 =?utf-8?B?aWtxL3NKWVkzR0pOWkU2TGFXa3FFYXlEVEhCMXBNYjVQc0l6MFlWdmkrQWxI?=
 =?utf-8?B?RVBYZVpkQWpvTE43dytER04wMnhhaGxvWmg2VndqdXUwdzVaOU5ONENkR1Ns?=
 =?utf-8?B?QnJTaitPVnQ5cVkrTllkVFpMY2xoZDB6VVZGTWZYRlM4aEwvT0hmbHhvdkU3?=
 =?utf-8?B?V21LOUpKcHZKNjUyZFJXM2ZaTDlLY3V2cGp2bWpoVEpZcXhhWGxkWHMzNVF5?=
 =?utf-8?B?cGovQnF3N2xYUC83WlJsbVZvdGlIbGJyb2hIVzh6QzJpUDlWYkltclRkZDBL?=
 =?utf-8?B?SFBaZjdrTlRWUGxRYjJBUTdyZEJSZXFHSXpiUHBhUHdzWFYxQTZBS0VXdFFh?=
 =?utf-8?B?NWZ1ZE9lYlh5VjJaZHMrUjlQYXRWblhZS0d2SkVObXR4bE4vTkJjeXd2eHhF?=
 =?utf-8?B?d3dZTTV0eFhtd1FGbklIVTdGVXNVWjVSV2VhZnRSZTR6ZGdPYU5tdnhtWkFy?=
 =?utf-8?B?Uko4NjdGYTMyVm5WaFBobEJiT1FQMFpNOVpRZEN5Rmt2WmlhcGNGdDhDZTlT?=
 =?utf-8?B?eEk4QjNmUURGK3ZxNkN1ODNWVFZMV1lUSUNidjFUaXlxbmpOZ2E1a1Q1bVhL?=
 =?utf-8?B?dXh5VWZHWm12OXRveWNQVTZSbDdyUlJoR1FxV3h1Q1d2djdZclFBQWNRTHpX?=
 =?utf-8?B?cDdLMHRCTmx5enRrY1hudkZJYTd6Nk5VK0xGdy9oc0Z3amhFM2JhUWtJNXIw?=
 =?utf-8?B?WHJ0ZnI4K2dxSXo1eXg1allxbTZNTkRVRmpyV1RDaUZnVEg5YmJMWnVLem90?=
 =?utf-8?B?QXlkTHBJT2pJL2xsczdPd2pmaXlEbTVXbFJ5WDZZSDBGOWhmQ1BJVGYwVTVv?=
 =?utf-8?B?ZnZvYmJxcXJ6cXpITmd5NGdKdjlYbGwvVlBJdzkrQmNNMi8wanZFY0t5dHl1?=
 =?utf-8?B?Z2RiV2FKL0pMV1JaQ2xDKzhGakI0R25UY1FIOHFJbWZsYS91dUpFY0hLSE1h?=
 =?utf-8?B?WU9CWVc2bzllYmtzVVcyaUs2bjdWQVdWSEhVVldIV0xTR2Q2ZGFtYjlQV0Zo?=
 =?utf-8?B?YmJlSkZNVUY2eVNzWmFqQkJHNUxmSWh0dXpEbjUzN2NPdmk2U3NGSURZT3Zn?=
 =?utf-8?B?RlF3Zk5hWGQydmRUNEtjRUlEV1RMbmMvYVczWkUvMm5rVVB3ak1GRk5CTGEw?=
 =?utf-8?B?a1duZ1JJUUY1R05XeW5UOVlpRXltZFVTWGcxbVJCbmtSZExpZEh3WHAzV3dO?=
 =?utf-8?Q?WJRg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5464afe4-d629-4593-da6f-08d9f5d9efa9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:04:22.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSSrNhrKw/Jmk/GdsCbElduD1Uh+WA27u0WoaJmHQ8+dh864hBszfkr41CUrhvTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/22 15:50, Souptick Joarder wrote:
> On Mon, Feb 21, 2022 at 5:46 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2022/2/20 22:46, Souptick Joarder wrote:
>>> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>>>
>>> Kernel test robot reported below warning ->
>>> fs/btrfs/scrub.c:3439:2: warning: Undefined or garbage value
>>> returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
>>>
>>> Initialize ret to 0.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
>>
>> Although the patch is not yet merged, but I have to say, it's a false alert.
> 
> Yes, I agree it is a false positive but this patch will at least keep
> kernel test robot happy :)

I'd say we should enhance the compiler to fix the false alert.

Thus adding LLVM list here is correct.


To me, the root problem is that, we lack the hint to allow clang to know 
that, @logical_length passed in would not cause u64 overflow.

Unfortunately the sanity check to prevent overflow is hidden far away 
inside tree-checker.c.

Maybe some ASSERT() for overflow check would help LLVM to know that?

Thanks,
Qu

>>
>> Firstly, the while loop will always get at least one run.
>>
>> Secondly, in that loop, we either set ret to some error value and break,
>> or after at least one find_first_extent_item() and scrub_extent() call,
>> we increase cur_logical and reached the limit of the while loop and exit.
>>
>> So there is no possible routine to leave @ret uninitialized and returned
>> to caller.
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>    fs/btrfs/scrub.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>> index 4baa8e43d585..5ca7e5ffbc96 100644
>>> --- a/fs/btrfs/scrub.c
>>> +++ b/fs/btrfs/scrub.c
>>> @@ -3325,7 +3325,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>>>        const u32 max_length = SZ_64K;
>>>        struct btrfs_path path = {};
>>>        u64 cur_logical = logical_start;
>>> -     int ret;
>>> +     int ret = 0;
>>>
>>>        /* The range must be inside the bg */
>>>        ASSERT(logical_start >= bg->start &&
> 

