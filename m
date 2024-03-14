Return-Path: <linux-btrfs+bounces-3280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C3787BB6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 11:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3FA2863D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398F5FEE3;
	Thu, 14 Mar 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="djGgfIdw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXmp/rFE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F445DF26;
	Thu, 14 Mar 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412693; cv=fail; b=kqIE5VMHpyeqKZ2hiMZHhEQgKlNSuchaFdJXHXvPKjqxHDaEOT63p5l7FrEPTZDTxNFKd+utMs0t5ZTUroA68oDQq1KqDpfPwN14pnmHtyjbKdAvV/83fiySarHN68IMG37C5nPkGvObR2ErthCoojkWhEV/LCJU6d6mvkDUc3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412693; c=relaxed/simple;
	bh=beevJW7niL4+qt+/8yVXDFpYDaZX128CB+y/7SkvQpE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kpjuXZ2QWgowaIRKaON3cFi9SowPTzpJHDrlE+dKufIb9gMi0xdnv1wed2D2fZTMzAGWw/XgDqDskRGS7SpMpNpNFUWIQ/KvkJcAglYi5CJ0B5bwOSqbQEElGviWGlJsvmUkIYUAuPlRAYEWwAhS3DknVoCpT7JQfm+uGKoGn48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=djGgfIdw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXmp/rFE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42E7nefK012944;
	Thu, 14 Mar 2024 10:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=546TEVurM+5oi26qqHa3jeU95ILQ4x+zyAts+p9xBDg=;
 b=djGgfIdw3CgICVDEYv3GTqecw5R7iHvZAhgK4BD9F0Ee/1iIYXvHBl99M5cmgH2iQGbt
 GGpe+MBKmzIqfZ3gLUYf1vSYPBFyWqEboF0bav8wQlruyxt4kXMAbu3pAVPv5gPSJg7u
 opmO8qvqGrTl3xpVQXGOPa0b7bS5JF/k10Md2zL3hmMWbc4dKkweGsoh0F2aSYoaUrky
 NdF/+rSiiUyj07Un5olySzrwFB8p/VOsSBa4KaNtojglbOJY5Ywjb9SmTUNoqZ9p8Cog
 TqLdgbH3vVlKXA+bO5xJyp9Xh7K8dJEEetqXFCrRIrpwobWdAyciCPXzkSVhjdTl3snd +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepd32jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:38:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42E9Uv2G004975;
	Thu, 14 Mar 2024 10:38:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7ah9ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:38:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hve9ipmAdM6oozrrnsjiRhiTHZFsvtoIBqCsNtXXkv6KK4ouLM9ucobKqtG+Yz/R2CD7BLmutvMAzvW+sA78lbbd+ZpSOKXcTtH/zAiVPNu+W9LffhyCv8Ax9A9rtGYYSJ00V1BiPt3ymwc5InFXv8OC4+yzw8Sp/9QgL2XFl7sTO+ha+zdqNzI5bMmryNVoA4DtzPsdua6j4DgLi5EATJxWvuU8c+UNinrMkknTsQIOWSlU5jChOaIyrCNqbjLutul0/8HiC6lrqzubQ/4d/PLRO4D8JmAGBe1a5BOBx8tSlK1s1U9veTZ4z8YmNiNkHdjdxMob5WqNO99GP2Q6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=546TEVurM+5oi26qqHa3jeU95ILQ4x+zyAts+p9xBDg=;
 b=n1lN+jPvfEQ4iXM+x1JS6Sgl7PP3PlD7k9kx8iY/nzoMrtf7/l5xppEVDWPCYZioLXZXCgpvPSS0G3UFdnMaVDJ9+D6829ucoaiGHWDAZaQ4x6NrH0zVXPClMQMxA6EEZbL4encUVJfw4S2+BDKvw+jTluCKX0ONUY3CioQSLX49Wuw1oRoSLezO0giZ8+JGcvP9Y5fSFvT8d3k9z9Tipj/ap8Yly11lryOabFHj/P02ghplSc+c99SFQoeRRU/zhmj+e3MtxdEMcsZLsPNRfj7UblrwApTaZjG8dJpGDiMYPxvjTQH05zLsr1d16phxYtnTyRSnWHROV/XGRzR0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=546TEVurM+5oi26qqHa3jeU95ILQ4x+zyAts+p9xBDg=;
 b=aXmp/rFE124GVBmOHihUQbJqT+DJHo3txqa1Y/xQCrR8ShPz5JFTub1Le+lZ0/sbwodtZMN5P2Bj8zOD4/Po9Iy+DDL4gcXc3PqfGQti+5EEuijifKOZvU4xbrz7WqJq2fMqMiQttoCVY8OT3uk0NFckwlVmbSIdOO/cQcO/5gc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6617.namprd10.prod.outlook.com (2603:10b6:806:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 10:38:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:38:04 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, boris@bur.io
Subject: [PATCH v2 0/4] fstests: btrfs pending misc fixes
Date: Thu, 14 Mar 2024 16:07:36 +0530
Message-ID: <cover.1710411934.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d63fefb-0bb4-45fb-8dcd-08dc4412d46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0rt0mtkI0X3Z9jYA3BxP7dtltd3RzQcvgQ8zUFhR8KDhhOoDsWaiK3eEI8QV9rMmj97UigqQ96t3VExKingMsWCfYfrQQ3ajueJHfMR/dZc35pqawynJP0bDJ91degm4pgzH1VKvsYLniWHPxIxAPqshtk3LXX6KkYkpSlJHLvkdEZJiq51UiZ9WYCjfHR9XsKjL/eWz7Fy7701jX8DQKnLHQmA1Zyud+3ou1ccXmO7MRx2Dz6oKGdlPWc9xEXHqtboNtqYTrAig22/boo1n07Nt6zEEJdlq0xidpUyoZMXIjvj+gKmFsJ6FI5L2zoiVPCxPNPbAZRJgIk1FpMYJoR9xstE1CZVywCDM4Rc3QQ80FLLPvOrWiqZqcj+HoiGihCdKuEgWw3u9zQYWMuU55/uqCNpzN6pQ1D5YAeSjvnZCKBxiee+Y3uzdMp1MMZ56GCmY08nIfUOQKdJ3/0lJLXohqhXCE8nKeSb4CqWlst3iHhxHXcFidgmUTOxx5I6KuHkKqai2xHfFitt9UWYl1TBzV0526Fo2efn5nB7SKN62/v2uzA5XrQOAtyAtHcgugASuyMjyCcexj1VMi2jEr4VjN/umoPYZ5yQKYjElrrVGdO7saxZpZxUodcJLrH9xLq1/XnsGI7OgjFOoBnNDCI5b9I51Nn0MCdmdmDXWFUo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q+8VDTmBF+vc54sbutb4ifCMQm8q+lVmFsB/FngCheci0zPKrpYknoern0uc?=
 =?us-ascii?Q?+JCY2GM3imOv0VYpcaCQ0tJp80YW3+0gpK/rEjkvxo33YcnQuqv/HxILxsvD?=
 =?us-ascii?Q?KJ9R66rl9IZiVPeOdyNR8VGfhrtumiEsDBjGjMlozhfWUJbl+HpWFKTJvWHE?=
 =?us-ascii?Q?oU+BJfsH4ofpne8Pm3r/KcF0bsHPw0ECcU17FKLw1lzsRjXZIfXRY5c3U21u?=
 =?us-ascii?Q?yDIi/Mps2Zyt0RsXLTo03wkXkfh9INVHWagU0/Ww8CPUoYn9JpX7ZLyFAMzC?=
 =?us-ascii?Q?fUhhc/aOzx0K5ehNP+B0R6Fuc2BiFD3QbpsSEFjkNr0y5XHQl1ggJQ+NPGiL?=
 =?us-ascii?Q?oISmLybyeMNIvMp9TpPeHkwRk3GZBNueoO7xvQwUHOQKfEqJd1eHV9+vheKR?=
 =?us-ascii?Q?zc9AxZoviuxiN5q1T6DbNFG/AGjxD/jkOSKRdGwQiAoCX9aO2tBk0UXuAui8?=
 =?us-ascii?Q?5H+TBWa0PP5fcZeQjf6ZSai5V/EZysHLo1YW6L/Rwk0cTV4VPgiAsckEl36O?=
 =?us-ascii?Q?OyNB3dgYKJiFmFvMAW1W8TrY1De2QlO/duHPhMeuhlbq3/tQH03iRxduQbCn?=
 =?us-ascii?Q?/yw9sqQYiQll5APZTEepj+AV1GQvSL9kLP15ktEHECpWTSF1km8KCt5sotpr?=
 =?us-ascii?Q?F4ZS7buUQLkorrdxcgG6mtCuevtAI0SXF1OYhQTidkQ94KlsHZA5/kOjzIXB?=
 =?us-ascii?Q?Vz9Wt68Uqne58RYqfIJFaPLiqvM1Y3lwxciicWw/Zlms6BJsrPWotZD4vwS7?=
 =?us-ascii?Q?pCD4WeNyXYBxGdXY3Sg5AV6CMNt2M7Cq4CSV9TGnJzQEth6HUKurgvFDiabG?=
 =?us-ascii?Q?i2tY1BfmA7oEVCnL/Q2D5kecjXYaIgkzrHXi3RNGG0lqxNyxMMsCT+EY65pF?=
 =?us-ascii?Q?sBGI5BJtcCWoXTWybrAsGsI3w1Rcftpr4ldHXw3UnMHQ6yfnjLldiMZXunXt?=
 =?us-ascii?Q?UW0o6vr/eE4OzwGy3XWPScU70Fj4LlSclfg5H49ngL+60y2DPjffAc9vTPXe?=
 =?us-ascii?Q?WrReO+C6tVPlIfrCFH7bmYNkSyCE3ye8QTdT/p36qP8pjkzTFM7N2rydq/OE?=
 =?us-ascii?Q?b2eW3AwKoZJb+FI44JQwLptUIzFcrDD84xEtuc/DieO7vhFX80hVuwqOqbIx?=
 =?us-ascii?Q?8+qSWM7IPAdrRYNuf34kGXIfnn0gY5BZazaIB8n/bKVx10dM5Gqqpres58Jo?=
 =?us-ascii?Q?iUJ88D/ypRrYoJIhx1qenRyIAxxMkGuJIJFEnhPxFv4nU43n+PDqmlc8WYYN?=
 =?us-ascii?Q?BT93hlMyvZovZFOksCe3RJcihMp16Wyh2Pt8xd2YXmzYJvxHLpcyV+u0ZuXe?=
 =?us-ascii?Q?xTDg+m4i8Bi0hRHbJtRVEVTUlKOw/gqvryjsWVFZ/5ZkoIVQnRxoP6xoHlmz?=
 =?us-ascii?Q?7LQ7V1GQKOUju3lBY5sSRhRARUlsEscgzv8V4uM3xlw6lNjrJx1HMqhEKPNA?=
 =?us-ascii?Q?eKN0Lq7fr0fvIu28pp9TU4L6+PSOUDEIljqsGJW/HqEzww9P87rgOr96SzX3?=
 =?us-ascii?Q?K8M56SZM5OLHHTdMHJpsUkkctSQnq9BmK96/CD4M9t5m7TsEYWrSqqgHNRNL?=
 =?us-ascii?Q?tBYyXxdjErrIoJH4oU7fayfUzMON0384bNAU1uYE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o+i6DqIYDz4rOZ0MKwEZ2+6SfuNNyFQ6cwuSME8nPrj6YL4LW6Yrp1Hblniu/e/XcSIEJDvi1eHmG+hcskFcEhw3/bhBbbGHeoe+3blQTjESm2ZvQa6Xv6MZjBIm9p73FTFx1iJtruLm/vFG7gqU2D3AetSB39Ieo7zSwJJB2bEEMadQBxOt/3tzZyz1AL+ua/DlE2FTch1Xd75dDx57xFb65FHVNhnacUqIjAcPq7cV0Wi0VyDD0iQwaNL1fe3qpHKcUlpjSGDvpRW9FIyquNDXY0OfoQBDMX8qZhkVhHiNN94h4qzBNsOZp80dsyAF2t1hqvh170/9uOyDZ4miuQn0D3726UOMTtnQd4+PLNyYGq9nq0nSikImbinVpw8Mg9mjIOlOHHGIYaQcP48byLTQi/OT+jl3rBYcIOsZkjTR0rIuZv+pWYVe2rYKYwdpRyK7HXulq8jD0cquo53gor7iII3Iv0egWmQahMt+4CSQNU60f5BYdl3TpqvkjR2LcPGsknJxzt0ZJZHxfBmdsatDtp66YJTd2ZeA+WcAYoKDmxkPq5z6i1aUYxcKRJDqYvwKkk/LIlpH1nPTiMVY69pooOxo238+BmH8ApWHTX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d63fefb-0bb4-45fb-8dcd-08dc4412d46e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 10:38:04.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSdSX391HZdRakUqVn4XBCTPLNms1jRkeTMsRY3HBAL+lwTwmaZBV0Uygp5xUZJn5W3C5KMpYE2nJgxHuF6XeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_08,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=986 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140075
X-Proofpoint-ORIG-GUID: IcEytW2RazLRjEBlcVfwpQDLipc5NXBd
X-Proofpoint-GUID: IcEytW2RazLRjEBlcVfwpQDLipc5NXBd

v2:
Patches 1/4 and 2/4 are new, not found in v1. Patches 3/4 and 4/4 were
sent before and now use a helper in 1/4, thus v2 and bundled together.

Adds _require_btrfs_send_version and uses it in the patchset that came
from Boris. Also, sending out patch 2/4 for Boris which isn't found in
the ML, but picked up from the btrfs fstests repo.

These are in the queue for next pr.

Anand Jain (1):
  common/btrfs: introduce _require_btrfs_send_version

Boris Burkov (3):
  btrfs/320: skip -O squota runs
  btrfs/277: specify protocol version 3 for verity send
  btrfs/316: use rescan wrapper

 common/btrfs    | 10 ++++++----
 tests/btrfs/277 |  3 ++-
 tests/btrfs/281 |  2 +-
 tests/btrfs/284 |  2 +-
 tests/btrfs/316 |  3 ++-
 tests/btrfs/320 |  6 ++++--
 6 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.39.3


