Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63472F21D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 22:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbhAKVcW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 16:32:22 -0500
Received: from mail-vi1eur05on2062.outbound.protection.outlook.com ([40.107.21.62]:30433
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727984AbhAKVcV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 16:32:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCtT95SAozKNxSrHaIySGaTl1e10tbl6kQ4tleupIMKUXH+ezoC1wHbBoxmk3oCJBuitPD/6eDR1FvQCnCtWe9G/i9a2hMiBzJRGL3j4R2uR8ZHEGsOd6blix5hGMXXQsctRpJ3ZqpBqA1C0XKXlPjzAjkIIUAUnoNdUng0ZaFGjorHaeXEUdkftWHJrYoVG053QNeoEeiIl6L47cHQO5ThDlQ/q8eL/dh8IU/WHOGiN++Kc842CCkp0ArTSjVeQIBZ2GACUj0BHuPGWtgwB/JMOt5+R3WjFkbD0nRBhzQLl5xk4Jm1sDOoOzf+2MFMKrr0Xieg/t26YYPViXPQUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn+Esj+fVPKS034yM3jx6Fzmrd6OCcsltAWM2cZ9Djo=;
 b=B677dYXHhhrzqSjprhkHaR9k2oiiPWYF87/x3s+Nnv+BrPE55Mu1KBycVwMRbF+z9LPjmb+lamY+9mmklnopIwA11HejHtvAsxhIO95CKAzJIhCE1OqX51uTwD4Va+KTq1sb/bgBei74WYLR8kLQtuiRIq3xo2XJ/jW0p3vPhpWh6zebazITSZhgAdBvPPwxraSkhaTBQoHdhBrmCeXNvu4qS0Efito6raT8WltEzmoLdONwZnsyJ1sr1pULRhPDvohFJ81kVm+HoAe7Vx+S2KGSyWFv+YV6yeLqZqN4hK4obwj0ggqWxfbti1fuBUSlmPeODW7R8y+TVCL3teU/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn+Esj+fVPKS034yM3jx6Fzmrd6OCcsltAWM2cZ9Djo=;
 b=nPVdFf3/yJNH0S6jRGPkHyS8ZFeA2DT67L7S626e4sXjGYAZO+sg4kYlWjEf/1XZY1JZ3CybT7bVqOZGX1zxg+FBMDwA6mnDlJUOAs3YhF7qxuHV2fNN6Svpq75fwdBmz1ktpQZAatWCst9/mfNYGsbqavCTd6OVq9UxwynU2TtYvKL2C2uDKT3+j/FmlKLcTHIfyZw3FA+30dsQq4bnzrrnKZH+2O4dOSwxFOL5WOlW+7nu+d6rq+1/7GZl38nZdjm92zZU79oGaF6n15NH31SHJCUU05qRNxgYwYaQ91A+7g1Dp9xccwpE6YpaRMTmL4bS1olOwBgwd8p7oNpg/w==
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB3PR0302MB3418.eurprd03.prod.outlook.com (2603:10a6:8:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Mon, 11 Jan
 2021 21:31:31 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 21:31:31 +0000
From:   Roman Anasal | BDSU <roman.anasal@bdsu.de>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
Thread-Topic: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
Thread-Index: AQHW6ExfcsLlXW2ATUu8CwlNGk82oqoi7S2AgAAEr4A=
Date:   Mon, 11 Jan 2021 21:31:31 +0000
Message-ID: <0363f5435d09d6fc0fdf4e680b408bfc96c8a698.camel@bdsu.de>
References: <20210111190243.4152-1-roman.anasal@bdsu.de>
         <20210111190243.4152-3-roman.anasal@bdsu.de>
         <20210111211529.GE6430@twin.jikos.cz>
In-Reply-To: <20210111211529.GE6430@twin.jikos.cz>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=bdsu.de;
x-originating-ip: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3da78550-1292-4cdf-01b8-08d8b6784383
x-ms-traffictypediagnostic: DB3PR0302MB3418:
x-microsoft-antispam-prvs: <DB3PR0302MB3418C99E1A8EB1FA99757D3794AB0@DB3PR0302MB3418.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hmHw+x3inDJqZTGkfdDdd6IpTULh6++BnqRbF/ypqwkOF4JHlLqgg3bwU73w3GWlcBQPL8Qr0TCqTztiBflGFicyAPq7IChDNZlHiZEdocI7RFVG0eeSanSlUTM+rWpZkES6rVUoHUu5YaeWm9LGXypdouCttp5wJ28LI0g8B9oypchTGf0CTmnMHPQJlypB7Sen9oR1j25nNa2/ksXpAy9hBG3JLazh7SPFXji/heZS8kByNFIp1kuSCqkhiEyVB5gftlqDW71LEfxVgXBLVmOKaKwdtmGVxZgqdjvv4i1/HQlBQnLQ075sU8xlZwjI7acOlYZL84TkH59XhFnZGHaKVwVO7eNOeoDfnOjQUDsJJLPXSvYrsSZnPQhy/9zw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(366004)(39830400003)(186003)(36756003)(66446008)(76116006)(66946007)(6512007)(6486002)(64756008)(66556008)(6916009)(8676002)(4326008)(66476007)(71200400001)(786003)(2906002)(316002)(6506007)(91956017)(86362001)(478600001)(5660300002)(83380400001)(2616005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S1JpUkhlb0ZJMjQ5ZVY2Mm9Ob1pzbmFNWFVwRWNRT21xQWRXYXhSMVF1N2ox?=
 =?utf-8?B?L1c1aEtwcS9jb0dEWEE4SHU3TTdaNDZQTkhYOXhRNjByK0lmb1VvYVNWUEdk?=
 =?utf-8?B?L1dCbUdrZ04xZlduQXBYWHhyVTBLRng4UXpIZDluTTJ0Rkx0V3pGbExCMEZK?=
 =?utf-8?B?Nmc3S2llRVM0YWNiMEE3M3JJQ0RvbmxnN1dXZ282aHhYY241OTZUa3JpRlZy?=
 =?utf-8?B?YnhZbXI3L2VNMjJZUXhsVlhuUXQrQXpYRmxhUzlHcnJYTHNSQWhZc2lZT2RO?=
 =?utf-8?B?NEJRbElBcmQraHFPQ0oweFdOWFEyODJ2KzJvS2ZrbHdiSWdsN3hMUkRUMFhQ?=
 =?utf-8?B?UW5yR3RXbUZJTzROZmRvUVBmTm5XMlhJM1J4d0I4R2JhNlFpa0NOZGM2Ym05?=
 =?utf-8?B?QU9NY2JObFd2YTBEQ2s2VGw5Q0V1aVJaNTN1RndIUGtnZHJVaHEyKzZ2Ymt4?=
 =?utf-8?B?NHpxdy9iYmtSR25QQmpsR1ZJeE5FK1c2cjN3a2VLWU02VXJkMmZWK056UGZM?=
 =?utf-8?B?SWgvRkxwVnFnSXpIMWF2Y3FGaVNYbTRjMXErVzJMRTc4d243UDVLVDR2TkE0?=
 =?utf-8?B?anM3REU4ZGlScFZWcDJSM0FyZGc5OVRRN3dWZFMwY0pMSkpWWnBlUm9lYjlh?=
 =?utf-8?B?M3Q4aFhTMU9KbWp4SHBtYldyRHRMV1hXY2JBa0RrR1VDM2ZEVVRlOHd1Wjho?=
 =?utf-8?B?VGtaMTBBYVlvZjlPSy9yekJvdnR2U0NMZms4VVJDby9GaXZ5dkpENVBESTB6?=
 =?utf-8?B?bnhnNHBGYVpSRHI3clJHRGc3YzJDMnJxL2JNM054WEg3a21hYUxWUjl2elJU?=
 =?utf-8?B?Y1RlVnJoVVlKbnFtZHYxdnlDTGJpb0tmNjIrRXB5dWFPYUVkcE81VzFrMHd3?=
 =?utf-8?B?WlhUVlZCbTNnbFlhc0xyS1cxR053THJ1K01IR3ludEljaXdkOENzaUNhL00y?=
 =?utf-8?B?Rno1MkUxU0Z6LzZGZFJvNEVhbzF5Wk15R1hDRDYwNy8xaUJNdGgveDBBNVZ4?=
 =?utf-8?B?SGxDdVZLem9vKzBndFJ1NlNlTjFUOE0yN1B6YkNiMHJ2SjRpM3k3ZDY4RHgv?=
 =?utf-8?B?cXZNd0E3OXplVmltWThPcE5lWUttekRWWG9YVVlLa2EyZjZtQUZCS0t6OVJx?=
 =?utf-8?B?QStXMlpnMmNWb1BabS8wVDNzVzhvWFQyMDB3V3dRUWMwTWZQb2t0RW5Pd0dS?=
 =?utf-8?B?RGFubFVNekt4QlFidFcvQnZOTjU1bW5lNjBYbUJxczhkMFQ5QldVL0Jya3p0?=
 =?utf-8?B?eVB4ZlBIWGd6SGVWV1JUK2NqMUNkUFZQZTRuM2NXMnZFUzBmSjkrV2RJQkhq?=
 =?utf-8?B?bFN4S3RnWE9jZ2pCNFhHLzBCVkgxL0hHeFl0ZzZ0dTJ5M29sTWIzcTJqRnJs?=
 =?utf-8?B?Q3U3K0pLNURMaVBCOStyeWtZaFJaQis2TkRrUmkra28xOFZGQklBRzNrMXpD?=
 =?utf-8?Q?Pxnu/Bqp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2536544A96B0B469926CAC1AF6D644F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da78550-1292-4cdf-01b8-08d8b6784383
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 21:31:31.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeQmUuG1hvJeT8yvJXoeI9gCv0LEmkFgDkclCj39AcnmINHZkW3zHq/l8EXUT7b49pfaxEg8cjfcXk62q+fe9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3418
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTExIGF0IDIyOjE1ICswMTAwLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+
IE9uIE1vbiwgSmFuIDExLCAyMDIxIGF0IDA4OjAyOjQzUE0gKzAxMDAsIFJvbWFuIEFuYXNhbCB3
cm90ZToNCj4gPiAtLS0gYS9mcy9idHJmcy9zZW5kLmMNCj4gPiArKysgYi9mcy9idHJmcy9zZW5k
LmMNCj4gPiBAQCAtNjI5OSwxMiArNjI5OSwxOCBAQCBzdGF0aWMgaW50IGNoYW5nZWRfaW5vZGUo
c3RydWN0IHNlbmRfY3R4DQo+ID4gKnNjdHgsDQo+ID4gIAkJcmlnaHRfZ2VuID0gYnRyZnNfaW5v
ZGVfZ2VuZXJhdGlvbihzY3R4LT5yaWdodF9wYXRoLQ0KPiA+ID5ub2Rlc1swXSwNCj4gPiAgCQkJ
CXJpZ2h0X2lpKTsNCj4gPiAgDQo+ID4gKwkJdTY0IGxlZnRfdHlwZSA9IFNfSUZNVCAmIGJ0cmZz
X2lub2RlX21vZGUoDQo+ID4gKwkJCQlzY3R4LT5sZWZ0X3BhdGgtPm5vZGVzWzBdLCBsZWZ0X2lp
KTsNCj4gPiArCQl1NjQgcmlnaHRfdHlwZSA9IFNfSUZNVCAmIGJ0cmZzX2lub2RlX21vZGUoDQo+
ID4gKwkJCQlzY3R4LT5yaWdodF9wYXRoLT5ub2Rlc1swXSwgcmlnaHRfaWkpOw0KPiANCj4gTWlu
b3Igbm90ZSwgd2UgZG9uJ3QgdXNlIHRoZSBkZWNsYXJhdGlvbnMgbWl4ZWQgd2l0aCBjb2RlLCBz
byB0aGUNCj4gdmFyaWFibGVzIG5lZWQgdG8gYmUgZGVjbGFyZWQgc2VwYXJhdGVsbHksIGJ1dCBJ
IGNhbiBmaXggdGhhdCB1bmxlc3MNCj4gdGhlcmUncyBhbm90aGVyIHJlYXNvbiB0byB1cGRhdGUg
YW5kIHJlc2VuZCB0aGUgcGF0Y2hlcy4NCg0KQWggeWVzLCBJIHdhcyBxdWl0ZSB1bnN1cmUgd2hl
cmUgdG8gcHV0IHRoZSBkZWNsYXJhdGlvbnMgYW5kIHRoZW4NCndhbnRlZCB0byBwdXQgdGhlbSBh
cyBjbG9zZSBhcyBwb3NzaWJsZSB0byB0aGUgdXNhZ2UgYW5kIGRlY2lkZWQgdG8gcHV0DQp0aGVt
IGluIHRoZSBzYW1lICJzY29wZSIuDQpCdXQganVzdCBub3cgSSByZWFsaXNlZCBJIHdhcyBzdGls
bCB0aGlua2luZyBpbiB0aGUgd3JvbmcgcHJvZ3JhbW1pbmcNCmxhbmd1YWdlIGFuZCB0aGVyZSBp
cyBubyAiaWYtYmxvY2stc2NvcGUiIGluIEMgOkQNCg0KU28gSSB1cGRhdGVkIHRoZSBjb21taXQg
cmVzcGVjdGl2ZWx5IGFuZCBjYW4gcmVzZW5kIGlmIG5lZWRlZC4NCg==
