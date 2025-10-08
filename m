Return-Path: <linux-btrfs+bounces-17525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDAEBC4B08
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 14:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA27189A1A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956162F747A;
	Wed,  8 Oct 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oWiXHEpy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mqO64/kR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D84C8F;
	Wed,  8 Oct 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925068; cv=fail; b=EKAkMas+fWhpMDlXle3uFOgqyeBfZv7qt6hs8fcAnYzXg+SWMyiNlTna7gCOVHBIniOfa7mosMCwfontZuXD9UrezOd4W6Ctu/LfaoK9HIBIzeeay6OKg5dw2IMjSQmm3a4f7W0fpSm7I2hzyaVtJlZ52n9biPmPFmeQQ2oN2UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925068; c=relaxed/simple;
	bh=Q3V1DWCp9M4fDn/MuMn0lIdo/fswBOz6F7csDXuk3nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k7WRTk6E7jB/fKHHAZECbybeIt85tReKuQJSd0iNA7cepqEATrA/+OVLIx/huIpDqVIfV/aVTbNBp5LKZKtcGtzLoWHKTjurcHxLI0AZkvS0E/OkONGzcuMmp/EvtNZbimPlspJlN42CGkX8Oi+EImhr8FG245yWrz/SGKIwkqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oWiXHEpy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mqO64/kR; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759925066; x=1791461066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q3V1DWCp9M4fDn/MuMn0lIdo/fswBOz6F7csDXuk3nU=;
  b=oWiXHEpyMzWjUZ7l59hXPfDdoaDiZX2oQkOGmnytfxvhUnMpnWTrJxKe
   yjqDDsRCZdCIplCE2BVE+hHBO5EcuZeKYXk8TV/+Z+vURWI6BFrC5KBRZ
   Fai91Fr4kNWis3hi/mZk5G2HuJJdYDvYiJNaNDGGWF6WnAiFznr61dK7s
   C0rf0ZnozJhzBC2u6Fdnfm1fZru/x/iLdvjp6YwrILpIJUNzcWZEHlbXy
   YRyRTdiKEx5FUU32mt9Mlo0qAevWPjew9Xn08Cj3uonrQCvwMz0UyFWAJ
   NyUIZaFjXw0fVyHG8cYjzBo5g/I/VvtvQZCPT6iworJYUNhMpi43BNC0z
   A==;
X-CSE-ConnectionGUID: u/6wDVteQdOCfIxk882Icw==
X-CSE-MsgGUID: T8vutGNVTmynvDfFR92umw==
X-IronPort-AV: E=Sophos;i="6.19,323,1754928000"; 
   d="scan'208";a="132503333"
Received: from mail-eastusazon11011033.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.33])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2025 20:04:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBTSfTcL/kvsRygnglx43AEyo17aSklvhwnMvDNUxOJFL5ik15lmc0HExjAP9IrZgzmtbH0ukI1l9Azugxy9PRDq+lerrMja7n4OXivkguGN3Yl7ba9MM6eXGNZde/Pfo8zKHryUM54MzEDHTyTbApGpw+UIGgVsrwVk3OcY5ppk1SSVLG3LLHyNaJd2M9spEFQxqp07ApFHuXx4hsNtcVbxSIAXAH4trOi+9rSFrPj1/IBf9lIM5zvCglyWGRsueoeuM8wh0KmD6HAhrowvwAKYzXu7Z5z2+kAEkr92KcZ+V+HKURfg6Ib6osD41FlpR0tJsybIxn/9dFmTXXXZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3V1DWCp9M4fDn/MuMn0lIdo/fswBOz6F7csDXuk3nU=;
 b=EKyFw/tXR17wZ9RnynU4Oa7wDug7h0QfkiW6xd6NxhxRdypi+BEmhwXDcTPBkHQAndIQq7FF6FW2mGX5ooPWCJReg5uplAnlsSdhGdMCHln2mcocWh8M4d8hymCPqac0M7QGMPQJitDYvfuLhUjCC8fktWgAVPyVHwZyf6chjNgQ4CLVVrvP1VY94y4MkVCMhUaNiA0U+2mnA/EDNY9/34mmm7SQPwWZ8CQEZdaZcP4ynMWEtTaCQ/umOrOb+LXb7z0dk4GK4atFPctOrAca1dZ1XvYT5tpC43EHrj3706kw7u6Z/Ar1jakXgB4lrE4KCIlAWumpLG/H77441roj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3V1DWCp9M4fDn/MuMn0lIdo/fswBOz6F7csDXuk3nU=;
 b=mqO64/kRXkkyQjZBH/dFAD5AXEqW9ZZZXwI40YLJxMi1PqtgzFqv6AVjHA15pTcgG7+ykDY183B+8cXDicISsLdxvLXmnk/71E0pEsHzLwOEBrLuvbatyRhWNTlqgp4e/J9OX4vmsWNGVjV+n+HQhEBCbkQjoVy3nEjyATg86w0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN7PR04MB8548.namprd04.prod.outlook.com (2603:10b6:806:355::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 12:04:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 12:04:12 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>, Naohiro
 Aota <Naohiro.Aota@wdc.com>, "boris@bur.io" <boris@bur.io>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: fix memory leaks when rejecting a non SINGLE
 data profile without an RST
Thread-Topic: [PATCH v2] btrfs: fix memory leaks when rejecting a non SINGLE
 data profile without an RST
Thread-Index: AQHcOCbn4bxpwrlQqUSA5Ls52qFwzbS4JqqA
Date: Wed, 8 Oct 2025 12:04:12 +0000
Message-ID: <2e943abf-2adc-4726-85db-c2ee5dd97017@wdc.com>
References: <20251008074031.17830-1-mssola@mssola.com>
In-Reply-To: <20251008074031.17830-1-mssola@mssola.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN7PR04MB8548:EE_
x-ms-office365-filtering-correlation-id: 0955a696-774e-41a0-d9a7-08de0662cb57
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGV4aStDN3RYRXk5MWd6b3JnNlBhYmxvVGtOc1V1WlVTM3VDVEhOc3lEanVO?=
 =?utf-8?B?M3NVYWJyZkJGcjloUk9RbUlkL3pKUHdRU2FTU1hoc3FsZ0NBUFRjV3hOQmIx?=
 =?utf-8?B?Z1o1Q25nZTc0TVMwWStEQUlCUEg2M2Fxbk9iUDlvelNIMWErcm5oblMyK1hm?=
 =?utf-8?B?Z0pSYVEzVzBkR2NXbjBrUDA5MHZRN0hRS29rRFFhUTRwdm1DeGczaDlabHJ6?=
 =?utf-8?B?T3VMRFNsVFhVUUd0VTZFN1BmaDFLbWJucXM0QnVpdjhZNmloNG1lcWdIMjh3?=
 =?utf-8?B?dFh2ODZtYVZEZXpVZEdsK3c1VXluQSsyZHROUVJFdkZhNC95djlrSVUrQVZu?=
 =?utf-8?B?MGorNzd2M0wrOHVaemNIREh4OW5ORzNwZ0w1ZU9aWXRvUjNqbFk1Z3VWeDNk?=
 =?utf-8?B?VXJnZVRxem1JajgwOXBEWGdkbW4vcllkdWNJUWNBSDUyZWZqendGR0lpVy9S?=
 =?utf-8?B?WVB2MTJwNzhpUnNOZEhKVE5KWEdPaHpSUTc5QXhHQ0dFb3VqS0t3Vm16U3Fv?=
 =?utf-8?B?enFMaG1LKy85RWQ2QTJiUTVpVElRenB5WnBwcVh5NGV3OUVlclFyQktSSTF6?=
 =?utf-8?B?amFaTnlyVWNNOVlwbDNPKytqekNDL2xFMVJ0emE4Q0NrMVB1NVpQbXhpT0lz?=
 =?utf-8?B?WURHazFDdk9MSWYwbzZ2NmhsOW5JbkRqOWRkTEY1bDFaT3lnWDFoN29qcjhS?=
 =?utf-8?B?WDhIbXJOLzlyeVNDNTVYT3hlV2dienFXR05BTHNGL1dkYlVodm42cDh4UEkw?=
 =?utf-8?B?bUNXKys3VGtVWDVwSWRwWEdEbzNUVGJzSmRBWTRjOCtSczZLUzZFcXRlSWxH?=
 =?utf-8?B?S05qMm5hOWt6Vkg4aHpvZU5wUkQzbGN0UDNtdmlWdUcvTGUzcG9EK0NCYzI1?=
 =?utf-8?B?dG9ZZm5rQzRkRUROenkreUY4M0VwZ3dNSFRZVFl6ZHFTMHA4RXcvcGk1cXNq?=
 =?utf-8?B?Y2l4RVB0dDZLc3F3REF3SUV6alY0N3BEWjZXZzYyVmpjTk4zeWVvc0JLNWZP?=
 =?utf-8?B?dGw3L2U3eG9zRncrRUdNSkk4ZENrQ1puZnlxc0E5dE5vZklRMVhIUkMwcFVB?=
 =?utf-8?B?WmRsUnR6RHp3Q2xiRVhNcksyMC82Vi93Q2Iza0RmYkpMV3J1N2lpM1RzbDR1?=
 =?utf-8?B?elVjVnQ4ZCtibk1LaHhjajVkM2dSSlZ4MFNpRUlEQzFlQk1kUmp5bURObFZB?=
 =?utf-8?B?eUdkamptdTRmVWdjOHZ6dVQySmNPeWs1dy85eDVDYjRIUlFRTGVIT0RpMzhL?=
 =?utf-8?B?VURVSEIvSU1naXNWc3BFajVqdzg4cDFVZTlRZDU2UnJwQnBIU0UxNzhpYzhN?=
 =?utf-8?B?TWh4VXJHWElrdU92bVNJUE85ZkRPUnF1OE1vU1BZSUYyNnVOditMb0RKYXRu?=
 =?utf-8?B?c1BFbm16YmY1eU1SbEZWR2pTVXhCWFpRRjRNTXBJZXhDSzU3Z3I2TUF4Qkg3?=
 =?utf-8?B?VE9uRGZYSy8zMVVnR2FtTGQrZFg5TGpob3NrRkVtbkM1MHowb3FGaDA3R0NK?=
 =?utf-8?B?K3NYaXZwVVFPTTBEOGlxSSt5am9DcVZVNGd3UjFhS2FpUE5MSFM3allhRzdN?=
 =?utf-8?B?eFFiazNPNnBrN0pwbFhVaGRhdDlvUzlWMFFxTDN6YzNQa3dSZWZmemx6SlR0?=
 =?utf-8?B?RG9lRm0rb0Z0T2ltUUxMb0VNeWFDWkM3NTdCQ1FwbktvRHIrdmM0M3A1Yyth?=
 =?utf-8?B?WnUzSVRFWEcvd2Q4UEwzQ01FQU9BT1hPZXFGVHN1ZnF6UGE2cHRVODZ4bUx5?=
 =?utf-8?B?dk90N3BRNjh4aHFYTmpCMUx6eHNSMllwVmYxenA3UFdxc1VvSUo0bVh6RHk1?=
 =?utf-8?B?b2lrcWg4bkU3c2ZSUURtNzJXRFFKRU1XUXhDVkRjVkNUV0toL2tzTm9HWnlV?=
 =?utf-8?B?SmEyUmF2QkIwRjJWL2xUQldQUmsra3lCQmY4NjQ2dG1WOURSMDF6dHA2NzBB?=
 =?utf-8?B?NFBhUE91a1EwblZGa0RxWDVoSUJuSTlpMDcwbVo0Zm9Td3NpTDJSMzNISkpN?=
 =?utf-8?B?VHlmMXRtWGN1UFc3aVBFYlFHWXJ4bDZ3ZGxvL2pBZ3ZlZnhwelpMb21QU1pk?=
 =?utf-8?Q?KGEDl1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3I5R3lDbTJqVTBDSVpBNGNYN2JLL2RLZ1BxNEZEdDB6NzRCZnU0ZUI5aC9O?=
 =?utf-8?B?c3FCbDJYMGwwVlhZZDFpWWFCU0VLNmFGUythYm5jRnloODAybmhvNU5xSktx?=
 =?utf-8?B?NHlrQlZlejYrZ0M4L2F4cVl2UTRTeFlUdXptMU9jWGlTcjFNVUpRWlEvbElr?=
 =?utf-8?B?bWN4SjVjdEtPZmtGa3ZmTEthTTdqVlBKbGdMZ1pwaWx6RTNNOExDbUZoYXo2?=
 =?utf-8?B?ZTQrdEVsSDZ2OUJBeWdHWEpUV2JBaUw3aWZGbWlMR0VnVHp0U21VWmxybjVr?=
 =?utf-8?B?VGthWW1sQ0hwaER5UFhrUU5JZ0tYMnNHeWxqSy9vbi8yNWtXZWhXLzJqT09K?=
 =?utf-8?B?OGFBQWF0TkE2VmpnNUtoR1lKQmloWWhPQktzdHZIby9CdElGN1VDblcxTGdq?=
 =?utf-8?B?K2g5WUFnNnlzQ2t6eW95empuVXRHMVlzZ2JsNzBqa1NZbTdaRWliZy9qTWpS?=
 =?utf-8?B?OWxGNm5JclprYUZEcG9TYlhFRzF4cTRpVkRVRXh3WGp6MTQ1Y1h5UVFIUE9w?=
 =?utf-8?B?RzkzNVAzeHZzSmVpMFRnSHpTWGIwVVF3Y1lYYmFkM2hMcFA2MXI4WjFiKzFx?=
 =?utf-8?B?aldMMzIzTFdGYW9EcXlOdDB1TGFvcEQzOWFJN0xaNHFTdDh6SXRWNklxTUFK?=
 =?utf-8?B?aDlxaHBEanI0YXdYSHVOQUExSWtRZC9qemdUTXBQNlMwa1N4TUFzd3ErU0or?=
 =?utf-8?B?dkJDVHRJcXB4Mm4wSnNkUmx4a21TSVVJMG9hT0VpZ1FST05jbVRMSGZkcnky?=
 =?utf-8?B?WEdCUGpYbjVqamFVdVpPNHpsZTU4eTRLM2IxdVBnNjFjZXR2Zk02c2o5S1or?=
 =?utf-8?B?M2JSU0h4RFNQSGc2VnQ1dlpBeVVUR1EvNWcybXVYY0ZFdmtmemtaVU01SEVh?=
 =?utf-8?B?bkNqOElHWVBaRElEK2UxQUVkT3YyOFcrMzBrYnpYZUVvUXVtemRlcVJaZ2ZX?=
 =?utf-8?B?VXVZSlA1Uy84QVlHL2phd0YxOG96ZGg2Z3pmTEJWRFE1V1pwNG9BY1VnMkNa?=
 =?utf-8?B?ci8rbVRRZ3NyUlVxWHpRK1hxb2pCYTBZYy8yWG9nUzgvd2NsczBZRXZhV1M3?=
 =?utf-8?B?NzJwQkt2dHNteDhxS2REYlR1aUo0WWFHRUNBV3FCZ25jcGkyb1Fsa0pQMG9P?=
 =?utf-8?B?OXRtaU9PL3FJWHQ5bllFcUpCTFZONEx6QURZbjhjUUdsRTYvcEhxbTVrRlo1?=
 =?utf-8?B?dVE2VEVVL3RXVXVwUUJzWkhwTXFCRmQzVVF5OVBENnNNemE1emJSejdJSHdS?=
 =?utf-8?B?TTJZUUk4WGJieHB6YzVyVlFlYVgvYXI0NTNOTDhqdzEzTnYySU15b3g3eDgr?=
 =?utf-8?B?aVREWUxTM3p5ZG52ampja3ZBTGlSZEg1c3JydU1NSEpnc3FBVVRyYy9DMmly?=
 =?utf-8?B?Q0hnaE5SemVrVGgrMjlHeXBOcStHZFphaXZpdGlobjhYYkZ4SXljOTIrYVhl?=
 =?utf-8?B?YVFDQmJDZEl4bTA5d3lHU0xoOUUrZm9yeTJuZ3lBb25KcUVYb25aYlFIZWZ2?=
 =?utf-8?B?WFRJeit1aXIrUDhKQUJWKzM3OFNTbDFHcXR3Wk5CbTZERmxWMU5NMmI1S0Ns?=
 =?utf-8?B?aXFTeGJpckJlenpsVStiSVRrR1JpdXc0TXBBWXk3Yld3TXNOcUtDTGZWQWpU?=
 =?utf-8?B?UEFLZ3NDcGluUkVoRytrZkpiRVE1NG1zNUdWMHFMczREZ1FUSmdGZStsVkxF?=
 =?utf-8?B?U3hGYTR2U2NGMDA0ZUJPMEkwUGVORXFhRno5czNGNWN1WFBwMDV2R1dDMWVK?=
 =?utf-8?B?OFZVbEZ5RlE2eDVZSXNQeVZmdjlVc2M5VjNaTytaVHpSeWdjOFJsRnd4dXp6?=
 =?utf-8?B?VHlVcmFDZk1sOGsyN09rV1BvZlNyTDZsRTc1UTVidkN6YjVUMEVsRmVkNk12?=
 =?utf-8?B?UmsyaTJQdjYxcnVpNjloZ1F4Rzc3UWhlQU1RdjVNYlM3UERwcFBlL1oybGUw?=
 =?utf-8?B?aXZPYkl4VVhBclNwa2Z4bVBiWXNvUmNKcndkTTdPRHo0RzJCT3FsdjE0WGto?=
 =?utf-8?B?cFdFSW9rSUMzSGRZaGRUM1ZGbjNRWUpUZFlmb1p1U3ZqNnB3bVg5Sm1NbW9P?=
 =?utf-8?B?QUNnV1haUDVBb21velBzTDkrWGwvUEF5SjZTRTd1Z254MzBQelFQY3U2MGI3?=
 =?utf-8?B?SUpiTExBSDNieDBZc1VzNW1CUzdXSGJSNTN5RmxqbllsWTgxZmorWWR4NHc5?=
 =?utf-8?B?eXhmVDAwUUFwVEJvM21ZbWJLa1BUb1RkZ1R5Sk5CaWdvaEhCelhHdlM3d0pj?=
 =?utf-8?B?V0Z0c0dSd3JmY3RXMEFhZjl4dE5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9911C73FD81E6B4FB25A2215F4464BEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yW7QvZMGoXViiVFQ2bBK1TTrHO8OSQJxVXyuXZzuyXgCGEFuVl0fEEWVinvaLykG3p8VbNzO1A3qtMH0hkrmJJqLQScixeRkpzI/1Eabu9bWOAuvSKVQf8+L+NPnkqeu2C+ebwMWrcmEroUbgME0CRZehB+SBxAkLBK1vvJ/SxJrsomzmNYH4y6ms9Noss2sHHcYDU25TApdXYl7ckwh23f9G52DhwGPf37CSOi/hejT1c8wMMGbYdlCDtt9V3OAQO9FdbjlvFE/Jr29AeLGVVuf9j57nj/MozjHmCuCmmM7n6Nb+07+pPvz+DsqlrxXGjpCLLRb2Jn2XVFyfyk8MeI2pJ9JOjZRBhuyIlMwsX/3czefEMKaGcXA3kYmy+MEWBTE6cPNiCbSKq9m4GyzoCkA5jQAYa74BJn+xLY98zOJbDnt41i07Duq9tZG0Ro0sH8S8+FPEV7ukxNvFI17yQvev6rZKvrvytADLeqJYqcJf4llKzjwyb37HspBvseTU8n3beTycn2bpK4lmikuzVznF6+kVefA+bX+a2SfYvrPRXWT3E4I0CbbH/SsBw1BZombzdnvONWyh7dcoAj+IgLG7FRIEIVXYMbxvZhdjks5zEiiyZnMKidTrbeNbaAn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0955a696-774e-41a0-d9a7-08de0662cb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 12:04:12.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3SlfQvXPvJO7EHaEcFlQMKMpV/EJapGVkuowYGLsgxmv2vpf1733sQ3xAddTuFirQv4TTHYH10QLZhExM3ynRoidd6E1sueNanM/W+EJCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8548

T24gMTAvOC8yNSA5OjQxIEFNLCBNaXF1ZWwgU2FiYXTDqSBTb2zDoCB3cm90ZToNCj4gZGlmZiAt
LWdpdCBhL2ZzL2J0cmZzL3pvbmVkLmMgYi9mcy9idHJmcy96b25lZC5jDQo+IGluZGV4IGUzMzQx
YTg0ZjRhYi4uOGY3NjdhNmNkNDliIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy96b25lZC5jDQo+
ICsrKyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gQEAgLTE3NTMsNyArMTc1MywxMSBAQCBpbnQgYnRy
ZnNfbG9hZF9ibG9ja19ncm91cF96b25lX2luZm8oc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpj
YWNoZSwgYm9vbCBuZXcpDQo+ICAgCSAgICAhZnNfaW5mby0+c3RyaXBlX3Jvb3QpIHsNCj4gICAJ
CWJ0cmZzX2Vycihmc19pbmZvLCAiem9uZWQ6IGRhdGEgJXMgbmVlZHMgcmFpZC1zdHJpcGUtdHJl
ZSIsDQo+ICAgCQkJICBidHJmc19iZ190eXBlX3RvX3JhaWRfbmFtZShtYXAtPnR5cGUpKTsNCj4g
LQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCS8qDQo+ICsJCSAqIE5vdGUgdGhhdCB0aGlzIG1pZ2h0
IGJlIG92ZXJ3cml0dGVuIGJ5IGxhdGVyIGlmIHN0YXRlbWVudHMsDQo+ICsJCSAqIGJ1dCB0aGUg
ZXJyb3Igd2lsbCBiZSBhdCBsZWFzdCBwcmludGVkIGJ5IHRoZSBsaW5lIGFib3ZlLg0KPiArCQkg
Ki8NCg0KDQpOb3QgY29udmluY2VkIHRoZSBjb21tZW50IGlzIHVzZWZ1bC4NCg0KPiArCQlyZXQg
PSAtRUlOVkFMOw0KPiAgIAl9DQo+ICAgDQo+ICAgCWlmICh1bmxpa2VseShjYWNoZS0+YWxsb2Nf
b2Zmc2V0ID4gY2FjaGUtPnpvbmVfY2FwYWNpdHkpKSB7DQo+IEBAIC0xNzg1LDYgKzE3ODksNyBA
QCBpbnQgYnRyZnNfbG9hZF9ibG9ja19ncm91cF96b25lX2luZm8oc3RydWN0IGJ0cmZzX2Jsb2Nr
X2dyb3VwICpjYWNoZSwgYm9vbCBuZXcpDQo+ICAgCQlidHJmc19mcmVlX2NodW5rX21hcChjYWNo
ZS0+cGh5c2ljYWxfbWFwKTsNCj4gICAJCWNhY2hlLT5waHlzaWNhbF9tYXAgPSBOVUxMOw0KPiAg
IAl9DQo+ICsNCj4gICAJYml0bWFwX2ZyZWUoYWN0aXZlKTsNCj4gICAJa2ZyZWUoem9uZV9pbmZv
KTsNCj4gICANCg0KDQpTdHJheSBuZXdsaW5lLg0KDQpPdGhlciB0aGFuIHRoYXQsDQoNClJldmll
d2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K
DQo=

