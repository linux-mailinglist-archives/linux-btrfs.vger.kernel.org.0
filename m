Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1FB136A3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 10:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgAJJux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 04:50:53 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:45921 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727206AbgAJJuw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 04:50:52 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Fri, 10 Jan 2020 09:50:10 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 10 Jan 2020 09:34:50 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 10 Jan 2020 09:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJGAlek5m+kX+NXL4KyEBIphuDMhzDUqaOwyE6gvTS+MmKFICrSXQQmCKbcr/BoVQ4NUULYm7exf+6vw/1Q53igfgBlO6wbSiGeV2YCA2KVpUMJqY6Wy7N5X/55r+yTivl59k0YcffcE43JnNY8ZWXMq5suJHBPF59A+0n337N8Kd/509Bgy017Q34N90ukkZCh3d9oX4sL7LPhJe6riMQEanK2HeBtL6SIObEV+0yhyaTokeis3pOwF7kCfNDdt9UaOMgeyaMUnCCCyBjmUK2g8L3d6Cp/g11TxcuiknKIDQ/8CFSkvfy5LVNcSAzVSlsldKNLkc6YTx7lgX0J9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlS1mZeW0QFAiVNTjlIEdMMJ6278Xq/7j3mSRE5DVEA=;
 b=aUuG0to/lbyRORzr7OwTF52KJQqMdBCHPBs/E/oHq6m5nGYrbxwHXP3/YOg90A3HMxnqeq/NVXmewME6SmmPQ6qgm/tG7+gIJxCwCy5fkVtoJ9lknyAKyPJIDfMZYKMg8eDQOqISsrJ3BusIUA2QZhXLlnoOvBgPX1oF7gIWhaU0bJ86APhn/+RYTz1CEAD5wKONyh2KzX2Ghg9bG5VzX2mgYTeoQQLGhb8DA72ehhmSSozPx091a5i0CI9gaeWbZiImIv6ZNYa5IeFYLQc4yI/niMWvy7dlmmcFs7GtDtKNuv2gt/CxxB3Xj2zEU/3cNg3rZFaNjdLB/GRySv6lAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) by
 MN2PR18MB2525.namprd18.prod.outlook.com (20.179.82.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Fri, 10 Jan 2020 09:34:49 +0000
Received: from MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::898e:fc64:f921:63b1]) by MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::898e:fc64:f921:63b1%6]) with mapi id 15.20.2602.018; Fri, 10 Jan 2020
 09:34:49 +0000
From:   Long An <lan@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: fix path for btrfs-corrupt-block
Thread-Topic: [PATCH] btrfs-progs: fix path for btrfs-corrupt-block
Thread-Index: AQHVx5f+zW6PCIJlV0OyIoZmpawO/qfjozYA
Date:   Fri, 10 Jan 2020 09:34:49 +0000
Message-ID: <1578648888.3609.5.camel@suse.com>
References: <20191219025220.31764-1-lan@suse.com>
         <MN2PR18MB2685D76F7AFF7508E8101982C6380@MN2PR18MB2685.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB2685D76F7AFF7508E8101982C6380@MN2PR18MB2685.namprd18.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lan@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f25e3b1-ba3c-404b-8b8e-08d795b05692
x-ms-traffictypediagnostic: MN2PR18MB2525:
x-microsoft-antispam-prvs: <MN2PR18MB2525DC85F3E9A090902DE564C6380@MN2PR18MB2525.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(51444003)(2906002)(478600001)(8676002)(26005)(2616005)(36756003)(316002)(6512007)(81166006)(81156014)(76116006)(6486002)(8936002)(186003)(66946007)(91956017)(86362001)(71200400001)(103116003)(6506007)(66556008)(5660300002)(64756008)(66476007)(6916009)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB2525;H:MN2PR18MB2685.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jglmOmRrKDr66tC3E78VwyI1HNGtoCoOU2E54fIEmZVOKqTJO0A8vMwGmivpqBaBvu9Q4LJ2QkHLcJo+Ey/dhB3nNpeu/LDGmMT1wWSXbeEICYl4aFDTlXO3vrqncLnNk2ekPgm8l5kH9CFdfu1d2LWUkfZdOfpO/F1HqIYdSOuwcQvyg/3ZDsoh/ICJ6JGzd2uR1eatnBn9EXx8rHr3l0HmU7j3MbxhNSHq57PQ9kxGVW2ob5WN1vTZ1fKZYPpGuDiToN/oAEEM2QMeWSKS2oPl4/hbGqNQ/AplY0HUuBy9fPFkaO1mgIxKAtnIj0p1UWFjnE0mnVvcFSets0a29NMiXPanmnIh4fMIeKvhZEvXOTVkfPQDDCgyWatH6btLEyWsYkyQ96mhNBmQbyR0qnzbcriHj5G/tjNDWPgC5AxTaKeMQIiaPIQlcbo0ilJGwZ8tFf/05h3vSc+nSc6+kcuddzA4EJpF9h3oMf2IoOpHG2FBjum65wkvMk0S4dv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5996134122B8E488A63BDCC36AC6CA0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f25e3b1-ba3c-404b-8b8e-08d795b05692
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 09:34:49.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ppN4ukJE0a2dI+X9rk89G9hp9IZQBYCo8MsNUmmd4qiZ7AAO0sID8WRx/I8mVGe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2525
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

QXMgd2VucnVvIHNhaWQsIGZpbGUgZ2VuZXJhdGlvbiBmdW5jdGlvbiBtaWdodCBiZSBiZXR0ZXIu
DQpCdXQgSSB0aGluayB0aGF0IGV2ZW4gc28sIGl0IHN0aWxsIG5lZWRzIHRvIGJlIGZpeGVkLg0K
DQpPbiBGcmksIDIwMjAtMDEtMTAgYXQgMDk6MjYgKzAwMDAsIExvbmcgQW4gd3JvdGU6DQo+IGJ0
cmZzLWNvcnJ1cHQtYmxvY2sgcGF0aCBpcyB3cm9uZyBvbiBleHBvcnRlZCB0ZXN0c3V0aWUuIEZp
eCB0aGlzDQo+IGlzc3VlDQo+IGZvciBiZWxvdyB0ZXN0czoNCj4gZnNjay10ZXN0cy8wMzctZnJl
ZXNwYWNldHJlZS1yZXBhaXINCj4gbWlzYy10ZXN0cy8wMzgtYmFja3VwLXJvb3QtY29ycnVwdGlv
bg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW4gTG9uZyA8bGFuQHN1c2UuY29tPg0KPiAtLS0NCj4g
IHRlc3RzL2ZzY2stdGVzdHMvMDM3LWZyZWVzcGFjZXRyZWUtcmVwYWlyL3Rlc3Quc2ggICB8IDIg
Ky0NCj4gIHRlc3RzL21pc2MtdGVzdHMvMDM4LWJhY2t1cC1yb290LWNvcnJ1cHRpb24vdGVzdC5z
aCB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2ZzY2stdGVzdHMvMDM3LWZyZWVzcGFjZXRy
ZWUtcmVwYWlyL3Rlc3Quc2gNCj4gYi90ZXN0cy9mc2NrLXRlc3RzLzAzNy1mcmVlc3BhY2V0cmVl
LXJlcGFpci90ZXN0LnNoDQo+IGluZGV4IGQ3ZWUwZjIxLi40OTE2NWZjZCAxMDA3NTUNCj4gLS0t
IGEvdGVzdHMvZnNjay10ZXN0cy8wMzctZnJlZXNwYWNldHJlZS1yZXBhaXIvdGVzdC5zaA0KPiAr
KysgYi90ZXN0cy9mc2NrLXRlc3RzLzAzNy1mcmVlc3BhY2V0cmVlLXJlcGFpci90ZXN0LnNoDQo+
IEBAIC00Niw3ICs0Niw3IEBAIGNvcnJ1cHRfZnN0X2l0ZW0oKQ0KPiAgICAgICAgICAgICAgICAg
X2ZhaWwgIlVua25vd24gaXRlbSB0eXBlIGZvciBjb3JydXB0aW9uIg0KPiAgICAgICAgIGZpDQo+
IA0KPiAtICAgICAgIHJ1bl9jaGVjayAiJFRPUC9idHJmcy1jb3JydXB0LWJsb2NrIiAtciAxMCAt
Sw0KPiAiJG9iamVjdGlkLCR0eXBlLCRvZmZzZXQiIFwNCj4gKyAgICAgICBydW5fY2hlY2sgIiRJ
TlRFUk5BTF9CSU4vYnRyZnMtY29ycnVwdC1ibG9jayIgLXIgMTAgLUsNCj4gIiRvYmplY3RpZCwk
dHlwZSwkb2Zmc2V0IiBcDQo+ICAgICAgICAgICAgICAgICAtZiBvZmZzZXQgIiRURVNUX0RFViIN
Cj4gIH0NCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9taXNjLXRlc3RzLzAzOC1iYWNrdXAtcm9v
dC1jb3JydXB0aW9uL3Rlc3Quc2gNCj4gYi90ZXN0cy9taXNjLXRlc3RzLzAzOC1iYWNrdXAtcm9v
dC1jb3JydXB0aW9uL3Rlc3Quc2gNCj4gaW5kZXggZjE1ZDBiYmEuLmE5NzA2OTFiIDEwMDc1NQ0K
PiAtLS0gYS90ZXN0cy9taXNjLXRlc3RzLzAzOC1iYWNrdXAtcm9vdC1jb3JydXB0aW9uL3Rlc3Qu
c2gNCj4gKysrIGIvdGVzdHMvbWlzYy10ZXN0cy8wMzgtYmFja3VwLXJvb3QtY29ycnVwdGlvbi90
ZXN0LnNoDQo+IEBAIC0yNyw3ICsyNyw3IEBAIG1haW5fcm9vdF9wdHI9JChkdW1wX3N1cGVyIHwg
Z3JlcCByb290IHwgaGVhZCAtbjEgfA0KPiBhd2sgJ3twcmludCAkMn0nKQ0KPiANCj4gIFsgIiRi
YWNrdXAyX3Jvb3RfcHRyIiAtZXEgIiRtYWluX3Jvb3RfcHRyIiBdIHx8IF9mYWlsICJCYWNrdXAg
c2xvdCAyDQo+IGlzIG5vdCBpbiB1c2UiDQo+IA0KPiAtcnVuX2NoZWNrICIkVE9QL2J0cmZzLWNv
cnJ1cHQtYmxvY2siIC1tICRtYWluX3Jvb3RfcHRyIC1mIGdlbmVyYXRpb24NCj4gIiRURVNUX0RF
ViINCj4gK3J1bl9jaGVjayAiJElOVEVSTkFMX0JJTi9idHJmcy1jb3JydXB0LWJsb2NrIiAtbSAk
bWFpbl9yb290X3B0ciAtZg0KPiBnZW5lcmF0aW9uICIkVEVTVF9ERVYiDQo+IA0KPiAgIyBTaG91
bGQgZmFpbCBiZWNhdXNlIHRoZSByb290IGlzIGNvcnJ1cHRlZA0KPiAgcnVuX211c3RmYWlsICJV
bmV4cGVjdGVkIHN1Y2Nlc3NmdWwgbW91bnQiIFwNCj4gLS0NCj4gMi4xNi40DQo+IA0KPiANCi0t
IA0KQW4gTG9uZyA8bGFuQHN1c2UuY29tPg0KU1VTRSBTTEUtUUEgLCBBUEFDLTIgQmVpamluZw==
