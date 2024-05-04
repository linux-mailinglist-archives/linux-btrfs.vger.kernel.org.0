Return-Path: <linux-btrfs+bounces-4740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A818BB968
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2024 06:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A622846A5
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2024 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB61171D;
	Sat,  4 May 2024 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqH7fupu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626FAD2D;
	Sat,  4 May 2024 04:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714796008; cv=fail; b=YFkh9RVhNktnMgLtxrSh8+KioQfR4Uh5ydlm2xOs0v4ixZ3PtJWfSZjUuT1Y5qRPjGGo7UJkNIFAc+I4fDv2rr7R5+PxoId553LrcTxGPxY5Y9ga5qWZ+t1g+vZABJ6t8QYlrPm4xf6rKNm2TiVJ6xTr2Bm3fRDVcbpIGLt5EWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714796008; c=relaxed/simple;
	bh=QBwpm8sprTXLaqs9+nPaanr40AxokFaIuy+hiJMMA54=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XaXhlee61zJRGx1SpR+y6bgPIKHuAi0g3XaFzA2LUsbiq6Yi0NRUeKQjeyszu6qoGOxhxGCgEDd85vyfCgLZdvpHh2l1v1aVNcHLtvGdg+l2yzq2AdBOF+pRF+9/xtRO3clwyK0LUy3mA1t5ENfyQvcrsy8hBrM1YeMDNoQL9B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqH7fupu; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714796007; x=1746332007;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QBwpm8sprTXLaqs9+nPaanr40AxokFaIuy+hiJMMA54=;
  b=YqH7fupudYzLamySDg+T5S79DnlUO9tJdrmJzGqv8xYXOU/rpqEYLDyW
   r3PWTctxnQmeN/0fnANuOM920b9zqjzreY9JIEnpAKFi7UqlhR0ldfcz/
   9vG53PPpTHm2RDx+T/fMlYQFwWHBtY3VXtM1pXaJigFS68iIb4wZOOwRS
   RSBDXhgFv/yUGXzPC4B1uC6bJ7ZLploMsZx1YqO2VMrAYmhgJtD38sSmM
   QC30f74JggfYBg2dgjWEU8IYIvEcfqnZru2qEnxo1EvFvY0R86u/W3Qwa
   mvh9IRHzEf4JB2E5htZPdJKs15gipm+pGlkTfbSm0jgUgkuwMvS+oJSRo
   Q==;
X-CSE-ConnectionGUID: Fb/2jUpBQRq5FdikOSJmMg==
X-CSE-MsgGUID: v3vvj17KRGe2X2cburA8uA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="22024588"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="22024588"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 21:13:26 -0700
X-CSE-ConnectionGUID: 16fqTwqmQf6ZlpoWeIzF8Q==
X-CSE-MsgGUID: I6LllCjuQHuzRj+9D3OIUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="58540244"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 21:13:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 21:13:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 21:13:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 21:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8QxbHv8tc5LOkfg/e/sHWDh0079zacy0EyPSuOfzvN78GTC6yxWgYjzqqUy3UNNxn0JiweHG+IxeABmkYYh4NtYbX9iPczHGFDXJXlIvaP3rrv1rZSLawPoSVwtP/AF2dMeit0ZSMwsEsntXsO04wLxlEMkOvfPOi1L9pt9GMRI2wOTxiTt4TGGxpZgi18yhbHRkZ4P+419ZFTFX4FwxaKZmiNTKLp8UKmSkJbwza8Hec2QW/uvFTTxVRSXXugkU5uzV3TkwQ/jwaspEbqHwHG4KBxg8WLK8/QerlFCslgt13k0lxo5VPdeW6b9RsBGneyOrwUOAMTdF1cRZ1Cidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM5KwGrgrIrlD1F8ZMQ6Ef5Aa3khD+1TCdLgOH6+dik=;
 b=YX5S+CtGo9rkTB9TGSL9n1tQfRn3W0WoHY8n2Tx/by69Ii/N5oFIuwU3nM9TU7DUAWQnfdSfrrurhoGVDTV4JmFUzR6KsBOU/fSuCO50c1MNC5Pt91xKNEI2GISSgIxutW43u/XBR2Fq/mjCSn50NIPApFxAPgUWA7EVrUYVnuMQ8BDHb2kzqwA1cXD0WWCgcVjww2XC32iw8Jiv3eiWNRLfRkClQuUKeFGa7V+OmExMtr5VywW+nMI6B9T2uC5CwdzSZcGL1lIfbliQfGnowdpi1TD4SYlj+idl6ffQUETXidRJeunGnx3wweCGXgsAOgTYvM2/h5ZyfXM/yGpctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4765.namprd11.prod.outlook.com (2603:10b6:806:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.38; Sat, 4 May
 2024 04:13:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Sat, 4 May 2024
 04:13:23 +0000
Date: Fri, 3 May 2024 21:13:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <6635b5e0e3954_1aefb294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
 <ZhSPHvoTHl28GXt1@aschofie-mobl2>
 <6635366717079_e1f582941d@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6635366717079_e1f582941d@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fefef5-0180-4e21-4dad-08dc6bf089fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VZ4GGcFKfw6/xpF2BTFqkIyWitskHoczg/K7ljpWT8oM2yfDJhPmwaGMpd2d?=
 =?us-ascii?Q?pP/eka1hTyRT7hxPh0FlBO0qtPN4JUpWmrkGMNXAuYUy99No88qvmOmvmLq3?=
 =?us-ascii?Q?xEah6+C3JGTe04woVuhmkxPg76Fgin55UGRXVsY2P5SzVWQpSj565QzPEzKY?=
 =?us-ascii?Q?q2RCBAaBT+Ss5yMh9b6GPKbbNb3noGsRfuND8PCc85j2Jk6ZqXEiH7Gt7KEt?=
 =?us-ascii?Q?+ee9NFZyHTWX0mXBmeC2UmOL1UDXpUeeOgnsG505rBGVruChxtchxwbhZt9w?=
 =?us-ascii?Q?m/sqmiEYQZTnP25QNdG/a9b0Ha0UWhyT37V8y4VugDr1p7aXVFks71Ul9M+M?=
 =?us-ascii?Q?To691e3wX4jBbGkiHFIQ8CuBMPsUpo4rF81sEiiLOY8usO+sV7C5aDWTPBuo?=
 =?us-ascii?Q?gWqn/QTf26jdbIAV005tHhATPYZ3st+03DfFr/gtKLuSS1+CTGprMcWGjIkE?=
 =?us-ascii?Q?nAY7/6kHON4Av5hdFvwVMuNqrwjaJSU7YBjHGCdKcOKWm0zyTsWsmQo46M5Z?=
 =?us-ascii?Q?zSKtoh+GsnrjVM2N/8XSryoEDD/FUYGGzhC65EoDKMBy5jyzEQhbW0DrIJBn?=
 =?us-ascii?Q?aILYARtyTT/LfDaAvsBNGQbXgT1OJTAEW5waDQQ9qo7blIKWoA8j3Z93T1WU?=
 =?us-ascii?Q?tNe4UzvLV5eCwUvclQGL2FNxbIE4odF5pkQey85juEuzmgSS7Q7x9xkePdZp?=
 =?us-ascii?Q?04kc5bhVhhsTYXDgb5fJCjJGreT19fjicX9ZdbIEu+6FY1uiCes77mk19+OM?=
 =?us-ascii?Q?ZS99h2mSf7gDf4aU+eWQjKQcL8TZ9/ngRtDJ3iiu/ZQNNQ4w+XBT/hyhl6t6?=
 =?us-ascii?Q?MZVMFcuKjHvS6BE9+zEAIk58Osh5zoquCx0cLWoki73eDIhTggnAmfKfpEgT?=
 =?us-ascii?Q?tD8FG26r8vu0p3Eu6jlVndAxMmghWu8gZloTSj6vkJIMHEMJWuyMmUQKwJq6?=
 =?us-ascii?Q?y5Sx0rjkj+qZEMXdkzs4NMyVCfS5SlquGLk0lnc+XJ608qn44Z8xjN8/Cde8?=
 =?us-ascii?Q?4dUBNwnDx2hrbWhJR8rw92/3bizhRH1eP4DV3Bdk8EBNUuz2acOqaUaUBGnU?=
 =?us-ascii?Q?JA7HKKbcJca0VLswV3HW8fbgF3yBUgI6VDbyUZsrktIEFjFtcehVaPRykxJJ?=
 =?us-ascii?Q?wT2eIjQk0LUE0NueXTuoqNbfHaDaMPbF9x6B0xSX6mG3r1l3JkywDfdsk0Jf?=
 =?us-ascii?Q?NdkWQQXig1PPiqgSDJhuKef8PIOzD0ntzL82UcFtsBWT9vibArNI6kuPBeQt?=
 =?us-ascii?Q?JZKeTdnbrTVISTRQdZyiKV3rjvR1nlWTpLABe+RB4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivWEjws37MfdFDWU7stab4M8jg9dDA48w+YUaZAEO0FhFLQ3fD7BuCkYm5Z4?=
 =?us-ascii?Q?veIXxFpaYJSMz7PedwyZaLhIqP0AwI3VyrR8txjpvGbUUwGGsNTg7qh1pQYZ?=
 =?us-ascii?Q?RQLwhFBq/ih/nn8u9LNiEG6lav0rixd7ufDjUWHFoG6P6K6onq5G0YR8N8d0?=
 =?us-ascii?Q?zRVRHyKqhWzr0BQNRwQLvsiCoqMx8RN+cOuv9gISL4JaNnLICXHOpnXOKM/+?=
 =?us-ascii?Q?ij1AzeZ1+xuS0QBdEikXInfvG9a4sclkgppoDwtdO7zMr1c+P7edvMYEJlhZ?=
 =?us-ascii?Q?fMVYntyt7/bqGOSmy6yaPRW39j3VYo6EckukBqzqjWSkv/utveQvgwR9MQgX?=
 =?us-ascii?Q?ZR1RQ713BmtBT6WTpVE/gtBkvZkmF6vd8GgXzd69I+ZQFnt0KUXPxe2zK7c5?=
 =?us-ascii?Q?NqLs/oWgearJDMWwJfYQOZ4SCwUV/JFb/d+by5zlezyiIljOSRvc5HR0kQOk?=
 =?us-ascii?Q?DSAIhb9/ZVwTzz3Jxunzdqq8Q9tG51nqQpmk7yEAAtLUxDDxFYp4+IMMhWpV?=
 =?us-ascii?Q?uJkxWi1fZIBgzQC4WhuuMSORRXo5JSGftjPPEoVPJb2yoQT52c/stLngBOxN?=
 =?us-ascii?Q?kby2AU2hPG9Of6TVAq0+fsO+zCjHCA7cFb86OjCVXNAKO0SxtOAMGmGyb8Px?=
 =?us-ascii?Q?kKOJA82V1b5Apw9Ko9FZEEyFF/MPSffrKi+TEwro7OTRHBZHQVsYNzGGRb4C?=
 =?us-ascii?Q?jbcpSkgfJNhpwVQOD8Abv1WE8URyUS9NCQvDsioIK8L1vkV52eRdg/950AZD?=
 =?us-ascii?Q?gpQCbPE5du5yFiCnyJk9Drh/j+bZD9TZ7/NCn8OYwWMLGDeaPjWfD7pbMP6b?=
 =?us-ascii?Q?iAe5gS7IPbvhtjQ/HXEK1PqeZiZRDO3U40GOeVe9j+zF3gYSC32d8lwnoYy1?=
 =?us-ascii?Q?9cXuMjt/ZBb1FchXoNZFSDQvgxSDN0b2/oE0dvZxJXj3/bPJrFPq/ETG/EGE?=
 =?us-ascii?Q?zyyOEdOGeU94gTgcePFBHbNY9oN1lS/Zkhz99AannyLp05MetDEEDyGTF9yZ?=
 =?us-ascii?Q?mQf+jCJdfDxfajR4atKKekSsuk0wN5g2j9EMrt4IWKuiSDFFpOjkyJTC6bFC?=
 =?us-ascii?Q?zdYAPaopJ+5nTb402P+Al4m26GVuM2OSs/RzFqttwYKMItOIHOyf1Ds65vBv?=
 =?us-ascii?Q?UjN7g4auUCCe2fuY8RzkgISeQQxuso6WWmwoVCqO+30zzZmL6668PAWv5Dtl?=
 =?us-ascii?Q?D9yWgsNprAbU5r15r/GLGrEeo/blABQ0pmBGGEi9pZH5AYZhGyij9DFsfrzc?=
 =?us-ascii?Q?g/dhnt6vy+PVyZFPwBztiPQ6Tju2J2lsWOuX1agopHfz3eqqMgukIY5UfiLG?=
 =?us-ascii?Q?lqOOUStSjxkVfS423nRHQgx+7bulntZy2Aka/OQoFZkJJYlNkWUHy9nb71o5?=
 =?us-ascii?Q?boajAXD1ABWNEhgm8H6oRhkH2TwdCkdZwb0u6vMpDRnQtwSpR5WZ3uXCwxYB?=
 =?us-ascii?Q?9f3QDz657NrxnZhepPr6Kzx64Cnqo+0/j8thuu9uLfo5Mrv3c1w34f3l3w7q?=
 =?us-ascii?Q?ndLxajkOUfheeXaurKaw2zYS4IGpz6tcQl832NUX4DsT9PyaSdemxRvwsmLz?=
 =?us-ascii?Q?T7p/4XZHFV+oCFoMbgd+ibZQhN9M/QOPDl/v/3EWtPB1P7ROByRUrPj4Bo8L?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fefef5-0180-4e21-4dad-08dc6bf089fe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 04:13:23.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzIpjE+oawmgfL/lnWsvAF/jItQ+6CiKfar3tv7upWDiXwC36G9vJ7vZbdYa8UGg3sQ++jkHeshKwjoLUNXK0lAYREZ0JV1amM6XOT7dixM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4765
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Alison Schofield wrote:
> > On Sun, Mar 24, 2024 at 04:18:08PM -0700, Ira Weiny wrote:
> > > cxl_dpa_set_mode() checks the mode for validity two times, once outside
> > > of the DPA RW semaphore and again within.
> > 
> > Not true.
> 
> Sorry for not being clear.  It does check the mode 2x but not for
> validity.  I'll clarify.
> 
> > It only checks mode once before the lock. It checks for
> > capacity after the lock. If it didn't check mode before the lock,
> > then unsupported modes would fall through.
> 
> But we can check the mode 1 time and either check the size or fail.
> 
> > 
> > > The function is not in a critical path.
> > 
> > Implying what here?  OK to check twice (even though it wasn't)
> > or OK to expand scope of locking.
> 
> Implying that checking the mode outside the lock is not required.
> 
> > 
> > > Prior to Dynamic Capacity the extra check was not much
> > > of an issue.  The addition of DC modes increases the complexity of
> > > the check.
> > > 
> > > Simplify the mode check before adding the more complex DC modes.
> > > 
> > 
> > The addition of the DC mode check doesn't seem complex.
> 
> It is if you have to check it 2 times.
> 
> > 
> > Pardon my picking at the words, but if you'd like to refactor the
> > function, just say so. The final result is a bit more readable, but
> > also adding the DC mode checks without refactoring would read fine
> > also.
> 
> When I added the DC mode to this function without this refactoring it was
> quite a bit more code and ugly IMO.  So this cleanup helped.  If I were
> not adding the DC code there would be much less reason to change this
> function.

Where did the "quite a bit more code" come from? A change that moves
unnecessary code under a lock and is larger than just incrementally
extending the status quo does not feel like a cleanup.

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..0dc886bc22c6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -411,11 +411,12 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
        struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
        struct cxl_dev_state *cxlds = cxlmd->cxlds;
        struct device *dev = &cxled->cxld.dev;
-       int rc;
+       int rc, dcd;
 
        switch (mode) {
        case CXL_DECODER_RAM:
        case CXL_DECODER_PMEM:
+       case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
                break;
        default:
                dev_dbg(dev, "unsupported mode: %d\n", mode);
@@ -442,6 +443,11 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
                rc = -ENXIO;
                goto out;
        }
+       dcd = dc_mode_to_region_index(mode);
+       if (resource_size(&cxlds->dc_res[dcd]) == 0) {
+               dev_dbg(dev, "no available dynamic capacity\n");
+               goto out;
+       }
 
        cxled->mode = mode;
        rc = 0;

