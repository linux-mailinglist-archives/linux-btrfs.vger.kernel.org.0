Return-Path: <linux-btrfs+bounces-13932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E94AB4331
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB648C69AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F5F29A9F1;
	Mon, 12 May 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LRfEVs/l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lB43beTL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5029A9C3
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073438; cv=fail; b=cKGQJYVEhiT0sKym/dQq0gbshBeHAiMzIt0yUHp/5JIA1kBzi+xjJ2sfoMW12dH24Jz+83ms0fF5oYZQ22Zw6+Oz8+pgpCHIB35aBlpV6atNzDqLoCPTT7QUe6HTQzg+4yUuNkMdTi+XjW7pfDQh8gubEcKOyCFjFRpVhiPGDMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073438; c=relaxed/simple;
	bh=ie9vms/qEJsBpOqSlT3hiVorWCHPKYTXJUxKVKnve3s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uH+a/eD+TP/DSZUYqnA/N2hSwueRO4njhE89DdimCWhaOSbHXtywBL5CdHAqCuJ4896dIWDAxhYcuQBG26zs9eELwUek4ghZm7C7bHSpy1JQBMBMpe8H66lfP8R9+U0t7LX4HLA4YXmsET5kJ8nMuPiJi0kW+z7WMN0YPKCxRJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LRfEVs/l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lB43beTL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0vQP000576
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gxwIhNCRM4udKFiTQgGTraXgNFpCIIIevWdRK/JqpLs=; b=
	LRfEVs/l44eBzDOwnBK4V6RkzqOt2wrwr2abH0LOAgqhFTEWnmimz5d705a+EDoz
	I/2jr5/BSxSC6bcemwn83ahT9tlkXZn7OGYL1aqU+ejZwNFmRmKhmPkmngaALHWz
	vOciDM8jENLCGcsEPEBBGVctgK3g5SMlcz0++3lIhezm1LPOlJBRzQ0NgAGkR9AF
	JGg5ngmIgJ3uZOo9gWNzbP6xw0vNO6TBJ60IskMKlKcvu42PFi86QrMDXIaMMd5K
	2F4omDWoywzK16faQxztBURTz3jJ0GPCehGnzU5c1IMUvpL+oFi39pPFuFwOq9Md
	bgN5RX9l7raqK5PeDEg/PQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnk6c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH1nME033188
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:34 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010000.outbound.protection.outlook.com [40.93.6.0])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8dq6xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrMSbc3QLJVxY5jRcB6Lu6lku5yZ+RxZKGWVKFfk+P9WC2xGByE4NDM6WQ7RytTt250jv/jAtLzWhImYulxlenBFxTZM07eXChrsF0wstARGb90z5CxW9qgAlbI6MBp53iTkEuuJImcA/oSIW5M/8YuDufX4Cnl7GnzmEItA/KaNoJdUyi4aoekodzp3KV7iHJdsXGZ15ZB7vHS8pLSyC8FtQeMpQu6WKKobFkRl/pZMlgrmnit9fgU/D/gbE18Z4PlLWGiO08VvyzMhDztM2Dv5GuC5Ru3PXB6OXHoQckPDlc2vKGdLOWSQogABlKqA2LTW3BVRka7HbHb/U374og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxwIhNCRM4udKFiTQgGTraXgNFpCIIIevWdRK/JqpLs=;
 b=BTugW7t4D5l6K8zTCfkZq6CAATQcV2Wg4npQU2y/nKTKcF0AETzOmY3LxTRldtquv2G5btRqYR17lsqHPWBa0vGpqWDp3VECVVd/GKheXuslBRKA7p8VrOqkWvfFCgV0GtiekWZl6pRYeol3OHQQPMO3nYuRzP16278ttOKxcxROtxjM8Wtx1ShyzvsvbH7GiO6yzZ+AJahgUlJxP+/EDWXMysPZTV7yB42EFoqqTIF6nX+3HPSqTcMCDyM+YvzWhBSgTOPLe1AoayAAW0pirYPfIaujOpm7ipeyV7L1SsrS+FY5G7ckhalAPGMQf9rz/EfnRFVVIXzZxheJYjdmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxwIhNCRM4udKFiTQgGTraXgNFpCIIIevWdRK/JqpLs=;
 b=lB43beTL+s+9/r3V60opDGxbbpVOwHyu1dT4/STm/8ACQBZTtkewVTkKIut1SK6Qw8QOhiCLk+WNI1/xf5Bx4inY7YWktLO7eXfwTmFXRMATsvS7nmJHVGrYPAXCvNFaZvGJaZWLJEk9NnczKazJk7Bc8T4XB6d1gcZxgAeoxhg=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:32 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:32 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/14] btrfs-progs: mkfs: prepare to merge duplicate if-else blocks
Date: Tue, 13 May 2025 02:09:21 +0800
Message-ID: <86d730d00e0433ec3ac0d9824b86f2ffd8ac8425.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa76556-0fc4-4b5b-743f-08dd918048e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qaOsbnB6IAT5TEyho99jNCyJjJblhFIYiXZHMbSqQlHO7hygZrS0ARuasZZ?=
 =?us-ascii?Q?ZYIAprU7noPesaWcyG8vn0VGnFq+yJVWYOEmzSmqWj8ZP8gi5eq4iSJeE9K6?=
 =?us-ascii?Q?GQ961wvgyrSCOePtyTYNkT2gZqe7Hz6/YcKL3A8CuT/ywkG6vK9XMfzNg7Yv?=
 =?us-ascii?Q?eR2r8zdSSpyhcwPhO2k760tm970HauAYXk/TnUq6LddtTC20PgEHH6wQl8B1?=
 =?us-ascii?Q?nd31G+fRVYzJP66m8r9A/zI7N9LvjbSuaAeDZduhsmLn+hBC1bv/+g4wYYTa?=
 =?us-ascii?Q?6LeDUFJGPES+6L+t55yOV9JfDusZ5FwM3w7mBen30lsy5pK717ShLZYZeAfT?=
 =?us-ascii?Q?eELWnajELbWz2bLv9L8+SqmpBKuAux9j9PHlH7KLtTCsT9TMrh9sOpHhk8a8?=
 =?us-ascii?Q?GHJGEsYYIBj9THRomxBFJXmMU8uT5pCe15+CpQwCEg+2RPMK9Wm4gjdQxtO9?=
 =?us-ascii?Q?BOpcLk9+ony7G41JSVFmUzQ+msN4LijoOKBPHK4fIa+F82wf9wr1rPIy9Y2g?=
 =?us-ascii?Q?bEQTMwdrlGOPRYZOfF2ZeNNCxAA6kOufnB0aUuOqJkbC3lug8DHsPcSO7p8g?=
 =?us-ascii?Q?87x2ReTCvYxijDkvZNf8kTicgbKCcI3dA7T4C1QTaGne6kgnEp8/lc3Yc//+?=
 =?us-ascii?Q?VtIBeZv5HVjww/UBPes9//Ff6QmABpGdGC5nlSFuIyegKa2HIDtuMOICA5kw?=
 =?us-ascii?Q?7A6QG/Y3wExpIOsd1DeztCq11BeYN4C6LVK530hBIINYwPlWtcUOXCV7pEph?=
 =?us-ascii?Q?xgmZxE2Ftr/FR/cGzUyL0ackMxy+zX+kQBP6AP8RNMcgFcXH5jk6GvRNpbRp?=
 =?us-ascii?Q?WNtnZgf7ebq7hwv6kHjOGxHACn9OMuJi5RGK5P/vCYM7Bff127I0AG7L4WWF?=
 =?us-ascii?Q?0Bc2xhTBRT7/fWz/Wq5vO3CgCRaCe6E97dc9eNrYHuJ2EVd1r+pYSQaeu1C0?=
 =?us-ascii?Q?Q9/7mEuZI2/TQ8Min2SWiYDnzY0JDhcGF7S8mAi6l0K8pSTBz928Yyaery/k?=
 =?us-ascii?Q?27WSOZviWz/mCmb7O5BFMWxVEU77M5RTw8t6iJghoCtTWlpbe+Zvp0VSpdGT?=
 =?us-ascii?Q?iVXKK0ExZu1JoabicyI8NC3hZCE56Y4P97253zWqjXMvT7yXLUyEgK/zIf//?=
 =?us-ascii?Q?7T2yMMRd6dDpW/2PCtLVq6DJiQTzZ41u5jB79lDwl+FWhh8a2D0scQ3N/aIy?=
 =?us-ascii?Q?zhmQKXRVbr9Hbo+anohomJ0qgxwTboV79oresZ4q/3cGCPBr0sVbd1AXaoOS?=
 =?us-ascii?Q?+pRyH+Q3v/dvD1CmGPGcJCvsKSBN8Tpzj8LLNbn0O8FpibsZGTElwqdQsQDy?=
 =?us-ascii?Q?IMrbiOMN+61/TV4l4NF0Wed8A8ODQKXOXZaU2E62DGCv+tP1UunbDMPwsHXx?=
 =?us-ascii?Q?pnpfkzqlqOlu6S7jNEcBuqaGZXMF/uJRwveM0LFsv8q8xXztgjLp3eZyL+du?=
 =?us-ascii?Q?Ijj42Nilc68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wARHnPrXLvbT8Wxb6M4Dwc75F+q3TVT88r4WM7CadGxvwCBNSTTQ4Vhf5Zqw?=
 =?us-ascii?Q?OmJW86ZbenW7WjHLkpr3YaOkuM8dYslEBwCCO3+mcE9FWMnvwC52tL18+3BS?=
 =?us-ascii?Q?yQ64whLMgJAkDYq0MvEWMHhZyGD7nSmg9xGW20nFbYvCoP5KyT8WFZC2lC3e?=
 =?us-ascii?Q?OjMXkFPjtRAVIaf/3BbW1zaWSUlyRqquGOssHDizpdHCNhWA7wziLs6kVTB5?=
 =?us-ascii?Q?9lYZ5s92ESGfp8UJxtn3Ythu3aLvRzbO0Hgzw/55z1c4ER89pK8pCcIS0mPq?=
 =?us-ascii?Q?p4UYHz/7FjIj2ZbVqmihHeyNJvEH3dbo39xOhwvAFtqtTZSFL8ozH0e5uoce?=
 =?us-ascii?Q?l9mVssjZ5fDhHqXO/3ZujOIP7b4eU47/HUTx8K3IDf74sFq4tbaNlM32aXfR?=
 =?us-ascii?Q?98ck5VL3UPFqwr0Vu1RN47hsX33PlwaGhnyegcAzXa4p+aJGNhAok9qyAOF8?=
 =?us-ascii?Q?lKSVuhd9gZ9SJ0tO/HbVYcQm+w1CqhKdO5XfrX0u8atVA4KG6CuP4x0PADRX?=
 =?us-ascii?Q?2/fMo+HxSvUUJjO/ElmbhX7hgsTbaca+V++eCEHFPB5CQBFcsdh0uyp2AojF?=
 =?us-ascii?Q?sefMovgQZdA/8AoiNS19SCW6N9wt4B0BmKd77nKUsiPed7a7nit7lAeHTTAo?=
 =?us-ascii?Q?hOntuOrNs9s9yT/6LCRBvvq48qXYegP7XCpRy0mEc3QPJchk4wEmHljjkJ7f?=
 =?us-ascii?Q?/jCt81A4pvAjyiKOlYeD/UGpYBLDhZaCSJqz8RRMsMy7kXWykN3zS0+PCsVS?=
 =?us-ascii?Q?OS4s6zbxQaMRDDh+J8cZV+us4W5mxnZOzcTLqB4mXghoM5kWsAyd6N5alvnb?=
 =?us-ascii?Q?cWwXJxpGvhEc4JJrPp7Nr2EFrDwITVt8G6T4aujbAXB+Hs7R8nqZfSahxuII?=
 =?us-ascii?Q?czjms0jZd/+BkCUz/v4wRi0B4mdPobxB4IJFFLaX0oRDC5hqte1EjwFVLvIC?=
 =?us-ascii?Q?lFYaLiLYCDW375IYU27pCbSjnnrjd0uMb4Lsu3FiCaW+ykWIgmv/ilh7Enel?=
 =?us-ascii?Q?SkFhbUrjDPWwQb6wWJCFVoLr6vDz07OSPN+r9RV32l/dNv19M+jstoYS/SAa?=
 =?us-ascii?Q?mvaCVdR6tI8vBaNR1UJkpPZk3HQuGWWvJtQDdYXU+7sYOwfMHpLn916cADXx?=
 =?us-ascii?Q?KRJxE4Aw9NdT1OkOHi/ELXDXN9k8BEWrzk35kwIkUKOeoEhUPyQlOA4FyyJ4?=
 =?us-ascii?Q?0Kv0YYHfNwgPXt4LzzxVQSuvXO8YzJr+qh/EFzzPe4T/DvDs9lGfxXwF05td?=
 =?us-ascii?Q?8vbtldT5zi4kX0Y5H6M/Fd6g7VwlJJjNic4PR1F/W2f8ZZdxUx18wfXrfXMu?=
 =?us-ascii?Q?6HNtyl33I01aBkh48Li1eQbsemobzrDw/hl2wZ26/3W5O11CILTXdA+BfKVk?=
 =?us-ascii?Q?NiVIXFNjey9pf5pqDhqEir8frOok2EzwIj+igz/gvbjWmHwbLU9pnDjnkn02?=
 =?us-ascii?Q?ReiNFlhsiHeXWz/NB6PtBYV86VQmQVxoyYt1X27zZxd7X3dhQ59tKndrweCB?=
 =?us-ascii?Q?79e185zoYx+RwzSKjK9VUjY/7HHbm+fcVNWm3y9KpM0pXd47ta6DhZJbkSfJ?=
 =?us-ascii?Q?0lkGnRMcNY6yDqHhdd6X5T/FyJrJPMoEMVfopo5I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XF55C4vTpMbe5SlJow3ziXYPV086fgiW4eGJ9mQKL313ewCI9eOphDega8WWi0e9PzPzw8kf7wq1rZxPGHg7HPZdYhZXckJPjPVw7X9AiSPtJRCkKi1RsoD0qJO/JKW48j3iqHg6d1VTefWGYiqCGjyQziANBnOb9/YAGOTdu2uUAI9uLk0w82bRwMD1OkpTRc3Tdi79QRst3EUAzcvv6hA0c88DitDlnm6ONjelrYMYlxF43/hxCq2/wxpzXAPCU2LvK4bWy6+sP8jehkswY7zskhESgzJZl5ZoeXEFj13PsJt1V0mY9+JpTnGS6QhwJfm5f+xbDdXMhPzmVB7yneEnULZ+zvfJWVMUirofpJSfEWBVBw7FWOixyCier40aXvSKkKlWe/HcATAvw5yVClf3SCm3WjJ9Hbq2/+hN3E7rALeDLxJp+36KM5WckSznkg8Dl/NMwt7xNn7aT5UV0M/h5E2D3zX5yhjkr/xtvwFQRi20eiY7gUVOrdnn7Jt9zstmY0b8FLgUzay9HArGpkecFVrynKvhH/VUXGnyw9iREiSwxvqXIYhbKizqdZV1BKOUNIf4ao4JVzTjHl9tbC6tsCq8GGcoC/kvxB/W12g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa76556-0fc4-4b5b-743f-08dd918048e9
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:32.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VXI9Qp/MRtJIAnavZfOlkBzBE1xtf7tfUlvWab/xWwjJy9BdpshdkTqQRFL6w+nDa20YAnetkgerMGK3syZLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-GUID: xMcZMHYg8TVyTmdn4lvvwZoSHcrUrsvP
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=6822399b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GfCJzzh0PhO8nb1OolQA:9 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX23rI7eDVXeeY WDIecc7HSZBNvIqftZ7ONIOOtHX3FwSIQbVMNYCU81dzNLuXoOJPeypTZDlUWbGSPvfZYeqxh9F 5PxgIXP45VpH5aWbVQ7ijylv++EALfCB6wjCLtYQayaOOYFjL7VhysNxAe3gblZoEfEjbjZuQbj
 ImlWEscOwhDMxzFCOVTObSe8ETCcwyWzgxKgtEWD+AzPt2IeBcMPkGIR7U3AwAnHrN8CgisFeyX rhlwcaExO5wFzTw5qH92rNRIUH3Ic+RCEB5vZd28XcDaUOYI3BV26CfH41waSH+AN/0O0KtapBH xt0H5yHyUq7AbkKctj3w+RvGkVLocnHkhawRzBx7/4bDbOKzgx3hcNSQc/GN1OEwsGpR79sf552
 YTHOwKmCvjvPq6DAEQGzbYDpTzuTvkcrt2N6naUSIld2haYLdtkfa8QwmYeYeKF+SQ28Lhx1
X-Proofpoint-ORIG-GUID: xMcZMHYg8TVyTmdn4lvvwZoSHcrUrsvP

In create_metadata_block_groups(), move the line

   allocation->metadata += chunk_size;

to after the function's error return check. This aligns it with the
if-block and enables the merging of the if-else blocks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 mkfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index b23d0a6f092d..48aa57f23d5f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -157,9 +157,9 @@ static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
 		ret = btrfs_make_block_group(trans, fs_info, 0,
 					     BTRFS_BLOCK_GROUP_METADATA,
 					     chunk_start, chunk_size);
-		allocation->metadata += chunk_size;
 		if (ret)
 			return ret;
+		allocation->metadata += chunk_size;
 	}
 
 	root->fs_info->system_allocs = 0;
-- 
2.49.0


