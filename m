Return-Path: <linux-btrfs+bounces-13984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED28AB6014
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 02:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881E2466ACB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 00:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F54A1E;
	Wed, 14 May 2025 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GkApaJBH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ONyndKvp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220D15AF6;
	Wed, 14 May 2025 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747181569; cv=fail; b=Sfxrw+jLQQjvKX7ONlkQ6fR0O+JtmcEcmOxJ0bSX94IFyKmTk6qbYRUu6qxm/qMPX+rzYZYCuctPRh2yxsO+QO7i7T3dZMb1hjJfZKBs/9JGHZIXZxo9mPGF2THfbkTy4Fva8qAfxcNdXwktmDN5v/J5ko6ukjwzJRNGmosALY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747181569; c=relaxed/simple;
	bh=BDZ5PLUomSnUzvvT+GxyWWWxaf6IDr3KUGSHzpyemlg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ay0BnOHER33s0a88xQcYN9zyhfTklVvWyaVzhxqdHQRy4LoqJkIS8PO+8AAfjxAUwBZuCAaR2B5BKFPtDRxvovEh0xmDnSEFMHTe9JcmFQM97JFmlxWFBrbql/Ed55AU4FfDqzGRRS0obEao9cpwoFuir+B92pQhNCib45t4tt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GkApaJBH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ONyndKvp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DL0nFI010322;
	Wed, 14 May 2025 00:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/WSK2WFojDIAtn0fTNrmgf8JosHKHWGmwUrNYWCro8A=; b=
	GkApaJBHgAGym0lg3t+iEhHgdLx7Ab4XJIErMsrVmJXwhXmEIkThhxvs3/sy+7JC
	zAZdZWVYcbh8UGQKNmLh5Td+t0xovE006r0UgA1rCXqB4OZe7H7rup4DLTfA82fC
	o06JX1znMNEZUY9I+zph+zQvLqNQ/qXN8e3EqbNtT5bGsnfqd9V9S7xHVE7BEyun
	6VWCk2xomHpLY26iPTc5YnE8MGXw3D5zJPIjqytFy4wcJ6gFPUb+7zNV3oMMpp+M
	Ak1dsl2EPYAsbRnKY38o1wacX18r6c7+2vzZi9DdIXRR0ntsVZgAzjGORaDq1KcZ
	vOGOF6YQyPgevXyh/49bNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchrfds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 00:12:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNi8J6016275;
	Wed, 14 May 2025 00:12:44 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011030.outbound.protection.outlook.com [40.93.12.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc32rphj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 00:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZAuT5Rb3c72aQQqBclKC0OMqoOBK91aDs+akIXSPj0UoHAzyiaGqCZFeP8dCQQF6zHMNgBJEFEyVj9JOVweVh4edZcZcH8sTvp4/4ovuGRPhwv+DR3EFZ14FhnGY+lY6LpFS9w2ChXRt64bMWX9tcaVVhKnMdxO0xoF1YiR83GEqoLO3ITuKOWtCrheXfQf2NoUsyx3N21MI74wp2gnKARXI0ngIlnFRHbdyH5vsmMrkf36DvIUNFaQqvic+XbtuUPY+wf7CKEvvdvmd/IhG0H07HILqfcpVeE7Ep7qqXYuMyhpHQN5ujTqfF8qVZy836d6JhfmWUfNjR+OGqNIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WSK2WFojDIAtn0fTNrmgf8JosHKHWGmwUrNYWCro8A=;
 b=RzOCu/v+uMSnnk8KhSkNSYj5k9sUKaMSka1ESSFBaS+jSExbbIGMBMU1oMPkt5Rfy/fLB+A/OByGuHQnl6CsJ9X61LYxYJPyu1WCmQ5n40ClX0oqSFK5Yg/IjH/tOWPeiDFu0Kg3dEL+HJAlGb8AHqaj/F0OeduC4chtObmc46wi4u/oNGrpIo074mN+XQkWslcp4ecxuQCrR7faY0EtKJWwrFLlxdHH1f94vVQCECNYbrl+R5DHDyhW4n2TaB0OgwvQXfE3qZ+pTZbxB7MBGd1Mn2lGpVQuwKhwbqQmjl6Yd+eFnwdedlISgJNlyopXmRCVtyA2CG3IGynoY7fN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WSK2WFojDIAtn0fTNrmgf8JosHKHWGmwUrNYWCro8A=;
 b=ONyndKvpSAnhq8Zq3YB1yQ7kFbxhIRzDmanCKj29sC8IcDmjhZLfluH71LF/nlgWpWBLIQuHMEPHKlT0oHcps2ATlomx51YDnsd9giVEHkzbnqAc/27ro1voLgioZGq7fkx8ClpGvZ4S0IaAzP+pf6zU11IKIlIQ4YHv5bjKPO0=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by IA0PR10MB7349.namprd10.prod.outlook.com (2603:10b6:208:40d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Wed, 14 May
 2025 00:12:42 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 00:12:42 +0000
Message-ID: <40d60d4d-d4c0-4938-917a-66c8f7ac4e35@oracle.com>
Date: Wed, 14 May 2025 08:12:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs/020: use device pool to avoid busy
 TEST_DEV
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250513230301.69503-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250513230301.69503-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|IA0PR10MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: ff63f2ec-cc6a-46c5-dbd4-08dd927c0b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFF2ZUJHWTQrcnlaRlltZ0ZIdDFSZ2VpcGQ2TU03eXo5WmIvZGFtZVFmTk1q?=
 =?utf-8?B?R0dZeEU3bi9YRnltdDh3L2JGUzZZR2hlc0NtMVoxTXFoejVKZ1hrUVkyRlMx?=
 =?utf-8?B?S1o0cExpQnE0ZmZETjFlVE5VK0J1Vzl0SWFycDFuSHhQazY2NThCTTcyeFF0?=
 =?utf-8?B?ckpkbGRuL0R4V3RwZ2FaR1Fnd0RNMnJ1ZlFHZjRxK3VlTXpFaC9Wc1BiMlpj?=
 =?utf-8?B?KzljZjNVYmpVaU94WnVkRnZXUW1iU3FSbnh0Qjh4cVhlNXpFckhCNDBROVRR?=
 =?utf-8?B?Qmx4ZWRlYWNkemFLSnNSaEV5Q2c5b25yK3MwcmNMeGg3MzVhc2hTMmc0aFpW?=
 =?utf-8?B?TFlGanV6VDNKTkYrOWU2V0c1S0ZqS1U1TFZXT25Hd1pHai8zeWo2cWsvb0VL?=
 =?utf-8?B?MzRjdUYvVytDWnhDZkQxN2N0RlhWQ0d1dTFDWnlrWXhoaUZyZ3BWZlUybzNy?=
 =?utf-8?B?RnYzNWtjSTE4RmFsa1Q0SU9pRmMzRDZYUFFBWlViMVNCbVJRVUNDVjFFdnps?=
 =?utf-8?B?RVYzeTZsNjlJbE5vb2FRZnd3cGpXd25IMXMwemxsSUltZWtwMlpEZ2FmM1Qv?=
 =?utf-8?B?Y2o1U3ZiTU0xMVZXaG5HOEwxOEpSKzhzbzZQelRJV0RQZUszL2xHNFNWQlM3?=
 =?utf-8?B?VUovalArelE0SGxkYnA4Tk5QaVNrMGpCbE52MERDWUgzOE91anRFU1dVZGM3?=
 =?utf-8?B?UUhja2k2a1F3ejVNelhGMzZSSmgzU2tiNEVSV0hiclJtUS8xTDRoZWw3M3dk?=
 =?utf-8?B?eFlYMDRHSEp6cVlPOVdzZFRuUUR5UFdWcEp2cnBJMmRpQ3Rpanp4VjV5VitT?=
 =?utf-8?B?UGhMaFQ0S1I5ckRMbHRYTVhoVlMyUzcwNjJtT2tKU21zell5OGVmRWhUcHRq?=
 =?utf-8?B?ZmhDWm92Mk9RbElBelkvQ1NmN0lWcEpka3pMdTNtRHl4TmdUODBTL1FXanlT?=
 =?utf-8?B?M2k5a0F3OUJlSC9Uam04cnJvblIvWGU2NVR6UXFtU1MwajBLbmNrS0RxRFdx?=
 =?utf-8?B?VXNlYXFjcGFMZXBFZFdSL2c0K0VESWxkVW1KSTJQMUpZSGpRV3hpNFI1Q3VP?=
 =?utf-8?B?d3hVbFFWUXF2VEVmWlc3Wm4xV3ZCRlVKUXlGYVVkYlJpdkRrK2xabnpTZFYy?=
 =?utf-8?B?NnpkRUtGdmtVV21hL3RpRjZOSGhVV1lUbDc4UzM5aDQvb2xnclp2Y0x3N0cv?=
 =?utf-8?B?SWgxbHNPQitSemZzczhBeEg3K1pkc1pmYlJZTlpZT0hzZW1VWWFmR2MvSFU4?=
 =?utf-8?B?KzdSMytLdjNHcnBOdk9QNlFIa2M4V015NW1SVXZuZjN4VkVoek1qSyt0V1pv?=
 =?utf-8?B?R05XcjdWaytsalNmN1AyQkJtUG9lZU5yZDJOeHdUYWx2OHpBNDAxRlpNc1NS?=
 =?utf-8?B?UWgyQnVqQTQ5WnBKKzZoWDFuNkxjN0pGM1FwVEQ3ZDBVMFZQU2Nyb29LYkhq?=
 =?utf-8?B?OUpsZ1ZXS0xMTkRxOXBoU2tJT0pkMmRWbDNoMVd6b05XMS8yMFkzdVNDMy9X?=
 =?utf-8?B?N1NLZTN4NDI4UGRueXpLckNPMnRJbS92MytyaUtwcmFuTmlzWHpXQ290VC90?=
 =?utf-8?B?Z0x4OHJFelI5UnNlcEs3S0NlNmkwOG9oTitHMDVDQ2JKeWp6eE1XYUZkNDAr?=
 =?utf-8?B?azNSMFFaRG9XY3pLT1JKWlcwY3Arb2xQdXJNN2ZvUGZTa2haMDFPTUt4d0t5?=
 =?utf-8?B?NlRqd1hBZlZYcndnZTZ5SWppMmJ5Rk9BZFVEeDI3ckVKTmZZZXRLVmFrUS9F?=
 =?utf-8?B?bm9xMlZkMkcrTVJvbEZLUEc0ejZPaU02UzlQK3RKRkxYMDVDZERaMUtxL0dR?=
 =?utf-8?B?UWZMTXRjWnUyNTFvKzlDZ2xYOFNvcmZ2bTFPN2phaXdUU1IrWXB5YzlBRkMy?=
 =?utf-8?B?Y3ZtNWFSWXpDU1BYZnJxV3p4VzdMb1llQUdKVy9wamgzS1B0WXFQSjZlMzdi?=
 =?utf-8?Q?Auh6qduXq4k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUJDWXdZZ0x1M3lGUHdZNUl0aWJYWW1CaVFKN1VnZk5DcU9ZZVdjREtyWWpO?=
 =?utf-8?B?SU1pQVNodGlwUDJvb1ZobEl5OVJGN0kySVlHMzJzTWZJRUpkb2tkaGhDWVB2?=
 =?utf-8?B?Unh3RS9sK1dPQ2t6a3Z6dytVekVvNEM5dnFKbVVXKzJpdGhVMFNZWjA5NDZx?=
 =?utf-8?B?OS95dEFxWmxvOXhyTWh5WnFzcEVlWW1renU4cHNxMzFGN2NESkpaQjNBUzh4?=
 =?utf-8?B?UEk4ZkROQmpGYU14WjhMay81TCsveGxodTBZSStEbDFRbTQyZlI1MGFjRlFL?=
 =?utf-8?B?NXZHajRYOUJ0TzNrd0oweVlyR2djeGZEenh2a0tpOGwxOW04cElSbVJtY2dO?=
 =?utf-8?B?STR6Zm95MDNRNlhwejNTSmFrc3Z4aUpsTVZ3a2hZK3JmNjhEbWFtbFB0RUZa?=
 =?utf-8?B?REY1WnZGQzNzQko3cGh1dGtuQ0ZKWGh1WTJhVlIrRktDWEwxYnp4Q21UOC9Z?=
 =?utf-8?B?R2NrQVE3cStuelcrQ0hvVnRGeHFaaUIwTXZON29NNUFORTVndThkdnc2OEFQ?=
 =?utf-8?B?NG9BZ1QvMEhWaGlWRlBPaHBYeUlnSXpBQnV5UStwdVJhNUVodU0rU0tkK2Jo?=
 =?utf-8?B?bjBkL29SelRwWXBUdDdIZzFicUNyTkZuSGw1Zk4zbzlDZ00xTFJrT041b3dm?=
 =?utf-8?B?eitjZTg1V2tvdURPWmxDSFRSdnFrQmNwNkZ4ZkZZTDd5UjFqdHZzdGtTZFpy?=
 =?utf-8?B?QzJoTjBkVW1kN244cmdqWnVxeGxaZy9uaC9MNnlCNytsZkJ3UElJdEJTWkVX?=
 =?utf-8?B?b0Fib1F4eitpYlFlQnVoQnNOVkkyVGIrdGtXL2J5eEVCL2xITVg0THRMR0hk?=
 =?utf-8?B?VWJoaXA2ZzlhZmtORUNkSFU3NmRmRWY0R3M1blZYdkUwUTRDWjdWakNPbnNs?=
 =?utf-8?B?dnpKWklYWElnT0xhU2gvNGdRdGNERi8zUnk5UzRUWEdWa3p3ZzIrSXhtVW1q?=
 =?utf-8?B?YkdGM2VvTERLaG0xVExwZVNBV2xlc1N1b0FJdjZzRWU2bEIrMGh2NW96eXlr?=
 =?utf-8?B?dEFXTU1kNmwwSXFVaE9WSjFULzVaTG9WZy91ZnBWcncxdFBad0dqRDlEOVdB?=
 =?utf-8?B?Nkx0YktmdjEwdi9kNHFYYmtDSlUxd2l4c01OeTJnVDRRL0d6OWt5NFhnMFMz?=
 =?utf-8?B?OVFnWEwxNFZ3cG9STDhyTkpWMDNKMGxkTUN0ejdCQU1vQ2EvSTJEY1VyQkti?=
 =?utf-8?B?c2ZYMjM1eXV1MTBzTG50bmVibUo4U1UzZVlMVGd4WHVoOXJMQVJtSFRoMmRn?=
 =?utf-8?B?ei9ES0VJUXdzaGFxMUQzUkRhRng3M3ordTBCc1huZUZsUmhCNnJ1d1ppTVpm?=
 =?utf-8?B?NHBycGdEanJPcXRTUjF1MHM1NERiQlpxRlU2YjlDbk1ncTJkMVk2ZjFnN2Iy?=
 =?utf-8?B?NEFnajRzWXNWcVVvd0VFWDdLeGZsSldIRjF4TFkxSmg3U1RRckVkdVRoa1ox?=
 =?utf-8?B?dVlLbXJ2NEVKSDFmSFloUHFaU3l1ZlNhWWNlZW5TN1R1RU5GZUQ2TW15VHZ2?=
 =?utf-8?B?UlR0bEVQM0ZBQnpuRGFvWlJZeGdWUUMrbXZCMHZVYzkxVkR6WDF2c3ZxWnc0?=
 =?utf-8?B?UzR4OElMTVFicVNnc0dkdFFZVEdZNHBDQzJySzA1WmxjNEVCTEVKMTdiN0xN?=
 =?utf-8?B?d29MNHhmMmQ2bFVLZ2l1L09NM0NVMUhWYXN6aFBTaEQ5VG1tVE8rUEppazdz?=
 =?utf-8?B?M0FTaEdsZzlQL0F2SlpCQTNwSHFudHc4azM2OUxTVTdqRzEvRTdPZm1WTjFX?=
 =?utf-8?B?ZFd6b3VTaDZwMlZhL2plVVVIQUpmYU9LWnQ5RnFRYThXQnhaK0YwZlNDNkF2?=
 =?utf-8?B?ejk3K05OZ0dxU01vbzljMkFLUEpEempDYnl4elhmSzR3S0VHTlRmdGZKVjlz?=
 =?utf-8?B?c3NxcDZVN0k4OVhHTHlNSjJQYSs4VFJtUzZia1pZTm1GSk4zVlIzeDYva3Fr?=
 =?utf-8?B?WnZFRE5MM0dYY1BUK3lzVnRTUEF5RFFydEtJb3B2cHI3dVhWbm1FNFNybEZS?=
 =?utf-8?B?dlpYdis1WmxqSWVISTdUTHY5Ymo0ZlRLdTZyampPTHNuYlQvd0hEcWErM1l6?=
 =?utf-8?B?ZDREZHZnTW1BK3VaOThFaXVZaHlMWnV2WGpRS0ZzeVZqU0xDQXFMN1hZa1lJ?=
 =?utf-8?Q?Uv6CImSuf/2Aalunrkj0IsHre?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X00uXauClUvegkZrF4nA+I7lHyICqtyVBqrdByi4uSKyGIZzIfIVGkofz8Kd0BLrXxRGDYk9mGxBAiN7rjAS6oYiZbB2jJj3w3y2fNCGFxRfJ4DIwEwSfRiP55Kpn3nPKVECGfto0SvEcngIb/V3w7Vgbh+fuorvOm6m3nmERKG0ZPUDTbpaP78nG9pS700J+R/VEm4NvJxijj2GeoGnsoaw8blo78MJummWlbajhT9XEcGO+Y4iq5kmm8XA2MEJGjyEJuD7AJPxKexOQ5105Er+hWZqj6RaHqEJYUoRQw+u8cQqLjchZRaq1i6p7y5+67n4CRRxbw+CbQ+5KYzxwhnTlIme5OCc6gPu9iWEW298Oppsbts1kFn/tpW4QPnIqr2mupezUPkc15dcTJwbG0y97fKtIxEa+pxpmXAMolrPPWn85PVDGnVR0pm8d+LpS64V52qwuo5QTSxREShtYFU7CK4xftWcvlINNhEg5monOrlzyzxrVFdv/kuWpM/07YydQQeryT/isbfexgH+/MB1vl0K6BWtsAvJJNnq0NPwadDqu2xEsK8+Q1q9P6vAhgHs//CgHXPoWpDw34qZR43VuoHJ2FbS1YfvFsYmg+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff63f2ec-cc6a-46c5-dbd4-08dd927c0b8c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 00:12:42.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKbGO23qGBT85R5YrWbqZs1blTGdoeWdmQ4vAGXYmVEhv7m2XRKVobq5Me3tlBBDjSVxz91jPvPhqQ1pvzfo7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505130227
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAwMCBTYWx0ZWRfX9l+3MlUZgGMN galumQm+/1uvE2jiJieWPuS3YLsqlbgJkUSplFgEJy5/7MzDCA0Vr/FyYTwguJh3GSvIfKLktuk rmyFmPV0jfjo/92i//4zxThXvoUVExdVMe6O+hIVQC6tQS91VPP8RAGY+UQ0GwnZIyHDeBj7faS
 T4h4jMXoI5qekqImYtoC9xOoUYIeEoni35LViOtiMBKjrmPLWWKqEo5qCjKzwrzbulyAzpVYRQQ nHj4GMeRwnPt6QxAC+VpWbk+JvRi3NVTk9COvvvhQQnx0+mw63DdENlZgwmlwjRi0d3Ya202g2J 4e79LmxZ/BG+ka52N46rFLXWJ9iG2NAyrnVIZexn17pa3zPLlpTK9e56wHoWIUIR3eOlEVFjAsb
 9ilGzpAFAYsTWYfNU7oWIWSKrWpbisdaNc/LSwClwOo0Be+j482qZjVFmRV5PTtQaTVdwufO
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=6823dffe b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=n-XsKypgau7OJoThEaYA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: UUf_Uwnqw8SFSRqPr51HW4KwqZ6RHYGB
X-Proofpoint-GUID: UUf_Uwnqw8SFSRqPr51HW4KwqZ6RHYGB


> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Use golden output to match the error
> - Add a filter to filter out the unexpected new line
>    Btrfs-progs will also get a fix for the incorrect line break.

Tested for backward compatibility with and without the btrfs-progs patch.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

