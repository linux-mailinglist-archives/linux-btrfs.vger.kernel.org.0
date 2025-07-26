Return-Path: <linux-btrfs+bounces-15687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D486BB12BBE
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 19:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BFA1C242EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE115288525;
	Sat, 26 Jul 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NeXEaZgS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lweJ9mju"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9378F4C
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552668; cv=fail; b=JjuT+xWaaGyh56+9YcfThqZ/sv9yO/ydnXjFrpOMOtsgUDzXfmT1BvOuz/1n9pd0sCWu1j80eWU49zqrs6W6k+HW3ItGNJgSEI6of2gPqU4qc+k3dAZHExfODLy5BDI0Vz4nlNY7JN7OMUIJpU+MQ/4PuWUow6zKzBnLqSmf02Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552668; c=relaxed/simple;
	bh=yOykulQNVvEFu5gsanJxKQ20Tqr4VQHWasbcZqNym5Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M4P8ftyWc/+tHlyvPsn0ZmRLab+xhKDR6JPaxW8fU2yUYg8oj8bEPUElw3QB32gfMfzlqFaGNGf7CLqh49q2mS0zQJVYDIBDygWOj7f3VzLp7jqVLHvYAx7WpiuDMdtxLiNySQtX+a4fyLwL7pcdW0EO0NaEKHpsPJENUQS+Wzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NeXEaZgS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lweJ9mju; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q9perY020209;
	Sat, 26 Jul 2025 17:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UmXIsGQHBAzMhVn6ett9sVY1SkuX9Es9sppg2gcY8dE=; b=
	NeXEaZgSHo56WQyho+/AQsTM9yhj7c0aORI7bqQZXLG1OFO4Dt+NZQqCNP93xwON
	Z6Pkg1wWkYh/OmqhXCVMt5wE02xSC7h3BIksJEmDotdV+9rIzcbUSsBhlXAluJjr
	pMt8G3BlApLUrXA7+W+EzSJqeS40vCartk/F7NjVZQ7cGY+InE//cxyuuTZRzjYi
	3/8/ZmEW55nznqjjwC09xIkWb69zNbes4P5JlrLQ2n1af/e0srVxbL3JtMJ1U+Qb
	XyikrCc997wDi7GXCRc1L2GBJC097y12TT/KQ4zpwE2nvV7dWHdN6Qhn100FI4TQ
	kvQqw8x9ea8dbna6y7Yg7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q72rsxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 17:57:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56QH8EeU020374;
	Sat, 26 Jul 2025 17:57:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfddmxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 17:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEAR43xUbpguHsxkwsd71Azhk+BnKxZdrQzn0RGDpr0B10THBH/yNRCfj95Bh6IIW68QNq0W/EqcV4BTa0a6hdcRHo71CxP6giYyZFmjN3l1oyIAVSVS3outM8uOjwXJ15hk3LLPJK+qZQneKBNHXIGf0neOcfFGvrvHtRUydl7cCdvOWOUPrMtKeaerWkDj5GxV0Exf54Jwues2JSILTEPf1iJhLr+udacLaCwLFExDn7kTEMK9PckDB7I9vMTeOJFd8Nu23ws6ubVhUbYA0uP4OCtNnjsT7CGOF9OXLR8eq9QYij476I2fhor0mULRNaafTQoU4NHcb68+sE7zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmXIsGQHBAzMhVn6ett9sVY1SkuX9Es9sppg2gcY8dE=;
 b=WX4K1Z5UTkFVSfzyGUe+7OXLkd0k6u017crO5SYH1WxMaqVWFxLHyKgOlAxC7W5xkdOqoJ1FKlZBMOEa1sxO5ZhJOm7igX/YJU7V9xEw7J+sPyJBpzIeJVKMAf5+V6+iv34U7HdMKrXmH0s+Ao0h/4xb9xHLNUMNH7zTkG0DrVBLvrulZnhCJxU5397JVheoh6yYIw+hxDJ8TtQ572CT1XQNZqLt0Y2zLob+Ilb8neIE2KuMqlA7jEEV53quc1MnrmeTuhxVCsaAmMdfwj0iv70KYXULTFPW5PKB9xveNzZM+jA91hgWfQLQeqy7iS/7MCRJh6ng3+UQbLJUhNQbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmXIsGQHBAzMhVn6ett9sVY1SkuX9Es9sppg2gcY8dE=;
 b=lweJ9mjufihRdeWycgrFxTdmK/Cw2Zky53m1n5GPcQXKihjXQAlSi7Hwb4OYkRg5MorEYmSGQY3AhMU6lqxxDqJ1NK/+pQ8KLY57scPOHtAS13l6H2ipoBiarNgxr9c+hItjp60J0vGKOcNoFaWweM0pP2KBkVS59EakN2guUko=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Sat, 26 Jul
 2025 17:57:25 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8964.023; Sat, 26 Jul 2025
 17:57:25 +0000
Message-ID: <b756562a-ebb9-4840-93b6-ac2ff1ef488c@oracle.com>
Date: Sun, 27 Jul 2025 01:57:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: skip ZONE FINISH of conventional zones
Content-Language: en-GB
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250723133810.48179-1-jth@kernel.org>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250723133810.48179-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0046.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::12) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0228fffc-547a-4cb6-c7de-08ddcc6de0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0IzaTJwTTR3bGlXbDlxVWZlR0RNNkg5dWlOclQza3BvdDZzRG81VTZjazJW?=
 =?utf-8?B?b3Q3c3hwd0FPaTJHajlLNDk5V0R2dGZSeUFOWUFSVWxxL1JwL1ZKODNtQTB4?=
 =?utf-8?B?S2VndHUvSUE2akhsTUgvYnp1QkNrcy9WTU9SZDcvVDRLN0c2RmtLOGZOTmcx?=
 =?utf-8?B?d2t6VE9KVGhqZTY1YVMwMUtDdDZDMTU3bG5xQUlFT3k0RUNES04reTZiOFUx?=
 =?utf-8?B?NnFyeTg4UksrNnUwcHU4bVpCcVVVemlmd2RienhLNW41TGVOSDgwSlp4NkZU?=
 =?utf-8?B?THJhWDVvVjdVV2NaM2NRTTJCazFGb3VJNHhqY21XUXJOR3pTaDh1c0M0QU9n?=
 =?utf-8?B?SlJZRXNEems5OEtEOXRtaExPNlJ6d013bjczTzFQR1JoWTlORkZFbklZUXdn?=
 =?utf-8?B?bXkvOXRzdXlBYmRtZXJNSzIzK2lXaWRjbW41RE1nNXNsOXZVTENQVWFXSVNw?=
 =?utf-8?B?ZTlDeFpZT2hoUXg2ZngrUDBWdkU1bFRZbnNMZm5PSTlJcmFPdEFuNGxZZi8z?=
 =?utf-8?B?SE5NcUtQbE1scWtDUHNsa29wU0ZFNmhucENjdk9YejE3N21pQllHOGlRMVM3?=
 =?utf-8?B?eDhaN0xHMXl1NWxsNTJSSUVHYlZvL3hVUXdrTE81Rks2WWptUHhSVEVOUHFU?=
 =?utf-8?B?cFZtTWRHQTNUWTVKWEp3dXVHRkZnQkowZUpKdDYzZE9VSm1GRUtSNjRnbFNO?=
 =?utf-8?B?aTNUMjE2RmtCWHJ3M2hERzR4NEdFUmNCSlU2U3hvVzVqbVNkZitFOXhoLytF?=
 =?utf-8?B?eXhoQ0R5QTM0LzJJSXpOVTI0V3A3NTlhTHVoM1pYRUZWbWkyK0NGSDhtbHB0?=
 =?utf-8?B?TGsrTmRyS3FqaFFOS0JVaDFDOS83M3ZrWVp1ODBBRXRSYUdZNHNWZWRueURq?=
 =?utf-8?B?eGZ3bFY4ZWNMcXRqMDQzUDlINTA2TjZMc2NSczdZdHhUci9tQmhhb0loR2V5?=
 =?utf-8?B?QjhyYTYwR3h0a3huVzRCV09kc3k0SFBCbkFvQlVNMDB5TEdPblI2b1J1ZlNL?=
 =?utf-8?B?YVYrejBGMGVaVTZuVVlvUE9DNWhXemZLTlltSlZDMVpQVmpqd05vSnplVDNB?=
 =?utf-8?B?cWFwcklIUzg3YTJCbTJYYzBPMGNsbTByYUpGYUFXZVp4U3lwdG5DOHU2MlZo?=
 =?utf-8?B?dXNXQ1p6MjZUU1NlL2hFVW55MEFTU2cyYlZUNG9FaGdnU29RRkVkOHRFbFRm?=
 =?utf-8?B?MnFha1p2anQzR21xNk84emRDYW5PTlhDbmNNaXZrMEcvVHNYcFlpWWkwQ2Np?=
 =?utf-8?B?RWkxRGtPL3daM0RPTFUwWWFTYjZobnVqczBpSWlHcFNzVW1nVEZ6Mk93dHBz?=
 =?utf-8?B?VDJleURTNmxLeWE5OVJOZVJKbVJHVUtBSTRteWgzUFZmcERrVjdPdURDbTZN?=
 =?utf-8?B?SHErOFB5bmJkeFF6UW1IWFJvM1A3VDUzUkVYa0ZhWFR5ZmQ0R281UzhLRGx2?=
 =?utf-8?B?b3hTUGp0dUIvcHVwTWIwV0pCUVZGMU9sK0hBZEZBTlVSQ2VDQnorTmRUMWFM?=
 =?utf-8?B?VEtOQWtWUTVQMmo4WEVQbUZkR1Y4ZEkzMm1QcnlyMXJ0SkFBNmZ2NDdXamEv?=
 =?utf-8?B?dmZpQklWODgzM1NxKytDN0FaUGdCZDVHQXFzZi93ZVZ5M0w1TE44NFRkVXVr?=
 =?utf-8?B?c2F1RXFPUmsxZzRCNm1NV29xeldhYmM3YkJLQUdGUGZWVzY0eTBkL1J3Y2Q4?=
 =?utf-8?B?ZjNYOGEydk5GZG9EWlNVb3BTR2dZVEpocHFtRVZ1djRMbjk3eVlEZ1o5VjZ5?=
 =?utf-8?B?ajdiTCtLbTVwM1VLUTBWZEtvN1hwUFhXRFE5RERIbDFkRHJlc3dPV0krcXFm?=
 =?utf-8?B?VCtnaGlKc0MyNDQzbzNDUlozNUlObStPeXE5TldkZVJscGpIN1BkaUY5YUt2?=
 =?utf-8?B?L0p3aE5iYWJmelFJQjlNd09Bdnl5U3hCVS94YkdCRVlVV2xFMzdFbHNOM0Rj?=
 =?utf-8?Q?LBysXmucnco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXRvdnkzcFpmL2VnYURpZ3NVdEoxcnFicS8ycnc1MTVYR1BacVZYOFBna1hk?=
 =?utf-8?B?djcxTll5aERpTytPVlhWRnNDcGRjd0M0USs2eWFtaDNlM29FK2FCeHRyb1Ny?=
 =?utf-8?B?Vm12c0VOZnJRMERkTWxzNE9CdkoxL2VkeWRCRDhxT1hwOHZDVzVVTWt6VFFG?=
 =?utf-8?B?S05mRFRUNTRHUUVxa0s1QjhKRm5Ydmxzb1Yxdnc3a3VBYlBQYk1ObjNRT00y?=
 =?utf-8?B?YkF3ZXI4QStFQ1lBZmlPV3djdUVZNkZUQ2puQ0prR3JCcFJqblpTTERvK0NO?=
 =?utf-8?B?MmM4eWpuN2JMenVLVmw0R3Q2dkdORWJYUkNoYTl3RHZ4WW1HUUZ3MGhtc2o2?=
 =?utf-8?B?bDRuT0tXdDJINFR0Uyt6aVYwYnlKVjBaWk51R29IMm1NaGgrMDZ5M3RMTHph?=
 =?utf-8?B?RXB2Z2ZmTWxzb2MzU3BaZ0tpakxQN2hCRllma3BIR3QxZTU0eWdYWlVXa2RD?=
 =?utf-8?B?Rlp6UER3bTNIaStPVTVJbkVDMGd1Tis5ZUxpVkxYK1E1YVl2TURZZk5Ub1pT?=
 =?utf-8?B?UytWM3RmYlNNeVAyVFAzMDhsRXBVbkZHNnA5KzdWWUlhdURVbHIxekhCZnFM?=
 =?utf-8?B?VUFWS2h0K1hvYXpNNk1sNHFqREc4UldUOExPZ2t5cG1qZi9VQjVEQlpVOXh5?=
 =?utf-8?B?WHV0Y3dKVWNLNDhoTVJtQ1A3aEZLMVFXZlMzaGUwNlVaVCtyeE5acVlIQUdz?=
 =?utf-8?B?NE5BZTlDN3RabWdlTU9HZkVud2RlRkxOZ0tIWXYvc0huWmwzT1dOYzk1KzZB?=
 =?utf-8?B?clN1OEhUalBmZitISTRhb3JKNjE5SmNjQ0Z2K3NDeWdTcW9BSnpDWEdaWEVl?=
 =?utf-8?B?WnMxRzEwc0JjV0xZU21oN1NGKzZLN2lDTUZhM0thMWNYSi9BdElkRTlyYlhZ?=
 =?utf-8?B?T25xQXJya2hZY1FvcU5ucW82Z1liR005Q1JtSjFyOU1xUVh4d2RtMTU0WEFB?=
 =?utf-8?B?M3ZkWWRPclZJVDl6Vlc2cmgvQWxhNkQycnBkTFBwVUs3SkMrN0NWaXBvaFR2?=
 =?utf-8?B?b242bnIwU3VBeDVmWXdkelU1QnZrUExLVHBjSklZQ1pVN2lxdWJtcXEvOGpk?=
 =?utf-8?B?aVFrMVBKOVpLU0taZ21KUkhZeUlpZ2c4SkoyMytxUXcySkZSZjRiQ1AzTk5l?=
 =?utf-8?B?Z3BJRUg1S1JKaXplcU1sVUJiK3VKNHdubFZFYVlHczZobmQ0VU9rajA4UUFG?=
 =?utf-8?B?bFgzQTFUNENTTHl1SGRKREcrMTNSeGdKUUczS1FjWnFKZjZ2MVZjWlFOVnJm?=
 =?utf-8?B?c2w2b3BPQUVwOGR3N0JTSmh3ekY5N0czby9qb2xYQUlOSmdCaEc0VmJ3bGF4?=
 =?utf-8?B?dkw5bnY3bVBUbXFLdTBHTjdFbUFoSXQ4aXo0UE9Rb0dIa1owcVJDSzQ3MnBM?=
 =?utf-8?B?RGFUK3ZDeHoxWjJnL1pEeTNoSmJpeXBQelJCWTBKUzJkZW5QdklPYlVwTUla?=
 =?utf-8?B?UjFGWjcyRUl3UGdzK3ZJUUpXcVYzUzkvTnhBUXM0Q1hVNjZkZTZQeC9tbWU4?=
 =?utf-8?B?T1UwZlA1MTVwS1djMzdZMDhSYkxidFhET01VQmx5T08wK0pVancwUnE0UUNs?=
 =?utf-8?B?SDNCV1dCQVNPTUJtUzNKOGpScmxvMU9NWkUrQTB2M2xSV1BBaFJOTEhybThz?=
 =?utf-8?B?UXNKQTgwbVBVcGQ5NjgvNFMzaXNoelVUUWp5cHVmS01ObXQ4QlIzM2tDZVJ2?=
 =?utf-8?B?MHZyOUpjWnZ5bXdJN1FTeW8xczBaMlErbEpEcGp3VzEvNEJQNHMyQ2dWK3dB?=
 =?utf-8?B?ZmRzUTA0VW43cWF2Z1IrWFFtaU9lRXBlVUF6enY1dnhNeVZmK0Y3d1JaQXlz?=
 =?utf-8?B?MUlUZnBvdDlrbjFXYzZLd05nVURzaWFvUDdMUzNsWllTZXBScm8vaHRVb2ZE?=
 =?utf-8?B?VUhtcEdOaWJGM3U2ek0vaGs1d2RkOVlkTjQxa3U5VXVoK1N4dEVLdW55WU5P?=
 =?utf-8?B?TmlSZlZwY0RWQWFWWnE5bDZac1pBYkZJQXRDY1JPV1dDaVhxMVlyZG1PS0FD?=
 =?utf-8?B?T1pIUDNpcjZJSWJERmR0Q2liejZYcVArczYvWTIzTmtHWTdNOStvWVFDczgw?=
 =?utf-8?B?WFJpOVFhN1g2SGxzZnRXZlBhVDhlM2laZUxkWkJsVlpqeTNYNDVRcFllRUtV?=
 =?utf-8?B?cm95RncwOVlBMm1YdmZrM0Q4RVNpdnhSYjVMaWZtMVEzSnZtVGpQL0JzNkZW?=
 =?utf-8?Q?LxZFrdNJoE4Xogal4gtdr+Gm+a2Zh77WJg4tFFjtZsYd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vADDR0uEdElp8e/vdrr+46fG9B+5dGegw/dioUhim7sGjF5di75CBgyn62CEpS8S4wYdFjYKuv/64eR9enrB3J/PWt2aD1Kwu5aJ0jU6L1EEDODus5E+FlCNtGZwpkhSNjR1+SFz4obTSoqy/V8C9z73OTlLXiSDveEdts6LakqPc5/5Rdl2tm8BUABdy2Q8/18XWCTPbNWXDfH3Vpndk16GyYK4gW5HTnv3j5+zuRMiCPO5E6pCysy5bqW1dCtWAMflgEvR+tz6G2o4739HgP+IJOUZdOT2RzrcQr/RLDgdcY8TCkChgrn6fkhB50xmxjKnpBfEuy0eXmXPsnURyIxN9lM1FFJtzKOzTPpqk/LNROhkxxlZcpovhBi4nU/MpFj1G3yZ67UWCpDx/hyvRzQtF/gIRIQXfxic5rWeWI3cf/JOTOcp6lkMIaePpnE13g0XACOMfbAfSvbctUIZzPyz9tAOO9dhhJgB5/rybV6H6zgd1nAJHlPJfNJ5rgUNS3Uw3fnpOKA5Is50/Rc8MicnrIp882jSHE/xjQzOM8sxrY4O1a3UdgDp2/mxVdppEPech6+YaiFxeYPBa10HiPjHvbUoHUvClujqNvgydRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0228fffc-547a-4cb6-c7de-08ddcc6de0d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 17:57:25.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rqExR09/bXuDZwInvd+QvH3F4sckA6zQV1I1zRvAA++Tl+XS8I6eLfcw+LuniPer2F8N7Irrwca0efOTMDVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507260157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDE1OCBTYWx0ZWRfX8X0i/U84HSux
 JSVbPmBkyixsyunR6FtsQ4im7Kjl5/AeRi7Vsjuof+pVq0S/bRcmY/jcZ6XsgQy3IHFqsnq2ath
 /R6QBz+JuQCbhCKxZSIXxqLmKf4Y6Jg24GGbxi4MrbEhjGue76uMHNrCzHszNZ8Szz9WQyy+6f3
 wu5f8gpOu9ioFw4nrsXGXtunVtyQatGPQ3GeWV6OZSI4QRQuTPrY3+bX2uR0LmFsSly433gorjC
 Yv1eD89VVMOsHld7BCB/fY2HTmBTPNn4qCtc1vobw+zmQ08RpdBVtQaiyd+jCxPu/AVdEiFY9fg
 kOedSLt10/jPZVhQZ1n5RAdBbdnowKyGeEWn5rV0ZuvlpwLjxpPgCWiAyRV5JDLiIYW/UPUIbq1
 q/p9/YaRFaf3i1YgoQIMnW9Vgle4pVUbrQj+I8k+g54Z/3qF/KiGXqwJbMXQPrLyq7Bboo6l
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=68851709 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8 a=ZzHkPLZ37lO42ZTfK54A:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf awl=host:12062
X-Proofpoint-GUID: EoLynhQwRKRoaiT_wGFiT1_6hZR6uAUs
X-Proofpoint-ORIG-GUID: EoLynhQwRKRoaiT_wGFiT1_6hZR6uAUs

On 23/7/25 21:38, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Don't call ZONE FINISH for conventional zones as this will result in I/O
> errors. Instead check if the zone that needs finishing is a conventional
> zone and if yes skip it.
> 
> Also factor out the actual handling of finishing a single zone into a
> helper function, as do_zone_finish() is growing ever bigger and the
> indentations levels are getting higher.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
> This is a preparation patch for Naohiro's patch titled:
> "btrfs: zoned: limit active zones to max_open_zones"
> which can be found at:
> https://lore.kernel.org/linux-btrfs/47f7423f53492e0ee1cd40f204db8354efb8d6b1.1752652539.git.naohiro.aota@wdc.com
> ---
>   fs/btrfs/zoned.c | 55 ++++++++++++++++++++++++++++++------------------
>   1 file changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index eeb049994cfe..ddacdb75d45c 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2257,6 +2257,40 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
>   	rcu_read_unlock();
>   }
>   
> +static int call_zone_finish(struct btrfs_block_group *block_group,
> +			    struct btrfs_io_stripe *stripe)
> +{
> +	struct btrfs_device *device = stripe->dev;
> +	const u64 physical = stripe->physical;
> +	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> +	int ret;
> +
> +	if (!device->bdev)
> +		return 0;
> +
> +	if (zinfo->max_active_zones == 0)
> +		return 0;
> +
> +	if (btrfs_dev_is_sequential(device, physical)) {
> +		unsigned int nofs_flags;
> +
> +		nofs_flags = memalloc_nofs_save();
> +		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> +				       physical >> SECTOR_SHIFT,
> +				       zinfo->zone_size >> SECTOR_SHIFT);
> +		memalloc_nofs_restore(nofs_flags);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
> +		zinfo->reserved_active_zones++;
> +	btrfs_dev_clear_active_zone(device, physical);
> +
> +	return 0;
> +}
> +
>   static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
>   {
>   	struct btrfs_fs_info *fs_info = block_group->fs_info;
> @@ -2341,31 +2375,12 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
>   	down_read(&dev_replace->rwsem);
>   	map = block_group->physical_map;
>   	for (i = 0; i < map->num_stripes; i++) {
> -		struct btrfs_device *device = map->stripes[i].dev;
> -		const u64 physical = map->stripes[i].physical;
> -		struct btrfs_zoned_device_info *zinfo = device->zone_info;
> -		unsigned int nofs_flags;
> -
> -		if (!device->bdev)
> -			continue;
> -
> -		if (zinfo->max_active_zones == 0)
> -			continue;
> -
> -		nofs_flags = memalloc_nofs_save();
> -		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> -				       physical >> SECTOR_SHIFT,
> -				       zinfo->zone_size >> SECTOR_SHIFT);
> -		memalloc_nofs_restore(nofs_flags);
>   
> +		ret = call_zone_finish(block_group, &map->stripes[i]);
>   		if (ret) {
>   			up_read(&dev_replace->rwsem);
>   			return ret;
>   		}
> -
> -		if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
> -			zinfo->reserved_active_zones++;
> -		btrfs_dev_clear_active_zone(device, physical);
>   	}
>   	up_read(&dev_replace->rwsem);
>   


