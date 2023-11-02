Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9417DF1A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjKBLuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKBLus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:50:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A5188;
        Thu,  2 Nov 2023 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698925837; x=1730461837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BG9gsSwpbNyKj6e390QNEIYoXJJMHH+Bd20z5WTzO9o=;
  b=LDG69Sa4OsspET3OY1LK1mJNxHRL7hHQihFXXUZJKJE4X4fKh6RPDeMF
   NSKH2i4TnV0TrEga2vGmhKTeSXje7b6sgj7wlx+RXlTm+sFHvWyAQDCk1
   rRIfj2AzEHpvQ0Ex8NnKxBL9iqy21vDIeud9Ai4UQZwjhuPgrE4cJG9K2
   8ZwHL79JL3bRLKyOIbtdB8IC0dKt3Y+49VQ/dbx/YBYh75YtCSgtsJRd8
   a1dNrRtJtB08abNvSXHhHHaSEfg4koqWSCy0LDVcg8cb6EEqqbhi4HLVW
   aFBKCziWc3m8MawpCqvNdUZl9jDQtFYBydj27hfYbY6+woRUMrfc+EmwN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="379087951"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="379087951"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 04:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="2407069"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 04:50:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 04:50:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 04:50:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 04:50:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 04:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXTX8BvSSki7aSrgBtds88TasXGRB6pRBzpDbA7nqLthV0cn49pPYaEpLQ3pVJ4kDBQne9ulW2D5wCMOi+OhmmmMjjLyCVJlM5HytPDraxEGv7roZI2iVNqOkwIEWynnucy08y6CA3pjeM6vLOldy8pY8x+MFgoj6mKKrZt6tVABWpJcfU6v6CiZeVmpFPJzFLabzLKODoNR+gIRT+GgizxIl0Jr+KvYiz31aucHvTX2/2H3ghlDPq7B4kVkefBWd9QzZXg8eR+LZ3fv6pxm4od7oBy91vFfYQN7GuBMWN8htVxeS6ha6rhLh7etQApzzQjrBGM4FRil832DHcSiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HrQ4O5NtmuJoGMOPSGbi/DUOGYUbGaOO0830JqcyRY=;
 b=RYrTE6YrwIRwY1+fVT9CgD9xgYxah+I2Dk/UcocDZbtuoebsMPmRrEAKIZrYjioMWgMH0ic2bdodsQE8GddlPhQzr6RIggdqHqLsUzrRM9EfkUvvk/ffR2U4V8M/523/xfeD2dqNCLTxuPaJnzSGmTBZnSoDFLhxD10WOWp89k3MGmhqVcXb5r1NXcA7NiGPLQkDl0bfs4/WwG8BlFTyxIseAXXu8dnel4bXZTguoFH92bVMCO22P0aLrQ6WkZiG5+wLvA/0qQ7AnxW24MVH8TZcfRAEFWNwsURwnAB+3qIAnk2nKvx1delTKa+QYQkObvKM7hbbop0BATkq0N5ceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY8PR11MB7362.namprd11.prod.outlook.com (2603:10b6:930:85::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 2 Nov
 2023 11:50:32 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 11:50:32 +0000
Message-ID: <17803a27-fd89-4708-a2fe-1c811f6cb47e@intel.com>
Date:   Thu, 2 Nov 2023 12:48:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] ip_tunnel: convert __be16 tunnel flags to
 bitmaps
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        "Simon Horman" <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <dm-devel@redhat.com>, <ntfs3@lists.linux.dev>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
 <20231016165247.14212-12-aleksander.lobakin@intel.com>
 <20231018172747.305c65bd@kernel.org>
 <CAG_fn=XP819PnkoR0G6_anRNq0t_r=drCFx4PT2VgRnrBaUjdA@mail.gmail.com>
 <ZTJy/7PMX/kGw2EL@yury-ThinkPad>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZTJy/7PMX/kGw2EL@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY8PR11MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 179285ae-0dcf-42e3-de3e-08dbdb99ead4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8Et+awQSZbJk/MzQUB9QAnidkgphIZFyfg/lD35xB1eAr+YgUFWi5BcQmA4P4pqlryzqUE9N1hPPQm84iaHJn0bpqQ/jSnACZC3UrKhvbH3XgV0sUR2DnqGfFRWkJD5A7haEsZs1flpmFgEMwr0Fdp10eHQ6/yQY3JkAz0F6zGPtYJHFKkx4oFJFXX8/vivic2pEJNE93oQEIDKAAIMgKU99/a54l9XNVPNAUSi3UkHRFUcPagV6/JZk6fAexTM5tXGhVYYUgFCNKtqSGKVea5Ka3Oklyn0bikoH4NC2O8eoLr2uwIZQsX2baPMwzoo6zzhmqqrkLu317kuB/WSRMt7C2bauXVq79Zbn1r9KNMaqbzWlyoJsfIK1crlqDj1UD37oti2vDJBexh3ZIiUqNj8i1FP/CFihEGA8CCj0OoziscxsEmMwBJDXF4mySxY91zPoMEHE5S0J4BTAuWucytmgnr2wFjUwU+CTVM1gIzGTECMnj7BWSAcZYAiVocb/M+Q5Ll8rOsxD74id7xCK7hz6wqVbXlLwqdcyNq0bOebLoaldjfMww7LC0Xml/18AdRiEgMVX6jrFmqudUHbAGT/HXtpVTgyYCNvJl7s4KpoFaI85IWexCZhMPgbTtwLk/FdqLmlR7esWaM4eiPtRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38100700002)(2906002)(31686004)(31696002)(83380400001)(7416002)(2616005)(966005)(86362001)(6512007)(41300700001)(82960400001)(66556008)(66476007)(316002)(110136005)(54906003)(5660300002)(6666004)(53546011)(6486002)(66946007)(6506007)(8676002)(478600001)(8936002)(26005)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxwRHEzeFlkNnNZTGFDSlBLUkRqRGkrNFE2bm5QdG9hcUFtdW5tYTFhTWVO?=
 =?utf-8?B?d0FLUDkrVUE4MXQ1ekhzRW9QWlYweUpBTWtCdTMrb1FqZmFGbW9SbmJYN0VC?=
 =?utf-8?B?R2hrdXZkekltU0s3Ti9kUUpaeTk5Qk11UFExUjZJU0NQd3ArS0xPT1V6WlJu?=
 =?utf-8?B?S0RLanFVZThWc2pDaGJJK29lcjEwdmpFWk5FYVFXdXBRS0RQQ3BKRjNaa29C?=
 =?utf-8?B?anRCZXh3a2VheFJOZWpLOHVxUUthcFloLzR0WXY3VzdBUmcyVkswNy9yWVZD?=
 =?utf-8?B?QXZIZ0VlT2VOb2UxbVFiQklWK00wTzRMK0k1VE02Qk4rWHdEbWE5NXJ2cDRi?=
 =?utf-8?B?emZqVFBsU24zVFcrTGJIVFdQSlpFdFBDUnhFOGtBZlVMd3FPKzV5anJ3a1Y0?=
 =?utf-8?B?UVpZdWplanQ1MkZOeHE2ME9YeEpVYWNGdllndk5kSFlRK3djVDFsclJXUU5K?=
 =?utf-8?B?NldoUXlyUXk3TkFKQW9IUVdKek5WR2tWNG1Hc2JJMitMT1ZIOU5xaEwyaW5U?=
 =?utf-8?B?dmFiMkp3OUdUWFp5S213akFUSStpVEg5aVp2OUhSNzVZK214TmJMRlZzQ3FE?=
 =?utf-8?B?RVN2VnhQU0tpWitVWk1kTUZMTEZ5R3NMNkZTNDlzQUo5U0dCdVdJeFgyTkdD?=
 =?utf-8?B?Wks0em5jKzNTcTdSK1h4ZWh3N25JdmxXdkJld3p3cEszOFo2STVIaTQyMGFq?=
 =?utf-8?B?WVZBNVBjUWtqaWZiejZjSjJxRUNVOFVCaEduVWpWbmhtV0VyS1lqNmtrOWJo?=
 =?utf-8?B?WlQ1UzlYZlBncFNHdy9QZFRSTnFoclB4bHFtQmc1enJTd0FzV2tLeU9XRjFn?=
 =?utf-8?B?NlVjY1AvTmxyWWQ3TldJWlFhWERVK05sWTIxbVl6dXB3R3o3VmkwejRWK0ZO?=
 =?utf-8?B?TkVoNjkzcktBeC9DM1ZET3dJbm9ubjNPci9pS3lTZG0vNzVUdmhVaE1GR3Vu?=
 =?utf-8?B?dGVtb2hVcmJKTDd6M3ZaMXdxb0NzM3p3dldteldMdjdtUTdkbjhVaE42dnFo?=
 =?utf-8?B?TEdyV2pKbXE1S1N3MkxueXk0QW9Celhlc2kvSTcyUTlPeWdsb2xmdExtU2c5?=
 =?utf-8?B?Qng5Zi9FN0M1UmdvK21mNHRPZVIrcVY1U1F1ck1OYmU3WThlZUVOejh3Qjdi?=
 =?utf-8?B?eVhtL3V0NVErbGRVVXRhYUNmVG9qb2JiUDNJdlg2UjljYjYwcHRMTWFnc3h6?=
 =?utf-8?B?VWFZNHk4NUMyeWhGWGN3cGRuVFVkVHRCTWFOaHpYRjRBZU1YUVZIV2hOeTdj?=
 =?utf-8?B?emdJdUZ5QVkxb2VpQ0dlK28xUXV6L1NnbUdIUG11RVRReWEwaGtWMTNIVjNH?=
 =?utf-8?B?YWtzTUhhK1ZOWm94NkNKRUJpbVR2dmJ5Q2MrQzN3OHpTOVRrb0c3cUdOQldz?=
 =?utf-8?B?OHpsQmRMSy9CejFRTXN0Tk1ac0V0VDdIcnUyUXhjMTNoV1NPcTV3c21zZlhp?=
 =?utf-8?B?YTc2b3Y1R2VGMG1KU05QSGZoTzZYVDNYQjB3b2t0K3Qva2dCRTVEL3VMb0lP?=
 =?utf-8?B?UUR4czNtWVdya1NETXV0b3V0S1pCcXJNNEUzWkdwNHJjSXVsK0lSL3VqUHlF?=
 =?utf-8?B?cG5YQVRLeC9EVStORnZaZ285bmtjYnlFUmhmdEVJZjVFUjM5R2ZJRm4wUXI2?=
 =?utf-8?B?MHU3Y1lGOTVhVnZnM3IvcUJxZ0p2VFQ1UWs1UW9kTS9DYkdibkxJaUFBU3Qy?=
 =?utf-8?B?Rm50VjRJS3hxLzN4d2FvTFlHMjdPbzFXbWlKTXllTWVaNUloR2lkaHRpbXdL?=
 =?utf-8?B?a2FOa0xsY3E1SEFLeEtnbmE3dlgzSm9HYnl5R1I3RjNpZUpMMERYb21CV3ND?=
 =?utf-8?B?bit1KzdBSGQ0V0VkWXFINDNnMGtXcnJ3UldQNzJpZWQ3UDFaUGZITGN5WEJh?=
 =?utf-8?B?L2c3enNzbVZBcDlzaDAxRGZLSWRQbnZmSXF3SXE4R0FoVXVzU0k3cEc1UkNM?=
 =?utf-8?B?TXRqRjNpSWVhd0tNQjNNRStRMzdRRjZsdHY4VnNza0NFVmJ3N1EzVEthZDlL?=
 =?utf-8?B?MStwNDJaMVJUaEd0cE81WWRxSUwvVVlSZzY0cE1IZzYwL09LT3VZekVDT3Yr?=
 =?utf-8?B?UTBvVEQwMVlreHplOWh5bkFWVWh4N0tEUVRRYjIyZlZoVHJteU1aemxoQmd5?=
 =?utf-8?B?UUczcitYejcyTy9CVnBHcVNpTjRaS1ZhdkJ0MXRqUUtEMmpmR2xudTlXczNY?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 179285ae-0dcf-42e3-de3e-08dbdb99ead4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:50:32.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0I+1ZJfU+Ha7B8Hantqic4ePr7iQKJyuXnLteLtpkXTl+zxVRYDa0J/EvKuW+459Qd3WjKOziH3l0FX41NwhmoCpd54N/roTf7CCGfJ1/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7362
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Fri, 20 Oct 2023 05:30:55 -0700

> On Fri, Oct 20, 2023 at 09:41:10AM +0200, Alexander Potapenko wrote:
>> On Thu, Oct 19, 2023 at 2:27 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>> On Mon, 16 Oct 2023 18:52:45 +0200 Alexander Lobakin wrote:
>>>>  40 files changed, 715 insertions(+), 415 deletions(-)
>>>
>>> This already has at least two conflicts with networking if I'm looking
>>> right. Please let the pre-req's go in via Yury's tree and then send
>>> this for net-next in the next release cycle.

(to Kuba) Sounds good!

>>
>> Yury, Andy,
>>
>> The MTE part of my series will need to be reworked, so it might take a while.
>> Shall I maybe send v8 of
>> https://lore.kernel.org/lkml/20231011172836.2579017-1-glider@google.com/
>> (plus the test) separately to unblock Alexander?
>  
> You better ask Alexander :). No objections from me.

Sure thing, I need some time to fix the series tho, so take your time :)
And yeah, I've seen that you already sent it.

Thanks,
Olek
