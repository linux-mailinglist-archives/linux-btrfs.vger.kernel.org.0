Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2138619D7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfEJM5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 08:57:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45764 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbfEJM5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 08:57:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ACqlb1015300;
        Fri, 10 May 2019 05:56:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UyZl9/f+/aCY2sNQv3saR+fQJzeIumo6CBS8f9SDI94=;
 b=h+BlHK1rFg7shDy7MLYtEeek4zJaoL1Vj9XPZX2oqbT3HMKyxN4RgM7gk/MSKC3wJcj7
 3N4pYWhFkVu4sWzk3TsJADGgMa3vtT8XjS0SqONCHg/9DXts98E4tzW89XAeAqykgsus
 Af3huGvFDXrqQ6U8Edb46QFkJI9zvfZW0gw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2scv04jc6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 05:56:57 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 10 May 2019 05:56:57 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 10 May 2019 05:56:56 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 10 May 2019 05:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyZl9/f+/aCY2sNQv3saR+fQJzeIumo6CBS8f9SDI94=;
 b=PfQAc0gAtIzss0fqmMJuenGCgEddr84SoI6cLQN6jUYcOxfMqNueJq1ycU21t9HyN7Vef4PUu9SEbAHsn8EaUCWgiKuOhj48I3lM/rLp+TrGED9POpKzuGI5Us+IrVOiIL9adyPhxWiz1lg59vd+nt7sOyIkXCDt9+8j5gh3OGw=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1243.namprd15.prod.outlook.com (10.173.209.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 12:56:55 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13%5]) with mapi id 15.20.1878.019; Fri, 10 May 2019
 12:56:55 +0000
From:   Chris Mason <clm@fb.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/17] btrfs: use btrfs_crc32c() instead of
 btrfs_name_hash()
Thread-Topic: [PATCH 04/17] btrfs: use btrfs_crc32c() instead of
 btrfs_name_hash()
Thread-Index: AQHVByHS2iwS3kT2KEG4xHDiBdnQuqZkUWkA
Date:   Fri, 10 May 2019 12:56:54 +0000
Message-ID: <AC9DC8F5-8DE8-4BF1-BC7A-814CC4DA0FED@fb.com>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-5-jthumshirn@suse.de>
In-Reply-To: <20190510111547.15310-5-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: MN2PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:208:134::20) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::8888]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df6380dc-36c0-4bb0-9d9e-08d6d546fa7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1243;
x-ms-traffictypediagnostic: DM5PR15MB1243:
x-microsoft-antispam-prvs: <DM5PR15MB124394E2C56964ADAF123894D30C0@DM5PR15MB1243.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(136003)(39860400002)(189003)(199004)(46003)(76176011)(81166006)(81156014)(53936002)(2906002)(8936002)(50226002)(33656002)(52116002)(8676002)(99286004)(6512007)(6246003)(386003)(6506007)(53546011)(6916009)(6486002)(6436002)(186003)(102836004)(229853002)(36756003)(82746002)(14454004)(68736007)(305945005)(7736002)(478600001)(11346002)(4326008)(54906003)(446003)(2616005)(25786009)(4744005)(6116002)(486006)(5660300002)(256004)(73956011)(316002)(64756008)(66946007)(66476007)(66556008)(66446008)(86362001)(476003)(83716004)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1243;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gfCWH++9ktCDVn2PwLSFbTEDJdnwCUQ8vCXwPzZ/EFrKmTXxHj52IB6F7X5usd8+mBu1+kcsEa1np19R6Sl/Q4DyZ9rqMZOFk1lUuJhgTH7JM5jC+Dso+wtiKUZzucCC8WGodNcEdDhO5gKHSvVQpvBVJ/1ZXuX0cJVn1jiBvN6BPqNOQ7BZWdhnfIDV33K5HHEOZcsJ5tl0FWbzZKkjmUrfgOLy3IjPVtcmBPFZhvi6YrVrrDrab4yLwURbbcoVU75EyTFZ6kAwZAvd8JycCmo0Jpq2qSLAz3wLJr4D3Y/f7g0idlBjSR2hm2at5VJ5C0pas+UyPtXOQkvCXf59BVDLJDBqyYEuS6gaStZYu+qKxrplRDaEXn5CnyjkWnp4+ckwxTJmT6mEzGz8EFYztnHugoWyjQUwi6NHutLzXlY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: df6380dc-36c0-4bb0-9d9e-08d6d546fa7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 12:56:55.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1243
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTAgTWF5IDIwMTksIGF0IDc6MTUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCg0KPiBM
aWtlIGJ0cmZzX2NyYzMyYygpIGJ0cmZzX25hbWVfaGFzaCgpIGlzIG9ubHkgYSBzaGltIHdyYXBw
ZXIgb3ZlciB0aGUNCj4gY3JjMzJjKCkgbGlicmFyeSBmdW5jdGlvbi4gU28gd2UgY2FuIGp1c3Qg
dXNlIGJ0cmZzX2NyYzMyYygpIGluc3RlYWQgDQo+IG9mDQo+IGJ0cmZzX25hbWVfaGFzaCgpLg0K
DQpSZWFkaW5nIHRocm91Z2ggdGhlIHJlc3Qgb2YgdGhlIHNlcmllcywgYnV0IEkgdGhpbmsgdXNp
bmcgDQpidHJmc19uYW1lX2hhc2goKSBpcyBtb3JlIGNsZWFyIGFuZCBsZXNzIGVycm9yIHByb25l
Og0KDQo+IC0Ja2V5Lm9mZnNldCA9IGJ0cmZzX25hbWVfaGFzaChuYW1lLCBuYW1lX2xlbik7DQo+
ICsJa2V5Lm9mZnNldCA9ICh1NjQpIGJ0cmZzX2NyYzMyYygodTMyKX4xLCBuYW1lLCBuYW1lX2xl
bik7DQoNCkl0IGdyb3VwcyB0b2dldGhlciBldmVyeW9uZSB1c2luZyBjcmMzMmMgYXMgYSBkaXJl
Y3RvcnkgbmFtZSBoYXNoIChvciANCmV4dHJlZiBoYXNoKSwgc28gdGhhdCBpZiB3ZSBldmVyIHdh
bnQgdG8gYWRkIGRpZmZlcmVudCBoYXNoZXMgbGF0ZXIgZG93biANCnRoZSBsaW5lLCBpdCdzIHJl
YWxseSBjbGVhciB3aGF0IG5lZWRzIHRvIGNoYW5nZSBmb3Igd2hhdCBwdXJwb3NlLiAgV2l0aCAN
CmV2ZXJ5b25lIGNhbGxpbmcgaW50byBidHJmc19jcmMzMmMgZGlyZWN0bHksIHlvdSBoYXZlIHRv
IHNwZW5kIG1vcmUgdGltZSANCmxvb2tpbmcgdGhyb3VnaCBoaXN0b3J5IHRvIGZpZ3VyZSBvdXQg
aG93IHRvIGNoYW5nZSBpdC4NCg0KQWxzbywgc3ByaW5rbGluZyAodTMyKX4xIG1ha2VzIHRoZSBj
b2RlIGxlc3MgcmVhZGFibGUgaW1oby4NCg0KLWNocmlzDQo=
