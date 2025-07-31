Return-Path: <linux-btrfs+bounces-15777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608DDB16A26
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 03:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9234E81C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30C347A2;
	Thu, 31 Jul 2025 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H8KQ7FI4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V3vKAU0q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9982A2D
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753925735; cv=fail; b=WpvZdb6YV9QONPEvp7OEqaCfjcmI9XFtPFApEBUvyFsV57PEi9Wn2rui4mGtDZiXkWcRI+QQzX+0dqpoeY+tuoMucIJf/1BSDXDfF4I45dNDC/Bn9tgiR8/KMHKdaD30lhVgDtyUc0FezDzYq/mmQPRqe1NVb9QbBnPeavk7TjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753925735; c=relaxed/simple;
	bh=mmxV+Fa+by4HZUB2Yb8ZOvuAQAUTxThTD8Atff7hBtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sjwY5LHQ0G/kLaWqIQd8a+yEO8wB0Gw/B6XdNwNLqQ++DnA5nw+zjc2FeUEYc9yXuaAqUSX3OEIjexZuVzTFjs25cQbfxWpHFxuCLYmUHu/ZdDOb3CzO0VHXAJCcMr5qX1SC2XyX5FG1k5tq8HaXKLtRtW3nP8sVwLcgp/bPMH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H8KQ7FI4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=V3vKAU0q; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753925733; x=1785461733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mmxV+Fa+by4HZUB2Yb8ZOvuAQAUTxThTD8Atff7hBtk=;
  b=H8KQ7FI4Rnnj0GqmcRKBs32dI53XIMlxudzMgulG0u9Z/Ytztk8HKOPk
   2N9N6ebYm+WYmUcRP5DgIQqMBMmXf6dY/SgJ0NqWYbhET9w4jbIRvi2D6
   +C29L8xfg+4VUnBBag42bJ39lF8AQIwqLxBjf4W0fJe/yBKN2x+jQ5jIw
   5Fxu7K4qJXUJ0lKT1/PY/hoR1pQVZC6iKI7T28vJm7IP4ANSMlvNmDqUm
   jdOtVFplub/0Lo52YMxUF4XzLXYSh1RFsFYqrB6Z2wP3yVIlpZ7l86owj
   59+WRwwr8GkyjabrpLwkjEbl5FSwx5Qee3jVHk1nIZ7Xpo+4eLlyfrGOZ
   g==;
X-CSE-ConnectionGUID: qjw/vknIQmKb/JEswubiIA==
X-CSE-MsgGUID: Dtp2x7b1SMirZZm4uJASkw==
X-IronPort-AV: E=Sophos;i="6.16,353,1744041600"; 
   d="scan'208";a="102243609"
Received: from mail-bn1nam02on2066.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.66])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2025 09:35:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppnyw3LDOvISgC/TbQMDhzcdHns6VpdY3rgODdaLIVRgRmoHDAgAmVcWYSnXLgu6lsbz+AdgHM3/aCgZV9N4v2Fz4We3xKglP2ZI1Z9CBn1sTnA+aaPpGWWl8m8Hj3N5asAT91WIbAuQ8/7iP0ozCbBP6k0d78EiKlyQZdWjNrXBCMUEqu43r9M2YZLKXB9nCxdzpZi8llw6Ob94oeqOdIDZdPumbbR1FkJuNsnBw3u/SRA0m3oqgmhl1Awn1qb0yDqxOBi8In/RpJW36sJETeZx7G4omJX8adrOV0L4+GmYpeXs8lktiMqj6qJ0hz+XoBQyCqpPVJdVeU0CRRPp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmxV+Fa+by4HZUB2Yb8ZOvuAQAUTxThTD8Atff7hBtk=;
 b=nlcm3zmaL2eaEcPzwi7Wop0lVGPtbwSqap9LXllVyiODFykC39HTTx+Vt4EeQXbhuHdkhJRIZj4ficBSZV01+gOnYHU6hQnda38iFKplRjcSWXFR8Rflcp5d5Vvv//JYV0ysdz5gz8iPfKUS2jHktCHqBHiiFpTkNKLfMFVZAE8hRMWSkOeopiKp/JyLRq65i15g03OFwwwH4Vb36pjsxd11R0Pu/8EZLLMuhVTKcPIeT88QGVaC7W6bbPB5Hjg4NNmKLVUFjA2lkCPaNbsiXMExNCG2MhC2OdgzwmDmlSuGEUcEbAc1hXb3ekSXSbPJg5AvYKSvvu8i+m04Sl1Gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmxV+Fa+by4HZUB2Yb8ZOvuAQAUTxThTD8Atff7hBtk=;
 b=V3vKAU0qXDcL+2Lz1l592PxE2GOlOKpNVIMHYJe9VXz8Ry2lvVAm7RwSoP+GiGmMlwttatu0tB60xtvLWna0YRoQ852fXf5LqlJBSr4Fjqa3Aek3jxFxID3JsVqVyu2of5BSAB0C+kTsY9k5H3BQ8KtSCPEqZ3rQhfwgqWfUfbI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH3PR04MB8861.namprd04.prod.outlook.com (2603:10b6:610:172::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Thu, 31 Jul
 2025 01:35:23 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 01:35:23 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: WenRuo Qu <wqu@suse.com>
Subject: Re: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Thread-Topic: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Thread-Index: AQHcAT3Hf2fNO+Z5wECNV1otilOkXLRKhUSAgADvAwA=
Date: Thu, 31 Jul 2025 01:35:23 +0000
Message-ID: <DBPUS1L6BU5A.140W3GNWAF15K@wdc.com>
References: <20250730103534.259857-1-naohiro.aota@wdc.com>
 <dde2b8b0-49a1-4f3d-aa26-c1ab635b42a1@gmx.com>
In-Reply-To: <dde2b8b0-49a1-4f3d-aa26-c1ab635b42a1@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH3PR04MB8861:EE_
x-ms-office365-filtering-correlation-id: 30f413f2-976b-4c8c-9783-08ddcfd2849f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHdRVHppVWJnN1NndzNna0o5aC9LcjBGcW04VUhHOVFreXMzY2VzVkkvdXRV?=
 =?utf-8?B?ZEV2VG1OU05VQTl2dTFGdVBrY1BjQmZiaWFub0hLRUEwM1ZvSHhnZGo2eHBm?=
 =?utf-8?B?enVyM0MzMS9qUlRUTW10WG05UlZheDJ2d1NpZFJ5c2FvY1VWc1RCdVlkK0N4?=
 =?utf-8?B?TDY5SWh2bDY1VDVEcXMxSHhXNGR6NndXQmJ2N21kaHVIYlhEcnpEUDJVSnlE?=
 =?utf-8?B?VlFlSWtPV0dyU1ZPTG83RTFibHdyYm1oOVJ3WmxEcnpTRlFoY1lxRGxkNjhZ?=
 =?utf-8?B?RG9JZnk0dkt3RC8xVmp2emkvNkFHT0ticHFGSlhBSHBQQWs3alRDN2lIU3RF?=
 =?utf-8?B?ZDNPVHFYdkVtYkxPdnIvRFY4cENPc0x3UVZ0L25pRWwvQVJ5Q2FRTUtwOGlk?=
 =?utf-8?B?UE1kMzJiOStzd1JSdDJtSU9NTHRhOTVwN0YyUVJBcDl4UEpSS1gzcFhXNnA1?=
 =?utf-8?B?aTNhNG56TURPZkFHWWxBQWRmbUZIZURhS3ZVYitObkpUOXlDYjVhRjJYNlFo?=
 =?utf-8?B?ZXpPbU5hMUFHS3JybVB2MVArZFJhMmpYbnU2RmxuYjNaMHhHVnZBMDc1UGFG?=
 =?utf-8?B?RDNDWHlROFNrOE94ZHJFdnYwVkw3MTg0QW1hQkVsZi9MOUsvQkdya1ZLa1Qr?=
 =?utf-8?B?V28rVU5pSXlJODBqSUZ5OW5jdjZMekhlakY5M0tzSGo0YXRkTFArVGl3cEdE?=
 =?utf-8?B?ZUJwMnZGdm1iakxuSTVTNW9hR1FDVXBScExOaFZ1UlhFc3dmbjNGT1VPKzlU?=
 =?utf-8?B?U1AvVE9lY1ZGcHZiUWtGUXNHM3ltTnNRVS9JVzB6c0JnaVpEOW5DNzJKQURV?=
 =?utf-8?B?SHk4MlNyV24rMTloZ0xTRkNKdFMyYjRBQnNTYWRmQW9idGYrQkdNUzZmRWJN?=
 =?utf-8?B?Zi9icGZSalhsTzgxc0g5TExhY3MydWJoVXhWVTJUQ0ZiSDUrRFFrMGkwUFJH?=
 =?utf-8?B?dkt0enUvMTQ4aVZKTGhFMzk0TWNSaDQ3Ym1DWTcxajdtQVRtL3Job2RkdXlu?=
 =?utf-8?B?eU43dUE1bmsrV1lqYnloWEE2RnVZN1dwSkYyM01Wd0dLeWU4UDNnaDZVRHZE?=
 =?utf-8?B?V3lVRXF6TzRFQ21Td1RBbFRlOFd0WDFrVTdMU1A5SW9iQmlOVjZxRFNPdDVR?=
 =?utf-8?B?R2pUT1JWaGdGa3U4b0YwMFdiZU5yZXdVT3NuK25MbHVuOGsxdEFsUk9mUm8v?=
 =?utf-8?B?WlVQR1RvZGQ5SHhHbUlPSGI5cnlIN2JIWDI2YWkzU0ptbXlWblp4c1dDL3V4?=
 =?utf-8?B?bHJ1QUxmNDJ6UnJqNlZCVHhHa3Z5a3J2YmRNd0VxNC9ubldTMDZxaXJFSnd2?=
 =?utf-8?B?ZG40dVczdFRMd052ZmdxR2lXZiswOUpQTjllemJEVlhYSkJEZEZiUFYzME1F?=
 =?utf-8?B?TE1IcWFWRUdsTDF3eStjZkFiZE1FcWw2MTFRNDNpNHpZWHZ5OC9HZWxoMWtK?=
 =?utf-8?B?SjJKMDF1dk00UXEybnhFdnE1VDlva0REZUpMQ0ZhemJtd2ZST3VtYjlVK2FD?=
 =?utf-8?B?cC9lQXc5UDNhVTJJVEVVdXo1bFpXTENTWXFaRkRIc1hqVzBWWGszYllEdUFU?=
 =?utf-8?B?NDkzMFowWlczN1ZMbFNOWVZJd1laOXY0WEkvSmFKNWtwMGliMjZqR1VSaFR0?=
 =?utf-8?B?c0J0SytMSUs2b3NFbUx3RW5lR1JkQ1RaSTdmQVVIcXdBbldqRTRHNVRON0hF?=
 =?utf-8?B?N0g3UEJLc3hCN3hieXdoMlBWZ3NPUFpMSnREWC9KMUN3TURUZkE2d0s2UUZa?=
 =?utf-8?B?R1JEbHBjeVprNlVKOFJLT3BSbHp2YS9veUc0MC9YQTdlbm9vUmREbHdaWTJl?=
 =?utf-8?B?NEkvSkJwRExZRC8vdExReXo3M252VFlnb2pvdWhYWnhLeTM2ck8vOU9SWXlZ?=
 =?utf-8?B?RkwwSGtpeXZiajlEazNzOWhaYmlZRytpN3JkM0s2K01YZjI3T2RPSXgrcXV5?=
 =?utf-8?B?SXdQWDE5aG1pdTFCYW43Qnd2ZTRHQzVPT2drbkhGZmQ4RWhVL0NOb1dHbk9C?=
 =?utf-8?B?TStpeEd1WjZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFN4Nmo1b2RLcU1pRlBXY0pqVzZYWUZaUDFLUjNWYzVVUkU4VkwxcEJIRGU5?=
 =?utf-8?B?eHBFKzFPZUFmZU1jZFFhS3VlQVNpWGJFZGgwWGdDeHdqZzR6dUtVZUgyUjB3?=
 =?utf-8?B?anJySjJyakxoZ1NkMVF1RFBqdHV5dm5iZ0RrT3A3ZFdvZDY3enFkc3p2SFBx?=
 =?utf-8?B?QkpQNmVaNWpOWWxlMUlpcGMzNXVhY3J1a3haMXlOdFNJSlpaN0ZQOWtXYmVU?=
 =?utf-8?B?aU9hZW02UWxHYUkxMTcySEZ5c3pRM1RvY3RxVWxETEN4VU9iMks5aGxUQ2F5?=
 =?utf-8?B?QVBSdXV3MHJobFFBcmc0bnoxME9HNGpOWGxlMDZEQnJIWFY5OHZiTGdkeSti?=
 =?utf-8?B?elcyRkxBUlhCeGpidW1tajZYQ3JYRkpnVitCdUd6dC9IbHFIN0JkR3VNZ2F4?=
 =?utf-8?B?RWIya0pIOWhYbmxsVklSRnkxQlJNbGxacVBzU0orUGY2a09pRnZRUy91WjNy?=
 =?utf-8?B?blJ3Tm5ua0FJQXZGOUJra1dhN1YvR0FWcTgrNGlkK2pIUzVrbjZMZFN2dWg1?=
 =?utf-8?B?SWp6R05OUWZYcUYwa0MrQi9nZjl4YTZOVndVRnVsenBhN0dQTWIvZGFiQnRx?=
 =?utf-8?B?Q0RqdWxmUTQ5SmxwNFRGWU9WUHdwNWgzcmUwYTZWTHlLK1pMMVJNRXNCeTla?=
 =?utf-8?B?VnBvZVBsNjlnd0xWNzFMeXFUT0UwRmZ2NjJlSnBicE5kbjNDUGNzVHNpck5j?=
 =?utf-8?B?dHEzbVg1MlUvZ1JlT2F3cHhxaHpwUFh0c2FDQUNTK3dzRzNCR0pRMjRtZ3o2?=
 =?utf-8?B?QjU1YVlhUVFMYkNnV0p4TFlJVmFEV3E1bjFKR2pndjFxZkkvOHA0YmpHSzBC?=
 =?utf-8?B?L0lzeGpVT0hHbHdYdWtVZk9WaDN2Z1Q3bVpRNXZHRnhmbDMybWZaRk4wTkt5?=
 =?utf-8?B?b2xaUkx3SGp0MnhDYkIvbzI5TmZuWWRrcWRFaTc3VHdmM1IvNmZkekFoTlEy?=
 =?utf-8?B?UitGVkZQbmlEZWVmT3JjaFl5NmI1bUdoSUY0N05laUp1QjNjRjJ3Wll6WTZU?=
 =?utf-8?B?WFdnekNwR3I0YjFLYldycjQxUWdVMElzaGNZd3ZhT1BVYVFrQmxERlFDU0ts?=
 =?utf-8?B?V292ZzZTdlUyc3dEZmtKT2VNaE55NEkzczdOaVZQMzVqL1grOXZ3N0dvQUdi?=
 =?utf-8?B?cXRubzJJU0MrbWhKN1ZTUklwQUhnbEp1Sm1MNDBta2l6aWYyV3JiV1oyUy9j?=
 =?utf-8?B?ZHNraW50QXkvTXBxT1RIeFF3SjcxU2tKa3luZVZNWHZZVVFST1QzUmRsTGM5?=
 =?utf-8?B?SGlQVDV2VTk3Nk45bmpmQXIwR29KRFd2NnU5OXpCWXE3VWVyL3J6TFF4YW0v?=
 =?utf-8?B?S1Y0UElkRVdZdlFUQXpjNFZBbXMrNmZrdnNueWlJZmtIUFNkUWJmN0ZPWG1G?=
 =?utf-8?B?MGRzK0IxMC9LNXB0WEdVVlRmWVdEV25Qb3ZLVGZZVDZ3cTJxYkNxQzJVL2x6?=
 =?utf-8?B?a0hSaGpKanVqYmdkVFBOaVlWbHpYdnVJMk92VUVzWWg1SnlIZ2ZSYnZpR1Jm?=
 =?utf-8?B?b2NlQ0NwRDFOR0RMMVBVa3V0dmNmbzEvMVRKblJ5K2NpSmtTZ1h1Q1RwNllz?=
 =?utf-8?B?WGtuMnQxT3pNSjJHN241azBiQ1hTNEY0d3RpZ2F1Zk1odGltTHhpRm55QUhl?=
 =?utf-8?B?Rk5McFlneTJQZ1dLOTFZaXUycEltcFh1RHRLVjJyVkFvOEZJcWJaQVVkdGdJ?=
 =?utf-8?B?L1AzUi8xeUF2T2J4eGxkOEZlVlc4RXFZcllDYzIxQWVCTmp0Mk5jTWIzbzZJ?=
 =?utf-8?B?a1dneUttS29sNlpEcXg1c3Qwd2p6Z3NDd04wdzVhQzNOS25paGJsTUNORzhE?=
 =?utf-8?B?bjlkb0VXb1FiUUtpK0RjTWdJS0o3bTJlYk0zZzdtb3M1cmtOV3JLUUp2aVhw?=
 =?utf-8?B?aG5IcTB2YUt3cmhFcS9ubTYvK3Q3enFteldkQ2tiTHViWkdlR0JuemtZdkF5?=
 =?utf-8?B?eWJuWmRSYTVNaWc5Y1RheUhucDl1K21TSFh5MEltTHpPakVkU2NpVjdYaUVZ?=
 =?utf-8?B?aWhjY0JUQUlmR0g4a2N0WDBvS2dkSXAwMm5yWnhGY29CUFVPL0dZUjJQU2pv?=
 =?utf-8?B?YWEweldlUWNQT09uRi96a1gvdHc0TExGKzU3c210ZE9DdmVaZzJSbi9nUnBF?=
 =?utf-8?B?SEJ6N2RzWjNEZ0J4TkptL1F4V2Q0SFRHQk1xNk1TdktrK05HS216Wmc1amJm?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A952D80A892ADB45B8B7FCA928AF5D58@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NQsAoMLnF/zcyb3JnHteWMEPdbV9W8fNR6bb7K2MvhDfjv4UjUXsgjInxad7rVB+jLzoEbYlNgY6Ba9uX8Tm4Q7ggwFleXmLlw3t+g4EPqRSW6kJD+S1u7XEKdgktQDR5wW9G1nn3jjE/8hZctOT0n+G1AQ4SvI7nZVGaSL/DEO6F21FW6KDT/wM1yYOs6RmZfr0zZmJScLfqyjhv18z3pZOyw4sy07sZVzw3JQprduZirhaP5QmiqAkYSH0IcfaVp9OTRAu6ZbyHqrZNcBo8RfzSPfZJcu7G0/H5BGrhmB/ZrbnpUcSr1oSLMMdSm/yr61rD63lXChPwyRrL8EN1j88oX953z1+YA6c8GODVtqGtjFCHuDnTuLY8toOx3zMOlcrslafn7ZzLeyzhOatoKkeKsJcE3X//Iwuw8VsSjh6C9nxPTRuQ09rxkZCDmq1oWVc80JLntih8s6XhG6VX+40a8p68/f65xrFevzxi9lx5SRiO2Q/mWLKxW3Z1G31u/bTAsZnC4mQrOIIra5S0W1iY8UFn2YxpE87me485yUh+7xs6nGNLuDiKuAXX/iZh89Wuzf2Gn1oeQkum8ZCxN39SkkyjAsOjMTUjS4f0g8YzQAUNfG9MnV8S5ruegCg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f413f2-976b-4c8c-9783-08ddcfd2849f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 01:35:23.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRoVgtvbSxPl8zgDmku8nVG/hkggTlLDnvRaryVrhGS2u0Y3XDlWiOy294DGuNdztewz2ioSOZzp72GQ6VbL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8861

T24gV2VkIEp1bCAzMCwgMjAyNSBhdCA4OjE5IFBNIEpTVCwgUXUgV2VucnVvIHdyb3RlOg0KPg0K
Pg0KPiDlnKggMjAyNS83LzMwIDIwOjA1LCBOYW9oaXJvIEFvdGEg5YaZ6YGTOg0KPj4gYnRyZnNf
c3VicGFnZV9zZXRfd3JpdGViYWNrKCkgY2FsbHMgZm9saW9fc3RhcnRfd3JpdGViYWNrKCkgdGhl
IGZpcnN0IHRpbWUNCj4+IGEgZm9saW8gaXMgd3JpdHRlbiBiYWNrLCBhbmQgaXQgYWxzbyBjbGVh
cnMgdGhlIFBBR0VDQUNIRV9UQUdfVE9XUklURSB0YWcNCj4+IGV2ZW4gaWYgdGhlcmUgYXJlIHN0
aWxsIGRpcnR5IHBhZ2VzIGluIHRoZSBmb2xpby4NCj4NCj4gSSdkIGxpa2UgdG8gY2hhbmdlIHRo
ZSB3b3JkcyAiZGlydHkgcGFnZXMiIHRvICJkaXJ0eSBibG9ja3MiIGhlcmUuDQo+DQo+IEFzIHdl
IGNhbiBoYXZlIHN1YnBhZ2UgYmxvY2sgc2l6ZSwgYW5kIGluIHRoYXQgY2FzZSB3ZSBjYW4gc3Rp
bGwgaGF2ZSBhIA0KPiBzaW5nbGUgcGFnZSBzaXplZCBmb2xpbywgYnV0IG11bHRpcGxlIGJsb2Nr
cy4NCg0KWWVwLCBJIHRvbGQgdGhlIGlzc3VlIGZyb20gdGhlIHBvaW50IG9mIHRoZSBsYXJnZSBm
b2xpbywgYnV0IHllcywgaXQgaXMNCmJldHRlciBhbGlnbiB3aXRoIHN1YnBhZ2UgdG8gdXNlICJk
aXJ0eSBibG9ja3MiLg0KDQo+DQo+PiBUaGlzIGNhbiBicmVhayBvcmRlcmluZw0KPj4gZ3VhcmFu
dGVlcywgc3VjaCBhcyB0aG9zZSByZXF1aXJlZCBieSBidHJmc193YWl0X29yZGVyZWRfZXh0ZW50
cygpLg0KPg0KPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZ2l2ZSBhbiBleGFtcGxlLiBJIGJlbGll
dmUgdGhpcyB3b3VsZCBsZWFkIHRvIA0KPiBoYW5naW5nIGJ0cmZzX3dhaXRfb3JkZXJlZF9leHRl
bnRzKCkuDQoNCk9LLCBhcHBhcmVudGx5IGJlZm9yZSB0aGUgcGF0Y2gsIHJ1bm5pbmcgZ2VuZXJp
Yy80NjQgb24gdGhlIHpvbmVkIHNldHVwDQpmYWlsZWQgd2l0aCBhbiBBU1NFUlQgZmFpbHVyZSBi
ZWNhdXNlIGl0IGZhaWxlZCB0byBlbnN1cmUgaV9zaXplDQp0cnVuY2F0aW9uIGhhcHBlbnMgYWZ0
ZXIgZmx1c2hpbmcgb2YgZXhpc3RpbmcgZGlydHkgcGFnZXMuIEknbGwgYWRkIHRoYXQNCmFjdHVh
bCBmYWlsdXJlIHRvIHRoZSBjb21taXQgbG9nLg0KDQo+DQo+PiANCj4+IENvbnNpZGVyIHByb2Nl
c3MgQSBjYWxsaW5nIHdyaXRlcGFnZXMoKSB3aXRoIFdCX1NZTkNfTk9ORS4gSW4gem9uZWQgbW9k
ZSBvcg0KPj4gZm9yIGNvbXByZXNzZWQgd3JpdGVzLCBpdCBsb2NrcyBzZXZlcmFsIGZvbGlvcyBm
b3IgZGVsYWxsb2MgYW5kIHN0YXJ0cw0KPj4gd3JpdGluZyB0aGVtIG91dC4gTGV0J3MgY2FsbCB0
aGUgbGFzdCBsb2NrZWQgZm9saW8gZm9saW8gWC4NCj4NCj4gSW4gdGhpcyBjYXNlLCBJJ2QgcHJl
ZmVyIHRvIGhhdmUgc29tZSBzaW1wbGUgQVNDSUkgY2hhcnRzIGV4cGxhaW5pbmcgdGhlIA0KPiBz
aXR1YXRpb24uDQo+DQo+IEUuZy4gd2l0aCAxNksgcGFnZSBzaXplLCA0SyBibG9jayBzaXplLCBu
byBsYXJnZSBmb2xpby4NCj4NCj4gICAgICAwICAgICA0SyAgICA4SyAgICAgMTJLICAgICAxNksg
ICAgMjBLICAgIDI0SyAgIDI4SyAgICAzMksNCj4gICAgICB8Ly8vLy8vLy8vLy8vLy8vLy8vLy8v
Ly8vLy98Ly8vLy8vfCAgICAgIHwvLy8vLy8vLy8vLy98DQo+DQo+IFJhbmdlcyBbMCwgMjBLKSBh
bmQgWzI0SywgMzJLKSBhcmUgZGlydHkuDQo+DQo+IEkgYmVsaWV2ZSB0aGlzIHdvdWxkIGJlIGEg
bGl0dGxlIG1vcmUgZWFzaWVyIHRvIGV4cGxhaW4ganVzdCB1c2luZyBmb2xpbyBYLg0KDQpTdXJl
Lg0KDQo+DQo+PiBTdXBwb3NlIHRoZQ0KPj4gd3JpdGUgcmFuZ2Ugb25seSBwYXJ0aWFsbHkgY292
ZXJzIGZvbGlvIFgsIGxlYXZpbmcgc29tZSBwYWdlcyBkaXJ0eS4NCj4+IFByb2Nlc3MgQSBjYWxs
cyBidHJmc19zdWJwYWdlX3NldF93cml0ZWJhY2soKSB3aGVuIGJ1aWxkaW5nIGEgYmlvLiBUaGlz
DQo+PiBmdW5jdGlvbiBjYWxsIGNsZWFycyB0aGUgVE9XUklURSB0YWcgb2YgZm9saW8gWC4NCj4+
IA0KPj4gTm93IHN1cHBvc2UgcHJvY2VzcyBCIGNvbmN1cnJlbnRseSBjYWxscyB3cml0ZXBhZ2Vz
KCkgd2l0aCBXQl9TWU5DX0FMTC4gSXQNCj4+IGNhbGxzIHRhZ19wYWdlc19mb3Jfd3JpdGViYWNr
KCkgdG8gdGFnIGRpcnR5IGZvbGlvcyB3aXRoDQo+PiBQQUdFQ0FDSEVfVEFHX1RPV1JJVEUuIFNp
bmNlIGZvbGlvIFggaXMgc3RpbGwgZGlydHksIGl0IGdldHMgdGFnZ2VkLiBUaGVuLA0KPj4gQiBj
b2xsZWN0cyB0YWdnZWQgZm9saW9zIHVzaW5nIGZpbGVtYXBfZ2V0X2ZvbGlvc190YWcoKSBhbmQg
bXVzdCB3YWl0IGZvcg0KPj4gZm9saW8gWCB0byBiZSB3cml0dGVuIGJlZm9yZSByZXR1cm5pbmcg
ZnJvbSB3cml0ZXBhZ2VzKCkuDQo+PiANCj4+IEhvd2V2ZXIsIGJldHdlZW4gdGFnZ2luZyBhbmQg
Y29sbGVjdGluZywgcHJvY2VzcyBBIG1heSBjYWxsDQo+PiBidHJmc19zdWJwYWdlX3NldF93cml0
ZWJhY2soKSBhbmQgY2xlYXIgZm9saW8gWOKAmXMgVE9XUklURSB0YWcuIEFzIGEgcmVzdWx0LA0K
Pj4gcHJvY2VzcyBCIHdvbuKAmXQgc2VlIGZvbGlvIFggaW4gaXRzIGJhdGNoLCBhbmQgcmV0dXJu
cyB3aXRob3V0IHdhaXRpbmcgZm9yDQo+PiBpdC4gVGhpcyBicmVha3MgdGhlIFdCX1NZTkNfQUxM
IG9yZGVyaW5nIHJlcXVpcmVtZW50Lg0KPj4gDQo+PiBGaXggdGhpcyBieSB1c2luZyBidHJmc19z
dWJwYWdlX3NldF93cml0ZWJhY2tfa2VlcHdyaXRlKCksIHdoaWNoIHJldGFpbnMNCj4+IHRoZSBU
T1dSSVRFIHRhZy4gV2Ugbm93IG1hbnVhbGx5IGNsZWFyIHRoZSB0YWcgb25seSBhZnRlciB0aGUg
Zm9saW8gYmVjb21lcw0KPj4gY2xlYW4sIHZpYSB0aGUgeGFzIG9wZXJhdGlvbi4NCj4+IA0KPj4g
Rml4ZXM6IDU1MTUxZWE5ZWMxYiAoImJ0cmZzOiBtaWdyYXRlIHN1YnBhZ2UgY29kZSB0byBmb2xp
byBpbnRlcmZhY2VzIikNCj4NCj4gSSBndWVzcyB0aGUgcmVhbCBmaXhlcyBjb21taXQgd291bGQg
YmUgZXZlbiBlYXJsaWVyPw0KPg0KPiBFdmVuIGJlZm9yZSB0aGF0IGNvbW1pdCwgd2UncmUgYWxy
ZWFkeSB1c2luZyBzZXRfcGFnZV93cml0ZWJhY2soKSB3aGljaCANCj4gaXMgdGhlIHNhbWUgYXMg
Zm9saW9fc3RhcnRfd3JpdGViYWNrKCkgYW5kIGNsZWFycyBUQUdfVE9XUklURS4NCj4NCj4+IEND
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNi4xMisNCj4NCj4gSW4gdGhhdCBjYXNlLCB0aGUg
c3RhYmxlIHdpbGwgZ28gYmFjayB0byB0aGUgaW5pdGlhbCB2NS4xNSBzdWJwYWdlIA0KPiBzdXBw
b3J0Li4uDQoNCk9oIHdlbGwsIGl0IHdvdWxkIGJlIGEgYml0IGhhcmQgdG8gYmFja3BvcnQgdGhl
bi4uLg0KDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3
ZGMuY29tPg0KPg0KPiBUaGFua3MgYSBsb3QgZm9yIG5vdCBvbmx5IGNhdGNoaW5nIHRoaXMgYnVn
LCBidXQgYWxzbyBmaXhpbmcgaXQuDQo+IFRoZSBjb2RlIGxvb2tzIGdvb2QgdG8gbWUuDQo+DQo+
IFJldmlld2VkLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4NCj4gVGhhbmtzLA0KPiBR
dQ0KPg0KPj4gLS0tDQo+PiAgIGZzL2J0cmZzL3N1YnBhZ2UuYyB8IDE5ICsrKysrKysrKysrKysr
KysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3N1YnBhZ2UuYyBiL2ZzL2J0cmZzL3N1
YnBhZ2UuYw0KPj4gaW5kZXggYzliMzgyMTk1N2Y3Li42N2NiZjBiMTViNGEgMTAwNjQ0DQo+PiAt
LS0gYS9mcy9idHJmcy9zdWJwYWdlLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL3N1YnBhZ2UuYw0KPj4g
QEAgLTQ0OCw4ICs0NDgsMjUgQEAgdm9pZCBidHJmc19zdWJwYWdlX3NldF93cml0ZWJhY2soY29u
c3Qgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sDQo+PiAgIA0KPj4gICAJc3Bpbl9sb2Nr
X2lycXNhdmUoJmJmcy0+bG9jaywgZmxhZ3MpOw0KPj4gICAJYml0bWFwX3NldChiZnMtPmJpdG1h
cHMsIHN0YXJ0X2JpdCwgbGVuID4+IGZzX2luZm8tPnNlY3RvcnNpemVfYml0cyk7DQo+PiArDQo+
PiArCS8qDQo+PiArCSAqIERvbid0IGNsZWFyIHRoZSBUT1dSSVRFIHRhZyB3aGVuIHN0YXJ0aW5n
IHdyaXRlYmFjayBvbiBhIHN0aWxsLWRpcnR5DQo+PiArCSAqIGZvbGlvLiBEb2luZyBzbyBjYW4g
Y2F1c2UgV0JfU1lOQ19BTEwgd3JpdGVwYWdlcygpIHRvIG92ZXJsb29rIGl0LA0KPj4gKwkgKiBh
c3N1bWUgd3JpdGViYWNrIGlzIGNvbXBsZXRlLCBhbmQgZXhpdCB0b28gZWFybHkg4oCUIHZpb2xh
dGluZyBzeW5jDQo+PiArCSAqIG9yZGVyaW5nIGd1YXJhbnRlZXMuDQo+PiArCSAqLw0KPj4gICAJ
aWYgKCFmb2xpb190ZXN0X3dyaXRlYmFjayhmb2xpbykpDQo+PiAtCQlmb2xpb19zdGFydF93cml0
ZWJhY2soZm9saW8pOw0KPj4gKwkJZm9saW9fc3RhcnRfd3JpdGViYWNrX2tlZXB3cml0ZShmb2xp
byk7DQo+PiArCWlmICghZm9saW9fdGVzdF9kaXJ0eShmb2xpbykpIHsNCj4+ICsJCXN0cnVjdCBh
ZGRyZXNzX3NwYWNlICptYXBwaW5nID0gZm9saW9fbWFwcGluZyhmb2xpbyk7DQo+PiArCQlYQV9T
VEFURSh4YXMsICZtYXBwaW5nLT5pX3BhZ2VzLCBmb2xpby0+aW5kZXgpOw0KPj4gKwkJdW5zaWdu
ZWQgbG9uZyBmbGFnczsNCj4+ICsNCj4+ICsJCXhhc19sb2NrX2lycXNhdmUoJnhhcywgZmxhZ3Mp
Ow0KPj4gKwkJeGFzX2xvYWQoJnhhcyk7DQo+PiArCQl4YXNfY2xlYXJfbWFyaygmeGFzLCBQQUdF
Q0FDSEVfVEFHX1RPV1JJVEUpOw0KPj4gKwkJeGFzX3VubG9ja19pcnFyZXN0b3JlKCZ4YXMsIGZs
YWdzKTsNCj4+ICsJfQ0KPj4gICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYmZzLT5sb2NrLCBm
bGFncyk7DQo+PiAgIH0NCj4+ICAgDQo=

