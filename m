Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF13E2316
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 07:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhHFFwz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 01:52:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16156 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhHFFwy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 01:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628229158; x=1659765158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+HdC093eDVkKtavgRaFRoLAFMBnmSPpCwtFAlz6pdI8=;
  b=mWPbHTaVn2S13mOxh02YXRGa4FO+g8/8JEIjUM80PvE8RzEPv28nyxSn
   biEvqy4uUdOJkUa/jFRjUcqXOXfXChTEBp/jbkDGZ7nj7LYlN1otu3UMv
   OCWJ6UOzKDq5OdIkWaPS8BTj/NxJOqtBJAjLuhY7Pgt5EagCIQuowZOKf
   Ji4bceHgs7QjDqV4dLx5jtAuU6kYFqSamHqbq79AK9lttIQyR1c4LLaje
   vGqzFHye/gY/ERXQJwfdpQKfP+vPuuMwdtNoMEmykMOGnBN2mUxsls8RS
   z4Brws+aHGbMryK2y3fr0qshakJkItIjmZRG0vGiKs25HqTkl+Ct5OfNk
   g==;
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="181287890"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 13:52:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSLvQAEmgcjdwmbTkXplXzHb8UsIEa3VNnOIsIsEmGOB7hg+Aq7bDiBus3lFSm/HripG3/MWmN1yJA9yv2CZ3ByNLVu1OCAuit9OFCXgFeE2R7ErXyR8ImI8SWC6bqnUJB2DqAhlGwbePL47hTQg9z9VcpTJiZNh4378ziRxjgmkL+ULzAGcY53qzj0In1ofSC0uYuwVqLq3AeEWK8lfwoIWBvbrlK0c3sQVEapvtkyAyF0Cpl9yMQWWGANtEuENOBS7/aYVX0tcTkxUejAf0r88fGaCQsUZ8T6TD2J0OQz9adXwNHIkmGi1SjS4CKUkUgKVl/ZQ3UAszekZNUrzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HdC093eDVkKtavgRaFRoLAFMBnmSPpCwtFAlz6pdI8=;
 b=l3l1JB20UvYNXUtxTsshJdIwWygBdxbXd6stfwHAYRNdAyBCQ90xd3/7OEafexeC1vBXAvg3H1NOJYUf6WlbDFZOhENG4Oc/tyN1ywISisBHP08WNBYxx6huzuKHbRSnnXWSJlkC43pSP2TFETY0Dj31RkivXe9RVmG04SSUalL4IEAvdNfaTqWRoILhMT+Ms68YZQ5fWUV2zzGdCVpOn9iy1JTaqsb9w1KApUErsq3hSYoPDCllyxCM+gWTXUstOopQEvPEdelO5TyIGYgmHR9h6y+kZKr96C9lIGDUyR2M8anl/+lTa0S9JkHSwDpn+b80jtab9TC5M+TTVOxSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HdC093eDVkKtavgRaFRoLAFMBnmSPpCwtFAlz6pdI8=;
 b=bIdSUHy8CChcYmGJ3JKgRFTwcz7Q11LPA29zuKWddGYPkeD04YF1RdFz+5o09rt5kPZrRRdGWwQ5lJ4LKKQiS2Qaeb8wtkBXSmsok21DK658yTJpRir+5+6cG/f+87GkYaj9JyiOX5uGj/H6ER7yxQBxKE4dkn+Yg4fngZS10G0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8273.namprd04.prod.outlook.com (2603:10b6:a03:3e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 6 Aug
 2021 05:52:37 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%5]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 05:52:37 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 3/7] btrfs: zoned: Use btrfs_find_item in
 calculate_emulated_zone_size
Thread-Topic: [PATCH 3/7] btrfs: zoned: Use btrfs_find_item in
 calculate_emulated_zone_size
Thread-Index: AQHXiWF8ceku70HQVU+E20D6AbX226tkdm2AgAGFUwA=
Date:   Fri, 6 Aug 2021 05:52:36 +0000
Message-ID: <20210806055236.hour3vgwgz7cphx2@naota-xeon>
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-4-mpdesouza@suse.com>
 <5f66b9cc-288b-3f26-ee36-9c2ce672c100@gmx.com>
In-Reply-To: <5f66b9cc-288b-3f26-ee36-9c2ce672c100@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 806a7017-a60c-4457-e2eb-08d9589e64f9
x-ms-traffictypediagnostic: SJ0PR04MB8273:
x-microsoft-antispam-prvs: <SJ0PR04MB8273F56FC2F307B6A487B4258CF39@SJ0PR04MB8273.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFYOp/DjR9+KVvyn6P5hsWIcatwyQhtJBFJlfjZVOhHVQvWf+q/et2DK9Bvd7RmNFsuyDUVBwLhPmVqVjc6HuJ1EjZqmNkKyhtdyAhu+jPVCnsocycOJAtoXkTNHKnZlbktSu8azD12H1NPUMo11WbL1Rg6KkrXiFh+JKwHQqY+7Nt5RXmS7Rz0eMVUXkpwb8z1WMXCbiJESwNNk///RyeCZNjnrOE+x8IUR0+D10XK5g3acwJoRKkQWjC1L09UcVQh/lgosDhY1mqjfqR8WAWazsKLdR41Zxp5bwwhV3acPxYAEvyKhbLJiE1kVpkG/lBzMInGLWop4Y28aiuQ9orE5ezDM6jQPiRJvOBa6cw4K8edBhiqActYULVbkiVBNGLbLdxpobpZSRmmFAgmuhoDAm4F0nLhEN6OCBw/cb8aXnvrEKW4hu0s0FJgax6KQ7u2U+ntZl2BFSAC7KiClIjfmmkeaeNQuNttNJcV4idSZMHfDNZbkXfSg7wvgTDybnrIaU1RXdySBZRt+iWpY03NMHoLo3K1C4y5tPEEuZ4BWWIW9O6ubOPRaqy6u3d6HuuEBdxMod0fPowVvTc8Ql+pvqwOhAkxNocTRPfb5EgtSKFobZaGjg0GwicCPlt9SVT/PDb+X9JIVHhmurPD8jSxUfrvdRgfyE3A+g4y9bjyUxZvrISJ+Cjayh8T78d+4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(396003)(376002)(39860400002)(346002)(136003)(86362001)(4326008)(38100700002)(64756008)(71200400001)(122000001)(316002)(83380400001)(91956017)(9686003)(66476007)(38070700005)(66446008)(66556008)(76116006)(54906003)(6512007)(66946007)(186003)(5660300002)(6486002)(8676002)(33716001)(1076003)(8936002)(26005)(6916009)(478600001)(2906002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y052dXFMaThnZGN5N1IvcnpvK25wa0NEQXdTOW8yOGpPd1lwOWNFeXJzSDZp?=
 =?utf-8?B?SEFZSlRXM29qeXliTDZCQ1RLUG9LeE5IVGZwRjVzeUUvWXFSc2FUb0ZvZXMx?=
 =?utf-8?B?L3Vhc3Iyc0ZuWlkxNUVjc0Vnc1ZYYjhKdVFsYXA0WFNsR3pxT0hza1RKTGJl?=
 =?utf-8?B?UEs1bFlzcVpHMk1BVWVIdkl2bC82bEFDRitHbUJGa1N0MHRtODZpTTdINGM2?=
 =?utf-8?B?dVF1QWV3VUt4dVFON2QwejdzQTZOMWQydmxIMmdwd1pWNTU1QktxeHRYRDVP?=
 =?utf-8?B?LzhZYkZ0Tk1YeWIyd010YnhXMG5yMUU4VDI3M0d4ZHRpYWdNWUNQY09iRVFT?=
 =?utf-8?B?aFNhS09EUU1FcEdQZFFWeTZqUUsxSmZHMndaM200eU9MUTgyY1JjUlMzWnlG?=
 =?utf-8?B?TFFucldvL003cWwwT2NaeGtOTGRibDlQQU8wQmtMNW9ReUpmUjFMQWhiTFFa?=
 =?utf-8?B?UG9GN3QvKzF6MHZHUVI3SmNuUjZHT2h5bjF5WC9MZ01MZ2FlVlZFWWg3bERk?=
 =?utf-8?B?SklaY2tjQm56QWg5WUZGdi9teUVQblpWV3hYN0hja2crVmNnemR3K3o3S0RM?=
 =?utf-8?B?eEo1djdheG5wb243WkNjUFpiRWVocGFzbVNrYWxOeVoram5ybTd4WkEyN0Ur?=
 =?utf-8?B?NW9rYUZDNjcwMlp0OWUwN0E3cXhVT2JadXFpaHdzTzIrTUZmeTRHM3F6QVlJ?=
 =?utf-8?B?MmNNZSttMEhLODgvV1ZDcHlxMGdOWjk5YXpYTlNwL3pQTXRYVU5NUnNjRCtt?=
 =?utf-8?B?aWg3V2RXditrcUQwZmdRV0RNajRrb1oweTVyNDZCUW44K1FGSlZ2SXAxamtF?=
 =?utf-8?B?WHpoclVGa1NLZ3dlYXFIZnJDeURac2VQSjNMK0hBM3VZcTVUcmczZWMrcEdi?=
 =?utf-8?B?YUNLYjFURnZCRDJsMEEzZGI1b25jNnJNZHdRQXdtbXRmYS96TUZOZXM1ZkVB?=
 =?utf-8?B?Y1JOVGJxb0NDS00yQVkwa2ZKV1VQZk9sNGtpek9FU3RseVBlZFZYVjJxMVF2?=
 =?utf-8?B?Y2JEL3ZVWWJjY3VUVU11c0hwVWkwaUR5WkFCVGdSWXRMWHhzZVRMclgxalN1?=
 =?utf-8?B?TjZnR2RsUjZBSDJEQ0w5NzFxRFlXbS9UUnpjOHZLdzV0aXBVQXAyN2xNWXM3?=
 =?utf-8?B?WllvRmJUL2t5N1hERlZ0R0NIa3oxWkJ2cDE4cGFMUzE0bDBlcE9NcCtNQlE5?=
 =?utf-8?B?R3BpSWlxMFBhWHRPSU1tdUhUTHI5VWw5bWE3RzF2bHlxQWh6TVY3OTIzRVVn?=
 =?utf-8?B?QXhLRlRtbDRxeENzMytUZHh5eHF4ZEthUVVoY0t0RGI5NVRQa0YvUkE1UHhu?=
 =?utf-8?B?enAyZ0U4Sm9HZ3VxWWJuRGhKL1BuZ2dSVWw3QW14L2p3M3l6dEo5Q0NPM0xq?=
 =?utf-8?B?MGF3ZXM4ZnNYWkJBalpXM3dMSUEzMlArckVmeDd6WEs5RTBEY3U1YlVQZDVM?=
 =?utf-8?B?eHJLTGFHZm9ucmtENUg2YnBCZFl5b0ZkamlBT3dUZ2R3MWg2OHBHY08xWFdV?=
 =?utf-8?B?Wk5LSEYvSmpOc1I1Z2MvdEcvM2k5QTErM0N5c2p0M3FjSS9xMFNUMGNlM2hJ?=
 =?utf-8?B?djd4YzZ6djQrZ3JlM2J3ZTVyMXUrZ2h5eDFHNEpRajdDNGRvamdxRE9JRnA3?=
 =?utf-8?B?bHNjU1lScnZLSllsZFAyY0FrZ1B1d0FLVGxrNk9ZN1dHNDBpZmlKOEM4Tm9n?=
 =?utf-8?B?MDNhbjJMQlNnYksrajFoMzZ3eDlXRW04S21IVjBHV1NVUWhCcCs2ZG5OL3RE?=
 =?utf-8?Q?fsV9UWdjDQ1A7uXffNzHvuRMFHpD2QN3ZNWHhN0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0FFEF7097C0564FB1CD95F169767EC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806a7017-a60c-4457-e2eb-08d9589e64f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 05:52:37.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQAMErXuIJHW1GwKVBFIPek99Nof3sLP5z/6EQN2J4PHXyoYb6Yx1Ir348aqINmwp0SoAb9wPJJXgaJ0rE7Atw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8273
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gVGh1LCBBdWcgMDUsIDIwMjEgYXQgMDI6Mzk6MDlQTSArMDgwMCwgUXUgV2VucnVvIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDIwMjEvOC81IOS4iuWNiDI6NDgsIE1hcmNvcyBQYXVsbyBkZSBTb3V6
YSB3cm90ZToNCj4gPiBjYWxjdWxhdGVfZW11bGF0ZWRfem9uZV9zaXplIGNhbiBiZSBzaW1wbGlm
aWVkIGJ5IHVzaW5nIGJ0cmZzX2ZpbmRfaXRlbSwgd2hpY2gNCj4gPiBleGVjdXRlcyBidHJmc19z
ZWFyY2hfc2xvdCBhbmQgY2FsbHMgYnRyZnNfbmV4dF9sZWFmIGlmIG5lZWRlZC4NCj4gPiANCj4g
PiBObyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY29z
IFBhdWxvIGRlIFNvdXphIDxtcGRlc291emFAc3VzZS5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTog
UXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+IA0KPiBCdXQgc2luY2Ugd2UncmUgaGVyZSwgc29t
ZSB1bnJlbGF0ZWQgY29tbWVudCBpbmxpbmVkIGJlbG93Lg0KPiA+IC0tLQ0KPiA+ICAgZnMvYnRy
ZnMvem9uZWQuYyB8IDIxICsrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2ZzL2J0cmZzL3pvbmVkLmMgYi9mcy9idHJmcy96b25lZC5jDQo+ID4gaW5kZXggNDdhZjFh
YjNiZjEyLi5kMzQ0YmFhMjZkZTAgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvYnRyZnMvem9uZWQuYw0K
PiA+ICsrKyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4gPiBAQCAtMjMwLDI5ICsyMzAsMjAgQEAgc3Rh
dGljIGludCBjYWxjdWxhdGVfZW11bGF0ZWRfem9uZV9zaXplKHN0cnVjdCBidHJmc19mc19pbmZv
ICpmc19pbmZvKQ0KPiA+ICAgCXN0cnVjdCBidHJmc19rZXkga2V5Ow0KPiA+ICAgCXN0cnVjdCBl
eHRlbnRfYnVmZmVyICpsZWFmOw0KPiA+ICAgCXN0cnVjdCBidHJmc19kZXZfZXh0ZW50ICpkZXh0
Ow0KPiA+IC0JaW50IHJldCA9IDA7DQo+ID4gLQ0KPiA+IC0Ja2V5Lm9iamVjdGlkID0gMTsNCj4g
DQo+IE5vdCByZWxhdGVkIHRvIHRoaXMgcGF0Y2ggaXRzZWxmLCBidXQgdGhpcyBpbW1lZGlhdGUg
bnVtYmVyIGlzIG5vdCB0aGF0DQo+IHN0cmFpZ2h0Zm9yd2FyZC4NCj4gDQo+IEluIGZhY3QgZm9y
IERFVl9FWFRFTlRfS0VZLCB0aGUgb2JqZWN0aWQgbWVhbnMgZGV2aWNlIG51bWJlci4NCj4gDQo+
IEZvciBjdXJyZW50IHpvbmVkIGRldmljZSBzdXBwb3J0IElJUkMgd2Ugb25seSBzdXBwb3J0IHNp
bmdsZSBkZXZpY2UsDQo+IHRodXMgaXQncyBmaXhlZCB0byAxLg0KDQpUbyBiZSBwcmVjaXNlLCB3
ZSBjYW4gaGF2ZSBtdWx0aXBsZSBkZXZpY2VzLCBidXQgb25seSBzdXBwb3J0IHNpbmdsZQ0KcHJv
ZmlsZS4NCg0KPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gaGF2ZSBzb21lIGV4dHJhIGNvbW1lbnQv
QVNTRVJUKCkgZm9yIGl0Lg0KPiANCj4gDQo+ID4gLQlrZXkudHlwZSA9IEJUUkZTX0RFVl9FWFRF
TlRfS0VZOw0KPiA+IC0Ja2V5Lm9mZnNldCA9IDA7DQo+IA0KPiBOb3JtYWxseSBmb3IgREVWX0VY
VEVOVF9LRVksIHRoZSBvZmZzZXQgaXMgdGhlIGRldiBwaHlzaWNhbCBvZmZzZXQsDQo+IHdoaWNo
IG5vcm1hbGx5IGlzIG5vdCAwIChhcyB3ZSByZXNlcnZlIDB+MU0gZm9yIGVhY2ggZGV2aWNlKQ0K
PiANCj4gU28gdGhpcyBpcyBhIHNwZWNpYWwgem9uZWQgb24tZGlzayBmb3JtYXQ/DQoNCldlIGFs
c28gcmVzZXJ2ZSB0aGUgZmlyc3QgdHdvIHpvbmVzIG9uIGEgZGlzayBmb3Igc3VwZXJibG9jayBs
b2cNCnpvbmVzLCBzbyBvbiB0eXBpY2FsIFNNUiBkcml2ZSwgMC01MTJNIGlzIHJlc2VydmVkLg0K
DQpXZSBjYW4gdXNlIGFueSBERVZfRVhURU5UIGl0ZW0gaGVyZSB0byBkZXRlcm1pbmUgdGhlIGVt
dWxhdGVkIHpvbmUNCnNpemUuIFNvLCBpdCdzIHRyeWluZyB0byBmaW5kIHRoZSBmaXJzdCBvbmUu
DQoNCj4gVGhhbmtzLA0KPiBRdQ0KPiANCj4gPiArCWludCByZXQ7DQo+ID4gDQo+ID4gICAJcGF0
aCA9IGJ0cmZzX2FsbG9jX3BhdGgoKTsNCj4gPiAgIAlpZiAoIXBhdGgpDQo+ID4gICAJCXJldHVy
biAtRU5PTUVNOw0KPiA+IA0KPiA+IC0JcmV0ID0gYnRyZnNfc2VhcmNoX3Nsb3QoTlVMTCwgcm9v
dCwgJmtleSwgcGF0aCwgMCwgMCk7DQo+ID4gKwlyZXQgPSBidHJmc19maW5kX2l0ZW0ocm9vdCwg
cGF0aCwgMSwgQlRSRlNfREVWX0VYVEVOVF9LRVksIDAsICZrZXkpOw0KPiA+ICAgCWlmIChyZXQg
PCAwKQ0KPiA+ICAgCQlnb3RvIG91dDsNCj4gPiANCj4gPiAtCWlmIChwYXRoLT5zbG90c1swXSA+
PSBidHJmc19oZWFkZXJfbnJpdGVtcyhwYXRoLT5ub2Rlc1swXSkpIHsNCj4gPiAtCQlyZXQgPSBi
dHJmc19uZXh0X2xlYWYocm9vdCwgcGF0aCk7DQo+ID4gLQkJaWYgKHJldCA8IDApDQo+ID4gLQkJ
CWdvdG8gb3V0Ow0KPiA+IC0JCS8qIE5vIGRldiBleHRlbnRzIGF0IGFsbD8gTm90IGdvb2QgKi8N
Cj4gPiAtCQlpZiAocmV0ID4gMCkgew0KPiA+IC0JCQlyZXQgPSAtRVVDTEVBTjsNCj4gPiAtCQkJ
Z290byBvdXQ7DQo+ID4gLQkJfQ0KPiA+ICsJLyogTm8gZGV2IGV4dGVudHMgYXQgYWxsPyBOb3Qg
Z29vZCAqLw0KPiA+ICsJZWxzZSBpZiAocmV0ID4gMCkgew0KPiA+ICsJCXJldCA9IC1FVUNMRUFO
Ow0KPiA+ICsJCWdvdG8gb3V0Ow0KPiA+ICAgCX0NCj4gPiANCj4gPiAgIAlsZWFmID0gcGF0aC0+
bm9kZXNbMF07DQo+ID4g
