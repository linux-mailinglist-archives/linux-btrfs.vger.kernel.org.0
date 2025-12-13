Return-Path: <linux-btrfs+bounces-19704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4629ACBA431
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 04:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A3C305936A
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 03:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7817227EFF7;
	Sat, 13 Dec 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SsCDtb1Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eawqZPPb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75213B7A3
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765596834; cv=fail; b=ejetAlL+VZQ5g4lffPIeaczffyDLmcqE0tdyL15/ew9mdoi8zDjWvrPOarB1A0uuFZnIntDuoVwEgisABIEz0CV8IECrAClbowQnFa4CKM3tANWiRQNpXUR4d3dx1eWGxp5h6N+AlH/Rfc/qLSCcipwTmqcSeN3maxpAi57jVQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765596834; c=relaxed/simple;
	bh=mJtTYQ9IHF37U5eYaGa/8ioEeQqPLREtf/jNm6aIeAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hX7pkYq5S3+Ht/VULs8PI7A64j2fHBRV02o58MJ05IdwfY5yjczfNZa7JVrRFwZUTFJmJxWc4eSJXF0hO8IF0PT/OfhInvZgtrpk7fbWJt+oivTNwJxWUCsv2hR5w1+WR3iHnoKx9skWPkRdqK6D0WASKeb1N40Bd+OZ4diPhrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SsCDtb1Q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eawqZPPb; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765596832; x=1797132832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mJtTYQ9IHF37U5eYaGa/8ioEeQqPLREtf/jNm6aIeAQ=;
  b=SsCDtb1QUSJ909tiX2AJoaiiurdEk9bJaGsrKX+R9eV1DM9Rcw+Wq0Ed
   Hd5MBTsuNdFd3dYDcIzlE+OHZdGTWco7+fv5Cx8kk7iYqxeLRUjokBVXu
   9VcmrCTz5rjUB9IC6VlWUXtX5PSDzkdw4vniN08HWcs16sOQCEoIXdOhK
   QL4lBnUUNf3IRI+CnYI2HqFvZ+9zBK5iWdr1fKJ2Yqn6L3bZwF5T+YhtZ
   0SByfFo2MWj1pLV0UxVvs8JbvxOS+zubzeQyCzbZc7oIhhuj7WjZWD2UT
   cHpt7MkYstCsKq5f8wkOdSTWWD5Jy4BVxGiqAi+v1hyOpwZZMWvYSNdox
   Q==;
X-CSE-ConnectionGUID: 1U8nJWAoTwSsYpSIlc/RNA==
X-CSE-MsgGUID: HfLcHGHaTcG7WuY8Vl9CrA==
X-IronPort-AV: E=Sophos;i="6.21,145,1763395200"; 
   d="scan'208";a="136983851"
Received: from mail-westus3azon11010045.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2025 11:33:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUzn7/ogxvEw28W2KlyP9FXR4tsgdu3tUlO5NCHFJEbWGcSZEBpYcIC9Kxoel/4e7drWwz5JN76+nOw3xKNVy8K0h7803fZVErMmhF/8+xttWp0TJ0nLxuY1ogP0JOL77AaOJrb7Hihk1irkzfVxr56X/8kbDdJe1EKSe9Z37+9FpKiRoYl/MoDF9CfSA2x0fbofodOUSd/t0aR1s5Tm9noj1jHgpaSqT0BVtgg7vkHGXm90ieApHKv4OaU9DZLHsVtWapP19U4dXBBnf8x30YggnIOzMU6dAxB7qK6cDQKugAUoEcrFJq/qnCwW+oYgdaStt6DUGKrvAupy0aFYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJtTYQ9IHF37U5eYaGa/8ioEeQqPLREtf/jNm6aIeAQ=;
 b=XZ1deEqTIoHel3C6GTmX/ZyHmUFoYjAihWTlUsA769BsrneqKMJATMZJo4zh5ST+6T3999BSPfafxyNuMkObVEWgKR6nspqx5bzwpv5Pb0hXgTY1L2OfCEibGf31e7OimPvpd4KrVyToJEJVeS/mUUL0zXKaOh40o3LsAO3ZYyquPGxG2v2dPxRsJ0HZhSsNK0PcuFr6UG/XPjwbHS0z3j50H8Pfn0MQlJ+7tYdRSOhmhzqPbeJe7CWBbzZkVNfa9sxGObdUp/1mphmT4XPqOzJBZUAuipAlXmGHY6RggtIDTuWC8EbrYU/t1WtoaJkxte4vE0arUH8IPT3ebfgyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJtTYQ9IHF37U5eYaGa/8ioEeQqPLREtf/jNm6aIeAQ=;
 b=eawqZPPb6ejeRM7WPAOY3ntCi2t9g/LwoKW15cnWS3df91mAAPT9HaEwhWGV+M3iYtEyi0+awIHtow4psDOd9cu7jiJg4YvrBokRKq3N1dDhATcjFfLjw5ag03mb154E/Kb+dbKRaTDPhIQwbLt3P728MkJxp23wKkcMk6TIR7Y=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DS0PR04MB9486.namprd04.prod.outlook.com (2603:10b6:8:1f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 03:33:49 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.005; Sat, 13 Dec 2025
 03:33:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v3 1/4] btrfs: zoned: move zoned stats to mountstats
Thread-Topic: [PATCH v3 1/4] btrfs: zoned: move zoned stats to mountstats
Thread-Index: AQHcazZh8IoECohANEGSZuFKQ43D0bUdv8aAgAEsYgA=
Date: Sat, 13 Dec 2025 03:33:49 +0000
Message-ID: <847e76d6-fc1a-434e-85ef-b6887f426934@wdc.com>
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
 <20251212071000.135950-2-johannes.thumshirn@wdc.com>
 <CAL3q7H5xbK_XXwNe8G+JHEmgbv2gcOU73sEqHFWFA+NCExiiaw@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5xbK_XXwNe8G+JHEmgbv2gcOU73sEqHFWFA+NCExiiaw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DS0PR04MB9486:EE_
x-ms-office365-filtering-correlation-id: 7defbe37-e988-4f80-4c54-08de39f86ded
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlNKbGMrQjhjS25sMzJHeS8zNGYvTWsrM1JTY0RtcGgvSHFlcG5JdldTWm5R?=
 =?utf-8?B?WkRPN0FoWkxMQisvTXY2c1ZmYkdlSmkwN1U2VXRXYXVqeXE4TkE1ak1GUkV0?=
 =?utf-8?B?QVZ4dno4cmRsemcxUklQTW9XMGZIMGlISjVlUlJhaFFRM3VMOTh4ZkZzQkFF?=
 =?utf-8?B?SFp2ZnFnLytEdHhEVWFjaG8vWXFYOGRucmpBQWg5VzRzSURzYngrZS9mdFYw?=
 =?utf-8?B?VDFYN1ZIM3hmeXJVNkdDczB6YVlQZ1FMZTRyVnZ4TkhzS1I3UCtkRXNVMUhX?=
 =?utf-8?B?d0lGQWQrdUQxRnBMYVJDbVNBdGRTNUw0NWFZc1E5R0JCT1RXamczajZEMEhs?=
 =?utf-8?B?enUrazFVYTVvdk5tTjJrbmlNNEZjRVBDcXpSdzlvVVhQbmhHV2ticDNpcXJX?=
 =?utf-8?B?Ujh1Q0RUdGdHRzk1Y0paa2cvaXRwazdWLzlrMUUyQXQzaGR4blhWL2ZMOVRx?=
 =?utf-8?B?TlBrcnJ2RC80dDVVMmJMUlF4MllkcGlvcEdPN0YzZzIzaUdsK1dDNHF6dG5t?=
 =?utf-8?B?aDJVUDRFZ29HVmRqSC90UlBhcHN3SzM2QThGTHZmUkFldm5JVkd0YUttZHZr?=
 =?utf-8?B?L2diMHN1TDlTWkpRamsxOEd3YXcvK2lSckhjRnRKMUlTTmdCbFlvc21uS2k1?=
 =?utf-8?B?NmJJUThDQTViSjVMYStQWVN4akhyOE5PbzQvYVl6MkFhb3QvK2J4OFdQRFFh?=
 =?utf-8?B?RE1iaXZSaFo1eERCaCs2OXNNN1dTd3FFY2kwNDlidDFsaSt6V05rMSttWXhW?=
 =?utf-8?B?eDU0Rmt2R0dmRURMaU9IWFh6cDA0Mml1dy8wT0V6Tks0bjVOY3RzSGpMalQ5?=
 =?utf-8?B?Tm14NythUndBSjJTY0dmcFJWNE4yNWRKUE5KMHVjQ2phaGFyUjRadlJsbGc3?=
 =?utf-8?B?dXcyVUlGNURaR0phdHFISHppK1paaHVxY0dMdlVESHR4bzRoUTE1ODNGMzJP?=
 =?utf-8?B?Mjl0bFcwZFJQMS9PSDdmbThKL1Y2QmMzYTBZTmZJYm5rZW9iYXNOcXRjclpj?=
 =?utf-8?B?d1pkc0w4dXJvRiszeTlVTDJSNnpselh4L3gvaW9DNXIwQWVwaEFkZCtuVGJ6?=
 =?utf-8?B?ZlVGSEpQWVFhSjQyRk0zK216TVphWHNBMC81WURpbUswUHRJdzJYMGVOU0xQ?=
 =?utf-8?B?OG00OXlzK3dRWlpkQmhzR3RLZGx1WVZSbnZPejRUbERPREV6SEVNNzNsSmU1?=
 =?utf-8?B?TGxSaVZHcG5aMldJREV5UnBiRTJhblFoQitrWUpNYWhjaDZkTWNxVHprbGl6?=
 =?utf-8?B?QUswRVFnLzFTbGt0U05BMDFuZlJGOE8yQlFqTXFXYVRjUG5Ea3VaRHpmaWoy?=
 =?utf-8?B?RmlUa1cyNDVKQXRwUkJaTWJhb3Z3Tk1LalZYSmYvYlNBbWU4SDQ2emU3Yity?=
 =?utf-8?B?aFVCa0NYNzhqOE1WK3ovem1POE5Td2NBZzF2WnZSY29PTkNTa1VjUW1CZmlt?=
 =?utf-8?B?RWFwc2k1UTRtUWlUNEd5eCtZbW5wZXlib0RBQm1FZHdBOFNZZ0hzL0FVbytn?=
 =?utf-8?B?VlJ0SDVPeHNoNkN4WFExK0dLS2FPd2VBVzdQU0VSS1RLNEtuc25raE13V3k5?=
 =?utf-8?B?TkNTaEhMOFRKZ1FBUEFZRWxRUzdLS2pqa1ZsaUhINm1CM3kzM0VlSDFmb1dY?=
 =?utf-8?B?Uk1SVkZPZ0I3MHlpNDNiZGxqMk5xby95QTVUcXhwZjdMSE1pRE5kZUk2MGhR?=
 =?utf-8?B?eVhtdEpTYkVhVndjLzI0Zk82dFZGNXc4UGVzVFUydE5BNWl2Rzg3eGhUUTJl?=
 =?utf-8?B?WlBJS0YwRkZCck04dk9EdlRLZU5xNGo3R0JEWnQvYVEzL0EyVFVXT2FGbzZz?=
 =?utf-8?B?Ym4zMlVlSGdMei9lYkI3ZVA1alFTM3dDSjF4TXRJRXdYNjkzSGRBMyt6YWdH?=
 =?utf-8?B?eW1TL0pnNEtTZEoyNVJyRnFnakpQOUhIWVFPU0lmMEFRVGFsZkFJV21FYnor?=
 =?utf-8?B?Y0IzNDFuZnFhbXJ3T0U1ODc1ampOM2NGa1lYbmIyTEMrbU5XMDgzZXFtNjJz?=
 =?utf-8?B?SjQ5QUgwY2ppb0RSU1dEb2JzTmU4OVJqbUtvU1Y4ZTBBWWU1Z2JMcHBLeTNB?=
 =?utf-8?Q?mwznS2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2UvYVdaRzNuMkZIY1lkVEZGWTlMd3c1bjFsYkJLMXVKRnU1amlBSkdYdW1C?=
 =?utf-8?B?WUNXcnI0TVF6WW5BcndkOFk2SFZXM3AxcEpTWnBVZXZOSGhkQVhCZjNVSytU?=
 =?utf-8?B?TTkvbVVLU3JscEZyN0pnV0xVc05LUHdyNUtFUjVlSEt3cjlJb0luUUdpUGM0?=
 =?utf-8?B?UEFkNGplUkp1UTJqTUQrTTFueUFVRVQvamplUjZhZmRiVzBJWDFnV0xFY2Fp?=
 =?utf-8?B?Szc5VTNZMTVxUWQ3c2VxcmdCUG5RaGhWZ05ZRUhOcE1BdjJmUXJTZ3FsblB4?=
 =?utf-8?B?NnFwV3Z2a0E3bXlwcmtoVFFjc0M5S0ZQc1A1ZldOQkRHNlNIN2drcWUrK21R?=
 =?utf-8?B?MnFyR1Y2dmdJTDFoZWpnMXlKZU84K1dJaGtYbjZSOXdwbDBEam5XbW5HU2Q1?=
 =?utf-8?B?OWdpWEZwa1AxSGdGVnl1aC9JOTNXT3FHZ2JWMzJ5d0s2eTZZaGdYbGNLbzNt?=
 =?utf-8?B?dlkyL09SUWRmZVZFcHUwbkZQUUlzNzIzbUExR1ZSZE10KzhNOFRqNEs4VW9o?=
 =?utf-8?B?M3BnSDJHQUZoSWxRcENvaE1pTVFNdWFCaVpwVU5hZTFIOTZ3czVnWWdjMjJk?=
 =?utf-8?B?QS9IOExZVUtKT3dWR3BuNGxxais4RFB3M2tKVnNPbDh1cEltNW5ueGtKeHpa?=
 =?utf-8?B?VndQaE1ESy83dHNFWi9vS3ZCdkpBWU5KSUZuNDl4YWhya0tLSFUvQTdTTURz?=
 =?utf-8?B?Q3BuZGF5NzhUeWd4YW1za1FUSHRmb1RKRUh1eGZOekVVUmhqa0xnTUxVWEl2?=
 =?utf-8?B?cXRTdWJvaDJrb0haQW1JTjVUdXJLQ1N3VDFUWnFwbVVCK1FtQVhrc2lONVR5?=
 =?utf-8?B?ejlGR0grU29kOU9OK2o3TzQyalFQQjl3M2NrREVrVEVMQi9rU0lhaUd5MUtN?=
 =?utf-8?B?aXkwNW50ZkRyVVFUc09EU2EwK1Q1R2NrRDdvelExa3hrTnQzTFRzNkZXdFli?=
 =?utf-8?B?VEtiZHB6WGo0TkY0MXY3eWI0WFhjYW1UeUZEbCsyTnVadGVlR3FvN1FKQzRL?=
 =?utf-8?B?TmZxMEZMSTJGZE50Yzg2RStmZjloRlJSYkwxWnUrOE1mWGJFdVJlR0NZL2g4?=
 =?utf-8?B?Wk5Gek1RVjhQeUNEb0EyZFJVZjQyaFZWcUk1TVZqVFZ5RXRYTjNraGpJNzFS?=
 =?utf-8?B?S3p6ZjA3aUZQc1VBRFV2eDd5Nmgzckd4aTZyclExYXd0b3Q0Z01QZUVGNnJs?=
 =?utf-8?B?NzAzNkdGdmttanUrV0h5NU14U3NMandzZVNEaGxXdHc2dWVFR2dyaHpwNWsz?=
 =?utf-8?B?bTJYMEpyTE9ISkhHWHBDa1pyeEcyc05PSVdweGR5eWpNVytnNG9aK0lsVUtx?=
 =?utf-8?B?Q09DMFgrVC8yaXNuTzhPN2xPeHBrUStKTXpuS2RFYWE3QS92YmpVVE9JcEU5?=
 =?utf-8?B?VlRpaHZiK0hpenRyUnJHWWxXektTZzNzbG1iT1ljSFVFV2RoT01wU21DQ1BK?=
 =?utf-8?B?cDdZdGVTZW5QQ0lCL3gvaGdVSEhPUDJSVFkydXRCRnBxa0ZsZjlkV0JtR21L?=
 =?utf-8?B?Q3hXUXZQdzQ4V3EvdVA3RG9qQTBXWFhKNG9RbkVRNTlOeldxUVdhY0NyS3JN?=
 =?utf-8?B?ZGdLa3NUaXEyQzJMTWlYTFR6WnVhVXlKazZyRkJNQzBMdDR2TGtGdUhKRWh3?=
 =?utf-8?B?c0o2azdUOTRYYXd2M0VaR2JTK3hWTUtsZTZBemwvMW1uUkEwUnB6RkpuL0Y4?=
 =?utf-8?B?cEdPTGFWRmpBZFQyeTFhZGJnSTVrbkVoa1R1MlZ6V3BqWWhKM1ZxYTEyVDZK?=
 =?utf-8?B?VURCem5za1FGazNWUklVdFlzc0xvK3pqSWdjbWdXb2h2cDV3dllSNm1hS1NP?=
 =?utf-8?B?NGRqWE93dDlYYisvVGNJRVU0V1Z1SmVMM01GWXNmNGNLcXZRMWhoa3YzK1pu?=
 =?utf-8?B?YUhIVmN4dSt3ZzhFMFlaT3o0WmNSaWh2em1uZ2ZXVzVXUUZKU2tyck5YNjBR?=
 =?utf-8?B?TVRZeUlqbHZibWs0ZUFDV2N2bGQ4bThjVUZtSkpHL3c3NEhLOGd3Y2FHTzIz?=
 =?utf-8?B?bWdTRjBuYTl0a0JSTUdtQURmMXdRbk9BMXBwMXFWQTQ2WkNFOURtM09VM01z?=
 =?utf-8?B?NFJBc3crMHUxWTlOR3cvTnB1emtDaERSN0FqWUNxN1krQWY1ZTVpc1JGd0Rs?=
 =?utf-8?B?Mkg4L01UbDdIa3RWbCtvTCtZYXV6aWtEQ3VFTi9oaVJjZ2QzQ1hMV3hwVGtr?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CD1D7C633F7F1428F9E7D1F282A1C30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nHO5VbFWxTxJKEfBqKTxFqW968MQKaKDs9hjDVlXJsFRmBd/a6r6TK725yFvEd39SU6oXZUVnPmcSqc7GYPy//hNg0pESM7tqHjjgPqN0yDDXBz2TY10beRhYwKyA0ZWo7Rc2JPEoftjTHc42VnmN3lAEhd1eRWt03W8in1jtxiXhRz827LuYimyvmexBbwLVVY3Kj6uDOJBc5rcPNXjDc47Gj5E12Uc74NFA0vypOUFOwaPyUIcSzfbXT7v95c/H/5aDtY152CrqIICiRtT+5o8r6yUTb5ArW+FoJvlu1vz1WtQUfl5TTpHK0ROaOpw+Ydttx1byk3suoS0rANtlPykSy/SX/SdUAWZneZBcOHkDDE5hs6MYvxsiB+HIx+GUp9gIUYBg9FkdsCCJrbcOw6rYbt43vaz/wjQEXsZNsEbMGAaonzLDdeW0qAlqg/SP4BVlX1ZrmaTJ9vYZtAk8olcm42NHhD6wi5oZ/edRoz3TkW1XEHAS35JF+KOHD7TutH/sh+p9xsIqgFo1ZHY+1GR7eLmfMPkMiUl9XA8cBiebaxHGkCSgZS9PRWl5FKSVoZvoH4nNTk4JZmhOnMJ7n90YbQChcNQ8UNn5czU1PvNHnbwIPm8C6M9gwYF+u4f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7defbe37-e988-4f80-4c54-08de39f86ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2025 03:33:49.2033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TC0BX1y4S1cYsU3dU/QsdM4kREWeysyWZCA6cl51oU4CU3vbqI7NGX2BoScrKBiPqKPKNLA3fiJHLjA/2y25rY/v4n+eDJl5JIHJNP1XIcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9486

T24gMTIvMTIvMjUgMTA6MzkgQU0sIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+PiArdm9pZCBidHJm
c19zaG93X3pvbmVkX3N0YXRzKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBzdHJ1Y3Qg
c2VxX2ZpbGUgKnMpDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAg
KmJnOw0KPj4gKw0KPj4gKyAgICAgICBzZXFfcHV0cyhzLCAiXG4iKTsNCj4gV2h5IHRoZSBuZXds
aW5lIGlmIHdlIGhhdmVuJ3QgcHJpbnRlZCBhbnl0aGluZyB5ZXQ/DQoNCg0KQmVjYXVzZSB0aGUg
bGluZSBwcmludGVkIGJlZm9yZSBkb2Vzbid0IGhhdmUgb25lIGFuZCBpdCdsbCBsb29rIGxpa2Ug
dGhpczoNCg0KZGV2aWNlIC9kZXYvdmRhIG1vdW50ZWQgb24gL21udCB3aXRoIGZzdHlwZSBidHJm
c8KgIMKgIMKgIMKgYWN0aXZlIA0KYmxvY2stZ3JvdXBzOiA1Ng0KDQo+DQo+PiArDQo+PiArICAg
ICAgIHNwaW5fbG9jaygmZnNfaW5mby0+em9uZV9hY3RpdmVfYmdzX2xvY2spOw0KPj4gKyAgICAg
ICBzZXFfcHJpbnRmKHMsICJcdGFjdGl2ZSBibG9jay1ncm91cHM6ICV6dVxuIiwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9jb3VudF9ub2RlcygmZnNfaW5mby0+em9uZV9h
Y3RpdmVfYmdzKSk7DQo+PiArICAgICAgIHNwaW5fdW5sb2NrKCZmc19pbmZvLT56b25lX2FjdGl2
ZV9iZ3NfbG9jayk7DQo+PiArDQo+PiArICAgICAgIG11dGV4X2xvY2soJmZzX2luZm8tPnJlY2xh
aW1fYmdzX2xvY2spOw0KPj4gKyAgICAgICBzcGluX2xvY2soJmZzX2luZm8tPnVudXNlZF9iZ3Nf
bG9jayk7DQo+PiArICAgICAgIHNlcV9wcmludGYocywgIlx0ICByZWNsYWltYWJsZTogJXp1XG4i
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2NvdW50X25vZGVzKCZmc19p
bmZvLT5yZWNsYWltX2JncykpOw0KPj4gKyAgICAgICBzZXFfcHJpbnRmKHMsICJcdCAgdW51c2Vk
OiAlenVcbiIsIGxpc3RfY291bnRfbm9kZXMoJmZzX2luZm8tPnVudXNlZF9iZ3MpKTsNCj4+ICsg
ICAgICAgc3Bpbl91bmxvY2soJmZzX2luZm8tPnVudXNlZF9iZ3NfbG9jayk7DQo+PiArICAgICAg
IG11dGV4X3VubG9jaygmZnNfaW5mby0+cmVjbGFpbV9iZ3NfbG9jayk7DQo+PiArDQo+PiArICAg
ICAgIHNlcV9wcmludGYocywiXHQgIG5lZWQgcmVjbGFpbTogJXNcbiIsDQo+PiArICAgICAgICAg
ICAgICAgICAgc3RyX3RydWVfZmFsc2UoYnRyZnNfem9uZWRfc2hvdWxkX3JlY2xhaW0oZnNfaW5m
bykpKTsNCj4+ICsNCj4+ICsgICAgICAgaWYgKGZzX2luZm8tPmRhdGFfcmVsb2NfYmcpDQo+PiAr
ICAgICAgICAgICAgICAgc2VxX3ByaW50ZihzLCAiXHRkYXRhIHJlbG9jYXRpb24gYmxvY2stZ3Jv
dXA6ICVsbHVcbiIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZzX2luZm8t
PmRhdGFfcmVsb2NfYmcpOw0KPiBTaG91bGQgdGhpcyBiZSB1bmRlciBhIGNyaXRpY2FsIHNlY3Rp
b24gZGVsaW1pdGVkIGJ5IHRoZSBzcGlubG9jaw0KPiBmc19pbmZvLT5yZWxvY2F0aW9uX2JnX2xv
Y2s/DQoNCg0KSXQncyBvbmx5IGEgc25hcHNob3QsIEkgZG9uJ3QgdGhpbmsgaXQncyBuZWVkZWQg
aGVyZSwgYnV0IGEgZGF0YV9yYWNlKCkgDQphbm5vdGF0aW9uIHdvdWxkIGJlIG5lZWRlZCBvdGhl
cndpc2UgS0NTQU4gd2lsbCB5ZWxsLg0KDQo+DQo+PiArICAgICAgIGlmIChmc19pbmZvLT50cmVl
bG9nX2JnKQ0KPj4gKyAgICAgICAgICAgICAgIHNlcV9wcmludGYocywgIlx0dHJlZS1sb2cgYmxv
Y2stZ3JvdXA6ICVsbHVcbiIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZz
X2luZm8tPnRyZWVsb2dfYmcpOw0KPiBBbmQgdGhpcyBpbiBhIGNyaXRpY2FsIHNlY3Rpb24gZGVs
aW1pdGVkIGJ5IHRoZSBzcGlubG9jaw0KPiBmc19pbmZvLT50cmVlbG9nX2JnX2xvY2s/DQoNClNh
bWUsIHNlZSBhYm92ZS4NCg0KDQo+IEkgYWxzbyB3b25kZXIgd2h5IHRoZXJlIGFyZSBhbGwgdGhl
IHRhYnMgYW5kIHNwYWNlcyBhdCB0aGUgYmVnaW5uaW5nDQo+IG9mIGVhY2ggbGluZSB3aGVuIHdl
IGFyZSBub3QgbGlrZSBpbiBhIHN1YnNlY3Rpb24uDQoNCldlbGwgd2UgYXJlIGluIGEgc3Vic2Vj
dGlvbiBoZXJlLCB5b3UgaGF2ZSB0aGUgbnIgb2YgYWN0aXZlIGJncywgdGhlbiANCnRoZSBzdWJz
ZWN0aW9uIHdpdGggaG93IG1hbnkgb2YgdGhlbSBhcmUgcmVjbGFpbWFibGUsIGhvdyBtYW55IHVu
dXNlZCANCmFuZCBpZiB0aGUgRlMgbmVlZHMgcmVjbGFpbS4NCg0KVGhlbiB0aGVyZSdzIGEgcHJp
bnQgZm9yIGRhdGEgcmVsb2MgYW5kIHRyZWVsb2cgYW5kIGFmdGVyd2FyZHMgdGhlIGxpc3QgDQpv
ZiBhY3RpdmUgem9uZXMgYW5kIGFmdGVyd2FyZHMgcmVjbGFpbWFibGUgem9uZXMuDQoNCmRldmlj
ZSAvZGV2L3ZkYSBtb3VudGVkIG9uIC9tbnQgd2l0aCBmc3R5cGUgYnRyZnMNCiDCoCDCoCDCoCDC
oCBhY3RpdmUgYmxvY2stZ3JvdXBzOiA1Ng0KIMKgIMKgIMKgIMKgIMKgIHJlY2xhaW1hYmxlOiAw
DQogwqAgwqAgwqAgwqAgwqAgdW51c2VkOiAyDQogwqAgwqAgwqAgwqAgwqAgbmVlZCByZWNsYWlt
OiB0cnVlDQogwqAgwqAgwqAgwqAgZGF0YSByZWxvY2F0aW9uIGJsb2NrLWdyb3VwOiAyNjAzODIz
OTIzMg0KIMKgIMKgIMKgIMKgIGFjdGl2ZSB6b25lczoNCiDCoCDCoCDCoCDCoCDCoCBzdGFydDog
MTYxMDYxMjczNiwgd3A6IDEyNjE1NjggdXNlZDogMTYzODQsIHJlc2VydmVkOiAxNjM4NCwgDQp1
bnVzYWJsZTogMTIyODgwMCAoU1lTVEVNKQ0KIMKgIMKgIMKgIMKgIMKgIHN0YXJ0OiAyMTQ3NDgz
NjQ4LCB3cDogNTU0NDM0NTYgdXNlZDogMTY4MjYzNjgsIHJlc2VydmVkOiANCjY1NTM2LCB1bnVz
YWJsZTogMzg1NTE1NTIgKE1FVEFEQVRBKQ0KIMKgIMKgIMKgIMKgIMKgIHN0YXJ0OiA0Mjk0OTY3
Mjk2LCB3cDogMjY4NDM1NDU2IHVzZWQ6IDI2ODQzNTQ1NiwgcmVzZXJ2ZWQ6IA0KMCwgdW51c2Fi
bGU6IDAgKERBVEEpDQogwqAgwqAgwqAgwqAgwqAgc3RhcnQ6IDQ1NjM0MDI3NTIsIHdwOiAyNjg0
MzU0NTYgdXNlZDogMjY4NDM1NDU2LCByZXNlcnZlZDogDQowLCB1bnVzYWJsZTogMCAoREFUQSkN
CiDCoCDCoCDCoCDCoCDCoCBzdGFydDogNDgzMTgzODIwOCwgd3A6IDI2ODQzNTQ1NiB1c2VkOiAy
Njg0MzU0NTYsIHJlc2VydmVkOiANCjAsIHVudXNhYmxlOiAwIChEQVRBKQ0KIMKgIMKgIMKgIMKg
IMKgIHN0YXJ0OiA1MTAwMjczNjY0LCB3cDogMjY4NDM1NDU2IHVzZWQ6IDI2ODQzNTQ1NiwgcmVz
ZXJ2ZWQ6IA0KMCwgdW51c2FibGU6IDAgKERBVEEpDQogwqAgwqAgwqAgwqAgwqAgc3RhcnQ6IDUz
Njg3MDkxMjAsIHdwOiAyNjg0MzU0NTYgdXNlZDogMjY4NDM1NDU2LCByZXNlcnZlZDogDQowLCB1
bnVzYWJsZTogMCAoREFUQSkNCiDCoCDCoCDCoCDCoCDCoCBzdGFydDogNTYzNzE0NDU3Niwgd3A6
IDI2ODQzNTQ1NiB1c2VkOiAyNjg0MzU0NTYsIHJlc2VydmVkOiANCjAsIHVudXNhYmxlOiAwIChE
QVRBKQ0KIMKgIMKgIMKgIMKgIMKgIC4uLg0K

