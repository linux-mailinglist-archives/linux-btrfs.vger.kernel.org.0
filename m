Return-Path: <linux-btrfs+bounces-19728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD83FCBC9CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 07:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25DAA3019197
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 06:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863523271E1;
	Mon, 15 Dec 2025 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AqTk46X4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W8Om0p0l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D983164CB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765779040; cv=fail; b=QxXiA1lhDOMKgt8KjXdbw1UjjVjMZb/tQkyOgmOXAKZBRgAFA/jxwJHmMSFESegqwxQESQ6SwD53MtjPOi7NoE42/F80Rn6JxFHc/ov6Cm8hP5nPLLd2VANQwmKIQfbx8InjVv4AsemADrgPajT4nBiCYMBPupSRe48YqzHyRDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765779040; c=relaxed/simple;
	bh=O7PLWxAf/t7+wZdO+BYRf/bAEFDVPtIRLrlQLhlffE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m8GLBOf2OVO8ieF/zJp+UFgrZx1Lj76SB4LSTyoUF0NLwThfhce8lp8/PKfqCgkmhSOw3CvT8jL+NSczkrA5nZRFFhmltzl5en8ysdCpLBCnKRqZbxdN4gU+8syQEDcVSI57IHhOW56myj4OOwKj7OvSmc1UshS+A9V6o/xapM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AqTk46X4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=W8Om0p0l; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765779039; x=1797315039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O7PLWxAf/t7+wZdO+BYRf/bAEFDVPtIRLrlQLhlffE0=;
  b=AqTk46X4+3eQvhaMSR6KsGnHVhDoYQTRk8NgbDfhiQdW4iVkC/UUtIyn
   8f3O0Wobafp6wTJnmCuj0C6XrakRcSQBuDp6Nj/CqrEDvzZX667VFyIK4
   uV00bC0o8eWP+0kMOxy3kCT03LCnaYquQgYmZW7N4xcAkDZhlzofOhV5a
   eZ+7GpIHCZrDV5gzR151cLV9PjPEEz+VqMP+SHKtJI4gOAxkRRYVVsw2E
   zc0NdP6/wxlmNyvifS9qrnHOC4T+S3ILaa+jRRTaiPPgA6fk7GOATzYE+
   svIX6sSOZw/+VXCx/aJQr1nC5Rx+WIu/MBpV+p27xyBVQFKDwbCJ5vWuS
   w==;
X-CSE-ConnectionGUID: 9blebJL3Qy+qB55B1vlUNg==
X-CSE-MsgGUID: /Jxn0Y4pTZeeGJ6s+eCE5Q==
X-IronPort-AV: E=Sophos;i="6.21,150,1763395200"; 
   d="scan'208";a="133863242"
Received: from mail-westusazon11012034.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.34])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 14:10:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+nZASEcXWpeGMGb8DlQ2IoZfQfhCH0bmgDAFMItceAOG8PrEGGr56eJ9YyWQZs3aL9J3hoIUD2C5mcTADOR803wWatxTvOGj7awAS1qimkBBo7nGGmFCGrS7h7twptb+FzGidRFlgJOKUPKCaJBha+wjXCw5bbntVR5d6umJzD4uCEkKmo3caYjc3DVI4UTdJNpy6bECQQgLLa2CzobH0ND6oNpeu6GSfMtZkP9ulz90RzrBzSsCmKvYaQy2ztUIXfdvj0Iskzm1C98ywxffEO4Lmp2A9/rbOBj7mDatC54KzVddcks9hGXS39OImhXxxSmK0DrX+dKYCWdlfH/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7PLWxAf/t7+wZdO+BYRf/bAEFDVPtIRLrlQLhlffE0=;
 b=APF8KtR6gDkR1SXwXu5UbDhx9ibJ6dqmZb38f5l5PQTW9H388riI2gtrVri7+25/zTDjpdSIW6PUWty5LfLT8P/SGPeatE/XiqTj0pbVGEiLo8mg+WK6DVKDctxEKv+hh2twBejaUZRF85+H+G3lcOur9I99MWVECTabIEDhhsLead/0CgZi55RvVDEyKSeHUruoELHXzF3q7YQmGHvVELgjAXBOiIz8ZqR3QAiHsnLxqWkpPU+1mBUJlmgYeqE1ZSUsYFfHPhECNT11JfWslb7ayrBcXOEyVUr+pw0pzLUhxKBl2WQkNzquu/61KqfU1RQALTNRK3g0nUoOGo+bMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7PLWxAf/t7+wZdO+BYRf/bAEFDVPtIRLrlQLhlffE0=;
 b=W8Om0p0ls7cVO2+ivPZNB10xxN00NK8guMKyYe3rNef0JjzZP1C7M2yYgSwOC77c9cdc5SR8bkVn+sDuSHHxotJhjR3sh1KoDWSxpVTh4D+hx+caftPnBpJ6s+Mz8q6ItysMdl/+HKjCqyW89ATCz3UMgwj3ekMd8TBrF976rhY=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by CO1PR04MB9627.namprd04.prod.outlook.com (2603:10b6:303:276::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:10:35 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::1f92:3bb1:1300:b325]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::1f92:3bb1:1300:b325%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 06:10:35 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 4/4] btrfs: zoned: also print stats for reclaimable
 zones
Thread-Topic: [PATCH v4 4/4] btrfs: zoned: also print stats for reclaimable
 zones
Thread-Index: AQHca+3W2UYaMq3sJkioSj58Nu13urUiOzGA
Date: Mon, 15 Dec 2025 06:10:35 +0000
Message-ID: <DEYKFE9UI1UK.14D3BD16J0ISW@wdc.com>
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
 <20251213050305.10790-5-johannes.thumshirn@wdc.com>
In-Reply-To: <20251213050305.10790-5-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|CO1PR04MB9627:EE_
x-ms-office365-filtering-correlation-id: 87a00d4d-ee1c-40bd-9c71-08de3ba0a98e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0xyeHFIMkNpV05QRWdvWUNWd3NZR3hldHRvOHdReUp0a2N4amw3Y0VFZmVx?=
 =?utf-8?B?aThyWFlQWUQ3ME5vbWxLSGs1TnFQaStIYjJoMkJZMitxUUhhaVN5QXdQR0d2?=
 =?utf-8?B?WWcrTVpuTkhQU1dHU09rRFRVWWpsK1pkT2RoWGhHZ2dteXFkNVk4MXV3T1h0?=
 =?utf-8?B?c2x6Yk9iY2V2MU9ENHFsako3WitjeDRaNWFHWG5EcTF5bE5FR0Y5TXdrUTRi?=
 =?utf-8?B?U3BhUk14TTdrcy85STg4d1RWdDZnSGlTei96bEVTUWNZanVCdnNBS2R1TXY3?=
 =?utf-8?B?K2dPaWswaHFaNjMydjhVSHllbDNEbkk4MU5TQWV4UzA5cHJPRjN6OXU1TStP?=
 =?utf-8?B?Nm1CVkZHZ05tNGVndDZscjkxMWFSY2RteWgxM1A4WDdzaTV4QzNwYXZ5Qkl4?=
 =?utf-8?B?NFlkYkJQOGVxcFVOY1QxMTFSSGdCQk4vUm04SXZUN05kbnFIS21pZUQvc0wy?=
 =?utf-8?B?QzlPeDN0eVhtQUJhQUR4WEI3TDRPb1l3QVJjSDd1aWcwc3FhbjhsY3QzcHpw?=
 =?utf-8?B?TEN0QzNDMlZvbHpFUVFHNWdod05yWUoxUGp1RXNTYUg2TFFjbVJ4bWJDN1cy?=
 =?utf-8?B?OUY4WHRFRUI1eWI4TzBnbmcxTmZNQzFDaDF2QmdvV2pMNTRhOEpBVUpja0JU?=
 =?utf-8?B?RVRRRE8zVlVtWEFGbFJXaldIYTdXWEdVSkNGT2lvV0FKTVk3TmFRSW5reU16?=
 =?utf-8?B?czFuZjM4NTlZSE1NUVNrK2NQOFBEQU1WVjZZdFJ3NGlsRXNkSXZNQkM3WTlr?=
 =?utf-8?B?djd3V1JpUGd2clU4MTRYRzgraTJsOHpBbEFSU1c2cW1yVkJuTlF4WVhxa3c5?=
 =?utf-8?B?cnM5Y1dXUFlxOU83bVlKRUErejBtVlpVMG5EaldtQllNaG1FcFllT0tJUGJK?=
 =?utf-8?B?SkxUWUNKNko1d2hrdnVuWEMvbzJ6NTJzcFB0b0t1REZuZS9FSm5kOFhhYWRE?=
 =?utf-8?B?aU5iNzl0S1FlQVRXSDVLenJSYXBiZm0vbWJ5UzNIZ21NYTV5Q0xUUXhCNE1i?=
 =?utf-8?B?TTgyWWdET1ZzRVQ5eS9FL3BKUjFOaHhodTJPU3prcERna0tSRGFSTks3MnZB?=
 =?utf-8?B?SGFzdmhnb0hLUjdKdWFOejhqb2NEM3ZjYTM0ZjhRTnVoVWk0S2l0dnoxeTJF?=
 =?utf-8?B?OGFobC9YRDY1Q3ZqY2E1MWQ0VU45b254WE9vaGRwWkNzK1Q3NXVsWjlRUHRP?=
 =?utf-8?B?MG9YbElDZHNheXlTVktJd0pyL1g2dVJwZnN1QVNlZjNLUE9La3c0NUovdUNz?=
 =?utf-8?B?dUxrREtEdVVIajJzOXVMaFFqZmJCL2l4eHd5anVzckU3WEhoK215cjFlVFpz?=
 =?utf-8?B?QXVhanZPSjhJQlZrZVJlR3BpbjJWVkx2bjVnOFkrZEVqRWZIa0VHeUtIcmVi?=
 =?utf-8?B?Z01pK2VxUTdvUDZ3ajc1M2xIdExudytMdXJ0VnIwQkQwb0NSN1pyWHlOSnNY?=
 =?utf-8?B?eUFkSm00WnFnTFJaenBtVldJSzkvL2o3eE04bVhXTHA2MVM4WHRmTVgvL0gv?=
 =?utf-8?B?SFFFYU1tZXhGNEdRVlNldDZOYVJtakNXajJBSk5aQzNvdFJ3dlhqUGFBNy9C?=
 =?utf-8?B?MXBrT0RianNWSTVDME5RajJwZ2hKUGVta04rOGhPd1ViZFQxaVk2K3JjbjRa?=
 =?utf-8?B?YzlYczVSbEg1SEhMQzZaNFpnSFI2dHcrNndITmFhV3R0NDI2NzlTeWdDSHQy?=
 =?utf-8?B?Qzl2MitadE5BUEhrVHVTK2lWNnA0cEY2dEhselpFdW9HK1ZSZmtOcGRjdFp1?=
 =?utf-8?B?ZGdlV0lTMTJWTXo4eWMyM0UvNkRqNVZIeklGWFBLTjExRlo1bEpqQytvcjZn?=
 =?utf-8?B?cEc5Q2RLL3F3YlhQSlJyeGU2cFlyWVBndytIbTFBdjM5bzNGZjJJT3JCSnlG?=
 =?utf-8?B?Sjd4R1MzRWFFR0toalY5a2RVYUZwNUVEWklsUHJGdFhwWjBDVGhWYko2ZFNB?=
 =?utf-8?B?MDQvQkNjaTJuNUh0akhMam1TblJWeWRZaU94VWo0Ni9DQjdCRDVTeVNIMENh?=
 =?utf-8?B?VmhLVVdGOEF5eUcxSFRXbVVNWnh4aEs1a2lxRmo2WVNYZzVCejFtY0E5Snhy?=
 =?utf-8?Q?xZ1s8B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3BmMXdUSitiYy92RStUYlQxaHhERFBhelFNNGRWOXNuaURiM2RLNHc3bEs0?=
 =?utf-8?B?ZXJkdFYrTC9HbzZJSENlbzFpWGFLQU1Ca3BUV1hZVDNSeEhDMWdWc002U2hM?=
 =?utf-8?B?TTJCWWdldnBOdktmckQ0NUQzOTkwRjJQTUY0czc5T3V4L1JTVm1CSnVKNkps?=
 =?utf-8?B?SVdSbTBCeXJ0bVlRdFBHbnN4MjZPdU9uaEtWTUFseisyeFJ1RVlCZmNoQzVP?=
 =?utf-8?B?MkM3aEpxTFpGZm1iZ0gzMHNKdHJjYjltRUpMS2l0SFVpTkZobDFSNDhZdUFX?=
 =?utf-8?B?eGs1cVRDRTdxREkvUnJQdlBtbVR4czJiN3FjNDJVaTRkQm5pVEVwaHUrMFBO?=
 =?utf-8?B?Sy80bHZzajg1ZkZBRmhxaE1KcC9vR0VzbGt6TmRRa1Z3TFMrc0lDRDZ1NFp5?=
 =?utf-8?B?L2ZEVGR1SXc2a3BPUmhzYVlqUTY3SkgzVUQ4NXBGeExQcFpFM2hLSzR6OGtW?=
 =?utf-8?B?NHFadFJpTndtY1dYakdtKzRUS0xCQjRZZkRmd1B0VUUxNmhreUFxbDE0YWVY?=
 =?utf-8?B?YjVIa1k4ZmdnOXV6UENKZ0syVmRHS1RVU0NMVXU4TUp3K241TjllUDlLSjN3?=
 =?utf-8?B?N0cybHAxdkYvWC93enVoYlo1elc2a0R0R2t6aDFmQWV2ZzV2a3VBZENLbmx3?=
 =?utf-8?B?bVJnem9ncHFvWTVVV21wYVcwVnJwZzlwbFFaVEEycmRjd2xIWjFIbTZmQTFD?=
 =?utf-8?B?OUUvR2xhN0dIQ2VleVhHZTNoQTNuYkpKRVFFVnZjUnJ0ZUp5eDlBSGxTOVAz?=
 =?utf-8?B?WXVwMFVVQWNLUjhSeG9HV1BrdEFBSndhR3pGMk5RNUw5VEZFWTBJZVN2aXlG?=
 =?utf-8?B?VytmSGxwaWM1QVozQ2kvWDlTWG8vamRySks2Mmh1c0t0dFJWOXY4NlFKWDNu?=
 =?utf-8?B?bE9DRzAxZUFRSGY3b0pnUUFwSnRrZXp0NS9yNTNjQTRvL0tLSGxkQVVwSTdq?=
 =?utf-8?B?cVZ3WDI3R1NSMDJQK2J4VW9pMS9jYnEveEV4dHZkQWIrVDVsYkVwRWZidFUv?=
 =?utf-8?B?QTlJVGMraFNKaHRYUUVBdkc4bkRTZUtrWnJhbk1UbzU0Y2x0VmVtMTQrdzBN?=
 =?utf-8?B?cWhiODYzWDZFeTF5bWZMQWtXM284OUtMT1p2QTd6cDF3UlpzSk5tdExULzZt?=
 =?utf-8?B?c3hHUU5Rdnc4WFIwWTAwamRrTEZQQkorNHZkM0Z5bVlUOTRQMG9Gb1JpOCtT?=
 =?utf-8?B?UUd4VjZVbFhzUFFmSGlXTnk3dXVHR0Z6YXA1TnZtV0ZYN2VJQk52ZDk0RlNw?=
 =?utf-8?B?dElQaUsxQUwwVXRMS3hLUnZ2R3FGYllEbkVMRDVhVnI2OUh4TGMwN1JVUXBY?=
 =?utf-8?B?WW5lVDNyYmVFWUNtRU9UVlN3UDg5aS92cUZNRWR0QmI4ZkMrM0Nac0NwZ3gw?=
 =?utf-8?B?TnhML0VGTnFUamNUL0I1cGNZcE1pVWlRUnlURm5tRnZ6b0lwWjA1bW9TYUhB?=
 =?utf-8?B?dyt1Q3E1U282Wmo3VzFMM096Rjc5QnFpaDJZcmFpRUxxeGNKR0pPTEdqa2tX?=
 =?utf-8?B?UjNwN0hwM3NST0QwTnFDNzluSlhhZHdOSnloSThEVFhIdU9KcDFQNS9icnhX?=
 =?utf-8?B?QTFtajAwajhVTXhIRWVFVnpnQXpjaEFnWisrS2hjOWJRTTIxVUN1QkJGaXY0?=
 =?utf-8?B?WGtJKy8xRDBnZnNtUCtGWmpZbnVwWTJSOGNrUkdpb1JxVTBjQjIwZWRoVlZ5?=
 =?utf-8?B?aUE5QnpIMVRQK0NwWXBqQk1NbnVlYUFwMldNRnR6cFBYd2pJN3NXbHJIV21h?=
 =?utf-8?B?TTF4NjdwcG52SnRydW9ZYjFKdjFqT1JSZnRjTi9ma0lZbU9oUGcyaXBiWUF0?=
 =?utf-8?B?bXFPTFJWQnBFTGQyK3hObCtDQzIrTDV1UklCS3ZOZGVDNWpJOVBjRHdBZW53?=
 =?utf-8?B?anduWlY1V3JZMEoraWh2cFRzMDRSWVNwMGZ4ZVYxbk5mOERpNUVUUkRPL2F6?=
 =?utf-8?B?THhPWW9xa0xDU0g1ZkZCaDArK3R4ZmRYL2UyNk5jb3phdWpmWGVhK1dabTJD?=
 =?utf-8?B?ekJIdHA3dTREZEMxUlR5aE8yR0pXSTNWbjd5RXB3UjVPY09leDhOaEhVTDFE?=
 =?utf-8?B?em0wM216L1hSNE1JY1BVNklldEtjWkFzRkVVUnZuTmloK2t2VXJPQnBlTG1S?=
 =?utf-8?B?U294L3kreGt1Z0pGVlFoNm01MVpEd1ZIMXJtZzdWUXc1YWIwb3lmSWtydXRq?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2724F242A94944F8D684BA65EC73A89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	glVxvGTBI3OEW025FV7CIdvM/o3M8e3/qMo8cwFE4a/Cb0arYh1pJMR5wZso6FK6hmylo7yGjO1MyZ6nPsRLPm44fbiucNFUskpmuOliKAEPmU9mr7Ugh355ngDalb9z6iakW7B/8bgaD3LL/nyemOlyHnfppQzHwcZ1RfCy65I8bxTTXXrFa6aJ2kD1ZD2ZecXsrtaYoRZsPAn43jXcVqam55vf1sYm+pNWAMIy0KmsUOEkolECe6l5GnnvcAESvCte/qthtRifQtub3EimJ1q4hGebTfH3LyX9Pi7jvZzFYB8IkyLbOaETOQCxWqM/orntPDJnYJ8tCD5T3u+lacQ/DvS4abE5KPQ3IVvxCTPmvWSA5rai7HsRgIHEQiKIgFgzsdREfyQcTEKsAQ1poYZ2TnfDQeEiZ9Wh/eHyA0qYancSL5FrB84pRYJbpiDvzVpMLtAs05vLzBSrB4zOWG/hPaxGRfh+vW9l795PoFUgxTGXV4ymPeQzjRsHG1nJ8YxmEUJK2wDfFGVWhSHPKvMN5quhsoAb/rhEoTQYZMCDrx2qCBvXlFQ/tixwuRc4U7K2V3dKTnQv48SZM7PpJ3xJNQ2CsXhFZ2pTiV05W+hzIYJDP7n2HT0HhqQnE/51
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a00d4d-ee1c-40bd-9c71-08de3ba0a98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 06:10:35.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FikyumwfSgKXWgPk2NLlfJ9P94Z/wVUDO7Fsdwi1fJvcZWtXR/w1czZzwVP1eDQvP9r1SJPHUPcigBp2TOjSsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9627

T24gU2F0IERlYyAxMywgMjAyNSBhdCAyOjAzIFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBDdXJyZW50bHkgdGhlIHpvbmVkIHN0YXRzIGFyZSBjb25maW5lZCB0byB0aGUgZmls
ZXN5c3RlbXMgYWN0aXZlIHpvbmVzDQo+IGFuZCBub3QgdG8gdGhlIHJlY2xhaW1hYmxlIHpvbmVz
Lg0KPg0KPiBBbHNvIHByaW50IHRoZSB6b25lIGluZm9ybWF0aW9uIGZvciB0aGUgcmVjbGFpbWFi
bGUgem9uZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5u
ZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IC0tLQ0KPiAgZnMvYnRyZnMvem9uZWQuYyB8IDIxICsr
KysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy96b25lZC5jIGIvZnMv
YnRyZnMvem9uZWQuYw0KPiBpbmRleCA2OTgzZTcxNzdjMGEuLmRkNmE2YTVmNWI0ZSAxMDA2NDQN
Cj4gLS0tIGEvZnMvYnRyZnMvem9uZWQuYw0KPiArKysgYi9mcy9idHJmcy96b25lZC5jDQo+IEBA
IC0yOTkwLDYgKzI5OTAsNyBAQCB2b2lkIGJ0cmZzX3Nob3dfem9uZWRfc3RhdHMoc3RydWN0IGJ0
cmZzX2ZzX2luZm8gKmZzX2luZm8sIHN0cnVjdCBzZXFfZmlsZSAqcykNCj4gIAlzdHJ1Y3QgYnRy
ZnNfYmxvY2tfZ3JvdXAgKmJnOw0KPiAgCXU2NCBkYXRhX3JlbG9jX2JnOw0KPiAgCXU2NCB0cmVl
bG9nX2JnOw0KPiArCXNpemVfdCByZWNsYWltYWJsZTsNCj4gIA0KPiAgCXNlcV9wdXRzKHMsICJc
biIpOw0KPiAgDQo+IEBAIC0zMDAwLDggKzMwMDEsOCBAQCB2b2lkIGJ0cmZzX3Nob3dfem9uZWRf
c3RhdHMoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHN0cnVjdCBzZXFfZmlsZSAqcykN
Cj4gIA0KPiAgCW11dGV4X2xvY2soJmZzX2luZm8tPnJlY2xhaW1fYmdzX2xvY2spOw0KPiAgCXNw
aW5fbG9jaygmZnNfaW5mby0+dW51c2VkX2Jnc19sb2NrKTsNCj4gLQlzZXFfcHJpbnRmKHMsICJc
dCAgcmVjbGFpbWFibGU6ICV6dVxuIiwNCj4gLQkJCSAgICAgbGlzdF9jb3VudF9ub2RlcygmZnNf
aW5mby0+cmVjbGFpbV9iZ3MpKTsNCj4gKwlyZWNsYWltYWJsZSA9IGxpc3RfY291bnRfbm9kZXMo
JmZzX2luZm8tPnJlY2xhaW1fYmdzKTsNCj4gKwlzZXFfcHJpbnRmKHMsICJcdCAgcmVjbGFpbWFi
bGU6ICV6dVxuIiwgcmVjbGFpbWFibGUpOw0KPiAgCXNlcV9wcmludGYocywgIlx0ICB1bnVzZWQ6
ICV6dVxuIiwgbGlzdF9jb3VudF9ub2RlcygmZnNfaW5mby0+dW51c2VkX2JncykpOw0KPiAgCXNw
aW5fdW5sb2NrKCZmc19pbmZvLT51bnVzZWRfYmdzX2xvY2spOw0KPiAgCW11dGV4X3VubG9jaygm
ZnNfaW5mby0+cmVjbGFpbV9iZ3NfbG9jayk7DQo+IEBAIC0zMDI2LDQgKzMwMjcsMjAgQEAgdm9p
ZCBidHJmc19zaG93X3pvbmVkX3N0YXRzKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBz
dHJ1Y3Qgc2VxX2ZpbGUgKnMpDQo+ICAJCQkgICBiZy0+em9uZV91bnVzYWJsZSwgYnRyZnNfc3Bh
Y2VfaW5mb190eXBlX3N0cihiZy0+c3BhY2VfaW5mbykpOw0KPiAgCX0NCj4gIAlzcGluX3VubG9j
aygmZnNfaW5mby0+em9uZV9hY3RpdmVfYmdzX2xvY2spOw0KPiArDQo+ICsJaWYgKHJlY2xhaW1h
YmxlKSB7DQo+ICsJCXNlcV9wdXRzKHMsICJcdHJlY2xhaW1hYmxlIHpvbmVzOlxuIik7DQo+ICsJ
CW11dGV4X2xvY2soJmZzX2luZm8tPnJlY2xhaW1fYmdzX2xvY2spOw0KDQpJIHRoaW5rIHdlIGRv
bid0IG5lZWQgdG8gdGFrZSB0aGlzIG11dGV4IGhlcmUuIEFzIGxvbmcgYXMgd2UgdGFrZQ0KdW51
c2VkX2Jnc19sb2NrLCB0aGUgQkdzIHN0YXkgb24gdGhlIGxpc3QsIGFuZCB3ZSBzaG91bGQgYmUg
YWJsZSB0bw0KYWNjZXNzIHRoZSBmaWVsZHMgc2FmZWx5Lg0KDQpXZWxsLCBvbmUgb2YgdGhlIHBy
aW50ZWQgQkdzIGNvdWxkIGJlIHJlbG9jYXRlZCBhdCB0aGUgc2FtZSB0aW1lLCBidXQgSQ0KZG9u
J3QgdGhpbmsgdGhhdCdzIGFuIGlzc3VlIGhlcmUuDQoNCj4gKwkJc3Bpbl9sb2NrKCZmc19pbmZv
LT51bnVzZWRfYmdzX2xvY2spOw0KPiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGJnLCAmZnNfaW5m
by0+cmVjbGFpbV9iZ3MsIGxpc3QpIHsNCj4gKwkJCXNwaW5fbG9jaygmYmctPmxvY2spOw0KPiAr
CQkJc2VxX3ByaW50ZihzLA0KPiArCQkJCQkiXHQgICAgc3RhcnQ6ICVsbHUsIHdwOiAlbGx1IHVz
ZWQ6ICVsbHUsIHJlc2VydmVkOiAlbGx1LCB1bnVzYWJsZTogJWxsdSAoJXMpXG4iLA0KPiArCQkJ
CQliZy0+c3RhcnQsIGJnLT5hbGxvY19vZmZzZXQsIGJnLT51c2VkLCBiZy0+cmVzZXJ2ZWQsDQo+
ICsJCQkJCWJnLT56b25lX3VudXNhYmxlLCBidHJmc19zcGFjZV9pbmZvX3R5cGVfc3RyKGJnLT5z
cGFjZV9pbmZvKSk7DQo+ICsJCQlzcGluX3VubG9jaygmYmctPmxvY2spOw0KPiArCQl9DQo+ICsJ
CXNwaW5fdW5sb2NrKCZmc19pbmZvLT51bnVzZWRfYmdzX2xvY2spOw0KPiArCQltdXRleF91bmxv
Y2soJmZzX2luZm8tPnJlY2xhaW1fYmdzX2xvY2spOw0KPiArCX0NCj4gIH0NCg==

