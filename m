Return-Path: <linux-btrfs+bounces-10428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D7A9F38C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F1418853F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA42080C1;
	Mon, 16 Dec 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcPEIF3T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xAG8fxrb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836DA207651
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372877; cv=fail; b=VuX/PzRTVSgpOXU1sNTgn6R+I7YP/uHzrHzIJF753vtLMNnGf2HxRdSOXZh4Z6V7EPWbsDHmkWvwq56PD6TZiD95DWw3gJptew8jsNtdJEqcFE2foTqS2nMI3agu0OUhaDU15S5bhwKsyX0YVjvD+61GJrH1doCJJdmcDFLZMrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372877; c=relaxed/simple;
	bh=4rDYMkl5elHHPniqdzXbZjlTLtoVuqwA5zt0LySk2z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOvTUBi4KHalkdVCrX7vkzj/UAjz05KNMDZ5NX3GwBj+e7byiLUr67NuTQrgm+Ee19HfWMBkUadAsKBuQc0fLldWRLN3Ec7ENiE3eMGwgtnMVZfTxvib6FEu3mxV8KiZkMVWyRt5b/S26ER/TzHHP6E+WxQwfQDrupva3FnWoxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fcPEIF3T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xAG8fxrb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQtYA015434;
	Mon, 16 Dec 2024 18:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jYj64u+dgtu7QMYvM/n2JuUdjPwcI21a14QeObnaXZQ=; b=
	fcPEIF3TVziN3STBE8n9DU2bcNQh893HZ+ZcB7jHalBONLx7OOmtqOjRRVGMqb3d
	8EG485wremE7H9N+wGfnql0dIwh0h/w7HoNLLu4OxEMWEOdfxwo2sFDgkAd+TNIg
	886DakDT8hAkSbl1kDG5wFZH7biZ4Hk7wC3MJxLWdUxUMcuBexVEpVRQrDNJQjIv
	6jzDvWgwM3VFWpbM5AgItoU4+JXbergVtsKES0UKz9gQ8V9anoo9mncIMX/gTze6
	ofyGrGWbRfX+LEXVvTUZ0oltzUxCKvEwsZRRkZpkOTXhkbSiA9ZARc1GCDgQgUVb
	HyoZ+zWWwbPfo23IJdJHAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9bxck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHIotZ000776;
	Mon, 16 Dec 2024 18:14:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7m3mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtgLtB96PMyVCgVGwncA+/rhAcG/W0RvID6smLmphXsDrFxzuxdsCpWllfBfdqF+wMDmLdbAe/XVrTWjmDyAmVMYVNSryRR3IVi6MpwBh66ChAnPIoPVwvR9wOJfRcQ2kKLKLUi6VADywnSoZFmoNX2QD0KQexCs9fL1y8RgXJJ4R1wMRmWGbT6caQg1HLIDJoG9TIcgosS65zjLNZFq7B+9sGlNVm0xMmagKIsveMTQzKC4baOYRUc+cu1Fcv3seFeHqyOLgiGOi23D4rSBRnpiR0ZWsISuRLV4DQ9KLnnzPToSYP561gTHDT/nf3XDuFqpf+e206BvNdJ19exTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYj64u+dgtu7QMYvM/n2JuUdjPwcI21a14QeObnaXZQ=;
 b=TMPtdhrxOry3dMpd9oy+UsRy8vBDIdUbPcbI31ArzCGKP8/vl6vqn8fmnZCMcirtZSHXhfiWMlquTE0F0JW3hPsrreMhDQg4wKJUSayx+xVfUuucVmNExdhbKktWppQugSmO0KnFr4uN5WTT1nL+lkFPMJsmH00RR2Teeitd4hNsCeODnOQLFdYhs8N1RMhB4Bv5IO2CLcNW5yrOApEpFCJWwelnuB4NLJc8XWCB24LPqzHA+AhaSlXqR/IqNcZ5U58o0EfbqGwILsXhNGy72IF6DStO4DRuDNOgTuqeFP/Y0EIMWym/023dQjnEGbo/3oYfE7D5EXWGFeByFQb+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYj64u+dgtu7QMYvM/n2JuUdjPwcI21a14QeObnaXZQ=;
 b=xAG8fxrbbHuvDXyx24EbrHvdTl5IDIYqNAqE0LHDPsaY5G2MJNtDdqvjgr1nfh/qOBpvzaM5fiMNB1ZDiNRne3wykk3zswhzQlDF1b7yRioYr10hvhSoAeYpdu0bsL1yz0KN6HxrKc92uuDvkZU3AZAzf3eawwZdY2GxbYmxILQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB8220.namprd10.prod.outlook.com (2603:10b6:8:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Mon, 16 Dec
 2024 18:14:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:14:23 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 6/9] btrfs: add RAID1 preferred read device
Date: Tue, 17 Dec 2024 02:13:14 +0800
Message-ID: <dee9a6d8815751f9ca69cc4e233df63565003d04.1734370093.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 560362c2-e277-4060-d4a7-08dd1dfd77b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SRr+u2ADvtVggD+Hg1hYaHjAhdxe23jK9VHZ/2d/xVmVp/3KYbk1Kyoj4oJ3?=
 =?us-ascii?Q?iDuBR3pAMreaKUVV+8eOX6TPT/TKKgABfcypqSNPWaQKVC4uBLIDEnz2j/LR?=
 =?us-ascii?Q?Ig429K/D57kGBdoO/8fSIEyPOcVT7GIWbolDDZry9hb3KJN/kKCs6+dgc2FC?=
 =?us-ascii?Q?nEt3ijoaAN+pPZ0bbbOg3hm9fWXxCD7qkcqCkVqnCanqIBrzSwfSyau+sZfB?=
 =?us-ascii?Q?REunV90LOznyhWPkxlu7qR4K5C629UUtnpgnfBYqrD+1CcR82scZMCRmxhnc?=
 =?us-ascii?Q?HhkZ5ibxVJAOBdLkULDmR8oFLDWZob029xlRRxB+cxvkVtyOe82aqthNTDYS?=
 =?us-ascii?Q?IM4qYihxey9Tb2FXFeRARQMUOYCd+C/0FXdyfgDculI8mM+BFe/9HhmtApyi?=
 =?us-ascii?Q?x8Nj5id//h5ZeX9Ycf1lDozPEGGs31xF7ChUBgCa12Edo3KXhdt9eAN2BfqO?=
 =?us-ascii?Q?nT6tv6fBusfOUwwqo3zAX713Jw71sYpDn3dPogClDrSO9DDEsJW16EUmr/Zm?=
 =?us-ascii?Q?hCuGu9ET6dfNmaINK7tm3M3skvldERM5FeKYm+pMJZeX4dIORapTbNMgiWfV?=
 =?us-ascii?Q?I8+8i5BwuMGvNSaaEdEgqR7r170NOicxRJ0zuv1+lA2X/PfH5w6gFHk5WdaM?=
 =?us-ascii?Q?mUJV2NRLaouRMGbf86Q3XhA5QbDKQ3ewa7y6eghwA4xhutMpqRhrlHZEvoeZ?=
 =?us-ascii?Q?2TvtTHLQvRgL2MSKRxqIUOtMLSk0nskln0JEz/MWxjup260pdiLDN1caL5+u?=
 =?us-ascii?Q?EVRoPhWs8G58I/ObgjijnBJXgmewYas84oRvfSTLkTDyyP4VpNHSWGoMXv6W?=
 =?us-ascii?Q?Lx0KBfS3rL2Pjf2sjMOYZxPUbIr5UA8kXymc4qlWa8wWP2uQ92Z8RGNNxrtB?=
 =?us-ascii?Q?lT8N+g6+w+E4t9t/mhyBl25SH5PbtPTAn7JudMn+iT6QsFlhXeh7V2nEAgp8?=
 =?us-ascii?Q?CA9B+h/mH8nY2yZ815TzQV9tRqz9tRMmwaXi+1W6XEBUcsf2C8MFMRU80VkH?=
 =?us-ascii?Q?8p5ExkweBs/sJXhcx+3HGN12xRLz34Isen3CqRSAly621ExI1Xal/znBTQ4P?=
 =?us-ascii?Q?wAOGZ2zqFaO1hLG2FRvD7/EIEqxTJK6EzZZA/wZZmGx93pI3rsGaeKPVc6Ri?=
 =?us-ascii?Q?h6kYHW9CeCbcXLLITm5k20mLvWC4oNwGNvNT7y+1vfZJHLYwqlsSHONm9vn9?=
 =?us-ascii?Q?VTfMci96SRdzpKieNg3F5TKm8S+aqmynIuxiDaciCqTYzdseHwmZvBlYzdzB?=
 =?us-ascii?Q?0Xu+JwexDXiNDMWRo2inZlHdv+isnlfPZVfeLTt86vIMPBmEJm9gfXH0h+E+?=
 =?us-ascii?Q?1pl6taCj06tRxm34c264LPOYOnaIRSStaFfHuRvC06+eTF016dwXT+Y67ZZ5?=
 =?us-ascii?Q?mwDmuN6T+O3Uc7zkaXflLnKe7+eA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3A+m7oTbxCqRZByWFqrrn34i+LmzCkUQbJsq+CleOtZegb+L0GpvFJZlsSR?=
 =?us-ascii?Q?tz18bFAF6eW0/52d+yRr4F2Vrr8hgTV7RPtFbD1+w8gidhLWBMJY68nIva1J?=
 =?us-ascii?Q?M3IPjqDjuFOF6tjpYmohoZrdDkp0Cw4SwYQYGHjx04eRlUokMnb/jdCuqZg4?=
 =?us-ascii?Q?RRxDTpk1UMxozFvSlbVKmpG4wxnMW3VVtgYT/i4EjhzQx0Qk5dHXUYuZf2Qa?=
 =?us-ascii?Q?D3xT9lBd2+qzqbkoG/VTU76houpdIcE7pUAQ6xFCNHEAm5lCQt6lxlOA4X0i?=
 =?us-ascii?Q?pEuDyaWoIbUsOm5we+jzAoXAb3Yg/qkDp3UfXlw9NBf9b9j8uRz3u+LE0ATY?=
 =?us-ascii?Q?nKEeFV6dastRK8q2ApFVQfZBlsxUgJn1zmEe3cDQNFKzgXaixJRlBGcjGQ03?=
 =?us-ascii?Q?mzFpY64bHk1ishZs6Dc1LrAHMcRucqe1j4A/6LELRoMZZUueec1VGJ9oljTp?=
 =?us-ascii?Q?MEk4yifb4OMaej6rAhfLhz4ibQE4Z98WryFXKpWkS7BMqtEytSWVxYvGvKrO?=
 =?us-ascii?Q?OE9NollxPnuHRs+xOuEHEq+EgG4ZRLKpbmoMzReKVyK89htecdPyiyJQElHH?=
 =?us-ascii?Q?P6YXODZnXGIUZg0jgovZ5RqKfKYov6KYmCMk8S8jbJ4sTOyuVSK51pGqXs4H?=
 =?us-ascii?Q?p3eFToCIYwSCWIsBPycMN9bmd6jQDXMZ5bdLjDYrG/3IyxxiEQIEkvBkJjNa?=
 =?us-ascii?Q?Ke1fVODxCdvfeh8nuJlMuCc7COEvH+jTWPPgI///Pryx+cgD3e/CSMdKoD3H?=
 =?us-ascii?Q?6Zgx6GGjB8voNss2Nt1MQFe4m1nCOmVzlcMug0VttZkuDsAoHOVCpWkRrPO/?=
 =?us-ascii?Q?BTjlcFfM1YLedR684cH+j0BUlENhz5sCS2umOWmgOMH8NXim0CynAYJa3uNx?=
 =?us-ascii?Q?/uwppaUthc60Oih9X15GLuxChbVcafINlpUYXt6J4t3wqHZCJ0TrIdfedIrk?=
 =?us-ascii?Q?cSCcbwlkQxhyKcsp/kDkV4D9YZRyAfNAZMDRlPycAUxGevObkIRLIVig5sar?=
 =?us-ascii?Q?L9YBMfJnWMrx5jOskh12paFy8sLih50e7QwlTcnHzxqNc4EkmjnKVrfjGJLv?=
 =?us-ascii?Q?D6xmLjQ49ugNe5avlf+SQFCVrYbXolQe2tcy6Jg/MLe5MXPgDWDdR5wVD0tF?=
 =?us-ascii?Q?TXLEuyeWG1pQZhqcOfyTsh5d08QAe3S1wzsNVBnhsDCbub873zOWW+PtROOo?=
 =?us-ascii?Q?xCustYlouZQpoR//aYamywYTByWx/75BnlqN/hmEuYmlvU9uSJW1D7hMNIVT?=
 =?us-ascii?Q?iNoU6NFE6EqrWMFxd8NjPUHH1VAmFikMscnDpnlWgkAQUnevTbUAGggMoKBO?=
 =?us-ascii?Q?YbwUieoH7x1DolSjcAC+a4W23rkf1YqSbMCF06jyoODcHz3HSGeaPxLICZpr?=
 =?us-ascii?Q?WqOb23g/UZclE9oZSJAsbsPFj1syTb8N/DZ3Z9tVo84oxNxqT3Txp2S6W8vG?=
 =?us-ascii?Q?mQigyjkNajlDLW9M7zbvLq/gJcT5JEulTAe7LzUl+A5nJf5OmgS7LVyl+ppt?=
 =?us-ascii?Q?+gUMPfvcstaFYtye3swfHg/OLgADZntNOLRxqZiUfmk1bPciFzYIptlrYjdZ?=
 =?us-ascii?Q?t8NT1n7qS1P2hXy5gYvYFCVIybcu+s7v6wwiKyPz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qtLpypM1qelJsxRSg11VqDpKxurhur3KI9Y+kVHXRl/JDIaC9cnU3P0AjURKi3tmt2fEm2VfjdW9HYyZitHQufIou1kk+I5+vt3FKF//NGgBGBdIfKH0GoWDTK5IWMu8MinZnKPXcCDiCWbjmmmxw+gbFJQVOTWpoxRybSfr/5woopgkH7Q85ohkaaElrffJZzVyJfGuOyAyF9O/5bMoITIzkquYwz7Ecnv/ul4ijd9iZbcSc3q6XGTAKz/J8DH5y6eTdgeUNEcVk90Oin0t7oCgNAJYW3anlbVp6nBOxKrBN0MdNR0rrwwAlmqROJJ/3cfLWH26BIISr3nM8xuqHBnxVI15lWQcibU6vTLYBcyeHokxUnsUdF/UOhHPAx7JiWu7nbsl5Q0+xzln62pVL1xb4MmvCOJHxzd+KU69t0RL1sGkf6WR8rQfdan1hga18o3FWTjwN5B/K3FJD/OGlIpGqm5ZBAlaV8S5qvHtrTbx7NFbv1HRm485+QvYCCEq/VLsJ5c8V08ZImSFd9/N5BUO06pHWIfaPDPmUp0xqURMn4CHlTjKm/YuKR3C8z+jA0xSS6hGon6kFnTHGwM0bC/f1fqG63FpkXtYhUTx+Rg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560362c2-e277-4060-d4a7-08dd1dfd77b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:14:23.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5j3bv3sVv7LFY96lOgs6rwPpBOL79EC4HgKLnfBfgrU2rP9lb6+5wrtKWs9PYITNzjnkFuMVFX/Mc8pUAvMxTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160152
X-Proofpoint-GUID: j9I6ydFRlskSXD0jw3I3TK7EZLRwpgFq
X-Proofpoint-ORIG-GUID: j9I6ydFRlskSXD0jw3I3TK7EZLRwpgFq

When there's stale data on a mirrored device, this feature lets you choose
which device to read from. Mainly used for testing.

echo "devid:<devid-value>" > /sys/fs/btrfs/<UUID>/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 33 ++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 21 +++++++++++++++++++++
 fs/btrfs/volumes.h |  5 +++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b0e1fb787ce6..b4b24a16a50c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1309,6 +1309,7 @@ static const char *btrfs_read_policy_name[] = {
 	"pid",
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	"round-robin",
+	"devid",
 #endif
 };
 
@@ -1368,8 +1369,11 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 		if (i == BTRFS_READ_POLICY_RR)
 			ret += sysfs_emit_at(buf, ret, ":%d",
 					     fs_devices->rr_min_contiguous_read);
-#endif
 
+		if (i == BTRFS_READ_POLICY_DEVID)
+			ret += sysfs_emit_at(buf, ret, ":%llu",
+							fs_devices->read_devid);
+#endif
 		if (i == policy)
 			ret += sysfs_emit_at(buf, ret, "]");
 	}
@@ -1421,6 +1425,33 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 
 		return len;
 	}
+
+	if (index == BTRFS_READ_POLICY_DEVID) {
+
+		if (value != -1) {
+			BTRFS_DEV_LOOKUP_ARGS(args);
+
+			/* Validate input devid */
+			args.devid = value;
+			if (btrfs_find_device(fs_devices, &args) == NULL)
+				return -EINVAL;
+		} else {
+			/* Set default devid to the devid of the latest device */
+			value = fs_devices->latest_dev->devid;
+		}
+
+		if (index != READ_ONCE(fs_devices->read_policy) ||
+		    (value != READ_ONCE(fs_devices->read_devid))) {
+			WRITE_ONCE(fs_devices->read_policy, index);
+			WRITE_ONCE(fs_devices->read_devid, value);
+
+			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%llu'",
+				   btrfs_read_policy_name[index], value);
+
+		}
+
+		return len;
+	}
 #endif
 	if (index != READ_ONCE(fs_devices->read_policy)) {
 		WRITE_ONCE(fs_devices->read_policy, index);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 77c3b66d56a0..ee2dd7e461b3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1330,6 +1330,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
+	fs_devices->read_devid = latest_dev->devid;
 #endif
 
 	return 0;
@@ -5963,6 +5964,23 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 }
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_read_preferred(struct btrfs_chunk_map *map, int first,
+				int num_stripe)
+{
+	int last = first + num_stripe;
+	int stripe_index;
+
+	for (stripe_index = first; stripe_index < last; stripe_index++) {
+		struct btrfs_device *device = map->stripes[stripe_index].dev;
+
+		if (device->devid == READ_ONCE(device->fs_devices->read_devid))
+			return stripe_index;
+	}
+
+	/* If no read-preferred device, use first stripe */
+	return first;
+}
+
 struct stripe_mirror {
 	u64 devid;
 	int num;
@@ -6060,6 +6078,9 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_RR:
 		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
 		break;
+	case BTRFS_READ_POLICY_DEVID:
+		preferred_mirror = btrfs_read_preferred(map, first, num_stripes);
+		break;
 #endif
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b7b130ce0b10..62812f4231dd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -308,6 +308,8 @@ enum btrfs_read_policy {
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Balancing raid1 reads across all striped devices (round-robin) */
 	BTRFS_READ_POLICY_RR,
+	/* Read from the specific device */
+	BTRFS_READ_POLICY_DEVID,
 #endif
 	BTRFS_NR_READ_POLICY,
 };
@@ -442,6 +444,9 @@ struct btrfs_fs_devices {
 	/* Min contiguous reads before switching to next device. */
 	int rr_min_contiguous_read;
 
+	/* Device to be used for reading in case of RAID1. */
+	u64 read_devid;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.47.0


