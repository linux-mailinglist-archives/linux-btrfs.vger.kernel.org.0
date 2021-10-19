Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5EB432B2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 02:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhJSAYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 20:24:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33320 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJSAYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 20:24:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19INGmQf004568;
        Tue, 19 Oct 2021 00:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=D5gYiGduvnM4Dob/dTSAAvr/6ZckHV5APQT1Vs9vCZM=;
 b=Tvl/SydW1PbcLCwfprXeRhmSIFhdy3xRQfFs9y65HoNTxSSLYytrHPFVo1mriUfyCo6f
 p0AFAnDtfss665X70XsqYrr7pS8NvvgCbiBCWu4I9FLOprSRdzBJajhr7gC0TZ12cHOZ
 ebvt2HmhJ/61D60oekNW8+Y/O6PVkD62MrtHZ7VWIRLYNf4QCZou4WEkwYCRbuZRL94A
 8i/hkZrJ1MJ43lCu/EEv2OSvcPQXhTo1LzGWuQMT4ACLbrDCs4UFnkbyYekGpOMF8lGr
 q0IlzHanxWfYbRwzqFU/7Wwa366hus8zl+dFzWLXwnJswQzM/a0LLHbXBWOVDbIUzNF2 Qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brnnnfe7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 00:22:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19J0Gkg3127880;
        Tue, 19 Oct 2021 00:22:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3030.oracle.com with ESMTP id 3bqmsdx9t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 00:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpEO3rfFfx56lsT7Tehx+w3wSBXWlDUESdmC58SOJaDwpcr9H/sIu2cNdi+8iyV9k7sF5GP2x6OzfHvjST0O6+3wX1im1Cf7RzCzXgW2q3vUjO+O0h8q13GnzD4i9rRkMS++/ZUbZ3nAw0wvesCCfkEwvJahtZFI8EzqteSy5ICpemZe8V4abhYnnu8XD7nUE7w81fIBYsv+CrXQoORNKs80WbXBm1pjunfpNS6FZkEm1NnIlXhQFrOfw1h+aFNiHxa997Q50Kwhj0j4CuyDccHA/1TTL5G2R5Txr7gVcjcW+l/QP6y68lt8ZdEjLuLNcXJpzQyy3vGIMaWnW1B1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5gYiGduvnM4Dob/dTSAAvr/6ZckHV5APQT1Vs9vCZM=;
 b=UtuiHnmWzYNbP6Mas5Qjqr0EGHDwPQbkGSwaP6zIX+tZxaQ/2KX5R79jkJs6ZvbUJXg20YDkK+MjdsKtFYBstd32dBzbDAqvsFt2yVByv0nurstDMx84KNzgVFPqOU4SNti/StLjULYHs8O2zffx2tRro1YwvIR/dbzn+sOFDBgoImyCGpn8SHV+yuFpqSBKpA1TeoaJHK/oG3KQuXs968SI27POG+Nxghj1ANEOnOIiHiQhl4uJSHVcKBwRJZ3wBEIrUNPc6NfNY/TDVshW8Wc5rg4XidD4EcF0qSZicqLK3//81fjFmSz10RtXeUFr9RpFQ5SM5JGdqKdylK74vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5gYiGduvnM4Dob/dTSAAvr/6ZckHV5APQT1Vs9vCZM=;
 b=SOAqmqWryP40zJZPQjEaA0VO3yUHUk/K3HajvsUdowUbFGHxIyh9aHu25kTgYGHnVIv9AFWq/6SEl2IysmR7hF2TdG9OPyRbCzpdoEKCBn3PJAUxUXds0x7jRuGYDLd/LW60IBmHL8hdr/jY4E1VF+49ew+buFvjVCqssmdg63U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3920.namprd10.prod.outlook.com (2603:10b6:208:1bc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 00:22:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 00:22:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH 2/2] btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
Date:   Tue, 19 Oct 2021 08:22:10 +0800
Message-Id: <7df68f272490c55349b44a33dd7ac19ccf87560f.1634598572.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634598572.git.anand.jain@oracle.com>
References: <cover.1634598572.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:4:196::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 00:22:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a151094-41f6-489d-1d7f-08d992968970
X-MS-TrafficTypeDiagnostic: MN2PR10MB3920:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3920B6BE3D947AE57C530DA0E5BD9@MN2PR10MB3920.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hpADbnDig9KvPxS3EhG2K80NJTp8PQ5TF3ENA1j0yF5HYqW45fOcJy9BzBVL3/fEqaSeHPDkc0QUzUBPe8psYnx++TZ1H6L1ujlKT4JPedSwbodqpUAeowx67GfETkIYJkVcd57BLA8wG7YYvayPFJcHIBqKSj0QWWVDw8FKxqGzMQPzHemE0cKrhlsm9vzDal9flkUCoAQ73phMUJ/69H/Y2tDlkMuXNMGnvcuSAmEbuMjbcAImL7AhX/TYkBIxgZOgQIvKqdb8SyA638l4n/AYVUMMuk8hmFhrOI5dMDuStb56GC1jk9d6JWZukDqynRkfyuN8bvzbxzbfR7bV2uZNjypzP+sDkH3SpaytsXYSRwlfkYGpvwQ8thEtQEEpW5rnV2a96jZ4eUXdq6nw9+VtXPtx3fOsghBAFAEDNPhaEywEKFf+vKkZoI6EPzL9tslOlxeCpm+wR7IvWVynQUuvmBV4aljS0LqJPn5p50BpFx1MBHXCGqEWN7FBQNX5KVfKKWtuNiCBY5xjO8UIeSFHFf5RhaBW/tcVW1fGEgqzIpSNem6XxSASY96zyZm/msDPhuU0p60Jd02TqYeQVXn8GPo7NkFliwZNhQkFXeyLdZtcUo33mjFxVXuVYNiYOqkRMdpH/dKlPOaT5gOS9tfMeFPKhlfKmRiZV5e4yAc49gOmocJnOoXqZfcShULlCdI64CJbUno35RtC5q0BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66946007)(26005)(508600001)(86362001)(66556008)(52116002)(6486002)(6506007)(186003)(8676002)(66476007)(83380400001)(36756003)(2906002)(6666004)(316002)(6512007)(38350700002)(2616005)(38100700002)(5660300002)(44832011)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8oXhUZ+dy/SWV3S39FnUfj0FAQMoWMFAXmNs0YX7pcP1eJ8J9vlnB5JNpRuW?=
 =?us-ascii?Q?83IvO2bC4MB3ws+q0xIyrc/peVlh+Z/b68wdqEazlrG63tzMI+BGPSZpDjK0?=
 =?us-ascii?Q?YEv1QysvHBmIod2W86U/7/HyzGAS26VvTXky+/+jV8KeYvtORg6PLxGb132v?=
 =?us-ascii?Q?U2lIHnlWwI6S2awZJRMsjSoJVlTfb69csyd7gpdcv+bEectN23xYYojHhILa?=
 =?us-ascii?Q?7ttOoflZKI65jMDJRdusDboAKd2ky50pcnbjwR8nds1Ah2LxlgJE9KrR5jY4?=
 =?us-ascii?Q?EVaLUDsJJtUHm6jpl6fBHk4c/sZUZx4IQuslm9C360YJ9d4GureYuEXbbt/s?=
 =?us-ascii?Q?hC5AFooq7nR01CjaGap5J8IAFkZQbnN8PXmRPaXwYJrnhjOz+J2kC/DG/ULk?=
 =?us-ascii?Q?HamSKBMmnnB3zS9mew0o5ex2XSBO8T/MOJkDWzNfJF0bEw0raDqfcS5r+doP?=
 =?us-ascii?Q?2AawS+AmhRjRv4mcUs+khPkriBHpORBllANEeOepCHFj6WVYiv2le4krAV3C?=
 =?us-ascii?Q?iAm8SJh+CoOv0hK9GALwXP0iQ5Pj9DuyGqxBOz2Gl+aFCm9aSS781KILR0Wa?=
 =?us-ascii?Q?n+ikn7/IaafGXfs/pgYUtxlpt5c7unMfGa0is2No3fLl/gLkbjnSLsL57hjm?=
 =?us-ascii?Q?pwr4JXlz0mBFRNpNGGhC4yDdSxu/2IUu5CFZamEcmaGfUS+buvgv83skXwCF?=
 =?us-ascii?Q?hqnmFbNHjr7HfhASP+UGn4Lamy/2BwQmqfTxVV8yi9gPNjS8YP4piDM6dd3z?=
 =?us-ascii?Q?UPALyXwQqdZ8x5cC3U6Kvk94O5PHOHv7Wl9yxwLIQ3nXK4F4ZQNqHCJu0VeP?=
 =?us-ascii?Q?Bi5ZnlhtZsoHJnyORXUbb0FlHEuGo6hYETv8LCmqX3YdoaPRor8YdKw0So34?=
 =?us-ascii?Q?trfRWMi3RSBd62k1XkmQhr3xItMpJmA/XdBgfUg20wkKsAOlr5ulSzoFliEw?=
 =?us-ascii?Q?IA5CeXibps49D7gKJpqmurQ+hhykNoVJiKK8zSu7lC33De7sDYrkYbHJ/Elh?=
 =?us-ascii?Q?ZspxbfKgJjcF2d8B/lyqFt+QwF5La/flv31rcYWnaqPkLSS7cOnbaOYjwmmk?=
 =?us-ascii?Q?j5rs8YdokiSUElEO9Xz4pBLOVwZf2GxagQ7pGSHfLsscdxfxz28JARA8dPDK?=
 =?us-ascii?Q?D62LqgkVdkMtBMIq2UtoSmRw4/bW+MCNverBXbqe9g/8Bnm0Lm/KpHvd9rWQ?=
 =?us-ascii?Q?+pfJ4IyB2hNuoZADG4DOVO2ASlScmkZ/YAVkjfP8C18ypEMroHV+Pfk5uHUI?=
 =?us-ascii?Q?7BygB1mizyw3WCyRWn69y7vMVga4EEHDqWSQmCNpIXtfZ+KgEqdso3tMR4HC?=
 =?us-ascii?Q?El+zBw4wECvRA3A1ghmsLnH7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a151094-41f6-489d-1d7f-08d992968970
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 00:22:29.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWsXhBlSVDsMm7JEJ2GyU1xK48FPFIETeypWS7sDaN11c5uS9LCbl4laCLrSXdpv5V1XNoNQNJ0EUsA0apdtLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190000
X-Proofpoint-ORIG-GUID: tFfUPi579vO_ds_cdvDJTYzGDPu1qoGm
X-Proofpoint-GUID: tFfUPi579vO_ds_cdvDJTYzGDPu1qoGm
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
---
 fs/btrfs/sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c0ea7269ff57..c10fc39cb677 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1538,6 +1538,16 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
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
@@ -1578,6 +1588,7 @@ static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, scrub_speed_max),
 	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, fsid),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
-- 
2.31.1

