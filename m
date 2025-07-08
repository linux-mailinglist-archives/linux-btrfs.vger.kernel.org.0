Return-Path: <linux-btrfs+bounces-15328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E2AAFCE2E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5B188535E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80D1F92A;
	Tue,  8 Jul 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="APHCB1F8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sl+eNbRI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394352E06D2;
	Tue,  8 Jul 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986084; cv=fail; b=QmGdDV1j5awfTxf0uDRwGwxAb7hslIc/5D3ECj3rz/0/3+FZ09It9N1Ozz1H3aqJ70+Vf3j2ir2SvDpTnqUYofInZJgQUgskWJkQ15qwApf2fj/a04SZVfB4NPFxoxOXjvoAY3AT6q0UBO4OoTZ3qJUAqtbaCuQKUdL+Dt9iGqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986084; c=relaxed/simple;
	bh=jPcboOlTx4KvHleAI0dBp9M9k4FG4dn6lXhANGNchq8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/0r9UG6u7IhoH1RynIIR/G6HIXmSz03fEz9TZJ0H7N+dCiEBYMkRWIiN7xvHoT21usffWe5K0LwZ698enDZj+Nxa5C+nHVtweTVIWqHTp/PE+B5wB7qxH93WAMnOE4kEPcndQkjaS2FCNaGUOvMI074qrFpNTAJz9RKrRWAYHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=APHCB1F8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sl+eNbRI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Eftj1020292;
	Tue, 8 Jul 2025 14:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jPcboOlTx4KvHleAI0dBp9M9k4FG4dn6lXhANGNchq8=; b=
	APHCB1F8VVzNoOrQyfZuoOHcXYmK1evmsHZoykEjw6eAdWYv0Y+4Onycv6P2Sjz7
	P1NnvUvtuWqdO7KNmRKdoXwr9a1NmVvE44skgEUcxTxDYjysHElCzFkm5Ro1jQAU
	Ln3Vh8tsAKeR3pQ5Nmnujy8hH5spvys2juLDZztudOhsk39R1fPolEuZQjSg/uqS
	mTEz2b7tPTuqGhZNEjNWZQkQFFpP82YQHuQToO4+u+hZYOiBSrYKL0rZtP2PVeeH
	DCKNhZj/6iCQVSi2HEsXBEXh61cls2iSweOA0JUu8gSBP234LKnL8Va8CAxCn7nI
	KnWMrYCjeXNf2LWBu6G+1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s5aq80jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 14:48:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568Ele0n014002;
	Tue, 8 Jul 2025 14:47:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9qpcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 14:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLpfhFRgewyD9ZY60XXMa/2Wfq9qyS97sgYE+NP8OJ30xZddWhdcL5JmV8Lp17HupuNffBZ1sqaMRBgEe7TbNHQ4Ika2AmnC3ViIN0SoNO9Fp0vVAykwWj8Pa/bOCH+ul5BqnBzD8VXfKTHdD5zTfnwinrGAI2Ilm9lb0JX32xSvpgl+qKcngApySxsIm4euDwL6hVPApTy8Iw8Dm8kcqUrH+BizmHgoA44A8VBcFUnYATqgs6K8Mc0XtzR6oDO39hvMVTryT9JLGtRmAOmRvW+8dibu1MmwC4J6vyo86CairFZ0Py+CHcTAkBYMnRvORZkF89r1GS14I3wnN6+lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPcboOlTx4KvHleAI0dBp9M9k4FG4dn6lXhANGNchq8=;
 b=wzyhkF2vY0BVVEZVCNfJqbX5UPs+ndT51VMD4SbZ1qCrcCkOx/O4ZJwOVMBhR2wBJyJoEb0Cr5nC1C5IUPEj2D0+MM1tJzNhYmP4WljRDDSVFrAJVfIyNheVV59z8SxNXONVrR5kkdbJRer/9X2RuXGzTGmqWZ7pkRDLxoLTwGeDh27CuEIou+3fvM2Z7qyosUs5fBufuGubkN97gox9uSzuqfu+Tcvqa3yxlUifSSfQsXL/hIf3tbukTsEbfXmszF5IgGnwhdLzXb3JmyLNOTvHC066L3w5Zv6jjFQY1x1kX1fXrDG0QnVWUjgr5zOoHCiH4tq23QEa33V/F3kYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPcboOlTx4KvHleAI0dBp9M9k4FG4dn6lXhANGNchq8=;
 b=Sl+eNbRIldj6fQ47q84zOcsZvnfSXCcTGlrV7/j4zUIwLsdZwRwwzZ3QooW407KV1D5vfpQzmPqkWuk9b5sGfESXVMh5tty7IXDruCC8R4Gz1DQdfW2DzwjVEq7LUl4xBoltqi3ldQ7Gya8QEGMf7rWKkxNgjBpC4FSaBM7XYYU=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DS0PR10MB6103.namprd10.prod.outlook.com (2603:10b6:8:c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.23; Tue, 8 Jul 2025 14:47:57 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:47:57 +0000
Message-ID: <7bf66624-5be5-4f8c-9496-681a594a26ff@oracle.com>
Date: Tue, 8 Jul 2025 22:47:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/050: add a workaround for btrfs
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250702045312.59995-1-wqu@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250702045312.59995-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::7) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DS0PR10MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1efe6d-a726-4907-cf3c-08ddbe2e6d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFdxUDRVdFo5VXhQMGVHVGR1QThmUTQ3MnZyKzcyckoveFFISGlxVVR6UVVt?=
 =?utf-8?B?R0VFTDFTcmtTNnliV0FJSEtERllNak5na3g1UjJIV2NqazJZMTc4aU1tV0x0?=
 =?utf-8?B?ck9KYnFrZi94MFhVbDRnQW1GUWlua1lSM1habWN4dkorZlhsdnF6a0ZpZVpv?=
 =?utf-8?B?ZnkycjFHWTdBWXBTMXlvWS9YdC96aWdLTEZESWVnZzdxSkxWZzllMWVERHhV?=
 =?utf-8?B?NmxqdmVhUFhMcEtMeDgzdFFvSHlQeVpnM1dTWGVWazRZOHZQSlN3QkFvV1U5?=
 =?utf-8?B?S0E4akxjc3laNDd1SnRMS0o2bEIwcXYrbzlqUTFJdjIzM3ZEQnR6RHhFaHR2?=
 =?utf-8?B?cFVmdDViRFZUWjkzQWxhNFl6UG9DR2xhallzeE5FZmJVcmJ0MHp3SW5UNWFI?=
 =?utf-8?B?c1c3anB5c1JTZHh1SlZBME9DQlFyaVU2czRGMFk5ZUtGbDlQRlhDdzRyZzIv?=
 =?utf-8?B?VThhN0RweVNZUlEyT0JnQW5EcjAwTEpjT09rN1FMT2JrQWJESnQvenBzdzlq?=
 =?utf-8?B?b1Q0MWU2U0R4Q0NnUXJoYXNKUGtFNHk0MzlkcWhzNnBJVlppZ3ZaODBoSDZ2?=
 =?utf-8?B?Smw5VUJnNEFqZ1dDSEplVUZHemNQZlgvYW12YUd4VCt2emhRZ3J0S1hqS3lM?=
 =?utf-8?B?dXh3Z3BGZHJJT3F2QzQzSWxlbUY1TWx1N3lTbEdaWVhvb1dhRWpmUkJ3MEZi?=
 =?utf-8?B?TWJhY25xSlF0MHdQSk5uSnpPc2RNaW5xT3g5WUkrUDRLUFdmN1ZPRjQyaW5H?=
 =?utf-8?B?WXBIN2dadUV6UGhzb3RjdEw0TmZpRTZobjA1S1czUHhBeEtEUnNpMFUxOGxK?=
 =?utf-8?B?WVVIaDJBOGZhWGVrNHUwUEpicWNidW5kOEdkcENLeVdzT2VpdktnUThuY3pE?=
 =?utf-8?B?bnZaREpJaldTSWEvWlp2Slo5ekFTWW5pRStseFN2L1dORkRFQ05KdFdRdlFP?=
 =?utf-8?B?dTJEL3I0cHk2bEJEd0x1K0NreC9UTTdsQ0VYaUtHcisyQyt1WUNJcnRHazk0?=
 =?utf-8?B?UzljdkZtS1pRb3dnVDRPajliT245M3JUREFzYXZMTkpJcUxzbW5ud3VlcHlw?=
 =?utf-8?B?VXZXOGpJU3hib1ZRTWFpY3FDU3VoWnVYSlE0bTZrWkNsM3NoOTdRWGtKSG45?=
 =?utf-8?B?ZktkMnBNZ2JNc2k5dFhSY1FBd2VvZkwxRlZ0MkNMV0FRd0IwdWJ3d1orc0c2?=
 =?utf-8?B?RXBHTUI1S0dNb3ZrYkxRZlA4Y0MvNEpqdzRKcDByYkptOUdMQlBnUmYxRFI3?=
 =?utf-8?B?dFZSaE90VFB3UktwTDN2MyszVWtKSnZPbU5WZE5Ea1Uwc2VYTDFFckZ2bDFk?=
 =?utf-8?B?YUZhQTJGcXUrMkNwNlFuNWpuNUpVajNhVmZYclprZzI3VktiRXM2N016ZDdz?=
 =?utf-8?B?VzJmNGtBQmVXcFNhdjJzcndibS9TL1dSeXcvL1lES3VrQzVUTysrWnhvcktZ?=
 =?utf-8?B?cHNFaXIxRUQ0cGI3TU4yODZFbDlpckhPZU02TWNsVit1cFBRaXpBdnNxZTNy?=
 =?utf-8?B?eldYZ2NSbGRvZEpVVzdKbUpPR04yVXdBcGFrck01M013UmJEaVpCbTZ5dDQx?=
 =?utf-8?B?cFhxRkptbytYNndQR3BNU2VwZ3lWdGJkOUtCbXlRaVZOd013WGV0M0NMUFk4?=
 =?utf-8?B?RmZYcXZnZWJzUWZQU0NGWlUvUVlJVW9LSHovRDB4eks2aUxqMFE5RnlkdTg0?=
 =?utf-8?B?ODZBZnBSeHFOWFNseG1PZjNEU2NmSEc3elBmQ2ZMTVlJZ0VpNG1mTFcySTV3?=
 =?utf-8?B?SVBEVjd5SmVWRFdybUhUL3ZUQWtpSi9vZzBDRWJDYjRyTnJMa3dmeVJ0YkIw?=
 =?utf-8?B?RGQ3K0lYZG9VOEJDU0N4RnFqWWZ6TUJyRDN5VmZJbTlxYUcraHI4RXY2Q2hY?=
 =?utf-8?B?S3hyUFhXV1VZaW16UHBJNmVrb2VKQ1JCR2F2NkN6VUpFMGNIOHFzVzNjOE1l?=
 =?utf-8?Q?feCN2Xs1ZF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3pmbStmTHhXdVdSOUpydys1Vk1qTHBVb2Mxd2J2bTlPV2l4QWVWRnBLYjFw?=
 =?utf-8?B?b1h4QVlJUmxrN3NkTStjWldyMGdRTndYRThyS2JEd2I1TGhaRGt3aU44S095?=
 =?utf-8?B?bDRtU1lKRFZiQlRST2hKNU12MGJKZkwvZzJmRXJ3Y3FOajgybjRwQytxSW9n?=
 =?utf-8?B?TTVHcjk5K2ZYQlZaK0swSWwyNVhDazBsWHF5MGdtTzlrTFB2WEFlQTAxNHVv?=
 =?utf-8?B?cG5qQ0syKzZNaFZsOFZuUEN4aEpOUEFVT3VqdkkzTnVLQkNVd3pwNkVDY0lj?=
 =?utf-8?B?alVaaWJESTJDemEveXh3aHkyV0x0VGIxSWlPQjZ2QVducHRGZ1lqTGU0Q2RW?=
 =?utf-8?B?TkpWa2t3dXVvUHlJbWRyVEhlMGVZMTA4bzMvd2hoa2UvejlacGlPbW5lcDQz?=
 =?utf-8?B?dmhCckU2Nll4NW5jazhSMEV5VHRtRUxCUWdGV0tDMEJKZFNJUTZ5UkF1NHV4?=
 =?utf-8?B?OGZVY1YrdlU2aU9hVDlJTUlDRzZiYjFFQURhSlJML2JOZVZSOHpIbGVaWmlU?=
 =?utf-8?B?S045Qzk0czBmR0dDT0IzeUhaVTcwMEorRGxyRUNTRFZuZndGK1dnbk14VVV5?=
 =?utf-8?B?UVB3VXBWRnFEaGZpd0dkQlNMbG9aNjBTUkp4MFVLazBMeU03M1N3NEtiRDJV?=
 =?utf-8?B?b09QR25nU3BzMC9SVnI3WWZsdFVWSW9jaXFBT0ZuTHQ0SVI3K3hjQ2VzRDdy?=
 =?utf-8?B?WnZ0MXpHVGhBaFowZ241aDNPb1d3SXpISmZ5SDJsTmZHZkY5cnFzUkdDcC96?=
 =?utf-8?B?N1JhZEtOYXRGNC9KUUJCQ21LSExNTTJYb1IyVDVUdkNsLzE1TWhISmdGR05k?=
 =?utf-8?B?M1RCVmYvV0FCdlByVCtNS1lYTEY1Qmk0bTVYMW1vNkNpQzdHalYzdXVYUjRv?=
 =?utf-8?B?d095VWtPOUdEWjJBRWdaa1Q4d2p6aUMzamh0NmUrcEVmeGJiWTRsazRMWmF3?=
 =?utf-8?B?OWNSY0NRS0U3dXlFUU1ib09tdVkxQUxmQm8xek16NEV6Y25UUnp4bzNOVnVw?=
 =?utf-8?B?cXJuM1JpMXZTQVhxdnFORXJsS2tkeWIwYVZQQmErMEhuaUloK2xEb2d6QUVZ?=
 =?utf-8?B?Uzh1NXpIZ01ReVJCTHdNQlpGelA3RUQ2V2lGS1NuL3hPdlJwZTNtb25LY3RN?=
 =?utf-8?B?UkdRU2JCeHNJQzZCZHpkV2VXcXhFOXBWZExsN3o4WEJLM01SeGdEckMxYnVq?=
 =?utf-8?B?ZldwVURsMTlFTXFmNCtHTGNyenhrYzE2elVITDM0KzZmeUZaaVFWekhOMDhn?=
 =?utf-8?B?Y0Npa3MxcHFraDNyalhpa2ZOdW4wa1EyaHFZc2Rhb3E5Ymx0YlY5UzlkZTFw?=
 =?utf-8?B?d2dHWDdaMFFKMHR5NHF2R3ZrR24rTnA4YWhLRW1MMjBDeWRJZVhkMldydjgz?=
 =?utf-8?B?KzZBaHMwVzlWcVZ1UEJVSTRUS0FpMWtFZTdZandsbUZBQSsvdERFNDNYTkZz?=
 =?utf-8?B?RDVEMUlGb3BqRU5Ud3p2N1hHWTdtNWNvT0lzWHQ5YlA3NWc0ZmlLeXQ0YmFj?=
 =?utf-8?B?WVRHYVp3WDJtbXFacVQzVFM5QWFBK0gwNDZZYTBJckx6NVJVb2NtUGk3djBF?=
 =?utf-8?B?emtJdVJ5b0dvbm1lYVBhaUl1aHk5a0FBUlFoNlRtaFlySC8wSHJVZU1EVkJF?=
 =?utf-8?B?amtMbDVVOUNXK2MrSUhsQllrdUNSU1NWUzdXQnJtMWJvcTk5c3FHMytCdFk2?=
 =?utf-8?B?VWtndlZCTFZKWUNoalo5MW8zMDFUTHNMSWhKZDlJSE9WcEQ3M1VhNyt5VHcw?=
 =?utf-8?B?cDhIUktmcDNvb2hiM2QrR2ZsLzloL2o4dFJwdlRmZEdKMWJJbXc3cXh2YUJv?=
 =?utf-8?B?YThaYnFsZ1JCdG56em1wczdkMjZaSWFpQnZGVkpBZFBSd0U2NkFIMnpWcFlP?=
 =?utf-8?B?NXd0cGVCYXM0S0FMN3VQRXdpVktZdTdyWGRBRWFJdzdhZVYwN2srWWh0N1JH?=
 =?utf-8?B?RmtNU1VMdzJiYmFaaHZiTjMydkllU1RnNzVYZWRVYloxdEFENHhLWVN6dytm?=
 =?utf-8?B?MnBqaHRZWXVsRzdMUDV5WkxnOFBENXhGQ0pzcGpwVklqUEVKZUQxZXgydzQ0?=
 =?utf-8?B?WjBVS3J4bExhb1dvd0YrS05UYXRqS3pnNnV4SXdCejFKMGVJbUlNTXNiTCtL?=
 =?utf-8?B?bHdjQUZoNjRQR29BWnN5MmhYY1pqNlVkbkN4d0tsajE2YnFUZDhJU1ZaVHFh?=
 =?utf-8?Q?pIIOyC4OgjK3EsdulXpWB6oHoVB+YWxb6QG3H5iGhapk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tZeMzsw3Se3oBL8CHCSb1r0xyvHAZ39CX34HrbycZM30Yt+dfTtVIKg+qldsL89Nr/mdXn5EoU3vaWtPYi43LThelHI7AHydeWgBIGSOv3URx9UXPez/RDy+StpX/1vfovypX2d6ynk8PjDBFhuTmgoluFwXhO6ZRRW6OvkrpUXFa/azJqmakZ7bYJyw13o9rCV5Q4F492yensis3UOQlbWI3Y6Pq7d93bOX6zDsk+I2cIA8zHJvk/d2OKUiRaZD0tEkpwzjYASevzNxk4APhZirF3gRJ0SPnqmd8JogcAU2uu9xT6TuXFQXiNaWlXrNV48CIZXZPnwK1ttzGjrpANjn4LqE4JOMHZaLYw/flMWP6/RB6/8icf4H7mdT5h7pWQS6JwvtZVpxaFPbQ21BBnEyAppRB5poznKlZd4L1KFeF4SMFtdq/XKvCPNwVrfjusss2DdQhtOMGws5F3i4l7TjkVRiUaZbRoFfjnjG3EAEtCJFb/P4Fwtk93+C5g769+tBY2f6+tO0c18o6ZRiOz+1ZzMNsBFyVotjf5pA0A+KcJ8+lwwcCx75gIbHFA/+3ZS+xoMdDW97+Ihzw2FhdcUP0w3x6OhJ94M0pix1+Vk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1efe6d-a726-4907-cf3c-08ddbe2e6d92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:47:57.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ewhZqGer3cCd5fH2oxnJI3c5seBD1hCEHQZBGT1ZpGFf85T6yHKTginv6IED261SnbeddJIgWabP42mukA3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080123
X-Proofpoint-GUID: k60_JBUv-EWpth8YvIedLhjmumiENAE6
X-Proofpoint-ORIG-GUID: k60_JBUv-EWpth8YvIedLhjmumiENAE6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyNCBTYWx0ZWRfXyX9SkK5ciuI4 mEQzBFejmT66rgL6tU5wOb4WfYrO5M9v1qfDF3SGpFmzfDdXgkspAqFdhDcRrM6wBsFa3AfMMDw NS02N7eHMK+yUbsHbmOmrjQsoGYq1WRQ5qVb/0DsxAY5HCdkmO3FTwM6prUOl9jlbBu1vyNt8iq
 840zyf8V3ptjuB62hZpwNYYhHjTmlSfE+03OJ2vlPM2bOuSqr1NzJ0nLOPlCHPPt+HU6Yauby1b qVJR52oGmALzM9Vdl2aeylDZV+6sT8Z20iXU92t6xq9FAX77LcKIzhZoz5+GG43oKOMsW6ioq3T 6BG7wr+nEv8eGu0Bd0GGCD6TdrtyeyXs9oxurYLQiYfxLBuTXlqLGqLeoYqtYEzS9lnZvcaH3An
 FZyxjjtAurKV9D7gU7ddews2Sgf05jozb6FECr53eoEHIfBlU70HOd559vjwkFMFVPCkUIFd
X-Authority-Analysis: v=2.4 cv=eag9f6EH c=1 sm=1 tr=0 ts=686d2fa1 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=v_2VbwHWFUbEMxz5hlYA:9 a=QEXdDO2ut3YA:10 a=_Xro0x9tv8kA:10 cc=ntf awl=host:12058


Reviewed-by: Anand Jain <anand.jain@oracle.com>

added to preview.

