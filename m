Return-Path: <linux-btrfs+bounces-5038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2DC8C7502
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D0FB2562F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE48114535E;
	Thu, 16 May 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWLYo72Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cSJUBhDY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC4145353
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857978; cv=fail; b=kThKy25HPF677NmpiY0CdXI5iK2Xc4eBH9RVYvw+HpDO0taGvlFaNn0S7PG0ae9NthDxllrnHZ9zWg7sIB3iYN0SBsaWh1uqU0y53MRwP5MGmRkvbOEU88HDMai8F6k1RsA/ZJxPKsMu/E/+z2KleDqSW1m+xEpKrxGrMyi2HUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857978; c=relaxed/simple;
	bh=eCj19SJuaOBHItmWrrkRh6hvy67hBulDPU9rCVz1z80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NrPDhjxbYtHv41c9tTvZFYzMv97oIJ3d3QHCs1T9psdhdWkpmNov+mht9cp3++TgZzrDwZkzIFbR4sR95bgsYk8qJA+GSIDSlcZH4/cgvfmj1qKShmMe67EYTvou0NgRbQNEg9milOoRPuXHoeRNCYVRYnih1MpYCXOMDhtX8RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HWLYo72Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cSJUBhDY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GAAA1G026846
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Lh0GYKevP2ycccKAIrR9+uFE+GA3IFgHH0K8Jp7FTuQ=;
 b=HWLYo72QTMwdDJLU+Z6maJeAcQAg2mtqQ9zEPIUH+mGckbEI/mqJ/f+YRYFmogT8Q9lH
 It51VBWqO3BW8svjQXUefEYjjjfN7xoyaR/vpVe5XNxTqiiLCMtOBKFC4dw740J/5ydr
 gdMutSDLONKWCZCeiIs+XvPnjcC0E3bL5magz4cGIRAcZ84BJURKsM/pzSwOyvrmIFA2
 IhAMLpKMA/XDNdQWUOp+Ixp6CYgTcq4CUizCeu1S4HzqUci7JkV7+pMLggMaF/Qr2Sc+
 14877ZB/y7aBXAFostEi9lSwOBC+tXgP4qZSWW8ZjgCs3yXdhF5zJ99veK5D5bPGvwEX VQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4rw89e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44G9Tfkk019298
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r87m0ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD5aVslG9H43qmsPddQdH8bGBC1YpPYeLLh6u3j8lJdOeWY11IQOuQbF0XepK5Y5v7SZ3aOu2PksVUUyFrHX/Yq8A0SLIyr+mfQ6mLDlmJ5XK0MLqLMKpy7vO972wB7iyfhZe7gIroSXIwYq2bNcgzsfL+yu2WWmMmEKevaaiZl+LzQvmKJfdvQw3AMi1pGAOnFuq1hDuK9ptpotp2ZMUS/PRGRYAPlw3Yxsmi2pBtfXG8Ctht3sI0DhUfhwx5R1SDrXjtK4bjA6/3iAeQaHQ4C06Kd4O/KNdOknd4ae+MATA3viufXmoFvUQTbzbTYSo2J4hGIxTLK3WUfEAIxwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh0GYKevP2ycccKAIrR9+uFE+GA3IFgHH0K8Jp7FTuQ=;
 b=kbngatzF9vUKCBfABvn/GBkfymMyhm3nu6013hwh9hbb8yMbvjm4/lgkAMoU8pzUTj57V/rImLIUW0Uk5dR3ZlowceL1Yh+ChksAtMQOHoXkcQAhDqv0fdu0D6yjL6Uz/0YcX1CFgv9WWh/jZlWXkys1JsQgNhAR5R2ITVecBA2ixKF3gAkDF2keGv9LAByOa0Tss0UzGAhXtHzLlhZR67WEhY2peKqrZeiGzmMAWBNhh//BH/+wP2ENVVkRSEvPQTcP9MGx34BhFeAdTi0BrjGgHf5Z3prFFkDh1cLoPfaI14VlggZPqdmfJNaZXXh916MNycIXbSVqxNL+apHFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh0GYKevP2ycccKAIrR9+uFE+GA3IFgHH0K8Jp7FTuQ=;
 b=cSJUBhDYCSpimDI0IfvyugtUceEEYj+Ti7Ap816mqFr6R5wDiWGQDVyb9xXQ/feSYrC6grUqCRedQbYFCeXhsSxuT3kAgGgCsT8Hylha5lrvhpoavCWTn4LUsUzZFnl6IuylsCcjb+DFXHERM+ZY5m2mqbX02zVYO6i6JJyGJ+A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4345.namprd10.prod.outlook.com (2603:10b6:5:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 11:12:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 11:12:50 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 2/6] btrfs: simplify ret in btrfs_recover_relocation
Date: Thu, 16 May 2024 19:12:11 +0800
Message-ID: <fc09db478c858a59d90b49c26cb463bdafd1a5ed.1715783315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1715783315.git.anand.jain@oracle.com>
References: <cover.1715783315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: e17c40f4-ee4a-40ad-411e-08dc75991fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yXKJcu6+0i4B7ZQnAhoCvvfA1HgtuDYIMrUyHBkWNqbn66hxrkdmrFjD7NuL?=
 =?us-ascii?Q?MOMG1UP3hGSn9Z7dk6a8UY4imxZGJxOfO4DCVFeiRsgalnI1CjFpaqPh2rep?=
 =?us-ascii?Q?YJdlwiemFp37EccsBtu+OaOxjp6C+HyAVf8XAdwSTXq8/HH2T/NTnBRWN0Um?=
 =?us-ascii?Q?7dewMwAphAwAxeenKPmCtu+QYMkjfdhGPIimsVpVQi/BXvnPruJa7BN2gMxE?=
 =?us-ascii?Q?c63CaRmFNd06FYdQR4IEsbj6WwV0HaFd/Qq+L4As6X//Rxs1E49QHgmM5x4j?=
 =?us-ascii?Q?XzTC0sVlAJGG4NgNiopLW4FLFrPafWvmef+iEJCT2QfaN+b1/VqM+kbGsnBj?=
 =?us-ascii?Q?oqpLlsoGl5vYfGuYLgaA0qXO5XwdjMGR29hkEi5O7tlUD5md2bRRji6WtQKG?=
 =?us-ascii?Q?/HkFKQIMhtGz0xoK/Pt6hznBUoYd3Hg15l/Bm8oXKUlc7Bqj8B2dNmPXw9yc?=
 =?us-ascii?Q?kVTPPWv5rEWKfp05EwwM4r6OCzS3ABivmkw8fc3v5/uQrbwsGBfWgS7DmtFe?=
 =?us-ascii?Q?r3q/bBI/160JZxxxlZOZsZbtI5PNG2tJsaL2o3YbaBGsidiYTMp8wEWPpUlK?=
 =?us-ascii?Q?y6Gh4PLRw1vSq92vsiZGdnWL7IUlY4b+JG3KP4J4eoF1yXgq/b5cYPpiJLF/?=
 =?us-ascii?Q?Xrd6+QU7jykJgY62f+UMfyGrKDK7O2XLflEfClpmd7lMXWHNziekCIIkeM+5?=
 =?us-ascii?Q?eWbOgfs65QNqgzxTsdvhohTSGsLgl8Pd8ue8Lj2UJTN3k4EQWf5RhBO8BEcF?=
 =?us-ascii?Q?vmvH+RmgHNYfw1XMWWgNeCGECi0Lr2iRlsEBCmqIuEiuLJt3/REHfO/XBRwE?=
 =?us-ascii?Q?QeYOvbJwFh9QRyvOts+pTyLEYzINhPjH6bi0Bmu95ocN8Jam+WqPj/4HSZ8B?=
 =?us-ascii?Q?3xSdERtnLxjSMHxlg2S60uptJ0mn99Xpo1l9FPGfFzIjaceWB2lCGJec1HB7?=
 =?us-ascii?Q?WjuYOIq1dq8BDcQpBqvujHJ6DYP04ioZGV6Q64jZ4KHFl7ZPOizEyEk/oKRR?=
 =?us-ascii?Q?VQXu59/ar3ybqEmeWPcrOWcyeyixNDMHzUi+X9DDRsfrcn/NDTj39/44g7o+?=
 =?us-ascii?Q?2kA9MePMzMVp0oLC9RaigoCoep7ewPyJaD/BFgMKIrtZuM928uvayxqSDPhL?=
 =?us-ascii?Q?x1uLzNH6R39v6HLkztFwmr6VNxTsuM+L1tJ2yjbjCAP7xIVD8t1QOsBtj+NR?=
 =?us-ascii?Q?a5qfPCy/j7bkcHwx+X4TmFhDBxsTxAoxi06jrQ1ZO7FU1+tuLYTtqCPaIk+k?=
 =?us-ascii?Q?EnNeI2WD5XMna7LDfr7KeFo8uV8b0bdwEKCg9u/+EA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MQN6LK3IBVYuOC6OZkqUomrG/Qn4m5UX46uQBRhyGvB0DRXJqIdZRechpWFc?=
 =?us-ascii?Q?FbWhDlyEzwwAkq0YlM2nPl3TP5lkiAuKb69WlZsYvmF+RD2tpI4jfSSwq3z2?=
 =?us-ascii?Q?Cko7YUwZB+DzHGUl+agO1bDVbygmgYnqSy+Z40jkTEqvIzkAPnfrAha40giH?=
 =?us-ascii?Q?G95qnWin0mVMiIP6FOBZ4AnJIejF5HferI7GdHuCqXaUqzuiVrIq7ATrZcDH?=
 =?us-ascii?Q?3Z5GIpASLRzM44Ovi4GsBMzKS+0UK/GF4dsdHppIilV1I/Ca1jLcR23G/eii?=
 =?us-ascii?Q?VlZ1M74lfc+YuiqOasFZ1euWIyn9Wt/EM0UEIXZWoeUHFnXheIrYU+YsnDTB?=
 =?us-ascii?Q?UWX4pR/j6JV+/TPrwz18Gc2FkRFJfe7KjISQOAcQNsWdvmFApDUtxQoD/Vj5?=
 =?us-ascii?Q?c1+i122HD9umn/RtVXBQEvBRs1tIXx6b+quLl0lmm/bWFG5BljyclFQMivhP?=
 =?us-ascii?Q?sBUfaYFrl61hLtNuH/Lxw5ng3YapTDdPlK7ALhwtcAOkft8DSvEIFJP09H7m?=
 =?us-ascii?Q?ILPXTJrNG7MxdLYsZCBlYkl1PDmIu31KKcSSsN4TopCq/fRa5ZFmBOQt3TjX?=
 =?us-ascii?Q?i7I24SeO4GlR2YKhOm/cbLWsR1X6TOwY5x5iPwdDryz1RtjU8G6vOLbxvPRI?=
 =?us-ascii?Q?TNR5t8h7s/mAHzkhMTwCAUKDIHn3t0Dd1Zn34ba5TFm/m3vFf1dJmIMHs06G?=
 =?us-ascii?Q?xOPUM2S1pGkeCTJgUczKJa9IkYqe4I6gxXPOs2fKnCfCih/LCbK3SUjLx/Bp?=
 =?us-ascii?Q?YAHCJnxp0H8AmovNSE+aUMOSZTp+/FHBAbGYhzBI1UbMAlOlBwaK2ukQnvwA?=
 =?us-ascii?Q?b1egUiT7nA/FGY4OmotvdmBCDR3NSuYxvFiCtDDSYHussIIXXNxM/E+kr64q?=
 =?us-ascii?Q?0Zjqm+A8FHr42CMvGAV1WkW1mF6JKip8wGrFL8zsNZXMKXG8CMZXv0s79mzK?=
 =?us-ascii?Q?jcXYh26eeQEaDXvGuJJV76dff7prMgrJ9X29TSauaIon8sZNb90c8+vaWD/f?=
 =?us-ascii?Q?qLKkrCpmiYwtHH3hvy7M7FEaFEYRqkU6TBJRgP8KX8DFIFv8fTDh2IPBwf03?=
 =?us-ascii?Q?hfcOsjRMzODZCfYDGrDSpIkWzmMIP08xdNPQaHO7zkEi9/KVP7Z+/yYf5vuz?=
 =?us-ascii?Q?4+R0oSSeluxVH3UGuhHbZr3esgQy/tMsGU0agGN6iEfnLvoPMLSJ+LSTHDr9?=
 =?us-ascii?Q?R/ZTek8uVZ1lxhMpHR4lx9eSNVZdS0vcodmpesN8z7xWGHgPNwg1/K6aToeJ?=
 =?us-ascii?Q?e1WeX0K13m7WH0+HENq4FCyEH8dynF2aWBzWo5Iaka2EqIAozEW7/bRqwt48?=
 =?us-ascii?Q?c2De5Ja0RNcDxa3ufRzTRW0jQBQtxRmTEe51M8c62bENmOXZOrblTwkKdq7G?=
 =?us-ascii?Q?ldudE/l93IVBLGr/rA+FPRVzMVuxCPNd4iZjqobyXzg9Ckqb36h2CF9PLoX7?=
 =?us-ascii?Q?tyKzvIOtkNIfNDig0KHe5+IrJSrUcSrJ7SdE/Ud26Eqn7/G7YswY3YbGKeRN?=
 =?us-ascii?Q?yF95mPAP2ymUC1fmjmr86RBXGVnEPdMgfbICpU0i67aCNKi6nSIjKQgOKLY6?=
 =?us-ascii?Q?1PMql7da2maCTSIo5OXwR0DXJNFPUXLHGTWk/dXxxeeG4hGFWtxOLfUYyfsM?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i8epX7OaIeTt5agNVpU81vhef/p/oiB1GEb+8bmmgC6MHJQAWMe96NzxaFJ/q/6C3i9zxKF3ciSQFtApycHc0TXG0/l+bd5mbK5G56YIXK1IOmOp9PO3kvOWxK0zFf1mKooP0PquZVs0+/fm7cI3dbDgzYnq2aqU5KMqZ0mYA0V6YlOJL2WIqJqG3+pcvF8++scqGe1ZseXkKiCR0FJuxY9G2R5uHIVzAdSeEfDfu1BlxcQoknAi6BaFYT+f4E075iy7LGHBxLeCULHZarMuJINl7pWN/A5WBRrq6RUt1rL/Q/gn+hYcz6SAgmsT8wDtT2PveHotES33gM4GouaZzlDNmB9lL9pnOvCBWdTGC8avIc/iqDBV3DQ9WqZQptbXK1SnEek1J/a2KlQGvrVeEg85lqvYLBs1X1Ef+QJ3T2gEcYv6TVcG2GGXYphikRlvGc8zST7yu8k9APn73glOhYaPkeKAdgtO/Nde6WLIcMTOCUnv49MKLrYRCraiYh5oln+pxKh+TKmcNSnHRLH4Ow9QvpMafIM/k6Gr8Lx6n59PNHkwVn6teGQK+gQZJOrMmNmKwjBu1fIw67YrRLnfz6Wg0BwZjEmi5B8l6NA6t4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17c40f4-ee4a-40ad-411e-08dc75991fcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:12:50.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXG1ZkURI768Nn/qJG3L4UfNcCKRFQaGpa7Qi6ep0qj3IvrXQzu6vxMqJ0XT74NkOLKwnJAHdJNK5LPKBHfEuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_05,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160080
X-Proofpoint-GUID: edDdmVRtRRbIkOnuZnRXaK9S5_RaWB3D
X-Proofpoint-ORIG-GUID: edDdmVRtRRbIkOnuZnRXaK9S5_RaWB3D

In the function btrfs_recover_relocation(), currently the variable 'err'
carries the return value and 'ret' holds the intermediary return value.
However, in some lines, we don't need this two-step approach; we can
directly use 'err'. So, optimize them, which requires reinitializing 'err'
to zero at two locations.

This is a preparatory patch to fix the code style by renaming 'err'
to 'ret'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: splits optimization part from the rename part.

 fs/btrfs/relocation.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8b24bb5a0aa1..bfcecf6701a0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4234,17 +4234,16 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
+		err = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		if (err < 0)
 			goto out;
-		}
-		if (ret > 0) {
+		if (err > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
 		}
+		err = 0;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		btrfs_release_path(path);
@@ -4266,16 +4265,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			fs_root = btrfs_get_fs_root(fs_info,
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
-				ret = PTR_ERR(fs_root);
-				if (ret != -ENOENT) {
-					err = ret;
+				err = PTR_ERR(fs_root);
+				if (err != -ENOENT)
 					goto out;
-				}
-				ret = mark_garbage_root(reloc_root);
-				if (ret < 0) {
-					err = ret;
+				err = mark_garbage_root(reloc_root);
+				if (err < 0)
 					goto out;
-				}
+				err = 0;
 			} else {
 				btrfs_put_root(fs_root);
 			}
@@ -4297,11 +4293,9 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
-	ret = reloc_chunk_start(fs_info);
-	if (ret < 0) {
-		err = ret;
+	err = reloc_chunk_start(fs_info);
+	if (err < 0)
 		goto out_end;
-	}
 
 	rc->extent_root = btrfs_extent_root(fs_info, 0);
 
-- 
2.38.1


