Return-Path: <linux-btrfs+bounces-5738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA49087A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 11:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBF5B22439
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299E192B66;
	Fri, 14 Jun 2024 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Om1ukZHg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rMrSoElr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA71922DD;
	Fri, 14 Jun 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357806; cv=fail; b=CgaMhDTeiINMleRvTWBwB/X0eybwhrEQWl0UrqTN7ZD7e61Flurv7zDCqgBcwnwrcMYNXl6vAtuni1m+V1Lqu980OvBVh5srR1cb4Op4Cn+kPo/eWjfTE/ac7OEVSyFkmxCwfvwzIcUH2/uSAmbqVfA0Jb5fjdqQoHLLfbFvsqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357806; c=relaxed/simple;
	bh=UsZGCoUn+7sYjmT/dOKNvYAU/2uXRFqMI5OEiv8Jf5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HuXCvSml6UUxMk2oi23SOH1qbUMJDrc6virmxsURAOPCOPfQUE1NfPja4e/w5IIfYB+AB89RHevDSmoJgvv1TxwWIozq65VeCPwIsdei2B1oksqJupjGMdx+J9bg7BQ1vBkvL3DNMkxJ02fin9SHkDO8IjOMKPSyM7vGJeq9Qt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Om1ukZHg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rMrSoElr; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718357804; x=1749893804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UsZGCoUn+7sYjmT/dOKNvYAU/2uXRFqMI5OEiv8Jf5w=;
  b=Om1ukZHgXphd0oB7EgtrO2NFIMZY12VF8d7sZM6I8GF+ybxJZZMr9hos
   OxUSwbMH0iqUiHX8cQgBtFjirXXZMeYotHOIbZ+AI4G2TzIunnJ50synF
   ApItTkfO3Ohd67GFlypKBoH1X9XjrJNEfqce5D3MceL5vf2hdZKD9CDsu
   xqZxqzmDKDGktveKAHFuvuQ8eXiQ0uo0rWedd6KxEpGeIddlx1QGJ45iH
   5SyKx0WoPy6/gjFY/jtMLqychFPNwMR4gQ4CDa+oZ5614PNkqxlghxDDb
   uKUacz854smXSLHpo4jckjyP+hRG/r9kP/B7mw7errXMp54CFMN+T13rM
   w==;
X-CSE-ConnectionGUID: YJTPCaCrQWGfuV1FUaskHg==
X-CSE-MsgGUID: p8v8y5ZDS7a8RhfKXTnMRA==
X-IronPort-AV: E=Sophos;i="6.08,237,1712592000"; 
   d="scan'208";a="18373446"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2024 17:36:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnwofdrJjDm50qXVVonYpHz6TiGJv+1EOa0yXMDv1O7ZypQ1tuS4S/DqBP89znbFoTSOepSr9GoMlBLkjCIL5+Dt5XgBd8ZNh9uMSOjKmSY5X0R/06DaPfJ3VfVpS9rzLbk72aFS3lXKSB02t7ZysDyhdPhSx4kn5Y3xFugDJlHv2hKAhr+UCu2TN3W7WyMJIxRCkAJlpU6fpU9mqkg+LX0Lvtp1XtMItUx6uy+WEvrp14BDE9oTSWDdGjhoFVLmY7H2n0W9F2dW50BePFwPZbyMsIpOf7aEL0rvV0WrlFW9RKQyevJ1FTyojrGbOQYg+yYL1EsBzyQXP9S4wE+AZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsZGCoUn+7sYjmT/dOKNvYAU/2uXRFqMI5OEiv8Jf5w=;
 b=hXGXynSG7ka/1QotzFLd+YJzbHB8zXYluzYn4CMLFBvqh5oLvpJ+TwBfaixxn2lpeUtIFCgUGVpEZ+8pdrh1I6VYt7TezMa0a+rm2eB/N8VcHqgfIpGMjo5VOo9bV4ty8ucvoXfLNeAGFeblBYNf3bk6Qyf8kBHEeb3VUMlWrOfuJUnJv46ku0/ofrsYywR9cUrktPfRYFYeNioOE5Lzs1D9Q6gheqiPZjX4vOwHC589pTevk0ixXf/4zKr9J5QywRRnDGMk3tuFS++NIpcj0le99lJgpfiGJeCOQr4CxR0X03TRsOtrG4C8tXZjlo5I46K9c07btSw9apwrQtQbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsZGCoUn+7sYjmT/dOKNvYAU/2uXRFqMI5OEiv8Jf5w=;
 b=rMrSoElrReyImS6+nctOxRII/1k9c9z5UQEMzj2cDJAy2/DuNHqU8z2dV2YFkT3JG44UyQNE3oMLry0UYTfugS/t+RJTquYFy9Iqeta3W5ptvHyjROl63ut/m+C4//DYvQcFoqwxJ80NTaxAtYQDwhCnbto0W+CBe8xIBAtMN7A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8516.namprd04.prod.outlook.com (2603:10b6:a03:4e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 09:36:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:36:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
Thread-Topic: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
Thread-Index: AQHauxHeASfDcWxbXUu31/wvl5H+ObHCo3SAgAAgioCAA3XSgIAAzLwA
Date: Fri, 14 Jun 2024 09:36:34 +0000
Message-ID: <d6cf3e45-aaf0-4256-92c1-bb8780c76da2@wdc.com>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
 <20240611143651.GH18508@suse.cz>
 <c7246728-aadb-4699-8fdf-060502c1092a@wdc.com>
 <20240613212347.GB25756@twin.jikos.cz>
In-Reply-To: <20240613212347.GB25756@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8516:EE_
x-ms-office365-filtering-correlation-id: a86228cf-d472-448b-12ea-08dc8c557b57
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWl1cTZZYTRmWGltbWM0aHJ2RGNhcXVyUHZGVXFHTEo3L3hXTUluSTVBRGFt?=
 =?utf-8?B?ditpT3BKemd2cVFrVm0ycXBOcjNmUXJpYmdvbDNyazJrb3hlb1YrRDZndDRw?=
 =?utf-8?B?azE0RlNwU3JmRTdDM1ZWZnJUUWEvcHp2NUNSMDc3eUxJcFBDUW5ab1BRMkM2?=
 =?utf-8?B?R2VKUUtNZUpXc3F5c2ZCN0NyZ2JZaE1hbUdYNHlWMWN1NjExNzdGaU5NN0lO?=
 =?utf-8?B?NUt5eks4U21oR2J6Z3ZWSUNBNFNSSHhCNVdDTllCdzRMK3h1SnNJTWJ4REJu?=
 =?utf-8?B?REU4WXlZZEN3Y2ZOZ2VIUkRLQ0ZSVFFaVUJZV1F3WmFyYmlaUXJJSTJha3Ix?=
 =?utf-8?B?N1B5MUw2NzhwOTY3ZHJEeWZJS0taS2pxQXFkY3FzeGNnbUVzeHBiWHVRK3JR?=
 =?utf-8?B?UmFIamF3NHBBanA4Z2czMGFnc0xjZ0pHRGV1dGowR04rMVE5V09qYmFLOTJk?=
 =?utf-8?B?UVRqYWY0YnVZV28ySFNYR1RJaGI4RXd0aEVrczRqcGRNdkh4QTZqOFFjSzA0?=
 =?utf-8?B?WHBwSHYxT3hVcnZaZTdzTm1TUjQ0aUgwWWdRT0NYUkswdHdNejhsSkhqZkxh?=
 =?utf-8?B?NU1zTUkyTGk5ODR6YUJRNVVsM0ZFbmZoa1BraXF3U1NPTlJtK1hJY2xtdjJQ?=
 =?utf-8?B?eHBtY2k0NFFZWmpZbDNoYzRObnZQMTMzRW5mZmpSNS85Vld5cEhiUktyUHpJ?=
 =?utf-8?B?UTBWOFhpV0YwbmdZSnVtT1dnNHNGZU5pS2FQbTdaR28weGw2bGloU3pabW1D?=
 =?utf-8?B?ZUxTSjVVWjV0bE1XQVJ0WGVpSTQrYmI2UUVZdU94S1pGVUNqYlc1WWZSRTFh?=
 =?utf-8?B?MVRMR09tazRBMWZPYXFWRDF2VFcxbEIxM0pIMi9QSVl1ZHZZNW40ZGI2dFVD?=
 =?utf-8?B?cVRaZkpqYmhzK2xBNTE3R3owNGh1bFd6ZnRvWEVrU0ZhSmU1L0QwK2VleU1t?=
 =?utf-8?B?TGlFclY2S2dvbjYvUEdBaXhYWmlxY1YyNVhlR2pOeXM2dE12QnkwK3hBcVl1?=
 =?utf-8?B?N0FZUDlVYkk1WGYxZ2NWaHNZT1BEM0ErbzlVN2pJc3MrZFJYU1NDdFJBR0Nr?=
 =?utf-8?B?SXEvK1dGTzFrL1pYZnlMTDlMaGpnalkxRDkxYXIrQkdVYTFUZlVxNURLTS9O?=
 =?utf-8?B?bk9xWWlhSXIrWmI1NVpwd3VIdytCNkFPM1Uyc3ZwQ1JvcGRVNGxtRXJ4ajFN?=
 =?utf-8?B?dVpUV1pnRTJpcDl4OGwvNUtRbExsUDBQSjdrU3pqS05wczc5eGZYZWhqZU9o?=
 =?utf-8?B?ckZOSFc3WFdKaXd3V1ZrNU5IemFSU0pjSW1BTlZtb1haemZlR1dKVzFxWW9u?=
 =?utf-8?B?NmZzeDBMTklIakROOTNzb0Y2MmpzMEJvblgvVEhDVGFRektjY3lGV0pZZTJZ?=
 =?utf-8?B?d0lVZUpWNW9JemFCTG9MMC9CK0ZJU3B2Nk9tZmw0Vy9pejVQdlR4YzloTVQz?=
 =?utf-8?B?VHJyVEhKbVd1eHJNajZnVFFPWDJKbmYxUWZUdEtuaDJBdzBleUtyVlBzNVZ0?=
 =?utf-8?B?Z3dwR1ltait0YzMwRzg3TnlMNXBLZ3pZT21iN09vQWJHNEdKMWltQmI5OVV1?=
 =?utf-8?B?ZnY1QUpDSmVyemVnQko3S0pHcEFqSEpib0FuemNGeWJTTFhhZDlCVXo3Y1pD?=
 =?utf-8?B?bjFqM2xrNk9ZdTNvZk1HSlZEUkt4Qjd4S0xRc01MVS9JdXZhamdKMTZ4cWlK?=
 =?utf-8?B?aGYzNFNJVVR1VTNXU1lNeU4rbWE3M2tXck1UakpxRzcyUm1DWWxQejJCSCs5?=
 =?utf-8?B?RVVKakxxa25JVlFwTVR6NE1aREhyRUk1UUh6eHI3ZTRObS9OdlorNVZ1dkZq?=
 =?utf-8?Q?hrnHesJ4+VIuQnd8TuA70cWRlj/TXgWScSFV8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3ViUUdKbUVDRTVDNXc4cytzd2cwZG5PbU9sZTEvb2RNTWVWUHVickVBcXEz?=
 =?utf-8?B?OVJVdE5Zd29COW5Wc09yelltc0ZnMjlwL3F3Qi9pcEZwWTlDTERTZGFNT1I3?=
 =?utf-8?B?MU1DbnFPZDE0ZWZ0YTZ3R1hVazZWMStnU3Y0R09OSnp2MEE3Y1d3eEQ3bU9m?=
 =?utf-8?B?SU9IN0pqSUtvcC91dDVUK3V3TWRWUkxPME9SVzRpT3E3cGxLV0FZdks4UEdl?=
 =?utf-8?B?LzA1bTlTMGFJWHd2YUpqWjVtcHlFU1dwdzFhTHVVVW9mbW83MkNvNmlKUlJS?=
 =?utf-8?B?THVoVWw5Q3JYcjloZFhFZXdYa1VheTBmMGg3MWtkSEtBRnR4cVo2bWhDell4?=
 =?utf-8?B?KzRzRzVlM2NubjlHZEgxQys1VEtWMVhneHJXQ2VXZlVBNWlSSHBFNmV5WjY5?=
 =?utf-8?B?Y0owM1FpeDcwTkgwbW9vVFlBejN4Z0ZXYS9oRHVlak9IYTVMeG9tY0I2SHdo?=
 =?utf-8?B?K2ROTml5eHhwUkdUWlF2RE44L2V5RGZHWlBNV3VCNjNPWVhTTEg3bnZlN2VN?=
 =?utf-8?B?UkNFSHl4QjY0dEp2Ky9WTTBpcDNPWkF0QWhWQ3A5bGZKMHlsMGp6UDF3MWZZ?=
 =?utf-8?B?MGw4ZXRsbCtPa0IyQW0wQjM2dk9wRUYzbHdaQWVhaXpvVExvQWdaRXdVWncv?=
 =?utf-8?B?ZkRuUkYyekYzL3BIaW8xTWJaUVhRcmEwSnE2dWx2bXFPZ2Z6bmtKeGZYdjBX?=
 =?utf-8?B?eS9DdkxWeVl2djdyZEkyK2VCYk5KVFBJMkRVd2lqTURqcml2cjVaeWhTNWVY?=
 =?utf-8?B?SXN1ZElnV1VGTHVlS01hbDJydFZBa3d6MW84b0V5a01uWGwvdC9vSE9oOGRk?=
 =?utf-8?B?WWFnT2hwWkJQT1NMOFVCQnVQWndXRmRQa1VBNmJ3dnF0a3d0OE1wbWU5Z01G?=
 =?utf-8?B?NUdCUExPa2xLV0FkdmNoRXRkaGdvZlpYNE5LOTRabjAxdU0rNWRxV2xqUWZp?=
 =?utf-8?B?c0RxdW55LzFRYWhwRThhcXJuR0NaYkY4R0dxT1BOV1RkK2pwUy82dm9iMkpN?=
 =?utf-8?B?cGlMS1FGSHZtNmRmNDc1eVZiTGpZK1daTlVqZEFSbnRGdXZTbEFmQitrM1NU?=
 =?utf-8?B?blZuSklWQVpQMkJSRVBKZ01Cc0RUSzJRSVZKeFVrVGwwcml3c2F0VXgyWG5S?=
 =?utf-8?B?MGg5MEJKbnByOWVrMTkwZ3RhcmdIVkdISzZhc3dndTh5dndmSFNHMWdHQlZZ?=
 =?utf-8?B?dnROMGNsZk1qeHp6SGt6dkt4NndKcTZtRjZkWGhxem1ZM3pFc2VuWEVLVkdq?=
 =?utf-8?B?dG9wQnVqbTNyZW9vZTNZTFJ1dTA2ck9EU29TU3RCbng2bHJoUjVTeHdRcGIz?=
 =?utf-8?B?WnJ0ZlRIZE9WNW04SXM2R1ZwY0g0UENoS3EyRnBhRkdrNWlBNW1TeW81MnE3?=
 =?utf-8?B?T2VFZkRBNzBreWlMcEJtQzJrNFQrNkM2SkVVcnN2UHphbjVFQ1YwejhoWlNQ?=
 =?utf-8?B?TjVIVGV5VWVTbXREdzIxMmU4WmxwVE91ZmQ2MnpleG13NzZyb2o0ZW4rYlZU?=
 =?utf-8?B?K0NJS1FkeUhZbThIWVBUT1ZxK2JUZ0lYZmN3TFczVDkxNlorN2xBMStEVEJT?=
 =?utf-8?B?QXNMejRPUUhzR25acCtrcUEyaUJNMGljdzNzaVh2Q2RSOUVCWFFaRnFUUTM5?=
 =?utf-8?B?U2lJWjlzazdJSVRqZTVyU3JsTlllOEtRVUtZNnp4Qzd6bmI2K1NVM1FYbjl0?=
 =?utf-8?B?V3JjM1hnMWl6QStZZGprN21DbjhiWmxwc0J0UWhyS1ZmY1NGQ3I0QWxOWFBS?=
 =?utf-8?B?dGd5YUhEdFRsK043VnQ2a1Rzem9RRGZoQTlTMmdBSEFDdndTczJGdkxOWU12?=
 =?utf-8?B?QmdZeDZDRTBUVlBNbkZXUjJvYWVBQTdRdVVnNEhiWk1KbHNtZFBHSVRCYVM1?=
 =?utf-8?B?UThlbFp0TGI0QjlhQnlhZk5uWDBkdjgySnlRTlQyYW50djk3S2pNWWdFS0gw?=
 =?utf-8?B?cWpQaFExbXNsZ2s4ZEtDZ1hVTGFXRkhmWnJrMmJBV0V6QnVkWEZpYUpZNndP?=
 =?utf-8?B?MS92TjJPcnJ1SXpYN3ZURTlYT3BFY2l6V0FuSkR5WXVyMWRCRlBwVmsvTStn?=
 =?utf-8?B?cGFUS2M0Ujd5MVUwc2xFbS82bjdzRnEzZzhZbG9aTUNkcWpTRlJDcWJzak5k?=
 =?utf-8?B?QU5mVjNBenVHOExyRlhVN2tiTzgxQXF5MGJwdlZmaHJMVy85RXRYQ3ZybDds?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F46A6BBB14A8348A44B8392F1C3BA66@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	228sLwN9MaFRU5I32Gjh8HaP8tAtNRMjAWMN9410x4Dza5ApYa8Jx90WHwWRfrQoHRUSbGSQ9DHJPUPYwy696+0qWQMmdlZLwVyfRa60aBNnsHIvFP5wBeHDDddzQSYK5LRpqKLS3zkO0rKBp2FrB6VUJ1mCCSctSae7dwvWArXLw8mEfAO6E6/2eGSAeUst3p7jYxdBpl+g2arr/3Qohe5ZhwSmC5dKPBCoi7/L8mFIpy6htz912pNTvnj4iQeLxeGnk0/UQAL+CXBX4LDFNf4ulQ3gnlAZnFB1r7EqbBTTtmtLAqrZJz3xPYHO4ZmBCF0pMDCec9klbOLRLiFuedPD3QXtCwYbP7FvwgP/v9YK6m/BhrRLSyblbaGhDZLJMO77DteIC4hpfD/JGHCktAkTEZgVugBb8Yo+Vrd65lRGQcNAIr2x07iIC29Tos+FyYgkIvKZOk2CVYAXLCodtfvUnGd7tlReF+UcFWo5NA9RArKnfqWCMEhDII3oVNilh49thU8XILvBC6QOeYsJT3jck3LJwDiXX9T2oNuHppSPactMRZvHaFWxhtyoiG66jA1id07KDpos4K6MzN8uZdxjPvCl+67kU2YfXEtz3dCMUsdZ4cRtXcCzbL+aE2oZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86228cf-d472-448b-12ea-08dc8c557b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 09:36:34.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WOISkGmBi9SzXdpOskQZTZAQKmguIprnfY6tWPuCIZrbwAT30CsiLBBnq3JvAEUChuOtZ+8155dAokU9UBa5KD5k0agbKS4s6reD7G1hrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8516

T24gMTMuMDYuMjQgMjM6MjMsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gVHVlLCBKdW4gMTEs
IDIwMjQgYXQgMDQ6MzM6MTlQTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
T24gMTEuMDYuMjQgMTY6MzcsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+PiBPbiBNb24sIEp1biAx
MCwgMjAyNCBhdCAxMDo0MDoyNUFNICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+
Pj4+IC0jZGVmaW5lIEJUUkZTX1NUUklQRV9SQUlENQk1DQo+Pj4+IC0jZGVmaW5lIEJUUkZTX1NU
UklQRV9SQUlENgk2DQo+Pj4+IC0jZGVmaW5lIEJUUkZTX1NUUklQRV9SQUlEMUMzCTcNCj4+Pj4g
LSNkZWZpbmUgQlRSRlNfU1RSSVBFX1JBSUQxQzQJOA0KPj4+PiAtDQo+Pj4+ICAgIHN0cnVjdCBi
dHJmc19zdHJpcGVfZXh0ZW50IHsNCj4+Pj4gLQlfX3U4IGVuY29kaW5nOw0KPj4+PiAtCV9fdTgg
cmVzZXJ2ZWRbN107DQo+Pj4+ICAgIAkvKiBBbiBhcnJheSBvZiByYWlkIHN0cmlkZXMgdGhpcyBz
dHJpcGUgaXMgY29tcG9zZWQgb2YuICovDQo+Pj4+IC0Jc3RydWN0IGJ0cmZzX3JhaWRfc3RyaWRl
IHN0cmlkZXNbXTsNCj4+Pj4gKwlfX0RFQ0xBUkVfRkxFWF9BUlJBWShzdHJ1Y3QgYnRyZnNfcmFp
ZF9zdHJpZGUsIHN0cmlkZXMpOw0KPj4+DQo+Pj4gSXMgdGhlcmUgYSByZWFzb24gdG8gdXNlIHRo
ZSBfXyB1bmRlcnNjb3JlIG1hY3JvPyBJIHNlZSBubyBkaWZmZXJlbmNlDQo+Pj4gYmV0d2VlbiB0
aGF0IGFuZCBERUNMQVJFX0ZMRVhfQVJSQVkgYW5kIHVuZGVyc2NvcmUgdXN1YWxseSBtZWFucyB0
aGF0DQo+Pj4gaXQncyBzcGVjaWFsIGluIHNvbWUgd2F5Lg0KPj4+DQo+Pg0KPj4gWWVzLCB0aGUg
X18gdmVyc2lvbiBpcyBmb3IgVUFQSSwgbGlrZSBfX3U4IG9yIF9fbGUzMiBhbmQgc28gb24uDQo+
IA0KPiBJIHNlZSwgdGhvdWdoIEknZCByYXRoZXIga2VlcCB0aGUgb24tZGlzayBkZWZpbml0aW9u
cyBmcmVlIG9mIHdyYXBwZXJzDQo+IHRoYXQgaGlkZSB0aGUgdHlwZXMuIFdlIHVzZSB0aGUgX18g
aW50IHR5cGVzIGJ1dCB0aGF0J3MgYWxsIGFuZCBxdWl0ZQ0KPiBjbGVhciB3aGF0IGl0IG1lYW5z
Lg0KPiANCj4gVGhlcmUgYWxyZWFkeSBhcmUgZmxleGlibGUgbWVtYmVycyAoYnRyZnNfbGVhZiwg
YnRyZnNfbm9kZSwNCj4gYnRyZnNfaW5vZGVfZXh0cmVmKSwgdXNpbmcgdGhlIGVtcHR5W10gc3lu
dGF4LiBUaGUgbWFjcm8gd3JhcHMgdGhlDQo+IGRpc3RpbmN0aW9uIHRoYXQgYysrIG5lZWRzIGJ1
dCBzbyBmYXIgdGhlIGV4aXN0aW5nIGRlY2xhcmF0aW9ucyBoYXZlJ3QNCj4gYmVlbiBwcm9ibGVt
YXRpYy4gIFNvIEknZCByYXRoZXIga2VlcCB0aGUgZGVjbGFyYXRpb25zIGNvbnNpc3RlbnQuDQo+
IA0KDQpZZXMgYnV0IGFsbCB0aGVzZSBleGFtcGxlcyBoYXZlIG90aGVyIG1lbWJlcnMgYXMgd2Vs
bC4gQWZ0ZXIgdGhpcyBwYXRjaCwgDQpidHJmc19zdHJpcGVfZXh0ZW50IGlzIGEgY29udGFpbmVy
IGZvciBidHJmc19yYWlkX3N0cmlkZSwgYW5kIEMgZG9lc24ndCANCmFsbG93IGEgZmxleG1lbWJl
ciBvbmx5IHN0cnVjdDoNCg0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGZzL2J0cmZzL2N0cmVlLmg6
MTgsDQogICAgICAgICAgICAgICAgICBmcm9tIGZzL2J0cmZzL2RlbGF5ZWQtaW5vZGUuaDoxOSwN
CiAgICAgICAgICAgICAgICAgIGZyb20gZnMvYnRyZnMvc3VwZXIuYzozMjoNCi4vaW5jbHVkZS91
YXBpL2xpbnV4L2J0cmZzX3RyZWUuaDo3NTM6MzQ6IGVycm9yOiBmbGV4aWJsZSBhcnJheSBtZW1i
ZXIgDQppbiBhIHN0cnVjdCB3aXRoIG5vIG5hbWVkIG1lbWJlcnMNCiAgIDc1MyB8ICAgICAgICAg
c3RydWN0IGJ0cmZzX3JhaWRfc3RyaWRlIHN0cmlkZXNbXTsNCiAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn4NCg0KDQo=

