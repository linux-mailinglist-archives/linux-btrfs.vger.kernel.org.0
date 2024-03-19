Return-Path: <linux-btrfs+bounces-3405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9DC88000B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79A7B226CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D4657AB;
	Tue, 19 Mar 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n87WsYg2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s68Xk9Kn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25264CF9
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860242; cv=fail; b=DtfMvaxio0lPUrbzbe88BEExu7LbcKwySsXDR1DeFcdVYgEqhA309ByFvMNtkgxvp/8OOLa5WI108v7iQFTC0I0EduZmzFg31DWkKMtFJhoziyyG0RQf/WMiweuf5XHNlwQTudKJ8I0BFUmkLskKagU4Vps2O8ntRatSBiMSCRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860242; c=relaxed/simple;
	bh=TkJ6s64HJVqnlg8cHIZcZ9VhZNAOs5XiJI5Ejrv96Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dzye9BL7EWN4otiSwubsfi8frTKknobxVfoJ9GY9vqsqn7KJoPCl7+F391MioRwiZnyBvv4Rbov755E7Wd+3phQYeK3I09w0D10d5dXEZtP8Jt9Y44GyMw0jzHJ0gbe/lu9c0CZ5Md2qBpF+uhCjO5T4jDLFg+MvWS8rWfZ9HZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n87WsYg2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s68Xk9Kn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAIN3t020295
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=rPzb4O9qialp2pTUsThaQCMa906tXytx3MvOKUtu6f0=;
 b=n87WsYg2UG1OdUK1Ex9jG2pJtu1B62JvrTvJkTrWPj4f79P+1LOOFWgfsiTOVc1hPBt/
 dr49Kh/u30hGlXtr+7VqSK1acudMl0AHfK8zslyHJpDUyvyGmjNUqoFOW7wrA8OQ/gQG
 CVnvOggn1ETLjwBWMtxEUN01JKV/HZ5n2PVAUr8PERmyD1o5pyw5eE7Dqd7AsoIF3JhU
 rnlDMDzYm17QbOE1OjbDkFd5dPw8aptGAiSN8H3xdJJOXTBCFB+Dg6jo18gN3R5Dvsan
 AYivVfxvYm7voXzKdVVjIG1eNz3LIg5r0wPlB+6OfGjERMNP8n6tatzlLxQPH95iABOl iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3fcntjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JE2UnU007529
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cn77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0uvDOY6daNJkFQycDDbDejfUm8MTbsNCepEwZ8S4U1KvnNbEk1ZX6fWg7K3JnNQxiXYrgf9ShhWagbG3SAjzPYZUG+URAQZwHjVnMq4hHtctZ2CHVWV6DjHcS0W5zAJ43OvTX3tHdoZIKSXkzGW7TNgmJNOOIw/ndZ5C9yAnWgFOVqPkfWirRJeVPmJgAg3QzSTTSYDFLJ/9zcUG2k/NewpwWjKRynmpR1+axuNoSMVrl7UNGVyiAgSCGvSqvTzQPCw2ZpHeHKdwJmRUmeRuzANjOQFKOowyYzgRjfll+6cNX5n85WLf+sgYkTyIpqtdxrKJqyd1y+uPL7CmXl7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPzb4O9qialp2pTUsThaQCMa906tXytx3MvOKUtu6f0=;
 b=jFAEDKdAB+A64ijHkb9z+Et/b7HG2X+3tr9g7ply7nzINpzgqzHrKqG7K0epBBvbg1nGTjyrSCNuP/BrK/UgKz0/PyoCCJBg4zzKJ9XVbYIuq2k9fJjHDul2nnI02J651lz2xEDz89+OG9PTb5etNhGQDug9s2bSXrT40wAiSrORO+eRI2sHPXg3A9Nf1W526vUmo68RNqqW6GQ5UQUJ6mwFKIlwYl4WB0PfRa/FZqKiS1QSxGPyRnWEDO7kVWG9NAdquVIkRRhSm26SJZDDxzDolMkeg8/uRemtcDOSTL27A6dFB2wAO/j+H6OKydlDnppNClAPw2xJhfzGQEcLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPzb4O9qialp2pTUsThaQCMa906tXytx3MvOKUtu6f0=;
 b=s68Xk9KnRpvqxOmqbXbhkG0jZd70pkrjN23yOjAsNiN0NHL5HEKMTBdFHvQbXxGWshCMUQRkOgD7yjO2lAXn7s69nYeNr2oqjsE2Kmoxoxe8VxBA4PtBKas1m9iGNL420p484amf1QFkd8TBhpu0KR2vDmMYGdjHAOc0nzORn+Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 14:57:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 10/29] btrfs: convert_extent_bit rename err to ret
Date: Tue, 19 Mar 2024 20:25:18 +0530
Message-ID: <f87d84b84c06efc34929600439222bb3b64e7ffc.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7117:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/6KXpEtGKnMCwyzFf7f0VEEZKxfU5qM39G9TfqWrQyhjyAsFyiWHZ8WcqKDHHlrxn1puwWGFAJ6Vq66Ju8t7Yr2emgu/sWqT5CpjSWdI579GqY7G65a3Ld076GJ2QnhilQk+mMNNkKQXjp8N//Pzg0JTM8APqg25rDyW1X/JlmbPsuoBxybyfB++rTkZ8fXO5CLaDhi1GWX1d5Io/HKKc3qW79IL/KbTjxC36sOd3soxlwO4iOGjBhAIY4dKZz3Rt+E0kCd3qKvzzEQH8oE40IarEUoVFmn7QSCef2sukmEL1SXRxt8tkTxPD5NeEV2deAbHOcB8K3pq/9OeAH4yqZgglN12cP31t5fk33PO6Mdp1FC5qvIAu5N+FroU4P6aeRwiqsCFT4612XPjsptTFTkhwY70yCtWTKxDfCex6I8zJM+efmQ+Hsl/JnJW3h71OmG2iFXR2eluJbj2Xm+j/9GQjlVE2hbjwOyWEOT2jUrEJLKdAt8EB3UxznTlAInHoVeErejE25SEqy4N//TidWLgvK+0SJlfSwn3A1qQ2HFILrSSVzTLorOe3WQyo7D8v+yXqkIhvnO+NzWh+A03qZs1dOSmUYY0T+Tg9zHP50EqH/PzhoPKF7rSNMrpU1z8b24WYOo9Ld6l+09WTjXJ9wcRcu3aH+Eg5Ky/09U7GFk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nsKxZgFZL4MRwpF9z34GxoOPLrHt/WtUi9/L3wumn9rL3Pbgwfvb3XewoBv9?=
 =?us-ascii?Q?XohAKbcu0jPOPjiYIWZSbaNB6Cn1exEvnZWD50vyIIyUjoXrLnDFxdnxX79N?=
 =?us-ascii?Q?ItgLqINBSAYbFXpndr3nLGOlxPyb9NKSs3kaYe0iPHW9z9aGze16kDqUqYqE?=
 =?us-ascii?Q?Rp11QXype4l+rauZ9lwv/tVdhKFYCkcYF/fMtsQMQQpDQZBKjeykd02/Gcsn?=
 =?us-ascii?Q?P4a7C68UBX8lwM9ks/jYKmRY/ek/Xfqmxzhc+jIDu+iID2Qq9WlW0Prl+dug?=
 =?us-ascii?Q?eRjhlnycw8kYvE5uz4PXx4vcFyV/XBrFoLF9eHYOwmGJJxcbSa7478Zjg4Ka?=
 =?us-ascii?Q?SxklKufwY/clNgNGEFjDsqWaRT6wx/rkNXRlVucVH5f/nm5GT3rZjOcdq4CX?=
 =?us-ascii?Q?xtV6Vjjh28JZ8JJ8s4xQvqEKE6kBsJ7+4A0P16evf+LYHKIKQZxg4OTZT6Xn?=
 =?us-ascii?Q?UPc84P9nWwHQ6YXFYAxMKI875yDEYFpP+5chGGbBqqqC/HZkUhlMnyj5s/sx?=
 =?us-ascii?Q?Q7JnPC5jxz/zexVExXfam+W9HqNrluAMfRjaQWcxgsFjeEFEY1l2Z5tQCN+y?=
 =?us-ascii?Q?+xv4RTnYMVb3bgW2cNV91EJPfZTEuiQ7hsSuIOcTc1/2BZYINHE0idByf4EQ?=
 =?us-ascii?Q?mb3FOTAAK9FsCkYS0RCWUhB0O9TjfkFBxFb5H0yJZHI6q06V3ufBD9YWMdrj?=
 =?us-ascii?Q?KOq38GzcICFKmRNOfmNFhoipJ4KqmiXo9Jl9BhMjCmXd47uKfY5xhYfa/hRT?=
 =?us-ascii?Q?2GOFoIty6fVECNcoWBahO2z8Jj5XYzl73yYXoEI7sK4o+B7j7Tx/32eu1Q3h?=
 =?us-ascii?Q?wtwDErZQQALdXB8VVPI6fIhL1te/0ByNi3bxKxewns9kfFDAceBA88EZ6xpX?=
 =?us-ascii?Q?wLWOYgwN50EWjsxRBY4nvgmQorGqjTVud/J+sLHRhD2Fel7yNzFNCkuGd15z?=
 =?us-ascii?Q?Z4dSAE0FWkYu7oTFQD/DPS9ft92wQqmOKRoyIDmK35G547BEnwvAUz0yfXNl?=
 =?us-ascii?Q?qDaOFnezGJmiBiP0dIjSMM2oAoWWrocuztkxi5Zf4qivNxXBjzn6IsKQNlST?=
 =?us-ascii?Q?7/ClTtL5BhFyMtfTSznqzR2+li0EG3PI6oTQKnOY0sr6ENbH2md7+Cs7VGI2?=
 =?us-ascii?Q?D00uhaUw+hCWZ07Y+BdywGWQRvB0yYGEYV9yKsxASqpXg7TZbQw0UO87xm10?=
 =?us-ascii?Q?JcTvdKzmhcXMZKNseoBlIAcjkut0vVQNir2yl+6iR1mz+/Vru/zKPx5Dyjkz?=
 =?us-ascii?Q?obXiaRl3HHM/HGVBqiUVqFD5u5Ah3gKXR7PrdGjnCBlOgdkBiUOV+f1a7T8E?=
 =?us-ascii?Q?p7LSmfWo9u9Un0yKz0Qr8vq3LtQtdWDrEXW0JYR8UHGDA6bzZluUvEfXJ6l4?=
 =?us-ascii?Q?mIDIeG2YnHvLHiC8linlNEzHYEeXN8zv01ma6chjo1Kj9qRgs/5fo2/ULT1H?=
 =?us-ascii?Q?ACMNJy6t3WgfcMmOkMulagjpRFPlNS2zenRDbDwUVCmGZ5rPHmTK5n7Cf9J4?=
 =?us-ascii?Q?rhzTIdDj0l+Yn8oGpB9LPJ+KCYBT9SF/DH67V2HmF+MojzCI+oHsgqbyzom3?=
 =?us-ascii?Q?iIRy3YPrzGzDjiOMpjni797hin1oNDTlZ2PqOzSqBpLJIBVWShUGzZI/nWkH?=
 =?us-ascii?Q?Mhzze5KJ1map6SyNPdRaKSPBp8dLNvRbQq0JDVHMLGaZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ddZZlNE4QFh6VsnjQkWZUHJXMk3iW1/2BoKNEds+9ra0hLOn/I2QyaM+emlQS9sCju7iXYVCf6K0TTGTr0PkKlXtpA3mahnId/mST/aeCeetSdNNrfoKV0NN4Kx6K/GAMnoo4BvOiGatIzXvAHdEBAo2TgsG84YPFaPawkyNLOsOW5u5Fa4NPmqEzUzbVU65a0u5A+YpjsX1FfG0PRnj/0JM4DVaTHijnFyKVDFcuT37ax+5GgN5bGg4hOmlXwG5v2uccwsSlVKvyviMd0m0yW6w+KrU1aZ4IinFL2Es4Fk2mdBaWHJSvJUPu3xyEbYQB6Pghi/ToC4WVPw7Fy9mna1HnicCRqxq+yc9ZOoJMWlr/lXfYh1cpOoRSiKxg+6ooE/JJ1Npycurcms3b+2T5cbJZWsoysZuqtpwmoaWkKS92Vz8mLI8dQOGRUPHqjHuQXQzfrJCy0CXBJlwfRn/d3m2Oj40ZTHRXWKpoqTqW79E2PXPupacZh6WUxsuurDI0ZR29eH8NGOjxiuCgXJjfJWlbpQ3hIBLlqwAd8kELitP3TQmThqY90Xf7p7G6rTeLOHbloep6Y9VKSX+W1bV/A5OELu+ZGVaEHaSCCEANis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01f0e4d-22d5-4b02-327b-08dc4824dd56
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:15.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGUXerLw1sIDmJCJSc91DJLj01GI2BOlqnNyg+F0apOd9W0UOKOoNmq1fR53oS2sSVocRSjfcObcMgTc9AI7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-GUID: 2duYGkBuKcengennezQKCIIGVIjIaFu-
X-Proofpoint-ORIG-GUID: 2duYGkBuKcengennezQKCIIGVIjIaFu-

Simple renaming of the local variable err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent-io-tree.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 0d564860464d..ed2cfc3d5d8a 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1312,7 +1312,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	struct extent_state *prealloc = NULL;
 	struct rb_node **p = NULL;
 	struct rb_node *parent = NULL;
-	int err = 0;
+	int ret = 0;
 	u64 last_start;
 	u64 last_end;
 	bool first_iteration = true;
@@ -1351,7 +1351,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (!state) {
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc) {
-			err = -ENOMEM;
+			ret = -ENOMEM;
 			goto out;
 		}
 		prealloc->start = start;
@@ -1402,14 +1402,14 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (state->start < start) {
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc) {
-			err = -ENOMEM;
+			ret = -ENOMEM;
 			goto out;
 		}
-		err = split_state(tree, state, prealloc, start);
-		if (err)
-			extent_io_tree_panic(tree, state, "split", err);
+		ret = split_state(tree, state, prealloc, start);
+		if (ret)
+			extent_io_tree_panic(tree, state, "split", ret);
 		prealloc = NULL;
-		if (err)
+		if (ret)
 			goto out;
 		if (state->end <= end) {
 			set_state_bits(tree, state, bits, NULL);
@@ -1442,7 +1442,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc) {
-			err = -ENOMEM;
+			ret = -ENOMEM;
 			goto out;
 		}
 
@@ -1454,8 +1454,8 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		prealloc->end = this_end;
 		inserted_state = insert_state(tree, prealloc, bits, NULL);
 		if (IS_ERR(inserted_state)) {
-			err = PTR_ERR(inserted_state);
-			extent_io_tree_panic(tree, prealloc, "insert", err);
+			ret = PTR_ERR(inserted_state);
+			extent_io_tree_panic(tree, prealloc, "insert", ret);
 		}
 		cache_state(inserted_state, cached_state);
 		if (inserted_state == prealloc)
@@ -1472,13 +1472,13 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (state->start <= end && state->end > end) {
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc) {
-			err = -ENOMEM;
+			ret = -ENOMEM;
 			goto out;
 		}
 
-		err = split_state(tree, state, prealloc, end + 1);
-		if (err)
-			extent_io_tree_panic(tree, state, "split", err);
+		ret = split_state(tree, state, prealloc, end + 1);
+		if (ret)
+			extent_io_tree_panic(tree, state, "split", ret);
 
 		set_state_bits(tree, prealloc, bits, NULL);
 		cache_state(prealloc, cached_state);
@@ -1500,7 +1500,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (prealloc)
 		free_extent_state(prealloc);
 
-	return err;
+	return ret;
 }
 
 /*
-- 
2.38.1


