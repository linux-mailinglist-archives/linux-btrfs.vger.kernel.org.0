Return-Path: <linux-btrfs+bounces-14228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3AAC3759
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 01:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696793B2570
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B41C5D55;
	Sun, 25 May 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lXZm1Iys";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ljl7om1l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07661846C;
	Sun, 25 May 2025 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748214485; cv=fail; b=E4bTKeCXS1LOaVhiKIa3e9PwH4UyFMS0sTZOQLD07bdlz6m1D8nTdCSY5r37MYEx6XkdpW6sTVqvyMR8DTD1SNVYS81xBPpAr4cSqycDHViKWX1VW8fFg0F4+Iq+b7wWdnqSFeHWrcENSPKiU/s4tLQH5Y4TKcXsffDdbPhmo8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748214485; c=relaxed/simple;
	bh=uE36y4X4r4m31A1NOhjK/NNd0Qs56wcmpN3+HCJui3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WP7SAxrQBSdcWFlQEXlxY8wum7ub+3Mg/CefptTO7FtRNZhvRAIyrZfD+9P+cxYfsLVU/MG8/OlX6XStclKC9cI10GykiCnB3ZUtedy9YyuEnqOmTR5BZyflSSerOFPouZT3wkNCW+gemjF45roRJzmPu5EWvxpdC2LSmE1Qx5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lXZm1Iys; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ljl7om1l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PLKOs6023295;
	Sun, 25 May 2025 23:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JDngYBRorb9nGLO+0BbNRJaoYilEpLXfEbs3uoXgWI8=; b=
	lXZm1IysvEKIwHxrCHubHqMsoVN2EELWCGk4io+iK+7ivRxSA4iIqDIYXUE0axfi
	n0a/1XXzTumKC2ADRP4HAeHUmffuEoz8XVXcibGk49BYwSSGbWQk1fmEbNieb6BK
	Mb19rxM5PfUCzMQ8HJdyCWi5BVqf7CcIqGF2gmYiJ45PYlZjkRa74fjwUKTCcANN
	wvTlxtkisR0Cs4Ge8lo3KBPNeoECL13nxrSu8COW8GMD8WmjGeYxhIZAsYbSrw/n
	4VIz6hEbfvaTVcKkZ26++oEvNWzU/9Gc2GO4UrujvmRcAS9omDvxqaPCuvFgfQRO
	kmOZ8aQXg7ieEwhL29Sx4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g28fb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 May 2025 23:07:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54PKV3Ws027873;
	Sun, 25 May 2025 23:07:47 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11010005.outbound.protection.outlook.com [52.101.51.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j77w73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 May 2025 23:07:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAXGa6VrcGDUVjpJWXUpP/FaEpRfgqhFhN9VFzXIv1RAJM2oOe2K85HfNOyjRunEdYUmcbOpfiJRTCDONKUS7r62NQCKLsGpTS0keJ7pZnlNE8ir4LhDNpGqxn8AvvhSjO+1/WtyPDPpUo2c54+tMnspw1kF5lgQWbmyMsDXv7nQ0FcD+L12ZDsVq5OvuF01gflDWXx7B330sb9h6yt8YcC6bSQSHGPYrTNWOOiP7cI8fiCpqjU1g/VScAt0usXL1bnyIuWEKnVHKsLNidWc00QNxFz6mcit6jOcRHrgmJfsIEt49/EUdZMEuvUCtW26fcY3N7DujRI7c7jP71UGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDngYBRorb9nGLO+0BbNRJaoYilEpLXfEbs3uoXgWI8=;
 b=Xmx6EvZfTCBbk95MkH6lwhM7U+3XMHsjve1JK7nO3596JatWwr575IHsZbHh0AtCrtEZ0irvdF117nbQkuunn2pxyFdvDZJflxc14uFzBuFILBPnUXn3y/Nk9AG5IkAjtgDbTmJQ8A72Xllx4Trs5ctruT4jAxE2gVD1FBC1bFrtqPmxKdCTgEqJ5dP3rIMPJJqcNr4sdVBR09BuTn6tgFpI2mR5zw/j/QZVD0oPaJZi6iHxGr4PlqbH5l16FEe2ZdObXh7J4Awb6Uifzp65De3R1l9gJ5wLZcBAz+FOBqWtIVFaSVqnyFcYjnWgpaBwuW5zmBipT/Don3m4S31tzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDngYBRorb9nGLO+0BbNRJaoYilEpLXfEbs3uoXgWI8=;
 b=ljl7om1lUCtkkGaq5GpWZ3CAq5yr63ioZwatFkI4WQfI9EYknreW7su1/Zd5WJn9qtoEPuuSPXb4YqRvaTFqWcyNlDRc2zdIY8otpOrPaxwZTeRuN5qRGsEBMuF0qWA7/WShLybD0j7IIsuNUbiJsy5A/ks+bDM+STffwRE6KU0=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.38; Sun, 25 May
 2025 23:07:44 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Sun, 25 May 2025
 23:07:44 +0000
Message-ID: <2bbd3592-51dd-4d12-81f1-fb2a311921b8@oracle.com>
Date: Mon, 26 May 2025 07:07:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
To: Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
 <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f4c2b83f-cc13-45f3-9f16-03095b56e175@oracle.com>
 <20250525052802.pwujhzxdyj3on6l3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <97d6425e-dd3d-4949-b63e-a53a6e210069@oracle.com>
 <20250525111459.bpi6zisqetjpxxd4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250525111459.bpi6zisqetjpxxd4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bcfaef-826a-48f1-f108-08dd9be0f4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1g5dG82aVdyK3dzQWZxNU04VDFzSWFHdmRmRHFReHZrVnMwN1N3ZGpjU3VV?=
 =?utf-8?B?cy8wSndENHFnTzhMN0k5ZGtKS1FJU3FldjVPYlZmdWk0YTZNZXNZYjNyMDRR?=
 =?utf-8?B?TmdXS1Q4ODVKclBUei8xUW1FTmZwcXJpWkRaSlhqOFAySXh1WUlESTZaZE0y?=
 =?utf-8?B?bENaRVBnWXpqRG5IS2lCR3E2MUNYVDVNclU2bE5IRk9YRU15NE1HTmRwSy9H?=
 =?utf-8?B?ZlBWbFpPaENjT3hndTl5Nk10K1psViszLyt5UFJ1R1czdnhOUFpKTExTdzJM?=
 =?utf-8?B?bEdPNnhkNnNsbzByam11UzBkbkRJUEQ3Q0k0QzlyU05iNjVQOTFKKzFsdVg3?=
 =?utf-8?B?ODAvc3pBSDg1OHdoRyt4VHp4WWZFWUNWNkgyb3ZsNUI5Y08zbFVsS0JBWGxK?=
 =?utf-8?B?QXpRUFA2aG82VTZhaG14L1V6QTlNZ2hGQ0RiVWg3UGdSZHNHSWpFTDU5Ynpw?=
 =?utf-8?B?WXdSU2pkNTJHRDlkYkpYaWhVNkNyMXJLUWVxNWZFQ0FIcEljNEN3M2NyQXBQ?=
 =?utf-8?B?bUxmb2UzOTkrV3ZJME1JcENzN2dVemNjVXBKU1lzb0gxSzk2N3VoaUwvYWRj?=
 =?utf-8?B?WGswRUVQZkRYdWVJSHZLRkh2S2QycGtuSllTbFZlKzArcjM1V05nMVh1aVNp?=
 =?utf-8?B?QXc3YXQxaG1JaUR6c25SaUFzMHc3eHVpQWhFajdZZzExbXRxVnBMcHR2YkFr?=
 =?utf-8?B?MXQ3YXFtU0tCclg1dTRWSGFjZXlZVkNxTkVHemdBRlNBL0pxbkM0WEI0dFZJ?=
 =?utf-8?B?S2srUU1XajgzUWJ2cWdMKzc4UHhUN3Z4ZG1Db2N4cllqM0tXb1d4Nit3QXd4?=
 =?utf-8?B?dFFBSEpVNHBTcldtbHBPa01xUGNmRzFNSzRMSnhKa0pkK1NEakYvbk15emxT?=
 =?utf-8?B?Wk1OSEZzbnV3SUFSdVNGOEllREJiN1d4QysvN3NGQWI2dVpRT0x6cGRmUXR6?=
 =?utf-8?B?QjFwanZJcmNGN0dNcFcwLy9YOTFGTnBCbzd6OXUrSmRzQzl1UFIyak5BMEZQ?=
 =?utf-8?B?dFA4UmM5d2M2eU9mTVYrT245eUg4aEJoSzVucXkvYkd0a0lYM1B0bXZjalUz?=
 =?utf-8?B?WmVQYTNpcGRpOXlqRFJ1YjNLNC9KdVlUK2Zoa1FkNWE0V255dTJRREQ5UTJY?=
 =?utf-8?B?NXBYcXdlSTdjVSttQm1RV0U0VS9EWVFpSE9NLy9PY0Zzek8zekluRUFub0xn?=
 =?utf-8?B?aldiVFptZTNxK0cxcEw2Q3pMRzNIbzlNUlV0WGlKaTZ0Ymt0eWtyYzRkaFJy?=
 =?utf-8?B?czZscFJhV1J6SEx4KytLcnVEMzBvaGUvT2kzc3U5dXcxSlkwdmw4ZEZ5Q3Ba?=
 =?utf-8?B?QzVHZ1RWRHZyUHcrcjM1am9VeUlCV0JtQllVN09zN1dBc0xKR0tKRUhpQjA3?=
 =?utf-8?B?ZE1ZYkYzVUdOUUoya1JqWHd1eE5td2hBOVRxVHl2QVllZ1pPK3phdWRZUUk3?=
 =?utf-8?B?dU04ZU5JMmFUbWtZdzFkUTF0RjJ3a0VOY2NJcXNYSW5lS2RTbWtUYk1MSTRS?=
 =?utf-8?B?SmZYNVhyWVdYaUljSytreFhBR1pISlFIZVRuWlNON21LaUd6eU5Oa1REUFlq?=
 =?utf-8?B?WngwZHJmdGplZWtmVS8yNXZoSEhmT2x4WUNrTEl3TTgvTnlhU0cxRVNlcGhH?=
 =?utf-8?B?SkJwVm01d21vRXZ0c0tRZXV3MlhldTdhNjVXRlhNV1pDNmFBeG9DbXFYTkxX?=
 =?utf-8?B?TnFXQUVqa2JES1RFOTUwNGdya3E1WXJob3FnYWtUcmtIc2EwWm1HWWh1bG9t?=
 =?utf-8?B?QlYwV1c1NmxxOGJzRHpjSFRTSUZWNFVWSWQxUnV2WDFycWI0OGd4RnNVWWN6?=
 =?utf-8?Q?TKPbVHWFiHf3kFzmUSDzmKFcqhLbXhyabGhK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THVjVXFLN0V5S3dmcjRQUTZHMVo1VElxTnR6b3drRTFXUmVxMFBJbjBTODlO?=
 =?utf-8?B?b2NPT3pVY0ZqUzdrWEszbzdyb1l4VTFISTBOc2VybllLdThFY0ZmNTRMc2hX?=
 =?utf-8?B?SC9TQVVJL0lydit1NWFBU1kxbEVhTmVWRGNOS3QyYXB2ZmdyYkppMCtUbVFa?=
 =?utf-8?B?ZlA5WGU2V3FuNzlnaGRtWlZqMUZSaUFHZld0T2R4UW1oczlpVjFkMGxqRENX?=
 =?utf-8?B?L1hlcDBCc0tXWXV2c2V3aTVzeDRQUGQwbnpYY3ZsdDZubm9HRHdCVVdPdk9n?=
 =?utf-8?B?NTZ6bE95N1lMYnk3dk1OMi9SMjdTUTU0MGk2cDVqUUgzK09uemRJSEJnMUJk?=
 =?utf-8?B?cHc2aGxwOEYxOWZ2aFZST1ZCVklQZGg5ZFJHYWtTeXM0RE5OOEM4Ti9GU09G?=
 =?utf-8?B?bldLYUg1ZEVZbkg2QXF2VGxvTWE2dE1ERy9sbHVrVzNZbExOTGZld0VzNEFt?=
 =?utf-8?B?b3VHa1NCYVV6aVpxSnZxWHdXVXljT1k5dVJuMDk2TEN2dERPVXpXbkJzVWNo?=
 =?utf-8?B?cjNzd2ZGVEkrQXozTk81WVo4SEJBa0lvZUtZVE9GbVQ2Lzk5ZmczTXpOTDFp?=
 =?utf-8?B?a3lqRkM0elI4WWZTS3dPeHVId3lYUHY2MUlMeTZpNDRYaitRcityamJJa0ZX?=
 =?utf-8?B?aDM3d2sxWXdRZ29POXp2ZWFmbWJNcFN5RXJtT0JBdk5ES2t5V2h5RFdqVml5?=
 =?utf-8?B?eEpCa0pRWHllR0FzdDIwMUpyV3VvTGJNZFBLNk1rKzEzZk43ODZYWWMzRXJC?=
 =?utf-8?B?enpKbUN2QXc5V3pIaXF4VnFHMGNZZVBzT0lETDJLNFVFKzY2UW4zaERhOTlZ?=
 =?utf-8?B?RzIwb3pnVkdyRDd0SktsenU4bWJPeXQ5Vy83WjJOVkZhbndIZ1VzaWgrcnp3?=
 =?utf-8?B?OUwwQS9tNkZUbERGNlVwVDlOd3VTek1mcWl2T0gvMWhabVlkMjBGaVo2VUQy?=
 =?utf-8?B?SUdOMkU3QU9IWGxZM0dTZEtDQlVaSUM5c1dFM1JkWUdHR0dTRmI2SlFzZCtT?=
 =?utf-8?B?OGcxVTd2WG9rUXA4VlQwZkxHem9HeDQ2ZmxqSHQ4eXgyL2laSGc3OXZJQXFs?=
 =?utf-8?B?TlFTVW5pTmg2dm9nNnR1Y3VIbVFhTVUzaEFmZzVCZURic1RYaThTbjhzU3hR?=
 =?utf-8?B?eU9EbUVVTElkYjh3N3VwTFR6RGdPL2MvSC93K2FmSVozc2szem9BTEo1dU1E?=
 =?utf-8?B?TEJMTjZBbnllM0c3NGYrSmpNSEtuY005UlRkRDRQYTJRTDRsZkhSQkZTcWJi?=
 =?utf-8?B?cVNBR0RuSmg3YmM5dzh6WVRNT0xoaHRlZ1E3djBOM2RmQU9GL21RVENyQXU0?=
 =?utf-8?B?bUE4MUcxakNlZTl3ZzE3a2Z2N2Z4d1hPUUc5TjF4d2U4cVd2ak5VN05MajRr?=
 =?utf-8?B?ZjdNQ0dpbnNLSlVKa3RtZzBiUlVqZURKaXJKTENGb2dTODQzQ1pYYllTbGRu?=
 =?utf-8?B?b3BtU1h4NmJyR2pvWTI0VE9MMUtJczljb0w5MjZoNmdDTmRlMDdqNnJ3YnNl?=
 =?utf-8?B?dE1xNHY2YWkyaXM1UEhLb2lTRlZYVkZiUklOY29vWitMbmpmQVo3ZkNDOGxG?=
 =?utf-8?B?ZzR4SkZRcXpUVjBEdnYwK3dIQlFITC9mekN3SjdpaGRVT2lQakhWd0RVMm9k?=
 =?utf-8?B?cllBZnA5SkdvSlZXLzFRVHpRMklTSmJRUzkrQXZlZ1NKQyt2bmZ0UVVieWpu?=
 =?utf-8?B?OFpQVE9NQ25QWFpkZlh4N0htb3pudyttRWdpSGpGNXlhZ0sxcGFvdU1WVS9t?=
 =?utf-8?B?ZWJCZGtuVWdBaUpiaWFmZUNZbGF2b09oWU0remp4Nk9oRXpPQVlJQ0I3QXYx?=
 =?utf-8?B?VnJkLzdZdlQ5WHFRdGxBOFhDQXNaNHA2emJhK1dVa3BIZUNRcGJFdm11MW1p?=
 =?utf-8?B?a2RIQ0VrT0cxNHhWMlBUdmdTdFh0SEFZVElQdUhwOTE3Z3ZTT2J2aEtFRVVC?=
 =?utf-8?B?RE50bG9SZHBFalFnN1pkTXNDZ2tydGNmSGtWUmo1dGRXSWVKc2pVOXJVT2Y2?=
 =?utf-8?B?SlNyOCsrVjI2OGJtMDVXcDhaSUxZSGJqOEpwV0RWUnlwZWd1MmNVK0dQT2c2?=
 =?utf-8?B?cnFnMy9yZFh4dmJaM05lMzFXZTB4WUpJbS9zaVI1OGJPNjZ0UGNkQk0wc0pW?=
 =?utf-8?Q?cW6Skjg48Bv/iLSpXG7mhKgRv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BbjyAtUUqACx0hXTafU7pREFtP2IdnnQhhTZnlkRgx4QkNVvQ+MfhRKq+NO7M2qE9LODMzKvPzt3xsn9/8C2avlgax9COZH+7v3rpaS+sH3avu517VL4EJXJcyl0FaEaSZ1xCUTU9E4hvsl79BC7C/iSubhbwBHz9sBmNy3Q4gOamKf66SXJ5F9RfFM+j35ssYkz/rG1gOoL0fO3BI2KgJ3VZvxy1UCnlF5eoTgWo4zWgsvP7cWqwO7M2U07ElTmnmanNBDZ9vlheAjWSL2fpDcIhawkOunMz7WQY4C17X4K9SkpwrYcwBW3gmSVv6WvDJdto3gi5MHhESB8vp6V71JbBYd/dNB27tz+XybwPeO3yfQ1TM1s60AOwMKZ/pqO+kW0MJSmwHDLKrjWqDoHxFLNaEwKw14TbWs3J6B6hH4c9hrBG2s/XMbBtnscoB/ghPlEIWjw3wok7XyCm+Fu8s6UwbjHRacip39HJBMEciOfekfuHqEn6MTrcg9N7ZRsYVX9GhEKhzq9aCBUfztB4M5qYXxL5CPBZ221vLnQSKXWdu3uANmPs70rRI2gpMn/rj83gg6cTpdJsp7uzH5UerDhu7F6qDwZCodGbfUNSwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bcfaef-826a-48f1-f108-08dd9be0f4e4
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 23:07:44.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtI0G3xuGyJVl9AhaG7bhIisVEYZGRmHiGRJOqMoKihUSvj9Zyztgc0DF6p/aLEpzUm4yD54IAnZnIWQ/x1NYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-25_10,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505250213
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI1MDIxNCBTYWx0ZWRfX6x16rARVLJZn nseIqqfiuvIaucBmr/Qfw2ewwU7oSqE3cM6hKu8WVjhV+yHD6mIJtdWLGzpQPhQnwZUKS4uxqpj isG7UO/s60LiiKRPOUl8evkDMCOd8hXCvyfkThVu+ZQM32thhKg1NzVEzaJejbI1hfmbWpV45fC
 ijgeOb+sEBmivZOE/6LErE9nJqDO+qX1V/2yGk6F5dhiPORMA/2owUyj+Qh9K3HCRAmr+nqizqN cH9rF4VJOWks9EFteUMuWcqfsEFDjJiZGsXKv98wshWjedpZ0AG9oTeFSk57d/7UzrnMd0sEx/w le/NtlgXnNpsnjmU4Qc1VGWQOVTd959XFyAQM20LzqetZgBFrgp366UTv/YMzwZxEP3wZjuZcAh
 WeNvfxvX5YmcysUguBao1DNJ3SW/a0Uojn+mE2FpTjXF+x6qlvbGtZDXgH1TmqEl9zGNcCGa
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6833a2cc cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=OLL_FvSJAAAA:8 a=Ym88_VSRhwyD_vG6xxgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e72awE5OOzsA:10 a=ubxQsdc_O_wA:10 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-ORIG-GUID: vRjwPKnYrtXL0N4Pt-jp9HC91j2yjNFW
X-Proofpoint-GUID: vRjwPKnYrtXL0N4Pt-jp9HC91j2yjNFW



On 25/5/25 19:14, Zorro Lang wrote:
> On Sun, May 25, 2025 at 01:41:11PM +0800, Anand Jain wrote:
>> On 25/5/25 13:28, Zorro Lang wrote:
>>> On Sat, May 24, 2025 at 03:52:54PM +0800, Anand Jain wrote:
>>>>
>>>>>      3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
>>>>
>>>> There’s an additional fix on top of this patch that doesn’t have
>>>> an R-b yet, so I haven’t included it.
>>>>
>>>> https://www.spinics.net/lists/fstests/msg29195.html
>>>
>>> I saw you talked about it with Qu, not sure if you've reached a
>>> consensus or will send a v2 :)
>>
>> 3bbdf4241 above has a bug, which the patch in the link also fixes.
> 
> Oh, you tried to fix a bug of an un-pushed patch. Why not review and fix
> it in the patch itself? As you've prepared a seperated patch for that, I
> suppose we can merge the previous patch at first, is that good to you?

Yep, all good with me. I sent it last minute, so I figured I’d leave a
bit of time in case anyone had thoughts about using the golden output
for KABI checks. Pls go ahead and merge these two into one, if you are
ok with my changes.

Thanks, Anand

> 
>> Others need to comment for the RB. IMO, we should have the error
>> code in the golden output to make sure we're not breaking the KABI.
>>
>>
> 


