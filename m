Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504CF74B4A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjGGPxb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGGPxJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:53:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2052EFB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FiMLg007053
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=EuZZ9iJ8fnEqSWpbq8FuuZXci0LOStW+ZdK4r2F6cAU=;
 b=bGDEefqRUFDFiWNcSIRan68NfNb7dEj+LdTTx4YiBo6bNTsVLIMiS78Pd5qjP2vY+iJ2
 z8+Pf6y8ux7mZFtuxe6t8zttmjTe1nqQcVOiuxOHq+A3p0mtXgojgD+xAkXFd+dMJo3e
 ORsqiZjJqFNr+u1UQyIGd6PC/0ECQhIylR/fXWshCE8drkJx13pKzzEcr07S5t5+pDaU
 yifTAGCWUhDcuQ8e6bXEpFA73snwW+C9izYMil9OWwCQm+4aXjOuGGMI+v/hZ2vSV8V7
 GlmJHY0dMIGbXbJ37ZlNkac99/2KCxmWjkuVklNPsSZiJ/KuUdiIyJyVGQ4G2ItWG2Q4 jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpnm0g0q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367F4hwP010374
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8kfnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLlTatR3+2FY8N0lFLMCYIqvJv73ADkNJMZtX12jg+Iu/6VE09ck+NZqMLWC1qV9jG3eFBWyoQMlPwAhOWQte/YsYaN1vGg4HXYVTnTFAyyoxBDPyOiLEniCP2wdDd3Jgss7vsMAfvGaPpiP73SMA0c7w+xGSxd1Esi+TVNuh76ScdzQQc3lwN/DyKsvjaqMW2hYl2BYosE+zF3m1Ay4OjQIRBcRGQdW2qjaF45cX4cFLRl+I/B5X1UPgfBzIYjFeMxhMTP2qiXAp6CtRk13ctUZgoCGMyb+wPDVMeBymEWnxT+p7QWmKQqfdD3UNcyUwWACZBSjgKM1vM+oGp3GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuZZ9iJ8fnEqSWpbq8FuuZXci0LOStW+ZdK4r2F6cAU=;
 b=PvsMyyDM/43MF9Dj2WrNS9T39PMe+xFh9ZZCfNP6OOs948jVikzq/DAHgMbpHZdBSujbbFhqtqJy4bOUU+B6GGnxfhIwHviKReBOb3V2i4ZE6hczUx4zgvpMtkd4uWLWp/087vRx8EYcMdx3d/IU2bolU5WIKJ/TlfFg02/3pQ5RoT3BmUs8n10GBoAhK22b4Px5b2HvIGJPPAllq9lMcJ8jviFA42o6+UskpazTkCwi3u1TzAoWxUyIT+pLLiG01XG2I7CRUoSmqIRcpPHIaZYV8oDLky8tbFFC253n8kmsFSq18Jw0yZ14wE0jcsGP3uKbqwXCBYJuw3SXiO4+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuZZ9iJ8fnEqSWpbq8FuuZXci0LOStW+ZdK4r2F6cAU=;
 b=v8o2zZ6+ouybxYjmUjPGheY7tLwgLBEd1ou02zV4d5z3UgbDGjTH3VD0KYCE1LF1e8mJICeM2TeWZnJTe3NFj8hbp2opvKFp8cWylfXjTXh89VPZgzRVZmtF6mxmUO7YnpPb5L3l1QznWvA9F31k9ERksMZbgK49d46B82ZXH7Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:53:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:53:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs-progs: call warn() for missing device
Date:   Fri,  7 Jul 2023 23:52:32 +0800
Message-Id: <e4e0299f46b9b4715039cd74f90944d9357446af.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be56c15-1234-4b64-a977-08db7f024060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vveXZOkczywyt1hTCyVrB2BApOn3JF4s8Myk90fTI54XCBoGIOL8Zq1FYZCPg24y3Yg0qu0Jae27+EKaOD7JRUiRM2AQG1/LwDXt/yQOOWvCW0QiN7JDEFEou5/XIt8KCsvflbOW4+a2s3qZlTmvLrAZ7+uJoNO8ikwuZyPKU2NVya1HwG0dkTLA6wE3BrVbaSFwh42E51Jir69HxCO3oeuH5HtSrj79yNOeC838plUXiTR60ZmuNmzenfZ7oJZiiNFVrlQQV0Cbuj/c5ZPlr9kRW2BvJdpGkbO+l1nOub2SPfNy7VMmaXshyQcq8emk6xV0B1bpnBpfWV3kw3f2O9fezQ7yqWhPBtX9Vwy3ACyrxWUYvw79SGo/UjywEnVruHUtD+RY3IqWio156OF3PJfXGCuAhTESwUnbgMTfWRkVtvwSQil8TPzJ57wWw8v7FsiVhbfneLDAnDm8CsbfoPBl9lNCH6Ibr46aLqhtq0pIuIPPKOsL5+Y7j3BzsjThtH+9H0vdyw7CPHpRZKqIJ42qdlH3xoSWzLpxXPCzmcLD4NMwWHRMF49oC1Uep0sY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(44832011)(5660300002)(8676002)(66946007)(66476007)(6916009)(316002)(66556008)(2906002)(6666004)(6486002)(6512007)(41300700001)(8936002)(2616005)(26005)(6506007)(186003)(4744005)(83380400001)(478600001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NVBq4wvMi9jx18P5dkAIN//wunilLILqN0KvDtwGirmK/E2GDw3eu/+5RiB?=
 =?us-ascii?Q?ff+YmEHir/7+ePdPkfNqBMvD2Wzmjyova5DuRqGjl9ujqTzCzpHmQAtCXono?=
 =?us-ascii?Q?pXmZTyvwZ4ON3v7jjIXlCXNv0Gy50ZrglA6CbirQ4IFXxd8fw2Oh+eomRVqF?=
 =?us-ascii?Q?o+riuKf16jyAdgeLlcdB4CNLgQdlw9a8b9iGFJKwUJVDOWrVtknnexdkSeZh?=
 =?us-ascii?Q?Lb841HNog4BbKHGIE36+Y1h58XVt9VrTK99M6oNRt7gbAMNJN4XJQqRK23Np?=
 =?us-ascii?Q?O1kMyemGJerpyd6i+IcoZJqmJJFRD++BwdhSTZY92IS2pf8/+7MOd3nspLv4?=
 =?us-ascii?Q?O3zMGdIemB6rylVfn6YeKoTCTrnG6exSfaclqCRlun6o8qoEPsbn4skja9M2?=
 =?us-ascii?Q?mBPBTUlZCX3xl423jrVO8GdW4ycDKUCMUVLbRemn8LlbIuy5a4lzHzJb/CsG?=
 =?us-ascii?Q?80vGBlSoY9MLFyQyfZfRW0aUPC7r0U/TobCSHIVzeBUrMVlA3UnQoLYpQVyP?=
 =?us-ascii?Q?3/ihtMW8K5TQYLo109Z6mHAxrV+anZPP6LHXfdhHb497EEidNPjgEDLfzliT?=
 =?us-ascii?Q?q/+PqeSbjMi9XNipwwfhzbH9V4wiEFnB4FWEg3WgCpf9UTt0aufyJXkv6+3v?=
 =?us-ascii?Q?Zz74hWZawOUS0fGfosnaKXbK7E4w8mGZZGM/8lwJbKhiMRupwCdqsqvIsd/4?=
 =?us-ascii?Q?gsi1AAOMLwj3+JK4DZOE5LA9auo95zCRrIDuf5/0Wa2o4ATb45iyqcT0p7s5?=
 =?us-ascii?Q?G6rtey1Zilz8okBHaIKzdlLxE+HCFLeYfuWRGKcedB5FjJHqE+N0N75njXlN?=
 =?us-ascii?Q?4iy3EI8VmVSyfEwoVuDt4Xt+OVgblY7oKsrmu7mOnvY0tpV9xC+AAlE4wiG5?=
 =?us-ascii?Q?PFLt6Le6b3cK0e5Kjj+Jj+tYIDUxO1XmxeGv5hpc2gEJQzH9RHmHetYcj7wt?=
 =?us-ascii?Q?VarN9rvYwaJkzXKwDI7yqNu1JlpMWhlkMAbqYXeT+F0xJ9P7sUxV4peO6+10?=
 =?us-ascii?Q?/6Fkqm0nLfloCOjkvCNr0AMBES1lz9xhmM821artasAuxCALYz/otHAV3VGt?=
 =?us-ascii?Q?twyjdmx6EXpzp0Pmo7oFtjiyZS9JTXpbEwpZt1EMzZyybfeu+WM8B6MrLW0P?=
 =?us-ascii?Q?970+bN7F81nyB8d47EObJeVR9CMYIEScslzh3Eb+veDKIgbFuVrNhdSjlcOJ?=
 =?us-ascii?Q?AZkSx0+3/N1c+jJMJFkJuiU3p+jsHMTD0s/7IdF78KkQo2TsTGTm5JlJ3IjA?=
 =?us-ascii?Q?nGj7NxNDxrXnbq/H6LBabjON3um48Jrt7bOJja6mFRKML75gq6k1CeZ2i5jp?=
 =?us-ascii?Q?B70ju0LTgPnRdBhfhfPG0lceEsyrm/QIqnBBzAVqaTZaLxcsC8RuCzwoeHGC?=
 =?us-ascii?Q?M68ONpzayWUtOYLi6gt6ewEP8jjlCHjpsI5vLyEpeqBnNTRGjHPAaYhMUFOW?=
 =?us-ascii?Q?PHduQQuQjyj0vyqSEpca3fNIhEcih01yar242otpTKA2TTNneW5Tjae57Aag?=
 =?us-ascii?Q?XJ4L3jbrjUH9XKLLFr4H8LBvV3VeId9uKIYozO+S9wyHzxSpKUQHJGLAia/U?=
 =?us-ascii?Q?fIqId4lrQPMcpBhTYEZsPLhb19a0pQny0K7t7IfA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KmKOrQ9+1NcFXAKkkDmIrisAQaHYfxPjO5tKSMmINmY0o7OfZfd4gvIJ7R3ykm2qLBFs4MDgefQmts3kb+hAEcpLetvXktSMlOWbmrX2BR0mhLumQ4pryFG+87ua82/RKPiTetA560ETYu62pN7oQHL8DrFKxIrxG92fGTVxtc5Gg9x51CMwd3pXjfVKPFOBp7D4FwnbDEhS3e5yNpBZyJsIZm217/RJ7lznNUbF1l03dWPzCPUuONSpNLSbeCkHrFNRIy0zSJY3MGhOaFaOr79/bjgBtO+E+4VAgXAril4fdKCMOxAwMOYR5xryjYqXnm+3kF/xXN5ZNW/Pxv6K/9RWIdJR3Kxwh4tH+RjuboViTc9xy8CndeiuCNGrL35aVHTDtaOvqEn5UwZYb2AgoeJwNRTTDys53M1Ac30AIp64XRB/CL/G/24JZXCBTZEOBlKAPdULnpAP+X90oQFDfrAaab7yYkaTLKTCl3t+r46XNfMBUkQDW+oI161uUeOl8gcg1jGXeEa5P3xOF1HqL5fERz8CDZMec3C/ayiP8AKG2OP8ipDfD2E+WSsJKY/WlWEvji7LO/ojpq8FGZFCoOsFfxhP7cDh6+wEcP5HdY+NKI81xmw2hVoWmMzOFIv7kgJyH+9lNKE08Zt5sg0+59HQALdXQbIAgzjlcX5XvcP08sMTy6y1BabovU3v9xbC++8YoWrAK2DRCHezolVTyvbro7khB15UOxvzC7qSbIzfkFk690Ss9CXblv89yhlv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be56c15-1234-4b64-a977-08db7f024060
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:53:05.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wy080V2QRRScgm0z384oSiyVhbBxT4fOId6x74XWXL7fcim4HaGNqFIUVt4Ekytsud+AvRCrq30heOL1ScEUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070147
X-Proofpoint-GUID: haNzsOMKoRYQetLv_MIjlG1e-p7wYook
X-Proofpoint-ORIG-GUID: haNzsOMKoRYQetLv_MIjlG1e-p7wYook
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we add a struct btrfs_device for the missing device, announce a
warning indicating that a device is missing.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 92282524867d..d20cb3177a34 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2252,6 +2252,7 @@ static int read_one_dev(struct btrfs_fs_info *fs_info,
 
 	device = btrfs_find_device(fs_info, devid, dev_uuid, fs_uuid);
 	if (!device) {
+		warning("device id %llu is missing", devid);
 		device = kzalloc(sizeof(*device), GFP_NOFS);
 		if (!device)
 			return -ENOMEM;
-- 
2.39.3

