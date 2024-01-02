Return-Path: <linux-btrfs+bounces-1176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E545821629
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 02:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456F7B21267
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 01:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2FA3C;
	Tue,  2 Jan 2024 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRIyeqIB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C4A44;
	Tue,  2 Jan 2024 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704159489; x=1735695489;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rm3mB6xfKB1haeJaHTS5U+3GY/7nZXa4GQjglCGB6UQ=;
  b=lRIyeqIBAS5WayA05ktmX4D5cxlNL7xmO5qALT+2Sx5ygdlQGBYLbTsU
   H69ns+CcssqzHbQxKu/P3rUXR+Pu7AOxN0tNSRyLC19yPYXmIBpWQkZy+
   ZE4nsgMwo4QUM7j7RM6MzoFTONcv6Z951cJWcEPdxAgbZTAndFr3JeELQ
   qrmAuX8Cz6P2lVGq4R+uIqSANZXLXxufGXpCzqsjo/hw5PGpL9N0JSi9c
   jjiTADsw4tClCS3o5YhhOIg4guZKJ8PTZs7/xSsskVuzj5wll8yXZG5kB
   e2yRrrTIkVBjCuO1OtnkwfoOFWTWOTk6+KRUNSKDR+Ldpde2ihF98Im3f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="381785684"
X-IronPort-AV: E=Sophos;i="6.04,323,1695711600"; 
   d="scan'208";a="381785684"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 17:38:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="902963390"
X-IronPort-AV: E=Sophos;i="6.04,323,1695711600"; 
   d="scan'208";a="902963390"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jan 2024 17:38:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 17:38:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 17:38:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jan 2024 17:38:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jan 2024 17:38:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHAYZhJ5hq3gmR/PuwrkInooDBDi1s4gBwLTT5mtDguYoCw6B6MM8vQOfBYnl6AMJFwLrJCAM2mYAgWL6tag9VNQOvePULAkbcb/+gc+6somy7EOEYNQc9C+iLCuK0INspmEdy6v/3U6rmIiWILbVdwz3mI42qlYbCSomKzO5TfDR0P4cY/e66R52UCX9zsb+P2nryzyvNP9q9nqFGDJSXpMIfxT17BLElMwFHx3eqcChRo/eksumWDgQFs7wjwbslWt/aLzXx9NhApPl0ibqDcrOliNTcOeA3kHmJS7UUX/neO4tRl8AmJt+ANdxE2Y5n17fzUNzBwEY89t9xH8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SxLHaN1ybRyS9mYVyoJaCMr3hEbn5CA8lp5olrNRO4=;
 b=IkEpJAFxcubNXQCNl64tJhcxX+75b+l41Yf3qyD7YbT/iYtnTfhWFuIsL1fiZZikLp5/uRXaPOaCsm6cwIFrlFeeSe7Y0a8bzVKoB8rMYYO6jp+Dn83Cmn3/rvBsYZVfazuyqfrXM8JDbvcX1yStgpWQoR91CMmCRNNeVdSDadE59JKUaX9lw3qPbWo0G23EBNNrz0sN+4vXibINoxBv7Uf2mDZecwxmaO7RQn0ZNfY4iKSIpbDBKK7qRMkGPrx6GfqA2B+3Ef5ODLuPBuc1rQvHNG/5bpSG7sm23/cvlqonHCiqgZDq03lGNZrstQhfRjmibGZ0hQ1dzlRPt0P8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL3PR11MB6387.namprd11.prod.outlook.com (2603:10b6:208:3b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 01:38:04 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 01:38:04 +0000
Date: Tue, 2 Jan 2024 09:33:40 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
	<linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <christophe.jaillet@wanadoo.fr>,
	<andriy.shevchenko@linux.intel.com>, <David.Laight@aculab.com>,
	<ddiss@suse.de>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 2/3] kstrtox: add unit tests for memparse_safe()
Message-ID: <ZZNn9HKlxbPNLt1H@yujie-X299>
References: <56ea15d8b430f4fe3f8e55509ad0bc72b1d9356f.1703324146.git.wqu@suse.com>
 <202312261423.zqIlU2hn-lkp@intel.com>
 <479bcb3b-bf0b-472f-8f3e-11e032587552@gmx.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <479bcb3b-bf0b-472f-8f3e-11e032587552@gmx.com>
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL3PR11MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c66ee3d-38a2-4901-3b8e-08dc0b3376b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIJ1SPYhdBl6BiSXY2uGf9zklVYmeFSsXGbmVB/WszyJifGPwXcXocaNH3gl13ykMScEccJDhfhzXN0i3oSQLC4xkx4o/Cypr0K5wAZt6OWDYGwSsn+cqKkc+V3w9i08RLexAzmLBfvKJmAg2my6yic0cvrc71LIy5NvYqz0b5Zw5QMayYfrJYVDCoVApzQOoKmMtYB/so6zpprZz6LMpGuE75LRZ+5KYPXTz2LTLMkJgr8YQ2Bl1SLhhfurLm8YEirShQbiidsdTovjw3CfrWAk9L8TYN88/P7sXUVKubFB9PJWnCJrwVC1KlYXHEMKFK1Uw3Pl00mty+8oUW84xXYelO7a/diiVnOo2iXhSsnN5Xn3DfLa9LYdagOyOVLgiyc2Y8dC8QRmI7ItpgL0eaKi3XMyf47s30VBPP/3JlfRsxhBlAHFPD1QjPxIO6fkYcdX2STTSC7nzSv6e0TivTCvN0xErTJQp218Wdq4W5ekNk0fobixXXZuDZ4OCkX2lWQHwOAUOaseEmZIiD7KSSEtj68E6IzcbClRC1WoYo9sMT5VElZBlJ+CgHw4BFhK/8HO6seKqUYJIROpnG0fFj2VhhMhF0X+5Nyh7EvcMAlDvgKocRxGWz0pDHHu1emAwcU59HAU5ml1Y5jA5govImFtMxCMpJTcF0JqstbgYTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(38100700002)(86362001)(6506007)(53546011)(9686003)(6512007)(6666004)(478600001)(83380400001)(966005)(4326008)(44832011)(66946007)(66556008)(66476007)(6486002)(6916009)(26005)(316002)(54906003)(8936002)(8676002)(41300700001)(33716001)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aW4PX/AQNlKvGBcVM0H5/YlIRjF6V6d+LALfbaoDM4HO8+/LE5LsKefoPGAd?=
 =?us-ascii?Q?wweQUYNPPUnnAt7jNYd+Od/yi2yU1gdnqpNA1iQEQAtKCeMl4bRqzznnQHDF?=
 =?us-ascii?Q?szdhYn5tkulDDJH6RaTQgmcLMOl4Ci5L9pkYliBJrsiKJ/YwhA6/NR9A6Vyp?=
 =?us-ascii?Q?s3U920iwNJaX30ph8fnoZRPwkCBBGyzcPYxjfGRFeO+mPZtvhwLJmp9afwhL?=
 =?us-ascii?Q?fh4rrb27GRU0oZoquopaWWdEs9wqT8jdGnsoIq1KM8iUyBusTXBUcoUY2RHl?=
 =?us-ascii?Q?qoQeqehHzDmiICsHLHTLg+fRRBw0XTW3yjjzvyierZS1o/9k6brPOfZlIdc2?=
 =?us-ascii?Q?Xu0VFa6On6Wj35tS9JBzz+NZHVxQI3wll0jq1+Xn70tWAfc55Pin7HthbLmk?=
 =?us-ascii?Q?RcWO6B/NLlHoIlZQjqiCaKOXQuM6a2dTdi/kn0VBbf9Ih52vccvbJvL7nrCQ?=
 =?us-ascii?Q?+ilD8wqtoTpmjCTEmw7IiGozDNEv9xLGeHssND3hRRGC//ok8QBieTaBrOMb?=
 =?us-ascii?Q?R6+5aZod/XEqSkjW176L2PHN9vZkdsXGzgSelti1yK6xo5h3yJe5pWc8rCTQ?=
 =?us-ascii?Q?U0cgI+Dm+JF7dpoH2jf8/YtDBgbLhiVud7Y94m9IIepIMPe4YWbyUqusyfVb?=
 =?us-ascii?Q?s/ZnYokBtwXgLEE6UId85IG3nql4xkqXY4zYDZmthkPMCu7YEaLjEOggkhS8?=
 =?us-ascii?Q?Ufr+3GVKp8jU5WGjwNdZGXgWIH5aa+2rZizI5v8/eNHxrEKsjR78VCw1/h/3?=
 =?us-ascii?Q?ONR6vKAuxO0o+4h4fTCIfcduNCCILEvUmPUO2xVyEe8bi7R9TtDdwScVVTrm?=
 =?us-ascii?Q?iFpCq1qV3LcE9qr0Us6HwlEvr0XHv5i7FPS2OoF+HPq6CGZb6J4hbHKNa+7v?=
 =?us-ascii?Q?tuIn1Jlb55AZZAoxAxalsfBctIp6Yidx/JaOFICPUJnJAviqcqCbqSmbviSz?=
 =?us-ascii?Q?tqpHSQZH+QGoJ60koADGbhjDuOykfbNy71E7PK2TaDAUDx5I9hdlmsxke5Ck?=
 =?us-ascii?Q?JM9Hqt6GR1MN1d5AypEwUsAb1T1wSgatPC4MDRHRHxEVU9bJ5C9sRCRiBsAv?=
 =?us-ascii?Q?grlRDlTem8E+qUjTsS/qqoPMt0zMh+35kJju9KQSNAwz/DkIBR0f2lfIqi+0?=
 =?us-ascii?Q?uxcIu/NATxEIKvW04uwRigiRDGZfGyycn2c1btA1qajTK0UR2J5ZAAqzFGGG?=
 =?us-ascii?Q?JY4RmZAmRgtWdJ2yoyGUk3xZMpZlC7Q0qbkYWzTLVhOSWjS2S7P6qTQbDQNR?=
 =?us-ascii?Q?7BDBpiBthNF6E+IbPwPJX6OP1FnH2/C7dcBzN/N3+vn7tPucCWM2knrM7Ybk?=
 =?us-ascii?Q?JQ+RJS69rZ+tiGuuSbUOK7GHkAjayGBN/qq1b0knGeYxPh/wr790hwAJEzAj?=
 =?us-ascii?Q?ya99kLnFGE5I9HbNIBLa9d0Rq+AwZgf0Wvjg5Jd03yDjO3iAtTB7HpQa1y6P?=
 =?us-ascii?Q?IwqQx1WGq/+15USgXqAzIsrS4Tr1NWGXs3uEE/MpJ6N7fk/LekDwW8R6ssj9?=
 =?us-ascii?Q?ErN/y8KRQaAfBB5eZOEEitcs6eVsefhrFpKVvjsTQZm8dnlvkRL7e7CZWDns?=
 =?us-ascii?Q?Kuzyu3s7uxAsOmgSEiV4IeL4VbUR00vC4JWYopl9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c66ee3d-38a2-4901-3b8e-08dc0b3376b7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 01:38:04.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 732pr468qbRkcAvbQwJOc4s7W6k/05ltDlINR6JzRXaMoJvUk4SHPMsFyBB0ow7EMeK3MCEXPQKp496dT/DZ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6387
X-OriginatorOrg: intel.com

On Tue, Dec 26, 2023 at 06:07:40PM +1030, Qu Wenruo wrote:
> On 2023/12/26 17:06, kernel test robot wrote:
> > Hi Qu,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on kdave/for-next]
> > [also build test WARNING on akpm-mm/mm-everything linus/master v6.7-rc7 next-20231222]
> > [cannot apply to akpm-mm/mm-nonmm-unstable]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/kstrtox-introduce-a-safer-version-of-memparse/20231225-151921
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> > patch link:    https://lore.kernel.org/r/56ea15d8b430f4fe3f8e55509ad0bc72b1d9356f.1703324146.git.wqu%40suse.com
> > patch subject: [PATCH 2/3] kstrtox: add unit tests for memparse_safe()
> > config: m68k-randconfig-r133-20231226 (https://download.01.org/0day-ci/archive/20231226/202312261423.zqIlU2hn-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231226/202312261423.zqIlU2hn-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312261423.zqIlU2hn-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> > > > lib/test-kstrtox.c:339:40: sparse: sparse: cast truncates bits from constant value (efefefef7a7a7a7a becomes 7a7a7a7a)
> >     lib/test-kstrtox.c:351:39: sparse: sparse: cast truncates bits from constant value (efefefef7a7a7a7a becomes 7a7a7a7a)
> 
> Any way to suppress the warning? As long as the constant value (u64) is
> checked against the same truncated value (u32), the result should be fine.

Hi Qu, we've suppressed this warning in the bot for the specific file
lib/test-kstrtox.c, while keep it enabled for the rest. If there are
similar warnings in other files that could be false positives, we will
also suppress them later.

Thanks,
Yujie

> 
> I really want to make sure the pointer is not incorrectly updated in the
> failure case.
> 
> Thanks,
> Qu
> > 
> > vim +339 lib/test-kstrtox.c
> > 
> >     275
> >     276	/* Want to include "E" suffix for full coverage. */
> >     277	#define MEMPARSE_TEST_SUFFIX	(MEMPARSE_SUFFIX_K | MEMPARSE_SUFFIX_M |\
> >     278					 MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
> >     279					 MEMPARSE_SUFFIX_P | MEMPARSE_SUFFIX_E)
> >     280
> >     281	static void __init test_memparse_safe_fail(void)
> >     282	{
> >     283		struct memparse_test_fail {
> >     284			const char *str;
> >     285			/* Expected error number, either -EINVAL or -ERANGE. */
> >     286			unsigned int expected_ret;
> >     287		};
> >     288		static const struct memparse_test_fail tests[] __initconst = {
> >     289			/* No valid string can be found at all. */
> >     290			{"", -EINVAL},
> >     291			{"\n", -EINVAL},
> >     292			{"\n0", -EINVAL},
> >     293			{"+", -EINVAL},
> >     294			{"-", -EINVAL},
> >     295
> >     296			/*
> >     297			 * No support for any leading "+-" chars, even followed by a valid
> >     298			 * number.
> >     299			 */
> >     300			{"-0", -EINVAL},
> >     301			{"+0", -EINVAL},
> >     302			{"-1", -EINVAL},
> >     303			{"+1", -EINVAL},
> >     304
> >     305			/* Stray suffix would also be rejected. */
> >     306			{"K", -EINVAL},
> >     307			{"P", -EINVAL},
> >     308
> >     309			/* Overflow in the string itself*/
> >     310			{"18446744073709551616", -ERANGE},
> >     311			{"02000000000000000000000", -ERANGE},
> >     312			{"0x10000000000000000",	-ERANGE},
> >     313
> >     314			/*
> >     315			 * Good string but would overflow with suffix.
> >     316			 *
> >     317			 * Note, for "E" suffix, one should not use with hex, or "0x1E"
> >     318			 * would be treated as 0x1e (30 in decimal), not 0x1 and "E" suffix.
> >     319			 * Another reason "E" suffix is cursed.
> >     320			 */
> >     321			{"16E", -ERANGE},
> >     322			{"020E", -ERANGE},
> >     323			{"16384P", -ERANGE},
> >     324			{"040000P", -ERANGE},
> >     325			{"16777216T", -ERANGE},
> >     326			{"0100000000T", -ERANGE},
> >     327			{"17179869184G", -ERANGE},
> >     328			{"0200000000000G", -ERANGE},
> >     329			{"17592186044416M", -ERANGE},
> >     330			{"0400000000000000M", -ERANGE},
> >     331			{"18014398509481984K", -ERANGE},
> >     332			{"01000000000000000000K", -ERANGE},
> >     333		};
> >     334		unsigned int i;
> >     335
> >     336		for_each_test(i, tests) {
> >     337			const struct memparse_test_fail *t = &tests[i];
> >     338			unsigned long long tmp = ULL_PATTERN;
> >   > 339			char *retptr = (char *)ULL_PATTERN;
> >     340			int ret;
> >     341
> >     342			ret = memparse_safe(t->str, MEMPARSE_TEST_SUFFIX, &tmp, &retptr);
> >     343			if (ret != t->expected_ret) {
> >     344				WARN(1, "str '%s', expected ret %d got %d\n", t->str,
> >     345				     t->expected_ret, ret);
> >     346				continue;
> >     347			}
> >     348			if (tmp != ULL_PATTERN)
> >     349				WARN(1, "str '%s' failed as expected, but result got modified",
> >     350				     t->str);
> >     351			if (retptr != (char *)ULL_PATTERN)
> >     352				WARN(1, "str '%s' failed as expected, but pointer got modified",
> >     353				     t->str);
> >     354		}
> >     355	}
> >     356
> > 
> 

