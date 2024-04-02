Return-Path: <linux-btrfs+bounces-3842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E37895F8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996851F21DB0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE51EA7D;
	Tue,  2 Apr 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlrA+GRp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A3A41;
	Tue,  2 Apr 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097032; cv=fail; b=SyIsgGvfsLu7Xujm+lO14I7+48O5WsMOTeWKDZT6n7L27IbhyHBz8axN4ycf7iUIivzzbx3/CX432N9GV4/QBnqeMupZSGKmvKzGFtWyXXRm1CaSGYvj/8e9MzW0mcEQ5QJEYsOmVH/8V2rulFMJbTNlCbpacfYhK0RyvGeVKAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097032; c=relaxed/simple;
	bh=X9iUHXyPeVsNQhyOaScfnDy93GduOewUnLLm1Lz85dc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EhE0vYVeM9M7oDVjGnhkD4I0zoaNm7cQkqIpJZU+K0dE6LzgpykSBorRwmfkaKxVzmQrUZgqphi5427MbvrlZ1gJVL9F66j7y4GZ8LRAELyfwkPVdOErbJjmycgJLOg6JdU6v+Fp1xPIdLLcXvpEirstooj0QD38UIB62o/lucQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlrA+GRp; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712097031; x=1743633031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X9iUHXyPeVsNQhyOaScfnDy93GduOewUnLLm1Lz85dc=;
  b=hlrA+GRpgWkr/SJ0NVnacSpdSLoLQ5ukEc1oSzcHzjKV4gNEVLN2hAnG
   V4c2Vug9n4Cl+Cs5BR2EHSee2R3X+2CcC6rVyqjvdmocyebVzsFmu37dx
   QSlPjDFbnBHR5heP2igy3HzVn34Yw+sORRfv+51Z3v6S0T7inVrMfnCBN
   if2FiXClzZJuzV6v/SgKwtt6kN84uXyGjHO6UxWpjJyoIm6gkqHhft5f7
   yKIVeLyY2mXy0Jxf22njvZHdElImJon21fg/XA/aIw4qF4O+quETaib6c
   mDfc9O4X5hPKurIWJo4QJrL0Wke82iNvI/mRpp2z4M52ZgU/F1Nty/Gm6
   w==;
X-CSE-ConnectionGUID: lDS0VMRZREWolQV6M0NE1A==
X-CSE-MsgGUID: 4lDHmvigTXG+qcaIhkvWHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="29777837"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="29777837"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 15:30:30 -0700
X-CSE-ConnectionGUID: S6bMiFitSMaR4a9nW5wgtw==
X-CSE-MsgGUID: cg2J/4eMQRW+XCNSvQVUDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22975751"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 15:30:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 15:30:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 15:30:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 15:30:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOso+zErM9f9Rj+OPTUcKd1nc0sn14XBerBuYoFeidgo+j1a/Qn0NZx/MXwAWxcvr0zZ3f3tK1UnlAlkbkFra70ujOYojTdwlY0DUQHEJSCuELCRz2zE5po7qEBHwOmIwxHw47INSJqgRuZPDGodUQSkHsJC3qL41QoSsgTDnlRusGd7gnwzYaB14SIIXX5pkEpt82LPrxpFyqcaY8324WytJxSyAAzP3eN9yzFXAAncbXAehg6y92BSFT+woYvLy50yXSuPMLPe/NVfMm10VJRQOPq9uhJoZDu0gb85vTjddPEaU5aOaP7k2MYi452K0qYE3CvYiBE3aGMHLE+aDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rytsOHxWaRJCUOdmsWNPJqqVrBpp7KVwNNR7CJU8ic0=;
 b=Fn1inUJoTGT8Cm/Ik+idpOyc9pZZTj5h4Me1wmFCMkdHMOf1PYkCxqHP+/io/TuSYEKi4inD3yPM82F363AWIju99EBhqe/vdsreC/g799Ks8ORuKe9RKPSjbGIjDxdvotXCyQivRH5LWSQwGD9PU5Tf705G9dAkMxUda6MIdBiUq9fQcfVoVlNUfcynSGcmLKFRsRZqW34wZMsWxl3L5s4GD/MROvcJkNz8WnKLqdrjAQBjpPPTIMrAAtrvcVCgiWmlD2Me4ouRzTSck1bOuXv+5lk630Iu8d9rc3/qOMd3rzHM+766CTC/a3BsN+WtkmTJi5mDCrlXre0NQiVOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB7591.namprd11.prod.outlook.com (2603:10b6:806:32b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 22:30:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 22:30:26 +0000
Date: Tue, 2 Apr 2024 15:30:22 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/26] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <660c86fed6918_8a7d0294fe@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
 <d3bcac81-35ee-4876-8f2c-6c66a7fdd960@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d3bcac81-35ee-4876-8f2c-6c66a7fdd960@intel.com>
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB7591:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJvIgnWO6IN+nCVRsObz/6tBAUzO+TJSOnkk85tYg7enBzCUiSP7dJD98QF3Ai4zJaFdmN9sKMslPVPDRNCQSVb1rCDrCgBi144F0wZ7lqDkhBDdoxVvR9xI5cyDUezNyawJHTcQWaMv6+rJIWdkzkJaPRguOx0igVcw/7/WInjvPB/f0TsntnJk1gYDTlLxppC7sAfZvxbuRfs8il8eobiIE/NhmvPQ7TdP5ZViG7UDsBEJHr7jGTZvmvOXzP/Cl2DN5plG0JRjWOucpV3aBJJM0bgBRMevFHMVCD2ogGwIfBMGp57OEqhZNi+L6mML31Q3iEhdf2cgUiC93fn00Uus62fKFewK06AZ6w08j+UGkZobhXbnvJujycDTARUUx9jtRfwT7nHcOvRVL3aw5ppkhIAxxjVdjStKlrSRHfXoXRyBlRakOjaQVkoNizIb3IpSdWfxdXY/wm0ecT0aflLE2pOIKSMQLnyWyQS14oajfbytqDakx/5/o9NmOgKEgCZtICea/R6CILzqEYZ8oKRJaQYwCnlcvtaP89gKVdxSFpW3zbx3GuyX3Z1m4pIngbzzgxbMrRSlpyOiccHAwPO1lY8E2EEFtAj1ee+weSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zabQp+StPFjTLYXKU9l2j3I5LzmQJ1bkzZYUKiAxfzJ+0eoJjv/z8h9/APJ6?=
 =?us-ascii?Q?L4yacHSyoQuqtP661rr7fJvZZkxmJs9l0xy6sEz4cek+aZ3F1rMg1KXVwsy7?=
 =?us-ascii?Q?7Oow+QL5DUb+kLqXqft1Kcakg53P7F4h7Jl2bFZdFYjRBfAmfamWS055/emB?=
 =?us-ascii?Q?V+xBvanEN9JWfqUuZPLk0xrkPAzLJrO0/8OxKeA8IiUaKCWhuuwMRnvE2Pad?=
 =?us-ascii?Q?EX0PirG57gJdBBYaA9c1DH/WhiRXRRMxmOAAvJfnoXsqsOGSmSWErfy7I4vN?=
 =?us-ascii?Q?8wDEqXSzC7kPIybFGqZOgNPw5IHAXkaCXYQi9rrpgmT6u+tcTPZ3LsPEotum?=
 =?us-ascii?Q?KxkxzWKOiHGKuMwCRu9kBQKjkbUPDj1QBkY6sH+urBn42IpzLO4GjdRuBVP0?=
 =?us-ascii?Q?KGOTiTRhWFFtBJvckhBgQkdlB1eaHwWf+WTWfl9tl6unmI77qziCBT7csRpa?=
 =?us-ascii?Q?1VafbbwNL8oSroe5duXPCJQbPWZdAXfi2aZHCNUK5DJ64LkXLp87iASA//3k?=
 =?us-ascii?Q?zfU30HUsQtxuGzf4p9FXlVmzy5xTnqexuqeX8vs4Yy2xcYJniA6AtqFdegh0?=
 =?us-ascii?Q?5FJ41B7Lt1kO/iFIl8bUR/gt09PX/LPLGu92nnCfvVI/DZy+lCFZ6F3LtWIy?=
 =?us-ascii?Q?PtVAEn3gRVWKmcTnPUtdojijk0B2AJhkfClmksFQwxu9WGL1WbSV5pR92vzu?=
 =?us-ascii?Q?6WLt07hMfmgOKinIGJvn3fiYlpKM1u4GhQHeNAcCVXqPuq1t3+Wts+UVPKoq?=
 =?us-ascii?Q?XuYZAjwgiR2agj9f4mvDfaL5wzx8XMjG+No3itkZM4DxGUBlURZ/lomskljU?=
 =?us-ascii?Q?KyimHy7qALlW/lWHg7uOUsv5BW/VJ8gQRmBUe8BJQIVnRWuT4pve3wFt5VX3?=
 =?us-ascii?Q?abeSdM8YDHAPXiFVVY0hjVPZavhTwelWqei06/vu5hr6etBV5QCkizFMZ54r?=
 =?us-ascii?Q?bJYHlct4Np7x9shWT3t8rawZI6rGC8A2blPaGTV0zGB7Xwgnldb/a/p84HfK?=
 =?us-ascii?Q?QZZi5vJoXzJ0ClO/uDXldcxGbFoj/9IjYi3a9vwFGsz5m1kkyhrGIvFkPFJu?=
 =?us-ascii?Q?WRCejlkwW3z8qakLFwQs4pG/+99fWKdqQvRCMrGHWysDN4onInsnqoCS/U9i?=
 =?us-ascii?Q?eD+/vALQDlt/L1xUp31hvAoiuZpYdHNWgT3NjNOPGd+5BsyAKhwXGKanKYYM?=
 =?us-ascii?Q?3ydPOw2atT4GuAO9WxCe2IJKYDnPfN3pH26sXeRcUxKCfOiNsJNHAuKRmgY0?=
 =?us-ascii?Q?n/cQSQlHbYzQL/J0HrhIAAhNt5cioNSm7lxP8GHkFV9OCC63dblhES6cYrgo?=
 =?us-ascii?Q?FcVRCoKwwq1hNJVP6PYtWkb0NERNBqB8BK087xhWkhrZ1P35bxeGLWN3+wxV?=
 =?us-ascii?Q?dx04mIXwkrtgcTWM4TYBUrZ/94HYUqNwnQn1U4dqzqzSq8ghK4k0sspbbbqa?=
 =?us-ascii?Q?gc0aog1ivYBxyeOSyUV0Vy/b4r6GwTYygtn3UnWu6PiiiVBUKmvVuEdPFATH?=
 =?us-ascii?Q?S8sa8SzEv9ZvG87lKN7f6XOzSTXw7cK8MqBldyrhqvcAbRRIGWU034qR3ppB?=
 =?us-ascii?Q?1dLHxb38JqFp1TRjpOx5VbZ1aAbIe12lwSB3zLPL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1556c53d-d7d8-4cba-65f7-08dc53647e3b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:30:26.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBmj4OXk4f47SWxxkxqIFWlJ4sU29xDV0hqkD1UE8UWUP5XyUJDhiJntapj8zN5dRtxMpLDB5qsrOnou/O63vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7591
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Per the CXL 3.1 specification software must check the Command Effects
> > Log (CEL) to know if a device supports dynamic capacity (DC).  If the
> > device does support DC the specifics of the DC Regions (0-7) are read
> > through the mailbox.
> > 
> > Flag DC Device (DCD) commands in a device if they are supported.
> > Subsequent patches will key off these bits to configure DCD.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> small formatting nit below
> 
> > ---
> > Changes for v1
> > [iweiny: update to latest master]
> > [iweiny: update commit message]
> > [iweiny: Based on the fix:
> > 	https://lore.kernel.org/all/20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com/
> > [jonathan: remove unneeded format change]
> > [jonathan: don't split security code in mbox.c]
> > ---
> >  drivers/cxl/core/mbox.c | 33 +++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 15 +++++++++++++++
> >  2 files changed, 48 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 9adda4795eb7..ed4131c6f50b 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -161,6 +161,34 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
> >  	}
> >  }
> >  
> > +static bool cxl_is_dcd_command(u16 opcode)
> > +{
> > +#define CXL_MBOX_OP_DCD_CMDS 0x48
> > +
> > +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> > +}
> > +
> > +static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
> > +					u16 opcode)
> 
> This seems misaligned.

Fixed,
Ira

