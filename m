Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FDE64BB60
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiLMRta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 12:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiLMRtG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 12:49:06 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F72409C
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670953714; x=1702489714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J+UHISYabYmubc1slaDNszZhlPUcZZ0zpanuA/1KFkM=;
  b=ho31IqRPb0CXWORVKZH2u+UtzC/vd62Pbm4nrRjEeTSNBB4OOI5TLbym
   r/8prPQ78aHOMSjkxp2vEqxfHfHHiXed4azJj6XnktsBZ5L5PDedCKlhp
   OGrzC4/vTzG0646C/oeVQYkDuXr7I19W9pBL8HQ2HaPJKXw7pqIzILNrN
   YdfcnI78sLssw4Znklhnip/Zj8tbDeo4Daqm77PTaCm4QAPVOSyuzxg0r
   N+h2yTZ6uf7qwXIWWTD+a5p9UftjMUVqTRuwQ2rBO0KZ6j97aZkKDmgfK
   Bxi6NvK50QFgUJVMvec1pxZ62ZQSUT94PULk+Phce3hvVOlGRQO3Yh6zS
   g==;
X-IronPort-AV: E=Sophos;i="5.96,242,1665417600"; 
   d="scan'208";a="223713989"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2022 01:48:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARnD2/l23+0SnM6rxy3FNEVSb1dtk7kOdBengAHDUik0y5Vuf3VXJcx4BVXnvKrxixj4FM9kOtiO0vsT1wyOS5Du3V3/b2JckuaBgvD1psUklkngBn7GHYiT/4uH6TJvuyX0ebiNxVVpPQ8TfJO96uS5ohzcvKgoeU5crw+h3DUujMv4sTaDPc1bq6PFzHu9itRJ5shg8LRVEhNEgArWT9yMQT44XZQXNAx3m4igCcUjzolRW31pmMVZPVywR624O2dYx3pt1iYm1yAYA6UOpYvwBPmMaa8IxbUqLBgpVSb8SuP4MZjjiOYwmxukoELx4dWf4LWL46GQjxoEC+iInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+UHISYabYmubc1slaDNszZhlPUcZZ0zpanuA/1KFkM=;
 b=b/qLZGg6i7sfiCKqAOq6LC15fA6EfxpfF68YdZB31+GcYUC/QWZJd6yu/v/jsjpNO7GHNqvq/IhezYtUGJxKnhGAivOJW9QUEvUdK3jabiuQ5YgKxmjr0oh/69dV0h2zDwsVEkxeoO3WWVfTmKhq8TMr4FFXAdZxomkGP4OCrzsmd1rurFMGrI5zmZLJQcMfVfF+Avq1K1ZSehg52tu/apU8Gknxp8mF+g+QpaR5e/A0YV97D3ZqJzX9nwYE14aQzveP7yWh97X78Uatry6rdtjxaZ3owIVPNV5uFOayMmjdUzozNK2YgnClcTUZyXVDqaEmB1Sk3NEPXgzUdjAknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+UHISYabYmubc1slaDNszZhlPUcZZ0zpanuA/1KFkM=;
 b=fTH+w0rK6FPBMYtdeew7HpcsyeY3kdvYSB/6BB4jdbwe52ccb8yMNIaASpDZF0tYZE8Z+6x6DDgOd54Zr+09sd50nQnOjboufGZUoykgXJl32c1uX4/BeLefwM4/lTu3Gy91loXWtymuPKzST4QHf0GdF9K8Kw+yH2BMhPF22IM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4514.namprd04.prod.outlook.com (2603:10b6:208:4a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 17:48:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:48:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZCkdbJyiBsduuyEOE+tpnuJRQAq5sB2yAgAAaP4A=
Date:   Tue, 13 Dec 2022 17:48:32 +0000
Message-ID: <2bf134be-f5e2-14db-9c8a-a55662663f8e@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
 <Y5ik61/v+1gq9xl/@localhost.localdomain>
In-Reply-To: <Y5ik61/v+1gq9xl/@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB4514:EE_
x-ms-office365-filtering-correlation-id: a9aa6215-0a20-483f-9aa4-08dadd324048
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUPzb/6zS72l3MavJ/s3FhPISoVhESomCzhAVkB+0Y0WB3VTrwyGv2ORrJ6dMagD0DBPD7pNiO3PkZR0bzOnFkAjGmm+t3xDxqvLktaEgyZFFLL0BZO8b7asAPHWPNF+f7/p5K2aRIrUJtqewbwO7vAZqvrmRRb/Xo9Jvl0t1rZ+uiZniGHcE8bj5MrRHVH6tIhFh/1iZWGvVWLLywACVm4JwGrEaf9iFWkTJjgaUI4S0cUWAMeoHHFN+jzjJv5V2womhALSh8ptJQ3Xl2A2glJ6tr12w2PWzKZJdCZ9RuizpsP4MyYcFSR3BE8VFX5vYKFomINwP45ScTOeIlp/XJbK0QP3ukKdyNxRSy+JHEgV3CqdOWDeDYs4UHUgVG6+JjGqoQtDn2oFdu5F/1V2fhGnKKZHk0zyCNDXMozTZRoaFC39em7Jay+hEOccIizdnFxQTnArWeqDEfiwaJ18+uwvabxhO0KfUJ35fz0KGJfjikKKLwKu0sdE8fPXzkb76AaycuhP6YC5cU60w1UatA1yxXAX4hBPdilF8lY1LAOXJ9aMhHphu7t9o86hRSoYl1z8NYaJcyqtaA6qgCPJwEQ7KJG9CGP4DTnt7w8sOlwRAZfGI6ddg6FrFGL/owJVirlKCxqdUva/OsawooRSZKxFwRSX7ZGrs85UzSK7bZsfKDsGQ4EGIUgELNhjIQyw/shFD7EcoZyeQj9FyEzbXRmPnZZ2oTXtaEPfQnkD1PWYfg8Q2MaRz9C0caYiWIH/dUJMX3vTNNaaaFGK800Z7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(31686004)(36756003)(71200400001)(478600001)(31696002)(6486002)(86362001)(54906003)(6916009)(316002)(38100700002)(8936002)(82960400001)(38070700005)(122000001)(186003)(6506007)(53546011)(6512007)(2616005)(66476007)(26005)(66446008)(64756008)(76116006)(66946007)(5660300002)(91956017)(4744005)(2906002)(8676002)(4326008)(66556008)(83380400001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUtJRzFvUXFJY1dlbnkyYUVjbFV5V2d2L0QvMDRIN0R2ZFRHQUxJOEhCaUN2?=
 =?utf-8?B?cFd4OUlJMG9LZWx4aFhPQWdsL0dZYXVzQ0lRcDRzZWFGSUZrVm5zaHlLekVO?=
 =?utf-8?B?QWIyNms5YVhuUWlzUGg5YTJWRTN1REI0bjJPU2k3L1QrMzB5cVdYUHVzdXNT?=
 =?utf-8?B?cG5pUjBkT0E2b3RMZzVvTDU2amFPWFVDU3dkQ3BOam9hQ0p6dG9xSG0yVkVJ?=
 =?utf-8?B?YmJ5eXh0bW8vR1RMemxrcjhFU1d0NHkvWjFWalRsV0VsWTJrVWFBWmhKU1FC?=
 =?utf-8?B?RXl0UGJ1bUlleWxET2g5ZGJOeGR2N0YwWExVdjg0Tko4YXZLVEd4V0ZTUEhW?=
 =?utf-8?B?UnFsSjJ5bTM4R0dDTDY0WWN6TlNCcExIam15ZVczTFd0MDZKaEJGNmFnQzNH?=
 =?utf-8?B?UUxxd0h5aHBVSTRlVkkzbzVkN2d0NWc5dTF6eDJ1NlFoY3Z0eS9NM0lOcVNz?=
 =?utf-8?B?MldaZUJDTjBWVi9pVDJjb0VwM0k2NDVhcHc5MEJkNXdzS0ZDd3MxVE84NzZ1?=
 =?utf-8?B?cEVVUGpoaW5Odi9vMlFzcjBXKy9MQmlOOVQrSjNlWkZiSk1ldDVPSG5NTGR2?=
 =?utf-8?B?RUJnVjNmSWtPMmdBWjNZN3JuN2dMSUhnOUwzalZCTnAya1pMNHVOZG9PYmhJ?=
 =?utf-8?B?Yk8vSVBqbm9NK21JWWFRQXQ0eXp5elhRNVpiZ1pldFFvaU9qazRaUnZvajEr?=
 =?utf-8?B?YnhKWk8yaDhsR0hXSkFZd05aZ1VTSEdqRnh6ZkQreFR4NlNDazIvcm5DekR1?=
 =?utf-8?B?WnFkdFlLaWZ3UStYVnlsZ0pXZ2RDNHhZV0ZrcEdtQ3RreXlWcWUvSXdQNlZQ?=
 =?utf-8?B?UjQxT0RCdElWbkw2bE5yOEVlT3o3WlhLemI4cXR4OWlTdDdnQkd1U0RhMWh4?=
 =?utf-8?B?Vmc1L2RWL2RmMmhGUWE2NDBKZ2VDbzNZZlljNUkyanFla3ppSDQ5ZnMwOGE4?=
 =?utf-8?B?cWZZTXRJdGNJZlhFWmRud2ZQODZHNEdaeis4K2J1WGIzNVlCbFMxT0hhaUJ2?=
 =?utf-8?B?WVdzOU1Nek5ndE42b2FkUXhBMEl5RWFkTjJMU2ZURVZ6SnZCZEZJRUNMOWNQ?=
 =?utf-8?B?MUo1dmVOZU4rTURjNDltZXk1T3ZoYlduV09tRFVmeWFyenFKc3dUL3RvNXp5?=
 =?utf-8?B?TUlJWkJpaDlDRUdlNzNuVjlhNU5NbStOWGZhSmI0SzE2endpVkRxRm1BU3dr?=
 =?utf-8?B?c29rZWxLLzFlYm1iR0x1bG95RG9QUVQ5amVET3hWb0tzSG9scDZVY25tRUNp?=
 =?utf-8?B?TkdHV000K2s1a3p3bldETFBnLytGSUdvOExrYU1TV0Nxbk9rREpPcENxWWp0?=
 =?utf-8?B?WHpxWDdmVzRXem5xQ1VWUk9UUlVOa0RrQVgxVjdiVStlOUt3OUtEakdRWm9r?=
 =?utf-8?B?SDc5Mzk5cHZuVnY3RDNvWWZXOXBYZUxsb0g4Wm1xWXVITDVnTUN6dzBFNzNi?=
 =?utf-8?B?N2xZYVFSa3dXU2JpYkRDVnM3SVpDQkFLWjF4clBZb0hwMlcvR0l5OGt6OXhq?=
 =?utf-8?B?YTN3eWR0TEEvTWY4RDA5d0pTYXVqb3BHeENnUDVCaExSbXcrek5aTEFFS1RO?=
 =?utf-8?B?R1VqVXpVZDl4Zk1seU1reTcwVGZISCt1UWl4WXVTS01jMk4ydXZla1c2bUJ1?=
 =?utf-8?B?UHJ5Ky9qVkRIMHhVSWI4Wkw4YlN2NmcxQitzeHZNSzdEclZSKzkzT0tLbTM3?=
 =?utf-8?B?eG9US1hJTlNqcFpFSTV0TExzYi9KemtNU1M1SmRQeVpwRmFZVDMrWWJqR0Ur?=
 =?utf-8?B?eXZZTWdBNDkzZGQrb1VkeHNjeEZJa1BNbHVuak81ZFUrZTFUK0ozS0JTQm9G?=
 =?utf-8?B?TW13SUJRa0pkZVNjRGprQ0hoamVNOHRHb01uVExPb2p2UjlWTzhZR0d5blJM?=
 =?utf-8?B?cWlidUhxajBqTnc4R0NoNzdqRTNyMU94K0lDaUNxWGtWL2hJUGZHSFVZQlZE?=
 =?utf-8?B?WWVEejUvdklGcUU0cU9Sb3ZHcGRBTUw3azdncXJ3VkhZTmMyZUFRNDNFY1k0?=
 =?utf-8?B?MFJDTWdLcEltRGhCbW1qZjRoS2tyT2lkdld2WGgzYnc5NUF6WlA4TVpEK1Mx?=
 =?utf-8?B?TThFaFc5cXZaZnI0NGNMY1VhMkUxQlVLUEsrMnpob1owSTFGZlBWQmoyV0gy?=
 =?utf-8?B?cklwWjVENFlqS3lCenp0QzE5c3k4QXZxMmlsSU0yZWZmaUQreWJOZjVBMkRa?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24FFCD17B04C9E499EB87678F751AF59@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9aa6215-0a20-483f-9aa4-08dadd324048
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 17:48:32.2637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8C6NDbH65QwWIGvA1TFyKfm0dxKkcd4kuyo8cLQzN0Nm7GMUMl+0GaOH/OHi73sYKvL4eFcKLtsYYY0RNFaqXSIvgP4bN2arrCq06R/5Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4514
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMTIuMjIgMTc6MTQsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4gKwlyZXQgPSBidHJmc19p
bnNlcnRfcHJlYWxsb2NhdGVkX3JhaWRfc3RyaXBlKGlub2RlLT5yb290LT5mc19pbmZvLA0KPj4g
KwkJCQkJCSAgICBzdGFydCwgbGVuKTsNCj4+ICsJaWYgKHJldCkNCj4+ICsJCWdvdG8gZnJlZV9x
Z3JvdXA7DQo+PiArDQo+IA0KPiBTb3JyeSBJIGRpZG4ndCBub3RpY2UgdGhpcyB1bnRpbCBJIHdh
cyBsb29raW5nIGF0IGxhdGVyIHBhdGNoZXMuICBXZSBpbnNlcnQgdGhlDQo+IHByZWFsbG9jYXRl
ZCByYWlkIHN0cmlwZSBoZXJlLCBidXQgaWYgd2UgZmFpbCBhdCBhbnkgcG9pbnQgYWxvbmcgdGhl
IHdheSB3ZQ0KPiBzdGlsbCBoYXZlIHRoaXMgcmFpZCBzdHJpcGUgZW50cnkgc2l0dGluZyBhcm91
bmQuICBXaWxsIHRoaXMgYWNjaWRlbnRhbGx5IGdldA0KPiBpbnNlcnRlZCBsYXRlciBhbmQgbWVz
cyBldmVyeXRoaW5nIHVwPyAgVGhlcmUgYXJlIGZhaWx1cmVzIGRvd24gdGhpcyB3YXkgdGhhdA0K
PiBkb24ndCByZXN1bHQgaW4gYW4gYWJvcnQsIGJ1dCBwcm9iYWJseSBzaG91bGQsIG9yIGF0IHRo
ZSB2ZXJ5IGxlYXN0IGRyb3AgdGhpcw0KPiByYWlkIHN0cmlwZSBpZiB3ZSBoYXZlbid0IG1vZGlm
aWVkIGFueXRoaW5nIHlldC4NCg0KR29vZCBjYXRjaCENCg0KDQo=
