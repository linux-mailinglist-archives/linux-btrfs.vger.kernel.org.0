Return-Path: <linux-btrfs+bounces-19437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C33C97FB3
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BCFE4E24BA
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE5031CA4E;
	Mon,  1 Dec 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKEzT2jg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EB244663;
	Mon,  1 Dec 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601847; cv=fail; b=Ycswl2hgH+x/ukM1co6L1tAvgebb+Y+SxMJrxiY1CoLLKF06E1So5n86EmlTP0Kw2OzzQ63ENu4pO7EVzIbKvsID3+R/znkRpYwrZp8s8rfhq6hKeXGa0z/IlbMt1LLcm0a/DYOcX31QkmZzjgXfDRKyYnpMBbd46It0hY8jSnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601847; c=relaxed/simple;
	bh=o1VrXapgl0kiDDiq3xzdEuQ5hjX6X2DGa7BsQnPCMYQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kwDn2DCTNoKhAHV6Hz3wkls00RwGsMIXZ8CN2RHm1AWMx5qOtG8t2YC3/VcKTVEzLJOPodVF9RzFpWAD1QcMDB07GKJco9K+bUpWDm6Xw/jGzS2zL4n73VnqLkfVgHXxlynTSWtIk5KJuVPyY3hozDseABaSjxs+OYYIm/sZnkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKEzT2jg; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764601845; x=1796137845;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o1VrXapgl0kiDDiq3xzdEuQ5hjX6X2DGa7BsQnPCMYQ=;
  b=VKEzT2jgCjatwh3RyLAZOA3Gds7/nBagI48wMqWclcERwdQ+COVgbZDO
   xKUp+DEJovIbw57TC4VVnrwTQhtanWTSg++N4mujCb688cvAggevSSeuc
   +j48Klc77F3MhqNXGceC8m0nWoLkeNSdpBps2/v0qiqizDy+v1YMDYZeI
   dnptcHVADwCarEFGrNBYD74SWwIJBrdcOMKn6rbPBkuwiWabJ1Irlwy7f
   kfAcwgcxzb2YiIdDVbgzAXfewOlpEMP4brz5FYmnM7DNfxdLSnA6cEFHA
   wQV8ECtk7FRdBsf0iTQrrDmr+EYZBuJXK/u+H6/UmTJiAx9KJppX6IdSe
   g==;
X-CSE-ConnectionGUID: 3f+S7DKqTs2pqWH+ha2pIw==
X-CSE-MsgGUID: Iw14lwpVQve6H1Ld3JGnHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66493055"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="66493055"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 07:10:45 -0800
X-CSE-ConnectionGUID: w0W2W4MWSxmXRze5JNHhjg==
X-CSE-MsgGUID: WKIHRVBkRpCMUNA3uB7o9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194196688"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 07:10:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 07:10:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 07:10:44 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 07:10:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOyfyxzwlpCpvQdzC/rd1VGXt4Nts9frXMnK6U/KmZ/QCOvXi763LYM7frCnV9YDHs9xxm4L+jBh7HZJFxeXN/vXt9TWKFXjQvEqQXNUrpL6VUqvcVk4BjXp9g8g3tNXLpyaZtdvnDekpf67DJzZlUFi8H/lbWZPlaBAwpLF4Vw6POaVVLOvV/1xJqmVsNaZfQm/f621TjmbkncrJ6KG2Qwx3yXcYEdNohJE0zdIfXRFEJ9cVZDcnjHn3VQ/gxyn59d/VQLOpyYp6krbAdD/ASAl5SWb+TwdvH8cIOztCVIGK9sWYFPU+Wkjvvvy/Q/bIVUzvFxaDdmjMwDBz1eTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2n+jgPXIr3iPa4K7YHzoZF900OX2uxtA927sMn+Irc=;
 b=xbXenp1y7fNfqYFZMUs2+31TpjD/jlHIQmQ5mFjm1KeqT7mIvHgStiYYafBFZHPWkLryNN5RHr+gY6SFjx0uYlnBeiS577F/PnIedGNwrpHMCeZmcuYZ/Br7W3z7YwkTZtxCkEwG4sYxByzxcDvpag+QMCB07agsriEXlIP4jlPeoIXYFLNCf2afnbZCk3LJxyiOevFk7BGy8RZWXSGSEdYx+2lI3wFsjDKGRi7zO7/qCVQNjxgAH8pQR/NJJuw4g44uYqUUVG5j0/SfjhBnBIFWedhWfD6/AWUbqSOF50F9jetc+g5Ha4mHeRYS5Nrq/z/j/glRfWLoQArvyrD1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:10:40 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 15:10:39 +0000
Date: Mon, 1 Dec 2025 15:10:34 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, <dsterba@suse.com>,
	<herbert@gondor.apana.org.au>
CC: Qu Wenruo <wqu@suse.com>, <clm@fb.com>, <terrelln@fb.com>,
	<linux-btrfs@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<qat-linux@intel.com>, <cyan@meta.com>, <brian.will@intel.com>,
	<weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Message-ID: <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
 <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0237.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::20) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|PH8PR11MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 836aba91-ae51-464d-b58d-08de30ebc9f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V29mQUtaTFpPZHc0SktLV0s2djVzU3prUjRwS2UycEtxazJNZzNUQWx0MnIx?=
 =?utf-8?B?OG1IL0NhbVBlS0crNnFQSTdXRmJiY1VFNDBTK21YREdLOWxTMFRFRXhMdWw5?=
 =?utf-8?B?QVEzQ1d5K3NoM25kS2hsYk5Fdm5mZUczVzU2MmhjRVk1czdCTGJFYW5lVmZU?=
 =?utf-8?B?M29XdWRoeHpTYWQ3anBCRnhoYmRNNjRqQ0p3SGExVEsvbXUrblZzTGYzSUNw?=
 =?utf-8?B?NUVsd25WcWhwcWJ5bHRKZUFGek9KcFRxV1RIQ3h0alBwL2FJVExwUTNnVlBa?=
 =?utf-8?B?dGxwYytiT0JrcmNmTmMydGx6NXRZZU9QQlNQa1Q3NVVFeldqQW9ka1kwQjAv?=
 =?utf-8?B?dExXTjlDaUVrdlhGa3Z4TU1LQ05pN0d1Ti9IVFg4Tm9ucnJaczVOZ3dWQXF6?=
 =?utf-8?B?S0YreWt6U241TUM2dm5BN0tFS0gyeXpZb0RpWWRhVDBieUs0clMrWUdMYTc5?=
 =?utf-8?B?N3pxcUdlVEwvWWhGZmozM05nblhyMEMvSXk1Z1Fvakl6V05aSklnYUM1NWpi?=
 =?utf-8?B?eDMwQVUzdlhRNHk1SXBFUDZYa3hOcnAvWWx1UjBGRXo2akRoTnlHY3dyemVr?=
 =?utf-8?B?aUt1VjI0MW1ibUhzZmZhUnBlQS9TeCs1aGxiYkV4TXpvZGlGblhRRE5GZkhp?=
 =?utf-8?B?VWxUVlpsTDBxSEZoUmZPMkpCV3BpdTBrejFBN2NsZ2hvTHdKd3BRWDQ4TXpT?=
 =?utf-8?B?ZGhpblYwRkxUUnIrLzJuMWZIMk02MXlwTXJPbDlvbGZCL3dOV2oyckg1Rmp6?=
 =?utf-8?B?SXRzeFJoS3dUZmp4TW5JTWt6U0dTVHNFMVd0ZXB4OXAxU0lUYmdDWGh6b3Zr?=
 =?utf-8?B?elFXY1ByU2NnTFpkYy9EZWRXVTBjYWpacVRrYmd0OGFXWVg5VjNmVU9scy9D?=
 =?utf-8?B?U3YrbkRQcTIzMHRteENHSnFLK2NyVTRUSUc5RVZEb3RoZlY0eXlPTGRySWxo?=
 =?utf-8?B?TnB6NVZWMkl5M2dnUnN1MEtxOHV4QW5UOUpHSjFWM2pyMVNUUWJuTnlXd3Zt?=
 =?utf-8?B?RUdNOE1qWEhZOHB5MGt4UDhZeGUwUlFTM0YvVklXYW8yTnRDWnYyQXhuSzUw?=
 =?utf-8?B?ZGNpWVIxdGFDODA2Vmg0UXQ4K3pERXpHRUhrZzk0M0Zvc25rTHpPZFp5bXJn?=
 =?utf-8?B?bUJjcjN2aklRQTY3dWZ3dmJTblNmSW1YVEpjUnY1NEZ4WWRSSzNDRWRjaTdt?=
 =?utf-8?B?RFUxYWdyK3plbUlvRCtZYzZpRXltSVFpZktKNDRKM2hLeWliTHpMaWpOdGhT?=
 =?utf-8?B?dk1sMlZaZ0lSS0RPZ1NTaVdoaEpSSHdLWmtNUExMY3RqZDgxbHQyZkFTUU4w?=
 =?utf-8?B?VU1jVTl4NnlhSHZXV0J4dUJKa2dKdngweXhrdEx0cjRxT0xzbkY4bnNhNVMv?=
 =?utf-8?B?VzRGemxxcjAxbGFzKzNLdEhTU2NYUEJxRW9UaHlQME1abkl2QUFoMVpKN0VV?=
 =?utf-8?B?VStXMngvSjI5NWZ4RmZ1MXNiZnRTbS9ubUpzTlJYeTdic04zd1FwdlRISWJZ?=
 =?utf-8?B?ZUtmOHVOSlk5Tzc4WkpQL3hHOEE5V0xQV3lIek9wR2dSc1VaUzI4QWVQV2Ny?=
 =?utf-8?B?UGhxRWsrOXY2OWcxYVJ6MER2czdITDB4UXhCTUZ3d2NqcW5BYkIveEJveWJ6?=
 =?utf-8?B?a21kNGR4bUdWWlQ1bER2aHRTVXF3cVFlTXNLc0tRVk1zK3Yxd3NYSExZL0lE?=
 =?utf-8?B?bWhaRGNqNkk3c3JOb0pPd1ZVTE5CS21jUEZUUHRVRVBiVUZaWFFQOEVaVkFX?=
 =?utf-8?B?YWpYZjhzWjFKU0hUdiszOWZqVGpra2RuTFRreUtDZEtmdU93TTR5RnNBTFNo?=
 =?utf-8?B?U0tnT2VtTWwwWTlKb3FPaStMK010RzcxbE1jNnJRWVJCUHJidHdPSGRwWkNV?=
 =?utf-8?B?L2N2Q1BNRUkvMWFNS0IxVGZuRDJPNHNyUVlpVUxiMFNIZVp4M2dYVk53WlZl?=
 =?utf-8?Q?vPH3gFNqKvehLvLbv8aDkQWfu54h7NfH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d09PNll2bXlwcHBMTmw1dmVIR3BJNlkwR0NBNkI0UEd1cmtaZjRwR2pYOFhh?=
 =?utf-8?B?NjloL2JCR2JHTXdnK1VXS3FiNFdxR0RZY2ZKeGU2ZTVTT0swaDV6emxhU2hL?=
 =?utf-8?B?bndaZkVYc1oxSGJDSlEwMHZkaHNkdHVaWForY3ZqVWZWa2lnaGYya2xQcldB?=
 =?utf-8?B?Nm9HdXBJdmxmaDd2ZGloT1F1d0gra0tTRHZkREtNRUU5Yzh4ekFuUWI5RW9E?=
 =?utf-8?B?QW9XZ1lRTFJDMHNsODNGa213SnZkZUhDL2NVTHNHWUp3Q20zb25aTzA5THhl?=
 =?utf-8?B?dmtnc0hGMkRtTk1jRnBtOHlCTGVmdS9EN3d0QkdveEUvb3QvMmlHTHZUOWl1?=
 =?utf-8?B?SWlCczVLU0Nxd3dPWnRxV0VCNDFNVmxjSDJYTTVXcTYzYkhwVXNvT2lYK0lB?=
 =?utf-8?B?ZmtCMWx2V1VvSmI0Zy9tekFQR1hlbWgzMm01SlN1VDFEY2lhMGxRbmczakdX?=
 =?utf-8?B?eFNzVHZlOUhrQkJDYkU2U1VtNExoTlVhVVpMS3A3VTNDTEVtZlFjNW15Mkli?=
 =?utf-8?B?ZWF5cWl6aE12VEJ2c0FxRTdtT2cxRDNhdTdhaElKY3FIVHpPdWlTT3oyZURG?=
 =?utf-8?B?ZlVIM1NRVHcyVE1ydXkzME5KZkZtK3VRb09wV2pYdDhHUHhRUDBnR3hWR0Ux?=
 =?utf-8?B?U0ZwN2lDTlVXRTVTUHRVOHMxOG9xUWltU21wRi9VR1hPWjkveVlGNmJ3VUo4?=
 =?utf-8?B?cldMdFZZeWg1TmNvY0hGbk1UdzFNbFdNSFd6V09HTDQySC9yVmdhU3p1YnRs?=
 =?utf-8?B?SG9LRkpvMWtuSHpzb0FUVFpnbEJqSm92WUhmcXJrNUpOdHY2QWszSXowMWox?=
 =?utf-8?B?Qmw2Z1ZkeGxwOFpscjlFK1g3TEc3QllOTFpOY1ZNVkFMZDZncjNxM1Y1SmM2?=
 =?utf-8?B?RUxURkd6di83NlBQSXQ1dGJ4NTgyaGtWODhtSWw2eGY4aEp6aENWR0l1dmI2?=
 =?utf-8?B?Z0dYVGppbmlZWVJ0NjZ2T3dwWFR0WDY3bFBZVlhFaWVMenNZUnpXbnN2ZjZL?=
 =?utf-8?B?WDB5VmFKK2lkeDZqU0RDWFFEeFRsT2swZTRsWm42bzhtUVRZZmovTmxDdVEr?=
 =?utf-8?B?akVwK1ladW1WKzlpaEhYSjlNWVR0bTBENzAwbHdtSmRKc2QrdkF6SHRUOVoy?=
 =?utf-8?B?S2Z1Rk5HUDhIZWpwTU9OYVFNeXdmSUtYQWZ5b1EyS3BJOU1VSkR2eHF4TkVN?=
 =?utf-8?B?YWVGTk9sMWdlU2dRTytSQjI1eDBSU05xUVFMTWZyNVBKbzdraXBKYnY5Rngz?=
 =?utf-8?B?cHhWTVRHY1lYL2xrbnlXRXdGOStQZk9KOE9hN3VRclNFN3M1aUhNZmsxZmZs?=
 =?utf-8?B?SzRwT2xFdk5xR2UzTW83NmlsRnRyNDJDMzNVTFdRVVl3cnhwOVU1VnlIK0pa?=
 =?utf-8?B?S3NnNXIzNmV4TjVLdnREd2NUL0pqL2plK09SL1I5amhLN3JnVm1lOGFZYjNG?=
 =?utf-8?B?Z0VmVk1VblJQVTMxcUJDbzdvWUVXNVZnWkJHR0tEVGlBTCtURWdsRWo2bXhp?=
 =?utf-8?B?d0RvRTJwN1IwK1o2MFJQSzM1c0I3Zmw1QWtGTnBaY3A3T3RvU0ZFY1BBQVdJ?=
 =?utf-8?B?eW8xY1JOaXhnUDNYaG1qckZDelNDczZMRjlvdU5id0FyNFdKdzNWUEZyT0xV?=
 =?utf-8?B?aVFzVmVBQ3NPaVJQUmtzNFdSSHFkTHFnSUJtOUk1cHhDWWE3MlR3Ums2QVpa?=
 =?utf-8?B?aGVMbjZlQmFraTU2NXUzQ1M0dGhoaVZqd0F6N2luUFQ5aXplMEVFTGRXYWFy?=
 =?utf-8?B?RWZ5VHZSdEhZZ1ZMY2VOQUxBbUFYUVJwSEVrbkNkNExHdXh1amR5Y0U0eXlw?=
 =?utf-8?B?UU15Z0UrRytzZDgveVA4ZFNySWFEWnhndk55bElLVkd2TndhWGJ6ZldoU05X?=
 =?utf-8?B?NkJjby8vYWZNdWRjT2xyU0lSQ3NZYjJnL0VacnI4RzIvU3o4QUF4TjRZMXBs?=
 =?utf-8?B?RGh4SFdQRmU3U1dUdW9KK0VyeW1HYWhDY2dVblQzOWFEK1k0U0ZlQlhaKzlL?=
 =?utf-8?B?WFNLbTd1UTE1V096SlJuUjhRTjhGdGZjeDMyeVA2TmEzK0lrMUkvLzc0SlZB?=
 =?utf-8?B?TzBXTlhYK1YyRWFQWFVJTnZyYWMzSU4zaDdNcjBXS2hmUEttYjU1dEF4RmI4?=
 =?utf-8?B?RUkyUkFZY1BQU2I1VmhIM2syeXErRndySjJPTkR5YUNWVzFZU05ESGRmZGE3?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 836aba91-ae51-464d-b58d-08de30ebc9f0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 15:10:39.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Viw1pe5C/dvvM/Ol4RDp8d+c7XseZ+rZyWSs1HCn/QTIkhgvrEzXFAWAmoqFisydRULeyD6SLj4L5ZDVFr5TyMouCDocNSdeUWVdDarZ80U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com

On Mon, Dec 01, 2025 at 02:32:35PM +0000, Giovanni Cabiddu wrote:
> On Sat, Nov 29, 2025 at 10:53:02AM +1030, Qu Wenruo wrote:
> > 
> > 
> > 在 2025/11/29 10:29, Qu Wenruo 写道:
> > > 
> > > 
> > > 在 2025/11/29 09:10, Giovanni Cabiddu 写道:
> > > > Thanks for your feedback, Qu Wenruo.
> > > > 
> > > > On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
> > > [...]
> > > > > Not an compression/crypto expert, thus just comment on the btrfs part.
> > > > > 
> > > > > sysfs is not a good long-term solution. Since it's already behind
> > > > > experiemental flags, you can just enable it unconditionally (with proper
> > > > > checks of-course).
> > > > The reason for introducing a sysfs attribute is to allow disabling the
> > > > feature to be able to unload the QAT driver or to assign a QAT device to
> > > > user space for example to QATlib or DPDK.
> > > > 
> > > > In the initial implementation, there was no sysfs switch because the
> > > > acomp tfm was allocated in the data path. With the current design,
> > > > where the tfm is allocated in the workspace, the driver remains
> > > > permanently in use.
> > > > 
> > > > Is there any other alternative to a sysfs attribute to dynamically
> > > > enable/disable this feature?
> > > 
> > > For all needed compression algorithm modules are loaded at btrfs module
> > > load time (not mount time), thus I was expecting the driver being there
> > > until the btrfs module is removed from kernel.
> > > 
> > > This is a completely new use case. Have no good idea on this at all.
> > > Never expected an accelerated algorithm would even get removed halfway.
> To clarify, the sysfs switch does not disable the algorithms themselves,
> it only controls whether acceleration of that algorithm is used, if
> supported.  If enabled, the filesystem can offload operations to the
> accelerator. If disabled, it performs them in software. The
> implementation also handles the case where acceleration is disabled or
> enabled while the filesystem is in use.
> 
> BTW, currently, the feature is disabled by default. If that is
> not preferable, we can enable it by default.
> 
> > Personally speaking, I'd prefer the acomp API/internals to handle those
> > hardware acceleration algorithms selection.
> > 
> > If every fs type utilizes this new accelerated path needs an interface to
> > disable QAT acceleration, it doesn't look sane that one has to toggle every
> > involved fs type to disable QAT acceleration.
> > 
> > Thus hiding the accelerated details behind common acomp API looks more sane.
> Even if we hide these details behind the acomp API, we would still face
> a similar issue with the current acomp algorithms. If we need to disable
> compression acceleration, for example, to assign a QAT device to user
> space, we would have to unmount the filesystem.
> 
> What's needed is an `acomp_alg` implementation that is independent of the
> QAT driver (or any specific accelerator) and can transparently fall back
> to software. We already have a software fallback in the QAT driver, but
> as explained, that does not prevent unloading the driver or re-purposing
> the device. @David and @Herbert, any thoughts?
Perhaps I should clarify the use case to remove ambiguity.

I added the `enable/disable` switch to allow disabling acceleration on
the QAT device so it can be reassigned to user space.  In the current
design, the acomp tfm is allocated in the workspace and persists for the
lifetime of the filesystem (unlike the previous preliminary version of
this series where the acomp tfm was allocated in the datapath).
This change was introduced after a review comment.

Here is what happens:
1. The acomp tfm is allocated as part of the compression workspace.
2. The selected compression implementation is chosen by the acomp
   framework.
3. The driver (in this case, the QAT driver) increments its reference
   count.

At this point, if we try to remove the QAT driver, that operation is
blocked (as expected) because the driver is in use.

Without a switch to disable the feature, the only way to free the device
is to unmount the filesystem, perform the required operation on the QAT
driver/device (e.g., assign it to user space), and then re-mount the
filesystem (which will now use sw compression).

This becomes a real problem for root filesystems with compression
enabled (e.g., Fedora). If the QAT device is automatically used and
there is no way to disable its usage in BTRFS, how can we repurpose it
for something else?
[BTW, for context, QAT is currently used in user space via VFIO, which
requires disabling all kernel users and enabling VFs. There is no
hardware mechanism to partition resources between VFs and kernel usage.]

Regards,

-- 
Giovanni

