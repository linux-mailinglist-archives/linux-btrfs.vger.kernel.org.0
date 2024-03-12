Return-Path: <linux-btrfs+bounces-3225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D9D879530
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 14:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4FF1F23E13
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F577A707;
	Tue, 12 Mar 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7vfS5W7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pMfS1FFi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0779B91;
	Tue, 12 Mar 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250552; cv=fail; b=Q1dgOUykr2n+WbAGmYA5M0NKN6MvDQ8++NhLFdz/QHZKZgbRGnVYwVClSbCxh0fihSzIKGtvdGjc8bswpwNIDSETHBdxRY86wdgD4b7w26HUMUcMO42wp8GyIV3SCfG/Nmo/N3etYR17GjkaDHdQ0dll6dp22NFPhYDOMMFFalo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250552; c=relaxed/simple;
	bh=yLU55zVMJzqnvZXVaSJCwSTFAmm6qy1n2jNrEYGnHqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dhWPMC2gVmE1qIfeFCcd719ADiosr/WoNgyUXfcAc3T5Ged2P2LHLeukVG4ShwIA9skqAKdhzwWBpwTAjjeju3lstYzTLLb2XhT758NxTlqp3rPEpa97hmzrSZhpQSKOUIHTZZaHz15qE1gVlLEv7FCksz5vIpCHV9qxh18PMiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q7vfS5W7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pMfS1FFi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CCZ1tE010197;
	Tue, 12 Mar 2024 13:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=u663KhblykI/3ucJp67FIcKElgmP7s0Zs6LPg7QTfoo=;
 b=Q7vfS5W7AG7iBG/sORcLhaWnSlYjOAcKbw68BY/K8TL53WI4TRGQ6Ju8KS9vAdqkgXDg
 0rF1AoUZH1faa7LYiCKvN0HXBRFh+B/u5Ax/ItJi0K+GHklG47+xm8zMtTUIz4E4NXaL
 tPiuYZsK2b4nHz2IMaIqevsbJ0tw9vzbwOyoPhcqgdtrJgBjiQh6TpahH0dRjrLR/I1z
 Lk12CjuVnE6AizlWLtMZmGmV0MjgSVhIybSp4yr/rCy70b2txDxPhySgkOg5Eed4K/Hp
 ZqrBFBZKJNRcuU4pe7sFqA2TSaNAp+Lg+ZuHDidIFKJVBeDxumvyeGqc6e1fB0X/NSUt /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3x26g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 13:35:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CD7PjK009267;
	Tue, 12 Mar 2024 13:35:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7deesg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 13:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPz1qyU8sWH3NstB56AETs2w/jv2xOlwj+vO6IOBw2PqKB6crPToTYlrz2Ocvq7qyTlNudgElL0eZ4diErxG4M3TnFFVX0JHZ5ux/aYRq7DqL//W3DnIVxiBTuEAXV0O2N7tpuT764GyayVSr5cQ98tZCd1jIRPuZLFliVP8me1iahJ/hp9oaJQnof7cWT46X6m6VF8MVia1O07/+ty57LpmWHC3K1pB2tMSK2me+X0YjA1BFLzGvFBhNGM995lBzCHeBYlqWYW28Gn6c66VbZsMZ1JljhVRD/8B243/rU27ZWFQyQTGYP1JUpzIsJ2ZKtMLDqsJ5Xqzjb8kU6uljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u663KhblykI/3ucJp67FIcKElgmP7s0Zs6LPg7QTfoo=;
 b=ZrwuW1KyUq++QxI6N5eJev4xjv8Jb9ut4a0YomoZ7UDHob9IYJQKmdAq7nv+d+g6jDm1UPTx8Yg2ebUmZlLTqOV2XiYaEphPpuvp9klHbrGhUgOB1ph5N2gHJCbwz/Vxf/Fr3tSUWqSiWshJBKzhz4oj6QOKMoNqNqb+cOVDijo4ZwWgQhLu34AntTfY8NgF6xmKaLczsRorQyCAlUzLHbvMK0dJE/x0hyH0h70iMfDUjoIBKrE1ffu8Lmm4QgOVP4H9+FgyHlm0F9NxD74lfj+TF3yLIzaIfOtFdlUenZAqoW0abFttrqI+lLm5226BxUK/Icg0cs2modx11yyJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u663KhblykI/3ucJp67FIcKElgmP7s0Zs6LPg7QTfoo=;
 b=pMfS1FFiwznwloYTjt+RLol9evPavAZetncFgMdLMnE4d5DRhXfhStlnc9sl4rGlsGbKTUJ2JNX9Q2n9C9tUwjrhp40ooixZ3evxuX4ezXS6rNjTYTIs0aPVTtieTkLanA3DeUordQEipdl3idNlbdPi9ypgVRgQpExa0Oi5HRg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 13:35:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 13:35:44 +0000
Message-ID: <9f13a3d0-ec72-4b42-a13a-c678b1211af0@oracle.com>
Date: Tue, 12 Mar 2024 19:05:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] generic: move btrfs clone device testcase to the
 generic group
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <cover.1709970025.git.anand.jain@oracle.com>
 <dd10c332377f315cd17abc46e08f296b87aed31c.1709970025.git.anand.jain@oracle.com>
 <20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 85973ca2-7a7a-4ef1-e4ba-08dc42995186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C7FC0H2deRDp/Dp1TxCJfKpHMuI+z/bvwuYnvi4gE+PUGZUzXXFcROc3MueLOTG09upkYxmyqL/UOgMLXquIs2l0XVcjb/aKSp3jufWkPMldTeo/Rdi72jagjXtZ7nSpS5iPktxtw/YMdqAGvGqtlPt/S+s28VbwyN+2fc4O8PaSsWupiyQtQdND80F1xeiSYYMOglV/S8Z136dItqt/izP9fYsa3JTnmPbwz3st66TPjVHad4O4/kW1Dkgx69p9QGpVSKBNlMTORkcV1QUQHG7fkvAR5Av2+AdluiZEAqERWG7UR7U+6xpkB36T9PQvot51ihj6XkeCKuY2TL4fXbHV4uBdHeI5J3jklZoa8b1WQzrEVVRenwmUyeAP0a76BPrPlzpYOnnD09+dUM2gu2K5GV/IMR81BxDjgQmWEHeyStlu7yYcnoEVnzHIivSaM4ffMaR7oTl4eZqdiBNlwQXlEF/hPeDJETvVC3lOORlm5SVraMVBy95GiwIc5B9YguTXYsIvs83oe1X/0iZSNj5XhX2NZ1cOkibHpeCnHYjcQ4hh5vgX8aJbMWE3vBZeiBssK0f/SRdWlblSeuWccTHFz2fBwd+GdgSd6xIguPU/FOcH/qnndKZFStX/M2xDir3XARmOUzM9Dy0zlG4XWHIvwsTZe8KEwCRenVc1nHI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ck04Uk82SWc4d0xjREQxb0lVR2toWkNIV1l4c2s5cjludjV3TkMyejE1WnZP?=
 =?utf-8?B?bFlZazhJeFlMYUpPNlVXT2djS0dXc3NQMzFITkgvYVhJdUJMeldCNEJMYnkr?=
 =?utf-8?B?ZGhHMlY5ZGE5SVlHUmdBWFBqMlVxMkJXRnlib2JzcnVrS3Z3K25LMzI3a2RJ?=
 =?utf-8?B?MURiQ2ZpeUk4dTlUM1BwVHFrRzIwTlQ4Vk9tK1ZlUTNyTUJDbE0ycUtQaG9M?=
 =?utf-8?B?aU42eHJ6TUFYcncraFl3aG52QzJQL0c2QXA4N2lhNEQwcFBXazljdVhmbjNE?=
 =?utf-8?B?cW1oZ0FjWWlhYnRYc1lla1dsaks0d3U4WHVUd1Y5WkZVUEZ2alI1YlBjSHRh?=
 =?utf-8?B?L2d6dVpUTE16VlNhTjA4NktHYXU1YWRPSEdjWUs3SFd5aTFtMlFCQmliVkR6?=
 =?utf-8?B?M3oyeEc0M2xINWNHU1Z0ekQyS2lURDFSNkJiMVAxR2p6YXVnZ2c2emowWGVj?=
 =?utf-8?B?aklNWXBHTVRwRjkwZ0k2UkQ1b2FUNGh2RWpXY2hvME9odUU0RHJYOWk4dmpp?=
 =?utf-8?B?T3hxZmQ3THZYZGpWdndabTFaRzVTV0w3N0VDbXU2MjhjbkVpMDNmTzcwbUVN?=
 =?utf-8?B?aERSUDlRY1ZaNkVra0R2T3g0YnRJcms0MlhRZG93VkliUU9leXlPejFvYXFm?=
 =?utf-8?B?TThyWkd4YVBwQk1XQXAwR2t2V1N6VlM5VkJNV2ZDU3pqNWg1UUUzdmQ0aEtZ?=
 =?utf-8?B?ajZ0YzhNelh5Q1I3VVNwalVBYURwMDMvWFFJNzRERjZoUExoakVDbWdRNXJm?=
 =?utf-8?B?TFpXVTRrWXJJd0szRWpOY09jRStXS3liNE0rZnRwdW1BcU9adFkvNE9HVllM?=
 =?utf-8?B?cEtEK0NvZnFtQWJjVFhyQVkzRXI4UlNiM1FkWFpVblJVeTh6N3RWWkl1NGJO?=
 =?utf-8?B?RUFyTFZwKzRzc2JnOUVJWnNyTUEzd0tLanVBSUlKMVVrWkFJQWw1OGY1MEpp?=
 =?utf-8?B?bE1TR096V1V0dmYvak5rZ0ZLMkVHeGJwVkdncmpoMUt3NFZqWVVraVBxSW1P?=
 =?utf-8?B?Qnk0ZUN3WXdoSWFCMnFQbDRGTHNSMU85MXV1MGFrUWlTUEM5cjU5bnZKWGFP?=
 =?utf-8?B?ZTVMc1BJS1VZeVUwcXE2Y3dUM1VTSE1oYU9SbmRaWXZnSzRUWGdGUHRsY3Ay?=
 =?utf-8?B?b1paY2hHLytVRU80VnBkdHFaVmFEc1Uxc3R1d3pJN2dGZFJqVUpxZzFITHBT?=
 =?utf-8?B?QVUyU3ErUUhMenJ4WjArb0hpaWV5ckhlcE1BZ2tWNE52WFRPNlJUazlLbzNH?=
 =?utf-8?B?bjExdkRvSnZ0cFhYOXlmUWhzR2FIdmttRTNQZGFEcW91Rkt2Q3ZDRmdjcWFz?=
 =?utf-8?B?RFF1RTgxeGU1NDMxV3Y1NzBMYUhFZDB2YXVOMFJwRHZTaFhGMFNhOXJtY3Er?=
 =?utf-8?B?ckhqZVYzQVVBYStoQTEybkhiSnltcnBtbU5nNzdXNUpWM0tTTVkySFVrMVlo?=
 =?utf-8?B?d20yMWpoSWg1OW4xbllYOFgrRGNzQjlVdkViRno5NzI1b3ZlcjNzbW15ZG5G?=
 =?utf-8?B?NGZseHFSbnp6ZnpxazBoTE1PRnZwT05MUDBCWWJ0M0RuVFhrMGZiNmgzS1JQ?=
 =?utf-8?B?TnJwNW5HWTdPMFVXclNVV2xhYm8wcnB2T0RiQUJmZCs2bXg4aGgwRk8yNGNq?=
 =?utf-8?B?b1hieTA2QU00ZEdhaVJ5SkRWUFdweThiYkhCMmU3eHVQWkdGM1VvR0l5a2Nr?=
 =?utf-8?B?WjRJaCszcCtnckRHVGJ1SldYMTc5N0QvaDVwNmZKbUZpUExlOHA5aFNVUk1l?=
 =?utf-8?B?d3EwVnlWNE1meFRzbGFSTHR5UEh0bVNreUdGRFE4WFlrOEtNUTFnaXRNQVdn?=
 =?utf-8?B?UlRDUGllbTdLOUxLUll5d0N0TkNqdkNvQWhlVVNtVHJhZGxsNVJycGFwbHNn?=
 =?utf-8?B?aFBjbkdKOGk3UVozNHQzQ2dGRUhtdW9vSGh5NjB4aEpGUmt1amhQVU1NYVZq?=
 =?utf-8?B?ZkxLUEhmYzB4dForT285Qjc5REZ0YnZiWldPanlISVZzekl4TFRNUmxBdmdS?=
 =?utf-8?B?TUdtVXZTU1NSdWRJMHQ2SU13cFBlNEZtbEFxaG92dXVvcGVOaHUvQis3cTlG?=
 =?utf-8?B?cldSNDQ1RTdINzBSNVVUeDZhRldkaFV2dW53ODgxR0duUElsdTVVYTZUWTZj?=
 =?utf-8?B?WUd2bm15bWZlNlFvRkplalBhWWZENGNWN2JPK0FUeHBGejdTN25oeXJuTzY1?=
 =?utf-8?Q?r8SX4rNZHzomBLcWQ9rcGDpkVGDRW/BlhQ5N87t3gr2F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lVIRfK6ymxMaOGq2/M4Ubtsz5dTyWPgBrwnvu+fpjH/WwAehyvDGLShYMTwYL1JjM+SC7mh+M5HYxZ/BcAuntYNkV2EG7mGdZp/NYOoUN4ArzWBgFkp6gi6ZuKm7v02LT7abe7c0UJyLlqDZUYE9p2K99YAWnwAqBnPeMHUxAk4BocfQkNLegGutm+QzeMUzyFwQSyRhX4NH5xMrMIOQslXeRV/IgK3/CrROSnNs+r7B1MnyQHe3ZrO3IRrSLNcEuLShyFLR8kmXwnTQ0T5hd9IcwJ8FTsZUyGQjtzcAuExc/w/yzi5HHAnDYWSC/oBMCV3SoAS2HGt3gHmHhY6wjhoawujEndaog6YKG1qd15TAxKBspSBKaYrhOpNe/TG/IzInRItCw1qGXnGeo1d6PxaLz/+rHgZKFz+CqZnEWzHhBRZuhLhxQFHCs/5VRJQ8gXpkDRMD1L7lNGOEGJKTTxTO+yQAWRmmcXn+q3/0W6FPj1izDL3nBdv+HR3WP7mulTxyyHbBpAnpTS6g7PUv4iznqAKyFJmU7SaJxMFAW1RzB4nafsuUWFeu9qZEuF7tD1N1CPvxcBgMrFtrV+ZeCqoUVNLnJ9Q0Bm9BYl6zOek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85973ca2-7a7a-4ef1-e4ba-08dc42995186
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 13:35:44.8104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85+vHmKpOIyustQ2vzAcock0uC5paTgje8HFjsdZSLi7OUhh036/SCDKuprv3Nj0V00mCHX9CThFyEXOrfS5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120104
X-Proofpoint-GUID: Lj3hy57aX7frW3CtpOFWslFolKSe7bGQ
X-Proofpoint-ORIG-GUID: Lj3hy57aX7frW3CtpOFWslFolKSe7bGQ



On 3/12/24 10:16, Zorro Lang wrote:
> On Sat, Mar 09, 2024 at 03:40:34PM +0530, Anand Jain wrote:
>> Given that ext4 also allows mounting of a cloned filesystem, the btrfs
>> test case btrfs/312, which assesses the functionality of cloned filesystem
>> support, can be refactored to be under the generic group.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/312       | 78 --------------------------------------
>>   tests/btrfs/312.out   | 19 ----------
>>   tests/generic/740     | 88 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/740.out |  4 ++
>>   4 files changed, 92 insertions(+), 97 deletions(-)
>>   delete mode 100755 tests/btrfs/312
>>   delete mode 100644 tests/btrfs/312.out
>>   create mode 100755 tests/generic/740
>>   create mode 100644 tests/generic/740.out
>>
>> diff --git a/tests/btrfs/312 b/tests/btrfs/312
>> deleted file mode 100755
>> index eedcf11a2308..000000000000
>> --- a/tests/btrfs/312
>> +++ /dev/null
>> @@ -1,78 +0,0 @@
>> -#! /bin/bash
>> -# SPDX-License-Identifier: GPL-2.0
>> -# Copyright (c) 2024 Oracle.  All Rights Reserved.
>> -#
>> -# FS QA Test 312
>> -#
>> -# On a clone a device check to see if tempfsid is activated.
>> -#
>> -. ./common/preamble
>> -_begin_fstest auto quick clone tempfsid
>> -
>> -_cleanup()
>> -{
>> -	cd /
>> -	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
>> -	rm -r -f $tmp.*
>> -	rm -r -f $mnt1
>> -}
>> -
>> -. ./common/filter.btrfs
>> -. ./common/reflink
>> -
>> -_supported_fs btrfs
>> -_require_scratch_dev_pool 2
>> -_scratch_dev_pool_get 2
>> -_require_btrfs_fs_feature temp_fsid
>> -
>> -mnt1=$TEST_DIR/$seq/mnt1
>> -mkdir -p $mnt1
>> -
>> -create_cloned_devices()
>> -{
>> -	local dev1=$1
>> -	local dev2=$2
>> -
>> -	echo -n Creating cloned device...
>> -	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
>> -
>> -	_mount $dev1 $SCRATCH_MNT
>> -
>> -	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
>> -								_filter_xfs_io
>> -	$UMOUNT_PROG $SCRATCH_MNT
>> -	# device dump of $dev1 to $dev2
>> -	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
>> -							_fail "dd failed: $?"
>> -	echo done
>> -}
>> -
>> -mount_cloned_device()
>> -{
>> -	echo ---- $FUNCNAME ----
>> -	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
>> -
>> -	echo Mounting original device
>> -	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>> -	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
>> -								_filter_xfs_io
>> -	check_fsid ${SCRATCH_DEV_NAME[0]}
>> -
>> -	echo Mounting cloned device
>> -	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
>> -				_fail "mount failed, tempfsid didn't work"
>> -
>> -	echo cp reflink must fail
>> -	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
>> -						_filter_testdir_and_scratch
>> -
>> -	check_fsid ${SCRATCH_DEV_NAME[1]}
>> -}
>> -
>> -mount_cloned_device
>> -
>> -_scratch_dev_pool_put
>> -
>> -# success, all done
>> -status=0
>> -exit
>> diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
>> deleted file mode 100644
>> index b7de6ce3cc6e..000000000000
>> --- a/tests/btrfs/312.out
>> +++ /dev/null
>> @@ -1,19 +0,0 @@
>> -QA output created by 312
>> ----- mount_cloned_device ----
>> -Creating cloned device...wrote 9000/9000 bytes at offset 0
>> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -done
>> -Mounting original device
>> -wrote 9000/9000 bytes at offset 0
>> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -On disk fsid:		FSID
>> -Metadata uuid:		FSID
>> -Temp fsid:		FSID
>> -Tempfsid status:	0
>> -Mounting cloned device
>> -cp reflink must fail
>> -cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
>> -On disk fsid:		FSID
>> -Metadata uuid:		FSID
>> -Temp fsid:		TEMPFSID
>> -Tempfsid status:	1
>> diff --git a/tests/generic/740 b/tests/generic/740
>> new file mode 100755
>> index 000000000000..2b2bff96b8ec
>> --- /dev/null
>> +++ b/tests/generic/740
>> @@ -0,0 +1,88 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test 740
>> +#
>> +# Set up a filesystem, create a clone, mount both, and verify if the cp reflink
>> +# operation between these two mounts fails.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick clone volume tempfsid
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.*
>> +
>> +	$UMOUNT_PROG $mnt2 &> /dev/null
>> +	rm -r -f $mnt2
>> +	_destroy_loop_device $loop_dev2 &> /dev/null
>> +	rm -r -f $loop_file2
>> +
>> +	$UMOUNT_PROG $mnt1 &> /dev/null
>> +	rm -r -f $mnt1
>> +	_destroy_loop_device $loop_dev1 &> /dev/null
>> +	rm -r -f $loop_file1
>> +
>> +}
>> +
>> +. ./common/filter
>> +. ./common/reflink
>> +
>> +# Modify as appropriate.


>> +_supported_fs btrfs ext4
> 
> If it only supports btrfs and ext4, then it's a "shared" case. Generally
> we use "_require_xxxx" to _notrun on fs which isn't supported, except
> a fs totally not be supported, we use "^$that_fs_name".

Moving the test case to tests/shared.

Rest, I'm not entirely sure if I understood what you said. However, upon
looking at shared/002 test, it appears to use _supported_fs xx to filter
out unsupported file system types.

> 
> As this test need loop device, so you might need the FSTYP is a local
> filesystem, so:
>    _require_block_device $TEST_DEV
> 

I got it.

> And...
> 
>> +_require_cp_reflink
>> +_require_test
>> +_require_loop
>> +
>> +[[ $FSTYP == "btrfs" ]] && _require_btrfs_fs_feature temp_fsid
> 
> I'm wondering if we can have a common function likes _require_duplicated_fsid ?
> Then this function helps to avoid running this test on those fs which doesn't
> support (e.g. xfs can't mount duplicate UUID now?)
> 
> e.g.
> 
> _require_duplicate_fsid()
> {
> 	case $FSTYP:
> 	btrfs)
> 		_require_btrfs_fs_feature temp_fsid
> 		;;
> 	ext4)
> 		# not sure, does it always supports that?
> 		;;
> 	*)
> 		_notrun "$FSTYP can't be mounted with duplicate fsid"
> 		# not sure if need a real testing at here, likes mkfs
> 		# on an image file, copy it, then try to mount them?

As of now, for other file systems, I think we can maintain static checking.

> 		;;
> 	esac
> }
> 
> Any thoughts about this?

It makes sense to me. I will use this.


Thanks ,Anand

> 
> Thanks,
> Zorro
> 
>> +
>> +clone_filesystem()
>> +{
>> +	local dev1=$1
>> +	local dev2=$2
>> +
>> +	_mkfs_dev $dev1
>> +
>> +	_mount $dev1 $mnt1
>> +	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
>> +	$UMOUNT_PROG $mnt1
>> +
>> +	# device dump of $dev1 to $dev2
>> +	dd if=$dev1 of=$dev2 conv=fsync status=none || _fail "dd failed: $?"
>> +}
>> +
>> +mnt1=$TEST_DIR/$seq/mnt1
>> +rm -r -f $mnt1
>> +mkdir -p $mnt1
>> +
>> +mnt2=$TEST_DIR/$seq/mnt2
>> +rm -r -f $mnt2
>> +mkdir -p $mnt2
>> +
>> +loop_file1="$TEST_DIR/$seq/image1"
>> +rm -r -f $loop_file1
>> +truncate -s 300m "$loop_file1"
>> +loop_dev1=$(_create_loop_device "$loop_file1")
>> +
>> +loop_file2="$TEST_DIR/$seq/image2"
>> +rm -r -f $loop_file2
>> +truncate -s 300m "$loop_file2"
>> +loop_dev2=$(_create_loop_device "$loop_file2")
>> +
>> +clone_filesystem ${loop_dev1} ${loop_dev2}
>> +
>> +# Mounting original device
>> +_mount $loop_dev1 $mnt1
>> +$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
>> +
>> +# Mounting cloned device
>> +_mount $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
>> +
>> +# cp reflink across two different filesystems must fail
>> +_cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/740.out b/tests/generic/740.out
>> new file mode 100644
>> index 000000000000..6ca8bb7e1b21
>> --- /dev/null
>> +++ b/tests/generic/740.out
>> @@ -0,0 +1,4 @@
>> +QA output created by 740
>> +wrote 9000/9000 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +cp: failed to clone 'TEST_DIR/740/mnt2/bar' from 'TEST_DIR/740/mnt1/foo': Invalid cross-device link
>> -- 
>> 2.39.3
>>
>>
> 

