Return-Path: <linux-btrfs+bounces-12928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C1FA8336A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 23:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3627D7ABE9E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035321518F;
	Wed,  9 Apr 2025 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c353VEF/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ByLy4Nj4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAB212FAC;
	Wed,  9 Apr 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234315; cv=fail; b=e+9o/mpdetmVwiaRCog/F2rVglBWoLTNJMljF373TPQAyKUkIzMNDffgMjRrc4oGSCVQvmcYJwtn0zlKDFf3qBdFw7Pi8SMlxI2ABAg1tWSTCVinRD0RcKhp+paXs2gSjfGc95Clt0shRciNwmpaJ6Byh1XFdfsXMTkrDRRBIZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234315; c=relaxed/simple;
	bh=tQ7zfYhgR0w/8vb9LV7MQuedWndLe6B6qwG8zKNCKEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jx2asFLnxlQ2ZYgYSDWrYwdUprZOc0p6OetYqprkyGkp+wlsKl/dTdvluA1r7v8oLZXmE5N2nQHBbbAr69jCwnFngb/+1peDqWzUfAX+BKF1k13SBZO2auDWbYKAqFTwFA4Ifpmnal2mQ3hn2AyotbxcTU1or66YO7ErkRhUA+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c353VEF/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ByLy4Nj4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539LHmae000572;
	Wed, 9 Apr 2025 21:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eQ1BtXybugd2dK5wjO2OXSULwsdmWVO4JEoiMAEHQZg=; b=
	c353VEF/P/IdTRwANR7ThU8IdyYqRI2GYig/3xt8cQBiJkZVvmA+G26UUqOJJyoO
	yoj6hNpRgxLRG2ckrayN/PpzBSt4fLcb7BF2NjAQgzZ9pQxjXkktgLLGoUzRb29t
	YSZYTOwdrcj9EJpCwTD9G3bsaJ2dqRtxXzW8HDFhsI+EGfC+TEpwZHI5gkgR2U+6
	fylnIduVIGsF6XlfxKlpiWGrTUNmK8PTCbRNIfUf02SJUhfli4le3gDF6EVQlHfQ
	lY593qwgZjDdu/Ez4AmTdQrP2w/I3dqH64Vxt1/wPYZSllzm7MW1+J8D4lhUqhi5
	3b0VvrSjQvIF8aHCAQsa/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45x0nur0mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 21:31:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539L5q5N001477;
	Wed, 9 Apr 2025 21:31:46 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011026.outbound.protection.outlook.com [40.93.6.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttybc5d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 21:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6dzSDqXnsDsyHq2zypczOXnRo+zUxs1YsM/izC8sVk0ZZifRsLZVgUAwPdJTDYgc3zTWDFOXwVg1zkbLNjPsjZ2eHy91tPQK6QkheyYH97JVLwQMf5sPVtQX0eausx9Q9MSSY9Fa4thiIF7fadoIkWXco+9yFwWsrswbFjgAQ7WfwDyvBGZ6AXa60ttH/t87PcT5+8RPTrZjjfMCOvXiElvNDIrHcOp5ZAF7+HaLpXrgVpZl1is6adqwpiFXcnpAJIjKeJpaxtttMpWDT7IMw9Qr3lGrCB5c1QMbbf1OmIT2ul7tjgVE4gnLqhrbOw6lWeR8XirNJk2ihO7773jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ1BtXybugd2dK5wjO2OXSULwsdmWVO4JEoiMAEHQZg=;
 b=xxbhxeiYolgjki/AVMCoGQbafCpOUmsBtUuIvm3smOEFZ2XClVTZWjgJo/m4h1Le2CZ49Wtv2rXVo4yU/eGgusU3Dmh3rQPyGPhumZ6llWAFQuGefzJIG4K94omU32FZLdM5NorFFdfabW03dP3DAKjaeKwi80wtjA+ONTm5bWxorYCmqXBP0HlsvB13RSbirogP1OQ9uqVjRjXH5P4Zo8mgD5SmAF9PGjJmpIED1I8PjZMk7bbVGchRCx1O4Th3pF6ZRgomzgZpdbwyYouK+sLQfZd50j2eOCUWdCCNnhzgh2c1l9qGJ3u3qzu0f2pi0OtvLtXrs1WtILnsOP9Fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ1BtXybugd2dK5wjO2OXSULwsdmWVO4JEoiMAEHQZg=;
 b=ByLy4Nj4sb1lXBBS+WppOJDnRV50ziQUcARdWy9FDCA2gdmbTJBGc7X7Umv4qtwtt+AU2Ve0jJbPQw8pzpzPbX9u98KhmKHctWvjhhr8v0NxVI3ZM9MPQTD86DKzTx7XLxtbaYgX3usJOlZ5wMzguqwtDBHSsdD+7llWJlBDLPs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6310.namprd10.prod.outlook.com (2603:10b6:510:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Wed, 9 Apr
 2025 21:31:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 21:31:44 +0000
Message-ID: <9dc6a550-5e4a-4ff1-8961-9d6dd758a83f@oracle.com>
Date: Thu, 10 Apr 2025 05:31:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] fstests: check: fix unset seqres in run_section()
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
References: <cover.1744183008.git.anand.jain@oracle.com>
 <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>
 <20250409095725.xumxhw54igwapuue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250409095725.xumxhw54igwapuue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: e46fae73-a74c-4888-0f58-08dd77adec86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TklqTWQrTnIvWHVDNGVlTEhuODNzdmhHQ092bjNsbXNYNWkyZ2hMWk93V0lu?=
 =?utf-8?B?RFdRR1ErU3FKVXdTbDZRVkN5VlVaUElSS0dMQzRhamlwNVJES1Z5SjZxTHpO?=
 =?utf-8?B?Wjk2bzdlWWZyOWMwSG9UK1gvUTNLaW1qdzltVDFuM1EwTm1NY0JnbzlpeVJT?=
 =?utf-8?B?VllDaFBWVFdBWTJyY3d1bWwxSEtJcTF2c1pMMStvWE5JMnRXa25NZjhzazND?=
 =?utf-8?B?T0pwZC9SNDFNdkU1NXQ3Z09CZk53TFl5TDhydUVXTzd5akRCNTNtWVJuSDh4?=
 =?utf-8?B?Y2dPQmRSeEFGS2dQcUJUcFB0dmFYOEY1cG1kS2xac2xGY2FhSDgwVHlianN4?=
 =?utf-8?B?cDBIRVBERWFnUksvVUZ0RVNUNGtoODFBQ1p5SWsybG84M2dxQUk0d2lHODJ0?=
 =?utf-8?B?RitMSlVjMXpYQnNVTUhMYlpDSG5FcnBlai8raENNcHlBdkxOemJKdy8zcS9q?=
 =?utf-8?B?SW1VN3BCTUFGVE5DelVhdzJIaEwwZzVHMmtPODhTQVBFTTg3MUo4Z0ZoY0F4?=
 =?utf-8?B?Uy9kWTVFSXRUOHJZM0tDUDlZRnptT2FXYUZQQno1dE1Va01mSGxHb2hKdTcr?=
 =?utf-8?B?di9KYW95M0Rab3ducGs3WlA0OGwyUmxuN0wxaFBuV3FqcW9FYitrOHhmUUpO?=
 =?utf-8?B?dFhzb0pjTWVHRXd5YkVVMVdQQ0RGcENNa2hDN3liRGZ0bEZNMDNBMVAvU3V3?=
 =?utf-8?B?TnpEMkVwNU0wV0lxNUFDK1E2bUJCNUtIbGkzM1AxMkY2YUV2YW9VYy9HM0RM?=
 =?utf-8?B?MjByOFNSRnpPZnVRREhQcjAvNWNqOVYrMGs0akNnSTlXdE95NXY0TTg1RnlP?=
 =?utf-8?B?K3lyZ2srcm9kQUJhQVJqV3RnRW91MU11MUVibUgrblVxampBUHFMUDZQT2JN?=
 =?utf-8?B?QTB1dHpVWlN0anNkV20rMkM2eUlnYW5hR1pPc3JsUHRVSTZzejB0WlJVZVpr?=
 =?utf-8?B?YUg2VXF6amczbFlydUkzblIyVzQ1eVREbTJRdkVoZDFtNmVHekNpWjROZWVk?=
 =?utf-8?B?dnhXUWpBdDdFaVNWNU1HN2FTMmU4U3daNzdWRitpTDRzdy9rb2k0N2Z6M0dr?=
 =?utf-8?B?RXdqNzBjVXZpSzRIUlplVXgyMHdMZ0taNHo0VjI0V01XWmNOUWRJRThNaHVu?=
 =?utf-8?B?ZzljYmlOOUZQaGFIV2xHanpyNWRmeUNFangwMG5Beks2NHViM1ZzWjM4VjhV?=
 =?utf-8?B?MW5XekJzN0ROc2Z6UjhzdlZsYkFvK1JaOGUxRGZTSzZoTXBjQWp6ejdwbUh5?=
 =?utf-8?B?Sk5LeG1IdVFRK2tJMkt0MUpUd2xrTFQyOUVRQ1hyaHlBY1kvcUpYVy9ob2ll?=
 =?utf-8?B?K1JLd29kRklYR2dEemtyWXJYa3hjNjJheGdNQW1tL3ZnT1h6QXd6SlJZTW1N?=
 =?utf-8?B?NFRMaE1KVll3WkQyQm8vRTM0T3JUT1VPUDVBbFd1N2Y4d3NEQnJKTmFxQ1Ji?=
 =?utf-8?B?OElLVmJ5cmxyRUhBZmQ0M1QxNk4vRENOZTdPS3UxcTZIYk5oWFNvVEh0MTVM?=
 =?utf-8?B?SktCaCt0NG02VUdKS1hVanFZSUplWk5yOWUzc3lGd0puQU5UNEdVcWRNSEtF?=
 =?utf-8?B?R1VmekpzSHFxaUdoN2NFbFQrZXlRTG5RaUxqQWtpV3FFZCtWVDZoOFFrL0ZP?=
 =?utf-8?B?UGQvZnllWFBVZTNncDZDWHArd0RBUSt5WXJsa1lleXFWZyt3cjlGKzJnbXF5?=
 =?utf-8?B?M2tZSnFGRzV6cnhuVGIraCtiaVArN1pvd1RxOW12RlRHQ01XV2NSTkZWa3hL?=
 =?utf-8?B?eUdJVy9uS0xzZWkzd0hzYnpHM3RKN0hidTlCVmgrK2hBcS93aG9pSEZsNjFC?=
 =?utf-8?B?S0JpMHFUandJY0s4NjhrZTY3VE5WMkwvSUVadEFGZHBxUnhaTEVUVkh4N1ZH?=
 =?utf-8?B?ZTNFdEFkNzNqWWtHQitHcVFnckowNXFyVWFQR1Exd2hNMmp1ZFJqZlJXMjdC?=
 =?utf-8?Q?4hhTwt+LaIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnM2WlVtcDN6SlRXTjd3VExvMURlSngrL2pvelJUbk1FVUxFU1lEZVpjL3gv?=
 =?utf-8?B?VlhvaytuZU9uSlE0VWVKeUJzYzdQRTZEUXVOM2dwbkt0UW1aNnJZbm12M0Z6?=
 =?utf-8?B?OHZqTit0MEhuUEpLTWVsSFA5aVJOd0tFYVpLNkc5QzlIR2g4Rm1sTVdOY3Q1?=
 =?utf-8?B?Z21ROHFEcVVsUUpxVXF3bFBYd3NUMVBNZDBHSW5yd1B0b3BmMUxuaXllaVo5?=
 =?utf-8?B?MGIrb0VKeWVqWkRnWitwcEtsdUdmaHBwYnVRQUFMcUo3Z2tyT2t5cTJnZU9S?=
 =?utf-8?B?OXJVakJQOUt2WGFQL3MzeDZVTDVRa0lNUStqQUxxRmV6NjB4SmFNMFhKL2lK?=
 =?utf-8?B?N0k0Rm50R0wrY2dPVCsvbHNNdXlTdGFKMDkrSWJHanFlWXpOSUlhM1VNazNl?=
 =?utf-8?B?Ym5jcmM5UEU3b25MUENsalEvTVIzeW9pQzhEem1PVE0zbldLUHMxbURDK1FQ?=
 =?utf-8?B?eVlwWlJ6U3BvVEZaNkhYWHFwRDRUK1psdG4veWJObWVaUkZFdlFwNlVyV0hs?=
 =?utf-8?B?MStiOUJzZkRmVzRwU2kvVDBUN1FSaFJ4TWtsZys5dEUyUGFSRFBSZHFYOCtI?=
 =?utf-8?B?ampsVDBtdHdOdFJaU3Y0alU5cWpmTHp5VUdEdkRqMXhpcEUzYjZ3UzJmZ05D?=
 =?utf-8?B?dFVVKzdxYUREcDFxeXFtSTAzUWpWckU1Ny9qOWZQM2tlbjQ0TEFPTVRPcUhh?=
 =?utf-8?B?ZndSUHRmMU9YYzgvUlZiYzRDaW5mR3pzRkdjYWtNc2tURmtnMXZmSlVuUWda?=
 =?utf-8?B?MzhENkUzNzV5K0R5ZFpZTG9lTzFJd0gyN05HYXN4WVRHb3JOQzN0enVDanpn?=
 =?utf-8?B?cjR0MXBGNHR6TUFrQWNKV1I2NExpbThmQ3NaR2F3ZkF6Vkc1WDM0dTh3LzJy?=
 =?utf-8?B?UzhGRUd4R1RBN0lPeDM3Q1N3Rk9uWDNjL1VDbFFwQjA0enY3QzMxZjVRYkxQ?=
 =?utf-8?B?UFA2eUp3ZzY5d2tRMzBYdVlFQmZSVEw1Wi9Fb1VZRUxNWGVvVUxPUXY5THZE?=
 =?utf-8?B?dXRGd0xEczM1SEtUWi8rcXRJN3lqdW53c0Vib05VK1Z0R25IU2NOYVRaZjdN?=
 =?utf-8?B?VGJ2eW5ZaFlHNkpoMzQ5ZnNNRmVZMUMzNDA4amRVSGVrdFhtZE9vK1NKWXpn?=
 =?utf-8?B?VG04dW1KSG5yRlU3VmNyNmZ1TUl4d0JHdmhYNXdjMkxJdEtCbld1citzS1ZO?=
 =?utf-8?B?ZUhvNStvRVZUbTlOb2wrQ0FaNTdZaG91SHZpdkxPT256Sm80cVhyS3hOVkRE?=
 =?utf-8?B?K2ZTN3pkYThZb0p4T1dweG40RkpDd3A5bEFuWXA4K0ttTVcxMUlFeFZyalhL?=
 =?utf-8?B?ZFdtd3czRmtIeElnUGQ5bllzVmJZOVZCL0VveXRTZ0pENzNlLzdYUEZIdkNO?=
 =?utf-8?B?ajhUVHJXZTVVci9PbUZSSFBoTEtzYW84aXhqV2FGTm5NWDZzL0xJL0tUbTR1?=
 =?utf-8?B?a1B0aEtiM3dkWWVpaTVmMW92QmEvdW0wQ05aYmtsYmFNWUpYWlYrb0ZhT2dI?=
 =?utf-8?B?Sko0SEF5Y016NkIzUTdCd29McGRYMXcvVTVRTlZta1V0ckFuQUZBbllqdUha?=
 =?utf-8?B?bW5QVURyaWhldzFGOFEzSm9hV0U1M2N5UmFEbHhTMXVPK0VVQkpYQ09TeUNL?=
 =?utf-8?B?a0hUblVXbCtvZjRnaGR3ZE0zcVZHT3ozUUNIQXNkZXQvd09Zb015VjFVblp3?=
 =?utf-8?B?SlNLMVZDS3FDWVllU0NoazRPcGtiUlNMZnMrQnd2MmlkbVh4dENDQVFhaGpW?=
 =?utf-8?B?a2dNL0Y4bXhEY0FQQjRoTUxHM2NzN3NpSnpTSWNlRk9IWUl3Q0pBWEh1cjFH?=
 =?utf-8?B?N2JlQzhYMC85d3NKcjBoN015WDlORzVvbVhZRmtSMHZUZUdsZjhqZ2VJMWhE?=
 =?utf-8?B?OXE3Q2xndGZ3ZVBnOWZVZVI5VGZIQ1M3aDA4RHFCd2M4ZmRpUFUwbi9hcWlM?=
 =?utf-8?B?ekZUS2hDR3FHakYyeWFNTmV2dVlYeTBrQXU5aFRzUVFDSmtjTUNYRGpNQUgy?=
 =?utf-8?B?eWVCeEZaTVpaVDF2eDREdFc1eGVDbDJBeDhZcjVxRW04Tnl6SzF1eGtLRWJq?=
 =?utf-8?B?R3FUQUVOVDA4Q0pKcTBPREFnQ21OVzdadDZWY01LMkMzYmlDWGYxUnorVUQz?=
 =?utf-8?Q?tQRu7l6vSfcfJv9OErWxwAe30?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rOjFwGQmMeXIjThfpb60HQ1gxf7IL6w9t/Y9r7vs6JATaM8dIOeG9jUdVaHmFwHMxwm7wJ3Nd6AhvOyU+PzdkdVl0t+CKTMBnadnEMjAWTAevQM3zoQ6xtpe4qhIj00NuRLME/eYcJW5g33zBhQM26JR6YNV5MRNEbjt1h36QDynmOB62+OE13sqcnR4RXRfTmhYeXOP2M1EpdC1BNbMkuMcGJ3z6tUWpx7eI+CWk4YNSPr/cVnORG4UhrShigvuSurrUWNA3QOsiK25uJnZW/CVdWIYbiyoU2uxU6dKGqbocq4z9zd52iIedXBB26m75ATVyl+1TN2d/46KGk0n0m3Y1e80uS2TbODOAkhB3IjsoWcPQqynTvMYxJzNINgc5xre69TlYitKWZ8jMIH5OwlBIfXl/fjxQWxXFMkTD8jyZGJD1255rma4uwDo0WBNWeOtNh3pei2CZLRuWd4sJdAZONHTEiy9iUbdFIBpdlm07L69y7CspVqnspZjIvamJTiw+yu8RjQQCDiHF7vZLitmxrGHIhYZmCy+OcvWazI5s0RkPlJIr/uZke1doFjpPVKb3w9Xw9Hx6mREbXzefAbfauGxtugTl1PbtayuaLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46fae73-a74c-4888-0f58-08dd77adec86
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 21:31:44.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLzZQZ/UDntnzRkv4VMZgy1wQTbPgg5gp4169igsxL5Us2k28ai7RXvQBtzTRd0trKltcmKSCCcH4lW7SlxK7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090146
X-Proofpoint-GUID: kFUjVjBEgfCYgjNayGmnPlUH1MgIt6bn
X-Proofpoint-ORIG-GUID: kFUjVjBEgfCYgjNayGmnPlUH1MgIt6bn



On 9/4/25 17:57, Zorro Lang wrote:
> On Wed, Apr 09, 2025 at 03:43:14PM +0800, Anand Jain wrote:
>> Ensure seqres is set early in run_section().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   check | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/check b/check
>> index 32890470a020..16f695e9d75c 100755
>> --- a/check
>> +++ b/check
>> @@ -804,6 +804,7 @@ function run_section()
>>   
>>   	seq="check.$$"
>>   	check="$RESULT_BASE/check"
>> +	seqres="$check"
> 
> The "seqres" even might be used earlier than that. If your rootfs is readonly,
> you'll see that.
> 

Zorro,

Thanks a lot for the review and RVB!

I’ll take care of this patch 2/6 in a separate patchset.
Meanwhile, could you help merge the rest of the sysfs patches,
except for patch 2/6? I don't want the seqres issue to block
the rest of the sysfs patches.

Thanks, Anand

> Thanks,
> Zorro
> 
>>   
>>   	# don't leave old full output behind on a clean run
>>   	rm -f $check.full
>> @@ -849,7 +850,6 @@ function run_section()
>>   	  fi
>>   	fi
>>   
>> -	seqres="$check"
>>   	_check_test_fs
>>   
>>   	loop_status=()	# track rerun-on-failure state
>> -- 
>> 2.47.0
>>
> 


