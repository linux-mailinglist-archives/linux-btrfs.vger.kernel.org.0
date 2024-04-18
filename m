Return-Path: <linux-btrfs+bounces-4397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5BB8A93BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EF6B218D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9E3C473;
	Thu, 18 Apr 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kDLVprp1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hZZXwguT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154C37719
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424190; cv=fail; b=OIpNUnuYWeAgtyV18dAbJ1NEiUSS29/vw0q3EqDgIO5vAAK5YEvRGqBJ9SOP4YMDQpI1lLOLotopcViISgNRMGvCozvLo44tkuS1mXkmHlmCRbGGiiogzbFcRVZvz9dOnsHGBfzOVvCKkyl9gHZpT4gMm9VRJT+wJ6iIt70Wef0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424190; c=relaxed/simple;
	bh=pUdKH5utbRwJ9KKP1GD35auBN609cdU6NwvtaC9j5Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rit2WrblF/yApGPBI/iUB4vCA60tkzkiUimmkD5oG9wLSTQgd5yx6C4UhYU6xIp15U3daIUSB/9pHpjXmJXxpTGNAX5/YSa4mEHxuVT/ocr2gX5t4tvn0CcJZv9+KDmRWy1n8SMpcZkR+6jSJ1ELdrB6YW4KStw2ZqAz3FUygkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kDLVprp1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hZZXwguT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3xM2H012092
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=RDcC35vSQTtuQ9acw3Ybon1JBzf2WByTprD/5FQQ5Ug=;
 b=kDLVprp1JQ2EGRSbBKCV1fTHAetKBw+wqG5zYT4ByJTPeO7DUAy079a2xvTfP4/xQTRN
 ER08S9cAGuaNMe1FV1PcdUCp0u6bS6gGlANSa00P17Wx8QBXHzhbEBwnTGumLwcuiDOq
 wrdXcw+oy+IFYAAZo+oEknz7yQfACeYlNvPOlBDNqudcu4aO2gBrAHOEZb/qJ9nLBrYi
 1CvLIFSvCGgcQ1foN8DUJ6GLeIc9O1n07rGmUFzuS4lfXBG4XcYN+36izlOhzsmA05r8
 utYWffAjNGIJiN+4i0Sn24vaTUOUvbQft5Su1zmVEutxlxOJphX81ExaCa+AFpRxX3pQ vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycsndf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I5ZLim029293
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y8r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3ssjv3YDIi7h+9yTgsYObVN+cwJVuoEQ4i3+peBF6jsNgjHVeETytmGKC3Ndn4uJYRq1EWh/YCJvMVkrb8m/t5dDWhccKxxnUZ14fDCqjhD8Ofi+plykIUw153j+4h2M5xDkmxld0KMXankKMOauzybATwgks/8/p4lybwgTGnMiae50fNMHAXQsXUVdhcTu7t/JJGI6GDkCY9itvYB2UszdVKy4BDz1MjoieMFB5BukoYbXsFcLjORhEP5sBHzLidG59Q9ktyrHRF3jMkxMCWXSXubp4xJwXTmGHFYl0PdPqGF1wM1fsf22uIW+OIRML/FuJXBzZsmYXKntXXayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDcC35vSQTtuQ9acw3Ybon1JBzf2WByTprD/5FQQ5Ug=;
 b=WlZvjDvcZwbstpZen1ClwAXj21kpFgNeMpHlw9DzwOkvhNul+xXxvkouhSqsXl7+HhOxfhGmKDIuQ9aOx/hZZh0q1xlddCvkXQgnMd7kXAMsc6oUdiuAhyUEdW5vdwci11JV7lEr3L54jKHTqvOJqoOrYxjA7deVO7b9RjdISPJR4xKWTOx1BioZXHXFIyqlrCwB1BlcPUBA8UAJWvJHssFPyiHPZ4wkprPcfg44tqyOD5SkbZbS2tWq+05XpPlwvpedUtxZjlxTIcFN9sZz5aFskkwlH6XWrS6WAVcH2bpDmHTiYPLbfoMy922CBUPAxMXPTMr8poeGctydDyyBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDcC35vSQTtuQ9acw3Ybon1JBzf2WByTprD/5FQQ5Ug=;
 b=hZZXwguTrmN5sjdKB49Lfm11+DpdNrIAjFeV9fEApGv0BhEYk/s4brk1MWxMyAsVKSTiWarPombPyuXWuNN/DrVaLIHLrS+ZV+BB8n6TBdz70NJwVeKgRrfpRn53Ec9iMBDUVYpp3qDPx/kZwghwJyjlurjaqtXbR4VNz+bQtro=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:09:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:09:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 01/11] btrfs: btrfs_cleanup_fs_roots handle ret variable
Date: Thu, 18 Apr 2024 15:08:33 +0800
Message-ID: <5063cdad35934623ddefe8e49c4a2c105713beb3.1713370756.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: eb97371c-c8d5-4d2b-3a14-08dc5f76832b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9OeXXUPu5DU8ixqUpqWs1Eu4MbLnGtbwz0yYhsnyQuk3aacQXWRvWXycv0p37o7kmfJ4lW5xEKSYaoSsIPl+fBi+XT5GrIbHwvAbgl6iW0G0tSyx0QQQjmerxvw0kArdhW5r5ABbe9mHI7N6CclvQEIWf+cKE6YtpRid71BUFn7AIlJEa5gs/iOOGkDGePf40zqR6klr9kApsL8R3II7tsmp4KlZK5auhSdGQ2EMHd4WqHEr84GynMJGpKrvkcb4TkOqU2daRYZ2Gb17xsOXnAlugiwb5Dta0Ewhmj7Oo5F9nAEVolTVZ7QuiA1meZZrOIE1oo28YolpdmwP3MJMK+4ppDkZLKgeHcWGsCXnHCsL7FVUXbFkV07qFmqVGsf/bXtB+ZN0jOw0pr3UuJYK8lLPAmxohcVC0hmxLVJJHTHTHRq4lDAcjkTCkZLMfzw7nNT5XkjhnC6Uh4W5HVjs7ndM98xbA13Dgff3E3MI6w6iKghjNi3rAYpV4cPctf1FUo1DqTK6UqUO421avQzDRpLc+is/hrVIg8QVySRmOuQTCVd/rgRd4fAhoGkcGSWSC3M15sbGeOA24p7zB6VIdG+YyWYHCzM7WUTCNfq+1GFAnwRdsaTTDj/pMB2ygK8kWuRVLS1Rtwnt4QzwM2CF1Johvjj9TAnPE9fvyYE4jT4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kR6jYY/wSYxNqn69QljmKY2xpvIMjuV19xnFM5NQohoG+MvIyX8HCVRz2jdH?=
 =?us-ascii?Q?b+4uMHDSZd7El/pBt+0Bxj2ifVp6Xe0SVvlIYe2EdIfp3qSHS9sAByzJSrhl?=
 =?us-ascii?Q?+bwwa1emr3kvJ8yEAW06ksIqSBvjByw8J5IZ07158sexyClXZbDrcizAzB4O?=
 =?us-ascii?Q?KJjMP1YEp3xmzKFu/aZwj/F//1LVU86xQ97BKj9i5izZaCPGQ9sUXOQo5Jj5?=
 =?us-ascii?Q?CIjXzgkmZ5Q7nMAup9+ZJSD8PHPTvcjgBeG95dTCXUmHl6ZSckDF9mcrc3rA?=
 =?us-ascii?Q?tDvq57tNxlz4SnvQyLqUtwwuR/uphZ97mk5uAKIKau4XdW1ry13neh4MszAJ?=
 =?us-ascii?Q?TMTBzUUPv55hnCjHDdUQ6x9mjsz71+lEyneHxadSTX/jeajCHGlQkb77pAGS?=
 =?us-ascii?Q?UACzsZapFBSm/JhYHeyFBZpXKzDxhviy4xOyM+bTFC7zUE3BipAwwNjVv+9F?=
 =?us-ascii?Q?ZkHYYOHuaTXxeJSTWUSmtLIB29MNfc11n0HIWgbU4D3cWPSifTiuovQFs8b2?=
 =?us-ascii?Q?3rKODkJDoFwaiFIem9evy8tQiA2tD8WIsLYnphEX7VDfUNtVqjgZmMMImaaN?=
 =?us-ascii?Q?Kzo3Kf2eujP1mo6RFWn5utzumLpF2iL4rq+aXb8fc8j/uUSsfYEPEjO7tu6E?=
 =?us-ascii?Q?YNS+Yvk0m+Sxu+9u05yBVuc34Tr3ODj2i8wHfJDmD87fRRvgev/+V0Cy+LwW?=
 =?us-ascii?Q?LZZ600lt6908Kt049WuQXPdydW5eatGeo4X4KuYDnIZ4qOpxzvZFCtO5a1uZ?=
 =?us-ascii?Q?nuFBQz2GSmBpmCoPu3cEKkJRoPNp/kBzTPWZEvV1CLQB2VQNOsBVqj+glEWJ?=
 =?us-ascii?Q?7WzS9lt0s7aDYh1PJryDGTC8YabhHmKTU6iPyW+kRP8nnml8lDVWj3bCv5gM?=
 =?us-ascii?Q?KwoqaonIDExPYR6ZLxDLQpIvxgDkVdkf6NHH8WQPBN82yOuHaqhtrviOtJ0D?=
 =?us-ascii?Q?JYbS/aI7QKo/xp3Nect40R6P0bWPf9+RB3+8dsLJE8CVOigXT+7mzfxsirfI?=
 =?us-ascii?Q?d3f2zX6waEDCHeHEOEnvzUOoRZiE+d9M1NT1sfQbcC6itUGUQDHqn2zuYgot?=
 =?us-ascii?Q?18BDhUv0m7HWPiaI/WZfUAbsvad+R45kFrz9E0SsKoX3l5TtenIM/7ybsAS6?=
 =?us-ascii?Q?WlpsJtj08PtTYCO9cpwU0atUnD6hU/OvEgkpCaDdRDdqZfwTxN3McSCEuyLA?=
 =?us-ascii?Q?0rMsXC1QClnM3Q69ppVJwIO2Gp/t+iRNrav+oDql3EKfOJUJqcgPrb4tlsrW?=
 =?us-ascii?Q?RK3ZD+FidMefJ4+NXFWcwu8OT4nnV4rJZh7GMJV+KMALMX3pzQlD8jwT01wz?=
 =?us-ascii?Q?pIOIlithjU3pv7wnwVfHn8oQXiDwOKOOSu8ZWsHDZ91lfcwuR+dL7xLMUrXE?=
 =?us-ascii?Q?UH37jQjJCkDkl9MfhSS4V+SI8QpiGyB/5g4G9LebCkCbruVBSDs8s4faqpK1?=
 =?us-ascii?Q?nRORM9hUUJWu46tVUz8kKewep1m5Xc721YZPetYLvLcoraNGFQoc9566R4xU?=
 =?us-ascii?Q?m19dwpZjhD3E+CpJgXtzIiwWGdV1jpN4U7wpwqK9GR1zj9NRnJVIVBIGXnsA?=
 =?us-ascii?Q?f4o/SOWsNn/7bKRlDNpXzF5Xbm3ez8I/7ah5iRp0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QdRLBfSOaXTswKbqCU2CUkLMLfzteCtgHxVY77wShlLFPwx8FH3zyqRdeO2MA0a+F3NUFLY7f3gZI3j2xMjP+H/XRF/7sflc/2AGGhrP/ogbUuvURSUeqyfLvHgQUo/qBgJO7Hk7yI890Y1PBlJhLKoHUDbfOzRSYJ+zOW5WSN8VOlyvEB4WuAjVJBB84XdTqTreQVjdBRHzHK8KT6NKy7Kbe4lJqoLAdNG82g1ulRrPTkHi17D+oyQU+v5Cy+7YzMh9/UOt5aIsG8o3WfHaE9BX3+cFqRmKPUpC+6U4/QQCNgWARhcQNu+o87WmyMxiblYNTw/aFBDmB+Y1ggkOq/yDVevkM9iayLP2Ys5jvV4NQU7IQSApNZ+46i9YHbHqg/b/Nn43QBQ8HZkMIb/Um+yQznVXGiVk6NsnESkBrJdlnh9Qc7vs4JAkDO1HTA/35YC8SDXYSFUP46Dx+UDJ7vWk1ou5NmxkRCu0MQ1aKE9zjXYYBveo15LliBzm9WaL8JXbqV85zzymT8dPaYZJajRDpfbgKTGuE5ZBG09yweDv1tN/e90HCZNr0rveHhLSA/d/3DizHPDMLnV4uHxGzFnaXiBp21orii3HGP9Wafc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb97371c-c8d5-4d2b-3a14-08dc5f76832b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:09:39.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOL+e32fwyR/G7/S1Dz9MqN0JjCbvjvVK/OHpbXC9yAzAadgb/pBXwz+0AElbkzlIXL7YVR99+6gk4KBnsTLng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: euc8ZKAxmxW-nHpUK3clsWerXMn-kvhn
X-Proofpoint-GUID: euc8ZKAxmxW-nHpUK3clsWerXMn-kvhn

Since err represents the function return value, rename it as ret,
and rename the original ret, which serves as a helper return value,
to found. Also, optimize the code to continue call btrfs_put_root()
for the rest of the root if even after btrfs_orphan_cleanup() returns
error.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Rename to 'found' instead of 'ret2' (Josef).
    Call btrfs_put_root() in the while-loop, avoids use of the variable
	'found' outside of the while loop (Qu).
    Use 'unsigned int i' instead of 'int' (Goffredo).

 fs/btrfs/disk-io.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2dc88f909b0..d1d23736de3c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2926,22 +2926,23 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 {
 	u64 root_objectid = 0;
 	struct btrfs_root *gang[8];
-	int i = 0;
-	int err = 0;
-	unsigned int ret = 0;
+	int ret = 0;
 
 	while (1) {
+		unsigned int i;
+		unsigned int found;
+
 		spin_lock(&fs_info->fs_roots_radix_lock);
-		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+		found = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
 					     (void **)gang, root_objectid,
 					     ARRAY_SIZE(gang));
-		if (!ret) {
+		if (!found) {
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			break;
 		}
-		root_objectid = btrfs_root_id(gang[ret - 1]) + 1;
+		root_objectid = btrfs_root_id(gang[found - 1]) + 1;
 
-		for (i = 0; i < ret; i++) {
+		for (i = 0; i < found; i++) {
 			/* Avoid to grab roots in dead_roots. */
 			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
 				gang[i] = NULL;
@@ -2952,24 +2953,20 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 		}
 		spin_unlock(&fs_info->fs_roots_radix_lock);
 
-		for (i = 0; i < ret; i++) {
+		for (i = 0; i < found; i++) {
 			if (!gang[i])
 				continue;
 			root_objectid = btrfs_root_id(gang[i]);
-			err = btrfs_orphan_cleanup(gang[i]);
-			if (err)
-				goto out;
+			if (!ret)
+				ret = btrfs_orphan_cleanup(gang[i]);
 			btrfs_put_root(gang[i]);
 		}
+		if (ret)
+			break;
+
 		root_objectid++;
 	}
-out:
-	/* Release the uncleaned roots due to error. */
-	for (; i < ret; i++) {
-		if (gang[i])
-			btrfs_put_root(gang[i]);
-	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.41.0


