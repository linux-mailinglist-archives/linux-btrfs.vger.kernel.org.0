Return-Path: <linux-btrfs+bounces-15877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1040B1BF4C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 05:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B0A7A8927
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 03:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1E1DB54C;
	Wed,  6 Aug 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O4HadDPC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tY/VtiB0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D618D3595C
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451001; cv=fail; b=mUcX7PV1bwIjKBrPPJfBynBBCxf63zLRE1niFM1v8uTrdpjHhfORd/ad0ek2nMShV2F8BJrtmAEaF8KTUeerjxW/76xk5bB0HBlFp0NiXHfvMcpWfB9tD0MboYiqg81Wvz677N+cCh5kDlRvMHL/AAS96hso/dV7whUWNSTCaqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451001; c=relaxed/simple;
	bh=aldSTDm6ocB5SvPc4Lllw9rzxRu7koNThlG+x+5+kgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D5fh0ou2vNizFsxlACU1N3+R7EsqJzUJ6weBdVbcWOOOyN150efnjNcr371f5U0mddFrxMIiKY4q2efAZnUmC2kma2+ZhcTZBqna6ZPYEjcdHPHRrTrn6wbRtoDbR+l2HGGnsf6qOjwHgLmG+h1DeNaHaZ9eDndj2UNo6dr8Q8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O4HadDPC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tY/VtiB0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761v6iq028167;
	Wed, 6 Aug 2025 03:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+BIbdNcrSwQPnIIdv6o8yFHzuADPVOL8PHIyS1OYVIs=; b=
	O4HadDPC0esOZRaUohEVU7PeG7LKtYfRKHHyPshim1QWBngLck4YTwGYXhZPNNJR
	VT9pj2s3pg24yDJ4nrFE6XZt++otaLJRcqa7UAQtP/uga2RRvL6wbn3XVOjvFGmM
	Fft4aJLKVr0er87NXFs70LXv3nMAtH1ZXZQtB/al2Ycwh1f6KL950lTFPhQpmyxZ
	aEhYydkkutE9bepJrwpFyC9ptNjooiZiMoeYWrAB4EtaO2efkjirqi+xWnJbY+RX
	x3vMRUxd2Na7GWNa/2f5wR/DjccRkJvDIC27AYIfXGASrjGSS4IPsqXsgQAG2lCJ
	HC8EFgTCQzwRhQ0znJlmIA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd0nwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 03:29:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5761rPUZ005733;
	Wed, 6 Aug 2025 03:29:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwwf2np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 03:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP0kw7Vjcx4FY5/7O4AgeEj7N5fitbgoIh3lGgdSXr9uzZ1Mula0IiBEYabXAvU8vyZWV6fdlPb4J0anxBws7VtSBRndlgE3b1CsFzmsFa4CC9KLrphfBK4Ym55PiEE99TtCDb0LGp21lEcg1VoIjnKeADW7ra5gVDFo3Hv9WhOZTGp7Vz1nMa6iDNYxGnXPDThPHXFhSYOYCw0oK7l0IKvF6uQQH5T5oF+QrbboaXdcwNVj63WUnb5LYInqsaZTPRmdG0w9rOdV/l1NO2YJldh5xT3ASdorSp5nj72Vz842SOtLSRjSx+raqGAA8FzATkeSzoXdzi6M2skpIRs6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BIbdNcrSwQPnIIdv6o8yFHzuADPVOL8PHIyS1OYVIs=;
 b=AQOesX1Xg6xFAja5EE93zRlPTlxGww3Jucd8VQUJqu+ysZa/9AroGCM9JDv84gHfrmRlhZQdXxy0opQWSBB2oViQMfWnWJpTCJe1vpBtEa8A7xwkDCEnHB7OdruDZY306JmFOa597QGCpGaFocmDgzqBzO3kJbKr5MZUcdOOxxgmCXfjf7yjd3lZxWoJbZbNrUPm4uKeyruONn+wBgUVtbboRdELffy8d6DKlgzQPmJCdFcdBiEl53fqNQtKulurWTUVwsiQEdm5WJzDqOz2c31CRFfFeq5KoFMo7Oh16+q0DiFV9KoVTapRtERxR6zQYUsKrImJxjV7sQ5Jm+h0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BIbdNcrSwQPnIIdv6o8yFHzuADPVOL8PHIyS1OYVIs=;
 b=tY/VtiB0eUQH9rOLSdqtUQancltOXrKQSzS2DJDGNzDrmtorgz221uNqaYldHRkk+bjfEieGom+Db/pMEps712pFQt5TvR1dBgCeCXgKPSMXra73nBTIP8tctfotavGeF8gnc0uTPGIKVLZ9IKl4jzU9JeeHFkoZoOOcKgRz7QU=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DS0PR10MB7201.namprd10.prod.outlook.com (2603:10b6:8:f2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Wed, 6 Aug 2025 03:29:52 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 03:29:52 +0000
Message-ID: <3d4c7d42-5341-43a6-a820-f1ced958c7c6@oracle.com>
Date: Wed, 6 Aug 2025 11:29:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: check discard_max_bytes in
 discard_supported()
Content-Language: en-GB
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
 <20250805180401.GA4088788@zen.localdomain>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250805180401.GA4088788@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::14) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DS0PR10MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c4fdc6-389c-4d39-4953-08ddd499817f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ellLbXFPb2tZWGRsUWNKVVh1Um93VUVtMFU2MzhqZlByamkvOWNTMUdERGNm?=
 =?utf-8?B?R0FOVmRmMzRJamc0NnlXT3ZnUkVIYmdEcWtJVHpEVCsreVVmWXVsNjBiQUIw?=
 =?utf-8?B?NEMyVnhaWUhaVmk2MUd2VWlIWGk3VTFia1M3SzJpQ0hiQmpUMmdzN3N2MWoy?=
 =?utf-8?B?R3VZcjBNS2QxR2ZIOVNWRmFxUDZPNFFGMEZGZWFLdVdibjJTRHFqU0tsRnNp?=
 =?utf-8?B?U1VBQ1BjKzdieTJra0NGb3hOWGh5dXdXV2RhTG02ZFc2R2tLd1QrWDIzZ1lO?=
 =?utf-8?B?T0dGU3AxNlJtcWYra25sTE1LZG8xVnpQMnF1dzFCNUdQaWJaNGY0ZGF0VVFG?=
 =?utf-8?B?MGdCTU1EUFMvektKYWgzaGZ4NFhJdEJHcFcrSzM2WWFoQ2pPalpCYzRJd0NZ?=
 =?utf-8?B?SElidnkrZlN4QVVjZEd3TGo2ZEpqYktTSjVpUnY0bFh3bXN6bThoeE4yZFEr?=
 =?utf-8?B?aXlZNGFUWWtmRi8yN0RZb3lyNFg4VzdsMTY2Ykx6L0JsMEwvdko1aFJMS1k0?=
 =?utf-8?B?NENxMVdLVzY2c1BPREQ5N3p1ZUxvamplbUpZV2hiSXBoVUxBVStrMHAvN2RS?=
 =?utf-8?B?dlZiZ1lYUU1qQTc0N0tpRFdBUGU1VUlsblVWOGUvODUxSjh4dnNrWGJmelpJ?=
 =?utf-8?B?RE9Cdy9vZ3dCYVA5LytGcXRFMkdWWE00Ym9qTmtSK1dwSTlzTTZhbUtSbGhC?=
 =?utf-8?B?SVZ4OU8rS3RFM3BBOUdkN3YrLzg1L25UZERhS2RXUXN4aXp5RDdrc3lEMlhW?=
 =?utf-8?B?R2laYjAxS0daMllZblAyTHc2QnpRUGhwZ2xHd3ozKzZqbk9kZFdidVlQbEI2?=
 =?utf-8?B?cFY3YXJSMHk0ZUZ2eS9VSndKSk5zS2lnNk4ybWFKaHdRV0JFaFpxOWY1VUpG?=
 =?utf-8?B?NGN5ZDhFdDRINkZqektmTXNnSUMxcmpNVXpuTkhnRkVmM2ZoSVJYTXdxTjhO?=
 =?utf-8?B?VklRdkN4NGR0cmduQlU5T1dWYXoyTzc3UzFMNU5iUDdQbFRnVDBaYUxRbW9a?=
 =?utf-8?B?MFp0T1V6V2dVREs0RHMrZEJ5UURDSlNEeTRKRE5kb2F6dXJXaFoxK0lUZkZE?=
 =?utf-8?B?VVExQkcrcVBJVWxtZGxUMENzY2hPc3RNOGJnZEVkek5BV1NPZlZjeGtpaFlQ?=
 =?utf-8?B?YlhVQ2daZ2p6TkpwWGdySWtuNmNEN3UvOU9XSjMwd1h2L2hoY2gwNTZEeURL?=
 =?utf-8?B?dHBJZ084RkxlaW03WHowbHJrV0EwR3RnVVI1Vm5nUU1RSXRlNTFZbi9QeFZJ?=
 =?utf-8?B?a204TDk2UmRFZDA0czQ0SkxjVGpwTWNVN29zamJCY1pmUWcxcEJYYy9ZTU1R?=
 =?utf-8?B?SEFYVnNKSENYL3hwYzJ0V0toY0g5R1FyTFB0TGx2cDFxU0JBRjJtY0VVdHlG?=
 =?utf-8?B?SWg1MHdxeDErZmk3U1lxc05YWVYyZ0lYMGU2NTUyQmd3N1BkdDViQ21keW51?=
 =?utf-8?B?cG9pNXJzNHA1SkljMFdIQm1LZGZydEN5Zi9nNXJUZGt5b3VhYStsWmJTZUZQ?=
 =?utf-8?B?aUpFdGE5bnZoQW15aFp6VDlqV0UyUmN2ajhULytyWjRubjZtNW8wOVFTQUNB?=
 =?utf-8?B?M3duOXFTVlFIR25WQll0djBLeHEvUTJmcUpLN01YdktETzJsQ0lmaXVTcjlZ?=
 =?utf-8?B?MFRkOG1BblBLWVhzaDNqa0V4dFp6cnozN2JZd3ZDdW83ZG5BMmp1N3R0dFBG?=
 =?utf-8?B?cS8raFoxTEw5b2l1bFFoWTVTSlVVWi9DamhoamU1bXdUKzl1REtISm9YRkpV?=
 =?utf-8?B?ZnRmZ2Fjdkw0U3FWejZMTXJqNkIrYWhLcFdlR2xKU3BJbGtEb2FUQUdZU2p4?=
 =?utf-8?B?dVlUbVJ3M1lPOHhFWU9yZkNyZ0c4aWNsWnBhb2NpKzVad0ZvcTZ1MFpkcWQz?=
 =?utf-8?B?K1pTa2JFU2pjRkRjRWtLQ1NQRUIwWEtpL0FoUlZRU1FwRUNubU9xNmFYVFpQ?=
 =?utf-8?Q?/wP7CGo9NRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVR2QVpOMDI4YUQyNWxPSmo3NDdpazV3SVMrQW5TeHR5dXY5cW84c1lKdWtm?=
 =?utf-8?B?SVdmOWRBTnVEL1hqQ2tSZ0Z2endzTlgvN3JJcnZXS2hoTDB0S3RRaWNpSjZL?=
 =?utf-8?B?Wm15OWtTd2tLVDhLbmhJM29uODJST1pMY3R3U1gxUkhkS25YemJsdm1uR2dx?=
 =?utf-8?B?elB1aVVObU1lVVR1Rjg3OEQ3QzVxblcvdEx2NVdtT3RPY3FtQmZlWlBORFJa?=
 =?utf-8?B?bjlXb2p2Nm91Z04vWkh3L3FwZTZrcWtRRnhNK0Y2V0tNODJSY3pyNjJSTTZp?=
 =?utf-8?B?WExOQjg1bzYzeE55d0VqY1hLVG4vVGpWU1F0bGNBYlBuRVo1elRlam1UT1NE?=
 =?utf-8?B?MnRqSWdLUzdKNG91SlIrNHpmQUZYeE1aM0lJcDRpNXAzMmw1MXU2bjdnS2Zy?=
 =?utf-8?B?MnBaN2FGOHFOaE5mWURLMGg1bVAzcUd2RHhNSit2SVQ2SlgwdHpHcmtHN0Yv?=
 =?utf-8?B?T2Yrb1AyRGsydTRjeXpzNW5pVW9RWlFlNTB1S2FmSmJ6OXlQM2ZrNGxvVjIv?=
 =?utf-8?B?ZDJZdnFENGtWTTF6ZXpxN0RJSmpLTU5kcWxwTHZDUWc3cndWeEZtVGV1OXpB?=
 =?utf-8?B?NHRRZWJBanZVY3FPV25kaktYeVU5TFdBU3FXNDVja2MrR1hMcXFhQWU4dU5U?=
 =?utf-8?B?Y21XQVZycjBmaEh0d0c3VDNKcldTTm5NWW9kQjRNc05ISXQvYmdHRDgzTmto?=
 =?utf-8?B?dDJDMTU5NU44ODdpUldCQ2VJNHVwZnBSUjV1Mk9TaFJpTXdkeEFsdzBCeEdZ?=
 =?utf-8?B?TXRZN2lzd0p5TVFaOW9VSENHSkNuajZaVmpFUXZUejF5LzZ6ZFE3UERjaGFv?=
 =?utf-8?B?TFBJRm1oMm5ic3pvMk9lSEZHSmRYeUtpaW5vRWI2WVV4SStCaXA1QVljWm1r?=
 =?utf-8?B?UXV0RTJGSTlZazlDbVJ6eVZrODZKcU5iQmZlWUptQkxaOW1DUWtmbTh5U3hW?=
 =?utf-8?B?d2ZLaGlVbnhGS1dDSnY5a2haWDZBK2wvRUtJQk0yWktsUGxKOFVKWldTdmdr?=
 =?utf-8?B?T0dNMFIwaHRyNjZTUTkrRmFhSDViV25lSHVFVzFHTW5wTU43Q0ZPVVFtSDZm?=
 =?utf-8?B?bkhpZlhoL1FoZ3R6Yi9rVDFLTW5mQjF1dTNBRWUvYXVUQjFJZ2JCWFdwWEJU?=
 =?utf-8?B?RFdvQ1I1NWt0TGNEWjUyK2pYWmZTUEhDR0ZhSDYrdGo4MktLZ2NVaGhyKzJR?=
 =?utf-8?B?VVVnbVJVdzZlU2o0UHRRdVBVaVJNZVk3YnZSQ0pvWFlxV09maHlQR0FEaFN0?=
 =?utf-8?B?bEpYM3RPZ0UwVWU5Q001UWg1VDdYeWZCUWc0eEZHYUxXMW5RSklKMzBLODFM?=
 =?utf-8?B?enpDbGd5OEZpL3RRNmJid1RZRHJwRUdPOURuNnJuSUR3QWJlV3dyODI4ODBq?=
 =?utf-8?B?SE1MVWR4akpuSGRUaXlXVUNZTTZLRUsvY280cEJGbjJwNHVxRlcxRVdSQytF?=
 =?utf-8?B?NEFQUklKcllRWjVPdzR5b1RZNzl1dVJtVHZxMURYVTRxT3VUU1B4QW83TW5u?=
 =?utf-8?B?NXVkVHZEMWtkQmYzalpDN1hzbzVPTHNxa1ZLdU4zQmpYSUZ2WXBSSmdPdTZY?=
 =?utf-8?B?ckV3SElTOFBjOE02bVNHeEcrZ0QySkhiVDJmbTFwenpSSGRnMlQ1UnZ5cnJq?=
 =?utf-8?B?V1lPbVYrNlplSUc5U2FraUxnYURsMENsekN1M0lMRk05ZERjS29zY1ByODZ4?=
 =?utf-8?B?R3VFMlBEVFl3Wk1hMy9ZQm5maUZLcUdvbUc4czJQRGNXRTBxU0dRT3lKeS9T?=
 =?utf-8?B?dWFZaU5uaENQaCtveVlTazlucHRYQ01kTC81U1ljamRoanc4UEp5ZzVwMFVn?=
 =?utf-8?B?NW5WeGY0OGRJVy9VOWdZYUtQRXVNYzJCcWFrblhBK3ZiM3Z0cTJWYm8wdEJV?=
 =?utf-8?B?NVBKeVhNWjB4M1ZMWVkvNkp0ZDBCVGJ4ZHlqVVJCUFhyKzY3NXd1RlNUN1Ev?=
 =?utf-8?B?cW1mZXRiWlBNZ2dRcHh0UnBwNG5ZeVRKU2YySXQzQlhacUdyUWptUTBtQWdD?=
 =?utf-8?B?YVJxaHI0d1FYRXoxV0JOK0lrbFZoeFl4ang2cTJSUmRyWi80MzU4VVNibUJl?=
 =?utf-8?B?aGtzdVNYTDdES0c5alptalZ5bnlOWnRwMWVlUG1veW8rWkY5TVlXNVRqRlBQ?=
 =?utf-8?B?YkM4NnFiMXRoMXlCMk0wWWNYUitiYVppeFd1N3lrdVlZVWJUc0pWeThaZjFq?=
 =?utf-8?Q?BjwyWv024YHNYzyInZ36rl/imBZMO42ik7kKmV7wPqTQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nsMV0jCkgdWf0oiIsVU5izodS627tFZdh9lA/LkwggVTcs6eKHhhdF8DAWr7zJnYv1npb7g4msbnSk/XLhn9FcjewjjrLuD3NbcLY9reAC/RLSaTZETaZNMyHSMSFinAYSvFZNX2AOKBmG2J04ldBBjcIfQt6COdsnWXUNJJLFC9exfPSsaVwfUjO7Ie3FDtHMaDkvPvs8JNh5OXZj+aNIVHS8l//D+qD+iTcH6vwFb1BySB9kB+yyVOC3/91UNXz3c4iA8y3zhQ35lbQfrMnlCut+bR5IYK0GjUisisuibNBu5bpuDakIigtf9L54ZmJr4cSOideig7EOA+X+anK6toGsPare0YKU5v99O5LE/aMQrvWjh9ex+I+SPSwnVs6GWMZZMhO7u05tlYSS9X708l9WkRM76EGRIhpIuCn5U949HAVNsDWL0+//95WBG4oFOH2VzxYoHOKCqOS/PQ3tRqhExTyRM0sL1Wb71yIjTOZQZd9og3Xm5cQwH0Piro8PG55N1m9PAb4vyGMytUOxhJPqAL2VxJqA8HWvs9FURMLfjP9J3fPf7dM/p8jp8v23N6yILmpM9dx4FlxYgHVx/H32cmc5ecopBfD3R4g/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c4fdc6-389c-4d39-4953-08ddd499817f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:29:52.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBPHkvcpDPsmBz840HglMrjo4rRq1wKCW09QwUqwzK6q3oox4LIlSriOHTwbSL4BtABOJ9nOem4Sxa72OVVJtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060021
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=6892cc34 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=NFaghckrWKq3e7GOqhMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12065
X-Proofpoint-ORIG-GUID: 4w5iDjOnYtxzzRl49TO6fT_pHZdyQCVP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAyMSBTYWx0ZWRfX/b6SCL4by3Hb
 WnjGlzb0guokFCOGy62ucUKlIT41IB4VfpUR0golUWRWrdGwwORzBVojGAfcXo8B3vcGMac0CBJ
 u5toOaZfZNw00FejaMTcd8gmzylvhOUuP9CjPe845sOnSHIh/S3Jco7/dVTwQ4gV/ExrDAceW8x
 VV5JWH8CNnnnA3r+mL5S3xeDjKyvaHvzmp2UDsXb/HoLhX7vc4dEFp6sJ0ypmFcxSbp+KuxJJoS
 YWahZ1ydhQjFBKmnkBCNbuPrSpBsu8cewHSmy9KDfUdCICfOmW5fWxtYWOcSvJrbqi/p1369PtK
 Iem49FQc0iq5c34ytPk70swJCXVpmz4zqq/nVpblzhUPUXs/wkM31focsyDnuyp4F6uqFHOraSD
 ADC2lgBE/6UH/aMyzuSpi+PRYrmJr9Xouq9bNkzOOFZxbaYchDtUx72yYMguKJ2EMTmS1yYk
X-Proofpoint-GUID: 4w5iDjOnYtxzzRl49TO6fT_pHZdyQCVP



On 6/8/25 02:04, Boris Burkov wrote:
> On Wed, Aug 06, 2025 at 01:14:19AM +0800, Anand Jain wrote:
>> Some devices may advertise discard support but have discard_max_bytes=0,
>> effectively disabling it. Add a check to read discard_max_bytes and
>> treat zero as no discard support.
>>
>> Example:
>> $ cat /sys/block/sda/queue/discard_granularity
>> 512
>>
>> $ ./mkfs.btrfs -vvv -f /dev/sda
>> ...
>> Performing full device TRIM /dev/sda (3.00GiB) ...
>> discard_range ret -1 errno Operation not supported
>> ...
>>
>> Fix is to also check discard_max_bytes for a non-zero value.
>>
>> $ cat /sys/block/sda/queue/discard_max_bytes
>> 0
>>
>> Helps avoid false positives in discard capability detection.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v1: https://lore.kernel.org/linux-btrfs/2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com/
>>
>> v2: Checks for discard_max_bytes().
>>
>>   common/device-utils.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/common/device-utils.c b/common/device-utils.c
>> index 783d79555446..d110292fe718 100644
>> --- a/common/device-utils.c
>> +++ b/common/device-utils.c
>> @@ -76,6 +76,17 @@ static int discard_supported(const char *device)
>>   		}
>>   	}
>>   
>> +	ret = device_get_queue_param(device, "discard_max_bytes", buf, sizeof(buf));
>> +	if (ret == 0) {
> 
> Looks good overall, one small thing I noticed:
> 
> I was a little surprised by this check so I read
> device_get_queue_param() and saw that it does return 0 on every error
> condition, except for the final read() call. 


> So if that read() fails, it
> will return -1 and then this logic won't work. That applies equally to
> the existing code for granularity, so it's not a new bug in your patch.
> 
> Unless I'm missing something in that analysis, I would either:
> make both of these checks for <= 0
> or
> fix the return at read() in device_get_queue_param()
> 

I hadn’t looked into device_get_queue_param() earlier — now I have.

One way we could get a return value < 0 from read(2) is if len or count
is zero, theoretically. But in practice, we aren't passing zero, so that
part is fine.

Next, in the queue sysfs show() functions, the values are read directly
from the settings like this:

--------
/**
  * blk_set_stacking_limits - set default limits for stacking devices
  * @lim:  the queue_limits structure to reset
  *
  * Prepare queue limits for applying limits from underlying devices using
  * blk_stack_limits().
  */
void blk_set_stacking_limits(struct queue_limits *lim)
{
::
         lim->discard_granularity = SECTOR_SIZE;
::
         lim->max_hw_zone_append_sectors = UINT_MAX;
         lim->max_user_discard_sectors = UINT_MAX;
::
--------


         lim->max_discard_sectors =
                 min(lim->max_hw_discard_sectors, 
lim->max_user_discard_sectors);

---------


/*
  * Set the default limits for a newly allocated queue.  @lim contains the
  * initial limits set by the driver, which could be no limit in which case
  * all fields are cleared to zero.
  */
int blk_set_default_limits(struct queue_limits *lim)
{
         /*
          * Most defaults are set by capping the bounds in 
blk_validate_limits,
          * but max_user_discard_sectors is special and needs an explicit
          * initialization to the max value here.
          */
         lim->max_user_discard_sectors = UINT_MAX;
         return blk_validate_limits(lim);
}

----------------------

For discard_granularity and max_discard_sectors, the limit is set to > 0
by default, so that part looks fine for now.

We still need to check other parameters in device_get_queue_param().
IMO we can handle that in a separate patch.?

Thanks, Anand


> Thanks,
> Boris
> 
>> +		pr_verbose(3, "cannot read discard_max_bytes for %s\n", device);
>> +		return 0;
>> +	} else {
>> +		if (atoi(buf) == 0) {
>> +			pr_verbose(3, "%s: discard_max_bytes %s", device, buf);
>> +			return 0;
>> +		}
>> +	}
>> +
>>   	return 1;
>>   }
>>   
>> -- 
>> 2.50.1
>>


