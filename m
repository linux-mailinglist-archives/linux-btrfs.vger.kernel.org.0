Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5078C47F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjH2Mt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjH2Mtv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 08:49:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D44CED;
        Tue, 29 Aug 2023 05:49:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCCUQN021779;
        Tue, 29 Aug 2023 12:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=YSuNUisqbBFb858C1NEV5sTGpsHh/D1VOq4x5D7nvCw=;
 b=mGhKNt3DQ45VE8ySli4R4gD9tuHiIubxgDt1kMN+ixlPjHwX7ZGY9R+ND0NY9EfGyvnr
 dZUEqYTXI4ZH1bpQVaIOHnWyNb+a3dvQ3HlV2taxsGv8vN1x+hS3ceRLbATJ6FdyZJgm
 xIGe22zOlCFecHjDM0MBqteOocKotNQ8NLUE5xjBcMdCZji9XxT8S+atGgnX7XlkFa50
 XInPkor35kj2q3F+ZL9BTEbocsicLWu3/bXyIMpUVFWL2qi7EgSepQ2DZ29xfhEddVrP
 Xa2ZLMITFAKfZNCsB2GO/WqUj2z0/byQYJi/HxZNR1zsIqPRZPN+ODqHm5vCgrdAT9Lj oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4cx6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 12:49:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TB3v0h036840;
        Tue, 29 Aug 2023 12:49:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6mn1s2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 12:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It0q9qqOWH4FgiRjqOrwATnad4E4O71g1QTmqAVXCh4TfgcsopJEFrP81Flgqgv4LCeZ4AYYVPlQiBZ6vm5ZjsFhu1Mlv/eWTt5T0067XOkmSeAIY2WoPnbjCFa1taoqqr/NqqT2uzSJmAVe+DPZIuGduSqCbf8/TkTA7Y6LQKZ3I3ByeCJjD4ToBAKQJM3GrW6zCa5iPuN3p6XE4wFeqZwVn8TaZG/JuBnGXC4vlcQDcWkl8wZ3qP2fyKKROAk/HPlILbR04z05+KcPWf3BLWWcuSJZYQTAzocX4/X+L3Sg+8FnMB58mggEOxXZhi59C1IssdT0iA36HNG069uMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSuNUisqbBFb858C1NEV5sTGpsHh/D1VOq4x5D7nvCw=;
 b=Utld7Es5YmOs4GgRzYRFp41Y3/x3TDAD7rlgdnrCLYPgQjHyiG9Xn1jkkHCMo7r7JH90eHQPv+SAVa+niutWuoWX7pt9SqXC7XRfIe8ij61bSMxpWSypwB6Sir4f/OXkNtJhsaTnTiqjf6m688DV0H470e9iB1DkMqBsTKGqV/vgY9AkCRwzMKH0A5zV3rAX9iGg8vg3+mZsg+HbHEeJ88hewwbvZbGloValJNAVRRGjwLGoPlapdjqbzf7/OUHxICKtJBEDPK02Ci7WxyBkU7S2t/es7X1F4CcrawMYF7NO/DPxn9tTO4AnAq4Y6j3ZQGDq0DIwSOtXno1FUZL0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSuNUisqbBFb858C1NEV5sTGpsHh/D1VOq4x5D7nvCw=;
 b=vEKY4W8iiPOG9KukwENVKQU3nkwfKzUgs6JqYr2NC3yZObrRWMntQeR0JKqaW0+zRd2Pz0YEDYcf0sLT9t3EwpCkf9N5drSeRSLdg0MKNRDPk9EN1t2soz8dtcDQB90WepBNKv/wV6vTXhQZJtUzs4ILaFGHl55UKeT7WIdoLF0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 12:49:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 12:49:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/261 fix failure if /var/lib/btrfs isn't writable
Date:   Tue, 29 Aug 2023 20:34:06 +0800
Message-Id: <3e6b018ef39babe84d3a307e547b480b4834c4e1.1693312220.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: df262ba2-4644-4468-2d83-08dba88e6754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B12CXOMN7fAAy2J31PVWXU8yDiGi4henGzGxLQ4O2HGrXmYgoRKBTA8HY03ItYTWEYIN374c+jw1ZUebaJPonnTDPpQd3cCrvB8WoEshP2jNuk3Cl0iVwHgyYQNw3opkk0ayPhoI/fX1mBT6JhpkfpEe2zpDkS/9xIsPtrNe9u3rzc86f4YYFNhNLV3JXeecsum8l167GodkwbneaDbNUSpZ//Hhkxu4R1JTs/k8Ogpad/lb6uHuZQRr1OWREtN+OSzh5nZ8313OWIepzrjxI19SAyQ/GJT2P5vGJoOqz3piPLjsPvZMjz8Tq2AAIHFqAbqgyvTMkykg4TQHW050uy5G5fRcwVh9HtPc5BF5iFyM6hq9qLwHY88JfXVQpmYDQna8yRaytuALi4GOz3mILCxKhn5uOomk0In/A1neAZ7ID0VhG6n+zarFx/160oJb8z3vmtUCREHXlt+PLm1zv2onx9M48me9HZCTOvj0dxTBMRvRe88iAtmi6QLl3VN/C9jvEn/aNp8GOCDgZqBebmnej5iL01yJvrPA3NT3s6LwaaCRjPTOsjFp3wl2pXfq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(6666004)(86362001)(83380400001)(478600001)(26005)(2616005)(6512007)(6486002)(6506007)(66476007)(66946007)(6916009)(2906002)(36756003)(316002)(66556008)(5660300002)(450100002)(4326008)(8676002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kwlh5KgDGA7fTAsVudV+CY4gmROCJ54JoLczgaWsIckfmrqv6RJZHHUNlNcb?=
 =?us-ascii?Q?DlFCwFXr95frd6ilcUbnjNmTsMwwXlgsMAO9ie3v0jPhWKACsRZXArtAbGKv?=
 =?us-ascii?Q?qtzNHEwxSZPFcucaU/FvgWDqr2LQIUO4TlrfeE57Ryaha2ItH5ZV6noZvjka?=
 =?us-ascii?Q?sSracfqm6tSqvkqssJI47mdVYt9k3Odb7NlACu7mKwWmRzvwvTQlxQpJECj2?=
 =?us-ascii?Q?hitS57agtGOa5CKEgM00Kcq8Lwsb2R+5FSNdx2TOsBCftBWfS/0uzSFqoYv/?=
 =?us-ascii?Q?NIcAKeyjfhjs+13Ahih/k6jGeDotavfZQKt7VITsruUrhT04fuKEO96cdn34?=
 =?us-ascii?Q?dmPEiKc9fji6IR8s/jA5pSjkm2TTMS87/w0mRbFfwVOpW0xE7db6wXmwiiuZ?=
 =?us-ascii?Q?9jiNWPrxnR06q1s6AmZDhstQFIRQpKKPFW25cMZ5Yg88+3FHdRIn7+fX+oP2?=
 =?us-ascii?Q?SFSrP2qcBMABI9w4QEqHJWPdZ7jXJjLRzoyE6AH3S+hqjGIOlhR8kVH9jsjX?=
 =?us-ascii?Q?1yT9wVCm3f4wOo7ddUoUtn86ufr1p7ylTWQqhzSyoKR+HrYn+AVq2ZfKHClQ?=
 =?us-ascii?Q?5G3PvRCaJWo9x9wZ63YUxcyDyzQOlyWLCCeK7wE4zhMHv6+QmxYoEkUybIWC?=
 =?us-ascii?Q?HQPRI9o95KrubAg2jTtH0ye+7Aue/CePgDvZ0IgpRCsHy/2aUhv1BM0riECJ?=
 =?us-ascii?Q?MlLlairPO5S0A7yz7d9i0pENsiv3ZcxOck54M1N3vRP4bzYs20UvlSQFmLkq?=
 =?us-ascii?Q?LMVgRecp95Rdo7TBWBZ2iwA0rcdz29fuoq9K4nheRwT6/XuTxiwILoUDLPxP?=
 =?us-ascii?Q?Av2C0yY+taNoRdNkMRQZkktDw76VDxobRXih0XlQAUZMZ1Vt35SNFL33ip+d?=
 =?us-ascii?Q?z6CZTsrxtBidvQD1wrvcf6LLvQHyNJWnLlR/DGBQhG9LnbjlB1J19Me6HtYI?=
 =?us-ascii?Q?4CrKcr3kwIhm6kmBFm/XZerKzbnY1lTbhKJF/69bgPCA2C5PE2JcTgJFkCGD?=
 =?us-ascii?Q?lSPFs3X3udyorBZUg1v7WieCnsspnGrQeRNrFd3JicyI4RurWyIDrpKK7+bU?=
 =?us-ascii?Q?tNYA7pVM57EeZDTf/zEMgqUbFGRproFkbqVS9+MUZwp3JWJXc/1tVJHkL8Nm?=
 =?us-ascii?Q?4HK9X6sNvQbO2TH0z0eJ859rBkApBWeTfp1qUncks7Cpdgog0l4nHzOlO8DM?=
 =?us-ascii?Q?pOFsqxK7HhuLvl5y2VbkwfJy5kO2R9LscvNzLdYg2qRmGkroxrtJFmal+2JO?=
 =?us-ascii?Q?72eYtzN7mU2PWl+Iinw9Dkz1foNmdziBJReb/Xv/JwN9EiLqA9PvuYFcedxL?=
 =?us-ascii?Q?C10oWs+IB9dkIc8G+mNKttpoYsHD+ojnTu11pElKwRV3hGQX4eWfYByR2StF?=
 =?us-ascii?Q?/l02xne2+ujeaGMLVxk6M7uZXtu76AlbaPdVlTq49mTzCLLxyRb+3bVXwAZb?=
 =?us-ascii?Q?u24TTmRPjqrZ3EkjLTsdS3RWEqJWU68wOBVIOcdyhJX6l/gJgrxHW3FNUbZi?=
 =?us-ascii?Q?ES0o+LG1an+Eaf9OG58yQ3YaiCAjFe7hGsT9GHLIehqhq9YdokbKNkSeLYr5?=
 =?us-ascii?Q?ev3gqTeqkEfuIHnvbd6qufdGqlsK5b7xNVMf53UX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5lvclKifPLBjjJ1Xu7eUEf8diwxrKOSTgNuV3s8tYwoqw6nv/rmSPplsBRCEJf9RhJznAVSghC9m10h/84Bk/Tk5tbE7Zi1R4/1jRzOqL8FTVk8tuaR7v+iPqIKKOKmJxduYxGSP6G0i1nMPVMH/h8l2vWzYSmwC+ODClTg5sK4pLQ7OZZsPoHW3w/tF6lRFToSu2mOVRwdkEpdnWHARQwp9pA5Q5reexFPiI9QK1TEr+9KAT+7C6vzsPvQwMLUYLZwiQf6RxHYKz0F0EhiMnTO5QhPQTEW9LVN1kB/7V6CQnsnHhaM7Hy0fq55BFQHpp3QKOSQk1L2fxKW7382QTGmAaXOMJ75R2H1JxwPCAiAx7Vb/ijz+hvtJbvJTDSJvkBL4uIHtgSZyuATX1bJ85nQWY3RQ3kQ4kioBvi5IVUqwxU3EqKr8z35pmpZyTGoxpEYpp1Sd8PvVIhBaDXLifQWA0sVSrJtF7UclRbjIyYYgO7IgpBqk6SpGySkfgc6JkTrg4CpgNoCCNya+LTUnQqXwnvY6QL8gvBzDtcOASNYfYv/daNYTzkOSKSZ3Vs537L9KHUk1EPmcRpD5mo2m+GzB3/jf5aT1X6U19kxHogwM7ZKR7DcdalUYkkaO6UyVMUIlBNeL5QPFKbc1tJWfuGUHC6N3dlyUq4Lh5Bh6DhhVjt4Rr2qW8anl0+zb8NEw7nTh8YLQLZNENDX9bwwPvDnHasI96qNYs0MwjJF5I0nm6zkYKBOEwWUcmT20ti3UoG7Psc7m4mWouewUQqkebQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df262ba2-4644-4468-2d83-08dba88e6754
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 12:49:37.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zM64tThWMiYBVqnQnJT2Z7C64GC5MGw4p5Vrzn6y/d60z0+mwTEC83/a9BqnsOH+sQ0+f2/AuBA9UD/59mWZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290112
X-Proofpoint-GUID: h1FKG-D79oFGzelFhDP0mkbDLEqM3VgT
X-Proofpoint-ORIG-GUID: h1FKG-D79oFGzelFhDP0mkbDLEqM3VgT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't need scrub status; it is okay to ignore the warnings due to
the readonly /var/lib/btrfs if any. Redirect stderr to seqres.full.
We check the scrub return status.

    +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.42fad803-d505-48f4-a04d-612dbf8bd724: Read-only file system. Progress cannot be queried
    +WARNING: failed to write the progress status file: Read-only file system. Status recording disabled

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/261 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/261 b/tests/btrfs/261
index b33c053fbca0..50173de351f3 100755
--- a/tests/btrfs/261
+++ b/tests/btrfs/261
@@ -68,7 +68,9 @@ workload()
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
 
 	# Make sure above scrub fixed the fs
-	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full
+	# Redirect the stderr to seqres.full as well to avoid warnings if
+	# /var/lib filesystem is readonly, as scrub fails to write status.
+	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
 	if [ $? -ne 0 ]; then
 		echo "scrub failed to fix the fs for profile $mkfs_opts"
 	fi
-- 
2.39.3

