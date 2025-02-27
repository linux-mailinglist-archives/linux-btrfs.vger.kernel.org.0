Return-Path: <linux-btrfs+bounces-11896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A4A4764A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 08:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A74D170184
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338D2206A6;
	Thu, 27 Feb 2025 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fqTCp1UT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ckyR0+Qf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA721B9F2
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639999; cv=fail; b=bQfPtfsDdL5vL4atKpS0kQHd7QmvGRzATiAqYfNyhGdP8yfiefvhXVNF4WjKr2mcOLd50C3IIo4Y5pzV6YaUhcKmAum8Hj56ZZc4BnMZ8IY0dvwabderhLtQCVm2k8BZptqOmcJIk/hjY2iCByZZZkLOjX7cAeSJw6mPdDhaJ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639999; c=relaxed/simple;
	bh=opf7+H7AmblR+m4kjXUDFWyuL2L/6cAfsG0k7yfTnu0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fY8HFN6rwQCm+3PQQbj0MMjT2y5ECMAlu84ZaQTKqKy01H3elfPJ2jZAZ5XTgVHN3MgumpOJQHAI7IhXpkKXIwiqkbyhgenROaY8hjc/6t/ojGuuKEDR3y7Y62qk+8WRsb6dpZZyQYlrhwGBnSm9vYL3bH1+iBN4lA6we/rJ0t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fqTCp1UT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ckyR0+Qf; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740639997; x=1772175997;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=opf7+H7AmblR+m4kjXUDFWyuL2L/6cAfsG0k7yfTnu0=;
  b=fqTCp1UTc9Y0VSZ8zzPOvFOnzStC8fBYna/GtjwmUHYE5AlbAWb5YXea
   VHGuMEDnpDueQnTbsslWmAmtRctG8Hi3d/MJevHpds1bJvh1+6OqNnFw7
   MMjiQeeQ+/5emP5i0J6CAE8W136LgfgIBXSYYS8z22CQ9WZmR/SJC4Lsj
   xueR6OU6Yc4cl7moSWcJJqh1rboJRAYewH1M8l6Uh+CfOASxIRhYE9ivR
   U/yvTv1lvz/3W/eV+ARdaFsdWpcWfL9XxihZC7ENO3YLFUgnFQBMeRubF
   XS+2BWFTR32+jP3Y2PGhB72kBgl8L5vZC1sVoqrzojS0SYkbgsUsH9rfm
   A==;
X-CSE-ConnectionGUID: PXEMonloRm2K2T8P9Jj2hw==
X-CSE-MsgGUID: Q+JwRdsET9KZa1hdqDZBpQ==
X-IronPort-AV: E=Sophos;i="6.13,319,1732550400"; 
   d="scan'208";a="39575518"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.9])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2025 15:06:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVJu6upkzZIXdDCFACUjWfxxThDNMpQOZFVqlpzhtAFtwQ6fqbR+FHwkvEYUx4NgGK3Ca1+E/UA8/NBMVCyMKj8rEoZ5UqUc7TbYC8KXxGTbQ4RRn6aCssEEN1fhl4/U6veJR0khI/JaLJ2Z/wd/STOyhEWy7lvh2qMHMSbJ6pTlyKYoky+gWLymC2/0jT0xX1dqPD9kHWNob/zMUmC0LsN3rkelm1GTz/Rfuidr3193iz4R7actziunkbaAxdv6cI0AutexQU/RumDr4ys08dLtIPTiTYIEYbDA8BSJ5HehX6BdulJO7kmUNOc+G5/V4/AqsAZRRVTJHGL3t3RgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opf7+H7AmblR+m4kjXUDFWyuL2L/6cAfsG0k7yfTnu0=;
 b=utlVzRBNERlaLTm4H0N7upBGc3ox8iqnsF5bLwTlsPgghHaPAkl+vquinGCzr0JewZWjiDqVHK4sr6/dsZkrIwRHrDF3U8yptVsB+9gEdsBwKYWvFXXzdHKZOX7/Le78CfPV4L3ahhkXEu6vxltl8eX/bs1BmVRekw5z86QaQu/kkua4IpJR+VG2k2ge8x2ofMw2+zDu/7uxWn6Rvg8pq0rDjKeT7aT+tWkdHigR9CpxnhUbIBp/zWevSrJsQrnwjfpvmBMkwUXqRrnSDbWGPPH8XHqV0wbjwUcrFjW84ZQbYEHg7tckl8xfLemUnatyCNb8cLjOehB/yyN+Wx+A9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opf7+H7AmblR+m4kjXUDFWyuL2L/6cAfsG0k7yfTnu0=;
 b=ckyR0+QfzkhjR0rxAW45JL0htJyBxn2YRxcCqyk4asFW9htsQPQ0J8nMBT801SIQVkzcybnr/lzkrZ1ZI1h0jaybwFv8KrDouRY5UZ5CQYVDV7OZgjymK/OSAJBQi6ZlucKW2NREY/8oryfNn9dCdzLTj6IOoXDfNyFfxx+s/nY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9132.namprd04.prod.outlook.com (2603:10b6:610:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 07:06:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 07:06:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 27/27] btrfs: use BTRFS_PATH_AUTO_FREE in
 load_free_space_tree()
Thread-Topic: [PATCH 27/27] btrfs: use BTRFS_PATH_AUTO_FREE in
 load_free_space_tree()
Thread-Index: AQHbiDR0giB0iI7rM02336NdM96nIrNau9QA
Date: Thu, 27 Feb 2025 07:06:29 +0000
Message-ID: <62a7bbf3-e029-4a54-99f2-48d969768aab@wdc.com>
References: <cover.1740562070.git.dsterba@suse.com>
 <f78c8e236bf2d9975f033e08f33ce7d088267b11.1740562070.git.dsterba@suse.com>
In-Reply-To:
 <f78c8e236bf2d9975f033e08f33ce7d088267b11.1740562070.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9132:EE_
x-ms-office365-filtering-correlation-id: 3ad99a28-4412-4044-b361-08dd56fd4205
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDJtcVpLODJiWHNkT2J4TFdEMVlYM3pQVEJtRncrWUZKNnBsSXdmQ1ZwK2lV?=
 =?utf-8?B?Y1d2d0pYd0xvelFGaGp2YWpZUnpMYVJyYXdRVEtPOHhsamVJYnZmZmRPWk1H?=
 =?utf-8?B?MHZzdDN5SlNUc05scy9ScWVqbFZ5NHovU1VaSlo0bjl2T1Yrck5HSDk4Zmpn?=
 =?utf-8?B?U2s1RGZHWEdkRzFqbzV5Qm5maVpGb3BNVE5ybTR2Rkkwdjc5N3R3dU1KZG00?=
 =?utf-8?B?NUFFbmxFWU80UE1PL1lyU3BWM3RWVXQzdjFIcVFNbklJek1PRjdCQXlQYSt0?=
 =?utf-8?B?bXp6UW1vY0ptZFBxN2kzL3RXUkpQV3pCN2UwRzhXV3Q1N3YyWnYvSTRmS1RK?=
 =?utf-8?B?a3d6dUpkOG45VjBMSzBMbTBhN0cvalFEN0hTSWc1ekd0OStHRHpBRGZrUUk2?=
 =?utf-8?B?anhNNk94YVpZZ2lvcXlUVDlOWCt4MnFZYzI0bVFTUEZvaDFlZWFoTnJ6dmQw?=
 =?utf-8?B?dlk0Z1Fkb2RTQ29GcHN2RHJ0SUczajVURHJ5ZG5QQlZUZUJlalZTdnY3YW9x?=
 =?utf-8?B?b3ZkU0trb2FTMVpGVktXb3RqVWRPSzVLYlJ4OC9hTjF2WHE0ZGU4ODRlbFFY?=
 =?utf-8?B?ajBXZHVRdGpoZ3NEcFZxMlVYSHBUbGk5bDF0T09kd1dPTlFvZ0swU1I4enM0?=
 =?utf-8?B?QVk2Rlc5R2ZjT1FnU3ZJbWVBOHVKb292N2ZVSWtKZW9mNGZwRXdNNmlZcVo3?=
 =?utf-8?B?NDRrWTVJbDRmei9XSmt5TjRyN2VKRVdnVUVnOGxIV0dRR2F3cFhkMmNwendk?=
 =?utf-8?B?S3FrVGdlNVNmN1NjV2J4dVJtaGU0Y1o5RnluT2IwenIvNUdSa29heGkwbXFR?=
 =?utf-8?B?WmlTU3hlaU5ZOXJIenlidFpWUi9wZTBYdnVjQTVJWmUwMVBRSkZhS2ZiUlR0?=
 =?utf-8?B?MDkrK3BxTm50V0lkUjNmVzR5VGptS2pyL3NOZFN5Wi9qY1p2MmlTeFlDQlcy?=
 =?utf-8?B?d1VwNllXTHU1Q3hnbTZyeGk5MXFIUTdLVEYvTHpDTEVBZjVLR05TbE1CQ3JR?=
 =?utf-8?B?a0V3YVNGUjl5VHZuNm10eGlBQlVpTXB2bklzSHhCM1NLeHlSVlAwWEVtcnpk?=
 =?utf-8?B?MXZvdWkrcFd5U0hiK3c5U01hM1lFUzFBVllLSmZOMlFyS1prQ3BHT1I2RmFI?=
 =?utf-8?B?SDFXbGljNStyRWlUQ08xU3pJc2hkT1RCL2J5SUpFS1dIcW9RdDRyS2NQWDZR?=
 =?utf-8?B?QnZnS0NlQm9GTUdnZ2E0K0hLMGl3VWU3bXRzOTJmVGU1L0NhZlJjbXNJcmNK?=
 =?utf-8?B?WEI0amVlWjFRRnJ5bG9Jd29yWE1PWTA4NklTSjlvU1RFUy8wYkcrVlNySjVa?=
 =?utf-8?B?cEpsYlBwZURnK21Ra0dlWGNiRmN0OFVwNXl0RVNKWHRINVRQbjB6ZG5iTE1O?=
 =?utf-8?B?eXExaHBVZkpEY1dCb2FQdXgwOXNqRkJ6eGVkTUNGNno2Q1lMZEFwVHAwNnpX?=
 =?utf-8?B?R0daS1Q4QTg5bGUxeHFRYjY2VU9ZUzRKcWYwYnllTUpLSlFTdGZYY1ZaWmtw?=
 =?utf-8?B?MitWYk82b3B5Zmc2b2s4MEpZeFhvMll2WDlubjZ2R1doYzlXcjFMRTduVnpr?=
 =?utf-8?B?SEFyRzZhWUVYM2xaM3JwbmtlS1FkbVZya3hOZEJwcmd3K2RqM2RjekszRVlu?=
 =?utf-8?B?UWF5TXo0akkrNzF3RWoxMWlFMEZPWXkwekpoenNDY0xTaFlxNUxxS1kvbG9r?=
 =?utf-8?B?UzZvS3dnZkw3V2k4M1FSeVRON1UwSlhVMkgvWSt3czdZN2NQVzFET1J4b29n?=
 =?utf-8?B?RnNaVHBzdFNXU1FuanA0WVFQREJGNHY3L3hxWkVIajIzVUgxNXJWcmU5ejFU?=
 =?utf-8?B?Z0pVejNML255bVgvcFJTYXhqSG5HcTcvczVrdGNkOUU0dkRnTFd3aDVLTTcz?=
 =?utf-8?B?R3RDYzVOSXR3aytsTkJjeUZNb3hoZ3R5ZmlsamZIbUJtV3VXWUV2cEVHNFJQ?=
 =?utf-8?Q?JveTu+Ue9nwgWaIabWjtvriq1Zif3sI+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUNodWJhN3lmRTJFeTIwVWN3dXl4TXNmckZBbmJ0WWgrU1hSeC9SaGRsRi9F?=
 =?utf-8?B?R05iT3JGTEhaS1FxWjJiRzJSdjhvY3NhMGVGWENHb0hEeGNoMmhwcmpVUGNY?=
 =?utf-8?B?cmZFbE9uT0tnN2hPbENrN2FRMThKWnd4S3RELzVnTG9yd2NHOThTMzJzaEN3?=
 =?utf-8?B?alVTUm0wOVArZFV5dm05bkxQNVpHOVIwV0Z2Qk1zT0phRTRTMFVmaFViZkxz?=
 =?utf-8?B?a0s1dkVHN0tITWVBUTVDRSt3bkhxeG9GeTdzUncrR1pRQnl2akpwaW85TytT?=
 =?utf-8?B?aWU1aGFNVHBBTWQrZ1JnMlNnTXd3SDR2eDZiaE1pL2xIYWh2MHdFZXFYTHpz?=
 =?utf-8?B?R1VEZ3BVU2dwM1djTDRuTFFMT0FFaGt3ei9uVHd4ZzRLYkhXOXBnOHdSV1N6?=
 =?utf-8?B?K3hCSW80SHViSFBxSGRMTENMMWowVzhramhiOERzbDdYTVExK3JzS20zWEZp?=
 =?utf-8?B?bXFRT1R3M0hBemg2TER1K0RSOFlFM2dwNXV2WElyK0FWNGNEeTQ5SlBwUHo2?=
 =?utf-8?B?R0dOS2NoeDFDV0hzNnJnczZGMy9Qbk5iUTRTcDZuamFuaHZiQVc4dm5pbjRZ?=
 =?utf-8?B?akNtY0hNbWRQS1NZNnA2dFZDdW93c0w1QnNJZjFYUFhtcG01R2ZuUnVuSGg5?=
 =?utf-8?B?cjdDYkdqK1h1RGp4SmNwaDFJeklPZmxuaXhvZlF1K20yM040WThraVJzMzR0?=
 =?utf-8?B?WXc0RktKcEhJWU5YZGptdkxzSXVpSWFVU1FIZ3UwZDVWRHc1clFER2xMRzlO?=
 =?utf-8?B?R0JUQUc1a1ErTHQxQVh1NisvRzY2OWV5d24yQ3QzcHdUU3RGWCtMcjdBeUhk?=
 =?utf-8?B?cEYzSXl0QklDTzVWV1RPYWFVbHhtcGpMVTlGaGlnbkt0eWx1andETjhLVDVJ?=
 =?utf-8?B?OVdVREtKZk5UbGE1YmVKaHhhZFI0N2piMWF0Y3VGTUQ0U0dQSExpeFpqKyt4?=
 =?utf-8?B?aC9HQ0Jzb2k3Sm5oK0ozdDUwZGxzOUxBd2tpNzNDM1BrRG1hL2tVSExTV2l5?=
 =?utf-8?B?ZUlWOFVBZVdqdHRJM3FXR0xucFcwcEtKV2FlQUd2TlBSY0pNODkrSnFJUDJT?=
 =?utf-8?B?elFZTEJYeUVjR1BXcUU5djF1UG14MjdCMHdRTm9ITUp4MjFGV0JRRy8wZklP?=
 =?utf-8?B?bGNNbUJiZFRJM2FySzArVjIxcFFkTlFBZXlDajdDVVg2RVI3ZWVnSnBEMklB?=
 =?utf-8?B?cklwUVJYM25UMndRWkJqcDJzNWJYdzQ3OU85RXlxVzlaSjdjK2orN1B5T2lk?=
 =?utf-8?B?SlhXeVV5MXp5TWdhYXJWR0dzYnJMc05mcm9iQjVycUExZFhjaFN6d0hGOVVJ?=
 =?utf-8?B?azBOQmJOZHkzZzdSZ0Rra2Rjc2pQWXhCSjI1VjJLQy9xTjd2c0tqbTJlQmpZ?=
 =?utf-8?B?ckQzOWpvNEdxcEVoSk0vTTdHWXBrZ1FvcUxkQnYyWDJNZHhqNXE0dzhIUUhC?=
 =?utf-8?B?ak1ia1lwNVZ5R1dRMVlnMXRkMmlWQ0taSWlLczBYNVZRZldHK09NRFJ1MEpn?=
 =?utf-8?B?dnhqSUx2VGdHV2p2YVJGbVdDSXhNOHNZZStiSmtRckdLRDRqc0tWaGU0blIy?=
 =?utf-8?B?MWc1VU5OcEI3VGdNOU5kQkZ1OTl3d0lIZEhNZTRlWDlFTUVoeFFXMmJKcno1?=
 =?utf-8?B?VUNDdUxFdDkzUnhUcm1oY2sveStreCt5T1JwWW9hRWZsK2tqaVRCNjhOZS8y?=
 =?utf-8?B?VldhZk5EY1BVeEhnOHRqTytlS01td2VFcWdDMFFDMEFFemk5Y00vRk5aKyt2?=
 =?utf-8?B?SGhSbE1WNVJNcjBQZDk5SERWUE4xQU5YREtZbXJjT0xFL2xkb1RuZU4xOXpF?=
 =?utf-8?B?VDdMT215WXd5NXh1aHRUa01Hdkl2eVZpSWhtUWFjR0R4UzVXQWRua1VaN2RE?=
 =?utf-8?B?eE5zZ3hSUGpCT2lNd3FWR0RuM2t6SytBNnAvSHhNSHJoNGVmWG5YNnAzSjlE?=
 =?utf-8?B?WENVcVNWeXhpT1Jha2JvaTBZMGlQclZmVXlFeHdiL2pFY2tCV1p2YnZ1MUNj?=
 =?utf-8?B?TEpOTDdQd1FjVXRKREtlMTMrK2hSVnQxNnlORkd2OG1CaFVCTEo0d2NaMHVF?=
 =?utf-8?B?WVpEemg2MDI1QkYzd2tydTNyRTFPKzFLQzl4VGd3aG54OWVjUi9CM0dwWFl0?=
 =?utf-8?B?WmJENklJaFZvTzFmc0pKNjBMTmVtZnQ5aVRyU2wxOW52VTZRcjNneFl4cWRo?=
 =?utf-8?B?UW1LdUdjeXMxeTNnTktncHN0bjNIMGt2bjJSYmJjRVNKeCtaNGlLZXpFOHZs?=
 =?utf-8?B?cUl4RUxER01icWFIK24yZmlRMkJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65605A209F5E5C47A0BAC8928838043E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NhqX1Rhoe2ga/Gen808JX29yxNp0jTj2wLxpTFM9AX+lZuLE5IiqmUwjhqcgWLq3loNHCuN5cmUYBKkttCBQBURXuKG2CienDY49CplodqdP/ENBHmideXRCPcrLs8ods0L/j9bKreG5YV/GwG4k1K9NfU6yLUftSZYjcDdg/Kdz/LYz5HDrOorLoiZm0XlG1qMI0ZszafZdRlIo8PhMquFXSffo01yGjS8BLXMVBxU1kJWa7ApA/oQJJaKw8e1c+/64ZBba8Bf3Hb30CG5m4rWVfXjDqYiR14VHUfSnyny8/hsSLnYSou85GuAndoX5IkNnpuJnpM9fDKbw8pJM9EPV+DFpDBv5pSOXwL/XRWPjzBssd9eNlFUUK0F7FBNa2teSW+HyNry2lyhqrC4a7D+F/g93CqXScRJnozFjMFT/ug4lEEFOrJlWg2q/7jpujOp6KXWyiR/Xmi8VVfRbDd+LsdS6bRHiZor0spl5XuTV7r3dv2A+GUzSCHcHgu6e7SzZYryE5WXFTOOS/NE2tw+7OGmPkM3xYnozwURpQeKJ/9gXnQy5Jw08okFo3f8cMrvnV0T5MKDA4yC7J4PIEatKD+hcFDCzJhjZgpg10ca6cLXv634hjS1FVoBfdkSg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad99a28-4412-4044-b361-08dd56fd4205
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 07:06:29.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtRqGIXdCoWax8Ic7Bj36PYAKHbI47u+e9q8AVRng1LsvTMhjQyMClGSpxZWld/2TZGtxWHtSsdhSvXAGZEQK/KSbEasmgkbcRykuGsjBVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9132

T24gMjYuMDIuMjUgMTA6NTQsIERhdmlkIFN0ZXJiYSB3cm90ZToNCiAgIA0KPiBAQCAtMTY2NSwx
MSArMTY2Myw3IEBAIGludCBsb2FkX2ZyZWVfc3BhY2VfdHJlZShzdHJ1Y3QgYnRyZnNfY2FjaGlu
Z19jb250cm9sICpjYWNoaW5nX2N0bCkNCj4gICAJICogdGhlcmUuDQo+ICAgCSAqLw0KPiAgIAlp
ZiAoZmxhZ3MgJiBCVFJGU19GUkVFX1NQQUNFX1VTSU5HX0JJVE1BUFMpDQo+IC0JCXJldCA9IGxv
YWRfZnJlZV9zcGFjZV9iaXRtYXBzKGNhY2hpbmdfY3RsLCBwYXRoLCBleHRlbnRfY291bnQpOw0K
PiArCQlyZXR1cm4gbG9hZF9mcmVlX3NwYWNlX2JpdG1hcHMoY2FjaGluZ19jdGwsIHBhdGgsIGV4
dGVudF9jb3VudCk7DQo+ICAgCWVsc2UNCj4gLQkJcmV0ID0gbG9hZF9mcmVlX3NwYWNlX2V4dGVu
dHMoY2FjaGluZ19jdGwsIHBhdGgsIGV4dGVudF9jb3VudCk7DQo+IC0NCj4gLW91dDoNCj4gLQli
dHJmc19mcmVlX3BhdGgocGF0aCk7DQo+IC0JcmV0dXJuIHJldDsNCj4gKwkJcmV0dXJuIGxvYWRf
ZnJlZV9zcGFjZV9leHRlbnRzKGNhY2hpbmdfY3RsLCBwYXRoLCBleHRlbnRfY291bnQpOw0KPiAg
IH0NCg0KTm8gbmVlZCBmb3IgdGhlIGVsc2UgaGVyZSwgaS5lLjoNCg0KCWlmIChmbGFncyAmIEJU
UkZTX0ZSRUVfU1BBQ0VfVVNJTkdfQklUTUFQUykNCgkJcmV0dXJuIGxvYWRfZnJlZV9zcGFjZV9i
aXRtYXBzKGNhY2hpbmdfY3RsLCBwYXRoLCBleHRlbnRfY291bnQpOw0KDQoJcmV0dXJuIGxvYWRf
ZnJlZV9zcGFjZV9leHRlbnRzKGNhY2hpbmdfY3RsLCBwYXRoLCBleHRlbnRfY291bnQpOw0K

