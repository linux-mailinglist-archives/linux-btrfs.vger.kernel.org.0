Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB762EA1E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 01:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKRAS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 19:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKRAS4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 19:18:56 -0500
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2074.outbound.protection.outlook.com [40.107.107.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9F365E76
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Nov 2022 16:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL7sdHZg38U7RKKqfv1hp1/XxNoLm1pm5v7OSRLXRLdbIStNyYJeEy3w5yNwVmQ3ph8WzcWDa9nQy1YSbwpSTxCjJkCAmBevO3dATI7AkxYV01XitUdJuF2xe7AGzG/0TatGcdfMOCOEH+7htwOdQ73u/8a134uckWpSHQOFpOliEWeRZRi+/W+EhRIZWFtIVZvo745O4BDhxGhOYIo7DqehXA7VPY/BGDIcQipEb239Weq7PYutKQ6LtPjzRbD8JAFW0oxRnA3VuISDH0vrtB6UK4vF9F6aVw8iusFvhlQIEXTRjxH4j1fmJqRvoJfHHHQ6E0vZr0Qgb45jFyCT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8atxIpx0E9Z7mCHH1KiQxZHH3vW20JdMP3/qBGwmkk=;
 b=IjlEE8EJc+KNrKWcS474CaLfx+cgm3h7vTzTGB/LyIyHORKeVkFtwTMcVdcZ+Ie0GD18K7k4uDDTJ0o+th9UBugKeGScoedXS2Hv5QF0ZYr5aueFJcptlwr457COT2Y0g9jk4h22RHdQWI6+rGByIMFTQqXCjklMo6hlVHbvoC/hIud9D+N2XfSU9B2PCP8j4zBaydZGz4wFlX5QJvDyX1m2Q8S9iqwvX+faOHc3/WWcHPxKMKA3UyvMXWXc02GxQ4TZTP1u9NeVsWxJZ9K8RBEoOKzg/C2+c4ajbe+Vp3V6gvsWk1VgCuu+MzeZCHupFxIHrO32A6+qIGOQzGfklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8atxIpx0E9Z7mCHH1KiQxZHH3vW20JdMP3/qBGwmkk=;
 b=ZNjSSUkdpem5u1SkJApTyf2pIjwSrh6wujTYMQn4pysZQOyAG/rr1jt5sPIh/KxSBBtm17w/+PFrvOxZ4qIkss4Tdd+mJEPJed4YgeOFYf+XcYWEd7Ah5PQglgk7TgK9Iq22hGdTM9SJYGXZRwNVNJVrWPGXOBZiGnAf/ywhDr0=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SYBPR01MB6843.ausprd01.prod.outlook.com (2603:10c6:10:116::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 00:18:49 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::ab2c:7285:1c1f:842a]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::ab2c:7285:1c1f:842a%6]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 00:18:49 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Hendrik Friedel <hendrik@friedels.name>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Re[2]: block group x has wrong amount of free space
Thread-Topic: Re[2]: block group x has wrong amount of free space
Thread-Index: AQHY+mxhaoZ/Ak5Pd0+mykHeli9vE65C94YAgADZlWA=
Date:   Fri, 18 Nov 2022 00:18:49 +0000
Message-ID: <SYCPR01MB4685F00E2D2EB81E014D33159E099@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
 <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
 <bcb7a3f2-fa48-1846-e983-2e1ed771275e@gmx.com>
 <em62944e8a-0e4b-4028-ae00-383aac0608ab@7b52163e.com>
 <d7cc9778-9e97-f749-e110-d93a7045e341@gmx.com>
 <em7ed36627-a727-470e-872c-a2af32cdb18d@7b52163e.com>
 <em8aefb52c-4cdc-4cfb-ad52-1c807d8f7756@7b52163e.com>
 <emcca5c139-84cb-403b-af68-e288e31878e3@7b52163e.com>
 <c91c89b4-58e6-526a-bfb8-fb332e792cc3@gmx.com>
 <em6eb00339-18ce-4f15-8b9d-da8058301e72@7b52163e.com>
 <5fcf68ec-836a-3517-289d-bb77527468f7@gmx.com>
 <ema0c172ea-7620-4949-8f89-1504aaf516ca@7b52163e.com>
In-Reply-To: <ema0c172ea-7620-4949-8f89-1504aaf516ca@7b52163e.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SYBPR01MB6843:EE_
x-ms-office365-filtering-correlation-id: 78ff48d2-cace-4ba5-7863-08dac8fa7732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5gP6sZs78qRoGm1g/iVm7jf5g9H2Y8J8/4s2neiEN6s2muD7Zv85oMEQj0W0r3WiIceJ5saFghYSzdSYpr+IyMhsrw3XwanLpZO+ypXKMNvxlUkXRfTzJvsd5LJ2ZOIaFpWldPlTeqhYEGlfpamT8W6FknTp6c21yL0Kfz+4j4cDviQohBq5vGzRGohat6z/1H6KziuTghhiu9ixS+8md4Cv1G1xU0JmoyF1WTIO5b829HdAzgnX8joxZ4bTEVgrTJ9kLckXqjY0nMmNEXTT9WZfJ3yjQ59Sff0R/4oTtG2Iq/a00Q+PrNuT+scNvvuyi92ppNW0E/EuNYsdTD/kUet5EQFXKMHUP5CrX8De00v27o4r8rplRunBMzbLEriOMPqaJr+KoV8KKsYWVfHFco+QSNQTYpvCgNCtq6EZ8AyKf1xRZ5yDBbhUdb7FtDFeA3y0Jzq0lqqnvmzvY0l3zzvKyrMxo5NnpIDm52t0vYEUUZYpVQHSEKSk8C1mv+clWTIbxSpcQf5ajxXh/eEsaa10dkZd5dbcF8jzzmegUab8gnOBHnJ1WtruMjNI6TfR443zflav4hRB2IptndaKQgv14o/1N7wOEsAQYAfZfaykUIriEFW+v2BDpPjHIBWuNixxi2HO1hoIJ9BBIgkMf7JUe8UfqK+qFm5xeJIIQ3moMJurfb8SDjOPRky4AGTb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(366004)(39830400003)(451199015)(86362001)(76116006)(110136005)(5660300002)(316002)(55016003)(41300700001)(52536014)(8936002)(66946007)(122000001)(71200400001)(38070700005)(83380400001)(38100700002)(2906002)(6506007)(53546011)(7696005)(186003)(9686003)(64756008)(66476007)(66446008)(8676002)(66556008)(33656002)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OElpYTg0VVdsWEJ5VmN3SU9sM204WUxNdi80VDI1WHpXeHhWR3RKTXpCYU5I?=
 =?utf-8?B?ZnpNODhBRnhhdkYwUXExbFZ5dCtUSzdYakF0eHpoK0kwRVJMbGxlTEVZdkV0?=
 =?utf-8?B?MDN5SGJiTmpKMjRGMWVDMUpYNnFIS2xNUXBqR05BQ3g4MEU0eGZXVEdOeCtD?=
 =?utf-8?B?ZTFtNWVFSEZOUDBCblo4SHpRTDlwWmNLWGNGWVNseUh1bXQzcHdpTmVTV1or?=
 =?utf-8?B?NFhJK1RFcDBoZlVnTzJScC9IODZSQ01ZcE9pN0xmVG5DUVUrb29WNUxBbmxH?=
 =?utf-8?B?QVRwRmRFdlVhODI1V1A1K0Y1aytzU1p4Vy9tU1pNTk91czEwdm5jSXE0Rml4?=
 =?utf-8?B?TTV0S0IyRXJnUm9MQUQ0WVV6Ty9Da3RzY3BtaHFYRHVkdVg5UkxGRy9rREk3?=
 =?utf-8?B?QTNCUUJmR1hsMTVuZGdVbURwTHlNNFYwcGtuM2xnWC9zRVFhZk1HY0VsR2oz?=
 =?utf-8?B?czduZlY1WmUxdWFwMExaTWVoU2hBUm0zR09oNngwa0hnNWNFZGpMSnNUR3dw?=
 =?utf-8?B?ejFvb3VSUjJLZUNoTjlZZW9WdUxVMzl0azF6YndyMDNwWTcwSlloTXJqQVBx?=
 =?utf-8?B?VThOQXhXdFZPa0xNSXV0YUpreDM5UmhwRWRKOGloRjZ3QkE4YllWTEwzRTB5?=
 =?utf-8?B?KzRpcmJnYUlDbGM4UHJZRERiMEtCYy8wQmJNSFRxMVE1NUllcjBQWEZrTTVq?=
 =?utf-8?B?UGFRbGxpK0NyRWlWUjZjWDVlSXRCQVhORUdjWHZaK2R3MWl5cDRCeVc5anRX?=
 =?utf-8?B?UUwwamo4bkwzOVRPOHVhL3Mwd3VGaTlrMDhLMlRCK2dnNG5jZnQ0MDhtT0V3?=
 =?utf-8?B?b25CaGlKTFNZZHZ1dUtPTE9aWkh3SEdkOTh5b0MzdDZkOFpraVA2MHlIOEpP?=
 =?utf-8?B?aXUrd0RaOS9zRG9hNm10YklPcHMvS2RMRTh1RjdCS1ZhMExYVGp3b0h4MHdV?=
 =?utf-8?B?TTRIQk5yRGlkakVoU0FmYVlhSzIzV0l4Qng3SnRGaGs0SDMydW1wTExiMUZ5?=
 =?utf-8?B?STVtWTk3NEppSmoveTJ2azRydWVCZS9VZE11TWFUSUtjV0x1aG93ZlZEQVlX?=
 =?utf-8?B?NHZ5aGVJUkdUNHVsNWFLU0NhSjRadW5MVkpxeXlra1RCZE5sY0Y0R1B1UDY3?=
 =?utf-8?B?WS9rcUZUN1ZKSzJ1ZElUbEsvWEdSR1UyQU91TVFrRWlUdjhHS04wTVJTclFh?=
 =?utf-8?B?STRkZDV1VTkwNnIyMjRsUEpoK1gvV0dCdm52V2tLSjVYUEJEZTFpZ25Jcmg2?=
 =?utf-8?B?cHhxZDFzY0RCNkRNNllKTzE3cEdWcm54M3hFZHAxbmJkUG5FdjE5MEl1eldF?=
 =?utf-8?B?cXh4aUlCMENNYnVFSDdsSk5Ealc5UkxJRDRGTjUxb0w4UW1ZU2FuOUl2OEZs?=
 =?utf-8?B?N1JlYklTKzRKdXFpQjZuQUo5MnZ1TVorZmxtTFgrNDlMUjVQNFVrTVJYeUx3?=
 =?utf-8?B?SHYyd0FBUm55RHpSRWZDUUpKR0YyajVjUUtVQ0NIR2dqRTF3VE85enlKcmU0?=
 =?utf-8?B?TzVXZmFyaTg0d3NoTW1Xd21SckkvS1JvUnJyYnIzVlpxQSt3UUE4Q29MT3A1?=
 =?utf-8?B?Zzg0b1FBaHliYkxEVG9OelAvK1RMTi9xcGVFVEJQTmx4amtPUGsyaDZHZHRD?=
 =?utf-8?B?cWNpT204SlJIS1plV2FWYWJMb0QzQWxvR3htS1NiWEY3c3dvL0RQTjRJNXVx?=
 =?utf-8?B?TEM3ZlMyRi9WdUE4eU9vRWMvL1pUVG1SQS82UHo0aWVWMVkwY1B2SksxY0Z5?=
 =?utf-8?B?eEJXYmNRN0J5SHAyRjVHNmZFMGtuQWJxeDVNTGZSM2tmanVtY3JyV2VDanY2?=
 =?utf-8?B?WDVReGJxZ2l0SU5aNWErU3ZlcytEZU0wQ1pFNXE1TTFCRkVEOGRlenF0cXE3?=
 =?utf-8?B?RDZPU1c4NHFMbUZYU21oWmpRTzFWWUxZZllwUkZoZlllWUhDa1RhVi9YTzBI?=
 =?utf-8?B?WlB6NXAxMmJqVG9LQUFROHozbnVkenFLY0Y1MXlHQU90R2xhYXFMU2llQUU3?=
 =?utf-8?B?NmNUeGtkdkhCaTJralhNYllvT1lRSnpHUFM2MTc2b0JZc0Y4b1c3YjQ1cFVu?=
 =?utf-8?B?Y3lxTG1BOEZJZWdMMVhzbDZOYnBSZ0pMM3JHZllib010bUwrZ2xCNzBxcmtl?=
 =?utf-8?Q?39V8lhT4Va1LRIegHO4vfaF5F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ff48d2-cace-4ba5-7863-08dac8fa7732
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 00:18:49.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdujwVLLeZycLY9S6f5PaUaWDpLw24miIJlwajsIWBpdJmwNNhE0ZeXrrI2NGhJYJyKIhGtXp6pel3W4JYY1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZW5kcmlrIEZyaWVkZWwgPGhl
bmRyaWtAZnJpZWRlbHMubmFtZT4NCj4gU2VudDogVGh1cnNkYXksIDE3IE5vdmVtYmVyIDIwMjIg
MTA6MTggUE0NCj4gVG86IFF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT47IGxpbnV4
LWJ0cmZzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZVsyXTogYmxvY2sgZ3JvdXAgeCBo
YXMgd3JvbmcgYW1vdW50IG9mIGZyZWUgc3BhY2UNCj4gDQo+IEhlbGxvLA0KPiANCj4gaW5kZWVk
LCB0aGUgZGlyZWN0IG1vdW50IHdvcmtlZCBhbmQgcmVzdWx0ZWQgaW4gYSB0cmFuc2l0aW9uIHRv
IHYyOg0KPiBbRG8gTm92IDE3IDExOjM1OjIzIDIwMjJdIEJUUkZTIGluZm8gKGRldmljZSBzZGIx
KTogdXNpbmcgY3JjMzJjDQo+IChjcmMzMmMtaW50ZWwpIGNoZWNrc3VtIGFsZ29yaXRobQ0KPiBb
RG8gTm92IDE3IDExOjM1OjIzIDIwMjJdIEJUUkZTIGluZm8gKGRldmljZSBzZGIxKTogZW5hYmxp
bmcgZnJlZSBzcGFjZQ0KPiB0cmVlDQo+IFtEbyBOb3YgMTcgMTE6MzU6MjMgMjAyMl0gQlRSRlMg
aW5mbyAoZGV2aWNlIHNkYjEpOiB1c2luZyBmcmVlIHNwYWNlDQo+IHRyZWUNCj4gW0RvIE5vdiAx
NyAxMTozNTo0MyAyMDIyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiMSk6IGNyZWF0aW5nIGZyZWUg
c3BhY2UNCj4gdHJlZQ0KPiBbRG8gTm92IDE3IDExOjM5OjAyIDIwMjJdIEJUUkZTIGluZm8gKGRl
dmljZSBzZGIxKTogc2V0dGluZyBjb21wYXQtcm8NCj4gZmVhdHVyZSBmbGFnIGZvciBGUkVFX1NQ
QUNFX1RSRUUgKDB4MSkNCj4gW0RvIE5vdiAxNyAxMTozOTowMiAyMDIyXSBCVFJGUyBpbmZvIChk
ZXZpY2Ugc2RiMSk6IHNldHRpbmcgY29tcGF0LXJvDQo+IGZlYXR1cmUgZmxhZyBmb3IgRlJFRV9T
UEFDRV9UUkVFX1ZBTElEICgweDIpDQo+IFtEbyBOb3YgMTcgMTE6Mzk6MDIgMjAyMl0gQlRSRlMg
aW5mbyAoZGV2aWNlIHNkYjEpOiBjbGVhbmluZyBmcmVlIHNwYWNlDQo+IGNhY2hlIHYxDQo+IA0K
PiBBZnRlciB0aGF0LCBJIGRpZCBhIHJlYm9vdCwgYW5kIGZvdW5kIHRoaXMgaW4gdGhlIGxvZ3M6
DQo+IFtEbyBOb3YgMTcgMTE6NTk6MjAgMjAyMl0gYXRhMzogRUggY29tcGxldGUNCj4gW0RvIE5v
diAxNyAxMTo1OToyMCAyMDIyXSBhdGEzOiBsaW1pdGluZyBTQVRBIGxpbmsgc3BlZWQgdG8gMy4w
IEdicHMNCj4gW0RvIE5vdiAxNyAxMTo1OToyMCAyMDIyXSBhdGEzLjAwOiBleGNlcHRpb24gRW1h
c2sgMHgxMCBTQWN0IDB4NDAwMCBTRXJyDQo+IDB4ODUwMDAwIGFjdGlvbiAweDYgZnJvemVuDQo+
IFtEbyBOb3YgMTcgMTE6NTk6MjAgMjAyMl0gYXRhMy4wMDogaXJxX3N0YXQgMHgwODAwMDAwMCwg
aW50ZXJmYWNlIGZhdGFsDQo+IGVycm9yDQo+IFtEbyBOb3YgMTcgMTE6NTk6MjAgMjAyMl0gYXRh
MzogU0Vycm9yOiB7IFBIWVJkeUNoZyBDb21tV2FrZSBMaW5rU2VxIH0NCj4gW0RvIE5vdiAxNyAx
MTo1OToyMCAyMDIyXSBhdGEzLjAwOiBmYWlsZWQgY29tbWFuZDogUkVBRCBGUERNQSBRVUVVRUQN
Cj4gW0RvIE5vdiAxNyAxMTo1OToyMCAyMDIyXSBhdGEzLjAwOiBjbWQNCj4gNjAvMjA6NzA6YzA6
ZDY6MzMvMDA6MDA6NTk6MDM6MDAvNDAgdGFnIDE0IG5jcSBkbWEgMTYzODQgaW4NCj4gW0RvIE5v
diAxNyAxMTo1OToyMCAyMDIyXSBhdGEzLjAwOiBzdGF0dXM6IHsgRFJEWSB9DQo+IFtEbyBOb3Yg
MTcgMTE6NTk6MjAgMjAyMl0gYXRhMzogaGFyZCByZXNldHRpbmcgbGluaw0KPiBbRG8gTm92IDE3
IDExOjU5OjIxIDIwMjJdIGF0YTM6IFNBVEEgbGluayB1cCAzLjAgR2JwcyAoU1N0YXR1cyAxMjMN
Cj4gU0NvbnRyb2wgMzIwKQ0KPiBbRG8gTm92IDE3IDExOjU5OjIxIDIwMjJdIGF0YTMuMDA6IEFD
UEkgY21kDQo+IGY1LzAwOjAwOjAwOjAwOjAwOjAwKFNFQ1VSSVRZIEZSRUVaRSBMT0NLKSBmaWx0
ZXJlZCBvdXQNCj4gW0RvIE5vdiAxNyAxMTo1OToyMSAyMDIyXSBhdGEzLjAwOiBBQ1BJIGNtZCBi
MS9jMTowMDowMDowMDowMDowMChERVZJQ0UNCj4gQ09ORklHVVJBVElPTiBPVkVSTEFZKSBmaWx0
ZXJlZCBvdXQNCj4gW0RvIE5vdiAxNyAxMTo1OToyMSAyMDIyXSBhdGEzLjAwOiBBQ1BJIGNtZA0K
PiBmNS8wMDowMDowMDowMDowMDowMChTRUNVUklUWSBGUkVFWkUgTE9DSykgZmlsdGVyZWQgb3V0
DQo+IFtEbyBOb3YgMTcgMTE6NTk6MjEgMjAyMl0gYXRhMy4wMDogQUNQSSBjbWQgYjEvYzE6MDA6
MDA6MDA6MDA6MDAoREVWSUNFDQo+IENPTkZJR1VSQVRJT04gT1ZFUkxBWSkgZmlsdGVyZWQgb3V0
DQo+IFtEbyBOb3YgMTcgMTE6NTk6MjEgMjAyMl0gYXRhMy4wMDogY29uZmlndXJlZCBmb3IgVURN
QS8xMzMNCj4gW0RvIE5vdiAxNyAxMTo1OToyMSAyMDIyXSBhdGEzOiBFSCBjb21wbGV0ZQ0KDQoN
ClRoaXMgaW5kaWNhdGVzIHlvdSBoYXZlIGEgcGh5c2ljYWwgcHJvYmxlbSB3aXRoIHlvdXIgZGlz
ayAtIEkgd291bGQgdHJ5IHN3YXBwaW5nIHRoZSBjYWJsZXMuIFRyeSBhbmQgZml4IHRoaXMgYmVm
b3JlIHlvdSBkbyBhbnl0aGluZyBlbHNlLg0KDQoNClBhdWwuDQo=
