Return-Path: <linux-btrfs+bounces-18035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E65BF0143
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 11:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6003B1B97
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B572EB87E;
	Mon, 20 Oct 2025 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P5sFrVME";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qgdBEPnl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCF1DF26E
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951032; cv=fail; b=kgMGENVXxfJTvZM4ySDx3zQCOjrf1vccsEUCfubUUfxjRANDeRLPBpV6kwNqJXszKNFGyV7Dt+pyfDh+KA/vJXQipGQNX1YZkZklctPpRbHu15vIG5HMmovNhYiU1tAhMF/FSohVVWCEijPgcCulsJeHSRNmSyCpn79183ldMqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951032; c=relaxed/simple;
	bh=OwvyV+15dlxf01X9gIz67ydDNSOB1ytJyoV/Z9nOc2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJ/vOnW1zsiLCllmny9YPo5rBpfDl1nBsBxdY4WZtk2sEYlPZfTlUw26xzfsN+tMFF4stxArWB5Zni7DAxXy2cuCtXY9jGVY/rYib2mIpdmoVAcuyZCBtG1CrTijZiRfXQ1WCiDb5REZcCsr/HpX36HVjKGdyV2eI9sr0B5pOKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=P5sFrVME; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qgdBEPnl; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760951030; x=1792487030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OwvyV+15dlxf01X9gIz67ydDNSOB1ytJyoV/Z9nOc2g=;
  b=P5sFrVMETkoeYf5SSZHXy6/l2wPEJUwfn+cOe4g7MVrNlzTzXkFGlAWR
   fNgNQDaM3e7EotaWyAlvRtvlo0Q+pWtHXnHebaIYxDyKGMVZlcHUO/Wlh
   SUyL0/q6hSDqLvD42mpJHTw8GbSReDYJICdgsa3OMMZEO+CHFf8O4O3kl
   pYWmay6uxKZl16zjOQ1CesotfRrptC4R95eS5O3wvKH/6yk7XRRw9Dp95
   1rMUt1BFrZ+mNOtcNBkdpCSlPNsXXRDyyhrBnhJUEesdRPQha4PCsFo+w
   PUrVRxEH7miDu356mSIlv8iefBvTYdy6mrYm2k8VWjd2OQrZUxxdd5J5Y
   g==;
X-CSE-ConnectionGUID: V/JkY0/NQfC82V9F5RJ6Xw==
X-CSE-MsgGUID: +o9Cmxg8TKmysB/+9GnLDQ==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="133561013"
Received: from mail-northcentralusazon11012031.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.31])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 17:03:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFrLWvU+a+3hEW7wJ6Jokc1TTCk2c1cy3Cb40JbAPcdbcqJ95cuzoLVfERhA74LKlQit9EXHWuGsCk89H2ox1ReVGOYe8lS6o0f3FmN4m89Ss4fTAomzcNG3CzrE9Br6Cj+Uq5zfmcgxidEYnDUTV3xDZXEFNfVPNmkApNXeIZcT5iynFHZztbYcbRZ46l8KylVyKFsF1OpVnoC2v/BfObaATSWBidl7Y6idBhvms0KdPMsCxpiyGEq0nvqx4tq1iGRZ7T5dFEr9v/4+rv9FFgqdA+mYRUq9NJ1aAdx6lH/rTOQzWGTc33h0G5kswkzUYkPXaWD9MqhtgfXBl7Y5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwvyV+15dlxf01X9gIz67ydDNSOB1ytJyoV/Z9nOc2g=;
 b=TSnx+8cRmZKNn0xeIb29QzPlILPZ3Dmnrk+vgqQqs54DnxMQCs1sHXW/li8cOPIVN2mOWj1vo2YGLnWZlpbOYhvbg/Eg63itfPnzSyFCU/gBLhqnHpasewLhtIIAz6o7g7MqhlBUlmlqiIoJWrHnlyVyFlVWLvgzA3Ig+G03CzO9UYAFpGDL+nxDSHc0humdb1IartWGuVJGrU9zwr4VFLb6pGtNz8ca4ei8WXBkHvHpEKvtWrfB0gBgJEF6CBFWbs++vUrlU6P8NklFEtNBGuIykgNvoYWiGv+pnXbRfVb1DrXf1i0jWsUY+o2BBDinzJDRC92P+hGNxM5mULblpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwvyV+15dlxf01X9gIz67ydDNSOB1ytJyoV/Z9nOc2g=;
 b=qgdBEPnliPDcFYPD1KyMCCTu7LOKqxjz019uavnYBU3LCokYTZyuI4novzWfIDsmi8uuW98xfKuFo67li70FwfpsIKDEHa2vWemIQkQG+dg3eZqfwShFoy3Eeh94lNybfT34bwWXyvw6sJ+mmPcRtS16/f2kHjxF++VVWPIOZOw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8527.namprd04.prod.outlook.com (2603:10b6:510:290::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Mon, 20 Oct
 2025 09:03:40 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 09:03:40 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "hch@infradead.org"
	<hch@infradead.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Topic: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Index:
 AQHcN1KpeH78g9jFR0y3xmj5UbrnxLS2iOkAgAE6w4CAAAEpAIAAhrUAgAwao4CAAgBTAIAEa5sA
Date: Mon, 20 Oct 2025 09:03:40 +0000
Message-ID: <DDN114YEC76E.3B4M7405BCBD@wdc.com>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
 <aPCXz7ktsyE8BLeG@infradead.org>
 <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
In-Reply-To: <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8527:EE_
x-ms-office365-filtering-correlation-id: 4ec8162e-4aa2-41d4-d61b-08de0fb7901a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnRvdmppUWRCOHBxdUVEMEFYK21mNFgxdkc4bDBEbnZWeWFLZ0NxL1pyZ3pL?=
 =?utf-8?B?bjMxSFBTdTZZcGpzN2xneWtNWXg1aTVFU0dwV0djd0JoMmtLbjlwS2xkZ1lZ?=
 =?utf-8?B?c005Sm5YMXZDbjk5QWxrUTRNMjZleC9zL244MmVqemhKVHJKMjliUjB3Zk0x?=
 =?utf-8?B?bFl6MEhnN01Ja2tRTlNyUWVwWkZ3SWFCcWJ2RGw5eVBQN3pSRmpTUXJYUkQ3?=
 =?utf-8?B?YmRPNjcwb3RqRjZwbHYwRndqcjg1MUdqMlBsdE0wMVFnQzNIZ0cxamVBODJq?=
 =?utf-8?B?ZjJkSTZlRTNZZFdZa1h4ME5qUDBDcG9Jb3M5SmpxMWdYMFYvVnRnakxWVURE?=
 =?utf-8?B?ZzN2N09XS09qMTFpWU1relBDN09uWmIzWjBlTXNWZzAwMUpldUlOQTdLZG85?=
 =?utf-8?B?QnVsY1Mwb0E2NzRiRFFxRDdJSE5RTjVpVC9pdk1mcTIvQWpLS0xFUmJNQW52?=
 =?utf-8?B?M0Fud3R6alIrOXc5YmowN3JkcXc2QmxsZlRUaURvTVYyck1WU1R2bHZTNExN?=
 =?utf-8?B?ZFUrTGF2VUk1c3l3TUFKZ01WZ2tRaDNTaHhtcE5qOW12VUxQbFhWOVpXalVD?=
 =?utf-8?B?ZytZMnROM0hRbjJ6b0NCK1kzRjdLNmZIRHRxSkFXU2thSng3YnFmNTRCMWtJ?=
 =?utf-8?B?MkRqNFcxc3FVUHRNeEJ2MVNHaU1QMXg2WTBDTmg0cVRJODgxQUVaV2FNQjZK?=
 =?utf-8?B?Y2o4Vm5mblJjSU5pYytQYmJjQThDZ0VPNUpLUURwdGt2Uk5mOWgzZ3N4eVIw?=
 =?utf-8?B?d2JrMDB5Vnh4ajNYMEpZUXhoWDZCWCtwdS9XOUllbnZHZU1vVWtlcUUwRUtI?=
 =?utf-8?B?MEVVdFVzdVBTNkRuWHppWjljTTk4aHpoekMvVFowRmdmaTRlMjN2bUc4c3V4?=
 =?utf-8?B?VElMT3hxNFhEVDRsbEJkamZqNHpRZ25GdEpKYzlTWlVmWW5XMTQ3TlNLYkJi?=
 =?utf-8?B?RmVUdWNsK3lQbEZnSTFibnJCRi9oT3NYcWZNSEFsSFMreHhwZi9DRm96ZUdS?=
 =?utf-8?B?NXVQMXhZdlJiYncybmZXbzhiZldpQitJaUY2emVTdEoxVTNjUnFFNmhrVHV3?=
 =?utf-8?B?WUpYbEJHQjlEVjhlSWtJdDhTWlRDNEJFUlJTSkFISXQ0MHBmbDBoZWw2OURS?=
 =?utf-8?B?VjZ0YWUxYUhINGdJSkczMWRxK0ZIdXIzM2hlS1VOVG9XM05iUERVR0hOVW9P?=
 =?utf-8?B?VHZMaXlYT0ZwKzVQRXRudG00aVd3L2RnSTQ2T1BmOWp4S2NkSjdQNjgrLzl0?=
 =?utf-8?B?R1oxQzY4Z2xuWHpZdEMzbHVWOGpXYTlzRVpkbkdMcDRqUXIxeHN6endTQ05a?=
 =?utf-8?B?clp6cDB1dGF4V0VtdEdKR3llL3BwWktTYTg2QWwyamYwc25leENDSm9heFdK?=
 =?utf-8?B?TjA3RWxZbk1TT2hDVHZtandxRXZ6STc0NUdSQ0JJSFQzZzhweDZkSDlYU2ly?=
 =?utf-8?B?WTQrU01IWG01QVJtNFN2dmFYcXU4TEdLL3ZQL2laNm9xaG1veW1PTDdxYmxU?=
 =?utf-8?B?L2JsOG51d2FndVlPTEROd1IxTVJaRDBWYU9LR1NuUGpjTjhiOVdHUEFWcjFZ?=
 =?utf-8?B?Y3pXRjA0T3ZqMk0wa0swbWVlUVVLRFJ3eEl1WDFJRUEyQUFaM29XeGdubm9r?=
 =?utf-8?B?SDRlUUNUNUpJUnd6YkJsc1FFQitUMEo3NGxYRVdXNWhKaDhEME1PbDNZdERh?=
 =?utf-8?B?RHRoOHlnRVhEc3NscFBOdXNGTUgwZGlSdWkxVEJTbVdjYWpXaDJIcllsbms0?=
 =?utf-8?B?bUtsbEoxMmo0d3d1WkppQkZleUxBbkZONStKYXd6V3Fnd1R1VlBLL1NENm1s?=
 =?utf-8?B?TVV4SUY5cU40cituNHVUTHlGSFZDb2xNTmVyVWhna2NST1NORitxSlcrQ2sz?=
 =?utf-8?B?TDFrWXhoMHNTY1hSUndMKy80RDZSaWVoRk04RHc2VmpUNHJuQkpzU3RMWGJp?=
 =?utf-8?B?Y1NXZjJWYkRlVExTMjJXeE9oSXBCZlFvSTJCL09oUnBqK1FkbWJWaFoyVkRs?=
 =?utf-8?B?V3NpMGdIOW9hUW9MWlFHNGdTeElYZVFRb3dTM2h2azNPQ0RNVnQvYk1QYUhK?=
 =?utf-8?Q?GfIi92?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGF4M0ovWjBFeHFpZWtTSC9VeUc3Tnpic2tET2t4UytPc1JQL1dHMVpjT1d3?=
 =?utf-8?B?YzNZTHpQOVVuZmtwSzZEYTVqWTZqZWpzeS9KQmtuSkVBeE9GZGhpVjFTOXcy?=
 =?utf-8?B?cEJRTzNMM0tTUVd2QmVtSTZDZUlURis3eXlFOWdnZEFOMG4yK1B6M3NoNGxl?=
 =?utf-8?B?alF5ZjJyU2o1Ly9lYkh3WHhkUm91YUhLOFE0N1NZN1Z1TzN1bHprL0kySnJw?=
 =?utf-8?B?M2RQUWcrRzJKSTJocG5TeXh5UmI4MTRSbzExYUFUWWRTQ2xtMGhiWW9aYUdP?=
 =?utf-8?B?RGl5MCtPRzA0MVlTRGZUck0zNVhZSWJBTU5CcHZZZFlmRTM0K1dtZnB0N1VD?=
 =?utf-8?B?bDZDSUZBc3BYMWx4RzhkWFRIWjBsNERkMFNBMURDNVZ1S1NvQm5YTGMrMDAz?=
 =?utf-8?B?NzhJWVpwUXh4UTNwdkRVbXRZVWZEaW8vT0ZNbUlSRkREcmxtemExR2NFUDRp?=
 =?utf-8?B?NE9NeHRTT1FDRmJ4SjVZdVhpTDlBNTdmS1UrUS9tTEdDZGdCMHJjaWx0MGg0?=
 =?utf-8?B?dUNDTnFiUWdmMTZkM1E3eStHelVOQ1dPa0phZFdsaGtwR3pScEtjQ1A3QVZh?=
 =?utf-8?B?WFlZTGpuOGZDd3hlY1d1NU5zSHZoMmJqYzFiWk11RGl4cVhLbGlnLzNpbytp?=
 =?utf-8?B?STdsN25SWEdPTXhCRzdwL0RlbnVZVVJuZEJvLzNaSW1KMGpvcnRwQkxQMXU2?=
 =?utf-8?B?WVd1cm44R0Q0d0lKRkFzc08yaVkvbE9Ia2FHV2NYUTVIOVkvYlVoOERTbm51?=
 =?utf-8?B?VUp4a1RuVGMxSEJNNzJ6akdNS3dMYkRMWkdEbklGY0tuL1dzZUZZamVPOS9E?=
 =?utf-8?B?NDlWbk5ONXBjdlVyS1FnL1pUT3VKdm1WdTJhM1l1Q20wOThpRDBVdU5aUTNQ?=
 =?utf-8?B?aWxRMFFZMzh0YlR6azNTLzdxblJPVkJhMGFmRGFsZ20rWDVMaUJkdDM5Qkdy?=
 =?utf-8?B?WDNEbDQ5QmhYTU4yVHByazVmNnNyeDRJNlV6TG5WQ2tNZm43dmxCZUtQa2o4?=
 =?utf-8?B?RWlkVmNQMUFOdHJ0c3N5QU8yQ0pFLzlTTkZTKytPYjROb3I1cE1SQlo5dHJz?=
 =?utf-8?B?ZS8rb2RIU2NaMTUxcGtjQXhKZW8vNjF2QmVJU01OUHlnWmd1QmlVVjY0MmZ5?=
 =?utf-8?B?dmtuUW9XS2wvZGIzNm84TzFDVUVPem5qVm0yRW9OK1l6QW5IRWxmVDcweXlh?=
 =?utf-8?B?UkFUS3dyS0NvUHFLaEZRcnVmQ01DQmlCREN2ZFpDSXE3eUpjeDN6dXcrVXlp?=
 =?utf-8?B?czRmS25sR2RMdXFIU3BSbFBrSDNTU0I1T0s4SlNJSU5NU3p4V2xPL2JaSWIy?=
 =?utf-8?B?ZGQySzA5MDdUdjRqcGhRc2VsUVEyaWE5elpWMGdONTF1ZTZxNXZtVjhsVjg3?=
 =?utf-8?B?bFY5eWEzSkN2eko4d0dQRzBjaXdyZmErNm9QeDk2amRiRng2MGRJZTh3ZmZZ?=
 =?utf-8?B?UXVST2p4aWdacnAwRnN1M0dqeXdNTWcrSnpjbENJQys5cjAzWDFYWGxHSWxH?=
 =?utf-8?B?Y2ppd2JXdUZodzJRbDBsVkxOUklKc0lSRFNncWVmU05Qa0lqSHZYVnBOQit4?=
 =?utf-8?B?M09yRHU5RnFCME1TYXNxaWtYcVJQcTdoam0zZUtIZi9VUmdWNnZwUWplREVK?=
 =?utf-8?B?d0thWURFR2M3amtOa1NYamhtNzRZOXlPcFo5TnBSaG1hTjBBZFQ3S2dPWUha?=
 =?utf-8?B?WDh0d1NSdEhIM2tKbEN1Rkd0aTRaaWUveXhMUUcwRFBsRmFTcyt1eFBUZWFH?=
 =?utf-8?B?N1podDJMYTBWNjJMaFVhemVsYXBWTGlPYXBFNE4xRUM3K21BemVlVW8yWGI2?=
 =?utf-8?B?SlFIYzU5ZGRpbWNyOXY0YmFOWTR6d3hJWnZOVDFFV1VMRGRuWmlBb3ZCZ0ov?=
 =?utf-8?B?L3VrR3BqTW1MV0cvT0VENWJIcDdCNE04QktXTDV0WHlXKzZKWDNKWkxRZStv?=
 =?utf-8?B?NVNkbVd1aHBWQjVaY01sekVKeEtCdzc2RS9ibVFPTFJZdzAyeDJ1WXp3dGxa?=
 =?utf-8?B?UWhGQkEzT0dET2dIMUxKR3cxZWVIMjlrSlROQnN2U05OdTdsU1QxSXN4ZTlq?=
 =?utf-8?B?bTgxTHA0WmwyVStWTll3NGozMDQwL0FiOUM1M0oycWg0M3lDV2llNVJUdXRZ?=
 =?utf-8?B?Z3kzMmdYZWtBRERBK2pGVXFZa0NneEtaS2duRnJxQ01VVDdYUTZCeXFwQ3Jq?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <826533F338C5244395F0CB6985D23F76@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oxi+5R67ksqFjvY0de9NDOqGERlD+uareYZ/6XqRh4WdW5Q1kE6oy/PUKYNYb5xlBCSvfT2wMpdNOkCAAt4GBtwXIuKXgMUZqQIrtdgvb8XXQGsS4knFb80jZmsKr7VgRUfeEOFbhTdKmYTemj283N8mx5haHIo6PCFdpxa5LaRXNOmDmbvVFOvOhEh4HN1bYXe5++OlTXPrbMZZSUgcTwt6dQ1+It1KBTNk0wr5rS2EVfM/kEA0kxuiHEM9nLvIRxYKieNNemaasjAn8pxDp9cZmFoVJomb8wPQ6V2z7j01DGBnoOBwmIZOaNL3MHunv1I6SsP9ad5OGN1e+yKumZwqvD5N48HoHE6bczl/tMUKwA7S6rjwVZW+zXgoqwETHY0xZBjsAfhSYvb/HmlkLyqE2j1RtojwwTAkPeYm53I1hUlQcKbOipeh2X6367e0aZL2zTBG15tP4VbeQ06wY9n+yuWNkq+AwzUbXhHVvRsN1WGYUI/7YpLaqPAey+qAY7nWwkI/0/MEvf4QNpg5mUonr/SsM7eIqkQojQs1nwvBZq2KYm/b8U2FRhms1erR3VqVQAPb4MZ4hBCl377jp5UL5sEj+wLS8PCsX5yRwwTLDgw/tsbapPQo8bZY5N3O
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec8162e-4aa2-41d4-d61b-08de0fb7901a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 09:03:40.4174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ktO0h5O2kDLOh1kvpdEfx7w5u5AMjtN02UFPFRVeIk28ZHVEaoypy4dmWMhq+awYjlMLKHerqocE91kgnHUYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8527

T24gRnJpIE9jdCAxNywgMjAyNSBhdCAxMDozMyBQTSBKU1QsIEpvaGFubmVzIFRodW1zaGlybiB3
cm90ZToNCj4gT24gMTAvMTYvMjUgODo1OSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+
PiBJJ3ZlIGJpc2VjdGVkIHRoZSBoYW5nIHRvOg0KPj4NCj4+IGNvbW1pdCAwNDE0N2Q4Mzk0ZTgw
YWNhYWViZjAzNjVmMTEyMzM5ZThiNjA2YzA1IChIRUFEKQ0KPj4gQXV0aG9yOiBOYW9oaXJvIEFv
dGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPj4gRGF0ZTogICBXZWQgSnVsIDE2IDE2OjU5OjU1
IDIwMjUgKzA5MDANCj4+DQo+PiAgICAgIGJ0cmZzOiB6b25lZDogbGltaXQgYWN0aXZlIHpvbmVz
IHRvIG1heF9vcGVuX3pvbmVzDQo+Pg0KPj4gd2l0aCB0aGF0IHBhdGNoIHpiZC8wMDkgaGFuZ3Mg
MTAwJSBmb3IgbXkgY29uZmlnLCBhbmQgd2l0aG91dCBpdCwNCj4+IGl0IHdvcmtzIGZpbmUgMTAw
JS4NCj4NCj4gSSBzdGlsbCBjYW4ndCByZXByb2R1Y2UgaXQuIFdlIHNlZW4gYSBtb3VudCBlcnJv
ciBhcyBmYWxsb3V0IG9mIGl0IA0KPiB0aG91Z2gsIGNhbiB5b3UgY2hlY2sgaWYgeW91IGhhdmUg
NTNkZTdlZTRlMjhmICgiYnRyZnM6IHpvbmVkOiBkb24ndCANCj4gZmFpbCBtb3VudCBuZWVkbGVz
c2x5IGR1ZSB0byB0b28gbWFueSBhY3RpdmUgem9uZXMiKT8NCj4NCj4gQE5hb2hpcm8gY2FuIHlv
dSBoYXZlIGEgbG9vayBpZiB5b3UgY2FuIHJlcHJvZHVjZSBpdD8NCg0KSSdtIHJ1bm5pbmcgdGhl
IHRlc3QgY2FzZSAxMDAgdGltZXMgb24gbXkgdmlydG1lIHNldHVwLCBhbmQgaXQgYWxsDQpwYXNz
ZWQgc28gZmFyLg0KDQo+DQo+DQo+IFRoYW5rcywNCj4NCj4gIMKgIMKgIEpvaGFubmVzDQo+DQo+
DQo+PiBPbiBXZWQsIE9jdCAwOCwgMjAyNSBhdCAwMjowOTowMFBNICswMDAwLCBKb2hhbm5lcyBU
aHVtc2hpcm4gd3JvdGU6DQo+Pj4gT24gMTAvOC8yNSA4OjA3IEFNLCBKb2hhbm5lcyBUaHVtc2hp
cm4gd3JvdGU6DQo+Pj4+IE9uIDEwLzgvMjUgODowMiBBTSwgaGNoQGluZnJhZGVhZC5vcmcgd3Jv
dGU6DQo+Pj4+PiBPbiBUdWUsIE9jdCAwNywgMjAyNSBhdCAxMToxNjowOEFNICswMDAwLCBKb2hh
bm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+Pj4+Pj4gaG1tIGhvdyByZXByb2R1Y2libGUgaXMgaXQg
b24geW91ciBzaWRlPyBJIGNhbm5vdCByZXByb2R1Y2UgaXQgKHlldCkNCj4+Pj4+IDEwMCUgb3Zl
ciBhYm91dCBhIGRvemVuIHJ1bnMsIGEgZmV3IG9mIHRob3NlIGluY2x1ZGluZyB1bnJlbGF0ZWQN
Cj4+Pj4+IHBhdGNoZXMuDQo+Pj4+Pg0KPj4+Pj4gTXkga2VybmVsIC5jb25maWcgYW5kIHFlbXUg
Y29tbWFuZCBsaW5lIGFyZSBhdHRhY2hlZC4NCj4+Pj4+DQo+Pj4+IE9LIEknbGwgZ2l2ZSBpdCBh
IHNob3QuIEZvciBteSBjb25maWcgKyBxZW11IGl0IHN1cnZpdmVkIDI1MCBydW5zIG9mDQo+Pj4+
IHpiZC8wMDkgeWVzdGVyZGF5IHdpdGhvdXQgYSBoYW5nIDooDQo+Pj4+DQo+Pj4+DQo+Pj4gTm9w
ZSwgZXZlbiB3aXRoIHlvdXIga2NvbmZpZyBubyBzdWNjZXNzIG9uIHJlY3JlYXRpbmcgdGhlIGJ1
Zy4NCj4+Pg0KPj4gLS0tZW5kIHF1b3RlZCB0ZXh0LS0tDQo+Pg0K

