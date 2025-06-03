Return-Path: <linux-btrfs+bounces-14409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3421ACC540
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F77165866
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E98229B36;
	Tue,  3 Jun 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eJX5wtnj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t0GyYc0t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E5149C41
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949823; cv=fail; b=JY8PBumQi7AHWwsI5m/gX4gS1K6HVbU4NJ/RxRZH0FATMcV7GOhV2ksqPQ+mC5N60+obT17YkmSKktkN2maMSUk1SBoIjB/pA3heoSXCq5Jif7Q8lTcGU5pPGGH6YBgTdWrqQTi8Frrut5EkZ9yodKkUpZdrufcH7THfJRmQp6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949823; c=relaxed/simple;
	bh=8z2H2KUZFCWDcNF/XbbakKFHtOAIbp/e4Gn/uXgG3Hs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WoESgqPqk9Be6h3R99q7BQYkYWm11lSy6cEhSe902scwgLlSQSVrBILb+uomvL2Xm0IU7iYKIZVlA3I3EUw/evH9VV8adphCK+kwrlFhZ9rn2Zh+XRt9h5jXy86g0FzxFZVX84zYvjdo0lA/ghidnXq0/2Wc+SlwWSPebzN93Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eJX5wtnj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=t0GyYc0t; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748949822; x=1780485822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8z2H2KUZFCWDcNF/XbbakKFHtOAIbp/e4Gn/uXgG3Hs=;
  b=eJX5wtnjvCPQV1kMZYzwrwm7nCK7dKxYki0KSFiSap/9fGYeX2QcBx7x
   b5s3rcXxvqoH/11AW966tPL9W63+dvMu3d9vTQ/7QoTzlCyT69gEArTVc
   gPLn/3adEBSOwfE/ac7w9DqY7jcRRJONzrh/+j4lSCylWY+Nk6KVkQzDh
   PqMlDENW5t9b4vdcDskCiYU/L2PwWLL7PWV1oB+3enGhsde3YpMQJXHHO
   j+rvWLYzM425v5+eu1XMMdW0KZID30ub0VI8FEDqmo3e/Aq70q2nOnvUq
   22TL9u8fhLGPGT8/pon0r5xtk3JCXKpyUsm+XORCzWWCRtAJoqa3bU9lV
   w==;
X-CSE-ConnectionGUID: v5Choq5sSCCB1beuvWBCSg==
X-CSE-MsgGUID: lp6uVklrQEe1jt+3vKrWRA==
X-IronPort-AV: E=Sophos;i="6.16,206,1744041600"; 
   d="scan'208";a="85926499"
Received: from mail-westusazon11010010.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.10])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2025 19:22:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoFbMn6uMnZY7XieklNJ3YPhlYqLA8rL9Ic3E9ST/F7/sUtvFW7FgKO0fLa22dlZZg67xrEXJfpFRr+OU3XW+tGsdrMUx+Juwv4svKWLM9KbHS/6QWemau6NXuKQj+DvxhxHg6Jpn8cZ9bJz+nk4kA549NEE9yIHYEOQ77a5/LFJ1v96em6FlXMGVrtC98YYYw4AJTRuVgWhhuC7gU3UuT0HRKdcfih+xI+e3w6npqRd+hAdFSJ665WPW4ezJACHVZdY2yFebr7V5zKzS7rzXSq+miMCZIv6kWYMfV/cOf8f4Qdbct42Gs+F0ksygnMj4g5aLdRJcg5r0SiOi+X1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z2H2KUZFCWDcNF/XbbakKFHtOAIbp/e4Gn/uXgG3Hs=;
 b=d9TKNmRKUunjjOc09h4lw1ipLD47YVpATZ8k20LRTyFtZDtsgIz2HJfJ2A+dogHulPjv/s8iLZfThlrFLzAMhQhlMvNY76odwalngWBhrpYW/i28outbyvVI4nTpNnE+XbtErGsxvdRyugq3dPcgxpuxql6le/VuTQ1CXm8f3h20pxJYVEF0TChxrlH/zYF60NDZl//tEidJdlbEQG1xgnx8E/FMEzotBB5vmUd2TkkkfOVOrVWtfaiM/+ejBdCIRs0bKW6/Rs4zpG0n7fpAzcgSPrtsG5gf68LltInEPNVAY6JF+LhcIO8iFnd6VWcbiVdvI5huVd5hCESrThHNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z2H2KUZFCWDcNF/XbbakKFHtOAIbp/e4Gn/uXgG3Hs=;
 b=t0GyYc0t+NRvv05JVUxVTZhgNZYgalrZdl6zm+VhNyw/r+IFO/GIkSivRMdxl19VCYLAGt7omROWkQCDmEvPKvGzMgo7yauWSyvlowNTXtg2meI4OJa1qIWrbhQmGirROWQSQf2FltljhXaRx5iE55iyUTG12V2cQnWmMSUaLJo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6432.namprd04.prod.outlook.com (2603:10b6:208:1ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Tue, 3 Jun
 2025 11:22:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 11:22:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Josef
 Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4] btrfs: zoned: reserve data_reloc block group on mount
Thread-Topic: [PATCH v4] btrfs: zoned: reserve data_reloc block group on mount
Thread-Index: AQHb1E7CQ+uMfcGPzkSYlAgQ5OvrSrPxSvmA
Date: Tue, 3 Jun 2025 11:22:31 +0000
Message-ID: <d8e6b335-a47a-4e31-afce-c7b9a87e6b43@wdc.com>
References: <20250603061401.217412-1-jth@kernel.org>
In-Reply-To: <20250603061401.217412-1-jth@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6432:EE_
x-ms-office365-filtering-correlation-id: 5396c7eb-d392-486b-6a49-08dda290ee5f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlNMLzB6UVVyODF2STVIUGY2cjU1MjBZSU85Q1FkaFp3Ym5aRk1IelFkNUNJ?=
 =?utf-8?B?eXlZRFRxdU8vV0Mxc0ZGZCsra3VRTlZZUUx4MjgvUTBhY3dxSkIrV3l2eERm?=
 =?utf-8?B?R01OUnBmK25ZRlk2V3EvYm1SZW9HLzd1MHZGSjhNMm16OGpHTUtmNXAvcnU4?=
 =?utf-8?B?K1U0aGlOWUJGWjhqeWtZelBSMmxvNXhHRlpvQzlDc3FVbWI3a1pWSFgzT29P?=
 =?utf-8?B?REtKZFVlSE81eGNTZlhua0RBRGZ3L2JRZ3RCQkZvRWhGOTNwaXN0aEc2V2hO?=
 =?utf-8?B?RTc2R3BpcDZEa295a0xId2JUQ211T3JyZXNybWx3Uk1uQ1J0empVSFQ3S0pa?=
 =?utf-8?B?bGQ0cTdzOElDSUw2bWN2TnVGSUY3RW1PL1dUVDBWejBGNXF1UkNHKzZxYVcw?=
 =?utf-8?B?c045eXBlaEhsTm42U0E2VFlCN1d1ZE81TDZ0ZHFjczVvd2JDejhyYnFyZ3JR?=
 =?utf-8?B?anJ1WGFwb2p4WUl3TW5rZjArVmQ3cmpzajVSWmNXUlRuKzljN1RIaFpkZ016?=
 =?utf-8?B?OEVPOEFtd0NUVnA4ZVFBcldIMG1YQk5FN2xId2NPWEpSalRDTytYZTdTMllk?=
 =?utf-8?B?RW5YU3U3SjFzckYwU0t2MWVYVk1HSFFXaUxZWG95aWNhZjJRWE1EMDBkMnky?=
 =?utf-8?B?MzM2YlBSRjVlNThpMzFTdkViTlVtNWd4K2hpYUd0bVU2aUFibEtLTnZrcWpv?=
 =?utf-8?B?RHo3SHl6YVZXeGFXTTAwTUFiVzNXSU91SEtKdFdKSDA3Q0NRS3haQlcwSVdG?=
 =?utf-8?B?ZEdPTkxRWXdyMmpUMkRsdHNtVDNoS3dxRWVGQ2hxWHl2RGxMM3ZURms0bHBm?=
 =?utf-8?B?SDZqMkpTdUx3clUyRXlEODVrNWNVbUhoMmhHQjZ6Z2doMkxmWmpYZTBPZWJn?=
 =?utf-8?B?bmpRakZqNmkvUmpKWlB4Yjl4czQ5Q3ZOM3Z2QjFaTzB1MThwa2J3TEJ1am1G?=
 =?utf-8?B?cXFGRENVL2xDTFlZY2hpU00zN2t1WEZFcytDOUZJbUc4YUI1VUtQUEZ6enFk?=
 =?utf-8?B?YWVhbS9nZFhYMFZ2eG82MUUxK3M4eTNJMEJpb2JET1plbjRKUndvczF6T2Ew?=
 =?utf-8?B?TUNUSCtZaDFpNUsxN0RlRktLSXZrRUdJaVl4OE53Z0E4VUtEZjJoZGtGTHBm?=
 =?utf-8?B?MlVOTkFNSDZvb1BMeTFLV0VYckc5K1JyQjJVb0pONHBueXlvUFpHcG9CWW1a?=
 =?utf-8?B?QXBkbjM3Uit1YzgvQWZkOXZVNUc0UDl2OThKQ0U4T2QwZStQbWxqcUpCcEJw?=
 =?utf-8?B?NGMrd3pnRE95bEdlRnJ5VDhzc3Y5aVpoUnpHZ0pKMjZOV21aTU9VMXhTanhM?=
 =?utf-8?B?Nk1NYzZjZWdWSVpLY1RtL3lEcEp5L0Z5RE0xTjVnK3NyUjVReDQ5VlJyRXd0?=
 =?utf-8?B?M3pwQ3ozdGNxMFpQRWg2bGZEakFRaWxUalF2aU5RSUtXVldHSDFWQjZoOEQw?=
 =?utf-8?B?UFZnc3lzU29jQjM4bGQrQTNuTUNHY2RDbkdOSUoxRzlrN0pmRnJHRHVINlRQ?=
 =?utf-8?B?Wjd4a2lkQ3VsVXN2cks1Nm9WRFVCMFRFK1ZEMWNOOGVSY09lVlZ1TGNUeW4x?=
 =?utf-8?B?YklUaTY0VENxV21VUURSRHV3aGVOVzEvYk51WC9RZVNSZDVsSllJYjh0UnhE?=
 =?utf-8?B?VFlEVFgxTkpFN1BsbFNPQ2twRkJaVVhSczZrVDB4UWtZczJEYTZacUVtMndX?=
 =?utf-8?B?TGNEK3BEbkNrcUU3aDhTaGpMUDNyemhBdlE2dk1kYzZneEdvKzdudW4xWTJa?=
 =?utf-8?B?SWJHY25BVXh6akZ6dzRCMG95SWR1K0hIN05JRWVLTE5VSzdMRG9hOTZXejZv?=
 =?utf-8?B?MDlpVDBQK1VKR0ZiRUFjUCt1TkhPV3hkaWZSeVV2OXUwNTVwRTVyN0ZWTzcx?=
 =?utf-8?B?WE5NLzU0R3ZFQVBMYm5sYmUyQzhNYTNrWFBMcy9TSUVocmVxbXVqK2xCL2w3?=
 =?utf-8?B?RHIyc1NKRVZ6MUx5bUNvaW55OWJCTndabGhSRmZ5NCtrcDZHM1h6ZUlSMjZW?=
 =?utf-8?Q?s0St/ffksUEOA+xWQRezq7OQAudYqU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDMyQUdBK2phWURob3JJeWlnUW16MG1ScHE0Njd0NDl6ekJUeHA5OVVOUVNp?=
 =?utf-8?B?eGxrNEFDazFaRm4rRnVONXdUM0Q3b29rbmJOMGhoUWMydDIwdzg0eS80QXF3?=
 =?utf-8?B?cXhkOW1LVk1ISEJpdnVCdDdMdGtnQmd0cTFiZTRMdFhaOHp4bkM2d1JPU0JX?=
 =?utf-8?B?QkdpbHFrdm5CajlsRGhQNEN4YThudzZuQytmZVpodVA1eGlNN1FXb1VyZ2t1?=
 =?utf-8?B?aDBtaEtNcDcxdDNmUnNZOTlHdGhyeGR4OFltdnpwZ092c3hxR1ExUnlHSG1R?=
 =?utf-8?B?NGFTV29YK1JoWXdWL1BXV3J1dTRPZWt0b2VQYkczSnMwNlBaZitGVmN4emtM?=
 =?utf-8?B?ZHNIS2x6S05NbkxHaW5DY05ZTU8xcnVuUFVrWHBkVCtLa2l6MGt4aE1Oc21s?=
 =?utf-8?B?ZmIxOWZxbG9IdFdrUkNZV05IV3NIYXdTRzJjMzN1UWtvYjNOcTNmcTJKTHl6?=
 =?utf-8?B?cENhUDJDV3RzYUJNdEJLb1BPa3pNZ2lpMjN3OTFnbFA3TEdkcFE3M1lvdjFa?=
 =?utf-8?B?dTh5Mk5CdnRXQUlYN3BaeDRUczNzMGw0bkJlV0lnc3VQTXZyamU5Y3ptVkt5?=
 =?utf-8?B?aStiaGt2eVRBNndmc0FXTjB4UWFuc2tiaDRkdEdMVUlQUnFvUjFUTmpQQ3lp?=
 =?utf-8?B?a3FhaEFVTjFHNFI4VmZqbHgxQ203eXl4YTNkbDd5TWd0OHpOQUh3ZTVibnNh?=
 =?utf-8?B?M1hieXBMem5WSWtsYXNpTXd4eXMvSzY3ejFjUERiMkVMVDl1OXN5RENBcVo4?=
 =?utf-8?B?bTFXTklSUmI4YXFuWWlYSzA4cm9Yc1BLbzBjellqK2h1OCtibjNNcHZFQ0JS?=
 =?utf-8?B?VDFac1JaMkN3OWVmRUxxeXRZRkRMYUpqUDg2cTk1RTdiOXJYaUsxaXpyWFlT?=
 =?utf-8?B?ZDRMM3p6NjFnS1hnVlYxS2I0R2o2Smw0OFpoL0lRRFJ2M0Zmb1A5SWlxZ0RG?=
 =?utf-8?B?S3UvZlVEUkFuTmpwMUNrMjVINWFoYkR4dDgxMlNzUjlLSnpjd3FKWW41cmU2?=
 =?utf-8?B?REdHKzBobFJXUnlhNDNFVTlKZXFISjZ0M2NNcTF0YmkycG1pbWdNelFmVWND?=
 =?utf-8?B?dzQrSU94bTBqVCthWkVjSGh3TjZ0Q1c1N2k0cUtxUDRWNkRYMXlVN1hjYmEy?=
 =?utf-8?B?MEluWlhvczZaR3Jxd21KcFpvbHMyWVVWRThWSWRYT0pBSGk5ZXlSSmxlM1d1?=
 =?utf-8?B?NFE4TmhOT0RBbWJRcHNObjBCM09kTThBdU83ekZET0NFMW9kMy9RbVVDUnlJ?=
 =?utf-8?B?cHFCNWROU1U1S3RwUVZCTURLb0ZqNmxoaEx2MlNrQndyYU9ENnRwc1JGdUlr?=
 =?utf-8?B?OE1lZjJGcHlvd3lyZkZZZStlemNLcXpWZmJoak84dHh4YUt5WlpWcldpZG1E?=
 =?utf-8?B?WVBxUkRDenFSM3cvaXB2a0ZYZjE2dGZWSkZzMUkxSHQ2QVNCdS90cTlkcm10?=
 =?utf-8?B?SFVCNkJxM3BqRW5Sb2hkS1hQMzdWQ1FvRS9LVWpYTE9hMVFhNHZiRFVYVzN4?=
 =?utf-8?B?TStVRGhNWEN4M2Q2SFlpQndtMUhGTnRMMjJmWjFPdktuQjJKN2dSQXZFekRt?=
 =?utf-8?B?ZFdYOW1wUHg4MCs3VDFZNnp3cm56WWJKQXd1SnpyNzc0bVBDNnd6L0g2QTZY?=
 =?utf-8?B?TllRSGhqNGwzOHl1UzVaWkIrOEc4eGRrQ0ZCeTYrc0ZCcnF4Zi9GZTJKRUtO?=
 =?utf-8?B?UnFzcmR6SHpuR0xKM2FFZXk4QXRuWTVycXFCb3RlcTRodVdPR2hKcG5NZTUz?=
 =?utf-8?B?SjNyWXJ6clZFSWZnd0JJTkVoVmhFQktVazl0NWZXSm1XYnIxeDNDMktndk1u?=
 =?utf-8?B?TkRjeWUxRGdtMWQ5dTBvUHdQeFF0YjNNK2FCamIwalU3Wi9BcWM4bzRwdW5j?=
 =?utf-8?B?RVcyM2xoM0pzU21Gb1dDQ1lKeUZqaEhuU2hNN2YwY1hxUXFDSHFCYzN5V2tX?=
 =?utf-8?B?N09GcWtLN2xuc3ZHbG85TDV6QzR1Zy9EeE40Zkx0bU9jOWNqeURnNXNCVHNn?=
 =?utf-8?B?T1NuUG1zU1Iwd21vLy81MitSOUtnb0NjU1NqU3pJeVUrcnptMXMyOVFkdy9w?=
 =?utf-8?B?K3Z1STI0RnJFS2V4MkViOS90cTRXM0ZPTHVvRVB2SnIwZ0ZlaDNna3pFb1pO?=
 =?utf-8?B?UkExc3pxdWFCd1YyQjhScW53UkNFbXQ5cGwrYTh6MDdGeGVnOHhRV1JxcEVO?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90A36DB01F25A44D983E75F15208E358@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QgmjbJtgX33SGYJKQeM2D0mqz7DkzaQhC2OytvNwQj9T24f9Kyu8gIW1xfmYJ1pBvEz28UNLEyH6KqCBakq0+mNbodZrVs2veO1tJczBSqOMF91T1p6kHZR9NgSPzfGm3UUlTn0GEqLMIR1qJQe4rmaNPbuHzCnLmip62iXYBg8CbAGMaG7wVj5GulX5lKU8NjhrEDBf4KSZ2vb4txN27vl96qQFYEY7dJsPhx4OYYDkCxt375711dM721SsM8Ggjng1XZZSnPE5gdDilRzFQ5W7/jTMaBRkDUU6g9ubsG7OfdSf9JbOFgVCBioeh5/Low2fPX0Ym/bMY+a5UOWWoexvTZMI5DzjMyKbVfcgEunsyoB5NE39K1AThzqAjs02hMOlDt1DMNmbQqsh49f9B0QFrG+TsbAkAujB7CYSzQOkNuZ0fctJVezkovUtyR6HPJygNGRfAGnBIF1cNi2u2lW6JwG1i0zHa0h/HyrJx0nTl5SIKDBIql76XWDPMdD1K4p2NNHkYdL1pPYHFsh1KqTNWl1ec5+6WerIdEiGEjU6Sq1LHhqrYXs72/ez7s32NO6rvETwQY8hr+WcBuJ5rhv/Fd2zAwoAwHBbdeP+tVkEVBuPaXQhDQQmn8JETWOS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5396c7eb-d392-486b-6a49-08dda290ee5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 11:22:31.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBJ3qVP5AmMoSVZJ9YUCghJAIGOWV43Hgzh4ftbEerC3rIFcNVp3RY37AtNTgsDmX70mUPNdMlhX5HJ1JZ9cuGQl1FCabiSpYsuAwgfpGk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6432

T24gMDMuMDYuMjUgMDg6MTQsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gRnJvbTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gDQo+IENyZWF0
ZSBhIGJsb2NrIGdyb3VwIGRlZGljYXRlZCBmb3IgZGF0YSByZWxvY2F0aW9uIG9uIG1vdW50IG9m
IGEgem9uZWQNCj4gZmlsZXN5c3RlbS4NCj4gDQo+IElmIHRoZXJlIGlzIGFscmVhZHkgbW9yZSB0
aGFuIG9uZSBlbXB0eSBEQVRBIGJsb2NrIGdyb3VwIG9uIG1vdW50LCB0aGlzDQo+IG9uZSBpcyBw
aWNrZWQgZm9yIHRoZSBkYXRhIHJlbG9jYXRpb24gYmxvY2sgZ3JvdXAsIGluc3RlYWQgb2YgYSBu
ZXdseQ0KPiBjcmVhdGVkIG9uZS4NCj4gDQo+IFRoaXMgaXMgZG9uZSB0byBlbnN1cmUsIHRoZXJl
IGlzIGFsd2F5cyBzcGFjZSBmb3IgcGVyZm9ybWluZyBnYXJiYWdlDQo+IGNvbGxlY3Rpb24gYW5k
IHRoZSBmaWxlc3lzdGVtIGlzIG5vdCBoaXR0aW5nIEVOT1NQQyB1bmRlciBoZWF2eSBvdmVyd3Jp
dGUNCj4gd29ya2xvYWRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJu
IDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEZpbGlwZSBNYW5h
bmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KDQpVbmZvcnR1bmF0ZWx5IHRoaXMgY2FuIHJlc3VsdCBp
biBhIEZTIGNvcnJ1cHRpb24gaWYgdGhlIGFjY29tcGFueWluZyANCm1rZnMgcGF0Y2ggaXMgbm90
IGFwcGxpZWQuDQoNCkkgdGhpbmsgaXQgaXMsIGJlY2F1c2UgSSdtIG5vdCB3YWl0aW5nIGZvciB0
aGUgdHJhbnNhY3Rpb24gdG8gYmUgd3JpdHRlbiANCm91dCBpbiBjYXNlIHdlIG5lZWQgdG8gYWxs
b2NhdGUgYSBjaHVuay4gVGhlcmVmb3IgbWV0YWRhdGEgb24gRFVQIGNhbiANCmdldCBvdXQgb2Yg
c3luYyBzb21laG93IHdoZW4gb25lIGNvcHkgaXMgb24gYSBzZXF1ZW50aWFsIHpvbmUgYW5kIG9u
ZSBvbiANCmEgY29udmVudGlvbmFsIHpvbmUuDQoNCg0KPiAgIGZzL2J0cmZzL2Rpc2staW8uYyB8
ICAxICsNCj4gICBmcy9idHJmcy96b25lZC5jICAgfCA2MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgZnMvYnRyZnMvem9uZWQuaCAgIHwgIDMgKysr
DQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZnMvYnRyZnMvZGlzay1pby5jIGIvZnMvYnRyZnMvZGlzay1pby5jDQo+IGluZGV4IDNkZWY5
MzAxNjk2My4uYjIxMWRjOGNkYjg2IDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9kaXNrLWlvLmMN
Cj4gKysrIGIvZnMvYnRyZnMvZGlzay1pby5jDQo+IEBAIC0zNTYyLDYgKzM1NjIsNyBAQCBpbnQg
X19jb2xkIG9wZW5fY3RyZWUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGJ0cmZzX2Zz
X2RldmljZXMgKmZzX2RldmljZQ0KPiAgIAkJZ290byBmYWlsX3N5c2ZzOw0KPiAgIAl9DQo+ICAg
DQo+ICsJYnRyZnNfem9uZWRfcmVzZXJ2ZV9kYXRhX3JlbG9jX2JnKGZzX2luZm8pOw0KPiAgIAli
dHJmc19mcmVlX3pvbmVfY2FjaGUoZnNfaW5mbyk7DQo+ICAgDQo+ICAgCWJ0cmZzX2NoZWNrX2Fj
dGl2ZV96b25lX3Jlc2VydmF0aW9uKGZzX2luZm8pOw0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMv
em9uZWQuYyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gaW5kZXggMTk3MTA2MzRkNjNmLi5hMzFhYTEy
OWNiMGYgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3pvbmVkLmMNCj4gKysrIGIvZnMvYnRyZnMv
em9uZWQuYw0KPiBAQCAtMTcsNiArMTcsNyBAQA0KPiAgICNpbmNsdWRlICJmcy5oIg0KPiAgICNp
bmNsdWRlICJhY2Nlc3NvcnMuaCINCj4gICAjaW5jbHVkZSAiYmlvLmgiDQo+ICsjaW5jbHVkZSAi
dHJhbnNhY3Rpb24uaCINCj4gICANCj4gICAvKiBNYXhpbXVtIG51bWJlciBvZiB6b25lcyB0byBy
ZXBvcnQgcGVyIGJsa2Rldl9yZXBvcnRfem9uZXMoKSBjYWxsICovDQo+ICAgI2RlZmluZSBCVFJG
U19SRVBPUlRfTlJfWk9ORVMgICA0MDk2DQo+IEBAIC0yNDQzLDYgKzI0NDQsNjYgQEAgdm9pZCBi
dHJmc19jbGVhcl9kYXRhX3JlbG9jX2JnKHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqYmcpDQo+
ICAgCXNwaW5fdW5sb2NrKCZmc19pbmZvLT5yZWxvY2F0aW9uX2JnX2xvY2spOw0KPiAgIH0NCj4g
ICANCj4gK3ZvaWQgYnRyZnNfem9uZWRfcmVzZXJ2ZV9kYXRhX3JlbG9jX2JnKHN0cnVjdCBidHJm
c19mc19pbmZvICpmc19pbmZvKQ0KPiArew0KPiArCXN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpk
YXRhX3NpbmZvID0gZnNfaW5mby0+ZGF0YV9zaW5mbzsNCj4gKwlzdHJ1Y3QgYnRyZnNfc3BhY2Vf
aW5mbyAqc3BhY2VfaW5mbyA9IGRhdGFfc2luZm8tPnN1Yl9ncm91cFswXTsNCj4gKwlzdHJ1Y3Qg
YnRyZnNfdHJhbnNfaGFuZGxlICp0cmFuczsNCj4gKwlzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAg
KmJnOw0KPiArCXN0cnVjdCBsaXN0X2hlYWQgKmJnX2xpc3Q7DQo+ICsJdTY0IGFsbG9jX2ZsYWdz
Ow0KPiArCWJvb2wgaW5pdGlhbCA9IGZhbHNlOw0KPiArCWJvb2wgZGlkX2NodW5rX2FsbG9jID0g
ZmFsc2U7DQo+ICsJaW50IGluZGV4Ow0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlpZiAoIWJ0cmZz
X2lzX3pvbmVkKGZzX2luZm8pKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlpZiAoZnNfaW5mby0+
ZGF0YV9yZWxvY19iZykNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKHNiX3Jkb25seShmc19p
bmZvLT5zYikpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCUFTU0VSVChzcGFjZV9pbmZvLT5zdWJn
cm91cF9pZCA9PSBCVFJGU19TVUJfR1JPVVBfREFUQV9SRUxPQyk7DQo+ICsJYWxsb2NfZmxhZ3Mg
PSBidHJmc19nZXRfYWxsb2NfcHJvZmlsZShmc19pbmZvLCBzcGFjZV9pbmZvLT5mbGFncyk7DQo+
ICsJaW5kZXggPSBidHJmc19iZ19mbGFnc190b19yYWlkX2luZGV4KGFsbG9jX2ZsYWdzKTsNCj4g
Kw0KPiArCWJnX2xpc3QgPSAmZGF0YV9zaW5mby0+YmxvY2tfZ3JvdXBzW2luZGV4XTsNCj4gK2Fn
YWluOg0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoYmcsIGJnX2xpc3QsIGxpc3QpIHsNCj4gKwkJ
aWYgKGJnLT51c2VkID4gMCkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCWlmICghaW5pdGlh
bCkgew0KPiArCQkJaW5pdGlhbCA9IHRydWU7DQo+ICsJCQljb250aW51ZTsNCj4gKwkJfQ0KPiAr
DQo+ICsJCWZzX2luZm8tPmRhdGFfcmVsb2NfYmcgPSBiZy0+c3RhcnQ7DQo+ICsJCXNldF9iaXQo
QkxPQ0tfR1JPVVBfRkxBR19aT05FRF9EQVRBX1JFTE9DLCAmYmctPnJ1bnRpbWVfZmxhZ3MpOw0K
PiArCQlidHJmc196b25lX2FjdGl2YXRlKGJnKTsNCj4gKw0KPiArCQlyZXR1cm47DQo+ICsJfQ0K
PiArDQo+ICsJaWYgKGRpZF9jaHVua19hbGxvYykNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJdHJh
bnMgPSBidHJmc19qb2luX3RyYW5zYWN0aW9uKGZzX2luZm8tPnRyZWVfcm9vdCk7DQo+ICsJaWYg
KElTX0VSUih0cmFucykpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCXJldCA9IGJ0cmZzX2NodW5r
X2FsbG9jKHRyYW5zLCBzcGFjZV9pbmZvLCBhbGxvY19mbGFncywgQ0hVTktfQUxMT0NfRk9SQ0Up
Ow0KPiArCWJ0cmZzX2VuZF90cmFuc2FjdGlvbih0cmFucyk7DQo+ICsJaWYgKHJldCA9PSAxKSB7
DQo+ICsJCWRpZF9jaHVua19hbGxvYyA9IHRydWU7DQo+ICsJCWJnX2xpc3QgPSAmc3BhY2VfaW5m
by0+YmxvY2tfZ3JvdXBzW2luZGV4XTsNCj4gKwkJZ290byBhZ2FpbjsNCj4gKwl9DQo+ICt9DQo+
ICsNCj4gICB2b2lkIGJ0cmZzX2ZyZWVfem9uZV9jYWNoZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbykNCj4gICB7DQo+ICAgCXN0cnVjdCBidHJmc19mc19kZXZpY2VzICpmc19kZXZpY2Vz
ID0gZnNfaW5mby0+ZnNfZGV2aWNlczsNCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3pvbmVkLmgg
Yi9mcy9idHJmcy96b25lZC5oDQo+IGluZGV4IDk2NzJiZjRjMzMzNS4uNmUxMTUzM2I4ZTE0IDEw
MDY0NA0KPiAtLS0gYS9mcy9idHJmcy96b25lZC5oDQo+ICsrKyBiL2ZzL2J0cmZzL3pvbmVkLmgN
Cj4gQEAgLTg4LDYgKzg4LDcgQEAgdm9pZCBidHJmc196b25lX2ZpbmlzaF9lbmRpbyhzdHJ1Y3Qg
YnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgdTY0IGxvZ2ljYWwsDQo+ICAgdm9pZCBidHJmc19zY2hl
ZHVsZV96b25lX2ZpbmlzaF9iZyhzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnLA0KPiAgIAkJ
CQkgICBzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIpOw0KPiAgIHZvaWQgYnRyZnNfY2xlYXJfZGF0
YV9yZWxvY19iZyhzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnKTsNCj4gK3ZvaWQgYnRyZnNf
em9uZWRfcmVzZXJ2ZV9kYXRhX3JlbG9jX2JnKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZv
KTsNCj4gICB2b2lkIGJ0cmZzX2ZyZWVfem9uZV9jYWNoZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbyk7DQo+ICAgYm9vbCBidHJmc196b25lZF9zaG91bGRfcmVjbGFpbShjb25zdCBzdHJ1
Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyk7DQo+ICAgdm9pZCBidHJmc196b25lZF9yZWxlYXNl
X2RhdGFfcmVsb2NfYmcoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHU2NCBsb2dpY2Fs
LA0KPiBAQCAtMjQxLDYgKzI0Miw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBidHJmc19zY2hlZHVs
ZV96b25lX2ZpbmlzaF9iZyhzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnLA0KPiAgIA0KPiAg
IHN0YXRpYyBpbmxpbmUgdm9pZCBidHJmc19jbGVhcl9kYXRhX3JlbG9jX2JnKHN0cnVjdCBidHJm
c19ibG9ja19ncm91cCAqYmcpIHsgfQ0KPiAgIA0KPiArc3RhdGljIGlubGluZSB2b2lkIGJ0cmZz
X3pvbmVkX3Jlc2VydmVfZGF0YV9yZWxvY19iZyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bykgeyB9DQo+ICsNCj4gICBzdGF0aWMgaW5saW5lIHZvaWQgYnRyZnNfZnJlZV96b25lX2NhY2hl
KHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvKSB7IH0NCj4gICANCj4gICBzdGF0aWMgaW5s
aW5lIGJvb2wgYnRyZnNfem9uZWRfc2hvdWxkX3JlY2xhaW0oY29uc3Qgc3RydWN0IGJ0cmZzX2Zz
X2luZm8gKmZzX2luZm8pDQoNCg==

