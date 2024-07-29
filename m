Return-Path: <linux-btrfs+bounces-6836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10793F849
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03097B22A28
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CE156887;
	Mon, 29 Jul 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="alBqiwfH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eXGU9O6l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DDC155CBD
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263546; cv=fail; b=oZlr2cwUGhtGpfmkfFxryLP5/6070n9FvzPx41taSzZApsbcHbRCoz0B8sr0l1BIoWULCbQUZ5wwK1gtXMhe3feHIsfLJvLWRLHckEgDGwnCowJMDIR2mvElzir9VUCV9lLHh3ZPRD2AI4wjon4S5AqJojYOtLwOdGmCEqgG9w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263546; c=relaxed/simple;
	bh=6i8lFR+EHMWegwK5+ei4bhkyeLaBW/Q/XtypnBivvnE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4LqeaCXUD4f97erp7jtpv4wMkxbaQvi1hoAOVPIULV3aZPksg1TOUwD/66Cn+nqtX5B3cZ0VloSuqDMUQbyJUOLs5BSvRXFJxvX3s+mw9Alpu0fEijNyS/oS2onabtPaYvwlEbuT1PeoeWRUCbLgw1BkGSAX8IV6jE9XNZ9nYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=alBqiwfH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eXGU9O6l; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722263543; x=1753799543;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=6i8lFR+EHMWegwK5+ei4bhkyeLaBW/Q/XtypnBivvnE=;
  b=alBqiwfH4s6K82XOYKx2k8q+KlHdclhlqjGe1WTRAVMx7woc5IWQa/BL
   onqtwQVdP6LJUXYqi/sNf0sZt+wWwt8sV7CrNyQhAqsoCX6D8P8jERK6f
   TodSg+1kYBTpR0XTHQCHTIq4mRrGmcbdMJ2AUEzVZNqHLxQSQMRjfANwJ
   rNXtWAB06+FiPxAUjSFCiIxRjv6hmJyj4xFE1E5CDhYIsCPCyrvp9s2um
   okymt0H2Uc0QY+7jNKUKzNEvX77tFbCDTeOY9X8hrs/R8v1vVlDh0xwAz
   hLhsZhaE2iiYRNcCBJ+tRObijbM54fVyWDWZYc1fPMzEuy7yE4N9ZpWTH
   w==;
X-CSE-ConnectionGUID: 7GgFjQd8QXmcvg7E/m4HfQ==
X-CSE-MsgGUID: 2x7dub05R46rwXUrdOCxtQ==
X-IronPort-AV: E=Sophos;i="6.09,246,1716220800"; 
   d="scan'208";a="23236313"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2024 22:32:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnnlspxGhsXNC9+OONAy6he4jOcncJFiV6Buj1TTcsD8UK6+AJDCWSGJ8kvhNcSzaQkAPDHC3g0pCGuFhgsRwG/RYM7lHdDQTSlf5rZQEy8ZAB7vJVce3NJf+TOH5FNherCXfD5kK/sc4c8o67ZMPRjQCKD0PmEZr8/hHwkJLyQu0A7CUIuufSN3LQwq5cd1ECqAE1P85jdOc4EKfFM6j0q4Z0JBvVfRG777yPn8wYj/3L2GG3jkw5M1BWFNZIxOPBhue/ziRF8S1tqIrkAnp9t+4OAugyadUIphdm1RRq7NNIY8pr9DyEL3BGjFPvYiu/UOxn+z8Py0eoqOKRiqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i8lFR+EHMWegwK5+ei4bhkyeLaBW/Q/XtypnBivvnE=;
 b=ipwVdJ6WTt65fioZoqRD7FraTKcEXWO3YkyOxbq5hnk6YZXZqmQIbhV3NAULGb7jgbMWgOa5vytFEycZBeu3edsEK6+NYwPRUoHFrjHYfxnbv2FGYgwQhjUUEtbefam50Dn5aOBy9MYkWAqauKx5fhA0IFEBYbqVSowK7gIpwx5xmDbucommLtQMDPZnhMOw8595pPS9XIy6b/NcJPOPtdesq7Bl9uBfOb9EZ7PwTRUKUIp3z0P7zUX9BqGpfhkZTU6WDWgMG1NxQC91Olo2zXQKJeLym4HCeLmXiLOBv8dw9oBaeMLly83ThbmPRo+NHPn0UTMchXKSUvhaH887uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i8lFR+EHMWegwK5+ei4bhkyeLaBW/Q/XtypnBivvnE=;
 b=eXGU9O6lwJyFr/JkgOb/ZRg1wPtsxbU/kPt93h8Pn5QxXYpk3Zc8ttaqtPExSWL+FlYvfTHmFYGCA3XX+fHs5fAzRzKkZREdDiMleaAi7IC4DA4RwKYmCin7bhIj7T23caVh4cFC1RWbGPlaJJrvXR0UwtJugiUdTdUaMi1OP14=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8525.namprd04.prod.outlook.com (2603:10b6:510:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:32:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:32:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?SsOpcsO0bWUgQmFyZG90?= <bardot.jerome@gmail.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Virtualbox and btrfs superblock issue
Thread-Topic: Virtualbox and btrfs superblock issue
Thread-Index: AQHa4cAOtIJnDGAyPUe1ovUbQ2OdErINxLMA
Date: Mon, 29 Jul 2024 14:32:12 +0000
Message-ID: <43062b94-e758-4283-bf55-68d4f2f2fdb5@wdc.com>
References:
 <CAK6hYTsFwBVXAJ3yBkBX-3tgmAj=1OFxN=2kybiovxjtTX4yOQ@mail.gmail.com>
In-Reply-To:
 <CAK6hYTsFwBVXAJ3yBkBX-3tgmAj=1OFxN=2kybiovxjtTX4yOQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8525:EE_
x-ms-office365-filtering-correlation-id: d9b2acb9-9fce-4bdd-1c6c-08dcafdb3ca8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXlZTDV5K2FJRjNHUEF0SFR3Z3c5bFNORFJoUnNBV1R3ZE56TkVPcTB0VUxJ?=
 =?utf-8?B?OVE5QzB2WGVSMGltalJXMStPdlVmdWM2RlphdWhuSnZ2UEh4UzI1WERFRFNY?=
 =?utf-8?B?Z2phQldZVzBWV2ZxNHE2c2E4RnIxV2wwRXc5K3l4K0Z5aWtrWHQ3dlAzQzV1?=
 =?utf-8?B?b29PY1pIUzNuOVdlTTFsZEhnZEljeDMyNXJiNVhhOG1QNjZTK3ozVXJ2UGx1?=
 =?utf-8?B?SVBiTytxZG8xZVNSdU4vN0VoR0xPMkFxdXdWV0I1dVROd1N6cVd4RWhQT0VU?=
 =?utf-8?B?enE3dkowUU00UnpLTDhrK2hmMUtnMVNYeCtlblltNytsV0ZKeUhlOENuNEhq?=
 =?utf-8?B?VGVmNmhLcE9rTzVZcHFqMFdvSXA5WHFSVkh1Z215UkpTa3RleDFvQzNselcw?=
 =?utf-8?B?TDhtNElxRklmUVRTQ0p2R0Iya2p3aEVTcXN6NUFvUmNtUkVaNTNlaGxvYnRE?=
 =?utf-8?B?V2F6M2tKWFIraE0rZmxJcFY3bjFSM3Z2RllZeHFDaGxTcGl5WmVHbWJtZldr?=
 =?utf-8?B?dGJ0NHU5aHpQTTgxSWV1NEd6SC90N3FpS3pDVm9TaE9LTXRSd01hemtILzFN?=
 =?utf-8?B?akw0bVhzNHlWdlFSaXMvOTZJcVhzb0U3UE9McldqNUxQcEhYWDR6WDVDTzhZ?=
 =?utf-8?B?WHAzQkFkeGpXWGMxeEwvSHlMQTlZdjdvK2hsUWlyQTRadWlmcnk2OXhSbm9n?=
 =?utf-8?B?VzRQaUtQdkFDRXU5MWpXUSt3enkvV2hXVHNWN3d4a2t1cEg2YzlpV0NZK2du?=
 =?utf-8?B?VjNCTC94UkJtaVAvQWNkL3JOOFd1ZHJ0TTUyKzFvNzNoSlpHeVkyNi92YUJH?=
 =?utf-8?B?NjJCbUNlOXg1SXlEMFdKVGtTeTFqa3NYMEJ2Z0gxT1dqdXZxdXFubGZJSnV0?=
 =?utf-8?B?a05GWG9MQnRJRTFidmVJajFvRnFXMDJvZEJvTzJ5b0NLeUtDcjZOOCtrQndz?=
 =?utf-8?B?QTNRNGZLNGNWSk9mQ1N2TmdKL1MyaWZDRyszajBuWlVpVWhnUmw2WWpmeGlJ?=
 =?utf-8?B?ajczVkl2RkhUcG5MOTNoaDZ2Wm5kWDl6bDBObGpnQWJrQ1hSb1RJbStKNE9m?=
 =?utf-8?B?andoZUVYZjNyNGVmUzBra2JucEJ1dmlweUtCZDd0eG1aNDBoaFEyZGlUNFVh?=
 =?utf-8?B?YTVaREsrZElBZjhmMDRVY3NoMmlrcXlNWlRRdEhUczVXaFFaM3crODhpWmd3?=
 =?utf-8?B?cGhXaGJaRzZkR1NsVS9UaHM3cVpaMG5PUlF6WHNsR2EwWmlkdjJXZlVPSDB5?=
 =?utf-8?B?UFdIYUJjTzIzMFQ3dTdCRFdYNlBwa0k5ZHZobWlncnNMK0FKOWx4bWo4MVRO?=
 =?utf-8?B?ZUdDTjRMQTdDcURzZEZldWlLaGhSSDlpaDlJbFpkeE8ySUhndHVVM3djbDh1?=
 =?utf-8?B?L0xwM3k4UmNtd2ZTZ1E2VG9sbGRScDRCQ0JKb2d5NEtSRi93RDlDek5TSzZD?=
 =?utf-8?B?dExVT0xBU3RRcE9UZFVwRWFaZ0VmaFkzYWo4aE1UTTBLc3NtajN0N3hINE1r?=
 =?utf-8?B?L1JxRktKb25iRHYrRExBTG9odzgzdjRrUjl2c2U2UkpaZUxmbDd5SFpCRXpR?=
 =?utf-8?B?Vys3a0xOWGZUTVN1ZUpyS0w4SnAwMHRUUmQzN25hUW1QVFExSkU0dVhITk1o?=
 =?utf-8?B?NHJMUHBpeXV0ODZxNWthbVVjNjFxeWRSSmRzMGMxWnEvL3U3R0FzYUYzY3Q1?=
 =?utf-8?B?dGM1cVlsSUZMRGIzSEpPdWdrb0d3OTdzdmFmRnFMb1FFdGRuOVVyc004bW1q?=
 =?utf-8?B?SlJadmlEUnYyc1Y2SWQwYXBKbElVbEFCVzh1eXVoRmhtSXkzOXdaWmlFUm51?=
 =?utf-8?B?bW1jbkoxbDNmVmI4THRhakd4K09PdmQzS0xlQU1kejh0V3NnZmZ0VHBnOXdF?=
 =?utf-8?B?ZnN6d2RHajVCUUptSkszdHZESlVvOVFsY2hvYU5CS1V2U1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWdNS09IdU84eXlyTWFXaVFhelpkdHdCSUs2TWd5K2ZUcUJ3bWRPVXBsYjBv?=
 =?utf-8?B?OGVlTHJGZERJQVNVZXpTUkNhcmJ2cUJKYVFTaXdXK2ttVXlzZSszMkpIZWQr?=
 =?utf-8?B?WlkwYmkyalcvOXhEVnNmMGFEamRNQ1VXd0FrQ0ZTakpXenNjb09IdVNtdGha?=
 =?utf-8?B?SFRZQVorRTFLNXltanZBd3FtMmMrUnA1TkpqSWp6MjRCN2hpMzhnYlJhb3cr?=
 =?utf-8?B?OTJIM0NxYUxvMVlxdWxSeGlpS3kyY2ZjelNyN0t2YXNTSTdiRFV3T2p4RE9j?=
 =?utf-8?B?ckVwQjJXdUJMVXp1VG11THJzTWgyOE94SVRuemk1Mmd2R1A3UUR1RlJzaTR6?=
 =?utf-8?B?Wkk5b0JhcFhMTUhPaGYrU1pid3FEaTZFdVNST2p4VkQwc1FsYzVHU1hvaHdS?=
 =?utf-8?B?QkN4N1puenZjeURkZXhBVXlzZFpZQURyWTNNRWZDYWFUWUEvc3IwNjl5TElj?=
 =?utf-8?B?R3BEQU1nNEhGOGZRbm40THh3dHVCcXo3UXc0ZmN2UEdYV1h4aUhRRVpudmN5?=
 =?utf-8?B?bHRxQ3hyMUlwSGtVTnk5dE9IMjZOU0c4ZG9yckRndjJQdnBkR1g3R0doVkpI?=
 =?utf-8?B?c0RySW1CVG9LR2FyOGFGVGtMK3NpVjdocnBvcEN5bUlnUEh0eTF1YlhQMG1v?=
 =?utf-8?B?U1BxMUhWVDNlaEZRam5DVERzZ3l1cVpnb2VUeDI0dWRJOXA0aGg5SGRQc1A0?=
 =?utf-8?B?VnhrT2RFSW9aSmpQZWN0SnhqMXF5d2dBZTlad3JQUzBlRnBucXpFZXRDQWhv?=
 =?utf-8?B?VFFlSnFPOVBkQW5VeXpqVVdCM3JsbEdJOTZvRC8vWVA4VTd2VkZhUXlpN0hq?=
 =?utf-8?B?aXl4dWREaTFWMDhoZk95TjVJaFQrbUpGakprZjlUVGs2emZ0OWxUVFoyRHBk?=
 =?utf-8?B?NXoxdHZObXkxVnJoUG16S1NIVzRzeUlReml3TElpcDROc3RLUTlPamNnNlB5?=
 =?utf-8?B?cE1wM1crWWdveEUybEtOb0FHQ0F2cTNKbWZvdjYwUkEwVVRsZGI0U2VVSUt5?=
 =?utf-8?B?YVdSZEpaTFdTd21vRHlHQzFtQzB4MnhleitvQjJBeDhzVHRNNnR6eTlVdEs2?=
 =?utf-8?B?YklXWVZaSU50ZVVrdFVqSmNkNWlnd056aUhhSTRkNU1Xak4zYlp1TnY1dnZB?=
 =?utf-8?B?OE9jYzV5TTZ3N3pibnVvVGR4OUxmandIcUIzdjhDSnY4WjV1a0d6aXVNWGgx?=
 =?utf-8?B?emxNcHNsbG1MYXVjVVplNkVSSUxodEdSYXhiVWFsMFlGR3NUZ0NKNFBsak1w?=
 =?utf-8?B?S0VhYlJYZ1VpUjlYU2FLVmZXU29tS2hDb1hNclczaW1CV2kxOE9rSWl5OTNQ?=
 =?utf-8?B?MzJHTGVGTkZMbFM2Q21GRGNHcTZ2Z2duMjZMaWVJQ2dlKzEwdXQ0M0lzN09w?=
 =?utf-8?B?SEk2SlZUZiswNFczdzB3dU14U2FFU3ZpRzVqSTZTWldSVWhnL3c2dTFEL1F6?=
 =?utf-8?B?cmlkbU5WNjVTZEViYkZuYTFQdVI2OVRIUEpjQ3VOZVdGMXVMWUU3NFBuRWdO?=
 =?utf-8?B?RzQza2FUdVQ2azkvYWkzYmFSSGhpa0dXRVBqQWtlV0JGWFc1dVNwak16L2hT?=
 =?utf-8?B?ODJHaE45cHNyVFo0d280WDdqaUJBU2ZyK1JDcWRkOGE0UTJhVFcxWVkxcDFB?=
 =?utf-8?B?TXpPeFlTK2h3NDFLZlQrdWhsRjlFVVdXVXBjTnR6NnJ0NjRydnB3dkZsZ25v?=
 =?utf-8?B?NU1JMHNzSm1PeEozZllEeXpPZ1gySUNscHVZbW01amVWUXRONHhQVG5Xem9q?=
 =?utf-8?B?Um45YWpQUnQwV1VLT243MnVibDduVmF2a2NtbGc3aGdlSUFhdE9vUzJPa0Vu?=
 =?utf-8?B?RzhWZTR2U2haL1hCTTRNQllhRlV0SnJ5VFZwQk1md3R0Qk5XMFRlUHVOaUJw?=
 =?utf-8?B?K29rdkIvMVo3c0JCVXliRjM1STF1ODBlQVpGVUdwYzI5ekZVTEhMaWoraHAy?=
 =?utf-8?B?MjVrT21PVnV6WEh1LzB3Z1RZZmdsaU9CcnBsc05tNEpPeThscERoR1lndzAr?=
 =?utf-8?B?d1RoQnNDQUNFRHFtRVNPTWNzQnFHVWgxcnRiNzRGeUhUdUkzUWN5YkVJRmw0?=
 =?utf-8?B?T1htMkdQYllDRTZNSUgxSDVDOWkwMHBNRzUycmt1N0dic01OcVRxQk1Vb2hD?=
 =?utf-8?B?ajU3dUM1ZUJsMUV3NmI5Uy9kd3plTm1CUFJaRVJOeHNKUVVBUEFpZ0VWSXJz?=
 =?utf-8?B?dUgzRlNIU0ttNU43RFFSZHNCcHM5VlJMZUx4ZVJJUUh6Q29ZQnNvenFQcTdI?=
 =?utf-8?B?QXVpMGVxQ3ptcEl3QS9kSDJLUklnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDA3BD08BBC4144C9A155C4888B686ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u1TRb70/iATC9+F7LLgjdbk1nSZNw7BU+Sb8Z8j4A/u2IG9JteeGaufJuoQJ9byS21NIM43argp75WutAmd1eN4AROA4l/6DiIWUx6Lwj2PQHpmQsNDedzGbvXLTcvd8wzSvnWnX8XmvkojFxShcKKd1gKG9U+xj1pnXjVTbfja0kIQ1BqN9I2Dklw7MQ/MZwCW/MlYNU70nI5/g0efzrSUNskU3dm7gLPnraWPN6TkUdOC5kLXCdVLkEC0uNbKAUVl6r/Uov07QMEMUqF9dPoo/PrrKBuumAuDAXCfDxAoPD5uL1AWuRG8DljzKrD5v++lJq4abisQZltk3jwUAktbWMeETIossLp+VlG4Blv+fCiN1hJIIx/5NH/pBmLgQPDo6TGfibtKwEhx18LfyoSYvgwED/Wox7vMNzqwQMkB1DvgDTx/B4GwbC8fbPat12i9gJq+trV37cedZkqcysCbFJix51GNozdLobqqhHIhMJTaIVTKYe8WHFnDcug4Uu9B7FvgokcoFWQmZS1xIhmsK6L40N/F+AuyQlEaY/P88Dr87oQ7lc3ErgnZ89NdvpYkTVtNQheGRRuAdf47TC1HhY/fJ2aT9f4SF6/EDXeHK+6gHiU1qDalH7ltGFFmq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b2acb9-9fce-4bdd-1c6c-08dcafdb3ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 14:32:12.9967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUiLESSQEzXQpJcrxeQl3DAY0KedsMTLmWw5InJvHRwzopGsqwljcIsn7dt3591lwZfzi26SBN4UfDAqXoM/TEV3a2GIShqTpYscivWtJT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8525

T24gMjkuMDcuMjQgMTY6MDMsIErDqXLDtG1lIEJhcmRvdCB3cm90ZToNCj4gSGksDQo+IA0KPiBT
b3JyeSBpZiBJIHBvc3QgYXQgdGhlIHdyb25nIHBsYWNlIGJ1dCAgSSBkaWRuJ3QgZmluZCBhbiBp
c3N1ZSBtYW5hZ2VyDQo+IChsaWtlIGdpdGxhYikuDQo+IChJIGFsc28gYXNraW5nIG15c2VsZiBp
ZiBhIG5vdCBhbHJlYWR5IHBvc3QgYnV0IG1heWJlIGJlZm9yZSBpIHN1YnNjcmliZSkNCj4gDQo+
IFNvIG15IGlzc3VlIDoNCj4gDQo+IE9uIGEgd2luZG93cyBob3N0IGxhcHRvcCBhbmQgd2l0aCBh
IHBhcnJvdCB2bSB3aXRoIGEgYnRyZnMgYW5kIGFmdGVyIGENCj4gcG93ZXIgZmFpbHVyZSB0aGUg
dm0gbG9va3MgYnJva2VuLg0KPiBBdCBzdGFydCB0aGUgdm0gZHJvcCBkb3duIHRvIGluaXRyYW1m
cy4NCj4gV2hlbiBJIHRyeSB0byBtb3VudCBmcm9tIGFuIGlzbyAob2YgdGhlIHNhbWUgb3MvdmVy
c2lvbikgaSBnZXQgZm9sbG93aW5nIGVycm9yIDoNCj4gDQo+IG1vdW50IC10IGJ0cmZzIC9kZXYv
c2RjMSAvbWVkaWEvdXNlci90by1yZXNjdWUNCj4gbW91bnQ6IC9tZWRpYS91c2VyL3RvLXJlc2N1
ZTogY2FuJ3QgcmVhZCBzdXBlcmJsb2NrIG9uIC9kZXYvc2RjMS4NCj4gICAgICAgICBkbWVzZygx
KSBtYXkgaGF2ZSBtb3JlIGluZm9ybWF0aW9uIGFmdGVyIGZhaWxlZCBtb3VudCBzeXN0ZW0gY2Fs
bC4NCj4gDQo+IGFuZCBkbWVzZyBnZXQgZm9sbG93aW5nIDoNCj4gWzcxMjgzLjYxNTYzNl0gQlRS
RlM6IGRldmljZSBmc2lkIDcwYmYwOTUzLTNlZTMtNDgxZi04YTdkLWY3MzI3YzZmYmE2Nw0KPiBk
ZXZpZCAxIHRyYW5zaWQgMTgyNjE2IC9kZXYvc2RjMSAoODozMykgc2Nhbm5lZCBieSBtb3VudCAo
MjQxNTYpDQo+IFs3MTI4My42Mjc2ODFdIEJUUkZTIGluZm8gKGRldmljZSBzZGMxKTogZmlyc3Qg
bW91bnQgb2YgZmlsZXN5c3RlbQ0KPiA3MGJmMDk1My0zZWUzLTQ4MWYtOGE3ZC1mNzMyN2M2ZmJh
NjcNCj4gWzcxMjgzLjYyNzcxMV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYzEpOiB1c2luZyBjcmMz
MmMgKGNyYzMyYy1pbnRlbCkNCj4gY2hlY2tzdW0gYWxnb3JpdGhtDQo+IFs3MTI4My42Mjc3MjVd
IEJUUkZTIGluZm8gKGRldmljZSBzZGMxKTogdXNpbmcgZnJlZS1zcGFjZS10cmVlDQo+IFs3MTI4
My42MzkzNDVdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjMSk6IHBhcmVudCB0cmFuc2lkIHZlcmlm
eSBmYWlsZWQNCj4gb24gbG9naWNhbCAyNjk4NDY5Mzc2MCBtaXJyb3IgMSB3YW50ZWQgMTgyNjE2
IGZvdW5kIDE4MjYxOA0KPiBbNzEyODMuNjQyMDg3XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYzEp
OiBwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFpbGVkDQo+IG9uIGxvZ2ljYWwgMjY5ODQ2OTM3NjAg
bWlycm9yIDIgd2FudGVkIDE4MjYxNiBmb3VuZCAxODI2MTgNCj4gWzcxMjgzLjY0NTE2M10gQlRS
RlMgd2FybmluZyAoZGV2aWNlIHNkYzEpOiBjb3VsZG4ndCByZWFkIHRyZWUgcm9vdA0KPiBbNzEy
ODMuNjQ2MjI0XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYzEpOiBvcGVuX2N0cmVlIGZhaWxlZA0K
PiANCj4gSG93IGNhbiAoaWYgSSBjYW4pIEkgZml4IHRoYXQga2luZCBvZiBpc3N1ZS4NCj4gKGkg
ZGlkIG5vdCBjcmVhdGUgYmFja3VwL2J0cmZzIHNuYXBzaG90KQ0KPiBJIGdldCB0aGF0IGlzc3Vl
IG9uIDIgc2ltaWxhciBzZXR1cCAvIHBvd2VyIGZhaWx1cmUgYW5kIG9uZSB3aXRoIGEgeGZzDQo+
IHN5c3RlbSB0b28uDQo+IA0KPiBJJ20gcmVhbGx5IG5ld2JpZSB3aXRoIGJ0cmZzLg0KPiANCj4g
dGh4IGZvciB5b3VyIGZlZWRiYWNrLg0KDQpUaGlzIGxvb2tzIGxpa2UgdGhlIHN1cGVyYmxvY2sg
ZGlkbid0IGdldCB3cml0dGVuIGNvcnJlY3RseSwgcHJvYmFibHkgDQpiZWNhdXNlIG9mIHNvbWUg
a2luZCBvZiBjYWNoZSAodm9sYXRpbGUgd3JpdGUgY2FjaGUgaW4gY2FzZSBvZiBhIGRpc2ssIA0K
b3Igc29tZSBvdGhlciBjYWNoZSBpbiBjYXNlIG9mIFZpcnR1YWxib3gpLg0KDQpZcHUgY291bGQg
dHJ5IHRvIG1vdW50IHdpdGggLW8gcm8scmVzY3VlPXVzZWJhY2t1cHJvb3QgYW5kIHNlZSBpZiBv
bmUgb2YgDQp0aGUgYmFja3VwIHJvb3RzIGlzIHN0aWxsIHZhbGlkLg0KDQoNCg==

