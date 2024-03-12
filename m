Return-Path: <linux-btrfs+bounces-3224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302958794C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 14:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF281F235C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7D6997E;
	Tue, 12 Mar 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lEvLk0nS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L1ngAoTO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A607811
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710248673; cv=fail; b=AAOzDxYsaJ9mHGvpdUmmtfOUIwZndYA8bzAj04Ct0JG+kwAaAP7n0i7S+7uH3sHSpOPHE1aE0qpO+TzLmf/V/xIgSvpZOz6Y72OQs1XPQJ9I8k8X9/k5OyHUyzHjc7Vkj1XO34fabBYSVPTgB+XThGavK0aauVnX5z0/Rxt9g5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710248673; c=relaxed/simple;
	bh=B3DNJvlbQx59PJm66g5lqnZkFfs/9DHgwv9blwTWx+0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R0+XeLIiVViHTmEnAt9iXFZC9Fk8yATn0pVq5xeb3PXjabuSrRJMANmp2mVNEPuQQX3C3UXO6zvthcdmi51wx8yQmqNOXHul5v1azUCGb0K/pkuwxdttZW4qTep7XXraLsvSy5nNDlmS2a9q84EGCDkQfd2AuFBlK8VoVwzg+bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lEvLk0nS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L1ngAoTO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CCZ02R010161
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 13:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=pgIgZ6bapWrTGX97vm8TuYHxMe8EULr9cxufU1If++E=;
 b=lEvLk0nSX69aUgiVrTS0DLNl7aimYZe1gqMUPV0dWpMo4tV7tmeWMFC4Sn4SdYS/c0Iv
 RHoa0xB6u+Esjnmnt5rnYslZqRH74Ii9p3LRzRuPcAqnFo2bRpn95XiSTRXfPWKJXIUs
 0P4bNsdil3xPrWIn5F+vxl2yUhw1CpQD/RnKJRhy34bt6DVMHVxrFCyMoREVX8/wbPIx
 iJT7F0TmsEFYHK5824sdoPTO+Br/XrWTSbbp5Q5qSA7dl9AdR3AipEjSg7Edtb7Dmlr0
 tQxyMfJ1Kgrd7YMlCW+FR5VquAvvrcKxguqDiOePuN184/faOIbTkikmmWE3erLcL3tZ JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3wynd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 13:04:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CC9Z8C004777
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 13:04:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre77bxjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 13:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs8g23r2Si/4y5rFt+GzFNAiYmWFFgOsYDCzcNVzQDpr/+UeNbX2+xfsfwn/W0Sxl/iolMyfzQ/p7pAmsZFyxCpJofujbZWl8VPuqdko4fsPOOsLQIeGVFanlHE4cqdzNNh6SPhdAktlmD1s6zma55hMi1IL2HadF7VxnFHRPPgtq0IVenzTcmxdTeTNwbNsuRhZjKjSzF0Nb32vJ+YIrOyBnNA8+NUYtjbJhIzQhsdNLaMivAb9elSObTv4WOkPh386rDmH+r/9LUnJ4Xan7DGCRL3XoxNFpHo3fGXwazNr+4JLAHV4N0M9L8JpKrGDmxCVhNFG8p/6rvDLWgHHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgIgZ6bapWrTGX97vm8TuYHxMe8EULr9cxufU1If++E=;
 b=XYEVLhhrIIzi6eJCh0m/1u6fGPoPik8eEd2SLo0b8Muvg+2w/HKAKgeeFEx36J3b+l55Gcm2b/iVA40ieGPQinB1ZnoqVwureY4cj2fg1mJwHsTh0TtNJm9eD4XegPfxzTXOzzNSNt+Ua0df1RgW+liqQexRwe1bnhLVEndiDuMpCpkA28cApPqfOfJJJjTsGnpbF/UfAOxUEdf5xzg2UBnf1obX75bzDMURwXmadOn9A6/GXove8ROvyI+i3tbJQ3mfhUOkEJYyUCjZrdmxRzgwxkEKxPex8whOezOaMmKV67m76q4niE/bdfTS3X208eLw3sl/Ej4XZG0gT4iJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgIgZ6bapWrTGX97vm8TuYHxMe8EULr9cxufU1If++E=;
 b=L1ngAoTOYrqjdt6Rg5sCA7LL0vRvgixqP2Y8DMTFJcx/Av3AxwAQuQi+THCfUw4IOyMJ3QATHk45sCCzMPQp1hBIT2+Dxo0B7+yJnz5iMSRSRED3I4MA/CTh916wrYsd1wHfOBjwv5mlN+NcjpbouNZRcAD/Dn74WQKeC18GmT4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5626.namprd10.prod.outlook.com (2603:10b6:510:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 13:03:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 13:03:25 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: validate device maj:min during scan
Date: Tue, 12 Mar 2024 18:32:41 +0530
Message-ID: <ea6a2384807500090943f95c164e9f6b899efc58.1710246349.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dd4f16-81be-40c7-090d-08dc4294cd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9gaawxubBfK0BGzNOIsJzftyrRo5VzjGOPFhtjLFNUJnoMVeXUSmXwoQGaeuffgn5yARkff1X0AsmkNH5qreb1RR1pyby7rdPxicGDoQ5uIIeH4wjeTZldnL+YlG/tmt1Nrd4nh1vc7E5eWknuk2juQgFWobBHqoMtzsEot8A/Ttj/1P57t16/wqaEBkCQReG1zaKrmAOqe3xq1pTQMNlm3sun+/d5pPJnFv8l8//s2jRraRS2BgJdAqdgOMSKwgFfBMz2r13x+XkntT9CrvkxRouPqFPWMfggXzSi0+baCYjpVguKA1vR4M3kqmzmrHUbKCCiZ5GYtBlgJ9fMYQXiMQnjRW4ZLi3ZGkxsflTgSuKwd+ZGfkzddU/L3W7yo6zA3IngDtOqDDKue0cG1P/YjgkIMr5zTs4HL7nw8hiPIBm2ZVp/Dv7Gps4K3ajF399UV5daYLMhcURR3EzLB0Ije/pZbC29kcFBZVjGGcnLmTPA5d9TXTX+TwPFTaetA2AmBTE/XCaGC3RvYYw7F4kWoIu7BNn0AjaAQ60AqDEIj+/BivuGaww7ZMK/MnlAHXY5osalcQRuDw4hfA8xux7BPytKTReooj8xL9RAgdlapVzBVLYodGgHwXBr3/OnIVfSE5M/BIOMNEstMscERGaQIO3ajQ6m4VAIOdqisNTe8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IslYWURXKx4ck2PB0yAI6263jOquOQZYN2czMJnyjVHll8aiKT2EM+9Wq1LV?=
 =?us-ascii?Q?RzUZbUJWOQvHsxz8DjyUhBkZg6plBbsfyyPuryO3jHG+agjClA9Ds1aiSVK9?=
 =?us-ascii?Q?R1n2U0j8QoavYmQFR+d3YI40c9K6bnzq//dAf/BiRjk14ljM2Nhs3MMnPJJ0?=
 =?us-ascii?Q?Utb5G8rejlgGfHTEE9EbkWudzAzxIl9hzYoCBgNLRviAT3DVNrpwaFyu8rC7?=
 =?us-ascii?Q?dWUPuHaWAJYiSD0Hkv8EugYKNMj/aOVoT3tcim6Lvwnkt/qvTTp/Z051jfpt?=
 =?us-ascii?Q?XfkPvgGEL3LbJG2Xw8K9kJPXmvPh92963AcyXi/K1MUMBG8T1dH/xYomc61I?=
 =?us-ascii?Q?09tKxNMZwj9VAjmbGJQlBKaxAMBvNhD59MDtgB3mWgGoga5sJImIERojp2cE?=
 =?us-ascii?Q?Tm7/2EvCeHtlqs38O7nwuHqVe/LifkFmMuipinBN9knf3pjk/ILIQlh4sQAm?=
 =?us-ascii?Q?5i5Xp8v6Dq8yxWYife96Jsc/kVsardXvMw1w/okuhkr2izxzL/vEHJ/igLGl?=
 =?us-ascii?Q?L4c8khpdkwT2iuVwuTiue/eqxhXNuKWPiI6OxVkFGJmhE8rlvo1kL7IHA3G1?=
 =?us-ascii?Q?AOyMrF0MamM/NCRzaQmJ31l+CxeQX2NsN/3bTCKbhT+2dy0nJBmlZ9DeIieB?=
 =?us-ascii?Q?y3EUGiVMndxT9UmUU7pfzY2SOBOK2oc2FYPWhiJqPgE97Yj+RoLKiWUpjFYr?=
 =?us-ascii?Q?L+5YlV928Szj+mSXU44TNFkoPCws0Y6JguZ+XdPteMl8pOL1rVjHKV3Dsqsu?=
 =?us-ascii?Q?FyRHRzXYbYJBWofmz+gvm/JRK4xpA8OYH9GBJ7TbqlfBqkDcJKGgsfdDOXVT?=
 =?us-ascii?Q?EPGL1oQLyarEj2dyajUGdMV6DNzwmfK384FV8b3z8UGCEpGFeV12cO/uFIMF?=
 =?us-ascii?Q?y8D10S060zJiPfbINE7I5h0zB32agRbOztaam8MlZGEgJZnLSBpI6U/gM+0E?=
 =?us-ascii?Q?ebgswQXe4iDBP5119k3/CbjyBSqA3EQTXgG2YEY2Jamb70vTPQZ3AtgrZ78I?=
 =?us-ascii?Q?xkkvSJ2C8T1KwpbziqS5Yr4tJujOgdrS8EOwCv4jeFQaw2Eh9K7v/2mo/gLa?=
 =?us-ascii?Q?BWkr9672RoUvEQTKHsKhgqZUn7MPhIzEyMNQo+bSC4HD1/nqXFdssYGVNfQx?=
 =?us-ascii?Q?dJsqxfj15va+BH/ykZG9DJCvquZf/1DfFxaS1T9+IRvYHBRMBPE6BtknTOag?=
 =?us-ascii?Q?6oQlSzPDyt6armaoqEk+EoE6Io/hvNkJteRbxKidmYn8CR2mNJeXYc31zfe5?=
 =?us-ascii?Q?segR/wMy9psAc/cZhJTlSAtx0bA5gRsp5vwnfEEwykyWH5gSTKjXbpk/lIho?=
 =?us-ascii?Q?OeTGtysDorsWqPbJedQU6sf519jMmp+j/fjsDsG4HWKJnEix+U399Y8KgW2s?=
 =?us-ascii?Q?YglsL1b41SpXCq2m1xZ6ZrwAcrk/1GiddQkWxuOvK8Ihmd3v1LNhz90rs/sr?=
 =?us-ascii?Q?OHKMeKjUJ01yzdmB/0ACzvTe76Opr7SkCczK4k4S3uxdB2hM0ztt1CejbHph?=
 =?us-ascii?Q?cDgjepfVGyWU/i3W94g0IPbPHpIqHGxaoTHro+cjG4uH81xhOd3TiZNs91P9?=
 =?us-ascii?Q?R6CQSULfR5RDR3Dr+pZwztNMGmGFUicrzNzZmCe5jh5Zhf2u+yFhEHC2w4IE?=
 =?us-ascii?Q?I4qtigupsH92/HWTsnlXzvQig3j9ceepkVvVdFgS8Qkk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/1KejoBIrtDBFevSS8ZmVQasVv5oTbum5hvZ2MkgxQ0Cm4Eeno2EMQMtXTfTFqs0bwCRcp4hZqlNiNPSfG2xXy7Z14tRTVOKSu2dCbscgrvG+agSX5+V4kQvyeHe3388RxEa6Rv7nUFOmwBfLsYcgecVRGzunkJ2foDQdbZm4vJL1VkLTys/nqe8wqiPjNLjCaPCGOP5DW5dkTBQw5cbDMesGPub/Nz6fXNSdZejf0LaoWrGotzXSC3He7ThmvdU6EbQfinBfq5CAEGHJ92+i6RmeZDPd6u08ngyfssHzivL1EuRHah30CzeuYFUeR/lJzVz0C3mP/fNs6WAAiYJh1Qo1pazVnuPBHywY+swav4R2I7mumLBPX84TtoLm+lI3hAvMJFxO3XRdSdGGgOs9mVqSCAKFAK5Z2mjK5ZGqbsSm+bD8oVFN4QzdFFDYO6CnJ3wakhEss02/GWq2FQxh23aCAOEVuE7ay1xxb4exnMMjx6tvSfu395rnWMMpVBTawA07C6aj6eSrrHMqPwUyjMVtQwy9EAcSCKStIRQs3SBJf5UrPcHtHXq5KXUqR36H6kstNGKwu1uBerr497cy+14ETZqyiSUFlTHuxi8gLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dd4f16-81be-40c7-090d-08dc4294cd72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 13:03:25.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zxz3pPpuRA3Vf7iibj9+hqesUauYNXz4QfxzDwFGmgFe1c0c1cJdt2XcKEQPKxkZ4CYBa0H8M3FvTS7qYyWyzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120100
X-Proofpoint-GUID: FFPNIhbeQ8oeV6QNSrNQdIlscNAT06LN
X-Proofpoint-ORIG-GUID: FFPNIhbeQ8oeV6QNSrNQdIlscNAT06LN

The maj:min of a device can change without altering the device path.
When the device is re-scanned, only the device path change is fixed,
if any, but the changed maj:min remains (bug). This patch fixes it by
also checking for the changed maj:min.

However, please note that we still need to validate the maj:min during
open as in the patch ("btrfs: validate device maj:min during open") because
only the device specified in the mount command gets scanned during mount.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8a35605822bf..473f03965f26 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -854,7 +854,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				MAJOR(path_devt), MINOR(path_devt),
 				current->comm, task_pid_nr(current));
 
-	} else if (!device->name || strcmp(device->name->str, path)) {
+	} else if (!device->name || strcmp(device->name->str, path) ||
+		   device->devt != path_devt) {
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
-- 
2.31.1


