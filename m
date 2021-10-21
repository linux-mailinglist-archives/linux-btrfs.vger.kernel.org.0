Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5248C436650
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhJUPeB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 11:34:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57674 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbhJUPeA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 11:34:00 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LFIPGx017614
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 15:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HZwIbblxnYyrvZsL/V8jzwoly6NMbedfA6MuL3Ac9lQ=;
 b=NjJPEvfVDWTr1ZOMFRFT0dVZuAu1M+wIQGA/PnW/dKJGnox6JVtt87cdj9blHxLctYaJ
 iV1d2MZwoVWvJeeHPlZm8+VQo7YqpsQf7n/VzqIYEOE3GlBWrWhgy3hCBuy6ZNldgvgA
 Ibxjp3+3vNK6zf8LiOykAdW0DEiSLu1CIbe6Q4nu4FBGXrQBY7IMJHjTpwXE7ObV6IJg
 rJKFw0Eu94lHviTLkcR0wJgp9Uabwd9begpWm4RhZTQL/2RDmVzjIriAKW0ld/uS2/PQ
 kdwKLuF2FpKXiN+xM7Bn+UPzM3Evs5Pm2e9Ji31E0IjnL6XqFtOQsgPsP7P9COf8J17x TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj6y83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 15:31:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LFVe2u051941
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 15:31:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3030.oracle.com with ESMTP id 3bqkv23u8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 15:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkgJDxdC8LKzfIWgIa8hC3l6JC/rwZ7h9l1j57YKlgS0DQBTtkT3CcLfH009NEIm4FEMGNWhMTg2G0l1gmMA0B1tplst5sBLXUzKEZbWoUcKWLmMjrA358Cym+8oyZSqK31prZVwSXC/+8hv66cF61Qppji0N/NLmrhcKj60zUYVeQguT+nrTBLQ0AEgoHK8GtH830lfeYilEaz3RH3i8TGP9AVuA9BlhDN04gYkiR+9bN/k2oZdTEDMjdISmTDv262LyrXlHahlf36qU4ONUmLduI25rKG14F6xvrrb2XmX/ZEvWoW5uyNptVcfnIvbwnZaDWeCKNM4e0DBOEV/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZwIbblxnYyrvZsL/V8jzwoly6NMbedfA6MuL3Ac9lQ=;
 b=KFIBl0QQnfapkHv5D4eoNSVX4cX2TqB/Z2Pm/59thgC51D+Tz7DCJVCGjgg3LKNQnMiW6vKPmz7w+cnXq8vTrlj61W0LQhvf/TKvIhKDCptfXC6EETlQb3UsEXckcx7vWQ9oaGvBFWyqE35EYku3hUmHkK7cIrYRbuv15Vs2y2bZoybIsgyiI8V82r2RKNXDzpyv4wp6SE/ptt9xmps1Jsd+YDbVmkKUmWb9C6JI6n8A3IjDMgGV85ein/frZeL1WRzW1K4eXAiXsjeMVFO/ajXVTrlnpK1Lzc4tuTa5mLcorx18t3OlteGFST0EadyoNq3omHq37cmkQ4a1oHsdsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZwIbblxnYyrvZsL/V8jzwoly6NMbedfA6MuL3Ac9lQ=;
 b=exAoc1YkNiOJrqZc484moq0XIYsYtuXZGvvV9DYJlrAaLyFYXg4VeURAsIqHSGi4GK7w2TXGlL5tYAFqL7jnCSX+F7ndLPPG8yq/nQGcKwgQUROu/Op/if6OPb2PjK0UUX3YrTSkVyQ9O2WeTQdFSwEep/KIZlHZjgW+7SxTYno=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 15:31:33 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 15:31:33 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] provide fsid in sysfs devinfo
Date:   Thu, 21 Oct 2021 23:31:15 +0800
Message-Id: <cover.1634829757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0051.apcprd01.prod.exchangelabs.com (2603:1096:4:193::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 21 Oct 2021 15:31:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1320f9e9-3101-4491-5f92-08d994a7dc8e
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5156294B3101233D72011658E5BF9@BLAPR10MB5156.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcxWIc6MOLZbKRgLN/32XiJxcgfxAsE4SYIG9fAf6qjqgiQoax8gq2QWcJAyW3SwO1KFFSJYrt1CPIXt+GjCcfQeQel+TShqQOa58cGOuRL/WS/pA1y7/PqG+BpC+6NewgcDac2zOz2WOKQHOmFXxL17Vug+t0Ap/HVW/t9fD6Ec8fxXZSKLTC9xuy/qtYS75Aq2aSWIMvhSomQ2fN81sVOZKSnZ+STkjbTjoYPBe8uWmuz39JYc0qHh5vvyMjNwn1xbxKiSeXZ+Lg4o6wlwo3qb0cEpl27A0w0a5/SaHmn5IfgJ3N0eNqzVlNOlrZTpjNex0I9eW3Voopoq+iLgjGLrXiiB0lEEBQ1Pkyn8MzHCZpT+zY5CsM0TD2saSfCh3R7+t0GjkSh3a1iTWOfWEONgKwjeX3gQhhZD/UYR/oG+z7PUjLk6Lwhme+zCLccSlYOY1Aa7eU/aooHB8vtWjQrQKOYmHinn8+/NCk9UlarmlPH52R8UN0ZyhHSMW3GhX8FLTFDpAHF8bXmI0mGSXSiPFm4BO2YXy1DYifBNM+U+ZCud4MQ8VT8+7WIIgo6ZVSr+DDxjXdM5q/ul9fY3lxutAaVFfAyRQsMawGobU2rSoKENYOqg8m/v5b6s1bKqe7orOlzlO8G1wHWkaip/Jug1lVd4zdVqeA1XwUVNkRJl3GXKqzHVFkJxTkH3I1GTdHObfuiDLc1U6MNzGMytbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(44832011)(38350700002)(956004)(66556008)(6486002)(6512007)(508600001)(83380400001)(66476007)(86362001)(36756003)(316002)(52116002)(6506007)(66946007)(6666004)(5660300002)(186003)(38100700002)(2616005)(8676002)(6916009)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cFdWZJDGLnbW2tndgexfY6GxWYh2m2ePuEbAglRBkTKXMfLQ+oBY8dRY6jwL?=
 =?us-ascii?Q?8eFOAxt+U8zHYclqEus+8JgYPOtV4HyVg5CQ//gE5Xq/a0MSMUhV0Voch2H0?=
 =?us-ascii?Q?0fU2xGmIj/Dl47ATHPbfutHzPoBE8Zgz/zcZhpk2Zm5Nn13/lhV2j4Buc1G1?=
 =?us-ascii?Q?3KozV5nnEKfN1kT4fNahq+t1jVWwsmnOvuZwKdz5CPTgCXQvYWXWPEkj2Qgk?=
 =?us-ascii?Q?75y0wP8Y//yDeILOGsVN8HHKnYCUXNfIiOIl9K1Wn9a6ZPUYn7Xh4EVtR+BB?=
 =?us-ascii?Q?dG3lFNh5bwI+DBA6VDwTdDHLoBYY8Q8fV0pf5hfgIHgvbovWByfSpO1WsD2O?=
 =?us-ascii?Q?BGcC7SJHkaUAQhFXAqJxHQHH0yVmDb5U2+b6Urda6eOnMu/t1oy2tyAAsWl7?=
 =?us-ascii?Q?ok7L3rT2ViNZy7/o2DlE3FRpmc3RUi3aSXJGdsBgcyDB/M8He7XHYOlzhb9R?=
 =?us-ascii?Q?+zWBKihZAIjbzGCoYo4uvi7S381hw2NtIV1ZAtDdaLDIuEUhmuNEV8seC+2B?=
 =?us-ascii?Q?dbyOWr+Txikzw78BQZPnS/aSGKMrxQrpoeRwkmMDmBy1Y/TxRVS+yO1HaJ/7?=
 =?us-ascii?Q?WT1f1NpvtSQKULMvp8zw1D+QIbchZ6FkRE70WKz8epzx1gslT0tHHyslD8GG?=
 =?us-ascii?Q?BP9AQbyED2XYqcM3ZhKncC5gfIXD97grw6PJQDWgCuipq/QZnYvpptBNMQZs?=
 =?us-ascii?Q?QFtnBIFEagZgjeJmyqQcy2ooxVvu4EjEoqbxItMVPL+P+TtZVyuCuqgpCDxs?=
 =?us-ascii?Q?jM5RFeWsTw4ObZuKdGC0aVd/zHZI/LQG6ZRogkh+fosLRf8SmBoNfjjWWgG7?=
 =?us-ascii?Q?8iozwi/IE3hm0phWm0TINRDQQDf6dY/n5XES62u4PlAd4RGxYIiZmuZZHdTT?=
 =?us-ascii?Q?6wezKRGkjNg7tfUGszeI8P+nKx2tpRO0uSvY6Q5MG8g0t06Yn8lP0+3NsQcJ?=
 =?us-ascii?Q?UMZG/ADIk957X/mOLNM22v/tDvx7p5iYjJhbvl4YQAqaFItMQBODG/8lwebl?=
 =?us-ascii?Q?d/Le8IcxoO+zgbAPu3SQJzt1dRYLFU2gGpUsgdghn5sinvw6DRo3X3oTqDns?=
 =?us-ascii?Q?d+Tx5eI3kyQfrZaH57SZtflKBFCt25f+RfyDxLNWkC4VQ9Q7TivPi7IYUETV?=
 =?us-ascii?Q?UEQjWS8JpKqjXEJubskFYQnmaGPC24iQgUPPgBE6mpBA6kcmVcCFRKP8QYO5?=
 =?us-ascii?Q?mSY4EulwUZjFjM//uJskraUMVh+l5Szw9F3CZk2M6FspbwhTzeRiERHRa1zK?=
 =?us-ascii?Q?QZT2FU/lkq1oKpMuBQJVPb81ro6bsmPfw6ZcSYhqhjqvVIwLuNbKux3jf3xA?=
 =?us-ascii?Q?/w6+x7ggwFJyzSwvTDKupD7FcAUs/BM1vig/r6yiDyo6ZDR+jKDtB1n0diIU?=
 =?us-ascii?Q?xDJpaNYASRtkHD0xzKgT82euQT4ND/BVFboP+oULUWh7iPgil+inf2Sf8wq5?=
 =?us-ascii?Q?aVnHCJhcD8c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1320f9e9-3101-4491-5f92-08d994a7dc8e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:31:33.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=746 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210080
X-Proofpoint-ORIG-GUID: WU9JPTw9gy17OY6LRC-NVcFmrB8OfZfc
X-Proofpoint-GUID: WU9JPTw9gy17OY6LRC-NVcFmrB8OfZfc
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
Fix sysfs_emit conversion at the two non-sysfs show functions in patch1.

btrfs-progs tries to read the fsid from the super-block for a missing
device and, it fails. It needs to find out if the device is a seed
device. It does it by comparing the device's fsid with the fsid of the
mounted filesystem. To help this scenario introduce a new sysfs file to
read the fsid from the kernel.
     /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid

Patch 1 is a cleanup converts scnprtin()f and snprintf() to sysfs_emit()
Patch 2 introduces the new sysfs interface as above

The other implementation choice is to add another parameter to the
struct btrfs_ioctl_dev_info_args and use BTRFS_IOC_DEV_INFO ioctl. But
then backward kernel compatibility with the newer btrfs-progs is more
complicated. If needed, we can add that too.

Related btrfs-progs patches:
  btrfs-progs: prepare helper device_is_seed
  btrfs-progs: read fsid from the sysfs in device_is_seed

Anand Jain (2):
  btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit
  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device

 fs/btrfs/sysfs.c | 106 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

-- 
2.31.1

