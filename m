Return-Path: <linux-btrfs+bounces-2888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4106186BE7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5091C22893
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649936124;
	Thu, 29 Feb 2024 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DoKkBu75";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iC4Qhht8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DE2E64F;
	Thu, 29 Feb 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171434; cv=fail; b=sVMN7Ft1upH7JoNb5A8tUsevYb49WNEZgsFgnNT1Lx4TlP7I8kXbd24CVsO5j1PVbDF1g0uINNUxFa3ncLyWvAB7R1jYRz23H2XFlzInTcZ8QPB+uySqa4a/0P9oxLFvzG0M0OXGhV05r+VFcStwUxzhaj3JcFy4qpcff8BqAvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171434; c=relaxed/simple;
	bh=8I4Ksm2P0uA40omPt3RtNnRDVnr7OhBcLf0mDRXJ4N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4am4KRlUl3j6rdihJJSVKTSIKd4tz0gNE+hhZfVM6D5egjZ3M1sIVj9vlpIYLZPjv94J/dK56oV5Qa/MSNOdpp7TE22mS6tL+3xg0pBP3q1U7FM0O/J5NRztoOTyV05ADjfJ6t/jx9ZJAJxtVJvV/h9X/X+QoyOtrt/FSRcg30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DoKkBu75; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iC4Qhht8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKVw85010141;
	Thu, 29 Feb 2024 01:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=fBXBALm7FwiKWDN37XZ0VT2+DqkPxcaDGXbJPMeRGDs=;
 b=DoKkBu75pO4BgECI5qS//8xworhHTVYRGYQ2C5i25Z3p1VVN50Pj9pFB1acgR+kPYvbo
 ufzkKKs9kO8iHoVZbUwwJwGr8id5YpD16lKJPvoGf7yMKov5JjS1I1ydTLN+1bRm7FX7
 W0gCrZL7oajQY5jHiMoRMG2ujzO3cHhHFsogFSJRPbDZqFSHFrC5Ze6AkCVrG9Um6N/f
 9tWWbVG4pMRHyf0rUJrmE5fg62rJ8YS+RkJ+fBJePnLsrd/4GTXgXLaoXzkJTNWHvfj4
 Yg6D+VZCI9uGvWGefurwg7c61MsoYzPPp5d/3wY/494kNhThy9RC7qSGOoJifDJeS7K+ kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722kya3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SNdct7025510;
	Thu, 29 Feb 2024 01:50:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wg9dbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRN77nj0iR+PPI24Nc57A1N66zLrtplojYzLby5R9N7pah2dZGKIYL06TLWwLSpKBW5SmQFLF1O721pTJpNzZR6ISeCtAheWl7CPQbf2UvqmwDmM/6jjqp4C5CBXQih2Pl+4xd840NsJ+U7pG+JS9OLJP0MpzyOwhLvG1L/tJxX69q6xW8vMzHFJJYQUPiXELvVLftfDSLEv4/iy+tHZ9rF6kmfHRKtJzz09mqZHzfNEzhmFSABYmN7PBUEDO9n3bdYz98zuu46UjjanqG31lE27b9Wd2jAEShx0PCvgJH4KTKT3XrBqyEPkbwofhkHS/N4nEQbz9UTei0ZnQ0B1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBXBALm7FwiKWDN37XZ0VT2+DqkPxcaDGXbJPMeRGDs=;
 b=n9ofdp4YAXM1PdOz45YpKa0xcm3GooiEEEL1/7qLMbpNGed1GH9mf1C3iPdOpNKHT+OIm6nZrm53/914bhAZze/QwXwWSpTAQpiVB7HfdH37dhxWEoTaspNzxeBk+uH6jSbzPVB2z4WmL3/7++TxsLWWWkd4f/qoPE4Y8QCVO1ddCoRAw1sCdde71DvNW89C1tFnWTjPjUjX/FK/2yBMWIdP0qOlEu8txUtPmTaQqLR4AtXzUoc3HvRM6Gy4zd4cwPKbczveIcX7O11sCFURf+SA+VqebR7haa7ORdhze9R/9uPunyXkRP9loP30dGi0X15bIQwykKWXUYtEkvju5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBXBALm7FwiKWDN37XZ0VT2+DqkPxcaDGXbJPMeRGDs=;
 b=iC4Qhht89D1yY2yOfw0QFCsdhoF1vpnWi3e9GTzqcnB6Hkxe3kk7N9etffZpynwBmmxnHTyQ93Z3kvBkQL9RUwfeTaNOLuRvYC04rAJ3jO2uXaFPcXuEozGBtJaMtmuBPSY3r1fuD94bxb7cTbpvAva6ijMbXbI6xF21oIpiyxg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 01:50:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:27 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 02/10] btrfs: introduce tempfsid test group
Date: Thu, 29 Feb 2024 07:19:19 +0530
Message-ID: <112633ce1d075a7dca242565e36325220bd630b4.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9ae2c4-b119-4cc9-790e-08dc38c8cd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pp1lqZeQG5wGni/yYDamz5SaWwSiA0IIhtpEIq1oOOPZM5tpc/6h1Nvb2t9DcCedSV5f0woUiInM2fXZdDTRCJ6dB9/di7EMVVQTujto44B5K9YB4/H6LvvqqW5WH17vVc3ssw9rR1cNstPJTakdEcKW0fG5d53EsNFRb3xUdVmtK1Km1JxUxH0a7po5mEvE9tOIF773lbgjyd2zGj8zbtrkQLH/dCr5O9lqidmspkbCtjhtk+FnrVfFWrb2Z5wRsKRbu44VtmtjJqkRXf6DZqcqQx0uIK6YMMTA6LupzkOidrZyRsLaWGmYFDc6YqkiyZbaBOhpl10vOsT+i2u95YmNV7NI/Ih/gt3p+HLp1nC2/lC0moNuGtKvPUE8gBMl07zKS1eYej/uSaukUbhH+ifc7zX7akvuSCC7QUvJt3MVeDArfPtpwj4VMks9/NszIJ3p/opUZgH5XnbSwyqZ9tXx0VHD5bGXGs/Ci8BHMESZK90tp4KoSromSuLayTh5f1yisBOe/h92Bajf5Gid36HGlRkY1W0h5yta8/tIz9UWP68c1ubkX5iuoKReR196BhEdnknIZtPiNgxJl/1gA3A8EYbdsXAAL8/8YceF5f0+pWaduwDbBzEqo//pfs9oig9AxgCF9d/sfL/RFvR71Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C/8CHV1omEZz7Njk2fRJ8pwibF1o/YoYpXljEQaRLzDJQwEz9+GQzZpu6UtO?=
 =?us-ascii?Q?yvJfTuVbSeY7fzzecC2xPOLf09TJq6cleujB/LUF6M9DgUk2NOsycwCU0gg/?=
 =?us-ascii?Q?S9PvkRV/UNZF/GbY0P1OtSTLPTrPL4yjgABzjPGbM+SyNGKxhjVqzARgi+fF?=
 =?us-ascii?Q?LxXOc6rm6OLZalNVDbeE6UTxAOhiVOPzIZOMDiLx2A4hpWPbUmQOINCx9y8b?=
 =?us-ascii?Q?YMvCyOtyl/s4JI+Y/D0juwQ81sgIMZQ9e3mBz4/S1eLN3c9gqnDZFErK9cu+?=
 =?us-ascii?Q?NM3JeLWWCv7ud5qEgcYphtIjPcv8NAbpWBIeD/8bOVo+GnCWEF5TsS+UZc04?=
 =?us-ascii?Q?SakGfbTYb90oNCMu7Z+T0A63eDmk+dCoeu03oHOTBpKMZYocYbowr1vorTJn?=
 =?us-ascii?Q?/ism7Y2LyehtTjGmaSVUuiGjJZIF23iOlwKhGhyM83A0m29KJ26yu/ztZD1c?=
 =?us-ascii?Q?ULXNsCwITQ7zy07X1RFqCdSZoObdyfPret0ooyJ1mHDc3TdspX7F491XsCqc?=
 =?us-ascii?Q?ZTXfnP3NGkfFYtw8h+tJVB4m+BYOePtGIXOCMMgMGFUNXzHWiNSVme9Z1AaC?=
 =?us-ascii?Q?s05/p7vayUXJyd6vW9UeouYG4ZX2s7gv/PFBULEm6iDbs+hdf5odv+ykw3bw?=
 =?us-ascii?Q?wMhEPWcCHQRp7j0r+k4gHoUQRSKgzBx7bV8DFY9hBYw3VA0sY+lPvr2B8r95?=
 =?us-ascii?Q?3qw8WFsnRINAdIfyRR0bSQ1Jd8jRG7iuExHZ0mM6mZfvB5DGm2yFfSnD9xxe?=
 =?us-ascii?Q?8wy4iguVMrVquYpYk3a3c6lkje6vgl9fAqx2aZE/Ohph9CcmbiBF8hhNL2wE?=
 =?us-ascii?Q?99MxERaCvVGwIwKgis5RJEoW0OHuvKedHQgBAO54KECPxQenCCFyIG/zuL+V?=
 =?us-ascii?Q?toInaBvX5ARcrGkjVok+A/bkoCGZK47LjvKCWm3B4N4ujk0gZakpeLHkMSMV?=
 =?us-ascii?Q?FDoTnw+mENiy8OelGMR0b8L34x4Gabs5mOtgiqDAV0O6pAIsJxAtfpJQNt/b?=
 =?us-ascii?Q?Et/ek17PzYw8lf85iD9r+tzN6to9JEM2lb9+xoFv8NQRx33oCyiOgIhhkBUN?=
 =?us-ascii?Q?BJS+UP+vJzcMtlBE9PpAffbuFfYIWkicCVJhSbqwjQYbqx2qepjfELf3RE+Z?=
 =?us-ascii?Q?ECc3QAOBCNxbCRRxWuD9pM1nNBRWy5V9TDr0NV7oMdWKdwRGCh+QvDM045jU?=
 =?us-ascii?Q?CYt7ZvS3pKFmi1oxqqFmGnz4GO55eLttEVBZEGZ4RE0qmxAmv8yebPONgNls?=
 =?us-ascii?Q?6WbAavGIwPBUYE7Rmf0mUkTTs6b16KykaP4MnK8cZzLgiEp5WmyNmpOLyRa2?=
 =?us-ascii?Q?kzx1H+E/Y9nBYWfRZmgc2jgsu9m+k1fQZLKtqV7JS6apRC7oE6reQ/hzHcnD?=
 =?us-ascii?Q?cGURL7iWrr9OpDg6rUtILhHJdFg9vM1mFkhxW2VL+pRPQx6l2e0jKYoofLKZ?=
 =?us-ascii?Q?k/cChPbW4bDtNXps/z+Rx0dNLRKDyPFX/FF5avILD7a1LPjrl72jgpRUiMKZ?=
 =?us-ascii?Q?qyXEw6dHB07J7RTfUxhLKRxwdw48D3R+svsqlLObLw4CwkjEMvfFuC6zH2C4?=
 =?us-ascii?Q?iyBmEzAoFbbsn1t7faMJsVUCYQQwDoy5R5Wgbg+x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JI6EiggMcBSpGSa9XrkFstXX1pidg7qyEN4Kdxby6ANH0q1VxA9DZlBQTy2ymjIVhPL3GGKSEyYZFAKNyIhRdTdMDmfG2Uk968F+EVFDLQXBtZ3+q7zFyYYMqbScfbfZ8yG9mD7mZJdMVMqvI7SxlcMm6BBqULsK6MS8fdLct73o+htUIiMvE4eGsxQ0RAby5pslGrSaysNB0GKWaGdTqxvOndqeZPjI0e10tyas9hmraqYUfAq7M6Vok2PpwhUBnuYqNBmKRrXfMmZOzKjsqM2XLu37VVRgG3w/YwLBdcQP4K79VJBpurencL8GPKLizoNa4t6ltQBMIeEC3CiA0W1gvy3NIxAJn+KBklVU+UKvMwcf6jhgie+SY7Ez8Tz4k3V3yzdXjhrCPsURUEEQHUsByx00waX+mO2q7Y++U4RU1VnWdBu1wjtl4hbp9PYVRHNqH5AqvQuFLyWhiX9gBqihhaZovDS2ORh8bxPFuA+1B4//jZE114Ywa6EsiTuMDMD5+yb4xlCx424VcLrZ3vHTnGCScH3eascpsU+tgQNWnYTqEoY172SXu/Cxwtp4LK0+qrOqtbaOozOZ02c0ib6wQO70yS8NO8/Q1sZwnxI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9ae2c4-b119-4cc9-790e-08dc38c8cd7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:27.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0/uYHQ0Ui1fdHrQkAdEsKkq0QNAj2RUo2xpW6TdMupXqaMoQ+pcsWUkI9ZQcfEwKlK/6Rf6RMucqZXmg+AWnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290013
X-Proofpoint-ORIG-GUID: sQPixABPHz4jzQqFExm25J89yNc0SIDq
X-Proofpoint-GUID: sQPixABPHz4jzQqFExm25J89yNc0SIDq

Introducing a new test group named tempfsid.

Tempfsid is a feature of the Btrfs filesystem. When encountering another
device with the same fsid as one already mounted, the system will mount
the new device with a temporary, randomly generated in-memory fsid.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 doc/group-names.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index 2ac95ac83a79..50262e02f681 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -131,6 +131,7 @@ swap			swap files
 swapext			XFS_IOC_SWAPEXT ioctl
 symlink			symbolic links
 tape			dump and restore with a tape
+tempfsid		temporary fsid
 thin			thin provisioning
 trim			FITRIM ioctl
 udf			UDF functionality tests
-- 
2.39.3


