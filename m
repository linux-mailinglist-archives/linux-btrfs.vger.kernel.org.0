Return-Path: <linux-btrfs+bounces-2615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8A85E383
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 17:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81FDEB21C2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29982D63;
	Wed, 21 Feb 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WR1bno2r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VtTI3t2w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6677C097;
	Wed, 21 Feb 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533628; cv=fail; b=GCqWDSJV1/N/mUBJvXK1eCbKD50zzo6OHYvKBVzr1pHCJ8tIbQuG6GCuDZmKenFr1qR9vMrFJAXsyLdvLTjXBEmroRJmOJgU+MB3QxIymyr99fElDp1GiTIAQ63FKwVO2V5lthvRBNhRHJuDJZuOInMYD5eDY/BLLAj01NRdL+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533628; c=relaxed/simple;
	bh=R1QG37wy/7O1mp5fwsdmRzScy1R25yLHlsx1m5PjYMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+f67S9w7AsR8GLLBRRGMfF3dVhLMfWu4MQd2nsm/6UKWwYbMAS0+/RXJZFwz10xOQ1oS//I9CeCswwaKbJ6N512XIv6Seq9V9Qmha3yS+VWhfU1wuRR1TjI/UA9lCtVn/n8YwPQ4KYksri8ZX772ASLc/ROzASCAV9ADSUKd3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WR1bno2r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VtTI3t2w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDijDJ012050;
	Wed, 21 Feb 2024 16:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qK8r6xWpa93TRs8FjulxaFCDN/K+mEEunojzo7aSaNs=;
 b=WR1bno2rhZTKixg8BPYgf2jsYIfuZxMJ5+/cwj0uMoiRFpB/IOriwy4DoRcTe6Mchg1M
 7z7Mcbnk0zCouULaAI5w2YUzGj8u1a3VkxXHGl1voS1mzVrV/8QgNmAStoyGaM7RPOXv
 lHkQsx3nhV2mP5mli0KfTF7Yjti7r1bGHf36eknCvFf/atOuyYOpjv30zNrOvf2xBmi4
 pbLokTeAgDtvX2Jc7NY/f0+XfCxWRP/fmy1evZTyJS6tQJiS2Dje1iUESzElzq4YIr1c
 u4cNHnbmDRgfhUP6SKXFwDnxPfQmeIBFXWErTYoZ4Ti1axJ4ZXXyzZlYfDq2BNSBTGV8 Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu28bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 16:40:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LGO490006488;
	Wed, 21 Feb 2024 16:40:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89gb9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 16:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWQKab7bvWMVQz8J942ivfJVSenzuG8bbwoi0biiKdq1ejWO54Z/r/DYg6DbZzWvqmV8Btt2WDRERjyJAppXmHotzVGxoLOhhDw351+7etyo9z3AF4O8PNBWLvPfl6skn7PTWGJikHQst62GTkzAkBlze4+pmV3HSDPXEeSloSk9AmAbjc8maqcLThhE7TONp9TMR6nnK0snVvZjyunQIGnVQm9mE2HteRmzxrcYwhmrd2SLEXWM6pVREoabXNoNDbXCIL8xbBtZoZcaFm5528JSVtFmfBeV0Dzom1AHwlE7ne2HV9LV+c83q+SqrCf+22nHt9BWBVhfBQEzW21QLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK8r6xWpa93TRs8FjulxaFCDN/K+mEEunojzo7aSaNs=;
 b=CifthXre0T288Wxn1mkWktsrdInPG/qRbc+Md0O4JWFgaYOva0a8e8QoKHNT1LdEF9oq2sJTYMJ0V8MR5mx0Du7Y988Y2wbfGZiO7Z6bRemK1RG+PlHTl3vOxXT1ohlSXeTcx7YT2FXbBGndezU6sJ+nw1BCaRW+rPI2qVVjXHplia0YoYmubksnL9VbmCERCWtajRX5s8XM4aHjI2NsFWT/tJdPgXQ0uARuAFbuDkwdrzxoe8DqS5dSKVFvQYDJsQValoVI5vXS7927LM3jZiRxslL9uXEgxq8w/Td/yBX8nmb8jyOdFCfcxfPD8eZDlgQpMXLFmP7fAcOr3k4CMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK8r6xWpa93TRs8FjulxaFCDN/K+mEEunojzo7aSaNs=;
 b=VtTI3t2wjqn16Z6rgZ4e7Rj3bNJPz9GW6x5sw68rsiny6TR6fBTDjd8U6JeM40v+SHhTNQTYC1RM7nYpVyktYPW8dFQdOzbAsI6sYQAVHr48byXhiuHePJMF0u297Yt1kfjSUmAGrFAzdzD6uUjIJHfx7Y6xROAhoj1lRu+BUtQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 16:40:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 16:40:07 +0000
Message-ID: <bdaa5790-56d8-4490-9eab-9a47e4926661@oracle.com>
Date: Wed, 21 Feb 2024 22:09:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
        bernd.feige@gmx.net, CHECK_1234543212345@protonmail.com,
        stable@vger.kernel.org
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
 <20240214071620.GL355@twin.jikos.cz>
 <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
 <20240220181236.GF355@suse.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240220181236.GF355@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 33246b40-7e94-4823-23cc-08dc32fbc2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Kg4nHnstJ+NRobr3UKIBAzrLK5rur0PRQQHaPy0we7ZNjxW5d2RYFoQ67E5kQoROtERBZdMzxCehMVsjKBziShmvdBuT2mMgnaF6UzytVQ9ZHIp4uziDKcZ0hPNENSHbNsACFbB6tPyRvQd+6oGnXnK53TeIstF/5yuIUbm9cAy57Nd8QER4K9Wg5JM6My93bZVw+nBKOpWhkGFj25oF17lP0ZgAo6AZkVUAzo/mDvDmXfZXiiHjF6/yah3GF8cyOET23y2Oe2aftx2k7enRyKilpvp4GIPKEy/t/wEmnqmqX2MLsn8qnfYYonSdVYX+UMHJf+TAdtQS2fN31O6DQrUQHdzyjqM/d5RgiPR6aWSFFBdQSbS6LOpfUeVuvwvdS7ujy9wiNdKnNExyDBnEw0v7ugEl6kYTtM8/LkuZg14FfgQMA1bvfqdaFZatcBsmhuxRjVcce7keUHbfaVijhBU69foT3aUz/7fWfWKiijHxTFbab4KzWA6atVCiXfo9uFepiKM3q9YEtur8IDCvXQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rzg0N3NlUmxRS3NweXE5Zk5QZUJreUdRTmlMTlhtOTNoTWx4ZzQrTGpZc1JH?=
 =?utf-8?B?d2hmWkVNYTFiQ0ZROTNWUENkeFlTS01xRlVNRUtpamh0YVY3elRQMzhRbTI3?=
 =?utf-8?B?c0QzTjR6RzhPWGhyQUlMUit1WjJsWjdLblFCTE5GVTJkYklZL3B1bXpkQlFp?=
 =?utf-8?B?MVUrNk0reCsxdmpmVHN6RmQ5a0xia1ZjQXFBcjd3VzBEeTdFYU92bjgxWGlq?=
 =?utf-8?B?OGQrSi9peEVVZ0I5WnRsZkdXRmVuZEJoV3dqZFJUS01vQjZ3YSs2eVJLL1lG?=
 =?utf-8?B?aDNxU2JKZnVvaExvaGR3YW1Od2NIaTdDakpycGc5Qm5hak5oNXcycUpwWXc2?=
 =?utf-8?B?KzFSQXN4cHBTQ0NZaFE3QkFmUUxpbkQyRkJzc3pLbW9zMk91dFpDeDdpY3Mw?=
 =?utf-8?B?SzNYLzBCam9BMlVIWmE4NEJxSkkvcEFjLzI2M2IrQmRiNDU0ME8rWmdwcmk2?=
 =?utf-8?B?QTU1WWlYQTZrNk5WeEFzTXptdW5tUWl6Q1VqWjNoOWdzV01scVpqVHpxY013?=
 =?utf-8?B?cE52c1VoVnZqWXlXZGtaNFdwTmxiMUV5Rm5DZVdCY0lwaEVXamZtVTNUSnhD?=
 =?utf-8?B?S3RRZGdiWUl6TldTb3J6WXhhM1hqZmxkaDJRS0dnNGxnL0lZdkxnc0FIa2s1?=
 =?utf-8?B?SHRSbnlyeU5hTnlRSkNMeGs0SmdwekwxeGRqbm1TaVpxdVZubmtyd25renRB?=
 =?utf-8?B?NWw0YUFZWm5wQmtvckFGcXRhTlFDVytwMkdUOVBJTjdjQll2OEF0TUdKdkdn?=
 =?utf-8?B?SUN6NmhHeC9jdkcwZ0RXMDZHZldGZngvSFRaOGdPWnZkdS9tbG5kZHM2UEdF?=
 =?utf-8?B?R3o0QzhpZmdzNVRyNTg3WTFIY1FLVjBWUVRBOWZiL0wyN0hwcGJCanJBaThx?=
 =?utf-8?B?UkVaUmhQL2lxaXlKaGxLTGpWMWRMM1NpUFViWUJENnFGZnVLemxJUHB1eXVl?=
 =?utf-8?B?cithNmxKTmpCQU5ZOGZHWFFaNTFtc3ZUTFF0V0tEM1VLVWE5OWNHQSs0RE5Y?=
 =?utf-8?B?ZnhZY2NIdncvREFNdThnc3JrcWtWUkhZempGdEVWV2dmNUdxYVN0NHMrclhC?=
 =?utf-8?B?NFJxTXduTElJZHNSVEMzTmZmSTNQZytnQlptU1JzeUVrY1MzSi9SdU9PVUhu?=
 =?utf-8?B?d2tzWDVoSXRPN29XTzZLM2VsVnRuNkZDTWRpS0xFcFlPMXlrV3FqU1dNbUpu?=
 =?utf-8?B?Tjk0SHNuUEZOUjdHVmJpWUpid2FHMWxudTk1NkkzU3ZMSkVsSVh3M1piQm9v?=
 =?utf-8?B?bS9TR1BwUzlNVXhHbERKYW5WSmhJWTJqb3FOWk1hRXpjbXJydXI4bUJGYlcw?=
 =?utf-8?B?cEJRSWVqdmJxcUNQaDFlR3VOS3p3K2JpVFZCRWF5Vk0yM0svSzFjMFdRN1Zs?=
 =?utf-8?B?YjQxRWVNcmU5YlZlYXVBdW5HU2phSEVwWUdETGF6dmg4ZGJVSytWbVBQM0VZ?=
 =?utf-8?B?WWhNNStFLzBjeHhLN3gxTGs0U1FhOXQ3YjUrMm80Rzl5Rk9uN3BFamN1akND?=
 =?utf-8?B?ckRoYlVqWG14SDlFWGpZNUthVlRGbDNta3dpbjVTcHVyMkpjM1poMUM2eU53?=
 =?utf-8?B?V0JDZ0FvN2NVek5ZbGROeFlQVHhDUURsSGVxbzdEYVNOT0d2UDlsWFdsWXQ2?=
 =?utf-8?B?WjRpUHpORG0vZXhlL2h1MlJKTlVzNXF1R3hwOUpHWFRVcjQxZ25IT3dMR3da?=
 =?utf-8?B?bnN0QlMraitXKy9HeGNuVkZrZjJXQmViS3RyTnFwT2RPTWlTWXQwWWRSZHF1?=
 =?utf-8?B?T1pTWU9XVUVkTU5YR3cwbFg1ZlZScXNBb2FnYXcxcUNkaTl2YjR4QUJsRkhU?=
 =?utf-8?B?dHZxVTUyNzEzUFExU054eEMrcEdBRkpFc2YxZEJ2a2Rnd2R0SjlaNlF5YXEw?=
 =?utf-8?B?NGFOWHVkT0VBaFlPdC9QNzJwYjJIQXpkdGJrb1c5cStZRjNsQlBmcE1WUThI?=
 =?utf-8?B?YTc5ODN5RVVEdzZ0RlEydHZveVB0aG1abkR2SVFHNGxhYlV0Szl2OTBEQllv?=
 =?utf-8?B?c0tDM0FkTFdGSnh2R1NiODlZcDE5UlNBSmpaMWd6RjQzL1dQMTdJd2NYdi9x?=
 =?utf-8?B?MUFGQXp2d1V6bHBWLzdwSzBGcnBBOVBScUNLVDJmLzVCKzBTUG1Pb09EbitF?=
 =?utf-8?B?WE1IT3MycnJ4K1F6YjBZVTdqN1gxKzFzTkorRFdVbyt1eGp1VVR5Unpib3F0?=
 =?utf-8?Q?yLMrd+ZyEbuc2YL2ohko6BW6jGLwV3M402NdyWthLBG5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7vEvHRhHf0uYUxz0c7VPubRU345MO1lCaJmvVTfCbtZi8oC7wkVsz3Ujr2imvgZpSnwPipBCsB59aOVsIH4gR/72xln0NwjrShfvp4yAUFR3RCQ3HlE7SqsxOCm85Z7zIJSyrg3936f4nYIkXLb7OB4oNDBGqYBqoQFKEWgbTuKn/8r8c6t6SKjfQu16F+RjPZTIr0aOoHVl04Nqg+tcv+vDG82ZD/pv/oL7ncvUVTdWJtJdPfNpEGBZJhzYamtCUtZ9FyJ7Df80HjZ7RNJ834nZfGsUCvqyxd+YL2A7Hddgt4XPfb6wmN9XWur5+DFfXLXTQ/9AFmMXTDaMJxpcL5Om4xVesmpz9r5wJ/KbMixSvcA23CUBCy45Em++icbCRHwOE1j1RViBxmYKLC8hFa0c46XnUKobW1Mn6ge7wPC92t4yr7Ly39iI5sTHPELVzS1MJ/WtypIlFefKJ0WsVfsP6ol4K0BiAfIhhUybgZZFein/eoUIhk5fSEC/gtWeQFalkM3IjNhzXEziqkymuUJfGAjVmie/bCDi6hlb5Hh6Aj2Q80EDG+XH/iRY/6p0OhskJQ3HL9tULoVPCejWjdoKqy2eDO0NbagG01IbzVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33246b40-7e94-4823-23cc-08dc32fbc2b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 16:40:06.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUNBAnqFBhFMt94l6Bgcyx8B5gZV5xW4xfBfHHSJiW7Vwfgdvfxw79EV1rz11c6x3M/LVCMQodYQmUaxR0eSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_03,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210129
X-Proofpoint-GUID: q2KkRJqCGJkpdZpCb5tIO4tRF1flwmmm
X-Proofpoint-ORIG-GUID: q2KkRJqCGJkpdZpCb5tIO4tRF1flwmmm

On 2/20/24 23:42, David Sterba wrote:
> On Tue, Feb 20, 2024 at 02:08:00PM +0000, Filipe Manana wrote:
>> On Wed, Feb 14, 2024 at 7:17 AM David Sterba <dsterba@suse.cz> wrote:
>>> On Tue, Feb 13, 2024 at 09:13:56AM +0800, Anand Jain wrote:
>>> https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#ordering
>>
>> So this introduces a regression.
>>
>> $ ./check btrfs/14[6-9] btrfs/15[8-9]
> 
> Thanks, with this I can reproduce it and have some ideas what could go
> wrong.


Thanks indeed.

I see some error during mkfs.

ERROR: /dev/sdb1 is smaller than requested size, expected 1073741824, 
found 766509056

-Anand



