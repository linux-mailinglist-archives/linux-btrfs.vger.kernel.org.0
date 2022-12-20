Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526E9651CFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 10:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiLTJRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 04:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTJR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 04:17:27 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68889FCA
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 01:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671527846; x=1703063846;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=SIYvtvgCRRCQIigtzP7wU2XeBwQXDt1NiYjIQeejlpk=;
  b=VfEwu/UGb92qYMrX28sgKl8g3OrLWPKpC+kQo1CpWdg2EQd2t4xt0Y9T
   vXpBOQzB3unH9aRWH6Iqa5f5YxpwsIqIls/fAgji8xotd35uoqlfGlz6y
   HqbJr2H/F1l8j1Ua1uhON+NRjD1L5zBtaXI13/l6v6Cb2xCu2f0OLXA9P
   QgLGlsgwF7pI7/Qj/7m29vSElqVjzjmcx1cQ08c9kB7W7Je/RQjynpNQl
   EYZVVxzBlfC+hs6+vGnbWnfseOSSfNClil3WcQH2hDESaz/cyrzs7rESV
   oC7ddN19J47qtUJeBf/rYpQtQYbKiDFfxeLEiRuhLdU9UDV08TOJeduTH
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,259,1665417600"; 
   d="scan'208";a="323421815"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Dec 2022 17:17:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km4LqbTC7JFaGxbh2HklbOpzOLOVZyZCBifR9eXDILHEd9HrisBDQXj+MKrZ+vbQTImKv7YIex5gS4AVgs317Lhrfgh7yJj5za/juQBAapqaMQy4QO094iDxmZ/tg/52sZlxHaah55I9zlGi2Tna0UJTQuYKur5O4+9M3Qs/cjcLrhvI6jWnLuabwxIRI9v8XRLJ8MaGPSybFDSLLUIv1GJjDuD1wWPCGJK0kSeTXMmpYg0EnTLcv5iOdlsw1+soYuRXelMwQHfnS75MtU1/TJHqzQcxbzqGh1XRXSmGNJ+QPdmiQwaMjmbh7iLIzMW6BxANIxIylus1VHgvjCJeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIYvtvgCRRCQIigtzP7wU2XeBwQXDt1NiYjIQeejlpk=;
 b=KBe53KRyJNff09cEPBCIx6H+0YfwIRYvvg0gaTVhYo1KjXwg5gaKSF/8rcVkbTenvw2qRwerVuHOS7No68LTBPmNmwAQwfutmKf1ryYdiO/QevsuM3vD+euAXdQ80YScp/2ZAmpBiH7a5YnAI1S75hRVWB8vf9wUsICDwKhY0JAK7XdMt7n6KItm8mUTu19nmfCwgr/hCVZCY2P4X3UiCOWP+k7xPevYElYk9tkg/qvZ+vNO7TqnRkem/+AYMUbqQ+vyfpF1dTXjJPLQGRkymv5FVKm1LscgnuGgou3tFkLVU+oqvpLc8jN59BVaH6T7247mS0UdJGTj1yt4AV7GKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIYvtvgCRRCQIigtzP7wU2XeBwQXDt1NiYjIQeejlpk=;
 b=WyIJSxlm1z9sxb4iGaCrAIni7B3Ef70WtiXHGSwIieSkPuOWQcciE+drM0ac78blAtRdTvDcpCBPrSb9rv5guj9c0DhjOtGQthXNmDNinQsIG0LAecxMeD9JRGHJ21JZbKQxGPzuTOtqXcg9OKqxCwd8PAmtAdHzLoMjSSCbUeg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6555.namprd04.prod.outlook.com (2603:10b6:610:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 09:17:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 09:17:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs: delayed_ref parameter cleanup
Thread-Topic: [PATCH 0/4] btrfs: delayed_ref parameter cleanup
Thread-Index: AQHZDgiItu/prH725E2aRMGdArK6bq52i6oA
Date:   Tue, 20 Dec 2022 09:17:22 +0000
Message-ID: <98f29028-b984-47ef-6c9a-1742418c8bf8@wdc.com>
References: <cover.1670835448.git.johannes.thumshirn@wdc.com>
In-Reply-To: <cover.1670835448.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6555:EE_
x-ms-office365-filtering-correlation-id: 9b64cb6b-064e-4e99-2450-08dae26b008e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1QWUOeo5w/ms4L0kgz5/ZOxYwJJuwut7pt5QfMZW05GS9Ph3Ksdj/T1C6mL4nbbJ0QuVaWkTT2ejZQAJG5e8JgMiBt2MQ7AuTYYuYYkTKa1SPt5N7h96n/qem3JBNdTX8D2IdcQaahnAI0xohxcrWLbQ34ZBtGoJ604Gv9asMHswjgMRx8JO5B0rtFlJfR9ayadxPaHcNCKMR4rTaRAuG18aFAHV+91mKV65v/5wAQghfQJ83Zs88m+aF277vTLC49UDs0hhT7Ih8GdVRNzGSz+KvNu5QTblmTPMf3l0V3SI4M716QyqJJ0/Z7ISt2dBTvONPXGfWgtzsTtjC2AyQDE63eAMUGnXW5bFGjJ3EVAOC1KZ4DR65mLGx90X6m8oGEDeNnOItxXNecUQMGCnKGdAmnF/DXWcnCZOiBuyJKcYGR4c3oNYnAZW2wi1onDDWbx+S3IswwTAVjW2Cu1YFdGGgzTgSu8+gr+9GL7W8XowYZdL+2N/vGvGtv+PvTofkkDHv+aX2pGuGOCisgVbDYMT6i86GyrA96KKS/D16r1My12Sus6Wrykvgot5bniWrGp4+Z++yL/1tLcbzzcP+uTLUpUxXXfSHozJsTFAEJJVOnJAL2OyxnvdgFoLrZs/DjNfpi4T4k+Bhg3ZUTcqisq8EYmiBOoW2j9MPkjYYS1OVbNVFTOJ6nRt5qv4Nao2faI9hUVf9aYZUTkLMyR/n1trIE1C5f8AoLG0qlv4bDxQetILfp1uOe14k9oCcaXWoOX/kfrP3xSw8vBNCAjZIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(478600001)(6486002)(71200400001)(6506007)(86362001)(186003)(31696002)(316002)(2616005)(6512007)(66556008)(6916009)(91956017)(66946007)(66476007)(64756008)(76116006)(66446008)(2906002)(36756003)(83380400001)(38100700002)(8676002)(41300700001)(82960400001)(31686004)(53546011)(122000001)(4744005)(8936002)(38070700005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFp0ZkJmeEEzUmNzTWtjVmpJeVRjK1UwWk1TRHRXZDFtblpSQ0dLYWZ0ZTgv?=
 =?utf-8?B?K21kMGpBTFJSZ3h0WmFEbzViRTU4K1cxU01Ta2VQdHA4U2pVM0c2YjkwMmJP?=
 =?utf-8?B?eU5yOFNLdzAyY25HejFnWnNlRVo3U0FjeGsxRmIzbzMrQ0ZxVlpBMVRXTjlN?=
 =?utf-8?B?YW1VZG9ubDl0MUR3R2RlTkdUZlhtdEU4UHpyQno4cGFNYWFBOWhCT2k0bVlR?=
 =?utf-8?B?elpsaWRGMU1uSUFQc1BXTE5uWXNCbDdzZFk4c2xZa3MyUUFXWVBUSnNOTmZm?=
 =?utf-8?B?REJqVGp2VXN1aU82SzhBYVlURW1lK2ZnblJqSDZCV3RreVRtdTJlTW9vNXZP?=
 =?utf-8?B?aW15YWZQOGU5b2dWM3kzT2syNnZkMkRZdlcxL3BORmk1NGd4Szg4VmRXSktG?=
 =?utf-8?B?Umx5TkZVcU1ZKzA0c09HNlFHVFJwYW8weENqOEE4dFFjbUJBOUpIdFJvNG9Q?=
 =?utf-8?B?NzRKZFhDVDFpSUUxbWVRZVF3TTI1ZEtveDdIdCtYcUgzOFZYVXBvWi9nZWVk?=
 =?utf-8?B?UDU2MVFCSTllbFc4RDdNWENhaysxdDZRQk1Fb0pGM29LVis2UUhmdmpZZGc0?=
 =?utf-8?B?ekNGMWhWajJyVmF4dDEvVzR2UHlLdndkS0NZb3R6Rk5wdnlLWm1jd1hRT3NS?=
 =?utf-8?B?NGNYV3M5NXE4OU5HTDZYREVkRWp2T29uUkNhbDNsYWVTcDBVdUxKTjJtRlBs?=
 =?utf-8?B?dVRBNWlJdjBYc0FVbXNJd0w0OVFudlZQS0t5djhNbVNHNExDY2pBVTZlK0pv?=
 =?utf-8?B?Nm0ybnQzQVhXNXJ1TmJDV2I3c3JWN3psd2VJZGtvQk9WMTQ4VFhlYXhLUzBj?=
 =?utf-8?B?Q1pYQXBHY1ZVZzEvcWJvN1h6MjBMRE9FVTRDbUpKSjEzYVRkbGtZanRNQU9U?=
 =?utf-8?B?TkFQL01XaW1LTUJEdGMxRDVyWGFwZXkyZ2Q5em1OLzlpNCtndkttY1dPaU5l?=
 =?utf-8?B?SFlvam5xY3l6M1AwZzRkUEJZVlU5bTdDdFRrOTUwT1pGMG9tYkdLOS8xQWZo?=
 =?utf-8?B?SkFMYUkySjdBOEZlN0NDRHZGaWhyZFduemZPbWhKa1Q1Vy9EdjlWL3Y5NFYx?=
 =?utf-8?B?QU5vYzYwcG5JdFJ0eG13Q08yazN5dGgyMmxxSzh1SDhyNUtHcVFPb01Jalo5?=
 =?utf-8?B?KzhNK3pCb2c5Z2lWeTBVaG1nM1V0QjNodVhxM3FQQ3VWYXBXR01YNEhmMGdE?=
 =?utf-8?B?YWVqMXFESzJEVk1UQmppUzlobEVPMGdaMkI3QnBrL2pWWnlGT2dGUU40a0xy?=
 =?utf-8?B?MWlQTWF1L3pjb0JRV21VZkFHOXBMbWxHM3NMUDd6VFJHUUZRR2t1WlRWVzI0?=
 =?utf-8?B?YUN4VUFiay92ajdNWEhZWVNTdDdQZUE2eWp5RU0zdlhLNUJRUHhQa3dPVzVF?=
 =?utf-8?B?UzIvbmRtbGdhUFFxSjh1V005SXVxRkh3NzYxQUc0S1VFTGpSYndXQUxVL3Ra?=
 =?utf-8?B?YVRuaEtUWSs5eFNsdEE0elVXSmlDVm5WcFBMOGdxdmE0ZVVwQTMvR05nQTlk?=
 =?utf-8?B?eU5JSkxNK1RjRHQ0b0lhTTBQWGNRVFBob0pwY0NvUTE0cFY5djFKSEFOMWZl?=
 =?utf-8?B?QmJqZXJoMzY5UkpsQUZkU2NacFEyNjJMYVpHZ2o2OE5sb28xd25ta05La2Rq?=
 =?utf-8?B?ZHUzTjVXS1hjTUd1a1hZTE9qRGtZUHRTVkN1MENwbTBrdDNDZ2xRRlVDL3l0?=
 =?utf-8?B?eC9lZFVkS0k1SGNVRXFJNkxUN0JXaUtIYjAzUTVhek5YZzFYRENHYzhFaFo2?=
 =?utf-8?B?QlRaOWUwME0xWXZNSVk1TWdqQkxsb1MzVi9EZ0lUZElUVENlVnNLVFJYZnor?=
 =?utf-8?B?bkZGQXFaYlJDekpEN0J5WEh2UzlGZTIvOGdBUytRZjcralFLY0dLWW44M0V5?=
 =?utf-8?B?dVNSOU11WU1vU2FuV1k2WVFIQlp3eFlpaUZCbUtZdWorQ05mWWNyZFRKbG9B?=
 =?utf-8?B?a0w2eTkvSXo1UmY5cFNzRXdIZGFIWDVtVUlOS3o0TldPRXdiL2QzWTRqREpm?=
 =?utf-8?B?N0xDTHJ1aytyNEpzcUovakZEZnZHSzNxV25rbzlQU3lmTjVFQjVWVkgrM1Nn?=
 =?utf-8?B?Z0dZY3F5alg2VlN1dUhORjBmK1B0TVBTVlZ5czJQSndJR0pub3BOaFJVTm9J?=
 =?utf-8?B?ZlRZYUJtcTVTSndvWDNlZG9FS0lGd3hwOTZnSUM5U00xdk1mZ0d5R3BCaVNF?=
 =?utf-8?B?Q0RubmdzNHBzVFQ2cmM4T3lRNUc2VDNqNHMwd1RONXJMaS9iRjVuYS9qUFB4?=
 =?utf-8?B?VHcwWE5zbzFyMmNLRTNzbGFWMWVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BF442E4E5B031449A2539BBE0E39B66@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b64cb6b-064e-4e99-2450-08dae26b008e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 09:17:22.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnrRXxihOISSGUooVlNr6pMw1B6y9NRY1bN6pAcEzdINjb6ARDn19FRR019t21dBRclt8XiH/hMHdnzaiZqMZRayTuaFdAEFruRxXfnYDsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6555
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTIuMTIuMjIgMTA6MDMsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gV2hpbGUgbG9v
a2luZyBhdCB0aGUgZGVsYXllZF9yZWYgY29kZSBmb3IgdGhlIFJTVCBzZXJpZXMgSSd2ZSBkaXNj
b3ZlcmVkLCB0aGF0DQo+IGRyb3BfZGVsYXllZF9yZWYgaXMgdXNpbmcgYSBidHJmc190cmFuc19o
YW5kbGUgd2l0aG91dCBldmVuIHVzaW5nIGl0LiBBZnRlcg0KPiBoYXZpbmcgaXQgcmVtb3ZlZCBJ
J3ZlIGlkZW50aWZpZWQgbW9yZSB1c2VzIG9mIHRoZSB0cmFucyBpbiB0aGUgY2FsbGNoYWluIHRo
YXQNCj4gYXJlIHVudXNlZCBhZnRlciBkcm9wX2RlbGF5ZWRfcmVmIGdvdCByaWQgb2YgaXQuDQo+
IA0KPiBKb2hhbm5lcyBUaHVtc2hpcm4gKDQpOg0KPiAgIGJ0cmZzOiBkcm9wIHVudXNlZCB0cmFu
cyBwYXJhbWV0ZXIgb2YgZHJvcF9kZWxheWVkX3JlZg0KPiAgIGJ0cmZzOiByZW1vdmUgdHJhbnMg
cGFyYW1ldGVyIG9mIG1lcmdlX3JlZg0KPiAgIGJ0cmZzOiBkcm9wIHRyYW5zIHBhcmFtZXRlciBv
ZiBpbnNlcnRfZGVsYXllZF9yZWYNCj4gICBidHJmczogZGlyZWN0bHkgcGFzcyBpbiBmc19pbmZv
IHRvIGJ0cmZzX21lcmdlX2RlbGF5ZWRfcmVmcw0KPiANCj4gIGZzL2J0cmZzL2RlbGF5ZWQtcmVm
LmMgfCAyNCArKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gIGZzL2J0cmZzL2RlbGF5ZWQtcmVm
LmggfCAgMiArLQ0KPiAgZnMvYnRyZnMvZXh0ZW50LXRyZWUuYyB8ICA0ICsrLS0NCj4gIDMgZmls
ZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4g
YmFzZS1jb21taXQ6IGI3YWYwNjM1Yzg3ZmY3OGQ2YmQ1MjMyOThhYjc0NzFmOWZmZDNjZTUNClBp
bmc/DQo=
