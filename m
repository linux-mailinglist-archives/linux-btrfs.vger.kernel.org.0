Return-Path: <linux-btrfs+bounces-2717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C107F862614
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5321C20DB3
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD224C61C;
	Sat, 24 Feb 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DFGgOYy3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Isv92ujm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E374C3D0;
	Sat, 24 Feb 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793059; cv=fail; b=FDFPqzSuEYD7cSXj73IThWoA58EsOTmK7r8jTBq+8EAyRqDCmSgMDID2sJnfNya9PrBBj1tEof1/eL6Jx9c8QemEuN1flNRs77EAY3Z5t6ULiZhiXw3JDdyB/Nez8WVTxO+4W4OwFEBMFidGs81D4SndHEaNmmzz+8Zf4OvFlqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793059; c=relaxed/simple;
	bh=86sYsJOwU6O3t3FU70qP8w00Te5CmrOfzkhYqico4lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O++5org/XJtG7buZTpGpV8NTScqTZq6vC5Ht8wvXAoA1oyzfpsK4joY+wHKGELPBYOGCKmYjj/b2mVQkxcOsg9+vlg2z3gYJBH/pLJcwFmJUSBQsChAKAlCyscUJTngKN6HGH9Rc1TqJmlo3KeGYZIfAEbRjy3HCXjU+rx4B5bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DFGgOYy3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Isv92ujm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFT8qZ020779;
	Sat, 24 Feb 2024 16:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=x+cnQMC8g3KWqpEIzlWeaIZabDXkwJblw9anuQ8YxIc=;
 b=DFGgOYy3EW8g0S4q6CDloVtCnUFffMdGi1AtaUasTSj25P8fqFWqaOLpBloJJMncaY3u
 JmHUCe7Lgkw/qEZEf9c68pYxS6KGfj0Mn1zDNshvZZKld5lPmy3Mx+wnkpeme3rRj6W5
 pxFTa41+zcSuEA/xABIfSiYsug9B3569GiNk1tCTlGrT+rghEwuWsiIArWzNmQtO10+A
 6RcfJl8Bi66ngKVogs4qCpiWM7w0ptlXOxRjuullejHYDDOwWO+ZbtuwtW1PGNFg/KpV
 EWvnvtdb9nZE2GvxXv60T/6H1tqh63vCv3hFhKpizK54UbHY8Gur750bEP28lw89vMfw jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v1102-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFHovg040740;
	Sat, 24 Feb 2024 16:44:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3tv3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoIiNIE/ecEzIP/NMwvaH49j7s2h9hVDc3St6YhBhMj0uU0hb8tTrK9ir9ZGdemhE4hTYVe/CHpFwDJXlTeVx0+0492MPZ1erXErGYu5pZTYmiOaGsxsKXtzl5aG6fClaDo+ShC02AWv2y9aBTU5R0hiWrJ5419COIYJwtvCWkPBN7+0zcHUEzjYlKrYYuvmKQUeXQokVobu6XwGWw2A2pQYhqv2AW3J+caFcNdGusyw49q11nQjAPkeqrzEsMIvQNvmC2Yz/3aZTeX8F8uAq5KreJVnBq6sk/x7TFpcNWa3NvJi8sT12IqwvVmvuzcP8CfcyRTBVLOSyx7Hv/B2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+cnQMC8g3KWqpEIzlWeaIZabDXkwJblw9anuQ8YxIc=;
 b=Tn2IOXROEeRpBoQzV5tMOepEZaiRo1GGDEUD5BiPqBVNplUrfsHkipfzF4oidPGwfO32JtW/TOEDRNPorjDqFjZXARAGei0echD2AyFJSgpvO8jQqfOE4yPvo54BQ9ov4nVMPjFCwfvAsKWgo6WfJA5n961uDKTqcxqinSJYlj2RKXLcjFt3+zKDDXL1cl354qaeuRGe0DYSzQbf25tmm2vZcC0zyJ3+mMPphE4AbA0YYaM9ytA1ls0GSqwGZ9kPaDYK38kbGjQ3B1zY9aybPqUk/63zTxTt9k2Xf1evaSKyLW7984WLfqebXAMmIxGZd+EVSb7FIkbQHU0A/K9TCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+cnQMC8g3KWqpEIzlWeaIZabDXkwJblw9anuQ8YxIc=;
 b=Isv92ujm8AByliutxCRXdcQReW4AyAVt0xWej2B11dJxFTCH6okSFJ6TUHU5vNRkTkFvf4nUGgvrMyfmFtvubOK0OPXPh725Q/BKJDahqef2gY1cRGLzR+uoOQHkAKnZE8GryXPY3VrGkvU4YLjqMIK6qdAuAhpSZQu/CC+CAEo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:44:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:44:13 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 07/10] btrfs: introduce helper for creating cloned devices with mkfs
Date: Sat, 24 Feb 2024 22:13:08 +0530
Message-ID: <8b66778c41341db1ae73fcdf4d30b8f1cd32208c.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: c1341f8a-b1e7-4086-0020-08dc3557d51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aNPPViJq1iQjRewrwmS17b1V01nYdldpIZT/sOrPmDRtCAMbntVQgch1oW7iET1ExpVuetjCnN4tFDU9YgGj1/Yg+GYOYWeEHQpA3HU2M/2cVSWuQzo8AlbQ19GuOEzz7+yzUSICv/izGYyFtJRKFGLkpHjGAQVaN/9DaFQTVfc1QUtemGGBSX507RvTSXK5USu1lmALzNT5V5getZhn/W6cDnyl/68SGyxemhH/y9zuhcKnke2b8XLYZqcjG9v/Ybb+ATtAxG83eTnMv31PNJNoWqg4nH3snK+sENqXJpZFgXaJTEONZ48MK06rwUpRzLqJi52RYvGbLjrGfaxsBjmCXfK8M7LId+wHlTsM9JK9nAOjprz7saDfFulRNWkLZ+hJIzwhfPgwm0RNNET3EvndiBJJbhNn5MG0/EneOdQT2OAsklZiBrcQzWkMD/EVaPATZiNbfco+9bJLSvb3iT99QSg3oh07g1Ham5gNbntyWPOeBOlJ0s7dVVb6lIKua6J8I7L+VnxQrmU7N7j0s/ahBy6x+7N4ObgVFPaYioQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vzsNGQtjMU1ILDQTT3N6lgrb5iGKukLue+KKJaxIEC/eoYbFgwRdBzz0yUuS?=
 =?us-ascii?Q?lfeEtvQf8A2YXx1anfv9RUax6ZEQzfsFh7dxB6IbTdgnakbYz3IP/UOM+rhr?=
 =?us-ascii?Q?q2MS1IUnzWDkNBpJS1dP/rL4LGv08IBJv3RZTiQeIzYzYtXQDC4+TmH/mefs?=
 =?us-ascii?Q?R8VHpfck+iDgqpc9f+HzqAMWoy6jrBLT5PkZiXonQv5HM7KeYZt2ByiJB4YA?=
 =?us-ascii?Q?58xD9P6z052ozgXdO04d94KbIprAsyFGlXKClchC6W/E3BTO0GbgclrbAsOx?=
 =?us-ascii?Q?gi9vMFxVXa0r1X7TvOWZIu7/yFDh544kPr1bnkjohihV1TfAii7e12+NhpD4?=
 =?us-ascii?Q?QQqir50YPtZLMg1GdLsiYroLCr4Rs88d/m5tZwX4ay/i6P8DF5ndSd7D0DPu?=
 =?us-ascii?Q?k32Afa8zBg5dmQqze225635ml2q4RNxK8O2ipUPj+pf5322MitspRgIe6UB+?=
 =?us-ascii?Q?zPXfFSZv/eUd0vMixqJSvjwJ33hBlt66rW+EU3oWGOB5vByu7gPSJguToBzO?=
 =?us-ascii?Q?NI0DRVfiMnrAOWSK+/M30QVCcx0xD+1WHEq2f3op/szNXdD1YaAKQTEKpPML?=
 =?us-ascii?Q?KVigXctm9RVaf1MQAKhUxEtLPF/j5PResCKsoItrCs67bJSb/EzMk+CBqa+p?=
 =?us-ascii?Q?eabDiXetAVmpbJC2Sm+0cmbPjbxFidkmlF18t5AcguDi17U0aO8gGjmgfdb3?=
 =?us-ascii?Q?1xyikspcEF9tT4A2QK1XmNRGGT14JVd3XDwQz0S9MXTpLhaRQ3vWeI8n4PF7?=
 =?us-ascii?Q?hDQxAyPHGqaQIssnkzcsQuzL7zPieTVLnLxSp1eljyHn3dKXwSe48jDqbqpq?=
 =?us-ascii?Q?uf2KLFMjN21FQZfrIYwWDXW2haqnSzZsbnl7S4rPg6gxtoNPTUv8n5veAKrG?=
 =?us-ascii?Q?JKYKEIkR/uQM663cIsCPWeQ+gnV6a1JJsRFSEI73vsJr3jhaxMh35GkoLZbB?=
 =?us-ascii?Q?67ux+ZWG3urEqsZgyknHUWyeHWrqDRYA0PENwImeN/B0eCsNisRvIhU2qvJx?=
 =?us-ascii?Q?/RmfxroycAZVVS8Z5wxpxdYDZqFnczajVxVlxdsKnooVjJ/H1/WnQm8xWJvB?=
 =?us-ascii?Q?d8oT2pNR85fwM3SMZ/8yhOyP1ETxpnA3UHSvy80aZm7SrAblIm/0/l7YWCPG?=
 =?us-ascii?Q?5ObIXzOaOFm6jSgqrvZCzkAjdIVqfvlbUDqD4QPszwQuLYv7Nt266wFbAZdt?=
 =?us-ascii?Q?weYBbJux2IBc/m+V7nOvpHgNAOJ2O+lkK788W3AjhFq/E6tawFJIcDHiO97F?=
 =?us-ascii?Q?LKMvu7CCOlkt0sUR5Nk8j1kzfxT60C83Ix3HtHvkMnZTbO1IwJbEjzszRTyM?=
 =?us-ascii?Q?KkoQEYforhtPd57WcMmG4PIrYxmb5K58STw/DTKswgeCQ9sV+U4Gox7DQnVY?=
 =?us-ascii?Q?4AWlepBPOSn8ydnLOYe3kXFYpuF7axdhZAa4qrLDK+x+EbMPKft72kQryfbu?=
 =?us-ascii?Q?PqLTkQ/2QRIBmbzf2kgC3a+c0NYUd23DLkVdx38+uRzBQsXNYhKKJ8WckdWY?=
 =?us-ascii?Q?MEufpDtGkYqqnbvlB88DI7rmSR91kn+IHn+ThRTRmqa5ThkP/0Ru3b9eoD73?=
 =?us-ascii?Q?XW9MbNoolMsTvoGNAJDx1+hdECtF1mvKsZlmo01T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nnE1gI81qPIEa8e33ayO0xBTo4ivcEqPtiYrhV/1UjtcK/bpvZRNFeCmp6x86W8TxpEGn3pMlbVWxtMfTugnKbzf9HPsbfcispxd04n4PYNSteiy8aEB2BmsQtsku0TYwRLk9lGvvHA2RlSFKw2fgNq7KoCzI80k0wv4LLczJApb/0d7GsaCLp9A8SmSgudPeNRcYqS3uP0t1zKY/KDwf8KHHU67dwMLxQ6dJPotoLhjRIYg1M9RZbG17deYizy0P81LlPaqxZ0rWvNaGBqFfYCv+HREI55teVeFSg6QiQfzwu44r59+iKKLVl/xTNse7tX/1MNd/ZSwRxCy6yLNqXoqxOu5W9hzy0ZTGE5053M1JJe8j+vRKaXUGpyo5jbcsaHF59+//RpWcMDQO6nJCqz71xEJp9x3PIo1p/RNV8y754VEDEMf8wnl3B2V73lxKXkra0SEB3A6HapWiLyBhQ0dlHHc1bQkv2KrYhcsKV8RuiYUQVJnzyV7h0cHqCWkKCVDsY52yrgAXID410E56Mt0bZBY1QWxJA/2l3E/LFU03Q4gTWLHHo1jhYN0eRSp6Gr/s3MLE9JsbbLbNa3637r+ZlKpRFwg8FWDj7F/ZXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1341f8a-b1e7-4086-0020-08dc3557d51d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:44:13.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmmvsOoXTRVW4fKx8LHRAKWflDqT2at9hwqndo1DTbXffPWplMphj5bA4W0+pNHYv5Jdk2Xw9B8SqmqLqRIpsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402240140
X-Proofpoint-GUID: 2JM4tH_oenECP1xI10ojnJCXcZF7Bkdy
X-Proofpoint-ORIG-GUID: 2JM4tH_oenECP1xI10ojnJCXcZF7Bkdy

Use newer mkfs.btrfs option to generate two cloned devices,
used in test cases.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
 call
 _require_btrfs_command inspect-internal dump-super
 _require_btrfs_mkfs_uuid_option
 in the function mkfs_clone()
 Remove the conflict fix metadata line

v2:
 Organize changes to its right patch.
 Fix _fail erorr message.
 Declare local variables for fsid and uuid.

 common/btrfs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 55847733b20e..04ecff6ada71 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -840,3 +840,26 @@ check_fsid()
 	echo -e -n "Tempfsid status:\t"
 	cat /sys/fs/btrfs/$tempfsid/temp_fsid
 }
+
+mkfs_clone()
+{
+	local fsid
+	local uuid
+	local dev1=$1
+	local dev2=$2
+
+	_require_btrfs_command inspect-internal dump-super
+	_require_btrfs_mkfs_uuid_option
+
+	[[ -z $dev1 || -z $dev2 ]] && \
+		_fail "mkfs_clone requires two devices as arguments"
+
+	_mkfs_dev -fq $dev1
+
+	fsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+					grep -E ^fsid | $AWK_PROG '{print $2}')
+	uuid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+				grep -E ^dev_item.uuid | $AWK_PROG '{print $2}')
+
+	_mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2
+}
-- 
2.39.3


