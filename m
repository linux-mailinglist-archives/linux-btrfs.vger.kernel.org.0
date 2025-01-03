Return-Path: <linux-btrfs+bounces-10709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B0EA00B18
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 16:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD1D1642DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54D1F9406;
	Fri,  3 Jan 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bmYQYvdx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qSISQfWz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABA1FAC56
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916681; cv=fail; b=EQJaVQyq7Yr4HzJhmWn7pnuG/BBh59PVI01/73VqsDhxcnv6tY3CcDae90TzZTktzPsWZ3fuSfiuE0xcFcFkKNOszTrECeqayssNzj/zNbi7BJdlHhiI2txbCzSdB4zILYlzXBpTCJV2syIk5zBtCpb+dFbc4iWtCfMoCpbu5ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916681; c=relaxed/simple;
	bh=QWL/VHh1GCxDblWh0fsi83WxhCiXbf0bSYSvxHrQLa8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HmY+OzL7j+FK5YTfVp19k+MFLTP2su+p1+2aaBcKEp/WG4ddm+bDyYTRWuXrVxplXXiZPalP2rx3oR7vqVcpdRgCvZiqvTla7T5ucUJKb7lLAXnx6OH+IT/Tjfx/VAITjzOWJu9wquIY5P7a8nNrCfpBMlWpr1TQrRhY+gNQiS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bmYQYvdx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qSISQfWz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503Dg2F9012277;
	Fri, 3 Jan 2025 15:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W0yc4xPYs0caAjfWtUFfqrG7VbPvx6DewwPfbdjbVSM=; b=
	bmYQYvdxnue9wayIRkkcAY9WfYo/Z1Z6A+RMV19ganH99GSdT/qnHr1AN0oNQiMl
	mnU9ZO+zxe+JiDJUKDkM74EnbjUb7+A+hLSHwu5Kr9TZircwYqSGtRySjAj5gu/z
	+IEaeXPLJ8kQ/WdioDsTeP0ZE5E8gcRI+DiRIqN+o/6jMtZfNzea9aoAs7jx+j/6
	h5cPzKWbqsFn3PIVvxjTHF3qwU6cMIkI2qcq8U5jjmspb8n6G/sNw6aMikcggshI
	fQcF22WZohGEU3ukrvdbAqCmn5GcqRSzj59F9eDwXD7V8a7sir/pDtxFKRamrh8U
	2IIIpCvc2yuO2IhLGLU5Dg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt875n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 15:04:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503EgaHZ012954;
	Fri, 3 Jan 2025 15:04:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s9rx4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 15:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whfsOwWoZpsnOUypow6bFAcm9faCfkJMDQULD1CUQYvEz0rfUNop2bNr/6FVYPM3LNlm8ukRZ8ZDsH7K8GKHaQCvyfB67s9cXrsrhoWt8Y3PMnAz5atqaxWi2uiFBdmV/6Lkc6JZh8rQGk/NIbnUYLYRaS0IuVso2Wn3XrliFfnolrUZi/bY7ueefY3zDFDgJRiJZC0dSiVcnhQVd527lriTRAklspx2GtGYPnKVtE9LQunnzi8oJOZ5nfEtL2wx5XvP5Mo9Hc+PYou+ANM7w8gcdJlrj9OzC0goMF4H8p/xECe9lHDse8HgvjLghu9rnmXItbvLXUSMeUpkolIENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0yc4xPYs0caAjfWtUFfqrG7VbPvx6DewwPfbdjbVSM=;
 b=SWCg21SAR6r+FzJG6xaOH5T8mD/3vvo+8FI73aIdiOWxhXOuZMnbvmG4Wk3HF5Jb5EpHyv1NGncz8FVHuIDfQfRPUPE3DATVo4d4oOtsTA7M5VMne21txo12pQHmkePsQaQmdjf1aQQ4W3VkwiClEgQEFDatOceXhmNeruP+efij3xqOyJImOSiAOvBO7WQXG5ASghdSEVDN0zomnSav7xvS18A6cVLXhQWYRFts145n9mi2W+CcsBwVTNqT1N+m8qSiyIhJUQRteIPfuaQsmZtUTIhkhzcpCx7zhNsOiYPNvkEODLd4sNW4Yb7gnjBvqdcv5NDGhH9wKcxg4l25Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0yc4xPYs0caAjfWtUFfqrG7VbPvx6DewwPfbdjbVSM=;
 b=qSISQfWz2HpSfrOAwZvhw4f6T9yVhbShqypkRAZSZw9olvPcKfnJox+bJbZC+lANb6EkGNQJmE+5DC3EL5wl1FaI4GGYCgVupHIZlK03xGqAS8yvLZ5xIQk5Th1HErJLVT2pouZu4vplDgWdf+fQftZYcbQqOLgG3frO5oOR0Ys=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 15:04:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 15:04:18 +0000
Message-ID: <40c66d41-1241-4ece-b032-c165db086018@oracle.com>
Date: Fri, 3 Jan 2025 20:34:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] btrfs: handle value associated with raid1
 balancing parameter
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com,
        wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
References: <cover.1735748715.git.anand.jain@oracle.com>
 <6a303a3da8116c3743fa9be605dde540d8a60f1a.1735748715.git.anand.jain@oracle.com>
 <20250102182920.GR31418@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250102182920.GR31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd0f4ef-7b0d-4869-b9d6-08dd2c07e563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXF1RllzL1E4bVVJZ25pUUhqb3kybit2d0dPMkNqZzZVZWY0eVZsd1ZjaTJy?=
 =?utf-8?B?VklGTkZWTUk0RnUwS2h0NmhsdGVoMlR0b2FoR0xHSzB0N0t4alB5UitNMEhi?=
 =?utf-8?B?bmdjcGNhRlVhNmlGU1YrOFVrSUZLNHBEQzRwdGJKN21MVjJaTUV2d3V3S0U1?=
 =?utf-8?B?STc3ckZOVDZVcnZwTVBNOC8yQ24yWlQvRWExaVFEMm9qWW54bFlvVGdFUTNY?=
 =?utf-8?B?ekFMdjc0ZmtuNzdiUk5uY2ptcWJlUzlXalNCYXRtYkdIOGZmOVQvclhIK3FY?=
 =?utf-8?B?S3I5S0FCa2haVUc1YjJGTXhUa2Y4OCt2OW9vWlRaS0NHQVpPNDZVQW9Bekll?=
 =?utf-8?B?MG1pbm1pWHVDb1BuNnMyQVhCM0UrUmd2WWxsMWprTXVUN0ltNE9SWHJPYWx0?=
 =?utf-8?B?RndPM2NaOHhVdXlzL2hmWWM2Vk14aFFmOFp4cURNUTQ5RGhqaUZISjFmcDNY?=
 =?utf-8?B?ck1SQ3dWUTEvK05xbjRpS213K3pGb0x2bWpCWFk4TlM0NEJ3Mkh2ZWs1Mk9N?=
 =?utf-8?B?L0R0TTB4WDNwck45TVJyVzV3UFhkckY4cjJWU1Y1RUp0QjY3dmxjNjNTdUZC?=
 =?utf-8?B?bU5jeWVCUm43ekcrTURvN3JQbjdsa01mMWNBWEM4SE9WbnZUZ25pMURKTFdl?=
 =?utf-8?B?Rk9Ha0IwZk1JWlhaLy80NlBYUlJMMi83ajdSK3RyditLV3NFVFdBc2pmOW9l?=
 =?utf-8?B?UXBJY2RvcTNkSUUrTCs2VmE0T0xENWZwQ0hXQ24rVHpUTWlWMXFjRldkdThv?=
 =?utf-8?B?dktybGFDbFV0clpBR3FuSFBCeDBpR21YOFZqLzlneTRORS93YktqaTljZWRu?=
 =?utf-8?B?RkFrY2FZT21qZG1ISkJRdmNURmFXYVEzQ2paRStDRGVrVndXOUp4OGVMcmx5?=
 =?utf-8?B?U1RZNGJ4MUhrVnRnUUVPaUUvcnNYVDcwaXZicmJMbVJSdU5oM3hFQ1FHVS91?=
 =?utf-8?B?cHByV1p4Zy8zLzhsOHRDSUxucFUvWU5iSmtya0JLbGcrM3pkSkVlTndhVTBQ?=
 =?utf-8?B?T1JUV2hOSnhKRlRGU1NnMWYxTzNEelJzNitCZzJXakE3NXh1OFJQaXcxK0hz?=
 =?utf-8?B?QWJjT0pORzlDaTFmZXVPR1BEcVZ4ckdRODBGbU96UmpVTDBIcVI1bEcrd2M3?=
 =?utf-8?B?aloxRlBZSVJzTXJ4OVZFYkE5bmNGZjAza1lMdzIvQjVmQ0M0NEJxNjVzbjJR?=
 =?utf-8?B?WkhET1FrZ2VVNjNSblA3eWFIQ1RUaTIvMWtGOEVockl0WWFhOXM5cjR0N0hl?=
 =?utf-8?B?eUI4Z3FJalBZTFNpeW5vTlNyUHpHMjlaZExPcDl1cGNsaVAwQUU1d0M5cjQx?=
 =?utf-8?B?M0lVVit5a0UrRlA0RUtwc1BzZWl3MFlqOW13Zm8reW92eW04UmVNRGc3VlUw?=
 =?utf-8?B?eFBxVStIOTE0U25KeTdYTEpRVTFxeS8xQVN2VU9Zc0tySXdOUXhBR3NHa2k2?=
 =?utf-8?B?U2lHZHp4K1h1amhnemRRUTQyZ3V3SW9hdnIyYUpHQU5vMC80c3pXdnBOSkFN?=
 =?utf-8?B?SWVRU2dQU2dSMW1MRjFYSENtYkZkZnozWWwva3NGWmVIN3dkTzR5OTJlRE5z?=
 =?utf-8?B?cnU5L1p6ZGk5YzVMYytWcExjamc0QTFYbDR4b1NmY3kwL3pVa2ZZUldaWk9K?=
 =?utf-8?B?c001VE10MFp3QWdhaXUxUDF3dmprenJnRVB1VHRick1ndU5xd1hkL1UwU3Uw?=
 =?utf-8?B?Y0F4RTYwZENLak9XN3k5SElNUnI2QTd2QVFnMWU5ZXZtQVFhNzQvQVkrNzBy?=
 =?utf-8?B?T3FnZ1ZjMEI3dDVQb2Vndkl6MEtiMW0rcER1SnVDdmpEUVlLMG5NazhLZU45?=
 =?utf-8?B?cFdJUXpHa2FWcW1wZVcyVFdHaktoeUNtdnFvYlBkT0VrZFRvUGZhTzZoazRP?=
 =?utf-8?Q?BjG4kZiwO3AW7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXZtd1oyaGZYNUNuTmRpaEtpNXROMEhzU0owUzNXZmYrcmhCbUxVNHFNcEZO?=
 =?utf-8?B?UFBQYlN6MWVVbHF5aVJ4M29FZDdYSUcrRVpzNlpsVk9STVJLWkU4UEdHaFFl?=
 =?utf-8?B?dXo0L2tUR2hVRDFUaERCSGhyZzNHK1NEdDBoWmFoTHcrSHhGMmdLb2hDSU1o?=
 =?utf-8?B?WnBvb1NUREJ2SHZlOFNRQW9pcnhBbnlnNDVYbUJPb3NCSi9JUUFDUzRDdHJL?=
 =?utf-8?B?Y1Q2L0JqUklaYVVuUGdhV3ZFN2YwVUJmd29xMjhQRzFHejhadmtLY2RSdVBI?=
 =?utf-8?B?U1ZYRXBVZzhYNnplRlFnSkFYbzl2Q093S2ZTTGpwc0h0MWY5bjFqNFE2REY1?=
 =?utf-8?B?SnREY0tnaWViNE1KUG05Y2NQSTVmTUd1S2s2MnJyYUJQbldUcU1tTCt1ekt0?=
 =?utf-8?B?MmtpcGxNemE1RTJZREdaaUJXbnArRWExNERNVW9JSWdsY3VsbXBVYjFBRkk2?=
 =?utf-8?B?QWZVZXZvb2FNTGFrTTdSeHRDNVc2cjZVZkdiVXBicVNucHBaeVlYNUp6U2Qx?=
 =?utf-8?B?ZnBhck9XS1pZemtJQW14RmZIRzRncmsrdjl5RDR4SElBRmdCbjI5MTFlckt0?=
 =?utf-8?B?KytWbWdVVlcrUGJ5VVgzc0FtbUdjZEcwQ3NIbDZKZGhoaUFoWHY0YStJajRi?=
 =?utf-8?B?aEF2V3BEL0FmV3NxN2ZrMy9qQlN3dWVhOWhlOEVORWdNbUJZTXphYU02SDZL?=
 =?utf-8?B?ajV6eG02SFZTUlluUUE4RmpaS3FmYmllQUJqaUtIdzQzM2xGVjhCd1EzTklU?=
 =?utf-8?B?RGhuSVlGMSsxKzFremtubjYzRGM5TFpHMkVZRVdXQzBudFgyTjhUZElDRjR2?=
 =?utf-8?B?Y21ZNEw4S1pOeDQxR2pMdFN3Y1cwN2JlTTFUL25DeS9ibndoZXFFdXJOMExs?=
 =?utf-8?B?VVMzanBXWjZ3bE1OaXJtQXo0RVRCU0tESXFkRVRsOXVyRmN4ZFlpRE1lTjcr?=
 =?utf-8?B?ZXBSakZoZ3hYdUhLZjhzLytOQVVCV1dZMEY3UGkxeXVYdGVwZ3RlZEVQUE03?=
 =?utf-8?B?cGQ2MUpBM3ZWWEZaMjBGcGQvZStMVjI0V1RrTGh0TmwxeU01RWFReityL3gx?=
 =?utf-8?B?VFpkYXVydzhjZWdJSWpBT1U1VGRqVi8rckplUUc2U2F1UkZuZEZsdUpmQW5k?=
 =?utf-8?B?MXJQc25kemZvN3ZaK2plQk1WVHJ0SmNEUmxGZ1pETXZ0WXExZWcvQmZBR2Jz?=
 =?utf-8?B?Z1FhMnZ3N3ArUWdYMWx2cytpYXhFQ2M3emRET2RTS09uRjAyWUM4clpaRHVO?=
 =?utf-8?B?WWtSeWxHTEliTU82YVJPT1lLWklIYVkwcVArOHBWRG96L1VZQndjVFF5emFU?=
 =?utf-8?B?S2lFMGQ4NmZpcFFvL2dHNDVRRWpuTDB5cGhoSjlaRmJPZHJDUUlidWNESDNN?=
 =?utf-8?B?UlozR0gwS1loYmthVjB3WlRkWG4wNTdjajBVSW9FTEZ2ZytEbk95Q3pIUXEr?=
 =?utf-8?B?cEQ2QWx6amdyRGdmVWIvbTUrVkg4RjlGTGwzNFdIengrZ28zcUcyamF4QXh1?=
 =?utf-8?B?bFZ0REFJaGoxcGMxZE82QXJiaDZ6RmoyK21pUml6R29Ya05uUmpHNWlQak1i?=
 =?utf-8?B?NFhueGlGd0dxaVRsYjdxa1o5bUVHbkRaZEI2Z3kvNkJ5S2pJWkg0SDFLKzB5?=
 =?utf-8?B?N0lQa2F3MDFpRHk1R0lub0NRVDdLcDZHYlkwM0JVaTR5Wm1GamNKR2xqemkr?=
 =?utf-8?B?NWpxbGFOL0ZIUlZIc2JqZlBONG9nYlRUSUFMR21wU2s3ZnBSUTFBNVYvWUds?=
 =?utf-8?B?Q1R1ZURWNFliU1hKSjBDWW5mOXNuVXV0ejNTTXdKU1lHMUJZeFpOd3ZIOGFC?=
 =?utf-8?B?dkk4L0I3bFZsN2xLbjFVOG1PVGd5d3JMNW15NlNWc2tSRGNEMElxNGh3NFdE?=
 =?utf-8?B?S3FqOTB2dUxRczhDTmVJM1Jkbk9YMGZxVThMUERTc2N2VUR6TmtiRWQ2dGxB?=
 =?utf-8?B?VEdBdm5rOHJDdzB0TTFaWXNwQ0dnNXRQMFdxdXIzTG95SWo1MDl3RlBxVmgr?=
 =?utf-8?B?bUdZdEhsMm42K1hjOE5MZVUvU1gxQStLdCsySXFvenpkazJ6WVVDQU1NM0xo?=
 =?utf-8?B?ZGJuRnRPaGMrTk1IcmY1U0JscysxQ0dXMUc1U1FYeU5sR2ZRZzlWL1NoUDZE?=
 =?utf-8?B?bzFNeDFhMlNvR2ZQS2FTd3hWRngwQ0pLN1c0aURZSjJhSElXc3pBRFlkTjQw?=
 =?utf-8?Q?X2886bfbHN8j40Pxu1LKNyqgpEw5nVWgNl8+7x150Km4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lx4Z44zguKfnS9P8+Bz7c+wxc2RVhX1Lh0BtzuafLbxk2dUNrlgEoViN3joxkGIsYzt+zwBfGvx13NtaFO2mQ0uLrnajosvCMGRBym0ZSe1ybUD87S9moM0PoVyBcqRSVI2KMO9dCTJ9OTx/UFLveJ7D3nt1JxgYQ16Pt4+NQhtPrkfF7aZEB0PnvJ1uGDteymzYXha78M/ePLOMlWPY1wrhZR9bS8iHOj1tnbKHEMa+iCXQ+k9YB6uDfkop8VzmfI6Ievnbw/u3HQGmaW3cxwCNVQc/uPvMsHrzZQt7QRHM6aqnAVLfxJncdNj3z5rCadwjsJISK/pkKiiIPEz/uN7YRR4cirbTPsCnubNcqto/cpTbPCOPXgfik6Vry977iLESfoeERvh8SS3dVhsWyzJaHxix0mUVLYLCmBBb8nhQT/hfZf83VcudZZOlyplORKFoMraYerUdxO4cyYWZcdfsJesqv97qx+K5Gg3n0BQA5CcL0WcmE+w+2xvSTy5GEGQ4xqgWuRD36p8CqwGz3yhBieqUcWijaZGbhkysw+BCVN37bxgp8/aE6WhcOQx4gMkn6aS9lGL1apmiYaiWGTg8eAtfTuKp8aKzNB5jke8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd0f4ef-7b0d-4869-b9d6-08dd2c07e563
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 15:04:18.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs0/BjOB1/VlNKJEVtGB62bEpe2Ygn603RSAUJaSfOraqtWM9GlsnPSrCb7hfhnuyQwtOblwpB2OhCJnczEsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030133
X-Proofpoint-GUID: 0ZCSNVhMIshP5doL7ToBbAlYhsCMiidw
X-Proofpoint-ORIG-GUID: 0ZCSNVhMIshP5doL7ToBbAlYhsCMiidw



On 2/1/25 23:59, David Sterba wrote:
> On Thu, Jan 02, 2025 at 02:06:33AM +0800, Anand Jain wrote:
>> This change enables specifying additional configuration values alongside
>> the raid1 balancing / read policy in a single input string.
>>
>> Updated btrfs_read_policy_to_enum() to parse and handle a value associated
>> with the policy in the format `policy:value`, the value part if present is
>> converted 64-bit integer. Update btrfs_read_policy_store() to accommodate
>> the new parameter.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 3b0325259c02..cf6e5322621f 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1307,15 +1307,26 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>>   
>>   static const char * const btrfs_read_policy_name[] = { "pid" };
>>   
>> -static int btrfs_read_policy_to_enum(const char *str)
>> +static int btrfs_read_policy_to_enum(const char *str, s64 *value)
>>   {
>>   	char param[32] = {'\0'};
>> +	char *__maybe_unused value_str;
>>   
>>   	if (!str || strlen(str) == 0)
>>   		return 0;
>>   
>>   	strncpy(param, str, sizeof(param) - 1);
>>   
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +	/* Separate value from input in policy:value format. */
>> +	if ((value_str = strchr(param, ':'))) {
>> +		*value_str = '\0';
>> +		value_str++;
>> +		if (value && kstrtou64(value_str, 10, value) != 0)
>> +			return -EINVAL;
> 
> I think I've mentioned that before, this lacks validation of the
> 'value', there should be some lower and upper bound check. Minimum can
> be the sectorsize and maximum maybe 1G or 2G, so the u32 type is
> sufficient.

Regarding the lack of validation, as I replied earlier, only the
minimum needs validation, not the upper limit. A 1TB disk or SAN
storage can be connected to a 32-bit host, and we can still read
the full 1TB from a single mirror. IMO, it depends on the use case,
or we can revisit it based on feedback.?

The patch already handles the lower limit.

$ echo round-robin:1024 > 
/sys/fs/btrfs/b03580af-900e-4940-a7f8-3f04f9981a12/read_policy

$ cat /sys/fs/btrfs/b03580af-900e-4940-a7f8-3f04f9981a12/read_policy
pid [round-robin:4096] devid:1

$ dmesg -k | tail -1
BTRFS warning (device sda): read_policy: min contiguous read 1024 should 
be multiples of the sectorsize 4096, rounded to 4096

> The silent conversion from u64 to s64 should be avoided.

Do you mean from s64 to u64?

Thanks, Anand

