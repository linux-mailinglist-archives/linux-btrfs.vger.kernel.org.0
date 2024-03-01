Return-Path: <linux-btrfs+bounces-2962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16C86DBE4
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 08:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C299FB2635B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A536931F;
	Fri,  1 Mar 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TfSIHQb8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yCAqIgOX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE369304;
	Fri,  1 Mar 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277263; cv=fail; b=L/DtrLgRumqsEDW2k/d4fQcO6Pn6fJlxmKHPaMTG/sAFQMPci7EMW/bjSgJk9tosTRG7Huwn8RLwZzDB2HiUfNc48u8oXfJWgqboGJWio+c5vlEy9UB24wfCMoRGCvCxAEm5vhV4LlH+NJ4Ez9hdzlbFdce+MFwL3ttPx0eafsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277263; c=relaxed/simple;
	bh=SpmiDPiRC7d5YONXw3zFr6fM02Qn57AQx8AQ/DDjSsE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DdXnCa9CSmuFMzPi9O7e+4LLP/8Sl6B1SA2TIfTLEWAt//eQP/K0Qo+9n5TfrrOyUYLBoyXx1YkYVxpfa+2c416mdtPQ7k4T6TVNPiDQf1zqF67NAHEGR+UgSQo3RW7NzXWRp/Wyw+/7J8D+iq0D4SLGqmaZ2xzDlaGfzSt9ijo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TfSIHQb8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yCAqIgOX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4210iSjE018244;
	Fri, 1 Mar 2024 07:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=xW9yHjcGt8fbyrMQBqMKIAEYh9HZklQfuuMzhBD0mDI=;
 b=TfSIHQb8ISQkxsb6lRFs7vXQ4+6dfm84dmBy6VyCUWay/VvtiM7dH96WWJ91LN68J43B
 cWqFox8BpYXO/1p2aYFMlczD4LX4VJWqNFpXBt8XWWWurefy+PrgfWcBh3JGghjSQge5
 +/SsfV8fUfPjk3+gJYJqNtSwi1XbRapWe+YRi8qEdDCLdFYdEBe1eh63oM9t9zqOL8L6
 kiuE9xHOcoRXOIMMYoNYjHpRzrefZDv9FoAl81JcSAilQ+TzxDDekhaVUS5ohinytOmX
 t4CTlwP8M6YfqCbH//DnuMH7ODkOxJnxok50CZYoO0I/rWnNCquT+DYMjk2jUQeBjn/d 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccqvwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 07:14:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421714Gi015367;
	Fri, 1 Mar 2024 07:14:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wbwp03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 07:14:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+pEwk/hf+/oqZcawAJrytxnVwtSbWawN6rX7jXZb/7I2Q0xmCviBYMr3DaAUTpOj39sJQuxke3lOGcGm6rfebRrYP1PFUsChSLeHfq5musEsXCYHJdC3TtpcHQ9cC3W/wEO2mvQ71x7FIiPDujT/HGmAQs/lxgjeN9DoRC8B4XlmslwPiqGomMja0z4Ai03P0adATIKQ13W3NFSCle9lSCPbip/MGp+usUAF2TK7HJKDWEgsjHEaGSKuuRt/KxVICZ8ZEevqqwjcfjns+BnW3C1T4zD5VXTWQf3zv3mzQfGo8j01qTWJOBaj3ckTKeEY6b9fuk2kCUbJfQGSIhqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW9yHjcGt8fbyrMQBqMKIAEYh9HZklQfuuMzhBD0mDI=;
 b=fVTLLANOriryYrfS8GbQz1sG+D57/MpQUn86fTD9Ie0wjADhd/qyW2bdx/+by6tIwokKA9chw/78ZUvEMnAmE0a2zFBNyVBppWXowz2hl8bkVaCR7JPSoLY/v9br3GM2c5/zQAEAtNPb85JberRDyYOR490d4MJtwHNhfEGq20LYi4GKkEmkmXYRhIFLgSJ94aF1+WYwqhS8m8/sZvoAGzBWWCUl8wQ2J23Dl5zHc21QpTV+a8WCe3n65Sm8jVbOcb1gTi3UxOHnT2GzcicLUlrrMCGTvjBm8lBk7YK3TFN7vh0iSeS4sBUOCkpG4Ek/yOVlYFR21GH5iz1rnj/Nnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW9yHjcGt8fbyrMQBqMKIAEYh9HZklQfuuMzhBD0mDI=;
 b=yCAqIgOXV7PalwtCW3nkJGOJ6qjIGbXWxZ3rrO4YZ9Q6+ECpbom5L61JEm5Y/nkM4JTqHaTILg57B1Fn1LpiEIgxPItSf0JwSe3H7x1YKpYz7V/EXvmVm1ZSdyBqPeE+4RyxwYB6S5vA82E9iKtUPmbJ2ruTBRiuTuyi+xEKWNs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5924.namprd10.prod.outlook.com (2603:10b6:208:3d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 07:14:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 07:14:17 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next v2024.03.01
Date: Fri,  1 Mar 2024 12:44:08 +0530
Message-ID: <20240301071411.55148-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: dd92644c-cadf-46a4-9258-08dc39bf3500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HzScYqeZZsG65ciYg4lsiVKMoV/p4Tf2Aluz1EEyLRk+L3O7gnZHzbsWxpB5nR6n0dHVxKVh6GglProSbAEDZfx7B0w6BHYnpeID6jbt8ffVoRxHxJZ/00o4+3GOVK7X81RnZugGD48A+VD84JMyCdIuwAg56IGCgQ0ZRmtNKPTDaeypc5rK8uk6kXyJD4V/xFAS2q44R0uUZ33LZwQGr0F2zUbF3o2WcLJlWITeaRiiO9l9cG36kVgdRcWYWnGokQaeIvgYQ5nZyZY5mhHBkiSsjFJ+CieQf1xv5kH0GtdRDxz53drbKIMJAJv5mUbAZ5U1Y7MC+H4x+o3pQ29WI2oqOlbN7XOJzUjHdfoCSYptaTP5Qle+DSyErXYAORokuSZwXQUPHzrKWvVqgUSXDlNbRZwDQU55WGXb/lNuOCZ8Qnono2hUdHlwVV5Qp0PJ/vF2hmanAHKqLDjzkp4meIChcb0Z0rI/gEYZyAR+9ZUMD2Ws6d5o3DInuB26rEH7q+03WY2qLoDg2/zeXxlK+bSFdNf41Yv8HlCHmKNuFID9PeumKxUUHPKFFs6jzoURRJ4VqJ2w46QykaCfoSDngA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dcWuO7Zr4HbjqYa37Aca9TWNrsjABHgc34NFwl5enZ7Rl/fESK5Bql7SxnQ9?=
 =?us-ascii?Q?SnIU7JFrBTtFlSRypUOvPyFfWK5LN6CDd3/1e/Wrn6PNKVlH/1sBV0EEqChE?=
 =?us-ascii?Q?eCzh6Gil/kM8QvIrdM500RDCMy5HcA4ngu8SNc+5R9hKdz6zaHaJfmBRpfUa?=
 =?us-ascii?Q?dyw7rrnWevqx9j+5XfMyU0S8aEO37Mqy4hTuUI8C7LK7kdCwnQpf3x+ekZH3?=
 =?us-ascii?Q?5EY1bnnH6X5RBtPrE0Y4e2BC6zI8GWv2k6XahLEk+LKj8BGKLguAOHV3zCWI?=
 =?us-ascii?Q?LrMdX/6sq+kyIOzhTCRS1g81F4GDZtWv5iwskulUoBbGCki9skbmgVFji/5u?=
 =?us-ascii?Q?js4wB4S0Iz2kc0jSWT4GrVfxKk4W1W0Yu6z1LyXbG/Ovu8CHcZdoy8hyJ1Tf?=
 =?us-ascii?Q?Ri+LwuS26fXx2KWUXhXDaO6j+MXr1VBKjfQAunJPjC1UVOw3/KrhWG17ghyz?=
 =?us-ascii?Q?RMvEYpTuzT2zNExWCrBH5Ivey0TwvsF/TGPCtkEReuXjo/CF3AR1/H+u5HMb?=
 =?us-ascii?Q?YpcTJ9xBmbjTVDo7TmsTItttZOpgeyvRpMVYbfoCYcVejsV9h0Ouf3E2zByd?=
 =?us-ascii?Q?HBaqdnbmM7QY5UXyIs0cvz9vXXqLora75vLNz4qQ6WAxq3mCaR6P4Zk19LhQ?=
 =?us-ascii?Q?wGEMeJeOd20xZIWoFZmtf2KDY6v1jQmWUhLMRqeFJFFUSYPDXYS81myEeYal?=
 =?us-ascii?Q?n1sbBv6i2IXoUHuq2+TyuSdqscnyBN7XEQyLE0LrSsb/U6MuYVtHTKhehFkW?=
 =?us-ascii?Q?rIZBUdjzXXN12AdBOc2WMC+ySE5p5MbVU5DOzYaYkD6qBCydgDtxYISzBYsL?=
 =?us-ascii?Q?nYgVDs5Vc8cv3CKMJc88LZ59IKRLCzc1hpNLbKtGQzjSBvG3vBsBv8sUnf4e?=
 =?us-ascii?Q?VDOEJeswqPTDPWwnH2557m7hwl609Idrc4TQlYPld3iUwh3E0cJS5dGLfF7m?=
 =?us-ascii?Q?Rr1iQQMwlJM4pj/R8AionJ1aAgz5e690VhniNlWwePrIiQARe2QohQg1bZ0j?=
 =?us-ascii?Q?pcHfpqxWx26Oeok27dPliZtojbHnUcRFzTtTC2fuFfDh9G/bDln5bbaPeVgO?=
 =?us-ascii?Q?4gbuG35BGojROM1vJm67w35KhIMVIIOAhR8nQoF+ELUrImHY84UcX4T6SZ5a?=
 =?us-ascii?Q?j5bFypmIzWI7qkgn7zlXfKI8zClykhp82T6h0Q552ULL9weJuWrE4cZYLDX7?=
 =?us-ascii?Q?SHsjdc0inJ7Pupvh12bgfguehvpldIiaLGTNxIx/yFWrIr61b5POdtCTBeD9?=
 =?us-ascii?Q?EX4bvCFGnypQgbwpZam8tgpo67e8a5s9tuRrjEVEluHBCce6TCTMWgWNt1ih?=
 =?us-ascii?Q?vFySeTbSMTd0vopYHLhFL6vwXbPt/50Pcdzbakr7Cqpt0Boze2Hc5GHCecka?=
 =?us-ascii?Q?r5hn2ZiGi/WU96Er3rAWn/cgS+9fat1vxhjEWKnhHb7VqebJG4RTt4Wl56q7?=
 =?us-ascii?Q?y9g5ZFL4i71Xsuxg8oG9jD1bpeYXWToUwjhEMai327WCXjVPZHWYrmRGIeGu?=
 =?us-ascii?Q?JLUBZhtjFQ0rrw0eY8vOVjRVgyTYkXNKNmoDDrGIqahatGM0N5Tswxygcaa8?=
 =?us-ascii?Q?7BaTBbbJN1KcMFxSHVO9TSYK5M7v6f0TB3QHt3brgJFI1lbiAg7ckpAherxd?=
 =?us-ascii?Q?RDU5wfbLSN9OOUpO91vpD1bweisqnE7x336m22f0Xm1F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CBOMKu5UlNTsMc3wJRfg0/n2L+2BX8UcTwVAhjr6sBS0WlsVFKfFZluMBu/hBsCVkXgsAYIEF6nlw44J2lIF4mkuXdRyGxzxHmvo/oyl6B8833Vc4Nc/B83ClJeRp5QrTcuKvUrrD9tznZYhZtjf3VtSYsdwNm9XCsGjzB6Gki6WN8QhvvAOM/rBfM49/cgzAX9e9Sq9F8E7lCGV5jEmp6aA9Lo5b8rdUC+YowNrfWTIJiWveurSQRn7ib+6BoAppUbxERqhd+W+aDU6m6f+qQJPxc8iaJxhdMBNckNNn8iBhrn+r/2zfv62t8QLkhvnnQOxojQ2wd+S2ljfdGog/Gv7t8XluUGM1q4Bs4w52bUa3FfuJUSPdlpYSggPOEP6iDlPQpZozYGysaRLZhxo3RbGPR3NtZXevV6XmIHps5SyPHmf9YpequIgsV6ULyYmWjUX8JMoQ+SdAb5mGBBmi1sZ49J6XbzY8UAbM9CcVWIrZ4pFNMWG53WOpfOR1MUdpMeAKqcsucx6keMOhmO7RJft/tW2ou6VFmpUH7OS6ibRAirDXkViZO5sVxOtoLo32Xhnnd1VMYZVKsNk+DhK8gQB0/P9EeYbLP80vNOErbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92644c-cadf-46a4-9258-08dc39bf3500
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:14:17.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxX+ljmS7ECkixgB951CntTfnnFr+eexczAzKWks3cAPTEvyMvPeM8qe5jg7sG47y03u0EeWEo3uxatHo9Fctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_04,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=977 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010060
X-Proofpoint-ORIG-GUID: ie25X2-dCvdjdpvua6G7o9OU8snZCno_
X-Proofpoint-GUID: ie25X2-dCvdjdpvua6G7o9OU8snZCno_

Zorro,

Please pull this branch containing test cases for tempfsid and a few other
miscellaneous test cases.

Thank you.

The following changes since commit 386c7b6aa69ebe8017a4728a994f80d55c660de4:

  xfs/122: fix for xfs_attr_shortform removal in 6.8 (2024-02-09 13:27:17 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20240301

for you to fetch changes up to bbc42ac1031c70e40b1191ac747697f0a3e0a5a5:

  btrfs: check conversion of zoned fileystems (2024-03-01 12:28:29 +0800)

----------------------------------------------------------------
Anand Jain (10):
      assign SCRATCH_DEV_POOL to an array
      btrfs: introduce tempfsid test group
      btrfs: create a helper function, check_fsid(), to verify the tempfsid
      btrfs: verify that subvolume mounts are unaffected by tempfsid
      btrfs: check if cloned device mounts with tempfsid
      btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
      btrfs: introduce helper for creating cloned devices with mkfs
      btrfs: verify tempfsid clones using mkfs
      btrfs: validate send-receive operation with tempfsid.
      btrfs: test tempfsid with device add, seed, and balance

Filipe Manana (1):
      btrfs: test incremental send on sparse file with trailing hole

Johannes Thumshirn (3):
      filter.brtfs: add filter for conversion
      filter.btrfs: add filter for btrfs device add
      btrfs: check conversion of zoned fileystems

Qu Wenruo (3):
      btrfs: validate inconsitent qgroup won't leak reserved data space
      btrfs: btrfs/224 do not assign snapshot to a subvolume qgroup
      btrfs: detect regular qgroup for older kernels correctly

 common/btrfs        | 76 ++++++++++++++++++++++++++++++++++++++++++-
 common/filter.btrfs | 15 +++++++++
 common/rc           | 18 ++++++++---
 doc/group-names.txt |  1 +
 tests/btrfs/224     |  6 ++--
 tests/btrfs/303     | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/303.out | 24 ++++++++++++++
 tests/btrfs/311     | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out | 24 ++++++++++++++
 tests/btrfs/312     | 78 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out | 19 +++++++++++
 tests/btrfs/313     | 52 ++++++++++++++++++++++++++++++
 tests/btrfs/313.out | 16 ++++++++++
 tests/btrfs/314     | 78 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out | 23 ++++++++++++++
 tests/btrfs/315     | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out | 10 ++++++
 tests/btrfs/316     | 59 ++++++++++++++++++++++++++++++++++
 tests/btrfs/316.out |  2 ++
 tests/btrfs/317     | 67 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/317.out |  9 ++++++
 21 files changed, 839 insertions(+), 8 deletions(-)
 create mode 100755 tests/btrfs/303
 create mode 100644 tests/btrfs/303.out
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out
 create mode 100755 tests/btrfs/313
 create mode 100644 tests/btrfs/313.out
 create mode 100755 tests/btrfs/314
 create mode 100644 tests/btrfs/314.out
 create mode 100755 tests/btrfs/315
 create mode 100644 tests/btrfs/315.out
 create mode 100755 tests/btrfs/316
 create mode 100644 tests/btrfs/316.out
 create mode 100755 tests/btrfs/317
 create mode 100644 tests/btrfs/317.out

