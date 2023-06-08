Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B157288D3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjFHTkA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 15:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbjFHTjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 15:39:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010792113
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 12:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FARsgZ4Lv4XjTDoE0M+HtTsaRfwDY6LkO5gBgYnFGv+tZTr5ssEQHZ3VQXtNF9DccMMYI011HtJaIO2vpACfwpIb1HloSW2f+kvZbwgAVI8qP90+jMmTIQ/ruyD8ctWcGd+cWmOlogBBSJPYvgxS50qGLiRg4008Bl8mFtongJO+DnXMkqRxTsagvIYQ7JNWTpxOIIErRhd3MzYytUNjtbBycxG254NOWrpT1cIX6YDYt0Mbki5dpiK3DnubgkG4mIWMqedEAAruW2YS22g9SZ1sdAaMWlmGvv6tIU/33tmgLyWiOZlwdjtfYrezN/eiCI2nFsYTIVL5sTm1kkEjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kKQubGDtkO5ic7WjkEYVXOA3aJqQfp1BThJ4w19mtA=;
 b=K7L/+sgFzEEGGQDJogUzhIs75Sb70Y9Yl//bOLT1rMOGtuLr0fekjJaO9YpqrxP+MyWe0BR6t5Q6C6/bP68nG1n81lGfSG6DkQ/5ZIn3q29/kYSt7cPmcHhXZYb3pyAiFdwXQtFvq9+/a9gNQUksqUVvSuqp1qfaOKVQaG4H/wVWcrMV2iACQGRUyQPNcpdhQh7sQXWJDXhWiBvfB+LJzDopnALRjyG/kC2hc23oVy+majAIZ5S9pni+J2b2lW8cfVK7ckj1PmSXTsvs9mynbWA7MJPHFZXGre0Fo+MHxOkOX/cT5TNZHEdYDmDk1+SnPekoO4JyF7XT+JLMsgo3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kKQubGDtkO5ic7WjkEYVXOA3aJqQfp1BThJ4w19mtA=;
 b=G1wv04wUfIGSd5u9Men/T/CLdDt+mc5Jqpu+ulKyBmY91aPHU53M9NwiU3HawI/Na/hev9OwGGMsNSVAe2i+TFLq2/TNQWs3+s1DOYO//dkv1rXfmKXtIBYVlV1WNsUYmOhfBK3gkc06D4JyfUuE4nxsQIvsppCk5eEANMPIBf4=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AS8PR04MB8328.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 19:39:47 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778%4]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 19:39:47 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Nicholas D Steeves <nsteeves@gmail.com>,
        Phillip Susi <phill@thesusis.net>
CC:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAyVbEAAE/dPgAAAwC4gAAPG1YAALFcuwA==
Date:   Thu, 8 Jun 2023 19:39:47 +0000
Message-ID: <PR3PR04MB7340EAFF7BDCB9A287C2201CD650A@PR3PR04MB7340.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AS8PR04MB8328:EE_
x-ms-office365-filtering-correlation-id: 6ff93566-893e-4d72-1250-08db68581e40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBiZaKlsbIacGk9D2gNnso/Ry0AKc43nnPKpRPOrri7HPCQCm5UnktXTfRWuP/tEftB3wYUHbsmuTqRqv2YEqlvXdX43nARNmEcrZOleLaGX8g0X5LAiYkOydvKdlF7iFc9ZBAkARYjWEif2l5JjievI++d5oYrwP+DeBedT/ySizEbzivEjS1Jko5j8yZ3AmdsV8r3/69CqHAReGR9w+r5Lrior0gYfFcGfcUCFouOd68IXizRv/Pr7gR1tmSK7tQW7qBYq8X4K/UU4E8QA4Fy9RQpsElDGgHUB+BoPAzpDyTDP8588pHxprPdm5ap6Lt19xHuNFaqC5wwHn+0oajqL5EOrP2cA0etmz7t3uLzIZK9MFL/N4RlpZqnc+Iwk2nzBahvjaivTDxmcQqMG9bCWgrx+jnA2OjggiuZ8Si81TWrY9dMXtnoUHtWBki1fmBPkGlIsjEwfMWW7kp9WcsJAKmhY11CJ3TGMjD84bl7Xi6u7t5t5uO7QogRFczPT/UacUrjYwOEXe0X+GULF7Jah4kc12ZmBUu5ojrAF2ZkYU/hroQtjYjoAQqUg9bXgXJmgOV7zG3spD2gmiuteOD0ca1M4uuTF2pLJTSpM48HnZtihFbwSmIIGCwZ0G2l5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39850400004)(366004)(451199021)(6506007)(9686003)(186003)(966005)(66574015)(83380400001)(2906002)(66446008)(64756008)(76116006)(66556008)(122000001)(66476007)(66946007)(3480700007)(7696005)(71200400001)(44832011)(5660300002)(38070700005)(8936002)(52536014)(38100700002)(8676002)(86362001)(54906003)(110136005)(55016003)(41300700001)(478600001)(33656002)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzFrL0VuWktydWVvWURUdXRKUmlJWUUzTitVbHRHVkJBOEdjTTZCRkdvbnpY?=
 =?utf-8?B?V21TUjd4Uk9GMDhuVlJ0eTNjVlBoV1RxWlV0a0E0UHc5Y1hZaFk1T2ErS05S?=
 =?utf-8?B?Uk1lVis5K3NNdGVmdS9zZ0xYT3VFYkV4M29EUVhOaUR6cXFiMWJYamFsa2NC?=
 =?utf-8?B?eUJ6Zml1N2pyRXJFdmI2L0xlVm5TMFhBdXRyZVlkTjZYRGwwSHFiWDg5a3U2?=
 =?utf-8?B?QVNDQkdIVGRZSmdOU3l0ZUI2THlWNk9pZXJMeFB3SGllV1NreUNCSUF5T1R5?=
 =?utf-8?B?LzhWTUJ6Zkt1dmF1aUpDdjFPd1I1R0dHNUltWG5oaHVaWEFpaDZVaTNRYmVj?=
 =?utf-8?B?MERGakE5TURwSHZqS2crTi9HckJpY3R2SDlOU2xGY0hvWlRMdklaRUhnWHZv?=
 =?utf-8?B?RGZjNzc2SUFTREtGeGozbGVvOWdwVlNhajB2OWtURkMzd3doM21DNjFydjVJ?=
 =?utf-8?B?M3VCV1FXT045MHo4Qy8zTjBhSkQya2ZvNEdsTFY5ZFVETnFpN3lrNTcvOE41?=
 =?utf-8?B?MnhRazNHUVBIYzNXUGdtclhKQXdOa2g0WUgwUk9LUmtadjlaMCtpQ3ZhY2c5?=
 =?utf-8?B?ZkZLUEpOQXFtUTA2VnA0c05qR29IQ2pRY0VMWTBHSzNQRkZDeUlUUlJHcm9o?=
 =?utf-8?B?c1p3Z2V3QmVBVDdWWEU1Q2dCaEMvM2pKU2U1Z0w1THVNQS9GS2lFaFV0RHkw?=
 =?utf-8?B?bk82OXdPSVRzMzBrc202ejlSOUNwVW1jR2lmWXZsaU1DUE5YTVM3bGxiUURZ?=
 =?utf-8?B?a2ErNnBEVDJuZEczMkpCbDVKTU83T1kyN3AvY2xWOGtTMFlCZTV0eWxPSWVK?=
 =?utf-8?B?R1FoaDZObUJPT1RqTmVtTVVSTitJMHczZ1BkRFMrTFdTeHJTeUo2QVBUMmdk?=
 =?utf-8?B?S2tTaFlmd3dLcXRvQitTczlKaldiOUxaK282U0srelFLcG1wRVVUd3VxeTZR?=
 =?utf-8?B?RnZEMEtvbzlnV0wrUW5zSHlFeDFGU1NSZ0hrbFN2NjBtWE45MUVmVkJuRlhY?=
 =?utf-8?B?M1ZOTnJrSjRYOHZFNklBVXRSNVd2OXg3R2JCTHhYVWhlM1hDNnFNSWFvYVR2?=
 =?utf-8?B?NC9WNWY1VXlzcDlWUDFwa3kxQVZEcjg5QmJsSEZyUWVzbVBWMnc3cTdRUmU4?=
 =?utf-8?B?T0lZelRIZklxRDFOd0Ryd2lHaTBxeWpJVHhLNm02cDFuVDkxY2lYaCtKaVNl?=
 =?utf-8?B?VHV0UVhhUUo3THNCSkg3b240Zzl6NThXRTVjVVRsZ29mVUJIQW1zRWhvdE9C?=
 =?utf-8?B?dDJBalJsMTBxWmwwWDlPbzJNSDhsQ2wvMlN2UzhXdTVZc01QMGdBL3FDZXdB?=
 =?utf-8?B?NFVqNFp4N1R5S1U3blVGNzBMVDhaVEd5U3IyNURESEpqVy9mcXp3bXcvekFS?=
 =?utf-8?B?VWwvU0pzd3pnRG5ZblpDQzgySFNzSTJZZ0RJa2x0NTJ6VHBxajNXQzhnMEFr?=
 =?utf-8?B?OEVxN0txc29NbkIrbkRsVEU4Zmx2NDUrTTJ6RlRNM2ZEUGRWQjdNUEJ6MkY5?=
 =?utf-8?B?Y3JtM2VHajRLdTNYT2ltTGFCd3dBbGNTQXVWMkdHYkx0MndQOUFUaHliOWQw?=
 =?utf-8?B?VTh0UVd2T1hOVHNYUXhxTUVSU2liUmFtWHRXZ1I3ZVF6L1AwUFVzRmdGbEdZ?=
 =?utf-8?B?cS9hckJ3NHlWN0ZsTVhvSzNzQW5yY2pzR2ZGVFNhenpKQkJBQ1ExNk1CU2lS?=
 =?utf-8?B?SlNQZWFyN2xZZE14N2xUWUFqNjNuQmc2RFNON2VtQTFsQlJ6ZjE0VUV6Zm1s?=
 =?utf-8?B?bzRRWi9aT09ETXZLZnRsdHBFa0hGTitMb1FBRkNKNDFsY2FJRWljejFWSWwx?=
 =?utf-8?B?VVp6RmYwdFZPZVdZZ01OSEU2bS9Kc0VxTitoNHBab2FiYURwNUwvdlk0MDhl?=
 =?utf-8?B?Uk9VTWQwTURhK20wSlBMbWgxbjlsazVlQVZ6aFhqUHN0M2JCV085UUhNY0RR?=
 =?utf-8?B?YytVWHl5b1FKMkNxSlkzS2wwOW93TXM3YjRMZXQzc1J4WmdHTXlkL0ZsZThj?=
 =?utf-8?B?SmpoNHdMeERzMEJ6NUZSN1dQVE50cEVNa2N2WGhmd1l0V1lsZXhwSU1sQ1J4?=
 =?utf-8?B?WS9JdU9TaEdyeDE5OFZrMU1jZXA2WFJsVVl3SHhmQytwVVFvQ2xmOGpFa0Ny?=
 =?utf-8?B?T0p1ekQzdUIvZGpObjlxdlBJdzA5RzJZNGp0U1ZibUl6dTh5dDB6eFlQYnFj?=
 =?utf-8?B?V3luYTE3U0JaVE94b0Q5dlhlUUNXNnR2R1puWVZ5S3k1eGk5OGNHVEhsWlJY?=
 =?utf-8?B?VlpkQm42L2J1V2lIR2E1cmwxUGtBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff93566-893e-4d72-1250-08db68581e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 19:39:47.6866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HM7tj7zDpB10w36AX3bPN/2mVYus+yfL2TSzH0PmGGMGuVj3m17ktW4eRVmc4XHt+3KOr+ioJnf3jR8K+5fcaFXitwRpCML9vwvgX56J8Rl+tqY4oz//EII6p0WVmpx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8328
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBOaWNob2xhcyBEIFN0ZWV2ZXMg
PG5zdGVldmVzQGdtYWlsLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgSnVuZSA4LCAyMDIzIDEyOjE4
IEFNDQo+VG86IEJlcm5kIExlbnRlcyA8YmVybmQubGVudGVzQGhlbG1ob2x0ei1tdWVuY2hlbi5k
ZT47IFBoaWxsaXAgU3VzaQ0KPjxwaGlsbEB0aGVzdXNpcy5uZXQ+DQo+Q2M6IEFuZHJlaSBCb3J6
ZW5rb3YgPGFydmlkamFhckBnbWFpbC5jb20+OyBsaW51eC1idHJmc0B2Z2VyLmtlcm5lbC5vcmcN
Cj5TdWJqZWN0OiBSRTogcm9sbGJhY2sgdG8gYSBzbmFwc2hvdA0KPg0KDQoNCj5JZiBJIHJlbWVt
YmVyIGNvcnJlY3RseSwgVWJ1bnR1IGxvb2tzIHNvbWV0aGluZyBsaWtlIHRoaXMNCj4NCj5zdWRv
IGJ0cmZzIHN1YiBsaXN0IC8gLXQNCj5JRCAgICAgIGdlbiAgICAgdG9wIGxldmVsICAgICAgIHBh
dGgNCj4tLSAgICAgIC0tLSAgICAgLS0tLS0tLS0tICAgICAgIC0tLS0NCj4zNDcgICAgIDQ3NzY0
MiAgNSAgICAgICAgICAgICAgIEANCj4zNDggICAgIDQ3NjIxNSAgNSAgICAgICAgICAgICAgIEBo
b21lDQo+DQo+d2hpY2ggaXMNCj4NCj5zdWJ2b2xpZD01DQo+ICAgICAgICAgfF8gQA0KPiAgICAg
ICAgIHxfIEBob21lDQo+DQo+YW5kIHlvdSBzaGFyZWQgdGhpcyBpbmZvIGluIHRoZSBpbml0aWFs
IHRocmVhZDoNCj4NCj4+IHJvb3RATWljcm9rbm9wcGl4Oi9ob21lL2tub3BwaXgjIG1vdW50fGdy
ZXAgYnRyZnMNCj4+IC9kZXYvbWFwcGVyL3VidW50dS0tdmctdWJ1bnR1LS1sdiBvbiAvbW50L2J0
cmZzIHR5cGUgYnRyZnMNCj4+IChydyxyZWxhdGltZSxzcGFjZV9jYWNoZSxzdWJ2b2xpZD01LHN1
YnZvbD0vKQ0KPg0KPj4gcm9vdEBNaWNyb2tub3BwaXg6L2hvbWUva25vcHBpeCMgYnRyZnMgc3Vi
IGxpc3QgL21udC9idHJmcyBJRCA0MzAgZ2VuDQo+PiAxMjE1ODY0IHRvcCBsZXZlbCA1IHBhdGgg
LnNuYXBzaG90cyBJRCA0MzQgZ2VuIDEyMTM1NjggdG9wIGxldmVsIDQzMA0KPj4gcGF0aCAuc25h
cHNob3RzLzA2LTA2LTIwMjMtLTE1OjE2X1BSRV9VUEdSQURFDQo+PiBJRCA0MzUgZ2VuIDEyMTYw
ODYgdG9wIGxldmVsIDQzMCBwYXRoIC5zbmFwc2hvdHMvMDYtMDYtMjAyMyBJIHdhbnQgdG8NCj4+
IGdvIGJhY2sgdG8gSUQgNDM0IG9yIDQzNS4NCj4NCj5TbyB5b3UgaGF2ZSBzb21ldGhpbmcgbGlr
ZQ0KPjEuIHN1YnZvbGlkPTUNCj4yLiAgICAgICAgICB8XyBADQo+My4gICAgICAgICAgfF8gQGhv
bWUNCj40LiAgICAgICAgICB8XyBzbmFwc2hvdHMNCj41LiAgICAgICAgICAgICAgICAgICAgIHxf
IDA2LTA2LTIwMjMtLTE1OjE2X1BSRV9VUEdSQURFDQo+Ni4gICAgICAgICAgICAgICAgICAgICB8
XyAwNi0wNi0yMDIzDQo+DQo+c3Vidm9saWQ9NSBpcyBhbHdheXMgdGhlICJyZWFsIHJvb3QiIEkg
dGhpbmsgQW5kcmVpIEJvcnplbmtvdiBpcyBjYWxsaW5nIGl0IHRvDQo+bWl0aWdhdGUgdGhlIGNv
bmZ1c2lvbiByZXN1bHRpbmcgZnJvbSBwb3RlbnRpYWxseSBoYXZpbmcgdXNlZCB0aGUgZGVmYXVs
dA0KPnN1YnZvbHVtZSBmZWF0dXJlLCB3aGljaCBpbiBteSBvcGluaW9uIHNob3VsZCBuZXZlciBi
ZSB1c2VkLCBiZWNhdXNlIGl0IHdpbGwNCj5jb25mdXNlIHRoZSBib290bG9hZGVyLiAgQSBkZWZh
dWx0IFVidW50dSBpbnN0YWxsYXRpb24gd2lsbCBoYXZlICJzdWJ2b2w9QCIgaW4NCj50aGUgYm9v
dGxvYWRlciwgd2hpY2ggbWVhbnMgYWxsIHRoYXQgeW91IG5lZWQgdG8gZG8gaXMgbW92ZSB5b3Vy
IHNuYXBzaG90DQo+aW50byBwbGFjZSAocG9zaXRpb24gIzIgaW4gdGhlIGFib3ZlIHRhYmxlKQ0K
Pg0KPlNvIEkgdGhpbmsgeW91J3JlIGdvaW5nIHRvIGRvIHNvbWV0aGluZyBsaWtlIHRoZSBmb2xs
b3dpbmc6IE1vdW50IHRoZSB0cnVlIC8NCj4ocG9zaXRpb24gIzEpIG9yIHN1YnZvbGlkPTUgdG8g
L21udC9idHJmcywgdGhlbg0KPg0KPiAgY2QgL21udC9idHJmcy9zbmFwc2hvdHMNCj4gIGJ0cmZz
IHN1YiBzbmFwIC1yIC4uL0AgLi9AX2Jyb2tlbi11cGdyYWRlICAjIG5vdGUgcmVhZG9ubHkgIi1y
Ig0KPiAgY2QgLi4NCj4gICMgSSBzdGlsbCBkbyBhIHN1YnZvbCBzeW5jIGFuZCBmaSBzeW5jIGhl
cmUNCj4gIGJ0cmZzIHN1YiBkZWwgLWMgLi9ADQo+ICAjIEkgc3RpbGwgZG8gYSBzdWJ2b2wgc3lu
YyBhbmQgZmkgc3luYyBoZXJlDQo+ICBidHJmcyBzdWIgc25hcCAuL3NuYXBzaG90cy8wNi0wNi0y
MDIzLS0xNToxNl9QUkVfVVBHUkFERSAuL0ANCj4gICMgICAgICAgICAgICAgL1wgbm90ZSBubyBy
ZWFkb25seSAiLXIiDQo+DQo+SWYgeW91IHN0dWNrIHdpdGggVWJ1bnR1IGRlZmF1bHRzIGFuZCBk
aWRuJ3QgdXNlIHRoZSBkZWZhdWx0IHN1YnZvbHVtZQ0KPmZlYXR1cmUsIHRoZW4gc3Vidm9sPUAg
aXMgc3RpbGwgd2hhdCBncnViIHdpbGwgYm9vdCwgYW5kIDA2LTA2LTIwMjMtLQ0KPjE1OjE2X1BS
RV9VUEdSQURFIGlzIG5vdyB0aGUgbmV3IHdyaXRhYmxlIEAuDQo+DQo+SSBiZWxpZXZlIHRoaXMg
aXMgdGhlIHNhZmVzdCBtZXRob2QgYXZhaWxhYmxlLiAgVGhlIHBlcmZlY3Qgc25hcHNob3R0aW5n
IHRvb2wNCj53b3VsZCBtYWtlIGl0IGVhc2llciB0byBzZWUgdGhlIHJlbGF0aW9uc2hpcCBiZXR3
ZWVuIHNuYXBzaG90ZWQgY29waWVzIG9mDQo+c3Vidm9sdW1lcy4NCj4NCj5Ob3RlIHRoYXQgcm9v
dGZzIHJvbGxiYWNrcyB3b24ndCBmaXggcG90ZW50aWFsbHkgaW5jb21wYXRpYmx5IHVwZ3JhZGVk
DQo+ZGF0YWJhc2VzIGluIEBob21lIChpcyB0aGF0IHJhcmUgdGhlc2UgZGF5cz8pLiAgVGhlcmUn
cyBub3QgcmVhbGx5IGFueSBnb29kIGZpeA0KPmZvciB0aGF0LCBvdGhlciB0aGFuIHRvIHJlc3Rv
cmUgdGhlbSBmcm9tIGJhY2t1cC4gIE5vdGUgdGhhdCB3aXRoIHRoaXMgbWV0aG9kDQo+eW91IHdp
bGwgbG9zZSBhIGRheSdzIHdvcnRoIG9mIGV2ZXJ5dGhpbmcgaW4gQCB0aGF0IGRpZG4ndCBoYXZl
IGl0cyBvd24NCj5zdWJ2b2x1bWUgKGllIGxvZ3MsIGFueSBWTXMgbm90IGluIEBob21lLCBldGMp
Lg0KPg0KPkZvciB0aGUgcmVjb3JkOiBJZiB5b3UgY29uc3VsdCB0aGUgdGFibGUgYWJvdmUsIHRo
ZSBkZWZhdWx0IHN1YnZvbHVtZSBmZWF0dXJlDQo+bWFrZXMgYW55IHN1YnZvbHVtZSBiZWNvbWUg
dGhlIHVzZXItYXBwYXJlbnQgLyBvZiB0aGUgZmlsZXN5c3RlbSwgYW5kDQo+aGlkZXMgYW55dGhp
bmcgdGhhdCdzIG5vdCBiZW5lYXRoIGl0cyB0cmVlLg0KPg0KPidob3BlIHRoaXMgaGVscHMsDQo+
TmljaG9sYXMNCg0KSGkgTmljaG9sYXMsDQoNCnRoYW5rcyBmb3IgdGhpcyB0aG9yb3VnaCBleHBs
YW5hdGlvbi4NCkkgZG9uJ3QgaGF2ZSB0aGVzZSBAIHN1YnZvbHVtZXMuDQpNeSBzZXR1cCBpczoN
CnJvb3RAY3Jpc3Bvci1zZXJ2ZXI6fi9za3JpcHRlIyBtb3VudHxncmVwIGJ0cmZzDQovZGV2L21h
cHBlci91YnVudHUtLXZnLXVidW50dS0tbHYgb24gLyB0eXBlIGJ0cmZzIChydyxyZWxhdGltZSxz
cGFjZV9jYWNoZSxzdWJ2b2xpZD01LHN1YnZvbD0vKQ0KDQpTbyBpIHB1dCB0aGUgLyBkaXJlY3Rs
eSBpbiB0aGUgdG9wIGxldmVsIHN1YnZvbHVtZSAoSUQgNSkuIEZyb20gd2hhdCBpIHVuZGVyc3Rh
bmQgdGhpcyBpcyBub3QgcmVjb21tZW5kZWQsIHJpZ2h0ID8NCklzIGl0IGJldHRlciB0byBwdXQg
YSBzdWJ2b2x1bWUgKG1heWJlIGNhbGxlZCBAKSAgaW4gdGhlIHRvcCBsZXZlbCBzdWJ2b2x1bWUg
YW5kIHRoZW4gbW91bnQgdGhlIHJvb3QgZnMgdG8gQCA/DQoNCkJlcm5kDQoNCkhlbG1ob2x0eiBa
ZW50cnVtIE3DvG5jaGVuIOKAkyBEZXV0c2NoZXMgRm9yc2NodW5nc3plbnRydW0gZsO8ciBHZXN1
bmRoZWl0IHVuZCBVbXdlbHQgKEdtYkgpDQpJbmdvbHN0w6RkdGVyIExhbmRzdHJhw59lIDEsIEQt
ODU3NjQgTmV1aGVyYmVyZywgaHR0cHM6Ly93d3cuaGVsbWhvbHR6LW11bmljaC5kZQ0KR2VzY2jD
pGZ0c2bDvGhydW5nOiBQcm9mLiBEci4gbWVkLiBEci4gaC5jLiBNYXR0aGlhcyBUc2Now7ZwLCBE
YW5pZWxhIFNvbW1lciAoa29tbS4pIHwgQXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRlOiBNaW5EaXLi
gJlpbiBQcm9mLiBEci4gVmVyb25pa2Egdm9uIE1lc3NsaW5nDQpSZWdpc3RlcmdlcmljaHQ6IEFt
dHNnZXJpY2h0IE3DvG5jaGVuIEhSQiA2NDY2IHwgVVN0LUlkTnIuIERFIDEyOTUyMTY3MQ0K
