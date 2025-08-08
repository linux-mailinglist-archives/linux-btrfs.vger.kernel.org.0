Return-Path: <linux-btrfs+bounces-15925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B38B1E382
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CCFA018DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312E274642;
	Fri,  8 Aug 2025 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hAPnUufa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sN+UcB3Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD62741D0
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638041; cv=fail; b=UT4a40rb/lfhHYRdmaWG0Q2qirvBpVl9Za0d2MldD3A+X8FBwtYW/ZQUDxupvbh9hjqtoVsWC2HD/Bg31XXqez9PsJPQqNHUaaK79IedH8kCzLMgjWB6bioL5BbVi+PbW6mH1pseev/DdUaBY9K1nHmT5DpgoBU1HhUFQa1YlGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638041; c=relaxed/simple;
	bh=yINnHyxHA2maTAb/3OV06kMRHeDR4H9+jl0PAUFfcYQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKxzyQyO7saPjseVtHG8iGBcB+t/uAcnuC25EsDQ01vY+oRZHaxOhW0hKAQ6n2CjTd5cTJ05sc5IP/PM2FAuNIDGIiE8qLljncZWsv1BOHhY3eV7Hcz3eYiwGe45xKaU6EWrlMzXlD3LiV7efxyST1w5g457Meq7I7whHEpDEUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hAPnUufa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sN+UcB3Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786Yhuf027993;
	Fri, 8 Aug 2025 07:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FkPFteilSmYzveOUAAHNWTzdpva1jkCaTaKFJGTIDlI=; b=
	hAPnUufauOY/EiddakUBgVU6qQiIFGMI9T7iuQGSNaAi7VbhnOWHQRdRiElgldCT
	lUA/kHxJd9SiHy8/DaoKRIN849XC1SlD/1kw2FzZ2uFewnTKOgp7rVlJWoayN6KX
	Gd3Xjb0On8qRAo+gukTIMLvxcVDMH6B2uwq6HndciBI+EN/jUZlHwaph5/1MNuLz
	6wZr6rz2XzzYwfgJ60sfWbsdXQWYodJiscnLAcSSsk33gCuikisB3yIU0HQs5bsA
	jZXacHNSNr4Wv4iBZhXOIsuOxnUxAOtCCvKXDjooW0TSt6ORFj8O5d6weRsS0vEL
	wigpzdo0RBBrIG1fsRrjFg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd5skh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 07:27:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5787PEKv009700;
	Fri, 8 Aug 2025 07:27:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpdnmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 07:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdt4YmPg3hd5XpAoDc6MbAirZ/tCEAgKJPCJzL9usTSiEky30kIst5Zt3KDE2MD3bS4tgBFMLI21edzPxvmVadX1Bqk3h4TTqx5ihWSpzsTCQlApl1C2zfc56l1jgtrFXOrFgQr5Ud/ZMbqWOr791JgHz6KvoqS+2RMbmVT3E2hETyiIlPeiCGUK3cSReLNTImmhAplnQVKRugH7RNvSsA5YE9lVzovEn6GjlcNs6Snt7LYvLyIdTX0IdSi+DsqWqH5oELJ2AwUKsh49fyck1F5GGGYQuAD7NRI2dYOvTI2JuK2TjW7qAs1e5mcKAgSLzF7fQgXj4cIbL5RtqGBLkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkPFteilSmYzveOUAAHNWTzdpva1jkCaTaKFJGTIDlI=;
 b=yGPDs9snDU8w0a4v5VimnSEO81+3M0+UdhGvf+/fdJLS0nOSW7k9VU21sBYhnkZtwEDm5hMFNH18MhkemyM094PXq9GwwzTM06HeGBr2syUIUVmV0GX90ofj2d/oZ7APcioyKZMsF9t/GjjJPRTanQabOKuSRmmL6QuOlsTUBWQi5r1vpD2diz83uzWvM3YOStC9i+VuNBAdgCGHD5kHEASmQ5pF01JlJAAo48pl1jjxL+P123xghqF7grQUVJgEj6wFa8MzpqBrAvfeJm4S1Z7xtCIlcbTOGmU0NSHLuVXOgiWiWQCUB5d8rACn0siPOwYhAm560HRj8MhJTMz0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkPFteilSmYzveOUAAHNWTzdpva1jkCaTaKFJGTIDlI=;
 b=sN+UcB3QivVv0UhUh7M2Xz75Ck9RChZH/d55fSZmewhRn8d3AsaYF6hCfYqiGOLq1Iu1cl7mDF7YPWrbRvOHpyYilWW4evnbSnFxP2OekYnSlgwbhvGCfek0qd0EFT5F0U+W//ZUcIF+7LyRQk24UHeceyG/SzDUnCTQSbDeQiw=
Received: from IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 07:27:13 +0000
Received: from IA1PR10MB6075.namprd10.prod.outlook.com
 ([fe80::565:8dcf:2d10:bedf]) by IA1PR10MB6075.namprd10.prod.outlook.com
 ([fe80::565:8dcf:2d10:bedf%6]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 07:27:13 +0000
Message-ID: <ae4a109f-e533-4a9c-863e-7286508f489b@oracle.com>
Date: Fri, 8 Aug 2025 12:57:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] btrfs-progs: add error handling for
 device_get_partition_size_fd_stat()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1754455239.git.wqu@suse.com>
 <529ae91e63a07645b0d9f2d769c785de92e1fc23.1754455239.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <529ae91e63a07645b0d9f2d769c785de92e1fc23.1754455239.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::13) To IA1PR10MB6075.namprd10.prod.outlook.com
 (2603:10b6:208:3ad::18)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6075:EE_|SA2PR10MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: 9317f579-fe99-4787-2064-08ddd64cfe99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmM2MUovcFVQMkdvMDYzL2dxcWM0TnlGdWlsOS9iR1E5Yy9PTjJvNUFJTXJG?=
 =?utf-8?B?YWlBRjRCaVRVbzNMZk9jakdlT1hJSTFaMlJmNUhaeU94MFlhMFVTWTAxeTVF?=
 =?utf-8?B?bzBGL3BpellROEF3eGM0cEdkS1VNbS9oUDdBMTVYVitTTmFJUzc0UnlCMmtM?=
 =?utf-8?B?NXhHWFFBcWRKclhPbFgyRm5pSmgyL1JLNlRuT1FBRHAzRWNwWXFmZ1orcFA0?=
 =?utf-8?B?d3B1cHpHNmhQODlyNytzdklMaVhqZExQOGVqS2p5N0FlM09vc2M2bDc3a1RE?=
 =?utf-8?B?VWlYMGU5N3BuTTQxYVJWUWdVZVVOZXczcDB6YmhSWUprWHNNemplQ2NtNFA5?=
 =?utf-8?B?VmZtV1JHMEM0Zk5HM1EvY0lCU3h6WFJLNXBWSFBZbTVneXN1NUY5WFg1Rjdl?=
 =?utf-8?B?TmV3ZnE3ckhnY0FLajZMZmh6N3hXRjgxTTdZMzFOdWZrYWw1Ui85eU1ORWpP?=
 =?utf-8?B?bU1Ca2Q3aEpuVzB6VzBPaTFZTk5laWRrR1IwbDhYeHBUWEVlUzFDREU1cHVL?=
 =?utf-8?B?NFRtc1d6WFdRcjE1ZFlCR2Z2Qms2TXFpUmdrZXNYRVZDSUpTUzd5WU4rMlZQ?=
 =?utf-8?B?UExya0tFTHFLL2RNaXk4bENzYkgxMWxzOU1HbFFZRlZsRGhOa21sNVRXVTZx?=
 =?utf-8?B?dVFiZ2FBc2h2Q09BM040aTlnMzBNS2gxaHhwWjh2QnFUU2xYSjZvclZSY013?=
 =?utf-8?B?RGszQmpIb3ZoV3hnS2RPOHlKYjNjYXBvR1R4Y2RQdFBtRmNNemhIUUZGZW02?=
 =?utf-8?B?aGtGakwzWWhlcmdnQ01UV3JRcE9NaDNYb3dic2dBMVV2L2dOeFU1SFF6dGRq?=
 =?utf-8?B?ZUptMUNHNGcvWXphR0c3ZjFJUk5qcnl5bDFGZXFxZy9ZZFVpNzJtVU8xQzJz?=
 =?utf-8?B?RnZHc0FtcE02N0pGRW8xQ1VxYU8vZW9KNSt5UE9mMFUraFY0bFRnVUpnY2lG?=
 =?utf-8?B?dkY2NDc5ekErWnlnbVYzMmdpZVFNMjVSVTczNUo4NmYxWjF3eWNObHNiSVlx?=
 =?utf-8?B?czdxc2FnbEdYK0xiZ2M1bHFza0dzK1M0ZnhRWGNSWjBBZ3JrdW1qblpGQjVy?=
 =?utf-8?B?WnBRMG95SVErcEZjTXQ0TUlQblNRUlNTVzkwamNmVVBNbnBoNmNDR3FteWE3?=
 =?utf-8?B?aXhUYU1xaXJ4VHJOM2U2TWphbFlxR0daRHVFU2xkUlpGd3BDeUEwMGsvREdB?=
 =?utf-8?B?R1ZxNmFRMHU1eE91aEU2UThqK2dKeW04R1NUZFZXMjlVYzc5ZDZWRjVrd0Vw?=
 =?utf-8?B?MkFIWWwxZTl0Yy8yZHBiNHZxQWJ5TXg3YXpncUVEWHp1d09JcDdaWW0xd3FV?=
 =?utf-8?B?czZkaXljWkQ5RURJRDlQbFVpQkN2N2MwTnRFMEdWZHhIZyt6T25QWWRPWGFj?=
 =?utf-8?B?Rm9IVHRHb0RENDVvdENuMzRmOC8ydTVRSG1ZWGdYMVpsZUt5a1pXRU9WaENS?=
 =?utf-8?B?SXFSWmVZR09ueDYvQ1BnSFdRektadWdNM2RXeUsvb213S25GS2xJNC9JZ1ND?=
 =?utf-8?B?QnlReTUzQTNSQ21vUUJDNXd6bFRjWk1PWlRqNk9ZYkxCTUU1L2Fnc1hyNHpo?=
 =?utf-8?B?U0tLaFdSWE84ZTlxOGdvZVhNTFV3cXJIRWhnSHFpSUdVVFFXYnVTQkZKYURi?=
 =?utf-8?B?Y2grMERncUFocVFtNXFTQmtuYlFuU2hiVmtXMGp4dnVoKzlsZ2crSjRONXdV?=
 =?utf-8?B?QTJwSFZaM3dLNEZhS0cybEVDZyszc2Y5REZlem5JS1lFM1loTXpYRUxnc0Qw?=
 =?utf-8?B?M3VOLy9vRWVTNGhZS2crUFBUcTc2UjhsMHBLWGUxaWxBMkFiOThXMFhCUlFa?=
 =?utf-8?B?RE80R3grV2FkVGpEWGtiNTRGeEowMGd4TlM5V1JDM09TNVNIcEJvb1VPNUlu?=
 =?utf-8?B?T1JsZnI3aE1qVGIwYWJnWTV6Z0pGYWVOYkZaN1M5N1FaTmhJSnAvaFVNb25E?=
 =?utf-8?Q?eQFfBwnJboM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6075.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2NNcndVOFRmcUlwcyt4SExNc2dUVW54T2JySDZOcEJjWTA4UEZVM1VKZER3?=
 =?utf-8?B?MGg2MEJSZURzT25EOU9xelRZM255d3F5eUViSWlCL1pZZ3MxMEZ6UmhZYVB0?=
 =?utf-8?B?eEpXM2pKVWNicHVZY0pNV2FDWnkwTzRYV0V4MmY5QWEvdENsVlJCZGtLclJy?=
 =?utf-8?B?VkovY0UvN0wwZ0xYT1RpTWdlM1pDVm9Sdnd2U2tGSVMxRVI1QnNRWUhBR3lT?=
 =?utf-8?B?WFpkbStJblNVTlI4SXNWcEg2OXRLaTZIY0dZbUNKZTJqK2tCY2Y4ZlRDcWZi?=
 =?utf-8?B?SHJXbnpUQkNSem4yUm5vUTFodGp3a2pqSTdCNVpOYk83K0thQTloZ0NhREpF?=
 =?utf-8?B?bG9qWlZSRWIzNGpLekFaZWZvMXpxL2ZaVUJIdm1GWGo2UnFvOFRoWGkvLzI0?=
 =?utf-8?B?RGVHNmZBT3p1QXJYVnpoajRtRFlLcTlYU3RIUGlTTk1DZjJzN3JXbEQrclpq?=
 =?utf-8?B?cTZPbVRtZ01SNU5iR2U0cCtmVnZ0SFc5aFZ4MGdaVHVxQVVEaGVvQVNPMEF5?=
 =?utf-8?B?b056RVhIYzFWaXphRzRjVGhzZmxsMDFLRFhSK0NwRjlUMGRUMnhFT1FFcFRE?=
 =?utf-8?B?UjI5amtHcmxuRHdmKzloVm9wUEVwcUdRbTRLVTgrV3BmdFFJY2lERzYwWm9h?=
 =?utf-8?B?Y0REOGIwRGFyaHE4dkRKNis5SkRKVzRoUHQ2dVlVNDZ3WXl3dVBxaFQ4aHhI?=
 =?utf-8?B?dHhvSklJSEE5WTRBck1EMVpzc21iOHVDYy9Sc3F6bS8yRGRqUVNpbnBMbzBL?=
 =?utf-8?B?czNkV2paR3dmdXhMS2xDMG5PUXhWMktKMUZyTEpjZllTN3l4RHMreTFIa1Zq?=
 =?utf-8?B?USt5SVlUUEtFTEJ6cTY0T2lFaUM4VFd0MEFZbHVWL3dZZDVDNEJqVkEvUURG?=
 =?utf-8?B?eUZFRDBFM1BSS2pyVWxUbWJST2wxUGYxeW5SSVpWeG96YU1oU3hia1ZPanND?=
 =?utf-8?B?Tm02R1ludW1KdXVjQXk4RG1rRVJuY3RvUE9yT2VEV0h3b1BPL2IwRFRvQTcx?=
 =?utf-8?B?WVVWRXo1Q1Zuc3gyRWowcngvQzFQUkl2UVBGRkxSQ2VwL1BZNzRGUDNwcDJ6?=
 =?utf-8?B?MWdqcGdXSXlpTWlsbHpFcDFXdDhEbEJsQWtlbGNmQTdwSzBPR1JJck1oVUlW?=
 =?utf-8?B?aWdRT1NUeDRsSm9qeWZFRFFSd3NnVjZkWGFmRmFkbmd5b2Z5ZHp2VzdwSmcz?=
 =?utf-8?B?c3RLUjRWQTVEbzYwL0x3UER4UjVBaUhGZ2hvUkNRM3loVEhKS2tFT3M5aWpW?=
 =?utf-8?B?NGc2WW11cDFEK2NsbGFjQy9Fbm03NGI3R00zUlVBa0dXZ09QTDhidmxiWDhL?=
 =?utf-8?B?TmkxeVlMOS90R0doVFhTeXlLTmxrbitYODRtL0MvV1hrU3NzUTVsTXIzY2NZ?=
 =?utf-8?B?Q29RUnUvb0FZT2xxVnhuREozTk5wN2wzazUzUHA2K0dBNWlxdlJYTnhHREt0?=
 =?utf-8?B?cmF1MWdITkRXbUUxQk9jK2llam4rTFVYYW9DV0QrUWl5NEswd3kwVm5QVG5P?=
 =?utf-8?B?RFFRQkc2dmVBVlgvWGhmNXljZjhQdGRtSzJLSTFocFBlRVlOUk9zcG9Md1c5?=
 =?utf-8?B?ZEg0YlNvN0xhYzNweEVFemJvemNoWEw3ZUdwUHY2WW1LRnBmdHJDaUFybVZT?=
 =?utf-8?B?UXVZVnQxNW5oRUZDK2NUR2ZCbVlvTjYxenB3Nm1kOWE2U0FJVnJtbG93QUZ5?=
 =?utf-8?B?NmtoeTM3OGxTMHJPdGN6NEE3WlV1U20yWDdGWEYwZmQvaEhWK0xNZGkzckFq?=
 =?utf-8?B?SSs1TmVRZGVEbDdRSC9tMHFjS0ZKM1VvaXVZbGkzWFZJZ1dqSWRPUm1pSi9Z?=
 =?utf-8?B?U0V4ZUJRcHZ1OWdRNzBrajhaMHpjNWtGbHM0MTIwMHpmZGJMYTBkWSt6ZENE?=
 =?utf-8?B?UXRUa2lqNHZxMjRSZ0pYMitTWVJxd2ZJTkZQaHVVZzlQbjUvajkwRkpkamMw?=
 =?utf-8?B?Qm5HWEpLamFjWHpsbHM0SEVCK2pveDRMdGxnaXN2aDJqelN0ZE9PTW54VmxN?=
 =?utf-8?B?S1VYRHlPalNJNHNDYm0xOHJ6VTNjMFBDdmFLeDdKYUM4dUFOYk5CbXdMQXA1?=
 =?utf-8?B?NEx5SG9VMllsTnBQUGRmeEdLRnpmRENvd3VGQnNJRVhHdlE4VSsvUWRlRXor?=
 =?utf-8?B?dVlkWnZoeW1qNHBhU3VMaTZ4K0NXajNNTldyQWRtKzRqMzNjRjVZdWdvSWhs?=
 =?utf-8?Q?zkBw4LoFM4NvzYtwilR8gf+k/jLAOdQUZBz8yLOmGm6h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pHpKkEWH5+SLITCkyQtiwR1CmrbpnGAVXEXXX8LW49P3CtbOtuzswJvmJBXD8YY6jFR7tW5/mATuU3hK3joRN26eQVNRBFtesJ1HJ3Wq1CBm+2pI+SboXz2tIjAeFKglXwy6omOYK3Za7AazHI03GyKsGWd/F8U3avD4fAwOd76MYUpbgfh5wIVrjkDGc/42DFweQLtXlxTal4eeXS4MozIPZFWV0gpqU2TYSxo+kopLuyix01/JuKm59sRgc4sl7+/4C6Dc+30aLwVsjzEhVxaa5IFhATpuNxnNr5gdiZJ2VF7E5U2wY7K7k9TL05hpnWi9E3/oBBIiqWRDEHNyk2HUeQSGYvqN1OW7Ig7GkgXWSCw9PzveiOBnzLcPFXltZiMDDWT0x+4IYhXALztQMhv+i7J3appzX0vz7gJi97Wrf1V3oLbvcxT5Wl8341wdJFEki1aZaNYv4qcMfEMUIgSE8XcI5D3Gtnm9pZp297WyqACBPhutGR1qh2doIaEituMkLqoFX0Zgbg6nvBVUpWfde76DCK/i0+G7RxS+TcWU/oQXedyr4o8b5ytk4JNNripdPnYzKielre5OPzPkZrISxoqiFyRfkZU0lPTkN/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9317f579-fe99-4787-2064-08ddd64cfe99
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6075.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:27:13.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMy5zc1cuod8kYmf+EzcLZEPLVwOGMk8Zz7MN6V63FOVBHMWmhboMYHK3CcA6UNKBjcjGFj0GLYpWxZWPfSx2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080060
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=6895a6d5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=Djns9Asslk8m5wIFYC8A:9
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: wDbWBOJ_9G2LIfvNd0KC46ayZ3iG1vZa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA2MCBTYWx0ZWRfX2e8/lFwzsTye
 AorXop4ocGJCrlMuZwGno6nZWmFY27wLB/sZ5X2FjqK3dyHxkUFQ02D2md3OPvjtaBoY4XSRrnq
 8ieileogB5VrdbBjlJCskRE9LYUCN1QWTDk4CsXPOoXdrMBuoLrtelnA4XuRSjS6gFNKX4NwLr3
 QCfpUblOQRfM2qWxBv6wqmUB8C2pIEnc4HGMcE9mN9l/AaOdoWiS/oNktPYV2sxzgqCyxI79eJW
 9loV4VK8ar8vQDvs6fWGPaMfDWtSxG67VA9ZxzrR+6WkpxLsm8JP3OkvmFb8uoV3vlgpNhzu+Oe
 4/MhDc1KI1R5coItuLgn6yobY978O5KrksSnZyh5IiWWOsWmUHtivTT59QmNgX2lf6GVftEIK5m
 hTRHn0PIwGVvlQMywupCE9lVYSWzqAHga/IUq9w0C5Oo76EFvBaHRw8W7O63WddNq9VDh0lN
X-Proofpoint-GUID: wDbWBOJ_9G2LIfvNd0KC46ayZ3iG1vZa

On 6/8/25 12:48, Qu Wenruo wrote:
> The function device_get_partition_size_fd_state() has two different
> error paths:
> 
> - The target file is not a regular nor block file
>    This should be the common one.
> 
> - ioctl failed
>    This should be very rare.
> 
> But it has no way to return error other than returning 0.
> This is not helpful for end users to know what's going wrong.
> 


> Change that function to return s64, and since block device size should
> be no larger than LLONG_MAX, it's safe to use the minus range to
> indicate errors.

As commented in the patch 5/6 also, signed64 as return is avoided in 
btrfs-progs.

Thanks, Anand


> And since we're here, also enhance the error handling of the callers to
> do an explicit error message.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   check/main.c            |  8 +++++++-
>   check/mode-lowmem.c     |  9 ++++++++-
>   common/device-utils.c   | 27 ++++++++++++++++-----------
>   common/device-utils.h   |  2 +-
>   kernel-shared/volumes.c | 11 ++++++++---
>   kernel-shared/zoned.c   | 18 +++++++++++++-----
>   mkfs/common.c           | 10 ++++++----
>   mkfs/main.c             | 14 ++++++++++----
>   8 files changed, 69 insertions(+), 30 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 84b6de597072..f0ca78bb2e19 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5438,7 +5438,7 @@ static int process_device_item(struct rb_root *dev_cache,
>   	device = btrfs_find_device_by_devid(gfs_info->fs_devices, rec->devid, 0);
>   	if (device && device->fd >= 0) {
>   		struct stat st;
> -		u64 block_dev_size;
> +		s64 block_dev_size;
>   
>   		ret = fstat(device->fd, &st);
>   		if (ret < 0) {
> @@ -5448,6 +5448,12 @@ static int process_device_item(struct rb_root *dev_cache,
>   			goto skip;
>   		}
>   		block_dev_size = device_get_partition_size_fd_stat(device->fd, &st);
> +		if (block_dev_size < 0) {
> +			errno = -block_dev_size;
> +			warning("failed to get device size for %s, skipping size check: %m",
> +				device->name);
> +			goto skip;
> +		}
>   		if (block_dev_size < rec->total_byte) {
>   			error(
>   "block device size is smaller than total_bytes in device item, has %llu expect >= %llu",
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index e05bb0da1709..8d1b4c3f3f2d 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -4716,7 +4716,7 @@ static int check_dev_item(struct extent_buffer *eb, int slot,
>   	struct btrfs_dev_extent *ptr;
>   	struct btrfs_device *dev;
>   	struct stat st;
> -	u64 block_dev_size;
> +	s64 block_dev_size;
>   	u64 total_bytes;
>   	u64 dev_id;
>   	u64 used;
> @@ -4823,6 +4823,13 @@ next:
>   		return 0;
>   	}
>   	block_dev_size = device_get_partition_size_fd_stat(dev->fd, &st);
> +	if (block_dev_size < 0) {
> +		errno = -block_dev_size;
> +		warning(
> +	"failed to get device size for %s, skipping its block device size check: %m",
> +			dev->name);
> +		return 0;
> +	}
>   	if (block_dev_size < total_bytes) {
>   		error(
>   "block device size is smaller than total_bytes in device item, has %llu expect >= %llu",
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 8b545d171b18..b4daf7605fff 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -226,7 +226,7 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
>   			 u64 max_byte_count, unsigned opflags)
>   {
>   	struct btrfs_zoned_device_info *zinfo = NULL;
> -	u64 byte_count;
> +	s64 byte_count;
>   	struct stat st;
>   	int i, ret;
>   
> @@ -237,12 +237,13 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
>   	}
>   
>   	byte_count = device_get_partition_size_fd_stat(fd, &st);
> -	if (byte_count == 0) {
> -		error("unable to determine size of %s", file);
> +	if (byte_count < 0) {
> +		errno = -byte_count;
> +		error("unable to determine size of %s: %m", file);
>   		return 1;
>   	}
>   	if (max_byte_count)
> -		byte_count = min(byte_count, max_byte_count);
> +		byte_count = min_t(u64, byte_count, max_byte_count);
>   
>   	if (opflags & PREP_DEVICE_ZONED) {
>   		ret = btrfs_get_zone_info(fd, file, &zinfo);
> @@ -315,18 +316,22 @@ err:
>   	return 1;
>   }
>   
> -u64 device_get_partition_size_fd_stat(int fd, const struct stat *st)
> +s64 device_get_partition_size_fd_stat(int fd, const struct stat *st)
>   {
>   	u64 size;
>   
> -	if (S_ISREG(st->st_mode))
> +	if (S_ISREG(st->st_mode)) {
> +		if (st->st_size > LLONG_MAX)
> +			return -ERANGE;
>   		return st->st_size;
> +	}
>   	if (!S_ISBLK(st->st_mode))
> -		return 0;
> -	if (ioctl(fd, BLKGETSIZE64, &size) >= 0)
> -		return size;
> -
> -	return 0;
> +		return -EINVAL;
> +	if (ioctl(fd, BLKGETSIZE64, &size) < 0)
> +		return -errno;
> +	if (size > LLONG_MAX)
> +		return -ERANGE;
> +	return size;
>   }
>   
>   static s64 device_get_partition_size_sysfs(const char *dev)
> diff --git a/common/device-utils.h b/common/device-utils.h
> index 2ada057adcd3..666dc3196e2f 100644
> --- a/common/device-utils.h
> +++ b/common/device-utils.h
> @@ -43,7 +43,7 @@ enum {
>   int device_discard_blocks(int fd, u64 start, u64 len);
>   int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
>   s64 device_get_partition_size(const char *dev);
> -u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
> +s64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
>   int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
>   u64 device_get_zone_unusable(int fd, u64 flags);
>   u64 device_get_zone_size(int fd, const char *name);
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index be01bdb4d3f6..fccff07ba761 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -3081,7 +3081,7 @@ static int btrfs_fix_block_device_size(struct btrfs_fs_info *fs_info,
>   				       struct btrfs_device *device)
>   {
>   	struct stat st;
> -	u64 block_dev_size;
> +	s64 block_dev_size;
>   	int ret;
>   
>   	if (device->fd < 0 || !device->writeable) {
> @@ -3096,8 +3096,13 @@ static int btrfs_fix_block_device_size(struct btrfs_fs_info *fs_info,
>   		return -errno;
>   	}
>   
> -	block_dev_size = round_down(device_get_partition_size_fd_stat(device->fd, &st),
> -				    fs_info->sectorsize);
> +	block_dev_size = device_get_partition_size_fd_stat(device->fd, &st);
> +	if (block_dev_size < 0) {
> +		errno = -block_dev_size;
> +		error("failed to get device size for %s: %m", device->name);
> +		return -errno;
> +	}
> +	block_dev_size = round_down(block_dev_size, fs_info->sectorsize);
>   
>   	/*
>   	 * Total_bytes in device item is no larger than the device block size,
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index d96311af70b2..1036dbd153ad 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -166,7 +166,8 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
>   {
>   	const sector_t zone_sectors = emulated_zone_size >> SECTOR_SHIFT;
>   	struct stat st;
> -	sector_t bdev_size;
> +	s64 bdev_size;
> +	sector_t bdev_nr_sectors;
>   	unsigned int i;
>   	int ret;
>   
> @@ -176,7 +177,13 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
>   		return -EIO;
>   	}
>   
> -	bdev_size = device_get_partition_size_fd_stat(fd, &st) >> SECTOR_SHIFT;
> +	bdev_size = device_get_partition_size_fd_stat(fd, &st);
> +	if (bdev_size < 0) {
> +		errno = -bdev_size;
> +		error("failed to get device size for %s: %m", file);
> +		return bdev_size;
> +	}
> +	bdev_nr_sectors = bdev_size >> SECTOR_SHIFT;
>   
>   	pos >>= SECTOR_SHIFT;
>   	for (i = 0; i < nr_zones; i++) {
> @@ -187,7 +194,7 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
>   		zones[i].type = BLK_ZONE_TYPE_CONVENTIONAL;
>   		zones[i].cond = BLK_ZONE_COND_NOT_WP;
>   
> -		if (zones[i].wp >= bdev_size) {
> +		if (zones[i].wp >= bdev_nr_sectors) {
>   			i++;
>   			break;
>   		}
> @@ -289,7 +296,7 @@ int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
>   static int report_zones(int fd, const char *file,
>   			struct btrfs_zoned_device_info *zinfo)
>   {
> -	u64 device_size;
> +	s64 device_size;
>   	u64 zone_bytes = zone_size(file);
>   	size_t rep_size;
>   	u64 sector = 0;
> @@ -326,7 +333,8 @@ static int report_zones(int fd, const char *file,
>   	}
>   
>   	device_size = device_get_partition_size_fd_stat(fd, &st);
> -	if (device_size == 0) {
> +	if (device_size < 0) {
> +		errno = -device_size;
>   		error("zoned: failed to read size of %s: %m", file);
>   		exit(1);
>   	}
> diff --git a/mkfs/common.c b/mkfs/common.c
> index c5f73de81194..12a9a0bd8176 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -1171,6 +1171,7 @@ int test_minimum_size(const char *file, u64 min_dev_size)
>   {
>   	int fd;
>   	struct stat statbuf;
> +	s64 size;
>   
>   	fd = open(file, O_RDONLY);
>   	if (fd < 0)
> @@ -1179,11 +1180,12 @@ int test_minimum_size(const char *file, u64 min_dev_size)
>   		close(fd);
>   		return -errno;
>   	}
> -	if (device_get_partition_size_fd_stat(fd, &statbuf) < min_dev_size) {
> -		close(fd);
> -		return 1;
> -	}
> +	size = device_get_partition_size_fd_stat(fd, &statbuf);
>   	close(fd);
> +	if (size < 0)
> +		return size;
> +	if (size < min_dev_size)
> +		return 1;
>   	return 0;
>   }
>   
> diff --git a/mkfs/main.c b/mkfs/main.c
> index c3529044a836..166a4fc0fd32 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1254,7 +1254,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	bool metadata_profile_set = false;
>   	u64 data_profile = 0;
>   	bool data_profile_set = false;
> -	u64 byte_count = 0;
> +	s64 byte_count = 0;
>   	u64 dev_byte_count = 0;
>   	bool mixed = false;
>   	char *label = NULL;
> @@ -1818,9 +1818,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		 * Block_count not specified, use file/device size first.
>   		 * Or we will always use source_dir_size calculated for mkfs.
>   		 */
> -		if (!byte_count)
> -			byte_count = round_down(device_get_partition_size_fd_stat(fd, &statbuf),
> -						sectorsize);
> +		if (!byte_count) {
> +			byte_count = device_get_partition_size_fd_stat(fd, &statbuf);
> +			if (byte_count < 0) {
> +				errno = -byte_count;
> +				error("failed to get device size for %s: %m", file);
> +				goto error;
> +			}
> +			byte_count = round_down(byte_count, sectorsize);
> +		}
>   		source_dir_size = btrfs_mkfs_size_dir(source_dir, sectorsize,
>   				min_dev_size, metadata_profile, data_profile);
>   		UASSERT(IS_ALIGNED(source_dir_size, sectorsize));


