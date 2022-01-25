Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6333E49B66B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 15:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578760AbiAYOfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 09:35:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42745 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579501AbiAYO3E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 09:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643120942; x=1674656942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3C27gvpAFPh3wYfweTgGDNFjdPAlyhoNAIEaP80vqTs=;
  b=Mp+5XKRysUb6MCULTIZ0uzpWrrKZlhzGd2742MJWPqqPexE2zZsJo0NI
   kmCJt65HjybBGuSZgi9NPIT0I9lZt19xxVy39c2EeGLCnThlRHY1MWEQ3
   akDD5UyIMONh6RxawHMs1AI1jx7g4hIh0c9/aCLQFbBZ7bDA4bywUpDxT
   iNqtKSlKxjaoK7ua+EmVutyZfW3DBl+FbGPtbOScO0kNYfQtbIQ63GjcK
   i52wUq7cCzn13gdx7YN6/n5OY1a9kjbI9LUNtdHh7SzNRhlnpZb+y1QzN
   6zTTA0YM1y4qR6SKAbe1g6Wmk59VSOQGEpfnwm0Ph8o+WjTIPu/uUCOaR
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,315,1635177600"; 
   d="scan'208";a="303207440"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2022 22:28:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tyun1qfcnh4xdRiV/16/LkyyrZ5JyQ97+F5X7r0/9FYW1Ijpkm9hSgl1Z1kTMdnKqPeEs2sLSP7D0yoK4x2yXwGIn4b07rT4jQx0jn5gwsoSlqFty0wA5w7UzxlBPmmXUV4l8rqiq3G+kljgMFJorshY4Ej/fPhfHoDCGFj6t26IPPV+HGqEquHrFaDXnZ5zLDZxnSoviwtYSXL6Ifj1fnw4aryIGge0eMwHObr7W8vKKEjEj9SuKH3cxFWTWrP7n3iIY7jhFk33crgMjURsRV/OKwEuObpq3Y06AHgZRJZ6wsZVLDKZxmqzComrjl4cVALKBoDdJLsqgx0dprS4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C27gvpAFPh3wYfweTgGDNFjdPAlyhoNAIEaP80vqTs=;
 b=hptE2puKxzchbnlshl6ySrAH3y1uRBfVhu+ypGlZd3mFHvOpTNdibh7fnokgYwDrF1CUtdFo1by6P2GLG9OyE4qqqg7GojBpo9/scDhfI2RyHyLiBmurK5NLNQWyza2o/e+fKIYm0d7mgJZ2+oC8sWME/xzOLLYdVx6dGNORf4kn0ZaS4ffPAJpxcpzzrHtIsPPmOUGTVUCpwMhe8QEhvul6C12ayt0XFZgC8+Ehnu74WZ0GIcqs7GVegzOqtRXvz/rbrBxiYYweMXLW8N3Y92ozbNAlfrHsoxZf4FRd/+kjJ/q/qh4TTEsB9fJbbowIC1f91M7aL+ugQLfPwE2ovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C27gvpAFPh3wYfweTgGDNFjdPAlyhoNAIEaP80vqTs=;
 b=r/sGG2KBlWDqvsUibpbBWohR2zUMqHwtmqtA0LB3i7Ej2zzvQ73tFqylhECpMOaAniSq8KvTvjJJKDqWlK0qPvxeuzRCqBX6aPkilextXHOJtsXTBdYFE+pUAhFjX4+8gYJrCbAY12rcggI/yZUJk7yeFGsuZ5HxDF2tbaL5S4o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0543.namprd04.prod.outlook.com (2603:10b6:300:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Tue, 25 Jan
 2022 14:28:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%6]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 14:28:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "naohire.aota@wdc.com" <naohire.aota@wdc.com>
Subject: Re: [PATCH] btrfs-progs: add udev rule to use mq-deadline on zoned
 btrfs
Thread-Topic: [PATCH] btrfs-progs: add udev rule to use mq-deadline on zoned
 btrfs
Thread-Index: AQHYEe6SPW3jdxkrfUS+HVGvfMxZfaxzyWmAgAACfAA=
Date:   Tue, 25 Jan 2022 14:28:55 +0000
Message-ID: <9af77f0dc0eeb08da612b8ba053a0cae0d48ad2e.camel@wdc.com>
References: <20220125132200.56122-1-johannes.thumshirn@wdc.com>
         <20220125142001.GP14046@suse.cz>
In-Reply-To: <20220125142001.GP14046@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c7de5b1-a7df-43c4-6c3b-08d9e00f04c2
x-ms-traffictypediagnostic: MWHPR04MB0543:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0543C184316854588F1A96639B5F9@MWHPR04MB0543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VPYCi8RmBphsAGO4UFyRuIvBaHa3rUe4pvgspNDMR1ia27ncM82T9HdsDHiMCaipnVxbKt3UPEMeaa1S+S5kqXPwe1hCW/7tXlN4QrW3ZbH3ZB49+EBuyBq6QbweFyAZ6exyTBoq2lNeyl+xae2FZbMcmQGRKFxXm4VtjEAf1hj118j2OpmfDIg37Vx392N6LhLSpdeWXZsHgj5UYxlXGYXK8+GZJ0wQQaPxOKohu+vH2g4dzlIjQcRyHUi361kumi2YCIzayYQ3gDoD2kNnaHyaf356b8SMwhZ/DVRZChvKB/ozoli6OsIA1dgk3Hway6Xc9RhVt1lI6xQy+BtUtHFZSFub6kKsQEA51w3jYujalaxeJIzRb+e3KICx+25HdYFszXojTbdac9cHuD1c8hprix/gjU4hPCnVitRCDJm4Z7qgsH1edmw5Smcx2FkEdUmx3GI9MrhdESv3iasLmhFlXLjM6Fk4JkI3adluf5iWViKavkrrZQZsIpE8V8I4SJhRqgv/9pegRfAfPwk3ehnYjk/4CBJCFUiwV9lZcgXytlJUC6O7F/3T4SNFPUxUdKMWJss/p7LTziOjxxdJhNP6+Xsy4WEsHAOMIgOkYIgX9jfZoFWYgakyo603zG+lOI1j9rSvD06gEJLT7iDbTQJCXBvNrVOWQeXrbhcb7vkiDK1XTa5lo9MnrhyHZZqbE4oPvIy1mqB0kYDGezYgeoT16ARwvdTzkKsPbMBiHmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(26005)(186003)(82960400001)(4326008)(508600001)(91956017)(76116006)(36756003)(54906003)(66946007)(6506007)(316002)(66446008)(66476007)(64756008)(66556008)(38070700005)(38100700002)(71200400001)(5660300002)(2616005)(83380400001)(6512007)(6486002)(8676002)(2906002)(8936002)(6916009)(122000001)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjdISlY1emVVQmlLSEt6U25SaFNVVzhzNXhWaDE3Y3BWalg0elpuTmx6bDI1?=
 =?utf-8?B?cWQwYlhTczhrbUt6WGVDRU5SU2pVSTlNWW0wZHBoMHV2R081Sk1pdXFqTVhL?=
 =?utf-8?B?bmJXUE9vVzcwQmJlM1cvK0hOT3hwNklVK295dG9GajhqakVSckJBYWVZY3RE?=
 =?utf-8?B?dkxNYnB2U2FxZmRyTm50Z3RPaisyNWZHRVNxVWVvNHJ1TzMrNXlxUzh3QkZR?=
 =?utf-8?B?Tkh3Q3BoODhSTXpFcjkzaDV1MHFxMjVhNXcydExSbFdlMGk1OVNTWHlSREJL?=
 =?utf-8?B?cThtNjlucTJ0NmlzdEN6TlRuQW5nUGUyb2lCYzBESlhzaHJ2T2FwOXd3VTM2?=
 =?utf-8?B?VURjNHZkc2Vvd25sRzk0U0ZTZHBpNWpVdjlwTFViWFljTWdGb0NDMllRU1NJ?=
 =?utf-8?B?MzFoODZuUEdzaTl2bUJVZGFZc3ZBSU1uajM3NWFyR0FtNWF3bWh0TE1rbWdC?=
 =?utf-8?B?c0NNM0ZYcWViTS95UUd4MStxMWUxc0lXdHhlaHFZZDF2OGpYL3B2a1pNbU5q?=
 =?utf-8?B?NUpFbjYyNUhxNGFPTU9lRmJYV3dSVUJ6Tml6Vm9KYUxBYTVsOVZGZ2UzNTYx?=
 =?utf-8?B?UkxxdW0zbnBXQ29HOEVKWmNNb3BLV2t2TGw2SmhqOWY1UVB3MUR6N3B4VkUw?=
 =?utf-8?B?STRwYWFIcy9JeE9SbXJxMHoyQ0FXcW5wcmNuYmtISmtkcVBGVk9aT3lVTFJk?=
 =?utf-8?B?bEYyZnBQd1Uwa0dXU0JXOVI5SmFkRVRDR2pORmZONzAxbFZMSUF3VDdoU2x1?=
 =?utf-8?B?Mm15aTA3UDhpZm1XTEx1SlJMWVZvRncyUmoxV1RsLys4SFdXbGtJbWkvR3h1?=
 =?utf-8?B?VXcyNnV6UWVCYzdBblRTVDRIbk8rTXFLenA0ZE5RK0Rqc28xL2hXamo1SDlI?=
 =?utf-8?B?cktOUXBEMGQ4bGVIUkt4MVhhaSs3bWJiSW84eDRSSWo1djNFMkVXVnpqVUd3?=
 =?utf-8?B?cDRmSE45SGhzZVhWSDZnbXE3azYzNU1zY3g1L1pMWVpTS0F0VGEvUzU1RkhM?=
 =?utf-8?B?c2dNc2pZbFZ1akYrWFNNaGtuZlhFL1ZZVExZNFRmSGp5MUJaZ2ZSU0lFWFBx?=
 =?utf-8?B?dW5Cc1BKUU9TUm5GYm8xcjVzR2MyM0tYS2t3WTBDRFpTdjFXT0RkUWlJT0d5?=
 =?utf-8?B?QUFBcmdPbmJxK0IrWC9ERUpkdm00aTBBS3VMZlVhazI5eGgwbnRpbm5uOExT?=
 =?utf-8?B?a29saGdTWnNoNGx2dWUyOThSYkx2UmI3U042S0gxekhFUTE5VzdVUTBFRWUx?=
 =?utf-8?B?cDJVTUNYZWNLK1dJYm1pN3l4SE1wUnpwT0Q4aEVYd09yNzZwNVo3QlBJR3ln?=
 =?utf-8?B?R3lDamQ2VUFQSFdMWjFyUVJTMkNrY2RreXhHM3l4WU14V041ZVBvVGR4MmJ1?=
 =?utf-8?B?TXhqYWc0b1pEWnNQQXhCcDhaYmZiMEpiSWpYNHVkeG1NVDNjSTdRU0ROSHhZ?=
 =?utf-8?B?SCtOTmR0UDFzSXJ1QVIwK0l4QUhTUEJVNmg1aFA0RGFLZU5kUFRqSkFaZG9S?=
 =?utf-8?B?NjRaazF5QkNOSENVT3QwMWRzR210VWR1WitxTndPeFZhWkN5Q1dTY2FvU3Zj?=
 =?utf-8?B?QjY3WTk2d0pwN1FrcG5TWjdOVmlzTGlzUTdmcUxFM0pCR05Vd2pocmtKQ09u?=
 =?utf-8?B?RWdrN1FNNU5nZndnS1Byc0xRL05QbzNScS9ZYUxRNzNBeVF0NVJQMlFaUWhV?=
 =?utf-8?B?ekEybytwTDR5ZlVxUXU5aEl5d0ExRzY3RXJycVB5aUdmdVQrbW9McmhRcmE0?=
 =?utf-8?B?Q2l6T212Z2hWTkIvSVYvWmNLSWRteHdzTlFWRVp5dXZTU29DQXFqNWpyNHRQ?=
 =?utf-8?B?NjJjN0cxbjNSaUhkRE9hRjJpb3J3TTY1dllWNi9PZHRnd2x1SHFSTkxzOWZm?=
 =?utf-8?B?dlVoMXdVaGlTaUF5VnlTcEg5ZWd5VHdhSVo1VTVxV1FMai9NbDZvS2xESmJX?=
 =?utf-8?B?d0I2azNJcmtZZE9XQkpNaG9jYlVNZUYyZ29UQU9Ycko0N2Q4QVN0UTdsSzAv?=
 =?utf-8?B?a0FuUDFjSUlURDVsclg1T0VMNjdMWHZ2aVh5RWxYaFduZzBqdU1Ja0twNU1l?=
 =?utf-8?B?aVpKZFJBMldLZHE4dUhNcTczUENnYllMR203YnhTZE9Fbk1DRi94UnAxWVg0?=
 =?utf-8?B?Y2R4bk5YR2J1ZXdRdjRwUlFrL253dE5rSVR3ZmdRK1B4VEx5NVFMWTV4RCtp?=
 =?utf-8?B?Z0xCQmk5TTVSdGNXbFRQY3hLNG9RSnBGR3U1R3JjODlFdjl4WnBYK3M1a25O?=
 =?utf-8?Q?DDTG67gfS7CNeWget5W2OgebVBH8h2Z5WYRoyIfhI8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D01B4AA49BD2647B8D933F2C9C253CB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7de5b1-a7df-43c4-6c3b-08d9e00f04c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 14:28:55.7367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LkYRBGCqPjBVe7Ft9/jsHozw4Bs3lszVfpmeAxqrVO0kACXewZDurKk6lih2M8o9nROkpoyOswgdSg0zZez8dEBS+DTJlEdv+0c45YxenxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0543
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTI1IGF0IDE1OjIwICswMTAwLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+
IE9uIFR1ZSwgSmFuIDI1LCAyMDIyIGF0IDA1OjIyOjAwQU0gLTA4MDAsIEpvaGFubmVzIFRodW1z
aGlybiB3cm90ZToNCj4gPiBBcyB6b25lZCBidHJmcyB1c2VzIHJlZ3VsYXIgd3JpdGVzIGZvciBt
ZXRhZGF0YSwgaXQgbmVlZHMgem9uZQ0KPiA+IHdyaXRlDQo+ID4gbG9ja2luZyBpbiB0aGUgSU8g
c2NoZWR1bGVyLiBBZGQgYSB1ZGV2IHJ1bGUgdGhhdCBjb25maWd1cmVzIGFuIElPDQo+ID4gc2No
ZWR1bGVyIGRvaW5nIHpvbmUgd3JpdGUgbG9ja2luZy4NCj4gDQo+IEknbSBub3Qgc3VyZSBob3cg
dGhlIHVkZXYgcnVsZXMgYXJlIGRpc3RyaWJ1dGVkIG5vd2FkYXlzLCBpZiBpdCdzDQo+IHN1cHBv
c2VkIHRvIGJlIHBhY2thZ2VkIHdpdGggdGhlIHRvb2xzIHRoZW1zZWx2ZXMgb3Igd2l0aA0KPiBz
eXN0ZW1kLXNvbWV0aGluZy7CoCBObyBwcm9ibGVtIGFkZGluZyBpdCB0byBidHJmcy1wcm9ncyBn
aXQgYnV0IHRoZXJlDQo+IG1heSBiZSBvdGhlciBwYXJ0aWVzIGludGVyZXN0ZWQuDQoNClRoaXMg
aXMgd2hlcmUgNjQtYnRyZnMtZG0ucnVsZXMgaXMgZm91bmQgc28gSSBndWVzc2VkIHdlJ3JlIHN0
aWxsDQpzaGlwcGluZyB0aGUgcnVsZS4NCg0KDQo+IA0KPiBBbHNvLCBpcyB0aGVyZSBzb21lIHNh
bml0eSBjaGVjayBpbiB0aGUgem9uZWQgZGV2aWNlIGRyaXZlciB0byBtYWtlDQo+IHN1cmUNCj4g
dGhlIG1xLWRlYWRsaW5lIGlzIHNlbGVjdGVkPyBUbyBhdm9pZCBhY2NpZGVudGFsIHByb2JsZW1z
LiBNYXliZSB3ZQ0KPiBjYW4NCj4gYWRkIHNvbWUgcHJvZ3MgY2hlY2tzIHRvIHRvIG1rZnMsIGlm
IGl0IG1ha2VzIHNlbnNlIHRvIGhhcmRjb2RlIHRoZQ0KPiBpbw0KPiBzY2hlZHVsZXIgbmFtZSBh
cyB0aGV5IGNvbWUgYW5kIGdvIGluIGEgcmFwaWQgc3VjY2Vzc2lvbiAobWVhc3VyZWQgb24NCj4g
Z2VvbG9naWNhbCB0aW1lIHNjYWxlKS4NCg0Kc2QgYW5kIG51bGxfYmxrIHNwZWNpZmljYWxseSBy
ZXF1ZXN0IGFuIGlvIHNjaGVkdWxlciB0aGF0IGlzIGNhcGFibGUgb2YNCmRvaW5nIHpvbmUgd3Jp
dGUgbG9ja2luZy4gTlZNZSBkb2Vzbid0IGFzIGl0IHdhbnQncyB0byBleHBsb2l0IGFzIG11Y2gN
CnBhcmFsbGVsaXNtIGFzIHBvc3NpYmxlLCBzbyB3ZSBuZWVkIHRvIHNldCBpdCBhdCBsZWFzdCBv
biBaTlMgTlZNZS4NCkkndmUgb3B0ZWQgb3V0IG9mIGVuY29kaW5nIGEgbWF0Y2ggZm9yIE5WTWUg
aW50byBpdCBhcyBpdCB3b24ndCBodXJ0IGlmDQpudWxsX2JsayBvciBzZCBhcmUgcHJvYmVkIGFu
ZCBnZXQgYSBtcS1kZWFkbGluZSBzd2l0Y2guDQoNCkkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBs
ZXQgbWtmcyBkbyB0aGUgc2NoZWR1bGVyIHN3aXRjaCwgY2F1c2UgdGhhdCANCndvbid0IHBlcnNp
c3QgYWNyb3NzIHJlYm9vdHMuDQo=
