Return-Path: <linux-btrfs+bounces-4016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16F89B6F7
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 06:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B181C209C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 04:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3626FBF;
	Mon,  8 Apr 2024 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cTZmohgk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CAxp+rWE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7A53AC;
	Mon,  8 Apr 2024 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550829; cv=fail; b=R7VRVezaeowwocRY3KNj3z0UUoei2pYtBnFEwK8OMvBIJXDC7vw7gDJ19GlGXuu2bKQX/B+PYjTAU++QlT6CXZgxEv8MpWPqTEFQNzvkmg8nMCUzIx0HCF33SWYGOexDanNJD9GjJTXR/Q+QX+rNENpdX6orloq1IVPDlXQhXYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550829; c=relaxed/simple;
	bh=7CSeOSAlnsS3KYcprn3qijZaFILDQoDcJTDrZIDEDcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7ubPOGmwRqp7f2jnAFuNgYeyAva4c1JKCSvQ+TMpV/4Gn6eGq33Wu/QlIKNsz9R7EZXN9ddIX8LrFzpFpokaU7tI1195RBMAaaiH/iU1hPR8D3sMw1p+hrPxKPoHFFOgmBnjLpdbkGOgYWXPru2degkKgfNMRqapCjWdYgBDfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cTZmohgk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CAxp+rWE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4380jHgx022412;
	Mon, 8 Apr 2024 04:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=27m7RMs+DWdMKNcO4ao0f9TSqloi2cCrAAZ2kxwu2bo=;
 b=cTZmohgkueRsCbNZ8c7lVxZadKy/uPan7snsExJtFiR2dXTDJNX+EmnCr1ueyHb93Xxc
 Rom+THAMFEySE4A1cvd8kZqnU9DZaaNplMZzACvCwpyCqRApBHoNmYvC8GsELXZ7WGFn
 uI8Ei3mNBKUrGw6IH8q7CYuDed6pUZk5TuqInZ5tyAID2T4hCFppi7jYvvXzIZkpTznV
 lugoBlKJhKIWHfDGvhe8j0qc7gxg+2H8OSp/ztHJuwoXi5IB+JVao4OOFOHArWesII0N
 4XUIABscA6C0bVpFcYHz69MeJWGe0vE18Q66JG2T45XbYE3/o9LbIROlEIspA1dREhb0 7Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b1nbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 04:33:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4382uWQ6017942;
	Mon, 8 Apr 2024 04:33:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuaxvbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 04:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixha/2tz28FVoKiyJhOi4Je3W6EZoWNjNqx6hxcHhY3N5arK5pwoS4WMfPPDm+DYNCxHdKl62kYnnEvt5eB4C6akxAFElgPsoi/B2z7Zl8cZpvt9laPcdqbVexRFKudbQeE6eN3zeH8m/POMk0y0lbWEtESCBY82lQfIIIBv+oj8WcFoteY/IirgKLhZWBYxQe8NOgTB7UW2dSFMuRnewbuwV4nOWt7Oizrjs2eyUe9asniVHukjkyxbDfQp9erNuJxCCmJE9COXK23vH4szBZWmw4fAoSQlr+tliJ4OAWVK4hzBH4jXFUhD3DFO8Sf3d53IOjUKMkFvOylU4/kMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27m7RMs+DWdMKNcO4ao0f9TSqloi2cCrAAZ2kxwu2bo=;
 b=H8SpZxsrD1BCcBF1uCf29m7pC2IEXBDxklhTLPuBb33ReEwag4tyyhlKhXgnf9hDF6/FqK+O9CMcVuYnq5DaOAsqjZCiG/13D+oVMgCo7tJ6+s1XAyynCrvf+NiiHeWQYuJj48lyCXTOeVMZzsHl317Z8PxfIv5x68UWlViUFe0DXzF0m2hpd0ohmjwgqhfVXHt4BvsDnOgtBZqTJdI49+3ATCzhTs/pNy//yCnoPGIdIF2iiJiR2m1o0fI0FhDWGmDlTFY/mIfED3FzwIiwOZ/Hx6WBVBOCXvhHF1DWFK83/7wVqt6bRbDaqBZIXLVE9upx6vUbQ85RzpIDoWjFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27m7RMs+DWdMKNcO4ao0f9TSqloi2cCrAAZ2kxwu2bo=;
 b=CAxp+rWEti191F9m3FLCsgF15XXzPHymgs0kVqjHaP/341b2TSrTUXtwAEg7pVz1QPbAjP8mv2Bt6fHgQVN0NtNzWUcOzIvw7HQy+M+T1OwrsDnUn2/Neic6Dr/oS7l+xL98i4pQzw/AWKUl7Ub1AlQcq04WTvGOHMTxtXj/YvM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 04:33:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 04:33:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] common/filter.btrfs: introduce _filter_snapshot
Date: Mon,  8 Apr 2024 12:32:58 +0800
Message-ID: <bedb9edc01e8938544fa5c73f716f823764c3fd9.1712549642.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1712306454.git.anand.jain@oracle.com>
References: <cover.1712306454.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pDi2jaLnMVCf5FDAcpzRte2ccTC0uTbTBq0GCNHE0VnZC1vyKxK6gXOj8DPQuxkmA8uhJAdco94B+W45u9XqqosmQc0hD7I77q+JA9nMz8/LK/lnR1EAwJvhlNId6RUP8Nlse90o1W/Tu/s8hfYyl5RddVAL/1m7SWtWC0GEG+gK/e5PS62CxT54vjl8Nqv9uke/gphOVtGffw50ixfJ7dcC6EwAA0npijzzTNRLZtDpFr665puYhPTehqWZ8kRGTYKUyZnRbBMav9MUZo0gL0O1W+o6DEbLkzAZCszcPOhnuk01zvxBRJFLxQqwugmLPfYZ19AaHA/zhRC1bEGPnqK1r1nzflr1/kl9vpiGPbFCXhYjWRH3Lnn1S1gRp0Ytsql39AIJSi+xzYMTEvemREejxM+IC9O0ARhTG+ZHrTvHQiAIesZ/yH5T8iSbiriXKSX8HBW6sP2bOeMpiqsNpeCwUjd8okzHnlY6GKT837uBNUY4o1URgBDXE3knG0s4tLDB2O8b/Ej1wYFCcatfTdep+pmWtuu55wzqeO+kAFuly2MsIFzJtwBG9knmj8eLHKXbpueAPPRSLJCkp8BLIRh7ZhqCIXmzO+7iGmGxPoxeFnm8sVRjqO5efCgB8C22NsCuA8bJjG7BFpcLOjGINvzE5596pFH2H+AYNMS7P6k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r9DmdWL4fJGGiA9KV5JEQ3vxzmsYFFYbCPtnq9BFc2ixYtWPSkJqSTy4/d/d?=
 =?us-ascii?Q?Ei9w/rDCqGFxqj24V5jb9Nc8Le1SYMOObxDYI6jzyk7i8wiUWQQyRZTJ3zKt?=
 =?us-ascii?Q?OjyWr2PCrWNOqHRZhWdkMfOOglTI2Jn5yxMsPr9wvxNE9ACeLJIoqb/Aiy31?=
 =?us-ascii?Q?OThIx8PaoZrjsWWDlIm626Lj9YwSIuRxEyt0n09wdy3/HIND+IGeeBCZsE7v?=
 =?us-ascii?Q?TnzRsp8NQzyaxClBqglNLzukrGvH/uNTfvadoI1zvW0L1CcEPxonYxPomXWr?=
 =?us-ascii?Q?a4MtDffM6U1tcIXqNQ/PjhVZ5mf2Mzk38ugpMkaegB45MHEzuu/odzvk4wn7?=
 =?us-ascii?Q?JaO4qoV7kEz1f4R257ZVgDYXK1NnwwF3fw/p4xXs3QcK9c19KciKDs1ilBrT?=
 =?us-ascii?Q?/dkk/d9VoKq3ndWB/HYKTPHJNxor3bfIBAawmY7Q1v9WhcHvDPkgA1V4CykT?=
 =?us-ascii?Q?zFooTtMuaGZnH8EJbZeNovehXIMMx0uoZaK3SQ+gu1ufNvxmBlBy7WLNNwxA?=
 =?us-ascii?Q?P0rs/V80dNNYaaNXNbaOOGUzJY8S7d+OZYJWf5wOvoeZqRENmuv3RryoHG/p?=
 =?us-ascii?Q?nx+f9nsfWskRRbYiMjFW8K/L3Kujz5UrkudsHgvKlL18PyNb8zusvk4g6+9j?=
 =?us-ascii?Q?Adw6gk1CjOihhI5MJBMIYPIntn2gTsltURKxRHlUMHcp7mk8SWhKseS3PvvT?=
 =?us-ascii?Q?dRRpzB2A/8AJhbVIhmrGGsxMijpfd2PrpDNqz9BfRkBOg60PgDTkQUtW4bgU?=
 =?us-ascii?Q?jCBuQm6Y2VV9xuF6blD+Wo8SIccXekOccVFj+JaVr7IOOSKthVD6MwDk4llC?=
 =?us-ascii?Q?taSIIxBtJfiaGbQ+ozokSktTiX4Egmll2VSpao8nnconls1MGkYoWP5IOZw6?=
 =?us-ascii?Q?YMebWaf/LydSejEL5YgI5uH4CEJQDKNtXbyLknxohuX/Z9dR8lPVsg7DRqMN?=
 =?us-ascii?Q?V7VfrCCiC5aFp81ScaODbpoy3vEQF5D/Qya6rrdtRTCC4tlShOR2CPSIUrl4?=
 =?us-ascii?Q?u8nmpEHxBdoI0ClJ0Xd7L3FHF3ZiDq1fTvtP2iGoXnzrzqDZ1Epnwrytblp9?=
 =?us-ascii?Q?zYMPzQlFnfgRMp3Rs4GBYkGqBvwvBnfu2xRJvQHOT751/2pcpyXGm/lExmjw?=
 =?us-ascii?Q?zYVT9skOvin66Ox3p5Y6aA88WsHL+yrMvAI2aCJ9PRsibrq2MqPWx4soJcXg?=
 =?us-ascii?Q?V5eSEOettCbQad+8Y5Aqd9G8tAMRXpTvmvt6852ff8LORfH0nGHWKcJs+DIH?=
 =?us-ascii?Q?VVP4bfEDkfcZ9EkiUP8JIOlQKvzu2gAt4AWcPqdHSgZXOup4CgDIojAAbn6i?=
 =?us-ascii?Q?IUlFcJfpQr2RwjX7kIogJflY1NvJXohAOUF29RSin70ZzLvvJCobmTPPFidN?=
 =?us-ascii?Q?mLPYH070cwhyd4tBZo0FOnwpi8yesg8PGht5H5/KQYS9GNmuzm2TYVubDazH?=
 =?us-ascii?Q?6oc/a/Qh+L/5pCfjLmy7jQtNdE/XJZJH8RoKBV4y8w85QqAX4U7KTQ8PRv8C?=
 =?us-ascii?Q?3Ep0hTNcED29x4Qy1QvM3FCRH5TfiGUvkY8+xyI5nmtz+MERCHiG+/OLIARK?=
 =?us-ascii?Q?VcSD03bSN9bTQ+qJobgFbXadkWYf/3J+4zbqawpJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dBYGs+DRH7Q2Tx3s3g6JSeSyhp6a/Zy/JiGmfU+P1YEUd5Yse8b3jCwhfiRN/02jDC2wlQHjS6eZdiwRHrCZNkNuB+zW4E+jj74wX6ro08dcZoIB1OwSjlCTJyn4RkJG6h5nkYqiLySPcEIrkd6szxhJkD4E/b1jEvND9d5CtTXKiPTgB1oZYfWREvTnmeb13n7GkaGryFuDFQrENPXhHmYT2wtmTTvMow8/9rNshYK88MJeEoH8LnzL5MbqzW1E2geaCM6MmqH7CM0vZHwZGPnuiqn5EfQeZ0bfYmABQRTDvt985xvzZbxVKN8TlgZu75psOwCMtFjqdTmGqHj3HQOS2GvbutvjAkW4u962XI/CmnkN3ZCWUdV1WyiwjHzDoF7K8Sen+rkv6PTh6OmaNtvR3EtlQHP93lHhC0tkJbKB+QNe+GWarUZGicR85WlkqplqEQTv9B+DlRSvXKW5ODvV3WsL2IbJVCzPXesxfEe5VyyjHzqh18bW6LaWULauv6Ghvi8VHE0tSN0J2CIWtaTGBxRsnI+phkH0jtcNJGmkATNnCQMKcPFv/CyNiL+dXqgsdCKAJ/Q30uUWlk5eUTvb63nz7zJjjRFuECMrqio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29f166d-dfad-4f68-370a-08dc57850198
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 04:33:15.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuZkmNaFIV1LuUEsnZQ5trRzoX4ITC0nufSgZF7TFGZLhHvTVIJdvKByHV4Kh/J7B5h30cdBJxrng/7+iAIPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080034
X-Proofpoint-GUID: w-ySh-E6QwJ9dBctRVoQ_BGb716WVr2f
X-Proofpoint-ORIG-GUID: w-ySh-E6QwJ9dBctRVoQ_BGb716WVr2f

Btrfs-progs commit 5f87b467a9e7 ("subvolume: output the prompt line only
when the ioctl succeeded") changed the output for snapshot command,
updating the golden outputs.

Create a helper filter to ensure the test cases pass on older btrfs-progs.

Another option is to remove the 'btrfs subvolume snapshot' command output
from the golden output and redirect it to /dev/null, but this strays from
the bug-fix objective.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: The missed testcases included now.
    Merged following two patches in v1:
	common/filter.btrfs: add a new _filter_snapshot
	btrfs: create snapshot fix golden output

 common/filter.btrfs | 9 +++++++++
 tests/btrfs/001     | 3 ++-
 tests/btrfs/001.out | 2 +-
 tests/btrfs/152     | 6 +++---
 tests/btrfs/152.out | 4 ++--
 tests/btrfs/168     | 6 +++---
 tests/btrfs/168.out | 4 ++--
 tests/btrfs/169     | 6 +++---
 tests/btrfs/169.out | 4 ++--
 tests/btrfs/170     | 4 ++--
 tests/btrfs/170.out | 2 +-
 tests/btrfs/187     | 6 +++---
 tests/btrfs/187.out | 4 ++--
 tests/btrfs/188     | 8 ++++----
 tests/btrfs/188.out | 4 ++--
 tests/btrfs/189     | 4 ++--
 tests/btrfs/189.out | 2 +-
 tests/btrfs/191     | 6 +++---
 tests/btrfs/191.out | 4 ++--
 tests/btrfs/200     | 6 +++---
 tests/btrfs/200.out | 4 ++--
 tests/btrfs/202     | 4 ++--
 tests/btrfs/202.out | 2 +-
 tests/btrfs/203     | 6 +++---
 tests/btrfs/203.out | 4 ++--
 tests/btrfs/226     | 4 ++--
 tests/btrfs/226.out | 2 +-
 tests/btrfs/276     | 2 +-
 tests/btrfs/276.out | 2 +-
 tests/btrfs/280     | 4 ++--
 tests/btrfs/280.out | 2 +-
 tests/btrfs/281     | 4 ++--
 tests/btrfs/281.out | 2 +-
 tests/btrfs/283     | 4 ++--
 tests/btrfs/283.out | 2 +-
 tests/btrfs/287     | 4 ++--
 tests/btrfs/287.out | 4 ++--
 tests/btrfs/293     | 4 ++--
 tests/btrfs/293.out | 4 ++--
 tests/btrfs/300     | 2 +-
 tests/btrfs/300.out | 2 +-
 tests/btrfs/302     | 4 ++--
 tests/btrfs/302.out | 2 +-
 tests/btrfs/314     | 2 +-
 tests/btrfs/314.out | 4 ++--
 45 files changed, 92 insertions(+), 82 deletions(-)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 9ef9676175c9..7042edf16d2a 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -156,5 +156,14 @@ _filter_device_add()
 
 }
 
+_filter_snapshot()
+{
+	# btrfs-progs commit 5f87b467a9e7 ("btrfs-progs: subvolume: output the
+	# prompt line only when the ioctl succeeded") changed the output for
+	# btrfs subvolume snapshot, ensure that the latest fstests continue to
+	# work on older btrfs-progs without the above commit.
+	_filter_testdir_and_scratch | sed -e "s/Create a/Create/g"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/btrfs/001 b/tests/btrfs/001
index 6c2639990373..cfcf2ade4590 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -26,7 +26,8 @@ dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 &> /dev/null
 echo "List root dir"
 ls $SCRATCH_MNT
 echo "Creating snapshot of root dir"
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | \
+							_filter_snapshot
 echo "List root dir after snapshot"
 ls $SCRATCH_MNT
 echo "List snapshot dir"
diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
index c782bde96091..c9e32265da6a 100644
--- a/tests/btrfs/001.out
+++ b/tests/btrfs/001.out
@@ -3,7 +3,7 @@ Creating file foo in root dir
 List root dir
 foo
 Creating snapshot of root dir
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 List root dir after snapshot
 foo
 snap
diff --git a/tests/btrfs/152 b/tests/btrfs/152
index 75f576c3cfca..b89fe361e84e 100755
--- a/tests/btrfs/152
+++ b/tests/btrfs/152
@@ -11,7 +11,7 @@
 _begin_fstest auto quick metadata qgroup send
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 
 # real QA test starts here
 _supported_fs btrfs
@@ -32,9 +32,9 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
 
 # Create base snapshots and send them
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
-	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
+	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_snapshot
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
-	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
+	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_snapshot
 for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
 	$BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> /dev/null | \
 		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
index a95bb5797162..763d38cefe65 100644
--- a/tests/btrfs/152.out
+++ b/tests/btrfs/152.out
@@ -5,8 +5,8 @@ Create subvolume 'SCRATCH_MNT/recv1_1'
 Create subvolume 'SCRATCH_MNT/recv1_2'
 Create subvolume 'SCRATCH_MNT/recv2_1'
 Create subvolume 'SCRATCH_MNT/recv2_2'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/subvol1/.snapshots/1'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/subvol2/.snapshots/1'
+Create readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/subvol1/.snapshots/1'
+Create readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/subvol2/.snapshots/1'
 At subvol 1
 At subvol 1
 At subvol 1
diff --git a/tests/btrfs/168 b/tests/btrfs/168
index acc58b51ee39..78bc9b8f81bb 100755
--- a/tests/btrfs/168
+++ b/tests/btrfs/168
@@ -20,7 +20,7 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 
 # real QA test starts here
 _supported_fs btrfs
@@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro false
 # Create a snapshot of the subvolume, to be used later as the parent snapshot
 # for an incremental send operation.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 # First do a full send of this snapshot.
 $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
@@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" $SCRATCH_MNT/sv1/baz >>$seqres.full
 # Create a second snapshot of the subvolume, to be used later as the send
 # snapshot of an incremental send operation.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+							| _filter_snapshot
 
 # Temporarily turn the second snapshot to read-write mode and then open a file
 # descriptor on its foo file.
diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
index 6cfce8cd666c..0eccbc3fc416 100644
--- a/tests/btrfs/168.out
+++ b/tests/btrfs/168.out
@@ -1,9 +1,9 @@
 QA output created by 168
 Create subvolume 'SCRATCH_MNT/sv1'
 At subvol SCRATCH_MNT/sv1
-Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
+Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
 At subvol SCRATCH_MNT/snap1
-Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
+Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
 At subvol SCRATCH_MNT/snap2
 At subvol sv1
 OK
diff --git a/tests/btrfs/169 b/tests/btrfs/169
index 009fdaee7c46..e507692fd0c6 100755
--- a/tests/btrfs/169
+++ b/tests/btrfs/169
@@ -20,7 +20,7 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 
 # real QA test starts here
 _supported_fs btrfs
@@ -44,7 +44,7 @@ $XFS_IO_PROG -f -c "falloc -k 0 4M" \
 	     $SCRATCH_MNT/foobar | _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
     | _filter_scratch
 
@@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
 $XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
 		 $SCRATCH_MNT/snap2 2>&1 | _filter_scratch
 
diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
index ba77bf0adbe3..c3467d5162d9 100644
--- a/tests/btrfs/169.out
+++ b/tests/btrfs/169.out
@@ -1,9 +1,9 @@
 QA output created by 169
 wrote 1048576/1048576 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
 At subvol SCRATCH_MNT/snap1
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
 At subvol SCRATCH_MNT/snap2
 File digest in the original filesystem:
 d31659e82e87798acd4669a1e0a19d4f  SCRATCH_MNT/snap2/foobar
diff --git a/tests/btrfs/170 b/tests/btrfs/170
index ab105d36fb96..50b6fa8654d4 100755
--- a/tests/btrfs/170
+++ b/tests/btrfs/170
@@ -12,7 +12,7 @@
 _begin_fstest auto quick snapshot prealloc
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 
 # real QA test starts here
 _supported_fs btrfs
@@ -46,7 +46,7 @@ md5sum $SCRATCH_MNT/foobar | _filter_scratch
 
 # Create a snapshot of the subvolume where our file is.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 # Cleanly unmount the filesystem.
 _scratch_unmount
diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
index 4c5fd87a8b17..ebdf872c7eb2 100644
--- a/tests/btrfs/170.out
+++ b/tests/btrfs/170.out
@@ -3,6 +3,6 @@ wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File digest after write:
 85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 File digest after mounting the filesystem again:
 85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
diff --git a/tests/btrfs/187 b/tests/btrfs/187
index d3cf05a1bd92..f0935c9e6516 100755
--- a/tests/btrfs/187
+++ b/tests/btrfs/187
@@ -17,7 +17,7 @@ _begin_fstest auto send dedupe clone balance
 
 # Import common functions.
 . ./common/attr
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 
 # real QA test starts here
@@ -152,7 +152,7 @@ done
 wait ${create_pids[@]}
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 # Add some more files, so that that are substantial differences between the
 # two test snapshots used for an incremental send later.
@@ -184,7 +184,7 @@ done
 wait ${setxattr_pids[@]}
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+							| _filter_snapshot
 
 full_send_loop 5 &
 full_send_pid=$!
diff --git a/tests/btrfs/187.out b/tests/btrfs/187.out
index ab522cfe7e8c..208cfb212b8f 100644
--- a/tests/btrfs/187.out
+++ b/tests/btrfs/187.out
@@ -1,3 +1,3 @@
 QA output created by 187
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
diff --git a/tests/btrfs/188 b/tests/btrfs/188
index fcaf84b15053..feeb4397c234 100755
--- a/tests/btrfs/188
+++ b/tests/btrfs/188
@@ -21,7 +21,7 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 
 # real QA test starts here
 _supported_fs btrfs
@@ -45,16 +45,16 @@ $XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K" $SCRATCH_MNT/foobar | _filter_xfs_io
 $XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 # Now punch a hole that drops all the extents within the file's size.
 $XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
index 260988e60084..586543cfde61 100644
--- a/tests/btrfs/188.out
+++ b/tests/btrfs/188.out
@@ -1,9 +1,9 @@
 QA output created by 188
 wrote 512000/512000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
 File digest in the original filesystem:
 816df6f64deba63b029ca19d880ee10a  SCRATCH_MNT/incr/foobar
diff --git a/tests/btrfs/189 b/tests/btrfs/189
index ec6e56fa0020..244ca84299fa 100755
--- a/tests/btrfs/189
+++ b/tests/btrfs/189
@@ -23,7 +23,7 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 
 # real QA test starts here
@@ -46,7 +46,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M" $SCRATCH_MNT/baz | _filter_xfs_io
 $XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo | _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
index 79c70b03a1ba..a516167578e4 100644
--- a/tests/btrfs/189.out
+++ b/tests/btrfs/189.out
@@ -7,7 +7,7 @@ wrote 2097152/2097152 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
 linked 131072/131072 bytes at offset 655360
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/191 b/tests/btrfs/191
index 3c565d0ad209..9c1fd80b7583 100755
--- a/tests/btrfs/191
+++ b/tests/btrfs/191
@@ -19,7 +19,7 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 
 # real QA test starts here
@@ -44,7 +44,7 @@ $XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create the base snapshot and the parent send stream from it.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1 2>&1 \
 	| _filter_scratch
@@ -55,7 +55,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M" $SCRATCH_MNT/bar | _filter_xfs_io
 # Create the second snapshot, used for the incremental send, before doing the
 # file deduplication.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2 \
-	| _filter_scratch
+							| _filter_snapshot
 
 # Now before creating the incremental send stream:
 #
diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
index 4269803cce1e..ad4d779814f7 100644
--- a/tests/btrfs/191.out
+++ b/tests/btrfs/191.out
@@ -3,11 +3,11 @@ wrote 524288/524288 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 524288/524288 bytes at offset 524288
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
 At subvol SCRATCH_MNT/mysnap1
 wrote 1048576/1048576 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
 deduped 524288/524288 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 deduped 524288/524288 bytes at offset 524288
diff --git a/tests/btrfs/200 b/tests/btrfs/200
index 5ce3775f2222..3d18165a630f 100755
--- a/tests/btrfs/200
+++ b/tests/btrfs/200
@@ -19,7 +19,7 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 . ./common/punch
 
@@ -52,7 +52,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -64,7 +64,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
index 3eec567e97fe..5c1cd855fa99 100644
--- a/tests/btrfs/200.out
+++ b/tests/btrfs/200.out
@@ -5,11 +5,11 @@ linked 65536/65536 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
 linked 65536/65536 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
 At subvol base
 At snapshot incr
diff --git a/tests/btrfs/202 b/tests/btrfs/202
index 5f0429f18bf9..57ecbe47c0bb 100755
--- a/tests/btrfs/202
+++ b/tests/btrfs/202
@@ -8,7 +8,7 @@
 . ./common/preamble
 _begin_fstest auto quick subvol snapshot
 
-. ./common/filter
+. ./common/filter.btrfs
 
 _supported_fs btrfs
 _require_scratch
@@ -28,7 +28,7 @@ _scratch_mount
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
-	| _filter_scratch
+							| _filter_snapshot
 
 # Need the dummy entry created so that we get the invalid removal when we rmdir
 ls $SCRATCH_MNT/c/b
diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
index 7f33d49f889c..6b80810e96ed 100644
--- a/tests/btrfs/202.out
+++ b/tests/btrfs/202.out
@@ -1,4 +1,4 @@
 QA output created by 202
 Create subvolume 'SCRATCH_MNT/a'
 Create subvolume 'SCRATCH_MNT/a/b'
-Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
+Create snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
diff --git a/tests/btrfs/203 b/tests/btrfs/203
index e506118e2cd2..e62f09edb570 100755
--- a/tests/btrfs/203
+++ b/tests/btrfs/203
@@ -20,7 +20,7 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 
 # real QA test starts here
@@ -44,7 +44,7 @@ _scratch_mount
 $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar | _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -70,7 +70,7 @@ $XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
 	     $SCRATCH_MNT/foobar | _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 		 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
index 58739a98cd1b..59c2564bc61b 100644
--- a/tests/btrfs/203.out
+++ b/tests/btrfs/203.out
@@ -1,7 +1,7 @@
 QA output created by 203
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
 wrote 65536/65536 bytes at offset 524288
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -15,7 +15,7 @@ wrote 65536/65536 bytes at offset 786432
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 linked 196608/196608 bytes at offset 196608
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
 File foobar digest in the original filesystem:
 2b76b23b62fdbbbcae1ee37eec84fd7d
diff --git a/tests/btrfs/226 b/tests/btrfs/226
index 7034fcc7b2a5..f96a832505a4 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -11,7 +11,7 @@
 _begin_fstest auto quick rw snapshot clone prealloc punch
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 
 # real QA test starts here
@@ -51,7 +51,7 @@ $XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
 	     $SCRATCH_MNT/f2 | _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
-    | _filter_scratch
+							| _filter_snapshot
 
 # Write into the range of the first extent so that that range no longer has a
 # shared extent.
diff --git a/tests/btrfs/226.out b/tests/btrfs/226.out
index c63982b0ba4a..1855e5255fce 100644
--- a/tests/btrfs/226.out
+++ b/tests/btrfs/226.out
@@ -13,7 +13,7 @@ wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 pwrite: Resource temporarily unavailable
diff --git a/tests/btrfs/276 b/tests/btrfs/276
index f15f20824350..30799ebe449e 100755
--- a/tests/btrfs/276
+++ b/tests/btrfs/276
@@ -105,7 +105,7 @@ sync
 echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
 
 # Creating a snapshot.
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_snapshot
 
 # We have a snapshot, so now all extents should be reported as shared.
 echo "Number of shared extents in the whole file: $(count_shared_extents)"
diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
index 352e06b4d4b2..27ea29bdf87b 100644
--- a/tests/btrfs/276.out
+++ b/tests/btrfs/276.out
@@ -1,6 +1,6 @@
 QA output created by 276
 Number of non-shared extents in the whole file: 2000
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 Number of shared extents in the whole file: 2000
 wrote 65536/65536 bytes at offset 524288
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/280 b/tests/btrfs/280
index fc049adb0b19..4957825b7e4b 100755
--- a/tests/btrfs/280
+++ b/tests/btrfs/280
@@ -15,7 +15,7 @@
 . ./common/preamble
 _begin_fstest auto quick compress snapshot fiemap
 
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/punch # for _filter_fiemap_flags
 
 _supported_fs btrfs
@@ -37,7 +37,7 @@ _scratch_mount -o compress
 $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create a RW snapshot of the default subvolume.
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_snapshot
 
 echo
 echo "File foo fiemap before COWing extent:"
diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
index 5371f3b01551..4f0e5d2287b6 100644
--- a/tests/btrfs/280.out
+++ b/tests/btrfs/280.out
@@ -1,7 +1,7 @@
 QA output created by 280
 wrote 134217728/134217728 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 
 File foo fiemap before COWing extent:
 
diff --git a/tests/btrfs/281 b/tests/btrfs/281
index ddc7d9e8b06d..2943998bee20 100755
--- a/tests/btrfs/281
+++ b/tests/btrfs/281
@@ -15,7 +15,7 @@
 . ./common/preamble
 _begin_fstest auto quick send compress clone fiemap
 
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 . ./common/punch # for _filter_fiemap_flags
 
@@ -53,7 +53,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K" $SCRATCH_MNT/foo \
 
 echo "Creating snapshot and a send stream for it..."
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
-	| _filter_scratch
+	| _filter_snapshot
 $BTRFS_UTIL_PROG send --compressed-data -f $send_stream $SCRATCH_MNT/snap 2>&1 \
 	| _filter_scratch
 
diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
index 2585e3e567db..49c23a00baea 100644
--- a/tests/btrfs/281.out
+++ b/tests/btrfs/281.out
@@ -6,7 +6,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 linked 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Creating snapshot and a send stream for it...
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 At subvol SCRATCH_MNT/snap
 Creating a new filesystem to receive the send stream...
 At subvol snap
diff --git a/tests/btrfs/283 b/tests/btrfs/283
index 118df08b8958..d9b8c1d24b8f 100755
--- a/tests/btrfs/283
+++ b/tests/btrfs/283
@@ -11,7 +11,7 @@
 . ./common/preamble
 _begin_fstest auto quick send clone fiemap
 
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 . ./common/punch # for _filter_fiemap_flags
 
@@ -58,7 +58,7 @@ $XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K" $SCRATCH_MNT/foo | _filter_xfs_i
 
 echo "Creating snapshot and a send stream for it..."
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
-	| _filter_scratch
+	| _filter_snapshot
 
 $BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 | _filter_scratch
 
diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
index 286dae332eff..37f425bf8312 100644
--- a/tests/btrfs/283.out
+++ b/tests/btrfs/283.out
@@ -4,7 +4,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Creating snapshot and a send stream for it...
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 At subvol SCRATCH_MNT/snap
 Creating a new filesystem to receive the send stream...
 At subvol snap
diff --git a/tests/btrfs/287 b/tests/btrfs/287
index 64e6ef35250c..dec812760917 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -112,9 +112,9 @@ query_logical_ino -o $bytenr
 
 # Now create two snapshots and then do some queries.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+	| _filter_snapshot
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+	| _filter_snapshot
 
 snap1_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
 snap2_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
index 30eac8fa444c..5798ec5d7c55 100644
--- a/tests/btrfs/287.out
+++ b/tests/btrfs/287.out
@@ -41,8 +41,8 @@ resolve first extent +3M offset with ignore offset option:
 inode 257 offset 16777216 root 5
 inode 257 offset 8388608 root 5
 inode 257 offset 2097152 root 5
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
 resolve first extent:
 inode 257 offset 16777216 snap2
 inode 257 offset 8388608 snap2
diff --git a/tests/btrfs/293 b/tests/btrfs/293
index 06f96dc414b0..fffdcd53441a 100755
--- a/tests/btrfs/293
+++ b/tests/btrfs/293
@@ -32,9 +32,9 @@ swap_file="$SCRATCH_MNT/swapfile"
 _format_swapfile $swap_file $(($(_get_page_size) * 64)) >> $seqres.full
 
 echo "Creating first snapshot..."
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 | _filter_snapshot
 echo "Creating second snapshot..."
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | _filter_snapshot
 
 echo "Activating swap file... (should fail due to snapshots)"
 _swapon_file $swap_file 2>&1 | _filter_scratch
diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
index fd04ac9139b8..7b2947a705e7 100644
--- a/tests/btrfs/293.out
+++ b/tests/btrfs/293.out
@@ -1,8 +1,8 @@
 QA output created by 293
 Creating first snapshot...
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
 Creating second snapshot...
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
+Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
 Activating swap file... (should fail due to snapshots)
 swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
 Deleting first snapshot...
diff --git a/tests/btrfs/300 b/tests/btrfs/300
index 8a0eaecf87f7..00ffcb82eae6 100755
--- a/tests/btrfs/300
+++ b/tests/btrfs/300
@@ -43,7 +43,7 @@ $BTRFS_UTIL_PROG subvolume create subvol;
 touch subvol/{1,2,3};
 $BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
 touch subvol/subsubvol/{4,5,6};
-$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
+$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot | sed -e 's/Create a/Create/g';
 "
 
 find $test_dir/. -printf "%M %u %g ./%P\n"
diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
index 6e94447e87ac..06a75bff5ce1 100644
--- a/tests/btrfs/300.out
+++ b/tests/btrfs/300.out
@@ -1,7 +1,7 @@
 QA output created by 300
 Create subvolume './subvol'
 Create subvolume 'subvol/subsubvol'
-Create a snapshot of 'subvol' in './snapshot'
+Create snapshot of 'subvol' in './snapshot'
 drwxr-xr-x fsgqa fsgqa ./
 drwxr-xr-x fsgqa fsgqa ./subvol
 -rw-r--r-- fsgqa fsgqa ./subvol/1
diff --git a/tests/btrfs/302 b/tests/btrfs/302
index f3e6044b5251..52d712ac50de 100755
--- a/tests/btrfs/302
+++ b/tests/btrfs/302
@@ -15,7 +15,7 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot subvol
 
-. ./common/filter
+. ./common/filter.btrfs
 
 _supported_fs btrfs
 _require_scratch
@@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
 # Now create a snapshot of the subvolume and make it accessible from within the
 # subvolume.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
-		 $SCRATCH_MNT/subvol/snap | _filter_scratch
+				 $SCRATCH_MNT/subvol/snap | _filter_snapshot
 
 # Now unmount and mount again the fs. We want to verify we are able to read all
 # metadata for the snapshot from disk (no IO failures, etc).
diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
index 8770aefc99c8..c08f8c135538 100644
--- a/tests/btrfs/302.out
+++ b/tests/btrfs/302.out
@@ -1,4 +1,4 @@
 QA output created by 302
 Create subvolume 'SCRATCH_MNT/subvol'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
+Create readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
 OK
diff --git a/tests/btrfs/314 b/tests/btrfs/314
index 887cb69eb79c..598af611d249 100755
--- a/tests/btrfs/314
+++ b/tests/btrfs/314
@@ -43,7 +43,7 @@ send_receive_tempfsid()
 
 	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
 	$BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
-						_filter_testdir_and_scratch
+							_filter_snapshot
 
 	echo Send ${src} | _filter_testdir_and_scratch
 	$BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
index 21963899c2b2..d29fe51b3ff9 100644
--- a/tests/btrfs/314.out
+++ b/tests/btrfs/314.out
@@ -3,7 +3,7 @@ QA output created by 314
 From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
 wrote 9000/9000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
 Send SCRATCH_MNT
 At subvol SCRATCH_MNT/snap1
 Receive TEST_DIR/314/tempfsid_mnt
@@ -14,7 +14,7 @@ Recv:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/snap1/foo
 From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
 wrote 9000/9000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/314/tempfsid_mnt/snap1'
+Create readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/314/tempfsid_mnt/snap1'
 Send TEST_DIR/314/tempfsid_mnt
 At subvol TEST_DIR/314/tempfsid_mnt/snap1
 Receive SCRATCH_MNT
-- 
2.41.0


