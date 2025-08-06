Return-Path: <linux-btrfs+bounces-15887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A690DB1C033
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 08:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427743A2C41
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA01FF7C8;
	Wed,  6 Aug 2025 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qvYj173U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eZDus6GT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D4273FE
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460108; cv=fail; b=NGZKpnQiGqtqWUqf06+2xDhTd8Exx97v5W6HLs+5L4xd8Z1IIg39RRt0YPu61eTVWTITWGthjzNuSJpcAoNN2CD/LEiRvHhzpO2+nqz/YNPEs7XHfy7bLI1sWu6kqhTeAnpA9uOXlESNkqCWKdMxmWiUsbi1+s3mbM1B3Kiocq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460108; c=relaxed/simple;
	bh=ZQoUXkAPju3cgXE5pG4nxCUmPSp8fpEo31Ud4OSFuEY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UVxbwOqRM1wtJfY6r9o/tHHqM68GnwuHosFaKsbKBwnM6RTseThByM+00aVZeZd1CoZq1Nh7Pw5OPlzFpG2o0F4nIDH+eR3D7ZEtWD5c/NHrPZ2lG6wZZKz4JxU1kZJcy8WjkYMtGwWZvlnCTWDrDAT4ifKR80jE70V2x9xJaSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qvYj173U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eZDus6GT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761vVY9014014;
	Wed, 6 Aug 2025 06:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5a7ZDsOzFYjDYqVhKonIvbxo+s2NaTqhntNyazpo4uA=; b=
	qvYj173UvG4l89ZnQN/goD6i6TJzzzE5sb8o5wrrh5dwbK+jx97ZryC12XNCkfRU
	Kyac1GD7WXZ6QvqM56+4lvbRx+rFN4cslxHMT6ZaFLSaHTgtqeFDke87FSPzSRLR
	+dZyar6QycTzLw7VyJqyglw6L8Z3DxWyPZdv16xAo3nv3AVepVThsgPiYv3XWVsB
	V2BaGQBVgAxTlFHycNYP8mmRNUcx0HTuhhM4JAzGBmYrFxe/0TaOP8S95AWPA1K2
	nRlMzWpuq9bdzHhph1j8hoqF80Qdo263cQjKSM41MPlHT9zKx397pK99Tfm63l/v
	Wz9UkeVju/UhAu0Aev4QAA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy0ty0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 06:01:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5764DkZ5028233;
	Wed, 6 Aug 2025 06:01:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwktk5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 06:01:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0QN/i6GAv8kbgYXPohbVu3fue3RRXwFFA/dt1msFHD0DYviBFSdsl+BZOtHwSLB2V7LOEZ9dOPgV1TMVYC2w2iNV6wdGnek5RJ5qIWPqI4Op/KQJ0M5Qj1apnd2I0aP1YBiXdRjgzCKp6WnFQ9d1vdKRtb4fU18rFkFJKFJjpbfe2ybserMonsKZGyB53Qe+Vk7JdNfSn2enHxraUdyWOq1oBfULxlbB76kt6II7e2v5yuKj0ekVfnfgxjHtbf/3DCCQ6fbz1aumPYBPAPujt17sHMDpVao/iLZoaOPNyDZiGh8OmDKI1Gb3gmIMg7q6DVVShASXj/m3+Vojp8OmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a7ZDsOzFYjDYqVhKonIvbxo+s2NaTqhntNyazpo4uA=;
 b=RygIuM7b3VSa7wKIciDktL+f51/hklSPftmV+J16OuCSN3X175hWDdq3dbqS2sue8Zh3v/eb6K2nu+I9UHEPmkjbhLcMhriBe6od1ETTYUudOKkyhVcN61DrTrKpWtZ+Y9PTuXR/4C7VWhNM382d28vF153V1j+q3znaCPgtRYPgIWVsAv56N8JaRXF+LDf63QJxbh+lIcP/pNktijCPHL7umqM5hI4m6V/iFDPdhLNh9zlzvI2HHk2HhN7PDoOUi70Eua7UWxZee5maEAIf8eRTLbMFM+Fgou2HGhEiaqbyMgLpW5/Q2t9+5BWRSsx71HAyU2CwqDI+iSp4SMJorQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a7ZDsOzFYjDYqVhKonIvbxo+s2NaTqhntNyazpo4uA=;
 b=eZDus6GTXsOn5nriNl8yG6ZmLXE+wiWpWZ1BO4iW4ps39R9M54wZ84R5j8YcLbfEYsusLTp5C82jUUUKKnymIkRMMpYBOHWC1mI/+2El/cw0g8NTGXVIDj3cHUjMCPDp8tdLyHojizqSFjuVtyuLzbq+Xsn++fcsiCUKyTnfEeM=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 06:01:39 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 06:01:39 +0000
Message-ID: <6baaa8ad-5cbf-43b2-b7cd-c04572c9952d@oracle.com>
Date: Wed, 6 Aug 2025 14:01:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: check discard_max_bytes in
 discard_supported()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
 <4222f30c-8bd5-42a9-ab0a-f8c39d402256@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4222f30c-8bd5-42a9-ab0a-f8c39d402256@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To IA1PR10MB6075.namprd10.prod.outlook.com
 (2603:10b6:208:3ad::18)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|BN0PR10MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ea91fc-54e2-4184-0407-08ddd4aeb4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXBNdkdVWnVOZU9qU2xGTkkyZjd5OUk4UlpLZHdPc2tCaEZmUmx1emh0Y0tQ?=
 =?utf-8?B?SE1xYmxuODN2UWFFalZBUEZ4T0lBVzhlbkdFK2YvQ1d3bmhCVnljRUtySytv?=
 =?utf-8?B?bnFNZ2FNOWFIK3dKeCtHMTdwakxmdWtUWUsyNXJxckl1c00vV0xRYWJXQ3Yw?=
 =?utf-8?B?eVZ2YVRqSnYzQ0JYMnUwS2VSWVh0WlVpVXh3NkR3Zk8wVjNab0xVMzU1QlZO?=
 =?utf-8?B?YUZXYWxONjh6akFPS3UzUitwVG5nVzBBQTBCVTZCRnVrMW5heFFaN1pJbCtQ?=
 =?utf-8?B?ZG0xSjkvaWtnR09XbWVUbVowVTZqSWxMcndkSnlmN0lFaHBPMUVNS2w4NlI0?=
 =?utf-8?B?aUhzYzlsSC9PdFQ1VU4rdXc1ZEhpSnRNRnZ2b2RqRVdhdHV6N0JHb0xXTkhz?=
 =?utf-8?B?ODhJQzdQU0QrVmwvNUZLUmRMTW1nVmhpSlFIZ3hpWDdubXhBd3g1S3d6ZjNY?=
 =?utf-8?B?Z3ZaRVJjOXdUZ1RZQS9taVgyaUxmVkZ2ZDVUVldmN2ljQ2pwWXhvNUErcWRB?=
 =?utf-8?B?K09nUUl2ZGJmaG5FNUdtMHVjaDZxZlBob3hnZ1hOOGhkU2Fkb3VtdmF3R2RI?=
 =?utf-8?B?TXNBVkNJRWdtVUpzeVpsNXZuaXRydUx5cGxPSVpLV2ljWUlaM3pnTXBrYlNn?=
 =?utf-8?B?T0c2ZVo2bnNiYWtTb2l0Q015UWJPcDd6anF6YitRaXVLaE5PZEQ5a2crYVoy?=
 =?utf-8?B?VEtCZ3JHV3NRWWRudVNzWjNZbnluYVR0dFN1MHZhV3RBMWNvT05EMUo2NGNn?=
 =?utf-8?B?aXZrYlduanNpbVZzd0o0cGxHZ0t2RE43RmlRL0UvbkNTeThJdndOdmRmbnVz?=
 =?utf-8?B?R3I2eWxkTUhXSkVqTW9DLzBJTW90TVJTbXUyZnNqeWprSWlma3JVMXpyNlVW?=
 =?utf-8?B?d050NU94UVFSVGxFNkZSOTJYd2hkRzFrd3RMUnpNOHZtMjR2OEZMTWlWb2Ru?=
 =?utf-8?B?R3dyMksxZ09EbytSOFBuSFpWWUdjZ0pLcnBVeGJmYWU3WWhiRWZzQ29UK1ph?=
 =?utf-8?B?eG1rdFdtbll3VFpibU45ZEIyWU1NM1FNeXlSMERPZmRublJRSHdTdU05VWR0?=
 =?utf-8?B?YVMvTkZuaXJZSnF4c0hxUHFqMVNWYUNJa2hXemJ3Mk9DSHh2NTJrTEJnMFpS?=
 =?utf-8?B?N1FPbk8vQlpFV0l4YWcyNEFPZEIvRjBqTU9pY0dpckNHb29BQ3E3eHd6UkV6?=
 =?utf-8?B?SjZrMEdrZVljdVljWWt0WU4vallMbHFKZHdvcGJYYzl4S3pQTTJ6Sm0rWDBi?=
 =?utf-8?B?UTRINmFUdE5mZlRST3RVTUk0ZlR0VXY3TmRIYmZRVDFtQktOZFVVRy9oa0pZ?=
 =?utf-8?B?SFNsdHNmbVhFSzBNSWtrNTVLb3FwVnN1b0RxNTVhNlVqMXF2anE0aWlJQncy?=
 =?utf-8?B?THFOY1BuZkZMZEZ1dEpvSEdYMHh1YjhwcFFLdkhXcmptSVhwd00wYmw0MSt0?=
 =?utf-8?B?QStFOCs4aGQrNmlLNVFmUG04ekhwc1dlb0h6TWhJM1N5NFZmbHlOclBwd0pL?=
 =?utf-8?B?cDMvYXM4UndRcG9aR25LRTVkSk5nZ1B1WU1XVnVsN2pMeFByeU9RSXpwSmlU?=
 =?utf-8?B?c3oxOE5SZk1GenVVd2dWR0FTT21mOG5pSEVLV3Y4NXVSQklqTldTU1FPbTNi?=
 =?utf-8?B?RXZHaEt3MWx1Wk1Ceks4OVpQdVZlVUV2b2xkUUNpS1RXckMvSXNuTlRucWdo?=
 =?utf-8?B?OHJHS0xHTUZ6bHNYVVNjY3hUdldGTlQ0Tkl2dlc2c1V5Z1hXTXRuK3JBMFRi?=
 =?utf-8?B?dVpXenBCTXkvRGJIMWwwWnR5YmhRRC9MQ0J0WE5CWkhvU3JKdi84MWV5YTRK?=
 =?utf-8?B?ODBpWlY1QnZINUJ5SE5GYXlnbFhaV0VpSnVHNkdLNThuR3hZTWRCVUdlZlA4?=
 =?utf-8?B?ZFhOQnhtRHZyemQxRnN6Z1dQbU91NlBJUTVqcGl4Qjhid0NrbzdqRjN2bTZO?=
 =?utf-8?Q?wkeEFdCfmaw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzhTOVBRZm9Oa2UveTNTVmZRWG9sUENtOWt3YTEraGNzQllJcTREUG5raTJ1?=
 =?utf-8?B?aVNNczNIWHdkR3JkUDdPemY2NWpBb1M4ZGFMaEFQZjdndHBNa1Q2eU1RTHh6?=
 =?utf-8?B?M0ROTFltWWE1a05DZDFZaVRWV2Q1MnA2VU5odkd4czNmOS8zOCtDQTJjR2d2?=
 =?utf-8?B?bnd1eWs1cG53UWtIaFRKSTAyZ2l5cS93ZXBFeGZjM3FzenE1NTk0V3ZXYy9B?=
 =?utf-8?B?VG5TOGorbWdvY3NVbUtkVmwybTMzUEdpd0xuOFl6b1Q4YThybUNMMjZHbTN0?=
 =?utf-8?B?dVBadFVHRy9DNzM4Tlo2ekVKTlYrV0syenhsaVpaRm5Tbm9DZCtaaTlFNlg3?=
 =?utf-8?B?U0xSditUZFRZb3FzaXFPUG9qTDZNNzNhcjVibGhTaHJJak5ZUFJJczhUUHJN?=
 =?utf-8?B?WHpicW5nazFPYjB3ak5wTEFxd1JwdXF6M0pqZUxsb0hMS21BRU1iZmk2N2t4?=
 =?utf-8?B?dFlsampPOUlub09haFJZbExBbzdCaFJmdDNpemJmd0tNNTVnbldaNEV6amhl?=
 =?utf-8?B?VzdLZ1E1WHBtMlhEV3ZXTWduVmxiNzZUUnlFdXJLK0wvZDFxQWJIME9mUm9l?=
 =?utf-8?B?STAvckVWbFN3TzByQ3ZUY0ZJUEpNWnJBL04rdzk3Q3FKT295SnpVcW9OYXh0?=
 =?utf-8?B?cnpFc2RDRTdXWCtPeUFmWW5jU2tabFVncldiSHBibFhBWmVXT2dMQmJFeStG?=
 =?utf-8?B?ZXZkck8xdjE3N3NlbFZlU3c5c1RQWkZoVkdNdUZXR2RXOUhzL2dYd0JObFJQ?=
 =?utf-8?B?RTVQUllrM0ltOWtpa0RMa3IzaVdwaVY0Z1ZhL2ZSZThGOVZ2Sm5RclNtZDFs?=
 =?utf-8?B?WnRjcWFFTUE4STJwTG1IRWhkVGZQMWpoMmVqNnFBOTFxQkNsS20zVjZobHY2?=
 =?utf-8?B?OU5BVnJmeHhueS9rNGpLTUYxb3R4c0ZDU09MNUI5ZkFYRUFxQnliOUsyRzNK?=
 =?utf-8?B?QnJveFhRcmY2SWVIZ3pLMFFqbjQ5ZldGa016Nm1nRW9YWDdNYkJTSVdBdVZE?=
 =?utf-8?B?bjVURkxOSERhM29hOWg1RlYranorb3pvaFc4Nk1CNkhxU09yWmRVeXU0d1U2?=
 =?utf-8?B?bFFNVEQ0M3loNmZBWmFBcWhWcjBYL2x6V1g1MUNHMVFpWG5HY0E0VzkxYkR0?=
 =?utf-8?B?UHpTeWFubUdyNk1lWDBMWFlzSWVJS3c3L3d6WktJSFFjNTI4a0pVR0VmbHFC?=
 =?utf-8?B?aVQvWFpVN1Vjbk1QTlM1U2ZVWTk5OXBPWlNMSXhwaHFiL3hnMDFTaWVkZDdD?=
 =?utf-8?B?T2xCQ2VQOVdQV3RDVEdvK0c0NTU1b21kTFJTaXhqeDdrVmZwTHJLWlptcHRC?=
 =?utf-8?B?cnNtNUh5NVo5SFFsdnMwR1ZHTHI2QXB2MzVqRWVQd0JoNndNVUhSK2R4WTR0?=
 =?utf-8?B?cWtSVEFlYkJxWFB3TXk4cWwrcjV1Wk9zcTY3bXdsazZOcXlpOERyM3pnZkdr?=
 =?utf-8?B?cExlWVI2L2xUaUw1YU9ZZ1JCWHRHcEt1UHNUMFJFUk1TdmhQRzcvZ3Z0WjBy?=
 =?utf-8?B?T0R6MEtsNVM2WXFrQ0huOE1ZS0xpcGhWaVdNYXNPQzdnUTl4bElucHdvMVAy?=
 =?utf-8?B?Nzh2S1FxT0Naa1JIRTlmRmF0UFJWTHhFbmtDTlc2UGZIbXdlWlY3Ny9DSjY3?=
 =?utf-8?B?aDFvQWlEakJuZkxtUWVoS1RkcFM3dEtaSUY0WFNXSkVDOURyY2RCcG1sOFBq?=
 =?utf-8?B?OHpsMkRZY2w1bENtM2FpRWdMVW81WmhwcHlyYi9QNm8xaDQyZnc1T1Z4S2VU?=
 =?utf-8?B?SlBISGYvOUM2a3FjN3NEUGJhT0RDNisvckdIYURkRUpCUnIwM25Kb2pvR2g1?=
 =?utf-8?B?VzVYZHZwUVBvblI5RnoyY1lDUFRZdXAvMnNNVnd0cXFkV2RzNjlEYUU1YWxV?=
 =?utf-8?B?SXV5SXRRNDRTN0JIUkIyRzhNelVONWpJRGNzRGRIaUNyejk3ZnFqODNka1lV?=
 =?utf-8?B?NGFHajRUS0ZobllWckJNN2I4N0ZBUkdJUVFZZ0ZiRFpLMjFWekpxdUF2cHFC?=
 =?utf-8?B?Mm9WSmozQ0wyYzl1ZUIwekg2dHFWSWFMV0FKVWVBQUxXLzdXOE1CTFg1TnhK?=
 =?utf-8?B?V1ppa0VqR3dHaGQwOE5IdEd1ZnluY3hJaHMrbDZLbU9aQXFEM2M1YUgxYXJI?=
 =?utf-8?B?UkMxSGVPcEcxdFlMQS9FdGFnTnZ5YXAxamJtZnRzbDBFNHVXeEJSdVZlajdD?=
 =?utf-8?B?WkdRd21kTGFmUHBuSTNHNUptYnhZTEhiTVJQZlhhMnJsc2tZRnUvVlY5MTFl?=
 =?utf-8?B?eDBoL2p5UFVvaThNN21McjR4WGVBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	npA+HNedyZ1FQgx/YLrWBUCkLUxvJuBBTfZuqqD9ndl58WysTdta/rSfMy4joTk+FrrpIsbGZR32MpTKLAzxg29JHlnArpKdFjiBaFu5GK/yZXWSbjSBPyTBH1apM4AYTjggsDZlNADUocBv9yprrjnnVl/vRV4hhCy8wUSz9VBljoG9vkQMDmSnLdoYJDYfhxiBK2PrpXoAjlsDCb9BVpOAj5NlshKDNKuJTiFL/jbkv2CdzxpMYm11UxFg5pGWX8N3Dw8XXIK9YGHXmCJCSGq2sTNHkMpFcJzyxJl37JyfAsEiK7hM/p2/BW78zFFMNvf7IW8Leuj7VqTUiYYcIcpZWvK6tzDraYVKD5y/jt8dGFgvKz8YHjOLedMhh0CuID32MCjsgO9yTS6MXeNxhK57XPGt4fA3efw9Zpi56wEMjEV2P3dvnDqMZ4Jvn0iPgsvfliYrz9TKNftl+q/c2mdJu4NYoScm/tQgn4Z205qnbZHP3N0JncaoEHxICpLgwqNz8n+9BMpHp30sN+0X0F/qhDk4jBc1n+1HZrBvDSSHc3TPSrStzLJOY4ZMdyKZewvVK/dOYSBIZViDvslZfVPSThFQPsufu6YhxXf47W8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ea91fc-54e2-4184-0407-08ddd4aeb4d6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6075.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 06:01:39.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8r5RQj6qX8d45P7qquzgP0KzD41fLapRLzPn9T02BBZR1dmmzDwXjsNhg45DSU/KcSX1UNiVlSsxr8IzOi2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060034
X-Proofpoint-GUID: kkDQJSTXqOrcuqM33GLF0ow00yVyLCeZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAzNiBTYWx0ZWRfX+78cwFV5PxM9
 OFTAddB+B+sS3RcOmf1Rj3IMdnFyRau+Cmr1tUq1Gunh0e/WDCe50qN5Ks7flNDSfoKHG3CYHZ7
 A9vjpFVx87858qNx1JH8ktAejkf+2Ryo44V8Dup/23wyDzSIi7mSqajAIpUZdZ5uuefwt9F1fQU
 RbKUO8xyA08QSnpWtK5w/uU98ufWbxWx3WAX1QlchCjnGLPRhX4ozFzyM+K6a8NKsuTqE4zCHnC
 iDUvm6hcvd16ZBsLgHlWUhx2/nJ15AfPX2ppqsUte71/70AbgAMRaOZTLFbk6ChoAiKL4KPZzwp
 +Mst27t+hhzMI2ZN68Z1D8WarlAa2kMi36Jko/55+Xby2z414YAmxaCcLj6NtNkWnyPmixefq9i
 Nt9KBeSr9oZZ1nV0zpXpODqE3+2ZtJVffutTovDcGtTY0Lu3+ZDFLRKivF8E5V0pyQPzsGUT
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=6892efc7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Y35qIeiWKdUmLuhZWVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kkDQJSTXqOrcuqM33GLF0ow00yVyLCeZ



On 6/8/25 13:06, Qu Wenruo wrote:
> 
> 
> 在 2025/8/6 02:44, Anand Jain 写道:
>> Some devices may advertise discard support but have discard_max_bytes=0,
>> effectively disabling it. Add a check to read discard_max_bytes and
>> treat zero as no discard support.
>>
>> Example:
>> $ cat /sys/block/sda/queue/discard_granularity
>> 512
>>
>> $ ./mkfs.btrfs -vvv -f /dev/sda
>> ...
>> Performing full device TRIM /dev/sda (3.00GiB) ...
>> discard_range ret -1 errno Operation not supported
> 
> Where does the error come from?
> 
> In device_discard_blocks() it just calls discard_range() in steps, nor 
> discard_range() itself would output error message.
> 

Its from the my own added debug message at

         if (ioctl(fd, BLKDISCARD, &range) < 0)

>> ...
>>
>> Fix is to also check discard_max_bytes for a non-zero value.
>>
>> $ cat /sys/block/sda/queue/discard_max_bytes
>> 0
>>
>> Helps avoid false positives in discard capability detection.
> 
> Since there is no error message and the error code is either ignored (in 
> btrfs_prepare_device()) or properly handled (in btrfs_reset_zones).
> 
> So I didn't see how the false positives are even possible.
> 

discard_granularity suggests discard is supported, but it's actually not
discard_max_bytes is zero. So the discard_granularity check gives a
false positive.
----
$ cat /sys/block/sda/queue/discard_granularity
512

$ cat /sys/block/sda/queue/discard_max_bytes
0
----

If the line is confusing, I’ll remove it.

Thanks, Anand

> Thanks,
> Qu
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v1: https://lore.kernel.org/linux- 
>> btrfs/2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com/
>>
>> v2: Checks for discard_max_bytes().
>>
>>   common/device-utils.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/common/device-utils.c b/common/device-utils.c
>> index 783d79555446..d110292fe718 100644
>> --- a/common/device-utils.c
>> +++ b/common/device-utils.c
>> @@ -76,6 +76,17 @@ static int discard_supported(const char *device)
>>           }
>>       }
>> +    ret = device_get_queue_param(device, "discard_max_bytes", buf, 
>> sizeof(buf));
>> +    if (ret == 0) {
>> +        pr_verbose(3, "cannot read discard_max_bytes for %s\n", device);
>> +        return 0;
>> +    } else {
>> +        if (atoi(buf) == 0) {
>> +            pr_verbose(3, "%s: discard_max_bytes %s", device, buf);
>> +            return 0;
>> +        }
>> +    }
>> +
>>       return 1;
>>   }
> 


