Return-Path: <linux-btrfs+bounces-8804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C67C998BBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689B028BD7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DED1CCEFA;
	Thu, 10 Oct 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhZFRpTU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21930188CAD;
	Thu, 10 Oct 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574328; cv=fail; b=D2eqCf2VyV+NhoaNwzYtT0sFSvZh0VyLoeNAkpMWTPUDKpnp3vHDLQR/boc3nfFGMpu7ELUQ3MFZ/NOMa+OBD1rEqbCJnVHm/Eh7IMqCUlTyCnjCESVpV/2lbPnJ5L/PfhT5Q4c9VEEqGljKCJQHe/3M9wGQDokdi9wDIT8JVC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574328; c=relaxed/simple;
	bh=fxfuPT4v4LFzQztrddxUUanAcGTKKGuCqxQnpsu3x7s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eADTvwO3WwlubZnPqZAjEELcga6UZ5dA53QWC1Vyk6aYLU7gzl/g1G/eg7dSUNja4O/gNi6HYV1EpBYbdi61XTOdF6usqH6JrPjYxL8ai7ts1NWaxOWEIrhJCGKQeSAPaIi7FaNmeNfUxQXDkxz8AfeP5COp7VAFRtspmFdeiek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhZFRpTU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728574328; x=1760110328;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fxfuPT4v4LFzQztrddxUUanAcGTKKGuCqxQnpsu3x7s=;
  b=BhZFRpTUL9aGSJvK0hBuJ3QhGmq4nScCX35YokiMbXASXzj+oGMC49J4
   WQ/TfiIuc7kgpW6nOt9jyBulmcVOT6wz2eksZu4Mk8A5M/U8Ac2BvXokA
   DDlZeRra0qnN0ipp/o1hyZsYyMnsMp8eZcjE4sNM0IxkJUNwdBS53P0Fq
   ym/tPEjX+iIp5M3Wt47e7i1yS9C44yyzF3EjJMHdUKJEE25eGJLhPAWNK
   9wyYeyMhhlKDIPdKgQEXsdzAd9Fqz5qoDvZLDG6NDqKFhG2TtQPdakGvL
   WfERp/uPNYEiagMcjfTh7W8HyRva6kKaIUgZ8uU9aQA+LviuvZaNlzLJz
   Q==;
X-CSE-ConnectionGUID: 9BuhEnCJQM2n/tjLXeaveg==
X-CSE-MsgGUID: OW1qzHURRD+A4eyXON+ORA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39070048"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="39070048"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:31:24 -0700
X-CSE-ConnectionGUID: OSltfw6GTQ+iM6RLqkJAyw==
X-CSE-MsgGUID: I1z0RAH9QZGU23SS0MQzoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76288281"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 08:31:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:31:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 08:31:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 08:31:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 08:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8hSOZgPVGWzK3mpjbotFi0qU1A52BOZWMw5FJkUUqyEnY9iCf1LYaR8vJmZu1Od7OlSoOpvr8TpUUtKMPMqq+xcpcCkLJgOmsmfrx8MPfuKF7KvOCrQ3+Br0W7dYdzAeZKqPLII3S3PvpA9MUcwlP+X/KNR9E4pGfQ9NSwcft33Z6KdxCf8TrMu3uMneNe3UjkDRpZBhevz+YMfpOzJYkX53DeRJ6TZbYv/s4QhgAFlkNccBZIMNmpOGRxKBo2hgQSulZWNEC1MpLIB73A8s6R4OiHdCMev3M01Wenti4swtxMzxrt0a3xZ9E4JPzBDuQi+xJ97LJ8G5wZg6RUyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ9MCV/wwsJ6MmLR+NNgdOhj1u/ErlGTu70uNqtDySM=;
 b=oe8M1UHO3TiaKuX3y8BVPG9Hp3mw9iaFXfBrL5ncgYUsGAXGJLjLvPlEk+1PMxDktpx7UasigHlxf2ZHVOn+Y/DH+Uc4viTRS9dfvlXTZ42DluEzgRzlIh1V41DYpEcXlA2BMQsl3/boFXMJ180sjemsMvSBPY6nVhQ5/rCsrYwERM/KY/qxcDfNoFexs8eH3eFtPnQZpjNxNgB1jAJm3A3lxnOhvY60k9uqz6JV2f7y4rrJagQrEUG7aV/E27u2RXWr0Ph5qY/rIeeQTN39Ig15l6c20UC1aEyMbjjYxsW7JX9RlsNs1wupql+oimYrOpD4H6ZXhe0KHYji1IvV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 15:31:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 15:31:16 +0000
Date: Thu, 10 Oct 2024 10:31:08 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, "Li,
 Ming" <ming4.li@intel.com>, Robert Moore <robert.moore@intel.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 00/28] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <6707f33c89730_4042929481@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <ZwW4yQ11wYkaqdgx@fan>
 <ZwW7E2gSUM8SHAzo@fan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwW7E2gSUM8SHAzo@fan>
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: f2507fa2-b0bf-4aeb-82b6-08dce94094eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K10fig8HBn+s4sfXru/E9idvbRylxFwNhc7IuzYReEpi4IOUMBvMPqsV12s0?=
 =?us-ascii?Q?CWPI3LPn9zxrO+SYJjh9B/OHvqHE/lqPkAvYcQizdXMWLOoblOt23dwUbwEa?=
 =?us-ascii?Q?zM5iGFQJnrt2dJclUAaEScmamUv0Q61UAqB0U03jbuvfIKTaO9bONiBYiaUY?=
 =?us-ascii?Q?wOMCKYbw76rDt7AZT6LK5U/7nnQxV1OrcMbzwi7HvPKbHreHOSYh8Rze7ki/?=
 =?us-ascii?Q?MjuwdvPWYsSwyaV0XLTh2UxwKhgmW/hvI/QmKLZ0YRgsww3hd5muyoOnJ79e?=
 =?us-ascii?Q?2dir6fYyFpLq9BbDqz+NLV6v7fQz1YrivZhYCIz9cBtiPX5UHqeuZ+VRs69H?=
 =?us-ascii?Q?gmqiHhK2znk+3Q/B37vVByJj99Mj0VQMwrSXTaqBAas8mRepnDsb2PM931iZ?=
 =?us-ascii?Q?XLG41mtLWvnPUX7UD+cEyGjzIy5htZPmaVuZ9BsGrj+mOhYk/OVXF3c9WUG7?=
 =?us-ascii?Q?+lbT09JIC8gpsVBxfntvJSj9ACZYXgBPqPNb0c2wjlLw0WhJfTEQgD1VmjTS?=
 =?us-ascii?Q?YuA4ffi2pxZJsPjdiWsnNsW9i1odAPP892Dmxu41QGaE5NnxafVLsj87U7jz?=
 =?us-ascii?Q?PD3ghJn/H76gXJEYO1swv2vo/2VlpJg+N9h3txzEF95LzeYC7byVrYFvKZqU?=
 =?us-ascii?Q?lUOrhaJTrIi0Wi+khsqgOtAgevg3cXU7qKGuZNxeSdSf/sRLUU+HGX9giQo2?=
 =?us-ascii?Q?leTRBPTlR2ZBI1gmCX8Bve61KBE0Fx5h6tOxAIz0kFX5/GCvFKo0/Khi5ivF?=
 =?us-ascii?Q?NAu/ga/yAJTqFsM6zv6hpYugekCE+UT4QQ+R8cSp308AHzGZQL2y6KIZGN/4?=
 =?us-ascii?Q?mUlXdTBGp77eYaUVOLJD+gnIZAHVTz192CzGxa2oIJxUzXYUD6qP5tm4GB6f?=
 =?us-ascii?Q?NCHX95jFUmrH6IX+VXYb40uFS6AOy8RofToHPf2SaMITD2m28EITGzXXSlqY?=
 =?us-ascii?Q?T3dQe+Xuv+8cu+rqMG4TJysMpnX50adZpDYu9H3NZmnBpdb7F3zBl6WraQqj?=
 =?us-ascii?Q?shTWpkRS5BMMznyM2qT2q7IZv/sGcnoCSY+6o6/aFWwZA2VoDQs3h7h53Vb7?=
 =?us-ascii?Q?fhUgIcxqFVImIJHkHJpBKDTl/0PBG80KqnPLQms78q8KWUduHIBxVyIb/pJr?=
 =?us-ascii?Q?wAIzvxBXDPn3jjFnRP1FKHUgjf9ZxaeXVovBN8sYdk3OGBg5S5PHZK+UwXkK?=
 =?us-ascii?Q?1Bk22rZHmEvbVOijYvvjSBsWEpPzR4cn304lt4xq5ih+ZymsIzx4v5Wxfd5O?=
 =?us-ascii?Q?mOSH9KT5/SojSYrYbZ2OzF+ayThX3WlbYQ2O2v9qog=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXJWArpK/KSfcqEJcH6oNXlz5bfMoR6896kBkLNk2B+j2Jti1lfZeAddItNI?=
 =?us-ascii?Q?NZwaFOQmw7ESmdSxUduHcj7kfpW9o07h4xW9ipldbCsXPbXuUODXSRwvz9X9?=
 =?us-ascii?Q?J8C5CCPlZlwV+woqQhiG8E4qPY4ra4xb/RqwxE+n/iV+WWJknNZuwZVxaaBu?=
 =?us-ascii?Q?BL+ST/4vts/Ku++oznTulXJzNF5LIUjmVZv51v5brzyx6fZS0n74GZpEcrf5?=
 =?us-ascii?Q?ZERQU3npq6FoPIXLCMWHl2TmX1q+gS7PF8HC5jUCEowM1rt3QaatPP8bYf1F?=
 =?us-ascii?Q?m+t6TgRXVkc5oyZ8KKqyBMJvJ8styVoUPF3Raz/SUD2pluI6zpnIwkYo9oT7?=
 =?us-ascii?Q?axH+xcvfy6x4xhPXKIZqyE8lrkCjlMVonSlvwUooxEwY/MrNglXysaJ9WI1T?=
 =?us-ascii?Q?dhvrs+gECf2du31hZ0bhpY45qGuKpgZz0FGiZPGcFoHvny2DveJwgtrS8HQx?=
 =?us-ascii?Q?nLhBkb6nkzT+hMARcENuPNfQliNor9oCvpT2ydgFH8hKvGbkkpYSLaogsoVL?=
 =?us-ascii?Q?7j8hijai8EfHNI4ldByxeDkFWAUk8fH6jCcMuHGzsUMFdPNe3vHnIHDjaXu9?=
 =?us-ascii?Q?3ld/jHEyFLZMdA0rBLDn37MVZOG5S+dX26eQQadMceqaZODba1vdfzu04grU?=
 =?us-ascii?Q?CcSpVqVod91sBvLjdrPbSvaKHthbJOMyMVd1O3ys3C47s9nAjfZNsRQUfBwf?=
 =?us-ascii?Q?ggTY+M+qmZvndoi5VGnSY/lUE3brG2TceFMowx10f6l3LJAO5qmSnU5G66dk?=
 =?us-ascii?Q?Ux/D/HU2RUvNHiV6/SgBoW/Jkn/0CvTrs6Invz2eXceA9MdNvcowuO6jD/Dt?=
 =?us-ascii?Q?r9GA86QUFcvIenCC9mzJ6CI3+8Zm2LeC052rmZa6rilZVMn57iHSefAmyNNx?=
 =?us-ascii?Q?E/cwvEqgUO1dockAYPbFqohmIxcR91rXOVYVoKfAAhNqChxwWA802ZmmSoX3?=
 =?us-ascii?Q?8Obd9irU+76QQHFMe8miVjiSx1+HM/unr26NWtsmctfaEuN6o68Tjh3luSf1?=
 =?us-ascii?Q?b+/EYZTr+TqxDsd4/HsVDnLbIhz8Bythg8U4GgcIylIo9KlQ1H5UV0cHWn45?=
 =?us-ascii?Q?AlHxxygimNnarLZiWCjtVqhsfiNw1b4/v1IWB5H+WGxT79+ZZ6dlQCDRc95/?=
 =?us-ascii?Q?sZ7IjSVzI7fal7hVoUJJX0QY20pV+z3pDasvqQLc+TvItJ3k8dNILdsCC1Bg?=
 =?us-ascii?Q?HjT0bugDdy1GW10bBDTNngE/LpM2rLWYfPEUrs4TwmHDP+FzFc/ZPxrhgnLD?=
 =?us-ascii?Q?HCIAmN6ek7+VxKRzXR7WLMnHcApKwWglc478ykPE94mJWSMdHrrwk8rCqtfo?=
 =?us-ascii?Q?4BXNSaBuhnipvZs0GzyXCEZsX/Ec44yMjCmXX9K1xFHtJ5+3hpDpI3l7X5ad?=
 =?us-ascii?Q?xEWlvP+7RVn6NNF46AM3e4RvAoE28wx1kG/p+77jnKoZzyS8QrLoY4fDqn+M?=
 =?us-ascii?Q?f6XIngP41IpZIuBUBHGUwUPtGKh95IevccoR3LeSYpwOPLkp0ozI0tnGPCtO?=
 =?us-ascii?Q?5XceDxc0Rfa9AtfBNF088amGKnc5zwHN9szd4aVfYuUFOkZZ1OxQPbnIVzFK?=
 =?us-ascii?Q?EGoiy7YccXk+EufaRB7E/gthYO7Q1tWq2AOXjdYJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2507fa2-b0bf-4aeb-82b6-08dce94094eb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:31:16.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2M3w0UzdniKHgAphYTM76+suPhHOvT/7nwBgtys8eg/GIRHZTfqUkmK2OAVp2/jtwxX5pxDqfP0QT5bgxh2lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Tue, Oct 08, 2024 at 03:57:13PM -0700, Fan Ni wrote:
> > On Mon, Oct 07, 2024 at 06:16:06PM -0500, Ira Weiny wrote:
> > > A git tree of this series can be found here:
> > > 
> > > 	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-10-04
> > > 
> > > Series info
> > > ===========
> > > 
> > 
> > Hi Ira,
> > 
> > Based on current DC extent release logic, when the extent to release is
> > in use (for example, created a dax device), no response (4803h) will be sent.
> > Should we send a response with empty extent list instead?
> > 
> > Fan
> 
> Oh. my bad. 4803h does not allow an empty extent list. 

Yep.  It is perfectly reasonable and intended that releases are ignored when in
use.  Thanks for reviewing though.  As Ming has pointed out I've got some
issues still to clean up.

Thanks,
Ira

