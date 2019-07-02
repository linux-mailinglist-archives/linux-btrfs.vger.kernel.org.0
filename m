Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA225CD57
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGBKJS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:09:18 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:55480 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbfGBKJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:09:17 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:09:01 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:22 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:22 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:21 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:21 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 03/14] btrfs-progs: image: Fix an access-beyond-boundary
 bug when there are 32 online CPUs
Thread-Topic: [PATCH v2 03/14] btrfs-progs: image: Fix an
 access-beyond-boundary bug when there are 32 online CPUs
Thread-Index: AQHVML3woB0F0HJdmEepVThyZpPJwA==
Date:   Tue, 2 Jul 2019 10:07:21 +0000
Message-ID: <20190702100650.2746-4-wqu@suse.com>
References: <20190702100650.2746-1-wqu@suse.com>
In-Reply-To: <20190702100650.2746-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [240e:3a1:c40:c630::a40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d2cd19e-ae32-4b33-f840-08d6fed51239
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB3284B6733F3C8CD9640BAEA7D6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nkpVRg5TjowoDsfockqJXPZiF7wIpBQ7cDT/U/wLaSx7yw5ftc4sLSBLRgMMgeT1xHLYscxjZgWxdWVHtkZKtggX0m23sqXIxkWckmoqhzBgDfkmbWFXd90Q5aZeg5gwdcun1HhJOjbROz5mkw2bwq+wmV1ImSgn77Bfn9T7eldPLb1YtAFa26sUBReanAYUjIk4WpjE3Wze7Cc5UjYQQlc7iOKqTUGnqsnqEv+Ra/0a37H+1nXhxjjjwK5BfDHWEidq1oHKY+LVh0JSATZyf5ItKvKyj/Z8RF1J5fURITub7Nq/SjDinT9XjKIV1FkFRJaVF7Y0akoqWAZc7jrkqfaPdzBbTcOUvW1FB982oyt1S8jCytJ0pQVmRCcpBKsfUmNypMPGCKybfvY1JtbS97jsdGvyuPmpiA0rLojLneE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2cd19e-ae32-4b33-f840-08d6fed51239
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:21.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqu@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3284
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When there are over 32 (in my example, 35) online CPUs, btrfs-image -c9
will just hang.

[CAUSE]
Btrfs-image has a hard coded limit (32) on how many threads we can use.
For the "-t" option we do the up limit check.

But when we don't specify "-t" option and speicified "-c" option, then
btrfs-image will try to auto detect the number of online CPUs, and use
it without checking if it's over the up limit.

And for num_threads larger than the up limit, we will over write the
adjust members of metadump_struct/mdrestore_struct, corrupting
pthread_mutex_t and pthread_cond_t, causing synchronising problem.

Nowadays, with SMT/HT and higher cpu core counts, it's not hard to go
beyond 32 threads, and hit the bug.

[FIX]
Just do extra num_threads check before using the number from sysconf().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/image/main.c b/image/main.c
index 9a07d9455e4f..c45d506812b2 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2701,6 +2701,7 @@ int main(int argc, char *argv[])
 
 			if (tmp <= 0)
 				tmp = 1;
+			tmp = min_t(long, tmp, MAX_WORKER_THREADS);
 			num_threads = tmp;
 		}
 	} else {
-- 
2.22.0

