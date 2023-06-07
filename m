Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B179726A63
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 22:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjFGUHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 16:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFGUH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 16:07:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEBE1BD9
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 13:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n70UuY11BAZ1yqTEm0znR6lELcxsq/vDjcwKyiOIJvvwyJlVMxXFqPvirUxjCyQyLm3oZJyegBm9djD1HCFIsfIFjs9SRpiYrwqHGq+C3YWwMmKHT7jpFuBN+oaSUfcsp32uZn4F3eFyNLYx1KDlLk/Mb25mCH9nJyVPeKZ3Xs9ulSt75EO5o2mYVb2bY6kVynX8y6DKhe1XjiyKk3jJCG8i0fzh/13qdT2s/21kJnaaXtIoRHzlSuv+qE4ChdtwtYppYurg0UAelwAdQY/R9y73FqLkRz/to5K5TcRSOl7+jXJqxcf2yvmw57X59Plxmb7TM+DO9ARlt3kZvD65CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJePkfdWe7uhZSgY/P5a36/6rjJOa76D2G98u2DqJC8=;
 b=D0F9amPiJgB6Va3tXoOnM6Z42bMxXpvy2Dod8AtI+kGpyEvLOhIeIPBIs/XtoSIlxqLwb6UXtgfbsN9opu/7JEx+xDPoLoHwbDmkzCX9qJF2gx1uogQgTyD1JXz/Bf+3sjKH99PfoSHLXXyqlmgYxMCcuBPIuFXKmyE/KzvkVzGttUJYwraOTzZ1U2w1Kowl5YsygCNZIqhLoMfg366PDkdjU3V7HGfyKJfphYH0LMjn0oaMZVhPx3XNLr4jEkI9gkBNLZMIGeDcI/NHW/caU8RNwltGfHgn8p4I3P4lhtZEejZ+IIvHWDa6DkZoVxsGt/x6DtgQV+Fm/ji9UYVo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJePkfdWe7uhZSgY/P5a36/6rjJOa76D2G98u2DqJC8=;
 b=w3JUbCInj1TSTQFKJyp/aRUAx+3KLw03cPasQ8fipv7VghUzOgjtmcHjbVoCjHuzqkEmV59mr2ktsIRcJ2aFdZfKGD2qrKTPrf5Ifq6PXUyt16nXvGF2BfNdYK+qiwKqVQ2Ahp+1mP2woxj5mjWF48vbsdbeam2Vitz743B1J74=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 20:07:21 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 20:07:21 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     "remi@georgianit.com" <remi@georgianit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAzLYRAADFFIgAAGTo4AAABYgAAAALqfkA==
Date:   Wed, 7 Jun 2023 20:07:20 +0000
Message-ID: <PR3PR04MB73407F1319779797A065E065D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
 <PR3PR04MB734090961ACE766466980F04D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8c9b136c-c992-8c0e-a1e6-0e8aec1e89cd@gmail.com>
 <PR3PR04MB7340CB95E5AB4FC10706604DD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <d708df28-a0fc-411b-97a0-7d2bea2f5f72@app.fastmail.com>
In-Reply-To: <d708df28-a0fc-411b-97a0-7d2bea2f5f72@app.fastmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DBBPR04MB7499:EE_
x-ms-office365-filtering-correlation-id: b28a99d0-f020-4b1d-1f4d-08db6792cd4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swmw4yTSHUZgP29jA1Y15WaOEnBw5ngbZEgZIi0+ouenDq3JfUfRIxZl3XcTf+Sler6fRvms5LMSjccMZPGsRy1IPKL/xp5SdN+Z3iX3lPuDGxPvt6N02p9mB6f3208grRxL3/8/SlQuPyJAx9FpdTAVH37UEBvIvqXe9uNFA1ifs4YtA6Z4CxGFd09gV7sibeBDkKvpZ/tsuHpxYKnK054z3hUkYFX1SfRN+hqwdmuvCiDt3pPhUdxFTVacKx7nGTyTCqBFW6tV2IHezYssFwEkXLWPBRtHSapH+gt9VernIQSVX5NaccwIj1mpe/DpLoUptDOwq9jtPVVCHmCkAcbM2wjnCRitC3cIq7ggNGGkhj3MmSgvGs1rWkbKZOsZqQBkrE1rKZ5kFY2Mzh0opWlnljRk1hLqhG9TUS3uVJ78dKMgCpp0kLPWRux/uUw+yStzaMaSDnUSSmlA0AJuUd/fDeHleqb8iy/pLlsld3JarCcSsHJok3x0zyw/nn87wW7LUOiixyFX0NXeVvCRdRPR7DiSdf8OR4yxmmt2B6fk3oLBwRrtQpmSoorgD8A9s9Df2hmbZW5lA2DRohEt24KSywqnEIyDdPB8zen4j5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39850400004)(451199021)(8676002)(8936002)(7696005)(478600001)(110136005)(966005)(55016003)(41300700001)(52536014)(6506007)(5660300002)(316002)(66446008)(44832011)(76116006)(66476007)(71200400001)(64756008)(66556008)(66946007)(9686003)(186003)(83380400001)(2906002)(4744005)(122000001)(38100700002)(3480700007)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUpRK1dkU0xuNHI1Y3FHcmNKTTVnSkw3MmpEcGFzY0s5MFI0RExSYU1jTnFh?=
 =?utf-8?B?TkhqNzRuVU9Udm5ENllibzFLR0lnMm40NFNldDZWRUErRnAraFZnUDdFYUhi?=
 =?utf-8?B?WTk5di9uZ3NTTkM5TjBrZzJNa25ONWJzdkZLQlBsbDh0blkrVDhpMDdPcitZ?=
 =?utf-8?B?MUNiWUVYT3RCZDNkQjQvT0o4YVU0YW45cnZkb2FYV2lKVnRHSGJKajBRZjUv?=
 =?utf-8?B?akxKd2JpajluUGVGRUVtNTBXSGViVmxpNGtDR1RreXVYNDNzQmIrNE4vbXBa?=
 =?utf-8?B?N1Fyakk4bms3c3FlaUM4ZDZwYWFtT0lrV3UrYW9iQXFGbmxrc1FMU0hvSU9O?=
 =?utf-8?B?OUZ2N0VHWUd4STlyUk9PaDlyelhhZitjeG1ZMTZNKytKdW5vYnAwTUFyRFda?=
 =?utf-8?B?NzJMVk9yWU5xRWNadThCOGFuRHRWTVRkZXZaRVZ5YzFBMmNqSUpMRTlZVHJ5?=
 =?utf-8?B?V1YyNUpaa3ZEOHAyd2VnMC9rZHl4cVl0RkdhYkxqT0dxRG11amVDeTcvbGRC?=
 =?utf-8?B?WEZzdjk1MlpDSjJVbi8yMVBuVFNVQWtOZkhsOWg5OFdvM2ttT0ttUnh4L21G?=
 =?utf-8?B?eFBFSG5uRUhtRGUvaXNtNjVYSDEwWlpsOVo2TWJFb3pIZmF2V2t2N1hCeVJO?=
 =?utf-8?B?S2FOSE1wb2Fubm5FK3pVcXhvNjZBMG1pdnF0djhTMkVqZTBCUTloS2hMeG96?=
 =?utf-8?B?VUpSMTVUdGowdkZMNGV6bHhyZ280Zm83MUNlY3ZULzREam1nTjZ0K3RwQWdz?=
 =?utf-8?B?T3V5QXFZeTRRL0JvU20zNnJGdW54V3FGTUZDMkRLY0VGa2JHcUIweWcyWGwr?=
 =?utf-8?B?QUs0K3pwQy92Q2pzSGRZT3U0dytZY1NPT044bTcwcjBKcW5qbkRpTEhTc3ls?=
 =?utf-8?B?WUIweUkxNUVUQVYyc3NweUVpL3dDSlo3cXhsMXpXRng0bHZtdmNZQzBjWUZu?=
 =?utf-8?B?QUpJcnAvZkdsbDBMTFBwMlFIVjdKQmh1Q3duOWQyR1RUbnVvZnl1SHVsT1Vv?=
 =?utf-8?B?ZHQ2am5RbVA5b0lGc1ZLRHpLeEo2SnBKOUsxRlh2S1pESjRHeGZnM2RiQWtp?=
 =?utf-8?B?dDc4RzBXY1paU0RVZUNnTFhWUTYvekFBcjdWOVFxaVh2aEtNbHJZYThHVGxh?=
 =?utf-8?B?QUhMQklkOHQrUFFTQldVd1ZuZWYzYzR5cWNxT1R2cWtGd3lLTWU4R3U0dDVn?=
 =?utf-8?B?VTBiY0xHbU92dFZLQXRLd1FPMTkxYVg4d3M0dWJ6N2JyelhiUXRxVlFDeFRl?=
 =?utf-8?B?NXdGU1hhbmpZL2VJRFUwM1JCdFBMU05KUTNZZFF4TWhmZ3FhL1pXbGw3ZG5E?=
 =?utf-8?B?ODhiNklqUzhnSG94Y1VDNGdncHlLNERoTHBNdTFoTXhpWEVYYzZDaHR2L2pY?=
 =?utf-8?B?RFZVTXdSWGtyZHV2ZVZCSlZjNTNadDJQVUdKOWJoTVZONWlxaTBhV091T080?=
 =?utf-8?B?OFNwak0vOGJzazByeEpMdXBKSFNOaCtJdzdOa2VlNURHNUQwOGR1UHl4dnEw?=
 =?utf-8?B?NERqaVVqYjJpQWxSME5TRTJhV2ViL3B3TnVJanRzYzZOekgxRFVWUEUveFNN?=
 =?utf-8?B?MVdjSzEzRmZGQzBFMzBPbm1sZzhqS2lzV2ZJbnVwNUxXRUgxMWFCQ3lVTHZB?=
 =?utf-8?B?V1BpWi9ScmZkaVgvT3dXQnFxTHNXcjdDalFqWUYwZmZsdm9sU0NCWVFpLzdl?=
 =?utf-8?B?VzQyVFFNL0o1b2ZmU1pEbHRveXVMRm02SVc1QW04YWQ5OFpwa0xZa2tuTEZJ?=
 =?utf-8?B?VmU4NlNubjJ4ZXphdExwbVZWbStDKzlnM3REVFJuMFgxZ29aYXlnemZRQUV3?=
 =?utf-8?B?YlZlVkJFY3RYV2ZUMDZ3UVF3NVhwelU2MDU2bUJzWWdzSzlRUG1ydmtOVkp2?=
 =?utf-8?B?TDlKWUhkSTZXUlphK1J5bEVsWWRWNzhhWnpSbGZjWVlUUndUQUxadC9rNzVX?=
 =?utf-8?B?QWsrakxxOFFPWFJ2QnZTa0hZWVR1TXpuMENSck9SS3VpZmVXYXJiUjQyTzVH?=
 =?utf-8?B?RVZqdmdIcFBkV09WTXF3enprSi95cktmcnJabVBBcjU4YWFZVk5PamJRTDRU?=
 =?utf-8?B?clBIUlF1ZTVKSWFOYVNpT2M2L2EyR3FMYll4anlBbkFnR3pSaFpvMWFxZ0xQ?=
 =?utf-8?B?RnBwNVF3VDMwaFJNeUIvUUJjZ0VpMGFvbFdvSlF3NGREZ3ErTGJzV05rZURx?=
 =?utf-8?B?cklIK2ZCREJRazU5SU1IUGJQREovZHd5Qkl6SStCdGJsc2ErSmtPN3VVTXl5?=
 =?utf-8?Q?gxPyTGtvxmHyvtSx+mdihUq5m3sNpW4lG20PaZuy48=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28a99d0-f020-4b1d-1f4d-08db6792cd4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 20:07:21.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdAZdLkd0yxixPg4RjICYCipxAWp1Mors7rT8OVasBhSV4aJz3EiqCzXV1HPEurYlII+vxj7AdlerX5uiqUqB8uF2XkNDOJi+XfRArKFDWg4KjLGmuzlvaTOG5ZUP2YZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiByZW1pQGdlb3JnaWFuaXQuY29t
IDxyZW1pQGdlb3JnaWFuaXQuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSnVuZSA3LCAyMDIzIDk6
NDYgUE0NCj5UbzogQmVybmQgTGVudGVzIDxiZXJuZC5sZW50ZXNAaGVsbWhvbHR6LW11ZW5jaGVu
LmRlPjsgbGludXgtDQo+YnRyZnNAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IHJvbGxi
YWNrIHRvIGEgc25hcHNob3QNCj5BbHRlcm5hdGl2ZWx5LCB5b3UgY2FuIGp1c3QgY29weSB0aGUg
ZGlzayBpbWFnZSBmaWxlIGZyb20geW91ciBzbmFwc2hvdCBpbnRvDQo+eW91ciBhY3RpdmUgc3Vi
dm9sdW1lDQo+DQo+Y3AgLWEgLS1yZWZsaW5rPWFsd2F5cyAvcGF0aC10by1zbmFwc2hvdC92bS5p
bWcgL3N1YnZvbHVtZS92bS5pbWcNCg0KVGhhdCdzIHdoYXQgaSBkaWQuDQoNCkJlcm5kDQoNCkhl
bG1ob2x0eiBaZW50cnVtIE3DvG5jaGVuIOKAkyBEZXV0c2NoZXMgRm9yc2NodW5nc3plbnRydW0g
ZsO8ciBHZXN1bmRoZWl0IHVuZCBVbXdlbHQgKEdtYkgpDQpJbmdvbHN0w6RkdGVyIExhbmRzdHJh
w59lIDEsIEQtODU3NjQgTmV1aGVyYmVyZywgaHR0cHM6Ly93d3cuaGVsbWhvbHR6LW11bmljaC5k
ZQ0KR2VzY2jDpGZ0c2bDvGhydW5nOiBQcm9mLiBEci4gbWVkLiBEci4gaC5jLiBNYXR0aGlhcyBU
c2Now7ZwLCBEYW5pZWxhIFNvbW1lciAoa29tbS4pIHwgQXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRl
OiBNaW5EaXLigJlpbiBQcm9mLiBEci4gVmVyb25pa2Egdm9uIE1lc3NsaW5nDQpSZWdpc3Rlcmdl
cmljaHQ6IEFtdHNnZXJpY2h0IE3DvG5jaGVuIEhSQiA2NDY2IHwgVVN0LUlkTnIuIERFIDEyOTUy
MTY3MQ0K
