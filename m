Return-Path: <linux-btrfs+bounces-3281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1B487BB6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 11:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16C61C20FED
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924B65A0F9;
	Thu, 14 Mar 2024 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lJ4Gv29t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MTtlsjzg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BC5DF26;
	Thu, 14 Mar 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412698; cv=fail; b=UlwTrTvjcMB2lEPAa2WDX0gvXARp9Rh/PbcdvcLWnXxFfwfR5DEAmDkxRxb6kjeaKZAN5/tpUas4OTuK31ENZb38DF26P+irn6PMQCb5CoX/2xgGzQH5RXrztM3kstFY9FQmV2tmQ/Y9/XilP8H3KJ7MGxCtzqMINviEOuiAm30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412698; c=relaxed/simple;
	bh=ZTsqk4BCNDvNMBLmLmpBNmyGASCY1sPzVkN8ikF/HhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pp4BifxtxLVDBkOjgySlr47PniVBjNLJ8iiZ8uOfQwKmoQZT9/7cvD/yfvcQZdbVG8j67y/J+FiEIph0eg1EWrg/KXxjMvdQgBi15gF92HMrz6o6F+3wVpZ41t9KOCg6MbQMXHBcY34ZYHNuhUpiddmqoPUpsacIZqh8fOHkpX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lJ4Gv29t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MTtlsjzg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42E7mqmh012798;
	Thu, 14 Mar 2024 10:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=wMC6CN4j2Vul/kLwwpHXjAarc9xyEa3TEICxoFa7PZg=;
 b=lJ4Gv29tYjQbFI4hJkPB/wGt+0yCJ9VUOA5f7TCmF1la4rl+mbOG7CH/N5eSjfEoi2eP
 c3RMwdiQMkPt42l/gTDtSQ/IT+vZVmyPKxYWMwWsU2+zhFMbIIItCONLVZtiJWt5ZTyr
 xiCqo96QnuHvcIUuu/bZMm6zJnIxlkCkPmPv4yc2+3fDarj3nKMpibfVwiDzxgV7jSC+
 qD21ainfHeLm31oScO7eAshQF4FSBwSASaKC1fgZfMV612X7MYo/VaNkmj/SPjMvTLiu
 lDrQYNB1ginSG2r8ouxKwe72FytatR4YLRPoTRUOrGN8dntWEhLXh3BW8r8negMYk4iH xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ek3st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:38:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EAAfv8004920;
	Thu, 14 Mar 2024 10:38:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7ah9xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:38:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUYUKAgujCJ0mMngTJW5dVh3i9RINMse20r5GUMECwg4MYnH24jUQOtuKRTJfw1m57gD7cfymXb/ba0a76lNKVjXaAk2uObI1ReOQMov6A2hyf3FLgyZRFa2JmOs4c/vAuGGzOEAmdyP1KuBX5K2jT/c23ATc45mAOHbWutpcnjr3Omhgz4dbByZ1KFsj8Hz38D3NJDmbd6O/WqdajvRbBC2rEqDlNVAhC4MVn08RuV22+cgbLsx8AyBoeOVAuJ6Jl5iydhVhXkCMWXXj3aiG4WVQKWzJU84LasUhRPz7EHjjGMlv2taIwiEuAxy5j7oFaaTwrOeEOYn3oJB7c9jGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMC6CN4j2Vul/kLwwpHXjAarc9xyEa3TEICxoFa7PZg=;
 b=gjsOBeh9GkaiyTEOrg39UOxyX/9svRpIJGk30ZO1xj4iJTZoQaN8j8gOyT1oHETjZIYOcs4r+u2LmvroX5Q4SzcuPqt0vcj9HSqe08A40p5ImOE+AKO+pBiaY/ZOcYol5yWTW9LoJONtU2+fwX+Z9deH8arBuPcb4aA84Mlys9GWkLvRSFlxST4XdfCHknTEV0jXCeb05TCiZj6cUfP+P5FqAF5U57saJMrIQckcXMapTNwLtUhu2pKupGJomNnZme9sARnMZafpGbAVs4XpK0XlV1UbqjShKWOciN81LsWThOb+XzJ8bS4zZZzTsnqRe0wJB115QyLS3YN30r7N5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMC6CN4j2Vul/kLwwpHXjAarc9xyEa3TEICxoFa7PZg=;
 b=MTtlsjzgKVfwZYD3K+lC+tKuMrMXrSOG6YDW8ltcbznzs0HhYDO3xe/3EqrGe5sHc9j+YWHYD90SM38fQHMJ4T2KFuxNgbowgt53PfGLQeuQqNpfzav3MDBiL8Se1B5Rqs23kov+Va0HxVoIxDi/l2NUZIvCtf237rchxK+rx+o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6617.namprd10.prod.outlook.com (2603:10b6:806:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 10:38:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:38:11 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, boris@bur.io
Subject: [PATCH v2 1/4] common/btrfs: introduce _require_btrfs_send_version
Date: Thu, 14 Mar 2024 16:07:37 +0530
Message-ID: <b9f5d4d4ebe898034c36b3b7094b758c2df73e1b.1710411934.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710411934.git.anand.jain@oracle.com>
References: <cover.1710411934.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 15adbc30-cc13-481e-3996-08dc4412d84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o57M3Nh8pPxqat3caY7t9QxiW7ZJY8E23gQEz/hyn3Wg2/kvf41pJ2k2+FXwdDgRusXNDg4LqNEojgjW1xgB6yPHzhYnVYkACmPdhjcOAvQZCBJ96UvSfI+6fTWq2oS3Lmacy+3vqIJ4GN8K6gVmHK39NvFEkK4OqRRsOZBZ9hGjxvbZkv31IRRIkyj9wmnakSFL31b6XCYgcJC3cmCCE1Fx3htPSFABLrrclqFSU8iFdlqbrw8nHu8krLueCz6pB3bxf+OhC7EoSMWqrJ3v5RJV4cogXTE95I0o/S9492/tZXZdNqroBC3iewXhaTwZT1RdPznlwdDFNxXz9txySSE/tpJLJSloPHlA0d7kuMx99lQx1yn8fQ62iNiEmjILCAEmeSgKN2rMYg5QAcX7ynYaXhDkZcr/Vrr4tEsJaY3flFZEi7Ufc5iIIqrjL5otF+jJFOzAT5UPERj61WKVLXyYrkhrewx7TzfBhZZgs0mF53AVPZiMWVAATxJtpN+MXVoJRe16yIrMiL6mZsL3CQs1hVnG5o0/h5Bdzf9s9l9VPR9BxCGMGWYaWoFvfVepcW9W/z9jfrv2dlMJ4DevUN9fuykhWVsxU2ODa9AGT4SB9pb8nX/05qGusyKbgPdyDKEnoE+y+z5dxHHpymRCWFGQwt3ZYlZMt3ztIlEvBNo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zhDmhAjD8Bg0D0/2HkLkFIxYAJRcHwTVsNWAA+ExYQ0e5bjuIrD7jbrETKZB?=
 =?us-ascii?Q?SZrFvYpbgAko6iS5UPpLxB4FawWHcuYp9x85yf0VMr9wQUSyiJuN5o1ZJHSL?=
 =?us-ascii?Q?Zga01dHvfj5HygpCOIOp5RM5oll7WCO7uvvLG7si7Yn6peuqEurDHb+AQPFa?=
 =?us-ascii?Q?AsLXLaTisx7d7vqh0VuPWxGC/xJL8t4CYXtA7nb8xaByd/fCe6oGPnXYejG5?=
 =?us-ascii?Q?skemeTzLEpBqlqCWXwG648IZOPuwXmer6C+5sttmHJ3Du3GdjOYvZXWT1Hk+?=
 =?us-ascii?Q?9N3v6qqjT0pATi08wpPo7XhDW8XeDTlqg9d72msR1NufXQ2I7wE7fNeRyGtu?=
 =?us-ascii?Q?fUckDDCSJ8Cx/0uUKBoMHwi2/8Xw78ueSX3nqqJZx2rDnJ8j8hE+Nd9QI4U7?=
 =?us-ascii?Q?wuFyiqqNoVRtX15RPbQBS3mFr+rEc21xp3+yqi9YY/5J64rILphpNf745IxR?=
 =?us-ascii?Q?G4HMqVCOY0eLj8zdq3EdYqFYZdu8Omq3QGfZbq3BRmAVh/tWQbdOF1LdWyEf?=
 =?us-ascii?Q?Ou8mt9jpBShlI2DgzMAsFIjdVxZ/QnFbibXUoxaUebLXZIqmklF4bva2E2FB?=
 =?us-ascii?Q?Nar58K7hxqZhin/hGLj77jdxLEwQNMrmuggC6B9YI7BnPlaDbDEtTxzhbaCK?=
 =?us-ascii?Q?AuDut378886689xRWkKayywWeQ0YYneFFh47tq92lw+eswPJMIBAUYtmrig5?=
 =?us-ascii?Q?87susTv7dD3e7TnQD0kDKOMAN7odJWzdO6ZUUXls6VlGa49wMLSVy68ICT0L?=
 =?us-ascii?Q?FtRVjqo+kYSYscwCxYMknET0McyFtAkdtLBmMM7noqxkH8J+0UMzjYwWzsd4?=
 =?us-ascii?Q?+hkyJtHBLBNsec/CzpG+FzU2fBy+0MYOMdaQ8jXiLmGR8716JHGnylVO+fsc?=
 =?us-ascii?Q?yBmOuowS1IKR5TnUC7LJtQYgVUXd1z84o35Ju+qXTWQYURa6gbpSGXGA1qOL?=
 =?us-ascii?Q?/F3fKwZKxJq2DRS1z1VxtRN7ys2I2vN61faasQhNy6RnzDX8uwRFl+dTvw7W?=
 =?us-ascii?Q?l/cHdWhUpc15KO45OnfaUdPHdqE4PpD2F/ls0LBzJ+TyPslhiDEBqRd/jC98?=
 =?us-ascii?Q?Q9zXW+hI0XdA2oz7h28jZdlqMuH3tsD0+la7OitLjOb4IVYAMnkXliUnlB7l?=
 =?us-ascii?Q?gf8XttTZ1VrFUEmOCbtvtSk4cpDZxKuTY/UZoGjr+a+wQncLc7VzwzKum14v?=
 =?us-ascii?Q?DdwTm/eEmXzCpR2fcpz4ar8uP0nNXqfjYo1ot6/kbXKrK2vjQ9gb3Ov7u4aL?=
 =?us-ascii?Q?geCQc7MnRspGnr+m/qtSvUahhTiVHZA5yyWqbENzpOAKTYDLP4eecr5yq5ha?=
 =?us-ascii?Q?wNgoJ7bfKDkmF/liX41g56AklfUeFafaxut3YPiQ+iDz3DmV0tFGb9LAKOry?=
 =?us-ascii?Q?cmA+nY4xcH2w1rVHeXoi5LfUEXJvzFulf4GtyVnHPHWVAVy4aGfHHmCGW4ti?=
 =?us-ascii?Q?Rszpvha2k7yJ/hzzMFgPmIMKs1R7w0rOXc7y3BpEzQ6WtGVOxnUlfzxa4tN7?=
 =?us-ascii?Q?q1pd99/ZQ1L6HaVVWPGV05Rnhl2riYFTUsRSxKhdvK8SIz9KJbCfT/l+Bkkm?=
 =?us-ascii?Q?/yRCoJ6yiSc99a/S+u66PU5HXSPPGP5iGlflEKE4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oyb2wpe9z3N5HGeaeBiq7pWS8V9i+aUTIHrkRWMUShcXfq/v9JMjDqXZI9a1sMogALQav6JiAIYBCbkWChbWxj8y7M3JXYiVk3YmIvxcup8F54JjsPR/pJqCaFicqbrQswOhobi5IHd8953BiVEgumXT+F4VxOsircDxKKDtxW3tYF4nZWxMQ2WzXe8x0W9M3140xG1xYAfnXKWWQGtKiPA3yxxAFaqR5MT0ot3N0g5LYfL59MQ1tX2EiAvG3M/1biZbpA+G99nwLYcHGya8rmTeBA5nOZNevzBWddsTqZ3p1YOBNLYN1P8k96NL6XllyDjEUPHwqIEHYtcBGrdf76zvuLWyjj1OiXh6zdJABlG6KmedMPLbLhSZWfIAxE3SGMDfa4FR//X6A1hiWSd5AXu6hCSsH8CZDcEN/h8WTnEe8ri4hEY9v2AsVrREcZPdqWj0zmJmBujF12PzEASeZk0VEwkMzgBZmrCY48idfYcBBJvQ8gwdbuZW2PiooTCGCEoILdZszYBxJpHfT98Uvhw8hRRhyqTe70HC2eEJqVmJaW3VJtlOMNPFy37JjWKbbTNrf9e6AmZ/32cL//HcTUscWFWu/qNU1olFSmSSW0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15adbc30-cc13-481e-3996-08dc4412d84a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 10:38:11.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXYCcakZlbjuFDSg67/b68YSVJX0Kqrt7pXtQcW9QHzOituvl2Z67lTIhokHC5hpixRIG0DFP4QOuYrQnKhrAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_08,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140075
X-Proofpoint-GUID: MfezuLvHXZAxxmt3Od1ZByJWwVJdcOfV
X-Proofpoint-ORIG-GUID: MfezuLvHXZAxxmt3Od1ZByJWwVJdcOfV

Rename _require_btrfs_send_v2() to _require_btrfs_send_version() and
check if the Btrfs kernel supports the v3 stream.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs    | 10 ++++++----
 tests/btrfs/281 |  2 +-
 tests/btrfs/284 |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index aa344706cd5f..ae13fb55cbc6 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -662,18 +662,20 @@ _require_btrfs_corrupt_block()
 	_require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs-corrupt-block
 }
 
-_require_btrfs_send_v2()
+_require_btrfs_send_version()
 {
+	local version=$1
+
 	# Check first if btrfs-progs supports the v2 stream.
 	_require_btrfs_command send --compressed-data
 
 	# Now check the kernel support. If send_stream_version does not exists,
 	# then it's a kernel that only supports v1.
 	[ -f /sys/fs/btrfs/features/send_stream_version ] || \
-		_notrun "kernel does not support send stream v2"
+		_notrun "kernel does not support send stream $version"
 
-	[ $(cat /sys/fs/btrfs/features/send_stream_version) -gt 1 ] || \
-		_notrun "kernel does not support send stream v2"
+	[ $(cat /sys/fs/btrfs/features/send_stream_version) -ge $version ] || \
+		_notrun "kernel does not support send stream $version"
 }
 
 # Get the bytenr associated to a file extent item at a given file offset.
diff --git a/tests/btrfs/281 b/tests/btrfs/281
index 6407522567b8..ddc7d9e8b06d 100755
--- a/tests/btrfs/281
+++ b/tests/btrfs/281
@@ -22,7 +22,7 @@ _begin_fstest auto quick send compress clone fiemap
 _supported_fs btrfs
 _require_test
 _require_scratch_reflink
-_require_btrfs_send_v2
+_require_btrfs_send_version 2
 _require_xfs_io_command "fiemap"
 _require_fssum
 _require_btrfs_no_nodatacow
diff --git a/tests/btrfs/284 b/tests/btrfs/284
index c6692668f7fc..0df494bc8ab4 100755
--- a/tests/btrfs/284
+++ b/tests/btrfs/284
@@ -12,7 +12,7 @@ _begin_fstest auto quick send compress snapshot
 
 # Modify as appropriate.
 _supported_fs btrfs
-_require_btrfs_send_v2
+_require_btrfs_send_version 2
 _require_test
 # The size needed is variable as it depends on the specific randomized
 # operations from fsstress and on the value of $LOAD_FACTOR. But require at
-- 
2.39.3


