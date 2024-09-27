Return-Path: <linux-btrfs+bounces-8280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D8987D41
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 05:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F66282442
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1F16C84B;
	Fri, 27 Sep 2024 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="grYXV8un";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nxaVKBSj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0279D1
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727407122; cv=fail; b=UyQ4mvoR3cv0Ap7rmtttSVA9g0NGIjJfP82NOa6KU/uSisGOpjE5tb03VGz9x5kJRFUN75xRNsqaY/tMtF5VPOMpOgbTVs+CTNLHC8ISv0OJqfMHDl33I5RWUVxbhHZ84Bxh6cQrm0tGhBkB8b58+oBo6M81aYwYKzvAbUtyqRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727407122; c=relaxed/simple;
	bh=H1p7pmCNvXOSYekYXWjX3vWRYwl6FoDGjJBkgW+LyUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pm8ZRkGo5ceatD2fkymZ6X9CoHdDaSHsWZ91Ix1pStb6fg2K20J2nDQ9a6EkSG4JaSc6lIDd2WsoUQxnt68D2SaXqgtHJrXPJyjZ4mEIdUD9SO2r/l0750+ZJofBnkdePWJSPaA9BhoYoRuPeNbbQt0h7U1AhsvsTS744mcpxdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=grYXV8un; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nxaVKBSj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R2qdSP004202;
	Fri, 27 Sep 2024 03:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=jVhKAKas9XlKrS12v0P2B8IRdM7SC0o8mpeK0AXn6GQ=; b=
	grYXV8unFBHCO0n7T4cdaXvk9dOfRJRzRxS4zCPgSblwv0oRlaDJtz6gflygrNvo
	aPy7DrVYDAUiuEfAq9ethi3MYs/FM+fnM9ARQpK8gCLEbpkMLF2TFb3hjVN5FiRH
	I/AvOLM70wNT/rUxen7HmLYExQDDFSxCdvuR3xpL1j0sGuBC7JYX9HLA1yucnZiG
	kI3vO2p8yyOsKDKczZtLDHp3psJnnNka+8bkD8Mr1vzBnWmUE8PHv4C7nT3rosq6
	tVoi8oWavW9HFq56K8+rA5qJLfzgsWomVOPru2zsjCWDbH8n+S5s3KXYMVB+sDly
	1XL43HJVEyWUfamrXGSShQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6cm9vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 03:18:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48R1Z2hW009750;
	Fri, 27 Sep 2024 03:18:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkcpav4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 03:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EANv7jzUOFI6P8RLpj9lU+ODy7hRC4w3MfFDmh+DaF7Q4k8KVJJHcZzmfwos35Im2TCK7d/3E+gGwcPsbWyUv+KeTor2irupmOJexf2C5LSz7lOHCsZrJukXmDTt+4zqgdeBhgaKlVbR5gMEVELdsABYmEIC5gylqX1JXDWBb5GX3g9bD7VzUJtSIqseCV1e/ZHYgN76QAasuoJCjIVx76cgVmggYYD0TenyvOn8XDvDz4/CYNm+T1LfxcF6I/rUbXMLT4TDxe0LJUyxBzAXKA9XXttPTEQ1bBub2A9+NMYVERwpbNY1p21H1Mc+fa6hGw/ucbueLxXi5SCYmXmT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVhKAKas9XlKrS12v0P2B8IRdM7SC0o8mpeK0AXn6GQ=;
 b=AITpwQvqP64N7aIuGD89sJWsG9UqSOFZL1yZMfNX2uvPxDE78Y0bAEsD2AmfcNCr6ituefBKhVq1AZFf/udA218in4uT/atH5ca5pEcLlBIHOrh4VQpPmU2Rq666uMvfzNgTRpBNVZwbR8RkO4C1/92x6vw+z3NDsgYeVYe+VryzYA/hyKoCfpLBpkxiOaWIf+N4Zn0tNb/nuiBQhaTBlm1Rla6PNPJJTVKtio8egaGKI5i7z0NYadkTZgOnr3ngsqKQ6C2Ni+BhvQCyXAvonD2m0PHSzQ/F6XR0lKvbeo+9qpsWKnAzZ5uatVBWeSxsfpyHRlcUuKErH67eaUbwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVhKAKas9XlKrS12v0P2B8IRdM7SC0o8mpeK0AXn6GQ=;
 b=nxaVKBSjIBHZ8tqe6xJywNxIkskh7ksiSn366OdwPtxIVYGyFZA6JGuq+q+kZb9zLMCjSqWwXTDexwRnJKYFlwnf3IMaAFr3w8rt4xuQ1sAaEmNPIOKlIKFF6QzvpDCAbzherg9uqZaepRH4rv0bumOEpU+wRL5esep63HcwWuE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7183.namprd10.prod.outlook.com (2603:10b6:208:401::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 03:18:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8005.010; Fri, 27 Sep 2024
 03:18:22 +0000
Message-ID: <2133219f-09d7-45f9-9c81-e4cd44f78c82@oracle.com>
Date: Fri, 27 Sep 2024 08:48:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Round robin read policy?
To: waxhead@dirtcellar.net
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <87c646e8-c27e-6853-feaa-38b480892d60@dirtcellar.net>
 <54cf8c1c-b333-432c-bf37-0029ba0bf0e4@oracle.com>
 <330190f8-b421-82ae-5819-69707eb29745@dirtcellar.net>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <330190f8-b421-82ae-5819-69707eb29745@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 3472f562-3a9b-4ae2-99f3-08dcdea30ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEhoV0ZJK29DUDdSQm1Yc2k0Szc5NllhaWdtQ243M1llWDNUQ1ozb0pTci95?=
 =?utf-8?B?MjI0Q1duRUhpaXBSdStUZm5sanF5eGZYUnZJek1xaHJtQW50aU9NalFqNWU4?=
 =?utf-8?B?OXFUcWZBSTVmNElVb1FJcGZRaTRRQ0xBemJ3Z3Y4S2FaVy9YbnVVdzVoNmtl?=
 =?utf-8?B?YW5zQXBBUUFMVDVPOFRBbm4vaFFkb2pIRkd4Q3ZuVkpWUkFheTYyVVh2MG9s?=
 =?utf-8?B?a2M1V2tMVjJScnZkRU1NWGd4b05QTnM2WnVjMVVlemhxNkZhY1NLRDFDSXlY?=
 =?utf-8?B?enlMTEZ0NldJS2lEZUdhdmN5enMySW5hbEFlenh1dlhPY3RHWkRPMUpMdW5p?=
 =?utf-8?B?UmpFM2NYMGFWeStYeS8rWEZERUtIRHhlWThiYlloUlVWSUpTRzhaWWVrdDJn?=
 =?utf-8?B?TVNxVlUrbEhhQlN5ODFXRE1rZXVVVWJOaExRTXFmUlZNVi91MmM3NDI0MGZC?=
 =?utf-8?B?Q0szT1lvdVNpclZhRGxTWDg2WEhFUC80NnZJelhyNlZDamVLejlmTjBzTW1s?=
 =?utf-8?B?VEFWcXFSM1REMG5oVkt4S3dhemlXUUVRWHNqQThOZTMwL0lDTjh5TjBYRmxQ?=
 =?utf-8?B?QmtLZGdUN0lEN21GaGF6K05uallTQjlRdFBSbUdLMzZsaVhKUk9pc2FQbGIv?=
 =?utf-8?B?NGRDaHpZOWFzMW1uZXRhOExtb3JUQ0hORi8rcVFzVkpycVJwMElrN0kxWThL?=
 =?utf-8?B?RmJxdXJlZ0pwWmRqNmZGcFQxRCtEOEszNDRidzczNU1hZXNoL0trcWRuQ2FT?=
 =?utf-8?B?NDdnd0xGWWdlMys1OGlOK05LdFR6aW00MHdyRXI3ZktETzgzcEdqK25ZZ09z?=
 =?utf-8?B?WHpqeFo0UlplQ3RPcXo4UGg5dWJOd0drZEErNGlGRU5ML3pUWUVkYmhWK1Z0?=
 =?utf-8?B?Q2pnUWdYeGdjcmprYnhRdDI2cXZEaHdQeGpHSDFOT3FBUmd2WG1WMXpTdHB1?=
 =?utf-8?B?SGtzaHc1dHRXY0hvTXVkQ2RHU1NOTlFEUUl5V3VpeVdWN29GVnBmaUNBWHpp?=
 =?utf-8?B?dm9LcklVUUZCZXExb0RwVHlvbEhsZFBzSzREdzZydHRpc2xVYWdZNUFFRmxM?=
 =?utf-8?B?TVVjYzA2T2JsaEt3SU9LVmtDMW1CU0JXbitPektjRm9Gb3FrOGpkaXdPQk1r?=
 =?utf-8?B?bCtpS0s1cnFQSW1IdmtNNXBlMSs4VDJZVWliR0FnNmpZNllFcVIxSnF5OXlj?=
 =?utf-8?B?NXQyZUVIY0JOb1VUWndOYmI3Szd1RjdjTG1lV0ppbHZMaXZVVjFTcWtCTm9H?=
 =?utf-8?B?VVZaRVA5N3BlMEFTN05iQ0swcmpnUXlwWVhXTWtlNVV0NWxKWStLTGRld29W?=
 =?utf-8?B?VjY4VDRCeEZPdmxZMC9tb3hEcy94VG1hZTNSVnMvSXB1YUxKRzZxWG40b2ZE?=
 =?utf-8?B?cTB2K2ZiMkFhUk55MWQ0RWMrOXVjejJVUi9heXJ1Z3BDaHlnalZiWHB2U0hP?=
 =?utf-8?B?aEdpR2lhL2JYa2dFTEsybjlNMm80Y1l0TVFmc1Q1TmpTejVBMHoxcVRzbWpJ?=
 =?utf-8?B?Vi9FL2xBM0llUHRiUGkveHBjVXp4NS9rbkZqTXJKT281WGV6L25CdnRmZmFO?=
 =?utf-8?B?NEx2bHZLTWczbHFKcW1hTWFDN1BtUk9RVlBEZ21IcktiL3MwYmk4eisyRG51?=
 =?utf-8?B?YkVtY3JOdllMSTVWaElJeDVKMlhxSHBHSng0MXlwY21yU3JtK2szM1ZCSFNF?=
 =?utf-8?B?QmovYmlhTUdxbkNtZk96UFpVR1UzazBIdnRzTUhWZUJBcjRkUENFSGQxOGUr?=
 =?utf-8?B?eGVocC92YWg3cktCR0YremxYTktqY3J3Tkg5cy90eVhXL3dKWThkTDBkWFdj?=
 =?utf-8?B?endHSjZmVFpIV3YveGtOdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW90U2cwSkUxOXVleVNHdHRFZE1wdEl6N2FvelhTMnBiTDdreVRCc0c0TXZ0?=
 =?utf-8?B?Y0ZkWkRsblZ0ZXhTZ29wTDgwbEJhbHlWUHMrWUt6cmJaSkducmFUekhSVkdI?=
 =?utf-8?B?VC83aXFYYTBFc2t0UEVrRnpSNjZvQnZ6d1l0ZGZ6WHJPd1FFc3RzQ0lZZTV1?=
 =?utf-8?B?YTFncjdoeFVpN0JFNTBEbXdzUGk0M0tyNTl1RFIzVklJVEhBSkRieWZlT0Vw?=
 =?utf-8?B?Wk1keW9pRkxKZjhuMEZCaWVjbC9hVXB4NDZuaHY2ekxlcmxDYVlHdVc0MTRS?=
 =?utf-8?B?Nk14TWdrUHNQZFJjRm9xTiszMTJjZ0Vlcng3WG03TlVxeFZLRFpFcFNjTTJO?=
 =?utf-8?B?ZDUwb2p3ZllNVms4TU91VDduMzZoSjZNSHhYRmxOVWJrb25kOVR0RzFwU2hj?=
 =?utf-8?B?T0ZLVFo4OG1FS2dGQmt4WXhIYjRtTjgrWG5XUFVqMUwrTGJXdE5nNFI5NHdG?=
 =?utf-8?B?NHprcll0cUhkMnlwbW1PRDFsV3U2ZUtxMG5jdkRGa3JNNHZHNkNwakZpR3VG?=
 =?utf-8?B?OFBSZDgybURRcEllSWF3d2VGTVpMa0VWbUtqRG92U3o5ZWZvT1ZrNGlqZ3lt?=
 =?utf-8?B?Nm1TSHVGSVRNdTllVmpiWjVEeGhwenllc2J3a3RtaTNQUCtHcnFnWmNVVWwr?=
 =?utf-8?B?WG5jcm9zS2tZa05MYWhwcmpEYW5CbkwrZnE4M3JZY3VCcmJUcDJsNkhRRmN4?=
 =?utf-8?B?NDZxVDlZbzIyNVlGakNxNDdkZzB2QjYvc2JUb0FFbUd4ekVhWmxBSWhtME1H?=
 =?utf-8?B?aUdYM2R5c2Ryek84UFltQVJIbHU4SnRqMFpWUEl2c0FWS3EveXEvdExBK0cx?=
 =?utf-8?B?SWtuMUVsNG1sbXhQZHVmUC9aREpoZmFlR1VvSlBadjFKbU0wNzB0STczWFRO?=
 =?utf-8?B?MG4wb293QjBncjJORDJHSU9DcGk2YUM2NEN6aFl1eHBSc0k3anlTNFl4NzRQ?=
 =?utf-8?B?SXoxaXFEUVBPZ0lHU1hNR2lpQmZQaHFYK3pMc2E1ckx1QVhieGVwRjUyYVo3?=
 =?utf-8?B?N01CazZDSzUvdXgvdEZ2U2l1VW4rNzY4RHNFdysxTEVmRWwyNTJFQk5RS1Ra?=
 =?utf-8?B?NWpHbnlkcktldlp1Zk1MQ1lTNWNJU0xkblBqVDkrTVJZRWoxQ3QxZTNMSFR4?=
 =?utf-8?B?UHc1d3dlWGcwZkRIRVFCVnpVeDRWVFI3RjQ2Q21aT2Z5MFpmcjg0NUNiVjhJ?=
 =?utf-8?B?dC9MTlVmZVEvVHBibFhEZjRvbkQ5cEhMc01aSHVYYmwwUzRnaG5qWXhOYnlq?=
 =?utf-8?B?Y1NKd3JjVVp0ZjdlNjk1ZFFabFAzN2plYWFhWmRTbEtybzdzTkt2a3FydHhG?=
 =?utf-8?B?ZXNRMXI0UkVPQUJyUUhPWlRnaVNOaHlQejVaOGVBZXF6c2tKM281YWIxcS9l?=
 =?utf-8?B?MDlPM0hNSVJIWXFWemRWZ0pCMEpMeTh0ZHlMU1VROURsRjRJbWFRRkpsenhH?=
 =?utf-8?B?T3JrSGozczBucXowQThLYkhKSlh5TWkrZUNBWEJJYlRmNVlyUFMwcUtVcy9R?=
 =?utf-8?B?TkRtejFzeW1IMytPZ2ZkS0NSR3M1OWtIQkxxVkVhelpiMHRCalZrVWovb1FH?=
 =?utf-8?B?c0ZYOTFycnZId3U0Y2tMS3FCZlVKdHhpcmhJcndhRDYrYmpqaEZiVmxTQUQy?=
 =?utf-8?B?aVFSV1hDQW9jRitmYm5kb2c1bmJzMU5hYjlFWE5JNkFLeHdpZW0yZFZWSEJJ?=
 =?utf-8?B?VlM5NXRmL0h4dldwdGtaQVZGMGpUb3JlRmtuM243WWM3MVNYWVRxSDVxLy9N?=
 =?utf-8?B?SkhBZmg5RlpzRVF2QmRDSjFsbVdHQm5uRFhrS1IvczRQVlRxdzBlMlZtZlVV?=
 =?utf-8?B?cjZVNGZWV2R5c1RCenZpTFlVVzdXdm5ReXo2R1JpcGJQZktSNVlDMCtqdDE2?=
 =?utf-8?B?ZFU2cFN0d25JNVo4U1BjeG1Pd0RWRi9NOGRlOHRNeGpER2U3cE4xb3kvRFFx?=
 =?utf-8?B?cDhxWm9MVXRCYUpkY0hxZnRWQ2twRUczdmMxckR0d2srYWtLL0JiUHVEaEEx?=
 =?utf-8?B?Rmp6Y2o2WlFEZjNSNHY5TUNwWkVGS1BlamhLMENFUWRzZDExOWFDMk9sWDV4?=
 =?utf-8?B?RlJaZlQxN1ZaZysrSXI3ZXJZcHl5R2FMNG9Dcjc2K2diQ2xXWUQ1cXZKeHE0?=
 =?utf-8?Q?Oap4s94bFtHl90sQejaoBSQbA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jYILU97faDvG3qPm1erZg0XkTElhotrz6TElOZfTOkyWe2VBhgVJCJlaQxw/A2tFLdBazAYAJ1nnNjVJ1TprFpUtrq2V08t2D69wuzla0jyR6lfBEnpFYBJyyQiCnNpsn9esdjXI+GXDxPjyUlOvXbC1Y++sjmqS9UNPKxn9S4KDrfCCqSi7kYd2mBxgBo/XtR+8lmc2Rwy5U/FWCgIszBKy0B5WJiUhAnnXLNSTQ/S3S/9MNTZABUj4ScIsa1TqRC+OdZWvmQh0bkgC8hXUtYV55wk4btx+qjRRf9g8MV8xpbPWb8mWQ/G9LSmG6vGQFnVbj3LSsGDxV1wpv/0UGn1TVeRalS/989mxFlVJavG4mG0EFnMZSlw6MR5DQah1PZyuD2A/mFw0CsuZeTvKJ6GoZdsSJA7tjSjuKeES6cKXzZWa8+ex79i7ZjxvHLqCTpQ7Wksy6ww0KoNysda9K7Rsba3doc1Yefj4pAW5yXigZwQO1kAHpd2h1zOa1N+baxlY0tWx3sFE9MwieXo+4hXEtmglP8bYavhW4X8JgTGo/O+pdGoTGB8tGoBGxfexi2Xw4ksbbp0TMPkE3gRMA4fq0G+9ZA1CYW94pBIfIOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3472f562-3a9b-4ae2-99f3-08dcdea30ab2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 03:18:22.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4vRNfue2K/l0249uI8E+KdwA3VYvv0htdpsMGubh3p5DbxJ9VLMy9ooB6SMI5VTR/ITwIq1T7cZKz0pD9RnNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270021
X-Proofpoint-GUID: TPynXiXIg-p96AhKc5Cl4fuPK3DVwVTy
X-Proofpoint-ORIG-GUID: TPynXiXIg-p96AhKc5Cl4fuPK3DVwVTy

On 9/8/24 2:14 pm, waxhead wrote:
> Anand Jain wrote:
>>
>> There are patches for other types of read-balancing already, like
>> round-robin and commands-inflight, and there are also patches
>> based on dynamically benchmarking devices—some of which are in my
>> local repo.
>>
>> PID or round-robin perform fairly well when devices are of the same type
>> and there are multiple threads generating I/O. However, this is not the
>> case in defrag, where there is only one thread.
>>
>> Neither PID nor round-robin helps if the underlying devices have
>> unequal read performance. Both methods can result in lower read
>> performance if data is read from slower devices.
>>
>> Another approach is to benchmark the devices during `mkfs`, but this
>> lacks accuracy and carries the risk of performing unnecessary writes.
>> Good read performance on some devices doesn't necessarily translate
>> to good performance for read-modify-write workloads.
>>
>> When trying to base decisions on the dynamic performance of devices,
>> earlier patches became complicated because we needed to know the read
>> performance of devices at the block layer. Calculating these performance
>> numbers wasn’t readily available, and doing it in the filesystem layer
>> was expensive.
>>
>> Finally, I tried basing it on theoretical expected read performance,
>> but the necessary information wasn’t available, and it seems that
>> those patches were rejected by disk vendors.
>>
>> So, I concluded that manually telling Btrfs which disks are preferred
>> for reading and how to allocate metadata/data chunks is a better 
>> approach. And balance reads across only those devices.
>>
>> Thanks, Anand
>> Thanks for the (much needed) recap, but my question about considering a 
> round robin based approach really had nothing to do with performance at 
> all. In fact lower performance is perfectly acceptable for the reasons I 
> described.
> 
> ...And since the topic is interesting (and I am getting carried away a 
> bit) - if a performance oriented read profile is to be considered, would 
> not simply maintaining a fixed queue length (and/or size) to the 
> underlying block devices be enough?!
> 
> A fast device will clear its queue faster and therefore more jobs gets 
> assigned to that device (as you are trying to keep the queue length/size 
> constant). Likewise a slow device will take longer to clear it's queue 
> and less jobs will get assigned. E.g. solving the need for complexities 
> such as performance benchmarking / dynamic magic.


Thanks for the feedback! You’re right—read I/O balancing can help beyond
just performance. I initially tested with a random read-write workload,
but after your suggestion, I tried it with defragmentation and saw a
surprising ~50% performance boost with the rotation method! I’ve added
details in the patch cover letter.

Regarding block device queue length, it’s usually set by the vendor,
often around 256 commands and depending the device performance.
Our focus is on reducing the estimated wait times for commands by
balancing. The block layer also optimizes queued commands, which can
improve performance depending on the workload. So, it really depends on
the workload. Maybe at some point, we will have a mechanism to balance
dynamically based on the workload.


Thanks, Anand


