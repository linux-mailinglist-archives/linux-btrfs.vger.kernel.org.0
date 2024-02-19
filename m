Return-Path: <linux-btrfs+bounces-2534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789C85AC69
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C207F285939
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BCF57333;
	Mon, 19 Feb 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RudzrhBB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P0ldGkg0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A465731E;
	Mon, 19 Feb 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372160; cv=fail; b=alXUyinbNtz4r2n1vqgCcgO0xR4rG2UA/awoZz/aycged/Skd4jZgT+KgdrepxgUhZvdVmRxf3lTuzEnAIXDT5M/kDuSpTT0FCxZumSrYo1+2rsfkSIXdJNVBARTnsdcTl52TP+f19H32FImTcoByEb9hiJ5hQfyAfB9w+u+ze4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372160; c=relaxed/simple;
	bh=IwaF1Y0qGNNQ/IQhxaFRv0TX8116vykW/SbNSpyoSZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9iXNHAM3lfnkIFWxu5zVYk9XG8EdCyxn+fbtu/hHDunO1BVJcyXRUf5vG1zgsS7kQJG8njVLGr4My2OW/vFog3gmviLC7JeOChtu3h1wg5LbSE1kGRO2nKhlkWF/8FXZ6eQgXOPzLeF7wzxCRxNhXPBNQhfTPZxoLcmCiLBCZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RudzrhBB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P0ldGkg0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJ51l031793;
	Mon, 19 Feb 2024 19:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=WzmUgCixtOU683xoD3j+QCsxp7ln0hL1WqEEvr93r3E=;
 b=RudzrhBBeClE0zPv/kZqEYspzXoHEYrKuXwy/oN/GSp07nrgC8m5yoE+d8eawAkOskre
 xGU3TjsrcktT3bPskWJXjwjDZO3sVnjRUPrh8W6QLFwbWB4auRoDag4+bgeD/hBNC5pV
 8y2u/D/P3vBV32VmZYozCRXzqMz082XC7N/iKSJVuxHkAvSuxdlk3svYb6E0s90d1Dvc
 CdrDkJa5uaXy2n7puYK6P1QsklBlIgXRXEBnvXZ2RDIKcV974vTWmp143YJn0jRNx01Z
 FBM5UqNmds0llyHvrYYhVdUA5bjJAsyrpOtM0aQz8fPSVpw8kf1IEaqeXGJJGzKsDJgB /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7ed0ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIIS12012968;
	Mon, 19 Feb 2024 19:49:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86aa9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOyZ3qobCof5UeeoAgEr8J6MhxGwJkNpFiKw+fXbf2kmJ+ArJmq4dvzXqra0Lh/Wvur0ErZ/MTBXTj6Y2htoF8r9GPSb1cti8EP9hZ4i03vMJx/4zeMIhh5b4UxhtSL2vPSuF7gsxQfJJZDDBS+2PkfNZratXuRuZCMfJQ94hqG2knNVATBbMD/mjoFuqCGOnLcq+/NJOP3uhuHrktrZVXhyKt88tfAf8umOPRXifUHt6xw6Y2vZ7xVRJ+YcSY7Si4tUSfjnlU+qvZOmzuDi3qhZP1ZwgszBYZAFkGWZ9JVusTCRiA1wSfqlaARlvlfQo+AoQdfVt5TssE/FzdneaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzmUgCixtOU683xoD3j+QCsxp7ln0hL1WqEEvr93r3E=;
 b=VuGPz0Rzuc4Qe2SWae+q0BplqH4OfD/b59IfXKt9y/EO57PFuQRMAVD1cSYOdyxY1ogS16nZM7NCTv/zP1Am7dcbFEoMDVy2tjg+P3cMf2wI+uQmjeKwcaXi4EdQkhVSTFecER69LP+pLXmCPh2MPeMEbkR9GQKrwYe3wfWOi5W0Xp1VWi8tdDFvmp47qWTHNcHMlRF0sD3H8AsPozp8su61M9YHg6u/LsV4I9M2N2xXOfBNDTaVyhD3kippDsbeOhQN54rDlEu9ZiT9soWDX2t/jgOIQ1qy9He0BBo4zfDXuf56/uhdGUPvpClu+uDv6W2lDRAuuCuw7TDGkLhI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzmUgCixtOU683xoD3j+QCsxp7ln0hL1WqEEvr93r3E=;
 b=P0ldGkg0DqcpzoD6lrE36CbjwMdqmltzY4jrgF+GMT/sUIVek9c2jQLEQv2oQsW6rLX523PlnfOITsZBVUxaFTfPh1E3mWSwJgsHXg//g12Oubn8xDXcI+nEozgGAq31ckY8AErv+qrzm5ZA+Q8QdMrkJ+mBgu+XPfCQd3omIko=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Mon, 19 Feb
 2024 19:49:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:09 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 01/10] assign SCRATCH_DEV_POOL to an array
Date: Tue, 20 Feb 2024 03:48:41 +0800
Message-Id: <a234d5aa2612e0d28e3f9b4e6ced8e5a4dec98a7.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5450aded-2a1d-46d2-85d0-08dc3183d6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F6T8xWEmLVmiv9v7Yd3dROAzTnx4awyK5LkuxMIkimFJLCYTKunV2Umv+WvAIJ6HzNd77tERPjvFCqA9oUGzISXVAxXj3YJ8HIEKhoPaS4DrhBghIAT97or7a7GOsszh/cDiI0Gpu46Wxc8jz2e+ZvhqXwvI/wGZ0ZyWyXM/q2YDuRCkhlAp5boW+IBUzGqGPafu0H2B5TxiNSB7ivb+jGguFb9k5KwCgkgwp5QZkE8vkSlZy19BiDk5VyiwSGCcyDxUkMQl+1kXRi0ykldlRJN2pfSjCI+oOBYTIbG+G41hNA7Ur9MRFGRJEq/SjFBJZ75iEMMxeNK+k/X59XI4hk3U2mDToCOi7jQ/PiD3sSSqBtBxnxChaXSAQ9958TQU951vkNYB3/nVNeovwmOLMh+niPpumzc2Hh1VGtf6VNLgngf2nwZh8p3cdH54esBVNla/umiIq6LbPj0e6Wf9QWitcrg3JYSMrJzryqoS63+6PkVGjlu5deSfSDU34d3JhDwMuck/+tyMknJfABq3HyqGOfA3+7CSIrJHeBWDsYw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iXi6sdwQUwvvkz2R+Lng6587YdE4zE/Ec77sCe409rgce90Mw3k7OEb2EhpY?=
 =?us-ascii?Q?TSNls2b0lrLXRmT33SOkJEvFOfLpxHaDp12vtLQ2ReS4XDemUFvTo59Zc3+J?=
 =?us-ascii?Q?hzEqC2RaBS2oXBrNKoeDKyyb7glnkY7LbbbF6raCPekjUD8bsfrffqu6iJPj?=
 =?us-ascii?Q?JpJBwEB3ghfSRSxq/cqEdDxVXecKsze59Y+FDwHFG3Gxxg4CV1CK46RAH2jB?=
 =?us-ascii?Q?22/WyY/eirIKEO9FsajPiur7mg+dcO8URMoVkl8nJGPeLu/PcfvBkd5t5URB?=
 =?us-ascii?Q?6QBaub9NA2IrjnYZWVrc76/WkuXhlWOtpXpCq5zugQo2ZXMRMNveG7jgQq3H?=
 =?us-ascii?Q?Wf/YeDOku5igFH/Ep963xE7PuxbpYbyqmcyyxJnaMUepNm9/nsupNr6sZSQi?=
 =?us-ascii?Q?AxYt2aKudsiXNVzGjrODYv2/SXWWiSlTsuuSlKbDaKaE0Rb1Zg3d2dHSmmoD?=
 =?us-ascii?Q?1j91/e6x8f8bgaP05zIpDy2qxnlW/RJurGTZcECCrctWmezMq+dllYbZEXjI?=
 =?us-ascii?Q?aS5uHX0YIHnTdJiuahQCQ+3eDsFKZH2//GxrAg8KkjVTDWiffW4j5Qi0ZeMp?=
 =?us-ascii?Q?vxj/lEqtrBHpgmctsXYgJumVIYBDcirC29cNBMQT9xTSz4CNCCmuxGekJRVX?=
 =?us-ascii?Q?NgJCyqcgp21dco5eGEHwlGHA1nwId4LjghaH/MmVc2avd08StfYvR/r0q8Gv?=
 =?us-ascii?Q?unmNS3c0kGn6PN3JGbTMS1H35Uo6TQsXp6REHhV94gB5oQUjiDisbY0gcWs5?=
 =?us-ascii?Q?U/hBHGfae9HERokpiXchiupZUaxZ3E6hmjifGCT48krstBIgIRkmmQsUlbEN?=
 =?us-ascii?Q?wti0r6LfBhaguNDwGDZv6zv8hwblncRoH3aLGLViCS3W17F/k5MPgGUmO5nK?=
 =?us-ascii?Q?TF71MEHJmjkuyRHfdjlXCGIDPPoKEU+4o75Zxb+edIsIr84LrmA94VsmHnSq?=
 =?us-ascii?Q?zIa9te0YJWz9lVx25+xuLIj1mxFjogVg6TkUkxtFmkBRByIk81/X7QwpxdcC?=
 =?us-ascii?Q?4KCbw3iGsJ/nl+t/PYTYu6vC73qHfOgsq9DOr9FyErT6Hz6UGW+yHnpFkrXZ?=
 =?us-ascii?Q?SgTxijxJUBZBM4Xii59G4oUs9LLfijLHNCKDYs/AkKUrtaSAX6gQrxUM8F6r?=
 =?us-ascii?Q?NbFJiZjx2ZOplAgkZ6nkKLPAGQUBKgN3yQwoGRWj/JxgLUbCK6AsYSI49eor?=
 =?us-ascii?Q?cAIvnMhx1+/zrxRktv6yPD7FtUu/NncdaeTpSv2W3dnbD2bDHKi6MliV0nQT?=
 =?us-ascii?Q?i0h1/8wYPKnrHD8BpmWZ7R/E2PvGJDRVCEhvp8iUK1GEBZjNw3Ljq14wN4sM?=
 =?us-ascii?Q?xY+Yz442gPIvh2KgN/7RyjpqQ7v4kSKL8ktKnVwcsJLiXHivWZVApiNfQQD9?=
 =?us-ascii?Q?hEfj53a7PhdWQ5NZJj6evPjbXrlj3UXAyAARQw/7UH6YWy1WsDpeENpe3cL0?=
 =?us-ascii?Q?VvDuF5IWFQ8aUN41I9fufpfGAbgsOHp1OADQAc/3rZA/s3QtVD9iMrz5H2aZ?=
 =?us-ascii?Q?0LoHkk0G801XuhIHPTNqEnYhFEKR9jdPDuktq457TCH/g3Zshh6YPCF83nNI?=
 =?us-ascii?Q?8kDVKZRmHcrg469ZjCfmfOqrvYy2uOwoBKsS0/Xl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7XIJ4pZklKXks4yPaR2cxWKCLiczH1CTWXFRuY/08t7oDrrS2mJvI0d+Kw1BiK2MNnMq9Fc+N5Z4Ynv5KljNZNaenuBLAzAX/MGkaqiGsBtJwwA5N9BCxBxRF4ve8K8DmMk+FHvIxFtTp3SXNzA8KmdLPdp8u1+GXySV/zOw88pNagjYuRvzDbvpKajiEXTOSX/YRAH9mtky1vbzeN0F59cv959UNBQKZPT0WraYe+TodqxlQlh1tqZ1ttrVcl+pZ65xQ1tOpZ18lB9OIFiceq8VT3I8WfRftMfM6s8xVG7mbgc8EJDqbFdCYb9fV8CTMOWZO6DJQsT7QHSQ+Cg88r5RuHj+C+BlkAqGHCTfoZALaduEl60MsXHyIkN8vWF+txP9rJJME8zaT4jioB8dzf9ZVjzBn8LUlqbJO/+Pp1ggMHLlVuJgfgsAwgX+zVkcwPe4q/RyoKz7EXB4eP/122HyhllYo1JE3pMnZQiDi1MNpe+yPK2JFqyIR3qSECj04TnvDAjtg6qLW0ZXJ1X+HhbU6XOotRwc1DBzKkSPYx59gsdvsaRlfXtPJEquPoppDVdoXuTZ4KwXdbSqqnRiP9iDkOzyfbpQMGv/zE9yybY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5450aded-2a1d-46d2-85d0-08dc3183d6df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:09.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9cnakcfOO+wiACdznXJxJFbuwhNkUUuiHPv+nZVpGvo1b4Z2mlvThs53PAU7L+mJ1me/prpkKbu60086Ngiew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190150
X-Proofpoint-GUID: pJl4_K6m9rrMsgUqduebhaiAL_3r_g5T
X-Proofpoint-ORIG-GUID: pJl4_K6m9rrMsgUqduebhaiAL_3r_g5T

Many test cases use local variables to manage the names of each device in
SCRATCH_DEV_POOL. Let _scratch_dev_pool_get set an array, SCRATCH_DEV_NAME,
for it.

Usage:

	_scratch_dev_pool_get <n>

	# device names are in the array SCRATCH_DEV_NAME.
	${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]} ...

	_scratch_dev_pool_put

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Fix typo in the commit log.
 Fix array SCRATCH_DEV_POOL_SAVED handling.

 common/rc | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 524ffa02aa6a..5d249af3df37 100644
--- a/common/rc
+++ b/common/rc
@@ -830,6 +830,8 @@ _spare_dev_put()
 # required number of scratch devices by a-test-case excluding
 # the replace-target and spare device. So this function will
 # set SCRATCH_DEV_POOL to the specified number of devices.
+# Also, this functions assigns array SCRATCH_DEV_NAME to the
+# array SCRATCH_DEV_POOL.
 #
 # Usage:
 #  _scratch_dev_pool_get() <ndevs>
@@ -860,19 +862,28 @@ _scratch_dev_pool_get()
 	export SCRATCH_DEV_POOL_SAVED
 	SCRATCH_DEV_POOL=${devs[@]:0:$test_ndevs}
 	export SCRATCH_DEV_POOL
+	SCRATCH_DEV_NAME=( $SCRATCH_DEV_POOL )
+	export SCRATCH_DEV_NAME
 }
 
 _scratch_dev_pool_put()
 {
+	local ret1
+	local ret2
+
 	typeset -p SCRATCH_DEV_POOL_SAVED >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
+	ret1=$?
+	typeset -p SCRATCH_DEV_NAME >/dev/null 2>&1
+	ret2=$?
+	if [[ $ret1 -ne 0 || $ret2 -ne 0 ]]; then
 		_fail "Bug: unset val, must call _scratch_dev_pool_get before _scratch_dev_pool_put"
 	fi
 
-	if [ -z "$SCRATCH_DEV_POOL_SAVED" ]; then
+	if [[ -z "$SCRATCH_DEV_POOL_SAVED" || -z "${SCRATCH_DEV_NAME[@]}" ]]; then
 		_fail "Bug: str empty, must call _scratch_dev_pool_get before _scratch_dev_pool_put"
 	fi
 
+	export SCRATCH_DEV_NAME=()
 	export SCRATCH_DEV_POOL=$SCRATCH_DEV_POOL_SAVED
 	export SCRATCH_DEV_POOL_SAVED=""
 }
-- 
2.39.3


