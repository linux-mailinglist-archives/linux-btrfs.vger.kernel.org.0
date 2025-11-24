Return-Path: <linux-btrfs+bounces-19282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E0CC7F233
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 08:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 889DF34353F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F422882B6;
	Mon, 24 Nov 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SJpKtAH7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qqwL7cx5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16313B7A3
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967653; cv=fail; b=uKovIEGCjmSemeiu1oNAmFrJuknRJciTvelp9+Uieyk6AidOUQh95pT6NgLWsm91FTVs5RGmQkPBh+w3O6YevFlLPRBOmfqlTEVkGh8gUfPQp2Ivg934bL+79LBtQLC0dPaK1zV/gpvRvVIvmyrV53rzfUj4e0TKTLCqUNq213o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967653; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWq7g74pn0yOI+MKOnjp5R9YhYu+yHgPzMtR3TkAdTb9HfC+FlM6aI05fupoSGE/aI0QdQXmFe10GsIRFddqSnuf7U7ZdNZeumS7SyMktHvxEJs6OcnA6Im7Vvmf/B0pJ/L0BtE4Y2/NOWF1q3KQFmM9UjdPl9pg6tCmWiiq3gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SJpKtAH7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qqwL7cx5; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763967651; x=1795503651;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=SJpKtAH7xPEMaEjFH6OXcAfwbpFIVxAwHBh+lrG+4FBygX+AOgV+7oSj
   FMo8mUfhX4zC128KAuu1/4RC6SPvlxDJmTguxExkkRp5Ltkk3gxL1MrsZ
   QRKGZM1QVYlXVbvjA9pUEk+4lZVdjGaeuiwCMHZJmLGl+E9rkFy7SQi4b
   W+4XBSLO8sA6kjrA3Jt/G0JaL11RPYzN6OBg7LDnJLfIRvecnobZziPVl
   OBaTrHMtjukoJE4hypmKO5lSLVZme5O11ii1nLCTFNsmitjNEqe7kcJWO
   H9y/5Hw1TvCK6d1Bv6T6oMsByBJc9lGQ78q/Qe5sbexLblucIUvr8Rnpd
   w==;
X-CSE-ConnectionGUID: lpGbgE2kRIiR3wWATd2vjQ==
X-CSE-MsgGUID: 40sq50ZhTVi3rZHe01gpNA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="135667224"
Received: from mail-northcentralusazon11010070.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.70])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 15:00:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCTU6UNvc2a6BuOjcgbhOQMLG3buJnzRxcjhQsOTl0UUtgNqZEhfDsdclzeJFqT7lymK50ajdBrZl0sS6yc66UgOoojHdF0O5WNUXSm0dDwWKT4DnaswxBgBCzRMcKMbjJ9gggfmJ9DoJNX2FlMh1cYSlEeT0Xl8IhfQ8B1guMR9P8AbdUeb2+d4bQUJQhz+M9FIkdaugbifGxCxTsByTuNf+MznunH724pNv/0OMsy25kIp2RNu3L5VGIj36I9MYfUjSgWs2K7Yw94aFn5Ro/bWoG5pmNOoEvQDurqcEw8lUeffEp4QhiVmFl6Pt+B6WhviwiTh5RVt00bwsmTxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=JxZXvebjR2LWh67dNbmxFZk99YGbiIkKicy5R8Kn3vwJk3S0WMbBysW3UQKfTD9fymmD++mNSK47nKUZuLF57IF7pRyVXP2KiNosFZLfppIheXa5ncjX1k3w8N1/jUrBaZzopXYASdJAG826VdEUfO9lILBVjVSuFomSAnZEJJcpcGozPoDwwvNtFFFwOuVrym7tFwEASwlNA6WwGUoZNUjxXub6YvXh/vdW4SpNWSbI/ZzgQaXO4QyHCAdbi5sCFbJaWh7RRXEu4infpibA588GswLDu35w9Rb93RTIrn5CHjELKonTpCgxqzl1DBkPhlMuBCw2Fljlgw0y6j35bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=qqwL7cx5owqz04YT4OVq2m7wqCljQQv1bDmfr6U97TTyaSrbeHy5mwsJe2mdEnXw3yS9TtzFLVfZg5hg3Nr4OaPCfbpSgfEmJmCZZN5sPfterqNhQA6Jiicjf1f05v+Ak1o4nDtJ7HAqOpeBLIlUjqr2RNtQJ2jldkI5XAPVZwU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB8513.namprd04.prod.outlook.com (2603:10b6:a03:4e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 07:00:43 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 07:00:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove redundant zero/NULL initializations in
 btrfs_alloc_root()
Thread-Topic: [PATCH] btrfs: remove redundant zero/NULL initializations in
 btrfs_alloc_root()
Thread-Index: AQHcWwBayTzK1W5xLEyZv8h5AsdbD7UBahcA
Date: Mon, 24 Nov 2025 07:00:43 +0000
Message-ID: <e10a8fa3-ea0e-4b4e-bcaa-9072fb6e2fd7@wdc.com>
References:
 <b35e6981136cd8066b56ba97e99e531e9621a84d.1763740870.git.fdmanana@suse.com>
In-Reply-To:
 <b35e6981136cd8066b56ba97e99e531e9621a84d.1763740870.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB8513:EE_
x-ms-office365-filtering-correlation-id: 298edce8-ab70-4cb0-c7d4-08de2b272f63
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkMwSjVmYWhBNEhuNlNlTVp2SEEzUGIwM3JLZVArcitmdndGdDZkcUZnTUd0?=
 =?utf-8?B?dDNSMjkxZjF0VlNRUG5Ga3Q2SzJ0b2dQVVQ3c1NqcjlQYmN6akpsemYxNlYz?=
 =?utf-8?B?dmlOZ1hwaVdPTUg0dFROWXAyclVVSWg5MC83Sit5UVREMXVjcitOVWJWaVho?=
 =?utf-8?B?bkNwc1RFbU1YSE96YTJpVkppUEFJWHBBKzIrbnlyMWZQdzNPVzArYklJMXkz?=
 =?utf-8?B?TFBSSXlncjVpaDF2ZnBiNkJDUEVEaTAySUpMVCtBNEg1eHJMR0xlZU9VcXA4?=
 =?utf-8?B?dFFxZUlCL1pQTk1tTDlEUGVvSkRwbWlYd0t4SllvZFNTaENDVThSRDQ1clFk?=
 =?utf-8?B?ZEFrVjcxUCtHUkZ3dHk4eW4wRUhQTThySStoKzFVZ2N3YWlQSTdURUp6dGhM?=
 =?utf-8?B?TW1PL1dWcmgvRXI2YTE5b2RaZTU2dVdwa1lkWXBiSW5yMHNrR0VXU3pvZERO?=
 =?utf-8?B?ai9BdUdha1k1SVVuaUdvRWZNYzNPOTcvWjNERnVCMXpqb3A4Nkg3QmQwaW02?=
 =?utf-8?B?bEdCcGhyeTY3bEtHSHNzYWduZmZObmZSZDlpMnBJYXNmcU83elpmY2dLbGUr?=
 =?utf-8?B?cWZvOVhJNVI2a1FPUzNNVXFSSzhEbWc3anFHamdWSHNHUmhyTUpPMU9WOU10?=
 =?utf-8?B?a0J5eW9rN3pHcG40TmQzWjQ1SE05VU00QlByaUQ3RjVvbjEwU1pkdTdpeUJ1?=
 =?utf-8?B?UUU0dGNCOE5vTUk1bXA2YmU0ZVpGV1RaNUVFdjdad3VDTFBpdXIxTTR1OWV1?=
 =?utf-8?B?VG1ldEFoN1BiTUhrQi9VY3VxKzZrNlVRZFBNU00vNk1TMHo0UXYrR1I0dENh?=
 =?utf-8?B?ekppc3NxQXo3SjFEVmZuTUlIc1VjYS9pZ0Z2NThDRmtXMHRLUVpFT2FSRUhs?=
 =?utf-8?B?ZXdYWVR0blh6clFVdlBBaDJpd3YrQk5meklYOEhoNmpNaEdwc3Jjb2hsMDIw?=
 =?utf-8?B?VWcrdENlTTRPQmkyTXhKVFc3RlFlaHhMVVZFYUk3eHNZb1VTNnN0RU5Od1RK?=
 =?utf-8?B?RzBWUStIbmtpKzFzaUdUeVoxM05WN0pYU2ZrcHVGWndNVDJidnIraWVnSHFT?=
 =?utf-8?B?UHMzeTdrMjVJRlNFQ0dvYVpBUFVlVDl0R2dlQkxzSUpwSE90WjhSZ2ZnSjhj?=
 =?utf-8?B?aS9rNkZoTkp1S2NuMWUyY0NYMkQ1dHQyTkpyUWZMbmF2WHlhUkcwb0tTNzE4?=
 =?utf-8?B?amVNb2hmdFQzandMbFhKY3VZem0zMmhOZy85UExsNlZVMDlLRE1ueWd2S0ZT?=
 =?utf-8?B?SXRCZW1pd3FYZjJLb3NienlZSC9CQ0lSUjVheDVmVHl6b1ZyN0hoSjM2UGRa?=
 =?utf-8?B?amdpK2c5ZzgrSXo3VjYxaVY0S056a29yMHFnaG9QVjJCQlozSmJrNjRoWmlr?=
 =?utf-8?B?K3hobDQzNU9vWVN0L1JaV2d0Z21xRzhod0RreGxwT3ZjZ0ZFanA4OGxFYXlC?=
 =?utf-8?B?SmtkaDV2RXRvWUorVW0xTy9nL21xMlNBM2ZQVys4OGtSbXcrcVF3bHE5R2Nj?=
 =?utf-8?B?ZGdhRTBESU1ZT1d6cTFGWUpYU1NuSnVnbjdGMTRMUXBuUVRuVDdianlGaGxP?=
 =?utf-8?B?OE94NlhzVVpSeWM0TWhBZU5MSUV4SVhlZjdadE9hZm5xL0FpZ01KSU9wRXJT?=
 =?utf-8?B?ZHBUMlYvUS85eXdGY1Jmdzd3d3QzMjZyalF5SGtUdmFWOTZRN0lmckZEWWNa?=
 =?utf-8?B?dkd3U3EzVWh2VGcvWnJFZWNhWGc5VnVkRURUMC9Qa1hnSnhTeXF3NjVoT0lN?=
 =?utf-8?B?UGptRjdCQXJZdExZWXQ4TlJvRU9HaE10Y1J0bHhJVGJZVGFaRXpsandxUGJa?=
 =?utf-8?B?eGZSMWRrd0M1UWdEc1lTSHlKRDIwcEc3MjFnekRIcmJaMDJtRk5hWDg1QWNS?=
 =?utf-8?B?bXRIWlJCNlpDWVRXOTVqaE5IU0pNQ09FN2RuV3ZBc1ZLaGpoNVFUb3N2Z0dt?=
 =?utf-8?B?Wk5GM09yTjhZRW04MUJTQTR3RDR3VEg3Y095cWRpTjA1U0h4NXRlY1R1b21r?=
 =?utf-8?B?WkhWSnVJTW9ST003d0VWUmZxa1RLcjJpcmU1YldZSFhJR29CRlBnK2JlNlYx?=
 =?utf-8?Q?yXqFBj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzVVd0hLR1QzM01NKzdlOG5OZi8rVUwrWGMwSWZ1Mzd5VXc1M1liSGpTVEcw?=
 =?utf-8?B?eHdIa0x2ckEwb2VYVHp1UUtLbmExWnZlOVdLR0pUTTJ1Z3Z6RDVtTkMwVWQv?=
 =?utf-8?B?ODBpVHZKRnF0dzYvNDJXeUpZdTdzWm9WTGI5bmZ3ekFTRUVYSUdSRlVsaEhl?=
 =?utf-8?B?enBVZ2RmbGRlTDg2Y2g1d3ZqS2lSclV1TlFpMHRMZGFXUFJramRGQVdJY2NT?=
 =?utf-8?B?bnI2U2l6ZDVGaElvSWlJV1ZiNEpOZUhqUkFiQ0UvSi96K29od0tHMEY5NWd4?=
 =?utf-8?B?dkNtK0tBYitDMEY5OEh0NHZ6MFllUXpZUFd0VlUvTDVXYk5EMnRsTFptVzdN?=
 =?utf-8?B?eVVORTNaVzUxdUlmUU5qM2R2dUx2d0NCZkNNS2gwT0o1Q2xXSWpJZElWaEJR?=
 =?utf-8?B?YWdULzI2ZThEUm1DcGJtd25tYU1wZU80akQ1eUQ0cUc0d01Hc01HYUF1M3F3?=
 =?utf-8?B?RFZaVmFNZVlYeGtJNThVWkNPRFVVbHUzeUIrd0MrZ1R6MElNUjNLcTVQVWNt?=
 =?utf-8?B?d1JPaWI1WGNqUTg5UzRCbm1TSFpHeHk2YVJ1UUNyYXBhZXhucU9ZSmxYL0pH?=
 =?utf-8?B?VFlUWDc1Q1BPSnhRNXE1ZnhCUGZzTlFGRk00TTYrRXFsN3E5TlFjeENOdzFh?=
 =?utf-8?B?RW9Nd01qK0FNVmxDSTZ1QjlKazJETnBrcy9KQmVrTXg5d2VVSmRzVm1ZS01z?=
 =?utf-8?B?ZlNLOFdvUVNWNmdCMzNjN092T3NFQ3ZKNU40ZDh6RVZVSXlvaVd2YU0yMGVa?=
 =?utf-8?B?UWRzUExuYmU5K01uNllCczBDRytWMENlUXBlNVBBTFcreXJHSDNjS1BQc0JJ?=
 =?utf-8?B?YU5ITHdQZHNiNmVxTi8wMHBjSWJPYTkyYk00M1MxK0hGdzFNU0ltdWd1MzYy?=
 =?utf-8?B?eCtJaEtpWHJvMEhPdVVLMzZkZXFDWWQvM2pZTlVpYkh5YVVFcE1zV1JFaFpu?=
 =?utf-8?B?MmdVeEFIaVo4WUoyTXZkYjBPMk5LdnRNZXdyZTlQUDdrYWR6YVJaNmJvUTdW?=
 =?utf-8?B?QmhLRXJBVDBEVWxMZFF2L0hTbk01bnhLYUpoaUp6Y1dveHZnWFRYRVNYTTVS?=
 =?utf-8?B?NWpvKzd4MWRMN3FDRHBkY0gzZEo5d0VxVUVoNlZabkVqaFFXenhCeDl1ZElZ?=
 =?utf-8?B?T252ZjlEaDJyZVFITnk0TUVuV0FzdXNuWW1WNWdGTCtBUzg0dmc2bFJKeW1X?=
 =?utf-8?B?dksySGJJYzBIYXdnK0Jjb3U0S1hYeEpRNWoxRXlNYkQ1eGJ6U3lmdHZVWWNl?=
 =?utf-8?B?UUZzbmVJOTRCRGV5WnBDVmpZaEIrS1JrZjVFTmZXUXlzVjdaUDBxMHZid2c3?=
 =?utf-8?B?a1Z0TW1PRkdXZGxVWmZ6eE8vbklXaGsxd055T2tNS2V1LzVwTTBBTUFuZUJt?=
 =?utf-8?B?ZHlad2cvUmZsUVQ3c1VIVXJlc0xJclp0b2Z1SFcvVVJRV09jUXAvOHN3Ujhi?=
 =?utf-8?B?Z2gzZ3I5TVVOMDVKaGtNaGYyL29ndFIwZlp5MWlSN1g3Vy81bDA3ZUZ0aERv?=
 =?utf-8?B?OW1XeEp5WlpPQis5bjhKVHJ6eTZTb2JMOVFVaHNTSlMzV2RMNVROTXYrNEVu?=
 =?utf-8?B?endwM1NxMkk1dFdYTkFWbVh0cVlwZlBOZnErM0M3bkoxbHlMNjBSZXI1RThS?=
 =?utf-8?B?VUNKUG1wSW1jVkNQU002U2FBUk9acTd1ZWFtUDRtdjBCaEFmTU5LQTZtUitY?=
 =?utf-8?B?cUI4OTJSblpXUWNPWElWZ0lmaGlHc2RrdFJ2ZUR0VjhMcGtsSDNkSHl2MkRi?=
 =?utf-8?B?bXdhYmZjdkMxckg1V2hJcVVTekFYZFdtZjhFaTAwK2wramJja1hNMFNzNGMw?=
 =?utf-8?B?bytNUXdvTXA5UEVvdGhCR1JWM3ZKY2ppWHNxais4YnpVWGJYYzVCR1hNWUUx?=
 =?utf-8?B?MHlMWTRtckdFeWV2c281VFRNZDRuYlVtQk9BWUdBeTBiQjlwVU1mcG15bXdB?=
 =?utf-8?B?VXB6b0JLTFEveTNBMVpQem9IejBnT3pWaElHb3UrWWx6NzZadElGcFVlQm41?=
 =?utf-8?B?Smc1YVNDV1FQb0tWUWk5TXBHT3gxQ0R2bk05OWZtbys5dE8ybWMxMm9kbW9n?=
 =?utf-8?B?ZUZtWDd2T0hjS29YWTB2bElZTFB0bEJxdk9uZ2ViRnZ3eHJldXhvRWFyemly?=
 =?utf-8?B?TmFRbC92cEdhenFSQkhkWWRqa29wZDRObk0wUDI2T01lSlpWM0hydnBBMVg3?=
 =?utf-8?B?SlBTMVQzbEs4Rldxd0lyUmJwWDZOVGd4ZTFZZlFYbGYzOUFjc3VKWDA2dDE3?=
 =?utf-8?B?eHB0SWxNVGhLSDRJdEU1OG05SVZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4A24739B90E404EA08F1C2F706EFC92@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4d8BRnkzyjCshRuEEESCy543gRrywlu5FkoKUpmdrNFQCIgG4UcEMKloEoYwanGoYG28GeHDzSLk6bv+rYknqDdeZGtn8m5bbN8TtLUKInS7Dn8JQ4de+rWMbpn9hnR8syMNMlZU+NUflRu6Pskoh80Nok576HBtN3hZ+losEdQjoHmG2GvAfHgZm4wW/zjJuvryPEZdh4Bqkf67VMxj2jhFiclOEdYuGV99anUtRe34H1uJn5pJjv627MX9dPG75jTLe12YEcl5xx2IjRvGcXSO+p5hy3IoS64Ao+Yj7JRiD/KMeBXn/2QNFy1RvfQzgU3G6IMlN3srha8tofDEuuLa1AXOkpjanT6Lp5EQYviPXL0eqhumSgZ9cvvWpDMiMYVdExDPfwtDS5Yk0JtdB/M8AwTyOzu4hI/FFrn7j8NOfW3E6oUhwSdBpCFwFPW3B6LN97ag1Wz5FhHrwc+jJ84yYifXmR+zZE0eFcrzb5amFV5remmhhva/jfSOYizZzl5Kbvg8YX8tAQcxRrNiipmKNvl73TrgjHcrGfUGgNRzGN+7RD7v5Pt8fnoMiZELYBuyHSSSTG+ejF+B3QQ+HN36IlhfIwa0ff0v/+0khhtKQPL7I7bY6VrfrjSsxv0+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298edce8-ab70-4cb0-c7d4-08de2b272f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 07:00:43.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4ZI3fmshY2Mo83XTt7ZgB4HZXN0nqeTImRYm8CSUVnhZb9XawYNf+9rIjqLj0cdVzMgxm/scY3ucjctVd/+/kvLy7SsqmcNny+xmlO2Fic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8513

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

