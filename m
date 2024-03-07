Return-Path: <linux-btrfs+bounces-3064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBD874F71
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D09B22799
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938D12BEA9;
	Thu,  7 Mar 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MCc0jz1I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vTnTUFZT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F812BF07;
	Thu,  7 Mar 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815860; cv=fail; b=bKwfHs84Yu4J7muajqJlMjVkt0kb8Xt9SZSYitLU1EVSzGZQ8+QPlvcYYaIo9Po4ozpO3kLFo2OQhqUUXp670Ps6QAHXKQL9u7DuVUbq06kU/xFGCmdpJynSZzinzhxeeNgj2WOgMouRYpE7bMG7+GcUoW7LuayNsNnmMB2Lsu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815860; c=relaxed/simple;
	bh=BCv3ognhhLV8sMCi+A8ILWqK32ctYCJ9Cv4Gr4AqTAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uO7lv+GK8+Fd0J+yf0Syl9pIgAeCVZdI7lPYodV5XygPhrRycCh2WD1CKp5xE7NIp2t51oLkFbCmNG0XzK2mLSJIiScn0Z4XzZIEcAXslKoFHSzjyrG+YyFw/xplCxEVqACeRw85S7iZuLJJXxaqGXI4i17Jz8Ik/KOsibAJBnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MCc0jz1I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vTnTUFZT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279n927021883;
	Thu, 7 Mar 2024 12:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=5/Ts+UrrBFzlxsSki4lAZFmHdNLo9smEZHn2/aqhx2A=;
 b=MCc0jz1Im78VBzcjUvL/VPX6Q1Cbl5/xRKpRSnrch2xBOxZTrGizQqGb2w5AJn+0nbWB
 QXn9i3vhc/1YB9WkVLcT0A/hBG1LALxDanN5myz6kM7FKYtStCopWZwePBjeoNO1fowo
 X/8whprRRc0uFtM/YVbQmRtMEGyv6gnwCFT+MWLX6w7bs2i9ti3dt7i8q6XSL+XXJxv6
 Lkc5gVkP9pUGXepHmbgsYFfx734fLXrUVlIZWOs1udu+7ev/ZgXyYenPOJw+7xFcRczE
 tBTI0uChnlpxrMor/TSXiK0MzuiKHSZe2/FCz3p6OtUduDHpVziscOwjaRs476BN5phu Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktheku2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:50:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427AoG6e040930;
	Thu, 7 Mar 2024 12:50:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjgy3yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:50:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiQ423mWP4JrXGEKrqrF7qhIHqjd5mcgdRXK4QzGG9QyS+aF1iL9SEesdKUbMcwFHucgFeQa46WPnrM42uTiFHV2hYLWOnAUAmf/bopl9uik4xMHh9ShTPEyzyOZtXE37ST7+tbgxbD9VcnBU4LtPGeJJFrygaPDqGwbhSnYh2YLm4zqU2uIuxnRWyaUbx/amnB7MTaRILRizjyU8NBGCudOK0I8C1mqO5RZbst90W9l1AwOFabXZvkoBXRomBu52pGwk4CpX9CWFCCwfs1Hl5JeZoltW0sJ+urkEnGuUCj9Nl2i0KjQvJehtJyeglkxs0pO/FlGHhoFDqfQU0mF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/Ts+UrrBFzlxsSki4lAZFmHdNLo9smEZHn2/aqhx2A=;
 b=AWDM+N0GplFhaHhv7y4JsjZvLgYRGOpjiog1M6AmvxJAZxo+ZwsTf4IEUmrAA3jj2S8AXG3fL6CxjQdzlnlOVVKuP8WHbMmZe4gWqmO8xnGJENm+8CxBWN5ijt5cqrOEONy3SmQrHacNwhIvq8LSt2YB34kc4h/2q74YYOi91b3TavKTNe5VB16l9Im7U9nxYVihFnLQHsHIFYW/vPyv4zgglNz/Lqmydo8QkWTjbrFUZU+bhrdPI3Fuur4Jdw/CooDxx5hVROxlCxM/rv6jyphdR7cDWS/8dnNTVLb+JIu5hFL4yTLZBKdBXRhJkDd1QvrOAwgA46c3tNHQY53T1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/Ts+UrrBFzlxsSki4lAZFmHdNLo9smEZHn2/aqhx2A=;
 b=vTnTUFZTD2WbX76i6j9Em5dwMWta5Z0b0cqvuHeh13WBQeBz0VBsoPIdjY6Bkvhmv5nZOOzATI6ae7eoJTqzJQPpo9HaFUI1YSBDSGn7/V+5x+gvCq0yaqAZI/cDxokc8+xAT0Xa6s7oK13sHzo42kVGwK1DtgJrMdZVzRED4vM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 12:50:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 12:50:54 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] common/rc: specify required device size
Date: Thu,  7 Mar 2024 18:20:23 +0530
Message-ID: <c74dc3a6f1dc8d45bc54ef6ac087e5e92a778509.1709806478.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709806478.git.anand.jain@oracle.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: b3de1347-a58c-4376-2d17-08dc3ea539f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WIXhw6dsQyxWKCpEYcBBP8NVejQPbfThsxoJkP4k94I7GCGONrkIMkqH06PL/6bYXlEWHOlbDNPf0xb6CFQT1JpNOET/T5/H3EUgLwgOFsYdoAwoYgODyAfhgG+5tz/d3Bpzs2FyZ88xDhPgtmlKM38YDs6ckn1pPLC1HDMP3XP+KVLi9f2u/yIqbrcH3AW3fWzT44vSgR9YzRZIZa1dLdKVQesXrqZZLG6tG0CRpQsykvVdessrFu3lXGwFLSeDmrPTDqNdPaNBqWKyJmrvkjS8Scg1r12HgJi+JvrZvsrSF45IWGugJfof4hX6Ayvt6iCUhzIfxfyrbCXtQ7axTK3FYnL586SnZjId54XL3ILSoZzkOQRR6AnP4jXVyq/KNjisqPE+WmhVC82tOCUfr5urbuXKYi8ZxJATfviCSoVeHMJcYtEiKTIqY6h24J/FEVUTLGu/QB6IHa3DcrC1DEcGAULgZPul+VaZTCPsCwnmrV70e08e7j/j4UbGFDMX4yajjqsx6Hdp3+jsFDmu3mapwEmduPnPbK53JNwffuY1N5YEv8EKnLDBz/M+Y4xe16HmT+bLJVunCHel6pT3Xii/+1vI/jfJMglZp6ltpSOMDV0pl0rpdhG6QPK8SeZLK67tJN6+ToPfD8595Z5l7H/eQDV+J3AXvynGLfzH/Yo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PX6J31lwQxjoRj+fUmRUSv48WoJ/LAkxcRPc5SB+5bL6olkvWYO899rFVe5T?=
 =?us-ascii?Q?JNTmWzzp5qzH7JkkE3jf2XvXMDI1CknA1qmc4+AqlVv9mrzezocpKcdOTtUd?=
 =?us-ascii?Q?RY0C+3EsDAYoV9X/61R5+1R80B1qtGgEHxFOVwrvR2WFhY3BWnl0UlFHhlxK?=
 =?us-ascii?Q?q4rlv83vbW8wXTYCR1yFzWOyDeRoPlL+yNfVEwYDR+alMVJfDRbXClLVO8I1?=
 =?us-ascii?Q?h+/BUxs7eJg8IvkXaALyirjPUS3/IYN9/cq0+pcHh2XTWk4W0w/uqxZTI76Y?=
 =?us-ascii?Q?+vDxRx4BSGuTQtW7MBBIsO3rgT0Ev7hcOcgpd+VPGCXHaxYwsr+j4T9Whraz?=
 =?us-ascii?Q?jqEC7OqW5qV6Up7W3USqGWuxVCZL2hlnwuZgQTjD40J6REOFCVnxZgT4MYVs?=
 =?us-ascii?Q?feic2y368W3M+TG6TwfA3y/nkGibsheD4Rr2TyX/zM9CUGNVp2H+HUypfZ5A?=
 =?us-ascii?Q?n/amNZueivyOV9823rDOa4eE7v+XXWQII7kA65Kmuawzg2lgAueiBItwS+DQ?=
 =?us-ascii?Q?bCKXrneDL7ObUapPl2iVn/1LBorGuKgQSDkB7dM4yXgXyWLUBczxOQKVEPuw?=
 =?us-ascii?Q?9XpljMTm/S/tUgcRkzR7jdYq44x0zyoubXnxPxMHk80+vY/G1FcbpjsOjWp5?=
 =?us-ascii?Q?X4QC0J0QJDtoQxmutiV3AW11EsnugIl3cApoMwe05n2Xqfr6xpD1kclQO31V?=
 =?us-ascii?Q?/MQbrRcnemM9Ajt7v2KgCIi8KlA52jhWzcnFMsZvVGBkh3/8oOJIZDusXbJb?=
 =?us-ascii?Q?r4Lf+Zr2B7cMEXeIigiqi7SB2wi+24R7ZVJUAANji0UsWnk3tVzW61uNPopT?=
 =?us-ascii?Q?X4QIwFZfAvWIBwnt/ckhatWqBGWRWoLqPI3RaKqzLFlB+h05bpJPsnebLotN?=
 =?us-ascii?Q?kL1vK31hnVaImURLNLz1xt4OHp5/d+Wh7/UMcKO3VxD5I8X8QDuHcGFEN1HL?=
 =?us-ascii?Q?/xQDADD/7hCHs7UMGEAZGEKPLfPfCB8kpuVa4B6/5hEBO6gbase/6KcVOn/o?=
 =?us-ascii?Q?pKDuNRBmbtbeSpwup0M7oG4/N7XfJaa1eH2qg1exTJi3KmSDYYZSq9eNmrWE?=
 =?us-ascii?Q?cFGsTYn9BCNEoyT+aBRR4ZdOkr6mUmExzHqgjzrF0isNf5S8DpOBiPUeZQmk?=
 =?us-ascii?Q?CyYrrqWGrq6nwwuDylRDbmcCdFZ8yWGzml11bjQLapLGkOsIgcx5mW7BejWA?=
 =?us-ascii?Q?6GuIG34GHJf/2TX12scVqWrjuvXFChgrF75kCOb1N3N5MDR9FDpmaAD2PUOg?=
 =?us-ascii?Q?qa8E3oNToTuGYRkI/ypsYiLOvPmzOL60JlKmEhMLbUu4NWEJhdYlqcgfevaw?=
 =?us-ascii?Q?ST4Hnw9Bm6h0mAnaZT/ANbF6zQQ9fIQkHk3Yz3TApRGh6kU44YocLTM/kHLK?=
 =?us-ascii?Q?/MVLB70ulC8UXIKZ3RPxcgqc5e2IwDeWvSMIrrYXSkp9HKdo80/JZd89UJVd?=
 =?us-ascii?Q?mY6N7YdIbuI1KNcPr55csVqAnoH26pIxsRaWpiR3h+7wPHX9XHQnTKXXrzEh?=
 =?us-ascii?Q?nLy67ViBsbxrrBipSXt7J+iZdXh+qv0VDw4kPzzAo9mluJVjOVfF5MZuLV9R?=
 =?us-ascii?Q?JK4gVx+9zjtSDXY5WRd/mBn2yz/Vwo4OtsCTaBK6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Uf+quZHs3XDUZ1d6ItuCckq2ylSRpJNYIFnR3RlHpz3Cc2c30xpc1v3gdBga6upyemeXdEW9gMi+xH1qLg3eGHy3u/P9tME1wj+8L2sTftgsNS7afodC6q6jMK7kVTivYDjbmZSHepovAKUN5PIkKxLOfroFGtDksWK1Nw2+ZGvT5Q/mBFquAm1n9hKfAqJJZb+3mFhJKbT4i35SQZLt3fb9poLTZDNdkg1syEPzeb17o2O57CUteKHd4cBMP7qEYs1N/kNsojahQlhRfZj4KiMyPxZGe520N31ZpA+YUEmkyV0EGOtGlCfrzBQPZ1U4OclnGyziH+gWPzAnojlUL1mGdzYrBM1szHYMcM69PiuBlPAJsrOWNg5F8sSPF11skDD6UE29YamPMOqux5UJ1xSQ24xBLajZY+fEoLjtEVPIQ9u0hf8pec0g678XY82iYViDgUuTH+gVhG8up3u/5wRyuWoYdh9xkDLd5ARAR0Y2ovr+C8CLj2NuatS+B3Fc944pOrMFz1BcqKfgXgYg7t67BU76YTmEKvK4FBRIdRnzcpng/Qff2nVSG+poACjlppqVGsyAYoCZ25xtCXJ+5Rfj9s1MiycbyGQ+qgZ/ugw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3de1347-a58c-4376-2d17-08dc3ea539f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:50:54.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKganSvIt/LcMkZ/weQJde+m+EFEpI4t2etRTQMUnpqs/6sbpxvCYR2FzLcgcSZwY66nvWiM3BETIEYw7PrMEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-ORIG-GUID: NighrPYdTCKFr6DwK4cGq1X3CL3uaBFp
X-Proofpoint-GUID: NighrPYdTCKFr6DwK4cGq1X3CL3uaBFp

The current _notrun call states that the scratch device is too small but
does not specify the required size. Simply update the _notrun messages.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 50dde313b851..5680995b2366 100644
--- a/common/rc
+++ b/common/rc
@@ -1834,7 +1834,8 @@ _require_scratch_size()
 
 	_require_scratch
 	local devsize=`_get_device_size $SCRATCH_DEV`
-	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
+	[ $devsize -lt $1 ] && \
+_notrun "scratch device $SCRATCH_DEV should be minimum $1, currently $devsize"
 }
 
 # require a scratch dev of a minimum size (in kb) and should not be checked
@@ -1845,7 +1846,8 @@ _require_scratch_size_nocheck()
 
 	_require_scratch_nocheck
 	local devsize=`_get_device_size $SCRATCH_DEV`
-	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
+	[ $devsize -lt $1 ] && \
+_notrun "require scratch device $SCRATCH_DEV atleast $1, currently $devsize"
 }
 
 # Require scratch fs which supports >16T of filesystem size.
-- 
2.39.3


