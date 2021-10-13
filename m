Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3782542BE87
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 13:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhJMLDs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 07:03:48 -0400
Received: from mail-eopbgr1300127.outbound.protection.outlook.com ([40.107.130.127]:11922
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232807AbhJMLDe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 07:03:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXvbaIn0mOid8sbhCFyNywvnGLHSle20tQx2pEYtnJnjWqhOgtoing/DBYNWY6p6kdSayFDorv9dUTnpCcAIyDTembrfn6BQK4sOgPCYD5e8CUuiE39l3KBuh5u95QzUBA/Yq2DNATt4nhwlvr5188EIP1R3s6IK9PaiCnNUFdvY0mwxy8KvZGNO8GT2ySd6LUHohk4pbSdiADhXtTRtyukVZVDK//v7KGrslIZIRFy/Z78Jh7BGQUsmObYR1lX6hzqkpuk45M6/9h98BxfqV7dqodfOVErj0s+NYvCPoE8d73AKNTU7V27Htg6Pg7kgoMsDae4ZBK91D5AhBeErxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6U3olCwcdBuNABb3xsXOASEg3SnSnvtaXEMjdoajjAE=;
 b=kNQqTmZMGqtWtZqsvm6SXDuHF4GCeNZQY+DbKsknPsASHWFa8fCOR2Pjoj0RBFn/rSgaVqqQ6KiSR4YmnwDmzsJhe5c8R3oJZZzTrHmsWvmHoWFDsWFbNJazAyi3lKtdeAOvBCcSXb61fakZoWXgLDlhy/aJIz1l047GZ1B5bB2DF+fs4hnrB9hEy1dPNKlIW8T7Ekq02IWOliUofHi0nGujlmT8WHQZmjhm8cOV1jbreAdVqA7ZrP5B6V5g4j7L4+8p59ADwBRcbLmaFxfnHvC9pjdhfPDhJkenF0e+evmILTYh82LxzEpOpmmFIIgiMphSuePZgC7Psx/TJqAbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U3olCwcdBuNABb3xsXOASEg3SnSnvtaXEMjdoajjAE=;
 b=PZ8IgOpbW6hIQcKJcPQ6AirlT4y6x2Cjz/PlcFeUsOQ2obsnrxQiIxhOJVOLZZvqvFkM2Kr4FaOqQB5m2PlAuaNMETINSRlp//DmCqcvHRSSw0jXGgFA90+vf0ojChzn4wLLDBswY6WU+oJnPIF3nBfww/kiy8enFYVREtyqYv8=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3115.apcprd06.prod.outlook.com (2603:1096:100:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 11:01:28 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 11:01:28 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Anand Jain <anand.jain@oracle.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGJ0cmZzOiByZXBsYWNlIHNucHJpbnRmIGluIHNo?=
 =?utf-8?Q?ow_functions_with_sysfs=5Femit?=
Thread-Topic: [PATCH] btrfs: replace snprintf in show functions with
 sysfs_emit
Thread-Index: AQHXv+JtgDtYLu6mDEesnK0OhzJVW6vQwDpKgAABYno=
Date:   Wed, 13 Oct 2021 11:01:27 +0000
Message-ID: <SL2PR06MB3082B71AFE2C42CABDD5E6D6BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1634095717-4480-1-git-send-email-wangqing@vivo.com>
 <6f03e790-6f21-703f-c761-a034575f465e@oracle.com>
 <20211013103642.GC9286@twin.jikos.cz>
 <ADsAzABEEmLRWHzgUOl4Sqr5.9.1634122164687.Hmail.wangqing@vivo.com>
In-Reply-To: <ADsAzABEEmLRWHzgUOl4Sqr5.9.1634122164687.Hmail.wangqing@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8c75091f-6ccb-3329-c518-5306fe1246ec
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed75ad9a-732f-473d-a999-08d98e38ce54
x-ms-traffictypediagnostic: SL2PR06MB3115:
x-microsoft-antispam-prvs: <SL2PR06MB31152B77EDC97245354B520DBDB79@SL2PR06MB3115.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQN+WLQX3UcFjYX/nLFAy8bOM7/J1snEMxQq2JYBPDAQztsHS1y4BeDEjRKIu4REYV4O6AH2+JAUORZaAWdYAxPhQNuH8w3bvwbt+AjmBZdGWjnY/lnLS0+wtmweyohZ6CtCJs0qRnU0YlnzaDmV0izsNGvzZzsexLVMXXot5cH/C5gAbRd5tCqd3jzyoj4wcbmM5kkXHJaYCll9r/D5JTRmMlhmJzs0OnT5BAuOJM0iDWL5hTKrA2MmT1SegAhJ7zspiXOc95kbOVGrXvbWqOVNlbipTQowzWTtFZ3m77Vz/gKjSHEzYWbAlLgvRy+vHGUoF60uejI/2R+vZij5J2S9vkIpton0MZcuA/wp+3acjED5F+/Du3YimzWNTaXft8QIojJi2xlfuEF9u5Yc/RdVAm8waeeiI4nh54T0fkuLnNrORiWdlOKcuG3Jm5NwQLniAP5leeaswBRZSpZMTFvm6XVwA87R72aUXVG/484WmYfd+NO8mvnb+MUP6zJu7bxFd9XpLLpekwd5aElVg+bBTgbWNk6nPZaqsFtLdT0tqxMWEjudRnRvooq61WEXzHd+VJQv7Xoh4dZmzpvKIVcoIlCaQTTBMqmNLE+j2BQ1cyeiEQAgQyWZ8so8hBKZQc3sQNRDj9H2XQ93R7cdkJBo1TQ7s0QxJpTgj8DJvRa9Tj8mrOeLLknmT5DiQF1G1lPxpJzLH5cXgCJzdlPwMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(9686003)(71200400001)(6506007)(85182001)(55016002)(110136005)(33656002)(26005)(186003)(316002)(2906002)(38100700002)(224303003)(86362001)(53546011)(52536014)(91956017)(66556008)(66446008)(8936002)(76116006)(64756008)(7696005)(83380400001)(122000001)(508600001)(38070700005)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXIxYzZoaDVPeC9xOGVGNStVZDl0NXJDUHlNZE4yZG0xbnBHNjRsUUFOTDd5?=
 =?utf-8?B?MDdlMkpLVlp4S3NoRDFyeEdFeHY1U1ByZWpwSUZSalQwc05iTk1XaHQxb0p2?=
 =?utf-8?B?VG9RZGU5T1FHSHdqa0lYOGJod0xMdWtwK0IrTlZmWmJOTHozbnAwRkhTb2NR?=
 =?utf-8?B?SFVXNUNMUzVMWE45azV4YVB0RlBmbk9tL29yT2x6Z0NCLzNFQlpiQlJGQXJJ?=
 =?utf-8?B?SmZRMnh0dWpTbHhjd0U2enViTGpuL1YzdkNvQmtRaVRrWmErUlpmMFRJdVhC?=
 =?utf-8?B?UnlHSVRjK1VoK0dsRXEwYmV6WHBzSlV5U0Z6eVdyL2ZsNGw0TlZpeE1lVVdK?=
 =?utf-8?B?TGFKTmtFQlFLSEpYTTNUV2tSSmFEaXljekFVdUgyYXpXRGJvL2Fxa1cxcFlX?=
 =?utf-8?B?dkhuL1Y0YVZyYnZIaS9YaEE4UEtCTm9zRmI1Z0xiZzlrV3lrM1o5ZlpBaUFT?=
 =?utf-8?B?WjVxZHBwdUJFckI0OWVhSGRwVmhkUkpmVlRNK1oyZFdUdmFOdXRRZlk1Uzhn?=
 =?utf-8?B?S1diQjJuUDNrdWFKRFkyUFFyem9DSGxWMEtaeXNNekNEemd2YkRmTkg5cXBm?=
 =?utf-8?B?eWtseXFjK0Z4LzhLc1pmVnl4V0Y0dTVnMkZZM2s2T280VTZCZUN5NlUwWnhQ?=
 =?utf-8?B?NHFGbkVBbmt3aHlqblpmOEJMTCtBaHVDT2ZiLzhIa0c3cTdjZkx6V0k4Tk5U?=
 =?utf-8?B?STJwRXFlRW41Vm1Qazczd1FIeWRtaE9HTnp1amk5VWdLS0dac1FId0NVbExv?=
 =?utf-8?B?WHEwN1lXNDE0dXVReTJ1dGNmQ3U4bmZraUNEOFlpbTlRUEFHMGZpMXZoYTJ3?=
 =?utf-8?B?SjNmcjZkaHJTZVV5MC95NC80dEgxT1NKZnVKcStrbHh6RVdVYVNCYmdFNXVs?=
 =?utf-8?B?MVRWU2w2YzlYVDduUUJGeUoweDM3amdrWW9pSjl2cXJkaEo4ZzhheWkxTlMv?=
 =?utf-8?B?L0JZSStHMFNTczNYKy83TWhySmRlOTVuWXpCbW90dW04NjlBVnFrc1Y5Slo3?=
 =?utf-8?B?TXMwbVl1ZlprL3VYVHBsRVAzYzNzWm9XOGdpVlVibm9TamR1aytYL21yMjBl?=
 =?utf-8?B?Rys1dWUzUHpsL3dmak4vbDI4UnhMZlhNZ2IzUTh3ZUQ0NzhLbVc5enlEV3BP?=
 =?utf-8?B?VnM1NzhLU2hlUEZ5aEV5VWlMTmQycmptYW41WHA3Tmc5SWd3aU12WmNEdDhN?=
 =?utf-8?B?L0RBUDk3RUs4MWdSMVBsZUZuVkdiYkI3QmVwR1M3NXZJS2lTZ1hNU1B4Tzdx?=
 =?utf-8?B?V2ZaQUJxcURmSzJUU3JrRFl6L3VZNkx6akljb1lzZWlyUHRwTW9VNFZTV201?=
 =?utf-8?B?NVYrN0ZwdEFVeFVScWJhT0dxak1WemEvV1FXTVg0Y0xvVGtXaHBzd0dhN1dU?=
 =?utf-8?B?ckZBemFGaFNQelhLdzljS0RmOXdSQTE1akg1RmZJZENsYVNxMkp1WmMvM2VY?=
 =?utf-8?B?c3pvL0dXdVkrRElzZUtySC8wL0FVek42VVRaa0tyT2pSczQ1QmlQSHM4SHdQ?=
 =?utf-8?B?U21YclMycytTNWloalV3ZFJGM1doSDV4R0VKdGdXSTNramx1Nlk4ZjZJT2E3?=
 =?utf-8?B?UUU2cGFsYnM1M1FxV01BV1p5Y2xQS2lUbVRSWllTTmxLci9vck9hQk1IRGpT?=
 =?utf-8?B?MzB0RFoxb04xWTNaRW1aZk1Na2xhQ2VGeHFSQ1BadFJ6eFovMzJwR1hadzIy?=
 =?utf-8?B?TmV3dFNVV2tiSE9Tb3lNV0F5TXJRK3A0UG1nUHhmbzVhSHdLRDlqYXBndFVN?=
 =?utf-8?Q?eSU2L+mv9Or4Cn22s8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed75ad9a-732f-473d-a999-08d98e38ce54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 11:01:27.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vP+aY6xS62zKrBQu9NKKf3VZ/rnggOa0IQIHKW1+aH4QKi08dm1BeLvyN8znelwuS0PZhs+upCDikB4fsbTq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3115
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cj4+IE9uIFdlZCwgT2N0IDEzLCAyMDIxIGF0IDAzOjUxOjMzUE0gKzA4MDAsIEFuYW5kIEphaW4g
d3JvdGU6Cj4+PiBPbiAxMy8xMC8yMDIxIDExOjI4LCBRaW5nIFdhbmcgd3JvdGU6Cj4+Pj4gY29j
Y2ljaGVjayBjb21wbGFpbnMgYWJvdXQgdGhlIHVzZSBvZiBzbnByaW50ZigpIGluIHN5c2ZzIHNo
b3cgZnVuY3Rpb25zLgo+Pj4KPj4+IEl0IGxvb2tzIGxpa2UgdGhlIHJlYXNvbiBpcyBzbnByaW50
ZigpIHVuYXdhcmUgb2YgdGhlIFBBR0VfU0laRQo+Pj4gbWF4X2xpbWl0IG9mIHRoZSBidWYuCj4+
Pgo+Pj4+IEZpeCB0aGUgZm9sbG93aW5nIGNvY2NpY2hlY2sgd2FybmluZzoKPj4+PiBmcy9idHJm
cy9zeXNmcy5jOjMzNTo4LTE2OiBXQVJOSU5HOiB1c2Ugc2NucHJpbnRmIG9yIHNwcmludGYuCj4K
PklJUkMgc3ByaW50ZigpIGlzIGxlc3Mgc2FmZSB0aGFuIHNucHJpbnRmKCkuCj5JcyB0aGUgY2hl
Y2sgcmVhbGx5IGNvcnJlY3QgdG8gbWVudGlvbiBzcHJpbnRmKCk/CgpkZXZpY2VfYXR0cl9zaG93
LmNvY2NpIG1ldGlvbnMgc2hvdygpIG11c3Qgbm90IHVzZSBzbnByaW50ZigpIAp3aGVuIGZvcm1h
dHRpbmcgdGhlIHZhbHVlIHRvIGJlIHJldHVybmVkIHRvIHVzZXIgc3BhY2UuCklmIHlvdSBjYW4g
Z3VhcmFudGVlIHRoYXQgYW4gb3ZlcmZsb3cgd2lsbCBuZXZlciBoYXBwZW4geW91CmNhbiB1c2Ug
c3ByaW50ZigpIG90aGVyd2lzZSB5b3UgbXVzdCB1c2Ugc2NucHJpbnRmKCkuCgpNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoaXMgaXMgbm90IG9ubHkgdG8gc29sdmUgdGhlIHBvc3NpYmxlIApvdmVyZmxv
dyBpc3N1ZSwgc25wcmludGYoKSByZXR1cm5zIHRoZSBsZW5ndGggb2YgdGhlIHN0cmluZywgbm90
IAp0aGUgbGVuZ3RoIGFjdHVhbGx5IHdyaXR0ZW4uIFdlIGNhbiBkaXJlY3RseSB1c2Ugc3lzZnNf
ZW1pdCgpIGhlcmUuCgpUaGFua3MsCgpRaW5nCgo+Pj4KPj4+IEhtLiBXZSB1c2Ugc25wcmludGYo
KSBhdCBxdWl0ZSBhIGxvdCBtb3JlIHBsYWNlcyBpbiBzeXNmcy5jIGFuZCwgSSBkb24ndAo+Pj4g
c2VlIHRoZW0gZ2V0dGluZyB0aGlzIGZpeC4gV2h5Pwo+Pgo+PiBJIGd1ZXNzIHRoZSBwYXRjaCBp
cyBvbmx5IGFkZHJlc3NpbmcgdGhlIHdhcm5pbmcgZm9yIHNucHJpbnRmLCByZWFkaW5nCj4+IHRo
ZSBzb3VyY2VzIHdvdWxkIHNob3cgaG93IG1hbnkgbW9yZSBjb252ZXJzaW9ucyBjb3VsZCBoYXZl
IGJlZW4gZG9uZSBvZgo+PiBzY25wcmludGYgY2FsbHMuCj4+Cj4+Pj4gVXNlIHN5c2ZzX2VtaXQg
aW5zdGVhZCBvZiBzY25wcmludGYgb3Igc3ByaW50ZiBtYWtlcyBtb3JlIHNlbnNlLgo+Pj4KPj4+
IEJlbG93IGNvbW1pdCBoYXMgYWRkZWQgaXQuIE5pY2UuCj4+Pgo+Pj4gY29tbWl0IDJlZmM0NTlk
MDZmMTYzMDAwMWUzOTg0ODU0ODQ4YTU2NDcwODYyMzIKPj4+IERhdGU6wqDCoCBXZWQgU2VwIDE2
IDEzOjQwOjM4IDIwMjAgLTA3MDAKPj4+Cj4+PsKgwqDCoMKgwqDCoCBzeXNmczogQWRkIHN5c2Zz
X2VtaXQgYW5kIHN5c2ZzX2VtaXRfYXQgdG8gZm9ybWF0IHN5c2ZzIG91dAo+Pgo+PiBUaGUgY29u
dmVyc2lvbiB0byB0aGUgc3RhbmRhcmQgaGVscGVyIGlzIGdvb2QsIGJ1dCBzaG91bGQgYmUgZG9u
ZQo+PiBpbiB0aGUgZW50aXJlIGZpbGUuCj4+Cj4KPiBZZWFoLCB0aGUgc2FtZSBpZGVhLCBhbGwg
c3lzZnMgaW50ZXJmYWNlIHNob3VsZCBjb252ZXJ0IHRvIHRoZSBuZXcKPiBpbnRlcmZhY2UsIG5v
dCBvbmx5IHRoZSBzbnByaW50ZigpLgo+Cj4gVGhhbmtzLAo+IFF1
