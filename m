Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4A43664E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhJUPd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 11:33:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48770 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231890AbhJUPd4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 11:33:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LFINMu017556;
        Thu, 21 Oct 2021 15:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Gae+rI8HUTTp/lqmLa2BOmuOVmmJ0t4H/+XwN4fNsho=;
 b=wCqnZYu8sSfxQepYwWZewPzip7/BLe2qgkLo6zU1WO60QlgU6Yby+s0FJkqWIFIOJ7x7
 PEz/qWw0fOF1VTfPYnXev6yqpxJBI8EMxcbkuUzcIqR/WDhKUboKqWtcnxqltJpC/I4o
 MgSnXKN5SguXUdGs1V0/kozulpnyCcEHuB8JJe0RIDI5GYOuki2NzchhSSyyzPwR40fC
 zPteaJP/1ZzpkZDCn985fo4vLbuJrL4TFhQcupLjCJuTU0TBoqf7KyvrB+jehGz8hu3p
 W2oEDxPziftPAi98aDAvguUdoxBKPg1uQ5Zt6m7yZm+IP2K/cdsC+FnLEQejpt/E2FQQ lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj6y7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 15:31:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LFVEWe076337;
        Thu, 21 Oct 2021 15:31:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3bqpj90t19-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 15:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tcitq2ZJISTzEpNXH48Ho0CpKrudxYocT0P41/ry7xwnC5crBNlffGZ22BV/rKO4N6LFjl3TWGPuod1cpkIFmb1o6XjrugYWri4FzTzXfHWLVZ+T0/F1tfzECHHB+W/M5hK6odho8zXpixVCQRMrXI04whE9VofzJvfzSCAaaC/ovZvBnUhmQq7dWefjdoNcz4G6ptgTo5ROEIMElalA8Ejc8bdj8D4Eqkp6tlC/ZmB8UN2o5vJ2Vqs3dQvRjECz1PWQpNdWsVr6lMmUddNBvOvEii4W+fByb1TFdUXenDFDzNOCz+J1CX7Cr0Ql4gAkzq6lDICNBtpnKnvS3uhFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gae+rI8HUTTp/lqmLa2BOmuOVmmJ0t4H/+XwN4fNsho=;
 b=D3JasWlmWI/rO8fCDaRz6LbYm8QViDhObYNrTzAX8zf7eIoxGDUNtRvcpnrZK4ADMET6uQGCeyEG4jieEYOldgT9V9ARLaAUojEtWfLTejUw5OBd/5Et6b4vqfkc2e9FRinJ3DdHas5pc/XD94xboN+MtyXzVffMBdl1fLcm3p33wiTs56sMpGm9oHcyXmoRy1YWRFbGY14Q23DUOKxGiJv1hqy2jIP8rF/H6jUN8qv1DDLPRxPRJPmeXZUIqIHuUkNd2Usv/ka2OWP204+Spyvb0GN7tSPUuKRQXm9l9n9lJecnQN/nqJrduEcMN8Kjw9chDpM91AQjRLsF77MpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gae+rI8HUTTp/lqmLa2BOmuOVmmJ0t4H/+XwN4fNsho=;
 b=Dyb8z3LKnQTqdKZlAjzhDgVcP6a8MuDwQlGKSHqsYAGEcJlUX2PBDKRSE0d6zwZbZf3ARDQupeNQsNFdsdu7c+k/corpwksVD1Th4O82IykDFwtF3cL+lkMYOVJpONvi2dnGooV2su0vAJiKFkKLih90vGrU7ornsYxaSIOQtmA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3839.namprd10.prod.outlook.com (2603:10b6:208:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 15:31:37 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 15:31:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
Date:   Thu, 21 Oct 2021 23:31:17 +0800
Message-Id: <33e179f8b9341c88754df639b77dafaa1ffec0d1.1634829757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634829757.git.anand.jain@oracle.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0051.apcprd01.prod.exchangelabs.com (2603:1096:4:193::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 21 Oct 2021 15:31:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c1a79d4-0317-4588-0bdc-08d994a7df44
X-MS-TrafficTypeDiagnostic: MN2PR10MB3839:
X-Microsoft-Antispam-PRVS: <MN2PR10MB383947E9852655CD16A059F3E5BF9@MN2PR10MB3839.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4JA0izQT7Fleruzew075XYHAAgslf9kw7w/Xsb5r4pAgUMO0w+jwg5sKDII826fWnD+T/K9PwxQ5FR6htMZokBImKDoFMmelD53nehTHo5gpGXTVXr5dK5KG2qhTPoQJuqcSO6zPQqG4uO3QVIw9Ia6pSHTSDvXjaFPWQeT0WTj9dfmYYojlxFHibBWHYYXC6i2K3+053DybgQs9yKtxoix44ZqjAZ3U4tjV462Evxb0vkcsp1ZPTXt94e1/JtzhYYQlvYd16EDVe4OMGhn9qGv3fGn+0FXcbVGfDupuiKnhnm2YVF6N8BKbNg9fG7UNvpJBUPWWrVSYrKoYozyhqvbeXWAN00+5HH6azJM6RhwI32/AaD1nNy8BYZ2Z+kPiOKh1jfYnvAg+5S4TOMPkza6J4FaAFshH9lRe4lREVOw0hBzIDtgdkby7ckSw230CYjksIcrH6lsHkYV5biQv1i8GdTxdpiuXxlmYv2NkbW/pISWR6v+KLwLrnGNaXy2yIpeKfe++9sD/gglHhQE3gPhytm+Sb9iA/1AP3ugRV+I+S4asJ8tIbqC7uMJ+WV0A++hiypyNrcIgV4tfIroiOZGtOnIHIUI2FaqX7Lah2lhiOufvtPQgF7+UwPP2F5oCJ+jCWHGO+y3hY8eC/JAJG4oO/KQaTcHtLl/2QWvL6/zxmV6bKQHVrKgnb+7Y1O2JyF+dwrWzJW2p+xK7p8ASQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(86362001)(83380400001)(186003)(4326008)(316002)(6506007)(36756003)(6512007)(5660300002)(38350700002)(2906002)(6666004)(26005)(66556008)(66476007)(66946007)(8676002)(6486002)(2616005)(8936002)(956004)(38100700002)(6916009)(508600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V++pvuzfijiX0fHjX2GHeZD/hreUC1lveN1jEHc3JU+q4wz86glpngmnY8p/?=
 =?us-ascii?Q?t7NAyrdC7pwEjZ5+Di7N5RVQggFH3sVi9N7LBj+4j7HPowEQdnR80pCcaWWD?=
 =?us-ascii?Q?Snak+xyWqXygEWeG8Sw42GwkJaLjm5ctxMxPeF7f4Yt4/G1zymwjx/CVZs72?=
 =?us-ascii?Q?XiNbdsaVFhyqr8ZZ3MkTJG05yrcplUkhblfUg0xSjDZLYBgQ18t5X1/HLO6Z?=
 =?us-ascii?Q?O2UkqQR4nB4pn3ibidGSLWN5LZQSoMQX0QV5Pfz9giqxAicor9L686xWCKbo?=
 =?us-ascii?Q?JOPjutvY1vpObj5xvbAmzUqp0OM815M3IW73GSLAHs1G69RcKPygyzqi5P9F?=
 =?us-ascii?Q?d76HGdihKdE/HK36GSYU5BwHJi897/ybbIS4H8/HxXJbVsuSPGtFBWeBDmev?=
 =?us-ascii?Q?oU7+DY6LUlW5MYf57fVKsoBoMZBuMtXnP11L29W5VrWdmlnuRfdJhrEzCu9j?=
 =?us-ascii?Q?3jnem7ZoTYijEIgDF2ZY9nP8CGuumVptssXBdOO7uqDSnp8MWgkZd8rfHsNB?=
 =?us-ascii?Q?Rpf8DtxT7uwT16mAuE5O8dnrs4P/rm9m8G4pkMPwq4Cd/MGqJ4z2XEJlWHqQ?=
 =?us-ascii?Q?5/8+kW8eKKBmII4ixnw+xH/HE/dzLXOMZ99SeKZGAufgKTPdidmYrFkUnh7i?=
 =?us-ascii?Q?GxF6cxeJ26ZVUtW4bjF/IgAR8gDahJaQPAAy2PcS5+FltAZbuYID9Wnr/13/?=
 =?us-ascii?Q?i0DPn0w0gyvBScI6bRB0afYCnPVHab7hTmNiKg9HszTpVmSfx+0R7CgWOSmV?=
 =?us-ascii?Q?mJv3qikUwMlwe1o1lACG/gl0eCSne9Sa6HCnkrgmiJ3oI0Py0FVv9DCYvog3?=
 =?us-ascii?Q?bTQ9Ul1QFjYZDRjCPhEyLdmlz4n5T7Dq3YiDp/YgjYjGGinFmK456hPaUL2o?=
 =?us-ascii?Q?0+1aK4mgTa6xz8P68hCWFxgs2cZR7YnkEosPzunA8qaQbanmFTAsLJL/6SIl?=
 =?us-ascii?Q?3/Cp/Ic4i7ELBFFHx1drej+FkUhz+XhKziWwLgV5h8AN0LkiRNOwIah517Tu?=
 =?us-ascii?Q?9+BuU3bRo0DDfEETt//8BT4eYb0AYm+VMS9figRwIc8BOkHEEdW6299P0CXs?=
 =?us-ascii?Q?toEZT3RtRU6XUmNgWiH6AK3DxbE+nHBGQ1ZVxlh88qw8XjqldDYNcu3NVVS2?=
 =?us-ascii?Q?AUfPDRtL8p7xZy1vhFPMSOBkMjZ7ijoGUg0bTGjaEOagVgu5qcQf+8t5JNqQ?=
 =?us-ascii?Q?Vnyu8ycs91tZacdmjBnEAMJdQRVrZELPAGHbj3mksMseKM+NkknsYqe2FQll?=
 =?us-ascii?Q?fmsg533Ozl3hxz2+4jgePcAknBdWsp4pE13rQO/Duk0C8vGur+H/sl03F8ou?=
 =?us-ascii?Q?EfAKlyRwzX3ongbQ04CUIQgM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1a79d4-0317-4588-0bdc-08d994a7df44
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:31:37.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3839
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210080
X-Proofpoint-ORIG-GUID: cv1P0zxdsYSmMCysVa1pYLScFsVtq0Rl
X-Proofpoint-GUID: cv1P0zxdsYSmMCysVa1pYLScFsVtq0Rl
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the case of the seed device, the fsid can be different from the mounted
sprout fsid.  The userland has to read the device superblock to know the
fsid but, that idea fails if the device is missing. So add a sysfs
interface devinfo/<devid>/fsid to show the fsid of the device.

For example:
 $ cd /sys/fs/btrfs/b10b02a5-f9de-4276-b9e8-2bfd09a578a8

 $ cat devinfo/1/fsid
 c44d771f-639d-4df3-99ec-5bc7ad2af93b
 $ cat  devinfo/3/fsid
 b10b02a5-f9de-4276-b9e8-2bfd09a578a8

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 28ff7fce1ac5..591d49deb552 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1539,6 +1539,16 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
+static ssize_t btrfs_devinfo_fsid_show(struct kobject *kobj,
+				       struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	return sysfs_emit(buf, "%pU\n", device->fs_devices->fsid);
+}
+BTRFS_ATTR(devid, fsid, btrfs_devinfo_fsid_show);
+
 static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
 		struct kobj_attribute *a, char *buf)
 {
@@ -1579,6 +1589,7 @@ static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, scrub_speed_max),
 	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, fsid),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
-- 
2.31.1

