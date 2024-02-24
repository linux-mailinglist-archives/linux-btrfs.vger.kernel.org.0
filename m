Return-Path: <linux-btrfs+bounces-2711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DBB86260E
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA791C20DC2
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D4812B90;
	Sat, 24 Feb 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otrCgPLz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QL1Sl5vW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033412E5E;
	Sat, 24 Feb 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793026; cv=fail; b=KSrHnZNEqXS6yokzeeXsNV3CkaCiVP2QK2x+LTG+3SuAzzA2H8p+e9lM7pjrqM9oJ2cVaT/0+MDLTwTbWT71wFLmoqw5YNVSDR3AGVd1C6/SW3vjERVMixdWNt92W4sc8pCWhM88kXIUyHwsA31em3efxoBavTcP0rF3GtoiByA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793026; c=relaxed/simple;
	bh=I3RlPW5t0zlgJQcoKjHufWULfsoC90LsJBjMNzkGbcg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F5/dZnVmKQPV/1Lanb0vEb8eO5d58z7JaqlRStY4NYhy8gEDmhNf6UsvGh9oyMhA+XKjmO4ag2OgEpEq3dbL+cxJ5O84wZDZt6SO2Ro1+4ne4YTopRB7Z/rZUJ3hpgAkDW6OjLf2Y0L22jDkcSo7aoNxkjP0vVRgy5onZ1YLXAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=otrCgPLz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QL1Sl5vW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFSiBe007736;
	Sat, 24 Feb 2024 16:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=CoWtHUuhRThRwIjCU8ml7lwKlf+4aVS29Cxdb6qmdmg=;
 b=otrCgPLzkMznSSqZaW00br6njhKxpVALSThhtE2rkKn6HIFRYxr695DTbEWa3P+3s32o
 7XJNsWhcG3BvsCuB1ZGjBnINkWOMS+n7chfMzM8F2q+S4YP0dMYXj7m7CvwBKw70MqMF
 2EpK54ptnesOgPS5RaR4x3HwjBjxg3MCIKWiytYD5TV2cxZJKHC9YxqEwAE+GSIkUm7T
 sLct9C0GRy9remqh4/+a3xlVm2WJih9osOrX3H8tMf+mZn722kpTOueG9VOvYgOjEtyv
 YZCAfyFaAO/xhGXOu2wGeWf71z0+x3vPA3TCISOfNZ4EsxQlhTd2S3HFtwNsMupEqulW sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7849654-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OG5F6N011751;
	Sat, 24 Feb 2024 16:43:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3sm0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhxj5ucEWGAUB+7hSGSIwLomKPpmBAk/pGDFtfVPfcvZIAHHbrEYKo9ArmBIv8OtC/k0XvQPOSs0UJNRFk5We+L4m9JFFlggA9iP4RCiI9OblYh7t/MPgXqrWmAHwzgkAI/Lr4veUjKN2/RydxWOxkuzuXLYWS+vvCxlX3sL/LjQ+ty1htNIGUDzv+LMA1x778Gj8jvkUDmAf3z8XT+zB6H3mjCf8GnwMi0X5T2kxF12WZL12SrIitV+SxaCGfpL87eD6/BzZ2vP9IH7rogjnjy2CPpND+TlbGrah0hY9alRGqJIjHdF8VaBe0qu3mUbCN1zhFsIWc/JeGn1tzf1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoWtHUuhRThRwIjCU8ml7lwKlf+4aVS29Cxdb6qmdmg=;
 b=OPy2aHIisKVeZvxZI+JUH8eIfVzf1XmkTgUXgF6NcR7nWF+6Jce0nr55LgpIzuu0W2eHKk82zEDdcENoqVRKcUq61H3+ua9YJFBsNCwM7pl7IOgElx5h1M9P1DG4oory8YI++t8rw3j2O4FFhHbAjouXGvE6RzQDQ6DGMo0GkO+xBdP3YxsDCVpzdmX3Z03C6+suqZ5Pa1dWKPcq0G4NRmYUnwDCZIB0b2oU3Uj1Xeud7Ae3aAo+ZssQtf9JiveM/r9lnuQu0v/zg1prsqfyYHg19H3jKT3O8berXxQKp5oNEt6XCYm3PbARt+mKJwK/rnO2JrS3NBnis1nVM7qgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoWtHUuhRThRwIjCU8ml7lwKlf+4aVS29Cxdb6qmdmg=;
 b=QL1Sl5vWEoSjqfyfct7K8flvHC6NmMKYp+sbnzwDygWBwaNi2i16WYYV4wtBTiY4dwjOnYzLjhxQLa70zWwltPbAm+OSPgwhR0YSLlkk/fabsV5jUUZUyEbYJNT/8sV13VRnY6398pRbbsMGAgbmiJToSZTklICmXEtMBn4YqiE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:43:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:43:30 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 00/10] btrfs: functional test cases for tempfsid
Date: Sat, 24 Feb 2024 22:13:01 +0530
Message-ID: <cover.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edef4cc-7e98-42f9-6a30-08dc3557bb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x1qzU1XAD/DJpk56jvvmr11Y1/INBsEEvoh44yicFTyb807N7b0hp5O1HZcqcbafNeii1yfKh69TFiuTIjfYyh/mdATim1gjKiU6c84DdkqC2LE/cpXajMZvw88vk+T6QINNW0Q71mP1kRurBgraUz0lgW33WJUuBXwiflmInbpsF09X8B1RbhIpFk0I4zF8AFBxAuZGt3nPp2iV5hvpYr52BtwKp3XiQ0OkqII/axi+3YKJtQiPFzzGIx7dL6Tarqov5S1GGcK/9wuRuEW1yFetJf0+nhmGXAxnmynnFn1MbwLKJ6qo15k2yuF8tvCnmcbvVEByjpMFHpvUQVF7bdIFCjsDupMua2y0AZxvUtfRaLAVCl9y2IncniFbv1EnKfmylmIAWb0EdvnbALqPeir5gqrwKFemXqWSIVnc3LErPidr3LujdQgRrBk16g6VJWK2E6dp/fUf80jSsO8HxptE0q0t1nJBvSx23q/9Yl+HCFsJRUFVelA90XmrE2hon6Zdkzb+8+Ax0km5gZUb/QASiq784MBqLVR05InIBno=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?30b/cN3bDgmuds0d3S3b7Ampk238CjVLuq/IhXP7UyV/j8qKiijE6zbxzsjT?=
 =?us-ascii?Q?SdB6Mj1vXhhbuZJMMnU/l3QAZQDYO7HH1mSJfi/0QRFyxk9RofIkGuMuvLUG?=
 =?us-ascii?Q?lM9lSpjtHAXVmPlL1uEDi+J7F3+vAYdQP+z4GYqJaLmjA0793E2+Y+Emako2?=
 =?us-ascii?Q?BJeiLooKrncU3ZTWPBqIgr2QmWBnKSuzIOamc9n30gFiieFldJdO5n9u2NbK?=
 =?us-ascii?Q?oWfkSGNoAFvmEV12+AViN81NLwXkoGRd4dxgKEzkGUpRkdhugez2DP0L3jNo?=
 =?us-ascii?Q?1WuY5U1ms327CVOJ3Ax/gDjNfZiJVs0tlfE3Aab6ZlMrXTIdC4HhpBeOc8ym?=
 =?us-ascii?Q?ioT9kRfiFe51PGcGNXadx+b7Z8I9JDr1qj94I10kduy+NL+IbT1EJpQnlaR+?=
 =?us-ascii?Q?b5ib+2Fx3OlOf+uhFNzbeV5t+wYGRCk96NAFtbyLTfEjin2DaGqOINwaLTPp?=
 =?us-ascii?Q?1oBpJ/YewWDuPC3jtb1/pnVu4AjLve04X55tc66fPxMzNCJ9UE37JWdcmIjG?=
 =?us-ascii?Q?d3ynlsRI7PON/kC6ivq0Ng8kdz0KP0bFPs1pJQxKWLONYUjEyMae/IJQKpLd?=
 =?us-ascii?Q?q3N54G8OSrb6LS2kzvJNk9pvIWteijCQ8SbHFR/K9pCEs3OeGqGHrT1TfLIy?=
 =?us-ascii?Q?vNdUpvOzW59vDB9WBBBM/vq78nGPxHugsvUiflaLjQTkow7ZWGxGFQLGIHA0?=
 =?us-ascii?Q?5NJpSbYs6OaAYDvQOlg7O9JJmQ6ZGhCdAHB0i/g9weqTQqMo1uha+6a7XKd5?=
 =?us-ascii?Q?uMQriLQJKJu3Qqnvs6rtzw5e9E2o/Hn5pPhTW04lejPRzAbB7qixHtNLmtCF?=
 =?us-ascii?Q?Jaip2/0CRkgLsJdqVXPvhVH1rHMCllIHFBm6Z7x4DAx/7RlEIWLx9vwpA9M7?=
 =?us-ascii?Q?/DeiatNUFJ920sY+qAd9Muo6hJrK0ba3ZV68sb+0ewD8sd/xKbBRzQviouHA?=
 =?us-ascii?Q?C13zHCQdbL8fUUG4NosyK5Pmf3CHqKBR7sQYPCFtf0z5vrWnS+IGl85E6nlz?=
 =?us-ascii?Q?ZXkYYexhEQKaYxnEoFMIMC8vIvaB0qTfjr2Y+SShyFk5xgV/MYGobzD6cicf?=
 =?us-ascii?Q?3CrjjCicWQF+kFjurQ1HT8MqucA8VaxSoUvzcP7JA2Li6qRiD8j18F4KLh5n?=
 =?us-ascii?Q?drfU3dcXLt41oq59+2W0bezLm8mhbqkqrrpZ22ZgQdVNtzPz4nczxj+FYzon?=
 =?us-ascii?Q?pMbR3VbbZQ4zeyJcz5mp0nk5hVNaw51LtEbHSOL0qIy9D/7MNzqAqFsld/vL?=
 =?us-ascii?Q?NVO4+itv36fR68zr3s6UwlVwA9ez8DUCsJ+CFn1hyrLOUl9HFPzmA4qEyEYn?=
 =?us-ascii?Q?JXei/j4NgcgEqXqVo4d+bVOP6rhSnmBEQhl9vOu5ztn4I7Gwg7fWcDpvbwaT?=
 =?us-ascii?Q?5l4ECc0OJkuCVSNmxyhMLBgFZStkq14VCrh8wlfeedcajwjBFAG3BZ/kPzad?=
 =?us-ascii?Q?1PXuZlsZ2h1H++lEcS7p4Twi1meqiffQlTgLlpfhXqcFZGqNmr7C4ogCwWOI?=
 =?us-ascii?Q?sHKysmsdnOjUiGw2h+ZDzxaOcVLMJFVyLcQoYNVkcRiSwScEcbUqOvhLMQUc?=
 =?us-ascii?Q?JlHwSIj5WWsY8UAi8sdlA+64wklvJrWx7wasxmzR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XGsMIZcjY9AQh+/UACqSMrmDHmDe0kJ6Kz7IDPuvI7SQ/D9LZy2PzDyX8DoWhNcVR2x1hwtknuEQUfscjTVGGfqpoP13FTQLxgxghSX3h3EfThDzNrapuOFRClAJk4dfZYqBCMhuJ3yHlhTmI+23XpTIzpXcFK+6lqnrW/cuvMEyWxfc1fsmFIGRfKvX8qo6fDa+NiWVvNoilVdtcY6OsuMt9hJwnPPvSikDIg1QJHTMkKlZuAIw4+B4dR3mIOEcaleFxOWHb4gauYyRJlR3s7y1vK3eEJsJo/lY7SLw0uaDF9MkJteSgDayjxf/yaLk4glXa8X5yWXhFig9TJ/70/PHDWE73YqxZSxKI/dUYkQ69bUb09vqpugQVGYkdHX5E5ELBa0lHMwxIoTTlh1GZE7pAF10o2IfQF9eRdWXVOCdBLNbgIhzY9EfP4Z74svfKLLX9Ns83WzyoQvHFbHVqNFIgYLQpMsf5S53m5KK6gnLb1KWayPekt4xzStrXLXptLyL9C2yP1K6pb07nE5Y5Y1xoFLiNWMit7pDRM0cubV67fbIkZh0VxYIccSMjZ5AFCrz1l0VQc/CMBobk3Qye7ql0O0ZwrezTkhUrIQ4mRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edef4cc-7e98-42f9-6a30-08dc3557bb3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:43:30.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaMi28YSx83yclKJFMA5O9RC3dv6fHhR6+o4+PMR/5pCOU85QCTWbVCBfzQCQGfPka93kGW0hRRhh8yHTY4P2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=560
 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240140
X-Proofpoint-GUID: ud8iwjnSxYaH3AwDVtd-vvaLGFgxEny5
X-Proofpoint-ORIG-GUID: ud8iwjnSxYaH3AwDVtd-vvaLGFgxEny5

v3: Mainly, move the prerequisite checks
  _require_btrfs_command inspect-internal dump-super
  _require_btrfs_mkfs_uuid_option
to the common/btrfs function mkfs_clone() and move
  _require_btrfs_command inspect-internal dump-super
to check_fsid() from each individual testcase.
A few more changes as in each individual testcase.

v2: Each individual patch has undergone numerous fixes based on the
feedback received. Please refer to the individual patches.

This patch set validates the tempfsid feature in Btrfs, testing its
functionality and limitations. Also, has one minor bug fix.

Anand Jain (10):
  assign SCRATCH_DEV_POOL to an array
  btrfs: introduce tempfsid test group
  btrfs: create a helper function, check_fsid(), to verify the tempfsid
  btrfs: verify that subvolume mounts are unaffected by tempfsid
  btrfs: check if cloned device mounts with tempfsid
  btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
  btrfs: introduce helper for creating cloned devices with mkfs
  btrfs: verify tempfsid clones using mkfs
  btrfs: validate send-receive operation with tempfsid.
  btrfs: test tempfsid with device add, seed, and balance

 common/btrfs        | 71 ++++++++++++++++++++++++++++++++++++
 common/rc           | 18 +++++++---
 doc/group-names.txt |  1 +
 tests/btrfs/311     | 88 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out | 24 +++++++++++++
 tests/btrfs/312     | 84 +++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out | 19 ++++++++++
 tests/btrfs/313     | 53 +++++++++++++++++++++++++++
 tests/btrfs/313.out | 16 +++++++++
 tests/btrfs/314     | 79 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out | 23 ++++++++++++
 tests/btrfs/315     | 78 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out | 10 ++++++
 13 files changed, 560 insertions(+), 4 deletions(-)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out
 create mode 100755 tests/btrfs/313
 create mode 100644 tests/btrfs/313.out
 create mode 100755 tests/btrfs/314
 create mode 100644 tests/btrfs/314.out
 create mode 100755 tests/btrfs/315
 create mode 100644 tests/btrfs/315.out

-- 
2.39.3


