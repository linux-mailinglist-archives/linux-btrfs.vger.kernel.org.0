Return-Path: <linux-btrfs+bounces-5010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B308B8C6A58
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683D92815D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E53156255;
	Wed, 15 May 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TB/mAl2w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tYVGhKSc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332A13EFE5
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789682; cv=fail; b=J3af9HFxaFqPfi0e8Fva1fRqoXyyzg2I/p/vUDINnG7+nNEjqtlIRUUJ2VNtCc2J5/m0ZCrnzKkbpVSiT5SsQAkvwa5vEu1+Sbf4ZhiEUpC47xZXaNuJIlKCnBwYbnBlF20xuZJrF4nMDEGUe4rIDX8LZ0FfNDlZ1+7++/IyAOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789682; c=relaxed/simple;
	bh=wez602oZ5ewKIBB4v86o7iLUTbjOHp1/Q0Si1bIfac8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mki8F0zHdFqE2qwTnyJMJwf8Jn1RzFpsvXEGnLMgC6tvUFSZQg0uF5d81j5XaZdMQ9iNtc/Iz6TWBuNkZ4hHLVBOM9C7Ot7QK1yVdIswmGoFt0QjNvCGeKFG+NzL5+dW0OMOAOjp1t4WXEXvGuxCpsVq8PfED+oYbhsbiWbiQGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TB/mAl2w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tYVGhKSc; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715789680; x=1747325680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wez602oZ5ewKIBB4v86o7iLUTbjOHp1/Q0Si1bIfac8=;
  b=TB/mAl2wYn7yVXZj++dwzKYLBBG1Bvgs+llyP4BMDOVxnEJB1DF45dEl
   0qr3H9rcYcg/u6Up3y3Em3aPKuNGYCkhU/NPrQ87l0FoHAXfSZNxkvqip
   Nxq+2zPF7/r+/jtqVcahWbs0srFajVmMwOkjgPyhQf6QjNxqm/kiOzCxj
   Xn47Lor53GRlXLj74qsyqQp3zm0yufsH/1yNKxln0vqSFylIljC1JhkXO
   lmBLLGca8xtjIVTkrbnVvkn+EehqzHFdz4WnWg5jV9cbQwrqFUYbhbndC
   vPybZ1bsnNYxtnJJs0P0XKXWvojkeq6B5kIoRj+0cskzyh78SgQ+wAbGZ
   A==;
X-CSE-ConnectionGUID: G/zaMUVhRaaxOr7DritzWA==
X-CSE-MsgGUID: J5unJJ5tQHGngNSAqmXGNg==
X-IronPort-AV: E=Sophos;i="6.08,162,1712592000"; 
   d="scan'208";a="15743093"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2024 00:14:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+tlx3lVOFU7ogLs7iGHRutyqk4bH4yTwK76WmKPNiXLFIfz6OUE9iKgxpnR3Es/DGUXhSg96p7pohiQJSNlHv2e9nZWTxbNt5tQvIreC3HGf/G0lMqRFi3Iw6xYUFloKxa0Ss9gwQqRXRG7JKDjc1Ci+UR50iwlFqzPIEtyUl/o6rdsFAmCsLBEGp1ooLj/tCoRVvu2ofUbqVF4Z1KAnrLmJ5jMNqrjiHUWomwDDlXe5a361a9xIWnWBWK3mfkjcandz8xoX/CDjjr4RHR35WLKnGHAI/IB07Agj43HZHPFbML/+YTbNND2bRkMDL7h58kdTNyMCGjqtoBHEabvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wez602oZ5ewKIBB4v86o7iLUTbjOHp1/Q0Si1bIfac8=;
 b=ZGgZDurFdbkl2LhKJlKG4h0svNhFQNDTk+Gjvdw7uOcr5ildooGPqGi4VeWPLhJeLc6wkucBgFPgyw6eKXbUNEi6SGgcn4GQ1SBh9MzViNyAlZR3pwRuS4ZO9UV+4ZJ185ek33NN/NcnXuiBVtFK7WnToNQfP4mYdFAdl2VbtBHe29D9pAC9V9RpnKUVemhCJ2z5Q7OnykGeN01B9Al7gBybQlSMHMEpvx/jGXpFE69Ktr16Iy3Pm0ZHfhBrUaB/8Li81TLxyE7rAy6eQRVkVyHyUZIIuhyyJBDwXMVnJCbco+7k2oJd9zmH1Hapf8QZ++o31xoOMpk3ybE5PAeF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wez602oZ5ewKIBB4v86o7iLUTbjOHp1/Q0Si1bIfac8=;
 b=tYVGhKScF6aBcGuMs8YzX8vAOWZdpoWzteLFaq9wyZGXaBRwTmB9Io5xGJLvHlpyQ59Uc+ZDT1XRa8AS9IzK/1bzuoFXDLjvd/w8S8z8cSeJxTEG23lO4f09RVzotuzbrl53z9lupFcI52AYhNesCe6wnQZYs5hV+MfJXhE9kfs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6282.namprd04.prod.outlook.com (2603:10b6:5:1ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 16:14:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 16:14:35 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] btrfs-progs: add test for zone resetting
Thread-Topic: [PATCH v2 7/8] btrfs-progs: add test for zone resetting
Thread-Index: AQHapiwGwLvg/7sVEUus6kWk8A51lbGXWe+AgAEfpwA=
Date: Wed, 15 May 2024 16:14:35 +0000
Message-ID: <a57phbwxa33dykmy6nqdhudue2onuvr74c7dulzqygu5zaabo7@ovegvvpcm5eo>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-8-naohiro.aota@wdc.com>
 <65db4776-b74f-48f0-ab7f-b33f56e1c00c@gmx.com>
In-Reply-To: <65db4776-b74f-48f0-ab7f-b33f56e1c00c@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6282:EE_
x-ms-office365-filtering-correlation-id: 27e47544-ca52-4753-f657-08dc74fa1d18
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUtiVmdvT2FCM2h3b3FaN2NNOEMxanY3bXA3MTVGa2w2U2kyS3A1OC9HK3JW?=
 =?utf-8?B?RjNBMjBKeVNtTFVMV1I2cWl2aVQ3VUpNYkxsbVdyOXVhQm5GYnJuUXpFZFJB?=
 =?utf-8?B?UUcxR1BZS2FzZG9sVGQ5NEdJNGxWU3Iwd0RLMWcrd0xkaVdBb2tPYVM3UHNY?=
 =?utf-8?B?OE9LUkRJdkpQVVRZMGJKK01KdHVUM3hwWUZYRlhlS0QxK0Z0K0RKR0UvUWdZ?=
 =?utf-8?B?NzliK1BjL1NHTTF3STVwbjlaY0s4VGlCd3B6SEl0NnJvaUhvbXdxZTdWYWxm?=
 =?utf-8?B?NWhiQ0lYck5HTWFYcDhoUTNkclJobVhoTFcyL3JYMzVaSWlQaVA3c3BlNm5Y?=
 =?utf-8?B?Nlc1cmVsS1lvUGEzZzNZMzEzTFY2aXZ3RkhBTWZmUTBrNWIzUXZpSzVlRU4w?=
 =?utf-8?B?WTgwK1RlNUxCbmJ6UlZ5Mlc3RUZ4VVMwQmZrb3ZVTGQvUUdkOTVLMjU4NWxa?=
 =?utf-8?B?V05RZC9NL0xGa2RCU1BVcHZTWTlIc2tUa2w0OGNpWlRrNklBT0tEdGZwdkVu?=
 =?utf-8?B?LzV2SStrTTdwMUx6VDJPTVpIY3BXMzY4NUh3V3BqWTFYbUlmMktuaTFMeGd2?=
 =?utf-8?B?WEVXYVBmWVhwOW9vN2M1TWdqdkxHYVEzRUcwVWRxZ2k1bjIzdWloM0xwYVQ1?=
 =?utf-8?B?Q0szdTFrT2RDcHhVeU9wRy9TcGp5Y3E0eU9wVUM4dWZHN1pHeGNFMzhFeUxt?=
 =?utf-8?B?VlN1UVAvOXJNVVJLTDNhbCtzVVdtRjY5ckNIUXlXdHFVMWxUK240SzBtN2sw?=
 =?utf-8?B?TVQwNVd5UWdjZVdEWlRsVWpSQXZvZ1hjS0lqYVZDS1dhS1Rjd2N2eHpiS3du?=
 =?utf-8?B?UG5lRjJMN2RYR05mQXNXME1XazJXbXdDQzBiOWxNWEVQVU9PQks0REtvVzdN?=
 =?utf-8?B?YkdlODhNaCsrVzBXVDBieE12bVUvMTBHY0d5ZWNEaU5GWVhhb0JSY2xGb3VC?=
 =?utf-8?B?bUIwRVh0Wk42MGNEbEZvaFM2Zm1QODIyS0ZxQUpMdzVOSyttSXM2SUJiakhI?=
 =?utf-8?B?dFhBdUxyY2FPYWdpSkV0NWx3NlNzWEIxb3Via0RpOEhEbUZ3bmxaelFONmgr?=
 =?utf-8?B?ZVlwZUxydmJVRkdodG8rTVNjZUswMG1JeFhFZXZxK3NIRG96TjhGdjV3RVFE?=
 =?utf-8?B?c3FaaWxQdWRjZVIzb1d0TFZ5d2RiYTVxR3YwQWhvME5BYWE5aXBWT2syYzFW?=
 =?utf-8?B?R1AwdllUK0NQb2hWY3VtaEVXK3dQMldzYU5qZTdLbGJoYlY1M1NHR2t0T0ly?=
 =?utf-8?B?eGNTV2NIVXB0cHhkL2poRzR3R0kwNy9Ec2k3K3NCMjZXU1RZVlRWVHF6UEF0?=
 =?utf-8?B?WmtRUVUybVdGNHIwY2pQWlV1ZTdDTFBIc1BUT0tKbGRWN2tCT0g2MHRDNEkr?=
 =?utf-8?B?eFVVeXdzZm5tSitadDNST1pXSHYxYi9lV0pwcHQyeTd1YjhhWjh3cENmbHR5?=
 =?utf-8?B?bkg3Ync3MWlBYzhUckgvdm1tZE8wdS9CU202T1FKcDRuU3ZQaXZDbGFJcmpu?=
 =?utf-8?B?Q29PVEtYamlpc1BqaFR0bkVuaGpPU05HMGdCWmJBYkV0WC8xcVRmdmxOejRl?=
 =?utf-8?B?aHVUWWxCVDJiS3JrQk14UWlKRVNucFNGVDBoTXVob25RWEN5cmhNcHBFL21x?=
 =?utf-8?B?NlA3cGlhbVZ0bGVVMlJTNUV2M2xFTU1yalRQMUF5Ky85WWt5cEVDSkp5azhW?=
 =?utf-8?B?dFVmUFBkRmtwbXkxWDRZVkxtUFVyNVJJdDhpWllzK1lQMnJXMndrOVZZaWRK?=
 =?utf-8?B?QmgvU1VNV0tiU1ZMaFhZWnF1bXJDWFAvbllSTHVpNklRZXZkOW10SXJTMUlJ?=
 =?utf-8?B?QnJhaTh1N0pjVW10NW9EUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWRrYlNmWnNneWVRcTdlM1llREhPZEZIREFOR0pQdUs3bTdjNzNvZm15V2dG?=
 =?utf-8?B?cTlWa2RIZ1B3c1BLNkwybVNkYzlKYnc5ODlJTXVkZDhWTkRBanJVWm1aV3ly?=
 =?utf-8?B?a1hmcEYvS3FSaUZiekwwRXdFd0IzZm15VG9DZ1MxTlBNTjBnUG1Zb0ZPWUZp?=
 =?utf-8?B?YzNqUjE2VlFPRi9LSFdPSUEwWndkbGxXdkY3bjhvbnVjVEVCaTl3RENRSEJt?=
 =?utf-8?B?b0gzZG5wTUdJZDhvbUJxdzN3ZWxOYUJYSlowamlUdnZIN3JtcDJOaEYwdEtT?=
 =?utf-8?B?Yk9FRkxxc0lLZ09uWThOZGF1dWdYV2pPSHdUWDBWc1IxSUFIZTN1SVROMm1D?=
 =?utf-8?B?SXVraWFIb0tQKzNQemZabEdsaTZIRXRsUXRMVC83MTNaUHBLdnpQNlBUK2ZC?=
 =?utf-8?B?dGwyREtKNmlQNEpVS0VYbjZjdTV6MkFlNTVsNjE1b2V6bjczdTB5bWloY0VS?=
 =?utf-8?B?clRmUjAxa2pid1FOUFF3UFFzUGl1U0pwY1VyV05aZW8wZ0t4ajVHNFFyRDBa?=
 =?utf-8?B?MUloaktEeG1MTmFMbUxqTUtmZkZENmY4VU50eitqRnNGOENhUW5JY2x4VnRG?=
 =?utf-8?B?UnZUZ3QrdVZjVDU2OUV2RUdUVVBhbkdNSElwMldubGpqc1I2bmhRZW4waElC?=
 =?utf-8?B?L3dCTnFOQWpCMmdtYTNOZXVIMm96ZGc2bE5xM0J2Y09qNVRPUDh3emVqL3Ir?=
 =?utf-8?B?RVIxQUh0eUZWdkdFL2N5OG1KTGlWVUdNOHBXTVhjR2hqcHJiaitUVHBZMVQx?=
 =?utf-8?B?WVFvbDRXN1BSRGtGWmRVWlI3bWVDR3Q1UWk5dzFmTFJXRi95bFFNdVFLVEJP?=
 =?utf-8?B?V0tzZ1NzRTJyQ1hLaTVzaE9XMy9PZStYZmJVOTRPc29STm9BcFhNTjY1bFlh?=
 =?utf-8?B?REVqNUFLWkx3NjZVY2ZQWHIzbHVNMUhMR0tYMjVkbFNUWGxIM3dVRmErYm9R?=
 =?utf-8?B?WDNnRkhSYnZlREs3aml2RE5IaUpmUmswaXRFQU1HNUJOQmJ6eTUwR1lUd21F?=
 =?utf-8?B?dlg1bU4rTjJ0dDFQRHlzQlBpRXZFTmQ4NGhCcHh0bEN6d252a0dQb2pGb1l1?=
 =?utf-8?B?WXduM2xuckoyQmp0c29oOGZXdG5ja01US0hZY2FkQTlWU0htTFU4d25WK3p6?=
 =?utf-8?B?RkJJT3dQL25Tb1liL2JJNXhMUzB3bjFXNml6RkpaUWFFK05UZFhhUi94SVU4?=
 =?utf-8?B?WllZTUluYTFLd2MrRjR1T2pSTFNER094ZjBSMFpnVXI3VTdEeEVweFRuZXow?=
 =?utf-8?B?NGxOZWt3Y3IzMmJtOU5iV2hLQlNaZnVQM0tOZEhacTk0b3Q5QU5BQ0NTZnVX?=
 =?utf-8?B?d2pKT1BKb3hxUi9tcnM4dDhaSjdIUHVzR29tQXMxSFIzeU4xMTVEbHZqbnJw?=
 =?utf-8?B?U01oKy8zQmlCUjA0dUVBU0hObytEZ3F1dW5zb3lLWEFxQkhIQSs1bSs0VjFw?=
 =?utf-8?B?NnJ3cGoyTy9CeDZEZElGS2dPeXZ1UlVLcDNyb0s0OVN2SVUycU5jZkJYbnFW?=
 =?utf-8?B?VjdWZCtMeEhwZTZ5bEx5MFpXR2llbHh5cjluelgyL2dmMmM5N2ZwNnRYRzdW?=
 =?utf-8?B?bEMwR1hTS2JpbHllNGlNWlpwaURxZHdIbnk3SzFJKytLUVdBM212STY0Z1Rs?=
 =?utf-8?B?VWtmZEV5ZnMyaU9CWmU2QVVHM0o4b2NHOUk3R3BHNndRNmVyT0trcHFhUG9h?=
 =?utf-8?B?U0pnN0hzcFBPYW0raHpWbnBkY3dYVGY4U0xzbG90WWhLbmtzSk5JQWZMemV1?=
 =?utf-8?B?TkFGd3N1Y2JSd216NEhqcjdQQzRwaE05VVRFa1JISWprYVk1blQ1c3M0YjZk?=
 =?utf-8?B?dFRVVFIySURpdzNESzU3bHFZN09KWUE2ZEdsd1EySkRhVERzdlAraEY1NElp?=
 =?utf-8?B?S1RBWFVPb0x4ZkhiZm02R1l6Mk44cFlPUnRGSG5KaDdwbndBVkF5b1psbVpW?=
 =?utf-8?B?Yno2Vjg2bERCSlJRNzB6a0YwaHRGdzF4NHZINStGWWtmeGEzNWk5RHRXVlJk?=
 =?utf-8?B?RlZvbXExRUZ1bWpwZVRDWFVHd2x2cGFKY1E3NFhjVEFlTHdnQVNrT0dtMUFB?=
 =?utf-8?B?UzQwOU1VR3Rod09qSStqMiszZ1F0dXFtSjdnK2tuN0V0L28wUlVDUzVBMlRz?=
 =?utf-8?Q?zgazBm/qdMjS+T91Ol1InKalP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <612FAD2725671349BB3A266E7A8A88AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lb+pTFL55GGf1oYl5tbOsWF0jt0BFgMm/d2PIPivdnnd3f1bImYukVEhYt7wYsrCzZ3+aMvaU5CdZB8mHYg+QQFn7TvYwsSHzb18xh49ZPJPvZKBI6uKf3Ogp5XJB+Gm01Lwj7m6DL01i1Q7obE9AKygUS8KyCyp6I1Zp98GxVRnsiAKhpzafx2foUl/vcWobUXaGPK0vJrnIPGmXf6/OCI0aO4esuq/PiljcXEHWcvGeTQKadz1zH2fqE9pgQpKIMmcHyoisUI4TmE/7QgOvsrGFOamN1vNuo8lipCtf8+H7MSonwyGpRfDiQiVXS91j9TO6vuidAvc0Y9fjZ1df+AqNMSpTvN488Fh82j+xLnd8gM7IRcyysWqC8nsfhL7nEbx+pKQsqu2526HTMBy14duQZxALzRvyQGfXveBCs1gtQt8hQkAXf2HVpg00mU5ihYzvQrH0nMVYoMNY8nEO4tWOdUk5HHV0YWoKIgwm+rCLJWnBD+ng3LZWcXt+/QudBox9WTWfkuN1k741IvTjCpnd/FgGBsu8a3eJN0agBBqi7jv9Uy07L7wW9aLXzGelDPs7gC5QJ3krHSKSiHVPYC3l/R4GmqYiLNBwN+GPso/XsGo4kb1Bb8VPVPDMO3n
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e47544-ca52-4753-f657-08dc74fa1d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 16:14:35.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptqo2zuP31zCc0LhznEgo6hWv/Eo+O6Cu9EOmrxNQM9PW9gt1DZ+xtyvUAv8yT/sVuzLaQSHAhQKjJo5nezjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6282

T24gV2VkLCBNYXkgMTUsIDIwMjQgYXQgMDg6MzQ6NTdBTSArMDkzMCwgUXUgV2VucnVvIHdyb3Rl
Og0KPiANCj4gDQo+IOWcqCAyMDI0LzUvMTUgMDM6NTIsIE5hb2hpcm8gQW90YSDlhpnpgZM6DQo+
ID4gQWRkIHRlc3QgZm9yIG1rZnMuYnRyZnMncyB6b25lIHJlc2V0IGJlaGF2aW9yIHRvIGNoZWNr
IGlmDQo+ID4gDQo+ID4gLSBpdCByZXNldHMgYWxsIHRoZSB6b25lcyB3aXRob3V0ICItYiIgb3B0
aW9uDQo+ID4gLSBpdCBkZXRlY3RzIGFuIGFjdGl2ZSB6b25lIG91dHNpZGUgb2YgdGhlIEZTIHJh
bmdlDQo+ID4gLSBpdCBkbyBub3QgcmVzZXQgYSB6b25lIG91dHNpZGUgb2YgdGhlIHJhbmdlDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIHRlc3RzL21rZnMtdGVzdHMvMDMyLXpvbmVkLXJlc2V0L3Rlc3Qu
c2ggfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2
MiBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvbWtmcy10ZXN0
cy8wMzItem9uZWQtcmVzZXQvdGVzdC5zaA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9t
a2ZzLXRlc3RzLzAzMi16b25lZC1yZXNldC90ZXN0LnNoIGIvdGVzdHMvbWtmcy10ZXN0cy8wMzIt
em9uZWQtcmVzZXQvdGVzdC5zaA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwLi42YTU5OWRkMjg3NGYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
dGVzdHMvbWtmcy10ZXN0cy8wMzItem9uZWQtcmVzZXQvdGVzdC5zaA0KPiA+IEBAIC0wLDAgKzEs
NjIgQEANCj4gPiArIyEvYmluL2Jhc2gNCj4gPiArIyBWZXJpZnkgbWtmcyBmb3Igem9uZWQgZGV2
aWNlcyBzdXBwb3J0IGJsb2NrLWdyb3VwLXRyZWUgZmVhdHVyZQ0KPiA+ICsNCj4gPiArc291cmNl
ICIkVEVTVF9UT1AvY29tbW9uIiB8fCBleGl0DQo+ID4gKw0KPiA+ICtzZXR1cF9yb290X2hlbHBl
cg0KPiA+ICtwcmVwYXJlX3Rlc3RfZGV2DQo+ID4gKw0KPiA+ICtudWxsYj0iJFRFU1RfVE9QL251
bGxiIg0KPiA+ICsjIENyZWF0ZSBvbmUgMTI4TSBkZXZpY2Ugd2l0aCA0TSB6b25lcywgMzIgb2Yg
dGhlbQ0KPiA+ICtzaXplPTEyOA0KPiA+ICt6b25lPTQNCj4gPiArDQo+ID4gK3J1bl9tYXlmYWls
ICRTVURPX0hFTFBFUiAiJG51bGxiIiBzZXR1cA0KPiA+ICtpZiBbICQ/ICE9IDAgXTsgdGhlbg0K
PiA+ICsJX25vdF9ydW4gImNhbm5vdCBzZXR1cCBudWxsYiBlbnZpcm9ubWVudCBmb3Igem9uZWQg
ZGV2aWNlcyINCj4gPiArZmkNCj4gPiArDQo+ID4gKyMgUmVjb3JkIGFueSBvdGhlciBwcmUtZXhp
c3RpbmcgZGV2aWNlcyBpbiBjYXNlIGNyZWF0aW9uIGZhaWxzDQo+ID4gK3J1bl9jaGVjayAkU1VE
T19IRUxQRVIgIiRudWxsYiIgbHMNCj4gPiArDQo+ID4gKyMgTGFzdCBsaW5lIGhhcyB0aGUgbmFt
ZSBvZiB0aGUgZGV2aWNlIG5vZGUgcGF0aA0KPiA+ICtvdXQ9JChydW5fY2hlY2tfc3Rkb3V0ICRT
VURPX0hFTFBFUiAiJG51bGxiIiBjcmVhdGUgLXMgIiRzaXplIiAteiAiJHpvbmUiKQ0KPiA+ICtp
ZiBbICQ/ICE9IDAgXTsgdGhlbg0KPiA+ICsJX2ZhaWwgImNhbm5vdCBjcmVhdGUgbnVsbGIgem9u
ZWQgZGV2aWNlICRpIg0KPiA+ICtmaQ0KPiA+ICtkZXY9JChlY2hvICIkb3V0IiB8IHRhaWwgLW4g
MSkNCj4gPiArbmFtZT0kKGJhc2VuYW1lICIke2Rldn0iKQ0KPiANCj4gQ2FuIHdlIHdyYXAgYWxs
IHRoZSB6b25lZCBkZXZpY2VzIHNldHVwIGluIGEgY29tbW9uIGZ1bmN0aW9uPw0KPiANCj4gSSBi
ZWxpZXZlIHpvbmVkIHRlc3RzIHdvdWxkIG9ubHkgaW5jcmVhc2UgaW4gdGhlIGZ1dHVyZS4NCg0K
U291bmRzIGdvb2QuIFRoZW4sIHdlIGNhbiBtaWdyYXRlIDAzMC16b25lZC1yc3QgdG8gdXNlIGl0
IHRvbyBhcyB0aGVyZSBpcw0Kbm8gcmVhc29uIHVzaW5nIGEgbG9vcCBkZXZpY2UgdGhlcmUuDQoN
Cj4gDQo+ID4gKw0KPiA+ICtydW5fY2hlY2sgJFNVRE9fSEVMUEVSICIkbnVsbGIiIGxzDQo+ID4g
Kw0KPiA+ICtURVNUX0RFVj0iJHtkZXZ9Ig0KPiA+ICtsYXN0X3pvbmVfc2VjdG9yPSQoKCA0ICog
MzEgKiAxMDI0ICogMTAyNCAvIDUxMiApKQ0KPiA+ICsjIFdyaXRlIHNvbWUgZGF0YSB0byB0aGUg
bGFzdCB6b25lDQo+ID4gK3J1bl9jaGVjayAkU1VET19IRUxQRVIgZGQgaWY9L2Rldi91cmFuZG9t
IG9mPSIke2Rldn0iIGJzPTFNIGNvdW50PTQgc2Vlaz0kKCggNCAqIDMxICkpDQo+ID4gKyMgVXNl
IHNpbmdsZSBhcyBpdCdzIHN1cHBvcnRlZCBvbiBtb3JlIGtlcm5lbHMNCj4gPiArcnVuX2NoZWNr
ICRTVURPX0hFTFBFUiAiJFRPUC9ta2ZzLmJ0cmZzIiAtZiAtbSBzaW5nbGUgLWQgc2luZ2xlICIk
e2Rldn0iDQo+ID4gKyMgQ2hlY2sgaWYgdGhlIGxhdCB6b25lIGlzIGVtcHR5DQo+ID4gKyRTVURP
X0hFTFBFUiBibGt6b25lIHJlcG9ydCAtbyAke2xhc3Rfem9uZV9zZWN0b3J9IC1jIDEgIiR7ZGV2
fSIgfCBncmVwIC1GcSAnKGVtKScNCj4gDQo+IFlvdSBtYXkgd2FudCB0byB1c2UgYHJ1bl9jaGVj
a19zdGRvdXRgLCBhcyB0aGF0IHdvdWxkIGR1bXAgdGhlIGNvbW1hbmQNCj4gYW5kIGl0cyBvdXRw
dXQgaW50byB0aGUgbG9nIGZvciBlYXNpZXIgZGVidWcuDQo+IA0KPiBBbmQgc2luY2UgdGhlIHRl
c3QgaXMgcmVseWluZyBvbiBleHRlcm5hbCBwcm9ncmFtIGBibGt6b25lYCB5b3UgbWF5IHdhbnQN
Cj4gdG8gcHV0IGFsbCB0aG9zZSByZXF1aXJlbWVudCBpbnRvIGEgem9uZWQgc3BlY2lmaWMgaGVs
cGVyIGxpa2UNCj4gYGNoZWNrX3pvbmVkX3ByZXFyZXEoKWAuDQoNCldpbGwgZG8uIFRoYW5rIHlv
dS4NCg0KPiBUaGFua3MsDQo+IFF1DQo+IA0KPiA+ICtpZiBbICQ/ICE9IDAgXTsgdGhlbg0KPiA+
ICsJX2ZhaWwgImxhc3Qgem9uZSBpcyBub3QgZW1wdHkiDQo+ID4gK2ZpDQo+ID4gKw0KPiA+ICsj
IFdyaXRlIHNvbWUgZGF0YSB0byB0aGUgbGFzdCB6b25lDQo+ID4gK3J1bl9jaGVjayAkU1VET19I
RUxQRVIgZGQgaWY9L2Rldi91cmFuZG9tIG9mPSIke2Rldn0iIGJzPTFNIGNvdW50PTEgc2Vlaz0k
KCggNCAqIDMxICkpDQo+ID4gKyMgQ3JlYXRlIGEgRlMgZXhjbHVkaW5nIHRoZSBsYXN0IHpvbmUN
Cj4gPiArcnVuX21heWZhaWwgJFNVRE9fSEVMUEVSICIkVE9QL21rZnMuYnRyZnMiIC1mIC1iICQo
KCA0ICogMzEgKSlNIC1tIHNpbmdsZSAtZCBzaW5nbGUgIiR7ZGV2fSINCj4gPiAraWYgWyAkPyA9
PSAwIF07IHRoZW4NCj4gPiArCV9mYWlsICJta2ZzLmJ0cmZzIHNob3VsZCBkZXRlY3QgYWN0aXZl
IHpvbmUgb3V0c2lkZSBvZiBGUyByYW5nZSINCj4gPiArZmkNCj4gPiArDQo+ID4gKyMgRmlsbCB0
aGUgbGFzdCB6b25lIHRvIGZpbmlzaCBpdA0KPiA+ICtydW5fY2hlY2sgJFNVRE9fSEVMUEVSIGRk
IGlmPS9kZXYvdXJhbmRvbSBvZj0iJHtkZXZ9IiBicz0xTSBjb3VudD0zIHNlZWs9JCgoIDQgKiAz
MSArIDEgKSkNCj4gPiArIyBDcmVhdGUgYSBGUyBleGNsdWRpbmcgdGhlIGxhc3Qgem9uZQ0KPiA+
ICtydW5fbWF5ZmFpbCAkU1VET19IRUxQRVIgIiRUT1AvbWtmcy5idHJmcyIgLWYgLWIgJCgoIDQg
KiAzMSApKU0gLW0gc2luZ2xlIC1kIHNpbmdsZSAiJHtkZXZ9Ig0KPiA+ICsjIENoZWNrIGlmIHRo
ZSBsYXQgem9uZSBpcyBub3QgZW1wdHkNCj4gPiArJFNVRE9fSEVMUEVSIGJsa3pvbmUgcmVwb3J0
IC1vICR7bGFzdF96b25lX3NlY3Rvcn0gLWMgMSAiJHtkZXZ9IiB8IGdyZXAgLUZxICcoZW0pJw0K
PiA+ICtpZiBbICQ/ID09IDAgXTsgdGhlbg0KPiA+ICsJX2ZhaWwgImxhc3Qgem9uZSBpcyBlbXB0
eSINCj4gPiArZmkNCj4gPiArDQo+ID4gK3J1bl9jaGVjayAkU1VET19IRUxQRVIgIiRudWxsYiIg
cm0gIiR7bmFtZX0i

