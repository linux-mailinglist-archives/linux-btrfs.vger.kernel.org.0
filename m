Return-Path: <linux-btrfs+bounces-11601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B5DA3D0C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 06:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A253B965E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 05:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605F19DF6A;
	Thu, 20 Feb 2025 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SHDJaCuf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HdxxEY2C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF78A926;
	Thu, 20 Feb 2025 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029267; cv=fail; b=kGqaTQUjHWclzblSeZP3t9IYkOH8Z8jWS6xN5PHnvUzkr1RgAjDenex+wdFpX369jWQ54SSGwirEpYFTcg+c1jeTkkFeQQn1cuuWAJOzbtOIaRuFE9675MdVIFd6025/vXDg+Rd/TOvSwRiSYH+ezk3yhizuL5KhO7PwOSnyFhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029267; c=relaxed/simple;
	bh=xHqz7eMlNjb/GqjJSe2S+3U9+sA2Qolc/BvpfXdtDjk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=heYbfcFK0yojUxhDXXBw0sKVpLtzPytdJERhJFBvGu092iw2rC/VfE9W4mVCVfFW53GL98eoh761w/htlG/Ulo/UnMHoiTp0lO3N+srOyvT7XDMjI2gmwHKvvChM0+KIZ4AicPa82eb1RrOFi7sl15iNdA6cb6IzayiwRJWCK2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SHDJaCuf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HdxxEY2C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JMZXXj012515;
	Thu, 20 Feb 2025 05:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ct3fbjH71shSGOjEe5F+X/Oj+KxbltsBsEENHnu8JU4=; b=
	SHDJaCufL9zGhdMMytxnsqbS1BTgs0PLChCz8CK3jU/m9IKqJFq8eTfrdm99tuA8
	VkEBiUyxL+x925GlsEcHj+qByJ0H/Oyvy5Xz4Kdl85CIpA18ElaYwM0rfXRX/0Bg
	6dGzj+f0nWoqP4IK35nRL9i+KG/S8wYANOAf5TjuPUKr2kR6KypialJOcumSJPdw
	Ndo41mO0AYJe2K4CAgZtzlhL60hiC86vA5EcMplt11fU6RIuMX9IsQNw5lFDwhBw
	19uvdSN6IXdfoAUudZbONatnQh8O4+ixzhsRB4EAW2xwgbs2vUo/xrhLzpFOY+Pr
	8AyBYhaRA3VTBqUX5QcYKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kkduj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 05:27:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K49h5s002175;
	Thu, 20 Feb 2025 05:27:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tmpa6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 05:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgYKm7rjz0cVvuZpm0JmbDGRislgDrzowURrKeU3P27To+e0Ulti9p3PiIoUSHqyzARRbyN06RmMdOVuGZtZB4ulR1xQY+zKhnVplpUTRbENoDbvnAobK02+7dOAJcC+kCbMIb5wR+F/YjhGjCeqrJOgoYv77dgem9C1W4GwG7yHRLAQgSlXRaOLv6i9NloL4RkSKhQcr4qLp6QiixizZxawDGari+yxMv69cejdZU+OFNdSDXsanTetjGl/QK2y3HBIuJDP2CL2iQ+TkgLQtFh/Zj+AOzyypEA5WS28HPHMnNyZSSHs1mkjAi0HowHWWRn/a65KB72otdvjUt0J9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct3fbjH71shSGOjEe5F+X/Oj+KxbltsBsEENHnu8JU4=;
 b=rqSpTzLATx8yYvUkj9hA1E3EA9lO4n8QcfwKiRm8QvFCgCH25MGyJfdQ/nMplV9ndk8TYFjZU//7nA4DfIesBHpGFCMuKYWEe8qDRiD3J7HsX69VhRiDD2T6j5rHaTjMvxrj7zqCa9HHYtCqiQJRflJSb4Z0nArFG9jFCU3wUNuhn0gD2syEQ7D+91BIZIIKUvRFbMkETS5WXXooTvZhgrAjWxx9GzRJHNaHhYHUQSXzsCZdpG1oi0BuCk7M+HgdNIBgfIaKGRPETD3Ra+OrffhLzREZLx8Ub3Oljor3aDaSRLyUeObitGilqKMCl69QJb/o9XO2p6q1biyD1WKFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct3fbjH71shSGOjEe5F+X/Oj+KxbltsBsEENHnu8JU4=;
 b=HdxxEY2CxCZ6cHK2sAU6yb/GJEQ4j5gDdC3o5cznEr5yiW0mtdqBDGUplZOQqhIuC40g7GMLyk3OoGeoZFnTFAWFTcbHpYeRMh7oYMZqmZqQz12vpmK6ioGORjbj5k8D76Prg1rOFt1ZY4t7v6Q7N1r7zWWEvXY/PdiJBo6aCMg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 05:27:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8445.020; Thu, 20 Feb 2025
 05:27:37 +0000
Message-ID: <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
Date: Thu, 20 Feb 2025 13:27:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of
 failure/interruption
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 57edb9b7-337d-437c-12f4-08dd516f4954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blAwWU1zNWNmckdyRm5IdGpIQWJOeDlBczN4QWRyMkgrdnRaN2ZYNlkwb2Fu?=
 =?utf-8?B?U3ExQnNPdFB4YTZkZkp3NjBObFl0SUhzZWN1QW1FOExVTWg4QzZqaCtZV2Zt?=
 =?utf-8?B?L1paYWhEcDlKS2dxKzhFbjVtcmhHSk1BcmdNOUNRNkZFaWN3MENoemdsVG5J?=
 =?utf-8?B?MWREOGQ2SWwxZzVoM3E3TllIbzIvdnI1VmNUWHdQM2dHelpMWjRjN2tvNDFQ?=
 =?utf-8?B?THM2L3dWM1YzRERVQlJ1bm1JdmZPby9LU2p6ZGp6bzAzME9iY1RpOVlaSnhS?=
 =?utf-8?B?VEtBOUQyTWo4Q203L1VjR1hCN1Z4dUtKMS9CQ2pwZTI1bzhOT1QzcmpQVXh0?=
 =?utf-8?B?bWNyaERjY0w5NXdGMkFWQis4eHVFN1dTSEdHVllsUm9PMnUxODJUZmdIQnNB?=
 =?utf-8?B?WkN1elJyUTU5TktvV1djTFlyWVdVMURwTVJlbHV2Z1JySHBQck0xaEx3dkVG?=
 =?utf-8?B?QzIyT2toTWxKWFF2QTZKbnlLQWg0RnBFd3VPZnFjMi82RVpjN0hhdGo3QXFn?=
 =?utf-8?B?Vkh4VmQrQzRmMVVoSGp4SytPN0JNRWlvdTRkc3NnaDk4VWRPK25waEJsSU1y?=
 =?utf-8?B?YUhzQmt1U1B0Y2p1QVQrMzlKOEl3ZWNSTW0zeFlHd21US1R3NVZ2OEhZSk02?=
 =?utf-8?B?dmRpelRYQ0ZhaGhuMTZJU0hjUUdoV3lpOERvb2xGQ0xPaW1zcGJ5V3dLNDVm?=
 =?utf-8?B?c3FJckNldmE5b3d1UitrellRZXR3RUFpYXBCcjRGV2JkdkZsdWRYN204YjZH?=
 =?utf-8?B?cURML253bSs4Qm9PbzlRdlFNejJDbG9odFhEbEJrMUdQUWlXUDdVNDZzczN2?=
 =?utf-8?B?c3UrVVZkc0xOOGxLbi9ITlo3dG8wR0d4Vk9Ick5paitEbkxJYm1ZK2l4TUZz?=
 =?utf-8?B?Y0cyQyt0NzBYcTJVYVRxR3NJQjZRaDlvVlNrVW1wU2VGSy9OREM5ZGRPMHRm?=
 =?utf-8?B?NXQ2ajBLeWlmMEk0UDIvZkVzN09UTDF4TWJVaFc1T2V2QjViMTFldG5NNlI1?=
 =?utf-8?B?NUhkbUpQaS9VNXdIYStuUEZvY1lERENncURpeitPU2RwQ2ZQV1A1L3ZoUGxh?=
 =?utf-8?B?b0l2eFIwekxzeVZlOE96UG1LS1hmeEp3VFpUVElSRVJ1eUhTaE5pQStTN0ZW?=
 =?utf-8?B?ZEZ1OXN1UEkvWHlEVG5hZXkwMkt5SUdocjNqOEwvbTJkT2J5SGpuRk5qZDkr?=
 =?utf-8?B?L3RqWTdVWWlHd013RHNZSlkwSTZMYVVNNko2SU5aZzYwOVBsN0FJTzZRd1Ba?=
 =?utf-8?B?aVhBL25yNXZlbzh0Mk96Z3NFLzUrbE9LOTMzaFU3TjF0SkNTYWxuNCtCenhv?=
 =?utf-8?B?MFJqZlRObnZzMTZaRFJ6dGlKU3BaZVN2UGZJN3kxa0FWQTdBcS8rTkQ4VXpF?=
 =?utf-8?B?NW1tZUdXNjRQWVUrTWpQV1orNDhOZlVUbDVrQUFKR2VwNkZzNTlNUFk1RGhp?=
 =?utf-8?B?WE4xZmFKM1hBYi9XbmQ5QWVnOHgyWktOc0xsek1qV2E3WFVJbk9DNWtRYXZr?=
 =?utf-8?B?OHFrNG1kTkc5K3RXejJDMXhUR3VNUzZPZnB5V2tGVkVuc1VHSGswd3AyL1li?=
 =?utf-8?B?amtzWis5YUxhd1RBY0dVOEZvbkZwL2xxbDRkUzBJOEZvWEtjVzdaYzgvRUQ1?=
 =?utf-8?B?Z1RUZ01vTjJVdkxvR3dXbVRtWFlCZG9PZmNySXFoZGxqVlJpcmJVTHc0Q253?=
 =?utf-8?B?RHJPUGtab2RRT3kwcW5oQVROZTZWV0YveUs2ZW1GbncxWW5NYVRham4xMHhy?=
 =?utf-8?B?SHNobVFyRENpbkZSN0htbXlMenU0dTVWOExtdXNZUG9vdWI5S3J6MUs4LzhR?=
 =?utf-8?B?V1cxM0FEcThWRElEeis4MlFTTWVxdVdxS3FPdnhocmw0TCsxMGdlbUdleTQ4?=
 =?utf-8?Q?s4A2d41S2z7wY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0t5VXNlWm4vczNxdEZYdUJPcW9KNXJYZDlyOWVDdUo1dE5nNFkzWnBmNDVV?=
 =?utf-8?B?V0pvQkczb2pQanhwd0hMdkRyaUM2NjUraGRvRUpzb1FZQ3QvSm40bEVwMngz?=
 =?utf-8?B?WWF2ZUhXdVM4TjhkNDczMHBocldFSVVaYUk1SW5La3grOVc5MkJ4WDJTT0ww?=
 =?utf-8?B?NzNDbzJ4UHZIWXhsSWN0T1dRbzVtd1hKUlpiS3l0SThLY3JreGN0N20wL3V6?=
 =?utf-8?B?WEw2N3hsMW5ZYWhSdUlvWGs2WTNoelVIZDBvdEN2Z0ZOaFYvRUpwOUsrTS85?=
 =?utf-8?B?NmJFTGRvaVZuYkJuekRZM3F5L0JkMFV2dVA5NTU1MTRrb0tVamFIbTI4Um53?=
 =?utf-8?B?N2lVbEZPRkM4Qnl4dmlnY1hLaVFja2xIVGhUb0YzYXFQWWxZV0JpdXVjV0FE?=
 =?utf-8?B?ejdsc1B1bHVnMEN0Ym1Da3ZJQkZRQ2sxVGREODMyRTBWTU83bDl5eTREUGNj?=
 =?utf-8?B?YUtScm5QNnR1OGJGNWhVZEgrRWdORzNBMXNWZkNaZENqY09JcHdDZmhEZHlz?=
 =?utf-8?B?Qk5hOTdqaSs5d04wWmxNNUtIa2hvdzhJazBsNjNLd1Rhd21TbkhTTUdkOXRD?=
 =?utf-8?B?bG9RbWdJMGlmQVFCUjJGc25DNHNKV24rVmVNaTNOQmpRMVd6d0xETTlRejBR?=
 =?utf-8?B?TVNHUm05Y3pEWGlmWUxpbytRaDJaUWdZUmQvL1ZnTHFiRmxnVEdwaEdRL0JH?=
 =?utf-8?B?dHA3c3pyMHFKMFJkWTNCSm9Yem1DeS9SZWlGMFJ6RGhGUUthbzNiOVMxeEpo?=
 =?utf-8?B?R2dpNk9kLytLaGY2cW5vSTQ5NFh3dXRBamM0MnBwZlR5dHhXZ241WStvdjRi?=
 =?utf-8?B?QWdIaG5lbTV5VW1tK00wQnlicTcwTzBQdSs1NFJtR0o5bFBJQmVhQ3BGM1ZO?=
 =?utf-8?B?cUM5MjRSaG9VUlNOM2V0eENHTTNEVFlsQkljRTlCWkViemxGVFoyQmpPYkkw?=
 =?utf-8?B?NksxamVKanhPR2lLNGZURzdvWVk4V3FmWGZwSEdKTHMwNkZpR3hFV3RnZlIr?=
 =?utf-8?B?RGxnaStPZFBlWjA2SDgwUStQT1pESVZsaXl6TWRiTXVHZTFqUXBlMWZqRWhF?=
 =?utf-8?B?bVE4UVk5aTF2dnBlcHNQOHNRcjZyUHpkMTJURTlCTzB1UU1WdlFiY0dPMFQ5?=
 =?utf-8?B?RUE4dmxMK1JxbDZ6NUNyQjdVei8wSk1SdEh5QS9XYUJoQ1NDWjV0WlpFWDJB?=
 =?utf-8?B?aVdoUlBvM3lWVFJxZU40UHlrR2pjMjNJNkpqc3JWK1VJMlBNakpVYkhVWjd2?=
 =?utf-8?B?WW85RXRLQ1BId0E1TlExMFIzNkRDaEtuYVZvYTlxWURKQVJ0cWV4bjBra3Zi?=
 =?utf-8?B?cWQyZ3BUSXZCSGZGZlphMkVwSHBxK3lUbVV5RUQ2b0sxcHcycTk5N2VraSs3?=
 =?utf-8?B?c3I5Njk1QnBnN0R1ZENrUlRZWm50ZmlHb25HakoySmZzNXdncStGOTl2UHFo?=
 =?utf-8?B?eHRxT2d6a2ZmQTUzKzh5YWhud0Nrc29OQXZKekFkamR5MGNzNCt2UHVXSXps?=
 =?utf-8?B?R3ZFbkxRTk5XaHFNV2diNWQ0cEhEbzR6ckUwMyt3QnFac0tqZjNLYlpRa1l3?=
 =?utf-8?B?NVpicUdiMU0vd2ZNbzQvcFZvdFpyMXZRMGs1aXc3OW9sUEFzKy84c29SV04v?=
 =?utf-8?B?MVNWRXllYS84RERNbzFXaGttS3B1TUdTREx6M09ZSmVOZjQvT0svRjIxNVE4?=
 =?utf-8?B?SXp1M1I2cUhMQ2c4SU9JSUxOVm1hK0ZqRitXZ21MTFJxWjgvTkhUN01keEU5?=
 =?utf-8?B?OVh3cURkKzFpNTEvSk43OVM0NEwyR0I3VHJRWkhNT0lMQnlpQWNkVmRTZDhR?=
 =?utf-8?B?aHkwNTdBekppRjQ3Y0d1RGtOQ3huYVNCYkF2c1drQUxjVFFTOGRHRUpRdDJw?=
 =?utf-8?B?UXhtd0tweXNLb1RrMGpMaDExdHpLMnJIMlh6ejRpQ2hUMVJvZjVLcXBYaFZV?=
 =?utf-8?B?NTRaVW9jaGdrQTlDbFRuRm5yTzg0d1AzSHlQcjhDZGROcUg3S2dhZmZEN2ZZ?=
 =?utf-8?B?aXVpVlFSdVdjaWk0c29EMlFGRXBmQ0YyelRVenZycU9GS1JySlV1ZXkzbFRq?=
 =?utf-8?B?d3JuSmdHRlpPOWt2YVZJS0JtTEozTkdKVGZsajBjTlFxUDB5VXBXelRKTzZa?=
 =?utf-8?Q?fvXVS6eWL4+h/f+RC2XJ9bYbS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCSE5TWdUIV4W4VAF4e7VxeGDuQdUAIqbb4NiCk9QSz/I8kNpekCJGC+6K7c34IubaExxdHIUEzfKIiMlBE9/pGafhklSUaopLnXlTGrrAZtc+HU1mbITBTQwMmh2MQ3osc/67D+oAiIFcy+DbhLzAP4XjZ27Yy8lFwP63H2x1Kx4OZ/pDsJ4tk8wfXmzHWbv8cDsg41SkM+XxZm9KJOq64sO9aPwU4kgLG6rVlBvOnVLYYsvq1UVBLqdGnzJZk9tpqEy/N/ICZ2zBVWafMgNfFCFhEe5lL+u7iMtMaUTv14GurGMye7zHUanw/xImPaj7/j8VYKYPCDsY9JEHH9rNS/EoTE2dIuV6xb7mz08qzBlMB+Nb+2eged5nCtDfv/zJOFJ0N88K/FqEpLzxAcA+yyaySBrHLR5ZjBVkUgv4X2qiiSFFCKshLtR94guTZAYy/ALMyavFs+X3prmJXqCQqA3PoRag0p6DMwj6OLlKbhM5edD+11FT9XTwHkJy2W7Yx0Tfs37JFcG7Z77Icy2knZIJvKc1jEFLktgjFSxx4EdjxMcN3oVbg47BDdH95TwDx+X7ir3imOzl86GCbt1mcF7EuiOozn9QckBFhA3p0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57edb9b7-337d-437c-12f4-08dd516f4954
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:27:37.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsc21ImFLX70mqazrdxJ8VyiYUW7/iaqihE7XsDJiatTQ6j9zEvDUtOA72j8phIQcpaBZkkRlTjwhFU0hKL48Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200036
X-Proofpoint-ORIG-GUID: -UCTLNykFwRaG70OFsb2C_kruohdkuVq
X-Proofpoint-GUID: -UCTLNykFwRaG70OFsb2C_kruohdkuVq

On 20/2/25 02:19, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If the test fails or is interrupted after mounting $scratch_dev3 inside
> the test filesystem and before unmounting at test_add_device(), we leave
> without being unable to unmount the test filesystem since it has a mount
> inside it. This results in the need to manually unmount $scratch_dev3,
> otherwise a subsequent run of fstests fails since the unmount of the
> test device fails with -EBUSY.
> 
> Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
> function.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/254 | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/254 b/tests/btrfs/254
> index d9c9eea9..6523389b 100755
> --- a/tests/btrfs/254
> +++ b/tests/btrfs/254
> @@ -21,6 +21,7 @@ _cleanup()
>   {
>   	cd /
>   	rm -f $tmp.*
> +	$UMOUNT_PROG $seq_mnt > /dev/null 2>&1
>   	rm -rf $seq_mnt > /dev/null 2>&1
>   	cleanup_dmdev
>   }


Reviewed-by: Anand Jain <anand.jain@oracle.com>



