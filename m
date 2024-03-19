Return-Path: <linux-btrfs+bounces-3419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5788001E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F2A1C22660
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E22651BA;
	Tue, 19 Mar 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9KA7b7W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OqNRvZgs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE054FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860325; cv=fail; b=e8lGVmbuZO09LqWR6O3I3Qp7kWXJ7/MyaTjr2aGZflE5UZpYoTDzAVi7N/AMSD6mYtLXWRT8DWeeS277OyV/thOfOLymfU3hCyJAr+lYJ4mic7fv2fmdmS49fQD1RWgNZHRWnPF3FXhuFh+6xpE1ZBOgpX4UmIT1oCUQoklueCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860325; c=relaxed/simple;
	bh=9raEGbDnxJqlpK4II+/APpl8gkaXlKtCTTiGTXKptsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncb7Zw/X72FSTp+wyZxZdifan+XD8egC/ueR2v9po68Q1U2RZEeJw47buqV2L+AzJqTPnkPMeAlt/vvCsksM9mT+4daX5dcbL+e/PkKrRs4kiIIv8t1f8/T3BLj7LT/soxrugvPZwbkDJOzFWdq4UseYo0Fvu1eMMWhD8DDH8Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z9KA7b7W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OqNRvZgs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAIRSY020311
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+IlvqLTU/TLUGLbQ7s41P14gSv/EbT1WGTpK8ySRi2E=;
 b=Z9KA7b7Wm6XC3JklY0bfy89HJL4yx2cosTx/D4nbnebuLpcQ1hHTbYwaYHeXayN8YoEo
 3HCdDQSTxKrB726fhC6FZXwDdAzX+Iqs4XtANN4bV5DlWVSNT8omoIn9nGc6htpq7C4i
 2b4Gs+YInpAYT1cuh+a+NZbK8vgnM5k7VLRiFd2Kp9D31JGag6o7WKt39Whu9xMcA+EX
 vUAUKd9CbkzRnT+pKjlVkrCc8tTso/7U6c8rMoGSScqAeF+zCjDm5kKG/820YM58IkgG
 VJ+CZKDEeajv8+Ihw4aqp9p2CvO2eeDasyP4orTYvtCaNtDD4029kvFr2oCd/vZrP2Bx 2g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3fcntng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDfGgv024264
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6mt37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVoE4r7airQuU60Ar3rM6xLUY7xYM++CaBORMoSPGnSAZz2Hmdr1fr7kXJy4ZQ1VFBXMduDZfsimKL16iru6o+PSk3+m5A/VoBIqy0xYVDJoAMinP8BN9DCJW/izNdYaUrF/+lfs4Un2z3OLLIsE3SljG/1W5T/Tj/VCc+tCe7YegxAMOSc19IrEseVdPRF/51HK8G+Ey9zrulYuTcQagsQMxAkCfW9LIw03yZltxpUDglM1b7MULCmNaKtNHem/aa6VMP15IMWXmiAWs7YsVsYqPlGbt1uN3L+g4mJgWaWHat3VkTMgq38GtiX70YKEQAEVXduEmuK+ERf3OudIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IlvqLTU/TLUGLbQ7s41P14gSv/EbT1WGTpK8ySRi2E=;
 b=Jqrk+ueo8BmcH2vXcDqnPzrPSARH1vddkxUsk/es0+PJZXFZm0hGSZ2uZFIUETiwdSkCCDWYVbL4IzjeUME/2AnL/RN/7q0bD6Yb1oh9US8ySdhbfo03zwOBVMCSWUAj4sfpi01pko4cfwdwjcsp5xsVKMV0sGS31kXlHle55vz0m4ZHGCcZjVl1+CF+hr3qEuW4UNxKlq+e10MPsyavXIoR7gtX8nQPheqYkSEYfDJ/96Foh+Ah9BFcmRcPeagwXsEj+LusQ3sZtXM4iaSi2EgxKIwEj+vXczjJtUoQUr3JjV1HPPh6Tx8uyftmiIrbvYuvCNABOANCMWcbkpefiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IlvqLTU/TLUGLbQ7s41P14gSv/EbT1WGTpK8ySRi2E=;
 b=OqNRvZgsaYTDUOlLupz3LSle38P5vvLDCKqoUiKSjwiwmonelX2+Mf/QZN08VQNqdH1Tcg3148Wn+INjgS2aJRf9kC2KKXOcEYzPgrwEKbtTnIDb2fMmcqlOs9XPTvMOOqRei94xFYgorBCFKjQS7dpLCHNBeBuytZojSUrAEm8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 14:58:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 24/29] btrfs: btrfs_drop_snapshot rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:32 +0530
Message-ID: <d7c6a92fa4199b7b0e95eb02ac5d10689d7222d7.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r3zWrq6UUoAH9UGUapKM38//2FO2sUPheQNkHhfLyMxLVm7xNq0914pxm/S0Z90Tun5dF8P/PG0EyTcMWfoUDrnE2XMa0t4oPd/Kt/pkHwz5ph9G35Ky61ZR522ykuvIh2ZBNh2V62IbL5eyeVkYSeo59izi1XYh0rg7sOTPKKECek+0YSfFe8uBqLWVAa6IYFdLm2ARTgwLNwUhBhIthbqGiBEGfp7UJ4K2Rs+L6cecAMNkGoClYSqlIJn1Vsh4b3BOjnD4qdlppDMBZ++RgSczwfmCNxyr8Dk0EtcLfN3gIBRH6k2XepLLqvpqin+/rdutw9yzSMlcDW3vCOuQqfqGX8lSYotkpiSUsddj1xOU6TaKmol/I/oACaIlG1cEnEjPNnJhBmsGRrXnuGR8cS73ijRTeuA4+M4VylGAQlNM4QjUkJjDQXRUNX/Ea0r9vWdnFk03n9AT1ixqDj3p0beEv+c1/orOyWDBPJQtTFicnSBSKfHaCycXufIS+QEFrhxkcIQsAbQz+dGLXEQNQgSOcr1LGs0xmE3R4LWnI+krJXSXlkmmQRhqQPvi2rmtrQKPzuxWPyjgdVo7TYWTX++Bx5w2uzqyCW6/XgLCtRSGgNJ53oCWG8HhNgCw50bsUK05rlxR8BoDZpldoB862mOhp2gbfnq9ZcwI8Qs7J7Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8HLkI/h8YqvJR8mK9vgPY8A/u62HZZg8ncYZ89wMRNNL6qmCt0nmlk6OTejD?=
 =?us-ascii?Q?grglELxjtdHc7uLrsIAYK+LW1GRxgVlWPTmBNwDPvmDoT8IyScslnhCl/lKx?=
 =?us-ascii?Q?ToKNFpQjoP56erJDlvxSoFZ35NQMTudfvXqgoxq4+EWiZY/3eUhRmU2I2qVG?=
 =?us-ascii?Q?7XWfDLnOpJlWtKb6Blsa33/RlC9k4MnSSu3A9oHfdhLoks8AQ97EQuxpXicr?=
 =?us-ascii?Q?EuhB2qUUfR9swnmFNabk3Ztz0T8ustWstANhRqgwdWNUoeAc0MRi22TzMO46?=
 =?us-ascii?Q?StMMGOMd8n5qjYp/F3rCXECstJOLj7PhzSQVdSJ6zJ0t4RB98Qwc21e0dgSf?=
 =?us-ascii?Q?bUTQLQEcMUlfvkDy68Z5eKXuBcmWTVZhnfuTeJFqfeqysw0jJG4dTZzCPx8P?=
 =?us-ascii?Q?5+n770lELOMHvzhujyEvIPNP8o+r1YXLuH5p1CjZy79JCKpcuw74csZCt+SP?=
 =?us-ascii?Q?GDhstbxa0olfr/ZtDG1eP2tegCKvoZbcD4UEyqsUxU6dxZ4zwZ+kwNbsqCYH?=
 =?us-ascii?Q?OkC7M3eubh/rP/wiezoJ7TU11wVQC/dUzkFpjJaxlBS/83XlAXEZSvG4AWkt?=
 =?us-ascii?Q?2JQYeZuHhdPotZCiQpSRgNkbhGtIGlpdlYOp1z9GAMPDzSEDEGkVbOHPpt64?=
 =?us-ascii?Q?3ppNDUiqSJdhKM0xxWZtE1hDgSKwAwexaYBHFXxerZygnNtT94CVI0tt2Luo?=
 =?us-ascii?Q?SkauP2i/3Hgz0LjNIvHl29RM55pCMEIbNafuLipE2VnZLOTofbVM8U0rv3mW?=
 =?us-ascii?Q?kagPV3sz45Sqf2U6S6ufao0oNBytYagHwFxCZX9Wt1HYD32ypl183Ec7xI38?=
 =?us-ascii?Q?fR/CS2HWLkBxwVj5uapX/acG0/pHLYVwl3OWaADcZXBdd/cNSJJUWVYK4lbq?=
 =?us-ascii?Q?YdjnCWxh3CEsUaVGC0t1YWu92pnezbWKbaEn9SLev6lM9dvRljJW3qRYdTEe?=
 =?us-ascii?Q?/vW/rGEvYZ7f9jHeSbBz/bnZLvj8tSY85tAafuXcX5aL1PGMEQ/eGCfiDQ5g?=
 =?us-ascii?Q?aEuAO1yHQP04isBMCf9hv6xm3FEuZfPDj1sfsbrjdeWY1OkQgPoeTtRbA8V4?=
 =?us-ascii?Q?neBIfHsWRNb/Crfp3l/sROX+gbhRO4yvK/U/IoBqd6iCbShc3VA4I9Bxypqr?=
 =?us-ascii?Q?A7rgYkjBgzEvQXgVx7F8rdYxo5QVYiljE/MACVNHlV733l/c+4OCfOj8z4o1?=
 =?us-ascii?Q?Ok1jMBo67udbHY1+nYOrtT8+IHuV+opKkwlCTo2aBZWLXipT+s7MpfpNDvtj?=
 =?us-ascii?Q?J4ANrA+BTjt2pMxqvY7/6E1Xt0HecaGkbFpNom93m42HOVwBX2pSlg0HmanR?=
 =?us-ascii?Q?kzbNcTp6yOMyXhurOzyBiN/QabRqAvREohYO9P+JmidOHdAp1c/gppBL+zml?=
 =?us-ascii?Q?DDtmAQ7b4KyQvhsYGqHwXFHidTqWTLSOBO0IdoQXOfnCpwY/D/NT6RZNho9+?=
 =?us-ascii?Q?5RBlVOoOiFwmMMdXSzF/OeHxOEWJb+C5mEfzo/Hdb6KkkeE0wGpVMEGFzuwd?=
 =?us-ascii?Q?Dh7kceGRKHl6K5qAF47ekefD+pGm6K1CKmtoIJ6gziXsiPiW59Tx1ik8BUwD?=
 =?us-ascii?Q?HmO6YtOtTGQlX41ltFA9wq2Ew2CzsEY4mPgcvaYeWjx+wdF5nmiFuhw3vefb?=
 =?us-ascii?Q?hydlnOl0eThRp0HU9PTxsRiG+QcLgiHPgGXkk9FiMY1i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CwUDV9MMmI1qX0cpZL/Y2sXoD/OUNahTuxWf+Kld3pcOl9cNUpmPof2x1ufCwzE4GXeoL1KU0D6OjQJAdQB5mt08cC6IbT2267F46M5z60zCZ8fgJUIGt/adgMVoJbuUWzPvbvUtpwx/f8tQHji+vzDaQBpA2Jslu1GrcXPRGEY+uy6rwc4YGSRtugHYgkTeR2Qs4Gdvn1KjuKVNZL2fTF8StxgPwCPMiieucVo6KRafahPlUGxfWSzTXf6KYM/tT1uS1Gd29HrLkQFeR+ZWAAicU7LUdkqcUiNq8gGHBFaRbhyqt41buBMR1IO1q9/pSYuTzEZ9ncAlpOlykFDgo4j8n4wWdSA+FlQweOp2/XjYM/JqD0I39CeMODysWdArF/tilJcSoEYWmPvJBP9kmdoTLeDV3Mq2L/vhOr3/O7JTUrPYYzB8axE2IGBWq5WD238p44HTkzffZLULxFQTB2kGDMHZ2AuNnM9+RAY8ScOe7OCJOp9+TKc8tzdUwmFlreXtYIC1A3k7stzE2LAIZ4AHqnuka758fDJaCguxxxkT8CGgZV5lMSI8p0CQNw1heKfnCA7dOJ4Gtpvl2TgX6ksue0DyX4ylvzXHi9w2bS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095cab5a-fd83-4a45-d934-08dc48250f45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:39.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hvjko36UmvaqYsmFAw86PBCmMYXWqPzK3Cq+lwJ6x6NF427BRAJBISZmfg+mGlwSb+I4tpprQpEOD3MmKdCKlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-GUID: XfWOI02DY80UUboQ3zQ5jteiz4R7HQyZ
X-Proofpoint-ORIG-GUID: XfWOI02DY80UUboQ3zQ5jteiz4R7HQyZ

To fix code style for the return variable, first rename ret to ret2
comopile and then rename err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent-tree.c | 82 +++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4b0a55e66a55..acea2a7be4e5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5858,8 +5858,8 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct walk_control *wc;
 	struct btrfs_key key;
-	int err = 0;
-	int ret;
+	int ret = 0;
+	int ret2;
 	int level;
 	bool root_dropped = false;
 	bool unfinished_drop = false;
@@ -5868,14 +5868,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
 	wc = kzalloc(sizeof(*wc), GFP_NOFS);
 	if (!wc) {
 		btrfs_free_path(path);
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -5888,12 +5888,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	else
 		trans = btrfs_start_transaction(tree_root, 0);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_free;
 	}
 
-	err = btrfs_run_delayed_items(trans);
-	if (err)
+	ret = btrfs_run_delayed_items(trans);
+	if (ret)
 		goto out_end_trans;
 
 	/*
@@ -5922,13 +5922,13 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		level = btrfs_root_drop_level(root_item);
 		BUG_ON(level == 0);
 		path->lowest_level = level;
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		ret2 = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 		path->lowest_level = 0;
-		if (ret < 0) {
-			err = ret;
+		if (ret2 < 0) {
+			ret = ret2;
 			goto out_end_trans;
 		}
-		WARN_ON(ret > 0);
+		WARN_ON(ret2 > 0);
 
 		/*
 		 * unlock our path, this is safe because only this
@@ -5941,12 +5941,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			btrfs_tree_lock(path->nodes[level]);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 
-			ret = btrfs_lookup_extent_info(trans, fs_info,
+			ret2 = btrfs_lookup_extent_info(trans, fs_info,
 						path->nodes[level]->start,
 						level, 1, &wc->refs[level],
 						&wc->flags[level], NULL);
-			if (ret < 0) {
-				err = ret;
+			if (ret2 < 0) {
+				ret = ret2;
 				goto out_end_trans;
 			}
 			BUG_ON(wc->refs[level] == 0);
@@ -5971,21 +5971,21 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 
 	while (1) {
 
-		ret = walk_down_tree(trans, root, path, wc);
-		if (ret < 0) {
-			btrfs_abort_transaction(trans, ret);
-			err = ret;
+		ret2 = walk_down_tree(trans, root, path, wc);
+		if (ret2 < 0) {
+			btrfs_abort_transaction(trans, ret2);
+			ret = ret2;
 			break;
 		}
 
-		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
-		if (ret < 0) {
-			btrfs_abort_transaction(trans, ret);
-			err = ret;
+		ret2 = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
+		if (ret2 < 0) {
+			btrfs_abort_transaction(trans, ret2);
+			ret = ret2;
 			break;
 		}
 
-		if (ret > 0) {
+		if (ret2 > 0) {
 			BUG_ON(wc->stage != DROP_REFERENCE);
 			break;
 		}
@@ -6003,12 +6003,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		BUG_ON(wc->level == 0);
 		if (btrfs_should_end_transaction(trans) ||
 		    (!for_reloc && btrfs_need_cleaner_sleep(fs_info))) {
-			ret = btrfs_update_root(trans, tree_root,
+			ret2 = btrfs_update_root(trans, tree_root,
 						&root->root_key,
 						root_item);
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				err = ret;
+			if (ret2) {
+				btrfs_abort_transaction(trans, ret2);
+				ret = ret2;
 				goto out_end_trans;
 			}
 
@@ -6019,7 +6019,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
 				btrfs_debug(fs_info,
 					    "drop snapshot early exit");
-				err = -EAGAIN;
+				ret = -EAGAIN;
 				goto out_free;
 			}
 
@@ -6033,30 +6033,30 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			else
 				trans = btrfs_start_transaction(tree_root, 0);
 			if (IS_ERR(trans)) {
-				err = PTR_ERR(trans);
+				ret = PTR_ERR(trans);
 				goto out_free;
 			}
 		}
 	}
 	btrfs_release_path(path);
-	if (err)
+	if (ret)
 		goto out_end_trans;
 
-	ret = btrfs_del_root(trans, &root->root_key);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		err = ret;
+	ret2 = btrfs_del_root(trans, &root->root_key);
+	if (ret2) {
+		btrfs_abort_transaction(trans, ret2);
+		ret = ret2;
 		goto out_end_trans;
 	}
 
 	if (!is_reloc_root) {
-		ret = btrfs_find_root(tree_root, &root->root_key, path,
+		ret2 = btrfs_find_root(tree_root, &root->root_key, path,
 				      NULL, NULL);
-		if (ret < 0) {
-			btrfs_abort_transaction(trans, ret);
-			err = ret;
+		if (ret2 < 0) {
+			btrfs_abort_transaction(trans, ret2);
+			ret = ret2;
 			goto out_end_trans;
-		} else if (ret > 0) {
+		} else if (ret2 > 0) {
 			/* if we fail to delete the orphan item this time
 			 * around, it'll get picked up the next time.
 			 *
@@ -6093,7 +6093,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 * We were an unfinished drop root, check to see if there are any
 	 * pending, and if not clear and wake up any waiters.
 	 */
-	if (!err && unfinished_drop)
+	if (!ret && unfinished_drop)
 		btrfs_maybe_wake_unfinished_drop(fs_info);
 
 	/*
@@ -6105,7 +6105,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 */
 	if (!for_reloc && !root_dropped)
 		btrfs_add_dead_root(root);
-	return err;
+	return ret;
 }
 
 /*
-- 
2.38.1


