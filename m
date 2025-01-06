Return-Path: <linux-btrfs+bounces-10730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53672A01D66
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 03:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CA83A368B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 02:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36D478F2E;
	Mon,  6 Jan 2025 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5xUBiB1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aCdr1Io3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CB184F;
	Mon,  6 Jan 2025 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736130336; cv=fail; b=R+RBl3VqOIBgDrNFOZlhWxOtqGisQrsP6K+imsBGg4gjAp4nF+zs9pm8QV+qeESX+NjJyJqsv5rdBzFgHhrtMKXTUJ/x+jZ04Ct60UWNbFs7JIslAyx/nXakwbzzsn6Mwdickt5Cq49xjzPptZMNDc9wXl/IiD3uVLpelLXOWXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736130336; c=relaxed/simple;
	bh=kwMdA3Kr/qp2UiaScMiNim4A3JjRoSUxQ3rPVSGr1i8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ETvVuPPk5YGEru6xfCoGeUjSk85cPHk5tfFMVAcYdjtBomIWzdBaMa20sul3Ai4SmzFtXj2Q87zz94PWLiKDFPFG8GTLyqHojo6dTVMJ2RmJcTIVd8YgCI00938PyypLS2xO6bKgYt0oUw4YXFq3G3d6gk2w9v67LuTCM5sdurY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5xUBiB1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aCdr1Io3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505MVwjZ001464;
	Mon, 6 Jan 2025 02:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TeP4nPRM9YT8JzXpyE/HafOKnhyyJrXUSA8VWAQCycU=; b=
	m5xUBiB1tAc2RTD9rg9zKyAKeBY2i2Oo3WVT6jiIfQJmRoMwWdrSWH55pviAQoUf
	PMTpXni3olUFby4qP+cKtdkfl8z36uvIjQWc0pBptILCOfsqT1Oe5CSuB53ciQb4
	wElTWkI6+01M/aeR9+fHv3H/+Ta7dGgoytc7GexCP/q/6M7agjgxIf1QCkxV+WXZ
	0USHTbEbjPmlWv8Vn1np9ThoqCSUtQamFTxV8M0mpbeoc9Fv7XOTUuixBmHe1GqM
	ltEntGfTkouvlflNwYczm6C6xq9l44f9tTLGmGz3qfragdXAyINciiW7oe0TjYuI
	nDFEjDXcE/IhBscp5Ppjzw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhshhgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 02:25:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50622Ik7011121;
	Mon, 6 Jan 2025 02:25:27 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue6h79a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 02:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3QPwGU9sYNpDAmGapgzyjaqQy4kUeV1qSvSlh/mUDhg8sxZjdxushDDPvW9/pwDR/UGX7m/qtnUB9wt85pjrQWofiXXTHayH+ZX/6ZpI3UFm5elJ345oBbwdvM0rtltUjXDc7lO8BjMnkA0A3JShWKUwH2jkmnStSMHdFd/60tlHXNnrMT1+3xSPpXgoHyW9flSFlS3hw4kZdZOY3PrSkdcUHD1BxSEVA27mmLQKYZ9I+3Bc4eWN2A6JFVw0AurxFGJPKlahsshxp4yMRtl3eG4jatrZKYiZ/vQW8fb1LjcgPLi93gNdsQ1bZC1blKqAP05gUIQCeMyhYTi2LShUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeP4nPRM9YT8JzXpyE/HafOKnhyyJrXUSA8VWAQCycU=;
 b=bIbV5qbxYhJqezigc9WP1Cywq/JCYUC/saLQuAPsm+P6M0bXkw/bbeDO/aLpwG4r35ecNDJGQQDPfu/DhmZsUJNpv3/j9YdrPi8miIU8pTq1XFZIhrwlh3EDM6j8Jvlgearng1+82ayDytlHewvr7uBUhHs6XWXmc8GIKHqH64tAoXIVY7rSqfY9haHOl1SadKigp6ZHtieE5qkinx9gjH1Bsu9FawRNmK8KsEFh4Z/JHaUAC7k2DZ5/IdgUFpO6Y9OzIeXfifbHRnjRSxrIkiaQXIz3rtXpp6XYv7dxtiaaI9xofh3WhmNZh6I5Ub6ZGG23zDKISz1Bom6PGHusoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeP4nPRM9YT8JzXpyE/HafOKnhyyJrXUSA8VWAQCycU=;
 b=aCdr1Io3IB+8jQJia19/Dj5yqltSi/FvFHB7q2mb5V73caWRLFeZYxHechjJm/+CDEUILi6Ciy3iBg5CwE6tg0zC78Iaucpsyt/wT/YoXqyg8iqQa5UCYCQUE6lP9Mu1XZ2jm6rlHayYOY31fb0g4DpvC15hbbC0rGr9HTyFsew=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5554.namprd10.prod.outlook.com (2603:10b6:303:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 02:25:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 02:25:20 +0000
Message-ID: <174a47bc-2ff4-455a-897d-39316352d444@oracle.com>
Date: Mon, 6 Jan 2025 07:55:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] btrfs: add test for encoded reads
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, neelx@suse.com,
        Johannes.Thumschirn@wdc.com, Josef Bacik <josef@toxicpanda.com>
References: <20241219145608.3925261-1-maharmstone@fb.com>
 <20241219145608.3925261-2-maharmstone@fb.com>
 <20250103161314.GA4067957@perftesting>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250103161314.GA4067957@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0f9610-dc27-4844-91d0-08dd2df95df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3o5VkZuZDgrS08rN1k0OUJNcWc1Nkd5clhJdnloZDRFUjNEaVFPSGR6RW5i?=
 =?utf-8?B?c3doK2lKblRRRkgrWGtjWjJmM1VQYWlLZlRhRGY3Q2RwU2Y0Y3pZeUVUdjRi?=
 =?utf-8?B?U2xjK0xxOFQ0S2VVNlZzT0ZqSThjUHVJZS8zcFZGbm4zeDNhbUVQRDE1bnp4?=
 =?utf-8?B?U3dLZUxsUjdiUklGZVA0Rk5wdkh0NVovZTcyeEdBREo0enQzZ3UwZEVrNE9u?=
 =?utf-8?B?U1A0Rkg0Tko2VkZZamE3SFBQM0ZjOVJ2THZnUW1KKzlyTy9rM0ZYcHVRYjY5?=
 =?utf-8?B?WE04bGRKOWhoMXJsUFJaZ2ZjencvRUFNSWZ4a042K3UwSVFERlpYV1ZvUXBu?=
 =?utf-8?B?K014elNwUXp0bHY3MlVOaDl2dkQ1UmxXSDluVGtwWWw4VTZhK1V4ZUlvN1Q5?=
 =?utf-8?B?cTQrdDZ1RTMzblpJVUhYZm55S2dYZ0VSd0MxNUQzdFdPUHhKOFpZbXQxMlA3?=
 =?utf-8?B?VEpXa1ZDZk9YdnMydGxncUQyWE5SYlZFZXI0SEc1ZkRPemZ2dW9zUTF1ZDF0?=
 =?utf-8?B?TEhIUnJsREMxRXVjaFV1Y0djOTg1OUFNeis3YWR1VnZ0d2tHYVlkcHNOQlFU?=
 =?utf-8?B?UzBqMFY2VE1uVVRrRFJURXc5TXZaMXFESzlmajByZDd4dVhNSzRVOVRhUzlH?=
 =?utf-8?B?SnpMZEFQVGpJeVg0bkV0WnV2a1cvUFNKYXZCQlFJU0xsaHBxSnl2TlhXN1dn?=
 =?utf-8?B?WEVrc3ZZWk1PaUc4VVUxOUVCeVpKOUc4RHByV1Jqb25PcndOSkx6ZGJQLzZY?=
 =?utf-8?B?TE9jbXgvZ2tKMjE2eXhFdG93cVMxcDJUcExXMHFMZWdOUTVvZFlCQUQ2T2t0?=
 =?utf-8?B?NzlKekNvOE5GQzJBdVZLNTR0cFZaL3ZnVHN6eXJKejJNZXJxai9VWUx4bk1B?=
 =?utf-8?B?Q1lUNXJlNndheHJVWmIvZ3BMK09qQStoQ1dNT0NRT0xTdzQ2N0NtcVF6RlVW?=
 =?utf-8?B?S0l1bnJZVVl5Y1UzaGZwTE9pbHFKN3NSSlgxcGVXcTFIVEZQRkFKY1hkcWls?=
 =?utf-8?B?KzRBTWJ6aEdRcmpYQVNzUEFRODUvalA5Q3JIWGNQY3FHdldnMGl1YVNQTzRI?=
 =?utf-8?B?eGRVM21mTCtmMnFqRHN2RFVxMWR2cUFsNnJ4YVpRZmdqZ3YwQXhBd3pFRGJZ?=
 =?utf-8?B?M2V2WWFPYTU2L250ZjExOU05bnFSSlBya2hGcnR0cUVJRndJcFNTdjZwMUU3?=
 =?utf-8?B?LzJLVUNsT25ZbGNRcTJheFN3cnBxYVJDYWF2ZFo0YllFMVo3aWdGUThXbGkr?=
 =?utf-8?B?cWs3VTRiNEQ5STJTSTg3aUhjcTcySGhXQ0srZTBlOXB2YW91dXdzbU0yS3p4?=
 =?utf-8?B?NXBIZjllMktLRG16NTArK1VBWHYvbDBra1hNZGk0Vjc5M0JlSlJLb05WbElH?=
 =?utf-8?B?bG1kbDA1R0UrclowUGFXcnFrTTh2Sll2Vmp5dGxPSzNabkQyaG1tc1FWVmtB?=
 =?utf-8?B?Z09HMS8vQVRLK3hrMWRHYzBkTVFWNE82MXJuVWxCc3A3SG1ZRkN0bnJmVnUy?=
 =?utf-8?B?N0k0eWs3SHVreG8wek15Q0NxN3NQTzJiTFNNSFlsdzB3R1Nvalp6TWZTVjdk?=
 =?utf-8?B?em5vbzJxRzJNYUVEeUtUM0dDQjgwOGttem12WFdRU0pDVFlYSnhVYVNyaENk?=
 =?utf-8?B?b0QvaG0zRVM2ZXhkYzAyME9Kcm1sbXc2OHdVVTNUSVV4cW1KQ1cySGxYSUVo?=
 =?utf-8?B?eU10aUxCTXFwYXhxcmd6REhCRGxpbWU1OHZNRXgrTFFkOE8zNm0vb21hVldu?=
 =?utf-8?B?ZjZCMzdFRXlNOVhoRWVaSk9nMHpVVWxhajFwbkhaOEJ6WW9wc3JxZndXNnpZ?=
 =?utf-8?B?UnhKUVJpeXJsK1JPSTYvTEo3T2RkUWU4NkRrM0Erb1lBbkQwWndZMmNnZElT?=
 =?utf-8?Q?gA3PTXUdlAcHI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUlPTnpucldPNGlMMnh6UENzRGJ5QUdmMHkvaVpBZmZ1S3pjUmVOSkFib2tD?=
 =?utf-8?B?SElaVWNWanBmM0NXQXRBNThYQkJFVWhWVENZaFhRRTExaEJnVVpBU01EWk52?=
 =?utf-8?B?M2J1VXdiZ2dqM295UnBYOXM0RjY4cEYxNGNXQzJMV1NrS0F0SXY3YVJxQXJB?=
 =?utf-8?B?ZnFiMUsyc0xMTENxL0w4Y0VpTlBEZEVMNzRlRjV6bG9LNFVMSmFCNDhFZ2E3?=
 =?utf-8?B?bFh3ZG1vWWVhTmhlaGlPMm56RDFla01PTWE3R29qZ2pCbFh0c29ScWhkUTg2?=
 =?utf-8?B?YjZBMVoxVEFadFNZMDhCa2NTbjR3VktaNzVBNWVNVmVsZnpzWk9rNkJGbUw2?=
 =?utf-8?B?Q0tGWVhVTnpqVVlkMko2Lzl2SHZubG8wTUlqWmVLNTRuOXphZ2M5UFd0bWVZ?=
 =?utf-8?B?Rk5TVEVUcjNuc3cwdjhLV3lGRVc3MDNNRkNDMmcxYTNNRE93T0tJcll4dG1K?=
 =?utf-8?B?TlRVcUlFa2FEQjhrWmRoTVFUQlRYT1ZpL0lEWi9SSCtZQ09NZVNmQ2NybWJW?=
 =?utf-8?B?TjRVeE1JZ2h1bUR6d21JekhxWDhGaDI0dmhOTHFvMlFJZnB6QkJkVVpvRkx5?=
 =?utf-8?B?Sys2VnQ5ZVJML213dVpUbVFkS3Yvd1lOSHJqaTVGSTQvekQ0cEJFa0ZmUm83?=
 =?utf-8?B?U1B6RmZtUWZqdjNUZ3dYUHgwYXVrMkRwK1pUTERQNEFSdUswcUxyanU1NGVY?=
 =?utf-8?B?dVV4TE9wNlR2ZXVxNHVpeFB3a1EwYmFNUWVBNFNnWEZlcDczRStUa1o2RnlK?=
 =?utf-8?B?RU1UVUdJdVNPNWs0VmJkRitrTTRGeGNqZUhRWVJ6UXp5YjlReEhzbGdsVnUx?=
 =?utf-8?B?RU1FMVVLVHlaS0hUTlJMNlhnU2xIb1Qvam51Qlo1NVNIOWNtRm1FOENDcjRr?=
 =?utf-8?B?Y29lTlVvaW9iR29ENC9EbXFIU2lXUEppbGkwVHNSandyVzZ4Tkk4NW5ySzhx?=
 =?utf-8?B?Y1hJVVMwS3BmbitpRkMwVU5OV0JRZkFtVkxQQTNSc1R3eHlpLys2RzdUZzRy?=
 =?utf-8?B?dmRCaTRQQThjSmhpREVNTEwvc0xWK3FHS09DU09hb2lHbXhCa2RzQVRNcUIv?=
 =?utf-8?B?aW83UDc0RkhQYVhVUVAyUUdjVzFIZlc2blVneUorWFNHOFhIOGpUb0tRUEdM?=
 =?utf-8?B?R2trTzR0YUkrSTZSZ0RUVlRLaGtyeWpQVFBwelFibTJQVVZMdkk2RU9CSXcy?=
 =?utf-8?B?QW5QalhXVkdTWTFCRkFibU5nY3A2WFRaeVlYaDYrZ2x0TkFZMmR3bDlPeUtL?=
 =?utf-8?B?Z1dZMEFoZEtrN2JsNHVaVUo5eC8vam5LbFYvWjg2dVJTQlJQYnllTjUveGdy?=
 =?utf-8?B?VFNrRm05VWFuZCtrUzZ1WHI0Zy83SEFlNnRxdEpJSDFBbEozeVBpMXNtZDBn?=
 =?utf-8?B?WE5VQ3hXQnRhbE9OYUF5dEFGZ2RmN1ZteUxtYU54Q1oxRmo5NEszSEU1RkpU?=
 =?utf-8?B?V210Q2x0Nzl6VTlpWlVNcXdIcE1oMC9yNXdNZlgxY0pTRmNzWGlVZWJxdmRN?=
 =?utf-8?B?VmVjSG9GVThoUXNTUWhic3VVekIvZEhhRkdDNStHRVRKSVhML3F2Ym56U1JJ?=
 =?utf-8?B?cjd5bEtudEQ5eXg4TTM4ejZYZ3N1Tk4wNHlYb2kveHMrSkVPRFR5aHNoakpp?=
 =?utf-8?B?Y21PVGpTbjRjc3FVazBNdmxWTVpVYzQ0VDRUVEpzREsrTHA0MzE5V3lTRVhQ?=
 =?utf-8?B?ZC92ZC8rcnpmL2kyTTNtVE1ZKzdHTWl1VjltekpoS09sWm5Mb214WVZya0hq?=
 =?utf-8?B?TXhLNHFtWng4VHlJYjA2RjVadUxhQ29oMDB0RWJselZqZFVqUjZGZzgybFZj?=
 =?utf-8?B?bWd5ZGZydHB4WkJKdTIySnUvYm04aTJFWEkrVTNjQTZvNHNKWEJhRGY4c1hS?=
 =?utf-8?B?YVltcjhBRDBUN2w3dWlIeUhQcEk1U1VqZGZnQ2ZMZ1p3UWwxVzJnb3pJWk84?=
 =?utf-8?B?Y21MUmRybFF0bVRBUG9TVkhVZ0Z1aXZPSnh5aFZLaFJERGFlT1J4UWcxMFA2?=
 =?utf-8?B?RmhVTzZxd2tyR0FMMkRYVnp6K2tSMnp3TTFBWmNTeGc2MVU2UnMrQllKZHBt?=
 =?utf-8?B?djQ0aWFQWi9uelRnRlRyVTlRcnVYTXhGMEpPY2tXeEF2bXFpZUNnTEpSQ3ZT?=
 =?utf-8?B?TTBsTnFNcEViVUN5eEZxRlN1UjZ4RDR2SHFXY0NKdk1SR1hjVlJtcGVBc2Ji?=
 =?utf-8?B?ak1sdUNFZXdWMWVBck5iS2lrcW10S09rVlRORzBvYWZ6TE1ndlp0eE5BVGxL?=
 =?utf-8?B?RlpxdVYxSzlGbjY0VS9ybHRKcXd3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v/35OzspxP5MdKG3vd3k/oVUfYRw3lT5QA/kPWpKOIEB+7jGtqfL8k8GPuMxVv1BHtIn6wRuKkjSIe/zw03pZK3AD32stzIbh8BbqzCi25Dp7qiLMEXjTKc7B9DiRXIYDSRTLXGoOGsdRsBGUAxtYm+FGQ70evsG886pJkWJGsdbbSaLFgxePKtRt3AeQyp9tVmsKHvt1gT6NUHS7oM3M23v0fE8uSg4cjr3JvWTd7aFmfJX93Di7znWoVQ3eaI3qQ5b1AdplkBk17cmlLbJ3P5m854VYJFFj8ClZsW/74LuFUbyhXDLhhqqRJqx9DPBmkPuvyjgTQL9dtsd6i/5GrV9e7ZwNWMsQx9VzkI69n2B6OS80f3v9KFmk+uvHYIpIh+tg9hYoFeyA0lpT5XpcZmpPlEIojG0mPl/lj2dXZ87JTEySR1N5hGPQvo9h1JzbyTWX7rQ4SrX0oRYb2JlPKPjJOIxruDFEOrlchGgETT0nVwN2l0j3PaJzhLctAUfkZfOA9GX9O1Y9p+w5f12O44gV2RqhbIhNxhMay1UXZsrRpp0Z8sy8TT2Xux1AUeKE2xMbZs9vHkcYk/IEBRm+ZiSrFx0jlGExK1eYqp5Bs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0f9610-dc27-4844-91d0-08dd2df95df1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 02:25:20.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgX4r0TXalMyWxCssnPgDhv3rhqWLNN/idrheRKCKBJR8ZjsHFJDznqJlPyp+tvsEumhz0qJVrteP3cH4TX5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501060019
X-Proofpoint-GUID: gtB3DrHuP46f6pdg58NavoEnmDd2hkZq
X-Proofpoint-ORIG-GUID: gtB3DrHuP46f6pdg58NavoEnmDd2hkZq


Mark,

   Sorry, missed this after returning from OOO.
   Along with Josef's suggested, some minor things to fix...below..

On 3/1/25 21:43, Josef Bacik wrote:
> On Thu, Dec 19, 2024 at 02:55:56PM +0000, Mark Harmstone wrote:
>> Add btrfs/333 and its helper programs btrfs_encoded_read and
>> btrfs_encoded_write, in order to test encoded reads.
>>
>> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
>> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
>> that it matches what we've written. If the new io_uring interface for
>> encoded reads is supported, we also check that that matches the ioctl.
>>
>> Note that what we write isn't valid compressed data, so any non-encoded
>> reads on these files will fail.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>> This should now work on systems with old versions of liburing, and
>> systems with old versions of the btrfs.h header.
>>
>> I've also included Daniel Vacek's suggestions for reducing the amount of
>> time spent doing dd.
>>
>>   .gitignore                |   2 +
>>   m4/package_liburing.m4    |   2 +
>>   src/Makefile              |   3 +-
>>   src/btrfs_encoded_read.c  | 203 +++++++++++++++++++++++++++++++++
>>   src/btrfs_encoded_write.c | 234 ++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/333           | 220 +++++++++++++++++++++++++++++++++++
>>   tests/btrfs/333.out       |   2 +
>>   7 files changed, 665 insertions(+), 1 deletion(-)
>>   create mode 100644 src/btrfs_encoded_read.c
>>   create mode 100644 src/btrfs_encoded_write.c
>>   create mode 100755 tests/btrfs/333
>>   create mode 100644 tests/btrfs/333.out
>>
>> diff --git a/.gitignore b/.gitignore
>> index f16173d9..efd47773 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -62,6 +62,8 @@ tags
>>   /src/attr_replace_test
>>   /src/attr-list-by-handle-cursor-test
>>   /src/bstat
>> +/src/btrfs_encoded_read
>> +/src/btrfs_encoded_write
>>   /src/bulkstat_null_ocount
>>   /src/bulkstat_unlink_test
>>   /src/bulkstat_unlink_test_modified
>> diff --git a/m4/package_liburing.m4 b/m4/package_liburing.m4
>> index 0553966d..7fbf4a5f 100644
>> --- a/m4/package_liburing.m4
>> +++ b/m4/package_liburing.m4
>> @@ -1,6 +1,8 @@
>>   AC_DEFUN([AC_PACKAGE_WANT_URING],
>>     [ PKG_CHECK_MODULES([LIBURING], [liburing],
>>       [ AC_DEFINE([HAVE_LIBURING], [1], [Use liburing])
>> +      AC_DEFINE_UNQUOTED([LIBURING_MAJOR_VERSION], [`$PKG_CONFIG --modversion liburing | cut -d. -f1`], [liburing major version])
>> +      AC_DEFINE_UNQUOTED([LIBURING_MINOR_VERSION], [`$PKG_CONFIG --modversion liburing | cut -d. -f2`], [liburing minor version])
>>         have_uring=true
>>       ],
>>       [ have_uring=false ])
>> diff --git a/src/Makefile b/src/Makefile
>> index a0396332..b42b8147 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -34,7 +34,8 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>   	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>>   	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>>   	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>> -	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment
>> +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
>> +	btrfs_encoded_read btrfs_encoded_write
>>   
>>   EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>>   	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
>> diff --git a/src/btrfs_encoded_read.c b/src/btrfs_encoded_read.c
>> new file mode 100644
>> index 00000000..2e4079b0
>> --- /dev/null
>> +++ b/src/btrfs_encoded_read.c
>> @@ -0,0 +1,203 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) Meta Platforms, Inc. and affiliates.
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <sys/uio.h>
>> +#include <sys/ioctl.h>
>> +#include <linux/btrfs.h>
>> +#include "config.h"
>> +
>> +#ifdef HAVE_LIBURING
>> +#include <liburing.h>
>> +#endif
>> +
>> +/* IORING_OP_URING_CMD defined from liburing 2.2 onwards */
>> +#if defined(HAVE_LIBURING) && (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 2))
>> +#define IORING_OP_URING_CMD 46
>> +#endif
>> +
>> +#ifndef BTRFS_IOC_ENCODED_READ
>> +struct btrfs_ioctl_encoded_io_args {
>> +	const struct iovec *iov;
>> +	unsigned long iovcnt;
>> +	__s64 offset;
>> +	__u64 flags;
>> +	__u64 len;
>> +	__u64 unencoded_len;
>> +	__u64 unencoded_offset;
>> +	__u32 compression;
>> +	__u32 encryption;
>> +	__u8 reserved[64];
>> +};
>> +
>> +#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, struct btrfs_ioctl_encoded_io_args)
>> +#endif
>> +
>> +#define BTRFS_MAX_COMPRESSED 131072
>> +#define QUEUE_DEPTH 1
>> +
>> +static int encoded_read_ioctl(const char *filename, long long offset)
>> +{
>> +	int ret, fd;
>> +	char buf[BTRFS_MAX_COMPRESSED];
>> +	struct iovec iov;
>> +	struct btrfs_ioctl_encoded_io_args enc;
>> +
>> +	fd = open(filename, O_RDONLY);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "open failed for %s\n", filename);
>> +		return 1;
>> +	}
>> +
>> +	iov.iov_base = buf;
>> +	iov.iov_len = sizeof(buf);
>> +
>> +	enc.iov = &iov;
>> +	enc.iovcnt = 1;
>> +	enc.offset = offset;
>> +	enc.flags = 0;
>> +
>> +	ret = ioctl(fd, BTRFS_IOC_ENCODED_READ, &enc);
>> +
>> +	if (ret < 0) {
>> +		printf("%i\n", -errno);
>> +		close(fd);
>> +		return 0;
>> +	}
>> +
>> +	close(fd);
>> +
>> +	printf("%i\n", ret);
>> +	printf("%llu\n", enc.len);
>> +	printf("%llu\n", enc.unencoded_len);
>> +	printf("%llu\n", enc.unencoded_offset);
>> +	printf("%u\n", enc.compression);
>> +	printf("%u\n", enc.encryption);
>> +
>> +	fwrite(buf, ret, 1, stdout);
>> +
>> +	return 0;
>> +}
>> +
>> +static int encoded_read_io_uring(const char *filename, long long offset)
>> +{
>> +#ifdef HAVE_LIBURING
> 
> Instead of doing this, add
> 
> ifeq ($(HAVE_LIBURING),true)
> LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write
> endif
> 
> and then in your test you add
> 
> _require_command src/btrfs_encoded_read
> _require_command src/btrfs_encoded_write
> 
> And then you can remove all this extra code to check for liburing.
> 
>> +	int ret, fd;
>> +	char buf[BTRFS_MAX_COMPRESSED];
>> +	struct iovec iov;
>> +	struct btrfs_ioctl_encoded_io_args enc;
>> +	struct io_uring ring;
>> +	struct io_uring_sqe *sqe;
>> +	struct io_uring_cqe *cqe;
>> +
>> +	io_uring_queue_init(QUEUE_DEPTH, &ring, 0);
>> +
>> +	fd = open(filename, O_RDONLY);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "open failed for %s\n", filename);
>> +		ret = 1;
>> +		goto out_uring;
>> +	}
>> +
>> +	iov.iov_base = buf;
>> +	iov.iov_len = sizeof(buf);
>> +
>> +	enc.iov = &iov;
>> +	enc.iovcnt = 1;
>> +	enc.offset = offset;
>> +	enc.flags = 0;
>> +
>> +	sqe = io_uring_get_sqe(&ring);
>> +	if (!sqe) {
>> +		fprintf(stderr, "io_uring_get_sqe failed\n");
>> +		ret = 1;
>> +		goto out_close;
>> +	}
>> +
>> +	io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc, sizeof(enc), 0);
>> +
>> +	/* sqe->cmd_op union'd to sqe->off from liburing 2.3 onwards */
>> +#if (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 3))
>> +	sqe->off = BTRFS_IOC_ENCODED_READ;
>> +#else
>> +	sqe->cmd_op = BTRFS_IOC_ENCODED_READ;
>> +#endif
>> +
>> +	io_uring_submit(&ring);
>> +
>> +	ret = io_uring_wait_cqe(&ring, &cqe);
>> +	if (ret < 0) {
>> +		fprintf(stderr, "io_uring_wait_cqe returned %i\n", ret);
>> +		ret = 1;
>> +		goto out_close;
>> +	}
>> +
>> +	io_uring_cqe_seen(&ring, cqe);
>> +
>> +	if (cqe->res < 0) {
>> +		printf("%i\n", cqe->res);
>> +		ret = 0;
>> +		goto out_close;
>> +	}
>> +
>> +	printf("%i\n", cqe->res);
>> +	printf("%llu\n", enc.len);
>> +	printf("%llu\n", enc.unencoded_len);
>> +	printf("%llu\n", enc.unencoded_offset);
>> +	printf("%u\n", enc.compression);
>> +	printf("%u\n", enc.encryption);
>> +
>> +	fwrite(buf, cqe->res, 1, stdout);
>> +
>> +	ret = 0;
>> +
>> +out_close:
>> +	close(fd);
>> +
>> +out_uring:
>> +	io_uring_queue_exit(&ring);
>> +
>> +	return ret;
>> +#else
>> +	fprintf(stderr, "liburing not linked in\n");
>> +	return 1;
>> +#endif
>> +}
>> +
>> +static void usage()
>> +{
>> +	fprintf(stderr, "Usage: btrfs_encoded_read ioctl|io_uring filename offset\n");
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	const char *filename;
>> +	long long offset;
>> +
>> +	if (argc != 4) {
>> +		usage();
>> +		return 1;
>> +	}
>> +
>> +	filename = argv[2];
>> +
>> +	offset = atoll(argv[3]);
>> +	if (offset == 0 && errno != 0) {
>> +		usage();
>> +		return 1;
>> +	}
>> +
>> +	if (!strcmp(argv[1], "ioctl")) {
>> +		return encoded_read_ioctl(filename, offset);
>> +	} else if (!strcmp(argv[1], "io_uring")) {
>> +		return encoded_read_io_uring(filename, offset);
>> +	} else {
>> +		usage();
>> +		return 1;
>> +	}
>> +}
>> diff --git a/src/btrfs_encoded_write.c b/src/btrfs_encoded_write.c
>> new file mode 100644
>> index 00000000..1b063fa1
>> --- /dev/null
>> +++ b/src/btrfs_encoded_write.c
>> @@ -0,0 +1,234 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) Meta Platforms, Inc. and affiliates.
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <sys/uio.h>
>> +#include <sys/ioctl.h>
>> +#include <linux/btrfs.h>
>> +#include "config.h"
>> +
>> +#ifdef HAVE_LIBURING
>> +#include <liburing.h>
>> +#endif
>> +
>> +/* IORING_OP_URING_CMD defined from liburing 2.2 onwards */
>> +#if defined(HAVE_LIBURING) && (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 2))
>> +#define IORING_OP_URING_CMD 46
>> +#endif
>> +
>> +#ifndef BTRFS_IOC_ENCODED_WRITE
>> +struct btrfs_ioctl_encoded_io_args {
>> +	const struct iovec *iov;
>> +	unsigned long iovcnt;
>> +	__s64 offset;
>> +	__u64 flags;
>> +	__u64 len;
>> +	__u64 unencoded_len;
>> +	__u64 unencoded_offset;
>> +	__u32 compression;
>> +	__u32 encryption;
>> +	__u8 reserved[64];
>> +};
>> +
>> +#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, struct btrfs_ioctl_encoded_io_args)
>> +#endif
>> +
>> +#define BTRFS_MAX_COMPRESSED 131072
>> +#define QUEUE_DEPTH 1
>> +
>> +static int encoded_write_ioctl(const char *filename, long long offset,
>> +			       long long len, long long unencoded_len,
>> +			       long long unencoded_offset, int compression,
>> +			       char *buf, size_t size)
>> +{
>> +	int ret, fd;
>> +	struct iovec iov;
>> +	struct btrfs_ioctl_encoded_io_args enc;
>> +
>> +	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0644);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "open failed for %s\n", filename);
>> +		return 1;
>> +	}
>> +
>> +	iov.iov_base = buf;
>> +	iov.iov_len = size;
>> +
>> +	memset(&enc, 0, sizeof(enc));
>> +	enc.iov = &iov;
>> +	enc.iovcnt = 1;
>> +	enc.offset = offset;
>> +	enc.len = len;
>> +	enc.unencoded_len = unencoded_len;
>> +	enc.unencoded_offset = unencoded_offset;
>> +	enc.compression = compression;
>> +
>> +	ret = ioctl(fd, BTRFS_IOC_ENCODED_WRITE, &enc);
>> +
>> +	if (ret < 0) {
>> +		printf("%i\n", -errno);
>> +		close(fd);
>> +		return 0;
>> +	}
>> +
>> +	printf("%i\n", ret);
>> +
>> +	close(fd);
>> +
>> +	return 0;
>> +}
>> +
>> +static int encoded_write_io_uring(const char *filename, long long offset,
>> +				  long long len, long long unencoded_len,
>> +				  long long unencoded_offset, int compression,
>> +				  char *buf, size_t size)
>> +{
>> +#ifdef HAVE_LIBURING
>> +	int ret, fd;
>> +	struct iovec iov;
>> +	struct btrfs_ioctl_encoded_io_args enc;
>> +	struct io_uring ring;
>> +	struct io_uring_sqe *sqe;
>> +	struct io_uring_cqe *cqe;
>> +
>> +	io_uring_queue_init(QUEUE_DEPTH, &ring, 0);
>> +
>> +	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0644);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "open failed for %s\n", filename);
>> +		ret = 1;
>> +		goto out_uring;
>> +	}
>> +
>> +	iov.iov_base = buf;
>> +	iov.iov_len = size;
>> +
>> +	memset(&enc, 0, sizeof(enc));
>> +	enc.iov = &iov;
>> +	enc.iovcnt = 1;
>> +	enc.offset = offset;
>> +	enc.len = len;
>> +	enc.unencoded_len = unencoded_len;
>> +	enc.unencoded_offset = unencoded_offset;
>> +	enc.compression = compression;
>> +
>> +	sqe = io_uring_get_sqe(&ring);
>> +	if (!sqe) {
>> +		fprintf(stderr, "io_uring_get_sqe failed\n");
>> +		ret = 1;
>> +		goto out_close;
>> +	}
>> +
>> +	io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc, sizeof(enc), 0);
>> +
>> +	/* sqe->cmd_op union'd to sqe->off from liburing 2.3 onwards */
>> +#if (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 3))
>> +	sqe->off = BTRFS_IOC_ENCODED_WRITE;
>> +#else
>> +	sqe->cmd_op = BTRFS_IOC_ENCODED_WRITE;
>> +#endif
>> +
>> +	io_uring_submit(&ring);
>> +
>> +	ret = io_uring_wait_cqe(&ring, &cqe);
>> +	if (ret < 0) {
>> +		fprintf(stderr, "io_uring_wait_cqe returned %i\n", ret);
>> +		ret = 1;
>> +		goto out_close;
>> +	}
>> +
>> +	io_uring_cqe_seen(&ring, cqe);
>> +
>> +	if (cqe->res < 0) {
>> +		printf("%i\n", cqe->res);
>> +		ret = 0;
>> +		goto out_close;
>> +	}
>> +
>> +	printf("%i\n", cqe->res);
>> +
>> +	ret = 0;
>> +
>> +out_close:
>> +	close(fd);
>> +
>> +out_uring:
>> +	io_uring_queue_exit(&ring);
>> +
>> +	return ret;
>> +#else
>> +	fprintf(stderr, "liburing not linked in\n");
>> +	return 1;
>> +#endif
>> +}
>> +
>> +static void usage()
>> +{
>> +	fprintf(stderr, "Usage: btrfs_encoded_write ioctl|io_uring filename offset len unencoded_len unencoded_offset compression\n");
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	const char *filename;
>> +	long long offset, len, unencoded_len, unencoded_offset;
>> +	int compression;
>> +	char buf[BTRFS_MAX_COMPRESSED];
>> +	size_t size;
>> +
>> +	if (argc != 8) {
>> +		usage();
>> +		return 1;
>> +	}
>> +
>> +	filename = argv[2];
>> +
>> +	offset = atoll(argv[3]);
>> +	if (offset == 0 && errno != 0) {
>> +		usage();
>> +		return 1;
>> +	}
>> +
>> +	len = atoll(argv[4]);
>> +	if (len == 0 && errno != 0) {
>> +		usage();
>> +		return 1;
>> +	}
>> +
>> +	unencoded_len = atoll(argv[5]);
>> +	if (unencoded_len == 0 && errno != 0) {
>> +		usage();
>> +		return 1;
>> +	}
>> +
>> +	unencoded_offset = atoll(argv[6]);
>> +	if (unencoded_offset == 0 && errno != 0) {
>> +		usage();
>> +		return 1;
>> +	}
>> +
>> +	compression = atoi(argv[7]);
>> +	if (compression == 0 && errno != 0) {
>> +		usage();
>> +		return 1;
>> +	}
>> +
>> +	size = fread(buf, 1, BTRFS_MAX_COMPRESSED, stdin);
>> +
>> +	if (!strcmp(argv[1], "ioctl")) {
>> +		return encoded_write_ioctl(filename, offset, len, unencoded_len,
>> +					   unencoded_offset, compression, buf,
>> +					   size);
>> +	} else if (!strcmp(argv[1], "io_uring")) {
>> +		return encoded_write_io_uring(filename, offset, len,
>> +					      unencoded_len, unencoded_offset,
>> +					      compression, buf, size);
>> +	} else {
>> +		usage();
>> +		return 1;
>> +	}
>> +}
>> diff --git a/tests/btrfs/333 b/tests/btrfs/333
>> new file mode 100755
>> index 00000000..d7fbb7c7
>> --- /dev/null
>> +++ b/tests/btrfs/333
>> @@ -0,0 +1,220 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
>> +#
>> +# FS QA Test No. btrfs/333
>> +#
>> +# Test btrfs encoded reads
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick compress rw
>> +
>> +. ./common/filter
>> +. ./common/btrfs
>> +
>> +_supported_fs btrfs
>> +
>> +do_encoded_read() {

Here and at other functions too,
Please fix the code style for consistency and make it easier to navigate
with Vim's default helper keys.

do_encoded_read()
{


>> +    local fn=$1
>> +    local type=$2
>> +    local exp_ret=$3
>> +    local exp_len=$4
>> +    local exp_unencoded_len=$5
>> +    local exp_unencoded_offset=$6
>> +    local exp_compression=$7
>> +    local exp_md5=$8
>> +
>> +    local tmpfile=`mktemp`
>> +
>> +    echo "running btrfs_encoded_read $type $fn 0 > $tmpfile" >>$seqres.full
>> +    src/btrfs_encoded_read $type $fn 0 > $tmpfile
>> +
>> +    if [[ $? -ne 0 ]]; then
>> +        echo "btrfs_encoded_read failed" >>$seqres.full
>> +        rm $tmpfile
>> +        return 1
>> +    fi
>> +
>> +    exec {FD}< $tmpfile
>> +
>> +    read -u ${FD} ret
>> +
>> +    if [[ $ret == -95 && $type -eq "io_uring" ]]; then
>> +        echo "btrfs io_uring encoded read failed with -EOPNOTSUPP, skipping" >>$seqres.full
>> +        exec {FD}<&-
>> +        return 1
>> +    fi
>> +
>> +    if [[ $ret -lt 0 ]]; then
>> +        if [[ $ret == -1 ]]; then
>> +            echo "btrfs encoded read failed with -EPERM; are you running as root?" >>$seqres.full
>> +        else
>> +            echo "btrfs encoded read failed (errno $ret)" >>$seqres.full
>> +        fi
>> +        exec {FD}<&-
>> +        return 1
>> +    fi
> 
> This should probably be moved to common/btrfs with a
> 
> _require_btrfs_iouring_encoded_ops
> 
> or something like that.
> 
>> +
>> +    local status=0
>> +
>> +    if [[ $ret -ne $exp_ret ]]; then
>> +        echo "$fn: btrfs encoded read returned $ret, expected $exp_ret" >>$seqres.full
>> +        status=1
>> +    fi
>> +
>> +    read -u ${FD} len
>> +    read -u ${FD} unencoded_len
>> +    read -u ${FD} unencoded_offset
>> +    read -u ${FD} compression
>> +    read -u ${FD} encryption
>> +
>> +    local filesize=`stat -c%s $tmpfile`
>> +    local datafile=`mktemp`
>> +
>> +    tail -c +$((1+$filesize-$ret)) $tmpfile > $datafile
>> +
>> +    exec {FD}<&-
>> +    rm $tmpfile
>> +
>> +    local md5=`md5sum $datafile | cut -d ' ' -f 1`
>> +    rm $datafile
>> +
>> +    if [[ $len -ne $exp_len ]]; then
>> +        echo "$fn: btrfs encoded read had len of $len, expected $exp_len" >>$seqres.full
>> +        status=1
>> +    fi
>> +
>> +    if [[ $unencoded_len -ne $exp_unencoded_len ]]; then
>> +        echo "$fn: btrfs encoded read had unencoded_len of $unencoded_len, expected $exp_unencoded_len" >>$seqres.full
>> +        status=1
>> +    fi
>> +

Here and at other lines too, it’s fine for strings to be longer than
80 characters, but try to align them to 80 if possible. If there’s
an operation, the line can break to the next one.

	if [[ $unencoded_len -ne $exp_unencoded_len ]]; then
echo "$fn: btrfs encoded read had unencoded_len of $unencoded_len, 
expected $exp_unencoded_len" >> \
	$seqres.full

	fi

>> +    if [[ $unencoded_offset -ne $exp_unencoded_offset ]]; then
>> +        echo "$fn: btrfs encoded read had unencoded_offset of $unencoded_offset, expected $exp_unencoded_offset" >>$seqres.full
>> +        status=1
>> +    fi
>> +
>> +    if [[ $compression -ne $exp_compression ]]; then
>> +        echo "$fn: btrfs encoded read had compression of $compression, expected $exp_compression" >>$seqres.full
>> +        status=1
>> +    fi
>> +
>> +    if [[ $encryption -ne 0 ]]; then
>> +        echo "$fn: btrfs encoded read had encryption of $encryption, expected 0" >>$seqres.full
>> +        status=1
>> +    fi
>> +
>> +    if [[ $md5 != $exp_md5 ]]; then
>> +        echo "$fn: data returned had hash of $md5, expected $exp_md5" >>$seqres.full
>> +        status=1
>> +    fi
>> +
>> +    return $status
>> +}
>> +
>> +do_encoded_write() {
>> +    local fn=$1
>> +    local exp_ret=$2
>> +    local len=$3
>> +    local unencoded_len=$4
>> +    local unencoded_offset=$5
>> +    local compression=$6
>> +    local data_file=$7
>> +
>> +    local tmpfile=`mktemp`
>> +
>> +    echo "running btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $unencoded_offset $compression < $data_file > $tmpfile" >>$seqres.full
>> +    src/btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $unencoded_offset $compression < $data_file > $tmpfile
>> +
>> +    if [[ $? -ne 0 ]]; then
>> +        echo "btrfs_encoded_write failed" >>$seqres.full
>> +        rm $tmpfile
>> +        return 1
>> +    fi
>> +
>> +    exec {FD}< $tmpfile
>> +
>> +    read -u ${FD} ret
>> +
>> +    if [[ $ret -lt 0 ]]; then
>> +        if [[ $ret == -1 ]]; then
>> +            echo "btrfs encoded write failed with -EPERM; are you running as root?" >>$seqres.full
>> +        else
>> +            echo "btrfs encoded write failed (errno $ret)" >>$seqres.full
>> +        fi
>> +        exec {FD}<&-
>> +        return 1
>> +    fi
>> +
>> +    exec {FD}<&-
>> +    rm $tmpfile
>> +
>> +    return 0
>> +}
>> +
>> +test_file() {
>> +    local size=$1
>> +    local len=$2
>> +    local unencoded_len=$3
>> +    local unencoded_offset=$4
>> +    local compression=$5
>> +
>> +    local tmpfile=`mktemp -p $SCRATCH_MNT`
>> +    local randfile=`mktemp`
>> +
>> +    dd if=/dev/urandom of=$randfile bs=$size count=1 status=none
>> +    local md5=`md5sum $randfile | cut -d ' ' -f 1`
>> +
>> +    do_encoded_write $tmpfile $size $len $unencoded_len $unencoded_offset \
>> +        $compression $randfile || _fail "encoded write ioctl failed"
>> +
>> +    rm $randfile
>> +
>> +    do_encoded_read $tmpfile ioctl $size $len $unencoded_len \
>> +        $unencoded_offset $compression $md5 || _fail "encoded read ioctl failed"
>> +    do_encoded_read $tmpfile io_uring $size $len $unencoded_len \
>> +        $unencoded_offset $compression $md5 || _fail "encoded read io_uring failed"
>> +
>> +    rm $tmpfile
>> +}
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>> +sector_size=$(_scratch_btrfs_sectorsize)
>> +
>> +if [[ $sector_size -ne 4096 && $sector_size -ne 65536 ]]; then
>> +    _notrun "sector size $sector_size not supported by this test"
>> +fi
>> +

_require_btrfs_support_sectorsize <xx>


>> +_scratch_mount "-o max_inline=2048"

Pls add a comment the need to enfore, default is already 2048.
If you want to overwrite the config option could you pls add
the reason in the comments.


Thx.


>> +
>> +if [[ $sector_size -eq 4096 ]]; then
>> +    test_file 40960 97966 98304 0 1 # zlib
>> +    test_file 40960 97966 98304 0 2 # zstd
>> +    test_file 40960 97966 98304 0 3 # lzo 4k
>> +    test_file 40960 97966 110592 4096 1 # bookended zlib
>> +    test_file 40960 97966 110592 4096 2 # bookended zstd
>> +    test_file 40960 97966 110592 4096 3 # bookended lzo 4k
>> +elif [[ $sector_size -eq 65536 ]]; then
>> +    test_file 65536 97966 131072 0 1 # zlib
>> +    test_file 65536 97966 131072 0 2 # zstd
>> +    test_file 65536 97966 131072 0 7 # lzo 64k
>> +    # can't test bookended extents on 64k, as max is only 2 sectors long
>> +fi
>> +
>> +# btrfs won't create inline files unless PAGE_SIZE == sector size
>> +if [[ "$(_get_page_size)" -eq $sector_size ]]; then
>> +    test_file 892 1931 1931 0 1 # inline zlib
>> +    test_file 892 1931 1931 0 2 # inline zstd
>> +
>> +    if [[ $sector_size -eq 4096 ]]; then
>> +        test_file 892 1931 1931 0 3 # inline lzo 4k
>> +    elif [[ $sector_size -eq 65536 ]]; then
>> +        test_file 892 1931 1931 0 7 # inline lzo 64k
>> +    fi
>> +fi
>> +
>> +_scratch_unmount
> 
> You don't have to do this, the common stuff will do it for you.  Thanks,
> 
> Josef


