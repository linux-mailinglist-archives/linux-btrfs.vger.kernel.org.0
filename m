Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D70651D0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 10:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiLTJTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 04:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiLTJTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 04:19:11 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B479FF1;
        Tue, 20 Dec 2022 01:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671527950; x=1703063950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1dqdSSpPwk2Y/Cja7N7/xJDZMAzbNMXdhKJ2LN5Nc08=;
  b=FoT4pztD8jWpwGxqu3RwLlNjcv673xbmhJqQWPL3vj88Z9XjShj4+E9H
   YS3ZZ3urAAKeSq0pi63mj/PEEg4GAQfW4sPZtCGJvE2n2fghYUlYcs2Dd
   S4UBUkViPSSCpC8PYfLe+70igCgF8iDaZK1b0LxrejrmNsERie++KvoTY
   xmPVbR3wJa4RYHEwRC7C8J1Mwq/X5tNoAQW/ndZ/aELMXJ2Ltg8TLJstc
   y/6XozmNwoCqf/TBOf8esDbvikVRzZZXyVPBhQzAvYnKu0/QzurTsOQ78
   JvXtWsfWZM1zxnrqSo39l70ocwY2Npfmg94D6wbcCgfotxQP2IZgkkXhT
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,259,1665417600"; 
   d="scan'208";a="219051858"
Received: from mail-mw2nam04lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 20 Dec 2022 17:19:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpX7LfaCgzN5PyfH6faRAoNU2bseQ04YC0QYHnNTmuFcsKDMjuDq56heP28Hgpbz7P+9RlBzlOV2Gdyn0VN/PtqxHHOrwx7mf8mnjltucqywpU5H9SLvDHR3d+rvvgKb+yZjG9oTyEcgT99cmHjcQMrkzLDebuBZkiKq6tg5AneBIO2w0GNaKncWlBrf/8QnJ126AIhQlTN20OHIqetItYboX2ErJcMvZhH0SaS8BMD0x/4Lz/0ZQgzoEODAQcOjjBN/ENeeohIb3Bi5uSYgFLw6q0wv6sloxREGfXspVE73C1COjcfXNzrqhsOWBjvg0zcJ8KtMxdBMxImikBUhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dqdSSpPwk2Y/Cja7N7/xJDZMAzbNMXdhKJ2LN5Nc08=;
 b=G4q2+NRA+NqZkso4gxqDZ2CEBnA5CKPKSg5BqvLQh1JjY1ssJZUN+VoBiN1k+M/9QLdXI99YSQHznJPTQELVInJIAJafl9wEL52fnI55cNA/NXF//Wkm3gpK4hqTHopd/0LVzWcXFQxsBFmqfwow6rU5B4n67/zixxVFSgSNLaJ4hXOIhZEAjJvhg+aDOOItyLScd3GnSwJEgifFGh0th7LFIA+GO5qIA03WYexZ1F9Kvf0oFs5+b4ryWqc6CzW9RR2oAHV6BP3CDlBkjYo8Qeyb4bUBDFYFou7kN9/h6cXTR+0ceRN/z4aDHSHJL6AroCPkkv7Ke3qMzR49ySBUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dqdSSpPwk2Y/Cja7N7/xJDZMAzbNMXdhKJ2LN5Nc08=;
 b=srJUWTL8cIjaqXaEFiWsFGFKmyTGLX0uha8w9vvEnlEtqT0k/R4tGyv6qDHvDljY80lf1MjTUAGeNUT1LuGH1r6RBBg9dcMWj4ByOMOWPUbMpPeXQlVYuJrbLmYzDg6j8uuDKfEVkRNOk1YfMcltH7FQUk4tzTYJmAYjUbJGZWA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5507.namprd04.prod.outlook.com (2603:10b6:408:52::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 09:19:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 09:19:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: skip btrfs/253 for zoned devices
Thread-Topic: [PATCH] fstests: skip btrfs/253 for zoned devices
Thread-Index: AQHZAyUiN2O8kxrvy0Wu9ilJJGmalK52oe0A
Date:   Tue, 20 Dec 2022 09:19:06 +0000
Message-ID: <c682ddaf-44c9-ba98-933b-9e0cfdcf7bfe@wdc.com>
References: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5507:EE_
x-ms-office365-filtering-correlation-id: fe35433f-3af8-4922-c24b-08dae26b3eb1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nc8vugYU9H0+Zx3vwe6RRBsCkA7nfZNI8ftr93cpYg4M0MlF+l+Jug2zCI5WyNnGSeTK03mFaG04Bm5tSl+nUZeCANZDffEdyLzgzLRnIh2QbzrtTCBm9nqptrIn763S1rasFbPW6BvSzAYpl+4bj5FZbWJhtibTaPJHTbtUVetFirtGmlbNXnKTtgssM24X2qsPmxV5OFU8EZflhIU4pRGRtEQPrPjZPByj+VIHa7r78Qa4aOa6fT/krBOzEQm6CaiW8GMbJOhy2VIQpyzW2fTEepzDQDLtJ3Jjw9+6CfMA/BEpexAhhQH2E2uA7txqudwkwhQH2D/rduJ+Mf6CYlQ6VfrGglWDEa1syxOFWGGu3goLLoIHAPeHFC1Uk9I/5QZza6U+gBIjzFjVt9lT9YRjxgfuzueH1qWikXC9KdJIFAeVI3S7AGtGtpB6q0jP3UMHM9wzv4+tn0T4pK2buqNHPjVWuV39mpnLbrmUxh5Ign3qj29/l0ogLnfm3zUTdCXlVQTZYFPULu78DUnyarOvimC3QcCipRGlyrWHQs+n0KYKu1uHfxt3rCxbwC9baVxAoOrMxISqAL0WsbGNOESwZaOaZIaT0kH3gc0uQzm4LqECvW4ytkRtpLpd9rLlGRKLGsokuAtiBFae79IDpkiJH63kHmHBUAKiXTqm1DIChGsFuwpCnxonuerC3wyJe3EK9nLorxuxlQAyxxCYuNfOPXgjW5X+IereHdiNOxBaAUgsKje9y0QYeL7dpXznWHslqyhBcqrfdaRakv3N6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(36756003)(86362001)(31696002)(316002)(6916009)(38070700005)(478600001)(54906003)(71200400001)(6486002)(66446008)(4744005)(66946007)(4326008)(8676002)(91956017)(76116006)(64756008)(5660300002)(66556008)(41300700001)(2906002)(186003)(8936002)(66476007)(38100700002)(82960400001)(122000001)(6512007)(53546011)(83380400001)(6506007)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjBmS1p0MEEydVBSa0hEd1RlampFbnJvZE9PUTdLdGlSejBPVmMzTzNOemh5?=
 =?utf-8?B?c1hHS2N3WmxjY1lSZ21VbWw5ZjRGcEVJZFZGTGhSbEhPeHdmUTY2TDNUd0hk?=
 =?utf-8?B?ajh6ZE9uTUNiZEYzZTdrdWZUcC9EaHZxSFhJZnJLTjBLNzAyYkhLY1dTWXd6?=
 =?utf-8?B?Q1F3cE1jRnIyUkFrTUorSU1zemZCWXZZeG4vaFlSYWc0ZGphWjV5cHRxaHBL?=
 =?utf-8?B?Q29JaEFPVytHU21YVkNPYjVLRkJrU0xrVkNzc3VCQndpSE1pc1gxMWpJc3R4?=
 =?utf-8?B?Q3ZyMGx5Q2tMYTBENm5PbVc0dllQMHNPNjBOWEdVSmNGRzFiRkU2N2E2N1lB?=
 =?utf-8?B?bUxMeWhCejVFL0M1Mk9ldElGbjY2SWcvVVBCME5qWGZ6MkRpelhqZmdZZFBL?=
 =?utf-8?B?RHZsUFVrV2d0U01uQzRQaEVINnlPMUZxa1FUc1lRR1lNY01oZUp3Q1d3QXFJ?=
 =?utf-8?B?V2RmMUlwdjRuVU13MnB2SDFwanJvem45cEVBTE9GalpzVnV2UktUbE1KMXdq?=
 =?utf-8?B?bjEwbWZIWmxZNms5MnkwZDlwZGFDWTdzc3hvY0dRUTV6ejYreUIyZ0tlYmtU?=
 =?utf-8?B?QVNzblJzcWc0Yk5XQTNGZ2I3TFdURkxkVlNLSWNMSGg3UmFlN1RVQzhKOUZw?=
 =?utf-8?B?bWxCZFllNzVmUnBDMDVSZlpSRGNSd05GSjZwVm85SVJYTXh2VkNYN3BWWjRw?=
 =?utf-8?B?WWVhYXVxWWl3RXBpenBvVXlXV3NmcnZwbjVERE1ZNUNxRzh1dHZiS1FhbEoy?=
 =?utf-8?B?MjZiWk5janRJcUk3ZmgwaXYvNG03QmJLNnRyK3pEVGhzWHdGZ1JIOG8wejhG?=
 =?utf-8?B?SUVwelp3alNoYkNtVGMrdG9SVk5ZREZJV0thUGpzbFg0K1UvZUdvNHZqclVy?=
 =?utf-8?B?ZFYwTHhsRFJZREhlTkZFU0NRZXgycGIrbU9FRW1wSldRSjJLUUcwbnFmUmha?=
 =?utf-8?B?K25wQTBqL05Cb29XazdqZlNUSk1CTEVYQ25POEdKQ3BGTzNzU2dlWUs4VDc5?=
 =?utf-8?B?czJjanhzTGxxM3JpQnE5Y0R4WjFNK3hRWDhzcUMrdVRsalk1MGN6UlcxR0Qr?=
 =?utf-8?B?a3FGdG1ZaXdqQS84V08wdUhmZW44V09SMWhrRStrZnozUCswYnZwOVpPcmlF?=
 =?utf-8?B?a0RlNFN0T1lIUy80cGRVY1AvZFBoU2lDbVV4NGtQaGlnamdIRzBDTEQzZWl1?=
 =?utf-8?B?aklnM083WmlGRWZpQUxmQlVCTDc0aHFDMDRFdzFVNDJMUnVubVZoQW9mWkVo?=
 =?utf-8?B?RmF0NkkwTWJZV0VTa1MrZkJZYVBSZ0JsNWZhUzgzdEtqeWpqcFpDMFhldWpv?=
 =?utf-8?B?cWpoOTFVSVliK2pNdGlBUS85U1M0M0ROQUJqNit5MVJkRjNxTlA1WTZFenor?=
 =?utf-8?B?cGlLQ1cyRkFBNE1GaVMxT3JXTitmQit5S1JGbGxodlpYaGJlME5jOHlkSVY4?=
 =?utf-8?B?Nm56M0E3RFVXcWdrU3p4MjhaTjBndmNZOWJ3eFZ0WGI3U255dTRhUU1nc05p?=
 =?utf-8?B?dHBJbVRCRmJKU0laendTR2VNTG43ek5uQi80RmlleW81ckp0T09oTEUvellu?=
 =?utf-8?B?U2kwQ3hLVjRsdVl2QlNGS0txZEtQU2lPdGgxcVBmRENUS204Nk9yMi8wR1Fz?=
 =?utf-8?B?R1Z5TXU2MVpLRTYxeGJRN01ZbzBlMUNZUDFhdjBuNDNHZFE3N1ZTZ0JqRkt2?=
 =?utf-8?B?U3R5OHFOOVlFYy9ZNURyY3hndFBMcnZXNlVvQUx4Z05PZWVCS0Q4VExMTnBj?=
 =?utf-8?B?bFc3OGJzRHZBU1QzNnNldmI0WW9Xay9TcU8wR3VzalphSkx3YWdMZ0NrQUxo?=
 =?utf-8?B?c1ROUS9saVRHdTVRRndzK1cxQUY4NzF3SEp6Tm5kSmNwVitmVDhtU1RUUHpP?=
 =?utf-8?B?ZWw3VGV6YUdFUW5RV0phNFYwclY4d2kxd1V1cWlqWDBKeWR6Ukt2amt0UWln?=
 =?utf-8?B?SytENktHOTY3bFJsbVlQQVFrckpBOFNhVm13bktOaldYa0d3cktKVnk0Ui9s?=
 =?utf-8?B?WW4wRWhudGhYSWo1aHVPV0pLSHhheVdRT2lhb01VRFkybTFsY2pRSmxDdHRQ?=
 =?utf-8?B?cmxKSSttVHNOUzZNVmpzQXlUM2VMcHpKaC9rZldoVVcxQzZsY2Jza016b1hn?=
 =?utf-8?B?QXh0eWd0ZE1wVXNHZno5eGZMSEFLQ0UyQkUyVEpTUENSOFFOaWlrUHpwQU9a?=
 =?utf-8?B?SWZVUW0yNThKL1ZEZ2lkaHVhSnp2V0pLeU80UnVNMVkxTy9WU2s0YzU2a1l5?=
 =?utf-8?B?UGx5aGs1elE2b1BQVlM4eDR1RlF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF32F41EEA3294AA420F30830C091FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe35433f-3af8-4922-c24b-08dae26b3eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 09:19:06.7250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2bcSdtNG0uI+MVlaOXlqlw3JOG02zOO8uNwNjyeziAb/EA5l6lSE08x72lYdYzuOe62BpRCnA7LxdYTOSvo/8PL3HbruJpoyZecrYQzOYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5507
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjguMTEuMjIgMTM6MzAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gVGhlIHRlc3Qt
Y2FzZSBidHJmcy8yNTMgdGVzdHMgYnRyZnMnIGNodW5rIHNpemUgc2V0dGluZywgd2hpY2ggaXMg
bm90DQo+IGF2YWlsYWJsZSBvbiB6b25lZCBidHJmcywgc28gdGhlIHRlc3Qgd2lsbCBhbHdheXMg
ZmFpbC4NCj4gDQo+IFNraXAgdGhlIHRlc3QgaW4gY2FzZSBvZiBhIHpvbmVkIGRldmljZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJu
QHdkYy5jb20+DQo+IC0tLQ0KPiAgdGVzdHMvYnRyZnMvMjUzIHwgMSArDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9idHJmcy8yNTMg
Yi90ZXN0cy9idHJmcy8yNTMNCj4gaW5kZXggZmJiYjgxZmFlNzU0Li45OWVhZWUxZTdjZGUgMTAw
NzU1DQo+IC0tLSBhL3Rlc3RzL2J0cmZzLzI1Mw0KPiArKysgYi90ZXN0cy9idHJmcy8yNTMNCj4g
QEAgLTgxLDYgKzgxLDcgQEAgYWxsb2Nfc2l6ZSgpIHsNCj4gIF9zdXBwb3J0ZWRfZnMgYnRyZnMN
Cj4gIF9yZXF1aXJlX3Rlc3QNCj4gIF9yZXF1aXJlX3NjcmF0Y2gNCj4gK19yZXF1aXJlX25vbl96
b25lZF9kZXZpY2UgIiR7U0NSQVRDSF9ERVZ9Ig0KPiAgDQo+ICAjIERlbGV0ZSBsb2cgZmlsZSBp
ZiBpdCBleGlzdHMuDQo+ICBybSAtZiAiJHtzZXFyZXN9LmZ1bGwiDQoNClBpbmc/DQo=
