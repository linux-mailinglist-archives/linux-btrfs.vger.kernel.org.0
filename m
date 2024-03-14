Return-Path: <linux-btrfs+bounces-3288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E187BDDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14382B21CF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD35C90B;
	Thu, 14 Mar 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ALcUVtDc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lK4eRjfv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D061E874
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423508; cv=fail; b=Q2KsLhPVbMJjax4LBTh66jtbvFfsGqvv1WgfYHqpZwNUie5ZNk/QGDB/qtMBsbzT9lxSbwo8Aw18bW4WzZ6xMYtYHyDMBVwROa7C2J0QN/Ae8D/Nq4wJDw98Tl5+6mr5RIire5VkUJsAGctvbWfZis/UNRnQBWhu2Uc06bPNN8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423508; c=relaxed/simple;
	bh=1nHUQC7By/zUuLmUyp9xwOQ3n3PdcSp+2FRbIgkZtZA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sNA3rM3Ek51hGN2ZHggjf9P/z4Wk79Rj2QN6CObfLYJKLux2KghkDwI1xEBC2f5qQ6crgt4hvaygOIdmWKqMf0QY7ArIu8x58DsTj9PAqnyBKOPgft5My6DQjL3HIXS82OPKEHeCgC2G/5GH96lg4+Zua9k6lvSHXHrSgO0xCxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ALcUVtDc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lK4eRjfv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECLxe9009405;
	Thu, 14 Mar 2024 13:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zYyGL7LZ3q0hc34wH8km+nCZgcSJRWakdLR1x4HqeXY=;
 b=ALcUVtDcH6gg5JIQmdDBngsX1JGcOBouyVvIJDLMPksbmyTI+eBmsvgt/o6uMysa7HqF
 ZQ3SLbUTwQbaD3h4dkPC3gakMkj9vCzhSe/EQ/GhT9cS+v5LIvNloioOKxfN/W5vQs/J
 SDvVXJsay9UZcYu/UW2DI4qOJeWWIuv0mrxSsR5cpwkq46RjOHm4MV96xZhDN9UzFO8M
 8GgkH0oZfu7y5yxbx5bUEkx5qX+7ysQc1ty4VJ5Sdp/gUyPZCobI/gV23pTsw/hNBl8L
 2G0sJz12NwbMKXzescGMSh8vMurvVyH/ydL6ZlSoECVi6HWWxVQhpRRnqkYd4B/8IpdJ qQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0ac08x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 13:38:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EDPTXU019752;
	Thu, 14 Mar 2024 13:38:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7ach83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 13:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsFQAjedDdzMYw1LvbErq3b7Izx3XRXAuyeK/gDu2y9ZDvLJUqMSG3hT8YDDcXFhPcpmTUHZv/cSmY8vPcr7Stmg2w3LiK/iWY8cv40K8NxMGF+CWxWhDOandAtZSOkPiDocevBIck88uq2HQHQEahUjE8JlcslzPu+WX0LrwKt5XC5Xyr2mVmpJVc2uqrQB3//nbc3Pbb6WH6HgHP+ICATx18MP9xkM0uCFhZVLaIuWn/i3YCBRIyZJweTTEKcfKBv+jJTYTEbva4VIqQZ/5VO/+2lTSrgqcMqwXYbpT6piJ2RcF3Rcdv0yOFixzPBlHgv9if9swT6o9K/yNQ2+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYyGL7LZ3q0hc34wH8km+nCZgcSJRWakdLR1x4HqeXY=;
 b=LuI/AW2F0qk0/wolgEJvd9zi/udIIkDD87tjJ5aR3KocvvpHu+aVgaMnBULCQWLfBS8DspMa8BkKcgrHky7mHcpATFDcL69KF5Mcrwkqa26HLrKR8jwA09MPABnt9L4NQQKEgwF98zM/6sfW7yvjVQbSbBYPdxZjp13KRwkOY0t1dEKtgg0nsFgFhQIKZ6tEbxKzpo+szgBG4GCsz2YSHUZ5HSKMPHQ5b1TOZcRAIzJ72q8gYtt6DIi8W7XWaSsnkeUNZqXIdzomvpr1+BkGJ/2sZ2pMy3dqHgGG1i+AAoY5PW8dtpobCHXx7jpELg2uit5IOWpaD1to6UhKm0DNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYyGL7LZ3q0hc34wH8km+nCZgcSJRWakdLR1x4HqeXY=;
 b=lK4eRjfv79Ywb7F8HIinwNPW2m5arhKVFxrmOHslV2L+84CXCGdG9H0YG5PxsfS3Cd0f94VtcERhW/Dpij2UmUmlsXzxeM5h4AHuhFDVwHWlyRmIKZ3IrCUgh13tFIT96GAMWqcJZvqn6auH9P1wmZUZZKUWXmuhL7/4PJNcCCQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7393.namprd10.prod.outlook.com (2603:10b6:610:146::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 13:37:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 13:37:54 +0000
Message-ID: <5f668819-969e-4873-a4ca-d5639afe123f@oracle.com>
Date: Thu, 14 Mar 2024 19:07:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: enhanced logic for stray single device
Content-Language: en-US
To: linux-btrfs@vger.kernel.org, boris@bur.io
References: <cover.1709991203.git.anand.jain@oracle.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1709991203.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 58eceafe-d8aa-4c90-d327-08dc442bf37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tfaj9Q0uHm6RFfy4xUBPMDlK1QLOgZjghaBmh0mLv9I33M9a3Y3NOX5y673Pt7bTQ5b6bh8EKF8DCeQDW+wlI1nBlv0nNGW0VqcL5N9jRn3OdH16YTSH5A0CUvzVtW7zICmn75OQ9559WtrEiaC/RMlgBX/XJnBQHyU/ZjlFAZqUCGOnh5OPikj61gOb23VkEHwOcgIRJnFT5eFNaWkWYM3wx9OKFXgDLk+W/DHZeOXK4oQDusHOUVXEGu6gfu6pQL4mokzhARTKgevDyrbo1O/RquFLeAZhcURtwz4SX8uRrwyHjVn2dhoSAoyKyVSM4+RYcZtR5LXi76jRTYVLZ7bgOU0+cIm84wnAbj13bfkw6YDCpWm010YbZ5YxQgcJSq6/pOKOa1CGEOmB9KXuJwp7ypZxemCXwEMbCZCblKw3faf+7yhcqQMHYrRiCB8tB5uEn0reQlWIYNGJJ9j2eTe+HIbuxWjC/HClPZJ5SzZJZZxs4lluXLOACfoKWu/hH5w3aZcjMUdv/StwcJgT7KefVAKZlITO8JBqokvBnmxEi4deG4ZoGExGfl11B8Dj7hvZxBvGaf1XPu9yx3/l75UWIawtzrUdFyNxg8c49zKMI/arKeImrLL42vqd+a2I1gzkDghaVpxMpYZgNH55cxvvMnmUK8fJ0c/nQjoRYqw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1UxV0hXQ0l2NzdoemFlOWFXNUoraEp4QUdVOXhHa0xzVkIxbEJQTDN1YWlp?=
 =?utf-8?B?TFFwUU9mQXhoQjl5QjRJQ0EwL3p1ZjNkNUgvZzcxbmdHS0UxbDBLMkY2OCtV?=
 =?utf-8?B?RmdibUpqdk8xOEhuV0NXeDBoekIwdURBeFpyTmlvV1hsZWZYYjN5YmQ4VGZ4?=
 =?utf-8?B?dnRzZDNXd1NNOWwrNzlUb3hGbWU0bGIyd1dMbi95WW1YVlpKSEV5Z3NibEVL?=
 =?utf-8?B?cGduSlptZ0JXZzNWTnp0Y0tJWStqTC95cVhkUzBrYUNBY21DTnFxcXdqK2xp?=
 =?utf-8?B?VFd6NEJtVlFtR3FZMW5ZNFNhd0JRSXVCWjNtOE5QK3RIbHA5UFdoaFVMWFUw?=
 =?utf-8?B?a0taZVRlK0hnUjlqRWVvMG5aVWxueVBEbmFiem91UDVmd1dzWkVGRExKa2lV?=
 =?utf-8?B?WmlJU3pVSmVhLzQ1c3NFRmpybnZlQndQOS9FSys5SEhuWk9LWE5ncjV2cjUv?=
 =?utf-8?B?ZVEyQkRTVnlmNllrRWszdlRGbnBTQnNBOElxWmd3UTViMmsvTC9Va0w4dEh0?=
 =?utf-8?B?ZG52MWl3cGNpNCsxTzlDbnplRUYwZGpLY1A1L0JoQzFlZGtFWUp5cEtoanlh?=
 =?utf-8?B?Tko4Slh5Z0dwbWorY3cwUEYzK0haTGNFeWVLUDdxNm5yaDZmZHkvSTNpRVc2?=
 =?utf-8?B?UGljMENWOGFHNXd1RFc2ZXZsMHNxc1d5bnNVN2cwUCtyRm9oNlBVRkhCemNY?=
 =?utf-8?B?Y3VaY3ArdkJDak0raS95SjYrbXpCYVkyWm9WNWN0bzRsdFZiSXVUWWlPUWx1?=
 =?utf-8?B?RENaWExTVktsUWxxcVR5eEI1MFRyZ2hXTkR1Y0ZaUmFJa3NwUHFCTlh3dnBR?=
 =?utf-8?B?NUtxa0ZsS2hMYSt6UnU0UC9yWndJanlrbnJDZ1RraEtNVDNuRElzTXBVK3F2?=
 =?utf-8?B?YmgxNHZZZFFrU3FpNi9hNnNwc0wwMGtabG53eE9zcnE1SkhhWUF4U0tIc0Nn?=
 =?utf-8?B?TGJnYnBCemZyU0NPQ1lWRmptUDY5VjN6NFJBTDZJaFl2d0szNmNGbWxCeExl?=
 =?utf-8?B?RGxzSUdWZ0tFM29acUdCd0hhc3BEYW5ySDNVenhLY3hjSUdUcmJDNzZBdFdl?=
 =?utf-8?B?VlVlVHBRRDVYZndwWDFhazQvWS9NVGFsaE1OYzZEaGpFc3dEM2NSZm5MUHRB?=
 =?utf-8?B?ZFZqOE45RlJpODJQRFl2Ylp6NnN3L2VrQkhLci9TbklQSUE5RGJGdjhKZndI?=
 =?utf-8?B?RmVPbUcvVkcxMlR0ZnpaZ2kxSG8xaks5YVpCWGZIVCtsWWhjNDdGVnNmTURR?=
 =?utf-8?B?bU5FdjMxdkIrQ3Vkdmt6ZlNSTWRBUW1hR2lXVzdlN1Rsb1NMYXlUWkhkdnBh?=
 =?utf-8?B?ME8zVVIvMlJXSHoxK0w2SzltTlI4citzREJleUhaVmlsY005YldhdmsvYmxu?=
 =?utf-8?B?R1R3alhjWWdPemxQNEZFRkZjdXc4TUM0bCtlTXpZQ0s5cHBYTTRyaC9GS1RH?=
 =?utf-8?B?NXV3RUV6VmErZ2Z5aE1UZ0w3NWdwbXpvS2JRajZUYmZpNjNTWEFqdy8zRVJZ?=
 =?utf-8?B?alQvU29FVTR5aTVMTU9Qb1A3YWF3MmNVT0pXRUo3RnZuWUdVT1pOUThDTmhw?=
 =?utf-8?B?cnE4RlErdWcyWHhHMzdpTm1jMExsQlcycnl5cGhhTWtjSklscG5WTUpxREFu?=
 =?utf-8?B?WGs0MDBZOHlLcUgyNVNzZG5ydWhLVGgrckQ1Yk9vY0wrazhWL0k0K0VWYXRN?=
 =?utf-8?B?YWRrN0tmajdGeGx4cGl0ZEFDT2ZxZVJGaWJ6Ykd6UVBnTzlWdFUvZDhpV25n?=
 =?utf-8?B?Z20renJaWjU2ZGVLd3BCbHlmVXZrUEhESGZ3bzlKM1ZpYTMwWDZrWnBwcHIy?=
 =?utf-8?B?K1AyL3B6SjZOMmQwNk1YZ1pCN0JBeVIvYWFWV0VJcHdXZmh1Sm9ZUjZUUDNY?=
 =?utf-8?B?WkRVc1dzcmlDUVlRbFlRN3kxOTVQRXhzRUVOeWhkRVQ0dEovRlV1TmkwSVIv?=
 =?utf-8?B?OExMY1dyTStzS0JSMU9ObENSSVRmd24rNkNxemhidVJzaWhPMDhEL3dSejhi?=
 =?utf-8?B?TThjWFhwanZXMHZPTkJYNlg3aHd6UEhQYWM0aFpOa0E1V0RnaEo4d2xDZ1F5?=
 =?utf-8?B?Vmkwcnl3aGlvSEt1UHFKQVJXNTMyUWgxeVNuV1ZxSDB3TTQvclNEdk5BRm1E?=
 =?utf-8?Q?YBqRiJ4ssARd+ABQhLOxhV4NW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7ZmQrQoP3YQynF/flsnDidheaD3BwOAQvSk7z1AqyHEFuPnTfWJjETbxi61vQoDfoyEEXZOLVVgmjmJzYtWza7630QLnX3w15zB9rauy3zYVECGvkbam6NQTg9LJBJLJ0wD+yEFpGnkKap4Zs9fecdG5FA7bNoPlOmhXr5Uv/9WK4vNx8z5ZGyrA5ImU9IXapUzRLiHh3QVNAXl1G1rNlGOamPpS7ORAAeSv55rltKARlRBX3wPPe0EMh9amcslHjwOILSZUfxKxtfTZjZ2XUkQ3vNenh7Ninkb/HPqhMpPNYJMLZ9w+LGSWk+QNnXUTIitXGaiPz0/neupGTdrvxf8mMNphN1yB8yhIO1VkynLeKKkFR3o2uEIhLOVGISRlPcgR3dEmEiU9uLTwpC2eIB0S4i7QjSdB+ccoN1EJg6zpUdLLULCnYcpBms5mWKqlkM1csSgHOUdkGvnv6lVexDfCAkRdyW2yiREs4m4Uk9fDZsRTGsePlXFBTsJlbfoI+LK600Fb3TBGaxay419CVCNIxwKp60sxG3Byl8iq2zAKZBYfT6VyCjWThbKKEn4scJXtadkZDoUApm2GMaeCcKxGih7T5HIC64fDG0DX494=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eceafe-d8aa-4c90-d327-08dc442bf37e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:37:54.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Md8sBJx24gmqw5p+4jBrSn5jkvISWWFf8BlAC7HJopyRusTN5+0bcpsJG1DRtv45+TezyhZcU8zSa2QfkPqbCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403140100
X-Proofpoint-GUID: 2gZJalBYBgkHii5vRBaW8_-1h7KmQjXa
X-Proofpoint-ORIG-GUID: 2gZJalBYBgkHii5vRBaW8_-1h7KmQjXa


Gentle ping for any reviews?. Thx.


On 3/9/24 19:14, Anand Jain wrote:
> This patch series comprises two preparatory patches (patches 1 and 3
> below), one bug fix (patch 2), and one logic hardening patch (patch 4)
> designed to address issues with stray single devices.
> 
> The objective is to ensure that single devices are not left lingering in
> the device list unless they are properly mounted.
> 
> Anand Jain (4):
>    btrfs: declare btrfs_free_stale_devices non-static
>    btrfs: forget stray device on failed open
>    btrfs: refactor btrfs_free_stale_devices to free single stray device
>    btrfs: validate device_list at scan for stray free
> 
>   fs/btrfs/super.c   |  3 +++
>   fs/btrfs/volumes.c | 18 ++++++++++++++----
>   fs/btrfs/volumes.h |  2 ++
>   3 files changed, 19 insertions(+), 4 deletions(-)
> 


