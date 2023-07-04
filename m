Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D080C74775C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jul 2023 19:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGDRAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jul 2023 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGDRAk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jul 2023 13:00:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF021AC
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jul 2023 10:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8r3dtZwdCZyAh6VCxP/Kr7WOeWblxTK++QfyDIPNVyFzXn4ua4bXIyuAcbTYqJXppmC34XvYYRL55Jv9qspEh44yC3GoJa16AcN8AXyxBoxTs1laOrEMAdty+aLmmyJ0OKw2q2IljyQYwrF0X0WJjNQo17gKGL+4q3S3l4es9xB3j/YXmL2fshc7anUSUabc+slKPUeyFiOadbyq0kPKZbRLy7/d4e6rhJ8JS3265poJUPKnT5YiESHBd524o8fAgOf7I7RLPKdUk4hrCxlXBKYAwR6GB9SuJApjn7qHpMm0ibre8yzDLNewH3FttA6cLJYoTDuHPCdtM6iuTpVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhxjAYBO0wsjH75QMLJo2HRVSr7GltOd/p/TUGnZVWk=;
 b=ay2I2ctXaENdo704wTkW3BV5TvlHZtXxrU6f8NlwaDlQe8LAI41vp8kdrlXNJnYXK5m9Eh4XBxVEbBQlCRABd8p3Clpf8/ROj2JK9u+2D8Q83lrM0qZNnkiO3VlG0PrqOQ2IVK7PIaYOMbgLa9mNbGnVGjN2j0VK2PdRPpqC84BAbz5KPtp0ulKoIkMv8pDbFkm3q2P+qVfAXFUcsKGXlaKcbWaYZZ/YcQ0frjC1D0D7CDAnPJ3MzqUz93aWyKPZt1CUDI7SW6PBsrMER/Lsr0qdqeAJ6nfP7AQf4IH3tk4N0esmdy95UiFB532MDClXf5RGwhE2WKMurZDP2QsTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhxjAYBO0wsjH75QMLJo2HRVSr7GltOd/p/TUGnZVWk=;
 b=eZqLTMNQhWSZjyhAUxAi38HO1Q5XG78fqM5Q3z/Rm6pYRUEvRLj1lTmNXFpegAvFVbP9vFs9X9iT4SRWpItoquiR6dh1Qam0lQNZBGr3t6nSyLKcFLAZhEG3bQ26S9g4et5FMXAaFGy1cjTWBnkwBymiKZLwLJ8m/kJFI+Fj6vk=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AS4PR04MB9624.eurprd04.prod.outlook.com (2603:10a6:20b:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 17:00:35 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 17:00:34 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: question to btrfs scrub
Thread-Topic: question to btrfs scrub
Thread-Index: AdmqYWxcqzByINPHTMyzVF+8SQB2BgAB8fyAAA4C3wAAJq31gADUQtNgAALlqkA=
Date:   Tue, 4 Jul 2023 17:00:34 +0000
Message-ID: <PR3PR04MB734072BAA9012917AE1E98B7D62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
In-Reply-To: <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AS4PR04MB9624:EE_
x-ms-office365-filtering-correlation-id: a6073014-48bb-4c37-221f-08db7cb02eff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wH8kPBrgWJSjRoDKtqFR3Fx6dY/kok50REkRasSB4NCIForID+PLTS6I47IO0yhwTzMPt/Dc7VU/OjgZDkH4iquZu4xLNI+uvBhrTS/QHL0XdFOEKSS5e7esLJnGgQDUBAC7sN8TFCw9SKyUGROsydiHW3GVwV74z+ahE4gmciRKDzHnJdKKy/f8zNyA6hvXMrUfOzeXihN6JX1M00JfxkscHlmdCP/GiDeHsRSJCE9/X/YXcjNfjoRR+wSXRbXGk5Gvl0Kquiy4Yqk1mD6DW8PIYRG7NGquTBXZu5nyBNwQSHwnzV2V/b9wg3ksoNHeMYvy6FD1xzA3fAVfTILGfJR2qJ0BognInQE81MQXEI+FUO/Yz5Le9b4qx9GNPbwI8etJumv+FvFNEOcFroWR0QAZfVrPsKyJlIaPnLJ6VObMhbkqvy2wrIFh91ZKA41byjzYoIZbL03o1e3gawtBEalfVYM7RF5hOSWnl34+OW6EPfU5xd1bles+B/OkZSRsrEOtWyylkNYW/QUybCd2soFG1+ewpbKgI40tGj+5g/b9Qfik3FDVJbRgsNSjADCJNiTPYQXtERRhCPuiBrePLChKGzQA+20E7/o7+dPCugcX3UKTkj9WXKTHHDuo3hIK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39850400004)(376002)(396003)(451199021)(6506007)(53546011)(76116006)(66476007)(64756008)(316002)(38070700005)(38100700002)(122000001)(55016003)(66446008)(66946007)(66556008)(2940100002)(83380400001)(66574015)(186003)(26005)(9686003)(478600001)(110136005)(3480700007)(2906002)(8936002)(8676002)(52536014)(44832011)(5660300002)(71200400001)(86362001)(33656002)(966005)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUhIL2kyM0ZqcTlXc1ErRUtZZVdmMnVwMTZWNHVsVkhFbmpOV2I4a0dOTmtC?=
 =?utf-8?B?UGRxNVFGU1lKd1ZYYjQvcTlsajJmaXpuSjRGanE5ZVRJY3NsR3p0T3dCUWtm?=
 =?utf-8?B?V2Q5TzJyOEc2VG1EcXl0T1RUcEg2TS9IMG45eFJYSThvRmFISjN0OG14ZzVy?=
 =?utf-8?B?Vm1kU2VVMG1QLzA0RG9iTnc0OURDWWZNZHZxczNHcVpmemcxUFNaaFRmK1M5?=
 =?utf-8?B?OUllMXF2Wnpuak1uT2hMZzNTUG16N1Z0M3BIZUx2RElsUFB4RytEajA0cUhW?=
 =?utf-8?B?UjlsenhSeTJjSmhGUlJDK2FmOWNRVU9XUHF4ZXkzY3c2OVdrM0QzeVNIWHht?=
 =?utf-8?B?UXhxK3hEMlRUVThSa0kwQ1NYdkpiOGhlRi9XMVVDdVlWVFY5eXZBZDIxM0xs?=
 =?utf-8?B?Wk5FbEFYSlErbU03QlY2RlQzd1o3aDFmRHJWZFFCN0NTK1IyamdhZmExNGVB?=
 =?utf-8?B?WnlTZEZaK0tYVkIraEFUUTBLY2NxZUJKSDdkRGFTVjNjaXpQNzFHYnhraEEr?=
 =?utf-8?B?RHFVY1MwWEhTQUppeUowVFlzeUlWcmxGU09GMUFINWdwdVFod0d6N0pNSk1h?=
 =?utf-8?B?S1F6T0ltc0tOdnFnc0V5UUxFS1pjbmE5VXhXTTY1aHJvQjRlb254K0czWVRM?=
 =?utf-8?B?U0ZRaXFMZFdWSUdJV3ZGUW4zZlM0WExCN2cvSWRTSkxHQ3dEZGloWEtWZjZF?=
 =?utf-8?B?YVFTSWNHc0htQ3M5N3BtcklpQ0JMaHQyYm1TSVJKRytRN015bHVvZEhhYVpF?=
 =?utf-8?B?eXc2K01HNDdPdnJuZTY5by9HcnpLZTlnUk01akNaenBqS3oyeXk0dVNpdDh1?=
 =?utf-8?B?cHJQaDJFQTI1SFdpc0R3ZkxrMEZSZ3pSMGFDdUQwR0JoYlJNT1Q5QzI2bkxw?=
 =?utf-8?B?TGpZOEt2M2lFU09maHlSOWV3ZFREMXJRUUd5VFRhbE9idWcxekJVbFhuRnUr?=
 =?utf-8?B?TGtFZ01MU1Mxci9YNzlsSk5uaVU1ZExkWDlFZURNNFVQa3phbGVRZkFRQkFl?=
 =?utf-8?B?TnBwM0lHeWgvdUhXV2lyNThUL2liRHlMclFxbi9yNkJZV3I2MDhZemg4M01C?=
 =?utf-8?B?dnp4VWl3YndvbDFLVU9ndEZ4TGt5bHNHMlBSOGVqd2luWTQxYVRVN0w3RHZG?=
 =?utf-8?B?dG1PRW42OHhFMDBtbEk0aVdreFNMVEs1ZEF5MW1UQy9tcWlrVExTakhHZEZZ?=
 =?utf-8?B?TktuU2NkRDRYWU51eDlld3VrL3BZNGI2N3ZzK1NEQXhENnNTOW1GZ0lPVy9F?=
 =?utf-8?B?ZGxBR21RdWtGNWFnbHhUdVlzOEE4akhEdzNXUmcrdW9CTXA5NHlTVEJOQXps?=
 =?utf-8?B?K2oxNWYrTjNhK3JhU0JOanovVFZ1M0trYm1sdjA5ZS9qa1ZtUUR3d3pJNFFE?=
 =?utf-8?B?bVhCOEJnS3BIVS9zYzRLTDJ5dmFQc2E5UnNuWjl4TlR2MGN2SkJldE1BM2po?=
 =?utf-8?B?TFNkQUFlQ2Z1aEFyTlB6Wjk2NXN1WTJIUXJYTC9DOWFFYm02NXdmVHQ3dWJh?=
 =?utf-8?B?YmlOVWtZc0h1RldFZC95elRBWklkMGduVDdzMzZZOHdXK1JEQTRnL1ZEdXNL?=
 =?utf-8?B?VmVTVVdHMG1BYmJQUi9ueTRQRUYycFpvVXV5TUN4ZGtCOFpNMTdJYlY5STVY?=
 =?utf-8?B?RnR1dzg3Y2JIWkV1TmJ6eTZ0THF0amw1OTdNQXU5eW13SThuR0R0R05FZElG?=
 =?utf-8?B?OVpMNFRONFR4L1hFSzhlTU9CUzhoaW15WlV2RC9vMm5ya2dnTkF6OXZCQ0tX?=
 =?utf-8?B?YzA5NTJrWFhjT2ZkQ2UwNUZHS2tkdjFGUkRnYy9Td2F5YU9CL3dVeWdMaHlm?=
 =?utf-8?B?VmhEeE85Z29EbTE4OVJEQkd0aVRaTVduTU1oUGJTVVlYMWh2c1FUUTAxQjVJ?=
 =?utf-8?B?REtkdXNzY0Y0Y2l3aUFUWXNTRVVueXE4d0pCOFdUOG5BQ3ZIdTBIR3dteURz?=
 =?utf-8?B?TEJKZ09CL2xRSS9kS0E5THV6elN3ekNNbVBUM2NWMUJ5T3gyQUYrSXJwb3hD?=
 =?utf-8?B?MDd2ejdYSEJYYWJWT0E0aXF1RkJVY0tzYytqZHpIbUFZSktXVmpiQmU1RkhM?=
 =?utf-8?B?Sm04bU9Gc1RPRzdEZ0dnWUYvQ0hTdWtES3B6akd3TENZaXBiajBvdi81OEtv?=
 =?utf-8?B?Qjd6TXo4RXVackdtZUVSS2o0Wll0RU1zSkR6WnM2eFNoSFIvLytqNG85SjVi?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6073014-48bb-4c37-221f-08db7cb02eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 17:00:34.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZegmUFTpwTEuJZY0RZRRP2XptZzqeVHrBcwcXCa7z2Aeb+ZDFOdnG7X4aDtgkQWdBHQiJTAQchLs4qgTtqrecFxDLh7jlMaW1zY46gNismTzVvvQdqf5cq55+cqlQuCx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9624
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlcm5kIExlbnRlcyA8YmVy
bmQubGVudGVzQGhlbG1ob2x0ei1tdWVuY2hlbi5kZT4NCj4gU2VudDogVHVlc2RheSwgSnVseSA0
LCAyMDIzIDY6MDQgUE0NCj4gVG86IFF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT47
IGxpbnV4LWJ0cmZzIDxsaW51eC0NCj4gYnRyZnNAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBSRTogcXVlc3Rpb24gdG8gYnRyZnMgc2NydWINCj4NCj4NCj4gSSBtYWRlIGEgYnRyZnMgY2hl
Y2sgb24gdGhlIGltYWdlIGFuZCBvbiB0aGUgdm9sdW1lIGl0c2VsZjoNCj4NCj4gaGEtaWRnLTE6
L21udC9zZGMxL2hhLWlkZy0xL2ltYWdlICMgYnRyZnMgY2hlY2sgLXAgL2Rldi92Z19zYW4vbHZf
ZG9tYWlucw0KPiBPcGVuaW5nIGZpbGVzeXN0ZW0gdG8gY2hlY2suLi4NCj4gQ2hlY2tpbmcgZmls
ZXN5c3RlbSBvbiAvZGV2L3ZnX3Nhbi9sdl9kb21haW5zDQo+IFVVSUQ6IGJiY2ZhMDA3LWZiMmIt
NDMyYS1iNTEzLTIwN2Q1ZGYzNWEyYQ0KPiBbMS83XSBjaGVja2luZyByb290IGl0ZW1zICAgICAg
ICAgICAgICAgICAgICAgICgwOjAwOjM2IGVsYXBzZWQsIDY5MDAxMzQgaXRlbXMNCj4gY2hlY2tl
ZCkNCj4gWzIvN10gY2hlY2tpbmcgZXh0ZW50cyAgICAgICAgICAgICAgICAgICAgICAgICAoMDow
MTo1OCBlbGFwc2VkLCA0ODQ5OTUgaXRlbXMgY2hlY2tlZCkNCj4gWzMvN10gY2hlY2tpbmcgZnJl
ZSBzcGFjZSBjYWNoZSAgICAgICAgICAgICAgICAoMDowMDoxMyBlbGFwc2VkLCA1MTg0IGl0ZW1z
IGNoZWNrZWQpDQo+IFs0LzddIGNoZWNraW5nIGZzIHJvb3RzICAgICAgICAgICAgICAgICAgICAg
ICAgKDA6MDI6MzkgZWxhcHNlZCwgNjU1NDkgaXRlbXMgY2hlY2tlZCkNCj4gWzUvN10gY2hlY2tp
bmcgY3N1bXMgKHdpdGhvdXQgdmVyaWZ5aW5nIGRhdGEpICAoMDowMDoxMCBlbGFwc2VkLCAzMjM2
MzI4DQo+IGl0ZW1zIGNoZWNrZWQpDQo+IFs2LzddIGNoZWNraW5nIHJvb3QgcmVmcyAgICAgICAg
ICAgICAgICAgICAgICAgKDA6MDA6MDAgZWxhcHNlZCwgMTMgaXRlbXMgY2hlY2tlZCkNCj4gWzcv
N10gY2hlY2tpbmcgcXVvdGEgZ3JvdXBzIHNraXBwZWQgKG5vdCBlbmFibGVkIG9uIHRoaXMgRlMp
IGZvdW5kDQo+IDUzOTY3NzA2MTEyMDAgYnl0ZXMgdXNlZCwgbm8gZXJyb3IgZm91bmQgdG90YWwg
Y3N1bSBieXRlczogNTI2MzAwMTQyNA0KPiB0b3RhbCB0cmVlIGJ5dGVzOiA3OTQ1ODYzMTY4IHRv
dGFsIGZzIHRyZWUgYnl0ZXM6IDEwNzc0OTM3NjAgdG90YWwgZXh0ZW50DQo+IHRyZWUgYnl0ZXM6
IDgyODM5MTQyNCBidHJlZSBzcGFjZSB3YXN0ZSBieXRlczogMTEyNDE0Mzc4NyBmaWxlIGRhdGEg
YmxvY2tzDQo+IGFsbG9jYXRlZDogMTI3NzA0Njg0NTU2Mjg4ICByZWZlcmVuY2VkIDgwODQ5MDY2
MjI5NzYNCj4NCj4gaGEtaWRnLTE6L21udC9zZGMxL2hhLWlkZy0xL2ltYWdlICMgYnRyZnMgY2hl
Y2sgLXAgL2Rldi9sb29wMCBPcGVuaW5nDQo+IGZpbGVzeXN0ZW0gdG8gY2hlY2suLi4NCj4gQ2hl
Y2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L2xvb3AwDQo+IFVVSUQ6IGJiY2ZhMDA3LWZiMmItNDMy
YS1iNTEzLTIwN2Q1ZGYzNWEyYQ0KPiBbMS83XSBjaGVja2luZyByb290IGl0ZW1zICAgICAgICAg
ICAgICAgICAgICAgICgwOjAxOjI0IGVsYXBzZWQsIDY5MDAxMzEgaXRlbXMNCj4gY2hlY2tlZCkN
Cj4gWzIvN10gY2hlY2tpbmcgZXh0ZW50cyAgICAgICAgICAgICAgICAgICAgICAgICAoMDowNDoy
OCBlbGFwc2VkLCA0ODQ5OTIgaXRlbXMgY2hlY2tlZCkNCj4gWzMvN10gY2hlY2tpbmcgZnJlZSBz
cGFjZSBjYWNoZSAgICAgICAgICAgICAgICAoMDowMDo0NiBlbGFwc2VkLCA1MTg0IGl0ZW1zIGNo
ZWNrZWQpDQo+IFs0LzddIGNoZWNraW5nIGZzIHJvb3RzICAgICAgICAgICAgICAgICAgICAgICAg
KDA6MDI6NDUgZWxhcHNlZCwgNjU1NDkgaXRlbXMgY2hlY2tlZCkNCj4gWzUvN10gY2hlY2tpbmcg
Y3N1bXMgKHdpdGhvdXQgdmVyaWZ5aW5nIGRhdGEpICAoMDowMDoxMCBlbGFwc2VkLCAzMjM2MzI4
DQo+IGl0ZW1zIGNoZWNrZWQpDQo+IFs2LzddIGNoZWNraW5nIHJvb3QgcmVmcyAgICAgICAgICAg
ICAgICAgICAgICAgKDA6MDA6MDAgZWxhcHNlZCwgMTMgaXRlbXMgY2hlY2tlZCkNCj4gWzcvN10g
Y2hlY2tpbmcgcXVvdGEgZ3JvdXBzIHNraXBwZWQgKG5vdCBlbmFibGVkIG9uIHRoaXMgRlMpIGZv
dW5kDQo+IDUzOTY3NzA1NjIwNDggYnl0ZXMgdXNlZCwgbm8gZXJyb3IgZm91bmQgdG90YWwgY3N1
bSBieXRlczogNTI2MzAwMTQyNA0KPiB0b3RhbCB0cmVlIGJ5dGVzOiA3OTQ1ODE0MDE2IHRvdGFs
IGZzIHRyZWUgYnl0ZXM6IDEwNzc0OTM3NjAgdG90YWwgZXh0ZW50DQo+IHRyZWUgYnl0ZXM6IDgy
ODM0MjI3MiBidHJlZSBzcGFjZSB3YXN0ZSBieXRlczogMTEyNDA5NTIxMSBmaWxlIGRhdGEgYmxv
Y2tzDQo+IGFsbG9jYXRlZDogMTI3NzA0Njg0NTU2Mjg4ICByZWZlcmVuY2VkIDgwODQ5MDY2MjI5
NzYNCj4NCj4gU3RyYW5nZS4gTm8gZXJyb3IgZm91bmQuIEkgZXhwZWN0ZWQgZXJyb3JzIGJlY2F1
c2Ugb2Ygd2hhdCBidHJmcyBzY3J1YiBzYWlkLg0KPiBJIGNoZWNrZWQgdGhlIGxvZ2ljYWwgdm9s
dW1lIHdpdGggYmFkYmxvY2tzIC0gbm8gZXJyb3I6DQo+IGhhLWlkZy0xOn4gIyBiYWRibG9ja3Mg
LXN2IC1iIDQwOTYgL2Rldi92Z19zYW4vbHZfZG9tYWlucyBDaGVja2luZyBibG9ja3MNCj4gMCB0
byAxNjY0MzAzMTAzIENoZWNraW5nIGZvciBiYWQgYmxvY2tzIChyZWFkLW9ubHkgdGVzdCk6IF5b
W0FeW1tCZG9uZSBQYXNzDQo+IGNvbXBsZXRlZCwgMCBiYWQgYmxvY2tzIGZvdW5kLiAoMC8wLzAg
ZXJyb3JzKQ0KPg0KPiBOb3cgSSdtIGEgYml0IGNvbmZ1c2VkLiBiYWRibG9ja3MgYW5kIGJ0cmZz
IGNoZWNrIG5vIGVycm9yLCBidXQgYnRyZnMgc2NydWIgYQ0KPiBsb3Qgb2YgZXJyb3JzOg0KPg0K
PiBoYS1pZGctMTovbW50L3NkYzEvaGEtaWRnLTEvaW1hZ2UgIyBidHJmcyBzY3J1YiBzdGFydCAt
QiAvbW50L2ltYWdlLyBzY3J1Yg0KPiBkb25lIGZvciBiYmNmYTAwNy1mYjJiLTQzMmEtYjUxMy0y
MDdkNWRmMzVhMmENCj4gU2NydWIgc3RhcnRlZDogICAgVHVlIEp1biAyNyAyMDo0NzoyNiAyMDIz
DQo+IFN0YXR1czogICAgICAgICAgIGZpbmlzaGVkDQo+IER1cmF0aW9uOiAgICAgICAgIDM1OjM5
OjQ4DQo+IFRvdGFsIHRvIHNjcnViOiAgIDUuMDdUaUINCj4gUmF0ZTogICAgICAgICAgICAgNDAu
MTZNaUIvcw0KPiBFcnJvciBzdW1tYXJ5OiAgICBjc3VtPTEwNTINCj4gICBDb3JyZWN0ZWQ6ICAg
ICAgMA0KPiAgIFVuY29ycmVjdGFibGU6ICAxMDUyDQo+ICAgVW52ZXJpZmllZDogICAgIDANCj4g
RVJST1I6IHRoZXJlIGFyZSB1bmNvcnJlY3RhYmxlIGVycm9ycw0KPg0KPiBXaGF0IGNhbiBJIGRv
ID8gSSdtIGFmcmFpZCBJIGhhdmUgdG8gcmVmb3JtYXQuDQo+IEJ1dCB3aGF0IGJlIHRoZSBjdWxw
cml0IGZvciB0aGUgZXJyb3JzID8NCj4NCj4gQmVybmQNCg0KSSB0aGluayB0aGlzIGlzIGFsc28g
aW5mb3JtYXRpdmU6DQpoYS1pZGctMTp+ICMgYnRyZnMgZGV2aWNlIHN0YXRzIC9tbnQvZG9tYWlu
cy8NClsvZGV2L21hcHBlci92Z19zYW4tbHZfZG9tYWluc10ud3JpdGVfaW9fZXJycyAgICAwDQpb
L2Rldi9tYXBwZXIvdmdfc2FuLWx2X2RvbWFpbnNdLnJlYWRfaW9fZXJycyAgICAgMA0KWy9kZXYv
bWFwcGVyL3ZnX3Nhbi1sdl9kb21haW5zXS5mbHVzaF9pb19lcnJzICAgIDANClsvZGV2L21hcHBl
ci92Z19zYW4tbHZfZG9tYWluc10uY29ycnVwdGlvbl9lcnJzICAyMzEzNA0KWy9kZXYvbWFwcGVy
L3ZnX3Nhbi1sdl9kb21haW5zXS5nZW5lcmF0aW9uX2VycnMgIDANCg0KQmVybmQNCg0KSGVsbWhv
bHR6IFplbnRydW0gTcO8bmNoZW4g4oCTIERldXRzY2hlcyBGb3JzY2h1bmdzemVudHJ1bSBmw7xy
IEdlc3VuZGhlaXQgdW5kIFVtd2VsdCAoR21iSCkNCkluZ29sc3TDpGR0ZXIgTGFuZHN0cmHDn2Ug
MSwgRC04NTc2NCBOZXVoZXJiZXJnLCBodHRwczovL3d3dy5oZWxtaG9sdHotbXVuaWNoLmRlDQpH
ZXNjaMOkZnRzZsO8aHJ1bmc6IFByb2YuIERyLiBtZWQuIERyLiBoLmMuIE1hdHRoaWFzIFRzY2jD
tnAsIERhbmllbGEgU29tbWVyIChrb21tLikgfCBBdWZzaWNodHNyYXRzdm9yc2l0emVuZGU6IE1p
bkRpcuKAmWluIFByb2YuIERyLiBWZXJvbmlrYSB2b24gTWVzc2xpbmcNClJlZ2lzdGVyZ2VyaWNo
dDogQW10c2dlcmljaHQgTcO8bmNoZW4gSFJCIDY0NjYgfCBVU3QtSWROci4gREUgMTI5NTIxNjcx
DQo=
