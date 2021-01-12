Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9D2F30CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 14:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbhALNLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 08:11:50 -0500
Received: from mail-vi1eur05on2069.outbound.protection.outlook.com ([40.107.21.69]:25162
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730918AbhALNLs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 08:11:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZvvdJ5Pn8HZMAGqyKLHtuaO0plX6RKW3KKoYf+cTmHrfa9i0OGH46W1yWCrePicNnbyH25hnnlwIlJwEQPIIt9+tEH/C5K5nY+fc26//J+QWgAGjHA9FneJzbQFeyQBDSpQTz/QR+qPR1qR2I5KUET5xC/apFTsTknXJf7zheAfdRGAlBXGTctWrSF24zqpYVRGLetIyTADFeFxZcVKy5JCjDVIFn6MGChF1f7onyRpT3/uOUX6Q6bzVYujGfsXmepQGVXphWmZvqP9u9yY849+9MLaxtdJZ7tWeMdkLz9nRd2dhRso6o1CKA2gzmMklUwe0JHCaYUbr1d6UCGPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87+5r9LKrqH6RAigP7RN3YVfInvjKH4T/qVRhf/hvQ8=;
 b=mfHGEjBM+K/OuJOasFD5XBrjudDQH1OJ3/s2qzn09tlbPT0j5zKkPA3KjCFQETI9Xf3/xmO9dTyrzkxYlkk3PKnxLOHB340zKRTY+C0APUyUSKuWN4qKAnqgKnMMMDbNET0aPo8EL9wvkMqeF95d52ZFFMojy8LSpVipJgaNZ9HjsjtPU9sPeTKSUnJxhbCUVhfdnJ35KrQJLNKBadUkesOedVZfoxeMB6/lpUx9S+3x6oulRYOeTPxpsBXEk14aGNWvWtdMdm6r6mELZtkUjb9PObaJ5P+vpiWd/ZKgAXBsetlG50Vl3IrniDR5wU1pOP/Cid1sDC1pqri8Qe1e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87+5r9LKrqH6RAigP7RN3YVfInvjKH4T/qVRhf/hvQ8=;
 b=rZXBvQGoZFguEixfZ6BQboJovghtALKhqoenVIPWBnCvhkXBbfJp25a9kLlrm6JVIrSk0U2EA8cR/3a9SC/M7i+tyyE95zLWjrVfJrMGtB3AkqQH2f0p09x39cHWuaCjyMhlnu0MMcs5KNkfeNkb8b/wWSaMGJG2lo4NFEJxX3cnBFX1pI+0JbQ7hnBLN8tm/cmdJnMqaKpQCTJBruQdafQrV3XTGa63cNzq7xsJ3vFvV7i1/ReybdcVnd8RVHpKuR2TMy3tIMD7V+y0X+YjNd8aBBZK6YYqjvfri/S3ZzkEfSXHFPqf/jkuzCb2o6dMIjEIknpCD1BYAHErJ24kLg==
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DBBPR03MB6922.eurprd03.prod.outlook.com (2603:10a6:10:20e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Tue, 12 Jan
 2021 13:10:57 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%5]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 13:10:57 +0000
From:   Roman Anasal | BDSU <roman.anasal@bdsu.de>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
Thread-Topic: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
Thread-Index: AQHW6ExfcsLlXW2ATUu8CwlNGk82oqoiz9CAgAAXWgCAAPQkgIAAHQiA
Date:   Tue, 12 Jan 2021 13:10:57 +0000
Message-ID: <0ce2d415308ab40874aff535031e9871a442cd9a.camel@bdsu.de>
References: <20210111190243.4152-1-roman.anasal@bdsu.de>
         <20210111190243.4152-3-roman.anasal@bdsu.de>
         <9e177865-0408-c321-951e-ce0f3ff33389@gmail.com>
         <424d62853024d8b0bc5ca03206eeca35be6014a2.camel@bdsu.de>
         <CAL3q7H6YOPgcdgJKX8OETqrKqmfz8GRkQykPOQBMmnNSsc4sxw@mail.gmail.com>
In-Reply-To: <CAL3q7H6YOPgcdgJKX8OETqrKqmfz8GRkQykPOQBMmnNSsc4sxw@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bdsu.de;
x-originating-ip: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37378cfe-b81d-4164-9d8b-08d8b6fb7ff1
x-ms-traffictypediagnostic: DBBPR03MB6922:
x-microsoft-antispam-prvs: <DBBPR03MB6922844354BDAA28B92C8C2194AA0@DBBPR03MB6922.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ZKjFazbfdTu1Iu7IiBoIJawBBdoODQQi48MZKdqIVabwGK6GT7MEOeLDcIJ7ZbfL8osqAVMMoFeEr41CdPwzn0vdmxF4/0WEyF2X+u0itZwGuNlBuaoeGsaiUZkE1HMzCsMCNDlfqf49gMui5vMKKndu3MKR6DEqj5mh9D9vi+ubV0L+HxeUFMrwKtpFtf6ONndyWVHg9DBzyBScv6ZFhqWSrNVxHFkzd3PFHn8SgUvgg412o1TWYaM55Kp+unhyFsxxFcEamv984dAHqS67AFvvkQba4+MO8nmpM0xwFk10TQoV1hYA477h12apCTK37pU2MPbyM+SxJAXiyTGxswPXNYfA1lXyuRDtIyJ2nT/DJUFMjc814qfWfeSswWNfONCIQjn+LRVE2SDeUJHlEhy90j7k+6Zi7lEFXq1FE/BS0l2Lm3fB0Z8m0IOlRV4OwuJHO5xgAvFn0TSIaoySg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39830400003)(376002)(136003)(366004)(64756008)(66446008)(76116006)(8676002)(66476007)(6506007)(66556008)(86362001)(6486002)(186003)(91956017)(2906002)(66946007)(8936002)(83380400001)(5660300002)(316002)(786003)(6512007)(966005)(2616005)(71200400001)(478600001)(6916009)(4326008)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VHNkTFA2dlFqYXdWUVhBU3B4S1NtTFI0RzJGZDNQOTJRVURXOHk2STBFWldz?=
 =?utf-8?B?TGo3QjlxVnlOd25TbEl1RWNTeE1QWjFvaUd0TDhHSGdwdmRTVzh0RDVseC9q?=
 =?utf-8?B?RjVzc3hreHAxZE1TRGFwSm8yNjYrenlmNjJUSnMxVkI3MjJpM0JheGdaTUg4?=
 =?utf-8?B?REFZdUhzNzMwM1JuaUhvTERpcXl5akhSWWNiMk5tMDM1MHlsVW9jTHlUY3Vr?=
 =?utf-8?B?WlBnbDZ2Unh1UFpSSXdpQnQ2azcrMk1lMEJjd05GOXNKQW85VXRXOFNHakFE?=
 =?utf-8?B?UjlpTmR2U3lMY0ZNejdHYWlyclBPbHhzMWF6Z0hDV2VvSm5IZHd3L1V5Sm1z?=
 =?utf-8?B?VmN6b1NzRlZ1Rzkwa09BU214YzN5VXBxUjNjQnZab1M1UHFYMzlFdVVRUU81?=
 =?utf-8?B?OEh6OGtVUERFYkdnaWVOcWlTZklJd2V3TEtGSGR2TFptdzZ2TGZmWlZFaDhV?=
 =?utf-8?B?dURUaTRyTnVib0MwOWpzbkJKL1NnVHVmaDZxNGk2SkVIRWE4b1VzbFpJU2d6?=
 =?utf-8?B?bFVzdUVIRjZ5aEVEbytFNmh6Y1l3M2dXZStobHNMTU9paS9CajYzcFJHVW5D?=
 =?utf-8?B?cXJZZUJMOC9yeERrRzI1Tmx3NStDd2sxdnJEWWxvZWEwYXNXQjRxZFNFS3VV?=
 =?utf-8?B?M0pBR3FkWHlqMXdFUWVYbFkybDd3dHdUelU0RkxrbzBubytlUUhZWUhFbkI3?=
 =?utf-8?B?RUcweDBSZEhQMzRFOHkwUGFYNGJSWGM3N255eGg5dXRaU3c3WWtRTmI0Nm9D?=
 =?utf-8?B?eWFIYVJod1FvM3B6WHBOb1FmRkVlbVZnN2lvSHBpbUNYOVgzeHNMTUZ5Wlc4?=
 =?utf-8?B?djNrclg1cEM3cm15ZVdQZC9OR0orVFJ1NVRzbWpoaVQydkNteEMrMVlvYjVR?=
 =?utf-8?B?dGN4a1NUdGdFdEZNN2dzWElsU1lOKzVLS0pCTFNmUVhBbkxKamJHN2tDRzVo?=
 =?utf-8?B?YUxwemdSQXRkbmRXVTgzcmZVUFYvck9SWlhlV3Y4a0wzdVplSDBtV3hzL3VJ?=
 =?utf-8?B?d1RtdVlmS3gxUkpDK05OVXpXb2ZlRHAyODFpbjF5Qjd0OVVzekhGaXZRWnha?=
 =?utf-8?B?Vzl5bUNaaWNOWHE0aFgyQ2pGNDUvci9xY3ZVK0Uyb2lZNnJ0WllNL1FleXor?=
 =?utf-8?B?enc2VU9DVWFyUjJBdTNtdnNQY0RLanRFenREZTVhZGptS0xocDRMT3R5RDZP?=
 =?utf-8?B?ZnhZcW1DM3o0SndzNS9IYWlHOHJmYnJxTGNVK2NBdkd4cGd6TDN0T2NkTXJZ?=
 =?utf-8?B?V3FHSSs4N1hjZlpPSGdsSGZVS2VVdlJtWWMxTU53RFBwZys5aXJSS2F5OWh3?=
 =?utf-8?B?VXh0TzlhYjRBMGg2dGNJVlBSdU91NHZZVW5SUlJRZVpjODJpWHV2Z0hwTDNy?=
 =?utf-8?B?VjJDbmlZbzNrSnFEcC9FVHlXYnZaMHVYa29ZbVRPUEI2UjMwM0I2Y00xMTN6?=
 =?utf-8?Q?zngtOwXH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ECCF4C8677FAA40A96469A2622C25FF@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37378cfe-b81d-4164-9d8b-08d8b6fb7ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 13:10:57.1623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyToRbTwGvpIJclMIKtHGIlif9CyuJ9ff+wM/ZYpeo9av/E3fIOoTLS3aZrZjvF0io8a57aA1tIB//x6Khysdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6922
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTEyIGF0IDExOjI3ICswMDAwLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0K
PiBZb3UgZ2V0IGFsbCB0aGVzZSBpc3N1ZXMgYmVjYXVzZSB5b3UgYXJlIHVzaW5nIGFuIGluY3Jl
bWVudGFsIHNlbmQgaW4NCj4gYSB3YXkgaXQncyBub3Qgc3VwcG9zZWQgdG8uDQo+IFlvdSBhcmUg
dXNpbmcgdHdvIHN1YnZvbHVtZXMgdGhhdCBhcmUgY29tcGxldGVseSB1bnJlbGF0ZWQuDQpZZXMs
IEkgYW0gYXdhcmUgb2YgdGhhdCBhbmQga25vdyB0aGF0IHRoaXMgaXMgbm90IGEgZGVzaWduZWQg
Zm9yIHVzZQ0KY2FzZS4NCg0KPiBNeSBzdXJwcmlzZSBoZXJlIGlzIHRoYXQgd2UgYWN0dWFsbHkg
YWxsb3cgYSB1c2VyIHRvIHRyeSB0aGF0LA0KPiBpbnN0ZWFkDQo+IG9mIGdpdmluZyBhbiBlcnJv
ciBjb21wbGFpbmluZyB0aGF0IHN1YnZvbDEgYW5kIHN1YnZvbDIgYXJlbid0DQo+IHNuYXBzaG90
cyBvZiB0aGUgc2FtZSBzdWJ2b2x1bWUuDQpUaGlzIGNvdWxkIGJlIG9uZSB3YXkgb2Ygc29sdmlu
ZyBpdC4gQnV0IHRoaXMgaXMgYWxyZWFkeSBoYXJkZXIgdGhhbiBpdA0Kc291bmRzLCBzaW5jZSB0
aGUgc2FtZSBpc3N1ZSBtYXkgYWxzbyBoYXBwZW4gKmV2ZW4gd2hlbiogdGhlIHN1YnZvbHVtZXMN
CnNoYXJlIGEgcGFyZW50L2FyZSByZWxhdGVkLCBoZXJlIGFuIGV4YW1wbGUgcmVwcm9kdWNlcjoN
Cg0KICBidHJmcyBzdWJ2b2x1bWUgY3JlYXRlIHN1YnZvbDENCiAgYnRyZnMgc3Vidm9sdW1lIHNu
YXBzaG90IHN1YnZvbDEgc3Vidm9sMg0KICBta2RpciBzdWJ2b2wxL2ENCiAgZWNobyBmb28gPiBz
dWJ2b2wyL2ENCiAgYnRyZnMgcHJvcGVydHkgc2V0IHN1YnZvbDEgcm8gdHJ1ZQ0KICBidHJmcyBw
cm9wZXJ0eSBzZXQgc3Vidm9sMiBybyB0cnVlDQogIGJ0cmZzIHNlbmQgLXAgc3Vidm9sMSBzdWJ2
b2wyIHwgYnRyZnMgcmVjZWl2ZSAtLWR1bXANCg0KVGhpcyB3aWxsIHByb2R1Y2UgYSBzdHJlYW0g
dGhhdCB0cmllcyB0byB3cml0ZSBkYXRhIGludG8gdGhlIGNsb25lZA0KZGlyZWN0b3J5IGlub2Rl
Lg0KDQpTbyB3ZSBub3Qgb25seSBoYWQgdG8gY2hlY2sgdGhlIHBhcmVudCByZWxhdGlvbnNoaXBz
IGJ1dCBhbHNvIGVuc3VyZQ0KdGhhdCB0aGUgZGVzY2VuZGFudCBzbmFwc2hvdCB3YXMgbm90IG1v
ZGlmaWVkLCBpLmUuIHdhcyBuZXZlciBzZXQgdG8NCnJvPWZhbHNlLg0KQXMgZmFyIGFzIEkga25v
dyB0aGVyZSBpcyBubyBmbGFnIHRyYWNraW5nIHRoaXMgb24tZGlzaz8gU28gdGhpcyB3b3VsZA0K
bmVlZCBhZGRpdGlvbmFsIHdvcmssIHRvby4NCg0KDQo+IEFuIGluY3JlbWVudGFsIGlzIHN1cHBv
c2VkIHRvIHdvcmsgb24gc25hcHNob3RzIG9mIHRoZSBzYW1lIHN1YnZvbHVtZQ0KPiAoaGVuY2Us
IGhhdmUgdGhlIHNhbWUgcGFyZW50IHV1aWQpLg0KPiBUaGF0J3Mgd2hhdCB0aGUgZW50aXJlIGNv
ZGUgcmVsaWVzIG9uIHRvIHdvcmsgY29ycmVjdGx5LCBhbmQgdGhhdCdzDQo+IHdoYXQgbWFrZXMg
c2Vuc2UgLSB0byBjb21wdXRlIGFuZCBzZW5kIHRoZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHR3bw0K
PiBwb2ludHMgaW4gdGltZSBvZiBhIHN1YnZvbHVtZS4NCj4gVGhhdCdzIHdoeSB0aGUgY29kZSBi
YXNlIGFzc3VtZXMgdGhhdCBpbm9kZXMgd2l0aCB0aGUgc2FtZSBudW1iZXIgYW5kDQo+IHNhbWUg
Z2VuZXJhdGlvbiBtdXN0IHJlZmVyIHRvIHRoZSBzYW1lIGlub2RlIGluIGJvdGggdGhlIHBhcmVu
dCBhbmQNCj4gdGhlIHNlbmQgcm9vdC4NCj4gDQo+IFdoYXQgSSB0aGluayB0aGF0IG5lZWRzIHRv
IGJlIGFuc3dlcmVkIGlzOg0KPiANCj4gMSkgQXJlIHRoZXJlIGFjdHVhbGx5IHBlb3BsZSB1c2lu
ZyBpbmNyZW1lbnRhbCBzZW5kcyBpbiB0aGF0IHdheT8NCj4gKEl0J3MgdGhlIGZpcnN0IHRpbWUg
SSBzZWUgc3VjaCB1c2UgY2FzZSkNCldlbGwsIEkgZGlkICg6DQpCdXQgYWRtaXR0ZWRseSBpbiBh
IGtpbmQgb2YgZXhwZXJpbWVudGFsIHNldHVwIHRlc3Rpbmcgb3V0IHRoZSBsaW1pdHMNCm9mIGJ0
cmZzLg0KDQo+IDIpIElmIHNvLCB3aHk/IFRoYXQgaXMgY29tcGxldGVseSB1bnJlbGlhYmxlLCBu
b3Qgb25seSBpdCBjYW4gbGVhZCB0bw0KPiBmYWlsdXJlIHRvIGFwcGx5IHRoZSBzdHJlYW1zLCBi
dXQgY2FuIHJlc3VsdCBpbiBhbGwgc29ydHMgb2YNCj4gd2VpcmRuZXNzDQo+IChsb2dpY2FsIGlu
Y29uc2lzdGVuY2llcywgZXRjKSBpZiBhcHBseWluZyBzdWNoIHN0cmVhbXMgZG9lc24ndCBjYXVz
ZQ0KPiBhbiBlcnJvci4NCkluIG15IGNhc2UgSSB3YXMgbW92aW5nIGFyb3VuZCBzdWJ2b2x1bWVz
IGJldHdlZW4gbXVsdGlwbGUgZGlza3MgYW5kDQpkZWR1cGxpY2F0aW5nIGFzIG11Y2ggYXMgcG9z
c2libGUuIFRyeWluZyB0byBwcmVzZXJ2ZSBhbHJlYWR5IGRvbmUNCmRlZHVwbGljYXRpb24gYW5k
IHB1cmdpbmcgc29tZSBpbnRlcm1lZGlhdGUgc3Vidm9sdW1lcyBJIGVuZGVkIHVwIHVzaW5nDQoi
dW5yZWxhdGVkIiBzdWJ2b2x1bWVzIGFzIHBhcmVudHMuDQoNClRoaW5raW5nIG9mIGl0LCBtYXli
ZSBqdXN0IHVzaW5nIHRoZW0gYXMgY2xvbmUgc291cmNlcyB3b3VsZCBoYXZlIGp1c3QNCndvcmtl
ZD8gVGhhdCB3b3VsZCB0aGVuIG9mIGNvdXJzZSBwcm9kdWNlIG11Y2ggbGFyZ2VyIHN0cmVhbXMg
c2luY2UNCiphbGwqIG1ldGEgZGF0YSBoYWQgdG8gYmUgdHJhbnNmZXJlZC4NCg0KDQo+IDMpIE1h
a2luZyBzdXJlIHN1Y2ggdXNlIGNhc2VzIHdvcmsgcmVsaWFibHkgd291bGQgcmVxdWlyZSBtYW55
LCBtYW55DQo+IGNoYW5nZXMgdG8gdGhlIHNlbmQgaW1wbGVtZW50YXRpb24sIGFzIGl0IGdvZXMg
YWdhaW5zdCB3aGF0IGl0DQo+IGN1cnJlbnRseSBleHBlY3RzLg0KPiAgICAgU25hcHNob3QgYSBz
dWJ2b2x1bWUsIGNoYW5nZSB0aGUgc3Vidm9sdW1lLCBzbmFwc2hvdCBpdCBhZ2FpbiwNCj4gdGhl
biB1c2UgYm90aCBzbmFwc2hvdHMgZm9yIHRoZSBpbmNyZW1lbnRhbCBzZW5kLCB0aGF0J3MgdGhl
IGV4cGVjdGVkDQo+IHNjZW5hcmlvLg0KSSBhY3R1YWxseSBkb24ndCB0aGluayB0aGF0IGl0IGlz
IHJlYWxseSB0aGF0IG11Y2ggd29yayBzaW5jZSBiZXNpZGVzDQpmcm9tIHNvbWUgZWRnZSBjYXNl
cyBpdCBhbHJlYWR5ICpkb2VzKiB3b3JrIC0gSSB0cmllZCA7KQ0KDQoNCj4gSW4gb3RoZXIgd29y
ZHMsIHdoYXQgSSB0aGluayB3ZSBzaG91bGQgaGF2ZSBpcyBhIGNoZWNrIHRoYXQgZm9yYmlkcw0K
PiB1c2luZyB0d28gcm9vdHMgZm9yIGFuIGluY3JlbWVudGFsIHNlbmQgdGhhdCBhcmUgbm90IHNu
YXBzaG90cyBvZiB0aGUNCj4gc2FtZSBzdWJ2b2x1bWUgKGhhdmUgZGlmZmVyZW50IHBhcmVudCB1
dWlkcykuDQpJJ2QgbGlrZSB0byBhcmd1ZSBhZ2FpbnN0IHRoYXQ6DQogICAxLiBJIGRvbid0IHRo
aW5rIGFsbG93aW5nIHRoaXMgcmVxdWlyZXMgdGhhdCBtdWNoIHdvcmsNCiAgIDIuIGV4cGxpY2l0
bHkgZm9yYmlkaW5nIGl0IHJlcXVpcmVzIHdvcmssIHRvbyAoYW5kIG1heWJlIGV2ZW4gY2hhbmdl
cw0KICAgICAgdG8gdGhlIG9uLWRpc2sgZm9ybWF0PykNCiAgIDMuIGZpeGluZyBidWdzIGZvciB0
aGlzIHVuZXhwZWN0ZWQgdXNlIGNhc2Ugd2lsbCBwcm9iYWJseSBhbHNvIGZpeCBidWdzDQogICAg
ICBmb3IgdGhlIGV4cGVjdGVkIHNjZW5hcmlvIHdoaWNoIG1heSBvbmx5IGhhcHBlbiBpbiB2ZXJ5
IHJhcmUgYW5kDQogICAgICBleHRyZW1seSB1bmxpa2VseSAtIHRob3VnaCBzdGlsbCBwb3NzaWJs
ZSAtIGNhc2VzIGFuZCB0aHVzIG1ha2UgdGhlDQogICAgICBjb2RlIG92ZXJhbGwgbW9yZSByZXNp
bGllbnQ6DQoNCkZvciBleGFtcGxlIHRoZSBhc3N1bXB0aW9uIHRoYXQgaW5vZGVzIHdpdGggdGhl
IHNhbWUgbnVtYmVyIG11c3QgcmVmZXINCnRvIHRoZSBzYW1lIGlub2RlIGRvZXNuJ3QgZXZlbiBo
b2xkIGZvciBkaXJlY3Qgc25hcHNob3RzIC0gYWxtb3N0DQphbHdheXMgaXQgZG9lcyBidXQgaW4g
c29tZSByYXJlIGNvbmRpdGlvbnMgaXQgZG9lc24ndCwgd2hpY2ggaXMgd2h5DQp0aGVyZSBhbHJl
YWR5IGlzIGFuIGFkZGl0aW9uYWwgY2hlY2sgZm9yIHRoYXQuDQoNClRoaXMgYWxyZWFkeSBjYXVz
ZWQgYnVncyBiZWZvcmUuIEFuZCB0aGUgYnVnIEkgaGl0IHdpdGggbXkgdW5leHBlY3RlZA0KdXNl
IG9mIGJ0cmZzLXNlbmQgYW5kIG9yaWdpbmFsbHkgc2V0IG91dCB0byBmaW5kIHlvdSBoYWQganVz
dCBmaXhlZCBhDQpmZXcgd2Vla3MgYmVmb3JlIFsxXSwgaS5lLiBpZiB5b3UgaGFkbid0IGZpeGVk
IGl0IEkgd291bGQgLSBiZWNhdXNlIG9mDQp0aGUgdW5leHBlY3RlZCB1c2UuDQpUaGUgYnVnIG15
IHBhdGNoIGZpeGVzIEkgb25seSBkaXNjb3ZlcmVkIGJ5IHJlYWRpbmcgdGhlIGNvZGUgYW5kIGhh
dmluZw0KbXkgc2NlbmFyaW8gaW4gbWluZC4NCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2tkYXZlL2xpbnV4LmdpdC9jb21taXQvP2lkPTBiM2Y0
MDdlNjcyOGQ5OTBhZTE2MzBhMDJjN2I5NTJjMjFjMjg4ZDMNCg0KVGhhdCdzIHdoeSBJIHRoaW5r
IHRoZSB3b3JrIGZpeGluZyBhcmlzaW5nIGJ1Z3MgZm9yIHRoYXQgY2FzZSBpcyBiZXR0ZXINCmlu
dmVzdGVkIHRoYW4gaW4gdHJ5aW5nIHRvIGp1c3QgYmxvY2sgaXQgY29tcGxldGVseS4NCkJ1dCBn
aXZlbiBpdHMgdmVyeSByYXJlIG9jY3VyZW5jZSBJIHdvdWxkIGFncmVlIHRvIG5vdCBwdXQgYW55
IHByaW9yaXR5DQpvbiBpdC4NCg0KPiBUaGFua3MuDQo+IA0K
