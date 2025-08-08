Return-Path: <linux-btrfs+bounces-15920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44AB1E1E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 08:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF433564614
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 06:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C21F63C1;
	Fri,  8 Aug 2025 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aIqb5Mcq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F9npkrx3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098F21CC4F
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632811; cv=fail; b=mAvePp4JUoYb/JiiQBFaxy18NZuMdyrgfiyaW1FendVsDX5bqajQhxWzKw3HtulausXRHEbBiyLwchrBZZ0l8KdHB2G7C/MEdeXbP+GePCtWn5pg5vxLGZIjY6FWK2EcRb9ryVBLd2REq7+tKd1aBb3jCOom7fq44FVm9msZ/mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632811; c=relaxed/simple;
	bh=4s61k0iQ+kMLuCAuu6H2HgAXm6p0OtdFdf/0v+Bj/jQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pX1OP/62DxNnkqhP739vQAQ4OzvivKu4wJ9EZY0Bgr7aRt2d2SuLoeGbgsPB35D47cNCJDt+dHlFqxg8R/0OfKdxF6wYfwuWUQp4H/JGb646+cbEyP2Ub2KGJHY4qyWlqS3BX8wkaxI3IS/TVsYv+664+DJjPWzIEliGKPzxihE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aIqb5Mcq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F9npkrx3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5783uEeh020825;
	Fri, 8 Aug 2025 06:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4s61k0iQ+kMLuCAuu6H2HgAXm6p0OtdFdf/0v+Bj/jQ=; b=
	aIqb5McqPUC4GFn4EW1qAUBCANCuvfwNROTtKPyTdAIPg7zuFrUUgxCg0o9cE4yq
	N9igf0yVA0y3LswMpazNLg2oJXuK/3hI8JzYiMbUlQ8Y+J+m2EhwpEv1YubnmMnW
	gkP4+i04xeWQ25IOFAAL5GjvE7FG6QOgHXE8hJEx46lQRkq11VpDU+eZNXSS0iBR
	wvffuU4h2K9smJ14/0QAdB+S74J1k83BMoUFP2DDNJF4aiPqOlWgCo5qDE/5mMhH
	HWFvPK84zNJYsCMbO1gVj53RtTwCUfrP+OTPiY6tQTN8OGyRlhFnZ0/5lpLERGrV
	a7WmrjJykltjDY1CZNWlEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgwhar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 06:00:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5785WOA3032102;
	Fri, 8 Aug 2025 06:00:06 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwsvyn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 06:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okXPCg8tXiwoG2mHMzQUT6kurxj0zdhdjmV7ZsXbER0XjakYIaMOjlyhjj9h/I4PX52w2YqRiIYHWWa2og4ZbAA9YXpLDu7YS7kYXuhHCbBdvK0Xsh4j8oRTebU7Tta+vuQYN2Lzw/pQeDBo47k0WLdZI7hGPotgfPeppvkA1qXPfNFGMY/lx276Foo/TuVOj7U9LU4zz0ZASIeaX9hs1ojp/GXySeQ+ZEJge/87QdTY1cmv72b1mGOj+KRnAmjrUJq5WebP1qKD4RS4PgpVxiaFP8yrIP7YNYs90gFFz1D8UJvan9HuekB8bQVA+DWBSqKKeDHR9+0QFBj3R8iEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s61k0iQ+kMLuCAuu6H2HgAXm6p0OtdFdf/0v+Bj/jQ=;
 b=fei2W8ibGSjTb7c5gY5z8x3ReoSZY9xUj2I/npD44kSPxS3v+i+ZyMjLxK3c606xowfVTZNIn726PASA7Vs00ni96uDWjm/SqK6ejvMWpyjj3VLUkFhOPejn1Uf8K5g0nl9GpmYwYOouhoP29WXcHbUCeMJoqqxCArfowTQq/7KbSjgmtGfEpN129t3aA7uVki0XLzMCr19jlpi7LA8w/+x2A8mlkOhP3IfKQij+V4cXArInc19zUoZNTiwDy1yH9Hpn/ZcgOFNvyeGhZiKUJtU4iJOudXUUrqc450BKnr5AM4p8jPeSvVckWvgcR6Ilbcfvtwd8es9v1oPbIbjT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s61k0iQ+kMLuCAuu6H2HgAXm6p0OtdFdf/0v+Bj/jQ=;
 b=F9npkrx3mNZmHX/cATeyitKJAkbFtJV4TOQLXSsZbsnllRWoOyzKqtjecbtGumF9po8MzQ3Svvf92QBMCJfgIFzIZa/0LtC8M+4o3iA/rUBQLy+q6WNED67Z52rx1lkUIcDmjrRYAjKOaCTRdvjoem23K1QU8+WUTnoRMVtD4Xc=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 IA0PR10MB6843.namprd10.prod.outlook.com (2603:10b6:208:435::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Fri, 8 Aug 2025 06:00:03 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:00:03 +0000
Message-ID: <41ac491b-9cd2-4167-9f3e-16f1617267ce@oracle.com>
Date: Fri, 8 Aug 2025 11:29:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] btrfs-progs: remove device_get_partition_size_fd()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1754455239.git.wqu@suse.com>
 <85b30aea3031129419ec507afdaf0f0912477487.1754455239.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <85b30aea3031129419ec507afdaf0f0912477487.1754455239.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::22) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|IA0PR10MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 2493c4d3-c73f-4a9a-9c3e-08ddd640d10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0JwV2VwQVBXcU9pdS9hRE15VHMwOFhNdmp1ZVdJMXRNV2VOSmIreDZuVGFk?=
 =?utf-8?B?Vzh3L2V4MHNkWWhBVEE1RkJ0N0thUS9YaTNqMzcwdnc5MDh5ellpdEpkYjMv?=
 =?utf-8?B?ckdrZzk0TkN1ZlZJaFBBSVUxTTNQdHhjY1N0Z2pjQS9nMjB3MmpQZkhjc3pj?=
 =?utf-8?B?Y2kxZUk0WGk4VThmazQ5V284MXpyb0lmMSs5VWVqR295QmNSSC9XbVhuajUr?=
 =?utf-8?B?d05BbE5tTlY5TWx0cEZiSlhheTA5cmhoL2VDYVk1OFVHV0lwUWdZUDljaFpH?=
 =?utf-8?B?Y2swQ1IwdkZkem5vU0lLS2w4VUxsa0wyaVRiZlNXSzU4cTNiMjFaNnlJUzBr?=
 =?utf-8?B?YlUwUjQ5Y3R4N3hKcnNtUFdXbEFrcUtFeGF1OFVka2Z1Nkl2YlA0TTZsV091?=
 =?utf-8?B?dW5nZzl6TUlZYkorZXhYUitCZUZDcGt4ZXRmNFVNOG9xSy8wVkswL3dKMHdu?=
 =?utf-8?B?ZURDSWY2UW95bHVUc2R1MkJBcFV6RzZNSGloVG5mRjJjRm8yMHFCcFRDdUJz?=
 =?utf-8?B?cTNrR1BoYnlNamRDWTdWL25mbzVLQUd3OE5wRDIzSTMvSTB2YnpSb0U5QmVt?=
 =?utf-8?B?Qld5SUE1Wi9kdWE0a2s1NXJIUnlsZzcwMGZWYlUwQ3I4bFpCdk5FUUUzV21o?=
 =?utf-8?B?TlRpYk9JYWhIS1ROMkl3NGorN2xtRDNDVHVnMlU0UUNDaFBnQlBNQTl1aTJU?=
 =?utf-8?B?cHVCTFR0ZUtxbUpKYzg3b0QyNFZXUUlqRHlUNjU4UGpwR0IxeVpIUitZaERs?=
 =?utf-8?B?SDRNUFAzVGk4TGgrNllvSVJ2Sm1NQXdqLzJwYUpGcjRzZlVsWG9Zck9xYU9n?=
 =?utf-8?B?TTltMVg4d0szcmZSdkR6SVN5WSs5bWI5dnZWbUlaZDJPcFhnaVlUNlIxVmdw?=
 =?utf-8?B?L1pydXF5OWwxN2JQTmQ0ZE5iQUhIL0FmQkhkTHg3ajhZaStkT2tLV1I0aVJN?=
 =?utf-8?B?bXJaWnJncnRFOWQ0bHdRaEZIdVhBVEFteEovYmYrMWllY0N4RE82UEJKZFpG?=
 =?utf-8?B?Q1JySTZBUFBkU09HRVZXU1BZeEZOQnpLajcra1ZKeEZQZ3pBck1VcnpwcERj?=
 =?utf-8?B?UHhyZ1BHckVZaUVOMjViTkpSM01pdUhlZ2MveFNyNWZQbW5pM1VHeEtJbnFV?=
 =?utf-8?B?U3dpMkZvVWQrMjV5TEFlZk9Gd1FFK2RQZlRzaFNIS1N5MWsyMkttSzJDcEpV?=
 =?utf-8?B?MEpOOFUzdFVCTU5IbFJGYXByVGp5SUI1SFJaZ0VSMks5RndOamlzOHlKeXc2?=
 =?utf-8?B?ZytoaFZoTjhyUk5vbFp3QkNwQlZQMjVFcmhrK1J5QjFGcnQvMlFseFByNXgw?=
 =?utf-8?B?QjZuMVJIcVdsWFRENjlhSmhXQW9mWkRhVFdIY2FDclo1dVNPSHBJWG94U3FR?=
 =?utf-8?B?MmtsRk1TSGRJYnV3Vk9pK3dZTEVuMm9wbWFUY1M0cVR2OUViMndRVlloNGlm?=
 =?utf-8?B?Uk82VWJSTjkxMUQwMGhjZjlVcmIzWUkwWXR5dmV1aU5Lc2JTczl2S1dYaGlu?=
 =?utf-8?B?STl4RnMzTXdMME55MXRJeEIwZlF1YjF3L2hsZURndDdROTFuSU5mbzhvOEFz?=
 =?utf-8?B?cndKZnNRNFFiT21VMTk0TTBYNkJnVnM4c0Riei94TGNZNFVieGQ3OUp3V04r?=
 =?utf-8?B?Tzh4dmxyVFk3QW5ad3EwZkhRODNYM3VaR1NzU1ozL1RvN1h0eWF0NzBxd0NS?=
 =?utf-8?B?M012Smg4Z2o1enFLY3Z0VE1vbDZLODRpSWVPYUR5ZzJOY1Y1MXhoSXo0UnlJ?=
 =?utf-8?B?R21Vd0pHQXhCL1VPOXJwem1ZcTc2U3N2OU5UdjdTTHFJTThZeFVzVXJkZWJS?=
 =?utf-8?B?cGh3cDhVMUlzaHE0bERHQ0x4ajhrdlc2VFk0M0xKdHJhZGlDREFJcEI4Rk0w?=
 =?utf-8?B?cUwwRWR5OGh4WWVFS01STit0NldjZ1Vic0VNK1lEMkNNY3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlhDcGptaW0zdjZFbldlR05IZjNiWWlFUmhYOU5ycFBDQ1h6YlNpV1liMlpX?=
 =?utf-8?B?VDkxS2FNYmtsdlViMXJqWE9NMGVCOXNGV0R0MjhsNWVVR0l4bzdpcnI0cmpj?=
 =?utf-8?B?NUhyY1ZoRGk4RmE4R1FlYXMwbzA1QngrUjFFTlhURlk2RGNxejdDRisvOWZV?=
 =?utf-8?B?SGdvTlE3Zkw3UnJ5V3hCUkF6Y3hJOUZ2VnFQcHpVYkVQYkR5cmpkWm51OFNK?=
 =?utf-8?B?N2ZIU3QxdlcvakxVZVdJTEJ1a2hSN1JxVkdjUzQvTVNaQVRjd2ZZbmNSZWY2?=
 =?utf-8?B?c2tvZHAwbEoxeHJtZG5ZSTRLc1lIWThhbHlMMUp0RnRGYmdXaGNXbzVCYVho?=
 =?utf-8?B?WDZDZVF0V0J1dDVucldQQTdteXlhcEM2YzZaWStxVmF2TnBpYkNPTFFCSlFT?=
 =?utf-8?B?eEFpSlF4d1laemVKM1EwSGdqRi9ra1F1TkpBcVVrR25sczRJMFVMaWtVdTdm?=
 =?utf-8?B?UnlNeDJsWTYwejZGNk5EQW5mN2RKcWlYNlhaV1BCVzJkN3Vxallqa0ljRVRM?=
 =?utf-8?B?cE9KR0NFeEFaTFlZYWR1WDg0WmlMNjl1cTdqNWpoSUZQSHFmZGJwVkhNSDUy?=
 =?utf-8?B?UXJnNndhNnhsQTdUaGhFUWphUm9RU0V0elBxOWR1WEVvRjhtWC9qejJmM0hx?=
 =?utf-8?B?aW5yblBMc0tZYnZJSEI5TjQ4eVpqRDdsV25LNnZ4NEY5amdhNFNSdjJ5Y1Ba?=
 =?utf-8?B?QmV1bC9ZRzV6TVVPNDdadkN4MUhjaThxcDU4MVdzeXNnRkhHeVFzSGdObW1n?=
 =?utf-8?B?NXdYc1RFditzVFBlUmhTUUNTSEpXYVhQWlRiYVpESVZLZE5Nb0tNd3gyb3kr?=
 =?utf-8?B?SjhJUU8xQW8wdWYxSmVkY2ZMODREWW5HaWNHQ3lxQnpiY2UycjBrSG1EK2dN?=
 =?utf-8?B?bENQekY1WnVzZ1ZKb0NwbmpaUVBLS2NpT2NVUW5MQm83b0FORFViMzhsTzQ2?=
 =?utf-8?B?N25JTUpTSnFwTmVVdVFkRjBRVVJPaG5STFhZZ0xVV0hvVVBFSXVoZlhLVHN1?=
 =?utf-8?B?S3kvaTNvbzRsNnhZUWxCU3J1Uy96R2cwbStRaTdrVFhXKzl3ckdJMVpGWjla?=
 =?utf-8?B?SzBBd3A4eTFxNExXb1g3eERvaG81WUJjUzRaRnMvTzZ4WlVqZ1o2dFhCelpQ?=
 =?utf-8?B?SEdiVzBiMFZ6ZEcxUUlKK09tSW9pNmgveXRlVzVZZFljbHJha1hrRU5xdTZp?=
 =?utf-8?B?SVZEVHpUUk96MEJWWTZWd3ZpZU9QQlRsV3czekdEVjhJUkxXOWVqd1VPcUZU?=
 =?utf-8?B?Z3VTaFVIT2lKQmdOMmwvdFJTS2NqWCtBTmt5RTJyVU5UbVNYVTk2bGZqL3Zz?=
 =?utf-8?B?cnpPT3hGbGVYbCtJeTVzOHJzZ3BrdGZlcUJGbGJSRjQvbWlVQzVLVitJN1pS?=
 =?utf-8?B?aUI0L0FSTi8wY2dtdWRKY3FxcUV1T1IzejNyY1VSWCsyV1pNY3JRVlhlUEdF?=
 =?utf-8?B?VUhJTEFhQzNIWE0zaHZGKzdKTCttZWVQV1h3R29xRmdXcWFBeml0OUI1SHVP?=
 =?utf-8?B?d2lsbW1jNmJ5djdqcWRMa2hnNE0rVHdDR0ZTcVcxUERRRExyRldrK2pIS3FW?=
 =?utf-8?B?cTg0cnRYaDk3NXVUNlFGamU3dzRwRUFxWkFiaGoxY3M5N0tkM3VpelBzWVpJ?=
 =?utf-8?B?MFEva2w3TlFtR25XTVc2WUZLY0hnTnh4ZDR6UFBLb0ErZGdMVUt6RTlDV1Bz?=
 =?utf-8?B?aU80Y2EwZytkYklvMFB3ZlllZkZLcmlTVkN4NGIxR1ZnSUpnbUM3UDBJdVVS?=
 =?utf-8?B?Qks0UFJueE5XczNOdTh1TDQ3eWtZYjVSZVFPQ1J3MWVQTXNGOG95cHVkT0di?=
 =?utf-8?B?OTZabHJMVWhjMzRsR3kvL3F1TWcrVENQK0d2c29HamNJaHNKQ2h1RjhUR1Vv?=
 =?utf-8?B?M1lxKzdhanlleGJLZytKWmJsTW9KK3BUdlQwbFNSb3ZRNm9IV2RydERiclk5?=
 =?utf-8?B?Y0RDOVRoMkxaTHVJWTFmTXVBQVVTelg1bTdINGR5MjVKd1RMUWQ3K2NLaldP?=
 =?utf-8?B?SjRDK3ZLdGRRNXJGOWEraFdhSzRqSkNuZk1QQTVSenZqcmFUUVhvMTVkeDFt?=
 =?utf-8?B?UkJFQnRNemZsZzZFNjlNcDhBZm5wMk05dWpZWTJBRTBBTkhQR0pDeUdxVGVW?=
 =?utf-8?B?SzJBbUg2WHo2MG1LVHlwUFMyN3ZyWWZWR084Ym82WnZtazJDaWlFTVJkQnFm?=
 =?utf-8?B?bUNDaDd1T1RGTms2SHVCdlRxNm9RZFlLU3lNWWhROHNEeXJQYTlJS3lUcy9s?=
 =?utf-8?B?cjlRamZZaE1JMzNMNDlnTmNTNnRRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qqqBDbET3MjuhnTJtOJBMG5RbSoV1D6h3fANg3pRSbhS2y7RT/AgvDT/n2Sk2KspIFKfliunzpjsYrUAX1QUQWyTDIYHzusYorZ8rQFjE8o+iA6oZ/ykP6w/S+f6sOQ+YOwFhA+N3cJar+jw08QEs2/Fq2P0zk2GnXENvuhrMzDk4SvGpN22kV52TAihhLwViMvtgNhCa1XQ3VTx9FeGw2ETNrR0ev1gtzMvGLrgsSuZFumq84L+bboyX+SUTKaKK+00lMYM7r6OrIraTZo5U09nhfKR6l3dJokkb+visK7rXy6mjHXh4953rY39XiU9poiD/LLHvLC7p4axLWUECtyyyrm85jJKv+wD4AXSPRqUQSXev8AiB3jcuDY9zsbL6Oag8CanqqcSAjf8Xu3O5Jrr185hNzQVkRqDPIHcw275C/jq34bBYPeYhcLfnAstzRU2ms9x9O5d/KyKu21hq1s14lxdbFsZLQREVhEz56WlazE2Ht5QcmO+Nu8Fv4RPq5z82C9yg/yRB7yVmdgjbu44GTnirUopBG4WhIuxjOrrVSrfOVOD+fzjG3D3rQYLeD/oerOz3QcAGPetmB1PE+Xfksk1Ca38N1zJUYvrdfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2493c4d3-c73f-4a9a-9c3e-08ddd640d10a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:00:03.4739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gflZYHgrVMJO5YgogUMMltbdr5ZYjvIGq0QjBjTThqQi/gClrRxqwkD8fERZt63txUolIxyg1Ap8york7lu9xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080048
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=68959267 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=BGF_fdTIUcW3nsKGlJwA:9
 a=QEXdDO2ut3YA:10 a=_Xro0x9tv8kA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: so6QdL3Gj5984btlnFAS3WcPGTdLGxSn
X-Proofpoint-ORIG-GUID: so6QdL3Gj5984btlnFAS3WcPGTdLGxSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA0NyBTYWx0ZWRfXy/1N8aNK1GMg
 8D4W6ClwhJmdP/J22PcmUlcd00dCAmds3y/KnJ7QwrFdaxEuw02QhLNKCciRSOmMLAru/HbwYnd
 MyxmU32BWubHv0ij5S9JEQ80LZcgQ3siyJwOQJ4oxhbgeC6hAjwjcvLT5HZEJxUyMcAvNXkWyc/
 ZEicFrVVrcpZ9IT6JiBxWmvUSKPhvhbwM8kaPAeW6HAy3zpWucMtPiQVb+aC0bGhkElgjl5fnzO
 UWI4SCH4jdXo4nEyw8AvOiMD7V6V0xXoHfXk+MAhRluy1WUnwtgEPIw6G4HojgrOPMZXf1O/OXY
 E6aSFF9LkQwXnGnYWkhO2Tq9lnYhJ1pacpksVwwFK1HaTt2+Z9ZHFgYRWrm0LQXsHwMmNqq6tI2
 qhuqNt4GlNVANJccjunnZ9XCAyTRhyIUzQLlWZ7AOvG8fegsOVNgGGpy7t8a0SoLgwXC9t28



Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks.


