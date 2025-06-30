Return-Path: <linux-btrfs+bounces-15094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F1AEDB88
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 13:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D303AA56D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49920261378;
	Mon, 30 Jun 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ULmAuBzv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mNCicghY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA742C0B
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284009; cv=fail; b=EzJzj80NyO1YMLIY1UTDvf+p3fLe9/K8laS0RCl/uOYTC9uxuz0WNlhISv4Zc+nZRr6SaJBv+Vij3EvaANb2p9VplT71U/jWGGgCWIFYdapwAXOkEBmFOxAbNSTWvBA8Mc/rmMhZ3Ksqj3p2ZvAA4rAWgCrWccGrxVx+N6Sznsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284009; c=relaxed/simple;
	bh=Mrs08zAJYcsZ76UNrjsQjms4cI2cL/d+ztafcElKqMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BurbFYNJI+JPAXKLAIcIzZpKGQ7CluoKG9cSZ+Rwf9qIOeTitDPrV41d7QCCZlJiLat3M6Ptxf1D7tI0wqdEs6eYLi5xZGF3d8jnriIZHbul59IkMpWHQGoaOciKArLJ+eA5KUi/LeVt4xyoOi/SRnMTv5nR2TkzBvJkYBnLbZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ULmAuBzv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mNCicghY; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751284006; x=1782820006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mrs08zAJYcsZ76UNrjsQjms4cI2cL/d+ztafcElKqMM=;
  b=ULmAuBzvLrAIRQgqpVpFRtD/gQWxck+vlrwkIUTwiY1fIdJOEpsig2ra
   vImEwtBgvyf7mVqutoDsURZtstDsUmvE0fuQ4g2LU4OCV3lh3ygo/h46z
   atShCStmASPeWxdCRz21+g+6mhpuRjvgjmSxYwF5iGGOKcAyqnnRbFpZa
   J6BroS6eC4urKmiKgT9y/qfyZoiSWPgfQxUBXNvYedTQtLVLUsy8vwtrU
   36A2HM13fXQNRMg+U2X3S9st6NjCvwzSCXrIOIXdfIzfPNHwFDBnC4fRF
   JWLjd1OWokUqbOwscmIZg5xDToG9oLzxleI5Hb+lMTMraB7T8LFfhoqdd
   Q==;
X-CSE-ConnectionGUID: diD6yPCER5ugEtMX7KjgIQ==
X-CSE-MsgGUID: untzzKN+TuGCgz8epxyI7g==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="91536140"
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.57])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 19:45:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddK9HC4ksTipdRtFxCLRXVh8XEtaxegMy/fmoVCN/ttVj046AC4lRyl1R/Oc1iUvDOmkjEkKc+57YzSZWY8pLIhevy/bbRdChXqQW2Tcawrmq8TmvMj3ZPfd0Z2qu90NfzXmL6dAnmNBETag9TbA1Ohec3W17sdZWHlNkTdpA5PvFXfPNE7PjWtlYBNjsoyjJ04DmTLKcJX6UsPOyMbK5+0jQ0WO6o99WiOtlZYNWsRc3CjIpwMVaeTUNh1iDk0xdaomOFZQGfngahwPUtTzbshkFNL6vYPoRSpWkad8Up2OXDyWbCKVnZoH5yE/FjKIraVAeRUO/afxz5ATSGiXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mrs08zAJYcsZ76UNrjsQjms4cI2cL/d+ztafcElKqMM=;
 b=Ok9EPBHeV2Hs7AsUAGHUGpIauESW5lETOIs+cb/YL6lhWBZFQixPbyMtqXh8yhzP//G+BkYLEmf3T7Y2Sc/8wqyE20Z/XwQMj/h/FjpioQV2wOddxqzw7OTaU4VGOYqqSuHxbSysN4bxzBnOlEAH6waiE0/3QNGgmftQYsuJhR3UZ8O5SdDnm5C/6zUcSqAz0ISz4TdU8IxUk9cwC04XtgjBmtzjWRpEL4O2GPP+WSYwX0fxY9v2C+VbZ3YUKQgudR9skB6h9raZWJUjzyYqOF5takxfrNdo9J30UxM+TAAQSvuhut7xEHvy5LWZZJKUiSoVs38ELIjfOyswXvgekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrs08zAJYcsZ76UNrjsQjms4cI2cL/d+ztafcElKqMM=;
 b=mNCicghYcyjaJNJvs5TQcVF3ODoI3QIlro/YpwHKbnXhnaHVpfSYvYDfKmu3tlpEjHjkZWMYRr+xUeJfuPsQBbWgQ3BoeUJS9TrPv8RZ2tNqCLX1wlsuF8wRUy5CWQGf/PhCbHy4GNKMg2lC9YyKXbz9vei7nvodVmZjzbMEO9A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6448.namprd04.prod.outlook.com (2603:10b6:208:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Mon, 30 Jun
 2025 11:45:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 11:45:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, Johannes Thumshirn
	<jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, Boris Burkov
	<boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH RFC 9/9] btrfs: remove unused bgs on allocation failure
Thread-Topic: [PATCH RFC 9/9] btrfs: remove unused bgs on allocation failure
Thread-Index: AQHb50Sd03LTibgT40S51u2McBzczbQW4ZSAgAS424A=
Date: Mon, 30 Jun 2025 11:45:34 +0000
Message-ID: <79d8cfd1-ec0d-4eec-a3e2-7875b94d0e53@wdc.com>
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-10-jth@kernel.org> <aF6CzXUlUNE5ruWH@infradead.org>
In-Reply-To: <aF6CzXUlUNE5ruWH@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6448:EE_
x-ms-office365-filtering-correlation-id: d2268295-ae6a-42c2-35c2-08ddb7cb9fae
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzBNckowaURkdTA1dVIxb1F3OC9ONGZZcEN1TUpJM0ErclBsYUhKZURCVTkw?=
 =?utf-8?B?OTUwQ041dUFmd2tYZzdGMzFBbFEyUFJSclhMb0tlVG5FNW05QzhkaG16Y3Np?=
 =?utf-8?B?bGU3Wm9VTWdTYmxLU3dybEFsTDNLNlJVeVlXTkFpWU9lZHNlOXlnNG15ZjNL?=
 =?utf-8?B?OHc2OHpYWmZLemNnTGVLWGd6OUROUDNZNHJkcmNEbHNvT2NhcHpGd0xjMTNW?=
 =?utf-8?B?djY2UGFWdVZRN0xkalpoSE5ZNE9KSjI0TFV1Z3l1VmJKS3IwWUpLM0Q2bDJU?=
 =?utf-8?B?TXNJSDc5NHBEa0gxbXlXLzZOTUN6QUR6VVhrbDVaeE9lV2R4aTJsWlJOT3ds?=
 =?utf-8?B?SjdreWFENTZiZ1F3Zk5kRlg5ckFPeWZFemVxcGU5TVV0VUUvWnYrTERua3Er?=
 =?utf-8?B?WkF0R3FWSTQ5Rm1QdE00YXVvWGRYVzZqUEErSlk1TFUzK3FpQzRyZkN3cVVS?=
 =?utf-8?B?SXZpRDcreEtZNlNSbndnNHV5N0pUZTU1K0QrR2d2WkRjKzZ5Q2ZZcUNJOWFN?=
 =?utf-8?B?OHpZKytWT1ZHUC9PNnNkVi8vSUduM1hqU01ZZERvUHhQVHZPYjdrcUNKdW5u?=
 =?utf-8?B?NzQ4WXk2c2hjUURKRW03WHJTeXZTTm9LQTVPK3gySi9rTDY2aUZJSmdOVjBC?=
 =?utf-8?B?MHd2cHZWTnFMb3lwRk0vMzY0cDByeHhqVnFTUnQ1SEQzelpsUWhwc09ZUTZJ?=
 =?utf-8?B?aHBxdCtrbWJjc0JMb1M4TFlMNUtjZjVDUCtqVGtBNU45eVFwTVBuYXFtTFlZ?=
 =?utf-8?B?RE1BbStNOC9xUktMRGpuR1czQkZtUXFmT2l1Y2JQb2hyMTZnNVN0ck1JOUhK?=
 =?utf-8?B?RHhEMmlFQytHTkZ6emRSbXZEVzBIUDNWblBFWXlMOWhwNTlMejJVTStWTTJv?=
 =?utf-8?B?eEw5MjFVZWxRZjhGNVV6b1lwUUlKeXhUOENsM05Pc3pwRmlFSGdGbXM4UVph?=
 =?utf-8?B?VXlvM3B6NWhZNG9Qeml2Sm12S2RTN3dTcjl4MG9pMDFwZXNvZndDNGZZREg3?=
 =?utf-8?B?d21nQjJQdXdrbUZMb2k5cmdtVE5yQTE3VEU1NW85ZWZMbUdjaXVuYlFnL2lS?=
 =?utf-8?B?UjRYY2IvbTBCeFpnb3hIVDJDZDBHeHFINFcxQk0xa1piVEVHL2VlK2tFbEF2?=
 =?utf-8?B?ell1aVBNcnViT1RrZ3FMNjBlUk83KzlCTkVsSGYwcTBod2J5Y1NBTTRRUURX?=
 =?utf-8?B?a3o3RUVQWmU3UGtLYmlYbkV2Y1ptbm9oN012bmVodHIva24razhPY0VWOWJh?=
 =?utf-8?B?VVhITFA4aEpKQlp5T1U4SWVhMUlFbm55Ylo4UjlqUTdpUGlEWS9seW5FVkl2?=
 =?utf-8?B?WGY4Z3BKWDZUTG41OXEyWEVmTVBxQUl1ZDhoR1laTWVXRzQ2b1JES0RyT09w?=
 =?utf-8?B?Z3J3bDU2V3VoZy9QazBkcjdTemRiMlpFeTVaeUhPN0xYdEFZNmFiY1ErVGJD?=
 =?utf-8?B?NW5yNmhQUGFLRkJsSU5lQmF3cDFwUDdTTWFYOE5FT3ozbHRVb3hyUHNiUWVF?=
 =?utf-8?B?QVh5QllzVXNNZkZYT0tRZWtNRFVyZlRrSGJuK2laeXgwT1gxTmtwTXc0Tlln?=
 =?utf-8?B?YnIvN0pZUkk3dVNNSHo3aC9GNnRiZndNMGRHWEJaR0RWYkd5SlBjYWtjeXVT?=
 =?utf-8?B?WUtSeVNiOU1tSDZwT3kwMk5Ga1Y2WnR5TERVQTNLYnJaaHl6dFYzVmJ1VUw1?=
 =?utf-8?B?eVlJUzRnbjlYSE1PNk0yRXRNWHFLaENsRUVwQ3BSVE9zNEpjc3ArbGUzdWZM?=
 =?utf-8?B?eWpIc1NJcGpkLzB0VkhpVG11ZTc2WkJPMDBQQUJsTVhVS3FGUmhUeFlrSWsx?=
 =?utf-8?B?bXNFLzhqVEZnYXEyY3Q3cEFxWlNzMXZZSzZPK2NFWTducEh3M2d3aUt3WDN4?=
 =?utf-8?B?ZytCN2hyVXdqN1ZkM1B1dW9SdGsyblVySDdDWStaa0JTV0s5TXBPOFZzYUYr?=
 =?utf-8?B?dm9jeTFPN2FrMEZRWFpUYVdNT0ZJeDRIeGF5bG56UXBSNm9jb3QxSTlYZmhK?=
 =?utf-8?B?bzhydDdqeS9nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzI5UGkyZFVpOU1HeEVHNVFXY0lkcHNJYnpzZXl1dzVNeDhFOUx1WVdyc1Fo?=
 =?utf-8?B?WTBpTjJnWHBtTUVDZkx5YmtQcmRiaXU1U2pjZ2laaDJKVWN2SWNaa0JrTGxt?=
 =?utf-8?B?Y05uaEJFOTJqY1ZFYVJHL1hLMC9uSVFaRkROMWovcEtlS3NMbGhXTzAvREU5?=
 =?utf-8?B?R2VVZ3prR0NwYmJUNVRnREtyNFJscUhYQS92MFJNcWZZTEdPRlZQa05jTjJu?=
 =?utf-8?B?NktVOWRrQjFzT1Ztd1pDQW1ZdjIzOXNTS3RDcVhwWGZxSnhtRE5WVk5mK3RS?=
 =?utf-8?B?VWFGVjEzVGxjcS90K3ExNUtUTFY5TldJcG1pdVVYQXBNVFZoOTBBbnFuZmNy?=
 =?utf-8?B?OWp5WlBnME1RUWkzeWZiMUtlUDgxaFk5ZU5jZHp6TGNYUWxDT0E3bHlKYWds?=
 =?utf-8?B?WE03RkJ3dmU4NmxJSXZPdXNxelViR0NDZnk1MkVYdVdIeVo5OVNGWWdIRzAw?=
 =?utf-8?B?SmcxTmdoWmJhRUpwVW5UcGhpNzIvMjRsVTdOZ3gyWUVRZDFOSDJpZVdPVnZD?=
 =?utf-8?B?TmIweGJ1QWpVajhjMnFGSDlNQVErOGJKS2Y0cGhUb2RqeUV5eTVxeDNHRVRY?=
 =?utf-8?B?cVZUS0UrOTQyWU5WODlNUGMwdnh3Rk1EWlFIcnAyVWRXNkVCd012bGU3alBD?=
 =?utf-8?B?WlRmclN6cit0K1VjUzF3VDMwMm15Qm9nZDhUa1QrMlVMMWpvR05haXM5SmZ1?=
 =?utf-8?B?NVhpN2xpQ3dJMlZLYk5NazBSVm9QMlp5ZHR0cjYwcmxBOEF5QWZBd3paUThq?=
 =?utf-8?B?VGxGSkE1RlFlV2QxSnBTejFHYWVCN3JZbEpadGpUaWVaNjB6MkpNVVRlMG0v?=
 =?utf-8?B?Ullrb0Z4aG9KZGRxT01mVnRSYmxmWmZ2MGNMK29qOUpMcFR0bEF2dW1XL09l?=
 =?utf-8?B?TnRzbDAreXQ4Vi82VzJYR29WaDhidW1uZUgvYnFVK0tPbTlCTXhMQUM3QjJx?=
 =?utf-8?B?cHZzUGpuTVBobFpqdnE4RGlvOUFOVUxQc1I1SXMvSDVrVnJJL1M2QlJjV2xi?=
 =?utf-8?B?M2swM3o3dlNpcE15QVVCODhDMFpaRW9RTWYwU2VoL3hjVTliWmxWUzU1ckpj?=
 =?utf-8?B?ZVQ4V09Pei9JaGhNcG9vSHZub1JyNXV6YitkS2xBUFpEVEFndTVvT0Z3bWVt?=
 =?utf-8?B?c1ZOaXVvYWIwSzFpZU5HMWE2RGtZY1VyWVpmYXd2YnIxNmFUKzhEeTFoTUly?=
 =?utf-8?B?VnZ5VmRRN2dKUVpRNGZubkFCaWM4bnBjMVc3KzZZQzNTNGF1VEtleWVsK29o?=
 =?utf-8?B?TjY1SjhLWEU5U0d6eWpJQ3R5bVljaGJpNFlwNndIcXd6bkVXUVA1T3NYOGFN?=
 =?utf-8?B?Vy9YcjNHTlV6Uk5hUDBkVkx4WmJhMmVCTGFTL1F4ZFJLK251TXBYUWZjd2Ny?=
 =?utf-8?B?UHVsOXJOU0lFT2ttMHJEWXh6WHQ4Umh5NmhTNUxxUXVhcVdjTXRldE9sMFk5?=
 =?utf-8?B?U3ErNlh3R01yRXVlTW1GNEI0NHZteGdpS1VNKzllVnFsRXBpOHcyeVQ5RzU5?=
 =?utf-8?B?SVJOZko0cG5iSWVIWGxQMlZCR05uZGwvYkppcllQRWZGZlQ3QjBWVnhvUFgr?=
 =?utf-8?B?NGZDWXBnNFFEQmtzOUlzYXNoMkpEOEpDcys2c243NWxiUzd4Vld2MWlaZ2pj?=
 =?utf-8?B?aldoZ0pZaFQwdEhyNFArMVNMNkhNSmJPR1dmUzBaWEdCL1dQZzJnQVFNbDJZ?=
 =?utf-8?B?TWtVSDhGNEt0ZmFmTW9nL3F1VVpwTHp4ZkNkZHdCMTdsVmY1T2FPNGlJMDNB?=
 =?utf-8?B?Y3Qyai9pTkQ4cE1ldlg5M3hGNko1QjM0L2R0SDVpMmtDdkxSYVEyRzJoekhE?=
 =?utf-8?B?dUwrVURGUkVDaHFZZ1VBODZGNGgxTEhMQmhDYzhGYWhwbEdOY0FNRXJLL1JD?=
 =?utf-8?B?YUd6Um5td05OOG50WGFwbnFyQkhiT2xhN1lQY1BDWk9qTno3c2pWYlhjbERn?=
 =?utf-8?B?MTVabWpyemtlM2hOYm5ZSnhQa1RpWDV3T1BTSHpWL2sxUXdQWi9LZks4dEF4?=
 =?utf-8?B?RkFBV3ZSZUpmdW9KamplMVArTTM3S1dCZ2g5Zjk1eEVLUDArdUpGL3l5WTJB?=
 =?utf-8?B?MDRoTTI4cm5MTXJrenNxbW9QUVFSaHdWQXRFcnkvdmgzMHN0NmY0TEZwZktj?=
 =?utf-8?B?S1FTc0FrbzNyc0l4czVUWGNSa3RURm9LU20rQnFaZndsdnA3ekIrTTFjWXdX?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E934F7E643C3F34CB32551859F205235@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FtV2Cw+diM/Xw4lCMZXwbEcpomBBLaWg3W28UxnWXojF+panW0hj/kMe4XYXTo3tVwgIbLi2siLGaEViBle9kDyXoBM8oXhUDqLJj0M0ld7RjuuQjs2+dZNW0OFRMMQ/8i8Bcx+1A19oOkRrDorlYH6sv0lgNVfpVzgwTusuE2FUMe/F/9CJqJC6KurTRYLtPivIcOgD053N6iXOpoCxKwvM5AWXLqlmV3g5kKgU2Sh0xzEVS3NBcDk9W6g+NEu+//hyeZZOOSCmIvMorjqvYV7KPnNBUAxYmiDPK5khe4sW4FTMhYQhCWAo0J4xNxO0caC59rQnXvzOu09oOmRcBlmCT8G9xxDGKymqbyNt5n050CSyNhEkjclXGbYeAyntkwWMT9xnboufBL88QfpzAlfmExP4BJDGemSdfsCp37o/qkXWhKJcon4grtr1tTyWFGDZRppLoHBl4S0r1EPxXJNmSYkzKmy8YvXe6q2LaIWkPVwQVfb5Lj0dAqfaoYDlfyPpKI8MjnYPbXF5YKi3o2QpPAfeRToqf8ApeoI+22rsqgv9WIrtEDK3XG+AFY1ksBOcG+zKI2V43lkuRdiLi355+w8cVnUu9dUCjs49lDLMz174TPV25Jp45/sQbgd4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2268295-ae6a-42c2-35c2-08ddb7cb9fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 11:45:34.1404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvM3V+fKXwY8blfpo9jUHv5X9CnTda6rDCOaBvqqJqCqN5Ude0+bIlvQMHzLU9bVsXTy20f6auJMwumjR+s1aRM2CVXjiaEFtuFuv+L3x8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6448

T24gMjcuMDYuMjUgMTM6MzksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBGcmksIEp1
biAyNywgMjAyNSBhdCAxMToxOToxNEFNICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29t
Pg0KPj4NCj4+IEluIGNhc2UgZmluZF9mcmVlX2V4dGVudCgpIHJldHVybiBFTk9TUEMsIGNoZWNr
IGlmIHRoZXJlIGFyZSBibG9jay1ncm91cHMNCj4+IGluIHRoZSBmaWxzeXN0ZW0gd2hpY2ggaGF2
ZSBiZWVuIG1hcmtlZCBhcyAndW51c2VkJyBhbmQgaWYgc28sIHJlY2xhaW0gdGhlDQo+PiBzcGFj
ZSBvY2N1cGllZCBieSB0aGVzZSBibG9jay1ncm91cHMuDQo+Pg0KPj4gUmVzdGFydCB0aGUgc2Vh
cmNoIGZvciBmcmVlIHNwYWNlIHRvIHBsYWNlIHRoZSBleHRlbnQgYWZ0ZXJ3YXJkcy4NCj4+DQo+
PiBJbiBjYXNlIHRoZSBhbGxvY2F0aW9uIGlzIHRhcmdldGVkIGZvciB0aGUgZGF0YSByZWxvY2F0
aW9uIHJvb3QsIHNraXAgdGhpcw0KPj4gc3RlcCwgYXMgaXQgY2FuIGNhdXNlIGRlYWRsb2NrcyBi
ZXR3ZWVuIGJsb2NrIGdyb3VwIGRlbGV0aW9uIGFuZCByZWxvY2F0aW9uLg0KPiANCj4gQXNzdW1p
bmcgYW4gdW51c2VkIEJHIGlzIG9uZSB3aXRob3V0IHNwYWNlIGluIGl0IHRoYXQganVzdCBuZWVk
cyBhIHpvbmUNCj4gcmVzZXQgb3IgZGlzY2FyZCAoYSBxdWljayBsb29rIGF0IHRoZSBjb2RlIHNl
ZW1zIHRvIGNvbmZpcm0gdGhhdCwgYnV0DQo+IHdpdGggc29tZSBleHRyYSBjYXZlYXRzKTogIHdo
eSBkb24ndCB5b3UgcmVjbGFpbSBpdCBBU0FQIG9uY2UgaXQgYmVjb21lcw0KPiB1bnVzZWQsIGF0
IGxlYXN0IG1vZHVsbyB0aG9zZSBzcGFjZSByZXNlcnZhdGlvbiBjYXZlYXRzICh3aGljaCBJIGRv
bid0DQo+IHVuZGVyc3RhbmQgZnJvbSB0aGF0IHF1aWNrIGxvb2spLg0KPiANCj4gDQoNCkkndmUg
bG9va2VkIGludG8gaXQgbG9va3MgcHJvbWlzaW5nLiBUaHJldyBpdCBpbnRvIGZzdGVzdHMgYW5k
ICh1cCB0byANCm5vdykgbm90aGluZyBicm9rZS4gU28gSSdsbCBydW4gRGFtaWVuJ3Mgc2NyaXB0
cyBvbiBhIFpOUyBkcml2ZSBhbmQgDQp3ZSdsbCBzZWUgaWYgaXQgaGVscHMuDQo=

