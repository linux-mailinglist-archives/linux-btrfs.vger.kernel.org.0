Return-Path: <linux-btrfs+bounces-2718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34368862615
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B154B21655
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4014C634;
	Sat, 24 Feb 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E+Wn5wpt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oQLk0CEN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE274C624;
	Sat, 24 Feb 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793065; cv=fail; b=C9l/8J8igWG9SD9KWUgqTs1kkg1KQV7LXB2BoeO1wXAsW8XGmjE2Kx5+eZ1Mn2/DMCcEy2xV2DAQd2ZrzSePffnGnyi7Jfc18M84snBbn+4EI2QDdMII3MRHEFsdVljD3XedRX5NyLM3LSVFIWXBojWL2qDYN1eRlT3Rd3UHseE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793065; c=relaxed/simple;
	bh=NT9NLIPDePdQonY6PgInIm7Pjw0RsEa4Aml40SokKR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYnyCpLt+MlGLx7UkR5Ja/0qnTBg1TQwmjmVIrzd4vIDWxBsZGEpRED6lqAubGNb7PfmECp6ktQkfsI5QkqACFNjmeC8ULY8JCHMgpuxLuHuvdZ+1W9cr7b7YfjN/eVwuVZQU89I69THJe1Fd1+c3YrlnxV0UJiQd0AYfObXsl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E+Wn5wpt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oQLk0CEN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFT6Xl020729;
	Sat, 24 Feb 2024 16:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=o2zLnwqVEP69UHQ5EpEpPUOSMSGBBgVK0tGGqHcqMNA=;
 b=E+Wn5wptM2quGQUSnKtxu4t1dbectGGF+AMYuNXk8psFS9/3cDBV/8gMB7DFE0w23kF3
 EgKVD09DCXcquj0w5rf4Oc87YgodKL5koeN8KroBQjhuuq6B/twJH0kkA0xpp/z1ekE3
 uQyxnctrAbgLX8NpRJCRdDqBzN4+CGKhihFAbV8TtSHCKd7IGfJEj1OiCw42Lm4oFTzL
 Rn0feG3YJ65F6LetqFB8ns7KKbp4nG5fZ6Vl6Fu9KBMQI2aeMh9/9aIdXtzqPtSpExo8
 1UAzzg1pL66+yMmr0jrpfaGeNRu7hOdHM5Dt7sPoGYh4rPj1daUiYBTQKVJndk+TE0w6 eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v1103-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OCOKbP011427;
	Sat, 24 Feb 2024 16:44:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3smc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv+RccyGalzLl5yJxizXB5OSCU7ZWzViFj5JoJNBZbmZpLDae/i0Eh/6hP5Z12FK3Rz4cF12NITyK39618bemaMU571QgSlGzsdcMzvgiWXnT+/8BcCZhT01Zp/sqD8tmQRXlu2fddvdvF5Dx/KCG6oSo1250KxGZCMBv8MePgDP1dKR8YG6I15iMQZ9ppxqNVlqUADBwEkUWgp8sskwmx56e36L2zPwdT2sFBM8jJb8bRC1X4J+wP5EhHxsHJBZsh7XNdQhYZGpA6hSWIaw+83M7R+2p1IO4d6xeauyJ4OqW/5Qn7Q36NT6ND2/eKhPIGJ9LUbGiT9q8r4J5YCCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2zLnwqVEP69UHQ5EpEpPUOSMSGBBgVK0tGGqHcqMNA=;
 b=TW96ShRGDtBPzQM6hIfc8waVwMlJPRQ28hFS9odrIg6aeQhVbXR+LOL1KLQaYboWU3Hkvq723lbxSJ+Joyifxs3lKaSP2HiIyLWxZEjQbO6oPdiH4mOxC29tH1M7ZCIudX+KuNzbP5Jj8+5ZAjvVksQJOSK4ybkN2zfaDVSOAa9HFudYTuw616e0FaaYRpMqFPZYnYBR8R6MEppZM6xVKZbJeGg9/WRYGQFn++JzFyeg8zFr92QSSL1iAcGukzjsoXG9DUINjDVjpTupeS5jSJfYR1j4LpfWlGUdtEij186l4gssZiq/+r0DbgMf0IQLHVqyXWCO33fzsVjIOYXl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2zLnwqVEP69UHQ5EpEpPUOSMSGBBgVK0tGGqHcqMNA=;
 b=oQLk0CENyzILOn7mVj+E3n1bSQUBkcDeeUYsvrlss9PBqv8arsS7eEzZ3ueHjrc0OrTGM9Sj0Dz2eTe33arEec52TpNSOOxtH6vK5zcGdDbZL7cqzq9JYrsX56nPnr6nReDza8/gzFyFG6FLUbojkPtQKF95af7ZrLPKw3s8ueY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:44:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:44:18 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 08/10] btrfs: verify tempfsid clones using mkfs
Date: Sat, 24 Feb 2024 22:13:09 +0530
Message-ID: <b51143afd6776abf1741fda00a007c594e8d54f1.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9e8ddd-3278-4cde-819e-08dc3557d7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OPAqR/GJpomyhhDRSF9opzm5DBMj2SSk6WPYEmttJuOh8cO1mPJA4k5uX05H2xsNfzA61xcsZqNPfwYOdFdRBfUjf9VqkGHRRqKLJIWPTkcGGBg+LfctuNCHSMN/mzUmMsix7NQvMt3qoqxqXE9/ezZUFGoa6DD2o9ppJZ5WFkXJdPndJovyZ8XGz3m4fu5jreuoRPNWVeSqwHdPJBN49t1dzvzigb3G3F63ic5EY+9WU0d1bLJ5AJ69VA0q8PUQXPoJBkVbE/TlnXAFSHzRCDPvrKU/P8bvlm9vOJXAqARTLU99oyhadT8cw27vF/824l9/gLjRV5G4XgyKwqTXjpZe70J7o3aW52cfWdNeJtzZkbxoE0Iuer7GCOAJJrxllfDUAptanTr3HDGmfeOBazprtN44GvkBFSyWVVjCcLCnb6kLkDSXdTpJndWbkZKOelTmFFV+AgnQQ5xwbL3ggpkEOAzqJZQkzNlJvL+cPkCZX2TdiiaHbPY51LAgIduzN9zzvtLtEw/cZRpOgPpHdt5ArEZNsZMwDrLrU1D/Pkk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+x/sUmxOgwDi47BE8nDdmCIVVq0CljcUysBVRzqjCJW6ShG5TUvuS2itOLPw?=
 =?us-ascii?Q?FWPA/p7OhxbAhJ+iBwdQG12riRxfMvMPuxecAE6kVTH6SF2OmbDNz9MSGy9a?=
 =?us-ascii?Q?MUjBy/0CpbWPS0AUgWeezuGhgmc4vwwkagNUfYh6iso54opuZW5XpH3Y4DFC?=
 =?us-ascii?Q?NV5g1IXAgdrXe38OGGchgaZD3kp8QSMALu1Zecnu7pDTeyQ8UBUiz7rJZaG+?=
 =?us-ascii?Q?J1ClveKg9hsZTlZ+aQ5oA5EIJltidsi7c2G+uMrlj+M+SaAzQx/Z7vGydO8o?=
 =?us-ascii?Q?JLBEFF8Ehn751BuCMDrMm1iOqvgSIREAdbji2UKIjLstqeyJvhZHVBKZJ0kZ?=
 =?us-ascii?Q?6hfh1j58CmQ8B2QbC5wkI0qx1ZhY79xoQeEZgYs/rEA764Upq7ugelXd+92o?=
 =?us-ascii?Q?AfMz00i8kWXXPy3cFTPBzhPfZbs7n9ULlUW/nLDzvf5x5LJdOj9a/ySfDpj8?=
 =?us-ascii?Q?m7CrMRTXyg3Q8iGqDgbKXAOllrk4ra/qBkRLc0qqLr/uOqGgUu3dMNwNucFM?=
 =?us-ascii?Q?mqkE+bgLb9Z2Gf3oWwVoyjoStXr8snv2pCB5ZdAFrEKqn6zL44lX2knChmKV?=
 =?us-ascii?Q?pnNbE1QUyeymI4uO0Hg0/TC+67Bto06Xy7pZBdlGJF2wIO0rJGOhrugiPrjw?=
 =?us-ascii?Q?+N6E4pGpASnULYB1FfLNRmFxzszAVJiaZkvIrrr29742zweA4c3BVRPTyY4h?=
 =?us-ascii?Q?mV8ue4UwpYu++4Pv+j+JX+62YyV37eYBzwMkVTL4gHAh1fsptuHt79bM7D6l?=
 =?us-ascii?Q?viZIW/NajNujSv5DwQE/B7/XNbhq6hqZ+j+hK2cXZP5fIk/G5DUUQxNkb4iZ?=
 =?us-ascii?Q?sh4ROyqj2jP+UQCQghtMDiQHLo4JatbzNo4bCymPdujjkExGa/GcRBOhm7iv?=
 =?us-ascii?Q?dzLv3sIxX8HxXSmjR2vcIUB3dsaserKog1/qDoxNYCXm93JKT6sA5Cxc4xPv?=
 =?us-ascii?Q?0qe512SoYd3AnOQeFH/dllROB9wTJUEU4asDMxK5SlCKcW0uI8VtUSI678NK?=
 =?us-ascii?Q?kOdD/hz5iXeYb8mZ30nWJzxKDRw8iJZlTzSPDpBAObzdlM8DV9TvATx91P9J?=
 =?us-ascii?Q?1ZlJSx0s6h03/+KJKLRdKsahPXVnql7GcAiFS2pFpaYuV4EUtoSCTz95spHo?=
 =?us-ascii?Q?DNGwvVqotrt+7qRaEf7lR4bPGAqKrLMKibpIOugmS3KzBPs+HA9IpuxpC/Zw?=
 =?us-ascii?Q?Qlpja90KNmeCpWL1/qIBBWUVPGxqrnjUBcwYWiH/AYlpeKwtPPCuxAjyT8k3?=
 =?us-ascii?Q?6K2yDLAw0v/hv+V43G3NDu92FITaNjHMVX/VmLjoGXQ0NZeFPG6EE2LU6zX7?=
 =?us-ascii?Q?5omlYWAenk3aTaNn6jxnOZ5giZRqVyj+DcAGDKEt4STm4bySfb0CzxFNUpya?=
 =?us-ascii?Q?dpbeFZXqpP/EQq4m3A4jRpVV2TjlFPOu59WJv+w1pFjl7Iyr8l7ICscFBMQy?=
 =?us-ascii?Q?wsP/hjOyByWxEoVYwudffic1n8Gp6pY6KCSyTFvr7L2DnFfjpCsTT+TUxi2r?=
 =?us-ascii?Q?YMqaCqeFLn9c9PIc8qRPeYieLfkvWHG1KqRnRcHwrjR0wtvn9YscWMkoQRI6?=
 =?us-ascii?Q?z/4RIXl0FRGPnmQWTrozkDiPggrHa01kI7OdL6bG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MQVlMPs/6/x8LkIFzzMusiPb5winmKejrUANRh+4KZRNnuQd3rhaafLd0n1igppvO4x3ESFbXre/Qzx1DTe6bOrvsA+Q7uJEZunkFuuHRs81xlTReLLUWvLU4x9zUd6VowJ/feyNXukly45No2Z0ZL53fQWdUAQwifdtgtcrS9z8vp/+96H2tsXN9mbz4Q2b0xwJeoZKsP9UIYZbkemoNM3V6GsxFLy7rg5/elcAGRTb+YnWKpmb9tsrQ20gBoFDusuqhHI345GqBbCAMMIor6gmYiPHgqguPhvjZ2eipJuUo3Db8sM8c9nca5iGb6mn5HZky5xtqUhshBD6hQ920qH8JnO4543kHJCAYnFtPz+ieoVplxFE5Y645ueXk/wy2hQIm/1yhvHvX8kUfJ1U1Pg2l5Mbgw+JaNqfRjbyWEQTke479+886B/ePCQ3ZT+br6cGVdmmZkx3ysNWBQnxK51Z6ZVhz6oTlFER6/5Ch4gqRClhmBjks5tRmJfK6N/+Jj7jCiZ4PbvjvWp0JmCFcw18dFmKk5Frb8qVg/TKqic1dFw9+imytU0zNxYzYI9WXAPBXjLIPOU1jOH+gaqbB+qUPcF3hKgxckqdaGZQEc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9e8ddd-3278-4cde-819e-08dc3557d7e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:44:18.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i293oSauNWJOCh7IFN15W3PcaJL31/VlnxTd8yKYtum/hoXoR/YmG+bxbgpZt1aedeK100be4w1mdcwzKpqyAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240140
X-Proofpoint-GUID: Vx-u7WXk6h_mfHlklpsrtOAYK0Z4ff0X
X-Proofpoint-ORIG-GUID: Vx-u7WXk6h_mfHlklpsrtOAYK0Z4ff0X

Create appearing to be a clone using the mkfs.btrfs option and test if
the tempfsid is active.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
prerequisite checks are in the function mkfs_clone(), remove from the
testcase.

v2:
 Remove unnecessary function.
 Add clone group
 use $UMOUNT_PROG
 Let _cp_reflink fail on the stdout.

 tests/btrfs/313     | 53 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/313.out | 16 ++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/btrfs/313
 create mode 100644 tests/btrfs/313.out

diff --git a/tests/btrfs/313 b/tests/btrfs/313
new file mode 100755
index 000000000000..1f50ee78ab99
--- /dev/null
+++ b/tests/btrfs/313
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 313
+#
+# Functional test for the tempfsid, clone devices created using the mkfs option.
+#
+. ./common/preamble
+_begin_fstest auto quick clone tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+_supported_fs btrfs
+_require_cp_reflink
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 2
+_require_btrfs_fs_feature temp_fsid
+
+_scratch_dev_pool_get 2
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+echo ---- clone_uuids_verify_tempfsid ----
+mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+
+echo Mounting original device
+_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
+check_fsid ${SCRATCH_DEV_NAME[0]}
+
+echo Mounting cloned device
+_mount ${SCRATCH_DEV_NAME[1]} $mnt1
+check_fsid ${SCRATCH_DEV_NAME[1]}
+
+$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_io
+echo cp reflink must fail
+_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | _filter_testdir_and_scratch
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/313.out b/tests/btrfs/313.out
new file mode 100644
index 000000000000..7a089d2c29c5
--- /dev/null
+++ b/tests/btrfs/313.out
@@ -0,0 +1,16 @@
+QA output created by 313
+---- clone_uuids_verify_tempfsid ----
+Mounting original device
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+Mounting cloned device
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		TEMPFSID
+Tempfsid status:	1
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+cp reflink must fail
+cp: failed to clone 'TEST_DIR/313/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
-- 
2.39.3


