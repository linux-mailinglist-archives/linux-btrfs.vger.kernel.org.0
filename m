Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA473F7D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjF0Ixl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF0Ixk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 04:53:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F708A4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 01:53:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8E0p4004331
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=sfHNJdUlhL/8kA7zdL/OEaOERDdH5e2QILIxLoyBKn8=;
 b=JaB+lk1EmUA9FRCoM2/MkAFRU3Min4aTrziaIwutlIsi4fwJ7e7j+9K5dkzSC9/NxTTK
 fk3UfHZppoxOl6pCTWV4vxKAlNve/ItYrzV9ZVsz+FnrWIfAW4adIyHRCtPC5LNqCIzV
 VwXk1zQVbe52x/I9+/4LvDS+9jSNbb6nN3HyNv3dAnzlK8jRa8+mAUpYNdTQ7xTJwKGx
 fcRIccQbBJaSrqN0a7ukf6YHcKq3iOhFlEHe8D6uees49S53fw3NHY3QP9Q92Tkb1rPx
 DwG0cMlBXcWLx3OvmAFxoD2se+yu/x3GL63ICJMArZ51OlaVa3DYhs9XSCFfuKwOzqxS 4w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq934fwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8fJTL028344
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx4792g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIQ3OUC5bt3S/XhqxW37pP007yqQu4lcGoanLvtCMZiufVuHimrOIpP/Ik2f4e967XcajIAdhfAH48jmfpfNh8q7ihIoYvw8oBQRm+jzqX4el64/o097Xe7ZqRSwa2CgdISZcpApWnN8xmdievOvOH38RizKISJ8OiKcjhjlbSinqV4y4cI7el0E5ICma/lojGjfaMCfDdvGNTMA/CTCJuM/D/wC5/HFCZ57obbv6d1uAbG1bFmCRHBWLZIsI+SZKx9JMuS+OLnnPL/z1NXaqQZU/ipQAgxvem1I/qjyYugXyK7OlfPk8BmZEMpj/jjzvQUgVuDz+BV+dADrighquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfHNJdUlhL/8kA7zdL/OEaOERDdH5e2QILIxLoyBKn8=;
 b=fYBH9mRpBR6ihO2Py+1uWDPZH8arNyGXvZ73/i80btb1dLPIdgEojncLQGLg1RAGTYTzY7TVkNEp62P6pAmiZF9N71pakKLfquKCzE3wkfqgH2D7DYzUj391+pCxwGnkbb0SZjbQp5YBMQRUl4fi4IctLjq3YdNx+hffblJFklNOaToZ/ra0hpFbzKXFPG09Kt/gYaOIF0OjmLCkAe0+k/f5gXzkHWCbOKYnK95HvpoZNt2jwfeMfuTOtpQW9oLNQOZjgjsKHRo77wWx7eK7FX5Q4gsecS9dZKiRWAMJeFoE0yR5ev9uPMls7aCUDM+e56JbNFYUFTDagYf3DzC0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfHNJdUlhL/8kA7zdL/OEaOERDdH5e2QILIxLoyBKn8=;
 b=PiT84PZhwEwjZVHnpzVK8wb2HHbidaDNQhF16PiX6gIg5+M+MYqeu17Rvo7W1p3hbSQbvEuX+QtdrPnJJ1+RU/dotHYsZI/sQD7mZiDWeUUCFYcnMktDN0K6I4v0ryXfCXO/KGYA6WQIsbvG25PNuTWjOp0CkxIIKXX5+KKbkI8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 08:53:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 08:53:35 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: dump-super: improve error log
Date:   Tue, 27 Jun 2023 16:53:13 +0800
Message-Id: <d9fb113f645e6c882041aea91a356ec3a36c2240.1687854248.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687854248.git.anand.jain@oracle.com>
References: <cover.1687854248.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a691b01-8b73-4b01-214f-08db76ebfdfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWG1ZZ/uQ/V9ISNF1bBTp9cFQtA4EMVAZ0g4r3dgoCjkqPSs0d72R9TGrmB6T2PN9KjMmyZAMlzqBr6aA1DtpTiIKXNM1LInrSd7oWrkQbVPBeBw1/IJ4KrBEwcY5Bu0kbr7wOclhQCs3qiilKo2hP9DIiUA86X0x12TyOhNxR/8Yu9NKubNd5JrOcyDikY4HSfR5Iz/kO3x4LWXcScT6ivGWs5jS+63harRLwx3uZo67SORnNOTY0ZWGpsgwyOI8AN0ttWPj1ZtFQzoYYgVsOuTdsdjkD+Yj/sz1LvjPk3SQkojloXhA5UCQCx7McImuxkznCTpsf7SodG0RikFPd83CIGqIdAONtJF0y4X0MuTZU4Gl+GGK2SDorqVYlCLPcXTnZdkpDZ6t2nbZeERc93vOksSy5jmUesFlzqP/0YOIidv1/D6Ew3CN6ZSNm7KYOGJyU1s2N2J8z8NcHy00/lRIm4oxu8U1GzQe+6RvGFHvoTliITNP+5pMFn26s/YJd3UOZbR2b5fYQ08fYyBHm+l+ZRx7BFUH86mVVgrvRosKLEKsCeA65VcEAJgWOPp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(4744005)(6486002)(38100700002)(26005)(83380400001)(2616005)(6666004)(186003)(6506007)(6512007)(41300700001)(2906002)(86362001)(478600001)(316002)(66946007)(66476007)(6916009)(66556008)(44832011)(8936002)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WGMD8rwtmJdHLPHOVigBSiII/AVrL2gjVHauG48cHAI9ezC1gaXWXs+bPjpi?=
 =?us-ascii?Q?0sUJNhrY+2NokIBPCDJ26+kEzbX6v7vsd7c9GN9y7Fy93VVAoM2cKzd4mJa4?=
 =?us-ascii?Q?HuxmI+jgtMOVsWXeQMLC8ZbkXRcKCdfZ1EqDPjRruFZWmVWq2NuwsP4RCW0a?=
 =?us-ascii?Q?+y1qoKL0adzfheNaZQvUruUt/okI42tWotTYNF76Q9UwZ0oXBr+L6HL+N52u?=
 =?us-ascii?Q?XyGACXC5nKkhk4RnDi4inI0fthFMH0JV4AgN4PyqTQGqyWgf+3hTUhPpWwrl?=
 =?us-ascii?Q?4dXEpSdqQbH2cLnfy2fsZeJrEPoKgigg0iVcO7AqnbD+uYmDFl9E2tzx+Wx1?=
 =?us-ascii?Q?U/0dCz8O+O416As+/7ak3LmrtMXmNXgDHxoJecOxrJNQXZq7Ed24cCynTOqz?=
 =?us-ascii?Q?ZSp/hNXLT8Z5xLfO84b2VnagXkuA5nXVAxBVzpaLCDsrAw3VI9WO5HN1jl12?=
 =?us-ascii?Q?Ok2gxXh1C46UYBvOilcoL9HHcjq5UgIQgKqK1wRF6n5odyW9Tn3x4S6CiMOG?=
 =?us-ascii?Q?8l/95psooHYGKQxN2X9DfRmq6MANxELRQxEPmKcPoiNdcBzR4r+Vo8gUdM0n?=
 =?us-ascii?Q?Yw10sOgL4Ibdu+me0MvE7sImiE/xZnFNg+m8V+9nVSJBvD+7XeFLx6pzH9it?=
 =?us-ascii?Q?EulN0DWVJ66EuM8Zj8uzLtySzzZp2pjfZX6lGlQzD3CSIgytv6C58wuAuyo0?=
 =?us-ascii?Q?+9IShg09ECbT7jYNaQrBVd6DYOBkBHd0JGyNYo7ePtAaY9WYnmoamqTkoD8p?=
 =?us-ascii?Q?fxTrjo/9BFiIIIMfz/nENhXLwlHgyAb+o+JWI1h8s+AEYQH6Yk1XbdIBF6PK?=
 =?us-ascii?Q?bdy23jAvkYuLKt+wUkwjqsoRwOMCasXj4srsOU0I0ZalZ24CWGUy62pzSd4v?=
 =?us-ascii?Q?Iy7iYWJtAHwP5fe28BksNLM3V9TT/pwq0qWJlWN9q3e5+XeYVmqAK5el4S2q?=
 =?us-ascii?Q?+VAHnysFqTdOP2i/vYgAL8RBBcWNF5B8Ykt1p2Es4TOiJlOmCRD90L0Xdax4?=
 =?us-ascii?Q?5ClRoeb3ZJhXYXD9Ft9gUqGEbPC3NaOu7tsunW2mwljDzQZqx2Dj7nZjjZXO?=
 =?us-ascii?Q?1KZwkenAQqtiBE2+BQPiA3KlQP/D41vzPL2Yf7Zum6il0ppgWA1khoo2oJZr?=
 =?us-ascii?Q?mSWkWCe6gq97U7lh93chuT1qOkx/btTTV1WPIVmMkXWIkG92tbO/iVglr8Wq?=
 =?us-ascii?Q?2LIfP/+O23J87KPajwf6z4j6hNllquT/U6NouG7cxLgGSK0k5g+lOKdDEdQD?=
 =?us-ascii?Q?3P9B82doreXR32Yeo6blXAZoqxqMI4n5EYkapM4cRNrhKp//CLZaTTf+bfhR?=
 =?us-ascii?Q?Fmp5ar4FpvmGPXAnTuS5VdJd36jCtxDETHjqvi2mymHq2VRb6U6zcpmIfJAu?=
 =?us-ascii?Q?0WVFRDHb4FDz0L4nFjJF6ZXF23xQO62QZOKMtDcds+nxK7rfp4uimROyvaTm?=
 =?us-ascii?Q?e+GW2Md6Zto8fYefuEyJzoDv1MTMb+uLhJnmAJEiGRQS5chS3ClK+HSnEWqU?=
 =?us-ascii?Q?wkK+bSF+0ZfCIBKGeDshzDoyNRgMK8ta2lrRP8OTFCd+fz1COUpm8yepI9jb?=
 =?us-ascii?Q?R50OewwLFsJZNXD9sDpdg8havGIoBIJ3nY8Dx22g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C4uuDv5Fj+rBt2s4E/SelP18HPdxQ6dhmywv8vCOFYcUgKOFML0v8C2KPJbN7WF3b/SEgehnoXuXR6On/OHixiMYJWtWYb8z7ilz1sl/dbZugkY4VpdCvtZaSy77hxJ5/7G+y5xYw2S1pPv2IpbARkbRdEh0HswH5hpBgqDM6hJcYXX8XpccF9+jZQjQSXPjnE+HT8ym/sklz1UCPdohVEJcAyy0/Pp5e0spn2FIegh4A9q5M2jdl9MW3vfHIeVNiklB+uIHkGZRuu9Kp79MvODD3KwMDEnWBIpioHVYWaYmFq8bs6F9kEehl2Ic6EWBKXPuf85gHg3OXi7/82RyLgjORIFj4mHmLNE+TP1AVG+fmtnt6YMSgcA8SdgJMDpdz5oaNF+37yVzFlxkHwpXPwmtQvsrmkg30+leV9ZIkSbginMzASA8bX7Y1C3a2QqRaDBGnS1aQPBmYJp/WjSAQcUutPGAicLeOF2LpexqLt5FtYAIBu7rFO3pr7KtoaZMCYPZDlDkSxVl91JO1FLAuW14rtTfIAlf/te6Fd8UvvfWnx7SEyQ2FIhehOlNX2CJoB3dAM99mIyetziQMNdIDbEWZPVMQWhmtPkRrGf2tWKmcgEbNdrMFOrYryLhT0SnnWgyuoirRhWSdy87VbBBZMyqkj5WAMmMoQ6MJUxGruIqVPMeSRZWT3P94089a562w43uEHDItxll57rJ5ttT/BhNkDTAnRObh61z9n0dz9JGYMs5MVZFljWbKCxfnXfdsD7Sp1gz3WcGxc7EQqYDKg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a691b01-8b73-4b01-214f-08db76ebfdfa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:53:35.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMR77TFuaqWvOpwtmHSk3dvy/X+WLBO5oTIuuDxJriqplQe50YNcFYzdu7d5rZf/BRg/5dyycKvT9+xtkRNqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=942 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270084
X-Proofpoint-ORIG-GUID: nXBx9d2LmKFoUiz1ZKOb2va3GHiuv_dR
X-Proofpoint-GUID: nXBx9d2LmKFoUiz1ZKOb2va3GHiuv_dR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add more error info to help debug.

  $ ./btrfs inspect-internal dump-super -Ffa /dev/vdb10

  Before:
  ERROR: failed to read the superblock on /dev/vdb10 at 274877906944

  After:
  ERROR: failed to read the superblock on /dev/vdb10 at 274877906944
  read 0/4096 bytes

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect-dump-super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index d62c3a85d9ca..4529b2308d7e 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -41,7 +41,8 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		if (ret == 0 && errno == 0)
 			return 0;
 
-		error("failed to read the superblock on %s at %llu", filename, sb_bytenr);
+		error("Failed to read the superblock on %s at %llu read %llu/%d bytes",
+		       filename, sb_bytenr, ret, BTRFS_SUPER_INFO_SIZE);
 		error("error = '%m', errno = %d", errno);
 		return 1;
 	}
-- 
2.39.3

