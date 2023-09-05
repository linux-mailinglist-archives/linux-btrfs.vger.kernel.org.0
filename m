Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C66792833
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjIEQDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354651AbjIENQA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 09:16:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0519B;
        Tue,  5 Sep 2023 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693919757; x=1725455757;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZEx2zW62QhvfWDCWwaBix+aJtI2XIf6x8jG6VwFL9II=;
  b=cue8o8XDovLNBVF/azvr6C5rq2KVWvq1SnF4bA423CaZ4Bg3b5ERi5GA
   TMgyfJ7kvhZ0cvE+FpisPSQT9ZBhen689YfGWsTLHsTZ/uocESwomzGkZ
   QIzkvP0KfZn3Q8tIZUXmgI8Pcym6HO+oYfr00myVL8TBfgLvXx31FSkyu
   uNesHtj5GUKqnsMZMJfSVqnION/iivnmLLBJaqR6qXrdWizKar15P9EFO
   sXoE97DPCD8RRx/1GIP1rmhfdIEd0r10dkUHq3jKlfR2c/pVchU0LYRMe
   HLjBBbzElGN97/WgAzR0VKZv0D+c1mzP41GUkJEU4R6K/MDPJ4Size7I9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="376711718"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="376711718"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831249663"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="831249663"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 06:15:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 06:15:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 06:15:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 06:15:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyzGVs1sH9U2U+ex8I3MUXoRCj9nTZITDv0s/7iEIhgAK97nGV1DipHC0WvcMDdG+s2dVLkTRdaXvlVXCbSuAQ5Z/e44Rw7aS9AuIP1+2jfhm5dQzugr4DlUKXs5EgrTqQ77fK/HavRYpf0uyO4qfWl39WxmYwBoTnVnZUruD7MKd4HYg5/wQ7EzBGLgpJ0/XruI79Yju+b2hW4sZ2cRnRi/Q1rF87S6m/KAya0/UEbQSYHYW/wZU8VV+kOIGxNQlChQNNEhyAwN9GiZI8wytLWcoP9KykmA2SwjrwStmTB26abVWGam6piWTsgXR6o7qNvbpncdDSh57ZouW6nijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2oR1VDYynI+S96mMnYOCibYlSH2LoVQkKPPT0tMHdA=;
 b=NTSlQtJvBlN9sHGoogYTRUTcSeHloAL5I5PibDp9QLCrXfGxBAUJrD5BdLjztj7rk7ou3FIdghsm7YsW+C4KmUJ+9EHVd/oeQsJ8K5GmXhi3307bQK9tcdRal5v6EY5tZQX0CQYhyLe+KQIYz9zDQK1Pu3hoD5CrP8YTidKeBAgJ1VUkeizqOVc9DmdUU9TQTON7JROSCMraCuqWXl8B6DENtzsFGuxZ60WDKYR5Nky3nKtFVATImXw/wNLBFOx5Sftgio103IvYcclxfUg2MR4Z6tXMKNgWOacB9ZRGD8NgcXBPJh8VwHJxbXUdnM6Keud8dhy7hSBLZ7FC2dUHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) by
 BN9PR11MB5436.namprd11.prod.outlook.com (2603:10b6:408:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 13:15:50 +0000
Received: from DS0PR11MB6374.namprd11.prod.outlook.com
 ([fe80::854f:7dca:2a5f:b763]) by DS0PR11MB6374.namprd11.prod.outlook.com
 ([fe80::854f:7dca:2a5f:b763%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 13:15:50 +0000
Date:   Tue, 5 Sep 2023 14:15:44 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Linus Torvalds <torvalds@linux-foundation.org>, <ardb@kernel.org>,
        <kees@kernel.org>, <linux-kernel@vger.kernel.org>,
        <enlin.mu@unisoc.com>, <ebiggers@google.com>,
        <gpiccoli@igalia.com>, <willy@infradead.org>,
        <yunlong.xing@unisoc.com>, <yuxiaozhang@google.com>,
        <qat-linux@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Weigang Li <weigang.li@intel.com>, Chris Mason <clm@meta.com>,
        Brian Will <brian.will@intel.com>,
        <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] crypto: qat - Remove zlib-deflate
Message-ID: <ZPcqALQ0Ck/3lF0U@gcabiddu-mobl1.ger.corp.intel.com>
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
 <E1qbI7x-009Bvo-IM@formenos.hmeau.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <E1qbI7x-009Bvo-IM@formenos.hmeau.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::13) To DS0PR11MB6374.namprd11.prod.outlook.com
 (2603:10b6:8:ca::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6374:EE_|BN9PR11MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a001d8-18eb-4cd0-4a7c-08dbae123975
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIN2Bha73NGkFLnC6BmQ7nep5tJM7fT8S1V2FkUgfP5OiJv1YhkS/it7P5vgVv1gXzenOg05CsD9okBiEIjaivvR3j5MyW7VELkbWUBrz1v8z7bZTP/xa7lvPfD1PlNkQ20Uv/5KYGFfwT/SpMQDtw5TC5GbeJFsXva5mEKN5DXA8nsRPyu/KM6bfVrk8nO+JiJr9Y6+Jrec2+S952UQw4OkSQ3BNWiLlKtq41DmrbO3ya1/BEa8W6wkVFps18pS1VriznzLRuXqopyc791FJ7oFbMIlhGiQZRkuihM7vw1RZmQiSxIC0xW5TksPFmxYiHg4/SomlY7n8spY+hoim0WC/SzpOtkJ9sksbMEfMR0Sek1T9AdgWU/TrjFYhekTj4qnH4+T8QWxQkhBLAroUv8bQ0LP4kN1gNAd08ivFOZccHoF6V3Oo7iWqeEtmAcehkMSi+SunXrehMJGgPF3ssOtMW1zXmCC/oDMQaGUGJVsLRHh24zz8j5yqNIFVTN6L1dqEuWnmHV11Fq9RWXpqA2dJ92pN+g7s9dv75L1xkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6374.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(186009)(1800799009)(451199024)(41300700001)(7416002)(38100700002)(86362001)(82960400001)(478600001)(966005)(6666004)(6512007)(26005)(6506007)(6486002)(36916002)(66946007)(6916009)(316002)(54906003)(2906002)(66556008)(66476007)(4744005)(5660300002)(8936002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DsRBpMQBezqr6HYfIcbUjwp+2TD5+po5NLJQjq9uhq4iXCyKyTV+EZyYZ0vW?=
 =?us-ascii?Q?CNHqQFL0VkeGVbP9yovugucQIvOklXWkamV/hjwi1Lek8eeSY+5z7A23eBTy?=
 =?us-ascii?Q?HVZ/FyNxNQ/UQuTCronKodhjrrmC0E5jrtw1elWfhtjnTS/ElCnWbcMnuuvv?=
 =?us-ascii?Q?oj91DhH3CEF0GX63jpFCg4m3VvxKsfDg8xqQe0KQxGtvS+yNUp5qE27sAgJ0?=
 =?us-ascii?Q?SaFv8bScy6Id+63UoHVWPqRbseC7x7rg5PEqTOd3+WwE/dMdKxvN17pXCAcP?=
 =?us-ascii?Q?UIvi+aFZhuWuQyFcQiIbak/72Q7HPXGfilWhQo/AgLgXrqHtueqb0ibgMAKO?=
 =?us-ascii?Q?cR6kITqVnZgpM7XbgD8HVhh26igmzVl7uXshsJVEONXYqPeqMgLmW7B1a6d3?=
 =?us-ascii?Q?t5F3V5EBKov/XaBMjlzdICDiqmz8pUBq33gNXB8m65TyrVvBslEDBgeDBG5n?=
 =?us-ascii?Q?PpJV1qJ1twKVQ+u1MLMci6shisDf5DVAvBlmCOpSN3cMcJgcKuw2yXwSVYG3?=
 =?us-ascii?Q?ggaE4Powlvn26Xs5gwDMME8205I0dRwQ8Jh5A3Mbsw3tQ3/etCshKh3fUqud?=
 =?us-ascii?Q?C+7aY7gqZlEoMIuNWg7ers7bMWYK380EG1BaHouzy3GjynmrU6XXmHgqElyJ?=
 =?us-ascii?Q?2LPFk8mnr4o/p8deBFohiCR41zR/qq8NcACvcgOxesU4YILTzdAAF7+Jkxxl?=
 =?us-ascii?Q?w7zODzh6rtZ1KI3lMnxSCmZAkUkj55mXidiFEeXiuZ6/jqtsnUE46ajRkyLO?=
 =?us-ascii?Q?UWJW7hFZUJDlrNmqMAQX7ur5IXlMYb59UHmXamN46CCnOpvRq0Kcvjmtnb58?=
 =?us-ascii?Q?yYY/k6V0Y+AUYYPJXXJagcUQqK46V6tz/JQQwgwERZkajUC2OYL8SESVFj68?=
 =?us-ascii?Q?22IHK3br7wOShNhlQ6NrihCPHF3+YCFagtPtqj4XOTM9ctGA6VJz7HHkPx81?=
 =?us-ascii?Q?0C/XtUswhPQeQXe1a97MI11yrC2IkKG6MTB5qdn4DY95pgIm4S2xEHDqDfLW?=
 =?us-ascii?Q?JoNc7b+ymaD3sZkQlzXPOWNXKWosn7QP2pcpyC7ulP9kmzqC0hdY3ftPFlpS?=
 =?us-ascii?Q?MyVuecuD7ONg2B1wYkWliUJzRYvOTzCNfmu8d4S12rOTtr5sqyMhUMb2Vr19?=
 =?us-ascii?Q?D4mEnwe81U0uCUYg70jZZePXRnWPsuoOwiFcs/bd/gaTr6x4Uhy56BG9ZHug?=
 =?us-ascii?Q?Bgf8SPydzGEiG8oiNMPmw62FxwJCu7679htza7Yg0K4EdmqYrqaNXMaHQgmQ?=
 =?us-ascii?Q?ABqFmb5UJDwgjjZp5G58GFMEmCf5ITkKaWA1plkHAt6YvLR6KuabJ0nKQ7Hm?=
 =?us-ascii?Q?6xk7qOAJQ5CquU4G7CmALB4G8+XA/TcPIlWXrEboTgeG0p4zxJl2FnEB3b4X?=
 =?us-ascii?Q?LlCJaWT8/tONeT+b7GIaL+Pwm88Enxdc8UOAuQ93z5IxBTgKTPXIU6tVwgry?=
 =?us-ascii?Q?dXb/xnUtB+mbuHHzVoB5CNfzJOomljTUiV+KgjTxV0cSyJy07NURxeyI6dsF?=
 =?us-ascii?Q?hxjkLF3atOBrFrUQMr64T1/tUaEGODkj1zIBIKKBrKox5DruMbVwFJF0ArNa?=
 =?us-ascii?Q?6wnX6Wu0qfWQaFUR1mQFqhmVbAYLeAjVXvuT8u9dRQg2Y0T2lwtwyZmDBJxU?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a001d8-18eb-4cd0-4a7c-08dbae123975
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6374.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 13:15:50.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7upGcr08izs7xMOp5VKe/98aWQLad4U3mQ24R4Rng/2/9Mg+T+CCT/EDKaiVDZzR5GLRPfgL4eMD9gjaznjmqgrFP4iHY42c/KGLRA3vVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5436
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Herbert,

On Wed, Aug 30, 2023 at 06:08:47PM +0800, Herbert Xu wrote:
> Remove the implementation of zlib-deflate because it is completely
> unused in the kernel.
We are working at a new revision of [1] which enables BTRFS to use acomp
for offloading zlib-deflate. We see that there is value in using QAT for
such use case in terms of throughput / CPU utilization / compression ratio
compared to software.
Zlib-deflate is preferred to deflate since BTRFS already uses that
format.

We expect to send this patch for 6.7.
Can we keep zlib-deflate in the kernel?

Thanks,

[1] https://patchwork.kernel.org/project/linux-btrfs/patch/1467083180-111750-1-git-send-email-weigang.li@intel.com/

-- 
Giovanni
