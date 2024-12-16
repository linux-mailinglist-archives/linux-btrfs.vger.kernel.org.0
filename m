Return-Path: <linux-btrfs+bounces-10404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9331F9F2D12
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 10:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CE7A280A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95224201271;
	Mon, 16 Dec 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cRJi+7Qh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PcW3Gzw0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41D200B85
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341676; cv=fail; b=rjNI8P2W0AHKLbH07eSBHGyWIbR0aq6lcP6bHx1IntfQGcNUbwQbh4BtBHWHjITcSFFxezuyxeaYPLpL4IosllBDnbJNY3p5fDbtGkK8BDfDTJFAgTSG2WOUdDXtZeYlC6gUY6qId7awcKkQWPBP8QmQyl7M39C5NxyM8Bpzx3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341676; c=relaxed/simple;
	bh=fwdQRj8BnyStqN6xTB43RnBuhH+1pVy6HBwa5/Jhq+Y=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkLYnoOt3SgUhESDZMtYnesdj7AGhKVv7eYj8CO/xBt3g4pJX/mY+0CBVazdLDOntB34YSDZWwgVNw0phglZ1u65Ey6LQ+8roVNlya9hVKLJf3SkIbBHgNx2GbKRwo02vq24Iflht2vMUTaj0H6+/hFBHF89CNxRb0Wk7t9XMf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cRJi+7Qh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PcW3Gzw0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9Msfr018727;
	Mon, 16 Dec 2024 09:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=twrNkUWME7H8l/8jgpfFha3TzovzlzOavqZgZ+aPbvc=; b=
	cRJi+7QhGK/M2KtyfGLbPZCf21EClBSezIJgL8rXt8FFyZ+h2olXvTPghVcNbZX8
	3brOIEX6WrtgjATebwQC4y6SwcA4G2baIpW59DtMjF8K9IO9fit+kElkLEblZQNg
	HZKQ6DRUxpdpdFX8gjqVXF6AKssF3M6d4MSf4rt+gm6ULAV4/8DpYBjBkiDgviWe
	ZZXbTGaIFVTv3m+IOB09wHSjkwr6xPyjOGUDxi2Am1x0trZleqFn/XLHlvbjKPk1
	xDt2IxGvHufUHpcibgURvnMFRP8MNSsudjbkJnPVwl5lbvr9kkqvYvqtoBITQkw/
	z4Y/ar1HihuSuRUgVE9ldg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cjre2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:34:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG8ZNFD010921;
	Mon, 16 Dec 2024 09:34:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f6s6w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWV/X30P6gAGQXoFFsSNOH05K9TTQNZ3Ddu9AESwpJuUEpzFX7TqnC0uGT1f0FWHBX0iMOvvWlv5CNnyYfGF6RAEB/r5UJpnYviHiBVHvGBMTkl4KBWRdRDGde4h46EcYiknqMJQPy4vbPHF6azV45nVNLM/E37OUwhxMub42Zq+DeGH8vtbDJpUPDWniAP9R90vj4MM8pgeupXwRnQ5mmcrn0PodT/uPX3ogDfC/eV0DIxcbNmUWsz+WYgMzy/NGtNr/vPjk22kSsE8cbWagIp0WWqY1ybsjvpD+8eWRcpdDpozW5AGSJajzLoeNsNlTCpTE+/MeC+mV4ngF28Xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twrNkUWME7H8l/8jgpfFha3TzovzlzOavqZgZ+aPbvc=;
 b=PFF5+iJd5YpsXqlCQtEfhkejl0fIxU+56xF0sLimN641SPBHs25HZ+DgrLaZoul0G3H2ac4QR3uQANHoPcHvU8X3QpWSmHajNPDnVnMXezhpVPh2eW/KAhxSs3885NMv//UvCi/IV23MiQciKNKFrSeapQXH1ULJBayjgi2tj3jNRfCl4pX5mKiW/ZIXSJTURddJ75aITG9W8quUc2D1uuartVq0sdK4hGEPiKIOKre3lxjZbNbXh2EGbj3l7ZbVtnx8e8uEflAF4sNHbTSYbQnhp8HJJgQIFV7/8NqnY7SsqB2OC1c1gCcVIxTwmDcvWFDUCdKdb/K+XCsBffnEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twrNkUWME7H8l/8jgpfFha3TzovzlzOavqZgZ+aPbvc=;
 b=PcW3Gzw0tY2fCspDSfjfyxMB8Sqjb5KRbRhy0+PeK7dFhq5kIm2+Z3zCNHm0ueZCUuHKNv0DnCYlOfE1JN79mvJEkK4NsQI8N1dwNXP8Kvrp8IvhG8o3IAF2IAt9UrzkMOD75rdmKdSJtyU5cMaQyXn0srwyw7NEoFhfbtIR3tQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5723.namprd10.prod.outlook.com (2603:10b6:510:127::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 09:34:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:34:12 +0000
Message-ID: <90c5cd3e-b998-447c-93b6-969d03b6b42e@oracle.com>
Date: Mon, 16 Dec 2024 15:04:06 +0530
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 05/10] btrfs: introduce RAID1 round-robin read
 balancing
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
References: <cover.1731076425.git.anand.jain@oracle.com>
 <995d4a9dd9f553825805efdac24dec4a9de20ef3.1731076425.git.anand.jain@oracle.com>
 <20241206171319.GH31418@twin.jikos.cz>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <20241206171319.GH31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: ac842f10-7541-4f94-7d71-08dd1db4cc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUp2MG1xZXVoT3RWWVpJWkRTTk5ZQ2FsNURFU2dsVjU4bXdnUkw3RFhteE85?=
 =?utf-8?B?S0ZReERuaEFtdWZZYmdsRmxXcXI0Kytlc2MvczdtZHk0Ni9tWVYrRkwvRFl4?=
 =?utf-8?B?SUREU3RsNU1VcjdDVlMxazA5ZkNZY0oxNXFhTVBiNTRyRWk1NGVlcmVCQk1s?=
 =?utf-8?B?OUFZTDZoMFVjTk1Kc0E2N3pPZkIxUERrbnR2MXRJSHl6THgzMFBtVVVOTXJk?=
 =?utf-8?B?VzRzbUU2WGV5UnpOVGhHWTVNcjI1QS9VUXN0c283SG5wR1JDdzZLVTE1dHVI?=
 =?utf-8?B?Nm9yekZnYk80UldZdDJZcDdFWGhiOE9JUWNOL1VlT1phRXgwR1FpVGtKUE1R?=
 =?utf-8?B?cGdKNWpWRGsrQ3BSU2lrT3NndFQvR3JCbzBOamM2VXJEdUd2YWFJSDJHeUdE?=
 =?utf-8?B?RzZkYVcrRlNwY2FrcVpicklWZ0hESUI0b0JXdVQrWHFLZzl5aWRwRVZUc09N?=
 =?utf-8?B?eGREaXdWRUhic2RLZ0s0cWxFcU0rWXE3b1g5VGhjL0JjemE5THlKeVZGMExz?=
 =?utf-8?B?MnlzRXRjaWFLdVhuOXpCcytoc3UvSUtxWDF5ZjVvRHVCQ0JBR3pqcjJxMDA3?=
 =?utf-8?B?elY3amFEMmltMzN4UkdhdHpjeDVGWlRxOWx2S1dLYlk3VkluNGNIRENPVHZC?=
 =?utf-8?B?ZVFhakZQaVBSdlc3LzRjMmp4N0FaQWlyakFOQVpGQ1ltU2VkZGtnL09ZM1Js?=
 =?utf-8?B?SjhyeXdXcFdXNnF2UmxoNWdMUHZleERSTmsxUSs5RFdOeVNNalRqakFRSFNP?=
 =?utf-8?B?L1lkOWFRRURkb0h4bVV4bjV4ZXlaNjBWVTRFZW5zNFFnTTVra1BoQlgvK3JD?=
 =?utf-8?B?d1pXS1N4UWprVzFES0RqRm51cTJ3a0hOTFltdmsvR05Rd1RXU01jc2p2aXNT?=
 =?utf-8?B?SFF6VG15Z3pMamY0dEdTeU1yNTgyMDNSMmV4cVc2MW8yRitvdnJVWk91RFZ1?=
 =?utf-8?B?b1FCdkh4azc4UE5PZENXOTNCL0NPSXZpdHlha09GNUZJMUVPRWVZZ0J5QUFk?=
 =?utf-8?B?UXZ2RUhSVW1vWmEyTUlQLzd1RnhrcVZkZ2dscUdZSXlmQTJPM0g5TDZNdXZN?=
 =?utf-8?B?R21ZMS9kbHlOSmZJMjh1UUJGM3l2ZDdDTUE0M2toQndNTDd3VjNzWCsyZXdq?=
 =?utf-8?B?bUpWbFprQXpmQ3gyRnhodWZmQTQ2OW02RGVSLyt6dGNaM0RCRGZhUjRtUmpu?=
 =?utf-8?B?Mkd6TWZGdXhDNXdpa0oyblNRUlJObStOTzA2QkRhTHpNNVhkZU5aZWMyVFdw?=
 =?utf-8?B?WFl3ZFZnN3E4Z0VuWVJWLzJzOEkvOStxdlpZV2VKcUZVOWpOaGNyclFNbzhK?=
 =?utf-8?B?cXI1eVQrV2U3c3h2OG9RUWlORXloYWo3a040c1NNM2RNREwxYnEwaDNIWmVu?=
 =?utf-8?B?Q1JaMXBsT3pyT083dWI4Z2dINWdUMDhlZ2lxMDRybEV5bnA5RlVNZWhndjdp?=
 =?utf-8?B?eXJYajZDWUtEc1NIcldkZ05wUzl1czhQSGRFMVM1YWVjYjdrLzhJSkowb0Zi?=
 =?utf-8?B?dHBXaENhWnZScXZhTnowcHBPcTFNdStNSnZ0bTU3SGtGVDdKN3F5N1o2dzE1?=
 =?utf-8?B?bXA2WlVrUS9EVS9QTE9SV2dQdlJPZE5mUFpDWWxTa2UwTVNyN3orVnhzVUpk?=
 =?utf-8?B?WG03TzRHWjl4YVBoR243SzVrSkRrbE9Ka1FmQzBxRS8rZnd4dEY0RXA1S1BU?=
 =?utf-8?B?M0ROaGd5WE9scGRORWFua01ac1NnR2h4TnlJRlZOcmV4bGNwNG1lQnJMdTRt?=
 =?utf-8?B?aDI5NmoxeitvdklDbDhDeG9CSUEyVnE5WURqWWFTSCtsNmRhT2dSenREVzBr?=
 =?utf-8?B?eUxnVk5idytBaFYwMm5XdklKcXNETWliYnh4ZGIvZDZIa0lkVm1oeU0xajZ0?=
 =?utf-8?Q?xKvOkUNlf8afk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmRkaExFRmIwUXBSRlpKK2Y3Sk8wMzR1TWZWUkc1VUhLNHFhb2NGaTdPK0o5?=
 =?utf-8?B?YTVhT1VvMzlZM0UvVVFrR2graW9MUnZsNXMrWUZqZzMxbTRhb1FEbVkxM0Vz?=
 =?utf-8?B?QkFPVUdhb3l2NVdwVndDL1V1emZ6cVhic0ZyYkozYlBVYUpHeXYyNGdUUHF4?=
 =?utf-8?B?REtkdmx1cGU2dWQrK1p1d0pUSmJBV2lmR25kVTFtRkZEclY2ZldwQ1lnVTIr?=
 =?utf-8?B?UzFFa2p2dnIrdEw4bmFzZ3BIVXdVMk5HdFVsK3Z0VmtVL0ZDUkRSckVPWDhj?=
 =?utf-8?B?UUthYUdIM1JCUEUrc1dqK1dJUUg0ZXpuWmVUaTByZ1A1c1dvdm50QTdWNXRY?=
 =?utf-8?B?eEM3R0t6SGtaZVNFSkxpcW9yckxMY092QUNDekpya0g4aGdGcHpsaDNqUWc4?=
 =?utf-8?B?NFc2RDdPOEZ3QzdQdkEvWXR6SUxmZ1A0M2t3c2hOei8zV1I0dnNiT0FCaVpN?=
 =?utf-8?B?Y1laNWhsaEVYVzVQd3ExdStSMXg5Ym1EeTJadVVmRWF1bWo4dFdlQVJqUEN5?=
 =?utf-8?B?Q1NDd2QyMmNSWnZZb3l1N0lNb0l4MzRTdUxneDAxd3FaOEJpVVdKZFBULzgz?=
 =?utf-8?B?Q2pUTTBHY0l3Y21rTUxMcllHY2FKWjFJbytvQTJSZStVSVRVK25LbkxNMjN2?=
 =?utf-8?B?a3NMclA2WUc2dWJVbXJPcndGUXpORkdBcDhTZFptaHlXUE1ZMCtuSW90Tk1Y?=
 =?utf-8?B?cVNyd2ZsUnRrUlpVYis0WHB0b2hKSTN2eGFsN3JHYy9ZeUM3WFBhVmREaFhr?=
 =?utf-8?B?bTJ0V1ZwNmRYYStUcWpQbE41WUZ2REZOWlR6Vk01VnZmT21xdnFOSnBsM0Nm?=
 =?utf-8?B?RUozOEJGdGRVSWlwUGFPaGh6ZXhhcVlWTERncmxjdnJSNG5lK0NPQ0UrV2E3?=
 =?utf-8?B?MDZNU21Wam9VOTZqWDdFbXV6dVhydjJvUjBzcndsSHhzRGJCTzFRelFrK3lK?=
 =?utf-8?B?SkpLelBsd1ZObm9HT2M2aG4wZFJidnovUzNwR2YydnM3ZW5nQmRWclFYTHlJ?=
 =?utf-8?B?NWJCb29xcEppODd3WUhUYWs0TmxWM0Qydk9WVFVITE1abHlYenlFSkd5ZURm?=
 =?utf-8?B?S2YzbWxZZ21XMkllY09rVjVmcVFHWnBqZE1GNFNIekVRWEJGT2x0dmg3U1lJ?=
 =?utf-8?B?T0hlUy8vbFloYWFMRlVraUlSYmEvY1BPVWZaSkZvZENZV1hTdDc3VFBobktq?=
 =?utf-8?B?NTQ5YVZIcWdoVVFTTVpGU0JlSmxlazRBTnhwajNHK0ZpcFVVUjVsRWp2bW4w?=
 =?utf-8?B?ZEp0SUNaUFpzZWNJcmdhYjZDZ2NxQVlLVEg4bWdVZnQ1U2MwdkdyaGw2cWR5?=
 =?utf-8?B?dEhjNnJBdFVobFB0NC9WRVNZelpCRlVYQ0k1ZnJZQUhkR2E4ZjVqNllxcUpS?=
 =?utf-8?B?ZU5mZ0p3RlB3YlJDZVpUUkVHQ1dPUTErTDNGYnlIdlFyMXNKbDNYNklqSHEx?=
 =?utf-8?B?SjNONEUyMWZvY1FJUTdvbHV1S1NPSm1FMGRCRlNSUW8xc0UxQ0wvdHJDRC83?=
 =?utf-8?B?N2pMdXdEVTlmZWZSWVhnSTNiemFFc0VSWW5CdU1ORGFUKzlUOXhqdVd5Uktz?=
 =?utf-8?B?akZXNWxtTEozNUp5dHlmTEpBZTRrR0RZOHNsUG54SDgrYUMwdkkzdWprVHdH?=
 =?utf-8?B?Y012Z21ZKzhZcnpJSTBmaTFYQVNXRmR1T212UzRFTzRsbU8wcFpiR1hLazhC?=
 =?utf-8?B?cElCSCtQVWtJRmxicThNdFlCU2JnT3dUQVdPUVlDeTJ3Q1YrQzlnVDFEMVhF?=
 =?utf-8?B?Z3R0dXZtSXpWUllrbGhZSGZFeXIrNEZXZ2I5bTlUVWZaZHlvb0NKakxZQ3ly?=
 =?utf-8?B?NGhaY0NZRUZqdVJITDZTd3B0L1JOQm53ZElVRzhoQ20yaUJaV2kyMW5jVkpt?=
 =?utf-8?B?aTJqejZnLzA1b1hMcXB2MVhydXk3SXhPWk8wcFV2blJQci85bWd0TUZ1TTlR?=
 =?utf-8?B?Tnc1QTUyMVZ4bjkyODBPYW1YeGNuS1BXK2sxY1NtRUtDQUN4OHQ1NU9OR3pr?=
 =?utf-8?B?NnBWNmtuSHF3bjVyUVFjdzRsLzFZVG1tUzNLRFd2VHZ4Z1k5TTAvaVh1NFVC?=
 =?utf-8?B?cjBDcDRoeDFzY0pxTmtxOGZLU2xCaEVVeXdnWmdEbTJKYkhBVUpSeWMzbmJE?=
 =?utf-8?B?ZGlMeFB3NVlpcmtZMVIzMkJpRHNmTmhxbldEL0VSQUlHQlgvc2NGOHNMOExZ?=
 =?utf-8?Q?hTcisWyU7qPIxuVOhVlockHC9Rk6Y1sOSREIUmdoYTXM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n2+O7YIjN0aF0wb7NrF7+lFW4pEKXXmuqRkev8IbWKZmPkLRITu2KSFpnyGmw4IexGRj4AZ8JVdLzaanI/Z/ym4WYtfgr7XiSeTVsX/1RKgLkZUItGNDF0pO0Mk7ldqOUNvtt1xeREk9jGyRI0AohBQnV8/nZc94rLvmM7nVuns8pBx+FGcH1NQSlZTADbvr0BZeBGI6dzJhar7KG1KvbX8voeXrZww4PIJAvN2d0L2VXjWiUtqWqFQ5E2PkWTkmJshD62afwXTrmd6pf//RAhsgSYgTdNVyailBqhUBuLVUs/f8VdkAjvpetFgG+oyeHDVYIMZfzG7jOAtYJeQ5T825Qi9gCW/J+ti8A77U8Jrs+j1KF5fbH5bJV0wQ6knvBLldUTJLvP3c9lPAmbkcp18Y28CrvgEDm9Zs49KnpnyXUKP2OUHtTnsgkBRYxEELxQ9gvCaM2P0dJlZ4n/zdSIqJIPzaSJOJCax0t9/6lsyM70IlLkNVMdpvAWPpU83/DEtXGXhNjVOkcHLWOl9XEMbshg26QjbmkE7FeWs5ylhLNFOXmiigMfixxIYie60HHkGDjkqmwCjUizwb+FkBTTK6TB7209oQia6Mq7RpsnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac842f10-7541-4f94-7d71-08dd1db4cc7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:34:12.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lLqPmD6s062q0ymTZsMMdG8ZtQLRtmvnInzkSNhDmYOpUR9QASLf697LLqrUyrXmOUjae1qGgNbAkpeKw+1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_03,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160079
X-Proofpoint-GUID: tTw1qVoamx4pEukvTCbgV3Miixpkwof1
X-Proofpoint-ORIG-GUID: tTw1qVoamx4pEukvTCbgV3Miixpkwof1

On 6/12/24 22:43, David Sterba wrote:
> On Fri, Nov 15, 2024 at 10:54:05PM +0800, Anand Jain wrote:
>> This feature balances I/O across the striped devices when reading from
>> RAID1 blocks.
>>
>>     echo round-robin:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy
> 
> The ":" is part of the optional value, so the example should be
> "round-robin[:min]"
> 

fixed.

>> The min_contiguous_read parameter defines the minimum read size before
>> switching to the next mirrored device. This setting is optional, with a
>> default value of 256 KiB.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c   | 38 +++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h |  9 +++++++
>>   3 files changed, 107 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 7907507b8ced..092a78298d1a 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1305,7 +1305,11 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
>>   }
>>   BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +static const char * const btrfs_read_policy_name[] = { "pid", "round-robin" };
>> +#else
>>   static const char * const btrfs_read_policy_name[] = { "pid" };
>> +#endif
> 
> Instead of the duplication of the definition please put the #ifdef
> around the experimental strings.
> 

Now fixed.

>>   
>>   static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value)
>>   {
>> @@ -1367,6 +1371,12 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>>   
>>   		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +		if (i == BTRFS_READ_POLICY_RR)
>> +			ret += sysfs_emit_at(buf, ret, ":%d",
>> +					     fs_devices->min_contiguous_read);
> 
> Maybe this should be printed with the suffix, "rr:256k".
> 

If the output has a suffix, we should also accept an input suffix.
Perhaps I could do that separately after this patch set?

>> +#endif
>> +
>>   		if (i == policy)
>>   			ret += sysfs_emit_at(buf, ret, "]");
>>   	}
>> @@ -1388,6 +1398,34 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>>   	if (index == -EINVAL)
>>   		return -EINVAL;
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	if (index == BTRFS_READ_POLICY_RR) {
>> +		if (value != -1) {
>> +			if ((value % fs_devices->fs_info->sectorsize) != 0) {
> 
> I think 64bit types and % could lead to the division which fails on
> 32bit platforms. As it's the s64 type for no apparent reason a u32 would
> be a better fit.
> 

Yeah, that will be a problem. In v4, I'm using IS_ALIGNED(), and we need
the value in the argument as a u64 because it also represents a devid.


>> +				btrfs_err(fs_devices->fs_info,
>> +"read_policy: min_contiguous_read %lld should be multiples of the sectorsize %u",
>> +					  value, fs_devices->fs_info->sectorsize);
>> +				return -EINVAL;
> 
> This does not need to fail hard, we can simply round it up to the next
> sector size multiple.
> 

Oh yeah that will be nice. Now fixed.

> Also this does not validate the upper bound of value.
> 

Um, IMO, there's no need to validate the upper bound as long as
it is sector-size aligned, because it always upto the use
case to decide. And, there is no theoretical limit we could set
in the code.

>> +			}
>> +		} else {
>> +			/* value is not provided, set it to the default 256k */
>> +			value = 256 * 1024;
> 
> Please use a named constant, then the comment is not necessary.
> 

Done in v4.

>> +		}
>> +
>> +		if (index != READ_ONCE(fs_devices->read_policy) ||
>> +		    value != READ_ONCE(fs_devices->min_contiguous_read)) {
>> +			WRITE_ONCE(fs_devices->read_policy, index);
>> +			WRITE_ONCE(fs_devices->min_contiguous_read, value);
>> +			atomic_set(&fs_devices->total_reads, 0);
>> +
>> +			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%lld'",
>> +				   btrfs_read_policy_name[index], value);
>> +
>> +		}
>> +
>> +		return len;
>> +	}
>> +#endif
>>   	if (index != READ_ONCE(fs_devices->read_policy)) {
>>   		WRITE_ONCE(fs_devices->read_policy, index);
>>   		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index fe5ceea2ba0b..97576a715191 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1328,6 +1328,10 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>>   	fs_devices->total_rw_bytes = 0;
>>   	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
>>   	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	/* Set min_contiguous_read to a default 256kib */
>> +	fs_devices->min_contiguous_read = 256 * 1024;
> 
> Named constant.
> 

Fixed.

>> +#endif
>>   
>>   	return 0;
>>   }
>> @@ -5959,6 +5963,57 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
>>   	return len;
>>   }
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +struct stripe_mirror {
>> +	u64 devid;
>> +	int num;
>> +};
>> +
>> +static int btrfs_cmp_devid(const void *a, const void *b)
>> +{
>> +	struct stripe_mirror *s1 = (struct stripe_mirror *)a;
>> +	struct stripe_mirror *s2 = (struct stripe_mirror *)b;
> 
> Please keep the const qualifier.
> 

Fixed.

>> +
>> +	if (s1->devid < s2->devid)
>> +		return -1;
>> +	if (s1->devid > s2->devid)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +static int btrfs_read_rr(struct btrfs_chunk_map *map, int first, int num_stripe)
> 
> Please add a comment explaining what the function does or how it selects
> the device.
> 

Added.

>> +{
>> +	struct stripe_mirror stripes[4] = {0}; //4: max possible mirrors
> 
> Another magic constant. We probably won't have more than 4 but it still
> needs to be defined elsewhre. Also the comment format is wrong.
> 

Fixed in v4 (in volume.h).


>> +	struct btrfs_fs_devices *fs_devices;
>> +	struct btrfs_device *device;
>> +	int j;
> 
> This is used in the for loop only, so you can declare it as
> for (int j = ...)
> 

Fixed.

>> +	int read_cycle;
>> +	int index;
>> +	int ret_stripe;
>> +	int total_reads;
>> +	int reads_per_dev = 0;
>> +
>> +	device = map->stripes[first].dev;
>> +
>> +	fs_devices = device->fs_devices;
>> +	reads_per_dev = fs_devices->min_contiguous_read/fs_devices->fs_info->sectorsize;
> 
> Missing space around '/' and we have the sectorsize_bits so division can
> be replaced by >>
> 

Fixed.

>> +	index = 0;
>> +	for (j = first; j < first + num_stripe; j++) {
> 
> Actually you can use 'i' for iteration.

Fixed.

> 
>> +		stripes[index].devid = map->stripes[j].dev->devid;
>> +		stripes[index].num = j;
>> +		index++;
>> +	}
>> +	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
>> +	     btrfs_cmp_devid, NULL);
>> +
>> +	total_reads = atomic_inc_return(&fs_devices->total_reads);
>> +	read_cycle = total_reads/reads_per_dev;
> 
> Missing spaces around "/"
> 

Fixed.


>> +	ret_stripe = stripes[read_cycle % num_stripe].num;
>> +
>> +	return ret_stripe;
>> +}
>> +#endif
>> +
>>   static int find_live_mirror(struct btrfs_fs_info *fs_info,
>>   			    struct btrfs_chunk_map *map, int first,
>>   			    int dev_replace_is_ongoing)
>> @@ -5988,6 +6043,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>>   	case BTRFS_READ_POLICY_PID:
>>   		preferred_mirror = first + (current->pid % num_stripes);
>>   		break;
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	case BTRFS_READ_POLICY_RR:
>> +		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
>> +		break;
>> +#endif
>>   	}
>>   
>>   	if (dev_replace_is_ongoing &&
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 3a416b1bc24c..05778361c270 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -303,6 +303,10 @@ enum btrfs_chunk_allocation_policy {
>>   enum btrfs_read_policy {
>>   	/* Use process PID to choose the stripe */
>>   	BTRFS_READ_POLICY_PID,
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	/* Balancing raid1 reads across all striped devices (round-robin) */
>> +	BTRFS_READ_POLICY_RR,
>> +#endif
>>   	BTRFS_NR_READ_POLICY,
>>   };
>>   
>> @@ -431,6 +435,11 @@ struct btrfs_fs_devices {
>>   	enum btrfs_read_policy read_policy;
>>   
>>   #ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	/* IO stat, read counter. */
>> +	atomic_t total_reads;
>> +	/* Min contiguous reads before switching to next device. */
>> +	int min_contiguous_read;
> 
> As this is in the fs_devices, there should be some prefix that it's
> related to the read policy or round robin.
> 

Naming is bit challenging given that it is long already,
I have renamed to rr_min_contiguous_read.


Thanks, Anand

>> +
>>   	/* Checksum mode - offload it or do it synchronously. */
>>   	enum btrfs_offload_csum_mode offload_csum_mode;
>>   #endif
>> -- 
>> 2.46.1
>>


