Return-Path: <linux-btrfs+bounces-904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF8C810CE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 10:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587B31C20944
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780EB1EB4C;
	Wed, 13 Dec 2023 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O/PIgHM0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w2uNtqmD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D1B7;
	Wed, 13 Dec 2023 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702458140; x=1733994140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sTCf5g0DEi8qVyvnTMoPxY9ish3QnOtLU0BS1yXtn9g=;
  b=O/PIgHM08zmOWAWuN25lXfheQFcx4z+zpXzbPyB3VgzyPnVDr2AG4Ygq
   y/cEnw4T22amld+4JIKFWp9sJlu2tR8Ivn2OItmCUcn43HkfkfzdKVcSb
   iS9upN437etcIwZ/zjgtuJbntSEIuaP1T9vzx0djSgv7iMXf/gnvpQ6fE
   rDoqNb0ABzVTZ42fWNJRzPXEJpVjntgacsImhGw2ycD9gP11vfCi66Ne3
   H5T88UxSBpIGkvRu2mOeCV+UbnVUnwbhS2lxS78Bnn6B2O368hIhqal9y
   ovaJL0TdedpSGfilTp1Kfpguy2tq7lzxW+g2s1YM68oTyA1HCB5DONsTS
   Q==;
X-CSE-ConnectionGUID: jx0cnefORQangYZJsdo27A==
X-CSE-MsgGUID: QTGKg3FRR3qWWdTs+PBXSg==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4560875"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 17:02:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaIy8CfB3xgYI19qfNLMzIAH/GQfqqYbk7zWvRnM4E7n6UomERvqRzAbk7uzBMzNSx71q2oCl8jpE0/253P1LM3qVtiMhc4/w+Y05CA6VXfHpyjoYZV4Lw2VFhzH0NR+CEonEE52cDGJvfiYKysVoshTDbKg1SgOJT/Vp/Wn5cUKGN6ldjwzSoHjUh/5sUhnYQtxMEWnmUng7Wy6TDz1SR31aYcQ/JLBkLNJRolG5NinGoIC5RVWgByz4hjmt/54MsDJOCZt1INE5lkj2/NDVc5IJk7n6jIDpdQLFy8q9pCZ79E923cNmgjN7iKRlGw8Vxfj6Brcmaa1Y/qLr0M8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTCf5g0DEi8qVyvnTMoPxY9ish3QnOtLU0BS1yXtn9g=;
 b=ckfOSdJBHEWkUONGrP1fu1naxRt897HyYurNbA35Ch7ktUJaooiqPwo1fV0xSomHDXXhiWQXdH4JaZge7uzRv56OXlAjFJB2gc5OiKT32S70lrVbOkivX1PzKJK7YkWG6EE/rWRflVNlJpg7s5Xvnu3jXUUpwIH98rqsm5Ox73f42u3uDuZV/FdGG3r3MebRps/Pp1fKvx/GlKISumVdj3gnbP5i+8y4KMPGrftjSEU8qr7IgI1HHfwbEBH+lMmzpUffzN6+uiHQKnM1wEgqG6Iyjq55vC8/64XlrGbdRBBNAU8FIJbsTuWk0wnZ8qxxOwrdYPvWsfsM3Ql6Hxivbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTCf5g0DEi8qVyvnTMoPxY9ish3QnOtLU0BS1yXtn9g=;
 b=w2uNtqmD4ekpF0innnC+nWb6nqM1yEYKnOD2zey9X4sKMdhu1ErY/Jl97yhXHabwZ2sRQGEYGKEoS4vjU2VxaAzsAUdPPmOWvoSc5Qk9Bhqag89pufy1hCCqikIEuWDFcMDgRfoVerUAICHAS8x6lfCv9T8h7UlhKJHr3wuYiDM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7270.namprd04.prod.outlook.com (2603:10b6:510:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:02:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:02:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/13] btrfs: factor out block-mapping for RAID0
Thread-Topic: [PATCH 03/13] btrfs: factor out block-mapping for RAID0
Thread-Index: AQHaLPgZZa3XPam1IUaUxzyqmuwOGLCm6QYAgAADKAA=
Date: Wed, 13 Dec 2023 09:02:12 +0000
Message-ID: <02f24444-552e-45fb-9e13-f73a3cc2cb30@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-3-b2d954d9a55b@wdc.com>
 <ZXlwbjflk9EwEE7A@infradead.org>
In-Reply-To: <ZXlwbjflk9EwEE7A@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7270:EE_
x-ms-office365-filtering-correlation-id: f308e54c-064a-4150-5a12-08dbfbba3258
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PuLAPz5JPc61fdIJ/yxP843hv5GxEX5zy2oh6ax7NVopET/b11DpNyXAPFvG/QO9+jaYZ0t91P6Pm/+KfUQeChCR50yD2kkBnUfZAG3nGytuPLUf6PzMwbXnPHue9E/mF4lHflMht+74k0QL9hM/IDFaX+oswVJYZphezohyO4CqWVIWYZvi65uTBPYMeZec0pSsB9py1FFX+9s/CMOr6PdB8IKPyjMXoErfKg36uOjDVjUKjPst6axZJF/wRq5H2HY3R0KRFpMzAJyepd1egJud7QcsXINagyxFEJieCJqlzA3TTw1I8t51oEevmXUOlxNQyl2HY8pTl9Q1bvlEyCG8rhOXjqYyjUPIFb3Dj+5loDSngFatKlSEvs6JejDq78CBtMMg/+vEbQWZ6K7Tz/D9FJNKvwi/LjzBrfb1uGeZld4NMS6mK3Sv2XRC/PpK6Q0rpmD1lJAakJNamAgvtcpORl5qDLId5EUP3XiKX8IIO0ScWKjbDz+A8kTXOi1DdtxbDX9egfoxUXzwF6YZMZ4d8n3+HB5Dx778mN+Dd8OUoDkZIs00TQVIrvwEge2FhCkXtKvo4cM1IRSkkg7nz8ITzyy8T9zAADFXExa2zw+P0TXUsuML14rle2V8cRTWXzkUevV0p+DiGaDxotNSjJqtT1yW+nHaR/O5L8z3Xnv7CkZGhqrmgmXf9/lKNmH1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(2616005)(83380400001)(38070700009)(86362001)(31696002)(82960400001)(36756003)(38100700002)(4326008)(5660300002)(6512007)(6506007)(53546011)(122000001)(71200400001)(316002)(6916009)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(54906003)(91956017)(64756008)(41300700001)(8936002)(8676002)(6486002)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVJ5MlgydTBXZDdvSTZ3TTlFaEJKMGNDcU1mSVVWT29LY1owVWx4a25ybDhr?=
 =?utf-8?B?WHpuSEhQajkvUVNlTDlvNlRWRTZVVjRWS0k0SmM3clZkU21ZRGpHc0ExT0lp?=
 =?utf-8?B?WUYyMU0wV1hYOVNLMlBOa0lQemdaUW11aE9CK2JHYk00TzRHMDY4OTEzeW14?=
 =?utf-8?B?bXdFRGpoVWx0dVJ4WFlxUjlxOU5FdE0rdU42K0l1cXhBTXg2NTVLL1BYMEky?=
 =?utf-8?B?djd6cW1YSkxzeFgxM1FTK2FSblVQNmhjMTdoZDZML1NhTk5ENkpSZnlUNXFm?=
 =?utf-8?B?SzMvSWZjejU1dytiRDlSSEZWMnJtampUTG9ic1dGN2dXQmZTRDUxRGRZbmxF?=
 =?utf-8?B?YlhmWnFPdzY5V3U5Qjk5Ny9aV3NhKytCL2svZDFsYzNUWEQ0SzhIcUdtTDFE?=
 =?utf-8?B?bzRpS3UyRjhkY0pXQW5yY2VkaXJvOVZjZlNiTmJOcGZLbjIydWM1YlRzbExG?=
 =?utf-8?B?TURqVUxjYVM2QmlLSlFEd3ZBSFZRSnRKNVpVanZ2Mnp0TXpya1dxdXZBTXBu?=
 =?utf-8?B?aDMxVEhZeHhjS3g1Ny9mK1lXZ1B4Y0VvNENEVExUQSswdkZ3UzBwdDN2WGpP?=
 =?utf-8?B?dWJjakF4ZkozWnFzdUhpRjJmWDk4RmpURTVoamRpQUVZZC9ycUFHaDRmYWp0?=
 =?utf-8?B?QjErRHFZVDFtTlFKdWo4OVJjZG9OdE1wZkNFQ1BVaG1aTDNLZEhkcmlNRXE4?=
 =?utf-8?B?cTd1L2xISUFDTnpTaStudmdQQkM3dnFYZU9QY1NHTGZaeFoxb29PQzdnb2Vl?=
 =?utf-8?B?VUdGM3A2TzJ4dzQxczFxdzRGMSsycHdCeFc1ZUNKcE5mRlJpaEFiWVdiZ21u?=
 =?utf-8?B?QnRWT1JmNlFkNFpaVnZjZjA5QzVIaEhDV2I5WFFNUEp0Mjk3ekU1MklLaGlY?=
 =?utf-8?B?S3VsRWZ4cTZqTE44by9SRUluUU5YcDdyNm1BVUtDMmpRZVNjWFRyYXdVUzR3?=
 =?utf-8?B?bmNwQUcvWlRUaHZDd2xHVVVEQ0pOaTZWaEt4ZDBKZ1JiOFNlT2lOUkN1WUdX?=
 =?utf-8?B?M3lYMnpVU1doQ2w1TDd6RExiUmNhY3B3bGxhUnMxbXROazNtUEhNcWp2QVVr?=
 =?utf-8?B?TDU2V3pScXhxa0U1RzY2bnE4VUR6dFgrb0RoNkZ4UTQ2ZlFFOHBkMWo0U0Zt?=
 =?utf-8?B?dWkzWWVuVnF3ZTdzbUZ0Tmp0Tkt0Wk5XZ0wrbFJNbUpFT3FRdkhGeFJPWTRW?=
 =?utf-8?B?U2hTbmxSTFFiTnpFT3ZHZjhtM25BSk1NSVVlM2VJODV2Y3lHbVFCUzVBaGhx?=
 =?utf-8?B?SDV6VW9QUnZXWnpKU0szRHcvYzFWUlZwWkl2Vm53eS94TXpWMTlDZlh6N3ZD?=
 =?utf-8?B?SGMwcVB1RGZoTXBrU0hMOHNsT1h5QXExY3ZWRk5veEhnakc5aGZFa01hV0p3?=
 =?utf-8?B?UkxWVlY3OXg3all1V0Z2c3drb1lEb1RFSVlUcnNuS1ZiU0NOeUhMNWpOdnFa?=
 =?utf-8?B?UFpDN1pmbmI3OTN2UXJJdTN2Q09xeDFsL00vdmJMcEVkOTJONksrS1VyL2I2?=
 =?utf-8?B?N0ZDMm0xSkIxbGNLRW9veE4zUFNDV2dCTnkySWlacVpibGt4QUZjUkh0Wnc0?=
 =?utf-8?B?WG0zRm1DQ0pMQlJacnBzWldCNGN5eWViRHBPWmV6eTdqQjB6L1VmZ1pQaFNw?=
 =?utf-8?B?MHh5cjB4b0FEVUd2TWcwTHBvRW1KQkhkaWw0L2NXcEdkMCtiZFV5VWFBUG5C?=
 =?utf-8?B?YnpCUmRkeUFvZjhIczVlTlFRR2ZrekQ3cUhwMkJuUmZ3TXhtWVJnQm9MSUJm?=
 =?utf-8?B?c01uT3I3N254R1F6OENCUWhtSitZMWpoeE1YMWZBMVQ1MGk0SmdNYWRTUS9k?=
 =?utf-8?B?TmNtc0pyNksrb0VOYlpFR1UwUUloNDkwWkxXaE5xd1hpYmxYSGhQQldvcHJU?=
 =?utf-8?B?V1VNSjdnamdrNHl0MXlqZmR1cDljZ0Q1MDZUY0YrbThlOTNNeVhEWXU1SG45?=
 =?utf-8?B?U3F2UEVpZWZxSHF5MzBIaERrbXhwZmZZVUpLTWRRL3JraXhhQS95RS9vOWVD?=
 =?utf-8?B?T21pQTVRNVBrL0YrNDFpNXVvV0RpamhTTkNQS1BuUVhqUFVNaW9hemV4R0lP?=
 =?utf-8?B?SzRWUVY1UmxkUndiK3k3NkVjM00rOHlnYnJSRk1EM2N2UGxQaWU1Tm5uemIw?=
 =?utf-8?B?VldVVU9OSnJRZmJZZGJQSTZPcXRrVEhQUUV2aGNXNmpVbDdRSXdUWUFSejlG?=
 =?utf-8?B?cDlPMmI0UnVxYVFLU1hsL01XemFnTnVXR1hwU2gzaUlKbVRLMmY2aUpJRXFr?=
 =?utf-8?B?bG53ekh5cFFKS3ZRdXIzR2UwWkJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B558225A9A4CA74A87658998D0A94455@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bi3KYhcNn+PC4R8G1o1efF+bgUFzLhdnEHj4CMHslpPQS4YCp7fsuv0ZuxE2Bj1+aT6Iv6YRwS3y73/TrvNsiXk4EbUsfn0Yk7vI0erHsupVkAcp8z/KZpzNsfhztoGAEC7QsaoncYLOTayWr51vPEnAOYFHNyf71nrhiMLoerkC6R1sAK2DgEYD3C1szfx0MrQJoF5jMdbjBPIkUukLNEcqKUDLYtXdSBcHOC2mhmNs8/Ptb7ow4xJ8ikgew58UQ27fH0ty5eA7nEgxuD/BgkAhyMGq4+5kOYWr4bMUGwtI+tD0Llrsjip1qAv3kZkjsT1Ve2JXYDD/wdKvE5Pn8L0ppn9I1uUH+fTHwVs6Gr1TiKIOZOhMqueLE+bU0tZ65OQROudxXwjMmtIvGhHaMVOYqd9W5/Ve30WmCCuqaTTQfQ8XA+7kgfDryfgrd4Eq3zFE6v//A4qhLXdN5JLEN3iF76gPSqCvGLUeIdKE+63lru0oBjmlDy2M+E9REt7rkOjJOllansYRHGZJgcmUvGKM5u9My1XBk52YaKAQJGby/1ynUV1VysNp90ZfA3EaLU9xddqjL9zDfN2K6bEkzfvA/61gmsg9N54dyxkWBTaILCKhyQCPC+TqaEIWFWOG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f308e54c-064a-4150-5a12-08dbfbba3258
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 09:02:13.0033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5sDL6VtNFEOulMO786mKEjJldUO0/P0hH46tdCFOL09EghcsvWKabjTd7rCOq3RBky63g2hPIrjMYP/hvlFh7z9rGMQY0XgG0TIqSJFS64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7270

T24gMTMuMTIuMjMgMDk6NTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gK3N0YXRpYyB2
b2lkIG1hcF9ibG9ja3NfZm9yX3JhaWQwKHN0cnVjdCBidHJmc19jaHVua19tYXAgKm1hcCwNCj4g
DQo+IEknZCBza2lwIHRoZSBfZm9yIGhlcmUgYXMgaXQgaXMgYSBiaXQgcmVkdW5kYW50Lg0KDQpP
Sy4NCg0KPj4gKwkJCQkgZW51bSBidHJmc19tYXBfb3Agb3AsDQo+IA0KPiBMb29raW5nIGF0IGFs
bCB0aGUgcGF0Y2hlczogc2hvdWxkbid0IHRoZSBvcCBhbHNvIGdvIGludG8gdGhlDQo+IGJ0cmZz
X2lvX2dlb21ldHJ5IHN0cnVjdHVyZT8NCg0KV291bGQgbWFrZSBzZW5zZSB5ZXMuDQo=

