Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3587149DCE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 09:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiA0ItB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 03:49:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51556 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbiA0ItB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 03:49:01 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20R6upFN011847;
        Thu, 27 Jan 2022 08:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=rTZ0fngelISDwCameJVxTWjSJR9bIfgI1xcD6XeuXn8=;
 b=xnXLmXbKrUbFn9DxsqoZGUIpAoV+2IAnL6UZbUQzAIoJa08puohgva7ZMA1K6EBJyguN
 GxAxGhY1mFli1/0FiDqliF0EG3a1kw9Jsyh7Em3emu+XSR/l1vX5gB1VdglTOn6gCmT3
 BUeciG+VSZJBNxGmcMD3RfSsinw4Xu8o+Q6dxMhT/6QzlJu+hXS7X0hm0NpSSYL1RxdF
 6IIKy2hERMYN4NDTrzIRIgVL0rB7SfatShwGnvKxvmbfgDXpaLpJXLS/oqHqUqtRF56m
 41ygLSK06thanvmjeKvnbErSmmKThjV8dpVdPXNBNVlGXOqxkVnx1Iuo5FzPUFWTL+AF jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaaggda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 08:48:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20R8jOdR106279;
        Thu, 27 Jan 2022 08:48:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by aserp3030.oracle.com with ESMTP id 3dr7yk9ke7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 08:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA9qyhcg3zPqdWH5wpLeCyeJZ7oxME1o1A2+Awo3sUp6q3rWIALGKAnkKMMDzLhaOWeedjIyJL64sD1dAEizscIZ3fh1A9rFfXa6cF/VacCZ7AdCdIjteBIARx/NB4gYK2VKYVwKgspEzgbOrhPf3JUky0OMi9J8EoHoLdbciv/pfCYMar7jiVHs3uPCsbpMtAQmRywrQxlq0nw0gC36PmyNLEwyKiQzDAUO0F/d6OKtiTPdg13HiVWqy4uy5Z1sKdo4FWLdxP6iGL4D4WJBx5eTm5xkzs3sfrfVVc2ZmCeCTJUJQm0XCPXWTDBEL8SG5D1ivptUMZZ3nzcir8QXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTZ0fngelISDwCameJVxTWjSJR9bIfgI1xcD6XeuXn8=;
 b=Cuesg694cXKUjGv91BP7EKrvxZcseknksTQnVilYKGhzw3iEle4EfhvD50ctiYmHwbOcvQ+NgiKzFatubLfCQy2dojdJdZAENbPZjJMuFQRPGHYspZA4Ye21/R6BRQqghUv+sIWfRRzWBDT4TLv4HoHiLoFRPZ2Z+BT3OE39QYz4IIHR68y4LqQsqgz0HYQqk46m6+NA9pNmTu0ppLfIxbSIpQfng72ar7yCqK76/cUupHJecuMH16LT6eGwG+fxclokASP6ehxGPy7ewrJQW5rNMW7AYE/POmerB/pp1qSgeGOeA6enfHV1TtoN/PPp4zRQ1/9cl69RcT99k/EACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTZ0fngelISDwCameJVxTWjSJR9bIfgI1xcD6XeuXn8=;
 b=ZzqLsfuJIgPFelxhMRE+aIDe+e9ro88a5V1FDd/9oT7uP3+GC4KStJkyPIij5HfDIHbdW6bfk4Ye9vZ8o/c/28JZzXsCk/+hF59u1gjyF97nU65evx0AK3MWjiODmau1bBA4Yw69iFBNmG6tmHVOKduPj7RQKAxxtwjISkbTEtE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3889.namprd10.prod.outlook.com
 (2603:10b6:a03:1b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 08:48:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 08:48:53 +0000
Date:   Thu, 27 Jan 2022 11:48:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: fix an IS_ERR() vs NULL bug
Message-ID: <20220127084834.GB25644@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55496875-8f02-4c84-ce4e-08d9e171d881
X-MS-TrafficTypeDiagnostic: BY5PR10MB3889:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3889244DFAE69A28571FFB258E219@BY5PR10MB3889.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FV0T9gXq1/YWNWeybCBm09nFQ2q50FWR7hBYtgfdBWQWwrSX8830WqqnFWB9E5aOGwoxkr7qCsispa8R9/kb75ibTKujjS0V8IWIOkm8T3Pklb+HrCw8RLLlI1jhsd1sJnYP82xhgBdKqO2ZapSqKDKWV3k1MNxhRs6f7iAuvWZNsNP4RtjS0745wW2BV5s7KVue2zZxRt45TaGPOtSiH05mhpDcnFyhN7AMnQD0hWnsHdwRpuw9uffkxM8TfA8oVm3BnkYI8I7W9zpttcswamKc59zNr89ssjN0O4SvQ3ZAUU8pY6d6W9cqQ9foMUjZ8LhUTJg3VF+x8sdk0sMHjIn1jGDflgcoholYtIMmOhbJOLRaTtZbcmo7ddCtDjOF1IwSxY1XYcRS1v2wi2ugWoQW5W0FxSeR9slOiWa3HJ4CTm5IVxCim423Aa1W5MWa3tUDfVfw6zOraOFw/bkc4at77E0pWYuVcm5noo9G7dCJp9+t410kwyjy6IlmuTW2nbWhDSSOa4pVwwD2QQymRPW8EX69iIipzyIWROTirBZsIixPsJBwbKoepeHkkiz7/wCQoxD3tOqGTbSmFFLPlEvgKE72v8RtgcGfFKaPZQh7VLZTm8XjqUJFL6RJLX+8xOFCy3tgN6psQRsEchThMptSsixFLFLfbwWMeD+en9Tm5KGMGq4aGxV8ZEa+vBjeZBjl67fchhGH3wOH2uMN4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4326008)(6666004)(38350700002)(8676002)(52116002)(44832011)(508600001)(6486002)(5660300002)(66946007)(38100700002)(186003)(33716001)(2906002)(316002)(6506007)(33656002)(4744005)(8936002)(86362001)(110136005)(1076003)(6512007)(66476007)(54906003)(9686003)(66556008)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cAM58/rIMhxb2vGINfbsHCx6WMzZfrqvYLPn2JWAilvKUD3UuSQ4oWEF5Fmu?=
 =?us-ascii?Q?lDIaAvQHXHKZZ8ps3WeDjGlUjw/GPqqs0i7l3d7kEOygfiqa70IU2vZuQhDN?=
 =?us-ascii?Q?8U06q3M06ZCz31UIauCqVXA2usxKRT84Itl68FJQZrDdRl12urO4Z+16+MQW?=
 =?us-ascii?Q?h5HHwdKBrFT2TVXLuoGpT3yvJ6trPdfImjuOg0mBmm/HOy66xzJShDp5Coy5?=
 =?us-ascii?Q?+hK+L4qRgmTCtecbRj0UdCvRnzGO/sp5OhnxSZ5CE9stDSaF37dYr/OzpdQ4?=
 =?us-ascii?Q?L0XK/W6l51W9ZoVNh+KbxmIod1+QXBh1sA1vuuimzB50j4kpeEaDPiX2DBOS?=
 =?us-ascii?Q?FBX/weeDCz9R7nYoijFiloDjzEReNCCNHmykbF5frckme/tQX+Ffz4nf6Sa7?=
 =?us-ascii?Q?I63gVWPsIT/9OpMYh+cJco+uuPBIcrCo/SilySNQJjVKo7wmNIGC2S5nrM1u?=
 =?us-ascii?Q?PKIO5z6Kvr5tPZOD0+3MtCKkjZPvKK0FO4xOCcsxGS8oOalTH0PtCv6Qo63K?=
 =?us-ascii?Q?Ez6XUxQvnzHUwvWnoitnYWSDHOahroJtKvH/wcA7I6xXSuS0CQEbsw3U7ltm?=
 =?us-ascii?Q?rFMBn/RPq/kc7URkF+34putrR9CJOTglv3HqcFsFFIaY1uwOJ1MMUB+0vGBx?=
 =?us-ascii?Q?QbRvh3FhaNTbYzX73qyJjQH4bavAnJRgKU2FmLPFC89WmJ1YwmCvutkXPnSe?=
 =?us-ascii?Q?T4DkJz8j/DA4iSm++o2jcSh9t2vUzSgGoZbDz05vw4fWvAQfl4DDYxt6oJZO?=
 =?us-ascii?Q?YpIv70ourWzkN6MHEOB6dANTLmbSIAXvKUhK2Fl2WPpzVqKeYliInDmUyfVN?=
 =?us-ascii?Q?0XxQvgLDyFtT6s2SYCWsaDE0URLHZkrmLzWfJH4IaZ+nRvjtNwWnUj2G3YXQ?=
 =?us-ascii?Q?2if56Ii/FYdjkKCyLwNvYhmZFAZ84jhLFTVKvj/HCQbeS3sepreQn+cyUYSF?=
 =?us-ascii?Q?3UM44BUE12VNn77KzZXTDBbrON7HZmvUFz+njA+MBwo1/WKv8ljXtutXABrO?=
 =?us-ascii?Q?1fa9wr6l5DOtPPmEzurK63fTcjUn1Z5cRA2klZ56mc4FkgKGLfB6z/wHdx8d?=
 =?us-ascii?Q?jMwRb/ac7k4Ing8vCWxX8P76mtv39voy7H3zRA7ihdIoezFSOpGFijR14Hnp?=
 =?us-ascii?Q?hdgzZnYG4OECfGqr53mLhmPKb2Ej/2fpUyqmHmbIgSkjysOYFuIznfzZiwq+?=
 =?us-ascii?Q?cj7r8XGMmIRLT0SjFtcv9oheB7XsAmPbqyd12kmfld8jLEM4EMzY8IoFFoj9?=
 =?us-ascii?Q?M1AnMzNYG8mnxJIrVLLOJ2Nd3Faw27SKdowp2R7eQGh43q57MiEKBFSF7HnE?=
 =?us-ascii?Q?UuTBB9xkNoDyWywsTFB008gGCz2RlcjtN/T09HxrZ4zocEZGYctudhzdTy9p?=
 =?us-ascii?Q?4VzEjrttKUUkjTW/CwJsXFhCJXcCHmZxPWDCvoK+7UMp0P3B7diVkONsoYYf?=
 =?us-ascii?Q?FwjlKD2RaEccrl78zr14rUcAhwheOGnAl4slocxNxN6YJZIcg2EbDiiGERmp?=
 =?us-ascii?Q?IWWBXwlA8Aj7vVm2VXA5Gaxq4KmOlnQg/p/09epBx3KEv5RKR4zseceGm/dz?=
 =?us-ascii?Q?CItNCh0rt8Lhj5RRTS4RNlq9cBnI4YOO9l0KjOCs9FtFZT6fXwuB8y98HcP4?=
 =?us-ascii?Q?wieilpxB5ZeNPuDa085tE/pYUrjLulq0JZN06u3sYCit899ALlyWt7RhyVuF?=
 =?us-ascii?Q?+xKRAuY61UzXfu6bao3uy9/MvSI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55496875-8f02-4c84-ce4e-08d9e171d881
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 08:48:53.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/xPRVOSA6VRBDPdF8/g1Wy5LZ45cuaqUXzKNunjq8SQuOAPTw08Gx/1Lj3wnFXdgqFUV1sHAL11SLjPh/mzpvPa26PypZFZqNbP3+tOf4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3889
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270051
X-Proofpoint-GUID: 9k0tqPJVz0cXrr3XQn0BZ7gr3xvva5UB
X-Proofpoint-ORIG-GUID: 9k0tqPJVz0cXrr3XQn0BZ7gr3xvva5UB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The alloc_dummy_extent_buffer() function does not return error pointers,
it returns NULL on failure.

Fixes: 5068210cf625 ("btrfs: use dummy extent buffer for super block sys chunk array read")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 98ad92041ae4..791dd31360f9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7389,8 +7389,8 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	 * that's fine, we will not go beyond system chunk array anyway.
 	 */
 	sb = alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET);
-	if (IS_ERR(sb))
-		return PTR_ERR(sb);
+	if (!sb)
+		return -ENOMEM;
 	set_extent_buffer_uptodate(sb);
 
 	write_extent_buffer(sb, super_copy, 0, BTRFS_SUPER_INFO_SIZE);
-- 
2.20.1

