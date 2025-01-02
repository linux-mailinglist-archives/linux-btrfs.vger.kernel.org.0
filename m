Return-Path: <linux-btrfs+bounces-10693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D49FFC6D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 17:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA451882BD9
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DC7442F;
	Thu,  2 Jan 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fffkfSHy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jftr8mOD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA6D528
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735837181; cv=fail; b=WFepaaslB+cln0XCFrJB1HbjvYPhDQheasCv3PoYg8YlLE4EZflm7fFT28aBjulC8TlPGxxTq0nfelQgM5AQX5RLP7Gdjbp5KiBS8A6BG675cZwvQ6NESWrDA3daHN0b5MhmOgYC6uOGBUMPbenAW5W8ngN8OvmmK0H8aeJbK1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735837181; c=relaxed/simple;
	bh=7gYNXf63+Py6AsEC6psCHZyVgF+ovv96lyQGKtjaCEI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOAf06CriTUHxbakBpMS9lph9pNMoW/eB8VP2PP7gmIa6xCPu+pQKCPYvyCy9ZQBLnSJsZqzWU5LDaf0zFPbURUd/4R3ZYwcNoAGwbmhVA+E9xqFk2QZB9P4yssyFApuCIvT1PMAPqTFBK33y2jTJHoI5R3wZm5SbdphtnBmOsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fffkfSHy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jftr8mOD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502FuVlR005075;
	Thu, 2 Jan 2025 16:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4YYuISxS/g+JJReZETeiKaBqWmoH8lRGuVXpWVuGFOQ=; b=
	fffkfSHy247Fy6IFz2Vq9ouTfvWuKlhvKU5SKWjkYznJIXsnU+s7DEgKPrfwP7fj
	+S0A9aKDvqvvhzlkWQltTBJ1YMRuuWBgB56iEQLK9/1JYWnJUNufEcRmqK0Z29dl
	aQj/LUTJQ9UdDWJoaHgLC/Nm87CtX2uT672uwY16cXVxpaGkl3la0eKliYTX4pPm
	bxP7HALPD8jHC1RiqHbh32U9URzvma1bt9efytuwHCf4WamTpVpkG7q/gHe3Nd6Y
	oM+GD1r5n7kRkppzyFM+tTZHbkPZ6clHlpDnALKBgTGq1xnN1qDcfoCJLgG6tUYT
	KXFv3saXOXaLQBHxOG1I4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9chdvnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 16:59:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502GSH5W012943;
	Thu, 2 Jan 2025 16:59:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8rygd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 16:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1CSrz058eHUYkEBxLBxKUqOGHWY+8JjlkIKHETQQqok2WTVd/A4Py45WURCiQBYOebT2/8YDiEGMpT4j2MPO4sgizedeoqR5MDDrXs8AbsLoT3LA5Y1ik+iuKqWwofx5ZIAL1ZbNyURF96lm70tjI6TX7Ne/kl3TZEsNa/rArj/4qcRaWOmQ0d2KhRgyWEHQwjjzhW0IMEGCHUvZlyuyb2mRXHNlar0HBftmABe+tuoX5QxUNH7cC4p435zDQrLvIbbPFXBXozrKu6NKRpVa4nb8VewccYMz734S/cSn/qv/kZEvBcP8QmWXalbgses8Tu3DxHlt+KGwgLGlhzaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YYuISxS/g+JJReZETeiKaBqWmoH8lRGuVXpWVuGFOQ=;
 b=LTrf+v9h+BSpqxqG0IzOgcGKBsd+HD7smnOTqe/8j6fogAv6f9dklgSxd4KZCKywZ4tU/Uv6jm85iEpKzr3EDqx3eI78lEa2mn3GbbtE6c529F10X01vle2rafdMIMwwVWgah4yyF8WUvmp2arW3+GLBABN9BFRZq9ycPFlGI0E6/TFI+Lij+wOh7WwCcKJ8I5E7w+UHH8sF7GnFzITxN3MmxQO6TaBLcIOUjFA/VxmQt6nIQKPvJhr6C+91CLjDKiEFv6b681AZCIO8Qa1/oKzwKCPlw0wnmtn9hNzu4vat1qKQ5DS8sckVuWQbEes2X58MuDGd+tcnZRdPqb9paQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YYuISxS/g+JJReZETeiKaBqWmoH8lRGuVXpWVuGFOQ=;
 b=jftr8mODlLhYuL9lfRUrhMt2RQVowdN2EorleukZFPZdqXGr1aqv0jH2mtqYW76p/HdYDb9bpzou8oXSYa8Iy7ybwmMGRK1pZTkpPGf8b8x3kM3yUcRccaPMQ+WoZTRCnkweRpQPHyZ1a2qfrfePWWU1T+CExJbw8Di5/HN/Jl8=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Thu, 2 Jan
 2025 16:59:19 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d%4]) with mapi id 15.20.8314.011; Thu, 2 Jan 2025
 16:59:19 +0000
Message-ID: <42d63c80-61a9-4c53-b9c5-be8025a65b97@oracle.com>
Date: Thu, 2 Jan 2025 22:29:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] raid1 balancing methods
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com,
        wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
References: <cover.1735748715.git.anand.jain@oracle.com>
 <20250102135808.GP31418@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250102135808.GP31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::32) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 78be7e16-991a-4608-a208-08dd2b4ecc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitiU0ppQXVPaUpWcEhIbkhaek53bnFPL2lrd3NYbWdnWlRKZHBmQWhqY1RB?=
 =?utf-8?B?czRWUDVSbFc3emx2MmxTSWx6ZzlOeWx4c1VyYTE3aWF6VzRjUEpKUUxOREJC?=
 =?utf-8?B?TGRUSHUxZFdLSHQ5Zkx3U2RpWU5ZUzdwVE85TklMWExtdCtyTTBRNkRDbTBv?=
 =?utf-8?B?elA1WEhxbzJISkZVOFN0NUNvUWtqWTIzMjJUQ0RZVTJkWEliYzVYQlp5dVhS?=
 =?utf-8?B?eFg1aVd5VURHYlRaMUFzMldTc2NxV2x1Z3FpL3VTZlNjWDRIRDAvMTFhUjJS?=
 =?utf-8?B?aW1jS2FSNWlpMk9MTEUvSUxjbEw2MVUraFVrZDZkbjVhcE5LaGdvN3R2RHdl?=
 =?utf-8?B?eUFTM1NLNXM2YXp2RTFQL0k4ZlhzcjQyR3BUb0JnVkR2N3dzVlcyRmlIZytQ?=
 =?utf-8?B?VlNBTFFtQktPb1YvKzZIMXZMRDBIWFdJb0pPVzlHLzVvM2RQWlJ1QkR6d092?=
 =?utf-8?B?UnVLek5HdmdnUjJRWHRkaDN0Zy9hYjJVWW5rRGtsTWNLMmpUZENhNFVMaDBE?=
 =?utf-8?B?aVhWRnkvZDV6WFNMTzNUZjNZbmxuaGY1aHUyb1BLYjRCZVUvYXFveS96ODNs?=
 =?utf-8?B?Ni9nL3NBaDlIK1ZRQkswVXBqYUpVYWhDN1NhYWVRVCtZbzVCNWtUNGxkL3Nk?=
 =?utf-8?B?WE9SU0hiMzJ6R0ZGNDZ3R0I5dHpRQkg0VzFOZDVwbmowRkdXckZCWlRETEN0?=
 =?utf-8?B?akZoR0NTSjJLMCtSN3Vta2JiVlBhdlYxZDVEaGgrNElJZkdueW5VQTYwV24y?=
 =?utf-8?B?VEt2aDRFQTk2QnBkeTBjaU5JTTlmUUgrVnVWSGY2VXREVWRMZWt2bVNRZytL?=
 =?utf-8?B?STB5N0lqY1VWeUNqcmxCQlFWVFNWTFpuTUJEQWpFUTRmaituQlBxSXd2YVhw?=
 =?utf-8?B?NU94ZHlTOWZRMTlUZXB6dGZTaW5nNmJkdGUvOERTRk5jQllGQnE1TzBqR21E?=
 =?utf-8?B?T0QyODVGWVRpdi91bndCcE82ZUtiRHEvZnZuSVhSMVR4STVYOWNzYXdlYlhI?=
 =?utf-8?B?MTJDY01qdklaempwMWprYmpySU1DTURyYlJoRzJVUzNtTzJoV3dmVFZnUk5O?=
 =?utf-8?B?MlY4U3gwL0NydHpFNkxINDJiZTZMelcvcjlsdDRmY1htY0syTTdEN1Eya2ND?=
 =?utf-8?B?bUh2M1FBKzNFeHk1Vlc0ODRaT3U0dkt6SnQ5R2t6dlRGeTJxTUpJazByM2RI?=
 =?utf-8?B?SEk4QVpOWTcyNFUyZUdqQ0pxTlBDUUU0dk45R3B5alhXallqcFFweWU0RjNo?=
 =?utf-8?B?Q0FxbVZLSGNQKzdVMVQ5cEhsUGQ2eDdUMVBUNkxIMjAzWWtFZ1U3Tkg3amEr?=
 =?utf-8?B?VFZMYWhJSEEzUUNHT3ZSZi9QWGdrQWZOc2pFSUFOSGVmZnJOU0s0QnZHTG1i?=
 =?utf-8?B?eWhpdmRZU1FLaFJXR1hyaHIzNnRwOFdLam11Z3doQVc0Yk1hY1ZEZ0NHT0N3?=
 =?utf-8?B?blRZSVozOTFwUk9YWUw3RUNQOUFqRTFuRWhmNm1rUmN3bkJEeWlZYlRjYiti?=
 =?utf-8?B?UTE5b1ZTQldkWWMyajBEOUNXbmNDOGFGNkRKYjcxSENTNkdoanJnd2pVNUhT?=
 =?utf-8?B?S1FxNmtSMkhkcVZscldqZlJDSGg5YU1uaC9jZm41aSsxQ1JWSnNwYlJBQlEz?=
 =?utf-8?B?dmtXSEMzU2ZOVldqNFdFY2ovRmlCRVdJWjRFeC85d0o1aGNJTjFDLytSNnFN?=
 =?utf-8?B?bThzWG1TTEJUZXY1eWVRMytxa3U1ZnRHeHZsbjY0TUVoZm10a05ZZ0cwNURx?=
 =?utf-8?B?c3p1dFNQSjBERXgreS9lTjBJOFU5UkZIbmVwSmNFb3NrNEFlcUdLZEpZVU1x?=
 =?utf-8?B?TFBlWVR3S0duRXBBYmtvSkhnTVZzSXh5NU5vMUdNR3pVVGVnbFA2WHdlUUVP?=
 =?utf-8?Q?UDyJq13hqYzLx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmFzUHBWZnlWbyt1LzJJeEROTjNlODBEVHl1VGFoN1lXSXhPeSsvc2t0YnVH?=
 =?utf-8?B?Q281ZnljR3FIbmRUMlJnWjFHMjU5TlBGZi9WU3RtMVRNL1ltS29kSmtVTktF?=
 =?utf-8?B?SUVSWU1ZNTZ0RGhUeENrQ09Sak5FOXRIWERkOFgwRnQxcmdWZE85OXE3MDNi?=
 =?utf-8?B?REYvd3ZXd2VrbW9rNW4zUExhY05sNXJNRkEydktaMnN4eEY2KzlwL2Z1MFhS?=
 =?utf-8?B?OWt5djBBbU5TQ0UvakxQd2ZxWTVqQmNpb2JReFd6azdCbGxUVTVMZHpVcXF5?=
 =?utf-8?B?Z25SNlBWUHdPQ3B2UCtTNk1xMUVkd2hpWlR3bEIyRUkvekxMYnVaL3lHSU1Q?=
 =?utf-8?B?MDRaRHZONXpFbFNFNjRlbXFCKzZwdHcvZ0J5ZUNUWFFzMWRLUG1UYUg1aHRS?=
 =?utf-8?B?SWMxczM2VUdIT09hSGJ6VkJwZkRDV2lkcStxVVVYbkozVGRtbGMzZEhxaXFo?=
 =?utf-8?B?dVlldzZram9ialY5ei9aclZ1c1YxWE11TCtWQWRPRS9yeTN1NTlwbTNsUWtG?=
 =?utf-8?B?eWYzSEFMTTdmVnBkOVc0L1hSRTJNUXFyTm9CczR6UjU3TWZibTA3NVgzNTFo?=
 =?utf-8?B?Um5CeVRiNjBObUJUVnY0TzZqWm5nZldBTVh3bGhPeFc1RTBlejhIUlNoVE1v?=
 =?utf-8?B?c3BRKy9uQWwwYlJ5R3Z1N3ZVaXVkN3FReTF5SmtVb0hHNUJpaHEyaHFtTHRN?=
 =?utf-8?B?VlpvMEhZemFIUW9MbGV3anRML09pclc1eENVaFF3d25OMTlYK3VYNUI2ekdX?=
 =?utf-8?B?L1RFcnRMUFRISEdZN2VnbjVyOXNwcUQ4cGhWaHdoeVFhcWdoNkFNbWh0VDVV?=
 =?utf-8?B?TkpsLzBPSE9HVkw1TWFjODR2UGpyc0ZzNmVFaWJRQTJPWTFwWGlVdHBNVnc0?=
 =?utf-8?B?emM3UjNsRWNZbjJ5b3pPUzBCQSt0V2grTVhacTdIRCs2VGduMGIrTGRnV0sx?=
 =?utf-8?B?L3lGa0dQdGsxZ2RoNk41VGRyc01IdlI1WXFoaGNFUXZCeG4wOWVySys0LzZQ?=
 =?utf-8?B?L3B0aGZ5Q1FFN3BtUDJJcHBsWEtPVE1RV0VsRHNvdjZQYVVUc0h2N1QvbVdz?=
 =?utf-8?B?M0Y1RTRBU3dQNCt4bGFpTEhjUTErbHFHQXNZNTBzL3Azd3JMaGlna1JRdXpH?=
 =?utf-8?B?YjJPNkI2RHB2TUZ3Wmh1V2E1dGYwV2c5Z1F1eGR2Z3BzeXBhV2h6R056T1Y0?=
 =?utf-8?B?TjB5ZFhoK2RJK1Q4UWtOVzRVOFFGYXlvRHVub1Rxa0pwM3JaOThHVC85SDhM?=
 =?utf-8?B?TWd1Z3RjSlFPcUpmRHB1SWJZQVc2WitkZnJzS0pWQlJpbVJPSUdUYTc0ZG9I?=
 =?utf-8?B?WmhYUmZ3NGFqejdSY0pvd0xDTU1ZaXA2VTJqZGNqS2hmMVAwVkVaNGVEUE9W?=
 =?utf-8?B?TSttbGlnNUdwdXFBd2JsdmxFeUNyTDg1aCtLakY5WlFiRVczTkM2c0xIRFJl?=
 =?utf-8?B?UWV0QTlrcndVOFNnMGR5cXRsL2tYOUFYeFBNRU1CbGVldmE3SnY5ZzYxeVUw?=
 =?utf-8?B?SE9XeGZDc0g5Z2FybzJFTjVsb2xsWS8zTW9hZzd4R3RzZTFFWXhabXBSYzFx?=
 =?utf-8?B?NmlkSkdRcmRsVzBsdHFONEhjWnl0ajdhU2dvSXlqQzV6SkRYNGpyTi94dlgx?=
 =?utf-8?B?NFgxNjVOa0dQZXF0Z2NxdGczVjNWV3VhbjFsK3d6aStCWHZMdFYzWWpkbU1J?=
 =?utf-8?B?Z1U4WHlLRjVUV09nVEFJMDJ5bUluSXVBdWVLSmNDTVJSRjB3TDAvZ1hWYytm?=
 =?utf-8?B?OFZXa3RCRWdONEpwYS8zWTZUVUFRYXZ1OWFuMWRUVkQrT011Vng3MG1BZGJQ?=
 =?utf-8?B?QzNBZFBENEdISUpTQ1p3dTBuUng5RGxhcmpZcnBPY0lsZDRuODliY0MzWWdE?=
 =?utf-8?B?bjE1Njh2ZVJYNDVzNU03czc4b0llS2V6dmRoVTg0M1FOM1g1YngzaGl3dXFQ?=
 =?utf-8?B?Ukl3ZzFTUW1tOXU1allnYUxtMmEraUt4aVI3Mkdpa3U3cGVWOTE3SVJZOEFl?=
 =?utf-8?B?aTVLSE5QUy81K1dvanBKVEljL2Z5Q0tMcjZORXhWWU5mL0NkRjVNUjZZOUxp?=
 =?utf-8?B?VHVSWEVIN0xMOTJYZzhKZWhtVExyYm8yYXhtYW1wMzh0c0NvZnVBeTh5dEsx?=
 =?utf-8?B?cndaZnNQalNVWXZmWGNNeW5YQmVuTEhtcFdGaC8vbmswZWt5enZnZ2ZRNGhl?=
 =?utf-8?Q?yZC1/3V8LvSBOf5QZDyG7L+pkvpz/dJU15PECJwICqDH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7sbZ6n6rISVlZXu2kZhJDtidxJameOBbdwfdzwV6LsAilcwfL3Z4D9hmnqVg1QHfowkrLZRxwMDyTa/pWyqX8+VU0vMZ2ChZD3iq7TAOt4yIc4Ohohm9X3qyiosnRimhsMCQwdu8uaEvAAlszO8ZKq3z+MUg1aKd1U0eRUDQc3AyyZcwYKXn/GJGeWOYROEhFoO1tS/LqjYva6pGfRGt8r5d7yIAdr8iUftZDBTtWvqwcZZlx/EjUhqOpoMa2zTbT87+Z5OBIpdFOnAJAx6gndPTEWB1RKOZn3Fs7s/PN/sAeXjTszbLkGQnEAj9rTNwDLU58YG3NUcTaw3UBcg1dZ4PSNs7s7NvW2ZtmEY2De91RHOJfil44PLMJXAxOlOLV7Eo9hPpUBq2f55VXrFcRTSS5LHgGMtzOdmzRmgp4cpHa6GL2pTaZoI+5mqa3sVONz3EpG4YFJZGdFoNbiBM4P6wF6OXYeWte4atnfjyyik6ePJaMb7Py89C04MlC9WujQ7tVWzbuk6Z+sLBSpBamrhso5bWlyWkrMZjRfKREpoKog9mV4pdORLmShlctUshhLOiVTWw89KzTOK6N3Tbj80GxUEnBPU37F5QioxLWDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78be7e16-991a-4608-a208-08dd2b4ecc3e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 16:59:19.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiKQefoPUfnd6NVDbSV1i7iF3mZwt16Ih0UBWDoVQGSNOg6uoVX2DdKJj1lVYo07q1X+qlI8xpMr7lVrmmU+fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020148
X-Proofpoint-GUID: sSmui-bX_ArVHVxA1ywHjDex5hDl4NL5
X-Proofpoint-ORIG-GUID: sSmui-bX_ArVHVxA1ywHjDex5hDl4NL5

On 2/1/25 19:28, David Sterba wrote:
> On Thu, Jan 02, 2025 at 02:06:29AM +0800, Anand Jain wrote:
>> v5:
>> Fixes based on review comments:
>>    . Rewrite `btrfs_read_policy_to_enum()` using `sysfs_match_string()`
>>      and `strncpy()`.
>>    . Rewrite the round-robin method based on read counts.
>>    . Fix the smatch indentation warning.
>>   - Change the default minimum contiguous device read size for round-robin
>>     from 256K to 192K, as the latter performs slightly better.
> 
> This depends on the device and load and the read pattern so any number
> is fine, I'd rather stick to something that looks sensible if the
> difference is slight. Changing that later based on extensive benchmarks.
> 

The optimization should target the generic read-write workload, where I
find 256k or more reasonable, though I am unable to demonstrate this at
the moment. It's a good idea to gather more feedback. I've sent a fix
with SZ_256K and for a missed bug, hoping both are folded into their
patches. Thx.

>>   - Introduce a framework to track filesystem read counts. (New patch)
>>   - Reran defrag performance numbers
>>        $ xfs_io -f -d -c 'pwrite -S 0xab 0 1000000000' /btrfs/P6B
>>        $ time -p btrfs filesystem defrag -r -f -c /btrfs
>>
>> |         | Time  | Read I/O Count  | gain  |
>> |         | Real  | devid1 | devid2 | w-PID |
>> |---------|-------|--------|--------|-------|
>> | pid     | 11.14s| 3808   | 0      |  -    |
>> | rotation|       |        |        |       |
>> |   196608|  6.54s| 2532   | 1276   | 41.29%|
>> |   262144|  8.42s| 1907   | 1901   | 24.41%|
>> | devid:1 | 10.95s| 3807   | 0      | 1.70% |
>>
>> v4:
> 
> As we're at rc5 we need to get this series to for-next soon, before rc6
> is released this Sunday. I'll do one review pass and then move the
> patches to for-next. I'm not convinced we should do the module parameter
> but as this is to ease testing let's do it.


Thanks, Anand


