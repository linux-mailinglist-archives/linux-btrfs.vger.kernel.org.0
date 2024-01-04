Return-Path: <linux-btrfs+bounces-1213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3C823BE6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F11DB24A80
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096818ECC;
	Thu,  4 Jan 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OOj1JMg0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Km7i1Rne"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BE1D55F;
	Thu,  4 Jan 2024 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MLfDw001823;
	Thu, 4 Jan 2024 05:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=1OS0xRismOfyW5Rrv3XjpjXyLLe6VT1FUHfr2tanZbM=;
 b=OOj1JMg009HObFfN4HwEXEAJQnNIfnjFSAPu6lQYL/1vXuJT94f2p8tW6IuYd/MCY7wq
 t9ai3p2haHO0AlAKMdattHevuvAuwAGKhXv9LFcwHfft831L8UnuIhgqHB7Edn/Kjbp8
 Ga8i1UXN/zv4cKcWuQWMB2DI9QfaiI0ULcANLdnq5oEl0wBMsh2TVPIgTSE8xBQcHAPx
 73jk3+Smdk0l2fFYaLEqnfXD4lC2SkdcFcjqXTZq1RiClfJwzdgoHLh7gPrmdVe/649G
 OzwX3KM8kAoelxOZYshBIDWofMfGBBSdLQr4S43pFgf5Jc/D0REBJgULx4hEHq0MWjIH KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu6bnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:48:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045lkxA015824;
	Thu, 4 Jan 2024 05:48:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpudg0gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTQNn5mcR8Y7lg/KvvFf93xmN+wnup/6sS4iLPlOywWODICQemM7JIDGCeohOtSQXrIXvQ1wbPRdLCk86l98nnyTKUDwRpONTkut5cs/K7q8U/7tN7rnfiuncWSKixrvwpJtZyD6dnNYmRThB3yQITEMTP5e/Kctx4ukUQedWBmESQG/Sb9XpcNPmu8Rm3mU6/P2APVrjDvCq3WakhF3IpCc2YWaKvmu2zJmLsEqbK1rJ+WgLoGHz7Dw1ZlRJsHWTXnJMer2r2qe6hDalryqVQ/tkP+jbZCNHUK7kQc0z4jHrhPcIDxLXDRBsIq4NIOsRbXMrPAxq3dKQjFOWmmrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OS0xRismOfyW5Rrv3XjpjXyLLe6VT1FUHfr2tanZbM=;
 b=Rj+MpHXZKfWKlLx5NNogj+rNTH35ZwNuZG7XueLbXSVSUt8/9D6w5ZmArpcBg1Cqam4y+CKzoXGgnsPtej5nz1wnggkQHN5vdGuNxe4GHGOmCSJRI1MgKQXFILT5iwYwyUneecxRXYHThn/QCZWSI5RkWAplYOee95D+Hhwcmc/6QdmelXILOrma+rVc9Vu8qQujWlnT8nEC038eVaVxNwGmRVIn7maBy8WOQK7A4HzyC3kxCNQW1F2FfQSaCT9vbuqfcqhsw1dgfALoVRaR1psoVKNropO7AJWK7SvstZPfur9fCDfK0kzoVHYSBWN6aInMjmpvBq9Pf59eH5mwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OS0xRismOfyW5Rrv3XjpjXyLLe6VT1FUHfr2tanZbM=;
 b=Km7i1RnegU0j289HqVpOdeKy9M40mAQrAA+Su4g4w4Ls0csZJaMbbyD2UoaLxbNehDOoC82jzEOSgqSuBpu97iO05CNtHjXBpDxhuRx0LdnFV6MAf+CIrI74hunbsagSxo20n8I9yOD/2XcgjeaQrYybq6K2SVAQYlzZebBwV6M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:48:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:48:32 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 01/10] fstests: doc: add new raid-stripe-tree group
Date: Thu,  4 Jan 2024 11:18:07 +0530
Message-Id: <8ff870dc3bc3717b2e1794ac4c56798fc0471f06.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a49692-4bff-4ce4-ac6a-08dc0ce8c8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qUPF7vPzLVQiTqGuVQz9Wgmye01J+fafqbA3SZwIwEPHRSHwoL3GMX6vOG2Ic1EMXhAR9i0DmY8R4z4F62ce6gP555vQm7DoGFgiXzvwLk1YQpMOxIkWrWU+87gnl3cBl9GqrrW8wWI2fbcHUAii2NmtJ7YtAEhSrbOL8Kcv+Q9KG1wfzU8zqdt4qvd2ohXYJ6kXNlTjWtKvtxEZbkgTBwonNE78RYWwxAy6KFC0hgkVUKXzmSnCYkQimQA//nXj4QA9B7Ae2d9sYqiQtKHfZ7Mweclc5TWa0nWRMd43z9SUJCqfhRVLzDBoD2FQTyc/XxvNFaj07h8T2U7O1pO30D326eYbhQNfA79yZJFXzYZJvfq7zvheZd2+Kv7U84BcTevkDhsS2R12Me5ECI/w+1HOXiKxwZHVn8GIiAxq2cQRi7Kwe9AUrjxpjF2Sp7FAXRliHvknU9IQMvDTFibHVPJN5V3n3BAIEdsoCP5Z+YHnnHd+lCjDo/6W4GDBJtL1aN0F4+djsBWZ9zvypREbzFsKx0tj5yLRgbSnqddkWxQP/cvLC0kyWMC1+HY5RyUt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(4744005)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(83380400001)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZeQnQPnlvg7Je4DizLQGBKiAMxIux4jWtJgjghvtHCbKpTP18NjN6UzkYp27?=
 =?us-ascii?Q?2nJJZhzYviUUTs57flUnPtDmcdJ5aksWmWC6pWxSjmRTQfNSO2fbM1l5G24h?=
 =?us-ascii?Q?IQVqD+Vd+dU+Ef6CwjqJ3YqiCNoejAuoYnsm64/565s+wgZ0M/IMIc1yhkyE?=
 =?us-ascii?Q?aZPiJ3M9d/I1Py46cEtqw2oxQLiK5KBT6TfIkwiS+KeAr+2w4JFG2CtqZVcT?=
 =?us-ascii?Q?d5m775TqfBk2mm7S6YFZB7cG/dGaCgBahzBwmUdiUdeEtnlpsfUf/7okvPdn?=
 =?us-ascii?Q?UzynGLFR7y2BsC73OV2dg+Gieabb9GrMpphA/uYAuZDP4oH1Jie5nR/iaZ/6?=
 =?us-ascii?Q?tg6/dkuIYLohNtj61A46JpxjtzVH+cxy19mNdvMeVbDcFS2Z18BvANydTcmd?=
 =?us-ascii?Q?J6koFnBZ1sBQ+34y71Cev3y32XUrgDkCWy/6KLh2AfePgueAtdEQMNBXhcYC?=
 =?us-ascii?Q?WkAsYx07zCQIppousDEmKHiytcXfNv60rsgWXo/3uzOThrpk3TuQgM1tKlYp?=
 =?us-ascii?Q?4pcUO7SLZltvNqtURxrJbcfqrCsIdR4p6Vw6a/JEj5c6bPPHd1Vb8iLnaOqS?=
 =?us-ascii?Q?l/8iaaAzvaL7Gfv7Dnh4JfRIaARPuZ11uHvkqqAh6CfsDUgFMnKZhx09RhXL?=
 =?us-ascii?Q?0CjygBlByclETfsbmtXwW4JZGqJua47nSxiGohWlgWMwrHk1hROVxJRAExAy?=
 =?us-ascii?Q?fJR8tct+mpJ7skUnEWTHnpqkSPLIghi/XxiPiGA6NWytGCQhHrb/mRTIu7Ee?=
 =?us-ascii?Q?dgZO0PzhxB3/d2WzS9BMQ/IJ1yl8iscxVA8aMF+LBhx5fzQyNkjcxeToLLeO?=
 =?us-ascii?Q?+bW0gdSA0tV2rxhksIORGxRhNrumFUSpdc5plP+uCZX8c9uHlAvVVgbOrKkE?=
 =?us-ascii?Q?rUQGoq42QYHOfLHe7QN7YSwv1qqycsh2fDwYOR7mqF7ywAXR1xdn9F90Owvy?=
 =?us-ascii?Q?TALm8QkLGQbzxhYf8VwWpo1NH5+0SYFBs66nDmnGo1Ot0E7LU3rsK0zOctz0?=
 =?us-ascii?Q?R8tI0fIA0xf8X6KOPq8sQr9uFp3bgt/72WjQ9zGs2WZRUZs3Qc05JnGMtppM?=
 =?us-ascii?Q?Z4mFu2RPRkmAOEFmPHzxHjYq2afWVkgy/zzX9xLreiHLJUxmbBVDax4mAtGm?=
 =?us-ascii?Q?mTpVT9gnr8ZAYDb9PI8+0yJx6ii8fJkVhWUA4l9FYmDMbPKGcFol2FpeE25W?=
 =?us-ascii?Q?6El3UCB9dkD7OPjh6xkQn8GZsfCc5GJ5K3fuj7D/00fn1m+aFPgp1spkINK0?=
 =?us-ascii?Q?KPh7M7vc7AUW+N5F/VqRRiL7uiwcrKDSDm7cUz0h36ZpmRhKeeepiJdBliKu?=
 =?us-ascii?Q?dOiqZPhhzHfxA5YDWRCv9XvhLSwaysjtRGYA6Ss5kBechrKmXdNhHiSVeuQ3?=
 =?us-ascii?Q?NRfSGs5Je/7eu/mBvAHbk/QJkyVsOHGF7fJJJTT3awr71LLMKF5RQhsfBRSh?=
 =?us-ascii?Q?QHybJuECjwA5gTwV9Lmq4OWEnGgwaZVkKfhCEKXXC4fKBFbZJRgayDmnFtSp?=
 =?us-ascii?Q?CYxGW2d1hyhQoRpTTR/g0sCPPN7hqvF7NPXeGyJYN2ORraF2X5nhWD/tH5lz?=
 =?us-ascii?Q?cIyESQ9ntX5Smhfg2hl8ZCjw/DeXhyGs9Zzx69FT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tknTAyBMfgvmucsk810ZCS0kx1Wak7QBqooMnqeSU10PRU650PvxKKUfjoNWI+Lg3IOzT538zSd7SFiFXuuyZ6N3YhAfLZ0doJVXrt2R5dKro51k4HJEatZZCeJO6si1zIMEScREdClk6j/fDq6iWvYhkVv4LLCaRyFnQKLRyL+coPV6+EN+eAvpLJxO8f9uQeXZYDLR5uXCCtn8Hdra99OaXX8f8tEGnGvcYHQi3NejyhbUBCYi9g9RcqsFCYyt2rwsj8TeIWJ0Zpen26ROpL9tLB6lfWkzgv+6HFDI8S9Vwzc8ylf2ImpBeCqZlCajgI8QdVlEFNXcBqDgi8/rpCyTWXHeWziOQj/AATnM1kcV/rkJxQcq/+Tk1WXJDf+/EEWynEgue3vXTcnUKwIbVR1wNZFRwAxLi2x4X2JBZuXi6v1VvfpWaP6Bhz2gQvwF/Fg2zj3Ozch+MooKmDAE42zhwEJ7AG9Ha1ON0WjVQ9RD18oGjMgUpOyzgJdA9Qb3MgNx6/FwAjH1Y8wM+/JV/hdDU7GcQoeVbFcSzQKvz26QyNU3vLMKvAZKmRXH7GmzOTPxYRBFLhztOHfxbyVkDjOQrbHYmPg7GAgVj3Up+G8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a49692-4bff-4ce4-ac6a-08dc0ce8c8be
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:48:32.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9buKjh8/C0dNtqBRjuQ1lZDdyZm1m/HtEEu7FWKzCDcl+yot00uDL9Zzj9bTdngyX58jrgH+FCDODYj62hlaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-GUID: kMpX7jNiHo_62RmNMgYJSwTD03Neq0FS
X-Proofpoint-ORIG-GUID: kMpX7jNiHo_62RmNMgYJSwTD03Neq0FS

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
2.38.1


