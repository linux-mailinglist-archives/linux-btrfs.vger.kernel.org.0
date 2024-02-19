Return-Path: <linux-btrfs+bounces-2522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F93785A4AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 14:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38422281236
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE9364A1;
	Mon, 19 Feb 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a+W3RCR4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EPiG8oNc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860ED36132;
	Mon, 19 Feb 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349622; cv=fail; b=GUcWrw65OPf7hDWytBSOrrnXEOVWGazFHup++4qznIDAh4GjhNovvcllOLDljLc40bImo86Dov848Oh1pexjNtGjWhke2jLdg2rM9K7DAk9ihU3i4nBYmKn3v777gM3uxNTLPJ0I18t8A1qo9vR3g5ka4JzrO9HAG1AoLC8XztY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349622; c=relaxed/simple;
	bh=VtLbsP6ulNkbGFZby3jZ74JG3M8cp3flD0kChv52Dkg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qImGM/B3gH1+liw1ZBZHi+d470no5TqttKvLbHOaPHH3a1bcyzIefdAvmyxWnUmIIl2vjkSZn3XCWT5unIOq9wfYDitpDGq9gRiaNRCaGlqaIldzHFNvB2bnH/+4Y7Hmbyjlx1yBX7NRsWpOmdBhWMFI8qHEBBQ6AsXqvDf+qc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a+W3RCR4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EPiG8oNc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8ONMa024950;
	Mon, 19 Feb 2024 13:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UWEOu/YQZCULRlK3p7dAEIefyzkMIP94CPTzgUy8bnc=;
 b=a+W3RCR4kqKmaB+gy07Tga36xjhw1o9UyYh+5MnP/Sghg0fD3X70xHZquSNMdE8/SLQa
 H7RibGE5Wae18aCHpJDZd09lKTRhb2KRIthS21cm0QspsL4cMw2BRz/KFHItQQ9LD5Hi
 mFIKSuEazpSlnZTFCdLkR2Jl2OJ7730WXXzRoxQb/yU8nrLttXKq3zhpb2+PHHOhNxJR
 dAaZ0DP4lCOPk6lTVz/jAsd9OCsjdegeiXSjRa0SnXuHoFYQArz3fBxMcr+MaCy74noj
 CFmC0LgnxmF8wZOE9IQTikURa1gyXsekrB2WPsV2KX0GJc7ojcqSEDM6ASwXKdGgNj8S NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvc1u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:33:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCPJ1o038067;
	Mon, 19 Feb 2024 13:33:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak85wvmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:33:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAAvPn1U6AJ6b7O2g2nA6T1sHKQPMoHkbdpIlMemDg2s8dDjYb246eSWrmS96K4gXroRDFjVJLsuSxnitJc94YulaFkA2tWT33Z6S/POU8uNFQNi8nXvoYk1qmuDTsJwKHkU2E78icOsgf2Vc1k7VolR6F/PobAA2YoGYyYPMkGAEHIuoXMgtM8B7/qRrL5/9OoS7K1pyC77YV5J25eUcKElfBPSVBg/S8dz0oc3RVoa//q2lg3N+nE4jD2NxgSMV2yjyKiiYIOqOcaVSg7Md87lTgkMXVRvdgJQWcp+NHCLmZg8Qu5DTmukNdex8rWCZGdhCth9ATvjFUbCu6I2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWEOu/YQZCULRlK3p7dAEIefyzkMIP94CPTzgUy8bnc=;
 b=nv+592wAVMo8NYYvWbi7Vc9pAsWvnVAx0qD8urx5wK7J9iYQG0cTWRocSTRhz2nY4kogQ5miIYRrQrdBfCltfT0rdYV3njmkC4Z+FCsx3rCEC776LEfz9/o16lcY4FNopCg50mRQWWt1DkSsWAZgcjW3CSMT9OMRMgn5WO3DuBmzyVu8fCnYWU7dv7RnGocvKkDh6ymfDliH7sauKr8ahVHk0znpHzymYBNCjAyDf9KgImC2hiMwHJgRPJJkKldLKmPDOUrtpc8SGvLcmtmvIfKSrPsjG6I71w7uA11vwS6L+XMbIq3+d7xsvoihAiK1I83Swn5pxvT64I0NNBTw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWEOu/YQZCULRlK3p7dAEIefyzkMIP94CPTzgUy8bnc=;
 b=EPiG8oNc8jwemShK54FqTl9NFQn4EPPGOpzZCZtYhAlRkB9TYLUjVEL4LJv4Pj7QVTEH4fywKnDpGCoTk827+7gS7OdaQL2cr/sUpf/TEzKzLFtV7Z6lhBn6nn+PXtorzF5UaIyZvl2TkSVmzhd23pnwEYdj93MqMtyZ07JYU/o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6196.namprd10.prod.outlook.com (2603:10b6:208:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 13:33:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 13:33:34 +0000
Message-ID: <f30c9409-d365-4663-8574-c5cb7c766440@oracle.com>
Date: Mon, 19 Feb 2024 19:03:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] btrfs: test tempfsid with device add, seed, and
 balance
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707969354.git.anand.jain@oracle.com>
 <325a9476e06cebee3752d32fd06e75b2f478b8bc.1707969354.git.anand.jain@oracle.com>
 <CAL3q7H77SEYPongbHn9auS7jyvOetD-8gD3oyQ3e+7pJuPVbSQ@mail.gmail.com>
 <c754b3c6-040c-44bd-9e50-ce95f4c4c4c7@oracle.com>
 <CAL3q7H45Sm1JMTHHpvBP9hB3ogOgRpq9cXyAQ9n9-oyPxdAMVQ@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H45Sm1JMTHHpvBP9hB3ogOgRpq9cXyAQ9n9-oyPxdAMVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bd8044-da9f-4ccd-27a3-08dc314f5ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kTdoKggWIR+2qNwnVCUk0gxx0kOZK8Hm4tksZCi4Zz/YRPYd0nmdRK6jov4gyrNP5+gDsQ8NzbyRZO4rNn4PDcz+5qjSQgH3SI/MgBX6BMNzSnsiOfj5bumuJAi/vUhBV/9S9DBTvJTR1/n7f3bKa3nPS7cMPTLVwwFpdFm+SzfJ6vBgZJkyydja7+rFO7U/zsJPtueVCFz8r6lGjq4lDx1W6ZFcdc+Lrm9hwSbFN7GoKh6/2BsJgmYEhycVKZvCA7DvPFwPB4F1E6kMFtghNHwNZ/a0bsM96rGjZ2aoH1UNpa+4Qe2+r6buxPLRPw/mg2E7jDeRSf5MydjlaFoBO3anen2c/6tUwrmKM7b9B9wAxHdBBj9nyWLcMjb+Wo4WPHXHnyFdtTwc3+6yBkZcG4/xYTowHNfl8OIsM/L8r7XWAqBlqvBt56Mwb0tLdk23aBedpWUNKOosRYnpvzBmPA+z/f3/rvbVVD9dCeewDCgMoNHy1VOUnLUpB5fcK0SMsC9w5hg8GyBBw9vKZeTvj0TfYVjBz5YbK6QlHfyHJ2ZEsQbKvfLuyV/8nZXQIbhw
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDRsSSs0MU0xK2R3RGVDam8rVmJjeGJpUDRLTGlGSFVVcklURUkzQTRmQ2s1?=
 =?utf-8?B?UFlpSjE2ZnFuWTNnYTBFeWxwc0x1RmpLR0p6OHJUODVJNFpGN0xZdkhYcWFR?=
 =?utf-8?B?YWt2dENkdE9jN0ZFTkIxRENTZEhYWmhUWjJhRC9iVXlWZHBWd1B0cVJRZGt3?=
 =?utf-8?B?K2dLd0dPdEUzNWxlM2ZzUXB4L3YrMnhLY0ZFd3NScnJ3YUhuL25HWnJXSlZF?=
 =?utf-8?B?am1HVFZxSW12b0xnT3FCd2NjVmxyV2s0Z1M4WW1HTDVRUFRyYkdCWW5TOThC?=
 =?utf-8?B?d3BGWDBFcWpDZ1g3SDd0M2xiYmJxTk1xT0JQbEdLWUF4S2VVeDEyN0RCZk1m?=
 =?utf-8?B?Z2JlZHRUV3QrbkhJd2J0S1Y0SGljL2dLelZKOGVzN1pVVGdnUXpwN0REU05K?=
 =?utf-8?B?S3A4Sm5UT3QrWTdsWlFGVHg2SjdneGg5VXRUOFNtRTAwRjNMS2FTdzVBSSsr?=
 =?utf-8?B?NEppdWxrRzJJNFE3emZ0SXEvMmh1cTlxSk5lODNCTklnMXBEclp0ZmNLSFpN?=
 =?utf-8?B?ak9xdW5TaDhBSWxzUlcveTI5aWpaRHU0TXVST2xKSktaSEVad1RYUkttWDdI?=
 =?utf-8?B?Tk84TkJ0c25neThVZEhGTTlBdmk0QjEzbm50eldQUnhGckYvYUdnaFJvNGpa?=
 =?utf-8?B?YmVtQi9SYkFVN2N5alBJMzRZSVlqQ21hQURkKzlqNGsxNGhlUHZoVDdZeGhm?=
 =?utf-8?B?cVhFMGlmTS9MRmZiVzFnQTJ4WUhXWUJSZnZKSnBNUGV3bkFEc1lYVjE3VEZQ?=
 =?utf-8?B?QktBY1RNeG9sU29qS1VyU2J5Y1BIR0tNUFZnaDBTVldzOGR1Q2gyRWxrYVhN?=
 =?utf-8?B?WXY3bWpiV0xINS9aVTZTeTRFUHppQ3A4Z1E0Z1dnSzhaR3FsTWJCRS9kZE9p?=
 =?utf-8?B?WitLcktSa044bTVMZHdMdE11NkNaRTRmN1VJWVZ0S2k0cFRpejBpOU5ybFI2?=
 =?utf-8?B?NXV4ZmEvZ2h1NEpBajRJZ0xac2E0b2h5Yjd1b2Zkd1lZam5HWUdyUlM2OHBM?=
 =?utf-8?B?R2tJSCtUQWhtb1NHUy9ZWEFkWVdTaDg3QVY5RjFIQTIyQ0NjUWRBNzloQzhN?=
 =?utf-8?B?R1B0SnZEdmtFL01aZUN6ZEJpTUlkbE5abzNpSDFGZThkVGRmZTZRRXZySkJ4?=
 =?utf-8?B?bmQ5RjBoSUFDOTVRWlFaSUY1TlU3WHZJRHo5amtMRi84MzIwS0sraHhkbzhJ?=
 =?utf-8?B?V21RU1crZ1d4aGloRk9rTHM1UjF3Nzh3TGk2dnpQdDJGcWFjbHFwUnRLYXYw?=
 =?utf-8?B?UEY1cTQzMlJ4Y1g0Q3FKVGY1dkZtZmErY1ozejdrM3VXTld2blZ5cEZSNlBm?=
 =?utf-8?B?bmZSNTZxNi9GUVZDNDZOU0oycjZvMHJrUlpOdDJ2akhNWkcvM3IxTEpMMFVU?=
 =?utf-8?B?cjFRV3Y1aTNMWkIvMi9WOVFDcTQ5T2kzRWRMR1BVdVcwRThvK0VxY2VGdGow?=
 =?utf-8?B?N1IrVVY3OGJMMzNvbmdCdFdERVNVVUhSelFZOFNBU1J5Tmh3dEdVVnd2Nnc5?=
 =?utf-8?B?b0I5R3JndHphVzRYVko2b1VoZzU2MThYeVFhMm9JU0Vrdm9BVDFhOFVYcjhJ?=
 =?utf-8?B?dmovMzgrLzcwUkJwYWExbC96elB2cnErWGp4RFBYc0tUUGEzeTRrV09VVDdI?=
 =?utf-8?B?V0I4Ynlsajlac1o3UnFvNWsrMUwwVngrMy95N1VmTEIxYTFMVTR4eHhSWmNP?=
 =?utf-8?B?ZXFIamhZNU9ZZEFBL2VPWDlTdHJGaXJCV3dHRytsNGExbHlvVWEyVkhkc3hF?=
 =?utf-8?B?VVhGZEF5UTdGanVLbFNpcXpJYWt6SExUOWVieXBrQ3R6d2VLRHEyWFNiWEJy?=
 =?utf-8?B?RjdxNG5MT1hUVnFXNXNMbTNjMm82andPN0pDdUlJYjdmaUxmN0U5WWI4MnM1?=
 =?utf-8?B?N1M5VzdZcnRjN2Y1czMyUENvWWgveGtQVmhvRTUrc3ZnSEJXT2t3OUZkaDZS?=
 =?utf-8?B?MWFuZ1QyZ1RDcVNPbXJWb0tNVW9PVGROT3BOOHl1QlhJOWlwMU9DS0R0cU5k?=
 =?utf-8?B?cDgwZHFYQ1ZJbXZiNWJVSGZxOE9mWTM3dFduL1JzaU91MVZ6VUdveitNOTJZ?=
 =?utf-8?B?L1F3SmhDWVZSeXVVeVVkdzV6Y3NuLzlOMEFaaEVVYmFxM2JOTGZCbHdNSHkz?=
 =?utf-8?Q?mbyHip6QeWnt0RbEjY3Bxa0lk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HRB1kQNryBNUBDTJmkN5mMx76+zZWYZpx2wLkHPvM7QyvAS8P9VlyNW4JkG1oPnawVB5FEBMBrmO7JYesOerxtT+q3dsd56b7Pf/d0lxLXwTj87XcfyEXVj987PjxzKces0HaJwnqymHKU7Vyk5jAVGmLErvo4TCyVzAELutCm5Xxs2lzUYL0S4OHxYMefp4OoX4DDYSxuslMZzPdDTN/iBJgBQkK0IZOz231+8bf9uGjJHlqyuui77zLN2rZVWlVYrkmDIt4242w1Vy5gpTk5h47MezGW0Yx/C690QTe3b/RJqmWyou45zlg6i68R7yPeiil2ECR9ElLQe4oOTkwcYNC10UDD6KZue45/ft8mTa8Gq5SN6aQHn/EUplT2n3LQvy8nq7nF3+OY+tr14pZjqphmuPxoYxGje/PWnDM3LoWqRCkUKceanIwyT656/RSI7mWBMZ41V7aM/diBL3erTMTll2Sp0OY53iBVU8nx4GtayJ9eEgmAVPD1vgsTPfJx3Q9oKizkQfZRPwn95YzKuLic3l7SflBEhE5g5hJc3LBk7WT97LEVQySFezsBL47I53BfSDdk0T/BA8sDb4TmnpNMjxflVVJCd/Q0C5e84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bd8044-da9f-4ccd-27a3-08dc314f5ecb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:33:34.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BTQEVx/YNGD8f8V2SqTck1H38QhqMCThqQCi1syP4fpPvtPvksXSQDNDqGIAyin0OwwnWskni+d60tLAultzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190101
X-Proofpoint-GUID: KKAlv9c8u1KZCtZZWUMKEmm8zSBTYERv
X-Proofpoint-ORIG-GUID: KKAlv9c8u1KZCtZZWUMKEmm8zSBTYERv



On 2/19/24 18:59, Filipe Manana wrote:
> On Mon, Feb 19, 2024 at 1:18 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 2/15/24 18:33, Filipe Manana wrote:
>>> On Thu, Feb 15, 2024 at 6:35 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>> Make sure that basic functions such as seeding and device add fail,
>>>> while balance runs successfully with tempfsid.
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>    common/filter.btrfs |  6 ++++
>>>>    tests/btrfs/315     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    tests/btrfs/315.out | 11 +++++++
>>>>    3 files changed, 96 insertions(+)
>>>>    create mode 100755 tests/btrfs/315
>>>>    create mode 100644 tests/btrfs/315.out
>>>>
>>>> diff --git a/common/filter.btrfs b/common/filter.btrfs
>>>> index 8ab76fcb193a..d48e96c6f66b 100644
>>>> --- a/common/filter.btrfs
>>>> +++ b/common/filter.btrfs
>>>> @@ -68,6 +68,12 @@ _filter_btrfs_device_stats()
>>>>           sed -e "s/ *$NUMDEVS /<NUMDEVS> /g"
>>>>    }
>>>>
>>>> +_filter_btrfs_device_add()
>>>> +{
>>>> +       _filter_scratch_pool | \
>>>> +               sed -E 's/\(([0-9]+(\.[0-9]+)?)[a-zA-Z]+B\)/\(NUM\)/'
>>>
>>> Why do we need this new filter?
>>> We are testing for a failure, where none of this is relevant except
>>> filtering device names.
>>>
>>
>> 2nd part filters out the size part as seen in the raw
>> btrfs device add output below.
>>
>> $ btrfs device add /dev/sdb2 /btrfs
>> Performing full device TRIM /dev/sdb2 (731.00MiB) ...
>>
>> I will add a comment.
> 
> So that means the test will fail the golden output if the device does
> not support trim,
> as in that case progs does not do the trim.
> 
> That line about performing TRIM must be filtered out. Replacing the
> size with NUM is irrelevant.
> 

Right. I missed those devices that don't support trim.
Thanks for pointing that out.

Anand

> Thanks.
> 
> 
>>
>>> The test can just filter with  _filter_scratch_pool only.
>>>
>>>> +}
>>>> +
>>>>    _filter_transaction_commit() {
>>>>           sed -e "/Transaction commit: none (default)/d" \
>>>>               -e "s/Delete subvolume [0-9]\+ (.*commit):/Delete subvolume/g" \
>>>> diff --git a/tests/btrfs/315 b/tests/btrfs/315
>>>> new file mode 100755
>>>> index 000000000000..7ad0dfbc9c32
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/315
>>>> @@ -0,0 +1,79 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
>>>> +#
>>>> +# FS QA Test 315
>>>> +#
>>>> +# Verify if the seed and device add to a tempfsid filesystem fails.
>>>> +#
>>>> +. ./common/preamble
>>>> +_begin_fstest auto quick volume seed tempfsid
>>>> +
>>>> +_cleanup()
>>>> +{
>>>> +       cd /
>>>> +       umount $tempfsid_mnt 2>/dev/null
>>>
>>> $UMOUNT_PROG
>>>
>>
>> got it.
>>
>>>> +       rm -r -f $tmp.*
>>>> +       rm -r -f $tempfsid_mnt
>>>> +}
>>>> +
>>>> +. ./common/filter.btrfs
>>>> +
>>>> +_supported_fs btrfs
>>>> +_require_btrfs_sysfs_fsid
>>>> +_require_scratch_dev_pool 3
>>>> +_require_btrfs_fs_feature temp_fsid
>>>> +_require_btrfs_command inspect-internal dump-super
>>>> +_require_btrfs_mkfs_uuid_option
>>>> +
>>>> +_scratch_dev_pool_get 3
>>>> +
>>>> +# mount point for the tempfsid device
>>>> +tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>>>> +
>>>> +seed_device_must_fail()
>>>> +{
>>>> +       echo ---- $FUNCNAME ----
>>>> +
>>>> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>>> +
>>>> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
>>>> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
>>>> +
>>>> +       _scratch_mount 2>&1 | _filter_scratch
>>>> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_test_dir
>>>> +}
>>>> +
>>>> +device_add_must_fail()
>>>> +{
>>>> +       echo ---- $FUNCNAME ----
>>>> +
>>>> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>>> +       _scratch_mount
>>>> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>>>> +
>>>> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
>>>> +                                                       _filter_xfs_io
>>>> +
>>>> +$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} 2>&1 |\
>>>> +                                                       _filter_btrfs_device_add
>>>
>>> We are testing for failure, so no need for the new filter
>>> _filter_btrfs_device_add.
>>> Just filter through  _filter_scratch_pool here and nothing more.
>>>
>>
>> As shown above, we need to filter out the size part too.
>>
>> Thanks, Anand
>>
>>> Thanks.
>>>
>>>> +
>>>> +       echo Balance must be successful
>>>> +       _run_btrfs_balance_start ${tempfsid_mnt}
>>>> +}
>>>> +
>>>> +mkdir -p $tempfsid_mnt
>>>> +
>>>> +seed_device_must_fail
>>>> +
>>>> +_scratch_unmount
>>>> +_cleanup
>>>> +mkdir -p $tempfsid_mnt
>>>> +
>>>> +device_add_must_fail
>>>> +
>>>> +_scratch_dev_pool_put
>>>> +
>>>> +# success, all done
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
>>>> new file mode 100644
>>>> index 000000000000..32149972beb4
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/315.out
>>>> @@ -0,0 +1,11 @@
>>>> +QA output created by 315
>>>> +---- seed_device_must_fail ----
>>>> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>>>> +mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exists.
>>>> +---- device_add_must_fail ----
>>>> +wrote 9000/9000 bytes at offset 0
>>>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>> +ERROR: error adding device 'SCRATCH_DEV': Invalid argument
>>>> +Performing full device TRIM SCRATCH_DEV (NUM) ...
>>>> +Balance must be successful
>>>> +Done, had to relocate 3 out of 3 chunks
>>>> --
>>>> 2.39.3
>>>>
>>>>
>>

