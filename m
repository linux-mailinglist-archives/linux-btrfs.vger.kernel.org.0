Return-Path: <linux-btrfs+bounces-4233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837938A3FD3
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 03:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34915282162
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FBC1CD18;
	Sun, 14 Apr 2024 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ttvuk7g3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zHo+PP2J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BC1CA87;
	Sun, 14 Apr 2024 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057165; cv=fail; b=FwrFD3ur7rd7W8HkXQOILOSiGb9cWVb+hMmEgYAc2xFbYVK8gc37srVDhRZjeKMOBlmG4Xt2fHIg7LbKCXJCtyHRYXMbZHsXa44YvYRouWIlxVim+j6zDR6rn4ErQk+v0Drkn0CKxfK7uZY8kIqsJNgCHd6a7APZJZqp0Z1u8yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057165; c=relaxed/simple;
	bh=6MWu8/VyNeuOR5z8JTFvCqYQgiQIDB7J6chD+Qk632U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WiKDOU56IA1UIY+/s9tXtcfsRJWBZTbRn0prFlzzo7JSYNsL0btwJPB0qTDZ37jFtavMyyN+n8tmCUv3usbYDOgDYiOhuIK/cWqkWzvYjrBHGDLdmRmCjSpqXyH3jcmZ2FyaGi4HpoF4Ftw5MN5Z04OmB34Lzq3GkzszTBn/Q4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ttvuk7g3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zHo+PP2J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43E0wOnn005852;
	Sun, 14 Apr 2024 01:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2JPCLc9gRbhKynB4J0wj6Vohl/ffUJwqYDsDDGyw3js=;
 b=Ttvuk7g3i3MYpD/eMMpe/IC27DjBWY7BB0wI+jIfEhX+x6gIXyeIorVu2LQnF6fjzXur
 g7rM+sgyv4fRgtG4Kr6qv/GComXhryzEi5Z5lxlt3SJkrPHyFYu9lwcm1cbJW2qmF9CY
 DBA4DJNz5FFlvWcU76PfZboV0rWtUh4mWW2+goGwhReE6yX788AUB8QFGqiE3d6+yx3n
 jtCwc6HZNR49+XJF8hLNixPT7BJ5OIuMDV98lsvKCW+mXk/SZQXU7cn6kptWqc0Miy1Z
 EG+9Zs1e7l2NDa06wED0g8dDWvngx3WMSXK4ByGhTFboR55eLXuBafkeTqvJY1ULDpnU cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv0u11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2024 01:12:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43DM7jar029284;
	Sun, 14 Apr 2024 01:12:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg4f4wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Apr 2024 01:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNTdLy+TYDNcL2HbaRLJlg+oxR1Mqvy6jK21qS84TsKqy/pIPLDwb9sVOmgNeomlq5K5oVF4Xugb4J+DSHXwAPCAACrcHyvacJIwpKH6qlmiargGDRVydxJTEorXFUSfcIKhlMGZr8/5DkaHnJeXnlKDwWrNM07hwEA4hPRdYgcz7wRoP3sgnJ4ia247q39rQTmzl+mQ/C55XToGYU7A8Q3u+jm2NrSC8KTWX17T2zNigospYBptx8VTyfOCLqc27WbW+luW7V0a4zvZYy3fZuINEenTx9dOKKEgR5kWMA+e4vBc/Rr01qztN6QA8DL9v1gWBiPXAtLEeE7nsYfksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JPCLc9gRbhKynB4J0wj6Vohl/ffUJwqYDsDDGyw3js=;
 b=T5sVfGB6NG2LGzMNcp2f0Dim9FKwJs6d/iAc9rQ4Ui+LAEztc6INGDp1FS8pWJ1r3T9xKDoJwYlefHy2nx1BGPL1nEtedOOMOxuErYbHLAuQg8W4L0gmXUWoUXvX9OYHJKdZC+JTdh03YB7/8Qlux9JWIZmfg/tn5wYYE5ezinW7+Nn8S1Lqej9gkmMCSOtJ5pJlsVn05PL6R0xtY3QhlZA6fA9Xl0SA6V5Jw0okZX3mS896X+XoaaCPQ+w2BKkvqDcK0W0eqC0Dl6Z9IF2Uw4SwY22VR6UsZ1PB7CtkaQuEA/IQQby43bZRlB0qWBOuBYSXh3lmeCKgrLyiLpdoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JPCLc9gRbhKynB4J0wj6Vohl/ffUJwqYDsDDGyw3js=;
 b=zHo+PP2JWzuJ2qfqomHOfYg4RuJK4fYV67CegEFUI7VSXitKqHetDQAei8GaARdSeCpCQBhTaCPw15kFJgZudh+rjHQnA1oWLHJaNYIEfTgBcHAs1nN123UZtVSmZLu2dAEFBG14g8ZSoX4D47QAhCncyL1SRAuhctZJc2pAtys=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sun, 14 Apr
 2024 01:12:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Sun, 14 Apr 2024
 01:12:29 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes staged-20240414
Date: Sun, 14 Apr 2024 09:12:02 +0800
Message-ID: <20240414011212.1297-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 945823ab-44ed-47da-1f00-08dc5c1ff43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6owfV82mWCCSaNEU+uw3QOwU8C9YtrC54R7gJKsp0uaJOwexofwNuLDCtk4G+pQlSRyagXpqrQSsJ/IqyhKcI2Yy7ILXyJ5PE4iJ92pivrnEBCkJXU9+bhC7tFO4Oq+9Lq1rfPOLhCk/VVIbkPTlpSriPA3I4JN/R7naRaVKzz4Rjryet2aktx/9m7g3R556KLACZQ5TOavuGbMN0pltSnt3Y4/Gn/uK/QkoBuo/tvVpYsIjDxF25VzU/dSHYD4OLGr1go5dK7DS1qpBfLb5RHf/WTZO8V6iOR8aEnjGoWfKcZcAor5ia+L0jF3nYlIzGAGXkvdW6Azdknu1/kkOD5zYZBX5bbEfZqexB56UOfh/NaJ/PmVVR3Mqkn3TpYVuoBsjFs0GuxRnQJMGWEeOwaX64uhgBXjUNzjOxi8dGAJZJ0AGFnaF1s7MF91cUU573OsnbjBblsSAyjyWLhAj2G+SJVmsI1i2so2sgxVlz7hrVQojPbmdsz6gC2k77Cu++gVuvxC5/BE+f85qJh8CcxQjAZ5DnIZ4YgRi5zrBnGNbhd03zRNC1mGcP4TyZ8plSLgNkxQQGSHOHtKikAb+4xyQQ9A/CDleVLVg70DQkS7Sf1UN2Rw+S8BI+dO8lhg0Arsjn77Rlv2BLfmq2ZmZG0opimIBU+wG6FkIZ8vkL/M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?siWZ+e3rvOPvd8MrtJ7P6ihlT08SV8kHxi149D9TtJXMopKSH1l2lCkk+yKN?=
 =?us-ascii?Q?VqMgJe+cE8zWED3M9JkMI+wWRWD7B9J8GMirB/7O1JKxoq6uk8obeg4+aULf?=
 =?us-ascii?Q?abGwuWzc5sbEhu8vdS28MWae0bOT3M9YbQRqaVUSZzgan8s7xuICLyQqdGHS?=
 =?us-ascii?Q?wk0tcNdQZX8B/yseWt+DgX47m/iW+DTljuu+YWG6f3pwhBbTDZHqbNSmu9Ch?=
 =?us-ascii?Q?tUWV0asVM4E1aRAXAy5C39Hgg0S2clBcM+mxzfKhL/UD47V1dQ4g2smQAFH2?=
 =?us-ascii?Q?b4vGqrmXjega1Ly/kTGJD7IEs4naaAMM5Ez4z7t2nOflc+uASFGFfbw/BxKZ?=
 =?us-ascii?Q?f/8FCcrFRXJXxRhNLwmfCDUSWh614RsiBsDhxhlBoiqCJFkViEBSyuOMbPBO?=
 =?us-ascii?Q?k4wn9TQXfa8tao6S2L5Rm9m2NuwKE5/igf9+ORdbzSnRM3JYcUNPOecBNarK?=
 =?us-ascii?Q?FuWENNhwJTeb2uxySPZ8uHdlg5NUmVeYRMvbAT4cIz3/fGnwBy+FavVQ3qto?=
 =?us-ascii?Q?FWk5zQ5ft+LtdUax0fEnaEs/d+oKxbqXaPf2UzImH8kcIYWjcWsB1A2Nck4M?=
 =?us-ascii?Q?BG3Yn8E24J6xyaYVrqZGr2SKCnaH/+cFtbJhFf49bq3jysu6nnlp/1BeBnMZ?=
 =?us-ascii?Q?Jo1TeFvVpQ3jR/XYJSykJZniD3Zd9Fic6896Xhgsh30ZRsTUsa/nEORtw56F?=
 =?us-ascii?Q?viUfP2TfdUKlQVzEvJRkbe8O8DKYBAmjg5pxhLm0l6ycCU9wplLpq7RXkZO0?=
 =?us-ascii?Q?nPTuwRjZ9oqhDxeOgR5qCnK2+IZ4MmLfKa52hF8F94EowoTqKycfddwUoXxg?=
 =?us-ascii?Q?gqpwldTrCdvcUHFNEgpnp3YpGZA1s5aYjJcY7oHqDBDMIaJFgLw2+/LXKKZm?=
 =?us-ascii?Q?CJWXqa8OS+UGDodUZNM4jYX/8psmG/37qteEVFmABq1b5vssG0RVrvPOeNHz?=
 =?us-ascii?Q?/96kZ8hdFkgNTBUO2ewuZTCNtwu/pGcQqS2MSx93qSlVno6rHkC4lF5L5nx6?=
 =?us-ascii?Q?G78GD+ZOY1PWVlT6e4Hwm4R4uA/y/bt5lFFbu/ILKxEzrUtlREBBVI15eB3J?=
 =?us-ascii?Q?3J3RzfBffdrDL31xAWRR4RrmbM0BvE8bSLEADH3bLoMkh6zYcbhfO91ZTofz?=
 =?us-ascii?Q?mwceUHT03dBmdU5IP3MUylXeKJBAKNKbSCsXzuxHr5CT7sR629uE3bukAJP/?=
 =?us-ascii?Q?5P7sI8M275aNxF+csDLYfPd87WyjRV6kvc63d84b4iT1IB1zR8UnQbuNFBf5?=
 =?us-ascii?Q?HXXw4RIjWpJG+biO/fHo3G1A5rjieTiBlSjaO0bJ0Ty+YkszyrcHP9bNZH2i?=
 =?us-ascii?Q?tS34fm7ah7Q3KetyV2/taqtBL5ZANJgKVa7zQqHfurKGbJyiWalmPZJJGjdx?=
 =?us-ascii?Q?PrMDwnOk+8a5XwaM1LYyuzaAU2sRND0OFLGVNCFtfuRN195dX2Ovq0bRgwys?=
 =?us-ascii?Q?RE+pFj2IYVdOz/xeFVR1dnraYOUtAS/ynGyMTy/hrAqjC18y4GQm3ETQ21FU?=
 =?us-ascii?Q?RGmQ4bUlJ5UA9Jt6acekKnkBaALVO5N1KC1Xg0hu9b6JpnsZZuBJXqH1R5Rq?=
 =?us-ascii?Q?eTZlgxZTabLSCrXJKn+Gp/6kBEG2maej0UTY/DjWSn1IZqX5IhMBu84ZwBk0?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8w6Yz8y1NFCDV+4Ah/KtqMFCgqIPM+rsOnuqwuYlUrrLe0l4eloJ5Z7YdchTP2hLCiKgr0t3/XDn5tnbCflq50mgZ9ZTxV+S8D/7oPBhxH5btTvQ2Wmvw9f2HNVWQ4B+KkN6YQm0v+4RF+NWd64UvbBviUPnHfj3x846rvlRu5WxP1lzBtTYdt8UgiMuMoBKlEBZ1DBVq3qbdGJFhDgV1X0/IxAJqWaLzh4gJBlgvhSnKvaO1T6RxCcPuoN1KlWUYRG4/YzFFQjNC3gqPy0s001A2BMFtdMJIYVCbXlUpt1T5uVXZTJ+Exh2Kc3e0R+BQT5kfFQBmjj2xpDewDdOcDwzaA7YAVxMLOTz4zSJFUx/7roguqwesU3TwMuibSWtLJlFP7zs4kyUpd3fj80G8zQcEm4hdkolmpYOCQ2OPti6zoJ7y/PdGmbZYJCxqWfN8f1021KK1RG66xCDyc+pL9YHe3hPlQGsR6IR5lW0TqE6aMEMGNEnstSoMpkJ+4HLYPdxXNzBt34PdSy9fvIVP34zjVetOSpOv90FYPu8QStUHVrUDVwuhP1orjQg7jOzmbjHk2l4f+RlATQMz3cAjAAK8tmxAw4H4jvW0V3LezU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945823ab-44ed-47da-1f00-08dc5c1ff43a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 01:12:29.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7N0pfKzYGG2AC1eFkhXb/KzNVirT7C9lVGltbYGxR+aYwAy/ITEMtchgzPmnmkcynBNy7v57iBn1fvoWqqzXrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=774 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404140007
X-Proofpoint-ORIG-GUID: Tshk7vPPJxs4Bn6T3F6qo552R6-lclcx
X-Proofpoint-GUID: Tshk7vPPJxs4Bn6T3F6qo552R6-lclcx

Please pull this branch containing changes as below.
These patches are on top of my last PR branch staged-20240403.

Thank you.

The following changes since commit 8aab1f1663031cccb326ffbcb087b81bfb629df8:

  common/btrfs: lookup running processes using pgrep (2024-04-03 15:09:01 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20240414

for you to fetch changes up to 943bbbc1ce0a3f8af862a7f9f11ecec00146edfe:

  btrfs: remove useless comments (2024-04-14 08:38:14 +0800)

----------------------------------------------------------------
Anand Jain (5):
      generic: move btrfs clone device testcase to the generic group
      common/btrfs: refactor _require_btrfs_corrupt_block to check option
      btrfs/290: fix btrfs_corrupt_block options
      common/verity: fix btrfs-corrupt-block -v option
      btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME

Boris Burkov (1):
      btrfs: new test for devt change between mounts

David Sterba (1):
      btrfs: remove useless comments

Josef Bacik (3):
      fstests: change btrfs/197 and btrfs/198 golden output
      fstests: change how we test for supported raid configs
      fstests: update tests to skip unsupported raid profile types

 common/btrfs          |  45 +++++++++++++--
 common/config         |   1 +
 common/rc             |  14 +++++
 common/verity         |   5 +-
 tests/btrfs/001       |   2 -
 tests/btrfs/002       |   2 -
 tests/btrfs/003       |   1 -
 tests/btrfs/004       |   2 -
 tests/btrfs/005       |   2 -
 tests/btrfs/006       |   4 --
 tests/btrfs/007       |   2 -
 tests/btrfs/008       |   2 -
 tests/btrfs/009       |   2 -
 tests/btrfs/011       |   2 -
 tests/btrfs/012       |   4 --
 tests/btrfs/013       |   2 -
 tests/btrfs/014       |   2 -
 tests/btrfs/015       |   2 -
 tests/btrfs/016       |   2 -
 tests/btrfs/017       |   3 -
 tests/btrfs/018       |   2 -
 tests/btrfs/019       |   2 -
 tests/btrfs/020       |   2 -
 tests/btrfs/021       |   2 -
 tests/btrfs/022       |   1 -
 tests/btrfs/023       |   2 -
 tests/btrfs/024       |   2 -
 tests/btrfs/025       |   2 -
 tests/btrfs/026       |   2 -
 tests/btrfs/027       |   3 -
 tests/btrfs/028       |   2 -
 tests/btrfs/029       |   2 -
 tests/btrfs/030       |   2 -
 tests/btrfs/031       |   2 -
 tests/btrfs/032       |   2 -
 tests/btrfs/033       |   2 -
 tests/btrfs/034       |   2 -
 tests/btrfs/035       |   2 -
 tests/btrfs/036       |   2 -
 tests/btrfs/037       |   2 -
 tests/btrfs/038       |   2 -
 tests/btrfs/039       |   2 -
 tests/btrfs/040       |   2 -
 tests/btrfs/041       |   2 -
 tests/btrfs/042       |   1 -
 tests/btrfs/043       |   2 -
 tests/btrfs/044       |   2 -
 tests/btrfs/045       |   2 -
 tests/btrfs/046       |   2 -
 tests/btrfs/047       |   3 -
 tests/btrfs/048       |   2 -
 tests/btrfs/049       |   2 -
 tests/btrfs/050       |   2 -
 tests/btrfs/051       |   2 -
 tests/btrfs/052       |   2 -
 tests/btrfs/053       |   2 -
 tests/btrfs/054       |   2 -
 tests/btrfs/055       |   2 -
 tests/btrfs/056       |   2 -
 tests/btrfs/057       |   2 -
 tests/btrfs/058       |   2 -
 tests/btrfs/059       |   2 -
 tests/btrfs/060       |   2 -
 tests/btrfs/061       |   2 -
 tests/btrfs/062       |   2 -
 tests/btrfs/063       |   2 -
 tests/btrfs/064       |   2 -
 tests/btrfs/065       |   2 -
 tests/btrfs/066       |   2 -
 tests/btrfs/067       |   2 -
 tests/btrfs/068       |   2 -
 tests/btrfs/069       |   2 -
 tests/btrfs/070       |   2 -
 tests/btrfs/071       |   2 -
 tests/btrfs/072       |   2 -
 tests/btrfs/073       |   2 -
 tests/btrfs/074       |   2 -
 tests/btrfs/075       |   2 -
 tests/btrfs/076       |   2 -
 tests/btrfs/077       |   2 -
 tests/btrfs/078       |   2 -
 tests/btrfs/079       |   2 -
 tests/btrfs/080       |   2 -
 tests/btrfs/081       |   2 -
 tests/btrfs/082       |   2 -
 tests/btrfs/083       |   2 -
 tests/btrfs/084       |   2 -
 tests/btrfs/085       |   2 -
 tests/btrfs/086       |   2 -
 tests/btrfs/087       |   2 -
 tests/btrfs/088       |   2 -
 tests/btrfs/089       |   4 --
 tests/btrfs/090       |   4 --
 tests/btrfs/091       |   3 -
 tests/btrfs/092       |   2 -
 tests/btrfs/093       |   2 -
 tests/btrfs/094       |   2 -
 tests/btrfs/095       |   2 -
 tests/btrfs/096       |   2 -
 tests/btrfs/097       |   2 -
 tests/btrfs/098       |   2 -
 tests/btrfs/099       |   3 -
 tests/btrfs/100       |   1 -
 tests/btrfs/101       |   1 -
 tests/btrfs/102       |   2 -
 tests/btrfs/103       |   2 -
 tests/btrfs/104       |   2 -
 tests/btrfs/105       |   2 -
 tests/btrfs/106       |   2 -
 tests/btrfs/107       |   3 -
 tests/btrfs/108       |   2 -
 tests/btrfs/109       |   2 -
 tests/btrfs/110       |   2 -
 tests/btrfs/111       |   2 -
 tests/btrfs/112       |   2 -
 tests/btrfs/113       |   2 -
 tests/btrfs/114       |   2 -
 tests/btrfs/115       |   2 -
 tests/btrfs/116       |   2 -
 tests/btrfs/117       |   2 -
 tests/btrfs/118       |   2 -
 tests/btrfs/119       |   2 -
 tests/btrfs/120       |   2 -
 tests/btrfs/121       |   2 -
 tests/btrfs/122       |   2 -
 tests/btrfs/123       |   4 --
 tests/btrfs/124       |   3 -
 tests/btrfs/125       |  11 ++--
 tests/btrfs/126       |   4 --
 tests/btrfs/127       |   2 -
 tests/btrfs/128       |   2 -
 tests/btrfs/129       |   2 -
 tests/btrfs/130       |   4 --
 tests/btrfs/131       |   3 -
 tests/btrfs/132       |   4 --
 tests/btrfs/133       |   2 -
 tests/btrfs/134       |   2 -
 tests/btrfs/135       |   2 -
 tests/btrfs/136       |   4 --
 tests/btrfs/137       |   2 -
 tests/btrfs/138       |   3 -
 tests/btrfs/139       |   1 -
 tests/btrfs/140       |   4 --
 tests/btrfs/141       |   4 --
 tests/btrfs/142       |   4 --
 tests/btrfs/143       |   4 --
 tests/btrfs/144       |   2 -
 tests/btrfs/145       |   2 -
 tests/btrfs/146       |   2 -
 tests/btrfs/147       |   2 -
 tests/btrfs/148       |   5 +-
 tests/btrfs/149       |   2 -
 tests/btrfs/150       |   4 --
 tests/btrfs/151       |   4 --
 tests/btrfs/152       |   2 -
 tests/btrfs/153       |   4 --
 tests/btrfs/154       |   3 -
 tests/btrfs/155       |   2 -
 tests/btrfs/156       |   4 --
 tests/btrfs/157       |   6 +-
 tests/btrfs/158       |   6 +-
 tests/btrfs/159       |   2 -
 tests/btrfs/160       |   2 -
 tests/btrfs/161       |   4 --
 tests/btrfs/162       |   4 --
 tests/btrfs/163       |   4 --
 tests/btrfs/164       |   3 -
 tests/btrfs/165       |   2 -
 tests/btrfs/166       |   2 -
 tests/btrfs/167       |   4 --
 tests/btrfs/168       |   2 -
 tests/btrfs/169       |   2 -
 tests/btrfs/170       |   2 -
 tests/btrfs/171       |   2 -
 tests/btrfs/172       |   4 --
 tests/btrfs/176       |   4 --
 tests/btrfs/177       |   1 -
 tests/btrfs/178       |   2 -
 tests/btrfs/179       |   4 --
 tests/btrfs/180       |   4 --
 tests/btrfs/181       |   4 --
 tests/btrfs/182       |   4 --
 tests/btrfs/183       |   2 -
 tests/btrfs/184       |   2 -
 tests/btrfs/185       |   2 -
 tests/btrfs/186       |   2 -
 tests/btrfs/187       |   2 -
 tests/btrfs/188       |   2 -
 tests/btrfs/189       |   2 -
 tests/btrfs/190       |   4 --
 tests/btrfs/191       |   2 -
 tests/btrfs/192       |   4 --
 tests/btrfs/193       |   4 --
 tests/btrfs/194       |   4 --
 tests/btrfs/195       |   4 --
 tests/btrfs/196       |   4 --
 tests/btrfs/197       |  30 +++++-----
 tests/btrfs/197.out   |  25 +--------
 tests/btrfs/198       |  29 ++++++----
 tests/btrfs/198.out   |  25 +--------
 tests/btrfs/199       |   4 --
 tests/btrfs/200       |   2 -
 tests/btrfs/201       |   2 -
 tests/btrfs/203       |   2 -
 tests/btrfs/204       |   4 --
 tests/btrfs/205       |   2 -
 tests/btrfs/206       |   2 -
 tests/btrfs/207       |   1 -
 tests/btrfs/208       |   2 -
 tests/btrfs/209       |   2 -
 tests/btrfs/210       |   4 --
 tests/btrfs/211       |   2 -
 tests/btrfs/212       |   4 --
 tests/btrfs/213       |   2 -
 tests/btrfs/214       |   3 -
 tests/btrfs/215       |   3 -
 tests/btrfs/216       |   2 -
 tests/btrfs/217       |   4 --
 tests/btrfs/218       |   4 --
 tests/btrfs/219       |   3 -
 tests/btrfs/220       |   2 -
 tests/btrfs/221       |   2 -
 tests/btrfs/222       |   2 -
 tests/btrfs/223       |   2 -
 tests/btrfs/224       |   4 --
 tests/btrfs/225       |   4 --
 tests/btrfs/226       |   2 -
 tests/btrfs/227       |   2 -
 tests/btrfs/228       |   4 --
 tests/btrfs/229       |   2 -
 tests/btrfs/230       |   3 -
 tests/btrfs/231       |   2 -
 tests/btrfs/232       |   3 -
 tests/btrfs/233       |   2 -
 tests/btrfs/234       |   2 -
 tests/btrfs/235       |   2 -
 tests/btrfs/236       |   2 -
 tests/btrfs/237       |   3 -
 tests/btrfs/238       |   4 --
 tests/btrfs/239       |   2 -
 tests/btrfs/240       |   2 -
 tests/btrfs/241       |   2 -
 tests/btrfs/242       |   2 -
 tests/btrfs/243       |   2 -
 tests/btrfs/244       |   6 --
 tests/btrfs/245       |   3 -
 tests/btrfs/246       |   2 -
 tests/btrfs/247       |   4 --
 tests/btrfs/248       |   6 --
 tests/btrfs/249       |   6 --
 tests/btrfs/250       |   3 -
 tests/btrfs/251       |   4 --
 tests/btrfs/252       |   2 -
 tests/btrfs/254       |   2 -
 tests/btrfs/255       |   1 -
 tests/btrfs/256       |   3 -
 tests/btrfs/257       |   4 --
 tests/btrfs/258       |   3 -
 tests/btrfs/259       |   4 --
 tests/btrfs/260       |   4 --
 tests/btrfs/262       |   3 -
 tests/btrfs/263       |   4 --
 tests/btrfs/264       |   3 -
 tests/btrfs/265       |   3 -
 tests/btrfs/266       |   3 -
 tests/btrfs/267       |   3 -
 tests/btrfs/272       |   1 -
 tests/btrfs/273       |   3 -
 tests/btrfs/275       |   2 -
 tests/btrfs/277       |   4 --
 tests/btrfs/278       |   1 -
 tests/btrfs/282       |   1 -
 tests/btrfs/284       |   1 -
 tests/btrfs/286       |   4 --
 tests/btrfs/288       |   4 --
 tests/btrfs/289       |   3 -
 tests/btrfs/290       |  27 +++++----
 tests/btrfs/291       |   2 -
 tests/btrfs/292       |   4 --
 tests/btrfs/294       |   4 --
 tests/btrfs/296       |   1 -
 tests/btrfs/297       |  10 ++++
 tests/btrfs/299       |   2 -
 tests/btrfs/301       |   4 --
 tests/btrfs/310       |   6 --
 tests/btrfs/311       |   1 -
 tests/btrfs/312       | 153 ++++++++++++++++++++++++++++++--------------------
 tests/btrfs/312.out   |  19 +------
 tests/btrfs/320       |   1 -
 tests/generic/744     |  87 ++++++++++++++++++++++++++++
 tests/generic/744.out |   4 ++
 291 files changed, 310 insertions(+), 876 deletions(-)
 create mode 100755 tests/generic/744
 create mode 100644 tests/generic/744.out

