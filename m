Return-Path: <linux-btrfs+bounces-18248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843FFC04B93
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9133BF74B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584372E040E;
	Fri, 24 Oct 2025 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dWfbhwfJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xewPV7wL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48C28D8DA
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291065; cv=fail; b=tjVsbdPzp0gcD16pgTS28fSzpOE5A+M4OuiftGXYQFPrCWPbVQ6AdBRGPUo0SzU4tw9hfk6jnaxTUPJ3aMGMZ4umoshhJjYTIMWd5KSq/28yzYctBQ070OErgJDwesEd5mrAZ+m/mDImAUlyofyMgVWgYcr4E8d7yC4mFdZodY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291065; c=relaxed/simple;
	bh=Ix+ObygNfJQQCmcX8KrCT85ZhL/7frHJPh6Iy/T55L4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oKATLiHvGOpoH38aGVbqWu30Mzd3SsQlAsndfdSWFtGg0CL1zYdEvLYhZ8yhmKoJODXYrqSyMYaSPK2+NXad8ORPNUjdYMhOY5QZ2lhRrDAiQClGZruCJBQqRq6tc83AN3UmU3ravl+J+cSZizSPP2des/q5LLeg7grZFkD59ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dWfbhwfJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xewPV7wL; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761291064; x=1792827064;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ix+ObygNfJQQCmcX8KrCT85ZhL/7frHJPh6Iy/T55L4=;
  b=dWfbhwfJqdlzuigKh7zPSzODfTyDubtjvmU5p3550o9WAocQdZKDz4bf
   HM9z0/5WzKkJ7D0dbcIDTkIO9c4LlSZgdRz4Rm0sQxttHlytT65oAOmkl
   WPqmloI9H2gOwixmr3ArnNSz5CJ6MJqE0ZabD5jLRvktykytNHeW3YZM7
   ziY+haswPlNwdTnbe/VjHsFBdV3NNL2LNLIFiYq63pEsRAITuB8LZNXSP
   dfzcRSgOwLLhR7JGRQxJU7ASb+AQGdOK+TUTtehJZsUxK1vizopdfAnbG
   ZiOGKAnElyJ2WY+QbNuF6alAt91EUzq+VxxN5o43+CTYlYYD9APp+eflG
   Q==;
X-CSE-ConnectionGUID: YJENYKG6SOSU5LGyRZm9Ng==
X-CSE-MsgGUID: X36Rt5jeSdyx0YIT56X4iA==
X-IronPort-AV: E=Sophos;i="6.19,251,1754928000"; 
   d="scan'208";a="134766693"
Received: from mail-northcentralusazon11013027.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.27])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2025 15:30:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1mrVj1c7V/2gzgaJz99R0LPP+cKTqk76uxCeRvlwqLpZVgYpcM0j+nxjQlUuSlfnfjfp0nXNN7GLMdGRajTgPbesgoHMFpDR9j8R6Ser3ot+GClb7CubpAAkNFzStNlW8nrrLB5HHNqzgsVH+M7c7/pZMRkMZELqihwS6Ag0QwuAh9chylvlbJ+8AhTVQY+j0Rwc0DatmIun1i9W8ESqTsEKaIdlQdVY7yl4FarZYCjUWe+FrO/Bube0rsg+HBO9jv1QCHQNow8NpT3mTuA0njWubMyi67Zdij7+FAuHwN2PiIdUDeN/+G+ItJ5WbA0XpGoYGw2t1eVeoPSzewVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix+ObygNfJQQCmcX8KrCT85ZhL/7frHJPh6Iy/T55L4=;
 b=BhvZMX3nF6YfdVNBYpB3FdpgAJA/TwNAL+YWa9Z3JVbR+mr0IvUAlpu0a0qHwTYKDcu0VByiNe3Q5pROsqz48Lrj+bGqecHswuvskYKYWHGQ86qDtFm8XDkiHwCPMpuZysdhLw9MrqoeR4ObGzdEL0bmtQw/bcYuujoNSEJ53SCXTwHpvWXK56hUC4FJG6EQbbfELZ4qAt9zjj+taHENybHct3UYQM6VLXVq8jxuQwfQ5j0exzmL7fRH+vHEKFXoJpziQh+2Vk6h2JlNa8Il7I/As8v6O/N1uwKEGVE0Pvhv48ZplZ8fL+4KyOEz6ieGNseC93TKQKGhTbJMIwqk4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix+ObygNfJQQCmcX8KrCT85ZhL/7frHJPh6Iy/T55L4=;
 b=xewPV7wLfgjYkto0QZrG6edt7wlpgEZAk0XHvcMD/ordRbEZD3zYEr0G+ZuTTbY1MQsXmM1De+d/VxY5EBE63Mcw4iBA25AVB0Rl6az7fau3x80lqB6JQRN+8ivN6d6t3jh3CgT9pzBwK58p5+udXs/0oFFjSCAPYYhXKSsYOKY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6714.namprd04.prod.outlook.com (2603:10b6:5:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:30:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:30:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/28] btrfs: some small optimizations around space_info
 locking and cleanups
Thread-Topic: [PATCH 00/28] btrfs: some small optimizations around space_info
 locking and cleanups
Thread-Index: AQHcRDYiLvMo6h4CkUGTiUekYcjoLbTQ59eA
Date: Fri, 24 Oct 2025 07:30:55 +0000
Message-ID: <10ff1ca4-ae10-4d9e-8615-42f6218110b7@wdc.com>
References: <cover.1761234580.git.fdmanana@suse.com>
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6714:EE_
x-ms-office365-filtering-correlation-id: 11575097-a74d-4bbe-447f-08de12cf44a8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?azR6Qi9qM0hYQ1ZpT3VVNjIrdmZZckxpVm1MWEdYZ3IwQUlpMEZwazNSUWJ6?=
 =?utf-8?B?OGNkUVdJNW12TEZWM1NYaTVFQzhrODVOMTN3eWtYcmREQ2NsMThQZ2YzRWUr?=
 =?utf-8?B?dG9SdFNaNWlvb21aaGZBdmk4a1piSEVDQ3RTNDVyenZyVFdHVlJJcHhEQUxm?=
 =?utf-8?B?aVBOcGp1SlBDRFdLUVhrUmVMZEFYcGs2Nmd6VEwxbVdRWm9RR1pNeUwrS2Jk?=
 =?utf-8?B?R1M0dkpzWExaVEtGa2x4cUs3cWluTlNCZ3M2RUUyUU1leEpLTysrZzhkazNy?=
 =?utf-8?B?Z2pjRXdUSk5UZlA5eThGaUtVdUNVNUc0U2RGNHhDWW9YVitWdzRxSjg4d3Ra?=
 =?utf-8?B?eVRiQjN2eVZCMjNYcDk1T2pTWmsxU3RlQVJCQW10dzF3bWdyZ3phTlRmVW13?=
 =?utf-8?B?NUJpOS9hR3F3L0lvNDZZbVBwQWZmdnN3dG9DeXEwVVQ2YlN4eXRVcXpzbjNP?=
 =?utf-8?B?RmxscHlIUTREU0tPbFRGcnJrZ2FKQjZWbmxiTVBnd0dmN1RoSUNkR2FnMTZz?=
 =?utf-8?B?SWs1d25qQllaeWZRZzg3SUpHWFd4NmFRMkU5TXZReXBmeWJBTncyNzhLUy9E?=
 =?utf-8?B?bWx4M0hYNmpBSFJzN0lRWDhQb280T3B0QnNhbm9kaEVHRTNXTTVINzZWTmVv?=
 =?utf-8?B?aHF5YXRQMjV1aWIxaFYyWlVlSmFacWVjZWErVzRhbHRFZllHTHRRRUNDU1Rp?=
 =?utf-8?B?WWhhdThESXZYZWdWMjlla2pQMU9maHE3T3cvYXlMSlRxNEplMTd0eVlZNjNO?=
 =?utf-8?B?V3gvWThPQUtacFJqWXVXclRaREx0SUFVUTU2WldUamNiUVhSdVRHaFl6ZzUz?=
 =?utf-8?B?cnJYd21Ecm0yN29tb0c0eHhkOWFPZlc1U0xGdkJwTS9rc3A0RU9IaVJsODJx?=
 =?utf-8?B?ZCtHbGNIWHFJdSthM01UcUdBN01hWFN0QTRudDVrOHoycEFxVFRUaTRCSGVQ?=
 =?utf-8?B?WG4zMWZRZlJVd3VnZ1NnNkVQc0RvdmVqZndBY2JnS1VlTnl0eUhTSTd5bGFT?=
 =?utf-8?B?enFuTlRvZ2VrcVlqUW5tL21Qa1NKZTNmdkExencwUUZ5ak9BaG5IYzJIUjFD?=
 =?utf-8?B?eHlyLzhHVVRjcjllWmFKNzJtcU43bkRXSzBUb05jY0pYZUk3RnRyb25Qem9Q?=
 =?utf-8?B?Qm1pMWdtczlYc0ZKZGNESG1JTHRXODJLQnFmbUZORzArUHVuZUhQdmNvMEpS?=
 =?utf-8?B?TnVBRzE3S3ZuY25IZDhiWVM3RDF0bGIvR01OZkpoQlgzdGZmSzNGNnVOMHJT?=
 =?utf-8?B?TGU0Z0RqUGxpa1lkcHFnOGlOKzFLaThrOTk5dm5wSTUzYUNvRlROTGNRU2dk?=
 =?utf-8?B?Z05BUzBCLzdqcGQxbEJBeFZ2bFFmd0lpUzR0UWJFVnNIbys3OFlCcjhGQTBH?=
 =?utf-8?B?RGc2TjRtYVQ2TGNwMy85NnlvN1hJcGNPazF2anhwRzNUREY2R3pXSGZSTjJV?=
 =?utf-8?B?ZVN6Z1VvNG14WEpFODE1Ynppc1hyWG5xdTRBd1grdHNOTVAxSmM0Qmp4L2Y4?=
 =?utf-8?B?UU5wbmIzREhKdWM3QWpoN050ZExtODc5cHhzK1laakpvUUJ3cTFQNEo0Y1JW?=
 =?utf-8?B?UUJyMW8yVHNkYnNZTEZ2N2RKMyt5SVVrZ1RpQitxSHFzN2pYeDZIUXRucnJZ?=
 =?utf-8?B?SUFJRTZRdTMwRlpza012NjVrd0RXQXNGbHVYTWNDU3FzQXdqd0FoOEJDd0ds?=
 =?utf-8?B?cXB5L2YyeC9mL3UvM25ZS0hwVlUrZWFnQjFrY3FBaEc2YXB3TDFYZ1FQWHlB?=
 =?utf-8?B?ZGlud0xvYmpTS3VWNHNMQTNjWlRvOVBqMWNNRnpkcENRWFVpeSt3SXNCd3Az?=
 =?utf-8?B?NjBoOU9zbVB6MVI0cmVOQSt2eENUVnVSYVZDa0tOSjd4N0FwTGYrTmFiQjI3?=
 =?utf-8?B?MGgrUjFyekhQai9KcVlSeCtNOFdQNGNOWE5YKytZVkdYWlVKUVVLcFI4ZFZO?=
 =?utf-8?B?cEU3M2lmUkgwVHBsdjE4Nm9Gd09FTVBoREZjOWh3TEFlQnZNb3orMm1oREdH?=
 =?utf-8?B?N2JPaityZFJPazJSZnMya3ZlM0NNYUV1Z0VQNTZMd1F2RkEyMk91cVJjRXZ2?=
 =?utf-8?Q?qQsnHr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aklxanJMMkRvd2ZFdjlaRVRaRGNpeUdWRGo2dXcrYzQ5emNONU8xMlVYS1No?=
 =?utf-8?B?dHNkZU1lWXRObCtsd1R0NjdUcmZFTVBsQ0lkcWpmd2R3eEpkS0ZhM01oMlRH?=
 =?utf-8?B?OTEyK3pXeUNibVVaVkJ6ZDhBM2tTalpjbXl0eitLb1lkVGtpdEdIaEVXNWls?=
 =?utf-8?B?YUFoSGJpYzlNYXVFckpqOEpsUExIeXVLYnNVU1NQZElZT1ZQNTdKcFhEZWdv?=
 =?utf-8?B?UHJWOGhRWE9ydy9qbXNORWU5YmxLVkcyWWI2cTlwdnpDR0tpRXdjWXRJZGhK?=
 =?utf-8?B?VmJrbUI3Tmd5bW9OdFkvRElKWjhCNVNobWtCSEIrVUlORkRCQ1JnM2RkcXlN?=
 =?utf-8?B?UmVuNU9ySlI1Z3hTY29iSk1aN1ZSaEY1bXJOcCs5elAxaVZOTHhtQzdWSFpo?=
 =?utf-8?B?OFRpQzZ2ejRlTXpiTnlSWmlTbktIM3BrYnhOMmEvZHlqNklvRmM1ZzRZQUx2?=
 =?utf-8?B?Y2FJTGxvTjUrMkR0ZTg3WjRQUFg0M0ZzRUR0ZWJkWHlpSFhwbGNVQTV4WmZa?=
 =?utf-8?B?MWtqTXRxYlFiMmMzaGVLdmV1YzdQTXZKVEt2VFowanVFQjNGQ1BPWDd5MHBn?=
 =?utf-8?B?a1BPZVBuV1JYRUpPeVJDbXBuZkZreTVxOTltSGdvQUxtdzIvQjk1UVQwaC9h?=
 =?utf-8?B?RFFKU0xEMjVlUXFwdXB6UUdhdjJSRTJ5ZGlrMFA5eFVuRGI4cEs1cGNHS3hx?=
 =?utf-8?B?bHBWT2JRTURIRWxHVktTaFpwTmJPVG1uVDAvYXVicUJLRXpNQ1g3MUlNdUxm?=
 =?utf-8?B?SGZvVExJaWppWDR6ckQ4NUhQVHZnTEp0T0EvdXcyeEE0MXgvU0NDaVpDT1JZ?=
 =?utf-8?B?cVlZaU5iOHJ4QWlRUFBpUTJtSEQvTlZNeUhhQ0RKbzZlS2lkVkJucWZCNi9C?=
 =?utf-8?B?RmxxcDU0WkZjbDY0RzNTYW8wQUFsOXJNTHVvbWJGYld2NjEvTTR3QTY0ZUJn?=
 =?utf-8?B?TXhvZjZVckc0aWkzSy8vUXpMWXFJalFIdmxJZEdLU0dJbm5rdWtTOENpdy9Z?=
 =?utf-8?B?dXpKZWxzZDAwaHlnM1Y0aEp2Sk84SDB4RnFpbGdjRWxiMzJndng4d0plQkNs?=
 =?utf-8?B?OHJ0OWFsd2VpRW94d0xPb21VaEVlblNUUlNlNTErMm1COWNOODlTQitnMWFQ?=
 =?utf-8?B?UlRqamlnSU1mQ01tciswWVZsSDVRN3ZvalZmUWNBVnF0NVZXRTV5cSticVJK?=
 =?utf-8?B?cDZMRERFSWUyZ3VPKzB2eW85a3o4eWg0dHZiaitsYkh0b1Q4WFZPakZnYU1V?=
 =?utf-8?B?ZktDL0JpbXl2UHRocksva0RpU2R1TUt1WEpOVWlaNWFKaklhVFhhVkowZWZr?=
 =?utf-8?B?Q1owck5PbzIzSDFaSmsrSDdCemxpcVk3NUoxcHhYNmZGTDdkSVNuaVY4bVVh?=
 =?utf-8?B?TzY3UEVXUTE2QVhtTlU4dlZ6LzczckducUJDSW1rVUM0NjlST2svblZvQXFl?=
 =?utf-8?B?NVdrdVJiR21XeFo5TDFqOFlGSTZsUFhxdVA5K2NNaDU1VjdYbnNBSkFyWEpE?=
 =?utf-8?B?cVRjTDNhRmpTNjNVV1VpUDh0bk5oUXA0bStJVis4bE9JdFduVHEwK0owZE5y?=
 =?utf-8?B?dStGaVhOdUNnMFJvNFZmY2pDcm1oVVNjS253RjlaV3hoUngxSy9ReWFraE52?=
 =?utf-8?B?Rmc2V1VoV1BNTzg2OEJrMS9EUnBKckVlVkdyTVE0NFM2aW1JL2s3NWN5Tm84?=
 =?utf-8?B?cDFHcUo4SHdGTlp3bUlyNW5kajlnKzJsZ1dJMU1Ud2IwaDBkallwaWVma3Ax?=
 =?utf-8?B?alppelB5YUk0QWlIMzRmR3oxZEF1Z2R6R1BWNXUrUDg4Q1Y4dGJYODg3V3hQ?=
 =?utf-8?B?ZnlKZGg1VklqVXNsSllDNTJqWlRHd1pheEwyckVlR0swSTBYcTFxVHFzR0FZ?=
 =?utf-8?B?ZVpsVTdRZ2REZVlvcHlMbnFlTDg5QUJKSEJSOE5TSitUb3RYQ0FtL0VvVVpM?=
 =?utf-8?B?K29xU0RYeVplKzRQRHdsdHdTYlR6VnNxWTk3NWJCS2pmYkl2RDBYVElrV0hz?=
 =?utf-8?B?YjhUWFYyc1RsUHkwdURXVU9uL1lPaHZFbGpiN1ZmSzM1UGxpTHMvb2pZMHZo?=
 =?utf-8?B?eFk1SnljazI5TXFpZWhFY2czY2gyUC9KdDRrOHEvMTh6ZVRFdlB0ZXRpQjFX?=
 =?utf-8?B?WVJZcVg5VXI5bU8wYmtxS2ppVnZ6OFptR2tqSkZUaWExMitjODhrZ2hhWjFQ?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F1655E18CA723448F9C569328A6521C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ymgkUMhAh0gLpqI4+9q5PrHxmW4Kdc3WmgtsFURUsxdmqdCK5MXGwfEoACYtFEjIRIRA/FfTdnFF79gZK+r4fcqqGFmibSb7ras0t4L6oojASaloC+0b4I2KWvUHzyIZLjyh4KvY8Z1y33cOZnS0owFEWRv2CdGPSvES1ZirQ4Huq1g2H2VlrcgUCeXOrgEqhXtFhKyceEjwv5ZXt8Ji3GCTfJiBd+4Xr7G+ohjxGOTZrF0Y6hNy+mfS9oE/PHKZ5O8rz0z+zkEWpE2yYdJ4EZaujf7EykmiqHqNgwIfBVHMevx7/GEMO4Q7N5rLMJGMXgEVGQLHktfuhUkHBurW9mehhBzOnroEwCbb7WD7x3Xq8aIvE7JHb3+M9vZTJMhmrKm6ZgA0tKJify2MjPszOKdwcBeJyrWDliozE4MQMHCuTaml3S3Cn5ylTStBrkNLfs21e2xVvZ+rm94iZQoA3KuxCgo9MUSh1uQskGGYSWNV35g6B6GuGa4BV4YbB4Kt6sgdcHXHJtJsQpK/jFW7p80nCwpyLYK0uyxC+oVfcr1Y2nRRHfMQNiBlXi8e0Sl7C4nNdHt6g1IoZNcRKcc2q/MWN7Y90LghfVWx9RQz5CepZdc97+XNkJuxkoG7wTrm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11575097-a74d-4bbe-447f-08de12cf44a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 07:30:55.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFYslgOGKO29iXMD+TEMcNZ67A6NlSHpKlFAze+fgNOpWntWN5A8deFufqESwBaqFGd5X/wkfdVKLAjyp52Qq8mV1Esz4YXPeMwGMn6SL1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6714

T24gMTAvMjMvMjUgNjowMCBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gRnJvbTog
RmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+DQo+IFNldmVyYWwgb3B0aW1pemF0
aW9ucyB0byByZWR1Y2UgY3JpdGljYWwgc2VjdGlvbnMgZGVsaW1pdGVkIGJ5IGENCj4gc3BhY2Vf
aW5mbydzIHNwaW5sb2NrIGFuZCBzZXZlcmFsIGNsZWFudXBzIG1vc3RseSBhcnJvdW5kIHNwYWNl
DQo+IHJlc2VydmF0aW9uIGFuZCBmbHVzaGluZy4gRGV0YWlscyBpbiB0aGUgY2hhbmdlbG9ncy4N
Cj4NCg0KQXBhcnQgZnJvbSB0aGUgc21hbGwgbG9ja2luZyBxdWVzdGlvbnMgYW5kIGNvbW1pdCBs
b2cgZml4DQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPg0KDQo=

