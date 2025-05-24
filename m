Return-Path: <linux-btrfs+bounces-14195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD4AC2CF3
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 03:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700A51BC5738
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D395170A37;
	Sat, 24 May 2025 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9+59J91";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LSH/iMFt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E4770FE;
	Sat, 24 May 2025 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748050804; cv=fail; b=qkjEu66LExAuSlwcwhxLtN3Yc7uFzZg9ZCa3C/mSu1n4YDskca3gO1XP291z5cJoIpl44D28fBulKD/6/MnIKPsHUuzGJnA4FJEYY6YXcVa8Kz6i6TdD2kHUsz2DdSwMJD+ptVARKkhEdI76w0NrDpGJ6JiAGYvtDyYkkrBDoGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748050804; c=relaxed/simple;
	bh=g41D4zy3m1u4adQUigR2FcTIhA3hpMDk7Ab3ysBMj4M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YRZTc/T7mggOpZpr2aW4EEG/caXiRAwRTgytofgC8l2K1UGIWnjtK54grfeS0kvUacUV35MBduOOM1BCFCrTo5QrogIt293xAtXAysH9zqYz/eFsyiW/ZlTdNx4QvaskIZS2+wAqFnAWrVnPStKvYurtMyN/xHCVFx0sLkAv3bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z9+59J91; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LSH/iMFt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O1dumW021799;
	Sat, 24 May 2025 01:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fyBLpcz5JXTIwMIbPfjWzSyQEdl1zrWWTLcNr4ZRHYU=; b=
	Z9+59J91XpclrePYWrKiTH2HuVYvtQanBNuatft0pk1nyaFJ9Bg2R9vWt8NP85ra
	qEtPyBfU7NCKGbcjiFSMEvVv86YtusHMJcuDZ9D2cTJ7fGfcQBQxQASxqDi40M7C
	J5AJcrER/Gno0f2sXRHBnSDRDKqo75/GIq7fCyW+BWwHErKNcSAZclCbZ4tcTda7
	i+KS0001rAi2S97CL6GTjgjm3rieHNoZcn1TIMBiIO9C1c7k2EldSg98ouN0uGp0
	Ts1yC+T6jxTmKUY2/GwNR4+tKkV6nH3rwds/Vh5wH/tgkwqbFbLN3XKxVjL/PaV/
	68Q2jr+qmy+2bPUuy8o5kg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46u4mmr00e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 01:39:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54O1Xfx4007197;
	Sat, 24 May 2025 01:39:55 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012053.outbound.protection.outlook.com [40.93.200.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j682wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 01:39:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDKdPbMTQvHp1V8wFbowKmT3qgZxKhwEPw33DV6cUC1andIBSKsyZx4c9GLyEdmB33QVszY2BZbKfGMXmkbjs1fKlX2+GLFCmkHsElivdShsJm9YzPFFxWhqZnwKZAh80dn4tQtiUu9Zvb/+3d4uv16nlykEUx0HkC/wQPMDBfo5HOMiiF8Y7ua7Ush/L0JfLVQuoVSIwJ16dTRoXMja01MOV/4yc5PoZegsiPksM8REfxkqDescmhQScs+dAQbleXmvZUy+aiYAqOhXNjYlEdK+E5LWyzZkv1hiLftAGZd4lZeygUg/4CvcQ7p99fi2WsiMoLoWeAson06CXrDi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyBLpcz5JXTIwMIbPfjWzSyQEdl1zrWWTLcNr4ZRHYU=;
 b=PMIhpckRrzwvZRm7fvhS/DIvEhnl3YyTx0uN/a+9t0G5xs2snTPvDHxPPqgoLlmTKViU2ahcACMMtHREXBfpqNYK4Hl6j8lkMs9Dn0tC5lIIbnkFKESbHOZj90FggiHVgWnKBJOYecjWRWB9NK2BYH4ZykFuKlXnWMUH00QljCTvN35pvUYpy0+Ylnsle08SsPiOzqk467o+A616OaBDoXcXxxG3lsv3794Ai0Y2pbiIdyXsixQeQg6XXXbaqjACKGghmNBNPLInPCNUkq606g/nlor4W6JZHMA8jYd/OcGX8BSH/slETe+f2xFkdms33geYsdS0MUVS4hAlQG/jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyBLpcz5JXTIwMIbPfjWzSyQEdl1zrWWTLcNr4ZRHYU=;
 b=LSH/iMFt914gOa4st1495DwtcYwUbbLgPU6o5iOI8g27OmQpI5CTO9VgZEXea7THcS/F0ppM/vy5tFDzc/dtLna40IZQjfj5Rl0V0RSSKqccbI4n3+YVhsjv4E3PQz7MOUVgQ8R75GC4vfi5YKZxJKeF8P2APuQR46FqQZ7Bmsk=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by IA1PR10MB7288.namprd10.prod.outlook.com (2603:10b6:208:3fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sat, 24 May
 2025 01:39:48 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Sat, 24 May 2025
 01:39:48 +0000
Message-ID: <45934816-f009-47c5-a34b-e8d81ddd6305@oracle.com>
Date: Sat, 24 May 2025 09:39:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] fstests: check: fix unset seqres in run_section()
From: Anand Jain <anand.jain@oracle.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
References: <cover.1744183008.git.anand.jain@oracle.com>
 <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>
 <20250409095725.xumxhw54igwapuue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <9dc6a550-5e4a-4ff1-8961-9d6dd758a83f@oracle.com>
Content-Language: en-US
In-Reply-To: <9dc6a550-5e4a-4ff1-8961-9d6dd758a83f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|IA1PR10MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: ec746a4c-5080-4577-3f38-08dd9a63de28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1YyZ1VzcG9LV3ZiNDgyYUxVNVBnamM5V2hiN3BPa3AveXFXRzN5Rk1GMkdZ?=
 =?utf-8?B?endVUFJTdVJRNzYyT2xBeUZ3MzR4VkxheTFtdWZRN2lpNTJSWWlJYmtpSGdN?=
 =?utf-8?B?R1Fra1lIR0hIMnYzYnBhZnJXdEdvTmZZV0JMZCtMVmN2c2ljV1lDVUpYbFRj?=
 =?utf-8?B?UVBDS0JxSjduQjc0Sk5sdzAvV3dvaHNwb3dRK0hvZ3FJUlIyRi9IVTZpSVJJ?=
 =?utf-8?B?SiswcDNuR1Q0ZGwrcnFKUDZlbFZsaTZVbnBOWWV5N25oVlJzeDhPQTV4SkVD?=
 =?utf-8?B?WVlZM3czdzQ1YlhEelV6WDU5US9IVzRZY3NGVkRXRFBVUXBQNTMvV3gwMmEy?=
 =?utf-8?B?YlRQTVE1OGt2QWtRSWRIamxXL3pZa2Yza2RINGFyV20vUlB2NEpKbUdjY0pp?=
 =?utf-8?B?cDVWWXg3V1dsY2Q0SXF3eGsxQWZBQnVTbWtGenZvcDk4dHB4TzE3VmJONHpR?=
 =?utf-8?B?MG03SFFrTDB0M3VSOU9HcDFLa3k1MFk0bmNrUjRQeVEvWFIySEZjWW9VNHpY?=
 =?utf-8?B?RWNNYmZaM2lFWFdnU0hvM3gyMXd2UTQwMmZQS2JaWldtTGFNTXhHbTFSLzQy?=
 =?utf-8?B?TmtBcEVMMkRxdnpFaXNGM3ZyYXdYU0dyYWp4RUNBUWNRRSs2VmFHSmZoZDVK?=
 =?utf-8?B?OXBOTXlaQ2dLcU96NjZ5TGpuS2FMbnJKT2xQM25hdmVHc2dmQmFoVkY2T3lN?=
 =?utf-8?B?NklXTSthZ2NtNGE1aS8yY0lxbXBMSjF6dWZnQjlGUnlmcFBLdGxYZHg2Ukxw?=
 =?utf-8?B?cGdUUlRsSTA0MXNoOVZWbUtUWklwRm9WbDgvQTRaSVJRS05MWnJJUmRYcWQ5?=
 =?utf-8?B?R0kxOE9RYWRGa09KUk9hYkJ6QkkyZHdSUmVyOFNQMlJ1WUVxVG1UK0RmQVBD?=
 =?utf-8?B?TkdwMk4vQXlXd1FYSU9LdDZjMFltS3pmc1pxVytnczQzUkNRenhLVloxa2Zk?=
 =?utf-8?B?Q2pCa0lqNUxjYVQwTmNvZU9TSTBlOXFtY2dJQkFRaWVaTzBIQzNUaVkzbXp0?=
 =?utf-8?B?YXVnVll0cTJYWktQOThlTFk1MU9VeXJRNUFFVkRSTWRMRndUdkhsVnRaakZF?=
 =?utf-8?B?c0NnR21UenNFMmdKbzQ5ckRtd3hKOVJRalNGbDlNckVOazcwY3p1SHY1RWVJ?=
 =?utf-8?B?SGdtTVBIRVRHK0E3OE1DRkhsVG15Y1RQdUhhWFNCeXNqOXpuRTZ6TDZieC9a?=
 =?utf-8?B?R2QwcUY3U0xiZWFhQVdQam9sVkxRbndmT3dKd0hjUG40bXdLa0pxQUY4SCtN?=
 =?utf-8?B?K0VJemh3dEd3N1d4ZHNyWGtLSXVDdUVRLzgzOTZ2MGVMYXI5Y1Rja2xjdTlS?=
 =?utf-8?B?MTAzcllQZWR1NGlPYkhmWXlSREFRSEhMQTMxVVBETkRvUjlmc3lGaU0zOWlY?=
 =?utf-8?B?S1c3QTM5bnQra2NuVVJ1dFFZc0MzU3NaenIyN1dQeXkySUlKSjdvQjlhb0ty?=
 =?utf-8?B?K1ZNQVdBRG1LelBKcCt2ZG9leDAwQ1hoVXNVVDByRGZlaGZ0aUdYN0dwUVJE?=
 =?utf-8?B?NGlLNnZTYWNIY0tnOGMxTTMxcmdUdzE2NGdTMmlRY0ZhS1oxNDhUaXIvNzU5?=
 =?utf-8?B?VnFxT0ZCWHljZmMvL1JCYUNtSzU2R0FwSzIvMHIvaGF6RkpIdWpNOEM4VUVL?=
 =?utf-8?B?ZjcrcjR2WE5vdklteDl0Rk4zYzRvNmh4UzJMVUJpdFZ1SXNNSU9ueVozbUZB?=
 =?utf-8?B?RjFKdW5YYWZjTTNaeTM0bUNVVjY1THlnNDNvSGgrdlUxZk5idmd5RFdzQ2ht?=
 =?utf-8?B?UDB6QjZwVEY5aDRIL2NCTm5CU1U1YjhjclF5NTMyUXFKb2Z0cVhjZkZlU0Ix?=
 =?utf-8?B?dUNDUGpUOEVpVGsxczFFQnRFdUJ1U0hMR2w0Q0Vlcis1bjFMdGIwUTN1dTRi?=
 =?utf-8?B?YkQ0SFBXWjl0ajBCVENzK29tUWJWNXBwbnI2WVMzbXV3WUc5dmliUUNuOXV0?=
 =?utf-8?Q?sw0ma6Q6kuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTZHZlVsdnNSWER0bWNkYTN3ekRvVGdUQmQrLzF5S1FFd2ZVTkU5SDJEcmQv?=
 =?utf-8?B?NzBYbjMwRmMyenFXNU5Rc0lXaWZnSStkTXpleGdISkRUVmxqeTNsSnA0c0dY?=
 =?utf-8?B?U2h3d0hnT29HYmZQYmNHNGkxUzVLcWt4ZG5yM2xIMUhySkxuZGsyR0d6VG8y?=
 =?utf-8?B?blhkNmFsem9iZ2RJOHBBazAvczFKZkZRUXdBL2VkWk5PU1p4ZjRGL3VHR2Ix?=
 =?utf-8?B?OXhweWdvZ2RSdHZpNTlkQ1FQekthRzJwQ1oybXhCNnVyNW11bFg2NFFTMnho?=
 =?utf-8?B?UjJ2Rkt3ek1OcE9paTU2NnNvMVBaMGUvdVJPbjQ0ZzkrVlVqeW1TVDhaZDJm?=
 =?utf-8?B?MnNFalZ5bjJXWlBtRWNPOFNKUVdFVFRrWTR1dUtXSDMxV0RYRmpQUE13Y2JQ?=
 =?utf-8?B?QXB3K2wzN3BJUnVrUnJ5ZzdXcW5JNlVzSVhSRXZ5dTEvdDMvWVk5WmJ6WWQ5?=
 =?utf-8?B?d0RSbUw2aE5zUk1oSXRtaU5zbllpUTJaYmhvOVE2RlgwRnJqSEkzZUNmSU9q?=
 =?utf-8?B?MUZFbEg2anBzVHpBMXBXZ1ZsQkJQR2UwTkliYjNxS1M4MEduVU10QUtVZENp?=
 =?utf-8?B?WVdzcVpXYXFKckV4a2JwbzBVSjI4WGpLRVoxbmdyZkRmWE5TSGdBdFRCWVZk?=
 =?utf-8?B?Z0VpdzM2R2lZS0JaV1hIcVVxL0E1bGJwUG1lbUNqZmh1UGxiT2JTUGpuTlM3?=
 =?utf-8?B?aE5xZ0R6S3ZqMlJxdkc3UXZ4anFLRzJsSEtPRjAyWk1LZXhDRTNWR3RKYUJr?=
 =?utf-8?B?WklnNS9BZnMvaHFOT21sMnM1dkhRMm9iU0U3UVBuZWVDbWlkaUtadHVsdUF4?=
 =?utf-8?B?empjQzduanpITGtmdHdGdGRneFFRSldjZUdCdG5vbENVSHlucmZ1bXJydnlE?=
 =?utf-8?B?UWplQUhqc010NnpaN3BqZ3l0WjdEVmxhOXZ2NkovL0J1Yk93N2E1V1B5V004?=
 =?utf-8?B?WlFlanFtak1mbmo3WjR4OXB1TGZ6a0dIdko0LzZyYkE0Mkp3QUFFOTBvWm9u?=
 =?utf-8?B?QXpSN240MDFuR2V0eklPTTI0MUdHWWxvZFpDMS8rWnJCb3BONHRLS0J2R0VQ?=
 =?utf-8?B?aHN1WXlxaFNVa21MQ3QxRXhpamQzSjVRbmxGRWo1djBPb21vSUJHVkVBdDU0?=
 =?utf-8?B?cG9ONU5hbXZmVExhK0Ewa25HYWNxc0p3VjMyWnpXcGtHdmhkN3ZLRkpGc3Ay?=
 =?utf-8?B?TGRYNUZHRzZNTjF4cWNhMlRzSi8rVzg0eEFtVTlpVWVYNjhkb1ZKZnJRK0lW?=
 =?utf-8?B?bTB5OGk3elNUdWRIODlqakZXMVRsVkEvVDFGWWdXbk96Q2RzVnkzVWx0MDBU?=
 =?utf-8?B?bHdEdm5IdU5hOFUwZGtlYTF6YmhGT3NrOEt0enNqODF6MENpMEpDbGcxQkhv?=
 =?utf-8?B?TG9ZYk9SOUd1UlNFelRrTGpnd1RFMmhhVzN2MCtiZ04yTTJzT0FZMmpZTjls?=
 =?utf-8?B?YzdJRW1IQjUwNHduazkyRXRDc2IwVTZDWGJpUkJCck9qS2gvbVhRbHZIQjNn?=
 =?utf-8?B?MC9ndDhyeWpFR2xLVVNEU202VURBRVNMSW1PRzVjV2RZUTlkTnkxYzlSQmZo?=
 =?utf-8?B?cWNZaFgxelp3VUdwZ1daZExmdnNybHMwTTNZQ2h5YkpnMGJRbHlwOXp1aGs0?=
 =?utf-8?B?MjREQlhvbjhEaUIzUjM2c2tqc2xHcHB3V2VTMDJxRDJFOFZrWGpRWmtDZld5?=
 =?utf-8?B?ZEpjcTJ2VjAwNFFFc0ZvdzRLVFcrZmpSR1pJOWRwdWoxM09wUCt3eGpPVkVL?=
 =?utf-8?B?R3YzK2tkL0M1NVJJTDJrZmFUejlkTGszODgrb09ib3lJMVRpcXdMY25kalBk?=
 =?utf-8?B?bEFtQ3V1WXJUTjhGNzdlbGJOd3FUTE5SL3NMN2FsK2FQTmFyeHFWU3RxREpl?=
 =?utf-8?B?RFRZNzhMNytkT2tOeDEvVEtySjIra3pJRklleUFKTUNqTDMyeWhjdkNKZnRD?=
 =?utf-8?B?cUc0Vk5CRVV3U3pPQmVSQUhOeHc4TW5raC8vd2E0V01tQk80TUlnK1ltWHpD?=
 =?utf-8?B?TGFhRWRXSkpialJQVHhIYm8yN3FjT1lwWkxqWGJaVUVqZWpTUGk5eTZRWEc2?=
 =?utf-8?B?Vk1UMVBBZnFpY3RvY1lDWlFWZHMyVWtkYmFNeHgzSVlnc1huVUJ2VnJSaURF?=
 =?utf-8?B?ajBaQ045TmlhRUNXMXZXYjh4aWtsa0plUWVtMlc1cWNucnFWKzR2a0FtdThp?=
 =?utf-8?B?ekRlMXkrS2c4blp4OUdMcm02OUNSTzRpWE9haExKZFQyVkdVbUJacXJMT3Zu?=
 =?utf-8?B?TFpqcTBvQWxseGp6NTJsRFV4U3lBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c3g66fzDfDlTSh5qWheIqN1ccQb24pM+SstYuQcp73mSrL0lg10IhgopxN/e59fJcwxMj8kRUsWVyZ/DfXdBp8NWS+kz6BcXUbixwswi8+wfhP8nRel54gsmExIhEdk0wOsZbKLvUlm35PFPN6qp6EFtl1A/fv88rh2RxYoR47TdjcfeehhFoAhToBLWYPLljYobuoMeDYQUHIg1KFXNfBm7diUN2h/AKiD4WqH4YECjiezD253HjN8+k7Lp8taQhpXDVLZGE0DleRrnB9pTy4yEHMYHOgLMH0D0MqdRrvOvV0Gp1vAaykNwyftqQMj9WZ+JIQ22Swr48ftChC8M6//0FUqjuMTRKwmgumqZudykpiqJlf564lS8ScnAayz6gTLveTi0AZjfmhNIaJ14Qcf+OD//b7mgMCJXI+rdgwDmpul35oJt6y0Y08jyFY5HsnoMoP4REPch9dM2/fpjdaGOPvOmdxjrjNOWLb7wjoalezQRQQf2dF/YugVDaYFlF0faoDX9h8qTqyDa4yrqcVsgtVNUbJaXLcdWBdri85k6V/xDpOjCtMWYqzZBRpUoiDL41SL7cU8yjQ6jc49as0Bmd4dZaz2uGvAHF4oW/Sg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec746a4c-5080-4577-3f38-08dd9a63de28
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 01:39:48.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nb/rhvsq6oeQ9FGiff5dm4VXWDX7Alu9yUS2ug2b8udSDyjPXOGShsk52m71jbO/HE3ZHc80wiAGMDQ/f+FOAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_01,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505240014
X-Authority-Analysis: v=2.4 cv=c/yrQQ9l c=1 sm=1 tr=0 ts=6831236b b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=BIOq2PY0CPLXY4Hulh4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DFUBExryRdP8GFulmA0w5MH9g3RO8Jd-
X-Proofpoint-GUID: DFUBExryRdP8GFulmA0w5MH9g3RO8Jd-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDAxNSBTYWx0ZWRfX4PkxztMLzlFs KaSV2qdZx4Yw0/rwH7lI+ZZOHfSjXdFvwTPPu6f6kcBoGBoE/odHbhD/Wh+MZCkMomQwJFDRqo5 LEKPkSPcs2923dLpFPNszFdgVbwEAJObltPLoScukp3KGZ0HYUwDwwca7tYzHbYv1hIx8oj9UBT
 ypMqwjRAoDuVH/RJ+D7sjtysu8tycheK2bYA1zRklh4Jr2Z4qQzJBahkpvRQOk9lkCLiU0+3yd+ vuEcVk399Q22ZFuB3Hzl9Ll7QGqeo4pfI62f3q+Qcvm4JRMCrRnwg7E88nVXycK0DsCzWXeXJJh YnV4fh42mSmH/Hrz/SLyG8E5ybSYA7tQ8MgJ8dBYRVu9zp8XafnV8odBuJx9bddPjP3DZmvV/xo
 8FwxkBayoE+Ws5thGupUekyVl/sgT+bWAuNmdKRgZCYffFg89Io8cJ6j/0we4GiFevpalSbi

On 10/4/25 05:31, Anand Jain wrote:
> 
> 
> On 9/4/25 17:57, Zorro Lang wrote:
>> On Wed, Apr 09, 2025 at 03:43:14PM +0800, Anand Jain wrote:
>>> Ensure seqres is set early in run_section().
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   check | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/check b/check
>>> index 32890470a020..16f695e9d75c 100755
>>> --- a/check
>>> +++ b/check
>>> @@ -804,6 +804,7 @@ function run_section()
>>>       seq="check.$$"
>>>       check="$RESULT_BASE/check"
>>> +    seqres="$check"
>>
>> The "seqres" even might be used earlier than that. If your rootfs is 
>> readonly,
>> you'll see that.

Zorro,

While testing, I saw that ".full" is created by _scratch_unmount(), 
called here:


  725 function run_section()
  ::
  815         if [ ! -z "$SCRATCH_DEV" ]; then
  816           _scratch_unmount 2> /dev/null
  817           # call the overridden mkfs - make sure the FS is built


So the fix in this patch is correct..

I also tried with a read-only rootfs—".full" wasn’t
there an error to create that file..

I’ll resend the patch soon.

Thanks. Anand


>>
> 
> Zorro,
> 
> Thanks a lot for the review and RVB!
> 
> I’ll take care of this patch 2/6 in a separate patchset.
> Meanwhile, could you help merge the rest of the sysfs patches,
> except for patch 2/6? I don't want the seqres issue to block
> the rest of the sysfs patches.
> 
> Thanks, Anand
> 
>> Thanks,
>> Zorro
>>
>>>       # don't leave old full output behind on a clean run
>>>       rm -f $check.full
>>> @@ -849,7 +850,6 @@ function run_section()
>>>         fi
>>>       fi
>>> -    seqres="$check"
>>>       _check_test_fs
>>>       loop_status=()    # track rerun-on-failure state
>>> -- 
>>> 2.47.0
>>>
>>
> 


