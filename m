Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBFC44E2C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 09:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhKLIH5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 03:07:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10016 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232346AbhKLIH4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 03:07:56 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC5xjs6024107;
        Fri, 12 Nov 2021 08:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=wZNGfOvLbeiLFJZUm+N6O+a33RyPr5XAIWdnMdq/r9s=;
 b=qfYcsU+Tzgom8s5Z68Vy/KH9HxERBX0ZXBHqgoWUlGrNVjxXwDd9OmfNeIk6g5em6db8
 U/irV6mGl/UehVE8IyltLiEMI04gA9Fl/U6BZnMCj8YPoif/HCDjTeAZoMV3wt4IC0RW
 uLhv4F1W6yMBiI0AwOLwI55A0qtYJXon17lIcserSivAt9Auj+Fr59uRyNAKDV2kaYUI
 lRnQKL+ifUcHAFvJOrx6yrkglaBEJCm/leFtAXkE8Zi7/KS0mZvq6Ik7piSzStbsvC6j
 mBp67PiSWvvglkUpvrjx5kg8niABuuhB8SYtGQJawOdEXpJSHK1Qyod/VmB9V/lU1JYW 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c85nsp8td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 08:05:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AC7umQO053068;
        Fri, 12 Nov 2021 08:05:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 3c63fx89j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 08:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/5ZLvpSBM4Rz8jwwIdJJDkJrxfZPTzMSXYwQf1ip807SiA0HkncybTpJ4Nu4L9NcLCsXPdbo9ejC8KTKg9eAJ07HzboCO99AcuG9ijI1O1vxWCBGSaVK/kJmXbEzX/HiN/BAgyDPFenBKWo5VYrW8SiOyBQLP03eBz1LA0nhiUHgnq1UgSj2HSK3zedy8MdcXMJ1SxRCf7RtOmQmKU36RUpogK1N3JkD1Edg0cR11y6N12Gvk0Z2Y7Hr4cWOH5dS2dcsovqFVJ7A8xL5Y8z2wCJoNdIsKcqlY14pu6JZdIHalMxJ1I9o0AQ+XNrbpJ5crYrRLpbaIl8kVB9xRdGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZNGfOvLbeiLFJZUm+N6O+a33RyPr5XAIWdnMdq/r9s=;
 b=b4oUSelJyxFEPj9ogHpVnoD11di9LejCs13PvYkW3IxHW4vsgbVS0mX/zE2oJuYCUO6Q1Bdy1f4MVmqDywWqkQsxSpiQWT9okIkfuz1VGUIkkaAYYCwDgZGFs+DCJ86cuMeieiz4m88RMG+iHWj+yDRm12676/C2rgxGW8chXRRhNqEKaNhAJ1l7wngV8uOYMaqiVpVPSDsPl1h+Dx9zp61D5Y3k3G85l1uDfZWYBNNMBqjCwK+dF6ru+bveLU1T3NS3uwGxsH8J2aRR8k6SkM3DgWojCJTmmUjOuE+n9hCzo1ltIEmj6+xLDeMRHJyIa+RcoC7O+3hbdLxnv1ENzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZNGfOvLbeiLFJZUm+N6O+a33RyPr5XAIWdnMdq/r9s=;
 b=dotLlWqx1cNaTHdTNJ40HIoUQDpGziwAWWqHKOK20w6KKYrhggZtwva1fjwDvaKsUlIKQcwtggZPErJo9G92q1TWPfQwmk1w07JKTWRcm4ekygq92G04Qsqme84g4VXJFOltbTSTIqkTqlBGS7Ti6AysQHGT0YpGM71XKK9AVmE=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Fri, 12 Nov
 2021 08:04:58 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4690.020; Fri, 12 Nov 2021
 08:04:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     josef@toxicpanda.com
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] fsperf: get the running section in the setup
Date:   Fri, 12 Nov 2021 16:04:38 +0800
Message-Id: <2aa6fbb5e415251faeca9eaa01526a6f7333517e.1636678798.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1636678798.git.anand.jain@oracle.com>
References: <cover.1636678798.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend Transport; Fri, 12 Nov 2021 08:04:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de02e75d-6ae5-4e30-ca3b-08d9a5b31e61
X-MS-TrafficTypeDiagnostic: BLAPR10MB4980:
X-Microsoft-Antispam-PRVS: <BLAPR10MB49807D93B7D3922359B0FCC2E5959@BLAPR10MB4980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaPhHtCXGmnJmHzRKAjnAcxZS/Im1/am5fLvIZ3WIF/mhOewm+I3Zr72u2Uy0x7dthtQFmifRjoWBIhQDMr/3TPEREGgd44tqNPSJ5Yha4uOEwsNSSJ2qstQmtt50CF7sBOKJbsA9fJ9Ogzo7C7f1j6h3bIe09Fxh1KKdle8RdMtdbuHLCKQQCivEv77zFeUMPMIgjruWwDGm+fmFGh+gEkrN7/7cvUGU+dERUmJuDcN0t2S3yY5LUJghlQ8KW9RhjhdcOy0GTApX0JGR+JVeigBlMzGWDrL5oTIARIDksim2TdL4rzyUyRo7TS1FFg6YduQpEalFwIL2pVVpt+I+NFNi6BnjdDUfTrS9iBDDOZDD1ZTFOqCuqGXCvlDpBu1BOn8BWpeNkJvLrpKE+HaRoT4KKltxiZlJdv0WOXYhETrTLkQtNqkaIus/tA2hTEAJ5wwEpDSvfbfqE5Jx7AqmEYCMRHhaEQLDQgbsTs5zU1pXIrP/zKdV469xhs3kKKM3p5FeLpNDdkSxp8tveunvhRl/3B+ZTCuN32KY61e6HveXusinjnxdvg+0shxK9es8AcZWtZgg/0RptgiyxjfDedcS5MpCXhZazTk5Nga7t5TW3TP/INbFbXy7Ihs+xwIeZdHrbR4tg+4SZank347JJMhAH2UVejQFhetcXgX2ucrL3aeTS5Ud7LHOeNeHv1XZADFpsHzMxRrPYEa1T7gkuQID8zOef4E2gJmBa32dHpRoSEsXjRSFrMb2bpukk3K9F0YiJRqmwhTGCP1+QPogZrwkruY22Ra4KrX20FPaambmP3BlG/W2wxBoL5suc/k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6506007)(83380400001)(44832011)(66946007)(966005)(52116002)(2906002)(4326008)(6486002)(508600001)(6666004)(38100700002)(316002)(8936002)(38350700002)(66556008)(66476007)(6916009)(26005)(2616005)(5660300002)(956004)(6512007)(186003)(8676002)(86362001)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1xm0USBanax57k3KKY9BtCTHyMKo7Npypbc4bAsBf8/+l1M6ZKnyM0OczGr?=
 =?us-ascii?Q?lEmhJYgykWvnFlT5+6vhJUQFxWmVrR8z6RGx5wuVwyA+7EGvTry+SR8EKdD3?=
 =?us-ascii?Q?1YVKkMlMEGMe7IHwsGxUPnRq1ic87Lh4Fg7ZRB+eZwhDUEuCpIwXTdyNcPqT?=
 =?us-ascii?Q?Iw3FH1d1wj8/UoszeoOdrA5+/OJcpxL0+VAWMQ1ftGqU1LIsx3OtwnGpOjXu?=
 =?us-ascii?Q?VJQqZ22l2PZQHoeBBt7sxiIhC8yOFXsvwpoC4d2Lgrq6Mj9OB0Hz1Wvu8Wwl?=
 =?us-ascii?Q?BuFYh4hC5FsviN0/cPXaipLZtoYySFEi/tl6sgExrdbr82CnZSx8y4sN1UuK?=
 =?us-ascii?Q?wWdUUUKbZGnM7KiSjky1uuZ98ENVlPv7j+j0nSYUAkWqRfbei/ykVW//NhM/?=
 =?us-ascii?Q?lxU/ae0Hs0bu+Ru9W1ehZO3FakdY7n1y9uQS6Z6S7WFlLOSAdFq+LeB5+sin?=
 =?us-ascii?Q?V3indND9BiDI6O5Zp+9PhnBi8Bvfz15plWRWn58dAm5IyCTQcy3ay6kGNjVk?=
 =?us-ascii?Q?/8ucru2wCysy4Ad1FbbkRGXSs4xylgn/52gkhhhdCbQSy2NAAn7K24WRNVea?=
 =?us-ascii?Q?Jab1aqvep3e4wg1ibXAJALm/z9Gm/j9UDlgGdSD3sW6tVcn2+D1FsaPszyTO?=
 =?us-ascii?Q?tieVZ0QyICSBPauRSAOzFzlkrMwqjSAcSxVqqgLey+lhYJXFpn7w+Y9Wms41?=
 =?us-ascii?Q?6Y1E2xHgLVUbgJf409fU/SP7eFHSTVuLsMCq0fbbO4A9AigFHzV7MZJEU/kY?=
 =?us-ascii?Q?LW2VjpldaInqZ+hjOmqnmd4iSPQ9EB+BVCMrgqON6n1ImR859GVc+11hVUL0?=
 =?us-ascii?Q?aExjTUStyFqWGyejwzvYueF7cEnaX5WPG4Gld4xttXhZv+UGYjJGyFAT6t/z?=
 =?us-ascii?Q?7dkUT1h/dGhW4KmBcxOoiyaRVTYR2bws3TyVUfvwT/d3XGtJYI4xT0MjTjP3?=
 =?us-ascii?Q?UKp0GYQdt0b8D2Op07aeF2pXcwqTWkA4wnN+IgGh833USXi51Gd/aLGLeBvb?=
 =?us-ascii?Q?SkgCOgeUCb1PDlxNS04t357tAwiNcASYh7eOefaxHyN8TR1fKxevkVLpcqoC?=
 =?us-ascii?Q?4iIlwU+FsLDv/96zF3Fxg5KsC0nh4xFd/UUo0TRS4ZEho0pwJ4h6FA64ffs+?=
 =?us-ascii?Q?kF2zY8q9IlaVsXLo6izqfPcVz21YcPp1U4ihKeUvQVrAEdqlZNO9W7LaLamS?=
 =?us-ascii?Q?p0hEBdVnoIssx01NktgWfdfrnMK8UVZMZzCat2ded0hsD28KgBQvru+Mp7OD?=
 =?us-ascii?Q?xNNBpT54LcaySeNNyOcMFOKaHajKMcjCbDgiE8XUEEnp/cm1LHXsBTTH2Kvi?=
 =?us-ascii?Q?rQpaD+vQyR7r+dIi4lHFaHNK9qQ9/sGemzyG0YsXL0YP518eo4K08TXv7YkO?=
 =?us-ascii?Q?dATptId9X2OA+GONvsn6R3cn+JkaLCHOljs+hCX5wBkF3lWh0g1NjwwDv7eW?=
 =?us-ascii?Q?jqB9P63KvHiJPKHlfdcKv+wKowAHtSd6mjov/hgtNOl+Q8zVnXtSlM6fVXYm?=
 =?us-ascii?Q?pzAP21imfVuUdp9yv+YXUsprlvZEVpiXgQybNfCaahGkANYV0bV76VfkgJQq?=
 =?us-ascii?Q?q7nBMoMkrXCLaDtjq0H/cPbtA68uVdBRN/ZH3m2+4SYOuUWLc1rS0274+Js+?=
 =?us-ascii?Q?SFojfv5BzmVYM3tV0Z4CbPU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de02e75d-6ae5-4e30-ca3b-08d9a5b31e61
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 08:04:58.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsSrKeWFaxtvzU+Q+QPzMewOmsd3hS7SGFPXTKOToo1nGCfqGl0UdlNu+zq+guqHxVKSKsuuzCx42e0vz/z0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111120043
X-Proofpoint-GUID: 2rA9VNGSpn46wCh-RoanhYKHC7E9fiFM
X-Proofpoint-ORIG-GUID: 2rA9VNGSpn46wCh-RoanhYKHC7E9fiFM
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to support readpolicy in the config file, get the section
as an argument in the function setup(). It helps to verify the given
readpolicy.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 src/PerfTest.py          | 2 +-
 src/fsperf.py            | 2 +-
 tests/randwrite-2xram.py | 2 +-
 tests/untar-firefox.py   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/PerfTest.py b/src/PerfTest.py
index a47dd4985c3d..f084a92121e3 100644
--- a/src/PerfTest.py
+++ b/src/PerfTest.py
@@ -9,7 +9,7 @@ class PerfTest():
     command = ""
     need_remount_after_setup = False
 
-    def setup(self, config):
+    def setup(self, config, section):
         pass
     def test(self, run, config, results):
         pass
diff --git a/src/fsperf.py b/src/fsperf.py
index 99d8e9e0e43f..a26d95b8b5f4 100644
--- a/src/fsperf.py
+++ b/src/fsperf.py
@@ -20,7 +20,7 @@ def run_test(args, session, config, section, test):
         mkfs(config, section)
         mount(config, section)
         try:
-            test.setup(config)
+            test.setup(config, section)
             if (test.need_remount_after_setup and
                 config.has_option(section, 'mount')):
                 run_command("umount {}".format(config.get('main', 'directory')))
diff --git a/tests/randwrite-2xram.py b/tests/randwrite-2xram.py
index 25fc94e51dde..dfaa97236727 100644
--- a/tests/randwrite-2xram.py
+++ b/tests/randwrite-2xram.py
@@ -9,6 +9,6 @@ class Randwrite2xRam(FioTest):
                "--size=SIZE --numjobs=4 --bs=4k --fsync_on_close=0 "
                "--end_fsync=0")
 
-    def setup(self, config):
+    def setup(self, config, section):
         mem = psutil.virtual_memory()
         self.command = self.command.replace('SIZE', str(mem.total*2))
diff --git a/tests/untar-firefox.py b/tests/untar-firefox.py
index 5bc1923db72e..b5dd7ab8ecb5 100644
--- a/tests/untar-firefox.py
+++ b/tests/untar-firefox.py
@@ -5,5 +5,5 @@ class UntarFirefox(TimeTest):
     name = "untarfirefox"
     command = "tar -xf firefox-87.0b5.source.tar.xz -C DIRECTORY"
 
-    def setup(self, config):
+    def setup(self, config, section):
         utils.run_command("wget -nc https://archive.mozilla.org/pub/firefox/releases/87.0b5/source/firefox-87.0b5.source.tar.xz")
-- 
2.33.1

