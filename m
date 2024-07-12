Return-Path: <linux-btrfs+bounces-6421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0703292FE50
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF893284139
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEA16FF37;
	Fri, 12 Jul 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oLj+89Lh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ECkPenvU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143C16F8F5;
	Fri, 12 Jul 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800999; cv=fail; b=XWqe5N5Rgo3Mzps8QV4T0pqDfgy/FCtLZfijlTKHD+QUdsZ2xrnRDV9tJXZRCdAEUC8/NeaADtJLoE5kK8bWMDTogzNtCaJ9GX13PpLjC6cn80fUxi5MenCAWXpCORIyyBWkFu4iFM9xqmOjgNEKj783vMrNdsLCSZXIkm66L7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800999; c=relaxed/simple;
	bh=yh3UKqfDw1qBXyuLxOopPYIeuAxlOE8LHymovgA9f/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b9dzod0Na+vLIIcvtf1pFtby9Xew2KSR+rtaQkVH7zt/RWzTTHsqCqsgEhn96K9n27tJi0kE1MmIjBpBZlLULVzPp6pRABgEZVDTGdEux3nHBZ7FvlQrejWiIpzwLQLVmZMJ2i0x/ZnDviwEJieYg6JBY3NU3m0FYF0FpNZAUtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oLj+89Lh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ECkPenvU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIc8L028154;
	Fri, 12 Jul 2024 16:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=EeQ+QEZZiNanJ64fL3iDc6JSdR8YKbHPDHbzKfHK0J4=; b=
	oLj+89LhmsSankk7P4gECRv8OAA4UDY9VW9Q7HFWCBvdoDvR2JE8mCMCAKKZeyro
	TnzhkTUhv6unv/0ld5QrYaIHihIXMwC299iG5wVCO7Ngo6qqy+CckCY+GiYFSUhl
	l7u7yyYGeUj5gVkdIFEqgJs6r2KqagY89dB+uQwHuT+f7hzll9b6Oy1ttYii6A2F
	Y/tJV4s98+uuDJnpsYUWcb6FSZn/SfPc/qn+z94ichN1ncuFAjJV96oYiD7kMZJm
	UmJVLlMpUf2dZD3WjYHPiLOAu9BMJ+3sHrsxMqF2VwZGywzuXUqD/PeFMySu2ysp
	1VEXpxctAvK87oYe7UxZDg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkycdv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:16:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CFSdQ3008705;
	Fri, 12 Jul 2024 16:16:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv65d80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJeGU9x1bXtZk6giR9q6mppOk0lbGTbYmPZX2B2wbaKF1qJwRCdtYCYn0PWYBHhdqqFiiuWBv+MqJrI8vSTw42EL40e6KuGVGIkMnfrYx1+PhFSB9WAMAcIJ0BN7stt6UwkHtUj2Mtj/Ggh1vmCFls0BGJellMW9UgfRCFjenr0O3sYbJX+c6qf4Th+heD7LgYYSu4JrPEiDQhG4x4TDsVJ4JuMQcggTmp0ZtNtyVqKmQ+7+DwxcHkpHG2Jnwswitd4VgiV8dZE8fCpMJ3HBJZZMNycwYR8CO7GZ8HSZnmpgzNkqSii1+l1khc9+u3B8f87377ZEE2eN0bdjhtdZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeQ+QEZZiNanJ64fL3iDc6JSdR8YKbHPDHbzKfHK0J4=;
 b=h7YibMz/+yxl9gejqD4TxFcvhrPQq9nsHu1R7lJceyXu0xtnMZSG+TxpoyUsEVPb3hs3BaZzQ0/dIj2m2S5dsFVGexewUSKQs7un92LqZIJxNE/ALQNH5dboMCyj2hkbP3MURFaO3BcSEYxowTU0POoQK7u1VsouvqhARz6KTFlK7rxOhcuXE7cuwwlfbAFYxHjTluwpdo0HLL13FFmiyl4TtRwjgHhqj6w6LTTQA3LFI/fKMVMjVyeCx6K3dkMD7MoXdieVWyuUB5hu08B+KifeY097tDpFQT+UlfkLdEW+ab2U1dxPfJHuNwm+Zxhskp3Lg81WNfa8LLoVhA4UyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeQ+QEZZiNanJ64fL3iDc6JSdR8YKbHPDHbzKfHK0J4=;
 b=ECkPenvU8C02Za17SaytQpLok2cnsi+4ObhR5+NZJ+rIUZWeJTj5a9oOsmPYlo/+9zVOEQUBdEPSNyspGCM+/r7pmhFdcMEsyg9zmnFasH4SiuC6Znx+IjTLKDrvgXyB+S7RK8MA2yCUix5lZFQk1Bkzksm9ogoZuZLV2Ed4qlk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 16:16:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 16:16:18 +0000
Message-ID: <a3bedcc7-c8e6-4e83-816a-ba28fb883202@oracle.com>
Date: Sat, 13 Jul 2024 00:16:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: update golden output of RST test cases
Content-Language: en-GB
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240701080109.20673-1-jth@kernel.org>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240701080109.20673-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: e00bb96b-9219-4a75-b16c-08dca28df630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S1JVR3pyOW5OVDNOYlRKN1BkSTVoWGk2MDBGOEJMdjVkNW9CVjh4ZzRvQStm?=
 =?utf-8?B?TVJ1eHBVVDVLalpwSTRzV0x4ZFlpQ3lvWG40aDVXNnhWMTdKV2hsUlUrYTVa?=
 =?utf-8?B?d2FrZGEvT2RPMmpUS2VQRjVYaXVuUGZ1Z1BxSU1TNWZNU3UvT2FrV2xQaS9T?=
 =?utf-8?B?Szl6VjNiQ05kU3dwSDE1SDVWZjdJQ3RINmpFK0pTaHR4dEs3WGFNRlhhWVZj?=
 =?utf-8?B?ejlPSHRNdm5abkJpVnl6VXlpQmZsWGdkUW5acElGYWMrZDJTeURkSVlXL2wr?=
 =?utf-8?B?NDJVVTR6Qkx0dTRPVmZxNm9SejlPaC81QlVqSElhWW1Ga0duT0I1TjkrTkt4?=
 =?utf-8?B?V2w3aG5nZzNMRElrR24xWEJZMWk1TTdwK3RTVVZXTGttNUdCeFNzcE1sSjJO?=
 =?utf-8?B?cWJsS2tBK2tlNVU2cTBBMHBsMTllaU5SYUtnUGRYNE1VdXFHU0J5dEdvbUl1?=
 =?utf-8?B?YTdpQktRT1Q3bXhvM0JHYjFRTzEwTXVmdmFJdGt4bGN6WUdvUnRacHZNb0VL?=
 =?utf-8?B?Zjg0Y1FDMHE4LzlHb0pIUUVNMDdPOVJQTXhiU29wQmdEV3FCeVcyeFd6MFlx?=
 =?utf-8?B?YXpMb2lVM3lFbUFHbVltTi8zb3pzc0dyZDVLMHNWajlQamVSUEVHU0pCd1B1?=
 =?utf-8?B?cFJtTEdDRHB6TmJ4T1dTUlNoaXpLalNOSVZZUWRQbDcraTV3clp1ZlR4dmVF?=
 =?utf-8?B?bEtUQ0xOWWZvVXgvUU1acElDUUpwbFV6WER0SzI4OUt3RjdHZ0grMlhlelV2?=
 =?utf-8?B?UVhZbGVxcUwrN1RiYlhrUjE3bTR6VUJWR1c3M1o1RTFtQVgwRFpBUGpzRDRo?=
 =?utf-8?B?blUxZmdiUCtmcnN2T2RYY1FCanRXKzdsVkN1ZThITFVtM1pVWWxiZE5ueXpP?=
 =?utf-8?B?R1d4TzRtR3FFa0d4RjhOQlMyWjlBRnF5WVU2S3BkelpSNHo1UWlOc0lzbE5O?=
 =?utf-8?B?aEQ2Q3A0Sk9rMHJENlNFb2dsQmwxWlBkakFIWTVYREp6dmdUTEo5UjFVaHJq?=
 =?utf-8?B?c0hxb3RDamZCTkxPN293Ri9QMHhWUWVpZHppenlHanIzS2QvUjdzTkp2SVNQ?=
 =?utf-8?B?UEQrZU0wdCttQ2ROWkpnSDNSQ0hMWkxIY0wzUTcvOVd5MERMemN6bjh3RWhO?=
 =?utf-8?B?QlhSUzR2azNKUFE3QXN4YnFXcldYUzJPSW8wazVwT3oxT25TQ0Era01oSGJo?=
 =?utf-8?B?ODVRVGsyQkpCR3lpZng5NlhadzdCc2NiQTNzTzE0cFNETVo0OTIwbDhPNVk4?=
 =?utf-8?B?dzBHbk5oZGF3cFlFK3UvNEZ0S3B1cUxCZWhWT2hOV3IydDlQNjBzbFRrbC90?=
 =?utf-8?B?MFA2d0lGcGQyUDhSNTdpdDBLcy9ZT3dQQlRHQ3B6b3pLSm5PdWtGb2VFR0VG?=
 =?utf-8?B?cndSLzRBNCtTa0l5V1J2Y0s3bU9RdHdTQms3em9HcXViYkk1VWVTeUFJSnln?=
 =?utf-8?B?M0xxRlUyVjRDbEtlZm9Genp2VGNqYlVhRWwvenlIdUYwVTBDdFBMVmZUNG83?=
 =?utf-8?B?Y0tVdTg1RHpsTDdrVWtoaXREa1l1YjlsTzE4eDJpQ0FWZElBWGZPNE8zNHBw?=
 =?utf-8?B?OWc5S2N6VStNUW92cXpIZ0JubkN2ZXRMR1RTZXRtWXRORDV5QXgva1lHL21J?=
 =?utf-8?B?WGJmZWlwUEZwTlhCRGl1TGdyb2w3dUJiNzd1SkFBc2ZhcmRaN3VIeHByWHpv?=
 =?utf-8?B?VE42Z2VIVTJvR3dQV0NEYk5lZlo5WU9GNE1ZclFlcy92KzE1cDBDOUVPeFN6?=
 =?utf-8?B?TVAybFdzM1UveGNDamtMeUJIZEM5RUdJM2I5WlkwUTVyQXBuNzdyNlRRLzNF?=
 =?utf-8?B?bHh3djBGRHpxUzhwNnFHZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVJBWkNTcWlESEJFMkwzdUpLTmd5VExKaVBpWWtxbVJZcjZOSVFqbnB5TXM0?=
 =?utf-8?B?clg5WDRwTk5yaXp0QVA4My9FcEpiNXhRUDlBRm4wNlJ6ZllQQ01mb21mYnN3?=
 =?utf-8?B?eWUrUWdLOFJlaHFCZGMwQWZrc2FxVC9YNmdmM21ySHQ2Q0FnOXFiT0VLYnk1?=
 =?utf-8?B?NUVuVmRzNjRuT1ZDWDJ1STRzV1FzS3diL01HUW9uT3R2OGRubDZjUC81L1BV?=
 =?utf-8?B?bTVBYzBjTDllQzJIdnJSNFdOQVpFcWExT00xZ0RXbFdXRmFaeDJCS2lPd1Uv?=
 =?utf-8?B?YVpDU0lYV1JzZExOZ0xIYlp5ck1aODJSUDZLcE1tYUNKbHl0WHBoYWc1c0hM?=
 =?utf-8?B?S255eHl0b1ZybWFIeHpBQWlObnVVQ1IrdGdlVEdiaFRJVllhM0tlZkNUUWVC?=
 =?utf-8?B?SVd0T2EzUzJkNWVOKzNjSnNLZ215QitDTFpOM2hIMVRCZ200TnZEWlp4VmFD?=
 =?utf-8?B?RU11UGttUWxWSlNhVzF0SXN5OXBpRFpGbzBCbUZhejVpejJsamRweWsvdUll?=
 =?utf-8?B?Tm9UZ3c5bG5HOFZha3dmeFJDVlBvWXFjQkNqYUdYWVJhYVdxMnM1RkVVTzJo?=
 =?utf-8?B?QjU5QmFNbjk4M1ROUXZHZ1p3VFZNQlkwSkZIN1JZcDl2QWFsaitNOW9uWVl0?=
 =?utf-8?B?TjVzaEwwZkExaFM1dC9tN3cxRDdieThDM0lMYndRdm1QNUxEOWFuS2FjVmhU?=
 =?utf-8?B?S25OSkl4bFJzL1YrMGdUbFZ5MWdEd0R3TFRhYjFFdjZhbTV2eGo5a2NTSTNj?=
 =?utf-8?B?a2V1OEx5ZnlBUndkOEV5Nk42THJRb2FMM2RLR1h5NVZ1TUtqUlJkMUNDVUFB?=
 =?utf-8?B?L3lJOHRYSUNIZHJVT1BmZzRaU2NlbW1ZSTE5VVFHRC9jTGxnd1RVNlI0TGFW?=
 =?utf-8?B?RWpBcXMyYm8vcGwzQWJKYk90Z1ZIclQ3S1c4d2sxNFJGMG1zNmFBc2Uza3JO?=
 =?utf-8?B?ZkZDd3hpaFp4a1VBbW1vZjduSGN4SU5Qc2tSUjh0Mk4wRGdPVnNVYUMxT2tp?=
 =?utf-8?B?WllWREo5OE1aZk5zWFJNZE1ySzdhc3VmQlkyMlhaL1h5YkYxNFhhU2dZb0d5?=
 =?utf-8?B?SHEvOUpDcVcwWmhqSlZ1YUFvTTUxYThLVUxTenRoYVBpbVU2N2FCTTVGYTEy?=
 =?utf-8?B?SmJFWm16c3VldzIwZEpkQkZFeUhtUWZnQTJuMmc3N3VnYkhaRDRhcXVtbFBp?=
 =?utf-8?B?bVRhS2ttdmtJdjkzSDRBYUFyU0ZWV0Nnc2huRXB3VitSWXRHdVAyWVdqNUFW?=
 =?utf-8?B?Wk1hNFhySXg4UHhSWGllUGZ3UjVLMFg2YU9tZlRCR1ZaMGJ4ZktRZG1nakgw?=
 =?utf-8?B?cEp4R3EwVzNwckp6bTdhRms3c25GdlJDcDg2SjlXZGVNcitLUFNhczg2YW0w?=
 =?utf-8?B?bjVrcEl5YmdpdndzUFF2QkpJWWxkYzFYMHJHZjlTdWVvalZaVTExWlpMZERF?=
 =?utf-8?B?c1RjL2VycjQyU0tFaG83UWN1Y2d2MXZpK2JuUm9NRnRlMFNFcWEzcFcwTVBC?=
 =?utf-8?B?RGJ3dHdEdmg5eVZFZ2IxOVdYVWs2Y05XY0NyeU80blFpRjVCSGpaYWtvbVJm?=
 =?utf-8?B?aHNGcjhTVTVjb21MZWZuejlKME1SZkd6UVJ2Qkk0L0tML1M1b1JKNTVLbHRu?=
 =?utf-8?B?SGd0UTIvVHRJSDZQVEFvcGR5dEFCcVVhclNJZXdTYUJROThzOFRzSXFHU2dH?=
 =?utf-8?B?YWJFdWNNUXhZN1VEQmZsV3FmL2g1UUlGcm85aTJ4SVluMmxKM1FxaWNndEp2?=
 =?utf-8?B?M1MxaVo2OXF3Q045T3pyd2lDUFgrcW5Cc2tBY3IvMUpzUWFTUVJIaFN5Q1J0?=
 =?utf-8?B?dFpnSk1XT0xuaTdoOGxjSEJDZ3dQN3hDWVNrb1FINkp0S2N6czcxUkFnZTkx?=
 =?utf-8?B?MGxGL0FYQ0Zic3ovSWFvSXV2ZmlSbUVFY2hRQXp0elh4S3pvb2FEeHZ6aW93?=
 =?utf-8?B?OXRGRjhOaE1ON01FMEJPemhlZGg4MzJvaVJXMml4bzRhSXVHQTg5TTRhYXJS?=
 =?utf-8?B?Ym1QTHZjbFNScDBSVWVsd1g1Vk1DeXBwcVh4N0VsK0hpVFFRNDdwQnV2dDY1?=
 =?utf-8?B?aUE4RzUrczR5UDYrQWRxWk1PV1hWbkYwUHZ5ZVFVclBHNml1Ny9FOFBEeFBM?=
 =?utf-8?Q?2B6uqxhEaXqW+UCqdJQvLFTaU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9V6e9pfd0q+E/bnQ9MkOcFOpusurevtVMfqg32AUuBuDr96VQwaA8DCCjVIZc8GwaCmZTbHaH1lGKTHLJd39tVo2eCC84zv2z0fKIX9JVdly23GP4kOP2jvSG08R8C1+qqbtdDFbll6eDCg6gqhxGfakcdhbNsb2tG0IHkJ9jN/O0wUzgkRmcrnIExW4q/i4mYWY0V/uEp7cPaxRMB8oxU/fCCgrVTDBuq6MCDbmUYdgYbRtB5i5PLBO8yHDOj+JYIdNdI3hD7vZxyeNRaaMpMvNvuZLfagthFqw3pVCkAoh65YQMrOF3Bp4lHrqor1oF1Xbudxk8Ck/UIN3TqXkoXKez3VL+IcUtfGRD42JHG6HkiFM9htY7+876Vm/5D3nBYFDGKjnrockrMN6yknvpjP+16Kb0t1wJd7KZ8pcUZw60JXjh6ywo8BSXj5caJP5htoa1my7BG3FIV7Ibgd4mmkZlQjq1Smo7Q5UT2WhEBaolwJCvHoHMZGqFK4muKEqHtJ0SMrXrpbW/cIfWsAvDezKd9kmtYe7MQHkjP66D6EdfXMppsnJIyOXJBtfGmWhnBX1PFd2W8yNAWTNSwaRK34zhwmx6NyYJd6h58NDxMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00bb96b-9219-4a75-b16c-08dca28df630
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 16:16:18.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6p4Fc6GX/0dN5w69H5MydKpRaqMdYSIwZsnKQC0LMVeuBcqQ9COb3DvBWVXcrNnQKpk1mDuYz7Ie5EszYN/hbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120111
X-Proofpoint-ORIG-GUID: eHfikF15mJCnOIS9qxLrRERsCk5RG0xC
X-Proofpoint-GUID: eHfikF15mJCnOIS9qxLrRERsCk5RG0xC

On 01/07/2024 16:01, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Starting with kernel patch "btrfs: remove raid-stripe-tree
> encoding field from stripe_extent" and btrfs-progs commit
> 7c549b5f7cc0 ("btrfs-progs: remove raid stripe encoding"), the on-disk
> format of the raid stripe tree got changed.
> 
> As the feature is still experimental and not to be used in production, it
> is OK to do a on-disk format change.
> 
> Update the golden output of the RAID stripe tree test cases after the
> on-disk format and print format changes.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 
> Changes to v1:
> - Mention the kernel and btrfs-progs changes mandating this change.
> 
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Applied.

Thanks, Anand


>   tests/btrfs/304.out |  9 +++------
>   tests/btrfs/305.out | 24 ++++++++----------------
>   tests/btrfs/306.out | 18 ++++++------------
>   tests/btrfs/307.out | 15 +++++----------
>   tests/btrfs/308.out | 39 +++++++++++++--------------------------
>   5 files changed, 35 insertions(+), 70 deletions(-)
> 
> diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
> index 39f56f32274d..97ec27455b01 100644
> --- a/tests/btrfs/304.out
> +++ b/tests/btrfs/304.out
> @@ -12,8 +12,7 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -30,8 +29,7 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -49,8 +47,7 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
> index 7090626c3036..02642c904b1e 100644
> --- a/tests/btrfs/305.out
> +++ b/tests/btrfs/305.out
> @@ -14,14 +14,11 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>   			stripe 0 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -40,12 +37,10 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -65,16 +60,13 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 3 physical XXXXXXXXX
>   			stripe 1 devid 4 physical XXXXXXXXX
>   total bytes XXXXXXXX
> diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
> index 25065674c77b..954567db7623 100644
> --- a/tests/btrfs/306.out
> +++ b/tests/btrfs/306.out
> @@ -14,11 +14,9 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>   			stripe 0 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -37,12 +35,10 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -62,12 +58,10 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 3 physical XXXXXXXXX
>   			stripe 1 devid 4 physical XXXXXXXXX
>   total bytes XXXXXXXX
> diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
> index 2815d17d7f03..e2f1d3d84a68 100644
> --- a/tests/btrfs/307.out
> +++ b/tests/btrfs/307.out
> @@ -12,11 +12,9 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>   			stripe 0 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -33,8 +31,7 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -52,12 +49,10 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 3 physical XXXXXXXXX
>   			stripe 1 devid 4 physical XXXXXXXXX
>   total bytes XXXXXXXX
> diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
> index 23b31dd32959..75e010d54252 100644
> --- a/tests/btrfs/308.out
> +++ b/tests/btrfs/308.out
> @@ -16,20 +16,15 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>   			stripe 0 devid 2 physical XXXXXXXXX
> -	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -50,16 +45,13 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -81,24 +73,19 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 3 physical XXXXXXXXX
>   			stripe 1 devid 4 physical XXXXXXXXX
> -	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX


