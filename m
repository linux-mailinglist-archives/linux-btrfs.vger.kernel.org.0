Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4F41C2A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbhI2KYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 06:24:49 -0400
Received: from mail-me3aus01on2059.outbound.protection.outlook.com ([40.107.108.59]:37431
        "EHLO AUS01-ME3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245325AbhI2KYr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 06:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx07ujdz4oQnYdS98I31MgLyIbCB5UQwFfbOlLFUsy7egExVOCb9eYwaVyw7AV+7VuNANPU+BUx18JIEEcK+IKRtxBhCFMpLKYKgPgINpO9Jv61s4AsSYQBZ6e66SM1enJIGUAnbgdhAxS05aWOovXmtWG9HigHGZEPSyXrvDXfs/t7Aoi5ELURWppAjHV/1oM//nLmr4S9c7ejzuMkNlzvFA9zkhQc0K3XTCH4/d2oNO+KligW7laUSdZU4q1W7d9b+Z9jXQnHoQ9b/bH0kKLXUGA0Tq93RcM+FSYqCIldicGQFVGJvoAkN7WQLdVZdSRiMNrb9MhvuzmwxAFgZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uhNlL7aVhkSo+xLAI4DuWkX+a29R0/iA/AWSAQO1ehI=;
 b=AiPyRr1Hks6AOtcNQ2Wm0oHkg9odE6RbVJ8fI1veftD3Wd8N1ynR7FcWmWvqDPDOlL1gu2W2Qq66izudKzjY364+L1UV1dbhDC4+1dwOQmSc8FO5RkO/nbhaNqmMOOo/u7i+lVvw+aJUiiedRc3/rEVaFBGkAVhGdOc8sexUNentu3ecs7QK0eRdsqszBfHekOHlLD0lHllnzPGfBXabqDscnk7UEQT7BIm6krzhIySjHD+HuJLXV4AmbMAs28SFvhrbBDTRb2urgKQnM7HVmMg1fgxlIDJ30N7drHHSGu+8xSA4M2vL9UJvsEZnzc5TwlUUiF8kRv3M8VPlVzwRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhNlL7aVhkSo+xLAI4DuWkX+a29R0/iA/AWSAQO1ehI=;
 b=LrH2XmtrzrgTnzCbC2AzYuVoMFcaUARbqq61dEEUsupu61aQPaF6hKIF8VSG7lexLUA5ASvTewnIRNzY72OfLg40ywG/+MX0N/wScCTik4Hm13y1KsJxmatpevZyWerZtvVo03EVScc9lH7KfY6KUztXkWuhy1xT8B3Sbm1a0i8=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYBPR01MB5487.ausprd01.prod.outlook.com (2603:10c6:10:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Wed, 29 Sep 2021 10:23:04 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::416f:f98f:2ea:ecb3]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::416f:f98f:2ea:ecb3%5]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 10:23:04 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "dsterba@suse.cz" <dsterba@suse.cz>, Nick Terrell <terrelln@fb.com>
CC:     "B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com" 
        <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Thread-Topic: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Thread-Index: AQHXtMgiDdQ2ufD0GEKL41icVB6Wfau6OZgAgACQUoCAAAHpYA==
Date:   Wed, 29 Sep 2021 10:23:03 +0000
Message-ID: <SYXPR01MB1918E9CBD97CF904DDB4DC539EA99@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com>
 <4A374EA5-F4CC-4C41-A810-90D09CB7A5FB@fb.com>
 <20210929100659.GK9286@twin.jikos.cz>
In-Reply-To: <20210929100659.GK9286@twin.jikos.cz>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09be15f3-0ac3-4ed1-0ea4-08d983331f42
x-ms-traffictypediagnostic: SYBPR01MB5487:
x-microsoft-antispam-prvs: <SYBPR01MB548787F8ED838BFE69AEEF2E9EA99@SYBPR01MB5487.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Ot/tKJMNjfMUnHIfTvsIRFQE4d+EyZ7FCOMNEFNS82bpLjxRm+3ECa+GBkwCiqX4yEtGnjMfhhuZS0grs35zYLmB6KaqYR2eu0hZ87uJ8NeNX6Hq4/Eb7j2J2xoZxJF5FQcXeKzhHtHZyX2s6UsgWNwCNjRXet+VDQeNtCpDHf4pKH620aSO96/ixss9ryj9gKnrBphJyPdbspxqetvn1Qq6giWo5UiyR/RLqGM0I/o59WxAZLzYoPgH6TmsKEyvpez4izbdfkkPxkRQbAbcm1/03lfqudJO1yR0gOGglXEYpG2waC1EMLZZnjqca6T3kpa6EclQtoaBZBO2x3b77IKa3bagRyxn8DJP1u4JHQ6rcqC8kxO/oAILQwu/7iSU59WdKrLY2nzfC2kL9GKoVCPY1o4B0dXHUnP6JqRUB1wAGaNd8mCMnchN+k1jKokE0yjF33YRxFMknAn7vUPVgF+aOtbcvTUACwdNOFF5MtSyHJChNQrSA4gm7z6fQg8SVMgwzvDBocXJbRsyI2iybZa17ohhbyaC9urq+3dVfP7dWUQJzDIy74HKAWn3oXD2QglVRx75qIo35u9cqRRKe1XaU7KZFbN+8EbpUmztuGqBYKJyXtVsu1Yi5QrMus+WoLcadp7sETV6GKk6Zpk2zCjEk9xd9NV9UWHGxKYGxhVTK3Sz2ZO7c5Dw6rdn9lWrO8f+JApwxco6Si/57mk4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(346002)(136003)(376002)(52536014)(33656002)(110136005)(54906003)(5660300002)(4326008)(9686003)(55016002)(83380400001)(2906002)(186003)(316002)(122000001)(53546011)(38100700002)(8676002)(38070700005)(26005)(7696005)(76116006)(508600001)(71200400001)(8936002)(6506007)(86362001)(66556008)(64756008)(66446008)(66946007)(15650500001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0lyeURLemFqSjRod1I2TFlxTlNBV2U4MmJ6WjgrVVRnS1VIa2dmeDVmUFFk?=
 =?utf-8?B?ZkJ0UGwyeUF1WjRiOHcyOWJ0MVBtbmZCU1VhNzZkQy9OV2p0clMzWTFMNGRX?=
 =?utf-8?B?SnAvZ3QvRmNRTFpTM1ZtQ083eng1aTNCZXZVc09jTWc0cXl2bUlLeGEzcitJ?=
 =?utf-8?B?YmN2c1BNb3ZhMHA3SWl2RlpZSE8vSjNlNFgzRTlQb3dYWFVrYXZwa0FCVHhw?=
 =?utf-8?B?K2Z3cXFLRlBxU1JGMHg4N3Y0eGJFM1duMlZ1aHplR0FiSzR0dU9oYWE0YWNE?=
 =?utf-8?B?ZFF6MkIxZ2ZEMlNTVENQNVExOHRSMXlBcVRvWTlrbXB2UnovaGtMRDJhV3Q4?=
 =?utf-8?B?UkcyM1owbVpXWnBPdWY5WkxVTTFKblJYNHppOXN5eDN3aTZjcmZjTWlsSXpO?=
 =?utf-8?B?MnFibkJFRDVSQ1F5Y01CSSs5VzNiVzExbWlSMGdzUksyR3c1TDVuRnY4LzVh?=
 =?utf-8?B?STlMd3RlYUdpQ05kRUJYaXhyUFF3UU9WZE5TQitTNExyRjNJSHh1ZFU0YXlC?=
 =?utf-8?B?bXNFeEdBTGRmVWtJU2pibm1uZ0Y2ays3Uysza0pWT0lEZDhtcWRmWS9lWlNy?=
 =?utf-8?B?eXAvTHJXWHhhd2xiQ3JqNit0WU1QVFpJSEFnaTFmUkVVQUZERlFBTGdxSEVL?=
 =?utf-8?B?cVVXR1gvdytzQVg1aUZzWGJqUFhVWlhRUGtBS2VTR1hsUDVoYjAwUFFMd0I0?=
 =?utf-8?B?c1RDWnpzbE0vNEpOVS9zbE9wT3hwSWhyaERlM2Z1WS94dldZdnlsdUFNTTFu?=
 =?utf-8?B?MEFnNWVxZll3bTlMQUtPWitMTGV3QXpBNzZUZ2k4aXJ4N0J1TERLZ0NjSGoz?=
 =?utf-8?B?SEFuYXViMDBpeEhhSGdScEdjSi9JS2U0N0syak9qZ3dpeDd0eHg0TU11SDBG?=
 =?utf-8?B?d2RiMVFIWTJqMzhVUnlqVVhkbjVjS0tnSkFRQ0NEWnZ4bUg4MUxKOVFOQWxn?=
 =?utf-8?B?ME5pWGYyV0ZvWG8vQklWNTVvR1lLZnI2cUhKUHpwcVRtZVJ6ekZYNXJiYlh4?=
 =?utf-8?B?TXkzRWtiZ2ZWNm5qd3pnUnNIMFFRUjNKcXpYcTRNb2tHeDdWenAxOXY2UE9q?=
 =?utf-8?B?cXJMMTA1MHczSmJIb0NHdHJQMXp5UXVYeVR4QlpDV29lUjZ5aC9xMkNiNjRI?=
 =?utf-8?B?TmlORFZ5QzdqK083dzNnUjY4YlN3cW5OeGV3a0ZzQVBoNm1sdW1yMmNsSCtC?=
 =?utf-8?B?SEtqSkJwNnZIK05DYTdrUFZ6UmVFcEJVaGg2UFNBbC9VQVQ0WHJXMWlMQkZL?=
 =?utf-8?B?RVJmRjVoOGUrV3MzdlFVZUZYSUJkRG00Vk5MTVJXQmFuT2lpYkh4eUhtdHhK?=
 =?utf-8?B?eTAwc0YvaTlnelg5SklyUGlCRndvYjB3bFdCSlFRTWFhLzREUDRvVDFIMVkz?=
 =?utf-8?B?aXUwdUZxL2JvSndwK0JpY1RFZTJSVkVWL2MxcnpWRE0xckdHSVhMemw5bkZH?=
 =?utf-8?B?WlhoNjNTMFZNRXIzNXpoY3dFQmhjMUxEWm9yTnczQmV5Sk1sU01nNmhKY01I?=
 =?utf-8?B?Qi9OT1IyN3drQTRoYm1qU3kyQUFzRGRWVFNaamhYRi90MnBEZlZrQnV3M016?=
 =?utf-8?B?RXlnOHpFWHBkZTB5Q2hNeWRwY3JZTUg1NFlJUlZuVEVZRm1mNVJPSU1NWkpi?=
 =?utf-8?B?SkR5TkY3eEU4WjR3S3FYejdVK3p6M0ZUT2JjODNQczNhK3NxR0YreFJXc3lE?=
 =?utf-8?B?dTJMazBlbGI1RFRNWitiTjNsRTM4dGhVdFVCV3hhRFRrdWVUUmttZnFwNmxm?=
 =?utf-8?Q?IpFweYjyXaT8yKp5EU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09be15f3-0ac3-4ed1-0ea4-08d983331f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 10:23:03.9819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPJosa4LVz7z9qB4Hv/q815gnhepoteZq8nQpJlGcy3bxvKvBsC7dLOcprYzmg2zzEchBXe8GHlmw54NgDyZMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB5487
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBTdGVyYmEgPGRzdGVy
YmFAc3VzZS5jej4NCj4gU2VudDogV2VkbmVzZGF5LCAyOSBTZXB0ZW1iZXIgMjAyMSA4OjA3IFBN
DQo+IFRvOiBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQGZiLmNvbT4NCj4gQ2M6IEIwOTNCODU5LTUz
Q0MtNDgxOC04Q0MzLUEzMTdGNDg3MkFENkBmYi5jb207IGxpbnV4LQ0KPiBidHJmc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtH
SVQgUFVMTF1bUEFUQ0ggdjExIDAvNF0gVXBkYXRlIHRvIHpzdGQtMS40LjEwDQo+IA0KPiBPbiBX
ZWQsIFNlcCAyOSwgMjAyMSBhdCAwMTozMDoyNkFNICswMDAwLCBOaWNrIFRlcnJlbGwgd3JvdGU6
DQo+ID4gPiBPbiBTZXAgMjgsIDIwMjEsIGF0IDU6MjIgUE0sIFRvbSBTZWV3YWxkIDx0c2Vld2Fs
ZEBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+ID4gSGFzIHRoaXMgYmVlbiBhYmFuZG9uZWQgb3Ig
d2lsbCB0aGVyZSBiZSBmdXR1cmUgYXR0ZW1wdHMgYXQgc3luY2luZw0KPiA+ID4gdGhlIGluLWtl
cm5lbCB6c3RkIHdpdGggdGhlIHVwc3RyZWFtIHByb2plY3Q/DQo+ID4NCj4gPiBTb3JyeSBmb3Ig
dGhlIGxhY2sgb2YgYWN0aW9uLCBidXQgdGhpcyBoYXMgbm90IGJlZW4gYWJhbmRvbmVkLiBJ4oCZ
dmUNCj4gPiBqdXN0IGJlZW4gcHJlcGFyaW5nIGEgcmViYXNlZCBwYXRjaC1zZXQgbGFzdCB3ZWVr
LCBzbyBleHBlY3QgdG8gc2VlIHNvbWUNCj4gYWN0aW9uIHNvb24uDQo+ID4gU2luY2Ugd2XigJly
ZSBub3QgaW4gYSBtZXJnZSB3aW5kb3csIEnigJltIHVuc3VyZSBpZiBpdCBpcyBiZXN0IHRvIHNl
bmQNCj4gPiBvdXQgdGhlIHVwZGF0ZWQgcGF0Y2hlcyBub3csIG9yIHdhaXQgdW50aWwgdGhlIG1l
cmdlIHdpbmRvdyBpcyBvcGVuLA0KPiA+IGJ1dCBJ4oCZbSBhYm91dCB0byBwb3NlIHRoYXQgcXVl
c3Rpb24gdG8gdGhlIExLTUwuDQo+IA0KPiBJZiB5b3Ugc2VuZCBpdCBvbmNlIG1lcmdlIHdpbmRv
dyBpcyBvcGVuIGl0J3MgdW5saWtlbHkgdG8gYmUgbWVyZ2VkLiBUaGUNCj4gY29kZSBtdXN0IGJl
IHJlYWR5IGJlZm9yZSBpdCBvcGVucyBhbmQgcGFydCBvZiBsaW51eC1uZXh0IGZvciBhIHdlZWsg
YXQgbGVhc3QNCj4gaWYgbm90IG1vcmUuDQo+IA0KPiA+IFRoaXMgd29yayBoYXMgYmVlbiBvbiBt
eSBiYWNrIGJ1cm5lciwgYmVjYXVzZSBJ4oCZdmUgYmVlbiBidXN5IHdpdGggd29yaw0KPiA+IG9u
IFpzdGQgYW5kIG90aGVyIHByb2plY3RzLCBhbmQgaGF2ZSBoYWQgYSBoYXJkIHRpbWUganVzdGlm
eWluZyB0bw0KPiA+IG15c2VsZiBzcGVuZGluZyB0b28gbXVjaCB0aW1lIG9uIHRoaXMsIHNpbmNl
IHByb2dyZXNzIGhhcyBiZWVuIHNvIHNsb3cuDQo+IA0KPiBXaGF0IG5lZWRzIHRvIGJlIGRvbmUg
ZnJvbSBteSBQT1Y6DQo+IA0KPiAtIHJlZnJlc2ggdGhlIHBhdGNoZXMgb24gdG9wIG9mIGN1cnJl
bnQgbWFpbmxpbmUsIGVnLiB2NS4xNS1yYzMNCj4gDQo+IC0gbWFrZSBzdXJlIGl0IGNvbXBpbGVz
IGFuZCB3b3JrcyB3aXRoIGN1cnJlbnQgaW4ta2VybmVsIHVzZXJzIG9mIHpzdGQsDQo+ICAgaWUu
IHdpdGggYnRyZnMgaW4gcGFydGljdWxhciwgSSBjYW4gZG8gc29tZSB0ZXN0cyB0b28NCg0KSSBo
YXZlIGJlZW4gcnVubmluZyB0aGlzIHBhdGNoc2V0IHdpdGggYnRyZnMgb24gdGhlIGxhdGVzdCBz
dGFibGUga2VybmVscyAoNS4xMi0xNCksIGFuZCBoYXZlIG5vdCBlbmNvdW50ZXJlZCBhbnkgaXNz
dWVzIGF0IGFsbC4NCkZvciBBTUQ2NCBhbmQgQUFSQ0g2NCB5b3UgY2FuIGFkZCBteQ0KVGVzdGVk
LWJ5OiBQYXVsIEpvbmVzIDxwYXVsQHBhdWxqb25lcy5pZC5hdT4NCg0KIA0KPiAtIHB1c2ggdGhl
IHBhdGNoZXMgdG8gYSBwdWJsaWMgYnJhbmNoIGVnLiBvbiBrLm9yZyBvciBnaXRodWINCj4gDQo+
IC0gYXNrIGZvciBhZGRpbmcgdGhlIGJyYW5jaCB0byBsaW51eC1uZXh0DQo+IA0KPiAtIHRyeSB0
byBnZXQgc29tZSBmZWVkYmFjayBmcm9tIHBlb3BsZSB0aGF0IHdlcmUgb2JqZWN0aW5nIGluIHRo
ZSBwYXN0LA0KPiAgIGFuZCBvZiBjb3Vyc2UgZ2F0aGVyIGFja3Mgb3Igc3VwcG9ydGl2ZSBmZWVk
YmFjaw0KPiANCj4gLSBvbmNlIG1lcmdlIHdpbmRvdyBvcGVucywgc2VuZCBhIHB1bGwgcmVxdWVz
dCB0byBMaW51cywgd3JpdGUgdGhlDQo+ICAgcmF0aW9uYWxlIHdoeSB3ZSB3YW50IHRoaXMgY2hh
bmdlIGFuZCBzdW1tYXJpemUgdGhlIGV2b2x1dGlvbiBvZiB0aGUNCj4gICBwYXRjaHNldCBhbmQg
d2h5IHRoZSBmdWxsIHZlcnNpb24gdXBkYXRlIGlzIHBlcmhhcHMgdGhlIHdheSBmb3J3YXJkDQo=
