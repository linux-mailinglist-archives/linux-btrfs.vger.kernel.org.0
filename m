Return-Path: <linux-btrfs+bounces-13941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0B3AB430D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68D61886782
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853A29ACCA;
	Mon, 12 May 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rAg5mWGp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hjRiw5Ie"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F129ACC3
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073476; cv=fail; b=FN6lur/5lWjFdiUlsKLJ10HcZ+yFOc4NNZGv9hqRph6Y/B/Q6sYyM596Au8BQQhcIZ2n06m67XH7jsOyCYljEeVtivZN6nWThxg8IEGoZloJquGQ94Hl0UfpQQXmSXyekZG+0FMoN4m+NV1/mycXAyVbctN/IYcdjgif7VXFPTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073476; c=relaxed/simple;
	bh=BksXoW8fXTYMXf2POUOZ+DG0z1XtN2Y1Wdx3kPsNGmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZGr9Iu2kbG94bxeX4Cnwphrz+8l16xxqOb5uyaLrcMktyt90BuzEZkOw7YGY9tjxExD0z1HFDRqzIgkoDi+nHFGxW+2FJARXS1w2mGVwZBPyqvr7m4fo54nKo882vT1vshXPEUFgwKmV1YQNnpdruHSkcO9FF3nyu4RVTF+86M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rAg5mWGp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hjRiw5Ie; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0tK5007990
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=spXR5UM0hBSEnzgbA72v+9mFnPmXDZ/gBG7mEMbxYTA=; b=
	rAg5mWGpdzsvT5gHvKz9e71ifdwxDOaYuJ+BuK/3p2QOzHujz9qTJvqyn1BY/zS/
	H4BP3ftTjA/L4zfw5qBZb0ChCUjawknQTe2oWQHZPx+SIiNnxakOe1aiy3knCpxC
	l2KXv7WqCxtJDlRSMOD9eu/a8vLp6kc3rCuWjDVtc2stJzcN7OjPjXCG/AJk4P54
	gimPsqkO3UHZ3EGTqa+aoQdf2gdSncDrDEti01L+U71EbwW6bNHNWvyKGdB8tQo8
	mfgm2I9OAigBzqhKFAjDN3E0jYcWpNQwr0rsoMmNYT8zssiflZ087XbWzNJ9u1E9
	MUW+OrymWU/mVvTH72b/qw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2b3n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHYaLG001988
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:12 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8e79up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK6xpkNPk4Yop89GUp8JaCpkEEGVsqF0zpwpEV2VDu8gvuO2GzUD/jZy5kxV3W3ReTslJbdTRGf1ZZnQeicpU/j93gjv/x7Kzkg//eIv8+ml8XyeFInBsQYAlqtDySCjuZlsXTY+gJDTreHvPUzSr/c+3Pxv2eRyP9BqAaROe75Bvu8QceSeQaWdgHhmRO/mhN5zylfLKU+9S6jE4bVzAawk+9zJNYqW2rZstksqg/3rn5zNfv5AzZGJ16xGP7iMtX3XUlAdQL08TqAt2KPM2PuGjo/jgzD4DqtwMgenN7OSq6MjserqJHxXaAoxS9NAf0+GCBWQ7bdaf8nLlYjPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spXR5UM0hBSEnzgbA72v+9mFnPmXDZ/gBG7mEMbxYTA=;
 b=ehrG4gVqIrD+8RaxsOPI1w5s4VIT3mA8ojNpqEotsHh60Ma/v3zAqq4kwJRpvYMl7DfpYOV8QjBzByAs+CqW8AZDJ/5KWm8+MtpRXwITKm5D13riNNw1Jf8MxNCTbFCIQP0fHbRPsNfTMzmzuY+YXxb801QfBQDJ+dNYaGPnOiKPeYUxNdZ0b1FWMc1pYGD5CeIFCaP/fD7DRhVrfsiZ0S52zCixbsX5PCPkWhAPBKhZxbrS3eh08u9aCLSYoZ9W17KjhcMeFJrDP9quzeMGD/h/cRwprwudWDO2bVJ6wU5qgHlCXW4p/dbIDhmbj49wIOlVOy46hJOz36Opd9GqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spXR5UM0hBSEnzgbA72v+9mFnPmXDZ/gBG7mEMbxYTA=;
 b=hjRiw5Ierim/yjfNjQVqmxL+g/PjVQbs7MXqhDT3YGbTZh42M/Sgu6mAi0pIAlDxc3rymuHygbpsvYWYUuZL0iofI+BLz+loF+0wI+Y96zzFccih2lzD04rG/uoZzq8BrYmf5HBeTxGyCM5zREcaqyEYByd0psogtTxFs9Kv0Ng=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:11:11 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:11:11 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/14] btrfs-progs: update device add ioctl with device type
Date: Tue, 13 May 2025 02:09:30 +0800
Message-ID: <8e5d35b2239f1680f40e4f542d1eb8bf979ce64b.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: dd123ab0-bd3a-4e0d-1e57-08dd9180600a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUy3JM8veMOHTgHGgZpmt1wBjyfFswbTkaxj+9Q9MGuadkpMo3GI5nBOvNgo?=
 =?us-ascii?Q?w7CbBeUyYlHp1tQX4KYMJVpp6JWjuzuddasM14zqhU24CM1GNYA84j9DYa8a?=
 =?us-ascii?Q?TcM8YHwJ8vW/mWC4CEZ8lBx/h8LYRwu485uzj/T3H4AwJ907vB9I7gaQlr26?=
 =?us-ascii?Q?hjix1uMRhEKBinnRAx43t9bDwDsP6FEJzjIMrQJnxv+Ye2BRW/TMzKPyRzS+?=
 =?us-ascii?Q?KbrmCCFr5eQXRi8AHRKkBdxSwbHZvgqhX3mGWiMvoZCoZHC2omyqcYdeUPjo?=
 =?us-ascii?Q?zvXolS0Ym+T53BDktPJJeQukMYcJlPJ63NlUyGNHtwSZ0to5A+e0y8yFLjZj?=
 =?us-ascii?Q?njs5Pc14EM6W5y3qUANr8/rO+fnhbT0lwsNyfIOTabXxKi0a8e1P6inVnNta?=
 =?us-ascii?Q?fSiP+3nNs/ZbvYBOtecKp1r4E1tKGVn3t7ocdAVlKHUPe5GKP+EJsS3HSovd?=
 =?us-ascii?Q?uMv8jH7NrZ94X/SMrrZ/3M7d5RBSJTayLfCj1ZK3Ft1yUZTFJUW5vdN1jsa5?=
 =?us-ascii?Q?YdEMrif/lCkBQYJBCpVAQqhqgzrOG6WD/CJcwbJa7ePaHEiYwAEtqA2tbO8z?=
 =?us-ascii?Q?FigzhZ3d13WX16wUFgE1WLQoy622PMHYkWIa30vJq4ksuuBQOdKZDJnWvyOZ?=
 =?us-ascii?Q?w9xU405cpYlRe6L+8CAyExk1SKloX9BX/miapQUeEnIfZWCMAkTLTbe/zexB?=
 =?us-ascii?Q?Er/l/XpRUZvBwr2gCgCFa4HyIEbKiskD2oe00rq7CBVNnU4+nSuwscOwImWi?=
 =?us-ascii?Q?5xno5Xg9EzyXtDvWbzqgkq6PCIPH8zhZgNvs4FC/DXPuPiq7ztKgWkBtcZIi?=
 =?us-ascii?Q?2tazDDyYvm8uyZjHduTIjIEZZhgp2hDkA8XekreF58TzUMrg7pIsHS15OeIf?=
 =?us-ascii?Q?b3vT0YDuK8PlQt6NjCpt4cx3M2vjR1R+n46njc4k/TwstNFZskPvBAPZaqW7?=
 =?us-ascii?Q?Oe6sWTt6jo4/xv6CbNjfvDhGrT6Me+AXQ8eZ8Wu5E4wQI4HaSwYimZLIr50h?=
 =?us-ascii?Q?iXIL6LATT7NX9AAWQX9ukPKoMR814Du2hDNgO4NGFTyxxkWODoS1aKkL92vj?=
 =?us-ascii?Q?eRELQjSHm2gP7ysuMfZqz9ccOw9UUpZaNPkWPHGb7+xEmMvccPf5tM3JXaTq?=
 =?us-ascii?Q?yVmmwqvlI6xQ3R2Po/cKnzX5sQAS1tMN0TyM6djsQfej0NdfEfRMC/XZvlKO?=
 =?us-ascii?Q?eseW6t0M5ZwSa5M3XVQu865FrOo6aP8KhT7ddrCHmz5+t0Z7uetz0QAadS4p?=
 =?us-ascii?Q?l4gGXEC/ZCUT0nU+rV3X7HRqn3HXsB9OI5HsrT7BJMVSci3yYHlVcPUpBwtb?=
 =?us-ascii?Q?md1tINcgLs5kVpJpbZV8HnACg1QeCre6pVfMYCuzsrr9IWspn+E4TV8TIN61?=
 =?us-ascii?Q?e76QEAT4K7BF8f7qkS8ZfcXRXrPDTxvivtHOQpsZiq4TV/2+jE4w3tzV08qB?=
 =?us-ascii?Q?kWf2WZJnj4w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uC4JfczlH0GcKpY6dVI2UceGg6YD6OiuXTjH5EInnij66mQ/oV7T5kChQriy?=
 =?us-ascii?Q?W+bPXPe7PLOk3ibwznqrdyBROZRQBSBmganSUEioooZ/qLoU3GuoFUOmYyaR?=
 =?us-ascii?Q?StYKTucEbn3OrrDIwwe3RSZIOJ7JYl2+nmN06a7Zr4OrzfkNMuVs5hSurv4b?=
 =?us-ascii?Q?bwxxzJvIBLiwtWH8HC2eqzVVJhB3bpXKwh4mgj5EvlGelU8aotObTAF8rwgh?=
 =?us-ascii?Q?EHOrc6ilK1DdGzQ0US73Hj81vyKQfU1/l1CVdpzS5eN3r1mjCoy8YJOBcfQx?=
 =?us-ascii?Q?qiLW42utWJzcQNBAEQbI3HRWEIzB7LInUaYRGkql8e1NBR2aMi0RWago/tZe?=
 =?us-ascii?Q?ASv1CJO1jonc2vOgzvCpnPcBMHsG7AoKpRbNAXFA4Glmq3G87pZjnrFUx+LJ?=
 =?us-ascii?Q?AxNNcdLlVd2NFj45yZwV9xFjTdkJPqZx09MH6B8qPJqT1G+agn0beo5VVVnu?=
 =?us-ascii?Q?eOjUZ8v6f19EH+aD+GGHJr+su1q7RehTfB9iCVKUSeF5DVXwwhprehF8bm4K?=
 =?us-ascii?Q?F3hkvPiEKGUgXAPLGEd3VRiunEdwD82hD0ZX6swgj5x6f2uSxc8AX+F9686n?=
 =?us-ascii?Q?r0hc9RGybE1WfwhrQ3LIwDnemrpOAExNfzMXrr4CC+14Z0HxwA0pxbRO1ugA?=
 =?us-ascii?Q?1zyb7NcexafBVx6yTVlhXQLAzGWDFNc4B7ky7DJGumYMZCsCBtf9Ae+H1LxV?=
 =?us-ascii?Q?sgrIinwqPqFiu63jXT/XbpCkT53mp3qDcZmOkrqW3OboN7GG4+J8mVT5zYec?=
 =?us-ascii?Q?3FJN5mh3aGZ9w86HZt7aluxoPiNihvnqxErHIb7jjGr67AZQ6qx/nz5IqIIp?=
 =?us-ascii?Q?N0CXiM9z4+GDbZl2cXhpKbnj5sKIjpWZcRPVlFYNNoe3h6psGwoDCMVIhyeB?=
 =?us-ascii?Q?9bkKKId5CyNh0k4fp+S0ceBqZC4x09yv5hgOlfcvfe+x2iuOyfWH59lAAwBG?=
 =?us-ascii?Q?6785T5DPyjxVipryN4e8EUBIanqL2tnjSx6BKD7mJb/0+l1Jg04oPHCy+yU5?=
 =?us-ascii?Q?FiM7mLjtYt1JuXl9QPeoRZOKXG8Y+9s0M8N84AfBYVuLlaxgfcIlBxwB+wit?=
 =?us-ascii?Q?on3NcE2kytdsbBzmMoj7gsSLiPE+slKID9d6lf8a1QKhbwIKC3Ll6CzhE7i2?=
 =?us-ascii?Q?T/vLE+KhcW66eU2ZXFGqkVGr/8BjevrdsLjpfyFf6iMU2OsThZpHK6Z52uLp?=
 =?us-ascii?Q?T+M/KyOHekrE7skk9Uztb/ppThECAdbsFkOUnWpXcYknFj0GwzhWDtgDIyto?=
 =?us-ascii?Q?xgwFMx5hFQ1snB+gQDKTEnHlNqWqsbKUd+HGr13OTvJqTdYXdSezT6kWDpzN?=
 =?us-ascii?Q?4Krphf6GrBPzXI7YZR1GHjKIJoR58y3P5ZTdQpbMotEMs/L860yzfGdDEpk+?=
 =?us-ascii?Q?MJCWsOqILxSEpt45mlAmjxf9lnai9ZzJe5rIo/D2+XnrfOfGehYWERQtyE6D?=
 =?us-ascii?Q?ylRrNwkohzot5HSw7K3zi2zP12KKsy3wxPMM7/aiCSprFM408EHknT61NMC3?=
 =?us-ascii?Q?8aPCND0cgo8GzjnXaYhEBJGbTAHhkfeWnYhuB2hlGOxM4tS8+Ys5E3L8Q4Mo?=
 =?us-ascii?Q?uuOuhoV5SIPr9LGzfDtyEaMBOyiJYKRIcVthkpsX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S2jHtYZ5nsvDARpJPqHfy/I3KVYl9agj1m8gGSyT09O1Qr4amAjs98xgq29MlmvE2ovU41RLKBXxUJ59cLLXDUU4u9cplKaJXgcKpmeoZ/b+BhAR4KkW1S8IuKaahU10sBK/Zqb0PMZVv2IHal+SZnEFxIyoCpWtrQcuqZ5Sd1CFhszJD4ZM9s231ub7Bg3DPqKjeMMQtABu5cvZ7isuenP07eYkn1RZMQ9aBvHQBSnn52Gizwk/TkoOZz9uPgCMVg9VEbzLD0tdLanP0QxS0Dea0x4XneKSxyS3p4AQ1iHi/lOCqwbBsQhnsGQXUlfG9NqphNovcBFqN7L6OmmqodD76YoGWD/HO4InVAZOEQ2+X9AGmcoUenZVy9sSAS97q27g20BQ+lSxldHzJgb9pnk3uMBszf28cbnJwC7CP5DEGrIlF2S1VPAb7ccETH9vGMy5JIx1bGxZBO2zettAgznSWbi0sWGa0VvztYhfXbUbcud05ePZRnXvv/PEM0UzMk8DSLvT6Dc5GAcgyQ5tmcI2s9mgTWL9qZraIfcMU8A9+lNl5HSVNKUO1vMMHgL0+w1pZst7HrkZJLHLSIhFqOY7F0kuD+e4UYqNFga+MSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd123ab0-bd3a-4e0d-1e57-08dd9180600a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:11:11.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr0dacZxEXmNadMhF7Q7ZeFUNahasgKvItc+aLsT+btgYz3DtapitJsI9oAxMvmtaXCBBzaFWeNxkIdITX/7ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120187
X-Proofpoint-ORIG-GUID: 0yEWIB4tANZ9PBxEf9gLn7YLtFbItu3L
X-Proofpoint-GUID: 0yEWIB4tANZ9PBxEf9gLn7YLtFbItu3L
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=682239c1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=dkNZlqp4j50Xndsi5RQA:9 cc=ntf awl=host:13185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX598GK2zs5HXi YM8Cfj47mfPQ+e+AmaUshxIAXUmPgUSHtiDCaehNGy88RE+wphC5SwnJ8v9sfuJx9G+NMEJUQtQ TOx0mMJhIFJJRYrumJQtBMlyFZ27NcqbtpiCYqVALoYUyH9zBnGxjxXY3Leymahm4OtfzLvJqGX
 fxZXJzuU+DqQ6fGIP998LgzsFCZBr01XHF/ALI9Zg8OtVkzVRmrheJP5StcnhtMCGbfiqf6mY+s MHaR81P6g0n9bNmRxwW7uqfqJjF4+iVtcCSn5Ts414Hw28FbSQxvWyfLXcOrqOIlWxiJ11bBlWV w4WkleoZGqs4GdkfYL7g/B/lKGdgDaLm6ONYud270W2THmPopsU2xu9M4tHdYco6BductBID7OB
 d0T4Ft5SPGcgkrq8RWoUfUO4mmQyks2Im8Sqa7K3ovc9DJsTPOfu4H/LbcDll/iGG1EEETIg

When a device is added to the mounted device provide an optonal suffix
to add device roles similar to mkfs.btrfs;

  btrfs device add /dev/sda[:m|:d|:monly|:dataonly]

btrfs-progs: update device add ioctl to support device roles

The btrfs device add command now accepts an optional suffix to specify
device roles, mirroring the functionality introduced in mkfs.btrfs. This
allows users to define the role of a device (metadata preferred, data
preferred, metadata only, or data only) at the time of adding it to a
mounted filesystem.

Example:

  btrfs device add /dev/sdb:d /mnt/btrfs

	This command adds /dev/sdb to the mounted filesystem at /mnt/btrfs
	and designates its role as preferred for data. The supported
	suffixes are :m, :d, :monly, and :donly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/device.c | 57 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 3e45a72094e6..af2741353e90 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -122,34 +122,62 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	}
 	zoned = (feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED);
 
-	for (i = optind; i < last_dev; i++){
+	for (i = optind; i < last_dev; i++) {
 		struct btrfs_ioctl_vol_args ioctl_args;
 		int	devfd, res;
 		u64 dev_block_count = 0;
+		char temp_argv[PATH_MAX];
+		char final_argv[PATH_MAX];
 		char *path;
+		char *colon;
+		enum btrfs_device_roles role;
 
-		if (!zoned && zoned_model(argv[i]) == ZONED_HOST_MANAGED) {
+		/*
+		 * Copy path and role (separated by ':'), then replace ':'
+		 * with null.
+		 */
+		if (arg_copy_path(temp_argv, argv[i], PATH_MAX)) {
+			error("Device path '%s' length '%ld' is too long",
+			      argv[i], strlen(argv[i]));
+			ret++;
+			continue;
+		}
+
+		colon = strstr(temp_argv, ":");
+		if (colon) {
+			*colon = '\0';
+			colon++;
+			if (parse_device_role(colon, &role)) {
+				error("Invalid device profile");
+				ret++;
+				continue;
+			}
+		} else {
+			role = 0;
+		}
+
+		if (!zoned && zoned_model(temp_argv) == ZONED_HOST_MANAGED) {
 			error(
 "zoned: cannot add host-managed zoned device to non-zoned filesystem '%s'",
-			      argv[i]);
+			      temp_argv);
 			ret++;
 			continue;
 		}
 
-		res = test_dev_for_mkfs(argv[i], force);
+		res = test_dev_for_mkfs(temp_argv, force);
 		if (res) {
 			ret++;
 			continue;
 		}
 
-		devfd = open(argv[i], O_RDWR);
+		devfd = open(temp_argv, O_RDWR);
 		if (devfd < 0) {
-			error("unable to open device '%s'", argv[i]);
+			error("unable to open device '%s'", temp_argv);
 			ret++;
 			continue;
 		}
 
-		res = btrfs_prepare_device(devfd, argv[i], &dev_block_count, 0,
+		res = btrfs_prepare_device(devfd, temp_argv, &dev_block_count, 0,
 				PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
 				(discard ? PREP_DEVICE_DISCARD : 0) |
 				(zoned ? PREP_DEVICE_ZONED : 0));
@@ -159,19 +187,26 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 			goto error_out;
 		}
 
-		path = path_canonicalize(argv[i]);
+		path = path_canonicalize(temp_argv);
 		if (!path) {
 			error("could not canonicalize pathname '%s': %m",
-				argv[i]);
+				temp_argv);
 			ret++;
 			goto error_out;
 		}
 
+		strncpy_null(final_argv, path, sizeof(final_argv));
+		if (colon) {
+			strncpy_null(final_argv + strlen(final_argv), ":",
+				     PATH_MAX - strlen(final_argv));
+			strncpy_null(final_argv + strlen(final_argv), colon,
+				     PATH_MAX - strlen(final_argv));
+		}
 		memset(&ioctl_args, 0, sizeof(ioctl_args));
-		strncpy_null(ioctl_args.name, path, sizeof(ioctl_args.name));
+		strncpy_null(ioctl_args.name, final_argv, sizeof(ioctl_args.name));
 		res = ioctl(fdmnt, BTRFS_IOC_ADD_DEV, &ioctl_args);
 		if (res < 0) {
-			error("error adding device '%s': %m", path);
+			error("error adding device '%s': %m", final_argv);
 			ret++;
 		}
 		free(path);
-- 
2.49.0


