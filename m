Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB15538D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353400AbiFURXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 13:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353256AbiFURXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 13:23:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFD2D1CB
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655832222; x=1687368222;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=qxoyAbLA/9g4Le/xj07GUdlbGhwTQ5EYYvKYU41JxJ8=;
  b=QXzcAjMBcOAEKZaw17M5/hGv35gNCcHpG7ik/RmV+ky0uQvjGAd+W21k
   1MkC7WvTg+Pz2Q7TTjtpSr3Oqk8437nmFUSl8GBpisUkOU1L1w7c+/pd9
   94DquPCcwgJfa2fW5nBQMPzcTCssCn9cA265EXCQpL2gZTTzJi6wuFygB
   oQsf6UUcRA+zTWXUsYw49KWzPd45aqbUAwA1Nm6PS+WxMyusN+y0YSTM+
   sZ7YSzx7+13JkKvWMhX+hTmFKK8UBtzfHXgkEowKIRxFAhsKSDfBRpIYJ
   8g9NDZh806BFwMpOq7fWeWh1xBmz9Nq1yQeF0/AjZUzf7V06Nto49co9U
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="341870937"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341870937"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 10:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="690044271"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 10:18:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 10:18:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 10:18:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 10:18:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 10:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njsEK3kp/GKp35ZsEK+o5qNbfN3lR/Ds/6QqXxJzAZdtHgqBofl5x38YFhqtN+mruBL2gdIvrXoI2qGSWK577FWodN4sr5ebs8JQGMorlF7rMHcTdA1k+gehYIN0Hz9iYD2+n169zKjqjsuCgvqVGEirq6GA4vr6tn5QTtrAVdl8SlP4C1Gw6mnZoON0E2oWtIsDa/SqiYMhQeyPpffmJLjMgLGwjZzMG+6ERkpam/OAG7T0bVOfbpSe1vw4nCct311474Kp+jL293uEP0n+9S+Pt39fdohM9GdEJbksBoFH5LPg56jQRC7rkQxNyC6rGol62SVRthMsBkJsvu+PAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKvRIPhx5b/SmP/zDMGdNtJ+Oai38+1loLwOn4hC0QE=;
 b=EMG3DVAgGeZhKtQk8PyF0SwccI7QLdrfNzHSzFY+aCqfAm7QKIAuFZichqvJF4XU9CuxEYMgIFX28n3IKe740UxRU1NHt31epmDmuOwqd93hakr6uT6gQVl39TjrRLSVqKjk3peIHIG3UvoVp3TB4l/a7p1f89uH06pUsMfeg8bELrDqLkEh5W160PLktGVjPUQxDeDV6sFB57Xky1F+Dy+qqnCPTRO+lSTcwXyFoyI3LrjftYkjkZLXl4zzpfV65wNPm6/cf1gYeT3B5THPKdq//i2hePUrTTzfoQJctU5Tc6bZtxu7xk44BsEXmOOPs27t9QntjkWsCkBMHxJwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BYAPR11MB2630.namprd11.prod.outlook.com (2603:10b6:a02:c2::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Tue, 21 Jun 2022 17:18:16 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Tue, 21 Jun 2022
 17:18:15 +0000
Date:   Tue, 21 Jun 2022 10:18:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        <linux-btrfs@vger.kernel.org>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] btrfs: zlib: refactor how we prepare the buffers
Message-ID: <YrH9VNQnVqHgUKAC@iweiny-desk3>
References: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
 <20220621131521.GW20633@twin.jikos.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220621131521.GW20633@twin.jikos.cz>
X-ClientProxiedBy: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f29841d2-0a55-455b-abe3-08da53aa0702
X-MS-TrafficTypeDiagnostic: BYAPR11MB2630:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB263043174BAF9C2B923C1428F7B39@BYAPR11MB2630.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/bh/qMhiFZUUFBSyDDORJMyVwZwO8bLZnwJX4uB8cNcJu5CA4YUcvAAfhrTXM4oeyVIhI/lwFhjoTUwV2oRrIKifUJGb/uaR9pG5Y7P+uq+En2FPqjwwK2uD6TOe3D1pnbJHTkI8RRNj9J0TGq6c/pxtvRYa3+ExEkejmeNouaSknnzIFS4bCHORX2Uxd0LktkVuPp7Q0iu22u5z/CraGP5sn/p5IHYO9JJonPXNBDP4qhUk5jrB5FuiKF2EIBbJL/dz6xo/P9/x/n/+ForT4G2Og2++FmvgC3vvakM4IAecUERbEoi0qRinMvNwlu5MXhZ/3SZ87AoDhKfenE+ptI+W7k2+WWjrLynDpnwo2RB4XalW0xCUL9Vc7FYzStzKXJ4bzm0F1f2hFS1OKzw40KtcnzVckat3OMlGB09SGtrgSMIezjdrjSEr4nbwa/kNovPiZUvRVVTWrKjmoayF6nwM2UCuNnvuk2dm9SMXdtxGkPFQLDcwljT/bYCRF74vRY6sIVDvAopGUTmQyvTt2mv7Zvim4pCDkOgl5cnVM/uWlXfQHyo8PijJqnmPeyImOXm4vOPL28TJfTf30H6UyYVR7sNIU1iNTKnkIGBLOeFTSne9Py6ULh5HqE9jKdRBeU/68/aPVCU99awdZocwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(366004)(346002)(39860400002)(376002)(6666004)(26005)(8936002)(5660300002)(186003)(66556008)(82960400001)(38100700002)(6506007)(2906002)(110136005)(478600001)(6512007)(6486002)(66476007)(44832011)(316002)(41300700001)(9686003)(86362001)(33716001)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6l+CTEn3MMI6BhP89C0nxOr6Ax9wBcOT0XStzFeOujrotxlKOaWaP/cT2dK?=
 =?us-ascii?Q?CsZ+NjV+P+kR/Gmnb9esSRPg1v3CN6lNR2gyNiDfodReqs+vX1o8RUQE6XNL?=
 =?us-ascii?Q?f+3hbKKOC3yczuJAHFS7ru1a8mN81anWHihp5xtuLjRGVeUs9z2QwkFvz2Vg?=
 =?us-ascii?Q?b4uuXsB3Sv+ht6dO7o1RRA07BNl5V8GI145O25gRSIlDjNJO6EdSw0PstvgH?=
 =?us-ascii?Q?E6GWrPEpTqsYnOq+s4SmCDeZY3G6uxO7Q1pUi9J6SFO+dnx8x03/GiASC3TS?=
 =?us-ascii?Q?IApRtg5Uy12jyR/RGZVOj0CuvfjB25btxeKEoL1K/5sWHsVr8UTSgFz0WwH5?=
 =?us-ascii?Q?KtGWvghMmKHFcYDFgwyta04garjkeNm08CcPvvl6YKRqDvuUuwWNdCwoOgxC?=
 =?us-ascii?Q?Zvq/oFOE7pIAzEVmHPOsIY2HoVrysZoMwo0M3stAsni7sTC8QkC159YVluem?=
 =?us-ascii?Q?uiBT2fTynFS+SOGMZYGjekfmtjQbCBT6QrTHIbSKreQX5/5Knin68kfCOp64?=
 =?us-ascii?Q?hzKRccXt0UCBbzONeLQzEh8cDiD2NO8sPNzmBUZp9tmTJ/ooKoSQ+d7lrxR+?=
 =?us-ascii?Q?+q4utxl2jSVIHgV9CkLcYZIQtQWeErjYRkHcUU8MVZY4FU3G5MKj6DORTkzt?=
 =?us-ascii?Q?E298Lnn2dXSHb9m/mhBPqoQci8af1vDAKcxDbhsoqG8t4QbT9OzxX17AAsdg?=
 =?us-ascii?Q?F5u7m2lsjHqipHLv9v4teiFPPo6Rj0BvgkAlir/1teQ5drm76dK9izcELokF?=
 =?us-ascii?Q?eW6O1fpEXydEXYXS1a4DsYMFzBmAi2VqUXZucNSxSMu9kn2lSvdwLfBhsMUR?=
 =?us-ascii?Q?S4UuzYMcmhymr4oyIpdqxQiB+gimSrJIGlJo0UfjoAV+uYSnshwh5e4ML5Up?=
 =?us-ascii?Q?jVr1aHuU5YqoaXeaKJrs/vwLApvQ6/Lru10JBRuIqUrqDOaCskoNJtTvGv63?=
 =?us-ascii?Q?eAmAiAwuYerkkI/QcIWhTe7g3yKq287TiiR8z7kq1eGnVRUtvr4ghuosaOUR?=
 =?us-ascii?Q?sRb70aY1fQgIaxJ6yxyeutUxWE2sJzpC3QLOhyJkNQBnTGFZridSFOTQl2nB?=
 =?us-ascii?Q?o02CRKkPap795YoG/cUVbFAzv3lYKIOGRvvUfNvogwXtnzTJVRAjWVzk5IL9?=
 =?us-ascii?Q?MIXFIWkpvmbnP0Znq7gHTvN1+5vbriEQNYU/kN7K8C6DUOV1bP2dzPmg/2xe?=
 =?us-ascii?Q?AucLthMBcIa0pxKP1GC4Y0JUNCzUM30aZqqkoPdD+FDFn33qR3V/21vwsTFm?=
 =?us-ascii?Q?GTNh9jbadWjciG2JRJMXj0JcYGAe5venOBlDuXkgJHtajqo1ZOp1V2DeLaJ9?=
 =?us-ascii?Q?e4QPIBLlHLmvAp0qninh+D3DEzfRwD9J87y1J2/IL3jGPM6+raG1BpqiE/ls?=
 =?us-ascii?Q?MqjaiGLMFHxugvsak1pM37HztXuvNXmHss/g9dX7tyQRcNjjikFiFn6kg0vH?=
 =?us-ascii?Q?s3SbOyQoRqeXrk4v85vrmrbf4rXLSnlnc5f7TmtZ4+/E0r+suY30e2OZcRPt?=
 =?us-ascii?Q?0innT1aZG+eyB7+lkXLY5ZPBUnYnk6ADx6RAAEtMpbQ1GD7h5VkiX29x2nsg?=
 =?us-ascii?Q?a2zpTPhQcEdqa94Z2kWXEyvSO2yr2wUPwc0g1qyQF1Rz6U99Rio2drbAubVx?=
 =?us-ascii?Q?qVWNsUJ3ndC8afaAt/C+stUG/qxh2H90d2gTvwzQR5p3B/EcC+mShrpCJ7BN?=
 =?us-ascii?Q?5Obv+vlWS2QcWLQmymUHI40Pqw39xZqlUTHaYyddhmaWq/F+o/SzjbR4g7LX?=
 =?us-ascii?Q?/+vlElHkpw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f29841d2-0a55-455b-abe3-08da53aa0702
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 17:18:15.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TPM531dHXMn6Adk/gDQ439pK/jYQXaAKwp+eCF22b2vNOpsJBs56yUJWoh6K5gtxMDftVXA146+SpYDOJm7sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2630
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 21, 2022 at 03:15:21PM +0200, David Sterba wrote:
> On Tue, Jun 21, 2022 at 01:59:46PM +0800, Qu Wenruo wrote:
> > Inspired by recent kmap() change from Fabio M. De Francesco.
> > 
> > There are some weird behavior in zlib_compress_pages(), mostly around how
> > we prepare the input and output buffers.
> > 
> > [BEFORE]
> > - We hold a page mapped for a long time
> >   This is making it much harder to convert kmap() to kmap_local_page(),
> >   as such long mapped page can lead to nested mapped page.
> > 
> > - Different paths in the name of "optimization"
> >   When we ran out of input buffer, we will grab the new input with two
> >   different paths:
> > 
> >   * If there are more than one pages left, we copy the content into the
> >     input buffer.
> >     This behavior is introduced mostly for S390, as that arch needs
> >     multiple pages as input buffer for hardware decompression.
> > 
> >   * If there is only one page left, we use that page from page cache
> >     directly without copying the content.
> > 
> >   This is making page map/unmap much harder, especially due the latter
> >   case.
> > 
> > - Input and output pages can be unmapped at different timing
> >   This make it almost impossible to convert the kmap() into
> >   kmap_local_page().
> > 
> >   As kmap_local_page() have strict requirement on the sequence of nested
> >   kmap:
> >                    OK              |            BAD
> >   ---------------------------------+---------------------------------
> >   in = kmap_local_page(in_page);   | in = kmap_local_page(in_page);
> >   out = kmap_local_page(out_page); | out = kmap_local_page(out_page);
> 
> The input pages come from page cache and could be allocated from
> highmem but the output pages are allocated by us and only with GFP_NOFS
> so they don't need to be kmapped at all, right?

How important is it to optimize the HIGHMEM systems?

On !HIGHMEM systems the kmap_local_page() calls fall out anyway.

Ira

> 
> I sent the patches to remove kmap from the compression code but it was
> buggy as it removed it from the input pages too. The revert was complete
> so we get back to a known state but the output pages do not have to be
> mapped. With that removed it should be straightforward to use kmap_local
> without any nesting.
