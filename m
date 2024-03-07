Return-Path: <linux-btrfs+bounces-3065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC390874F72
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 13:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E69283E77
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A300F12BEA8;
	Thu,  7 Mar 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YUg9ync9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BouQvWS6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A823233;
	Thu,  7 Mar 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815866; cv=fail; b=U0kcV50XU2AA1+ykfOX5wVKUWV8wspKJkWnc+8uX/mAotkEUQ8bzaydnX00fR1m8637Mi55b3t7r10ziEIBctWFGgvJvYHVRLCNw+Zxa0WsWG0KdtuaFZ6WL2SptRcOQbtzZqLWYKrB90tBknQZyNu7lYEoRQhp+vcZo6oLzR5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815866; c=relaxed/simple;
	bh=RpzxUorBvy1lRvuDMVz1anpD+WqKFpIq7XXFq2e4uok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUe2867q+Mucy3aGAEeAVoJjHpuFo3xlHfPNBcYSi5svumhQcH83zwiBzoKho4GX+gLEoff6y1O0TbexJjfao+B6h2QRXq8s5JA6kYOnp6kdhzIWz9fklB+2/k5rD95+YlxOQmxmz6bsWQM48WQyVVVDo4YyLFaClHAWSALFHHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YUg9ync9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BouQvWS6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nTNG019333;
	Thu, 7 Mar 2024 12:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=IEtREtBS5XpPpmUSNVWEvfYh1XCybKJEUIcn/jPaLtI=;
 b=YUg9ync9oRre1rxdMJb46CvqKmfQL5C+mdx7t2EstGKuwGfCSg9CtFtkU+/xsxhViMuG
 qDo6lSSrjzJGFnRjU/qHDOyOUrvQLJd+c0OMlbSsyWTipVGGxys8wfe4/7M9jFuNLouY
 Fz2BRwghul+v9mIbwR4dqddwKbFfUSVS5kktlGiT0zdnfVxbvGVHXj8OMn1TcJu6vz8J
 laWDZralSCSF22vcBubPYCGiSYHOJ/N+SQpydPQIVvO4m/iwdIbXVhTGu7zhTR8Oln1N
 xVxZylnjZMQtmq9dX+UlNJALU4pVsjlJ/hJ8QiKNl1ScPXtOcuTYnaAGt+CAemMzTQAp Yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dm1hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:51:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427CQCcL005147;
	Thu, 7 Mar 2024 12:51:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7ntr3ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAC7yr2Gpn0P+4s07Bq5A1PtuvJcrwoIH5K6/F3KCldwHGWl4y1XCWFRprgDLfdRDFV8NXLTOtGkf4RXv0i7OqxGmoH1h96+grH5Qn8YMjf8CCV7STsuiSmvy7OxVG3DjohIqI4yJAJyCqUGqSHHVKTjUs0/wX6N+vgvDVNf1AtUhb7jV+y5ck3UXq5tyYOOX2+DVDeQMzBcdj0lqXkDVN9Wh2b0YnCnDaBhOeVlMLvOoevAGF1qZmzjxMvgA+0sb+f1LD5W6QGuHBwIppDt/jmhlUuygZABB7bIGlSrCg8TWgQnhHkT6PNN3ADiQRkAMNIqq7edFY4kjUs5JzcxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEtREtBS5XpPpmUSNVWEvfYh1XCybKJEUIcn/jPaLtI=;
 b=Xp90l2ZXEQZqfm/831jvIrcjh7oy8GAGs9O15ARyOow/pdt0e58xVRNEfPVeto0paIKGCfOs1w7VnaXkKJNqIqJXzKGdQrHeScIQDc4YkQW2IALt+QRBsq1FHVcnnactVnUMEpOL3I/8uA358hRXMN6pmggS2W2SIzIVCKEViCo3hFFyyQPYSCKG+lnkYJO5taE2TOMBkY3qvPbVCHNoTp3Gi0vcXxm11lhv6xu0EKRuRfTk7niTMFRXLmY6XKoxXM+1TozwBx5V6an3skH3oXWq+aH4rlcKosOex1wq1FxNfaqJU1tKS5cicDhEy0C2MN0zx7KqP+p0SScd+PNSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEtREtBS5XpPpmUSNVWEvfYh1XCybKJEUIcn/jPaLtI=;
 b=BouQvWS6B2+2Ny2/a182SWxPDcjrAUg21PTtE4IF+VVWyF5F1qADY73qon/IEAbV7mJyWQnVURYUYfpn0ofU54JbzPwzUgY5Iy9sojVGLzROHaJgSL628s8HVOykai7ggc1nPX/iqkc3kXepzvRt97hTOqyW2FIj0jrfDCtILag=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 12:51:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 12:51:01 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: test mount fails on physical device with configured dm volume
Date: Thu,  7 Mar 2024 18:20:24 +0530
Message-ID: <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709806478.git.anand.jain@oracle.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: cbcc7234-c3fd-427a-33a6-08dc3ea53da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R+kKgrUFIqrraXDKkm6D3KanMZgBFHVN2A5DHJUTR6gchnDNQY7VYzq/w8oOTJQa7osYujhkjZwyeHd+J1iXmLN4Xg6Irthxe2MATyTFJRRq4YieX5G5XmStOne2QBJ2eR7ySaZMVRTqa4bzdbUy08vipwtMN6MM4+koXiuZb5vwadCd0W2rXVEAiBAevtzOGqOR7KNDiGgkhj2G87a5pZdMGF7gxYWmN599ZR/ubquXlfhBxKq8eCNI4palkkWSVE5MrYpMmcK6mS9JMuz2RImlnnqDuSDfmrgqSeR6y32f953qqAa+UG2A11D392PGVjZLlxLM3X5r3ywV0DkXAPhru+a41fY40rQsNT3/n82QNEdhT53zNM3vt8bRFJN/w4jAshPHSWLOiSYE20xdZL0qo2sILpB7PmmcR+YkQatwtygKJc27H9KxLqOIJIHFKMHKTRBdSp3KnJ5G++nDvefGyvdLo7YK2jeh/CH/O6BbMWl1y+UJVae/L0YGSssML9lPVVoy6Gw9k3m70s0pItEfWjTKxJt4Q/YULtcHV83mr2LHGFk4cEHthG32IPQVeSHXsweR7b41YgK9A7l1nGZT+eAw8fNsrvgz/4zOV3Z1E58djLeY5efRGSoR2h4L3kxRVRKAiR1R/jXNu9BAvpsxPNAqJFIgyaWKMd24/nc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zmtEXYBAslGuf53X6guzh+R02PNRSXmr9Td2nuoiTqFknIYKf1YULhUoEMgd?=
 =?us-ascii?Q?dPLrt3E8iM2f4+oHC9gruBx0URtWYfAtsTIKMutB8e6yly9gIwy6uTGb1D1W?=
 =?us-ascii?Q?czy/5LXptXcLACVNzfvPlLniY2N7djutKICCNZT02xJwWM61Dsl8RQWoKoPH?=
 =?us-ascii?Q?x5wquF2Zjwc5Dw2zZKc6/nUz3PSqsV6tHujYA5iEK03rQv+O+dvKFl0ssuG4?=
 =?us-ascii?Q?sjtll96owBH37lAjLlGYbTXww5WhJsvCOpCa9H1cABnCK03PsZGARCgSvoP3?=
 =?us-ascii?Q?4R7sAlPaYDIwDh5wlLGYzF9NhlKDD+2SRu8XQIBshwpcSTpc66an5t7aBiSP?=
 =?us-ascii?Q?QNwgy/cb+POz9ENwFaGQAqWw144vUEX+YwzMBvknVFqeAjTDNcwhaDQhkBg1?=
 =?us-ascii?Q?WXTvv6Aw8UYSLHPEDAUwiIUWsl+DawFyLH+GGSBtreT4FwHj1n7FiMTpWsF0?=
 =?us-ascii?Q?VvyaLj3vgIAl+Ld133XkXr9UsTAd9xMJnmJEYO81tN3hrpXEYAh9Zdx0SsQa?=
 =?us-ascii?Q?sg1VVyY5LecpmTiElC1C9Fc57pjW7TPAcgx17SSL6rrS9ywuXr1qBZeqnYj0?=
 =?us-ascii?Q?wjV73ybZo8z/4hOmdPjawjGjFDWtRqGzOiL0d9oxqFyHZcYR8ahCu75XA4ai?=
 =?us-ascii?Q?Icq8tpzH8+MYiGKql3YDNR6brJmSK++MSy/iGEOEnAIzX/+RV2e6NQnrM5XB?=
 =?us-ascii?Q?On1l0jyEokOgmmMA295zjTNpj7a63AbeW0KnNSOOBN/FG1tp02KizYx9yQNz?=
 =?us-ascii?Q?br3Qwa0eGhcuoT8umfKSqwc4OJYZ1ZJ1UR93qcs76itL+2PTHVnVfQWvrY1Z?=
 =?us-ascii?Q?QWPSCR22T5Uj2buEXAm+/2TfAFF5KwDqtCXDztg2X9UGGVZtMNsbgESn/NAZ?=
 =?us-ascii?Q?FT91uY7SSmVASPWy4lU8RrV/K1A7JwHDfzoJc3WAjJ3iOSs2JosAvLX1yXbV?=
 =?us-ascii?Q?Rp+L/jMFG82DiLzT7jjJkJAE9bgGr3TMgppvyIAI3U+mGO9d5Ot0yN84mD4m?=
 =?us-ascii?Q?tK9mMCDowuiNRKLrvmSrdWmKQHwYF4Rp+6Gqpw+5aKf+bmaEdve+iseyGKfz?=
 =?us-ascii?Q?yXIGxab6xK6FM9GUM37Au2HnvTAbGkb4gMfP41AGaWCXZCIsWlweyOY61it+?=
 =?us-ascii?Q?Be/OI6/vIYqEFzO9dp6RLk97kQ7zFXpEKSpTAIvhoBP6KP+RNAwSYoTkot5L?=
 =?us-ascii?Q?djqU4dz9gRfSKtCFpfzFApfnh2QQWSgrokCubJwJ9srIpcN96FSCEMKYZKBE?=
 =?us-ascii?Q?1oSy9j/0+mSjHJaoOqBCN+OrLia3w5+GcIpYinEmwu6Z//U6q7b38E2HyrfM?=
 =?us-ascii?Q?537HgS2NNZUBBFMNqWJ5WZILSsV9daKiNcHVifc5APMdeCFZIq7mZ7Glt2iz?=
 =?us-ascii?Q?6D/bWXjj2sAnOi7KYvzg+34k2SIU1eee1dTphYSON2Xiz/RREfm2Pnyo51UE?=
 =?us-ascii?Q?fTEgunl8ajRZGSk+ANmVu0DbU2IGAn/S1360a8rYAu7Tmj18cic9zb7lMSIa?=
 =?us-ascii?Q?C5Kl+Jb1mIKnEb6TNYQL0Q++cCPgOP//HEqpfQ0RCLm96f5asACKa7lYsXci?=
 =?us-ascii?Q?RNe0QlT+9DBBUQlME6yFQnnuXqzfFjA+wGiXEnGr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rzjS8dCo9wQgKb5so6ZiFfBzRkn50bMiCvtgNKkC3yHf1of1PBpoolxwHlfjuWVcx+vbCCaORle8Dhw9f9PwrS5TgOR2CGgZHHcnhO+euY7Lc41fZL7Tz30q7iPNLIPBqV5UYNIeEAOKIyfZRfhRbtiKM0PQiaBvY+YuQibrL7D43Gy/v5BJKfY5MpDIzCSyv8G4pNUaERbxiP04k7xRBnAu+1aPVV8zAqNyNoWqsL1JVo31QVLxoXPkdfNeXbUgnIEW9NhdulGwNrzU9yl/+oWJVDYBlFk2TwI7PgS7zAgcULV3Q2zxm0/GaWN7lO6tfp8IPav/DU0vQStf8I7jJ4cfZgpQY2DwsI6W3C1DBZrH2gNeOGAbsQWOFvwCECJaUJyuZ2BemKxP0+yzj9JrfMGRsAHzqdJACSKxU5cgkQCLggVAxI/ICu/qFt86YSmlIJwCm718evSNz/O/8klaTKSIDV73ssWRtFV5dZ8P4D/zJiRQfI41jGezF+Vr/CL1UbGe/dm+Td99/rkM4fL/s4LAMEEO/GGn6y0RR+NrWrspQj7j4nSytxQa+iNXm9dQkFvBf3fUWCwPh/q5I75qGeKVACKaA9yk02iYfIIvi2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcc7234-c3fd-427a-33a6-08dc3ea53da7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:51:00.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0MfiOk39d6wtMPHk3RNHpqijcrYMz3/o2WRstFxZAMCegMMGQ6NdHrsaK9IiW6tc+znr7y1XDTIsFjVgPTtCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-GUID: R6sy8Oz0_DsT2f2UIzdEhmVAloOyuYQs
X-Proofpoint-ORIG-GUID: R6sy8Oz0_DsT2f2UIzdEhmVAloOyuYQs

When a flakey device is configured, we have access to both the physical
device and the DM flaky device. Ensure that when the flakey device is
configured, the physical device mount fails.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/318     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/318.out |  3 +++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/btrfs/318
 create mode 100644 tests/btrfs/318.out

diff --git a/tests/btrfs/318 b/tests/btrfs/318
new file mode 100755
index 000000000000..015950fbd93c
--- /dev/null
+++ b/tests/btrfs/318
@@ -0,0 +1,45 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 318
+#
+# Create multiple device nodes with the same device try mount
+#
+. ./common/preamble
+_begin_fstest auto volume tempfsid
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $extra_mnt &> /dev/null
+	rm -rf $extra_mnt &> /dev/null
+	_unmount_flakey
+	_cleanup_flakey
+ 	cd /
+ 	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/dmflakey
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch
+_require_dm_target flakey
+
+_scratch_mkfs >> $seqres.full
+_init_flakey
+
+_mount_flakey
+extra_mnt=$TEST_DIR/extra_mnt
+rm -rf $extra_mnt
+mkdir -p $extra_mnt
+_mount $SCRATCH_DEV $extra_mnt 2>&1 | _filter_testdir_and_scratch
+
+_flakey_drop_and_remount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/318.out b/tests/btrfs/318.out
new file mode 100644
index 000000000000..5cdbea8c4b2a
--- /dev/null
+++ b/tests/btrfs/318.out
@@ -0,0 +1,3 @@
+QA output created by 318
+mount: TEST_DIR/extra_mnt: wrong fs type, bad option, bad superblock on SCRATCH_DEV, missing codepage or helper program, or other error.
+       dmesg(1) may have more information after failed mount system call.
-- 
2.39.3


