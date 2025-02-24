Return-Path: <linux-btrfs+bounces-11739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E81A41EAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 13:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA92188D19E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AED221F21;
	Mon, 24 Feb 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JY3AhJTL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EmIkSRzQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A6221F1B;
	Mon, 24 Feb 2025 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399332; cv=fail; b=icVmHNzwH74FoyaGzg+Gifa3480gZL9L1IcUYl+px75Uj0bIF3ijR9NMrXlBI62N0Thr+rh7hbZoUvCX6hPfTHbZ1lMHpOUVMj/6WUJmScnbHZzRfbcfTqlTg+wsOXFUy5BQmiMLo4ME63rR8nP6pgUstiSEiRHMvLv6iRVfMRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399332; c=relaxed/simple;
	bh=UJ8oizn+Sm9HrSKfy4buVeE9TTn2ZIkMxqFSD570xUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YP0OAqVRNuZWgmqhm4gpiQs7gc/4FxcCq1jUcJkJaDbOlJ8Ae6l+lxXIamrNobPRMaFfAhWUOw9ZvL4LTHsZ0FPWbadzk4qixj4oKpGatjF3mMkve1MXWxXrfuzbGq1EuI9r8/nVAEg5Da0DNuGGVxEDFR/D25eIoGM2ljYwbFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JY3AhJTL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EmIkSRzQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMb2V024850;
	Mon, 24 Feb 2025 12:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=c835mLiZPUi6/3tiRTwtCwRR0DJ8isqvXoDaz9dSlVw=; b=
	JY3AhJTLiKHz0OlI17LdW2HLwsHQEkpr20/L4g7HQo2BklLAWo77LvHIBB8sOtP0
	BtaAiQLz/tXtz4MIRzemEAyaYHbeMszMSOzLpnEcjav5X93YgpaiWP0kMw/oBkTz
	Vo9xa7FAHOWMrSY1eErFW7TJaB6d9tC54P+XgYsOa2NSDn3c5uQF9H12wHdMBMDa
	3E0XTuByUQU7JRIo6aBfBuTDYgQfkKroZ6GOLc3a1c+05cJBAoZb/2DIFjXsApma
	6ViyeIADX3dsTFMZX/Rbz2+KQxR0eXVi1uiQFkTWGWqDtFrVopeff3f7/2wmWHH2
	M/45q89iE12igRP7o7X7NQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t2cu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OB0tjL002929;
	Mon, 24 Feb 2025 12:15:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517tj2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K32huKtYSISACMTcmQAgmwCLx8ZKAqM/td5Jr7n5RuYJckSkX+DtbF438v0NfyILcmkj2kOmggXmOXQnynwbae+kADgDoU5RtpYA2w/f5j3F96bvrR0zJLZTQNWxL9sMk4v6ZlyaM/kdVSY3Fempa6THkiYCofTbgx6ERsfGgHsgIuFdzVtu8Ai3JDBhLwxj/YvVFlHPSIbJ35IBINAUIp+c25M+98LFRIg5x0AFZ14+tJvNB9Vrah7trPtJQZ2UhcVDHd0OFTvwX8GCf/L75MQof6DSLzf5wsgFw0F1dYCDeLilbA2WTcDcb+MRaOw0b+PL9ayea2VpfYln2l2aQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c835mLiZPUi6/3tiRTwtCwRR0DJ8isqvXoDaz9dSlVw=;
 b=ti/1DeLoDvbQbjjrvsYlmdY7225ePaI2KJee+SIHFQo1D8DjlcjbF3chLJ/nJa/g8oid3zMfZit1xOwBPjKmL2em0t1O2aDMxtxrXyyPLTfT7H5DMkVLAIBnjrlE7igI8zQNgBBgsgPzaYFnoH+0PhA7TFQUf7FGPlnLw7rqePkvQvJZ5XeHl0jQTOReQSvwQNIoxcDd+t2NIsYB5ZO5pqQC/xtugkD9GIlDZhkZlNfiW9H+yMAadhaYuvFTOBGWviIhi9pIyTs+uQ9NdRjKRNi4b7fR2gwyp+FcakoVS5Bza2MPOjYA1fKXknKec9TUbGHVlEjtfKeIGJG5BK/3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c835mLiZPUi6/3tiRTwtCwRR0DJ8isqvXoDaz9dSlVw=;
 b=EmIkSRzQAVjTaVOnT/xffn1fbFjVTg5apOBqX4PtjO10KR/VFsLiEnYfAJYUNFTR54hic2NYYNTsiBicYFlFoWAuB4SimIrT4NtBP/77zVik7XQCOEfqRnBIZcddRpxiOKH26hWbyd1Y+ATjQWE9kZpBLns2/AmaEuDCnuM7XHU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:15:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:15:22 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v3 1/5] fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
Date: Mon, 24 Feb 2025 20:15:04 +0800
Message-ID: <e18babf503e66ce798c3df4353174afd4f771303.1740395948.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1740395948.git.anand.jain@oracle.com>
References: <cover.1740395948.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c916331-30fa-45f1-e6ea-08dd54cce9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y1I3bvHP+bXDfOqbOnB+Bz+PdFmWsXHxH5PuxFy7YLIoVMM7SrHvnFzkg3hq?=
 =?us-ascii?Q?rdLGwT7K9UVFR6Uq8im+OOcH+D55Ukj4VVQuWwZb3+V3Gaxizg/P/oOvSsgw?=
 =?us-ascii?Q?rjbYP1glDIC3fnuz4JBx+wDmjVIhXxLQiTgpc18Enc49+NTVkt/RUa4X/QGf?=
 =?us-ascii?Q?tbN6Inc2AwnOcgPR+ARdJ7AVU00NN+jXsNRhah9Fc6ynwef0GimwzGUKWf7o?=
 =?us-ascii?Q?giRaLuyHlSJP4E+kBzd6TOd2wgU41HfSjOXR2ZFIphMVUNguat1iwEnfzhXV?=
 =?us-ascii?Q?VsDErIbyuE8bhuGF8WqyipwuH8cWnbUGEZyFryg1Klh9goEvIOD6bHwRNFjq?=
 =?us-ascii?Q?MBomDM3YNsJcS2GcMD2QK7QyeMZWgk5YvHpOwlMiBcUVbjFh8EnXWg/lQDNa?=
 =?us-ascii?Q?IErjdRBgHZhbGgnFOMVv5oGSUR5JcHkNKzmfOHLuGcPL+paxASerwbj621J0?=
 =?us-ascii?Q?So/7GZ3WxIKi7MVR6ieuaCs/XAoWJxGE40gAoGd1jQY7RFcQDLbhiRL9opF+?=
 =?us-ascii?Q?SDYSQwJMq6Qbd7DAF9/pXB0OSRDMCUUPcRNcTalRWccw8zd/oSMi/3fIvxlb?=
 =?us-ascii?Q?FLScrAC8E6ro+sEigM+MW/pzl776dIOMiI7lvne5N5OQ1NU38b22ZJfg9xFf?=
 =?us-ascii?Q?hdsVJPXFMeiVDZVfyvrZiLJo+hIwPb1HeiXSvblz95dD02HHzXT/X5OJ5ZBf?=
 =?us-ascii?Q?L3UOhwZPNnXmMnpWNUzBP63RKRATZGklXAQNI2rsJEBYprqDkssJPi0l7XWL?=
 =?us-ascii?Q?VVJyYj7uoFQd7g1KPTChGaiEMfJUb2BcEAWy7IgfLT7Mi9UfbFhZ/I5/ONWh?=
 =?us-ascii?Q?72MVqLX8+H8MhuJL1o2hmoJlRJSPUiuP2eSJtkeaMkrAIhSLrHLSGFqo3xAy?=
 =?us-ascii?Q?Y1BAODaAARMVibJOD4DuUhGzNCg3CBY1BK+YsDeBWtxxbNpIyJ7A/+FwlgJ5?=
 =?us-ascii?Q?Ndjff829t2vPqifazMDzboLX0WJqmPRoADx3hP4ByWiEcyyqBUxWU2qWOVFr?=
 =?us-ascii?Q?/w3s8kyHbCZAY9sqAhhA4AZaZNv3B0RtTbLCHLPLIcG+M2dpVcD1o+e9vlSj?=
 =?us-ascii?Q?3YuGWVqI+m29db9OtXBheuHjwTHtFpxgLodVz0Tvzxubs1MuSmAoMgAJEC6n?=
 =?us-ascii?Q?pFMGStPAmJjFzA2XDh3uIjanCpmlE9CShePqU43aX/Ay8o+3jq4dhNjNvxrI?=
 =?us-ascii?Q?tM56U2XGBLL9uZ6GuLQa2WWUrTVYUgLUYUdeFDDTdtXLRlXkaYmWYAiZPsiI?=
 =?us-ascii?Q?fdVyzekCYkHEp1G9Lgkxb7MQVXgbQNSXqH1t4ntkHZFnmbY/c6g1HnpAnqrK?=
 =?us-ascii?Q?E/rEzsPmXfJ4wgZQIcYdpLqSOxBxIbt6tAVut/Y+lQLYSNfuGXKQMC3YrdpR?=
 =?us-ascii?Q?6HkEuGUvqEJVBrvdH9O3V9C7CkW1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n1vCPwIaDpq8/A4uWwjHQy+9urBaGZtWGqCLBkRs3yNk6V8WK+d7fBBf2Pn8?=
 =?us-ascii?Q?ZLh0nKZh0d4o6UXpJaD8lU5/Rzrj+si6t9hFHh3qBPDa2ZrsE65SRQ9S0rit?=
 =?us-ascii?Q?YYATKu/ntXWxyz8Xy254No8Im2/4GuWq5vHpWKyzL/Bac3gCU9Gkni+CylIA?=
 =?us-ascii?Q?fWiat5kWBI0S/i0lwt8z3q/vaczqEVrS9z1y+lnsUvKQbRceWDYFsWjUBZnL?=
 =?us-ascii?Q?AA/1Xc9bJCF0cSCSg6FColPJKqkPejjdc6g8ry/AQFEQSzQ12FKAjouoqhvw?=
 =?us-ascii?Q?wMnPLI2JSswwN3CaZ72Cz0qc3Y5ifI5b8foid44O3wXcJgwfZRs57FCi7fzc?=
 =?us-ascii?Q?Z7TvckwpjJW+XT2Yu4/amYlV4kpVrBpbay+C2bOLoX24Oa++NpBFMM37Kl8x?=
 =?us-ascii?Q?k4nl1Dn5E0gXnJqj2Kpgbdqwo5vVz6CIme13vUsk6mpn1YLQUGZ+arnf6oQj?=
 =?us-ascii?Q?Pzw+7QT11JLk9D0D9tE/OJs6QZhbYwYtQqxCJqOb9/2nZ4sCiqJlBFkV5iOc?=
 =?us-ascii?Q?VKAAFZBgzdadhFUhhK+ox44ah26BnGQf/MFJxdezW/UpgyDVj17HTBFohx8R?=
 =?us-ascii?Q?vB3KwCZx6iYowLRImYEXGKLSTUQrYicirqaxt0crBFjs64XnhJvHHGcYe+GF?=
 =?us-ascii?Q?Vw/Ph0xxEdPwQM48FxlpdFQSbLl0r2SPqVgozoyCev0GtYoc5ks5sa35gpCs?=
 =?us-ascii?Q?k1CnipLBxdH2666sGX6TekOclO44yQkoaZB91d6woyLfrq6NwzEqGyCKTSiV?=
 =?us-ascii?Q?qalI7T8DKCpsHqZZ2b09cRQ2ivdNG7/XWzUSS0tNQtGs9q4NkCVdNb+cf61c?=
 =?us-ascii?Q?aGiHUI4TqBrJEn/wWD2e9aaVY17rA02VKWPrsGM378Xx8tCWKcJHFY67DRDC?=
 =?us-ascii?Q?+WnWAhV6lEd/1+uS37MVllcDPvEu+FkMljaQfJpeaXpiPGRS1h/qOM8VOzZ8?=
 =?us-ascii?Q?3V0DlN7LsLtU15M3rOd+O0jSFdrZylumCy5YGXgZBTriYjbqnXB6I2FyGfbJ?=
 =?us-ascii?Q?ACLtGlqSQkkbxcwx8Ufr73lfZnKNol6SPt2RfdZSpooUHeo9qb0mhZJ2AoRQ?=
 =?us-ascii?Q?pV1HBEMQfEPPQJbDox7OXYeEhml0yczNbwDKGTESbov2dFkY1mm2JpboAuNl?=
 =?us-ascii?Q?mKs5EmPLUpf/LTXp+qFxQ+dUX/lSWaH0Epvb0Q2iOZ5Iv2LW0Boolr7ysqEQ?=
 =?us-ascii?Q?xxYBiD+LEgZjptVpvkW1djbaSxd9MtK0Y6YtuSCgYFmk0qa6Vzg2bt6DFe+I?=
 =?us-ascii?Q?6C1dzIBg2TNqCvSzZK8AR/WPXPuetV6EAqqJvlS0A41QOb7Zf0d3QMRFyy0G?=
 =?us-ascii?Q?V/bPy0vPsVN78vksKeSm7SuTdTrT4TdKGMuqMPqWrViAi+S4GeVV0FRiVZxa?=
 =?us-ascii?Q?sNu0+8X0UWMV1MJqihT3mqUzHK+MScav6n5diV0ngH/giX3VGackVefi2Uh/?=
 =?us-ascii?Q?Kf3WVeW1SwaYfxqLrjtx1kcZ7V9x8bCj7pqh1F8ypuqTNBgLCR6ZiWv5Le9F?=
 =?us-ascii?Q?zbEMUjPekYDHTSN5SbP8NMOjDhfnYL1ogic+ugsBxMiXlAHrQhEgCutoY0fI?=
 =?us-ascii?Q?3vuDVjU6/QGBkfp8kMyYRYIlbmapcEAv40sNM+8d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pl/G74P1qziQUbm36LSJtzUtoXLNYThIABZKYIM2smIGJ5+i70alc4P5ylOCqLtmk4wEwEPhY6zyJUj6Az5PlwpNanjxHX7f1u92rOAdoxRlkZ5Al4Thw3XSQOrATWFRMAqrKGXK/4JPsypsYrxQ2pvj8fOmojKNerJZnEbuO1e85MEvPSQTB+k8SX/wMe00Md5hskJDygM17ITBbNH97QsU9jdFRNNAwPQZdIB2kdCUed0XnTFn+f4VRfqdMY7fsEBqoSh0bInOwCP8IUIhkOmUipsR+Xb6KLcG3lto+ugwv62y49e0Dqm+fkODX2F3PW10LBw94t9tbDBuZQcmKicClAjVgwUzdYMgY3crzXoEUOj32vOj0rd/x6iLFHyGnN2k7AACO1+gdbxfmAMS0mm1l+cP8dXA/R6vx/0kDr2MXQu/yvNInsEXDZjiz/le6F6M07nxZXxvxbc7FsKv+t+VXQQUw9RUCloeTRgMNqW9wm2j7WBq7Hqn3KffUTeWmalGUA1BF7NSSNPknSeK+iutDq2fPlONlc9J+gTW3YtQBp8Yj6Ov24Cjb5LsnNUY3cONrs9xopE2ZaHeVS+JHtkT+lI4paD9q71jH4/q91g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c916331-30fa-45f1-e6ea-08dd54cce9a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:15:22.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMkVNS03g2npRDsSqA5WThjguzZOeC/WTA+LD0XwnJaxRPOlZLAtfm8zsveZ2WXgyyKghxieRtfCkbpDu7l3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240089
X-Proofpoint-GUID: X9wBbklM6YQNDiI7c-6D94L6lPra4PBf
X-Proofpoint-ORIG-GUID: X9wBbklM6YQNDiI7c-6D94L6lPra4PBf

Redirect sysfs write errors to stdout as a preparatory patch to enable
testing of expected sysfs write failures. Also, log the executed
sysfs write command and its failure if any to seqres.full for better
debugging and traceability.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index cf6316a224ff..942e201649dd 100644
--- a/common/rc
+++ b/common/rc
@@ -5081,7 +5081,8 @@ _set_fs_sysfs_attr()
 
 	local dname=$(_fs_sysfs_dname $dev)
 
-	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
+	echo "echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
+	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
 }
 
 # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
-- 
2.43.5


