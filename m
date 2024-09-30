Return-Path: <linux-btrfs+bounces-8322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E8C989A04
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 07:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140521F21A78
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 05:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8EC13BC26;
	Mon, 30 Sep 2024 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PL/Cwara";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZKQ7W6zy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA1383A5
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727673985; cv=fail; b=ftM0QaohkUXDYHkl0h56sBOYB/5Ldvxgfs81px77xCd49mpWstT52UXxWdUNbyxunT1Xu/E3vvF3nbrMRHGl3Ob3IRUw+6NWuBtRWLTWkzoBRbIO1DajGBpwFCKM6884AXnZ46J4TYvhY0sT2ydgyox78adt4YleFCAOVczlZ8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727673985; c=relaxed/simple;
	bh=50WvZd1NF/WIDGmEKPh7MR4z3OK8AoQ88lW4rxDqYAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d/4KnW/f65wIAyqz9oQWdEN9GkAruk3WP2Gkh8dbZ+agnxxhJf/4yZicHI170L6tR3i7CGX0oSu6XGfxoHwW1NCmEAQkGGT0v+DfLD8X/qfNRbSStKEPOp30J/UNZPzPaIe+EQyfutLcauWEn0VI/fDJLgDBNILpVOHfBt4E38k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PL/Cwara; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZKQ7W6zy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2ta1e009403;
	Mon, 30 Sep 2024 05:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=da5YIceQyS5NLph/zZKYOnf0oRqGJ8Y+kucFsegcUN4=; b=
	PL/CwaraQrPnDRFC93VWZJOFGLFKEOCbcyOsU25I7uMpzXYZb6D5d7D2S5+/KO/P
	G1tqBmXcbbQQY8DMU57cLwFLsyJ/qPSbkRJPRUIHOUmmOyAE0rrTPkV/oo33JGkr
	5xIRi+D7zvNjgvXbRcPh6aWd8MsZn+u9Pw4z4mw4XhD/stIOswXazOo5T6hHUdDw
	FiDwGAW12fUJ+rKOmqUpAEHdZ2wDzR9tTbTvdLT72opcC1T2Tez9+bZgxQ65uLBh
	d9N0wpQTbo5CsvIihq6CCZybS9cZ9UG684OvB5LSWPkwWYcGjmzmFyWS/L0AU+87
	/DQsW/MyMLv/CIg24dofSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k32daf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 05:26:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U4Z3kN038658;
	Mon, 30 Sep 2024 05:26:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885jpra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 05:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpgSaOvhqDEdlgKwYKaoxFb7cO+r/eoGqPm1233LQtHi7uJQoRK3RsxpfI0cwlzeHaThrARphOayV6TdPrlwSh6nKLTOJiLwbp/mmcoKnx5uX5FevYacCKzSM4FMKunb+F2eNUzjMoIBrg5TCjCDPGUqJX4ZxkP/Q4WtLpm220kM+TIkYhHsDwi+98Z9xzrThrE1K5xTQvHUNTS4eLmaiCeH4cD3Tgj2/ossYMRfHKZ9hKUf2+djGrB29mo4KQdeSFYQK2q5QfzAnXChOkMqbIUF4bnKP+ZSytsM0uWvcdU48kGKtEzW2Q+CydmTj8wCjhpM7ASCtYgoaF/IhhSxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da5YIceQyS5NLph/zZKYOnf0oRqGJ8Y+kucFsegcUN4=;
 b=PhTdQJCO+TZAgDAI3nS6B7gnZErDFSGt/B4ctO8mNbp25Zbso5b0KE0Jr4ZLwga/d6xf/7RpJUULi4ghdU9fleHrR/552UM1whxB1XelHrHVhiDUzJaAiwZMZ2yLejzklXzfZ3oo7YfY7FxyNx4plS0L/at3Jv16q8zjptjYscL+fDIbqQfqRitFKH7YmiJKfEHH30JLEer26X1Ll6YSQl37bpl/hKjWodpfOO1zlWg0GjFMI86iJN2BIJg/6CgC6NhOJyQxp2bExdO3YlxjTLQ2m3r7CBtO0uokGrhHBXGkXLtX9OWXhptnSTAB81vRTubVB+kq7nmM76If0isYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da5YIceQyS5NLph/zZKYOnf0oRqGJ8Y+kucFsegcUN4=;
 b=ZKQ7W6zyftJquoncX/TzvrpMK8iVuF8bGTtFIxF/kSCPzMIIeA4M/AcsF1jve7TYAxAhWARFgVE+crpNfJCDvE3cSKYcSPGRr4616yR6BXDriSNvN7HqJzDSg3SYuPHHAvaJXHDCSJSFzffo+4FvolpwWypRNLLKHgsXQtL0sp4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5826.namprd10.prod.outlook.com (2603:10b6:303:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13; Mon, 30 Sep
 2024 05:26:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8026.009; Mon, 30 Sep 2024
 05:26:11 +0000
Message-ID: <af8014ff-d4c2-4f43-8602-49d11d4977fa@oracle.com>
Date: Mon, 30 Sep 2024 10:56:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: canonicalize the device path before adding
 it
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Fabian Vogt <fvogt@suse.com>
References: <cover.1727222308.git.wqu@suse.com>
 <3b0eb4cd4b55ae567abfc849935b4a72cea88efb.1727222308.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3b0eb4cd4b55ae567abfc849935b4a72cea88efb.1727222308.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca09c15-e5f3-4f8b-46d6-08dce110653e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDdadVprUGtpandDL1RDMVJWbTF2NzlsZGQwMHcyNWE0cGhKNVhsem9jZCt2?=
 =?utf-8?B?RHY1U3o3NGVmbXRTZEVrWHM0aUJpYUhkSmNTcnlZbVY2c0Z6ZGVpbVlsVXFh?=
 =?utf-8?B?WlY4MW1xYS9TYWNFa0xrQzIwSkFMZkdOem4xdEV4MUxWaE9FNGhtekRxVDAx?=
 =?utf-8?B?T2p2YjQwd3RwZkhhcWhQSDBxaXRXeXB3TlFHbW5pOUo5eXFFNXRsSVlwSWd1?=
 =?utf-8?B?NWJCeWEwZ3FweWFqVzFDMlpscmk4RnAxL3Rjcm1aYmZxMDk5b3F0azBtbmxW?=
 =?utf-8?B?dUZWMTdtT2R4OUpyM3lRTURKb1dNZ2JqaHRWcUM1VHBQTTFFL0p4STQrWVBB?=
 =?utf-8?B?WmJZbzRpd2g4enBMaUdPbUJwMnkyVWdyd1p5UFJqRFBnUGsxTThGSGhOVzAz?=
 =?utf-8?B?RS9BcEh0YVMzS0ROL1ZtNVkyRFJCMzlYeHdHbjUzK1d5cWVIdnVERjZaMGkx?=
 =?utf-8?B?bmhXeFlIRUJLZEs0MFQ1bnVCSzc3SkN6b1Q5b3UwUUlaaSt0NTFTVWRiODVj?=
 =?utf-8?B?NjBIZGJESjVjOVNTOVRvcExOamQ5V3VrcG1nd0duNXpLc01Jc3VWTCtudWEr?=
 =?utf-8?B?Z3UyU3BjRGNNTE9GZU5mZTJ4anpHVDdmbnZzWVFJeXBZWmlBVDlMWk1HT20y?=
 =?utf-8?B?djBtNVYxRlhrOXNHYkhlUDhCdzN4dmF6NGk5WWlYb0pxREJLQjg4Tm5HQnY5?=
 =?utf-8?B?aFVlM2NXVlYrTFIrbmFTbFNoVkRJanVZQ0NkVlozQWdLamRzK3YzcG5PSmNv?=
 =?utf-8?B?ZzJKVFpaOEVHeVVKWTNWK0xRRUZzSzZrQzFCUjdhV2RoYmR6R2E0Zk9vUVl3?=
 =?utf-8?B?SzhrVWZhMFNyak9uZWJVWUdJVDQ1dmE2ZFc0d3QrOEtZNDVDSjR3cGtCS1Zi?=
 =?utf-8?B?NW5Ha3Jtd1dqVTlnNjdpL3ViVEtZSUgwN1U3ZmNzSjBaRkhrSDh3TTV6NzdI?=
 =?utf-8?B?K0tHUXl6Q1VVWStsb2VtUFdqc1B0dGJyN3BBNU9XUFF0c1l6MHkvUFpWNE9K?=
 =?utf-8?B?K1dHRjBtdTlvOFdaQ1ZlT3kycy9JbVhrb3VyclI0WjFNalNFMll5aGFQV0k4?=
 =?utf-8?B?SmNOV2NCQ04yamlqU25Ld1FwOFlCaDh0Qi9PQVlPQ2k5ZVNLMnlaN215OCtM?=
 =?utf-8?B?TTF0OERuNkh5OVBiMTZmRTFOMFBTTTY3L3pmOW11WGVXRTVUZStSbHZHd2g3?=
 =?utf-8?B?MFJLdDFMZnA0TFcxR1YwK1lEVTVuMFNrTWNiRE0vdkU0QWx0VGJvUDZmMGFO?=
 =?utf-8?B?UDhVNTE3YWFyQTNZWWFwemxqZHpmdTlGbFhFRk5ldjI3OHY3cVlDd2NmSS9D?=
 =?utf-8?B?bHFkZHV6eWxGS1ZQZDIwTFZ3WERMb2x0L3pNK0FncC9tQUd2dWQ5U0ptWStR?=
 =?utf-8?B?Sm0zZG1hTmJJVUIyRnJFdGh0R2xrS0dwSUtyUWhXZkw3dkFUS0JvQ1dIN0dk?=
 =?utf-8?B?TTJ1OS9qZWYrVzQ1dy9jZys4YzBHUlpjK1Q0SnIyQXcvR053SEQvVE0xNXJq?=
 =?utf-8?B?ajNmQk5Sa0RnQ0puV1R3ZDczZ3ZLaW42TmdKSTZ1WVVPSVJod2hMWU9JZ1ZY?=
 =?utf-8?B?U3BkbHlCWHlwdnQwa0lyWS9obnljTllmTi9DbkxNWWpPRlhwTnFidVNXOGZS?=
 =?utf-8?B?Q3FCL1FZeGl6SjJPcmhBcTNublB4UnFveTcvTy9mUmM3a1QxZFd1WGdDQ010?=
 =?utf-8?B?TUI1dEVoL1pTckVoVCtxQk5EZERoWkRNUE1tMVZoN3FTelcyRzRYMDRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aENlZ3gyTFp0MzRBQit3cXFyZXNVWnRZdGtXVTNtRU9QWmplRXVkL1pzWVQ0?=
 =?utf-8?B?WlovamVITzZJRW1LM0FhWE9JM1B3UVJRTzJrWUp2Y0dabkdmSjdIWG9ueHdO?=
 =?utf-8?B?OE1md1luUkhlbGFjODdkbnNaZDk2REV6c3VEUkg5ZVZvMHFKN2creitsRDFj?=
 =?utf-8?B?S2ZCWHM5cW5pWTMzSTd2T2FQNm81UStkT1kwSnA2a1pmUWt0UC82dGFjeUZD?=
 =?utf-8?B?a2xlZ2djYkQxa2JmTmZrYmZsU2ZjbktUQzlsNFVSM1dDQUkvbzFXc0tEUE45?=
 =?utf-8?B?VzBPL20yMzR3SjQ3RGpoM095akhvU0NHd29ocXpPY0pMaFRhaENpNExQOTRp?=
 =?utf-8?B?VVZ1Vm9QOU1JWHZRcUovVjJ2cUVSUWsvMTZObC9EaXdKWTRJY0Zqa1JhZGpu?=
 =?utf-8?B?YVdoNTdyWGdNNjV1VmJrbGlvQWViMnRGVWdNd1lBaVRWbGhoNUN1MVJiUmtC?=
 =?utf-8?B?eHhpNC9vbE5Uak9DR3B6cWVoRVlzUXBRYVFPcXdiTFUweUZJL0dxR0tmTS9S?=
 =?utf-8?B?UnlYWit1dUlFdlhpQUp5UDVSRjFsbm00MDlxSmNCN25BUmo2N1F0VFgvcHFK?=
 =?utf-8?B?YXQrdTVaZkRxZjl0SElBQytnQXhOZk1IT1VySEtOWllPUHFmV3lmVTMzMnV4?=
 =?utf-8?B?RlEzdnFIOGNFRVI5RU9YTUpWRzczL25QdlBRL2hmaGUvUmVxNzdJUVRxM3pu?=
 =?utf-8?B?RnlmTk1jRXZlVTlmYlZTTkZ5Vko3bUpnVUp4T1JNZ3ppRmpib0JTbnIzbGxV?=
 =?utf-8?B?S3J6TStBcWdtN1VLWmJwM1FGSC9ydXVGenRPbnV2cVhLV09MQ0tGTWhhQTBZ?=
 =?utf-8?B?RzhhaWIzaGE0TWt4MGNERDN3a1dUeWQ2aXZtME1ObDlKNFM5Wm1ZNG9jcmdX?=
 =?utf-8?B?d1BJWHMrM3U1T0lXazF3aGR0em1FSnJMVWJ3dlpRUDdzSjJJTk9wUGhWL2Jq?=
 =?utf-8?B?YVlBbEdZSEc4UDJZNHBMZ01GU2tLYXY3WkszbHBXemlKZS9YZGNjdTJzY1RT?=
 =?utf-8?B?aVlJM0NHcHh1REd2WGdqbGxqSHNJVEZSbXdsVktnRTVEWjJoblZwR3Q3bG5p?=
 =?utf-8?B?clFadlRyYTR5eFFoWFZ3d05HQkJCRWZiL3g4RHYvRVZ6QXF3OHhVdk16REFX?=
 =?utf-8?B?czZYaW51KzFKTGtHeUx1RlBwWVdqNktUT3RPS2I1ckh3Q2lSZXh2RzdPbm10?=
 =?utf-8?B?YmZpUEdmUXp6RTJHR3d3WUFRV0dQNzFrVU9BMy8yUkNmcWhZNUZEcC9US3V3?=
 =?utf-8?B?dEJyN25Sa3ZuVFY0WlhFVzBSc0xlay82VWVzT3YvNmJvazdTWFNFV0pjMG1V?=
 =?utf-8?B?VVBoQ09LcjhqaktxWnN5TktodThrb21YUS9SWitnK0o4dVArd0lWdktVUEhC?=
 =?utf-8?B?aXN0UnlrVHRKNlVHYXI2azVxOHVQdWRPeVAyWDN3ZHVWQ3gvR3N4MDdwWkVq?=
 =?utf-8?B?TnUxVkV5WkdhOVhrWjRvL2FJVjZIeE1OS3pneFBxQ0s3NUdVUXcxSG1sRWlH?=
 =?utf-8?B?NjM1aXFOUlRzRkgwSWdpbU1MSU1sNGw3bW9KWTJPMHhET3VqY1ZoTVJERmZR?=
 =?utf-8?B?ak1JU3JGelZ2ZFhwM0lVUHRBWnNlT2lBNXAyakQ2ZFRISVFscUZIR29jRXYv?=
 =?utf-8?B?eTc5a3k0ZU1SVzJyaVV5WHcxSkFKT3o4WW9VK2tOSmZJRVdCMkNOSDlGa0Fl?=
 =?utf-8?B?TVhIcHNPL2szM2RqekFCUFcwaWJyOGkxMEVqNzhXSWxjY3FDRndhaEZ0b0hH?=
 =?utf-8?B?MWpOaXFVbWhrTS82YWozRk1sM3BhUTkrd2pYS1Mwc2lxUC9SMnltMWV1b0pT?=
 =?utf-8?B?K1Fxd0g2dEJqVUxVN3FjeW5mazlaRGZIaUg0ZFZnUytTZkZaYmRWbit1Ty82?=
 =?utf-8?B?dkM3V2VjQVhMaXloOFRnR1JweURGUjdOZlVycnNCV1p4dHRzUVg5SW4yaldn?=
 =?utf-8?B?TklRZGdMRmtiY1N1dGJrbnlqWlFWZk5nN0ZmUUZSUWs1UWk1Skt6ZGtGb011?=
 =?utf-8?B?Z1I2NlEvZWpLUWFTMWgyZTdvVWZyTXlNSWZuUWZoMkczZ2IxYVl3czBLN3hM?=
 =?utf-8?B?anByVWpTUmJMWk55ejkxRTlIVGdQVHBQVm85VHg0WUZwSms5OXBOQjBCTFRW?=
 =?utf-8?B?ZEVnK0lLTjY0N2NXSG96TUY3REVHdXRSbnFRVWlUeEV2SERvM0N1eGN1ZVJW?=
 =?utf-8?Q?/BMO4xF4qX/ffi+iI6IJ1/Krno9iZaxyeXxQFXCvDnl5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+EcH/e163L6Vr46Ur7bJ4Y9XvcuV1h5u8mIZjBFAE5OjHhclXPgFzXDHobfvGL2W4SdTluttscATHWTZNNtQEg8+6nzzodqwqbm2XbdBBqflLwUymlfXVxYB3JkxZajpvYgLVVr5kRlGZYHozyiOqP8ES40OA+XV0aRCkSY2e4QElf/jF5+niCf68oGUhDgDAvQE+sjtwmCWbvVowxxIK3+1q0jL5LQ2QWazdFyY4zMo/s39IRAghaDNk+dCvC3VsHQOkEX9mleQJS13Q1UN3UYDk2JDFEZ1o8Gr71HaCwZdK7QpFVKloes7QlooFlqMUS0OTk+DWZyx/h6GV9kA6z78ZzbCaSghON/2oTAIAYcwIvXm/jMvtrFUSsEHoHKn5HXKYZw2cgTikXGGydfyHRP10O79tf7mI5n4WHVi2i5Eb7A207fhIOL1Hcmq8sRtLpQ+bktfDBUtmISusgwJ1ACrQVdAhsP4/srZWfpzIl3nxBDwJYaUdM3+ZGOTtC1UxfqNM1XynJVDpwUIYlk0jGKr9Q91WjQIXGL8gqLkLmXDLmFNouiml7aRdXBvpsqdzGY3FGRK0+stQxEBNlvbeJLxUcXjU9wCcrHLAvPvoGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca09c15-e5f3-4f8b-46d6-08dce110653e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 05:26:11.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtqmADQrWaYxunqjAX/nQYGL5TjSxmEAQWwXL4Y/yo0kXGkXqWpvyC2W8Ev2i/nCL1zjW7Z/qQTaqVSUjGMfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300037
X-Proofpoint-GUID: AGLfDgdb005F4c7wbRqpzr8z_OfuLqZH
X-Proofpoint-ORIG-GUID: AGLfDgdb005F4c7wbRqpzr8z_OfuLqZH

On 25/9/24 5:36 am, Qu Wenruo wrote:
> [PROBLEM]
> Currently btrfs accepts any file path for its device, resulting some
> weird situation:
> 


>   # ./mount_by_fd /dev/test/scratch1  /mnt/btrfs/
> 
> The program has the following source code:
> 
>   #include <fcntl.h>
>   #include <stdio.h>
>   #include <sys/mount.h>
> 
>   int main(int argc, char *argv[]) {
> 	int fd = open(argv[1], O_RDWR);
> 	char path[256];
> 	snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
> 	return mount(path, argv[2], "btrfs", 0, NULL);
>   }
> 

Sorry for the late comments. Patches look good.

Quick question: both XFS and ext4 fail this test case—any idea why?
Can a generic/btrfs specific testcase be added to fstests?

Thanks, Anand

> Then we can have the following weird device path:
> 
>   BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 transid 7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (18440)
> 
> Normally it's not a big deal, and later udev can trigger a device path
> rename. But if udev didn't trigger, the device path "/proc/self/fd/3"
> will show up in mtab.
> 
> [CAUSE]
> For filename "/proc/self/fd/3", it means the opened file descriptor 3.
> In above case, it's exactly the device we want to open, aka points to
> "/dev/test/scratch1" which is another softlink pointing to "/dev/dm-2".
> 
> Inside kernel we solve the mount source using LOOKUP_FOLLOW, which
> follows the symbolic link and grab the proper block device.
> 
> But inside btrfs we also save the filename into btrfs_device::name, and
> utilize that member to report our mount source, which leads to the above
> situation.
> 
> [FIX]
> Instead of unconditionally trust the path, check if the original file
> (not following the symbolic link) is inside "/dev/", if not, then
> manually lookup the path to its final destination, and use that as our
> device path.
> 
> This allows us to still use symbolic links, like
> "/dev/mapper/test-scratch" from LVM2, which is required for fstests runs
> with LVM2 setup.
> 
> And for really weird names, like the above case, we solve it to
> "/dev/dm-2" instead.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1230641
> Reported-by: Fabian Vogt <fvogt@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 79 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b713e4ebb362..668138451f7c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -732,6 +732,70 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
>   	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>   }
>   
> +/*
> + * We can have very weird soft links passed in.
> + * One example is "/proc/self/fd/<fd>", which can be a soft link to
> + * a block device.
> + *
> + * But it's never a good idea to use those weird names.
> + * Here we check if the path (not following symlinks) is a good one inside
> + * "/dev/".
> + */
> +static bool is_good_dev_path(const char *dev_path)
> +{
> +	struct path path = { .mnt = NULL, .dentry = NULL };
> +	char *path_buf = NULL;
> +	char *resolved_path;
> +	bool is_good = false;
> +	int ret;
> +
> +	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!path_buf)
> +		goto out;
> +
> +	/*
> +	 * Do not follow soft link, just check if the original path is inside
> +	 * "/dev/".
> +	 */
> +	ret = kern_path(dev_path, 0, &path);
> +	if (ret)
> +		goto out;
> +	resolved_path = d_path(&path, path_buf, PATH_MAX);
> +	if (IS_ERR(resolved_path))
> +		goto out;
> +	if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
> +		goto out;
> +	is_good = true;
> +out:
> +	kfree(path_buf);
> +	path_put(&path);
> +	return is_good;
> +}
> +
> +static int get_canonical_dev_path(const char *dev_path, char *canonical)
> +{
> +	struct path path = { .mnt = NULL, .dentry = NULL };
> +	char *path_buf = NULL;
> +	char *resolved_path;
> +	int ret;
> +
> +	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!path_buf) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = kern_path(dev_path, LOOKUP_FOLLOW, &path);
> +	if (ret)
> +		goto out;
> +	resolved_path = d_path(&path, path_buf, PATH_MAX);
> +	ret = strscpy(canonical, resolved_path, PATH_MAX);
> +out:
> +	kfree(path_buf);
> +	path_put(&path);
> +	return ret;
> +}
> +
>   static bool is_same_device(struct btrfs_device *device, const char *new_path)
>   {
>   	struct path old = { .mnt = NULL, .dentry = NULL };
> @@ -1408,12 +1472,23 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   	bool new_device_added = false;
>   	struct btrfs_device *device = NULL;
>   	struct file *bdev_file;
> +	char *canonical_path = NULL;
>   	u64 bytenr;
>   	dev_t devt;
>   	int ret;
>   
>   	lockdep_assert_held(&uuid_mutex);
>   
> +	if (!is_good_dev_path(path)) {
> +		canonical_path = kmalloc(PATH_MAX, GFP_KERNEL);
> +		if (canonical_path) {
> +			ret = get_canonical_dev_path(path, canonical_path);
> +			if (ret < 0) {
> +				kfree(canonical_path);
> +				canonical_path = NULL;
> +			}
> +		}
> +	}
>   	/*
>   	 * Avoid an exclusive open here, as the systemd-udev may initiate the
>   	 * device scan which may race with the user's mount or mkfs command,
> @@ -1458,7 +1533,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   		goto free_disk_super;
>   	}
>   
> -	device = device_list_add(path, disk_super, &new_device_added);
> +	device = device_list_add(canonical_path ? : path, disk_super,
> +				 &new_device_added);
>   	if (!IS_ERR(device) && new_device_added)
>   		btrfs_free_stale_devices(device->devt, device);
>   
> @@ -1467,6 +1543,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   
>   error_bdev_put:
>   	fput(bdev_file);
> +	kfree(canonical_path);
>   
>   	return device;
>   }


