Return-Path: <linux-btrfs+bounces-1154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E8B81FF60
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B191C222C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2771119A;
	Fri, 29 Dec 2023 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ijzneoe+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BFlxWHy3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39411724;
	Fri, 29 Dec 2023 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8O74l014965;
	Fri, 29 Dec 2023 12:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=OUh/Gvpal7cXTPeSUCAr7wMpD4KDuZBBLfCFpfDzHxs=;
 b=ijzneoe+vYit+pUik0WepfCz82ezm7i9TqYaaxkroAYrPMXqnQADCSHnVJeQ2f2jfymm
 U0eog/3ZtIEQBTi9v1EkCh1106smh/P63dz+fKp60KvVHHdxfzIuSwutlgd1mq+/HRoH
 HQIM/1ICi0JZ0UDz36V8K8WZkYX7rRc8LA3IZDQVT5tMYVnJTc6DB0hYEmO6rMpFBwzT
 jodk905cB27yfZwEWIN2UPhOOTdi32GtyVqubsb6yvVqKydc4dZrPuaUw6tSps4aFEDN
 tUzKEdIjODOQm2G6PTzP+LV4fTiUJqg6m2YPGs+gS3pwGl42+2ND0+6h3T4zT1KwakHV wQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5pb47km4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT9u3uN035662;
	Fri, 29 Dec 2023 12:23:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v6a965me3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbQBJqus8EP7mUys9F3q3Pe97xf16DRu0KhjulvDQunldnRcWeuxF2BUans9I6W+m8eHq+Mq0KK0s4ouPizc7Ub/WOpnIyP3rrCKIZU/jhAjiDBPOV8GofpygYkLvDMS6s+hI2Jx+GJqTqD5bPuoa99uCG7nU6/xsMKfs210HlqqIAnKb6du44/ucHAq5864jhNJ60IrQG6yPkZ+ky2mDZRkaRT8I4HWZTy8uS3v/JRTrnVnTE0Z4N0RLqp9Y30JoQqFOJrdT5DGGdX6PuVng3D04DZUCHC6K6ElItlppB79+njx/hpypjH8eyFcigh0RaM7irVomKdrwu7oWx560g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUh/Gvpal7cXTPeSUCAr7wMpD4KDuZBBLfCFpfDzHxs=;
 b=IDdaTptBmzuPeKsALM8zmkZ5o4E2wqYhf++3OsvfbRfanMMc1+NYAeWZiGQaRnyhd0KYAKXoYluCSPEMxotN8IN5eXiC8ZieRGCRGqaospyo3Fm7iT8uSyuEiOaO63zQ+saGkrUQlmMmFIERCZYNLf5RWGfAbhQ3Y4mm00TtPVITDz2M6h3bs4MrdkK8AoWkXlQtiGcJ0EDeqJkhMrZeDEeHSPtUdYy0ACW/q2hK/WH9GygwCMcCykDBUzhRIz/hslyEKjKOBxblL4Ya7mbsLzBv0ISt2mUv5lXOHkG+JeBITVdF14nlKM6ASeMk32/NfwWT1dWd+qb9RpNAjOBbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUh/Gvpal7cXTPeSUCAr7wMpD4KDuZBBLfCFpfDzHxs=;
 b=BFlxWHy3HTkQsOMsJJEXtd2/1BtxG9M1SKySkSjpoemf7JmsvSav2/nlUGFbpipFaUefjPjvUiWicrCiSrC4/KYw01uu49LIWbgv0hae6+0H/xMrW473MHC0X4aYyqDIDsKQ8v7n5OPkRUIgKu0yu6VCzCfXwQx/3NMI4HzqFKA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:06 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 02/10] common: add filter for btrfs raid-stripe dump
Date: Fri, 29 Dec 2023 17:52:42 +0530
Message-Id: <37e54fb6ad6ab6d16e9f211d668aedd2463a79c4.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3081c240-0263-488b-d1b3-08dc0868e966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n0v/7eMWe0W+x0o2SwAmeHEHoHaeZmhZSmlJ9t4e3LOiwf9LeXv/NfIkIrhZmZV/uuorlGCaXFkxuRc/iYCrs25gRqlUF+s2S8r102r01nYZdC31NM6VVF4H5k61ca5cxzEEqnz10auox+BPcI/9naNJ4UQNvp6I4p0qe4yZQlhwuxbd4GWXb9NjC3jOLn5uz943PsEPxGNBd5S1z5hZh7VYAtf0DWXu8D2gSDRdZ80AagBe/96AqVugTuFaxHMPWhQjPsXSrS+09nxs6ao4MuxlZ2PaAUXGQFQ8o79KCZgr4c27XAaVBA1RIIM7+Fp0arBL/pdS5NHifPF+rK34S6uMBKcm53IRaPdRXOp/NKdGIA4uj52J193If7OtQJ/UR7svbIVy/fErD7LibRP4XOgQiYKrUOOrlF0kJ4e4MUVsYdkXgTFHBJ0ZNl9u8fReETOYa1KbkGJn+ufXo00LkpHc6kLysnTV84KFtFgAtFb2lK+8FLiGYWi22FLLGgVLU09vyshQFWh88TRFUjn48ZAtYNcKIJCUWyrgCBqurFy+9CZpZrYGQUYkh3XBa9hC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gVysqYIGnnSfacP2jo+FEwH5oBADAQF5rZwXfppwRG2A2JBlWVMC1m7wAE+f?=
 =?us-ascii?Q?yqR4OtWJdW71/YCI4X8YhfqVHFAaOs2QO5V/18w3V+zehG8kYtnA/h1Sa3f1?=
 =?us-ascii?Q?O49P43nN4j3hTajvmsacdaz515uqRggR/ZenTCs2QL9HmsKuPTNNmjhV7gha?=
 =?us-ascii?Q?7sH00pHKfcGZ7rJa9axTjnjxbZ2OF1CgfgMhuNKXdoLxBlFudHpv054Rz/of?=
 =?us-ascii?Q?MGX21nqkChVQH9LropQuE33pmp1AdbnJNrozkLVmwVYMcl9Nj83c7OW2XDag?=
 =?us-ascii?Q?aWv94hgJG1CHHw3wIBZKTZggMy7cz8wPBc5LLGL58mtYVOeQya4ryFh3TUYr?=
 =?us-ascii?Q?kf3ICs4JYlUYIiJjMgVrTDheO/qAdwE2mHd2YOcZrCN9NG9HYJEakvzGoXp0?=
 =?us-ascii?Q?CWzxkyl0mABrg9ys7rrVZUCqtKVss8qIwbFfWNK8Uwz2D0wkFUq1pMmY71K7?=
 =?us-ascii?Q?loKAAt5rIbo+zirLKas4n7gTL0WEb8qCIWYGyDf82N0QVJ6uLIWj2o2DZ8F2?=
 =?us-ascii?Q?dbvBlYoqTKcmjS4BMrGMzPdZNTXbq8sPudy3pmz1XqG3UBzyRR4BG783QEP9?=
 =?us-ascii?Q?rYot6uwRkhonlkL6kINwEi+0aq/kVHpXrLabXaFbP2K+ieQQzw59m6PYS05I?=
 =?us-ascii?Q?29Z7kzMk8xOUWy+/Af81eHHa2wieeLIG0a9xrBUUTOrGL9YTJU9pIi9sZNFv?=
 =?us-ascii?Q?BpPNZ1pAVbnFIv42c+YA9XqJd/WsqJCzA+sKk2C6LqKounpM+9hPWUM+CN7X?=
 =?us-ascii?Q?Ju9rALIHG0A0CgfbSG4j0uNmTchwupA86AfORJloiM2mCQeVNSgwW6j9BUyZ?=
 =?us-ascii?Q?tY2Jxx2b/XOtRoBGoXTnjgqJXGfeIwhfcRzE1xHjM8w9dLY7rA9yqzJV5PAH?=
 =?us-ascii?Q?p+rlF7uSb/p/Q+D27nqyfWSeZSdHPHofUUz09VwFLOOdWjfB4pF9738etD84?=
 =?us-ascii?Q?cb65b56Z5/rk1EwaPCv++LZ8lOgF5gSJ7sXks4uMJY6LfcWcDXZm2vJmzCT6?=
 =?us-ascii?Q?SFq483SP88DXACw9tTmSWSrIV6UUifOITxZlDDfdiChD0yYi4y2TdLRce0ZT?=
 =?us-ascii?Q?cSDwJVsyAuIa2Ob6YyDNgd7KNvqPmoanjWZdPxVPgovbl1w7IYtADPH1YDNE?=
 =?us-ascii?Q?7atKqreT4+nh9StexUBRuNaOCT3imSZ+3VwGmNgc6zh+DZ94UZiPyk/fzB8J?=
 =?us-ascii?Q?zjJsFeDzZudO0b81s9PQJuHjjDfFhXR4feqmXneENRxsHSAhuzIPV9p8BYE1?=
 =?us-ascii?Q?oI6QdF/+z+rHOxrIhTCF1HZkFii9ZR076V5S32XfZaBI7OcpWXcuhFmkHd4o?=
 =?us-ascii?Q?nN7e1fLF7EBMcKOiyKlmBa5a9nJAL8oVGvDMzCp9nkGyEUVF8TlWsvJXccB2?=
 =?us-ascii?Q?pMVm2aJLpVyJxQDp6c4aDd4wrAfjRbNKg9WOSoiPZsONdW04vv9VgoXNkanB?=
 =?us-ascii?Q?QTX4FehjMIpmVNNMLmgtTMlJniPRN0wxIgllBvgIAeUFPkWLLA7W0k0kq5N+?=
 =?us-ascii?Q?CErnA7WoJP8tIPG947e+BwW5uJyzwtMUGvKaRDpizwRakgLIfzOWwpc7ASDz?=
 =?us-ascii?Q?ExLywNAN5xDDE/1Hr1rFdlxruhTHBhPlk4pUEoC3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aRkE4vwKrhLpX0eXdUxZvRcqcawlr0qdcBfGY9nqhYVguTds66DSEM6X78kCk7ydC7k8eU+2jy1ch6U6t8dlJxNEcEfwkn7ibUexopFImzZNqOav3gCGM9TRanIvc2y6r4djwevrUYqrAKANnyMpgAxPYMagZb+hM57OvSbsbfgyIvdDFpEVDsKupFD6MobPfqZ1nyd4ldaiT17wzeEsF7ymSE3op2K4u201rF7WaXPdMRLCisIagGodIkFkTI7/xvfodK8HVKA2uz+hzSXD4+DRTBMRB86tATtlnReFbiKPWmcL5uIUF4Q+ihop34LU4viShXgv/RjbHpDF36ST1buXbHZ3uqSuYcsrJQz3MuU0TakaGxv1eshJqOn58Yop+GTNSGF/lmIqxSgSg0XjEGZcirOOA7KMXtxxIqa65U7DlsyLeBb6r+VhI1y1MgHng78Hnps7rTFrcvmpcHeqrQAtLD46qv16jQeJia+EF/RmlLrMzhGfxy6dWcG2LqWcP2v9rWTsXjsUS29Mh6BmTANLdEsI9undV4qPJCEZn0YpejujjE0cPvCAxAb3btRERjnkcS/y8hDJjy/wx8kPU9jlJBJMJIur6RkuPyII6CQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3081c240-0263-488b-d1b3-08dc0868e966
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:06.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i93jJv3+uq7iT5t9tPuAvO7toJutRiBf3p0KjSK+tF1P0bZO3GbcyST7f6LFL1Tp2r9U+2oDoQJfhTh+iEZVQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312290098
X-Proofpoint-ORIG-GUID: AcWEbmEAY9XZWgXL8YomT-I784fJ9wid
X-Proofpoint-GUID: AcWEbmEAY9XZWgXL8YomT-I784fJ9wid

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter.btrfs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 8c6fe5793663..e570648bb5e6 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -126,5 +126,19 @@ _filter_btrfs_cloner_error()
 	sed -e "s/\(clone failed:\) Operation not supported/\1 Invalid argument/g"
 }
 
+# filter output of "btrfs inspect-internal dump-tree -t raid-stripe"
+_filter_stripe_tree()
+{
+	sed -E -e "s/leaf [0-9]+ items [0-9]+ free space [0-9]+ generation [0-9]+ owner RAID_STRIPE_TREE/leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE/" \
+		-e "s/leaf [0-9]+ flags 0x1\(WRITTEN\) backref revision 1/leaf XXXXXXXXX flags 0x1\(WRITTEN\) backref revision 1/" \
+		-e "s/checksum stored [0-9a-f]+/checksum stored <CHECKSUM>/"  \
+		-e "s/checksum calced [0-9a-f]+/checksum calced <CHECKSUM>/"  \
+		-e "s/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/<UUID>/" \
+		-e "s/item ([0-9]+) key \([0-9]+ RAID_STRIPE ([0-9]+)\) itemoff [0-9]+ itemsize ([0-9]+)/item \1 key \(XXXXXX RAID_STRIPE \2\) itemoff XXXXX itemsize \3/" \
+		-e "s/stripe ([0-9]+) devid ([0-9]+) physical [0-9]+/stripe \1 devid \2 physical XXXXXXXXX/" \
+		-e "s/total bytes [0-9]+/total bytes XXXXXXXX/" \
+		-e "s/bytes used [0-9]+/bytes used XXXXXX/"
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.39.3


