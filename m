Return-Path: <linux-btrfs+bounces-3150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B1877180
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 14:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4C9281C82
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239FC4085C;
	Sat,  9 Mar 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ECdl/Rve";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SJ1B1KFE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739F3CF5E
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Mar 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709992019; cv=fail; b=mABSfhhF2/36s2r4WhbZfbhlBJvG/zEWb27979JF930EdTyyvuqqlsjPZHScuaV9DQx8Z69sr2omBVuoyBbHgzts9IuA4Xc++pfiQvPK0TockhukU8e6FEoJ8TXcZvZHAf9lsisAZMJtZaiwNl1MDULflTs0zm09qjJnRhRMTwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709992019; c=relaxed/simple;
	bh=oOZ7KNaGaMZd18V+WXfTfeOLbVR/KhPpY253ZOT9aq8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WcF9ePkhCQQ/6Q+5PmrvbGJaS78PHiRx3Wl6RldR/4vUz1tgkQ9d4pXiTXuiL17Atb7Fja6UZkRXj8H8jQzXHHShBS+C5IH6T7OcvX2uFMR4EedC2xvyQRfCYZ9xeGAqKYXHgfrB5d2xuNDYLdPvGGfRvyh+Sn9lOKgAoqbgkG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ECdl/Rve; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SJ1B1KFE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4299ho3M002234
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=9h5dJYYOUGgFjBVCLiDfqn2gMMO8W7unikYQsqJOHpA=;
 b=ECdl/Rve0t+L+RI8pQ765O2toRPfXTgXyAZ6DMWLZQlRNzJOTb6d81/p6J8hdtX0DZuA
 +mWZZm2JaMwbJkHm4EVtub2BCewYYJl8duFljuStDVDZEUP3+7r0qLy67DwM2VZiGEwE
 aAh0IOOSw+JHqAoJFuNE1hRab/4xF18ux5TM0bDb4bpdU48r1b0dIlNXX36YiHGFckRO
 YLIDFSzwj+nscR5IcjSZ8pgOTuRFfdJx8KYVpGWev0R0Ia0RKsRPzBUQ8w8JAW59fZzL
 efECS7zKl3s5gHBDI1lMVxIifCtxksMOr8vKLWCAgSlazmaLU4aDCsFdxpbPOi9MRbAs zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcu8h0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:46:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 429AMHMK006018
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:46:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7447by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:46:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEQg/wacn8zdPk2jCrcHs2E4/vywZfsOn17jUDD1e+0FNaZt2KXCsfRHGe8Go6Tsvm1c4wYV5DVGI6x5+FDPIJBUytJeLdYdscwIAcaC0zGxhgAJW252hLqH7SHeDXSUyWYGUg+aGz3+v3J74fmN2z1W+7bYlYBgpvoeB1m4VPLiiOfEp1FEDZ4NkUbuV43Zm8jDb1HGMtwX/9Jz5AlPZTpMpp+NyCKVTFsQcjCEaENHbipudUr4icjYXOs6bPQ7JXi9YDrvdxpOVUOk1Hxw2CXjKqQb9QqK+OuucTYhuebhgNyooD9cajCS9jvA7omWm/wh7bi/JHSiB2eEZLEiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h5dJYYOUGgFjBVCLiDfqn2gMMO8W7unikYQsqJOHpA=;
 b=Md68uLnXsF+x/nJ9nUDlADBjoEq2ik9f0NnWXGu3S2DF7ZsOf0h8boVw1XJ+QjpuSB92Ybf/WDe1xLc3iN8nKfhrgn2sw7ytiC82R7yNL8X4ORLYV1f40Rx96cZbjQEi2EsxwwZ5nWZ1R3yZghBkoW7G3udTi1Q8jQdFGLr3vzK1G1H/laxeXTiEYVIKHwC8CqRzDgZRZ7qZxOba6dFFCpT7V2EYeJKA1aRvrybybR9h0R6i9XE7rE7RO3JSRCjOu4BUeqZ4oEO8awyP1e0TFsNjbKSnOi4o68zjLI9kTwRi9lmXA327Y4FkVcIaeNiEtimceqYYCgIS1CegCxLAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h5dJYYOUGgFjBVCLiDfqn2gMMO8W7unikYQsqJOHpA=;
 b=SJ1B1KFEHm3ioJpp4+dQf0OvgYfZPv91SV7qpYFpsPi7IGlmef17KSUnqb25z+hX4ssHvg7Rd4YV4JHIsoz2uZAwiAwNpNgpNK8AUiOK0MCPpjTEgYXdwrslZBZdwBDr0rHvvqfE6gfi3BmoG8c1bekqRfCE1l8gxjz+L9kRQYk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7509.namprd10.prod.outlook.com (2603:10b6:8:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 13:46:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 13:46:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: return accurate error code on open failure
Date: Sat,  9 Mar 2024 19:16:35 +0530
Message-ID: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: c239d18f-3974-4b96-16cb-08dc403f5d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Oei65opvZ8VTdGxVJCqlVv5W9Kau8fZDbXCh+KnzOzjNdJd/qyF+9F4OZ5jcWEFgh7nBiHz3C0ISmijH1SwccyUncOAb8lZuZPQuR9tlVcWiuLBGw7CTHzHuH5yjUKCv30nsp2+PBZd10ugGc1WEJgvr17YUgU8mrY7sKhr+ZprDIa+9ra/JC2ZoVrY8ZVhk7JQnxYLxZ3Lf36jOXGrij4phSo79FLHXYkCqqCuEWSl+fxRiyDGhsBLI8YRJeDgNKZOS0ee6nNj3rveRZKrvZnZ+CApXF3iH8BXEC63EjxvRh+cAgDE47lz+CnHTKWqwpsSuy1A7JFKPkvRjEym2mTgmP39bb133qFYKy87q/GhWUTbohCnKITzbSTIngKn4QhDiHWSxJovK/ko1YxJbIGZ5yqzeVkDOzjSHcMgxJYJR2egJ0Xt6CCV6fKtGZwkvbVo3TE6EGPDKftAkgNEqrMjplCBVmItNU8CGIjAHnsoX2wLMnEEnbUYqb1QpO1RTrVjiy6Nwsi0WsSGS90uTTkFMEjafuJACRmCfj+LmOvC7UELPveSzHb40ScYOza9Lgs2WQLaCM9Ogymch4KpKK/lgYz9kOnVLJCcFAvptwwn065G8WB4KxHAalwDVcqdizyJS4eRWgPT8UvmcQURIFq8TWVCfEyLK5hgUpYgw1GM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V3YtIyqLPd92YBJ8erYrJVZWefveypBzl1aRhPSkNSWDMrnPCZI5cwWnlseB?=
 =?us-ascii?Q?4ipPJG9GPsJECp4dc+p7bTXb+zzLraxkO1qCcmx9GnG65otQ0p2Z0y5bPwK3?=
 =?us-ascii?Q?WMIHOxuGqyRopwgcLQ17VG0LLk963d+ZPdpKhSldtFICUX4S5Fq+EwVMgoy1?=
 =?us-ascii?Q?QeG5T5Ih+XWZHbf3fkIbri4SJVq1MhOICNChERlAT2bk4zZ8/pnlgaDq0t82?=
 =?us-ascii?Q?g+8DxGI040NRrdYuGkkluzsIuAJg4kfoT7ehC6UMHUu0D9v6soaLUTVyJTNw?=
 =?us-ascii?Q?pG90q42heutJ7wiF3fddmcIirMlLMzdJtEwG4XCyISMFXZN6uaoGVq5thEkc?=
 =?us-ascii?Q?g7FGYS57/Pzy6V0j8EWgbHOnBrBJUHF/4y9eM0EujYUvRVhfgBJ1aWuaSfxH?=
 =?us-ascii?Q?zRR1X8iIi7e047awRa6JBbxR4cqrq6S/JCE2UKvWj7H42D6cvGiBDnX+3VoZ?=
 =?us-ascii?Q?EGilk0UDJ9s54Uwlm+kpYOOEFoAaGG3bX0cGmRY4T4hyBNHUJPppvD49lk1S?=
 =?us-ascii?Q?4dy7F5m3StDyyiIPfLHsTfLUx4esr7hEWS4CTOQyTkksfdJTgdpLztxj8mNG?=
 =?us-ascii?Q?+Xc4dhbDAd/Yiki0jf+zrx44/fgetHAGCUv3li+uvxLALAyF5IgrKetYSbjq?=
 =?us-ascii?Q?7m0O1zwgeEqeTsfPLABLNAzGwndIjPHyxBe68PeTdZqLCCXvgXa5ZYQbpWM/?=
 =?us-ascii?Q?pQmnL+OzzsevpD+AiIwrhq7Nb5zFCiq31U7m4nHfF0rDfVFMC9itoXXoOhAk?=
 =?us-ascii?Q?AIs103zLsa/MK9TjbyyjdMyl1QOQn8R1+seQ9dA1gQ+o40dCeGU+FcObae8u?=
 =?us-ascii?Q?1ZkrnEug7s09yew9AA9tn9S4EoLyQxRQgRrTXVM4eJR738bvKkQ4701zkmjZ?=
 =?us-ascii?Q?CLiTlJ3aP6xHb3+mB5ZF67Hehv6qyCyLVVyyqRKK4baUJP0j5FpfFlhxxWrz?=
 =?us-ascii?Q?g/le9eX9KMa4+LTpu7n103VxoG/V08bPBxK4q4P5Inzfq0b86ShEJif1ITx6?=
 =?us-ascii?Q?ijaQJUlHoP2vUexSk7B5PYO9NV5CmKGyL+8yF8ik1iTtF7r+S7sJGpOmxf6Q?=
 =?us-ascii?Q?TTO3XVDer5qWbS74cPoDKr4URn+Wx6DTFsgbgHiMJhiDSJgjj8EAqcP7OgEa?=
 =?us-ascii?Q?StIQNKHLBT+JHc8MOjHi+sT0gy6sZy46N2XDDrN+nzGglbMUOsumMFSgbK4A?=
 =?us-ascii?Q?rqPeBqaq0dr7936fsdEnGoSXSSvPzEmsv1crxyjXcpFWh9pmfqq9dZJGM4ia?=
 =?us-ascii?Q?VITwojpvQDALFcoNR287xoeYpzlhFo7ohvu9x2P7l4fgSvEsW3FgPqPAkcST?=
 =?us-ascii?Q?uo0aGQjLtdVy0qLdR0eAdHZ1kJWEBrVL1jiPY6KXoQb3g3IzssYH5KYzHvIw?=
 =?us-ascii?Q?lrAALTs8i/TTHD6pn0ECubYhidHSnbahIBonphdTKGfs2zjoOtonMQQoKgo6?=
 =?us-ascii?Q?IsZZeVX/VpAIsheHTX90O8tO8rwc/VwFgaZBX9AGXqGut9P4ASbBF5a9U6lh?=
 =?us-ascii?Q?YJuTrRemyVye9i03VKpiBqGm5zvQTtAbH2Tyx5fFXj9UQNQrXh4Poy1H0LKJ?=
 =?us-ascii?Q?djmxxfDiczCH/gY+orFburDfvjbVSfxPGdyR5HzW9CEhsKrIun0yEJ5jSbj9?=
 =?us-ascii?Q?NUy0qLe/ViEOG+d3rFMUqBiVazvrvY9dCmEt9w3QFoL13Yxv0YWf786z0iUl?=
 =?us-ascii?Q?V3ZvtQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zJODlu1VLk/wm44AMC1aheRVNedJoPWxmj3mGsbuuyZm80rEMO+jqv+XE4UF6m0gJjM8C6sdWOy+y2kRpx2qKK9xaX8U4Cc97AXwJWdtXa+QlhbQ5h8KzxxVMJww1lReNVnl2SdH01sdbc4VKTgFWfCJmZaK2MHPWGJ3l1LN6wg9hQnRdjVeLw46cRxwzBcxQzq9kTtEEaQRcmpV11bKdJXMa0Yqi5YRx9jP1QRNwqhSOogccE0UR61z42PTNx6q+jvSO0Dc+pEsVywfL+0GXTKmIVtIpuAp2YDz6NT1/bwCtjPcNITTQlXSqXgtQERAswkvmKw8jZ2awC8PCaBF+6b3essg0aYkJDV+TYN8xBR0zsbhHn+OLCC82pkM4kGmOc3IM1LJWl+b58kNCUQ2IoIT2olhwLBTBJzWb4EIXqtjFH5aQUYaDnvDN4yeEy4T4LeF76/WLuyJZv+vbDr/y+lt2dzRMa/8fkE4McgdZwstNmJeRXkKXhPjZB7ubOjDKDR+fJJKStmYxPDCl768nw7dsJmacGppwlKgoTd9O0G4PSpRQkRmyNipMv0dUGW5HkIsdpN6jCSCKTX6VOqrgZFoH111IjNwzpRkHINk6to=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c239d18f-3974-4b96-16cb-08dc403f5d6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 13:46:47.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwF3vDaB/8ZSx9t/HqHxzODND8I8/ts1MYCbxUmh7LR+ylhLu5piqAlbjJ87htfUWqjb58J/i4Eb2Ja2WoErJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403090112
X-Proofpoint-ORIG-GUID: 4X-mJ_lafEkmohoiYsN9nAFVc_RinBHp
X-Proofpoint-GUID: 4X-mJ_lafEkmohoiYsN9nAFVc_RinBHp

When attempting to exclusive open a device which has no exclusive open
permission, such as a physical device associated with the flakey dm
device, the open operation will fail, resulting in a mount failure.

In this particular scenario, we erroneously return -EINVAL instead of the
correct error code provided by the bdev_open_by_path() function, which is
-EBUSY.

Fix this, by returning error code from the bdev_open_by_path() function.
With this correction, the mount error message will align with that of
ext4 and xfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bb0857cfbef2..8a35605822bf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1191,6 +1191,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
 	struct btrfs_device *tmp_device;
+	int ret_err = 0;
 
 	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
 				 dev_list) {
@@ -1205,9 +1206,15 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 			list_del(&device->dev_list);
 			btrfs_free_device(device);
 		}
+		if (ret_err == 0 && ret != 0)
+			ret_err = ret;
 	}
-	if (fs_devices->open_devices == 0)
+
+	if (fs_devices->open_devices == 0) {
+		if (ret_err)
+			return ret_err;
 		return -EINVAL;
+	}
 
 	fs_devices->opened = 1;
 	fs_devices->latest_dev = latest_dev;
-- 
2.38.1


