Return-Path: <linux-btrfs+bounces-11926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F69A49134
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E271892356
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 05:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A81C3C12;
	Fri, 28 Feb 2025 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZNzs6Wh/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e4uv6Qfk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BA1C2DB4;
	Fri, 28 Feb 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722151; cv=fail; b=CSZ/+wL0G6a3y7u6zKFsLbE+XVvzWghgSWXyl5fJcqVaBvIJnyzG+ABF4xjm2WcAwLtbxel7MGHHglhYNcfD/mR9tBabBl47r2fn3woiU60vYaMooNuTRRA7cMMaIIfoOIJVTk+x1CKneSLEWmGSXtHERs5IJTWvVfCyiIMEC2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722151; c=relaxed/simple;
	bh=yj0pYqZJEVUKE8vbBIRlHL50SMANXyZXTflGZlV0qqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJOQTiQTJBxFFDN5yAidfvt6GtGXBO9PLaR7hOf1ErBFz1Tp/CC9xU0Bnkwc2Xtga69rOC6pErb2w90289mPy+3LaeOuFVDSndwoGWoxzdvugI14X0MKvzZXSdYgVuuNd7dgD2TimGFS6JfBndp8KpVxD95wm1mGJcsdhI7MR90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZNzs6Wh/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e4uv6Qfk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1Blr0023930;
	Fri, 28 Feb 2025 05:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OH3OqySjvbaN6pL5QL56wyWK4i67FQaqaDIAB48FV2A=; b=
	ZNzs6Wh/+9B3gavZ1bys8M15IE1z5X4jtPvYdBJ56ke6VU00arnhyLdqi5hHybLC
	Wih7Vp+vXwwR16IN/Pe5BEvnfM6XYDB8hMop/2oOVaC6xOZEqMas6n1qMDsFzeCs
	0wRVUam8WwtotbIy2/c9RDGmQvkUqK0QdxcNY+AwdOM98hqUvzGyE3ZewQWQOL2M
	Q1RL98VkyMjxbnUhqfn1F7jXZqKatoF6qrY1qrw6280XT/7x8Ozku1DlLcV9saSv
	E4+7xF5C7vs1h1Zw0nzp034HL1526JUxmqANAh+DHc8btgy9KaARhR4Xo3S59FiP
	eqUmSj5jL6fChLTcitC8iw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf4udq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S4bF9p002726;
	Fri, 28 Feb 2025 05:55:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ddsxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8hs4Mpav7azbsyjA2/3QII/Awm5gum2WUbTY/flOJwuPYLwtMKQopDHJJBPpNyVQEuoB7jU74Gj7g86NFHfwwZkcYkvJL7YhtAFc2axZ+WxAWtgPSoV9eTLh1Gn6g9EHZ8n1HaXlU9sW6nXh+UCrMmTUwCofrVqBBwJuekbdGzwwzfdDIBjb3q76OpmrkHVn94ur0bpuzl2a9FFiz12JVmTAVWT7fwegqXV937g18cfdouCgBUvA8nxqGpvClY4PvUKavnNKx1aJ/s3FRhQiBZLz/DWVd43FbxcvPE7p9TDd4ecLGjzwBaoUJqJJe/cuiHtd+73MA6nUBOndqzmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH3OqySjvbaN6pL5QL56wyWK4i67FQaqaDIAB48FV2A=;
 b=BNQbK/USAEg3GsJR5bKe0n9EpOehVacwH3RcGqoTmr2NGQN4TyB4m0MR0KHgiA5GuTSGFZHG7bK3sGODqJYOWdSXzdQVfWpClRLH32Fz5WX7DXpplE1qFuzgV4sHrwu+VBVDKF32kTBpDQ0b7fRf3L7Y7HWuc7PhT9X41gC40Wg/oX6f58ZrOjRskORh/5UCbevo5h5M+4rxoAi97I1kkvwOTJSbgmCtCL/SFHXqIOOMtVV/pNRiZTVaWW/CppP63NSGTNFONXEHCVzX/iCIoRInswu2IDmTyFuEIX236mKynxu2FXTLrVjZBA7injNJvuSriVNEZJxFrx/IzAxDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH3OqySjvbaN6pL5QL56wyWK4i67FQaqaDIAB48FV2A=;
 b=e4uv6QfkTwbZyYLfHPC1omnnQEiG8Cn/IKCjB4g82SzMYcUOoYa7C4N/h9GtV5tArs53ujdQ3ZLh7BxNmE0k7w0AhCQXcszGgAL9OVKBWxXpP/Z8A2pGcxrMZoI21z20tiPo/H89+7ZAfbF1oca0bQmHSFW4wYLQ9YXDwmz0+YQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6618.namprd10.prod.outlook.com (2603:10b6:806:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 05:55:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:55:44 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org
Subject: [PATCH v4 2/5] fstests: filter: helper for sysfs error filtering
Date: Fri, 28 Feb 2025 13:55:20 +0800
Message-ID: <c8389fe873ff3cbf68d1f6b5a6df8d6fc0645f9f.1740721626.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1740721626.git.anand.jain@oracle.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7269edb8-abc1-470e-fa41-08dd57bc8a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDoSmvWYJ1l7IQMT8UvJ7uvBC2XWkAv8VQIi4AnGNEYedFm3AjOfZW4up8kV?=
 =?us-ascii?Q?ik7X8G2ENeofaWK95so03v7o6dGofXU2PsJV8KCVjLmCmEtKUWYgrgXDsawD?=
 =?us-ascii?Q?JwXvIMzyHBrjbK681wTjVa2a3PYlBQNAXmGZhOrKnfVQ1/vKVIEtXpJRYKnM?=
 =?us-ascii?Q?fe0QYtTkZCtDbBuFLkmLBcp+hmlGxpn8FxgbY+EqbkDuBiyDWzVm5dX8Ncq0?=
 =?us-ascii?Q?R88WrhvoKVtDQMWbcesNAOP9gjBbm2bSprHZwfcgZG9bqbz6FTUkmug5JhjE?=
 =?us-ascii?Q?JKr7dQ0PK5oSN6jG9AoRzNLO8JXCe5MRUOvijmECDV0kS+uC+wb4EjVFRiZW?=
 =?us-ascii?Q?tu0OLJrlwALqSVe/j6dhX7A80Z92Z9DHUw0voB1RM+evIY8N+h4zW+F+U0ZF?=
 =?us-ascii?Q?kX8RD+gzTJ3/lquZ131QQuy0mdThyGk+p4h3VKWbGb9CSFrjZDydJcs56LbG?=
 =?us-ascii?Q?F5DchUe19s2p02dpUL5yUXXP/KVTUOvTeX++CPZBp5ttKkpqJL3XuTQkKGNb?=
 =?us-ascii?Q?OU3uf8Sk4eeqzHBGYAxKpbiCVKF8JE2UHhZjdn/WWAXcJDa3Wh/h24SHbZMy?=
 =?us-ascii?Q?jvFVuN8btsZNLs4PUAACkqgAGdZZFeL11I8utAZEbBqbR+03De9jJdhIgRW4?=
 =?us-ascii?Q?aIILiQW7RYZ+kBS4op4n0Yw+otRlfG5yy577F6R8lCsdNVkieiy2rPUiI+YA?=
 =?us-ascii?Q?5TimGwOJQFjuYr1h/LpXZiTB4TyUUloLsSCG1952SupIpZ8WuhOLGuXFDK2M?=
 =?us-ascii?Q?Wlpk7CvpJDfa0uEuuVEWRfwfKtnGDjoacphmpNveRHR/GF2jfiRtAvRY3+Bn?=
 =?us-ascii?Q?syFsuY7NWLGl13iYBtthcT2a0CZMJ+wK9Ihvjg5UFPPy6BpcHT34PfXzGjGN?=
 =?us-ascii?Q?Bpx3oi6faBb7YMgCp8iUsS6la3FA6H9afkMreNl4C8nIBRNuHXtTxe0EZ4bg?=
 =?us-ascii?Q?mLaT4VQDDZZJi4LNVscYpnyqbToy53Pta+t259vz6H46JfwqoMaElH4xzX7M?=
 =?us-ascii?Q?yQWVtXpS2slC3KdZVn/b9RtFZOi7w8oL5Wxv7RCarb91CIguJp5zbBaKDWd6?=
 =?us-ascii?Q?0B1380LG73Z35JMDYrEKWy9wjgLTHK+9dsgfJCBhRvj59es5O6xSc5wqof4l?=
 =?us-ascii?Q?3M5Gd+jUZkPyBnZAtU61MRLOnjdlEiUFS3+QKUPyIGdgpaiUbLJ+WCceRLjI?=
 =?us-ascii?Q?nQIqnP3EBLh7OVqJ3r6atx1FM3ag3kGz9WLobgE5rnSVqgiCUGsDGNw3jxzy?=
 =?us-ascii?Q?Cc4wsvDivPLbYZnzrL55ItIf1qTRIv/A0oCG/Q0D2pvy7bFqK75FZgQBfzZA?=
 =?us-ascii?Q?Q3hMId5nkareTK35/T1wSAaYDyyVU/MbhYEinV7Lqa0t0XapsIg742YpdybS?=
 =?us-ascii?Q?3uNocigVPyMCk4j5j3Wuq2yPwzaZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?flkO6SqLQJtPAi2imST1+h/XM7So1zkRIgynjsBcKQfHBot2EnzbhIlbqiwH?=
 =?us-ascii?Q?784iEDtsgRhJMGE1yGhzPpc+8u2CPs1ECReNcgVtxZwJlIi0Q2V+b7sPedF9?=
 =?us-ascii?Q?YuseEClkSI4sErWlHkmXh7CevKPKTxJE/hoDkqQr7zOoI+nJXo1R/kduEVVL?=
 =?us-ascii?Q?XWzCtlWsIEGJWLR39lkdJ7Yv6y1VYbiyThkLY2dun77xHU0HoI5xqlxGe/0o?=
 =?us-ascii?Q?ctP78lVFpL6ju+M7Wavi4ysUqJ30VwqyV98CQRiI8/v0ULOcsT4/pX6ALaYl?=
 =?us-ascii?Q?YEqMmT3EAr1zAsrFO6c1KfgA7fHKzlCNo7orxXuONQLI/BT9rM1Urqis61Tz?=
 =?us-ascii?Q?TnwfqlCRk7aZ7hGn0jpdW2PqCSNOe74iXnFx3P5ZpGKx1mvqdQvqcqIMyCLO?=
 =?us-ascii?Q?o+qKB5uquIyZW/D2E7sliQTKBTKBVqoQRKa6QwG9BiPqYxOPbGbCpO81qM3b?=
 =?us-ascii?Q?mcIeYUlv6OxFgFqpEK0X3+k/hrKAiQM2fXcrCgiGAgNyOYeGv+5bPJzWwIsf?=
 =?us-ascii?Q?dEsexkP7J9ZvPAuse/Mfah7WviZB2Dmd71U+ukeiaUcr0qL3Co1qwdJzHioq?=
 =?us-ascii?Q?SMwU3/NL0tIa3Wb7hvZ5JQF7ASUHTMjUuaw5ApG3XDEZ6IXnJUeNmv2/eekJ?=
 =?us-ascii?Q?JtHaqQ+gZM6ZPZZpYR/WTXkTh+HhAU5Xp/i35r77OHE3QPUtngc8zgTis4CR?=
 =?us-ascii?Q?icNh01q5X7k/NErYB3cGVLaN4tHP9fbd45HyVbKTQ8AZOHXcyHnYUbLmSKDw?=
 =?us-ascii?Q?rgC0TETftEOVwXR5g6IIsnRDXWta7kA5ubz+hHT0jN2x9flbjKqEGyV+/KAT?=
 =?us-ascii?Q?/tfpUAwj2aPNqOpvjF7dnhdb1t2HUyV/0vEnZURSgavtAgBlCaNm+JBG647N?=
 =?us-ascii?Q?QneFx3f0nhaUpegRBssjkjv7XUpEBi+XZASgB4AZKx7Ui2tFS+lnKR5/85k+?=
 =?us-ascii?Q?mq+je1AXHYtJn0UoVUV+sgsMMB5SjeR0yk0gxO6W6hkWpDxQFTTaIy9+q9yC?=
 =?us-ascii?Q?fpnNZ4e6HmESn+XNfA0I/mIk3rHny+LqNuuf3yy/EqbmcI6xbuyt6AbNbDes?=
 =?us-ascii?Q?WF1PJksjhAELkr10Z9RgiqM8/qKjWXeBcQicA7c3XIHInPAw0Bg+lKqRq9RH?=
 =?us-ascii?Q?Bio+qM0lYDE4MAXYBXC7E4Bn4PjwaY4s6NZ1lHiOuKGJeWzcQrr9D0MIdyz8?=
 =?us-ascii?Q?ddZwqRtU/D497v/z2Njrq2vAdjVKLjq6YchbC54UVuKgwUYt2WPQpkyWvwbR?=
 =?us-ascii?Q?+SzADRH2A+9T1J46E2KX64tTfpEVZzXGq2a24u8ByHxqtkZnjOiCyKQGk1yZ?=
 =?us-ascii?Q?lCVmhWL8dH/r/KPjIhhC+t9Q1BXIQxhiRXHDnmtOuPeRBSpJIwxdvxXtSkt8?=
 =?us-ascii?Q?1Vxo++YSfEJmNsZBDa9vMh28ZNZuAf59y3Tj8yEvWPR733lH7y+q5+7V2ASc?=
 =?us-ascii?Q?C3DDMj0tdbTqDjGltAbknYOILhTvbwNkDCZjVDHjTvXsnWFVr/z1+PxcAdHh?=
 =?us-ascii?Q?RP1pXlV4TFlBtbpA5k7Y9ZcfbWFK6A6d4zlI6l6dT8TKI/0gLACVmVtFrlvE?=
 =?us-ascii?Q?q8/fj6a4O80lm/niy4H81yCb7vArRFZySYEGksRG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jeomQtVtbqHDOI7FgpIUCTra61bQ3QuS6f9dOxzH+OkSgExbtKMx73FkjdneKsv/9/SfXLidaTkTznEIGbTexzA6brbBqCHIV1mctgKQ8LtDUi0stqwVJKmdHP5xWkVdnnd1zi/MSljN8RiDEEuOpBavSkkQUXjSBGrLfoNBaSes+1ny+SET/jVq9f3T21Q7K0fjlBNBlcwoOkEr1qm4KX0e+aDPSpwlB2jeT13qvfcAdhFldevLA+l6gu5eHTreMx8606sqXVb3rhB/2Kjt1MX2skcRDZuOXw54ClYuwJxOVbre4kYlm4gQk7mWIaQE0cmXlRB3nPL33E5NGmqWRt/bvPzz2NNkxCeJ/txU7+XbYa/uHg0mF5KpQ3Ybn+8hHxBhQVCb2xxE01Af5asQzL58nsWgRl3DP6PYMlurrklFKr3dYY3XT1v5vwVuJrAWt5M7S5OM2ckc1hWGKzxZnvMN8F76RxJG0KwQvutjytjuOUGJXPiYuJ9kLmPfRDd1ZdsoGFUZuR8J7sU5ztpAiaibgZqc8eHLOlBt1cBflpZfc9UrDYkTb5F+jTMxeXYqLPgWvcZoRZ0x2k3DWAZS4yDwGSNfYoKNTK/4WM55Uto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7269edb8-abc1-470e-fa41-08dd57bc8a7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:55:44.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5IPRzJmh6aZncyPqwj8j1+9Dq3Lb3a5RwI52joj0zANFcQz7n4Xm1fAydkwbzP2AIUvy280PmgrJthLZGHq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280040
X-Proofpoint-ORIG-GUID: klrVUkvoP60yNRQeCuNQ3brDkleuamrG
X-Proofpoint-GUID: klrVUkvoP60yNRQeCuNQ3brDkleuamrG

Added filter helper to filter sysfs write errors, retain only the
error part.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/filter b/common/filter
index 7e02ded377cc..44ba2b38c21d 100644
--- a/common/filter
+++ b/common/filter
@@ -671,5 +671,14 @@ _filter_flakey_EIO()
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


