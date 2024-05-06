Return-Path: <linux-btrfs+bounces-4758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF58BC60D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 05:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A41B21727
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EC2FB6;
	Mon,  6 May 2024 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NPan+n/x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PDAkSHmd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF87358A7
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964740; cv=fail; b=n0S38jwsFVQ199heU7z0FInDlJvsog+rv1bz9tr3QrOCjlEYEV8+20XqpVn79gUU/q4iStDeTMJTgPtw+nZqmL+VT2xzj1F+LCaVPVgYOxVVOHOUOGlDxr3hQSDwBBJTRK7YP61jUQQpnMl/JKTjyoT7rd5WTgKE6YAgBoPm1oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964740; c=relaxed/simple;
	bh=G1ayxffO1EeG7EM6mqoV+szrjW+Jv06IsgivRrYe3UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VLP/ZJJWvq+L8s1A3Gvlhqjt1a2ADsLsqEOKHPZWxLllazScTDIVeJ0DlNz+Xqq/csT1AqOXrCilyogNaCAU+oQkGkZxj5UvyEb6HoiXwKM/bpbO8GZnjwuEJSi9ItlY4bCkbp0FwELUj5vWxh28DdH+w6RwAvnYAypC+Wm7GGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NPan+n/x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PDAkSHmd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4460iIQd010853;
	Mon, 6 May 2024 03:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=sVyuAvU+W+T6gmigB8W6VZ/liMKG/Jzgvy2ao123TlE=;
 b=NPan+n/xu03KjH15pjO94fg62Tx2DWDMFPnyTA5bjq3BEJqtIdaN0WVQP0aWUvqFRDsh
 ls0GK91IRCDotAw4DzDdplwx8fXzgfEY+RLhYYt9WR182dXuL8mAIXzaiSnI79uMmD8o
 +062gHlfFp1JBVTKRD5671KjsWjyUnUoWC/thqolUKdwxSwnI0sff2D2O6/uOUpNEj0g
 Fvo8/fAzZWi1lwg42F168tpm5dj3ULwWLk/lLusUIKP+x5g13JQuvciWOm+v7q7l3xQo
 yS+233mHhR3o8qPUpRk8V6qHTh9qFWNgGIZXgOm4x5ouq6Wxq2lHGdI9NvTXK367pgDd jQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbsphx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 445MdITr029234;
	Mon, 6 May 2024 03:05:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfb931x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj4TBp9TLAi62GvuBy3gOQdcTSB45sZJD1DgGUgIwmrH1/mLEn2KnxqrV12GVx0/CqI0MeUEPDjKm3Ua3/4Vm03yzlKTNKl+S1G1xlnVEEltiydiIlO0hlaFRYDhkOjd6fXV288+wAf5ut8PV72LdCFafjiNI7BqQ7toq8lN7xLllJ0MLzH71Wvk6XW8OD6Cp1UV+pW1hxxUSryBQNQ0PWjYNxUYXZDADv9LMBlSXlB3xYuCgZm56nHO1X91n7t5LsAhvtihzOPk+Xek6lie4LDq9Lu7OybiXET4LswbQ+azdvBxoGcOPCYlJaIv/ecomigRJowKPFPd3q+k36t6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVyuAvU+W+T6gmigB8W6VZ/liMKG/Jzgvy2ao123TlE=;
 b=J+SsPrynYLn1ZRa8JPfgdKO85XAWyc8PLZzQx+y0kICP+vOnkn4T1YzV+hC/typQ6ceC074bUM7BbnM2bwsesa2IftKqf2b3wr86gr0+fZNplBdW55RF1l+dXTKzEbSAZN6l3zuiVmEFzCuVcxD6ZZrgtz7SdQCWzVKt4OnVVCpASxS1Av6o/AE6QsVT00Bd8t4rnX8bLTU3yGStN2WD117Uzw580nddrfqwquAI95/j2IbniJvAqOV/bHNuUXVXnI9MIwtSwvxYslYaviBs5BmKV8aBq2Frk2bd8SGwBVpKZ5FRv4mkd/ZXWpitt6mw3qp0V3bdgLzvY/TIHOfrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVyuAvU+W+T6gmigB8W6VZ/liMKG/Jzgvy2ao123TlE=;
 b=PDAkSHmdszqiR1E/7LObkNFO05XrzBxGj55pynOYJg2+DZISgZNjuING8CkcJcUTu0Upv1VWX0jGUoDxMk4pskOA0Lh2JAk3O5u6WgBvzVsQS9gd6ijADcnGSG6Zxz02SizXEss+iNO8GQVx2g+6h0vw8HzfnVSldiATwU4RZMY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 03:05:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 03:05:31 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com, y16267966@gmail.com
Subject: [PATCH v2 2/4] btrfs-progs: convert: struct blk_iterate_data, add ext2-specific file inode pointers
Date: Mon,  6 May 2024 11:04:56 +0800
Message-ID: <b84b93b5359341d710367b1f4e0fe9a7d528dd4f.1714963428.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714963428.git.anand.jain@oracle.com>
References: <cover.1714963428.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f53408b-2a7c-422f-75be-08dc6d79638b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SDoLd/TxhzO/2lSlXZkvCan+QKpCD8XlXqe6TTuL0Li7HNn7nxkO+P01jiRf?=
 =?us-ascii?Q?i38uSLuX+Dso83pLncWeKhhrgOLy7fiUceJl8nPI0XRKDMzOL20iqZ21vax7?=
 =?us-ascii?Q?nAGQqKRiv5wjmryEOARrpV9s6AJ9xR72ujF0Hg1G/qeQY1qmH2K0Nq83Up/C?=
 =?us-ascii?Q?gSKfHF44q8DbCfHsHM/cSsAr2kXh7yZRiI1Cra44ppPt8QR9SkwTKK55RFGH?=
 =?us-ascii?Q?/0okM1DvQB193eQZrDk2uv+sTEKre6h05OQIeG1oTAB1YoqPME8UKy99ZhzT?=
 =?us-ascii?Q?am53LFPP9+AxpJgzvHXul/vJvT6ufFPD1itgRo7wMSTZOgkmPGmRl5BKnilA?=
 =?us-ascii?Q?vTherI0icQ3W0V28CurX6pbi1LNphT/6c2jIM6ZRVm1h9AzWHdQl8uMeTSGo?=
 =?us-ascii?Q?YXdg+DreM5VdDbDDHu3NvKQS0WQdnt/UuXdQdsrfKezP/8D1DYm1G5IyvLss?=
 =?us-ascii?Q?AYDQFi+khx3WAKgr3UfSvVH2LU6/a8dJjOJ9mzfGSypvFGtegbJ+dCaW+Oys?=
 =?us-ascii?Q?B0I+vedScpChWcTGgOU4OpHOL+B6+/HPPgwMpx9prjCLbBoli1Y0Duh6kg7f?=
 =?us-ascii?Q?6abdD1NoiKDk8WhATntcZptLpkz8eYekslvy8AWJNvtS61v5Cin0ztIfg7hl?=
 =?us-ascii?Q?YBBv6Sq8vBzXGu0OCgad7+lFsE2bP7VNnh7M8UlfwU+KauXdXYNkiIgQTO0I?=
 =?us-ascii?Q?a/uCimkOQMA0lJAt9NXU5YxeDfR62gxMZE508FRDnlwmbI/phuCm8oWGBEeK?=
 =?us-ascii?Q?6JnAwoC2wyogjXMXhNohMtEzgOIg9Ww2bPDrp9VvtCNM++MqOPYVt5ApYAbA?=
 =?us-ascii?Q?IpmvzlcBjlcZaCdBd+tb+1WRHv9MfM0OxnmIE1CrOt5WOgYB4OTfO8u2Ij4L?=
 =?us-ascii?Q?RAQU/1/9xMGRmi3rPAaeAENNiA1ZnF50QqqCQOU8JqytkU5aYlmyZqwv49L2?=
 =?us-ascii?Q?OYI9fkG6/WYVtfcPPkrnD3edRHrzeZL1pFXd5oA5eh+izjBsG12L6kzempL8?=
 =?us-ascii?Q?tf4R/DXJUThWMel/8reBk9ESytIeskcUWGsNsNP99O4VeITHnekosYLLRZz4?=
 =?us-ascii?Q?f5q4j5kPIiOEnfSGY02XLOn5npkC5+QpB9yIhIIgEJtrIAapF5l+WW/L2lEK?=
 =?us-ascii?Q?p7eaCIFpOkUc4bE63t3wjc0Eu290U1zIlp8AyODDbgWCDtmb+iWumJOhIVWo?=
 =?us-ascii?Q?u0paMENmcB19Do30aAHziS5US9aa8opFXbzJNs6gTKEVWh66V+IXCRrhOm+j?=
 =?us-ascii?Q?/ZZxva/jPzm8MYMYDZ84/xlhDKKh5nvFSEsGHT6bkw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wvbqpl7rH5ETsG9qTnYZUVwpDDhKxKWosPcN5Iv7WVDmZ7vFQCqBPTsYTBaz?=
 =?us-ascii?Q?CG3ZQABgJf6rnMZ9RlsHGRUO4KqWoTHEBUeUpp+fk3pvRhORiUDIEjf0I4Tn?=
 =?us-ascii?Q?QlpHEUxbkK3JfW6AaiqB0H9oa7JdyzPmQK2ucG0QzFXfJNbHc+8w1iJzIdkm?=
 =?us-ascii?Q?VC9vx9R7iXINg/DMyE1vYDOXPKIoapsK9Iha22AuUGIF6FQdyVDijxS3PcWC?=
 =?us-ascii?Q?xUeUOScN8df7XJikqvz+jHJdfNW4XRfw97iaZ2btXQB39OyAQgdAaSa2uRcm?=
 =?us-ascii?Q?FVOlgpVx/NEHzyICsPHqq0+qYR99XphD7mTpN3WialBTYGk6rZ3oQ6sNEUb8?=
 =?us-ascii?Q?jyojtv1aoxKa46wNzggDP0tfu5Lox511029Hhnp1EZ7TVEvsO/I1tPHhqcvb?=
 =?us-ascii?Q?VWMCN7lGCM6PwdTkADW6IPMRgNQW+Qtpazf3dXR285UIeOrqBz2MTYQXMKlU?=
 =?us-ascii?Q?GIsWE6WAUZMKdw3tFWBOU4kR7nwPIsRAPVx3Xbjvqa0oaSnudeAfpxUHpgBf?=
 =?us-ascii?Q?H+G6SmyggASl1ERy6418hd+1e327JWNqs1ezZutFqAHzsy+FTnXlb8lC8qNC?=
 =?us-ascii?Q?vKKflBmnHyW2FUuLaQK8VPQ5TaFyra8ISjkQA+sBeUZCbMUUXxWTTgZJHrH7?=
 =?us-ascii?Q?2JJ9KOETK/Sms7inwoki6PNXPtWQesepQiMJvnNy6oCEE6Dy/TU8CuN1e9Zt?=
 =?us-ascii?Q?D/e0h+/V/xzvKmTlc8+xz0wdY20Lcc98fYL9o23wZyYLW59acCx/WyNm8Vvp?=
 =?us-ascii?Q?nAlgw9fnX1RqT59qM/PBFR+qV7VCQ+fpoP7khxpdYl9bSc+RrfkgXot6TcTX?=
 =?us-ascii?Q?g1BmHERr6xkAT+LeSNo3iXju5vm0pHArM/98y3s84vV5dq7S/bDI6i18kX1a?=
 =?us-ascii?Q?Vp7OEe/yvz8w9DEsCZVzz34tiAfU2mVvvV60hRjFa6PLCXvgw3BPYBFF1csK?=
 =?us-ascii?Q?GLIIpmPXQth61v6rAvu/DG42Ja1Ut0Jb/4yHVfoQE9O4mReWu/goodiSxqKv?=
 =?us-ascii?Q?+nPzBuFVTumOGgCyzDcCKfBGRRY+JBXSc/jihGqtqqyP5vAxI1pDbea1txis?=
 =?us-ascii?Q?uXSEVnlRr1/AvGEqVt0aPVp6pk5/mhJYpIBZ51erwo2riOIknob9WLmlKOky?=
 =?us-ascii?Q?B8m4thRvygOqEii+Mu2qQNEXRiPe4rSs/olUKXbQVzto5An4mOdf8Jl3jine?=
 =?us-ascii?Q?N0/R602oXKHRSeFCM+S3FJGMv1o2n5MYAkrgGV7PfjY1ZAbjSvNwoF2Y6ELI?=
 =?us-ascii?Q?yQ5KuU1CFTw51+C1h3lnhX9VZ4rNnhVirJUV7iS1CvLpKYslEwrwqsz93vIM?=
 =?us-ascii?Q?buy+W4fsFaLxfB1L8RAFdNaHgEqlE1iiCU0w55cAybuyvcL2jCK2w4XkUyoB?=
 =?us-ascii?Q?LLEzYKeLFCC7ZeG73q/3hhmyc/YeUrWG6mSTTk6DeX4RIDvpVCGj9lLggfwN?=
 =?us-ascii?Q?UgX+x4Osml1bO0/kWyQEjbvQX1M7dVgRSmpAIgAOkceWRp0/SJFOehuUW6gH?=
 =?us-ascii?Q?FAfzBXeOUi1Ab6p5Z0+K8wvl230UMk+tKoto2trlupsFwoD7JpNxTwM/09NF?=
 =?us-ascii?Q?/TeyT8q/V6sC/WA+W0XAAbLUluQ6jcCs3YufWgjAq7+w9pwV/C/YN8EShAJL?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/ZQvk1JvpJqR9KfxsnRPCW3XaBIYAHgdU7Ihnj1/1S1dj7MUl184dfbBip4wnwEA6jRrjQ6Okzxkopep9c2PQVRw8yqxVsjbK9FHT0n/LGGSTF194iaWz+PqVqeBWUpYT6ElRVkHV8FqvfOSe720yMdNINuJ/vmKhx7EdAZK3+tiXekYci+DoOoIArj+QphA68LukztallqbM9G2W9GD58YOIuQLK8SDufMsxYIPXxABFkzb19OgJmy0JC6zSw43iwZtCLR0z8C9IRjhn8YMUD8PSJJNV5eIX4LVBco9sNuOD6BuaGk7mE90SdGrP08LW4pcxK6/Wu67m8D16MB1rl5x6CcXS7aL/1O6oiL3CFNltS7Gdrn5E/IhUsoGhQgC8j/tk4yPl/g4wKiH51FSy4X7FaSPToohvxt1T4QTeUMlxASr63rYK2irG25oBjFifzG3BVQXxSttTI4SIRzN1sD6M8c69+BZOQjRizqK3b7LykwzpMIO95mEScEGKRXcFNXsuWh2HxU6tY/Oa3Ba1JEoOT6/7fBXZl/AKMRri8uguN0Htg+FPQVtbNafPOxXfmD6IsgaIT+bqxIpA2doIylmKtL7wPbWZY32h81U8QM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f53408b-2a7c-422f-75be-08dc6d79638b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:05:31.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6y8JrqmGjlwapFVp5KhK+2Mwm18YDxyq9qJIY7N+XcrmNYg0aQ2xHF+fVve2LIHmywTettwdNfaYQSnjHcI3jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060014
X-Proofpoint-GUID: ukRXuPE7D3qHKDB7Ff8a37rgqo3NNzYZ
X-Proofpoint-ORIG-GUID: ukRXuPE7D3qHKDB7Ff8a37rgqo3NNzYZ

To obtain the file data extent flags, we require the use of ext2 helper
functions, pass these pointer in the 'struct blk_iterate_data'. However,
this struct is a common function across both 'reiserfs' and 'ext4'
filesystems. Since there is no further development on 'convert-reiserfs',
this patch avoids creating a mess which won't be used.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: split struct blk_iterate_data  containing the source private.

 convert/source-ext2.c | 7 +++++++
 convert/source-ext2.h | 6 ++++++
 convert/source-fs.h   | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index a3f61bb01171..477c39d9d658 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -320,10 +320,17 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 	u32 sectorsize = root->fs_info->sectorsize;
 	u64 inode_size = btrfs_stack_inode_size(btrfs_inode);
 	struct blk_iterate_data data;
+	struct ext2_source_fs  source_fs;
 
 	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
 			convert_flags & CONVERT_FLAG_DATACSUM);
 
+	source_fs.ext2_fs = ext2_fs;
+	source_fs.ext2_ino = ext2_ino;
+	source_fs.ext2_inode = ext2_inode;
+
+	data.source_fs = &source_fs;
+
 	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
 				    NULL, ext2_block_iterate_proc, &data);
 	if (err)
diff --git a/convert/source-ext2.h b/convert/source-ext2.h
index d204aac504e7..026a7cad8ac8 100644
--- a/convert/source-ext2.h
+++ b/convert/source-ext2.h
@@ -76,6 +76,12 @@ struct dir_iterate_data {
 	int errcode;
 };
 
+struct ext2_source_fs {
+	ext2_filsys ext2_fs;
+	struct ext2_inode *ext2_inode;
+	ext2_ino_t ext2_ino;
+};
+
 #define EXT2_ACL_VERSION	0x0001
 
 #endif	/* BTRFSCONVERT_EXT2 */
diff --git a/convert/source-fs.h b/convert/source-fs.h
index b26e1842941d..25916c65681b 100644
--- a/convert/source-fs.h
+++ b/convert/source-fs.h
@@ -118,6 +118,8 @@ struct btrfs_convert_operations {
 };
 
 struct blk_iterate_data {
+	void *source_fs;
+
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root;
 	struct btrfs_root *convert_root;
-- 
2.39.3


