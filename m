Return-Path: <linux-btrfs+bounces-3974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6DC89A4CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535DD281890
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E74172BD4;
	Fri,  5 Apr 2024 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pt3wDKwF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE2172BBC;
	Fri,  5 Apr 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344925; cv=fail; b=p4rQ/qK1atFh1B05A7qAryvGa36a1j2ZMArtMWx7ZnGxxlDjYQPzybeuRZE+31vZbk+NUyfoLVsxwjkUlkMyDN+c48F/XVhlNGcDucqg9s+l7TTsxUb41qA+pDFT96DNn6M1IVNMssu3OXBOSZY+Nz4cinIJAmU0NKjBQTsqI9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344925; c=relaxed/simple;
	bh=w60E2KvL69p/VCa7lDtClePbZ2f/vnTTNF3/DvskwFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MpIYkXZSclfwmw/ji/DzaUA5TRqGxtLaQvwIdSSdkkvj53grYZ7ymxq8tdKqXvshECdX4UtuxrXmpQnyHghV1wELnk1R7+DO/1jMvbYFLZPZHWI/UCuuGp9XwLDCAszJAHuqTYsnJ1g9lCoFssANTmaeGE+J/gNwk6iGs1Q13Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pt3wDKwF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712344923; x=1743880923;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w60E2KvL69p/VCa7lDtClePbZ2f/vnTTNF3/DvskwFw=;
  b=Pt3wDKwFTXSbvjMsugGh4BoaykaMx11ckOh54N2s4Fn4JRW95rQj4gFf
   nonYbm11+O+oDOQbjctGnKOxqneDSvb+DNHn3XZ8VwsnGfYX9qgW8ec0f
   mrL463XU8cJnFSjM4M0+iVyXkHIM5MsM/T9UKwiC9fFOywmnQSRXV2yvp
   Lxisb0YgE9l141aU9pVK4ddVBlR0pep78aoic9HPaKWoRVTOHdvYJ5sK4
   W07h3KvDnrGk3aJThOVFzgcDtMqK5hKWZA7mqijCnC6/zvNnhvloTggpV
   Alv69jJM3IAN32f5OMRKfhw6FPuiDkH3vyY7GEQEnRN6jmseGw90Dv0fx
   Q==;
X-CSE-ConnectionGUID: rYPu8/NXQiGrGkSfs8yoNw==
X-CSE-MsgGUID: x/XbL7GzSLSNqPrA9GM9vA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7876790"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7876790"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:22:02 -0700
X-CSE-ConnectionGUID: usjlZnkYS+KzH8cCIbmpVw==
X-CSE-MsgGUID: ftHUg1G8RNWqW35uRtmgOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19104944"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 12:22:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 12:22:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 12:22:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 12:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXkE1gSN1aZmgMAJ7w+UcmPtDtrI+6+bpvqpFK0jVA2Tv3K/W6Tl+qjVQZkz3TkSC14xs7IxsOUDpirgLpsqH++fdhYDnvUthjJwAOnQ/TBsFs1MZMdjShBOcZXbN2IR5CGMr6wO/mE7IWZ3F1ofW1tuUJI3Ht0vYsv5Xe+2HiHlWj6fYFCc0ohCYNCRqfZHmaHU1qWUOr+Zg2DmZLIxW/f+NrLlwA97IJo4JyGBX8LqFw8OTcU2UXQ7IvjGxynKdaPNK9fuSlqY0KdyRNJLTydAMJCJXa4dmX0fvt83IbHsWFB7dSRYlfSOE7ZDv9PY4FH3WLnySR+MRfk7glSjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLGTrwXqnkSdsUq2WXB8c/Syb4+sw4+GaWfX2SsUPgM=;
 b=DfoL4srdMxtZ28uOdk15uoRZr+R4Ts7KTQm7W2PscDfGCvEVYa+ODdijXtHgsdim7kRYbq6n+sm1fjAb36HSIAUiz91rO/wkHxEyV7Ix/rQ6sWSLIeyR3IMDVAM8kuyThyeETY2OS3AI2Gve2UPFbPJ5gPnpn4MOOrWV4SJ5s06pbsSkXZQJDAHRPDGSgA+RNwyW/F4CbbFvo8hdIvZUQOTAit87VQK2POD2EtBilsrUf0Frb9p/lCW/gJiU/S2gwK+CslsEY+JF74y48eO9uiHa8vXadM8FoEkZtSwtDVXjVTwKIfmEv5zuggqwWR/paGxFSWCgmL5k1Vd9cw7s9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Fri, 5 Apr
 2024 19:21:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 19:21:59 +0000
Date: Fri, 5 Apr 2024 12:21:52 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Message-ID: <66104f505de74_e9f9f294f5@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
 <922007a0-3f85-4a40-80e4-5c906e6dd2c8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <922007a0-3f85-4a40-80e4-5c906e6dd2c8@intel.com>
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6117:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ye6CiUlUu6SJyC9Ti5BaICAAosVlExEWu8l4Q+PO/uA1R5cLPeaIR9aefTwLwF1vze4c0wPJ8JATlns58LbuQgmMJ5Z0mrP5MxxqzWdhGhyDS8pL6ALVaWTCTKsdO0Xb4eaPWXbP3ktJSQaQY/nDsP25WSDhZZibcOHeAskODKuS2bX3RjYjNNOYs4uPvhpsrd8lU0X9VKIFlxqXxveBpII4ubtKPrwBEjWMAIxU5AFyY9WOaVQnMFtb6ADgyYAtHeJeljumhleqivzxTA0KG9qKTULzHy71WVyXzlNEYfS1/QsXF4C+iFrB7s0GXs17r/CeMGklwj8Q7vmbv2a2t/gKsKPtSg7LwIAldvAitDhOExzvx91pyWvOJ4IlNIFmWc+bLdOzdMsSU+aQrdB6OXEZ4svHM3DGfXn++9pDIMFMBUrut38GolGkTLDYu0x9b43mJpE5CDh4jDt5DL2yEMYFmkVAL91mzAXNl5o5YznQslMZ02EJC7Fo9kCBuy7v3grs/R66ULuS2WGQWkkVzl4PcdS1weSj77HXaNmaQ9T4NzEXbOdmZisKJ3+w1vKtdxA4+u698tmFbDXGKNbQQLFIOQOPJNhja4CZ4m4U2l18CxmfSw4r0FXsNmqT+l2FQz3HbbPrd5LQ4QNPeLHSNhTlZ/zCcJ/Ieslgdtd6eOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mIqw6BE1XkcGnAv4is4K+QFejMl9nHLLA7+XoRl5UuBh+6oImNrzR6MhYsiq?=
 =?us-ascii?Q?px8TzJm11qU698oXaJp4HeEc/m/FNlNpKXPSl6ngknO9kLMYDPsyaWh82PlD?=
 =?us-ascii?Q?L4SxheOS6UW14OHWrSCd69buk5iE0HJIcgPVxnohopidFxfXSzGgYTc+DB2J?=
 =?us-ascii?Q?RlPxBark/+tFz5e2Ua5Ci9OWBJA8+kV6scDiOAHSN/OidTc7AFbZvcRRzwhu?=
 =?us-ascii?Q?nPRQTGIavVum7xS6gnTd93a5VGhN0eqSSxwlWripLznBa5AvRXY9uoXHI/sR?=
 =?us-ascii?Q?NL66XP0SkpXx0birgwkuXIAQ1wEsSvJAb0Kshy8hQpp180iwEAop8d8uQRhk?=
 =?us-ascii?Q?B9rsiYtpncRWyIYn31GD5jRkOdPYDdLowDgeLBrpOzdCGKIbPHQ0ZNEzjPeW?=
 =?us-ascii?Q?sjXbihv3a8zVNQtLBsLqD0OIXG6xPklYhzyFA2JO+1symyWLNWH85FCjif5m?=
 =?us-ascii?Q?i2gAvrKGDtcGLpAcFp9yWo2VYOBmsCfufzjZFy4ucPhgIQ56mrXDoADVlFLR?=
 =?us-ascii?Q?ow7k/DhMko+HYQRIL5cRNU6Hu1gXEIYkP7jIjfp3xIfxKUMlhPa6xU1NlCR2?=
 =?us-ascii?Q?vrBpEPQc5Nusau5QMTY+kLkyYmtClZMl5c+v3yfZOCY9plD4Fzgg0Ox2UyMD?=
 =?us-ascii?Q?Jw42j+dvwvAYc/RazQ1BdIvJby4EtHEDSoaI9OqJnCA100P9RdcGlA/hL4Vi?=
 =?us-ascii?Q?TdlJrhmQnMft0mlmqSTBHrDJYPBdLtbuptMjVb245Qt+ikSgR5VEvUbJFwZZ?=
 =?us-ascii?Q?0erRGLcNfXNK+dxTg05Msic2+UbAl7c34eOxeitQ7EyJ8B0FT8LqNmmVLXUC?=
 =?us-ascii?Q?mu7HHWw02fcPf6U03o16Ivnbc5PFOQN/qCmfeRe7f+nYfFnwIHUEmtSd+5Dz?=
 =?us-ascii?Q?VpyOsyN+XYIgUjCg4uYmXwkk/afsrCW5lB/UfPQTc3ep7og7bU5T0GHyb0LH?=
 =?us-ascii?Q?104EDFlolGQnJMTlZkrqXPVKjrFGFm6kbo0gyDCBH8cSlnSBSA6W0eqHzzL8?=
 =?us-ascii?Q?onc03btL9UHCg7RrYOGlaCHM82G4dkyPRttJL/Pb5/bq/LE7YoyZC+0lMD7Y?=
 =?us-ascii?Q?twblE2FGG2ffmzY/9lCSz2BWsBuhmHgLkWNMH7Cr2y1EuSe8+05TOCB4wVgr?=
 =?us-ascii?Q?LZYHzXHJfx50AOsa/SrTeBsmNZG0bYm7KnoeXiC+bB9wRsbW3AQVAk59gKfB?=
 =?us-ascii?Q?ytCm3OX+da9JkSCsOYTlUh/DzDpzy64KCphhX6szLy65CmoI1vIqYeWFoWws?=
 =?us-ascii?Q?PxtrVW97DOc4cUPOkL0jzZnpPYFkMtUsDfEHwMVNr1CfozJdLj6BdCdCOrp/?=
 =?us-ascii?Q?QwkiaQipl/w2CoCFKEF4OccdIW/IhNGHO1wHqsZRo4CNa7NCpFHK2VW4s/RE?=
 =?us-ascii?Q?MWOITesiJCsjz1DIDlrnZql9qfMlAOoPl/gIVYILW2OMFLtJYsuouVO3z8lm?=
 =?us-ascii?Q?E/8qLax8mzZTkyC0yHi2FwKUa5QVcAIq8LPcvfQwTnULuJW/nHz764HtCY4J?=
 =?us-ascii?Q?ir1IWfttoaTOAOZ8tzWJTy1kE81xTBr+daTqyiON/XkgKlrEGhJXeT4F3wYU?=
 =?us-ascii?Q?TZEzsfFYCdkEL1jJG2oNRXm5S/zn7y8JlyIRMVvV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5655a0f3-8ffe-4b06-c0f3-08dc55a5aa62
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 19:21:59.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBmNYwbzq7p7gTUySICF3NPLOBYt+dSfbqVtx3FzjVUPCv+Yi4LVvS83kHO9Y/O+2Q9Wpi8/zjxN3Eh8gqYHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/24/24 4:18 PM, Ira Weiny wrote:
> > cxl_dpa_set_mode() checks the mode for validity two times, once outside
> > of the DPA RW semaphore and again within.  The function is not in a
> > critical path.  Prior to Dynamic Capacity the extra check was not much
> > of an issue.  The addition of DC modes increases the complexity of
> > the check.
> > 
> > Simplify the mode check before adding the more complex DC modes.
> 
> I would augment this by saying simplify "by using scope-based resource menagement".

However, using the guard cleanup is not really the simplification here.  It is
more about checking the mode a single time.

That said I will change this to:

Simplify the mode check and convert to use of a cleanup guard.

Ira

