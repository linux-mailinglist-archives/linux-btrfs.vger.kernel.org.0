Return-Path: <linux-btrfs+bounces-11542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A3A3ABC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 23:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AE6188B060
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A98A1D934C;
	Tue, 18 Feb 2025 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcAyVqJ7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NxhoJl6R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE31CEE90;
	Tue, 18 Feb 2025 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918225; cv=fail; b=tLVkcQIwGMGtH00Dq9SiyzglYzB6xzgNtPPS7rC/nd5fzWqAKkL/f9QBkurnHZh3a8zr2XpHP9VR+jPj2paVJYXHs63A+l+jaexb1Q+SO5HkSFeNeiVghZX+XMcs5wWhKVze+8hMZpGrnBegB2dnyVKVTevRfUR39VTx6S3+j08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918225; c=relaxed/simple;
	bh=yTV3nJ/sujZMMGDye8+gBwBhQEEGHbs04xOpZY5Dgw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LJjOG11sUuSdAps8dj2IZik2kq9uiS/tjQ1yEnoIEEFqkp67kEttUURGzkEhW2xUaK3S3Btkv4Yhw/bTIM72V7vtDWEgLDXTcH9d14PvHj4a3rNUBP/kEEvZZj532F1mBzks8lBa/BWKbZhyZDikpdwWDyctO48WlxJ5EN5SImQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fcAyVqJ7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NxhoJl6R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IMZ9x6029522;
	Tue, 18 Feb 2025 22:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MKrhf4f+uIhu6RfvwBCwSDQ2lXd3YSAnP7ZwnT750yI=; b=
	fcAyVqJ74DjJf2jl86hOcV2kio1aoWJ4udcFSvcPDV8P5t7cjKjSKvMLGRdLx45v
	Wb1IYlTChOfWGX4chKBi8NfXSIlKJGxARwzguODnL166QyDx+WcIwgUA6d7h5Pos
	PIlloiyYy31ThU2aqaTKqf3UFs0/72ZUXh8SqS2u07w5Ncq6tXbJ5C7pZfv1R/Xg
	9oACeVdsmhFeDZg0po2sDEvA/J9Ytcg7Hcrwq0I8pHf40d5rj51BGLn2KEp+AIZ2
	SrWIGzCaIsDP1+MWGFgWd5OWLsXjwjFRtcRqjFCTyXxd6ANJ3eHfoWEKMC6TKpGr
	+UMsvPsRhgw6L3tVvKPwVQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00ngdvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 22:36:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ILmbZw026248;
	Tue, 18 Feb 2025 22:36:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0sn5jhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 22:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0LgzpIKrYDi+bL06XEbGr5YnnEY3QUQANMv6OzLzR3dL3zyfw7bXXoOHPNnT6LwHS4+B4MnAOR1tRF2bufSeS/TZTwizJ2/jNWHBtd1S/OsDWakzzYWtSW1zuY+xiMbWZVd7K08cCaLkyg3dhQXFbKz4HJiycm2eBo1GbT88hb2YRPc2dqtxfDFtOU0e8AHyt7DvrYF6cixq2SJYY8tNhGq+JUaeytPVysA8EmgR+5vCo60nL04jR6IeQ1/nitPz4u1n0HV5j5G/DdcAf4MXZ6tPlvxVXSWdgSmmzIq+lFisO4ZkPQ9XxEGqZNhDnRePoKbYHOvL4CSTPqzE80v6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKrhf4f+uIhu6RfvwBCwSDQ2lXd3YSAnP7ZwnT750yI=;
 b=agnHjGdj6H3Py41XgjkQ1eBbz7j3oyAFManBQ/UCTPCfsgH6kvlfNGqDffd8A/U20jDMbqqudJ/IvZ8LbkmbtYQ1BqbH/DrGfR0138H+d+dbfYmmFd5yISZCZ9O9/ReW+sS3wAYuUHcCilHnBlJDVo8kAIiTOw1hd4Vc8jGIwnZk64k/mN3xEbqNfsYUQXXzWgzF+1xZJqx/QyRXr7Ka2+yC0b+kUJOLr9A8NSJ26XlOvVgCvS67a8reEX+0JiaHoNEhTVhR9aKjbpRVFDRpl+5YchSuc3QEbiwEcIjEA8mvhF+vhFLTT6fBiSgrK9PyXI6j8VCkE13u4+JfSZwbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKrhf4f+uIhu6RfvwBCwSDQ2lXd3YSAnP7ZwnT750yI=;
 b=NxhoJl6RTFvqnIeNLcgbedEWZlhGTNDLq+QU9zeVnaiHXXz945Vjg8pIdI6+A+h9EO7QHltzhdz2k0dYnrzyjSTmsWsDLGPC2TDqJBFLqBOwhDaK+C+IXiyDVDO4bZDoNdf2BnBoEGZ813zFkvFelGokxSxAQmBDJECBS3MOhpo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 22:36:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8445.020; Tue, 18 Feb 2025
 22:36:54 +0000
Message-ID: <6b6d1d8f-0803-4657-9637-24243f0335ee@oracle.com>
Date: Wed, 19 Feb 2025 06:36:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for master and/or for-next
 v2025.02.14
To: Zorro Lang <zlang@redhat.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20250214110521.40103-1-anand.jain@oracle.com>
 <3b2a541f-da83-4658-a47b-8b8a1ea75b83@oracle.com>
 <20250218035111.vkdtzkjskutvpvqa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <5b0f6e62-128f-4410-9b45-90eb70b8f5e3@oracle.com>
 <20250218131407.nqb5dasvwqozvs2q@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250218131407.nqb5dasvwqozvs2q@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: c75fde23-f7ab-420e-3e6d-08dd506cbe60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmVkZkZoOWdCWksyNTIzblpXKzhpNER1K2FpOWhCekFUdy83ckVVOU5BSmdt?=
 =?utf-8?B?bysxaENSYzJ1RUp6TGY2Q3RGVnB5UGtudmVsVjlSaE9NR1BkWnlVVjV3eWlq?=
 =?utf-8?B?d2hLdzNheGZWTVB4Y1pUeW9NMkxpOEVwUHBkNXB0Mk1zSFhSTDhyTmJxdk1X?=
 =?utf-8?B?a0wrQzJYM2VUSG02ZjBRMmdHM1l5NFJWaEpJUmtjc0U2RlVpU2xlRFJPTW9q?=
 =?utf-8?B?VzNjK2xEUVlzYjFVdlh6dnViSnpZYlRpNUdPcVlydzZiNlFZaVFuQ2tLT3dV?=
 =?utf-8?B?UHIySDlyRWlvQVRqREtNRHZpbmFHY3cxQ2ZXOS9zZ09PaVZ5NHdxRHdZMVli?=
 =?utf-8?B?eUFnSEFWMTFrWlZnVWtnSXlrY3F0bFVlYnQ2c0JJQ092RG0yUGZmTTZwUlMz?=
 =?utf-8?B?RTVlbXloQ2h5cDZWb21BWkhWZXR4N0tGNUc3R1M4R0VVc0pUNyswS29Hc05i?=
 =?utf-8?B?RklCaTRTcTRrRmVJZ1NuSVZSem9NbitKb3lVYzZxdW1Rc0MwcVZpTHJZd05a?=
 =?utf-8?B?VTdnMVZ0QXdZTm1ZKzBkUStxNGFPejgzNHBBWU9GbE1HOE9Pa1FIT0dxTGRi?=
 =?utf-8?B?Y3d1cEkxUVczL1E0VGFCbHY3S0o5bzNaS3U5Q3BGMEJkcmE1Uk1QOEpNdkFy?=
 =?utf-8?B?NW1SQW5uYzVLUE5ocnFWSHR2aVB1dXhueFpRcDc3dld3WjQ0aWhOaGN5SkV2?=
 =?utf-8?B?TkdqZnNIL1pOYjQrd3Z2bloxa3UyT2I1L2RqVk9aRG9WNHBLWGVCWWlqN1VM?=
 =?utf-8?B?WUFGd0FQR25SZG5wLy8xR2d5d2JXaGJZWTRHcFFmMW5GWDhzNjBGd29SckFY?=
 =?utf-8?B?YnFRKzRPcUNpbHVpU1llUVFoZkp5V3dVWkc2NitKRlBEYjVVVkVWWkxydzgz?=
 =?utf-8?B?ZDF1eDhWUTd1M2VJVk93VE9ubzNyc2MvV3NJVHZJMnIrZm83ZUROSTVPNmRU?=
 =?utf-8?B?aC9tTG5VRWVlN2VJbGhsVngyVmZ2NTVrVjRGdHFyQmt3SWJVMGRHREoveDJW?=
 =?utf-8?B?aXMrMW9DRGtFVlBtY0JldTRPN0tjM1dJWndMY21ESW1Jd09QTis5dW1rWVFk?=
 =?utf-8?B?bVZyUGthTkt5ZVplK2trZDJ4endIYlJyZkF2L3FrelBZanJjNlhqNmJ6cFlS?=
 =?utf-8?B?L0xLOVhhUU1hN0k3b2UzSkcxcWN6NDhSdTBOVnRDY1pFT1R1eFBKUmZWeGZs?=
 =?utf-8?B?Z0RadllsTHdST243MWVHcEo3cnZuM2t3QzJ2Zm1Hb1FaVGREblJNY3ZoTnBT?=
 =?utf-8?B?MHdjWStzTGtwVHIxUEIrRTU1NlJ5NVJvY1VEd0ZmYkJVNGoxVGU5aVJNd3pz?=
 =?utf-8?B?SS8ram5vUmNYZXdQS0grTHJkcjkzU3AyZERoL3V6NndOaExlL1dNV0RXZEJC?=
 =?utf-8?B?NTlSY0FiUkg5MW41cSs2VGpjcW9iN3Uvak5DYzRWcU1RSWlxWUxpQ1J0eUpU?=
 =?utf-8?B?UFdrcWJKMVJJUTdqUm1LdTROaGRVTVNISjgyMmE3cy9WM2hPeVNDNUc0NWE1?=
 =?utf-8?B?QWR3TVdXd3BKWHdpVlBWK21LTUkza2dpaVJQOThPZVJTaHlFUGpyUHVxT1ll?=
 =?utf-8?B?ZFpZT3psTnkvbThxNUpUcjlDUHpxRU0wNEJBU3V3U3NEMVhmUWVybE9rM1Vu?=
 =?utf-8?B?S042eGsvSnVtTzlQNjZPSDFLMTM1aHQwQWdQM1ZaTlIxU2FJSERGdlZDY2hG?=
 =?utf-8?B?K2pIdS8xa2ZIWnUzUzMrZ0FiODU0OHZ6UnVpemZCVU1PRXhHR1pvMHdvTHJs?=
 =?utf-8?B?UU5tR3hDT3J0UldYeHc3QWlxclpadFRzVlBLeStaVmZNSVhUQ0pEb1AzSUto?=
 =?utf-8?B?ODBXMzFIUFdMbVBEZGRPUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0VXZlVRb0lPSWFoQ3RxRTQwclJ3LzROM0pObXQxYU1pSmgzT3RCZTdZTFNs?=
 =?utf-8?B?bXJVdW5uYXY5M2lpQldPYWszVHhqYk5MQmxWTTBOSE42YjlWczQxcDBaSTZE?=
 =?utf-8?B?Q1NxSFVnbDh6RGZjMkNjYy9UTWZkMXR1cUtEL1V2aDAweldUQS81dWczSDc5?=
 =?utf-8?B?bHd4QmN0cDZ2M3VEQktFdnV3NlMvc0QwckNqS084dC9jaEwrWTc5RzExRmVN?=
 =?utf-8?B?M1VSTlA4NjFkNzBKM0ZPbkxlYTVCT2J6c3VJa2wySVZ3Um9tMS9pb0F5dzhs?=
 =?utf-8?B?UTNKVXNPREw4NzZwUDR2ZnMxUCtlWDh6MzNYT1dTUVdXL291R1JIQTZmR2E5?=
 =?utf-8?B?ZjBISVNXSnlKcmlVUjJ6VGJlZ0t6ZE5PT2dISkZEaHJLVTh4bHQyU1JIcFBR?=
 =?utf-8?B?UGNkdVNTWjFjUmI4ejBHMmVMNmNicHN3SVlGWVJuaEdYZ1RoMkpJdGt3STh2?=
 =?utf-8?B?QnVMRFM2QVNSWU0xTnZFaDN3Y0RJMm5XZ1lCcCtNeFJTZXl3UlFBQmNEaDJr?=
 =?utf-8?B?M0c4bzloRXRwYlR0c0FWOTd3bkF0UkdIY2QvTkw0VkVOUUltaEJMY0lzNVcr?=
 =?utf-8?B?NEZtaHVxZEJsakg4K01GaGM3MXM0YXhRbEt2dFdzK1BmWTYxMzNJdFRxSzdL?=
 =?utf-8?B?L3hINmt5MUpIc0dhTSt1elpiTmZTZDRsdnU0NFVMaU5TRXhrT2ZvUThPMzhU?=
 =?utf-8?B?cS83SCtZU1FZOEFwcDcveGIyaXN5UUN1Z1drY1JlcU5XK0VoeiswZk1jMS95?=
 =?utf-8?B?ek5ETVBlVnI3Z3hyOE02a2wzQWFOTHM3bWNwcFV3c0REL2NIRXIwTEtHNFNZ?=
 =?utf-8?B?amF4TGFsd0xhdmQvaE8zbG9OejNweEl5UEl3bGRZU0oyeXlwTXJKcXhZTUxJ?=
 =?utf-8?B?NFh5R050V2UzK0JGc25iZlJXU0J0VElqRGxyQUkycFcrQzczdThRdjNjdm0x?=
 =?utf-8?B?VXZzZ0R4UEdzb1ErNXh6VVB2TFhYaVZTYXRoSmQ0QUJDY3UvTldDcC8yQnZp?=
 =?utf-8?B?alVsZTJDSFRUdTE1QnZXV3dhQllDRTQyeVRCNzFOcVUvdTU2ZDFXMlFvdzV2?=
 =?utf-8?B?cFg0MGtzby8wT3U5ZDFMbkJZWC9SUU9NZW1tTmNhL3dGZFFVR05PZFNQa3NT?=
 =?utf-8?B?MTczN1pwVExuQ2R5eXYxSlJiL2twMm12Zmp3QXVTN2J5L2kvU0hDbG1qWXhq?=
 =?utf-8?B?am1qVDJRNlptRmdBYVFUWEcxa1IrSEZhNzMva2RBTlZ6S1NCRmVmZmpWbURS?=
 =?utf-8?B?Z2drQ3Z5L2NNR2Y4RmtTSTlnWnVvSUlJc0NGK2VRemRxZFlLWnNHblpaY1dM?=
 =?utf-8?B?WjRmcFdWYklKNm92em5PeUQvYVVHeS9Zb3V1WGFGYktEbFlPVnJYcnYyUmxN?=
 =?utf-8?B?V1FNT0daVjJweitzbEkvUnJCZmpueGQyRlpZK0pvYW9TN3U4QWNRN2tYc2Fx?=
 =?utf-8?B?UlFwb09rOWlwVW1xdENoK2tTQlhzcHJjSHZwNDlHRUg2SnFxMGdtYnFTYXNl?=
 =?utf-8?B?UXhQNmdIc1JYNDZNRUJnL295QVdTT1F4SWZrUzhBSHNZR0hXTDczbWZnUDk1?=
 =?utf-8?B?dkZ4Q2JNWEZwcHhZVVNyU0cxWkh0cGJ2dWJTSTdlTEhudkhuOWRiNkVjZTB6?=
 =?utf-8?B?UGVhdmhCVVlMb0p1NHZEVXhwRHdPTXplL0VuZkFYcTNyTFdnaTQzNTlHZnZO?=
 =?utf-8?B?aytlR2pJZHIrV0p4VHhJcHJFbzZCdmFqUDJDSzNZaXFadGZ0VktLWFpaU0F0?=
 =?utf-8?B?MSs3Y1VES3NRSlFlcTJhbWUwdm5rKzl5MXdMSTI3Yzc4dXNhTURJcmFpU3RF?=
 =?utf-8?B?T2d3N1VOWkNFZEkvSU0yZEtnSTdWbExpODVzRmN5akFSUGFRYzAvVE9EbGp4?=
 =?utf-8?B?TXB6TXB4Z0lrUlhBdVVzTFNZcVBVbDVvYm43STlESEc1VG5oRmRSTGRWclVT?=
 =?utf-8?B?MWcxVTBMUWM1cVR0OEt4NDF2cGwvLysxaWEycHBCU2lDUXZ0QXVPZmplU28y?=
 =?utf-8?B?ek9mVXZZZ2E1YVZGdFRoZVJ2ZHNZUW5kZ0U2eStvNDQvRmp5S1U1djM4NG9T?=
 =?utf-8?B?aXljNFA0bHlrblhSL2RUMHhVWTBoNDNvdGVWRW03ZUNFMFV3alNMNEs1ditw?=
 =?utf-8?Q?ecWEoZRAg7oj6UFqterZ6PNRj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0vxwFcnMJm7PuE0AMQg3Fl6X9YcrqOA/QTQOCPMcdzimsutBJw7gSNyeUsCc38Kv6XQ/fS927S7rrTsRM/5FrApIbWIRJeOl1WRFLFGOPLRYBll7cO9xPusRCtSgys0EGJ1pG7KU0JbbR7UuGzPcKeG6DNNalTbx49N+cKgEZKfS+pc5+D/Au9GMjOCTvk4YoQgDo2s4sNnYrKHfRKl6Y5tspdcTAE/Ymy8r9muCUOAelaV/RJza7X/qaq2+zIxAIwsVKmEwyInaPamaCeCIr8HwFZ5jrsGrrguF9/9jRSNAGZuDbGgPDbeBg0MHm+Prer/KcMZgbq1yZ5s1l1f0qwpoVXZNzyxQYZ830t6Cq1mXn0AD+DUg1BddYsQQNdhMgJQyNpSXRs+Irc9ehcxYrShvY+4FLwJIQym/iKQrLuOtjPUZWL3VNLSX4VJxqyQY3wDciE30HmW0jIuXHljD7TZw7v8s36/QANht5WvoMiGWEkQJqPlfl2tbH6KU8fnZTj02OfxqP1RitBDUZIa+8yXPW6zlXawYELC3SzYC5COR8DT3NdWARKMRwbd8ktJC7IgB05sNSA7lgjymTd6/eYBD369LDpW8KTToktWDx+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75fde23-f7ab-420e-3e6d-08dd506cbe60
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 22:36:54.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB60nnzbMZYBwXHpYD9pmCTN//O99zbVWwHg4vGGjT/VFM64+z/Fl8Jfv+byE2ZffwyUc9DTEFDCKsYRcd49Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_10,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502180140
X-Proofpoint-GUID: pwR-YvOUIQQLVVLkJp_q2d8hW1Nk_Z35
X-Proofpoint-ORIG-GUID: pwR-YvOUIQQLVVLkJp_q2d8hW1Nk_Z35



On 18/2/25 21:14, Zorro Lang wrote:
> On Tue, Feb 18, 2025 at 02:53:05PM +0800, Anand Jain wrote:
>> On 18/2/25 11:51, Zorro Lang wrote:
>>> On Tue, Feb 18, 2025 at 08:26:20AM +0800, Anand Jain wrote:
>>>>
>>>> Zorro,
>>>>
>>>> I wonder if you've already pulled this?
>>>>
>>>> The branches in the PR below also include nitpick suggestions
>>>> and fixes that didn’t go through the reroll.
>>>>
>>>> For example, commit ("fstests: btrfs/226: use nodatasum mount
>>>> option to prevent false alerts") updates a comment that’s missing
>>>> from your for-next branch.
>>>
>>> Oh, I've merged this patch from your for-next branch when I saw
>>> you said: "Fixed. Applied to for-next at https://github.com/asj/fstests.git":
>>
>>
>> Got it! Moving forward, I’ll keep the `for-next` branch up to date
>> so it’s ready for you to merge whenever needed. Does that sound good?
> 
> Do the patches in your for-next mean "I've merged" or "I've tested/verified" ?
> I think there're 2 ways we can choose:
> 
> 1) If you hope I merge from your for-next each time, I'd like to merge the
>     "tested and no more changes" patches to avoid the issue we just met
>      above.
> 2) Or I only merge when you send a PR to tell me which patches are ready.


  Let’s go with option 1. (I thought we were doing option 2.)
  Pull only from `for-next`; though patches will pass through a staging
  branch first.

>>
>> Also, the fixup patch for the missed changes has been added to
>> the `for-next` branch.
> 
> We'd better not merge patches in private. Please send patch to the list,
> even if it's simple enough:)
> 

  The missing diff isn’t private. Anyway, the patch is on the ML now.

Thanks, Anand


> Thanks,
> Zorro
> 
>>
>> Thanks, Anand
>>
>>
>>>
>>>     https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/
>>>
>>> Sorry, I saw you used "past tense", I didn't notice you changed it after that.
>>> Please feel free to send another patch to do this change, there'll be a release
>>> this week too :)
>>>
>>> Thanks,
>>> Zorro
>>>
>>>>
>>>> --------------
>>>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>>>> index 359813c4f394..ce53b7d48c49 100755
>>>> --- a/tests/btrfs/226
>>>> +++ b/tests/btrfs/226
>>>> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
>>>>
>>>>    _scratch_mkfs >>$seqres.full 2>&1
>>>>
>>>> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data
>>>> checksum,
>>>> -# btrfs will fall back to buffered IO unconditionally to prevent data
>>>> checksum
>>>> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
>>>> -# So here we have to go with nodatasum mount option.
>>>> +# RWF_NOWAIT works only with direct I/O and requires an inode with
>>>> nodatasum
>>>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>>>>    _scratch_mount -o nodatasum
>>>>
>>>>    # Test a write against COW file/extent - should fail with -EAGAIN. Disable
>>>> the
>>>> --------------
>>>>
>>>>
>>>> Thanks, Anand
>>>>
>>>>
>>>> On 14/2/25 19:05, Anand Jain wrote:
>>>>> Zorro,
>>>>>
>>>>> Please pull these branches with the Btrfs test case changes.
>>>>>
>>>>>
>>>>>     [1]  https://github.com/asj/fstests.git staged-20250214-master_or_for-next
>>>>>
>>>>> The branch [1] is good to merge directly into master. It’s been tested,
>>>>> doesn’t affect other file systems, and has RB from key Btrfs contributors.
>>>>> But if you feel we need to discuss it more before doing it, no problem—
>>>>> kindly help merge it into for-next. (It is based on the master).
>>>>>
>>>>> After that, could you pull this branch [2] into your for-next only? as it
>>>>> depends on the btrfs/333 test case, which is not yet in the master.
>>>>>
>>>>>      [2] https://github.com/asj/fstests.git staged-20250214-for-next
>>>>>
>>>>> Thank you.
>>>>>
>>>>> PR 1:
>>>>> ====
>>>>>
>>>>> The following changes since commit 8467552f09e1672a02712653b532a84bd46ea10e:
>>>>>
>>>>>      btrfs/327: add a test case to verify inline extent data read (2024-11-29 11:20:18 +0800)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>      https://github.com/asj/fstests.git staged-20250214-master_or_for-next
>>>>>
>>>>> for you to fetch changes up to 429ed656f99c06f8036eff1088d93059d782add4:
>>>>>
>>>>>      btrfs: skip tests that exercise compression property when using nodatasum (2025-02-14 18:35:16 +0800)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Filipe Manana (7):
>>>>>          btrfs: skip tests incompatible with compression when compression is enabled
>>>>>          btrfs/290: skip test if we are running with nodatacow mount option
>>>>>          common/btrfs: add a _require_btrfs_no_nodatasum helper
>>>>>          btrfs/205: skip test when running with nodatasum mount option
>>>>>          btrfs: skip tests exercising data corruption and repair when using nodatasum
>>>>>          btrfs/281: skip test when running with nodatasum mount option
>>>>>          btrfs: skip tests that exercise compression property when using nodatasum
>>>>>
>>>>> Qu Wenruo (1):
>>>>>          fstests: btrfs/226: use nodatasum mount option to prevent false alerts
>>>>>
>>>>>     common/btrfs    |  7 +++++++
>>>>>     tests/btrfs/048 |  3 +++
>>>>>     tests/btrfs/059 |  3 +++
>>>>>     tests/btrfs/140 |  4 +++-
>>>>>     tests/btrfs/141 |  4 +++-
>>>>>     tests/btrfs/157 |  4 +++-
>>>>>     tests/btrfs/158 |  4 +++-
>>>>>     tests/btrfs/205 |  5 +++++
>>>>>     tests/btrfs/215 |  8 +++++++-
>>>>>     tests/btrfs/226 |  5 ++++-
>>>>>     tests/btrfs/265 |  7 ++++++-
>>>>>     tests/btrfs/266 |  7 ++++++-
>>>>>     tests/btrfs/267 |  7 ++++++-
>>>>>     tests/btrfs/268 |  7 ++++++-
>>>>>     tests/btrfs/269 |  7 ++++++-
>>>>>     tests/btrfs/281 |  2 ++
>>>>>     tests/btrfs/289 |  8 ++++++--
>>>>>     tests/btrfs/290 | 12 ++++++++++++
>>>>>     tests/btrfs/297 |  4 ++++
>>>>>     19 files changed, 95 insertions(+), 13 deletions(-)
>>>>>
>>>>> PR 2:
>>>>> =====
>>>>>
>>>>> The following changes since commit d1adf462e4b291547014212f0d602e3d2a7c7cef:
>>>>>
>>>>>      check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE (2025-02-02 21:28:37 +0800)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>      https://github.com/asj/fstests.git staged-20250214-for-next
>>>>>
>>>>> for you to fetch changes up to dd2c1d2fa744aa305c88bd5910cce0e19dfb6f41:
>>>>>
>>>>>      btrfs/333: skip the test when running with nodatacow or nodatasum (2025-02-14 18:37:09 +0800)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Filipe Manana (1):
>>>>>          btrfs/333: skip the test when running with nodatacow or nodatasum
>>>>>
>>>>>     tests/btrfs/333 | 5 +++++
>>>>>     1 file changed, 5 insertions(+)
>>>>
>>>>
>>>
>>
> 


