Return-Path: <linux-btrfs+bounces-8800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C3A998B6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF2928BF91
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB331CCEC2;
	Thu, 10 Oct 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYd30onX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D11CB312;
	Thu, 10 Oct 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573885; cv=fail; b=Tu1xElQHvnICYHJB2ya/dW5qtGvfc46UI7U+NOGsoadNvpy5tmsh05L1UeoJoOixzZypvw8R0/FcFKJGj9fuUa4a31Kp5gx85NAK5EgTc6DXznlhS4Xj6qpjjYWdvIUzuiz/GoQPeN3KGDHggEEE0mcIREvqJXXF9ly0Yw+JqSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573885; c=relaxed/simple;
	bh=dNfuRLp04WYH0sy9yqHBqXBD8n/DG64vx+JFGSeB+zk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BrHoPGdU04RiHtGz2M+G5hq3KumNjwiTHvtnXO+yY4Pgy+e4D2VioB/WIXyxtRNEXCA6byBRgAZxa4a11Q9AOw/zh891FyHnSe0BPPeW0HjOrklBkf0EmQyGcWtQDOhY8kUEmOlomC76rRHDgmRpx7xEA/jzPW2THw0E1JmrzqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYd30onX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728573883; x=1760109883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dNfuRLp04WYH0sy9yqHBqXBD8n/DG64vx+JFGSeB+zk=;
  b=hYd30onXluUsI47jpr9ZHpZycEdkj/aDHM4rBHm86NojX1No7cwzIgKz
   Bakw6TTR3yY7/qhLW14CEmC/q5LZ5ffPVgba83Vg+NilolUw1uMGg6guX
   lleQ/4VWD3rcisCQE8LAEG8z7MKhP+rOD8eUYuAFh+LHndF6wjC4yFesB
   m8TbuRZqSPJbAC//px6LHdy+gtDAy79sqPADrdxqFBXLJCztsqW9mIvex
   PHpolGMtzNV2jmAfO6/ocjkIV8OSoL8bf0t3SPQwBkYO3aaDSZLOu80Uy
   +3JnURQbqi70O9KznQRfd+AWV1mq3Ybx/7tWPetVOw4whZlgOnVPm0DmI
   Q==;
X-CSE-ConnectionGUID: 3gL34xPtS2GELS0TJNsEFA==
X-CSE-MsgGUID: LFR3SeNJRI6KxRwZKclKIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28096411"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28096411"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:24:42 -0700
X-CSE-ConnectionGUID: hiqGGdEiQ5ORoH9yb2+B6g==
X-CSE-MsgGUID: VrJcWKWcQZKCadpzf3s/Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76943260"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 08:24:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:24:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:24:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 08:24:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 08:24:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlJAKbm+eMHueCLa/lb/GK3eSi4VISp7U2ikaCAKdUDMuXI6fzaTonrlRMoh9aVJe/j53OTLYvKl+c2uIXx+Nw+l5yZJelcD7mnS9rJVMpPwj+JPsBPVKfemwM7V0MLqxkCYBTO8BhKt6FCg8RNCu/nkJoxvxqiHC3+MgIzkNASzDT9A/VQS1GlZGHwfz6Pntq3OuuOEI9tIvooVQbirzJXXyXPNebYrMv6OisnDMlDRaLgypzaY/5vLiDj6SqDSYzghIp09k3ZDc5YNuEAOhr96WoABbjptjJqlsgrm1hnWqmZx4FOVTIwh/u5hVXOF/ixCNiZ9RpU0Tq1xA8tEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBWl3h2Ai2FkSQtsmZmlM72Ljt3W+0vQ3Tf1Z7fZIag=;
 b=NQPBwtkdXOFeZ3mXIS3Gsg5Oc1w3L4zgOw7/OS10LPb7LLKprElwmgp38jF0rlBvpZypkVPbIcprBRF/XrYBJyH4GEQUHBUz5FWlBC+kBBf08mS2hhDTusdRMl6QooJdhNJh8kT0YBNfgPOeE4VnSUYezFuIoPfTgLPFjYWYQDmq2kulYGHvVjFes2z5x53OexD4SDfR898UIW7b98USmza4FMV9swLtyga9CbCTN0nf+lZYD0sDk+BtQJgu1+U2A6Z2H+UApr9GmDK2O8sjNmpjbXZlXx2+euLtKNHluSnv3ruyXzgwEROPypbcL5Cx51rc2QSSaC/uiFwbymxbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB8276.namprd11.prod.outlook.com (2603:10b6:510:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 15:24:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 15:24:38 +0000
Date: Thu, 10 Oct 2024 10:24:31 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: David Sterba <dsterba@suse.cz>, Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 04/28] range: Add range_overlaps()
Message-ID: <6707f1afa8a2_404292943c@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-4-c261ee6eeded@intel.com>
 <20241008161032.GB1609@twin.jikos.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008161032.GB1609@twin.jikos.cz>
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 607dba49-ab97-449a-4ae8-08dce93fa782
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SoxVcrHZarI8lgQMthlHTLbvyskjU0gLVLRTplNOImMTUHrdPh8MGjmrdkIZ?=
 =?us-ascii?Q?uFdb9w3WaM43Xxph6ExYsLbyVZIRHo0lBgrv5nio1sjjoCB+33hN1MjpqMJD?=
 =?us-ascii?Q?WtILjhnpsMd9kUokpsGgXjfwGHRCy9R+cDt+DcK2ikDq3O7BnTQKvcg1aKI+?=
 =?us-ascii?Q?qM05GprPri3iCK8CmH0NPS7YtuAiyyc6PP9HIAxLe9HsUhKjkuk+TdbqONVG?=
 =?us-ascii?Q?ivREB2d1DweCKGqUSJ2h3/odYutKzHY0YgNdKv0u1FK4Lz6lgLbm3tI/hN4P?=
 =?us-ascii?Q?UeQJ3YiH5dIeDV6K2qe+wlVg8ik/Y8Tsxh3LOfRgHHnyNyangk2UBH+vjSeP?=
 =?us-ascii?Q?fDClDXwEWUq9mEUuT40PnXvGqnGSBh7Ef9NW955adbBXtPiNzmUntE0s0RQM?=
 =?us-ascii?Q?Q2a+371xyy4wrBBc+24Kbvl7UW9VDGA+dZnrppOkKnllx83wigjSAsTa9cbE?=
 =?us-ascii?Q?nfgkgz4WcYYKcVhdja2PbcphxvO/TlvtM6Vfd3D6f5lgTtWFhnHHTVWH/OR2?=
 =?us-ascii?Q?c6iHZWec8lsPmUgZp6dM2jS1QjXIn/43zDEmG9jnDU/Pg5uNc1+lKVq5l4iz?=
 =?us-ascii?Q?C4SRF3UlACWCJQpJIMG8XfGc/odh6Qugn5ixAnTOTS7cLcAPlDZ2h2jNzGxU?=
 =?us-ascii?Q?aMmIIZqid7M2a+1IY6VekoruxXAJkG7RdBR3aU0nbOJyt1Sbpq5IzD7tBKwT?=
 =?us-ascii?Q?zMNC7dPXH96MYi71Z/SM+LjmkctTwhrJcNbnC3PQEbaFCxxbo3+GB20Dubbn?=
 =?us-ascii?Q?EqZKUCUhsnC/RTrBsjNLLQRH65fDfehrj4v/eGWjO+/M47u3E6oD8MQBQOzc?=
 =?us-ascii?Q?y7JQOfxObuyJ1Hlxvjkqd43+DJ+lzIdU5l3Kry21DBbrMWi/Q7sP4kcJsJ8M?=
 =?us-ascii?Q?YDjMpI7MQauZucQ1NVQXVKrt0eZ6BNXiq+yr8qIKwJ9OnDCvy16qNpebgEN+?=
 =?us-ascii?Q?B2bQ5rHbM6L/L+cEvMnY7R5dN+hpbsO9CenOBlnNogQsAHh1jKIpX9xfKEez?=
 =?us-ascii?Q?0tbh2HK3P9wFUJZHdrS7ok/ESdr7ap2E1o+v1Tu09rQWO/guW0MTC/qmM+Q+?=
 =?us-ascii?Q?02+ySftmYNmLhFG0XxT6l/lLC3Fy3Ckmea4xnOHOs18aQhtsYPyZq1eveRjf?=
 =?us-ascii?Q?28z2jQ/zY1dh74SYy7siNL6UgWG1quShq1UhHYE8D8L70ADXiOS9Nz8gLZCL?=
 =?us-ascii?Q?UBp6qALjgOlcSy3BNi/i3FSRdAHWa3K7vJ5e7FvKEoUELiDuZBrkoHOJEpho?=
 =?us-ascii?Q?Cxr2CT4SZg0aEXZBzgi1MizsrjpeBAOHIGejACnkFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AqVGPcjZlbl66xevpeB5MIzhZNuiryFG41+7GRX2ntFmge/JBOpCZBOXkYNp?=
 =?us-ascii?Q?HcED1Zy4bRyTq67TPmSlzPfEW4/54tLQanNMWUSZlqXFxkBtMa3wok7Pv4pD?=
 =?us-ascii?Q?zuwpugQ0rN5t2N/0Ww4LSFe66XLSvpPbqA4eCqs0G+yuvX91zaRNNroL0UHU?=
 =?us-ascii?Q?gEQfpBZMIgjTqlh6DMEO661w634ugePT+RRkkibLyU1B13zVxfmfXdvPOPH7?=
 =?us-ascii?Q?nUlx0l/s6In18mUBQzIlZJ5AiHdX6kT7VDGj98w/zu7GzFU8PxYYVuxdWrWR?=
 =?us-ascii?Q?hJlbpWBiNY697TchwNRlDnR8WvQrhXq/uMaXKsLxMGhiGyz0Q/KAVvlLpMlF?=
 =?us-ascii?Q?RB0TNBhg4lSWRaseVgoZ5BUxFW+xke9xUJ2ZMtJNaXzSJKDSHYwyhLOtSVmZ?=
 =?us-ascii?Q?3iO3uIihiPTRsNx3pE51djPA+ss1gzRY1wwoRTulvl9n845+GWJj4VfqcqNH?=
 =?us-ascii?Q?bHC/t/XS2g+cJ1BqzksDZmiNDMMVQt8hKU4otPZ+8Z3xGTdV19n073j1Ias2?=
 =?us-ascii?Q?LSt8jYi3F+qa69OyOhU7uffrje+NeMUXF5ZjjYv99/kUq26q2jo9UvdUbiHk?=
 =?us-ascii?Q?HhTM6M1AzDsAwdwQbq7kUqBQlBq6wLLthB8sWNTaNLTObaCRIN1EZCYPUqd4?=
 =?us-ascii?Q?nZcF2KHCeeezw25dlD0F3M0kXpQ2yURPRwF1U3P2fJPOEMLZEARu4ftTLJ4N?=
 =?us-ascii?Q?janQyAIvQMfwoqDcGonl2YgLNbY5uIbJ98+eWEoS3WzuveW3v1UZN/V+o/AX?=
 =?us-ascii?Q?tkOlFI+vd/5L+/c13FwYoXrPAJjvlCecNZ7+a8OVbMPQpddYd70jPkNPHWeh?=
 =?us-ascii?Q?baUREGQmWGEx3LcNSDcjBRDCk9Jo5SjsTEWxPu5m8MLYHFGGcFDt07xJiaGN?=
 =?us-ascii?Q?qBDsguz6P71wo7fRnXFabrgXRcqESrLTXVpPDtCjE6Iurqi2Lo98UWD6/LwY?=
 =?us-ascii?Q?VoU0zIoU42h4byKvJI4F2rekaD2I+jTNiOBktW6lcRYYuJzty7CYG3vz+loe?=
 =?us-ascii?Q?IKaysfVVzfO1FqIAG5rIRSaD3VJF4GbjBBqB5khEX4q3zygnjW21h8HiCTHo?=
 =?us-ascii?Q?L2TCHdXT9pwKjci81mCLH7Kd1FSVe5D+5tGZbp1KX99IMlmo2I1/meAnzMP8?=
 =?us-ascii?Q?TUMJosbt10dJA67v64N+Q90yhtxmUirRxaOFlSwURyAShLaOAbKYcslWVdEP?=
 =?us-ascii?Q?C+W+egjLDPUZ0T9Y05PdEYxoBDcQOfKxSVCoDOfKnnkIu6GQrBm+Hu19Q3C/?=
 =?us-ascii?Q?s41X3qvR37/wzQe+8LFIoF/1ULGwM48L7Aolq5T32vdAbepwteISnDiCkPEd?=
 =?us-ascii?Q?qzGqgFqXZ2IWWwKwJoXjeb4jb4IARlznOymoUxfTFsbvRLSctiEpzAOXYfOl?=
 =?us-ascii?Q?kGlHRqA7Xlu9mqJjQXivU+ecpTmvxTubY+XsBp9cqpQ5akIlo8aTsOCe4nIb?=
 =?us-ascii?Q?VVNDUKR3G9c5Q5zt87KvxZrJtkO8tosPoC4xG88L/jlfIly/i2V4g3U4pBDC?=
 =?us-ascii?Q?anq3M5yPEPHgcMWNoO7tGLMGEIdxbxhJr/yTKx86jnxKU7GW7DFNj0S7bsJJ?=
 =?us-ascii?Q?KzSOWCIQzimVbJKcpPw4fulBIPo0pepO+aFtE20r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 607dba49-ab97-449a-4ae8-08dce93fa782
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:24:38.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfhoJZXGKb856o1T34biPjhcVfiQ4lPwkcCjohThcji7t2EPAgsHQKsBhUj6j2hPu2T7qTycGKTeCL3v6DV8AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8276
X-OriginatorOrg: intel.com

David Sterba wrote:
> On Mon, Oct 07, 2024 at 06:16:10PM -0500, Ira Weiny wrote:
> > --- a/include/linux/range.h
>> +++ b/include/linux/range.h
> > +/* True if any part of r1 overlaps r2 */
> > +static inline bool range_overlaps(struct range *r1, struct range *r2)
> 
> I've noticed only now, you can constify the arguments, but this applise
> to other range_* functions so that can be done later in one go.

Looks like there will be a v5.  I'll do a separate cleanup patch for
range_contains() and change this one.

Thanks!
Ira

> 
> > +{
> > +	return r1->start <= r2->end && r1->end >= r2->start;
> > +}



