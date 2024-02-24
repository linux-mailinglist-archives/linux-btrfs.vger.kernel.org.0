Return-Path: <linux-btrfs+bounces-2710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191C86260D
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0CF1C20DA9
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDF42046;
	Sat, 24 Feb 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fEmTYB1U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z2g3hGPc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC42CA4;
	Sat, 24 Feb 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793025; cv=fail; b=jHDuwY+/j1WdWm4oxJ+qQjEFtlHFUlQF8549uqdrO1dFhnC33D9v+qX2o3QzmUFz6TsI7KF4rdqebDJV0IzN16jUAAw4QfyOWpXRyFqeBywhGAOKSIRLT8WU9dbvcLlW6oy2yig1Z3cZ5Wxx5bHpfbPzCQP5A5W8S1wQR+OxyS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793025; c=relaxed/simple;
	bh=gD9s5fk+dVv5GiZIUv20kynR/5GSTosp1+tfDpgrxZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cnj3WtRL52wbryfcBUtipGStpRkFeRFMwo0aT6wPGmzHcumeZ5fCgfcyrRwhhbi5k7cdd6WbfEIZ8eW+rk1qzYB+5BBLVowy/gLY4eQDA5LUgAUkA01dPau3SV9nneQeh1INvL+HpMAvtjNTCVFODba4yb/A6uEGgqtgzS3vvI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fEmTYB1U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z2g3hGPc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFTZiZ031092;
	Sat, 24 Feb 2024 16:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=iNi9t4gOB2pDjQ2dR4dl0zo6SBnM7BDbbTl6V4xjhcw=;
 b=fEmTYB1UFsO/7y95Pshga8HiXbNoNbTJMd5Pd5r/ROhG9RWDfQ3yx82nFJDfPkcGo3Ze
 AQMXavxvBee0c3P5MDnNGfJs2G103aOAumx8e2uqIZi42RtAFseJeYFPNzEoJAkWpnEK
 s8nJLygZDQvh95037LRcqF9KupYInvqmihWuStXDFuIEvNQYFL4Xj/oRAFyAW58HP54N
 DNroogu6ShSQBAW2viDfdXXxztshh5lx71jBhwyuKFOBmlZxJpBXY9RjwgIbhr4LQXkG
 JHHyrsG8pAvb3vmu8npMdxRsxPZUxFnuVNmARtbTdlMl4Wluj8EbhSOlpxjd+2w3vsFV LA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bb11je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OG5F6O011751;
	Sat, 24 Feb 2024 16:43:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3sm0d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBshfUTbywIyVj/qz07HvM4ty8s22UE4zVZTy84lSSqoz0sBMrL6eOhC3xCGBbCMxpXnmkElevxDjI6H6yHvJk58DlLMSt6QNsVckJh0GuikqcAudzirZazq+tmcq8/67i+pK7ocApeD/JQsGDt/GobBkaY89lNAmIHT/AG3hR2FwJDOBlp/0Qy/MwgUXPTiIHZQzhhTGVhzukfvWZ8Emi1sLRG80LD+BaVb6e+VExvRnnSTugs+q97K5TNSKCWTYaJdeBmrt0tlD83WmwkKtKFp1fqErqmDV+R8/uSXcITrU5uvI1jobgxAqZcb+FQeMWywK7gYWSFNffb2w9rAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNi9t4gOB2pDjQ2dR4dl0zo6SBnM7BDbbTl6V4xjhcw=;
 b=A2TMhmvypniXyZgPZtLacNAJMDB3OQlpEuHzSGId9ZuipQn0Pewn0t4mfXTM0p1YjTug3mUQz8k/Ap0BqulZ1FX7P6wkyoOc0mAcbLpBlClukmFI2yRI7gfiHS7GdvRsOCP9640Va+N4WE5PHbcbRP7kP59c0S1M41NLJNiTNP/gB0MHGWrfZnogPURh4QM2Hes4SaF911t64J31ecvxmjBvirdpnLrbIzS5dioipsWWkrWCJoDhe5KrjcrMeiV/xHWdRD/FJSEiXI9OEYjhRhZLYo/YmyvoWk/ZcPZkYmEPEZmGJ9YSjiCuM5Ucp2mwVxOOhkr0BCrnjRAuYqqHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNi9t4gOB2pDjQ2dR4dl0zo6SBnM7BDbbTl6V4xjhcw=;
 b=Z2g3hGPc7vzu4bVfjM+FoAlNZmEHXUsKdPLWmnUkzHwkAUuf9bKm4YK7w+PgRBxsydO2W0P8P8LIQWfHBO1xuAI6bSmVFih0UhysUDaCeEzMdMYu+3cBTnQp7LSAeL0vONgtGr7hlcoCBl64cXUlLXSn0XKaBc1CpM9b+9U1PeA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:43:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:43:36 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 01/10] assign SCRATCH_DEV_POOL to an array
Date: Sat, 24 Feb 2024 22:13:02 +0530
Message-ID: <e590eac0dc13f8bd335e36086e6d385ab91e4ddd.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 934ea391-969a-4f86-110e-08dc3557bf0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dDmYP6uznTsI2l8MRrYB9xz/R8gXwkvLdvBHyI3Pw+U6rW7OmSCBUWSo+xhYc8Cy2lNKSGw0eaJxBD/E6f5cfyDHebcWX0ykrrwQA6G0DiDR19vSxMZhlFw9JmghGfdazwb9RlWLZrimLVLPHQuV5t9Krr25uW6NeVyIJ5OQrJxHmLUqM5blpjWBicbs0yBYt4GMN8i7mRrjDDeRo1kktKJptU/wMxNdaHPA9QeK60ctmyL63J9Hi8OpkmMUlBj1ztMir3g6cd+rBHSdraJZI0AnHbESiu1ufwb1mm3SxdVt5VN9uGh83sOzFt0V1bxVEvigHe4EDxZ/56yShtSKSBC7rV/4UzRuRYmY2t0HvEg7U0bDJLhxqxglZB8AO4Isd1nqaHV+mLQAA1Bsvmf+3evspEDMUTON4/pZy8paBVyenmAPfEM73wJws2ZKVA43JGTM8Hq/h9jk8Qyr/zmffSs2jHxif9hIVFIbq4JBh7fWrr3lZDMYmMbIM2SMTI1ffG/80RA55z62qdlOkhSA6GGwtIVD2zOLN7zZdh5fcxY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+FQvpGLbHNr4fL7BW80X6T6Evou2DRvBnRD6ZoFX7u6PO+76DmNaQ+7Ot3KM?=
 =?us-ascii?Q?wCWu6JjAMUvhYOAiHMtuoojzwFL6ZO9w7xvgQ6NNXZr4dEu9zrOfpF63xk4g?=
 =?us-ascii?Q?vFPeaDN9huzCyrCJYPNuj836xzN9TfF4nddWMEkkcrRGKNI5z8J/zCTM624U?=
 =?us-ascii?Q?PUtJosKgPmsE2hbMSNRCNzhMlcOZYLKpvCrbpkgMpwVRgrh4+A1Aa/V0/RAp?=
 =?us-ascii?Q?RKyKzCYHciVS28TehwZep8Yq/XUI2S8z+5uAbgiFcBHyZjy+Ce1ltX68cfYQ?=
 =?us-ascii?Q?tjlmgOqFaER8ZffHqv88Ysi6AL9h1lQd4ZVxJXvKcAYGXADhA0u2tky8sDDP?=
 =?us-ascii?Q?+kozD+W3zx55ULOwNWZJx2dSqWF5Mg0S50DpTFB37WAa6K0OKyXS5rm+vHcR?=
 =?us-ascii?Q?TWfLm0WXJ6+Vt1DXkAXIGwM62a8W7yOg/MmVnUwARz2PbXCmY1RywMmRhjeT?=
 =?us-ascii?Q?hHjRtI9NLJ5wdbitBhVo+qrRAz6nbi7a7afwbouoVRF5mOYTTretiltSGFE4?=
 =?us-ascii?Q?RXMJv0fQzrXbk74SkqFVzLu5ZbD0kAh0yvJJ50hW5yZFNHRuH1F8vQRYMHmc?=
 =?us-ascii?Q?FETPfXSLi0hAFmwubJthZUS4Tefw+BoaFqkgyZPm4ZcW4oJXLuufG83fX3QD?=
 =?us-ascii?Q?Ul/yLusrDzkFJi9fkQ0q8T78f30pZAXHonOmAIz2NyeG5pttadgpdAw4TtDK?=
 =?us-ascii?Q?EJdlKMOzhb3E7lpxtyCH+x0Zj2PoZBb4eD0BK04Fjixatg25XRdqTBABsumc?=
 =?us-ascii?Q?lEVQf47ogmjWYyH7SvcesiJ5xFsh6BaTbpMIqqvMuAqRRrVie8rPwUwHWrmX?=
 =?us-ascii?Q?SGZwGQAn8QAYWUvY7BeZV8sgnhpMEjjjcawi7cxICxnPKZSKhJEwv6S6iUdr?=
 =?us-ascii?Q?VwlN5Be9JXwzVqtIdCbxhogf0cTclOi06hcre9E+Ofj6ad8xF7PSsc/wQcwu?=
 =?us-ascii?Q?TlRxto96R/9wFqUc5ktmwA821ReFHzvDNwBuaokh+IGf0PYRDUdPgpvi56qq?=
 =?us-ascii?Q?z3MFvhNUCdfCrnYcpqSHjHRj2KVKYQaiFlmADxRvjna39Q0QRXA1EnYQuFaF?=
 =?us-ascii?Q?B2kLgVZV6XF+6ybFHYc7Cof80M2yHIG4Vlm0J5syKh1bQQuPyBoqz8wcqWGO?=
 =?us-ascii?Q?YtuQNBMV83dhw4hEjfxamT2DSNQ/3pK5ckvVHqj9dGP0QBBF8qoo+ajJmlI7?=
 =?us-ascii?Q?bPGfE/Vw7Kl7SmOONCK67AqbtsOd9N5rA9bJBRpJQ5DzJc+4UMKFZrkdoffI?=
 =?us-ascii?Q?7yB0EYB8Q6b1TJo+HiYx1BM5mKawBRE2Tz5uTF7x19SVsOgLp5zliale9OJI?=
 =?us-ascii?Q?E1OEbczUWQTOenOpuCeQPbFiucy4zWUobicgBbtEYNjP6k2pH6BqtxaNmLn7?=
 =?us-ascii?Q?l2sB866iKC7R7wPiJED47hiJE8VnuEuJf5yPnDRso0SSkYC3SIGgK88peZ3A?=
 =?us-ascii?Q?odzdTXFa4RtlAJx9jXzFZVQsAIfc4DFzEq10had2HYSriMdDc5iZPRZ6MSQW?=
 =?us-ascii?Q?JUk2IPxgvcD8spEhJtr82FJsI3dZl7WiMLgLEvTjdG/1/VWi9NEj7PD91rtT?=
 =?us-ascii?Q?juvqVaXGXEzrjJn8knKEynvEQ114VVqEaEiek+tT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	v/wPY7xhzvB3PH4ad4qWPvs4aYgeIyKPdZmL/vYz/tQBC3lDAtta8l7l6QjnjEqRxshUDGCMSRJcHscnhi3esHj7cB3INJmTJuTS2bYgvr4LyE/jcFofaR3CgNdwnQedDnQB16DjW2ir4gy7FGGlPWLvJn0apSPl6RdulDQ+/J+YXFtibuo4tKsBAvSP4RhhlifxL1akfwRWSTWlEzPUlngbNcJqrbRQXK4xFXlxjV5h5YlWRt47Ktm9POpc1W45TZxMT+TREU+lgLq+y1hme7kee3I6uGW3pijr04smQLcQ1P9Qi/mIBxhLE17DEeHD5v4hK1xRO1n9dFSxvcDcGkkjCsudhkUwlQhaqAqc8Ak5nmFRwf2NiMCLlbZM8NLKmiaZRKcYnn/tZCVWoh21WxTHwjPxDXVQ3EN6o95DR1V+FzOiuQeyMe5ZLzJ25k/mxgdBQQ7f5QjpP3FxPXie7CTb9f3d87Pi3p0485E5L2yfYL7fww6PaLmLdpK/hK4umSPZRzjbn+nGnCKv8rFG5C2rp/lChcgfQY/xZ1G+mbTnUTiIAgeIRLKvJpJli4Wa+CvL0dOc4erxQft0Hewzp+Y4DGuL9oqXtRbENTL0nwg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934ea391-969a-4f86-110e-08dc3557bf0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:43:36.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yD5cC/c1KT6QdC7rS2gWGaXyNk0BHih74Zn/qgXjAAZLy7jnJ1YzEwZY1L0DmdlQbjXJObd7PnGN/GL6ARgr8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240140
X-Proofpoint-GUID: TCv5NXwFYgi_WgiQ_oY5sjvfey-h6aaG
X-Proofpoint-ORIG-GUID: TCv5NXwFYgi_WgiQ_oY5sjvfey-h6aaG

Many test cases use local variables to manage the names of each device in
SCRATCH_DEV_POOL. Let _scratch_dev_pool_get set an array, SCRATCH_DEV_NAME,
for it.

Usage:

	_scratch_dev_pool_get <n>

	# device names are in the array SCRATCH_DEV_NAME.
	${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]} ...

	_scratch_dev_pool_put

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v3: add rb
v2:
 Fix typo in the commit log.
 Fix array SCRATCH_DEV_POOL_SAVED handling.

 common/rc | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index e475c890d902..50dde313b851 100644
--- a/common/rc
+++ b/common/rc
@@ -835,8 +835,9 @@ _spare_dev_put()
 # to make sure it has the enough scratch devices including
 # replace-target and spare device. Now arg1 here is the
 # required number of scratch devices by a-test-case excluding
-# the replace-target and spare device. So this function will
-# set SCRATCH_DEV_POOL to the specified number of devices.
+# the replace-target and spare device. So, this function sets
+# SCRATCH_DEV_POOL to the specified number of devices and also
+# sets a SCRATCH_DEV_NAME array with the names of the devices.
 #
 # Usage:
 #  _scratch_dev_pool_get() <ndevs>
@@ -867,19 +868,28 @@ _scratch_dev_pool_get()
 	export SCRATCH_DEV_POOL_SAVED
 	SCRATCH_DEV_POOL=${devs[@]:0:$test_ndevs}
 	export SCRATCH_DEV_POOL
+	SCRATCH_DEV_NAME=( $SCRATCH_DEV_POOL )
+	export SCRATCH_DEV_NAME
 }
 
 _scratch_dev_pool_put()
 {
+	local ret1
+	local ret2
+
 	typeset -p SCRATCH_DEV_POOL_SAVED >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
+	ret1=$?
+	typeset -p SCRATCH_DEV_NAME >/dev/null 2>&1
+	ret2=$?
+	if [[ $ret1 -ne 0 || $ret2 -ne 0 ]]; then
 		_fail "Bug: unset val, must call _scratch_dev_pool_get before _scratch_dev_pool_put"
 	fi
 
-	if [ -z "$SCRATCH_DEV_POOL_SAVED" ]; then
+	if [[ -z "$SCRATCH_DEV_POOL_SAVED" || -z "${SCRATCH_DEV_NAME[@]}" ]]; then
 		_fail "Bug: str empty, must call _scratch_dev_pool_get before _scratch_dev_pool_put"
 	fi
 
+	export SCRATCH_DEV_NAME=()
 	export SCRATCH_DEV_POOL=$SCRATCH_DEV_POOL_SAVED
 	export SCRATCH_DEV_POOL_SAVED=""
 }
-- 
2.39.3


