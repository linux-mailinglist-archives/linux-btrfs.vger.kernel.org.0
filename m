Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52116603B81
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJSIed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 04:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJSIec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 04:34:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C7B867;
        Wed, 19 Oct 2022 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666168469; x=1697704469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EgZt882yqwf38ea0uWyFSygZ9gID2wbwuHBaknJCEN0=;
  b=EkpEMe7NmdJ8klMowyJZx/MuoOGbTpkr8Jw+9tcu2sQnnCQoo8R3LTf6
   mMrXps0ijbWQWUl/IdQnq/k+c7ql6cQHCTAzWMb9yzty6YtVt+oIEFc9D
   Y3G6m8ZaAcXRMXXXgoP3It/B28exxUpXO9rQef77LE//5NDZfkj3O4LNV
   Ih+uQQybeUpe88B4VWuwn1IzXzTxmZBV51hP86hpdUrMQ6NX58u7PslUl
   ihi/qGFdGG4MjY8RMDDv8Rdij3gdwfhwRpYRCw7ZmFFnuBcTfGWDEx8f+
   cSTMS4d/B9Pz1dEAQQZjRcN/q6jQOCKS5084Nk1DnHkDcasvS5TBlE3l7
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,195,1661788800"; 
   d="scan'208";a="214590053"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2022 16:34:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZlou/B5CzkWpNPuMNfoPRXOX4c+q8ekNhwu+59tDlfUQXx2aJk+ZZqMEfPFCPVj3iLm2dg7rwG2s8odqTbJt+yL9eavI0wd+uIIbM/CiVJq3Uz9Bb/QbxpD+vU0VZM5fAy/jBwx2azS5AaTmpT+fB6YJjOA0ML81SzxrXlMenhz1ZO4NkzbdsHP+b4E8YnTtfEhQFSRymtfk6QOAbNzxH3LUpkKy7kf0bTZXxxHkO6LPSrSuY3uWx3EMhg5TKY1dgbj+9Ub1A/ttvmhQxocYPViAXlhX0y3nqL2X7adrThD6pCE999zG5EgKloNBZvbERfJApP1AVz9MoIJIy+Iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgZt882yqwf38ea0uWyFSygZ9gID2wbwuHBaknJCEN0=;
 b=lKhT+i3Ogxz77EhJtDyOvQbBpMe8Coi6yMjB2EeINdfZV97P4ZSTVMIlfWgnlkkuAZvk0fvH5V/06LKF87YT5Z4Cl7XZEfjLTzNHCca486vyzfSD19kO/tbLTQVvtwWz5XkM7lzHFaCr0GO5o3L5Lsbcm4uNlcwA7kUj39REKGoZ4wL1QAdR9ooBPGgchgi/7x+Dg8oEWehIeESB7wwNSG9db+5XxoLD7tyjMu4HsIZEjky0tNN6teyyF33h1PO2dixYx0urojtualdmP3YnSEVeZIXDrv2Suu2W0BdQNORpnrZ+ZKUELvgPfZg7W/oOMD9pOd9JGh7OKDRIQ52gDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgZt882yqwf38ea0uWyFSygZ9gID2wbwuHBaknJCEN0=;
 b=w5a7mO1OzHWR3FB/pk3X4FHvHqHd4qMWfAtNJsA2fSEN5+xzPiJwXCsktZm4PmUNxd46slM8Ebfn6DtMWlwlzJbDF8rIMkVKyemVJgFJ0c+7AVMLOAS4wS3zvLc65omqlwwfxi95tZn4gVrUC1uoA41mtg+4BS1Aox9NiHhkAWs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7913.namprd04.prod.outlook.com (2603:10b6:208:338::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 08:34:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 08:34:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Zorro Lang <zlang@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: add btrfs tests exercising raid to the raid
 group
Thread-Topic: [PATCH] fstests: add btrfs tests exercising raid to the raid
 group
Thread-Index: AQHY4gX/Pv5TrwurvUm6lfyxP9/i9a4UejUAgADs8AA=
Date:   Wed, 19 Oct 2022 08:34:26 +0000
Message-ID: <c8230e46-3bf1-c419-91ea-47907b70aea2@wdc.com>
References: <20221017085317.96172-1-johannes.thumshirn@wdc.com>
 <Y07v0MWnbCa0zLhT@bombadil.infradead.org>
In-Reply-To: <Y07v0MWnbCa0zLhT@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7913:EE_
x-ms-office365-filtering-correlation-id: eb3795a4-10ad-4edb-317a-08dab1acbbd3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLUKo6MBWTXyLfHcQLOJ//LsbY4QTRmOc8QfNEm0jODR24ISSDZN5NpgjHveaAz/jxyw7udegIicLMyDJ9oU2W9sPI6NoE2Yf/s1uRnxr9ZLX4lXoPxrDiraI8M3JeY+e0/3Os1E36cBnHI+/l34fKm32cpgWrrU1BUucyc2YNUpkJi5mVVnYzgJk5CvfnGlgups90imM9JeqfcArHrPtf7ueN2JYJgs4x5JqiFZsmEfEcaIlKtAlY0AI4qilvkmfWsGyw2OnUbJgYhjTWh1t2WpYLbzdXmNcyYLYvh3980x1+GGzHD0F9KQ1qOW9dgNu1mBmfrwkoYNQekAgOLjAp3o2BBQIN8XJcx9OfoUXzWC3+s+QXV6AuPdqJ7QmqZQ9K4zjQPA/1npMCCC+98FI8ZAt8v8K2YFlBaX1k21A7fjREndiTGO92Jwb8zZBV8iWADS4KjxUD2Zhp+20137r7nbuQQCO4DWXVzdpKzn836NwHerQNVQZ7q9U6/aXyPJoqpVVFX6thMzrkk8KEfgIB1dtWJVeD0jWj0FqTRLvw80lty7TwuzjEXCyqm7I+CulyvT01scFyYKFqHk8f/3dfe0Xr6zbFVib47Ccsih9B70wdzThcabp/6t4YI0UIDQ3Eb9P3bWs6dWh9sHFgpV3kp7Wn8OK4o5mQOgeVSeilrYsLMQHr38iHMtNLDzudyFNfQrGewpOymuQ/0jo6DfaKclgFjqO+scXKuJLuxcKQoyRVd5i0CGJOPW1GtJpTtg2vndMOch9q+aIQSLUfoayHCoruFNcFoSBF0VtbiBlH1aIoPO1V1Yw9Jplu2iqPsgp6/54LP7StHsOOJwCR1z8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(41300700001)(4744005)(6512007)(186003)(64756008)(478600001)(38070700005)(2616005)(36756003)(86362001)(2906002)(6506007)(53546011)(8936002)(5660300002)(4326008)(31696002)(38100700002)(91956017)(122000001)(6916009)(54906003)(316002)(6486002)(71200400001)(8676002)(66446008)(66556008)(66476007)(76116006)(82960400001)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGl1NHFFbFdWZEdabHd1ZXdRS2lFaTVaSFg4TkdRQ0hhb1pwclV0NU9adkp4?=
 =?utf-8?B?UnYrNVVnUHFwTjFWVkxmOEkyQjJnWkJ2aUgxSzZuVUNaMGladUV4SmNhOU5m?=
 =?utf-8?B?YU4wdmYvK1Y2SXg0ajlZU3NBVHREdU5SMGdxSElKL3JGZ0c0YmhTRGloc2Q1?=
 =?utf-8?B?THpyVldjUVd6ajN3VERtL0o1QWhGUHBNOVNmOUdmeU5Sc0Q1cVNscmlxSHB4?=
 =?utf-8?B?dXIyZHdrRjd2ejhuSHBINzRkdktGQmhPRTFhdDVlKzFKSmR1ZnBuazhjRFM2?=
 =?utf-8?B?d3VXblgzcjNSM3lzVkRCSFVycWJROXFXd0JFV255VDcyN29MaTl5dllpbEx2?=
 =?utf-8?B?SzhyckttNHNzS2RQQWg5WVhUNFBLajJubUJmOVdFTmpCcUJBSVFRYnpLc0ZM?=
 =?utf-8?B?b2JmcTk5VE45QS90d3FGUnptekZkRHRGSVp6eDFWV054V0w4R1ZCcU5nN1pz?=
 =?utf-8?B?WXRzNzRVeWY0UTdUVzNXczBIUVlUVGJHVk00NmtkdXFZRGY5S2NQYnk5cWNE?=
 =?utf-8?B?OWFBdUFLZzZETU5VeUN6RmJ5S2Y5RWdvSHEzL2pHWEVNbUhqTGVJRFdHWnZM?=
 =?utf-8?B?VFcyamtnblJmeW1GWURFQk1CVGxnTU9qMi8vV2lDam5yNk4wb2hOakZWZThE?=
 =?utf-8?B?MFBUczROU3czR0MrOXhHc2s0NGh5U3FnRjdJV3QwWkZ6VWhnazFadklkZTVy?=
 =?utf-8?B?QnY3eWFZREpKVGc1N3JycGxtc1NqOGV5cnVVRzRxSGwzdUk3M1crdHB6ZnZj?=
 =?utf-8?B?ajg1U0JldytpZS9aclB0UkVGZExkaTBFdU1XSHZBZ3UrRzY2bGRhQUlxZlNG?=
 =?utf-8?B?Rnd1cEw3TGFnYjFLSzdaNUduL0ZVY3hXYXdvZ2NjSSt3dlh5WE9pdWxIWjVO?=
 =?utf-8?B?QlZ4TklRamNnZ25zRmRhcVQ2bStHcDNmVTRWYnh2N0ZyUnR6UXU3eURTOG1W?=
 =?utf-8?B?ZEFOUnJ3Qm1JZUpQV2VBNms1OWhMVVVqelNDNTJQdXJRbElYSWZFM3l3eXVY?=
 =?utf-8?B?WXRYMGtlL0RwWk1Yc0FweWZ6dkhGMGdSV2ZuOS9FMWVYbTZVcDZQWGRneWJo?=
 =?utf-8?B?cFpBVkxuSWJMaGdkeVo2UjlvbzJBYmwyMlFyUHVUL0xHSkZCeDFyZDVaSjd4?=
 =?utf-8?B?VGQ4VEMwVXlUQUpQbjc4RzRkQ3pnUnNqb08yN3BqY2JrYzJCL2dLbk5pdVlp?=
 =?utf-8?B?S3VPekx1dnlJRFdQNWtya3Q5YWNDdk9RQmt0YmFsRzdhM1JHQmEyK2p4cCt6?=
 =?utf-8?B?b1ZybnFZcVBCc0w4b2ZWcUtkVEZCcHZ1dmZ3NHJIVnFwNENTSVU5cmlhVTcy?=
 =?utf-8?B?ZXA5Y1BOU1hVRzN4bWJlQnVhMmx3cE11TTlRZnFCakV2RWdYejNTa3lzKy9q?=
 =?utf-8?B?UXhJcHg3MVZSeWR2eFZyVlNPRXdKdURpbkVhWFk0SkZsUjhDUzFRaGdIeXBI?=
 =?utf-8?B?VTBYdzdheldsVkdpbE9jWW9NaTRwbEhoTWhxSWl0THduUzZwaHF5OFErRDVr?=
 =?utf-8?B?MU9IWjVwM0NqNmRsTTFBRVlTNFZ3T1lUUitzVElMcmxiaTBkbnpSRDlHQjhK?=
 =?utf-8?B?UUdVQlh5VGJQNTJQbmVwYm1CL2Y3NjR2dGJQd0g3SWJOZXdjM21ZWHNEU1do?=
 =?utf-8?B?K2JmeUFGa0RMWDlITGlnM1dERmErNkE0SGZZbUprSGVxWUIrcERMSE1ubDBm?=
 =?utf-8?B?TEJhSWJ1bUIzTGtjN1pqU1BZZW44U3BOUk1KQ1pCWUVhSUlTOXZTcnc2Q1Qx?=
 =?utf-8?B?eFZKMUlKVEdiNm1Na2tjQVEvQkZRc1Z4YmtrRmF5MVJmWERNMlFxSENOeUEv?=
 =?utf-8?B?TmFlTXQ0dDEyemVJRWF2UmIvZTd0cVI5NEdaYkhENmhRN0Rqd2Q3aStsZU10?=
 =?utf-8?B?VUtUQXhQdFNzcUJKYzVYS1BjV3U3YkduVFRyVU9mb21ZaFJrWVl2OWIraUNp?=
 =?utf-8?B?a2UyZ2xKM0I4WVZRRTRXYzM0RTJsUHQ4aEJJMzc0d1hVME01K3FTeDBCa3pt?=
 =?utf-8?B?R3BiNEsxUWVlYi9WVDg3S1VhK2xxeWN5K2Y5cG8yeDBmcjZzaldjTjk1cTNi?=
 =?utf-8?B?MnU3eExHenFhWUJ5Njg2ODl3cGwvQVBybThCb0pRb2wzcUZSS0VzOEQyM0lq?=
 =?utf-8?B?eXlpU3U1Q2YwZ3pWaEFWVWJGOVZNRFpGdWZwMDI4ZlhpckFUdXg3blRWNURp?=
 =?utf-8?B?WkhBeGdBR1dPQy84b2N0a1RsSHJTU0tmc2FKYXo5YjVWa3hQZktaRDJvOXBj?=
 =?utf-8?Q?I4R9k4Ni7b21cA1dvXf6fc8TZRA/mQhwbqE17jIfVs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A093EE29712544CB6FA4D3BDD8B51E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3795a4-10ad-4edb-317a-08dab1acbbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 08:34:26.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cB+orKfrZwesmXSx7O+9guF3gkqjKX2TkYN3gS9QOtuX+RkgdFOA6FOGy8pRPl83z1TAzbtK3+lFEAyCkEEQlF7cPHErckqAIVV/6L5kHJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7913
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTguMTAuMjIgMjA6MjYsIEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+IE9uIE1vbiwgT2N0
IDE3LCAyMDIyIGF0IDAxOjUzOjE3QU0gLTA3MDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToN
Cj4+IFNldmVyYWwgdGVzdHMgZm9yIGJ0cmZzIGV4ZXJjaXNlIHRoZSByYWlkIGNvZGUsIGJ1dCBh
cmUgbm90IGFkZGVkIHRvIHRoZQ0KPj4gcmFpZCBncm91cC4gTW9zdCBvZiB0aGVzZSB0ZXN0cyBw
dWxsIGluIHJhaWQgdmlhDQo+PiAnX2J0cmZzX2dldF9wcm9maWxlX2NvbmZpZ3MoKScuDQo+Pg0K
Pj4gT3RoZXIgdGVzdHMgaGF2ZSBhICdfcmVxdWlyZV9idHJmc19mc19mZWF0dXJlIHJhaWQ1Nicg
d2hpY2ggYWxzbyBwdWxscyBpbg0KPj4gcmFpZCwgYnV0IGFyZSBub3QgYWRkZWQgdG8gdGhlIHJh
aWQgZ3JvdXAuDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBr
ZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gDQo+IFNob3VsZG4ndCB3ZSBoYXZlIGEgcmFpZDU2IGdy
b3VwIGFsb25lIHRvbz8gVGhlbiBkaXN0cm9zIHRoYXQgc2ltcGx5DQo+IGRvbid0IHN1cHBvcnQg
aXQgY2FuIHNraXAgdGhvc2UgdGVzdHMuDQo+ICANCj4gICBMdWlzDQo+IA0KDQpJZiBpdCdzIGp1
c3QgZm9yIHNraXBwaW5nIFJBSUQ1NiBhbG9uZSwgSSB0aGluayBhZGp1c3RpbmcgdGhlIA0KJHtC
VFJGU19QUk9GSUxFX0NPTkZJR1NbQF19IGVudmlyb25tZW50IHZhcmlhYmxlIGlzIGEgYmV0dGVy
IGNob2ljZS4NCg==
