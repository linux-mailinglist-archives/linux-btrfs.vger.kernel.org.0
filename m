Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95306309DC1
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Jan 2021 16:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhAaPxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Jan 2021 10:53:22 -0500
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:28675
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229677AbhAaPxV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Jan 2021 10:53:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h05wZJAg7POVMoCeTMFwAUrYVzQh9crXRzrU9QUaQ8gZjTx+tDmO2QapWf2XMNHj8QoUtK9k/Zc/+8v2IhPxPAlATWuxM0IoazU0X6fyarU+QT9crXfrPYIGq1/7IzW7unyXW1G+j31zpcPM0CHL2vfyrDPJ84+o7TOyrjQOJQCg13WOYPNNzjX/Ms347wlyL1e1TrBRabzF0sKVxtTPJyVqXTqDSABLKcnkEK4acl9z/mbLPEOXbFu0kYvAI0CCN+xPlUvCtGJ2GAINO8SWk4CbmmVPl7b6eP/Upq+TrRWy5FePuQ8umW1FsnATs7xiBf398mmNHrUTK549HHAOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BWG0k+HZQYTieMuds4g8H9oq51I7DCuk26Q2pKEAyY=;
 b=E9LQ3O7e3rQdmS/ePOuQ16xrSIJb2nagyKloh54AIwM/KOVNCxMLFROv8lmBnyMn0tf57adgAHJjCiU/cUmZCb6JeOmHYo6ywxp555FefNqoqQTAQr08LKX/ekVzlpeIolZVdrfmChU7hom6aRAw3V6Rz0muXbRN83sCUg3yO8Wtfq2mO6HIfp0FxddCkgtl20tsDt8xlCjktv8aZY4lo0VKuaxrl45emVIgXtNXg990m8+ppfNcaUrVsLlqgiJNqD97RnKxSXYp7X4m8SsA64aAucP+FCGjqoc0tyMuIdd4RzfQSi3nSrnwAWzdyEoHHl0zYP5+tPHdBjTNk4kyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BWG0k+HZQYTieMuds4g8H9oq51I7DCuk26Q2pKEAyY=;
 b=Ee588nbbtQxJkTH8d2mOc/Yo8WypwXhYI0bbOgmnPuJdZJ0sS3DuFKkT5R7UiceCNAIxXkn2OgOB+NPhMoFHaRKoFTKv2RGCxCy6h2+loPpLUCl5zxsJaRB6mnWU+WPMqle7VVjsTn50GQCBw7ed3oHTd5/AL955SfK++f+SeoTDbO0kwaSh4mWsmun1IkdpND1pQmNBc9fPgLBoDd4DuSBiTkkMdhwy4AuHD6/wckISOCoKFVz3aEy5M91WlKDJlead19Gub0ry776mt8vvoqFMmnqnlcu6BK4DudFKMPzgLFzuolfBoZy1Zgq76g8UHX2jvUkv/yhqslCRY3o0sw==
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DBAPR03MB6646.eurprd03.prod.outlook.com (2603:10a6:10:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Sun, 31 Jan
 2021 15:52:30 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%6]) with mapi id 15.20.3784.022; Sun, 31 Jan 2021
 15:52:30 +0000
From:   Roman Anasal | BDSU <roman.anasal@bdsu.de>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] btrfs: send: fix invalid commands for inodes with
 changed rdev but same gen
Thread-Topic: [PATCH v2 3/4] btrfs: send: fix invalid commands for inodes with
 changed rdev but same gen
Thread-Index: AQHW81IrvLwzLkUvVEijvyczpX1sgqo40RyAgAkargA=
Date:   Sun, 31 Jan 2021 15:52:30 +0000
Message-ID: <aa2cf62fc268c9db63d47ef408accca79bc7b22f.camel@bdsu.de>
References: <20210125194210.24071-1-roman.anasal@bdsu.de>
         <20210125194210.24071-4-roman.anasal@bdsu.de>
         <CAL3q7H79meSfikTKvTujQzA_SRb3bfF9ajYtWSVTfu0+pLE8wQ@mail.gmail.com>
In-Reply-To: <CAL3q7H79meSfikTKvTujQzA_SRb3bfF9ajYtWSVTfu0+pLE8wQ@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bdsu.de;
x-originating-ip: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6b9250f-c13c-443f-1d94-08d8c6003765
x-ms-traffictypediagnostic: DBAPR03MB6646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR03MB6646E0DF99BFAF273408332E94B79@DBAPR03MB6646.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OuWrpS7OlWHrmobg0NLtdYRTIwCUFyXAdv2f89Xqa92wKv/67aGQXOpON7k+lRcKJiM4FWV2beGOodauQtTxxkMioYntDCgfAWqbL6Gbr6rdyK7Ku87fJk1yEVR/yTtagQP3zrD2DSkcVDpvqv/nSMJjJknOtB33tqKljJP4LEyfplZBm2UVic0QO/mkT6miBUX4bwI3Eu6GSaOLWaq0PAICYWNqmRgE/4XvaE7dVczlCkRFWKRWDu8ZamjyZUecoNYNZrFkX9Qr6sfHR77Xvr2xvxu1WcOgiF4/0Nqk7oegDhRvMqGzAgdHj8ds4zKQ8lnU9lg/B5wiSeX+F21gbJbhoSczZX+Zf4yGzKuVJhZ/1t+CWUubAfVMiCdqWVuxjkF6o23hZnVCRsqpQUjsmUror7EZPf+vNh4O47L50bxMtzjhVscNufqVR0zF2wOfyVzfjuQeHeJPejM+ZlU5NYC5ikc1WfCmq2JVb8gZ5ZTNQOHQytGEAm0fVoHsnxsQEuE/Im/Umlfoe0XCeQYALA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(5660300002)(2616005)(6916009)(91956017)(83380400001)(53546011)(186003)(71200400001)(76116006)(8936002)(66446008)(66556008)(66476007)(64756008)(66946007)(6486002)(6506007)(8676002)(2906002)(4326008)(36756003)(86362001)(508600001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TFgzT1hXVmlkQU5raE45cWlUS1dVWmR3YXFDdS9QL053U3ZtQTVDbi9VMDEy?=
 =?utf-8?B?NGFWaGV1ZXZFK1ZpUzk1SFM1NzRYM2grY1hvakhGeFA1MVJUMk9FcmtyNmRl?=
 =?utf-8?B?SjJLYnc4RHFPZDBvbitVWDZnTUtsNUE1dGNRTVMydEdaZ1JsVDA1ZEVDenAz?=
 =?utf-8?B?Ui9xV1gvQ3B3QU9Sd1RJUGM1V2JsYTVQTUJSY01EMGdBMlhsdTVJU1NVNHRj?=
 =?utf-8?B?ZFNEWUV4T3BMM3FNdEE0eHQvK3RuMkt6akhLZkF1V2tiMTVjTExXdmRWRFl2?=
 =?utf-8?B?TnpxQnZRZ0xoVXRZSHltL3h6VmVZUEh6UFJKVHFlYlBhZVJ5MzAzdzh4anl6?=
 =?utf-8?B?RWdieExwRmJWcHh4eFhEQlJhUlBEamNNbFpmVmNJQ0gxZ3F6bWhXV2Q0VFZ5?=
 =?utf-8?B?TER1S3hzWUVKd2w3Qktac0QzNXgvK25HWXBMSnRtRVpEbnZVLytiQVB4Nkxx?=
 =?utf-8?B?RkFWU2dwVHFJTkc4NExFSFY1ak1uTkZiSytKL3RJUDlMZHl5WW10Yk5QNWNk?=
 =?utf-8?B?UnRpM0xJQmxCUU4xT3k1bHFlZjNSbkV5ZHBxT2YwZDB6QWRsWWFNZlltLzlJ?=
 =?utf-8?B?VnNOV1hpUHIxbnd3QURkbHYxZ1I5ZkZvdE0zc1lYdXRza1dxSjEveEEwZ1k3?=
 =?utf-8?B?bVBwdDYwUHBPTjhFVG9rMWVCSy80dTNadStUbmNtSVIyaEZBZEFLdVZidW1h?=
 =?utf-8?B?L0YyODM4VE9GQ3Q4SGQrTHNvUG8yOEJtbDU4Y3NwcEYrQUkxcTZWRko0ajRq?=
 =?utf-8?B?djEwdDBhQnFwNDhpQS91Wk9qdkNmT3hNbE5MY2pEbjJLaUIvclU4VE9Vby9i?=
 =?utf-8?B?bmMzcFJ0RDA4cjZuRVh1WG1OL1lNaHNlZ0szbUY2bU1Hc0drNnEvclBLSjI3?=
 =?utf-8?B?TjhRalJsMGtVZVFOdWpmTGdLMDFiRVZMbGs0Vmo2Yk03bU83Wjhya2kxekdo?=
 =?utf-8?B?bG5DSGg3YVF5SGg4UWtjRzVwL2RrUjcwbmFONnpxY0ZWMGtMUDNtaEZSMWQ0?=
 =?utf-8?B?cWo1UkNoYnZxNkNFRzZHRWJZQ3A3SytnNkErektqUVF2UnBCTmZZOW9neVkx?=
 =?utf-8?B?TjJYWG9aN0h1MDlSaG9ocWVTT1FsaklwZW8rZGZDaFo5aWhrOEtHQXp6d0lW?=
 =?utf-8?B?cExTSXdCaHM0Nk0yTVY1ZXBodVNWVXF4Y1FzcDUydkN0ZVEyeHg1T3Rvb2lW?=
 =?utf-8?B?VXFSbVNGYlRWY0s2NzZOWUxtU1BFOVE1TFdaRlhadDV3Mld3eVhsYlhwVTh6?=
 =?utf-8?B?TVFSRndhRkg5K0lNTUc5OGxleDZZM2dUWVBpNXZUSXcxVzk0cTMvZjV0aEJN?=
 =?utf-8?B?anhQek9tRG1SWkk1clF5TmJoejVtT2xWWlBGTGhMaGN3S2huTGZnUUlzQklh?=
 =?utf-8?B?TElsQWJxS252NWFMMURObmhHMVllOUtIZlNBR1ZidlgyZ0ZiUVFSNkI4SW5S?=
 =?utf-8?B?U01hdE5LRUtMa2cvbm5DUEl5RWpRS1ZlZk53Ny9Kb1N3cEt3YSt6Q1F1N3FI?=
 =?utf-8?Q?FXaavOYmrUvublaCGY7ZmnLE/KG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2AD42540739CA4B8C5B0948AFEE201B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b9250f-c13c-443f-1d94-08d8c6003765
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 15:52:30.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: is61B3yFd2l4jfpHPNCPtnpPG0tcBCSlQV0MfDwsuZWVRqmsq5kQeVcwHbHpkgbDQbixSTi7bwz3WX3EBgumlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6646
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gTW9uLCBKYW4gMjUsIDIwMjEgYXQgMjA6NTEgKzAwMDAgRmlsaXBlIE1hbmFuYSB3cm90ZToN
Cj4gT24gTW9uLCBKYW4gMjUsIDIwMjEgYXQgNzo1MSBQTSBSb21hbiBBbmFzYWwgPHJvbWFuLmFu
YXNhbEBiZHN1LmRlPg0KPiB3cm90ZToNCj4gPiBTZWNvbmQgZXhhbXBsZToNCj4gPiAgICMgY2Fz
ZSAyOiBzYW1lIGlubyBhdCBkaWZmZXJlbnQgcGF0aA0KPiA+ICAgYnRyZnMgc3Vidm9sdW1lIGNy
ZWF0ZSBzdWJ2b2wxDQo+ID4gICBidHJmcyBzdWJ2b2x1bWUgY3JlYXRlIHN1YnZvbDINCj4gPiAg
IG1rbm9kIHN1YnZvbDEvYSBjIDEgMw0KPiA+ICAgbWtub2Qgc3Vidm9sMi9iIGMgMSA1DQo+ID4g
ICBidHJmcyBwcm9wZXJ0eSBzZXQgc3Vidm9sMSBybyB0cnVlDQo+ID4gICBidHJmcyBwcm9wZXJ0
eSBzZXQgc3Vidm9sMiBybyB0cnVlDQo+ID4gICBidHJmcyBzZW5kIC1wIHN1YnZvbDEgc3Vidm9s
MiB8IGJ0cmZzIHJlY2VpdmUgLS1kdW1wDQo+IA0KPiBBcyBJJ3ZlIHRvbGQgeW91IGJlZm9yZSBm
b3IgdGhlIHYxIHBhdGNoc2V0IGZyb20gYSB3ZWVrIG9yIHR3byBhZ28sDQo+IHRoaXMgaXMgbm90
IGEgc3VwcG9ydGVkIHNjZW5hcmlvIGZvciBpbmNyZW1lbnRhbCBzZW5kcy4NCj4gSW5jcmVtZW50
YWwgc2VuZHMgYXJlIG1lYW50IHRvIGJlIHVzZWQgb24gUk8gc25hcHNob3RzIG9mIHRoZSBzYW1l
DQo+IHN1YnZvbHVtZSwgYW5kIHRob3NlIHNuYXBzaG90cyBtdXN0IG5ldmVyIGJlIGNoYW5nZWQg
YWZ0ZXIgdGhleSB3ZXJlDQo+IGNyZWF0ZWQuDQo+IA0KPiBJbmNyZW1lbnRhbCBzZW5kcyB3ZXJl
IHNpbXBseSBub3QgZGVzaWduZWQgZm9yIHRoZXNlIGNhc2VzLCBhbmQgY2FuDQo+IG5ldmVyIGJl
IGd1YXJhbnRlZWQgdG8gd29yayB3aXRoIHN1Y2ggY2FzZXMuDQo+IA0KPiBUaGUgYnVnIGlzIG5v
dCBoYXZpbmcgaW5jcmVtZW50YWwgc2VuZHMgZmFpbCByaWdodCBhd2F5LCB3aXRoIGFuDQo+IGV4
cGxpY2l0IGVycm9yIG1lc3NhZ2UsIHdoZW4gdGhlIHNlbmQgYW5kIHBhcmVudCByb290cyBhcmVu
J3QgUk8NCj4gc25hcHNob3RzIG9mIHRoZSBzYW1lIHN1YnZvbHVtZS4NCg0KU2luY2UgdGhpcyBz
aG91bGQgYmUgZml4ZWQgdGhlbiBJJ2QgbGlrZSB0byBwcm9wb3NlIHRvIGFkZCB0aGUNCmZvbGxv
d2luZyBjaGVjazoNCg0KVGhlIGlub2RlcyBvZiB0aGUgc3Vidm9sdW1lcycgcm9vdCBkaXJlY3Rv
cmllcyAoaW5vDQpCVFJGU19GSVJTVF9GUkVFX09CSkVDVElEID0gMjU2KSBtdXN0IGhhdmUgdGhl
IHNhbWUgZ2VuZXJhdGlvbi4NCg0KU2luY2UgY3JlYXRlX3N1YnZvbCgpIHdpbGwgYWx3YXlzIGNv
bW1pdCB0aGUgdHJhbnNhY3Rpb24sIGkuZS4NCmluY3JlbWVudCB0aGUgZ2VuZXJhdGlvbiwgbm8g
dHdvIF9pbmRlcGVuZGVudGx5XyBjcmVhdGVkIHN1YnZvbHVtZXMgY2FuDQpiZSBjcmVhdGVkIHdp
dGhpbiB0aGUgc2FtZSBnZW5lcmF0aW9uIChhcmUgdGhlcmUgcmFjZSBjb25kaXRpb25zDQpwb3Nz
aWJsZSBoZXJlPykuDQpUYWtpbmcgYSBzbmFwc2hvdCBvZiBhIHN1YnZvbHVtZSBkb2VzIG5vdCBt
b2RpZnkgdGhlIGdlbmVyYXRpb24gb2YgdGhlDQpyb290IGRpciBpbm9kZS4gQWxzbyBpdCBpcyBu
b3QgcG9zc2libGUgdG8gY2hhbmdlIG9yIGRlbGV0ZS9yZS1jcmVhdGUNCnRoZSByb290IGRpcmVj
dG9yeSBvZiBhIHN1YnZvbHVtZSBzaW5jZSB0aGlzIHdvdWxkIGRlbGV0ZSB0aGUgc3Vidm9sdW1l
DQppdHNlbGYuDQoNCg0KU28gaGF2aW5nIHR3byBzdWJ2b2x1bWVzIHdpdGggcm9vdCBkaXJlY3Rv
cmllcyBjcmVhdGVkIHdpdGggZGlmZmVyZW50DQpnZW5lcmF0aW9ucyBtZWFucyB0aGV5IHdlcmUg
Y3JlYXRlZCBpbmRlcGVuZGVudGx5IGFuZCBjYW4gbm90IHNoYXJlIGENCmNvbW1vbiBhbmNlc3Rv
ci4gRG9pbmcgYW4gaW5jcmVtZW50YWwgc2VuZCB3aXRoIHRoZW0gaXMgdW5zYWZlIGFuZCB0aHVz
DQptdXN0IHJldHVybiBhbiBlcnJvci4NCldpdGggdGhlIHJvb3QgZGlyZWN0b3JpZXMgYXQgdGhl
IHNhbWUgZ2VuZXJhdGlvbiB0aG91Z2ggdGhlIHN1YnZvbHVtZXMNCmFyZSBiYXNlZCBvbiBhIGNv
bW1vbiBhbmNlc3RvciB3aGljaCBpcyBhIHJlcXVpcmVtZW50IGZvciBhIHNhZmUNCmluY3JlbWVu
dGFsIHNlbmQuDQoNCkFyZSBteSBhc3N1bXB0aW9ucyBhbmQgbXkgdW5kZXJzdGFuZGluZyBoZXJl
IGNvcnJlY3Q/IFRoZW4gdGhpcyBjaGVjaw0Kd291bGQgY2F0Y2ggbW9zdCBvZiB0aGUgdW5zYWZl
IHBhcmVudHMuDQpJZiBzbyBJIGNvdWxkIGhhdmUgYSBzaG90IGF0IGEgcGF0Y2ggZm9yIHRoaXMg
aWYgeW91J2QgbGlrZSBtZSB0bz8NCg0KDQpUaGlzIGNoZWNrIHN0aWxsIGRvZXMgbm90IHNvbHZl
IHRoZSBzZWNvbmQgZWRnZSBjYXNlIHRob3VnaCwgd2hlbg0Kc25hcHNob3RzIGFyZSBtb2RpZmll
ZCBhZnRlcndhcmRzIGFuZCBkaXZlcmdlIGluZGVwZW5kZW50bHkgZm9ybSBvbmUNCmFub3RoZXIu
IEZvciB0aGlzIEkgc3RpbGwgc2VlIG5vIGdvb2Qgc29sdXRpb24gYmVzaWRlcyBhIG5ldyBvbi1k
aXNrDQpmbGFnIHdoZXRoZXIgYSBzbmFwc2hvdCB3YXMgKmV2ZXIqIHNldCB0byBybz1mYWxzZS4g
QnV0IHdpdGggdGhhdCBJJ20NCm5vdCBzdXJlIGhvdyB0byAobm90KSBpbmhlcml0IHRoYXQgZmxh
ZyBpbiBhIHNhZmUgd2F5IC4uLg0K
