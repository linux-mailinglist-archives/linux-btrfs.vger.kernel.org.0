Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C980919E71
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 15:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfEJNqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 09:46:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbfEJNqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 09:46:13 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ADX9Z2025092;
        Fri, 10 May 2019 06:46:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HHw3zUpHT03xI06MTl/wkTQHbaEYi1n/HxwcoOS/0E0=;
 b=JGEDdwZRmFS7+twFUQzb8y9pSQRKug1+1+frkbBkuYV04/A18rpVLPaDKL6/IrkRxnHI
 9qdBLEfbirXzQVYjvZPyXho2LdppgHgIU/2oiQb4Lb3jSPZdaAk1gD64xK92K/NWtM95
 6JYFHndCNEtBK8PSN1/2gEfCjVZW0wpWmCw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sd3jk98wd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 06:46:08 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 10 May 2019 06:46:06 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 10 May 2019 06:46:06 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 10 May 2019 06:46:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHw3zUpHT03xI06MTl/wkTQHbaEYi1n/HxwcoOS/0E0=;
 b=LcbJSCh9kbB50dkC3pMGs74TgDUWR17B7E7RXzFk8cxAfNrhQOg9N3WwEd+/hpIsZ99eBW2/PMXI5cZBImBJKsGc2V9VzEx18nyuFRLPILMHo8w/JMqy5SoJAffl/cCQhNaDkohlSB9BKAFBPVbs/TO/4u8voEm00tNX/mytCQk=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1324.namprd15.prod.outlook.com (10.173.210.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 13:45:47 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13%5]) with mapi id 15.20.1878.019; Fri, 10 May 2019
 13:45:47 +0000
From:   Chris Mason <clm@fb.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Thread-Topic: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Thread-Index: AQHVByHcHj361c2vWkWOfcMgLPaHB6ZkXxGA
Date:   Fri, 10 May 2019 13:45:47 +0000
Message-ID: <18303EEF-24F1-40BB-9448-A55324AA119A@fb.com>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-15-jthumshirn@suse.de>
In-Reply-To: <20190510111547.15310-15-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::8888]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4b08e3d-fcb6-437d-e365-08d6d54dce9b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1324;
x-ms-traffictypediagnostic: DM5PR15MB1324:
x-microsoft-antispam-prvs: <DM5PR15MB13249BFA9231C1C5DB1B73AFD30C0@DM5PR15MB1324.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(396003)(376002)(189003)(199004)(486006)(256004)(305945005)(5660300002)(82746002)(54906003)(6512007)(186003)(11346002)(46003)(446003)(71200400001)(6916009)(71190400001)(6116002)(7736002)(476003)(86362001)(2616005)(14444005)(33656002)(83716004)(36756003)(53546011)(6506007)(386003)(50226002)(52116002)(64756008)(53936002)(102836004)(66556008)(81156014)(76176011)(73956011)(99286004)(229853002)(4326008)(66946007)(8676002)(316002)(8936002)(478600001)(68736007)(6486002)(2906002)(14454004)(66476007)(81166006)(6246003)(66446008)(6436002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1324;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VJJKNSbejLfUU3udbX6J71fn6wytM9nqPIeHaZnbiTu9Hebe3mVimZXDfrbLqo4RjSyx2tIWTZhbw8jroXwhyRt6SL/CmnyTmsH/Yj7cpojsZq0ZbfPTeQmJnqWAQFwlgc0tdhxiOd/TCiolnGQmKQ0KNYFZmi29kdQ1hYFvvb5YXzQGnzrDZbkTSIuAijelT9fXt86H9SG7yLYRah9MU61MCurN+8IqRScJ1Q8fglzdF6EtOdK4Gjp2XU/4d8e2EU8iuwIMtyESZc05iK/udGT4diRAx5izz7A54bO2qpJ/t/ZQvS2jyXch9IyPTr2MymRtZkPqU5u5y1fUQOvpD4vH373vhnh/YdSXPoZ3sxZjIqokd6eftsIJj65rGYys7zletBVmPiI93BI9ifW59fc2n2sfKiUzJlpaU6PBu08=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b08e3d-fcb6-437d-e365-08d6d54dce9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 13:45:47.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1324
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTAgTWF5IDIwMTksIGF0IDc6MTUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCg0KPiBD
dXJyZW50bHkgYnRyZnNfY3N1bV9kYXRhKCkgcmVsaWVkIG9uIHRoZSBjcmMzMmMoKSB3cmFwcGVy
IGFyb3VuZCB0aGUgDQo+IGNyeXB0bw0KPiBmcmFtZXdvcmsgZm9yIGNhbGN1bGF0aW5nIHRoZSBD
UkNzLg0KPg0KPiBBcyB3ZSBoYXZlIG91ciBvd24gY3J5cHRvX3NoYXNoIHN0cnVjdHVyZSBpbiB0
aGUgZnNfaW5mbyBub3csIHdlIGNhbg0KPiBkaXJlY3RseSBjYWxsIGludG8gdGhlIGNyeXB0byBm
cmFtZXdvcmsgd2l0aG91dCBnb2luZyB0cm91Z2ggdGhlIA0KPiB3cmFwcGVyLg0KDQpJdCBoYXMg
YmVlbiBhIHdoaWxlIHNpbmNlIEkgZHVnIHRocm91Z2ggdGhlIGNyeXB0b2FwaSBpbnRlcm5hbHMu
ICBJIGhhdmUgDQpvbmUgdmFndWUgYW5kIHNvbWV3aGF0IHVuZm91bmRlZCBjb25jZXJuLCB3aGVy
ZSB3ZSdyZSBkZWZpbmluZyB0aGUgZGlzayANCmZvcm1hdCB0byBiZSB3aGF0ZXZlciBpcyByZXR1
cm5lZCBmcm9tIGxvb2tpbmcgdXAgc2hhMjU2IG9yIGNyYzMyYyBpbiANCnRoZSBjcnlwdG8gdGFi
bGVzLiAgSSdtIG5vdCByZWFsbHkgc3VyZSBob3cgdG8gcmVzb2x2ZSB0aGlzIHNpbmNlIHdlIA0K
b2J2aW91c2x5IGRvbid0IHdhbnQgb3VyIG93biBzaGEyNTYgaW1wbGVtZW50YXRpb24uDQoNCkkn
bSBhIGxpdHRsZSBjb25jZXJuZWQgYWJvdXQgYWJvdXQgYnRyZnNfY3N1bV9kYXRhKCkgYW5kIA0K
YnRyZnNfY3N1bV9maW5hbCgpIGJlbG93LiAgV2UncmUgdXNpbmcgdHdvIGRpZmZlcmVudCANClNI
QVNIX0RFU0NfT05fU1RBQ0soKSBhbmQgdGhlbiBvdmVyd3JpdGluZyBpbnRlcm5hbHMgKHNoYXNo
X2Rlc2NfY3R4KCkpIA0Kd2l0aCB0aGUgYXNzdW1wdGlvbiB0aGF0IHdoYXRldmVyIHdlJ3JlIGRv
aW5nIGlzIGdvaW5nIHRvIGJlIHRoZSBzYW1lIGFzIA0KdXNpbmcgdGhlIHNhbWUgc2hhc2hfZGVz
YyBzdHJ1Y3QgZm9yIGJvdGggdGhlIHVwZGF0ZSBhbmQgZmluYWwgY2FsbHMuICBJIA0KdGhpbmsg
d2Ugc2hvdWxkIGJlIGVpdGhlciB1c2luZyBvciBhZGRpbmcgYSBoZWxwZXIgdG8gdGhlIGNyeXB0
byBhcGkgZm9yIA0KdGhpcy4gIFdlJ3JlIGRpZ2dpbmcgdG9vIGRlZXAgaW50byBjcnlwdG9hcGkg
cHJpdmF0ZSBzdHJ1Y3RzIHdpdGggdGhlIA0KY3VycmVudCB1c2FnZS4NCg0KT3RoZXJ3aXNlLCB0
aGFua3MgZm9yIGRvaW5nIHRoaXMsIGl0IGxvb2tzIGdyZWF0IG92ZXJhbGwuDQoNCi1jaHJpcw0K
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8anRodW1zaGlybkBzdXNl
LmRlPg0KPiAtLS0NCj4gIGZzL2J0cmZzL2Rpc2staW8uYyB8IDI4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGlzay1pby5jIGIvZnMvYnRyZnMv
ZGlzay1pby5jDQo+IGluZGV4IGZiMGIwNmI3YjlmNi4uMGM5YWM3YjQ1Y2U4IDEwMDY0NA0KPiAt
LS0gYS9mcy9idHJmcy9kaXNrLWlvLmMNCj4gKysrIGIvZnMvYnRyZnMvZGlzay1pby5jDQo+IEBA
IC0yNTMsMTIgKzI1MywzNiBAQCBzdHJ1Y3QgZXh0ZW50X21hcCAqYnRyZWVfZ2V0X2V4dGVudChz
dHJ1Y3QgDQo+IGJ0cmZzX2lub2RlICppbm9kZSwNCj4gIHUzMiBidHJmc19jc3VtX2RhdGEoc3Ry
dWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIGNvbnN0IGNoYXIgKmRhdGEsDQo+ICAJCSAgICB1
MzIgc2VlZCwgc2l6ZV90IGxlbikNCj4gIHsNCj4gLQlyZXR1cm4gY3JjMzJjKHNlZWQsIGRhdGEs
IGxlbik7DQo+ICsJU0hBU0hfREVTQ19PTl9TVEFDSyhzaGFzaCwgZnNfaW5mby0+Y3N1bV9zaGFz
aCk7DQo+ICsJdTMyICpjdHggPSAodTMyICopc2hhc2hfZGVzY19jdHgoc2hhc2gpOw0KPiArCXUz
MiByZXR2YWw7DQo+ICsJaW50IGVycjsNCj4gKw0KPiArCXNoYXNoLT50Zm0gPSBmc19pbmZvLT5j
c3VtX3NoYXNoOw0KPiArCXNoYXNoLT5mbGFncyA9IDA7DQo+ICsJKmN0eCA9IHNlZWQ7DQo+ICsN
Cj4gKwllcnIgPSBjcnlwdG9fc2hhc2hfdXBkYXRlKHNoYXNoLCBkYXRhLCBsZW4pOw0KPiArCUFT
U0VSVChlcnIpOw0KPiArDQo+ICsJcmV0dmFsID0gKmN0eDsNCj4gKwliYXJyaWVyX2RhdGEoY3R4
KTsNCj4gKw0KPiArCXJldHVybiByZXR2YWw7DQo+ICB9DQo+DQo+ICB2b2lkIGJ0cmZzX2NzdW1f
ZmluYWwoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHUzMiBjcmMsIHU4IA0KPiAqcmVz
dWx0KQ0KPiAgew0KPiAtCXB1dF91bmFsaWduZWRfbGUzMih+Y3JjLCByZXN1bHQpOw0KPiArCVNI
QVNIX0RFU0NfT05fU1RBQ0soc2hhc2gsIGZzX2luZm8tPmNzdW1fc2hhc2gpOw0KPiArCXUzMiAq
Y3R4ID0gKHUzMiAqKXNoYXNoX2Rlc2NfY3R4KHNoYXNoKTsNCj4gKwlpbnQgZXJyOw0KPiArDQo+
ICsJc2hhc2gtPnRmbSA9IGZzX2luZm8tPmNzdW1fc2hhc2g7DQo+ICsJc2hhc2gtPmZsYWdzID0g
MDsNCj4gKwkqY3R4ID0gY3JjOw0KPiArDQo+ICsJZXJyID0gY3J5cHRvX3NoYXNoX2ZpbmFsKHNo
YXNoLCByZXN1bHQpOw0KPiArCUFTU0VSVChlcnIpOw0KPiAgfQ0KPg0KPiAgLyoNCj4gLS0gDQo+
IDIuMTYuNA0K
