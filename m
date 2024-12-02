Return-Path: <linux-btrfs+bounces-10000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C29DFF0F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 11:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F4AB240F6
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837501FC7EE;
	Mon,  2 Dec 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ezkVn216";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nG8XaOoP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64D1FA854;
	Mon,  2 Dec 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135691; cv=fail; b=F0oXjXcjEEkFP1yPebr9EMJK40uWN4Q+7VZMUHtrf/klDSdmAMns21MuoXGp1kmaV8tUtqbJiAt9G4Ofk+0xhnHrceQGHcUHgQ+w+VvA9NBeh3n8WV5SIR5T1nfZV1lQI/cUngq2wxgA4Ho6GF7MZ3QaBOZKZAzQc31bM2ZiyAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135691; c=relaxed/simple;
	bh=tGkv9rkCT+a+wyPY5RZMYBSqCD2nlTQmZaSsvF/CrGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L4nSVUAB82HBcG00CPafe+cq5zwoYPhulskPoAh+NbjQ9b77OxfHKv/0ODBxuCjJW6wJMN09JtbhclbRfmXKjGGEulI6AAGRGE8uZdcE3DuNK259QVrOz2AIk4PEsk6WfpHPZ2xJs/RdYsmoESX2OSz8Ds4+pIfvKUyAdnX4a8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ezkVn216; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nG8XaOoP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WwOc024804;
	Mon, 2 Dec 2024 10:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mRf4JEowQNQSBejioTcaK/RikZaTx+Jwe6HaoDj+F9Y=; b=
	ezkVn216AKuupiWuYD0sq8cl4EofPtGXQ+2E7YS6g9L7oVYIcAtuC2c8gPWkyuq6
	/v8yEPn4QuCAtuMJ2jw9iWrM5oKpaed6wt8jZ5DqhkOS8/BO7vM6ol4yE4jgavay
	fNhntSCIzEtZD769YcymEtxuoWYeXMC3MogaXN4sEh2zyhJW02q+ravSxEkpjchZ
	7k4xTSAILYLnIN0ii0mHR9qxjy3hRuReahy16qT/mFYv8HLe9JvX6vBq4psW8iBL
	kP5dYRdMMYhXOSWfvFwnu+kOlgMIWjfhX+hMNYXn0PtPuiD2vef7IRsKqXin7WqI
	UYD+CSRTMDKkqatuIz42BQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg22mpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:34:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B29M31x039091;
	Mon, 2 Dec 2024 10:34:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s56cxet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oel1O/DCwAQIWYimW3yyDrEGIZ2e5u1NWWU+tNUVj9KZqeV7hMv6INtRWWbH2QdzVLPejqWBnFNc5qwuDeAYMzS0AjOOmv740t0llDq7meyjccRWenRkPQItGhOBqpKlY0LfF7NJFFiv23PQ28wB8yPMgNua4Mm9Mx+OKkcewz4zLOg+LOImrSzcbfiyXgjh8DUbxckaawBJznLtVzE4mrHcbFFgr3covdJ8Sc0Bcpdn7DgaatvOCLUpYinj7UTuFw81Oe1OXMc+QorMwxbm5+ejttCtj9W4Ywfm1qjlKkW2ehnzAn0cmQShWbUMEcElcjwpURtgBlboLAPpW80XGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRf4JEowQNQSBejioTcaK/RikZaTx+Jwe6HaoDj+F9Y=;
 b=duFFbMGz0VAddD4PuRzL3ai6dZ2rqYDVT8Jlh274yiRFEIzcstxWNuNFDs7ZnmHwZ9iYst3DRNhFi7t6hpHikc+XpJuuV+JcEafHlQmW1c3RTijRRWmkMxrrbkBiBpz0uRwP7vA4MLQtc+BaebW9vj+3StMIHPXDXytzfMFjzf+5UHA/S6LfOtk3HJ7f6Y0srxm8aPEedYMS3yod87S9pTZEN0MYxf1eKesGpa47juQQbUCphwF8N+WyE9nZ++403Kp/eZ552NYa8WYZc6bKU7/7ejZgH5jGygoo0D2/6mAmU+p9Cj2ZneGwRh3ZjOS8dW1FwJaDe+t/rGJ7kizKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRf4JEowQNQSBejioTcaK/RikZaTx+Jwe6HaoDj+F9Y=;
 b=nG8XaOoPx043L7koEyFSxEeQp1RzgXnn3/cHF9MkYNql6Svm5bRm87QQlnZRt24NtyRzwr5ctBY6DL3QUO8sqMlLpjCzLPEpxNzXsmaLcxfghH5UlvpH2F7NZfNc4J3OqTK6cK+71YehxEJxZWB+tT286+W2gsZ7Hc1i0TeCJXc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6199.namprd10.prod.outlook.com (2603:10b6:8:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 10:34:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 10:34:39 +0000
Message-ID: <a7421c2f-0ea2-4b0d-b159-3121f1a17644@oracle.com>
Date: Mon, 2 Dec 2024 10:34:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: handle bio_split() error
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241104121318.16784-1-jth@kernel.org>
 <9eec1ccb-6e56-4701-83bf-3397d1bc5197@oracle.com>
 <d892421f-3ecb-428a-b65e-4f0d0f5f08fe@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d892421f-3ecb-428a-b65e-4f0d0f5f08fe@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0630.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e7b361-b66e-415e-14f0-08dd12bcec7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTY3L1dYTGZNUWRpeGp2YkF6VzNpUWdwR1VjZlgyU3VwWVE2VVZuR1NnWkxC?=
 =?utf-8?B?aUhObGZIaC9QbVhnOGx2THg0VUpUSGg5a1gxbkJ3SXRrMGxxNEJJKzRmY1hZ?=
 =?utf-8?B?WGpzQ3ltNTV0eEVnNC9mdTJrUEdNeXF4T3l5VldqM1lxdGE4UnNHeTVIVTRO?=
 =?utf-8?B?c2Q0ZnluVHZ5T2JUaDFjSldwOWNNN1FRbWtnU0gzc0doZThsVk5mN2xFMXIw?=
 =?utf-8?B?bzRiS0YxNnVjOE5EV1ZxNEIzdG5GY0VmT0lSNGNaK1FRamVJbmZ2QlRhTlZl?=
 =?utf-8?B?cTgxOUNJS1FIWEhLWm1GS05qYVA4WVNORkVuYlRqYWZGd2s4U0RzdjZ3WUor?=
 =?utf-8?B?L09CWS9uTERWblNROEE2MzVWeERYZWRiVzZYdnVwRUgwTkZZUUJoNzlMeld6?=
 =?utf-8?B?ZE5VR3E2UHVFOUV0dDlZbExtSGlvQitkdWtYUjFraDJRY1lqT0xSNXhVTzdM?=
 =?utf-8?B?N0g5Z0pwdnFRNmpScEo0akRDaTAwK1BxZWRRTHNYb2dTMmpxNUwwRldOQTNO?=
 =?utf-8?B?R24xVlVOQldXMXR3aVlOZDVUc3R0L1lEN0lTc1dNSDEvOVF6elo0ZzFucFlq?=
 =?utf-8?B?bUprNWNKYnRXSytidW1nWGVKLzg0aVpLQUs5YXVweTNHamdUTDhOZ2duT3Ex?=
 =?utf-8?B?QmJHTWdjaWcxLzc1N1FRVHFBeVVldmZaSU8xR3ZjRXRMam9WeE16eHZUVDBv?=
 =?utf-8?B?QUJqQUR0QW4yZGdRY1dYVlUrL1JRektMSlY3dGFmVEVjdWduMmwraHFuUlZQ?=
 =?utf-8?B?N3liU1JPSHZVYS84ZXhwMzhoZEVKRWl4MGU3OWhFS3JlZzU2WkpFUzFrS1h4?=
 =?utf-8?B?bWlNSERCaU5jL3VlUWl1MHIzcDJXbUhVN2paV3p2NXhxcXJSaW9ka25OTC9J?=
 =?utf-8?B?d29xTkNqb1FoaytIL045LzA0M0Fjb3Fwd1NkSnhYV05weDdlcDN2OVRLRHV0?=
 =?utf-8?B?OEp2QmZNdDRmMm9tUDlycU51VURxOWVBQWxzNE5qQmhoa0IvaEtuU1JER1B2?=
 =?utf-8?B?UDlZRm1IQXNsNFBSZmFUTFlBZGVLdis5d1NFNVR2M01BMFNmNG9ML0VFWnRl?=
 =?utf-8?B?SGtaWHhBOHZGZkJobHE0TTB1ZTNwZmNKV3MxVVVMWmRyY3lnd01Oc2RtelVW?=
 =?utf-8?B?VnY4UTNxUmRZeSszN1IyL2wzclF5Lzl4NVhUa1dCODZPNkp3Q0pxRE5BS09L?=
 =?utf-8?B?akZuNzJJd2ZQSTZDZDdQZCtpQXk1cnVycUxNcTltMWxpbnZOSitHSHFvSzFp?=
 =?utf-8?B?N1VjejJ0amFUSVlrbmF2ZUovSDBlbkJOVzdvaFpoRjM1OFVvbDEwRjR1ei9a?=
 =?utf-8?B?eGxVdFJUM3phK2NXZy9GNldWVGxqRUpkcDRobFNlcmFCczhQQzdmbUJQQVdz?=
 =?utf-8?B?YTZPcFBsbTdLakM4ZFE5ZWM0bFhiWnphWWxPNElFK1JzRFQ3cWx3VHQyU1lL?=
 =?utf-8?B?bW04YnFtSlIrUWFGUUpESXRJK1VnNWNMTTBiby9qYmFzMm1SMHVpQThHQzR1?=
 =?utf-8?B?a2J6RHh2VFRBNFFCS3Y3ajVNZDFCYzVSZG1Tb3RsZ3FCVkk1UjBXSThNR3lK?=
 =?utf-8?B?QU5BeXo0M1pFZzVFY0x0aktnRGJDcXZ1RUlyc2VsQlZxVkx3cEd2UERnR2Jy?=
 =?utf-8?B?MGdxV0VacFg5YTUvWkk3d2JrZkNaQnN0REFqa2lEOFdLOEluZVYwNGppTEVl?=
 =?utf-8?B?dG9OMHVnbkpWNXg0RjNHRytLVTc0bUNqak9hRFpzVDZZb2lMbkRhOGJNN3pq?=
 =?utf-8?B?dFhqMmZRQTNjWjh3Y3FlbW1BNlZwYSt3MFVWOXVseklORzA2cjF1dXlaMU16?=
 =?utf-8?B?VUdiOFA4cy9VWURmN1VFQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L25neU93eXVZQXE5Zm9HUGlHTTZBNmJmWkpDWWZuTnZXbHdZYWIyOXBUcStY?=
 =?utf-8?B?U0U5VlF4emZGU0o3U2RYeDlrKzlKcG1iUXR4RjluSVJGNUk2bVF1cjFDMlk2?=
 =?utf-8?B?cFM1WklGbnBaZTRXcGN4cTF2Wm1pN0IyR3o1NWFhaTNJVFVtSFhuSDFIOGhI?=
 =?utf-8?B?eGFxV2lqdGRTY2lPVWhXd1FvbVBoY0Q3S1FyQmUvTlBvYlp5M1JTaGl5a0Nj?=
 =?utf-8?B?NW8vMWFQV2ZKSzg4aXRXWUtHeXl2dzRpWkdWTWluRnpDaFluSFNTb3lqeUdH?=
 =?utf-8?B?SmVJT0VEOWgrUVBEMUR4RGtoT1hzMFkvT2krblFLa2RmbSs4Z0NzYWIrNFN2?=
 =?utf-8?B?WTJnY21Jc2svSm0xMC9xTnhFd3NubUxjalVYMGJLTXpwaXNlbVdPM0JJWUFQ?=
 =?utf-8?B?Ry9NNXVZYzUzVWkvK2lRWTlMUDg3bWV4blRhek5rKzVDam9pZkJxaGZybnh4?=
 =?utf-8?B?YmN4RDZmZ1k3QXBUdW1hZjh0dmoySHc5K1JGN3EzK2xQZmNsQXZ1QXdGaG84?=
 =?utf-8?B?RkVuYllBMHp1eGtOZzdoaUlxblU3Z0VNZEJNL1p4dUNXM2hJaUMzKzVML3lq?=
 =?utf-8?B?OXZiVW1PQlo5YTByZE8rSktZQ1V5dkk3M0psSUd0akpPNGtVS1Z6OUp5dndD?=
 =?utf-8?B?dTdWYnV4VGtyZzVKV2lqZlZDUHRZVXh4NVdTa3ZoTXJVcXM5Z2N6R2hjckR3?=
 =?utf-8?B?SENHYzN4ak9zMGR1YldLUEhvSHZXdVFBd0lmbXNtUEt2aFZRNFZKbHV3TUNp?=
 =?utf-8?B?VHRGWUZUSDg5cUk0a1JGUVZJY3RFMDJqWkxVeFRHQXVvd2JWYmJjWnJXWk9V?=
 =?utf-8?B?aUdCMCs2RlRzQ2Z4a1p0MENrUmVoTUFMcjViSzNBZjRwQ2d6YTljaDVRU3Rq?=
 =?utf-8?B?Q0dqNTRlVUZXVm5YYjNrcmRZWHloUkN1WVJmdEFybGdZcGdSTm9hY1g3ZERN?=
 =?utf-8?B?TEFjYllybHNtRngyUmxpT1gwUjhiNWRuTnRhbkpiT1B2Q09aWi8zNENROUV4?=
 =?utf-8?B?TWdSVVVxWFRaZWJHTEJMbVg4YlBSRSs3ZWw4UWlqTExJY09BcTQreXBvUkNR?=
 =?utf-8?B?WXpmOFFuYS9NLzU4RWhwNXRqSUpLQXNoR3dwSGlCdUJKKzgyQXdHdk50SzJV?=
 =?utf-8?B?Y0doQUFQd0tOdld4d25GUi8weGxTY3BXZVl0LzM0cCtnb1RwSnF2bnFDcVRB?=
 =?utf-8?B?dDk4am1laXF4WnBhd2FKVENJVGd4V0RCcmUxQjUveURWSTZRdWh6ZTZwNU5W?=
 =?utf-8?B?eU1kUkxDdStvejN6SmFsYXBvUW5LMFVuczdTYWIyYSsrcVI5ZG9CVWk5SnZO?=
 =?utf-8?B?QkZsYzNEbG41OEh5L3hXMmR2ZGlRYXQ2eXp2TXVYN05zM2kzNDZhOFYyM293?=
 =?utf-8?B?ZjdWUGtGU2l1R0s0TFVpcndVQVE2aXNWUTVxN3B3aTIrcTcyTGh1d0ZPSEI5?=
 =?utf-8?B?c0RMdzZmeVQzV2dsVnFVVTVISG9vQk1MbHBBZ1VVQUZmVVRUL3MxNHJLMWpB?=
 =?utf-8?B?S1FSWEU0aHdFOGZHOVhvak5pVE5PZFljUG1FSHRKQnBlZWROZWQrVll2N0dY?=
 =?utf-8?B?YmRVSzZIVm5FSldWS0ltSWltZmxEQVhnN0lmT3JWeHJHSmVBbHVSWDRVZUo3?=
 =?utf-8?B?azZIOWRqTFAzRGcyWW9HYkk5MkdORFVTTTVidzczUjA4RlZVckc2Z1d4OEk5?=
 =?utf-8?B?Qng3RVhFNmI2Nm9CU0xiS2M0QTFRR0hnSms3Zy8rN3dhTWNhN214d3RJWnN1?=
 =?utf-8?B?VVJEUnc0VVkyMUxHY2FSYU51MG5nNXZoRjlVM2QwWXNrQVQ5UGhINk9HS1NN?=
 =?utf-8?B?dG9aaWhoWXVvZU83d2huMFFjZWdBZWtDTnpENnBrL1RleEdrVTFwdzlPZ2pZ?=
 =?utf-8?B?VUdzNjRQVWVmekc5KzZJK2hxTU9XNU9DWTVNSUxQcUNnRW5WRDBWcmlTVE1M?=
 =?utf-8?B?Vk4va0s1VTk5bDVwV204Z0ovZGVVVW9Db0thMG0yb1BhdGx2NG1zR211Z0Nv?=
 =?utf-8?B?WWxEY256NTJZMkJTb0R5L3VXU1JwU29nMmFQSUZZTmovSUVzN2xEVkMydVB3?=
 =?utf-8?B?cG5CNXBWM1QybGNSNG55QUtvS3FGcUNUMUl1TDFXK3djWFR4UTRUWlArbmRI?=
 =?utf-8?Q?Mj1ewxt417v9h3vYbfaicpi2G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZjGtTur3y+O9rp4N3VTMY2AHLiu8f7j+4jYP0n1TY+Df5vA80nWKOOQLke5MgTjBpdK4vhFRZIiJEz+7LjMHglSUexMYz7/xRsiB8Qumab6FJlIt9tx++rfkmd9bw1/IS25/4Ygp2ZzdYb88WC1UcrhpoS+DPq7Obp1Gm0Jv933isClJtTp8ZVNAGHk6f4UobBI6ON8LU4+ux8tKRGDJuHBnQ84kp841pmIIPgYqwU2wRZNUCMWx/p2h6yTIYMRAOE37NAPKZqTIEFXnuMjWZM7FFVbFa8DaTzye4A83ete1MoaVjvpvtvP8ZGR8KYTS+AIABiNwpYpczeJYmAIMiEz/XsKHGa/s5xZMryfcs1OBFxOr1l7gzN1V67laGBeROJcD8YYnMJi9Y8Z3dDS8DUsnO7ZbOw7qvElYnTmJMAnut5qJcrhFRdyF0BpIRai5EQ2IMCUrqgwtL39i3qrbWV9y3mb6WuxXdjxACV9juhhQE/nobJI0clObttwd74yQKekri8Uior9sJiDcK7ovnPt5JxxDJGQvmcxR+byeZ46YWBmXtb7Frz+xTy+ww2UnvRg3xrxBc5aZODIuJRjk6WF1Q+jKx7aeC1CQbiDLbhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e7b361-b66e-415e-14f0-08dd12bcec7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 10:34:38.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byd4OAcXkhUg6Y9YwcRvZL6qN3mywtC2F+YA2SMwRIa0bxUZ3P95LesWQ4w/nJIDxlR+NFgANpoTIwGAfF+TMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020093
X-Proofpoint-ORIG-GUID: nJSvsWZ7Ad1v5LQ98VGofow9CJVlP43t
X-Proofpoint-GUID: nJSvsWZ7Ad1v5LQ98VGofow9CJVlP43t

On 13/11/2024 10:08, Johannes Thumshirn wrote:

Hi Johannes,

Could you kindly repost this patch? Sorry for not paying attention to it 
further previously.

BTW, on a related topic, should we check for a negative error code in 
btrfs_append_map_length() -> bio_split_rw_at() result?

Thanks,
John


> On 13.11.24 10:51, John Garry wrote:
>> On 04/11/2024 12:13, Johannes Thumshirn wrote:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Now that bio_split() can return errors, add error handling for it in
>>> btrfs_split_bio() and ultimately btrfs_submit_chunk().
>>
>> I have a couple of comments, below; However, since I am not familiar
>> with the code, maybe they are invalid.
>>
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>
>>> This is based on top of John Garry's series "bio_split() error handling
>>> rework" explicitly on the patch titled "block: Rework bio_split() return
>>> value", which are as of now (Tue Oct 29 10:02:16 2024) not yet merged into
>>> any tree.
>>>
>>> Changes to v2:
>>> - assign the split bbio to a new variable, so we can keep the old error
>>>      paths and end the original bbio
>>>
>>> Changes to v1:
>>> - convert ERR_PTR to blk_status_t
>>> - correctly fail already split bbios
>>> ---
>>>     fs/btrfs/bio.c | 15 +++++++++++++--
>>>     1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>>> index 1f216d07eff6..7a0998d0abe3 100644
>>> --- a/fs/btrfs/bio.c
>>> +++ b/fs/btrfs/bio.c
>>> @@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>>>     
>>>     	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
>>>     			&btrfs_clone_bioset);
>>> +	if (IS_ERR(bio))
>>> +		return ERR_CAST(bio);
>>> +
>>>     	bbio = btrfs_bio(bio);
>>>     	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
>>>     	bbio->inode = orig_bbio->inode;
>>> @@ -678,7 +681,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>>>     				&bioc, &smap, &mirror_num);
>>>     	if (error) {
>>>     		ret = errno_to_blk_status(error);
>>> -		goto fail;
>>> +		goto end_bbio;
>>
>> eh, I am not sure why this has changed (and we now skip the "fail" label
>> actions)
> 
> Because we want to skip the 'if (map_length < length) {' part below the
> 'fail' label and directly go to btrfs_bio_end_io().
> 
> 
>>>     	}
>>>     
>>>     	map_length = min(map_length, length);
>>> @@ -686,7 +689,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>>>     		map_length = btrfs_append_map_length(bbio, map_length);
>>>     
>>>     	if (map_length < length) {
>>> -		bbio = btrfs_split_bio(fs_info, bbio, map_length);
>>> +		struct btrfs_bio *split;
>>> +
>>> +		split = btrfs_split_bio(fs_info, bbio, map_length);
>>> +		if (IS_ERR(split)) {
>>> +			ret = errno_to_blk_status(PTR_ERR(split));
>>> +			goto end_bbio;
>>
>> Do we need to undo the btrfs_bio_counter_inc() (not shown)?
> 
> Yes we do.
> 
>>
>>> +		}
>>> +		bbio = split;
>>>     		bio = &bbio->bio;
>>>     	}
>>>     
>>> @@ -760,6 +770,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>>>     
>>>     		btrfs_bio_end_io(remaining, ret);
>>>     	}
>>> +end_bbio:
>>>     	btrfs_bio_end_io(bbio, ret);
>>>     	/* Do not submit another chunk */
>>>     	return true;
>>
>>
> 


