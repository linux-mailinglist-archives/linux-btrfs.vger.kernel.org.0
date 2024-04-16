Return-Path: <linux-btrfs+bounces-4289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9388A6116
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AEE1F21BED
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27617FC1F;
	Tue, 16 Apr 2024 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VyBHEnFE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0BJfdosY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582A171D2
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235042; cv=fail; b=K5Ht7/O2Ln2/62WHMq8ap3GSDCc3Q2jUpDq/ciZxRaCcRO5uzNgtV8fc1wUm/fZolgB1MzkNHKfrHKuas7YJ0e8QuPxcH6pwaQdrTY9N+STqqlWlmQmNIQ0mvf1X9kt3z9mL0FxSeoXUCjk37f8phFlE4Ie3ilTk9aWwpvY4FHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235042; c=relaxed/simple;
	bh=FnYkrBkwtT5j+Qq47AL5cyEpMnx3nCHqkAWMPv9M7AA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PeAToXABRJWgByGc2I2mkbvTwssgDk4OpRDDOUOn52vF8e3QBvdUvjMeLhhLZpHW0YQb3un3q9CB74gXx23BuZjk4cr3Q/hHV10j0ZY0Uq9r8/mquIi4Pm94D9oMO92w52vNnlR9pTyZWGBM0hctVGFUomWdDQ5rNXhjraIe9EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VyBHEnFE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0BJfdosY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FNE95S017717;
	Tue, 16 Apr 2024 02:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=iSgwe8CysT1mx05Nk6KhDLSEZxIxwKei+7+xbn5eASA=;
 b=VyBHEnFE1CkD+ZAIxu6fnJnwsLqXk7eRAGvwEqi+NgiJoTEa6INQTe/T63bw6j0e83HF
 orMppZYIfD4QlauqVE9WDMTtpDW/EPPbFqDMll2l+vRtYCs3cYC8yQ00acq8URB1Dabd
 SNWiaNXxbfo/mhmU9ktrvvT89Er74FrZJ8S/QaDXI4PRuIjUeGZ8mBpyjkZ2+6JFrdZF
 d8Xg8CERfMKS4R3JEOwX+lKJZU/zU7p8bKyEvUxrZ9NKSfshVnN9d/iogKL55EW+VC0y
 19r+XJ5udR9T7Jco9F6DX4TjrTkEI3SpUVuTOgWumDv9W9mP6xWnhijNqRl3Lt64IYXU qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffc7pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 02:37:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43G22kdm029018;
	Tue, 16 Apr 2024 02:37:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg6kg13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 02:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T27Zf/zIeiDasuYcc0pIAdXtq24eZxbk/2j7mvOztUb+Ln1snJduTXyH0HU7koJDhG4aDTXQIuWnp1mwpfDpdwkn8VLyLUOcWsi3W9k+Ghxes5jNquuldSIYo6jQjOXIc5Mtp0sa5PfgiKAKOsdm3gt5kww+//i+XlOc+gOontk03xkop2ys4aM2ZokIdMW/KhrCXRpOjTH/zCRPir8nGrb03ICkSux5KP4ITFgFx4SGgZHi81CUVjNeWtvxqDLwxY9fap9EO02hETe/ZGlmkHg3BTkk963YL9eruLLmJJxUzsW8FIa/v4y34WbPa+Z1Je3+qXWMjLeDtZ4MU/2UEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSgwe8CysT1mx05Nk6KhDLSEZxIxwKei+7+xbn5eASA=;
 b=N8jfphUYWQSfwoouUGWocrTyn4yjWbEh3SeGOibuhLHtdO3YWDb/9fH0Om5tqf2O4DFNROkTHqXlQ+OCmjmnJwPgKQMNm+r85CNGl5SrTZKWhvWWwPp1zPR/rrE+dWot2Lnmq7InBey0GjeJQ5VZDOAdeTE+vsnmR4t/PdoNFh5dMTSh0Aiz/SyxWj/g1v14DpOQwCX8IbXjK9Wzpcb7BbZw7SaRFlF1PLa/YvnYnaH7t+ngFApH+b/2DxXJ8qGTtZc6OBfV2LSDh4h3g3EdkHvRb0mwjkrw5uCklAiks43tfCkAMarr12AsakgWEeslhlKiMOpR42AqvhYLRqDLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSgwe8CysT1mx05Nk6KhDLSEZxIxwKei+7+xbn5eASA=;
 b=0BJfdosYvDU+hikeZIdIdfdrFmJETpilALd6XQwciQSNrL/ZLF9MJxmEBBd7ySMqx+QJgexM5J7TmtjzaV57zSB+IC5cjXFycmSGsR+0J3EEtQmrVfK5bOIgJ2e8dYqpH2+bpPhfIDPy3Np8XssejuX1IqwQ4RvE7vNk3Aippzo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 02:37:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:37:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/1] btrfs: report filemap_fdata<write|wait>_range error
Date: Tue, 16 Apr 2024 10:36:00 +0800
Message-ID: <80c3c9ccb6e7ea366d88f0e5b2798f5bbd3b381c.1713234880.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: fc135be7-8a6c-4336-4ec0-08dc5dbe20f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1V5gxNXMTIo3PwNwfsYVSEOhTZVeT9bVZhibP3K/+G5XRVuR5vwGIfgTRKpcCj/RWDg9+4qj9JwNzuRorz3ik/RJet+LLdcYk11fXYfPisQGQaAiStzMbQwTCHcg892zAJemP86zuVRIIpYMlZVDOGTp9pHf5QvwuBFElySCFPvOtqeAL0Y45f1rx2IY3qY7Vk/zZ6Ik1p6VfGA4KAXmLPxA1hhlemMKX4xbmcxBNEv5MNUSbDguZ4T7nrGhq4mn1qfsmvk6O9A5qgAOVPxitSTJNxVTrdw1KqYMasljKXsyQJ86kttVdFLatfyq2B56+d2w5UT5ALqWa+KKHNIIPT32SB3YxSERCdTPrxe4fQU3NFF3mDhQx7AT3h3ZRUBLfGvrQHfsADseZCQ6WzcwcATSdnqgqIjEG0Y33a41DVcO5/FIDmnB4cnG4jzDJOdIPdtXtHeVF0vnH9pzeXsWWruthYg2/WOvPdv1ZZusWD1WMELE3UGqS6DJ7q0EcMKZRvypv4EHXwAfjDJvizOsjYX/J2uz8PCzV5SDdj6ojKjPZ/QDsqy7dQLnMuhCs1Rqnts50nVSoqdvW64d09NdKfe4v4zuzkHCM61Es5BvrfeO7KHazKc/sTgu8NwrskAyM9MKVpyJX86pfb/q/pSZmvtJ4ZG1f0+PA/EoLSi3Xec=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l8pTnuE0T+QKT8mIUZPVvncjrGJT+u2SFo7C7u1IZTvrtVaVQpIRjtjqh/9B?=
 =?us-ascii?Q?ycyP8I6cP+XR1KG3inEsxdeBAeHKgIshVzHcCXlvea/LzvlxV6F+eqv9BaQj?=
 =?us-ascii?Q?s/sHJaCQs6i9XQcj7ZX4LEFTu70UnaOUJKqdmW+NWJaFPGclHdDelahiO1sa?=
 =?us-ascii?Q?FeVrMtR9b4YGb73htedD8haI3Z4Av98K7CF85rnsUpBFgttTzkEykOuiPXZW?=
 =?us-ascii?Q?4dExp1PzyVoHwcJeP/tLbx0zQXDMcSUzGep2KIMXIXqJ6WyVIMTuUL525bKn?=
 =?us-ascii?Q?N8vtqFNBKsKvcTrlZMg4uZgCxaz0oBuQ6eTPsam04xDtJ7JLZyC99B3C9M9o?=
 =?us-ascii?Q?z1lwudeLP1n0iVam3Fga4MBxh8RRPOPxSn3vyiM2RIG2A5LzT5MjI58D8bLE?=
 =?us-ascii?Q?PRrKJMNpgtCSEZ2LzPXSeJ11ysHjCmhl0z15JgcHNm9UCRaUYqq1i3ltPADk?=
 =?us-ascii?Q?XQvr3UDf1x3MOw2VeQevW4TUlXAS9XJA7D+H7BIalPTdMz/MIO+CZXMJNtRR?=
 =?us-ascii?Q?k6HPF1x7h7E6TXubzjKnzOGNRkf5ZZ9CrXer8Rr5O6wpqLoMALngYXjuMGec?=
 =?us-ascii?Q?Nz0W7F6JseolbKffU8X2dpQp+sG+OgXZNi0+IhGd4oH/pvutyApXDSnWv1FS?=
 =?us-ascii?Q?AAjYATd7ShkGa4N/DW+A8D03lTTlmCLtPOMVpG4GYN1qMgOP8io5f1YOpfXy?=
 =?us-ascii?Q?3lwsCr067cGGS8QU0Jdk/NsQ0DbYzlB8g9Pn6o0WvPGqjny2pIOdFAIPOaT4?=
 =?us-ascii?Q?k2zByaugS3+4QiQS/gj4fWlrai3DLyz7Rnd7jT6KxPbfhMPq7E5mx2XyQZWM?=
 =?us-ascii?Q?+5DPAZpHNgR3oVEOkjfDfGDYOchhAMWQx3HV95Ak9ffIh5qum4brKGxAnpiu?=
 =?us-ascii?Q?UD14YBqSv5btcFRuwVxUrUjlxCIn9DgDJlRLAieVCrSC4rSWiEHDYnKL95iZ?=
 =?us-ascii?Q?78EHW8GUi6SGt2ZU401T0NxErS+9NS5KbbPD2q2J1RMu4FOEtxEYvL6AAn6F?=
 =?us-ascii?Q?2zvZrg5uQQIx5dIaOb4i9u+EMauYEyh/78lvvjPauIO4N+77DBzqUyjKenxh?=
 =?us-ascii?Q?JwoAJlqkHNbcXX8Du9NgUG+pPmVo+q1zhGzXrYhwOs1AqJe5mVposjAZbiaI?=
 =?us-ascii?Q?6y2jYTMn5lcxAZTtHRkudeDgV08iJwCmUe1Wz9b9orqfB61SNBEL/Q1J7pPU?=
 =?us-ascii?Q?MjHSYnI5sQ39XQMtIr4p6V00Z4QuJzfF5oxfv8LtGF5mvEFg0oKyIHC5m9fN?=
 =?us-ascii?Q?fTB8mE2Z4lAaeJZ1TU5c6Cvpys71dZK3B3k+U8XcryNjexcF5Q/KSbaya0+N?=
 =?us-ascii?Q?o2tNluez68IAHWv0Wxa0BQ+FBVVNdfkeQuDhfe13/0JIcems7ur2RiXdBy6r?=
 =?us-ascii?Q?CH3EBnOjn8Tjbxu7gdnWGrfCsvYs/joM6Wz9/4kJklLoph7Y+Car/kaLFRGk?=
 =?us-ascii?Q?Aw3cbsKwrJip/AmLo5Xize2t+yS8g3oHOPa41g5C4RuGP0Bkry5X4PVGKTYH?=
 =?us-ascii?Q?KlECQJ0r9No9OxDRlBBpt53WlU+WrSv+RyqIu7qvTauv0IWt2msMBMB+SqhH?=
 =?us-ascii?Q?c0zRx2JkMUSkZE4YlHsF2NdGP5sXAYlAsyzv8JkB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X2oyDlCckBZQXJkkr934L/8QXJ/JVzxdSYR5JZtyTDLwmj4ih/uYoOvPv/xUoSBn+h+DzIWbToojmhrVIwuyCOX+VttlsDQ3pAcnP6HQ3rCgFSjmDHIxOD0H2WD5D3PRBCky+IdGV92SDa7ULoI1dT9fS38DyR2AEwiW79tFEWoQKs37cbPtlySeLglj6SCT8+wRAhY3txqiLk+REiuOEwSukqxXIwUGKsO0jL8mB31LgQnHShVq8AwjCV/Ila2o5q/hQHAim+aeNJgcanaa1SmpxaBmFnE1IXDowOoMgy9vVwiZ8gy9tUUpiNkx4x1jtZpDYGCsNhARvCcxCMUDAJUvuNz9Bw+ajFfsla19XuwZetwsmAW2WGFOcNueaEfbAbzIveUw6U+G3tKt49q19F4yCgGWFTSLU+CvzqC28c2OIELOAvrD1ueae9IOr1lIs/F8xUDTNaMXiQGKcrHD2WuBjw2L55DinOwWR6K+KjaJvfv8oQOBbaLpdnfsJxMxhVqRPfoz8o6jTgCNFFUyQlMyHzHN2k9wMlgKPVxY4AtxoLxOLyC4e1KIZ670X4i7Baek3oH6MotOG58hQaArM7H/PA2isMemdJnfRfS5d/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc135be7-8a6c-4336-4ec0-08dc5dbe20f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 02:37:15.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvPKI324G13qsAmUm2/HuVbl2jxwi/MrtqwDkqNLlK1klsN9wCLzQwTam4Z8tHCRnSNhtPCZMiJRo6CQnCqLoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160015
X-Proofpoint-ORIG-GUID: WZCQAl97uTtXrmkx2Qa5uZC-xSymIQEk
X-Proofpoint-GUID: WZCQAl97uTtXrmkx2Qa5uZC-xSymIQEk

In the function btrfs_write_marked_extents() in the while loop check and break if
filemap_fdata<write|wait>_range() has any error.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/transaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index df2e58aa824a..a1c43fa6fd3d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1156,6 +1156,8 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 		else if (wait_writeback)
 			werr = filemap_fdatawait_range(mapping, start, end);
 		free_extent_state(cached_state);
+		if (werr)
+			break;
 		cached_state = NULL;
 		cond_resched();
 		start = end + 1;
-- 
2.41.0


