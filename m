Return-Path: <linux-btrfs+bounces-3063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9240874F70
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 13:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F098283FFF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FEE85279;
	Thu,  7 Mar 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SuKnC7aK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D9YK96tb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CE12BE93;
	Thu,  7 Mar 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815856; cv=fail; b=b4OrPY8h6JlMbAmIWrKaT9zevBkqhSCf1Ol7GknFozWyWJAOkdZcjS1wEvY7oYtW+QgoUo4zBGzqcuqv3yIUq/c7P2U35dygQHZTBryoLhyF/t76A608LBS8ZDa6S+52YvWePRizI4xVN7fzpQ5zzA3z1RzXRgz7bUBgMrHyU34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815856; c=relaxed/simple;
	bh=MtSZynjNPbpDwVsYloX2KljUExcZX+jDx+0zif0eANo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGb9IWZNbRnHFLqsGymWwsrH+rkkgrB1Ej5kPVdllqCN20U8oiYk2uZkGeTP9hkFUVYlhH79SnLWtFzZiVMkFY+Lxxz2JOsQpTVBsDeAbD5+ieORir7kzyNSkPTOB05FeARDTYDJtLJfNFXW98IH3xesO6y4N0NIs6EMD4CyyAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SuKnC7aK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D9YK96tb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279n8Wa020697;
	Thu, 7 Mar 2024 12:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+b8jiTOfPI2uahfT0kdmIEWAG4vsuy62ALopluA9WtM=;
 b=SuKnC7aKfYZpaHsnVsirOr8RU3Hfpm2fyc6FUc4deRlbNcHbcaciX3ojJvZaUpV1i/RG
 w/rASSDiMZpqMfQN+6xZM4cXKAdx0UlrrWQiQUsJQ5SiPLjFmKm+Gfl+ZDx94w43Aa61
 F3lgwYpraLLseQMxVWUp+OBs21kXAIqHh7tN4AQg1B56PvDWASWTLbDpeGKVbCdH1Ji7
 xElt62ekZP5necbQQPjiXJFA0S6UrqeLtLTxBEthlCJ7UKUXgxYBc+usGeLYr0XvITBD
 onfMeDIwwoWa1EeZhq5GqgHutn2lqyxkG2JB2hL3c3lRFJTH+DdDPIdz6dNVXqn97Juw UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4bsue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:50:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427CaEWM005185;
	Thu, 7 Mar 2024 12:50:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7ntr3mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcFNcN5ohwom7pE2lDoZQ0QlSWNnIS6/ffOyNsCXThdsqgM/YB52ohg0YABmVrn//b9s3pBt6EBKhNqnD1WXaCKsL1V6Wdr5GYnJa7BXZpSg1clxrzilN+oZP0Ufj/WQvg4jf4PICZ5rDTcGM9LJl87trdQwyr6jzeDY46x6dfbsoFkWiSxIlbQNSjW+fLAJwD8wUTUTBoXlmHlQ3pfi4Ttv9qeBrUXKO30GRO0mNkaZYpCfM9+jD5VwqJWVILyCSUufH8bc7z1Zj53RoZGudoeln9I4l7VkK8XOob93o9GCmpukoktjIc2iEEURbwr4FFmWygh5U2JthDosF0ZYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b8jiTOfPI2uahfT0kdmIEWAG4vsuy62ALopluA9WtM=;
 b=dJStIJrWKNX0iI7e8B0XIw9PmnVgjFlb0G0JL3d01qYYKJ79I+9nJHCZQcg5w81AVh5l6A1pT3E86jNixZx7RKwERa0bx6ucuglHaEhHbg2WPPDqd7X62vte9DaDKs1QLTmpMy7BnxnMUdA5WCIVFpJVlwlrRWwNW8YKBx6MlWvMU3VUsfogwB3OKWJh+j+70gjJuGuciRh44u3DJieh2EEU0WiBBSlvbgmTW1d1jW2ghNtDVViHY69XEQe8rg+PTmGg+ej6iwu8kjK1Hk4RTVCId77e27JFhjxk6M19MScdVmTCI255e2RV+5ABFE+zT37xAt/eaB0BiP+V6mJ3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b8jiTOfPI2uahfT0kdmIEWAG4vsuy62ALopluA9WtM=;
 b=D9YK96tb42qlJnFvhgqywp2MyucNp9lZc8QEp8hMT1yVkaEo5DDyn6vPd0lkAjc1w3H23Kwp2RNFMDmgyFh2toEgIFARaHX+GvM9NTR+uI7IF4G4Tb387tRrXvGjnPfKUiEZAc/HHseS/PYX3p1SeYP7hxn98dmoQ2Ie1L5ZzYg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 12:50:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 12:50:48 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] .gitignore: add src/fcntl_lock_corner_tests
Date: Thu,  7 Mar 2024 18:20:22 +0530
Message-ID: <d81464d8af573126efcc0551f80bd9968a38ab40.1709806478.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709806478.git.anand.jain@oracle.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9fed62-c949-4b28-33f6-08dc3ea536aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2Kn369PQxnfOf5sMjVSxH863MLCsvcGimTiKJ6UZkeZ6UvihQTNG1idAvyrH1aNZpf8H8hL8QSVhVfRQjOsgSAEll/Ur9ziBN813B+QoeKumSHwAmo3W5HSFoLwWfgUhM2Nvgf8+mn/ADONyXJ/27Fi4mSU3606MuSA30emKtf+ydocy73CxluJSJqv7hu8LRzPeh9Cg5dKDFQN+t69QhlpIPhsybcWYffooHfdVgSLrCcuubouRAoXoq0GTnf0ch7R0t5fpPYhP3o+ovtC5fqp2E6v78jz2xW8dnbXM8wxi6rJpY0OLYgwoT0av4uNuCS9zoRXoxm7zw1FRBGQaWGlYZTlJRU2XEEsNjDv1iWLSltFt82ZuST70F0JJhgSlah+QptvnaYt6a0+v+xRK82X1tOdeuAYFmtdRDSyjJ4YhjLVhQ4mppjFWsOFTtcDlBD3qddE544MtPrE5+klGWtCDg/+E4NfjwYEMbFUAKsTQP40HvbZz6pUouz0DiO/+LhvvDGJxwAAgpQIYhv26YTD3+X9tlZs14eYTigjDL55zrj0MahLKyG74j9WatJ9ql9Qw70km8rSa9izYCzv6YdTqRPBBoc3+iUM4DINvqvaS2wunqytRJc3vgJGTNXer1Z7CPdaGafXktCUluRfbNyholnFgTj7cktEYCdx0FKA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lkhhnIKRZYZIn6ia8DX8j43zOEJ1OFJsBHIR1SGofaT3wZMh9uzjNxZ9DVh7?=
 =?us-ascii?Q?iPzriHQl14BGTDr5v5+vC5UYm7YDge2/8PzwGTijX+qI8IXzJH5rPpYC7ESc?=
 =?us-ascii?Q?1mTqYhX9LVz0GScleJV+bNLuRts9sgm1p6febuTFpt560jStaa8lg1MhjcsB?=
 =?us-ascii?Q?d4A8k+pEJlq4/zYpm4XcyfMuZ9sC8CSirmF2DniQzO8P+/z2OhkvSfJXTu2T?=
 =?us-ascii?Q?Cqo2IvpJpOTclwcTUArHkB1B7DsGA7PmWR+Arg4Nz7I/2RMfsYnWXJ9OL4E3?=
 =?us-ascii?Q?x4bQNqKXJhyPjr/EX+YIIpTZ/UHtoC//emfqDq2k9yt1jRA5rXq3o/tTjWQB?=
 =?us-ascii?Q?kmNU0hMcYRzGq7XnDWhyVMz8S8vJEFjEkuicb5ze02SffF2icdlKkc+3tCRj?=
 =?us-ascii?Q?jolRPuidP0tuwt/7pdGYy9yaGU+YCbO+7L6h2HiVlvzlSqamTLdJA54dJ9OA?=
 =?us-ascii?Q?TvWwekbA3ZebA8cJShOjba+2/7OVjnOu4UmSN4WJwlg/oW3rGC+342GOqwvX?=
 =?us-ascii?Q?nlqMTtQX97YYGcpYBzbePgXLbBK+hzMzrSEbBooC61UGIJJE9Xkspeii+8JU?=
 =?us-ascii?Q?Q4zQEXWFVCJmUoTTXa1vlVJWFrUIQapK4jXb6paG3pwXEUKqS3lH8ZhUfY/u?=
 =?us-ascii?Q?xlc3ozMw0QqUZdeWH0NAePz5sDr2G6GX5rM7t522T/YeEYTdlBu98LdhY//6?=
 =?us-ascii?Q?4a1ZBToZOoOgPvWy1YhtOjNZSyp4SSJoRrWmFvdQsw+osEmGoANIMDmwSp96?=
 =?us-ascii?Q?FgGwIFEFsbx/bC9rVoGO5SiRZ09+P5jowCjRWPcGLyBFMXBaT4bCSk0fwiNh?=
 =?us-ascii?Q?Gm+iSS7h88grThJZsGAXEHyKfCc0ZKKXu2amRkabhRk/4P8QNouXAzQeRkJC?=
 =?us-ascii?Q?T1+7KFTI8OsJRvdazKDPLXo1tu9tx9Aue1/kfHfeXmlJYTh56cxJdu2B9SiW?=
 =?us-ascii?Q?2uSqjJvOpcDyY8aa6CvQ2REJVTjQOG+P1cTUKzvaaRx96qYyYnqKoXcNBcLU?=
 =?us-ascii?Q?4XXW2ECAdcbqPviAM3utQdbm4CFqqq/QQP7aoD4n44htanQGYI3ljG/bEMXo?=
 =?us-ascii?Q?dxRiwuHwcihGEj8nVnA+M7k8525snwqIVS4GoxQC6RBuP7QLSvpI7559AjQC?=
 =?us-ascii?Q?AoJiUcZAk4CY/sk9ljLeYmYSQQJk5efV87q/gqb9ZHUz7j504OqZXfRAuoxj?=
 =?us-ascii?Q?VZwAZAF6VsETvmWHjDmz7oSEYtTl0KWpoBQd040pRM9QpuS/Nm6B7SCYwCwh?=
 =?us-ascii?Q?IWt/B1aIPtxmzXEreaFp28aoDH+WvEMhKvd66Da15UID95OFbdJod1/75Xid?=
 =?us-ascii?Q?Z2XlZCeUyYII/R0Fxcc51ubNca/0NnSsJNqGJ60fiVvnkOlRk8C7uEP4o8fG?=
 =?us-ascii?Q?R7w9kD3Q4QBKqrkoIdGsCaKGjEVEfYHAprVZ2vGdNZ7Vux9gKUwhqljslIxo?=
 =?us-ascii?Q?PUNm+2zpnGMG3AvpCEzv8wOqe4FrKhKtDObpYg1rTabvpZqRkY9G9E12iRrR?=
 =?us-ascii?Q?uS7p8sASsVqiGnw8Td1xgluhY1ILPvkT0qq+M/7Cwu8R6Qx3/QDn+I8NFuap?=
 =?us-ascii?Q?Qt0EV7PO6xdA8oAfpcDEMswg3gm/Ecp2EPwgAAIB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c3iddIsCJb/cgBLWuxoaost4ppaI0ZO6VX71WqzGvXxbfMoDwU7N9vfKsN7udhcdhiKJiNDb2H0lkvvYCtKxLTiKgKSPC5xr77rOSCsMs2e1JUXDkhz4OkYGDoYjcyddJbbA4DDxikkA1zr5ppfQIHXVb9Kg/K4/KMjUIs/qsK+361jx5IZoCA+C/VMo2/f05VY6Od3FNky9/++XFUm5xKfLyIm6owHp/9UVIjGzj+isAnLq/tvMcDKyAd7zGlS2KVViRXIXHF7F/F1KiVa7FTUoeTr+ycx0Jp85jr3zjhMkFw6uM1nLYxVk3pgtAxR8UU26ItaxUdoQL+geChNQY/EuKSBnihqSpQEjyor95sixJoRZti1rCVxM8yTlbFoc/JpOkuoMlazgtOJrJWAUdx/Riayp/5qtVtajnLdUzSPPcjv53ZoJZ5+CrXbsKMqYdVMm4ePBFtH8wBGLoNxsd0ve6VQr/hsbu5caVxv8FiY9kfW0oMx04roidCNKPMaP+qO4OWbrxdRn/fjICIJp4SptPg72FLMHQtlDcO5FfAGoTiMoqyhwUy9LBhFb8I4KoAfQB73lRpkrEMh+vVXHD6yyv8VyiJN5SPKnWNE5fUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9fed62-c949-4b28-33f6-08dc3ea536aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:50:48.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVLkgaXaLPDPZZpDUG6Yv5qNaGOBPGiei24cs+DE40NyVcL4pb+zjVimRUaHMMla8oCRPPMUc4S21e5msZgroQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-ORIG-GUID: LuBa70VMop4zWfEsVTic2zpccLpBZ2xO
X-Proofpoint-GUID: LuBa70VMop4zWfEsVTic2zpccLpBZ2xO

git status reports a stray src/fcntl_lock_corner_tests; bring it under the
ignore.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 3b160209ac03..574aa9e8c1d1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -93,6 +93,7 @@ tags
 /src/fsync-err
 /src/fsync-tester
 /src/ftrunc
+/src/fcntl_lock_corner_tests
 /src/genhashnames
 /src/getdevicesize
 /src/getpagesize
-- 
2.39.3


