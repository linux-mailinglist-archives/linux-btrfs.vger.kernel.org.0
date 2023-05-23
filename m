Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24070D9E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbjEWKFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbjEWKFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:05:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A79186
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:05:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EFCG027123
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=IrROVOvEcG/8zfSvemRo92shb6XVb0Np0SqryV1gftE=;
 b=QJhDdmAgf8AlYo3tGLfbqLVLF2GKYjYl5W/I8yLghDZPgdpQBx/9iVOrpr9Wb8VCqoVA
 +pIH1Ua1S5NWOjM3H77q7K7H1UWVqjwhIkJhF13ZJ8RzGbHpDrRFq8ls1Ay+hT8rv/YJ
 aXnYj6OGle0Zj6dWShs4Gr7sJyxQwV0aTKKFL6JOg4ZW+MWlh4vFTewq7PQ0QDxzstGL
 ZMPVtf2I257LP0w43YLr31hW06m1BmyWLl9P1CCv53huWblnRok1L2ZmYL1aIqrb55NI
 llw9ucOMWC63/A+x57ebhzZUR+iy6u/4fpjHkIGOQJuIjlcwnpNvJ3f5d8JvDTSZItOy uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cct29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N8dwj1029050
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2am81s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORBk3l12OBLNldFKqBO8uSiV1nuBTGlFz5YPVDaf/mKtCqr/hrvR70PzWdV/butjvFoZP6S5lpqSyqkcM1hCV0Wo3qIxoin8RrNcHxsjkBYM6LnsXA4VtkVmvokMtQ3mS2VqXBmAmSzTsWdHQkQPCC0BbmWnzalW31v4Vi42k5Gr25oXF6TCY4y/1JMeIFbb9/LMOzAPDECYCwE8egjUenAgWpd1l83wJMZ4QNU+gyxyDPYxfW83Y43LCd9ciNWWOvaQf9D/cdimHJf/wGvRs3/J807/FyOjEMuJfrIC3WZkjMb6ueyIPUtIr8pSCSsWQ8qg+Zq9WP71CNbgD7gnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrROVOvEcG/8zfSvemRo92shb6XVb0Np0SqryV1gftE=;
 b=geCv3siwpXPtRssIWYWfFQlcGb2IgUZGA5VkX8yzBQLDd2qMZ9yaxXW085V/Typboyt5Q8Z1+UenGnGrgK2/kituvlBAVUs8XCgX6QDhXrgTEVIQ7migGGEqLd4gwGE4oGAosCjN/dcsWYrer9x8Sy1dN2Ig/jP/k4muEHRqekDnc/X/qzaL8n5d0eXJ2nwVdTBHz7Ax0wK0RYuugNPb5Wfjfq4h2ryHbQJ/TdiWDb+bQuKlgt4Zlis4gLE3AOnFCom/QXDG/UxsRNb7a/iQSqMxi0tbLnyXhSc2NeNSSTmX4fdflmGtA4JXeSog9UnC85RDt1dD3l+PA0Uu1gDT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrROVOvEcG/8zfSvemRo92shb6XVb0Np0SqryV1gftE=;
 b=Rmy7yo9CUH/gvgaCBHsCUiXbQVELC2fEIoXgtiSS1g1zUlYtQvyRgpt14g1trTS417vpxoUi7BiZd9GZC0qD4VtlLbE9ONsVtz4SqCyV7VltI4Wi4e7w2qWY9MIVEGbwYzWNewZ4hlvRlKH8NoCQ/0nC8qJPVb5PVTk+CqsLUSQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:05:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:05:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 7/9] btrfs: refactor with memcmp_fsid_changed helper
Date:   Tue, 23 May 2023 18:03:23 +0800
Message-Id: <22107504d4d780ff15382ec0abf531314069692a.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 964807f8-82e5-4416-29ef-08db5b752cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiWe4aSSu773lSa948mNNyq6H8ImSbCN20qYi5T/d1spjtWdcdt0q+cri6pxs/gw5MMqg4cBZpHCoYpjh/sJaJ5MLaKBg4/bwUSPXa3TeZGpvvVzyUfBLFSfr0ICB6KLndhLvl7VgJT3t1eVkbMHjeSVnHs/5Yjjl3KNeD/cqFRzSgr129cr6NEVOHRPFItLTrh60HpulHb6Rjl5nyqR+sPkjW30n0aJslumIWjwTHhbcYfMqejiENVkM9vNsnICkZwZ5m1PHaUpsNuUiPHTc879XuqT7iZtT0jcP9olGLZr7N8/NWHn+/OXw2ZTtnIWonG98RqU909iL/zjOjYlq2oegxhHfk5RWDjqrNkGF50sfzwz0qbtG88TWURKXCZy2ASWoygc9WEV6m6BboWlp5ZBpSyY1INmu4gRmQ2JDB0lYaeEGhRsdV5P+kpQEDIpabjcsds5egehYzAY5XYE6dEmJaGusk8MaWCsW/oG//V06hOX/05LYMsbikImMgZ95187Bq2BVa0Q09lR1MlaSIVfNLURLNUaYs9zZRTjjFWZqQeM1ZR6hEuFe6efTcHt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(107886003)(6506007)(26005)(6512007)(316002)(6666004)(41300700001)(6486002)(66556008)(6916009)(4326008)(66476007)(66946007)(5660300002)(38100700002)(83380400001)(44832011)(86362001)(2616005)(8676002)(36756003)(2906002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldVaSV1kznH3ec3Jmo9TKWMOe1xNlrEo3xU93WR+z+Jn4yvsbSCL1vlWTFW5?=
 =?us-ascii?Q?7rewgrsfb6Pb5mHSV+NG5V+5IjN2UqgWwlPogfMlspAC01i7QhBPoJpyyIci?=
 =?us-ascii?Q?bPtnxOUxxdukRMbqtc4CV8kHya12uV2df5GHYq2woQ4kFHSGNS3BFsqEwKiw?=
 =?us-ascii?Q?H+Z/e10STZ6secZm3uhQyuEMiMxJ8CrLWqdFH8vq8SH/BozeStbT82ZFyueN?=
 =?us-ascii?Q?flBOgtK/8SgfOb66XAchQFWHGRvl8sD+MEl7woy/dVDUQ/yCDpW3viYwvWyH?=
 =?us-ascii?Q?ubHavXiS+IgdWJy2lF/wbEaJezN8WlSaDrB5zmkqsgi7A4eXxSlYy81ypAc8?=
 =?us-ascii?Q?0/5Ocy7w5KFqALJ3az6ZuSgWxE4birTFDrsFOvvfjuePAaT0CyJuhk383sEU?=
 =?us-ascii?Q?GSXNABLhJIo/xnT4BVaERMcANa/FlUy5UiL3oq4j2z5Nj92xh3U714ZJV6CL?=
 =?us-ascii?Q?yWsmkBbjWgB1rBmtd+HWIqfz8tXQp4Zgnu4fedkDoQe3vzF5Oq38P0i/sSRO?=
 =?us-ascii?Q?ysoroBV+3jRSnojZu81ftxGCghe8HFYEds1VzRSx3z7KS+WzvWQ1pxNAPaJN?=
 =?us-ascii?Q?p4OOVt+6burStPZJPElUM75JQar4c0TZjQjK8mwYmWtYczLftdDySlKBqjZ2?=
 =?us-ascii?Q?zpRuuAqoQ9rKHH+5YPoOBBErsJgepxs1d2J/nfthwUJXOyZEeWh1PrKO2YNd?=
 =?us-ascii?Q?KQ9bTk97ZlbZhIcQ0uzGEicB6RpAVr0DEL5b1HWuxgvh/W1yXFvZXBbwDUTt?=
 =?us-ascii?Q?ncObWZWwyYflUPWVoQ4cY9MvM6ad0arz9eU1hzlSnFe8oedoLA7ksEqMmmka?=
 =?us-ascii?Q?OUNwOeGUkwic5N/CG/rHarUfyNWXTThNIqFf/ePGLs7jKdCqBqSdgW6unkdw?=
 =?us-ascii?Q?uqDq5jY2Jh6YamQSg2zXT5b/fvxpc/ra9MqNcWE7PTBKutFbTA69oWFNTgrM?=
 =?us-ascii?Q?eJcuE7fW1daPtA4DY+BSUZJljFyWobXEopWEAKZ+WXJRd5X5QTmwt7J10Gk5?=
 =?us-ascii?Q?YDPA6Nh1i2Ebwfjzgz7uw9LOS7KOfVy5yPhgOXgFuyG1yyACUCGGMdplJZcW?=
 =?us-ascii?Q?1DMtd44qZetnxrxWuXrZ2QdLiwmxY5WqfS3O4DswOojawYSvI+1fMjdbtLzn?=
 =?us-ascii?Q?IF7eWNjd6p3wGVdX55AQFjuPYQNhvrindQE5aO75Ry/5UsPKnR2PKIyW7HX3?=
 =?us-ascii?Q?uDYxfgQeNdwyoBOEv1G7noU1j/tF2NEBH/rcNaxSd/xM4c1DFXl6uz+Fa99b?=
 =?us-ascii?Q?4PpZzV84djil7hDqtga3Ji8Do2QWSHsp9b+yJW9yRyp0D8bRbLzj2e2HOSKp?=
 =?us-ascii?Q?0X6v3xb3n1MH3ieBPdvtRk2ozu1hkS8V2gXYsLujWZaVcvW2OFJNKombLXsf?=
 =?us-ascii?Q?O8nMAvJBx21pv14tzodBWFfzVhm8k+XIOeooB1QU5Ge0dJFoncF+/XQNrsE/?=
 =?us-ascii?Q?xLLRMqsQwQSkWCghXWRWI8hWpqQnhcv4zYh1LciTNmrXpsffz54IL2aDxy3P?=
 =?us-ascii?Q?C4FHjsk7r60P5qVePlOiyXsnTJK8ym2ycz0iCbE2unR8DojjUpkH3VoEFwIK?=
 =?us-ascii?Q?gC0kjjiyATMrjVFUajdBeY6Z8l6l7wGqm0TA2JfyCS9pjEaqg5Titwia+uXl?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IyxE7MeE69hcLp1lKF++8NkiAW5Aw8heRSCxXVfW7Lw8Fu145rxjra+BvwI1tSzOF8qub9hq2gB9TQgx8aAkHsC6+gqWzmGmHeZPDS0yCkY/csQzU7u+759/Md1C1OmPAbjs6cqi5HajwnsNMg3EjkAuQaAHPf8ps8hx6U/LqMoy4gRnSTOfJsGx1F84KinVMwKupJp27JrIz4bzmrdgb6xip9WWVB9UWvIs2m3mHMuPVspLNnyKGnJWqjB8DP5Hin4ZrcQA32xJwNoZpfZhM9nmW9udfjk/Wx3EwfxVfHxbVzOQoRA66zsFWtgT8yevCVAp/3ObTTf4HgKqpj5B9V61lR0PipwsnLbUZ/zpZWE2SEQrT4cAY9Az949DZoNb//6OEgjK4LyWTo13UHXjLOjqn78p1zahI+RBfm1lS7eiRenWQOQAJwfdS2A1yDAvLObCUePsBaO/vyGnMpOF0dWJiCsnM+DdE/so6qhmKdjImy2D95x+hVLxi4NXsMrS5kCQhJxVkw3Sod/dMsh/LEp+SC1chQOuLX3qtH7cGXww5QYjG9Z/rwEkBcv2VzvTa/oRb8997md8DBmG0WdpG88Ykitf/j1ubbXLFfLsOIDjKAS8fv0BXST+3hpEP49xYt0/5wfiBE71vuV8SsKw/KxYhTRYRNrbc3oefGvp89o5mX5F1eEMLEZLHazKzCKZsORDbKXNXknkFtbJmrO/30hdGSLUxg5t7e27HjegPYvHcIr1/HJ6sxbNp04OljrzOVJXAnGA9DvJ5HbeYEHnCA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964807f8-82e5-4416-29ef-08db5b752cec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:05:02.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4iHxeHY+RprOfs2bgBdQjL5NybpiKkLsV2Oo/xjLMdO8NnRcDeKpS8pBE4arBJ5HY2YTfbJwQmzxKbue5QpgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230082
X-Proofpoint-ORIG-GUID: oORrbmJ0mJ5sUpZYQ60uOHDkvufWNUeQ
X-Proofpoint-GUID: oORrbmJ0mJ5sUpZYQ60uOHDkvufWNUeQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We often check if the metadata_uuid is not the same as fsid, and then we
check if the given fsid matches the metadata_uuid. This patch refactors
this logic into a function and utilize it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 48 ++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8738c8027421..730fc723524e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -458,6 +458,20 @@ static noinline struct btrfs_fs_devices *find_fsid(
 	return NULL;
 }
 
+/*
+ * First, checks if the metadata_uuid is different from the fsid in the
+ * given fs_devices. Then, checks if the given fsid is the same as the
+ * metadata_uuid in the fs_devices. If it is, returns true; otherwise,
+ * returns false.
+ */
+static inline bool memcmp_fsid_changed(struct btrfs_fs_devices *fs_devices,
+				       u8 *fsid)
+{
+	return (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+		       BTRFS_FSID_SIZE) != 0 &&
+		memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0);
+}
+
 static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 				struct btrfs_super_block *disk_super)
 {
@@ -487,13 +501,11 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 	 * CHANGING_FSID_V2 flag set.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->fsid_change &&
-		    memcmp(fs_devices->metadata_uuid,
-			   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(disk_super->metadata_uuid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0) {
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (memcmp_fsid_changed(fs_devices, disk_super->metadata_uuid))
 			return fs_devices;
-		}
 	}
 
 	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
@@ -684,18 +696,16 @@ static struct btrfs_fs_devices *find_fsid_inprogress(
 	struct btrfs_fs_devices *fs_devices;
 
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) == 0 && !fs_devices->fsid_change) {
+		if (fs_devices->fsid_change)
+			continue;
+
+		if (memcmp_fsid_changed(fs_devices,  disk_super->fsid))
 			return fs_devices;
-		}
 	}
 
 	return find_fsid(disk_super->fsid, NULL);
 }
 
-
 static struct btrfs_fs_devices *find_fsid_changed(
 					struct btrfs_super_block *disk_super)
 {
@@ -712,10 +722,7 @@ static struct btrfs_fs_devices *find_fsid_changed(
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
 		/* Changed UUIDs */
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0 &&
+		if (memcmp_fsid_changed(fs_devices, disk_super->metadata_uuid) &&
 		    memcmp(fs_devices->fsid, disk_super->fsid,
 			   BTRFS_FSID_SIZE) != 0)
 			return fs_devices;
@@ -746,11 +753,10 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
 	 * fs_devices equal to the FSID of the disk.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    fs_devices->fsid_change)
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (memcmp_fsid_changed(fs_devices, disk_super->fsid))
 			return fs_devices;
 	}
 
-- 
2.39.2

