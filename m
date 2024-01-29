Return-Path: <linux-btrfs+bounces-1899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5C8407C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 15:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2491C248BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA9657DF;
	Mon, 29 Jan 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuXJYys0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D9657C2;
	Mon, 29 Jan 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537031; cv=fail; b=iLDirRsxcK0ZOcQRfCb/ndSJ9KQ0Cka4Q1XyHJEAGSzATDNDsjv8o3XMydzogchYeLqGoaUBmmNcCaQLl784clRLpKQu1lBckQaFqg3vF8f73tbB7eCwVQJOWlKQ9jojrrhIRUHjcSac97iITU4hJYuSradO3dd0cT7Rt0+zegw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537031; c=relaxed/simple;
	bh=YHMmjbaNtMMDUqDCJe26yMy9NK0y6aGvkcIV7bcf3tU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tJ9XHaxC5Ir/nJ93C5eXJwDVVBVlkBvOGzWaeIxunvM/Zu+EKzxWgNu4DauZN/x6tprtU34Tm/mPJrV0Glr1id92LoqQLVdiSrycwo/CTADSf1nv3kvejf8keTjFMQzdE4W96a8uY139IdnD6iONaibBrsRIgnGkXpZgF4/SLqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuXJYys0; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706537025; x=1738073025;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=YHMmjbaNtMMDUqDCJe26yMy9NK0y6aGvkcIV7bcf3tU=;
  b=XuXJYys01fYAzLixV+Yp/TW5brmKbRc8Z7r/M75dy2MtA6gaKx2zB8QX
   HbPnOlG+Idj/wqGU1Hwdrs3maV/pXElcPkTxtRcxNz2njD9AgczqxT6Qq
   Mu8vpQyWL+cqVL+5uT6souG+IYUtj7h8ljQ/PGw/tZmNGcx/shXoM1RlY
   LYP3UDAAHCy7nLq+uQIPeH0XL3rlBmEhGDgD0Bjd+GSMcVZ6vYQsYGQzr
   P3faceSTmQQnN05ftWLDpkIeCAPdN/PZgTsEvt8QTvI9jp88soCsd6tRw
   GeTeDfCKarz8fvrZ72BrfRDrw2v2Q4/Mw6BN956252PqojA9d/TIsovpq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="400102848"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="400102848"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="1118937817"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="1118937817"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 06:03:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:03:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:03:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 06:03:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 06:03:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ypwhv5cbGAm6gd4QdVWNFeSChUri5JejQ1vFLoqka2aqvB/QBN90TOvcB4CzqKKJyiR5AZyO5pGJlWGfnkL2D2m7lP+ETMjFHxIFSKuEhzVpiB2m7cKfrUZ7DQsqYTNUcyiCt8dX3mjjeeU5Poc+gmKp0+Ow4rxSRYVregTD7VogrmM5bIQ0O6b6XLyNzdxu8FVAAFWD2bM8lV/2CMDEOqV9csI7Ac1Dq8S0fuQjdbeOMFweKxxHrRMeo1KJihRaBX7bIsR3zInphnfjwbiBlBBlr8oZymgzVNmEmWLBFSJkd9bFJsoe6LiR7JF1TClAKNRS3yXQOrq45zGF2SLh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgWannn9QRloCX/Bmqr2XsAcrZ1GENY3k24mSuz1kXQ=;
 b=gj/CTqSWpgPJghNUDwD7IvXTvwABI6AW/CK7LQ8wfMI5ShPIXTsVjIrztrIw1Fgi7RPMf6ng5gqxjn2aingQzQcfRg3lOtmSK0owny8kbSKrMeYiYaeszsnQdxr/Nsa0gRgPzGlkgZxp7uZM0mWEMf3KtCTj18BENH6etTvSP1RuE6YPPtRfcFjniZE6zLB8cyC+ib2iCmJv3iy4lRaooLT0yWy8UAhIadBIrs8kmK1vlXFA8IjNPhPx6N0Iojf1lkHgCSl74wGpDEFFg6VpxHic8Vn1EcmZ5qEXj1QUqCJ6THRW+z78bXjn6CHxUyj0mU4TxG3H2YRGXrtIgXV9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:03:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:03:29 +0000
Date: Mon, 29 Jan 2024 22:03:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>,
	<linux-btrfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  ad21f15b0f:  fio.write_iops -40.1% regression
Message-ID: <202401292150.40c83338-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fc3f6b-50b1-482c-e494-08dc20d311d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPW6kKTyOsoWJOtylZnYlfO+X21Teqk8mYpClZVAaow0LHLs3R4M7L0e1JvUolt2PSe3VdFMVabDSfKfm44xHawRee8Sgw2C7mht5fcl8+ddZ2CI9VuAfAn7jaRApcRYFi6mOZId08HxsCujNHLdfBdX1qEYkOgcm1gTlhAcJWeRVHCR3E2h5kesaCl2pgDagq8Y64gBc9x7/VROon/Aprqe4j4CdZTKpBtIxGGChNQELzz4muo5Ti6fBs/ULt2m+i9WjWZJiwhK6nYc/ci3OX3t5dqiBv0TeGgoET462NJEZKuKinA2I3gnUGS3nw7QZjiCN5mkEAtCt0eQED1o1of1fhPdXpdWLo7yO+oupUc3pYbAdWEEDR0yV6J7SPA5bJBxLJTZ/xF/VduG6TVbQdz4QtmDc2+sRFy88IM2XUCW0kfCLU2ZOK8K6wbPkudHYq6N0YR/fqnct0s4MsLDhKUUprsVJe/gKOyGpyiVkSlKrKGt8p7LWBxh0/c7lodxtkEbNoeZvEHmi5EvvWvin66PwuV8FEQ2xq44R1LV2a0h18BSWTtmrwYJmFRTZjizowOHB1h3MB+iAa250o5+xGRaA90dT020R9yifNeVDaP897CIBk0sizjcD5GZTaQ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(230373577357003)(230473577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(107886003)(6512007)(1076003)(38100700002)(26005)(5660300002)(8676002)(8936002)(4326008)(966005)(30864003)(2906002)(478600001)(66556008)(6666004)(6506007)(6486002)(6916009)(66946007)(54906003)(41300700001)(66476007)(316002)(19627235002)(86362001)(82960400001)(36756003)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VpYdzXdG4wV52nC+2PURg2SRIBIEz65E9zLigYSR9+kx5iZbAVk/mR9bPr?=
 =?iso-8859-1?Q?/WVvbKqAOKqHBS7ffOz2Nq40wB566nHB4vmmIJ+cRbax53o7J+J4llpVBx?=
 =?iso-8859-1?Q?cZgtBoZBxUerbPU30C0HZ/fUZzgQ0A19iaMDqmEXTqrLE62Dd5yB1XuJRc?=
 =?iso-8859-1?Q?FT+8Iki1tmkEZa+3S/UPTGmniULP/WDGBFz0unla0jPjjWpX+Swi7xyLnl?=
 =?iso-8859-1?Q?wYKt2FvKQvwHwYvi3N1/Cs8xTaIh8R1au59Jz6WCIu8On3y/Mgrnd6PgX8?=
 =?iso-8859-1?Q?c6ZKDPZaic8x7d/cXtMVHEo0EGE4f90DbTvNT4FMxflU5u4dnxXtUjc5tn?=
 =?iso-8859-1?Q?Ki/LaBQfWMIaKzKvFFmVGMTzx1TprVkvjuWeZsjfJRYSOhudWLF6PQMh9V?=
 =?iso-8859-1?Q?Bubw1/ENagIqUN9W1Tebum0OhtiVOs9gE35H6jcGiW00KdwQF4iq6ktihB?=
 =?iso-8859-1?Q?WMs/AaQh7fApHNfYRv+jzmIxYo3UmHpbvpOE1SuI0pT4o5+Hx8+AT2/idl?=
 =?iso-8859-1?Q?+BqYB5Kqb0CjMn+7dZSZBOFY1DKDe77SZhtgX64A15YffnpFD1etL23Vqq?=
 =?iso-8859-1?Q?uc4f/R4uClseCZrIQvU7cpM8FwZhcq1Urta0bWQrp5Gx+3ehs0nXQemXOj?=
 =?iso-8859-1?Q?vlZW2NXNdk2XHBrX5v+fTyBilGM3zuznGAAOviGnu6QYUU+khhzlnz694O?=
 =?iso-8859-1?Q?0ti5rdtpLkTw9xhUBLgG3iS5oDO+uoIOQCAAwzj/lh7Ki74ui5Sv+L+OWp?=
 =?iso-8859-1?Q?4AZGs0pPcHOXxbS2YqNBhWjVS9M1b7mwqAya5eI7wSWo/LUBzEtb99P4Dr?=
 =?iso-8859-1?Q?4+/yeEcWzvD1TmuXUPnvtoZ5bTotAjOSyMDB9vUUxrbVVGZgUFBn/32GLM?=
 =?iso-8859-1?Q?oqo+F3x4LD7kQ2/jMGx0AvjqoeFpC03Ix26Pjxu0eBdLFqj+RhXwcRnVnX?=
 =?iso-8859-1?Q?Iy33ByL+cUfQ//TfOrK2eLNj4bdr+FuV4rm3R7jsxv1kloZb8OBVoOt6r0?=
 =?iso-8859-1?Q?cqFtddXVJM4nRxVIna4Xnd2Z4i3MJNHactaLcoxJxTUBXSJ9DrhHeEPYtS?=
 =?iso-8859-1?Q?L0UByRKluwakRIWdnBShcZTLl0NdZh0TsGCH2hNfefmlov8n2/GxoV2RBG?=
 =?iso-8859-1?Q?q26t/T8XQcNU9kPf/kt4hwZL656Ss/O91BtRvvJdn0F/r8PT4IiEIhQyzC?=
 =?iso-8859-1?Q?e/ORu1qF3pFpr6kFd3z8xQF2Q6sfWr+pK3LBTLada5JkM/D4QSfhGv2bs8?=
 =?iso-8859-1?Q?WX30pxKn5Y4Tv0EPFa/XHQ3ddBqF7xeIeEhwiAEJ/ncL5lK6MRwUeO0vsO?=
 =?iso-8859-1?Q?HelKrnR2aJasKeFy0fci/kiN3Or74HqK8dFB06a0vedbaEj78QGYrQnTM9?=
 =?iso-8859-1?Q?jSz/BmdZ/xv75wEt37PeeDSqOYn7aLI13C1t2qF6/xMUr+6W+GDOlLnuIL?=
 =?iso-8859-1?Q?xc5ihOKjiQNhuhYH96I7rrNmMSIF/3+2p4YyyPzSIYvl3FeyJ0rEmVW39m?=
 =?iso-8859-1?Q?8xqWS/g/DvAN0nt1AOmQj/+17AKYKyg4LPgT3aaEZ5YRHlJHxGzVTtmNBz?=
 =?iso-8859-1?Q?kcD34UJF/nLYiprWe/fOx9/2D94XkLPJtMTPrwl1xdpRQkgddyiR49k54G?=
 =?iso-8859-1?Q?RRxybpBKVjl2yGS7YY3Dhqx6OdpQCWr2Pv46fJHkg7j3Mc4ECwZJ/OKg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fc3f6b-50b1-482c-e494-08dc20d311d3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:03:29.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qztE1GGizanMd4bCHZwQgEGPXvWLInrVkLAHDvUNJQlN2iEzu1M/INP81WPAaA7joEXJdyhBX8VfTT4DPXn4sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -40.1% regression of fio.write_iops on:


commit: ad21f15b0f795daf8723dddbcb61797d4f1c2aed ("btrfs: switch to the new mount API")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: fio-basic
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	disk: 1HDD
	fs: btrfs
	nr_task: 1
	test_size: 128G
	rw: write
	bs: 4k
	ioengine: falloc
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.ssd_btrfs_DWOM_72_directio.works/sec -80.7% regression                          |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | directio=directio                                                                              |
|                  | disk=1SSD                                                                                      |
|                  | fstype=btrfs                                                                                   |
|                  | media=ssd                                                                                      |
|                  | test=DWOM                                                                                      |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401292150.40c83338-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240129/202401292150.40c83338-oliver.sang@intel.com

=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
  4k/gcc-12/performance/1HDD/btrfs/falloc/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/300s/write/lkp-icl-2sp9/128G/fio-basic

commit: 
  f044b31867 ("btrfs: handle the ro->rw transition for mounting different subvolumes")
  ad21f15b0f ("btrfs: switch to the new mount API")

f044b318675f0347 ad21f15b0f795daf8723dddbcb6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1086 ± 22%     +55.5%       1689 ± 21%  numa-meminfo.node1.Active
      0.00       +7.1e+105%       7142 ± 44%  numa-vmstat.node1.nr_written
     14.17 ± 10%     -24.7%      10.67 ± 12%  perf-c2c.DRAM.local
      0.17 ±180%     -92.1%       0.01 ± 16%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
 1.345e+09           +60.9%  2.163e+09        cpuidle..time
   1380685           +59.4%    2201309        cpuidle..usage
      1.68            +4.0%       1.75        iostat.cpu.system
      1.23           -27.5%       0.89 ±  2%  iostat.cpu.user
     21721 ± 16%     +74.7%      37936 ±  8%  meminfo.AnonHugePages
    527.45 ± 55%    +776.8%       4624 ±  5%  meminfo.Inactive(file)
      0.02 ± 18%      +0.0        0.03 ±  4%  mpstat.cpu.all.soft%
      1.26            -0.4        0.89 ±  2%  mpstat.cpu.all.usr%
     57.73           +23.5%      71.27        uptime.boot
      3440           +24.6%       4287        uptime.idle
      0.09        +1.1e+06%     960.28        vmstat.io.bo
      2.23 ±  4%     -18.9%       1.81 ±  8%  vmstat.procs.r
      5074 ±  6%     -25.1%       3803 ±  8%  vmstat.system.cs
    111.83            -9.1%     101.67        turbostat.Avg_MHz
      3.12            -0.3        2.84        turbostat.Busy%
   1364081           +60.5%    2188799        turbostat.C1
   1408344           +59.3%    2243023        turbostat.IRQ
      0.04            +0.0        0.06 ±  3%  fio.latency_10us%
      0.01            +0.0        0.02 ± 14%  fio.latency_20us%
      0.06 ± 13%      +0.1        0.14 ± 19%  fio.latency_2us%
     19.76           +66.1%      32.82        fio.time.elapsed_time
     19.76           +66.1%      32.82        fio.time.elapsed_time.max
     10.91           +95.3%      21.30        fio.time.system_time
      2156           +64.0%       3535        fio.time.voluntary_context_switches
      6727           -40.1%       4027        fio.write_bw_MBps
    398.67           +94.3%     774.67        fio.write_clat_90%_us
    402.00           +94.4%     781.33        fio.write_clat_95%_us
    414.67           +90.4%     789.33        fio.write_clat_99%_us
    394.70           +95.3%     770.71        fio.write_clat_mean_us
    155.40        +18966.4%      29628 ± 64%  fio.write_clat_stddev
   1722142           -40.1%    1031062        fio.write_iops
     95226            +1.5%      96624        proc-vmstat.nr_anon_pages
      2.67 ±223%  +3.2e+05%       8560        proc-vmstat.nr_dirtied
     96037            +1.5%      97468        proc-vmstat.nr_inactive_anon
    131.86 ± 55%    +776.8%       1156 ±  5%  proc-vmstat.nr_inactive_file
     14540            +0.8%      14658        proc-vmstat.nr_kernel_stack
      2327            +3.1%       2401        proc-vmstat.nr_shmem
      0.00       +8.6e+105%       8576        proc-vmstat.nr_written
     96037            +1.5%      97468        proc-vmstat.nr_zone_inactive_anon
    131.86 ± 55%    +776.8%       1156 ±  5%  proc-vmstat.nr_zone_inactive_file
     27.88          +216.1%      88.11 ± 42%  proc-vmstat.nr_zone_write_pending
    272467            +9.5%     298313        proc-vmstat.numa_hit
    206226           +12.6%     232284        proc-vmstat.numa_local
    292091           +11.5%     325551        proc-vmstat.pgalloc_normal
    167674           +15.4%     193546        proc-vmstat.pgfault
    123227           +20.7%     148789        proc-vmstat.pgfree
      0.00       +3.5e+106%      34568        proc-vmstat.pgpgout
      5474           +24.3%       6806 ±  2%  proc-vmstat.pgreuse
     13.40 ± 52%     -10.9        2.50 ±142%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.40 ± 52%     -10.9        2.50 ±142%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      8.96 ± 81%      -6.5        2.50 ±142%  perf-profile.calltrace.cycles-pp.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      4.16 ±100%      -4.2        0.00        perf-profile.calltrace.cycles-pp.__d_lookup.d_hash_and_lookup.proc_fill_cache.proc_pid_readdir.iterate_dir
      4.16 ±100%      -4.2        0.00        perf-profile.calltrace.cycles-pp.d_hash_and_lookup.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64
      4.16 ±100%      -4.2        0.00        perf-profile.calltrace.cycles-pp.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      4.10 ±103%      -4.1        0.00        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      6.60 ± 86%      -4.1        2.50 ±142%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      6.60 ± 86%      -4.1        2.50 ±142%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.82 ±101%      -3.8        0.00        perf-profile.calltrace.cycles-pp.mtree_load.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read
      5.14 ±102%      -2.6        2.50 ±142%  perf-profile.calltrace.cycles-pp.seq_printf.show_interrupts.seq_read_iter.proc_reg_read_iter.vfs_read
      5.14 ±102%      -2.6        2.50 ±142%  perf-profile.calltrace.cycles-pp.vsnprintf.seq_printf.show_interrupts.seq_read_iter.proc_reg_read_iter
      5.49 ±114%      -2.3        3.15 ±147%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.49 ±114%      -2.3        3.15 ±147%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.49 ±114%      -2.3        3.15 ±147%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.82 ±101%      -1.3        2.50 ±142%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     16.46 ± 60%     -14.0        2.50 ±142%  perf-profile.children.cycles-pp.seq_read_iter
     13.40 ± 52%     -10.9        2.50 ±142%  perf-profile.children.cycles-pp.proc_reg_read_iter
      8.96 ± 81%      -6.5        2.50 ±142%  perf-profile.children.cycles-pp.show_interrupts
      7.92 ± 77%      -5.4        2.50 ±142%  perf-profile.children.cycles-pp.seq_printf
      4.44 ±100%      -4.4        0.00        perf-profile.children.cycles-pp.ring_buffer_read_head
      4.16 ±100%      -4.2        0.00        perf-profile.children.cycles-pp.__d_lookup
      4.16 ±100%      -4.2        0.00        perf-profile.children.cycles-pp.d_hash_and_lookup
      4.16 ±100%      -4.2        0.00        perf-profile.children.cycles-pp.proc_fill_cache
      6.60 ± 86%      -4.1        2.50 ±142%  perf-profile.children.cycles-pp.do_fault
      6.60 ± 86%      -4.1        2.50 ±142%  perf-profile.children.cycles-pp.do_read_fault
      3.82 ±101%      -3.8        0.00        perf-profile.children.cycles-pp.mtree_load
      5.49 ±114%      -2.3        3.15 ±147%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      4.10 ±103%      -1.3        2.78 ±141%  perf-profile.children.cycles-pp.link_path_walk
      3.82 ±101%      -1.3        2.50 ±142%  perf-profile.children.cycles-pp.filemap_map_pages
      5.14 ±102%      -1.2        3.89 ±159%  perf-profile.children.cycles-pp.vsnprintf
      4.16 ±100%      -4.2        0.00        perf-profile.self.cycles-pp.__d_lookup
      3.82 ±101%      -3.8        0.00        perf-profile.self.cycles-pp.mtree_load
 2.149e+09           -13.1%  1.867e+09        perf-stat.i.branch-instructions
      0.43 ±  3%      +0.1        0.50 ±  3%  perf-stat.i.branch-miss-rate%
  13647408 ±  3%     -12.1%   11990986 ±  5%  perf-stat.i.branch-misses
   7630275 ±  5%     -31.3%    5238581 ±  3%  perf-stat.i.cache-references
      4828 ±  7%     -28.8%       3436 ±  9%  perf-stat.i.context-switches
      0.61            +2.3%       0.62        perf-stat.i.cpi
 6.443e+09           -11.0%  5.735e+09        perf-stat.i.cpu-cycles
     81.55            -6.3%      76.42        perf-stat.i.cpu-migrations
 2.743e+09           -13.3%  2.378e+09        perf-stat.i.dTLB-loads
      0.00 ±  5%      -0.0        0.00 ±  5%  perf-stat.i.dTLB-store-miss-rate%
     25720 ±  4%     -23.7%      19622 ±  4%  perf-stat.i.dTLB-store-misses
 1.512e+09           -13.6%  1.306e+09        perf-stat.i.dTLB-stores
 1.047e+10           -12.7%  9.148e+09        perf-stat.i.instructions
      1.67            -2.9%       1.62        perf-stat.i.ipc
      0.10           -10.9%       0.09        perf-stat.i.metric.GHz
    121.28 ±  5%     -31.3%      83.33 ±  3%  perf-stat.i.metric.K/sec
     99.98           -13.3%      86.70        perf-stat.i.metric.M/sec
      3110           -14.6%       2655        perf-stat.i.minor-faults
     78137 ±  7%     -14.6%      66753 ±  6%  perf-stat.i.node-load-misses
      3110           -14.6%       2655        perf-stat.i.page-faults
      7.36 ±  7%      +0.9        8.28 ±  6%  perf-stat.overall.cache-miss-rate%
      0.62            +1.9%       0.63        perf-stat.overall.cpi
     11564 ± 10%     +14.8%      13275 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  5%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      1.63            -1.9%       1.60        perf-stat.overall.ipc
      6008 ±  2%     +47.2%       8842        perf-stat.overall.path-length
 2.043e+09           -11.3%  1.812e+09        perf-stat.ps.branch-instructions
  12980852 ±  3%     -10.3%   11643888 ±  5%  perf-stat.ps.branch-misses
   7260442 ±  5%     -29.9%    5088495 ±  3%  perf-stat.ps.cache-references
      4595 ±  7%     -27.3%       3338 ±  9%  perf-stat.ps.context-switches
     60864            +2.0%      62100        perf-stat.ps.cpu-clock
 6.126e+09            -9.2%  5.565e+09        perf-stat.ps.cpu-cycles
     77.48            -4.3%      74.12        perf-stat.ps.cpu-migrations
 2.608e+09           -11.5%  2.307e+09        perf-stat.ps.dTLB-loads
     24434 ±  4%     -22.1%      19039 ±  4%  perf-stat.ps.dTLB-store-misses
 1.437e+09           -11.8%  1.267e+09        perf-stat.ps.dTLB-stores
 9.957e+09           -10.9%  8.876e+09        perf-stat.ps.instructions
      2954           -12.8%       2575        perf-stat.ps.minor-faults
      2954           -12.8%       2575        perf-stat.ps.page-faults
     60864            +2.0%      62100        perf-stat.ps.task-clock
 2.016e+11 ±  2%     +47.2%  2.967e+11        perf-stat.total.instructions


***************************************************************************************************
lkp-icl-2sp5: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase:
  gcc-12/performance/directio/1SSD/btrfs/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/DWOM/fxmark

commit: 
  f044b31867 ("btrfs: handle the ro->rw transition for mounting different subvolumes")
  ad21f15b0f ("btrfs: switch to the new mount API")

f044b318675f0347 ad21f15b0f795daf8723dddbcb6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  69361406           -50.3%   34485394        cpuidle..usage
      7.66          +774.2%      67.00        iostat.cpu.idle
     68.01           -79.6%      13.91        iostat.cpu.iowait
     17.51 ±  2%     -29.8%      12.29        iostat.cpu.system
   1371188 ±  4%     -19.3%    1106420 ±  3%  numa-numastat.node0.local_node
   1420052 ±  3%     -19.2%    1147094        numa-numastat.node0.numa_hit
    402708 ± 17%     -56.5%     175110 ± 22%  numa-numastat.node1.local_node
    487323 ± 10%     -45.0%     267903 ±  9%  numa-numastat.node1.numa_hit
      9.27           +59.3       68.60        mpstat.cpu.all.idle%
     67.92           -54.0       13.91        mpstat.cpu.all.iowait%
      3.22            -0.5        2.72        mpstat.cpu.all.irq%
      1.08 ±  2%      -0.5        0.62        mpstat.cpu.all.soft%
     13.72            -4.4        9.35        mpstat.cpu.all.sys%
    148.00 ±  8%     -90.8%      13.67 ± 15%  perf-c2c.DRAM.local
      2518 ±  4%     -82.9%     430.33 ±  8%  perf-c2c.DRAM.remote
      3376 ±  4%     -79.2%     702.00 ± 12%  perf-c2c.HITM.local
      1626 ±  4%     -83.7%     265.50 ± 12%  perf-c2c.HITM.remote
      5003 ±  3%     -80.7%     967.50 ± 11%  perf-c2c.HITM.total
      7.46          +803.5%      67.38        vmstat.cpu.id
     68.71           -79.5%      14.06        vmstat.cpu.wa
    198460           -62.7%      74117        vmstat.io.bo
   4181054           -23.6%    3193893        vmstat.memory.cache
     21.56           -98.1%       0.40 ±  5%  vmstat.procs.b
      4.91 ±  3%     -25.5%       3.66 ±  2%  vmstat.procs.r
    299183           -58.9%     122960        vmstat.system.cs
     83215           -38.9%      50866        vmstat.system.in
    298827           -58.9%     122858        perf-stat.i.context-switches
      4461           -98.5%      67.54        perf-stat.i.cpu-migrations
     40.02 ±  2%     -20.9%      31.63 ±  2%  perf-stat.i.metric.K/sec
      2873            -6.9%       2675        perf-stat.i.minor-faults
      2874            -6.9%       2675        perf-stat.i.page-faults
    298034           -58.9%     122435        perf-stat.ps.context-switches
      4449           -98.5%      67.43        perf-stat.ps.cpu-migrations
      2868            -6.9%       2670        perf-stat.ps.minor-faults
      2869            -6.9%       2671        perf-stat.ps.page-faults
    106290 ±  3%     -67.9%      34082        meminfo.Active
     85218 ±  3%     -78.7%      18139        meminfo.Active(anon)
     21071           -24.3%      15942        meminfo.Active(file)
   4101090           -24.0%    3115383        meminfo.Cached
   1673122 ±  2%     -58.4%     696414        meminfo.Committed_AS
      5164           -67.6%       1675        meminfo.Dirty
   1455772 ±  2%     -62.7%     542486        meminfo.Inactive
   1454295 ±  2%     -62.8%     541172        meminfo.Inactive(anon)
     50565           -27.9%      36446        meminfo.Mapped
   5519514           -19.0%    4468563        meminfo.Memused
    332021           -21.5%     260697        meminfo.SUnreclaim
   1223105 ±  2%     -80.1%     242873        meminfo.Shmem
    412735           -17.8%     339339        meminfo.Slab
   6807526           -17.8%    5593948        meminfo.max_used_kB
    143.67           -30.7%      99.50        turbostat.Avg_MHz
      4.44            -1.2        3.26        turbostat.Busy%
      3238            -5.8%       3052        turbostat.Bzy_MHz
  21748103           -75.8%    5261452 ±  2%  turbostat.C1
      1.63            -1.3        0.31 ±  2%  turbostat.C1%
  38276710           -45.1%   21002741        turbostat.C1E
     14.63            -6.8        7.78        turbostat.C1E%
   1404698          +366.3%    6549725        turbostat.C6
      3.75            +9.2       12.97        turbostat.C6%
     34.53           -44.9%      19.02        turbostat.CPU%c1
     61.03           +27.3%      77.72        turbostat.CPU%c6
      0.14           -35.7%       0.09        turbostat.IPC
  32917978           -39.6%   19887608        turbostat.IRQ
   7901422 ±  4%     -79.2%    1640010 ±  9%  turbostat.POLL
      0.42 ±  3%      -0.3        0.09 ± 11%  turbostat.POLL%
      7.35 ± 27%     -17.1%       6.09        turbostat.Pkg%pc2
    223.34            -8.1%     205.22        turbostat.PkgWatt
     47.28            -2.3%      46.18        turbostat.RAMWatt
     88074 ±  4%     -62.3%      33219        numa-meminfo.node0.Active
     68942 ±  5%     -74.5%      17606        numa-meminfo.node0.Active(anon)
     19131           -18.4%      15612        numa-meminfo.node0.Active(file)
      3858           -62.3%       1454        numa-meminfo.node0.Dirty
   2904126 ± 41%     -58.6%    1203536 ±106%  numa-meminfo.node0.FilePages
   1061670 ±  8%     -62.6%     397000 ± 15%  numa-meminfo.node0.Inactive
   1060467 ±  8%     -62.7%     395880 ± 16%  numa-meminfo.node0.Inactive(anon)
     34326 ± 44%     -60.6%      13511 ±113%  numa-meminfo.node0.Mapped
   3724670 ± 32%     -49.0%    1899258 ± 69%  numa-meminfo.node0.MemUsed
    212385 ±  7%     -28.0%     152872 ±  8%  numa-meminfo.node0.SUnreclaim
    982532 ±  4%     -76.1%     234878        numa-meminfo.node0.Shmem
    263701 ±  8%     -30.1%     184458 ± 17%  numa-meminfo.node0.Slab
     17885 ± 27%     -95.2%     862.55 ±  7%  numa-meminfo.node1.Active
     15953 ± 30%     -96.7%     518.88 ± 12%  numa-meminfo.node1.Active(anon)
      1932 ±  5%     -82.2%     343.68 ±  3%  numa-meminfo.node1.Active(file)
      1313 ±  5%     -82.8%     225.24 ±  3%  numa-meminfo.node1.Dirty
    394525 ± 24%     -63.1%     145598 ± 44%  numa-meminfo.node1.Inactive
    394258 ± 24%     -63.1%     145404 ± 44%  numa-meminfo.node1.Inactive(anon)
    240590 ± 25%     -96.7%       7980 ± 40%  numa-meminfo.node1.Shmem
      0.32 ±  4%     -23.9%       0.24 ±  9%  sched_debug.cfs_rq:/.nr_running.stddev
    369.85 ±  3%     +27.7%     472.20        sched_debug.cfs_rq:/.runnable_avg.avg
    253.57 ±  4%     +39.2%     353.02 ±  3%  sched_debug.cfs_rq:/.runnable_avg.min
    158.07 ±  3%     -17.6%     130.32 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    307.46 ±  2%     +32.1%     406.18        sched_debug.cfs_rq:/.util_avg.avg
    201.33 ±  5%     +34.8%     271.40 ±  4%  sched_debug.cfs_rq:/.util_avg.min
    148.65 ±  6%     -14.6%     126.90 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
     62.95 ± 34%     -55.5%      28.04 ± 54%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    440.05 ±  9%     -32.6%     296.62 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.max
    354428           +16.7%     413588        sched_debug.cpu.avg_idle.avg
    484006 ±  6%     +30.2%     630320 ±  6%  sched_debug.cpu.avg_idle.max
     85803 ±  8%     +43.7%     123321 ±  3%  sched_debug.cpu.avg_idle.stddev
      2489           -34.7%       1626 ± 21%  sched_debug.cpu.clock_task.stddev
      4264 ±  4%     +25.6%       5357 ±  2%  sched_debug.cpu.curr->pid.avg
      2341 ±  9%     +59.5%       3733        sched_debug.cpu.curr->pid.min
      2722 ±  6%     -16.2%       2282        sched_debug.cpu.curr->pid.stddev
      0.91 ± 20%     -34.1%       0.60 ± 17%  sched_debug.cpu.nr_running.avg
   3757401 ±  2%     -36.1%    2399126 ±  4%  sched_debug.cpu.nr_switches.avg
   4725160           -35.3%    3056363 ±  5%  sched_debug.cpu.nr_switches.max
   3568540 ±  2%     -39.4%    2164175 ±  4%  sched_debug.cpu.nr_switches.min
      1529 ±  6%     -98.4%      23.88 ± 79%  sched_debug.cpu.nr_uninterruptible.max
   -294.64           -88.2%     -34.83        sched_debug.cpu.nr_uninterruptible.min
    349.34 ± 16%     -96.0%      13.84 ± 40%  sched_debug.cpu.nr_uninterruptible.stddev
     17221 ±  5%     -74.5%       4386        numa-vmstat.node0.nr_active_anon
      4783           -18.4%       3902        numa-vmstat.node0.nr_active_file
     70793           -25.8%      52550        numa-vmstat.node0.nr_dirtied
    962.16           -62.2%     364.10        numa-vmstat.node0.nr_dirty
    726035 ± 41%     -58.6%     300885 ±106%  numa-vmstat.node0.nr_file_pages
    265135 ±  8%     -62.7%      98986 ± 15%  numa-vmstat.node0.nr_inactive_anon
      8590 ± 44%     -60.7%       3379 ±113%  numa-vmstat.node0.nr_mapped
     86.66 ± 56%     -42.7%      49.62 ± 93%  numa-vmstat.node0.nr_mlock
    245635 ±  4%     -76.1%      58719        numa-vmstat.node0.nr_shmem
     53098 ±  7%     -28.0%      38215 ±  8%  numa-vmstat.node0.nr_slab_unreclaimable
     17221 ±  5%     -74.5%       4386        numa-vmstat.node0.nr_zone_active_anon
      4783           -18.4%       3902        numa-vmstat.node0.nr_zone_active_file
    265135 ±  8%     -62.7%      98986 ± 15%  numa-vmstat.node0.nr_zone_inactive_anon
    961.81           -62.2%     363.35        numa-vmstat.node0.nr_zone_write_pending
   1419946 ±  3%     -19.2%    1147445        numa-vmstat.node0.numa_hit
   1371083 ±  4%     -19.3%    1106765 ±  3%  numa-vmstat.node0.numa_local
      3988 ± 30%     -96.7%     129.75 ± 12%  numa-vmstat.node1.nr_active_anon
    483.11 ±  5%     -82.2%      85.92 ±  3%  numa-vmstat.node1.nr_active_file
      8434 ±  3%     -82.7%       1460 ± 12%  numa-vmstat.node1.nr_dirtied
    328.28 ±  5%     -82.9%      56.28 ±  3%  numa-vmstat.node1.nr_dirty
     98568 ± 24%     -63.1%      36352 ± 44%  numa-vmstat.node1.nr_inactive_anon
     60149 ± 25%     -96.7%       1995 ± 40%  numa-vmstat.node1.nr_shmem
      1318 ± 11%     -25.8%     978.17 ± 17%  numa-vmstat.node1.nr_written
      3988 ± 30%     -96.7%     129.75 ± 12%  numa-vmstat.node1.nr_zone_active_anon
    483.11 ±  5%     -82.2%      85.92 ±  3%  numa-vmstat.node1.nr_zone_active_file
     98568 ± 24%     -63.1%      36352 ± 44%  numa-vmstat.node1.nr_zone_inactive_anon
    328.31 ±  5%     -82.8%      56.43 ±  3%  numa-vmstat.node1.nr_zone_write_pending
    487087 ± 10%     -45.0%     267948 ±  9%  numa-vmstat.node1.numa_hit
    402472 ± 17%     -56.5%     175155 ± 22%  numa-vmstat.node1.numa_local
     21278 ±  3%     -78.7%       4538        proc-vmstat.nr_active_anon
      5264           -24.2%       3987        proc-vmstat.nr_active_file
     79228           -31.8%      54011        proc-vmstat.nr_dirtied
      1292           -67.5%     420.00        proc-vmstat.nr_dirty
   1025269           -24.0%     778851        proc-vmstat.nr_file_pages
    363616 ±  2%     -62.8%     135306        proc-vmstat.nr_inactive_anon
    367.76 ±  6%     -10.4%     329.58        proc-vmstat.nr_inactive_file
     12681           -28.0%       9126        proc-vmstat.nr_mapped
    305775 ±  2%     -80.1%      60717        proc-vmstat.nr_shmem
     20178            -2.6%      19660        proc-vmstat.nr_slab_reclaimable
     83003           -21.5%      65176        proc-vmstat.nr_slab_unreclaimable
     39465            -6.6%      36872        proc-vmstat.nr_written
     21278 ±  3%     -78.7%       4538        proc-vmstat.nr_zone_active_anon
      5264           -24.2%       3987        proc-vmstat.nr_zone_active_file
    363616 ±  2%     -62.8%     135306        proc-vmstat.nr_zone_inactive_anon
    367.76 ±  6%     -10.4%     329.58        proc-vmstat.nr_zone_inactive_file
      1292           -67.5%     419.63        proc-vmstat.nr_zone_write_pending
     35417 ± 22%     -53.3%      16554 ± 19%  proc-vmstat.numa_hint_faults
     14782 ± 22%     -25.6%      11004 ±  4%  proc-vmstat.numa_hint_faults_local
   1909104           -25.7%    1418705        proc-vmstat.numa_hit
   1775632           -27.6%    1285231        proc-vmstat.numa_local
     13423 ± 16%     -51.4%       6529 ± 58%  proc-vmstat.numa_pages_migrated
    158174 ±  7%     -58.9%      64988 ± 18%  proc-vmstat.numa_pte_updates
    294518 ±  2%     -76.4%      69424        proc-vmstat.pgactivate
   2325713           -28.4%    1665375        proc-vmstat.pgalloc_normal
    365068 ±  2%     -74.5%      93160        proc-vmstat.pgdeactivate
   1404927            -6.4%    1314855        proc-vmstat.pgfault
   1978920           -19.7%    1588295        proc-vmstat.pgfree
     13423 ± 16%     -51.4%       6529 ± 58%  proc-vmstat.pgmigrate_success
  78558198           -63.1%   29004774        proc-vmstat.pgpgout
     95590            -6.9%      89026        proc-vmstat.pgreuse
     32134            -8.8%      29292        proc-vmstat.pgrotated
     21.39 ±  5%   +3779.3%     829.65        fxmark.ssd_btrfs_DWOM_18_directio.idle_sec
      2.40 ±  5%   +3775.9%      93.00        fxmark.ssd_btrfs_DWOM_18_directio.idle_util
    798.98           -96.1%      30.97        fxmark.ssd_btrfs_DWOM_18_directio.iowait_sec
     89.63           -96.1%       3.47        fxmark.ssd_btrfs_DWOM_18_directio.iowait_util
     12.97 ±  3%     -31.5%       8.89        fxmark.ssd_btrfs_DWOM_18_directio.irq_sec
      1.46 ±  3%     -31.5%       1.00        fxmark.ssd_btrfs_DWOM_18_directio.irq_util
      4.43 ±  4%     -64.2%       1.58        fxmark.ssd_btrfs_DWOM_18_directio.softirq_sec
      0.50 ±  4%     -64.3%       0.18        fxmark.ssd_btrfs_DWOM_18_directio.softirq_util
     52.81 ±  4%     -61.1%      20.57        fxmark.ssd_btrfs_DWOM_18_directio.sys_sec
      5.92 ±  4%     -61.1%       2.31        fxmark.ssd_btrfs_DWOM_18_directio.sys_util
      0.79 ±  5%     -42.1%       0.46 ±  4%  fxmark.ssd_btrfs_DWOM_18_directio.user_sec
      0.09 ±  5%     -42.2%       0.05 ±  4%  fxmark.ssd_btrfs_DWOM_18_directio.user_util
   2943942 ±  4%     -63.4%    1076247        fxmark.ssd_btrfs_DWOM_18_directio.works
     58878 ±  4%     -63.4%      21523        fxmark.ssd_btrfs_DWOM_18_directio.works/sec
      5.22 ±  5%    +710.6%      42.27        fxmark.ssd_btrfs_DWOM_2_directio.idle_sec
      5.46 ±  6%    +711.2%      44.26        fxmark.ssd_btrfs_DWOM_2_directio.idle_util
     55.86 ±  2%     -47.2%      29.50        fxmark.ssd_btrfs_DWOM_2_directio.iowait_sec
     58.44 ±  2%     -47.1%      30.88        fxmark.ssd_btrfs_DWOM_2_directio.iowait_util
      6.32 ±  3%     -33.4%       4.21        fxmark.ssd_btrfs_DWOM_2_directio.irq_sec
      6.61 ±  3%     -33.4%       4.40        fxmark.ssd_btrfs_DWOM_2_directio.irq_util
      2.40 ±  5%     -43.3%       1.36        fxmark.ssd_btrfs_DWOM_2_directio.softirq_sec
      2.51 ±  5%     -43.3%       1.43        fxmark.ssd_btrfs_DWOM_2_directio.softirq_util
     25.32 ±  3%     -29.7%      17.80        fxmark.ssd_btrfs_DWOM_2_directio.sys_sec
     26.49 ±  3%     -29.6%      18.64        fxmark.ssd_btrfs_DWOM_2_directio.sys_util
      0.47 ±  4%     -22.5%       0.36 ±  3%  fxmark.ssd_btrfs_DWOM_2_directio.user_sec
      0.49 ±  4%     -22.4%       0.38 ±  3%  fxmark.ssd_btrfs_DWOM_2_directio.user_util
   1803416 ±  3%     -38.5%    1109810        fxmark.ssd_btrfs_DWOM_2_directio.works
     36068 ±  3%     -38.5%      22195        fxmark.ssd_btrfs_DWOM_2_directio.works/sec
     33.42 ±  3%   +5025.9%       1712        fxmark.ssd_btrfs_DWOM_36_directio.idle_sec
      1.87 ±  3%   +4994.3%      95.40        fxmark.ssd_btrfs_DWOM_36_directio.idle_util
      1643           -98.4%      26.29        fxmark.ssd_btrfs_DWOM_36_directio.iowait_sec
     92.09           -98.4%       1.46        fxmark.ssd_btrfs_DWOM_36_directio.iowait_util
      7.28           -72.2%       2.02        fxmark.ssd_btrfs_DWOM_36_directio.softirq_sec
      0.41           -72.4%       0.11        fxmark.ssd_btrfs_DWOM_36_directio.softirq_util
     80.68           -58.0%      33.88        fxmark.ssd_btrfs_DWOM_36_directio.sys_sec
      4.52           -58.3%       1.89        fxmark.ssd_btrfs_DWOM_36_directio.sys_util
      1.09 ±  2%     -37.2%       0.69 ±  2%  fxmark.ssd_btrfs_DWOM_36_directio.user_sec
      0.06 ±  2%     -37.6%       0.04 ±  2%  fxmark.ssd_btrfs_DWOM_36_directio.user_util
   3105115           -70.3%     920885        fxmark.ssd_btrfs_DWOM_36_directio.works
     62086           -70.3%      18416        fxmark.ssd_btrfs_DWOM_36_directio.works/sec
     11.17 ±  5%   +1141.7%     138.74        fxmark.ssd_btrfs_DWOM_4_directio.idle_sec
      5.83 ±  5%   +1119.6%      71.06        fxmark.ssd_btrfs_DWOM_4_directio.idle_util
    122.54 ±  2%     -74.7%      31.00        fxmark.ssd_btrfs_DWOM_4_directio.iowait_sec
     63.89 ±  2%     -75.1%      15.88        fxmark.ssd_btrfs_DWOM_4_directio.iowait_util
     10.33 ±  4%     -55.7%       4.58        fxmark.ssd_btrfs_DWOM_4_directio.irq_sec
      5.39 ±  4%     -56.5%       2.34        fxmark.ssd_btrfs_DWOM_4_directio.irq_util
      4.39 ±  4%     -65.2%       1.53        fxmark.ssd_btrfs_DWOM_4_directio.softirq_sec
      2.29 ±  4%     -65.8%       0.78        fxmark.ssd_btrfs_DWOM_4_directio.softirq_util
     42.73 ±  4%     -55.5%      19.00        fxmark.ssd_btrfs_DWOM_4_directio.sys_sec
     22.28 ±  4%     -56.3%       9.73        fxmark.ssd_btrfs_DWOM_4_directio.sys_util
      0.63 ±  4%     -39.5%       0.38 ±  8%  fxmark.ssd_btrfs_DWOM_4_directio.user_sec
      0.33 ±  4%     -40.6%       0.20 ±  7%  fxmark.ssd_btrfs_DWOM_4_directio.user_util
   2853291 ±  4%     -61.1%    1108617        fxmark.ssd_btrfs_DWOM_4_directio.works
     57065 ±  4%     -61.1%      22171        fxmark.ssd_btrfs_DWOM_4_directio.works/sec
     86.44 ±  4%   +2899.6%       2592        fxmark.ssd_btrfs_DWOM_54_directio.idle_sec
      3.24 ±  4%   +2862.6%      95.99        fxmark.ssd_btrfs_DWOM_54_directio.idle_util
      2408           -99.1%      21.85 ±  2%  fxmark.ssd_btrfs_DWOM_54_directio.iowait_sec
     90.26           -99.1%       0.81 ±  2%  fxmark.ssd_btrfs_DWOM_54_directio.iowait_util
     21.96           +72.3%      37.85 ±  3%  fxmark.ssd_btrfs_DWOM_54_directio.irq_sec
      0.82           +70.2%       1.40 ±  3%  fxmark.ssd_btrfs_DWOM_54_directio.irq_util
      9.41           -73.8%       2.46 ±  3%  fxmark.ssd_btrfs_DWOM_54_directio.softirq_sec
      0.35           -74.1%       0.09 ±  3%  fxmark.ssd_btrfs_DWOM_54_directio.softirq_util
    140.45 ±  2%     -67.8%      45.25 ±  2%  fxmark.ssd_btrfs_DWOM_54_directio.sys_sec
      5.26 ±  2%     -68.2%       1.67 ±  2%  fxmark.ssd_btrfs_DWOM_54_directio.sys_util
      1.59 ±  2%     -38.9%       0.97 ±  2%  fxmark.ssd_btrfs_DWOM_54_directio.user_sec
      0.06 ±  2%     -39.6%       0.04 ±  2%  fxmark.ssd_btrfs_DWOM_54_directio.user_util
   3576656           -78.4%     771481 ±  2%  fxmark.ssd_btrfs_DWOM_54_directio.works
     71532           -78.4%      15427 ±  2%  fxmark.ssd_btrfs_DWOM_54_directio.works/sec
    140.45 ± 28%   +2364.1%       3460        fxmark.ssd_btrfs_DWOM_72_directio.idle_sec
      3.94 ± 27%   +2342.3%      96.14        fxmark.ssd_btrfs_DWOM_72_directio.idle_util
      3172           -99.4%      20.58        fxmark.ssd_btrfs_DWOM_72_directio.iowait_sec
     89.05           -99.4%       0.57        fxmark.ssd_btrfs_DWOM_72_directio.iowait_util
     31.18 ±  2%    +117.6%      67.84 ±  2%  fxmark.ssd_btrfs_DWOM_72_directio.irq_sec
      0.87 ±  2%    +115.4%       1.88 ±  2%  fxmark.ssd_btrfs_DWOM_72_directio.irq_util
     11.16 ±  3%     -71.7%       3.15        fxmark.ssd_btrfs_DWOM_72_directio.softirq_sec
      0.31 ±  3%     -72.0%       0.09        fxmark.ssd_btrfs_DWOM_72_directio.softirq_util
    200.16 ±  9%     -77.3%      45.38        fxmark.ssd_btrfs_DWOM_72_directio.sys_sec
      5.62 ±  9%     -77.6%       1.26        fxmark.ssd_btrfs_DWOM_72_directio.sys_util
      7.35           -70.7%       2.15        fxmark.ssd_btrfs_DWOM_72_directio.user_sec
      0.21           -71.0%       0.06        fxmark.ssd_btrfs_DWOM_72_directio.user_util
   3804008 ±  3%     -80.8%     730085        fxmark.ssd_btrfs_DWOM_72_directio.works
     75689 ±  2%     -80.7%      14598        fxmark.ssd_btrfs_DWOM_72_directio.works/sec
  28132878           -30.5%   19544914        fxmark.time.file_system_outputs
      2740 ± 16%     -51.9%       1319 ± 12%  fxmark.time.involuntary_context_switches
      8.00           -25.0%       6.00        fxmark.time.percent_of_cpu_this_job_got
     32.43           -24.3%      24.56 ±  2%  fxmark.time.system_time
      0.03 ± 67%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.__iomap_dio_rw.btrfs_dio_write
      0.01 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_alloc_path.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      0.01 ± 15%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
      0.01 ± 65%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_search_slot.btrfs_next_old_leaf.find_next_csum_offset.constprop
      0.01 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.00 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_csum
      0.01 ± 94%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
      0.02 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.btrfs_inode_lock.btrfs_direct_write.btrfs_do_write_iter
      0.02 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.btrfs_map_block.btrfs_submit_chunk.btrfs_submit_bio
      0.02 ± 16%     -95.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.find_free_extent.btrfs_reserve_extent.btrfs_new_extent_direct
      0.01 ± 52%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read_killable.__gup_longterm_locked.internal_get_user_pages_fast.pin_user_pages_fast
      0.01 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.01 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_insert_empty_items
      0.00 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_csum
      0.01 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.02 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.__btrfs_qgroup_release_data
      0.02 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_dio_iomap_begin
      0.00 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_finish_one_ordered
      0.01 ±  7%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      0.03 ± 83%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_ordered_extent.btrfs_alloc_ordered_extent.btrfs_create_dio_extent
      0.00 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.insert_reserved_file_extent
      0.01 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_drop_extents.insert_reserved_file_extent
      0.01 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper
      0.02 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mempool_alloc.bio_alloc_bioset.iomap_dio_bio_iter.__iomap_dio_rw
      0.01 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.__btrfs_release_delayed_node.part.0
      0.00 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_finish_one_ordered
      0.01 ± 12%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      0.00 ± 11%    +931.6%       0.03 ± 52%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio.iomap_dio_bio_iter
      0.04 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ± 16%    +184.0%       0.01 ± 39%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ± 22%    +310.0%       0.01 ± 35%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ± 20%   +2200.0%       0.04 ±  9%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01          +396.7%       0.02 ± 24%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
      0.02 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.00          +516.7%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±  9%    +404.3%       0.02 ± 41%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 40%    +548.7%       0.08 ± 34%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ± 14%    +237.9%       0.02 ± 40%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00           -33.3%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      0.00 ±  9%   +1487.0%       0.06 ±  8%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  7%     +50.0%       0.01        perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.btrfs_dio_write
      0.00 ± 14%    +223.8%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ± 14%    +433.3%       0.02 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ±  4%     -46.0%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 17%    +484.6%       0.04 ± 57%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01           -60.0%       0.00        perf-sched.sch_delay.avg.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_dio_iomap_begin
      0.00 ± 20%   +2572.7%       0.05 ± 14%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.00           +33.3%       0.00        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 88%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.__iomap_dio_rw.btrfs_dio_write
      0.01 ± 26%   +1638.7%       0.09 ± 67%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.06 ± 31%     -93.5%       0.00 ±147%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      0.06 ± 29%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      0.05 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
      0.02 ± 97%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.btrfs_search_slot.btrfs_next_old_leaf.find_next_csum_offset.constprop
      0.07 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.03 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_csum
      0.01 ± 53%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
      0.05 ± 83%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.btrfs_inode_lock.btrfs_direct_write.btrfs_do_write_iter
      0.08 ± 46%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.btrfs_map_block.btrfs_submit_chunk.btrfs_submit_bio
      0.20 ± 35%     -99.4%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.find_free_extent.btrfs_reserve_extent.btrfs_new_extent_direct
      0.03 ± 72%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read_killable.__gup_longterm_locked.internal_get_user_pages_fast.pin_user_pages_fast
      0.06 ± 29%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.02 ± 55%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_insert_empty_items
      0.02 ± 28%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_csum
      0.76 ±203%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.10 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.__btrfs_qgroup_release_data
      0.08 ± 32%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_dio_iomap_begin
      0.02 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_finish_one_ordered
      0.08 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      0.07 ± 14%     -95.6%       0.00 ±173%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.set_extent_bit
      0.28 ±158%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_ordered_extent.btrfs_alloc_ordered_extent.btrfs_create_dio_extent
      0.02 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.insert_reserved_file_extent
      0.05 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_drop_extents.insert_reserved_file_extent
      0.08 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper
      0.06 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mempool_alloc.bio_alloc_bioset.iomap_dio_bio_iter.__iomap_dio_rw
      0.02 ± 32%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.__btrfs_release_delayed_node.part.0
      0.16 ±171%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_finish_one_ordered
      0.05 ± 18%     -96.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.09 ± 43%     -77.2%       0.02 ± 92%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      0.01 ± 64%    +980.9%       0.16 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.05 ± 67%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio.iomap_dio_bio_iter
      0.05 ± 59%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 28%    +344.2%       0.03 ± 56%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.44 ± 11%     -99.7%       0.01 ± 65%  perf-sched.sch_delay.max.ms.btrfs_start_ordered_extent.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
      0.01 ± 26%    +748.8%       0.12 ± 78%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 30%    +375.9%       0.02 ± 34%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 25%   +2297.0%       0.26 ± 14%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 31%   +2088.8%       0.29 ± 10%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 29%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
      0.10 ± 72%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.03 ± 52%   +1040.6%       0.30 ± 13%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 11%   +1715.0%       0.12 ± 64%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 60%    +289.1%       0.04 ± 80%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.02 ± 41%    +405.1%       0.12 ± 21%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 29%    +971.2%       0.09 ± 53%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6.76 ± 38%     -93.0%       0.47 ±147%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      2.24 ±107%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      0.01 ± 42%   +2416.4%       0.23 ± 20%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 35%    +204.3%       0.02 ±  5%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 35%   +1820.6%       0.22 ± 26%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 29%    +593.9%       0.06 ± 65%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      5.18 ±  8%     -98.9%       0.06 ± 11%  perf-sched.sch_delay.max.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_dio_iomap_begin
      0.69 ± 90%     -99.9%       0.00 ±223%  perf-sched.sch_delay.max.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_finish_one_ordered
      0.01 ± 89%   +4046.7%       0.21 ± 19%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      4.74 ± 18%     -40.2%       2.83 ± 46%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 10%    +185.7%       0.01 ±  3%  perf-sched.total_sch_delay.average.ms
     14.59 ±  8%     +52.0%      22.17 ± 15%  perf-sched.total_sch_delay.max.ms
      1.24 ±  3%    +242.7%       4.24 ±  2%  perf-sched.total_wait_and_delay.average.ms
   1345072 ±  2%     -82.3%     237585        perf-sched.total_wait_and_delay.count.ms
      1.23 ±  3%    +242.9%       4.23 ±  2%  perf-sched.total_wait_time.average.ms
      9.25 ± 59%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     17.10 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.89 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.btrfs_start_ordered_extent.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
      1.73 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    172.31 ± 12%     +35.8%     234.05 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     39.69 ±  3%     -11.0%      35.32        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.03 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     30.40 ±  2%    +467.2%     172.46 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.45 ± 24%     -88.2%       0.05 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.17 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
     47.94 ± 10%     -16.0%      40.29 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     24.25 ±  2%   +2281.0%     577.49 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.74 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.88 ±  3%     -96.7%       0.03        perf-sched.wait_and_delay.avg.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_dio_iomap_begin
      1.69 ±  2%     +25.6%       2.12 ±  7%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     14.83 ± 19%     -92.1%       1.17 ±115%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio
     13.83 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     38.83 ± 26%     -96.1%       1.50 ±166%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     14.83 ± 33%     -97.8%       0.33 ±141%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      9.00 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
     94993 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.btrfs_start_ordered_extent.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
      2.00          -100.0%       0.00        perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.67 ± 38%     -92.9%       0.33 ±223%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1819 ±  3%     +12.3%       2043        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     22.83 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    495.50 ±  2%     -80.6%      96.00 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    141244 ±  5%     -95.1%       6991 ±  5%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     26489 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    380954 ±  2%     -81.8%      69320        perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.btrfs_dio_write
     99.83 ± 11%     +21.7%     121.50 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     16383 ±  2%     -96.3%     601.00        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.00          -100.0%       0.00        perf-sched.wait_and_delay.count.syslog_print.do_syslog.kmsg_read.vfs_read
    256053 ±  2%     -84.0%      40924 ±  2%  perf-sched.wait_and_delay.count.wait_extent_bit.constprop.0.lock_extent.btrfs_dio_iomap_begin
    412448 ±  2%     -83.1%      69652        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     68.02 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     59.45 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      9.07 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.btrfs_start_ordered_extent.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
      3.46 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.83 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      2173 ± 44%     -99.2%      16.42 ±  5%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    307.82 ±101%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
     30.42 ±  4%     -32.6%      20.51 ± 15%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.btrfs_dio_write
      3.47 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      9.12 ±  9%     -88.4%       1.06 ±151%  perf-sched.wait_and_delay.max.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_dio_iomap_begin
      9.25 ± 59%    -100.0%       0.00 ±142%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.88 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.__iomap_dio_rw.btrfs_dio_write
      0.13 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      0.04 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_insert_empty_items.btrfs_csum_file_blocks.btrfs_finish_one_ordered
      0.12 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
      0.11 ± 81%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_next_old_leaf.find_next_csum_offset.constprop
      0.09 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.06 ± 55%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_csum
      0.05 ± 61%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
      0.75 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.btrfs_inode_lock.btrfs_direct_write.btrfs_do_write_iter
      0.31 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.btrfs_map_block.btrfs_submit_chunk.btrfs_submit_bio
      0.29 ± 11%     -97.9%       0.01 ±165%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.find_free_extent.btrfs_reserve_extent.btrfs_new_extent_direct
      0.36 ± 86%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read_killable.__gup_longterm_locked.internal_get_user_pages_fast.pin_user_pages_fast
      0.09 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.08 ± 63%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_insert_empty_items
      0.13 ±103%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_csum
      0.10 ± 23%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.28 ± 60%     -99.5%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_map.create_io_em.btrfs_create_dio_extent
      0.40 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.__btrfs_qgroup_release_data
      0.30 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_dio_iomap_begin
      0.24 ±169%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_finish_one_ordered
      0.18 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      0.31 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_ordered_extent.btrfs_alloc_ordered_extent.btrfs_create_dio_extent
      0.14 ±128%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.insert_reserved_file_extent
      0.07 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_drop_extents.insert_reserved_file_extent
      0.15 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper
      0.34 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mempool_alloc.bio_alloc_bioset.iomap_dio_bio_iter.__iomap_dio_rw
      0.09 ± 72%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__btrfs_release_delayed_node.part.0
      0.06 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_finish_one_ordered
      1.68 ± 39%     -99.8%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     11.60 ±110%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     17.10 ± 44%    -100.0%       0.00 ±165%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.14 ± 56%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      0.32 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio.iomap_dio_bio_iter
      0.86 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.89 ±  3%     -96.3%       0.03 ± 10%  perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
    172.31 ± 12%     +35.8%     234.01 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.76 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
     57.23 ±161%    -100.0%       0.01 ± 80%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.08 ± 85%     -82.7%       0.01 ± 67%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      1.84 ± 34%     -99.5%       0.01 ± 39%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     39.69 ±  3%     -11.0%      35.31        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     30.40 ±  2%    +467.2%     172.46 ±  5%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.45 ± 24%     -88.6%       0.05 ± 10%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.17 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      0.38           +63.9%       0.62 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     47.94 ± 10%     -16.0%      40.27 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     24.24 ±  2%   +2282.0%     577.49 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.87 ±  3%     -96.9%       0.03        perf-sched.wait_time.avg.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_dio_iomap_begin
      0.31 ± 22%     -98.0%       0.01 ±223%  perf-sched.wait_time.avg.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_finish_one_ordered
      1.69 ±  2%     +25.6%       2.12 ±  7%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     68.02 ±  5%    -100.0%       0.00 ±141%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.96 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.__iomap_dio_rw.btrfs_dio_write
     49.04 ±202%     -99.9%       0.06 ±172%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      1.49 ± 48%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      0.14 ± 61%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_insert_empty_items.btrfs_csum_file_blocks.btrfs_finish_one_ordered
      0.91 ± 72%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
      0.36 ±108%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_next_old_leaf.find_next_csum_offset.constprop
      2.44 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.55 ± 87%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_csum
      0.10 ± 80%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_next_old_leaf
      0.93 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.btrfs_inode_lock.btrfs_direct_write.btrfs_do_write_iter
      0.93 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.btrfs_map_block.btrfs_submit_chunk.btrfs_submit_bio
      1.05 ±  7%     -99.4%       0.01 ±165%  perf-sched.wait_time.max.ms.__cond_resched.down_read.find_free_extent.btrfs_reserve_extent.btrfs_new_extent_direct
      0.64 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read_killable.__gup_longterm_locked.internal_get_user_pages_fast.pin_user_pages_fast
      2.00 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      0.32 ± 53%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_insert_empty_items
      2.80 ±144%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_csum
      4.17 ±126%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.76 ± 43%     -99.8%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_map.create_io_em.btrfs_create_dio_extent
      1.06 ± 12%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.__btrfs_qgroup_release_data
      0.97 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_dio_iomap_begin
      4.28 ±200%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_finish_one_ordered
     21.08 ±177%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      6.72 ± 49%     -98.3%       0.12 ±154%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.set_extent_bit
      1.35 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_ordered_extent.btrfs_alloc_ordered_extent.btrfs_create_dio_extent
      2.10 ±178%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.insert_reserved_file_extent
      0.94 ±107%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_drop_extents.insert_reserved_file_extent
      3.56 ± 39%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper
      1.00 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mempool_alloc.bio_alloc_bioset.iomap_dio_bio_iter.__iomap_dio_rw
      0.41 ± 74%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__btrfs_release_delayed_node.part.0
      2.10 ± 94%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_finish_one_ordered
    190.99 ±195%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     20.45 ± 97%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     59.45 ± 18%    -100.0%       0.00 ±189%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.59 ± 56%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      0.83 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.submit_bio_noacct.btrfs_submit_chunk.btrfs_submit_bio.iomap_dio_bio_iter
      0.91 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.00 ±  9%     -98.9%       0.10 ± 92%  perf-sched.wait_time.max.ms.btrfs_start_ordered_extent.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
     13.24 ±  6%     -52.1%       6.35 ± 85%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.94 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
    334.00 ±140%    -100.0%       0.01 ± 80%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.44 ± 91%     -96.0%       0.02 ± 59%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     23.59 ± 32%     -99.9%       0.03 ± 52%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2173 ± 44%     -99.3%      15.99 ±  3%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    307.82 ±101%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      1.01 ±  3%    +542.9%       6.47 ± 81%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     15.83           +15.3%      18.25 ±  3%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.btrfs_dio_write
      9.02 ±  9%     -88.3%       1.05 ±152%  perf-sched.wait_time.max.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_dio_iomap_begin
    231.69 ± 78%    -100.0%       0.01 ±223%  perf-sched.wait_time.max.ms.wait_extent_bit.constprop.0.lock_extent.btrfs_finish_one_ordered
     42.16           -26.5       15.62 ±  9%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     42.16           -26.5       15.62 ±  9%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     42.16           -26.5       15.62 ±  9%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     30.21           -19.1       11.15 ±  9%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     26.83           -16.0       10.80 ± 10%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     25.69           -15.0       10.66 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
     25.67           -15.0       10.65 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread.kthread
     22.03 ±  2%     -10.9       11.11 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_dio_write.btrfs_direct_write.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64
     22.00 ±  2%     -10.9       11.09 ±  2%  perf-profile.calltrace.cycles-pp.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write.btrfs_do_write_iter.vfs_write
     14.85 ±  3%     -10.2        4.69 ±  4%  perf-profile.calltrace.cycles-pp.iomap_iter.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write.btrfs_do_write_iter
     14.67 ±  3%     -10.1        4.56 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write
     15.20            -9.2        6.04 ± 10%  perf-profile.calltrace.cycles-pp.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
     12.96            -7.7        5.27 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
     11.78 ±  4%      -7.5        4.24 ± 15%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction.transaction_kthread.kthread
     11.79 ±  4%      -7.5        4.25 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.btrfs_commit_transaction.transaction_kthread.kthread.ret_from_fork
     11.79 ±  4%      -7.4        4.39 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.transaction_kthread.kthread.ret_from_fork.ret_from_fork_asm
     11.79 ±  4%      -7.4        4.39 ± 15%  perf-profile.calltrace.cycles-pp.transaction_kthread.kthread.ret_from_fork.ret_from_fork_asm
      7.32 ±  2%      -7.3        0.00        perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      9.91 ±  2%      -7.1        2.80 ±  4%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.79 ±  4%      -6.9        3.85 ± 15%  perf-profile.calltrace.cycles-pp.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction.transaction_kthread
      9.52 ±  4%      -6.5        2.98 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction
      5.86 ±  3%      -5.9        0.00        perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      5.74 ±  3%      -5.7        0.00        perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      5.01 ±  2%      -5.0        0.00        perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      5.59 ±  3%      -4.7        0.86 ±  8%  perf-profile.calltrace.cycles-pp.lock_extent.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw.btrfs_dio_write
      4.94 ±  3%      -4.4        0.58 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      4.92 ±  3%      -4.4        0.56 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered
      3.82 ±  2%      -3.4        0.38 ± 70%  perf-profile.calltrace.cycles-pp.wait_extent_bit.lock_extent.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
      5.50 ±  4%      -2.8        2.65 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_get_blocks_direct_write.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw.btrfs_dio_write
      4.21 ±  3%      -2.8        1.44 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs
      4.38 ± 10%      -2.7        1.70 ±  6%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.18 ±  5%      -2.6        0.59 ± 46%  perf-profile.calltrace.cycles-pp.truncate_one_csum.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs
      2.98 ±  5%      -2.4        0.55 ± 46%  perf-profile.calltrace.cycles-pp.btrfs_truncate_item.truncate_one_csum.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      2.93 ±  2%      -2.3        0.66 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.io_schedule_timeout.__iomap_dio_rw
      2.95 ±  2%      -2.3        0.70 ±  7%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.btrfs_dio_write
      3.10            -2.2        0.87 ±  5%  perf-profile.calltrace.cycles-pp.io_schedule_timeout.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write.btrfs_do_write_iter
      3.08            -2.2        0.85 ±  5%  perf-profile.calltrace.cycles-pp.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write
      3.98 ±  3%      -1.9        2.13 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_new_extent_direct.btrfs_get_blocks_direct_write.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
      2.67 ±  4%      -1.7        1.00 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_create_dio_extent.btrfs_new_extent_direct.btrfs_get_blocks_direct_write.btrfs_dio_iomap_begin.iomap_iter
      1.61 ±  2%      -1.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.btrfs_add_delayed_data_ref.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      1.60 ±  2%      -1.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      1.60 ±  2%      -1.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.btrfs_alloc_reserved_file_extent.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      2.79 ±  3%      -1.2        1.55 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_del_items.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      3.82            -1.0        2.84 ±  6%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.28 ±  4%      -0.8        2.45 ± 11%  perf-profile.calltrace.cycles-pp.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      3.19 ±  4%      -0.8        2.39 ± 11%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered
      2.28            -0.7        1.56 ±  8%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      1.02 ±  4%      -0.7        0.35 ± 70%  perf-profile.calltrace.cycles-pp.create_io_em.btrfs_create_dio_extent.btrfs_new_extent_direct.btrfs_get_blocks_direct_write.btrfs_dio_iomap_begin
      1.81 ±  2%      -0.6        1.17 ± 12%  perf-profile.calltrace.cycles-pp.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent
      1.84            -0.6        1.20 ±  7%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.79 ±  2%      -0.6        1.16 ± 12%  perf-profile.calltrace.cycles-pp.__write_extent_buffer.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents
      1.76 ±  3%      -0.6        1.14 ± 12%  perf-profile.calltrace.cycles-pp.__memmove.__write_extent_buffer.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert
      3.51 ±  2%      -0.6        2.89 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
      1.68 ±  2%      -0.6        1.12 ±  7%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.60            -0.5        1.06 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.92 ±  5%      -0.5        0.39 ± 71%  perf-profile.calltrace.cycles-pp.read_block_for_search.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      1.57 ±  8%      -0.4        1.16 ± 27%  perf-profile.calltrace.cycles-pp.blk_update_request.scsi_end_request.scsi_io_completion.blk_complete_reqs.__do_softirq
      0.86 ±  2%      -0.3        0.55 ±  8%  perf-profile.calltrace.cycles-pp.memcpy_extent_buffer.btrfs_del_items.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered
      0.84 ±  2%      -0.3        0.54 ±  8%  perf-profile.calltrace.cycles-pp.__write_extent_buffer.memcpy_extent_buffer.btrfs_del_items.btrfs_drop_extents.insert_reserved_file_extent
      1.32 ±  3%      -0.3        1.05 ±  7%  perf-profile.calltrace.cycles-pp.blk_complete_reqs.__do_softirq.do_softirq.flush_smp_call_function_queue.do_idle
      1.14 ±  3%      -0.3        0.88 ±  8%  perf-profile.calltrace.cycles-pp.scsi_end_request.scsi_io_completion.blk_complete_reqs.__do_softirq.do_softirq
      1.14 ±  3%      -0.3        0.88 ±  9%  perf-profile.calltrace.cycles-pp.scsi_io_completion.blk_complete_reqs.__do_softirq.do_softirq.flush_smp_call_function_queue
      1.33 ±  3%      -0.2        1.09 ±  8%  perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.33 ±  3%      -0.2        1.10 ±  8%  perf-profile.calltrace.cycles-pp.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.88 ±  2%      -0.2        0.67 ± 12%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      0.98 ±  2%      -0.2        0.76 ± 10%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      0.85 ±  2%      -0.2        0.66 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.60 ±  4%      +0.1        0.71 ±  5%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bio.iomap_dio_bio_iter
      0.75 ±  2%      +0.1        0.88 ±  6%  perf-profile.calltrace.cycles-pp.find_free_extent.btrfs_reserve_extent.btrfs_new_extent_direct.btrfs_get_blocks_direct_write.btrfs_dio_iomap_begin
      0.53 ±  2%      +0.1        0.68 ±  9%  perf-profile.calltrace.cycles-pp.internal_get_user_pages_fast.pin_user_pages_fast.iov_iter_extract_pages.__bio_iov_iter_get_pages.bio_iov_iter_get_pages
      0.54 ±  2%      +0.2        0.70 ±  9%  perf-profile.calltrace.cycles-pp.iov_iter_extract_pages.__bio_iov_iter_get_pages.bio_iov_iter_get_pages.iomap_dio_bio_iter.__iomap_dio_rw
      0.53 ±  2%      +0.2        0.69 ±  9%  perf-profile.calltrace.cycles-pp.pin_user_pages_fast.iov_iter_extract_pages.__bio_iov_iter_get_pages.bio_iov_iter_get_pages.iomap_dio_bio_iter
      0.82 ±  2%      +0.2        0.98 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_reserve_extent.btrfs_new_extent_direct.btrfs_get_blocks_direct_write.btrfs_dio_iomap_begin.iomap_iter
      0.62 ±  4%      +0.2        0.79 ±  5%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bio.iomap_dio_bio_iter.__iomap_dio_rw
      0.56 ±  2%      +0.2        0.75 ±  7%  perf-profile.calltrace.cycles-pp.bio_iov_iter_get_pages.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write
      0.56 ±  2%      +0.2        0.75 ±  8%  perf-profile.calltrace.cycles-pp.__bio_iov_iter_get_pages.bio_iov_iter_get_pages.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_dio_write
      1.56 ±  4%      +0.3        1.83 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bio.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_dio_write
      1.56 ±  4%      +0.3        1.84 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write
      0.00            +0.6        0.57 ±  5%  perf-profile.calltrace.cycles-pp.ata_scsi_queuecmd.scsi_dispatch_cmd.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched
      2.39 ±  2%      +0.6        2.97 ±  4%  perf-profile.calltrace.cycles-pp.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write.btrfs_do_write_iter
      1.04 ±  4%      +0.6        1.64 ±  5%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list
      1.05 ±  4%      +0.6        1.65 ±  5%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug
      1.02 ±  4%      +0.6        1.62 ±  5%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list
      0.00            +0.6        0.62 ±  7%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.6        0.62 ±  9%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write
      0.00            +0.6        0.63 ±  9%  perf-profile.calltrace.cycles-pp.up_write.btrfs_direct_write.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64
      0.00            +0.6        0.64 ±  7%  perf-profile.calltrace.cycles-pp.scsi_dispatch_cmd.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
      0.00            +0.6        0.64 ±  9%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_inode_lock
      0.00            +0.6        0.65 ±  9%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_inode_lock.btrfs_direct_write
      1.10 ±  4%      +0.7        1.78 ±  5%  perf-profile.calltrace.cycles-pp.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug.blk_finish_plug
      1.25 ±  4%      +0.7        1.93 ±  4%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug.blk_finish_plug.__iomap_dio_rw
      1.25 ±  4%      +0.7        1.94 ±  4%  perf-profile.calltrace.cycles-pp.blk_mq_flush_plug_list.__blk_flush_plug.blk_finish_plug.__iomap_dio_rw.btrfs_dio_write
      1.26 ±  3%      +0.7        1.97 ±  4%  perf-profile.calltrace.cycles-pp.__blk_flush_plug.blk_finish_plug.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write
      1.26 ±  3%      +0.7        1.98 ±  4%  perf-profile.calltrace.cycles-pp.blk_finish_plug.__iomap_dio_rw.btrfs_dio_write.btrfs_direct_write.btrfs_do_write_iter
      0.00            +0.8        0.80 ±  7%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.8        0.83 ±  7%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.9        0.86 ± 26%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.39 ± 71%      +0.9        1.27 ± 29%  perf-profile.calltrace.cycles-pp.ahci_qc_complete.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event
      0.00            +0.9        0.88 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +0.9        0.88 ± 26%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
      0.25 ±100%      +0.9        1.18 ±  6%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue
      0.28 ±100%      +1.0        1.24 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.0        1.05 ±  7%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.2        1.16 ±  6%  perf-profile.calltrace.cycles-pp.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.00            +1.2        1.22 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_xattr.btrfs_getxattr.__vfs_getxattr.cap_inode_need_killpriv
      0.00            +1.3        1.25 ±  8%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues
      0.00            +1.4        1.38 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_lookup_xattr.btrfs_getxattr.__vfs_getxattr.cap_inode_need_killpriv.security_inode_need_killpriv
      1.11 ± 17%      +1.5        2.61 ± 27%  perf-profile.calltrace.cycles-pp.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.00            +1.7        1.68 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_getxattr.__vfs_getxattr.cap_inode_need_killpriv.security_inode_need_killpriv.__file_remove_privs
      0.00            +1.8        1.82 ±  6%  perf-profile.calltrace.cycles-pp.__vfs_getxattr.cap_inode_need_killpriv.security_inode_need_killpriv.__file_remove_privs.btrfs_write_check
      0.00            +1.8        1.83 ± 22%  perf-profile.calltrace.cycles-pp.__memmove.__write_extent_buffer.memcpy_extent_buffer.btrfs_extend_item.btrfs_csum_file_blocks
      0.00            +1.8        1.84 ±  7%  perf-profile.calltrace.cycles-pp.cap_inode_need_killpriv.security_inode_need_killpriv.__file_remove_privs.btrfs_write_check.btrfs_direct_write
      0.00            +1.8        1.85 ± 22%  perf-profile.calltrace.cycles-pp.__write_extent_buffer.memcpy_extent_buffer.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered
      0.00            +1.9        1.86 ± 22%  perf-profile.calltrace.cycles-pp.memcpy_extent_buffer.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      0.00            +1.9        1.86 ±  7%  perf-profile.calltrace.cycles-pp.security_inode_need_killpriv.__file_remove_privs.btrfs_write_check.btrfs_direct_write.btrfs_do_write_iter
      1.41 ± 16%      +1.9        3.32 ± 27%  perf-profile.calltrace.cycles-pp.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt
      0.00            +1.9        1.91 ±  6%  perf-profile.calltrace.cycles-pp.__file_remove_privs.btrfs_write_check.btrfs_direct_write.btrfs_do_write_iter.vfs_write
      1.42 ± 17%      +1.9        3.33 ± 27%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt
      1.47 ± 16%      +2.0        3.44 ± 27%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      1.07 ±  4%      +2.0        3.05 ±  4%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +2.0        2.02 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_write_check.btrfs_direct_write.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64
      0.00            +2.2        2.23 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +2.4        2.37 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      0.00            +2.5        2.50 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +2.7        2.75 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_highres_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +3.5        3.46 ± 27%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      0.00            +3.5        3.46 ± 27%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
      0.68 ± 15%      +3.9        4.59 ±  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +4.4        4.42 ± 26%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +4.4        4.44 ± 26%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.90 ± 17%      +5.0        5.85 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.90 ± 17%      +5.0        5.94 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.23 ± 12%      +6.9        8.10 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     22.73 ±  2%      +7.4       30.09 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.82 ±  2%      +7.5       30.29 ±  3%  perf-profile.calltrace.cycles-pp.vfs_write.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     22.85 ±  2%      +7.5       30.35 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     23.04 ±  2%      +7.5       30.58 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     23.05 ±  2%      +7.5       30.58 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_pwrite
     22.45 ±  2%      +7.6       30.00 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_direct_write.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64.do_syscall_64
     23.31 ±  2%      +7.7       30.99 ±  3%  perf-profile.calltrace.cycles-pp.__libc_pwrite
      1.34 ± 11%      +8.4        9.75 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +12.1       12.09 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_inode_lock
      8.07 ±  2%     +13.5       21.60        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +13.7       13.69 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_inode_lock.btrfs_direct_write
      0.00           +15.9       15.95 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.btrfs_inode_lock.btrfs_direct_write.btrfs_do_write_iter
      0.00           +16.0       15.96 ±  4%  perf-profile.calltrace.cycles-pp.down_write.btrfs_inode_lock.btrfs_direct_write.btrfs_do_write_iter.vfs_write
      0.00           +16.0       15.99 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_inode_lock.btrfs_direct_write.btrfs_do_write_iter.vfs_write.__x64_sys_pwrite64
     25.50 ±  2%     +16.2       41.75        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     25.57 ±  2%     +16.6       42.16        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     33.03 ±  2%     +18.0       51.05        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     33.09 ±  2%     +18.1       51.15        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     33.08 ±  2%     +18.1       51.14        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     33.68           +18.4       52.06        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     26.96 ±  2%     +19.1       46.04        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     42.16           -26.5       15.62 ±  9%  perf-profile.children.cycles-pp.kthread
     42.16           -26.5       15.62 ±  9%  perf-profile.children.cycles-pp.ret_from_fork
     42.16           -26.5       15.62 ±  9%  perf-profile.children.cycles-pp.ret_from_fork_asm
     30.22           -19.1       11.16 ±  9%  perf-profile.children.cycles-pp.worker_thread
     26.84           -16.0       10.81 ± 10%  perf-profile.children.cycles-pp.process_one_work
     25.69           -15.0       10.66 ± 10%  perf-profile.children.cycles-pp.btrfs_work_helper
     25.68           -15.0       10.66 ± 10%  perf-profile.children.cycles-pp.btrfs_finish_one_ordered
     22.03 ±  2%     -10.9       11.12 ±  2%  perf-profile.children.cycles-pp.btrfs_dio_write
     22.00 ±  2%     -10.9       11.09 ±  2%  perf-profile.children.cycles-pp.__iomap_dio_rw
     14.85 ±  3%     -10.1        4.70 ±  4%  perf-profile.children.cycles-pp.iomap_iter
     13.09           -10.1        2.96 ±  3%  perf-profile.children.cycles-pp.__schedule
     14.68 ±  3%     -10.1        4.56 ±  4%  perf-profile.children.cycles-pp.btrfs_dio_iomap_begin
     11.58            -9.6        1.98 ±  4%  perf-profile.children.cycles-pp.schedule
     15.21            -9.2        6.04 ± 10%  perf-profile.children.cycles-pp.insert_reserved_file_extent
     11.66 ±  3%      -9.1        2.52 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      9.33 ±  2%      -8.6        0.70 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      9.00 ±  2%      -8.6        0.39 ±  4%  perf-profile.children.cycles-pp.newidle_balance
     11.81 ±  2%      -8.2        3.60 ±  6%  perf-profile.children.cycles-pp.btrfs_search_slot
     12.97            -7.7        5.28 ± 10%  perf-profile.children.cycles-pp.btrfs_drop_extents
      8.08 ±  2%      -7.6        0.46 ±  6%  perf-profile.children.cycles-pp.load_balance
     11.79 ±  4%      -7.4        4.36 ± 15%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
     11.79 ±  4%      -7.4        4.36 ± 15%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
     11.79 ±  4%      -7.4        4.39 ± 15%  perf-profile.children.cycles-pp.btrfs_commit_transaction
     11.79 ±  4%      -7.4        4.39 ± 15%  perf-profile.children.cycles-pp.transaction_kthread
     10.16 ±  2%      -7.2        2.94 ±  5%  perf-profile.children.cycles-pp.poll_idle
     10.80 ±  4%      -6.8        3.96 ± 15%  perf-profile.children.cycles-pp.cleanup_ref_head
      9.54 ±  4%      -6.5        3.06 ± 17%  perf-profile.children.cycles-pp.btrfs_del_csums
      6.80 ±  2%      -6.4        0.40 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      6.70 ±  2%      -6.3        0.40 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      6.22 ±  2%      -5.9        0.35 ±  4%  perf-profile.children.cycles-pp.update_sg_lb_stats
      6.81 ±  3%      -5.9        0.96 ±  8%  perf-profile.children.cycles-pp.lock_extent
      5.92 ±  5%      -5.9        0.07 ±  9%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.94 ±  3%      -4.4        0.58 ±  7%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
      4.09 ±  5%      -3.9        0.24 ± 11%  perf-profile.children.cycles-pp.__btrfs_tree_lock
      5.64 ±  9%      -3.8        1.84 ±  6%  perf-profile.children.cycles-pp.intel_idle_irq
      4.00 ±  2%      -3.5        0.54 ±  7%  perf-profile.children.cycles-pp.wait_extent_bit
      3.46 ±  6%      -3.2        0.23 ± 12%  perf-profile.children.cycles-pp.btrfs_lock_root_node
      5.50 ±  4%      -2.8        2.66 ±  3%  perf-profile.children.cycles-pp.btrfs_get_blocks_direct_write
      3.24 ±  4%      -2.6        0.61 ±  6%  perf-profile.children.cycles-pp.__clear_extent_bit
      3.30 ±  5%      -2.6        0.71 ±  5%  perf-profile.children.cycles-pp.__set_extent_bit
      3.16 ±  5%      -2.5        0.65 ± 18%  perf-profile.children.cycles-pp.btrfs_truncate_item
      3.18 ±  6%      -2.5        0.68 ± 18%  perf-profile.children.cycles-pp.truncate_one_csum
      3.10            -2.2        0.86 ±  6%  perf-profile.children.cycles-pp.schedule_timeout
      3.10            -2.2        0.88 ±  5%  perf-profile.children.cycles-pp.io_schedule_timeout
      3.22 ±  2%      -2.2        1.01 ± 11%  perf-profile.children.cycles-pp.btrfs_add_delayed_data_ref
      2.55 ±  2%      -2.1        0.48 ± 12%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      2.35 ±  2%      -2.0        0.32 ±  7%  perf-profile.children.cycles-pp.down_read
      3.63 ±  2%      -2.0        1.64 ± 12%  perf-profile.children.cycles-pp.btrfs_del_items
      2.26 ±  2%      -2.0        0.27 ±  9%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      2.02 ±  2%      -1.9        0.12 ±  8%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      3.99 ±  3%      -1.9        2.14 ±  4%  perf-profile.children.cycles-pp.btrfs_new_extent_direct
      2.00 ±  2%      -1.7        0.32 ± 11%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      2.67 ±  4%      -1.7        1.00 ±  7%  perf-profile.children.cycles-pp.btrfs_create_dio_extent
      2.05 ±  5%      -1.3        0.74 ± 14%  perf-profile.children.cycles-pp.btrfs_set_token_32
      1.57 ±  3%      -1.2        0.34 ± 13%  perf-profile.children.cycles-pp.memmove_extent_buffer
      1.65 ±  4%      -1.2        0.48 ± 10%  perf-profile.children.cycles-pp.btrfs_alloc_ordered_extent
      1.74 ±  2%      -1.2        0.59 ± 10%  perf-profile.children.cycles-pp.add_delayed_ref_head
      1.78 ±  5%      -1.1        0.66 ± 10%  perf-profile.children.cycles-pp.btrfs_get_token_32
      1.34 ±  2%      -1.1        0.23 ± 17%  perf-profile.children.cycles-pp.btrfs_remove_ordered_extent
      1.60 ±  2%      -1.1        0.51 ± 12%  perf-profile.children.cycles-pp.btrfs_alloc_reserved_file_extent
      1.79 ±  4%      -1.1        0.74 ±  9%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      3.88            -1.0        2.88 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      2.62            -1.0        1.63 ±  8%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.25 ±  6%      -0.9        0.31 ±  9%  perf-profile.children.cycles-pp.alloc_ordered_extent
      3.35 ±  4%      -0.9        2.45 ± 11%  perf-profile.children.cycles-pp.setup_items_for_insert
      1.49 ±  4%      -0.9        0.60 ±  9%  perf-profile.children.cycles-pp.btrfs_release_path
      2.10            -0.8        1.26 ±  7%  perf-profile.children.cycles-pp.sched_ttwu_pending
      3.28 ±  4%      -0.8        2.45 ± 11%  perf-profile.children.cycles-pp.btrfs_setup_item_for_insert
      2.72 ±  8%      -0.8        1.90 ± 10%  perf-profile.children.cycles-pp.blk_complete_reqs
      2.42 ±  9%      -0.8        1.64 ± 11%  perf-profile.children.cycles-pp.scsi_end_request
      2.42 ±  9%      -0.8        1.65 ± 11%  perf-profile.children.cycles-pp.scsi_io_completion
      2.18 ±  3%      -0.7        1.45 ±  8%  perf-profile.children.cycles-pp.read_block_for_search
      0.90 ± 17%      -0.7        0.18 ± 33%  perf-profile.children.cycles-pp.__irqentry_text_start
      1.92 ±  2%      -0.7        1.20 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.80 ±  7%      -0.7        0.14 ± 11%  perf-profile.children.cycles-pp.__btrfs_qgroup_release_data
      0.96 ±  2%      -0.6        0.31 ±  9%  perf-profile.children.cycles-pp.clear_state_bit
      0.80 ±  5%      -0.6        0.16 ± 10%  perf-profile.children.cycles-pp.finish_task_switch
      3.52 ±  2%      -0.6        2.90 ± 10%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
      3.00 ±  7%      -0.6        2.39 ±  7%  perf-profile.children.cycles-pp.__do_softirq
      1.46 ±  4%      -0.6        0.86 ± 10%  perf-profile.children.cycles-pp.find_extent_buffer
      1.72 ±  2%      -0.6        1.15 ±  8%  perf-profile.children.cycles-pp.schedule_idle
      0.83 ±  4%      -0.6        0.27 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.86 ±  8%      -0.6        1.31 ± 12%  perf-profile.children.cycles-pp.blk_update_request
      0.65 ±  5%      -0.6        0.10 ± 14%  perf-profile.children.cycles-pp.btrfs_lookup_ordered_range
      0.98 ±  5%      -0.5        0.43 ±  7%  perf-profile.children.cycles-pp.btrfs_replace_extent_map_range
      0.90 ±  6%      -0.5        0.36 ±  9%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.76 ±  5%      -0.5        0.24 ± 16%  perf-profile.children.cycles-pp._raw_read_lock
      1.02 ±  4%      -0.5        0.50 ±  7%  perf-profile.children.cycles-pp.create_io_em
      0.58 ±  2%      -0.5        0.10 ± 15%  perf-profile.children.cycles-pp.idle_cpu
      0.62 ±  7%      -0.5        0.14 ± 16%  perf-profile.children.cycles-pp.free_extent_state
      0.77 ±  4%      -0.5        0.30 ± 11%  perf-profile.children.cycles-pp.btrfs_update_inode
      1.62 ±  9%      -0.5        1.15 ± 12%  perf-profile.children.cycles-pp.__btrfs_bio_end_io
      1.41 ±  2%      -0.5        0.94 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.08 ±  4%      -0.5        0.61 ± 10%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.52 ±  5%      -0.4        0.07 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.22 ±  2%      -0.4        0.81 ±  8%  perf-profile.children.cycles-pp.activate_task
      1.20 ±  2%      -0.4        0.79 ±  8%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.69 ±  3%      -0.4        0.29 ± 12%  perf-profile.children.cycles-pp.update_rq_clock
      0.62 ±  3%      -0.4        0.23 ±  8%  perf-profile.children.cycles-pp.__wake_up
      0.60 ±  7%      -0.4        0.22 ± 11%  perf-profile.children.cycles-pp.sbitmap_find_bit
      0.40 ±  8%      -0.4        0.05 ± 49%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.45 ±  4%      -0.3        0.10 ±  6%  perf-profile.children.cycles-pp.up_read
      0.61 ±  2%      -0.3        0.28 ± 13%  perf-profile.children.cycles-pp.free_extent_buffer
      0.54 ±  7%      -0.3        0.21 ± 13%  perf-profile.children.cycles-pp.sbitmap_get
      0.62 ±  4%      -0.3        0.30 ± 15%  perf-profile.children.cycles-pp.btrfs_drop_extent_map_range
      0.42 ±  4%      -0.3        0.09 ± 18%  perf-profile.children.cycles-pp.update_blocked_averages
      0.52 ±  8%      -0.3        0.20 ± 31%  perf-profile.children.cycles-pp.unpin_extent_cache
      0.48 ±  4%      -0.3        0.16 ± 22%  perf-profile.children.cycles-pp.insert_delayed_ref
      1.00 ±  5%      -0.3        0.68 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.51 ±  4%      -0.3        0.20 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
      0.83 ±  4%      -0.3        0.52 ± 12%  perf-profile.children.cycles-pp.btrfs_bin_search
      0.44 ±  4%      -0.3        0.15 ± 18%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.33 ± 13%      -0.3        0.04 ± 73%  perf-profile.children.cycles-pp.btrfs_inode_safe_disk_i_size_write
      0.86 ±  2%      -0.3        0.58 ±  6%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.31 ± 11%      -0.3        0.03 ±102%  perf-profile.children.cycles-pp.__tree_search
      0.64 ±  6%      -0.3        0.36 ± 10%  perf-profile.children.cycles-pp.kick_pool
      0.38 ±  8%      -0.3        0.11 ± 11%  perf-profile.children.cycles-pp.btrfs_inode_rsv_release
      0.89 ± 11%      -0.3        0.64 ± 13%  perf-profile.children.cycles-pp.btrfs_finish_ordered_extent
      0.42 ±  8%      -0.2        0.18 ± 21%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.89 ± 11%      -0.2        0.65 ± 13%  perf-profile.children.cycles-pp.btrfs_dio_end_io
      0.37 ±  7%      -0.2        0.14 ± 19%  perf-profile.children.cycles-pp.scsi_mq_get_budget
      0.68 ±  4%      -0.2        0.45 ±  9%  perf-profile.children.cycles-pp.block_group_cache_tree_search
      1.33 ±  3%      -0.2        1.10 ±  8%  perf-profile.children.cycles-pp.do_softirq
      0.39 ±  2%      -0.2        0.16 ± 14%  perf-profile.children.cycles-pp.insert_ordered_extent
      0.28 ± 10%      -0.2        0.06 ± 56%  perf-profile.children.cycles-pp.btrfs_calculate_inode_block_rsv_size
      0.92 ±  5%      -0.2        0.70 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      0.35 ±  4%      -0.2        0.13 ± 20%  perf-profile.children.cycles-pp.start_transaction
      0.36 ±  8%      -0.2        0.14 ± 10%  perf-profile.children.cycles-pp.btrfs_put_ordered_extent
      0.48 ±  4%      -0.2        0.26 ± 16%  perf-profile.children.cycles-pp.llist_add_batch
      0.54 ±  6%      -0.2        0.33 ±  9%  perf-profile.children.cycles-pp.btrfs_free_path
      0.69 ±  8%      -0.2        0.48 ± 18%  perf-profile.children.cycles-pp.read_extent_buffer
      0.49 ±  8%      -0.2        0.29 ± 13%  perf-profile.children.cycles-pp.btrfs_root_node
      0.48 ±  4%      -0.2        0.28 ±  9%  perf-profile.children.cycles-pp.__reserve_bytes
      0.28 ± 11%      -0.2        0.08 ±  6%  perf-profile.children.cycles-pp.get_extent_allocation_hint
      0.64 ±  7%      -0.2        0.44 ± 14%  perf-profile.children.cycles-pp.iomap_dio_bio_end_io
      0.34 ±  7%      -0.2        0.15 ± 13%  perf-profile.children.cycles-pp.__slab_free
      0.51 ±  5%      -0.2        0.32 ± 11%  perf-profile.children.cycles-pp.set_extent_bit
      0.36 ±  3%      -0.2        0.17 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.28 ±  6%      -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.unlock_up
      0.71 ±  2%      -0.2        0.54 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      0.21 ±  5%      -0.2        0.04 ± 73%  perf-profile.children.cycles-pp.join_transaction
      0.37 ±  4%      -0.2        0.20 ± 11%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      1.03 ±  7%      -0.2        0.87 ±  6%  perf-profile.children.cycles-pp.up_write
      0.37 ±  6%      -0.2        0.22 ± 13%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.25 ±  5%      -0.2        0.10 ± 19%  perf-profile.children.cycles-pp.btrfs_csum_root
      0.42 ±  6%      -0.2        0.27 ± 10%  perf-profile.children.cycles-pp.rb_erase
      0.23 ±  6%      -0.1        0.08 ± 28%  perf-profile.children.cycles-pp.btrfs_global_root
      0.91 ±  2%      -0.1        0.77 ±  8%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.26 ±  6%      -0.1        0.12 ± 20%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      0.16 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.btrfs_add_reserved_bytes
      0.15 ±  8%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.23 ±  7%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.27 ±  4%      -0.1        0.15 ± 12%  perf-profile.children.cycles-pp.free_extent_map
      0.38 ±  6%      -0.1        0.26 ±  5%  perf-profile.children.cycles-pp.alloc_extent_state
      0.66 ±  3%      -0.1        0.55 ± 11%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.17 ±  8%      -0.1        0.06 ± 23%  perf-profile.children.cycles-pp.btrfs_dec_block_group_reservations
      0.17 ±  5%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.btrfs_update_root_times
      0.26 ±  7%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.btrfs_get_chunk_map
      0.33 ±  5%      -0.1        0.23 ± 16%  perf-profile.children.cycles-pp.__switch_to_asm
      0.17 ±  6%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.__blk_rq_map_sg
      0.15 ±  4%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.__enqueue_entity
      0.42 ±  6%      -0.1        0.33 ±  8%  perf-profile.children.cycles-pp.pin_down_extent
      0.17 ± 10%      -0.1        0.08 ± 27%  perf-profile.children.cycles-pp.igrab
      0.36 ±  4%      -0.1        0.27 ± 12%  perf-profile.children.cycles-pp.btrfs_get_32
      0.19 ± 16%      -0.1        0.10 ± 31%  perf-profile.children.cycles-pp.mutex_trylock
      0.22 ±  7%      -0.1        0.14 ± 23%  perf-profile.children.cycles-pp.__blk_mq_alloc_driver_tag
      0.22 ± 15%      -0.1        0.14 ± 22%  perf-profile.children.cycles-pp.__blk_mq_free_request
      0.23 ± 10%      -0.1        0.15 ± 26%  perf-profile.children.cycles-pp.btrfs_select_ref_head
      0.25 ±  3%      -0.1        0.16 ± 19%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.12 ±  6%      -0.1        0.04 ±115%  perf-profile.children.cycles-pp.btrfs_buffer_uptodate
      0.19 ± 16%      -0.1        0.11 ± 29%  perf-profile.children.cycles-pp.btrfs_delayed_ref_lock
      0.23 ±  3%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.scsi_alloc_sgtables
      0.22 ±  7%      -0.1        0.15 ± 13%  perf-profile.children.cycles-pp.btrfs_num_copies
      0.19 ±  6%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.btrfs_get_64
      0.28 ±  5%      -0.1        0.21 ± 12%  perf-profile.children.cycles-pp.release_extent_buffer
      0.16 ±  9%      -0.1        0.09 ± 26%  perf-profile.children.cycles-pp.btrfs_delayed_refs_rsv_release
      0.38 ±  6%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.llist_reverse_order
      0.39 ±  6%      -0.1        0.32 ±  8%  perf-profile.children.cycles-pp.btrfs_map_block
      0.14 ± 17%      -0.1        0.07 ± 29%  perf-profile.children.cycles-pp.btrfs_dio_iomap_end
      0.10 ± 11%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.wakeup_preempt
      0.13 ± 13%      -0.1        0.07 ± 48%  perf-profile.children.cycles-pp.sbitmap_get_shallow
      0.16 ± 16%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.switch_fpu_return
      0.09 ± 22%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.12 ± 13%      -0.1        0.07 ± 18%  perf-profile.children.cycles-pp.btrfs_dio_submit_io
      0.13 ± 12%      -0.1        0.08 ± 50%  perf-profile.children.cycles-pp.check_buffer_tree_ref
      0.12 ± 11%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.fill_stack_inode_item
      0.21 ±  8%      -0.0        0.16 ± 17%  perf-profile.children.cycles-pp.dd_bio_merge
      0.08 ±  5%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.balance_level
      0.16 ± 10%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.14 ±  8%      -0.0        0.09 ± 25%  perf-profile.children.cycles-pp.btrfs_reserve_data_bytes
      0.16 ±  4%      -0.0        0.11 ± 17%  perf-profile.children.cycles-pp.btrfs_find_chunk_map_nolock
      0.10 ± 20%      -0.0        0.06 ± 31%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.09 ±  7%      -0.0        0.05 ± 51%  perf-profile.children.cycles-pp.assert_eb_page_uptodate
      0.16 ±  8%      -0.0        0.13 ± 14%  perf-profile.children.cycles-pp.work_busy
      0.08 ±  8%      -0.0        0.05 ± 44%  perf-profile.children.cycles-pp.wake_affine
      0.10 ±  7%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.dd_dispatch_request
      0.09 ± 10%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.scsi_finish_command
      0.08 ± 12%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.dd_finish_request
      0.07 ±  6%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.06 ± 13%      +0.0        0.10 ± 23%  perf-profile.children.cycles-pp.mt_find
      0.06 ± 14%      +0.0        0.12 ± 26%  perf-profile.children.cycles-pp.find_vma
      0.06 ±  9%      +0.0        0.10 ± 14%  perf-profile.children.cycles-pp.main_work
      0.08 ± 16%      +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.xattr_resolve_name
      0.02 ±141%      +0.1        0.07 ± 21%  perf-profile.children.cycles-pp._find_next_bit
      0.04 ± 72%      +0.1        0.10 ± 26%  perf-profile.children.cycles-pp.__ata_qc_complete
      0.04 ± 72%      +0.1        0.10 ± 23%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.02 ±142%      +0.1        0.08 ± 35%  perf-profile.children.cycles-pp.ahci_qc_prep
      0.07 ± 10%      +0.1        0.13 ± 29%  perf-profile.children.cycles-pp.gup_vma_lookup
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.ata_scsi_rw_xlat
      0.00            +0.1        0.06 ± 21%  perf-profile.children.cycles-pp.ata_std_qc_defer
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.do_read_fault
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.dd_request_merge
      0.05 ± 47%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.mm_cid_get
      0.42 ±  2%      +0.1        0.49 ± 10%  perf-profile.children.cycles-pp.__gup_longterm_locked
      0.00            +0.1        0.06 ± 24%  perf-profile.children.cycles-pp.do_fault
      0.00            +0.1        0.07 ± 25%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.1        0.07 ± 25%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.1        0.07 ± 19%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.01 ±223%      +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.mtree_range_walk
      0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.00            +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.kmalloc_trace
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.scsi_prepare_cmd
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.exec_binprm
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.search_binary_handler
      0.06 ± 14%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.11 ± 12%      +0.1        0.19 ± 16%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.generic_write_checks
      0.00            +0.1        0.08 ± 40%  perf-profile.children.cycles-pp.ata_scsi_qc_complete
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.01 ±223%      +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.bio_associate_blkg
      0.08 ± 12%      +0.1        0.16 ± 18%  perf-profile.children.cycles-pp.lockless_pages_from_mm
      0.04 ± 71%      +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.00            +0.1        0.09 ± 21%  perf-profile.children.cycles-pp.ahci_qc_ncq_fill_rtf
      0.17 ± 46%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.crc_pcl
      0.01 ±223%      +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.__libc_start_main
      0.01 ±223%      +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.main
      0.01 ±223%      +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.run_builtin
      0.05 ± 45%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.24 ±  8%      +0.1        0.33 ± 14%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.00            +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.bprm_execve
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.check_tsc_unstable
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.task_tick_mm_cid
      0.38 ± 19%      +0.1        0.48 ±  5%  perf-profile.children.cycles-pp.btrfs_csum_one_bio
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.cmd_stat
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.read_counters
      0.00            +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.wake_q_add
      0.00            +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.11 ±  3%      +0.1        0.21 ± 11%  perf-profile.children.cycles-pp.rebalance_domains
      0.02 ±141%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.08 ±  8%      +0.1        0.19 ± 18%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.1        0.10 ± 17%  perf-profile.children.cycles-pp.security_file_permission
      0.09 ±  7%      +0.1        0.20 ± 18%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.irq_work_tick
      0.07 ±  8%      +0.1        0.17 ± 16%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.07 ± 23%      +0.1        0.17 ± 14%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.1        0.11 ± 34%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.1        0.11 ± 34%  perf-profile.children.cycles-pp.update_wall_time
      0.04 ± 71%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.gup_pgd_range
      0.00            +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.btrfs_start_dirty_block_groups
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.47 ±  3%      +0.1        0.59 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.60 ±  4%      +0.1        0.71 ±  5%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.exc_page_fault
      0.09 ± 52%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.02 ±142%      +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.find_free_space
      0.00            +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.crc32c
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.execve
      0.76 ±  2%      +0.1        0.89 ±  6%  perf-profile.children.cycles-pp.find_free_extent
      0.00            +0.1        0.14 ± 21%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.00            +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.leave_mm
      0.38 ±  5%      +0.1        0.51 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.09 ± 15%      +0.1        0.23 ± 17%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.53 ±  2%      +0.2        0.68 ±  9%  perf-profile.children.cycles-pp.internal_get_user_pages_fast
      0.19 ± 46%      +0.2        0.34 ± 10%  perf-profile.children.cycles-pp.crc32c_pcl_intel_digest
      0.09 ±  8%      +0.2        0.24 ± 10%  perf-profile.children.cycles-pp.ata_qc_issue
      0.54            +0.2        0.70 ±  9%  perf-profile.children.cycles-pp.iov_iter_extract_pages
      0.10 ±  6%      +0.2        0.26 ± 15%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.82 ±  3%      +0.2        0.99 ±  4%  perf-profile.children.cycles-pp.btrfs_reserve_extent
      0.53            +0.2        0.70 ±  8%  perf-profile.children.cycles-pp.pin_user_pages_fast
      0.04 ±102%      +0.2        0.20 ± 22%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.62 ±  4%      +0.2        0.79 ±  5%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      0.06 ± 13%      +0.2        0.23 ± 16%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.02 ±141%      +0.2        0.19 ± 18%  perf-profile.children.cycles-pp.get_cpu_device
      0.11 ± 10%      +0.2        0.28 ± 20%  perf-profile.children.cycles-pp.btrfs_find_space_for_alloc
      0.00            +0.2        0.18 ± 12%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.56 ±  2%      +0.2        0.75 ±  8%  perf-profile.children.cycles-pp.__bio_iov_iter_get_pages
      0.56 ±  2%      +0.2        0.75 ±  7%  perf-profile.children.cycles-pp.bio_iov_iter_get_pages
      0.45 ±  6%      +0.2        0.64 ±  7%  perf-profile.children.cycles-pp.scsi_dispatch_cmd
      0.00            +0.2        0.20 ± 14%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.18 ±  8%      +0.2        0.37 ± 11%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.05 ±  7%      +0.2        0.25 ± 13%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.06 ± 11%      +0.2        0.28 ±  4%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.19 ± 10%      +0.2        0.41 ±  6%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.22 ±  4%  perf-profile.children.cycles-pp.timerqueue_del
      0.36 ±  7%      +0.2        0.58 ±  5%  perf-profile.children.cycles-pp.ata_scsi_queuecmd
      0.19 ±  3%      +0.2        0.42 ± 10%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.02 ±141%      +0.2        0.24 ± 10%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.2        0.23 ± 16%  perf-profile.children.cycles-pp.irqentry_enter
      0.02 ± 99%      +0.2        0.25 ± 13%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.2        0.23 ± 11%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.01 ±223%      +0.2        0.24 ± 12%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.07 ± 14%      +0.2        0.31 ± 12%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.timerqueue_add
      0.33 ± 17%      +0.2        0.58 ± 27%  perf-profile.children.cycles-pp.ata_qc_complete_multiple
      0.00            +0.3        0.26 ±  7%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.07 ± 15%      +0.3        0.33 ± 14%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.3        0.26 ± 16%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.02 ±223%      +0.3        0.29 ± 17%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.10 ± 14%      +0.3        0.38 ± 12%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.21 ±  8%      +0.3        0.50 ±  4%  perf-profile.children.cycles-pp.read_tsc
      1.56 ±  4%      +0.3        1.86 ±  3%  perf-profile.children.cycles-pp.btrfs_submit_chunk
      1.56 ±  4%      +0.3        1.86 ±  3%  perf-profile.children.cycles-pp.btrfs_submit_bio
      0.14 ± 16%      +0.3        0.45 ±  8%  perf-profile.children.cycles-pp.__ata_scsi_queuecmd
      0.86 ±  4%      +0.3        1.18 ±  6%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      0.00            +0.3        0.32 ± 12%  perf-profile.children.cycles-pp.rcu_pending
      0.08 ± 13%      +0.3        0.42 ± 10%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.22 ± 44%      +0.3        0.56 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      0.81 ±  4%      +0.3        1.16 ±  7%  perf-profile.children.cycles-pp.scsi_queue_rq
      0.01 ±223%      +0.4        0.44 ± 12%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.39 ± 16%      +0.5        0.92 ±  7%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.08 ±  6%      +0.6        0.66 ±  7%  perf-profile.children.cycles-pp.perf_rotate_context
      2.39 ±  2%      +0.6        2.97 ±  4%  perf-profile.children.cycles-pp.iomap_dio_bio_iter
      0.76 ± 26%      +0.6        1.36 ±  7%  perf-profile.children.cycles-pp.ktime_get
      1.12 ±  4%      +0.7        1.78 ±  5%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      1.25 ±  4%      +0.7        1.93 ±  4%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      1.25 ±  3%      +0.7        1.95 ±  4%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      1.26 ±  3%      +0.7        1.98 ±  4%  perf-profile.children.cycles-pp.__blk_flush_plug
      1.26 ±  3%      +0.7        1.98 ±  4%  perf-profile.children.cycles-pp.blk_finish_plug
      0.12 ± 80%      +0.8        0.88 ±  6%  perf-profile.children.cycles-pp.tick_irq_enter
      0.13 ± 69%      +0.8        0.90 ±  6%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.52 ± 12%      +0.8        1.28 ±  4%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.32 ± 37%      +0.8        1.11 ±  7%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.37 ±  6%      +1.0        1.36 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +1.4        1.38 ±  6%  perf-profile.children.cycles-pp.btrfs_lookup_xattr
      0.00            +1.7        1.69 ±  7%  perf-profile.children.cycles-pp.btrfs_getxattr
      0.00            +1.8        1.82 ±  6%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.00            +1.8        1.84 ±  7%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.00            +1.9        1.86 ±  7%  perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.49 ±  3%      +1.9        2.40 ±  9%  perf-profile.children.cycles-pp.update_process_times
      0.00            +1.9        1.91 ±  6%  perf-profile.children.cycles-pp.__file_remove_privs
      0.09 ± 28%      +1.9        2.02 ±  7%  perf-profile.children.cycles-pp.btrfs_write_check
      1.10 ±  4%      +2.0        3.13 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.25 ±  4%      +2.1        2.38 ± 10%  perf-profile.children.cycles-pp.btrfs_extend_item
      0.50 ±  3%      +2.2        2.67 ±  8%  perf-profile.children.cycles-pp.tick_sched_handle
      0.60 ±  8%      +2.4        3.04 ±  9%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
      1.00 ± 16%      +4.0        4.98 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.31 ± 18%      +5.0        6.31 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.32 ± 18%      +5.1        6.39 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.80 ± 13%      +6.9        8.68 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     22.73 ±  2%      +7.4       30.10 ±  3%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      2.30 ± 10%      +7.4        9.72 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     22.84 ±  2%      +7.5       30.32 ±  3%  perf-profile.children.cycles-pp.vfs_write
     22.85 ±  2%      +7.5       30.36 ±  3%  perf-profile.children.cycles-pp.__x64_sys_pwrite64
     22.45 ±  2%      +7.6       30.01 ±  3%  perf-profile.children.cycles-pp.btrfs_direct_write
     23.33 ±  2%      +7.7       31.04 ±  3%  perf-profile.children.cycles-pp.__libc_pwrite
     23.23 ±  2%      +8.0       31.20 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     23.25 ±  2%      +8.0       31.22 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.68 ±  4%      +9.8       11.45 ±  5%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      3.58 ±  6%     +11.2       14.82 ±  5%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      4.05 ±  5%     +12.1       16.19 ±  4%  perf-profile.children.cycles-pp.down_write
      3.73 ±  5%     +12.3       16.00 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      8.22 ±  2%     +13.7       21.94        perf-profile.children.cycles-pp.intel_idle
      0.01 ±223%     +16.0       15.99 ±  4%  perf-profile.children.cycles-pp.btrfs_inode_lock
     25.96 ±  2%     +16.8       42.79        perf-profile.children.cycles-pp.cpuidle_enter_state
     26.04 ±  2%     +16.9       42.96        perf-profile.children.cycles-pp.cpuidle_enter
     33.09 ±  2%     +18.1       51.15        perf-profile.children.cycles-pp.start_secondary
     33.65           +18.4       52.02        perf-profile.children.cycles-pp.do_idle
     33.68           +18.4       52.06        perf-profile.children.cycles-pp.cpu_startup_entry
     33.68           +18.4       52.06        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     27.47 ±  2%     +19.5       46.94        perf-profile.children.cycles-pp.cpuidle_idle_call
      9.66 ±  2%      -6.8        2.85 ±  5%  perf-profile.self.cycles-pp.poll_idle
      5.86 ±  5%      -5.8        0.07 ±  9%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.51 ±  2%      -4.2        0.26 ±  8%  perf-profile.self.cycles-pp.update_sg_lb_stats
      6.21 ±  2%      -3.8        2.40 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      1.86 ±  5%      -1.2        0.67 ± 15%  perf-profile.self.cycles-pp.btrfs_set_token_32
      1.60 ±  5%      -1.0        0.57 ± 12%  perf-profile.self.cycles-pp.btrfs_get_token_32
      2.69 ±  5%      -1.0        1.69 ±  7%  perf-profile.self.cycles-pp.intel_idle_irq
      1.47 ±  2%      -1.0        0.48 ± 10%  perf-profile.self.cycles-pp.add_delayed_ref_head
      0.74 ±  6%      -0.5        0.23 ± 18%  perf-profile.self.cycles-pp._raw_read_lock
      0.57 ±  5%      -0.5        0.07 ± 39%  perf-profile.self.cycles-pp.btrfs_truncate_item
      0.61 ±  7%      -0.5        0.13 ± 14%  perf-profile.self.cycles-pp.free_extent_state
      0.54 ±  3%      -0.4        0.09 ± 17%  perf-profile.self.cycles-pp.idle_cpu
      0.52 ±  4%      -0.4        0.13 ± 11%  perf-profile.self.cycles-pp.update_rq_clock
      0.63 ±  5%      -0.4        0.26 ± 18%  perf-profile.self.cycles-pp.find_extent_buffer_nolock
      0.53 ±  6%      -0.4        0.17 ± 16%  perf-profile.self.cycles-pp.__set_extent_bit
      0.59 ±  3%      -0.3        0.26 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.42 ±  6%      -0.3        0.10 ±  6%  perf-profile.self.cycles-pp.up_read
      0.80 ±  4%      -0.3        0.50 ± 10%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.35 ±  6%      -0.3        0.10 ± 15%  perf-profile.self.cycles-pp.free_extent_buffer
      0.31 ±  4%      -0.2        0.06 ± 14%  perf-profile.self.cycles-pp.btrfs_remove_ordered_extent
      0.36 ±  9%      -0.2        0.12 ± 16%  perf-profile.self.cycles-pp.sbitmap_find_bit
      0.32 ±  3%      -0.2        0.09 ± 14%  perf-profile.self.cycles-pp.newidle_balance
      0.58 ±  4%      -0.2        0.36 ±  7%  perf-profile.self.cycles-pp.__schedule
      0.48 ±  4%      -0.2        0.26 ± 15%  perf-profile.self.cycles-pp.llist_add_batch
      0.63 ±  9%      -0.2        0.42 ± 11%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.68 ±  8%      -0.2        0.47 ± 19%  perf-profile.self.cycles-pp.read_extent_buffer
      0.49 ±  8%      -0.2        0.28 ± 13%  perf-profile.self.cycles-pp.btrfs_root_node
      0.29 ±  8%      -0.2        0.08 ± 19%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.29 ±  8%      -0.2        0.10 ±  9%  perf-profile.self.cycles-pp.__clear_extent_bit
      0.33 ±  7%      -0.2        0.15 ± 14%  perf-profile.self.cycles-pp.__slab_free
      0.34 ±  2%      -0.2        0.16 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.41 ±  6%      -0.2        0.26 ±  9%  perf-profile.self.cycles-pp.rb_erase
      0.35 ± 10%      -0.1        0.20 ± 13%  perf-profile.self.cycles-pp.up_write
      0.19 ± 10%      -0.1        0.06 ± 50%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.29 ± 10%      -0.1        0.16 ± 19%  perf-profile.self.cycles-pp.down_read
      0.26 ±  4%      -0.1        0.14 ± 11%  perf-profile.self.cycles-pp.free_extent_map
      0.34 ±  2%      -0.1        0.22 ± 14%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.28 ±  3%      -0.1        0.16 ± 21%  perf-profile.self.cycles-pp.btrfs_del_items
      0.25 ±  8%      -0.1        0.14 ± 24%  perf-profile.self.cycles-pp.down_write
      0.21 ±  6%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.finish_task_switch
      0.19 ± 10%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.btrfs_put_ordered_extent
      0.21 ±  8%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.21 ±  6%      -0.1        0.10 ± 17%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.78 ±  2%      -0.1        0.67 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ±  5%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.process_one_work
      0.26 ±  5%      -0.1        0.16 ± 14%  perf-profile.self.cycles-pp.enqueue_entity
      0.33 ±  5%      -0.1        0.23 ± 15%  perf-profile.self.cycles-pp.__switch_to_asm
      0.15 ±  4%      -0.1        0.06 ± 50%  perf-profile.self.cycles-pp.__enqueue_entity
      0.12 ± 21%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.btrfs_do_write_iter
      0.17 ±  8%      -0.1        0.08 ± 23%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.18 ±  7%      -0.1        0.09 ± 17%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.22 ±  7%      -0.1        0.14 ± 14%  perf-profile.self.cycles-pp.setup_items_for_insert
      0.19 ± 16%      -0.1        0.10 ± 31%  perf-profile.self.cycles-pp.mutex_trylock
      0.33 ±  4%      -0.1        0.24 ± 11%  perf-profile.self.cycles-pp.btrfs_get_32
      0.44 ±  3%      -0.1        0.36 ±  8%  perf-profile.self.cycles-pp.block_group_cache_tree_search
      0.12 ±  9%      -0.1        0.04 ± 77%  perf-profile.self.cycles-pp.prepare_task_switch
      0.10 ±  7%      -0.1        0.03 ±105%  perf-profile.self.cycles-pp.btrfs_buffer_uptodate
      0.25 ±  7%      -0.1        0.17 ± 15%  perf-profile.self.cycles-pp.try_to_wake_up
      0.11 ± 13%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.btrfs_dio_submit_io
      0.10 ± 22%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.sbitmap_queue_clear
      0.38 ±  5%      -0.1        0.31 ±  9%  perf-profile.self.cycles-pp.llist_reverse_order
      0.16 ±  8%      -0.1        0.10 ± 22%  perf-profile.self.cycles-pp.kick_pool
      0.27 ±  5%      -0.1        0.20 ± 12%  perf-profile.self.cycles-pp.release_extent_buffer
      0.21 ±  2%      -0.1        0.14 ± 16%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.10 ± 10%      -0.1        0.04 ± 75%  perf-profile.self.cycles-pp.btrfs_drop_extents
      0.12 ±  7%      -0.1        0.06 ± 48%  perf-profile.self.cycles-pp.worker_thread
      0.18 ±  5%      -0.1        0.12 ± 13%  perf-profile.self.cycles-pp.btrfs_get_64
      0.14 ± 12%      -0.1        0.08 ± 29%  perf-profile.self.cycles-pp.btrfs_finish_one_ordered
      0.15 ± 11%      -0.1        0.09 ± 19%  perf-profile.self.cycles-pp.unlock_up
      0.11 ±  9%      -0.1        0.06 ± 52%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.10 ± 12%      -0.1        0.05 ± 75%  perf-profile.self.cycles-pp.find_extent_buffer
      0.12 ± 13%      -0.1        0.06 ± 50%  perf-profile.self.cycles-pp.check_buffer_tree_ref
      0.09 ±  7%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.10 ± 11%      -0.0        0.05 ± 75%  perf-profile.self.cycles-pp.add_extent_mapping
      0.16 ±  4%      -0.0        0.11 ± 14%  perf-profile.self.cycles-pp.btrfs_find_chunk_map_nolock
      0.06 ±  7%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.sbitmap_get
      0.08 ± 12%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.dd_finish_request
      0.13 ±  6%      -0.0        0.11 ± 12%  perf-profile.self.cycles-pp.schedule
      0.08 ± 14%      +0.0        0.12 ± 22%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.06 ± 21%      +0.0        0.10 ± 18%  perf-profile.self.cycles-pp.iomap_dio_bio_iter
      0.07 ± 13%      +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.xattr_resolve_name
      0.02 ±142%      +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.vfs_write
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.mm_cid_get
      0.00            +0.1        0.06 ± 21%  perf-profile.self.cycles-pp.ata_std_qc_defer
      0.01 ±223%      +0.1        0.07 ± 34%  perf-profile.self.cycles-pp.ahci_qc_prep
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.sched_clock
      0.01 ±223%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.ct_idle_exit
      0.01 ±223%      +0.1        0.08 ± 26%  perf-profile.self.cycles-pp.dma_direct_unmap_sg
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.generic_write_checks
      0.00            +0.1        0.07 ± 29%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.submit_bio_noacct
      0.01 ±223%      +0.1        0.08 ± 23%  perf-profile.self.cycles-pp.mtree_range_walk
      0.00            +0.1        0.07 ± 23%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.02 ±141%      +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.05 ± 45%      +0.1        0.13 ±  7%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.scsi_queue_rq
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.check_tsc_unstable
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.irqentry_enter
      0.05 ± 45%      +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.10 ± 13%      +0.1        0.19 ± 17%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.08 ± 18%  perf-profile.self.cycles-pp.blk_mq_get_tag
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.ahci_qc_ncq_fill_rtf
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.00            +0.1        0.09 ± 20%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.24 ±  8%      +0.1        0.33 ± 15%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.33 ±  5%      +0.1        0.42 ±  9%  perf-profile.self.cycles-pp.__iomap_dio_rw
      0.00            +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.00            +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.task_tick_mm_cid
      0.00            +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.__libc_pwrite
      0.08 ± 13%      +0.1        0.17 ±  8%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.1        0.10 ± 17%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.10 ± 28%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.10 ± 20%  perf-profile.self.cycles-pp.wake_q_add
      0.00            +0.1        0.10 ± 23%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.00            +0.1        0.10 ± 12%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.10 ± 12%  perf-profile.self.cycles-pp.irq_work_tick
      0.09 ±  8%      +0.1        0.19 ± 19%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.16 ±  5%      +0.1        0.27 ± 10%  perf-profile.self.cycles-pp.do_idle
      0.07 ± 10%      +0.1        0.17 ± 16%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.10 ± 19%  perf-profile.self.cycles-pp.menu_reflect
      0.00            +0.1        0.10 ± 14%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.46 ±  3%      +0.1        0.56 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.11 ± 30%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.00            +0.1        0.11 ± 21%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.blk_mq_complete_request_remote
      0.00            +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.1        0.13 ± 17%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.1        0.13 ± 23%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.13 ± 25%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.15 ± 16%  perf-profile.self.cycles-pp.tick_irq_enter
      0.06 ± 49%      +0.1        0.21 ± 12%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.2        0.15 ± 16%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.2        0.16 ± 12%  perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.2        0.16 ± 14%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.2        0.17 ± 18%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.2        0.18 ± 13%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.01 ±223%      +0.2        0.18 ± 19%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.2        0.18 ± 11%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.11 ± 10%      +0.2        0.29 ±  6%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.2        0.19 ± 19%  perf-profile.self.cycles-pp.perf_rotate_context
      0.05 ±  7%      +0.2        0.25 ± 13%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.02 ±223%      +0.2        0.23 ± 16%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.06 ± 11%      +0.2        0.28 ±  4%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.19 ±  3%      +0.2        0.41 ± 10%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.2        0.22 ±  9%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.2        0.23 ± 11%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.2        0.25 ± 12%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.3        0.25 ±  7%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.07 ± 14%      +0.3        0.33 ± 15%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.40 ± 21%      +0.3        0.68 ± 23%  perf-profile.self.cycles-pp.ahci_handle_port_intr
      0.20 ±  7%      +0.3        0.48 ±  4%  perf-profile.self.cycles-pp.read_tsc
      0.56 ± 36%      +0.4        0.93 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.48 ±  6%      +0.9        1.40 ± 11%  perf-profile.self.cycles-pp.menu_select
      0.22 ±  4%      +1.3        1.48 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.33 ±  6%      +3.4        4.72 ±  6%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      1.40 ±  4%      +8.9       10.34 ±  5%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      8.22 ±  2%     +13.7       21.93        perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


