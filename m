Return-Path: <linux-btrfs+bounces-3413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AAE880017
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FBE1F22963
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4D6651B3;
	Tue, 19 Mar 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nkY55DN9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fs1omo+4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616365F84F
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860307; cv=fail; b=FtUNQj6K5iuvykOf94MUKgsBC8FhBN3pQ02jB3MRX6YvkavrzCVjBx2uYN/B49aKYzikbhTUvLCw+b3HIQ8lxflQVqUP/CqlJXswYYy79fjBcf8O8i7z6lBfarPlST+mr3DuyStCi3iA49Yw/IHPEptHhksXVnQmcAOnNVx8OWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860307; c=relaxed/simple;
	bh=qyg1fjhZlPODkzYFF78otLmfQVvp1o5s+av5ZFRYRI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUcfa4Kb+I5upTau4nt+Z+YXPPoHTKaQb/yW7gxrAAztcrvMrwjW2z/DyBfz6Z9UEdN+jRskb2iyzIYV7+8v2egJHWZhRzuK8arg+aq1oeLzUXBICyJaM6tsO/NydjU9s6Kep9Mg0ruSBJtLv+OrwRf+dP/jjUgmmUMkQYvQLKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nkY55DN9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fs1omo+4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHZV1026423
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=L3bf5a+JA2hK2hVxtFMVHjp8r3WqGHQUrMKdB8/5UxI=;
 b=nkY55DN9lJ6gb4Ej/qNHhkCuiPe9ou74MnM64IOblQIwIX0bFphjp+8U00LNa/zF/TIf
 +DvWJ+/i0w7j2NCZjvwggLRerzLQaEd9XrShzI4anJ1NKT5Y0gk4co7XWxOI2CQtWNUd
 yU7BU5p491UIzJ8fQYCo932sRPvd6mbWCoqj0zNjfRMKRlkP3vq0r+IEzPBt5WPxvIlh
 7Y6N5qSFnsl3v9pKQy5Qqvpk3SjFeaRxK7AOVJPZP2/usFcGx5OhgFYpu08Sy7b136NT
 jKpES4wsjRdE//7k3f4AXq+qiojA5RGa2mRtmMtrlygjvTzB/9qYJhx2GuK4n1hl0Y1w Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272wtvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDoDHR007468
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cp0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IthF4gO93vhm0s9yAj7d76teJc+io6KfSaDuwNa9/db0U2xtOXcLYDDaMjZsYW9hVkfdckAl5D8yg/UR5Te6JphZyJc6ER/9+fkDQIBHSH2d/VBCfYEwYGXCaodFaUWy7mDcY1sIn20C0Vm2uF5xPlI3fHN3l1vI7f8Hn7Q8cI3cDJYrvBjNe71oK9GFXbaVJGEYVv7RDnhJasTpP9FXjEg+NOX9ITWgRvqTsLvMGlYwGRKC8LcOKB+PDp/7LUPWvz5fk4E3Y6bsmUWp3GRSepIwWXiPH5ccM+gr+Jx+Jy3/xG1FaoTsjanM4kzRCG3HP0dTJDMzEwlhx9lpcDhZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3bf5a+JA2hK2hVxtFMVHjp8r3WqGHQUrMKdB8/5UxI=;
 b=lOlT0rvPWz51zlOoXppSZNi8Ucd7OkT1o/JjiTwubfCiAW77OEXLwJsXOu573D7fCrNZCOAjTzUr7O3xxkif83otxguoDjPvh96HhOxwGyDuJImT7URtGvPioZpEV85Q/VpL07nZr+IKi5olPo5yY8XMhrGEsWAwAtobEZaVmEvpGtXscnyFeJz+OVRteqVEV5b/23WEl/0UOoHQzLdchKKRyoh2TiJvm8i9K7q44K2rwphzcKEVnxXBKjJlWEagvvMf4reXq109yDkYW9SxAlGNjldOvy3x+vytHV1AleS5M/hUpKRvPSILLPNEq8GIcs6O2TuJR57JkxUu/mO+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3bf5a+JA2hK2hVxtFMVHjp8r3WqGHQUrMKdB8/5UxI=;
 b=Fs1omo+4rUCv/h213p5d9IxOKMJzzWddgUskNbwdGbrbxqbWF0IXuPg7G32rugKRE7Yd/TY6999abNvxbBVWh8vbdRkUtyKWY3/zIY/yb1D7oR3DIVhYeSQ78pGdL0sZKMJbRil3E4PKuVhY1bQsyE8/rwVTYQmP0smo6oK5jjE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 19 Mar
 2024 14:57:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:59 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 17/29] btrfs: create_reloc_inode rename err to ret
Date: Tue, 19 Mar 2024 20:25:25 +0530
Message-ID: <a0fcb78bd6042ccaa62a15b769cf6b0e6f36bd72.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Mr9kDza589Kz6cSTC22nYdLEhiw7KoUP2chi9Smt7TlqNZk2Gh+zrVU361MYYnfTynL1WV3PhaHjhEBbW05tJe8FmLPvNawDvUxBgzfjZyg5g9gJc1IdQgxFZQzvygggBYWIKEpFjZT9KxdJITQiHBN4o6yADP91Hp9M/sUfl+Ajvvk+zQ7Mh1GWcSdYwaP7FJVcAt7D6FD/AfCkUlrjNOEeJoArpQS0rxStHuJtJzdMKk9RfyXyR8VlCnXtzbFOFRuKWS+EO6xxJVidbTxIytrF1DgP+LYd2JatO5odQ7w+jBgCfI1PJI5Xniocy9jCNnqCbs26ZG+fHenIc0pd2WZ2wgFd1ytZ3I37vcF87GtNkpDNjGCTGQHqToNkI/ktjo1jgVPdu3eofOUt6B3zCBizYsA5jQWQYjh8YmPmTNiiioS4XdLy8i7MqDkB7Vghbu0yQJ4G+RNWkbVLG2aRUJp6GSrVfGx//urbO/EXVVUCw/DufdDN3Ztl3yS6FymLcIdPDrimII7cyKwf4vdQf7WVilJMSTLDqDhW1nObVJDPEG3vT5iTwD0jBrWFhaJRllgvS3N8lsg0Fxh72K+XthGe9EOGg/rtKmwXAgvXWBu24gxmLYiiQT4evZ2yLKPfyoxpbHGPnci5ha1SsbjGiO3iB/9Bz4umEkRTK0hNIYE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RjAMMDLoj/eMiqWCYRtZbUUY5n+g76N/kE5+oPqEreDoKJCdfbg0bT3AMHwI?=
 =?us-ascii?Q?ZKuddoLiaaJfnzMYXunfrpzci+Swg47JcslOa9EMYBPaIMUVv504h7XGEKrg?=
 =?us-ascii?Q?9HoyHNDbS9n1WZ6UPPtAesO0foa7hc1zmbZ8AFUoPS1MRBc/DOuPtehD6+3n?=
 =?us-ascii?Q?fIWqbbjVLpwmH/m1R17LA+feZNTPFGepo5kcme5Js2kjXmFc5heEzMbxlfzp?=
 =?us-ascii?Q?YFiiP+EsMNSIHhoiMCtoC5AHHAFZ+2CXr9ypxAFLJRptMC2vYYtd4+nx1M1B?=
 =?us-ascii?Q?smN3jFkCDdiaxVG5TL3Ikn2mnnSPZfNii/xCJeg+NA33CjzmC9bgJFXHkX0L?=
 =?us-ascii?Q?nud/ZEefDbqWxU2CzRo6CAYoGfI7vnZzq7elsAk1ZOpHeclQE8kcYBXGafwY?=
 =?us-ascii?Q?d6eKEdlv+svMUm8r5sAe5RdjQd9an6NLReCR4RNwHT7wJfxg9IPRk3jrsbqS?=
 =?us-ascii?Q?jDjCOd90Tn+X0I1IOBzA0cj1Fyi2lpiujejdZCPNqUwn+msCoQ5Udh4Qhdli?=
 =?us-ascii?Q?/Qq2TWbMR6qqhwz/n2/5qjv5vx8CDl6mTVumewkWceQtA019b4slFe6YIDPh?=
 =?us-ascii?Q?GZursg1s1uxuvz37S/iAkdyAAUWydCsBXQnCnfYStu5QrQc6oAuXRYnB0CAS?=
 =?us-ascii?Q?dgd+gxvyACQg2pKn0SgY4LyX4I6ttAF9JyEIDpE9ovv+dVYQzkyLdX505sKw?=
 =?us-ascii?Q?gYM+hhs6Il7Cf2ZKbtvoUMLhnHMfyQxL7JFGhrA3PTsnxiP0Uoo1RcZ/TJ2S?=
 =?us-ascii?Q?tlMjAIqaQfhpi1aW6W8We3Lq6qjJUKeoUfibQ8wkgTUS21GApl0o8EXNwRlf?=
 =?us-ascii?Q?ZEEiWdyVVkJbbCc3nMdZo8DOt+gbnxGaJmYyySC8nhQt6N/NFPmudzSPTbah?=
 =?us-ascii?Q?1VrbjIfAg3zCelz7Fz08mnX2/RAORP8Xy+2PRCJ+RXJkbenVl3TFTgeyzOl4?=
 =?us-ascii?Q?CkIM4n/euq2QK12tauDLSMH5ou2koJsNwsS0RP3TKfUhd1J+LRjJbpynudoV?=
 =?us-ascii?Q?TqPFL/9C4kHT5yDdztCGuun0/PZ8M3OoDRuyKbDmz7IbB3fWKIQYBPMxyziG?=
 =?us-ascii?Q?PZZZFe3DK+f5WLsjALXDL7MeSlXxDq3MQXu56mcqJ/MqazXm2+XJQZwHSs7S?=
 =?us-ascii?Q?6/RD4OcSbqLh55tHxQbDqGq2t0aoeep9NvlNHef0kHfk7jBANXBt1MZFXawX?=
 =?us-ascii?Q?42lddAWL+nHPHYQK5v7UW955uXKPb/Lr14LIprpSD2JT67lIgOy0zHXOrUdP?=
 =?us-ascii?Q?YVtYZCLGC2tollcnM3JnyqkTi43/4+Q9BIs1bL5MawUlB1f1tPms/fCRPguk?=
 =?us-ascii?Q?qWb99OKER/IWv3ypcoYKzxaiyULNjpp8sBPjlBmdqz3W67/kjoJUv5je6tvG?=
 =?us-ascii?Q?1nvTZSiZROZkzCyFZyzMVbPc+wzux5g9IBNRf+C1qoWXBJo42SPvJoqD0Q9k?=
 =?us-ascii?Q?W4eNNjFQM7HptnUicU3V+BFswlZ1nZcxsYNWASYUNa/korCvJQ4IIU8Mu4K4?=
 =?us-ascii?Q?iYCIBM1quJCECAExsI8LSCDYb9tMjfUOvU63JDZ4rrVPwPm0dg4ImAM/q7qj?=
 =?us-ascii?Q?wt57wEd04d6I+pYNcfI5+crIkNkohv+d2EwUlRq0WgiQZ1b+4OCHHwRBPt6P?=
 =?us-ascii?Q?CqyBVlfSaw1yRnH9QxVIW971WoWLM0lrQW7tM+RyX3zg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j93k928XVgldhpAJ9eZ5sP2TWOp9sI01jngrAE1yIsEEOiOd/n6B5SH6tiBjr3MbDDKP7NvvZKBNulNmtgGIdXflPkPuXKP5g6ltr1Q4W9lgwtrh6b3Gk1i8xEGpKoAeTr1WR4OvSCWmCX3WymwWnKQ0xqS1fzCl2ieO3n/KnCyorUFaBT+BjpxAGGKgptzt9RDihbwJDa7tf/RR6D2BX3KlIPWvY/zk3FmEwqqbSOGCaLRlrFmLs2VKyy8lROK+p+f0nQoDrCg4VZeVy9cqqBjmZoVGOfR1hJGJ8cOpEsMG8bNxwrrDjCdvFEiNuiMl/J3bpJ0W6HrQullyq782F0c9WT3+Nm34wP4cjT0y5mBoAHURwjuBOm2r23kbdq0VnkHsnoD5kzBL+bWga+33DNwDGdwFSi5i8JB9vdKbg/dDWMZ5hGaNlvGo+GBP/3VBUspTIXjnRED47zr2mHt2fXZGAi/lTM+iMZ/kM7RluLmmxcXgnFMhzO9S89BOeMdlekPHaw7p4hByWFHfKZGI7udm6nh1cN0xn/Y5E0iKRLrZVAu6/iyX0KM7eOBi1Cq1ZGuEjbef/Da1sMQoKPf7KMrq7yYcp+PeS3Nqbv+1IJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da448f04-19cc-404e-6eb5-08dc4824f785
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:59.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJ3D+J+0F6RUsC4Ed1HMEvmoZgiIOTBY39byN6Ad59e1nBv5uuar6+NLqnefBB+o++5d/NhlpRkt+EVHi/0viA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-GUID: WEt1Zf6spa4BxThOzdg6tq87wD4cbT-t
X-Proofpoint-ORIG-GUID: WEt1Zf6spa4BxThOzdg6tq87wD4cbT-t

Coding style fixes: Rename the variable err to ret, as it represents the
return value.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/relocation.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 412d328bfbfd..16a3882a4a7c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3928,7 +3928,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root;
 	u64 objectid;
-	int err = 0;
+	int ret = 0;
 
 	root = btrfs_grab_root(fs_info->data_reloc_root);
 	trans = btrfs_start_transaction(root, 6);
@@ -3937,31 +3937,31 @@ static noinline_for_stack struct inode *create_reloc_inode(
 		return ERR_CAST(trans);
 	}
 
-	err = btrfs_get_free_objectid(root, &objectid);
-	if (err)
+	ret = btrfs_get_free_objectid(root, &objectid);
+	if (ret)
 		goto out;
 
-	err = __insert_orphan_inode(trans, root, objectid);
-	if (err)
+	ret = __insert_orphan_inode(trans, root, objectid);
+	if (ret)
 		goto out;
 
 	inode = btrfs_iget(fs_info->sb, objectid, root);
 	if (IS_ERR(inode)) {
 		delete_orphan_inode(trans, root, objectid);
-		err = PTR_ERR(inode);
+		ret = PTR_ERR(inode);
 		inode = NULL;
 		goto out;
 	}
 	BTRFS_I(inode)->index_cnt = group->start;
 
-	err = btrfs_orphan_add(trans, BTRFS_I(inode));
+	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 out:
 	btrfs_put_root(root);
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
-	if (err) {
+	if (ret) {
 		iput(inode);
-		inode = ERR_PTR(err);
+		inode = ERR_PTR(ret);
 	}
 	return inode;
 }
-- 
2.38.1


