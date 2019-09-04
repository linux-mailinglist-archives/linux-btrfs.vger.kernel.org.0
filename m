Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0DA95D3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 00:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfIDWOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 18:14:12 -0400
Received: from mail-oln040092068036.outbound.protection.outlook.com ([40.92.68.36]:48284
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727562AbfIDWOM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 18:14:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCSIMQOmhRkbeqiwmUtDGE9wNaY2b/Bh94bPkc/YS4QiC7+5YOqP7xZx5vT8HKEtJEmJ3K13VyHIZru9805BXRjUUeEFi/NNkun3UJ2F0qDgBkNaRuz8v1xriCycXZqVYLt2HEzCHSEunm30Xf8RiXaH8pcuPgCUUGSrvpUFOierdQoCTXxLDayLaFqi6hlfqe0OvXspG6OkEWAHj5u1eGa2wdrZmQhf/Jj9Ww2m4PqimujKhTDenwHyY+js6molWmnjtIni5vbGaICwMpGTsjcTEkpm8W0Pi5nyZKYplx0orZh9Qn/gL2deYNCiR9fwzuj++ODeQKX6xNEcrWsrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVBnEASQhYlvMGwXQGFZj0Xf8Mv0C+TAP6b9rHA2w08=;
 b=LsmeqtFNMOK9L84XUwLewCvS/K+k6yZVSPO9FrID5wCkm121t0MDVESt+UQL++gkjCCc7s7TvbG/csR4F/U69LAH2xYD9p+SYdhhKJZoIQFAFDZNpgMAY6vuWjwNKO//5LI6GOMYPdDFJtUmSepnpUWadaBx6ZD/EZWPS138TQ8bs+RhtSQd5yyKc1SjPXbpv8g4RZ6bGp/4dyx8fwvHWd0Z0eklsEUl+ASRAEgDzi7V9vUX2xN05Lpq7/gjdIpuBvPo9xn7ypyus5E8sOsAgvd2zMbODRSOxn5/NeQKJpQlv6ZpsVBlVgN1j1Z5oS0Rk0r3yOX8bNmTOPrhyFO0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (10.152.8.53) by AM5EUR02HT014.eop-EUR02.prod.protection.outlook.com
 (10.152.8.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.14; Wed, 4 Sep
 2019 22:14:09 +0000
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM (10.152.8.57) by
 AM5EUR02FT054.mail.protection.outlook.com (10.152.8.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14 via Frontend Transport; Wed, 4 Sep 2019 22:14:08 +0000
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::1dc3:b34:1e76:cef]) by DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::1dc3:b34:1e76:cef%7]) with mapi id 15.20.2241.014; Wed, 4 Sep 2019
 22:14:08 +0000
From:   Alberto Bursi <alberto.bursi@outlook.it>
To:     =?utf-8?B?U3fDom1pIFBldGFyYW1lc2g=?= <swami@petaramesh.org>,
        Chris Murphy <lists@colorremedies.com>
CC:     Piotr Szymaniak <szarpaj@grubelek.pl>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
Thread-Topic: Cloning / getting a full backup of a BTRFS filesystem
Thread-Index: AQHVYuhMf7XFjb3pmUqXZaFDqTr4fqcbOVUAgABUQgCAAGjnAIAAB+qAgAAEXACAABOJgA==
Date:   Wed, 4 Sep 2019 22:14:08 +0000
Message-ID: <DB7P191MB0377435B086CBC80B5713B1192B80@DB7P191MB0377.EURP191.PROD.OUTLOOK.COM>
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
 <CAA91j0VLnOB1pZAbi-Gr2sNUJMj56LbBU7=NLYGfrPs7T_GpNA@mail.gmail.com>
 <20190904140444.GH31890@pontus.sran>
 <20190904202012.GF2488@savella.carfax.org.uk>
 <CAJCQCtQoKOL68yMWSBfeDKsp4qCci1WQiv4YwCpf15JWF++upg@mail.gmail.com>
 <5b5cc1fd-1e68-53c5-97bd-876c5cf08683@petaramesh.org>
In-Reply-To: <5b5cc1fd-1e68-53c5-97bd-876c5cf08683@petaramesh.org>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MRXP264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::26) To DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:5:10::13)
x-incomingtopheadermarker: OriginalChecksum:16C91DEC1CD5EC4AF1E89E218043A7A8C9D58FBFC78C7915254800136352903B;UpperCasedChecksum:AE6641F9C745968CA2F8B5356576C5259FC464C4A2C67CE7E9A27A2270FF0203;SizeAsReceived:7888;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [FPFdOvkDz/ImmEIw6kYRctq/NP1D0cku]
x-microsoft-original-message-id: <1161b4c2-29cd-f017-a1b1-58478c29dac2@outlook.it>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT014;
x-ms-traffictypediagnostic: AM5EUR02HT014:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: Y7UwLw+HA7ERrLO+i5osi5aBtcEnzeH2KQpz1lKubROaDlrBrgrLxcbFZj0tuAz1zVjaDoKkQIHXOfd4M+QuVsOzflT+CWqUbYtLqGU8+cuNjToG9l16GZmr183p1aXs9pDQig7XPlimag+3P32BqaxbdDJvyC8hedS8rfdzyUvr+7Pl/2agsWFlhnH0Z26d
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C66281B1B9DEA4CAC4703AE764FFF83@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fc990a31-eab0-4eed-df4c-08d73185342d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 22:14:08.6329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQpPbiAwNC8wOS8xOSAyMzowNCwgU3fDom1pIFBldGFyYW1lc2ggd3JvdGU6DQo+DQo+IFNvIHRo
ZSBxdWVzdGlvbiByZXNsbHkgaXMgOiBIb3cgY291bGQgSSBiYWNrdXAgYSBjb21wbGV4IEJUUkZT
IHZvbHVtZSB0bw0KPiBhbm90aGVyIGJ1dCBkaWZmZXJlbnRseSAocGh5c2ljYWxseSkgb3JnYW5p
emVkIHZvbHVtZSBrZWVwaW5nIHRoZQ0KPiBjb21wbGV0ZSBzdHJ1Y3R1cmUgYW5kIGJlaW5nIGFi
bGUgdG8gcmVzdG9yZSBpdCBwcmVmZXJhYmx5IGluIGEgc2luZ2xlDQo+IG9wZXJhdGlvbi4NCj4N
Cj4gSWYgdGhlIGFuc3dlciBpcyDCqyBUaGVyZSdzIG5vIHdheSBpdCBjYW4gYmUgZG9uZSDCuyB0
aGVuIGl0IGlzIHJlYWxseQ0KPiBiYWRseSBhbm5veWluZy4uLg0KPg0KPiDgpZANCj4NClRoZXJl
IGlzIGEgcHl0aG9uLWJhc2VkIHRvb2wgdGhhdCBjYW4gY2xvbmUgYSBidHJmcyB2b2x1bWUgYnkg
c2VuZGluZyANCnN1YnZvbHVtZXMgdG8gdGhlIG5ldyBmaWxlc3lzdGVtLA0Kb25lIGF0IGEgdGlt
ZS4gSSBuZXZlciB0cmllZCBpdCwgYnV0IGl0IGhhcyBhIGJ1bmNoIG9mIG9wdGlvbnMsIGEgZGVj
ZW50IA0KcmVhZG1lIGFuZCBpdCdzIHN0aWxsIG1haW50YWluZWQgc28NCnlvdSBtYXkgYXNrIGl0
cyBkZXZlbG9wZXIgdG9vIGFib3V0IHlvdXIgY2FzZS4NCg0KaHR0cHM6Ly9naXRodWIuY29tL213
aWxjay9idHJmcy1jbG9uZQ0KDQpQZXJzb25hbGx5IEkndmUgbmV2ZXIgdXNlZCBsYXJnZSBhcnJh
eXMgbm9yIFJBSUQ1LzYgb24gQnRyZnMgc28gSSd2ZSANCmp1c3QgYmVlbiBjbG9uaW5nDQpwYXJ0
aXRpb25zIG9mIFVOTU9VTlRFRCBCdHJmcyByYWlkcyB3aXRoIHB2ICh3aGljaCBpcyBiYXNpY2Fs
bHkgYSAiY2F0IiANCnRoYXQgc2hvd3MgcHJvZ3Jlc3MgYmFycyBhbmQgc3VjaCwNCmRkIGlzbid0
IGRvaW5nIGFueXRoaW5nIHNwZWNpYWwsIGFuZCBpZiB5b3Ugc2V0IHRoZSB3cm9uZyBibG9jayBz
aXplIGl0IA0Kd2lsbCB0YWtlIGFnZXMpLg0KDQpPbmUgZGlzayBhZnRlciBhbm90aGVyLCBhcyBs
b25nIGFzIHRoZSBwYXJ0aXRpb24gZml0cyBpdCB3aWxsIHdvcmsgZmluZS4gDQpDYW4gY2xvbmUg
YWxsIGRpc2tzIGF0IHRoZSBzYW1lIHRpbWUsIGFzIGxvbmcgYXMgdGhleSBhcmUgdW5tb3VudGVk
Lg0KDQpJZiB5b3UgYXJlIGNvcHlpbmcgR1BUIGRpc2tzIGFuZCB0aGUgdGFyZ2V0IGRpc2sgaXNu
J3QgMTAwJSB0aGUgc2FtZSANCnNpemUsIHRoZSBiYWNrdXAgR1BUIHBhcnRpdGlvbiB0YWJsZSBh
dCB0aGUgZW5kIG9mIHRoZSBkcml2ZSB3aWxsIGJlIGluIA0KdGhlIHdyb25nIHBsYWNlDQpzbyB5
b3Ugd2lsbCBuZWVkIHRvIGZpeCB0aGF0IHdpdGggZmRpc2sgKHNob3VsZCBiZSBqdXN0ICJzdWRv
IGZkaXNrIA0KL2Rldi9zZFgiIGFuZCB0aGVuIHlvdSBha25vd2xlZGdlIHRoZSBpc3N1ZQ0KYWJv
dXQgdGhlIG1pc3NpbmcgR1BUIHRhYmxlIGF0IHRoZSBlbmQgb2YgdGhlIGRldmljZSwgYW5kIHRo
ZW4gIndyaXRlIA0KY2hhbmdlcyB0byBkaXNrIikgb3IgZ2Rpc2sgKHRoYXQgaGFzIGEgc3BlY2lm
aWMgY29tbWFuZCB0byByZWJ1aWxkIHRoZSANCmJhY2t1cCBHUFQgdGFibGUgaW4gdGhlIGFkdmFu
Y2VkIG1lbnUpLg0KDQotQWxiZXJ0bw0KDQoNCg==
