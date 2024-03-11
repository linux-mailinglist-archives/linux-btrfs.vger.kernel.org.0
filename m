Return-Path: <linux-btrfs+bounces-3165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87388779B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 03:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6EB280E8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 02:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C410FA;
	Mon, 11 Mar 2024 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GbpF3ZsF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="genVoPmL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076D53AC;
	Mon, 11 Mar 2024 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710122497; cv=fail; b=ls29z7/xEzS4gM90HxLi14TZoGHhz8Vyrz1XdYwvwoZY1nw6FNRD9nlxP9Kxcx65UgXCqs/9Z/n1gJ4ugtfWLL4qI9xp2d7QaY/fOWoV4M2/wjr3/gyngDzk8PV0xl5mGDBUpS0tDiFSJxllzJ2/y7Fq4wGDowDcP+0BsBg6w8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710122497; c=relaxed/simple;
	bh=ly8MdDVZReiPTCMkiw1bYcmaVHBH0vnMCuIlwg4o/IE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=clZt/PQiG86bW9FkwNecME8ogifr/wtwE3KKdO+lEOFsG4YtrpA9KAgwziF2XrcniMh616gAohwzw2dPtpb6tpdJ2HhIYG/yN+ROq0QJsP7eBSF5od2o81ZHXO/qC8PWY/xCIyp1L1hNKJiNaG3u9qQHC+2DavIgQxlri06G9jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GbpF3ZsF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=genVoPmL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ALGHU8014742;
	Mon, 11 Mar 2024 02:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oY3sBnPI8YEyGhJ94M2QORO1oBhKuGTELo6ZNeXiCmA=;
 b=GbpF3ZsFLxq9AEk45zvct4BGbG7mzG74+Zzi79GlBuF36b5ErEBYtu38eZiF8iTmz/3r
 eyeJem+b1jVcBdR7Lb1VcnDgflyGUwDCpy++1iqpurTygZL5wl4vcSTeMg8g22Qht5rG
 njcZgQ+ppgoY8xhwyimF+y9iN5qQDIf4/SYLg6rJjGEm9C+ZmLpKq6t+CiwvIpRtUxG3
 2FkhnS583gpLdZY+6ZE7L+OFN1Drs+IUS6LEhv/fxkpK6yh+NUybraPC4tqpTU5fT4Mw
 n8k4OOlc+X5RQ5Ga2Q5Ssp/G53WqwZz2l3WFmSoPFYd7kAaOFWQJEXBd8btbf4/KYmXP jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftda5g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 02:01:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42ANjQRT004954;
	Mon, 11 Mar 2024 02:01:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre754b02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 02:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrr3qpib9NzcBYsrtZDq0vMr/S6EdS9h0HhAi6WDFmR3KSMkWikvRAh9ye5Y7d6xRhEL3kcSWj47TWvp7GM1nNxQkJgnBP7bH/4ku5kIIdcCAsNFYVQqsE9duFjFPXAsEoNxJ8ls8TFAgx6KfoIDstoIH/eFdyCKESJu//sMBDR5cr5PUrsTWloD5XdtKJJ48A/FBypYtxJ8vZZFgwdvb2/djYRmcZ5gDYjMAHUKrvnyBrUNnZOeEqomOMeT1FiZ88tuOnrYONaHJkBJhFO1N41Y9Erkn15forv3IoGFakbpit0sFvoIkXioQgu3k08BF4h8cHMv5v7nA9miBkof+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY3sBnPI8YEyGhJ94M2QORO1oBhKuGTELo6ZNeXiCmA=;
 b=WtGwBLV3JDbMjOoJ/95fIRS/xdYfZJwaB0F/z//Ra/SQZrzIJ/Iw0LOonH6pAIte2upY5FJIx6kB3TUhGAIEOfWQkf3lkC9t0XO17a0tBWda1ArfnIn5aD3hza8BYXFPqKEp7IwC/gmujUYLKHT9fLxJlJXC8diicMhla17yDDNMXeUqvJ1gGPs/vSRTnbfiVQ7D0EhHqEndCpZzkmVM4Ss731GzalMvnETKIJ6cqoVxitma1FyLMv1qo5xvyVPSMcqAUQ12coC+G/D6SIGV4+0Qqcqk0p1d0z+eJmFlvuqF4EfNUYNzvHoPsgzQfV3UMX99a95iNJ9TchWpln/hHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY3sBnPI8YEyGhJ94M2QORO1oBhKuGTELo6ZNeXiCmA=;
 b=genVoPmLpvrYYtthNTGkO5GvVSOzGIKa9yfCSDvSoJwh/egqS+gT9SFU1Vtahvpq4NkF3QNzQPFfYTT+86OqkIUH4AWv+6VuR/amseMG6fMEkZO7gj2SYqVJBXOA+piWrGmQ9IhPjzLE7WnBmt0Wm6dmRVQNwYPX1guWo9AMINs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Mon, 11 Mar
 2024 02:01:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 02:01:24 +0000
Message-ID: <e12f4474-da8a-48ef-a9c7-59eb10b7c86f@oracle.com>
Date: Mon, 11 Mar 2024 07:31:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.03.08
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@kernel.org>
References: <20240308144537.16995-1-anand.jain@oracle.com>
 <CAL3q7H69ec3URubLKdqFUiWfjRjQ=CaYtN=75eq4jMDggudtJQ@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H69ec3URubLKdqFUiWfjRjQ=CaYtN=75eq4jMDggudtJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4061a1-4919-4ebc-555e-08dc416f27bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zuPMLmBsDBDfKJjXV6jE3iPVAD5hgCUlar5ZFo1BCQ3qxXxhVbJXuk6Q3SO/89KQSLeSSPoyv7ZZRd13FUqrB3BC1LrZg5+dCIWZybWxTOHUvjBn2cs/wHDQCgwDGABhaOMCB/jQggEP8KVD9tDlhS5i4Tnb08DeCDEZEewqHrX5Fp2lneFntHEUQ5Rud8dl22SxTYl8dyp6V1r3zk01E83rNVDr8+3VRkSHEuw4DPo/zDfaMcda4tpnhk/sJzb+yq/VA/PIymoue2XB876Lx7f+6hBRh+9M+mKsphgnx5DFTr2VvH0H8vhRykKlXSvNUyAc4E8XAFMUyRJfz7TkpIxFB0Ml6E9k++4tOghVlqNtO08w/guRsmRb92emE9kicwAw26zWcAYbwNuDjJm3AVed+XQdPZSM4UH6b+e1P2yhyHMuNkSQocL4Cd4KDghSPBMcyMcGxZeJQJ+d0JUpnc2EUucpYHlhsAjoEfd+dB5LUdYV27lncELUUphnEcnMSwFRknDAeu58ZQnPPygbVJLOQ3ZzGNy+hjpTdmeFVP7GIpFj0LBYCwNyyhmD7ZlvOG6e+T5DQSNjSY3Te4bo3zdckNi+KI9EQSlzeT5Km6FdGeL8JWj/L84a2xnwh5dJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MU95SUJZejJ4Y3ZxcldleGtMRXh4NllOMWc0WHRYRStHVW5qdjk5T0xUNkpE?=
 =?utf-8?B?Qm03NFhTeW9NUHFoYTNaWDdYS1BxUktKUmdUK2dtM280YVF1WHNpWWVQa3VJ?=
 =?utf-8?B?cGcxeDRIbnFpOXRvUVUzNHI4YzYwbmZJQU5zeUJzV0N0eG9wdXIyL1B2MkhJ?=
 =?utf-8?B?QUZ5a2FBZUNiQnNRekFrdlBIOW0xWm92NThETHEwdERuUENxS1Q2RldFdFF5?=
 =?utf-8?B?Zld2OEIrc1MrN1hpVHB4WUxZa00xaGtjdmJkdGl5S240T0gxU3pBbTRlZktT?=
 =?utf-8?B?bFEvRnJFRWN1NTZZdmlGYUxJOXVPQlZrclF6SVp3c3prTjdxWU5wS2VKekc3?=
 =?utf-8?B?OWVUaTdESGhjb3ltUHhDS3p0RXR1RFFKSCtOUW1DWXNDcU9oZzJhNmN5RFVM?=
 =?utf-8?B?dU9vY01WUWJtc3liMXdJYUNZWkhCQjR6a1l0RFlwSUg3Y1loVFFMbllDWVFr?=
 =?utf-8?B?Y2xpVkY0dW0xYTVyQXBmQ0ZhU0FveGlwVSswNDEvY0pacFFjRnBtbVhRMUVV?=
 =?utf-8?B?dHFXN3c4SGgvRWJVcUg4L1prSTMrRzJmSW9TREhUOVorZzhJVXB4ZmJ2UDU0?=
 =?utf-8?B?ZVhCWGJTOHdrOVphZjhweVJnTnZRZU1FRE5SWFFWM2lHVkhFODdGYnd3TExk?=
 =?utf-8?B?blVUZmZGWG5SNlNOV2ZZaWpNODBKYy9qWTNHTUlyRnZZQVhPKzZPS3AxZmdD?=
 =?utf-8?B?UEdKd29kNDllOXBUdXVyaEFXL0RXTGRYTkhUbHJNUzNaV05LcjdyaEtCbjlF?=
 =?utf-8?B?TU9BTWhMZnZrVzkwN0ZpOUpQd3FDazB6YTFUSHRYNTRDbzJjOENocmV2dGxq?=
 =?utf-8?B?S0V4WkxQM052WHVEdlpURzcwZGlibkJOdkVtV1FIRDZ3aGpHYmx3dE5ncEpP?=
 =?utf-8?B?enRNTWF3b0lTL1RCOW0ySWxYcUlZYWJLb3lmMXE2SktCYkpYWTN0TTR4SDNi?=
 =?utf-8?B?NVdtcjlMUE5TWnRYWFlycjNYY1VHSittZU9TVWk3TjVHUS9aR2Yva2tMalFI?=
 =?utf-8?B?bU9PYmFVMHkwWWVhb2FJYzFxS0NWZWxDRmRIK2pQRE5zUDlHTW1ydnA1TmlE?=
 =?utf-8?B?ckpqV29LZVlJajlUeXpja0ZvZTU1WENPUHdpMXFtaXlYaVRLNE1PVkdzZm5Z?=
 =?utf-8?B?MFd2RGx3d29aTVRvWEtNOFovQTFwWjA5enNIRnpxcVAxMTZqQlp6NkpjUWdj?=
 =?utf-8?B?WEt3aFNJT0lQVDBoUFBBakNxUkIxU3ArQVRjZ2h3dDc0Unl2N3FQbU12Tndl?=
 =?utf-8?B?bVJTSUxhZ2lxWTNaMkQzanpvT1FDUWxBcTN5anVuVHBobmlnN2JPRkkwc0lv?=
 =?utf-8?B?S280RFFrbjlmRndaSmpLRkhqZ1BlS1d5Tmx6ZEtpdHROQU1XcXNGcnpjU2Zh?=
 =?utf-8?B?OEE2RzcwbE41SEdackhRamVxdUNnSFV1WWlITW5FOHQwZm9lTjd4Nk9oWkdh?=
 =?utf-8?B?YTM3Rml1Ri9OdUtrSUxuSEpQcW9FL2JYYVptWWVqdUxFaGF4QnpYbDB6NXBO?=
 =?utf-8?B?eHJ6NDkwMnhVMm5jZi8vUWhxZWQxSnZhU09RRWRCQkJDOFdCelJUTC9FR0xN?=
 =?utf-8?B?UHUxcjU5L3BBTWVuc3hDTWlzeVg4SkNpK21uQThKQmM2NWlHaWV5Mzdxd05q?=
 =?utf-8?B?TEwxcXIxTzhBOTVVTGE2dDE5b2V1cXIwZW5STDlwTzRGTSs0TjdpM2p1VzYy?=
 =?utf-8?B?MmhzRWdVZkhiNTVrWmVUNDhENk9tQ3l6dDVvdG02cUQ5VkFiZysxd3kwTlQz?=
 =?utf-8?B?Ly9ZZzJnUnBvaGF5MWd5Tkw1Y0dSdlF6a21yVjBoOFNwa09QczFndFVEelpo?=
 =?utf-8?B?K0lkQWxnYzZoZU9ialVvL0hyU0VkYU9yYUY0K0tESi9mWE9aLzFNT015R0RJ?=
 =?utf-8?B?Rlh1RXgwY2NKSkpFN3E3a2Nkd1prK3NzRkRyR3VNYmdQQWJ2OTdQTXN0eVF3?=
 =?utf-8?B?QlRiTWE1KzNDTk4vZzhncm56VGxkd0lyMjdNQ0FwZWpIM204MHM2V3BiQ0Zq?=
 =?utf-8?B?NDNaZDJtSWlFZE0xNnlyUnNhMEdVRTZxTkRBbTZtYUUxOVM2eDhYb0sxVlMw?=
 =?utf-8?B?Vy9wdDVKVTliTXNDV0hQSWN0Um8reGtlT2lOcE9TQllURmo1K0hTWE1IMkUr?=
 =?utf-8?B?dTlQbWJSZjF1OUxaUnNxYjVNZ0ViaWxHK3VJMENvaVgxWklOcWJCSGtyRlFI?=
 =?utf-8?Q?sekW1vXJsk/1tTq9IKK0tkUT/vLH7AiM98oCPkWHxEen?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l+GfyceHF3gB7tQGTSvXe1BxDTdQBROB2aveVbt4FxaY3gITXXpm/uYurXmZEKiINVUEckQvfAH1VDEQQZyte5apo8zcFE0ax2tyhivOzLDbEoXo2ZrENHnVnMtszEobS4x1bMI2iACN1+BHFC+Wb7Lhi1uZWvuxabXf6VJNnv4Pm/QMKJNIubQRRiSHxHywVDhLzZFqKLHg2VAajk2eOYlfjvZrRx5DDpTd7YfM6s3WWjw1YCenItNv1ygfAsawk5ENUQtLd+F3439mfOQHvRWCzMoW+ZTiYdoyTd4zfErXvKFLPwpzDOnKE7DzOlOnWeRf98R9/0ZMCUGDh1swonTN3cicGOqKOfQFD0ZSOTifyFzwJhsx7ksGWphz8LGW6xgxc5Sbz73mTIAEfTkXZdJWJ+uStTEFYD8kMZZHRCR0WHlN2BtKmEKJUKnt8ihEddEzIkZMBkbHmEcuuOci34NgflIfWui/yhPG9EDbve9m0vPboKL8yMFggrs509bTW7qzfBtyKGENw/hWaRnZTH+/xFC6HBm+E4Z4XoSUKZo/I9YYXdAWAL/Kwbqk9uN0DqWR0DuH8OWafYlAnWvYWngBXEZnk3d4npkubBaL0X0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4061a1-4919-4ebc-555e-08dc416f27bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 02:01:24.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLKy9k61UIJOgWCF8OE/Mc30bdAlztACZRfFFN5l1BLct8E5My8lzfD2LvKC4fJqR1fPEm+LxFUwso0U324J6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_16,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110014
X-Proofpoint-ORIG-GUID: vmOg1HzFRu_r5p56WFv5DjMAPan8zhPZ
X-Proofpoint-GUID: vmOg1HzFRu_r5p56WFv5DjMAPan8zhPZ



On 3/10/24 22:38, Filipe Manana wrote:
> On Fri, Mar 8, 2024 at 2:46 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Zorro,
>>
>> Please pull this branch containing bug fixes.
>> This changes are based on your branch for-next as below.
>>
>> Thank you.
>>
>> The following changes since commit 9b6df9a01ac8ee3f28a2a24d71e45792e21b6d48:
>>
>>    btrfs/016: fix a false alert due to xattrs mismatch (2024-03-01 19:24:16 +0800)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/asj/fstests.git staged-20240308
>>
>> for you to fetch changes up to 9a03e88a04b6cf6e161c8902a3a523ca22601277:
>>
>>    btrfs: test normal qgroup operations in a compress friendly way (2024-03-08 22:31:51 +0800)
>>
>> ----------------------------------------------------------------
>> Anand Jain (1):
>>        common/rc: specify required device size
>>


>> Filipe Manana (1):
>>        btrfs: fix grep warning at _require_btrfs_mkfs_uuid_option()
> 
> David's review tag is missing for that patch btw (and it came before
> your review and cherry pick):
> 
> https://lore.kernel.org/fstests/20240307095908.34913ff0@echidna/
> 

Filipe, thanks for verifying.

Zorro, would you mind adding
   "Reviewed-by: David Disseldorp ddiss@suse.de"
to the patch while it's still in your patches-in-queue branch?

Thanks, Anand

>>
>> Josef Bacik (8):
>>        btrfs/011: increase the runtime for replace cancel
>>        btrfs/012: adjust how we populate the fs to convert
>>        btrfs/131: don't run with subpage blocksizes
>>        btrfs/213: make the test more reliable
>>        btrfs/271: adjust failure condition
>>        btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
>>        btrfs/291: remove image file after teardown
>>        btrfs: test normal qgroup operations in a compress friendly way
>>
>>   check               |   6 ---
>>   common/btrfs        |   2 +-
>>   common/rc           |   9 ++++-
>>   tests/btrfs/011     |   9 ++++-
>>   tests/btrfs/012     |  14 ++++---
>>   tests/btrfs/022     |  86 ++---------------------------------------
>>   tests/btrfs/131     |   4 ++
>>   tests/btrfs/213     |  20 +++++-----
>>   tests/btrfs/271     |  11 +++---
>>   tests/btrfs/287     |   4 +-
>>   tests/btrfs/287.out |   2 +-
>>   tests/btrfs/291     |   2 +-
>>   tests/btrfs/293     |   6 +--
>>   tests/btrfs/293.out |   4 +-
>>   tests/btrfs/320     | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/320.out |   2 +
>>   16 files changed, 164 insertions(+), 124 deletions(-)
>>   create mode 100755 tests/btrfs/320
>>   create mode 100644 tests/btrfs/320.out
>>

