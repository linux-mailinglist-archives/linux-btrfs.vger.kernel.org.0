Return-Path: <linux-btrfs+bounces-13964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9557AB4E2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527F146796F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532E620D500;
	Tue, 13 May 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hy/yPtkM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bJVaq1a+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1919D89B;
	Tue, 13 May 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125192; cv=fail; b=EFl8GaaMjqAtj8l0yGWSzwhFxGuVkV33I+aEi51J73ln+1dMPozJnXpz6geyT2k1/6tctjL+3EG00U+xiKvbRcWXx1YveesM0yednvgxoB8gSL5IMehaj9TG+zM6THoVVXyB/bw/uCe/joY03lk8C/am6cW8b9a5bIXZFFu1bM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125192; c=relaxed/simple;
	bh=7k1pk/r+r9TcFZo+6bFUOlENl73249Lp3wQGezbxS4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ABa+th3Si0YQi/SiITgizm3y8GQjvxoYLxnGsChWkT9IMWqDJnoDlodbTuiZiPRGP0oCAirxhWD7iIk0xKIVoxY5n+QuhBKWUzvZVdoy7Z9BHLF0T/phygm3ZezJ6zCdG+RueaD7QK4Ry4mW5XdjtLWLmc10qbGFKIpH524gulM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hy/yPtkM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bJVaq1a+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1C3MT013133;
	Tue, 13 May 2025 08:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7k1pk/r+r9TcFZo+6bFUOlENl73249Lp3wQGezbxS4s=; b=
	Hy/yPtkMRNYPZkitwCvrjahdggBWQ159QJA/MQjopJ7piVpKKKsmZIJrJZCK7wjH
	BMM82H5RA81c6W7SNf0i9QxdC9bm6S8SFncV+otjTreLDfZWpAVM3MMll8yi1BZ6
	Hr6H6a9B5+aeU4H50J4CIdjJe3yIHaMlEa3GNgJMI5GK04JCsPZv8vnS199FT2RQ
	dBlOZ8aEbL0t2MLHXvQ4Q7zV7L/Gi657voU9odwnT0uiTAzijspXcDCUHSblH/si
	M88D6J1aMDhnJvJjzTOMyNB8tSpXz+5IiDaHmGJH1pgBaV+48icVNzQeGEVGepw3
	nmzMjapQsZ2ocwXGSAh72g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwm850-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 08:33:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D72gqt033193;
	Tue, 13 May 2025 08:33:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8ecdh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 08:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5eEUdrRCBlfcfc/IUlvNsnDigTP6CG+Pxl7xl2ktk368ytZQV1QaPwTMzK+0AuNnTWTfoP3kFHYgCn0LEgY1IYn7+LJExTGypQ7t3UjCOyso1NHVbQmhwuAezElX6CMsnO07S5Noy+mLe7K+5GsVS6rCbAe+Rad7N/ALfLaox57yRIu/2bEBIqM8jOvj0WQ0y14ard+oFYKR3koZDfSppB5sxjkTQLhS+KKSycpXGyDn71IzuFdgMXlt5vvweD4omJ6KSTyKswZHM3tU78GeD7IOvg6qjFxuobEdYNfiT0jMBzpspCwkKcJdod6Cn1gWi7zLXvza2S85lcqXVR6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k1pk/r+r9TcFZo+6bFUOlENl73249Lp3wQGezbxS4s=;
 b=PYiPpDVh2fc2miUiKzF1yIWljZAql2wFCX+RymCxLtRctrJhP1aXuNf0ZBTgLrUXFRq/a45tA/sFAP34h67jWdZtoKHmHS/tWY6gM4rl5Yjm03h4k2eXxjsiG7qft8+SKgyc+rNAeeqJ1CHmlek0OMtNdsUsimCxdW52pmPkXYlYUli4295h/sO/UKl89nVWLEAMJjklQMam4Mr/xY5LHZY/fwMrM2qVGuuU3zG6W/wwqi9EwKZPcP/Fq/VVo93wse4mhlYMPkO3DZR3ypLFnTsYxdMdS7EL84bAnW08mTnnGec5AwuUA8WxQrOBqeNpnb28IXR0u6YJmBZKXUqgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k1pk/r+r9TcFZo+6bFUOlENl73249Lp3wQGezbxS4s=;
 b=bJVaq1a+k/5VHAS54GMhkUKceENRhL3cFG3cQ4efeWV8tJ6CnqAGGI49Pi+0iFKZmoYf0aTDwKjmCDR7mTsJy3PaA9yOulrqDDgjFscXQIbQigcF8KNsbREB2XsPuzkozw8w6/Ye2dRurJ5UkGHGOSdQgvBX/WmWztmcFYlGTdo=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH0PR10MB4568.namprd10.prod.outlook.com (2603:10b6:510:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 08:33:01 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 08:33:01 +0000
Message-ID: <8edffeac-dbbb-44ab-aa60-f92e041cc531@oracle.com>
Date: Tue, 13 May 2025 16:32:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: add git commit ID to btrfs/335
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <7b7c5af880673b1698b17fc183d369457e1a89f9.1747030065.git.jth@kernel.org>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7b7c5af880673b1698b17fc183d369457e1a89f9.1747030065.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH0PR10MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0ab224-84f2-455f-0402-08dd91f8c5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEFXbTEvWHp5T2RLaEIvbkliM01mZjMyVE1TeWVNbWZObTlXWDVBSVAzc0hW?=
 =?utf-8?B?WXNvcDRiY1hOTVNGUTF5T3Q3Qm1FUW4xeWdkcjA3aENpMHh2aHVZZVpwT1Zq?=
 =?utf-8?B?QnhaSzQ0d2FERHRZejdUS3ZwSW9wOExCMmJpTFJidm16MWVhT3hFRDRNZUxW?=
 =?utf-8?B?c1AzY1ltSWR2Q0JuaXRPT24yQ0J2eG1tc00renlvM0ZyZ2FISE9KbkNjakxq?=
 =?utf-8?B?Y2U4VHJ6eUFoSGJPK3Y3OVlRbHVQcm9rMy9YeS9LQnUwbk14WmpocnFWc2lv?=
 =?utf-8?B?d0JkQk41dzZIeVRJV0FmWFRVdUlhTU41Tm8xNmhJR2hYTENKZjJDTnBpTTVl?=
 =?utf-8?B?bnF4ZDZTekJ4dUIwbHNMZHlyLzZ3cEJlN2dKbVQrZE9ySTltVWc5UkR1cmNa?=
 =?utf-8?B?ZHk0dCtqRFpXd1pXcm50Uk9rNERIVUZFTGhYYmpMK3NOb1F2RElITGpzOC9H?=
 =?utf-8?B?dVM1LzR2Z201ZGxJc1k4ZndDQ01ZNE9yWldNc2RiTmdOUXBJckIwSFVJUlJB?=
 =?utf-8?B?TXBIci80MkRtcVc1Tm13YS9YU1dkMWVUbElvb3I3ZXVWN0c5eXFROStwS3VD?=
 =?utf-8?B?bkEwMFc0cDBrZ2p4b0Q4eW1sOS9zWUVhVEJyZmw4dFNwdnJGSzFaRG0zam9n?=
 =?utf-8?B?b3NLa0NWL0daN1BmRmpaWEt6UmxsWTRnbHpXMG14YjV4SmV0b2Y1aUdqd01F?=
 =?utf-8?B?V0haNFlPeE93Q0ZiWUt2c0ZGaTErNUlHZHRVRTQrcE5Hb1Y4dVYvcVdVcGFu?=
 =?utf-8?B?Q21MdWg0VlN3VFVmTTNRU1ZjTEVpKzl0ZWtDWkpJcTBseTQ2Mkp2Z2JMNnZN?=
 =?utf-8?B?K3QxZ0RBYkhaTFJzQ0c5dHlhUldpVHJMYlNiZE8yd3g0c09xdkVqL01KYUNV?=
 =?utf-8?B?Qzkvdm5DWHZHS1h5em9VajY2OWZiL0oyZUZ0bWxjZHpxbE1WcFl4OCs1eUZi?=
 =?utf-8?B?RTV2eVhoWUtxSk5pMTJ3aG9qUUEvemo0Qm5QeXcxWWVhdllBZDlzaWlnZHlT?=
 =?utf-8?B?Y1pWeHd2ZEVyeWo2aUtBR0dqTzQ0dnhHM04zekhXdmpEM3Q3V25pUlZrckh0?=
 =?utf-8?B?Nk1IL2hybjhTNEo5TDlzMnB4N0J3YjR0Wlp6S1BqQVFRaUhkU2V6SzBOQzNl?=
 =?utf-8?B?OHE4U2g4TUlHZHQ2dmRHZFVmT2dBb2oyNUQ1QWhvZUpUcVhSbUhRcjcwYWtr?=
 =?utf-8?B?bGFPYjkrK1FRdHZsd3RlM0RoODlkSzJoSnU3ZmFZM1VKOXVoTXNtUTlsY1E5?=
 =?utf-8?B?OWJPQU9JQVZPMTdmNisvdG1MZjRsb0RXSXBFY0p6eG5OYXBLL2J1RnZpWm9W?=
 =?utf-8?B?cnl6UllBemxOVW9jNUE0VmRudlgzTWozbDFUNnk3RFdocjZpU2c5WDFGRDBv?=
 =?utf-8?B?a0pDS05EM3J1Wk5LdnFYNlo1UVBKeThGckR1Z0FsZ2JQQnNtcFN0TlJUYTha?=
 =?utf-8?B?THlOTnBsTC9DWUV4cE9hdTNFYjB2dFpBV3RCTUZxVlFOUlVJdlFUY2M4ZWtj?=
 =?utf-8?B?dThKMEFQRjU3UDhYZzlNeHhtQ25lbzFlS3psSnhCY3hoNE1nckJzb1B2SWpZ?=
 =?utf-8?B?YW4yTkxralZhQkpsUC8ybFBKRVdtQmo1VzJsSlY0TU1ORWFXTThFUEJIZGpZ?=
 =?utf-8?B?cnU0MGdoR0M1dUZhVTFqVld2UisreVFPNG9ndXVjbVZTVFkvTFdCNEFJR0Ur?=
 =?utf-8?B?Zml3UWNHcElTR1hwOFRZMGl1Vy8wQTlnaTJXczA1REJRSnRoRjA4NWZ4dVNM?=
 =?utf-8?B?QkZQaGlDY0ttYTM3Z2ZDdjRZeTJJK3BDWk8vbGxWa256b0UvcWhTbC9wT3oy?=
 =?utf-8?B?Vyt2ZER3WS9BM1dsRXBlR3kxRklMM2xNZTZxTlBtczVHb1FrN1dRMU1Za3ZF?=
 =?utf-8?B?U3FNQlRCanJLWDl5QlovcHh3NHZDckhKdG03M2hhckMyK1Z6bTBKVTNQVHJi?=
 =?utf-8?Q?dEn+8mf5IaE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCtSUW56WUJlRXl4NCtZZlE5QUdZdXFxUUM3Z2JIYjJRRUZUbDFQWHdrRXgx?=
 =?utf-8?B?aU9tUmhoZHZSV1VhZ3ZrS3lESTI4K0JxWG45SUhWa05raUtFZ0Ezc2daaXJn?=
 =?utf-8?B?RjJMZEs4NzZVZjNmZnpIV0l0Vmg3U3B2czZCYkNuN3FReTFzUUYyZzB6Q1Qy?=
 =?utf-8?B?eXV0bmxxd3VEeHNsVEdpMzhKd0lmYVJlbEh0S012ZSs2Vy9JMWlxRlRYQndQ?=
 =?utf-8?B?Zk00YmdKMVlQMDlHODY3SDMxdVhRZFd2L2ZBVi9UZGRJUTBaVnNGWk9EMXcw?=
 =?utf-8?B?cWdydDcwZkRiWUVGL1Rpd0ovbWwyOXFmaU9QMUNFOElyOUU0TnFuazVhUnhq?=
 =?utf-8?B?Q2JpSzYyUUZ4WS9ibGpSRFNKNTFIOFgwNEpxWVROWVo1d3B2eUxFWFlwUlJZ?=
 =?utf-8?B?OHJDT2JPQ3Zic1FtRTNUbWxxZmVNSE1jcEE5TlhTdnVrWXo4S09lMDh6dkI1?=
 =?utf-8?B?TUxUWUlNenlWZ0FKeXc1ZWRHQ3NZMkpQc1V4dGU1V1Rmamo2c0I0MmRoZ05i?=
 =?utf-8?B?eGZ0cnoyV2NPTStIMFJDRUVWMDF6Ri9QR2I1d2pnNU5VdXdBNUVsbGx2aVVu?=
 =?utf-8?B?Z1J4VmVPMlFmc1ROZVZmNEtTK0JkaFBUS0ptQXozZ3pMSkM3MW5VK0xXRjIz?=
 =?utf-8?B?TDNVQ0NINVRTRVIzSmgzUSt6VXpBcHdLT2JlRGVmcUNNVENENkYyQ0poMHJv?=
 =?utf-8?B?cjJEaWVvWkIxcUNNTDNrRVA0MHl3cGhyZFNEcHlHbzlpakltNVp2bThDdzRa?=
 =?utf-8?B?enVJdHY2UTkzamFRTzAvRmJqNk9ONUVFcDJLUnNBWHR1aTlnNERYU0xObzhP?=
 =?utf-8?B?aUtOM0I2ZysxZkR2c0dFRy90akdpd1dzbUM0ZGtqRUpsOXF6Uk1rR3gxcHQy?=
 =?utf-8?B?V3d5ZExPMS9pTlZ5UWR3ZlFNL0FLc3JuT3RYbjlrbVNXazdiQk1NWHZuZXZG?=
 =?utf-8?B?aE1FcWFjanBvSEkxL3BRTEhWTmIrb1lDa3p1bkJRWFV5YWFiNG5ZMHE3Vmc0?=
 =?utf-8?B?UnVIdDB6TXpkU1ZrUmorZzRzMGMzR0ovR3dmVTJSYzZxLzUrbW9tZThlZUM1?=
 =?utf-8?B?WWpVZElGL2xrVk8zQko5VU9aVi8xMzVsVk9mUVYxVEcrblIzZG9DeW1OTmsw?=
 =?utf-8?B?NjJWNUlLUFFEWnFKOEZ3SG1STVVuNXdraGRQSDd1TTVSaFVQeUpJUXNPWVlr?=
 =?utf-8?B?QnY0WU1lMVkwaXNGQldaNmE5c2tHaU9EZEV5OGNndEFvMFhXcTFHNUNsdGNl?=
 =?utf-8?B?TWYvRjdTL0tnYlNuS1E0eWZFeDF5OUNyRHN6Q3d3MU1zQ0lFMlZyNkx5cXdz?=
 =?utf-8?B?cVJ2a1VuYXdGTnBhTSs4Z1RXZlZIYjRlOTh5UkJUbFp6Z055TFZtY1RzY1M3?=
 =?utf-8?B?d2k1RTlQS254Q1RZS1RCWVVlVnVPT0gxT1A5S0lUaVRtVHVGYnRQbzMwRlA1?=
 =?utf-8?B?czhsdFB5TXF3Q3dLRElvWHBsL1lCZFgzNitSdUZtRHlLcWdCRTEzd0MwV2xt?=
 =?utf-8?B?WkZjL2ZSb2VFaDdHeVpjS3RjUnBqcUJ3VjZvWk1SYVBIUE9YdkRVZEttcTVB?=
 =?utf-8?B?SkE0dmZDTnh3SDlMak9xdyt4QTBCbVJISkdjbmQ5bmp5V04yZmhrM1BGVEEz?=
 =?utf-8?B?ZGIyaE1YeEE1RHYrVzhHRkJtM1FTV3ZvdSs2dERNZ0h1VUp5a2twaXFHWVU5?=
 =?utf-8?B?eEpVU2orRUx4V2YvWUoxOUMvaXN4d01mcUg4L2pHcjc4N0hNaG9YQUY3ajkr?=
 =?utf-8?B?Tnh6cnRacjl3cWloMG4rL3NjWk5BSkdkdEZuT1Vtd1gxa1p3WnA0Mk1FU1Vw?=
 =?utf-8?B?Uzh0dWZTMTk1aStUQkZHTVIvNUFna0krRWZMU21sUGxMVWxxalFwL1UxYlA3?=
 =?utf-8?B?aHFxRUJ1MTVqYlRIb3p0eUlRK04waXg2dGtMemRKMnh5eVB4dmszdVI1L1Iz?=
 =?utf-8?B?TUhpUnBWczVKVTMxS3FvN1ZqVngzbmtxcW92Q2lRVGNzeDNyMEJuK1ZwU3Fr?=
 =?utf-8?B?QUFFeit2WW1Rc01KQlIzQURnbU1aN21ObU1RL2NROUYrbkhZMXpYOEZ6Qndy?=
 =?utf-8?B?S1R4MVF6SnFyM1ZEY1dUeHR4bUIvSnh4QWt6TzliYTBFVEN3bnBHdUpDVmJR?=
 =?utf-8?Q?Nw4b99dTCWplbB2c8vIX9KA1c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	huCMm5vQFXcyBrJTFn6Q8qR0YjOr1uiohihSRX5MaKiWF37eThG18JKXr3do76/KoOyVjqbXuj0lpO927RqfWNMwaFcVbEZc4KdrogE5cIsv6DwO0ljbUZ1xERKdk56P1rMKSEBH/pdTLHkDlVDU7MrOj9jxjWIFqJErJMfhBnEu9lyMenba/7PEdvnaOreD95Cw0+XAkgUCnTj8tYrFWGT0EOOUh+0I9MtY75zKX5wNKnujAlWGoHzcHWDl54MPUPIopaTNuf4su9Ofe5ePs5TpmrixGhF439RqzbFnOd1bQAC9QWP2XRL9Uf6BYJZIJM/M5+/9AzJ7QgSo6gv98gmSEx0LjzP6JL4v2CVBz95/dWnSghf/B3gLa35DDUhKiG1kvmUM9qqPUPRMsAyuoUyt1UeiBXyo0wqglC+VJhmDe55fs5be4lqLx3UJEXvYQlGaZqyw28jKb2nEWD8iReBP5KXUjpEiyM2XOsvcatHmQBy7X8jWJrF9gSvoXey0TgsNCiyFuH2pzhEiC2bpW4x0y71F/AUkjWSLBG/ds1NyGrFTgt+R+h2LXv4r/41tEsSFbJdmwOQxBu+9+h8QxdKQXWV3eVg1Is53AElCFFA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0ab224-84f2-455f-0402-08dd91f8c5a2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:33:01.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZskp4db3yFHX+shnQMYOE03Ims0UfakwsinGjgc/n6/hUKdu9dZkjexJXnALLWhSGcylzNKbpsJ0TH48stmOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505130080
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682303c0 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bwuA3i-aMFK0sS89-pgA:9 a=QEXdDO2ut3YA:10 a=_Xro0x9tv8kA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: v-skXj5nuWqvfoLW6Q0DzqpMJmF-YjAH
X-Proofpoint-ORIG-GUID: v-skXj5nuWqvfoLW6Q0DzqpMJmF-YjAH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4MCBTYWx0ZWRfXyFNJRwhSmVsN 7KAA3IynRZSGm9cvvbqS7C91fmGMV7wLfuFiW70yVc8S1QXqDjg4tNmmMHeoVfrL6XQo5yDz2Ua VqzxXL/E6QS2gzfNW0iOXf5G48y4xEZJN8JGkOu/ojJV5mzvDA1LihlV+Z3sEyaQBBnsJr+uLJ3
 y/9iSHYRRCZzjbhkCUQ0gudDnwnEJ5oEykILw2aySMaAtjDk7T9LSLaKOvBwbSlfdwuPzZ8PG/s WHfb0H3ok6nYjUn1jQjXmol3TbOZ8JsgPcKYt/I+wEs2ZQ+dNLyeJZY2ZRkuUy2RsawaoUu5Os0 2bcffnw5hUmQ4WRF3o9VPPeK45LG7SA8wLVUosHpSCoewgNd9SC75Y5VAx8Ky78l0cl1Lk0arJq
 UtY9Remt/N5Em9ZfKGFLvC8F7hF73nZObqbgZzucd1hc411PxstX4vg7+GD6gjIoKB41emUc



Reviewed-by: Anand Jain <anand.jain@oracle.com>

Applied. Thanks.

