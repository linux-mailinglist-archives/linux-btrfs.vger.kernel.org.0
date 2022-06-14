Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A954B754
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiFNRHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiFNRHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 13:07:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D110579;
        Tue, 14 Jun 2022 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655226466; x=1686762466;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FJHj4D8RoHdg4/8+H1WeSmdT+eEmf7CsSbx9ZPYnWVA=;
  b=ebsdpXCfmYKZO9P9CtKx1DaIDy80golMPpFwTu5CFMD7oN79A6ZNE0YN
   EauoFPNFIho/JFFBdTIFH0uY2DsYZqS5tQQjB5McrPdBk1YBmP2DwRrHU
   4x9uWeU7C+vh/lESXizOxkKTF9eov661dkXZuLhm51YKYiwwmlwQb5yEN
   naCYKec/vOHkVjV5IefDWuCcebCae8YYOhaCH1snc7ZhOaCLMCS4ZuPMp
   zVbeJcHi6JbJZT5ywXnxLMgZV3XjjuqkbRzCdhv63kaQGtVUKsSGoXn53
   Q8GrILdIt+7xKnlDg1oD7HXcnvy84p/dJFjFFAPQwsw0pyLUWgTwGQPil
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276226911"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276226911"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 10:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="911106793"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2022 10:07:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 10:07:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 10:07:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 10:07:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 10:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4CJ7veALMSAYhgR5qRgz1b6oqcr5YKNlrIyW7k3SBNyUoEhBVnTjPtf2Oc2yxET3dx4rDISTWk+ofJjBdRJ8a5FvEFAI/ivf8cgvn248ELfADyvMiALrAMGpC18NnbQLFlb41M9ladQI/e5LOEnVgd6kEeZTtVojK8rZFM6xs/xgNtofiBIABLWGaEV6DGHx1YjfaPseZjjl9ttT0bALIUrjXJ4b8KlisVa7XMwpaRL9IBEwBDXEFP1kGztvm2PuRtGj+TTaP92B+ocu3RFNwT4ydLPRYEeclLQOi9rYDQqAxEr70DS2M9Ssvv9CB+ayMskfSQWnBK30Bd7FtGgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLKU0S8hmg78rS38iLkfrGAMp7Nv51QG1DmG35Q3ILA=;
 b=ehztJ/Ry7Oeflkq5o7eSuWl4fRe0pFpTT8dP3GS3q+Wt7VS3yMtz3tH37b3KTni4KW79AWfe55/nHKP35LTGr23haLiY20XTmOM6dWmFAgPtjEwWg6AxdhVY3WiajPk+uuWE77bOSx75Ajnp6RLgcGt8n8XQuliRx1QJAngbJ+0prkCj8zonGOUT7fRyT+2JVdcfjf0RyEWrAjwsEeURIZv6sY18bNtdLWzAGjKH0NEXBuH9UNhUiy2ClbESOdYjEx0fKr2Epvs4iucZ1NRXe/H4c+U2OcOUmuHyoW0wBxki4MZXxWHSWPKIdZl6NuwkVXNXV8xB91eHLS4vNw4kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 17:07:39 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 17:07:39 +0000
Date:   Tue, 14 Jun 2022 10:07:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Message-ID: <YqjAVq+1PIpVIr0p@iweiny-desk3>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com>
 <1936552.usQuhbGJ8B@opensuse>
 <20220614142521.GN20633@twin.jikos.cz>
 <8952566.CDJkKcVGEf@opensuse>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8952566.CDJkKcVGEf@opensuse>
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be6c581-83dd-44a0-5b54-08da4e2862c7
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH7PR11MB6498961F6218317610172CFEF7AA9@PH7PR11MB6498.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WYB2vMOYiECVXMfcIv5o2Jx/gDYl2M3lx23+LxAMhz2KKu9M0Zdp3hUWBbmTYW0d9Ufl2xMLpdAWzOcvO0/2xuG6gcYoINHDu2wT48qvXHJD7+hLh87aULYEQbVlUKCPCQFmfehb3zdR9iHi5vn8osgk46V7WBJVpaS2u3ueCOJ/uKhDD4EMRtY1GfBC4vRK1HlGnGSYfL8amd9oAzpznIWU+ooy9oy60ZpEsFeNr8Y66kQTpeO5GAR0vhXkg8VeYV0jLGsM86WA3zWwL54blqg6nc7+8Dwwn4uf8fEKdGP6t6klqguxJ/tiGE0Ek99YNQJk85f0uI7VdELA7CmQ1QhNgyE/Um28blbcpOb57IcbofjB5RXrKivxLOskOKxOtlHSx9GgwS5msb4+3ETw/0QZnTem+12FYbAVuQFqxEzh4dJu18ZKUx7ZVT3dSqoR/8RD9eQUrivgKFG9ORPy0GZwuD8MJtXz5fiWHUVQvR0gDqUzx8IgyP5kHJiLrE/bkY/hblWamvJ9QSQPSBAYBx8qLBIFhinZVeep85Xte59Yq0n8Vfv5DB8krTX/htFZEFTX5BRpWDFPLLAt7zfehZ9i1L02wodiIdoKgwPU7hoovZmjjyyiUsgkjEDbtFmLbZ5Nz7mVXwjzG51naiO/U1my3VZMnYwlI/Cfh6uypGnK4ovSncnf6i1QaZ+cC0C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(4326008)(8676002)(66476007)(66556008)(54906003)(66946007)(2906002)(44832011)(6486002)(8936002)(86362001)(5660300002)(7416002)(508600001)(186003)(110136005)(6666004)(82960400001)(26005)(6512007)(9686003)(38100700002)(6506007)(316002)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0XhirqsNQTEOGCpWv91B+id4Lv54HJyLG9RRPYECO6ZaS4Of7fFVrk6WzG?=
 =?iso-8859-1?Q?cwGRNErC1sLisFUq8/CncnV5BuPB882SsUdDUZaWTWKq+UdD126giwQ2AB?=
 =?iso-8859-1?Q?H01Vrzo9CH8hJJF/JC6E10EZmWDcamcD3Rm6BtbhxafLzu5OGVT2ZGF9/8?=
 =?iso-8859-1?Q?XmbTsDRqnJn7ojLPEAea4qd4sKyQpXhhdZvls1Bl5ewqw3PwpQWntEEUlq?=
 =?iso-8859-1?Q?KMdqSpGdZaYH0zC5cGmyxJ2zV2siWqIW2yNwmG4T+OdPkG/ZuWRU+KBBU8?=
 =?iso-8859-1?Q?cS1VU3OAECzJwQj27LhJ5f+VU28KTs3wve9krd5XdVu3MvY14Vi0sFf2pc?=
 =?iso-8859-1?Q?gpZdCFMu3RrLJ1NTDHH4KhxT4k1Tye/nFI++mekEI4XPMha+WsY3b5gRTF?=
 =?iso-8859-1?Q?HYzdRTSckK8RrceHdiI7XgJdLwWqfRBWuxydNQTdTExBjNUgEC9XAZwYMi?=
 =?iso-8859-1?Q?I8zVs9JlH5jXvuO26J1V2dZ7eYApSZSfxYa5XTdn75CgcaJNWy/6a44nkg?=
 =?iso-8859-1?Q?UyHldtG0rt5CUMtX8/l5rVTeZLkoKaPDu2Vs8AuMXxG9ff5wIMmsnn+Glf?=
 =?iso-8859-1?Q?wtQzmU3ayUJdyyU06fT9WJ23X5n85/mrCm2+gz1dTjzEnQRKVGC6yI/bZk?=
 =?iso-8859-1?Q?YN0Znr+Pw5pDgNKTNDsFVZjwvqu4hhGipwU4byBXlm80IcBLdUDLnjs3dQ?=
 =?iso-8859-1?Q?fxfcKkBZnTod/F3FOXrn//VEapvdqJie+F0wIlcE8h7hRXhqUkhS8fgRn7?=
 =?iso-8859-1?Q?o7HZKosrQDWH5NnOO3UhcAtBNc6sQPOeB/1Ql6ADsvz3YPzycP9VPP3yUZ?=
 =?iso-8859-1?Q?pMbz/MhVmja73YqCZlFE5YeXnYOCoy5Dshu6Au0z1CBSRarc2XUFJDReX1?=
 =?iso-8859-1?Q?QxXS8RDXdKW9FMiLOvSl4MyJMUnAfApE4E7Ce2Fe7YL0LdedxeDTE2STD9?=
 =?iso-8859-1?Q?wFQewlc0Wk8XyqAB6BGkpQfw+x8MjREwgWzd9g3knY3lHKvCntr9vKSa0V?=
 =?iso-8859-1?Q?KSr86FcmnJAnVQWS3N3ksAAoSYeeAhTafEWioHzfn4ghxLr62exZcM8QdC?=
 =?iso-8859-1?Q?afvumM3IKs6nw/VDHj0aZe8y4ANT7gVyHJRS+Kd6ciAMPi3+b9dvnIVW7e?=
 =?iso-8859-1?Q?N2s45aGKskzsi2xPZhrZlKIvD2/qdFUg+IRXsNh40ZAPK1wKXAKApyPSw6?=
 =?iso-8859-1?Q?wZrZD3FNlJh11Vvu7RD6MRUzpasQg+HgTPc+iHCKfYgFpk2lzglVnYAjoW?=
 =?iso-8859-1?Q?V3oV6pIy8n5mDT7JDluOakdqx+XyShjtpxr5fYpKWXIpCSL0JvzyORsPmR?=
 =?iso-8859-1?Q?hDcTQ/tSd8Xl1x9VAoC3cTBvt2H0CDLpkWgwqil4/Q3OwMVath2h7n6kXf?=
 =?iso-8859-1?Q?JuPITAHsKV8s2C6PNemU8mUuOo2ID/pyxSOF5nJPmdlLlYI9+m23HFGjaa?=
 =?iso-8859-1?Q?fvwTFtvW+HunItRpTEq3GlaJj7unTl4mw03IK7kV/Mtn6NsVLnqPjQju+g?=
 =?iso-8859-1?Q?OY2VKdHv4Cdt7F/1GyIdHbhnnPce66jcpXBY+g+0sTWhvKBrapspSy2q5E?=
 =?iso-8859-1?Q?Ig977UgrnOl65OwZlIDdU6pa206CkOWWKTHnY4LUvkU1kPJl/MZfShiidE?=
 =?iso-8859-1?Q?nvgRt8ury35uhsj0tJx8fZB5iRWUVrAQ+SpTW19wGxrpWRVe1/WfMcHNc5?=
 =?iso-8859-1?Q?YmlX3KMdYQugPVkpiT+RJfdNc9tv/vea0VAZ8YVi6C8zud42N4fuj207h5?=
 =?iso-8859-1?Q?I6OzU2Z5HY7QfjuMEvz/MNRsV6rxpDjTdyRWx9sCXMbfWEQ2JgeneYqkSn?=
 =?iso-8859-1?Q?91ho46UCWsnpD8rqMhT8UAJmffuC1UA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be6c581-83dd-44a0-5b54-08da4e2862c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 17:07:39.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7LFjGPrEgT2/Mh8k93lEAfCBy4m6uAQLs3PauDl/tP7Zv52OYD5kQYsbIF+ZxdEKMf1JlyjCyq/CPMT/zDA/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 14, 2022 at 06:28:48PM +0200, Fabio M. De Francesco wrote:
> On martedì 14 giugno 2022 16:25:21 CEST David Sterba wrote:
> > On Tue, Jun 14, 2022 at 01:22:50AM +0200, Fabio M. De Francesco wrote:
> > > On lunedì 13 giugno 2022 20:39:13 CEST David Sterba wrote:
> > > > On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco 
> > 

[snip]

> > > A better solution is changing the prototype of __kunmap_local(); I
> > > suppose that Andrew won't object, but who knows?
> > > 
> > > (+Cc Andrew Morton).
> > > 
> > > I was waiting for your comments. At now I've done about 15 conversions 
> > > across the kernel but it's the first time I had to pass a pointer to 
> const 
> > > void to kunmap_local(). Therefore, I was not sure if changing the API 
> were 
> > > better suited (however I have already discussed this with Ira).
> > 
> > IMHO it should be fixed in the API.
> > 
> I agree with you in full.
> 
> At the same time when you sent this email I submitted a patch to change 
> kunmap_local() and kunmap_atomic().
> 
> After Andrew takes them I'll send v2 of this patch to zstd.c without those 
> unnecessary casts.

David,

Would you be willing to take this through your tree as a pre-patch to the kmap
changes in btrfs?

That would be easier for Fabio and probably you and Andrew in the long run.

Ira

> 
> Thanks for your review,
> 
> Fabio
> 
> 
> 
