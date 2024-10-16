Return-Path: <linux-btrfs+bounces-8972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E03F9A1069
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14861C21321
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A3C210196;
	Wed, 16 Oct 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VuD54H3+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EiTRpYdh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789C2071F7
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098870; cv=fail; b=C9dKE5zgQbAjmj6r38Ec9VmZG8l6IMsD4M9UJ6ZxJw3bQl8HxFts/xJENIuSSEFEgj1iD/c7rdU/rRDFFP+ubnFn76yO1i+zpOHT5S41Dq8HuXbnr5/Ps0BB05YJNWa3JVXKqKHlECzdSrHPbPoNa27aQnfGlWJrKieRHw4iWSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098870; c=relaxed/simple;
	bh=WACpMbQwH10cIFHv41HeWujo2quUAYMRxVXorY2+cAI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=af7WolzdbGwk5NO6h7CYpv3hwcAFTZofQeZQtfaatjuUvi9+mX2Skcz8dcJzDhlB3jVKrWmJN/F4BlutIsHpWhPQJDaDcoiF7Ctl0lJ6kf7XccyTDSq+8TunnQg7roFlrK35Q7gf6N8GNwEvrPhZf84CrMaYDsEEcXjsKSSiKFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VuD54H3+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EiTRpYdh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGBdNM027244;
	Wed, 16 Oct 2024 17:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Qj4p5loBoHmVrD+vRPAw893T7kmLtHAUn+K6IP2FX7A=; b=
	VuD54H3+cQhn3iUguRXEIlYqCFFJDreZqbTGjhCXncvsmE7zcFbtanBnNkxG12xZ
	T9o11nt4aWeR6aa5z44tBccLxurdqOA4NN4lZVhlGIWABcQmCvD9Wt39zWlwQsWZ
	oMJBVVWsd+65JZZHxJF10gwKXpt5wInXCAq5zZRzMNxi6XNIVJP1hlgdUngX/j5a
	SqW5wfVdEbEELA+72NdC2H5GEQwMmptcZkY8tL+1xgGKMc5YZtcLYzQj6BbSSFf8
	w2LE9DXFihb9+W7AiOKvyQ/a3ZJ+V41RgK1sej9mKurHx5KyFq8gV1DhrWW/425Z
	c4toKMA9dXL/qRSGMP3Ogw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2mgyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 17:14:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGKkLm036110;
	Wed, 16 Oct 2024 17:14:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjfhn4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 17:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmDuS+2BLBl0u9hTxfMUpGo4oVzeCXYPKVC27qbo3VH+np676fSIp/vz8fwH8sMfZRMjNC/+KJmQA1WjyKrvOkDM1Agnh8i93zkTwypAliDABEb+eWoAUKSRJzuIIqwW0GJYiNLNfq+qfWSSVLlDU1lVqDDRpHp88VNaH1McbcYtO2U37MCfw4Uo50pfySOM02HwvIjG1z1UtybFjDhZhssAmFIaIxKIW/tHgsTe1jhk2GOWSNwYdH1r4KpWSOcTm9FKMbZbgVDGRZsONiPt9asWjrX/3DOdD/DphCBWJJPG0bKiD28NBP3YWe6A6Y+XCx/KitMtgbbbxuQnMX46ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj4p5loBoHmVrD+vRPAw893T7kmLtHAUn+K6IP2FX7A=;
 b=qEIb0wbMp9YrE8MFuWmjC3p5gyA8T7lfDUccY3Tf0VA7VF/7fsRr6SlRU9VTnavu9tiIQq9kAF63M8a/ydK9ym7EuISGhLMLg+xTQ+D+nyHuC64iZzJSR/7b/HW51VV9dpJj+MdN2VFsT7sOlSamDYmh10arqLLzkzIXJtdLHxnhhHjUfRJdI1jdGubp3mPPE6J85Y0MXFyFeUENsEbpHseytRXtIPxYk7tiZD7+Z0SXHmYSMcoRuJ7UrbyB82vEJGx7liaCgUgk39dUtcIhXxm2EB+ARzGa8nzfbwkb6ywVEg9dwPXos31EP/fSHqx47RbByESHYO2evImAzMigcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj4p5loBoHmVrD+vRPAw893T7kmLtHAUn+K6IP2FX7A=;
 b=EiTRpYdhGUel093ABmQXnKmTuwNkxQvstzr8SHn80rTa/rkZ5dy2Yye1ezryrjVxOpnBXh+3KhBCXidi5yDoXpJS89b1jX1ycPR1S9VHvCdJBb20IiG+kYN9pUGmh78rsr/3PZmxI9rZSve5VlyJJoVJGr7/pgEDzhodPrrGeJw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6178.namprd10.prod.outlook.com (2603:10b6:510:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 17:14:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 17:14:21 +0000
Message-ID: <694552b3-5f70-48d2-a62f-4c2b8caf10fd@oracle.com>
Date: Thu, 17 Oct 2024 01:14:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 29294f00-f64b-4b88-251a-08dcee05f969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUdYYWNNWVNnRmNIRlFJc0hScnlIQjhxblVESTgxZzVBNWxSUEVPMHNDbTdt?=
 =?utf-8?B?MTRvMTRJQzQrQ3ozTzNSSTg2SU1xd2RzMEg1dzVDRTU1QTRJM1g5aEVwejFF?=
 =?utf-8?B?T0FzTnFRb2d0RVA3VWRna05UZ0JiS1dOYXZGSEhrOWdFUndIaXVkdEdkeTFB?=
 =?utf-8?B?b2ZEekU4NG44YlNrc3RMYzlGVTc0OXY5SjMyQ3pUQlR2Qk5JZXVqTGV0bmJH?=
 =?utf-8?B?R21vSkd6VzBlVEFZYnpLckFObHpPMm1lT1VvRkVyZXlkbWg0UHMvR3FRUmZp?=
 =?utf-8?B?KzBpUFBBMmozTG85RC9oWmhpTHhzOEtFcS9KR1JTYTFnT05URXlOLzZDVkVD?=
 =?utf-8?B?WHhFVjBBVzZiaUtTOFVIa3VhbFRVS0RQdnhhVDFQZHZFTDM0REQrb09YNmZL?=
 =?utf-8?B?QnhCSUZvWlRnRlB5WXRUT2pBemFCVFpOZG9nRFAyNmk0Zm9TZTNYcGxnNlNE?=
 =?utf-8?B?NWh5anpPQUVoVEN0MkNIcWJJMW9yVmgrajNZUnJDSGQ1NmJsZjE4YTJHZ1Ar?=
 =?utf-8?B?c2FDdzczS0FxcWZZbEF4Lzl6T1liM2NIMXhYZzl3anZSRUZYZTlRdHV3Y0NY?=
 =?utf-8?B?cGhOdFhwbGFoSWcxZ2lVQ0hTb3Y0VEN0d2dSVSt0MlovUTFCVmdPN1J5Q3pq?=
 =?utf-8?B?akp0dkpXUG5YaFo4eTQ4MjcyNlFvMkpBODNPWlkzWk4wZ3B5dEVBa1pONEEv?=
 =?utf-8?B?U1Z4c3M2ZWVZUWgzbWMwQmJzeTlsQkdGL2hBcUR5OVF1WnU0MEJLMnB3Wll0?=
 =?utf-8?B?NmJzNVFndm1YL2FpODZoRmpsM21NcWUzQU9zd21lOWVBQmtxeXpkdzRuMW4y?=
 =?utf-8?B?VmluRjZyNmdVRFZXbFFOUGxtWUY3SDM1TnhCaFNjcU9hbmtUTEFObk0xemh3?=
 =?utf-8?B?UWdRMDMzK1JNK3R5eGRJcHl5S2gyNklMdEZVbUUwczV6OXZMQktFTlJzcjk5?=
 =?utf-8?B?aWdyMC9LcDVwd0ovaUV4amxLZzc0R3NrZFczMllCdGFsNmpFaHRjMlpOK2pT?=
 =?utf-8?B?UGxqWFNweXcrSkNPNGlBUHZBaFRPRUVmenNHQ05Da2cvN0pJOHVvellWWWwv?=
 =?utf-8?B?TUErclllOHZsS2gxMEFyUHVEMnh4b0dqTGg3QSt6M0N1OEd5TUN6Y0ZqQlhy?=
 =?utf-8?B?bjg0TXlqY1JKK1dTVCtUWkpNUG5QY0M2cnFOSHhXZVM4dzd1cWN2QngyV2Jh?=
 =?utf-8?B?alBPYktaSWtzWGZDSWJjaWhrdjBmUUJyS0RoczVxeXVEeVpiYVpEQWVCT0RF?=
 =?utf-8?B?TW9RSFkyQ2JEK2NrUHJYRVJETml6c081MHJZVkZNaXhDNTFySHBoNHZrcEZH?=
 =?utf-8?B?MFpuc04xREhSMG14aEhzVXJLdHljeXdGd0U3OXJabnhxeW1Jcmc0OFdkUzZO?=
 =?utf-8?B?QWtKNXZ4SzFtZlpqSmluaGdXR1k2Z1lwM0JiNE9jSmJSZkdMRzF1c0FJeUwy?=
 =?utf-8?B?SkFTdmQ2S1oyOGkwdUFIM0VDTnBZTEYxRGtya2xsdDU4QjFBbjEzZVh4aStM?=
 =?utf-8?B?QUFad09hRUdXblgvdUxvbWJEQnpaL1dvUEVmREhpdlJZNXdCQmtVMGJ0SE1v?=
 =?utf-8?B?OHRBTlk4ZHNON3Fua2FLZXZPcGtOSGNnanUwL0tUbzFDNnc0bmhCZTZWdHVz?=
 =?utf-8?Q?JZQGSl41m3/4T3dITW5+O/V/IvC5u37sj2/S+f4GoIds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG5GWmVQQy9GYWx0ZFJoSlpvcDAwWnRpYm5tcTNodHZoRmh2aFBuQzJKNFVt?=
 =?utf-8?B?ZnRoTXlXTTdQQWVRK2I5WHNVSmdkZTFCdDBnQUgrd0RLNmlRVE5RaklTQUFs?=
 =?utf-8?B?a2hyaXlYbFRscHZNSkM2Si82QVlqcVNzbitCRS9yYWF3NU85OTBBOXJOaFMr?=
 =?utf-8?B?K045b2FFRmdRdTJNVE9YYktuVVNFMjZNRFBRVXVYOUU2TDdpQ3I1VFc3LzNk?=
 =?utf-8?B?QlRBeXZwb1R5WDFIYk9uY3dMR2Zja1J4ZEI5MlpXTldRN1RzZ3hjVnUrV2xB?=
 =?utf-8?B?S2ZjRGVOT0ZuUnNiS0NCaGpiV2kzREw4MWJzQnhQUmlVSndpYjRnMXRacUpX?=
 =?utf-8?B?aVVrRWhPODJITllWbW44MmFSaTg4ZityS2FzTW1ORVRQSEVabUxRQ2l4bkFZ?=
 =?utf-8?B?TVJJckZWWTR0YVFRUjl2bDBmVXp0a2VqR214NE4vZ0F5ZjUyM1VkWDU0ZXFv?=
 =?utf-8?B?M3NIMFRrd0cvL0hQaitCeHlNbFJvdDRsMUJGbW5Kdlpkai83RVc1QkxodWJr?=
 =?utf-8?B?Z0N3U0VLYVhZOE1Ha2hPSHp0RzZKQW96NURUWE4wdWZJamJWdWl1TFJ1OWhw?=
 =?utf-8?B?S2lOZUhrL1liS1lsalY2UGpyR1hDK3p2c0QwQ3pISnlhSDRvbXAwR0pUcmps?=
 =?utf-8?B?QjFWVlFNL3ZuTk92ZDMwa0N1ZlhUaEF4dXRZYTE1WjRucFY2Y2NjOTkrYjlI?=
 =?utf-8?B?SDlrYXBPR25hQzBxSmVWajFqazdISXUyTm02S28xaVlxZTl1VVJPUWhkZnRp?=
 =?utf-8?B?Tk5Yd0ZzR2Z5Q291bE1MOXRmZTRFQm55RXhpbkM0RWZ0U0J0NkZKS3lSbGN5?=
 =?utf-8?B?RHNtcCtNWE40b1A5by90M3ZDdHM4T0c0c2haZEhyZTJWOHJVVmJJQ1JwWmpu?=
 =?utf-8?B?RjMwNnZCQ2hOTmZ2SmZSNE1maVNUbzR3cVU0K3FRV1BSMnE1NFY5RmhKVWlH?=
 =?utf-8?B?R0NwYlZ3K3JTY05LcUVReHZweC9ENDhDVVF3eXREQVVaVGZTdThHYUNmRzZv?=
 =?utf-8?B?aFQzcDIvclUwcEt1TFl6OTI4V3Y0UG1heklyTTZOWVVhSkxGUUN3ZFYzcWxT?=
 =?utf-8?B?SGQ2cXBpVng4ejdrYXlKQnN4VVQyKzFpOXovdFkwV3o5amNJa2JrUEM0N3Z2?=
 =?utf-8?B?NHYzazNtSU9vOUpWellsb1hoVU5neVZZalhyWE5zNGVNVk5uZHM4RjZ0RUR2?=
 =?utf-8?B?ekJ3eWRSQzZlYnpVeTRhU2F0b1djYWdZdGJDcmpHTkwyRW1Oa1dTWmJxbjR3?=
 =?utf-8?B?U0xOSlFaZnA4cm4wZ0lBeHk5TnZxT0RkRWFBL3VDakRqdnNnU1NwSEN3S0hO?=
 =?utf-8?B?bDNNQXBYZmdIbllYZHJ0R0svbDRlSENkZldJMktlcFRrSTlzWEpjekZOVUtH?=
 =?utf-8?B?aXVGbVZpQXFWY1V4MWFWU1h1eWdaV0hDczZQR1hud3V0WlBkYXJiR2VsT0R0?=
 =?utf-8?B?R1h6UmJkUC83OCtMVlFwczVISTFUUkJwYnBYd1duUm9nK09BM2swa01xNFlS?=
 =?utf-8?B?YU9lMmVOazd6QksrYURRalpmbDNGVHIyS1VseURtZzEwY0hWLzhxQm45VFk5?=
 =?utf-8?B?dVBtVVpLb0lZYlVrZVBvVndlR1U0ekQrbGROWGsxdjkwRGV3aVF4WXZpUFND?=
 =?utf-8?B?Zk5XODZoeHdSS1BOYlgzSWtkMlFOVFFNT21rOVgrVkwza2JxTm44QU9UNVVn?=
 =?utf-8?B?QlBhczVLNUhlcXFCR3drT3NHL0RlNkRON0JGenBWNk9LYVNJWVR0U0w3dER6?=
 =?utf-8?B?QjIyT0lTMjV4R1pJcDJLamV0ZGJHbkcwYk1oeW1IcFdsMGpuay84eFRpR3g3?=
 =?utf-8?B?bXVseWJteHJkREZSa3lRaFkvNlhuNWIvYXpzeUhhcWFqd3hnWjN0SGtHdVl2?=
 =?utf-8?B?ZHRYQUV2QlF5RVVnaU9wblpoZ3pJRlM3SHlpZDhHMzlGU3lxSkZsQ2RFNDdO?=
 =?utf-8?B?WFlvc2hxbUh1eDBuc2c5NFpEZkk4eTlqKy82QXZhWFBURTBabGd0Q1pKcC9E?=
 =?utf-8?B?NU1UenVEUzNUTUlkUFowSmxybXZlYWhpbmw2bzBqaWFaTWkyZVNaSk9xbzRS?=
 =?utf-8?B?ZkZXQ1dQMGtLR2FDZkluNmxEN0JJQUVpZ2hiN0ZEQXlSS0tuNkxqOEp0amVS?=
 =?utf-8?B?NkpmYUhCUVNqeC9WMjZWWmszM1RqNTFqQnBMTEx3TU52Zmw3c3piVDgwdWVV?=
 =?utf-8?Q?fScJnA4mz5IwRekI/hj2H6A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lW0goBkEiJ5Ex25py9U+UEo/y4E62UFtMdBUxSN+BqhIHrPqp8HwheBaT094SjRU1Eb9UyozvukLefHctb9t4OUJgoCIIkysGqTUXnqTIHkFZ7vavGXxakpxtjOJNtt3jAsO8OJjAqe4A6OzgQVwCXqbgYOj/NhPDvkhPnhgb9x28RyvOoRNGWqqLLB7+gigRhpQi6NXxoFxjw7YU1dytauO0weB1cA99V9+OHxyJyeDU1d+O/qZ6qXBESITq8b80m8c4zhZBIzwjJDfdvCpL8OguzA6dosiIxSe6QWA2wMt5c/7clJEr1P/301w7GLoTiHHM0VdNuwIIdB8kmhsKwX7hre+DbeUJXQuKEaqPhDJJTVO11c1caYGHQuIShKdK2gpLfhcx+ePDtc/gZ88SCXaD8oZeQ/49CvGIcPks4yu2mRC41OTzIKyMqJ5LtX9ehcYRbhsion/6XcpaVUiSgXpoV2MVR4a4/iAT9+4xh5VziD1MsHcuHeeYJGf1zizN32Gf6esgmtEy8xsKVLgryHMBFVWYQPz65Cz0cyBi9pKT4gR31oCScpPXr6AbYgYLtb3h/gwsAp/B85AKfH64jMjgQkURsWb5QdzfO806CA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29294f00-f64b-4b88-251a-08dcee05f969
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:14:20.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lm/J78U5KJoTqJo+bYy0mj/mLI5n6N0ial9/dYJ0rGUvUC/jJLFfPeF4S6puQI2nxjcEF9Q/RBCHTuhfgmQXLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_13,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160110
X-Proofpoint-GUID: 4JHHhTBbVk2tQyMWJVsHt8kNORVsk9o8
X-Proofpoint-ORIG-GUID: 4JHHhTBbVk2tQyMWJVsHt8kNORVsk9o8

On 16/10/24 05:38, Boris Burkov wrote:
> If you follow the seed/sprout wiki, it suggests the following workflow:
> 
> btrfstune -S 1 seed_dev
> mount seed_dev mnt
> btrfs device add sprout_dev
> mount -o remount,rw mnt
> 



> The first mount mounts the FS readonly, which results in not setting
> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> somewhat surprisingly clears the readonly bit on the sb (though the
> mount is still practically readonly, from the users perspective...).
> Finally, the remount checks the readonly bit on the sb against the flag
> and sees no change, so it does not run the code intended to run on
> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> 
> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> does no work. This results in leaking deleted snapshots until we run out
> of space.
> 
> I propose fixing it at the first departure from what feels reasonable:
> when we clear the readonly bit on the sb during device add.
> 
> A new fstest I have written reproduces the bug and confirms the fix.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Note that this is a resend of an old unmerged fix:
> https://lore.kernel.org/linux-btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io/T/#u
> Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
> were also explored but not merged around that time:
> https://lore.kernel.org/linux-btrfs/cover.1654216941.git.anand.jain@oracle.com/
> 
> I don't have a strong preference, but I would really like to see this
> trivial bug fixed. For what it is worth, we have been carrying this
> patch internally at Meta since I first sent it with no incident.
> ---


I remember fixing this before. I tested on 5.15, and the bug isn't
there, but it’s back in 6.10, so something broke in between.
We need to track it down.

The original design (kernel 4.x and below) makes the filesystem switch
to read-write mode after adding a sprout because:

    You can’t add a device to a normal read-only filesystem
  so with seed read-only mount is different.
    With a seed device, adding a writable device transforms
  it into a new read-write filesystem with a _new_ FSID and
  fs_devices. Logically, read-write at this stage makes sense,
  but I’m okay without it and in fact we had fixed this before,
  but a patch somewhere seems to have broken it again.


(Demo below. :<x> is the return code from the 'run' command at
  https://github.com/asj/run.git)


----- 5.15.0-208.159.3.2.el9uek.x86_64 ----
$ mkfs.btrfs -fq /dev/loop0 :0
$ btrfstune -S1 /dev/loop0 :0
$ mount /dev/loop0 /btrfs :0
mount: /btrfs: WARNING: source write-protected, mounted read-only.

$ cat /proc/self/mounts | grep btrfs :0
/dev/loop0 /btrfs btrfs ro,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

$ findmnt -o SOURCE,UUID /btrfs :0
SOURCE     UUID
/dev/loop0 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa

$ btrfs fi show -m :0
Label: none  uuid: 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
	Total devices 1 FS bytes used 144.00KiB
	devid    1 size 3.00GiB used 536.00MiB path /dev/loop0

$ ls /sys/fs/btrfs :0
64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
features

$ btrfs dev add -f /dev/loop1 /btrfs :0

# After adding the device, the path and UUID are different,
# so it’s a new filesystem. (But, as I said, I’m fine with
# keeping it read-only and needing remount,rw.

$ cat /proc/self/mounts | grep btrfs :0
/dev/loop1 /btrfs btrfs ro,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

$ findmnt -o SOURCE,UUID /btrfs :0
SOURCE     UUID
/dev/loop1 948cea35-18db-45da-9ec8-3d46cb5f0413

$ btrfs fi show -m :0
Label: none  uuid: 948cea35-18db-45da-9ec8-3d46cb5f0413
	Total devices 2 FS bytes used 144.00KiB
	devid    1 size 3.00GiB used 520.00MiB path /dev/loop0
	devid    2 size 3.00GiB used 576.00MiB path /dev/loop1


$ ls /sys/fs/btrfs :0
948cea35-18db-45da-9ec8-3d46cb5f0413
features
---------


Thanks, Anand

>   fs/btrfs/volumes.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index dc9f54849f39..84e861dcb350 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2841,8 +2841,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	set_blocksize(device->bdev_file, BTRFS_BDEV_BLOCKSIZE);
>   
>   	if (seeding_dev) {
> -		btrfs_clear_sb_rdonly(sb);
> -
>   		/* GFP_KERNEL allocation must not be under device_list_mutex */
>   		seed_devices = btrfs_init_sprout(fs_info);
>   		if (IS_ERR(seed_devices)) {
> @@ -2985,8 +2983,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	mutex_unlock(&fs_info->chunk_mutex);
>   	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>   error_trans:
> -	if (seeding_dev)
> -		btrfs_set_sb_rdonly(sb);
>   	if (trans)
>   		btrfs_end_transaction(trans);
>   error_free_zone:


