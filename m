Return-Path: <linux-btrfs+bounces-1221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF50823BEE
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3DA1F26BC4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C021179BA;
	Thu,  4 Jan 2024 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nvox5sYR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LVJBBpvz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B791F95F;
	Thu,  4 Jan 2024 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MLgci001984;
	Thu, 4 Jan 2024 05:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=1gcqeyqRrXesq0iCHCTMjAS18ugSCsKZSJGsyOu/FFE=;
 b=Nvox5sYRla8mo2G2j9q2MRlQmPl1crzWWvxDrty2zT3CEgDtGxUmfVQfRsY77FUdm/pa
 iWD6EUXwfd5rxLjivFsCaG5mA28P5FEJlZlRtAzlpX+nBVsvh2ehm9zR1mQ1Bjj0pxmH
 +zA4deGAxXVX7RP3zCJG+L2ydMOwsPwOOx6WmZ8dDA9ju8HurEMktfk2DAI0owo04pzM
 NrY2NFNHiS+6BDdk02/uMYusU/PIDtw/Kse1GFlPKqEX3gmHoLU5YJMppZ2UAqfEstXF
 LAMKCOUpcb61uFIstQzV0ypIRAnS+plxL0EbViFmpoiLY2hgKTXyjOq45NxnP5nrK8Z+ og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu6bqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045mfTI014824;
	Thu, 4 Jan 2024 05:49:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpkc18c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu7+vHUXNs9GKYrBRnII5J1X6u0BFIjV6pHE9jlUQxqeXHAwc845U4568O+twJY5Jdr6KTB1QSmGg37UfT4VIIxgE+LAO785AT6Pha5hDZpg5Os1IBVgqPaFUJB/w4TP2qzDupxFr26iuObAQomEeYQp8PEtOxtYbPtIL1BOL2+uM9H42CaH4AJ4yvFAwGBt75MuzzSrkPvUm5psz8U24i/fCQScNixgo5yHRTj8aBPuqfGkYhgJqelN4jieWQfQSbkhCl0H8CCyyBepgk4LQnLQBpp7qzfKjkDccZrvvqq2fcHMaqw3Tt6WH1OqKNntd8OfA2Aky0K+jEjzK7mEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gcqeyqRrXesq0iCHCTMjAS18ugSCsKZSJGsyOu/FFE=;
 b=NjpglMR6xF+dQB+WWtUjQbmhMSE/zw07FhTEFHDyHfnw0YgDeDaqDUel+RIpVs0nSfQ44cuu2GkWcpIn5KpFxVyLOjHJdKV7HtMlBOtXxGRyiHmaUKUp5MsDGXhKIS9t+J1osV2K9mVWMyEJDt4puXWUhvwhs11+b58J/9KCg4ugWyXqtyTTc3gCHqIjEp4wlnTj663v7rfodHH6SCxy1hEeVVovQYe2LOeAkEDj/yzX0SzTECmTsmVGWiwCwHmkvmTlaDDFFa6aNfW1AjjuM9Syx53J6qV1K8loW2CB9SYauybXu7NUxKtZ79zMQk+KwWYBRxxMcc/T+2pQGJa0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gcqeyqRrXesq0iCHCTMjAS18ugSCsKZSJGsyOu/FFE=;
 b=LVJBBpvz3EgtLd3lEPqCDSFTwT5oXGIAcXsJrpZT6vu2SmUbpmENATky7mvu241A3lt8HuyzBq11wRFv1wOjuz8DWDZIT0M8Bi8nqvsXkPKhdwFdAslVau3x6UZCP8XwwzuFml8IZPKN0uAQJP1kL4NiGT8cQhzFefRxD8hwI1k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:48:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:48:45 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 04/10] common: add _filter_trailing_whitespace
Date: Thu,  4 Jan 2024 11:18:10 +0530
Message-Id: <6f15c20d955e7a0bd57c5647ad0f6548af43fd2e.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecf88ba-41d0-4c4c-b5f9-08dc0ce8d080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5iwv3z8ZfqSnyGTVn4vgS3mQMVU1apgQD8KwT/30gWKDPMNqWf+J0j/eakwOubFcnNSQIIILA2+d1KrhT/ycotIYskP/OxT9CIDbZOTcC3FENoKTgsKYtVicIQ96sdH8c7i/ostre2dCEKOwxwmtqTIQ1EbsDAagHZ72feyprMzg88hFLCc5in73nQ8qePO6iW2uQC3AdkfqZ569rdEkXHcJpGEG/t7GuJbHefs7jW1MrWtbHdKqcJPFZzOC/yujyvShQUPUQkuAb/vo4Bm19afwHeh8NAsKgl09Vr4MEkAPa37fvpLmSq6qbOXWuePzEUpHMz9Q9nlgVzCIZk61Mkoya8dQtwMHmh3sTx5fVYgTNaDr4X+5mcE7/XGX0VHn9KOFd+PPnxJrmrtmUQzU+7Xwnz2tV6+fBPbhxNGMrNECL8PrUHmf81PslP4OgawyZ5Azx4+8h6rV5csnyRjRNhuuKzyD8Had7xe4b4qD0mKUaO0Yb5Wi3Q1Ydyp6++qwWS9LFZuhPOuF6lkrJXHoSu45la7pmylltfkhJKIoeYmfE4iLbwD3iRXKyPORfDRx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(4744005)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vqq0YPDuLH7LSgMCy7KbBXEwNCoQXSTRaAWy/QvzupCMiCNdLBybTNicyvK4?=
 =?us-ascii?Q?fXZYuUE5qfuH0Ub5RUNgNwtaBQHy9sNvCpn4Jf0ofrsLk25OsOmxgeb9WgG2?=
 =?us-ascii?Q?IwChkkBj5zsVtzN+8k2N1wmz0o+Ei1DURkCyc8VtAi0mQU64sbS0U2wb2mq8?=
 =?us-ascii?Q?Uq7NKraljePyEx1w1E0f3z/+cNoY5ts+yduel+N55hGOJtr223c+wkxY1heg?=
 =?us-ascii?Q?eeD/3kRc7477FceEaEzuLj+rdSEn2cUwQBUqTmxoprlW6FK3+PFofEIOynHT?=
 =?us-ascii?Q?BomAm4p82cGUCF8iznmRKHHt75dfUn6wTfN/U4PUWpcg5+lks+Pyrjnl4lav?=
 =?us-ascii?Q?Zq7hRrxJ9egS426uuS+S/Lc4Utql5pYeg0i7C0wCZAsLoCcpbpqJ8MV7JpRb?=
 =?us-ascii?Q?NBkvCdi9annkd3CemL7PzdE3lLBrDmruWyAFkXVo9hFkdnX2WZ8LPGy826g/?=
 =?us-ascii?Q?UxUY98P2fP38faTOseazif5fkKWMqg+torIlUPiYeqPQUdUIsyXCMiTOsYa5?=
 =?us-ascii?Q?T1ATgOOpA2qjA6UV7jVOjKUC0OwJxSqPWQdxyBFizwaxmBfV8aMYHJShgWuf?=
 =?us-ascii?Q?uydtEhQEJA8fOE7qrffeVJJefJRBkJ1ZvPPbu/k3TvWCnn31DuDtU1dVzgsJ?=
 =?us-ascii?Q?TlZaALp8ar1P6g1Pv+VHVtgnY94V/YwGtxA5Y6M48Ns6NCES8z/hCZPCP0PL?=
 =?us-ascii?Q?nu5HV4BlfmWEm9fM7AKGDNMSvD8N/6Ku7E90YiSEVHeu96nQIUrrYm5SL3UO?=
 =?us-ascii?Q?ZMciWTJQFFFDLL2WFkdQWvfb8ufvBtpL7IRgCvGwVHllYuQxkdejsXvTh2wA?=
 =?us-ascii?Q?p/d2OEH+siTiLucMKKBlW9C95w/upKFPHz5RdgN1tNYtrJRVOn4mB6mIrjFu?=
 =?us-ascii?Q?ViZ5QiUouSlxsmF22vZZ3gFeyu0QneBS/vv05+V0a7Cw2+8IgsApvaJlE830?=
 =?us-ascii?Q?DtTURAyQes7jxHnTxtAFB0YXBQu4IFVIVkvPaEBCghNuj0FQtVWAtH0i7Pm+?=
 =?us-ascii?Q?Y9U3xU0io7/0S0RMeO6oNhZEOsvNQJRqjJrl6E1Mx21Z9I6sDq4r/vH9XeuA?=
 =?us-ascii?Q?E7i29LidKxsCauJOW3yKKz02JNywCCQF2nDpWlvV97GiiUwh9o+3nE8hHfhP?=
 =?us-ascii?Q?+2nBdbagOjzQHjGrBWeTLtt+MQjURgrgW7cEwYlejBnW7ytZYTgjTf8Lya/j?=
 =?us-ascii?Q?h/nWLJVn8JGHJnX5oMe8o4JLPm3juZUI+T+qVGOehJvBcLJE+DWSZuJ9uikE?=
 =?us-ascii?Q?3sXExZO8yYdtVGGNWmWhpIQ8fP6WGuFCn61s3aOlKItqX6c2/ea9GBzGjgIO?=
 =?us-ascii?Q?5WwerC1q5uWr3WHFUS4vXYhpcdU1kmo3ORl+51p8Hw87ZLPbO1kRxMScox41?=
 =?us-ascii?Q?xDop+6rL5j463B9WJ8Atmvi7nlu2CmgMmFJshaX/sK1PDv4wHCqoFZ7a5UPl?=
 =?us-ascii?Q?d1MvKpzFNGJcqOj6rG7paIGwQILrKIYrteRsMFj2agkOhNCzo+M2FvfKompP?=
 =?us-ascii?Q?BpAjhMFiKI0iNUPvAFDrMTcySXUJFCvR7f4F33Sojzp4h6NfGHosEG7I+gcA?=
 =?us-ascii?Q?SpvGSoSwBHkm9zhnhxB5dUOGRC2Zu2rUysyuJifB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qvckiaGrYLiJVi7kaoITQfcB3ZlpdLZg7py+9JNttKCCt7//8wEYQly4o1wa/8NsgGK2lHBVtzBK33y7KEcA2Lv9YlaTc4zemlHswN7h1I+wPWKVuApxySRCJbpRJjXb5oMyjnraBRDGQ966WDNUp6kq7IpTr6DHi6+aQsQvcCvwl9r/v1SkriobkrIHqoPITkr/YwtdcsXOXqHovk1H2i768upIuR5THC4Y8HDVysK6uAlNH3XFzBrBg89xg6xifadLbsVsLgm20toZuJ2u4agWzpIq0Y5hmeKh/QYRUueihE6tVFPVv7JgQ9GvdaO/fhEYYmpTGqFlhU9Hzqt+b8bWsP6Pcu013UOK4Dad8XYEN3mlmQvpX1sDMOt+TYn2UfqJe7GGBSovH1sN3glKGlrD2i8kBOF5YAXAikRtZz6fbnLikjwx0ASEnoiR4A64B+kYsQ5BvCrO8/r/TQ+JdnBTzZBoxtJRl+Eg3YGhHGgx14m5p5elkc2gjbcEEcrUAP3ZKhZy5zkz4kSJ6gV+JE+7UjkkUkhjqykhQ20iAjHKtbsVn1xZDEXGF7saZITFSKHol62gQnHOsyiGQkcQZ4DLETy6r4EGP1wcmQ3bT78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecf88ba-41d0-4c4c-b5f9-08dc0ce8d080
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:48:45.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSUkZ18DMDp+KEbf0/Ycd0bd61J5sNozB9zdafo0kuDOQgeOI1+yd6UYnS+0vbnyw0FEjgRcF3d1LXwtpwAxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040039
X-Proofpoint-GUID: HBFD_13GOCgSJZqJdCv4VOrSBbmv05fj
X-Proofpoint-ORIG-GUID: HBFD_13GOCgSJZqJdCv4VOrSBbmv05fj

The command 'btrfs inspect-internal dump-tree -t raid_stripe'
introduces trailing whitespace in its output.
Apply a filter to remove it. Used in btrfs/30[4-8][.out].

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/filter b/common/filter
index 509ee95039ac..36d51bd957dd 100644
--- a/common/filter
+++ b/common/filter
@@ -651,5 +651,10 @@ _filter_bash()
 	sed -e "s/^bash: line 1: /bash: /"
 }
 
+_filter_trailing_whitespace()
+{
+	sed -E -e "s/\s+$//"
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.38.1


