Return-Path: <linux-btrfs+bounces-2198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D584C456
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 06:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AEC1F240C2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 05:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F214AAD;
	Wed,  7 Feb 2024 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xe1uzIs9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x/5Pi386"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5041CD1E;
	Wed,  7 Feb 2024 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282880; cv=fail; b=T8cYjLWELFAFUvxmXLcbDj/DjUyLG+FVgk9lwm9gD5VHxET0i41IOZ4cA+BSEJdg1JPz5F/Zi/tfa1/3nsVUU8bffL0K758VnyNBz1BR1R31HixUsKk3cNpZ211E7N0bL90dMYZ3b8xSjuBptuHkinRnRbeTES3qVLJK+FAywNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282880; c=relaxed/simple;
	bh=mkPWbkhiVpLSdzOiHiQc6JDfRDDMTO44ILPihmhe2LU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwS40XHXYbV+HVOBhZj6P33bmVKZdg+mY7sYGU38GLtyuPDs/NyZD0cGYuSq9VHBqPBqcO5TQvD+O2rxNdEhRN1GvvAx93ZQZYFY5Fh+mgKyNqbb0bmf03OkgiqnwkNiqefjtBL7JPkuUYMWub+aRRXtZTbZJL076xxVqeMVQmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xe1uzIs9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x/5Pi386; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416N4J3u007653;
	Wed, 7 Feb 2024 05:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=m2vM6dg1uXYoiHg/lNBqZZOSlwhW4tiMAYlJc5Z44I8=;
 b=Xe1uzIs9x5fqpTofNLF6VFPWWL/CPnio8YOqLwRC265EfV2GzW+K4S1h93rZtAGSoFTC
 vSqJ6pFBPZGmVdMbY1GFWYybZknvYjGRHADo9EKqmOeZaBkw9dQWw1uvU9VIQTzsjzxF
 YBOzW7Ds64OAVvOBcIsvUK+W4OxNjq5OZL0ATgbpZYY5jW0kvT/F4FL/okfb6lQ1MjWs
 7wSrJVWmJHAPHdccufBVN0mel8KbyDp7j9Wy/0xEDmpHodfaNITI+rb/1hTZRheR+Kzv
 kgOtw4X6c2Q+eC5XI0AwSV6jpSVQKJzG/R6YcSlUQb5D4TvT0UeeJdUDZHPRYXFNbas0 IA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbgkaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 05:14:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41751YnL038447;
	Wed, 7 Feb 2024 05:14:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx8envk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 05:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zizh3zo7LhxHFqW4QeEWZ31Nx/nvUm7X2eQdPyn0Ak30/Viwqw6YPJ4r1FxcRFgpLhQnFWpcGk2Q80DeSGmJz+gIB1Kc59l1EI+xEqjIlLfGkzWRKiRDnVHrs3cYeckvYr/9YOliZOts5gjQeSan8amn+eI9RICnOQLXR/kSoX3mBjI1MDp+LajRe+I1jvags3vKE+hqVab9mlDc+vejTjUcqu23TbIeAnLGSRLIHusV0qUtv/XJTHNkQTKMzM+caJE3otcKw0vAeiwtgWjg47uVoqpJ8De6jPFW4+NhA4dAZUbwZdkKBGequz0KaveT3u2FNsMmwMzkBm/A4p5bwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2vM6dg1uXYoiHg/lNBqZZOSlwhW4tiMAYlJc5Z44I8=;
 b=Mbc8N1ZGD8CUh0L9Ry1G23BHcp8fBAIDDqocZzePnrKHj9+N5VEmOjhbiMJPoVt2yZdSagysC8t50F8hOa13Q7WjGb2FTvArGlgdqQtPWH9NUEGl4c3ZU+ZZUWmxSEyEwFF2cWcMO7huSTqef04grQrR3b5kEeQdPJ6c2WSadzNxylcwoG/xiJA6N4clbF9G0DSkgDAsv4Ddq5WRUfbbRaqC1kESINyne6sCqBFLjQxOGD9W1zX8hEKWMbg4Q3FdcxwI9jTSBq1jL7B7Y7v4IKJ5XEJcEOUN8Bhu2SiPLuNvjOHpW2MHemCjmyb63KdAlCWJ4od1Z2yJKhPoGK0E4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2vM6dg1uXYoiHg/lNBqZZOSlwhW4tiMAYlJc5Z44I8=;
 b=x/5Pi386GkeWWQtv8zCu/DGmZf9DPtqRaMS2R4qriU3vs0S1+DlAELwapRVzAU8aWRMcqoyyfD8Ff1o279WQjuJNxpQvdFXKAAfn6YO7P2Ci32txljKCzr6gceyzScOmtoZBXEvK7eZ3N45rw2S7A9/GADTeya3UzX6bi4qs5pU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6166.namprd10.prod.outlook.com (2603:10b6:930:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 05:14:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 05:14:29 +0000
Message-ID: <adf78c77-160b-4d6d-ade8-c6926c3d9d6f@oracle.com>
Date: Wed, 7 Feb 2024 10:44:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: always scan a single device when mounted
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240205174340.30327-1-dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240205174340.30327-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3252cd-23c6-475f-e75c-08dc279ba906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Duh8lduVsc1vfnY/t4mZfwnWGmMD3TOd2vPfmq7Utofzbhyt8h6FnboixQnYddTzYdxQua3Y7S9JV8oACkcyRDb8jUiHdA6iCzgC6TBjPaBU5cB0AMXioBxkf7rHpkFiHbTXAt5TYPRTNRfrXRkL1/i6+P0JTxF4G05jrZXpMbxrnf05cSJwkuAC+1Nd9YWGUGfE/MUpVtQE8KW6zQkHbH+TY98FZTu0k/yGT8Z4UbK5wmRnrxxVrFa6hz21XXn/Q7vp9qzbFGBYZUEN0M+5iTEwpWdQa1RcOBb2DIdInAmIneoXxts83Ujl2llT9eEOmNbfVj5B0GiH3DC53LgzH2zRurvmzWJIjC9J3n9VH9/Ezoz/GO+JfInaJnFFJbH4Ns+GroBTMzhgyidw+reCxEPC5xvL+RHX+V605H9OiqDxIK6bkA7NBlK37bYT8+Ggx6O7POXPcD/BCApcpAQXQ+2690vXc2nr+9itg+tTE1w+3pNKgY0K1qiv1Z+OCUyz5BUHVvwe419H4guZltUBkVcl8zLLXylBMs19Zy2dsJCk2hbV3ZOL7bXvOk1YyMnbR921X8w8hjSb9ElghxUCLtuO9iwrErUs00wPm5U99G9/e52Xi7QYahS2+4KZJEABNrjvqHUw3BT1FK3Ci4MnAg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2616005)(26005)(31696002)(86362001)(41300700001)(66476007)(966005)(478600001)(2906002)(6486002)(5660300002)(66556008)(44832011)(66946007)(8676002)(8936002)(6512007)(4326008)(36756003)(6506007)(53546011)(6666004)(38100700002)(31686004)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elA5a2g0T20xcXFIMi9ITU52MzNWRmhWZmM2UFZGS3dpcmFKOGJ4REpuNkhw?=
 =?utf-8?B?WmNmV1UxdGJnb1E5dmxwSWlZTnJITFFkV2V0TWVaVmJnbEJmQlF5TjBUNmdD?=
 =?utf-8?B?MW1YSmduWTMyaEFTb1pIMG90WXZ6S3puK0gzWWtwcUdBVzBrZmlINzM4b2pz?=
 =?utf-8?B?ZTJWeWtzb0Q2MytnNE8zNzZJQUhJZ1pEeEJKNzdsYkw5Tk8xSEVnVWhKa2dq?=
 =?utf-8?B?MjhPMjNzSUdRMHNUOGROL0dSdTM5blJFZHBhNVVkTXloSzZxVmlGQ1B1NW9o?=
 =?utf-8?B?a1FNU0U2UzAwQ2wyV1ZUOUE5WVREcUlRT1cza2VuMy9SN0ZtYWdhNDQ2ckxl?=
 =?utf-8?B?TkRlYWQ4TDNEOVptOEZjQzl4WGdoU25XQi9wVHBHdlY5THZabHozb2NCNlZ2?=
 =?utf-8?B?VkF2MGJ6ZUF1eEt0ZlZRM1N1Y3FIQ0FPRkg4M2UySWN4L2sxZEtFY2lCc3lD?=
 =?utf-8?B?ZWpDRmpiVjh0MkVQT0lOV2JZSzZVRkVIYXBsZUZQNE9TWGpoaWJqZlkvQmV1?=
 =?utf-8?B?dndsd2JjS09ISmR3VlVRK1BWL01NMkxJSk5mSTJ4eVh4bjhObHQ4R0srT0xT?=
 =?utf-8?B?eE9NcCt6alRNV2tBMTVlMm1rb3YvMy81M0xWTFFhczJlMjNGTmVRQzF3Z0Ex?=
 =?utf-8?B?dTI0RURQeEEwejRZck9Nc0ZrWm9BVGExdVkxNDcrc2JFY1V0bDNTQW9nWlJD?=
 =?utf-8?B?ZUFJMXBJdml4Q2FxYy9tZHBncU94UlFpUTN0Z3dzOTR3REw3bXFyMGlEcHNV?=
 =?utf-8?B?cmh0SWhiRVUrcS9XWVgrS3UyM2h5MXNPWjhBQVlNMVdGR1pBamdCRXZtaHYw?=
 =?utf-8?B?NTFIQ3Q2WXpjOUpVSkswekQ1azZBYk1rVDlDd2c5RFpJc1A0YytKZU5LdHMv?=
 =?utf-8?B?TTh2VzlxV2RmU1E5L3QwcENtM1c4dnZaa0RPRFovQ1RzSHNOM0dOZjJzdzZR?=
 =?utf-8?B?S0NsZnJtcVByOHp4NDBYWXA4ajNSaUxwY3ZZYVVVWFZvT2V4T3p2MDlsZ0Js?=
 =?utf-8?B?OEVIWnlTSWNLaStnSlRBMS9xT2lFeHBXdzhXajM3LzA1a0lwdnpGMll5QU5l?=
 =?utf-8?B?ZHhIUHdKVWkyc1ZxV1V0MUFoeFgyYXpHZ0RNRkVyWG1qTXRDblczWFhTL0Mw?=
 =?utf-8?B?cG5LSG1tSDhybi9OMmw5YnEzYzRmSWlFUGkwSzJlNVMzZFNZdmlQdnhUN25F?=
 =?utf-8?B?WXZKcEtIbWpLZGN1QjlmLzNtc2hpaWt5NGQxNWtyZUo3dkM0SEZPZzZjbEdn?=
 =?utf-8?B?UUFlVmtxbGh4WjltOTBrYUhrM0x1ZHA0N2RJY2NTbFhEcE9OUm16ak1pTjZy?=
 =?utf-8?B?UHNNSXcyMHBtTzF0bXlPK285N1RtcExNRUd3ZWdOSndKNUE4c1kyS1k2bFZr?=
 =?utf-8?B?MnAyQnRMN0syeGhjNDB1cW05dVZpRDdpbHlhalJTQXBlTlU4T0FvTzUwMmZ3?=
 =?utf-8?B?SXJuYmZSS2ZhUUd2cUFBMDlCdG9VMXpBQnY1dmRUSE0rSHNlY1lyMDdQN1Zo?=
 =?utf-8?B?WHBZR2xhbFE4OWUvNjZqb0ZwYUh1WW52TW41TGwxRDdxbHAwWWtHdHdOMkFV?=
 =?utf-8?B?WExPaVFKUkowN3phck1ESUJjUktHbEQ2L0pwL083Sm1ZL1kwQzBqdVh0UnVE?=
 =?utf-8?B?R2xKZjVOeUR5K0pQdUFBZnh2NHJjMkNyQ2tCVGJsZXV6MjIzVEF6cW92K3lP?=
 =?utf-8?B?cEUyaUVaZjJvR3EyVEU4VWdUY1o5ZkdvUFpLSWovdkg4RkpqczN1dWZtWk55?=
 =?utf-8?B?N25EWHJ5UW1DSjFFMkVmVm5DVW9La2QxREc4bVJVcE54RmpDeUlYeFQzTVFw?=
 =?utf-8?B?S2N5RVQwcEo3RTFpdTlNNC83eVZzd09TUmZHeGlZb2hiOS9LbFp1Z1F2KzdE?=
 =?utf-8?B?NkdDdlNmUXl1cHllZVI3Q0kxWUVqZkpNNXlaaHBXM0JtRlZiVWQ3NlUxOUdF?=
 =?utf-8?B?dHRMK2Z4U3lNYkhockkzM1pMTWxJbUtMajVjNzFkS0tZZjlnSnJUZ2R1eHFN?=
 =?utf-8?B?bnRqVGdKZHhkczJLVXpzS21EeUdzMVlsOFBDSG10Y1hib25DVEpjRTFScVov?=
 =?utf-8?B?N3VreUVOK3l1MC9iYkVkVGhCL1NDajdwVmMrd0tFRCtFMXgvdTdhVlI0Umh1?=
 =?utf-8?Q?aGCmXCsbaMO+TrGNOBd9faHUv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mtRm69s/M4t80jMFyoAx/H6O0B4pxuPjN4DX5GViZ9/IGkY/+xuWWBCe4i5AetMBYTXhZ1hrWPLG8Qq2gLNqsFJIEhEhsjgYJXrqfkc+SDgQ7thPFdTvI+mELGXnxcmKLCoF6O3bkOH8DL+2LPilmjdt0oE3Ht75237ITeDgfCcwFMVbbCLn5u04jJE6OIhNxbwB2NK+uQJ0bhEY7LrVzHNfo+fpw4pLUQIbWIcmE05vPmZL2DvHBAANxjwFLsnfbKtwyAhDd/sJhN0xwa2XME2CDWTAqPt+ovyZgYu065XrRHup35TGA6s2BL7FS8WZp1L5Aq0PKzvzEt5udQX6Rnqpt1ulX+UYatVoSQ5LEvBzlZO50DHWuiRRvWk46XFsqsrzCIz5hE+ftZ5eLf6tC1685YWvhnHk1ROZDyS2nhXGytGtP51rYzp7RisgY26Qu7gKmUi2pcHMxNmZ2yU74P5Sf7QjHAVI5Bdho86/5Lr5YoLRd7Ls8ef5CReYXVqj0uAEa8c1bum+NLMTVgDNno+lHTX+DnY7QbtlvA3xd2TeYLhinJvyFSClv+0wk3lVZETATcXWGRNcsxwzpUq8GDEjvTeNp9lhL1Y6W4s1IWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3252cd-23c6-475f-e75c-08dc279ba906
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 05:14:29.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ffs2LedFco4SlQRH5bf/XUzAMlK3Zl6XK5j7NvwaXBCdPlVgbVPaHF6/ij4pL/xQKKWaTUNniAh/L5yoKb4vPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070038
X-Proofpoint-GUID: wdeFoxGN4gyn8FzeGpJPW_KQDIxcQ1Sa
X-Proofpoint-ORIG-GUID: wdeFoxGN4gyn8FzeGpJPW_KQDIxcQ1Sa



On 2/5/24 23:13, David Sterba wrote:
> There are reports that since version 6.7 update-grub fails to find the
> device of the root on systems without initrd and on a single device.
> 
> This looks like the device name changed in the output of
> /proc/self/mountinfo:
> 
> 6.5-rc5 working
> 
>    18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> 
> 6.7 not working:
> 
>    17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> 
> and "update-grub" shows this error:
> 
>    /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
> 
> This looks like it's related to the device name, but grub-probe
> recognizes the "/dev/root" path and tries to find the underlying device.
> However there's a special case for some filesystems, for btrfs in
> particular.
> 
> The generic root device detection heuristic is not done and it all
> relies on reading the device infos by a btrfs specific ioctl. This ioctl
> returns the device name as it was saved at the time of device scan (in
> this case it's /dev/root).
> 
> The change in 6.7 for temp_fsid to allow several single device
> filesystem to exist with the same fsid (and transparently generate a new
> UUID at mount time) was to skip caching/registering such devices.
> 

> This also skipped mounted device.

It's reasonable. However is there any logs from the debug message to 
confirm?


> One step of scanning is to check if
> the device name hasn't changed, and if yes then update the cached value.

> 
> This broke the grub-probe as it always read the device /dev/root and
> couldn't find it in the system. A temporary workaround is to create a
> symlink but this does not survive reboot.
> 

> The right fix is to allow updating the device path of a mounted
> filesystem even if this is a single device one.

And at the same time, if the device is not mounted, it still does
not register the single device. As in the original design.

> This does not affect the
> temp_fsid feature, the UUID of the mounted filesystem remains the same
> and the matching is based on device major:minor which is unique per
> mounted filesystem.
> 

It looks like the logic in find_fsid_by_device() does not verify if the 
%fsid_fs_devices and %devt_fs_devices are the same. I am concerned that
if they aren't, and %devt_fs_devices is matched by devt only, it implies
that the rest of the populated values in fs_devices may be inconsistent
(from the super).

I had a bunch of test cases for temp-fsid, I need to (find them) and
send it out.

> As the main part of device scanning and list update is done in
> device_list_add() that handles all corner cases and locking, it is
> extended to take a parameter that tells it to do everything as before,
> except adding a new device entry.

Hm. %new_device_added was for btrfs_scan_one_device() so that it can
call btrfs_free_stale_devices(), removing any stale devices if present.
However, theoretically, there shouldn't be any stale devices. Let's keep
it for now, as the find_fsid_by_device() logic might return incorrect
fs_devices (I need to confirm this again).


> 
> This covers the path when the device (that exists for all mounted
> devices) name changes, updating /dev/root to /dev/sdx. Any other single
> device with filesystem is skipped.
> 
> Note that if a system is booted and initial mount is done on the
> /dev/root device, this will be the cached name of the device. Only after
> the command "btrfs device rescan" it will change as it triggers the

"btrfs device scan"

> rename.
> 
> The fix was verified by users whose systems were affected.
> 
> CC: stable@vger.kernel.org # 6.7+
> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/volumes.c | 30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 474ab7ed65ea..f2c2f7ca5c3d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -738,6 +738,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   	bool same_fsid_diff_dev = false;
>   	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
>   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);


> +	bool can_create_new = *new_device_added;


>   
>   	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
>   		btrfs_err(NULL,
> @@ -753,6 +754,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		return ERR_PTR(error);
>   	}
>   


> +	*new_device_added = false;



>   	fs_devices = find_fsid_by_device(disk_super, path_devt, &same_fsid_diff_dev);
>   
>   	if (!fs_devices) {
> @@ -804,6 +806,15 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   			return ERR_PTR(-EBUSY);
>   		}
>   
> +		if (!can_create_new) {



> +			pr_info(
> +	"BTRFS: device fsid %pU devid %llu transid %llu %s skip registration scanned by %s (%d)\n",
> +				disk_super->fsid, devid, found_transid, path,
> +				current->comm, task_pid_nr(current));
> +			mutex_unlock(&fs_devices->device_list_mutex);
> +			return NULL;
> +		}
> +


I just ran the temp-fsid test cases attached here. Comparing the output
with and without this patch seems to be breaking something in the
temp-fsid feature. I need to further verify. I will convert this test
to fstests. However, in the meantime, it can be used to verify.

The testcases need to 'run' command from git@github.com:asj/run.git.
sb command is also attached here.

To run-the-test case:
   save attahced 'sb' and 'run' command from github to a BIN directory.
   update the devices in the file 't' and run it.
   ./t (with and without patch)

Sorry for the messy self use testscripts for now. I am converting them
to fstests.

Thanks, Anand

>   		nofs_flag = memalloc_nofs_save();
>   		device = btrfs_alloc_device(NULL, &devid,
>   					    disk_super->dev_item.uuid, path);
> @@ -1355,27 +1366,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   		goto error_bdev_put;
>   	}
>   
> -	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> -	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
> -		dev_t devt;
> -
> -		ret = lookup_bdev(path, &devt);
> -		if (ret)
> -			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
> -				   path, ret);
> -		else
> -			btrfs_free_stale_devices(devt, NULL);
> -
> -		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
> -		device = NULL;
> -		goto free_disk_super;
> -	}
> +	if (mount_arg_dev || btrfs_super_num_devices(disk_super) != 1 ||
> +	    (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
> +		new_device_added = true;
>   
>   	device = device_list_add(path, disk_super, &new_device_added);
>   	if (!IS_ERR(device) && new_device_added)
>   		btrfs_free_stale_devices(device->devt, device);
>   
> -free_disk_super:
>   	btrfs_release_disk_super(disk_super);
>   
>   error_bdev_put:


