Return-Path: <linux-btrfs+bounces-16356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAFBB35386
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 07:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C961899E9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986E2E2DDA;
	Tue, 26 Aug 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G5FCFWXg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w/TptX8W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7B27FB1B;
	Tue, 26 Aug 2025 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187290; cv=fail; b=momUtl1up5pJJ7pmmjzHtdEUTc1hctEEvwlei0Mn+DhX257/02E2cE8XuRRrYW/+4aA1gZesImC37TJv4kmvOL84pe1q6vsohFIaXpPbrptD5YAvjjZlMO3aHFgEsSuM4yaByx1jClxBOFa4NApRmDnkKf7XGTbTaonSfiOUDKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187290; c=relaxed/simple;
	bh=zKaexaxPgygBMY19aDwsZllr8QZFo6wlZaI2zdIfYBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fX3HFWtjYWoJPgJTzY4JWIGYPNjFOTebXv0FDz1YqTLo79irapZ3teSSIaUYgMhtgmeWKcBCZggSp19PbbHogsBMuEPhGkeD/PwLnmGcqO7Q4eCZD995h5mSFSawNVPGpSX0AEE9kQQsNsOcBt9uiBEqEWn79nGm3L7GR/+jNeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G5FCFWXg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=w/TptX8W; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756187288; x=1787723288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zKaexaxPgygBMY19aDwsZllr8QZFo6wlZaI2zdIfYBo=;
  b=G5FCFWXgDWfirTj8BzgCLlETD+k+MXzD6mhQDOUj1SSjePKyF7WUgjik
   bhlr31YHxq3jxQ92/bdBlf/pdCHnpE3ahNLaNOmx/pv6yv8hRnqACHsoJ
   xmDngEuntO8Bfmy/Cq+kCe8g49osn5QF6WGs/kaIZh2zrrM9fHnH2+bna
   cOG0RZ7ZTp4RIk7eZwrr34Z7xhu6bXw+9Ayhopmx9b2cY9M8wWR7YYYSR
   SQ6izNFBTaa86wzIlCAWUP8QYBM2KLTi3dhFDasmOjHIg/TnYufME1uP0
   6hXKTpRiS7reU+wWOaioJeAP6cgHEC6osEB/SpCyzAAPGALYaK/zFZ2dh
   A==;
X-CSE-ConnectionGUID: JAb/8b7tQNOlgHR36Eju+A==
X-CSE-MsgGUID: y6J6g0+0QrK7ykvUlKA6Jw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751212800"; 
   d="scan'208";a="108631225"
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.56])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2025 13:47:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zStG9UbORB2NuBxUqJnCGYyViqFhzVzCFC8uTWs3Q8y+QT/R4/r+estd+Vl+7x/uQHCkz1KHBV2xVFBfLFxMZFV1xpXNmGeacXZcmyQLq46weInve/3N62qHaACvNRKEp6E6eI3pw2LsnaGlSbVdgFwBINL/mO6KgVaESqdz2UzSd0XRPUE5SjmW31bv/N5h9hmGtUjexMxXyRuQ3FZM3Aj6n8qlIGekfFxSMN36MJkpUT/HpqnJ95Dd4eCUavPNnkTihNLftcEI43V7QPejeGQNSzYqdGHjP6dfYn/4eh9J1AqI5X5uOZZvOWI2q0OWUE5DJUDEWehs+BhhmZPZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKaexaxPgygBMY19aDwsZllr8QZFo6wlZaI2zdIfYBo=;
 b=v19ovVV6t1uWAEw75YD0vUoEo8xjnYtPU4XXn5QZUsEAnzYLBHmhAaO3wPgcq7DiZYajNJMZQTX0cZMcplcpgHFPdnYWuKX1bIp4PZ07WctlaoT4dHpUxPH5Kr6G11hfL3zB0O72qOHyLWbCNDo0qERwQp94Bk8lalTlynFjsM+pU4qaV3tH6C2kfX1Dp2Co/BoGWXzGs7m17u2H/x03iEsRJLyJiVj8HBgO234GOvlhLAokfmlxkx3fEtCTPxSmhmLuOb3zOt9qJuOfES1+JxAJE4IEW+KafNLlzMKTpRMbYWpVwsOABtFqMJgpnE42Rz/UHDwIpOH/jxUhqJktNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKaexaxPgygBMY19aDwsZllr8QZFo6wlZaI2zdIfYBo=;
 b=w/TptX8W2scpY60SoAGH2Pv/hW0u/ezoc6PAOHV9dsvMZwAXV+gZN751UlJ6CO1cLlioSxZZLPXbkCf0cIpvppEqfD8yvkfVfJ40sr3dHmag3WU8Ndsejo6ZEOzQnBreK4xna+RYKYuLnCaddhEsQCpUHYaYCYFDFYo+QiLU1pk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB7064.namprd04.prod.outlook.com (2603:10b6:610:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 26 Aug
 2025 05:46:55 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 05:46:55 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Bart Van Assche
	<bvanassche@acm.org>
CC: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: v6.17-rc3: zbd/009 hangs
Thread-Topic: v6.17-rc3: zbd/009 hangs
Thread-Index: AQHcFdvAlPxWDfgw40ezNXKjrQOQwLR0EE8AgABdoAA=
Date: Tue, 26 Aug 2025 05:46:54 +0000
Message-ID: <DCC4ESF8NSS6.1V7A1P9H0J0K5@wdc.com>
References: <b2678a98-037c-4567-b028-07e5bf149714@acm.org>
 <vybuayrnzu2kldwdluufm3b5bmjarzqchzsely7gdm3ih4ghjv@jejm2fg2jvdf>
In-Reply-To: <vybuayrnzu2kldwdluufm3b5bmjarzqchzsely7gdm3ih4ghjv@jejm2fg2jvdf>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB7064:EE_
x-ms-office365-filtering-correlation-id: d74bf52e-b7b3-4075-df08-08dde463f6d4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGE4QTgvNUJTSnIzc0R6amdTWURuMTB1L3g1UjgxUzEvTmszWWd5MlF3Y3dn?=
 =?utf-8?B?a2pDQUpPUFY0cUJCK1RMQVliUEs3QzRSUjRuekxTckI5VmZjQWRUR09PK1F6?=
 =?utf-8?B?Q0lIdnBPQjlHYkV6TlppaTFBK0hhU1BpY0Q5aGZLcUZ2MGgwS0liYmNpVERv?=
 =?utf-8?B?Vmc1c3F3RWMyZXIwWTJ6eERwOUFOdWdJQjBiUVR3Z2hQdWY2TW1lSHJqUFZ3?=
 =?utf-8?B?bTlqUnBidUpqVkdQMXhOMEJiSnBKNUo2amQxeldEUjNNVkJZQnh0RkRlLzhR?=
 =?utf-8?B?aGRBYjA2ZDBYRkkzYzVYaGtjdjJRZWF3Y3VJTWlrdWVuejdIUUFqWHgvNmla?=
 =?utf-8?B?endKZTNINXREcS96R0JsbjNJZ0xBczNQNmJ2YktsOWIwQ2puOWhxdDFnb0Ex?=
 =?utf-8?B?dFdnMFlneXVzTTN4NXRvdGVxdzFPTXZVVmlqY3YvWXVlNytLYlVCWXZEZ0NK?=
 =?utf-8?B?NHpGV3FJZEVpYU5uQTd0dTFtSFkzM0RwUEhZYytxS2FPNXBWZ0VnZnA1NXZT?=
 =?utf-8?B?NjB2bGI3eTJrRk5EL3p3VytzN2M2RzlFcWtGRVBMVmdaUFJXMTNJekt6N0lS?=
 =?utf-8?B?dGFzMHpDeTc0eHNmUW84YlkrelRFT1l0em9LTys2bUZuWkhVVWpwOHRlOGhn?=
 =?utf-8?B?eUpBaEVST3BJVGQ3TkgrL1pEV05RVlVCVkNKVGtRVVhnQ0R6N0VlWTY1bUQv?=
 =?utf-8?B?Q0hLaTR5ekcxWUU5Y3ZGb1hSeVBpMnNEaWcyaFYwaitqeWcwTkp3bDZNVExk?=
 =?utf-8?B?b1o2Zm81Q1ZhYlg3MVA3Q2I2VkVjYWZGN2t4UGJDa285dGNaaDl3TG1Rek5W?=
 =?utf-8?B?S1EyYWhvZERqVkc3dEVXb1phZGZ0WEZaZENoNVNDNHNzdFExQTBEdUxmVDJW?=
 =?utf-8?B?bUoySXdJVDVCd0J2bHV4Wk9yOVRTdGpmRnFHOENBRmdjQjNnTVh1STU2VWVp?=
 =?utf-8?B?MmpjZE9kTm16ZGIxb3pUU2Z3MWdHNVBIbnhydmp6bWwwd2FOaWE1ZGMrT1M1?=
 =?utf-8?B?TWQ0bEpyVERIcUxOUzV3M3FnSGxnSU9rY2lwcVgyeWJERG1CaGZJWm84M0J6?=
 =?utf-8?B?RnFwOUZqVlVHdDVqWnhXMHZxSTZZMjBoNmplZnorUE1pcVJlTzY1alJKWWxs?=
 =?utf-8?B?WmJJS3JuV3NwNnZQd0ZVczVxUVl2QjVUME56ZkNZRzdWNzlRYzUxUTN4Zkhp?=
 =?utf-8?B?WENpRU1zKzhCRGNZZkkzQXprckZ3WTlGRW8wYlF1UlgvcDVjcE1UZ0dsQ1Ry?=
 =?utf-8?B?MXFvZUZsSmgrUTk4OE5wdFoza1czNm95dkRpWExBYWpnQ3FKRDBRMmFwYmZZ?=
 =?utf-8?B?bHVVMGcwZ1ZIRWVVZGNUK1pSSzd4WmlabkcxTGp0RDNZd0ZwcnJBeTVKa3ZE?=
 =?utf-8?B?OGFqWkRzT1ZrRU45NHZaSHpGVHNRL0U5eEtwOWRHN1JqOWRZTE9aNnNPdnlv?=
 =?utf-8?B?VU95b1hXcVRVZmlsRGp6TXRrLzZIa3hLczNIQmRROENoUWpmNmNQb0RGWE1I?=
 =?utf-8?B?bE9uL3lXNGpJcHdpNkRSVXBXcmtyOGh4R1pHc1F1V0RFTjNPWmNvbWVKQWRE?=
 =?utf-8?B?Z1hDUmk3aUZJNXkxNWF0VjNRbFdycmVPREZ2enEyWDErQ3NWRURURWNMbEE1?=
 =?utf-8?B?Zi82OVBFMlFtbFdOS2NzLy9jR1NlcFN1YndxcXJKRTV6SVJQWG9TdFZ2WGdP?=
 =?utf-8?B?WEdzbUcydWVxd1FaY2FNQVlYMXlQcTdDSnVZdnNsR1lNcFJkMkZKbFBLSUdz?=
 =?utf-8?B?bklXajFRNmJlQSsvdjBGQlFjTWQyd0E3S2Y3b01XZjltSFpwZENhUlFoWkdp?=
 =?utf-8?B?K1BBSEdYSzM4RVN3WGVhNzRMMHhFRktuRGNyOVZyOTc5eEVSNVZmaFhJQjdy?=
 =?utf-8?B?emZZRlhxTDgyZTlWb2NFamJRVGxpbkV6VjdwZXRrUkM0cGwrMXJFRDk0aG5P?=
 =?utf-8?B?WW5IOW05OXVnU0M5M25TeUpybWJMbnR4ZllDQzA2ZHFjZDlsNXJTNll1Vk9k?=
 =?utf-8?B?Z0wvZ3NuWnpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEpYL1pBVTk4TlNqTkNXTm9ERFNVS2d3NzFCbi93a1E4cHJOTGNFcEFpTCtr?=
 =?utf-8?B?VEk4cXc4Y0FMSlFoTFVSczZGV3ArdTlrYkZoL2d1MDQ2SmZhQkdFTk1vanRp?=
 =?utf-8?B?RTBaV3dKcVdyRXN2SVBpWnFDeVdGTzlNcTVBVERNNzFGTyttUGxPNXpGZEox?=
 =?utf-8?B?RUZuMnBWRGNOamN2eWNTK21nalRoUFRYYk1oUFViM0ZyeURBeW11a1BMbkdH?=
 =?utf-8?B?ejFhLzQ3cUJwdnhQeUF2S1luVEx6OS9LZWl0SUJwQkxkQ1BuaEd5OGplZVJV?=
 =?utf-8?B?OGZWT2NVZ0ZKUytuZDQ5WnNMb1liWENUVEthZ3V2UWtxdTgzcUg3NUdYczU4?=
 =?utf-8?B?OTBscVY3ZThOTEdFbVhzOThlamREcUVBQkJscldSKzFEOHN2cHB1Uk5Yd3dK?=
 =?utf-8?B?eE1iaTVVeG9GdzloZGttdE9QOXltdFVTazB4Sm5lbFBmTVlHYW55V3Q0M1Nm?=
 =?utf-8?B?NnltWlgyUk1FVmdrVFpwSnJvRllLZEZEaGpsV2ViTllNbStvL3B2M3JrTExD?=
 =?utf-8?B?S0pDWlBUMUYrMnRjUTY3NlFBMTJwZnRZUWh1N0RJK1htTExkQklVcm5US0Zm?=
 =?utf-8?B?ZksydG1XdVZSbGo5ZjlFRWpudWpKeWo1TmhGWGlFdEZITVZiSXFnMVpNdjAr?=
 =?utf-8?B?VXVNaHJnSG5xM0h0QXBUVGlMbE96Tll1MmQ3M3JvaE8ySWdnT2hObkt1ZmZW?=
 =?utf-8?B?UC91eW5MK2xEZzBlYlJabURoRDFkdUJDZk8rcFB6c2VxT3JNUjQ5SHJwOWQr?=
 =?utf-8?B?TGhFZ0lzMW56WkNZakl0TEh2NjYxQjN1NkVNdU5MQnM5bzBWZTVwenZBK3J6?=
 =?utf-8?B?MjNWNmwybVBsa3JUdXRXOG5YYU1RZTRTQVdObEpwcFhvMTN6YnV0Y24xM1hR?=
 =?utf-8?B?Q3J0UXBoM05wRTROM3c2TG05R296WEtqUmg0aEYyNFRaSUV4T3RqeXQrTmhC?=
 =?utf-8?B?YjFoOEdneWwvMjJIa0JCeUdCeWNRMUgrQ2xXSDhpRGtRcGdLclRxelBPclBB?=
 =?utf-8?B?WG9iM1NBQjA0N1ZSdkg5UUFBKzlubTJkU2xvNVRncVp2cTE0NDZxdXBrZWxQ?=
 =?utf-8?B?M1dKZyt3Y3RBbFFydUJHdldvRkdYdnFwMERxTFRtTFRpRWs1TEVCbUFEVks5?=
 =?utf-8?B?ZnhrUnFVYVFlU3hYTGpYZ0pySVhQVUJQaERaRzI2QnlUNHZZVDlNZE9PSGNL?=
 =?utf-8?B?dmdDUXR0WndMZFAxZnBtYkFPaU9PM1VEV0pNMTlDODltUkRPcCt1OU1rZ1JN?=
 =?utf-8?B?V0xTdHpHbTZ1M01TRWlhMlhaR21aakxjSE0vekYrdjdyUS9BU0FTVkNwOU5I?=
 =?utf-8?B?Vk5sUXEvQmVqQkRMTXhWVnZhS25wQzMyeEJrdnB2K2hlY0FuVmcwQ2pka2gx?=
 =?utf-8?B?S0dtckhhSCtadXBwTi8reHBwQW54eDBLMEhwblliOUhONzc0R0MvNVBleFlN?=
 =?utf-8?B?WmRvdk9qdmc2SHB6a2VBc09nMXV5K3VHNzVtVWdtQ2R4ZDIwQXlmTS8zSEZC?=
 =?utf-8?B?dkp2cU9VY2JHcHczL0IvbEhqVUJ3K1lPYk1IN0JKNmUxMEhqK1NYWHZtbkdN?=
 =?utf-8?B?OHp5OVVlOGNzcDFodkVra3RRcXlSVGszOHcwSm1lM254SzVqdzQ4enJnUHU2?=
 =?utf-8?B?d2dnaWRrdldhZFU4azZEcTgxZkdpOWlnb3ZnV00zSWlQSUQyWUlCRGl1YUpL?=
 =?utf-8?B?OTdFcFJsTjVwMHVYZXlRcFpiY0dONXZXUWpLK1R1YXVldXZyS3BrRGVheTZ0?=
 =?utf-8?B?Zm1zeVdPMXIrYmFvWTVBR1NUdDc4VmlSaUxKU0ppZ3BJK1UrODVnTHd1eFdr?=
 =?utf-8?B?Tmh4Y0V5RWhHREVEVGVOc1BJcWpNZXloSExxRnBxamNPOSt0eGRZcWV1UzlU?=
 =?utf-8?B?eE9vRDB1d3lveU5VdVJMa0dIc2dkWTdIbHZNb1BLdERsSjFob1ovbFhaZjZy?=
 =?utf-8?B?VithVnNHL2dFam1WVW03cHBPVW1CbnZkUkZ2RkJlTXpmQXUyMGNYYTQyNWJh?=
 =?utf-8?B?Z3BSREpzVlRkOXNQcUhGU21Ic2JxMWV5U1dXN1hNQVZ0ZXBERk9ab09EL25M?=
 =?utf-8?B?UXdxMmhHS3MxVGpwM1R2L0ZTeGkxQXJwTEtXZmpxWmhGbGlwdTE2VGgrYjk0?=
 =?utf-8?B?MWpqRitKbUNmcENseUpTbmYzdlFEZ0t4VDdId2dwcDREL0JoL0VqMllaOVV4?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DCD236520347048A474BCA6313A1F57@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k/N1IdB6xsB+q3m6b87qa+LdBAG5snEjzSoBS9feazQoJlO3H9ykAPx3MqjfgBQf9HcPIRUSlUKNtEnK3OmUwgC34AoLwt61bX3Ze30mjS1YknpU+h66+MzWo5f+c1DPC69OSmOttMQULVei641/WBqvt8JkgCwsHyYkP7N5qw6+DFxWkNFqmHLGHbqwGbWzBhqRj1iatQAodFSA1EmGtoLithOiQFYwlMbZ5RbDD9GToEjIcZ3rvy61jepj+SDMoV6VBYARQT5P/KaOshs90AZG0Cc/mTEWKeaYdvb9br8ecNQZtF5h7IrlVOcm/1KzxoQEqjv1n3PIhB7yFRCUYO75mvY4uaW7axfFUz2tRcPu3LTWNDqvqgH/5TbOFhUgGTZhoW9R/+ZA9prqzyTIsK140GEsfQd4EKY46xIv1cz3pIbrW/mf8BPLFDofE9jCUypFMWpnmtsSMTADsxbkIvB24zfE28+TAHTSLCEGIgu4Ntu/cPdV2McY6ECkvk7PMSefOpG4oOrYDuzJbSHhJ6UMXNuUBmaiMW1tzoU7fhlyXjroJwaRvgGdeplDCn39js03JOWIx2xqnyoJSOSQIM/TZmhTE+vKKwQ9V0zdY2oUvjx/u6irllW+7p+Ocu1w
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74bf52e-b7b3-4075-df08-08dde463f6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 05:46:54.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pItonyL3PxV3uHZTHAWtrgH54hpsXsz2DUcfkRYnpgdJZ+RMUcYqfJAPr1gStSyvDSJmU+bZDxCTQxul1V+mEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7064

T24gVHVlIEF1ZyAyNiwgMjAyNSBhdCA5OjExIEFNIEpTVCwgU2hpbmljaGlybyBLYXdhc2FraSB3
cm90ZToNCj4gT24gQXVnIDI1LCAyMDI1IC8gMDk6MTAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToN
Cj4+IEhpLA0KPj4gDQo+PiBJZiBJIHJ1biBibGt0ZXN0cyB0ZXN0IHpiZC8wMDkgb24gdG9wIG9m
IEplbnMnIGZvci1uZXh0IGJyYW5jaA0KPj4gKGNvbW1pdCA2NzYzNTgyYzEyNjMgKCJNZXJnZSBi
cmFuY2ggJ2Jsb2NrLTYuMTcnIGludG8gZm9yLW5leHQiKSkgdGhlbg0KPj4gdGhlIHRlc3QgdHJp
Z2dlcnMgYSBoYW5nIGluIGJ0cmZzX3dyaXRlcGFnZXMoKS4gVGhlIHNhbWUgdGVzdCB6YmQvMDA5
DQo+PiBwYXNzZXMgd2l0aCBvbGRlciBrZXJuZWwgdmVyc2lvbnMgKHY2LjE2IGFuZCBiZWZvcmUp
LiBPdGhlciBaQkQgdGVzdHMNCj4+IHBhc3Mgd2l0aCB0aGUgc2FtZSBrZXJuZWwuIENvdWxkIHRo
aXMgaW5kaWNhdGUgYSBCVFJGUyByZWdyZXNzaW9uPw0KPg0KPiBJIGhpdCB0aGUgaGFuZyBhbHNv
LCBhbmQgaWRlbnRpZmllZCB0aGUgdHJpZ2dlciBjb21taXQgMDQxNDdkODM5NGU4ICgiYnRyZnM6
DQo+IHpvbmVkOiBsaW1pdCBhY3RpdmUgem9uZXMgdG8gbWF4X29wZW5fem9uZXMiKSwgd2hpY2gg
aXMgaW4gdGhlIGtlcm5lbCB0YWcNCj4gdjYuMTctcmMzLiBab25lZCBidHJmcyByZXF1aXJlcyBt
YXggYWN0aXZlIHpvbmVzIGxpbWl0IG9mIHpvbmVkIGJsb2NrIGRldmljZXMNCj4gdG8gYmUgYXQg
bGVhc3QgMTEgb3IgZ3JlYXRlci4gVGhlIGNvbW1pdCBhcHBsaWVzIHRoZSBzYW1lIHJlcXVpcmVt
ZW50IHRvDQo+IG1heF9vcGVuX3pvbmVzIGFsc28uIE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgZGVm
YXVsdCBtYXhfb3Blbl96b25lcyBsaW1pdCBvZg0KPiBzY3NpX2RlYnVnIGlzIDguIEhlbmNlIHRo
ZSByZXF1aXJlbWVudCBpcyBub3QgbWV0LCBhbmQgcmVzdWx0ZWQgaW4gdGhlIGhhbmcuDQo+DQo+
IE9uIHRoZSBibGt0ZXN0cyBzaWRlLCBJIHdpbGwgcG9zdCBhIHBhdGNoIHNvb24gdG8gc2V0IG1h
eF9vcGVuX3pvbmVzIGxpbWl0DQo+IGxhcmdlciB0aGFuIDExLiBJIGV4cGVjdCB0aGUgbGltaXRh
dGlvbiBvZiB6b25lZC1idHJmcyB0byBiZSBjaGVja2VkIGJ5IG1rZnMgb3INCj4gbW91bnQgdG8g
YXZvaWQgY29uZnVzaW9ucy4NCg0KQXMgYW4gYWRkaXRpbmFsIGluZm9ybWF0aW9uLCBidHJmcyBj
aGVja3MgaWYgdGhlIG1heF9hY3RpdmVfem9uZXMgKG9yLA0KbWF4X29wZW5fem9uZXMpIGlzIGVx
dWFsIHRvIG9yIGxhcmdlciB0aGFuIDggdG8gcHJvY2VlZCB0aGUgbW91bnQNCnByb2Nlc3MuIFRo
YXQgbnVtYmVyIGlzIGNvcnJlY3Qgd2hlbiB0aGUgYnRyZnMgaXMgY3JlYXRlZCB3aXRoIGEgc2lu
Z2xlDQptZXRhZGF0YSBwcm9maWxlLg0KDQpIb3dldmVyLCBidHJmcyBkZWZhdWx0IHRvIHVzZSBE
VVAgcHJvZmlsZSBmb3IgbWV0YWRhdGEsIGFuZCBpdCBjb25zdW1lcw0KdHdvIHpvbmVzIHBlciBt
ZXRhZGF0YSBibG9jayBncm91cCwgd2hpY2ggcmVxdWlyZXMgbW9yZSBhY3RpdmUgem9uZXMuDQoN
CkknbGwgcmVmaW5lIG1rZnMgYW5kIG1vdW50IGNoZWNrIHRvIGNvbnNpZGVyIHRoZSBwcm9maWxl
IGluZm9ybWF0aW9uLg==

