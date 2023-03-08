Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9BA6B0280
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 10:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCHJMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 04:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCHJMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 04:12:14 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B7A3BDA5
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 01:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266724; x=1709802724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qzL7jrkUxP+la1VZlPmewmNCU5JixiIigycQitzAU6g=;
  b=bUYAq08L2bJynCMfOJQla8cCQHY9Iy2HFUwBed4Yav8gQIMU2nYo6Glh
   kR2s2sNbXtUIZqMa9opHUicKX3LIvZ2GvOXSy3ySGPS+R0BAKR4/JHB5K
   BOm61EcQZgPjJjwsuaT5EFPHX1dUeNMQow8j+7VJulh5GAexTQm7AltxI
   P2w7IE5QWZcT3WRIGLjrhtlYBacBREARkkD6LSqbCTWFtp65atNmJHynz
   4B29BFDfeT/0PD0QvubQbBdcsYh+Vq76kGEk2asdgA9HusknZ1k6SzbqT
   rgNC8N2rFiECXrFMy5k6xLliQNk0tyZCxdjT4qgXwP+OUItvVgaivduGj
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="329450401"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:12:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUqhIFu71xsXcifmGGnYokLMggAfg4G4o9c4aw5VBjw8njO8OxhgNvR+L2F42C2HPD3lDPO/vH2B+Vg7yRMu4DV02VxEbzjMW5Uj5BlCwY7CN8SgqN87kq0HanFaeF/mOqyVEvjhPi3XF9+M85jrOwSLtp7MM2uyiu7SCn93PyYv9ZMQCo0Bi/akN8/Uk9/Qmg42IHlY1KX6t+dW2xSBGBwZiDvPypa8/wGhV0LcNExDnLmh6rKmljYiV3taPo9xfT9d9L3lvQecB/lv5DGUGS9jrpi8gRKLP8ZX3exnyTGuNb84Pr5lpr/TkQp2wkGtIvLNUsAyidH0ae/gWGT4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzL7jrkUxP+la1VZlPmewmNCU5JixiIigycQitzAU6g=;
 b=NDCaWNPa1EuCXVyYiM9Hc2wWiag9SizTO0nask4W61XytCYwxVwifw7DvkBSysw57/9oldrI1ySorj7wDbmsejnaCxe6Xl/kQiPIgVCAiEBf0I2N7oQyntdWalu2BRc7W/vaOcNL7qIhG6rY3JBc2Fec3WGPS4AlZ/xGl+X0uyQogFrO5dcLEMwE8cEdsfTC0xE452Chl57JmCxXcAVUpwJUldyfSAvFH6NuFoL+LbXpq51EbXnxkoxYVUzd3+FOTPezHSjwmqR4pgBV/yeHm6C7kb4sAvzpuwIR7qbyBsiYdOgFBNGXz10uBzjAsHbzrb5IZ+r9SI39fJfKe27rLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzL7jrkUxP+la1VZlPmewmNCU5JixiIigycQitzAU6g=;
 b=I2ZIK+VGDW0cXLwDhSciwJhy7Dd/DN024CISADIuJDq178cuWzL6r2zLWwiiJGw8w7ubm8xhJH3W9Yhmu3yNtu5V5JgaeHA1ZOwVj/7VvEBtiDu/3ux7A51fhowazbNSHaQPUb4uXkgqQumKqUygq+pOMeDZ3SvGPUATxefHE+E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8808.namprd04.prod.outlook.com (2603:10b6:208:493::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Wed, 8 Mar
 2023 09:11:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 09:11:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYCAAAWhAIAAA46AgAAikQCAABkfgIAAdl4AgAEG74CAB4aIAA==
Date:   Wed, 8 Mar 2023 09:11:54 +0000
Message-ID: <e9e7820b-9cf3-8361-cf3c-e4d59baa5b21@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
 <ZAIBQ0hzLTjOIYcr@infradead.org>
In-Reply-To: <ZAIBQ0hzLTjOIYcr@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8808:EE_
x-ms-office365-filtering-correlation-id: 5f39a4ab-776e-4bda-c7b1-08db1fb5297a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4ZHrJ9tFB7UERDqhkffNyj6Xb1UfYTGWWbJ1gInG1wnQD7lqcCxMIREnnOmudm/Kk7twIoBM78pIsgAkhD4gnnkUOg0w+UQMkuia46lBTM9uX3kbCW8sdywDligKdcIx3DztGUyS4eROTGkZ/0FnSwvJlQEdSejz2yzYLJbqaeP+Jp3r1vc5JNGoA8M1J0K3LTf32BLGqi6edqdAsDXRyUD5w3GFll2c5Q0SgjD6He2Ixa5CjaICFqrWBE1fWYWk8MI0EWYZ2qZkydLDsB9+DGD/SADva+NX29jRabGIlftID0jEj3P39ieqf2wzI9Kmn5VtvF4Fsdr53Y2ie24igNqwwOGDBjWS/dQz8f7zkro5I6stelQM/Xuiz6IwY4Oo6VSonX0SE78rFO6mzvwP1eRro3JFjuof488UV7GKYpMIC0FRQW/IF9Ek4XFujgUhr2PM99JtNsgpTnKAQgJg4SbZ4RV5u6aqfmVZAqFA/g0mFReoTm4tfpYJY6cV5Cl0B0g9/yqJbL6NkDJun9Vb7PTJ0/xxazNsRc3hjZUfgSO/2bnAJ3jRdVQw1QdIsNIgsuxz4MqdCQQO3v7703jbdP2x+K3OeItT1BU07UoN2xHmtNQXxUnVUVbHRqbK6Fi58u+sioxBgbhxcxFqkEXBUnfG/qL9+KBjJt0/k5I80ccsbHnITZy6Ixux1VVV1CChmwJVFiw8BKTEodcA/86DjA0iPKpB3RK99K/QfaZar3oppGbsCDoEkQQsrg6ejtt1P+oG1Z470GaMTufFX+c1K7L9BUMO9pk9Vxwq7tiNfWlevTBbR6JFhQBUzewPTQ9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199018)(122000001)(110136005)(54906003)(36756003)(186003)(53546011)(26005)(82960400001)(6512007)(6506007)(71200400001)(2906002)(6486002)(8936002)(38070700005)(5660300002)(2616005)(478600001)(86362001)(91956017)(76116006)(31696002)(41300700001)(83380400001)(8676002)(4326008)(31686004)(66476007)(66446008)(66556008)(66946007)(64756008)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTI0dlNBM2ZVR1RTZnZVNjZWWFpMREp1Z3dqVElWUkdHWWpPaXpwSUg2TEV2?=
 =?utf-8?B?Um5iS2dpT1ZvcWlxd1kwRUFoVFF0Z21UTEk3eFBWRW9SaEp4SEIrbnc4ZW5j?=
 =?utf-8?B?U0pJYWNqOE9yQjJLOVhhTzhFdG9hc3YrdHdIM0pSOHV5c2tqb3JJUUxvZWtw?=
 =?utf-8?B?UkVSUVc0NkloNE9NUkZaK1JFZkhiZVVLYlRrUGFvME4xZ3ZQZGdBQlhHZXN0?=
 =?utf-8?B?ajR2bFRzWEdiQnhaZ2w4TVNsdXpLcjJhNElwcFBQL2htS2wweDlVeWNTMUNy?=
 =?utf-8?B?aUZNT0tUVTQyUkl1N0xieWVWMjNmV0ltNDByQXdsYmRXckhNcVVTSzJpUUlI?=
 =?utf-8?B?OG9YR2xrSUpQbWdYeHdUVzdQRmxURFBLbHF3MmdRNzNTTlp6d3RXWmpENE1k?=
 =?utf-8?B?NlBhSDAwZHhSWUxZWWNNYm9XWGpIN0dBMDladjlmZ1FsSGppV012YXJuK2pV?=
 =?utf-8?B?dUZ1ZGpBSE9FcUVHQmJ6a05UOWRKa2NMU1F1TzIxeVZuZkFqcFFsRGlBZmJr?=
 =?utf-8?B?d3ZWaDRtRHpTQytyemtGbTVzeHhnWldoSUludHdwaTRMeHVQalB1QWF2WWlJ?=
 =?utf-8?B?QWdGZGEwMFNUSUJtZ092aktGUnNIVXJ3U3I5UU4raU1ESDlVUmxCWCtxcjY2?=
 =?utf-8?B?aDVyUmVWUHRHSTdQL3VKRUd6QXZrVGNSWmZzdFlMcU95QjArS21NTFBnRmMx?=
 =?utf-8?B?SDVsdmt4R2FsYjJCR1lnMTBlYTl2S3gzdmQvYUNJT0VrY0JuaDZiMkRsWldF?=
 =?utf-8?B?ci9BZnJkdWJObnFsSzFuUGUrNDE0RDdDWEFtU2kxZmRsRFBzMWhSeFczR1Qy?=
 =?utf-8?B?OVErb2tqU1JJTTdHU1FYc1piZWhLY1NDR2RXeW56TzJmeWxSVjhUbTNYVXdE?=
 =?utf-8?B?Wk1jYnFKN3VMN2puU21CenZCR2d2Z2lKNTY1OFJSejVBMmp4SGNpWFpES0d0?=
 =?utf-8?B?R3RrTVppZmhac1UydDRjTk9XOUQ2SVJ0NGJZQ2xVOUF4M2JiZW5VN1pKdHJR?=
 =?utf-8?B?NUJRZEJVQXBaVmpxK3JOOUdCdzMrNUdabnhMcGpPUDN2Nkg5YVJhUjhUZGtr?=
 =?utf-8?B?L0o3VitwN0Y5Tm9IcGpkL1VWNlIwLzJJaVM0SEdnOEZ3ODB4aGhzUk9JWE9o?=
 =?utf-8?B?alJPcURMaE9IWmtuUFZCZkx2a1dWaSt0ZU5sVUxxVnhOcld0anhkbUJRMjhU?=
 =?utf-8?B?eE5FaWNBYzVGKzNTaUQwb2JXdGIxbXpLSTdlaEt2TUFxY1pjdzlLdTI5MVJr?=
 =?utf-8?B?Q09MSXJwNVZGNG1ESmZjVHdoNmhVMGsyaGY3NDcvMWVOMENQd3hoUklXcW1i?=
 =?utf-8?B?dm1BOE53QllMdXF1Zjc3V1BhM1F5Sk5SSkpJN2YxOGkrdHAwMDNMT3IzdkFY?=
 =?utf-8?B?R0FGeE5pSFhvOTNzbWJYc0xwc1JUdWhCaVEvaTVjWFN3Rm01dml1d2FweWJS?=
 =?utf-8?B?aEowb3FCa09wV0VUUHZja3pYeCt5bS8yOXpldzByNmkvTnZxakNSdUdkTnNo?=
 =?utf-8?B?Uy9IeU11bllXRjcxMTFFQXNnTE1lYnl2bkk3cUlrNFlFM2M0Q2R1YzQ3c0t4?=
 =?utf-8?B?bStROHR0bFRnUHZ6ajhtZUliNjJYM2dOQXR2Q2JtVWN1ZWgrV2Mrb1JjUjZ0?=
 =?utf-8?B?QlNaWHZiSWJlVzFPS3pWNlVJcko3aDRxQkJRRmNoeUl4NWVJUmwxOXFia3pP?=
 =?utf-8?B?YnJTNll0WFN4WVNieWFBU0NmSW55ZDdhN0FCOHkvNXc0ZmM1Z0hLSlJ0bWRY?=
 =?utf-8?B?VS9EazdkNHFhZExqeGFrQncvaThJbktpOG5nTzNxWHNBcjlqM2NDRFNsVjIz?=
 =?utf-8?B?NTBQQjBQQjl0MVNKc3VPaEQrRFY4RTVIQ2tTZUdkUEt0RmRvTGcwMytZZlBr?=
 =?utf-8?B?SVhkR0FRSWJBWkxHd1d2TUxnaEZJVFF6RFZoZnhYN3U3RGVUQ1k0emRXRzlD?=
 =?utf-8?B?RHdidEVydVRuVXBBa1RiOENST3piaUl0Z1NRb21hSzRHK2xHVk5CL2xtYUg5?=
 =?utf-8?B?bloyS2lScnlyUDZWS2V3enduS2pkYjRENlYra1lRTk1ZNTh4dElqV09MYTZE?=
 =?utf-8?B?T3E5MlZxWXkxNFlLVWdPaVgxZll3Zm9hd3I0c0hkay95QmxrQ3JzZ2VCdE8y?=
 =?utf-8?B?QU82dUhVaGJlOVAzRHMzZ25Mdit1c3pzVzAxKzN3Q3BINkNyN1h2aU9hRGVX?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F3EEC3BAA6C154ABB2ABBE31F06C28C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TH0fWlwUhxGs7hRLeUKEwqriAa+7YtVfZYp0i36j2rFOnvH5GfotGzX/VqD4yz8g4J4Hajfo/cxDxEtDR1Fpi9uV8VI9agY0myb8DXSV3bJ8qoJO++o1pto9N1XNU3YxFrO9X0Q1VEuEERuCp6DcY5YU+hC+7QR3KaRLPw58VXr5OvkqWZp2cccBvtsDjbtoaUb3TJKwAAPt3TbyiyNTq0ahwlSczgLeAMAbEzr9/I7y8aH4hylOTIg3GYxZx8QTY6Ft6/WvD6vZLjxz61eb/U2Xd5xM4IJvFl7iL7zW+kCOuzTCJMLCQrBHGaFWSj1lh7g6Iri94RQWznWhg+Ug55EkKPjPOksBMha3zVjOmbYaU+zGYLuVrgOSVqEW1rWy2rKk1HlEpkhGWEpSBIFspbnL6FwS4CQizk2nj0c5ltT9s4/WRJ25YZPxbwtgbo6kjp5/CwqbVj65JmGojCCnF5HYxdGfMVXjJbvQabFHOiSwKwAP7jvwCS/Kzy47aTGpYY7w54x3ApyHLeDq98fwUdjBqBcVv1d0OPSbDz/dLDU2Avy0aCGfVSwpTTTooKuv2eCGiO6RI+lMNBH5HY71v2X6BMMmbTx1lD3XuO3hTn81UQKyfBEF/hduklzYjYKzBpMSYlBQcAX77uz71CcehSBK3KArYxrSUUbwDqQqosOmPukVQbpLHJWvmBZAls6F0xerOAp2ft+mw6VyMmWilIcJa3RGLthpzUZrqjmYJUMHOCni4Mz8CrgGu1hnEc8PnNiTYog2FiHjGCxyZ3nVAC0rV0YmwsbRpD8IwZOqNW0vcEbW6BOb1UlXuJIWw+cR6GxJxT9cXooeoEJRnaB+UGPev4fSDzMIgH0xvs1Ax8Tyoi0z0vIontO8JEJ67t8K6qjp7ZO47rurzKjuBMaaqTunsNuouwY8aU5cDQZSfBI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f39a4ab-776e-4bda-c7b1-08db1fb5297a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 09:11:54.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpHNdq4QG5bdB+bJw3TyrwIErjjINCIYYIHyKHFY+03ie2A2SHp4LtddKXwYNQxqEjwNJUT8eWdQk2no6mpzQuxs9gpiZ8w3TbG6oUUjd1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8808
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDMuMDMuMjMgMTU6MTYsIGhjaEBpbmZyYWRlYWQub3JnIHdyb3RlOg0KPiBPbiBGcmksIE1h
ciAwMywgMjAyMyBhdCAwNjozNTozMEFNICswODAwLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBKdXN0
IG1ha2UgdGhlIGluLW1lbW9yeSBSU1QgdXBkYXRlIGhhcHBlbiBpbiBmaW5pc2hfb3JkZXJlZF9p
bygpIHNob3VsZCBiZQ0KPj4gZ29vZCBlbm91Z2guDQo+PiBUaGVuIHdlIGNhbiBrZWVwIHRoZSBS
U1QgdHJlZSB1cGRhdGUgaW4gZGVsYXllZCByZWYuDQo+IA0KPiBJbmRlcGVuZGVudCBvZiB0aGUg
d29ya3F1ZXVlIGNoYW5nZXMsIGRvaW5nIHRoZSBSU1QgdXBkYXRlIGluDQo+IGZpbmlzaF9vcmRl
cmVkX2lvIGZlZWxzIGxpa2UgdGhlIHJpZ2h0IHRoaW5nIHRvIG1lLCBhbHRob3VnaCBteQ0KPiBn
dXQgZmVlbGluZyBtaWdoIG5vdCBiZSBwcm9wZXJseSBhZGp1c3RlZCB0byBidHJmcyB5ZXQgOikN
Cj4gDQoNCkJ0dywgdGhpcyB3b3VsZCBsb29rIHN0aCBsaWtlIHRoZSBmb2xsb3dpbmcgKHVudGVz
dGVkKToNCg0KZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Jpby5jIGIvZnMvYnRyZnMvYmlvLmMNCmlu
ZGV4IGFiOGYxYzIxYTc3My4uZjIyZTM0YjQzMjhmIDEwMDY0NA0KLS0tIGEvZnMvYnRyZnMvYmlv
LmMNCisrKyBiL2ZzL2J0cmZzL2Jpby5jDQpAQCAtMzUyLDIxICszNTIsNiBAQCBzdGF0aWMgdm9p
ZCBidHJmc19yYWlkNTZfZW5kX2lvKHN0cnVjdCBiaW8gKmJpbykNCiAgICAgICAgYnRyZnNfcHV0
X2Jpb2MoYmlvYyk7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIGJ0cmZzX3JhaWRfc3RyaXBlX3VwZGF0
ZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQotew0KLSAgICAgICBzdHJ1Y3QgYnRyZnNfYmlv
ICpiYmlvID0NCi0gICAgICAgICAgICAgICBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGJ0cmZz
X2JpbywgZW5kX2lvX3dvcmspOw0KLSAgICAgICBzdHJ1Y3QgYnRyZnNfaW9fc3RyaXBlICpzdHJp
cGUgPSBiYmlvLT5iaW8uYmlfcHJpdmF0ZTsNCi0gICAgICAgc3RydWN0IGJ0cmZzX2lvX2NvbnRl
eHQgKmJpb2MgPSBzdHJpcGUtPmJpb2M7DQotICAgICAgIGludCByZXQ7DQotDQotICAgICAgIHJl
dCA9IGJ0cmZzX2FkZF9vcmRlcmVkX3N0cmlwZShiaW9jKTsNCi0gICAgICAgaWYgKHJldCkNCi0g
ICAgICAgICAgICAgICBiYmlvLT5iaW8uYmlfc3RhdHVzID0gZXJybm9fdG9fYmxrX3N0YXR1cyhy
ZXQpOw0KLSAgICAgICBidHJmc19vcmlnX2JiaW9fZW5kX2lvKGJiaW8pOw0KLSAgICAgICBidHJm
c19wdXRfYmlvYyhiaW9jKTsNCi19DQotDQogc3RhdGljIHZvaWQgYnRyZnNfb3JpZ193cml0ZV9l
bmRfaW8oc3RydWN0IGJpbyAqYmlvKQ0KIHsNCiAgICAgICAgc3RydWN0IGJ0cmZzX2lvX3N0cmlw
ZSAqc3RyaXBlID0gYmlvLT5iaV9wcml2YXRlOw0KQEAgLTM5MywxMCArMzc4LDEyIEBAIHN0YXRp
YyB2b2lkIGJ0cmZzX29yaWdfd3JpdGVfZW5kX2lvKHN0cnVjdCBiaW8gKmJpbykNCiAgICAgICAg
ICAgICAgICBzdHJpcGUtPnBoeXNpY2FsID0gYmlvLT5iaV9pdGVyLmJpX3NlY3RvciA8PCBTRUNU
T1JfU0hJRlQ7DQogDQogICAgICAgIGlmIChidHJmc19uZWVkX3N0cmlwZV90cmVlX3VwZGF0ZShi
aW9jLT5mc19pbmZvLCBiaW9jLT5tYXBfdHlwZSkpIHsNCi0gICAgICAgICAgICAgICBJTklUX1dP
UksoJmJiaW8tPmVuZF9pb193b3JrLCBidHJmc19yYWlkX3N0cmlwZV91cGRhdGUpOw0KLSAgICAg
ICAgICAgICAgIHF1ZXVlX3dvcmsoYnRyZnNfZW5kX2lvX3dxKGJpb2MtPmZzX2luZm8sIGJpbyks
DQotICAgICAgICAgICAgICAgICAgICAgICAmYmJpby0+ZW5kX2lvX3dvcmspOw0KLSAgICAgICAg
ICAgICAgIHJldHVybjsNCisgICAgICAgICAgICAgICBzdHJ1Y3QgYnRyZnNfb3JkZXJlZF9leHRl
bnQgKm9lOw0KKw0KKyAgICAgICAgICAgICAgIG9lID0gYnRyZnNfbG9va3VwX29yZGVyZWRfZXh0
ZW50KGJiaW8tPmlub2RlLCBiYmlvLT5maWxlX29mZnNldCk7DQorICAgICAgICAgICAgICAgYnRy
ZnNfZ2V0X2Jpb2MoYmlvYyk7DQorICAgICAgICAgICAgICAgb2UtPmJpb2MgPSBiaW9jOw0KKyAg
ICAgICAgICAgICAgIGJ0cmZzX3B1dF9vcmRlcmVkX2V4dGVudChvZSk7DQogICAgICAgIH0NCiAN
CiAgICAgICAgYnRyZnNfb3JpZ19iYmlvX2VuZF9pbyhiYmlvKTsNCmRpZmYgLS1naXQgYS9mcy9i
dHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUuYw0KaW5kZXggNmIwY2ZmNWM1MGZiLi43MDRl
ODcwNWJiYjkgMTAwNjQ0DQotLS0gYS9mcy9idHJmcy9pbm9kZS5jDQorKysgYi9mcy9idHJmcy9p
bm9kZS5jDQpAQCAtMzE1OSw2ICszMTU5LDExIEBAIGludCBidHJmc19maW5pc2hfb3JkZXJlZF9p
byhzdHJ1Y3QgYnRyZnNfb3JkZXJlZF9leHRlbnQgKm9yZGVyZWRfZXh0ZW50KQ0KICAgICAgICAg
ICAgICAgIGJ0cmZzX3Jld3JpdGVfbG9naWNhbF96b25lZChvcmRlcmVkX2V4dGVudCk7DQogICAg
ICAgICAgICAgICAgYnRyZnNfem9uZV9maW5pc2hfZW5kaW8oZnNfaW5mbywgb3JkZXJlZF9leHRl
bnQtPmRpc2tfYnl0ZW5yLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG9yZGVyZWRfZXh0ZW50LT5kaXNrX251bV9ieXRlcyk7DQorICAgICAgIH0gZWxzZSBpZiAob3Jk
ZXJlZF9leHRlbnQtPmJpb2MpIHsNCisgICAgICAgICAgICAgICByZXQgPSBidHJmc19hZGRfb3Jk
ZXJlZF9zdHJpcGUob3JkZXJlZF9leHRlbnQtPmJpb2MpOw0KKyAgICAgICAgICAgICAgIGJ0cmZz
X3B1dF9iaW9jKG9yZGVyZWRfZXh0ZW50LT5iaW9jKTsNCisgICAgICAgICAgICAgICBpZiAocmV0
KQ0KKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQogICAgICAgIH0NCiANCiAgICAg
ICAgaWYgKHRlc3RfYml0KEJUUkZTX09SREVSRURfVFJVTkNBVEVELCAmb3JkZXJlZF9leHRlbnQt
PmZsYWdzKSkgew0KZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL29yZGVyZWQtZGF0YS5oIGIvZnMvYnRy
ZnMvb3JkZXJlZC1kYXRhLmgNCmluZGV4IDE4MDA3ZjljMDBhZC4uZTM5MzliYjhhNTI1IDEwMDY0
NA0KLS0tIGEvZnMvYnRyZnMvb3JkZXJlZC1kYXRhLmgNCisrKyBiL2ZzL2J0cmZzL29yZGVyZWQt
ZGF0YS5oDQpAQCAtMTU3LDYgKzE1Nyw4IEBAIHN0cnVjdCBidHJmc19vcmRlcmVkX2V4dGVudCB7
DQogICAgICAgICAqIGNvbW1hbmQgaW4gYSB3b3JrcXVldWUgY29udGV4dA0KICAgICAgICAgKi8N
CiAgICAgICAgdTY0IHBoeXNpY2FsOw0KKw0KKyAgICAgICBzdHJ1Y3QgYnRyZnNfaW9fY29udGV4
dCAqYmlvYzsNCiB9Ow0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZA0KDQo=
