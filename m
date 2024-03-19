Return-Path: <linux-btrfs+bounces-3408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43B88000F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965651F229B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78953651B1;
	Tue, 19 Mar 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BUCDvJxS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ua6GsXWL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2D54FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860262; cv=fail; b=q3GvVB4PZQFRTLRgOYkTGKPaP58tKsI5fnKwjnHYjegm8ztkZKiyGDqmya/80w+mO1h46UGxMmqEpZaJO6U/bGxpnkN+ygAexZpa6hoRryl3y4tXSMA16XwgxditkAjLfOFiQNvs2FlpM0Q1Qf2dMiJkdKoKYGtpQ4zTUZX3N6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860262; c=relaxed/simple;
	bh=BYGWqmbUulyTpR/w40aHE/zGKVCB3vlE8NyUmQipN/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIU/OAB7pDkggW32naylvf51BniY+kDGuDMQE04jxeBkmglJ1wAe/77lu98FjpsmidzlkW9gqN//y7rS9Qb6x3QQk44X6exNPVX4SvduHOozM6L3TZXAEALHHhbF05pUlbHob2fLg47lEkaGASNtVBq4PMFHwU5XI20d8VzkKBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BUCDvJxS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ua6GsXWL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHTid010230
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=gGYG3Dv1LBUBfjJCNwH++s8C2cVAw63CavHug47m6rE=;
 b=BUCDvJxS9BFsFvEp8/vKlI1sVlsldSMWyZicc6DSV41aKJjFT0lsAZ2rkIhtOptzd29x
 kMjHronQLacDeqGlSoajY5YoUYp8ZXSfbVAvBuUWCcEnvlkjQWatpVLrTqmHwjKWpfvB
 jLkDhZM+8Mx8zviZEJZjSRPRtuVCe29rFTfI9M1P7KlnDRCDzYfxuQlj/vJHQIwtdKcg
 n/MR6+sL4NoL0R2Q0AYCy3NGBjMJWCiu65AYqClgQQqkZeGu2XQFkBR6/q/uHfVCvrjH
 xZI2RO17uKOmukPMETvnlkuugoyLF1ZOnQ+8TD0bXaVfDT45gCjmNEPCs/iVFzFKQrPI BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu5kwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEfO6i007398
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cnkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE6NKzYEPmBWzcV9x/zVD0Mo0d2PrdOCEifR87Qa4zhpaP8vX4hJ5Ye9i+cvSFWAEyEhO31cjAZwq0GxndtqvpLWZq2Cm8ne7/ALHKyo0xpToO+aFmFP/XMV1H+W0CqP9XdKUm2noO1RyikxUmAq4rkPsWdpW/NAfWHeW0SwUTlVa8+BNV91Y8M8BLvvGKVhE7Lc/u6rd7juyrLI2C//6L1fCpCo3Q4AKmKLwEBS3OISkKt4NUGc9IHvqJ4F+a9wQEljHTjwMyD5N0cc2Qd068ZfdIjkMDZogz72MmyZxDLH/vx+Y3pxhkxGKbNxyiuBC+44iwyhOD5PFaw/urekbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGYG3Dv1LBUBfjJCNwH++s8C2cVAw63CavHug47m6rE=;
 b=gZweKH1TM4B12sEwAcP8mfJQUqoJbYvjGSOum04MDEoJ5eMRTAmzSce0EMmdDTv86dWmfL/9x10mRADvwrzbePJt5nJRIrKArQmfJPjk8YIqh99Ek9O91xH0xPLzHKEUb8V+0onyzyvsY3RyxG2JfD8j+/pTqkGy0etSk7w+V1gyUtN8jafqyBN8PiF7BarJWYwF51//ul+pFGokDPMuPvXBVDdVTWMBIy0YppkTRvf94/6HpfTA8iCcy7GFlnMRKjiYtuNpP4BQ3Q9D7KpFcJNlQZJmOeiHXIt1E3ht7WFgS9aVCDZ4gU+3GMZNCsXwh5rz/5R9F1uc9ZJgxnMsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGYG3Dv1LBUBfjJCNwH++s8C2cVAw63CavHug47m6rE=;
 b=Ua6GsXWLwDq+/sP8uMcygaHvOru3nsDp/UoDp8Gw/IFLD9vaaCjxSkB8iANnq5+wiWHt1MtgTyilX5e/6EAvfdN5RHZ+DAOW5t8NxSpsx5mGRXU5YdrquwHHZM2UNrK/DkIHR8ZOj6/keBFrt21rc1jhuwLzzTAK4+7/D7mw2+A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 19 Mar
 2024 14:57:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 13/29] btrfs: __btrfs_wait_marked_extents rename werr to ret err to ret2
Date: Tue, 19 Mar 2024 20:25:21 +0530
Message-ID: <2e8fef09405de09488a3dde439d213dee33e117e.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jGi+Mm/Vl1PO7HKwupnb/FxiyZnUF994g8ul7IxO4KHYAQM1OXMTtg6BZ8JFyYixsO4Z2DkhQ5/dE9fq6GowFtlBer/NmbhPtjfA7Xxf6AiJgN+vgrIEEzbnj49Qv54nasT/zzJhp2xNf87YiUxniE/7S63po4rk4swwKqrsV0abglCm+AOIzpADpZO/EUViVKFWHq0KONK0vogSQczdy604BYC5uHnjvW50Gtu/6e3hlHF4/LJ6x8Qijnzl1fdqvfvXp7ZPO5FT2x29lazUGW4hk+MidyhL9lWEZ81WLoNq8XNJAXVGk2d5eIjX4c1ohsMQMJGNEEudpvLLUDyw9M+Q2JFcsgOkUN+8ZgnblMe/+FD9hl3y15O7HjVG5kV0h9tHZwMO2YM/fqjvETw5+x5ElKFfZl137Pn8i3iuUd228ZyWoPjattOQsQSsSqqPe2glnUhlYbalqqGcoD92U7fjr976THY4kXTiBsQ09GFVeMcc9THR3wfYtZWla16LKRjlXZgAch+VOE9Dhe7NOmzIhVlIrGx2LGJ8wgHqINQPoUv1NHJuPMGsYE5hcRyUEnGvz1TYVW+VKKO0t7YaLYFu7GugGLVP3XqF1Y2jG/crqWTW/gPszNqW6UXt/cCcL+JDwn0ZwNgTuQ6tm7D9V6wKA3/ro2Cq5fniyzbXI2Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?awlybq1UZfAB841CfjVkG5jAOSmWz3bF49AJXpzQySMyOGv+gNKxu0rn6GLQ?=
 =?us-ascii?Q?tdk2HrXFwQxAfaQoFKG0UStaxHIAYOMHasN4QQM31bryk+R7p+sITm10X5sS?=
 =?us-ascii?Q?y4CtQUL3o6fti3xOs4k19gZ5tsZiUDk6vnx+8fz3reunbbnXXwnFR4VRq0V3?=
 =?us-ascii?Q?VIXnMvnozh/oPNmETkSeU7zQim/euFmRjfzR5DEIkw03vcHy6EGPRwCPmrfj?=
 =?us-ascii?Q?q9p1z1L9+egTubrzHQ5TywsBEEagjPxNGSgJXXnjnd4OIk4mF9QGfkirS0ES?=
 =?us-ascii?Q?TdK9Wif0/H1BfJOY52YpDuS7IIwUbrxyWL+x5DCZ6/EewZwEJOdUM0OQKNwt?=
 =?us-ascii?Q?eWni1PVliNnVO1q7XMy002kU2UArRr2RRy2Ud+j/xld1d+oMVAZ7FYrXHK6g?=
 =?us-ascii?Q?lpXrFLDQNLuLoeA69+cEB62oJEr2IivBzXq2lQWU/ioZj7VrNdHvN15er7N0?=
 =?us-ascii?Q?gNwLqpDUh8qWWEibXA+58Wm5U9o9BcXH/S+HtQ0EHmtbFJlrVsQQo+QEsXyG?=
 =?us-ascii?Q?3PnQVJlPRzkQePR6VSu2Ejv140zGd3LGzFDHZL9RJ+/LNpArcq093JJNvHk3?=
 =?us-ascii?Q?Yl1DJ3X6BE5Ize2SiSxG+pRvtoyDsNc/vlV4RSsvxhFMKJD0ZIUmYcvRXugi?=
 =?us-ascii?Q?vc4nYrESsJvglc4jJdwUqjt/vBaKtlB+UYzm+iiPiu/XRxgAiHZGEII35kwn?=
 =?us-ascii?Q?SCyopIy1/t2zSNYswNdM7baolwfPnM5SX++DH5RKi21XeBLSpfc01j+yjN/n?=
 =?us-ascii?Q?iUel771bxeAYZWA80LwH58jEK2GbVV1I12mau3dX225OtghThJK61wR4pDe3?=
 =?us-ascii?Q?YlWu1iR+Gx6KvmBKDctGBF5vZAnYXF7eBuC033KYvNqXOlN9I6A1xzgMlIpa?=
 =?us-ascii?Q?Ih9ECN4sbort86YDeGvLIZWs5ONl8xDs8Y49hjOKBGc6K/ou1bMYET0QjQm5?=
 =?us-ascii?Q?zAdtOTszwOvE4vyOdN8KdhEjCmycHEXwFLTPZp6yQh1vQh6t0puigN/Z7XTu?=
 =?us-ascii?Q?t5OAamDvnOIeELvP9Xfo40z1BsdQd0RCPXYhnG8rR9eCB0rwuiOKUsVm+UdG?=
 =?us-ascii?Q?QQI7oROIfkOY8IffoiOEoQXeAMQ1qUN02u67oLNnWAyNlPcKvYBE4zTMVH9v?=
 =?us-ascii?Q?eccFWzurwvuuAzRTbczx+WK1jRxSJwUBPgqk+TdYTjYIQpjIkQC89qEErROt?=
 =?us-ascii?Q?gjVaVucZOZIn1L6TQMZTUVh/8/jXY8Qcx7m8bi49SXcuh/Yvr8mM7IrIKFUt?=
 =?us-ascii?Q?SdIl9NbxtvOhbsrlw+YcEb5PKKC5uYHGd5J6Z1u/FjU3zCy4LNpZQgWsHEVV?=
 =?us-ascii?Q?EhKjlbsRcMo1SKkiz7SSVVW5P/InZBxLVTEuB2cml3yC3JghpDBCRyoQZoIA?=
 =?us-ascii?Q?vYkFYJrc2tXCNOY3Ix5TZXgxithSvTeXxkRGO16eli8rtm8QlSsb9zIxetwH?=
 =?us-ascii?Q?C6GvRr4O9C5u3Vw+VD/m05ZSLqFLHFIwrMw3xk1haOKmJgPthV7i3cO0APss?=
 =?us-ascii?Q?79/Q0cslhQuAVWt90logpBU6HtuPn512Ibu5z5jMPxGIKu+tOCqsIi/turpd?=
 =?us-ascii?Q?a8j+41IDdyjoHEWy1grS8fXDxfV/w1tJBtPKNIZYRuiESr2FCDgSP3oYu5q9?=
 =?us-ascii?Q?kVxeQqhObny+p/ymXWYpkh2xfacQrtJbubvqGHDQaZ0v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BxvnLfzts4X8k7aeCvOo8ZCsgUiScBE2g4Z4pe9QbkYVcP0tNi7Zxypzfcq2NEUftQpShhH8/Pb9p8VlXKUIsT60ZHr53wy1Y4XXXKCB3VhKq/0cuOqhAELsxlVFjHcvE7JQGlyGqJvbPQjk37Jidtw1IjrCgB72zCleXctMbALWgiIpJ4IUF+xHe4M4i9bTRjgxBYyRJu8KGgwNRehRcqFehD+FNY/o/yQqYUSp19dJ0sbd/K41JLt1i0eILMc20QsB+rAGFvLCG466WA/2LTfqTWHO+33SyFYvyTtEmc6fIOtN3B539VpxCLSywpFv6OXnRJhCOtIsEKzM2wF02hR5IghrjG0o6jGz4B+E78QodzjCGsrR1l4X4IbaKOhqLdtSCgGC8qq0b75TdciFb7CcPpUDNZhEPVNCD5CA4VtYN7M8UA0s1LB7/SnZYxCmt/ZPOOOm1KGRG3R+kr7/H5n2awwWerbfsFPZxkGKNGO1aRzCyMwHXOtk3FLRKD61IKTOxpeidGtzIZZJ8QVFEPGryxNl2811qzNSC0CzaC21LJmnBe6B8PZe7qylVzdoAJb5dgZktq8OxQsS7APU+3bRBRccOQurKQGUdn3S5F8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de416ec-be05-4cdd-0813-08dc4824e910
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:34.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/olQBPxrJvhxF88wxThjZ5nE1hxRycbDZqvXQppVV2X8ZvxZyEPVosvjDLN2XLR9nnwbEQrf72J7HRKCcQ+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-GUID: 57WOK7Zilye41eKS_uG9YIJ238Ji11_j
X-Proofpoint-ORIG-GUID: 57WOK7Zilye41eKS_uG9YIJ238Ji11_j

Rename the function's local variable werr to ret, and err to ret2.
Also, align these two variable declarations with the other declarations in
the function for better function space alignment.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/transaction.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 167893457b58..f344f97a6035 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1173,12 +1173,12 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 				       struct extent_io_tree *dirty_pages)
 {
-	int err = 0;
-	int werr = 0;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct extent_state *cached_state = NULL;
 	u64 start = 0;
 	u64 end;
+	int ret = 0;
+	int ret2 = 0;
 
 	while (find_first_extent_bit(dirty_pages, start, &start, &end,
 				     EXTENT_NEED_WAIT, &cached_state)) {
@@ -1190,22 +1190,22 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 		 * concurrently - we do it only at transaction commit time when
 		 * it's safe to do it (through extent_io_tree_release()).
 		 */
-		err = clear_extent_bit(dirty_pages, start, end,
-				       EXTENT_NEED_WAIT, &cached_state);
-		if (err == -ENOMEM)
-			err = 0;
-		if (!err)
-			err = filemap_fdatawait_range(mapping, start, end);
-		if (err)
-			werr = err;
+		ret2 = clear_extent_bit(dirty_pages, start, end,
+					EXTENT_NEED_WAIT, &cached_state);
+		if (ret2 == -ENOMEM)
+			ret2 = 0;
+		if (!ret2)
+			ret2 = filemap_fdatawait_range(mapping, start, end);
+		if (ret2)
+			ret = ret2;
 		free_extent_state(cached_state);
 		cached_state = NULL;
 		cond_resched();
 		start = end + 1;
 	}
-	if (err)
-		werr = err;
-	return werr;
+	if (ret2)
+		ret = ret2;
+	return ret;
 }
 
 static int btrfs_wait_extents(struct btrfs_fs_info *fs_info,
-- 
2.38.1


