Return-Path: <linux-btrfs+bounces-1156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA9E81FF62
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF20283BB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D21173F;
	Fri, 29 Dec 2023 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fkCzXiLN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CZ2MT9z4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B61172D;
	Fri, 29 Dec 2023 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8O2u5030071;
	Fri, 29 Dec 2023 12:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=6TTvbwtraQDkFvT55vMDBshuPhLd6jw4iC8y8ZykkjQ=;
 b=fkCzXiLNX4/IqqaMN4Oj3gPeZKD718AUeqZOexaM869dYKTuTGj1PemECY+lI7GUoBwm
 4Gd/iQiai2uQYp8EDjRKsQMrdMKbu/Dy8oi+yLn36El8pSEfOXVzA2ejzLzWfovm5MDu
 Sb/FqXoxzwrONkfK9wEmfluSw4u+ziUAWobVWVCtLA34MwniUg08JYTlf0duE+7mCTC9
 5d1SFJ+zWzek1OYn99aMx8WQ3p5/f12h7K8XvzqQlJ4acMZR/ZQbxBRNV9GqnfeC5LwP
 TcAZb45qJveoVbrM0VMPAMpCbSgMG5ZfCU5jbqTc3iURHIn8oseFt9kEc+0yoMjUMlJn vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5qkd7k7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTC1c58014160;
	Fri, 29 Dec 2023 12:23:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v73ade3cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLMJsYVzFBZOnSggVZhPCv5uFN47S1Ldwjzd93EQN5zCeQyiAhPAQ2X4P71zJl5Uk+w1p8XGxGec/r3BUm/20I9PgdVVMPc7txgWwBxnJgp1eSh4/Mn6n7QvdoBtzQIZtYG+Ygfa/djwg8/6XnKEgHnPALVqikvN3640Ma8cZFOxBV8CtpDVI9+y+iUW29Pd5Qu8CdrRLynsFomeC8J9BCbLsAD67UGy8e8Y7nyG6EfsamAqv2wbQqDFeHp42XyUZObYWSpVIrZbKdnDzGW1vsQ+sYKM0bJPsqrJ2axuzunCfyOGyxFf5+zxj5j62CdNlM0y8f7mgd6nn5KhNG+GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TTvbwtraQDkFvT55vMDBshuPhLd6jw4iC8y8ZykkjQ=;
 b=OalQOfib/ywtHktrtZIUhj1+42GFBne2t/IXCI49EruLnutn6ipbCM6tTOZ36OTBQ+J0bC74DxpFHTh+0TJvxUq11KtfUhQcVGsM1CQF6H6RXwa74TQ+968u2koAGJqU/qT50KW4KxDCgd14xUpmc5vMTdZmQhcohJDC7H1sfauc2PDyrWvEdHFuHPmVSNZJGodcHhXp5OOyR9A2E/4fht3iW/mUkzzAOyI4Wq8Kjs2suAJgUYYoYP8ACrxsK6bLDdFZKvGJbeDhzd2WDRIZbKhGRQ2yQ8v8+cFsIXUbDSBva4/L47BovPVGIudxOorQg+oUctSGY0tVJBVQgbebyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TTvbwtraQDkFvT55vMDBshuPhLd6jw4iC8y8ZykkjQ=;
 b=CZ2MT9z4EliK6gi3LVRN7iZQqczbqz5KuKoA0cMdK0y6xh9NSn9G4NFLgacZwAg0Sb/Exfd32BYpKRcEMOoZ1uATt37av6y2vdeoeUTS6vENorBz9Sa2MT1XmisygT1rAzb3gFW4j2LZsHTh2CIebYGq2aOEHIkUbmMJqKbp+WU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:17 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 04/10] common: add _require_btrfs_free_space_tree
Date: Fri, 29 Dec 2023 17:52:44 +0530
Message-Id: <f2a50d92e77c7f77f1743189cf8de70952f652eb.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4ea386-842a-478b-21b4-08dc0868f00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XovLL27f3BqguW7LUusDPGDT9ncN0mieumT16toN3kgW/+hWt70s/ivBoR90Doe5q6Q8ruHJlBVdF5435qc0zaVCR2JINs5EK9ey1LhdtM39gH0OiZim9c82F2qgYtoiRB3EkpctlNlkZmOwYVAJF1N30/J1I0XihG54kCe4TXRYwPbFxQe4A7Dg6AwcmygeYZCBLQ6P5G0N5wpNTJYOo50x0K85lGrrzquemCVGRU0AUprV0mwv5/o5spO80au+tzO6pwz/aLIu04iLO4Xmt9IMRstZ02YSw79zv7ZxtbEhUIWziOqPbIZZH52T6klLWymxQoarkBK14Ri4kyZGeFP6KfiK3uSaIgoEMddSk5AgVDybd8xEa7h8/2+8pl8XWchsHRrHwKiHiStSOZHldUjtu5WeG+c/9cb7jQmP1N6KGRCdtE/kTOxDJdiUgeCVSHe4jDtX8ImUBN9U7EIhCUg+fNdDIR09CwN2twIFLaG2Onz0BPBENznYPnQhyU3kGrp0rhfdzvzU4m8+wA8X4MLklmK+Dk7G9Jv8ogkDpcs0qhYOcXNPjv9RoZAkqHgU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(4744005)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pgNQ0RVX4A7TgsC83F/mtvd+dmfdLHrUHPrSXxMsNRwW+2hGUtswHY9/j443?=
 =?us-ascii?Q?CHAbMFO97Ju05X8hcC3hnZ+4qk6EITdwSFvfVFLj9SI+hzMvmvEpcpWvp1XL?=
 =?us-ascii?Q?ENY08MJJp4YIzoW10mdfG4vvnegbeltXvtM1pPU+inq/qGtKoiwI8y+12gFi?=
 =?us-ascii?Q?EV8F5lSBVN9HJu2XzmCxsf95D7Tm5ZVh85isPQ/j1p/kvfzK58otBNsv+vQY?=
 =?us-ascii?Q?Z3UhS2I4R68B2oQj7t58a39ndce92QNxfxu3C9h0SaqRejTnQHNsLrLUY/As?=
 =?us-ascii?Q?4Zbto/vwyxQh0zfYR20kiH+jxjklbVMMdn6HaGUwJL3vqwn/cRA+bhl+/sIJ?=
 =?us-ascii?Q?34u06/215fmasw8dB1O034+5W25G43FCgDraTExQvgfP6Xje3Kmem3WkRqwT?=
 =?us-ascii?Q?hwudMMH2pJb8H/xEGga3KyUzZKufxQI0aSdAx7TL9BF7Hxx6r62Lf4PsQj5N?=
 =?us-ascii?Q?/0IB9DJbqa3ZqhCrPK2lq1nj0my4W/AgQq4F7bSmv8aQrvH8uA7T3u64VuSC?=
 =?us-ascii?Q?TsbjY0tbF+YqOZO1BzH6EdIwsjMo3hlK5RTuKpmMEtPMIM+N52QbeYkv+BCf?=
 =?us-ascii?Q?fV/a+PmGB7FNMsINdrKLmlG61CmZ33RCr+MXKtnDP6lSLxqPZQ3OGqKSWWpi?=
 =?us-ascii?Q?v5Dcqgv+0oljeXDq2/8/hbywBcH0v4suij/TAxdB+4rZpylKxlnCcgMfj67L?=
 =?us-ascii?Q?0yZwvM2kMt7loLdyCUdBQlr7wlB8mwwQF+++nCQreWDQxwRjWAC3cJtrn0J8?=
 =?us-ascii?Q?C3iaiA/Isn/iGOhortiJ7XUveaj92B0d70jOx6dUSqkaXCMX0IdaYugj6SuL?=
 =?us-ascii?Q?GOBRb6Xvy9hkI1vpa6Gz1g9hjXHDkcl+yHIn5U0Uzowxsd09P/aYblGeCQel?=
 =?us-ascii?Q?wmmZe8PWKhsqkTZ2Jt1h8JtWF92jfgOq4Xh5GBl3v2zMHrK5pJhRIwoFtR5B?=
 =?us-ascii?Q?0AdjJ4LEbev7wWDbIPoAjGw1R07GVEMhfQ5w3z1gFRNQMQNbHgDVkMQvR4qc?=
 =?us-ascii?Q?0DDoVt9PkDSKHzUvyBctVHRDjfd/p8sAF6Iwnp8m8FSMXLaVwf/Zd2W0LBcz?=
 =?us-ascii?Q?bPREwcBn3xuG5wD2yX2jFZddWCoXi/XKkiYwYJO9uN9kEGEj8eyf3s5ywImE?=
 =?us-ascii?Q?ZcnbQZczPzECIT/oyd3bzGiKpgYZWc2yJ0qVMwjUp8c21KKdQgmaOIAabFEs?=
 =?us-ascii?Q?Y6oJ+4XdY4DYkqdk9ytDmSg3rwhXhQc71SgwR2gxhSvd2gFXbXsbs9lXJIZ6?=
 =?us-ascii?Q?DDvUNcrIwQkC1IUre03Y0yx4VTryiFkIu9drkNlY+KUqI10tIdOI85B3AJpt?=
 =?us-ascii?Q?e0p1540tVoiORwM9YBqA0TLVdiqKDiH+VpgjuiGXk4J+Zbsjgl2QATGfUTOV?=
 =?us-ascii?Q?MtUP81Iyf5YQ0JR6u5ANznpsCTCYojxJeykbWS5Zw0HK0I2vUQWSh/dDYw9H?=
 =?us-ascii?Q?emH5CeVsQDCnNUbVrsfHxwPi+5LirwMZolfG5Z2vCDYkcIM3t6vnF2/NzbAF?=
 =?us-ascii?Q?jxgfJHYmrSttYTcj8kipFpsZG9O6JApnON18hhpFMvaczk8oMU4Oba+krEBX?=
 =?us-ascii?Q?hllqoz2Izl/ck8Ta3q5MOxu+aAYAwZaKsXIMkB/b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	czLeyHOIrcXrOhB4yAocaSGd1RysvzNSDh/8SQL/qyqpNCZBkXprylarAQnLAeCvRpWs03/ds6scMKRP8auHhK+wxEpg8AZiP3dMcrchC6Jmdz7zmybfb5B1Dgy/7Mu+937p9FMfkviz3RvrKyY+dlbNmOQV/cM/BwZaehgUJkjOAZYUaiU1/7C2JOysC89T8+1QgIhvve7ivhqZJYOp/3zTwY9NpfHfV/5hbhcfCpLNgxdTpqO4DUb7EeIuFcC1O8QQS9clHPSnkEQ/qA6OO2TQ7FqbM1L66iR3rfSHN9hI3QJwfWIw8JXt/C/PSWpLsTP6HWCusUnQWolvWEXODPn4PWtIrBJPxU/qCaFwBNZAdzfYjDHRjCydMUPS8xIwf3VDm63zrsicyRqQvyR3MI3P8PLGn9xGneGUqHsVwaFpUKrxSGtRegCHsnF2onkD+r9rWsFHOFst773A4P2KqYswukJnHUHeDr/H+0hg5tMv+xvHDWf8bhiLgDBOIcg2hAan5gXOXt52aZLvQbg51hNyEQpM0jQiDdTPKmZBCtFKIiDEhjrykBF0RIsRcFNh7kmLNuv43DjbFZoSRCB7ctVCJfeRBpNxkCAfdLXWkTc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4ea386-842a-478b-21b4-08dc0868f00d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:17.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoCYtCWaAIHV4HY4Vgs7vBxFcMWkB85wW1VurID/SHbimQzusVktVDdMAWIgLyWz88wFqu6C7p8h4O0PEXOPHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290098
X-Proofpoint-GUID: Tm7GWr5dL36MkL9jOKGFaFtYG2PfZv27
X-Proofpoint-ORIG-GUID: Tm7GWr5dL36MkL9jOKGFaFtYG2PfZv27

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 9dd2a7f49e16..e1b29c613767 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -127,6 +127,16 @@ _require_btrfs_no_nodatacow()
 	fi
 }
 
+_require_btrfs_free_space_tree()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	if ! $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
+		grep -q "FREE_SPACE_TREE"
+	then
+		_notrun "This test requires a free-space-tree"
+	fi
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
-- 
2.39.3


