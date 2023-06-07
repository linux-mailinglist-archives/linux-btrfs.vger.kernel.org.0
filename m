Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17E726FBC
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 23:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjFGVBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 17:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbjFGVAq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 17:00:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E922119
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 14:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jswx8TK0msvzh9gWSvOinRcd2qu+mA5yZlYKAL9DvM0ysYvy4ZzPiY4kyXezGEopoNzwa9oGsWMbKNOgIo59AojGYAOzciqB5rJrupV1w2RJ9IufCdWwg3YL/fMvRHu3ERIAS9LKvhiM0W0JzPkQbTfwDyK1ONPAR0y9c6cyFkqibRKhT03VPKpLePhB24q6eL8VBMjmSz/NjekbnJtO0Vo/9Lq+opHQiUFmuUGurcvUGoEnn2ll+1FyyTHbfGayUqnzgaVRdqW9RLjzHfri0UuISLU1v5el6ni/cuwNG40g6GeiTUI4PkMlISrkLf0EDERXm7eCvkUJbbCjxECcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc3no5eiXdFcd8801/3hoJ0i1AXVoMD/7WX/tfyJa6k=;
 b=czeDrlshY1yBYsRuG5BUhbV3fjCLi/YZVY8XfWPvpLrttB/gqsT4JWBLNDsE6Eorsl06fgszv2aJIVKiwVPdmzk5wgd/Jh3gTiEu3QQS7X4m8J118kyApNgOGXt/qc+BC+3YyNGjKVt/wxU2Jd28hDPbaRlIeojT/zUD4Vf9oFVTWybLlO9ZBKwRpHxcgagvZA/PgPacjpRKUgA86/5wKl9SjTeM750BYqeOII8B6TGq+ubp14+DQHuLyj8XAiot7865YchB2ujqs3QthBKI42NBlxT1lYCkpgPgqy9dAUfVERJpB+6JUObG1wB5SnnW7fT8+eCiFD/SDvnGBq3Y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc3no5eiXdFcd8801/3hoJ0i1AXVoMD/7WX/tfyJa6k=;
 b=LMS+7AljmQJ8fttGCyj9YnO5WkstHDTtmbGaJyGbZZC89KSUyIcfeJ9RpH6D8FNFq9RK3F4KKZr6y+GoDfyEwVOeyWEaXoBIeZd/9X0tOpLMLn3T5LwOQaAWX1eu2pkPzuMeg6AmFr6fWY+hZaAQM2xCeAQ2W3OeRg9fZyERnG4=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DU0PR04MB9586.eurprd04.prod.outlook.com (2603:10a6:10:31e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 21:00:14 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 21:00:14 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Roman Mamedov <rm@romanrm.net>
CC:     "remi@georgianit.com" <remi@georgianit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAzLYRAADFFIgAAGTo4AAABYgAAAAMyhAAABW5sAAABgV3A=
Date:   Wed, 7 Jun 2023 21:00:14 +0000
Message-ID: <PR3PR04MB734074AD7CF8403E4F150385D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
        <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
        <PR3PR04MB734090961ACE766466980F04D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
        <8c9b136c-c992-8c0e-a1e6-0e8aec1e89cd@gmail.com>
        <PR3PR04MB7340CB95E5AB4FC10706604DD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
        <d708df28-a0fc-411b-97a0-7d2bea2f5f72@app.fastmail.com>
        <PR3PR04MB7340C53376C738E6DDEA39B2D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <20230608014802.1dce81a0@nvm>
In-Reply-To: <20230608014802.1dce81a0@nvm>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DU0PR04MB9586:EE_
x-ms-office365-filtering-correlation-id: 2fcc74dc-e06b-414d-cee9-08db679a3093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wk/7iL28BixzaqFPh9gbyyFAk+osrM30CLHAHVL6IhrmjhBXudVg/apkUsCbfiR4eQXcTEKGSL7ewahVqe+sfEpLLQgMHHfTJw0U+5UH9TvzswSNmiH9vPnFYky60vl4e0TPbUKg0SF68q33BC2Vk6o5CHEWoJxX98xLy3cQegtHTYwcBqpxH4Pv82qRlO8KWEfbD049eueTrTtSC/f27O+F5/FxcSY3kN2D/R352aTkRcNRZy7mZjvOpBs0qUQGnP8/Fv8LkyIJWDTZNDgRueq8aEEHbBAGMzGWJ9KSVsUOm1XFQnPM1H6oc3/XR6UWyo1OPrvbiYe/f0gaTmkEnJg9mFoaUQwZ2gtKJT8Iyhbp1vh97P3Rm6Pt6KDGuBUPgoOVj+PxSEkDJWxn7U4ZSfnjmg8nTwvPf9MbuT7wkndjA5dJudw82Xg2GsjhlhXn1It3DOYbbWrFZDWbUd8qVKTeYOeimlgxUuvxpVrYuC3o/n/XQ9uDOfGsSoTs1P8nGdNYTy+BX5EJ1XWvihySvsY6/+KEHB2x5oWrHesjmWkETj9eCIejXmCNAJJ1IGpVXejzF7VlEclCmZDo3njiTT+xncC+JErcFl/Jen4FjBUp+26bmPRrds5c9pyfTStN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(451199021)(41300700001)(3480700007)(122000001)(4326008)(64756008)(66556008)(66476007)(66446008)(6916009)(76116006)(66946007)(5660300002)(8676002)(8936002)(52536014)(38070700005)(316002)(44832011)(9686003)(54906003)(86362001)(83380400001)(478600001)(38100700002)(2906002)(186003)(6506007)(55016003)(71200400001)(33656002)(7696005)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVh3UldOYVBIU3ZRZkRLU2JYcGFVbHY4ODVWdWxpOTgxUURoYUI2RlRmaXFk?=
 =?utf-8?B?Nzh5cUUxMGM3WUU0aWlrWmdJRnJIdkxaK3ZMQ2dVems0OVZEQ1p6QWpSZDVw?=
 =?utf-8?B?M2J6bUt1OU1FS2V0cERydUNlenR5YStNQUNubWVuRkZRaUFEUUYvOC8weGwv?=
 =?utf-8?B?VXZUUzQ1OFNXOHBkV2ZuSTM0d2dMMEtOY2pvbHNLcHFTQlBxR0ZKYURiOW5P?=
 =?utf-8?B?QWd1b25LWlNnQzZsTnVrb0ZvN0FnRUFYRGdQLzhIelB4eTY2STBJU2pMM0cy?=
 =?utf-8?B?VHp3VG1XV05JK3Z5dUN2VnB6bE9YUjVHZmZ6azR2TThFeXArdzYvNHpkWW1k?=
 =?utf-8?B?ei9tN1NRY3FuMHBiUUhLQitaUGZ6Vkx5dWZZbmorNDJ3SzE5SkZKYzVIR1lL?=
 =?utf-8?B?bmR5cVRLNzlSZXF3d0ZSOXhFVDZsanJ6Sk5iUGhOMk9pVWRNZVFtSWFIUDZ4?=
 =?utf-8?B?b0tDNHhqazBVMWp4MVozWTg3QWFjUGZiZ0Ezd2VwRENxY2hsazlBTFBlWFZY?=
 =?utf-8?B?c1poQzVZRnBNWjhTbEMwZGh5QzVuTTVDYWxsM29BL0M3dWRNSzFCSE5adkxr?=
 =?utf-8?B?UWFJcEN2ellEY0VuRm8wcE95RmJscGlDVXUxKyt1eGRHSGpxSisvRFpiR0Q1?=
 =?utf-8?B?YlJGYkRzRFNvQVIzaHNhOG9mcTRmMjZHVm02TkpXR3Bob1NET2lIMVIyYUN0?=
 =?utf-8?B?cy84eHU5OE1GUTVtTTJHMjgwWk1zenlranJGNTN0d0lZdTZscklrd2tQRUtp?=
 =?utf-8?B?QnpyUTRvSEFjRXltYThjSytvaHpIQjRBVWhUdW5uOGFPK05ER1dxenFMWTNr?=
 =?utf-8?B?MFY0c1NpQTRqM3MvUW5NaVZEZm9EbUZkOUorNUZHZHJqU3VuZzlnRG9UV1VW?=
 =?utf-8?B?d1pYNXBleFdVMUd4THFrNGNnaG80WjlFMWZiaGl6dVZIb1o2dElUaEtNcVR2?=
 =?utf-8?B?Y0dvczQyRERreklGdllpZkZ6SGk0QVkyeTFvTElSVkJmcitpa3dHUjdHYTMr?=
 =?utf-8?B?NWJGNnVlZ09vczdIR2g0Y2FuVTcvWWZhTjd2VTVHTEJzcWphWGttQXpTcHNU?=
 =?utf-8?B?SUpJNmMrSjRMVzhuYmdOSUF5WFlMU0FWSFl4SnZTOXFKWU9HVUlQUGtrb0Jj?=
 =?utf-8?B?V242a0hCaWdsUDdSei8wVDk5dkdHM2E3aGgyTGJodGxwY2h6ZGFmZXJ4ZkN4?=
 =?utf-8?B?SWhWYjU2MzZ4SFF6ejdneEIvVW5SSXk4UnJCVFdWc0dLazBWdExXSEVlMmFI?=
 =?utf-8?B?bXJ0a3B6ZEs5YU05M2M3SnlDUDVPODdEY3B5bjMvVXFSRFVyNDdpUjEvWjlP?=
 =?utf-8?B?d2tyYktpYnA2NW55RTlMTlJObjhtSWo5cmNVU1d3Y3I4V1BQNGF0d21KTGJF?=
 =?utf-8?B?R3E3Rm12WVFnWlgxWDNUWURmbkR6SHAzZ2d1TzJ5MWtOVmhaZTZmdTcrbE9V?=
 =?utf-8?B?bS9MaXFxb2FyUGtwSldRMEpuRnlTQkhHUm1yQzhDaVNvdjBSTGhXR2NMeXhj?=
 =?utf-8?B?N3RzWXFFWUlEWEZJaUdmdHFvU1U1b3BmN1FpSWF1S3hNVTEyQ0hRV0NvbnZG?=
 =?utf-8?B?Z25wVkhrdGFhV3hQTHRUNDJ3QmJLeUpvZ3N0a3FYL29FNUNNWXhjcEt2dzlz?=
 =?utf-8?B?RVVWYSs0SnNBZDNORTZLNFJacy9Na2NtN3BHNytndFZZT1hJOWlSamdrTVIx?=
 =?utf-8?B?bDVnUWcrUE5CRHBtN1F0ZEkxNk80OEpiMDNJNXBTN2FwNlpqWS9pYWE0b1RB?=
 =?utf-8?B?bGJwZTFuaGR5c1NHQmZCTWRPMUNpUkJuSjIxL1VTNXVMbWViVEQvMVVZVFZo?=
 =?utf-8?B?OVZMaVJXNXR3Qjhlazc4ZDd0WWJONFFOcGxNL3FpekpLK1ZyalNoZ0V4eWdH?=
 =?utf-8?B?eWxGQUJ0TDd1aWxhR2hmUEV0UHFPN0J6di9PNFE5bjdSUWxIQmpsN01GVDIv?=
 =?utf-8?B?dWJNV1krY2pwMDF6S1JJdkxZWE9ZZGVZYndUNlZIbjNvMVBkOEdhanNxZDcv?=
 =?utf-8?B?aVduRXRXRHZJUkNBTlZnRHJ3RkFybVpqVStUNzdQRytjUm13WFM5UUU1WTdq?=
 =?utf-8?B?MTlKeDFhNEVWODNoQTA2b1BIY0tydit5SnowM01oWHZaNGlvcExKQTRwNGZu?=
 =?utf-8?B?VWpmSStJWkV3Q3kyY0lFM3JEUDAzMUFoTm9pVkEyU0ZvR3lmQzVYL1c5OU1Z?=
 =?utf-8?B?aW9HRk0xbXJ2TDlzQnVZVUYyNlk5MXVsdk1xRmh6RWd3NVFtaW51ejgwUE15?=
 =?utf-8?Q?ZUJTw3AAOq5Xwse3QzapnrGO88AgmEOqgxX/F0xHBs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcc74dc-e06b-414d-cee9-08db679a3093
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 21:00:14.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XzN+3M0NS9l5+xEtKmDTbfneN/ACyUakKtDpe3oEeZpH0/udSuPbfRT3QHoqy/KMJWOjIhw/3QfihqgIS503U/3KQR/Kl4Ml5pCHgsw7h+NzTmytbKg01H6U+PLESdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9586
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBSb21hbiBNYW1lZG92IDxybUBy
b21hbnJtLm5ldD4NCj5TZW50OiBXZWRuZXNkYXksIEp1bmUgNywgMjAyMyAxMDo0OCBQTQ0KPlRv
OiBCZXJuZCBMZW50ZXMgPGJlcm5kLmxlbnRlc0BoZWxtaG9sdHotbXVlbmNoZW4uZGU+DQo+Q2M6
IHJlbWlAZ2VvcmdpYW5pdC5jb207IGxpbnV4LWJ0cmZzQHZnZXIua2VybmVsLm9yZw0KPlN1Ympl
Y3Q6IFJlOiByb2xsYmFjayB0byBhIHNuYXBzaG90DQo+DQo+T24gV2VkLCA3IEp1biAyMDIzIDIw
OjE0OjI3ICswMDAwDQo+QmVybmQgTGVudGVzIDxiZXJuZC5sZW50ZXNAaGVsbWhvbHR6LW11ZW5j
aGVuLmRlPiB3cm90ZToNCj4NCj5Ob3QgYWxsIGZpbGVzeXN0ZW1zIHN1cHBvcnQgcmVmbGlua3Mu
DQo+DQo+QnRyZnMgYW5kIFhGUyBzdXBwb3J0IGl0LCBidXQgZm9yIFhGUyB0aGlzIGhhcyB0byBi
ZSBlbmFibGVkIGF0IEZTIGNyZWF0aW9uIHRpbWUNCj4oSUlSQyByZWNlbnQgbWtmcyBlbmFibGVz
IGl0IGJ5IGRlZmF1bHQpLiBFeHQ0LCBSZWlzZXJGUyBhbmQgSkZTIGRvIG5vdC4NCg0KSXMgdGhl
cmUgc29tZW9uZSB3aG8gdXNlcyBSZWlzZXJGUyBub3dhZGF5cyA/DQpPQ0ZTMiBhbHNvIGtub3dz
IHJlZmxpbmtzLg0KDQo+Rm9yIFhGUyBpdCBpcyBhIHdheSB0byBoYXZlIHRoZSBiZXN0IG9mIHRo
ZSBib3RoIHdvcmxkczogaGF2ZSBhIGZpbGVzeXN0ZW0gdGhhdCBpcw0KPndlbGwgcmVnYXJkZWQg
Zm9yIHBlcmZvcm1hbmNlLCBidXQgYWxzbyBnYWluIGEgZGVncmVlIG9mIHRoZSBDb1cgYWJpbGl0
eSB0aGF0DQo+QnRyZnMgaXMgbGlrZWQgZm9yLCBlLmcuIGFsbG93aW5nIGluc3RhbnQgc25hcHNo
b3RzIG9mIFZNIGltYWdlcywgaW5jbHVkaW5nDQo+cnVubmluZyBvbmVzIHdpdGggYSBwb2ludC1p
bi10aW1lIGZ1bGwgaW1hZ2UgY29uc2lzdGVuY3kgLS0gdW50aGlua2FibGUgd2l0aA0KPnRyYWRp
dGlvbmFsIGNvcHlpbmcuDQoNCkJlcm5kDQoNCkhlbG1ob2x0eiBaZW50cnVtIE3DvG5jaGVuIOKA
kyBEZXV0c2NoZXMgRm9yc2NodW5nc3plbnRydW0gZsO8ciBHZXN1bmRoZWl0IHVuZCBVbXdlbHQg
KEdtYkgpDQpJbmdvbHN0w6RkdGVyIExhbmRzdHJhw59lIDEsIEQtODU3NjQgTmV1aGVyYmVyZywg
aHR0cHM6Ly93d3cuaGVsbWhvbHR6LW11bmljaC5kZQ0KR2VzY2jDpGZ0c2bDvGhydW5nOiBQcm9m
LiBEci4gbWVkLiBEci4gaC5jLiBNYXR0aGlhcyBUc2Now7ZwLCBEYW5pZWxhIFNvbW1lciAoa29t
bS4pIHwgQXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRlOiBNaW5EaXLigJlpbiBQcm9mLiBEci4gVmVy
b25pa2Egdm9uIE1lc3NsaW5nDQpSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0IE3DvG5jaGVu
IEhSQiA2NDY2IHwgVVN0LUlkTnIuIERFIDEyOTUyMTY3MQ0K
