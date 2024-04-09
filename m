Return-Path: <linux-btrfs+bounces-4046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A2389D152
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 05:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC4B24ABB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6F755E45;
	Tue,  9 Apr 2024 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gyNfd4Ul";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fHsxEtIR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A50548E9;
	Tue,  9 Apr 2024 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634731; cv=fail; b=oLTIliJpK0SukrTQwVTLeT/G6t1LoUG1S2DWmwabJmOb+FQ6679OVLI66ncekOeeKTeSGRnjdeh0tPejwTeKNls2It5DZmmohW++Y/YjSmGYKFzKZwKKWGVgOgcgjCE4zQPLCtZeXFwAEdJ3wha4yRxbJ6g7SL9DZ33g9heGtoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634731; c=relaxed/simple;
	bh=VpqqGj2pROzlESVpmr/P3c/97lrul2dTqfaavto/w0s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ka/oVJiLbxMXbzSLeOrLp8aXxMoFSHzxIHSCupIBYZROLkZ9bChAyKJTQXhyfNECMR2pfl0N7rpznOz2cfQisaqR/Q27BrsZ3ABTTUGc6iUPeGP+zqBWKiLv1QM9stNXxvSq1GpElwusdBgbM/iuJUkkz85WBXlnv2bfVDbPThE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gyNfd4Ul; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fHsxEtIR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438Ln1CM013157;
	Tue, 9 Apr 2024 03:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=vF1pc4+WEkywmXMLK8upqMMXdzUtcBU+4A3TMOyBvJ0=;
 b=gyNfd4UlvCjf5kizWKnJ0C7IX94R5TO3ZA1Qlvdcd0GljQE2OuZkhx8DD/CzrA68MwDp
 5fyP2iOXB38IbQzDvV0g6UG5M62Eb7lNDK9X1C0hbnEcNygPS+F0f//ojC8tpDot6QJ7
 rcnPJbEVGg2fQdCvv2jbjQvVuj1brNkPfhgmjfkjnVo04YuZfDIC0IHIp/m59EpbB3gF
 zbe1vV7g2/5jg/v0DprYErXe5XvRc1q8GQeOO0Vzb7MZJ+1b5i6AWIsaCXBccuksixfg
 9/cfbCSuQFhSc2o0vB+6TdnzAUgdMTUboLdVpJI6lJbquBzPyJJnQfJ6O3s57dIt04gd bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf45wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:52:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43920ZAE020214;
	Tue, 9 Apr 2024 03:52:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavucb129-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 03:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOu3DXUcm9ltPOQTMcXb9BDF5/no/VbENd2q70UFj/oAm0Ch8XXFDXUDf6JhEqJWCH4drdBofmCUtnnq/ehzDJ8ooqWwLoRUoP3mK3BTuDMFlsP32xZH+wSzm1InO9RWoBGZ42LJ8pWhbRuIyw8c/E+/oAWd6SJLADRsh4VJZnTfiNRFa0ScJARUHPgyjmhXudrI35Is9pb5SUP+TrgwwlGWHHAYt7Ak59XgnYJmYt6eEOH5hUO6PQqWq3vFB31NLYxlsZyChadqKnU0GGu7q1HKV85O1e3761XMhO7YG8kiX8VvmzbiDYaYPMv0FCHcw2vBwPLmrMkWe7pIR0zTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF1pc4+WEkywmXMLK8upqMMXdzUtcBU+4A3TMOyBvJ0=;
 b=heZmFJe/tngQCdRGHCXB405UwohmhkKoJsdNA2ip5u8Ga0OfwdUb9rIumXvi2vAhJg/3Wa1Zuzz7K5CzVnKS4XWcPVDA52gHe1BRUNanJtAM62HnuhI+zJJejaX/2QM/yMqQe+0Jdw7F16dc/B7DIrvIGn1bNGcqA2TI3FB5Ylbtzp0dFy2f6XvoU5cz9+J6zU8KSuJMyk7UfEg+8NNwrPGB0D3sfOsPpO0B+wNiVShyUb42dBRuR9vpgI9pV9+0/mH38KEzF58KTXh8iyx3/B8rRei8KWvkbXQGmH2ggyXXi5YcNSAPqGUm0GrKte8tGztrNcuhNU8SXITYQlt6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF1pc4+WEkywmXMLK8upqMMXdzUtcBU+4A3TMOyBvJ0=;
 b=fHsxEtIR26qnHt56yjtEpZ3J6Td+0PQoB7fDLCalWz7Kr4VETK/aJCD3naPpv8iCiHQNLGqX2ccW+wonAZ5jXZMx4c2F+hVEOstVjTkCsIoQQWYwWe6UPfpw30ATphmt1ZOCsNgMMmsaIu36/mNuj2SECteEfEgSuo1krhjHzpY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 03:52:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 03:52:05 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
Date: Tue,  9 Apr 2024 11:51:11 +0800
Message-ID: <703aa9f2e34bf4dcc1fc5eec7ef4f65a6705ff14.1712634550.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6636:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h54Mw1US9zLklEBiQ4e6q9nzyhsji7kKNF3MpUWEUBwfz28F9oVfqPAp86au6I3X8op/w0cXI9ORjyKrDP1iO6UgZUobi2MXTifOtOw77IXgdx8kDbu8sD2olCwrg2kXv8sGiRN/g8cZxTQJ0E6roR+IwIpRTDJSRAUc1l3JFTbGvMCqrFVlFq12tz2Th3OHUV/8hUMJJdgM5I7iYrwV+zu3bV7I3cDjXjW6Eo0dF0VR7tpanopEz3BMLE/kllkWmW+ON6IHqqtTcq0D1ETFgvxs3snbaSBcZecxSuZO4Yr9YAPP5EpAfV8W76RFcR0dMRUsYdfUAJaAjYwyBZI9gvuDZLDxE1//HHw/odNwUpHpmos3tdGSkQQqhtbGJpOGPP7E1r3S0O015QNwR+rjHTt1AeJufWKnZXRNeXgqfXSPU4sEDr1e4rAbl4QR/nb1nUrWzPSd+jT/9wGmpLxMXg9U7xHryKm6BuRGjOIlvDpMXLbOeyfjllvoCwKGvBznWhejs5j9qQLHN3TuuPEf7HRt+m7a8MS8tHxhQWpdJHiAfdRZB2ePWXd+883EfFn39qdVbaBsluhmG0LWfBHGqm0gYSsK/w9kL32yZkVP9lH5eYfOqYNHUqhUBhoQEPSqA6M1AJlNztcYJuEPIPEhoanK89kjZCEQxYZ9ImZ9Z3o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a3Auosb20t3kGkGxgQUxw3dz5YpG3UKKnngzdrOD30WTNCzNwYIzuTFv7MF4?=
 =?us-ascii?Q?WFy+sulgt2Ay6+HNYhxecqr83Crv1xUpQqE04gjyyuPT5VF1mJN7+/RiB4xk?=
 =?us-ascii?Q?gp0WcZTkDAzl+Haf0qOo9npOm6mUhiKjKGGd/ze+D8voeEmwL1P0Ip1eaRU7?=
 =?us-ascii?Q?2yuLAddHNkfWk1Bdwf2462v5H4uMfiLm1Ve+EczI5qo06xIQG7aTvHXSJrBs?=
 =?us-ascii?Q?eJQ90QFpG9IhufT3zaEzMxq6YENBtLW/4XoIvoiNCQ6/pTOdSiW0sNIEk0kJ?=
 =?us-ascii?Q?fZK3ki1pvKMKSJNSLv1eBIz7mIOK12ZJUAWt1JGZas7ZopyCMCTe62x0n0od?=
 =?us-ascii?Q?5D2jonw/enZCoGrNgm2kFRj+9spkXnBgYjfGBaAusQp0eXDuva2NzE3bn5Km?=
 =?us-ascii?Q?eVilHE7WBmnEycBljNx/zigS5zPRTK8vd3TxuJqrD/HdXZP3QNCn+bSg5YBr?=
 =?us-ascii?Q?Bm/zFe5KWS+TNZaNbLyuPRlFJs/AafJwhVxTaOhfbMkue6CVxCAyGQn+3ia4?=
 =?us-ascii?Q?nyFWdpca2ehbOkpm2sPOoJR/Y9CBsZ5FPmk1BZz9g8PSZptt8S9g/9/WEhbI?=
 =?us-ascii?Q?LGenqGmNjooxh60rlWkXeP9G83RTg1OA3L4uHGdAHr49TUL1h/omMfjLpGjg?=
 =?us-ascii?Q?wDas6DbijUJuKXmD1luCRl3QYSkSmBb1hzRBZLZ1CXUa4dq9U2ztHOYU9+CN?=
 =?us-ascii?Q?UTDioyxgBrzc+K3nAfgORnMroME5N4k3ItLbB2MVJTH0fgdmqGZNQd/pCCuX?=
 =?us-ascii?Q?7pxFZgDZS0U4oKOFvnAv6LH8cp6SZ+TBQNw3aaP8RiuFx8k6iyONlBTPTgMl?=
 =?us-ascii?Q?GOJy7plEn7ej7YtDJQMvnApqv15ADduFgGf1HUsBXcG3RqAOGzTvaCeXPoqG?=
 =?us-ascii?Q?G6/EVTRuGFTncKM8XIYe/gdddfPmI4YuUaMrZ2y31glA9U3inJt5PcfbmQeW?=
 =?us-ascii?Q?uPanOjOl1NKDAKnfRB6ILFZaXh9tAsSY8nKJKOwv+mzNVz/zSQeHUNTj4BDR?=
 =?us-ascii?Q?QQ9HLduC+NEgHMi3AEiTMrT2n0gEoiTVAz3gDs70S9VwKlyQEu/zx1NgOVJp?=
 =?us-ascii?Q?Mbn+3gZcBegG0bCuwy+bBupZHDliqJTwZlmH/i8/f7OlBsNZ+DcsJd2oN+Fd?=
 =?us-ascii?Q?gxMOBmtmJb7w7LmrJfK7/3IMtfLkDzl1MC9UBzJKl+o25lNgRGbM8vaHZgXb?=
 =?us-ascii?Q?6i2jtYgfMpM0gta44D6uQ9417c+Y/hlR2NaxX50Nl8DTqQ2tVk3LyXnFAfyq?=
 =?us-ascii?Q?59qdJYrXFuzKgC8yMXwXxCiGPsR3CPpm8TXNMReIuLWG7ZHLdpII8ovs1Oft?=
 =?us-ascii?Q?IFd8hQQ9lVq9ETR8OQfxCX6mZs3+oiUH0BMiSw9vIU38omjJNraG4rdoMAEq?=
 =?us-ascii?Q?m8HAAIyUADBxL1wnFtrzmW4OUDYrYSyOPYHDdjxsY+jCCtxcbnUp+c1AVQ0o?=
 =?us-ascii?Q?1cYbjGib2qpcw9E9es9/xUmkOWxh+ehWujHyt4s3CmNmT1ayb9pIMiuufQGr?=
 =?us-ascii?Q?35Z1LneuX3HDzS7O9YLYYt8ZfEZn50Wv/YND/w7Tqht8Tl+EqgIb3IHUbR6Z?=
 =?us-ascii?Q?1z1xV3ybLTZzRa8zRFkaMWogdgPjxdzg7pDCTv30?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VeJrXKxmm/oc0FL9+4xbCmrY8n4eR0/jybGyYu/A0NMOlH7yvCfq1lOqkQ1fud2tKv1f1u4Gxgf8RcTm0+F/4dO/oQwSlsrX2048XFVdvDjpqLr7Vi4FNyeCXdmD6GCqHF7yAr6YD8MVvPbandhrVxCzHKvzgTAixCAUzz61Umji2wPzH45oeGgg/X87kLxfIpn0D0eGCfbbdXuGdrnR9fvp8fVEcUF3MnsXSxiWeey39l5MbF23pSwWuzKdsiYyHlEYCv6Immp4XYzHatVclo0nJ5KQVpiNHyG8WT2Ey0tx4hR7iPAk4mLsMny0raXkcQWT3ZBitTlsxqSabNcFa8QKG9AoeiY+DBVP+zs/LSylWTZ29abAmVtaUwC37S6JKmRRqLNHmcUXMC5UtMFGE1C21MhmqvGLbFiUzT8d6xd//IZSQR4O7/2ZTu4tGelKxHNnRDe31qJtlZ6lHNJEAkTHV+a1sADavHg8RgHFcRR0M6CsU9Tsy9dUOwsexoS638r4wljjQS7yuTky9vQWfu+0Dz6QaDszj8Zo86+Nb1SIIJI0+qbG7fjLk9CRlUFLTFbY70dO1YFs5sDnuqElcoJXda84a7iutsO0iWFqYpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c18202d-578a-4858-6636-08dc58486bed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:52:05.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OczPlhpok90xJG6wTzBcpLpVZ8WfCm3x9ueUz3xGfxNofoEFafIM+aYRw+cKUveM5HHISrhukK3MQaCjty0fQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090022
X-Proofpoint-GUID: TObSJoHEu0E9VdS_GGM0qQV2Bc4qOqxp
X-Proofpoint-ORIG-GUID: TObSJoHEu0E9VdS_GGM0qQV2Bc4qOqxp

Use SCRATCH_DEV_NAME[n] to provide the device path for each device from
the scratch device pool. Also, in btrfs/197, remove common/filter since
it calls common/filter.btrfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
There are other test cases that potentially could use SCRATCH_DEV_NAME,
but for now, only 3 of those are being fixed.

 tests/btrfs/125 |  6 +++---
 tests/btrfs/197 | 13 +++++--------
 tests/btrfs/198 | 12 +++++-------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/tests/btrfs/125 b/tests/btrfs/125
index d957c13911b4..f742d14f858c 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -45,9 +45,9 @@ _require_btrfs_raid_type raid5
 
 _scratch_dev_pool_get 3
 
-dev1=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
-dev2=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
-dev3=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}'`
+dev1=${SCRATCH_DEV_NAME[0]}
+dev2=${SCRATCH_DEV_NAME[1]}
+dev3=${SCRATCH_DEV_NAME[2]}
 
 echo dev1=$dev1 >> $seqres.full
 echo dev2=$dev2 >> $seqres.full
diff --git a/tests/btrfs/197 b/tests/btrfs/197
index 9ec4e9f052ba..196110cbdad2 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -22,7 +22,6 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
 . ./common/filter.btrfs
 
 # real QA test starts here
@@ -55,24 +54,22 @@ workout()
 	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
 							_fail "mkfs failed"
 
-	# Make device_1 an alien btrfs device for the raid created above by
+	# Make device # 2 an alien btrfs device for the raid created above by
 	# adding it to the $TEST_DIR/$seq.mnt
 
 	# don't test with the first device as auto fs check (_check_scratch_fs)
 	# picks the first device
-	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
-	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt" >> \
+	$BTRFS_UTIL_PROG device add -f "${SCRATCH_DEV_NAME[1]}" "$TEST_DIR/$seq.mnt" >> \
 		$seqres.full
 
-	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
-	_mount -o degraded $device_2 $SCRATCH_MNT
+	_mount -o degraded ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
 	# Check if missing device is reported as in the .out
 	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
 		_filter_btrfs_filesystem_show > $tmp.output 2>&1
 	cat $tmp.output >> $seqres.full
-	grep -q "$device_1" $tmp.output && _fail "found stale device"
+	grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stale device"
 
-	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR/$seq.mnt"
+	$BTRFS_UTIL_PROG device remove "${SCRATCH_DEV_NAME[1]}" "$TEST_DIR/$seq.mnt"
 	$UMOUNT_PROG $TEST_DIR/$seq.mnt
 	_scratch_unmount
 	_spare_dev_put
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index c5a8f39217d3..ad43b4d1b59b 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -40,21 +40,19 @@ workout()
 	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
 							_fail "mkfs failed"
 
-	# Make device_1 a free btrfs device for the raid created above by
-	# clearing its superblock
+	# Make ${SCRATCH_DEV_NAME[1]} a free btrfs device for the raid created
+	# above by clearing its superblock
 
 	# don't test with the first device as auto fs check (_check_scratch_fs)
 	# picks the first device
-	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
-	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
+	$WIPEFS_PROG -a ${SCRATCH_DEV_NAME[1]} >> $seqres.full 2>&1
 
-	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
-	_mount -o degraded $device_2 $SCRATCH_MNT
+	_mount -o degraded ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
 	# Check if missing device is reported as in the 196.out
 	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
 		_filter_btrfs_filesystem_show > $tmp.output 2>&1
 	cat $tmp.output >> $seqres.full
-	grep -q "$device_1" $tmp.output && _fail "found stale device"
+	grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stale device"
 
 	_scratch_unmount
 	_scratch_dev_pool_put
-- 
2.39.3


