Return-Path: <linux-btrfs+bounces-18034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA7FBEFB9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 153674F079B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48062E1EE1;
	Mon, 20 Oct 2025 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q/AoSj39";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h5gz7Ana"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07A2DF13B
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946196; cv=fail; b=MBx2DP9jMGm7mGPOzGRGmH94LsXt87DxjFAjoeB4Rd5808h/qlys4JjDN49bnw3JWeM7YTuS29+0BsEn1Ss+CFhmOkxlhrrCej2iDKTaZD5RKLhjZsr1C1av8C6cD6OQ+L5nw1IN3iqDdYyUoIvIZN/+B8H6KZ007pU5q57tQQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946196; c=relaxed/simple;
	bh=4ajKFzhXbrC99IuGuQs4m/9ohJWYn1PDt5E8c4ACO+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlN/DyQQWMh0+XrKjZR4KBfRFJ+x6K7izCk+nh8oe44vPQcRfy1057IkgaUTUfNI2llXX/0BLRi0fkbF1CM1KUHLkm9Zmwrgop1MzJLm3MJVMHim8eZBJqrljkpae5bDuwHkyEpygdewwdbYuNGLspXn7BOZR2IJIrpLM8xk5Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q/AoSj39; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=h5gz7Ana; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760946195; x=1792482195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4ajKFzhXbrC99IuGuQs4m/9ohJWYn1PDt5E8c4ACO+o=;
  b=q/AoSj39F8OPko/s53DSnvIMMHvACZuGPQ7s2rgSiWmL5V7SBMfWlqn7
   MV0aXwpgRXhs2etGELL2JI+KTVf5XZe0hvEQYjgUk6R9fnIp1/wVY9Y1r
   zCiSl+BWxE9BOHwHwSM18wE+c4XijaDnqLKlifxVpFfHeyx5FnHAcgXsx
   66IRcoQ67pdtkC2W/Vavyi7G62DuQCFEO91VivH+hqOPl9VoLhfPb/tBL
   3xL0x2VQ4zfq45qowtnqUBBH9DIg3m6Xm23fDu45CRErW9HUlPxOSy62/
   EwWrlv5DZHOIUB/TZLkeP4uNtupwrkUXk5BD8ed0VQfJHIg0fSjkREM9l
   w==;
X-CSE-ConnectionGUID: s97UpdhvSMyqv24r8LUy3g==
X-CSE-MsgGUID: ObleYbuNRyq4Hghd1XDBkw==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="134504703"
Received: from mail-westus2azon11010001.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.1])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 15:43:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5hGTF6YnnXH+aEhicVHWxA5TeDwEtKwrIPE9XnVgmxSTHA3oJ7GY2zZuTAC1v1AqtkmMhFqIK8hjpsSyTSDlGm9l9JcY246o82wZ1ED+1UdFPkST3kId5WDi4fdwCBqKODi5tD+3TyTUXub1jfVdBAQXK60FPviSQNHn+fvCFDuIdc/pS2r2Pj99JeooBpASl/lwbK//eETagofY5ZsPMPICv6KEktI1I3mOkPkoHzU87GpSjqP8IkxitXojZfckUP/MHwSf+/4Vb767CCTZRwyX/cMLDmYshhmbK/tJDHr95pL2kq5geLkg9Q6KhuWOVyxCoc1IvNKu5dUZNY7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ajKFzhXbrC99IuGuQs4m/9ohJWYn1PDt5E8c4ACO+o=;
 b=Mnj9tq1kvV4kvAJBzsnzy3B2JO48Ov612NFShqhWBqWVthsUIonW+dVKBpZM0sTfGKp+Ttk3os6SVz+XMEDbVzSmfHjjovW/R+8RN8hTQRmlh+liP4wC5GrjguEVCS8RdZwyCn2HZ0ZS98IUrOtXA7n7SyQTOAO+QS8MvQLoeYTe40Z+5qhnBJysvvVITeZXqeK8YZvF1u517B/c+tWnGTjPl1J5t+14F5XXO2rAE21A2LWc2fr+BRuquUSmlPKk5XsmVwnaV3z002LKXgHRBDc1chQ5p1NLEFfZ1w2DznL9CP4wuAOdyCG+Bpr89mzQpSOeBo6CDDnykO8RwKXgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ajKFzhXbrC99IuGuQs4m/9ohJWYn1PDt5E8c4ACO+o=;
 b=h5gz7Anaatd64tjIWrDALJvESOemau8RJfTRN9qZbQIqPfZvyyxYx0+Eqo0Njdu2yUIO9FU2iEsk4xSDi68z2HqdfF2GBD6CQH2Uff9wQzEqOBaJNRD/g7T/eEAKj77Vux7WK7ocJMvzJg9hzCgcmrXV3Nr89ecU21s6Meyw5i8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8489.namprd04.prod.outlook.com (2603:10b6:a03:4ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 20 Oct
 2025 07:43:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 07:43:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Topic: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Index:
 AQHcN1KuGCX0HNOhIkayN1jmYD5sCrS2iOkAgAE6w4CAAAEogIAAhrYAgAwao4CAAgBTAIAERZsAgAABVQCAAABcgIAAAK0AgAAHTwCAAAXigA==
Date: Mon, 20 Oct 2025 07:43:00 +0000
Message-ID: <21840904-beeb-4bbc-b593-49d1a8b71fde@wdc.com>
References: <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
 <aPCXz7ktsyE8BLeG@infradead.org>
 <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
 <aPXa9gR4l3WnI8kh@infradead.org>
 <506e7292-d795-4a78-9c0d-8442cb3b7a15@wdc.com>
 <aPXcYQPPYtA98MBM@infradead.org>
 <0f067fa8-acaf-400f-a36c-e124ae95e337@wdc.com>
 <aPXjFL6vz6UM_CH5@infradead.org>
In-Reply-To: <aPXjFL6vz6UM_CH5@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8489:EE_
x-ms-office365-filtering-correlation-id: 490cddcd-6ba8-4e79-d12a-08de0fac4b48
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|10070799003|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnR4bmRZc3V4QTRRczBhcmdLSlVSZHRQQWhuVmpLRlBMNk9tUTN5WDRPeGd2?=
 =?utf-8?B?aFExd3pvTEJ3YnBnU2xCR2VpVVRSK255ODBpZlZkOEo5WE9aaWNpQlZUU1Fa?=
 =?utf-8?B?VGdzRC9nVDdKRk4xc0djSkYwS1NXWGM4eVBJK1hMZ0FaWFlsckhCOHhCTk1n?=
 =?utf-8?B?cjZHckhha3B5QjE1T3VKd0N0RTNGZE1lTnpsSFFvYjZOUmI0NzE5YXdQTDBP?=
 =?utf-8?B?bWxYV1IwTU4zYTlBelVmWG9peWZRYnYzOW5ETjdGRElueWJFOCsveUFyNktZ?=
 =?utf-8?B?Q0lZWXZPazdJcEVqRUp6WGkwQ0d0N0M3TWlTcFBoRitzYjFubkFLcG1PdCth?=
 =?utf-8?B?YTIrVWFSNmppVTJTWFFWN00zT1Jpb2wzWjFBUUthQ0NvODZmSTNuRitoejlO?=
 =?utf-8?B?TXBKUFdYbXZJWWhFVEk0RklUZHNIYmxUS1JRbUlXTnY4ZWJHRHp2a2RKVWJG?=
 =?utf-8?B?S0RLMGZTUmhNRk9PajBBcTZqR2d1dkdWUFNBOEJUZE9FUG4vZTRBcDNDdjR3?=
 =?utf-8?B?anMwMjdva2JiMENYWVUxTndWQjVGVW92elVMeGpOYkduTkdyYWhRTHVsVElB?=
 =?utf-8?B?QkZUSU5qNXNnOUkrWDAwWFl1QjFBclMzSXpXS0RlLzdKM3QxQXp5b0RWNkpV?=
 =?utf-8?B?bTlwbjRLekpIWXhPeFFLQmFZZzlGaG9iSHl3ZlU5MFEzL0oyelhqWkk2alNs?=
 =?utf-8?B?M0JOTHlZMU9SclRMQTBrTnBxRDE4bmhob091VmRrU3Niam93Q3hnSWRvenpD?=
 =?utf-8?B?ZjZWZkdGcncvOHZLK2FDV2lKTFdwLzlWcHpkSWk2Wnd5cUlZdEtnUmZodHND?=
 =?utf-8?B?Y1IzRWdrYThkcnpVb01uVWF3eDI3ZWxFRDFFYmorQ0U2cDZzNFVVU3JlQktT?=
 =?utf-8?B?ajBxd09RTEVUSExTRkJBUzI3VTRESC9rMUdaNlhxb0RxdW1KWmZEbEhrbi9t?=
 =?utf-8?B?eGpxbmpaS3k4TnRvU0JGMk5pRW1pVHJFNXNlUVpkVEpRSUltNU15aHAzK1g2?=
 =?utf-8?B?ZUNkeEdSZE52VHBEejV3T0t2OHRqbGd0RGYvbU9oeFRIR0NvSzNpZXd1REVl?=
 =?utf-8?B?d3B4OEQ0TmtYVlFWTlJ5elJORWdBZnRyZG9aZTkya3BzRHliaTAzNGt3cmtt?=
 =?utf-8?B?emIyOU1VT1Y5VC9DWGNVSWZWQmE0d0djTEZOcE1ybUFzNk5MSEFYQyszOVhY?=
 =?utf-8?B?SVBiaElDN2M4L0hZUWN4UklpaWtCaGlSdXByN2daQW9ia1BxbWFocmJvTUhX?=
 =?utf-8?B?NmNGOXF0OG5OeUZKSSsxUEFFNkJvaWdCZmJEbEIxeVVFZmw1K1JZL1pFazVt?=
 =?utf-8?B?SjdhalRScDhxayszL3RLNXc0TnByNTlMN2NKQlY3ZnhDcjZoUmhPQzZVZ0JR?=
 =?utf-8?B?QXBSL0czaU95bjBwaVVxRU1DMVEwZHgzWWYvbHV2aVlwdlRsK01ia3hyN1VO?=
 =?utf-8?B?R0piNEcrQ2pHT3NRTGttNXh1NHR1Y2NXeUxsblcrUDBhZDlFck5SbjhEcnl2?=
 =?utf-8?B?WGRhN2F5aFl5OGEzQzVSUER1dVpLUm9UL2tFNEN1WXBIZm5CN3NtZHhWVm85?=
 =?utf-8?B?dGhVSUsxLzRqZVh2NC9xNUcwalA4WmFCWDZURjBTbWtSU0JaK1NabWttMEVo?=
 =?utf-8?B?VVMrRXVyZ3BlNDZzWGdaaVRwaDFrUmRub2kzRnA0U01nMEJhbmZDbU5qTC9k?=
 =?utf-8?B?TDdFOU9Kbi9tY1ZYVXNuTlhRZ1JIK3BONnRRelNsSjJtMnlVSHNoUVFicW4y?=
 =?utf-8?B?SVdLOVc4aTRkb2dCbUxDYVBkQjUzRHlneW1pTUI1VlZwZmhlamVCN2FYaWVi?=
 =?utf-8?B?WWlHUS9vN1hTTjFORzFiT0p1MjloWElVZHRJV0oyckNMVjRPQ3pyYVFrRGZH?=
 =?utf-8?B?b0U4RjFncFBBK3VDSzE5NjdXZEczZ1FJcGxDUFZXaG1QckliZkljQVN4NG5C?=
 =?utf-8?B?R0xMR0lnOXBmbHV5RkhnYVJMZ3JMWFZxcVlRTVF4RCs1aHR6b3pLMjhRWENK?=
 =?utf-8?B?KytjMEIrandOd1E5WFUxYVVkZEcxd2U2VmNUbVI2S2Y2eUEvekVBbExpYnhv?=
 =?utf-8?Q?bmWpA0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(10070799003)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUVvNlF4cm95cnJ4WFVEdDdXeFNwVkFNT1hzTldHWU9OdVhaTkgzR01QVHg3?=
 =?utf-8?B?THZnTGF1MWZCS25QVW1UaS9QR0l0MTdoeVAwaWdIR2Z6ZjNDQk5pMTR1Ukk1?=
 =?utf-8?B?dnQzaXJaRFh3WCswTGdBOEZQQXVCdWFEOWtsK2pPdC9Hb2wvS2RRTzlTL0FE?=
 =?utf-8?B?djB5YUZSTldmaVZicXJKYXFiVUFDUlVVMHdzbUtBZWhOcjZrdmlYZGZSeVNn?=
 =?utf-8?B?T1VDblRiN2VYdEpkNVNIRVRTZmo2SDVCRmpGZXV3dmx6c0g5RHFjOG1lUzVG?=
 =?utf-8?B?WDhYcjl0RmRkZW9CVmdyWWVYZnhtOGFpcHNnNWpodnUyWHRMNE44aGpTV0Ra?=
 =?utf-8?B?VTdLWkg3OWhvcVF1RnBmdFhyUGhGU3EzeGZLZmhjeGMrTlBieWdvU1RQUWdX?=
 =?utf-8?B?QUNKaGJyWWg0MUVPL09qMG16eG9oZGVFaUdGT3hiU0theDZrdFBmQWp0S0Ra?=
 =?utf-8?B?aHdXSDA1aWxNbUU2SFRyQjJMVEorV2JtWUUvWStLblJabE9CdWxRRlJUZ2hy?=
 =?utf-8?B?dTEwamRzM2ZsWlVFMUNzb0ZYMnQ2azEyY05GaGlmZ2J0dXpwUHl4Mnk0a3BK?=
 =?utf-8?B?a05QTmdua2lJa0ZHc3YrMW5GaDZ0b0hIVFVYTkxab2ROV0Uxa2Rvbkdhclo3?=
 =?utf-8?B?blJvRHhWM2FzSTlFbTZMd215OG50cnBlb1k5RDZzbFF2TENpMDlmRE9OTVRo?=
 =?utf-8?B?b3YzNW04UDZEYXVJZFVZL0pKb3JnZ0ZNNU9pcndWZFY3V2Q2dTBUWjhxTjRP?=
 =?utf-8?B?WjArRGFISytDcmdXcVJOTGdGUm5UaHdFZ3o4dXpoMWNKM2Q2dEc0cWw0RnVi?=
 =?utf-8?B?L1JxRlova2JPRUFJeFY4bXd2TkVhckd1VTRMcTluaEtUNWQwQXZpajJZVytn?=
 =?utf-8?B?VGxnZStwZThudEtLTWpqV3BucldDMzlPYTVGblRPNFJxODNHbGJKSnF4cjJP?=
 =?utf-8?B?VXR5OTBJdzQwYlg2QjlRWktSY0dITEZtUWpuZWt4Rk5Pb2huMnlVTUJVNThk?=
 =?utf-8?B?cGkwZ0ZFNEJjOE1tTFNBT2UwVUxpelF0K3JoRWhPeDkvZG5EV2I2dElVOTNv?=
 =?utf-8?B?ZStlU045aFVDVDVOQUpFdjBwbmR2K29NKzQreXBoaDFrcjh0K2xPZTQ4MHk4?=
 =?utf-8?B?NmplQzMrUUVzZ0pGV05XazlVZXdvY2Q4dWp1RHc0UlFpWkp3SzBzUTlacG40?=
 =?utf-8?B?R0N4NVBiZzZlWDlrL1dxemN0VmR1Zm1CZEFwbnJBYmljMEl0YXRlY1Y2VFF2?=
 =?utf-8?B?YmJMYjkxbGZvdlFFd0h0d0IydCtKVGFrTnpDWG5rc0NwTzlzWmprendyK2hj?=
 =?utf-8?B?dkFsMW1BVFBiTit4aDAvSEdDSmVQcWNQbEZSNlNMUktTM0x1cGpudVRzanZj?=
 =?utf-8?B?YkRGZGY1U2dPZTFqQUZxVWZJbSs3eXVoeVJad1IyNUpLMW5mVTVzd2h2RHIy?=
 =?utf-8?B?S096bWRDeCtObzVEOWFZNG9UZ0hqM1JNTk9ENDRWQ0d1eWQ1UkZObjYvOFZr?=
 =?utf-8?B?YXB2UVVla0h1YUVaU1A1SVNzVkhhOHJjSTlBNkFoQUtBNnRvakIvUlk3dEFY?=
 =?utf-8?B?RVpyci9uK2FLZWhKM0Y4Rm1tNit6cnhaRzgwTDJBeWlyMUFHcmNoY095WU5Y?=
 =?utf-8?B?M1BGR2xGS3g2OHdOcThLc2Z1Qm1mN2RiczRlaU13YjhWdm5EdS90eDJsMmpY?=
 =?utf-8?B?UlBtcVdNNVpZdVBMT3ZqWnhCTE5VeHhrSmtJbWZhOW1oc1IwL2FKT2FIZ1Nm?=
 =?utf-8?B?a1RlSmpMN2lPSStnRml3bU13R3NxZk5nS0lKdTBtcW5oOUtrRFF5V2N1NDR1?=
 =?utf-8?B?cmp2SWhndUtiZ3IrNDdGendPR05QNVpDVnE4ZGVORlVzVTFka2hFNDFmdWlk?=
 =?utf-8?B?VHBZWUZWb2RIL25uRjczWmp0WEVNcVBZNWhjeEdOZERTTGNvMlZkZ1ZpYyti?=
 =?utf-8?B?MW1UbGloZVRhdmVvZmljSG1raEhHTjVIcnJTRU8xYkdKN3FSVUFpM0l5aSs2?=
 =?utf-8?B?NVJkUWI5aEZ3eGVXTEJucEpCeDFDb0p5cjVXUHpLTzBSblBReVc3Q2wvVW9l?=
 =?utf-8?B?MXp2YzBuVytudEpXUlAvejN6UStjdWd0VjBEZkt3NEJ2NUU0MkdNa21GTVpy?=
 =?utf-8?B?Q3hvT21Gbmg5UkFrbUdFWTFldnZOTlh2Z1Q5VE1Mck93QTE0S3NWR1loeE9k?=
 =?utf-8?B?d3dLa3VkZFhENjdMUVVKZkV4cUVLRTNpSWNoMERuUFlDK3IwS0pxOEk2WDhT?=
 =?utf-8?B?ejR6ZHMyVklPSEtGc2JONU9URFBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EB63ECDC18F054B9E3AEBE85ECDF871@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BbErShhVxLiUL2baI+JCC517maOWiWcc0UV+lE7TjI3Z1KzNMDMGjA1sw6LRWfG4a9RNWfdIjAHFP2q/hV2XUdN7IGXCOJtBdTf5CIbeU58hI5o1hgiQXQH0vVX7u2Nd2SlBm//mWkEB9OcgVuOpW0l4BJ0VQXI/wJtjmvtraqYdttFNSoDH/imn/BmuKOSN/74DfrFogvYtHURuXw0cbMn5esDlhhHZ2jYHejGlyFL3k8MVKSs4NMDmLhklGaelkUUkxijiAuA+rJwhznyo9zdSU/BFyDgKkh8zybb00XUMo4Nz7nQUWGqILLXZNSzsjI2NDeTc7O9HXG+IUHQ1NpFChFb0OZiPbi4RgNTu04XQOoUSQUXCxIKeJZk0brQ5nbLno7Tb79Q7s1iL+eTTU2u7lityN5QCXBoLxarSbu+7uxctPmiKNQfc/VkNtgUZFFFfXnA4gGQUScBUChQKFFypzlKfZEWob07y+iz3bajZ9dPGxJwT5EbTdAf279jVpN1gp7sfw1Gz+Ak7nZj1f+KM/hySS/7CXP1xpBmBYY16LTy4T4xBV/pJmdqJezSfHEfU9arOhViD2EK8rtBOlYMTHjGoxzFT3eN+uNJKBe6TWUize9eLnG7l7ogsDGEq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490cddcd-6ba8-4e79-d12a-08de0fac4b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 07:43:00.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8FYp82LP/B/ZaxXMMob9SCR0ucwkx5hVHUMZRXLFQimobwlrsFcfLXjqfFZ0N3UyD+q5ctUebTbfLwWxllFKaYlo2x+2E211kphW4IqEs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8489

T24gMTAvMjAvMjUgOToyMiBBTSwgaGNoQGluZnJhZGVhZC5vcmcgd3JvdGU6DQo+IE9uIE1vbiwg
T2N0IDIwLCAyMDI1IGF0IDA2OjU1OjQ2QU0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90
ZToNCj4+IE9uIDEwLzIwLzI1IDg6NTMgQU0sIGhjaEBpbmZyYWRlYWQub3JnIHdyb3RlOg0KPj4+
IE9uIE1vbiwgT2N0IDIwLCAyMDI1IGF0IDA2OjUyOjA0QU0gKzAwMDAsIEpvaGFubmVzIFRodW1z
aGlybiB3cm90ZToNCj4+Pj4gT0ssIG1heWJlIEkgdGVzdGVkIHdyb25nLiBEb2VzIGl0IGFsc28g
aGFuZyBpZiB5b3Ugb25seSBydW4gemJkLzAwOSBvcg0KPj4+PiBkbyB5b3UgbmVlZCB0byBydW4g
dGhlIG90aGVyIHpiZCB0ZXN0cyBiZWZvcmU/DQo+Pj4gSnVzdCBydW5uaW5nIHpiZC8wMDkgaXMg
ZmluZS4NCj4+Pg0KPj4+IEFsc28gbWFrZSBzdXJlIHRvIHRyeSB0byB1c2UgbXkga3ZtIHNjcmlw
dCBhcy1pcyBhcyBpdCBnZXRzLCBnaXZlbg0KPj4+IHRoZSBiaXNlY3RlZCBjb21taXQgSSBtaWdo
dCBiZSBzZW5zaXRpdmUgdG8gdGhlIG9wZW4gem9uZSBsaW1pdHMgb3INCj4+PiB6b25lIGFwcGVu
ZCBzaXplIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+PiBZZWFoIHRoZSBpc3N1ZSBvbiBteSBz
aWRlIGNvdWxkIGJlIHRoYXQgSSBkb24ndCBoYXZlIHZpcnRpby1ibGsgZGV2aWNlcw0KPj4gYXR0
YWNoZWQgdG8gdGhlIFZNIGFzIEkgZG9uJ3QgaGF2ZSBkZWJpYW4gaW1hZ2VzIGx5aW5nIGFyb3Vk
biBmb3IgdGhlDQo+PiByb290ZnMgKEknbSB1c2luZyBteSBob3N0cycgcm9vdCBhcyBhIFJPIHZp
cnRpb2ZzIG1vdW50KS4NCj4gQWN0dWFsbHksIHRoZSB6YmQgdGVzdHMgZW11bGF0ZSB0aGUgem9u
ZWQgZGV2aWNlcyBvbiB0b3Agb2YgdGhlIHJlZ3VsYXINCj4gb25lcywgc28gaXQgc2hvdWxkIG5v
dCBtYXR0ZXIuICBIZXJlIGlzIG15IGJsa3Rlc3RzIGNvbmZpZywgYnR3Og0KeWVzDQo+IFRFU1Rf
REVWUz0oL2Rldi92ZGIpDQo+IG52bWVfdHJ0eXBlPWxvb3ANCj4NCj4gc28gbm90aGluZyBzcGVj
aWFsLg0KPg0KYW5kIHllcy4NCg0KDQpDYW4geW91IGdlbmVyYXRlIG1lIGEgdm1jb3JlIGFuZCBz
ZW5kIG1lIHRoZSB2bWxpbnV4ICh3aXRoIGRlYnVnIGluZm8pIA0KYW5kIGNvcmU/IE1heWJlIEkg
Y2FuIGZpbmQgb3V0IHdoYXQncyBnb2luZyBvbiB0aGF0IHdheS4NCg0K

