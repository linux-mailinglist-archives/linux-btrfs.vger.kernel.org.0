Return-Path: <linux-btrfs+bounces-5134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA88CA597
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 03:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D57D282E02
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 01:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D7EC138;
	Tue, 21 May 2024 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OXyF4z41";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pwr6gX3p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA308C1A
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253514; cv=fail; b=rmtcgBGR1JOMK1vG2lVNYfanSDXeO3toGSo6QFjiowYKMBc41E3I3tjt8thOi85FdcFMEntA+IY1QOkFPFUJShkKqlej2XVcQpXRUYM2syRv8fw0l5gE7srML8XV43ZtoClDKZCLhlRog0hKwwULU+Tm4SSoHy1QD2eFyyndZRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253514; c=relaxed/simple;
	bh=sFCKTxzcaKPmQ86/LNFI/VBKQbDmLLcPX4oQXxpfZQU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j8rjgjWKuAeBByRxqsIYuUA/lHImbu0c/cXu9nRbbfCf4d63qulc+hi2Hd4/pzWx/gVL71Ef9bnpkcYN5vTJrVLhr1uqtrBR8WruYBweYGutfl5uDZrznAK9rUqg7rbZD2Hua28myNQpRTkiN/0uGKBIW5qntq6NOl44QGsJNvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OXyF4z41; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pwr6gX3p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMwpo8016493
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 01:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=roi/qzquhfNikoLC7g2XUZ5I3KLINQDAU3W3/rqWzAk=;
 b=OXyF4z41z0qsey71jIvAj29F9gq3GkcpUjFqECIJGAXnwblC0Vhlp3Pcwfi0t/X/Opfl
 h2FRlqr25kfofXuEONc5KzJ5G8mYnjAriFVu1Z2NuIRxGa3dEMB5OzNtbE6VBUFWam7s
 cqJyQO2C7oCZGFy5xjdY1OJcVDoQU3L/Rdpoi8zjQBjvuzquRygi65+vAm0DIU5lnPbS
 avLpyjkSXOkeqTdmwRz/R3yKzsZqGOaKMk/yPE34k+3d9lclO4Z5UJj7leCq1uHMR3ZW
 jWwQvUrprn5Ro7sdi1NxDqhfMfgkC6FMOUsFXbZ15ey/zorG0NnPpewjBz3RyOAz6HvY Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcduxef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 01:05:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44L0U7w7013823
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 01:05:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6gg0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 01:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS7GVThYV+BICQxNncLzPldmvRMy1C5lNXeHRc71RAOHMYetemRoct4qegIkFuQ4e7Vcgk+6hcNA+5DsJfJ+DhZeVDFp68Fc5+LYwio5pRSLtoK4GkaDKVvE8yVGmcfEB2Sqxqusr1SUk6h7so9EbRuPPGtjzHKbbfdIaOYSK9epl+7eR/8aiOBAaYCipYrAoRoqHi9KDq76zjZK+Nx3JGiKU9CG09cbYmo3hqxECkBpX8ZVJMwhrwmahJzhYniZMnxIFFSZOFHPB+1c8JPG9KdkxNFKOie4LOecAg8y2aNHIntYZheasTcEmtmjabmMd9e4lrLxnaWDuSUeUsi3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roi/qzquhfNikoLC7g2XUZ5I3KLINQDAU3W3/rqWzAk=;
 b=EErd/LKq+joelsh0Ew+jYp3evqBBc1eRevYzKeUKcer1W8xZSxgRYbNXGAmHQhoiRE3HYtSsYszqfa36dDbuRj5vzws1mMDqx9wNvZRnlo8/HZDRHs0cZ/9N1WNz7LIDqS+CT5TGiRvN1wU1of5gYzdgi0prMvP6ygQlqE28w5kRRHn3IpKNLUJMTo5iPdsVa7kH8AMJzFSAxE3B5mi8XhwR+/YhAZqNdK7H+qAwtOjaZ2CVDumcYr+GVIsi5EJEK8UBOkVA7JjSbDE0RpVfd0wIVtimZqYBgUcTf8VvR/UHdAv404h64gCFA5Rc/QIC0k9CITnBHCzJb9t1MC2uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roi/qzquhfNikoLC7g2XUZ5I3KLINQDAU3W3/rqWzAk=;
 b=pwr6gX3puoO3KysKBxSmNFx8cQLC3GCJDk+1uwfo6mhEmeoEuXbYE/5cpsM81h2GiS0LAa3cWjwUkqh8d6Wj3mEitN7ZNDKX8PnG+V814bh66hQD7WC9aO0yBg55vUiwfOq1VquBZL8jsRs0iZm/jkNRtnTWFUfYsdCiE1oz5yU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 01:05:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 01:05:07 +0000
Message-ID: <7cba1c01-356d-4068-81e2-97ca8e98f713@oracle.com>
Date: Tue, 21 May 2024 09:04:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] part3 trivial adjustments for return variable
 coding style
To: linux-btrfs@vger.kernel.org
References: <cover.1715783315.git.anand.jain@oracle.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <cover.1715783315.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6c6676-d28a-485d-b074-08dc79320e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y1NIUTd1cS94bmpIS1NWNzlQZHlLU3JiZHAzU0F2VUlIRXczcmZTcFRPaGs5?=
 =?utf-8?B?a1FPZnh2TVNnSnphTk5Td1VYOWtvOTdFb1Z6bnVyM21UL2xEZGhydk02bEh0?=
 =?utf-8?B?bnpNZHRPOW9RR05WdzlZQlNJZDNqUG5xbXYrYU1DZTQ4VnJJd0tVY1JsbFFj?=
 =?utf-8?B?bzFQeDlna3kvWHFIeFpTamdlMmZqWDlXY3BVeEl2OVRGOHJDcHE1TTJMZi9x?=
 =?utf-8?B?eW93SDY2UERVTFI2SHBHdmRHRHNPd0lYRkpOTk5pNlp5d2IxRXdLd2MrNytN?=
 =?utf-8?B?ckk3Z1pja2N0U2R0em1oK2lZcGFkN01SdUdJOGswajhWbUN4WEUzdVNGUEh6?=
 =?utf-8?B?Q2ovU1hRaFBsVEF4L0tPOW0za3crcXVLL3U4UWtmUTVUcVovZGNOcEIzUk1s?=
 =?utf-8?B?SDhpR3hVT0M1V1V1QmlqSUs2UCthTkZXUE00cGY3YmdpeWR3L01NbzRndlhE?=
 =?utf-8?B?RGVEcEEvWmpFWVFDemNrdW9zbWVNTTBieVJQbEx2eWxiemdBZHJhcGtiRW84?=
 =?utf-8?B?WERBS1JkZkdhTHZOVzRaSDJqcjQxZ1hXV1hXOVhzOGM2U3d3SU0vT1BzMzNk?=
 =?utf-8?B?ZUVvNmIyRlBwMS94U3J6Vm53RHNLMkdWaXVUeGlsdlNEZFpMbkhQbTk5OTNs?=
 =?utf-8?B?dklNdEZheXFnZUJWQnQrdGhaeWpsd1V0Vm5mUVRCaDNiRzE2YTl4b2s4VjJw?=
 =?utf-8?B?QWhlZkNqZU5kaHFJQ3ZROXVIZUd5a0J4cUlZUlNDYmwzQXp3b3ZWM2lVSU5p?=
 =?utf-8?B?SGRTRDU4c3JLUzFOZHdHMk05Nmh6dmQrVWZ1SUVtLytBaDlIdFFTNUVsV084?=
 =?utf-8?B?UmdNaUdxeVhSVERGYWJkdzBvc0FSUGlPVGdScVZJL01BS1ZpN2VYeUw2cmhV?=
 =?utf-8?B?UkJtdzVmN09kWFBGYW1BUWgxMVhpQ21NV0NwU0o1WHRYeG9wZ0p2dGRNZU9k?=
 =?utf-8?B?RkR3YTN4ZVB1ZXlWZnBZRGg3YW9Xd0xmQUFSTnRFZmVhOWc3NWZtNWQ0Qno1?=
 =?utf-8?B?NlBIWThUVWNaaTEreStxdEhXZjg3N0hDUjg3U2dreVZUYXB0eVJ4OFF2dHBI?=
 =?utf-8?B?TDlYOC9abmdvc1FKTUpLbnNiMWVxdXkwMlJuTWpkRjQwcmp2MzBqbGxmV0ds?=
 =?utf-8?B?Y3FiRk0xa01PcnpIbFJ6OHcraW51aEhzK2tXODZIM204cnRRYzl0V1N3M0k3?=
 =?utf-8?B?QkxZUkZSdTV6eFNnaUJkS1hwZTNZRnF4eTBZQk5Xek1WRS9qK051czRPNzUv?=
 =?utf-8?B?SVBvdWtMejRYUzE4VkNyVFhxbWMrVUg4SWdSbnJxajJNL0lhajJadHFCYjNx?=
 =?utf-8?B?bE5wNHkyUEFJYTdsajYxS1A5MUsxR1JLSjNRaHV3MlhmZzBkOFltUEJRUGUr?=
 =?utf-8?B?ZEkvSFRsOUtnKytyVmZIMHp5cndBR2RUNXpMb0xmaklEdk1SRTRvRDU3a21k?=
 =?utf-8?B?RFoxdjRyNmZqSWdlbXJBenoxejhPOThkN25oMFVDcElVZzlwUjBUNzFPRlpt?=
 =?utf-8?B?UCtCNXpHTTFzblMxNXNiejNWZFNpSEl3NnVEbkJlaVNrRGRKZVlGeVpvNkpv?=
 =?utf-8?B?MkROWGlzZnhmL0tYc3dpeGRLemk2SFJLK2ZoN3Z4elRIZWpYbjc2MGJBUkVC?=
 =?utf-8?Q?jqqGxeaHq9/FrIurkHukZ/etrsuPgLBKYCyCYErSZu+Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UU9CQnF6TzhuL3ZpMmhMclVjaGFDTmxFTzZxMWhRL2I5cml1QlhzYndVcy83?=
 =?utf-8?B?WXBGdlQyUzZjbmFCUUU0cVdVVVU5NmhOR3NFbk8xU2FDaDIyRmo2RWZLMm9X?=
 =?utf-8?B?Zi9QdHR6S09pVElBTmZ6NjBPT1VqcXllSXR5ZFIyNkdaMzdKaDQwa1EvTEpT?=
 =?utf-8?B?ZEhjZUNnZGMwbnUxNVVDR2xLNjRZOUliU2pOYXd3TWx4Q29NckN4SThkUk5S?=
 =?utf-8?B?V3VzODBzcjVCeVl3SG03dlEwdG9vQVRxcjJuUTVlbllCNmN3QjFKdk0xb2pK?=
 =?utf-8?B?L0toY2NyMmM3TGs0ZHVaYUFRTDd3MEpUM25oWDlUaWxaZ1ZhbXBsUUhIbDNt?=
 =?utf-8?B?cys4UnA4WWQySlI3M0VZS2d4TTdhSm96ME1WNDRaYjF5TzFtQ0xqaU9INHZE?=
 =?utf-8?B?bTRjby9aeS9vYVZCS1hCM2p2QTJGS1V1bm9icUUwVDcxV2RRMWxJMmpRTnZP?=
 =?utf-8?B?U2JCQzZzZEN2ZDY1b242WWgvVy9VR25JNlFsT2YzVW1NQi9KcWFTR0R1Zm9u?=
 =?utf-8?B?ZllIbm1nc3RGQVdWYld6M256b3F0Z09aOWx1Q3hOVVIwY2JZVEpIVzJBZVJT?=
 =?utf-8?B?eXhKbDR2ZG84UnltR2I4QXFmcnhCaTNXdTZwRE5VTncrSk9ZM2hHNEFHcWFF?=
 =?utf-8?B?a2dWMXFJd1cvbERQckswRHV6ZU94TW01bDlSN1NUZHo3SXMxenV2YTFiOHVE?=
 =?utf-8?B?WnM4MWhwYTNWZGpTcXVqekRlTmJNK1E5Zys5WlV3c1RtVjlLdFo1NnJ0dUwz?=
 =?utf-8?B?Vk1LZ3Q1UTA3NlN3NmVCOWFrRkxDK1VMMFJGQ2hyNytGTWVDQjVzNUhuZlVZ?=
 =?utf-8?B?UDR5R2hZNisvQTFFWjY4WWxqdzNHNnVMMzJ2djc5dGJSaVZDWXI1ZDNFK05P?=
 =?utf-8?B?WlZjZVhpakNlOXVvN2lBbzdiQzVZQzB3THl5ZEdUeWhMOGVRcDFueG1vaXV6?=
 =?utf-8?B?a0VjbWdFaXlzNENTZG45aWs5WGw1WUhKZ2cvb0FVOTY3N1V0NERFMHVrMkc3?=
 =?utf-8?B?dXJYMVBNK1ZNU2FhelJpc3hiUnArMXJjSGIwMDNUMnpGZzkxek80TzIzemlU?=
 =?utf-8?B?NWxVcHM3NnltaTdlVTZqczdsRmdBTFplTUNsSjEwOXhlN1NoTnVkc3BYOERD?=
 =?utf-8?B?TTlFUkRzNEdkRjlDM3ZUK2FNb1Y3NkVRclcvalhlUXZWMS9nZnZrWHllRFdE?=
 =?utf-8?B?dWpIZmw1YUZsczFzYWtmdWUvU0wyYUdXbGFLcXJ6RzNRVTQ2a05GLzhkbXBP?=
 =?utf-8?B?QnNUR0F5ZHhrVkQwSjQ4R0V3L3BVM3cxZDNFZGZ3aU5pU2RyUnVSUUh1MkNJ?=
 =?utf-8?B?dVRvSElOa2VUM0NwRW1xVVMrd0dEWFdaOUZ4cWxOY1RyWUhEZmxKeGtxWHpS?=
 =?utf-8?B?OUFUWUhXYzE3dExVNFNpbFpTbWU2U3E2OSt4Z1J1aVRzVWlyd1lrWXJnazZI?=
 =?utf-8?B?OXFrZERQcHY3bXlvalpERW5zMXU2Q1oreDFSdWgwMHF0ZzBjek9WY0grWUVw?=
 =?utf-8?B?K3NkR2JuZDBOcml0VjRmdTFjZVBmb1NFQlE5YXlkZlVEV3luaENGSjloOXFm?=
 =?utf-8?B?clA1YTdpUkEzbS9TZmVHVGRDcERpNTg0Q2VFN3JETVBKaDhRL3Zsd2JVaGxs?=
 =?utf-8?B?UWpZVzhRTElmd29xSzc1UU5iSi90VUJnNnlpaG96MFdZaytOajhDdXp5cllX?=
 =?utf-8?B?L05SOWhIS0pFcEUxSHdDMXo0WFpYQzdVNkRPc2dxNnVnUTk0SXBacDkwZWVl?=
 =?utf-8?B?VDVYdGN0eCtBTXJNOGYxNjgzQzM0VW1rZVh6Tkg3R0NBT3oyaE1VbTllR01L?=
 =?utf-8?B?MWxpQy9IOFFrbC8ra3BrZVA0WE5walM2U0d4RGphY1dUTHpzTzZQaXVEM2gw?=
 =?utf-8?B?VlB3NmVIbHF0azBmNEVTRDN3NTJ2ZWNYbWdDYlMrTGFoV1ZEclVidjF4czB3?=
 =?utf-8?B?WjhGZTRSdzlIV2o0NVE0c3ljdW9sZUhHdGRVTGxwZm9GNm8yRHduNXBoZ0pi?=
 =?utf-8?B?Q1RWSVF4R2JySXRpdHJDMk80by9pZGhyUFJ2SVhvMjZXNDJWa1V5UHlZeVgr?=
 =?utf-8?B?YjZrUm03U3o4YlB6bkVuR0RQRXBSeUZtRWFFV2g0bCtDQ1plbi83R0Iwd0p3?=
 =?utf-8?B?V0o5SDFXS2FaNDZEQmFFZWJadFpOQmI5eWp0N0FwRnkxSEhtU3NBczRNSlFs?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mte/mDfRioWm1RPLCIJ3S3jXOQG7R3QsVOnWJQzQAoZqC8uiY9zSnMsX5VSiuKFcdi1kIiKMYo6MWe+QEppncEjxvim5aR8FWxwDZ6EKn2/RBykJR3hHh95Mv8oc9D3fJSWSbT1Fo8XTmcLVfaRKtzg0oPjVjkaKs2j29zja92nmUy/MMsdrEie9hG30rZMX41eZ4ZzcsOa5znEf4LRfGE8QlfntLT9xPZWX+5xu++P8wvUODf1kegutS+FDSNx1lMOP/hHETWQRnHBVbtj6Lmh+PmFP4/UNR3cphAFT00AGpuUIsgxvE1AtWHNUJyASwe8AsXUMkt9lGqyDQR7BPojoimf3FhXxVr0sC6JWDmz1tRwGmz96igmlJhowvZ8EcGFj1LK6Zj37ZNDwxg73CU9GHef52hGbldzIspIWLxB4CvRhfT5OpvRIKlaaTqdy1TMg2KIpIOCHjYMJRPsjKv9YHV1l/COqNSB6T1/Az29bt8+2ODpFKoPCNapGqzM8LG8Ycb2O7DWDlawV0z12Gbm3JlU57UISmRKWYPCAX2TZ7tAGiEw810I4QSmnyU9hGx5EWfVzPXHXiaypH3gKdPCtMCi4XDFzySqmw4bLtcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6c6676-d28a-485d-b074-08dc79320e0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:05:07.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJChV4CY4TtvcfuAkWq+FxOaYTjlhOlRM+62qkQ+DwElvBe7zEAzI0LlaB1Q38rL89EvyYh+r70b/QWj1XFUGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210007
X-Proofpoint-ORIG-GUID: 9hwaN_9Q2zsZCZFrISn6LUIYwvqho-pe
X-Proofpoint-GUID: 9hwaN_9Q2zsZCZFrISn6LUIYwvqho-pe


Any RB please?

Thanks, Anand


On 5/16/24 19:12, Anand Jain wrote:
> This is part 3 of the series, containing renaming with optimization of the
> return variable.
> 
> Some of the patches are new it wasn't part of v1 or v2. The new patches follow
> verb-first format for titles. Older patches not renamed for backward reference.
> 
> Patchset passed tests -g quick without regressions, sending them first.
> 
> Patch 3/6 and 4/6 can be merged; they are separated for easier diff.
> 
> v2 part2:
>    https://lore.kernel.org/linux-btrfs/cover.1713370756.git.anand.jain@oracle.com/
> v1:
>    https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/
> 
> Anand Jain (6):
>    btrfs: btrfs_cleanup_fs_roots handle ret variable
>    btrfs: simplify ret in btrfs_recover_relocation
>    btrfs: rename ret in btrfs_recover_relocation
>    btrfs: rename err in btrfs_recover_relocation
>    btrfs: btrfs_drop_snapshot optimize return variable
>    btrfs: rename and optimize return variable in btrfs_find_orphan_roots
> 
>   fs/btrfs/disk-io.c     | 38 ++++++++++++++--------------
>   fs/btrfs/extent-tree.c | 48 ++++++++++++++++++------------------
>   fs/btrfs/relocation.c  | 56 +++++++++++++++++++-----------------------
>   fs/btrfs/root-tree.c   | 32 ++++++++++++------------
>   4 files changed, 85 insertions(+), 89 deletions(-)
> 


