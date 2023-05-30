Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A616715469
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 06:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjE3EJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 00:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjE3EJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 00:09:17 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2045.outbound.protection.outlook.com [40.107.107.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511C11D
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 21:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np1Z+fVOic+MM/5Pu3iD9f6V5wFd9Ca1LLjvk5qdYu8TeQmOfQLMutXsz3W13syjjdkAz4clNHnkhSmyZlZE+11U+KJ9J7IzUPSd/BUBlojEWZRVo0zChnv7kkzpGjkmnPJhGbduAHo4J4PqkHlxNZHskrKv1DZOCXZi/o110sRQQaYr/W+AwNFmdaobbudMc4Pt9eAw90DF+NDoz+JRQdq+yJaXKLnUzlJwHbg2Z5lz89c+Q8ss4ecuuVTP30NIA/0/qiYoPAfz/RW296qAsL1tVqan95n/4w2XrjQr27oP6bvTS7JSrxLtP4NxVvqR96pyecXQVS0fIZ5PL7GD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkuCQcmnP77b2/Y6aTs8IduXRN9v0miAq0zOGnIgNcA=;
 b=nXZaPv5ikYaUwzTaPH+b6VDdBRh/iUYA/eOsAcDesfHni0sjD/9KUruSSSwyVg5JwHv7IShDJSYGUDmXyJx20LHBv8N6/9Z5+qaYNCZfF6DOLhoM6ydbhjFh5tQl/dek82JsiqffZh/3njaf8AMeUklQIPy678yQ2kTCozmjObUlGsATMogpbHnRlvtEpImrCsVN5WISuc9Hn0rbngh+AqG8V4PIVQ/S+QlmSXuQclOCH6ZFjxD0QqEEOLMKq7uYyKzealjm5+3YrofnzctBUp/Sk2cvQceLL6kBL6rybiI+bWLNFMd1SfgELNVWhr2LsElG2bEzI/jjM/keEAnyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkuCQcmnP77b2/Y6aTs8IduXRN9v0miAq0zOGnIgNcA=;
 b=NohYxyxDEZN8d6DKS9rI2cGJmxeLgG1qIDbLhlPkMfxGcW7zE7jTUiTSyU0Elhgtn0SYJNHOkOJ55LxShVdQVkumTZBGmoxg1Q4GTpegHwzUc7DXgNYTNdNn7KoTrnjrdG/OP7kR/oamMR+wvcBYT0qQUuuTx+cMWF5H+UvJdts=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SY0PR01MB8636.ausprd01.prod.outlook.com (2603:10c6:10:223::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 04:08:55 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::1781:ba82:b514:c968]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::1781:ba82:b514:c968%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 04:08:55 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Matt Corallo <blnxfsl@bluematt.me>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: RE: [6.1] Transaction Aborted cancelling a metadata balance
Thread-Topic: [6.1] Transaction Aborted cancelling a metadata balance
Thread-Index: AQHZkdwg3CQB87nep06fgX80CRaML69xTXWAgABlkoCAAAPUgIAAfa6AgAAAeNA=
Date:   Tue, 30 May 2023 04:08:55 +0000
Message-ID: <SYCPR01MB4685449D98D7DC18B085CCB59E4B9@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <bc26e2b2-dcb1-d4a2-771e-82c1dbf4f197@bluematt.me>
 <20230529141933.GH575@twin.jikos.cz>
 <f555f213-f839-445f-7b00-cbf1952d64eb@bluematt.me>
 <1ce06018-3fb5-50b1-813d-5b6d9f2cdcdf@bluematt.me>
 <398f2d12-afae-075b-7474-8ce1b13a2b88@bluematt.me>
In-Reply-To: <398f2d12-afae-075b-7474-8ce1b13a2b88@bluematt.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SY0PR01MB8636:EE_
x-ms-office365-filtering-correlation-id: a65a69e1-c0f8-40e3-e199-08db60c39609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ElSg4vQzhmRxQ5QEjqMm/a/OdVRRYhxoeZoptfS/nnaoLAoKFefb+APXe197i2vhkWI4KXvIfivqJ6rH39Ox+ymC+wKT5J7jbS/wEm+do4Dyk7DnEmhF+6XSlWICkkeL38N75UC6S+eDukdBha7b6dRMb8c1SfmZxNur8Ta4MInmsmAHqItfRRseM8Y0bruDID4owO7Tuk//MRDQjcyQJ2kb6pbIV9/8Ls+NUcnVOW8iQv/ffwkgiBTgC0N/X38d2r4NDif2cvQNrhdVxyEQ2K/mKn+vryj0heZGJBGHiXC4hGaec3kBP1OaPja8+87cbEQqVYRyf3cRtv+pCKs1LMyiM9e5Tv0xzqQJOX1fUudxD1g9Tuq+tH1cIuSiSGaU2JDGf4gATUa/aCB1vKeOVz5Cth9xXvsFG8CIejJpLAIY/pegTSJt2qYShMJBcKR8b9k2ewnoFmAf8lJwE27O5r4qO6NFXi7fLYKJrcXHdvdmE0iWhpG9cm9gDoS7SRwPsubuBHb2GdkGWFZ+zprQU7WaCTd9mUIz9ne+/wFRzGmMi5jN7g7W57tsNyBuEu7Z/L95SM41SpPxgTom02QqWcEUnvRNa89P3bwq6FVR3v0SqEPMzrlIXSUEvex1/ALE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39830400003)(136003)(376002)(346002)(451199021)(83380400001)(2906002)(186003)(38070700005)(122000001)(38100700002)(55016003)(8936002)(8676002)(52536014)(5660300002)(86362001)(478600001)(66446008)(66556008)(66476007)(66946007)(4326008)(64756008)(76116006)(41300700001)(7696005)(71200400001)(316002)(9686003)(6506007)(53546011)(26005)(33656002)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3lJNU1uanIza3Q0Z3orR0V0L0hmbHhtTkJ6TGxhTERNQ0tsTDJ4cE85UmpR?=
 =?utf-8?B?Umtma1c2Sm1CMHVJTjRMeDFGbWdyUjhKZXNPQzlNWDlaUVNNcDcySUhjdkVF?=
 =?utf-8?B?ZFZMMGFJY0JqQXpBWktENUFjTmZOZXk3SkJkMUluakxidm53cDhkUDJ2QjBs?=
 =?utf-8?B?TG0yeXNNMk91QTR0dElZYUhGUWlKQXhKS0IzZ0s0Mm1wRHFVUDArbGNHOG1i?=
 =?utf-8?B?bHBEb3R1TVlwOWpTTk5VZHQzSWRJb3ROaVl1dE55a2ZaWHc2eDZoZ0VGdVBL?=
 =?utf-8?B?L0kvQmdOa0g4TEdITmFMRVBCSlVDRURnYVl4V2hxUnFpZ0ZlOE4zVTl0eCtL?=
 =?utf-8?B?L2RWcVVTWWROS3hhQXlHV2paU0kzcUFMU0RVUnNGRVlVTUZTMTkzSjM1a1NE?=
 =?utf-8?B?NDlXTnhnTjhBaGVMZHdxVGlvdllJZkNwelYvdG5qRTZhR3FpeTU0ZFQ0eG9K?=
 =?utf-8?B?b0xMYlNsQytMNVlwZEFhdlN3N0pIR3puYmVqdmlzSTVENllOcG5Hb1UvVk43?=
 =?utf-8?B?UGxIT3gvRHBOaHNOQ2NGcVJGYk95eHBHb0cyTXdISnRCcjRHdWZmdDNFTXND?=
 =?utf-8?B?N3JOZ3NNVVR2dXg5OGo2MlVrNWcwMHptVm1EWkZ5WFFNaGFvOFdiSDcrOCtL?=
 =?utf-8?B?YVZhYjBTRnZKMzRQaDNZSWNhajB5UE9jNzBBMHF5TjEwQmFKQ2pHOWw1NVgz?=
 =?utf-8?B?SERSeTB5NmVmcjRKR0hCOUFzU1dqWUp3RFlEMDMwUTFNZXdBdU9uVVdmdUxl?=
 =?utf-8?B?TGNOWVVheE4xVGN6dUVDVFljQ3o0dy9sTWtubVB2Vnd2VEx5NVJsam9HNVN6?=
 =?utf-8?B?cVJxRUF3MEQ2R0tIbDJ2dzBRR2xRUmRuV3JvZ2RpYWhrb1lOUmNQZEZQZEZu?=
 =?utf-8?B?elBPYkRaYlJxakNuN0JHQjJGV043QWNEVElLU0crK1R5SFUzcmxaSHBXWUZy?=
 =?utf-8?B?cm9QNXRmbGhETmlSRFFXdnhTY0toRDJSeENiTGlkSTNuOUZoczl2YXQ5b3lD?=
 =?utf-8?B?Q21uN01ZMlp1d2E0Y3pCRWxaU1ZnSnRDNWl5SzBzdm01Qm01ZmVIUncvZkZv?=
 =?utf-8?B?N2pMV3B5M0FJaUlkOVJhZGRMdy9zQ2VHdXFnL1A1OGVTK1JndjlUWWRCcjNF?=
 =?utf-8?B?NUJZYUtJR1JNNjFmOWhlZGxpaXRYZnlOK2NBbUR0d0xRTGtKY1RWaXM2WUpM?=
 =?utf-8?B?RUVtbWZZMWZKSmFZeDFCSzF5bVRpelVydSsvb2tSODNydHZRNjhKUE8wSDVj?=
 =?utf-8?B?ZGdMdDlyVTMwci85NXBIYkxuQTZEUmhyOHlIWGQ3L2w1bVdEeXYvaDRDY1M5?=
 =?utf-8?B?ZzF5bzF0SWw1VVY1T2MwRnQwNWZoVHdIUTZralRuQUZoclRQcHBmRnBCRFBT?=
 =?utf-8?B?WXo0cEtNcGFyL2pKV1cySGNkUHl4RWhLM3dHZXhCeEZZcDE4UHVBYzQwM3hZ?=
 =?utf-8?B?KzhMTWlTeUkyTm9jbmZuTS9tbDROY2w2dG5naFFRMWFqeVFlaVhPbUNqSGI0?=
 =?utf-8?B?R2RJaXFrRkRqK1BISTBqMU50K2pLOFNZNmNaV0IzUHpBcVlQZlVoR1JmTERD?=
 =?utf-8?B?M2RJOGJBUFUrZkhhY2hFZUFZS0lLWGhZek1wMURKYlR1UDFwcklaSG5vdlE2?=
 =?utf-8?B?cWRwNFVPUEFZUFZNQ1hMamNNMGlSMEVpcGJtd215YnRaZGkxay9kWlJtLzRK?=
 =?utf-8?B?d0NTWmNOZHR4UW1saWpSeWxEKzcxek1XRFRwemt3MTdvNXpuM1JaQmlSVFdj?=
 =?utf-8?B?TXZJN2htVkZweHdweWpVeW93OVV5ZFNsV3VnU3dvVk5STWV1Y3JMVHM0R2hN?=
 =?utf-8?B?T09aS3FxMWpnTjFmS2tCZUowSUxXa1hGUkJLUmRsdU41dHFxTktUdGlzRjJQ?=
 =?utf-8?B?YWpYQ0JMVFEyZnhzOVEreE9sK1pxVm55L1h0Y0hhTVlGaUJTWjlIdytySzFZ?=
 =?utf-8?B?blBEUmZpb0tGZFRKMHVyVU5MaUhvMU15c3NBbGhtWW9qVGwrd1A1bXZiMFdL?=
 =?utf-8?B?V1djYUlYWnplT2YycHo4WEFUVmtJMzk3LzNTR2N0UWp0REhOYW1RVGE3RTJ4?=
 =?utf-8?B?N2RNbW80VWFwOW5DVmRFOGIzZHArSVRNN2RGOEJGd2NyMzAxTm1hc05wSFVC?=
 =?utf-8?Q?ChdBnvw9b85kvus7um0S5v4Vc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65a69e1-c0f8-40e3-e199-08db60c39609
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 04:08:55.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WNiP9oClP2PZCMTrRz8dixlCcH2bjKKxDhss8sArONNZWA6rlGl6P1ujNXS25GOUp8fhV4FJbdw9WjcJu4C1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB8636
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXR0IENvcmFsbG8gPGJsbnhm
c2xAYmx1ZW1hdHQubWU+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAzMCwgMjAyMyAyOjA3IFBNDQo+
IFRvOiBkc3RlcmJhQHN1c2UuY3oNCj4gQ2M6IEJ0cmZzIEJUUkZTIDxsaW51eC1idHJmc0B2Z2Vy
Lmtlcm5lbC5vcmc+OyBRdSBXZW5ydW8NCj4gPHF1d2VucnVvLmJ0cmZzQGdteC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbNi4xXSBUcmFuc2FjdGlvbiBBYm9ydGVkIGNhbmNlbGxpbmcgYSBtZXRhZGF0
YSBiYWxhbmNlDQo+IA0KPiANCj4gDQo+IE9uIDUvMjkvMjMgMTozNuKAr1BNLCBNYXR0IENvcmFs
bG8gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDUvMjkvMjMgMToyM+KAr1BNLCBNYXR0IENvcmFs
bG8gd3JvdGU6DQo+ID4+IEZXSVcsIGFmdGVyIHRoZSByZWFkLW9ubHkgSSB1bm1vdW50ZWQgYW5k
IGNoZWNrZWQgYW5kIGl0IGNhbWUgYmFjaw0KPiBmaW5lOg0KPiA+Pg0KPiA+PiAjIGJ0cmZzIGNo
ZWNrIC0tcmVhZG9ubHkgLS1wcm9ncmVzcyAvZGV2L21hcHBlci9iaWdyYWlkMjFfY3J5cHQNCj4g
Pj4gT3BlbmluZyBmaWxlc3lzdGVtIHRvIGNoZWNrLi4uDQo+ID4+IENoZWNraW5nIGZpbGVzeXN0
ZW0gb24gL2Rldi9tYXBwZXIvYmlncmFpZDIxX2NyeXB0DQo+ID4+IFVVSUQ6IGUyODQzZjgzLWFh
ZGYtNDE4ZC1iMzZiLTU2NDJmOTA2ODA4Zg0KPiA+PiBbMS83XSBjaGVja2luZyByb290IGl0ZW1z
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgwOjA5OjE3IGVsYXBz
ZWQsDQo+ID4+IDQyNTUxMzcwIGl0ZW1zIGNoZWNrZWQpIFsxLzddIGNoZWNraW5nIHJvb3QgaXRl
bXMNCj4gPj4gKDA6MzM6MjEgZWxhcHNlZCwgMTQ0MDAyMDUyIGl0ZW1zIGNoZWNrZWQpIFsyLzdd
IGNoZWNraW5nDQo+IGV4dGVudHMNCj4gPj4gKDQ6MTk6NDQgZWxhcHNlZCwgODQ4ODU4NCBpdGVt
cyBjaGVja2VkKSBbMy83XSBjaGVja2luZyBmcmVlIHNwYWNlDQo+ID4+IHRyZWXCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMDozNjoxOSBlbGFwc2VkLCAzMTU0MCBpdGVtcyBjaGVj
a2VkKSBbNC83XQ0KPiA+PiBjaGVja2luZyBmcyByb290c8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDk6MzA6MTQgZWxhcHNlZCwgNTQyOTQ4NQ0KPiA+PiBp
dGVtcyBjaGVja2VkKSBbNS83XSBjaGVja2luZyBjc3VtcyAod2l0aG91dCB2ZXJpZnlpbmcgZGF0
YSkNCj4gPj4gKDI6MDE6NDQgZWxhcHNlZCwgMzc0MzczNjcgaXRlbXMgY2hlY2tlZCkgWzYvN10g
Y2hlY2tpbmcgcm9vdA0KPiByZWZzDQo+ID4+ICgwOjAwOjAwIGVsYXBzZWQsIDQzNDQgaXRlbXMg
Y2hlY2tlZCkgWzcvN10gY2hlY2tpbmcgcXVvdGEgZ3JvdXBzDQo+ID4+IHNraXBwZWQgKG5vdCBl
bmFibGVkIG9uIHRoaXMgRlMpIGZvdW5kIDMxMzA0ODQ2MjcyMDI2IGJ5dGVzIHVzZWQsIG5vDQo+
ID4+IGVycm9yIGZvdW5kIHRvdGFsIGNzdW0gYnl0ZXM6IDMwNDEzMjQyMzIwIHRvdGFsIHRyZWUg
Ynl0ZXM6DQo+ID4+IDEzOTAwNTY1NzA4OCB0b3RhbCBmcyB0cmVlIGJ5dGVzOiA4OTMzNDQ0ODEy
OCB0b3RhbCBleHRlbnQgdHJlZQ0KPiA+PiBieXRlczogMTQ5ODc5MzU3NDQgYnRyZWUgc3BhY2Ug
d2FzdGUgYnl0ZXM6IDIyMTk3MzU4OTE1IGZpbGUgZGF0YQ0KPiA+PiBibG9ja3MgYWxsb2NhdGVk
OiAyMjcyMDI1NDg1MTA3MjANCj4gPj4gwqDCoHJlZmVyZW5jZWQgNDM1NjgyMzY0NzQzNjgNCj4g
Pg0KPiA+IEhtbSwgc28gaXQgc2VlbXMgSSBjYW5ub3QgY2FuY2VsIHRoZSBiYWxhbmNlIGF0IGFs
bC4gSSByZW1vdW50ZWQgYWZ0ZXINCj4gPiB0aGUgY2hlY2sgY2FtZSBiYWNrIGdvb2QsIHRoZSBi
YWxhbmNlIHJlc3VtZWQgYW5kIHRoZW4gSSB0cmllZCB0byBjYW5jZWwNCj4gYW5kIGhpdCB0aGUg
YXNzZXJ0X2ViX3BhZ2VfdXB0b2RhdGUgaXNzdWUgYWdhaW46DQo+IA0KPiANCj4gV2VscCwgdGhp
cyBmaWxlc3lzdGVtIGlzIG5vdyBiYXNpY2FsbHkgdW51c2FibGUuIE9uIG1vdW50aW5nIEkgZ2V0
IGEgYmFsYW5jZQ0KPiByZXN1bWUgd2hpY2ggZ2VuZXJhdGVzIGEgY29uc3RhbnQgZmxvb2Qgb2Yg
YXNzZXJ0X2ViX3BhZ2VfdXB0b2RhdGUNCj4gd2FybmluZ3MgdGhhdCBwZWcgYnRyZnMgdGFzayBD
UFUuIEkgY2FuIGNsZWFubHkgdW5tb3VudCBpdCBhZnRlciBhIHdoaWxlIG9mDQo+IHdhcm4gZmxv
b2RzLCBidXQgb24gcmVtb3VudCBpdCBkb2Vzbid0IGdvIGF3YXksIGp1c3QgcmVzdW1lcyBmcm9t
IHdoZXJlIGl0DQo+IHdhcy4NCj4gDQo+IElzIHRoZXJlIHNvbWUgd2F5IHRvIG9mZmxpbmUtY2Fu
Y2VsIHRoZSBiYWxhbmNlIHNpbmNlIEkgY2FuJ3QgY2FuY2VsIGl0IG9ubGluZQ0KPiB3aXRob3V0
IGhpdHRpbmcgdGhlIHRyYW5zYWN0aW9uIGFib3J0Pw0KDQpZZXMsIG1vdW50IGl0IHdpdGggdGhl
IHNraXBfYmFsYW5jZSBtb3VudCBvcHRpb24uDQoNCg0KUGF1bC4NCg==
