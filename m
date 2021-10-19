Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6933A432B2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 02:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhJSA0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 20:26:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11856 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230083AbhJSA0O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 20:26:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19INa1ap025772
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=lOTaQch0TRXoS0Fm/sUpskoSgVGmnTMfgCITrCw8TbE=;
 b=fwlMOUpsV+lvrvKZUPmvvC2AsADF/dQjAIeab2g6KOD8Uy+sYjjuLl/kIwjh/fo/3oPu
 /6sLu+jtnoP4EVIJFK1LDHGeSJYv4j7vqHviVQER6knnZtH1M4dllxlfokH5/iWv6DdH
 4Q6O7Z+4lQR4PcSyyrQePZIplE1j4VhXHOWht3kQ5mXzPa0hWdEgrpSZCQTaKTbMF9et
 5Ug2ZquUS1X1Pt4un6WSxeyqbPHP9jKk0HkhUPzWxvIEcnxtE9E7ihU70JDH04nU4gjb
 QqNwD+vDNGHj8sNgrmJa75hMYwwlX8gdNmXEk32JNhM2zbJOhCCkTHyZna93ANW7pxp/ Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brmkyfd2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19J0H6ED001897
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3bqpj4k2tt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT0k613bxgtmBQeCIm42N0U83DtVthtcISGmu4DEKWdHiUPKWkDExM5cwcRT2SefOQ4iqGN4Ij/Mdfe7aC2F0j/cChqKdv3lk6BCh/ttIK07YW5gBRutKXCTEpJ/ranqpecImC4VG95PY0tt8qk2JPk1MTiQFkbdHJTaupbkevH37KBJ09R9L2nLCI8JlhOascsaSJFojNUU2vilanHAcWi4QA67Da/ly9hdRXFU8jdZM+DRhQaE3aTLcWwdweITEtcKpLMvzNiL/umYTOgznR7FougAJ4zNjwIQjBmUbiw/RX4ca+9qywJEKrajOS7Wm5V9JzHd8dRQCOdO3Gtorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOTaQch0TRXoS0Fm/sUpskoSgVGmnTMfgCITrCw8TbE=;
 b=hzLFqyW5bNbZ1z8GtVucOFZ8/3rIEYSP3rWRXsv9n2INIe8BLxZPp7nC+8vO0tJWPaK145Vq7HzK0RQUiGlgt/ja7bPTQJAJy4ayf1poLzmn2g/98dO0GTXF1N13xcJB6D3zkiTdaDA6aaE7XYbb9UlHHKvXkzZT+fXPQVmsh6AvnwHWChlUm3iumaLQCJFnlZHDoOq+adMfufHN4YhCiJbGM0jbUP86/3dfPYNGKw4KMqPAEfHXOx+19ylCXpfK/eQPq5WzTtUb4APZTQgU/NZ6wdEis8k92IrEyuL9pHtOXmj/AzWyv3g7WA+Uf37Klnb722+3ac80VwlKAimoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOTaQch0TRXoS0Fm/sUpskoSgVGmnTMfgCITrCw8TbE=;
 b=Cz5NQaN4l50kcgPOIR1epa3S++bEB2AIOzClAHNIqgelcRBovphWbMV2VsIUDWr45IFwsUT1gazlD/0NpMKG4EX8Db1QyD5MgCBdwrKmD7EyZD2zNQveiOXhqZhH1Gk2NpggMxJ/xLuDqTfVFE1YSU5CBs7/kokZpTZ1RC1Hr8o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 00:24:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 00:24:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: read fsid from the sysfs in device_is_seed
Date:   Tue, 19 Oct 2021 08:23:45 +0800
Message-Id: <873d173c3b16fcd027dba4b10690e3e3fc3b6cdd.1634598659.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634598659.git.anand.jain@oracle.com>
References: <cover.1634598659.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR02CA0018.apcprd02.prod.outlook.com (2603:1096:4:194::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 00:23:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3e877a-27ee-4fd4-ebfd-08d99296bf96
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3427C52984920623C349B141E5BD9@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqdyO3UKiVh0CPJvgQF2Oiwsu60wU7NDNGq03ig0qhWGTFysyOhHuUVsiwiiXzMX9sT/ZVDpM2E9N2Rorx8wmX91HIaWhHTP5bHxLW/piJfDpBLcQDudyQvvB59LndXQdu+l8zGPOh63r/dVtTM9Bac9pkwyyiRl0UZje9oW9EyiN+6172wj7krachlzu38+SBktodAPzg8e/PB6tVzEegOKYMo0GJLqyzqqMjfF61bH8y1rf/39ZjC5T3febUo2ATM9TQ9BuwCER7yaJfZQvqsqM9IAc4p6uI00wsEu0a22hvN5lIsfhC8ijpoJ4A/wlzF2D0Xqgu3+DhUE0Z9V9OTXKwQURAbO/xte1b3ZEWQ8UNu2jVai1a+rrntP84UMFwn7oG/QFnuasW/MT09zOMN4mc1sDgiYkPTCE88N40dkudx2Sx9ofMPaFyYg/g23Da2NJwxPy+lG/yDGPmoX8A9WDJgSrn2dFX08kLcmfq0F9yRyCQhM7aZNF1JBswiOU9MA1Hz5ZxoKnCifvjmzouNSQ4VlT07cGXVE/5eXKnaKXulBqEiejRYmgXU06TuMGacdyePy2MmBUscU4qAmzdB6KxeG15NxyA8DZXpg2EHNT9gSZ1R5s+Bwf5RtmJIDtU2vsbp0oTvAOiNTdInQpHnDObYt5ELNaZdM2XapX/IMXOkYwEmZ7w/itf03u48YO5T8P+6O7QFiSLXuthB4kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(5660300002)(66946007)(186003)(6666004)(508600001)(8676002)(66556008)(66476007)(8936002)(52116002)(2906002)(38100700002)(36756003)(38350700002)(83380400001)(6916009)(26005)(6486002)(6506007)(316002)(2616005)(956004)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WQrEh3LklLcVWsVU0VdRRXWvAc612R9HdD2lfAzb9uCKDlPH2wsFNvYNv5Hj?=
 =?us-ascii?Q?ip0Po1U7x20NUUrf4D+VM5nZvtqO66gJ0hoTts1Q4GvOCa5c6cc80OD7TQXA?=
 =?us-ascii?Q?EifoImKXFsOFgmDgiVkD4HdPYlNMqRTeF++SISHOLqCLcicR2EzfraJZ2/ca?=
 =?us-ascii?Q?uj6LqKNqrixKVg8Dw4iU0imr5lgL2nS8IxfpeEgv2GSz9BiM1k93emnU8zGc?=
 =?us-ascii?Q?C6+pL2mtA0SN3H1CtjzGKYuaVJpcbaMJyIpLRe8EqXOJtlekfbvS8DejnSs0?=
 =?us-ascii?Q?yqRvxFQMtl6fSY/VoB10ZwAI/Ft7u4dvhUcJ4cTim/2rr9B+8O7BzRIHx/pt?=
 =?us-ascii?Q?jZVK1D5fyzSI2rFzu8Vu+BB1xUXYnW10EOKav9JJITfsZwgUi3xaSxYFRw2Y?=
 =?us-ascii?Q?c7/w5oxN3zCQeWOteJYFp0hs3Heu2GcWIMUrOTznhVF6uAyhHCx7nmqpWLSc?=
 =?us-ascii?Q?1xZd5z2+Ri8Itp0rRMCt79jxGXuXodaT34UWL6Ipj38BzWuIz6B6STod4gqF?=
 =?us-ascii?Q?6XSGFOA+mRKCx6oAgsDwZ6W8IV7qbl+QDnbXDo3TcREa3J2kOUX+ZnXpKYaM?=
 =?us-ascii?Q?UBLRIgXyhWcY3m21XBmG+D74pKk2WRJFbZka+vdd6jNSITuZM0f0lZp+453f?=
 =?us-ascii?Q?Q4GMYpTokyk/41dNu8vJgOy1bY9Lhn5ofryHYFc9AWZ5UbXqojv/bF9zPgH0?=
 =?us-ascii?Q?KpXp+DJBTV1QkGKjpHOV9jaYxHxd15Hf87WZvVu4Zd9+ZxzJMRRKZtoQRMqN?=
 =?us-ascii?Q?bNdbxbfaZbuzntpnb5D51C4DDbZWovLGbnRDYUIAvqjKlMWRtWZUDVTF9mKL?=
 =?us-ascii?Q?RuQiicz9OVWu9FYjElga9GM3hURibgLv3Hcehg/jY/ApUgtHhsWAMZD9Lw8L?=
 =?us-ascii?Q?4F8ePRIRa8viFSEuHLhL3KniG4snHH929Nt2cwK4hdI2iN1tw9sIg2uJAUVw?=
 =?us-ascii?Q?hXJMZYtxJdw929VVNOgjT7my/H/0nIAj/w9kkaFwFMkntqkj+xgT1JqvBYzf?=
 =?us-ascii?Q?tDbSCLaXJTB0PZFSdM8JxW7tD/icyhshKGSmbtTExpSn0BYp6ak2jTpRVAPk?=
 =?us-ascii?Q?kMepK0F8p2n4cHV2o7RtJfn8Q/uToOXeDY6Y62Ec16g3+xf598wJFQECZHKq?=
 =?us-ascii?Q?7gjBOhNTuvHrKbXkb940Y1vQlLHW1hl+wpnjGah01LvNSPj8R38WlCs6vJds?=
 =?us-ascii?Q?tZpiyugNnVenmOd57fwREW9WXJsp1eHv6jd9Gf9fAOLcO+UP1Zms41Bz3oJ/?=
 =?us-ascii?Q?H6B4tziM94LVo7QsgP0Wm0RDWmcdTdPWxOdpCGaw/bGJjtSki8ia/gVb+ItA?=
 =?us-ascii?Q?iVRAw2PWyTeSpzuqXSk4zeZc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3e877a-27ee-4fd4-ebfd-08d99296bf96
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 00:24:00.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVzgeU09DzwX2WVrjP37bk/ghCG0x+rx0YJeiCxdN3UprJsan5lOEWmAhAWMGZ9Cu3EqaAMcOFBv1gP1iAYF6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190000
X-Proofpoint-GUID: 6HsJVUP7mgV-TTaw88BgHNhlIWaov9jB
X-Proofpoint-ORIG-GUID: 6HsJVUP7mgV-TTaw88BgHNhlIWaov9jB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel patch [1] added a sysfs interface to read the device fsid from
the kernel, which is a better way to know the fsid of the device (rather
than reading the superblock). It also works if in case the device is
missing. Furthermore, the sysfs interface is readable from the non-root
user.

So use this new sysfs interface here to read the fsid.

[1]
btrfs: sysfs add devinfo/fsid to retrieve fsid from the device

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem-usage.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 0dfc798e8dcc..f658c27b9609 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -40,6 +40,7 @@
 #include "common/help.h"
 #include "common/device-utils.h"
 #include "common/open-utils.h"
+#include "common/path-utils.h"
 
 /*
  * Add the chunk info to the chunk_info list
@@ -706,14 +707,33 @@ out:
 	return ret;
 }
 
-static int device_is_seed(const char *dev_path, u8 *mnt_fsid)
+static int device_is_seed(int fd, const char *dev_path, u64 devid, u8 *mnt_fsid)
 {
+	char fsidparse[BTRFS_UUID_UNPARSED_SIZE];
+	char fsid_path[PATH_MAX];
+	char devid_str[20];
 	uuid_t fsid;
-	int ret;
+	int ret = -1;
+	int sysfs_fd;
+
+	snprintf(devid_str, 20, "%llu", devid);
+	/* devinfo/<devid>/fsid */
+	path_cat3_out(fsid_path, "devinfo", devid_str, "fsid");
+
+	/* /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid */
+	sysfs_fd = sysfs_open_fsid_file(fd, fsid_path);
+	if (sysfs_fd >= 0) {
+		sysfs_read_file(sysfs_fd, fsidparse, BTRFS_UUID_UNPARSED_SIZE);
+		fsidparse[BTRFS_UUID_UNPARSED_SIZE - 1] = 0;
+		ret = uuid_parse(fsidparse, fsid);
+		close(sysfs_fd);
+	}
 
-	ret = dev_to_fsid(dev_path, fsid);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = dev_to_fsid(dev_path, fsid);
+		if (ret)
+			return ret;
+	}
 
 	if (memcmp(mnt_fsid, fsid, BTRFS_FSID_SIZE))
 		return 0;
@@ -768,13 +788,15 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 		}
 
 		/*
-		 * Skip seed device by checking device's fsid (requires root).
-		 * And we will skip only if dev_to_fsid is successful and dev
+		 * Skip seed device by checking device's fsid (requires root if
+		 * kernel is not patched to provide fsid from the sysfs).
+		 * And we will skip only if device_is_seed is successful and dev
 		 * is a seed device.
 		 * Ignore any other error including -EACCES, which is seen when
 		 * a non-root process calls dev_to_fsid(path)->open(path).
 		 */
-		ret = device_is_seed((const char *)dev_info.path, fi_args.fsid);
+		ret = device_is_seed(fd, (const char *)dev_info.path, i,
+				     fi_args.fsid);
 		if (!ret)
 			continue;
 
-- 
2.31.1

