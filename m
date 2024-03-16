Return-Path: <linux-btrfs+bounces-3337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B0087DAF1
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 18:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B95E1C20BF3
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625391BDCF;
	Sat, 16 Mar 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TvTSeYow";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KyrpmTY0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0351B966;
	Sat, 16 Mar 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710608586; cv=fail; b=UeW6tsKUIJPpUeU8ous0XBoljhgaUOmQEUP98ONuHqRHxXZwRP7LvHc4vg8vpv1AdZFr2S+srfd649UOsi0qZuzSxrEb8faXRoJ8p/eeOH6Tbn5kbfg21Qq0NJrqv92RudDBnUeeUOw/3+nQ7fFdu+hhLk1WFWkgDJOfbg/sFkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710608586; c=relaxed/simple;
	bh=hF4rsrslnfyUPzTxl6tVIpa8NEkKRizSYOU7hWzShiY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A2BkGEgzIHlEgphs8Q60CHL/cXWOa7xodeg5e0+jm9+H40sqLYTofNcbqwtAau+ysvuZmargHYx8RYvfys3U1Dr8yZVm3jH3PH3dwxUg2XcSyYAIKSV9HIVb3cndB1ITdGqCvqvjAmonTYh4z+v5UN8qLoimp3jkLVzSabQVjU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TvTSeYow; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KyrpmTY0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42GH1VxQ015703;
	Sat, 16 Mar 2024 17:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=BdFdZYkhPjjRKBclDQv9t4U57jyyeXfk9ko6P/Lk4Vc=;
 b=TvTSeYowoRZHcvrTyvzDIkyqq98BagHDjzlZSthcd2rOf4WlyJcJ71IGMl5wN3s9f06c
 2ENgMftQO+fZIBW2814/1F9K9oUIn0kXMWDRYTDlrB5k35zZ3GWCd5cFipkax0bPuuoD
 DBKUygFPOcB5nRknlxwJ/8B2MYGkCL3aIMDpl9N3Vs8W/s0NDyeUNGj9Uieu33NxKtiC
 8XYhfvE0O4YiAOk4RbH4cFOI7xCO6r5Dkw8budv/NMTdzr+jC3HbzcdGxqgEyeXKnUth
 rderZg6hLL1ENyQMarCjAJPSYPln1J2hTF3jM++AG6PLmVCrSV0MoYKPQdAOaFiLPDQ3 LQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2110nw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 17:02:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42GDV6Vw007421;
	Sat, 16 Mar 2024 17:02:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v3971x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 17:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIc4BjmQT0aWWKhzRSGx2qzWSL1mUY5wRbH1KSAg/O5oxY1u07HywgWvU9UNmKPVU00lOBwJY7KXEdv9a3IK7g+1iVjK7sVibd18Z2xR0e4vNIty1re8PORXA8iQR9ssaWevrpw8FJ7WW5pq+RDmXPgHcJtDTfJZ+dG9PjbkGHMpxRmAcd8be6tx0il8tRkBqAzILv0cRXuQ2MXSoRqZdYaMKqovtZgHjue3RjOF+F5j0SGIT0tDKp3ikAB6MfiXFhooggtCKDplaMxVPfQBs/MzSMeSU+wyz9K2/KsAcxA0Y6brzYw6OyXE1V58NI+soKZBYOSCD+SAUdIc5HLxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdFdZYkhPjjRKBclDQv9t4U57jyyeXfk9ko6P/Lk4Vc=;
 b=UmV1zSPpwAOGfJPrlxKb2/R6XQyqfSv61OPhfFsCEVcNAvqWGokR9A8O4IbNt52PzacSW1m04beV6LQ+K+mrI9WxI5I3MqDXHKi1++GbVIAW3B8Xows8jtSBf84DMyWU5FVRJUKrK3yv3nesleKy6JQysasg/VNIUaa78oOdlxqRm5kguNWj8JUuBPcUabaz+ad3aDX9LUgU0ldPuF1gvCddPiTzGoIAOvIKl789W9/Y6BnkoiplS0Ea88Mv02WfpRNs9ddPxB6g+icEc/DEDP4Qb3yIEN9kLDO53Zjg56AGDFz5/PL2Ss3m8Bs05NHXcZI2nH3ovmPUWd5mKB+dsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdFdZYkhPjjRKBclDQv9t4U57jyyeXfk9ko6P/Lk4Vc=;
 b=KyrpmTY00w+tJ8Gf01Y/J74wFQKj/bvPaQGX9422mObaF69y2HKyFOrwxN+Y9GSuQ43Gvip25VIcQlXKEyswQn/WuHILUaV+FUZuu28vVUR4poNqgh2EvhGkwQMelxWRXwa6yjCMYbhBwm5w0+UH+Ir20lTAXWcbtbj/iSiABqU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Sat, 16 Mar
 2024 17:02:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.022; Sat, 16 Mar 2024
 17:02:55 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 0/2] fstests: new test cases for generic group
Date: Sat, 16 Mar 2024 22:32:32 +0530
Message-ID: <cover.1710599671.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0222.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: fde78441-d5aa-40f1-29a7-08dc45daeccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+2yBghgRqg0eIjDrgCBMMlD/B7Ni8pND4HWrpIkfGVKsQbTSVVJSsC/zHYLzb4J5S+G2HefWxFxenRVAZeCYJOm7C/XdQUkCBWf3kci9r04K+uLbvEdheGCVMOKTq0G/TRvMH5afdUJTWvO0qzC56HQt+prEabONS32xuCEHbJteSSasMWisD/4qX7SNth8Uc56Sl6rCDKeiqr71NMT+6ODAmzlVT5FMZ00V/zn4GLwx4lFBiX0hU+KKcVEUD9Ztf7RJX5LuEAxCsBYie2/nfqPHnIsRXwG+eQ+NTwFqhP6nP37kB5yHufzfeJ0mhDYU+aLNNYCs/7pgMDsWDTV3CIMd8VT4wJuHU3iyVdy8S1oH9cm96Pae03jZzB6adVbFVeevpNVtD0bqsba4zp0BCXKq1EMejr/J3K9VpiNJs+3m6vRAwW7S17COGfpfJJKIQJvcDyd9Vd3FBQWHaPKR0V6OmdZZsfHhiKaGLcgFCVo2QXe+wG6Ih/lx9XpKVV6SD32t5GQiEV8jxh/u4MEPibxODfiDuRhIEJhxYn5kMGporv184vLEXanBytsbrdFyicLduMDJlc3AKH7Ob/Gwoy2D+7Ww5GWkribRufiFS1/jzu2UtBeggxXwKuIOCwHLXwV6NSZPt2fb0ruP6qbz2vVuBc/gWE2VjRLmppFHng4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C6+pkE3w5+grnL/wG7mq7H28A11NP84nhq2lQ52RZcW1I7ic9ifpW1gGqWuN?=
 =?us-ascii?Q?D2YIikhg809lFbHsBWTAUZEXw06/Udd4m9lxQDmrcs6CZknTFkgjGuYbdLnG?=
 =?us-ascii?Q?z9WKRGfEL5Nnzj57LGmxtddcJNfZ07xEcW9rN/KJktxTMNGTqm/Xlu5S4FQ1?=
 =?us-ascii?Q?xEV04FBlfalfL++MQLTIU2Ym3Cy9kp5pIVmktFFm/sCDcz2P/Mj7Bb77ypKz?=
 =?us-ascii?Q?DHYg2uiJ+U5NDYM9bOeJK+D9KNOhbrr5UUNB8XrO9BitC6qMxXpz5PpGg/py?=
 =?us-ascii?Q?MlNd7OqckP0wFc5yoW+7RuUfaoqfKYDggIHZQ1cg5TgPZLGlkJGcjwOiDmaL?=
 =?us-ascii?Q?HR7+aLNzOZ2aeWRxPM28s27I4ttE6j++hJJizwJRwzWBT4LeqoFUJ9NVWY7r?=
 =?us-ascii?Q?vkRfTqNSMWlKJKzjEmUbLH9wadKR/aNTgsQZeMvqKV0D/ggWgRSGkziejLbI?=
 =?us-ascii?Q?zJD+WDXZAxrxFOp5OR26p8gm/wmLfcu8R9mqLKY7kFwy3cHoTjpg7M5NnT23?=
 =?us-ascii?Q?hPydDddC2r3e0U5t7IkNJUMcAS0nyRMqo6VxCSNfnPZ0WyTxYOLDHenQKWkM?=
 =?us-ascii?Q?NZ/vV2rQJJlnnaYkIwaTbrXUpme++RumlBX/fY9f5e+xp1EEyEqFkO1jkMr8?=
 =?us-ascii?Q?fqa24+eOZTMO8WC2MqxdPUKSK/WFxw/udb1hEa3Bn6tOkKGadQKHYKerRDIp?=
 =?us-ascii?Q?8OxTn4QENV2j+L1PcOZTQfqyQb/fRmVzaXP/l3UqpGRygcD9m7ILcq0FJM+z?=
 =?us-ascii?Q?aZVJfYlJx3s3XUOqkwMZLRy6qULHyQ8MwDxVV0qGY4d50jvNm4tBoZ1i3DV0?=
 =?us-ascii?Q?SyI+i3rbfCgHRlepz1aMVAh9KImrhjwoxhNNbtt5vhiqe4/VEY/HaXMJHLXk?=
 =?us-ascii?Q?D+e9Cfkabgu9b2WbsHY1wYhpc5UlWs9VBpAsecMQQBBKs1FDzEc3yoA9r5Ln?=
 =?us-ascii?Q?zKTSKwRnC5Mgqtm+xYfa5MrHDraZ1m8ZKS2I5zyQtj+IuKFleMKa994KlXCv?=
 =?us-ascii?Q?h8w78OD+86I5DYX9t/CkwWkSy6daC0Xt3eV/UfzaqTlrQy+me/iupAs1s2gi?=
 =?us-ascii?Q?IuDiUxJfITAZ0mhTcr2QJnJQT+9kgvoxUJHOFX5DqJD20BwB5H1QMtyWJPH7?=
 =?us-ascii?Q?MA1K0sHmE3DWf0sgxSQAZQCbrnZTE/PnNid23G32DsCNdBx31g36RloGqWGn?=
 =?us-ascii?Q?kDJIk4ReL0nxOyneWxhoGHwr7e7hqKsJ2LXOAud9inQd8vVhsQI0925NLHMF?=
 =?us-ascii?Q?Vs0Brx0qGTPk+tsbEARoett2y2ae6ZtglKgC12+d2WWxp4Ff8/bBVohECGq4?=
 =?us-ascii?Q?bYcbsaf3SItiG53LDlvEazl29I8e8Kbf7hf4qvmnwQr42eq3UXZumCKQKnQv?=
 =?us-ascii?Q?I+vJMQWnpCHvLk47KcmzsnXAYdTU8YMyTSZFJ0qtnezH3fcbyU3ozRvKAcyx?=
 =?us-ascii?Q?/7gHgKHzI7pG63A5A9pcGEO4hWNK8siCM1Ko37IrPxr5cznwCCWQnYQ7+bZO?=
 =?us-ascii?Q?oJqSigc6choSXiUoNq7egka+e14fFv0RIxIXon4MSpifOJt6kbqIv+KZfZWJ?=
 =?us-ascii?Q?h09wdEteb+HbF0omeUWrCmV96scZlGcYZT4fYTTl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Gy7cUfUpRjZ3qUJnlgJ9wXxwIj6z10QKLZ5FI4rabAjfqhGA/1JUhiM84espjAwzzYXqVVV4oxY1TIptbuHwRbzsPWhHLqmZjFjxNZhvfCfQiC2ZZT2EwMvYemC+7XMNJ9gQgVeTwkoWtT+7Kc4Ps6T2f2HMgnyL+S3v8kwxu+GOI3k25zC3vWk7iwN5mFzFk5yE7k4G8Jwjw0Bu48Jg0wyjYMPrRGf7YQmky0YrESrES+EHW9mSX68JiAf8rZKcBcCBgDmcv4UmsgxlK+QX/4MKMkjc4Of2v4b4l7HljQWqnNRJnW/G3L/6HL+/7jIkIroYO47e2Z4qCfEDQDfnNaq7PdVLLYN22XgmcEr3A9ibg7Vse5hHP3SWhvmAQjlNh3sAype380vREMz1PMX6JbqY0dpTh9HpoWSjQ842dmWJvblM3BnYrKKnzWd76s+SwtEQpEDnSGLbfEv214iuyMtDwcNZdAK3FQCAgioosWNUUKTovZkr7XRDWvX2p0DY3PjTEER9HDoE+PZloLTa4eYmj+Hw9t+tRxZDMo2nmyXmsaDfkJtiVmuvHnbl1PE0BJBxn9bCB5vzxz18Djik/xKZEDZ0UuCzQH5ym19l3Mk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde78441-d5aa-40f1-29a7-08dc45daeccb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 17:02:55.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/C3w6ab05aqFAJWeEkobKZjNhwRngMjloUKi7fJWv1mrV+fcC3jUD+r3kAUf1/8hbssaDRFIpUJ+geKfcWFLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-16_14,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=868 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403160134
X-Proofpoint-GUID: 171FyRAls3PgF8W-hD3JT0fAnKCkX7pl
X-Proofpoint-ORIG-GUID: 171FyRAls3PgF8W-hD3JT0fAnKCkX7pl

v2: Fixes as per review comments on the individual patches.

Patch 1/2 relocates a tempfsid (clone device) test case from btrfs group
  to the generic group.
Patch 2/2 validates a recently discovered and resolved bug in Btrfs;
  however, the test case can be made generic.


Anand Jain (2):
  shared: move btrfs clone device testcase to the shared group
  generic: test mount fails on physical device with configured dm volume

 common/rc             | 14 +++++++
 tests/btrfs/312       | 78 -------------------------------------
 tests/btrfs/312.out   | 19 ---------
 tests/generic/741     | 60 +++++++++++++++++++++++++++++
 tests/generic/741.out |  3 ++
 tests/shared/001      | 89 +++++++++++++++++++++++++++++++++++++++++++
 tests/shared/001.out  |  4 ++
 7 files changed, 170 insertions(+), 97 deletions(-)
 delete mode 100755 tests/btrfs/312
 delete mode 100644 tests/btrfs/312.out
 create mode 100755 tests/generic/741
 create mode 100644 tests/generic/741.out
 create mode 100755 tests/shared/001
 create mode 100644 tests/shared/001.out

-- 
2.39.3


