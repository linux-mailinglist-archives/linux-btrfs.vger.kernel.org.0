Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F574726A7C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjFGUOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 16:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFGUOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 16:14:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630A18F
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 13:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY9iT530q6Hg6hrBQOb3rTUAjq5zXv2GACH/CUzLlkn04zIXSW5wdQL+WpJI9/kjrd1PXuWu7n6qXEoCeTm1LJbiBPXJPiByHpPy6LVTLztBwxI0JOjAn0ZjnQw7XXx/hL4uAt6ube7cNyUUU4Szleh3A+1m/NjX7/7SEQH+2eQkLchYWCC/S+2NsIX25KPgKFMSK4MeKjlL5tTbogbI+h9BSFnZU9kPMChZH9HwGw3htfSfIAo/1n9Dnni7xvNAdWNZYojjHMXZroz0EFTA3zfWocBhJ3LxaYiKb4Kn69CfZb8/mrifb3kpnqr7S8vaIEm05rEq0FccqdvKRL5YqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxuYaRoLz6CsQRUEc7IWCAdkSwen7gOAOriyudPnVNk=;
 b=lKTreVHbWOGO4b8zQwmU2T1G2u6dCentgCI05l+7HeHDaWGDLKM+wZMGegEKZVCD7dDdfXoIlme+BB87QFkNxykh3eTTqqp/tWqWFaDNLsFHMPaZ8kGhpRHiqSfowMzyzToLLhjfx0nquwUeFBFH8mRoZnmtgqSmAeF6o/JRe5ALbg4RdRgOFwryBYIIGEuOp7+ZbU46fZ6gXimoGsRZLi1ml58LV6izSkhTI3t5vP2SUyMRT9Bkv6J44dLUgHMzxB7+90QU3PxlOSt4AM8aAqm3K2mHWLN1ZvxdUNNXzTtTiN3AYGatNsojuhOYDOmenzIapaSzJU8O9hGpB/RyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxuYaRoLz6CsQRUEc7IWCAdkSwen7gOAOriyudPnVNk=;
 b=HX3gHDbI7YrzVGXEGJBaqtqsJfU/A2dH6gWgKYcijYyibvBWHVc19YqjsP+cXDXTbHQ2NqNab9LcSqrgeYEUk3WTpaMtXWuGnujKNYzUvcQs0JZMBAicMXAbLZTBZFd8DTeeX+NLMfmDpcwPzN7K0d0cY2Ta2dicO8LK7nH/hrU=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 20:14:27 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 20:14:27 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     "remi@georgianit.com" <remi@georgianit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAzLYRAADFFIgAAGTo4AAABYgAAAAMyhAA==
Date:   Wed, 7 Jun 2023 20:14:27 +0000
Message-ID: <PR3PR04MB7340C53376C738E6DDEA39B2D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AS8PR04MB8610:EE_
x-ms-office365-filtering-correlation-id: 2b9ecc89-55a3-4567-5b71-08db6793cb4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jj8NFJu4+ZcpZy54y3y2rv9akg6a1RebaTeeCA+Ry1UnzXQf55+V44Dggy7j3LcGEzDHlYbsJURbKItZetIr7pl1b7+L8VJKoqfIcOtTiH79rwG3u0c0Hl/046d1DF+GQvDH0oLh06tGJVycKq+vhPq+Hift8TTWvDeZjoBI3cgB73TuMQPXOKloabouoYCyZ3VSMZGa/YLB3McZJkhEdit/A58Bx0EbmhbFA+KcCghIEs7opfZA0TnvCrxwYeQMkOdcnE4RzUHROO+Vy6+5ckJcoP0U6ZxhkeRie+5Yu09LDgZp+2lOxDSCwGZsPOY67hnmFaEMKTVCCPxs/O6BX0CxYUHeGMm7cs4k6ewS/ECZ7kUWamR84pRmdxFCzs2IZbxhQhpuVALESpilKJqB8IyeK98qUXA9WSiRU0ZmwByUsAWQ5bVaF/EVsxzGhRMCeH3neQj/C3kG8L8LyYuA3AEqDYC0MJJR3cCr9UXXq1HnZQ6tWvP6BhoSnR+VQAY1vo+1kcUY3Rt9Ek9SHL9Zbur5aGF3FzEsBfDsHtf2ECZEeUZJOB7eqldz9nwxSLs8rJxd5oi+NLin5VovZFJTHNQ/Axy+ZZXTgd/pJsXw+nJMveKQ0hFVQ1wA7wGcGyJ3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39850400004)(451199021)(3480700007)(71200400001)(7696005)(2906002)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(122000001)(110136005)(38100700002)(5660300002)(38070700005)(8936002)(86362001)(8676002)(44832011)(52536014)(41300700001)(478600001)(33656002)(316002)(55016003)(966005)(9686003)(6506007)(186003)(66574015)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEdKbU1VRGVzQmtTc2IxNFZSdStueHhQSmc4Q3VrRzV6Sno1Wnl5UlU3a1o0?=
 =?utf-8?B?Mkw0RWFpalhiZmk5eUprVENKYzhObjMwcjZnRUlCbk1KaVJjRTVKY3AzYjJ2?=
 =?utf-8?B?M0RFOGlma3V2M2FkZHY1cit3V1ZJL1hTSFFZYmF0eDVITWEwOE4vNHFXNjZT?=
 =?utf-8?B?Yk1wSzg2SzFDTUxaR2owNGZtUzRiaDJyTVhKVWdFRXNnOTRDaWkzQVJGd0E4?=
 =?utf-8?B?MjZncmNEWXVuN0ZRSDRyc2dackZLVDBoYlpUVHF3aHpVS1dJZnVoWkloOWN2?=
 =?utf-8?B?d25JNzJGOWV0My9naEtDS2FxUWZ0QTA0VkgrRC9WZ3RIS3YyWURiem5BSGNx?=
 =?utf-8?B?Mm9JNG9UdkdjWXhuYWhHUG5ybTRpdE44cDNDNnFBTVJCSkpFSE5aU2tFR3BX?=
 =?utf-8?B?Zlp3bDZ2TW1kVFJta3k0M0tEUjNDOEVLZXA1bVRiaXdqTmNGQXdCVjNtVHFH?=
 =?utf-8?B?L09wYkIvbTZUV1pocy9iajVMd1pPd1JnRnlxek9SS0c3OUdJMzNMY2ErbFN5?=
 =?utf-8?B?VlE2K3hRWjRVelB3OVl4T1V4Nk9Ma0xxTm8zS0RyZWVFNUdsVDlNWTBXU1lN?=
 =?utf-8?B?aVVkQVVHdzVWSXhRNkhwa3ZkTjhGVkFEeVlBcVB5QzlWekxaTkVSMktwNis2?=
 =?utf-8?B?Mmk3NW5xTCtmSEgvOG81UXZqNVBOMXZuVDFLUmdVME1hWkRkc1ZqcHdxeHgx?=
 =?utf-8?B?YUs4MDhFcVcrdmhsMmg5M0IzVHF1V0pRWXhsSzRjNFpPQURDOTQrblAwMHJn?=
 =?utf-8?B?bEdpNDlLN2dCVnZ5WFNMUFNvTG9pR1JZN2FialQ2L0lTRWZrTUZ2a2hYQmRn?=
 =?utf-8?B?MDhSdkZkUjlkN3h0am1Rajd3U0pKcGZ0LzM1NGs3a25yZk01K3pwUlhJVFZl?=
 =?utf-8?B?SHMrYXMrSHYzTjZqQmE0WUlwQjdBZ1BZcllhQ1lPRGIxU1MzU0RsbnVhVTYr?=
 =?utf-8?B?VkE0Tk1Ld2VZQVJzdkl2dlA5YTdhakF4RUZDNHhhN0ZJWkg2T3Bhbm52a1lh?=
 =?utf-8?B?TE0wWG5rek0zMzNiVm05VVBRYXdtNFQxS0xqb2JQMEpwZ0FOQTRyODZ0VDFC?=
 =?utf-8?B?SStzWkZuc3dxL3B1Q25ESVhkZXZOclI5aTJYZHQ4cjJGSGhpNmJYOXFqV0t0?=
 =?utf-8?B?YzF2NXBmM1l2ZXEraEFVLytuWFU0ZDJDa1AzOU9PZ09nS2hBYkxVbHNPOHFQ?=
 =?utf-8?B?S3JQektBZlBSNjR0WHJEM3BLVGNnODJBMm5wNmZOMFZOWDdWR0RZcDZrV3Qv?=
 =?utf-8?B?dysyeHZFNzhlWTNITUZ4d2dLWnFrU0ErTFRpaVZRNzkvZ01OQ2hyMjVVVEpr?=
 =?utf-8?B?dTdEODNVcnorMTI4MlBoMVlkc1J5QTlidEJGVzJZQWtabWJBQmNjWTJ6bHB0?=
 =?utf-8?B?dEFuVWZZUitFRWlWalBFcHVJdWlKa2hQOEg1UnIxSXNjK2xRRHM3a0dmelhk?=
 =?utf-8?B?a2R0bFRJUHNJTFdIS1FYc2cxOGtIdFhDTk1YWi9uSm05TWNaOUIrNUdlQ3pI?=
 =?utf-8?B?M2xIeHpuTXNoek5tWHNreFp1eTREVEd6bW1ySkh2TzByWHdaN2VpZG00VzhI?=
 =?utf-8?B?MVZEc2RLQUtPWURBWjYvMjZGNUExQmxXdnh4d2tDWURHbFVnbzBUbWZiL3Yx?=
 =?utf-8?B?dVdhVllFQ3lHMUF5ZENBcDdpWmwwVmhCYlZYdElLejUweWhEV0FBUElad0t4?=
 =?utf-8?B?VStueFZBekNscS91THlXN0hmSjNZU0RqWHBxNlNIT05OTlhGbWlwOTIzUEU0?=
 =?utf-8?B?YUVGKzdGcXNuYWUxSnFGVE53aEhqUDVuTHViTGI4UUFnNER2bDVGTXo3Wmpy?=
 =?utf-8?B?aUxuQU1uZmxMSVl6TWJWdlRRdXRtTGd0ZzkwRXpmc2JxZnkwQTNBUFBwM0pV?=
 =?utf-8?B?dDdXWFBnQzlubUFhUE4xbHVNeDI5VUNTbUl2RGlCY1c0ZmZBMXpHL3FQY25w?=
 =?utf-8?B?Y29INkxNYW50bVRNTC9LcFdyMVBHUWd6N3V1WWEyaWU3VjBzL0ozcFFIM1Mx?=
 =?utf-8?B?N2I1bFB1Z281djdaQ2QxYkFoMSt5ZGRTaXRoYkpSbWFUMFZtZEhrK1ZjaGJX?=
 =?utf-8?B?M2t6S0h1bXlHcVFxM0xJU0ltSHpwSmdjUmhYazZSb0FKbHlwRnU3ZzRTbFdC?=
 =?utf-8?B?cFBrNUdZL2RzMldBUnhMOERvRVV3bGR6RWt0d3NTa0JFNTdrOHBCR1AwMGlM?=
 =?utf-8?B?T3p6Wkh0UCtRRjBORHAvbTRUWlFxSnE1OHl5YzZuemR5LzFFU2orMk1qQkhq?=
 =?utf-8?Q?W1JvLFfvxet8bQE5K2ZShok0lLgopaY660DF93mNs0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9ecc89-55a3-4567-5b71-08db6793cb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 20:14:27.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4c7oS2yNvUoFGhGRq5aYBhpEP9FbS7Lp8m+sz3oHCBpehvZs9mZHw3KqCgAeVDMThnaOMQNtwf2nLIsscniR4uMjYFuDj21rhq02oYIbyWWaFGNKHY16Xn07K4reZfM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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
bWcgL3N1YnZvbHVtZS92bS5pbWcNCg0KSSBkaWRuJ3Qga25vdyAiLS1yZWZsaW5rIi4gVGhlIGhl
bHAgc2F5czoNCiIgV2hlbiAtLXJlZmxpbmtbPWFsd2F5c10gaXMgc3BlY2lmaWVkLCBwZXJmb3Jt
IGEgbGlnaHR3ZWlnaHQgY29weSwgd2hlcmUgdGhlDQpkYXRhIGJsb2NrcyBhcmUgY29waWVkIG9u
bHkgd2hlbiBtb2RpZmllZC4gIElmIHRoaXMgaXMgbm90IHBvc3NpYmxlIHRoZSBjb3B5DQpmYWls
cywgb3IgaWYgLS1yZWZsaW5rPWF1dG8gaXMgc3BlY2lmaWVkLCBmYWxsIGJhY2sgdG8gYSBzdGFu
ZGFyZCBjb3B5Lg0KVXNlIC0tcmVmbGluaz1uZXZlciB0byBlbnN1cmUgYSBzdGFuZGFyZCBjb3B5
IGlzIHBlcmZvcm1lZC4iLg0KDQpJcyB0aGF0IGluZGVwZW5kZW50IGZyb20gdGhlIGZzID8gVGhh
dCBzZWVtcyB0byBiZSBhIGtpbmQgb2YgYSBzbmFwc2hvdC4NCkFtIGkgcmlnaHQgPw0KDQpCZXJu
ZA0KDQpIZWxtaG9sdHogWmVudHJ1bSBNw7xuY2hlbiDigJMgRGV1dHNjaGVzIEZvcnNjaHVuZ3N6
ZW50cnVtIGbDvHIgR2VzdW5kaGVpdCB1bmQgVW13ZWx0IChHbWJIKQ0KSW5nb2xzdMOkZHRlciBM
YW5kc3RyYcOfZSAxLCBELTg1NzY0IE5ldWhlcmJlcmcsIGh0dHBzOi8vd3d3LmhlbG1ob2x0ei1t
dW5pY2guZGUNCkdlc2Now6RmdHNmw7xocnVuZzogUHJvZi4gRHIuIG1lZC4gRHIuIGguYy4gTWF0
dGhpYXMgVHNjaMO2cCwgRGFuaWVsYSBTb21tZXIgKGtvbW0uKSB8IEF1ZnNpY2h0c3JhdHN2b3Jz
aXR6ZW5kZTogTWluRGly4oCZaW4gUHJvZi4gRHIuIFZlcm9uaWthIHZvbiBNZXNzbGluZw0KUmVn
aXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNodCBNw7xuY2hlbiBIUkIgNjQ2NiB8IFVTdC1JZE5yLiBE
RSAxMjk1MjE2NzENCg==
