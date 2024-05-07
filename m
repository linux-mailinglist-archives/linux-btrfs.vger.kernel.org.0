Return-Path: <linux-btrfs+bounces-4788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CEF8BD8F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 03:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9CFB2154B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 01:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9EB4C90;
	Tue,  7 May 2024 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5+ludtm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8F4688;
	Tue,  7 May 2024 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045450; cv=fail; b=j9DNXpqRuESUq4ajgF9vjfmz8sq3JwgwT27ACCMAD3aaSnTT7OKwvWpEte6mXg/hFNgTAXdc7EZtEUhZHMAxdsIl3VFmSMaxPvDZbJ0lhOryEjqgejWkHxvx1unUrkZZIPJ++TA94ChH4Tpw28vjjRBFxqRPfxCOCm9CBmQnoeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045450; c=relaxed/simple;
	bh=XM27Faunz0Lj5N5lTHNxJSjvnJTaywskr0CM1DWmcVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J1/4VeTxhGvcGCy7pnM+ImIPAo9IAtfVfzcyWuhsvXCCF55F5SgHbq/XKamwA/itrP/RUolYR66XUoJ9rYXp2aiz+v39f329YYqMnBX3Ihu4BNBRFy6dsLzgycoAx9PQKledh4vX7dQh0WMCvyVsRTZaIvPqmljlYcMIEMO4RLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5+ludtm; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715045448; x=1746581448;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XM27Faunz0Lj5N5lTHNxJSjvnJTaywskr0CM1DWmcVo=;
  b=P5+ludtmIAqLZdcFjGCxq0pF/mEPBP98xvrNOpj1KNSHQI+sUAkzvI6J
   RJx7n5E+E679c7fS1DKMI0ATlF3hILBqfvn6vXUNRvRYsf3lAwuei1Xir
   AlvSQeLQaUPmuR6tgvjvpGuPyvSQxU6jIGMPLzuWJxvJiPFyOOf2E5aJ6
   rYmdC06wDw8TPeZnCf5oz2Qow5b6racGqI556LnYcitu47YPi7Zd8d6N1
   cBTsGSs9ZslzNY6cLPm2icr+U+b4CoekCnxlJnsy1yGg3RhH+ly/112wr
   lxFj46LUY8fjQEcYZBjwIBCjoJejPTWuElnxlHmUmZPrFj2dUwFJICIaa
   Q==;
X-CSE-ConnectionGUID: QFDCai/PSR2FkmdQuPZY0w==
X-CSE-MsgGUID: 3dV9iis3SuSA9V5mBps9Hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21428499"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="21428499"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 18:30:48 -0700
X-CSE-ConnectionGUID: NY01XdrAQoOlws8t4J+WXQ==
X-CSE-MsgGUID: IgTDiCaNS7iMawFIuVZVgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33175618"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 18:30:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 18:30:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 18:30:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 18:30:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 18:30:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sgv+jlbTncKqXN65tUyqqEavUHJGBBtaeR1T8CbeouFucnzHgnPLmNAPZ7ygJ/iz03kan6N3/zUskWMtcWZcxmCgFsWDAcEaYD2Rpwh+q6gvs6MKLSndjofBPhwgciYTORMlTcXCqpR1N1t/dLwWgpRKcdy6Kkp4mk5lW2eU79ywhYKA+TxKOuFaDWowQtH4rDAL9MkDgxTW4sP0uZ+ihSfnIqPAhYfTEiRmVUM249XrXGPJ70POp3hNWwHL5Bk758XFIEQXqJHkpAmGvTEYVEswQrhqGfnFBQORDyYp3NDQpfckbsLgiEvggOdBYnZp09fwZdbP2yYmj3Kbj0DtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePqd8t3pHggjyncpuZNPERXG/wNGUWqTLhFj+crTbKg=;
 b=KcfQxK94bESxRjDYlxhkiG7JzfvVPl9bHjWK27x4PYEwv0MRP6fr2qLaSTsd19mYZB1e5m64Rf6Tec3QYXrCVdtZ8X5Mb6x/kQm5UzVPVdET+196TPAhK8O5J2qYx80SznrICMRi7ZvtAgYlg2XtrOr3qvWSDcn0KUfK3G/wNoZTs9Le4JGULDIzah0LUGlXVeEtZy/UtDwoFgSdhSRKdqcBE9miY52Vp1UHntLca2Ypu/XP1JaJ4eik36vvPFf7DbGgsH2Z/6p1yS8JhVBX5a0LClAhHwEIMQmEy1jHnQ1TAOkyZIVe0NVhynJ22WiDOnyAhnZWoMWHTMWwPUqywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 01:30:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 01:30:42 +0000
Date: Mon, 6 May 2024 18:30:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/26] cxl/extent: Realize extent devices
Message-ID: <6639843f72ef8_2f63a2948a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce9bb85-f0a8-494c-1892-08dc6e354f7b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cmmnx1u4z4TZrgrkjskatqCFgIMHbxdtwsipXpQ5vuGOd7OaMq99upLP54BS?=
 =?us-ascii?Q?vOVLma4NUZ1/4j2ZfZBW2ytOIopzOEBzekDMkigOM7xscLeki5i9Wuuaj/PJ?=
 =?us-ascii?Q?SQR9wHTifJEY8LPYCQLsAJ6jbIqvIL/VqpJMQZPI0gNeLPnHzSTE6zT+qPCo?=
 =?us-ascii?Q?6/KwwcIcTzpULS5vRur0zNnlbIjxZv2iZyth5l3+oh1lKi7Au9WQC5XypV+R?=
 =?us-ascii?Q?N+1wwTgro3soHa2VIcEGNZ+E35De7y2MilIhhPjChKKwPJwBnLR5t2kxbRCj?=
 =?us-ascii?Q?rxUF7eNVEuwPi2n+R1o4molKMRyA6CEqnblVb/Y4xQo9gCCFDfSGpwR22vOO?=
 =?us-ascii?Q?pvoWHUp12QYx7n3E+4+NGPfHpKRlPOWvuiJ8BScVJerFyQBn4mx0fb5xPVbZ?=
 =?us-ascii?Q?TBHJ1vkI+8X9AmAC5th6UgbVY1bg/dBn6fUjW+n7xIJ91v3ES7/udoJYew7B?=
 =?us-ascii?Q?nLLLVM6sJzC7Qdq2s98vCglnGuoliZeP5shDMiJ3CqQin0x3N1dKLO0o0KBZ?=
 =?us-ascii?Q?/+xOtbEGjHOgdrc+hxj//G+nIlgRDdl2qrAk9olNKV9BSmFqD3cNrwYnMdIO?=
 =?us-ascii?Q?fGzXbWkEQwE4RztqEyt6AOIZxL1jn/7ToVHL5fSlGjTKxsNlTE5E02NmDi9L?=
 =?us-ascii?Q?P8qx2jt0kJ8x7O+ZrspVAvvTAUKdR+2kCWm/W5hsm1K+9ATcaXSnjtsAeB1u?=
 =?us-ascii?Q?INP3GZ4iRXoZi2hBq7JtNVQkSctcsCQKAsM673+H1ARYiKzidl9bG6wBQuKE?=
 =?us-ascii?Q?0QhCMAyC9TidhfUok0He7CrL6AX305cB8mH9m/RyfT93RXhHm/uJ4IYrC6VA?=
 =?us-ascii?Q?JwpWulMuFXptGrD6D4hFSVwRPdxcJ0fHCRZDg+8MhD3w4yYtS1lb89ZQ9kI6?=
 =?us-ascii?Q?tVQF25If1XYqu9y1UzR3HChU+UG8yW2PIoERO+6q8hiSg3NvpvV+GWFveNuZ?=
 =?us-ascii?Q?ESeaAHxYNjsC6MFtVLRX7SF0pdCbhE4M+eIXhvxvNQCjzHmSgri6w0TAi4EJ?=
 =?us-ascii?Q?eCaJcl6lB39zB2pM/CRXng2CIHzbg2OHjugYWcNELNaLgs42hKVFVPtHbawR?=
 =?us-ascii?Q?Z3omhq13hHSCfgnh+gOEZ5PnGUMrGfKwZX4hVFutLc+CvrR2flHoC/MjGO2H?=
 =?us-ascii?Q?hH4W+WIcM4BQitCbsJb9Z+5rpe0bfysJ2O8Q92I5g6C7mSOnAfiPwK5s9NK7?=
 =?us-ascii?Q?EjcWfCb7SqqTZ0+zib3C/MqQXSDbefWReHg8CMmrUYTkkNrxPJT4THBycnIL?=
 =?us-ascii?Q?zOGZ8UI5jDk/g8YVGpV096+A3bMN9cscL1PaDaxgFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAJzmij6ehL6cMnvdyViK4/dsdY2ymxmtIsjYipOLSKab1asFZuXdsoNlTN+?=
 =?us-ascii?Q?XnE3BH1b0KUmBBPG1HV03CtO4K0srUY70RrU7wwEBib7U7V1bk9lkp9kQu4a?=
 =?us-ascii?Q?/yTboKOclGImc/uNrUS6X5eBZQ4RKAquzkAXii2wlp9MEwjN4kmqXB6UmrYn?=
 =?us-ascii?Q?x/aopwfyVo66C75fJkyoZKCs74lfj+jDjnjO51KIowwKYE5ZBbrwaeSol6jO?=
 =?us-ascii?Q?YyWAdsMYGN/ors62nRDe1Yp1UoNaFaapcSdfhTJPXI1gfzu/xtdG7XIjgOaQ?=
 =?us-ascii?Q?jhlrwGPHOG1UebNkYs+6rqHkMahrxM5UGV/0Kc9duxClOyy5I1nyZVTuZw47?=
 =?us-ascii?Q?NGfTTwKIhnvtM0flIH7s+ZZcO7z38qbn7YR7qMe0FGpov67cLWcSOmAvGQm7?=
 =?us-ascii?Q?VdrVwt0XIVzSpPlfgvp5VP0OpNcf2s9WsaDQDYTXZdyERP3x834PZ23zT1TN?=
 =?us-ascii?Q?/cqQVacsACxViea44RPZoPw5ynYIhsZU5aIDkBlsgs73KKojxhWbXEnYlWyG?=
 =?us-ascii?Q?5kX+R34meQ63hWP4puiNtnFS1NLGDZpOmVJTKMu4BNhG+HpQApM1w+DiV6cH?=
 =?us-ascii?Q?F7E2+CINE6jpQeGIGRbwz7mBPRuBpiL+io6Ti56JTYRbuwzPsN8h7unMuDDK?=
 =?us-ascii?Q?WC7Y+XDtZQYpSeMSzHNdUhFutPqrJDsRZIvgDvd0nhJYvXDphL2kFRpiUyCz?=
 =?us-ascii?Q?AFnu23tW0970L56HVeC68Xd9YvqcWSP/nF2WWK3uT96tcZ+GgGxVtR23VKpF?=
 =?us-ascii?Q?asZmcI3yMLMVUNQtrhntdA5NhBt1yDlg3Zhjf3xiOS93a7NPScH/XaT5mZ3/?=
 =?us-ascii?Q?rrybx/l5mj3n/HyHYHZqwejjQQ/Z5IG3T+AocBWCwo3HmHZwS+YackF77a0J?=
 =?us-ascii?Q?/+megzIDLNhhuTq6dwjp2Oc5K6Bfj7+0h3Suy1D8Dc0DCXo6S4jUJ4zVppB9?=
 =?us-ascii?Q?MYaMZ2Bk4gUmeq1N3XusAXEF3/2y8e3GIE4pcB6C8n6MQi/wtGxYwfabZOB7?=
 =?us-ascii?Q?6froLtfHCgDA4JNCTG2r3LHEVM0vKE7QS93fzrDN9dI6oJ+MPP1BTblN4jBQ?=
 =?us-ascii?Q?m/506twqIrz3QAdQfyzc1angyKPYdDQ3c6PDc5mMDu96UaLOVwDigi5rfkcY?=
 =?us-ascii?Q?sOLg478d2BaN+5+p0YDHnLh8hMTB/wlf0Su6DB2cjK83yadbyRYgbshhzvqs?=
 =?us-ascii?Q?GnlX7L0wWobRTJ5U1r3ZgQGohxFL4HFwBLrSDHpYe1lVeqKXyVE8scAgbsMi?=
 =?us-ascii?Q?mNeo0/BSR64mFOB1xlVF7vs2yGSmHoUv9trG4y5ZiStz2gv9NQIdA4To7GMq?=
 =?us-ascii?Q?SBZtyGSVDUhJ5w0iy8+qRd2lfaSfVVwCXMw2UkriIn6hrjWOFL3G57bigJmb?=
 =?us-ascii?Q?fq2k9V3ULgZHVhtCZ7R2Hb+wanS1aPkz3Kz3e1l60N/f1Dj1bcx0Z4DvK30c?=
 =?us-ascii?Q?zl3CtRIDFdzmghjoVfbtiVM4ZBkthMmIIzrwCtiOmcP6sUU1bSz9KGdFr9si?=
 =?us-ascii?Q?Wca4MIOJ9uEzlg+xwDs114lU95sOOSTIkRT6IRyyQdJ2O6S5Ww6gvHWeP+N1?=
 =?us-ascii?Q?cCQXis4e2gCeL5BczERf8GCrclrtmOq8Q7S2QOmejhh1KGI62o+gw8ZKN+VJ?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce9bb85-f0a8-494c-1892-08dc6e354f7b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 01:30:42.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/qjsHlx1a80wAibfPriO9xZq5WRcWNCeZjyoHWzYIVU6B1JpYcm48hoME/BN0Etok1lMsecBLp2E0YFg2dJLAgx5TAslrnOcqP9XJT4Ybw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
X-OriginatorOrg: intel.com

ira.weiny@ wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Once all extents of an interleave set are present a region must
> surface an extent to the region.
> 
> Without interleaving; endpoint decoder and region extents have a 1:1
> relationship.  Future support for IW > 1 will maintain a N:1
> relationship between the device extents and region extents.
> 
> Create a region extent device for every device extent found.  Release of
> the extent device triggers a response to the underlying hardware extent.
> 
> There is no strong use case to support the addition of extents which
> overlap previously accepted extent ranges.  Reject such new extents
> until such time as a good use case emerges.
> 
> Expose the necessary details of region extents by creating the following
> sysfs entries.
> 
> 	/sys/bus/cxl/devices/dax_regionX/extentY
> 	/sys/bus/cxl/devices/dax_regionX/extentY/offset
> 	/sys/bus/cxl/devices/dax_regionX/extentY/length
> 	/sys/bus/cxl/devices/dax_regionX/extentY/label
> 
> The use of the extent devices by the DAX layer is deferred to later
> patches.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1
> [iweiny: new patch]
> [iweiny: Rename 'dr_extent' to 'region_extent']
> ---
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/extent.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mbox.c   |  43 +++++++++++++++
>  drivers/cxl/core/region.c |  76 +++++++++++++++++++++++++-
>  drivers/cxl/cxl.h         |  37 +++++++++++++
>  tools/testing/cxl/Kbuild  |   1 +
>  6 files changed, 290 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..35c5c76bfcf1 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -14,5 +14,6 @@ cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
> +cxl_core-y += extent.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> new file mode 100644
> index 000000000000..487c220f1c3c
> --- /dev/null
> +++ b/drivers/cxl/core/extent.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxl.h>
> +
> +static DEFINE_IDA(cxl_extent_ida);

I would have expected this to be region scoped, that would also allow
them to all be listed as extents on the "cxl" bus because they are CXL
objects.

So at a minimum they would be named:

    dev_set_name(dev, "extent%d.%d", cxlr->id, extent_id)

...but given the idea to have multiple dax_region as the management
mechanism for coarse routing of tags by regions this might want to be a
triplet of

    cxlr->id, dcd_dax_region_id, extent_id

...at a minimum lets give some freedom to figure out the tag routing
mechanism especially with the threat of multiple dax_region's per
cxl_region.

> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)

For something called offset I would expect the output to be relative to
the base HPA of the parent cxl_region. Implementation below looks like
an absolute, not an offset.

Now it might be an offset but "hpa_range" refers to an absolute range
everywhere else it appears in the driver.

> +{
> +	struct region_extent *reg_ext = to_region_extent(dev);
> +
> +	return sysfs_emit(buf, "%pa\n", &reg_ext->hpa_range.start);

Note "%pa" is for "phys_addr_t" or "resource_size_t" because those
alternate between "unsigned long" and "unsigned long long". Likely this
is subtly safe because there is currently no place where a phys_addr_t
is larger than a u64, but I would feel better if this assigned to
phys_addr_t or just did %#llx since I think u64 is always an "unsigned
long long"

> +}
> +static DEVICE_ATTR_RO(offset);
> +
> +static ssize_t length_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct region_extent *reg_ext = to_region_extent(dev);
> +	u64 length = range_len(&reg_ext->hpa_range);
> +
> +	return sysfs_emit(buf, "%pa\n", &length);

Same %pa vs phys_addr_t vs u64 comment.

> +}
> +static DEVICE_ATTR_RO(length);
> +
> +static ssize_t label_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct region_extent *reg_ext = to_region_extent(dev);
> +
> +	return sysfs_emit(buf, "%s\n", reg_ext->label);

I like Jonathan's suggestion of just uuid formatting this and calling it
"tag" since these things are CXL device objects they can have CXL
attributes.

If the tag is empty then just hide this attribute.

> +}
> +static DEVICE_ATTR_RO(label);
> +
> +static struct attribute *region_extent_attrs[] = {
> +	&dev_attr_offset.attr,
> +	&dev_attr_length.attr,
> +	&dev_attr_label.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group region_extent_attribute_group = {
> +	.attrs = region_extent_attrs,
> +};
> +
> +static const struct attribute_group *region_extent_attribute_groups[] = {
> +	&region_extent_attribute_group,
> +	NULL,
> +};

Just use __ATTRIBUTE_GROUPS() helper for this. Note I recommended that
over ATTRIBUTE_GROUPS() since the latter does not allow an is_visible()
callback to be specified.

> +static void region_extent_release(struct device *dev)
> +{
> +	struct region_extent *reg_ext = to_region_extent(dev);

Does the reg_ext abbreviation really buy that much versus just typing
out region_extent?

> +
> +	cxl_release_ed_extent(&reg_ext->ed_ext);

No, Linux object release time is too late to touch the hardware state.
Unregister time is more appropriate. However, this gets back to whole
question about "why should the kernel automatically send a release for
extents that it found present at the beginning of time?"

For example the driver does not reset endpoint decoders on driver
shutdown, why should it free extents just because the driver got
unbound?

Now the question becomes when should it free extents? I am thinking the
policy to start should be identical to endpoint decoders. I.e. explicit
decommitting the region causes all decode state including extents to be
freed and FM release dynamic capacity events to idle capacity are the
only methods that extents get released.

> +	ida_free(&cxl_extent_ida, reg_ext->dev.id);
> +	kfree(reg_ext);
> +}
> +
> +static const struct device_type region_extent_type = {
> +	.name = "extent",
> +	.release = region_extent_release,
> +	.groups = region_extent_attribute_groups,
> +};
> +
> +bool is_region_extent(struct device *dev)
> +{
> +	return dev->type == &region_extent_type;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_region_extent, CXL);

What outside the core needs this export?

> +static void region_extent_unregister(void *ext)
> +{
> +	struct region_extent *reg_ext = ext;
> +
> +	dev_dbg(&reg_ext->dev, "DAX region rm extent HPA %#llx - %#llx\n",
> +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);

Another use for a %par range print helper.

> +	device_unregister(&reg_ext->dev);
> +}
> +
> +int dax_region_create_ext(struct cxl_dax_region *cxlr_dax,
> +			  struct range *hpa_range,
> +			  const char *label,
> +			  struct range *dpa_range,
> +			  struct cxl_endpoint_decoder *cxled)
> +{
> +	struct region_extent *reg_ext;
> +	struct device *dev;
> +	int rc, id;
> +
> +	id = ida_alloc(&cxl_extent_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return -ENOMEM;
> +
> +	reg_ext = kzalloc(sizeof(*reg_ext), GFP_KERNEL);
> +	if (!reg_ext)
> +		return -ENOMEM;

@id leak?

> +
> +	reg_ext->hpa_range = *hpa_range;
> +	reg_ext->ed_ext.dpa_range = *dpa_range;
> +	reg_ext->ed_ext.cxled = cxled;
> +	snprintf(reg_ext->label, DAX_EXTENT_LABEL_LEN, "%s", label);

another instance of the "tag as uuid" feedback.

> +
> +	dev = &reg_ext->dev;
> +	device_initialize(dev);
> +	dev->id = id;
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr_dax->dev;
> +	dev->type = &region_extent_type;

Lets also place these objects on the cxl_bus_type alongside endpoint
decoders etc...

> +	rc = dev_set_name(dev, "extent%d", dev->id);

...but that does require a naming convention that will not collide in
/sys/bus/cxl/devices

> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(dev, "DAX region extent HPA %#llx - %#llx\n",
> +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> +
> +	return devm_add_action_or_reset(&cxlr_dax->dev, region_extent_unregister,

It is awkward to use &cxlr_dax->dev as the devm host here. How do you
know that that @cxlr_dax is or is not attached to its driver at this
point?

Likely if you want this to be the devm host this device enumeration
should be deferred to cxl_dax_region_probe() in drivers/dax/cxl.c.

> +	reg_ext);
> +
> +err:
> +	dev_err(&cxlr_dax->dev, "Failed to initialize DAX extent dev HPA %#llx - %#llx\n",
> +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> +
> +	put_device(dev);
> +	return rc;
> +}
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9e33a0976828..6b00e717e42b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1020,6 +1020,32 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> +				    struct range *extent, int opcode)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t size;
> +
> +	struct cxl_mbox_dc_response *dc_res __free(kfree);
> +	size = struct_size(dc_res, extent_list, 1);
> +	dc_res = kzalloc(size, GFP_KERNEL);
> +	if (!dc_res)
> +		return -ENOMEM;
> +
> +	dc_res->extent_list[0].dpa_start = cpu_to_le64(extent->start);
> +	memset(dc_res->extent_list[0].reserved, 0, 8);
> +	dc_res->extent_list[0].length = cpu_to_le64(range_len(extent));
> +	dc_res->extent_list_size = cpu_to_le32(1);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = opcode,
> +		.size_in = size,
> +		.payload_in = dc_res,
> +	};
> +
> +	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +}
> +
>  static struct cxl_memdev_state *
>  cxled_to_mds(struct cxl_endpoint_decoder *cxled)
>  {
> @@ -1029,6 +1055,23 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
>  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>  }
>  
> +void cxl_release_ed_extent(struct cxl_ed_extent *extent)

I am failing to grok this naming see comments on 'struct cxl_ed_extent'

> +{
> +	struct cxl_endpoint_decoder *cxled = extent->cxled;
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	struct device *dev = mds->cxlds.dev;
> +	int rc;
> +
> +	dev_dbg(dev, "Releasing DC extent DPA %#llx - %#llx\n",
> +		extent->dpa_range.start, extent->dpa_range.end);
> +
> +	rc = cxl_send_dc_cap_response(mds, &extent->dpa_range, CXL_MBOX_OP_RELEASE_DC);
> +	if (rc)
> +		dev_dbg(dev, "Failed to respond releasing extent DPA %#llx - %#llx; %d\n",
> +			extent->dpa_range.start, extent->dpa_range.end, rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_ed_extent, CXL);
> +
>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3e563ab29afe..7635ff109578 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1450,11 +1450,81 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +static int extent_check_overlap(struct device *dev, void *arg)
> +{
> +	struct range *new_range = arg;
> +	struct region_extent *ext;
> +
> +	if (!is_region_extent(dev))
> +		return 0;
> +
> +	ext = to_region_extent(dev);
> +	return range_overlaps(&ext->hpa_range, new_range);
> +}
> +
> +static int extent_overlaps(struct cxl_dax_region *cxlr_dax,
> +			   struct range *hpa_range)
> +{
> +	struct device *dev __free(put_device) =
> +		device_find_child(&cxlr_dax->dev, hpa_range, extent_check_overlap);
> +
> +	if (dev)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  /* Callers are expected to ensure cxled has been attached to a region */
>  int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
>  			  struct cxl_dc_extent *dc_extent)
>  {
> -	return 0;

...and here is the danger of predefining stub functions in one patch and
filling them in later. The validation of extents needed to be moved
earlier in the flow, closer to cxl_region_attach() time, and review of
dax_region_create_ext() identified it needed to be later in the flow.

Empty stubs like this run the risk of not having enough context to
justify when and where they are called.

> +	struct cxl_region *cxlr = cxled->cxld.region;
> +	struct range ext_dpa_range, ext_hpa_range;
> +	struct device *dev = &cxlr->dev;
> +	resource_size_t dpa_offset, hpa;
> +
> +	/*
> +	 * Interleave ways == 1 means this coresponds to a 1:1 mapping between
> +	 * device extents and DAX region extents.  Future implementations
> +	 * should hold DC region extents here until the full dax region extent
> +	 * can be realized.
> +	 */
> +	if (cxlr->params.interleave_ways != 1) {
> +		dev_err(dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	ext_dpa_range = (struct range) {
> +		.start = le64_to_cpu(dc_extent->start_dpa),
> +		.end = le64_to_cpu(dc_extent->start_dpa) +
> +			le64_to_cpu(dc_extent->length) - 1,
> +	};
> +
> +	dev_dbg(dev, "Adding DC extent DPA %#llx - %#llx\n",
> +		ext_dpa_range.start, ext_dpa_range.end);
> +
> +	/*
> +	 * Without interleave...
> +	 * HPA offset == DPA offset
> +	 * ... but do the math anyway

The full math would walk the extents of all targets in the
region_extent.

> +	 */
> +	dpa_offset = ext_dpa_range.start - cxled->dpa_res->start;
> +	hpa = cxled->cxld.hpa_range.start + dpa_offset;
> +
> +	ext_hpa_range = (struct range) {
> +		.start = hpa - cxlr->cxlr_dax->hpa_range.start,
> +		.end = ext_hpa_range.start + range_len(&ext_dpa_range) - 1,
> +	};
> +
> +	if (extent_overlaps(cxlr->cxlr_dax, &ext_hpa_range))
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "Realizing region extent at HPA %#llx - %#llx\n",
> +		ext_hpa_range.start, ext_hpa_range.end);
> +
> +	return dax_region_create_ext(cxlr->cxlr_dax, &ext_hpa_range,
> +				     (char *)dc_extent->tag,
> +				     &ext_dpa_range,
> +				     cxled);
>  }
>  
>  static int cxl_region_attach_position(struct cxl_region *cxlr,
> @@ -2684,6 +2754,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  
>  	dev = &cxlr_dax->dev;
>  	cxlr_dax->cxlr = cxlr;
> +	cxlr->cxlr_dax = cxlr_dax;
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
>  	device_set_pm_not_required(dev);
> @@ -2799,7 +2870,10 @@ static int cxl_region_read_extents(struct cxl_region *cxlr)
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> +	struct cxl_region *cxlr = cxlr_dax->cxlr;
>  
> +	cxlr->cxlr_dax = NULL;
> +	cxlr_dax->cxlr = NULL;
>  	device_unregister(&cxlr_dax->dev);
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d585f5fdd3ae..5379ad7f5852 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -564,6 +564,7 @@ struct cxl_region_params {
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> + * @cxlr_dax: (for DC regions) cached copy of CXL DAX bridge
>   * @flags: Region state flags
>   * @params: active + config params for the region
>   */
> @@ -574,6 +575,7 @@ struct cxl_region {
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_dax_region *cxlr_dax;
>  	unsigned long flags;
>  	struct cxl_region_params params;
>  };
> @@ -617,6 +619,41 @@ struct cxl_dax_region {
>  	struct range hpa_range;
>  };
>  
> +/**
> + * struct cxl_ed_extent - Extent within an endpoint decoder
> + * @dpa_range: DPA range this extent covers within the decoder
> + * @cxled: reference to the endpoint decoder
> + */
> +struct cxl_ed_extent {

Why is _ed_ in the name. It feels like 'struct cxl_extent' is the lowest
level "extent" type to worry about, and a 'struct cxl_region_extent is
an object that represents an interleave-set of extents in HPA space.

> +	struct range dpa_range;
> +	struct cxl_endpoint_decoder *cxled;
> +};
> +void cxl_release_ed_extent(struct cxl_ed_extent *extent);
> +
> +/**
> + * struct region_extent - CXL DAX region extent
> + * @dev: device representing this extent
> + * @hpa_range: HPA range of this extent
> + * @label: label of the extent
> + * @ed_ext: Endpoint decoder extent which backs this extent
> + */
> +#define DAX_EXTENT_LABEL_LEN 64
> +struct region_extent {
> +	struct device dev;
> +	struct range hpa_range;
> +	char label[DAX_EXTENT_LABEL_LEN];
> +	struct cxl_ed_extent ed_ext;

This should always be an array, even if interleaves > 1 are not
supported in this initial enabling it should be an x1 interleave array
from day 1.

> +};
> +
> +int dax_region_create_ext(struct cxl_dax_region *cxlr_dax,
> +			  struct range *hpa_range,
> +			  const char *label,
> +			  struct range *dpa_range,
> +			  struct cxl_endpoint_decoder *cxled);
> +
> +bool is_region_extent(struct device *dev);
> +#define to_region_extent(dev) container_of(dev, struct region_extent, dev)

All the other to_<object>() helpers do runtime object type-safety which
is why all the is_<object>() helpers exist.

Maybe a future patch needs these to be used outside the core, but seems
a premature export at this point.

