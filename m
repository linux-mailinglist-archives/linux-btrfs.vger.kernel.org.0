Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5D48E320
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 05:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiANEDS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 23:03:18 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59889 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiANEDR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 23:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642132997; x=1673668997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U9h2MkSyYOtWeSLy49FEah3Q4Y9Dr/ghRO+kW4BLN2w=;
  b=eYNGxQyn9lu9uH0p52Id61bwVm3I4KYyI7tIj4buRD/9acu/h7zU6gyG
   0xT7e+Ss6Ts5s1L2UHw0PyD2X6enmiO5aPGLVwD/H1Ku/7Tg6P0iXFZ11
   MFFsszB1hdB/LkDHd/tEoEt0dTjNEL+3pGJs7zMKgb5QRTOOTePlzaLc8
   WjgGqsQ2KO2CJSasampW2ZJyHkeIzqy7ntAlhXl7z/w37taK9HlcNgHyu
   7WjWP/Pmb4p/9HoT6DqZ6aj8F9aOCpN9ZGaQzVwbhVeIaZN9gyCTSqpyP
   GNmBKW64TVVY0Sed+GhJsq+5SNje3YNo92SsSC9YE9KAmwT4KPgkLs8gS
   A==;
X-IronPort-AV: E=Sophos;i="5.88,287,1635177600"; 
   d="scan'208";a="294497233"
Received: from mail-dm6nam08lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2022 12:03:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9GYlH0iASnFvg+Sg5Hy5wIfWozG5j5frQQhDWBvmesDTUz9TaZ85RQGl+xBl7oWavex+fmGWsHWr5o2uJKzmlPAfb2fbEfUSFHSpcxYq1LgvTg1qo7D0YYyADot3T66pyHjzKu4twqwplYhJXm2kPvI4R9+Jgf1qPuxlnYB/UkwPwwfnXRbGf38nmD2fbu//6ORdQh2LRuFpnpXHpM9YKJS+1ngZ2PvBpGQg+2uV6mKa/Ubzta+G9vfrmUftysKuGjeQeRv+xjvBW1H6aQB7UPASCVn5vUM3Tk4D7LSmo/c/YHyLMG+Ypm2h620artWBnUweRfp3QMlp3KI7hBtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9h2MkSyYOtWeSLy49FEah3Q4Y9Dr/ghRO+kW4BLN2w=;
 b=Q2THMXyKfB3ESQUUVsN7nxkkqLOm3z9QjfamvEsYaLW+U+lgyWmXOhYzTIflE+nxTRROiO30IVohIKqNEiO38XWe8tJ4k0p7hfXR/tv2yT9GfVgjXJcs2R9xU1QkaS3RN+WR+zrMw2Fac+VhcJs45iPRNR0t/RLGE5RdzaOnAZdzuH9OBNk4ZByQtyRmnvHPYAzhNxWCS7jZBMR0rn0V1QJF6DD0d8Lfasr5oEhLAbSEFyri0Py26+4lc8HyP21zSkKJGwbAHp61plFhA490whEPqhSSbEc2OD0RrP6loOwPjf3kTLxxFOnCtumk1OambI2QFxr/1YwuI+gfIaKNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9h2MkSyYOtWeSLy49FEah3Q4Y9Dr/ghRO+kW4BLN2w=;
 b=sXLODWS+9sPCglKiHs1lYA9tQrjTqeLQMoGoijz8r4kGp0RfN84xer5WV9eGUoKdczVo2LN53l+UKZQgJr9dcGNOGq8r4GjFyQB4buhyfeCF0I8HrTqzusZM3P6lVAm9Xb9+6oMSyU7rBmklREPFmmrTG1D4EPDPRXJlFNvrhVg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN4PR0401MB3631.namprd04.prod.outlook.com (2603:10b6:803:4b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 04:03:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd%7]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 04:03:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
Thread-Topic: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
Thread-Index: AQHYCGn+Q1quPPNsLk6Wk9uNZEhSIqxg6DiAgADI/gCAADVEAA==
Date:   Fri, 14 Jan 2022 04:03:14 +0000
Message-ID: <20220114040314.q46pvlcyyno2ze3d@shindev>
References: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
 <fa15b470-c2ad-152a-9398-17bf65be4eba@suse.com>
 <20220114005236.yrvqqzpegik4xhm3@shindev>
In-Reply-To: <20220114005236.yrvqqzpegik4xhm3@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05f8d612-aab8-488d-302a-08d9d712c9fd
x-ms-traffictypediagnostic: SN4PR0401MB3631:EE_
x-microsoft-antispam-prvs: <SN4PR0401MB3631DA05D7783567B36D2176ED549@SN4PR0401MB3631.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mxQsy1tR9isKoeB72DvZFzsUCq72HxfS3An3qVoAE/KcHRkGz14lFq8TafYZIUmDMJJwVsDTIJ7vvmyRX9ogJIx0mHsnmRYdViRt4x/mLBa/k9X91BWRLMErwX24klpkfSinB7HpH7wwBTe4Ge7BfoG3/jYijgZtntQXaY8zeNOgFpIe5VXlii/kOrFPuRijT4/uxf02maEOwAIneVim0uR0emrG5izcGIJSUqbHuJPIkEc+3XgZs4fkIhBQhqHnECyLDxx9ffgq3HLYDjtPou8VChZHsMAxCx2+pvZ7IGUmrgF5lymB3z/fz/yrft05CSK1S+UkRB9ZvVO49NRnsexwGJRfgbA4zXsgkz4xWJ8OeXIUVohoeg9hubueXWDoJCI0uj0qnICPZ+P6fDzSdYiGnCx0/d4qCe8PBZ8n1Ey//zQQtJ7zLD/ztC8Ka+Gpm0Q5ZFN8r/AcYnE2QnBFAQ3CusVA2A1qDkEqdJrLduXJ11LnjNtXynCigHFHEV58WRgYljnfXNWo4LwC6jKJbBq8jv31JoPESXzE5OmSOneP3IiIHDczd6oHUKxZK9xa3SUFtR2+rzw74K4drWjH93wf8FcoJAH6F6XlE+vMXZFwyr/9RDMHFhmuWKQVbKNJvyI0FC10fKsiMZ0NwFlDGnsE24Cjk0E+EPC/7E63s7/U9v/bNc5v645rrIst78f5PYnRwZdPfmtvlwF7g+QNyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(76116006)(71200400001)(9686003)(66446008)(91956017)(8936002)(1076003)(26005)(6506007)(64756008)(186003)(508600001)(6512007)(66946007)(66476007)(66556008)(86362001)(4326008)(8676002)(82960400001)(2906002)(54906003)(316002)(33716001)(6486002)(38070700005)(38100700002)(15650500001)(44832011)(5660300002)(83380400001)(6916009)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDA2anJ3U3lqS0dIRnN1NnhXTXozRjk4RzdXTXhhRXBWV1FqZXYzWHcyc3lx?=
 =?utf-8?B?YmdPVHZIUCtKQ3RBTnRQSHBEWGUzOWIwWUxQVUlYejBKcE1IaTJqNStsNklY?=
 =?utf-8?B?VWZFd1p4cW9oV24vRzFDSW9nWmRUUFkydXVPWGg0NEtIa205TzB1Y1BmRkUz?=
 =?utf-8?B?bmYwUzVIVko0RWFwNnIzNFJzUUpUUlRtdXpHYWV3Z1VFTENJZTVDWVZ4TENX?=
 =?utf-8?B?RUNMZ1pLQmx5bzZzUlNjOEc5K0F2YlFiM0ZEU00reUlFT04xeFQwZis4M2FK?=
 =?utf-8?B?akVhT05ydTUxbzZzNlJ1Z1FaNnVSMXU4RHJvS0oyazBRT0djWGpKYWttQmxa?=
 =?utf-8?B?Szh6SDBHckg4RnRSL00wQWRFY2FPVVpMUmR2RFlzc2xScEFLTzcyRHkwa0I0?=
 =?utf-8?B?T3pHa0ZEM1Rxem9YTDMycWxHaXpjTVdaZlExZktGWllXN011QlhzL0k2SVQz?=
 =?utf-8?B?RmJaeFNvU3ZiRFg2KzRkc3MrQ21Lc3F2UGtNcDhvYVEyaUdHdkdDZFdkekFX?=
 =?utf-8?B?bWVxRjZtaDlHTGdUby83U0NPTEJ4L1VmSDNhYjdnV25oZWV6ZkxKL2ZSdHd3?=
 =?utf-8?B?YnlXajFXT2JuR1dJM1VxLzRMUDkyWklPeWFKa1VzbHVoNjhrWEFNMmN0NlMy?=
 =?utf-8?B?cTBiRVp5dHBZejc5RFFGTlNTSFBiaGNvYUtHY2VMYlJ2c2ZvbW1GOGh3QTBB?=
 =?utf-8?B?cWRQcjdrMWRJT3djNGJmZ3REZ1NaQVVINlVka01pekpOajMzekRZOGhMUXMw?=
 =?utf-8?B?OFZ6RWhOZXZINUxWWG10YWppdlVNQTQxV0x1Nk9CZTF5M0d5UVRUOWk1Z1A4?=
 =?utf-8?B?VFFQT2JEb2JmTkdYVlVuSGdZTjhCRmhSdjNuRnZiekxrU0M3NlFDVFE2akxj?=
 =?utf-8?B?b0h4am1MQWFvZDVZZE1oVlpUNEZNVzJ3STZocFFNcjU5dkZCNFhlekMxTkx3?=
 =?utf-8?B?emFvNlFJbGRCai9Ea1ZvQytGRlpCcldlTWh3R0pIRHlha3k2UTVxT3d4L1V6?=
 =?utf-8?B?TmN3amM3RkpaY0VGU3BxT3FKYzBySmltaFpwNUZuWVNNQVBCRElSRTdyVStr?=
 =?utf-8?B?M2pQOXJNTWRGZU5XOGZhRTFvSS9zVUV4QU50cWxHZ1RTdnA1Si9XdUdRQU1v?=
 =?utf-8?B?YjFPaEVPRnVwOFpOWmJYT3lRdjZ5VmIyNnVmdThFQUE3TktZZnBJaEJ2SVZZ?=
 =?utf-8?B?cm5YT1JpT1FldmFYZ0lLZzZCak1CbTEvaU1SeXdKTGNNb1VXZmh2UEZwMkt1?=
 =?utf-8?B?VVVDbzhFOFZQZUx3dGZIQk5OZWpRTW9HemQvR2hUNUc5ZWc2K050Vzd4a09V?=
 =?utf-8?B?QmVmQXhSZjVYWlQ1S2M0UVpLT2dzMUFnZUVUc1diU1c3cXh3M1BsUjRKSXBk?=
 =?utf-8?B?ck9nWVUzTjhsMUgvSkUvNU1reTVpTzJCT3cwMWoxUmFqcVh6MC9VSTlsakcy?=
 =?utf-8?B?SmJtZWtPQkxmNnFHNFE4V1QrNVA0TC9zYzF4R2hDZkhxekVneDFtV1BjR2l4?=
 =?utf-8?B?cktNUDQ5MUF2a0RXcUd3RFErS0ZRQ0NTOGpuUyt2NDZmQ3VSWkZmQkozNkdy?=
 =?utf-8?B?SmVQVEJ0c2ZLRFc4SkpYQWZhaVZjY244SlBxRFRaVzM1NE5HVlJWNllEbVk5?=
 =?utf-8?B?N2Z5WjZWamx4L1NsNGZrOFJYeVQ0NXNhbk02TGJIaXlZQWdsYXB3NEJzVU5n?=
 =?utf-8?B?cWRLSUpPbVM0NWQrZzhjZFBoSHE2Nm1qbGc1bENON01MWDVNaVpTcytZYngz?=
 =?utf-8?B?eGR6Qm1kbys5ZDNOK3pLWEpsQnZVWFpYdEE0UnQ2YXhBUUFBQ2E5QU1tbGVL?=
 =?utf-8?B?ODZvQmh2WFoyT2tHaEtIMTdCWm5lNkxEcUNJZlZTMXlGOFgrcDZsUC9PRm1m?=
 =?utf-8?B?Zmx2dk5rRjRhMisya2VTcG5GNTVobVZXWGZYa1k5d05ub0tpbDdtYzNjNGNB?=
 =?utf-8?B?dGxsWTJTcndidm5NZUN6NnBCTXZjUXduU05QWWI2d3NjbUhxZUFzakpwdWUw?=
 =?utf-8?B?R29uTExuVi9ycXJKMlVNT2QxMkVZb3F0aVN4bkZRM2ZqT0pNbVppRG1vNmY2?=
 =?utf-8?B?bngyUWsvT1liQnVtSkM4ZFVvai8yZXRTTkdLMk1xcWlQYktnZjJCYjBrRmd1?=
 =?utf-8?B?RGVKZXRuRTZpSFZnSzRnZmQwVXFsV2tiREdCUStnK0ROMURCNUtZTndlOFYy?=
 =?utf-8?B?U1l2QXhYRms3Myt2dzFpdUJ3VnJyOVhNbEtOSXhFN09GNEM1NXMyWkdzdHQv?=
 =?utf-8?Q?uT1K3V6pOjgLOppEnHhycxRBZ90cUPcpZEqvcy0VjI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC1FE839285894A92B6993FAFD60031@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f8d612-aab8-488d-302a-08d9d712c9fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 04:03:14.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzTjXtNalCzi5/rCSjF/rr5z4WTU9m2hBkt5YIp4PGqDY2FE1wHVxAe7Hl3Napy1O84UDxmoVP2C2xWZGo69r4XNnwVhejLMHojx9Glsg8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3631
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gSmFuIDE0LCAyMDIyIC8gMDA6NTIsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9u
IEphbiAxMywgMjAyMiAvIDE0OjUzLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6DQo+ID4gDQo+ID4g
DQo+ID4gT24gMTMuMDEuMjIg0LMuIDEyOjQwLCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToN
Cj4gPiA+IFF1b3RhIGRpc2FibGUgaW9jdGwgc3RhcnRzIGEgdHJhbnNhY3Rpb24gYmVmb3JlIHdh
aXRpbmcgZm9yIHRoZSBxZ3JvdXANCj4gPiA+IHJlc2NhbiB3b3JrZXIgY29tcGxldGVzLiBIb3dl
dmVyLCB0aGlzIHdhaXQgY2FuIGJlIGluZmluaXRlIGFuZCByZXN1bHRzDQo+ID4gPiBpbiBkZWFk
bG9jayBiZWNhdXNlIG9mIGNpcmN1bGFyIGRlcGVuZGVuY3kgYW1vbmcgdGhlIHF1b3RhIGRpc2Fi
bGUNCj4gPiA+IGlvY3RsLCB0aGUgcWdyb3VwIHJlc2NhbiB3b3JrZXIgYW5kIHRoZSBvdGhlciB0
YXNrIHdpdGggdHJhbnNhY3Rpb24gc3VjaA0KPiA+ID4gYXMgYmxvY2sgZ3JvdXAgcmVsb2NhdGlv
biB0YXNrLg0KPiA+IA0KPiA+IDxzbmlwPg0KPiA+IA0KPiA+ID4gU3VnZ2VzdGVkLWJ5OiBOYW9o
aXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hp
bidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gIGZzL2J0cmZzL2N0cmVlLmggIHwgIDIgKysNCj4gPiA+ICBmcy9idHJmcy9xZ3Jv
dXAuYyB8IDIwICsrKysrKysrKysrKysrKysrKy0tDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZnMvYnRyZnMvY3RyZWUuaCBiL2ZzL2J0cmZzL2N0cmVlLmgNCj4gPiA+IGluZGV4IGI0YTli
MWM1OGQyMi4uZmUyNzU2OTdlM2ViIDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvYnRyZnMvY3RyZWUu
aA0KPiA+ID4gKysrIGIvZnMvYnRyZnMvY3RyZWUuaA0KPiA+ID4gQEAgLTE0NSw2ICsxNDUsOCBA
QCBlbnVtIHsNCj4gPiA+ICAJQlRSRlNfRlNfU1RBVEVfRFVNTVlfRlNfSU5GTywNCj4gPiA+ICAN
Cj4gPiA+ICAJQlRSRlNfRlNfU1RBVEVfTk9fQ1NVTVMsDQo+ID4gPiArCS8qIFF1b3RhIGlzIGlu
IGRpc2FibGluZyBwcm9jZXNzICovDQo+ID4gPiArCUJUUkZTX0ZTX1NUQVRFX1FVT1RBX0RJU0FC
TElORywNCj4gPiA+ICB9Ow0KPiA+ID4gIA0KPiA+ID4gICNkZWZpbmUgQlRSRlNfQkFDS1JFRl9S
RVZfTUFYCQkyNTYNCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9xZ3JvdXAuYyBiL2ZzL2J0
cmZzL3Fncm91cC5jDQo+ID4gPiBpbmRleCA4OTI4Mjc1ODIzYTEuLjZmOTRkYTQ4OTZiYyAxMDA2
NDQNCj4gPiA+IC0tLSBhL2ZzL2J0cmZzL3Fncm91cC5jDQo+ID4gPiArKysgYi9mcy9idHJmcy9x
Z3JvdXAuYw0KPiA+ID4gQEAgLTExODgsNiArMTE4OCwxNyBAQCBpbnQgYnRyZnNfcXVvdGFfZGlz
YWJsZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCj4gPiA+ICAJbXV0ZXhfbG9jaygm
ZnNfaW5mby0+cWdyb3VwX2lvY3RsX2xvY2spOw0KPiA+ID4gIAlpZiAoIWZzX2luZm8tPnF1b3Rh
X3Jvb3QpDQo+ID4gPiAgCQlnb3RvIG91dDsNCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogUmVxdWVz
dCBxZ3JvdXAgcmVzY2FuIHdvcmtlciB0byBjb21wbGV0ZSBhbmQgd2FpdCBmb3IgaXQuIFRoaXMg
d2FpdA0KPiA+ID4gKwkgKiBtdXN0IGJlIGRvbmUgYmVmb3JlIHRyYW5zYWN0aW9uIHN0YXJ0IGZv
ciBxdW90YSBkaXNhYmxlIHNpbmNlIGl0IG1heQ0KPiA+ID4gKwkgKiBkZWFkbG9jayB3aXRoIHRy
YW5zYWN0aW9uIGJ5IHRoZSBxZ3JvdXAgcmVzY2FuIHdvcmtlci4NCj4gPiA+ICsJICovDQo+ID4g
PiArCWlmICh0ZXN0X2FuZF9zZXRfYml0KEJUUkZTX0ZTX1NUQVRFX1FVT1RBX0RJU0FCTElORywN
Cj4gPiA+ICsJCQkgICAgICZmc19pbmZvLT5mc19zdGF0ZSkpIHsNCj4gPiA+ICsJCXJldCA9IC1F
QlVTWTsNCj4gPiA+ICsJCWdvdG8gYnVzeTsNCj4gPiA+ICsJfQ0KPiA+ID4gKwlidHJmc19xZ3Jv
dXBfd2FpdF9mb3JfY29tcGxldGlvbihmc19pbmZvLCBmYWxzZSk7DQo+ID4gDQo+ID4gQWN0dWFs
bHkgeW91IGRvbid0IG5lZWQgdG8gaW50cm9kdWNlIGEgc2VwYXJhdGUgZmxhZyB0byBoYXZlIHRo
aXMgbG9naWMsDQo+ID4gc2ltcGx5IGNsZWFyIFFVT1RBX0VOQUJMRUQsIGRvIHRoZSB3YWl0LCBz
dGFydCB0aGUgdHJhbnNhY3Rpb24gLSBpbiBjYXNlDQo+ID4gb2YgZmFpbHVyZSBpLmUgbm90IGFi
bGUgdG8gZ2V0IGEgdHJhbnMgaGFuZGxlIGp1c3Qgc2V0IFFVT1RBX0VOQUJMRUQNCj4gPiBhZ2Fp
bi4gU3RpbGwsIG1vdmluZyBRVU9UQV9FTkFCTEVEIGNoZWNrIGluIHJlc2Nhbl9zaG91bGRfc3Rv
cCB3b3VsZCBiZQ0KPiA+IHVzZWZ1bCBhcyB3ZWxsLg0KPiANCj4gTmlrb2xheSwgdGhhbmsgeW91
IGZvciB0aGUgY29tbWVudC4NCj4gDQo+IFRoZSByZWFzb24gdG8gaW50cm9kdWNlIHRoZSBuZXcg
ZmxhZyBpcyB0aGF0IHFncm91cF9pb2N0bF9sb2NrLCB3aGljaCBndWFyZHMNCj4gUVVPVEFfRU5B
QkxFRCBzZXQgYnkgcXVvdGEgZW5hYmxlIGlvY3RsLCBpcyB1bmxvY2tlZCBkdXJpbmcgdGhlIHF1
b3RhIGRpc2FibGUNCj4gaW9jdGwgcHJvY2VzcyB0byBzdGFydCB0aGUgdHJhbnNhY3Rpb24uIFF1
b3RlIGZyb20gYnRyZnNfcXVvdGFfZGlzYWJsZSgpOg0KPiANCj4gCS4uLg0KPiAJbXV0ZXhfdW5s
b2NrKCZmc19pbmZvLT5xZ3JvdXBfaW9jdGxfbG9jayk7DQo+IA0KPiAJLyoNCj4gCSAqIDEgRm9y
IHRoZSByb290IGl0ZW0NCj4gCSAqDQo+IAkgKiBXZSBzaG91bGQgYWxzbyByZXNlcnZlIGVub3Vn
aCBpdGVtcyBmb3IgdGhlIHF1b3RhIHRyZWUgZGVsZXRpb24gaW4NCj4gCSAqIGJ0cmZzX2NsZWFu
X3F1b3RhX3RyZWUgYnV0IHRoaXMgaXMgbm90IGRvbmUuDQo+IAkgKg0KPiAJICogQWxzbywgd2Ug
bXVzdCBhbHdheXMgc3RhcnQgYSB0cmFuc2FjdGlvbiB3aXRob3V0IGhvbGRpbmcgdGhlIG11dGV4
DQo+IAkgKiBxZ3JvdXBfaW9jdGxfbG9jaywgc2VlIGJ0cmZzX3F1b3RhX2VuYWJsZSgpLg0KPiAJ
ICovDQo+IAl0cmFucyA9IGJ0cmZzX3N0YXJ0X3RyYW5zYWN0aW9uKGZzX2luZm8tPnRyZWVfcm9v
dCwgMSk7DQo+IA0KPiAJbXV0ZXhfbG9jaygmZnNfaW5mby0+cWdyb3VwX2lvY3RsX2xvY2spOw0K
PiAJLi4uDQo+IA0KPiBUaGVuIGV2ZW4gaWYgd2Ugd291bGQgY2xlYXIgUVVPVEFfRU5BQkxFRCBh
bmQgd2FpdCBmb3IgcWdyb3VwIHdvcmtlciBjb21wbGV0aW9uDQo+IGJlZm9yZSB0aGUgdHJhbnNh
Y3Rpb24gc3RhcnQsIFFVT1RBX0VOQUJMRUQgY2FuIGJlIHNldCBhZ2FpbiBieSBxdW90YSBlbmFi
bGUNCj4gaW9jdGwgYW5kIGFub3RoZXIgcWdyb3VwIHdvcmtlciBjYW4gc3RhcnQgYXQgdGhlIHBv
aW50IG9mIHRoZSB0cmFuc2FjdGlvbiBzdGFydC4NCj4gRXZlbiB0aG91Z2ggdGhpcyBzY2VuYXJp
byBpcyB2ZXJ5IHJhcmUgYW5kIHVubGlrZWx5LCBpdCBjYW4gaGFwcGVuLiBTbyBJTU8sIHdlDQo+
IGNhbiBub3QgcmVseSBvbiBRVU9UQV9FTkFCTEVEIHRvIHdhaXQgZm9yIHFncm91cCB3b3JrZXIg
Y29tcGxldGlvbi4NCg0KSSByZWxvb2tlZCBhdCBidHJmc19xdW90YV9lbmFibGUoKSBhbmQgYnRy
ZnNfcXVvdGFfZGlzYWJsZSgpIGFuZCBmb3VuZCB0aGF0IG15DQpyZXNwb25zZSBhYm92ZSBpcyB3
cm9uZy4gYnRyZnNfcXVvdGFfZW5hYmxlKCkgY2hlY2tzIGZzX2luZm8tPnF1b3RhX3Jvb3QgdG8g
c2VlDQppZiBxdW90YSBpcyBlbmFibGVkIG9yIG5vdC4gU28gd2hpbGUgUVVPVEFfRU5BQkxFRCBp
cyBjbGVhcmVkIGluIHF1b3RhIGRpc2FibGluZw0KcHJvY2VzcywgcXVvdGEgZW5hYmxlIGRvZXMg
bm90IHJ1biwgcmVnYXJkbGVzcyBvZiB0aGUgcWdyb3VwX2lvY3RsX2xvY2sgdW5sb2NrDQppbiBi
dHJmc19xdW90YV9kaXNhYmxlKCkuDQoNCldpdGggdGhpcywgTmlrb2xheSdzIHN1Z2dlc3Rpb24g
bG9va3MgdGhlIGdvb2QgaWRlYS4gV2lsbCByZXdvcmsgdGhlIHBhdGNoLg0KDQotLSANCkJlc3Qg
UmVnYXJkcywNClNoaW4naWNoaXJvIEthd2FzYWtp
