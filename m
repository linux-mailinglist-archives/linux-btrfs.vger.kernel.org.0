Return-Path: <linux-btrfs+bounces-4398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827B8A93BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85231F23279
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C903FB81;
	Thu, 18 Apr 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JHE2n4/b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bFxhjfC+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE52D057
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424190; cv=fail; b=eHCui4hnTKl0q5TIqO7qUIspRfoGeKzpSabJ/1Rp0hxZDIHPyv8C3qu9k9vtQskqx2ueH7VfbI26Sm6KP4cYDH2PO612laPthG0A+fMBw5P7s4PNx+K45NiLoV11AoiAyxIDKMn+mFI8mSfTTzaz7pRHg/Bx65Ibdim9VnQXOyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424190; c=relaxed/simple;
	bh=uqW6ZffV0WtvOy2ZiaXEznkP8aJWO8KGwAN2vdUqEGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7JEN2nm6D5qNEddQIvNNunjn44MsxqiYj5HmPKqzQfU9GA5VcoAhQckBGzXO08xX3w1DV54jwWltFwYVeMPh6pvD5BmOM8vFLI3YwMavVV3etKaePc49L0sSJ9zrQ09dkpZB+C6bfnoTaAJW0pceTbNLbxYyV+jKhGa8PA5P/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JHE2n4/b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bFxhjfC+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3x1H6007679;
	Thu, 18 Apr 2024 07:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=1XGrUsx0tMcN4hQa0nb9auuJRHrmZ6FkMU9jC4cGWPg=;
 b=JHE2n4/b3pUeQ/386r7wLXOzE5fz2ECUKEqlMennGupzUNgtXeulrwS0qF/v38CrZWvd
 FLln5LGbQD4tTsIJA/6o70ogxClVz72Q0dULWhFdLWYBh/tueXt7/IoObd5YVfEYIYfe
 b/v5mA3v1CW5gVcNHqXYKEWcBhqSvNEq/r4dvluMIvPK+DKdgvHEGCoyTjRrLPC+BynV
 ozdr7jsUxv6iXK3Om7rwkyLnJqBP5d57pyGmXGFWTSVDuOgfCy80RIqN09mdK09IbBiT
 pylpQ9j9htpdD4DbTIc5uwlvBokzPlHNf4bNU2frvHAQ3v+x/Bz4smtU/BoL2hT7qeiN fA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2smt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 07:09:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I5ZLin029293;
	Thu, 18 Apr 2024 07:09:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y8r1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 07:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQwa5pykysR+tXawzE9DAc1BR4PgTg1iJk0lvUYQatbHiQrqes/8TUZ3Pr8AV+eatXMbYnXAPq3ghtsQpa2HCFq3CgRso/6cRNMzKh/OV6dVPQ76HOnFumk3Ysqn49CeG5cBLh3GDm/FhDi0vbImAwQz6Pp0VlqyUdzP2nGrGmcE4pGTltTarjE8zwatFnWRTHXs9R3SyKHhr9G11jpOiP+OHIrHW6hAsTu+u+qpB9s5n0zms1+9bOf20yfBSiBd+eCwxwXsy243fatWMm8cOOB8iV1YxCL4Pz8OrTd6Uve0bWYOZ2Wvznwhqfvlsbe7IGxWDqME55j+CShIu4NV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XGrUsx0tMcN4hQa0nb9auuJRHrmZ6FkMU9jC4cGWPg=;
 b=Z88vYgbgPliPX18Dpe1zM5Z51hy+zeoVaoNKT3JTdoiWqxZnVKB6JWBmtHId/uxcWVozGbPBuJLyhMJJekAeTFyiZ96SyW1PvbIZAlDd54EazxbGtBPeCTO+EX/Lsr36Lz5zvwSfHpWqy8PGijz5Ppv63V0PrmcAWh8eaLbM/Sb5jf5kOZs8jafg2v5trSIKozW/QQRTpOIseGdqDbjxfwBjJBXI6Jb7P6rwxDbDa22zyyEXnrJ9FgPqimAhhD0emjvaeeStEBh6teKjYkJ6LsYK+s81K/0vcr2bZuOylE/Hw7pD3v/O4PmfXTvhhMMBDIXJa+2mpCNomh0kgQYJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XGrUsx0tMcN4hQa0nb9auuJRHrmZ6FkMU9jC4cGWPg=;
 b=bFxhjfC+H7eAVEonHyNXdcSiV8owvELbSytxbDm9oeMw4Sz1JN/odpGl603WCZIozmMtzQwJIxLTmcDvML0wn9L/iC3GYfHRHWvd6BMHOTJ/uN/JcIIClRH/zmlipzdKSJfZbqO0TEt3+A3F06djhT3gzkPU5cTIMhkHp743D1w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:09:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:09:43 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 02/11] btrfs: btrfs_write_marked_extents rename werr and err to ret
Date: Thu, 18 Apr 2024 15:08:34 +0800
Message-ID: <5ad8b149fbf1f24b3610fc129b24b85196213ec4.1713370756.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fde56be-d265-4509-4eac-08dc5f768575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ynkEHDX9/RjUVmjyjOS6x7OXzAmcZftau46s36M7IzQfovynMvKPMsyiioazjEQJ9VU3tckhveQmjVDcZNALf0uu9nq6QPlFk7+W1E44PoHtPd0nM8RSAJTiiO4Ku8zWLDpqP6RMkiOBj/2WYH6gfGeSO262zkXee5Ze9wdYg4CNEubdwmKG7YEJ7NjItLAKPmsAWMo4KIdmGhLDKPvDfKoKGAXc/noyUDVmmqruB/xoBhDj+kevDpA2ThbgfGvW+JemVRKVwmxfDG9ekEz4tuLe9dh8uoEu9nqDSXmIOcwSvo2/DPxadTb2QKt3TF7EC/jI7lZ2MP7GdRVwLMrDcCSqgF4Itn9oA956bMYHUMFJlWj/TrCmBDwFgkvaDi4DppwAq4F0NR6MFY2naswB/Ha3fMlG6ECbJ4JgbiVj+XGjAHGVnHlZvZUqCUKeeGiqRzT8XfH5cjt4mmW7xXs3vmFPPsWDPeiA68Wr31PPdf26KsX+8n7dOz5XZX1qfLB1E8w/aJJHFtRqkQNMk0sGryipsxBmOuxiH2QSomhXrfRJrJqwXWLovRwCyqtxfDwTbwPGAY46VDeReOrA2Jg3da2++737XFkyQBVP/BiH43FEUoAxpwmOQU3lhMrhynSmvUCy5HWvoYXmkZMIPdhoyiCayo+jwJ4rmU9CPUZyn+0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qvOjgKGbNpzQZUBOyNWc4P8FpCBs4YPwWVhaVuLL9Zm9Qi98qrfDULJ+aLxY?=
 =?us-ascii?Q?01L79dileMUKJL2ASx6SSxicjsp4BAGS/zpAOLnAIGCb6ib3OGQQFTu50Ezj?=
 =?us-ascii?Q?tG7RXghJGR9zxOSmvw5x3UVmFd9+yP1l+Hm3uPytpZci4xbcRua2+CppIcFB?=
 =?us-ascii?Q?JSZ6H3lILz2kfMKKNeOpbyXgcnhCSCo9wmydycvquY62kLq2pftkESC22NER?=
 =?us-ascii?Q?8gxpgWy9w++N5gzMRwBaXhocpgAzu22evtug2/7Px+s808moPZ4J2H98Syjb?=
 =?us-ascii?Q?kREPYC6JNHhdnqq1Ipv/9uUMkE2hHSVDqv/5R/xnA/5aRiaH3xtCdmyeF2Oh?=
 =?us-ascii?Q?fNoNEoQKhs7eioSPomB8JESRB7Gp2Xm8utXhPqHb+j9LHgAlUdjv3g5iACnu?=
 =?us-ascii?Q?rW8h6sHF9paAyiudMbCMQe2i5+P8Z4MA97/aKs2ovTcl/Amull/KZVTVB+HV?=
 =?us-ascii?Q?9e2LuyEentF25gKMyJP2a1Yc5UinI1qlsAsfG9D+gioIZ2SsE4cE8tExm4xy?=
 =?us-ascii?Q?fiRn/7jDdCN2DuE6NVlSW2c+NwWqPoU+f0T+mqyFWqGJQIIOwegMiCpnzRng?=
 =?us-ascii?Q?bNUyzV6uOZMuwdWtrc/Gv6oKqVvVOYwvG0/f18BSqSVBhCY8m4c9TMI3sGPx?=
 =?us-ascii?Q?zyb616Aq8uqNei1NmwxTGlto00f73uj9cVM/6/tkkCnwLl5F+hoEYEjUYm6Z?=
 =?us-ascii?Q?xYbbUyrGAkqAT7/KgFJf7HD9ZWAl/9pf63DV5d3yJ5sDbYOI+9lTbYTvBL2x?=
 =?us-ascii?Q?oTyFvo90MGFbL5g0qaBtzkMLMBNmiX/aXj0SlsiiROeLMe14VfJaIXNviebq?=
 =?us-ascii?Q?DvEJ5P98F/8xHHexSQNZ1ds+udBKy+XcGPr+orM10gjgVD7cpo7XoyzuoojO?=
 =?us-ascii?Q?pEQ7X+uj9zgM0UjpDdm1us4px0Dp4RJvg+XTYmHYCCJ7F/EtHB+5k7N1I27f?=
 =?us-ascii?Q?ri50NA7LXpRDtHgf5/Bug0s5c7U0Td05OlaoUzDHDalReAat/6i3GUdUndrM?=
 =?us-ascii?Q?xEvaMOUQQJAptAuabUZFdRsKCRrvvanAj25HrrVpR8qtfYxcxarkg+XEdzSr?=
 =?us-ascii?Q?a7a0o07yCzA4bQISDpAw+p1k35Af4rrKPoY9U663qPc1poBZCnlPJ+3+oMmY?=
 =?us-ascii?Q?8VEFdC8u5uNYkEaaw//xM1TDuZO1fUmXsPzA55juqZlLs0lwGeEefbBw6bK9?=
 =?us-ascii?Q?HlCFOSvQ5QgjBi7MRVv7DB/NKYib4TzHqLHT8m9bmytPp483MqyIm/o0KQzK?=
 =?us-ascii?Q?yJ3Gdx0WWnYIQERLLEKMup0XbiBdLEULdEQqgLaNOikYT5vTDcu2Wmnt3Czh?=
 =?us-ascii?Q?MkI5Jbznw1sgCveytfl9s5jmlrZD204JowRht0AdXKKMfMrH5VQ4y3Z/i5/d?=
 =?us-ascii?Q?CIJqtsYWiiu+Pn2DifJKu+G/n+r8CKU96POOZgagBuiHuM3DySfbSp7Gq0Fh?=
 =?us-ascii?Q?vzufjqk5npTk2MbIofBnVkJOPkq9XHfDSo7C40boeSBiWwL5DYr3xjmVZyV6?=
 =?us-ascii?Q?DjdhNjXCs0LUmD8EM3y/EK03SFbejDelc5hy3TEkHh+DvcvpSyn4Y+GFjssR?=
 =?us-ascii?Q?J10GXRkAalot2OcABBJ3TNAx4it2d7pcF0Ui8VnI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1I0YNpYcrITcO8aUqjS/i8hl+CxooUc2VpRPXPvTzFcbxn3H3fBbfL1NyUfaasx6lujkHg7yOjOjvyE9JNIgZWmuwZYR18T9oHwyAGa1uWZS1op+uJnJSZAto2VwJm8mVlLoPy+zHhnWOl4ln5SZykuheGXxpCCuUKoUUsJcyVJOHrD/rs62XAURMzOaAgF10bNGZXKbkD4kkEwICiGQgPuSRt/dfNHOprOT50dbW2LbRXfXkxFy+iOpejU+mr9jjaSy3ZCK42R8dAbROMrYbDQvuH4/KXFzpOHTQnESzdP75KA2NBInrPEWxUut/PLIfLL24L5zFjh1P1GPbA7V0Qsb+P7zS4KA1wczEFeXtGZOZzziYfmkEWQTn+wmsv7HAG1Vr4UVKTPI4BXHnMW6/QDbPT9Fv0sA3PVSgLNB6jKty18xxvcn8Y2VLkrR5rf4m86+iusmDzfXjT7oUbV18kX8ijkrJg/jU4LQhqztU+oNcL1opKRUnYrADPJb4l2fMFXYI7mAiuUwUzSROtMyCUgvRfJdRCCbtBzFTLBKnLxS0ZF2k76i4EKssnfN12hnyk/+Nx83qXZP6tfd/OwdnwhmVeBTHCnAKRb1Ww19+a4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fde56be-d265-4509-4eac-08dc5f768575
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:09:43.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cspWheoznzRspPs4ikxcfNMVoaNswG4DxHRScN4tFhyNJk8Ibhrppvt3tE4GoX5nLs8laDuJvNAz32BHy5PIKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: mMemNI1n97DyDQ1gSxj16V6L6szPFcLf
X-Proofpoint-GUID: mMemNI1n97DyDQ1gSxj16V6L6szPFcLf

Rename the function's local variable werr and err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v2:  On top of the patch
      [PATCH v2] btrfs: report filemap_fdata<write|wait>_range error
     Just one variable 'ret' for the return error code.

 fs/btrfs/transaction.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8c3b3cda1390..defdb0979d68 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1118,8 +1118,7 @@ int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans)
 int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 			       struct extent_io_tree *dirty_pages, int mark)
 {
-	int err = 0;
-	int werr = 0;
+	int ret = 0;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct extent_state *cached_state = NULL;
 	u64 start = 0;
@@ -1129,7 +1128,7 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 				     mark, &cached_state)) {
 		bool wait_writeback = false;
 
-		err = convert_extent_bit(dirty_pages, start, end,
+		ret = convert_extent_bit(dirty_pages, start, end,
 					 EXTENT_NEED_WAIT,
 					 mark, &cached_state);
 		/*
@@ -1145,24 +1144,22 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 		 * We cleanup any entries left in the io tree when committing
 		 * the transaction (through extent_io_tree_release()).
 		 */
-		if (err == -ENOMEM) {
-			err = 0;
+		if (ret == -ENOMEM) {
+			ret = 0;
 			wait_writeback = true;
 		}
-		if (!err)
-			err = filemap_fdatawrite_range(mapping, start, end);
-		if (err)
-			werr = err;
-		else if (wait_writeback)
-			werr = filemap_fdatawait_range(mapping, start, end);
+		if (!ret)
+			ret = filemap_fdatawrite_range(mapping, start, end);
+		if (!ret && wait_writeback)
+			ret = filemap_fdatawait_range(mapping, start, end);
 		free_extent_state(cached_state);
-		if (werr)
+		if (ret)
 			break;
 		cached_state = NULL;
 		cond_resched();
 		start = end + 1;
 	}
-	return werr;
+	return ret;
 }
 
 /*
-- 
2.41.0


