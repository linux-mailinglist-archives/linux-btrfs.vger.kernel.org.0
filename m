Return-Path: <linux-btrfs+bounces-22286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMeVGDxtrmmaEAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-22286-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 07:48:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF622345F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 07:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57543300F500
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2026 06:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0524362152;
	Mon,  9 Mar 2026 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UCNwHr5U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gFWfJ1kJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF736213E
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Mar 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038899; cv=fail; b=V6vI8R2muekJpamin82vpYUM+YLQ57s7rCJ8+8r1HajbxdVX7b+aA7E4cJXXcSUBkhGRjt1nPqTGxMKbtM0bkH6YLeIzmxmGW+xxX7UlE1zVC3BYYjZ08myTy1VYlYL0K7lK2yQYVEOJhyB13GKhG6dYeVhu3wAMH4oElfZHC5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038899; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=srxUPSH9mQup7B9KJ0aZmyAwxYgiQkb7/0j/a+nVJHHr25AA6C+BDrBfscJblZzBn/1cHp6FAvQopO8Hfna7w8y2Y0mpGmXgwg9kri/h+i3jGLm8SXnjzhClHGBWT5PTX5i2bbhwX4GlsYFGBhDMzFICyUHlGUOJPX+6QOUAIAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UCNwHr5U; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gFWfJ1kJ; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773038897; x=1804574897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=UCNwHr5U5omlwsTPQlpf9axqtSfLBjfNSYMMOhzHuGtdNTn/2YAJ25sn
   ourzwatVCHaPk2N18ktnA2TglX1twDKSsiV096KUnph9G4rgFC7Tg8WJ3
   DXUBFcYcQdSKPefu/vl/IYoeiSZmXWpBaxWa+Ai+3a30p9FHQuKC5jXlF
   1u3HjtfiOtGztxI4CYGFdc3Kx+6CuLr7JrJSO6hyWpXFRGTDbV53dej/z
   06aCjpukA/3ARfmwDSV8qxNbAiHdOSDgoxJBlkihNAOVXv6TiX/CunN9L
   vdFRxOQ7SgSYQ3l8Z+pmowHe31RAJz7rAtin6XsgEnHbaYEPa9k2DSpZk
   g==;
X-CSE-ConnectionGUID: qq+hsIJMT6+IND8ZxM28SQ==
X-CSE-MsgGUID: pnm4zJElTVqnAtg/lxJQcw==
X-IronPort-AV: E=Sophos;i="6.23,109,1770566400"; 
   d="scan'208";a="138530508"
Received: from mail-westus3azon11012051.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.51])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2026 14:48:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfk29RW9c2UKo6J9RmAvulum9KgveYUH51F3KZr6Z2th0dxjFIkfkwYTWhR3bfZ9/yi4qNk2omiRC2xW/xlTiLB46tMpTZfylnkvFru8pQuxqjENqdO2lplODkGhso4ph4nNeKuZpNKPlw0j7dSee4aGCOiqf6iY5F7TUf1PtYB/z1HLkdPduiKTV3ExOic1lPP6nCGJCz4sydnilv+0OF2t6crxAIwFLNy0KS9S+cRkwf2R3aDmdtKIj16CDSeKTEECcxTYRo7TRdyD0zhT7rJaYIKzC1KrCDYpX/Tu/cMz7rRq6gGsTnWuM5XFcNHafxM8szZ7JQOAY1P/Ut92Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=HAzHn5BXp/l4DDKUIKp8qurnVs8+hd8JCdKk9JtYSoOxNUxfM8HrLzSRiMajF0z9kyMX9fDpBj8fJlg9hfKYURki8rKj1z7HSz++IohxD3B7rref3pizdng+odhkGj+mRCx59gULs9sK9HIuTST281j2hfmU7wkom3nB24SOAx3JR/SfQ+qIwh0eolxuH1vx7glJKD8O84AkCfljSFuWDtKOFpBHVzD/M6/JVvd+fWwbg5blfu+TcZ/RmMN0mhADRvdp8qS1ou2waP0PNtK0CF384JH2DmudrTA43qeuZG45TeLK7XrqXcRP/9wIZdyUC7pARj0Q6SEXwv0HxKcdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=gFWfJ1kJVrLk91oyzwp5xkHpoZeSWLUDjraL8u0j7vQfrW/DtE9qdXTavKlKiti6LRC0+VZF6Zrxv64Si822fucZXNIHeBdWrz3qaQeITh0lQm3oCbgqQedCIi9a0XxoK7IJtQ9PsDRg7hrgqdUlY7szIrMwd3PG0pjH86LGOxw=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7590.namprd04.prod.outlook.com (2603:10b6:510:52::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 06:48:08 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 06:48:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <mark@harmstone.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2] btrfs: fix use-after-free in move_existing_remap()
Thread-Topic: [PATCH v2] btrfs: fix use-after-free in move_existing_remap()
Thread-Index: AQHcrXQuZRmRfL43hUavWSTIIx/ljrWlxncA
Date: Mon, 9 Mar 2026 06:48:08 +0000
Message-ID: <003a7e9d-62cc-4a3d-b542-6117f8fda0ae@wdc.com>
References: <20260306141843.27186-1-mark@harmstone.com>
In-Reply-To: <20260306141843.27186-1-mark@harmstone.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7590:EE_
x-ms-office365-filtering-correlation-id: 8d269c63-5399-4f18-bdad-08de7da7d307
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 NdfMLah8qj6vuwxwwuYp//NvLqL8uHQQUeNCUoPYOdL1ooQaKvDn8/vS2sHeGABO6eOu8/ArNZcD7ekIQ2Vgt0rTnLVe81HFlQF12M2h7HJ7FaC8/fnWGFFeGVyQpHrNIOU8gTUAwUYDUWyfBscOkS1QGnHY+VMkIwV4ITrR43ghWziv2E0LpnQVhcY74s7bqlUkxSuCTjbibdonJ5Billezxz5DV65bZveM4SXnTp4ZtrLGdyYWNHkVtp8KSTCkTxBpS/HUSrcDotHZmZsTm74iuBSpAjVDZRQZIIGr8iJvHRLR6+ScOwwDVDawFhAtx+kCYXXfYTRGJPUS5gkujb+0/IrXi5AifJcysnkTSGtcBu7bZY8JsqTTMcWZjm7BCqn2hrhIXkd4ceIrbuKOJ+7hUFnKQcGPbzb6Tm6GDXlDAVEQk+Td/z2vznpb87Py17cnthHEtPWyuMm5YYu+t8yqDL0am5lJrCrHburDAhFthE+WuhUXca8zYb5s8MaOmC/ZtfMLm1WtLX4Fz74H0KOHIWO+VKp9Pkch37uMVcf1SheXrDyfkH+i9ACBPsGcmBJsLerMxwTa+POPhS8ebaeJSCQgvbVTmPD/cqVEx4Dggs3Avur2UlkguYs2zfxKhg1nyUxE3G1HlVuRVkslfJZuFiDMPXoUj8jXtPuSQPCSqjqSncvS8IHZtue5zb/bSeNpWEyAw/j6y/g96vYRXeNKWkMdXEII7WbEjIYNHGydTYcN4R5LqFrmilLlZ92FNVsOaXWraE3CyqrHn7nG5NtNaAeQ/06aYGhIcU4Cz1I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnViUlI5TjA2L1ZzT0o0LzJhejhFMTZML1g1amcrazZKajlybURUOHUvSms3?=
 =?utf-8?B?RDA4YlpEVC9EUUZJWEpteTAvb1pkMjBhK2lzaWJZTVpzdkZjd1F1aEgrM2RU?=
 =?utf-8?B?UFFLT0syRVY4MTFmcUUvcXJRb1lZQ3VVU3dKaTFJaTJqU0pUSThFbTc2OWlW?=
 =?utf-8?B?WkJrV1poMkY3ekZrSDhrejgzOU5GckI3WHhQWGJxOG9Bd2pqeDRhdFArZTRK?=
 =?utf-8?B?OStOWU1HaFlNV0Q1NGhqeDdhOFM1SEhiV0I3Mzd1QXZrRC9iRWtVeHlNZ1Er?=
 =?utf-8?B?d2FsYkx1U2FaeHlxdUhYT2VYc05nbHg4dkYzc2orZWxMVnhsRERSTFlibEZs?=
 =?utf-8?B?cHdXU3BuUEE3ZGpUdXYyUlU5RnQ4dHFQOFF4bUk1N2lhNnVxQm5HYjZzcEpL?=
 =?utf-8?B?K0ZhOGllek1xZldHdXAxekFhVTJqK05XVWVDYkFTeGYzbU5ncWMxSVpZMFdT?=
 =?utf-8?B?NVI4aW41ZDNPQk1NNGZjcEVDeENIRWJnNWx3Mmo4SjhReDEyS0JJOXhBWWV1?=
 =?utf-8?B?RDUwS25nNXVXZnplbVY4ZG41czB2N0VCQ1VoUi91L3BBR2JhZEdSK0lhSXFt?=
 =?utf-8?B?c0RGMWtBSGE2TndSNEd1QTZLWTZIMEg5YVBCMnZXSWNMZVVpRUhPQzN0dzdQ?=
 =?utf-8?B?YXhWK2l6ejBSMDlNVG51SWxiUGJZS3FzclZsUXRtdWZ2UWk3bDd6d0dEMWVz?=
 =?utf-8?B?OU5ESEVqOThPNWl0VVF5cEtHU1pKY1M1TWxwdlZpYThCMTZld2NOQUlQNmw4?=
 =?utf-8?B?VE5VL1EzN2ZwbHo3ellhV0dWODZ1d0NWR25DQnMxRHBFSzUrWGlkSG9nVVJz?=
 =?utf-8?B?aE1CbVlLQU5iOGdsSWZ5eDJXZTlOckVyYXg4VlhHTnh3QnNVWmVrOC9YVXZV?=
 =?utf-8?B?cW1oOHk1VGJvWi91ZElmNmlhWXEyUnpoNEk4cnkyb2ppeWx0ZGNFaERYQzM3?=
 =?utf-8?B?WkRTUm5DckZyK0hyTU5NemdORi9BTWpPYncydU96elJVOVQ1aGlaZGFwbTBp?=
 =?utf-8?B?VHNjaDhibHpmUHVmSXlWemRGODFBS0owb09LcWkzODFiSlRBWWt2cUUveHBp?=
 =?utf-8?B?cVJLSHNLVnNEeWN1aHZENmQyQVBibzhsb21DMGJjUlI4S1BDZGJib0tOZy9w?=
 =?utf-8?B?NUlJS0ZLK3hGdktSUVRSeUN4VGk1OEVCU1FycytacFZyTktnMUQ5U25CdmtX?=
 =?utf-8?B?bGY0cUJDejNxYXdjSExaSk8rWjM1bEhDYVR6YzhvQUFiM3F1MEVaTS85dmZy?=
 =?utf-8?B?UFd5dlZ0SFdPaHdNMVRxMkJsSTUyeHRwczI5TmtsMUtLaWpNd3BNVDV1Q3J5?=
 =?utf-8?B?SXhtdC81Y25sblN4TS9ENDBkeTVpVjBnOVh5VVBFQko4M09CUGg4UUp3S0tT?=
 =?utf-8?B?MnFEVnlsSVVWWkJVazNYMU5uUGl3NTkwNHdiakRsMzI3WmpXb0RkcGlBVU1t?=
 =?utf-8?B?VXUwdHRwMXhTYlV4azlwTFBqcHIvNFFpZ0Fwa1hUY1JlMTB4SUd0VkMxWVBj?=
 =?utf-8?B?Z1JCbUhIZmhtbWFjRFp5a0VBK0U4TmVud3Jqc3VobG9KSHhrckhGTnhwTE5Y?=
 =?utf-8?B?SUgvS0hZcTBnWW5KaFlkeUY2M2FqcnN1dWNCOUM4bFB3ME1kYkNhd1VrWHZY?=
 =?utf-8?B?S3lhSUY2MFNZelEwZXU1eVo4c3k4MkUxaFpDSXA0RktOOXFMU1Z4WVhvSXVa?=
 =?utf-8?B?RWE5S0Nqb25DL2dCUjN6NWxYakJSaHVWaXQvbDRzNkVHWWtOK0U2SFVRMzdW?=
 =?utf-8?B?OUJNOUxMcnROZDlRVi9qQnVsbDRQU2dTRy9QMGEwVUVBdXYwYTV4S0YwVkhM?=
 =?utf-8?B?V3kxdlZjU2h3ZVNjdiswcjYxUlRsa0RWNVAzUGRUSnRTbkNBUkxQdGlzRm1R?=
 =?utf-8?B?MGE0cjBydFhLZTM5ekdLQW16dkdCWERBSlVPSXVGRnJWaVBKRlpXOHI0enkw?=
 =?utf-8?B?cERjQVk5Q2ZiVmQ4eFlpdW92Ymx0RDk5c1pPRlErRGZGaEpqKzlYdWJ2c0FX?=
 =?utf-8?B?TEpEQ29aa2VrZktmcFAwWDlGaTZMYXlFMWU4bmI1Y2RyYTMxdy9YSWIyS0cz?=
 =?utf-8?B?Zis3VGFRdVQ0cTF2MTVNS09DdmZMNW90M0dRaXJ2TVdFRmRGcm85aFp0OVVm?=
 =?utf-8?B?STRmdGtHcy9VNnpoQldWdXlNMkg4MUtVK0JNSy9ObC9QeEZILzYxZ0Job0Nj?=
 =?utf-8?B?dFFwRUg1eTNiZUZxU0N3dUQramJhVnB5TEw2SFhlWFdJVEh5SVJtYlBrcDgr?=
 =?utf-8?B?b0toR1JVUW5HZS9PWnVNN0dZaGJsME9rUkJoZy9vUkJTdVNPQ21vUDl3bU0z?=
 =?utf-8?B?UjlrTEJsQS9XcnR2NTRXYjVUdUpaWXRoYlZ6Y2xDTXgwbncvdUdJdy9QeHVK?=
 =?utf-8?Q?EgiHr6UG6hlAjrYmdVpaPX/wu558a+fIedyCOv+8P9K3h?=
x-ms-exchange-antispam-messagedata-1: jPKssqteY8TngXlJkKBEqzQREyuA3Ye+XBo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCE81B248E1D0F4785D28C4AB9953BB0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ilHA1gMs2WNy/Pb9cTIJOKi8u/tESarbuvr3PJcC8lROLbt5UWGAaWDjei6GRf1llunk+vaW2Y7VHacvheoakP7zzFbBVV0J5sZMEBzjUl5h/slrecajQeEBAIJbs8TMDnfnh1fR05Un0BfD0+q+D8UKkOOrdYCk8vtV+4xmPettTSeHBhyvN6MR2vpUY9iSA7rnmidvWpQkX3TqBtFFBOJDZZqLU2wouCvhyvYMj19eeQh9D1zwq5MrjNNOPrMjq0lGJuZhXX66kK/vCTT71Q2+g3wI0eIfPj8OkiTBCDSqqq+81E2mQehpL5XnD1KY0BnqhHAj4DGUoWq5sNDbbw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ATPfcNDtbp/FBhLQ7Nem04IaktwGyEKyHxQ9muTvefSnd1pU7D/rC84UKxrbgmCG3E0WW2o6v+JgGEZnMBQ0J7DkLPnCAsdgIHfhebjgPsEfyWGE/+DUX9MUCWviXx6YPLcMxpxk47sFcsyNIXV9uRaDe0XpeLdtlVs5FSwIi6112la/4S/sZgz+QSQB6YRqyUhTDC7gf+Y7PZtK8JgCmxjNUtlCHLpn5mHcXsxoen8xkTKYpiyXbBeHcLOJpBnWb9nSg21F+uFFghcB096P+C3JuIHs0Eh+LYirC9jgOMBd1aAmlgy1NltmUw9acb74g8r8UtGMZLbFBisNxtb+OQ2Mh2zIEcMsComU/0niA1zPDg6QI5qp25rMTRQ05d117eC2Y651CqrY1QsHxsekbLYjhFmDnCPaWDeESac/v1kTzBi4u7n+jIIgbfVISH3dMpb8ef4z9n45URyksDB56FAg0uj7gmw1v4KS0ljkFwzuqqUojnsGwveDI5PHR8+tcac/I2U/pVdz8AHE8WojMJlALTpLFACFXHZrnRBMMkg+NcRRUWzhoB7V3rAWI//22ovptox3da7yMQ2+IdbzEx5TYULxLiG04YNHArFKp4rAsOZB4DPx0JhLK0AcXPew
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d269c63-5399-4f18-bdad-08de7da7d307
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 06:48:08.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wrt09AgSvwAUCEznHblK5kQCtwshkLTFuCFjKN8udOITEJG2EGu2XVekWIliVFaNLTNknEl3ieTnKdK+3Q6cYKLKYa+082lPY+4vLnAD4d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7590
X-Rspamd-Queue-Id: BDF622345F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22286-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

