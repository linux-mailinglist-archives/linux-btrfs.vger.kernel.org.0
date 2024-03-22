Return-Path: <linux-btrfs+bounces-3511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C00886B2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 12:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204A71C21CB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8103F8F1;
	Fri, 22 Mar 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SZahmD7K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gqw7Ru37"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AE3AC2B;
	Fri, 22 Mar 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106247; cv=fail; b=CeZu+4xMs72SErHrlqFWufZLgCooUphzZlfGZSPfcqSWtJtR7YaBSN4qNXNatVrCMZ28pAJjcfpEZFogyAmAfzZYH5U37zVzTl1VzqWJ5FDyyYK5rHUmDI+rmSdIGQ9fomdu3f0Rkiwi3s5Zm/ZXHadYQhwmkkNG0vbxeDP4Tac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106247; c=relaxed/simple;
	bh=QCg7fK5USOKYS18AVDAnTz/8SxtuHIVO61pNJrN17u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+9jqPPwXjnqgsPUtui3X5Hvd6NgoalPVDg/pJXQBqDIABcTfsy5quRjHymnxCangMBKIjT5pSMaFSDh3WQ3kGXQOInnX935kd9Uaf14jjCJrblXQKfHEYGVVa8MHtlnHgGknPgGS+/ECrDrR/XfC0usn+RVEcoLO8uPuSEfNkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SZahmD7K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gqw7Ru37; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7Y7Yp004068;
	Fri, 22 Mar 2024 11:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=sMJqwt/NTCxm+cvenhV5b1dOylppWQiBcLO/b361TNA=;
 b=SZahmD7KFKqGNYbkNCYt3yrYduwraCxRgnOkbVjLclKiTYcTlgQVjoWgnKmEqMfUBgr2
 HKuWGK/lKE5Che5jN52FClUqbK2YPCuhhdInGFqhxJagqyjW4BXkuy5glheuKc0vzpa5
 hbKZNx4a8Qpe+FSQ5YkvHJJQpRZzv1Y0Zy1KKwS+G2LgjsjoIUbTxzTSINrYWf9JBOAj
 dSg3Bh4Ny2jIzl8kaj4kr4l9jX6yu1+iIAYFr1JaUsdU4gxdPhi/5UmZ9QVtw3Ovcu/u
 VX028oV1zckeo07si1il6W3iUHfIaUrqBkJow4ONbiD5vv+JW8v6+ErrQw4k/emlfj+c 8A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvk8vs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:17:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MAurEe020218;
	Fri, 22 Mar 2024 11:17:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvfc9u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:17:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBO9PTm3zP/A15LuvpdJdSgblckzYemE8Y6C2PS1CDAhJ4QBJA+h9EZ43N0LN9r+YQTc8EBJCRQUDFEF1vbD/ekM3RFJCF0RqS6KMTatib2+ow8jahD21MMBkD9hSu1aJlCk6NysdbJHIO3p1p1yMMDSlMVOkXdGtdi5m4ajvAC/B+1YYjX0xMk70O42kc+B38iqxZ8cOUfxdyAiLFF520EVZ+BFCjGI+0EjpuoH3Nr/XQDm5lc5ee0rXqHmAD3FsJv7jN0cNuJEgT9KDiCjAqLoEjyuJFP06qBh72/TJ7sD5fWIXcrw2DvcMLv1wr96LD95oYvPEvPMIOQk8MejWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMJqwt/NTCxm+cvenhV5b1dOylppWQiBcLO/b361TNA=;
 b=aTSy7aJSWUouVBSXZJTcul33l71WJK0nrKE+umHtd7szOyeVHj4gCqhqrXIYFZ/1KNkqLy65NWal0xweSJbJBjP8LdoC7okUyFWvpZgHoP8i/lCbgtobretbODYg3BzqfY6yS7/7dm4qwXZv9LrMFRaSM9ss6+OfbrT3ZsLrbzattodfMbAuT6+KvphL9EwSy0Q4Qj4LlWqDUyCZD/bdsNZ4FuCebIzrxabqNcMFw4vEUh1Pt1GaAVyazHJXBgcVc1Jh4N9YWcfL7Yd/WzDwjzRaTYM+jggKXwYQBayV49+Q4vFL2gAIRdBh5KWsHNnq4rfCOVyCNKEpukiigZHgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMJqwt/NTCxm+cvenhV5b1dOylppWQiBcLO/b361TNA=;
 b=gqw7Ru37+wGvZWkCxDCvDvQVKxr0ZwX+y3jAhS1+CmX5QiLMEtloDL7RzGim5n9OYMgFnI22DpiFNluKiRWbUyYWM/Q6DiQ5O0QWc1tVSI/ESkWQE7NYbKdF/RZdBeNftWMgX3TAq6C8Gs21G9fn4l7QZOgQ5k8b96kaMXU2H7c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Fri, 22 Mar
 2024 11:17:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 11:17:20 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v2 2/3] btrfs/290: fix btrfs_corrupt_block options
Date: Fri, 22 Mar 2024 16:46:40 +0530
Message-ID: <4a6cada1ad70ca1f9cbb825d763364b71ac35514.1711097698.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1711097698.git.anand.jain@oracle.com>
References: <cover.1711097698.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f6ee47-6217-45f6-562f-08dc4a61a3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E/mj3fVpQ2ASIR8GJisNtalIF+sN4e2mfmtaMf/h7fGyI7fgYQhB7anbS3iT1nCWHFk5pVsUV7TzOYFepLKBCpp7AExEsTHydMM/i2bI1oH8ZZCh5Vyt2lu8zm6F1VmBIJPfhaXZ+mQjJFlVR3kjE7g+Ok3ExqMXM66zR1Aqm9EXb6VeNlQYdscV4BXVK2AUJcdeF04KbC40JCucAVPFuB0H+VNcBMR3mRInCTj3o7u/ctC6MeQLcqEhbhrsh7wcZ4FogoaiMCHEhT1Bzw3Qi4F3ej6B3xrD6I7M3eHdQvfM8mEVfIzPEawd3jZV2gpIlYXrHBH/EYrp5jeX7spszfTyl41sn267rfprT2oe6W6rtm0iRNBYqAuID33qg2ZSm6epqo7A9IEE4A3JWPyLj7htF0u2ML7eTdWW+MCvAg2kvhGCrF8p47JOE/vHd+A8Kb3NaEST/FBEKjSRxsDODfYWVhFE3yVNxhHW0SKVCmq2Qzgp+Maq0Luja3eXwuE31C7zpZjl+hoAalVS8Gfnl1ozZtt8OiIgDvlr1o8jay8Jw68MAY021rsNRwpGiBHV/v4KFN0TZS47853MNzTrMpXivPSkHOzl736t0yyc19uFI+uFK4yHFUsgDasXmMJmRcnvts9Pcb4yec93Iy58gM7I8j38a3ie1L9JeDi4Dqc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nsfogXpRqWHHbKc9W1DWEBgaqQ7DWzoN8h94jT/z9vlOOrnqIRFTiRG6FKuW?=
 =?us-ascii?Q?XJrXe7qP29SENgB9FjYqDT9bIF9d8GSxLXk5pbxyO1uv5OwHnFY0FX+K1ObL?=
 =?us-ascii?Q?k0XGi2SM7hhcWBd6wgzJrowDB875Sx4xJOvHU4xTLSjSbcOzYsaZpVpbM0x5?=
 =?us-ascii?Q?/uVZ6/dPBxB2/iVdeBphDny2pG4nb3CX4dp8z6NnbxGc9U/AY4ml27S6pNtF?=
 =?us-ascii?Q?R9b4Gn0sARShGJp5GJyImMq2XOoGLhu8aaDnZgOzXYH1QDtgdZkxREI3h33J?=
 =?us-ascii?Q?U10/T4b/iJVjGGdfHqHKic1xuvd9kHD6NR8EMYDiUWiZCGO+noLg1RHihfm5?=
 =?us-ascii?Q?dg9rKzDc5m8DVNNA1HMpTGi1MXWdZq/D9p8TdmzC+1VoG72z6nhj2yPNfFTy?=
 =?us-ascii?Q?/87T7s1RMIOb8KUUDc8BT+C3dWDNjvtBQcEeANtWW98ARDeBDECmVfnGviC7?=
 =?us-ascii?Q?436o68vUeAtvtT+wwFVV0pFs7SH2RRamvlOZey6oyBWObzb0LxiKdam78OPU?=
 =?us-ascii?Q?AuopeMm5d3Sa/eDh8sL2ZXnt5IvsQzsTeqVjJ51h7yuk1TcdNW++ZIUHy+ik?=
 =?us-ascii?Q?8UTse4xVx4fvnZ/u952lCeBNNRvqCbF6hE+zHslz1qbbRtZAhhmnWlw3a9Vg?=
 =?us-ascii?Q?Fa2+SwfF8cP5y8QB66PMA+fTnNOhNzFQiuDZMKUxdafiTuxzTnIbDPlHANhO?=
 =?us-ascii?Q?P3v6Ukn05VIgtDcUWlVJ4tVi0K34x92lS+bGEfGZx+69hOeMJ9t1C4YkHiox?=
 =?us-ascii?Q?UKK3k0K7KWiZpxOuDzRSOYDAw1TTRkO1yBCYDoXYnELRfUJFqtwjYDGgQ76K?=
 =?us-ascii?Q?5XShaGryYWprwWhPalC+xgXquV/VbYFETkK6JOV6biEJ/lPzXxHLEpQywq1P?=
 =?us-ascii?Q?IEpu7v0QMJRVAgIYwNvtRknJTbV8FpfGdDHAwm7S5y0IFJ+p42GY91dFWo3n?=
 =?us-ascii?Q?vMxke622TeCU0A/fV4bTQuvaWe4/eWi4yg7IbAH9v7I7cj7rZ1wuwYWuYxXg?=
 =?us-ascii?Q?922626T8uPYlGDfIagILv1NUn5PU9JTDwxWfeK1yqz+AqUTxYDPD5L3vDA4V?=
 =?us-ascii?Q?/Zu6u8dph0/Xfi37zV33/Eapa7rOORjseUgYljmr2YK+ksLsF1m0QRzrqHKA?=
 =?us-ascii?Q?65uHZPQ0mXwMSL2yvPEpsqQplRcM379CrLZgyLVbNW+CvowFwYltIoQJq1jF?=
 =?us-ascii?Q?kDQjIhyzXnBlOFCgNn2DGk9iyiymk9sM/wRT6sLOQAgmN1Ags58DnKWVKFZZ?=
 =?us-ascii?Q?bL/94yEj+BLOja87bQlS0oXftenKjYdWB70Pk9wkhDZ1VzscXBM3glSc+Tqm?=
 =?us-ascii?Q?ZshLTTtXzUu8d+PX6cytbfHzfntB3Wg6aZfco/0HfDz8r6471X69j5T+ICCE?=
 =?us-ascii?Q?80eZA9RO9GkQQ9ftugu6rvXMM4ZkRQHzTAV0BS9A+qrByvxWZB/QT7aeAiah?=
 =?us-ascii?Q?eMdvQCR3n7Vj7QS4edaLdx2sGUlLbUjEKfyBKUnxQXWduAch9FjreRIjFW99?=
 =?us-ascii?Q?bb2Xg143hk6CduP4dApk+riiFIRqLXyUQq5Ag7pXz0eAjmiL4ELeS0MgENVa?=
 =?us-ascii?Q?oUV/nDe1E+DJ1s8Pt+lCcq3UbwbLFueBOqj4NRYpO/RQ5QggRQSzCrlunmXP?=
 =?us-ascii?Q?0+sFrvVgmARNsxlshPykZv3G/WoXVY7SC8rku2Xkhik4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VjC9bckU19I5gBHk2rKBb3FVzG4mNDQaqdmrJEIjk6LSuPOGOUhIgLl+C7C8w6XubjAjX1+o2EyfXc/936wdl69dkueAkNfzUkJPi3LVwWWZNp3PGtT+9WVLYPDLSfvjRDkqEpo5oq/nssv+0dXD5QCSqGn3R5daQitX4Otat1b7wOs0rlkhKAuJBwlHi5MrQBjYbzW9fL4xFP0qzrp1qIKlC6H7sVemjjT/Hey88Uf2xKpA9dQKQH7GJ7imCveQDe91v6atOQFTOH+Ptgl2+2WPIFn/u1I0f4Mcz0KTO0Q51az4bTLVRnldST4zLaWhRhDvjuOmzcE6Cb7B7u7RWviDIu6vf4jvpV6UX1ViBSMPgsYcP2w1kQ8tpvvP8RdeE4TfWaqVdt0YW9VCEDEJRojwPdw6YMK2fdOGs1FatA1jbgzM92l+Irx0K3f3169jG4htAfcsQjeyt5XLwLyI4yTfOzNbAXoYKaBtmAxJvrTqx9Bjw+gsur756C72oaEOxGf+/BCtByV+Ti2kBfHqC/7xkI6j1+AgtUEo/VLhZA/sqGW8Dd8VvICOL8uRaLs0HI3Kxi3mLojdM93o9rEHdMMVMs0qa7fWGWmTo6OaKMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f6ee47-6217-45f6-562f-08dc4a61a3d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:17:20.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3x06D6gKOQHwwsxk8GIQKGcJM/joMbg52DPsUKwb4J9yR0xU/c876eYmWxyzYr5lDrOU2hO4EG/WQTjv8n4mSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220080
X-Proofpoint-GUID: uL9XmJrMPAEYY4lFU9c9dtiOqpHUPdqS
X-Proofpoint-ORIG-GUID: uL9XmJrMPAEYY4lFU9c9dtiOqpHUPdqS

Checks if the running btrfs-corrupt-block also has the options value and
offset.

Remove btrfs-corrupt-block command's STDOUT and STDERR output redirection
to /dev/null. Without this, debugging wasn't possible. I also noticed that
command is quiet when successfull, so no redirect to $seqres.full is required.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/290 | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tests/btrfs/290 b/tests/btrfs/290
index 61e741faeb45..281333b200f9 100755
--- a/tests/btrfs/290
+++ b/tests/btrfs/290
@@ -31,7 +31,8 @@ _require_odirect
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "pread"
 _require_xfs_io_command "pwrite"
-_require_btrfs_corrupt_block
+_require_btrfs_corrupt_block "value"
+_require_btrfs_corrupt_block "offset"
 _disable_fsverity_signatures
 
 get_ino() {
@@ -58,7 +59,7 @@ corrupt_inline() {
 	_scratch_unmount
 	# inline data starts at disk_bytenr
 	# overwrite the first u64 with random bogus junk
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -72,7 +73,7 @@ corrupt_prealloc_to_reg() {
 	_scratch_unmount
 	# ensure non-zero at the pre-allocated region on disk
 	# set extent type from prealloc (2) to reg (1)
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 1 $SCRATCH_DEV >/dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type --value 1 $SCRATCH_DEV
 	_scratch_mount
 	# now that it's a regular file, reading actually looks at the previously
 	# preallocated region, so ensure that has non-zero contents.
@@ -88,7 +89,7 @@ corrupt_reg_to_prealloc() {
 	_fsv_enable $f
 	_scratch_unmount
 	# set type from reg (1) to prealloc (2)
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 2 $SCRATCH_DEV >/dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type --value 2 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -104,7 +105,8 @@ corrupt_punch_hole() {
 	_fsv_enable $f
 	_scratch_unmount
 	# change disk_bytenr to 0, representing a hole
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 0 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr --value 0 \
+								    $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -118,7 +120,8 @@ corrupt_plug_hole() {
 	_fsv_enable $f
 	_scratch_unmount
 	# change disk_bytenr to some value, plugging the hole
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 13639680 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
+						   --value 13639680 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -132,7 +135,8 @@ corrupt_verity_descriptor() {
 	_scratch_unmount
 	# key for the descriptor item is <inode, BTRFS_VERITY_DESC_ITEM_KEY, 1>,
 	# 88 is X. So we write 5 Xs to the start of the descriptor
-	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 0 -b 5 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 --value 88 --offset 0 -b 5 \
+								    $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -144,7 +148,8 @@ corrupt_root_hash() {
 	local ino=$(get_ino $f)
 	_fsv_enable $f
 	_scratch_unmount
-	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 16 -b 1 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 --value 88 --offset 16 -b 1 \
+								    $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -159,7 +164,8 @@ corrupt_merkle_tree() {
 	# key for the descriptor item is <inode, BTRFS_VERITY_MERKLE_ITEM_KEY, 0>,
 	# 88 is X. So we write 5 Xs to somewhere in the middle of the first
 	# merkle item
-	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v 88 -o 100 -b 5 $SCRATCH_DEV > /dev/null 2>&1
+	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 --value 88 --offset 100 \
+							       -b 5 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
-- 
2.39.3


