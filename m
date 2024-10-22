Return-Path: <linux-btrfs+bounces-9054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CE49A99F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 08:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB7B216CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9EA145B27;
	Tue, 22 Oct 2024 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d8XvlEZy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zjpvoJUj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA25136E0E;
	Tue, 22 Oct 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579045; cv=fail; b=Ft3HNsNxhZU0WUHXVsKYZd9YfPZpLmwaHVY/9FcpGiHTw4h0hdWZ9cbvb+ffBqc92yOBg+ZDEC8p78Jk/nphE+Uz1hXplc6SWr6jd/e53R5tI6CI8Nbui1zJ6zx08T2DfpSdYu0h8gDr+mccPb3tQYzNcb47/h+QDyNtrB7d3AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579045; c=relaxed/simple;
	bh=DcZQraMW+ouEOjXJ645H88dYNsNBSu5c/CMfkO8yfRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKiFc960Jx+Sc3ex+z7GNw2K6D/Mpzuk9vnK7Ze7s+FTFtypT6UHJKYvI2owhZPzfZ2c3YyioGykz6CW/fKxk0XodbCuJkrYUSoF5e3iUpwfj+EjS68+VLDyzCyXTuw8s3qLuqm6xxyK3zcLm7our40RcQ1vw3XKEzFidC8S/k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d8XvlEZy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zjpvoJUj; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729579043; x=1761115043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DcZQraMW+ouEOjXJ645H88dYNsNBSu5c/CMfkO8yfRo=;
  b=d8XvlEZyj7iQ4tMOpxc5rPhR4Y6jwCBxLh+fk3NqOBX9+VBxAQ3HPDy9
   LMqwvd8gFlCOgud9CpHJxxaG8rgLepUX+CKMCYPcei+kKd4f5OuhKDXUW
   3rSkN0izQIcLq4dXGJ6Zh3g/oXSUsebfRQ+wLuKLv3LSL7BcZNnAKKPaf
   MwB177Xe+acwxdAzn8bLTh4F3X4ff2kXlg1WmPm7hZXb9NWkkZmRDKSKi
   NZTpy9JltYfn3fdz7//YzV7n45fNqdJ5L2aPpthPmBqfWfPgsLnvq/tRc
   OT1lucsPMA9o/wJF+XurU+C63sRbyJOHtXjNQ5fRUUJDo139IUqquJp3X
   w==;
X-CSE-ConnectionGUID: On4qorW0T/aOUEBWUUEEDg==
X-CSE-MsgGUID: v//tJptuRzukMvTmIvIMcw==
X-IronPort-AV: E=Sophos;i="6.11,222,1725292800"; 
   d="scan'208";a="30529057"
Received: from mail-centralusazlp17011024.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.24])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2024 14:37:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3ILdXoss74aRtvQhPxSFR/c3eFUmLbBSKtXkE3dm4Q4ZAa3Op07xoCys4J5TMt43CLHZ/fOKWaK65J74G44u0W0LZJenQH2EyAE0tkDWeX0HHARnFqYryjXjag16ltG7kju27yShhuM7omaQtPYhx+iGvO53tga8UZuwhRj7QaUt++aOUPuTVi/6aIDxT2VnxHZ/AcBrMjAlqpvn0Fygx20dz/ZThgbGMrzRs2wpnnLoDDffHKZj7yN1c8OIBFrY1Fo8NSRhowx/G8yo1FjPRUxZeTYWL+JBetADmciI3KsF8M+PgeolwpT+x7mSA1MkmxTaDfTtppSRK7Nm0/HsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcZQraMW+ouEOjXJ645H88dYNsNBSu5c/CMfkO8yfRo=;
 b=hR3oA7T7T0zeWQAgGaUAv28uit1idH4y8dRcMqZ/+h9A+1T1Z/oC5jb6P7uxfJqNZNjdRBmYoQI5B3EDV+WZGUzdiA/goO9bx8UEc5A9PuGbnvp5l4ioQK7gVsLpPBnyyruPoMbjh0+4MVIqsizc9t2pApPQzJwGz2jbj3pMN05SrCuD5hh5GqloQaUJqo8Z4c9ieikUZ5mfTLvrLRSMzY2zI5jIsQX08Nxo/a+bfnQxPdnSrdlsLB/RQcSqElh+gTMHjwaa6lr70XO2pnLVsb5f6cO7gSPmO84MY68W3s2RDsminl6ejzpcOn7gNczxVnJAiyOzSZmIDNKRRXHRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcZQraMW+ouEOjXJ645H88dYNsNBSu5c/CMfkO8yfRo=;
 b=zjpvoJUjuizcnfzP4KCGMBD7VcvcZmCLnCa0PtlMkW8PfBZM5GXEc8QsiDl19EkL6Bgj/zUq4iru0O/C4nC7EEkyiER0UxdiwdI/fXjIHZ0A5MEgSXYP5jqFxPgLae5hxhp7KyujJR0RmCMKcQP9CiwXPrZvJTQmEi95dHIn2Eg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6323.namprd04.prod.outlook.com (2603:10b6:408:78::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 06:37:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:37:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yue Haibing <yuehaibing@huawei.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>, "mpdesouza@suse.com" <mpdesouza@suse.com>,
	"gniebler@suse.com" <gniebler@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Thread-Topic: [PATCH] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Thread-Index: AQHbIgZDQrfHY2OhyUuOS1VyUQ58brKQ4ZeAgAE9qQCAADZggA==
Date: Tue, 22 Oct 2024 06:37:18 +0000
Message-ID: <89f8474b-c7da-470f-b145-a73088ee381c@wdc.com>
References: <20241019092357.212439-1-yuehaibing@huawei.com>
 <7daf798c-64e1-4d22-9840-8954db354c9a@wdc.com>
 <01b2539f-6560-baa2-d968-5675f0ff2815@huawei.com>
In-Reply-To: <01b2539f-6560-baa2-d968-5675f0ff2815@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6323:EE_
x-ms-office365-filtering-correlation-id: 6dbfc1f9-b1b7-4608-e837-08dcf263f9b1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGU4eXFwVyt3UXk4QURNVHJ6WUlVajd2YVVmL1RhUjdWeUpTSXErZzRZcGhR?=
 =?utf-8?B?TU95QVR0cnE5SEhYZmozZys2ekp5ODdhTWlKcnpNN0twNHBTcVFURUU3V2Q5?=
 =?utf-8?B?ajI0L21jU0lpK2NXQi85TkFYVFNZSDN2Z0NKV241REpEdThzK0ptUEU0V1Q4?=
 =?utf-8?B?LzdRcHlhK2M2bG56akUwUWE5a0I4ZlRLTkRqaDJ4dVJLWkZrM3dLNEJZdkRN?=
 =?utf-8?B?djNydm1oaXlwOWhLUi9wZEhMMm1QM2FEeWtlTUVQV2FHTmd6SGxYUDAzSEM1?=
 =?utf-8?B?K3FnSFlXVmZtT0hnSHVsL0lyZnNuakRlVGVFSk9jVHBlTG85eU5MZ3RFc3Ux?=
 =?utf-8?B?TDZKNFFZTjVIQVV5UCtScUhFQ1B4SlAvbUk0NzVybVlwbzllNmNwbi9pTlRi?=
 =?utf-8?B?T29jcU5ROUlBYmZCVWZVZU9pVUZNSHhJZmJJMlpocE5oK1pvZkpPSTJBWUk5?=
 =?utf-8?B?cVh6cFJmRy92UVpacno1ajdoa1RBTjRBZFpsZm5VclJwd2pDT1BYZkhVWjlY?=
 =?utf-8?B?b2JqZ0cwOFRvU1Fub1NSYzQzQ2hvOGFaaTBKMFc1d05RN1RkMHlEaHBUd0Fi?=
 =?utf-8?B?UjVhV1NpcVVJdVdnNjRNRmhOdmNrNjNqbGgwVDAvc2FQZGlaV0FMWkh3RDNn?=
 =?utf-8?B?MC9LS2djS3lTVzZjUnNvMTJyQXFwVEV5SHc5ZGx0Y1NHZUgvaCtzL3ZiUEdN?=
 =?utf-8?B?VCtPbDRDQi9QWkNqM0JXL1NDdU5ab2ZIangrSXovMzJKb2NmRER1SVRDOTg1?=
 =?utf-8?B?bDhRbmtQOHVtb3hYUDY5UVlCVkNIZFJleCs1Y0NVMXRiWmNwaHJrZkE3a2dJ?=
 =?utf-8?B?b2EvNHN0S3o3aW1PNEZDRENwMlVGYjZaUExGeUIvNVBwZnZxSFJLcTErdklo?=
 =?utf-8?B?ZWp3TkY0SW41c21IdzdkRzBXQUI4ZG9wOXErWUhFcVYzcEVUcysrTC9lUmU3?=
 =?utf-8?B?MG5RV3B2U0xKS29nQm51a0dLRTJSazJyV29pczBEeDM4MzNEQWRMRk5xMkFC?=
 =?utf-8?B?bVJQWjBJUU9RNGtGNlZCVk1YdXEvMXpTZ28xekp4UFlESS9iY3ZUcExiM0lm?=
 =?utf-8?B?dTlJZDB3NWw0c2xuZFdMVTdqb2lCejNvdHBhVTNqWUZYQXJaa3JqVTlqM1Mz?=
 =?utf-8?B?UU0xZkpjUTRSMlBHRFJsS2FxODhkQVU5azhFeExIVGRxSHZTd0VRZENJYmpr?=
 =?utf-8?B?VHpEUDNiK0lUT2FmcWlVZHkzSXQ4WUZjWllsWXIxWFViWitaSzljZWhCTERH?=
 =?utf-8?B?c211QnFHekxyTEVHMkxlSU1LT2RFdldSM0hhVjMxUHY0NjBvTUVyalNkZWYy?=
 =?utf-8?B?ajVIL1RCcmpJZ0NMcEFWaWU0WHpaNVpXT1dLRzdyY0xpWlQ3bndkdW9qS2lq?=
 =?utf-8?B?MU9pNmVvVEI0bUdza3lGeEZxRE4vWWphVFhNS1dETHROdEZuaHlRK0owQkN0?=
 =?utf-8?B?REtFL3RUSzJHKzNscnZTTUpCcW5lSHZJVXlLdDFnV01jUEdkMDhPcUVmdVNa?=
 =?utf-8?B?Z3o5UDVma1FVOVJPVkxMUUFHUEpBQWlGaHpTU3BNcTNKYUl3QzBZZTBLYjlv?=
 =?utf-8?B?OWM3cjNvS25PbjA4b0JqUlN1aUUyaHJXVEsrTnBUcVJNbUhkSDBjM2NjNGho?=
 =?utf-8?B?aDZUcU5BbVg5cHlZL3lVekc4RjJaL1QzZTBqRzNCZW5TajVBay8rQnY3bzJk?=
 =?utf-8?B?cHJlbXhyMXF2eVpBaFFJaldCNGRicDhZZ1BBRkhyWlZONmNCS3RzekV2TzA1?=
 =?utf-8?B?a1A1SW1ETVR4SW41REVCMW9uWTA2WnI0a3lFNXFESllVRW9KdUxzZCtJZGl4?=
 =?utf-8?Q?5U+vGujd5vbjspiej3o01jdgq6fX4nj1Qp+Nc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2RvNXFydnJlb0NKYzVranRtN0dCRHpTMHNhU3cwR1p6K0I3K3YwRWNPeTQw?=
 =?utf-8?B?aHlPTDNXcExubFBpaDNpcndWNjZkc0xZMElNaktRamVqM0l2a0V3ci9mRW1l?=
 =?utf-8?B?bVhIZjRMWjZIRFlzZGc3WGR1eVkwWUNtRjg0THQvNmJkelNEOUk0d3ZhSXFB?=
 =?utf-8?B?R3dRdFczMWlIeGFSNGVGRmxDT0RMbG5OVEhlNHRSVk80ajk2ZFRsUWpUM0xs?=
 =?utf-8?B?L2J5WkhSMXN0ek9CVGhMMk5ldzNydWtvZVR6MU9uemRucGZCblI5UHdBenlv?=
 =?utf-8?B?ZWF0cm1jV0VVV3FzalBqb3Q3Q0h4ZkNxVnlKZGF5RFl6ZmxXNlJuL1pIUFh1?=
 =?utf-8?B?bUlheEJ1MVZvSGRCWjVSbUNRdnlNMVRQT0E4UmhNWTlSZWkzcnB3dm5oUFZM?=
 =?utf-8?B?TWdMYWFqT0FYKzJ6YWpVZnF0cHg2Q3pPNVpScmduTEVWL0hRd1hEMkpEWEhG?=
 =?utf-8?B?N2hNTHlzTmtyYy9qdW9VVnY1b3pxWXFMNE1hNmg2dDdCSUtpR0JUaTZaNFVs?=
 =?utf-8?B?WjRsQnJwSGh1Ulg3SFFRZncvSk1TR3J4aTcxSHBreGtaVU5BM0pYVXgwS3c4?=
 =?utf-8?B?a2VucHlDV21kOGd6aTkyZnUyZzU3NUpZSGpwU1NNbGI0WjlwOWpOYmQ4MkNk?=
 =?utf-8?B?djB4QlVDRnhvQ1VqeDdSWktpak13V3BxNlJzQjJ6Q0tBa2dtT3ZJbXhXNDNB?=
 =?utf-8?B?UHdBTUdUSGVSUGFoanM1RVpJVmVEL1BJa0NxTkpyWWJLR2pRalVETlJvVlRx?=
 =?utf-8?B?aGdQNC8xcXVBaHY0QkczUEFrbnkvRFZwbUExOFBKa1E0QU9UVGdldHpNKzRF?=
 =?utf-8?B?M0NhdG5ZOStvLzlBN21QdmlYOVlZVnBjMGRKaUxhbGhIbDdDUUNXR2ZtZTlz?=
 =?utf-8?B?d0hDWkFMU21XYi9rRXl1ZnZrTC90a0F6SFZqQUVGRkxYUkx0eHRMaWtLVldm?=
 =?utf-8?B?T1BuUkVmRWdTY1NKOUxZM0hIZXpGaEIraGF3ZkdaVm1zVzRuQ1BuTWlTd0o3?=
 =?utf-8?B?M2xXMnJFSEFuckdMcHlKQURhMGF4QU5PVHUwYU1Pa0NoRFBhYmJMcEgwRzZD?=
 =?utf-8?B?dWtubFlFQ3pmMmFweUZHRWc0VjlhZDlneGJIc2t3UkxGNVNac2RNOWZ6SGdk?=
 =?utf-8?B?aEwvcnhZaXFOeVF4VlBicm5Ba3R6dFROTm10WFNkV0R6dDgyVlljNUw2c0lK?=
 =?utf-8?B?YmdPd3pvK01TYUdnNWRRYS9XVERRTU1EQ2JDOENqSzNnL1NOdTVuV2h6WFU5?=
 =?utf-8?B?M09vTVFJcmxlK0VBTlBSeDl5YkxXVzhxSDRGWEFoaEdXcnIwVDhqY3hIWHM1?=
 =?utf-8?B?ZWhhRi9ZUnZvQ2lwT0o1WGlDMHk4MTIxOWtERk9KeGF4dTIvYUM2NVJQQmpU?=
 =?utf-8?B?ZURMN0M0OHVnTnFiS1daT3BkWmFKOFlrWGRLZzF1QmtvNDdnZXN3bGNmcHE0?=
 =?utf-8?B?eXplbEdrb29jRFhiT3U2enhjUkVpUjBIVDRncjFBTHFTQTBiVWlxTkVLVTZ4?=
 =?utf-8?B?dlBHSjYyZXYvS1AxODhRRHdKdGxsNG1PTTBzdUptazNncFo0WU94TlRLTHgw?=
 =?utf-8?B?cDBuVVBOUDcrTkpjbXhMY1BlSUJXZ2NrYTJ2VDRQay8reElwMmRzOW4yZmpa?=
 =?utf-8?B?SDNiQnkvTVZHQUUwOXlYZUV4ak5MWUV5WTA2QTNjK2s0TjlCZkhWTHFaMCtN?=
 =?utf-8?B?cnl4K1A3OWowWjZUWHNDZFkvbk54QlZScHAyclA0RVd4b0cvUHRHQzFwcStw?=
 =?utf-8?B?aXJFRC9SNEFwcGg4eW1WT3RjK0YxWndnTDVOT1MzQkljS1VOV29GSSswbWpW?=
 =?utf-8?B?d0F0UXZqZG1rcE5TT0NkM3NUYmpLWEx6eGxpQWM0bldGTTNwcWlMa2ZXS1B0?=
 =?utf-8?B?RHlRbUJkN0dNTXEvbXV5UzF4SmpPU2lueXNqaG9aSUd0NGh4UUEwQ3BlS2tE?=
 =?utf-8?B?ekh0TjdnOEF5dWdqRzFkR2ZVOVZqUC9MdEw3VGI0RlhncjVKQ29OaFZhQ0pi?=
 =?utf-8?B?NTBPQk1WcUFjanliSmVjWE4vdW5MVVgrTkMyOFRrRHk1cUZoNHdGWHhzWUlE?=
 =?utf-8?B?bk91VHRTaTZHdExFRE1UenFFc1pKQ3UxNjZET2IwRmpoRUVWNXk0MWtFOW1P?=
 =?utf-8?B?NDFjMll3cE1GRU9VK09yblhkaUQvd09FaFp5aVFIckpoYU00bmxsSEFNMTlD?=
 =?utf-8?B?R2FtRWwvMmxlaUMxcGZEMkFhdjZDSmxaMzFPUlVLY3cwMnUweURsNDB6cHM0?=
 =?utf-8?B?VE5WWjhuNmkyL0Y2bWdpcWdDYTlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D274B7FDCFA4AE42A0430C0A7BD56AB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FfeGgAKGpQJw/YgFjo8cUofTA872hVHZIprnAzDg2IImkL7efibU91Z6IDV+BzQiquufxe6cHJzdyNxPu8znfQsyR74Dm7jw3M3ZOsgXrSkmug5M9H+j261PGRM/65hMBybEJYPY+2mnrn7sDl3pLdnj15+zROmriR5R+/6ynQmn+NiKQobz5b7kkHRJFB52G+YGJmWxpzLHLDBQnJivuBwt2kkyF9+1iakmKimYcWYV5gS7kbh8n+JrRu6t64rugvF6RipQgUm0ifCaIWg+5VJgkZUe9sAdnGNSKackUoMjdS2LIJB933UfsLhXNVGyOozeW9AB3+bPlSxcVLkFzhbJ5U5tGYk70F1pYbnWYB2MUbnvM75ZAbliGJsZS1oJv/uKl7tVWF1p+8updgxqQf6h+LsltFIC16PXAsmZ9WsGbDJMhzDCGU3QqLOc+jy6zihHrJIxwpMPVGJ8soE0XexEvKSCPKbCqke8OfHOad6x1epPNrxllPGzP1/Dd/ovhdNL+ho03kKQInwGik3awIEswQKAuT0GpEmLhBPaxvEP/mHJ9fs7GA779Mqo9yM8aqa0E4XSa1f9Fw2nDPj09oq8aIcAEjUJmvGU4bEylpceiYOxLofqhp2+6MkgKAxM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbfc1f9-b1b7-4608-e837-08dcf263f9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 06:37:18.4293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sdxggu3VfZ1I7BOti/7Kax1cUHTOHLvQVxDuI+OlUZToP8lM8ycrabxAhQ+MHd7iLZ8IBVE+qzj3t1ATiD/UgPS3kvQe0vCYyX6fjcXZxkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6323

T24gMjIuMTAuMjQgMDU6MjIsIFl1ZSBIYWliaW5nIHdyb3RlOg0KPiBPbiAyMDI0LzEwLzIxIDE2
OjI1LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBPbiAxOS4xMC4yNCAxMTowNywgWXVl
IEhhaWJpbmcgd3JvdGU6DQo+Pj4gUmV0dXJuIE5VTEwgaW5zdGVhZCBvZiBwYXNzaW5nIHRvIEVS
Ul9QVFIgd2hpbGUgcmV0IGlzIHplcm8sIHRoaXMgZml4DQo+Pj4gc21hdGNoIHdhcm5pbmdzOg0K
Pj4+DQo+Pj4gZnMvYnRyZnMvZGlyLWl0ZW0uYzozNTMNCj4+PiAgICBidHJmc19zZWFyY2hfZGly
X2luZGV4X2l0ZW0oKSB3YXJuOiBwYXNzaW5nIHplcm8gdG8gJ0VSUl9QVFInDQo+Pj4NCj4+PiBG
aXhlczogOWRjYmUxNmZjY2JiICgiYnRyZnM6IHVzZSBidHJmc19mb3JfZWFjaF9zbG90IGluIGJ0
cmZzX3NlYXJjaF9kaXJfaW5kZXhfaXRlbSIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogWXVlIEhhaWJp
bmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBmcy9idHJmcy9kaXIt
aXRlbS5jIHwgMiArLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Rpci1pdGVtLmMgYi9m
cy9idHJmcy9kaXItaXRlbS5jDQo+Pj4gaW5kZXggMDAxYzBjMmY4NzJjLi5jZGIzMGVjNzM2NmEg
MTAwNjQ0DQo+Pj4gLS0tIGEvZnMvYnRyZnMvZGlyLWl0ZW0uYw0KPj4+ICsrKyBiL2ZzL2J0cmZz
L2Rpci1pdGVtLmMNCj4+PiBAQCAtMzUwLDcgKzM1MCw3IEBAIGJ0cmZzX3NlYXJjaF9kaXJfaW5k
ZXhfaXRlbShzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCwgc3RydWN0IGJ0cmZzX3BhdGggKnBhdGgs
DQo+Pj4gICAgCWlmIChyZXQgPiAwKQ0KPj4+ICAgIAkJcmV0ID0gMDsNCj4+PiAgICANCj4+PiAt
CXJldHVybiBFUlJfUFRSKHJldCk7DQo+Pj4gKwlyZXR1cm4gcmV0ID8gRVJSX1BUUihyZXQpIDog
TlVMTDsNCj4+PiAgICB9DQo+Pj4gICAgDQo+Pj4gICAgc3RydWN0IGJ0cmZzX2Rpcl9pdGVtICpi
dHJmc19sb29rdXBfeGF0dHIoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+Pg0K
Pj4gVGhlIG9ubHkgY2FsbGVyIHRvIHRoaXMgaXMgaW4gYnRyZnNfdW5saW5rX3N1YnZvbCgpLCB3
aGljaCBkb2VzIHRoZQ0KPj4gZm9sbG93aW5nOg0KPj4NCj4+DQo+PiAgICAgICAgICAgICAgICAg
ICAgZGkgPSBidHJmc19zZWFyY2hfZGlyX2luZGV4X2l0ZW0ocm9vdCwgcGF0aCwgZGlyX2lubywN
Cj4+IAkJCQkJCSAgJmZuYW1lLmRpc2tfbmFtZSk7DQo+PiAgICAgICAgICAgICAgICAgICAgaWYg
KElTX0VSUl9PUl9OVUxMKGRpKSkgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KCFkaSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVOT0VO
VDsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihkaSk7DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBidHJmc19hYm9ydF90cmFuc2FjdGlvbih0cmFucywgcmV0KTsNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gICAgICAgICAgICAgICAgICAg
IH0NCj4+DQo+PiB0byBkbzoNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGlyLWl0ZW0u
YyBiL2ZzL2J0cmZzL2Rpci1pdGVtLmMNCj4+IGluZGV4IGQzMDkzZWJhNTRhNS4uZTc1NTIyOGQ5
MDlhIDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvZGlyLWl0ZW0uYw0KPj4gKysrIGIvZnMvYnRy
ZnMvZGlyLWl0ZW0uYw0KPj4gQEAgLTM0NSwxMCArMzQ1LDcgQEAgYnRyZnNfc2VhcmNoX2Rpcl9p
bmRleF9pdGVtKHN0cnVjdCBidHJmc19yb290DQo+PiAqcm9vdCwgc3RydWN0IGJ0cmZzX3BhdGgg
KnBhdGgsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBkaTsNCj4+ICAgICAg
ICAgICB9DQo+PiAgICAgICAgICAgLyogQWRqdXN0IHJldHVybiBjb2RlIGlmIHRoZSBrZXkgd2Fz
IG5vdCBmb3VuZCBpbiB0aGUgbmV4dCBsZWFmLiAqLw0KPiANCj4gDQo+IHJldCBpcyBvdXRwdXQg
dmFyaWFibGUgb2YgYnRyZnNfZm9yX2VhY2hfc2xvdCwgdGhhdCByZXR1cm4gdmFsdWUgY2FuIGJl
IDAsIGlmIGENCj4gdmFsaWQgc2xvdCB3YXMgZm91bmQsIDEgaWYgdGhlcmUgd2VyZSBubyBtb3Jl
IGxlYXZlcywgYW5kIDwgMCBpZiB0aGVyZSB3YXMgYW4NCj4gZXJyb3IuDQo+IA0KDQpZZXMuDQoN
Cj4+IC0gICAgICAgaWYgKHJldCA+IDApDQo+PiAtICAgICAgICAgICAgICAgcmV0ID0gMDsNCj4+
IC0NCj4+IC0gICAgICAgcmV0dXJuIEVSUl9QVFIocmV0KTsNCj4+ICsgICAgICAgcmV0dXJuIEVS
Ul9QVFIoLUVOT0VOVCk7DQo+IA0KPiBUaGlzIG92ZXJ3cml0ZSBvdGhlciByZXQgY29kZSwgd2hp
Y2ggZXhwZWN0aW5nIHJldHVybiB0byB1cHN0cmVhbSBjYWxsZXINCg0KUmlnaHQgZm9yIHJldCA8
IDAsIGJ1dCBmb3IgcmV0ID49IDAgd2Ugc2V0IGl0IHRvIDAgYW5kIHRoZW4gZG8gcmV0dXJuIA0K
KHZvaWQqKTAgYS5rLmEuIHJldHVybiBOVUxMLg0KDQo+IA0KPj4gICAgfQ0KPj4NCj4+ICAgIHN0
cnVjdCBidHJmc19kaXJfaXRlbSAqYnRyZnNfbG9va3VwX3hhdHRyKHN0cnVjdCBidHJmc190cmFu
c19oYW5kbGUNCj4+ICp0cmFucywNCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9pbm9kZS5jIGIv
ZnMvYnRyZnMvaW5vZGUuYw0KPj4gaW5kZXggMzVmODlkMTRjMTEwLi4wMDYwMjYzNGRiM2EgMTAw
NjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9pbm9kZS5jDQo+PiArKysgYi9mcy9idHJmcy9pbm9kZS5j
DQo+PiBAQCAtNDMzNywxMSArNDMzNyw4IEBAIHN0YXRpYyBpbnQgYnRyZnNfdW5saW5rX3N1YnZv
bChzdHJ1Y3QNCj4+IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+PiAgICAgICAgICAgICov
DQo+PiAgICAgICAgICAgaWYgKGJ0cmZzX2lubyhpbm9kZSkgPT0gQlRSRlNfRU1QVFlfU1VCVk9M
X0RJUl9PQkpFQ1RJRCkgew0KPj4gICAgICAgICAgICAgICAgICAgZGkgPSBidHJmc19zZWFyY2hf
ZGlyX2luZGV4X2l0ZW0ocm9vdCwgcGF0aCwgZGlyX2lubywNCj4+ICZmbmFtZS5kaXNrX25hbWUp
Ow0KPj4gLSAgICAgICAgICAgICAgIGlmIChJU19FUlJfT1JfTlVMTChkaSkpIHsNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGlmICghZGkpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldCA9IC1FTk9FTlQ7DQoNCg0KYW5kIHRoZW4gc2V0IGl0IHRvIEVOT0VOVCBpZiBp
dCBpcyBOVUxMLiBTbyBpdCBzaG91bGQgYmUNCg0KaWYgKHJldCA+PSAwKQ0KCXJldCA9IC1FTk9F
TlQ7DQpyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCg0KYW5kIGluIHRoZSBjYWxsZXINCg0KaWYg
KElTX0VSUihkaSkpIHsNCglyZXQgPSBQVFJfRVJSKGRpKTsNCglidHJmc19hYm9ydF90cmFuc2Fj
dGlvbiguLi4pOw0KCWJyZWFrOw0KfQ0KDQoNCg==

