Return-Path: <linux-btrfs+bounces-19613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D8CB1B9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 03:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CB00304B239
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 02:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794EF26E6FB;
	Wed, 10 Dec 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A7/VWaMD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QyWd6Q1M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9B246BC6
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334136; cv=fail; b=iVlTmKVDV+VsxWx1lhfh7dawRSyTlo0emGg+DgXubIHVIbrsra1Zio1Z1sgnQ56JsQrcb6Ez8iszJ8O3QldocHGSV1nWZM+A9xBgIoBeoDhB6NIghpV6V2GumunZVqXAeIlrvnPavQVAScRJyorOnYB7liWT4sLHkHpYIcPCHII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334136; c=relaxed/simple;
	bh=F7yfZLKC9xzZJ6bz+kkPSrGtvvUhqudH/xwoN8rQoBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CtNCmPU/AGj6q+5zIgNPCWN5BAgos7bDrL0sMvKAyMnRzJlgrhGQ3Vo3Upf57XU0+4dCF0IKKXSEb+5pRVw0b5WKPITTxXFLecaARMt/WPsnvXfwlA7d+2qoX1ndc3o8TzC3YHHagIQo8EbJUe67ikLvnY0ejw7a1nKP7y4jutI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A7/VWaMD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QyWd6Q1M; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765334135; x=1796870135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F7yfZLKC9xzZJ6bz+kkPSrGtvvUhqudH/xwoN8rQoBk=;
  b=A7/VWaMDXAcM/446ltuLI6FDZ1zzBEjkoYzIHrj3oKGr8sN3Wkn1CZOV
   ftV+o6ncCSRgowScrJF1d4X/qw1TaZHdKUN8QjMJKloafacl2Ui/QZ5Bj
   UTyA3qqFBl/8aOxuAEN/1znoYZFdzsUxXVEK8wIZQ2RHqtTirX5GlY+gr
   5Cm037nCLLEaQsT+onplRr8vIgYk0HK0pQxfkn4vFeefP0HTsI4p+cJz1
   Ksn0QOeNjSWJ6DGAYz56l6PnlzoJJnEiRouFWZdG8lWHEEGfhwC8Fw1px
   viLzqkHy7EriCQCUQXniNC5UVNOwcREq+fewyXnzOqQ2kBu8lnjoj+1gA
   A==;
X-CSE-ConnectionGUID: 1/YB0NwFQTGyOs47zJ2W4w==
X-CSE-MsgGUID: 0gcQc3sXSAKNolDcMZn7sA==
X-IronPort-AV: E=Sophos;i="6.20,263,1758556800"; 
   d="scan'208";a="133574342"
Received: from mail-eastusazon11011045.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Dec 2025 10:35:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjzVoEB7fXIz6bJYBvTKh3ANgdcwxcmnBjVZu+DCFAoj0DkyCnEtSh7tJ/Qa265QG2cmVaV4fXZ9tyzkSzKQ4aO5RoWvzOfFHWyb9CFKqX0H2svlAEtAVNe0IfbCSphwN4WvehsYWw+UsucmseF/KpF5epHNXhjFBcAgfO0T7lpks0HknHUGH8zNqiDhhpSlMk5EV9P/eISSBqEFFj7ZOcTusIa8SEVuJgI6mrE9gOIz7WFJovof5zt7NwE7ij6hbulrN5GPlaZCQPZaw6w/CXMdNO+T8YgHdQqxnBGxjYU2WsEHIhksI2pP2kn+CzuzYn9hbIjtyLlsgsy79us8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7yfZLKC9xzZJ6bz+kkPSrGtvvUhqudH/xwoN8rQoBk=;
 b=ImapSPePRKQkukq7ge4ehYfZ9orCwPkZ3Zzu53uPENRt5N088AjL6upcCf5qp//MQP8DAitBrbG+ltOO6YXbQNi5hQxbNc2Q+QnuKF6ZFruU4BOmJS7A7i3pSKYBkIyTdjQvv8d5ua/bjj7huEZLe0WUHBRicNUw06/8TH1dkUWl3ptEUcir0eGH/71cNuFGuLLK+dGP7rWUjaPXwCKtc0prHlF5z2DdpdRpPywN4pIQPx2sCJAxK3ovZYqOQifo7lIHSNkf1KY7RWkVq4ljFaP0hbrnm7s2S26T+YOWjcbKKj4rdA7EP9WecHRAA0geZxbxgymu2NLGvcjUenzsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7yfZLKC9xzZJ6bz+kkPSrGtvvUhqudH/xwoN8rQoBk=;
 b=QyWd6Q1MzdLUnbifeodIvCfeHNfLdaP78QfQDxboLtghwUAaBG/qmu9MHBk/PrfyyxLBQ6Ss87yb0JdJbGzd/GaxGo67Wd8VAmBNVSqf1Acgfwbvu7COw9W2+nPoj9amPTn7HfH38P3Z0M9mLXequQOZ1PxU257hOo2CNIN6Dyo=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM6PR04MB6460.namprd04.prod.outlook.com (2603:10b6:5:1ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 02:35:30 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 02:35:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs <linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Topic: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Index: AQHcYFs7ICy2wYW+6UypQP3O7Xqwx7UIL5GAgAAJswCABB3sAIANCT8AgADaJoA=
Date: Wed, 10 Dec 2025 02:35:30 +0000
Message-ID: <99066be8-992b-4476-9a22-8c1ff6f5cff2@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
 <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
 <3BB597E0959AF3E9+275dc513-febd-4497-a73a-61707d2d9e90@bupt.moe>
In-Reply-To: <3BB597E0959AF3E9+275dc513-febd-4497-a73a-61707d2d9e90@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM6PR04MB6460:EE_
x-ms-office365-filtering-correlation-id: 415f8dda-9975-4676-2370-08de3794c93e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YnhQZGd3ZXFoQ09Bdml2aWEzallTZnlpbUhnK1F2SDY4eVZJUkp0NksvM1po?=
 =?utf-8?B?dEg0a0dQdlpHbXVsUjAvNlV2ODBhS1NzOXl0eTFKWUlZUGticDdzcGpQQlJV?=
 =?utf-8?B?dE1QK0tEbmppQVBETDRwNWhrODBlb2RzRkZzUXVQN3hwdmpVaSt5NS9EQ2Ix?=
 =?utf-8?B?RC9KaWxDSEsxM0Q3ZnZxNDhteStEWDM3OWtlVXFjbHhGQW5yRWViNXRLZ3Nl?=
 =?utf-8?B?NmlMdkNyTEJHSjhUNVJOeU9hRzJHWW9BVVorUXBEN3hRN3F2emYyblh4MnJP?=
 =?utf-8?B?TVVOelZNRWVmZWtRWDYwMjlPanFPaHFSeldNZnNUR2diQzJJV1dlaUZHTXI4?=
 =?utf-8?B?WFFzUHcyZDBqVTI2VlVCMTE2WkhNaVh1ZFNNRkNlT3R5YzYrVzlWREJ5OUk3?=
 =?utf-8?B?VXZuQXFwYnh6dzRReVZjVndyNHVibVpHZnFnaURsSlRNNEJjZTJIY0RpeExF?=
 =?utf-8?B?RVZmUXdVRnY0eW4vYUJ2NGZZQXVKaXhlZVNHVnNNRGRUdjQwWlNSWUtyazg4?=
 =?utf-8?B?cFNHbVRBWGh1T1BHYlJYblBMRDhqUGJTTDY2V0FCcWkyckRoZVNOcFpyc3Qr?=
 =?utf-8?B?bzB6bUc3TzZvR05DN0h1WGwza3hRcHpSWHppa3BReTBxRFEyMHQ3dkViRWVV?=
 =?utf-8?B?a1ZJUldSQ3FpQlV5b3FRWDdXM0EySVR2UUJ3d3pyKzMxOFFsdm1Tc3ZhYVNB?=
 =?utf-8?B?N3oyb0liUnhYNDV3NHRmRGJOZWUvU0ZncisrTk5DSWh3NVZidFdYWHNBRFRi?=
 =?utf-8?B?ZjNIOGh3Rlo3NTlEMnpEK1RaWk5tZ0JCWmhScTAwaVN3MVE4bnlJdnc1eHhh?=
 =?utf-8?B?d0dBRXRlRkxJaHdjNXBrb2lUR3M1dHJKWHcyY3R5cTEvTlNFTk1xR005VU1R?=
 =?utf-8?B?U09EcTIveXFDbHRyOFJkN2sxWXZzV2Q1cE5JL21UdlF6cVNkRGNEWkx3OEcx?=
 =?utf-8?B?bnVTM2JXY1hkckFTV0ZydjdyQ3ZONWNOMlRSNHFmYWZKVnpvc3l1b3RHakxY?=
 =?utf-8?B?L1phYVA2NkY0aDRvL1NiMTRQTC80dDNtQlBVbEFNVjBReE9TSFVTYk1GQVFE?=
 =?utf-8?B?WFJkakRKanh4Uk91Z2ViS05qWnk0UlZvSW5UVXZkeGRrdWFYekJ6TzY2dEVM?=
 =?utf-8?B?S0ZlN0lvN3FLQ0lLQlc0d0tGcHloRDJ3ZmVyNE16ejNkWkVyVkU0R1JlSkIx?=
 =?utf-8?B?ZCt4eGlPNmpBd3VxUFJkWFBlMTJGV3UyQUtWeXk4UnRzY09jRDN1R0s0WDlG?=
 =?utf-8?B?WFpTNkZReW9DeHpKRE40ZzAyWnlSdG91UjNaRy8yN3FSL3B6T0Jvemozc01O?=
 =?utf-8?B?Q2Q3Z0hCN1JFczlCdWVYS2twNDNmZmVuM0ozUTk1V0NwZkpHaFRHMmxUV0FY?=
 =?utf-8?B?dnB4MGtZSGF3SExpcnNtTGhEamxaVGFrRTQxMzc2cHg1cG5jc0FLbi9IY3NI?=
 =?utf-8?B?TWxXSjEvbTF5Y3UwYWovRG55eXVhMVBXbHRTUEJsSXNPSm5LSTN4SEJUUTBL?=
 =?utf-8?B?OEFNeDkvVFRkNnNuVEhseVRiYmc1ck1HckJLZGwzUUpMLzFsMHNibDEvUDNk?=
 =?utf-8?B?S0RtRkFXY2g3blhFeFZnTzBlM0hoV1JwQ05vRm53QmpNWDBMVkJNTXU2cTlV?=
 =?utf-8?B?MkpPRnNEMzBHY2JBWC9halVVZCswalJKRTBLMkYvWGsxWDBxUHdadW1WaCtL?=
 =?utf-8?B?eFBZMjFpRHYyZk9NanBzNFNOeTg2YXBYVW50L1A0MVJhKzdPbUZTbm1IbktL?=
 =?utf-8?B?cHFMVmtrZ2taeWIxUFlvRytWK0hVM1VjZndtZWhpVitUZkFlU3RFOWhHUVdM?=
 =?utf-8?B?Y1JGL0NUckxBSWprTTBTVTc3dEpIbzN2VlJFdTZFbkhEM1FYWGIxSnVkZ2VI?=
 =?utf-8?B?NEcvZjFiZkdpSkg2ejJQVGtaSmxwTHhybDB4VEYrR2RiL3VyamRJaEo2Zmtt?=
 =?utf-8?B?K2VWazRBVnhINmJOZWVMWCtxUWRkUTVITEtvL0hoVDh5a2d4MzlybHhqUmUz?=
 =?utf-8?B?OGRic0t1Tk1DTFVLS0VteVRFb2VEck5IZzhJczMrZytldjl4U0hOdUlTbXFZ?=
 =?utf-8?Q?71jzwk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RktyZ3gxdjF0bytibzNucGRZeE52a3NOZ2tBeVhQNllSQkpEbDJRNkk0d1hY?=
 =?utf-8?B?YUVadmsrRHkwd0tFaXU1dFJrMFJYdTFXK0M2b2pJNmIyUnc2QXMxVExYQXZy?=
 =?utf-8?B?Q2R3bUVrTnpTbW1PMUtnYkd6TU9jVXlhRTdUajZEOXQvS2RyRVliczh5dHNn?=
 =?utf-8?B?YjRtU2pMZVZvWlh6QkVEaGZMTGszYWtBb2c2K1I2bGp2Y3p1Ny95ZWpUWGwv?=
 =?utf-8?B?Rk9VSkVMSTdWbS9UbWpWcXFFcEUyajFWTytzbElobm9NQlB3MXFadVlCaVF5?=
 =?utf-8?B?WEI5a3lIMzZWMEVLeDNlRzRGZ291ZE5wQ2dwMXFFSVk0T1oxcDIxbTVTZSsv?=
 =?utf-8?B?WGdGNXVVYnZKYmE2S2tzT0lmcmZSVmZad1UzR1Zyd0t3SDA0cm1qcXZ0VTQ3?=
 =?utf-8?B?OFd5QURkck0zc1lMcjF3OWNGaVhCYXVkdnBORzg2bEtQa2tjUTl5RVBBRm5y?=
 =?utf-8?B?UlU4QVQ3T3FoZXNVNlJkR2ZUZ0MwVnEzYU5xK04waVpmNVFjVHdCWUFtbWxl?=
 =?utf-8?B?Rml0eHdCYUVtOHpiNExEOFhIb2pFSm9tRjJSaHBudVJhcHkxS2hMZFd5NWhS?=
 =?utf-8?B?aDVjamtxb09IY3l6TnVVQXZqdVg4R2xJZEZXVFJEWTdmSGp1V0s1VkY4YVc3?=
 =?utf-8?B?M3RoVmRVbmJQeVVhVnJZeDRNZW9ySG1LSlk3SlZFdVl4cFpoNUZScDBmY0Zn?=
 =?utf-8?B?eEJISFpBcnpZRHRScXB1cDhGbGpMWHlkMERlSWxwaWFERGFpSUphSkptQVdU?=
 =?utf-8?B?bHEyc0d0SzJ5MmdQdERhNEEvLy9Beld6QXNpazBkR3FTaWxyaTVsT3JZVzg3?=
 =?utf-8?B?S3loczZmclRvRTBaY0doSldGVmpvV1YvUHI4M0M3aWd3WFJGbVhZT2lNM3Vt?=
 =?utf-8?B?REtFUGlTYVNzUDFHeE5kYmhFTnZYNUlSRzQ1dm1CYWp6N09IOXNKajVTSS8w?=
 =?utf-8?B?YS8xeVlLbGZYQ0NQcU00Yms4cDdBWnl4RkVjNGFkWDRENmcvTWFDdDA4RGw2?=
 =?utf-8?B?MlVWU3NRM2V0M2NYT253aEMyQjVmZE5lZSsvOWJzR1dNRUxYUm5EZ0FOam16?=
 =?utf-8?B?aFZ5OGtMalZHU0taRW1zUnRYeFBjY1VjY3B3ZlVJUmN6YTFJNHp0R1NEcktL?=
 =?utf-8?B?dmhEL3EydnoyN1JvamE3Y1k5K0F6OUE5b3kzQjZzbzY3ZGovK1czUzg3U3Ra?=
 =?utf-8?B?bkJ4RmQzaHJiTUFJekttVCtxL1pNajg2TFRTZ2k0eEVZRVJZZ01SVm1rSktV?=
 =?utf-8?B?MGZYcWtFQy8xMFRZSDhnbjFwYkFjanJLOTBWVUdIUGFQSTcxbUdLa1JEbllM?=
 =?utf-8?B?UWxlN2FlSlhXbzhFMG5uaXlKY01nbUU4YlVhUXdxMW5oMkY1a1IxeGs5dzFG?=
 =?utf-8?B?aTNQaTZHT2NvaUw5NnV0bEVwcTRIRVZtK2xZSXhvWTlTclFqYVNIK0FUVnYx?=
 =?utf-8?B?ZjczRitNNkZ5enQ2Rmh1MWhqMndNWHk1aDdVakdhUmpvUVp0MXZISlJQbXla?=
 =?utf-8?B?M3k1NmJ4NnNmanFTb0hzaTdDVWtSWEpJdklTank3SFV1TXNQb3JjU2RiU1Jy?=
 =?utf-8?B?bHZFWU1Gd0ZBVXF3ZTlaK2kybVdzOHV5cXNGbUg1dkk0b29aOUozSnV4SkFY?=
 =?utf-8?B?ajVpdHYvMGVxVkFaMS9qL0NwcHdSTWNaZERtbVpMaEJ6Nzh6dzdKREZubUFz?=
 =?utf-8?B?OHZ4L2NUNGk1S3dQVFJuRzdJNlJuYStsMUJWeE1XWnNyWnBMay9zR0RLbGdR?=
 =?utf-8?B?RGpkeVNBSHl1WVBSTGQreVVFVElYeldqSnBvTmlKdWFWT2I0NUtQQXdQa0Rs?=
 =?utf-8?B?bWtHSVNRZUx3OFpDM0xCM2dmeUVBN0RNSUFmS2pTekZZS29WSlN3QWdLdEVC?=
 =?utf-8?B?dU9qVFZrT3AwNEFWSHBJcE1iQmhTMXRnYy9kcjhsNDRqMmlvSk5ReXNadWlB?=
 =?utf-8?B?RE04b3lJSUhvU0lTRXVqZUdrU3lFQ0FNTDFhZTFvZyttbzlocnk0MU1ycWJn?=
 =?utf-8?B?cGZiL0M0cVBVeUZsSlhMUDBCYUpFKzRlZDJjNStJT05FRlJ3cDVoWG5DYUl1?=
 =?utf-8?B?V0YwMVhBU2ZsZ1drTitqbmlqam82UlhEODd0anNDb2ZiS2ZlSTdjYThlcDB2?=
 =?utf-8?B?TktmdGZVVGFnSVVCUW1Wd3JtZ1Z5M2lwZEtXdmxtVFNmaStvWm4wcmRrV2VP?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A769D6A19AB32A41A334625E61F64E3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0RklPSrmRFN+r3Rb+21SXWJ/dEZZlgdjLTltg9WVarjOm1tQcqSXdFFBvZlWdVtQYoiscFT367OeoV/Yxe/xRnXKUI0YrXb+YM7R7QTfeM9VVZwpnGFem6lTuwNKC14ktUTUAJ9Qc3wcQa8ofjQvMLLzbL4Nqj9nsj7Z4vVTAfJQnEWaEfczvy5HFnMZTDv0HqeHhYVdqKnMMu+2YZd0lYdEkkASOOg2NemIr9UthXEjtflWjVDhkA4tQxcvfEdpy72QXcmvPo681X/fRSVJhE6BRaNzzrjiYxiSDte1yV5niCc7ac/liHBgzBNPJHDQHw6/CytJ/Hsiw4AiX5tpsOfq+FC35fxEhl0JiEEcipbS13eFCZ7O5P9rb7f4IxTRH1hcqNro37E+1CsjmnzXqVfuKasoZnz87YpOyuri8Dps5qfoqjiSj/D9fOjBNZgSgbBEco9BfHHAhi+4uAKevpnv5gymLmeXwwjm12NQS1FXaT3rA4wYMjz71GqGfWaq1VyglijaFpVOYXP6XlSHxUIbKZJyGQ4AW6epKEzbtxWwUdD4DmDcmUw7OW7vu6whomK0wBBvjyjNWz+31liiDiCTwRPhen1lnJ6GD4Bf0GosL4RH6pa48+RUGW7/4i3W
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415f8dda-9975-4676-2370-08de3794c93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 02:35:30.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4D/U1DGKvBsxO0XPzIji6Kyj/bylmIT6Enusvqj+kTLsCgJqMUu8pdKxYgEo2oNJuZqzeEYFKL0lY6KpXNIEgjB5L/CtCo2i7aUaWNU4z5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6460

T24gMTIvOS8yNSAyOjM1IFBNLCBIQU4gWXV3ZWkgd3JvdGU6DQo+IOWcqCAyMDI1LzEyLzEgMTQ6
MzAsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBPbiAxMS8yOC8yNSA0OjM4IFBNLCBI
QU4gWXV3ZWkgd3JvdGU6DQo+Pj4g5ZyoIDIwMjUvMTEvMjggMjM6MDMsIEpvaGFubmVzIFRodW1z
aGlybiDlhpnpgZM6DQo+Pj4+IE9uIDExLzI4LzI1IDEyOjM2IFBNLCBIQU4gWXV3ZWkgd3JvdGU6
DQo+Pj4+PiAvZGV2L3NkZCwgNTIxNTYgem9uZXMgb2YgMjY4NDM1NDU2IGJ5dGVzDQo+Pj4+PiBb
ICAgMTkuNzU3MjQyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogaG9zdC1tYW5hZ2VkIHpvbmVk
IGJsb2NrIGRldmljZQ0KPj4+Pj4gL2Rldi9zZGIsIDUyMTU2IHpvbmVzIG9mIDI2ODQzNTQ1NiBi
eXRlcw0KPj4+Pj4gWyAgIDE5Ljg2ODYyM10gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6IHpvbmVk
IG1vZGUgZW5hYmxlZCB3aXRoIHpvbmUNCj4+Pj4+IHNpemUgMjY4NDM1NDU2DQo+Pj4+PiBbICAg
MjAuOTQwODk0XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RkKTogem9uZWQgbW9kZSBlbmFibGVkIHdp
dGggem9uZQ0KPj4+Pj4gc2l6ZSAyNjg0MzU0NTYNCj4+Pj4+IFsgICAyMS4xMDEwMTBdIHI4MTY5
IDAwMDA6MDc6MDAuMCBldGhvYjogTGluayBpcyBVcCAtIDFHYnBzL0Z1bGwgLSBmbG93DQo+Pj4+
PiBjb250cm9sIG9mZg0KPj4+Pj4gWyAgIDIxLjEyODU5NV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNk
Yyk6IHpvbmVkIG1vZGUgZW5hYmxlZCB3aXRoIHpvbmUNCj4+Pj4+IHNpemUgMjY4NDM1NDU2DQo+
Pj4+PiBbICAgMjEuNDM2OTcyXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYSk6IHpvbmVkOiB3cml0
ZSBwb2ludGVyIG9mZnNldA0KPj4+Pj4gbWlzbWF0Y2ggb2Ygem9uZXMgaW4gcmFpZDEgcHJvZmls
ZQ0KPj4+Pj4gWyAgIDIxLjQzODM5Nl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGEpOiB6b25lZDog
ZmFpbGVkIHRvIGxvYWQgem9uZSBpbmZvDQo+Pj4+PiBvZiBiZyAxNDk2Nzk2MTAyNjU2DQo+Pj4+
PiBbICAgMjEuNDQwNDA0XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYSk6IGZhaWxlZCB0byByZWFk
IGJsb2NrIGdyb3VwczogLTUNCj4+Pj4+IFsgICAyMS40NjA1OTFdIEJUUkZTIGVycm9yIChkZXZp
Y2Ugc2RhKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQo+Pj4+IEhpIHRoaXMgbWVhbnMsIHRoZSB3
cml0ZSBwb2ludGVycyBvZiBib3RoIHpvbmVzIGZvcm1pbmcgdGhlIGJsb2NrLWdyb3VwDQo+Pj4+
IDE0OTY3OTYxMDI2NTYgYXJlIG91dCBvZiBzeW5jLg0KPj4+Pg0KPj4+PiBGb3IgUkFJRDEgSSBj
YW4ndCByZWFsbHkgc2VlIHdoeSB0aGVyZSBzaG91bGQgYmUgYSBkaWZmZXJlbmNlIHRvdWdoLA0K
Pj4+PiByZWNlbnRseSBvbmx5IFJBSUQwIGFuZCBSQUlEMTAgY29kZSBnb3QgdG91Y2hlZC4NCj4+
Pj4NCj4+Pj4gRGVidWdnaW5nIHRoaXMgbWlnaHQgZ2V0IGEgYml0IHRyaWNreSwgYnV0IGFueXdh
eXMuIFlvdSBjYW4gZ3JhYiB0aGUNCj4+Pj4gcGh5c2ljYWwgbG9jYXRpb25zIG9mIHRoZSBibG9j
ay1ncm91cCBmb3JtIHRoZSBjaHVuayB0cmVlIHZpYToNCj4+Pj4NCj4+Pj4gYnRyZnMgaW5zcGVj
dC1pbnRlcm5hbCBkdW1wLXRyZWUgLXQgY2h1bmsgL2Rldi9zZGEgfFwNCj4+Pj4NCj4+Pj4gICAg
ICDCoCDCoCDCoGdyZXAgLUEgNyAtRSAiQ0hVTktfSVRFTSAxNDk2Nzk2MTAyNjU2IiB8XA0KPj4+
Pg0KPj4+PiAgICAgIMKgIMKgIMKgZ3JlcCAiXGJzdHJpcGVcYiINCj4+Pj4NCj4+Pj4NCj4+Pj4g
VGhlbiBhc3N1bWluZyBkZXYgMCBpcyBzZGEgYW5kIGRldiAxIGlzIHNkYg0KPj4+Pg0KPj4+PiBi
bGt6b25lIHJlcG9ydCAtYyAxIC1vICJvZmZzZXRfZnJvbV9kZXZpZCAwIC8gNTEyIiAvZGV2L3Nk
YQ0KPj4+Pg0KPj4+PiBibGt6b25lIHJlcG9ydCAtYyAxIC1vICJvZmZzZXRfZnJvbV9kZXZpZCAx
IC8gNTEyIiAvZGV2L3NkYg0KPj4+Pg0KPj4+Pg0KPj4+PiBFLmcuIChvbiBteSBzeXN0ZW0pOg0K
Pj4+Pg0KPj4+PiByb290QHZpcnRtZS1uZzovIyBidHJmcyBpbnNwZWN0LWludGVybmFsIGR1bXAt
dHJlZSAtdCBjaHVuayAvZGV2L3ZkYSB8XA0KPj4+Pg0KPj4+PiAgICAgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3JlcCAtQTcgLUUgIkNI
VU5LX0lURU0NCj4+Pj4gMjE0NzQ4MzY0OCIgfCBcDQo+Pj4+DQo+Pj4+ICAgICAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ3JlcCAiXGJzdHJp
cGVcYiINCj4+Pj4gICAgICDCoCDCoCDCoCDCoCDCoCDCoCBzdHJpcGUgMCBkZXZpZCAxIG9mZnNl
dCAyMTQ3NDgzNjQ4DQo+Pj4+ICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgc3RyaXBlIDEgZGV2aWQg
MiBvZmZzZXQgMTA3Mzc0MTgyNA0KPj4+Pg0KPj4+PiByb290QHZpcnRtZS1uZzovIyBibGt6b25l
IHJlcG9ydCAtYyAxIC1vICQoKDIxNDc0ODM2NDggLyA1MTIpKSAvZGV2L3ZkYQ0KPj4+PiAgICAg
IMKgIHN0YXJ0OiAweDAwMDQwMDAwMCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgwODAwMDAsIHdwdHIg
MHgwMDAwMDAgcmVzZXQ6MA0KPj4+PiBub24tc2VxOjAsIHpjb25kOiAxKGVtKSBbdHlwZTogMihT
RVFfV1JJVEVfUkVRVUlSRUQpXQ0KPj4+Pg0KPj4+PiByb290QHZpcnRtZS1uZzovIyBibGt6b25l
IHJlcG9ydCAtYyAxIC1vICQoKDEwNzM3NDE4MjQgLyA1MTIpKSAvZGV2L3ZkYg0KPj4+PiAgICAg
IMKgIHN0YXJ0OiAweDAwMDIwMDAwMCwgbGVuIDB4MDgwMDAwLCBjYXAgMHgwODAwMDAsIHdwdHIg
MHgwMDAwMDAgcmVzZXQ6MA0KPj4+PiBub24tc2VxOjAsIHpjb25kOiAxKGVtKSBbdHlwZTogMihT
RVFfV1JJVEVfUkVRVUlSRUQpXQ0KPj4+Pg0KPj4+PiBOb3RlIHRoaXMgaXMgYW4gZW1wdHkgRlMs
IHNvIHRoZSB3cml0ZSBwb2ludGVycyBhcmUgYXQgMC4NCj4+Pj4NCj4+PiAjIGJ0cmZzIGluc3Bl
Y3QtaW50ZXJuYWwgZHVtcC10cmVlIC10IGNodW5rIC9kZXYvc2RhfFwNCj4+PiBncmVwIC1BIDcg
LUUgIkNIVU5LX0lURU0gMTQ5Njc5NjEwMjY1NiJ8XA0KPj4+IGdyZXAgc3RyaXBlDQo+Pj4NCj4+
PiBsZW5ndGggMjY4NDM1NDU2IG93bmVyIDIgc3RyaXBlX2xlbiA2NTUzNiB0eXBlIE1FVEFEQVRB
fFJBSUQxDQo+Pj4gbnVtX3N0cmlwZXMgMiBzdWJfc3RyaXBlcyAxDQo+Pj4gICAgICAgICBzdHJp
cGUgMCBkZXZpZCAyIG9mZnNldCAzNzQ0Njc0NjExMjANCj4+PiAgICAgICAgIHN0cmlwZSAxIGRl
dmlkIDEgb2Zmc2V0IDEzNDIxNzcyODANCj4+PiAjIGJsa3pvbmUgcmVwb3J0IC1jIDEgLW8gIjcz
MTM4MTc2MCIgL2Rldi9zZGENCj4+PiAgICAgICBzdGFydDogMHgwMmI5ODAwMDAsIGxlbiAweDA4
MDAwMCwgY2FwIDB4MDgwMDAwLCB3cHRyIDB4MDdmZjgwIHJlc2V0OjANCj4+PiBub24tc2VxOjAs
IHpjb25kOiA0KGNsKSBbdHlwZTogMihTRVFfV1JJVEVfUkVRVUlSRUQpXQ0KPj4+ICMgYmxrem9u
ZSByZXBvcnQgLWMgMSAtbyAiMjYyMTQ0MCIgL2Rldi9zZGINCj4+PiAgICAgICBzdGFydDogMHgw
MDAyODAwMDAsIGxlbiAweDA4MDAwMCwgY2FwIDB4MDgwMDAwLCB3cHRyIDB4MDAwMDAwIHJlc2V0
OjANCj4+PiBub24tc2VxOjAsIHpjb25kOiAwKG53KSBbdHlwZTogMShDT05WRU5USU9OQUwpXQ0K
Pj4+DQo+PiBDb21taXQgYzBkOTBhNzllOGU2ICgiYnRyZnM6IHpvbmVkOiBmaXggYWxsb2Nfb2Zm
c2V0IGNhbGN1bGF0aW9uIGZvcg0KPj4gcGFydGx5IGNvbnZlbnRpb25hbCBibG9jayBncm91cHMi
KSBzaG91bGQgZml4IHRoZSBwcm9ibGVtIGRlc2NyaWJlZA0KPj4gdGhlcmUuIE5vdCBzdXJlICh5
ZXQpIHdoeSBpdCBkb2Vzbid0Lg0KPj4NCj4+DQo+IEFueSB1cGRhdGUgb24gdGhpcz8gU2hvdWxk
IEkga2VlcCBzdGF0ZXMgb2YgZGlza3Mgb3IgSSBjYW4gbWtmcyBhIG5ldw0KPiB2b2x1bWU/DQpO
YW9oaXJvIGhhcyBhIGZpeCBjYW5kaWRhdGUgZm9yIGl0LiBOYW9oaXJvIGFueSB1cGRhdGVzIG9u
IGl0Pw0K

