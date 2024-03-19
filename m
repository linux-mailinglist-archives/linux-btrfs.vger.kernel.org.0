Return-Path: <linux-btrfs+bounces-3407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D288000E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8203B282FA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA23651AB;
	Tue, 19 Mar 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fqe8JDPq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zk6Q3ndA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C754FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860254; cv=fail; b=TO410gfIK9k11bu1TODnF8dFB6iZLewMIDOcHB7hCKyllb6WxPSU4Z9s7a1Jz/X2AQA+cE4H6Xnzc53xEyjLbgfyZdV72mCxqoxcjWNeB/dZzPPRbpeNbDmxB2w8SqG9iB1zJr/IHzJeIUAwGJdPzUrQYyp4JlNIAIHaYuaUOe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860254; c=relaxed/simple;
	bh=nv5EHOBBlWol9Zbf39GbtkGiCcAuDPSgJui49+QS5uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hAiwkHE6wKUp62MUF/HY2hhda+WREYp9UTnzbD9quglcmF+lNiq6T0Bwz2lSEVnCyqB61aYFyySXfCYM5ho5NZtmGaE8MB9/k3dXr3gs5cgRaUySlwkkDprqwUTr5xLZS2cNJ1V1OSsV7J3BsOZH3FXxeGAbsee2jzZftbw+uso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fqe8JDPq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zk6Q3ndA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHZ1i010486
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=O595ekJVXdpwn0g0N2IDVWi+6EcfmfdpZetsW2NZ7eQ=;
 b=fqe8JDPqBr9bZDVL6JoipBowHkDUMypt/G7APIzsFbmd/fTd5U/WzEeRO6Uj3yPXPMAZ
 wZTiJ/0gsRL1G3skd7fci1yeb8DjRynRKvdHyG9D+PjWQrDMaWY8yu/yiT3laP008Xc2
 0Iq9Bsf3sjvKkQTYjBos4TkUzI9zjPtm+6MGyquRAZkkNxAOHNEJNHMhL7cvNkAuJvtR
 ThBfDr57Jfo10jSJPbx8TvaZU52fBGMNInOlH52J5pUYJlLfwi+KRlkYbACFXhFuV/OB
 tBI+xhhOQa/Cef10O8BuM7pKTqtZZPsEb/zT6wBrSPUhxitfamLKAkOCUWFJmqRHTWtj kA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2115rcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDealO028740
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6c1h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omn7FS/3sXBV6oPluROhYrGDG1xuYxUJBxX5oaKvBDObLYaFc+OfNsmgS1q712a9dvI45EOjmekbqnuJoxxB9xEvJNzwJ5QRRlmW2e+82P4wsenA44eIn3KJfYIJM9NVJvMrO+1dpVcC16bFogOcdIl2ILvwPEx/FYsaXzZ/Pzg5GWmnCy0HX/uZ3+L0Lz9KhBBVy+prrMV2+6jIR/Q5362Vy5mB/FzLAvSTfIy3DtcgyHFGDawJvHMzMo6XzhbOWBDAd0kTrPNGImrX+CC9E4oVIUaBxcfTTc5zI8iqaBBQh5x3OPBFlnDRxEd9F40SucGXleG2qdz7NatZCm/q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O595ekJVXdpwn0g0N2IDVWi+6EcfmfdpZetsW2NZ7eQ=;
 b=hg2H/2fZoyLLSryvIjw1mWbWCIkBSSLB5tlDqUX19ZIAkFXGpsPyP5Gy/6C96VIY2S4mHYd73XHJtA3Sc+zA56RzpIirjmQMqTlxZTNXKm759leZ+Hcr4dEZ2U7IeLawKlLAncW1Q5m/9WrM06Fwtm3Ji9lV9VBmO95sX7tIVPmME7jQfvjqvaIuA4E+CTirUpG2fbL3JWJaMh1TQnQR2LCDAgrybKpzvhdwdMge23b/WnlUU72aCNUd/4JlWkSDRxI6rHAkFIYlW7U+6Lh3OfoBRHXXIs79sby6ibsrRuH5poxGJIWz/BQtnmpS5eXwpy/y6EKx18ADIp7qLXcEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O595ekJVXdpwn0g0N2IDVWi+6EcfmfdpZetsW2NZ7eQ=;
 b=zk6Q3ndAG0b4PdEhXXm2/erB3bL5fPietBXD7onlFNNBgv7X00rPRmIC26mAN1z1y3j+WEZqLc+o3Cf9sHUlWvHkgXN1YD7cyKjwageOkRnIjT0PYV9fB0Ja3ujIG5XuXljyo/WrTq89EF7DdwOAOfyOcGuUSTOMxvTVWgxJp8k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 14:57:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 12/29] btrfs: btrfs_write_marked_extents rename werr to ret err to ret2
Date: Tue, 19 Mar 2024 20:25:20 +0530
Message-ID: <14bd267ea479d4c4d104966d4dae2d88ff403a99.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7117:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Mc6WsMzMEyIkSaoulcydXC32gPucOAGlY9wAY+Qg4c+Ws5dZ3WzQEkxtUiWNyqUqiWAppTSkThgCUYMy4G7b7FvJtr3KuSLh02rKt1DpUg2XoUWAxjB+veenzJXRN8mmuK25s2Js6vZMTOjVQnEWMnog0OXFGJ43Uciw9Ej7TLPtb6rjU8qhJodYzI7xvfOgPThaJ7ckXTtvnXMyVqhs8FbambUGPJAPoc9uJJQj5J2gpvBZyFz3PfrhxPvaiZGLTLHVOsLTRO9W79/kEf6CtoOtr63HFrmDKYcpvreZbPF8NTuCp1AxbnnX58ZDFN0V5KFHffCeyD4ffPLvPP6RjTFWyaYVIzj0UI59DNeFi769eqlorX7MEqWb/xqE8jHUfIoJiiOdy+n61iZ6Zh+0rdCnkcwaHFyB5RtnDpDdxVq8iG/VHLw3vkyG08DsLx/V8slWGGi8L6YKR9IfvRqc5NXbKPG9VkkIovmTu6uKzckycfEj0hrMGBKtBbmoAN0pHsyWW0G49wsWHxyMgSQZQboFt2jNPG/WM3wN9yY7APn0sXSx/iYeKxqU1N0An3/q0mFaRMhB5hEkPGZNN+/zARZbzWUl5oNNLU0M/ADcAgppJj/NN/i4A/9PScImKSoUapyh3BR71uKcktTVggH0CVkbpHlUGvVBa7Zecmglle0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Jx4qQkNAQ085Hg1kwRKQC/M6crkAszble1fXTX+jRIT02X7ztGwrpNJTzji3?=
 =?us-ascii?Q?ahbOJnJWEFvt+ntlx9UhOXqtdyx3EAm7bGnGr8qZu5FzLVputdWJ1zbJQnPT?=
 =?us-ascii?Q?GndbeaitsiHvCkiGohBkj1L971FdlS8x0m0Up+PclrtM+VOY7+lq+DU7cAC9?=
 =?us-ascii?Q?lt0eOAi7rkoQLv8VK7MY7P6KnFK5iNwCf1mtIqDKS+xFMj7xRh8tW9JsB0bo?=
 =?us-ascii?Q?Y3c1qk9O7BIUsgf03QX9W5bAKKldx+sOeh52hxdTGhe5RxVv9IFDp9TyPWDF?=
 =?us-ascii?Q?iN8ZSOmURQJhfRAGY4KNkbeHSqhTcKcFdQWvBWTrlJDd/uhZHlQTgKM8C8QV?=
 =?us-ascii?Q?v0BtK6rVOQfUQcrUGQjpx+98mnamkF4obXiqLyMgxqnZ+b8vEt/pG5vbQGYy?=
 =?us-ascii?Q?VWbj9RkDrfsMjwDQ2p5UHSy4taSGnFMbuxTNtEzLL1FBoJFhWUAlAAtkW1aE?=
 =?us-ascii?Q?TcdXoKsSeZwp47R+fo62UYolBoK6K2dEr3zpRhuvGpa5Va8/DFSMq/I4IXZt?=
 =?us-ascii?Q?AIZSnWWbJNCbbknKXWC6ibLGvWkZGVwBCcrKfkVebnc4ebYM/SZG26jYcZGs?=
 =?us-ascii?Q?NlMbMqcRlxQMEEaRWCorRKp/zIKnN9LhA1tLfJqwnYpCe5tW7DT2/wDc12P0?=
 =?us-ascii?Q?i3O+jqEcT/dwD6z03XV2OYPSdcAWwp9ucrV5LZ61U8KdfaP38BpgZxy0OkaY?=
 =?us-ascii?Q?KRnkSLvjOtPAlNtZYrIpgAtFJW/OFkKDXLlmsSob3fKY8fOYB+2p+Vmj7Czs?=
 =?us-ascii?Q?Rv11jkDO4fqFsK9DA5KoIQymnthEjQfiXQF86qkGYZQOiUz2uRAFgsDE/TuW?=
 =?us-ascii?Q?/h+jUeX3JdraDpyRJkrf+HNv001joSfrkTQnnwIoY9tfEr57rql39irOPPAO?=
 =?us-ascii?Q?1zDkQQvEWecqxfBGbfHNTT/3QyMy1tNpEZJmnnIyTS/S6wuvr0m/4hNsRVjk?=
 =?us-ascii?Q?v5UdAvGJtSIC6z/vnRQjR/0Col8ZwoF/pP47eMlty3mMLKATeHyJXwsgVeUS?=
 =?us-ascii?Q?CMvgxFGGuwlkJ30mY2H6uA7QHOSNbfAmr8VTnre9yPPS1mgC+yCvGVzeSySQ?=
 =?us-ascii?Q?JDk/Rb9xRFBUamh9XsR9P3AnPGL4ias2xmxlE1+rdS4O0m8mF7w7/rBi+iD2?=
 =?us-ascii?Q?q2WiZds0hjaQBDyjO/TLK8L9VSGbVUTL9awBpJpCYbFG0kvvmffXLMvMuwp8?=
 =?us-ascii?Q?vSn9B/6FdC1NQwveUAuAuq980m3k6QDVo78jYDhfY2hqkUgrcRZIacwpUZzX?=
 =?us-ascii?Q?uZ2jPJCSRYqCbqbtzrHwOL4JDAtQyenQXC89uX/w4XHOZZjK3Qrb6EnVPZaA?=
 =?us-ascii?Q?NzuZe8l4VpETLl/Ix1tgSoj4QopwGsbas/WeuvCMioMHKl80zzGUQvapmiH2?=
 =?us-ascii?Q?6yHtRDT577w0BniXwmEdDmWnCC6tRvT6bX+xBIlpRiayXfCDVYWNHjBsIsFh?=
 =?us-ascii?Q?roV5u+TPOkRR5BpeXN92DZC8K4jB9qE/MCHMpD3EsGrAmHqb2TqQBxssmYpq?=
 =?us-ascii?Q?4vkOo/o4Dn+oyv3isjghl9okzYVz1mof2vcQdYmw7JHCeuZ5qNXujFBaAgP4?=
 =?us-ascii?Q?ANl2jELa5WeUyGmKHRcr2zkDoFcRf2i8djdIDl6m0gv/4EPzeLTAML/rvbfV?=
 =?us-ascii?Q?nw86FQVtIWekFD7cN4XPEQ9GOeYsipbNKrH9r3JaaYew?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2Oidyx4zNxivesWX97JgqouIaUwVK/g1GVjhzGMR0YpVtmBLmBkRnPemZPuy7lIlbq34tgnhKGlj2k29YsbMD+dFLergZdxy+r8HARM17aYxXiISnob/hWpUTIVaUkLVh+ODnLlolF/9lvRquX0aOUpvABLYWmH52UawCOADI1LoEP6tZ9pdYe+Dlr/1EzjWr+J0zA5LtacrDMp5FP6qsMzCDcRRc2dYvGMlJ+xus8dYjknf5+AnA+fF5fJ8PJB0xgsXiZ9vt7ZxU8nDgNwLh5OoOgeBMYdqXNNte+lZHpE6/ZNFRJXw6cu4etupXDzhKQxS8sCGG9d/SnBSRcG+Fp1qTkfjn3dDLmR12KuBHUIpTy71qXD6aXxziZ91mrqM6GzxGepp93Je2nGO/8udBgxde9UhBlUixt8wn3wlfRi63seUms/tc/RYSNRN6EEOC3fDuoefqRsWPTKiA80gF6EEJC4Uyjb2DykKvInmzdgmO4MeJ3hpoyHDDkuX1hPn2hNeOgEl8zke7y2/saUCV4+nRk0LUwRSsEOGIR6KDk6QWANbnhqeYbbERnT0Dm6YeewGQ0yCpxjpidHkN4KK7kNX0ERyxu0RLxngoZUgfbw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48d15b7-efad-469d-6263-08dc4824e55e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:28.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5om0aENmDl/AuAQEy9VP9HMEF8Imjw8W13Ra69nehKQkfKEGI6YF0WO59mG5E7MKCzmgOuHz5lu9rMydzfw1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-GUID: RhZfXdZCPQ7l2BZOukM437F4GuipGwlC
X-Proofpoint-ORIG-GUID: RhZfXdZCPQ7l2BZOukM437F4GuipGwlC

Rename the function's local variable werr to ret and err to ret2, then
move ret2 to the local variable of the while loop. Drop the initialization
there since it's immediately assigned below.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/transaction.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index feffff91c6fe..167893457b58 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1119,8 +1119,7 @@ int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans)
 int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 			       struct extent_io_tree *dirty_pages, int mark)
 {
-	int err = 0;
-	int werr = 0;
+	int ret = 0;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct extent_state *cached_state = NULL;
 	u64 start = 0;
@@ -1128,9 +1127,10 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 
 	while (find_first_extent_bit(dirty_pages, start, &start, &end,
 				     mark, &cached_state)) {
+		int ret2;
 		bool wait_writeback = false;
 
-		err = convert_extent_bit(dirty_pages, start, end,
+		ret2 = convert_extent_bit(dirty_pages, start, end,
 					 EXTENT_NEED_WAIT,
 					 mark, &cached_state);
 		/*
@@ -1146,22 +1146,22 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 		 * We cleanup any entries left in the io tree when committing
 		 * the transaction (through extent_io_tree_release()).
 		 */
-		if (err == -ENOMEM) {
-			err = 0;
+		if (ret2 == -ENOMEM) {
+			ret2 = 0;
 			wait_writeback = true;
 		}
-		if (!err)
-			err = filemap_fdatawrite_range(mapping, start, end);
-		if (err)
-			werr = err;
+		if (!ret2)
+			ret2 = filemap_fdatawrite_range(mapping, start, end);
+		if (ret2)
+			ret = ret2;
 		else if (wait_writeback)
-			werr = filemap_fdatawait_range(mapping, start, end);
+			ret = filemap_fdatawait_range(mapping, start, end);
 		free_extent_state(cached_state);
 		cached_state = NULL;
 		cond_resched();
 		start = end + 1;
 	}
-	return werr;
+	return ret;
 }
 
 /*
-- 
2.38.1


