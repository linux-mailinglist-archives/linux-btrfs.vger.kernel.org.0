Return-Path: <linux-btrfs+bounces-3145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF487717B
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 14:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D20281CBC
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0D4085C;
	Sat,  9 Mar 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NpdiRyB9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TY1/E3e2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD716FF52
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Mar 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991950; cv=fail; b=CUYphFNQt4dpDO2se/dQtzEAmvUcRfU8tEq+oCJV+Bgc98aulgiEDhv9pCvqBLxOw+YTI5UoNJFckQKu3q46gSyW2ggnSl8d5mO0vMoqrKBeX95EzgdLy0dmb+ksN0PU1lHBZ86sNL+vSNG7zy85vwaAS2e9v+b7E+9ZOtE1Cmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991950; c=relaxed/simple;
	bh=Y617TMBCIaxQRB9TYF7x0/fukXHrF+WAr4vjtfO6X/E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m6zX03gZLLIXdyrpHzv6h08rEfCcxZb8w8BNKijs2UHTIxEYNuDMGCtD5vVR45FUQD7atT8Pwvi2xDyRHziF3QN4v8xN4yj73Jgvde/pwMrtTp9yhsWTo76mr2IUUGjeBHTGr7PhozNMU2Iga+RWB2gOakXVUaB4C3q1UOtf3ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NpdiRyB9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TY1/E3e2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 429BQv9h003453
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1h+PdS+fD7Do7mwiz4LW3cYYkOcFCwQ45emxBf5Lae0=;
 b=NpdiRyB9Nr2OaU1Yuv8V35ae+HyYVLQ+vAYZS002+De7Ya13Wackr75SB4lNdpZkksgn
 o5LCbk3mW77sF2KF81Apqh4rrN8Th9Wq1COyozPlmQn+vSApfmYnD0xr6vN+6/l69DpS
 E+vPqdQR+r2YYX0rZOVdlTIIRCKNYEVUe2ybdfQGvKsDsjKAtz1HxLwSZAO1K9tL42FZ
 srREhkR8g7FeRCiF03uaKwIUj7F1RiEmkQGPiiICHl0Hz1d6DSqeejSj7BJ4uXW5gHvr
 YqSo5xU24P2Xey5Sh14GMPjIMr97IZfgG18552TFTyrIU0/5DuafPLDftl1838NrPKyx cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbghuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:45:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 429AAggO004705
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:45:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre743qe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:45:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOiRQ4wXOeo86V4YAs4cx2m1EO+LvXpO/Kkqg7+c9j8dbg1RjLoolZ19ahMFNTzatlqZfMy022yMGPTlmCk+gt0rtIuuxzUcxkJH2QIiqQj3cQIl+oDOW7XpJDAlWrqyC3zsiOgkyz3PlU7SaXSxNy89C2hRjGUtRpdeBhN+1ZN9lpRWSyzMW/ilUwAljWZfG+4ghbGgiFTn/BTRgtWeG0E0ZT66j0FrWM4bdrU/lT17BqI00kVO/OlpYq2xxdQNHbDtGB7foihqIurtXJWWW2nxUNbN94yYJ3WyEVuQg04VEZcKFD/7ZAzY1KXFIOAqmZdlToMncDnkVFMGg5Pj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h+PdS+fD7Do7mwiz4LW3cYYkOcFCwQ45emxBf5Lae0=;
 b=dTPgEY75BRDxziiUw9AVf0Y1Z9YEa+HwQP4vCKcU/a8UEPkVLvKxaIAJFWWJrrt8ZB0rIn5yir+TYf/9Q8JZ73/+VxSKu3jPFSFZhuQZxWPHsjsv1LqSnwtNflQXJTD9t2bBiyfoyg6/JZK0F2lb6Fg4XIseYY/CZpiHVK1JhsBYGYle6XcetAuuEETOsOX78uxnQUWL6f+Xh+cX9ZPscclfmIpCLNuMRcezMXHHkiGQC5Pfj3MEXiDGR0NsJoFEIB/Z7oU2PebtEPe3FFdllD/GYbyabwK4Jz0Q+K2t9GKW065O4NRbFfglQcd+jPu8KzUPMmUgs9bWTDFsc8eD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h+PdS+fD7Do7mwiz4LW3cYYkOcFCwQ45emxBf5Lae0=;
 b=TY1/E3e28MmspfNum4t3L6RcMELU5Y+knT9JUprYTk5W4UIz1jKSm25JmngcxLgZskd9Vpd1vQdkoe5x7ECTYG18juW949uYfg3lhFjXB+ndzsVYnC//RbNcoqOywcntgy48KJ8GNE1Q+FERjkaDz0Hjxeah5WVgmqV8lZ1M3U4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7509.namprd10.prod.outlook.com (2603:10b6:8:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 13:45:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 13:45:44 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/4] btrfs: enhanced logic for stray single device
Date: Sat,  9 Mar 2024 19:14:27 +0530
Message-ID: <cover.1709991203.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 757ba897-a369-4d95-3d98-08dc403f37b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	T1diN+l9LOGNcYt5aDiSaKYRNOTV3fYgYBVT9CQSnOr8PGccMRfPKcEMCiLp+6EubTt6lcCtHz64JdMrtAEBfnLY6TdCc1HyrW7o8QS9LVDxRNxaDY77ALE/vFiTo4RD4gb3ksSpIIZC4n/zPM2q0Y1gIqx/a33/51W2/pA4jV+2HY03FjAXKZBgGuVq8zNgfhNkvEta9EwLN2XAAoVnIBBA/ZvL58qejRYXaOPyIi5EBQoP3uJLN8sBmgYRpVUETR1+TLsRjmwAvk5KaTgSpJu0xPfAwx8Ee8r22ljNg7emcrUgkAxlcLRjJyd9FOox/2MXFn0jXGFUxogfOAMH7xeTJgzwHHOcO2V8bmSVgKAJf2kQw+Y0hDsaJF8Ra6zZtjtdfonTpgZnJd+Bix/WbfStYPNlGrfGf/pQ/tryFBw3EU8p4e4CYN0cnTdlUMsuqCMJ4zUWcAPOaGaPr3nET/BswAouHaaJqAnCg5o/+7NV/r5QeNRswzDe2sicYjUObVrtoRoCr0YTTJsx8gEZZcI902T6fiv1/zlGpo07aGxPWF6bJRohPxVP8r8TK3OLIqhIPqKpwz/Bp5t79hDLxrKBBsNMvDkObkvORvxxv07rWGAMAaYL8+JmWoFvr/ZDD479jJ5YNEvfEd8OubKkkaAiKOxak6u3k0FE9KWCdVc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TSxok7MtV/gmvb7ghR2zkRnUFE0D/xT6XiQFUjDSCxkO+AXBBZJScbNxscj5?=
 =?us-ascii?Q?HeYywzypS400vfKRaSUOApdsWbSaaLs2RHQilpIwK05bYVXjAyoVxGQ4o71u?=
 =?us-ascii?Q?T0lV+sEQgHoLrNYpyRP+7i24lIHqOVjb697q1WyCEAHSw1apoZGmYKoAXcao?=
 =?us-ascii?Q?Cum6mg7Vn9Jd3m6eGhFvQ1cfJKQyxeQ3ZJKbS09/VN8LjJEZom7O3w5WVLt3?=
 =?us-ascii?Q?S+IyFFz30kk7CCtEO1IhRBuaH9+3O73Xj9y/jxjTNzXp3ASpbtdHgugdMlL1?=
 =?us-ascii?Q?lfI8yWoYfedZbOsVphJ3sF+JL1skwZrkuqrBm5mEQFV3r7H8Xj+VIEt+qd+X?=
 =?us-ascii?Q?qlqXjuFIfQ/O00iXk73RUoGMVMhyfoxjxXaEAFy1kXaOfPWtvNj+XjBawwNC?=
 =?us-ascii?Q?u9Yv4USTDHBrsKiJhvVLFLbzOIQ4AX3oBgGvP0V0d4uPFC52Z7ZsILyqVSwG?=
 =?us-ascii?Q?F2kt7wtKxLdz0Vu9rNHLJh7aqRVPfTWX35bzjM8VlyJTf6a4Yncl7IikiLIb?=
 =?us-ascii?Q?2LTT6CzxhnqE/jfikO20zdbaJ8H2ch25ir9y+x+9jKrXOCxO6ydRlOhOzeiF?=
 =?us-ascii?Q?f7g4EspO94EpPYywMwaty92rdYhHc9UdfV9MbJ/a6DaSJ1veQNLy9suZoJ0g?=
 =?us-ascii?Q?/oAHbtHDKHVu+tW891W89H2t/Mf0SSBJGwY51/sh/X9nlA+Nt2UarwOJDgnR?=
 =?us-ascii?Q?lrMMx1ho9cA4uElrpGVhTPtpp2yu3RBdNGUl4AqvxqXa6usmiKxNej1QQrgq?=
 =?us-ascii?Q?wSMFcTyjyQZw6wDgjScUIkNDhtjLRnggUXS/tTSYkoteEhOuMjh++5MgSgRN?=
 =?us-ascii?Q?T32z+9QMa80dM/HqpxSmbjJ3qtMEXZgDP/21OGKey5m3+4TNno1KW2ukc8+7?=
 =?us-ascii?Q?7AI66xn7Q+uwFLwpy53cL87rbL56EBkYhXLRZ+A2wb8qU9td8U3lm04bWwwn?=
 =?us-ascii?Q?sz2jB/wzVyErn/ABx96vQcbsXLineKHhkLEAU34i9lrbukAIPhSLNsxdAKyk?=
 =?us-ascii?Q?BsXDpRNsorbl/LpDPawwqxMzJYpyDmlzf/7hIDvzojRX/SfjMzNnxvGZfGvm?=
 =?us-ascii?Q?ApU9tHnaN9EM0tiGD3JG672dB+om1x946b5pj7pBhJjh5ThrN5RqVcXnFkAL?=
 =?us-ascii?Q?4hfFb4G3nn3Hf36GjQZvlXPrYKi050xdJVrmWiAKsvpCTjJYUPAWwLNASuvj?=
 =?us-ascii?Q?+nJdf/IFG/sDIeyWjfXJfiBaXaAcAcKtvSNT8kBSHtE3zSCONCaL0CHntz3t?=
 =?us-ascii?Q?NdnSltgNc/z3P010gHk9OfaKGIa7/koI/nexkY0VC9RWMcPTIUPde26xPImU?=
 =?us-ascii?Q?hPYlMtonrfH55YYWslw2ykSsEOBXHrTynIrWJIDw4s6rBtCZ5EVtHIVhXq8z?=
 =?us-ascii?Q?nJ+VfVDUvqRn80u+QAcb8CXlKG0raaEtYFK83TG0eGUc059pDV5mAWjJw8E0?=
 =?us-ascii?Q?va62q0DvVpEQp9xY+Qo/t2c/Hh6fQ+ib4y7JqQ8YZ49TqK4y256oMgAeWShZ?=
 =?us-ascii?Q?JGOy9YhZLgU7U6Yxtgi9p45SuXsurmcT+TN5jE70doRPWpXmXxB6j/CZS6H1?=
 =?us-ascii?Q?iU7cA4xnVIBWDJppt58ULqDCYIBolZQy5Pkry3IEbA2hasc+DAQM2jUigCli?=
 =?us-ascii?Q?9b5pQM1qmojEERP7v9u5GHRFAc6Qc+l15PvZxV2CLeae?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RyQ0saEzkHtMQ63E17y5Wa7CBe65XB4cLW4i5S9pEIogkalEU4u8HnDKfoGTMv/lfLnf+Za7HWRENoV+IfJwfBZDKEd9JOHS/wBK+mdP52094dYS6f7bZYG05qnwHHJlV4kl0tx8iG24xHxgH20iY0PIXNkVxPV0m7WQRO29CWY9cBUvU0/9xLsiJxLMUtGn1jcpdXtSu8MO4kLL2jZQCuuOg/MqHNwvm0DhTrUJ5h2exsolyGopLVaeVHPw1+1zGjeLRMH6VJT5FGtt51u9Y+YHx13r4G6IC9iSZ77U6LWMj8WM1xGgmLn81HaAR80nlksFjA2vLRMJ63aVNgW4NTtLS1rRHQAUBybEKNLKvTqFHjgiFjZ6L6l2RlgJCDPmq2xuQdHQIEAFRGS4V3NyDVOxusMGa1f7dAJFBHOaq7uYXDzaFK3H0TNwdOh3uvsnA+auybGhHBheV3rMKo59oKRIZVe7An5XBf0UaHn3e+D4L4+9XBzz+BpwSh3FhA3vQAZMB4wsIm0VhY4q2uYBQZF7sM4yS4ASE+tRkPce83bW8mBao/4OXyvFAZgU3thfynS7f4of0WWRrhWtMLxbnICMT/ESWglfn7K/hRUARvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757ba897-a369-4d95-3d98-08dc403f37b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 13:45:44.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vGW/XxJpTavj7i6vtwmyCLYI2yZQRmlcvtFV8IYTu+ZHzo3+c/q1lYUei5MqrPpS84jpbIAElOB6O6W6NqnfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403090112
X-Proofpoint-GUID: KOD-gXZJo8Y9m_AAomV3ZQdQgyegD1WQ
X-Proofpoint-ORIG-GUID: KOD-gXZJo8Y9m_AAomV3ZQdQgyegD1WQ

This patch series comprises two preparatory patches (patches 1 and 3
below), one bug fix (patch 2), and one logic hardening patch (patch 4)
designed to address issues with stray single devices.

The objective is to ensure that single devices are not left lingering in
the device list unless they are properly mounted.

Anand Jain (4):
  btrfs: declare btrfs_free_stale_devices non-static
  btrfs: forget stray device on failed open
  btrfs: refactor btrfs_free_stale_devices to free single stray device
  btrfs: validate device_list at scan for stray free

 fs/btrfs/super.c   |  3 +++
 fs/btrfs/volumes.c | 18 ++++++++++++++----
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.38.1


