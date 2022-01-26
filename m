Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97549C5FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiAZJPM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 04:15:12 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22259 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbiAZJPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 04:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643188502; x=1674724502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q82GvVHOp3dweL5WOpQCjpTeUFXGGyX3WZs73DyxNvs=;
  b=HRN887RBF2Nr5pQ/Ihj/xtdQPsK1GXJY9xYNDsesBTUl3WN12HoiDdd/
   ScuTOPLiR/ru/yRrV+GbFrXKkVOvWzaZF4J9fVLQRwBgN6A8Ni+r+LGhr
   1ngauQMPPkuYshp4Pfi3e/wQirzP9ksbKfk+7nEK3TghkNmpTeI/FczKA
   fSxu3CwUdWUp3BYk7U+2M2tO68CDoEP4uvsZ6E1b6J5tgWZRiaBjyXTzf
   iZ2r/Wi3X8q7y4JCUVRuHNVkmvfaOIN78+AUC21Nycl3Cn443M6mXat/l
   Ccv/hY5Umdsfz5I4+HYD9pMCWVY9YX6R+C54Pz+0eUQ+EbqrA76IsqZmo
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="295481132"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 17:15:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMkxuJTjNrKzv6vt1yPT2JTnKh7fm0ZS7qaDrhenZDMAzvKg5y/aPOYM1ejzLya9pcyvzmgfv++4VqV0aJiz4hJIXVQ/ATqCeJTGqo2Biuiwt28PrfRXd+HQbxRLRp1evxqcONrAGwmBlBEjQM5A20v3GVfrE25IAp3mJ0RAXwvDX1O6TWn1oimC2TnhrnVxsWdesV7bvydv2glHZ8x86i6k1cvjHGYqy663nQOjbrey3PYJ5EEBqwZfcTjo9Ckr6de9GrDk0DNsKYDYuMrQMtY+JvP64yUYsvEoOamOG/eFUwQSiD2O8xx3WG2Snwk7yl4/cMdO7E+txvjNCJyawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q82GvVHOp3dweL5WOpQCjpTeUFXGGyX3WZs73DyxNvs=;
 b=T6je8AA5cg9sfkkDucFjqoRpjudvexw6SPfeZ9g8C3XvBuYlJv5lLTuyULJEERcuR6ckqFehzMSvxL4DOywmPHawwe3/ohZhYzndByi442P5hjUqzCx1b55JgvdGOCVuNBUIAGARBZBSu6ggrQQQuNw09N+FKvKxReXu429sVndEYEnW4ehIGF48v2deyZihYhkmSj06QWYdpIH+aDcCmQC9z/5albEfAyCW8exzSpUNA0Cla6mLuhkpClN7s0/Ccg3AmIX+2nEYI2HXkGJjsd/x+GM5xXzAmtzSSb73REkg70mkW2Olk/g18xjza5ZHQMgw5EeRB6O7J04OlCUyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q82GvVHOp3dweL5WOpQCjpTeUFXGGyX3WZs73DyxNvs=;
 b=uWSQ/04dJlFcX5eqoUSDikRAYjq9pPfhPyd07TPAU5kFfsrfbjFXFdyrf0fMj/LH7ooO898QFixPakbqS+mzccoiogZgps6PMBYF+wKQV/POYFXkkWNy1pcSYSQ7aIG4i6SOREHpb5g24LhnRB5h/HGPvgY0vpSIoSr1YXL/foE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7711.namprd04.prod.outlook.com (2603:10b6:a03:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 09:15:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 09:15:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs: implement metadata DUP for zoned mode
Thread-Topic: [PATCH 0/4] btrfs: implement metadata DUP for zoned mode
Thread-Index: AQHYEpMSpofKaqk9g0OsThDx/T3uKax1BToA
Date:   Wed, 26 Jan 2022 09:15:00 +0000
Message-ID: <825e8aae92340c154c04d77f72f3f2aceecbcd2e.camel@wdc.com>
References: <cover.1643185812.git.johannes.thumshirn@wdc.com>
In-Reply-To: <cover.1643185812.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3da70d10-4ab5-4714-e6c1-08d9e0ac5451
x-ms-traffictypediagnostic: SJ0PR04MB7711:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB7711DA01C4F25AC1E1A1B9CC9B209@SJ0PR04MB7711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7F0THvI8ACIGf+9MFhxzBt294s5J820VgQzC0fluJLBfMXua3orVVmpd0ZV0hUOh+AnA5zzomt4g1cPEWc1/1KxcTt9vAD6W1BD6xw6HuV8WND1UmYV0BT0OWY6NQaL8sdu6jwG6X91dMw9IXEHL+1BoiUZCiZOv7qeHrrzhcUXU7ahNu3DOxnxXZHe9s9d/QFB1GpIbY6KZzw7WjDxTBP6AQI360jCDDJrK3M4FW68yQzXCqBnsmC5vvpx+8FRlQz6p+lI/Jh+p713VtdgCqR+cPyfyJBcFI6sSKQED0CwsrKFEATNZczcDfrRkM1kxb2NnnL8jWXoYYXlR3xeK5iKeRRei4jf81DiVFb0qAtvjhIAqiEMlkB4w5BjMVWSF+tK4kS0hUOsUMusGD+KI+nNUmbzoqgVGXHgaweO9DWgFuGohIswKJkaErlImceCHpQKqwSM00ii6YaxSFP5PJtKYLCvxOQoymNVctuY125MJZe6CZm/0WdyF02I8+Ki1m6L1C8Dul7kJwCOg2+pdZbp2LY3LfzUBtacudG7cmm5fjwY+HnOmVm8KMSclXuOYCO0aUVGDVO+7uGIMW6bPPoSzhhQfUxYUg6Il02ZE9T8SpdUSdO2DH4HvAi2xslepM47xAx9ruezmUYGxAT20xDbEZDGwDJyZdFmt//sug6AF5qOysMZcaOCqKtxybzp1jLswnLhgyWk9WvP5u3j+QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(4744005)(83380400001)(316002)(6486002)(6916009)(38100700002)(6512007)(2616005)(38070700005)(5660300002)(6506007)(26005)(86362001)(4326008)(71200400001)(508600001)(76116006)(91956017)(66476007)(66556008)(64756008)(66946007)(66446008)(8676002)(2906002)(36756003)(82960400001)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a21QODJpZWxhdW9kU1dqQlh0UVNSa1p2THJMY2lsZjRaRW5scFpmY1o0ck1I?=
 =?utf-8?B?ZWhjN0FrS2lHU3FaOEtTVEl6RVg4SFUrR3ZuSlczaHFTYTlJNGtUTDgyNUdD?=
 =?utf-8?B?RnpEcHhSbTQyUm91R0x6TzlnTDVHcTFNYm5GZGIvSDVNRmprNlhXOTU0SUJB?=
 =?utf-8?B?SjdtaWUxMEZHQ3VKanU3bkk3RXZtcVFpWThvb1BxQVpjM05HQlVBbGpsVTJU?=
 =?utf-8?B?UnJOZXRiVVdIVVVTMEtPR0FvVVNzdEdHbVpueklKZHNwdmlrc1V2UG1hK2E5?=
 =?utf-8?B?YWVnSXZGNTg4Y3Qxck9IYW5HTzMrUmNUVXlQWnBFWm10QlNiVGRJdUZjSFoy?=
 =?utf-8?B?VEVDNFdEak44amdPSGF0WUJxalNYeXhPT2xNQlM1ZE1BRzdQRXVpeFRkSy93?=
 =?utf-8?B?L051eHNOdmIzU3NZcVBOcERvTCs5ZkQ2OHRVazQ5L0tMQVhQanByZis3dGJH?=
 =?utf-8?B?ZlFsZThycTJPY3hPY29nN1JEdjN0eEN1MnlBYmFHeDJFbnJGd3BuUzFLTTB2?=
 =?utf-8?B?VkpBQWd6K2hncjBnWFAzdC9IV3lVMGhMdjFmNG1BYkRLbEg0MWlYdGI2QmhW?=
 =?utf-8?B?TUw4SDUzV1hvT1Jhb0cvTXlWM3B0MXBheXE4OWJiSmxVcjZ1TTU2ZW5jUC9v?=
 =?utf-8?B?NVloRDZoUm11YkZ0b3lkc1c3RlBhSmFGWk5rVDRGb2xNQXpkZDZoWmUyTFYx?=
 =?utf-8?B?YlFYcndmemFMVGFGYkh3UjAwc0NPNTZ4QVdTT3ZPdjFHYUJibzlnOTYwZkg2?=
 =?utf-8?B?ZzRMc3lPYlI2OFlGM2p0bXN4SGNaV1FqQmt0SmxIQzJpWXFNd2VGdGFscW85?=
 =?utf-8?B?ZG9pK2dnZ0xLMGhyTzRPQ1MvUWdPMmluNkJnSFpQbHJ0cEhZMjlUNkxQMEpa?=
 =?utf-8?B?SHFEVktQUVdNaWZVVHd6RzQwS3NDTHYxZ3BZeGs2YlZtMWM2dmF3QVFFMU1H?=
 =?utf-8?B?WnlzVHhaYkJVSmJYaGx0SEo0NkRXaUJqdjd1NnZLc2FsNlNBOER4dUlwOTdF?=
 =?utf-8?B?a29OUGpMRTBOK3UzMjN6N0cyclo3THBMa1BBSUF4T0luU3BGdXdESXI2WXNh?=
 =?utf-8?B?UStWTW1CT0pSTlF4UVFKZGVhNWJ4Z2c4b0djWFNub1F5TDFOTUc5cllWQlkv?=
 =?utf-8?B?b20wMmlIMzFOaHlPZlNhT2ZiMXA2c1JpM3dnbk1vS3dvU29TSkx6enAxZ29z?=
 =?utf-8?B?ZStPd3NJQjR1bnZoREpTUW0wZjFoelR2T29sbXVzL3lRY0piaGp3eHU3T1Jx?=
 =?utf-8?B?dGZ5ZGREcWlON2JFYjZEL3NzVE1IRGxCMVZGNzkyVE5kS2VCY2V3UXBhSk1W?=
 =?utf-8?B?ZmdYd1NwUUJKcGlidlNjam1UQ1F3dWxzbXV6YWdLcUpFZzBNbEh5RzJnUHUv?=
 =?utf-8?B?STZQTG5yWmRNT1liMVlGSXpHZ21BV2dnMkVaYWh4U0RBVjFvU3VEdURnV3lS?=
 =?utf-8?B?WmtDWUwxaTRDRU14N211MmhMOUFSaUthVHEvQ08vclN5R1E2cE5yOTI5NzR2?=
 =?utf-8?B?UnVuV3Vmb1A3UlRZVzk5MXk5OW5XL3AxU2ZGeGpRNW5QYXlOeUEwWDVaTFZp?=
 =?utf-8?B?VUZkZHpPZkNQY1UzbllNbXRkM21hY0g1bEZKb3pkcVVPdk9meDhkdS9NM2R2?=
 =?utf-8?B?VDVPRitNcGhiUHoyZkZZd2VQcmo2OTVldVpxb3FIYkxlcWFKajlUbEpjYmFh?=
 =?utf-8?B?NzNLcGErb3VFa0JZSmd3OVNiV3BzMmU1czEzT2lhTWJIQTc1cWlaMEdtNm9q?=
 =?utf-8?B?d2xuNldqUkpIZENINHE4YkRHWFloUHNjeTMya3FqV1d2aVZVdTYvMzkyVzB4?=
 =?utf-8?B?TUhSSUVOb2hlUFNVZEFocklVVWxjYzhrUy9VTDlHZTlBQlUzMkNMYjk2L0ZU?=
 =?utf-8?B?TjBnYllqUmVLUHBvelFxS3ZmT0JuUFNpWTJyU1NSN0cxaktxVUNvcTRTaTZF?=
 =?utf-8?B?NDdab1VEQ1FzTEx6Vk9EUkRyRlBUQXZrQVVYSy9aaGY1RTFSd2FweEpUeTJ3?=
 =?utf-8?B?SmZObW1PK3BoZTBad25Zd1RabU4rVzRKeTNoL1hrTWlJNjkrbXN2Nk82cW1K?=
 =?utf-8?B?czZoVUJacWFxZHhRN3ZpZXlVbENUMzhBeGh0Rit0bU5uOXQ0QUJXTmVaYlVt?=
 =?utf-8?B?WjZaS2pNaytyM25RSFhiNXpSbUN1RisvT2lMZ0tzV3grSTQ0eVJQZWFCbXdQ?=
 =?utf-8?B?RVdrM2RSbE5wcDBEQlA3Zm9qeERlY3hKNzAzMy9EMldaK0VLazZaUTNoZDcx?=
 =?utf-8?Q?RkhyuFC7ht3EnI9exmbgqfv55ZqdBY3msArhzFcwLA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <831A838D8513724C8AF4121067182D11@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da70d10-4ab5-4714-e6c1-08d9e0ac5451
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 09:15:00.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zUDC3aNZVZa2h9jxpCAjYi0I8sRxbZQ/RgOjQi2xmlCnRIqDURPsBqWqYnrTxfLT/3Z5OKxilhKy4WuAvLGfuHkAF1Z3ssLIRZoWBYD/l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7711
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTI2IGF0IDAwOjU5IC0wODAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IEJ0cmZzJyBkZWZhdWx0IGJsb2NrLWdyb3VwIHByb2ZpbGUgZm9yIG1ldGFkYXRhIG9u
IHJvdGF0aW5nIGRldmljZXMNCj4gaGFzIGJlZW4NCj4gRFVQIGZvciBhIGxvbmcgdGltZS4gUmVj
ZW50bHkgdGhlIGRlZmF1bHQgYWxzbyBjaGFuZ2VkIGZvciBub24tDQo+IHJvdGF0aW5nDQo+IGRl
dmljZXMuDQo+IA0KPiBUZWNobmljYWxseSwgdGhlcmUgaXMgbm8gcmVhc29uIHdoeSBidHJmcyBv
biB6b25lZCBkZXZpY2VzIGNhbid0IHVzZQ0KPiBEVVAgZm9yDQo+IG1ldGFkYXRhIGFzIHdlbGwu
IEFsbCBJL08gdG8gbWV0YWRhdGEgYmxvY2stZ3JvdXBzIGlzIHNlcmlhbGl6ZWQgdmlhDQo+IHRo
ZQ0KPiB6b25lZF9tZXRhX2lvX2xvY2sgYW5kIHdyaXR0ZW4gd2l0aCByZWd1bGFyIFJFUV9PUF9X
UklURSBvcGVyYXRpb25zLg0KPiBUaGVyZWZvcmUNCj4gcmVvcmRlcmluZyBkdWUgdG8gUkVRX09Q
X1pPTkVfQVBQRU5EIGNhbm5vdCBoYXBwZW4gb24gbWV0YWRhdGEgKGFzDQo+IG9wcG9zZWQgdG8N
Cj4gZGF0YSkuDQo+IA0KDQoNClBsZWFzZSBkaXNyZWdhcmQgdGhpcyBzZXJpZXMsIEkndmUgZm9y
Z290IHRvIGdpdCBjb21taXQgLS1hbWVuZCBhIHBhcnQuDQoNCldpbGwgc2VuZCBhIHYyIHNob3J0
bHkuDQo=
