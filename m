Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36C03F299D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhHTJzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 05:55:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22620 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238938AbhHTJzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 05:55:10 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K9kA8V026170
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=B95cNPl3NnzRgsazOC9303C6oDxMMKL16c//N4zsv1M=;
 b=CKaaEAgpLUKMfJEsJWrY6krM35XLLoXNZrsC0fty8OOcmMFWvvf0T8aOTJ17Ea8OL7V9
 0hKiq/pEl8m3f9pvD7IEwXBf7L8tTPyZ7u7CoPNSwledSYgDWpeZj4Z8813J8jnI+Ra/
 hokdMvHleY+IM685uIOsgu86+oCl/vmx67c2TkedKEjzRoz0p5isJu0cQqYrHCp0rXr6
 tZaBgc6HhSY+xrSUP0vGfmHcWby1HMUHN/kU3dmI3UVn8qNCJJbHMXJQE9ZzuZ+b7nMP
 EDbJoggUqBPvzbu4Cv2btviSR5dyvoX0PZLch4b/eKfnd5akHQIhh9mnt+MiFd6tH2AI hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=B95cNPl3NnzRgsazOC9303C6oDxMMKL16c//N4zsv1M=;
 b=rDvpgOjIYxfVk3slKHCpjq36O8On4rqvHbubwTZreJnoUCaYFIW6Ub+heNfzwPo0CfHH
 BfMncvFr7yLvmgPiSRntuZu+LYGDf5IcHoyQf6CtYWCR44y4j3axQlgXLkHGe8anks3h
 M1PfXnKXHzaAnZw5Qr/MHHAOYWuRb1+oZmqOgChFn643241HfPQG+rNkpU4YS5+G2Y1r
 qNeswwCmrK9mzdrjYd2nWRW8LXZCTwFIF6sJrOObdwLsZUzBlWOLTFpfIV30gScIVecU
 LXLXGXFHC/rU9vVuQdyypF1kNh8NXlLlYOJbRmBOjcAK01nkoktbVe+uihaqwo+WO514 DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs40j2rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17K9jC8o114375
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by userp3020.oracle.com with ESMTP id 3aeqm1dh19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV0gXtu+Ws+IHecSoVTbkeyLVYyq8ye2FIZjdhfnBwYmncrSwumm+lQwioQsVlaEHhcInXYDIsiPw6d6WCB+PsjM5KdbjWzZyXvNUKeGMf166AKhX5ZCOuD8omUtyBLP2Ynqxo1zksN24in7r1gdgqKDQ39Lx/Rso2d4OM1Mlr2VuNMc0cNVcIhRgBNdPRfb2qhJk2crrH1/Ie+JedezLIvqg2DAa+eK3fLZKSe7F0bil+DfbiPlA9uoiXHIoAdkKFFp9E5oZ99D3bEKculd23ZwvMmXUvethVeu4rPXjcJoPy6hxFr3BBHDsDIB0dpUvk1jtpzeMNrDO5KvnE19ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B95cNPl3NnzRgsazOC9303C6oDxMMKL16c//N4zsv1M=;
 b=GrHRTHLIzpDFfdRzKdpV9n6Za2EMcmN048erUzLCefzfIZKMQwQDwghL2If+JeICsx6hxv6q9RDOjAVolme92gFFOHFScRcI1jjJcT8FMM53/QbPe7XsnTs70BvLgwIJYzpA5JLERm6ygszAu98tD9OwtsqFjxhgTZjD6K7ejyEjL2p1k9yrtv7dS6AXjhZ8JOdhoIwqxHC6RZ1yq57PD8glDJSu+XvQX7gQa9Jovzc1NfGkP7YkaL63JbBIzhpc0ozzB4GsY/hDKIXXZmIZSxgNkBLuAb+eJ09z5CKvG0upGCOlihlLXfImz8pnWlibiTYiUCtMueBz/hVJOdsK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B95cNPl3NnzRgsazOC9303C6oDxMMKL16c//N4zsv1M=;
 b=L6HzJ8Q8LdVmM/0KEnhy4wkCLRy7OwRWCV0Zgh7q3eU6Mmmn7AUTmWwAko8BLj8yvLPOpRnlYvPXZAAe6rbcv3a3nicprsEJHYZHZE7C4fUbwHz6bJ09eZ7JAecVQRLYarR2ArIKe3F5KD+SD7NFWdPkkqQ9kcHOVe+r1bGABrQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 09:54:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 09:54:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 3/4] btrfs: use latest_dev in btrfs_show_devname
Date:   Fri, 20 Aug 2021 17:54:11 +0800
Message-Id: <7c09f4adb27f4dc9de47ec9a4b8b4b540036534e.1629452691.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629452691.git.anand.jain@oracle.com>
References: <cover.1629452691.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Fri, 20 Aug 2021 09:54:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fb40b60-7975-4de9-b786-08d963c08129
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3427AFF05FEA80FC475BF3FEE5C19@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxI/+aAv2JQpV/hK1lhjtGZIU+Qxf5udvaPjxRrSIeVXyGge04eEIlNT0XkzuZlJfnZ5Npf5jE/KRWgxgEGVxVEZUakkUc+68O1RbreWiNRU4VS/2ktqLvDHBNAqkOM0lSvAVG0vbNL1C7rRalVjCCjyzAe5p6lO3cnJ1nj6LzLPiOaY2EdskUzkO575sOlVuc6ctBH5H93YpQo45gb3guVCvH7oW7I+JIB9pNhNN0m8Z7EJdHCSE52gE7RqJmDudKfXlrTxCQUqF+4exDwAiGqoDrBelFoOpIFoBpGsWr59+TyBiTcuXLjK/7qDEGup0N56AdJKx4a6kokDQT8FMmf+xdfxinQHknD+N/Ux64lqL5sXcEzOhnoGha0revUvZ1UwQKS6v26M42hRf3JLw9x5g6qqppklZJHAvT7X2861oD8E0tzmsg6pCxuPKM22vNPuAn9Vk22g9Vcdde6pqB4ppKrl0hYKUKL1I8ND/mTT75UlBdIoqhUezoHnOVs76O3AA2XPoCQVBMVgN+CBcq/hhYn5g8RBOOHt20qEYe2lvi0CR8cAmRozEEs/xtTnFD5iLPD8w8oVLhJWc0fOsp3/9u29+s8JipXfjiH8zHcRtmIQynocBXrg8v6FOM9SYXycmsBgVQQFXI3UqqEFs4W0D9AK9+a4vgT27T7x6jDrF+obSfGzxR13RvCauBZ330J6ZiVO37kvyQ5GZnGw0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(346002)(376002)(6506007)(5660300002)(6916009)(66946007)(36756003)(66476007)(66556008)(83380400001)(186003)(6666004)(478600001)(6486002)(52116002)(8676002)(6512007)(8936002)(86362001)(2616005)(956004)(44832011)(38350700002)(38100700002)(316002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNWzEf0imaHB80OzxAY/pjLlCl0pH7uqOoj7gy4es4f+1ZNgF1dpwgzkkl61?=
 =?us-ascii?Q?7viV9VHtruZNTPCkYpp8paCkwsAgQAPCuUyNsJMW2l6o2OnEJuzscgwJfGbm?=
 =?us-ascii?Q?bpIEA7dNWpnlsYP9y1Xz7B2kGyZ9VFIJI/0mKLkfQWS5x18mwth2mAkFC32U?=
 =?us-ascii?Q?FY5Ile8KtiQMlplp/CaD5t4D4gK1rDeV7HIWT7sKElSpJcRTA+Ol1shdu6sy?=
 =?us-ascii?Q?wQ3UsvKAGIBHliztTLABc6Am+EldiDOVmWngIXSYntb/aFw8F9m108VLTGx3?=
 =?us-ascii?Q?SHiMdzN6dKf78InnjFSL7zKdVeXI/sMC55EkCKaqAEOZdNGSeLf77rTNbhci?=
 =?us-ascii?Q?iuJqZWNn0mDS0lB52L0Ffx/218C31a36Zj2kC6JNIt/JDk6Dp7lj26KeNdD4?=
 =?us-ascii?Q?+0N4wxegn7QArhbxPqGoH73G9o5hrHI5ddvefX/mUS/0PP0CzUVYNHmkgiRm?=
 =?us-ascii?Q?WpyxeZU4IVSAXcoc46AOajbCM/Qmxx5ON5824Sa1JRnrWy0Oe3WwzQI9ihN/?=
 =?us-ascii?Q?o6QNASf9MJw2SF2IaFz6ivxYINcULNCWzWS7ZHD2QbpFUAtXss9MdDCk7fYw?=
 =?us-ascii?Q?dqFl3ZZSAf1my8/vv7+0oZV1+6yZ0gihjCimYnh2lkRdibYBQhxHG0JuijHJ?=
 =?us-ascii?Q?7cAWLNFSAhWbfDT7zIp4jyJCnIZP8gasriYXcEqvtyyn5tow8ZY73kakxCFU?=
 =?us-ascii?Q?8dtl60NsQ5HkiOwB+UDBYSrnmebqb3F7e6U2UVBCmFImDf/v3+rtNdD90MoE?=
 =?us-ascii?Q?Ipt/OF2+sZ3g/XQeBNixiMaDWzTbX8G6w5qZ2D/roR4wCG7LRG0D6afT8dCP?=
 =?us-ascii?Q?pDEhOuhSf0Ju7csqMeFjtO262wW7SpvfqcT5gAmWzgmu6kLrg5V42NErFfrD?=
 =?us-ascii?Q?llssXeGXKsx/Gj7M6esrbde/hajbugQoA0Ysk03Aw/yu9ae4lMcViJeMp3kt?=
 =?us-ascii?Q?ylc0rjTzWXgnlsi5Sh2ROxLFui23jRLZwevq868ujdo/j9QZ3zZ+Y5TT39kO?=
 =?us-ascii?Q?bmaSHQTeTmex5MICb592zzDZb8nmhhG4sxOr6eiJPApoE+O4XPTlbBiED0/w?=
 =?us-ascii?Q?HGr1c8ts5w7SwLEe845btF+Y8WFxgS7EROO2/igFDe0yOnseYChhg0w6oMCD?=
 =?us-ascii?Q?CEsjAiHxYO6tPO5CvUp1HAvU8KF8K9UbSpccUhQvgk/Eqp66YRODQvHcrzmb?=
 =?us-ascii?Q?jiBrql4AjY4MGzRU7Mz19yhl7qMms1yYJho7ZwUGOHER7uSKOnHfq4Xk2luZ?=
 =?us-ascii?Q?4fJvTyugWVZe6+GLMA2DQ295v++TnwFdiGnzyGl1E024JDVwVjO6wWLgEMrH?=
 =?us-ascii?Q?MzdGnqBx/hVx+bebNp0tJCbl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb40b60-7975-4de9-b786-08d963c08129
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 09:54:30.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNc7pTiWZvU+01vrN+sxEDdtri8IpSZdhZCbpPkGPc3UPHvyfbseDN07k0Ixlvj32rFpb+D/6iW66SPwG/kxaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200054
X-Proofpoint-GUID: HxcMky_ujRxebtnmxznnSr-YxIlsA-dT
X-Proofpoint-ORIG-GUID: HxcMky_ujRxebtnmxznnSr-YxIlsA-dT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

latest_dev is updated according to the changes to the device list.
That means we could use the latest_dev->name to show the device name in
/proc/self/mounts. So this patch makes that change.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because,
1. With this patch, /proc/self/mounts might not show the lowest devid
device as we did before.  We show the device that has the greatest
generation and, we used it to build the tree. Are we ok with this change
and, it won't affect the ABI? IMO it should be ok.

v2 use latest_dev so that device path is also shown

 fs/btrfs/super.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 64ecbdb50c1a..6da62ebda979 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2464,30 +2464,10 @@ static int btrfs_unfreeze(struct super_block *sb)
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
-	struct btrfs_device *dev, *first_dev = NULL;
 
-	/*
-	 * Lightweight locking of the devices. We should not need
-	 * device_list_mutex here as we only read the device data and the list
-	 * is protected by RCU.  Even if a device is deleted during the list
-	 * traversals, we'll get valid data, the freeing callback will wait at
-	 * least until the rcu_read_unlock.
-	 */
-	rcu_read_lock();
-	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
-		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
-			continue;
-		if (!dev->name)
-			continue;
-		if (!first_dev || dev->devid < first_dev->devid)
-			first_dev = dev;
-	}
+	seq_escape(m, rcu_str_deref(fs_info->fs_devices->latest_dev->name),
+		   " \t\n\\");
 
-	if (first_dev)
-		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
-	else
-		WARN_ON(1);
-	rcu_read_unlock();
 	return 0;
 }
 
-- 
2.31.1

