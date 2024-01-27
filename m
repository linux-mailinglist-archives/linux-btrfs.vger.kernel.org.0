Return-Path: <linux-btrfs+bounces-1840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2A783EC14
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 09:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F07B22913
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8561E891;
	Sat, 27 Jan 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="imR/szca";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jN/h3XKr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CBD1DDDA;
	Sat, 27 Jan 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344720; cv=fail; b=Mk8KPhp+9kYOoiaviRwLE5bUunCcLDbUp+BWL+j3MkjHnS61z2dWB2aMsyOVv/xAAtqx3odtpL5AaL/6CWoF0lfj0kN/FDJ7ClmzqsBLWvvkQbMJTABVuw5Nu1uKDRvVFueMKZNqywwnnbV1a9KSo4GHJk6w8qxt+g1YftZwZ+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344720; c=relaxed/simple;
	bh=8gIlqm/4tUVfWSu/ABx6firOLZPH6qEGjjGfdgvbwYo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eAFd4j5xzQ+lb1hSe95YuBiCKv860i6XIgC27GlOV5Y0wDpk32RBqUvBPsL+iTYZ5/6OJneHabnfJMXFuCpXVo6lCoZ/E4bJukJ2i546u/J5ZwHChbELPHZos5148Vel+y3b/P5KvFYvWZa3IUj2kvByWn9Q90g2xfgUC54FT4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=imR/szca; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jN/h3XKr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R4lB70014146;
	Sat, 27 Jan 2024 08:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ho8pQyI3/Fng053xPQT2o/fVUD/+WW58DS+A6TNjkug=;
 b=imR/szcaZDAoXMFj15/k17/dJVgfOQga6od1Pu677syI3ZFKqQbOAPba285mtTFWdfhI
 XWaUTbzp4HLNSDYOQUnqEuCEr5H87H+m/MGpH1MDP8Ql5Rcdn0GZ8ULvkNXRPcUg3jX4
 q6xJH9eQrBImiJ7oeojC8VSjRx+uxkFH0hQS0fzB5l4/uxEoWyM86LaqELpDKuFYr+M3
 gm8+jZDHGXfOYLwnY+E2iKyJSGRY21z5KUJ+coaRnWyVdITd7FG/5ARGFiMxbe2UmWTb
 LCnckreWqkdosI23gZ9DGaMHPzpOqU2a7QVH+ub70Zdcnv8r8x6yc7bZmZx4JZW2ztfN UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8e8agg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 08:38:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40R5LjbU014462;
	Sat, 27 Jan 2024 08:38:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr93r0yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 08:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiIrPCkJhWBZMDvNNm7gFZd/x7TkbnH6Xtdk8yo1PpKvdtEPnfCLRRPKxWkNsEvKMprvkxn5Ek6nkIMY/Mpx9ZtV5CS2HyYDqo4CvJO9uzFHZXX2lLq5kE1O5GiyMl1++xmfB5Cv44ZSm+txGk2xMlFOHrgi6j3YLT+mSXgv6PvwNLgOWCZkqtYTsJLz8wLsW1VDiMBaSMVNw1FvmIe4t7zN/zU2DytRuFnHCkU7Bs2ZWH0ZgJk1I3wEJ0mIMduDfrTgGmVCL1p9CEywHvdXy0ALVAeNflnI7328MBjb1iNExPiU1TFhPvnqlYuPjEgtDp//w1ar2ijUlqqaC54LQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho8pQyI3/Fng053xPQT2o/fVUD/+WW58DS+A6TNjkug=;
 b=iIzPq+BRFGmFRrYOsD1ncxXF9eB4FiFGNhZc090XGHZgyTWMOcAgy+M2oKEnhhc6oqNbUl3Lq52xlakJWPBaF7ZcTuBDqFRozVUjfdyAQciiaBp6d8Q6gYhRV4q5xQ4HSxs750yo/N79R5Nt7BpdakHpksKsujY41FhwnTWHOWInO9Qlj2Y8go5kadPhAUYrxKFTDCjhKYjVAeyn5PGF/vPNUoXABt+wcu/e8Yl42/1BAbhQKMk8wGQMSv2wTbda7aEOeu+Oue9SDw/la/H8oIkoTCPwctWEFBt51iDDxGv2GtrjEWHWqX6NRfJtnrxYLdBPf60ukZPA1rcsJLM1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho8pQyI3/Fng053xPQT2o/fVUD/+WW58DS+A6TNjkug=;
 b=jN/h3XKrKmgIk33uy4q0Ps4xkFxTmn6tJo3sJysdig5+L5yU2MLkY08wN0564td8IdBzb325rCtknkNyzMsEaBiEKkOnt9cOVDegEau6ZNSOjEwpp318HX+7wzgxWK9EVc+kzL+JJrkNCQFBX3ifLH5PLGk2Ao17DF0dTMDJ+po=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.39; Sat, 27 Jan
 2024 08:38:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7228.027; Sat, 27 Jan 2024
 08:38:29 +0000
Message-ID: <72d39266-3ec6-462a-9ac2-02040c6c37e0@oracle.com>
Date: Sat, 27 Jan 2024 16:38:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: verify the read behavior of compressed
 inline extent
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240123034908.25415-1-wqu@suse.com>
 <17e9c07d-9396-4999-8449-b0e3e764c32f@oracle.com>
 <9baa2a24-a44a-4f5e-95d7-23509ea450e4@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9baa2a24-a44a-4f5e-95d7-23509ea450e4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 94654492-55bb-4a93-de36-08dc1f1355f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PGBIerUHVDkwoZBHkUUMUJd1k7C5s/EScz+eEBudOaGyv3WOJQArn+z8yY7PcvoAsgFRWf7edEFoKhTKB8ArGzR8K0J/5iw9tnR50XrDWG7SzR0p27RKdnxinwmz3HhJU79bbpz+KfFaci8IwAaZX8BpGCXgrip1cO5B4srEs85ZcqkpxOD/t/wzfsFLlg3TBR1eop/jedMSZIXUcl/RhsUTLXpdHMGH6M2Cfk0wGeC6ykm56kDUaNNenz4syv5pHqs2S0Ky7J/UjtEE9rwiX7HrRy0sAiz38zJDdDbQkvjdKR6QlfaZ8LI0YtLpFVWyMwcrV81o7r2LLZKAI3+xpgkwAyypmFsXOOj2yveqPMIOLYi208+YeIF1kaoSnVlwGQ2m/To/fwTC2zIX+BwIEntx2miW2eIsw3JOstSgnGWl/iPkEOeOqWy8gFVAFa9HBv7i5taSW6L37kzubm4klluQMARmu8wSRo6YmtyZ6xK5ZuPkifarONz5JwZwWVd6cdSTIoTrQeJc6QW381V0+FsPUxJKjVmcvjppA2PAfhbuGmXEyGYaifKnXl+0EJBE2aLL0NEHw8gPeHu+LpEdxsbklRH5nC9zm2S/FEAsGy2MTatVtWbHLjIj5Y9if/uan11BpBw41fj4j937xYVuRA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(8936002)(2616005)(26005)(83380400001)(316002)(66946007)(44832011)(8676002)(6506007)(6512007)(66476007)(6666004)(478600001)(6486002)(38100700002)(53546011)(110136005)(15650500001)(41300700001)(31696002)(36756003)(66556008)(5660300002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVljR2xZSDJtQ04yZjZLa2VMWTFHejFnaUdISWpQSmdwVE1CK01kVG9pOVJI?=
 =?utf-8?B?WlRSZWR3OC9Oc1pRRWpNbXVWTmpkTkN0blpzejNnMmgxUGRUazRxakh6Q1cz?=
 =?utf-8?B?Z3JwL0k2NVNhNHdxVFdaemJ6VG9NSFlWeXoyZUFvelZ0RVZ4dzllVXFtTVAx?=
 =?utf-8?B?a3BmNlYzeTBSS3U5NHRKeExuaDZQWGJPclRxeTQwOVZSQnNjdzE1MW5sd0o2?=
 =?utf-8?B?b09PZWw1MGNwRXdMMWhwWHMvZGIzRFpwZDd1OU56M3VBQjdwV21PYkFIMlFr?=
 =?utf-8?B?SkZMdG1LSWJ1d0tXWW9xbmlpRlArZ0NvODRZeEtTSUE5SUx1VTZHVUlYY1dT?=
 =?utf-8?B?MzJFNWFTN25KaGh0ZUxlSWV0TzgrSUJzRjhVSzh3VVUrdmFlNzJ1TkdicGpi?=
 =?utf-8?B?L095UU5FTW00OHUrajEyZ1lwU3l5aU5vYUxKUGhvZzBIZG9PSnNleDNCNTly?=
 =?utf-8?B?UUQwTzY5RDRTdkt0bFRweHEwbUNmYVVHb2lTSlNhWVV3VE1pQlkyTjJ6L2pi?=
 =?utf-8?B?RXhjRzdLajlKV3VOUEZFZWRSY1FaTnBnNTVkOWFPUkI5Zmo4ZWsrS2QxQktm?=
 =?utf-8?B?WGU2UkZzUE8wRWc2NFZudUFnZ1lwUkJYeHEwTUNsY0duOTROMzZ2OGI0Y0xD?=
 =?utf-8?B?ZzRLVE0zN2lUaUVqL0JrVGJmYzIrcTVoalh5UVlaNjB1ckFIcFZIbFNEcEZy?=
 =?utf-8?B?Q3dnbVFEOHBUTnViNERDWWpER01rNjJUSUhZbnhJVFNVaHZkYzFRNDZKbCt5?=
 =?utf-8?B?SVd6VUFZVDkxOTRtYmxVZ3F1aWRRS3dVSjcrTkFQWUo0OFNSdVA3WmR0N3BX?=
 =?utf-8?B?VzExb2JpdnZnV29TVzZwNEZQbDBIZGt3MkdSSGVSNXJCL2d5UFZzK3FtWVBu?=
 =?utf-8?B?R0NNRGo1K3BwRG1WUjJUTkwzNDJmVjNjRUtuMU1VM3BRNkVQU0hEbHpkQ3hI?=
 =?utf-8?B?UnJkSHc1ekZTOFU3eTl1UWxhQXlMOHZ0K240YUxnQytXUzNUYS9kcEo3UGZn?=
 =?utf-8?B?NnpXemtPalAzRXF4VlQvMWRhK1d5VDhmSm05ZWVBQzJTWi96WlpsYTQwS1RP?=
 =?utf-8?B?Q2dUd2ErendQeDRrTGRqei9vek5XZkRkdGtpRGJ2aGE5SThuTHMzeHNBUCtl?=
 =?utf-8?B?ay8rZkFGSTVIR3RuZkc1RlFpYytvVmdlcU1UajUxc0EvSEFJVkZpbHB3NU5B?=
 =?utf-8?B?ak1Nbm04dzF5Z0lKV0xuZXkxc3lyb09IYnF2RE5kcnNjd2NXcy9XZ3R2aXBN?=
 =?utf-8?B?LzBaVWFkczNVYW9qSjlDSUJlSW13cjBQelNnSmQrTzh1M2lYdzRWRU9PUTVw?=
 =?utf-8?B?NHlpcFBiTjA5UktZUjEzMzV2MGswbnFiUHRjNVhCcXZMMzhqaElQalc5NXRp?=
 =?utf-8?B?aFVDRkFUb3EvbDVYOGx1cDlOZWlyejg0ZjFxZWdkVFR4dVcvRmFRbWRwL2dD?=
 =?utf-8?B?b1VNZ3QwQVBXOWRiMTRUdlpmeGxhZk5Qd3JHTkxtMUdwamJhMWJYbjFnZXJr?=
 =?utf-8?B?UHVXWExmZmUxYW5sWm9CejUycFNZd21DbURTK3IrTkFFUjZJWTNGdEt5SVp5?=
 =?utf-8?B?RUdMYy84emRkd1A5bW1MNUxINTAxSGcvc0dDUWxuZmhnTWJjN2ZpLzEzY3NX?=
 =?utf-8?B?YUxMUUhwazRYbGFaTVMzZklGSG84Wm1IdlNOMk1SSlNTM3RnU3AyejhDMkZN?=
 =?utf-8?B?QkJjUExXbUNUM285OEpaanJXTjk3WnY3Q056RDRsS29XOGt3czM3VkhoTXAy?=
 =?utf-8?B?NU0yTkFPL0tvTENybU9IbG9LZWVLQlgxb2pIUG5KY0RValZkQlpLcWFOcmNB?=
 =?utf-8?B?OVZVS2x1c2RlNEJlUnpSRkk1bkpHWTAvOVJ5NDRqRGZEQno1aUExcGRSYzAv?=
 =?utf-8?B?a0xHblllRXB2M1dlV1ErN096bDRxcVBqU2F2QkNtckpCeTNVdUgrSWpOWkls?=
 =?utf-8?B?dmttQStDblZSTFBYRjFvWC9zUzNrVm45Q0NpY3Z5MTdjVUFMQTZ5bVZsNG9V?=
 =?utf-8?B?SmROVGhQWnlvN284aU1yV1hJM1A0Q1JVTEpQLzA2Ym1DUEpKUXExbU0raVRr?=
 =?utf-8?B?dExaQzhPdCsyNC9Pa3dmYXU3QzF0N1F0OVdTOTYwTW1obVRCTU1taHliUzV5?=
 =?utf-8?Q?pCyfi1zXn57mCGvEMz/V95J5V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RQodlkHC7Wxc9Au07U8Vuz/zuB3coOoHxvu3jnE3bs1S6Wjwj9AhMGYuPYEpLAULmnk/G8a1Ro3TJr+ZBQCga0jFmDmkLEto8NIrTCt5vdyvMqmMsLizWSfZln6Zx9Ut+yaeSGSpocVqZ4S5uyjpViR5L3FBotaLUs6HG/2SSPoq049jzRvN3YKO9koVSfWVP6mWVEjZXQdUrvjAv4DxjSnSLCBEgdYnMaGvdipAFNjoMaOSeODlWTlLRMZToyOsktQ+ApcXDstqvja4LgwJUhTrTcCez0VtQsYYLS+l6G9kGIWC85S22va1AjgvMFYcEY4+GZ3wKwMfYmCnGIKtlFxs10JzfHUWmkcYHxx9yqqcy7Yima9tv1McK+u0WIyynfZkxsniYlULNdOOHbSZMq8J9dE6ArKULQ6AvnJyAlbxcU1IoJKk7f6vJv0LkZa1ZR3TFZxZxg9iNqFcJhfiP988c3OPwfq8Vls8Ru8Qa+29zXFiDVJ43q5ZzESD2ED5XJZIE2xTdFByMiQSFcKD7YypORbJ3Iq1kVu/ob1Ir9LGqv5NfaYC+N/ISSL8H1D4Zx0Q0MtJvi8KjIqwGNZ111Z74xnrLfmWi0jiAypPoHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94654492-55bb-4a93-de36-08dc1f1355f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 08:38:28.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8QSBy3ClWJ8Hp17joKzB7/r+lcxXmBuAwY3A9yKBtrJ3RRBNl8CzN6GEy8SckWZJQXVbRMGfoOVuu6lehtVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270062
X-Proofpoint-ORIG-GUID: n68q3FfIaE7mJfFNLpwsTJ_jbJq9oGLd
X-Proofpoint-GUID: n68q3FfIaE7mJfFNLpwsTJ_jbJq9oGLd

On 1/25/24 05:00, Qu Wenruo wrote:
> 
> 
> On 2024/1/24 22:40, Anand Jain wrote:
>> On 1/23/24 11:49, Qu Wenruo wrote:
>>> [BUG]
>>> There is a report about reading a zstd compressed inline file extent
>>> would lead to either a VM_BUG_ON() crash, or lead to incorrect file
>>> content.
>>>
>>> [CAUSE]
>>> The root cause is a incorrect memcpy_to_page() call, which uses
>>> incorrect page offset, and can lead to either the VM_BUG_ON() as we may
>>> write beyond the page boundary, or writes into the incorrect offset of
>>> the page.
>>>
>>> [TEST CASE]
>>> The test case would:
>>>
>>> - Mount with the specified compress algorithm
>>> - Create a 4K file
>>> - Verify the 4K file is all inlined and compressed
>>> - Verify the content of the initial write
>>> - Cycle mount to drop all the page cache
>>> - Verify the content of the file again
>>> - Unmount and fsck the fs
>>>
>>> This workload would be applied to all supported compression algorithms.
>>> And it can catch the problem correctly by triggering VM_BUG_ON(), as our
>>> workload would result decompressed extent size to be 4K, and would
>>> trigger the VM_BUG_ON() 100%.
>>> And with the revert or the new fix, the test case can pass safely.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   tests/btrfs/310     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/btrfs/310.out |  2 ++
>>>   2 files changed, 83 insertions(+)
>>>   create mode 100755 tests/btrfs/310
>>>   create mode 100644 tests/btrfs/310.out
>>>
>>> diff --git a/tests/btrfs/310 b/tests/btrfs/310
>>> new file mode 100755
>>> index 00000000..b514a8bc
>>> --- /dev/null
>>> +++ b/tests/btrfs/310
>>> @@ -0,0 +1,81 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
>>> +#
>>> +# FS QA Test 310
>>> +#
>>> +# Make sure reading on an compressed inline extent is behaving 
>>> correctly
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick compress
>>> +
>>> +# Import common functions.
>>> +# . ./common/filter
>>> +
>>> +# real QA test starts here
>>> +
>>> +# Modify as appropriate.
>>> +_supported_fs btrfs
>>> +_require_scratch
>>> +
>>> +# This test require inlined compressed extents creation, and all the
>>> writes
>>> +# are designed for 4K sector size.
>>> +_require_btrfs_inline_extents_creation
>>> +_require_btrfs_support_sectorsize 4096
>>> +
>>> +_fixed_by_kernel_commit e01a83e12604 \
>>> +    "Revert \"btrfs: zstd: fix and simplify the inline extent
>>> decompression\""
>>> +
>>> +# The correct md5 for the correct 4K file filled with "0xcd"
>>> +md5sum_correct="5fed275e7617a806f94c173746a2a723"
>>> +
>>> +workload()
>>> +{
>>> +    local algo="$1"
>>> +
>>> +    echo "=== Testing compression algorithm ${algo} ===" >> 
>>> $seqres.full
>>> +    _scratch_mkfs >> $seqres.full
>>> +    _scratch_mount -o compress=${algo}
>>> +
>>> +    _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/inline_file" > /dev/null
>>
>>
>>
>>> +    result=$(_md5_checksum "$SCRATCH_MNT/inline_file")
>>> +    echo "after initial write, md5sum=${result}" >> $seqres.full
>>> +    if [ "$result" != "$md5sum_correct" ]; then
>>> +        _fail "initial write results incorrect content for \"$algo\""
>>> +    fi
>>
>> General rule of thumb is where possible use stdout and compare it with
>> the golden output.
>>
>> So something like the below shall suffice.
>>
>> echo "after initial write with alog=$algo"
>> _md5_checksum "$SCRATCH_MNT/inline_file"
>>
>> Also, helps quick debug, when  fails we have the diff.
> 
> Nope, for this particular case, golden output is not suitable.
> 

> As the workload is dependent on the support compression algorithm, we
> can not reply on golden output to cover all algorithms.

That's a fair reason not to use golden output.

Looks like you missed more comments below.

>>> +    sync
>>
>>   Generally, we need comments to explain why sync is necessary.

Needs a comment for calling sync.

>>> +
>>> +    $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline_file | tail -n 1
>>> > $tmp.fiemap
>>> +    cat $tmp.fiemap >> $seqres.full
>>> +    # Make sure we got an inlined compressed file extent.
>>> +    # 0x200 means inlined, 0x100 means not block aligned, 0x8 means
>>> encoded
>>> +    # (compressed in this case), and 0x1 means the last extent.
>>> +    if ! grep -q "0x309" $tmp.fiemap; then
>>> +        rm -f -- $tmp.fiemap
>>> +        _notrun "No compressed inline extent created, maybe subpage?"
>>
>>   workload() is called for each compress algo. If we fail
>>   for one of the algo then notrun is not a good option here.

There is no good alternative, lets keep the notrun for now.

Thanks, Anand

>>   IMO, stdout (with filters?) and comparing it with golden output
>>   is better.
>>
>>> +    fi
>>
>>
>>> +    rm -f -- $tmp.fiemap
>>> +
>>> +    # Unmount to clear the page cache.
>>> +    _scratch_cycle_mount
>>> +
>>> +    # For v6.8-rc1 without the revert or the newer fix, this can
>>> +    # crash or lead to incorrect contents for zstd.
>>> +    result=$(_md5_checksum "$SCRATCH_MNT/inline_file")
>>> +    echo "after cycle mount, md5sum=${result}" >> $seqres.full
>>> +    if [ "$result" != "$md5sum_correct" ]; then
>>> +        _fail "read for compressed inline extent failed for \"$algo\""
>>> +    fi
>>
>>   Here too, same as above, golden output to compare can be done.
>>   And remove _fail.
>>
>> Thanks, Anand
>>
>>> +    _scratch_unmount
>>> +    _check_scratch_fs
>>> +}
>>> +
>>> +algo_list=($(_btrfs_compression_algos))
>>> +for algo in ${algo_list[@]}; do
>>> +    workload $algo
>>> +done
>>> +
>>> +echo "Silence is golden"
>>> +
>>> +status=0
>>> +exit
>>> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
>>> new file mode 100644
>>> index 00000000..7b9eaf78
>>> --- /dev/null
>>> +++ b/tests/btrfs/310.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 310
>>> +Silence is golden
>>
>>


