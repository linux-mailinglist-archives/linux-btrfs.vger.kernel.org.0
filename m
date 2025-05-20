Return-Path: <linux-btrfs+bounces-14135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E91ABD6A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 13:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE723A49D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB426FD84;
	Tue, 20 May 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YNWHJtQ2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lFUWzUpP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB61EB5DA
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740233; cv=fail; b=KR4e7Ox7mm5Cv/Rpz+p3QFlrKAT5btlzzO0D8YQ3DN9HsSl+wCTaOJwKY8elLhcQZ9SmGVf3KriKut3AgByiIZG8dGoYz33yfj+tP2VX3ommPsp6kI+Ej8abdF5JQF5ZUbTmY8tt/iFMnCMHRTKvfGsbNYXKsHnfcWib9XPA3MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740233; c=relaxed/simple;
	bh=xxyCRB1oKvz8VSDzTBm8XZgCHQmtSHhI3/SKbpmQb98=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dOfuep9HlwI0QLQlPX8XS7izhQifgmuRZyQnJwPaFELVH/hS4QMQx4M2vmEvo05Dou0ssbsJBN75QAIMmoK8wOcqtvXLPMWgXZPmcMXOEf6w6rQv5sYXYNEIX9j4a3HAO+Cj5HUL5dLhEZt4nVWn4TIPeWpfhPld/Sx8/blqcaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YNWHJtQ2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lFUWzUpP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9MwVI016291
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 11:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=v1rb692UF0V4zBg7
	Qpw0NIHZbM+WnF7cGdCa8r/nJa8=; b=YNWHJtQ2ztQm6Esy4Bws1mB4Y1zbunIs
	iE4QAYEokuSRx+FWe0cPKgP1/XjLSZm7Pyk9CR2oYNB3/X3L7FB60lvEwF+Dz0M9
	S8box56VvuIfo6c/pqPt/Z6zV7ci7Uf0m0UZ4WFw6hWZjAHiKFkwF1NO/dO536yR
	B+DvYn3gRzowMAxqXJxvBab22bQ8uZ1eYF1C2muZNB44FJo+xp6aoMqYH4DmZeFt
	eOtDrv78AgDQUXarC/yishCs1lHVJg2VywnWiaTlZPqEbion61RGX+W5R4ynV0Ir
	EdOWtXj1nzE5aifewMU6tLGTSYBieZ3lqHtGzbiyou/7UDvrQe9k4A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdny93eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 11:23:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KA4PAE015663
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 11:23:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7mb3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 11:23:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv9ZqBmKGgsINlRT/zWj1X3rlgPCviN2JgHcNE2nGtAbaNObfzNXBFVba5pOU2lui3AdGOAfrpFKky+qVjr7ck10CTTjR/AJ8hqMsqVzIkxHGEhrGu9SWYFEtFBijPSQIhH7xLX0Cxl26nmOUuCvUj/sEZB7wHPHh5hLw83a+78Hbl6xDBDuP8QKf4HPHPzQsSQKHmeHp3YRMBokUpA2sPY7mAKGyCiYl2WUAegs3oV1zqJwkxXLGVxVsB0zhzG2/7bf4yctdoLQvM4s7BkLs/q3BYkryIvleaWSdzTshdo2/to8DOCgAibTvN+/qENbiT/OFXNbdtCIsilb0FEohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1rb692UF0V4zBg7Qpw0NIHZbM+WnF7cGdCa8r/nJa8=;
 b=K3O6Bv2EWbrsx4EHq1i3DQfEGRG16QRyslBrRonlXI90FBQVlY7aLPfCdXmfzlFdqIqNstA6Hnkctym6BzHEFDRK0Epd1qrpvq9NSnqCfBYlb11d5b7l1qq7A8Z6/0Q5N/El7l9kQPcYF4SW7WjjWtqRRsCAuRwHIMue8TJZ/e8gkKNVa8STtsCPTTZ2TgCQA6d0HstXbVc/o9FbmsKa/Uh3Xjs2jM7PQKDj5EhJ1F+3BwyP4wi0MYhvjobL5hxFPcYGiKnRHk4TbR5kozvomYBn50q7vUr+f4SVNb29G1Q6CMG64g8EvHgMySiEicsYf/1f0XQWgmDp0XQmeO6uYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1rb692UF0V4zBg7Qpw0NIHZbM+WnF7cGdCa8r/nJa8=;
 b=lFUWzUpPWvLraL4xqJG/RFX9YdU4nssjNGH49gtTb3t050ZnXIQJ/Pg8z08YihR3jBLPUVLyGVg9tgzj1w8EcVadmzya1wioD+BfTptwCoOTm4OT7TsPG1YhV/tsgHwM6jFhrkMEO/fq0t32bDff0ZMEudF7pxg93mV30kCeqP0=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by IA1PR10MB6097.namprd10.prod.outlook.com (2603:10b6:208:3ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 11:23:45 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:23:45 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: preserve mount-supplied device path
Date: Tue, 20 May 2025 19:23:37 +0800
Message-ID: <85256ecce9bfcf8fc7aa0939126a2c58a26d374e.1747740113.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|IA1PR10MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3e0b47-8d49-4725-bdc4-08dd9790c87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGswWCs2RENlZmRSUjhBVWhJUlhWeVkvN0JwUUFhcC94VDVvNE9lakU4aktZ?=
 =?utf-8?B?dzF6K3oxSi9oVXdkVGZiWnFlL0xmVFcvOG9VTllpaUZERnkyYVBLcU5PdEdR?=
 =?utf-8?B?MlBEVHZWN2tyNHMrV0xMcWgwVG5hbHVLdUZjQXNKUjExa2dWcUNmRWdWd3Rt?=
 =?utf-8?B?bUFOZDRENll1aU9tbkdRS05taCtTN3lGSUlLeHl0a2VucmltSFQvc2VsMzZK?=
 =?utf-8?B?TFY0em9pd1NIUUZFVldNQUdtY2NMdmNIU0xJWlMwbllrdXpBRElJUThJYnV2?=
 =?utf-8?B?bHR5VjVid2xEQnlrcmlKSm9uY3Q4L1haMVlKamJoZzRpSGZuQmpWY2kvV1la?=
 =?utf-8?B?blpvQzRlUi9XK3JSL0cxMHNvUU16bkxqQzZpQzh5b1dpYTdIZGF4RnpwR1Vv?=
 =?utf-8?B?bmwwRWFOUjFkV3BncTdlaS94MVV3R3VNWjJSSzVqSXhQbGJSc3VQYkRkSTln?=
 =?utf-8?B?ekdjN051eEoyTk1vamdHeVRCY1dkWnBYYVV6YXBYclRvMkR2OTdSdUw1anpH?=
 =?utf-8?B?VkpzNDVhTFFiclV4cmk1bWdGNEdiOFFQbHRqc3paTzV0YTB5ZFdET1NRbG9v?=
 =?utf-8?B?Nm83Y014UGFuZ2tDNnlteTZxWU8wZXR6YVM5WFdsbnJnWmtVakh5cXRSRnRN?=
 =?utf-8?B?U1R0K3RrQkJyRXp2ako1WGd6M1NyVXY4MlFEeHlUdk9VUjFIYnJWUC8ySHNs?=
 =?utf-8?B?c2V5MTZpRksvMmFDd0drM3lhS080cGVpY2R2eGJpekFVRTRtNHRIY1NnaG5M?=
 =?utf-8?B?ak1nUC81Y1BIWGl1c2VCb1BvVU0zTHlURzQyejROcGxkaG1Od1ZhczYxaXdp?=
 =?utf-8?B?SGkzMjF1TXR0YWxFamNOcjBETEduOFMzWFpDQ3d1ckxGcDFTdFJuN05IeEdz?=
 =?utf-8?B?QlAwNVdtUWdGQ2dTNlpQMnBGeXRlTEh4MWRGQWRSZFFUWHY4N2FBMEU1eWVn?=
 =?utf-8?B?YXJRcWRZYW5NeUloUk5JSi9weEEyaGdxSDNKMmVHS0I1eVdldUxwRm9SOVh0?=
 =?utf-8?B?TVdPQzlUME9wVWFGa0J3Mkg0cjdFc2p4andjdk0rYUczTWhIU1V2Nm1DWEVu?=
 =?utf-8?B?bnIwR3dUaG5PbXpoeUlSS3NIaDN1dkpwVStMVExrNWI0NnhtVHluL1kzVEp1?=
 =?utf-8?B?RUJoY1MvUmtqWmFmbGFGLzFhSmpwdjdlcVUwZFhSNUdUbXZ0SFdsMUQyNjQw?=
 =?utf-8?B?aHhsLzNYMEJua2ZNQmt6TEdpM1hVaWpOdEU3UERmZ2FuS25mSHZ5bWtOWk85?=
 =?utf-8?B?a1ZHczlmRHM0c0ljQzVzTW9oUmM1N3BvQ0hKUEdjKzlHeElzc3FMcnJkOHBZ?=
 =?utf-8?B?UFZVU20rRUtNYm1VMEtqM1VkRE1kY2k1eVQ4YXoxTXJLWlkyR2dkbGFmN0VU?=
 =?utf-8?B?ZFlFelAwdll4UUtQT3BXK1h3Q2NZc2hCVEpFWUF0VGlTREhlNXFGdm16VkNk?=
 =?utf-8?B?SVZSNllaQ0J0bWYrRkJaQjVVd25yUlBocktkOUJLOUZ2QklJQ0h4WFhCRE1w?=
 =?utf-8?B?Q1dPNmVwRUxrRkNzNTVTTnZmL1kyUE9uUVB2eXU2UEl1V0ZyT0tFL054bXJ0?=
 =?utf-8?B?RWw5elpxYjQ4SXJKMTFzRENreUNndlBoMHFLTjBVN011d0txSFJZbWFFUmty?=
 =?utf-8?B?eVcvbVNmMVhHREtyczZEMjk5Vzd3VCswTXVsWU1abUJvQWhTcXJUNk8wQ2VM?=
 =?utf-8?B?UDZ2eUZiZkpueDc1UzF4em44ZFUrSWJ1ckRDeGl5M1JBelZYOEdITElBeGZE?=
 =?utf-8?B?aHFIMkR0RGh4cG5LWEk2SDVYV1NJNVQ1ZHhsREZ0U0prL01MVlNNZGszdkpP?=
 =?utf-8?B?ajJhZFVZYSs1dHF5RG1BMnVCNGIxcU1ldjNaRnI4Wjhxb0d1N3VNWUxWMDVJ?=
 =?utf-8?B?ZXQrZlhSZTdJanIyK3BUM2Z6RnhoKzNTRE9wTENJYXdEbHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkJoVENkYndOVEFOQzhDT05HK05CeHBIUHRxam04dXVPTzQ5bERoT3h4aGpv?=
 =?utf-8?B?VjJtQ2RRa2ZPclFMc3ROQmY1NjYzTVEwOENkY25Gc2lEanZuMlUrM3VpSzBw?=
 =?utf-8?B?NEk1RUVaTmVaeXFDTHhTQ2pTdkNGOFIvbklabVJ2RWMyN0Qyd2swMXhSQU40?=
 =?utf-8?B?dE5EUzZ1aGRjb3htZUI4bjBXLzNjY1owT3BjY21xSDV4SmpRd25yUFVac2NO?=
 =?utf-8?B?L3BiU1VqYjJCN3VhTHFLdWZzL2dIaWFUd2oyRXhTSk9FSmNOU0laSTNGUmo1?=
 =?utf-8?B?bEhUOGMxcFhCcXl1dFF3RzNZWkxoYWUvajFIUFlXQVlhcTROditxR0V4UEsr?=
 =?utf-8?B?eE9kOFNBYXd0SC82SmRqM2NXbVlpOXU5cmc4Sm1NekRFRzhhbzRINnNUellq?=
 =?utf-8?B?UlJVL1dyVXdUVlgzQ2d3MHZGdXNieVZ3ZHdkVytiSXM5eTdlVm5BNm1BWmRH?=
 =?utf-8?B?eGg5RXZ5eXJjMzZBRUtCQkpXQ0V5am5ZanhrbkRibk9FQ0VJK2NBdjY5QU5Q?=
 =?utf-8?B?dmJVa0NmNEFGckVGTjZvckRFNVpFYmxpZUhwRE0yU2dSY2JjYzZEbUFHUFhz?=
 =?utf-8?B?QnllZy93R1BRMWprTXlzUjc2cHN3bm9FOFdJb01wdE1pS1ArYWZrd3JORkhw?=
 =?utf-8?B?VE4ySHZwK29GMlJxTHZVN3J6OUV0QlErSmhzTGE0VXpwZnNiL2EzOGtXdjZK?=
 =?utf-8?B?aC9ZYTNyTnliWVM3bUxiVU9HdGdJTWlHMHRuSVdvajhzc0h3bjhyLzZTd3Za?=
 =?utf-8?B?YVlMWHVQWFFmOTNJWHVRRHBmRWRrT0RvNFFNWmNTeGxzSlUyNU5BeTdITWVl?=
 =?utf-8?B?aXRHdEthaWZxelp3ekx5RTdYRFdSdW1IeUxwa0JycDl5MkhaZXg1dEdQcU9Q?=
 =?utf-8?B?WjNaSnU0YW5MWHRpYjZidUh3SWx5aHhBUnBXc1RxZkNvQXBZUFZoeVRhWmRS?=
 =?utf-8?B?WEVmeGdkQzdTSEx5dDU3dEU4bVRweEZLd2t5UEhqUDNEWWFGNVN2MkUzVUov?=
 =?utf-8?B?QjZFT2g0RDBDUnhMNTFtakpadHIxVTg1QlY2TllGQUtyMnVxQlJyWGRJZkFw?=
 =?utf-8?B?b2FTNC9DRTBTZ25TSXNkeERDc3dDbXNlQ3l0L1NxeTAzdkcwQWVZRkRscGxy?=
 =?utf-8?B?U3lhUHFFY21CQ1ZGTCtlSU04YmZaMXZxMFpsa05LdHRYTzkxNWJZb01hell3?=
 =?utf-8?B?Qld2R2pqTzA5QU8rUk5FeUd2ZmNka3JPa0RBY0pQVlZieEQ4UEFPZHg0MW9G?=
 =?utf-8?B?NXVPMkZsOGh2ZUw3cWxxdldZZ1N5NXkreXJmTERxN0NleWZKZ1M3bGcwQzBl?=
 =?utf-8?B?emVibGY1Q3FraUhHTjBzZU9sU2NnMGt1OTk0OFNkN29OUEJrRHhEcDkvaEh2?=
 =?utf-8?B?TWJrekNRTVZYbnIxRU5FTStYYURnU3NncUpSN2t0OFhsNDdVanA3b1FxTm5w?=
 =?utf-8?B?SDZjNm1hSGhZTHN4dTZ2MmFmbytoOUZPREhrZTQ3V2dWZS8xaXYraUFsYTJD?=
 =?utf-8?B?WkhtNFFkQkQ0OTNQQjlOMG5PMGkrZDhZcVJBK2xtaWJ4bkhTbUZ0MytDaGxZ?=
 =?utf-8?B?SnArQURzRTJXMEd2Y0NHQzN1blB6d1YxVTBiUk1OUTlncXlNNGZyOVJIcld5?=
 =?utf-8?B?TUd6TUxxUUI5TmVtejRYNzN4QUc5UkI2K1pJd2xCNitJbHB5MHNnczBLSFFk?=
 =?utf-8?B?S0FCNTRzUmRGZ0EvOGdrV2FabTZLMlRtSGY4V0dlOC8zK2tJdmtkSzEzcEdP?=
 =?utf-8?B?RUhMNU5TQ3B4bGhYU21STVQrVkpKS2JxVERqbnQ0Z3dFRUY1Vmp3R2IrSVEr?=
 =?utf-8?B?elJjSytyMi8xVHhzQ2EyNi9OTlR5YUdHL2x5S3pGMW90ZG1WMEJkWVIvVE1i?=
 =?utf-8?B?YzFscy9tNUNQWG1HdzRhMit1VDEwVkpCdGRuRk1ha2FZdElGY09lM3JqU0Yv?=
 =?utf-8?B?UlgzM2VMUmJwMkh0NUVVTjNUSnlmUTliZURXcTJSVnN6eXJ6Yitpd3B5SDhz?=
 =?utf-8?B?VUR2N29mYnBvTFRqQSs5MGQzUm4rTm4yd3F3UDJxbWtBZW1QeUJJY2Z0clhG?=
 =?utf-8?B?d1VNY05PL3ZyM1cwZEFTWEI0NVlEV1lIdEZpemFNaE1IOW5yQll0Zk8yU3Zx?=
 =?utf-8?Q?zh70gDl7A/C1yigg+IeMMFsgD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h2Psi3YjMuX+Yt4jYSvo/EROTVpPwcaybVVcKqTce4E34w19PJi7odPl6aOky+b8FZGlXgAMqofmdODJ6NGFiymx9ZkTiqTBRUdcg7h9sJrLiAuqyQXhPZ7u3KweJtbirllS1fIb+A8QN/HZbXaYll5yO6bjVjmpjaOsQqV2Zx5rbIaItsLX8QOpM1ELh7DMDNE1rdRPiCZ+921sGqYjdg1Cf38zC13ANBdPnTC9VYL66FFmWFVueh7aplMtD+WHpp/8XTKAckdEyWdx1iULscwvpYh10IOS2YMO1ZNdRF39A/KxlMmnU9mGoh5MDVY3vq2awXp7rJfy/bA22ltA+9ww+uo6xa7udj4OSzsa6KSeprLKVmViZF9gnkqPw/S+P/97cQwz0aI1MDoOTuaT0zONS7aV4GlB2P6l8ooUhwtL17ZJX1YP8ggVVX+KxVSXJaqiK4nBFtIFkGwgG2zpRLHDoejQ4Ov9xta8f4jzl12UINA7LFaXsmBa2aK3FByAufBoI9eil1Xgsy4cOlS3rwu5aqztdceD15CqY411hZgwucXzAOeXmdUeCGGx4/yKAVNlz5hmEAeceA5+0/Pc3+vfEujMQBMDJYMYVKEZBOU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3e0b47-8d49-4725-bdc4-08dd9790c87c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:23:45.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0BC1XVtFG/KJLMOZiCqzmLgWM6+7D0nmy0S2rRwo07FkAlaxskCsocdcf92o0+2aEf5entegZqSPaq1cpx8BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200093
X-Authority-Analysis: v=2.4 cv=S93ZwJsP c=1 sm=1 tr=0 ts=682c6646 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ffLivEqyPNmdK4QuX3UA:9 a=MeE_bVp1oTjb-lTq:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5MyBTYWx0ZWRfX+InV/jOjXW1y EHt6xBJWslANk/V4Re+wBARbZZ/JfvaXPk8yJZw9ywWtfhWeC9+Mz35YyNDzHjiL3MiyIYQdv4f IKXDEXYiiNdBnmYUJ1thImFaaq7XvZGs1TqyAMF4seJ/6guCdW+x/t4/rVdfg47/VACp3vEtI1U
 2HNwjL9tlbHemHE60Iv4opK3e2ase5jqTC2wzJQg1aT58tOa0y5faFk1j2LDQRe/RlaI4oEDeQU Qx9ChWZ8BVHx28beVwfoRjT2RdH/yEw1LNd0jY2eyYR6o2iSeBcepqKpaSxP58OoS5BDW6iL6Lo ZzLr+EmbTTPeWYD8sVtx95UsbzAwiUqvIHWtAQgd6PVw+ggfLAvbsmNw0kIEzs6Ut8qKk+CNApS
 mcP6KvIDNg6ki+XRcatEAGMk8kKBz5bJ1TBBbmPaW7aib9HGr1y29FLndJ4BuHWKME5uF6Ov
X-Proofpoint-GUID: jM83J3_yROCP-uLkpiLSh1ZNirUt4KJ-
X-Proofpoint-ORIG-GUID: jM83J3_yROCP-uLkpiLSh1ZNirUt4KJ-

Commit 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for the
same device") addresses the bug in its commit log shown below:

  BTRFS info: devid 1 device path /dev/mapper/cr_root changed to /dev/dm-0 scanned by (udev-worker) (14476)
  BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/cr_root scanned by (udev-worker) (14476)
  BTRFS info: devid 1 device path /dev/mapper/cr_root changed to /proc/self/fd/3 scanned by (true) (14475)

Here, the device path keeps changing — from `/dev/mapper/cr_root` to
`/dev/dm-0`, back to `/dev/mapper/cr_root`, and finally to `/proc/self/fd/3`.

While the patch prevents these unnecessary device path changes, it also
blocks the mount thread from passing the correct device path. Normally,
when you pass a DM device to `mount`, it resolves to the mapper path
before being sent to the kernel.

  For example:
    mount --verbose -o device=/dev/dm-1 /dev/dm-0 /mnt/scratch
    mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.

Although the patch in the mailing list (`btrfs-progs: mkfs: use
path_canonicalize for input device`) fixes the specific mkfs trigger,
we still need a kernel-side fix. As BTRFS_IOC_SCAN_DEV is an KAPI
other unknown tools using it may still update the device path. So the
mount-supplied path should be allowed to update the internal path,
when appropriate.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 89835071cfea..37f7e0367977 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -778,7 +778,7 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
  */
 static noinline struct btrfs_device *device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
-			   bool *new_device_added)
+			   bool *new_device_added, bool mounting)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *fs_devices = NULL;
@@ -889,7 +889,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				MAJOR(path_devt), MINOR(path_devt),
 				current->comm, task_pid_nr(current));
 
-	} else if (!device->name || !is_same_device(device, path)) {
+	} else if (!device->name || mounting || !is_same_device(device, path)) {
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
@@ -1482,7 +1482,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto free_disk_super;
 	}
 
-	device = device_list_add(path, disk_super, &new_device_added);
+	device = device_list_add(path, disk_super, &new_device_added,
+				 mount_arg_dev);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
-- 
2.49.0


