Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A05C74B824
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjGGUkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjGGUkR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 16:40:17 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6982106
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 13:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEVD1qhQg/FCzRpXe437yOwZeYaAZEQfGf5mUhSP1ZseOth+2O6j2WEA+nnoHQneP6PnKQikKvmgo9ACjg1cs9Ze+tDY0q72RQhjxgriC0lFzTSID3HoD+XhRFuMuH+Wj7/73aEceHmZL/AR9AmNxf2p1MKZQ1Ebf19BqyPeOs4kOk+jJUvfWz+Cn9874tTY8K++644vQvY0vVAHmOjyhsKjkblE3uawIhTk6ZbarmDAjRkl4sQ1rN1fZZg9QLlrR2PDBhA8KopP4+Og2DB52is2/Df8g/ov1lD5LuhsLITFVIsH8oHe1OkR+Fx7oi/5Vp1D5DAaG7IdjKUXGCiCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzZ2u4CUU1rRQil4mNrfCoaL4NSiPMfBZNtSem6ExOU=;
 b=jpWrJRNS1A7GBq0PQwrHRwC8yB5yphZI0r0ZsWIV+aGN7cM5a1ayZhPAUAIEVuWqJEDhRI9AV366rjoKdPS3a6685HIpkkDQK6LtPUkbE5SnM3LolC9Y7VVJOuVFm02kRhMQ6gZagZW8kYRtsa/X3XYWVib6YoZNefE/6/ldtf0KlxrUTZrnyleVbSbf5es5JCz23Ko8kSswZUtH9rxPJFQGNpgAslSm/vpsz5ShnPXVKn6watwPbF7gqUKpcjoaH8DAsXQXYbQuQtj7mU6+WX7RyMzTJdjn8D9A8r8FyfSTqEV+/DDL7caavDCrP+yZpYoqWLtItSTYIui6semc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzZ2u4CUU1rRQil4mNrfCoaL4NSiPMfBZNtSem6ExOU=;
 b=LxvPIcY5NQKGgXsPp+/iYvpzqy6I+qm37xnjZLtjvw497qd9XyQNApoj7u91EIX+RRvOBE7zhrtTYyPK1+UcZMoZgm4QJoHsRRGnYlPFw8r9c51Na+oLluJTEkKwqhaWFd0nkKDa1zSI/hlyEO+s2w3ao8Ofgo1jeKYZkXQKcP0=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 20:40:11 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::c221:aef2:711:b203]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::c221:aef2:711:b203%6]) with mapi id 15.20.6565.026; Fri, 7 Jul 2023
 20:40:11 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Remi Gauvin <remi@georgianit.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: question to btrfs scrub
Thread-Topic: question to btrfs scrub
Thread-Index: AdmqYWxcqzByINPHTMyzVF+8SQB2BgAB8fyAAA4C3wAAJq31gADUQtNgAA4hmwAAFVwYIAAAiSAAAAyYELAABoslAABqWulg
Date:   Fri, 7 Jul 2023 20:40:11 +0000
Message-ID: <PR3PR04MB73409D64B476E6CFD9781C58D62DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
In-Reply-To: <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DB8PR04MB7097:EE_
x-ms-office365-filtering-correlation-id: ac784be4-624f-4474-a4a0-08db7f2a5bf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nzxDC4/vgFhLR5uuF4ntnCCijyc9xELDpxvFAkvXTp+MH4tN14I2lpT4nm2yeFrIuuJpJ3bnG9/9S2cJjq2BqQBk9rrZYt3169dO6tbnEmvjzWVEo52F8fje/QLXqEaBXcR0OV1tsNeeGtUisx3anGaXP8Xg+9TGZFy3l2BrprYQOsFc2UPXCgJwGBXo28Ma+NR6TvfrS+ngroUxXgN103TMV71pQ9fYLyTE8TpxE3ItC6mylNr1WTsmsxGPJUaigUHHpW28MswoZu7nOJr/lWyISfWn1FYDQS2v2P6AzdhCQJ5D66iXtrQjc1z6lfEbyW6MSc0TAplUs/5mgiriPO5xwLMNr+i1FvkBfVqJRziWV/XFhRWzbM4yFDy8GdBZuHjOmEOKUZd7Rk3F3cBzdXwYXgmhMNX1qcDFKZLGKUjoTRxPc4PhJjSLoToosOcBz18IkIo6wzVvw1Boa0Xd2Pba50NVF2N2zuA9tIcvfzZPc2FAovKqGHlvhWZmD7V5Q5VTj6rUgeg1+B8TN7liz5V0/Z+DNs2xY2fYjKWcKJT0M5vbD8psg+/e0uidBzucDOR8mcVmHNMyBSw3wTdsdC/Br0HPHKLEbt+C4ulS8Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39850400004)(396003)(346002)(451199021)(7696005)(71200400001)(478600001)(110136005)(66574015)(83380400001)(33656002)(38070700005)(86362001)(55016003)(3480700007)(4744005)(2906002)(186003)(9686003)(6506007)(26005)(76116006)(966005)(122000001)(38100700002)(66556008)(66476007)(66446008)(64756008)(66946007)(41300700001)(316002)(8936002)(8676002)(5660300002)(52536014)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2dKa0FSMnloNi9XYlpoSm9MSkNMMlZQc1FSb2RDeXd0Lzd2SUVKcGdzYUFQ?=
 =?utf-8?B?d21BbWNUSVc0cHFocWwzdzNNWnRWVUZiUE5FT3AvZ2VaSzlibm56czJ5TXBa?=
 =?utf-8?B?MEN3WTljcWpQT0JZUG9ybGRDc2t4RjVrOG1aNmEzR2Z4eDFYVFFabjJzanNx?=
 =?utf-8?B?bW5QY1JQZ1ZlMUtQV1pqaFVSUXdRZERYSkZ3Z1NoVGdwUnJFb3VuQjBuQ0pk?=
 =?utf-8?B?cnoxTEVHemhrRkIwc3Z4TTQ1V09EWXZ4ZDl5YlJKZVFSOC9LT3U2UXNVenJm?=
 =?utf-8?B?Z0FKT3NiWFdSbzdtQUpoc0lTb0ZaZ0tsTGRFSFZ1cUFGSVJPUnBad3JQeE0v?=
 =?utf-8?B?LzNSNHFTM1RGOTg5MHp5QjhjV3Y0NlJsSURmM0RsT2R3cVh6aU02ajFrd1pZ?=
 =?utf-8?B?ZkNad2NXUXJVV1c4M0t4WDlsb2poS3FMSjVoMWk1ZVlYSkYxK3RqNEhzSGU0?=
 =?utf-8?B?V1hMWi95ZDFvUUNrd0J4NXNGKzc5Q201ekZFMGhHYWZQSlpYMTQzTzBxSEtG?=
 =?utf-8?B?Q3Y3eGpWVVZvMmRsd3g2TUdaWDMwR2JSOXdWcHV6TnNQT3p0cEVEU08xNFph?=
 =?utf-8?B?dkpaUENtekd5UDZ5KzQyaGJ2dG9MKytSTHJOTlVEVU93TnlvZkhORHo0RlY1?=
 =?utf-8?B?WG1sUlppUW80dG9HbXJoR1ovaVArYzNFekdDWU9yak1ZL3lRSkVsbFNGQi9V?=
 =?utf-8?B?RDUrbTNUUHRFcEFFcmRWdTY2SHlMQ0pCNTdtOXJ1aUR4aEFaQU1NSkJOWFlM?=
 =?utf-8?B?cTRHWDdlSVBtRmQxL1ZZT1FreVY1UFlmbVovWStBTDE4QkhIcDdpR2RKb2Vz?=
 =?utf-8?B?SVQ5L1hscTVDZmVEaHhSUnVSTHpxckY3dVdTa2x0cGNmTXFxRDNOcnhRMlI4?=
 =?utf-8?B?M0ZHdTYzaDJJTUowdFArQkJ1cVFpbjl0bmJzUVdIVzUzamVUWENHaHlYdSs2?=
 =?utf-8?B?UTlSVUZDRTNTWU5HZWZOeXNLeEVzcTJBMkkrZlFuaEVNZ0RTbkdob0Z0NUxH?=
 =?utf-8?B?UXcwM2hCd0NOVGJmMkc3eUxqSW9mdE1lbEFsOVhWQUhtMG1WWlJ4NUl1c3lR?=
 =?utf-8?B?REIxVjFrRlhyTmpDN1pDVG9Bb3FLUkU5SHBDWEdKRUpEaUladVdNR3FkNU5X?=
 =?utf-8?B?RmJNRkVWM1hzSUFqMlZ1ZFpvT2FSQklBK0RlNkRxT1lJNGJTd1JGdmljaFlR?=
 =?utf-8?B?dHpxb3lBUHR4NHc3bTFPOTRFTDEzdkM1bXdzVE1EZ2dCaXNLdWVjRHBWUFky?=
 =?utf-8?B?bURZb1RzbHkzc2JGWHF1RTJ3M0FaOTBjKy9oc1k0S1lndjNhUUZrcklMT1VJ?=
 =?utf-8?B?M0dZT0FhL3ZZWjdWMGRCd1lxQWJFdTI4bE9HNnBhKzRjUUhXSWdLMVJVM1py?=
 =?utf-8?B?L0d2c2MxR0phOUszZHlIYkVyR3dIMHRUOXc0QytjbWJqUWRzMWg1OVJITHlw?=
 =?utf-8?B?a0lZbzRQYWhqeHpDK2RZSmVzREo2b1YxZkx5Q3kxWDM5ZzFEQXMzT2I3K3M5?=
 =?utf-8?B?TDQzTGhsN2ZjMG9qTXltZXhEN1FiNGNaWXJRNUFtakRxanpxZC92RXpEU2Rr?=
 =?utf-8?B?UDRpdmpsTlNJMm5jS3E3a0RUTFNVcm5aZkc2cmE5VGNhaGFaRjNJeFJlOHFM?=
 =?utf-8?B?TGFqZkluQXNXSE5LeFBMS2ZvcEtQRVVNTndudGs3aXRMT21velRGcUtoZzdC?=
 =?utf-8?B?SWJMYk1lYTZUYnlXOWNCRldHWGtOcVZZKzZpRG1oeXpidmpYMExVdHE1dzRP?=
 =?utf-8?B?ODZhNThrVFVReVhjdWc5TlBrRllYWHNOVGlqbkJDd3c3c0hpbzlYYVd5dGlO?=
 =?utf-8?B?aWFtWWNacjNLQUJMQWNvU04zQllHc28yRDhQVWV1N011ZkxtK2ZhVElMOXBn?=
 =?utf-8?B?R1RjMHNKd3BHazBhSHVxOTF3c0FGa2RRaGx5S2ROcXJMMkVPdngrSDl4dmZo?=
 =?utf-8?B?dmt4YWw5ejdhMlBPN3VWaUJoWVFvK1NLSEZQelZxUDVQc1FST1ZnWnFmMnAv?=
 =?utf-8?B?MzI3OFoxVTd4SG5xR0VkeFlFbjBCK1NPQXAvYlNieW81Y2xEOTVyWUhLS0NV?=
 =?utf-8?B?U1ZRTmtBRnNCNUI4bmxZWTBINFJJNm95NWFDUzFNSlpyRkNETm5IazA4NEEy?=
 =?utf-8?B?KzJubVU5d01wdEdaNzVoUjB5d24zbDQ0SUhGVERsUXRaVFoxOUtwM3dqVUdk?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac784be4-624f-4474-a4a0-08db7f2a5bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 20:40:11.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xzr+YG1UpfE9nictH0DAfjUBbYqG0V1XDHTt3unpBNJskrO1zAp/M9zsOI6pDiSl9YaqwSwAx6+FyEaJu0v/GCTAw3eZLpaGAOu3xE9sMo9IALrf1zvp7//eSR5halys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBSZW1pIEdhdXZpbiA8cmVtaUBn
ZW9yZ2lhbml0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIEp1bHkgNSwgMjAyMyA3OjU0IFBNDQo+
VG86IEJlcm5kIExlbnRlcyA8YmVybmQubGVudGVzQGhlbG1ob2x0ei1tdWVuY2hlbi5kZT47IFF1
IFdlbnJ1bw0KPjx3cXVAc3VzZS5jb20+OyBsaW51eC1idHJmcyA8bGludXgtYnRyZnNAdmdlci5r
ZXJuZWwub3JnPg0KPlN1YmplY3Q6IFJlOiBxdWVzdGlvbiB0byBidHJmcyBzY3J1Yg0KDQoNCg0K
PkFzIGZvciB3aGF0IHlvdSBjYW4gZG8gaWYgdGhhdCdzIHRoZSBjYXNlLCBkZWxldGUgdGhlIGNv
cnJ1cHRlZCBmaWxlIGFuZCBzZWUgaWYgaXQNCj5oYXBwZW5zIGFnYWluLCAoaW4gd2hpY2ggY2Fz
ZSwgYnV5IG1vcmUgcmVsaWFibGUgaGFyZHdhcmUuKSwgb3IganVzdCBza2lwIHRoZQ0KPndhaXQg
YW5kIGdvIHJpZ2h0IHRvIChob3BlZnVsbHkpIGJldHRlciBoYXJkd2FyZS4NCg0KV2UgYXJlIHVz
aW5nIEhQIFNlcnZlcnMgYW5kIEhQIEZDIFNBTi4gaSB0aGluayB0aGlzIGlzIHJlbGlhYmxlIGhh
cmR3YXJlLCBpbiBhbGwgdGhlIHllYXJzIHdlIGhhZCB2ZXJ5IHJhcmVseSBwcm9ibGVtcy4NCg0K
QmVybmQNCg0KDQpIZWxtaG9sdHogWmVudHJ1bSBNw7xuY2hlbiDigJMgRGV1dHNjaGVzIEZvcnNj
aHVuZ3N6ZW50cnVtIGbDvHIgR2VzdW5kaGVpdCB1bmQgVW13ZWx0IChHbWJIKQ0KSW5nb2xzdMOk
ZHRlciBMYW5kc3RyYcOfZSAxLCBELTg1NzY0IE5ldWhlcmJlcmcsIGh0dHBzOi8vd3d3LmhlbG1o
b2x0ei1tdW5pY2guZGUNCkdlc2Now6RmdHNmw7xocnVuZzogUHJvZi4gRHIuIG1lZC4gRHIuIGgu
Yy4gTWF0dGhpYXMgVHNjaMO2cCwgRGFuaWVsYSBTb21tZXIgKGtvbW0uKSB8IEF1ZnNpY2h0c3Jh
dHN2b3JzaXR6ZW5kZTogTWluRGly4oCZaW4gUHJvZi4gRHIuIFZlcm9uaWthIHZvbiBNZXNzbGlu
Zw0KUmVnaXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNodCBNw7xuY2hlbiBIUkIgNjQ2NiB8IFVTdC1J
ZE5yLiBERSAxMjk1MjE2NzENCg==
