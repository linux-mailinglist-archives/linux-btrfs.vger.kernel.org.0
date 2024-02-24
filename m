Return-Path: <linux-btrfs+bounces-2712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F286260F
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366421C20DFB
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2770547A7E;
	Sat, 24 Feb 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B7Olwr52";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K/FrC/lu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185C12E5E;
	Sat, 24 Feb 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793030; cv=fail; b=CCl1wEW8DNajlXjxa1OXMwznWbmK5ynKOcZExon+dDfZ+67UGe7vSYJyXc+vf8fIyV9O6AVybdSxDzhMT+oGlD9Z+WshUB4MAdLK4JYyMu2HsAg/r2fzEJsUWOQ/eu+bvzjxALXzytItzE7n6971k4Y2EMf8DTkXCV62julsPZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793030; c=relaxed/simple;
	bh=w8tR8f7rMOfXsS1ku0BimfzOtQLrOUMQtD8S5kddZQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OAoQR7NyOkClokD77GmqHUxNZWavbuhd1ROy6w6AJIIB3Sycl2gsH9MRnx9lvvSdYmkhWPAzLO4g0qk/8kpXFClxjgTiAtfm1kZ6YPGFWXrZrIHdX2QcOmFtc0n5GJR6C8cOo6i21+435jLfLH9pUXnEo9v9LfpCdqVBv5MlV4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B7Olwr52; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K/FrC/lu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFT8DC011496;
	Sat, 24 Feb 2024 16:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=oBlJrjUOB/pLLs2JR7E/z7USkIp0IrpkTidtr8sakD4=;
 b=B7Olwr52YhlybxLsBiQsS1YY7/GFBUccVKBszWMVVY1xVPbnchYcG2FXvvb9iEbY/kMS
 wf8dGBgecpxPHogl2XogYi7hJTECEfOzg+r26olO8851aSZI6dZapbZ4x/O5kX2pbei5
 pcAIjFRgJbkoqhPja7Ww7knAg+bU4L1HnUo8u94KcAqz1oS23rxvahxmrVzRkvBDzZig
 WaK6afXYRRgD4uquha0wWZ/o25RVZp/yAPeQC3edtO8rg6DV/SmsXAOdcNF9GsgGB9x1
 gQBxuovcbw5e+pbD4GGqSDqpOsBJQ5p9EMmxKz3PHt3Fh0cNySsEqFtBigBg8M0SyDDs jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf72293ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OG3OSa037177;
	Sat, 24 Feb 2024 16:43:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w41kw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KD38vLNILsUEsAEnjDFhFSlZ3yoNK/QFQiRpTd2RHdsL2SbxY7sDJRnUgRUnkp3bAtxJuBtJ57VKnnaKy3T/sC1wba+zFt87OhehpfsUKaLmn7mF39JWtvapxnB/SPaCsNtyQmwjKCGpGEWXdhpcNLexAv9Rj5hKErFdFcyDsB8LVHOYkUaHDQVLtdoWYK+YFRMpYwCS3avmQqsWNWWvAHyjJRlI3wpg6ZXS3BIxyjsLP4mZ1Tq5qX+DCbhNLGUDHiPXEF+tPkdV3DBYdbD/u0Oeh+D93XSqNzWawlWh2HSS4U3jThVMR8HM1ZodF9N4P5E11ztDZJZm7wqH+rpXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBlJrjUOB/pLLs2JR7E/z7USkIp0IrpkTidtr8sakD4=;
 b=BZXOZ/wS3406D4vNfQ+lYUebRw9Gc3cuXv4y+j/LTGa9a0lrFapHio60JEvdafUikm01rZbIS5XCU8QyEAySt9UvvHhlySdQ38Q3QqaIR8sSVZqi4p/BYk+HhsrUrlRmRkbIVnh2H/ONX38Glqt/J/SZkkRtNsi83WYcLfs/tMFU4WBoWdlgEDmzYCDctMFMCUJjedC7tpC/UY27QWdnnccXQvkZ6YMG8W356ymviWyQYbF28OsN2DOkAEofyTa6StuKwknqjlxYt473eetJ2ggMbULg7YNUWCq3QLMc6pW/b5vKCS190wpcLGqCETQ1fChraWVwnfNlt/eaQMEe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBlJrjUOB/pLLs2JR7E/z7USkIp0IrpkTidtr8sakD4=;
 b=K/FrC/lutXb6WfSz8cV2cWjiDEaSgFloHQ1eyUc1qS4Hm0jSMNW3JsDADHZB16/zxYQ18/g+xneaNrQwK0Dwsnz/jU5JOeo/S0azm19lvbg7RqgNh2NP8BOEhju1KxeBIZD1eLqSD1W8cgGNbqA7kRHwxa7bELq8W4elGG77iMQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:43:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:43:42 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 02/10] btrfs: introduce tempfsid test group
Date: Sat, 24 Feb 2024 22:13:03 +0530
Message-ID: <6f44844db9661c2b0c902856cf8ed566a94ca2c4.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8b812a-d227-4763-49e7-08dc3557c2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XdkLsJo+LjeqNI4LZLrSqCisBCzDP86LhcKL6YAptdwo/niQJy3Yn6uZYzTsK1rTyIKwOmSVyNFjirLsgyN4SJZFODtVwgfeVuaCB+UQ3vE5fQvoUD85sCctyCGh0Ndgm+yUrE7gBsGMd5V/E4ytPwtO6Q69Q2QpDYhsSOW9TRkWxeooaOINZJAN93DTm3+VijYjGRgRMyRRZQgquq7nRhEn5vQs0/HVgiUrWWLJ8gHy6hOLZrL8xCd37SpmsLKV1hdZ0JQIYagCHQ49yMrJWh37fJN/sJAVMg2YqkOV3gjODuzPVZIoiCENJ1kKwBJcGwWFSIJXkJoa7kzIg9q/4H+Z9pE21nRil1QQsV5h/sGykXBic2+TjQrvuVPweW2UKeQqqiPHPIe/rx4XHuucmK2/VZ+af7miLDINZ8EMpnBOfpmA5CP7G1qL3c++6kduabaDkkaovA5aXS6HOnGYX00qCb8ufiz6a5Xi0SvIdq55mTJiWYrv38+GfWgLFOEncwcICNTI5Apl+nPmph64n64HRu8diwoEv6NL9M63kOk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p/wORk9h4HiFxmznjGua/qo64Sbu2yHCetWllzl3SND7Ipb2cZcH3RHA3XPO?=
 =?us-ascii?Q?G8l8LOKpl5zyj1s8wqpv0ABSmzZBiLgf4wn6WbOVw4ujd0QGeQ27xnv/iiQ6?=
 =?us-ascii?Q?jvs9x1lly8jg8kA3u1oaokAtzNlFm/Wf9denFfECOOc5t7P4rIFaXO/SotSS?=
 =?us-ascii?Q?LECpyiUivJGukDGh2dhXeMujzqlhvj1c+wRBqLez0mKon6SW46xFIeIOIQM1?=
 =?us-ascii?Q?4uaR7MFUKH9vVPuL1tuG53Bt+NY1nRjt/DDy+V+vPYZsGfUL8GvpmUG7gHL0?=
 =?us-ascii?Q?gkD5EVjwC5YsiYogrVpSKVm53hqmXLOKIw1L63egZBuFZZJTvmm+/K6kIYEB?=
 =?us-ascii?Q?33FKn48whdtSc+7Ny0NacJc/MQQON6UVkY+de0F0LNSRZL56kBqa4UcXjKZK?=
 =?us-ascii?Q?61qX60POk96MOPGIjBMKLL5m9CqxZ2s5G/8HasArCIbQE/PFfp/u6yrU34I6?=
 =?us-ascii?Q?+i3JHlp2ui/5+gvqH+WTarMI76Lr6kl4kqEgGJWzI8Xjoj1sY5gR8bZyuyCu?=
 =?us-ascii?Q?rztnIp0qOu/FPSIqBQX84ua4c8x9LrKp18cY0AUVitWwbeMX+O0fZMSxWMKh?=
 =?us-ascii?Q?6karzUUhxiEZoaQItilFG0eTd/Cu31KEQ7H/c+rFxu5C4yWwLEcx3dnrisVV?=
 =?us-ascii?Q?14JygfeciNi8I+6u+8Z1vkg7Xxlj2khmas0tualsw0WL9/6nEX1PpZanOK6X?=
 =?us-ascii?Q?cxyZawlJj9m+I+VhCeOXIAZD4bEGPYI4U6FwNccteqvaqH6rN/KvLlCptqUo?=
 =?us-ascii?Q?9n6jU0jLlRBzcgTtPy/dJ7Vo1xuBqnXkDksw94lKDb9CqkpFw9QEXRjWt5Z1?=
 =?us-ascii?Q?wPK+QNEigMf2dm4Pk5zz9yWQVi45ut4TP7CrC71/Ga7ngailGMmUE2DHTwuz?=
 =?us-ascii?Q?dU7TfZmsxKlneEi+5CfhMdN1ZutewQmlZqaT919Cqe1+MUNx3sQ7LG3aPlJ7?=
 =?us-ascii?Q?G/7n/FcfqqFO8/xm5l9cof5RzeI8TM+1eyheepNN4WhT9Ufb5YU2eBkzxhlG?=
 =?us-ascii?Q?LHvsA3YhaIXRz9MHAMO3TJ8+EpM3rO1m3/aQpM4/M2gAfNEtY9VvSq0Q/XTj?=
 =?us-ascii?Q?Ub0zlv6U+qJCLoaX0lkoQr3bfV0/uP/c/9nllkh7xo0FDpVjn6vsC7b4ep0S?=
 =?us-ascii?Q?qvo9c+tGF40TnO17yx0OZV5fA++9sr1gaIIliMh7acRD2KxqTshX2KYoc5Y+?=
 =?us-ascii?Q?wr7XPDOxjHT7s6BLVYjLUV3cs4qKmjg2ixowANB7PZ8f8FfS+tR1xrEVMZYQ?=
 =?us-ascii?Q?KMLsP6149BOZrJ4wKMimItfq1Q/1kCOWRDm2/S+2EbVK3Ywi0xjzAgoroBAL?=
 =?us-ascii?Q?Ht+4nb9sbuFvmhrtwtbnXXxes6CWgXHrOp7zQYcufOCfVr76fkv3Y4rjZI4W?=
 =?us-ascii?Q?ik7tZXwQ59nSgkG8bq+uyL88ENHb5yTGlXmp5P4LbI1ORsSqjlJsci4tzV3v?=
 =?us-ascii?Q?qtB9oZ0/khWLjOAA8aJekmD/r7zCwyuRE5LLX1WCwWdtCUiaRkrpSyl13I+I?=
 =?us-ascii?Q?IftcSqJ1GhUld/rg1Dgi+qevd9Jmn+yPmGuUoriqOT6XSruZmuD07aZytGtp?=
 =?us-ascii?Q?IN/snVf0xVob2AiD5Xuss/0wmewOSSKk8sHs7s/y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ec+3kaeOoWHhvuBsdlC1wZG9nTJk7JdJQIvKeuG8uKb+WG8rv5J/7YKMHb/XquTUjjRCEqTVVGIlvdf6/V9LOHvwgwR2+TOXyrKSqMCbvyF1xlc4SPtfYdaWj7PQEREBOYGFrswyjc53ZCstcGPQA0xoiY0AmkEfYrDxV0RuvpuLeScC+klU1e2vgh6LHPGC77yX75phxKeo0J1/ivRg8ims3y0Tru/H5aQLfghb8gMS9Ro3Dq8fzvCflQWKMIx6duls7NpXHQhBwCZYlVUvAEiUkWIahMmatzGoOCkQuZEa0Jzcu5EkXxyxqmzfoVWyunVG6cxx5TewrJwjht8ARsxyeyS4gS1tnEeYfi469LbOtkunZ9VHgXmXfVcGBK46mvQJGnBh/2nKBbWUKGN75xuvtvo2wmms9LucHAgoY9YrwBJCcBPKRdZiZPtmGZfiOmd0376Xa3vtk5/1T9yOJOm3EPK+l17DcBVDzQySktiflRQUR1RpOPHeGFTF5eEGrB6HQhb/IO4xGDvym5x3+jpB4i+DZNXV004fW7ApcVP1Uwc5siuraBLJhOHbR+UPT6KOOV3YcAw69zY+2XU/+VDg+1WXqC76FJ8kCMx0wIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8b812a-d227-4763-49e7-08dc3557c2e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:43:42.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUPy1aRHeLAeh9ihdQWpR9Kfn+mTPt3LyX040pomJFaGTn77lz/GoBcqQ6POxsMaZLf9hSWvHIACHpFYGP6xlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402240140
X-Proofpoint-ORIG-GUID: sy0WV0l2AYYRDKVC7EAX4--Ss1K3Mz_G
X-Proofpoint-GUID: sy0WV0l2AYYRDKVC7EAX4--Ss1K3Mz_G

Introducing a new test group named tempfsid.

Tempfsid is a feature of the Btrfs filesystem. When encountering another
device with the same fsid as one already mounted, the system will mount
the new device with a temporary, randomly generated in-memory fsid.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: -
v2: add rb.

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


