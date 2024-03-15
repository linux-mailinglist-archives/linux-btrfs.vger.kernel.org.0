Return-Path: <linux-btrfs+bounces-3324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40187CE30
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E018D1C21801
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 13:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A252C840;
	Fri, 15 Mar 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y0H5b0Mv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IuCvBoBu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758D1C291
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510034; cv=fail; b=j6EK/xYm5I+rsuYnJe++BGm30Wr3aVRwNFZgj9/jJsknPM0YEKVqYOlzPAWlRiy/h6KGYmgdJCryICS5buCRs4G8k7qmB2y6ckLIZL/RynTyjgCTW6WNB6jT8qN8dt+56Js7CDjB0K1Pbf+1N4zTOwXzVfLN2BDFTwkrhfisjrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510034; c=relaxed/simple;
	bh=+UF2D1OM0sKMGfz/CzocHcyHQ7O+k4mC4zBLeEQ5F7U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnPIIabc9WsMtBdAtg3TDad6DFw8jDqaWyd1CatH5BVE3/sPlBoRx6uLWJBNoDrgXIvcQ4qHtHCHJlmoOz3t9T/an1W/v+iI2s/+SsZB6zQpUZ06RMh9N9tRHnzT0Z7GXeD30DlJCEBkeCRUXzNsllUiE2pcl6KkrBnxwfh1vao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y0H5b0Mv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IuCvBoBu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FBdEcf004227;
	Fri, 15 Mar 2024 13:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8HSPSDnaqtPQXVeEBNX4nIU++Vk+NaAEtmN2VoZc+es=;
 b=Y0H5b0Mv7UAkfjulMlKXCPnldgZ0yBGf0bYAEfFlzmQ186vx0n9hL6m6LxF/r4x6+XAY
 rzwTK/myv0uRNFq/dWULEovjLExxnKtABw5I3CFwZnIXxBK6WGK85TAF4yQomMQ7/01f
 cdSEiFWDOrkBOKiwKDi6DhiKl9vHkFwiYVh/ltXHhBz2UAvUPD25qUPHC5K8XdRGpxwX
 GLensC5DgrGS44GFp8vB1xNaVHoLs3eP9Atfjf1hk0Y1+KM06b8t26VK80RhQ5xXLG7A
 RsVtyyqwoPaaLKeO0ovUwBRWzY7tWwmZ+7XZ61isXIeNyvCUKAEo2tlk3KKaPRNmVmnE ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0ab2r3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 13:40:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FCtDHl004925;
	Fri, 15 Mar 2024 13:40:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7cbbnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 13:40:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKV2iSBOSadY3Tp2hkLoMgRS25fmKLdv4A6+ERoay/lOTl2d+1MtWVEDXugu2ILxR4Qb9ox4GiOh6i2RY3HMf71cOiGVUjd4nsqdSLme9nMAbMl2hs3qGxro1pwdk+FADT3Gc+FEBRco4DlEeDpv/uzx4CVRFDGbWP5+8jpIthxrSBc2qKeMrGDwliPRzlS1GFgUzRtNjaYMrnjOQPh/Unov0Eprx8tg9Z7ob192OOcGM0oIXUlN+RR0lKOip4Bndj5W+6ognD0OqvN5gVL5IrKyfj1ws+CNgJkHZcw2XBt1i/QBq30taYz+W2lCfo0Xew/gpl6FE7NvvEBgpZ0QOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HSPSDnaqtPQXVeEBNX4nIU++Vk+NaAEtmN2VoZc+es=;
 b=EiOVa9JCcz0J9KUzW0BH/Jq64zHVmKuSa/KPHTtjr3KQQwdbD7xJlih7DPRsGQbSyb7Z42CWBhVgdKp+CGRs1kticGhTQtmtUUOX8Zp5raxWdKAVY/nLdEmWJaFvZWZBP4/Yg2MIEhaYqToJ5rU8UffDDoPPqWg+xA6A/VZEbrzDL8widfU3Smz6hbI1DT/wOF12thisi5EANuitwtcJEy+up+Ug30q+8ZmX0p8dBqzeu+qOWbhwN8w3VFXrm9qvvkZBtKA2RhZsfGiX6+PgO2lyUrjxETUbfzjZv/gnYfbSxN3kpqJsOFoh3zCsfcefLQn6p5cJDlu11o+9vAbPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HSPSDnaqtPQXVeEBNX4nIU++Vk+NaAEtmN2VoZc+es=;
 b=IuCvBoBukot6BDnZEEdBBxVfpYWDBefWn4VX5uwezDKR9FZNNnhG/PMbWHmkTmaiTQYzcOREpn6Gt8ARRoXlQ0Xor6EA45j7Vflg0RHcXo2tI9A5OUvKNQBoMNNWZH2NMcv82UClnnQEwdXSr1br+7lcHc8K6IGXXWw9a97bbLc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4174.namprd10.prod.outlook.com (2603:10b6:208:1dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 13:40:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.022; Fri, 15 Mar 2024
 13:40:23 +0000
Message-ID: <46846401-28f3-497c-9c4e-4033fba1ab31@oracle.com>
Date: Fri, 15 Mar 2024 19:10:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: trivial changes to btree lock functions
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1710506834.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1710506834.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 108f068b-375a-4560-d5ee-08dc44f5770c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Oc+lzjdmMJoAZQEd0DWqNzdy7d6wa0inSt2IXQXSb7ESov2PO2bOPOjlwot6POu/LfzfCdOozG8METTfajW77xfrVUyY42eR2LM94dfB8UQranNrgVVpoNmgb8Y2dV0Xs5N5I5LAv9wPiAxQK6PAvLj1ucZOX+frYKlVfmQcYU95mFzY81r+IeO69H1dHHztxW4FHavLpPu09lizIIJTfRw6LW40w9QH1Q41KiSr/ypPI7dy4Fj4i6pmYlBMjenDrQlSyYQ+XJHdCjqNNt7ZrB6sAk/zU7PsT/tk+QDwsspy1iweztka/mbq3gL3eCVz+MqmfS22Ek1FR0xI3opDdW3Bb+5pCiEXT2R3/O6ZJuYNP2S8OsO4gYboKHzeRnlUv8wH+yNFUmYjYSdb2ez77KN2Wlq/dd8m9xjPz73Kg7+uZGqFQH7FM4ehNRUFg+FiOaJ0waHSoi4U83+rS573Dw3uJtUaqA0wc+gjI+tI/tfD0q8k2VS8C2ZSHmIcaGXj2uobyYrL7Hw7LsZHEokTta0mKHSzHT5eSn5rloWLqX+liLoZuQ3XCaK/9D5bbuOeDtPotLGg2IVhKqBs/WIMkCIxnLj9rq3WvMyHjsG4ducVT9ZFPrhM2lnCcqOwzhilhY8G8aLubktf1t2ZyvTNW6eK8ZOUmUTfQYEd5IiV+NM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1c4bDZXK1QxL09oUFRkYXZRUmorT2NwUFc0V2V0bkdyeXpPNGYzTlh3Uy9t?=
 =?utf-8?B?RDQ2RlhJdU1TU0VHMktYTFc4ZDA2cEczY25uUEVzYTAvL0hJUHE1ZVVMVHpn?=
 =?utf-8?B?RE1USlZ3NGpKYjhpMThYbVVwQk5MUWlVWjVwZDBDaTZURFlGM3dubE1DNWJY?=
 =?utf-8?B?bU4zcHZOZ0lIOWFXd1Jab0Jjbmh0N2l6YWRKYWJqdTZMRjExemcxdHZDWUNk?=
 =?utf-8?B?U0ZlNnVGb0pNRGpXb2grQ3VaWWRORHhjVTRrKzNSdWc5dER6U3FnalJnL2xr?=
 =?utf-8?B?c01QbFlIRC9KZW9CaHQ4NCtrMGpmeG9Jd1pTaW1GdENqWXpKd2JWRlN4bHNm?=
 =?utf-8?B?dHRLV0R1bklCVWszNnRpOUE0eEVCcU1hU1FMTUpxQVhUeHJpSjVlU3d2Mkk0?=
 =?utf-8?B?Z3FOOElTaThkRmtyRTQwT0lod2E4ZUtnMk43emtkVEZGVnMyK05oOVB3eVIy?=
 =?utf-8?B?bVJpSkN4ODVOb1lBSEZrWmpqeUZGbkFJbmtaaWE2cHRvRFJwT1JXaFQwSHpP?=
 =?utf-8?B?enM0c09LbzM3SVhUYU9uWnJ6dDh0aXJpV2gvYXRHUjVLSWE4cHF1M0lWK3ZB?=
 =?utf-8?B?MHBOZkFJbEU2RGRVbVlHaXQwMElGQnpWcGFtSjM3dDVRN0U5N3ZWUHQyMWg4?=
 =?utf-8?B?WGZWc3kxeWFuUzZlZzR6RkZsV2VHbllGMHZiZkxGVTkwTVNmZms0c0o5UGE5?=
 =?utf-8?B?bHlBN2NrWmdFQXNBTGZOLzJpcVBTSzJVZnpzMlBTQVkrMndxWnhadHFHRlh3?=
 =?utf-8?B?akorc091VkxLWXY2eUdFK1J1TnhNdlpyRzIyRk5sam0rM24xVU5xMFZsRitl?=
 =?utf-8?B?V3VrdTNEMXJCNDRPTG1XZEtVeHlxUWoxMGg0NXFOTWI5U2pnczkxOWJvVlh4?=
 =?utf-8?B?YUc0UC8xbi95TlhlZUF1Ni94RnR2MWJiSlYzZjE4WHVtQzczRDN2MSs1S0x1?=
 =?utf-8?B?V2ZvQ2NGUHVVTDFOU25aT3lzVUY3Y2YxSlNaVzVXdGFRYzlwTzJhSGt5OStF?=
 =?utf-8?B?SWkzRFF4NFJwVUJnSENXcEJSNFdRSVIrMTVBYldaWHUvVmRJYy9wOXpPK1pH?=
 =?utf-8?B?ckk4OFZ0K1JzcHl0NVpkemlVSVp5WTk4Y24veERjREVPQXRISmJVOU9XOGxj?=
 =?utf-8?B?TW5VeGpBRkNYTXFPb2N4SlR1SmFENGNBbTUvcEVNWG9TazBtazcwNEtRZ09y?=
 =?utf-8?B?amRNWWp1TDk1WURWUDZiaHAvdzVNbDNEekM0WkIwekpoWDVSUDRaTWJlc0tY?=
 =?utf-8?B?MDFUMGk1d3RVek51TCtJeU9OTVBBRFFVZlhDVFd0a3JxRCtPTUcvYk9MSTU1?=
 =?utf-8?B?WGJvWU5LZWY0WEdHdmRwallJU0V1dEtsODNVMVpRRTI4REJCOXprRjBabkR2?=
 =?utf-8?B?anQ0VzhkQmtkTHlHblQ1aHIxSGtpcTJJTDZBQjFXUWNSVHphM1FzMy9qQWhC?=
 =?utf-8?B?Zy9XUzFxdGdVcVVrN0tUbHJ3LzdocDVwajR1WjFWTWR5RUdUNVZiNFdtSkh0?=
 =?utf-8?B?UmIrUnYrMkZNWENIM01qVlRhQUttSjY2TE9BR2RUZGNPbDJoRm9JdHRQWldj?=
 =?utf-8?B?TnF1d0tueDNCa3psUlo0SS94NmJVV294Q0x5eGVDMG1hdVdrdy82cWU4Q0RQ?=
 =?utf-8?B?Ynh5djRxellPNjZvWFNtd2c5RDg4dmJMbnZNcXdCZWVranFaV09DcVpocVYy?=
 =?utf-8?B?cHZPRHpMNVVhK1RXSnB2aFZIM0VkYVhWQUg0Uzl0Vi9TdGVhVzNNY2ZQcHpG?=
 =?utf-8?B?ZS9oL0Y5a2tUUEJlMEd3R0djT21vSWY1bDl5ZTR1VkZYQnlQb29OZVNVaHUy?=
 =?utf-8?B?eUZQS2p4ako4NWtsempPY1RtRjZhK204cGxCMVBjbytaaTFPYXdiQ1hzaUho?=
 =?utf-8?B?VzlUZGwrbmZrVnBOazhna25TVzJxTjcraTJvZ0M3Z0NBVEttM3Q4OHFZVElG?=
 =?utf-8?B?ZHJpaG1UV1ZGb2d4cmNJazJjemplb2RhZ2xPOENOcnFnekFxU3d3QjJLTy9T?=
 =?utf-8?B?S2ptNEx0bnJ1Y29ESXlUajgzVWJQSE9taHc4TjliV3ZOaVphVGdpQWtUVWpL?=
 =?utf-8?B?VlVKOUFNVEpXOHJwbWNDcGNkZnpxcDE2MXlsdXNsejJZRDZ4cFRzeWhtekRO?=
 =?utf-8?B?VTBZamRqUGhoRS9GWFo2TlZNS2NNd29Kc1hQWWpGNFh5UnRmeUlzbnREbXdR?=
 =?utf-8?Q?Lf+Ex7YYcBsjmR8tsp1pv4rzCKX0tcc0UmAV+TkALHQ6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F2OgTr+Si3jT5GWG4Fg5uVOuj08D0mGNvLk+05WuwRe8eTxIuwCfygdBpXYW541XKrNXhes8iL/QA1pj5RrCzIvzvPQguVw2fXndRoiphm5sAT+aNct/4GM8Qyw3Feejubfg6hdt+JbT7DKGl7ybnlQSu8dB6q1Z1iOXOru35zf/XDG9ZlIvgjcxCiy9YnAgb5zi4EPSxhYKwcaSklV/zgQY66lXTYWjLjshMyEO6ZDsoFjfobA03x5LC2toMywJGoEhFg1aI6AZNDwtVHiyc3JQY2jOWNOlcb5+VyLsFse1ChPZe5qyxWDWEfrsdF96jw66T0blcKOMooC9vx8QDuXkDXnR/kOlblib42Gawj3Gytx1whQyM/kNJNv+o6Ul9OaZ7o3zQCYVlGJU2YRpcLRHM1Dm4HtRsBjRvwxYoMiN4AvBu4eujIZ7ZNKcPriz1yM63LCf6Wbi/zhdFFVPyMUQIbbka8zPJVWCYCBUsGZ0srC3hET/lePuFSepUcJic0OzkSUoaJN0tp2rNkkewwzOPdva6ztsWTPsVgIYO78kOaEkeQ+ypXSbWSaTONeRfJR9OeMpU6Lwr132eFrOsFuRdMvcnhUpfXM+Xa4iKL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108f068b-375a-4560-d5ee-08dc44f5770c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 13:40:23.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nykwgU4mpF7xcwcO8ylvq3gNzdipd0nCjRid8tY3vxAmTf87PuRW9jvLRG8w0j1jx35Jr3bKvcmYfz7TH93vjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150110
X-Proofpoint-ORIG-GUID: 9X6HylgMbqxBzmjOkSlUGTC12cads-jE
X-Proofpoint-GUID: 9X6HylgMbqxBzmjOkSlUGTC12cads-jE

On 3/15/24 18:25, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some trivial changes to btree lock functions. Details in the change logs.
> 
> Filipe Manana (2):
>    btrfs: inline btrfs_tree_lock() and btrfs_tree_read_lock()
>    btrfs: rename __btrfs_tree_lock() and __btrfs_tree_read_lock()
> 

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


>   fs/btrfs/ctree.c       | 12 ++++++------
>   fs/btrfs/extent-tree.c |  2 +-
>   fs/btrfs/locking.c     | 16 +++-------------
>   fs/btrfs/locking.h     | 18 ++++++++++++++----
>   4 files changed, 24 insertions(+), 24 deletions(-)
> 


