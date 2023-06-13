Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F146A72E7BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbjFMQBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 12:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjFMQBS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 12:01:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B49E53
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 09:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6V5/MnHsmzRQqpJ/ep0TQWIeq8ECtX1GmkDggigIUSjhNzaYNWZ0Pnh08azEbDMNrjWf8HyMgBbcueo2mHsw5KX1F4HPCWJZmN6NhYjSQXhmXA+o3A4mTUhEVEGSFDlbcBz6c6jP5/e/F6WOg5sMcKDhvyg3+QC6PcghrCp+VLA3lWto7EvHCvGFLS+2beM+cPO+4ESCCBYLPKQdfT/wxFdHHdGK8I8Vn8BD7BHIyyfuuaJlRtWLCJVzpd4c8Fkhs7BvpWNDTzFinnUPboCGrpcAQZh5UiiTHl4zLhk9CUo7zArKnPOnPt3eE0nCuEYUk03FU+8+2fJ1lbvFGWuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy8saLpDOyZssSbm7gps3U4zzogHpwQbkmjGpp5QT8E=;
 b=mBmiAoEH7Tld9R+wTvA63E7X4LVSTM1b5V7RPetY/RaIoSXGPQejsNfFZ0rfmq9QhMsmGFIU5VrZjroCRuGYvF36agBrVdETsPSVEu8+aN90K9BW3sTSZ1YiHNb4PkQdpLrRUC7JAnjS6qQH2cRIvRHxbQCQ1FUWwQZkzyuacENOeu7En7NqY/dcWZKDvF3qnRqy3hXrZQqNwJFquKbHb+H4E+Nj2bl6pu9YhUKvTUCDwUj4ecxsOz9aQ/lflibkO5DIdOQw1avloaSYoxJJLA9BkT4HBaAdUvC4gHlq+eHp5l32ThLtVj/dY/wKMEhh+nDju2X4i4DaWak/h5/Ogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy8saLpDOyZssSbm7gps3U4zzogHpwQbkmjGpp5QT8E=;
 b=SXtugnL3N/DZv4nRzbNHsQEvXYis+wQTdHaj/wLGl4MpDuK39Rdr11dkj1CFSyERxmfnfIV8AZgGRXrFRQ2OkJF0/CiV9f3d9bcVKeykNT6mPhgdNl0H4GTfxlDmthal3PNEkssKaIROrl6it0AHBWcukenPjBqRTfbHP8h453Q=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AM8PR04MB7266.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 16:01:13 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 16:01:12 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Nicholas D Steeves <nsteeves@gmail.com>,
        Phillip Susi <phill@thesusis.net>
CC:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAyVbEAAE/dPgAAAwC4gAAPG1YABIG62QA==
Date:   Tue, 13 Jun 2023 16:01:12 +0000
Message-ID: <PR3PR04MB73407D6CC4267397F47548D3D655A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
 <PR3PR04MB7340EB60FBF52F117181580ED653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <87zg5b821z.fsf@vps.thesusis.net>
 <PR3PR04MB7340C8A490ED5E5B5446879FD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <87edmmvrv4.fsf@DigitalMercury.freeddns.org>
In-Reply-To: <87edmmvrv4.fsf@DigitalMercury.freeddns.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AM8PR04MB7266:EE_
x-ms-office365-filtering-correlation-id: 729c6f33-b8f5-4aaa-6cdc-08db6c276939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYqx8w/TVhKGGsvIQ1fOUcIQyXvNwp9vawRWx1NcctE5tVaCQFWj1rbajzw2A7F4i8kFtZIY0FtUzEBHxeRghQBHgmPSjwQbVWwD0zet9oawEkUPqj1PXTFHDz2Wv+w5+jAPmiICiqx5eg4MJjSVJ6zN+3wWTm1TT8pDzbmq5+pu1GPMPxZXSUzqhFvqgLEv3mR8ZWc6KsHtm2QoB2BBZNIsQxmwsD5uzWkQkXb35vNNiJXR517/D/LAJkxU+UoZ3bWyso7RhzaK9ZqHRM7xAsa44QHEAYjRqqEoDzfbHN3fo/k1EOOCWtOEx7GXBzwIG3LLWuumKQIY5alb2NGft5utfoXg+72QCQKKyFzG5fLXf5wpSw5HmTmgr1NuSlejRBHVzVOcmqBmeEjW7A94g1FrGVLDdimtkspPfc478Pr9tFR18ChnPZOh1jJIIKgQ6ZVJPMr7INGSBVrXTZ2xLQ/NnenFqqF0TKuCPM+q/B8/k7bH0wdgSI59O60Dcsa1gBziZJ1skNeWgZjA0Qww7v2mSyq0N9afR/0CgHN2zRS9BdOFMubmvfPaSsinGInhbYjiwaAd4wPuvTT1Jb1LuneKpJY67d3licAEIj88tBuIMg0ki9Unc/J/Q29vmUra
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39850400004)(376002)(136003)(451199021)(316002)(4326008)(44832011)(64756008)(66446008)(41300700001)(76116006)(186003)(2906002)(54906003)(110136005)(66476007)(66556008)(66946007)(8676002)(8936002)(5660300002)(52536014)(71200400001)(478600001)(7696005)(966005)(6506007)(122000001)(33656002)(53546011)(26005)(55016003)(83380400001)(66574015)(3480700007)(9686003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2p6SzA2bjVFRnhBeU5NQmorUU9uZmQrSy8vZUJDaVRMa21LQ0V2RkkrcTU5?=
 =?utf-8?B?dUQ4aXFEbkJXQVpKQnBZNnZKSkp1di9QWVM0d2gwR0ZIWThrZ2ZoQzFUaHFr?=
 =?utf-8?B?OGdkUmNXS01rbDFRYUw4RDlUcVRhbDF1WVNSbTRuMmpGSGx1eC9qcnlOWHFm?=
 =?utf-8?B?TEp2cVhvNURXQ1FtL2dMOGFVbmczMTNsaVpvL2tLSUxvckpxRVBCcHNJN3Q1?=
 =?utf-8?B?T2Z4SU42cis0K1NBb1YrREIvbmNQRENIYVZ3RmVMWU9rMFUyODczdGVmUFdZ?=
 =?utf-8?B?b2dYYnVGNFVqbkdGMHRjd1BBOXJCNEx4S3E0ai9aRUh4R3gvLzArZG5FQ3h3?=
 =?utf-8?B?UEFnOTEwZlFPaVFEOEtOU0ZKb1Fiemhib3l6aUVraTZGUGxIUTIvK0kwL1M5?=
 =?utf-8?B?U0RKNWtkR1hBNG5xYVE1OE94cVlPOTNpMkVpZ0tYMklWZTZ6RGtPSThRbmZH?=
 =?utf-8?B?Qi9QcnBEZDNQU05ETVlZaGl1MmdEZjUzaDZkNkk4VjVZTUY4ZW5NRFdpcWtx?=
 =?utf-8?B?OEQ1T00vWlM0V212dHY0b2Q0VUEzeDZoK1VENk5KWWtBWitDSXVWUHBheHpJ?=
 =?utf-8?B?bHNXSDRPNmtCd0hpWWVqUTNCbzI2MEFRN2ZzdzNwVWN2MkVIL3Yybzcxa3hW?=
 =?utf-8?B?b21SVkptbFZraUVkaDk0dGFyWHc5U2tQK3FtdTkrQmJwZVVvZUQvdEIyS2FV?=
 =?utf-8?B?dU9PbEg0eVR2R3NQdm9UR1J3SzhEYXVaemNWMWdoQ3J3L0ZVSTlKTUNHTEsx?=
 =?utf-8?B?L2YwZmNLMGpzR3J3M0RFeXFPU09oMzk3QyttRHJOOGpPQ2NXWEJhQjBMVkRm?=
 =?utf-8?B?cDBQSlRna3VaM3ZvWXdxTmk5QjZ0RFNobUc4NnIwNVh0dkY4NHh6Rzg2TWdv?=
 =?utf-8?B?RUprM1BpK1hCcWo4NllSdTVCQVBsRmVRN3RiVk8veGNrL0RsQkthdVBoUmFV?=
 =?utf-8?B?Z2FOcjBKRFFRNU94ZnR6ZXRhMzhRNkZHZURtb3RsMGFTc3A4K3hCN25FQmRs?=
 =?utf-8?B?a3lYMEdYUWxWOEpHck9LMHBHb0lLUVdHSkxIWXFNQm9QUjVxWVBVdjdvcUlF?=
 =?utf-8?B?NGJkUGZtS2Z4WExBWmhaRGE3THNPdDlFQy8yRUlEZk5yVkMwZTZybkpTTHhF?=
 =?utf-8?B?RkRySVh6Z2h4NEo1MGdIdDcxN0lYSnlpc1JGcVpDTGhYQ0RZQjZGYWhJdXNv?=
 =?utf-8?B?T0tXREpjMXdVWVM1MHBtUm8xZTdrN0U2L2FMMi9ENXFTRk9kUHdvWkJDVUF3?=
 =?utf-8?B?MUNiUllhaVZIT0N3YXhQaVB4QVVIc0lmeFdHVCtiakh2Q283T0dLbWUvaFVw?=
 =?utf-8?B?N1hKOHBPc0Y5THRSbG8rS2hMTUJjRE5KeE8xVlJYejMzUGJ5eTRrWVVwbnFS?=
 =?utf-8?B?L0tNMVZ4V3NJTG45L3FJV1RVanJPdlpsVGZ2N2hXRWt2UFFYdDBsUWJ5OW9a?=
 =?utf-8?B?M25vQWRjYUhZZjA4TFlZSTRNdWo5NFlZWXdPaERrZ2s2RVBjNm5BV1kvUEhw?=
 =?utf-8?B?NjVLVmNjamZBMkNIWEQzc1BwT21rRTh1S2VTVVZPMGJzN3VxVUx4ZE9NUmVY?=
 =?utf-8?B?SlJaRW5kOFJMZUVyQXVUQUkwc0t0K01IcTV2QmhQbjZXbXhBaXAvLzlNbC9N?=
 =?utf-8?B?Mmo0V0RwbFVzM3AyR24rQ1h1OU53Nk9oN1dQamlGNTdaZTlGaDh2KzhObmQ2?=
 =?utf-8?B?TjFWL3MzUGhtS3JUK3hIRXdBcVZwWTVXN0pjY2JzOFNZYUgwV1JWWFhYZDFY?=
 =?utf-8?B?MTY1bjMyVnB4RjhLekpKWkFGMHl6KzR0dTQvSFAwSUhoMVJydDlYOGwxSzhJ?=
 =?utf-8?B?N0lNdjJjaTliVWlwNVVzN1l6UTNoTXB1a2JOSmNzWkd6bHY2UTVseTN5MnBQ?=
 =?utf-8?B?YVFrTHRhWXRMdWJsUGFYTHFqQjlNOU9JZTdJZjFrQks2NCtsNkVtT1JQYkZC?=
 =?utf-8?B?UERsSTFHVElCSGZwRktaUnFNNHRlSzhDRmllQ29xaWFjK3Jtanpsek16NUtH?=
 =?utf-8?B?bFl4M2tnRERnY3A0TUtzV3BZd01HVW1pc0R4dmxPUFZHcW9Jc2J1aW9rRmtB?=
 =?utf-8?B?c0dBNSt2cGxuemVPcERjaG9MTFlvZTVkV1p0TFRaMHpRWVI2NUdDZGRYcUJ5?=
 =?utf-8?B?TVVYUGxibysyZGpyMFJtTlhCazRSSVVCbi9YMjB3OCsvUUd3TTNyM3o4U1hU?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729c6f33-b8f5-4aaa-6cdc-08db6c276939
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:01:12.7645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aww52jPwZ3cji4ijnFDoDliNqX4DQ2oq/rAX1YdqqW8e7PxOr9yH8Uh18cabZ/34/wPALivVxd87Bi7dJxQVojg6oHC0CS43CTqDYRH5KHEwWH1oR30Y05N8DHLvn1e1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7266
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pY2hvbGFzIEQgU3RlZXZl
cyA8bnN0ZWV2ZXNAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSA4LCAyMDIzIDEy
OjE4IEFNDQo+IFRvOiBCZXJuZCBMZW50ZXMgPGJlcm5kLmxlbnRlc0BoZWxtaG9sdHotbXVlbmNo
ZW4uZGU+OyBQaGlsbGlwIFN1c2kNCj4gPHBoaWxsQHRoZXN1c2lzLm5ldD4NCj4gQ2M6IEFuZHJl
aSBCb3J6ZW5rb3YgPGFydmlkamFhckBnbWFpbC5jb20+OyBsaW51eC1idHJmc0B2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUkU6IHJvbGxiYWNrIHRvIGEgc25hcHNob3QNCj4NCj4gSWYgSSBy
ZW1lbWJlciBjb3JyZWN0bHksIFVidW50dSBsb29rcyBzb21ldGhpbmcgbGlrZSB0aGlzDQo+DQo+
IHN1ZG8gYnRyZnMgc3ViIGxpc3QgLyAtdA0KPiBJRCAgICAgIGdlbiAgICAgdG9wIGxldmVsICAg
ICAgIHBhdGgNCj4gLS0gICAgICAtLS0gICAgIC0tLS0tLS0tLSAgICAgICAtLS0tDQo+IDM0NyAg
ICAgNDc3NjQyICA1ICAgICAgICAgICAgICAgQA0KPiAzNDggICAgIDQ3NjIxNSAgNSAgICAgICAg
ICAgICAgIEBob21lDQo+DQo+IHdoaWNoIGlzDQo+DQo+IHN1YnZvbGlkPTUNCj4gICAgICAgICAg
fF8gQA0KPiAgICAgICAgICB8XyBAaG9tZQ0KPg0KPiBTbyB5b3UgaGF2ZSBzb21ldGhpbmcgbGlr
ZQ0KPiAxLiBzdWJ2b2xpZD01DQo+IDIuICAgICAgICAgIHxfIEANCj4gMy4gICAgICAgICAgfF8g
QGhvbWUNCj4gNC4gICAgICAgICAgfF8gc25hcHNob3RzDQo+IDUuICAgICAgICAgICAgICAgICAg
ICAgfF8gMDYtMDYtMjAyMy0tMTU6MTZfUFJFX1VQR1JBREUNCj4gNi4gICAgICAgICAgICAgICAg
ICAgICB8XyAwNi0wNi0yMDIzDQo+DQo+IHN1YnZvbGlkPTUgaXMgYWx3YXlzIHRoZSAicmVhbCBy
b290IiBJIHRoaW5rIEFuZHJlaSBCb3J6ZW5rb3YgaXMgY2FsbGluZyBpdCB0bw0KPiBtaXRpZ2F0
ZSB0aGUgY29uZnVzaW9uIHJlc3VsdGluZyBmcm9tIHBvdGVudGlhbGx5IGhhdmluZyB1c2VkIHRo
ZSBkZWZhdWx0DQo+IHN1YnZvbHVtZSBmZWF0dXJlLCB3aGljaCBpbiBteSBvcGluaW9uIHNob3Vs
ZCBuZXZlciBiZSB1c2VkLCBiZWNhdXNlIGl0IHdpbGwNCj4gY29uZnVzZSB0aGUgYm9vdGxvYWRl
ci4gIEEgZGVmYXVsdCBVYnVudHUgaW5zdGFsbGF0aW9uIHdpbGwgaGF2ZSAic3Vidm9sPUAiIGlu
IHRoZQ0KPiBib290bG9hZGVyLCB3aGljaCBtZWFucyBhbGwgdGhhdCB5b3UgbmVlZCB0byBkbyBp
cyBtb3ZlIHlvdXIgc25hcHNob3QgaW50byBwbGFjZQ0KPiAocG9zaXRpb24gIzIgaW4gdGhlIGFi
b3ZlIHRhYmxlKQ0KPg0KPiBTbyBJIHRoaW5rIHlvdSdyZSBnb2luZyB0byBkbyBzb21ldGhpbmcg
bGlrZSB0aGUgZm9sbG93aW5nOiBNb3VudCB0aGUgdHJ1ZSAvDQo+IChwb3NpdGlvbiAjMSkgb3Ig
c3Vidm9saWQ9NSB0byAvbW50L2J0cmZzLCB0aGVuDQo+DQo+ICAgY2QgL21udC9idHJmcy9zbmFw
c2hvdHMNCj4gICBidHJmcyBzdWIgc25hcCAtciAuLi9AIC4vQF9icm9rZW4tdXBncmFkZSAgIyBu
b3RlIHJlYWRvbmx5ICItciINCj4gICBjZCAuLg0KPiAgICMgSSBzdGlsbCBkbyBhIHN1YnZvbCBz
eW5jIGFuZCBmaSBzeW5jIGhlcmUNCj4gICBidHJmcyBzdWIgZGVsIC1jIC4vQA0KPiAgICMgSSBz
dGlsbCBkbyBhIHN1YnZvbCBzeW5jIGFuZCBmaSBzeW5jIGhlcmUNCj4gICBidHJmcyBzdWIgc25h
cCAuL3NuYXBzaG90cy8wNi0wNi0yMDIzLS0xNToxNl9QUkVfVVBHUkFERSAuL0ANCj4gICAjICAg
ICAgICAgICAgIC9cIG5vdGUgbm8gcmVhZG9ubHkgIi1yIg0KPg0KSGkgTmljaG9sYXMsDQoNCmRv
ZXMgdGhhdCBtZWFuIEkgbmV2ZXIgY2FuIGRlbGV0ZSBzbmFwc2hvdHMvMDYtMDYtMjAyMy0tMTU6
MTZfUFJFX1VQR1JBREUgPw0KDQpCZXJuZA0KDQpIZWxtaG9sdHogWmVudHJ1bSBNw7xuY2hlbiDi
gJMgRGV1dHNjaGVzIEZvcnNjaHVuZ3N6ZW50cnVtIGbDvHIgR2VzdW5kaGVpdCB1bmQgVW13ZWx0
IChHbWJIKQ0KSW5nb2xzdMOkZHRlciBMYW5kc3RyYcOfZSAxLCBELTg1NzY0IE5ldWhlcmJlcmcs
IGh0dHBzOi8vd3d3LmhlbG1ob2x0ei1tdW5pY2guZGUNCkdlc2Now6RmdHNmw7xocnVuZzogUHJv
Zi4gRHIuIG1lZC4gRHIuIGguYy4gTWF0dGhpYXMgVHNjaMO2cCwgRGFuaWVsYSBTb21tZXIgKGtv
bW0uKSB8IEF1ZnNpY2h0c3JhdHN2b3JzaXR6ZW5kZTogTWluRGly4oCZaW4gUHJvZi4gRHIuIFZl
cm9uaWthIHZvbiBNZXNzbGluZw0KUmVnaXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNodCBNw7xuY2hl
biBIUkIgNjQ2NiB8IFVTdC1JZE5yLiBERSAxMjk1MjE2NzENCg==
