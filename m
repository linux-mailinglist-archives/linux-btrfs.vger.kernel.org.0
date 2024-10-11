Return-Path: <linux-btrfs+bounces-8837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB9999AB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A969FB216D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 02:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A61F4FA0;
	Fri, 11 Oct 2024 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W3BC0J+3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ry0vaMrY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F71F4FA3
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614997; cv=fail; b=i+ehOHntMnzNyA53I13ksGBMyBz6VKQQcoP3RFZ+oEvU6VmzfJHG1PbNAtJnRUXG2A58701PQq2mKaJP+azXWi088DnKBxQ5nRmUwj1DRuxabIR401tHsd572Ip8IDjp8dVwuKgizTgBOtncjreh7tF7os5yLCGhC3UzFJ14Wto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614997; c=relaxed/simple;
	bh=YykUjuTbY4HSJ7EPT32TBgvp7PNwN2NRu+JmwFHfBEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IlOjPkOB5XhQJYzR7c4cF3s0fHSCro5bx/FJKOUfJFRzpKU/HDkYHEfHh+wsRr6JpuWyCYa5ilbKWrEbEgVQD8OGvqHBOKUXIR0XpmoF8MMtJ3ftEiId7y/SWB7AoxwtZ9546xNE3dD0IM5FWru5R8sY9JV5DTy9wfC/VNgg0WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W3BC0J+3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ry0vaMrY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtcfA010765;
	Fri, 11 Oct 2024 02:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Jm+RoCfhJWXuvuAVi5syuitoXwr4QEG+yLXN6IZJSjY=; b=
	W3BC0J+3MddAyHseLU6860j0qV7eX9M1AD7Fyz8Khc4X7GOC6MSNZ9UI+zRny1J7
	PgAlQe02n5A7JmPmgcdVpyE8YgODeH9szQj+Hqtea3YO7+emKJvDzaw6hVQpfUUL
	918jln/MfwBF5ybVK/uFGyQGTHWEyCyqBakqzcsr7XGr3Bg1vTri3SbbmANYqyml
	RZQ9XIR2C4TUXZ8gY/Cy8VWhe3Sh3DKY//ldrhBdEhWiXy34oAhEztepCazL6iwi
	NETfHPXA3jd0PquZVgBdPEqif6/ttN4AuE8nTvjTWBR/J+704/J+TsHAVcKfI3ps
	L7DqnJpk0LYdrWNGqacJvg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ym1m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 02:49:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AN7SfG017546;
	Fri, 11 Oct 2024 02:49:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwawtnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 02:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4o+C9gWOuRPf8mXGNga84fEIgCwbHxf5RzMATDweqRYrBQrd3POodZ7zmDMBFF1cn71zkVd59OOSjF8bb3NFPb3H6619fq1+Azw15fIKbfLYjhfySnWKc03Ar1d76/zR5qFGIkdkEgllVs6d1NzD7Go9sunj3GhMhhFQEN+ZkgX/LTTuwwy8Su9jQqMhDB0lKbrkIyAr0A9gwNYKiz8dD/8+gLlJnxex2DFkWGF+bpRR7dRmHauMO11rRvNCOw0JiN/g3ijgVPnbNw6j42FHimQB1vFtiKc/jmc+dLrRUV2Yv75jdyBLCRv+NwhloC7oD5AxEdicVsn/nXGIniYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jm+RoCfhJWXuvuAVi5syuitoXwr4QEG+yLXN6IZJSjY=;
 b=CJIdITgDeX9H8xZhXSAHctjWyoa8Z4Yk+4gcS+/lyRdUcqycrlW4e9y24vzfJhaAkwpgTsIzix7CI6JjW1kwarwveUb5G2KpfnNCc/O7Ko6cmlb4uvFkd6A1/I5bcZsEz6ZYX/voHVR6VD6IIsFlLTMWcDmvHHeGg+mkhbU09mrmSmFmk9FKvL9vu/mytw9dqNX8LEQd7eftdad8kZwnqgSAz15JL0qU7Jx5jrrfaHRjdCICodCORLBfmdpnCdlXOOSO7IBcjbexCEkl9u0OBrZe9L3QQ5jsZXAbEs11L2sG4mT1qyzCBLqE6jXmaK79/G9KDzVXV6LXFnzCvQlQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm+RoCfhJWXuvuAVi5syuitoXwr4QEG+yLXN6IZJSjY=;
 b=Ry0vaMrYINIUciinakcPRmBXsZOOkUG3+JmMY14jiej/MJkzT89ye8+fCVz7VQXPVwPtV8hqbknNEoOhcybsZf5ujNErRJNJvs20ToJdzhIzbmSNr+XExhgL68BHWybiLbNRLwobtGxLU9Z+LwoNttqax7o1p+lAYVdAqjevhrw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7815.namprd10.prod.outlook.com (2603:10b6:806:3ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 02:49:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 02:49:36 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v2 1/3] btrfs: introduce RAID1 round-robin read balancing
Date: Fri, 11 Oct 2024 10:49:16 +0800
Message-ID: <ae88febb2b06eeadeafe97a476b92b66982ab2c7.1728608421.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728608421.git.anand.jain@oracle.com>
References: <cover.1728608421.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7e4821-88a7-4211-5a02-08dce99f5783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzEfPN8b9hVroUk62IvO19Qnl3Rp0XmvsGdtZyLHD/jD3WvLGAqXj48SLurr?=
 =?us-ascii?Q?qwA2XnIet3/krVSpEQG9SBKFS8s1O7+WYBEZljmkBv4n4A10wt+YbSzPEY9F?=
 =?us-ascii?Q?lngEtQ4STAy60VQbiZ4CW56RMn7Ult0MH5fVNEE+d7ZzKrYHwlcSAkYujs6+?=
 =?us-ascii?Q?2XLTHXYhuAtIlokv4dy6hsPWvu2I8hSoqmGIisA6AQta/0TXbFI4HH6YHL+J?=
 =?us-ascii?Q?v8WBDTGva1u5V/vfjNOn4nWN1VlfqWXNHrj1nYDuHHOxofdHZNLTCJlnEyj5?=
 =?us-ascii?Q?EAJXAz6FIktcUMQXLDYDeFLkuP55ZLJK0hXpSD2AMontieNXzP0AicMeygmf?=
 =?us-ascii?Q?j5ONrx5Fkw8xG/tcayD3O3LsThlnVYk82yyEv1c59JeBn9Gs6VO0sfaUU76G?=
 =?us-ascii?Q?Nrtvjq9NexGOuktB0xg0RmcjFhc42vjd+k5KbFfI3uvn2rcmv1iqT3gbj3GB?=
 =?us-ascii?Q?7Huj6mDsFysGjyi5oW3RrCFQ3oDWMiTQg31Jf+5a4vjPGVtKHA8fL5WjUt1M?=
 =?us-ascii?Q?+fzVZ7hKiqVZmukJW2epyiHlw3Ct3J4ROZsYi4eITEhky1XmHnDYfE9N/cav?=
 =?us-ascii?Q?xlvTdf1gQ249JIaGT+iPkDsrUo9+llpx/lHBbIr0thYDUUnS/m3UV5d6LXYA?=
 =?us-ascii?Q?yrLoAGsgST7ZbMm5nDRhfKd6xo3l44Kq7aMWcs8T+JHXyuElAMfbLrTA3abx?=
 =?us-ascii?Q?GBVSsS+05E6zHVUK49EJSZT4T2evt57NjzfmgnN63MRthkPkniHRGbavJCLd?=
 =?us-ascii?Q?Jbp0hMtFOZI6JvcIdG9jAQd4IMIu1LeBDCkksUMtjrGzX4nKpVFsv6LxzTn/?=
 =?us-ascii?Q?yp+pPhjrSidcq5sA88jWuHgsZB2LrN2tbk5PEfBd12zaZGISvR+lW+V/43PY?=
 =?us-ascii?Q?ovETv/aZVbJKPB+uVk/yn/Ii6+JqgwfoSjZAo6gcY2QoCF5uJFZQDN/XuWEe?=
 =?us-ascii?Q?ethLbBGFJ3AUZsc+1Pxm2ff0x28KNaiVqTGy0C1cxdeLE95MMPpGTGudvCQh?=
 =?us-ascii?Q?gDarWdn2SpjFygMnuYHNRFGJV4shhP+/wLDFjlZanKoHC4j7JylKh6hg4fp8?=
 =?us-ascii?Q?FtgIPXE1y9tX0XA5jdC6Ncjeq1xM1gvCN1aUiASiFP+ZNU/16K83aY/BEHJf?=
 =?us-ascii?Q?xxXWZeWThT5w3pEG1CEeQFJw5z0CKvqeEhhwiYXIKsLhoZyg8DMb9te9xMLf?=
 =?us-ascii?Q?b0kgT/FIkLPAJHC67lCW6B9qANcPWvmCulhgBDYr12LgB3i2V/ci3GPp1q+E?=
 =?us-ascii?Q?ilUoQdLiySguXpnl7ECIxhdSO/OQOxrHNe7XV2NQwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/2uqLuI6wk3chKzflMEYwgYrGkZAXsNo8etCO382sAI0Q5MVXXoaZHqxSXl8?=
 =?us-ascii?Q?MPHIJtnMPPZHpnbFNKBVBut5Cr2MxcN0+EhDmKVlqmm0RLXICM2VFBLsRB7Q?=
 =?us-ascii?Q?69zzCOO67SOPHtjf1jvmbKZLaCuBXuIKnuIQJQ4EavLmcv8O9B9wUdyTNZaR?=
 =?us-ascii?Q?mDdLdO5H5q5YDQZ2Q+2gf/Bq2hun1jY9ngtfe1l6a2KBssslf+PJyM8EZsL8?=
 =?us-ascii?Q?RNUAnwPcxBLugi1cCmSkonAbeukl2huDFYkbK18aVaAMGcgq7nSu8rRScvoo?=
 =?us-ascii?Q?eoFTK9RsMQdyT9pFdYTeUeZ3xVus4NjpnI4g4TQL3fEE1aYVn37mFXqGb7Fd?=
 =?us-ascii?Q?VSgZhCsygTisa/1hIdlZf+Qp+ZLEJWL34UWT7Nni0mCg4+zr7s7iJZuQliH1?=
 =?us-ascii?Q?yJFeFNHk0bVYSqZGqpnn1j4r6oBF70hRTcVFqXJikIUz/ueqT+sBLl1VxWm1?=
 =?us-ascii?Q?U/tJfZawtG52fB+a13lZtqr4u1a0SApcQXkcOkveXec05AvPcS3GVtmDpKkq?=
 =?us-ascii?Q?aQThA6V9Lsun8mEDBIXFGoAwhWKZ2iRYvQ5DpQx25LE1TuN/SFknM1FxkVkN?=
 =?us-ascii?Q?x07oTIOPN1F6IAvIqsccd942hD896qxu7Qtt+GKkqYBXPGK41Z1Y32mikVa1?=
 =?us-ascii?Q?idaW0bjOGeVgOBzKdmffLRERROpKhZeOf17Pzj8clQ1l9GVoDRNYjzTLrQUQ?=
 =?us-ascii?Q?heXKzptSuVHaPB1Ia/kLxuql4oTGhKE9fm6DdmqHNoMJjU9ltIJqQgR8lOP6?=
 =?us-ascii?Q?tMKWFgQsSIYZhKAOEK59A4zMvja46FQSDBqyVsGWvLlUPKCHlZGQSzSH3m1y?=
 =?us-ascii?Q?zKK4IRwzrpIFp9r5uiES6S3a6MGmygb3rGaHjxgczQiiB7AAhLwO11vByf8F?=
 =?us-ascii?Q?m1dZlhHKDhC6QaJWJoRvhoKkX+lEy7u6KCqU+5JosXmPSSV0VENauog/mjtN?=
 =?us-ascii?Q?2tiSC1rkgENqngN3/WFudmsEsLmdsCZv8PFQ8D4CF6Mhs2edzPNWqKy0Cfly?=
 =?us-ascii?Q?3u8513O0dU6RuB6fKE4lV19ZLh1Yw757DTJqBWnlNtfLgQ8ACSHHrbVCw8VQ?=
 =?us-ascii?Q?kfU6Bzdo+YfFZ+tTaeA75ZOS+zd31NPpR7lFKbPEZ74SnOW3GHBlTj6l2DmH?=
 =?us-ascii?Q?MDeByDrqYd1kPpDkMr+9kC0S+IYqwPCxSa4Tm6OgYdWakvLEoKC1l41XsAVv?=
 =?us-ascii?Q?H5tYHHpspaLKJe3/htP1UejkK20i5XyOYzfdMrIkxNiiX4Znr7dYPs4iLQZv?=
 =?us-ascii?Q?iJkIji513v94C2EwyH5Ow18bAbnSfLEz+Ntjbf6m3FBExjGoil+FFv0UhaS0?=
 =?us-ascii?Q?/7jjHaHxgiIzJNBBmeZ8JoEfmQy5pwZOCBQlrZEncgqZbtcXewXut1JZBL1M?=
 =?us-ascii?Q?EZTcjU414YG8moM+3XHDGetwnkvsyreXvJlCrLpu3CQ2ZG+FhkCuRbyovXKK?=
 =?us-ascii?Q?bfih6pg3slmQbSXqyaMr1/XZ27Kct7o+m4ujSQzrHpjUFZe9Duu8yjtvFf5A?=
 =?us-ascii?Q?OMdNqC467+LaZYz/TFk2CthcYGfPPC7lXJAFwxeycGKk3vqizjzyUCUBdP32?=
 =?us-ascii?Q?JYrkSEXXbtrDpVz8Wjvjgj+rCsPeAFmTbgH0KcaP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZJJMxm8UTcLDQGFlXxAop3sArtitLuBAqz8eahSIJyb5W+VpxE9r4QzTZC25w72W+QQ6JZkb6dB4VqF5gql//z42rvnA3jOhEjZhmp+5TPR3Gun4oQTXODbTABeF0SDNQ8GjZJ+hbphzsOmWhVPh/dbjAaB8NbbfB90+jfMjzceSv7kbc/MSJuIa8oG7l7gS/zgZTARkILwLOFtIhOJeYns0BZSmG6VHrRRe8mZwLlEdpfLqiZSgl+zhHWWGnZZYMvLaY6ldIUnH0RBszCFyS/PV7ZxkoBXgsm8K8vmtWbJ2TlIokFedU9yZVl/sF2mZK7xozJyNMPkthybXmAfJvkWowG9jPVD1AR6/RVtlhWkKJyhbJ5Y5udotrqiJajm95+sy6yv6460scYHek8tPavx3gHcahn17byzR/9cOFVi8deA4ho5/ubxRKelkljxFW3bxGff5fItmYDAV87FzG6LOL+L9/PzRNy525AfYc6BxIkxVucO+T/GUmu93tYKZQxNE7XJR0j9KQwERdbrxOSrYSE1gUHtE0B46hksZpggGMj401d90UQT2EUc3yKyj25BfdETZGHl6F0BzZjPo8yNIjdCuG/IDPbBQ0Eztm9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7e4821-88a7-4211-5a02-08dce99f5783
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 02:49:36.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efernfpPl40pKRNFjRZUYf2m+4+2tOAqsIQQYgljvlDiWdRQq5KBY32Qa7wqv/Tp9+ThgcEcBT8RUKwYKlhSmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110015
X-Proofpoint-ORIG-GUID: oWTXCEprIvGiLcYAEHTGOUfteafmryjc
X-Proofpoint-GUID: oWTXCEprIvGiLcYAEHTGOUfteafmryjc

This feature balances I/O across the striped devices when reading from
RAID1 blocks.

   echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy

Default value of min_contiguous_read is equal to the sectorsize.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c |  3 ++
 fs/btrfs/sysfs.c   | 88 ++++++++++++++++++++++++++++++++++++++--------
 fs/btrfs/volumes.c | 53 ++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  9 +++++
 4 files changed, 138 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4ad5db619b00..5b157f407e0a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3320,6 +3320,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	fs_info->fs_devices->min_contiguous_read = sectorsize;
+#endif
 	fs_info->sectorsize_bits = ilog2(sectorsize);
 	fs_info->sectors_per_page = (PAGE_SIZE >> fs_info->sectorsize_bits);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b843308e2bc6..bacb2871109b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1305,7 +1305,11 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static const char * const btrfs_read_policy_name[] = { "pid", "rotation" };
+#else
 static const char * const btrfs_read_policy_name[] = { "pid" };
+#endif
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
@@ -1316,14 +1320,22 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 	int i;
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (policy == i)
-			ret += sysfs_emit_at(buf, ret, "%s[%s]",
-					 (ret == 0 ? "" : " "),
-					 btrfs_read_policy_name[i]);
-		else
-			ret += sysfs_emit_at(buf, ret, "%s%s",
-					 (ret == 0 ? "" : " "),
-					 btrfs_read_policy_name[i]);
+		if (ret != 0)
+			ret += sysfs_emit_at(buf, ret, " ");
+
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "[");
+
+		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
+
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+		if (i == BTRFS_READ_POLICY_ROTATION)
+			ret += sysfs_emit_at(buf, ret, ":%d",
+					     fs_devices->min_contiguous_read);
+#endif
+
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "]");
 	}
 
 	ret += sysfs_emit_at(buf, ret, "\n");
@@ -1336,21 +1348,67 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 				       const char *buf, size_t len)
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+	int index = -1;
 	int i;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	char *value = strchr(buf, ':');
+
+	/* Separate value from input in policy:value format. */
+	if (value) {
+		*value = '\0';
+		value++;
+	}
+#endif
+
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
 		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
-			if (i != READ_ONCE(fs_devices->read_policy)) {
-				WRITE_ONCE(fs_devices->read_policy, i);
-				btrfs_info(fs_devices->fs_info,
-					   "read policy set to '%s'",
-					   btrfs_read_policy_name[i]);
+			index = i;
+			break;
+		}
+	}
+
+	if (index == -1)
+		return -EINVAL;
+
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (index == BTRFS_READ_POLICY_ROTATION) {
+		int value_rota = fs_devices->fs_info->sectorsize;
+
+		if (value) {
+			if (kstrtoint(value, 10, &value_rota))
+				return -EINVAL;
+
+			if (value_rota % fs_devices->fs_info->sectorsize != 0) {
+				btrfs_err(fs_devices->fs_info,
+"read_policy: min_contiguous_read %d should be multiples of the sectorsize %u",
+					  value_rota,
+					  fs_devices->fs_info->sectorsize);
+				return -EINVAL;
 			}
-			return len;
 		}
+
+		if (index != READ_ONCE(fs_devices->read_policy) ||
+		    value_rota != READ_ONCE(fs_devices->min_contiguous_read)) {
+			WRITE_ONCE(fs_devices->read_policy, index);
+			WRITE_ONCE(fs_devices->min_contiguous_read, value_rota);
+			atomic_set(&fs_devices->total_reads, 0);
+
+			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%d'",
+				   btrfs_read_policy_name[index], value_rota);
+
+		}
+
+		return len;
+	}
+#endif
+	if (index != READ_ONCE(fs_devices->read_policy)) {
+		WRITE_ONCE(fs_devices->read_policy, index);
+		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
+			   btrfs_read_policy_name[index]);
 	}
 
-	return -EINVAL;
+	return len;
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dc9f54849f39..ec5dbe69ba2c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5962,6 +5962,54 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 	return len;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+struct stripe_mirror {
+	u64 devid;
+	int num;
+};
+
+static int btrfs_cmp_devid(const void *a, const void *b)
+{
+	struct stripe_mirror *s1 = (struct stripe_mirror *)a;
+	struct stripe_mirror *s2 = (struct stripe_mirror *)b;
+
+	if (s1->devid < s2->devid)
+		return -1;
+	if (s1->devid > s2->devid)
+		return 1;
+	return 0;
+}
+
+static int btrfs_read_rotation(struct btrfs_chunk_map *map, int first,
+			       int num_stripe)
+{
+	struct stripe_mirror stripes[4] = {0}; //4: max possible mirrors
+	struct btrfs_fs_devices *fs_devices = map->stripes[first].dev->fs_devices;
+	int j;
+	int slot;
+	int index;
+	int ret_stripe;
+	int total_reads;
+	int reads_per_dev = fs_devices->min_contiguous_read/
+						fs_devices->fs_info->sectorsize;
+
+	index = 0;
+	for (j = first; j < first + num_stripe; j++) {
+		stripes[index].devid = map->stripes[j].dev->devid;
+		stripes[index].num = j;
+		index++;
+	}
+	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
+	     btrfs_cmp_devid, NULL);
+
+	total_reads = atomic_inc_return(&fs_devices->total_reads);
+	slot = total_reads/reads_per_dev;
+	ret_stripe = stripes[slot % num_stripe].num;
+
+	return ret_stripe;
+}
+#endif
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct btrfs_chunk_map *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5991,6 +6039,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	case BTRFS_READ_POLICY_ROTATION:
+		preferred_mirror = btrfs_read_rotation(map, first, num_stripes);
+		break;
+#endif
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3a416b1bc24c..0db754a4b13d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -303,6 +303,10 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Balancing raid1 reads across all striped devices */
+	BTRFS_READ_POLICY_ROTATION,
+#endif
 	BTRFS_NR_READ_POLICY,
 };
 
@@ -431,6 +435,11 @@ struct btrfs_fs_devices {
 	enum btrfs_read_policy read_policy;
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* IO stat, read counter. */
+	atomic_t total_reads;
+	/* Min contiguous reads before switching to next device. */
+	int min_contiguous_read;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.46.1


