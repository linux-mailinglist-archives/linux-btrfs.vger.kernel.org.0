Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D2E3E42D6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhHIJf0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 05:35:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22039 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhHIJfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 05:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628501704; x=1660037704;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Nq6il2agB/CUE3KN1w4wBn2eb/H2Fr/cLrHA2inwUog=;
  b=EP/m6i13hoXN7DIMm3PP9RRUnnc53UjjG8370jFxuMx95JGUCNoZXB7L
   GorohXLxJfr28hkwsgqRmaYvyU68+Tx5ZRt7dkbid8kegKgIRRbiTQi3U
   5O9I7kktJBgnnj8Lyp9IkjjptuBNqQoRNcMR/ORIBIcFkZxVskyYur5yA
   C7s15M/+xUlvRQIz4Nyr1g1dUvJhIgrz8mATgc3+wEdRxC4MOoBAYAm+V
   MueOJYciX9uPaxn+IJ2PKvwTWoK9zxNDF/O+QEmNSDqT1lyNcIs9Fjg2V
   9pGnSUPU1QGNYTanhpYxbGhGxrw3zUYiXGw4nFnBK8mTK5drsRMC+98U5
   g==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="181483592"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 17:35:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdPd0fq77GZnIJ27C/jTq2J39qc8HgAveHbaZlf1oAuKwFiS9fTEzzCV/8I8kc3vReQcoA1MPLQkpMmltlKfgCX0tuGcC06jZoZCPevH9D/SxGAxU0J7jxtCiYZ58Sh9sJE+AKmkmffPnwv7Qw5Q4KdVt5SjX7NJu2vWTEOh9JfPIAKmvQgEUfGU2xwtODgYDXMHJL7LaRTq5dFJ3E0CtHj1M3UWMCqm73NKrTyTspGzKz2glGArbv4KSKHK2JIbWucWxmpTgorcmQS1qS4XuyfIALD/xB7oUIDNhpjfnTvFte1xvIcSpFen0L2f0pk0bm/beftrrvkM5+j/5GYsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq6il2agB/CUE3KN1w4wBn2eb/H2Fr/cLrHA2inwUog=;
 b=To7Ha86dn8S9hfrisVn1jbgYczrnzAegBNs9L3IvVigGchDolfbSoYbb113k5pRKkQVLJ0ij89LSH/MM1YSMqHaei1CMcv8Zu4S4XrE5iCXclD/TEDxCks/9QwSl/xrlthM9AEX2G+yZ44xo/O8grPO24e3zuFvZYcLt894PrXP0km9W0ULvgo7GNGxFd8yA9ExUE9wkFGf1nCReGWwlistEZV4wMXVrgkxuOgrUszRkBmjOU6YHFtBNwUFPhoDjEQvIRdWjn0R5Q6S82JlKwmTEBC0NpSWn686E1jA9A95VcB4xQjwYyFhV7XrBylJmYTXo6vZn0Qk3AAsMrgjm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq6il2agB/CUE3KN1w4wBn2eb/H2Fr/cLrHA2inwUog=;
 b=PgIwYpZHAHnEGCWXe+U3v2Im8r0p7LILsVc39pwIA5EoNHUxIBsEe6HGvuNLdKyEypO9zJ/RzOYLeDxjnvFOP7NZvdKoz5L+eBxzOSiocVNLl55dIDYCwyoGBieoGgEHNlYgxpa+yAYzlLKb+UdQ1Y8Ah27wQEFtWA3tHRQpq/A=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4139.namprd04.prod.outlook.com (2603:10b6:5:98::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 09:35:03 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 09:35:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Aleksey Utkin <aleksey.utkin@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: Cannot mount hm-smr drive with btrfs
Thread-Topic: Cannot mount hm-smr drive with btrfs
Thread-Index: AQHXhUcnzopJ+eu+30OrtH1F8mwgEg==
Date:   Mon, 9 Aug 2021 09:35:03 +0000
Message-ID: <DM6PR04MB7081A5B19ABF2F8A5C2E4D8CE7F69@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <66714993-3927-8fc7-585b-398b8e4dc655@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db37e531-05d8-4b24-05e0-08d95b18f762
x-ms-traffictypediagnostic: DM6PR04MB4139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB41399BBE2175915D6C7FF7AEE7F69@DM6PR04MB4139.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgsYgEfMF1VAfZNsr7UYhQN+nNwDFsxBqVfjQdC2EPQTCmpys4j+8vdj5EDrI12Nm26oPLsNopLWhTzkwJTsbT6xdo3r/D0lk7vPNflA3pGHVaWk3D46PqdGKtF5i3OuLURG/wUrtS8uifYBOvSOidjc+trTAdbuantMuxf9st29WsU180RvKxba4yVlqsSShP6l2yrLTpuXgOe33IRyerWARSxqSnapci2QM5TwhjyA603lji2/iG4ZSKYcMqyAiV98Zu31vPPVTM3wPUGKnoiFuv19bOc95ClCQWl5VhvIcmKuh74KvgwVZxYEtxUu+9d4YtgMZCVWefHo2K4bbre5qCb0ytb+Ih1UHjHnJKlnoif4/msbJqba5/tlyNK0SVuApN89luCqi4ikKMMYC2h+n9O0WcM0R+vndaytVsrfsc8MDx6Xzhh/XBKeZGhg547UO5tm9KS8OK7tsNJw+vVDYifdm/QOx4mb85EV9TVKcM9daqLOWwwmUFuVqa4Ysy0QSfqVTiIZ+4Jbaku0JwqUZLpegbAEkN8/kDnCq3TODF5uhTTpnngA+VD4MHBuqdSK0L8hiBeWAn8coNF1GRfZBHwS5h2mna0RtOeHDuIi6cOCpMEysMpLprT6SvZvl4Bo/TR2M5Am0ZIYVGuFRaAPTlpJ/p2jY/FcGroo7keCQglIXXU5trIu4o4Vc0cMo4HkZn2s43hLjLlacxw7mTMp9vgXTgD2X+YOPrIofvdigVAf7BCG3kQ2x0YpsTUhqibIRc1otPrnWXPJn3Ipypt5zu7Jgdl/UXErqaqwSfET67+dKbmLqPVUxR5c1RT0Tw0xVYpY+ozGuTVNwsdp7ThUHFR1y9Ifily+QTe2nZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(66946007)(76116006)(186003)(86362001)(66476007)(66556008)(64756008)(66446008)(4001150100001)(966005)(8936002)(5660300002)(71200400001)(8676002)(4326008)(2906002)(508600001)(52536014)(15974865002)(83380400001)(122000001)(38100700002)(6506007)(53546011)(55016002)(38070700005)(33656002)(9686003)(7696005)(54906003)(110136005)(316002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXFKYmJCQ2pCYWR6bDRqSGdqNmxTbEJPTzdaYzlOUExJZXlYeFMzaTM2R3hp?=
 =?utf-8?B?ZGw5NWRUdlVTTk5TcVZGOU53UUN2OWZQeE5hd1NrMUcyZGRrSEFGQVYxMjN4?=
 =?utf-8?B?UWRKWjJvdFFKRnNkbVFaZ0V1NHVETUl0VTdSVVN0VDN6bDJZTmh1RDBjckpV?=
 =?utf-8?B?V1RLNENyRUh1OTlJUVA1VkFpS1FZUjRRb3pGSmV6Z0U4UFJsVlpJRUpDZ091?=
 =?utf-8?B?Vnp2MC9BQ3BNSEdUbU9MYllMMC9JYmZRL01QM01iZ2pQNnhXNjFLVHI3b0F1?=
 =?utf-8?B?WkFmOUxRSEhodlRoYzhvK1ZZb29LcHVkV0pEbDRwcmF5eHlWVFQ4cDZMS0Vm?=
 =?utf-8?B?aGhHa01rdDFsQ3hyZVVxOFB4R1hxbXMxbG9qcERRMCt2Tit1dm5ucm5keEJV?=
 =?utf-8?B?amxHNkxlQmtoTUF5RG5lN0VNNFdUMElYOEJsbmZCWnBYNlBQclc5cjJHUzhv?=
 =?utf-8?B?MGp3c256OHBzR3A0WkxabFJSekQwZEsxaFVOYUNwM0hzSlNUQWJzMGt2TEJa?=
 =?utf-8?B?WTVldTAvcXcvckwyenRJWm8wb3NtR0xnZW80dWd0blJIYjlNOWJKb0VBenVp?=
 =?utf-8?B?L0I5d0t4M2tiOGN6b1Jtb0h3cjJ4YUFsL0lMWUQ2VktlYkl5RUk3VXZLTSt1?=
 =?utf-8?B?V1dWbUhmZTg4aWNOby81eDR0VG9wNEZqWHBucXhjZHFzMElDc0pvSVU1Mzc2?=
 =?utf-8?B?L3Y3cWRQTHV3Qm9QRklMek5lcWpTV3NhaWQyaXlaM01ab0pyN1A1cEE5c0tw?=
 =?utf-8?B?eDVIM210UktEZGRsT3V0NU44VVZkRDF5K1FHMGhlKzJKOVQzTnl2UTJSeE4z?=
 =?utf-8?B?VGt6czVSa1hhemlseXlQYVVBZnhVNzQ2V3hSWDVlbGVHYytsN0Vmb0ZkQVd4?=
 =?utf-8?B?ZnhBVU85ckpLNXRkZVg3ZnloYXdOS2pRR1hMeFdEeGlQU2xGVVdEM01ucEZs?=
 =?utf-8?B?OEtuUTcwNTBBRTRwT3RDeVhhcVI4NTltUUl2bHlTQlZzOE1wOTVHU2hDYXJQ?=
 =?utf-8?B?VDdzNW9jN21sYk9iZTNrK01YcnU3QzVtdXdITWRQTlE3Q2pnZk1uMXBTanpT?=
 =?utf-8?B?MnV6bDJTbEx5ZFFtRnUzaThmdmNXSkZ5TmdyMFdWVmlwVEFRUG9BUmVmNHM3?=
 =?utf-8?B?dkFOTWFvWlRYaTdGbnQybk9mWld6dmZ6WmRxMDNLZis0bEsya2FlVWlOWEM2?=
 =?utf-8?B?NUZmZXovUFNGQ2wycnU2NXpBZ3FFcWZ5WXBBNVZRWWRIblZxVzlkQ1BmdW9u?=
 =?utf-8?B?ejg2RXdkWmNBODJ6SkZtRFlFMnd4aEFYbU5ib3Y3a2hvenlVWGtPbFpRaHQr?=
 =?utf-8?B?elNnZVlVSmRTcWhTd0d3Y2xFeWlobU1RRGtObTcyU0UxMjYzWnpMZ05tdDlC?=
 =?utf-8?B?T0ZqbENwdU50Ym9FQ1M2WVBOcUdOMlhuVVdiQy9MdUhkTmF1RHlrSit1S0Ft?=
 =?utf-8?B?bERCUlp2eC9sNmQ0cG1ma3dSV214bSs0UDNzV2VwTjJ4c2FDNjByS0prbitm?=
 =?utf-8?B?STI4WXk1Rm05NCtvTndncXgxVXQ5clI2eEpFVHRnTE0ySS82Mzg1S3U0clJK?=
 =?utf-8?B?b2dLMU05RXc2MkFDZHRwT1hmUlBGRGNMKzNFZ3BsbHp6SDI4NEVDcVM4OEVz?=
 =?utf-8?B?ZWQxRStHOHJnWkRya3ZBNXRZc1lmQ2RGU1lEZCt5NFQ0WHpZVmZCS0lrSTZG?=
 =?utf-8?B?U1hRdXVxYk1vSXQwRGw4RHdaZkpMVWU1VXFuT25YQU9VWERSOVd0c1FnRGpI?=
 =?utf-8?B?R0hLbUF0NDkrYTZTRzgwRGxoWS94bmVlcEZHaSt2L3lZWmxyUjJnenprUnc5?=
 =?utf-8?B?aFdza3hxeHMySlVVWWR6Unc5NkN6YXRpclNDUVZJL3ltWnUxT3ZLbHJEVlVY?=
 =?utf-8?B?WGhucldmQ0JhUDNuRmdBR0VGeHQ4S3J6QW5paTM2bk9KMHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db37e531-05d8-4b24-05e0-08d95b18f762
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 09:35:03.6090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLh7IKvKIWMnPWAeWxe45EojZKGzbqSgxKSSfx8f/Pa9fjYu6Wj98N8XFSu5W09vIX4UsFfq4DKUyAP1UdA6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4139
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjAyMS8wNy8zMCAyMjozMSwgQWxla3NleSBVdGtpbiB3cm90ZToKPiBIZWxsby4KPiAKPiAK
PiBJIGhhZCBhIHByb2JsZW0gd2l0aCB0aGUgbW91bnRpbmcgb2YgdGhlIEJUUkZTIGZpbGUgc3lz
dGVtLgo+IAo+IFRlc3QgY2FzZSBkZXNjcmlwdGlvbjoKPiAKPiAxLiBPcGVyYXRpb246IENyZWF0
aW5nIGJ0cmZzOiBzdWRvIG1rZnMuYnRyZnMgLU8gem9uZWQgLWQgc2luZ2xlIC1tIAo+IHNpbmds
ZSAtZiAvZGV2L3NkYgo+IFJlc3VsdDogVGhlIGZpbGUgc3lzdGVtIHdhcyBjcmVhdGVkIHN1Y2Nl
c3NmdWxseQo+IAo+IDIuIE9wZXJhdGlvbjogTW91bnQgbmV3IGJ0cmZzOiBzdWRvIG1vdW50IC9k
ZXYvc2RiIC9tbnQvc2RiCj4gUmVzdWx0OiBNb3VudGVkIHN1Y2Nlc3NmdWxseQo+IAo+IDMuIE9w
ZXJhdGlvbjogRmlsbGluZyBhIGZpbGUgc3lzdGVtIGRhdGEgc3lzdGVtIChjb3B5IHVzaW5nIE1D
KQo+IFJlc3VsdDogRmlsbGluZyBhIGZpbGUgc3lzdGVtIGRhdGEgaGFzIHBhc3NlZCBzdWNjZXNz
ZnVsbHksIHRoZSBkYXRhIGhhcyAKPiBwYXNzZWQgaW50ZWdyaXR5IGNvbnRyb2wKPiAKPiA0LiBP
cGVyYXRpb246IFVtb3VudCBmaWxlIHN5c3RlbTogc3VkbyB1bW91bnQgL21udC9zZGIvCj4gUmVz
dWx0OiBVbW91bnRlZCBzdWNjZXNzZnVsbHkKPiAKPiA1LiBPcGVyYXRpb246IE1vdW50IGJ0cmZz
OiBzdWRvIG1vdW50IC9kZXYvc2RiIC9tbnQvc2RiCj4gUmVzdWx0OiBNb3VudGVkIHN1Y2Nlc3Nm
dWxseQo+IAo+IDYuIE9wZXJhdGlvbjogcmVib290ZWQgdGhlIGhvc3Qgd2l0aCBtb3VudGVkIGZp
bGUgc3lzdGVtIEJUUkZTCj4gUmVzdWx0OiBSZWJvb3Qgc3VjY2Vzc2Z1bGx5Cj4gCj4gNy4gT3Bl
cmF0aW9uOiBDaGVja2luZyB0aGUgYnRyZnMgZmlsZSBzeXN0ZW06IHN1ZG8gYnRyZnMgY2hlY2sg
L2Rldi9zZGIKPiBSZXN1bHQ6IHN1Y2Nlc3NmdWxseSwgY29uc29sZSBvdXRwdXQ6Cj4gT3Blbmlu
ZyBmaWxlc3lzdGVtIHRvIGNoZWNrLi4uCj4gQ2hlY2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L3Nk
Ygo+IFVVSUQ6IDQzMTJiZjJhLTM3NmQtNGE0NC1hNjlhLTZiYjExMmIxMjRmNgo+IFsxLzddIGNo
ZWNraW5nIHJvb3QgaXRlbXMKPiBbMi83XSBjaGVja2luZyBleHRlbnRzCj4gWzMvN10gY2hlY2tp
bmcgZnJlZSBzcGFjZSBjYWNoZQo+IFs0LzddIGNoZWNraW5nIGZzIHJvb3RzCj4gWzUvN10gY2hl
Y2tpbmcgb25seSBjc3VtcyBpdGVtcyAod2l0aG91dCB2ZXJpZnlpbmcgZGF0YSkKPiBbNi83XSBj
aGVja2luZyByb290IHJlZnMKPiBbNy83XSBjaGVja2luZyBxdW90YSBncm91cHMgc2tpcHBlZCAo
bm90IGVuYWJsZWQgb24gdGhpcyBGUykKPiBmb3VuZCAxNzk3ODA1NjQ0MTg1NiBieXRlcyB1c2Vk
LCBubyBlcnJvciBmb3VuZAo+IHRvdGFsIGNzdW0gYnl0ZXM6IDE3NTM0MzQzMjgwCj4gdG90YWwg
dHJlZSBieXRlczogMjI4ODg5MjMxMzYKPiB0b3RhbCBmcyB0cmVlIGJ5dGVzOiAyMTkxNDkxMDcy
Cj4gdG90YWwgZXh0ZW50IHRyZWUgYnl0ZXM6IDIxNjY1NTQ2MjQKPiBidHJlZSBzcGFjZSB3YXN0
ZSBieXRlczogOTkwMDQ3Mjc0Cj4gZmlsZSBkYXRhIGJsb2NrcyBhbGxvY2F0ZWQ6IDE3OTU1MTY3
NTE4NzIwCj4gIMKgcmVmZXJlbmNlZCAxNzk1NTE2NzUxODcyMAo+IAo+IDguIE9wZXJhdGlvbjog
QXR0ZW1wdCB0byBtb3VudCAxOiBzdWRvIG1vdW50IC9kZXYvc2RiIC9tbnQvc2RiCj4gUmVzdWx0
OiBNb3VudGVkIHVuc3VjY2Vzc2Z1bCwKPiBDb25zb2xlIG91dHB1dDogbW91bnQ6IC9tbnQvc2Ri
OiB3cm9uZyBmcyB0eXBlLCBiYWQgb3B0aW9uLCBiYWQgCj4gc3VwZXJibG9jayBvbiAvZGV2L3Nk
YiwgbWlzc2luZyBjb2RlcGFnZSBvciBoZWxwZXIgcHJvZ3JhbSwgb3Igb3RoZXIgZXJyb3IuCj4g
Cj4gOS4gT3BlcmF0aW9uOiBBdHRlbXB0IHRvIG1vdW50IDI6IHN1ZG8gbW91bnQgLXQgYnRyZnMg
L2Rldi9zZGIgL21udC9zZGIKPiBSZXN1bHQ6IHVuc3VjY2Vzc2Z1bCwgbm8gbWVzc2FnZXMsIHRo
ZSBIREQgYWN0aXZpdHkgTEVEIGlzIGdsb3csIHRoZSAKPiBjb25zb2xlIGZyb3plbiwgXkMgZG9l
cyBub3QgaW50ZXJydXB0IHRoZSBtb3VudCBvcGVyYXRpb24sIHRoZSBzdWRvIAo+IHJlYm9vdCBp
cyBub3QgcGVyZm9ybWVkLCB0aGUgcmVzdGFydCBvZiBBbHQrUFJUU0NSK0IgaXMgcGVyZm9ybWVk
Lgo+IAo+IFZlcnNpb24gb2YgdGhlIGtlcm5lbDoKPiAkIHVuYW1lIC1hCj4gTGludXggeDc5emQz
IDUuMTQuMC0wNTE0MDByYzItZ2VuZXJpYyAjMjAyMTA3MTgyMjMwIFNNUCBTdW4gSnVsIDE4IAo+
IDIyOjM0OjEyIFVUQyAyMDIxIHg4Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAo+IAo+ICQg
YnRyZnMgLS12ZXJzaW9uCj4gYnRyZnMtcHJvZ3MgdjUuMTMKPiBmcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9rZGF2ZS9idHJmcy1wcm9ncwoKRGlkIHlvdSBhbHNvIGluc3RhbGwgdGhlIGxhdGVzdCBs
aWJibGtpZCBmcm9tIHV0aWwtbGludXggdHJlZSA/IFRoZXJlIGFyZQptb2RpZmljYXRpb25zIHRv
IGl0IGZvciB6b25lZCBidHJmcyB0byBmaW5kIHRoZSBzdXBlciBibG9jay4gVGhlc2UgbW9kaWZp
Y2F0aW9ucwphcmUgbm90IHlldCBpbiBhbnkgdGFnZ2VkIHZlcnNpb24gb2YgbGliYmxraWQgYnV0
IHRoZXkgYXJlIGluIHRoZSBtYXN0ZXIgYnJhbmNoCm9mIHRoZSB1dGlsLWxpbnV4IHRyZWUgdXBz
dHJlYW0uCgo+IAo+ICQgYnRyZnMgZmkgc2hvdwo+IG5vdGhpbmcgb3V0cHV0Cj4gCj4gJCBidHJm
cyBmaSBkZiAvbW50L3NkYgo+IEVSUk9SOiBub3QgYSBidHJmcyBmaWxlc3lzdGVtOiAvbW50L3Nk
Ygo+IAo+IERldmljZToKPiAkIHN1ZG8gc21hcnRjdGwgLWkgL2Rldi9zZGIKPiBzbWFydGN0bCA3
LjIgMjAyMC0xMi0zMCByNTE1NSBbeDg2XzY0LWxpbnV4LTUuMTQuMC0wNTE0MDByYzItZ2VuZXJp
Y10gCj4gKGxvY2FsIGJ1aWxkKQo+IENvcHlyaWdodCAoQykgMjAwMi0yMCwgQnJ1Y2UgQWxsZW4s
IENocmlzdGlhbiBGcmFua2UsIHd3dy5zbWFydG1vbnRvb2xzLm9yZwo+IAo+ID09PSBTVEFSVCBP
RiBJTkZPUk1BVElPTiBTRUNUSU9OID09PQo+IERldmljZSBNb2RlbDrCoMKgwqDCoCBTVDE4MDAw
Tk0wMDlKLTJVVzEwMQo+IFNlcmlhbCBOdW1iZXI6wqDCoMKgIFpMMkJINTNMCj4gTFUgV1dOIERl
dmljZSBJZDogNSAwMDBjNTAgMGM4MTJiZjY0Cj4gRmlybXdhcmUgVmVyc2lvbjogU0UwMQo+IFVz
ZXIgQ2FwYWNpdHk6wqDCoMKgIDE44oCvMDAw4oCvMjA34oCvOTM34oCvNTM2IGJ5dGVzIFsxOCww
IFRCXQo+IFNlY3RvciBTaXplczrCoMKgwqDCoCA1MTIgYnl0ZXMgbG9naWNhbCwgNDA5NiBieXRl
cyBwaHlzaWNhbAo+IFJvdGF0aW9uIFJhdGU6wqDCoMKgIDcyMDAgcnBtCj4gRm9ybSBGYWN0b3I6
wqDCoMKgwqDCoCAzLjUgaW5jaGVzCj4gRGV2aWNlIGlzOsKgwqDCoMKgwqDCoMKgIE5vdCBpbiBz
bWFydGN0bCBkYXRhYmFzZSBbZm9yIGRldGFpbHMgdXNlOiAtUCBzaG93YWxsXQo+IEFUQSBWZXJz
aW9uIGlzOsKgwqAgQUNTLTQgKG1pbm9yIHJldmlzaW9uIG5vdCBpbmRpY2F0ZWQpCj4gU0FUQSBW
ZXJzaW9uIGlzOsKgIFNBVEEgMy4zLCA2LjAgR2IvcyAoY3VycmVudDogMy4wIEdiL3MpCj4gTG9j
YWwgVGltZSBpczrCoMKgwqAgRnJpIEp1bCAzMCAxNDo0NzozMyAyMDIxIE1TSwo+IFNNQVJUIHN1
cHBvcnQgaXM6IEF2YWlsYWJsZSAtIGRldmljZSBoYXMgU01BUlQgY2FwYWJpbGl0eS4KPiBTTUFS
VCBzdXBwb3J0IGlzOiBFbmFibGVkCj4gCj4gIyBuYyBjd2lsbHUuY29tIDEwMTAxIDwgL2Rldi9r
bXNnCj4gYWZ0ZXIgb3BlcmF0aW9ucyA2LDcsOCw5IC0gaHR0cDovL2N3aWxsdS5jb206ODA4MC8x
MjguMC4xNDEuNDcvMgo+IAo+ICQgc3VkbyBkbWVzZyB8IG5jIHRlcm1iaW4uY29tIDk5OTkKPiBo
dHRwczovL3Rlcm1iaW4uY29tLzZnNTQKPiAKPiAKPiBCZXN0IHJlZ2FyZHMsCj4gQWxla3NleSBV
dGtpbgo+IAo+IAo+IAo+IAoKCi0tIApEYW1pZW4gTGUgTW9hbApXZXN0ZXJuIERpZ2l0YWwgUmVz
ZWFyY2gK
