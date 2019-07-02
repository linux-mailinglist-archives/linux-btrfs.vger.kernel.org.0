Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9F5CD81
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfGBKZc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:25:32 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:37576 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfGBKZb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:25:31 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.190) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:25:21 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:12 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:11 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:11 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:10 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 00/14] btrfs-progs: image: Enhance and bug fixes
Thread-Topic: [PATCH v2 00/14] btrfs-progs: image: Enhance and bug fixes
Thread-Index: AQHVML3p3lb4ujf/1UWhpeZS3xTe2w==
Date:   Tue, 2 Jul 2019 10:07:10 +0000
Message-ID: <20190702100650.2746-1-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: 9cd56d86-d462-4ce4-3cd4-08d6fed50bf1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB3284ABBDEA285AA5271A70B4D6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(54534003)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(52116002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KMO/0kiEhUNVxEtJnmTzllPqElNUWSOUWp9a8cQhCX7o0rUFRZDDbbj/U+530FPavN7WDVFN0F275uqBSKi/BtaBjNuQK3TlTsm6fcofkHXCrvmklviQrNy6oI1HWlugF+24q5KRjJqDtqbjtttABJDHBir9yg+j46zHh8/l2wQNnPYXP8kqGYq7jzOpBOC6YQRaA1D9+kWUdL+9gj7OG7M56MawvCMzlRAVple4e0L3cTIbEGW6P6wl8KOWNpfT91JIyXauvJuPug0GrZ26mOC9TSRfXIfaRCDPy/7+iI6rDot7f29o1QujPySHjBbwJOLW5o+ecpuIyK+Load2CkUmuaCXwmL1Q/d3rh96wtnNF3Q229ePtJWwqpHlMIqLNENFwkCPjYate316QYsg4pbFF/J9zgO24AQcivlsIA8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd56d86-d462-4ce4-3cd4-08d6fed50bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:10.8458
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

This patchset is based on v5.1.1 tag.

With this update, the patchset has the following features:
- various small fixes and enhancements for btrfs-image
  * Fix an indent misalign
  * Fix an access-beyond-boundary bug
  * Fix a confusing error message due to unpopulated errno
  * Output error message for chunk tree build error
  * Use SZ_* to replace intermediate number
  * Verify superblock before restore

- btrfs-image dump support 
  This introduce a new option -d to dump data.
  Due to item size limit, we have to enlarge the existing limit from
  256K (enough for tree blocks, but not enough for free space cache) to
  256M.
  This change will cause incompatibility, thus we have to introduce a
  new magic as version. While keeping all other on-disk format the same.

- Reduce memory usage for both compressed and uncompressed images
  Originally for compressed extents, we will use 4 * max_pending_size as
  output buffer, which can be 1G for 256M newer limit.

  Change it to use at most 512K for compressed extent output buf, and
  also use 512K fixed buffer size for uncompressed extent.

- btrfs-image restore optimization
  This will speed up chunk item search during restore.

Changelog:
v2:
- New small fixes:
  * Fix a confusing error message due to unpopulated errno
  * Output error message for chunk tree build error
  
- Fix a regression of previous version
  Patch "btrfs-progs: image: Rework how we search chunk tree blocks"
  deleted a "ret = 0" line which could cause false early exit.

- Reduce memory usage for data dump

Qu Wenruo (14):
  btrfs-progs: image: Use SZ_* to replace intermediate size
  btrfs-progs: image: Fix an indent misalign
  btrfs-progs: image: Fix an access-beyond-boundary bug when there are
    32 online CPUs
  btrfs-progs: image: Verify the superblock before restore
  btrfs-progs: image: Introduce framework for more dump versions
  btrfs-progs: image: Introduce -d option to dump data
  btrfs-progs: image: Allow restore to record system chunk ranges for
    later usage
  btrfs-progs: image: Introduce helper to determine if a tree block is
    in the range of system chunks
  btrfs-progs: image: Rework how we search chunk tree blocks
  btrfs-progs: image: Reduce memory requirement for decompression
  btrfs-progs: image: Don't waste memory when we're just extracting
    super block
  btrfs-progs: image: Reduce memory usage for chunk tree search
  btrfs-progs: image: Output error message for chunk tree build error
  btrfs-progs: image: Fix error output to show correct return value

 disk-io.c        |   6 +-
 disk-io.h        |   1 +
 image/main.c     | 874 +++++++++++++++++++++++++++++++++++------------
 image/metadump.h |  15 +-
 4 files changed, 666 insertions(+), 230 deletions(-)

-- 
2.22.0

