Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047DA5B3E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 07:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfGAF2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 01:28:32 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:52010 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727298AbfGAF2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 01:28:32 -0400
X-Greylist: delayed 935 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jul 2019 01:28:31 EDT
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.146) BY m4a0039g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Mon,  1 Jul 2019 05:24:57 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 1 Jul 2019 05:12:48 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 1 Jul 2019 05:12:48 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3155.namprd18.prod.outlook.com (10.255.136.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 05:12:46 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Mon, 1 Jul 2019
 05:12:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     James Harvey <jamespharvey20@gmail.com>
Subject: [PATCH v2] btrfs: inode: Don't compress if NODATASUM or NODATACOW set
Thread-Topic: [PATCH v2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
Thread-Index: AQHVL8ue7nuhfXyQVU+BGsD2wENnxQ==
Date:   Mon, 1 Jul 2019 05:12:46 +0000
Message-ID: <20190701051225.17957-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SL2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::13) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wqu@microfocus.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [240e:3a1:c40:c630::aab]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66bba85f-e422-4a1e-1c08-08d6fde2c075
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3155;
x-ms-traffictypediagnostic: BY5PR18MB3155:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BY5PR18MB3155F93597673A0D1635710CD0F90@BY5PR18MB3155.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(54534003)(199004)(189003)(6506007)(386003)(52116002)(14454004)(7736002)(8936002)(81156014)(81166006)(8676002)(186003)(2351001)(2501003)(305945005)(102836004)(25786009)(1076003)(6916009)(2616005)(476003)(256004)(14444005)(486006)(2906002)(53936002)(6116002)(71190400001)(71200400001)(99286004)(42882007)(316002)(6512007)(6306002)(5660300002)(50226002)(68736007)(46003)(36756003)(66476007)(66556008)(64756008)(66446008)(66946007)(73956011)(6436002)(478600001)(6486002)(4326008)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3155;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microfocus.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zq9jdUMb3ENMm/11C8eDGuiN80cMywEXmHXhk/OyXmlBBJZEuP2bD0nYaBSakHZwcBgF8LjSUlHt/Ft1793f4bkmyDxmTm2trTsJRck0w0EFzToCt77rVfz3JPbWBa9zNqp9D63/hM3MyH73RoQgZdLU5t5zYqjyrMSWau7BDVQaoMOGGQTAUq0hN3ly6HjqxBlqn/TO4yNCu74owKTu9TRrmrrQR8InQhUM7jeXJ5YIvHNb9A5GQ9U2KN69X/CIsOcwqr2SX24K01tYK6qv1DQC5F0v9XUhlI+hEV84GkFED/ufuEAQXRmMmxRWkeCdA3wwg+h9Pjh/CwXjL3xnT/9mBXX/KSPUoi/2xRm9L1Gs5+T/6LWLryPJP9Vg+C8w7avocG91sU1n2GI40bRxxxeeVcXB4/RwHF5qOKk8xA0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bba85f-e422-4a1e-1c08-08d6fde2c075
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 05:12:46.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqu@microfocus.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3155
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

QXMgYnRyZnMoNSkgc3BlY2lmaWVkOg0KDQoJTm90ZQ0KCUlmIG5vZGF0YWNvdyBvciBub2RhdGFz
dW0gYXJlIGVuYWJsZWQsIGNvbXByZXNzaW9uIGlzIGRpc2FibGVkLg0KDQpJZiBOT0RBVEFTVU0g
b3IgTk9EQVRBQ09XIHNldCwgd2Ugc2hvdWxkIG5vdCBjb21wcmVzcyB0aGUgZXh0ZW50Lg0KDQpO
b3JtYWxseSBOT0RBVEFDT1cgaXMgZGV0ZWN0ZWQgcHJvcGVybHkgaW4gcnVuX2RlbGFsbG9jX3Jh
bmdlKCkgc28NCmNvbXByZXNzaW9uIHdvbid0IGhhcHBlbiBmb3IgTk9EQVRBQ09XLg0KDQpIb3dl
dmVyIGZvciBOT0RBVEFTVU0gd2UgZG9uJ3QgaGF2ZSBhbnkgY2hlY2ssIGFuZCBpdCBjYW4gY2F1
c2UNCmNvbXByZXNzZWQgZXh0ZW50IHdpdGhvdXQgY3N1bSBwcmV0dHkgZWFzaWx5LCBqdXN0IGJ5
Og0KICBta2ZzLmJ0cmZzIC1mICRkZXYNCiAgbW91bnQgJGRldiAkbW50IC1vIG5vZGF0YXN1bQ0K
ICB0b3VjaCAkbW50L2Zvb2Jhcg0KICBtb3VudCAtbyByZW1vdW50LGRhdGFzdW0sY29tcHJlc3Mg
JG1udA0KICB4ZnNfaW8gLWYgLWMgInB3cml0ZSAwIDEyOEsiICRtbnQvZm9vYmFyDQoNCkFuZCBp
biBmYWN0LCB3ZSBoYXZlIGEgYnVnIHJlcG9ydCBhYm91dCBjb3JydXB0ZWQgY29tcHJlc3NlZCBl
eHRlbnQNCndpdGhvdXQgcHJvcGVyIGRhdGEgY2hlY2tzdW0gc28gZXZlbiBSQUlEMSBjYW4ndCBy
ZWNvdmVyIHRoZSBjb3JydXB0aW9uLg0KKGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MTk5NzA3KQ0KDQpSdW5uaW5nIGNvbXByZXNzaW9uIHdpdGhvdXQgcHJvcGVy
IGNoZWNrc3VtIGNvdWxkIGNhdXNlIG1vcmUgZGFtYWdlIHdoZW4NCmNvcnJ1cHRpb24gaGFwcGVu
cywgYXMgY29tcHJlc3NlZCBkYXRhIGNvdWxkIG1ha2UgdGhlIHdob2xlIGV4dGVudA0KdW5yZWFk
YWJsZSwgc28gdGhlcmUgaXMgbm8gbmVlZCB0byBhbGxvdyBjb21wcmVzc2lvbiBmb3INCk5PREFU
QUNTVU0uDQoNClRoZSBmaXggd2lsbCByZWZhY3RvciB0aGUgaW5vZGUgY29tcHJlc3Npb24gY2hl
Y2sgaW50byB0d28gcGFydHM6DQotIGlub2RlX2Nhbl9jb21wcmVzcygpDQogIEFzIHRoZSBoYXJk
IHJlcXVpcmVtZW50LCBjaGVja2VkIGF0IGJ0cmZzX3J1bl9kZWxhbGxvY19yYW5nZSgpLCBzbyBu
bw0KICBjb21wcmVzc2lvbiB3aWxsIGhhcHBlbiBmb3IgTk9EQVRBU1VNIGlub2RlIGF0IGFsbC4N
Cg0KLSBpbm9kZV9uZWVkX2NvbXByZXNzKCkNCiAgQXMgdGhlIHNvZnQgcmVxdWlyZW1lbnQsIGNo
ZWNrZWQgYXQgYnRyZnNfcnVuX2RlbGFsbG9jX3JhbmdlKCkgYW5kDQogIGNvbXByZXNzX2ZpbGVf
cmFuZ2UoKS4NCg0KUmVwb3J0ZWQtYnk6IEphbWVzIEhhcnZleSA8amFtZXNwaGFydmV5MjBAZ21h
aWwuY29tPg0KU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQotLS0NCkNo
YW5nZWxvZzoNCnYyOg0KLSBSZWZhY3RvciBpbm9kZV9uZWVkX2NvbXByZXNzKCkgaW50byB0d28g
ZnVuY3Rpb25zDQotIFJlZmFjdG9yIGlub2RlX25lZWRfY29tcHJlc3MoKSB0byByZXR1cm4gYm9v
bA0KLS0tDQogZnMvYnRyZnMvaW5vZGUuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9idHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUu
Yw0KaW5kZXggYTJhYWJkYjg1MjI2Li5iZTFjYWJmMzU2ODAgMTAwNjQ0DQotLS0gYS9mcy9idHJm
cy9pbm9kZS5jDQorKysgYi9mcy9idHJmcy9pbm9kZS5jDQpAQCAtMzk0LDI0ICszOTQsNDkgQEAg
c3RhdGljIG5vaW5saW5lIGludCBhZGRfYXN5bmNfZXh0ZW50KHN0cnVjdCBhc3luY19jaHVuayAq
Y293LA0KIAlyZXR1cm4gMDsNCiB9DQogDQotc3RhdGljIGlubGluZSBpbnQgaW5vZGVfbmVlZF9j
b21wcmVzcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1NjQgc3RhcnQsIHU2NCBlbmQpDQorLyoNCisg
KiBDaGVjayBpZiB0aGUgaW5vZGUgY2FuIGFjY2VwdCBjb21wcmVzc2lvbi4NCisgKg0KKyAqIFRo
aXMgY2hlY2tzIGZvciB0aGUgaGFyZCByZXF1aXJlbWVudCBvZiBjb21wcmVzc2lvbiwgaW5jbHVk
aW5nIENvVyBhbmQNCisgKiBjaGVja3N1bSByZXF1aXJlbWVudC4NCisgKi8NCitzdGF0aWMgaW5s
aW5lIGJvb2wgaW5vZGVfY2FuX2NvbXByZXNzKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQorew0KKwlp
ZiAoQlRSRlNfSShpbm9kZSktPmZsYWdzICYgQlRSRlNfSU5PREVfTk9EQVRBQ09XIHx8DQorCSAg
ICBCVFJGU19JKGlub2RlKS0+ZmxhZ3MgJiBCVFJGU19JTk9ERV9OT0RBVEFTVU0pDQorCQlyZXR1
cm4gZmFsc2U7DQorCXJldHVybiB0cnVlOw0KK30NCisNCisvKg0KKyAqIENoZWNrIGlmIHRoZSBp
bm9kZSBuZWVkIGNvbXByZXNzaW9uLg0KKyAqDQorICogVGhpcyBjaGVja3MgZm9yIHRoZSBzb2Z0
IHJlcXVpcmVtZW50IG9mIGNvbXByZXNzaW9uLg0KKyAqLw0KK3N0YXRpYyBpbmxpbmUgYm9vbCBp
bm9kZV9uZWVkX2NvbXByZXNzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHU2NCBzdGFydCwgdTY0IGVu
ZCkNCiB7DQogCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gYnRyZnNfc2IoaW5vZGUt
Pmlfc2IpOw0KIA0KKwlpZiAoIWlub2RlX2Nhbl9jb21wcmVzcyhpbm9kZSkpIHsNCisJCVdBUk4o
SVNfRU5BQkxFRChDT05GSUdfQlRSRlNfREVCVUcpLA0KKwkJCUtFUk5fRVJSICJCVFJGUzogdW5l
eHBlY3RlZCBjb21wcmVzc2lvbiBmb3IgaW5vICVsbHVcbiIsDQorCQkJYnRyZnNfaW5vKEJUUkZT
X0koaW5vZGUpKSk7DQorCQlyZXR1cm4gZmFsc2U7DQorCX0NCiAJLyogZm9yY2UgY29tcHJlc3Mg
Ki8NCiAJaWYgKGJ0cmZzX3Rlc3Rfb3B0KGZzX2luZm8sIEZPUkNFX0NPTVBSRVNTKSkNCi0JCXJl
dHVybiAxOw0KKwkJcmV0dXJuIHRydWU7DQogCS8qIGRlZnJhZyBpb2N0bCAqLw0KIAlpZiAoQlRS
RlNfSShpbm9kZSktPmRlZnJhZ19jb21wcmVzcykNCi0JCXJldHVybiAxOw0KKwkJcmV0dXJuIHRy
dWU7DQogCS8qIGJhZCBjb21wcmVzc2lvbiByYXRpb3MgKi8NCiAJaWYgKEJUUkZTX0koaW5vZGUp
LT5mbGFncyAmIEJUUkZTX0lOT0RFX05PQ09NUFJFU1MpDQotCQlyZXR1cm4gMDsNCisJCXJldHVy
biBmYWxzZTsNCiAJaWYgKGJ0cmZzX3Rlc3Rfb3B0KGZzX2luZm8sIENPTVBSRVNTKSB8fA0KIAkg
ICAgQlRSRlNfSShpbm9kZSktPmZsYWdzICYgQlRSRlNfSU5PREVfQ09NUFJFU1MgfHwNCiAJICAg
IEJUUkZTX0koaW5vZGUpLT5wcm9wX2NvbXByZXNzKQ0KIAkJcmV0dXJuIGJ0cmZzX2NvbXByZXNz
X2hldXJpc3RpYyhpbm9kZSwgc3RhcnQsIGVuZCk7DQotCXJldHVybiAwOw0KKwlyZXR1cm4gZmFs
c2U7DQogfQ0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZCBpbm9kZV9zaG91bGRfZGVmcmFnKHN0cnVj
dCBidHJmc19pbm9kZSAqaW5vZGUsDQpAQCAtMTYzMCw3ICsxNjU1LDggQEAgaW50IGJ0cmZzX3J1
bl9kZWxhbGxvY19yYW5nZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgcGFnZSAqbG9ja2Vk
X3BhZ2UsDQogCX0gZWxzZSBpZiAoQlRSRlNfSShpbm9kZSktPmZsYWdzICYgQlRSRlNfSU5PREVf
UFJFQUxMT0MgJiYgIWZvcmNlX2Nvdykgew0KIAkJcmV0ID0gcnVuX2RlbGFsbG9jX25vY293KGlu
b2RlLCBsb2NrZWRfcGFnZSwgc3RhcnQsIGVuZCwNCiAJCQkJCSBwYWdlX3N0YXJ0ZWQsIDAsIG5y
X3dyaXR0ZW4pOw0KLQl9IGVsc2UgaWYgKCFpbm9kZV9uZWVkX2NvbXByZXNzKGlub2RlLCBzdGFy
dCwgZW5kKSkgew0KKwl9IGVsc2UgaWYgKCFpbm9kZV9jYW5fY29tcHJlc3MoaW5vZGUpIHx8DQor
CQkgICAhaW5vZGVfbmVlZF9jb21wcmVzcyhpbm9kZSwgc3RhcnQsIGVuZCkpIHsNCiAJCXJldCA9
IGNvd19maWxlX3JhbmdlKGlub2RlLCBsb2NrZWRfcGFnZSwgc3RhcnQsIGVuZCwgZW5kLA0KIAkJ
CQkgICAgICBwYWdlX3N0YXJ0ZWQsIG5yX3dyaXR0ZW4sIDEsIE5VTEwpOw0KIAl9IGVsc2Ugew0K
LS0gDQoyLjIyLjANCg0K
