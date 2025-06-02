Return-Path: <linux-btrfs+bounces-14357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF5ACA888
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 06:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A45117991F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 04:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A3913B293;
	Mon,  2 Jun 2025 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lNygIL3p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bxmEfNsj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B26522F
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748838417; cv=fail; b=B0NZyA7rgcLpRyDJsb0S1+u62Shjb3SH9/dVAFh6FaYcoLUCsAPJogPT94Jve43ofmU6I9Zft36QyN2aPpHQEvc7bcwCDZyEAKQa8gj2XD0v1ALaX1Q8m1ScQsds9UCiBshGlfo8dB93gV1Um+A121w9Fa13swVXtj+rNOeTr3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748838417; c=relaxed/simple;
	bh=v0fc8es8gRqPqOXIyTiJg8VO3EsVK2kfGKmDXfgCNoU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YPsmw1jX4XYDbkrXOCM+hpVR8UqbF59LpWyNWaM+PvbtzvF94xTI5PXxFTpQH+JEXZ+7iMUBGd+qN1qJnSxPDoxwHeol8eNuSNVmQvnyo3TU59NkQp6tL+2wHKbVPEvKzWhkZ0xaVuUVir0T1CbVYwTrVQ7Pj0cFmjmX2YkIahU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lNygIL3p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bxmEfNsj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551NJomK014801;
	Mon, 2 Jun 2025 04:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Hgr5xlGIsrOwzhZMJxHqSOCMp1PIQ5U/3M33FVyROeM=; b=
	lNygIL3pLr6BO8BlfMyiYPkA14XQZsZIj+LDBB/NrXOkznllbl+2bTY052fNf7At
	6c6nDt00XvogoDKag2221jXTR6a9Xd3HYazgZkm16M/1PPeExLW63bWs+df6aiDI
	eljUNZxM9Ks2IMZcUCbTWWoFeVlmz1j2JhS7nebXXCHW+pnsIMTUcvsRiIKT5Ffs
	O4iUANUt0HEUjhxXQfEVMZ/lE7cuTpF9qXnGVhnjTejuHambVXprH55QzAMRCTR8
	Ahcu452rASUbtpIYC1xI6o3geJcrqCIl/HPeSYGUT+EqTUrou/GYIdWhdrV/WCpQ
	McWOZyOLuDzJ82IGXRJr1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yscw9r68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 04:26:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55220n19030680;
	Mon, 2 Jun 2025 04:26:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77fqcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 04:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPfnRf47xWe6v+OJseUY2GCDCSw6BSXz4MOv3uRx8/W5iKiVIIn/skR6wE327Nmz6Ur5CRCZHj5KUsaT9Go0XwGTm7KSQDJONTZrjqK9EygmwmYQDhXw+/WYgOjGv+XDnWgB1ghKTt9gi5/X3+22vi01GiyCZWegXzJvvf3S3h4MFCsMV1A319viSkmafQNli3TA9sderRNpC8YMxcW/bDpz7npzG2n+BIRplg5KWOmUllAOf4F2RjHuFukAFhkfAp8g6SsA8iXDhlJOfwoAg7Ckmbj/MBeNAu86GojGSpkcpK1WKerm93rdMfKzrpe56QCDy+sjo6K8VCTI4kXixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hgr5xlGIsrOwzhZMJxHqSOCMp1PIQ5U/3M33FVyROeM=;
 b=KkmJW3EzeqaYuMHmRdLaLJ44fO237kfyhmcTuDogSZPbKeoq6oIuJ+UcFp/mBLqkCYPGnlbbz7BQUYlrvdKjuh+fAcMNheKkzRg3HsUhRaGGogBgR4HDFSdV3A/iGYj2EF/TlRQWnzKGa75+Ckxro8GNBB8PqFa8xnOW05x6oI+baPZvmJq5DCygssBmEnqZsc5HzVENzZHP7KAUGXi6kDeofwUiaGEnJhxUybxwMDkKnm6mAaQdXVI9Vrsjko8/5eK++Izf+XYdtKm7TXG9FT+TTzRcBmIUF8tJyZkVEANRRDuH4pbFFN706LHw1ytObmeDvb46WBUjLjU3MY0UBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hgr5xlGIsrOwzhZMJxHqSOCMp1PIQ5U/3M33FVyROeM=;
 b=bxmEfNsj43d9cAVNcIJIGrH0aFT2QE/3pGEiR9b1xD+FhNaht3LaguN+mcM9hIuoy0YYHevdAckUp/czo5zcOwTMhaAhlqbdPlCeNJPxX1ki5tkLheXbRFX+sDg/4PSwIRY6SyuVGgaSH7LxfJsaN7YWRqD9Q2gUu1vFE1SyDRU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by IA3PR10MB8419.namprd10.prod.outlook.com (2603:10b6:208:57f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.38; Mon, 2 Jun
 2025 04:26:44 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 04:26:44 +0000
Message-ID: <5210224a-68ea-42e5-ac67-4b7aa44e761d@oracle.com>
Date: Mon, 2 Jun 2025 12:26:41 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
 <aC6jEehifdWWq4Pq@hungrycats.org>
Content-Language: en-US
In-Reply-To: <aC6jEehifdWWq4Pq@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|IA3PR10MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 16aca182-33e7-4338-c318-08dda18dae06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzR4OFd3K25JbXpXWHlpR0xsZjZWUXZzeEVMS1pYWWI2T205NGd5dFNoUVpU?=
 =?utf-8?B?Z29YYmVBMnVRQXFNUmZxRjMwZWlBY1pNSnVGVkR3OXVWUFNVRnlKZk9RdXcr?=
 =?utf-8?B?emV0RTRGQlBOaFhLMFZpdjNOeVg0WVFWQVg0aEFXcnpjUVZUNmJDNitrYVV5?=
 =?utf-8?B?d2lnZzYxNGJ4VkpoK2FPMzQrZFJoaFJDZ25iYmYvQTZiMFo2cnlkb1I1a2h2?=
 =?utf-8?B?VDBTR0JEWVFrVWxuQzJVQUloTFBzZ0t0SjRlYXJvSDBpTlFXVDE1cjI4bE5l?=
 =?utf-8?B?a016L2xvTytmamR0dnFjN1MvWTMyNEJTelBreGV0SDl2Wm1vYzVCSXNka0Nx?=
 =?utf-8?B?V0NnOVJFbU5ZSWRKVVFkV1h0NXhNM0piZ1FpRXFSRVFFMUJYemVpYlUvOVZl?=
 =?utf-8?B?Ti9UNk50QXA5RFdaeTJMMmpVaFUwMFU4NWVEV2FNaW5FN2VCekNqUzMvUHl4?=
 =?utf-8?B?Tkp6L1E5eW1sVlAxa1cwZTdGSFQrRy9DQ05yMUU4SHg4ek45dEVjUjRDOE1n?=
 =?utf-8?B?SS83ekt2ci95RjdwcnhLZFIxNEh5Rzk0SmtWc0lzd1VnUUFuMExScUd0eVVw?=
 =?utf-8?B?YStaRmtadVNBOXhROW1TeEhBVGtFS2hWeGxXcEJkbkxRbFRwdXUyeUhLOEt0?=
 =?utf-8?B?bzRKZFZBMDJaK1NyKzJ3NTZHUjJWeVJRVWFrM3hORUxoSXNScFJrNmdGS2lm?=
 =?utf-8?B?UVljSlg4LzVVcW5FMnZySm9Qd0Fka0k1UjFzVEw3dnFYRUJWaG9ENEhzakQ1?=
 =?utf-8?B?OGE5NU1Pb1JnNndDZEdDWWRQQXNnb0p6YzFvU1FMdTlpT0ZyRXMxbS96U2pT?=
 =?utf-8?B?ZHp5MHlkNzkrdFBaRHZQUi92bFpub29sT0N4cXNaQk1IdWdyc2ZDN0VvWFRT?=
 =?utf-8?B?dWVQVmNVcFlwT0Zka0N1NU5MTXN3a2prSFhSdEJETW5sK2ZlcTdMd0tIRWtU?=
 =?utf-8?B?a050dmJPZWxrS08xb1dCU1FZWCtaeWwrODUrU05kb1htMVBuYTlHSHdvVEgx?=
 =?utf-8?B?NVdWeitOdFpYNFUzRXY2OEp3UksvbXFHSWQyRXpVckR4TGlZK05admVINERh?=
 =?utf-8?B?dDM5c0ZXMDg3MlZURDZ3eXZ5cjVpODdib05DWmNuZm9Oa01BLy90Y20yemla?=
 =?utf-8?B?T3ZhTW1Ib3FMeHNRY2EvR1VjbVlmWmdUYXBBZC9ZN1k4WEpCNFcxM3NxeWYv?=
 =?utf-8?B?WVVxWDZjTTE1cWlKdzVyb2V4KzRxZWJGOFFwZXltSklPVHdNRzBTT3pjR3po?=
 =?utf-8?B?TzNoMythUEpheGIrUkVadnI0SDV4dVUrakY2K2orbWRGZUlIWlhkUmpOM21M?=
 =?utf-8?B?eDhQL2daV3Z0Y25zQU5HSE5mVlJabGttR1Npb0FaK0ZyWVRKd1kwUUVxbUw3?=
 =?utf-8?B?M1ozMkJPRXZHeDlSWG04YWFWTXVEWjd0dWRtblpnQXltZm1EUWZ1R2xad2l4?=
 =?utf-8?B?cERJUjNZWHNPN0xkM01oOWVEeVNNTjRTdUp5SGQ0bnJ0M1pxZ2N6S3BVR1Rm?=
 =?utf-8?B?QkVrRURzVm5JYjAyaHMyeUFLWVkvcWlFV2hFRnlTU1ZxcEhrckNYQjJGSUR2?=
 =?utf-8?B?VmRxV2xhYms1V1JWSWhvYVNWNnBCdFNjTDBaeDcxc0VsakZEVGVlb3FKVkRZ?=
 =?utf-8?B?WFpzajd0VnBWY205YlEvT1ZrVzE2RXppOW9TdENsLzhlajZzWDdueTdxd3Z2?=
 =?utf-8?B?UHViV2IxdW1JR0RDTkJTQ2RsbmRlRDVhQW1senQ5WHBRWEVPV3ZudVBBby94?=
 =?utf-8?B?RkhzQ0dtR2phUVdTL1RhOFpnQXlsVTkwMFJ4NTg4NnAwTFV0TjZLMDdHQ25L?=
 =?utf-8?B?SkY0VVBraGNrcW1YUUtlQUJJOHlyTEo4Q09jcVhYQ3RKVXJ0YTV2dnc2Wldj?=
 =?utf-8?Q?r2jLSj1G/pRPl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHdWZHpDVmZQa3V6a29rM3VpeXF4NkJBNTBya0RsS0l3bkMxbThlNmRYTGVj?=
 =?utf-8?B?T0NzR2NJell4UXRlVVhzekxONUNsT3JiZ0x4NGY5K3duNHRXQ1NmMG9vc0F2?=
 =?utf-8?B?b3VFYlc2L0FDNUsrT3RheGpPWEtBekhjODVIb3AvUHFjUjdkdUR4N3VlLzN6?=
 =?utf-8?B?a0VVVStoc3hoUkN4d1g1Zjd6MUNtUU9xOXcrTWZhdnNaMU5XbjF1bnN0akRw?=
 =?utf-8?B?MkN4cnJpS3lZckxmUVgrMkUrYzcrSDhqb0lORGJETDlYMWRNMVVmc2FQVVZU?=
 =?utf-8?B?SGRDelhLRTRGcVl4RURRdWZjQ0x0OVUxK3dBMDUxNHNEblVFemZEOTlWMndz?=
 =?utf-8?B?YXNrSnF6Z0NqRXFQNFVlNm1ZdiswV0I3bVluZUxldWEzZkVsZVcxRm5CalBC?=
 =?utf-8?B?TCs0UlcwdzRqaXNTSlQyU0U1d2Y1UnNlNVpZN29EdDNVc1FCRHJQNFBkTEhl?=
 =?utf-8?B?YTdKUG83cFMxSXVlS0pmSTFiOU9hSFRHMkVMYUN2UGVaWG1qeTZEVVdxeE9N?=
 =?utf-8?B?bmJTVlZoNkV1NndndGF4Q0l6SU4zNElsYjdKaDFrOXZZWHdoWXJra2FIWEdJ?=
 =?utf-8?B?MDF6aTA4b1R6ejk0cjJwVkNURDRvTVpvQW9FSUZpMVl5MkUwc2JST3lMcEdG?=
 =?utf-8?B?WjhMakFXRmJSc0FIQVl6Z2xQZWMybWI2dWI3c0tLVk9aRVA2Y0ZpcEp6M09E?=
 =?utf-8?B?TFJkbEpJTlRMUmJkZXZTOG8yL05sdE5pRnFldDhiSkYxeGZFTzZJcVpYYTNR?=
 =?utf-8?B?bEFEaUdQTmRpV0RFMm9zWGVtVWZybWwrN3FWZEMyVU9RSHkrRURtcjF3OHJH?=
 =?utf-8?B?QnpPYWNLRFZtRi9iM1Vab0VkRlJEZzVKMmtoWXZldTBtaTBOb2lHTWExTEtK?=
 =?utf-8?B?TFJHUnpXWHRpS1YvMnkwWHFJdVVENzkyS2tWWUZaMlFhcW1WYnBVSi8ra0Z5?=
 =?utf-8?B?MFc2N0VrNlNucHZuWHpvS0o1MG1URmlaNUMvdWVBYUFaM2lvVFI4ZWhrZUpC?=
 =?utf-8?B?K0xKR3RmK0MrMFIrUHE3NWhNT05xbzJSSFFVYTB4TzBXT3lQVUdxVEV4ZGhj?=
 =?utf-8?B?YjNTMUgwTnkxWURsb1dFRUg5cm5DajZrKzRHQnJ1SFhoUHZYbCtyQ1RkbkJk?=
 =?utf-8?B?YUNPdmJXd1hCQVpnUGc3aTBsWnc3S2lmRGdvN2J6emY3bm5NQmRNS3piRmR6?=
 =?utf-8?B?c0w1VDhxZW9LSzNWdG8zdnVhTkd4K2JwV20wbmR6UDFqQ2g5TDdCczNOcmd1?=
 =?utf-8?B?QVhJa3EvNmIrM2dYVDQ3dGYrc0U3UVpLMFU1QUJYOEx4TFNTckpqeTdrYXpZ?=
 =?utf-8?B?ZG9sanZQUjFlRnNsRkFnbVpkUWVGeW84aFhYTkhpOVpRTnBSUnNlUVlpcUNh?=
 =?utf-8?B?U2Z5dVFnOG9jTFYvc2JLRDlkT3JwWmxSTWxnZktRSUx2K2xhQzdXNkU0K09n?=
 =?utf-8?B?SjZJNGxjbjBadm56dE9mb2NMQ09pL3NpQlR4MGNIc0p4Z0RrNmZQWmFaZzJE?=
 =?utf-8?B?K2c2RHBQZ0VqQ09vUURXRVFzWE5iV1VXOUswR2hTZGFXdjVsZkFXUXpVcTla?=
 =?utf-8?B?aFhEV2JXQStFNnVEbnNzejhDSnFZbm14ZGZlQVRjUWU2WjE1ZG1HMVNwdXhE?=
 =?utf-8?B?QjRnVDN6WUd4Z01VTGtqUlNNeDBnMkNqM0svamovcWlWWFZDK1Y3eHJJNS95?=
 =?utf-8?B?WmFtR2w1WUxWeVBPZmhadC9DN0xhQ3Fod3pqdkdncEY2QXZhbTdYVzhNUFNs?=
 =?utf-8?B?d1R1MEpxUGRzSXphenFQMEpoOGxDNXNoM1NUT2g0Y2JYQURmaWo0YTg1Z1Yx?=
 =?utf-8?B?bjBiUEJiR0JnN2lDTnFTTkRXT0ZOQzZZU1FTZGtMM29zY2xnUk5rSyt2RDN6?=
 =?utf-8?B?WTVrMXRzZUFBUnFYOFlQVm1qemZEOXpEZmVIcEpqb1JmNG9yOGNmNld6MDV3?=
 =?utf-8?B?OG42OG9lRFh6YVBGTkdCTmU3NlA1ZGY1V2k0YnI3anc4UUd2bGpJcXpTd2x0?=
 =?utf-8?B?SFFNYmZWaExQSDd5VzMweDFPVUtZeDE3NXZtYnA4ZHFMSFVNZUF4QnMrSkRj?=
 =?utf-8?B?N0NNaUdtZjJ1cElXbTBPNWJRRXczMU9aQTVURG1DMEpHTURuRXBCNDU3Zysv?=
 =?utf-8?Q?EKuhUWXQXwrvmcmASWvO4vtq+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vS0X8lnUpFD8S2YNH0rnROEJCcE8T2wlOB1woW5aMmhJSShII2X6kpk8OgllEQOS+tMCAOs9xylmOMoI/I7U1nZ5cG8GAanOmnFLOSfx43w+6IUnCI79a/eyJ77m5kkd1SiOCaJW8XHkuFF7sRlg4dSnnwpkICizErZ1vKtynA2VQ1rDUNImXZ0oiqdnmZ8ZRZS5Hm//aIuOWfczlJs3Xqj1cmeI3eUBJtlq5SFX0myqA4V7Ag21W5stLNlKfiCNb+QKhv/RpxxE+46jkey9Vf0gq0l6NgjFBGX37C4YA1rNdN8HPnRMx/reIGYkfLiWeY2Fd3pyCQA+ZdMnvj3dTmJFzXoaGSEIt1fQPxPMGmwsLWg9sJlsj0EdmuFWkXfqcfpQgwJWSm5C2Zfh8DXSzbDFt2HlsML7L5rVyTnPn+f9yzNHgQzZ0MiWRAyfAjPoZ+PCC4lyVmMdpwmpyS1o9EBoAq9QJoWT53F3frxjLROyMfYSxN2dh/sHDe/TJUqUUxERGXvQsadhs8Zub80mU2RFJktisKWKvJir1ghTDWXEG7RF+UBhinE7N7y45zolfAad3t3kKFcy2C0YoFULKqWOanz6jiBIz7oWnQ+kNvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16aca182-33e7-4338-c318-08dda18dae06
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 04:26:44.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XI/n8M5BM4fx0C6kfX7Hy9z+JpknYEFtUMpKcOni60N3o0N4M8IGjoIT9a6KTFs6Zc6+9Uw0W36N7/zY77xVRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_01,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020034
X-Proofpoint-GUID: p2KfryPJj9HjvwCodwsR6P7JExkt5YGK
X-Proofpoint-ORIG-GUID: p2KfryPJj9HjvwCodwsR6P7JExkt5YGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDAzNCBTYWx0ZWRfX/yvEg411DnXA lWlFXNlsP0BoegfSaRcj4nJR4COE0uCFM82BbZsKzAO1LVMICjMOtWmotIA2Kmr2H4UyqCItFAS KdDvrosxuQg5dxic9eXLScLBZZUI6HS/NcsO7WTJIP2Ao5ahVd9h7rrHUKHWoxTti+CRISgHzEX
 R467lAqdL1jRKoQeledkHaKWwPfInpFeN0ZgAKxnZCdHI+ySFYvq0QfCL3NWGQ03xp6og8sTz91 WEWx66RoxJjTSiDC2kl4F//g/rCr/xCdQlRO4ok3MOBeZSjbG+XxOT6bwPZaE4jkH6LtrqHmD+Q 4Zot3673gfrkStYKHQgC2l5KM0YNRF27rTwm81E2lFRROUX17hx3b6N1VZlPPL4aKh8vCZvrgce
 PItrnG8YZXT6EpGxoli/hbjPHgsaKobX+rXbNGhTxMMbawXeqcYIsKl/6kQ+7JRWcR989Xbc
X-Authority-Analysis: v=2.4 cv=N+QpF39B c=1 sm=1 tr=0 ts=683d280c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=h-CwbLocAAAA:8 a=NEAV23lmAAAA:8 a=t6aiXnipmA-TvF3zxSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=jt8RqQJvuDcA:10 a=qB-ckWXWHtAsDaNONmv4:22 cc=ntf
 awl=host:14714


Thanks for the detailed proposal, more below..

On 22/5/25 12:07, Zygo Blaxell wrote:
> On Tue, May 13, 2025 at 02:07:06AM +0800, Anand Jain wrote:
>> In host hardware, devices can have different speeds. Generally, faster
>> devices come with lesser capacity while slower devices come with larger
>> capacity. A typical configuration would expect that:
>>
>>   - A filesystem's read/write performance is evenly distributed on average
>>   across the entire filesystem. This is not achievable with the current
>>   allocation method because chunks are allocated based only on device free
>>   space.
>>
>>   - Typically, faster devices are assigned to metadata chunk allocations
>>   while slower devices are assigned to data chunk allocations.
>>
>> Introducing Device Roles:
>>
>>   Here I define 5 device roles in a specific order for metadata and in the
>>   reverse order for data: metadata_only, metadata, none, data, data_only.
>>   One or more devices may have the same role.
>>
>>   The metadata and data roles indicate preference but not exclusivity for
>>   that role, whereas data_only and metadata_only are exclusive roles.
> 
> Using role-based names like these presents three problems:
> 
> 1. **Stripe incompatibility** -- These roles imply a hierarchy that breaks
> in some multi-device arrays. e.g. with 5 devices of equal size and mixed
> roles ("data_only" vs "data"), it's impossible to form a 5-device-wide
> data chunk.
> 
Thanks for the feedback.

Details about the current proposal are here:

[1] https://asj.github.io/chunk-alloc-enhancement.html

Some allocation modes aren't compatible with certain block group
profiles. We'll need to check this at mkfs time and fail the command if
the number of devices is below the minimum required.

The role hierarchy (exclusive-> none-> non-exclusive) only applies when
there are more devices than required for a given block group profile and
the allocator has a choice of which devices to use.

The use case for non-exclusive roles with striped profiles isn't very
practical, but the design allows for future extensions if needed.

> 2. **Poor extensibility** -- The role system doesn't scale when
> introducing additional allocation types. Any new category (e.g. PPL or
> journal) would require duplicating preference permutations like "data,
> then journal, then metadata" vs "journal, then data, then metadata",
> resulting in combinatorial explosion.

Special devices like journal or write-cache are different; they are
separate from the data and metadata storage devices. We will still hit
ENOSPC even if the journal device is empty.

That said, it is still possible to specify write-cache as a role. For
example:

	mkfs.btrfs /dev/sdx:write-cache ...

I'm not sure I understood what you meant by "not extensible"?

Also, allocation modes (for example, FREE_SPACE, ROLE, LINEAR,
ROUND_ROBIN) are designed to be composable as needed.

If roles do not cover a specific use case, the existing alloc_priority
(1 to 255) and alloc_mode can be extended to support new logic.

Note: LINEAR and ROUND_ROBIN are not implemented yet.

> 3. **Misleading terminology** -- The name "none" is used in a misleading
> way.  That name should be reserved for the case that prohibits all new
> chunk allocations--a critical use case for array reshaping. A clearer
> term would be "default," but the scheme would be even clearer if all
> the legacy role names were discarded.
> 

Got it, I'll rename none to default.

"None" is internal to the kernel and means no particular role
preference. It currently falls into the middle tier (41 to 80) of
alloc_priority, but we could adjust that to something more meaningful if
needed.

> I suggest replacing roles with a pair of orthogonal properties per device
> for each allocation type:
> 
> * Per-type tier level -- A simple u8 tier number that expresses allocation
> preference. Allocators attempt to satisfy allocation using devices at
> the lowest available tier, expanding the set to higher tiers as needed
> until the minimum number of devices is reached.

This is the same as alloc_priority stored in dev_item::type:8.

> * Per-type enable bit -- Indicates whether the device allows allocations
> of that type at all. This can be stored explicitly, or encoded using a
> reserved tier value (e.g. 0xFF = disabled).

The device type can refer to a special device (like write-cache) or a
regular data/metadata device. Within a data/metadata device, the role,
whether for data or metadata, can still be represented using the current
*_only, *, or default/any roles. So this approach remains compatible.

> Encoding this way makes "0" a reasonable default value for each field.
> 
> Then you get all of the required combinations, e.g.
> 

Added below the current proposal.

> * metadata 0, data 0 - what btrfs does now, equal preference

  role=< > no role | default

> 
> * metadata 2, data 1 - metadata preferred, data allowed
> 
  role=metadata

> * metadata 1, data 2 - data preferred, metadata allowed

  role=data

> * metadata 0, data 255 - metadata only, no data

  role=metadata_only

> * metadata 255, data 0 - data only, no metadata

  role=data_only

> * metadata 255, data 255 - no new chunk allocations

  Flag it read-only.

> This model offers cleaner semantics and more robust scaling:
> 
> * It eliminates unintended allocation spillover. A device either allows
> data/metadata, or it doesn't.
> * It expresses preference via explicit tiering rather than role overlap.
> * It generalizes easily to future allocation types without rewriting
> role logic.
> 

> "Allow nothing" is an important case for reshaping arrays.  If you are
> upgrading 4 out of 12 disks in a striped raid filesystem, you don't
> want to rewrite all the data in the filesystem 4 times.  Instead, set
> the devices you want to remove to "allow nothing", run a balance with a
> `devid` filter targeting each device to evacuate the data, and then run
> device delete on the 4 empty drives.

We can do the same by setting the device read-only.


I actually started with the idea of using bitmap flags, since it's more
straightforward. But I eventually leaned toward using an Allocation
Priority list to allow for a manual priority order within roles or
tiers, if needed in the future. That flexibility pushed me in that
direction.

You can find more details about the current Allocation Priority list
here:

	https://asj.github.io/chunk-alloc-enhancement.html

That said, we could store the mode in a separate btrfs-key and keep the
manual priority in dev_item::type, which would give us both.
But as always, we try to avoid new on-disk new keys unless absolute
necessary.

>> Introducing Role-then-Space allocation method:
>>
>>   Metadata allocation can happen on devices with the roles metadata_only,
>>   metadata, none, and data in that order. If multiple devices share a role,
>>   they are arranged based on device free space.
>>
>>   Similarly, data allocation can happen on devices with the roles data_only,
>>   data, none, and metadata in that order. If multiple devices share a role,
>>   they are arranged based on device free space.
>>
>> Finding device speed automatically:
>>
>>   Measuring device read/write latency for the allocaiton is not good idea,
>>   as the historical readings and may be misleading, as they could include
>>   iostat data from periods with issues that have since been fixed. Testing
>>   to determine relative latency and arranging in ascending order for metadata
>>   and descending for data is possible, but is better handled by an external
>>   tool that can still set device roles.
>>
>> On-Disk Format changes:
>>
>>   The following items are defined but are unused on-disk format:
>>
>> 	btrfs_dev_item::
>> 	 __le64 type; // unused
>> 	 __le64 start_offset; // unused
>> 	 __le32 dev_group; // unused
>> 	 __u8 seek_speed; // unused
>> 	 __u8 bandwidth; // unused
>>
>>   The device roles is using the dev_item::type 8-bit field to store each
>>   device's role.
> 
> In the other implementations of this idea, allocation roles are stored in
> `dev_item::type`, a single `u8` field, for simplicity; however, it would
> be better to store these roles in the filesystem tree--e.g. using a
> `BTRFS_PERSISTENT_ITEM_KEY` with a dedicated objectid for allocation
> roles, and offset values corresponding to device IDs. This would enable
> versioning of the schema and flexible extension (e.g., to add migration
> policies, size-based allocation preferences, or other enhancements).
> 
> Since btrfs loads the trees before allocation can occur, tree-based
> role data will be available in time for allocation, and we don't need
> to store roles in the superblocks.
> 
> A longer version of this with use cases and some discussion is available
> here:
> 
> 	https://github.com/kakra/linux/pull/36#issuecomment-2784251968
> 
> 	https://github.com/kakra/linux/pull/36#issuecomment-2784434490
> 

dev_item::dev_type (u64) comes from the reserved field list, so there's
no additional space overhead in using it. I considered whether using a
btrfs_key for roles would offer any advantage over dev_item::dev_type,
but I couldn't find a clear benefit.

Also, with alloc_priority + alloc_mode, we can support a manual device
order with the same cost.

Let me still consider what you proposed again to see if there’s any
advantage to doing it that way.

Good discussion, thanks a lot.

-Anand

>> Anand Jain (10):
>>    btrfs: fix thresh scope in should_alloc_chunk()
>>    btrfs: refactor should_alloc_chunk() arg type
>>    btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
>>    btrfs: introduce device allocation method
>>    btrfs: sysfs: show device allocation method
>>    btrfs: skip device sorting when only one device is present
>>    btrfs: refactor chunk allocation device handling to use list_head
>>    btrfs: introduce explicit device roles for block groups
>>    btrfs: introduce ROLE_THEN_SPACE device allocation method
>>    btrfs: pass device roles through device add ioctl
>>
>>   fs/btrfs/block-group.c |  11 +-
>>   fs/btrfs/ioctl.c       |  12 +-
>>   fs/btrfs/sysfs.c       | 130 ++++++++++++++++++++--
>>   fs/btrfs/volumes.c     | 242 +++++++++++++++++++++++++++++++++--------
>>   fs/btrfs/volumes.h     |  35 +++++-
>>   5 files changed, 366 insertions(+), 64 deletions(-)
>>
>> -- 
>> 2.49.0
>>
>>
> 


