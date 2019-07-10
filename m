Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C571647A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfGJNxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 09:53:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727528AbfGJNxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 09:53:23 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ADnPQI031198;
        Wed, 10 Jul 2019 06:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LSwHuOqw8ORrZCDHQsvG/QYCfmhr2ELeIl/jkZcYWrM=;
 b=ekrWL8wKWAmJd8pkzTY5jcY2oge6wvGrdYpvnMj9Cj9fmEAKW7e0ApVFklpBAHMDJ6eP
 GqPnYsu+6Amr0GGwcxrTHOc0d5QH/VMpUt83Sa+nSQj8JburLiCBCAg7lCVQ7vZiRBH6
 SIxrFOCHsY07afc7RcTE0H+kZ/9HUIM2Upc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tngys825v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Jul 2019 06:53:13 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 10 Jul 2019 06:53:12 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Jul 2019 06:53:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSwHuOqw8ORrZCDHQsvG/QYCfmhr2ELeIl/jkZcYWrM=;
 b=iZ1LC1mMRY8xJ1ECViknKbIr3unLR+50cpkhd8oACciYH4s45J25+GYo1vZfaqgUIFNKzuDrdswbO2O6+EuFhEpfE6Hq9RrEWuKFad2z9cCArLOXnDponvnhY7HPIw9IQf0a2VDT34a83+0MVpG4mm93zkWQDNH+mmdddr2ZSfk=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.159.10) by
 CY4PR15MB1638.namprd15.prod.outlook.com (10.175.119.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 13:53:11 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::7d62:c9a2:b34e:74fd]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::7d62:c9a2:b34e:74fd%6]) with mapi id 15.20.2052.019; Wed, 10 Jul 2019
 13:53:11 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Tejun Heo <tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jack@suse.cz" <jack@suse.cz>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHSET for-5.3/block] block: add blkcg bio punt mechanism
Thread-Topic: [PATCHSET for-5.3/block] block: add blkcg bio punt mechanism
Thread-Index: AQHVLSiKTltqM2bkpE2zuxFAnfDaGabD80mA
Date:   Wed, 10 Jul 2019 13:53:11 +0000
Message-ID: <be63af25-6245-18f8-4c0b-4f48682a34ed@fb.com>
References: <20190627203952.386785-1-tj@kernel.org>
In-Reply-To: <20190627203952.386785-1-tj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:610:20::17) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fa::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.144.74.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a7e2d01-0f5b-4854-236b-08d7053df255
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR15MB1638;
x-ms-traffictypediagnostic: CY4PR15MB1638:
x-microsoft-antispam-prvs: <CY4PR15MB16384134BFD5B6157ADB8E7AC0F00@CY4PR15MB1638.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(110136005)(5660300002)(66476007)(81166006)(71200400001)(53546011)(486006)(36756003)(66066001)(476003)(66556008)(25786009)(2616005)(4326008)(31696002)(14444005)(8676002)(316002)(68736007)(66946007)(11346002)(81156014)(64756008)(446003)(8936002)(229853002)(66446008)(2906002)(3846002)(6116002)(54906003)(52116002)(386003)(6506007)(14454004)(26005)(186003)(99286004)(6436002)(478600001)(71190400001)(256004)(305945005)(2501003)(86362001)(53936002)(102836004)(31686004)(7736002)(76176011)(6246003)(6512007)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1638;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kgg6ko+EVOYH4m2T0iyq8q31ANoSwocdu8shUmYMeGhIFJxNpxb/bkVW92WwZMop0EFqlJLPY2jXFI/40kDUWpy5ZVP7fsu5EyPy6ERW6eUkrOPNsvt4ZYcavXY2iBfMeZfDFigr+CQIwkHozYdvMykJrVTC8w854gptrhW54otZWC5MfFIRk6KOVl+T8ccToS7+/wuk9nG8cJKoKb1dso5PI/esZh8/t6Wooccph1GchR2DOYlk8Wm6orELF6tPDXxZgiE0X/ZVJhdL3ZtQMF8kCszs1a9sM2cM8peotlwv84jYjxlOWqwL6lBPaapzxztr0deOYZlzRz2O1cR24yH9alxc1LyPWqHO7SXAkoqAsioQEcUNUD47W/+I4olwss6lbWr5L+yS72/8wBfucyDqMuA1E0uGtnS/e3OYOuY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <791AA76E10A6A84997426D2AA76AE3C3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e2d01-0f5b-4854-236b-08d7053df255
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 13:53:11.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axboe@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1638
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100162
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gNi8yNy8xOSAyOjM5IFBNLCBUZWp1biBIZW8gd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gVGhp
cyBwYXRjaHNldCBjb250YWlucyBvbmx5IHRoZSBibG9jayBwYXJ0IG9mIHRoZSBmb2xsb3dpbmcN
Cj4gDQo+ICAgIFsxXSBbUEFUQ0hTRVQgdjIgYnRyZnMvZm9yLW5leHRdIGJsa2NnLCBidHJmczog
Zml4IGNncm91cCB3cml0ZWJhY2sgc3VwcG9ydA0KPiANCj4gd2l0aCB0aGUgZm9sbG93aW5nIGNo
YW5nZXMNCj4gDQo+ICAgKiB3YmNfYWNjb3VudF9pbygpIGlzIHJlbmFtZWQgdG8gd2JjX2FjY291
bnRfY2dyb3VwX293bmVyKCkgYW5kDQo+ICAgICB3YmMtPm5vX2FjY291bnRfaW8gdG8gd2JjLT5u
b19jZ3JvdXBfb3duZXIgZm9yIGNsYXJpdHkuDQo+IA0KPiBXaGVuIHdyaXRlYmFjayBpcyBleGVj
dXRlZCBhc3luY2hyb25vdXNseSAoZS5nLiBmb3IgY29tcHJlc3Npb24pLCBiaW9zDQo+IGFyZSBi
b3VuY2VkIHRvIGFuZCBpc3N1ZWQgYnkgd29ya2VyIHBvb2wgc2hhcmVkIGJ5IGFsbCBjZ3JvdXBz
LiAgVGhpcw0KPiBsZWFkcyB0byBzaWduaWZpY2FudCBwcmlvcml0eSBpbnZlcnNpb25zIHdoZW4g
Y2dyb3VwIElPIGNvbnRyb2wgaXMgaW4NCj4gdXNlIC0gSU9zIGZvciBhIGxvdyBwcmlvcml0eSBj
Z3JvdXAgY2FuIHRpZSBkb3duIHRoZSB3b3JrZXJzIGZvcmNpbmcNCj4gaGlnaGVyIHByaW9yaXR5
IElPcyB0byB3YWl0IGJlaGluZCB0aGVtLg0KPiANCj4gVGhpcyBwYXRjaHNldCBhZGRzIGFuIGJp
byBwdW50IG1lY2hhbmlzbSB0byBibGtjZyBhbmQgdXBkYXRlcyBidHJmcyB0bw0KPiBpc3N1ZSBh
c3luYyBJT3MgdGhyb3VnaCBpdC4gIEEgYmlvIHRhZ2dlZCB3aXRoIFJFUV9DR1JPVVBfUFVOVCBm
bGFnIGlzDQo+IGJvdW5jZWQgdG8gdGhlIGFzeW5jaHJvbm91cyBpc3N1ZSBjb250ZXh0IG9mIHRo
ZSBhc3NvY2lhdGVkIGJsa2NnIG9uDQo+IGJpb19zdWJtaXQoKS4gIEFzIHRoZSBiaW9zIGFyZSBp
c3N1ZWQgZnJvbSBwZXItYmxrY2cgd29yayBpdGVtcywNCj4gdGhlcmUncyBubyBjb25jZXJuIGZv
ciBwcmlvcml0eSBpbnZlcnNpb25zIGFuZCBpdCBkb2Vzbid0IHJlcXVpcmUNCj4gaW52YXNpdmUg
Y2hhbmdlcyB0byB0aGUgZmlsZXN5c3RlbXMuICBUaGUgbWVjaGFuaXNtIHNob3VsZCBiZQ0KPiBn
ZW5lcmFsbHkgdXNlZnVsIGZvciBJTyBjb250cm9sIHN1cHBvcnQgYWNyb3NzIGRpZmZlcmVudCBm
aWxlc3lzdGVtcy4NCg0KQXBwbGllZCBmb3IgNS4zLCB0aGFua3MgVGVqdW4uDQoNCi0tIA0KSmVu
cyBBeGJvZQ0KDQo=
