Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FCA49AE11
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 09:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447202AbiAYIci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 03:32:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17284 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450525AbiAYIaq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 03:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643099440; x=1674635440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KJOIKPj8ElTbMc7WLgqZa1iW/46wOrtFndBeyBQicW8=;
  b=a2rftKHuxdw9AFPZclXUmKFPRnnEJMNJIvUziR7XL/aJJzRmJvHKaJ/j
   FCIpM3HVxDYii1zCLZ1WVtpgZ+MPym/bUnys+zXe7/IhYy6/OFwyXKUoQ
   dBJc5fYWIo0yOE7UmblL16z37nz6DbFDYw/nnMozMW+/c9V5oz287gQVa
   CudTY2afyIxpV4EbfLaICS8pPEmZT7+zODbcNzMrDl8w3Afg+WyCuhM0o
   bCu4rJc4mzwZRVtJlHOpCDe4t2gkJidoVS0wuHOnKnhfDfPjBnmMqsadr
   ok2596QHfgDGkD+pNu/mRHTrsQamUaGDIxKnX/pnMw2yoExZIZY3d6kkB
   A==;
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="196114875"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2022 16:30:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGlEcJiEIl3fm946wBEfxXsABGdOJZaDM0bMpiZ9EUm8Niw/skyDP24ID0Z0n061IFC9wqjYLkTMuqHd++SwwentFSniPZrufdpuFL4cVMsrFOdFPIqh/4VPzZi9ReFnujZlqVnDtbUXmvaQkVa0gYn3o/UhKg1SzM6G4sfo9HRla3IHIafkohX63r97p7fAZNvy+/oZxS42EyRJF8Rp088GKUrFCfwBYQzlz0xkB4K6MSwInsigdjAC32khanOqsZ7P8aybwXGTD+9Tzu9RR9gsB0A4jmRSW5uOgc71N4saTzNu+H4lbjeekH6hpS4zD2cwlVNxo+wTQs6WygkLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJOIKPj8ElTbMc7WLgqZa1iW/46wOrtFndBeyBQicW8=;
 b=jKqzqAeK5J6lpSY+StYxZKmZvIZAI25ts00Cg4Xr3ZCByyD+ItbaZoI6TKUmj2y7aGEEOJea5dI6UgPtHhrhp9WEPZg9lNxqSztaZ9rqoLBjOHtymfc3k6nqGKvYiUBhSTjw2Z6qDSS2g6K8YfJIl9VPfg+ho6/vAV8sEhsS1uwT2Zktp5nyLnDbGYbz7TSUoSQ/ezDQkHUzeHwrh9sgeXcePqCdALGgTbNsotlhXiiJlFvQ+b17OljTmZt4eU/iCHcAqlQLyRQCzYo19j5XrA6JsK03KL1rrF44tH6TTDTBQHz6191o2aF0CCK8d2OijnKvaWkWVcEFLwTyK14YKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJOIKPj8ElTbMc7WLgqZa1iW/46wOrtFndBeyBQicW8=;
 b=wh6SJ9JZabVWm3BgalU4rmI54ht7HD236ynYiQHScR9fOiq1X9N4RC3iUBqruLfGkwGLl2ufwelTkui32Kh53L+KSAtN4PTTlgu9mz8JdRSjbuboge+tNuv863qsDtKTUxZpxHleltgSoEXOcJpng46V5/CD6flP3yR3XBP89Zg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0914.namprd04.prod.outlook.com (2603:10b6:405:40::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 08:30:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%6]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 08:30:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "wangyugui@e16-tech.com" <wangyugui@e16-tech.com>,
        "trix@redhat.com" <trix@redhat.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: initialize variable cancel
Thread-Topic: [PATCH] btrfs: initialize variable cancel
Thread-Index: AQHYDs024uHQ88GA90imWeRDopo4FKxzNHYAgAA5kwA=
Date:   Tue, 25 Jan 2022 08:30:34 +0000
Message-ID: <266fc1c654a03bf8c5d83f4d9ca1ad5cb57908cb.camel@wdc.com>
References: <20220121134522.832207-1-trix@redhat.com>
         <20220125130429.75C1.409509F4@e16-tech.com>
In-Reply-To: <20220125130429.75C1.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be81c52e-5d5f-40fb-3777-08d9dfdcf533
x-ms-traffictypediagnostic: BN6PR04MB0914:EE_
x-microsoft-antispam-prvs: <BN6PR04MB09140AC33886888E9C20F9339B5F9@BN6PR04MB0914.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IROh89LDxC9LEyr+aruZyBWjdiw6nXv3R3Abihy+/rCC2BpL6TVj+NqwJJc4kOouWZmt1mGUl81bOoQWwmU+g74D663dZcknAhTsux+7hDiM1wnPzdJ6pP5/QlMw/ld7SOq3dUOvd+DV0Wnio8UTmkY0efVFQbdY2oAO19vwn4iSLrG1huGgB9tE/W8caQmIPT17Cl0ufbzySZbhxl8/LdGRviQPD/i2S1L8stKHCmYA6YKLFGN0fGLh5s14Wn3l2JLDOOtqSiNowxTF7r4FNc8oIpaYlyIokVHyR+lfbK7dL3+0yGX9wi1Kcu1SNZX7jmWwS+3bd5h5fRKItU2g4SwrlluGENeJVLUNXiN7lkxHbsaoAtkKmvHmyX6QmjcHqd1LQV6vPV/5dk4vJw6Xo84zPFg6v4PcKfd65/s2y0X/l/PsGfegazAJqZoI2dsObniz5Ttc1sNI2Pnfx/gFsxtOXMWUWMPcenqhX/RTb1Y0GxcrylvyYoN1PuCzEqJy+6IblP5Piqg6y7+hMQq3ExPs+N8V7pL0jUGHFLQ/iiQbFGL/Z7MAyqg2Dcn/DO0iNbGZVgqrc4YE8sbY7zGhIPja2z9TCWTpSYPoobjUYUEvqGjy38Sr4yLanOdG+RR7MsCQ3keFkJ9f0OxmHamuxQ0Jdx+GUIdaOT2ijaq2qAUQnNIU04QpFIGUn4HV+d/eA9b6WpLnIfmjTy0Kp15tEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(76116006)(26005)(71200400001)(38100700002)(122000001)(8676002)(4326008)(83380400001)(38070700005)(2616005)(91956017)(5660300002)(110136005)(86362001)(66946007)(64756008)(316002)(82960400001)(6486002)(66556008)(2906002)(6506007)(66476007)(66446008)(508600001)(8936002)(186003)(6512007)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGdzU3FyZ2N0OUlGYWcvYml1bGY0WUFBQW1leWk3SjRMYVdQODVaRHcrRlhv?=
 =?utf-8?B?TzdUeWtyQVhnYmVNbU5aOE9UT3ptTitzQndaU2M5Z0pQcGZEcGNzWWhDaDdM?=
 =?utf-8?B?MnhXK0RwNkRzZFdIdHhJaWljZ3ZkYjRLK1dUcmhyREdra3l4Q1VWdW5lY2xz?=
 =?utf-8?B?TDZYRDlhMUdUaUJQYlozNUNrdHNObkxPOGtvalg5bE1EYUJqdGhBOXRFdk4x?=
 =?utf-8?B?WEp3Q2MwOVZIRVgxdkVRdnJ2N01Kb1BiZVoxTjlKd2hQcHhxQU1WdFV1WlhK?=
 =?utf-8?B?Wm9YMXVudjdUT3EvLzIraFZGSmV3RHo4S3VYdnFPbFJPMDgvZmFzTkljbVZM?=
 =?utf-8?B?NDIxMms1SnduUHdLaWp4Wkp1cE44TFpzL1c3OHBQeTZzSGNGNzRXWENBOUNI?=
 =?utf-8?B?REhWS0thNHdRem1NaS9pWU9vaWFTT0ZpUUhkVmh1TVcwd1lXMDcrc1V2ZlFo?=
 =?utf-8?B?T3IrTmg0L25kSFB1TkZOTlM0WXY0c2t6OFh5TFQ1bThSOVlFQUkzeXBDZnVq?=
 =?utf-8?B?eU10bnhxb01jQ1NuSEszVDZSUWVoNTdHNzVyUXI5bXFUbXBwak9FbDlGc3VR?=
 =?utf-8?B?cjFCakp4dE1DRFN3aDRianlpSjRueVN3Y1dVdFpVN3dNUlpUU2dIdFoyeSt3?=
 =?utf-8?B?RmFHWGZib0Q1NjZabnhja0dNaVlqOUhiOHBzMWFYYlNTWU5rMFBtU3lFUkE1?=
 =?utf-8?B?MG14QkE5cCsrYzkxeGRsS0R5NThScEd2RWEwZ01CSFUrcXJqK3lIc3ZoTnF4?=
 =?utf-8?B?Q2h1UjVHQ2FmUUg5Tlo1dVdmTzJ3cUhIMnZSTHNSd28wQk41aVNSUEpSQjBY?=
 =?utf-8?B?dS9oNUdWUnJkcSs3ZE5weHRCUWx1ZFFKcXNzVkNscmxxelJCUjZBSG9GcGVz?=
 =?utf-8?B?c2NKWGFKRllQb3BGV2Q1OXRyb0VGd2xwT2sxZDlQUU54K01Sa2lsQzJ6U3ZF?=
 =?utf-8?B?a3AyV2Vqb3JZUGw2UHM0Zm9iQUFYQUZPTEJMTmlYK3BWQ0FpNmQ4am1xWFF0?=
 =?utf-8?B?d0tITEQ0SjZnTnJxNW53UHBFeTJwK3g5ckJhR2JndXVrbEJzdDdOTDVwcTNt?=
 =?utf-8?B?TWh5cWl1djMxVVNIUW1wMXVHSlhWcHBtYURvdzdsT3o1aThnNHpYaTFnRzBS?=
 =?utf-8?B?cXlJYW9nZ1A4cVVaNkE0VE5yMVVzWVBiMXgzbXpmMDFwcXhNYmlNVW4rZjht?=
 =?utf-8?B?U0FRTzNqMk9NbWpacnA4dmJsK0tHWURScWM1d1ZjZ3J2eTR6UzQ1NlNqR3Bp?=
 =?utf-8?B?V0czd3gwV2craDJIblNDQTE0UjlhanVmVjYvL0ZuK0I3eGoyUXhPdm1HaEY1?=
 =?utf-8?B?WjZYcFFseDBTZitBMnBOSUsvRFlCTk51cVZwb0lXR1crY3ZNL01HYmswQkV4?=
 =?utf-8?B?YUZCWEw2VTlNZGVQOHAzeXVzRzRnLzBlRjJWVHMxRkszc3Y2NUIwRi9tTHVH?=
 =?utf-8?B?RkE5cGp5TTRoV2ZUWHE0TkJtZXN3NEk0SGNodjJUVE1xS0tFY0gzMWFKOCtM?=
 =?utf-8?B?NEtnM2ZsT3R4K1duTE1KdXVGQitmTFVTSHJRQnJ0L2ZKRnE1ZmpiV3gycjVv?=
 =?utf-8?B?bEJEZ3hWM1lNMWVhVmMzOUlqZFhnRStqOTV0Zjk2K0pBazRtckxtVm5QbEIx?=
 =?utf-8?B?TlJzTHMwMHJ5andDSEZvZDc3eDVJem9tTUZMWFVmYXNIN3Q5d0RBdGJyRlgv?=
 =?utf-8?B?UTlPRGhtYmRieTFRUnB5Tnk4cHF2VVRYOU1Db0RMYldsUkV1WG9aZyt4KzY5?=
 =?utf-8?B?S3dhQWxlVXU1OGZLbEo0Wjk2djE3U3B1OWRocHArT3NuOXlUaVU1TWlReEF3?=
 =?utf-8?B?REZIcVlDQ0U2eTc5cTRQdmRMZWdOL3huUkhBRFdsN2w4dEdnYUlOaWpybGt6?=
 =?utf-8?B?NWk5ei9QMGFHNXJrd2RmUGR2ZjdBUnc3NkFoYm9ZUFhFczI3Y0ZldUJxb0RR?=
 =?utf-8?B?YzY1RS9vbUpIcFRHTU9samtyY2o0NURTNVAwbndhTEVxejhkZXRURFpIVjd1?=
 =?utf-8?B?RnRFendUdHJaOXVJSVJmcTdlREpmVElYaWdJZ2RZeGt5Tk1GQ2ZiVmhYQkNF?=
 =?utf-8?B?MTBqMU54SkNwRk5WeDQzdE9LdDJ5aXFTRkhOcnphWUxvTnFmVzlNVjdjcm42?=
 =?utf-8?B?eVB6NjNzVFZwTEpQcHlEcm50d2ZGRFlkblhFTnB5WGZhVm5FN3ZtbThHVFFB?=
 =?utf-8?B?ekFGUzVybWVlamZSM3d5UW9zenRsazRqc1JpU2IvbGk2NGpORUR4K1VUL05H?=
 =?utf-8?Q?KdgfTqxtQ4ClCjxL3caeO+BcTtntw7Y/VNdMLc2Y2I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56DAE25C5D116F42B4C95FDD9A1252AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be81c52e-5d5f-40fb-3777-08d9dfdcf533
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 08:30:34.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y239brme0ntDL6K9m/mkHderWXpESgVqF1TP/q7VPkB6JfA8UAftRVB6wmjdtJYorZDyPXD5qoybWWhZzXS5K9d3WC7YpcFJ4FLmOeHQ5Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0914
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTI1IGF0IDEzOjA0ICswODAwLCBXYW5nIFl1Z3VpIHdyb3RlOg0KPiBI
aSwNCj4gDQo+IE1hYnllIHdlIHNob3VsZCBlbmFibGUgJy1XbWF5YmUtdW5pbml0aWFsaXplZCcg
Zm9yIGJ0cmZzICdtYWtlIFc9MScuDQo+IA0KPiBUaGVyZSBpcyBhbm90aGVyIHdhcm5pbmfCoCBy
ZXByb3RlZCBieSAnLVdtYXliZS11bmluaXRpYWxpemVkJyANCj4gaW4gYnRyZnMgbWlzYy1uZXh0
Lg0KPiANCj4gZnMvYnRyZnMvem9uZWQuYzoyNzM6Mjg6IHdhcm5pbmc6IOKAmHpub+KAmSBtYXkg
YmUgdXNlZCB1bmluaXRpYWxpemVkIGluDQo+IHRoaXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5pbml0
aWFsaXplZF0NCj4gwqDCoCBtZW1jcHkoemluZm8tPnpvbmVfY2FjaGUgKyB6bm8sIHpvbmVzLA0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Xg0KDQoNCklzbid0IHRoYXQgb25lIGEgZmFsc2UgcG9zaXRpdmU/DQoNCiAgICAgIHUzMiB6bm87
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAN
Cg0KWy4uLl0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIA0KICAgICAgICAvKiBDaGVjayBjYWNoZSAqLyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBpZiAoemluZm8tPnpvbmVf
Y2FjaGUpIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCBpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgIEFTU0VSVChJU19B
TElHTkVEKHBvcywgemluZm8tPnpvbmVfc2l6ZSkpOyAgICAgICAgICAgIA0KICAgICAgICAgICAg
ICAgIHpubyA9IHBvcyA+PiB6aW5mby0+em9uZV9zaXplX3NoaWZ0OyAgICAgICAgICAgICAgICAg
IA0KWy4uLl0NCiAgICAgICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANClsuLi5dICAg
IA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIA0KICAgICAgICAvKiBQb3B1bGF0ZSBjYWNoZSAqLyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBpZiAoemluZm8tPnpvbmVf
Y2FjaGUpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAg
ICAgICAgIG1lbWNweSh6aW5mby0+em9uZV9jYWNoZSArIHpubywgem9uZXMsICAgICAgICAgICAg
ICAgIA0KICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoKnppbmZvLT56b25lX2NhY2hlKSAq
ICpucl96b25lcyk7ICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
DQo=
