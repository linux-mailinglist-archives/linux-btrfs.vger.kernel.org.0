Return-Path: <linux-btrfs+bounces-12901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CACEA81E8B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FFF1B87DB8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF2A25B673;
	Wed,  9 Apr 2025 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="egaDVKCU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="beU8dFIk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661C25A34A;
	Wed,  9 Apr 2025 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184684; cv=fail; b=I20t/hs7e1amQfixM1D1hRsoPncgkJmDoOLhoit0RvE6asAnmdV4DG3bbZMNV/KXso1iRvwKn4eiNYms+IJVH5mf+nOEAUDT1MPs4c9PhUblNE4izR/70YsBKsSmcMMVylfgRN5CfJEjXkyrXDzqQb6k27abgd0Bi+TJCz2iwDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184684; c=relaxed/simple;
	bh=Yc+LBKStlivm+4oeHcCQpt5DU+YdskifgROQjI57Ra8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QO40pkZeRwA9vF4soTgYjzLly54xzJaKitE9X0hgaza31C7xrr0CchJwVfzXud4bvPEvnHx+nDvAGs70RKwk219idpd/2+VopT0D+UB7pLgv1ca6SzqQ1I2Hj/aIg5hag/7hH5pqDAbqo9sh+OZoXxu4AmZfvjifW7UDHUdcjwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=egaDVKCU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=beU8dFIk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9moE005736;
	Wed, 9 Apr 2025 07:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BZ2SxIDwqn9dsC3XN4jtmZLpY8oJMc81MnUAQpcMc9E=; b=
	egaDVKCU+hG+wThY0awiRMy+28/QxwQ8pr0hnziU76NOn29hVMeRxd8dYpKSQnmY
	GWYlcplEN0BT0hHVckRBPROMf3Jz7Mj+vnKsETRJDsFvmKDtaU0kF5EKvlkbBVcA
	TWeXLxGo2auZe+XbTShOtY8zW4QArXnkLLuo0KT/WQjvISG1fA4k08GYQKk0rnfq
	+w7po27/DaX0oQ2vTYgfKm/CPOPnbcQiQNv6LctWoX3aLDY+xfnvc1U9W3T3GNUj
	vFbHj1sUiljrxF4yYKVNVqJhBCJ9mkKTrsyDVOxIW6uX2wmgyd4vsW8qj0iuqCT3
	JJ9/HVxMh6orf13scBsCBA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvjcxgw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53963Q6H001330;
	Wed, 9 Apr 2025 07:44:36 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011030.outbound.protection.outlook.com [40.93.13.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyaey06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndIyR6bhOlyKhCcokkV8BZgKsSoH9us4yGtwO5ND+pDn9TlHoFbB9YuJjfVK614aLlskSoaqLRIslDESX37Oi9ZgTOqdt2Vq6sEzKO0feKwsye4NGirR+Wk4KdXEZELlqmXccLDYCTk5ObDyanVZrxv5lLt23hO0ARdRub5SVe/9Eu4lduWLmiRUJd1npjSQLrLN6HIa0c05vAA5XAjHQOdeHsUnUxQvPpho+r/cVsXxzYnb+0Efnjkn6ztg1XJhD99Ca7qsryPXou8Se/zKZ5N7F7gZXYodIOI/A73xMSv+G1cfiDFpPHhfWMJRnNkmy/ZyDmd9QsMHtbIml7PYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ2SxIDwqn9dsC3XN4jtmZLpY8oJMc81MnUAQpcMc9E=;
 b=Bcyu+VX/mUiUs9VTcWhnOxIbx6AoiM2i3wGivGVJ45wwD0sMaRaWJ/mLDMe6NPNDnteTfdQVcyPo2EhRyMmXUk2Obhqcr9jpD3kfxCwPk83BjiayzJkxI2x0640OqZdiePwYehOwMo7iKGIy+VqMjnHaFbJ3ebLr/9OzKZ9N7hrIMXGQylTsEW7Hi63rMPkQ32lO1fspwzNJYP2EI0HAMaLrhxUn1r5eW8nKzuI/ZZC+8fP2vhu6QD6CXkdMJPmLvaJhv5K59JXuuXxyMrasUeOxIosIv/jEwZw7/iYyMTXPjx7fD+M1pZPMndQkE6XWM4yByfjRtuU5K9KEr6nOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ2SxIDwqn9dsC3XN4jtmZLpY8oJMc81MnUAQpcMc9E=;
 b=beU8dFIkmwf9bd3Mm8cQxzxgL+5MZpTnsaXNxYHuELm6AjszkOXDE2GDdADquVIsDPdoZa5FmBVb1iuWTzxo11YgfUgDixlRlJqgxC7pyyEOBEWem9lq8xymohgNQra3Ujdk4F23qSuG94U+5w5MVgpSLaEx8KEbeN4bktGkzCg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 07:44:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 07:44:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH v6 3/6] fstests: filter: helper for sysfs error filtering
Date: Wed,  9 Apr 2025 15:43:15 +0800
Message-ID: <0dff2fa9e1325810a22c3e9a3f89ac99722f9468.1744183008.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1744183008.git.anand.jain@oracle.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: b8762859-ce94-43dd-1fbe-08dd773a5f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vuxX4oQ58R7I7r0kBQB2t/cEdXkYCcSR4PZjC+pSDQzz0OZ33PhpGFUmYtbd?=
 =?us-ascii?Q?gcgHt/DocUNSWd81qDtq/qJcFBQcpd7xzk/QfpZ1yBx8v8IjUh0I4OoOVkfa?=
 =?us-ascii?Q?xsgjf9V/pmKNTs2yTO+u4zeMC3JZxZuWlh3VIn0EnQGi88EGncnjqwSgDRAG?=
 =?us-ascii?Q?yTweNNwoSAbRcTL6aPZK+9TLXZB4HsKkSUrJtF8e5jHPU56JqGNM0dJjyvbJ?=
 =?us-ascii?Q?LhibCygVWFEmY4B2LJWEYWKvTvcM/Sp+Nc06NOekNPUrKsf0dA0ieMqQfaQN?=
 =?us-ascii?Q?LEgfz0p0EYUkSzInJDzKV+QoC0Ub/tC+b4/mXU9Bvp4Tx321SqSKnIYsibof?=
 =?us-ascii?Q?nE77fzAg8S29f0bAr/h7LKzZ16ak7XozPu3jsgZZbfcdAo/rEd/3kK4w7qVf?=
 =?us-ascii?Q?sbecUA553lqg9djv3XafyRN6Bh+U9yNO/HPY6xoaSeHr4BkDuniOE0nViUlL?=
 =?us-ascii?Q?XdSstML4eGa+D83SHsTkUcOsNYTVN/SpEc1viHZaTczT5Yi7s731Kbk+FVi+?=
 =?us-ascii?Q?u5lV57Co/zQ4n6unQpmd+L5JWreab03TMBGtzWEHWO1omXLzsOE3RXtfdL4J?=
 =?us-ascii?Q?Kn3eabAnBdR8Wt64XJzbmxkyB3ZckX7vfsrxgXX2jZbUwSnMGobqnnTpBqAz?=
 =?us-ascii?Q?jP6WQM81bL66H7UdJwVJwpffZZ+aiD1nuB2uVviI3TVGyO40HHyBhw10R2rL?=
 =?us-ascii?Q?VgSt3oazw1QL8lWY6A9h2IgmUAXJZynGrX65JA1Po6TA15PXvVplPFU7HCuw?=
 =?us-ascii?Q?XgBYgrSiwubmX+Wc8mQK/YjXflrMlBNJN9rUErKrhc2IVP25/OvCwYWCOVzo?=
 =?us-ascii?Q?Et1PAbINJ3Uw6+RyOlH9pGqB5HNbSsh7e6RsfY8Jxm9KrIYwbKPB+HkdOfLn?=
 =?us-ascii?Q?f+gDcIUDIiLOHG4wtTFmQ87atJSiGDQo0S+WqrJDIcOOqqkEv6Z0gRDL78qR?=
 =?us-ascii?Q?4isNhobbt0aM+WZcL08Ag+BYof08TMxB/gH+gTWrhz4NiqVfPJHsjVjH3xMd?=
 =?us-ascii?Q?KY4EMdcCJWr+V9Txm0z68UU+rSY/LasjQTYgzwWC7xbuTp6T578Lc9fYG1R1?=
 =?us-ascii?Q?/MSIw/RmTnSzExJkFxfY70r/rO52GryfpglB8B4N4XqVoKIvGj1cBdsF8u8h?=
 =?us-ascii?Q?xLshZupg4lJDXazSwNfCIeTgnrXZgYnsDyYSsxKrw9ZCV2bAXDHeo/5duJXV?=
 =?us-ascii?Q?T8qmc7nQ9OWOXiF3kahlTu9T/dq+Q8bTmzbKtvsD3JHAtasnCJJO1GsMC7yC?=
 =?us-ascii?Q?JnA4hHyP4GwUirjsivGQs4GJ9UU6W0QQx7ECAr0ym7kSAj2r71PWpsTxJCek?=
 =?us-ascii?Q?rW+H6DptO7yN6QpEXbPwpFFZ7Nzc7jD/ZlB/iCaf5wp23D3Kw2QQDILbkb7q?=
 =?us-ascii?Q?nGXgPS5FWhsAFZnLgxK7CU1I6xRu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/9hMrPUa+1mFDDzdErY2hqmC0QIg5YL+v2g4w8EIcW0ZK+dslkZVEon+0h+?=
 =?us-ascii?Q?a+EQwa70ZORP45AOoazE+ZrqsQefuEqtVmusYJkWlk7MZkH7ycG0F+8MBxJf?=
 =?us-ascii?Q?IO6ez9/36kbxCL1MzqSXN6yWz0sin2A7dz3Tiq2P1LI3mhMcq17o1V0kRXW4?=
 =?us-ascii?Q?RsffINsxasxcMhNWubIWdNsempyjvvWnznZP4dbP9tGHLaUcGOJkRsdSpmpK?=
 =?us-ascii?Q?Ksbom8NL8bgWl7lFFGVym/6b7i/asb91rK0kgRLlSAGse1zDTW4Hqbr/X9Pk?=
 =?us-ascii?Q?bYqHDUI8HoIxgTW1P7vzRdGJor92h/1DrNXNXW0+ezDh/ipEzmF5TyrfIFIm?=
 =?us-ascii?Q?VmE8v/dk2d6DHQCfazlmPZJbziY+V8I5NgxaYbQSDwd1oi+cmy42Nlu7hfsG?=
 =?us-ascii?Q?HCEyzfxNfh7uPaXmucLPEk3GSVWS9IMdk1cAWT5CzUuljPDx5zzmgz4wG/G1?=
 =?us-ascii?Q?Qo0Z0Q/47J7zCQ/iA4XIsdpe+2FaOxANvptQ0+KFL7wnPUfxS9EhP6Tg309G?=
 =?us-ascii?Q?e4H85l5TX/27Dd29LtWRjqscFyJP2j4jSenUC/NaQS54gAwugBCI8DLyVqfO?=
 =?us-ascii?Q?uMlDHwn3ZGDXjQeocVvxdIosPEPa6+glGvZHy6CojHIeeZ8Ct8V0d04Wfz9i?=
 =?us-ascii?Q?LkgvvGPsllfU0QUAWFU8cUg19b8O7FsM1mfVdqGBEGIcUdR8rAhgJCAOC4LT?=
 =?us-ascii?Q?iPipHIPW7YoZ6oTMM3Sr07lBHAdpWYblxu72F/WthHBuL6iHJ51vB1jFo7Bg?=
 =?us-ascii?Q?jJk8uiFSZreYDmnr9HkQ3fgDC+eQxTxaZINZrBbp7xIaIx2SsHlo9t9GmbsI?=
 =?us-ascii?Q?iCD8SksL814vauw37UmDPxA+7d/gwfmTn31H6pPfJ8E3DAM7gPNsbJmc9B5s?=
 =?us-ascii?Q?j8Z6Uc3lo0eA4+BNlW5Dq4nPe6uaikuhcxLGqbwpGRxnCF5VpxqafItCa7Ky?=
 =?us-ascii?Q?V1YQxjvf1EZ3GIl5Eg8jjyjJxV030wIpdWqjqh4Tk1VAb5XGz7VKNB/iM3jH?=
 =?us-ascii?Q?TmDy46Lq4TrwcQU8045/oOzNZf32sDPwksv83qfbnTPoZTpi1gnZh+TDbt42?=
 =?us-ascii?Q?hBZH/+Ms04Kt3GrmB/FsRoZDH1/H1S5/3SHNEaKPr8vmhc7YQ57Apiygd5+k?=
 =?us-ascii?Q?cU0oA955IqsNXdMiv9GzUr2PG9w0th10fvI09kF5x6n6tqNrLrcPvsxrNRyP?=
 =?us-ascii?Q?P30TKLhSOe8wN4wtQY7FIpdUX2LBwsgbYv2GdsWSp2q4Ww6LirSWNTW8OeB6?=
 =?us-ascii?Q?4lOoGW8dQ2L0skpo+LnaLMHi1oQvwm3a0cEkG02X5EXa0FEdQSRWdRX1yu0T?=
 =?us-ascii?Q?/lkYFE7C3LoK0D6ZErEZAmPCf4AsoN8OcQjAJg5J1X/iDSCRy0sfy0xAvxSU?=
 =?us-ascii?Q?6pSTguIphQwVRsXXqQQ/s31WaR+hawe/yGfv+aQJkwziC1R3jOdYKdEFc2CJ?=
 =?us-ascii?Q?CklVnJKaXahJ265brBy5msHgG5fb4AQuVCA1f8zea909G1Yw4gUQpSDjrDfW?=
 =?us-ascii?Q?Ypz829w7gsdKWP96YUmJJ9MzxiODo9hL7WrPMzrw7FarMAjE3Lgot1CchDXA?=
 =?us-ascii?Q?RohV9XqtfdP7e2dVCVW5stG+xr/cvKSeYR2DHTZS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	75kwxYsnEOO5Xkzb/0G4uNROB69fmjceiH0Gj90k03ShJq+N1R+jJm5q/CANZeFrRCwMbBKLlzI4F7n/92Oziaj856fzdKzwVMEF7Mm85oyLHR0hOme4pDHhJzlcTBTJnyJw4DN4I+5/LUfD3QtWqC7EnJOlZEn7TGY0YAIaPSFAjQvN/RJQEfwEROZTrdvGMvddJ9Ty6BrWLtPtEmSoKnu7P9q3vVuj8ukU9kSI6hDt3htvYME3JJlvOw7ztiNevy8zQB1tPpUY/YpFinYJDs07w287Mnuf6lil9bHJhfX+TjlZRXPbJjsQ1IUpDF+ErTMPA+gkMEXTlQmqTXtytJBqsJSJCsY+M7775DS8q/wCRNuOZ4n8w7FrDaSQiXFZECzKagM3+XkixsJSc/02xLjlb+bbqVdEVzAhXg7beayCrlUveCNqv5G+vTARwnvRPMNhvruOrq7c//H3whrewos1YxmNuOl2EMLxSNKMv4GlCL4U9YTpvmTZHJQGnFghCYmWpYwNsS2LIQTSsoSGpMaQ0IRiIvkTEcAuqbGDeZqGkEcMAhO3awCItWP90/y/0OytttS2jH9QDLcPd5VxBRw21Z6RC5pz2q5sACoh/uc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8762859-ce94-43dd-1fbe-08dd773a5f29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:44:34.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwWgoPtZcU7oWf0N9EkppHq1DXGztB9/PbGL92sK9NuPsf7ovdzSvQXe22zOx1CIOlXvazwxCbVKf00t0eiiKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090035
X-Proofpoint-ORIG-GUID: bjwx2XB6i4RJ597dOV5NvnE-kDhKEixd
X-Proofpoint-GUID: bjwx2XB6i4RJ597dOV5NvnE-kDhKEixd

Added filter helper to filter sysfs write errors, retain only the
error part.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 common/filter | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/filter b/common/filter
index 1ebfd27e898e..bbe13f4c8a8d 100644
--- a/common/filter
+++ b/common/filter
@@ -674,5 +674,14 @@ _filter_flakey_EIO()
 	sed -e "s#.*: Input\/output error#$message#"
 }
 
+# Filters
+#      +./common/rc: line 5085: echo: write error: Invalid argument
+# to
+# 	Invalid argument
+_filter_sysfs_error()
+{
+	sed 's/.*: \(.*\)$/\1/'
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.47.0


