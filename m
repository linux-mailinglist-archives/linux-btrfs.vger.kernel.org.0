Return-Path: <linux-btrfs+bounces-4757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2A8BC60C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 05:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233D01C20AE7
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 03:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A743AA0;
	Mon,  6 May 2024 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CD6A/zxU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oPkbB85y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB24206F
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964732; cv=fail; b=q5hECwYnUyGlEP6URBlF4wPulMkj65zTsAyXqc0l5gk9uHyBpoCLg+Om1iPRDtBDONqZ9xJjPs6l0AUXYnX64iF+h3ITzzqY5bhxPzILd27mJjFbMKoKumA7RLbk02ZCVPrhlGeeCetREiyrNjEb4Ey8EpZwYn1na/HAie3gM4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964732; c=relaxed/simple;
	bh=3CvyoosPG0q54PeNhKRdvpHEtodNBA4qtgSozbK9nqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ju4QGZhfT5wthiyvyWk+ns/Ae4au15Uwj5VQJSEyMbA4c9auOqXSUdGadhIBJHBlKLfmKBUCDxnFMwYdMjWATcrW4wq4J9wxHJ2Ak2rKuOQBgyReeIg2gu7nW50Ug47HSre4rBWfDSkAI14NNZ2hvVkHpiJMGNZEMXPIqt6R1Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CD6A/zxU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oPkbB85y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4460jA9i005021;
	Mon, 6 May 2024 03:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=O4cybG5j1f3aEOiESIEETtTtx/PDCkGWWcOJyaSG3JU=;
 b=CD6A/zxU54wqWGxTf78NARSJPFI5y7sfJueJOo2UqEvobA3HuEFQVWz+fyCF7P0YquvM
 AopKr+x0W0dQ9bv3Gbw0CWV2cV6QdkisW7r50hr1fyCt4jwEaatXxMvR3NItcaObxcZE
 0VaB6RmqNP5Cb4QbPOhCSjNrHqwgTiTo2zokp3DAkWOnOOHgNGtWjxuRFCU+DhqCxUo4
 cgtA3bCgjm71tOg+PNi/Ne6t00kM8PZDlSrHQiwddeylbb0G3HjQp9ITRESYQi4XdYwo
 r8RcuxPz9BfuvGMRbcaySozXKSv6anNBMf4uhFpYcFGM66FG8NGZjV9KTb9GuRNdbPZJ XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt51par-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 445NFFp6029349;
	Mon, 6 May 2024 03:05:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfb92uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3bK0zat/wDIXJrGGY7ybQ5cg43Kym36zprYS/NulUIByPUQwBynPd465bUQXAq8GNeHnsJ1hebp/lHynbVBNX4cI5ul9zL5MMPsLIlcgZCvZ8LW+BCVUN7Gkvy5kTPBD2js+d/UEGXVTUc2PMH9ar5y7MIW92CKitbuz4n967PTNQkXxoONZmiPRGCfW/y2/6r4Q6n153zLMqrYIOeWqtsXzm98FUzYvxF1VpuCNrDTWP4k0XjIGTIJ59rWPWiIA7MlUVsl/xxNQPcS9k71y69lLi9B2L+3aDO24Y3trsc0Qk/qKwTjkc6i+cm6/EcceH/t9J5Z8Xo+U/dVYxUHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4cybG5j1f3aEOiESIEETtTtx/PDCkGWWcOJyaSG3JU=;
 b=Z1sog56a9LRiNuv+bZvT1iyIecun7DalICL2izdXST1zPGeNYwjtGNWilmDCwnpEkHRo9WlbVl2gOikXt7EXl/2rPCnnCp3+uOql1RMC/Qh0o8hg/MZhoe80UJIVS+8IW2eTuYFtqzV9KlW5OPC4WUV2/WoCkqlKn3xzojKyFOPmbUcUICcRs4HRPdn+T1Elm1RP6eSfaR+Cdxf42dc9wy0J/lr3maQLlvKOMoOQYMIWGEf5mS6Rc0Da6cDaBWz48U+WLxojN7zY2SoukzQHifMfUh7wImSKVDZO+OGH2bA6pJqTVjHaJv7OYM5I6V0I/RN40lqN5hIQUHkTAfSN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4cybG5j1f3aEOiESIEETtTtx/PDCkGWWcOJyaSG3JU=;
 b=oPkbB85ySIe851vALK1fZY+KYSv7tM8Z4vTxOXNTv5ETT7bkJFFls8bPAIp10iBFpWa0maloqKWNSshFG09JJtrAHmu3TPHqVFqhB+3t0OnHHXlBaOCEHlRl2Wt4NyJ14zCkBe5fHM6aIX+qIlAm+BsGuWcnSGV5a7hqvKfyZr0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 03:05:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 03:05:24 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com, y16267966@gmail.com
Subject: [PATCH v2 1/4] btrfs-progs: convert: refactor ext2_create_file_extents add argument ext2_inode
Date: Mon,  6 May 2024 11:04:55 +0800
Message-ID: <b67c6afce34767618d4bf8c84a87c2a40661b7f8.1714963428.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714963428.git.anand.jain@oracle.com>
References: <cover.1714963428.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 883e252e-f92b-4166-d22b-08dc6d795fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tqddOVem9gFb/7Jup3r0PlzQCI+nvmSc3F5wH6sUddPKwHFJ6+gWGBs2/Hxj?=
 =?us-ascii?Q?sX59UzCo8lAOd2HFZU7s1hysQVodhubnt8JeTsg0RY5flDFJlD84SfT5QSFG?=
 =?us-ascii?Q?K7b+Sg9o0d3kcj3hWxuVPESnTqmipiBBfAJqeMLOoIQnYW5wL/b1GDUNMfwa?=
 =?us-ascii?Q?BibnvW6ZdvsBGMNCyAhoL91WhmAbnzqlIn6fy998ELIoQW2l94glboPXid/h?=
 =?us-ascii?Q?PmE/FfAPkYAWzilIIWQ0sp9OZYzP1UNYQxUSnnAIMuE/0/4MDMvOEDSpDX+V?=
 =?us-ascii?Q?bukgnltqD7h6/9RDHxXsa2hmH+hhT4uiTf9oWvblL+vNndnw+mZ9ZwWGK3KA?=
 =?us-ascii?Q?tKMe6zatkgavUUkibIc001xUE6VvGIpIi6fni9fLP/cSm/R7Xk6F+jDubHSm?=
 =?us-ascii?Q?gu7TY0xlUXU2qcNi7sc1IWEawl9vUsa1FMdiDqjry0+9jk6sr6TqAIJnm6jx?=
 =?us-ascii?Q?LvjcPUzXmvu7U5U9fvlC+tVLPRsZrHqxuX4+lpfYfZnxnP9X6dgXbsOAR+bz?=
 =?us-ascii?Q?nSVCYWfxFjoNRh62KsCDF6V5+6WG7YqVxagT0QBBS/COf/w6O7B1U8mzJZo5?=
 =?us-ascii?Q?z1gcI+OL33TATd+g0/Fsrvi56Qw+Vo7E8fTrTO4IkO+yXhGh5zyroXCm7JTc?=
 =?us-ascii?Q?E2lCTd5eEmQH5oDy8yLk9rD5QFiykr535Lb8ptjTQ8ZjsbamL9feCbm7Nzcm?=
 =?us-ascii?Q?Cd38BsnPXoSBxPQ0Tpo4GkpW3eLAirovkmrCRWL0LYpTSFFE66JhVlm2JheV?=
 =?us-ascii?Q?XDEP+h79fihD+I4Y64lqT8QegZRNIdEj2xkjWAM76Bpsi6IiFROLg3bjkSk8?=
 =?us-ascii?Q?rSol/q7YVX6ECrz+6Jk5bqqIoHvQ1XqGACuTPJi8UHdxlFsjnHvs6Ly/qdQl?=
 =?us-ascii?Q?WaHiysj9Z+tjs2BqtmQnHVx2XRZjhAhAtBfoGnjPTmMka4OPnnAKTVJbFZy3?=
 =?us-ascii?Q?XZoqY7FM2kC/LJ4BO13ByChCW1DtLXeliDnD6ZDS9RHbJoJmCqQw9zQ8LmGL?=
 =?us-ascii?Q?3pbmd4SbrE3U8NK2v9qO5D1MP6hJXoeYEwnIUb6RP0NjIRikO30edqJpsLhO?=
 =?us-ascii?Q?FT6JrLyLz8QxHM7KrQRP51SUYMFIYj6MMygs2XCZNIl17+vm+ap6QjfNqgDz?=
 =?us-ascii?Q?5aEtd+Dqc+SD0Jt9qNVQ2heyLSqUmRLxU2aXTvrTivttsdh4mNhsCBaHNiMy?=
 =?us-ascii?Q?QTOivEDiCfcCLeyxHx/wPSYjPqfUDZ4Eog1Xl4uf1WYUyMxp3b3mPvJWTd5D?=
 =?us-ascii?Q?iq8kU41BruiXR+Ut9a3b6E4EwgFnQa140iCMpgW7jA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RJDvRysYbX+qNmr8FWpvG7rT9hP8TNocHKB6eP6ah7eihfsJ5OATGT98xPOR?=
 =?us-ascii?Q?T83i8mq8Bk+8vNDMk8WqQBnkI6ehE1FSU1RmbsyjeExBzSoigA8NY3RiqbJd?=
 =?us-ascii?Q?6Bfo0HqOVLNIxVaZMy8azlEA0eCJMmZM2/P8/+R076Umxa7iKBysatwPvBUo?=
 =?us-ascii?Q?ZkTppoQaa/lYVX91CHCgSNI/1+NU1U8aq8dWuL3lg4yaztcy4lMwL59yO6zJ?=
 =?us-ascii?Q?jC9FZmukRHrYDVN+WXuq5qq8KikAcotw783KGJSNxDwNUK5zkHbOE+TiDGMq?=
 =?us-ascii?Q?zKCVBEeMZ2emI/OmXDFAcFdAqOJVtGcGiVKvjIhoplE0nf6oO6+9/Xs4f6FN?=
 =?us-ascii?Q?Zem+IKMgNuSBybZnrniyqgcLDmVxL/BVsvILWQOcQn7BqX3XhIGy7INLb/2P?=
 =?us-ascii?Q?Cw2NbnA7/MicP++lIBVrCarVtUxV/gbB7RXSzw/5MF2JDvlTItKUVWW40WYI?=
 =?us-ascii?Q?zCxHnFeyCyFAEhg00pEOveQqx5KC6Rvlkm1WZL9uqngsBlqoqL+lETpGF+aI?=
 =?us-ascii?Q?8W1hRdC8CPMmKdH6k4+mUvnT7Uiw/qYc7qrJD+iutInYyXPbo1XTVPOf29GC?=
 =?us-ascii?Q?QWMRKGP9j0O31rmRjaCDZTh7hGiIJKPOZ+YEkCTMyOGa49E/qsFuSeOzjDeG?=
 =?us-ascii?Q?OJ/dxkD6FuPM8t7A/j5RbN1JiHZWuXPfo2eha0GyIdvU8S4Y3+sQkbWWPj7l?=
 =?us-ascii?Q?2aUJVQ9AWnqUsmnOHHRB5LOY4NReaby3cSQxzU9y1cvi/YwqMECM4+FORjrK?=
 =?us-ascii?Q?vQthzNcMtEt81afEue8lDq155dIwz4QEeDdpk5GzuGIl+P9bcaQoCRNybH9k?=
 =?us-ascii?Q?L0uj9rZoBNWkTb9i+awK9jCzHz5gxlneFrp8Rc4+w0iR6kvxo7cpYV3WxiTw?=
 =?us-ascii?Q?VJYZCytikYZLCj9Awo5jJOeE2zI8DFpHrxgx8o8FAmacCpe9XdAmO89ZxQt5?=
 =?us-ascii?Q?h/K8j/H5v2q9NAUj4PLO+gWC4X6Uv+JczTz86aZ4+bgqrQZzY3/jTMLO9pAp?=
 =?us-ascii?Q?oGI6T5Z6baRC2Xavox3OfTvegCFeqTEVZ2LRSCjxgFkFdJsIYFwmk8fuPjrc?=
 =?us-ascii?Q?BqdDT87hvTs9Lo/lSKG1SsEze1b7DddKkMxLbKdpqEjOa2nNCabsMYTVsOtR?=
 =?us-ascii?Q?+7l9pB375TarO1Zrj5wsFvj9Wq7zkpvG0tcd7/2sVIU+6TxldMT+7WKqaP5h?=
 =?us-ascii?Q?T4IrIsD+Msbk9y153P94CnHEB40QxJtsmbvEf+cJer73MjTJORF6PT57rXzW?=
 =?us-ascii?Q?YroBK/Q9wsAZgOWzgyIex5KmgIeWY7Q23sZUVshHMeiaEBHDOKENKPpkiyGb?=
 =?us-ascii?Q?XH9s4nmEFRBNheWceqccfEftRo7LiE7cAuVSg5lvHK2fAHG0AH8wXVx/n5xH?=
 =?us-ascii?Q?mxAL+19Z6E370NPknd1vZ/goSxFltlauWKPX/Ym/D+tF29ZA0HvdrzDy64QE?=
 =?us-ascii?Q?vd5+lGWfoTYVk+VgHPnc22RuAH8kopzRwQ4Fw5jXhBa0BBr/nmciC5ZqOPnO?=
 =?us-ascii?Q?U+J2sn/LmNzEfrP2dcqFVUTIiqF34U620i7HuvUW4Jh7f+y0cqGCL7v882CL?=
 =?us-ascii?Q?bK00w3/mU60vxgmxxI34KH9GUbVPu2Fp9daaqakFEo9rQjZqx1IFp6o0WjO3?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Axgpap7i8c9ZD03YHdFqPR2YMak3Lf7y8rcosjh2xcADhAH9lNwoeCVsbZbryA7MlmFB/VAtrDdGPznYBw8t11bp6ej4IsNkPszHfFEzXM+5juwPNGP6MnQVv6TFb1bfKgKUyEGYdQPnDAhqN4GbfH6EWDoPeZqtak7ZdJLqqiMQkLYixf04pPk/L009JeT9627Q4K5ZgyjTvDAT04Y1uaz8TXTTKk4J8AQvFLqjG6v4Vi+GffmcOPOu7gaRP/nnQ4mWx/N2NfPXZZZz+ze8ndazxK8KiL6h31UWj7KuKA66z+F9Drc/eXAkWPvEfmvWE3zcm35x93pnuoAwNiWPA2CRrjFZ6aP0Dl/cG2h6aGyFu9tFZMg/FTtVXVdNicgLu4sIiDZXNnmCOvEa6tPPzYKt/i79t2MR/4dFjYLcMUsAeTPydDMmJuz5GG2argVjSA1xEJinUr9iWsPTZUpb+XnMiClTpjRdxKr6Asi8vQnRMt17sS2kHL5Kml/FlSEDIJ6t29KflkEGeutRSCt6TsJF6puUSmP247xunYCDd4dhcQPPX6gLhrzCw7ORNM2mXzWkAm7SP+uYYUWVPFoRbDbZtbld73n9qKMbsFadjl4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883e252e-f92b-4166-d22b-08dc6d795fc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:05:24.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwwQMSgPkJ0fX5nHffd5hgmzSFFj2pwMYdRbhpU736OQoGdSnSIvKZg4Zg91z9PSoNhclq8RNRC/5oOL7nC1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060014
X-Proofpoint-GUID: zL2hX35tJYOG_Mmn6e7-1POz3P64Y-wl
X-Proofpoint-ORIG-GUID: zL2hX35tJYOG_Mmn6e7-1POz3P64Y-wl

This is a preparatory patch adds an argument '%ext2_inode' for the
function __btrfs_record_file_extent(); to be used in the following patches.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: -
 convert/source-ext2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 2186b2526e38..a3f61bb01171 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -310,6 +310,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root, u64 objectid,
 			       struct btrfs_inode_item *btrfs_inode,
 			       ext2_filsys ext2_fs, ext2_ino_t ext2_ino,
+			       struct ext2_inode *ext2_inode,
 			       u32 convert_flags)
 {
 	int ret;
@@ -384,6 +385,7 @@ static int ext2_create_symlink(struct btrfs_trans_handle *trans,
 		btrfs_set_stack_inode_size(btrfs_inode, inode_size + 1);
 		ret = ext2_create_file_extents(trans, root, objectid,
 				btrfs_inode, ext2_fs, ext2_ino,
+				ext2_inode,
 				CONVERT_FLAG_DATACSUM |
 				CONVERT_FLAG_INLINE_DATA);
 		btrfs_set_stack_inode_size(btrfs_inode, inode_size);
@@ -903,7 +905,7 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 	switch (ext2_inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		ret = ext2_create_file_extents(trans, root, objectid,
-			&btrfs_inode, ext2_fs, ext2_ino, convert_flags);
+			&btrfs_inode, ext2_fs, ext2_ino, ext2_inode, convert_flags);
 		break;
 	case S_IFDIR:
 		ret = ext2_create_dir_entries(trans, root, objectid,
-- 
2.39.3


