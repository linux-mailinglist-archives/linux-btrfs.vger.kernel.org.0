Return-Path: <linux-btrfs+bounces-1301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416B88269C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 09:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D3F282784
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47CBE7F;
	Mon,  8 Jan 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dw/sdUP1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Th8Tgyx4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3284BE5D
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4088oJAZ023197
	for <linux-btrfs@vger.kernel.org>; Mon, 8 Jan 2024 08:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-11-20;
 bh=dp+ChKCYlEyK0SMcuekJGhBH5mqHg2poFEmtnq0G+UE=;
 b=dw/sdUP1EqUROjNDzIPob/ub2n+FKxshQFSMfNzqM8jCLkidU/AwIzF8GmHFvb/wKz7I
 V3qn+LmV0l1sTAQRFLfbvcMh5yFO1h164HEIKb58Hmcrq4JpNg667u3Pkf2wk80v3eWO
 i1TxPPyrEjI7hkbY7E+v3HjFdS2/yTgx26PDgApXXLDiM2F1eHdzn+uqHjiwB9jxfZj/
 vPY5EAizpzMc+FoUvMsfcR0ZhfSznrYDDSOcxVHm+2hqJWMr0XDyiK8weLAWUTvFkYLB
 UZAf8b8TWZFg3RXYNAHgxVd3z5Ya7Fx5GpsQFwfOqaiG40It2s5eCgPQnAMPZ0Hticgk HA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgdgq819n-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 08:51:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40875bqe008962
	for <linux-btrfs@vger.kernel.org>; Mon, 8 Jan 2024 08:31:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuug2c9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 08:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiuBiIIFAxbn9+tejv/mzeN7arLs9Zk2ayz27q8UVCvPCyKAop2qtlBoh0CPHftt5Qh/ikK4JlZXhjg4BczW1vXsh0cVZgNRjjkHjgLMa9oDld9UgMToQjj39P1shR9KyaTCb01viOQ4BYi8O7o2L40mwjvIYXMOTYq3hZFLeyUcCmJaCHE7gFMg3x0PT0MKRs/qZ8sSJfBHJLbFjEkhwDMdZhjQGo3/Ykz+4xecp0SByAXiPDB5URZhOWzTEnPxnjSm5E5bapNfmkRAyV/N6p+56YKVlV8e6cQ+iuaZmItKmZmESuCDYUxm8PDv3cbuY2tsdWDPFvhMYYExiHR8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp+ChKCYlEyK0SMcuekJGhBH5mqHg2poFEmtnq0G+UE=;
 b=kPw9sKoHfFxPh0sHNoD8xjDkqDOh3bkXvEP+iaRxVQOabj/jdSt4cQHy2t+DBW8B5YXZYgtozORxoJxP74q9pSEQlcEKYKpjX/dKNef49yBoLXppfNySAnoIOb7f1XZ+QMp6wWY9d4LLULLLJjEx6nF4MptnjSxUZ5Li0VWAkDbrbdtgaTi5iIuE0AgIKb93vLchG1TijNYYf3uKJUbxIBt5DcGSw0EJR7exW/tTK4tQ1R7m48D97x3iZxBDoJs7fRgcwJX1mbm9UlndJ63ERFf+FYhI1dxKB3jQa/a4SM0S/vQw9xPJFj8qgUgjo3pQez67XG/FBjYi2VOAO5TGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp+ChKCYlEyK0SMcuekJGhBH5mqHg2poFEmtnq0G+UE=;
 b=Th8Tgyx46BGPgDXrVsdTM+dg5qTqcT6PexG0iKg9BElxOizkq8lCV1W2P/bEftgWIWVczG07cY93XgaaBkHfrGltZ1OcdHS9h/A+b6PJkouqawdcP/7cN9fF76L871n6xOlK+NCeod0RHWSuCQXLqJ2MdeZg4cVD6bI77eoqRvY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 08:31:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:31:24 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/2] btrfs-progs Documentation: placeholder for contents.rst file
Date: Mon,  8 Jan 2024 16:31:08 +0800
Message-Id: <b30031c129e92c7e99c7e5bc818a456cd5828cc8.1704438755.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1704438755.git.anand.jain@oracle.com>
References: <cover.1704438755.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfa39fd-f0d0-42c4-95d3-08dc1024330c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qNQZuFFFRdyMP/QtoA0QAW/i2G7Q749lFfXVWzUYuY0zVxxecWToL9bpyTNeOWqygWbJ+X/+FTc5BAInwjdYoQkxiePe/aBkaFaPVx7QhRMTxaCoX9CK31U1ydWF2JvwanTQ41UL5kUjYHt6IDYeGJFxpuxKqbQbXXjgaZimSoLe4udMCLrhpffP1gkjVyAlQFudbjx5AAmp+UrxmFXvELyUikNvEk+Cy8mbfYwiY1nkbt5N6+KI6Cmk5iCEzjgDCm638Hlv8R4oOLOp0sY8rCCdnEy8fVlmdAtWEAoI7jFphzTyskH+dSQ1UBYCB6EFmK/Sk76GlYyfgKy7HoOTxxJgYJt9ZoCWu6ar1g7SMnHV69KL7OsIE7hwCq9CUhOt8MGoDCm/YHyB3GFYzJNLsSqaphE0mB/BtRdeiUDh79lGXK7OH+Prrp8vYaJXHuNAwaxzfhExEGab18RvIA7JHx7eNgP0FRq7C3B5ax+NcL41YOafvP/MAUYHltUa+VUTeaOQu8ldpthQj3MCnPPVurVw3sjBhwmZTBxjC9u/S0OJfEbABGhIJS0mcCcf2fdZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4744005)(2906002)(6486002)(2616005)(26005)(66476007)(66556008)(66946007)(41300700001)(86362001)(36756003)(5660300002)(316002)(83380400001)(6506007)(6666004)(6512007)(44832011)(478600001)(6916009)(8936002)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TG+W9RfNuCTnM4Vxb5PnK8+uiahVGevLBH0s98Kraxr6KmR27K+Eet++PSmA?=
 =?us-ascii?Q?DWW0ZBoYMZzEE1PN4sFJZChmZCgEEq+J+/rOKP18Ppolvlh1DfcCqGhHOBZU?=
 =?us-ascii?Q?7Mgr2IpwINwIlwlYGPb2BCfadpbgK29yjTEN5lEbJAabB/R9JaPHACJvazho?=
 =?us-ascii?Q?uAQSCjZwRisc40TbwTzgnKmeoh/WKWq/kzo32Ngj7vZILrMGzSfH9nIQ9Muz?=
 =?us-ascii?Q?y+E11Mhyj1RAeOjNFoPVFjQgfOWOIAZPsRVV9oA7++ihaaOnzy9MVmsVlfXC?=
 =?us-ascii?Q?yQoF7DDNGtrZ5oDGGO9adq2NbMm3UXVTrM43NwGSvKE7yUu2Z2peH8glJ52c?=
 =?us-ascii?Q?+Ic8mvXRvSEDUmZq46BhKDjM9HdpYXX5L9MJyr2oLcTIiyxkqBjr438CRPQM?=
 =?us-ascii?Q?DXsK/O7PTLGcjzQ9HJkjWTbDJ7RKCfmu6HPqjaJxDhTQt81/Ly4oHj3/kvTE?=
 =?us-ascii?Q?Ta12/asfqeIoFN7KuLQDJG06kMTwCN8rozBlqfXnlQmxLekuiKCg9pWgfq5b?=
 =?us-ascii?Q?q+L8P0VyBnzKeTJohp9rrAoX12J7DJE5i8CUH2pDvbuSSWkAOHEuvQDnulE0?=
 =?us-ascii?Q?Qrcg+225RtaF5UT4YMJL6GaAKVYChKspmUfyZi/kkRNUCxtrQvRHMZMzD12z?=
 =?us-ascii?Q?wDluuiPuQlIohvK0sgmzfBbDHpNApOaYVG+xNCyExGp5OhlQwBHkMjTivxAP?=
 =?us-ascii?Q?dulFXZGgTrlu68TnxaWQ8N/ozviKkJcGf6sOQSAYNMN8HtG08QbbCOY0jbWj?=
 =?us-ascii?Q?8XxA60lHGEQuq8PuslrDRTnnvPvbiHi8zGXTl5kXTABnM5FG0zJkI2iU6rki?=
 =?us-ascii?Q?0UajLyI8GAHDmzoiWVI4Iog8cokftjGvqXsMvW9B/CvNTCu/Aghy3B6CNDuS?=
 =?us-ascii?Q?RJDdxL+keZTs6GvzW0d4taGCYctygLBqNWooNIwdrSB8kcuV5jKI6ErfC1QB?=
 =?us-ascii?Q?Z/bsKe10P/m2MgO8Bpi4tPenjr5KcrLMmyZ56XvWUNLCn/YdV2DTouy7klDp?=
 =?us-ascii?Q?3T2sbACU7qusAmFQVWQLCAmUAK9J9H2hRUX5J+f2PK8SNIcU3QjpJls98eOT?=
 =?us-ascii?Q?ckXp1IJ0c50Hg+eJrmmCl/F0IG1U3jw3a53WMkG6FBMxOMJpoVCQ6RNUXgQZ?=
 =?us-ascii?Q?4+P+pCMN80jfc9W91ksKwJB8n/md0ERgERgkiEVoAy60N9mKsMzSHp/J4+Qi?=
 =?us-ascii?Q?6hlrZxpTnFTBRoXbUHtKRjkJ7Ekmybj26Ihhec8vOLLAW32qMf//TwTsxYkD?=
 =?us-ascii?Q?+tCspsM1a3xjSngJnjOIL/i3LXRsWmzEmeZRcrFZ7Y5XnTmzfJwRGhAX8uKE?=
 =?us-ascii?Q?Sg1/e9BHkj+Zp193rKXreshV/eUm4DDu/Y0iGnTtIHzq425qtlw9XKsHDk7u?=
 =?us-ascii?Q?2hhOEfW3OjZF/9oVzj/0YJz4FFIL1epwATW9XcYvuwRj4g7PRdwAIg9Llf0T?=
 =?us-ascii?Q?1BUdr/zuzPHIqJKxiXxmvV6ugaNvuvkbQ845pf24thJJDQH8ITSRz+U7wh9x?=
 =?us-ascii?Q?1SfCL4aTb0gauxxZs0FQFNQp6Rf9BmViLGAGc7VWmhJVebNOl5weyCm0SxMU?=
 =?us-ascii?Q?6QQ+01nSDnXhytmmXhULSEi0ST5eoxMNeQ8+DrbP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	II6sOEa++IuQM/E8RR8ZRzDwUDaUdmoi1C/qqHua8gWO3aKUDNnjb4qjVh5D44G/dCAMskIM+isHQ9Pp77nLPsg07HP/J8wIkBovEwCTQhSUgtyH6A9zhXni9ZqCdNfA26xzTb2Pgn5GkDTDe5thOq//cwO51VWt0SpaS6iL/fH6FD4sb9Uuxqy4FtcRbjF6F4KPPEKeTdT302a9YNLRKB1I1Ym+NmaXGTzM5q7DPeNqA87rVYReswj1wivbS1DC5LwHP1M9wryWiG19bRLRoBBBhs3l4smpZFINlzuPc4DWBgYYLl/7YyEYXeW5C/N4sf5TCNDJ2uYtj+NPHXO8QVlFEiqQWIdCpSdVnmi+mVVWaXyP9+atHbLhLqsA+6krEu8tEYaBYTozVpqEKKDYjDIFc7Apagh/K+QL4XWJBdgvzrpH6TCf7RU9dgpbBxtHf/Q1Ntmr37VFyXjoQcGsCNvfChzwbkcUtMSCrhkFZMMQDIrNCcOnBgPUsNnilnX5CaW1rKJV3AwCgRtipxI9jUzUkRvgzMZqZwRhY4JDJHP/eiFnV6oyOIqq6b0GKZxzZ6iPG4IA9f3Rkgj9ZrLaPHfCUCtZor5skqOfjeI2yaw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfa39fd-f0d0-42c4-95d3-08dc1024330c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:31:24.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCZ9/UTNzfQ/fatm05CHCbNBDMTRy0BjG8KYHjgvZXp4ZbnCoS2tNpW+jPmm9mbUI04Cs+QNRhP+/qirLplBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_15,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080071
X-Proofpoint-GUID: G6gb23Ye_Mj9FsXLOpoSLVA4SFZCM9OW
X-Proofpoint-ORIG-GUID: G6gb23Ye_Mj9FsXLOpoSLVA4SFZCM9OW

For now, to circumvent the build error, create a placeholder file
named contents.rst.

Sphinx error:
master file btrfs-progs/Documentation/contents.rst not found
make[1]: *** [Makefile:37: man] Error 2
make: *** [Makefile:502: build-Documentation] Error 2

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because the empty contents.rst to fix the error.

 Documentation/contents.rst | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/contents.rst

diff --git a/Documentation/contents.rst b/Documentation/contents.rst
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.31.1


