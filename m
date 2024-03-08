Return-Path: <linux-btrfs+bounces-3103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958408765A8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 14:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977091C21054
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661B3DBBF;
	Fri,  8 Mar 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5M2OCr9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="URnMnga1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35891DA5F
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905960; cv=fail; b=uOey1EV3ibCbYzwDzcnr7wkRL48Y8iCQ3x/5DpMpoY3sV2srsqOD6uNR9duaSKHqabr4kXFk2pu0ve/bPvmeGtRkjYMe28+AtyU1pys9mCAC9bTEkVH2TpKFW/eyEFH0qsHQ1vaVMMbyOKclRTd3xJwybHP6sjctEKBj4gZo9zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905960; c=relaxed/simple;
	bh=P/O2psWMV+0BRG4Cm1CNU4FDMcPWGDZG1eZK8N9vfNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXvdZd96wXIgqMPZ83nX+9I5NskVg1HGODb5dajLSugq+JxKkaB713Uea8yl2rZNX4e8miFY7t/4acDzjDJenBSluEIUE7GF0vuOiHfxoVMaHC2w/nJKJhdspYISfcGjYRBnPMM5/nvBSaqZmUbe/DP0ODlYC+Nr3+50jAX7hg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5M2OCr9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=URnMnga1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DTiOu005349;
	Fri, 8 Mar 2024 13:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ggBWLmc++oP+gLmfgULRWI/cVXQnIq6ksHLGF+q1C20=;
 b=b5M2OCr9uBsYQxlY+VtfaiMeK8ynZGdDK9zXdkyAepo7D5jcacHzsNsoBbF6/P5VQA3X
 VjLnD3nX08vJJZLkXLf9s18w9hqKPrdQIHIGSYg7/6B0v586G0hI6Sg654wAoB5S7+p4
 uGIzR0k19wSrClpd8l2hnqXr0a5ejyH7lnqBA+a3E35EMaZI9igp4na1MNqT7Vp1cymA
 FsiVjrMVplteayMB6yvbV64OOGOQDp/y2+bIc1tPs83HnOjRbjdKQQ4tfH50ycYkH6XS
 xxyVYxjxkSYkPWRaT2dyAsZQZFx+4fXTdjd53hQuv0g/SBusrX2A/tY3lun9Me8hJMvp Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cp0xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 13:52:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428DoZCl013796;
	Fri, 8 Mar 2024 13:52:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjck98e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 13:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ2ofOQUfsHrWMQEpYGq9EMfeiaUArBKw3LK/OZNuqn64BUubMJNA6Ot1FSJM3R5sl5gGpBS502I6GE7KY0yKduXmNDfzWR8HROJ8ovInSo4BM4JIv3ykGYtMKWySmIQQrQjnCTd1DIFPPK/BWNhxxY/3KLKS+XQscSuG0223/QUyLoasgQ/zTL+EvW+R0BN/qjOCqxBrCMQZwUJxm+vHmBm7VlgTdpz/VASYjonX1w+bz3dpsc6fXcs9/lbFF5NTpoKWQmTHYHqjy7o/WF5Flz+wplFP8AJs0X61zn91eACGtmcYTEXsZ8MlrlqJRWfFxlCWkg7T5cH6BUBcSURZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggBWLmc++oP+gLmfgULRWI/cVXQnIq6ksHLGF+q1C20=;
 b=YfP57/eDjtmWafvypZSqaeDsN5f1u+cyjZSUzVlajBo/4meB5jRQcr7QjWf8CvaKOQ47ZvtCJhn+ioKeQqfHoUZLl3TOCXRbMStBjv3SbP0b2iYoC2SujPLHlCvqSKv3JxqE4m/oexoSyXzfKmsjM9vkLaQrFVbrhx/W9JwJxkmPqV+djgR2kq6e16K6Au3ZTNAnd0AsK9RJkivio6FEkid9tZhLnsxOljmxbZcy372I7kK7phaokYVLycbVrbUsmwxaTv5Q7qkV3DS0gMNoN0pKiDjwO8QEFvXDmntrz66naiivFPGTW2cyGYRE4N4uho+QXsvfLoj/xMJVdxYaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggBWLmc++oP+gLmfgULRWI/cVXQnIq6ksHLGF+q1C20=;
 b=URnMnga1nikZazkjpVAqznmxb85h06PuqFtPRnahbLcTBtCklIMJA1saWrDSJ3fgUrVhuoy/4PVi1DF65zfA6T/+SjmUkM0nrovGGdniPqe5cUFiunTXf+u9tNm3MbMRmtUnR+VcO9M6eSL+X0CRONOagSZsX/hi3ORjggqVf9g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6491.namprd10.prod.outlook.com (2603:10b6:930:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 13:52:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 13:52:23 +0000
Message-ID: <03bcd60e-33a7-4bc9-b048-8ae8de6ab9aa@oracle.com>
Date: Fri, 8 Mar 2024 19:22:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, CHECK_1234543212345@protonmail.com,
        linux-btrfs@vger.kernel.org, aromosan@gmail.com
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
 <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com>
 <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5673a7-f66d-4400-e4dd-08dc3f76faeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WUI72aHRnkv9YsIoYeeRRjf07GQXjQPGCk4cpwlTtd5jAm+6QN7/QSq5VN5QS8VfNepsZqu1+t/mJiqUJ4VCpLTAxMmu9x6EqiQ7zPvdXXQJYrbyDSv2oJPUsFWJLnX7ej0Jcvf1an1ejP/Q5WxUK/ribM3u1XTXA0AJm5Lvukt8AzGmO43oVo5YBfliJ0j+jDk2rVgz+qeQJSSMEpINHlsR/Wtm1YbX90evk057gnvo5egqAFXrAp+GAVJjqu29fltQLawqWv4SochcwzRq++UUBEDxd6JkyTrHnFCJq4peICxjFdRVUaFa9bQAcU8qnholnuSxYOG5IP4sTRTfY+kgK+EC8OnUCk452L43riQ9hHCsFvPrQ/TNbN7fO0WtT+xGcfgGIhRP3seyGErzQWzyhuY4QXeebuEZXt4nfsdOm12uTBFL2aFQ4SixrDmNonJPV9N0N2lTt3slRrjrQG0/9gqacd1FTuJrdo/YprGT8ZdCoFmxtyrL7m9zCTZ/Am3zeOn1hCvo+ZN+B3tsdl237hLExPuyR5dupoMm7+2sviTGj+NvEuZg49BsYi5QOh4NBXURSzKcmnCmzO3CyYeM/kTxQuPAYI3KwK7RwJnzlAQ6C8d1qcv3jU3/89RF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjhXdCsxZDIyQ3JLTHc2ejJJRFFwYnZJenEwWlh1bHJ1Uk9LSkpHSzhZNXBo?=
 =?utf-8?B?VjRwVHpxRGFEekVCSkpMMTlwUG5YSUxEVGFMeHZObnRMYzhiRy9Vd2xsa0dX?=
 =?utf-8?B?U1J6cmJmWDdqNzRaZGQzcTFQQUlxTEZBTm9LcWdVdG5QMFdrZEZYYXJOb3hE?=
 =?utf-8?B?cEZtY0gxQkx3MlhqRFVCaFk1Y1l0NXJSa1V0Sk1sdjFXeS9TcFR2Qmp3T0Jw?=
 =?utf-8?B?Y3pIWkFhVVY3WjlHUlpyR3VyWWpJOGNxVThGRkFtQktMQXllTE1pTk5xMnkx?=
 =?utf-8?B?R0lraUpFb0liRnFFelNQc0U1b3NSb0pRWjFzWG9tQ0ZwTDJVcWEybVR0c1VY?=
 =?utf-8?B?Sk82RlZQalNoYVhhb3JRRnFCbTRQT29ReGpJa3k5M1NRNy83Qmc4Nmo1WGhs?=
 =?utf-8?B?K3kzQk1hVHlFRlljTTJwenJNOXBUTjlQbnVLMlM4bDRjZlpCRVJiWElZdzF0?=
 =?utf-8?B?NFp2QlRidEozTGtRK01BY1lhK3RZT0grVWVXWGliMllia0o4N1h3QkRsWmI4?=
 =?utf-8?B?TGovWW9mTCszOS9MWEwvc0dBaXRvSys2V3lZa2NNUkFla3BDQktCNmVKRkh5?=
 =?utf-8?B?QUVVOHQwYTRDaDZjL2RwRE5oSVdJU24rVVN1Wm0zWHBMeUlOT2U2MFBjckFC?=
 =?utf-8?B?OVJuMERaUG5KOEc0ZEpGcHN3bTYwd2kxZVlLL2lJM0tDMzdBaTBOcDJEWkE2?=
 =?utf-8?B?eGhQS3R6Tmt3b3RYSTk5ZUtaRG82R3VlZHYwWUNpSnFkeFhrTW5IS1Y1aXRG?=
 =?utf-8?B?YWh2MXdLYjZoZEYvdlVpczN0bFhuTWxEekwwWTdYckhzZ2NKNTNFWEpJQjhN?=
 =?utf-8?B?dDIzZHBIbW8xU20wOU4vN2tRODlGMFNEQnZOK2VESitnY1c0V0pUVkpVVFRy?=
 =?utf-8?B?T2RHZ0xDMy9jWmRubEhiQXRVK081R2RwK21wQ0J4VDc3NWwzS3ByZ2ZQT2k5?=
 =?utf-8?B?UDZYbHBUMXp2L0xXa3FubzFOcy9DZDVVaHFVMk1wcC9hR0RYQTlBcjcrRWpM?=
 =?utf-8?B?bHVPVTR6M2dVMFFHb2R4akdHRlpWdVRwaXM0aEZzMmdOWU9xc3FSZDhkVTZk?=
 =?utf-8?B?MmdzTWhiYmVWdE94bkpYUlZmbFNCZENKa3EzVVpWeGVyRTROVXd2Mk1EaVVq?=
 =?utf-8?B?VCt2MllpNUsxWFBPSkFPZkc1U3JteU92bStYcnhFUGc4aWZyMUxGdGpDNFJZ?=
 =?utf-8?B?NmkxcGlDNGN2RGNKN2pzMmpzVmFrbGFYSjBNY0pVWE5EUFdadXZaWncrUGt0?=
 =?utf-8?B?dkJ2cGdmZFpkRnNMOHQ4dnJlUGJsMlB6N21oV2xCc2JOZ1ZqclRqanVSOFNL?=
 =?utf-8?B?UDVvNEpXVkQ1Lzc0VFN5OXNLM3R4b1p3R2VQYUhJUUhKY3lETEhMZDJpOUZi?=
 =?utf-8?B?NmpQVW94RG9iRzkxemxlejA5TnlTeUJnOTgyVk5nNWtEMFRuUS9XZ3p4aG1q?=
 =?utf-8?B?R2hQT09XVGMwZlJxVHNEUWJPTXJZd0ZZdTl6ZFhjYmxGb1lKVWc1TmhtRXZz?=
 =?utf-8?B?NmdRWC9KZGIxTi9SNkNNaTdzSGthNjBzZm9IWVpUOVhHRUxYNlNDU2Z4VXJP?=
 =?utf-8?B?a2NuT0tBcldNRGV3U3NPblVNK2Zmd2FkZlNmbER5RjhxM2NCR1dUbUtOdFN2?=
 =?utf-8?B?VENEZjJhdjF6anUyZDJKck1KYTNDR1g2a2dobWJsT1paOE9HbmlmeWZSYWNW?=
 =?utf-8?B?Z0pYeVpPQXBWZzlsVDU3THNOdi9BWUtrOWFxQzRRSnZURC9VQmMvWUpZOXB5?=
 =?utf-8?B?bVJoM2JoTmg5MDVMaUd2ZjRRM1puajFjZGJIQ2RrcWQydFZ5V1FTQTAyNFo1?=
 =?utf-8?B?VzI5SVM2eEtia1FpRWdGWXlraUx6VE90WnRpNHhXTTN4RGVLTitSdEVyLzRQ?=
 =?utf-8?B?UnlWalpuZUFMdGhFcUtmODdVOGZnQ2R6TFkyYzBrTkNXaE13KzdyS3FlZnkz?=
 =?utf-8?B?RE94WWwxbmZzZzZhUnh0MjNrL0xwbWVNSmxWcG1xcEJ4UUt6cHRxTGRlMGpk?=
 =?utf-8?B?TTVkalBJOCtpMC9zSjJlenR4YnhRaVBKWTBuYzhoV1ZKZW52OVR4bG1OeDFP?=
 =?utf-8?B?aTlzeWs2VVpGTW1DSFpzQkc5TWp1YzdieEYzc09ybHdhOEthcnc1SW5ucFRy?=
 =?utf-8?Q?11r6wVZLoskJfSfBVqNa4Yh1x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ACYqU2Jkqbu7jGCRVEdxuQsxho5dOno+Enl5Clf1M1Yr0IgmghJn1iKqjQMHNZiJ5RpDY2PuEcRhvynKeqRPhDvbW0UbrNdzCSD26s4Y0jmwtF2uamzniLkx4IFVdj1ldrp+uFDjivGu0bkeR8XEB1pOu0oJrnCVDmpQ1CzBFiea0Yi8IATRbsTCaMDpE3RecWUn6kLCbJDA7wKE/QHgTobwTmvYTTo42VUaI9Qe7eEt+R3ZJB37FK2DlteE7aG/01aoVEvP2kEC3Npy40aBk15X5LyQ9Nzj5zqznWD6l3WKsRMTtL5I8M7AKY2GBsDIM0jzcDhfDF0JI+rHd3G5r3Qfhw8zKzz92NzDhdK0Hz4FZWHFzIpy3JNqDd80eDoPIMF+XCVKCTs/egpSbpBIlW8cifcuRI1/MpSwOINK4+T4c5NJkLNpTOuefMDo7+dacL6deZnlCxOg0Ea4o6TlwqAqPXohFQ65pyJKFAG14x/Ebn8EIOupI+0vkoUasxge4iNzuM2Ro9RyWUfsfypwDPDRC+UCZ85UXUnjv8jGKXuoAsUCIy9RuV6AchuQTXQRTc9gNSeOrpoce3CmwL2VmY18ccMWgyKqgSi+VCECbJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5673a7-f66d-4400-e4dd-08dc3f76faeb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:52:23.1273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5pMq5tRHnS+9jEmdTgALV+US/q/tX7cjdP/4h9B/w3OHMdcSznegn6h/tgas4tetQ4Z+8s7X4vFVCzTTLgpmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080111
X-Proofpoint-ORIG-GUID: hH6FtLjMRILtS4Jrxo8wRZCmSNzTrOgI
X-Proofpoint-GUID: hH6FtLjMRILtS4Jrxo8wRZCmSNzTrOgI



On 3/8/24 17:45, Filipe Manana wrote:
> On Fri, Mar 8, 2024 at 2:28 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Filipe,
>>
>> We've received confirmation from the user that the original update-grub
>> issue has been fixed. Additionally, your reported issue using
>> './check btrfs/14[6-9] btrfs/15[8-9]' has been resolved.
>>
>> However, reproducing the bug has been inconsistent on my systems.
>> If you could try checking that as well, it would be appreciated.
> 
> Sure, but I'm lost as to what I should test.
> There are several patches, and multiple versions, in the mailing list.
> 
> What should be tested on top of the for-next branch?

v4 is the latest version of this patch, which is based on the mainline
master. As you reported that you were able to make btrfs/159 fail with
this patch at v2, v4 of this patch theoretically fixes the bug you
reported. So, I wanted to know if you are still able to reproduce
the bug with v4?

Test case:
./check btrfs/14[6-9] btrfs/15[8-9]

Thanks.

> 
> Thanks.
> 
>>
>> David,
>>
>> If everything is good with v4, would you like v5 with the RFC
>> removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
>> it could be done during integration? I'm fine either way.
>>
>> Thanks,
>> Anand
>>
>> On 3/7/24 16:38, Anand Jain wrote:
>>> There are reports that since version 6.7 update-grub fails to find the
>>> device of the root on systems without initrd and on a single device.
>>>
>>> This looks like the device name changed in the output of
>>> /proc/self/mountinfo:
>>>
>>> 6.5-rc5 working
>>>
>>>     18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
>>>
>>> 6.7 not working:
>>>
>>>     17 1 0:15 / / rw,noatime - btrfs /dev/root ...
>>>
>>> and "update-grub" shows this error:
>>>
>>>     /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
>>>
>>> This looks like it's related to the device name, but grub-probe
>>> recognizes the "/dev/root" path and tries to find the underlying device.
>>> However there's a special case for some filesystems, for btrfs in
>>> particular.
>>>
>>> The generic root device detection heuristic is not done and it all
>>> relies on reading the device infos by a btrfs specific ioctl. This ioctl
>>> returns the device name as it was saved at the time of device scan (in
>>> this case it's /dev/root).
>>>
>>> The change in 6.7 for temp_fsid to allow several single device
>>> filesystem to exist with the same fsid (and transparently generate a new
>>> UUID at mount time) was to skip caching/registering such devices.
>>>
>>> This also skipped mounted device. One step of scanning is to check if
>>> the device name hasn't changed, and if yes then update the cached value.
>>>
>>> This broke the grub-probe as it always read the device /dev/root and
>>> couldn't find it in the system. A temporary workaround is to create a
>>> symlink but this does not survive reboot.
>>>
>>> The right fix is to allow updating the device path of a mounted
>>> filesystem even if this is a single device one.
>>>
>>> In the fix, check if the device's major:minor number matches with the
>>> cached device. If they do, then we can allow the scan to happen so that
>>> device_list_add() can take care of updating the device path. The file
>>> descriptor remains unchanged.
>>>
>>> This does not affect the temp_fsid feature, the UUID of the mounted
>>> filesystem remains the same and the matching is based on device major:minor
>>> which is unique per mounted filesystem.
>>>
>>> This covers the path when the device (that exists for all mounted
>>> devices) name changes, updating /dev/root to /dev/sdx. Any other single
>>> device with filesystem and is not mounted is still skipped.
>>>
>>> Note that if a system is booted and initial mount is done on the
>>> /dev/root device, this will be the cached name of the device. Only after
>>> the command "btrfs device scan" it will change as it triggers the
>>> rename.
>>>
>>> The fix was verified by users whose systems were affected.
>>>
>>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
>>> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
>>> Tested-by: Alex Romosan <aromosan@gmail.com>
>>> Tested-by: CHECK_1234543212345@protonmail.com
>>> Reviewed-by: David Sterba <dsterba@suse.com>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> v4:
>>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC stage.
>>> I need this patch verified by the bug filer.
>>> Use devt from bdev->bd_dev
>>> Rebased on mainline kernel.org master branch
>>>
>>> v3:
>>> https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com/T/#u
>>>
>>>    fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++--------
>>>    1 file changed, 47 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index d67785be2c77..75bfef1b973b 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
>>>        return ret;
>>>    }
>>>
>>> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
>>> +                                 const char *path, dev_t devt,
>>> +                                 bool mount_arg_dev)
>>> +{
>>> +     struct btrfs_fs_devices *fs_devices;
>>> +
>>> +     /*
>>> +      * Do not skip device registration for mounted devices with matching
>>> +      * maj:min but different paths. Booting without initrd relies on
>>> +      * /dev/root initially, later replaced with the actual root device.
>>> +      * A successful scan ensures update-grub selects the correct device.
>>> +      */
>>> +     list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>>> +             struct btrfs_device *device;
>>> +
>>> +             mutex_lock(&fs_devices->device_list_mutex);
>>> +
>>> +             if (!fs_devices->opened) {
>>> +                     mutex_unlock(&fs_devices->device_list_mutex);
>>> +                     continue;
>>> +             }
>>> +
>>> +             list_for_each_entry(device, &fs_devices->devices, dev_list) {
>>> +                     if ((device->devt == devt) &&
>>> +                         strcmp(device->name->str, path)) {
>>> +                             mutex_unlock(&fs_devices->device_list_mutex);
>>> +
>>> +                             /* Do not skip registration */
>>> +                             return false;
>>> +                     }
>>> +             }
>>> +             mutex_unlock(&fs_devices->device_list_mutex);
>>> +     }
>>> +
>>> +     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>> +         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
>>> +             return true;
>>> +
>>> +     return false;
>>> +}
>>> +
>>>    /*
>>>     * Look for a btrfs signature on a device. This may be called out of the mount path
>>>     * and we are not allowed to call set_blocksize during the scan. The superblock
>>> @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>                goto error_bdev_put;
>>>        }
>>>
>>> -     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>> -         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>>> -             dev_t devt;
>>> +     if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
>>> +                                 mount_arg_dev)) {
>>> +             pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
>>> +                       path, MAJOR(bdev_handle->bdev->bd_dev),
>>> +                       MINOR(bdev_handle->bdev->bd_dev));
>>>
>>> -             ret = lookup_bdev(path, &devt);
>>> -             if (ret)
>>> -                     btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>> -                                path, ret);
>>> -             else
>>> -                     btrfs_free_stale_devices(devt, NULL);
>>> +             btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
>>>
>>> -             pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>>>                device = NULL;
>>>                goto free_disk_super;
>>>        }
>>

