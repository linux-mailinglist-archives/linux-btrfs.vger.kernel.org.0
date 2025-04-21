Return-Path: <linux-btrfs+bounces-13189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D74A94F6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 12:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077D51891751
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5842261568;
	Mon, 21 Apr 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AbzyJ1JU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JRuQsWA0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7BBA53;
	Mon, 21 Apr 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745231738; cv=fail; b=YwK9fQrlXyaUWKozM8FWh7WimucE4YeYV8NRo8HwdTBwv7rkYt1WU4QNA9t+v2+CCPItzL8kaxNPJ4ywrPMuBKWyHzKJZ6DSGhVNA/fTxuzoPUevr6Fbril+5J12vhowrRQEbPWY5InU1isZBcM60ytkf9iCDGxBdp0iX/ADAqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745231738; c=relaxed/simple;
	bh=05BRRAoXwSMO6llqrJwhy5n8cbvEmCKFurj+uBzJzjk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TLRFcj0BeFDJxhNKRkUys9WGvAh9Bo4+Q9jmBS7iNCCguOmoT8v9cGeq9emrpDFJGZwfNJo9VDEKEnmlWpFHx39YcjuQBUTtgad5+hV0SnfJE66nCZjbx3CWmtGX/QI2+YPql9DQXx9TbgqiyVRtlslL8Y+ldiUn+RYQwnMB7LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AbzyJ1JU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JRuQsWA0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L1D54E032001;
	Mon, 21 Apr 2025 10:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h+c8HJWPaUbnXvmxpgwWTY3ngGkVbmd5CmqNfGpEbFg=; b=
	AbzyJ1JU4ECPni377L1wO3g/ZnJNv3QrJANLdb5RUlKuvDy3yFzqN+js0diGsi4m
	AAJwhLQr4E09J+e63hae9OyTpBRApgViA/2KO3Udxt6Tk1UdW6DWruyED+FSpCPC
	+nDECY6+rwz9alOsC+PaufzlTOxRHhtS+SUe6+7k9ruRJDYULLp+6V1VFhcySHTf
	Q0vbzmO+WTz9aLbPKcTKoO71NDLr1cCiI5H3Q5Ko+S4MY/0/2dYGrZVZ2T4023Ux
	XAXSSpeiavUOZjumgZHVRDPLAgVmeeSt4jQF/YYZs+myANG9HT5noKaV2nPJNSa8
	XYX/9siOhIdWaVd25wD8ig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642raa9dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 10:35:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53L8aXYH005966;
	Mon, 21 Apr 2025 10:35:33 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 465deh2v39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 10:35:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQuXpWkorY6HSW9BOw4J+1ZE369aw5qagfVz05frjmNXcHaAerKoka5cY8LCY4mgcdSUCCob9Xh9bSnCV/G3WA3MjStPOjFeGrmWi6991Spg2HigLRW8jQ9QGnmSndHVc/vrlp1E1+pekKymDJ9Da9LOwRVwMdYe1Mpbi6oNeh/Lx6SU32iy4k6Y/WdyCiI4XyNEl1V8jtcM+C1nITYq0meaw/mavwz2T/t/yXq6nWlc12o0Wvy+rpBPBoB1TZoZEBWMi7KY5S+f3FLM6Uj+e6T7yOwys0H4Fuk9fDGiuO4UZ97FEUIa/LUyQiRxdE+wvFaZHm86bm1DQV4xeSd+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+c8HJWPaUbnXvmxpgwWTY3ngGkVbmd5CmqNfGpEbFg=;
 b=kovhYNtI8bK+AUpvMNKW5jrj+teeY5zHfl4bDnQ8gvUk2KSoso2AEuW8FhJlhkO3VvZXTRd2XXl2j9a8752HizY8AeCszIcNj7zmbC4ht9TraLj32FLUTCmXXRwwne7NWpZ9/wfaYOSUHAITNqkG6w8qWCrrmzzBJRlMQBwSemTXP0M18qoRaoAMxC/xMRggpZkPInidiwDrCF9LMmhjbFppGEizJAS52m+hPdqw3esju4IU2L5Kgi+CKgh2Ah7lAMkgxAjjDg0ddyPhBOfDkmIWSarGZGdp9sBLa4Rxu+Q7+XDL18bCKVgTNBcQc9BlkIPWJh2IbbWHtqHRMO+S8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+c8HJWPaUbnXvmxpgwWTY3ngGkVbmd5CmqNfGpEbFg=;
 b=JRuQsWA0UVP4yLM/h6bV2pTimfc0xR4nmCA1SSXNKTmTZHptNkopm6YdCmOkZxuXQxcLbWGaI1rB4eUKWQK6DalvZeiNEP8gkR8V8OI5dDps/cweOmEKaRisYXBhLsbOGXJJQFgLWBg/I1tmff+yZ4EyYen0KFdGNgocYL6qlrQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 10:35:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 10:35:25 +0000
Message-ID: <62e8d0a2-4680-473b-bd67-8c54e3155541@oracle.com>
Date: Mon, 21 Apr 2025 16:05:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs/253: fix false alert due to
 _set_fs_sysfs_attr changes
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250421075940.75774-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250421075940.75774-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cef04b-ea28-40a0-251a-08dd80c03a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGI0NytCc0JOaEtCdUVlZkJWSDdxNmdtVVErOFo3OUs5V0ZFMm9UbkprOWhH?=
 =?utf-8?B?UXFHdU00cXVlalFDV2lJcEJiRWROUGpXSkdZZzVCYzA0UktjRUtKNEVyak15?=
 =?utf-8?B?V09MU3U1dms0c0pwb25UeVllNDNOYzN1Qm9yY3FLVE9YcnE1VThKSjVZY1VE?=
 =?utf-8?B?M0dDTlB0SllpVTBvS2F4Qk9pNkpKVll4eUlsUUkrMXV0UmdpdXg3bXpXQ01l?=
 =?utf-8?B?cHlXU1hiTkVwbEdQSHd2VWpUOEtnbGVpSGRmSUhoNTlJNEZCKzBRT2dXZDRY?=
 =?utf-8?B?WXQrMWFyaXVJZVRpM1UzU0tPT1I0bEU1WE8wTzkyQjY3RTRscHdtUGdnbVFW?=
 =?utf-8?B?dnR2RzVXSXpHaXFsdWZwSHhJeEI0QWtvV3IrQ1lJMGFSVWZoWDEvZldQSUJn?=
 =?utf-8?B?bUloSVJDSnEwNDNPZ1RzMDF1YUREN1A2eWJIMFRHTFJmd0R5OFZoendSVzhn?=
 =?utf-8?B?Yk0wek5ET2VsTGY3SlFyRHp0RnpJUGdmaTgzZS9rMGdxeGJoUWNhUjJUdjlF?=
 =?utf-8?B?QWNPOGtubTBZWHRrc2UxcTdmbTdwOFcwRnBRR08zZExUTXhuL3E5UG90TEx2?=
 =?utf-8?B?MHdmOVNjNm54ZmVIcFhRUjdXK2lGeUEyOEg1UzFjclB2Ym11Sk1wdU04TjY3?=
 =?utf-8?B?NThIalp1K3NmWWhKd0ZNNUNaVnF6RWZSZGptU3pmd0Ywck9BQ051OUtHVHNI?=
 =?utf-8?B?UFVsbTVWOWx4SWNqckJ2dmtqY3NKb0tKZG51bXF0clc3QTdjMTI2Wm44ZUdl?=
 =?utf-8?B?VzhUTDBqT1FJVytpbkR2aWVsbFRFZDlodkw1bjE5MVc3UGFaa242NTU5SmtO?=
 =?utf-8?B?dXFGNHVXbS82T3ZWT0lSbzFzZlI1M3pvRG56Q24reGdXSis0UnQ2U2JNTm0r?=
 =?utf-8?B?V1Frd28wVWg0a2xXeXhybEI5d0t2aHBtUGNGWktvcytqeVJFNnFUR0NSWklC?=
 =?utf-8?B?bFVvWDdxY3ZiMkFtK042MlkxbThXejZPSzNxUjVBbXRQczZvZHFGclBORmJF?=
 =?utf-8?B?R2wvQTkyVzJWVkNiS3JNTGRZZzYrNWJmMDFLOG91ZHRVKzNyZFJuck1Dbld6?=
 =?utf-8?B?WFc5UVhuSUpwZTAzZmtsYlppK2hpb1dTd3Y1Q2FYRzhnc3dORm54MFFGQnk2?=
 =?utf-8?B?WlhyS2Z4L0c1bmk3Njl6RTRiOUtYbXcweXo3VFptaEtvcXViTkNmSm9SY2VJ?=
 =?utf-8?B?ditJL3B6RkdrUG55NHZJb09mM1RSV1NEemFCSjNUSVF6MFFXODF2ZldjckVJ?=
 =?utf-8?B?RG5vS1JxejRNMThBYnRRL0FqdllZZE11N2VqZTRmVjZFNlFkdG1QWVl6dlFv?=
 =?utf-8?B?UjVIcVZUZjBscDBnTnJPaVlncHJoNjhVWDdFR2Y3bGNPM0crL1VqNDJBN0Zo?=
 =?utf-8?B?R2xlb0Y3M2VkUjZhT2tmRkxXU1FnY1lrcW9lT0ZDeGhYTHZLbGxiYlJzUEgr?=
 =?utf-8?B?Ujl0emVOYU1FTHE2UWdpOHdmOEpsNk5MYUJrcDJCUm9Kak82SEZRQktwZTBC?=
 =?utf-8?B?QmVVcGRQSGNyb1M3V2RxRWdrdjVEWjBSNCtGb0h2dzlRNldtK0FPU0lrTWpk?=
 =?utf-8?B?Rlh2VlR4WHl5WUtoeENCbDlaa0lZOThOQ21MUnZWeU42bVVTZlhsTTZQMDZD?=
 =?utf-8?B?L2t1QTZsS0x5dlNaVHVlRlBiVVQ0UmVIVDV3TXVhMWxoNkFCdGdrRC9WTlZI?=
 =?utf-8?B?eENGUUplRkpQay9rYnZWdDRoWjRScG5YKzM3bmJlZjBEdTBjZHZPQ2Nxbjgy?=
 =?utf-8?B?NlJwS255SHk5WmcvTnRmb1EwamluS09SZWxEZ1dzdityZVdMamZGMHFydnBX?=
 =?utf-8?B?Z1RBSTIzRGdDUnlySHJVQmt5VWwxZEovNmEvUm9SNnFyT1JqelJ2QndEbXZF?=
 =?utf-8?B?RkVaaTdlbTJWOGhscXFNeUZtZVREYmpPZEEzb04yUjZkOUdHRDlNbGtaRER5?=
 =?utf-8?Q?VRGfw2kSXBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdQLytydENBWENFVlJvWmpOYW8wY3FTV0V0NHJYaFN3OTFaWXhJSVd0dW95?=
 =?utf-8?B?L2tJSnJlS0JGZzZUUEFsK3o2aENsYVBPMEcvODBndEFiM2tPSjBpNDFEa2No?=
 =?utf-8?B?V3VQUHFRVUZDL28vVStZazR6ekVFYTl5K0phb0RWdDNvWXdVbkFvcDN1WVhE?=
 =?utf-8?B?U2FEdUk3S0FGQXVyb0xPN2hRRnlxOWVWTFBkckhad1g5STh6WnNITFJDR0h0?=
 =?utf-8?B?a1Z4ZVdJVERQZzluWW0rUWwvYlNESjRYcnZGQWF1RXYrV0w3TFQycFRNL2Rn?=
 =?utf-8?B?aDdaNDNnTlp3SnR5SWNhOFVFUVllcVpKYzNlQTdrZTEwam16VGx1ai9NcVpK?=
 =?utf-8?B?Y1oxR1F0ZWFjTzZpcDdCOWVteTNaOSsvSWN0dkZ6aE1MRDN0cnRQMkY0Q0lJ?=
 =?utf-8?B?NStkc1BVeTNSV3BQM0FqcnhZR0J4NmhUK003TDB6ckRzOHFoOS9ZUWxUSmZ4?=
 =?utf-8?B?NnUzUG5wSGdzNnZvK2h3NW00YnkxR3A4Y3NWU3hWME1UUWxlSGtYbDkveGRY?=
 =?utf-8?B?UjF0c3N6OWRRNU1vNVM4R3laR2hFVEpsUnhCNktnRTFwNmdMbGRZQ3VDTTFl?=
 =?utf-8?B?S3NUSFErLy9mUXFqN2F5U2NBNkozSU1yOWJCakRCTE94TExIVzV4Z250UEFN?=
 =?utf-8?B?UnFhZWg3OUN2SG1ETE1MYUc2QXZic0VnRFJ1NTFKVVZ2TUg0MEh3bXJwTmhu?=
 =?utf-8?B?TXdjOVozdFAxaWRqQ1lNVnA2NlQ0WllSZ1RFa2Rkc3VhbjBtVjVGVVJCNGxv?=
 =?utf-8?B?UkZoODVDZzVmbGM4SFVxVGJyS0o1M1ExcjBuNGgxU0phcFk0c1hNTzFYOVFX?=
 =?utf-8?B?M1IzMTRKSk5SSW5ZTVl4SWZLbDlDQnR3c1BMRkNXcUJVRjV4VVJLQmlBN2w2?=
 =?utf-8?B?NVpFdS82cWtDRGZmVjdNZU1xdlkrTVAzK0pIOWZROHdzNExla1Q5Tk44dFNQ?=
 =?utf-8?B?RWFFTnBYVDZYcVdkM1FnVVJ1bk9HVDBKTFZkYVlJenIyQW1xNXRub0tFS1JO?=
 =?utf-8?B?ZVpwMWdzaFFSanU4cFBwYlZCSkJtS2M5cC9vRkNtUWhuakZpZmRSL1FFQ2tU?=
 =?utf-8?B?QzBId051RjlUMWVxczJra0lnbmw2WTYweitIRUYwNHBzZGZFUUcva25aK0JT?=
 =?utf-8?B?V1hzb3Y3TURSL1BjMzh0QlJEem1TREZDWnhlYTZIZUk2ZkkyZGU2NDNFS3kz?=
 =?utf-8?B?UHB5bW96V2d6Mmp6UW9CL0xDY3AvT0IwK0tyeWZrVkg3ejVPWjhGbENYSjIv?=
 =?utf-8?B?TFJyRDFURmhOajRLbnZ3NVpLb29nc00yZVJGcEovR0poYzlFVng3N2ZMbUlt?=
 =?utf-8?B?MTExc09VeGRiSkN0bi9oYkd0M1hJZFFORlM0aTRtOW1ENDhvaFBPb1pIanpE?=
 =?utf-8?B?NmhjVlRVZmlCOEtNUENnR3ZJSWpSaHQzcVFhSVl4QS9lYTJLZm9rUStjWUVo?=
 =?utf-8?B?ZXF3MEZCQ0JoZGl0dXZYVnBpZG11elhURXAzUmgxT3UzVnpzcXlVV21tdEpV?=
 =?utf-8?B?WU95SDAyWGwveTB4NUxSSlNYVDQ0UVlkVWZHTFVXK0hxLzA1bHBoMmlBenRa?=
 =?utf-8?B?TGZQWnJHaDJtMEYxRTArVFEzY2piV2JPNVBZUkQyNGQrMXp4MEVzenhvdjZJ?=
 =?utf-8?B?T2JtWEdLTFZ6ejcyZTdrMElpTGxXN216VUZXYUIwVTZnd3JCbmtkMGxHampa?=
 =?utf-8?B?YWVKdVBzQmF1d1Rtc2cwdVE4bjRqeU8vd1BZQ1Y2cEEzNjJVS2FVYmQ3WnBx?=
 =?utf-8?B?N3NBcXVuSEs0WmdCb2IyKytHWnlZSGU4VEhDalVva2VYWE44N21CKzJEU1k4?=
 =?utf-8?B?S2VVMytJN0t3U1NtTHBaZU5jeGw1VUNTZzc3YzNybVBEN0FMZTFuVGluT2cw?=
 =?utf-8?B?MGlIOStFOFdGV2dFWm8yM3NhbVNydkFSWEt5bThteTl6QTdKYldzNVp2SEgw?=
 =?utf-8?B?d20xYy9xQkdZQ2lRZ1pkaVJDa3RHNmNqcHZtN3dRSFhpNzNXWUpKVkQ4VWlk?=
 =?utf-8?B?U2k3eXJMbUpuNCtCQTJjVzdDWjRacmo3SktzaEVFVWJvNkFocUJwV3NkZXhr?=
 =?utf-8?B?TmxhQVJ2ZFAyelRWZ3ZCSVBRc2xTWEl3eCtsK25qRjdBTW5NcEZGR0Q2THVa?=
 =?utf-8?B?WG1CZ1hQQXFIRmx5WllpMm1UY3hkeUF3MXREWEozNDRTWHpQSHN6SXkzZmFm?=
 =?utf-8?Q?dNPBxLuhiVC+7NaWBpvM+duR6tZ6vIcvBOl07BEyu3RN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U3J3YOgmZqbS94aRKBzfnEQcf52TxBQELdwH/71g0ohgfc+QWbQmhY9IXYnPuJ6JPhg2qu6ozCiJJ4nXg3s107mzYndRlEvoTWI4foUWtcq5ZPvWxBOUyMiDrTj/mL1EayKKo5RK5A8KBK6ERmO6sMs4o7sfKJkIGno5FpnQUP2w7DUyh3PsgU0mH7RMOsF0Zsgk+U7Yj1U6xppIKO0/pn8xjRP7uY+QrQxzj0b9Ys+LttweURMvmEiV+L9iIusaH4eo4Xfj6b/6GyAXQeUIFBw4+DQlwZtMI+Qqb87vZEuTWFMsQ7RcXS+utLnOforD8yPmE8c5tAzDA5DJX+Geo0yEcyZdwASmsDbVNENTPl3LWWSQYEcg+aPR1NKzO9KutS0rjWPcFVAlOoIF1qDn72XJpduXaPmkDv7mANxpUrqXqfAsPOhcdY2VzR8NcwBFQ00YXBNi9R1zaQVmvonTmKPbSUkw8A+ZvaaWukUi/Z94gpRq2Y4tcT+TkaMEr7DDeAeDfyuQwVG02ion9uQn3UBhjlA/nqdmXZi8+C8CZUnBSFIFzBrsp0edlpMp116nyuq2iHjduPZAFdYOe44tktAs5OwC8p/oq9sN4+n/hNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cef04b-ea28-40a0-251a-08dd80c03a03
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 10:35:25.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjYwyI7z5T5Dnxdn+g/OEA1sexixFmifgRriJ1bJYG26urjTzyC9M7xt0c2SG5UMdBHuyLYaJ5i7Dq18CmCpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210082
X-Proofpoint-ORIG-GUID: _OR8GbMu5pw9V10agQy17v1nBkRNFFdG
X-Proofpoint-GUID: _OR8GbMu5pw9V10agQy17v1nBkRNFFdG

On 21/4/25 13:29, Qu Wenruo wrote:
> [FALSE FAILURE]
> Test btrfs/253 now fails like the following:
> 
> btrfs/253 2s ... - output mismatch (see ~/xfstests/results//btrfs/253.out.bad)
>      --- tests/btrfs/253.out	2022-05-11 11:25:30.753333331 +0930
>      +++ ~/xfstests/results//btrfs/253.out.bad	2025-04-20 17:28:39.139180394 +0930
>      @@ -5,6 +5,7 @@
>       Calculate request size so last memory allocation cannot be completely fullfilled.
>       Third allocation.
>       Force allocation of system block type must fail.
>      +./common/rc: line 5213: echo: write error: No space left on device
>       Verify first allocation.
>       Verify second allocation.
>       Verify third allocation.
>      ...
>      (Run 'diff -u ~/xfstests/tests/btrfs/253.out ~/xfstests/results//btrfs/253.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Since commit 0a9011ae6a36 ("fstests: common/rc: set_fs_sysfs_attr:
> redirect errors to stdout") the function _set_fs_sysfs_attr() always
> output everything into stdout, thus the stderr redirection makes no
> sense anymore.



> 
> And the expected failure will cause output difference and fail the test.
> 
> [FIX]
> Use the helper _set_sysfs_policy_must_fail() instead, which will handle
> the failure.
> And update the golden output to include the expected ENOSPC error
> message.
> 

Yep. If we expect an error, sending it to `/dev/null` isn't
ideal — it should be in the golden output. All good now.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Added to for-next.

Thanks, Anand

> Fixes: 0a9011ae6a36 ("fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - use _set_sysfs_policy_must_fail() helper instead
> ---
>   tests/btrfs/253     | 3 ++-
>   tests/btrfs/253.out | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/253 b/tests/btrfs/253
> index adbc6bfb..96ab140f 100755
> --- a/tests/btrfs/253
> +++ b/tests/btrfs/253
> @@ -25,6 +25,7 @@
>   #       value is in megabytes.
>   #
>   . ./common/preamble
> +. ./common/sysfs
>   _begin_fstest auto
>   
>   seq=`basename $0`
> @@ -228,7 +229,7 @@ alloc_size "Data" FOURTH_DATA_SIZE_MB
>   # Force chunk allocation of system block type must fail.
>   #
>   echo "Force allocation of system block type must fail."
> -_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1 2>/dev/null
> +_set_sysfs_policy_must_fail ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1
>   
>   #
>   # Verification of initial allocation.
> diff --git a/tests/btrfs/253.out b/tests/btrfs/253.out
> index 6eea60f0..5aa75d54 100644
> --- a/tests/btrfs/253.out
> +++ b/tests/btrfs/253.out
> @@ -5,6 +5,7 @@ Second allocation.
>   Calculate request size so last memory allocation cannot be completely fullfilled.
>   Third allocation.
>   Force allocation of system block type must fail.
> +No space left on device
>   Verify first allocation.
>   Verify second allocation.
>   Verify third allocation.


