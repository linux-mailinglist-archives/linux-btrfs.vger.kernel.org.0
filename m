Return-Path: <linux-btrfs+bounces-1023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08EF816DD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 13:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D21F239BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D674B12D;
	Mon, 18 Dec 2023 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Btz83HdS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sxMhbhtV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5024B120
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702902042; x=1734438042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2wSg9lXB656eA51RFzsl+NR3CvaGqcPElk2op3nd1iY=;
  b=Btz83HdSWf2xQiXwnVEwIg1G932POsKjzRilXJBqeI3tFugI95VBqb7y
   oFEuBuSyng068r1vf6PWBHFUb74GoVSgW+YaDu+X+k3sXwNOyuFm69piW
   8Ems4fwBKe7XH+qjfGW2nwMSLBrho5pgYZ1MELmroFgGJQv7RlKWv/GWA
   bHG8hzqBPtUNnjn3YNJKe7yrm4Dnl0Z/ciUETWihvYGe1ir2eSDbBVQDL
   K5eKN9QW/xNvejlakvj4BZbP6jqxahbpNs+eN/0BCDeyyuze2ZqOIICH0
   N0bNWjv2xavBnwkeNau8Z4kNuz7+pa5ImDeqek5llOQYf/BBawHMHOf0h
   g==;
X-CSE-ConnectionGUID: RHUNX5gXQEif06B0VBMQjg==
X-CSE-MsgGUID: OAFvMZocTzO/e6oe3ISHCA==
X-IronPort-AV: E=Sophos;i="6.04,285,1695657600"; 
   d="scan'208";a="5457332"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2023 20:20:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuISKNgrpSIEXJFVWwUh5H4KoPplzOuDsJFI+vEKlFf7vEY9hmGO4FrwzW7rD/cZh3NZQ8RwXrWDplWaLrpyapXLOPN+0hDNZ2yYHqBjIOQrID65AzbV0K0tujf636DbhNoQJ0yleuVIpxCxil5ud3Dj6bs/TcirFVY/UHDeD6qIchSkgKO3iHHxdIGH8kGOMj8Vdff95xxgZrLAEkq0y8ZNMzgYYmiaN4oeo9fOgO86LmPi9jWREj3iAXTXdZ9vmrx7SKEvVALjT6JRGnnb9xf7gZGPzR92NEUMIAecv/H2p5mXLgNMZA/UvGq7ergiHgVVfIAz1PmTaDbVHe10Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wSg9lXB656eA51RFzsl+NR3CvaGqcPElk2op3nd1iY=;
 b=ErGVREoKY0JmxQHbD5NPLfAhHOvvE4n3L0Fw+Nhvrk2ipi+9571paHUgEtRBEs/FMz+/3wzHJHcecB86XpKvPSuFb4d0PPNoCPuNwjZlu1UWYL8ho3Ln6COHsQBJIvOw50oJVt04xyPRVzFkW4u6vy4xp1zg+sxmfavSNJoCf4YOtVOKLMdPwaIxUbwS62sdEimmVYFrnUpaRXgqgHWj/ynV9rEYnu2ZHIXBygP6Ig/12HfOyavgSDJgHn21WwjZGPL88eKERA36Uc64faFXvgVvJ239PZfdyyX/+D0ahl/54ao/RRPOWlYY33lyRDqaxyKYjpYPCpon5QyQQlm9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wSg9lXB656eA51RFzsl+NR3CvaGqcPElk2op3nd1iY=;
 b=sxMhbhtVzehezZZcg50alIIQHsjjXvMdbIM8VPjef7GhOfYliMje8ctd906B/xgUbSzDih9lMuuxwSO0tL2RE3S08NG1GeTfD9fRc9jeoHNKWWEp8tl/TeTBgMp/OyBb7AyM2JGL4LIqGAHxZuIbE24eAopQZ/xJgDDD08xOFZo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6750.namprd04.prod.outlook.com (2603:10b6:208:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 12:20:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 12:20:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: use the super_block as bdev holder
Thread-Topic: use the super_block as bdev holder
Thread-Index: AQHaMW2jyfNp0/fMzkiQL7xF5Uv+kbCu9lIA
Date: Mon, 18 Dec 2023 12:20:31 +0000
Message-ID: <b083ae24-2273-479f-8c9e-96cb9ef083b8@wdc.com>
References: <20231218044933.706042-1-hch@lst.de>
In-Reply-To: <20231218044933.706042-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6750:EE_
x-ms-office365-filtering-correlation-id: 1246bb66-43f6-40e9-f135-08dbffc3bab5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EMpYofwKuUEBpt2eZBpFFkqUo7tL41nbjzpFAFJeFTN9q5JpY756T3ea/iCMJKCepTPoG/cckCKnEJV2SWPD33RkssNtNqT4ipkLawuoS4MXCTvhDILZsNG97MgxpTyoo5xlyvXdX3bBmuk6fZNYcy57O4SnNk5s2k/7j8NVHXs8rUnxFyyszvJeCNhMworPQoLuVwW1VAgTgTWaAkA9knpREpl4k+1L+UxyISfyYpZaO+J2gQeege/2S7PMTx/FueLdikqzFX671wDghtQLItm/Sfit5qWMVyBVjUSCAg6rpQvMb1C2IQeglafR5+Ze8d9gusm4LYCpvIAN4cu49lezRFDPTbjFdpE71XleoBiCPdCCgcRX5TtC+1cOLFe2ZqRRNc+vO9Y9HPDCN1Q/Q6cE72LwF3HTn++YRdpJiNyN6uj9Y+sPPKl/gef8wr3IPP+94e/oO5vJMG97nIxfk6FS4LsKE8Qzy9oIfiv/pPHm0oamW7782bM1JUJMkHdqfXMYTk8oeHV8qwWJrY26Tf3yoiJ3DgrE3kghVKvrShTJ5h2JmJderIDfYHizFMyppsRPYBLBvYi6IjcMQ9h82l5ScNYG6xr8AJIZ+DIh31PStCrh4B6B8c8YVobmt8RfTN6gsST1rKFO4QuhE5UvTz5fPTr2GGSeFoedRvCq9ESK5L1IMqIi6aUMiDcc2mX5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2616005)(71200400001)(82960400001)(122000001)(36756003)(38100700002)(31696002)(86362001)(38070700009)(83380400001)(5660300002)(6512007)(53546011)(6506007)(2906002)(8936002)(8676002)(4326008)(91956017)(66556008)(76116006)(66946007)(6486002)(54906003)(66446008)(110136005)(64756008)(66476007)(316002)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDBZTGtpUVlDZEovNGVUWDc5NnFWb2dGQlBMek1Cb3lrcXhadWdvYVNJNE5k?=
 =?utf-8?B?bzhRNTRFMlR2SWlpMzN2QUxlN1l6TWRRT2xQZTFEYmtzSmVnZmhEa1JRLzBt?=
 =?utf-8?B?NjQ5VEMxVzZaTS9NS2F6MzRHcjdYZi8zdEs5VE8vQzkrWm9Td3NxekpOa1Jl?=
 =?utf-8?B?MkhNK2pCVU5IdHVJL1BSZ0dkcHFEVTNOaWdQUGJlZ3hsWmV3dStmMWNUSHoz?=
 =?utf-8?B?V2lzMXdJbUFhYlB6dExyUTZJM3QyOXhBSDdnN3lnSHRBV3VrbS9OSWwxN2Q5?=
 =?utf-8?B?NmVWTGJnTGNyNC9CTms2WDdiclZpRENNcDRtNHgwYVF3M0pvN0cxVVpkdjJF?=
 =?utf-8?B?eENoKzRpNFVXMTlTWGQwcU82M0hSVGVLRnE3U2tVMXhCdDY5eWFwVlIvZm41?=
 =?utf-8?B?ajFkUEZTWkVFK1RMVm9CWGhVMEVDWW9yOXdHV3BYZDhvanJCN3NjUXVjUTE1?=
 =?utf-8?B?QnFPcmJFVUFQN3F3ZVEvdXArZEY1aG1rdWVlTWdaTEpSelNsdWNrTzZTaG56?=
 =?utf-8?B?VmxVQU0wdUF4WW0yeFVkWkRxc1J6eUNIR2tKRWs4SEU4d1EwdzlPanRTNEJJ?=
 =?utf-8?B?SWJHNzRMMGZVYmxHbG9xYlNBZVBOWlFIdThySXhWbGZzNEFVcXN6Qlk3aWIw?=
 =?utf-8?B?ZVoxSlZIb0hzYTZPbmFtem16M0N4SS9BQVhXT1Jaem5ETnR3Y3JLU0FXT283?=
 =?utf-8?B?THlFS1FWVGVWZjVHTGdYQ2RzSW1sWFBhTGF6THpDOFc2eHFBRFc1QTc2amZ4?=
 =?utf-8?B?Z0NlZEwrbVZlMTVDWUFCTkpXL29WUDdTL2VVMkw0UHNvVENCSEN5WjJaNXJj?=
 =?utf-8?B?MVlya0tpTWU1VWlhS3VPQzE0SWtOZEZrWjRXVVd3T1FJRGNQazFnaWJHS3JO?=
 =?utf-8?B?bE5TS3dXMjZEQldkc3RiR1ZKRkxIaDhuMEgwbzBGNTdYNHdpNnl2M3ZOQUZz?=
 =?utf-8?B?UVM4RXluRWpKd2JER3MvdXMxc00vY2h1QmZpQXlQU1FUTzV2eWNKUzlOYmF1?=
 =?utf-8?B?WldFeDNtUFdsR0JBRHVwTkt6eWFDY0tvK1BxWDgveTNTK2FpV0tLT3FydjQw?=
 =?utf-8?B?SmtvS1dsZlBHOGJ0OVpYR2pLcG5UY2VNVDY3aUlTY3pOYzRvOVZRajY3TWZT?=
 =?utf-8?B?K2xqODNYbHFVaDRJSXJldVVPN3ByS0s3SUNUem9yVFFKNWQvUzdLNXRXQis4?=
 =?utf-8?B?TVc1SUFyeUxnRkJVNVJzQlh2TGVYYUFjYW01S0dJU1M5a2sxZU9wcnpIRndi?=
 =?utf-8?B?UmJzZE9PTG1CekhGMXZzVUVRYzJURk9tM0tQNnFGZy9LakZlK0VLOGlKZ2FI?=
 =?utf-8?B?TWd2ZWhXSjQvYS8zeDNTM2pvUVIzYS84QzliVXJqa2tVZDNCRTQzUXZBeUli?=
 =?utf-8?B?NlNEMWVMZENzTGg5U1gxSU15MWh4Qm9UbHF6R3pKU1BoT1FYNzVkemlxemZQ?=
 =?utf-8?B?c2lKb3VLRW4vRjQyWkNwbEJkZW5RcUxBQmRna1BzMjhib2pIaVgwbXpNdVBB?=
 =?utf-8?B?OVdXOWk3U2VGSVRmYk44U3VTbU5zamtCZkJrbmdEQWw1eGl3Zk9vTHU0MGsv?=
 =?utf-8?B?Q0JGenhCQnRoT2dDaGt4ZGNXTkZ6V05YN0orT2RMTGFyVWt3OVViSHN0djJP?=
 =?utf-8?B?QmxWQlErYnpjUGZoOUF0SGczb2lyQm1TZjhyQzBBTzlPellKTUdLaTBFbkpO?=
 =?utf-8?B?K1hhTmNyRnY1ZG1CL3JVMGVkOWRUREdNVTNuMzNOZ3FFeEo1MjI5aVplZCto?=
 =?utf-8?B?cERLempOc2o2b253N2VZYWpvckNFVFY5ODRhcFZBcmxocWxWUVVJTXZOTWNY?=
 =?utf-8?B?cU1CdFpMbENlZFBJaFlYNStmVXk1a09oNTZ1bE1jSEZGL1hTcDlOYStYUG5n?=
 =?utf-8?B?cVozOTNnMWd4N3JyWFNueDNCTXlaM2UwZ3hua2FLeDc0ZG91b3NsbUUyL1Jj?=
 =?utf-8?B?U3FjYTQ5S2JCNFE5cjNyK2FLYTMzWmNvVytaWkNiYWttenMwNFE5b1k5U2xJ?=
 =?utf-8?B?Z1Q2TytISTlNQUJTcjZ0aVk1c0NZcHdHUk1aeUdmQ1lsV1lsRENUKzAyNktr?=
 =?utf-8?B?SzZGYW9lRW02KzUxajRWT0w5WGJCU3Z2ak10WWRJTXFYdDlyWkdOYlpnZm9S?=
 =?utf-8?B?N3U3bzNaS1FvUTFZSFY4MDZHZTB2eFMxSnpPNGZRT2FGaGUxZkZFaC9KbSs3?=
 =?utf-8?B?SzlnZmVGMEI2YndLMjZJMlFjMTJic05IdjhySTlrRll2TXpGc1ViSitWcVFT?=
 =?utf-8?B?cWlObzdncGFXcEp1OXcwcU9vZjZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3D6C0DE3057E844AB499154DE7F8387@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7RJ6JVMnUlmhHoO9EfjgzdSYyY2g/KrO79bmGKKa4vUxVn+umW0D/dJziQe7vYa5o0L1i/dlSxZNYwIi+4LlTMpNSyuUWqgjMHhK+CiGAjc5bMQPRmqO5pMil2kVMre5gJ7R/roaydAU1izdAy0kMQG4N8t5gTV6aZtaSHGqczPljChX64tCTc2C0IAC2LktWLaBGzikck2K7/SmkSQinL2CB2b801OIWGLLFzvZ833gYkjGk+C3wq2UXcaBwLMmdmMobefTANMp1cGugFq1gEfL180OkxpaiRTNXR+nf/2q44oi5pMT/bTv0kpjq+149hq8gER8cPpkCkePcrZ2Vpibmcywd6gAMu2Rx1vHxqKJp4i9YwCvIZP4bdUTjsk8gcmp03xvaAxaURVJH2H4Jewa8zJmzpljCbpWF5s+uYwSphhkzlUCmqVZOLoF7UeIGAUCYVtPPQ6S8QzUXxGzdlX+kDUNkPa/NzP0AN2DDATa+Ixze8/EY5rZUZ49v/70CYW/z6Ieb1pEbSLBvsEb6KjEYtGgPXqCkd4tXEwJirmzi7YiBO6LioN5Kmw7YD/9qB06dm4cL5k3X4UJqZRW3wHu33ClC6B8Sf0BOhLfN51sNBxvG+Kog6P51Vvco8XZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1246bb66-43f6-40e9-f135-08dbffc3bab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 12:20:31.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KroKOTcGbMlZ572pecbb1gw6OrLwtah2uE8J4swS3BJb8hM5GUT1qHmjYA0a1o/TOSiF5a6WvnsD8i2hwNW/qTdahomEAaL9ewMHMlUbtXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6750

T24gMTguMTIuMjMgMDU6NDksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBhbGwsDQo+
IA0KPiB0aGlzIHNlcmllcyBjb250YWlucyB0aGUgYnRyZnMgcGFydHMgb2YgdGhlICJyZW1vdmUg
Z2V0X3N1cGVyIiBmcm9tIEp1bmUNCj4gdGhhdCBtYW5hZ2VkIHRvIGdldCBsb3N0Lg0KPiANCj4g
SSd2ZSBkcm9wcGVkIGFsbCB0aGUgcmV2aWV3cyBmcm9tIGJhY2sgdGhlbiBhcyB0aGUgcmViYXNl
IGFnYWluc3QgdGhlIG5ldw0KPiBtb3VudCBBUEkgY29udmVyc2lvbiBsZWQgdG8gYSBsb3Qgb2Yg
bm9uLXRyaXZpYWwgY29uZmxpY3RzLg0KPiANCj4gSm9zZWYga2luZGx5IHJhbiBpdCB0aHJvdWdo
IHRoZSBDSSBmYXJtIGFuZCBwcm92aWRlZCBhIGZpeHVwIGJhc2VkIG9uIHRoYXQuDQo+IA0KPiBE
aWZmc3RhdDoNCj4gICBkaXNrLWlvLmMgfCAgICA0ICstLQ0KPiAgIHN1cGVyLmMgICB8ICAgNzEg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gICB2b2x1bWVzLmMgfCAgIDYwICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICB2b2x1bWVzLmggfCAgICA4ICsrKystLQ0KPiAg
IDQgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgNjUgZGVsZXRpb25zKC0pDQo+IA0K
PiANCg0KQXBhcnQgZnJvbSB0aGUgbml0cGlja3MNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVt
c2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KZm9yIHRoZSBzZXJpZXMuDQoNCkNh
biB3ZSBtYXliZSBnZXQgc3RoIGxpa2UgdGhpcyBpbiBhcyB3ZWxsIHdoaWxlIHdlJ3JlIGF0IGl0
Og0KTW9zdCBmcmVlKCkgdHlwZSBmdW5jdGlvbnMgYWNjZXB0IE5VTEwgcG9pbnRlcnMsIHNvIGRv
IGl0IGZvciANCmJ0cmZzX2Nsb3NlX2RldmljZXMoKSBhcyB3ZWxsLiBJdCdzIHB1cmVseSBlc3Ro
ZXRpYyBidXQgdGhlIGlmIG9uIHRvcCBvZg0KYnRyZnNfZnJlZV9mc19pbmZvKCkgaHVydHMgbXkg
ZXllcy4NCg0KZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Rpc2staW8uYyBiL2ZzL2J0cmZzL2Rpc2st
aW8uYw0KaW5kZXggYzJmNTdjOTg2MDY5Li5iYmFmOGE5YjczNGMgMTAwNjQ0DQotLS0gYS9mcy9i
dHJmcy9kaXNrLWlvLmMNCisrKyBiL2ZzL2J0cmZzL2Rpc2staW8uYw0KQEAgLTEyNjUsOCArMTI2
NSw3IEBAIHN0YXRpYyB2b2lkIGZyZWVfZ2xvYmFsX3Jvb3RzKHN0cnVjdCBidHJmc19mc19pbmZv
IA0KKmZzX2luZm8pDQoNCiAgdm9pZCBidHJmc19mcmVlX2ZzX2luZm8oc3RydWN0IGJ0cmZzX2Zz
X2luZm8gKmZzX2luZm8pDQogIHsNCi0gICAgICAgaWYgKGZzX2luZm8tPmZzX2RldmljZXMpDQot
ICAgICAgICAgICAgICAgYnRyZnNfY2xvc2VfZGV2aWNlcyhmc19pbmZvLT5mc19kZXZpY2VzKTsN
CisgICAgICAgYnRyZnNfY2xvc2VfZGV2aWNlcyhmc19pbmZvLT5mc19kZXZpY2VzKTsNCiAgICAg
ICAgIHBlcmNwdV9jb3VudGVyX2Rlc3Ryb3koJmZzX2luZm8tPmRpcnR5X21ldGFkYXRhX2J5dGVz
KTsNCiAgICAgICAgIHBlcmNwdV9jb3VudGVyX2Rlc3Ryb3koJmZzX2luZm8tPmRlbGFsbG9jX2J5
dGVzKTsNCiAgICAgICAgIHBlcmNwdV9jb3VudGVyX2Rlc3Ryb3koJmZzX2luZm8tPm9yZGVyZWRf
Ynl0ZXMpOw0KZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3N1cGVyLmMgYi9mcy9idHJmcy9zdXBlci5j
DQppbmRleCAyZGZhMjI3NGIxOTMuLjE0ODc0ZTI2NjM0NSAxMDA2NDQNCi0tLSBhL2ZzL2J0cmZz
L3N1cGVyLmMNCisrKyBiL2ZzL2J0cmZzL3N1cGVyLmMNCkBAIC0xOTU5LDEwICsxOTU5LDggQEAg
c3RhdGljIHN0cnVjdCB2ZnNtb3VudCANCipidHJmc19yZWNvbmZpZ3VyZV9mb3JfbW91bnQoc3Ry
dWN0IGZzX2NvbnRleHQgKmZjKQ0KICAgICAgICAgICogV2UgZ290IGEgcmVmZXJlbmNlIHRvIG91
ciBmc19kZXZpY2VzLCBzbyB3ZSBuZWVkIHRvIGNsb3NlIGl0IA0KaGVyZSB0bw0KICAgICAgICAg
ICogbWFrZSBzdXJlIHdlIGRvbid0IGxlYWsgb3VyIHJlZmVyZW5jZSBvbiB0aGUgZnNfZGV2aWNl
cy4NCiAgICAgICAgICAqLw0KLSAgICAgICBpZiAoZnNfaW5mby0+ZnNfZGV2aWNlcykgew0KLSAg
ICAgICAgICAgICAgIGJ0cmZzX2Nsb3NlX2RldmljZXMoZnNfaW5mby0+ZnNfZGV2aWNlcyk7DQot
ICAgICAgICAgICAgICAgZnNfaW5mby0+ZnNfZGV2aWNlcyA9IE5VTEw7DQotICAgICAgIH0NCisg
ICAgICAgYnRyZnNfY2xvc2VfZGV2aWNlcyhmc19pbmZvLT5mc19kZXZpY2VzKTsNCisgICAgICAg
ZnNfaW5mby0+ZnNfZGV2aWNlcyA9IE5VTEw7DQoNCiAgICAgICAgIC8qDQogICAgICAgICAgKiBX
ZSBnb3QgYW4gRUJVU1kgYmVjYXVzZSBvdXIgU0JfUkRPTkxZIGZsYWcgZGlkbid0IG1hdGNoIHRo
ZSANCmV4aXN0aW5nDQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvdm9sdW1lcy5jIGIvZnMvYnRyZnMv
dm9sdW1lcy5jDQppbmRleCA1YWIxYjdjMmZhMzkuLjg3ODM4OWU5ZjZhNCAxMDA2NDQNCi0tLSBh
L2ZzL2J0cmZzL3ZvbHVtZXMuYw0KKysrIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQpAQCAtMTE0NSw2
ICsxMTQ1LDkgQEAgdm9pZCBidHJmc19jbG9zZV9kZXZpY2VzKHN0cnVjdCBidHJmc19mc19kZXZp
Y2VzIA0KKmZzX2RldmljZXMpDQogICAgICAgICBMSVNUX0hFQUQobGlzdCk7DQogICAgICAgICBz
dHJ1Y3QgYnRyZnNfZnNfZGV2aWNlcyAqdG1wOw0KDQorICAgICAgIGlmICghZnNfZGV2aWNlcykN
CisgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCisNCiAgICAgICAgIG11dGV4X2xvY2soJnV1
aWRfbXV0ZXgpOw0KICAgICAgICAgY2xvc2VfZnNfZGV2aWNlcyhmc19kZXZpY2VzKTsNCiAgICAg
ICAgIGlmICghZnNfZGV2aWNlcy0+aW5fdXNlKSB7DQoNCg==

