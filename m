Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288E8747FDA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGEIjM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 04:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGEIjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 04:39:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC51716
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 01:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TroVX/f+lGcEVCW0ZqJ7tsxFnvCurjs/YwBnr+KXvYt8hVtn1DpoNDCHtqnfI5ODf/L1Vz8ZQDN2ckX+D9lf1bhqHhbaH8s6ffBPVLEsgyKHWZJaGY7aSvLylUY6umzr1UVbvO1kOszMfrqzwM89mGQI+dHl7tKVVV/XVibkMghuCfcMDwzPUwx/sfncywNWy0afWMyacxGhS/pGbp8gQwyRey9NxAknuErOXUtaYpv6T334+a8GNv5InF051q/gZx4c0Oz9oGVeO81T6Avq6xm3kyQYS4ObIXCKFJCSyMd7qYGAiU5CgXRnb3oJCvYNeUF6xXg0hE1SsF4WTqb1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQUOuotyscve1nr0KyzZYzK71SnrPY3++sspcyuNnAY=;
 b=koLB5whLskl8xioR2kKF83gXPNfAEAQxb5rTcIzt9qvgAFTE8k0ugBONhbRy0XdzsKkTfnj13d0KznuFxH9xNNBDbMyh57LntdhphYjxXrcH9AkrQGnbCUDP6OhhojYRJBG5vbR20Joz2W5rLvHMKhglAtZNfJ/tj5L4Lyy7VjAtq6o4dcuFY7uPsJM+NXhUiiJQtTHsp/rlbHUS2TEVSIiJAGoNKpbNM1pr9Kj0w/tpfyg9NoYfx18BrpfxSeqF/bG4QAnXJgiDl4qW46VUR57OCl//+qwIsyJHmn2EQpXxVHh94UTDV/w7k/DzPEJ72rUSV0h+dI3RxYxJug//7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQUOuotyscve1nr0KyzZYzK71SnrPY3++sspcyuNnAY=;
 b=D8OIKGTR2vFmIZHCk5gal7bdka+JbJSo3TEQ4iit8I+6Q0IxkswrCZZuwIok+J87u+/LDdcG92yCz4BgHftlOAaylzB8nyJtCE0h0lpe1ctEQO3NmRUoGQoB3cNWmSZ68R4HxU5fhJL7S0Tnq1nTqNTMu9wZjQFU85h09lPejko=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:39:06 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:39:06 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: question to btrfs scrub
Thread-Topic: question to btrfs scrub
Thread-Index: AdmqYWxcqzByINPHTMyzVF+8SQB2BgAB8fyAAA4C3wAAJq31gADUQtNgAA4hmwAAFVwYIA==
Date:   Wed, 5 Jul 2023 08:39:06 +0000
Message-ID: <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
In-Reply-To: <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DB8PR04MB6956:EE_
x-ms-office365-filtering-correlation-id: e4b6e3d8-5a60-43a2-892a-08db7d334b34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7PfzBk2jlzxvYoN2CfqAZud6J6f1Z7ZG8HN1uy65kE6z6YmOpLYpa9jT/HuuaaPW4a7Uc/uCUrxDCRnQug0Rpfw5NujzDZAh1LdMat9ln6ctCEMMXS1NJMxs9NpPrNjjhy83PEh0hMBFIQhDFWAdJu2U4jhdQCSyZlANSY/97eE6evVjOm2t+z61SbqEB36JB5F7b/mZ8SKSr3Crt8EWWwngzDaWj3ri45lDssMTleVNeKHxvfUdodhxKp6EwvW8/9U1idybF3SKBOOGBr2vllabalc87M4/x6omNyNFkVUEm3jYH9snmoIbKTZeyb5fXB/2PlO3P5SjFi02ibkNISEAxc7fFnEm164G77uYVBfu/qvo6dZunhV1f9l4HQH0IASjSojrgZVj7WDkFQHhex7jFCLZ7slvqav2kTw0KG23At5VAPhvMvWDrVGOhvQO1tlvOrXLMsaqYLL0d+csOi9/kXLHtFDvlpluXIZkptpCRG17WPUx8lSlefxyxNDAgaKJAcVsZBAg+dP1O+QmMWU3WSzZCgn5eCpRzofFH9S1IkftGSML3S8VQeRZcS8FEhiMbAFxV/AtQlmA09/l9Ne1W8+J+aoBkyc5T4t5L/k8x6IwEfu+V04o6DiDiL0+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(396003)(136003)(376002)(366004)(451199021)(41300700001)(316002)(7696005)(966005)(186003)(83380400001)(53546011)(66574015)(9686003)(6506007)(26005)(3480700007)(52536014)(110136005)(478600001)(33656002)(71200400001)(122000001)(38100700002)(66446008)(44832011)(76116006)(66946007)(64756008)(66476007)(55016003)(66556008)(5660300002)(38070700005)(86362001)(8676002)(8936002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmoyK2JDM0pHZ0xPd3B6VHA3a2ttaDJaQjUwL1hDbXJLRDRvUEo0VFhidmU3?=
 =?utf-8?B?UkkyMDFyYUJveFhmd1RUT3E3aFplOTAvRUJsNHdSWTUrMGJVSGJRRnhaa2tJ?=
 =?utf-8?B?S01tZFpaMEYyTnVpMk84N0sxSkpzQXZMSHk3cFJJaHpGUzVEMXo3dVRtWWk2?=
 =?utf-8?B?QVJkdy9GZ3dWQ3dRUmlZdHdjQlBidDRhRHRUMlFQSG9VM1VLZDZCYWo5ZUpV?=
 =?utf-8?B?cFQ2MXBRTlFMZDBoUncvaXBvVmEvbGhkdUp2eTNQU0JXT1FrOFgvWWtFNnAy?=
 =?utf-8?B?NUdxWHpqWUJrcWlGNjNyVU1QZGRQbXNjQmxzZHBmNjRHaWkrQnhSQ3R6RlQz?=
 =?utf-8?B?RDdhbXo0Q05KMlhDYURUMG5oUCtiWHczb2t5Zk11ZXVRcW96dzZqMjNBRjNj?=
 =?utf-8?B?WC8vRVZtUUpUUVlpR0xBb284NGhpRWhTRFFUdW8rM1psUy9QWVBUcFJ0NGdm?=
 =?utf-8?B?MG1CdXhTdGVRb1pmQkJHZlJ3SEFSMkhKUEFWNUtiVFhqMGVGZ0VscXZ3L2ZX?=
 =?utf-8?B?RTBFbE5wSWZFM2ErTlduRFRMWGZwZ2x3dmZzMnJmbzFJbU15UmRUQzRleFQ4?=
 =?utf-8?B?b1VtYkdhWERUTXZwek50VktvNlIvMDVTOTQxbnNaeEZuUmJCSXE0NytPaFBB?=
 =?utf-8?B?N2JqZTRtZzNBK29pNEZhV1RpS1VkTVVDTmRTdkxJcE9aeWNRMm51QThBb3RQ?=
 =?utf-8?B?L2VtOXdrRkhtZ0tlS0RVaFVvdTJOOE1sRG04WWZUSW4wYi83UHhvSjZ5czFx?=
 =?utf-8?B?WVZZWFNWejRDeHQzZ3hOOFUyL2hLSjZxL2g4Qk15LzFMZGI4eWs1OG9LTWlS?=
 =?utf-8?B?dW9SUjhRL1RSanF2Y2pUbHhMdUpwYlhJdTFKVHZhYmRnbldOZ3RPTjE4RFN0?=
 =?utf-8?B?aXNVWDJRN2syUlUyY1ZWWVNPRU1VWEdBOE1zNzB6S0xaaE9tZGQvNzJpSmJk?=
 =?utf-8?B?U1BVMlk3N0hUZndmMlFybFRNWnA5Ly9CbTZad0ZJVnhzS0JTdVc3V2NBZ05V?=
 =?utf-8?B?czRURS9Yb1Bmb3hscUZMbURQS1U4QmFqcW1aNzc0MFdzaTRmTVdLKzR0YlBa?=
 =?utf-8?B?VWZDVDZhazN0dzRYdGhuaTdxL1FZOGRQMjZMV0FPNUhTU2wrR1JuRkxwSGJu?=
 =?utf-8?B?R1Z0NlZxNmFqaEQyOHRHV3R0SWQycElmWjdNM0pRdzBmV05PcHRJZ0pidUpO?=
 =?utf-8?B?YzBsdzM2cmdVM2ZCZmFNRFdpYmswTkJPWmlNdUdaek5qL21OTU1kS1FEZG9k?=
 =?utf-8?B?bGIrRFMyazExK051Vm0xYkJVeldDZ28wNEVwd2JXOWtidkNIU2o5TCs0eTFM?=
 =?utf-8?B?VFhkOWFibWxza0dFT1ZhZ1BzK2pJT1lpTUhKMGZJek15dW9EVzlvTnJZdVNS?=
 =?utf-8?B?d0N0ZUpEV0VDYWtZbnVJOTBneDVnUlI1ZkR6N3FFb3lJL0F0NkE0WFYwWHlk?=
 =?utf-8?B?YUdGNW9YNlVRV0R2Y0duZ3NBR1dTd2FHUG5nam40dm04azdaWkFqcGF3NUtn?=
 =?utf-8?B?TVBnL01pWWZucUJKRFBjZFFTTitKZzBDTDNmeHpLZGpzOHQwQk5Tc0FtZytY?=
 =?utf-8?B?d2xyNW93Wjd0cXF5QUJKVGZDWWpWY0ZFOEY0NXRpU0V1bWdoQlRCOFFJVUg5?=
 =?utf-8?B?SnVMdUl3NnhTUmJrajZWQzVPcm15dzRuVko1NEFqUlFmd0w1cEFudE1UTWxq?=
 =?utf-8?B?WG9OUGpIdHJKb2d6QjQ0b2xwblV0OVNuRkoyVDAwbVhmT3ZzWEZuNm1ZTGpF?=
 =?utf-8?B?SUVTUmQ3NFpwSkh6Nkc4QjJSRWF3b21aNjU1WGpEVStDT3htbFFqZGVKTDVW?=
 =?utf-8?B?M0R2NWc5dmFJelRmaHQ0MlZYbW9TZ2cvSUN0eFlJTXA3S0hKM3M0eEJObGUz?=
 =?utf-8?B?VytUVzA5dUs2K0VSUWxmZWxJR2M0NGZ0U1BKTUl3aldIUjlLNklWLy9qSmtC?=
 =?utf-8?B?SFFZS0h4ZFBOU1RScThOZ05YRVNQcTNmV3pRMXNQZ0FtQ2JrK1ZYZlBlRGZu?=
 =?utf-8?B?dDRiQmdJRzNIT1BKZEQza0ozS3B2Y2JlZU5QVlBudE9oMWNmTDRocW1WRGdV?=
 =?utf-8?B?KzVtVEVTWWdQcnJicXBaY0k1TUxyL2JGUDRvZitZUmYyLzBXNnphY3daUFcv?=
 =?utf-8?B?blNmSzllNVZ3TmVycFBFVHQvQjdtOURKMi9oMm9qU3VSZGVpWWh6eDRhNnZJ?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b6e3d8-5a60-43a2-892a-08db7d334b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 08:39:06.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0n2XlGpGhNOj0OQ5KSTZKfZ1o2zSBPBGoiKFD8p/kPj2Ez/jM+ibppzSizH8jjCvlYk+4xjb3jgPrlSFYG5TwHY6cnjxHZpaUNmImqWInya2cawezNNHybBvvxsTblPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFF1IFdlbnJ1byA8d3F1QHN1
c2UuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgNSwgMjAyMyAxMjoxOSBBTQ0KPiBUbzog
QmVybmQgTGVudGVzIDxiZXJuZC5sZW50ZXNAaGVsbWhvbHR6LW11ZW5jaGVuLmRlPjsgUXUgV2Vu
cnVvDQo+IDxxdXdlbnJ1by5idHJmc0BnbXguY29tPjsgbGludXgtYnRyZnMgPGxpbnV4LWJ0cmZz
QHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IHF1ZXN0aW9uIHRvIGJ0cmZzIHNjcnVi
DQo+DQo+IFRoYXQncyB3aHkgaXQgZG9lc24ndCByZXBvcnQgdGhlIGNzdW0gZXJyb3IsIGFuZCB3
ZSBuZWVkICItLWNoZWNrLWRhdGEtY3N1bSINCj4gdG8gdmVyaWZ5IGRhdGEgY3N1bS4NCg0KT0su
IEkgc3RhcnRlZCBpdC4gQnV0IGlzbid0IHRoYXQgdGhlIHNhbWUgYXMgImJ0cmZzIHNjcnViIiA/
DQpUaGUgbWFuIHBhZ2UgZ2l2ZXMgYSBoaW50Og0KLS1jaGVjay1kYXRhLWNzdW0NCnZlcmlmeSBj
aGVja3N1bXMgb2YgZGF0YSBibG9ja3MNClRoaXMgZXhwZWN0cyB0aGF0IHRoZSBmaWxlc3lzdGVt
IGlzIG90aGVyd2lzZSBPSywgYW5kIGlzIGJhc2ljYWxseSBhbiBvZmZsaW5lIHNjcnViIHRoYXQg
ZG9lcyBub3QgcmVwYWlyIGRhdGEgZnJvbSBzcGFyZSBjb3BpZXMuDQoNCj4+IFdoYXQgY2FuIEkg
ZG8gPyBJJ20gYWZyYWlkIEkgaGF2ZSB0byByZWZvcm1hdC4nDQo+DQo+IE5vcGUsIHlvdSBkb24n
dCBuZWVkIHRvIHJlZm9ybWF0IGF0IGFsbC4NCj4NCj4gPiBCdXQgd2hhdCBiZSB0aGUgY3VscHJp
dCBmb3IgdGhlIGVycm9ycyA/DQo+DQo+IEl0IGNhbiBiZSBhIHByb2JsZW0gb2YgdGhlIFZNIHdv
cmtsb2FkIG9uIGJ0cmZzLg0KTXkgVk0ncyBhcmUgbm90IHVuZGVyIGhlYXZ5IGxvYWQuDQo+DQo+
IEFzIGEgd29ya2Fyb3VuZCwgeW91IGNhbiBlYXNpbHkgZGlzYWJsZSBkYXRhY293IGZvciB0aGUg
Vk0gZGlyZWN0b3J5IHVzaW5nDQo+IHRoZSBmb2xsb3dpbmcgY29tbWFuZDoNCj4NCj4gIyBjaGF0
dHIgK0MgPFZNIGltYWdlcyBkaXJlY3Rvcnk+DQoNCk5vLiBJIHVzZSBidHJmcyB0byBtYWtlIHNu
YXBzaG90cyBmcm9tIHRoZSBpbWFnZXMgZnJvbSB0aGUgVk0ncy4NCg0KVGhhbmtzLg0KDQpCZXJu
ZA0KDQoNCkhlbG1ob2x0eiBaZW50cnVtIE3DvG5jaGVuIOKAkyBEZXV0c2NoZXMgRm9yc2NodW5n
c3plbnRydW0gZsO8ciBHZXN1bmRoZWl0IHVuZCBVbXdlbHQgKEdtYkgpDQpJbmdvbHN0w6RkdGVy
IExhbmRzdHJhw59lIDEsIEQtODU3NjQgTmV1aGVyYmVyZywgaHR0cHM6Ly93d3cuaGVsbWhvbHR6
LW11bmljaC5kZQ0KR2VzY2jDpGZ0c2bDvGhydW5nOiBQcm9mLiBEci4gbWVkLiBEci4gaC5jLiBN
YXR0aGlhcyBUc2Now7ZwLCBEYW5pZWxhIFNvbW1lciAoa29tbS4pIHwgQXVmc2ljaHRzcmF0c3Zv
cnNpdHplbmRlOiBNaW5EaXLigJlpbiBQcm9mLiBEci4gVmVyb25pa2Egdm9uIE1lc3NsaW5nDQpS
ZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0IE3DvG5jaGVuIEhSQiA2NDY2IHwgVVN0LUlkTnIu
IERFIDEyOTUyMTY3MQ0K
