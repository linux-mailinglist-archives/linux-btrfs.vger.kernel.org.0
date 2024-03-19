Return-Path: <linux-btrfs+bounces-3422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF10880021
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939FB28292C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A180651AF;
	Tue, 19 Mar 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GDr77+6g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iwHHe0v8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466E6166B
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860345; cv=fail; b=HMRIIYJQSCLZpLFs+sHCVZyPZ3BzYyIfB9lUtQO53uKyQpoTRv2VajbHnAiqkcrIVel08Fc3Oj8rOCYBQ4E6AhFAfbJ2+k1TQPZBQ9szVD15EhCAkZdEBHtacO2cf2LT15QBwQcS9U/o6GNvq1eM1dy/hWarKtWm5g0sBc8G2YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860345; c=relaxed/simple;
	bh=ORBl2N/BuEcAvwM/dtY1a9HWD5bxAropT5MV8J/L7T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I73ZmSMaMATwmsLlewFuqmdaGO7aUhBfK9b04u5FlcjSjBIZroMq0ZwvySCJhaWT1dSEx2JzXfkMyqLllwbZ3NIRB51AnOuAyYCOLuiwbLwN/STS9jBzp6642njwdeei17cJ/kQmtfXOAccbiUg4+UHVWP/zUzAB3QQSTwU3ENU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GDr77+6g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iwHHe0v8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHaUV019538
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=XS09fQugkocpmhPWk+INIcOWZNldXzvCCxKu0rMSODk=;
 b=GDr77+6gGtiqU2hy6QdYRWD8kwhukLdlMBrwv52N8KsxPEsfTSbBUvDEIp8PeeewuMWp
 qTxydTn+Lx8Sm5lFelWFgXZVE+dUTBuBK2Lucbcia77hlHw/UybrCumC0e61cFy1Y35Y
 IfD25Ha+Btadfx7A9fb5ReAw5UEaXd+2udYal97zMty6mX0s1pDqJKlzCkITTbCrqpj0
 oJCJ1/533VVLp9q50yO41EUYvqEyaw9PCir8I10JY8A+pAX+iX6zRfOYGBrZ2sXpFbrd
 T9VrH/amqfD6a9f2+RJGiLGBs9gcYeF2FbwgyG8wRig9mWSlehvGtQP6xNefiI2hELyY yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3fcntpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEIYvp024266
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6mtp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8B8bxRgmMIMlcirtjnbad6fCV0tbEoRlUhVClHffYg0GMrFXJXsADSDN5jvFC3XPZbRO1FdMjuZrOw7S4UqIvz/IuwGq2lhMshrbWdybOof2e/yPf7blnMtiy74oXvbuiBJC1T9l67g46G+xkozF+0om8AD0qGL56Y0ksOCdj5g6YAM6Li13ohnISFUyIz0EaZAbU10e4xhwPJTXshTjIIkmNdgdFtxQ7DXlLUmWXCEPhK8c6H0nwplcNsGbP1B5MBo+Qz0CKVVYMlYJ0Nwg0scFU4hpfU6vlQPSkTiOHImFdiGpfOKuIBVg5CI58z/U/lU/DkZ3/YMXAEv+gXKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS09fQugkocpmhPWk+INIcOWZNldXzvCCxKu0rMSODk=;
 b=T27x/XuQA/T38uTyYVMw6FHj/PsD2JVwOZL6roF0qKsIVNNfxBp4MIDh98lfTIQGb7o4xMHB7vntspEfStr2qnjO05u+rfaGMeZuZmyUe/GeaHXipDfqRRfQadWG9HZbfXUDcXUtCR85KH91QfNMEXCC28X2Hy6wkmtG94vHZpd5xmwtKvX2/fqyq1YzqJ3CfIKUuyYquQXqmk9im8OorLhVUB0CiovdNGfUO+upqvmVRnqmz323SkW7kOsJGAvWjETA/OPh1VCQtc3dVRb8nqkwtKBAGr0DVzMSHWrIz2Rk+osqBQV257zDYKwoaNfzMLwByX4WxHN0BhtLroZBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS09fQugkocpmhPWk+INIcOWZNldXzvCCxKu0rMSODk=;
 b=iwHHe0v8FRd/XSn9KHJ3b+hKauhmIfW5Rb+cLg1Zee6b74igYCyIoerz2Wky6xsA0ZitFyWbmmOwH1WNKoH45MLW3jQcvi+atgDR8/bDTGT51+IyhbFHPe1xbSTbMduLKQDS9FNWEqV4qVgEKhsyyb+hQaN8s5WO3LB99Gz2g3E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 14:58:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:59 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 27/29] btrfs: prepare_pages rename err to ret
Date: Tue, 19 Mar 2024 20:25:35 +0530
Message-ID: <b18a876a7299b53d876b52c68a8b08103e1286d8.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IYg6InaorFI+xTW5YPwg44tCkQAXvYEb++a6ZwIr0QcRry2u/17iBJtE9cgxzTAVVgn19ckjJKqWzN1ZZa3sZ2TQzMF6ahls6gJuIrSlC7v7R4aQjH4Xhfbw50ywK9bGjJb6FQySHxokULM4uNtbbekwNMa4B5SKH9vq1zVsL7Ep/mImaO3o3ul2RvG0j87ayJj0YiM5IGyU5lKNB0+UL8sIItMjHb44UNYD/0MyPmthPPImHBazLGiRIuzU1/N8koGxdeNXhcMz570Fq+oeZGYl7azLjfLQnkzTRXWeoOXaNbbaYR2+9h68FK8t/eZTiweZ6ag6DQEqaQh06JM0X74MBDoCpQNKJpoXe9xz2rebqFRv7c27CbksGy/y8EowaEbC95QmhFXRUWlxtc5IyvN24v1DwEnK4hMYeZY0G8TdtXN9fbTUXpXHmAqrXgdPCAbQyI7kYV8ue0GehGi/RWIqKxRVv/dBaCKGTptyB5WZudkfTJxhlAHwzU5uEp5qvGX7Rvw+mhwDN8HvmTeweMUwa0z1YjOdwmFslw7Nqatq5+i8P2OYSBG9ti1ss7SUnF0GxoGKkgGuo3FFr8x9b6nsDHkzllORehKjaY0Chu6qmmYlca+sHFzF/XKN7EnDje+l68htapVevzbfWInCizI15w0dlZvwNzKhJQ8aXS8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WLhI0GiUVKNfaPf3SY+FhMvC7TMiTZKJcSGRh2uVvaMfoFxWBXVZ+KxkLtUo?=
 =?us-ascii?Q?E9pAFdGStSjFNCFIrJu/2aUzVyM/wbfTbLcFlQJvW8Po9aQq1pE50BIOXLKZ?=
 =?us-ascii?Q?EfGI2BuEoxM8eVFRYnWebeBfKcIjPXExZU0xHbNS5FOxYiJYYwOYRQMQ9K36?=
 =?us-ascii?Q?GIusDCU9FEqP/OGz/1pFkTZn9FbYQOiW+HKggrcw4OqBCK+J5InfvkEt4lgP?=
 =?us-ascii?Q?NqY29hLrbF47ilx/AJPc+GjtmMXb+1XYn5riNeoKti/fqGIwhnEJsP7TL3jT?=
 =?us-ascii?Q?55y3B8l4agH7MoHkz+5N8TNXLsVRRtr8Atpd8YVLj/6o+b/OS86WJT7u8X7u?=
 =?us-ascii?Q?W+U09rnth8HWZ3rutq6pp9Bknf6JHcGn8tZ2J3DAZWkPxFTtnyj2eQCmIuHJ?=
 =?us-ascii?Q?va2jxhmURmNcY3FrkANQuTljSu91VwoxIlhhOzSwAhYWfQAdUPNWe3AlqMn5?=
 =?us-ascii?Q?H16Buo6zkmjpASUzWC9ndzTt09iasd4delRfzOhNeLPOZuJQ9j3CHz14A5s5?=
 =?us-ascii?Q?Mv2UBTbJ1Uz8ot/HlDNGOC5v3MgmGOGCTf96xYu93zNE80vB0R24N4XpNA4n?=
 =?us-ascii?Q?wB6AIH6imJBsqfIhCdA2qSrI4kT1xE75ZTomjc+Ta7Kg+Gz2EG9DHmLTLqSm?=
 =?us-ascii?Q?AlfcGjQuN5Ey8jz5FCQuldgMmCjiqCZ9hKRup280U3IJ5mC4l1q1kwwgnucC?=
 =?us-ascii?Q?9wp/ZS4/RvjKYsfiGXTrob+N9jVNVGHEBo4XJ8f6NfyhmW1UxEhZ6jQN4qY+?=
 =?us-ascii?Q?6ShRqG8RklXfONyGPoGxc+BCkk4UYfewEl6hWYtqfEpAFMnsjFsqujLsi/1N?=
 =?us-ascii?Q?jJP9pNGOLCzRn7Gcmkb8NO2CA4IWBiJBF7+IpntTEDDtrVkBf+GKOoDpgGhk?=
 =?us-ascii?Q?vxA0nqbDd7GiAgNrLIOL3KH32VGguAxyKeyNXen2Ljt9spUBJreBtEtMSKqq?=
 =?us-ascii?Q?YbTuRHiZUEkktYwjKljghKhFqgKcnaJmjSBi0At3Ph+KzwvnOJR5p/1gWk8j?=
 =?us-ascii?Q?aU/b6OaARpHpw9a/qUejFPFYUBxpkjvqIjSOZFJYhEXb0FRPA+8W5H8Rh6IU?=
 =?us-ascii?Q?OI4oP48MtFHCzhwR1hNVfhos+Xhdjz+I5Q4YeWX1Zd/kz8Lccro0eiHeDOai?=
 =?us-ascii?Q?WonygVhXiZUAZMg9LdyhLM+DWqfUeCRc9kHhXlN145ZbG2+XXz2sXeuNrgfX?=
 =?us-ascii?Q?1I4v9eAlIfnrnUCIIgd7adRW9/v3T0n0JotNrcvMGzKprwGyZsGopNDPRaPx?=
 =?us-ascii?Q?X0gAikazNzfxA8iohBRVGtG4uXJQrfr4W/lZvCrcRiQXCmccyWLvPNFztXSj?=
 =?us-ascii?Q?TYeXha0xt7TyifVI2DfqF0jS+6aQVkShl76UcybLTCMi9Gj0MQCFld3xJfkt?=
 =?us-ascii?Q?uXFPeRbTsOMoJDfDflvOeXX7qidyAlm/ZLw4zDec9LbfYQB2sru2GkZR/X0e?=
 =?us-ascii?Q?QKZVBRvTJTkZrK4habwskoFquEOGLk+jmkvLvotRMQ35oEAZLhdXrboEdCQA?=
 =?us-ascii?Q?rjyh3LRQVa9yj5CxFZbazJ20Ht8tNExvO69Q3mTDlhL7kT26RrxCTOq2OwMf?=
 =?us-ascii?Q?Sf6hS/X4oi+5W3Lk4j2TrJ6LdsCoaONiysLURz5UF0qK1TEY7EMK3oWxP40i?=
 =?us-ascii?Q?3ta7OjvEFe7p1+0et+HvQs71346oxNB4BTrzsBwHnUyZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hNcRYLr9EsMZTFLBoA6/wUFYXttjr6w7OMR7k/7StrtGCjBADN1eyPmLA/aT9cwPWY8M9KEjxqL9YvHO1chPSSE+K/WAEmK2wTBUzJmtgkP2sL+tKqkfFnFwvZ5cV9mwQ24RzGzVCrphrLRQzzIiadgXxrUHyIr/zmEvdTDqBYcdn/xKC3OXnEGNJpTRbEO15NbZtXIshqzEJUZI/7mmL0TuRmq0n2B8B2x6PIIGkaj/6PQFN0pDwf0G1Qjaph0FztzE9tFFCJbfB8gvpXHidkCDDuHBGJVVt/NBP4JbT/M+Gz+AQYjSOUR3r+5Fx4JI0U1F5NtIYTNhBFP9IDcJRdlhPzRG997F4QZVySRCwnhG/FRelx/+36gtYa5StuL7w+QxQSNa1zsFzAC/uKcmB7NuaUKtmeF6QNn3CKenndTSKKSf7CwlXRb9Et9stqLg4seRyrnMy0bRI+YlI278Ierr332/td1/1Sc2+olK1atX/2tTI2DB/drlzzUQS2nckC+EgM499McncEfq3XCnxKDgBUpN0sAvS4/XiEfpHGgqHdmYug/GJVlJO3sJksBixQ34Ae8SW1V6wtpH6qHtjA2oKWhMhN7SP0xoI0rpoN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539d6b7e-9bf7-4faa-82a6-08dc48251b5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:59.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDSgCxLOlYXs+j+KJ2S9gDE6pIE3c05bEzMTYzHUREPKpiGruS7nn1reMAOGSJN+HPJmLte1Gy10nScKpB33Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-GUID: mEib9fcYlh0FozhSF0J5n7zsIWIUXj7a
X-Proofpoint-ORIG-GUID: mEib9fcYlh0FozhSF0J5n7zsIWIUXj7a

A simple, trivial rename of err to ret to maintain consistent coding
style and reduce confusion

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/file.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f55ac15d727a..c22264c9cc45 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -915,7 +915,7 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 	unsigned long index = pos >> PAGE_SHIFT;
 	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
 	fgf_t fgp_flags = get_prepare_fgp_flags(nowait);
-	int err = 0;
+	int ret = 0;
 	int faili;
 
 	for (i = 0; i < num_pages; i++) {
@@ -925,28 +925,28 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 		if (!pages[i]) {
 			faili = i - 1;
 			if (nowait)
-				err = -EAGAIN;
+				ret = -EAGAIN;
 			else
-				err = -ENOMEM;
+				ret = -ENOMEM;
 			goto fail;
 		}
 
-		err = set_page_extent_mapped(pages[i]);
-		if (err < 0) {
+		ret = set_page_extent_mapped(pages[i]);
+		if (ret < 0) {
 			faili = i;
 			goto fail;
 		}
 
 		if (i == 0)
-			err = prepare_uptodate_page(inode, pages[i], pos,
+			ret = prepare_uptodate_page(inode, pages[i], pos,
 						    force_uptodate);
-		if (!err && i == num_pages - 1)
-			err = prepare_uptodate_page(inode, pages[i],
+		if (!ret && i == num_pages - 1)
+			ret = prepare_uptodate_page(inode, pages[i],
 						    pos + write_bytes, false);
-		if (err) {
+		if (ret) {
 			put_page(pages[i]);
-			if (!nowait && err == -EAGAIN) {
-				err = 0;
+			if (!nowait && ret == -EAGAIN) {
+				ret = 0;
 				goto again;
 			}
 			faili = i - 1;
@@ -962,7 +962,7 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 		put_page(pages[faili]);
 		faili--;
 	}
-	return err;
+	return ret;
 
 }
 
-- 
2.38.1


