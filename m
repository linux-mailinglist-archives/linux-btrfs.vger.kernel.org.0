Return-Path: <linux-btrfs+bounces-1216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C727C823BE9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710982885F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2201E537;
	Thu,  4 Jan 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IHtigLZI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UHBI8I3W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029A1DFC1;
	Thu,  4 Jan 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404280mc006617;
	Thu, 4 Jan 2024 05:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=iKC6wpn34RqY35D0LDYqpCJdTEpxogitCB+XDstU8pM=;
 b=IHtigLZIk54lf8riZxLHfrcQL7VjIsVbpTRyshl4WhKO8UFwiOBiZanRtB6BzsdvBtam
 c9ka5qOck3GBgiDJMry19Yu0zJjfNTv5/7mJF4OVWq+29wtu0NmVw0BhcDhQDt7pzVLb
 YvxaNIO/eYqBS8Ae1bP5TFfCT6FNkEa++JZHfES4QL8PIxtF/jdWgHtQMho1g0/9VHP/
 g8Saiijlo3/DBZ2AUdl690w1C1MF6GB2u/BjmKyDOxDMcniORSLMXqWwqAxtirrf3/Uw
 SvD1IyFeWES8Lh9JOOfXIoBJLjW+JOUis3oiMwpAAo9Pq4aH8aZed4BGRIIkIQA4ZBoc Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9t26fdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045lcoF015771;
	Thu, 4 Jan 2024 05:49:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpudg1r6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGgxF6VJ3Sw4FOL0r2tcD2S/2T/C9SjycquK2dOyiYDubN51IAPSMUfjM1cOmZLDVaAOTz5aTQtVrhWwQN2JO89jWDf3iB+3ePTLWH+5/1lxflJ1nOKrhu7pKb/sHqWZAL2gg7YgvcdLd7J2lf2Jg5k9dXB+qpP8ofoKVzlUE3LD0COi0QHjyzP0h1I7YefG5LzXXyE9/meHJgSuV+lcb3Non/LgJAXlc01d3xgzs9PKVGGwKRIiCqPlp0mHwxWqN6+EfgneimNc0oVRv7YMIibrJYtbS24la6nHHL8vwSpfes3fKo1jmOeaQkdcVFutWKl60rtmZczFSJYWdAHzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKC6wpn34RqY35D0LDYqpCJdTEpxogitCB+XDstU8pM=;
 b=MVGypt42tRWlgDBgC1QDy7rQCCfl23aeXAG4CEGP9b8bj6V+ssgS3lN+Ih4vWNu/I7Jdrj55Hp5G+R4Pf53z3NGi7t53kSCDUJ2o8/ZwPu88Bj3Is7Npu4FF5dOBARuJm2H06PEoHgtPSj7z2O+GLxBN/EhqwHjMjA6sLl1PjJGfCruLofPbOWx2vXtZ6DDczMdIKXnC52rThW5rgxlLRj/yWfv2X7tCpjgecWJXDr2xGtefa6hiEaSsMBJf2Ewc1ZTJTrB2NDLTLmZBq8q58zDTzPE+vlMlIDvD1OkB4opwx0eVR8LYfEH2sxeRA5yLw4hmzELywCo0fWwOyO+t7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKC6wpn34RqY35D0LDYqpCJdTEpxogitCB+XDstU8pM=;
 b=UHBI8I3WXd/M5CHwRMPxY50hjNuBxz7AeyZG1XHxmQrwN6vBQB7sRXMXAXODERyDQCQn3Y94xx4cx6iQw25cwwQr82oZiSphNTRim0W8msJtxTogsKTJVRzi18u/vgphU6i2jOUlZBcARCp41AVKhJ2AXniG8R4NAecws7lSyDA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:48:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:48:49 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 05/10] common: add filter for btrfs raid-stripe dump
Date: Thu,  4 Jan 2024 11:18:11 +0530
Message-Id: <c32ab6adb0fb2b2d332d9c67b54a2e749a8b5dcd.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: b398e086-ffd5-4fb7-4553-08dc0ce8d31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vIOOoWeDFIvp6AoSd4BjqjFZPP7WvxGzzNuCzrxBtvcrOKhv/+rhuyMZpIrY05mSed2HbRlahiBv7i9VqCv70QlO9ko6ZamV+ucpeSijYlJcc+iuDsB8ctNQPHPgMS+Zkfw0+XxqVkQeX334YQ46Dp5UbU9pP9OJgCOW1/4QRlBm18KwbDQtiqrnUFcVUZXQ4GdobmiC4aQW606D+mi+7E+mJyzxKOE9A+/NM0zYZytyHa2HcnKaG2wIDigzDOT5SykyjuevR/eTTQ/ED04iMYogssFCvru2EfYA0tYcFJ3GbbD+pAAuDnys+Oam6bqJFYVOHnUPMpC+dzZkNrW/MhPsVuFFd2N1bK8ofdnneOt4H485UjV/3+5xsEmqHBbU/76r3vu2WH3OMjtFMC9q9hgj1xsGu2leyhdKg1MjAhHUHlG+78i6iuTR6TAAD0kbCwwIjDK1AlTVQFL3ticBnHThIOd4HkVOWZC5cFV3tE8xziJs81LWU1AyBbfrBmxYqIbyJ9aF9qSrtaqwP585kw6UQQEL/gT7EOq7sw0C2FNdEY2PId1Muxylysqp4DzU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l0qdzT6ygzgyBe5d5NCSnHE36lkZUdVKwPmJbQzJWGVgFpO4ox2ya3ys+HDA?=
 =?us-ascii?Q?S29xY+FIEfkKeLQTAGMPZQU3GpAtzJkD2D+/rXlbjwr5slUjb0kOHLlk5LZe?=
 =?us-ascii?Q?n/6vo/l9TjMMN5NZCMvgHBq9wsRkAvzK4XLGUqcKwlPDOHbU94lYwJF+fELm?=
 =?us-ascii?Q?eQ5ez0UT2hQGuoo9B39BCBOrE/xF15zkW4httbgJXU2qyxVRUyhlWbAgcyNw?=
 =?us-ascii?Q?h7KQ6oMf1rmQ9bvwnhvqJfqvVCezRTo3NuQ3k3Bq4H3Io/gQ3MmaTwhAWwoE?=
 =?us-ascii?Q?ppSWqde1VF0HhqAdBizPpGHwfcNknSC1lXDR5Axp6HKhhiOaA3wjZQsNkXYt?=
 =?us-ascii?Q?cVS10Wc3WQNVpLbsgP61G0AWc0KU2tT5w4o82KyFkRe+TPODM+7cDkFgGZER?=
 =?us-ascii?Q?RsSGxcB9btixf/eJ6a49u6vlHJ/VZnEl3M70W0maiD/HUUQAEr3/9r90ILOa?=
 =?us-ascii?Q?nHTRyCVsn5UK8arz1rf6ZH9c1g45O2CYZZ4PYCrTcbqtVLyrKDw5PEvMAx4k?=
 =?us-ascii?Q?rSM1yFIStr4qL1rL5h63dQJNYZxYjyZL8SXEyb+3/BkzUYJ5+GpyJjf4kMa2?=
 =?us-ascii?Q?FBxjavCxspIZCBytb4hF57UIQ1EzLlKWrZYPEpnpMl5jeh7qsOhfy+D+JDRx?=
 =?us-ascii?Q?FGPaIyizDLhTeIrKb7O9ZpajB9ympHYtrHcqPPg7WnQ35H5/OaXeA34SkdYd?=
 =?us-ascii?Q?3dFkIpgk/tKzAYsbWAAmCAW1K0CtUCLvhUw1cm/kW+Jd/soBMabYPWmAdRG7?=
 =?us-ascii?Q?KtDVQJNFO/a6BPW1PnK9tutetgbek+tWCmyslAjzAyX3iZb8MXaTanVYfR90?=
 =?us-ascii?Q?iPlXxDVUIVoNo4xMyFx//4bdQEHtKIhDPr2OaX2IerrfjogPP1mZJHRyC19U?=
 =?us-ascii?Q?IAvdpl1g01yMFpDNJYjsM4xhskfAiPjV7N4C96dQGpOu4nCjzfy1EoqDn+a8?=
 =?us-ascii?Q?5hVPrNq+7lmr/WNOICDesSWC3XFqB31uuJ5BqgCEgFir069wbgVPZIEliSRm?=
 =?us-ascii?Q?2d8APYWLQoCq6C4YBBtgvHqQr8UdCZJLMMhN90+e/ThKNpPKvZ65Dz4x2D39?=
 =?us-ascii?Q?RN96iJe6PHbkOK0/AX6xckeEHE5i5C3Z/BHgtMSiurIsYubv16X+++euPDyE?=
 =?us-ascii?Q?PKDWlu9s7HeGYISr7GWd2vUE4k1Rp7yP8aQlINybVzY5jIeZ374f/3VBEsIH?=
 =?us-ascii?Q?8gt1uYJ02u3DbVuYWuVUFVPfVsPIYitcXCxxGOLhX+cKWfrvX6tq8PH4U5Kc?=
 =?us-ascii?Q?pSxdWoav0YFevYOK83ccn7RuQgI3nmYSuJHXjQGNL+fBa6bMGFrBRodmy/CM?=
 =?us-ascii?Q?ecg3LRzATq3cvnlPtoQB2Oi8rV1qHgoBNS2ZHP/Yz7hV1sV7WhTAVV9daX86?=
 =?us-ascii?Q?aBbcAm+Lh6TzRLmpBRhDxlos4bvZxCmZbnBori2v6YH/cmUi+NawHr1aMEum?=
 =?us-ascii?Q?XguGVm+AhzZGJt8dyU1Q94egTXKYayolq2WzIphy+aQqyCFM2d4y6ji510yU?=
 =?us-ascii?Q?zQtqad9a0uPg2kfoz996Lx0+XyOfn3gjJ1pAR/tS6WqJp6orpLsQpanTEq6p?=
 =?us-ascii?Q?LmZ+yD+5Vssv44vOmVZ+zLciQjcfvH8JdM3dRtJt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZASZO6U/sD5NIlcb096BZ2aJ2a+eGguQoaCGBexe3M+vCtp6bP/H9an2xpkznc/d1Ifbevw9f+2l9bpiL14W31e85/g8jJS0EJQRJRh/0HZZdi3Q5U1Zazs2SqhJtkKy3U83hjB4PY84u+xQUtJ/tLv+zeZ7QBT4eMZJ3u462xOMHrCgipUpFsQGLGCoaF+/L5QXnppV5yvWM6gV3f9qs9m3+eJ6erJuFi3fzC7/gQtLBrIlEyB0jPUv68CXxtS9GJUa2yRPHNWj5o5MkEWFJWCT6LPoD0vPqNfZgT4xiDWcHD7WJxCT53oBpk9VlrJDh5W+Hm4c0CxKk33gbas0ROk0k8zxTVzJY1W0A/coH3Rgdniz69ip2pLRKM0a4nFi5SrRWqQschEZLnkr5ZUtk/PUNl+2GCLQT6clrcyc6OuNx9BvpLg8KHT5uSKP1HHyxc/I7jJjbAk+R9aXxgt+HiiOPEiGZh0IrtWP22Uo2lR20ssx5I16ijfTHU3N0/B/dX1WCkRfyeqFb4Ezh3MEhuezXJn5EIXNwCbCAaAwLDxlFWWP759zK857BtwigVgUbU+VhXkElmeI699PPU6aOMXd7TSMB8/1e2due9eKNwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b398e086-ffd5-4fb7-4553-08dc0ce8d31c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:48:49.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woFiuUnZvcVuGNc5h0gbgBht3rOx/gLOfPPQxKGAf0un7Zulyu5yCGxYfqzX+Lme+1X9XsRHAF1srQ+XPv+VqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-GUID: yXrhidQtjJV51qsb6cM079zP1gG8oZc9
X-Proofpoint-ORIG-GUID: yXrhidQtjJV51qsb6cM079zP1gG8oZc9

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[ add trailing whitespace and the version filter ]
---
 common/filter.btrfs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 8c6fe5793663..8ab76fcb193a 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -126,5 +126,20 @@ _filter_btrfs_cloner_error()
 	sed -e "s/\(clone failed:\) Operation not supported/\1 Invalid argument/g"
 }
 
+# filter output of "btrfs inspect-internal dump-tree -t raid-stripe"
+_filter_stripe_tree()
+{
+	_filter_trailing_whitespace | _filter_btrfs_version |\
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
2.38.1


