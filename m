Return-Path: <linux-btrfs+bounces-10721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A45A013FD
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 11:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DE43A43A9
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D7192D8B;
	Sat,  4 Jan 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fbRmPDz6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vHyu3zr9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68CB189B8F
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Jan 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735986932; cv=fail; b=igBppWcPEiRVi1vyOFKQyNWVlC1Hhz23UPi/rPT5iHXPml4WEkj91gEOw1QQDlq/pibTHyXLQaEjBKEocCilRRCSPx76iiAp+3x2V0Db75nUQuhcZwhKAi5osAsutaFEe3SRZbPJx87vafDgrXxXxSNtwcXd/ldUWiKON/2vKP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735986932; c=relaxed/simple;
	bh=r5QBifw8ixU3zsneP5OzFRIkruwop4YfJyYgwPYw7Vo=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JpJc8vqiHAyiFVARXvXQItGkOpr9KaYCG1o8dbMlSszrKunaMnZIVXsQo8G6bXmA8i/X8I9TbfXS5iDumspQxtJb+CBGNuLnbwpIXhXrvRb6AbxrC1+rLsV8ePNBeRBE/uFcfVCllwbJJtLLFmC3spskajr+cY3xBAwZhtuMSYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fbRmPDz6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vHyu3zr9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5049P1Y7027451;
	Sat, 4 Jan 2025 10:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lVT9n7gFVUViKp3CHvd3oAlQRgqPZBYt8ifjIa4WNGs=; b=
	fbRmPDz6JFs4/nyMpbWkBkjfiYX+zoEyLwXTse0jeOvA1RpjJYlIuuFXOelZXYcF
	Tmbq5uqhLTiygsGtf5bPo6EBA21z8Y1GX19gigXJdJHNoqgTR6vC1Ld5B5DY5Q8t
	LW3o28hH4V9fzXZymog0LN4I3gQMnrm0mgV40UIpOioqGT6GOKB3S8SFWsZ1OoDL
	f9vZMfjyQDahdhFJNOZp8YpSTuzeUCek0XPGauqtiVID0OhDc0dW8p+dxt4U8+UV
	wENCcwd+/mLTYCSbW+QCqhxDyrmH51ZxxXfpFASlP2s/OdV4z7y3WzixdvDNgbCA
	aIea+Nh8rLKVIOww1GjXMg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xus28fdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 10:35:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5046AsUN005424;
	Sat, 4 Jan 2025 10:35:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue5rrfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Jan 2025 10:35:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDsS6vQijuvYwIT+XhXW1RE2OYRaxOoG0twhSYmbJRQ2T6JHXE6CHD0Z1a5vHYrKzevXSoEvj6ZDQwS1UdbIT607LkYi/qcX05n8d8f5Eq1A39Io/nkk3I1obzh/28BchUCjfiyrd+YdXiSKbA7FRndTDh0xC8rvRVw0FTNH1lzPDgFaMdAj5Z4AeMrJHobBhtTUoTB7xX8SqMyQARxFxUjSd7j6/ZS5IUCMW2YF9S41c9E9ZSW60m7v5owQ+OAzkvH7y3Drkjg/gpje2WbVAzJkhpUYmNWCjyaqWy339YZw97w/lwI3w+pf2gICgSukDyaEBSrfbTHX2HWETm2WLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVT9n7gFVUViKp3CHvd3oAlQRgqPZBYt8ifjIa4WNGs=;
 b=PFda+LE5kbBA8E9KqzPISnxig63Eq7i9vYnBVEPM6HVKrvuDRBhHrzcCauRw44YWkS3ZeT84/+GTfkg16Oitptigw8TNlz5e0zFv8oXzDM0VVy38utaLjtVyFMEOo7x+lYzuUW6qrlLrP5VUBU4Owjj5sSkp2mi9DaLW8BgiKdu/FD1IMBK3H4mthXiijzwgRVLyuyi4RmalBZyY1YPaYgvQN5HwVy6//n5J2Usf8CHkrr93PzA+wtC0qAN6p7Vj+5S6ikvhN9fraM8/Q3DW2Kgooyj9FM9aJp68wLDgy4Dt4HJjsNq5IBbuqkH3/vfm40M0XDGw2/NQLz++DNejMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVT9n7gFVUViKp3CHvd3oAlQRgqPZBYt8ifjIa4WNGs=;
 b=vHyu3zr9KB3CJ3V6NGSDd2l81zFPfPdLylI/Yt6Pq2KssTupN7E/kGjzzpMziEcQg0LiVi7sD8ddEwc804btRA6pP27O7u94WPKmnZFC0GtDJ3Iv7jQgo6EbYj3fADyXt7kTlS3Eetgb31l0quwfv1TKVLZ4hNrMb8smLNXzArs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5745.namprd10.prod.outlook.com (2603:10b6:510:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Sat, 4 Jan
 2025 10:35:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 10:35:14 +0000
Message-ID: <75ec1c40-afe5-4d26-b1bf-ebd4adb7e4f8@oracle.com>
Date: Sat, 4 Jan 2025 16:05:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs-progs: btrfstune --remove-simple-quota
To: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Boris Burkov <boris@bur.io>
References: <cover.1720732480.git.boris@bur.io>
Content-Language: en-US
Cc: kernel-team@fb.com
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1720732480.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2a4ae8-8297-4f45-7196-08dd2cab78dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2VGanZNZHdKblpORU9RNkZFdVVVOUNoTWtoT2FQcUpzczBmUVN2VnlrbXhF?=
 =?utf-8?B?LzZTUENHRndtUVRhcGFlSE52dm5BZnJGdlZnOHo2MUVQdzJnMHlXamJrd1lQ?=
 =?utf-8?B?Q05iUlVkVUdscFVQMEpRQTBaV0VSVEpZWW13UmxZaUNpYW1LNlpOWDhqd1Ra?=
 =?utf-8?B?OEN4M0RwaGRYK3BYK3oxY3FKbVFpYkVQMjk3QzNaZDA0NjJIejVmR013bXA4?=
 =?utf-8?B?OTFTMVkrVmZPWGhUbXBmVG5XRGsrMzIrcnlnQmFtRzZ2eUNWODdPNVJocUo2?=
 =?utf-8?B?WWFTc0ZLamhnU0xIM2RVeTg0U2owWlVWelYvbXlvRjRVL3RNQjFVWGl0SjBZ?=
 =?utf-8?B?S1psRkRTMlJIVmJMeGwzOEthWmtkc2xFOTE2b2xVb09vK1dtUmtXQjNjV2xt?=
 =?utf-8?B?U1RhM0Y1bXJMR1hLMnhXUmVzZktXSEZvLzVNVjNRZjF1OWF6dmplNGZ1TVFu?=
 =?utf-8?B?VWYxM2c1RFF1aWYxVXlvL1R4MDFrUWJxaVkvbTYyOS9ZdkpxWVF2WVAyREMv?=
 =?utf-8?B?UlIvZ2c2bWpyQUNGbWFmVjRKN1pFcFhoa1Z5Q3M3aTMwK3pGSGM2TE0wSXlJ?=
 =?utf-8?B?WlRHQkVIUEVvK1Y5VVUvdEFkWi9FSVA5clFDYXdxTVJqRU4rcXlhcGpLdjA2?=
 =?utf-8?B?OEcvZjcySXJZVEMzWUlqVnRGbnFGZGtyb0xOcElUZnpxQ2plUiszU0xoY0Nu?=
 =?utf-8?B?ZHFrQXRnYkhUdlJIVFVTSE5NemhUN0xDSy9ocXhGemdwQWtYYW5Za242bVJE?=
 =?utf-8?B?b1g3Mm5xdyt0TXhLYjBvS1RqR0FtUzlQSnM5Q0loNkFSWGVUZ21FNXl4YlU1?=
 =?utf-8?B?WmVCZUVjS2ZKNitEQzJMNXZTWUVDVnByaFpSbUoyT1prVFVQWUY4RXdhTVhz?=
 =?utf-8?B?Y0FhY0ZRS1dhYS9DTEZiRHlsWEJ0aFVBNE82WUNGVHBmZ2w1R0JoUXJid09X?=
 =?utf-8?B?aGp5QUpzRmRua0RnU3FXblRzZEFTbFZCRWJQTjFSbENsZjV5RUJET2dsRjM0?=
 =?utf-8?B?Si9KMzNCRUdlZVRYbVExUjQ0dm1wdFRhTzJHeVNIbEpqZFFTZllINEJPcmh6?=
 =?utf-8?B?QnF6UDNLaUtKYWZQUXMyUEFmSjVhMW81akVCNjQ1YjZhUjdoQkZIM1RPbXVD?=
 =?utf-8?B?L3pSNWhQTC96WEowMDVKVm1LeFROSmtxM0QyRGNnUXppenFUbkx6bWpxekNt?=
 =?utf-8?B?WkZSMkY5NkhCMUcyV3VYSFhrUDdZczdydnlYZEV5S3lCNVYzV0FTU3pmWFZT?=
 =?utf-8?B?WnRldjdRejY2cUs4aHI3VTNOaHNnUG1OUmsxWHhHS3paalY1eEpWQWNMTnds?=
 =?utf-8?B?a0Exdy9ialZJM2laSTgwMFU1bkg0dS85WnpIUXcwb1NjeThXTWtCV2U0aTI4?=
 =?utf-8?B?dDJXOW1Ed0tSUUQzQVhWYjA1b3N3U2kyNkttbzIyUWIvYml3K1pYQ0FPRC9s?=
 =?utf-8?B?WHhQMEY2QkVpRExjWWhRMXRBbEhsdW1rQlQxeTBjYTVHVmpWU2FpeHJUcDU5?=
 =?utf-8?B?R1FiS2hGazV4ZUorWDNyc0crcmgydFY2UDZyc2hVelc4THlKVzNLdHphd0pG?=
 =?utf-8?B?VStJTzZ3WG1EcGw1Z1FjZ0RWeFoydFNVQ0RPaEMzTDY4azlZbWpaSjB6N21H?=
 =?utf-8?B?d2VUamlzYkN2Zjlqc1hKWVEzMnNYRUZSa0JIZnRDTTV4MVM5bU05Q1Znd0VS?=
 =?utf-8?B?Mi80YjZWU3pXVUgwUFkxUVpLbWF4L0VOYmF4emhzT2tkb2FPSVQ4L2MrRWpa?=
 =?utf-8?B?RCszQXlRczNYaXZLdlBlTkswRytnZlIyOFlaZDdBdEpIQU1YZUtTcG1aRVA2?=
 =?utf-8?B?Tjl4bVNCQ3ZDTnYzaDBlMXFFR2RaWVpzc0swd0NXK21hVmlkb3VQVmhBaG5y?=
 =?utf-8?Q?MeNSiQ/rQ/hil?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTd0WG5RUzA4a1JEUXlodStlOWR5di84dFVicE5EUFh1ZjYrSDYxZklXSmZm?=
 =?utf-8?B?aXcyU3FWWUgvbWJCM1BKUmk4YVJubEd3UXV2cXlBUTVNUWdFQ3laMHA2QVpr?=
 =?utf-8?B?bTJXM1loUHFnaFZ4RWh6TC9GT21JeER2WU04RUlwQ0hwNkdBNTNZZVdXQlFQ?=
 =?utf-8?B?QXFGWCtTQVdLeDlOSnNuU2pSTzJyT0RTd09neDY5YWZhNDlTSzBiQjliajEx?=
 =?utf-8?B?RVdIaU03a3M5anF1UGlncnllNXB2U1NVaEplSk0rK0hocUtTRUFzVEhuN01E?=
 =?utf-8?B?VHFqaUl5cmZ5aTVDV1BNS1BsOVZwUHdHbnFpTWNJN29ySlp1cXRvR2twdGtJ?=
 =?utf-8?B?ZFJrNFhzMkViSzEwRCtoeFFUQUN2SFFHQlFhTUlTQTdjdHJBdFVSeFZkUlVN?=
 =?utf-8?B?c2ZRY2lmRTAvc09qRzZxZFZzcW1rSitvVEJGVUs2LzFhcFBNeTZNYkJSZ2VI?=
 =?utf-8?B?S2lVNEhmVElJQUU5SjN0ajNIL3VzRzZuREdFTkVBNXRpMkI0TnVCTWVFNGh1?=
 =?utf-8?B?R0RwbW44cERuYXJYMjZINEtXWHdENDlycjNqU2UrVXRVbVYrLzFQUzMzM3hz?=
 =?utf-8?B?alhQTjdJU1ZLWmhLa2ZOMHBtb2tnL0c5TkdKL1VRTU5FbThZQUJGTk9PVzh6?=
 =?utf-8?B?UmVkMkcxNm9xUmR1VzJrQXdNSXR6ejFRay92ZW00bWxGb2tydXFsa1JtKzB0?=
 =?utf-8?B?YS9uK1UrUXJyTlRpSXdEOXlmL0k3aUhsdzVrazlwSUtjdC9zMzh3NmlIakcx?=
 =?utf-8?B?SUphUCs4SlZVSGp1NktiTTdtVTVwcjNucmhpUFlKYlFuSE4xS3JsQ0laWEgz?=
 =?utf-8?B?eFVBMzN1OVlWZTR0TVFGZjhsdDVSRzhEYy9uM2pWcjBieWVScURsQjdJSG53?=
 =?utf-8?B?SlYzYzQ0dUw2NDQzRVNiS0dUdFVLamhvQlVUTlo2aFR5YnY1Y2VCcGN3Ri9J?=
 =?utf-8?B?VitPNUsxa0NnYld3dXh6ZnFwNVJjNXhJZHV5bnBKeklEcHdFZW15eWs1VHM1?=
 =?utf-8?B?MzFkNm5vWmZwNE9aTFIzR2Z2UEhodkhQZFRiZC9FT29NQlk4Zi9kUEIyM0Nz?=
 =?utf-8?B?Witrd2UxR29DSHdCZERqY1NiU01RK0ZjVEdZRGRQZ2dGVy9zMXlEWnVQZk9v?=
 =?utf-8?B?RjRMd2ZWeFhHZjg2bWZ3ZkxRcXdCTGFQSFIzM1h6YWl2eEtNT2pISTNkRXJ4?=
 =?utf-8?B?YzJvUWg1SFlEeWpWZUxLd2ZJZ2tzOTBlRlk3eEhOVjRaQWtWQTdPSjJNM29y?=
 =?utf-8?B?OWJVL0g5Mk51RUxvTHpYemJlN1ZrWGtmOUFabDNTdHQzbUU5eGdteklOQ2Fh?=
 =?utf-8?B?MEZnQ3lMWHFLZENFbWVxZ1I5VklFZGJRY0kwMDd4VU5ua0gybHNuM1RGMGwx?=
 =?utf-8?B?TkZkbnZLemg4b3MybU5uMUwzYzc4STlyeU1ielozVk5qRGpyOWpTRXVCMEdq?=
 =?utf-8?B?WWxrMUVFOEkxK2V6THJFNFo5aGUyWENCVkR2TjhRbkNJUldsRFFFMUcySU1k?=
 =?utf-8?B?UE15VGllTWMrWGlwY0FKZHlPcUh4U1oxOWc3VkNUWUZrWDNHc2NvUVdhakkx?=
 =?utf-8?B?VEJKZDZhTURxbGs0dHZZbWJzenhELzVRUFNtZHhBcm1SOUJOMzhENk1HeStV?=
 =?utf-8?B?OG9BQTA4MmhDUlZCUmN6eVpMVVZ5dm90UHJxTUM1b2Jua0RZNGVSZHNiNEhI?=
 =?utf-8?B?T2crcWFhYjEyd2lwOGo4QWFWNU43MUZKejBIQ2dPNTZoNTBHckYrM1lLWG90?=
 =?utf-8?B?ZTF4TGdWTFUvUlM1bDZxTlp4K29RVG1LNHR6RGVwcS9TM2VRdFZVRk9UT25v?=
 =?utf-8?B?cXhkVWh4UEZBOWJZdU0zYWlVeFBWY2VYUWFOQytVc2ZEUlhVZEx3SWxlU1R0?=
 =?utf-8?B?WVhCRlo3ZjBsUUVaaVFJdE9MWllMRXVTVjdSZWdSSnJ1Rk5JTm92Y3JIbE8v?=
 =?utf-8?B?SEZHTThSRDJ0Z2swY3ZWNlUrOGZOZzNGaExlUC8wT3ZicEZFalhwdkRVT2ph?=
 =?utf-8?B?Nnp2L0ZZT2JMemkzcFJXT2xyemkweDdUQ2ROUGR4R1NPa2tiTWxOcklxRytz?=
 =?utf-8?B?TGpwVnVXLzVHSVA3T2pJRlpscUtCOGdsM01nQXQzNlBQYVFCUG1rRC96aWpK?=
 =?utf-8?B?dWlQaHIvNi9aSlhiNkJLOFZ1enh5ZXZQSnI5V3RSamxiL25vbC9NZVdVTlEw?=
 =?utf-8?Q?pDeCnxZsz7KIEak/7rX/dG0p3iHbErvZD58WsQIDJst7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MUnx1UBQnLHpHep0QZOlRxRKKz90AiIG3+5xzJdILrNrTMg+nAkbc7W0ekmoyKkek57unIsJZt8cHzJ3EA7FgwvwiTnVVCbbk4f3DOz+gK6Koow7VCVyMsaiP/DoWPCHPCCDpagkyfMW+Bh1Ro7ZIyNC95VeSVwOaZRakY68hA7K5OP3SFmzMRt/M3MRggq8NI9csxszgaHENBCVjidiYUJatS+kZTgpCt7A0meWPt1QjqwvEMJoVOm7fjq35hEXCdJHhxFTWMM3gZDnLBkHOfhZvGC4Pj9ygj3VwFgqfuPXWNvr8c/oxm3M7Caxpp3jjjc9ATu9snir5hK+wDNQ9KtQBc5ogTfwT96GUjosLYVIp56PVKg2RvzNlFp4SllSL8m8xhdwOcHjOgZANslMQ9ryEFZrSQrREcPS7Cs46Aj0QAIOZIf4ZZVevcVHK99cmJQ9gkY9gAdgh+8bK/1d2p0n3wtdW47lxrm0U/nCTfo2oHHObGWH08BAdoekySPTevYZmbRl2A6qDvJeTQJIzJv9SQVVnpjcRzcU9Iu1KXDtkYDkRt+E5EzQ2cJjdTGcYkJDP533K2IJoG47jEpHFa2/kL5hufIxP1SQkSDYJEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2a4ae8-8297-4f45-7196-08dd2cab78dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 10:35:14.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GHCj5bawjzFdZG+6ZLr87Ie8XyYGkGJFlfvDdOGLjB5GVNUKWxV/6ss1thVIl1J1lEAiEHLohwFGovS+PZpWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501040090
X-Proofpoint-ORIG-GUID: AVeDdz5WMOxxU5dguAqASMGuyPiZ-KZo
X-Proofpoint-GUID: AVeDdz5WMOxxU5dguAqASMGuyPiZ-KZo


btrfstune --help shows -q as the option to enable simple quota, which 
does not work.

David, has this set missed integration? OR Boris could push?

The whole series looks good to me.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.


On 12/7/24 02:48, Boris Burkov wrote:
> To be able to nuke simple quotas entirely if you decide you don't want
> them (and especially the OWNER_REFs) in your filesystem after all.
> 
> If you run
> btrfstune --remove-simple-quota <dev>
> on an unmounted filesystem, it will be as if simple quotas never existed
> on that filesystem.
> 
> Boris Burkov (3):
>    btrfs-progs: add a helper for clearing all the items in a tree
>    btrfs-progs: btrfstune: fix documentation for --enable-simple-quota
>    btrfs-progs: btrfstune: add ability to remove squotas
> 
>   kernel-shared/disk-io.c                       |  39 +++++
>   kernel-shared/disk-io.h                       |   2 +
>   kernel-shared/free-space-tree.c               |  42 +----
>   .../065-btrfstune-simple-quota/test.sh        |  33 ++++
>   tune/main.c                                   |  18 +-
>   tune/quota.c                                  | 160 ++++++++++++++++++
>   tune/tune.h                                   |   1 +
>   7 files changed, 253 insertions(+), 42 deletions(-)
>   create mode 100755 tests/misc-tests/065-btrfstune-simple-quota/test.sh
> 


