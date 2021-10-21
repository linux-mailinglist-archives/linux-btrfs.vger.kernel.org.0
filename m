Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97383435DC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhJUJTt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 05:19:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37940 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231153AbhJUJTq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 05:19:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L91dNL013146;
        Thu, 21 Oct 2021 09:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fkRCxQ++sk/K3IQnDc4XmvjoP1osLq2GLGCtu2Y/lDY=;
 b=zMPdKUJV4mQ8vWrHXjQjGdu+huiaqm6FB5r7v0QXKSyoWX5Y3G83KSLhEDeHe/c1EEHy
 XsI6he7bIJOZOmrICJGjDodZGLfTH3KMbexysiYblTHDoOvt11n3yRv/iLCmixw9WsBT
 XYnpehwsoFMa0AAa+dFoH0U3ZdSdlycUwhX06qj5u6eq7nIYWwlN+Yw1P8nfGPp9kMSM
 4fEjjONVnBLOjyASsZlZfZtMCcSaPV7QDmjx9GjDFAyF8neHJ2x8wG3eV2IHzyT3s1jY
 GuTcsBCuevXiyGpJuwP3AFPB/967XccTX1saduevM2P9ZWTSyYnm2IOSgCDOiFa1NpTi Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkx9wkwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 09:17:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L9BdYK066145;
        Thu, 21 Oct 2021 09:17:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3020.oracle.com with ESMTP id 3br8gvn7t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 09:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbZUHIz1+pQ+ezl1wVRCa7ajb7ZGKHeOimgu9KfOCLDNrYi2Ig98V4pQusNht5OQ2s5oaDwL9hB+UjJyVh93OrGhrOsyEtleCUKdSibvK1pzN6qPiKOkgDjWD7bKc092NlYhcT3TXaZVPQZh7IcWbscc71yiT0uDlA4QCeObV+DzNm7VWJMnNqV+mENqCkckOF2COTnIaER4kOE4hyqrRfZdUOlfTrJFPWLThyUq21hqJdfuD+W7Q6jGl2orehM6KQiSbAaheEQ60sWfXHOvOC+ummbobUVs39lYJaJKB4OsxfA0oL75vB3N6g8InslToWU82UFw40Q56p5PYrOW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkRCxQ++sk/K3IQnDc4XmvjoP1osLq2GLGCtu2Y/lDY=;
 b=Jtyr3HDfmGPZzmNG3pDqxJte9CN6MSVBYftQd4Qexdmt7++XJhJjRgwL+VQuBV9aRaFpHtYPi0/ZEd2ES5XROXViYKZJYdgoFbHD0Gl1phvBZc24lwYjfUwwSeoSIzM2plT31JO1DuQixCVaJPHKJ3QALtOlhvovPmaEQRqpI2I6caJxvirknIBlhMNoM9W9Td1IXP+xuvqbJeunDdWFguHOJUzW4M5j/QKNVEmVz60iXzW6WqpSv4kIjy7mBJ1PYrxQ9IZw7GDTO6yf09gfDxdLaUp3ajCIvs97ETgEzm3KAUm2Bg15SrDyjM6yYxj8hA2h4PifJzy7gaNDuCv5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkRCxQ++sk/K3IQnDc4XmvjoP1osLq2GLGCtu2Y/lDY=;
 b=jkLmR+lQ3HiEQaEmybfHftYNfjbGZ88tyogvZtIgTypg5eTW4SECGykaJvFy1li/ZEzoRfOllhzpgWVjmSGZwJD3Y7IGMSqBVS1gLReJzKeih6iAFQlzItL514NtVa/6UzWbIAIa7xDDzAdoT569IubUPoXzSBoQCKSIlXG2Was=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 09:17:25 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 09:17:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH v2 1/3] common/btrfs: add _require_btrfs_sysfs_fsid helper
Date:   Thu, 21 Oct 2021 17:17:04 +0800
Message-Id: <482134ca6a531a3d1f29326c0c7dad536f66de6a.1634807378.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634807378.git.anand.jain@oracle.com>
References: <cover.1634807378.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.8 via Frontend Transport; Thu, 21 Oct 2021 09:17:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b7a24db-7734-40be-993b-08d994739867
X-MS-TrafficTypeDiagnostic: MN2PR10MB4287:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4287FB2401A91059033F4176E5BF9@MN2PR10MB4287.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5lO+68CDoEMcrpbYYUPVU4RoKote3mRxc6iHuAf0jj1GQFHF+Q7ZE0D6694ChHOBO8HOBgtnQehCYbHaTu5jadF+PPpVNlLeJOOyBzMSyP1pEfYBE727V5NbjKGb+un3JZb0dcPrNDugNI8/3IwIt7QUA8B0LAJ4QicBQjkGGBwrEssa1fypXM5LBxvIjMgg0mXanLjXNLwiISVoaEu2e0yDpgGFYHIzk0U6xPZNOXvczkkjE9s7Jzk+M1W+GrEW4PWhTPYpEWZ6qQ69qv3IJCj+GAlPHAwjk+Z3yEXVS0k1eVwIY9aHb4cX0o7j2RYFQ9XiDYbMlLeV1iMteA2mueR3r4X7e/xKPDaCAJqOnVlXK5YZR8KZ48+x3Su2mHI8YvR5DBdsHwCqf8TAJyfNV+I4+zLFjYvhrfVQ0eCk/WxYufHVEn8QZALh+05eC2TYMGtg+uydUK+UiUcnaskpSeJjOYGra/vZNEPbN6AEdqDUry67P4MD0tWakKX2tVWazOLNqve17Lk8tP4hRdVmfUjC69HiN5w4RhhPkiUJs5dQpe8mq/aQ1i0TNEteeKTWqaorJOI/uQvdNV1l8qsFkRw+j2lU2l2iNnDiPHg9Me0AUH88I1kJDO3rtj3Fb/PG2Z4BG48Zok97kRYKtYXxdwufz03uc35LTRXrm9AKKpTOkDIVsZMAy8zNk85j393X6BWIK8og+Ri6y3p5F90rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(66946007)(508600001)(66476007)(38350700002)(186003)(36756003)(66556008)(5660300002)(8676002)(86362001)(6506007)(2906002)(4326008)(8936002)(6666004)(6512007)(316002)(2616005)(38100700002)(44832011)(26005)(6486002)(6916009)(4744005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SOt1gtRykFWy7ACAEdaFqzeyzD39ClVIRB6QvOKrf7OFjg7ZmTXxsXjNDxDe?=
 =?us-ascii?Q?assEIMXKyp0bJizs3EpdP1k6ydbp9PWbkXL8tVVbJSGldm8vCtz9bFWGsJk5?=
 =?us-ascii?Q?9vD+WaACmKZiXI9fCIgAUCuFQ3tbQbcgzWRH6o7+nFUEgnnrmpEJ7jOnoTLT?=
 =?us-ascii?Q?VpPcPYxmPLjrNits0/lMvNQbdau3JKjdwAyIpfg2d8rd5QTqqXHa2gO+DPW8?=
 =?us-ascii?Q?m+/A6Wscm1jPTA/785+Tv/KGbSOwxPfpVUdP3e0JPc8soaGSg3jq72rtQ5lq?=
 =?us-ascii?Q?U4DD5uzvQsy3T87+U35VeKUUpvkWxvCr/dH+aKVjTFlsFpTx/xTLpvi3lbyf?=
 =?us-ascii?Q?hEkix2F0vxpLgs+n936M1owvTw/yziOLzuepe+/tIDCSy8NxI9ADnX64YkzH?=
 =?us-ascii?Q?9AAdtB7ylNhDhX8UkuvJbbr2tZjQl6mw4DzthXFzU3rsb9Lmm0lQABdFyEY9?=
 =?us-ascii?Q?tKFusxtiW4uMSY91UCsa4SnlBCcoUyCpvyPNP59ullnUP/cJ0cNQ1okKyPqN?=
 =?us-ascii?Q?FFsTBlWHGLyz5suDi4AxLDaaELsk7rCgSlrATj11cTzXV1ERZhMLe/+2Yqms?=
 =?us-ascii?Q?GeWnuMlBYCVBZ1ObGTe9buKdWb9NxMcbFydO2N5RABlb12ZxcgAMzcxVHO3Y?=
 =?us-ascii?Q?p/YJjIqrd68Gw7X5pAB4kT8HFXxNEcg9d8kD6Wy+hRNL2o7Qqa3N3iEsUosr?=
 =?us-ascii?Q?r1JP0LgK8HhhIaVKrqfmssr9pq5PMcL32bPVUe0wmIN8UMu+1vjKxCZYzZcp?=
 =?us-ascii?Q?COiaqTZjy0CzviAIe+La03HEL+E3BZl2tclvBih4xtUr1g8XJHJg0IXM6wCz?=
 =?us-ascii?Q?CE/5UjGLvoO1X1XWMBeneTYB/u24ugnjtFoN+V8q3V0ZfDsGjJOLMcPBPnOk?=
 =?us-ascii?Q?9FUsdRhgbxFjjOLSJlkkyIOEvZRQFWFJhuMqyaxSaNiPd7j7mAS8CX/tOGK7?=
 =?us-ascii?Q?xiY8UZnXv+Wm54MMgEmbSrwJSAgBR4yfYEk0jf+7PkVA4nJg5tGxsTmba3b/?=
 =?us-ascii?Q?MLwx9HkXz2FJb3j4U2lNWdCqzwJud127WD+Ph/AcjR9PzVs6kUggjA3FzVY8?=
 =?us-ascii?Q?FgnypWaUad74DMrZZAGe8uwSqScCEodVTknEAhT4Hz+4GTbMis2TSf9DudP1?=
 =?us-ascii?Q?LQKUUx0EM+O3C2xcxjU4bHfAMx+j9tKfPuChdicy7vBgwT/wxMsUVuPYeLvC?=
 =?us-ascii?Q?630adRssqT5eCD3C2OaBOjxbDEEdN8jO1LC/QdCgj+hz+nGeIi4bs7WGjHDp?=
 =?us-ascii?Q?1zjD1gXpy5yKfoGyA1v827dAzTpPRdHUENpxSvO1uwKQkPgvuxt1pT8g3Mjr?=
 =?us-ascii?Q?3/XDJpKnKQMJjj/WZ83xrMRhVy4Ufgr6CKDUOVG+xXpVM//5BZmOKx1O25yk?=
 =?us-ascii?Q?trOl2C6mFNuYrlmABlqFXuY2J9ip2N/JdFjDipXB/T2oJvlejJ/sRKLRmOZR?=
 =?us-ascii?Q?/pr83KBBjiM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7a24db-7734-40be-993b-08d994739867
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:17:25.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210046
X-Proofpoint-ORIG-GUID: aQrTfVtAwvfNrTESia08TFOU3XWWdz8a
X-Proofpoint-GUID: aQrTfVtAwvfNrTESia08TFOU3XWWdz8a
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It checks if the kernel has the following patch
 btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
that added sysfs interface to get fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 common/btrfs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index ac880bddf524..5d938c19b56a 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -445,3 +445,17 @@ _scratch_btrfs_is_zoned()
 	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
 	return 1
 }
+
+_require_btrfs_sysfs_fsid()
+{
+	local fsid
+
+	fsid=$($BTRFS_UTIL_PROG filesystem show $TEST_DIR |grep uuid: |\
+	       awk '{print $NF}')
+
+	# Check if the kernel has sysfs fsid support.
+	# Following kernel patch adds it:
+	#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
+	test -f /sys/fs/btrfs/$fsid/devinfo/1/fsid ||\
+		_notrun "Need btrfs sysfs fsid support"
+}
-- 
2.31.1

