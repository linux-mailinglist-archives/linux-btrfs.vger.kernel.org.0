Return-Path: <linux-btrfs+bounces-12467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07092A6AB22
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 17:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FD28A58F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6AD1EF394;
	Thu, 20 Mar 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NgQZkxI9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Kxo2J/3S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874111B422A
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488470; cv=fail; b=U4FxS5DZhWj01YYgzRFSkn3MeTSAdWHWu64lyIyn5vMdMSSZhYD+7HyRwa+kVyetzsXUMoXo1hAYDNaQXOxp5bIcOSVqkq5Tt2BaN4TDIA0geEFs4gFZwpUOLpu2cE1Q6AQgL0tjiTM1GQVZ0XW4/WdeIM5yKu5OqTAtiDCRB5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488470; c=relaxed/simple;
	bh=IqFxmCRw/eNQp+aNk1ltb4GYDrzdIjNwNu1MeJ1LsNY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwq+bUNA9DppS1sQrXmb0NgOcR424e6aEAWoTgKirFJbrtZnDR8jzIqMMxelFaDoeKx0DJZx8384YEdUcUXXtbTPh0gFqXY67xUg2Y5Iz7xcRsUEaAsa4unTyZf7h0qc7npqzFgvxaJKJIH8HzrMWBhL15CA6XEt7XZ1GeYd54M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NgQZkxI9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Kxo2J/3S; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742488468; x=1774024468;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=IqFxmCRw/eNQp+aNk1ltb4GYDrzdIjNwNu1MeJ1LsNY=;
  b=NgQZkxI9ftyWIH2La0+iWIf2Heay6+/e8vjRFJLPazArn7T7UirpweBs
   dcAfgh02GdNaivKgjmRc4w5IQiEcF3MWgHMO+aqKqcglvvYHscm/Zuf6V
   BFsz+6DUok+iTrsiAX2HIffu9z4jpaMqcta/7WlAQ4Bl1WjRkIYmq1L3Z
   olLkml004c8meI7i8kvNoXTrZRIo0sjq4gdFHW2RfqWDOnx0rp0Jr9PrB
   +0jHwftSXE5kfkkkozpxLTuc49/i1ZMuST+6wYxvpvERmpL1B9h1OpjCH
   PYQ/a4Gx7y2u2qcNpTolZBarrM7+T1VTrFs6RDLNSwdrN8wHhyvBboaHZ
   g==;
X-CSE-ConnectionGUID: CHXpity0SXeoMcrQtsvZ5w==
X-CSE-MsgGUID: GpFPH3mZTXyjEhn/wrCqnA==
X-IronPort-AV: E=Sophos;i="6.14,262,1736784000"; 
   d="scan'208";a="57919462"
Received: from mail-westusazlp17013074.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.74])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2025 00:34:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNqkHLKQGSiz0WXrG0KSD0Ahogbi2UtNOXyMd6phptUdf/OJ6ocBr0i8e+oRB3N6xvJopxvZTrhV/9wWFMewWUXUDUo9H++Gxm0OqbkpAq+61/D5FC05PPquM+v0GuK+bR0DEa7Qs+cXCI7tqtpzcAo1EaEKIOPVslxvj1c1hKpMpH0wdElFZjIYd76+pd8bTyUkQCRrwMUpzOp/Ga/XfxD3RmBzkvuqEk5spmSPS9bbDab38Zxb2oHiklVdOrmlXOqDkCIbMWp7JvSp4XPtQjT8rajaiGfzYQjMLn7vXyt2HQ8DiS5iHHFiE3c9j5vjUUBXAdiOf535up024CIIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqFxmCRw/eNQp+aNk1ltb4GYDrzdIjNwNu1MeJ1LsNY=;
 b=E2kea8WbfWxPJV4VkkOn4drB+Js0Kt2Uw6s2RG6qPk00dUNE7+0WdFT79Ze9vLKbQNv37j1bn/rNAQuNs8L0vwBo9czxOhtEbwj4iJcOV4/abY5qfdwOQmi2eJ0osnAQ4/lhwaEvjPLBX8KAhf1QPM5+wHkHuKrGvQ7M3A+ReIMYRVEiqI9tXt8pZ0LijEXIImqOc5i4acR3xbCRgxwUbifcW//y5CAeovpYBehl6QPVYNJ/bqQYeB0TDDWokpdYnR6QD7lCvcf/M3BnpmbiNfXMXS2N0uW1lDmFWpmCBwIv8OhicoEM7dwTymCrmJHplnazBI2GeD445jxThcT9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqFxmCRw/eNQp+aNk1ltb4GYDrzdIjNwNu1MeJ1LsNY=;
 b=Kxo2J/3SBjGIz9lSqIJlp9KYwT5opfxWJqkGL9dy+0WVVNEJIFRx4RyKuhIl1nrBtAXAQw/UuDkgPcaT/ud9eZV53ruG0S0pu8wTJ8r/Lyw0FRS+6xpMKI2roZ+S/qVcIM/ImG9YvuHbYM7+2QmSJViyj6g4lgf5PF41qzMVQN4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7710.namprd04.prod.outlook.com (2603:10b6:a03:31a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:34:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:34:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 11/13] btrfs: use proper data space_info
Thread-Topic: [PATCH v2 11/13] btrfs: use proper data space_info
Thread-Index: AQHbmJacIU2yRFN0l0ie94eJb13j6rN8OrSA
Date: Thu, 20 Mar 2025 16:34:25 +0000
Message-ID: <d14af675-ac30-4775-9946-6fbd071d70fb@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <54c32cd875f589527ee25f9b0e9ff82a90c66d7b.1742364593.git.naohiro.aota@wdc.com>
In-Reply-To:
 <54c32cd875f589527ee25f9b0e9ff82a90c66d7b.1742364593.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7710:EE_
x-ms-office365-filtering-correlation-id: 8360caf0-7941-44a2-d439-08dd67cd13cd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1d4UzdZc0xaNEpUcVFTNnFlYVUvVjhkTjlTZTk4QVdHVi9JT2E0ckF6clFW?=
 =?utf-8?B?cE0vVlV1OURCS0RiZDZsbGd3NHJSK0I1KzlSQzlRQ2F3WkdySlAwODBVZWc4?=
 =?utf-8?B?K1RodlFYY3hjelpKOUI3S2xEcjY2Tlp4T3F3MWY0WHZLM0VIdzl1b0twSjNx?=
 =?utf-8?B?KzFzYzYxdmppcys0WTF2N2h5aFJyN2tHSkFRVzVtU2VacG5nRDRFc0wyYnEz?=
 =?utf-8?B?N0dtOFZWVG1sNGlXS2ZHbGFBSDFGVFp5d2ZST29jeGQ0ckNqR1pBTCtSSGpQ?=
 =?utf-8?B?QUN5TlNrdzE5d0FXZVpUUnJFOGtoaTBCZEUvOHhPNDdsUkF0eUxDRktyUHBt?=
 =?utf-8?B?Mmx0b3hIVWFkSUo2RHVlRHhDL1lOZDRmeFpMV3R3bDZ1RFA2aFdBV2ZyRHhp?=
 =?utf-8?B?ZmhmT3JGZzhEY1RQb29Rck1TemVLNXZxQ2JMU011RHhKRnk0UXFIeXdrVnNN?=
 =?utf-8?B?K0hrc2ZhWHVtdXU4ekg0bFFWMDBGL0xJQk5YUmpOalA3c2ZHQnpKMmJtSkk4?=
 =?utf-8?B?YU4rRGN5aU53NElTd1hicWhLTE5ITU5qWnFXQTk4TXJ5eWlaY0xQWXJOMER3?=
 =?utf-8?B?UUNHbUZHZE5MSkxWR3cyaGRqWlFzQlZYUFVpaGZEMlMzMGx1cEFKMkg3WnBl?=
 =?utf-8?B?MlJwV3RaeXo0RWthdUozS1AzOW5iVGlxVFFjUmdvQUxqUSs2RmYxYVFwTXN2?=
 =?utf-8?B?WHJiV0hXU1JXTWNVTWNuMTd2eDNXL3FKU2d4MTRnR3BJT1pYdFJzOHpYNGNo?=
 =?utf-8?B?KzV4VUNibm1CMCtuVSt5YW9qSFQrSzRycVdWa1lxaVB3aG9xWUVNcTdTTzhw?=
 =?utf-8?B?aVhSVUxBb3dqbVpsRXU5Lzc2ZWJBQmZUVjJMNldudTFIbWhRT1FFYWpFVVNQ?=
 =?utf-8?B?YlcwejVoaTdaL3FpazI2eGRMMFcxWDQrU3NIL0JneEdhUkhOaDVaOWNEMDFJ?=
 =?utf-8?B?azJRZ1JPQU9NQXBJSXllb2FOVmxnYUFtRVFKb1huL3ErZG0yQTNORTJUUzE1?=
 =?utf-8?B?QkZjTVJzY2RuZi9PbHJsSzJoWG13S3V5RTFhL1h4WWZocWxYcWhvZTZ0L2lW?=
 =?utf-8?B?SGdwQSswR055UXF2L0N5NW4rMUJ5UUIrcjdaVmNYd1Y5K2dnVE0rbk9QUGZC?=
 =?utf-8?B?K3RQTVY4UzI5TkVsR3JvSTVBWGhlSFp5NWVxbE5DSXp4OXZkRU1FcTJiVWlP?=
 =?utf-8?B?NkF4dTlaZ3JRRHJySDZ2RnNsZTcvcURLU0tPd0d6eGZmSFExWEJiTnhZZDl0?=
 =?utf-8?B?WUlJcTlTakQzZ3d1eVArZTk3TVBKV051a2ZZaWhGVnJrU2ZnYmVzMHE3SUFm?=
 =?utf-8?B?WktQZXJCSWtuZXlqTDhBM0FkUFE3TVM3dUtJYnNUYkR6c3pQcUNVYWFSZUlk?=
 =?utf-8?B?YjdCOVhBSnJmZ1RLUnMxQ24zWlV2UTMydXFYTDVyNXpuSDJDTk0yUUxMNnZN?=
 =?utf-8?B?bFBWMThFWDJwVk9wMkFsU0JxalVGYU1IM0VXb1F1dzd3VlhvK1NYSmRXaU80?=
 =?utf-8?B?SlhVNC9SaVZxTHhuR1VTNnpkY3Z6K3hqK3NSWEUrby9xMW11MHM4ZFZMRFpp?=
 =?utf-8?B?UE1wMjdkdC9SRXR6NjMvc3BFUEdqdWxicTAxMXNkUklsWEx1cUJvdGxhd3Yv?=
 =?utf-8?B?NDdOdFJJTklNOWRVZHQ1d1pHOUFCMFMycE8rd3VBT3g0SWtwK2pPbDdJWkJ5?=
 =?utf-8?B?ZmRiWUlZeEczaEQwVWhHQ3hyam9zSWIrS3lhMjRjVlV0NjBrUTl5QjVPWUJm?=
 =?utf-8?B?ZmYrcVBvWXJxdXJRRkJRRU8yY3hWV2VqT1JWNDd1S0ZhaUdCU0IvczRrWnFy?=
 =?utf-8?B?dUJBcXZvd1RGWUVML2NHaXE1ZmhqbURHbkNlSEJ0QjJ0ZmZwRmdUTmxpZ2tz?=
 =?utf-8?B?VjJWamVJanc4SWQ0ZnJQZkxnSGNoNmU5VUtZd2xua0FpSjlNb0l4cm9zUldD?=
 =?utf-8?Q?T4lWpiJ++o/WW74n17Uc+kLltsISyVBd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dURjQytLWVlRN05hbzVFUWVCN3AwT3VnckhOdjVSZkdNei91UnNNV3Q1S0FJ?=
 =?utf-8?B?WDFMUnJGaHV6OGpmblpmdk9TclJEVzNpVThRNHI3SUxYaUUwZVVXWmxia0d0?=
 =?utf-8?B?NVNJM0lLaUR6MysvMEtmQUFBbjVKQ1p1anNkN1F0aVZrcjJYRGNKVWZDbnZn?=
 =?utf-8?B?Q1dKcUx5U1dJekhRcU4wRlpWL2ZQVTJHdzk3cGVQZnZlc2tQL2dTNVA4dkpa?=
 =?utf-8?B?eVlIMjdzRlZvOTM0NVdETFgyNHB5T2JCYUNZMndwQU9HajMwOUNnWjI0M1JY?=
 =?utf-8?B?TDVqOVBtYkFoWkp6dGgvUmJvdFR2SExKY3Y2OVVleGFQd0hxVm5UOGpXMnFJ?=
 =?utf-8?B?VVpnTkpRSklDczBwUm1SQ1pGZmxLZi9ET0l5Tmc5eFd0cTlSdzVmRDQxS3pt?=
 =?utf-8?B?b1N3MUVoNUUvTWRpN2Z3a3Brbkg1MjNXYjZieFNGdUVPaXVLcTc3RjEvdDEx?=
 =?utf-8?B?L2xNMERzWWdUMWFkS1I4OVVBTThTeEVkNWt0SktYSzF0MmczVEVUN29aaEU2?=
 =?utf-8?B?TFpCSWFtTXQzbGZtVUd0cGYzZ1V2Vk5KQTVDRDhlM2pHUkRYVXNiclV1MWdP?=
 =?utf-8?B?L2RkVjdhdnl1aVAxQkNpV0VwUjBaZFE2bGRFSW9pbCtHZkxhN2czOE1vbWI1?=
 =?utf-8?B?V3hsdm9IWTlFeHdkcGtFNVF4dDh6bWw3TzNSR1lRajJZMXQvZFlYeUZXV0ZS?=
 =?utf-8?B?cno2RFNSRXoyc2llVmlSNm9rbmNRNHkyWFNaM1Q5bXQrWHJDSTc1V3dHL0tD?=
 =?utf-8?B?MEdtUk5obU56MHlmVEUwOVVKQ3V2SEUyMCt5WGZmeC9kdjdJbUJhdzczS1Jk?=
 =?utf-8?B?MEt4L21SdHRLSGROemRUc28wUXVlQjFMN29TM0wxV0Mwd2p6NzVDT1hyOHk3?=
 =?utf-8?B?bEdpdVNadURsdzkxZXpZWTBZRHNpNTREdjlhZm1YTjkwOEE3dmgwKy9WMlc4?=
 =?utf-8?B?TDdBRTNaVCtiSkt4cm5uWVI5OHJIeXM0cjdZVE5NVDlONFArcGwwVVNuYUJR?=
 =?utf-8?B?OVNZNGk3SHlwMWpsZUFmS0VRMDFiV1VkemlmMTdqSU85MGpMVXdlSnZPdTZC?=
 =?utf-8?B?eHI5WTN4R01Ld21FaUttSkhwSGdxbUVRRWsybzhmRW42aEwva3o1QVFOOTA5?=
 =?utf-8?B?cllJVEw3dkx0c3lxVjVydWpxZUt1Z3FQRXYyZUt6L0N4ZDF6WDZ3bEJKUUl0?=
 =?utf-8?B?aW9KK0sydjhyRzRlUnV5UnN4VXh1QzV4YzB0VXN5NVpDcnpjVmRIbGlxeWpr?=
 =?utf-8?B?Sld6eWo2WlFNVyt3YlJIcGRkc3BNczl3Ylh5ZEF5RTlBZ29RLzJwcEFmRGxa?=
 =?utf-8?B?WmRSZlhyRkxYMnQrRkJVRnp0SXZCeUJaK2hNSFF1Y3k4L0Rka0RqWFNXN29J?=
 =?utf-8?B?RjNEU3FtUHlEVm96c2xZK3h5Z2paYi9LWmt0R3J3ZkF2NjJ6V1dvbStmYWpG?=
 =?utf-8?B?aWNxeko5UExpOTRmRU05Y0FFQzdoYmxHamkrbld1ZW4zbUlUWi85eERodHJ5?=
 =?utf-8?B?bnpmd1BESXpOaUxudkNmdG4zeGVpL1BndzJXc0pLdmJ1WFZhaU0xaU5Xdmh6?=
 =?utf-8?B?NWNHMGRCN2NBN2pJaS92V0pSZTJjcktlVUhzSEFodGFBZGxpY0RXYWRpanNl?=
 =?utf-8?B?b3RpcEQranN5ellOenUyWDl2cytqdm4xM2JMc2d5Sk0wT3RBYVQ1SEpUYUhX?=
 =?utf-8?B?a2c5MHZaT2d0enk5S0xseDJORHFsZkhQRm5vT1ZEYUJ1RWthQWFtNkEyM004?=
 =?utf-8?B?M25aVElpaTRvcWhYbUlFOFc4Uk1ueWl4TGxLY1M4RDhJNVVqaGZCOHNrZnlu?=
 =?utf-8?B?RFBTd21vNDZTWEFFRE13eS9wQ1NvR3dmd041NmpCMWxqNFBmU2xZcDdJczVh?=
 =?utf-8?B?ajlaZHBDL0tEL1EyL1BzUE8ydVVDdGVxWmErZnoyUzlLQWM3VnBlVWg5b0Rm?=
 =?utf-8?B?ODRoNktUNTdxdmN0eTVXR3hIRmpoa09iSVFHVTAxWm10VTh3bmQzSHZvY3pN?=
 =?utf-8?B?VzdRbTRsbkppbittc1puak1RZEljVXV6UW81ejNHSEx5YkZ0Q0hvSllPcUZm?=
 =?utf-8?B?eHFnUU5LUW8zVFBHSERqUUNRZzBudWZTYlBxMkt6eEU2WlNYM0hJOTBFOTQ3?=
 =?utf-8?B?ZFhWbkhYUEk4ZTFhT1E5aFIxalBTNkJjcEwxWGZSQmZJVUlUTkw4Smc1enlK?=
 =?utf-8?Q?iRn6WbzBwnCLNgi2Pgl0Dak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3B0695F895C31478B015C204B44CFCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bfSkLASzKxQeleCGaUXm/2C9rC6kvEHSYV4/itUm48/UPQqY+jpdnRoF9o38NMD8sJT5eghf6nmW6YHi0ORZ8akoaGnQ9rX301opUAKQU9DLE6ElubD8G02dxQj+dAKwdxf/yn74bhsC1M8u0w+rRY5FhJuduKPQZcqmX5jGttigZGmxzJvoiwWCeKLUgKu5RFA3UA96+tty2Vg21P7D8zitc2IR0HfZxwJZ611nnLzMQF/dzl3+ZsQdGHncuJ3HgUZbwHVyLCuBEpUaTI+KdJ3qcf05JZiEGdGhEbfbv6Ep5OmuNKBoYo7xqhtrMQZSQJTWVvqpDrCa3goYxC81Cdm6OVTW6dtRiv+Y6/wuCleHDfQuJXKnJLFMCkmppbS2yIRh5tFq6ZDSenokoDy2+HzxzhRPyQ9vyuuUG7DKs2Icw49v8g6CWpBFVroqcIDn+qOaw6t9rIsdvHJoG2H7OBjlmPA2VH+vrrR9HpKWSqL11aENxLUpRHZ7Jro8pUT46HqAZR0Qa55Z5dRL5vlPaDY2JZaxxujddcecY7OLsjy+8GaHY8oAdKDbP/6gNpZvTw5S/y6YQhkw8Ug1cIoBuIGV/P6fC2dBMsq+bNNpNv1OaP9ICBZ9lnaW6fBEMyye
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8360caf0-7941-44a2-d439-08dd67cd13cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 16:34:25.4616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRA3I+o51JHpN+QNU2V8avp92rnutKnidEWoBCK/RF9Vv8+VvvcziW1b4HLPc8evyxxRz4A7+1nYzFLYFM1xX6YXxc3qF4qVKoa0eqeNu0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7710

T24gMTkuMDMuMjUgMDc6MTcsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gTm93IHRoYXQsIHdlIGhh
dmUgZGF0YSBzdWItc3BhY2UgZm9yIHRoZSB6b25lZCBtb2RlLiBUaGlzIGNvbW1pdCB0d2Vha3MN
Cj4gc29tZSBzcGFjZV9pbmZvIGZ1bmN0aW9ucyB0byB1c2UgcHJvcGVyIHNwYWNlX2luZm8gZm9y
IGEgZmlsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3Rh
QHdkYy5jb20+DQo+IC0tLQ0KPiAgIGZzL2J0cmZzL2RlbGFsbG9jLXNwYWNlLmMgfCAxOSArKysr
KysrKysrKysrKy0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGVsYWxsb2Mtc3BhY2Uu
YyBiL2ZzL2J0cmZzL2RlbGFsbG9jLXNwYWNlLmMNCj4gaW5kZXggOTE4YmEyYWIxZDVmLi40Y2Zm
YWM4NWZmNTQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2RlbGFsbG9jLXNwYWNlLmMNCj4gKysr
IGIvZnMvYnRyZnMvZGVsYWxsb2Mtc3BhY2UuYw0KPiBAQCAtMTExLDYgKzExMSwxNyBAQA0KPiAg
ICAqICBtYWtpbmcgZXJyb3IgaGFuZGxpbmcgYW5kIGNsZWFudXAgZWFzaWVyLg0KPiAgICAqLw0K
PiAgIA0KPiArc3RhdGljIGlubGluZSBzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAqZGF0YV9zaW5m
b19mb3JfaW5vZGUoY29uc3Qgc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSkNCj4gK3sNCj4gKwlz
dHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IGlub2RlLT5yb290LT5mc19pbmZvOw0KPiAr
DQo+ICsJaWYgKCFidHJmc19pc196b25lZChmc19pbmZvKSkNCj4gKwkJcmV0dXJuIGZzX2luZm8t
PmRhdGFfc2luZm87DQo+ICsJaWYgKGJ0cmZzX2lzX2RhdGFfcmVsb2Nfcm9vdChpbm9kZS0+cm9v
dCkpDQo+ICsJCXJldHVybiBmc19pbmZvLT5kYXRhX3NpbmZvLT5zdWJfZ3JvdXBbU1VCX0dST1VQ
X0RBVEFfUkVMT0NdOw0KPiArCXJldHVybiBmc19pbmZvLT5kYXRhX3NpbmZvOw0KPiArfQ0KDQoN
Cmlzbid0IHRoZSAhYnRyZnNfaXNfem9uZWQoKSByZWR1bmRhbnQ/IE9yIHNob3VsZG4ndCB0aGF0
IGJlOg0KDQpzdGF0aWMgaW5saW5lIHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpkYXRhX3NpbmZv
X2Zvcl9pbm9kZShjb25zdCBzdHJ1Y3QgDQpidHJmc19pbm9kZSAqaW5vZGUpDQp7DQoJaWYgKGJ0
cmZzX2lzX3pvbmVkKGZzX2luZm8pICYmDQoJICAgIGJ0cmZzX2lzX2RhdGFfcmVsb2Nfcm9vdChp
bm9kZS0+cm9vdCkpDQoJCXJldHVybiBmc19pbmZvLT5kYXRhX3NpbmZvLT5zdWJfZ3JvdXBbU1VC
X0dST1VQX0RBVEFfUkVMT0NdOw0KCWZzX2luZm8tPmRhdGFfc2luZm87DQp9DQo=

