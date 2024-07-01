Return-Path: <linux-btrfs+bounces-6066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C091DBC2
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C334DB219F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36612A14C;
	Mon,  1 Jul 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iX+jKdrZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PYZIkv//"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47686252;
	Mon,  1 Jul 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827663; cv=fail; b=aioIDicBTkldNpAGGLVNOpA25wRfhJeXUx6QMaP8ZNuKicUkzSdxvphxpvfF4FWWDPQjXe7RkxykDz9rezdwuylIdI3e99u8qVc+gMf5n4fROJDDrmoE425pcABNhHYWix6Vx7Bl/Ue4MAfpwz1PzWrUuVK4Mc+5zZfZSVVDbss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827663; c=relaxed/simple;
	bh=4M+9BMnIpC2XzU0+X07q9/wb5h1WS5sPXaIO5kEYvGo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nkw4rWomruPmh7HK5I1G9iQLsymFphx2BqFsS6A6TBOCbdGlT9OLds1PsXEGvA68/6q6pfbSPH3rS6BmVLV1a9LFUzSKfNSx2BbdP4hV1bBuDp4OScQIuS+5rPz11cBHcXqVVQFp+vhrf5vsGf8GnU/PssPA1GzlZZ1ryaYTjZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iX+jKdrZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PYZIkv//; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4617tXJm028937;
	Mon, 1 Jul 2024 09:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=43VMWE1dtYxBhOmLkCTpeS5vHRs/jTFFO/nrTvtF9R0=; b=
	iX+jKdrZs29kHuOzuvTcHS84RD3pBj03fANmHtBVGU6N2eaCvcpb1fw1roG3vJJZ
	RxF5Gda7GuajiySw5j37JByuEZcgl+r3zQhOqFfB8aneVYwjLZCfSJ3THY2WsNkS
	TgR+Gjk6DqEoMZjX9Y9cG+R5S+lCSUR1J6XCGk5ek/WAMlg6x0/J4Ijhx2WHafgc
	oIO5WQ0VtQYwpYoSU1Nzs6p86OZqGb9RPlod+Ux7LRSrjfNO+uSQ9ic20PLIBRD/
	R5bLruJEu20uXXqj5siKnQTWHlVqPq3eR49m6RHVrbuIGeuGE1cmg7FAcmlpH3Mm
	Vdy8EsGj/9uswBHAE3nKBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsj9wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 09:54:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4619jI4O018327;
	Mon, 1 Jul 2024 09:54:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qchn4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 09:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFIzwC7MX1oP4mxlA1+V3jxQ8eF/2msiSoNk9ptVMtpdwT1T2k3rKPQqevLCEOqTgquEgdzVXIBf0U0MN2htqtzCDp3x4TOIrA1+RHloblXFajg9o8z6wU6yFGZpnQn+I+mz6inB+K6X/nMJJNegi12xSW+WC5mIZ7S6RR2X9vgwtCBmbKVf3LcEAmbgIqWxeVO9getUSABv8V/UcLEtWS6jw2PObxuU4Bvcn+MyQejfhcDR13XihjzP99b7UjEhE1q70R18Fbj9kXrS7v0wKd4CLu2/XYmwF9s71pdGvvGfyU1KJPSmF+3jRN2VamsUQGEf96pEJ1OL7FEyYlQI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43VMWE1dtYxBhOmLkCTpeS5vHRs/jTFFO/nrTvtF9R0=;
 b=l6A9IlX8dd04EmjvfEbGseafv/5sS+PJztpOQKZelMIA0krEuwHmMD+AjJ4eqlw8YYWIb3kG3pdNDPl7XwHXO6DDCYq/Te4XFCA61ZJcEkkIl6qX4LyyIJIr3zbBj2k4bvhW3PRB+PFbpRR1HsCha9vB2dHD4Gah2IPYmAO2WloMR3H7sH7+BGH0wnLL8ZGXDzfPXOu0iYios0MEPCIjst3GgWa6TE2rcwpBnHo2eNxHUtRiulto9XmfI+xVV1gfdrsbe2pvUJrluuMMDX6Fo/rrzFc73Z1klAq9jJXGQTIE+n/kbeAqCeqCPPc5WAQ/JuAMj2P7zXXXTdTg4cz/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43VMWE1dtYxBhOmLkCTpeS5vHRs/jTFFO/nrTvtF9R0=;
 b=PYZIkv//8K1PmlAUzjkmVWrzwRRNgFdRhObXz0Lr4XtNFqPr6jYgTqfLGwdba9KQVDU2A+zs/+GVPgTj6wic/ob4PNcFfOA4znXK4ClUhuclSUFwKl2V/3YCJ3UVx2VfK5v+06noGpC+ylAQti1dCa7Y+U8nrHwqrC9qAB8hesw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 09:54:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7698.033; Mon, 1 Jul 2024
 09:54:05 +0000
Message-ID: <9301769a-9b0e-49aa-9c2a-ecad3bb9e4aa@oracle.com>
Date: Mon, 1 Jul 2024 17:53:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: update golden output of RST test cases
From: Anand Jain <anand.jain@oracle.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240627094722.24192-1-jth@kernel.org>
 <CAL3q7H5coRxND9EwUkzOyLSp2cLKWirbEueiuATegytfBChRaQ@mail.gmail.com>
 <818b51a6-6ac3-4a2f-afa7-42568227db65@oracle.com>
Content-Language: en-GB
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <818b51a6-6ac3-4a2f-afa7-42568227db65@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb11d01-e785-4500-e67e-08dc99b3bea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YndrQTV2Y1N4Ky9xTys4Q3pXQVFYRTlKM0Z4Mk5TQ3lWL1c0clJSMWhvREI3?=
 =?utf-8?B?TGE0R2JJM1hKYUlrMFk2OENsTDdweXZyMUU2STRoUk1DV3FJOHZNWUtrRUpr?=
 =?utf-8?B?SjZqMFNObDNEdm1JQkpRYVZ3VXA3Q0tUUk9MaGljTmtGQk5BR3NKYTVnb2Nh?=
 =?utf-8?B?dHh1QTBscGdualpGWlBnLy9sN1lnc3lKUnVrK1RwT3k5SmtoeGx6VmZsQmNI?=
 =?utf-8?B?WEMxMFdCSEp4WVFmZndCQ3Y5VHQvcDlNOEVFaEdhaGtpdzV0VFRWckE3TC9S?=
 =?utf-8?B?L0hFRU1WV05ESVkvT3BjbWphZm51UDB3SjBLTmdwRkpwSVVQL3AyQ1ZqcTVp?=
 =?utf-8?B?Q0J6QXQrSStOVzVZYWtzenh4ZlBTdmJDM2Y4MkFMRVVqYmhYUlp1VGZna3Zl?=
 =?utf-8?B?aUVBRGNmc2VzS3oyYkdISHorTEx0c1lJNVBaa3BZVWhFVEdweXdNQ29qNmxq?=
 =?utf-8?B?YlF0eXhka1hVNUd4bVE4dWN5aVNSOTUwZFdJTmgrbVJBa2U1UlJVT0ZBMUxn?=
 =?utf-8?B?OTk3SmFSVFJDK0lJeHVTNDhZOEpuRjNsbHI1bGVTMHJhU2hjL09lallpZFpL?=
 =?utf-8?B?Zm5mUjh4KytRbGw2QUFMNEw4eFZTYXhyRzJ0cmJRWUR5cFpubkI0QkxwYnE2?=
 =?utf-8?B?RGNmQlQ5bE9BdmsxbW5lZFErTmhrN1VKa01HQnhLS1hSY29JRzJvS01EdnZP?=
 =?utf-8?B?emNzcjh2dmw1SHdNVVNuLzlmNDg0Q2hqNkNqWStZTFExQzhISjhPZHNXTERN?=
 =?utf-8?B?VFNDUENYb0psWTBjcEpLL25seE9lUGxTeENxTVdVMGxpWFoxK2Y2QVcvUWlL?=
 =?utf-8?B?T3RqTExKQUVoNzZ4RW5CYzE3dmIzMFVoc0JVcEdJcVpWZFg4RzR2OWI3a1hU?=
 =?utf-8?B?a2dpM0ZNeHEyMzExRWRKdmJZYUNHa2x6UUw0VFRZVGZQVENjOXAwSkhPZmt6?=
 =?utf-8?B?ZDFIWTIyWGdzYkwxNFVORUZ2djJFRm4zQ3BqZDBkUkljeTIrZjR1SGpkOW92?=
 =?utf-8?B?K3lXYzJReFdWWjVOSWx6WGxXQjhQMllOelNzTnpmdldzTmFyU3pZSnNOd0ZO?=
 =?utf-8?B?M3VxMDhlK052MnY2MkJkSHN1VTJmV1FKZFRhSEs4YWVzaTZNbkx5TjM2NC9X?=
 =?utf-8?B?Yk1NN3dJTGh0Vzd5RWQxcGZOb0VTMktydXZFMG8vbmU5ZEpyU1crMGljOWNp?=
 =?utf-8?B?akVRd2Z1cHUrRkJPdXdrakVWY0w0dnJabnBTeGRpdnRLcEtieWIwSW1uSFB0?=
 =?utf-8?B?aWRaU2FDb1NLS2N6N3J2RnVDWUhtZG00amtxR0lBVE1FVFVIVTRWbFlLMVc3?=
 =?utf-8?B?M3FsZ3dGUlBCU2p4K1R2d2hPR1hKUWs5eXo4OUtickVCL205VU5XWnhZQmdU?=
 =?utf-8?B?bTBJTkpQTzlVTkxKUW9kQmFIYUV1d0tkdFFnV2RDQWc1MkljWGVHOU5UUHM1?=
 =?utf-8?B?SUdJZGFKaFJ2eVJIWjkyNmtMeHBMbWs4eHU1S0xlNy9oR1ZBOHIza08zVmQy?=
 =?utf-8?B?dWM2a285SDBweU1wN0pEclZMYks5MzQwNFdPV25NSHN0citDOVVNN2FRVGlR?=
 =?utf-8?B?R0FBT3lPdmdhUzg5L2RVRWRMeVpOVUlUeXNvdTVHUE9ncEpxMHlXQUJ0SkVn?=
 =?utf-8?B?eGt0Z3puL0h2bU84b2hJMUF6djlMeEZtTXlrdXM1OTRkazNBYkJ3VGpEWGc0?=
 =?utf-8?B?NWRaRFR5SnMwamI3SU9nUWo5dVZ4eklrYXAzYnR2Q0NRT3BvMmlFRVV1N2du?=
 =?utf-8?B?aTk1TzUxQjBvckNzVjJabS9UU1BHM0ZLNHBHVGd1Mk96QzRLd3Y0cTg2YTNr?=
 =?utf-8?B?QWx4TFEzZ3JxaHpzYTRiQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXJISExsdUthZmNKdmw0OUFPTHZpWHFHa3BEa3pLTis0SlJWSFRPcFBJUWVO?=
 =?utf-8?B?YVEvYWlMT0pZT0I1b3FqMHY0NWNwaExZZzJLdi9pMHhUNGZUOU9RNHJKZFhu?=
 =?utf-8?B?VThaUFVCWi8vY1hKUlF2QnkxTWVEd3NHeWlXQm1CaWxyN09FYjJvenY5WWFZ?=
 =?utf-8?B?TDNad1JrNGZiMHl0YzUyWnVmNkh0MXVpVVBBTDY2T2p0OFBvVGZOTlY3R091?=
 =?utf-8?B?azVUYmozZWZ5QngyZUJvbDRaZDVmUzF4cmNFaXB0SThzdmFTL0RQQ0NENm83?=
 =?utf-8?B?N0drVlZLZ0E0SHJuNXdKREpYTnRXTGpXbTNOcHA5OVB0V3Y2MGxzbXBOOWNj?=
 =?utf-8?B?TUFZM1hQVUNDVlF2eTVtcy9uRmlRejJSS08wZ0V0b3hTdHhYdHF0VDFXbzd1?=
 =?utf-8?B?YlBiUytkRTgvVGlXdGdqY2FjdEJXeFJ6N2laOHZxNUpGbDRWbGhCN0JySFZs?=
 =?utf-8?B?VlpBK1JjREFqVXNqaUk3czVTRzJ3Tisrd0dmcVFoWTVieStNNWlwS3M0dS9D?=
 =?utf-8?B?TGNOZjJrQjZyOUNrait2OG5wc29KTmZnMldQbVA0YWtZZGsxSGN0TzhLNDgr?=
 =?utf-8?B?UzhMTmhOSGRESm1xTnlhVEtac0prT0NjNHd1R3YzTkhFYzIvTzVYRU8zZ0I0?=
 =?utf-8?B?S0FBOWg2UklxQjhOSlRyeTg3STNieHlUSG9xR3dBT0lVQWpINTRaeDFFT25w?=
 =?utf-8?B?Ui8wUm5SS3pkSWlVZW4yNUFac0ZhekxZSUVhYmoxWE13U2Frc1ZLRXArMVA2?=
 =?utf-8?B?dlFUbUN2UXplRXhNV2pqVWlZdjA0dVJlNlFwNVhPSzdqVyt0R0g1RVRwLzVE?=
 =?utf-8?B?SitURU16dVViSjc2dWlIMzI5aitHakN5RFN3cC9PaGIyS1RINGNFVHFkS2ZJ?=
 =?utf-8?B?VW53OUtTdi9hOUJPazJ3aUlQYzVGd05XWVJJRWVSUktrT0hINTUyc1ZwckY0?=
 =?utf-8?B?eEQ3c2x0dUk3TTA3RVZPSDdISWRubzFlTyt4VGpTOUpJMi93TVhDNzB0S2Fy?=
 =?utf-8?B?eGh5VlprZUVYZ1pvakE3bWZxZUxvWjlndlZkSXJrNVlmSHQ4ZCthcnJWWlF6?=
 =?utf-8?B?V0xvMEN2cjF0VEJiTk55SkRZZlBkSG5PL2R6anlCOUNvUm1JTUowamhoeVA5?=
 =?utf-8?B?NlhidUZQTitoV1F5aTZJRmpYeDdDUUI1MHhqVURxNm4zWUNienBJcUpqVkRL?=
 =?utf-8?B?a2tBdytvakYvVnFheFY5Z2lDc3NqUGJFaXpHSTVXYVg3T2lEY0lHZlhWRk83?=
 =?utf-8?B?V1lwRk81ak4vOFRObjlHN1NNVkJwUWdHdGpqcFIrZm5LVTNtQ1ZhRWdLVkRw?=
 =?utf-8?B?TmM2KzJjUEloR0JMWks5blZ1UEhCd0RkNjJTWExpd1lUM3FMbFZ2N1JVUHV0?=
 =?utf-8?B?bkhDT3VHVEpDd1lVSDcrRlg2YW9CNmxIUlR4Y1dyWk01NjR6UXRxa29KUjJx?=
 =?utf-8?B?dzVUZHduS1NVM2FRb0djaFNSYlFSR0NKa2dNUHhtUVIwZjJyVEpBZ3NiTXdF?=
 =?utf-8?B?dS94cHdOWGo0aEFEUDZ0NjAzL3I0dlpzWm55N0xrM1l1UHdGd1NHcVZrNm1j?=
 =?utf-8?B?UjE2ZDlnS0ZBc051MzQ5Nmt0Y1F1Q2x6S3hVeUIxM0pyZlAwbisvKzhiME9v?=
 =?utf-8?B?SUVXeGMvaDhkRzVHRUdwK1JGZkhFZk5JYUJ1bVM3UXZGMEtSbGpEZEpXNVpm?=
 =?utf-8?B?WXVoR2o2U3ZlS2xuQStpOHUwYnA3aTdLUXdJdkM0TEVzY3R5ZFBXc3laOC9u?=
 =?utf-8?B?R1llT3g2WkN5V1RHK0lSeVk2ZFVRcm0rSllBZ1NpT1JzcUg1S3JlL2dldGF6?=
 =?utf-8?B?eUdjQklHcTNWV3ZDbExGVGdzS20wWjR3S0hwV1paSXFod1hQSTA5enBqV1NJ?=
 =?utf-8?B?QTNsMWhQSmFTVHk2Tm1ZbHRBcjNkWSs1cmQwMHpDNkt2SDBmalFOOXNMenVI?=
 =?utf-8?B?cW4xaDVOVzRsSDR2aUlZS1llWWFQVmI4dWt6UGo3Sk5oYUQ0bFJmYXdUY0ZC?=
 =?utf-8?B?TytVQ204NFo1QmFaOW92MDliQWxRN1Y5NjFZVkZuWnM3LzB4eG56S21xTk8y?=
 =?utf-8?B?U3pvNmk3UWhhR01keG1oYUR6S2t6K0J6bGpuV3E4YTlndWdCK0M5Q2FaUHNq?=
 =?utf-8?Q?snra5bQI6VzGJi38jDdhgOMLw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sYtlnVw0AGzOOsWrX8LnA01rxCKjEG/VSfozBoYM4kvoPglTSNxDU7uvVv7Retk3h5OwTgei3CgyEe2vdMtGEcm3hoGAQZ7aDKUUHNjAWHCgJi7V9//YTCBDKXYFBmGbdjQVEbOBZC08Ovcpu+rqk75lhc59kOy4S1FeaDQNZfdtmDMHtholMFlQNNUMEiOXt6oKCJLJcVjkNXcscpkDycBONOtv6jisw6bvDt0+LScS0G3oF50d765Wcwxx6+mrfbmNfBrLLkYfNzofywGsvOZzUiM8ieDABSkWgo+SYqlmup1NCnF6JQ9k23zfx8/hnyzFGJ7rZpFXGS9rHHUzvaAY4x9fdf0SctTFCk5l/Cx3ehE7+9KdQmVHrC0T78h8E9g0EsN96OhcfCC3x4gBGSAUmNgxh0cG1wbIkpF4hMwAX3XYNGqgO8FZ7ziSxy0P2HdQHZ3S9W/ESCyW6Li7MeaYv9b5u0ypJ0O74iFDhohpnQPLzd4baii8K4tD8eaJwYeTUNrq+TkU0PRh3mGmi/MFa4aWK3DzWAb1N8Aj5nWCfub7sUSVbde1G8qla43Slk0+xTbS/2rLUbRD5OjM/0iGmw3DmvR+d5yF9jUcTFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb11d01-e785-4500-e67e-08dc99b3bea4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 09:54:05.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mka6c1sOV7ZouBSYiS3O3EWrctTvX9g8COZdqirhQC7MXt3L9JYlIGUTpE4GONh9u7O8Y9DucmYQ6R9gex1pew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010076
X-Proofpoint-GUID: fLUYA1R9U5ID75aZBRkf5h0z6TL_eRmF
X-Proofpoint-ORIG-GUID: fLUYA1R9U5ID75aZBRkf5h0z6TL_eRmF



On 7/1/24 17:48, Anand Jain wrote:
> On 6/29/24 18:50, Filipe Manana wrote:
>> On Thu, Jun 27, 2024 at 10:47 AM Johannes Thumshirn <jth@kernel.org> 
>> wrote:
>>>
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Update the golden output of the RAID stripe tree test cases after the
>>> on-disk format and print format changes.
>>
>> Better to mention here that the on-disk format changes happened:
>>
>> 1) For btrfs-progs 6.9.1, with commit 7c549b5f7cc0 ("btrfs-progs:
>> remove raid stripe encoding";
>>
>> 2) For the kernel, with the patch "btrfs: remove raid-stripe-tree
>> encoding field from stripe_extent", which is not yet in Linus' tree;
>>
>> And that we don't need to ensure compatibility with different
>> btrfs-progs and kernel versions because it's an experimental feature,
>> subject to changes until stabilized.
>>
>> Other than that it looks good, it makes the tests pass with the
>> for-next btrfs kernel branch and btrfs-progs 6.9.1+.
>>
> 
> Also, please rebase on the latest fstests for-next.
> 

Please ignore, as version 2 has already been sent to the mailing list.
I will fix conflicts locally.

Thanks, Anand

> Thanks, Anand
> 
>> Thanks.
>>
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>   tests/btrfs/304.out |  9 +++------
>>>   tests/btrfs/305.out | 24 ++++++++----------------
>>>   tests/btrfs/306.out | 18 ++++++------------
>>>   tests/btrfs/307.out | 15 +++++----------
>>>   tests/btrfs/308.out | 39 +++++++++++++--------------------------
>>>   5 files changed, 35 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
>>> index 39f56f32274d..97ec27455b01 100644
>>> --- a/tests/btrfs/304.out
>>> +++ b/tests/btrfs/304.out
>>> @@ -12,8 +12,7 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>>   bytes used XXXXXX
>>> @@ -30,8 +29,7 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> @@ -49,8 +47,7 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
>>> index 7090626c3036..02642c904b1e 100644
>>> --- a/tests/btrfs/305.out
>>> +++ b/tests/btrfs/305.out
>>> @@ -14,14 +14,11 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>> -       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>>   bytes used XXXXXX
>>> @@ -40,12 +37,10 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> @@ -65,16 +60,13 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 3 physical XXXXXXXXX
>>>                          stripe 1 devid 4 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
>>> index 25065674c77b..954567db7623 100644
>>> --- a/tests/btrfs/306.out
>>> +++ b/tests/btrfs/306.out
>>> @@ -14,11 +14,9 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>>   bytes used XXXXXX
>>> @@ -37,12 +35,10 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> @@ -62,12 +58,10 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 3 physical XXXXXXXXX
>>>                          stripe 1 devid 4 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
>>> index 2815d17d7f03..e2f1d3d84a68 100644
>>> --- a/tests/btrfs/307.out
>>> +++ b/tests/btrfs/307.out
>>> @@ -12,11 +12,9 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>>   bytes used XXXXXX
>>> @@ -33,8 +31,7 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> @@ -52,12 +49,10 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 3 physical XXXXXXXXX
>>>                          stripe 1 devid 4 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
>>> index 23b31dd32959..75e010d54252 100644
>>> --- a/tests/btrfs/308.out
>>> +++ b/tests/btrfs/308.out
>>> @@ -16,20 +16,15 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>> -       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 2 physical XXXXXXXXX
>>> -       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>> -       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
>>> -                       encoding: RAID0
>>> +       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>>   bytes used XXXXXX
>>> @@ -50,16 +45,13 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID1
>>> +       item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> @@ -81,24 +73,19 @@ checksum stored <CHECKSUM>
>>>   checksum calced <CHECKSUM>
>>>   fs uuid <UUID>
>>>   chunk uuid <UUID>
>>> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 3 physical XXXXXXXXX
>>>                          stripe 1 devid 4 physical XXXXXXXXX
>>> -       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>> -       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
>>> -                       encoding: RAID10
>>> +       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>>>                          stripe 0 devid 1 physical XXXXXXXXX
>>>                          stripe 1 devid 2 physical XXXXXXXXX
>>>   total bytes XXXXXXXX
>>> -- 
>>> 2.43.0
>>>
>>>
> 

