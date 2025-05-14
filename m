Return-Path: <linux-btrfs+bounces-13991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B58FAB6172
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 06:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D774F4A2DFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 04:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3FF1C2437;
	Wed, 14 May 2025 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="el5D9vr9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yz6ef13+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12141DF26E;
	Wed, 14 May 2025 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747196403; cv=fail; b=dKvXnpKpRa9ZxylTPmDYjAhRk/KoNcw6jU+Ly74RyfkgxLFGb0lWhMnbdGqvEY37Xi6NJyz8SA0N41V995AIPNd88eAPtf8+GZqIcyW5okTJgm52n1Hs75gs9jV2OEnvOdadRtEv8wAwwHioe4c65OXCW2IVPgIvLxlb2KVDVMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747196403; c=relaxed/simple;
	bh=hSfP7n82HYUfEC+0ozzjxE9pEzsDgkdxPWE9GL8CVnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a791EGhBJLsX6Fs6coist+y4WeVP0nNh1wCR+ewz+MQl6L41FLupUQ774wb/ASI8L9Vi/COFi45/4pn6uDIlJfzm8CT01hMmzgzQsgM7CGI/N14Tp0d9PgNUnIXcbq/QyMuVkPXdC7T9DLLrStEh0+Pi+wXeP7Qr7qQAXemcaII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=el5D9vr9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yz6ef13+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0g0ZW016887;
	Wed, 14 May 2025 04:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9U89iteq6Svkj/qrMscbQ1JrKJ+fJv9fYZmn171F3fk=; b=
	el5D9vr98VVJkCTyQn3FzXYMJ4BolT0HBwB4DVNAssI+RYyvGd5Im4pjR/eC7CRB
	apsO52MwLQLl5j48WXzj3YcmVf5TVekyPntQQ89wLwWPDl3TB4CTXxgf3j0mybio
	RL25C1NzIhFIHVMvP7by93SZqVewSsGe8ES8ITRH9U1xGxLqLQBLHITVpaWnCMYP
	jFxKKMW+hr9ynEwO38A2T9PgspPg+lma0uwmXqGzGB0fNT2B2gGL/LUBYrZpTIFR
	KKB7hfhvm/v2Ux9fRnOTzkIj4Bq+ePJssB4VCB4l0ww/ZyyRmZhyiBVasUP5b80/
	4ZlLt/WHralOW8QJrhXS5Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchgq76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 04:19:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E2U0Tg017104;
	Wed, 14 May 2025 04:19:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc5f5j5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 04:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpBwZwfc2Y5mWbwZz9w2zLqRUXp8Tq4SAb4gOIcTnM4S8GWqypsXT/BDDErIsthZcvm5CjetaRxLyDjhCyhUuw/9vnXcTHrFnCTR9/aIspAZNMLbOUL6y9PFqOpbThjTd+jaC0i7BDu+/NmFzzfJOIN1c5COKmNfaJrVFkoh/FBnR0rNMl4oNrlSGWCZWoZI8RmvioAmLPkInuYIZAQ2C2TUBx0nDN3eZQqM34ZWT4LX1swh4YWTtX8DXWe+px7qgmbe0Cemsp/JT4aw7+M2xuNvrvHzj6ogFhwz02K9VpIBBZ5pxE0l9tMXN0Rixw853i5g0I3Nel8/TJ/6nXEhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U89iteq6Svkj/qrMscbQ1JrKJ+fJv9fYZmn171F3fk=;
 b=wJhrODqb9QJUWhnVNlUf4zbbuWshPEnSXh+WWBOoDw2NwlXj11S05hp+1a2UQPT96pm63vgnmLRQai5mk23hOYU13MEoqw6dQl4EEM4YdYFsDVFrkxdgo3OW+64dg2ZJkWrBHRIX3h1AOYcZ3b5x27G3JkBK1GPpJILK/4H/0rxM1xOWjdKzIYwmpVPLa7FNjC21J3X0HHfgL9vydj1/w/FPO4ai3Z5VR2ng8NuQVppvq4Q36zVFthDu6POjbpSpZPH4wfweJrWEcILFNTRRlqeG9i2KY5+AerDJmlZuS2DiXAgF3epXRKCc2tQ51YM1yGbvrao2yz/DlkP5S4P+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U89iteq6Svkj/qrMscbQ1JrKJ+fJv9fYZmn171F3fk=;
 b=yz6ef13+ohg9zmhvSpUab73Qk1Gj/RWn53/Utlb+7FyAMvlTH//ukinAaeGccMM/bPOZuWlk5V3MjvTN4wR7W5dl8eiTgNenzcGUuJqV2Vozz7ffT2NDFGMtkwl1+2ZKcwSXsl4OxVtUbwhl1NqOIR3+Y+QhInoDb5z938j0eZA=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CH4PR10MB8051.namprd10.prod.outlook.com (2603:10b6:610:242::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 04:19:49 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 04:19:49 +0000
Message-ID: <843f86bc-90ee-42b5-80d0-b9800ac9fd9c@oracle.com>
Date: Wed, 14 May 2025 12:19:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/336: misc extra fixes for the testcase
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <9c9683df7928397142cb345ac5bbef2456972bf7.1747185899.git.anand.jain@oracle.com>
 <6c89137d-a835-447a-90db-da7b5e78263b@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6c89137d-a835-447a-90db-da7b5e78263b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CH4PR10MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ac2de9-46d4-4440-9ad5-08dd929e9115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDZ3UXRiemF1K2Q2eEU1UXhkVHVNSXd2Tmx4QmlDbkFKSXJvTGNkNUh2UDVm?=
 =?utf-8?B?Y3BhYWhXNE9qOVU3MHpVODRJY0xFUENZbFk2RzAzOTFTa2FHQ0tWRlVucm9x?=
 =?utf-8?B?Z0l6Q2p1UlZjTXo0d3BYN2EydXlMZGVUcEpOalAvZWR1YmhkRzRKNzVwMnpC?=
 =?utf-8?B?ZWpHYldEZytqc0xnU2xGdjgvYkN2c3RyVm1pSkdwZVBuUU1EZ1NZbzR2K1JR?=
 =?utf-8?B?RVdEeE5KTUQ2WisvSll2RXY3Y3ZsbDVaMDdrZXpWUTRZYWdTU3A3LzFYc1Js?=
 =?utf-8?B?YnpzSkRpVEM4Y3pVWFhOUDV1VS90ekRHWlUyUFVHUUlDYnpWNmFvc1VuSUhP?=
 =?utf-8?B?dVRRbEVhZVk0RVQ3ajEyeWR3eXkwL0hCRjJZczhlVHlQbW4reGtVTUVpT2Q2?=
 =?utf-8?B?T3lFeHBDKy9BZGdLT0VJU1Q4N2RqQWtnM2MrRTlnZUJVY3NpbTBtU1h3YzJF?=
 =?utf-8?B?MDdDbldISTBpUUN5a2JPL1h5K3RVY3NNbHJYM2dheEFRVWc2MHlDL0NtTUIv?=
 =?utf-8?B?UXdTdXEwTEFhY0N2c1E1WUh2c2FDU3MzaGlkK2RnenArRDVQZ2tBSnFFYnAv?=
 =?utf-8?B?VHdiTTlXU2pnUCtkVDBnbEFYZ0gxNHlDY3J2Njk5RTVEM3M4S3ZabmttQzdi?=
 =?utf-8?B?SU5rL2pkVVFkNDRZK2VubVhzaTRsSjBTUE5Ca0JtSktlaitMKzNGWko4OVJT?=
 =?utf-8?B?SlpoUVVhZGNueGFqclB3R2Q4WkpPYmZ2Q0Jyc0pEd2xPaWxLZ1VGUjdTcDQr?=
 =?utf-8?B?bzlaOWdFQkcrRFBsZTZ6dTlpNGxxWFdwU25HWE5YVmZYUDNNVGhnTDF3ekp3?=
 =?utf-8?B?YUJnNnEydWpkUGIvZlppWUhPeFI4a0h5S1kwWnAzb0JUbnFoV1JvMm5SR1pS?=
 =?utf-8?B?b3RVZnlmeFozSWZhWDlDVi9uTFN6dmNYc3dKcUlDSTl0MHRqdWJuTTlzcWhP?=
 =?utf-8?B?U3F4SUxrT25mcVExQ2UwQXJSVTNyd1JRd2lORFNKekNtSW5UTlBXblcwQVpN?=
 =?utf-8?B?Z2tLR0k3SjFZenlkd28zKzFhUGNiYjJCK3dkQjVpVGtDbHdleitEVWwrR242?=
 =?utf-8?B?elZoQWZnZHNaVEk3ejlTamJObXNMRjMwcC82Y1RwcnpQdFVzcTlrRnF3c3lR?=
 =?utf-8?B?cU9tYVhiZkoxSzlGZndqUDJ0YW9VQ2pUWU0yVkQ5N3VVdkhJOUw4MENVL3k2?=
 =?utf-8?B?UVAydGZycUdtdGpRRmhaZjNpblVGNXNIMXFlTGZ2eTRkSVZjajZWYTNBelda?=
 =?utf-8?B?aHpKeEViZVk3d1VVZ3FpSnh6UVlnT2JDdWxpb2s1c08ySGFKS2hWdFJTSlRB?=
 =?utf-8?B?RXhLTlBVMTVPeElIVTFySTRmTm9RTCtPNlZKSFp2aUpnYWxGOUZ3TjYyZkdM?=
 =?utf-8?B?Q3hvZzlHZVJ2VVpvcEtuSi9zZnpFdmpYcHFJUTNxSGtOWXpRNkhLSnZyQjBo?=
 =?utf-8?B?VWhhUmN0anBRSWRiOWxLQjhSSUQ4OGcrMzJGVmJaMmlueStZcjZqSEl1R0o2?=
 =?utf-8?B?ZkFyMjJJL054L2NUdCtmNjlTem1FM3ltc1JYc2tDdENKMW9XaXQ4ZjRYWmFK?=
 =?utf-8?B?UU92RUNuQ0JPY0ZYTkVRQ2lLcXFjejFLbTNLcUt5WmdvZUI2QkJMandweWdH?=
 =?utf-8?B?b3BKTGM0SDg5ZE03QUZZM01JU1dQTjlvVFJJTkM4T3pJQVpuRXlWZEFlSnhE?=
 =?utf-8?B?N0ZldjVNMFN5engzNXJQV3hSRnFjdWlIZFQ1UzlWOTBkN0l2c3B5bGtWMHc4?=
 =?utf-8?B?MFRkMkhKWCt0WjlaaUhpaW8rdmtrUWZIV2VvUVlkZ1VQVm0zbWlhYnZtN1FH?=
 =?utf-8?B?OENEOG5xN0d0UktLeFc2SUVqYWJxb24zdG5MYTVWQUgxc3lmRGFZQzM4Sms1?=
 =?utf-8?B?SWtGSTJFckoxU3daTkJYNE9WTCszYWFUZHdkampjSmVDUFIxd2c3N2x3U2lL?=
 =?utf-8?Q?/hbXIienGto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWlESFdlVjd1VG52aERHWGJ5WW1uZTJqbTBKTHdWVjA1L3pjMTZ6M3I3YjFG?=
 =?utf-8?B?WFppbWNKeVFtMXNsZ2Nnc2hrZHRQUnJhVzNUaUkrc0FiVnJ6WjhaS0hRRzZj?=
 =?utf-8?B?ejlIcU5reGwwNURaSWJjV3JGcXRlYXF4Y2hqOFRWSDlIcklrOFVUaDRJZGpH?=
 =?utf-8?B?eHNLdnpYUkl3M1V6bkt6c1NaaEdHdDRoWW9sNmt0SHhFTnVwcUUxOHRpK3pn?=
 =?utf-8?B?cmtNYVRqK2VCU05TNjNvZk9GM0llQU5obHRQRU1PQURPRUs4aVQ0aDZEMGlu?=
 =?utf-8?B?NFBQMUFsbGRpZ3VGZVc4L2k4cHo1OXpYNXg2WXB0MllIZ1U1SVRTS2l1NFpW?=
 =?utf-8?B?eTY4Um9kakp4Tkd0LzlnQk1McitLN2FkVDMzb2xlYWNSMlgrUTFGOENXNFVa?=
 =?utf-8?B?WXVlei9tbUVweWxwWHhGYXNXUUhVVVg4V2VzaDloY2FNcWJoZHVBaXVtbVpZ?=
 =?utf-8?B?QXdjOVhQcXZZYU1MVFYvTmdDdE9jY3dqN2psMTdKZ2xnWGVhdkU4ZlJzeU9Z?=
 =?utf-8?B?Znl1K0daYkxsNmdKVUQwWkdEUk5aZEh1N3RuVUd5aGhjWUphYWQwVmNUM3Nh?=
 =?utf-8?B?dkZYYWhZVW1RVldaeXlBWE9yZENmanlsYWxId2pQTk5yUTVadVF5akdDRWVv?=
 =?utf-8?B?Kzdjb3Y0eVQvaTh1VXlwN0d3LytzQXRUdWdGcUViQ0dsVWxPNlJpeWRIRExQ?=
 =?utf-8?B?T3hsemtxcDZTa2dRaS9idEhLNVluSzNiSVRZR05xMWpMbzZ5VXd5UUU0V1Vr?=
 =?utf-8?B?YzI2NGhOOVFRVUxmYlkrTWIwbzh6SVhxNlZaMXZYZzFqY0V2RVU3U3RoMzUx?=
 =?utf-8?B?OHpiUHN0SHVTejNDeUtwQmZsMWtzL25TcFFlMjVPWmFLOWxBUUZ5M2FaUGdT?=
 =?utf-8?B?L3FJWmJncU42L3RyWWlWWVlRTlVJNDFZd2N6V0R3RkVzVGNobCtScktKU2JJ?=
 =?utf-8?B?aSttbmY5enZNVVpaSmUyYVdFNkZYaHlqWDlOdEtpTlUwV0FSWVErR3FHWkd0?=
 =?utf-8?B?OEJ6cUR6SllPcmlVb2h6RWU0YnVqRTlBcUFYUW4wT2Qwa2oxaWxPRGV3ZURP?=
 =?utf-8?B?aTBCT29rVWpLSWRkdDNWM29kamk1TG5ZU1R0UlNSUkZ2V1lsc3BEY01WYll2?=
 =?utf-8?B?L0Q0NkhEbytWeTdmZ2hkaC9XaHp6UXhPNVgxU0YyeUFDUExxeThVeVlwRHhz?=
 =?utf-8?B?aGpvU1M0eWlRNHc0aW1hUjFQRW4yTHZ2NXBKU3FBalNlY29rRkNOV2VXNEVW?=
 =?utf-8?B?RnkvOUJVY29kSlpYNkFUcFhwNWtBYVpKNmVJQlBDVmJqZnVTZnVZUnhQSDBO?=
 =?utf-8?B?RTA2dFp6WFV6WkpNTENVTXlQZ09abzVTbEh2WUFTOCtaSmswK1Jjb2MzSGFB?=
 =?utf-8?B?RHpZNzYrQ2FiQzFqNk9qdjdCcGs4YlFSL3NMcnp5dE4vWUVpYVFDV1Vvbkp3?=
 =?utf-8?B?K2lSeUdmZ2hqWFlMaGNlREw3QzFsOWxMak9naUcrUklxYlliSDJ2aWpmNXEr?=
 =?utf-8?B?ZW4xSVY1d3ZDbWlIMm9aSEh4M3RYYmJLb25DTEpFZ2IrU01nRngzRUtPRmgx?=
 =?utf-8?B?bXl4Qkp6S2dhM0psZmxFd0JvakhYL2UvaVdMU0lTMzZmYW5zakRXZW9WeHFy?=
 =?utf-8?B?ejJBUlc4RkNiTU53MlI2YjJhWFhZenQ4aVJCM3JHZHdNcC9BT2pVaThmS2Y4?=
 =?utf-8?B?TGRVamw3M081RUZJeTRKc2dsQkVsQ3JHQzlJY1lvVGdBRnVQNkpNU1dFZmZh?=
 =?utf-8?B?N09YNDNtWG9hZWRGTUs1ZVVpcjMwZjRmekkxY1dWSTBKWFZaRFVHTUFzY0cx?=
 =?utf-8?B?MjdseUR0akdhL0dhL0k4dHdETXd3MXF1b0FGMDNQdlRNSW42TFg0ZWhRMG9n?=
 =?utf-8?B?M3RDN1N2aGFRU3F5WXo2elpSUnpwbTF3RG94SEdoaG8zSVJRaVJ1OUZ6RkJE?=
 =?utf-8?B?eUJaQi8venc1RjNnRGRlclFtaUdmUUNvK1dtYXB1RW1DUDl6YW5oZnJiSWxC?=
 =?utf-8?B?SEpUN05hZk1SWjhqa085NFFWM1NvaFJrbjNtZTNDSHNRZzNBdjJqMGl1S2dl?=
 =?utf-8?B?VVJ6R0huRFlnQmZ0aDJrMmtaQkpmMW9MT1RvM0RjME9PRXRlK2I1NlpYUDRX?=
 =?utf-8?B?dWIxUE5WSG1YQ3lreHVYZzNkcCtaRnVBNEJXdmVHbTFKamNaL3FoeVAzczBG?=
 =?utf-8?B?VG9iL2xHZ2hlcXdYV3I1aHZjY0t6Z29jWjUxdE5saHl4dVBWOVJ2Qk1mRjV2?=
 =?utf-8?B?U0owYUdDN0tuZ2lqREJUN3FiYnVBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I7AsDey1x5i+zc7N2/loy9eHG8N3J/btnda6rtOaxzJ4xk+pm/qSkylP5oZI3ziwTJUYEvUu1qwJrlPnsr3rnJn7OQXYql/BY7sLvXGlfZDfASW12X7CcQFBLjfiqVFo0Ov0CO9KSOIdPweCxH6a0jAt0Up7fm0uFX8UPXLBzuOZ6fgtJ0GmHx/IcaS2khP8RSROeDevSVtLR0RC8rlMTbGOVhsCHe4YqknySgnMnAtdLfKWVnIXN5/FmKI1SsVq3fVYK0wmbTfjdvrnyrPgsxpQNpKZnBdhAPaLzSuuiW65qU0waWzXBR/tfGO1mBayjFjv9ABhil3V2ZNuZ+nm4rLUiqpj3/s6OciYW7V3V0+GW1DDUhJxyTVvucaxe7ykR6u7kXl4SmjXFOk/SReQG/PXMfYZLvajaBzGfLIrQFWmsT74D7r8YmUR6fZqvdL3zcNGQsJepXw08iXrStGsqnkbjHb63YqhXL4vaNJEDasr2TgWVnFrz/NhAiKH0hw/9sPXl8Z2+9pxs4HVHlviivP9+0+NQvekAokQ7nds0ALxaiSfykt1886wFzy/TJ32CqiTeK21NkW5bj40oEXE7NRspsc+sHWMeWR3p2xdq38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ac2de9-46d4-4440-9ad5-08dd929e9115
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 04:19:49.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrEZ32ae5RyV0/bur0e/nxVHzJJEn5XUuViNH082RTI8t+xpzzF/EGVq3GLHjMAXIZNFnww4oLSZfLGtLfBWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140035
X-Proofpoint-GUID: XgbZJ2tQTShudRDr6H0uTvrbMt-8D1yG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzNCBTYWx0ZWRfX6Aj8qmj3Xybn VZNqzjnSh0QS+vcfl18QFqOI9H7hFIdm270HAFLyilIXtnEyDEboprz5OR1YEGLcK2C65V3bCvf DmUV8i9Vhf/yX9fADEfFCCBvKfyz1F+iLfL/+Duq2nXSOIWhj0sKe13aYEgeXVb/mWgZtX+PyKv
 fYUVRuH68imorGUwiiaYrUB0GUzmDX4mYnMDge6q2unSQL9ZZKRQNZsWaJkKjr08DOWjBDfuhTJ Za1tbRORHYy9lpxe6Pw2slEDEXIHXkSPm2jAvXAeKEOOWUv4PYXbO9X18Phw8IE6sPVb1aPEF2H F5Ug6JuKB8V3/c0Qoth5fzLZ7GutHrSZGfMI8aucpvrJ5TiRBidFU/TydX5ve3iceGGoAy1Fh8F
 o8pLR3HjGSbaLfjHe6W38cecrnGFkQtw5eya243hrWgTTP3znFvAWBZJS/pRQlsbccE/JONL
X-Proofpoint-ORIG-GUID: XgbZJ2tQTShudRDr6H0uTvrbMt-8D1yG
X-Authority-Analysis: v=2.4 cv=Da8XqutW c=1 sm=1 tr=0 ts=682419ee cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=eJz7NE_-jMGB_6At4uwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10



On 14/5/25 09:47, Qu Wenruo wrote:
> 
> 
> 在 2025/5/14 11:05, Anand Jain 写道:
>>    Along with adding group dangerous..
>>    Fix the fixed_by_kernel_commit with the correct commit.
>>    Use the golden output to check for the expected error.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> Qu, This change is big for the last minute merge time fixes for the
>> testcase with rbs. Pls review.
>>
>>   tests/btrfs/336     | 25 +++++++++++++------------
>>   tests/btrfs/336.out |  3 ++-
>>   2 files changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/tests/btrfs/336 b/tests/btrfs/336
>> index f6691bae6bbc..503ff03b377a 100755
>> --- a/tests/btrfs/336
>> +++ b/tests/btrfs/336
>> @@ -8,10 +8,12 @@
>>   # rescue=idatacsums mount option
>>   #
>>   . ./common/preamble
>> -_begin_fstest auto scrub quick
>> +_begin_fstest auto scrub quick dangerous
>> -_fixed_by_kernel_commit 6aecd91a5c5b \
>> -    "btrfs: avoid NULL pointer dereference if no valid extent tree"
>> +. ./common/filter
>> +
>> +_fixed_by_kernel_commit f95d186255b3 \
>> +    "btrfs: avoid NULL pointer dereference if no valid csum tree"
> 
> My bad, wrong commit. I'm totally fine with the fix on the group and fix 
> commit.
> 
>>   _require_scratch
>>   _scratch_mkfs >> $seqres.full
>> @@ -19,16 +21,15 @@ _scratch_mkfs >> $seqres.full
>>   _try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 2>&1 ||
>>       _notrun "rescue=ignoredatacsums mount option not supported"
>> -# For unpatched kernel this will cause NULL pointer dereference and 
>> crash the kernel.
>> -$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
>> -# For patched kernel scrub will be gracefully rejected.
>> -if [ $? -eq 0 ]; then
>> -    echo "read-only scrub should fail but didn't"
>> -fi
>> -
>> -_scratch_unmount
>> +filter_scrub_error()
>> +{
>> +    grep -E "ERROR|Status" | _filter_scratch
>> +}
> 
> Again I prefer not to catch exact error.
> 
> The output message has changed in btrfs-progs commit e578b59bf612 
> ("btrfs-progs: convert strerror to implicit %m").
> 

> And there is no guarantee it will not change again, nor the kernel may 
> change the error number/behavior, I just prefer not to play the filter 
> game on something non-critical.

IMO, we have some flexibility with error messages printed to stdout.
However, to maintain the kABI (Kernel Application Binary Interface)
across kernel releases, it's must that when a test case expects a
command to fail due to an ioctl(), we verify the returned error number,
not the error text.

For consistency within fstests, we should stick to this approach unless
it affects backward compatibility. I've dropped the new filter below.
Does it look reasonable?

-------
diff --git a/tests/btrfs/336 b/tests/btrfs/336
index 503ff03b377a..b418ca885e34 100755
--- a/tests/btrfs/336
+++ b/tests/btrfs/336
@@ -21,15 +21,10 @@ _scratch_mkfs >> $seqres.full
  _try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 2>&1 ||
         _notrun "rescue=ignoredatacsums mount option not supported"

-filter_scrub_error()
-{
-       grep -E "ERROR|Status" | _filter_scratch
-}
-
  # For a patched kernel, scrub will be gracefully rejected. However, for
  # an unpatched kernel, this will cause a NULL pointer dereference and
  # crash the kernel.
-$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT 2>&1 | filter_scrub_error
+$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT > /dev/null | _filter_scratch

  # success, all done
  status=0
diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
index 63b53ef43650..982b0adbc3e8 100644
--- a/tests/btrfs/336.out
+++ b/tests/btrfs/336.out
@@ -1,3 +1,2 @@
  QA output created by 336
  ERROR: scrubbing SCRATCH_MNT failed for device id 1: ret=-1, errno=117 
(Structure needs
cleaning)
-Status:           aborted
-------


Thanks, Anand


> To me the current make-sure-it-fails behavior is already good enough, 
> and more future proof.



> Thanks,
> Qu
> 
>> -echo "Silence is golden"
>> +# For a patched kernel, scrub will be gracefully rejected. However, for
>> +# an unpatched kernel, this will cause a NULL pointer dereference and
>> +# crash the kernel.
>> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT 2>&1 | filter_scrub_error
>>   # success, all done
>>   status=0
>> diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
>> index 9263628ee7e8..63b53ef43650 100644
>> --- a/tests/btrfs/336.out
>> +++ b/tests/btrfs/336.out
>> @@ -1,2 +1,3 @@
>>   QA output created by 336
>> -Silence is golden
>> +ERROR: scrubbing SCRATCH_MNT failed for device id 1: ret=-1, 
>> errno=117 (Structure needs cleaning)
>> +Status:           aborted


