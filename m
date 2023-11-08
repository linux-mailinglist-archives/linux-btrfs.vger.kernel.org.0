Return-Path: <linux-btrfs+bounces-20-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF07E5231
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 09:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372531C20D38
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A8DDDA0;
	Wed,  8 Nov 2023 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t02AmWL2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F2FyT9ux"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0834D266
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 08:51:34 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B081723
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 00:51:30 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJxCX022783
	for <linux-btrfs@vger.kernel.org>; Wed, 8 Nov 2023 08:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=3NQNd0Q8qMQfM/XpiayLGrajziGT3FE4k1FPCjl/FJM=;
 b=t02AmWL23bTZCpDE3pTJqgbI1s7/i+3NTkd4imYE+p/ATaMygT+zzZQK+0tuahK6MDqf
 xsRSs8u8CB4pfUJC5yyVIu7EKgtMsQQFm9r53EeaE3he9PAK+nbswNrqoGVnXftaKIs/
 orSVYe0fPcWG3+4sxgGelWGwIKqJOjY2yW3GFps0gRq0oep9R8Znhnj5Kt7Fz4mMM/3w
 CK0vkbUQBxLAkItIbbPcMf/FKY/JVTleNaCxn7zGrsuYbkZTLJMWaK4Crgi+o9kGEpoR
 Hn2uazZM6qL9XxJEwI3Q9ZaSeQKJXI4pB62y2EOnTzRKXnl6NBgCEcMLuCCGjNqm4JBa Xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w200xmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 08:51:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88BaJ8000412
	for <linux-btrfs@vger.kernel.org>; Wed, 8 Nov 2023 08:51:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vwsxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 08:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhDJJ16IUf2rmqMdAvLIFkPWWJI99fnv9ynK4XCQTLBQxYbX783cj/ro/KCwzPqaAyzjJqOfZFS2IsuwnDy5bo/dhKQ5SouSn41og6bxD1Wwrtzq0syDc3mfCBI8jaGItm93iLI9y2c6vDxINH+tRx96IB42gDp4mTLOElGnXdSDocE5xzuHztmUOpTRvmobg5vkczknTETFcqXRe7ehoegMTEwk+hUFuKkFn7Iugw/CcxvM6RujbBA9BBa3FwkPJ9taKhVcqI8mrK0ugepK5v7Req4/9vjb/rdyZE+v8HBv6xoxkeBKVGF3suinauP+j6fCX53JHdcV9cYqEAaE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NQNd0Q8qMQfM/XpiayLGrajziGT3FE4k1FPCjl/FJM=;
 b=Ji5qwhDebKFhHnBHN4jJD0t2lINsTiJC2LRBBlrfinmWdCqyWiFK4mefaAxsOO+Z603fXdvea4eLncOsI/kWaL+H7xTcYdrLr2nEaGMiX6S1ax80jfgYgXB8AK7DMqnSxwtUm+RnhOxyFbx491B+VOG2GEH65sw+o05cPTJj2wX0PZGqWBOW/Gft9iCRtjkq1n3XlsEYahZpftq6xbr610+1alyVjW/H2e++iuHHdqga6U+n8G85/HcJ/6IxpipeRiFM53Z9hZGxLML91tajpVRCQwD+/i23ap35//700rbqyBTW+2qJzRJAbq9J6MFV+UBW7589Fgl45oMsoZNx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NQNd0Q8qMQfM/XpiayLGrajziGT3FE4k1FPCjl/FJM=;
 b=F2FyT9uxuDjSX2HO52OvRY0l/WJ/bHrTTIsKshdswsQLacTQGMAJPNTVxJq4iB8pcay72GibMPMXkGr0Jo6V3rRbQ0V13oJzO7xloA86n2rdpSw1uqhP54SlvEn01HO9LEqokJHY7ZqcQJi3Bnxm+oIR0N5tj/7k9pcYgd4r7fE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 08:51:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 08:51:25 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: tests: use new sysfs interface to check prereq acl
Date: Wed,  8 Nov 2023 16:51:20 +0800
Message-Id: <a98e31546da07a22e785cbb1dc40720fcdb4b095.1699432917.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 7980593b-ab4c-4a37-7d15-08dbe037e3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bUbo9QyNy+OlUE8inRfU0Dzzas3SYC6HgMufvkLwJgRjyPYlIczYA4pXcuN2IezY9KMUY/WAssFqethwjvPCAER6pmlRd3EttXgN6zgT8GUKLF9t3I7o2h38IXlJAjLImYQFcUqjh9brmlxXsAhApTVPgCovLlrvBn8RBcpMUKvHJy8vIt51g1QH17bxB9rYVT6iyDhTerRYlrnTZym0yv5MCkP9t2d+T3jcIgE1S08iCt1HWsCtJ0bsepIzJnhzS/Ycafw8xE28cT3K1G1rpKl76QersyMdVbRx2jg0bEbrFjY1wunB1Ux0Md0ETPpfxXqxu4Dy5PovQXx2ljStfOkIE58NLzdRwINqQ2pklpNJozl6WmQNv33vnqgvP0PHzOw6NUMnMQhpAnzDrpM2o+v5PSx6NRXCsfaXuxu5zFCw/ezuZxdiIgDQdr8Aqmcd/0MEV0UThIZRtaJ7dgNKPOHWWgHX1FnFm8PKKPhVtl3hAT4c+SYZwe/cXrN1l/8n/DWKpnpP8084PMaSz9DQGvfAPyX/DWkyHAJv+dYP9us=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6506007)(38100700002)(6512007)(478600001)(966005)(6666004)(6486002)(36756003)(2616005)(316002)(6916009)(66946007)(66476007)(66556008)(26005)(86362001)(8936002)(8676002)(44832011)(2906002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I4yNWV2APcKv9KNTRCg643i/d6N7T+B7c5f+w6nwI1nWHDTSx8dJRMB+UXmW?=
 =?us-ascii?Q?OV/22VJn/ISpiF8tnl67Ycs+otsA6ItfjvIurLkmdQhwanVaU73PJydncEoI?=
 =?us-ascii?Q?+zeu4RBu6qafjV9AAJPl7iKN0T8Hy1V6NeOiLY32EjyKdgj+Jc4Mbx4m25WM?=
 =?us-ascii?Q?iCE+ResQdlzy6jUODr6h4YXdSPotliaLwKqirMcbRC/iX4UdGqkkGr/LIRJa?=
 =?us-ascii?Q?wucL5wowR9UnttE6vXbZPv7NPQPV7rf7JbuW93tZHAhwrlu1zxGQU13WG9EM?=
 =?us-ascii?Q?IjNL00NXKQuoJqYDm5KTDh6O84UMuGBbaHY7lXMjYAhaVUBZfGjH4h5jZHdW?=
 =?us-ascii?Q?xWbVVdRoBSu7nX1i36bct7x076qDonWMmxlomA+3rcwU+L9rp6e/ZlEVdeoT?=
 =?us-ascii?Q?1jhWuj2IOwf4vAMOiMiRtD+H3HDi5Vvteyx/5Z7QHhYrsSSvxzjiZ0965Pom?=
 =?us-ascii?Q?VvCpax7BgjdCTBMn3nQev5lOz6kqBe7uI335rCH/wA/uLMQuk5kA+LV54WbX?=
 =?us-ascii?Q?xL2DF13h5Ab0ntTjKJYEwCLughAeBmzlx2M+UqE4jFDU33l9y6v4aCFRNhi7?=
 =?us-ascii?Q?mXn2SzszClKpW3st2DhvsYlB8SCHy8yUQ5LCLRa/6ueRzWGcahKkE+NtT3UW?=
 =?us-ascii?Q?fRYR9kfeQhKu82eEio/75zlMjZsAeaYA8Az76FRnYfqzmOdEsz96p14Nh4+C?=
 =?us-ascii?Q?K2VM4QDJLO/oYPT3NJ3t0NmXHBUbLLaks31fSHND69DViArCeV6H6wpYkS7E?=
 =?us-ascii?Q?IVy0icN4SfV5AcaeYZ19nM0J/i6QEw67XoKvyEgGNoUDZGQngP3LTFYnAMNo?=
 =?us-ascii?Q?lLYPYNO2d3EZCfhAk4JlWAzRK7v/Na0fVg57Km/rXyvhFYSo6fWi3jgKai+H?=
 =?us-ascii?Q?RMEWMwVB2J3w1vwCw9dEzWSPxZljuO5MXv2imORolSSW+cCYr8tMhsDSbfs+?=
 =?us-ascii?Q?THGrwe75xcH6HFYyCgHRb3LH1EuOTo2mtjTYIfOkFw88z3iYE2IatfKQ/+lN?=
 =?us-ascii?Q?2yQGXivzEeGU6aOCYIvG/ko3mtyFn1/czNi20eZraW78t6Ufs5qzP+JdTc+b?=
 =?us-ascii?Q?UOunQUFYwDGznI4qNYXJljoSO1W+yoiytZovqYfzb+jHFeTZs3tu/MF9NTqv?=
 =?us-ascii?Q?6BNRPWr5pLV3gsA5wLszS5pDampq9BDGoLCZIwyzRotpfN76sEczPVT+0ZDC?=
 =?us-ascii?Q?LB/XD5n7rs0RsReOviWbpqNwTbWNfqSlMk4a5z26cya+VY7MjCgVexu74WEU?=
 =?us-ascii?Q?I5J4PlVz+4NahNV1/rB/Gy6CAkvW1lJd867lWqgE23c9FE2a/Wg0fIKCS7ib?=
 =?us-ascii?Q?e2t8ryhcoUaBe7TtPsigDGT322CKcnTxXYuW3qfkwhAzkR0u9/xptp9RSGdb?=
 =?us-ascii?Q?S7t6hiWAhtChWwuWeqRwUyf/LWsdvfonxwpIrwqV+wcXY+6lkLhYNYtOpq4Q?=
 =?us-ascii?Q?V+ISVC/IB1Ik1PBUDcLhEtoftyIbVFIgIrMDqAiac5LdurJ+HVHLcQysmND6?=
 =?us-ascii?Q?NDjxoRGnF/jITy1K0b6e1+mlq8yMlUVQSsYj6VzlwbOlWh6J5i+VUe0N6QZ8?=
 =?us-ascii?Q?saiPgIgY9lFwPcQ4TIEn57mcgnvXqQYlddU5yICb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	chvG/0aTMOmtZJcHKLA0wfyP19GCkXIs4N66miU5Cg7cWyup/SggsH5eyt3eAPNCAFMc52eb3Fz7DCH9Zx7E6teYajYUdBQMrm1qCmRBGNOtyuaMCpkirxsJA4FQyMFOu1gWxRPYcQdgucXfGa+ESq7v2qXRRecmOMGoHq3l6SjLirf76e6SoK4UxuwW1NHXJyHtN7VrUU9lvjJGLCgDw9y74TUxbrTUMN3ywGOH8tPtGI782aOUuZrETgbDKAuD/RJYAtPyj797B/gyOFikhTmeTzjOpZhV/W9dSNvFRCyU5SoJEZGJEzQeYDoG81kXa20wEz+3O2h6bwY5M0C2hcNEvBXNGn9QcdWXpfZqWG4tk8QmV4T3wEl8fVlawhzQkdz66uvv/IFVfLfZLX1E+UXLrPOOEYSZYtR4bU/hAG0YyRwvwy+1SUPgPRxIUKJzUas0w7/HwxBPpkkAB512HalTuUoFGtbIVWTOCK+DCkD+HTFzMHxLJXPAADZ68nGZl8NcbaNeW3rD0phOzyM6EgoY3f78owOwBwyCMOc5H83a5jM4K/dZzscm58m45QnUVavbhdt/BCF713DX63RqhUeRjiqmavUcceXKC8SRNOuDMyp7CmZpJUF31xVKqGoUuWkU8jK/SXlI8CdQ7+pyKOwHQdk68YBv4WjFzvjTl2h45hCa/4ao7nNQwMRRFEGns8KdxeN1YZGcZ9OJIWp1JEljMZmuMkDtN+MaI7pEzmMJtD/ip2N7dsP7BcJFRJhoipAlNxygofLoTH76yM55Wg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7980593b-ab4c-4a37-7d15-08dbe037e3c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 08:51:25.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shfeprfWKDiaRqYI0FKMSX08dL/mjbdq8ApiczEFY9RYHByd8C7pDTUt2rOccyXpWg+xYJSWYG7vBspJpDsz+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080072
X-Proofpoint-ORIG-GUID: sJn_hcLMjfuHIY9btWVb6ro1k1T0tsgZ
X-Proofpoint-GUID: sJn_hcLMjfuHIY9btWVb6ro1k1T0tsgZ

With the kernel commit 070bb0011ccf ("btrfs: sysfs: show if ACL
support has been compiled in") we can now check if ACL is compiled
without requiring a btrfs device. Retain older method for older
kernels.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1:
 We forgot to add this after the kernel patch was added,
 https://patchwork.kernel.org/project/linux-btrfs/patch/df5dfa3a329e7418519a5881311d776a50a118a2.1687250430.git.anand.jain@oracle.com/


 tests/common | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/common b/tests/common
index 9621600cd71d..30ce7e697b27 100644
--- a/tests/common
+++ b/tests/common
@@ -578,11 +578,20 @@ setup_root_helper()
 # Check if btrfs is compiled with CONFIG_BTRFS_FS_POSIX_ACL, may need TEST_DEV.
 check_kernel_support_acl()
 {
+	if [ -f /sys/fs/btrfs/features/acl ]; then
+		if grep -q 0 /sys/fs/btrfs/features/acl; then
+			_not_run "acl is not compiled"
+		fi
+		return
+	fi
+
+	# It is an older kernel without acl sysfs interface.
 	if [ -f /proc/config.gz ] && \
 	   ! zgrep -q "^CONFIG_BTRFS_FS_POSIX_ACL=y" /proc/config.gz; then
 		_not_run "ACL is not compiled in"
 	fi
 
+	# If kernel is without the /proc/config.gz file.
 	run_check_mkfs_test_dev
 	run_check_mount_test_dev
 
-- 
2.38.1


