Return-Path: <linux-btrfs+bounces-4403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3491D8A93C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482CDB21ED0
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38223C473;
	Thu, 18 Apr 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EbPi/80H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LkW5zA3f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A939FFD
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424216; cv=fail; b=p2FSgtdP6UmqYieD4fSm3p9B7YNl/v1NvZbhaEeP+dulm57YoRMbNkzos27ujRdDh+I2xVW8Rbxy+KDEp7QBdA0MwLEUvg/sHuZc2m4gx6QX4dv01YhNo0lktYJXhhONgUdmRirj9c/UacePDb78plcZDoODO/HfhkIRUGWHnKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424216; c=relaxed/simple;
	bh=PCg803RQ1XP67UEHfYNDL4nFDJ8AVnwpp2GUObO5A1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxywSPVfmmMhf2WX3G1ddAVGyjyU5UFIpBI4HnKUEf7kxCFw9WXvVYbRV/GY0I2jjUPCj6BSKZu3jpIYnIe6OoG1+cd5u5A4EjXjXmKzfBAHh1uZRf6q78TeuSWTwCuSxACnC2cGhlyWhdTgwsads0dWTNj9+2C7wHyxhuj0tPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EbPi/80H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LkW5zA3f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3x1HA007679
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=sA6urBG1YPy6+h4LMi3cOsCxy29/QDQR3R71KdMS1Gw=;
 b=EbPi/80HwH1rO2zEb8i2yAqK4nWvGSZf1X/enMjrUZD4XTzqS8mGp31jcr9bNRiUYrqJ
 jj5m3CZ0IdfePb05V0lF1eClMp0WFUV9IMdzyPoJe8KbcxBjlBb/XxOprjNFyKAsq8M9
 7fRu/GoG5FUY0sX7LA6t8raufg+oedYD87Dz0YSscQ5EeVhocPus+7DwmfK1VnOWnZDN
 VWFtJoSUMUmjoIfR0zmRRgDfYFxsqrsCadUKwBJ8kn6YSAD/v4DLG8SwQ5L933ciRvM+
 SV11IyygQNtAPrxWz9r6S4qF/qZ3GOEydlRcXQRCSDb4n0XmuL6O5puuHGigQaYnPajZ JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2smts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I6HG0O028852
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y7ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI50nJRcBAqwtUCUspRt7rtVEkgeKcDHPL3dunmWt+af2kGFWc40X9LO1gK7LsZFPEI2aHdUtVspy6Gy8xzcVvegfKT8oJxQBTSoroKGS9XS8eLQHpJ18AwzTjlBmfeOMskAUybEl02926fDKrLTHbKGXJrO/5lnFKkcieomidFH61Y7EJI8gtRvcWwpPhrH/lmE8Tql7qwRrNxRH51iEBh9pSJgnbZIL74Xy4LDItczjyAFZVrPSQViHa7MQq3LXZwkGvqWkVtoTlf1QDRvBne9wwklUphfCdJ368GsCisYOYLF+v1ViiJYVOJxPrIahalP3Hux1PmCd3M7yEF80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA6urBG1YPy6+h4LMi3cOsCxy29/QDQR3R71KdMS1Gw=;
 b=K8enYxZGck3y33exbzgTL1elGq/9nucH/MJf2gkjpTz8WZgG+lMUi8qqj5jkxDX7p3b6hQo4geTZN0T4ydvrJzI4pX+7IZQq3pb177TD9ENp95QhJRjrrpAZ6wm1/Os2EPp6tEHVo+gNvDOz1ZkmfX/zzrMtTuK6gKK1cH/P+dRBCdDi48Eo8FucWozXaxMjdGtPmPuvRbAGMT3IPkesgpT8z5VKY7H1XRWtfVrCtdOrPqIQwmU7hcRMa1lvJtghLQVIA7+lknVS3BHajTUK8it18+Giyi5YLuaIT8XbteMTQHfFnNAjVXHmkqexAxZ97dt7aRxTwwADWdS8+93OAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA6urBG1YPy6+h4LMi3cOsCxy29/QDQR3R71KdMS1Gw=;
 b=LkW5zA3fPIvb3pDFl9WN/fAynfv6VHqZzmnyzVgpBOiBBLiVkJQ3GF9hJz6vwJFwYV7j1Hz0tbVsEVK7ePnij64pnh7aqzmZLUrSQ9pVbLRTFFyeRpF+RBxQcQEjij5+jEH32QvDEnVNukd/X7VtL9ORVbiYNlJhiYReIAJJ/mI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:10:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:10:05 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 07/11] btrfs: quick_update_accounting drop variable err
Date: Thu, 18 Apr 2024 15:08:39 +0800
Message-ID: <52fca12ea2bd6ec9e64495c5b498d2e498b219b0.1713370757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8652de-03e1-4f81-f0dd-08dc5f7692a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jS+FGHisHD5vSbeacmO5gKGNrqOTeopirGN/7zjv8ks7QzyNe277JmvBaMrSxVZWhafYXBh2TIO75cJ3B1YU1XRvO2VU9in+N+o+2bVY1AjrzhDsRlMmGuQWYSOBedxMKI/AMRvhPmn44XouEhi+zrVuXVPzzywxE3btQbU0wAt1TXRxVa1kzo1xKefccmIBEUmSXfIykn8IoafIFuHi0Yu1BWn5rXYRKGrAeZyc/JWVh8I1kUfSXf4rPeVhO025m1cKmr7fk+eXIEhARQ9Gb8BhMwJQhF7BYRzeWn9N2weFn3y1evz0DuPak7YKDu2COG17H+ppZGDzRdhxKRQHTmXqqiqAmc4GdRMLNUgPtYSLJlYLKTg0ED2Cb476bAF9Weq6vn7yCWSy2/61/MqXVL3W4iAVM9VetIm1+3/rlywzzAtYFGcZlT0gpSLOPKf5xFVQdDbW5zHuXZ/sdtyqA/D7JsyV9p6P6/BYjV5kplOMB/9DZYuVdtOY/GvyVPOltavwojKuXGQAav9vpdYM/1FhzxNGwrWwE49wldkZUATbswD3WfoD3N3hc7hklOn7iraPifXyLcnvOO8uR8UXxbOGqLAxamSvj7GUeRxpoUbusboGt1Z+AXPV0GH9un3oPv1Y0LpD/G3AnueexlEtx/219pcLUnPm8a2EbzManb4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dQGtla3txoMThrxZSk/EzA4idBbcI1Ts+WFLISzLNZbEvga0/LJIRnnwY+DX?=
 =?us-ascii?Q?s6w+Jq3PjaIP7ZI2fVdaI1Hs/j+fRjpVfZVc240HVCMiIgWMyb7X33S16TCp?=
 =?us-ascii?Q?b3WMLzoXyN3EgILEipux5cQ1o+cPRUPBbvaSKsU4pvR2+lqAjcDvJ+96gv+d?=
 =?us-ascii?Q?aq3VLn+REqxVFuqKvYdXPRII5keTlft+1nMbmkow+vi9qj8BX7XZoiswd77C?=
 =?us-ascii?Q?clMb9rcaphzcVXf3KJtyxvSb5eilnG3GeUD2PA1QMJ2OX7ASG7CBUF89DvQj?=
 =?us-ascii?Q?JInmuCKQWT0WEWqc07QEJK5vZz27JSrqlwsi/NYKwLTskOCEplkdkbRCi5Wv?=
 =?us-ascii?Q?7YsYY8AaPrtR7hHDQadyvlkazipG4NF5lOjnzJAwUSruyTsiPl92p9JFSn1r?=
 =?us-ascii?Q?GQeekFzBBR5l1DiLgt8PwBHeSieBpyTgdbpnERjikgVtIymjnwkT32AkHxXU?=
 =?us-ascii?Q?oUKJu7XzcQ/Bl+8luOjNZuz+2xkbeUzS1JGmMXgqoSh2UHner9rIV+Ut8bG1?=
 =?us-ascii?Q?cOlgUalwidRW099qqlgDLKmpbg2b6cH4ynxrSwA9q3Je2TL2zyo05ImWal3Z?=
 =?us-ascii?Q?YEHWqfGnm6Sw8ywzE2y5Qb2unKfKjbrMZuxYFNWtefqaKwPkuGMoLa4wh4Dv?=
 =?us-ascii?Q?LYBfzcP0oB5wsDk1N7whXt6OnAms1tBBesHL77YzFidpHoFUW+YO6DC48r5b?=
 =?us-ascii?Q?m5x30TyQGOOPs7PNb+sN1bHa62vC4/itjXQx5KWWoClz/lcEygLf84ERwYBw?=
 =?us-ascii?Q?RWvixUqMZu0D0MIJG9txbOpHerKnE1mtmmsbVbDXK22QtUKgEXg32Cq5FKlS?=
 =?us-ascii?Q?xi3P7J2VrOHRBXYZZuCxrO6S4ZLOyiwAipO51PwFL8tqEDrl0deNiIikJRCK?=
 =?us-ascii?Q?gcNC0u0Td8Qzr0WzzTs0Ipamk/KCOivYGnGnKX50p5zXCB0ilZaWsuUVE0vG?=
 =?us-ascii?Q?4sUGMBXH7C3wQy6cugPtlmy+TScrmbLQMRWuqvWvCBw70y50ZmmFfRW6yi2K?=
 =?us-ascii?Q?hrQNsfvkBKjMBo6tuuH8B4VYRnQaBCgl3zmfgaimnQAYxOqPRu6S20L5jk3r?=
 =?us-ascii?Q?i9jixAjh8nxGuKKj83JgIjl8G8mwyO2DRT7wTQH8hWn+3vmW8+tKVBrDglQj?=
 =?us-ascii?Q?oVtpU3pa4u5pKXhibqes5uXg/DdNqqigvMYH8AzRrtMjgwNhPYmlV+dfwCcA?=
 =?us-ascii?Q?D9c/gNtKP5AQyio3n0EniWqnLX/2aG6cjwDywv2HXq+rYouSqJ9fPm764HJl?=
 =?us-ascii?Q?52mA/mvJa8fzqKj2PlWYXqJPhLOU3BbvCuMICkSQH0a/NOpCcItSq29pKIvB?=
 =?us-ascii?Q?a1cKuBDMbH53990i2Kxf3oFM6FUhrAlgUx7yFzpaPpasMKZqiVQBVKmUNhhh?=
 =?us-ascii?Q?UuZA2F2sjqsTz2RM0vGJFto+CehGUgNxqMMWD+rMuAJIDd60E6aOS6BIgsvi?=
 =?us-ascii?Q?yhul9rNLebN+ENlxCDBJ/wzhGb2FS5drqtLT11DXErSB7psRAO824OjM95gN?=
 =?us-ascii?Q?9HG+FHB0RE2a3Sbi65ZSNES/V2+a4Kj+68OjK1GmuVkum6dc8cgMeALA6imR?=
 =?us-ascii?Q?9jGSg+Xb1F9ZB09LjpzR23YbmNZYXBpJOLdhbOmX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oovJ06bEBLUjUCXlrTzynbYt87dTkF8dsY8BpgK+P1wI+lwDHLYjdFyGHw2g2Q0bOaHWmneq5TCgOl7ZYgkZE2zpcjU4c18cmGHG1d3Nqb2jmDh6ZBVovkRj86SECjlNEmMV6UZ0y8ntrj1eWYNF1zOwuJamUmGvvcrGrubGIW5/qaU+AywOtsT8Ghj9GP+9g9YnXBxE0LvTPVmI7m0ExiukPzor27qQe/xVsTKr8b43SriheZ9sJc1Pmr+ZgyPOOKBG7aFC8qXrQS4W50HO4k/UompviD3MQ9/z3LyIVPnH57H9GhYYnq2oJwFa2UkhRT5WpiLnbcNZcPcIj8cbod8wSbraC4SpLUQCA/xkCX9RZmphQ4uleUFAnUTerAnn/DoCQeDMBhwh+Onh8hKTld28zWcOinSim4AJszKUB5QmYnPDYdaPk3GNsMIpE6oyFafyU2qUCeY/VH7PU+qnioLqum/HqQzgpsEeyx9gf3i80oc4hX7M6KV25VNKwYFEAL79SBn4/4fDn7s5V1mQdBHXV4xGRmCDhffRcM9P3MYdeFDAfZiVGRgKdDiCAvuI1Gllb+TMOeAJVmalAIwZwPa5dnbkON7vxbKycsWIDlo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8652de-03e1-4f81-f0dd-08dc5f7692a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:10:05.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNNyZGlTTJXkxqZLkzt2UABacD1NybnWXniWvax2fMDnwNYWydE6SPChCJ6IGjU243jD0ZKSGf0kr0JlpuuAjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: ame1Fkl0VCYMw_DNxQz-d6WT_5rx44iF
X-Proofpoint-GUID: ame1Fkl0VCYMw_DNxQz-d6WT_5rx44iF

In quick_update_accounting err is used as 2nd return value, which could
be achieved just with ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: optimize __qgroup_excl_accounting() error out, so drop 'ret2' (Josef).

 fs/btrfs/qgroup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9a9f84c4d3b8..9a0f47d0c6bf 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1541,18 +1541,15 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_qgroup *qgroup;
 	int ret = 1;
-	int err = 0;
 
 	qgroup = find_qgroup_rb(fs_info, src);
 	if (!qgroup)
 		goto out;
 	if (qgroup->excl == qgroup->rfer) {
-		ret = 0;
-		err = __qgroup_excl_accounting(fs_info, dst, qgroup, sign);
-		if (err < 0) {
-			ret = err;
+		ret = __qgroup_excl_accounting(fs_info, dst, qgroup, sign);
+		if (ret < 0)
 			goto out;
-		}
+		ret = 0;
 	}
 out:
 	if (ret)
-- 
2.41.0


