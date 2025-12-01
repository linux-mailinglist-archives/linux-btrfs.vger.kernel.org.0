Return-Path: <linux-btrfs+bounces-19439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4DC995F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 23:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3272D34637A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 22:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385E285045;
	Mon,  1 Dec 2025 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLxwgTH2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F1283C8E;
	Mon,  1 Dec 2025 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627522; cv=fail; b=mDGAHuBCwLd0/AHvaRWq7lzb6gVIKKGcG9uueB88U0hiMaeBO/aMko0R4wGv5Bqf0pNH3ionZqoyj5jW1Gkp6mqvASmI46TxPviqnGRKyxDHSAmYI6hDCUNBErZ+HXfxcSkFQY9BpjpBrBV6UsqaQRcs2GVuH5LwD0kOzVIGGPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627522; c=relaxed/simple;
	bh=rxEMsZTBgcN9Zg15kbFsQVqbUgCbr+do6IZBBfeoar8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nztgip6MNnGSl81X8i4tODiH3Pb9KbzX09+Lc5bFJpf3EtcQqTeirKEDFojyA38Oxf+p7fFJsFKr3vBCRQE3drrRFD2IggMBUAUMSYXoZutMGklLDxfoktIWVDwfQoXtqLJqP8miFGE20WWqzkUhULDWU45xUX1QjY4RXq1nY48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLxwgTH2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764627519; x=1796163519;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rxEMsZTBgcN9Zg15kbFsQVqbUgCbr+do6IZBBfeoar8=;
  b=eLxwgTH2DpxbNLLY2lmhmhCg1soUL7vad4gnFsI6232oHNdhUFnkX9kA
   aIuqS63M+zJl8Af99dc6qbdIZNEh7/+3yLfq3XEr1b7mX+aymn4LQ3NGf
   xhIlJZU4cDxhAclTpKtswdsA1AR7mNt6g6GwFkqAlFVXcHJesPePFikEz
   53A7oicQDpaOz/CuXVjG761eKuW5nzJ87hHVlPoKOHolCEdLXemIGOVX3
   YDi7+TRxynhBHZFRofjoN/YCIKAIfDV9colN4LAlY6MHayJza31Yf553P
   83m+O6j3gXiCwgsUX3OIVun4v7L0/QatVakoRBZQDDjJgjp32mJDaJtwM
   w==;
X-CSE-ConnectionGUID: h1HARX6KSQau4pEMssEs4g==
X-CSE-MsgGUID: Hl/RvKgGQBqIS+UiJNj1FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66658480"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="66658480"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 14:18:38 -0800
X-CSE-ConnectionGUID: y9Xp4CodR8CpbgkHs0oWPA==
X-CSE-MsgGUID: f3OES6ilRyWvbeiEHGTfRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="193866425"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 14:18:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 14:18:39 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 14:18:39 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 14:18:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7nlp58Zj41Y1h1hJcgXAXk9JU6cXGhjcWhQaMo3Imwo3ToMxuN/MzEGVkanWTgFTNtvtR3o/K4eob1KF2pjr6xI744yBzUqbT4G3kcidy9KK2bTlCUm2V/3OJc9QDdccEfOW2lA+fta7QL1gWpfyYfWvPgPNadT9e95xdMA4roJzWpSxCRsMQGowst1UMQBEVvftDd18dIcsweLLhlXESuOPYwV7FJXg+YGykzC0oyyblt2iED3GeokGqFmiUVA9XQfGHzeKGbRqFxem6hmiZYRI0QtdUQ64QKqiOJFWguKwmnD0baLywDntBfZWwi2SML8812eU4kI9Z65Y/YJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oZLCOYnbjba+AxbSgZHvO5Z23SZTBxFPXm1egnxliw=;
 b=oB8FAps90OJ+1a/dd8MzW5yLW/+QTMqfOYeKteItZSi6Wni3+FGW0DsXqRBAEi/OIc+N3EBU5WwXRcRZ4wn/vP+9oDMl6Foe/YOx//XnR3OSNrgHZYgu1FfrBoqr0Wh0eAM5CIz+dsUt7RAHN/O2uln/h9D7T+P8SBVh++GsL6ntCOAoqLwbKrJR9XXSiMorbN4Dhd+Me2YVSKLO7g+nAuG9wK5ZwIvTWvChPXtqj7zh7UkRgs7ohv+04VzDjQ6PqWKGevOWpk+IHmHEjg4oMkBoa4TIGKgb6FhmuPcZq/VZdZgFIXO1mJNIVnbN69WP8a5lQybO0GK62qETYat8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 22:18:34 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:18:34 +0000
Date: Mon, 1 Dec 2025 22:18:28 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: <dsterba@suse.com>, <herbert@gondor.apana.org.au>, Qu Wenruo
	<wqu@suse.com>, <clm@fb.com>, <terrelln@fb.com>,
	<linux-btrfs@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<qat-linux@intel.com>, <cyan@meta.com>, <brian.will@intel.com>,
	<weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Message-ID: <aS4UNIfxGK0y6HzO@gcabiddu-mobl.ger.corp.intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
 <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
 <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
 <453951a9-0c8d-4e1a-be4f-2617c6a51fbe@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <453951a9-0c8d-4e1a-be4f-2617c6a51fbe@gmx.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::35) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|PH7PR11MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8a6993-984b-4841-7d93-08de312790ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkUyamlWRWk5aTN1eHViZG1sRk5XSDhUUnlJU1FQYld0OWc5djRIRk9WMHJq?=
 =?utf-8?B?c0w3d1BrRnQ2OUp4TitmQkx1SmFwYnhwOVY5aTlIOFdhRi9SVHIrQlI0WC9Q?=
 =?utf-8?B?RzhTUlhlZEVPK0lZell0WFY3SjVTQStrZllicmZBbGw0N3ErUUV1K0dLVVJX?=
 =?utf-8?B?ZXdPbUhsSXNSR09WTUZVN2E5aXN6Q1NBYkh3eVdLYnhTOWg1UXFrQlAzQ283?=
 =?utf-8?B?NE1wd2dybW1MM1N3c1gyZllRT3RrWlJJeisxQzFaU2Q3UTNYc1pBYTY1T1JJ?=
 =?utf-8?B?eTRMa1UxM2ZQNERxS090QWdyM0IzVktub2RFc1Bkd0Z4ellSd29QOVpWK0kx?=
 =?utf-8?B?cUx4aEpORTB2WmZmM0J3dWVPZUxkeGlZTjczNVhMTjAyUUJNakwrRlM3VUdG?=
 =?utf-8?B?a0dveWQ2STYwRC9paTBUSTFaQTNaKy9EaGxMUTRVVDJTVHEvU1hoMTF3aEh0?=
 =?utf-8?B?dlBQcEwvR1ZKWjBLU25UTDByYmdRU3h4d011Ym5IdHI3Tlpxd25oT2h2RGV6?=
 =?utf-8?B?Z0JHTk1HQjdKRTg0ZWY3K01qWEVMQkVwN0MzMVFoN25OelFQZDM5UWZ3Qi9L?=
 =?utf-8?B?ZzNxb3lpKy9hRitPR3hPMlFaYlpnWjdtQVV2RkpHSkJGWitIT3dvVTB5OURl?=
 =?utf-8?B?cXJjTWFvSFlCUEhmRVZpNnB2U0FEU0g0UUFnKytLL3FTWnIyd1Rpdm15Z0sr?=
 =?utf-8?B?MzFKUGJObHRjbXE2VFFFSnVLS0JXdDhtREYrTmY1YkdTT1RGUnRoQjVKSVNm?=
 =?utf-8?B?VHVSclVQTENmRVhKWTM4YkNqMVJJVG5DcjNoUTJKWTZ6cm1VWUVEdWVPWkJW?=
 =?utf-8?B?WWdDNU85clFGMVYwcDlhK0ZQT2JxK2ZPZ0MveWpWSzVncnY0ZHhPS3VzeFVt?=
 =?utf-8?B?N1dBQ2l3cmxYRlZqNTl4eVplRWZVY3FHOXd4YXZzcmhrR3IwckIyVVk3VDJs?=
 =?utf-8?B?WGVpbHBwcG9URHdRY1NzOEFIRVF2VzJqSWJFV3J3bUlkSlJBd2tTNG9MWHhM?=
 =?utf-8?B?Tmx6ck4rRjhBT1RJMVBLL3BXWTk0ZWd0QTd4NDQ0em5PbUFuU01TQ0V2bTBO?=
 =?utf-8?B?cjR5TEthMjgzUjU1c0w1ZHJ6a2lKemlxaStyRFJMeVExeVIyaEd1SFFZZUNq?=
 =?utf-8?B?Z0lHK1NMTG9UNnhIbXpjWmlsOGFybml5Q2pGMGZIQnBOVndjc3pqOWJPamxY?=
 =?utf-8?B?dVU2SzZnbXhMN1RZMElDbVVvZGd0blRBbzBHNlljRUFUckZHY0NMaGsxWXFs?=
 =?utf-8?B?dGcvSjd2SUExTmYxaWk4NnBaUzNzalk3em43aVFYQVZDckhXeDhocjNOcVNN?=
 =?utf-8?B?YTlHR1lBbHdrYVpMUmJJdDN5RmVub3YrdFZWV0lNN1VnRVlhVFE2RWg1aDVB?=
 =?utf-8?B?WWpxK1c5UUYyd2loQXpoQXpxQ2FRQWRTRC9rVzRYaGZDaUQwWUU0ZzlpUHNp?=
 =?utf-8?B?cWcza3JCc3VNUGNoZnp0VGZ1ZDA2dWt5OTRvazBFQmIweGtHbWZoL0FTci9o?=
 =?utf-8?B?ZlpRdUhnejJwV0prTkhENXBKaWdvb0hkVUo1RUUxa0Rpb09SS3JLcXJ0TlIw?=
 =?utf-8?B?cGptOVl3WFYxcHU3akp3Ly9GQ1VqT1k5UE9NdHhOSzQ2MDZXd1Q3dTNVR3Rn?=
 =?utf-8?B?L00vazg2S09aeTJZZ0tURVdib3VFdlgxUUdlTWF4RHlOZjVLT3B4K09ndFZ1?=
 =?utf-8?B?NHVaQWJVT1JZczFPcE5QQnR5WGc2ano1Z2x3ZGEwa04wUXJJZm9vZ0pjVlJC?=
 =?utf-8?B?SnZ5L01BdmVNOU5BRzNENkpjdFpoQVpPM01MYkxkOTQxTGNzRGZmajk3LzFT?=
 =?utf-8?B?dFFmbXMyR2RDeExHZ2VvR1RYLzFXS2k2cTBNQ0h5RGlZdU43WGU0eHVCa1FO?=
 =?utf-8?B?Wjgwc05TdnhCbUdNMkNMK1pxcmtBM0haVFpXeUJ0SFhtVHlCOGdrYkZJcldu?=
 =?utf-8?Q?HqsEB/iMLpDPPv5gzQ7X42+hBfL0qYAQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVVWUXcyOU1laVRxeExGbnVGdlA3blZhSkNwRU15LzJwVmJuQm5JclVQMitq?=
 =?utf-8?B?UE9WOGVPcGlYRVhGcnBOb3RTZGdOa3hjUStkcXFrWktRU3k3L3E4WGRIUCt6?=
 =?utf-8?B?R0pvUTFZbmRBUWkxTndBb0k5NzJMRjltVjRPODh3TFVxQXkxSGlFVVZIUXQ0?=
 =?utf-8?B?QlVrTEFBWmRyditSV3F6QnpvU3JBUGRFNk9ZTDQwZnlqOElqMjNqQUY1Mk5N?=
 =?utf-8?B?bW12cHZOMTAvbUJNQlV0QTRmM1h2VjlQQjdJdyt1WEtvZUl2Nm1wWTd3a0hy?=
 =?utf-8?B?NVpnbXZ0NkhQL2crV3JadlFXb01oU0k1cGJYL2ZsYTlqSXlEeithc0cwMzdy?=
 =?utf-8?B?dU1udXVmS3JKRTM4TFdMYzd3YUpoeGk4RFZMVWRNNENzZ3ptdzI5OEtsYnJa?=
 =?utf-8?B?OW14MDZXOEJuOXhFeVFENGdDUXBhbHZ6ZVNjVHZTaHJZS3drL2ltRGJTaStm?=
 =?utf-8?B?dnd0RldOazh1ZjUwQ2V4ekpKWUNUUUNkMjYwMTJET0pKZ3dYK3c4bi9hVGlT?=
 =?utf-8?B?TzBNU2huSUhESWhVWVBaM2dkWXhjNnpvblhqRjBZWjVXODdOMFFPaUpNYzZv?=
 =?utf-8?B?amhNUmUwVE5zSkpwSkFpcnFOUENSc0dUVWRMeVdXSlhtMmluR1prZm4vVGRJ?=
 =?utf-8?B?R1RPd1NCWHpKbHJaTDY0ay8yQzJjSE1IQWhuKzhCVTFkKzBMaVBWWFVCRHRM?=
 =?utf-8?B?R1pmQXM2YXh1cS9VQXgvV3V5Vkg0MlhYUE10VGNJa0svTDZIcGdPSlorckNH?=
 =?utf-8?B?VFpuZXVzSXdXSVBGeXdBejh4SmRPNjBQcHYvN2Q1ZTQzOW1pNGxQcVczdzdq?=
 =?utf-8?B?bVN5VFRIUmFzSGRVbVVzVzE3U0FPUXZXY3g2MnN3enNWN25OcjEyT3ZudFpz?=
 =?utf-8?B?bzM3VytER0pKd1BYUUc4MmNTZDZyMExNa0RsenR2QkVPemQ5VitKWUFyTkw2?=
 =?utf-8?B?alE5ZTFFenVpSmZwRW03RmsrMlQ2cm5sN0xpblJTTUJVaE9iUS9DWjRVZVFO?=
 =?utf-8?B?bXNSRlpWZ294Y3kvcVlKdjVvNHVZWmRibStrcEtjWjliWXNpYXhnalh3d0M4?=
 =?utf-8?B?ME4yQ1pLNjR4Zkg3QzdXMy96RzFpMmJteHhzZHZPTE5qaWtaQkh2ckllQVZw?=
 =?utf-8?B?MzQvVGFjUWpDVTJtUmJMdTk4OFhPODFIZWZoSjVib2d5R2lrVzNMMVRscm1W?=
 =?utf-8?B?a0pxcWxqbmc0Umx2TTRscGVIM2F5YjBoQ2tHUXFjK012UEp1Rlh2aElDNEZq?=
 =?utf-8?B?SHdPaFlKdVRhNERTdzR3RytISDRXUkQrRVVMS1JNaUg3YldCVzQ2Wk0rVGdy?=
 =?utf-8?B?OTlORDh4NkdhM0VXRXlWVG9aMzZFWXhhMkZiMHFHK3pDRlJLQ3dzem5qNERK?=
 =?utf-8?B?V2NyZFYrMG5KRytQdFozZm1QWitJdVRqRUZRcFNXS3NkbDkvUUt6ZmVTaEpO?=
 =?utf-8?B?M2pGN2x5bzFpWnNReGNPdlZ5RmRtTlZ6SDJHckNBdzQraFhFdXk2L1ZFblRX?=
 =?utf-8?B?WGs3K2hxWnFYR09nTDhibElZR2Y5VTk4SlJnYlFOOUNQanJSQnVEYlhHU1BE?=
 =?utf-8?B?bkhTeWM5K1dRSVFKdFcrdWNWUGhHS0JJRUV3dTJMT0dTbGczZm1xVU51YjI3?=
 =?utf-8?B?UG9SV25sQzRFcm5lbkNTVFZVdmRGc3FGeVVQRW9ydHMzUXR2d2lvYTkwbmhy?=
 =?utf-8?B?YXZOR0kwTGVSN29YSzFTSzN4UEdPM05tY015Uyt0cSt3R3RXRXE3MUxpSXpy?=
 =?utf-8?B?RkpDNUtEMkg2ZTVuc2U2ZDAxb1hieUdvb3R5alJYeTZNaUhBdnN3SWgwbndn?=
 =?utf-8?B?ZVNvV2pQOEVtSDRGZ1Fzak12Z1UzTmtSMUpCcTR0MXkyd2phalpyT0IzU0NZ?=
 =?utf-8?B?a0ovY2toQVQvSUFmVXVtK3lDc09kaVRJV3Q2THdMWmF5c1BTUndXbFVYT0lC?=
 =?utf-8?B?VHlvUFFZaG1SaFh0dCthbFk4elZuL0JKcGdkT2QrWEJ4akVqdG5sKzNvUGNm?=
 =?utf-8?B?b0V4U1BtTm9ySW1UNTlGVGNTKzhhcHdmdkxjbFhMVkhoMEppalVmeVp5ejVm?=
 =?utf-8?B?NVdFUDZob2VGaXB5U3F6TFFlMzZORkFXS3BrTGs4UEVhZzFuSFNjcFYyY2Yz?=
 =?utf-8?B?WDYyVnFoRHVCL3JRNnhYMkN3ZjduYUU3em5udGlTWDE2WlExMHpNOXh4Vm80?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8a6993-984b-4841-7d93-08de312790ea
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 22:18:33.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w8yklzJcPcYh+AGz/M6Am7I5lxTHAzAS5r6fupcYePEiiOdazQtIrrulslzV/nC6olC1RMJODdNo/dadO5dz+L3URvqGyqjWJBZJAc6ihY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5820
X-OriginatorOrg: intel.com

On Tue, Dec 02, 2025 at 07:27:18AM +1030, Qu Wenruo wrote:
> 在 2025/12/2 01:40, Giovanni Cabiddu 写道:
> > On Mon, Dec 01, 2025 at 02:32:35PM +0000, Giovanni Cabiddu wrote:
> > > On Sat, Nov 29, 2025 at 10:53:02AM +1030, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > 在 2025/11/29 10:29, Qu Wenruo 写道:
> > > > > 
> > > > > 
> > > > > 在 2025/11/29 09:10, Giovanni Cabiddu 写道:
> > > > > > Thanks for your feedback, Qu Wenruo.
> > > > > > 
> > > > > > On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
> > > > > [...]
> > > > > > > Not an compression/crypto expert, thus just comment on the btrfs part.
> > > > > > > 
> > > > > > > sysfs is not a good long-term solution. Since it's already behind
> > > > > > > experiemental flags, you can just enable it unconditionally (with proper
> > > > > > > checks of-course).
> > > > > > The reason for introducing a sysfs attribute is to allow disabling the
> > > > > > feature to be able to unload the QAT driver or to assign a QAT device to
> > > > > > user space for example to QATlib or DPDK.
> > > > > > 
> > > > > > In the initial implementation, there was no sysfs switch because the
> > > > > > acomp tfm was allocated in the data path. With the current design,
> > > > > > where the tfm is allocated in the workspace, the driver remains
> > > > > > permanently in use.
> > > > > > 
> > > > > > Is there any other alternative to a sysfs attribute to dynamically
> > > > > > enable/disable this feature?
> > > > > 
> > > > > For all needed compression algorithm modules are loaded at btrfs module
> > > > > load time (not mount time), thus I was expecting the driver being there
> > > > > until the btrfs module is removed from kernel.
> > > > > 
> > > > > This is a completely new use case. Have no good idea on this at all.
> > > > > Never expected an accelerated algorithm would even get removed halfway.
> > > To clarify, the sysfs switch does not disable the algorithms themselves,
> > > it only controls whether acceleration of that algorithm is used, if
> > > supported.  If enabled, the filesystem can offload operations to the
> > > accelerator. If disabled, it performs them in software. The
> > > implementation also handles the case where acceleration is disabled or
> > > enabled while the filesystem is in use.
> > > 
> > > BTW, currently, the feature is disabled by default. If that is
> > > not preferable, we can enable it by default.
> > > 
> > > > Personally speaking, I'd prefer the acomp API/internals to handle those
> > > > hardware acceleration algorithms selection.
> > > > 
> > > > If every fs type utilizes this new accelerated path needs an interface to
> > > > disable QAT acceleration, it doesn't look sane that one has to toggle every
> > > > involved fs type to disable QAT acceleration.
> > > > 
> > > > Thus hiding the accelerated details behind common acomp API looks more sane.
> > > Even if we hide these details behind the acomp API, we would still face
> > > a similar issue with the current acomp algorithms. If we need to disable
> > > compression acceleration, for example, to assign a QAT device to user
> > > space, we would have to unmount the filesystem.
> > > 
> > > What's needed is an `acomp_alg` implementation that is independent of the
> > > QAT driver (or any specific accelerator) and can transparently fall back
> > > to software. We already have a software fallback in the QAT driver, but
> > > as explained, that does not prevent unloading the driver or re-purposing
> > > the device. @David and @Herbert, any thoughts?
> > Perhaps I should clarify the use case to remove ambiguity.
> > 
> > I added the `enable/disable` switch to allow disabling acceleration on
> > the QAT device so it can be reassigned to user space.  In the current
> > design, the acomp tfm is allocated in the workspace and persists for the
> > lifetime of the filesystem (unlike the previous preliminary version of
> > this series where the acomp tfm was allocated in the datapath).
> > This change was introduced after a review comment.
> > 
> > Here is what happens:
> > 1. The acomp tfm is allocated as part of the compression workspace.
> 
> Not an expert on crypto, but I guess acomp is not able to really dynamically
> queue the workload into different implementations, but has to determine it
> at workspace allocation time due to the differences in
> tfm/buffersize/scatter list size?
Correct. There isn't an intermediate layer that can enqueue to a
separate implementation. The enqueue to a separate implementation can be
done in a specific implementation. The QAT driver does that to implement
a fallback to software.

> This may be unrealistic, but is it even feasible to hide QAT behind generic
> acomp decompress/compress algorithm names.
> Then only queue the workload to QAT devices when it's available?
That is possible. It is possible to specify a generic algorithm name to
crypto_alloc_acomp() and the implementation that has the highest
priority will be selected.

> Just like that we have several different implementation for RAID6 and can
> select at module load time, but more dynamically in this case.
> 
> With runtime workload delivery, the removal of QAT device can be pretty
> generic and transparent. Just mark the QAT device unavailable for new
> workload, and wait for any existing workload to finish.
> 
> And this also makes btrfs part easier to implement, just add acomp interface
> support, no special handling for QAT and acomp will select the best
> implementation for us.
> 
> But for sure, this is just some wild idea from an uneducated non-crypto guy.

I'm trying to better understand the concern:

Is the issue that QAT specific details are leaking into BTRFS?
Or that we currently have two APIs performing similar functions being
called (acomp and the sw libs)?

If it is the first case, the only QAT-related details exposed are:

 * Offload threshold – This can be hidden inside the implementation of
   crypto_acomp_compress/decompress() in the QAT driver or exposed as a
   tfm attribute (that would be my preference), so we can decide early
   whether offloading makes sense without going throught the conversions
   between folios and scatterlists

 * QAT implementation names, i.e.:
       static const char *zlib_acomp_alg_name = "qat_zlib_deflate";
       static const char *zstd_acomp_alg_name = "qat_zstd";
   We can use the generic names instead. If the returned implementation is
   software, we simply ignore it. This way we will enable all the devices
   that implement the acomp API, not only QAT. However, the risk is testing.
   I won't be able to test such devices...

Beyond that, the BTRFS/acomp code can use a software backend without any
changes.

If the concern is about having two APIs, we could remove direct calls to
the software libraries and rely only on acomp. One option might be to
allocate two tfms in the workspace, one for software and one for the
accelerator, since the software names are stable and hardcoded, and
perform the switch.  However, the trend in the kernel nowadays is to
prefer direct calls to the libraries, rather than going through the
crypto layer.  That said, I still need a mechanism to indicate when the
accelerator should not be used. (BTW, I saw David's email confirming
that using sysfs for this is acceptable.)

Thanks,

-- 
Giovanni

