Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D147C4F12
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjJKJe5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 05:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJKJez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 05:34:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6DA4;
        Wed, 11 Oct 2023 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697016895; x=1728552895;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WfuJvMhot/vVl1jOI5C8xU5lwZ3qeTbNvWh1PPnMDbE=;
  b=BlsHChk5OUxQt669GHk1jJNYHUESCSz3hS69LKPmHdWTB1yAfyP03Dc6
   FYUzarhrHFbdTtRPQEeOjQts5IsQE1oij70mIIJSwWeJ9LMqHdLoAksS+
   QzwwzjOP/4qjR3XW7BIWbMuAOrivRWADOkJyNv7mTPlFtWrJd7nUNdsHE
   joBJjQN3Ba4DS58G9fb0IruGOTtkvsorUaKuf1CGAgmhqi640RZZd+LjR
   bYGmsll5NWZDsLjgdcUWolYchqqpzI5W8pVm0CqvSCG7kKPUL6NOL4I63
   /T1w7aalFmm5rDX79DzTpA+he7ijiogW01Gtyc3B9SUdRlLohh+oxGeap
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="6179268"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="6179268"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 02:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1085158738"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1085158738"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 02:34:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 02:34:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 02:34:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 02:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBcek6/uqhez6ughAZ3DthRZKeEtwMjZ0ZSe7RT159FDt04g/dMjoxec5TOLp7lwxs9y1ZRi1PFiptKWAYO/q2VG7uCfnfMBwXUb4LIagwv2VxAEOFocBc+Vwc3ARsol+bMo/wOlGjmbN9zVarq+Y9OA2QbLZfhLcLBod5GQJhznSGOwUNPTuodQJCZO7XoyfEEfiyrsAKNyGhq7rErPPWOQwxxw6EHaoshKl/kGDOP9zVjdbOLeeSy00C4bKvXO/IM2QnL6Nt5dr2tewzmGxFz7pJ3FtQUXkqTb35O5ZYCX4auaPoPXxBepzCpGvdvx53TOr2jRNjaB5sQidqUMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa28NTVhibpLikBeuVemRJmO1y2Z+B1GpnjyDlQBlIk=;
 b=O3KupCVBkpOplYtOfjviPsuLVj6bgwFJNQ1fzfNysay9ulhOD/b+C/+h190DTc2KAOKO1nXa1KE/du7uDklaLLtV040646JTUZvPwLtuOxFQkmuPlDTDYItTe61cFJbkv0ZtmgEc8VMBbBlEvjAOChOwDar3KgesfGlLZglNtWu9h0G7yCW715qU+V/SS5iEeBPaNcoZWatwWsF7nw6hgvwQJkk/fD4r0Jfj2ABOELEuiB0ZOA66DB4eCOcYMbwdggrAY6SvwL4el/itorT6ZYxxs07XNmM3C4PkgjjRYi/4js0c97yTVryr7YG/JDFZU7bJw/TKFoju6bIl+ILVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB7919.namprd11.prod.outlook.com (2603:10b6:208:3fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 09:34:41 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:34:41 +0000
Message-ID: <a28542e2-4a5b-4c29-9d4a-12a0d2ab5527@intel.com>
Date:   Wed, 11 Oct 2023 11:33:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] bitmap: extend bitmap_{get,set}_value8() to
 bitmap_{get,set}_bits()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        "Simon Horman" <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <dm-devel@redhat.com>, <ntfs3@lists.linux.dev>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-10-aleksander.lobakin@intel.com>
 <ZSQq02A9mTireK71@yury-ThinkPad>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZSQq02A9mTireK71@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f434655-90e9-432d-7679-08dbca3d4b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1peSp9ZxEfvvylkkrrpUHil/AHeU7G+7/Y05Gw8rzb/uzCwdrYD4Wkt59HSUOcZ0hHJJp3GoZgDwviFCjNgSQsvcIW2PDqB3TPy4qT4DAjsuX1YZKZeZvr1I16DbtXMankM3EvvCFA4DDl27//topzfz9NEG6E41LIKubhr/quiwb56J8zzBUDU2gGOQiQBjdxMObVD+BeXi4wmFjdzoRCm/NBgFlhqh6x0eiwtrvSTLSOXbcWHNoEPdFvQetfS0VZW5iEjFAd0527pX4Y0RkQZJEhbAIno1953G28vdTX7Fv81KmDWORlxXKOuWrdNzaeWs9cv5LJzSxd6zB65x8F3rnagSdx/tHy/sy/Gi9q4XVMCgy0UnOIOrEu4GUK2OdRZbCntgoDnZCh+BkRVCUFkXfhK7ZoJFcvE4lVrzKEkZhCxxLDuEY1I4CmUktJ2Iyt6lr09AWSsPuZ0D8hpX8z3NpuWdZmG07wPBfLXBP6vTWUCm+SEMsHF0At0uY2pkK+uyYEsU2S56ndTdSzIqM/9TFqgf4TBQ4AWJ2ZbAI6BtDPaPxUs42hVV8JZ3vA5uIgugqFMwXeiE4Vq7G6ojDRx19mErsQx6mX13lThRwDZCAF2euuYiE0maHUl6gJHAx6MqdaflQdXscOc0vk7XqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(6512007)(6486002)(966005)(478600001)(2616005)(66476007)(316002)(66556008)(66946007)(54906003)(6916009)(8676002)(8936002)(4326008)(6506007)(6666004)(41300700001)(31686004)(83380400001)(5660300002)(7416002)(2906002)(38100700002)(31696002)(82960400001)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmlFaFRVdmpYMnZ1QWtrbVBYSmZpVEVGZXY5UGJDMDVBQ1dOUTlwMkNmVkdX?=
 =?utf-8?B?a0NFVmlJQ1FQeEVtcEwzQ2x0cVJRYUJ5TlplcFFWYzZBeENlRzYyS3BhM3ZP?=
 =?utf-8?B?cmJMVi9WS3lCUGc0OFR4QVNMWlZRYU5JZzh5T1hUem0xWms3VFVtVFhCNmNU?=
 =?utf-8?B?OExZMFN5Sjk1TDlNQnRrOU5EczBPRjcxVzFQdjd3aFl1cUlEUklkY3YyOGVL?=
 =?utf-8?B?dHVOTytBRW9FR1g0VGFEb0hOT04wTUFab2x5U1c4WkJZc082ekt4MlZ6eU12?=
 =?utf-8?B?WlAzZndsakFCRFUyZ29PdXg4OWsvSjNURVY4YjhQd3B2SytDREt5cmNVa2Q5?=
 =?utf-8?B?MjRQRW92YlVPY3p3dzc4Rzc0Tms3WU42dkNNYXozMThPVFpleGhTYnJ0d0Y5?=
 =?utf-8?B?K1ZycjJmY0k0M1Z0L0ovejdvbnFiVmdxVTVIRG9VbXBodGkvbXcyZFAzMXBJ?=
 =?utf-8?B?MmhBRzJYbllPdmZlT2d0ZlJIYlR3aEluam01em1VSlh1U01JcjF2WHdxWDJ3?=
 =?utf-8?B?dUdlTjlWQm1BL1Zmc09ibzVTK3kzN3lmQWx1dm4zaWdhVUdZMVExVVNkUWVj?=
 =?utf-8?B?ZmZMOTNaODFRMW5EMzZkeHNIVVNTd3E3ZTd1M09hdjVYbTRqeHlZZHBhTDU3?=
 =?utf-8?B?clFFUmsybTVoQys0V2oyRW53dFh4K3dBaVdqUTA4TjRHbm5wMnJJY0hxdWly?=
 =?utf-8?B?cWlQbGdnazJTSi93bVJHbnhOOWZwMlRCaTFiY0doSThwSjIxUE1FMmEvbk52?=
 =?utf-8?B?VU9ydU1FaFdOcmQwaDVqQVBZNCs3bkxPVzY5L1JuRVN3OXFxNmdwT0ZEaUcx?=
 =?utf-8?B?U2hodStwVHRrNjE3SDI4blY3ekRQM3dtbWx2bHpOSWRPNGlLQi81MFNiWWo1?=
 =?utf-8?B?T3dLcjhEYkZwdWExNDcxcGl4c28xSHVMeUpCY2s1d2VwMnhHWEdCeExFU0t2?=
 =?utf-8?B?LzRrZjBnOTdhZzloVlo5YkxPMmFFSUF1S1FrWkN0cG1PZm9QQkFFelRpeXhO?=
 =?utf-8?B?dWRNR1dvNFFPWnlDRzhmUlNYcUFLWkdwZjZ0VUdiUFNZK1pyMitQNFdLcWR4?=
 =?utf-8?B?TmhYeXVGVitubnJmSFBKRHZtN2ZMN3FzZitxK1ROQXZsaGlYNjBXL1pWNG9q?=
 =?utf-8?B?RVNjKzh1V0JrellEMDV1M1ZqMHB6c2ZLUG02b2QxdmRuL1M4OUdMUnFGSENY?=
 =?utf-8?B?Ykp5c0JMREM0Rm9nRlFud2Y4NGd3cCtSQkd2VzZ2L2pyY1JLY0N1V1hSSEFx?=
 =?utf-8?B?ZWZPM2drdFZsaHJ5RUxZNm15S1RzTFBCS2daTXZTeDFJbi90WE12ZTFuWEho?=
 =?utf-8?B?SkFiKyttRlZWcmtpNzhIKy9SdldyT2RvM0F1VDAyb2gzd2ttNW9LOHNkMXUy?=
 =?utf-8?B?T2JJbWhWR0tEY3hleFFJaTFrSit5RWtLTkxBNWhYS2RMNmxaV3RJYmVteHBP?=
 =?utf-8?B?NUlEWUd2empLSTRjbTFiYU5PRGI5aWFuNFZRbTVseXJvMHJ6Qitkb2dVSi9t?=
 =?utf-8?B?KzBMaUY4QmdpdnlCc1YzQVRRYS9Lc0VHVXVGRHh1aDQwRTdmWTNTcmJ3MDB5?=
 =?utf-8?B?SUdvYUJvMUFIcTk0T21IcmVFdVhPcjRLVXR5c2ZxNnNlNXJ2b3F3RElzTGRz?=
 =?utf-8?B?RkQwZzFvVFRmOFdSbitmbHVnVWpPV2ZHQXp0dytiTlNIVEF2QisxWnh2czlh?=
 =?utf-8?B?ODBJZ2dqcGJKYllEaDFmRVhCNG1MWjRRWjdiWFVQL0ViTE1PWnRoUmFCOXN4?=
 =?utf-8?B?MStyNDhLeFhaeWowUGJ4aGkwa3FZT2I1WDRNZVlLREUrUG1wT1RlSS9KcHdH?=
 =?utf-8?B?SUtMbUc4bzNDVTN6LzBYVFk2K0ZyNXhST0IxcTVLbkkybVVxYklYajJGM01q?=
 =?utf-8?B?REJXT3d3ZXF2cVhxMHFUa3F2M1F2WWVzT2dTbU9IdzdKY3hCR3VIcGxLTmhH?=
 =?utf-8?B?cHp5NWN1cEZxTzdERWhBc3JiS2MzSlZ5UzIvZmQ4U2g2T0JRZWhUTWlzcGJU?=
 =?utf-8?B?WU9jTEhwM1NWbkZYR1YwelVOVUNyRGJEWVRBZmJVRE5ncUdLZlptQ2dwY1Fs?=
 =?utf-8?B?VWp0ak1DOHN2RFUrQmVWS3h2NWJOczh4UXIzK1hwbTVaeVpCZHJMNitYQjJJ?=
 =?utf-8?B?YVM3VjJSL3RmOExzTURNb0FNWjkweFBLQ09lRndqL3ZYN0FabDNnT2VmRytI?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f434655-90e9-432d-7679-08dbca3d4b60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:34:41.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhAoJsJisUP5FiLarYDQigJLovwkkuyrc/0B/QAJra2/OdLxT58BFXR0K6mwd9KsnvKuAHcF26qQsW3s5R6wfyDR4n7+1EcmrGKvrfy8El0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7919
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 9 Oct 2023 09:31:15 -0700

> + Alexander Potapenko <glider@google.com>
> 
> On Mon, Oct 09, 2023 at 05:10:21PM +0200, Alexander Lobakin wrote:
>> Sometimes there's need to get a 8/16/...-bit piece of a bitmap at a
>> particular offset. Currently, there are only bitmap_{get,set}_value8()
>> to do that for 8 bits and that's it.
> 
> And also a series from Alexander Potapenko, which I really hope will
> get into the -next really soon. It introduces bitmap_read/write which
> can set up to BITS_PER_LONG at once, with no limitations on alignment
> of position and length:
> 
> https://lore.kernel.org/linux-arm-kernel/ZRXbOoKHHafCWQCW@yury-ThinkPad/T/#mc311037494229647088b3a84b9f0d9b50bf227cb
> 
> Can you consider building your series on top of it?

Yeah, I mentioned in the cover letter that I'm aware of it and in fact
it doesn't conflict much, as the functions I'm adding here get optimized
as much as the original bitmap_{get,set}_value8(), while Alexander's
generic helpers are heavier.
I realize lots of calls will be optimized as well due to the offset and
the width being compile-time constants, but not all of them. The idea of
keeping two pairs of helpers initially came from Andy if I understood
him correctly.
What do you think? I can provide some bloat-o-meter stats after
rebasing. And either way, I see no issue in basing this series on top of
Alex' one.

> 
>> Instead of introducing a separate pair for u16 and so on, which doesn't
>> scale well, extend the existing functions to be able to pass the wanted
>> value width. Make both offset and width arbitrary, but in order to not
>> over complicate the current logic and keep the helpers as optimized as
>> the current ones, require the width to be a pow-2 value and the offset
>> to be a multiple of the width, while the target piece should not cross
>> a %BITS_PER_LONG boundary and stay within one long.
>> Avoid adjusting all the already existing callsites by defining oneliner
>> wrapper macros named after the former functions. bloat-o-meter shows
>> almost no difference (+1-2 bytes in a couple of places), meaning the

[...]

Thanks,
Olek
