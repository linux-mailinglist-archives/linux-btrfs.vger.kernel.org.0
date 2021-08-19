Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43533F1FCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhHSSTs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 14:19:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10138 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234479AbhHSSTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 14:19:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JIFt5c028661;
        Thu, 19 Aug 2021 18:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=oojgHrxQlOEHaBpA/i41z2Zx80C8hBkRB+t9GyVrGvk=;
 b=E5TSPME7tpvoRaMMrt2JASgt8ngDy06hYEWjT6pM5+Skl5g0bLLSqW25TKQlHxUqWYGb
 817bTjPhRX0uVeeoM5owCGjLaTttF8sVPB2MLSvyRBU2pr6kK2pUHjGdp8TdmlUQye99
 7QpqyKD7V6/CAPNiFWMPakknPEDThtx/+dJXsmyIKwlROCqnxa4aC+vlLCRMhDMVgWMy
 V1SuCT+rXC0euyYcV2EZs2qvZECiNq3DhDzD5MpAIjAGfsdOTZXNqep7tvdWCHLlB6dy
 h6o/YceTjCVyRGvQz7e5jL4yeMqE1qN/EgNMdPVAil9kN9V8jLbO6zvWeBIevjcbLJ4N jg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=oojgHrxQlOEHaBpA/i41z2Zx80C8hBkRB+t9GyVrGvk=;
 b=ihdK6hGrbmNhyVXjEpgfZikd2D+XcyakeHPNJHKKXcSEACA2if5ZkAlsfOgKoWoGHMTU
 qtGJCmN1mBJ58ard2fSK4XWYbm1tnjIlAXhf/CV5EnQwfIZhOriIaqlHZAQz/Ynyn1Gd
 2XjWrv8Ms801Nk1CUcAamzc2cMPyuYkyRKEShV73VV+xVtEIygtqidrxJyFLN42xXIpE
 ISsEZApCaeNY2k7V34B+dgtTd8pqKAuJcuXeXzxRYYt7cn9qepL7Wyz50LoCw9AZ2Xtz
 MPifK+sBPgj9akUMN4+MxsZsYUSh49Qe59LpInVpe+EdRk2sWXzclkZOEGOF0oNQdSjI ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmm1tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:18:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JIF4sx003802;
        Thu, 19 Aug 2021 18:18:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3030.oracle.com with ESMTP id 3ae3vm0d12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCixugZ5Wd/WdQeSjnedIcYn+fltVZdxO4lBhseykzp3GDYIPeZ3nFV7JQiGj2AlVO+wdBscRRPTy+WNjY0g7+CUdJxPuqFvkrZVouUJEVs/YeIKGwkFsVIguAMxWjXoEA083CsBq/TWsCNBDfedqKtHFNqrXN1GXFAITNKGW7EWk8s0CLEVp/IP2iREL5zs5F82muLOzF3E+frcfaGe9e/wTY/lHGOt1ePrFjPaJgXy7hoX2BvqbgSD2D0UishS/N802+RuuxuZasotQnnMcEqsH1UJ0S4llZMpdXUdN9eYg/3Q1s+wyHG2Ew/H869PDyk8pjhocZza2oHsH6Y69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oojgHrxQlOEHaBpA/i41z2Zx80C8hBkRB+t9GyVrGvk=;
 b=Ky7S0okoZiW2JbLHtbeFxytx4jEvmNeUmsq8GqO2/MxlQoIQkT7nvWliazGNhSRF2XhM3JOYlzIzARerMZA2PZqSS7w0sQiCDyMwOhfG213jUfVVm4UJGoQrv+ehOkdT2CuDHAWHzLqCJ19j2o23gzhLz6TbDe0V0+Klyl011PeUd7kaq6j0E12LvGJkI2DUY5HbxS98G+Om6wDtDjso6xRU3Xly0cCSooY50xp1/COv4wbPPyjBp0hVuxmm2klhUdMGGWze/xaYdQjKGozEIFog2nsc9zTHOeKCIBmGcMK1E8J36+Ovg/w+3Dt0vs5rLnDgx0QoDpiVNvNLgCNRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oojgHrxQlOEHaBpA/i41z2Zx80C8hBkRB+t9GyVrGvk=;
 b=rfELy1waQe5/Og3G3Zw9ZHp02s4N9TPzmbKgHYxacVwM41g3e7sBqmkdWohu7bNvKadUAmBWpk47dlW895KD/wIFfrhpFPtjQaoNdaA3GWBthmlZf8YXNP2MfeVvnIi8YYmKHvVxI5I6FefEE2rJgU/OWuZ5BrnendvbzHFh7+c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3966.namprd10.prod.outlook.com (2603:10b6:208:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 18:18:52 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 18:18:52 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH 1/3] btrfs: fix comment about the btrfs_show_devname
Date:   Fri, 20 Aug 2021 02:18:12 +0800
Message-Id: <26445e25588c8216cd5b7dcc453bf42dd4707739.1629396187.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629396187.git.anand.jain@oracle.com>
References: <cover.1629396187.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (203.116.164.13) by SG2PR01CA0114.apcprd01.prod.exchangelabs.com (2603:1096:4:40::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:18:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb0e5e38-841c-4702-d4ca-08d9633dcbf4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3966:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39669056CB78C16331F8BEC0E5C09@MN2PR10MB3966.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+CFsS10XkbXJh9uOK7ebJur6IaYDEsFVpPYYB6s2oEHI9AxN4cvJIzgzal3j6GKly+AlYpvLiiW0YPFtCFFsUpculW/z/MulGZusG69yBOh4jn3ysI9Q6GJTX5FMWjGWiIc9YjeqEfCCoOY3h4+39IloYhY3LsYkacEb5MMKpapX4TxTb6bJetdk40npowtgiiwT2low4sklPhD1jA2d8SSCEB4PzDaYs/m1Cjtc4Mo/OhDC3DMmv6Y1w9SSk4bhKwdrKXeVoCrCt5ypi6MJ7cXxx6e8gTlGT4w5ukb4IrbUaoa8k5LJpEvxqlk/GkxFak4DG33mtzfEKi0WpuLnPnZnUX+i+xPKUK3QOXb/ft2cMUQBmVuPGnLJIpE/XOcuu0qfxGEHwlXdCZ4KJjz4xv6ub1pz4Hg594mcMlS2VNy0i4Hd12KsCNBn41cjDPWjGrxKmjKFa5joLShuviCLKCjYbFs4n4YWsaCfzaUM3SjSRZIhlcBMOx+U6PRsg+u+0GqLMIIRGH2TPQQ3dPo/ggc3mr/tVqNkUfnjK34CcszvvjxISXjVnO15UIDSdkSbaZxBsD6YPLL/JEKDMCAZjDF+hFRZm2KVRlNQYT9WVrKxKVKMxuGko7EU24uED1KfqN8h3mM5HC00KPvvuIfIZXVMhpXmoGKCg+i0eQJH8UAjn/H0UQ5CKg0Z9qn62G4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(38100700002)(316002)(86362001)(38350700002)(83380400001)(6666004)(66476007)(6512007)(4326008)(186003)(2906002)(44832011)(66946007)(66556008)(478600001)(6916009)(52116002)(8676002)(2616005)(36756003)(6486002)(5660300002)(956004)(26005)(8936002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8UlHBj+7404IDci8YXlwHwMlIbNY6mshwmcbgJObdCMg0EXQvxlhGWaIDE+?=
 =?us-ascii?Q?2v2+N9+z3Czgp5yT9zCZSP5tLlONjS4R9bnscsywTEO+yhVLO522uW+3xMtL?=
 =?us-ascii?Q?ULkrzpmFvqZepy2//lFWzbc1ufHyu1KOz56yFGuOFfTQEOrQcuG7Uj5IUc9C?=
 =?us-ascii?Q?IfGquN/RFdkOEixxQbod3Kn5gu9syMytBEydvZyBFGdhcel07/tnEQSJlHt/?=
 =?us-ascii?Q?QcIjmjxN2isrFw80VWVp3Z2O1znXm6oegOb+nB5POXT9VIJSoJi+KScSQw+Y?=
 =?us-ascii?Q?Vz38VTkepvZfHx7HdJt6CHgCe3a5iAIbQ0VWkl9BD5IWmzpJX/FS8r6DZcO9?=
 =?us-ascii?Q?pzjq8BaeN8puXnoxofGEtSIHgczZFPhRPP5miIp9EkEzNCVKJuzP2tzcSb0s?=
 =?us-ascii?Q?Yj5Gwxy7W5mdxHEDMK8CEjy96s7hQTKSQNzGZm+jvObhVsP3PqxDGWlLczi0?=
 =?us-ascii?Q?fsFBWo6cPB7/I7H8zTHsz8cR13UOnXxX4SiWr5C6uA3rrl6x3Pq7Uma5MoHI?=
 =?us-ascii?Q?x9McF1g+L/G5urhAxmPczBj878eluO9dx3ofyg5s4K7ctTBHSUN7w9SWR9Sw?=
 =?us-ascii?Q?KZ7IjSSOk+YTrDgX0Egmd70laGipDRRJwyx6QpLlBmGjY0Gmo9fvP5A2NZC6?=
 =?us-ascii?Q?84ynDcrOsj/auL9Y1/tV6dWYC6TM75droVD0UzlD97g6y1wnDJaRSdVV5B79?=
 =?us-ascii?Q?hrFa6FgaSe4CRNkjhBUx+t2AFihDW1qrYSrxT85P+TCPiSiPsalSlPIMEWcE?=
 =?us-ascii?Q?z6SI5wgWsrTb9OoQGHzy9ik1Zos6eJS1RDHu0wdKNB7RU7pOIVeKEIPOczuK?=
 =?us-ascii?Q?EsrbkqmSWla+5eWrR2psmGK/iVbnHFw10As4/nivF3SY9y2bgSX8DxZX46R4?=
 =?us-ascii?Q?F6jBTfwCCFUEM1FyNKxmfoT1D0kKojgLgutVmfbjS4tf+zLfFh3gUaTwOzA8?=
 =?us-ascii?Q?7QL2W7LqtvNKgYlVUE9AUoK21/7tEfZ8cgw7h7Kc8GQwHwOVnyAn0vCMglBx?=
 =?us-ascii?Q?BVxps3YdOHzMfsjtu2h+PHJ3npZB8xaj4hoSMGvw+2pRnXMPpJs61UM4L9xF?=
 =?us-ascii?Q?kU05ebjHyqaIlk59n3xQpyRlGtsfnHRm6ANSvjCO0zDUNWRYLwJDywKQok7u?=
 =?us-ascii?Q?XMxmShf48GRGr4ZQiikfMAeeNfkYOOHBffTN7Y43fvvPAUFQD13RZg/CznXz?=
 =?us-ascii?Q?zqPyE9lvfzEkp2DJcDpViC0v2M15c41VvIXjj7iV8L/ca9A1x7nGoE1vQ5aK?=
 =?us-ascii?Q?IK24fx4WqVRNtN5wLUwcEANh0H0BoCSWBTe33bFL8wrekFBnCtS9gq7UL+bj?=
 =?us-ascii?Q?u7WevXjn73TrkUZQTI4e6bvb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0e5e38-841c-4702-d4ca-08d9633dcbf4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:18:51.9653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvhwsUTMd4ybGKl6VGcqVpMOxq5Ay2j6oNjDbiIY8Vq1Dsw0B3jWcqDg7uVPW7rb35XQ4/dzI3qLz/TDc0mqVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3966
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190107
X-Proofpoint-ORIG-GUID: zdLQPQLXgxq7aTQIYahoysmwU_upo8ge
X-Proofpoint-GUID: zdLQPQLXgxq7aTQIYahoysmwU_upo8ge
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There were few lock dep warnings because btrfs_show_devname() was using
device_list_mutex as recorded in the commits
  ccd05285e7f (btrfs: fix a possible umount deadlock)
  779bf3fefa8 (btrfs: fix lock dep warning, move scratch dev out of
  device_list_mutex and uuid_mutex)

And finally, commit 88c14590cdd6 (btrfs: use RCU in btrfs_show_devname
for device list traversal) removed the device_list_mutex from
btrfs_show_devname for performance reasons.

This patch fixes a stale comment about the function btrfs_show_devname.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9cb4ed90888d..91b8422b3f67 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2278,10 +2278,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 
 	/*
 	 * The update_dev_time() with in btrfs_scratch_superblocks()
-	 * may lead to a call to btrfs_show_devname() which will try
-	 * to hold device_list_mutex. And here this device
-	 * is already out of device list, so we don't have to hold
-	 * the device_list_mutex lock.
+	 * may lead to a call to btrfs_show_devname().
 	 */
 	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
 				  tgtdev->name->str);
-- 
2.31.1

