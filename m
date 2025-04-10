Return-Path: <linux-btrfs+bounces-12941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F5A83903
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 08:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B48C19E38E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2335F1F153E;
	Thu, 10 Apr 2025 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FCkOvtTg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ISLtJQIl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF31BF37
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744265843; cv=fail; b=qWTCqRBloJl20EoSc7CXWz2S5SrE3bpt+S3cMMr8c59Tgf6Di/PM+1Pkxn5JweR5l7G5gotv5teHL0fJn65/J6tx43TihelCcwaP+lkxEkbvXfqCOWCjOjzUIp8s4viLbv7nWFZL0u4wAsfjuJbPwAk52A7vOq1Ea4/o6PBe4Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744265843; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m6cUNj+6ZL7XC8DvSjw7raBcGuHhLtkWbopLJ+/USGXXz8+UqrDjfRHCKg19fVblhzMj4Wc4vqaCMakMVfCBK24XH4qnRLzOJzZA6mCfI8HKFxKtkCP23q4RvjCj3sSvFvDj2JszUZ9HmpT9GqxlB6YCpec7vfzBIFHAsdCJTbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FCkOvtTg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ISLtJQIl; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744265841; x=1775801841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=FCkOvtTgiOuPr/ZMWlA+9iZvxNdxBA6OGladrN3DUtM3i+fJK3P/X/go
   GMg73Uma1E99hPItvfYEukT6e+kJbyHbNHAOo6uhimBPKLa++gb/uW0qD
   kdOr+jVa8G9JTxxkdk7xwE42iD6S3Ll355cT1duSmSnE6fhLdfr+YG3JT
   RDtYsV1pWaIYEhs+yJxwuWGoqpWCdastH/H/xLGzbF9dZfvsop23aM5Eq
   siHYpm+LoNyCYDTxzq+/4dybPVDgd+a+N/zmcexVvQu84EXHTEMQdsq2W
   7919P2dirRiawkNb/TvxtZgqAQdyAYz0Wmk7pIFGXwjZp67WlCZ1Bb8Bk
   A==;
X-CSE-ConnectionGUID: oCAYM2KKQMOghzJQiYMUoQ==
X-CSE-MsgGUID: enpvKFXyTqKLMpp4tbjYnA==
X-IronPort-AV: E=Sophos;i="6.15,202,1739808000"; 
   d="scan'208";a="77616547"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2025 14:16:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHzH+1A3wukR1Q96ig7/kyxomLADcKBGKqdaP2U58xfOu/Pmy+tJPIBCqS4EUxzkZ4DJNhekhkw6bkb9gqyIua6Xl7Jr2A/egAXDivY/GrWMDTPvMoxhLRKn5PbbB9B8etNeDpibDNtpGg6nblcflJE5N5yrv1LnylWiTmSMY5M/mU5YsP3WEO68QOxUwXCEzYUhCjjQbmcQS5/xbj5qSNEbOZQ5V77vSDM5f0TNfDti6QJZ7PXaSPZ6+Hn3wRFdRBqNP5Nsyozkb+z+tJoWQXKuZkVcavURjZbOihqKhbrVZ/g9JF3BT8Mq9GBenXxaE3q9ruuq+BTxaLRRrqHHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MqUl3MgRtGZLEK+OPEnjsV5rcdgtzkk6OVyUGOg7PA0m/vyRevlQAKiX5H5rWteSESaChEHzCpmccYCA4ePBZDVVC7LTP9K2hG+MhdYaXnpfDHGApdcpb2vjnTiGGbI2gJJA8f0o2+p1amBzFNDiZYzH62Y8EPR02Y//7Xe+xA96jfko4ILSLy6ZVbmTqtfj38QiTtDUsbNeDUcTS1vPNEVkjyItIKrilrsuwVZy1lGT3bM45mxYy9MPZJ9h2z4Rkj/lMpUgxZBe7AF7OnU7U4LTRjmFM51RldEYr96ZYVGPskPi2Ace3TxIDoR/Ke1Tm7KKZYtprlCgn46rrDurpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ISLtJQIlb8W1/Cr3HjZOTDdy7aoI+ZO65KmRfABCPnNzKcXoXTAwlQbVjnW+7xm0eQ27JOlTUs/maexk5t11mOhj4Ln8Gv9lmYdswX9A9zB368vFttjcnWXDUKjiVtRL6LqJ7aNCv2cgEjRbDCbxnq5uUS8ZMhCeWf0mq733i/k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7075.namprd04.prod.outlook.com (2603:10b6:a03:223::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 06:16:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 06:16:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, WenRuo Qu <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] btrfs: move kmapping out of btrfs_check_sector_csum
Thread-Topic: [PATCH 4/8] btrfs: move kmapping out of btrfs_check_sector_csum
Thread-Index: AQHbqUAr1O3/XtBGJ0m5eFNWf1UquLOcbZmA
Date: Thu, 10 Apr 2025 06:16:09 +0000
Message-ID: <3b20717c-0f8d-428e-b3e7-4be690290707@wdc.com>
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-5-hch@lst.de>
In-Reply-To: <20250409111055.3640328-5-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7075:EE_
x-ms-office365-filtering-correlation-id: 33a3d241-470a-4a33-c5f3-08dd77f72fb6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEJvNE80Q0JOcHg3OVo1NUJZeXpqRytybjJtTUlvS1V1MWRORFBaM29uUkFa?=
 =?utf-8?B?SEhqSmIwdHBpMzVuL3AvODQvWlRmZG1QRlQ1ZFFoZ0g1UWE1OFNBZWt1ak9M?=
 =?utf-8?B?ZVRtTnpPTTFHd2lpMjNuV095cThsaklmeVpvdGYvODBldWFJOXc4VVpOOEVp?=
 =?utf-8?B?TEdxN0h0TVlUeGhTaEE2NHVZR1ZEc1BKUFBobG42ZWFRL0JobjlaWTRFZllo?=
 =?utf-8?B?d0tSMWVEbndLUVRoTXgvZ2tMMDFIUTIyVVQwMXVoOHR1akhJeUgzQU1MeFpa?=
 =?utf-8?B?UUJWbzRWaUJ4a09mTFhhUUpmMHRJMmxmRXFxSFdVckVodlljcEpxOWVvaGcy?=
 =?utf-8?B?Y3BEbFRUOVc4eTZ5RVJVVUFLUHBUQjhjOWdIVHhIMkk5YngrYVpldmsvdXFy?=
 =?utf-8?B?WUIvTXh5dEM3WGVKNklxZy9OR0d0WUtNRDUreFVTd25YNEtVdG93VG1qZ2Rw?=
 =?utf-8?B?ZTdJanBXY0twZmd6SnAyR2R1bXk2T3RYdklpdkk1b1pmMUlKS2xMcHFoZnFO?=
 =?utf-8?B?SG9HZ3IvZFh4VjV6TDJDRG45QlBqTHBFeXNyR2FFQUJ6K2xGNkxsWTFlU05v?=
 =?utf-8?B?YWNnOGVkcW1scUZPWmhWcWtCeC8xZXVOR1hpU01WZlVVNWxZTE13bkdxdXJS?=
 =?utf-8?B?dmJoL0h4Q1BHc3BjR1RaYSsvU29vbkJCT1FDa01LSXBaNlFZbFEvVDVXcUJs?=
 =?utf-8?B?NlNRQkc1WG8wdmtJd3BsN3dqbnRNQkVrZGpHRWVqbXRlUlZXbkxNbjAvQ0ZC?=
 =?utf-8?B?cHViZFF2dEhIellZWEpEakthNUdydmhIL2NEZENOTXJDWCtsdS92NlViYldv?=
 =?utf-8?B?OUJueGpUK1Z3QkRkWmUwd2YySzVVWnphNm4veVo4a2RJYmJRMjVGMEJXV25V?=
 =?utf-8?B?SXJ2VkhTRE50K1pmT09UWVpsRytEeXlWL2RnTitmck5uSHZVNktMVTVKcGFv?=
 =?utf-8?B?OURyVVhuVjJNVVMxeEhyMTBXNmkyanhQM2NCYTkxRnNlK1U1WFp2Q3lSWHQ3?=
 =?utf-8?B?L1RhZWR6MDdONG8vZUpQaFZLM0pHSFNQRjdUOWtOaW83VjZwRjk2UTE3eHBq?=
 =?utf-8?B?aVdaV2xiQjZtSVMxV3VuQU81dllFZE1jc2ZFbWEzY2llczBZWUdQd3FEbVJY?=
 =?utf-8?B?T2ZOUXdockJLUGJ3SXVzK002R3kzZDdoTVBzMExaV2IrMVgxa28wekZwaFVv?=
 =?utf-8?B?Z21EaUQ0eUl3ZlFzbjVvRFdFbHNCaDkydStSMXFHbDlqL1diSFRxdjRqV29R?=
 =?utf-8?B?NFh1NlN0M2VKbWJwbTI5YUppazNPd1g5S3VyMXlZZ0M2ZkJpLzJ2cEpzNjNp?=
 =?utf-8?B?Z1JacGViTTRwWjhzQUw1dUdaRmp3VDE1Vld2SVZPQnlVTEtyRERjVXpiSVlj?=
 =?utf-8?B?aElpeFE4L0s2MnJmNlMwek1FTmQ0RjNIbmJhc0ZIblNoTUpta1ZOcnlNL29x?=
 =?utf-8?B?aUtsU3JEM0ZoaXNyc1paV1RHZEFjclQ4RVB2cEtUOStucWlLbmplTk9kVDdz?=
 =?utf-8?B?TjlIOXdQT28vWnJIYTk1NGhXRVAxNHl4cmdPblpiRHpnRzRPR0x6Wi9Zcm1X?=
 =?utf-8?B?bVZoU2d0eVdCZXhlYURPZC9oUExYSUhQQmI5dFR2MmlVbVBYdEpwU1JlVlZO?=
 =?utf-8?B?OVk0Y1A5K0M2QUhFZXhtSTBiVTQ3M0RWd0YzWVg1VVYwbXBDbndLekR0R2hT?=
 =?utf-8?B?SkwzaTcyRWtnczNjNnhPTXZzN3ljWTVrMWUybXZ5Y1FYd3ZPaEhqSnBYTVJm?=
 =?utf-8?B?UC8zWkR0TXNCRk1IVklScmg5WHpWajJubnpxZjZWUjVCNTk3b01jd2hlRURB?=
 =?utf-8?B?TFdFYmhDZUZuRnJyeEVzTWt5Q2hja0ZvTDBReklEdHZ6ZjBFdmNqbk52b2Q3?=
 =?utf-8?B?eWlIaWlsUjR4ZGM2TTFtc3p3RTJMSm9IZlIrV0UwTmFYTE9KQVk1bXVhcjV3?=
 =?utf-8?Q?ZgIapCRKwLkKaRSM6z9adjeSP6wEMIwF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1hBV1F0L0hqdG1EWi9xTEtlMnVTNXZYQlBNb2svZktiYmxkUFQyUUdOSjBy?=
 =?utf-8?B?RU0zcy8xWGY3Z1JaTW1LU3FjQ0xlckE0TXRDYW4vMjRMNm8ydW1aOTBCUXZx?=
 =?utf-8?B?TUlKOUR1TCtMU21sTitFQndLUTR3djBKS2ZLTHl5cnRmaWNJTWl5ZW1xVENI?=
 =?utf-8?B?OEdsOEZVbno3bWozY0Y0S3VaTVh4Q05paTJJWHF1SktWL05EZkFpQlI5akxX?=
 =?utf-8?B?c29KdDFWWThsOVdvZTBwYzI3TnVWNkRvZmVmQnFFbGRmLzZmYXY5dUtJVjBS?=
 =?utf-8?B?d0ltOVczOXVaUmk5QmhLdUdLS1VNR3dHU0RBRHN2ZFQxOWxFV2VsSld5NVB4?=
 =?utf-8?B?RGxFblZWb0x3VDN2NVp1NW5KNERnOEpxRkxyL2hIZmNIOEduY3lvS3hrcGVa?=
 =?utf-8?B?M1kxSlRwUnNyQ0J6aWdVU3RLSmd0aFVzNlI5cVVvODlxdGZXM09KeHZPci9x?=
 =?utf-8?B?TTczSUNvWWowWXBMUTFOVkROS2NHb0R1bVZOUGFuSy95dThYeXVkeGFvbEpx?=
 =?utf-8?B?Z0tvcEl3NVBiRUt4MTUxc0ZZcnc2bFdTVCs1NXJFQTJZRlR1cmpDamFuYWdI?=
 =?utf-8?B?M3lNam9RMURFU2NDYnVUa3kxU1BYVFpxNnZjZnRnWEJRd3NkcktCZ3lLUU9R?=
 =?utf-8?B?cWpPZU9WRG5QQUlnNUlGQVF1MW5LTkp1REd0TkZGc3ZZRkVlb2ZOTjRDcW9x?=
 =?utf-8?B?Y0I0REs1TjIvd0ZpYnRZakp1ZkJSbXFiWXJMekRnVk5Qc1lWK21JVDlqaksv?=
 =?utf-8?B?MVdqV1lMbzJJY2NRTzZPTk1RU0g1NkNpMzRaZVI0TWx4czVod2RRYVJIbkVa?=
 =?utf-8?B?Q0lxdWpORG1OL2hPQzNGaVd1bVhlcUNhY050UjRZMml0UEhlNi9XaUR5bVgy?=
 =?utf-8?B?R241MkQxU2lFYzJwcDFkQWYwUXBiTXFGa0QveW96RmJvWFM1NDM1eDFnNXZ5?=
 =?utf-8?B?NWlOZXd6bi9jbGY2c1ovdTEwRTkxR3pYZTl3NE0ra2pqL0tBM0h5ZGczdS9n?=
 =?utf-8?B?Zy85OWFqclN3TU02b042SUVhQWE0N2ZKcWN3bXJtSVdwNVN5VWFpYjhHOUlw?=
 =?utf-8?B?a1VPalZicS9mYmZQbE5wcUQyN0VJazRjSlp6cjBObnUvQ01kZGIwekd2Q1FX?=
 =?utf-8?B?MjdGWERuZFNFTTdrams1OU00N29IQWt6NXZWd2IrODkxaC9NeHdDK05mdTI3?=
 =?utf-8?B?K0ZSTXV3cXFaKzUwTnJ5Z01zMVU1K3N4Zm5QZHl6Uk9PbEQ0OXN0L2hrU0VG?=
 =?utf-8?B?aXpQaG9zTmx2aXhhNy9TNHo5QWR5bVBEK3VzMkJKRmcrb2JlbGxzMExmYlpE?=
 =?utf-8?B?WmI5azJBUXRYTzdXcGc4SW9YSkkydUN0SmMranBEWGUwcGIyZk1jL1hBTVhU?=
 =?utf-8?B?b2VTaGNGZzlUSXlPTXBZTVBGY2lpVDhNZE1HMit5dkFINUtyRFpmemJLT24r?=
 =?utf-8?B?RGFpSXB0dmN5dHJyblp4Q2xSck8rR2M4M29ETXUyWElBdHI0OG4rWERDN0ZD?=
 =?utf-8?B?NU1aeWQ1MFpkYzBzTWRBZHZnTDdSN1pmM0hBTUVzVVk5L3lqR09ON2JDeWxx?=
 =?utf-8?B?N2FqVHdsU0VFWGhKMmxuYUxoei96MmYxck1xYXVmN2tzRjJlVGFiQjQvRFpR?=
 =?utf-8?B?TktUYTNHVDAxYS9tZ0NpYzhsV2tCVHNBb1BQdG5FbjR4bFVsN1QxcGpyZFRx?=
 =?utf-8?B?YTZuVnFjQTJndEpib2haT0FtdTEzUlMxbngrN0lGQ2xsckIwRUljcXZNdmdl?=
 =?utf-8?B?NlBRYlNpN3JraE91MWxNbjN0czMwY2V2ME5Jb2dHR3ZmY1QxaWpuZGJzOGVU?=
 =?utf-8?B?eHhEQzNEMjhvYVJ0RzROblZPVHBuQjBrQVU2ZFJYRFc1QzlBbGlKbjdCdVZt?=
 =?utf-8?B?Q2dPcW5HYzhhSzhnTUgvc0hjVG9CNVFLUVhsOXVOSS9YMVdPUHl1VmpBNGU4?=
 =?utf-8?B?MHRwdlppYkwyYVVacGs5N3VaL0J0LzVQS05RU2l3anY4MWUycW9yYmVnTExq?=
 =?utf-8?B?Nzd1bFZVUEJSMlRGYjJmM3ZQM09xU2VqUkpuZVk3SEwyeUtvc2c3b2xud0Vv?=
 =?utf-8?B?MVVpVWdEVnRrWm9DWDFRUkJVQ1FPS2lvcWZMRGo3OCsvdW43UUFEbTJXUmoz?=
 =?utf-8?B?M3loVThGd3k5Rk1ZOVhNWGhMWGZsK1oreCtrcndJNEtzMjNnZHFTT2lYRmRi?=
 =?utf-8?B?L0xCbTI3cENEUVcvOW14WWloMXhUZHpNdHRvNFdnU2hWaUdpWTY3bXEyc3V4?=
 =?utf-8?B?QVJtOEJJTFBjcXR2UjhJUkw2NEh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73B2D21D962A8B46820FD5C8415BFD90@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k1aRzWynoQ9xQqANzA1EkgzxnCAykg7KLc+vo1LkCRL6B9MoogxlRgWdw6lXixngOvrQ5LRpPcg27aHZ9MvitSWJvPiaFVafJKiZmvqRhoS4evKMIAYzS02DHMAf8mVG9s289s2vOSLDHHDe2Z/QAZzfFldjomi00yndKDXI4h5pQ7LbX1aqBj2q/9SpyimE3gHOp2QmaB9Xd5haZfMF2NUWuta0pp+LUgRgk6lk5JOLVOvBKD5xlKvAOJzd4ZdNh+//JMVFGiZw3oRmboLLWcAB83Vzpb+uyYWZAhRk1TQchyp+huEIP0ZYPHXD0dC+KHrUdaJGkYPTDr2qcVCpFh+FR4C8U31vceibVXqGJJMC8KHvDFi+Bi7BzMDP+WeXiGn4kZes8qJGsFxnPCP8VhFzAjuYWdPIhpg1z9l8lWHl+o6gEbuhK9//SLoiUkRYSb8ql0snUaTWrysVZULoD/HZL+v/kVommkj2zN+L0perAtM+W0a6VQU2A8JgitSth/XwOIkaaaMEmfDblkWRdAeyNdEoW1zPnnMtamYhSw2xnl1bqNJvRaEVyLdjMt+6OEANO0BtaJuXtq1PllRu+bQT/3w6b5whGYnX7InObPiahEO7r7Qmo7b6nb3OLtCq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a3d241-470a-4a33-c5f3-08dd77f72fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 06:16:09.7459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+6OFjItRk/Q/1GtVuDeL/jUPJSAP+/pjh9ewgbRIQDm9+/LUFigUmC93Jl9gCz8w1oeSo9KLq/PUFwZCx+AtLx6i9nV/NEg2kayO9L0bl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7075

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

