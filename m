Return-Path: <linux-btrfs+bounces-19770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BEFCC141D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3474F306F4A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7F33859E;
	Tue, 16 Dec 2025 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AfN+guXv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Trdovmep"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D926F2BD
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868529; cv=fail; b=KQG6RU9rNMBoWsrWxAYplvbdNWYjTlL4Gd/ygp9md8PDdZ+4huzqzsTbA1X2UD1S3OnSwN7PfYvWIYRIR1y0LKc9SCPz8bpNo7RVs6peaRw07TwXzRkawH8XReWLp1dFRVrlWShtPYvlCNiiyx1ZPSfk1aJyxbV9qBSRsuAHdvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868529; c=relaxed/simple;
	bh=Ika5R14q/XIoIj48wmW956ytnJtw9W7QD1EmEYRzDZE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jmiILLSLgNT8yurIwaahU+0rYkQMS0klDE9w10hAoUC5k6yekSqp3yLhydqG0/a0jqRP+52NHzpSNfFaMxQ03qy5g2TJ4Y2WOjz5f+257ZZsCPAcYg+Fd9f09QC3eVgwjmcooTLj3IQS1/TPq8LcRbiKEX3VE5atUG5lyeiTotw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=fail smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AfN+guXv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Trdovmep; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765868527; x=1797404527;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ika5R14q/XIoIj48wmW956ytnJtw9W7QD1EmEYRzDZE=;
  b=AfN+guXvYb4FNc7JJTEyRn6djMwSWFRqMtmGMYnh+Zw2BEzcTK5LiNep
   ZPxiocQwWgJ8jAgCIpyUYftf/4+TYvgKFj1QymonY5tRL5Yl9hrseOX+H
   lzzkVeEyEYbFtX/I98wwwb8OdjlepC8b0wXbKPyQqcugQfbGiOwWrZJj/
   Lh1usuHIplcxbMoCLxE3kj693ADJpgnfCfis4y6XcaP+KPc0shdPMp3yK
   diw90/YBoOLT51hZT0MBxU2kGZXcE+sn9LQqgCrAA7E3CeACLLFt+R1hI
   jbd30EVYN9BSSwWh3Wyx1FZD1Ahzsh04x8Ljd1WjiAR7sbxKhTkKcD+L4
   g==;
X-CSE-ConnectionGUID: C7IEW/z9RA+IStMsv3uh3A==
X-CSE-MsgGUID: WOc3qFMAS3e02f91ICKBXQ==
X-IronPort-AV: E=Sophos;i="6.21,152,1763395200"; 
   d="scan'208";a="133939606"
Received: from mail-westus2azon11012001.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.1])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2025 15:01:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqkcClnko5iEyyrk0Ny6tYh57JEXXcrvlFpSOTlXEI/GgbhOfR7YmG9VxqZ1ICnRbFT6pp0px3pGFyWsVYKNwpDpgwygPJDH9Fb8mPzG7KMrk29igOskdGDh3ZcErq7rYp52GgodcLo9xAesdimNnXJBNAQnexPPY7/tveDtulkPzWrT3pBmpy5mQ+GCmlNzka64YoYL/T4NG9jN8Zj58ntJLVW5K1oOJZ6vhGN3eYTw5qjJMpJTJA5wx1qXG+NsI3R5OX0v+S4/rxtGXv5fz7y3XSznf4kQhnbhMFccscFPtmogDX1Z3Pdp9VNZe+WCOSGCCwmQ/mryYha0K/S56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ika5R14q/XIoIj48wmW956ytnJtw9W7QD1EmEYRzDZE=;
 b=qiAF8KDg4jKtoYTuS5uUjnLhCanY4dXsOCjX5+0udPF8j58guRR9VypbRFznamNIw5TyAcljyJ5h96q7zTaGajLCZBXDZIhJQTp5KFpfwm8jvPgJ7+lEG+3Iz0iml0AGlA5AmJ744wQjcvtLIO8qo2jHxxTXekF1GkOLlTQcQOP8elck9ZPpbGMjYvSWSFV4Y89UQLseNacbgdZQYBlkmm149sc5lkl2YRxGLXkWmjkWdfPy/ng88PUJi2iF2pVBSQK68A+XJMKo8RygWcxtbwc/OmAbYRgjcdkltWP5HIS1ZHFrSS2U+T3pDdPoTgnW6b4UGpuFTAp2edzQ736Cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ika5R14q/XIoIj48wmW956ytnJtw9W7QD1EmEYRzDZE=;
 b=Trdovmepza5dtfQIEeJPIKEYxHmYrtixs+xfWoRbUEZic2lYNE1vo+Hev8AsQJwKqesiaPm9bdHWTgrBSlNGylrTG79GgmqhXNkc9UGX+FmxQm4+sofDb/h7cw3xLvINFEWAg8gWYtribuDm47eDMIp3xGOjIfHL0PICUssDwhI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BL0PR04MB6500.namprd04.prod.outlook.com (2603:10b6:208:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 07:01:56 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 07:01:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: refactor the main loop of cow_file_range()
Thread-Topic: [PATCH] btrfs: refactor the main loop of cow_file_range()
Thread-Index: AQHcbZ/K+ruKqrhikkSdlLOAugS/CbUj2HqA
Date: Tue, 16 Dec 2025 07:01:56 +0000
Message-ID: <cbd02554-2298-40b0-ac18-0aeac854cf5a@wdc.com>
References:
 <5ff61d63a33409de2b821562613ebb3ac0da9bae.1765788497.git.wqu@suse.com>
In-Reply-To:
 <5ff61d63a33409de2b821562613ebb3ac0da9bae.1765788497.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BL0PR04MB6500:EE_
x-ms-office365-filtering-correlation-id: 0fd99671-e470-4f9e-efda-08de3c70fffd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3MvQUx6VnhsN1V3Z050MWR4OXRyNlZKT1MyaUlKRm5paFRtYjNad0hMN2Iw?=
 =?utf-8?B?eGx5ZHNLNUFKMktLSGE4RTBUaTVUckZTK01UNXRLQS8yVW1LejBxbXJqOXRH?=
 =?utf-8?B?MmFzK1c4Z1F5ZUtIUFUrNnJCYTFmUU9DajRlZ3ZpTzFuYkN0OWxTYWZXUlFs?=
 =?utf-8?B?YmJTa1hnTHk3d0U3YTFVa1dROC9rckRBbFVwM2tyQ1lzNUNtajhRWHk5SDhH?=
 =?utf-8?B?MmVOUEJES0xDMGpGREg1d2ZiQlQ4WkpQNVdqdHg2Kyt6WVVtMVloajdQWmVv?=
 =?utf-8?B?VVczY3A5OXJ0d2NCcUNZcXBueFlSeUx5dktyVUNWZzBzYXZjcWg3VjdpVTRw?=
 =?utf-8?B?eE1hWVg0eEhkQkJTVmg0UldKeHU4RVJlOFRZcytGVnRwZ2dlc3o0cHJnbTVK?=
 =?utf-8?B?NnBrS1loQVNpNEVDa244TUtkMzRUSXI1UzNsY2hEVkZMMWQxZVlhOHN0MlN5?=
 =?utf-8?B?YjJRZStyTE5CdWxxb2tOSnV2WVNZcmUvdUxRVm55UVhRTWg3Vmw3Wk5ZUWxV?=
 =?utf-8?B?YlZUb2M1TWMvbFE2SElzOWVZODNvVFdFWE5melZLQzRneG1FK3Fna2lEYnlV?=
 =?utf-8?B?UXpHaG9GSXJrQUpGTCtydThMTWpuY2xtMTZwbkRTMkd5WG45eVpYMEVpaTdC?=
 =?utf-8?B?ek9GSVJjeUptcHZTR1p3elYxUkx0ZHlwRytFWjhpeXhkK3FGdlA2YjlLZkto?=
 =?utf-8?B?bWo1cFQ2QWU3NnN5V1dGZWRxNUtKdkdKRG56dE43dTQ2L1FpMG03RmVEVGhx?=
 =?utf-8?B?SUdyMFZxZ0l4SklVcDd0TUJ2b2szV0N4UUprVmI0WStFZWhhNytXSlU5WVRC?=
 =?utf-8?B?L2Y1TWhRQXU2STdvZkxTbDlBZlNjZ1Z5MlFpKzZiTEZwS0M3MFVrZURiV2Na?=
 =?utf-8?B?L1hWQnNPdmRKcENURG1TL3ozanhyZnBrbG9PSGdQSFoxNlJEU0hvWlJmMU1K?=
 =?utf-8?B?SnRnbWR3S3dKYnlNTUNkNmZXSm5vc0padThrUXRYSm1NRGlqYkV1dTF2Nnl3?=
 =?utf-8?B?c3dLNmt6SzFjV2cwS3I0OERQakkrTFlaN2YxRndjSTMraVpmcWtvODZXc2VO?=
 =?utf-8?B?bVVWdGRudnN2YTExZ1dibHU4b1VWQmo2dWw5WDRBblVyMTVpQ0U3VHZVUzU2?=
 =?utf-8?B?ZVVSQmtOWnJMODJ0RWFQNnJRQVp0Q2xUdkJCVHNaTXJ5dTI1UW93NVhsR1lq?=
 =?utf-8?B?NEFBaDJGcjhWNEpSL0ZkbWljcGtKWlVVNHZUSE5XMkxycmhUdDVZa245Kzh5?=
 =?utf-8?B?TGNJU1FaNGs4U0U5NFA5a3VTWkQvQWtCTUpyTHRQalFJRmU3UFpiS0d4cjdE?=
 =?utf-8?B?eVVLVjY1aEdpQTQ5MkJnemh5MlhzN2poT0g5akRxUUduRG1oOHJSMVFiaWo2?=
 =?utf-8?B?dktWQzJrVkYwV09vUHBzajZVZmlEZy9oR1R5M210SDh2akZXVGsrWGlPbWRD?=
 =?utf-8?B?ZWI4dUgyeElJc0N2MUdOa3Z0b2FTOHBMOGYvR1FsbjYrYlNid1pydHVGVXBG?=
 =?utf-8?B?WE1HTjRLcm0wVFRvVEFKb2p6RytETnNVWEVuSlUrbjRIT1RzNFdoZUROeEpo?=
 =?utf-8?B?OXk5bkdGUHZDMFVBSWtVek92b2VBN1dnL0orQUZBSnF6ai93V211MjNHamxT?=
 =?utf-8?B?MGVGeUlmL0FIQXZkYjRwa3pIczU1aFBwM2FrVVM4SldKUVZqWkNJU290L1FL?=
 =?utf-8?B?OHNGaWsvWkVCejZ5c3lNV3pwUlRoZjhMaXBTanF1cXFLcm8wajdzN3pDVzRh?=
 =?utf-8?B?L2lZelEzV29SRnA2VmFTa0dWVGYyRzN0cTJDOEFWd1lSZzkra0FFWjl4Rk4r?=
 =?utf-8?B?c0wzYkVVT2kyeW1xWnZneHBNY1cwN2NzNnVvelNzQnk5eXlCL2VKMENCZm9D?=
 =?utf-8?B?bis0aUJ4amd2Nnlta0IwWXFQNkRUc212SzNmS1lYWi9zK1pqck9yMm9rOWFy?=
 =?utf-8?B?dEV1K01JMS96Z1ZYSGdSODY0TnNWa25QYTA2UCswY1dSczdpNm45em5UVFZk?=
 =?utf-8?B?OU1VUjFEUml5SzlYUmp1a0RFczIySXowVnZBVG1nWk9qNWNtYy83RUJJNUR4?=
 =?utf-8?Q?nEagEz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0FVKzRlRUwwaTNrRWRRTXdCNlBEOXdxbFR2c21aSmxRVTRuWFZsN2pxS0Jr?=
 =?utf-8?B?dm5JOUpnQU4rTnVjdlNjUnpFRmtjSFdrTHB1MnloQlp3YlRpRXlaSlRkYkhW?=
 =?utf-8?B?b0VRY2I4dDh4SC9GUXJ2TjhVREV4ZFRjanhzUmFDVjhHSTBQblpiT1BYaW9Q?=
 =?utf-8?B?eTNaUXZGd0NpQkR5N3czcXg1UnNSV3RURlhULyszRzVKVHRpMUo0Rm9oVld1?=
 =?utf-8?B?ZGlHS3NTR1dLMFpTUlcraWtXdngyd3NkUy91Y2dLS0NhaWdNTUJycmp2dnhO?=
 =?utf-8?B?MEFZV3pxVDBEdE14VURPZkp0UTVydm52VWRKNkhVS1RhYVVUbXd4N1EreWJr?=
 =?utf-8?B?anlIbUxmaSttZWpCNUpqSFpUSVFnRmt5NzdkMWpLZTljWHpYVmQ1TDdjZHJN?=
 =?utf-8?B?ZjBlOHNOMXc4Ly9iTk5jSS9qMHVOY2xYK2ZqOWZvc2JvTGV6WlZIVjY4NDJm?=
 =?utf-8?B?dy9ka3VwNC91YXFCanRoRkNjM1RGbEpYVXppNDVPTEFmV2FzZmZlb2FkM0t2?=
 =?utf-8?B?RGtkKzJkWVZINVVHRUtYallaL09yWXJicmRyV0U3Q081SVdXRVAyMDhEVHRq?=
 =?utf-8?B?V2VTcGhJSlhkMWJqc1l6cWtDWURJSmZhT05Qc2dmZ2YyMFB6alhSMnhuMFRO?=
 =?utf-8?B?WTlGeURsUHlBcDFrYzl6cUdJU3ZCL055VFpYRFg5M3VFbGkwSk9Nb1doTVJa?=
 =?utf-8?B?MjMwWW8vaWtyeCsxQTQ0UEpqTG1nZGtlSkVIeTZyZGpLMVl0ejhlbzNMMDBv?=
 =?utf-8?B?ZXQ0d0ZoR0Q4a2FVSysvejZiS0s4R0ZteGdmSnBwUDBCYlcxWHZJdkJBT0hr?=
 =?utf-8?B?V2FBNkMvaGRta1hpMmVLL2JpTWJVUUJqVGx0SVYvV3luelNoeXpSL09Sd0pR?=
 =?utf-8?B?a05wOUsycWcrNW01L1FrZk5zZDdoQzBlSC8zSkMzQWxxV3NIaTNoRXE0TDBi?=
 =?utf-8?B?dHRQZUFJaXorQThzZjhoalRPdU5QTjAxYnhaa2RqYlYxdXlTVk81T0pLbjZC?=
 =?utf-8?B?L1NTMGs5QktaMStPVXRjWkZncjIzM0xjMHM2YW5ZSmVBU2tQYXlqUkRqRWt0?=
 =?utf-8?B?REx4TWtadkhnRGxmWkZOSGJIcDBHNnlYaVdkZFBTU3NGckk2eTlLci9WTHh3?=
 =?utf-8?B?OVg1M2t1Ylo2RzhhaVkrS2c4NkJYZlhvbTBBVEtISGEwbXE0NXl6UHdUcGR6?=
 =?utf-8?B?ajFpNzFrSUlrY2lFbUxPcHdVZmNUWE9tR1U4VmM1aUtrekh2MHVlcWNreUdP?=
 =?utf-8?B?NXovYzNscnRSZEZ6NkFOUWNOWnRveFpVZ0gxOFBFYjRKUHdRTXU0dWh5eWNj?=
 =?utf-8?B?N1pmdmY1d2ZJbUptOHZ2bnBDVkFhbHpCLzNkQ2VaSFdTQjZERzBxZmhNYmdO?=
 =?utf-8?B?bVRJakV2S00yREwrSDRnd3BVeU9DZHVjVGhuNGJhbk5FZkRLYnZJdlRhZTBj?=
 =?utf-8?B?NmtFOFFXRFM0U0JSWHlpbWJ6WUh2MDIrNzAwL1ZuUHBIRGZIend6cDliZ1Ru?=
 =?utf-8?B?UHc2T05nSm9jS0xyU0h3b2Z3RDhHd0VqVnl1a3U0Tk5maFUwdEQxdFV4L0RF?=
 =?utf-8?B?QTUxYWZBYnFiRkhNdHlXTjlBZFhZTk8xRks4c1NYUEp1RTl5ZUVUelQwTGUv?=
 =?utf-8?B?bWZoY2tsbWVHMUZtcEpDRnlLRHV2NVZpb0l5TXlTZ2dqOEM5b3ZadExrM0N4?=
 =?utf-8?B?QWp5c0plV3R5cWxRdHM4SW80emk1OXk1UUF3N2dXQ1U2M0RGakkxMTVBZURI?=
 =?utf-8?B?U2hITlFGaXFBR2tzMFg2UlhnWFlvM1pQeUZ0OUFScHlrRmFyRTh2bGhLNTdU?=
 =?utf-8?B?QmVXcHdFUk1YOGVXc2VsUjRsUWZQSE9KK2lmclV6ejYwWmc2RlNuWjVTOFVH?=
 =?utf-8?B?TTdsOCtPU3FYcEw2Nk4zcDdkdkR3K0xQdWUzV1d3Y2NYNHBkNmdVNURKZGRL?=
 =?utf-8?B?OWllajdPL2ZtcDJabHMwVW04aks2ZUhKeFlOcjR1UWhobEI4WXBaMkdJK1d5?=
 =?utf-8?B?eTlYMzR3dzNZcllRK3gvZFhQTzgxNmVuT0tCaHZKdzBDS1dmek5LWkVYYXVy?=
 =?utf-8?B?bHNOZHZiZytoQUJJOVY0d3JhOS9Xblk2aUhPK1J3Q1RLRVJNMmZ6QzYyTGI2?=
 =?utf-8?B?ckhueWZ2NWJUSHluZFVLOW1XVkQ0WXNvZTA5WFFXcS91OWVzL1FIWGp2aDJw?=
 =?utf-8?B?aEZpYTZFcHZRTUFTM1JOTTV3ekRPQmdid0tuL0xjU0N0UmFUZ3p4RmkwTVRy?=
 =?utf-8?B?YmNoVWZVU0ROQzl6NjZnR09MeTlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD78726E01539644B476BE915901BA66@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ve1aAlvJc/5pN9AqX2R/x8cA1s4QznpuJBQYQbkF7PLTnQvfuhL1LNd5JIoRz7TkpEoX1yzkyKofo0OYls/KBtnVyWRXlghyW0Q8FUflkq+ZZZPMrVd7IAedpDgMAY5Jx8TPC5vdzPej3JbvmwQipZ1kMHCTZk5wUDAoEV+huOBbb23vpoXY0qjySWmLtktNa2KdTvCvmvdsqBgDYL8mF6i++765CUf/hUr1bW7RAyQEs7FG1u2ZZRe+1B3a/DI9DwA0MeOLbR0R8zDl2C+AYU6rbk5KM+9xCv7jXHWmg54oCKiQCOuRb7ziCWJYCQ2zB5FPKHrAde0nyij+ZBildU1N/4sjeij2Km4GIPqCbUGml3MT7dVMU22b78bBfXD/7DOkCJ4XNQICP1Bc23hkHV6nCcKIyYcnNj+rnJp92aTgbjQ0ik8sVNRV2z9WfkIat3LV9DmA5tWLBVgUP8S0NkwdEBk7DlWCFYXl898WVQwbt65JqQFCXbp7jhdzcmBTG9wxD7ccMPAqVUl+63gowMIm1uHUGRq3VqxKS/HDF/xMZvmJpSm6v5BqJ64byGI8ZBxzmFy8jOxeVug19rZuhGc9O+6a4RyM+7VdcN5oBWv0+HXVrX6gmHN525zh50oN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd99671-e470-4f9e-efda-08de3c70fffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 07:01:56.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deHEOuswSneot4QfENe+e9qIdTOuZs6nZpEJa5+dOca4+EKaey/UA+d9vOMfogyACzMnk8EU5BL/Wtgz7+B1QEgQealV/P7CwkzF+Uuh9CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6500

T24gMTIvMTUvMjUgOTo0OSBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPiAtCXU2NCBjdXJfYWxsb2Nf
c2l6ZSA9IDA7DQo+IC0JdTY0IG1pbl9hbGxvY19zaXplOw0KPiAtCXU2NCBibG9ja3NpemUgPSBm
c19pbmZvLT5zZWN0b3JzaXplOw0KPiArCXUzMiBtaW5fYWxsb2Nfc2l6ZTsNCj4gKwl1MzIgYmxv
Y2tzaXplID0gZnNfaW5mby0+c2VjdG9yc2l6ZTsNCj4gKwl1MzIgY3VyX2FsbG9jX3NpemUgPSAw
Ow0KDQpOaXQ6IFVubGVzcyBJJ3ZlIG1pc3NlZCBzb21ldGhpbmcsIHlvdSBkaWRuJ3QgbWVudGlv
biB0aGlzIGluIHRoZSANCmNoYW5nZWxvZy4gSSdkIG1lbnRpb24gaXQganVzdCBmb3IgY29tcGxl
dGVuZXNzLg0KDQpPdGhlcndpc2U6DQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4g
PGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQo=

