Return-Path: <linux-btrfs+bounces-11465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1DA35C22
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 12:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079B716E9A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55025E443;
	Fri, 14 Feb 2025 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V2SGtg46";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e3Ajd2Io"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BB25D527;
	Fri, 14 Feb 2025 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531142; cv=fail; b=CRwWfPEG8osyyxAq7xFKdc+kUz+nyfRPi6TKHkE2g4Tc7NUI8pdmzFvBsN3ttYfdPyK9Fs/kJgk4CiczHQYW9kf8WZJsnUSCz+f858oUbkxPGcBfCbuUPw682sMr42wNJXSwewmiemkUBeBkQgEwgyJzKrqwE/RfOVqKoeBrBW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531142; c=relaxed/simple;
	bh=jJJOBt6N5prbQ9v2dVLBA9TDTawsqJNiKxKhucBPMPM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NoHeJhBboPlsNmT1y68UDfc0w9nEaETgrKWIyD1VJLFbbId5nCNLEiRGpZro1p4LL0mq1Iw+rOJfPzU1EeNedUAc8CqlbdmmIgRQZdXYLUHylVBblL02c2B1lsSauZ9tZUhlVAKEiy1f5lawWWKAVduhY8OpeOqEPCKZQfLzMyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V2SGtg46; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e3Ajd2Io; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E7hexl028843;
	Fri, 14 Feb 2025 11:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=46ZJ9YCWAMFiFG2K
	AgwijtsfrXTuh2IjXaoIm6KF/GI=; b=V2SGtg460T2LNCDYbLqNKrQAfKUqG1pA
	6JDdy5WMAdv/LdSIzp4LSOgBROzhEjIih0tmei2s7mYyOqDelccCKLAG6xxtAf6n
	BCGiiaS/QOopNJ67LmFjLDFWEvtXwDDOV6hnys/FjRd/nh/cDX5IwprRKDLgw1EN
	DODh2tGnbwXkeuRp0//WkLXlrGwi4R6Dme9u1g+Vsgt+p8TLYw390h+7F3wKBF9x
	eWSQtPAyZYr/A3zc3R7njuTsYgtA+SpWxx3Uume0SWBFs0ym1wVQfr2yGcyDl8sw
	14v564+tjmBeimax+yEwGlaJ3EFc+EXVzupdECyZqSIy6LONbjv+yA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4bcrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 11:05:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAF8cw025325;
	Fri, 14 Feb 2025 11:05:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqkkpq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 11:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9OW+JE2jiq62zIaGDu55VKc3UbulB8ZsDw0zVBYCTVlaKNC3Bg/cJ2lIecORpv0+tsYSCMeKq0H7HJW07iyAXplccH6h6CEeoI1V1nJo400TMyT1Ifr+EKt0uiTobzjMyzXTDEsfIZ64JNHCrkIsQD3SDy7KoHjq68u6ww3kwE59azkg2GaMNSlKbHEm5l5RgaT+ScU7y18Yf6aMH6d2WvAw7yrgTTbHe/nWlR6BN9qAfliiDI3gWBo4z7C8Y0onNzBW0GtUdocHPvcCSwBzqrqMkEWvc+f1qzbF3XC9wspqOxbsBcUBX0A7TkitGXmR+rhw5bRb0PyLkjHMwxN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46ZJ9YCWAMFiFG2KAgwijtsfrXTuh2IjXaoIm6KF/GI=;
 b=Tm+cVph1d1+PjVmbvxQT3Bw+8Ss6w5IjyGq+q5LhS72eydlIXeBzN8ZNZaczwdorljBrZGwWnKPxGXXG0ijGFhTrQP3bd+QEJihKhUkPff+PgpN/GpHSmOJllgW8X+7IJTWptxu4tUqIu4H+EhZmSDnw8kXwhXG7zHhFu87v1VCjNLZhND5qXPa4iXbiGZTDGKTKs7fjohDKq0vr/v+rXbBlv12HiCSotVR4PhP2q2xoum6wDnMsfoH1yQ2zTFknF/bXR+tsfMDQCvUB+w3O+ZUm5nFTo/hPFO1FgKNSZL5wM2ea3UqI+cB4Du6DYDHQenDhmMctnum5dGMRb/Mr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46ZJ9YCWAMFiFG2KAgwijtsfrXTuh2IjXaoIm6KF/GI=;
 b=e3Ajd2IotNKGQ6SwAmJx5WVkeh4hbpxX3/CpPxYKFsPgxFEcmMZOsJq+LdK8s1yk8OFz25SrWHKE3DcEMjBP8kyTTAjlx29LFrH8GraF0Cl8ILdLQuaKqbJ5sbpNgD0HAv4bDtz/NgB8RCbKziwwPFb5dKMM+Xofn+8mAGh52KU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6346.namprd10.prod.outlook.com (2603:10b6:303:1ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 11:05:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 11:05:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for master and/or for-next v2025.02.14
Date: Fri, 14 Feb 2025 19:05:17 +0800
Message-ID: <20250214110521.40103-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cf27b0-5d25-4e0c-c2b4-08dd4ce780c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXFpc0ppZ010MHdtVTh4dE1lSDM1VmlWSG5qUnFVNjNPajhwYXNNY1VpOU1o?=
 =?utf-8?B?SFRnMWUyemFTem9yeFVJS2xYeU91SnYwQVppa2tQbXRZdmJtYkxrZDYrdHJB?=
 =?utf-8?B?YlZUKzZNUVhGb09jUDZBMkEvRVFJZzdybGVkUFFIdFVIVFlYcTR6S1dZSmtx?=
 =?utf-8?B?TUZEUWs3Sy9Yek04blg4MHdWQ3puQ1QzaVdMWHF3M0NyZnlPWUFveVpuR1Jm?=
 =?utf-8?B?YWlVeXNTWUYrdUlaak1kRUliR0VxR3JWVExFanNQY3JXUW14eUNET3E5VGlt?=
 =?utf-8?B?eElyYS9DeThuTkxvWHMxbHo3UERnT3VTQlNpazBnd3UvU2pLVmlhNi9VOTBl?=
 =?utf-8?B?U0hEb2FRMU9mVVJ4WHdTckpnVUhHVmsvb3Z5OTRaeXhaTHVlblQwaDJENm1D?=
 =?utf-8?B?RlU3cEhKR2NoRmJUL1VBcm1PcWlSKzA5NVRVamRFZWI4aVIwcXZUV2RFTElR?=
 =?utf-8?B?MUNUOG40ZXJxUzJLQWJQSU1jam5NNFZWdVU5MDcxZnFiK1VkYm5CeVRxYm8x?=
 =?utf-8?B?YUhNVmRxRkdqSDY0dGRJNFVrcnlnNHQ0VVhuUDNNSWhlM0tkUGlRZ0NXcVNO?=
 =?utf-8?B?aFZKZWoxL3NUVEZ5dDdwNmkzT0lsVi80TDB0WnlJYXBSS3BKYXcvWFpFdThX?=
 =?utf-8?B?ekpselFjWUJNWXhKNjVsUXMvSytmMlFueENsaThVR0t1V3J3NjZoeGcrajBF?=
 =?utf-8?B?cThPeFcydDZjbnY0bXFTSkQySmdaSFU3eENpNlVjNXZlK1lzMlJ5NUdLMFBt?=
 =?utf-8?B?YzhFRlNVSCtIYWdXRU1vUlltWEVrODhRWEF0N1QwNEowR0cwZ25pVnljZkVS?=
 =?utf-8?B?cmRpSDFXVm1NQ1h2TTNXMnlZRG9EdEJRZE1oYUE1cU9SNjIyclZhaUhEWmNj?=
 =?utf-8?B?RytGQWtQZTJndWxSSmlnc2xmSER1NGV0a1VUR3RLWEJmU0ZYQktJeEQrbzY2?=
 =?utf-8?B?V3ZtSnVQQUVOTkY3UjdpVjllcWFaeFZZM3JpRytmMlNHcmwxQXB0R3RnSFpW?=
 =?utf-8?B?RHVqelAvVGYzSzZkbUtDblZneGJBRnROdXZsZisyVkxrUXZZenVkdHMyU1VP?=
 =?utf-8?B?d1hIZk5yU0pOU3c2NzZWZG9yNCs0N1pjOU9wSGtob2VWZlhRdVdvbHg1dHZq?=
 =?utf-8?B?eThrYUJHbzhwTjNTUUdzVmZMTzVGbTBYMHFUSzlvSWdyRWluTWVuUGlzVzB0?=
 =?utf-8?B?VStycXJlbEtjc1dPbDFDZVlhMXAwUVRpRUhxeHM0MjJ1UXlWK2FEWWNhT21J?=
 =?utf-8?B?M05lSGxaWVlBZk9zcFlqUmxNRENreXBOSXEvWFZreVpZcStRWlpPWGpCSEdR?=
 =?utf-8?B?K0hXUzJRSUxuY2xKZGpITXNSTzRaalJFVVRZRllFbXlHUUk2UW53ZTdBcWYw?=
 =?utf-8?B?a2h1d1QzWGVLaVRySUpUcS9sNk53MjNJalUrS05qWHdGRnM3YzZvUTZNNisy?=
 =?utf-8?B?VmtucDZFVHVwNVRNd1lXUlozWTI2ZFp3SG1IdjQzdVorb1RwM0NKODZtWFFJ?=
 =?utf-8?B?amdTQTRCajAvT2RZS0RQUitHVkNOYURURXZSOHlTY1NxQzRiYmp3S2pxbWN6?=
 =?utf-8?B?NEtsNlBuS2NUWERIaXJNSjZDdkROVjhrb21BN1BNYlQ4UDVVbjQrQTZGaGdS?=
 =?utf-8?B?WUJXR2FIekRKYms1NVhLQ1ZjcnB6eFdRL3lDcGJMT1Q4dXBWZ0V3dnNNMTJ2?=
 =?utf-8?B?N2Q1WWhlWEhPTnRzdkhsSVpKZkVLQnZrWnZIbVpDbFFWUlBLYms4cVZLVVM0?=
 =?utf-8?B?RGIzQlNwYkdkUXZ5UFlXZ00zZld6UlVLdk5yVnJrOXJMK3pQQWhvUXlmQWJz?=
 =?utf-8?B?UXpMdm1vNk0yMkw2cEZWQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3lYL0NIKzJvOUFVL3dhbXJCSFpBSVJMQ2tjNHpKdFdxMmlXcFlWTXU3L2dm?=
 =?utf-8?B?b2pNd2JGaUVja3RwcVJZVitHRkQvQ29sMTR2a3ByUkRtVzRrK2tUY3RrYklI?=
 =?utf-8?B?M0pOZ2lKbUxraDhLNUkwRnlGUi92cm0xcjM3eEE5QlBrdmdPN1Ixa3FmM0sy?=
 =?utf-8?B?L2R5K3hmNktiZUVGUlQ5dFFIQVlLVjRxSThrTlVFSE1RTmJOcHlibTBjendJ?=
 =?utf-8?B?d0h3TXpZbGpwLy9iSnJrYmlWRTNtSjBCS0QwRU5rM2VUSmZrTWU4Z3J4VXQ1?=
 =?utf-8?B?emRKUkE2SUREMmVmaU9RcEFlZGJGZE1ubm1SV1VDYWpsSzV4YUx4TTFXKzhs?=
 =?utf-8?B?bElxOWdSUk5WU1ZNLzZRVUs3WkMyMUVKSjl4NXRMaEJGcDI4bFBiaUhSRVZC?=
 =?utf-8?B?QkRxTitRcG05TStGbEk1MGcvN0tCUkQ2VEZlYVpHNmlOUmtiQXZSRW9iODZ1?=
 =?utf-8?B?QlpkRVJKb1JNSU9HV2dCVnJLUE02bWE5Nkg5em9zSGNIOTl4YmRjZXZZc1hP?=
 =?utf-8?B?bFZ6RE56UXhPOFdaaFAwLzd5ODZKVENGNXcvRXpRTHJNNFFrY3cvQkNaeDFC?=
 =?utf-8?B?R2lEWkxsQVZYTFF2YzlJTm43K2NsRnpBaURBN0pyNVU4NmxHWWpncGxna0E0?=
 =?utf-8?B?a1dIZU1XRGNkY3RUczVYYnRHbEsyT3VDQzNLTFRHZWNMaUNEYzV2SjdsbzhD?=
 =?utf-8?B?RllkUHdlTit1dzlGM1NEbWljVkM5T2NmcGFpRVRyaURGY0NtTStJaDRmck5z?=
 =?utf-8?B?b0hsV003OVNuZGRETkIvRXhIcDJQYzRlQjBQS2Mzb005VlMvd0F4U1g5Z3F4?=
 =?utf-8?B?VGNKSjlmbVgyeHcrR0FZOC9abUVuaXBod0VhYWRxMVVDa040ejR1VFZPM0NO?=
 =?utf-8?B?dCs1SmNVczFYc2ZLaWszUzdMbndOWU1XdjdSY1FVMXN0OUp2aUs1ZXpjOWJa?=
 =?utf-8?B?WUwvVmJTMi80cmxqKyswZ1c3a2UrUnhSbEtuTS92S2Y0eXI2anFMakQyMFRV?=
 =?utf-8?B?QkdrTDlTazg5eUF0VlNMekFnWCtDdXdneE4ydFZ2VW0xWkNCWGJNVnhhWVZ1?=
 =?utf-8?B?bEhhR3ZrdWk3cEFGV3RoeE9RSWpiOFZjRC9FYVJBYVZENDA0REJNY2I3ck1Q?=
 =?utf-8?B?OW9QbTJiUHp6ck5Fb1Q5R0lCekVEZ092bDk1U3ljWTN5eWVHK2pqWk5OZ21L?=
 =?utf-8?B?eUVJQmtSdmpkK1VFQVEweEt0WUp1UWUxU1BCd1lwckFHY1duQm1NWmhqL3BW?=
 =?utf-8?B?UkFrNUJBM0hHamdvdlJSRTIvelllbDJNWDFKZkY5Wlh2NWtCeXc3MTdJKzg1?=
 =?utf-8?B?WWV4ZTRyK3RSN1hzaVFYN2lmN2NGR3MyOGEvYWlXNktzaC9pcEE3empWNnVr?=
 =?utf-8?B?c2ZJODF6OVh6cFpmcVN0RVBEMlJDdXMwc0dpUzloOVRSdFNvaC9JUjZGNU43?=
 =?utf-8?B?TVg5dkJpdGJhNk5CN3NyRmlKSnBkeXBPMVJ2V1FKZWNML2Vpck93Y0ZmcWZ5?=
 =?utf-8?B?c0x6Z1JZZS9NQXRFSU5KTVU3ZEFUckhLWjE1QWsrQ05Vc2dwUEF2YXRHZU9S?=
 =?utf-8?B?Zzg5emNaajhYcFlDajhsZVNWV0hPZUtER05xdzBXWFJUWGtUSEc4YUp3M3ZG?=
 =?utf-8?B?VXNpM1V3bzZtYkN2aWYreXVkOFVLZnJGTW9MaTRrNVdyYmFMVUdIaHV5MDhu?=
 =?utf-8?B?dUxWc29LZ2hMckxBbjg3MnBqdnZCMW5PeU5YVFJtdFQvTlV2Wjl6b1REcWZL?=
 =?utf-8?B?elFxcXdoQVozejlUMjF5WDJBTStoZFVyY3ZWcW1HRmRiM1lnajh5bGJVZ3NM?=
 =?utf-8?B?bHBENHFtM2w1azNadzV2TXZlUmtsMTlqRndJcUhkcC9vWTFmYjIyMEJ1M0Y3?=
 =?utf-8?B?NjdUa3dpak5sNExsZjVXSWorY2ZsOFlTaFU4bjBETUpqZ1diZEE0eGo1Sm51?=
 =?utf-8?B?TUU2MFlCOUFuUmdZVXlOanY0ejJIUXF1Y2hPMUNBVkd4bVBQQTl0VWpqQ3I0?=
 =?utf-8?B?MmxDUWN6WXVOUGZFVVVaZFZIQjgyUmNDK2dlZ3Zvd3JnNVpja2dDMTBWQXNL?=
 =?utf-8?B?dExrSERFK0g0eGlMRU9BV2ZmbjNtUncremtIbVYwSkVteDk0WG5Zd3JLbW12?=
 =?utf-8?Q?Tf7SDPeSlYY6dkM7jF88YWpb2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kvqIvlcvtViZwsPB9sUVyx2Gjp5M5SP4UwMRQz/vdB5tFuj4l336Y0YzCP7v/b4VCWMr1N6Lc40AMIanOdxM7cscfl1Khlgp8mWY7go6Os0cP2tGyQbhy8RmLVgxKFsZ+2WAqREtzIGOsDCQNYaYEk5y2ZhGb4BZBkGx8IXDhRekDKpzg/CJjgJyriyo0fIXMg6x/jeYQi9VMbSGy787l7mXjZsF7On6NmHkrbkVe3X/R5ziZ9hLQjdRs4pFoGR/c7HXPePQKHJOx2TSDJ5O89/DouWQNQhiea/jqLLDJd8+FOLq3sLYcG4DBaawOsG8//vnVrdwWIAiwVjFEIP1C2h8dbFeoGm4+JLv9wq47zBda/ocIa+hff51x7rvRosW1BWcxdfLMWZzGFwbNygVGG+72JBhMtoIeO1QtWPK5pn0W/flc1vyxvrdCkkSc6gakrlTj1dAnfhXLng+LqupcNZlqJqPCl1YgRzabLiMGa/AxCwY0GsKZB8O4ywJ/2d+wR9ZOg8MCA7g8h0Wx787+iS2NwWMnMLabrt5j4tiUOUFPx91pGhWWSj3IqDhowrgSm+TkgwUE7QtyDYABZ89gbSp6+Mrnr/TjszJga7wI1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cf27b0-5d25-4e0c-c2b4-08dd4ce780c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:05:34.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FOfHyicNaweE8t4btXYCOS22572S95Lk7tQQTG0MNrwEp0SUo28iy6TanisR/3UyShNqFOR4uO2kLQkS+H2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140081
X-Proofpoint-ORIG-GUID: p8t1NPN-Qf-4K_r83x1OXNdxI68Yk-d7
X-Proofpoint-GUID: p8t1NPN-Qf-4K_r83x1OXNdxI68Yk-d7

Zorro,

Please pull these branches with the Btrfs test case changes.


 [1]  https://github.com/asj/fstests.git staged-20250214-master_or_for-next

The branch [1] is good to merge directly into master. It’s been tested,
doesn’t affect other file systems, and has RB from key Btrfs contributors.
But if you feel we need to discuss it more before doing it, no problem—
kindly help merge it into for-next. (It is based on the master).

After that, could you pull this branch [2] into your for-next only? as it
depends on the btrfs/333 test case, which is not yet in the master.

  [2] https://github.com/asj/fstests.git staged-20250214-for-next

Thank you.

PR 1:
====

The following changes since commit 8467552f09e1672a02712653b532a84bd46ea10e:

  btrfs/327: add a test case to verify inline extent data read (2024-11-29 11:20:18 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20250214-master_or_for-next

for you to fetch changes up to 429ed656f99c06f8036eff1088d93059d782add4:

  btrfs: skip tests that exercise compression property when using nodatasum (2025-02-14 18:35:16 +0800)

----------------------------------------------------------------
Filipe Manana (7):
      btrfs: skip tests incompatible with compression when compression is enabled
      btrfs/290: skip test if we are running with nodatacow mount option
      common/btrfs: add a _require_btrfs_no_nodatasum helper
      btrfs/205: skip test when running with nodatasum mount option
      btrfs: skip tests exercising data corruption and repair when using nodatasum
      btrfs/281: skip test when running with nodatasum mount option
      btrfs: skip tests that exercise compression property when using nodatasum

Qu Wenruo (1):
      fstests: btrfs/226: use nodatasum mount option to prevent false alerts

 common/btrfs    |  7 +++++++
 tests/btrfs/048 |  3 +++
 tests/btrfs/059 |  3 +++
 tests/btrfs/140 |  4 +++-
 tests/btrfs/141 |  4 +++-
 tests/btrfs/157 |  4 +++-
 tests/btrfs/158 |  4 +++-
 tests/btrfs/205 |  5 +++++
 tests/btrfs/215 |  8 +++++++-
 tests/btrfs/226 |  5 ++++-
 tests/btrfs/265 |  7 ++++++-
 tests/btrfs/266 |  7 ++++++-
 tests/btrfs/267 |  7 ++++++-
 tests/btrfs/268 |  7 ++++++-
 tests/btrfs/269 |  7 ++++++-
 tests/btrfs/281 |  2 ++
 tests/btrfs/289 |  8 ++++++--
 tests/btrfs/290 | 12 ++++++++++++
 tests/btrfs/297 |  4 ++++
 19 files changed, 95 insertions(+), 13 deletions(-)

PR 2:
=====

The following changes since commit d1adf462e4b291547014212f0d602e3d2a7c7cef:

  check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE (2025-02-02 21:28:37 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20250214-for-next

for you to fetch changes up to dd2c1d2fa744aa305c88bd5910cce0e19dfb6f41:

  btrfs/333: skip the test when running with nodatacow or nodatasum (2025-02-14 18:37:09 +0800)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs/333: skip the test when running with nodatacow or nodatasum

 tests/btrfs/333 | 5 +++++
 1 file changed, 5 insertions(+)

