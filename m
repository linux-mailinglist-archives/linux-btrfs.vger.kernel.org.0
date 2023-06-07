Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628AE7269E6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjFGThr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjFGTho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:37:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034FB1FC3
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps6ubzJuY6i85quZ9skwBdG7ltNbF/Yzd8VzTIgcrRu5Y2yxxhGvdnqeYhQKBCu1VwwhiErE3q0vLYYXK4xwawVuECm7EpNhX/3DfWmagwjXlyOvTpzllZd/UWFIrtqZoWnKUDHup6gpt8wx6a9zEzeb7DXb3JMSAlmkylgg0O9BSTqnkUg7Ftj7L8haG/bPP4RO5Xa2OPkLm6rzy8419Kitv5XwiMOdOjO/HoLzZBJA8Ey8ZEXwdHjhD35WkHE+uq/hObOH693UDcyRR0GF7W7J3VTv5msL1g5zRTtf5uuX2OD9R2TPVdUjGf2zfZFoWxWzarizN6cdlxWq9nEylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBr6Zt8S2RhkyeJlL2hEQvE4zZH0v22HEMIulCZj/ew=;
 b=Bybcy/n/mALr5ZpWFFVkXf9lmtpMqfWwgZO6xfyr6NzN8QmlaHf/W7xxqbCo84NO9A5jf5xWKPbu45Se53NlJ679m+UnPl3sEerA4hqfuloOiHDYVMWeb4TgIkRU+sxFHxjIJR3rijUjXHBb7szMecZU1buJzKTth5ghFLas8XWkXUJW440NhNH6Lru2w9QZM9t7P048SETBm7FkF5oZo1AN1rwn3616hgBW1O+aFpJdxFUmrKDoYHtYv4GqGTLGddffB/bjjoDJp2hNE44uhh7Yfr2NnP2+awpFp2+0IBRQWDD/nDknFvdRdOqmSp+ePSDB0dPqo7YOCF7jejeibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBr6Zt8S2RhkyeJlL2hEQvE4zZH0v22HEMIulCZj/ew=;
 b=sjchaLfgxy4dsL0CQbnc22amVNi76tRxyGG3JM1416h4eZKi3jQulGfHJww7lkezhhFu39KB6C5MBSemydUDrn+XR0ukit5cjRUzKHdro3ea3jSRh3JMl05I1WQ1ZDegJqrHwiP5BckRnx247HrZ9fSUBtmpptrDR39fdXgn3R8=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DU2PR04MB8823.eurprd04.prod.outlook.com (2603:10a6:10:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 19:37:39 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 19:37:38 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAzLYRAADFFIgAAGTo4A
Date:   Wed, 7 Jun 2023 19:37:38 +0000
Message-ID: <PR3PR04MB7340CB95E5AB4FC10706604DD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
 <PR3PR04MB734090961ACE766466980F04D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8c9b136c-c992-8c0e-a1e6-0e8aec1e89cd@gmail.com>
In-Reply-To: <8c9b136c-c992-8c0e-a1e6-0e8aec1e89cd@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DU2PR04MB8823:EE_
x-ms-office365-filtering-correlation-id: 6e8e1768-4fc3-40c9-5572-08db678ea6e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4rZlLHjHsXYcsDVLa4TKFAZxJKqQaM+P0Hl0iobdH54XzJ6xS9BvOpQiovoIm6+OeeeF37MBTcphlvgNoqcchxZ4kDaj4cPpPQprG4bW04nVnlCECacdFr5puB8yh1wKLBVwBOnt1ZNRalSGvkXWYDfI6tifC6sRQtG5nq37RTUjpFFiRQcOUGE5964qhm83VFs27MIzUEwjnyvkBjq6iXfuJoKJhHCm25mmkfMqbsxQd+/KUUKXnWBMzHISE5xExINAOQMmMHAiU7KGf5ZpxSU74E4peocsRQUAYcf2uDcRZAO5YO2wwd3ua2d2BbexQ/PpInfZ+tYfuualPsAEJ6+aF++FQ5cOGclVVfxe8X0RnwsqD3vPrhgBMJwXyBlBL+lBL2Y9mxWqj3f8ebkDfSVpMUSYAmVreHFACZjOCheKqoXwUg62qzHEu5LoYfLq4sxRxF3v/benKRKhF1VWwr2AH9CTvjVGmX5KcvZujDwyOWKZQeDLRNZpXrxW5lBAklKx+XrukBise5Hc7kr/yK9qqmvCMYewfhCbpqKBBBr1ugATl7AwkgeDLNAwHeg9BSKv/xR4j3pSzPLXdD5lwpuoJ0pSD27CZrijz1T8RZNkmFqUnTjBRhG4inYt1Db
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(451199021)(9686003)(6506007)(966005)(186003)(83380400001)(2906002)(4744005)(66446008)(64756008)(122000001)(66556008)(76116006)(66946007)(66476007)(3480700007)(7696005)(71200400001)(38100700002)(5660300002)(8936002)(86362001)(8676002)(44832011)(52536014)(38070700005)(110136005)(55016003)(478600001)(41300700001)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW5oelY3bWtpOG5pRW04LzZ0N3JGRkhUWk1KNTZBd2tyVTRZS0MyOXRJVmx3?=
 =?utf-8?B?VytUVkJ2SWxkNjIxVHVvblJSWlRYbmdOOUtEeGRGTzV2TWkxN3Bad2FnLzJk?=
 =?utf-8?B?RGFrL0F4QXR1YnpSWDZ5endrN1B4Tk44eG1RczZRU1d1dHJnR1JDN0IybUh4?=
 =?utf-8?B?SEJxRkJTRmlzbTZtNFlhRmZSNm0wY1E5aHZCQkFESjFxdXVPRmM1NWN0czBT?=
 =?utf-8?B?cUlqcURYbE9xWVRqRTdVdFg4dXoxR01LN0k0dnp6MW80ejF1a3lqRjl6MHNY?=
 =?utf-8?B?L2djOEhwYkZuMkdNMWxRSzFUVldPSU5uT2t3ZjY1OUlxL0JoenVkbVMweDRZ?=
 =?utf-8?B?TDM2NlA0T1ZiUTFVWVdRYkJaMmJ6blhKN3VqYmRBZzJTWkxtMmgxV0c0OEEy?=
 =?utf-8?B?UEZzMXZzMzF0NkNQRU0wa0pqbk5YTHU2N1E0cWtXN0pNMGxBYURDUEwwVC9G?=
 =?utf-8?B?WXlrOXY1NnhzbzRLMzIyT0dUR2JVbUl6cDNlMkVydVBVY2R5aE5EM2U4azkv?=
 =?utf-8?B?WGZ4TkVlOVk5QVc0RTJndi9vY3pOOFRUUFR3c2ptT1pVa1RKQ0R5Ly9YR01Y?=
 =?utf-8?B?dkNaK28xMUhpcHdMbFhhRHJBY2NlWjZYZUpidDVBMHl3bEpnMFNkZmZZYzg4?=
 =?utf-8?B?ZnhYVDg5dFkzK1hKZmF5YStZbS8rMWhBWVEvRWdNUmFhdjhyd09lWmRNL3VZ?=
 =?utf-8?B?QUVISFVDKzRHQ3k3SjN6M1FqcjlsWnZVNURhRlVYMVQ2NlJKZjlabytHZWxW?=
 =?utf-8?B?ZTlGTE9EZ1VzVzJ3SnVEenVRUGhBTWY4cytPc2JzcUE3cjk4Qml1ZjMxMks0?=
 =?utf-8?B?clZiS2FWbElTRWRyZmpEQ0xFNFJtN2loRFdGOHM0ZXhDTDBGSnlIK2xjbVJ5?=
 =?utf-8?B?QzhFc3JjVlViWDRFdXNNbUplRlB4blUwWG5Hc1lWdXg3TjV1MUs2RTc4c3JV?=
 =?utf-8?B?K2prVmxMQlM3VzdEK0N6bEZzNmF0OW9lKy9YSEpiWjdrZllWU1p0NC84VHd4?=
 =?utf-8?B?RXhPRm5Rd1BOeUtXeE1VYXNEQVZEa01FTVFTcHV2cm56WXNrMG9PQTE4N01M?=
 =?utf-8?B?SVNUTjdwY1p2S1NzdW5EbUtHZG1IL3dBKzVBbVQ2dUtaMUNxRk43QlpYcXRH?=
 =?utf-8?B?U29LVklEazBLbmJmOWlNM1Bhd3A2clVXMGZGNWQrVlhaT3JpTURjenF0cTM3?=
 =?utf-8?B?cVM5ckR5bmYzdkxvbDU5blVKWDMwbXhIOUl1YmpPWEVXMEVTR2lNVUlkaU1q?=
 =?utf-8?B?MDkwc3ZiNTQ1bi9IVUhRWktGeXpyaGc1VGtSOGhqaDAvemh0WjRLVGZGTGZv?=
 =?utf-8?B?L245dUZxRS8wTGlyREFGY3Q5RUcxYys2cVU2aHIzQ2xnODNkNXV1dUl3cU5U?=
 =?utf-8?B?UXUzU2NUU04vc2dPQkoydUNnZCtYelFzVTdWMW1XVzhOcFltb0JaeGJDUndx?=
 =?utf-8?B?dkp1aHNrb2xJTmNPZWVqSkc2a2lHVnBMaVowdWVMQXBYeEV1aUpnaEs4QWQv?=
 =?utf-8?B?WWVObCs4ZkNwaC81TXhtUU94WjRQd2lHd0hOTUU0ZTV5azJBd2dsdTRCdjVJ?=
 =?utf-8?B?SG1oVEhyTnNjQisvS0lEbHdvL2h0eUxiQWNpTThVNk9ueWlhK2pocXozQm80?=
 =?utf-8?B?Nkw0bGdFdlZMZEwrQythT2p5Tkh3bER4Q2lWK2RPWTZqcXMyVXFyK0VmRVN4?=
 =?utf-8?B?ZWY0MmUvRFNpeWcwU1p3V0ttR1hjUUxTYU5TNEVmNVpieCtqbjBYVmJRU202?=
 =?utf-8?B?T3pCMTE1WnJOZER2SlhIRFhWVDQ0aUluYk8rK1B4YUc4V0lLUzFiWFZxYncw?=
 =?utf-8?B?aStWMENiczF2M2lxQWNmenltd24xeXV6MnN5dVliWFI3U2gxenVlV1A5bnNm?=
 =?utf-8?B?Q2R4Qk5sVEJpdE82NFI0U0Nwei8yWllaVG1WWWY0VEptSnNHMlFrQ2c5enJj?=
 =?utf-8?B?TmZkRk5jeXZuNFNiNjBVa3NZSEFCclNTeWtDU3l2Tzl5WDNxN09wVWIwS1ZO?=
 =?utf-8?B?SXgvS3N4NTUxZXk0TUwvRFRScStxZlN2cWFvK245TWJWRTFPU3plWHJISmVm?=
 =?utf-8?B?Y2dPcGFwZWVIVEhVdVF3MzdsTkFpOTJyRTRQOE9rV1VGZHBFNUF0SjRXMEln?=
 =?utf-8?B?a0VsNExRQnpyWUVXZ3FTTXNtc1dPdEdadHRiQnRHY0Fja0ptYnhYWG9Rekg4?=
 =?utf-8?B?Qnh2MDhVQkNmL21yYkxQdjVWVEU0bHF3Tk8reGRiM3hkNkhwZ0Z1bXpSckYx?=
 =?utf-8?Q?t10HYgTujpFzwuIeA3zyGEpy5FfCF+whyuDFFJTW0M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8e1768-4fc3-40c9-5572-08db678ea6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 19:37:38.6129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uu98B+HojpyhDbylA5WWhvfVdtHRvvTlFktIO8q/vkvfP9A56IVFlHlnScjAa0xf38hw3JIeAFd67UwNNA+yR6ZILrfkA1wbvQFDnPTNLoZzcKT0PM34k1XjfB6UZ27T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBBbmRyZWkgQm9yemVua292IDxh
cnZpZGphYXJAZ21haWwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSnVuZSA3LCAyMDIzIDY6MzYg
UE0NCj5UbzogQmVybmQgTGVudGVzIDxiZXJuZC5sZW50ZXNAaGVsbWhvbHR6LW11ZW5jaGVuLmRl
PjsgbGludXgtDQo+YnRyZnNAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IHJvbGxiYWNr
IHRvIGEgc25hcHNob3QNCg0KPkl0IGlzIHJhdGhlciB1bmNsZWFyIHdoYXQgeW91IG1lYW4uIFZN
IGRpc2sgaW1hZ2VzIGFyZSBvbiBob3N0IGJ0cmZzIGFuZCB5b3UNCj5jcmVhdGUgc25hcHNob3Qg
b24gaG9zdCB0aGF0IGNvbnRhaW5zIHRob3NlIGltYWdlcz8gT3IgeW91IGhhdmUgVk0gd2hpY2gN
Cj51c2UgYnRyZnMgaW4gdGhlaXIgZ3Vlc3Qgc3lzdGVtPw0KDQpWTSBpbWFnZXMgYXJlIG9uIGhv
c3QgQlRSRlMgYW5kIGkgY3JlYXRlIHRoZSBzbmFwc2hvdHMgZnJvbSB0aGVtIG9uIHRoZSBob3N0
Lg0KDQpCZXJuZA0KDQoNCkhlbG1ob2x0eiBaZW50cnVtIE3DvG5jaGVuIOKAkyBEZXV0c2NoZXMg
Rm9yc2NodW5nc3plbnRydW0gZsO8ciBHZXN1bmRoZWl0IHVuZCBVbXdlbHQgKEdtYkgpDQpJbmdv
bHN0w6RkdGVyIExhbmRzdHJhw59lIDEsIEQtODU3NjQgTmV1aGVyYmVyZywgaHR0cHM6Ly93d3cu
aGVsbWhvbHR6LW11bmljaC5kZQ0KR2VzY2jDpGZ0c2bDvGhydW5nOiBQcm9mLiBEci4gbWVkLiBE
ci4gaC5jLiBNYXR0aGlhcyBUc2Now7ZwLCBEYW5pZWxhIFNvbW1lciAoa29tbS4pIHwgQXVmc2lj
aHRzcmF0c3ZvcnNpdHplbmRlOiBNaW5EaXLigJlpbiBQcm9mLiBEci4gVmVyb25pa2Egdm9uIE1l
c3NsaW5nDQpSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0IE3DvG5jaGVuIEhSQiA2NDY2IHwg
VVN0LUlkTnIuIERFIDEyOTUyMTY3MQ0K
