Return-Path: <linux-btrfs+bounces-14033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F667AB8011
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 10:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA2E3AEE2A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91127BF6D;
	Thu, 15 May 2025 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c7vNrmUe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LuYP40yA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01819CC3D;
	Thu, 15 May 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297002; cv=fail; b=IqoLu/azRnXRhVQn5IinCAx7ziqUO4fFRnkrvBD/iB/BVWikngRGxr3P51zHRSr1+Lm521Hjp1ySjgkmzwzQq4Ng4CMnmDzueDTWK4/jbPSLloxj9N96nNcAiSrvzJhcgR7MKnUGjid0gEmfWEBtaMmcIJ150N40CYoGGWHm5u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297002; c=relaxed/simple;
	bh=tMB6PrdZonhgSLIbX74d0ktfCmrkbhwcI3pynOdUuu4=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=RH+e9uOt/Z5lfw2AGWONMuHM1+bE0vYHZY6soQ6rS1mS4cMzILf46ZrQqzHeF2NVkSajE7dZK8RZ+JD8dJ0S/i6GOmIusQTYKa/h+Z5MCaSkcZUhR7DGk+r5QZBP2Pc5LJrMqMik4pKpdTsYCpFk5uR7Y8u1y2XAyxpfe5rJ8Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c7vNrmUe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LuYP40yA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7Bo2S001107;
	Thu, 15 May 2025 08:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=I4we9LyaVWiV44XM
	RxoHwLLyZJID1LYMlVPOBP7sbLY=; b=c7vNrmUenX5SKfrJp1HCYrvHFLOzBRFZ
	TaqIclCLnnycwmR9CALx+gDHgbBxoT8PF2amIZa7oOe9jkii/yMzbwkLwPew0joG
	L/HyZmW51UDVLHkh7/97wFZhd7wdBgYk036zUVGEf+fK5hfMsd9+uuEqNa2gdgDY
	QEiw17dwLaCx/7fpFtE7PaBkwo26kuPCEw6MFGzPIMXKQ2ihMSmDv/nfCfNVHd2y
	xpQ8gXoMKwcTwtDVXIe9xuuSrJfjydE5dN5/2QCNHfpYQqjCimTkTwBWAvDhTMZ2
	7jDewBmPjW5RRINcy/Rmfur9n5yV02qEGk8UEZy/kfmMeNgsVXGmIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchudca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 08:16:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54F6jTjj004559;
	Thu, 15 May 2025 08:16:31 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mshk7vbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 08:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3wCBvSD54ze5uXCAmUIhDM8CzWQl50pKvE0huCWrjZkrUV7vdj3KPIzsUfhSKlIFKsp18q63/2c7bTwEJNfBhfvWJ8XmfSXSU4TS7ywmZsS+VtzinFdXM1hdJRwKG8iXl9HPONurQcfuluiq7IXPoQTccS/xqXDA/bzN4V6SB7u0Zde/SuNvbsApiYqdRNZKW0FIYqRcnr0c+v70IWH+98yB/j0S/qoU7eAyzuPANyXrcY8a5mS1agQJ6TodoSr29U9E1fPrpwxVKghPQFFwl90R4T+1ojBLjKc9iniGmfzQR40cqHXuhjPl9nO76dgEgRHJbAp/5JL7zZsGVyhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4we9LyaVWiV44XMRxoHwLLyZJID1LYMlVPOBP7sbLY=;
 b=CYzXO15dy0yZXH2fHpDkl+1magz85MeCo1vllK0eSvc46wzb3CFuqppiZkHr/uHUrcDUt0CMLC9x272/hAW7FTs8szBsyUqxfl4V7YcUxfQeyLdrc2ex9bFnuIbTETf1As3hM8AOXlRUbTe2+NKHOeZJ6TCTMF1FPMyN14Eh+EslaxpGbSUBtFLip4p9WcKmMSc3+Mj15rm9cprUck/wZUeeaf1Ksi8ZH/A+8mwfKqKPcP8V5kwNqJt9Lw4J2NlBA3u7IlucdlCgbx+TjVL7+14vn0BBIOIqNXPtejpeFTglBuM3mZXEn0aKP6hRoreCB6AhdqwSwRinC2dq4GTcQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4we9LyaVWiV44XMRxoHwLLyZJID1LYMlVPOBP7sbLY=;
 b=LuYP40yAgsUP8wUc1+npuO+dHPFHRUe5uPGn5Xhib+e+C9ADPH+bfiHU/hOZb8LC9ldDzMjQVGUz2MPeE/ntQ5HzMolgsuHRVxLiCKpa8rnhwWCqrpArf0ijx3dH0ymkbEacxsZua9hD/yQBSy8kK3w8pA52zGvQLSoexRQUJMo=
Received: from SJ5PPF97E574FF7.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7bb) by DM4PR10MB6157.namprd10.prod.outlook.com
 (2603:10b6:8:b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 08:16:29 +0000
Received: from SJ5PPF97E574FF7.namprd10.prod.outlook.com
 ([fe80::f087:72f7:23d7:d450]) by SJ5PPF97E574FF7.namprd10.prod.outlook.com
 ([fe80::f087:72f7:23d7:d450%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 08:16:29 +0000
Message-ID: <5f401c48-29f5-403e-8c39-50188028ad00@oracle.com>
Date: Thu, 15 May 2025 16:16:25 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: util-linux@vger.kernel.org
Subject: mount -a inconsistency: mapper vs block device.
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, asj@kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To SJ5PPF97E574FF7.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7bb)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF97E574FF7:EE_|DM4PR10MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a83680e-4257-48ce-ef97-08dd9388cb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTcvZ2oydGJIUWFPL2tUYTFTK1QrVExvUXdxa0tqSGY5RUQ5YnUwUm1Bd2N2?=
 =?utf-8?B?b2FrMXNsT0lGU2JOTVBMNlJ2ZGt4U0preFdhOGVtRkpLU0Z4QU83NUJHSlhW?=
 =?utf-8?B?d3BHSDNkVVVZMlk5azAwNDlzeWs0b2E3cXE1cnJaWjFtOGFWcXdLTWw5YTJS?=
 =?utf-8?B?T2MxSytPeUhOb2phTlc5MllsdzVPSXp2SEdJNVBBRm1ZaGNsY09lVTg1WWt4?=
 =?utf-8?B?YlBrckF6c3NjTEtUWGdFSGxvNHQ2dGpwRXQyRlZSWlJEL2ZWbUJ0elFjaENs?=
 =?utf-8?B?NDNWL2trMmZIQnFlSGZLbFdaVU1wL2U3cFdkR3RMUFdzVHBteE1aYnZJeWhZ?=
 =?utf-8?B?eFZLZktDdWpTUXBHU2dGbWVWTlh6anBjQ1RJazVlTEYvRXMrZHk4SWxsbk1y?=
 =?utf-8?B?NmlacUFiV3hTd3RMRjlvWTVLN0VFemovZm5LM1hYeVM4cXNadDExNXB3ajdK?=
 =?utf-8?B?QkEvMk9HMWU5NW9zQW1DYmtFblJmTHJQWlFTSjVCczJKbkNWbkZRYXlUQ2FW?=
 =?utf-8?B?RFlqS1MzbUZid3FJTmtDSWFCblVCSFZISmwrNEROdlNNZnQ3VithM1VsRmsx?=
 =?utf-8?B?V3licHloQnpyNzB0ZnNFZTZlUlg5aXJMMlBXMDUzTmp3N0lLQjRydHgzRlRD?=
 =?utf-8?B?VU5idHl2OXpSbVh6NlExR200cldYYVJIT3lSQXQxbHhFMllwZ1NYa294US9v?=
 =?utf-8?B?NUJTRE1MQmo1Q2ViNnVlT2oyR21pOWw4TWFQR1VtRi85eXJ2bVlFM0R4cFgx?=
 =?utf-8?B?OWFPc1N6NWk3Ykc1U3ZxTEQzSGlSZzZ4SHVVeVJtSUx0c1BjSEQrNW13QnJq?=
 =?utf-8?B?WHpSNFV5Y1hFcThSL0NheHF4QVd2czlVYTc1RTJNSGsvUGQzbHVKZWxFeDEr?=
 =?utf-8?B?V1FnZWl5cXBKakRNMXRkK2dGVHV6TFBuZ0hmQmh1NkdMaFZQM1c1YkYwS1ov?=
 =?utf-8?B?cDJLeVIzeGl5Q2dDLzJ4Y1g5SHFMR3BLbUVPTUNobnl1YVYvbVcxMUJha1Ba?=
 =?utf-8?B?dlV2aTdrY1BTc21tSXp5Q3RqeEdybjVjV3hwOXBUNEVneEhxS3IrcXRCY09Z?=
 =?utf-8?B?VTRnNjhERlhpNUR5eEtjMmhFYkhHMk5XaVBmQXpsMUZ0U3BvVHVtRDVla0JH?=
 =?utf-8?B?WXdGTFNUUDdka2NyR3FNR2UzV0U0SW9SbzVWMSttTlhHSi9rUE9XOVgxN1hw?=
 =?utf-8?B?VEZBaURMekdzeERDSEk3RmZsUjllb1MyQWZVQXdFOUZMWGpSNklRYVZvajNI?=
 =?utf-8?B?UUp6S0J5UE1KbGwzK2RvMDdyRXM2Sm15N3lxZlFObmJxQjJZUEdSbUtkRHRi?=
 =?utf-8?B?c2VIMXE0eSt5VzNyei8weG9nSmFLSWJJOG9GVlV5RTFEWUFPOS8rcjdNYzFG?=
 =?utf-8?B?ZlhBOCtMcUtPVytJRkVadFpBdTY1UW84SUdMWW1OaUFQSDVvUlRPOHR5YXBZ?=
 =?utf-8?B?WnFKd1pvTWhLVWdRQTZJNTRKU0NSMFlTUWd4UDlWMHJkR2p4ZExOb0dlbzhx?=
 =?utf-8?B?NFJMTDgrU3JLakxGR1pVREFnSEdUcy8vT2JRVkd1OHA3UHF0QnRCTzRwY1gw?=
 =?utf-8?B?Y1dYSzhEbzlQM1R2OGs0NytMcWdBK0UrM3pBUFU2cmVNTUcxMDBUcVNJTkFZ?=
 =?utf-8?B?SVpKcmgzTzBXQ1NudHIzb2gwNFZGZjc5NEU1MytTaG5abDE1WGpEMi9iTmsz?=
 =?utf-8?B?RVh2c0drQlorOFBjbGF5TXd5UXlmeGNaZlUvcWhBTytSL1Rwa3JWdEZublNi?=
 =?utf-8?B?Z1NCdmtqNGM3ZW1ybGcxeFVOL3hITXFzT3FmYi9RYytnemVVa3VKVzF5enc0?=
 =?utf-8?B?UEVhaEpKWHRic1RBZXlMQUhzbEhEYTN6WGk5WDlYSUV5d0x1djUwdmdWYVJW?=
 =?utf-8?B?MFptdWNNSWxKZUpyc2lyMTVwclNsTktNZy84L0pPMitwaFJ4ZUlsbzNNd3dj?=
 =?utf-8?Q?cvUG1DHpapE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF97E574FF7.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFp4ZWlEUE1LL1pSZWQrTk9rV215Ti9KRjU1ZjRVdFRVUzRGQ2pTOTRHOUtK?=
 =?utf-8?B?NXdyTlljSThFMnFmWkpneDBhQS9ZeHV5Q3o1MG4zTS9RbHdzOG1LMjhRUmdT?=
 =?utf-8?B?NExvVEttT05ERmF6K3FyU2NTMnZyMEo5d0hyVE1lL244djc5eWdqSGJzOU1P?=
 =?utf-8?B?VmQwdlR2V0w3MW5iY0FHNFdMTGlYWDczN2UwZWh6cWtXOVdZUmMyQTFURmh3?=
 =?utf-8?B?THF3V0xZeDZxM0xNQzR4bm1UaEZaOXpXTlRHYmU4VHB5a2c0TUxyTnQvM2ZJ?=
 =?utf-8?B?N1ZCWkdTcHJqSVN3T09GcG1SeVVxaC8yRmpkekxvZ3ZSNlRJTFBRYk9IeW10?=
 =?utf-8?B?SFJtdUp1RUZFVFVqZ0dncFJBRmg3TUxKQytKU2VEbzlKQmNnZEgrWVZvYWFW?=
 =?utf-8?B?KzcxMkN6QUFmejkxb215TzhXTGlPNVVCZGJlMDRJN0ZTU1V6eWZnSi9lWXFG?=
 =?utf-8?B?Y1BjeGR4eXQ0SWc3cXFyL1lmNTM2MFM1Mk1GM2Q3UmdIaWxlR0RNdW5Ielp5?=
 =?utf-8?B?aGxEM3lQcXhNZk5xdmZZRndjK3dYanNOUStVMDVSVXVGMnZlZFg5QnpldkRC?=
 =?utf-8?B?SnhsdGxuYWttdGV3TC9WR3Q2ajJ3K1cwZTRSS05JeVQxQjBZMG1iRWN3S2Q5?=
 =?utf-8?B?Wm82SEYvYTVoRWNaYW1VcU1CbHlkN0l0UXI2Zk8wbXdBK01LcldwQ0hoaVJx?=
 =?utf-8?B?dHd0UVZUMU05aU5TdzBKRGxKbWFXeFNkc3J6QVdVaEdRTnVwMVBnTVQ5YjVv?=
 =?utf-8?B?QTZiR2ZlRXZFQm9CRU1tMkRNQXpNZVJHMDNHQjBhekhyVElaaFZ3YnpFWVZB?=
 =?utf-8?B?bWU4U3IxVHd0aDVlRU04YmVyY2JrZExkVlNlTjZkdWZka2hFYU1iYjRDbUFZ?=
 =?utf-8?B?UEZFR1dTazdyRFhMUGtTbGFNY1hPQnU5RFFZVit6WlVUc3NLdDNyeWI3ZXJa?=
 =?utf-8?B?aExDdVdtSE9jNEVQRVVGQ3lxSzIvRndUczJLYWlPUVl1NkRnZjdEWFkxRC9a?=
 =?utf-8?B?WDVteVA4RVlKaCtVdElLUUJFb2M5ZXVEOTZFZjN4VEp5ajY4SlFSN1g0dlRz?=
 =?utf-8?B?VXFOTFRsSCt6dDdGMFZTbU8xRlMwdTd1WkJMQUREWkFCbWlmY3lQbDlUZmZ2?=
 =?utf-8?B?aVREZk5GS0NDSUhESWtJMFp5LzFwbm5DOTJLU0FvUHhibGpyWnoyc25aK2JB?=
 =?utf-8?B?RDBoeWQrc2pXQUJJd2FST1JQYzRESVN4TEtZd1U1VVU4N2Eva0tZRnpOdzJt?=
 =?utf-8?B?WjNYY0Z6ak1QODVZZlYzcVN4MXNxdHhVQ1crOEZTT2FLWmxpUXE2S0pkWDYv?=
 =?utf-8?B?YUZBUGNjVFdMbHRONFcySE9yL0ZlTDI1ejZFaVkxWTI4SVovaHMrNmxVcDdS?=
 =?utf-8?B?dkxtc3NGMVpQN0I2elRVd2tvdGdqdFIwR1M3allEY3RXSDZySmlZRVpKa1JG?=
 =?utf-8?B?eFh2Y0pqRytHU09LTEdEdDBUTFljTytIWHVZaUloSy9xaEdZcXA0SjBLSkFJ?=
 =?utf-8?B?YXRERi9ONDJNUTUxY0xtOFAzRkNUUGsrRmp3MnVIRWVNc042c2I1T2NVSkV1?=
 =?utf-8?B?ejg4SDJabmF3eXBJbk1TM1lhd3hodEVHQ3h2TkhsOHNCeE9KZzF6VGdNdUR3?=
 =?utf-8?B?OHloL3VFYVA4RXFyS1gzVWRjR2dFVDhEaGdHK24wOXhlbkVyeWlQc2pxTWFi?=
 =?utf-8?B?dTlRN3JaUmJnS3JWNlRyWWpHanBVckw2Q3ZCTlc3MUdMTlB4MEx2NFhRRm5V?=
 =?utf-8?B?amxZK0pwWmZjVkx1UnVFeWhnWXA4dys5YklZb1o1RGRzcEZpaFFUbnRKdW91?=
 =?utf-8?B?SGhqZ2orMmNGdUxOSlU2MTZMM2QyYWdnN2F4SDFhT2RpckxwQUFOSVdjdG42?=
 =?utf-8?B?OXRqeUVCRjRTNFRicGpyVVN0b3ZLc2JiaFdPWktnc3c3NTYvK1BRN2ZyMzhV?=
 =?utf-8?B?Qk92RnI1b01wK1NqNlA3S0RWMjJ5d244YmRHSWJWbUNtR0RLUFZKblN2aUhZ?=
 =?utf-8?B?OW9uQy9JdW8vb3ltdFY3NGRDNUR3QlVYUEZSTGRwWWpFTEpZMWNOMDBpTjhN?=
 =?utf-8?B?UVd1SjVxU3dLclN2N2t1dWhrOHdzYVdrWWNCbmIvaVlzcmFSa2NYNXNncTNB?=
 =?utf-8?B?RElsM0Y0eER2RXZOdk1GdlAzN2hKQ1o4WjlMVUVBZmFoZ3E4Wlh0WVdKTzNW?=
 =?utf-8?B?MFluWXlDWDBzZnFKeVAyc2FoZStiMnFGTFNOSkJhK0ZlOUxpOE9Bb25rc0JY?=
 =?utf-8?B?T1lPZjk5bENCQ1hSYjJYMUcwRHBnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mGdvop3OW+hpufuJZ7lJfT6FkKK2boNxRMlxLpWP2OLLqIUo6fXLB1VqnJWYn1z1vjix1Is6Ncaec3FfjLPJJvTHLkYyR3iPYBQQX2JF42KkuPIT27g3donU3dEcw1uejHCHNaLvoAQixNscOLvvkUMi5N/4pRkkkUcznOd9gFvHOYokiGYFHg6licPU/jg19/j7Z9pcGQRzOCBWieBKCQKwq84eqewhxjAtXn1328LmL408kWNWXU+29MB9AkffIYysvM2GnjW0s1YtbLhNl4ZSZ7y7m6CUGhR/ImCxvpBPHCy3i+DiVQJZktaoiUJWep1iKCzleQov4hV4NlHuRGFPhzmtkZMaujOzcBNkwIA2O71qOzeZfna1g0bYO7WvADCeCi0cQZPdY9xOUtKUadbCc3NP1askkdd0Y2RbM8GpSlbhEiih/bVrEx/SQcEDtkwvyur7jNenjM1Fs16KjnrGZAns2ONpZ/D7ey83tlVlUkS7ThSeDOlCmdOWoNq1V1gcTUevo9rtz/sCbBaUHPs5su23YX+rcl2A4qIO9L5nBy2VVU/Q4tLegqdxf7ELtU3lDbrGmiO/+U/qcrqcda4dcmzgi6BmdUsa1KwN5tw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a83680e-4257-48ce-ef97-08dd9388cb40
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF97E574FF7.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 08:16:29.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VG5pJ6PsCnfkCP53J4bf84fsr9SmwLwX+Gx7JLPXqDIclsu3sgIAL1hpcLOEV5KSotMvfq1bUmqEAw6mY4XRbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA4MCBTYWx0ZWRfX5Sq4TkCdvjkJ b/2K9ozZw3MdTks3r2OsDnb/q4/kpAOg6mBuqzpn0ndDTaDCecHwQaKROLHWVu70x4+Kf+3o1Xh HjBGbYvo0k6nNJfP2k9X7JA38SkXlwkvMNy1wCKZfFjx/kyxB+Pla0volQq7Kw4nCMGmQAT9yl5
 FMHavugHFYQgBZ1VqUeZpR55Mq/5bAjWZKnbWMF8KkPtgf8b8vBmNobf9U5u5Rh55GrsdsqJxWu 0Qvk2iF6UMAw+Mjmru1RkfZdJ7Tj50GybZlplkw9IUVrkpAB06q8z566Mf8zXcgvTmkb5jb0ZVN 2UinOyjRLnKHMBNys2cSbBijBv1WSnc1y+J99OhEnnbatguj5mhMG9SEX+MaFzJHprvxoqlxiSp
 ADVtShyDT2I0aQQwRgyWEi1xhyqlzXd2T3zSvTVMGsp/rNHXMDnkyaLW0PQA87b60pKvwGYj
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=6825a2e5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=5btPe3FBWFK96Y530zoA:9 a=LykqdjVeTy6PvCqu:21 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iR81VhFK2JrgfZFWnb9p_8RsviQYJxHH
X-Proofpoint-GUID: iR81VhFK2JrgfZFWnb9p_8RsviQYJxHH



Here is a simple test case that reproduces a scenario where mount -a
gets confused when an LVM non-mapper device path is used.

When the mapper path is used, verbose output reports "already mounted",
but when the actual device path is used, it reports "successfully
mounted". Since the mapper path is just a symlink to the actual dm
device, shouldn't mount -a resolve them to the same major:minor and
behave consistently?

util-linux 2.40.2 (libmount 2.40.2)


$ file /dev/dm-0
/dev/dm-0: block special (252/0)

$ file /dev/mapper/vg_fstests-lv1
/dev/mapper/vg_fstests-lv1: symbolic link to ../dm-0


------------
Create a Btrfs filesystem using an LVM device and a block device in the
same order (or using two LVM devices). We need two devices; otherwise,
the kernel doesn't go through the volume assembly path in memory.


$ mkfs.btrfs -fq /dev/dm-0 /dev/sdb > /dev/null

Udev creates the by-uuid symlink using the mapper path.

$ blkid --uuid 6e80077f-0e0d-49a6-bcb5-a9aebd4fd113
/dev/mapper/vg_fstests-lv1

mount also follows the mapper symlink.

$ mount --verbose /dev/dm-0 /mnt/scratch
mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.

However, since mkfs.btrfs used the actual device dm-0, and the mapper is
just a symlink to it, the path won't change. (I will fix mkfs.btrfs to
use the mapper path, but that will hide the subtle mount -a issue.)

$ cat /proc/self/mounts | grep scratch
/dev/dm-0 /mnt/scratch btrfs 
rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0


$ echo UUID=c48751d4-0b34-4480-a51b-2877474c17b7 /mnt/scratch btrfs 
defaults 0 0 >> /etc/fstab

$ udevadm settle

$ mount --verbose -a
/                        : ignored
/boot                    : already mounted
/boot/efi                : already mounted
/mnt/scratch             : successfully mounted <---

$ echo $?
0
------------

Now use the device-mapper path, mount -a --verbose appears to
be correct.

------------
$ mkfs.btrfs -fq /dev/mapper/vg_fstests-lv1 /dev/sdb > /dev/null

$ blkid --uuid 3e6036f0-0187-487d-962f-9573b68e9468
/dev/mapper/vg_fstests-lv1

$ mount --verbose /dev/mapper/vg_fstests-lv1 /mnt/scratch
mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.

$ cat /proc/self/mounts | grep scratch
/dev/mapper/vg_fstests-lv1 /mnt/scratch btrfs 
rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

$ echo UUID=3e6036f0-0187-487d-962f-9573b68e9468 /mnt/scratch btrfs 
defaults 0 0 >> /etc/fstab

$ udevadm settle

$ mount --verbose -a
/                        : ignored
/boot                    : already mounted
/boot/efi                : already mounted
/mnt/scratch             : already mounted <--

$ echo $?
0
------------

When the mapper path is used, mount recognizes it as already mounted.
But when the block device path is used, it doesn't recognize that
it's already mounted.

Also, in the older mount version 2.37.4, mount -a fails. Any idea which
patch or patchset fixed this?

---------
mount from util-linux 2.37.4 (libmount 2.37.4:

$ mount --verbose -a :32
/                        : ignored
/boot                    : already mounted
/boot/efi                : already mounted
/Volumes/work            : already mounted

STDERR:
mount: /mnt/scratch: /dev/mapper/vg_fstests-lv1 already mounted or mount 
point busy.
--------


Thanks, Anand


