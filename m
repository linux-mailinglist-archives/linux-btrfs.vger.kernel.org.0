Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9D179F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEHNJO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 09:09:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56524 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725910AbfEHNJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 May 2019 09:09:14 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48D99rk032050;
        Wed, 8 May 2019 06:09:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OqzxN0YufFxDvPr91bEkmMd4StKrYOYQmihCAkYyEIc=;
 b=d3LyQqIza1aPkpzmlvokqbFHQr+BS4EddINUqiGSh3XdV5HRo/YWNhMTKEyp703zT/aS
 6GmVqTjcHEp9oAvivaS/L/0I0kv76BLFl3xYbgjUVBnTsTH3DxL5yfOGFmUWGoTaZakh
 dnpWCjI7cjvs37NVfO2FQhMIu0M+ESPko6c= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sbh8ramuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 May 2019 06:09:09 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 8 May 2019 06:09:05 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 8 May 2019 06:09:05 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 8 May 2019 06:09:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqzxN0YufFxDvPr91bEkmMd4StKrYOYQmihCAkYyEIc=;
 b=k7gNm+b4Lam98nP0iNDS41Ovfs7z0W5EiKlrg+wwB6wG5Gj+YORNTOUbwFkmtet5BiApqwdnhS/N3T4rYwmZ1SWB8SEXLxoG6EQw/5r0LzIoCN+3gInLd6ry/DH9y9k/dVKqxbcK7tTVOrlstx9t0xWIkJDmG+u0gLxt/+HI1Bk=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1419.namprd15.prod.outlook.com (10.173.221.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Wed, 8 May 2019 13:09:03 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13%5]) with mapi id 15.20.1878.019; Wed, 8 May 2019
 13:09:02 +0000
From:   Chris Mason <clm@fb.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: run delayed iput at unlink time
Thread-Topic: [PATCH] btrfs: run delayed iput at unlink time
Thread-Index: AQHVBPpPr8qxwtiVREyKLOYKgYx1PqZg0Z0AgABiyIA=
Date:   Wed, 8 May 2019 13:09:02 +0000
Message-ID: <15561965-3624-468A-9307-169D70B3D5D8@fb.com>
References: <20190507172734.93994-1-josef@toxicpanda.com>
 <7147863c-dfe0-573c-18cc-f9284fd30f39@suse.com>
In-Reply-To: <7147863c-dfe0-573c-18cc-f9284fd30f39@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: HK0PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::14) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c094:180::1:db0d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bea27b7b-232e-4f69-78c6-08d6d3b65761
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1419;
x-ms-traffictypediagnostic: DM5PR15MB1419:
x-microsoft-antispam-prvs: <DM5PR15MB141988CB912F846FF72D53FDD3320@DM5PR15MB1419.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:252;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(71190400001)(71200400001)(82746002)(478600001)(6512007)(476003)(386003)(6916009)(6506007)(6486002)(53546011)(2906002)(102836004)(6436002)(14454004)(86362001)(54906003)(76176011)(36756003)(316002)(52116002)(446003)(11346002)(6246003)(2616005)(99286004)(68736007)(53936002)(66476007)(64756008)(66446008)(66556008)(81166006)(6116002)(83716004)(8676002)(305945005)(81156014)(73956011)(66946007)(7736002)(486006)(8936002)(4326008)(46003)(186003)(25786009)(229853002)(256004)(14444005)(33656002)(5660300002)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1419;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I1u+o2dn0MWCMc4NFpOl0UH6X71RRr8WuahIIjMGVlWU9uXYp6SHXP2dW85t/4kWwKxjyu79WTntOHW3LGgn9VpXaLPuh1P7rNzESq+gox0Gsz8a33mx/oHvKoYW1350eEFKQAN9T34y4YJITPSrWp5m8y5G0y3F7wjnYslHpNoW/me/zrAoCDgMlx42mUsR+b0J5o7XPU0jcAcOfrS3aHKo3wYBbCQuKWfPqPZQRZy/ZNj/QHZzosnMO7YnHJO8OayzOgLjDrjlDHbmlhdKoMoIaFHzJliLybxanmq49Vb06TRRzOkywvdA1N2KEcpGpQ3gSkEZl5IgOw4OapUbqK84gj7lf+tjFjeXbwG/ZVAVXxUnMDLM3EhCfj/+dT7/FPK7lWDFzBPv/4F06A3Mgv3Euocw0aGuVxJfXkdXhwg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C87B893F411A8B46BFF9A154EABF4B8A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bea27b7b-232e-4f69-78c6-08d6d3b65761
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 13:09:02.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1419
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gOCBNYXkgMjAxOSwgYXQgMzoxNSwgTmlrb2xheSBCb3Jpc292IHdyb3RlOg0KDQo+IE9uIDcu
MDUuMTkg0LMuIDIwOjI3INGHLiwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+PiBXZSBoYXZlIGJlZW4g
c2VlaW5nIGlzc3VlcyBpbiBwcm9kdWN0aW9uIHdoZXJlIGEgY2xlYW5lciBzY3JpcHQgd2lsbCAN
Cj4+IGVuZA0KPj4gdXAgdW5saW5raW5nIGEgYnVuY2ggb2YgZmlsZXMgdGhhdCBoYXZlIHBlbmRp
bmcgaXB1dHMuICBUaGlzIG1lYW5zIA0KPj4gdGhleQ0KPj4gd2lsbCBnZXQgdGhlaXIgZmluYWwg
aXB1dCdzIHJ1biBhdCBidHJmcy1jbGVhbmVyIHRpbWUgYW5kIHRodXMgYXJlIA0KPj4gbm90DQo+
PiB0aHJvdHRsZWQsIHdoaWNoIGltcGFjdHMgdGhlIHdvcmtsb2FkLg0KPj4NCj4+IFNpbmNlIHdl
IGFyZSB1bmxpbmtpbmcgdGhlc2UgZmlsZXMgd2UgY2FuIGp1c3QgZHJvcCB0aGUgZGVsYXllZCBp
cHV0IA0KPj4gYXQNCj4+IHVubGluayB0aW1lLiAgV2UgYXJlIGFscmVhZHkgaG9sZGluZyBhIHJl
ZmVyZW5jZSB0byB0aGUgaW5vZGUgc28gdGhpcw0KPj4gd2lsbCBub3QgYmUgdGhlIGZpbmFsIGlw
dXQgYW5kIHRodXMgaXMgY29tcGxldGVseSBzYWZlIHRvIGRvIGF0IHRoaXMNCj4+IHBvaW50LiAg
RG9pbmcgdGhpcyBtZWFucyB3ZSBhcmUgbW9yZSBsaWtlbHkgdG8gYmUgZG9pbmcgdGhlIGZpbmFs
IA0KPj4gaXB1dA0KPj4gYXQgdW5saW5rIHRpbWUsIGFuZCB0aHVzIHdpbGwgZ2V0IHRoZSBJTyBj
aGFyZ2VkIHRvIHRoZSBjYWxsZXIgYW5kIA0KPj4gZ2V0DQo+PiB0aHJvdHRsZWQgYXBwcm9wcmlh
dGVseSB3aXRob3V0IGFmZmVjdGluZyB0aGUgbWFpbiB3b3JrbG9hZC4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBKb3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+DQo+PiAtLS0NCj4+ICBm
cy9idHJmcy9pbm9kZS5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBj
aGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lu
b2RlLmMgYi9mcy9idHJmcy9pbm9kZS5jDQo+PiBpbmRleCBiNmQ1NDljOTkzZjYuLmU1ODY4NWI1
ZDM5OCAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL2lub2RlLmMNCj4+ICsrKyBiL2ZzL2J0cmZz
L2lub2RlLmMNCj4+IEBAIC00MDA5LDYgKzQwMDksMjggQEAgc3RhdGljIGludCBfX2J0cmZzX3Vu
bGlua19pbm9kZShzdHJ1Y3QgDQo+PiBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KPj4gIAkJ
cmV0ID0gMDsNCj4+ICAJZWxzZSBpZiAocmV0KQ0KPj4gIAkJYnRyZnNfYWJvcnRfdHJhbnNhY3Rp
b24odHJhbnMsIHJldCk7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIElmIHdlIGhhdmUgYSBwZW5k
aW5nIGRlbGF5ZWQgaXB1dCB3ZSBjb3VsZCBlbmQgdXAgd2l0aCB0aGUgZmluYWwgDQo+PiBpcHV0
DQo+PiArCSAqIGJlaW5nIHJ1biBpbiBidHJmcy1jbGVhbmVyIGNvbnRleHQuICBJZiB3ZSBoYXZl
IGVub3VnaCBvZiB0aGVzZSANCj4+IGJ1aWx0DQo+PiArCSAqIHVwIHdlIGNhbiBlbmQgdXAgYnVy
bmluZyBhIGxvdCBvZiB0aW1lIGluIGJ0cmZzLWNsZWFuZXIgd2l0aG91dCANCj4+IGFueQ0KPj4g
KwkgKiB3YXkgdG8gdGhyb3R0bGUgdGhlIHVubGlua3MuICBTaW5jZSB3ZSdyZSBjdXJyZW50bHkg
aG9sZGluZyBhIA0KPj4gcmVmIG9uDQo+PiArCSAqIHRoZSBpbm9kZSB3ZSBjYW4gcnVuIHRoZSBk
ZWxheWVkIGlwdXQgaGVyZSB3aXRob3V0IGFueSBpc3N1ZXMgYXMgDQo+PiB0aGUNCj4+ICsJICog
ZmluYWwgaXB1dCB3b24ndCBiZSBkb25lIHVudGlsIGFmdGVyIHdlIGRyb3AgdGhlIHJlZiB3ZSdy
ZSANCj4+IGN1cnJlbnRseQ0KPj4gKwkgKiBob2xkaW5nLg0KPj4gKwkgKi8NCj4NCj4gRldJVyB0
aGUgY2FsbGVyIGlzIG5vdCByZWFsbHkgaG9sZGluZyBhbiBleHBsaWNpdCByZWZlcmVuY2UsIHJh
dGhlcg0KPiB0aGVyZSBpcyBhIHJlZmVyZW5jZSBoZWxkIGJ5IHRoZSBkZW50cnkgd2hpY2ggaXMg
Z29pbmcgdG8gYmUgZGlzcG9zZWQgDQo+IG9mDQo+IGJ5IHZmcy4gQ29uc2lkZXJpbmcgdGhpcyBJ
J2Qgc2F5IHRoaXMgaXMgYSBmYWxzZSBjbGFpbS4gSS5lICJ3ZSIgZG8gDQo+IG5vdA0KPiBob2xk
IGEgcmVmZXJlbmNlLg0KDQpJdCdzIGltcG9zc2libGUgdG8gY2FsbCB0aGlzIGZ1bmN0aW9uIHdp
dGhvdXQgYSByZWZlcmVuY2UgaGVsZCBvbiB0aGUgDQppbm9kZSwga2luZCBvZiBuaXQtcGlja2lu
ZyBvbiAid2UiIHZzICJ0aGUgdmZzIi4NCg0KPg0KPj4gKwlpZiAoIWxpc3RfZW1wdHkoJmlub2Rl
LT5kZWxheWVkX2lwdXQpKSB7DQo+PiArCQlzcGluX2xvY2soJmZzX2luZm8tPmRlbGF5ZWRfaXB1
dF9sb2NrKTsNCj4+ICsJCWlmICghbGlzdF9lbXB0eSgmaW5vZGUtPmRlbGF5ZWRfaXB1dCkpIHsN
Cj4+ICsJCQlsaXN0X2RlbF9pbml0KCZpbm9kZS0+ZGVsYXllZF9pcHV0KTsNCj4+ICsJCQlzcGlu
X3VubG9jaygmZnNfaW5mby0+ZGVsYXllZF9pcHV0X2xvY2spOw0KPj4gKwkJCWlwdXQoJmlub2Rl
LT52ZnNfaW5vZGUpOw0KPj4gKwkJCWlmIChhdG9taWNfZGVjX2FuZF90ZXN0KCZmc19pbmZvLT5u
cl9kZWxheWVkX2lwdXRzKSkNCj4+ICsJCQkJd2FrZV91cCgmZnNfaW5mby0+ZGVsYXllZF9pcHV0
c193YWl0KTsNCj4+ICsJCX0gZWxzZSB7DQo+PiArCQkJc3Bpbl91bmxvY2soJmZzX2luZm8tPmRl
bGF5ZWRfaXB1dF9sb2NrKTsNCj4+ICsJCX0NCj4+ICsJfQ0KPg0KPiBPVE9IIHRoaXMgcmVhbGx5
IGZlZWxzIGxpa2UgYSBoYWNrIGFuZCB0aGlzIHN0ZW1zIGZyb20gdGhlIGZhY3QgdGhhdA0KPiBp
cHV0IGlzIHJhdGhlciBydWRpbWVudGFyeS4gQWRkaXRpb25hbGx5IHlvdSBhcmUgZXNzZW50aWFs
bHkgDQo+IG9wZW5jb2RpbmcNCj4gdGhlIGJvZHkgb2YgYnRyZnNfcnVuX2RlbGF5ZWRfaXB1dHMu
IEkgd2FzIGdvaW5nIHRvIHN1Z2dlc3QgdG8gDQo+IGludHJvZHVjZQ0KPiBhIG5ldyBoZWxwZXIg
ZmFjdG9yaW5nIG91dCB0aGUgY29tbW9uIGNvZGUgYnV0IGl0IHdpbGwgZ2V0IHVnbHkgZHVlIHRv
DQo+IHRoZSBzcGluIGxvY2sgYmVpbmcgZHJvcHBlZCBiZWZvcmUgZG9pbmcgdGhlIGlwdXQuDQo+
DQo+IEJ1dCB0aGVuIEknbSByZWFsbHkgc3RhcnRpbmcgdG8gcXVlc3Rpb24gdGhlIHV0aWxpdHkg
b2YgZGVsYXllZCBpcHV0cy4NCj4gUHJlc3VtYWJseSBpdCB3YXMgYWRkZWQgdG8gZGVmZXIgdGhl
IGV4cGVuc2l2ZSBmaW5hbCBpcHV0IGluIHRoZSANCj4gY2xlYW5lcg0KPiBjb250ZXh0IG9yIGF2
b2lkIHNvbWUgZGVhZGxvY2tzIChidXQgd2UgZG9uJ3Qga25vdyB3aGljaCBleGFjdGx5KS4gDQo+
IFlldCwNCj4gaGVyZSB3ZSBhcmUgc29tZSB0aW1lIGxhdGVyIHdoZXJlIHlvdSBhcmUgZXNzZW50
aWFsbHkgc2F5aW5nICJ0aGlzDQo+IG1lY2hhbmlzbSBpcyBzdWJvcHRpbWFsIGJlY2F1c2UgaXQn
cyBkdW1iIGFuZCBpbnN0ZWFkIG9mIGltcHJvdmluZw0KPiB0aGluZ3MgaXQncyBtYWtpbmcgdGhl
bSB3b3JzZSBpbiBjZXJ0YWluIGNhc2VzLCBzbyBsZXQncyB1bmxvYWQgaXQgYSANCj4gYml0DQo+
IGJ5IGRvaW5nIGFuIGlwdXQgaGVyZSIuDQoNClRoZSBmaW5hbCBpcHV0IGlzIHByZXR0eSBleHBl
bnNpdmUsIHNpbmNlIGl0IHBvdGVudGlhbGx5IGRvZXMgdGhlIGZ1bGwgDQp0cnVuY2F0ZSBvZiBh
biBhcmJpdHJhcnkgc2l6ZWQgZmlsZS4gIFRoZXJlIGFyZSBhIGxvdCBvZiBjb250ZXh0cyBpdCAN
CmNhbid0IGJlIGNhbGxlZCBmcm9tLCBzbyB0aGUgZGVsYXllZCBpcHV0IGNvZGUgc2F2ZXMgdXMg
ZnJvbSBzb21lIA0KaW1wb3NzaWJsZSBzaXR1YXRpb25zLiAgSXQgb3JpZ2luYWxseSBjYW1lIGhl
cmU6DQoNCmNvbW1pdCAyNGJiY2YwNDQyZWUwNDY2MGE1YTAzMGVmZGJiNmQwM2YxYzI3NWNiDQpB
dXRob3I6IFlhbiwgWmhlbmcgPHpoZW5nLnlhbkBvcmFjbGUuY29tPg0KRGF0ZTogICBUaHUgTm92
IDEyIDA5OjM2OjM0IDIwMDkgKzAwMDANCg0KICAgICBCdHJmczogQWRkIGRlbGF5ZWQgaXB1dA0K
DQpCdXQgd2UndmUgZXhwYW5kZWQgdXNhZ2UgdG8gc29sdmUgYSBmZXcgZGlmZmVyZW50IGRlYWRs
b2Nrcy4NCg0KLWNocmlzDQo=
