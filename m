Return-Path: <linux-btrfs+bounces-10424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE58B9F38A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8782816B31E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24831207A20;
	Mon, 16 Dec 2024 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nG2HzTkY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q2AM+kRH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480877111
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372854; cv=fail; b=Timm2NBPu8mBrsWbYU7uAq0DfRcsIfWlVb66b/O8SKIFNStPaguy/i55TDNIzksXWeQSrm5osUuse6LDXV7r55YlehYBT9eD1uyDFn+k3O5s9RYgz4TPvAMnODgdLoK5iQ4jtun0J0kYzaBdoMppF/kLYC7tFdERmSjD1ZLwsi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372854; c=relaxed/simple;
	bh=b7uPh5whV7MewalyZ7zR0knjGEdFLsevpwEqHQtFTPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kCiZwlg34iXvnioqFUhC2bof0tMO6mvmh21S2w/VBINHE48LfiR51yST+yYqcykGyMg5qNkJMcH16E6640GFF/fuqHLVE/msHRra/zBLoB3d8dgBuAVaDq4sslwBSkmMJZ2FbfyhiEGAtHtBML7gmXHDXmf7hy5Vnfw3LWGHN9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nG2HzTkY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q2AM+kRH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQhGx021710;
	Mon, 16 Dec 2024 18:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z65in74P5MF2tELa/EF17Ce6XG3Wx7bzC8YUMcexup0=; b=
	nG2HzTkYDL3jRR/oxF0j2jGK4E72KLcc5lnPJZ+FvhIlCwl4mt+8Wp4DPaxeWdxx
	I8V1Huq2u1hoeFKQnDrXPlBP6GwDQSSMsf2daTo4FVV2vXtp5GU/J9aUG50b+qtm
	pXp4Z3Ylu5w0clAoOYvTnvFwnFAs41Ol0NTd+0rh95bE+DPQoI2zU9SDijJN/WJP
	vKNG4xGKwYC1H5iV4cB3VJlrV1ARU8KaJthYO9bLUcAjpCBHOv2MgOHqSs9VlW4S
	+2U++o9Y+8juhRO90pzPo9uV6prN/DeVnK2S9nzts79YvqSaUCuC3R64hFsWwaSf
	EOoBiiSIgYd2cmdH6J9L/w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj59tq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHPFJQ032875;
	Mon, 16 Dec 2024 18:14:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fdmw5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc1+W2pHNq6Eri59pkmfrz90P3fItpxXbf7Gg+AZ+I5sxCa8qKIJ6Y8n3OdKPF0zRnN84VJwlSMIElnKNOcm+URKqMthUuFbFkOAFL8gsPfpkYdANaqCgUV0RCaNxK6m4GGCdE0LLnTEaRY1OA/UgOf9vR8h8wKWutjQ4zo25eAnUuNe2f4AzHeSdKa0hGEKlP1fg/JISMFuLoYD0cYOBmwlx4HPmzEn3VVYGpep4lwMwvEEQW314MIHqx9kgrgHnieMpIW78sSY5e4AyJNCoo4IoO/80AcMZv8u1bzpX8GHDoirbObYBEkQmtcp+93QD12bNJDLUBAKwTbxIrNhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z65in74P5MF2tELa/EF17Ce6XG3Wx7bzC8YUMcexup0=;
 b=UwpYMiyh6SsHUgTv0mvjnyjyn6xLkGakc4AwkM1O2WZFT3Yc6QYLLlMBtYKXOyrJVBr1zhRDcgqf2qD+MphzTfGazGVzdEKRqDnpadDEjhyaqnz8KHyDdIi3luW3wY0ZS4rNL46E7I7Kod/K4OELUgcEGq+qcAsvZBZ10BSnfpenGjIvtsuW7z7n9GIxI0GUf6SJ4/g79h9MnleM5ivqllpnSTPv+7xf0FCNFcuSrmhJWTmQOBKo9JD2h35xjOsG05XhUaXXmQOfyxG/6Oy8iVaSC4inLRBC/o8NHQPWgPKLk+lC41GwP+9J4PGNHZtxojNLJPdTcFms3K1siCa5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z65in74P5MF2tELa/EF17Ce6XG3Wx7bzC8YUMcexup0=;
 b=q2AM+kRHK9goZ1QK1mQ/HKkwU3ZWhv/P78IlbIC32qJW1KCwJtN0qOvRL7oeQuRtK8ulY+Yr+/HI4UIrj8/o+Pyn3FqCy/SphYYbcJ8Ydfdv3N77REzulSTIxGXwwvULR80PhxaVWXNn0Q1WPFsTVTfao0hqydgQBx5lcFYJkm8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6653.namprd10.prod.outlook.com (2603:10b6:303:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 16 Dec
 2024 18:13:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:13:58 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 2/9] btrfs: simplify output formatting in btrfs_read_policy_show
Date: Tue, 17 Dec 2024 02:13:10 +0800
Message-ID: <c9a99508b5880a913bac14b68a122a5c8c1e92a7.1734370092.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ece7e1-9717-487b-3507-08dd1dfd692c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RFrS1b6I+RceUZTImryk4etzkLaXdciCx4Asm6yOdzE0LyaO2JrroKC95cA6?=
 =?us-ascii?Q?QiIIABRdzfPkMr0ik+1Pl3wDeckmqyRbO6wRJICAp2j8e/8Ik5e975TEum9c?=
 =?us-ascii?Q?jk6oAdkcsh4eUSHA8CHXNnv/ILqqU+xkqZecy3uRdlwUkOC+4r5x9HBmm4we?=
 =?us-ascii?Q?woHgm7f9Wuz26IzuoGmxJih+EcnlVyEfmMWuyT+z4Ae20ubuxVNuxtexLwRO?=
 =?us-ascii?Q?SoYwYXeX3/23QbpBVA4CkiuQJjWjOoLUe4osBq0y1wk552z7mIM7zJXZhbq6?=
 =?us-ascii?Q?2u3OTDceM7WBVMj+txmFXiAcnpruT/DvOrb/S3c35LR1HRxtx+TabqwjU8wr?=
 =?us-ascii?Q?skrccVgjP89UeObSuotbNrVIJBcDqDdSqVHkwsQgncumgkIAnviMwa7sbHYS?=
 =?us-ascii?Q?QZw0yf36rH+1KeEO0jTIZgY2dPyn7NDIg5l+3bR78qcUJ2XUBMEU1D2SbyaP?=
 =?us-ascii?Q?gwIilMD/QbfAD2N37Pdb7MEw3cboCakDLtMyBy/i0llB77ypN50rnUeNImR0?=
 =?us-ascii?Q?pJ+JLBqbPwYQ7c0eIsYR4YF+da3RMNUzh1lRlKfKyVxw3cFv0OA83DxKFflq?=
 =?us-ascii?Q?bb+W9GonStzwBo5IedoMedZCD2TGijNDekGNq3M9M7FuDBeymTS02vCeeMj5?=
 =?us-ascii?Q?cxBtux5v3+OAG991U5/GmrOM3mprg6n773GuinMPSHvqhegMBZbu9V/iq1Ar?=
 =?us-ascii?Q?E2puduGpkYT0ECgAFgvCmriyrm7R8k22zrVilqU+BeugytlePSc36nTnSqaX?=
 =?us-ascii?Q?rUhQpEJHKzetU0MdwiZH7PSjoyd2rT22Ye9rB5guZllgJPJFdge1FbgsSDEN?=
 =?us-ascii?Q?tknaL8d0auPXuw3AC1AvojWSoYzEbpRTssYJxTvoERK24BIcS7mH3F+ul27D?=
 =?us-ascii?Q?zltvzIPqfBb2GGFVm+I+VvHYiBLHs71NVYLO5WOWPzRkJWsBxiKU2UFmrn0i?=
 =?us-ascii?Q?UD/1QE91zgMweMH02+XBt6wu8tYiuGwVwp81AMWpknntul80pq6uqjCTJ4ep?=
 =?us-ascii?Q?iF8wLzuEeOJmpQ9508teNO6rVBLfimwiKhDQK4bI7R+7xMuo8DMc846oCve4?=
 =?us-ascii?Q?ks3u8k46OtR+4E+mqSTyv9TDu44H0ezjt3vUPxu0jinqJXs2UeTZmMrOkYx+?=
 =?us-ascii?Q?ECTVSmcJjqLuu577i+HUHqyRsM4/4BDL2yJ30lEZrD0jWFZRT86cEd1ESRXG?=
 =?us-ascii?Q?m/lYpmNIbUoAn/PgGxcy2pL2EgP+uaPz9vqsJCul7d1YIZAKevLj+7wRWXHG?=
 =?us-ascii?Q?jPPoBK43HB31UaoeqGKh9zkmeMhcLthJPkleYSTw6ZvLTY2QGsZWYf3EVri2?=
 =?us-ascii?Q?QszGkBWD3jVCKNc1I87OF7cSVkDFYDHmb4F8RCeHDrzpb8tOIUB5dbwVI/2o?=
 =?us-ascii?Q?gthHPXWbnCBPqrnQ+7RGUnmYB/Cs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BqGiqpQ/nQgt+Nljrfv6ERWyG1ySTw9b3TyOGeXWaRexIYTY7zh9yKKhmZR5?=
 =?us-ascii?Q?CeMgVOeoWe9KnibAxAsc2To0aeHgat3ZZlezD4FvtY4h82deXU+WGBXMLYNZ?=
 =?us-ascii?Q?bUHa8ql8rTOJzU8msjak288Cguda1MMK/VzMaPI6TXg4cF+ToQ575GfI1bhH?=
 =?us-ascii?Q?JWZeLxx1orjZ5xhQ29M70BbVZu3ePxjAQ4UTvUADf1Rr1S7EKeksJG45kXa8?=
 =?us-ascii?Q?4P2+N8j1a4XqDkO6Pt4wmD0HQkdk5lQvT0hebov5chsp1Z1KwT/cgWT8MlPS?=
 =?us-ascii?Q?WdR7TbIFUilGYslFXW0Csqrdk7tdzjzQUXC8+r9EJwofqZ+nrJyaNNK25Ufg?=
 =?us-ascii?Q?0z/OWN+uLpyVG7qy5M1w+s90pcPADBgEzK65Q7+BnvAL7mP3MwIXP4ankV2o?=
 =?us-ascii?Q?zXWGsNVTJewABNYZ0vUASSlUmTHQ1I+A5+u6RVCMWkM2YxUxb+fg8+Jha3Ac?=
 =?us-ascii?Q?iThwaW4IIaOHydeCR5uCU3M38ckoLYNv3Nl3QD5NlLLNnLIMCnhIacybl9Kh?=
 =?us-ascii?Q?cPcwRdwDZ7WuMn/8cWqYjHyC+8UUI6rAiCxHeIeS4ldwqoC4V+ON3zMi1+c3?=
 =?us-ascii?Q?/AkdCrMbWp1jVsK2Aktudg29hvlJKtRUvVEucv/QAO5r+XrGJY2lCjCZ6KIK?=
 =?us-ascii?Q?nj9fql7QrIZPKYYK3RE3kXR8ssszRM9r1MN5tPZSHmy7hnR/k8xIQMBIB+7q?=
 =?us-ascii?Q?dMX/0eg6YjgSlamnifeCT52hK2RiXz1DfQouNUsKbNZaOdfhEqd0TnrkLOSD?=
 =?us-ascii?Q?VT7f+vN/7Geqh/hsEYmOEJ6r+GPbsm1fkUEPNMGBsw0CogvjH4DQBOH8AN/o?=
 =?us-ascii?Q?EZqpH0+DQeBytNdDTjzA7lMuentUxOLwuxfec1gCF6J3XjzcTx6q3KGPn2+c?=
 =?us-ascii?Q?spbG+k3O6pA9+Q4T0KuQ7vvn5WqDVBhU08A2oUlfg0gAAJEu8bocOkt8ItFp?=
 =?us-ascii?Q?/2HfKd/+o7nYFI8jP9p+s5egl6acv6Rsi97iqm/PTIuCXWf4sC5lBMcNiQnl?=
 =?us-ascii?Q?LjrpztfSSWlD1VHtR8pa7Kj4HPF5dvvmPh+meCu7Of9ZN7UdYZUGarOkVKpw?=
 =?us-ascii?Q?VmzKLDXBSz/doPfS5PQZXra5efXfrWQqNP6W73w1JCXNhswAAwVRHuuRVX8O?=
 =?us-ascii?Q?M8o3e3x+OdplSd0gbTXOFjjDEq6s+rhXFINe3XsrIRIvWqZZzJUWVyMkw02w?=
 =?us-ascii?Q?0uXRC4RikTuvbB3wQKw33Ka1rKI4F6rjFKZg7FA0OCYKCKhPjuDVNpzc6iN6?=
 =?us-ascii?Q?YZerEecFbeHj83koEoc5PfN7ta00WsQk7wkGLZJ6kq1YQK38oiRx4XDUrhDQ?=
 =?us-ascii?Q?MB5VRJZceHDUIC2U82waOZcNmsXfCy9Vn7uC4eMyf8cJrpeXDJZ/YN4aZ7H6?=
 =?us-ascii?Q?+0yN3zBn02cx5XAurZxI1z54pcj5YVk7BrB7w/XJ4Gy+blnyWxQSpavPT1YG?=
 =?us-ascii?Q?xbDBp0A6wv5UohXXitTyUvzHXPJJmRRCDZRdA6WJfwo27XcWcV5SMcZ95EZu?=
 =?us-ascii?Q?DC3Oa92Ummn+YquBn3iBcY19fBm52fk8mU9uTlNeOCMBTd/suZ8YMWI7OD3w?=
 =?us-ascii?Q?a74b8bCS5rE5oVeRiVtd2VH8HBfNCzP/qR4P2z+t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZqE5/u7EdQsNy/rv84PZcsL4aB7w0Enp22myzinrV5TwrQPry4UBCqzENjC11A+9vF9WHBIjSW87ND3zCusM75Fkuqu5i5SH6wymvWfIJw5QNBT/vLqI6M/z2n76i1ivYsL6BEesDR5Q+1SDTHHYd40selsnax+oiYIJrbeuvA+XB6ZORXeiaiSWlInuuytvpMfbG3Fga44HuQPB743GIgrciTsf8MXI60RDHlUlai23wWRBLVtAyAEEtaZmQaL1Y4J21RJgoTUbh/ujXqlEzrrowd/OOmvbDINJ7TayW9nRvLBuEkijNjiXkszIfk90leB7sYh+lYRwsBkU621yN3Txq4TzL40Pg+cB2X+eC6nOzpmKjOyV/5NW/JNHH7ETj0ri4iuNsvJKkfqL/kYKB19fx9qzey7/RrrTmk3dEa+ofR0l4uUwsw9i512/UACqOu5Pm+Mb5YYtA0fXwslN7HfPrnC+fT5TK5clNTq4WFlDDOiYRa6zvdLWZBUlb20K7Ma8c2KJdQrjZglLaQsXc+TFXX9ljXt+fzc/vEPcpaJB6i7nXtcaS/VA4dUc6GONwGmMriCqwjlFK87h7DootI2HNUtp3fJ3046OtBjBxZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ece7e1-9717-487b-3507-08dd1dfd692c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:13:58.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBx7gOKtgWo5bLp1B7bO/NnsxKy764HqV9pcFTt/bEXAgBOhMno6slHWPP7PmTKBY6OUkx7KqI4dReoPRsneJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160152
X-Proofpoint-GUID: Tg1IedAr_PMV-hhTU_eMjca_p8sfz0dk
X-Proofpoint-ORIG-GUID: Tg1IedAr_PMV-hhTU_eMjca_p8sfz0dk

Refactor the logic in btrfs_read_policy_show() to streamline the
formatting of read policies output. Streamline the space and bracket
handling around the active policy without altering the functional output.
This is in preparation to add more methods.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b843308e2bc6..fd3c49c6c3c5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1316,14 +1316,16 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
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
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "]");
 	}
 
 	ret += sysfs_emit_at(buf, ret, "\n");
-- 
2.47.0


