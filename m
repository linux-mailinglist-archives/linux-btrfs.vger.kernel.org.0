Return-Path: <linux-btrfs+bounces-1153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1AC81FF5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A46B227CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B487511700;
	Fri, 29 Dec 2023 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hU+bYvy0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WM3u4TjF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E139111A8;
	Fri, 29 Dec 2023 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8OjaJ015270;
	Fri, 29 Dec 2023 12:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=LwbKa06U00fDv+p8TtWC4ombSHzzfMl70/LnBiN3Utc=;
 b=hU+bYvy0lyQ/YyizJsW1bw66iub1UKwjegU1IJiRlJNkId1gzmU3BDKziRIN/GEYMEBO
 LUQZe3H557a/uLeNoaioBEEZyUHrHVgOTIbyGVNCC3o5JNQam33hpefLJN2jsuQ0zVTH
 vOgEcW0R5D2nI0OBUn6sALIG1n4TfBRO494nYFV1MIcQNBn73nTcUaf9Fe48NLwhi8G/
 IxwrV/dH0Vs4oGzEbsfqUGjbo+AO5t8LDHnV5KwOAWf6EsCGX3zCvAFtTe46XvIg8k9G
 DynWiSd2VjjOCuyOJ4JAiRhAz/B8vvE2Oo/rH6+BpHG/f7ELm/fQWmcU9sC/s5g4/2Im UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5pb47km2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTC4gcI021438;
	Fri, 29 Dec 2023 12:23:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0ehe29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGb6go1iZDThgzYzYOdwlJ10z0W4/6Ezxdry0YatHNaYjOEX14PA9tir1OjgDnhHxvyI3BxQV/Vty9nnEVRB96cF6WaiGsZFSpK/IXmCTqu3JXW7uoc1tXD9ri0oe3P2zO+bau+MKQeOg+w0yrEN5q/ZTcvLELpH3H32m6hCxHyYhzozyusH4JGVk4aRfzQBbK6MbytojU9pL/cUfWrty4T7pViKeTUq4gZtVC3sETJHJ7MkFZgTvnF1K9tq1rukIufqXEjIVgwlzjTuOMizuPbh7XSStzV4IkZYgP9/Uh/VXddHWPhuXcnnVaDoeKh3mqwMmdcX0eNn+enInVyU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwbKa06U00fDv+p8TtWC4ombSHzzfMl70/LnBiN3Utc=;
 b=mkKoEpS5UqSJ/WBdDDMsbu4+cU3z601g+URHYNgLfIVaz2wLUPqy9QgEUTEzC50hVv4LsGhv1JaZ1/3XfnNBHcSIUCsPJEOIVGISTNxFpof0haqEx95Mwm0QFikvBaZJGE8Obt27GlAvWfO74VqNt1ukTb+M/Iw/vX83KRh0fo79c+u+/dcKgZhUaF25+ONyR1U8j1nUDyeeHefKSmy1nFRrheT2vqgZCj2Ixs3if1Of5qkRvE8Km+Y+nPGfFtd+ufGfGw4vPKhMmX/GjAHZG+9DIlkuhMdIvN9Jgxm00vRqngxg4nRG7gm0z8KVpWqU6iVWjzv2aTG0GXxd+0hAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwbKa06U00fDv+p8TtWC4ombSHzzfMl70/LnBiN3Utc=;
 b=WM3u4TjFi+iLLVeUhd4X/xMVkDv01caDw01ubrRAbpmy8GwZm8hB8TCODTcOTUvmTpDQeHQ/aFpVSSt8uIj8kXQRJ8w+QSViOWMcT28bJn/IGZdQ0JWA61HrjQFDgds0EcEpfTk0bD0k09HOLqPt2g7Mk15n9l3lCT0xAbAAAu8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:02 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 01/10] fstests: doc: add new raid-stripe-tree group
Date: Fri, 29 Dec 2023 17:52:41 +0530
Message-Id: <983b2fafff61a3d116554e3b4c1477793fd9270b.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe477b0-a9ee-4844-5467-08dc0868e6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Njc6IecVt9qzjjEPICPE2i110IPZlA6xiwThSLC9pMX3l478G+b1WgrZcmCD2MrS8+ZYVO3EtPa4WmdMC8OvuP52OvHAllY7ccZnqtSnTVmQb9qTxCGyJL5YOvabPcfFG3hoKHhEbhDOmkwFohAZKCRhT5Jf8XS7AC42a31p7GT5uMLsjtkFPuD64RRwR5GetcgI29MHKvq7wXMIun9D0P1dpgv1k+XHQ9mkNzlgiEd8tAVAoMPqfh9JXuPIWaeT9uxQEO8ZFtVOwC7m3vhr1TAv03QLvl8mRPthkwFGKt5NiTrSGt6l+6KsIBd8DciW5xVaPZZaln7uV5VwbS6i/GBpb6lnv6qTpkv3FUQ1gJvI4lvGEpJXUOLU9qf3WycWoghyNNjYLEYiNdlxtPvs1KsHaO9wkzMWCjiDhmdjHmY+n/BEkP2pbnxFM8rMb1MlAfQ/LbwjsK0ZQo6SWvDz5Jt/OxcSrMwW8wgRzfQnFEseErXmulTe/khsJktCcFP0WI/bVsDR1Xn5eIaRajIiCp40fYdV4fB8H6TFMd7oOcRu9ITIXys6XT+h+NbhLuRU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(4744005)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dCFBuNdO3cm0STeLuAIcQX8mk2BVNQye6dTfL1lq1pzxyecDjSqTFyziGaf8?=
 =?us-ascii?Q?nfiyDAxpvPcyw5Alf2gXMCGPue2/2YK/KW+GCXkTbA2Awphhv/jtHVLoWuTx?=
 =?us-ascii?Q?FC3EP++Zgh3gfoa66aYhL9W+VQPmepwbNRw/QrRGuQ8pObcj4N4rSOyWTkkz?=
 =?us-ascii?Q?pI7kigGBZCmiErsn3ciahwczffrYhW60DRC4jXKC4jdTUTgAR6c/fviJr7JU?=
 =?us-ascii?Q?K7Uwssrgf5sNM2sbg2/GoqbUnDfm0dzwmdQC7B0het/hY4K0Ve0Nrpx8M0IF?=
 =?us-ascii?Q?DaIm762C9ap5+PKaYTGE5II7O5tfAPPUbS7nw+zjnUyturoOGMOybZkriR96?=
 =?us-ascii?Q?GLkNIBCBXvlDswU+Q1n+8wsbhKVWTy/eTDbXG/UhQCMXvemCPTxBmO0pNiqE?=
 =?us-ascii?Q?QhTIMw4Cn7kHXcklAv5TisbeygKkBHIEgk4hrInj7jykLDKQtvp9iSQCyQdO?=
 =?us-ascii?Q?K8YmlKAzFy3YzMvWQI+EvTuGZMQQ6gd2lAt/5FVefe0AZtKssEYyTRyE5rsi?=
 =?us-ascii?Q?SdJ+WdaTGh0tpgSkaiwZYlocTAHPoobmwtSyFIIRoRO8z0M9lZw2PcmXrj0c?=
 =?us-ascii?Q?NgcfVlwXVwqjaRqTJ4mIZBNs+8l7TFvY0azKwy3KbJ2RCbA3Z2kwb239kqKk?=
 =?us-ascii?Q?p1WsKDHOImkDQPTZkuxoDTrlzN0VhXZExzJMom7VSGIVGwUTtTs2dKap0pyT?=
 =?us-ascii?Q?wnEhMqYdnBYANaOWKWIjl+8+nCY3UuW0pxOwWVqY8HbhnRx91D1h/Fav6Eev?=
 =?us-ascii?Q?HSqCkC7ch2soO2P4qef78Xbhd50TwGOGf+nD9wUHpS6clcwReAc9URGNzjnF?=
 =?us-ascii?Q?j4rvdDb5/LDO2zgFz4Q1+ov6wvaxtFnGSbgFWhgdVRxnSL7fD07a9ytGylvG?=
 =?us-ascii?Q?rydYHHiworc91HdnR3dBhEO10FCSXvLdxhSJZjB1YEcVF5HXWOGSx0NLVPey?=
 =?us-ascii?Q?qFrAUUYy4uba5erhvatMuQYK0YxCWqpQykgPC+F8/XH180CJIAzRaAl5uNv/?=
 =?us-ascii?Q?+pKwM0OcVKYsMOY6aC7hzCg5VLkUM8RE/3s0+GpFHbyTgfcjj9b0qDwdAcUp?=
 =?us-ascii?Q?sP6IP/V8+019LdJdScodgqggsDlJ/j9aXtmu+UNqaj68OSzoqhN7tIMhqkaU?=
 =?us-ascii?Q?3ebNCqOlhNZeFojzxvyQGh0ovTHO7P4NiYdqu0/KfH2jsncZRPn1Zi7C12Kh?=
 =?us-ascii?Q?pcoeknBS17y9PAh+9YanxKbnzIp7DOMO3kE8Zjv5Rlgs3nOrIuBx54nYBDnw?=
 =?us-ascii?Q?4wDlUPnOBUgMTq5oncAm9uD3ccG2aSHe3I47W2d8/7f79hdjdKSO+3i88xwt?=
 =?us-ascii?Q?q9/iuj0ZD2bHhjNyW93+Mo5Cr5klZw4jqtFxZNnVNfRvPnHk+VCVh/VBWta+?=
 =?us-ascii?Q?AxdZmA97zyvBqx0UbjM0iXzSXQ+5ZHhAbX6nvtCopFU5Ck4xtOUIp1rhUBq6?=
 =?us-ascii?Q?cd21x8Op/a42Z52skiXgx12eP6fqw4sHFqLpa/lXusbKBXXarzAyE0SMpcu3?=
 =?us-ascii?Q?DD4UOY0FtILJ8GyCMYuQlYGgoFLKH/1v6fHfUXZEQ7AisBCEmP4bX9Etubwy?=
 =?us-ascii?Q?Q9jnlkSBskKC/BMjIh4hYb3H/2VRYdbpHGuEx8tp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BgMCQI/f8xLq/Im6MtIottj0WV9jQvsxmOMO2/54LXFOLuMTqscmioL/64vvDYbr4x7xcbqRWgbmetvAuz5wUA0Y0hKZLwn9gyCmozV+xpclfd23k3PPKfgGhiFHCzmb7p1nPAJqAfw7QsQbAi0MuFE1XgSZiECv7fNLdL6YfBCMzcrYKotDQpyG6TWcnAZWMUrpdxKN+c9k00dcFqDa7OEi+fwCbBmBhjbIi7vxkz32c04R4EvR6NW5QQbROW4d05UxltyGjahYsVZSKg/n/DfqiJ5uk54R1kM1ALdxBV43ak67ildX2jCz7plM/7Q3aRAVqLcbZeBCGUoYSgo5lHjgyZCFylg/9TPsLJMxNfaz1V0Ra3qRpPjuZazbG0HH+lWNfCR3TXIlko/QWHVE5X61sYlzxw2HrTSFpXYJKo0iRQRvSTFBqhfM2nBO9o7sN9ryG+Y41C7TOF9CL6o1RU6UWyNtKPe/pxibOB30OOtQbmSqhCMBZulycdjb/O8PXOVSWK9bITC1No+wziSn6SiG718odAq7HWo24zE2uEFK1e/dErTK/92INnk/29a7XiU5efblL7cTfGrTS0N0LOXAwNSdDHKA48L8mgfp3Rc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe477b0-a9ee-4844-5467-08dc0868e6a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:01.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H97reQhKpPEOySiozFWL47x2hn8GTrVuOUN61M6nxrXWQOIhELxiw3U6GDP/Tagzjj/q0AyO1GgbYCbcysB5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290098
X-Proofpoint-ORIG-GUID: -dOkN1UjtxHlo8dnxbu49WlBMu46GaUL
X-Proofpoint-GUID: -dOkN1UjtxHlo8dnxbu49WlBMu46GaUL

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a new test group for testing the raid-stripe-tree feature of btrfs
with fstests.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 doc/group-names.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index fec6bf71abcb..2ac95ac83a79 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -94,6 +94,7 @@ punch			fallocate FALLOC_FL_PUNCH_HOLE
 qgroup			btrfs qgroup feature
 quota			filesystem usage quotas
 raid			btrfs RAID
+raid-stripe-tree	btrfs raid-stripe-tree feature
 read_repair		btrfs error correction on read failure
 realtime		XFS realtime volumes
 recoveryloop		crash recovery loops
-- 
2.39.3


