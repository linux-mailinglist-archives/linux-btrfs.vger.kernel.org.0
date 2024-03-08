Return-Path: <linux-btrfs+bounces-3106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478C687668E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 15:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43D21F2371D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC90442C;
	Fri,  8 Mar 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0Il30iZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O7EfaLQW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6371DA2E;
	Fri,  8 Mar 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909156; cv=fail; b=BoJo524iYU57jQoOT3TV6vE2aJHUNbHzRwj77c8wguw+cU2vt5Kn1TTAbdiuoYNLPMbZaXbZ65a6Py/YyQOjqrzeTF7Q8emBkmxOMGHbu6LhcAm2aA2nMeBVvLCvC3+IaVx0P0KZwBr1p8hOmNBHKDgsP5IEyIwwOUKZSZKeS54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909156; c=relaxed/simple;
	bh=WWWH1phD9nT+T+NtK/q0bgzc2u9xiRDujsgONCRJx4M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lyrxmkCCG2y5wg9WN6WcbWH8V2ioy9f7rHdmMYrxB4RJ9yZMw8vnEm5dPab3zkREiaggT3FEZPKtgQ1ZUfhXprvg0iQBsiKv01CpSfD11rJNE1097tk9z+4v9C1YZ6s+3tZMXjqgVXb5N0aHIsC0OJxSfrhy88jxYoRFaeU9OYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V0Il30iZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O7EfaLQW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DT84W023037;
	Fri, 8 Mar 2024 14:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6Zjq6TRf48kPDhC4CP/2JkFBKf6M4c8BXkCULdLizgY=;
 b=V0Il30iZ6dMxBGTjbsPaIyOtURef6zft/wq/aczSqUd59qDS/u/qSY9Lsrug2AaIh0tk
 tpAjFjE5TjDGW3f1wtTjy6gzD4+BBUV3U0N1XNzNhXkv4BAzh4jsgg9rKE2hpcuq1bZh
 jwBdow9QLUmBaowkCCUb2svaGuV554RQfsm/T7jMtKUNPhqBeY/mIxEZGfG5KNcEc8oP
 WfX28jmfBXLD6lXa9gsDa/IawhAhCh77f8i9O1N4y9IVrKbe9nX1ozdQUekQp+mcBMqh
 Km/Fk3JBzXtVD5nddCaqTFWPXti3NMKLCwY9lJaDb65Utun5V7yg4iH19gPs99tWiz2f HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4exks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 14:45:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428EDtsj016099;
	Fri, 8 Mar 2024 14:45:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcwba9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 14:45:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoxgAM5PKRmRjMKePwouMsMunKazOXuVFz+D2HSlOpuTjY97Y+EgRCq7Ox//icIInf7qETqpN3aco2y43u4U+xvqc9yKlD3ebpI5+VUFOgR0TGYK70hs+5T+vV/BATO6XPsT2xV8zJRqkflj9PlMH19hcr8Ms6d0lniRCv1jM+UMmFciNoQfDZ4u0XNBtUEmDLVG+JFk5S/Wes8is1P9FPKXULET6momN5G5buRW1L6XCvazDhp/4DJHAcwG4TJxLyC6wt/PL8u+H/TdBcK2Ah16wOng/nHIxIwCKsMr9Qnf0zU82dwWId6iWQ7liL3sgxGZQV7TO14jhhWvSjodBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zjq6TRf48kPDhC4CP/2JkFBKf6M4c8BXkCULdLizgY=;
 b=F1OB1663Jqp6DsZhZoRsFWz3uKJ4GYogG9VRT/rb3vmuw3qTBlttUv8I/t6oWA9TjVju7GyskgdMpLHHHtVc6M1BGw6HwUzbLmO1xQeLmeCiMtfCcdC2N2YZPwrrpeoko1l9CRX1s5jF5dKv0ql6S88XQ35B/59DnpcxwSno/YhAAGWF5ShNilJC7LXtNDyN5977AgYxWYWDJOgtvJcb3DiQ6iHgXItP2rmCeZrNR5vkLYrAXYEnwLK/rxsbwGdKcuGv/J0MdxVv/r3Tmxl5lRNv37ISE0WJV0BauAWp1c7KMqy63zFZQsdhfVjCYTMuPKOKKc3xYGF024k7XrOHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Zjq6TRf48kPDhC4CP/2JkFBKf6M4c8BXkCULdLizgY=;
 b=O7EfaLQWXppk70RQ9/yrOIyRgyYbXEVtf7x2qoPJ5VNVF+856lb/Fqn5i0fO5N/9W3kH7Rs5UsLsVIx1RJyO4zDh52cE/d/xOunhgTzmMKA+TGbTkM8T0x7eYXiLP3Gi5ji+uRhw+OKy70UceNzdV7aTbcFXRjklrI+EnmFhxa0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 14:45:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 14:45:49 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next v2024.03.08
Date: Fri,  8 Mar 2024 20:15:32 +0530
Message-ID: <20240308144537.16995-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 425bc7f7-65bf-42f9-57a1-08dc3f7e71e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+bFjedNlJ2Ml5DiNYA0WHCWyy/Z/HypWeB7ElEPabPikA/VnO3DVxBxbNMs0WupDrLmUVubNoe1lQveRC9UtUShsr4uSEqWtwz7KRPLp/x7/JxqmotDrcFH5yMMo3YmDc0rC1rmrHPdEZP7hiFvoUIQh6z0YigG/MnDeVi9f4N50mANeg+9pBqvawV4vFXeFXLzENYhGxH1rIToN7ZsSahigz3zRQkF32idMtxMSkHsG+JLhxtfl7nu2JEi8wgycONhx53xRKTaFzfAB5JMuSlZPDV7E5bR8xoXgexwLmlzwjswhThMbRx/yEakY62Effm6mmKqa7kTupatsU18qZKRnTOaw6CZt6SgRpR1T85LUP27nPjqg/e2pqEl7OxBG19FS6Gq32q/S9M1sjOIi0gL+Ev9KvETlLyIz4uzlRSCMh9QOSnOSxX4vfyfKbrUE2/zfWCJJ6KiSuP7QMDMO7vPLaBLM1/8oXhIazmBwmboaJc1pKxIOgRrxjHN2VOqwmQznmb54fT+X83kkgH101lOJoOvA2IhQvmzMpVWjg4X8ZgW7XJo7REtmkiOSSBMHjmHpK9qaQLsqPh10sKtjHvJlrDOHkj+BB7LIEe0W76I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nVZNMuKTMI8HvvSYV76rct0ipSIyC5DiABw6s6OCWlt0/jAqY+Cz42M+Y0nV?=
 =?us-ascii?Q?5aqddbWMWK4lAJKqLgA9ZmgG9352jGuSDljMGlo9quFWOHsHkl9yemFoZVfD?=
 =?us-ascii?Q?kvHFcJQD0ndgl8G3bh8dcWXZce+4Gb3Lrctj7iXmFPhXd8rktVljgBsRfV1k?=
 =?us-ascii?Q?1TTLKG7TPm1hQnb1QL1/RXGCaf1biHlsfK2Mk34OgGnCzH6hmup8WCIrfWVA?=
 =?us-ascii?Q?nHZcxRVhcAcwy8yv3BCZoTCabp0P6DfuQYK5IaEhQKfpxUYDLWjmvAcPOOXK?=
 =?us-ascii?Q?O8fFKjVOOXf1RywehKgC9N2nzGpG9U94iEsOOSyUzNkx3ZtVBfIO71TTLmtd?=
 =?us-ascii?Q?lywBg0qADrcrDTAENMcTx1khCmKLBabXbVS4a2ZlDFHUAqm/D4TE/t1FlCaJ?=
 =?us-ascii?Q?+aJGzOtaN7HSvWJLBDEaUXF585h4qWDPbpp4bNll0ZBU8ssJbC7DWXafZwz+?=
 =?us-ascii?Q?5rOYuIkBICaSDmEqraUoF5PyTDQCcrfgsh4Cl6U4q8x714YaoUp9OKbMcoB3?=
 =?us-ascii?Q?M/87Q+s7LZ0T/8oO22/mJ2SWAxTSqBTCor7wzwUY6l8zx4dZ5Y7uWH/c/xfe?=
 =?us-ascii?Q?AzrUqGhGUzvfYC2cBMTRw4Jb8aOLHCqghS9PnH8oUF32/yV5KkfS/yDieLST?=
 =?us-ascii?Q?MihIS8pf/+aVKJpCV05icKH/sMWQpAz+QBmzlN3nqpP4H1OnDFS+5CR8FfOC?=
 =?us-ascii?Q?2Z83p6HAdQPd2Wa0GW5lF3TcMZqYoLkF/l8SzKNPmDMiYOMwS4L9g9jUzaqW?=
 =?us-ascii?Q?Ac1tmV+M20GKnoYS2K0GxagkApiTAPURK+LuXCGJn3hqqQrbK7fdSQhjDdlG?=
 =?us-ascii?Q?ryo5VNlN+LVU3LOfc1l4UARzLNxnj/zWmdH4KxRoYkTQTRc0qnmfAJpa+tTO?=
 =?us-ascii?Q?OjVVvVG2QeKHv5P/fHgHL9n/XNfd9YFjAYKEC8sgWwDz+yXu4fD2F0AB/l2s?=
 =?us-ascii?Q?5D65jt2f4uTz59ckGupg+4SjBDV/Rggr2xPIEjQOs09ecISN8tJjs925HRrN?=
 =?us-ascii?Q?RtgnP/ZoXQZPFoDhYKublvbtMMBGXGnO/KhBXATtHEwWWG3ZZSh9rRtnd1p8?=
 =?us-ascii?Q?ZqH90bbvG12vSiIS3LRoSLnax3xRgCq9YlzOx7GON0qKxkLW1TaSlIAfIv8L?=
 =?us-ascii?Q?rssYXvGnnKacqfcL786nYvUVnA3CJxUW+jKOVr8DKL+gwrViRVwqL8wXR/MF?=
 =?us-ascii?Q?cuOgtcMSpxCkENCVhxqOyN1o0fccaFIHO702r91S5j+SJMVuCDUtcBXWwlM0?=
 =?us-ascii?Q?V8VPPyCl5a4DoPJN5NKomiGSDNgfF9mtecDJukfkNCJP6DQBdp15R3jnbkmt?=
 =?us-ascii?Q?/1enUttrtIlQXaRcWXVzIT+a/AN6/nUW7QFLER014QTUg7stw7AqWS2UCb5j?=
 =?us-ascii?Q?6VNMTbub0PSxPTw83Y5aRePZQfmOAulTVMdBDGF9JBSF5Di74dDGxu+yUg8u?=
 =?us-ascii?Q?gGEpAawZVo1D+masz+G3fhbYB30/XmqdB24ihXqGAW/aja+wxZahbF+QIydN?=
 =?us-ascii?Q?R80z7zp79IMmZh8v4uFsBHsF4qqZHlTrTldPqsCexFyuO2b/sSS8cc25OCZp?=
 =?us-ascii?Q?VJg1Ob+O1wqGA6j1T0HZV9+Y3sdva/AlVFerXGBk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DubdkT2elZ7tJPF2EVHjzAAEpay8pmbo4KeA8F9QJaDf7XqUCmU5WHmFRHg4rCtQ+BvK1mVPpBbIO/hEtnvQmHpFoOrnRqS4KGAMwZE8R7dTjiVUQo7cpx4RkG8BmrQ02sBDf9YDDqepqZgGoASMf4ogjQOx7BXhGDuV+QdoJucHMTlOVmdWjrjdoGMX9/tI88KewEaPRJI0gYHJZk8qSYyBEcYfSNWakOuRdeqYIlEndZf+jFvtkYijcCK20JSiVii9StWAdPUczTzAvq9o99cXFA43lfusVX3TdFD4DMKnoEWt3Fo5QImfJo6r/+DglGvF7Uhd3mtgcnsB5PDfiOZ3Q+ZXPj6PW15kGkQ/cToFSTKAZnMmUPGDuCCgmVd/N/2h2UqUo1eCpUsiwnrOEy5voDsoc62oSYCIqC5CpFQAi+dpIxXDhFTz0YqmoNTrtYa6+kBRkBF679ocTPsKtjQLyrcCjaNsNZCWA3chAdu22l3pHlSfonMfIjhcGjqNAhs3gynd1fncTzE5se5vhFlCmiYYAEX0d+vgUgUiKgyzLUPWJqFr4jtu9aTjZWf2anU4oXdwpyxnYVYSfbd0BQY+CBpJLr5h56QnEyNXkl4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425bc7f7-65bf-42f9-57a1-08dc3f7e71e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:45:49.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmDR1dLCIXn9eEDJKOSIR86C32dNrDZBSqCZcSyaKGMdudoSrHxBFWos9zNNirdsBCZSveiSsazLWTO+o73oMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080118
X-Proofpoint-ORIG-GUID: XuZcWPtvjsl-dEtjGJZKI1IhPUqUQzks
X-Proofpoint-GUID: XuZcWPtvjsl-dEtjGJZKI1IhPUqUQzks

Zorro,

Please pull this branch containing bug fixes.
This changes are based on your branch for-next as below.

Thank you.

The following changes since commit 9b6df9a01ac8ee3f28a2a24d71e45792e21b6d48:

  btrfs/016: fix a false alert due to xattrs mismatch (2024-03-01 19:24:16 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20240308

for you to fetch changes up to 9a03e88a04b6cf6e161c8902a3a523ca22601277:

  btrfs: test normal qgroup operations in a compress friendly way (2024-03-08 22:31:51 +0800)

----------------------------------------------------------------
Anand Jain (1):
      common/rc: specify required device size

Filipe Manana (1):
      btrfs: fix grep warning at _require_btrfs_mkfs_uuid_option()

Josef Bacik (8):
      btrfs/011: increase the runtime for replace cancel
      btrfs/012: adjust how we populate the fs to convert
      btrfs/131: don't run with subpage blocksizes
      btrfs/213: make the test more reliable
      btrfs/271: adjust failure condition
      btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
      btrfs/291: remove image file after teardown
      btrfs: test normal qgroup operations in a compress friendly way

 check               |   6 ---
 common/btrfs        |   2 +-
 common/rc           |   9 ++++-
 tests/btrfs/011     |   9 ++++-
 tests/btrfs/012     |  14 ++++---
 tests/btrfs/022     |  86 ++---------------------------------------
 tests/btrfs/131     |   4 ++
 tests/btrfs/213     |  20 +++++-----
 tests/btrfs/271     |  11 +++---
 tests/btrfs/287     |   4 +-
 tests/btrfs/287.out |   2 +-
 tests/btrfs/291     |   2 +-
 tests/btrfs/293     |   6 +--
 tests/btrfs/293.out |   4 +-
 tests/btrfs/320     | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/320.out |   2 +
 16 files changed, 164 insertions(+), 124 deletions(-)
 create mode 100755 tests/btrfs/320
 create mode 100644 tests/btrfs/320.out

