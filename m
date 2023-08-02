Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6F76DB8C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjHBXaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHBXa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19E26B5
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:30:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiQaS002262
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=Ox2af2lQ8vFbNKP0HdTY/k8AQO0K6c0cJGlo7nAkpSU=;
 b=bydLKXy0E/NPkI4LH3k/F1HeCURb7SQzi8ndVxdymLdx1VziPYxUWiJ/CmisOX6nGxxs
 HcbvwR7uSsKng915wTzm1XCgFttWa7dBIU4qQhdl9Eg0ED3ggTFIMkYBUYcSkkBR4r1/
 MSHstVc8VQ5aL6Tz0WO1djchtvSE6SYhDRCQtJ8B3CFNV5KqSAqtK7U4Mc4DvuiZZmKA
 Rqrg9YsU1ZizbjmZbspmGCNjHijlIhWiTqvnf+FKODRVts1RkZKWsI9zSTTDFpLTSWvU
 dezUkzTdKQRZVA98v3gstdWE1zZce3mf26BiXOVsA7uMDmzlquULBOn86+V8kMvbamnw pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2ggfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372N1FV6025102
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7f4t1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMTaMutZULaSSnlHpitZEeh9ihsxV8sV/e8R0Cgy4+qGohOHh/WLs5+dQuYFR/BrnbE7czRM1WnijJQTQo8FLPeRDwlQPr0jaIIIXhhWlqlpSCXlnfrlNy0tgBlmBdKlOE6BYc01v33s9pMpzD/ZcDJoW0oQcAUzbZz64zqhx9r5+HACDjeh0LBk0vN+Vc4V8T822gSaDDVNyDFeNAjW4Sm50feZtzFtMKDdB1hksrcunIOcDVTX9feKph4HIe60ONvZkTuDi67eAhcU5vNam2KKTPzovbI0MPEx+zWruNUg6yxtsEn5ciuzdnWmTPVMIlYsi44tweD3CBwKm33p8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox2af2lQ8vFbNKP0HdTY/k8AQO0K6c0cJGlo7nAkpSU=;
 b=gRdxilgqon2TJg4C+KnSktbE9A5OZ1lUSdiwbtpKU4RPU6BFD3pLepJWriIQPVNnIs0dZkejtWhUmTqMsP6+RcCFkZwggh7nqAxSDQ0/EsKWGBvtyP6P0Svqshq0MOjpEY7Dk0CZlhKEiJxEz0nH+7oczSro+H29sOi6hcxrUrBLhrMWsPq/ifgPglZjwzmB9CFETqD608s1smZ9FL3FqDMZbAdk9XK2gohGJvqBhL95+nXRu5xwKnxqX/nF0fLvNXTPim48PEfkurJ+xsxo0RPQSoT6ajO62CMuXqJHyWvkwipX1aJQOy1XXOEZ/awXK2g30icFZDiAAzi1A7bKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox2af2lQ8vFbNKP0HdTY/k8AQO0K6c0cJGlo7nAkpSU=;
 b=u8JnFauNnmqeUtM+K0pP2tGfcVdY01k1oU1QZI2VomNx/bE5Wgc7UeABT9Yqv35xQd7rxAsDHc/nTApWthoGV67BmWIuVhU42nVvq5Hg0lkX8V6hv+LTzBBpIqly+Wtoee+vNBLAb/gueTEh1tNTzQfqqdQ74sUYR3hrDZsI1Go=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:23 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs-progs: track missing device counter
Date:   Thu,  3 Aug 2023 07:29:40 +0800
Message-Id: <644a524e8929ed4cd749b0b35ac0567271a861e2.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: a617b27f-f62e-45f1-f4bb-08db93b07162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYiWbB2FbBKsPMUyZLs6JAtrffUFV0RV38TVNINRHzmqiuYbzpOJnTq+P4VJE59aupmcjj5Lt+JGfT+ZTJ3fXvdpItKTkF0FXfqE41dt8v6CE+/ehtLtbK0+VfgDOefrLCB68TtFJo3faSXxfvVb5AW/r19eaE0kSOzhT1msPyLp65LqU8sijFWnsdHCi3HSMunEkjqJpVZyIteSV8iNpxmPsmwhYJvrVOlI1Slg8M/I7IRSuu526VKwPV5K1wLVjXoBSwiKNixuRBNhlC/EZ+gHBe9NOkTgqo71mv4lnVqV3J6BKcn5RkppPB/avizRnQpLDcUzmlhBvmn0aXcJzLBlGA5bK82+2V8lgE4Hm2CgvMD65Dwnwbp5B2t+eOb0seMMiZ2dpiMQAfTfqXtwaHGi2OwI3XXHsrU+Z8FSMXV4AyEK1Iy4j+O5xcUZ/lPq1AcMllapcaMAR94WkAM+zntT4rEV/eKr4yBqudzPo5ZuXKZwoXP1wo9Gkv2gqSdfmjdJamqk11cdkXMPKTLAYjjM5WJODA4PjK+eDNBP3EUaFuiM13D70Q/EZkLDgyif
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/SkcniXGJHO4LoVrqN2Ea7OclbFGZ4H1Goq7z4ZE4PAVBorLg9MDfWs9GV9g?=
 =?us-ascii?Q?y6ejo874i8fch7WdjtfzwqRYWkhytnGVmBhtl89DNG2qdJTkZ1oTlEvZhfFG?=
 =?us-ascii?Q?SMmAlmrOCKm5qnkFfJ9YzjiZAkmPvvqkMvboYe9Rjfl3wTaIbPAv/GjUiauw?=
 =?us-ascii?Q?XyYsGC318HLxd2v2lsVrjbU8V5v9zuTJPLtBTOyagmDMSnfaFv+c+yQZEHcL?=
 =?us-ascii?Q?eLnJjmdKZ+4AIlNMMoT4DqxfqSVQNA7goIYN0zcAe2nc4KRT79W1j2mVVmiG?=
 =?us-ascii?Q?JvS3Ffy9kiAFNpfUhdLYhr06J+Cf3zfYv4urNEElQGA+GpeFjUl1FyB3L2ep?=
 =?us-ascii?Q?f+ANfQ6Djj5bzEjyy4pdWcYm+UilVeJpanc4EUoN8pCBPRQaYSv8QUcVuN6I?=
 =?us-ascii?Q?vM9Kvm7IDoVQP5oLqyzWYbQpoiB/alXHBfMfYfkitw4+EPenVmN23CxTA/zh?=
 =?us-ascii?Q?UhXpD+qxMXGARGsTRZ0W7BPqh3k1mEQHVxpZJD4lgouXuuvFRlWMRrSAxOkO?=
 =?us-ascii?Q?SMhI4mUrrVrvae8zrOsiLbv5lg9sMZpf/1kwPsranfFsIQYzx3sDFMa0pbAu?=
 =?us-ascii?Q?mGEkuOuijxDbOu/2Zs3q2UfjeYHSG0iIcEIYt+91ro3nAAa8HE2WPpB6xK/S?=
 =?us-ascii?Q?CLb86IjYqODsP5P8sjKht6Se5zVJ1oiutOpJ1lcOAMqTWbWRmmPNjLTaGcCy?=
 =?us-ascii?Q?V+Ij28ZWrn9hk9cPfqx5FUFy9VBGIkiHEbL2dlB9mExqNo1uqqI9LM83qxAe?=
 =?us-ascii?Q?5vjXAXQAZFfZ3/ax3LMhJF8mmnyZ4om0abpvUU30jFTjY8BQR1XPShZGZUyN?=
 =?us-ascii?Q?wSlbziHVDTWXvVec5SrjXMjM9mUXECW4Eh+CAes31MQA8R5vIkUjz0cwQMIu?=
 =?us-ascii?Q?3url1Ij6nV1qZylLIqBRCY4mODopBy/aGA1qO4APZDdj0xQkHn3jo5Gi5/tx?=
 =?us-ascii?Q?FQXv4SODVzjYm3CvjhhJjl5uis7Cg7tH4OS3N5Y2YxtbxXMlLWwZ6cI7sWtc?=
 =?us-ascii?Q?ILu9yDE2phsorrU7LCXlMLSRGKVjkwZo7nCXIBqcTRrdvTVqxl/AiSgH/ko+?=
 =?us-ascii?Q?nhCBFLLyqQlAvkyOWVx6xad/NZu8teCeo9beMpxWo4RcrwIkn+hbJ9xyT9Lg?=
 =?us-ascii?Q?zWPPHUFaoUfKDqtOU2qSbraN8Y3AlUHZtLzqRwAULq0eEmxDyhETsX8PK71s?=
 =?us-ascii?Q?vWF014Dlsye9AvHbjODM14bPbruaddMxZVYfLaTZsjnp3CMu1br5nSx/WPoq?=
 =?us-ascii?Q?LrCGInwR8uB1oqOw+310VpoqVt8BBqZButYwEgCZB/n9s0AHcDb/SSXaSMFY?=
 =?us-ascii?Q?dphfILzSSRmOwu3wK2lgFIaTO6hoHu98bqMzhjAiCBgbDNJzDjnCmKjNx4ej?=
 =?us-ascii?Q?A1V9V5JdSZXaWBiXJxgn5zXKgQgw7izo/smwcqx8LJhacOjT+tVVKqkwKWYL?=
 =?us-ascii?Q?XycyNdMmSeRZSbBoNEa8frrztnsBgs7zaXcsDSnMDIFiOy/ChNN7NNiWrz8d?=
 =?us-ascii?Q?u/nwhg5lMLT6+AwmLBHoxujiqxvAQcCo4rOdi2HIc2bD9qXRrOBD46gAhUQ4?=
 =?us-ascii?Q?MtIJrFwm7BLFVnjMlTpRp6mzF3tEEE/fekU+/hS7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZMIfwBvDzXxECkhi+ljMsfbS/q8QxNAzVzp7eHuahu9mooVfcW83cmZkptRLSwFaNT0XfpPKoAcPI9sc09y+Rzg89jBWvYqD6g2e0Oe3OhGanFIwyts9kaIKOsojkpKExbnsqoFICZOKYa0nOqdUxyD2eAEWW2DyXpT8Ftky26hmK+9nWcCgqWrLa4J8M6pfT3oI1haVwUhhRxhNpGX8mdcYHfVZp4H5/gHZL51IwZfyRevsN8EPvbrR/5hpnwBBO+qa25iHdcluceEhKWINg43iO73f73BJjOCGj5IYSBfdPH1ocHDOxjVsCxyvO8PpQe/dHJVbNDsKHcBK28DTM02RPysP6qNWy+BphAwW1szaflqk5o5lExyi8QEx9UE79/wEzsRsqFJ9lYy7mQlUaG17Bug9NmAZOY8kUQDlddy5zj3Akn44rvvK2R8ppyjIReYTOWehO6pqBrHiWxAuJM0CA7oFAg2a5nl7dF9CWB9OqWCbuK7jxDrx+2xlmDq5OvyaYPJIcNk5Wbn4GS4EZnhXb/COoCyqVpoIPDqPhQiIByNvPWVGBGRaMTNA6VHBYhmEtnEJ/NyiRcn1cfy4Y4tqiE+YUKdOZkRH4qglRK9E4beHDx39B3o5Z3b32jzls1aJYM4aPhUcZQjI5QAPbmU37Lkvc75s0Uwf1hKCnMlWpTkFuX2a2b989GhZwzWr+Acu88TIJhGWSAcqgsSjbwP85Tx1xWjnroLtRzL3E/J0SeJEEb7QX8rAPht56+39cT0aqK1D51YJVvpMHJzdpg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a617b27f-f62e-45f1-f4bb-08db93b07162
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:23.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXFcxgoYq1wSN8X/fh8HC+UQOrNQT90R7mvmiVaj7w00AMiqPXjEK26HhC4u8WmKX0y+8AfnhVcAaZaZTwIIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-ORIG-GUID: K2shaun-w_NxL7pfWxSGZjGnyJln9_JW
X-Proofpoint-GUID: K2shaun-w_NxL7pfWxSGZjGnyJln9_JW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Maintain the btrfs_fs_devices::missing counter to track the number of
missing devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Maintains parity with the kernel.

 kernel-shared/volumes.c | 2 ++
 kernel-shared/volumes.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 92282524867d..54ef553e8230 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2156,6 +2156,7 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 			       (unsigned long long)devid);
 			list_add(&map->stripes[i].dev->dev_list,
 				 &fs_info->fs_devices->devices);
+			fs_info->fs_devices->missing_devices++;
 		}
 
 	}
@@ -2258,6 +2259,7 @@ static int read_one_dev(struct btrfs_fs_info *fs_info,
 		device->fd = -1;
 		list_add(&device->dev_list,
 			 &fs_info->fs_devices->devices);
+		fs_info->fs_devices->missing_devices++;
 	}
 
 	fill_device_from_item(leaf, dev_item, device);
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index ab5ac40269bb..24b52c86562d 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -88,6 +88,7 @@ struct btrfs_fs_devices {
 	u64 latest_trans;
 	u64 lowest_devid;
 
+	u64 missing_devices;
 	u64 total_rw_bytes;
 
 	int latest_bdev;
-- 
2.38.1

