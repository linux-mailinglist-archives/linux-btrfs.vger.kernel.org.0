Return-Path: <linux-btrfs+bounces-3070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DAE8753BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177CA284195
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57312FB0D;
	Thu,  7 Mar 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5cMDPXq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iNO8ElHJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3D12F59B;
	Thu,  7 Mar 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826972; cv=fail; b=Gc/9shv38LGSD/iRSR8F2G/EqRoBdWqeU8fZ7njUqUUahljiVjOu8lj1TgLCWf/STJqJh22T4DSvwlSefp6meU9Zo8Xrj6MGj2ZieuHqm04xhrIeqcThXDSeb9sYhCxvoZ4hkgZSWIPUJBEfhNfSs6JvnT2V27w+R+z5TZxloUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826972; c=relaxed/simple;
	bh=kyg6GeqNckEueC2QS8ZDy73RjM+6dFiGW1jxpozzcqM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HHVOC0bOpjTYueKkSVy7EY27URitRalVzO0ONDYD747n46I+pD/hnVeHThFSJwN5AhJXuOIc6x+5lCtnqmF9gCb3PK42h7GWNQeRRl88jLfrvyjylSBWHubTxDpYX3lrK19g3yKZuTKwOTg87NrKCiBZVK28J8eOmPdWcb1Unpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S5cMDPXq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iNO8ElHJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427DVhil018279;
	Thu, 7 Mar 2024 15:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Eap9ufcztVe5wVErIJysUka7apr19lq1J1/rrEuAlrs=;
 b=S5cMDPXqp4Qffqd3aO1sFW+D8McwpWdqtLCRiUyrmMEqUEpOBXGfgkZ18/d9w4oTYj3+
 QA47wx1Y5TFnsb+T0JaCnalN8PxO5fcfp15CCV62y7fY7S32eF3gUn5bCABVkebJ/Brq
 9psR4d7eeALlD3j2OabJPAAFlGgi4RRbxGXTjY5eKql/sjYiuic8kDl1TWXN2CvKMuBt
 sPLm2wBHU2/ae7EL7cNEti+KfzIgNMIwiIhut1M3KRqByiIa7VbOCXLdKSnA9b/6osJc
 7ejAQRiQJ4t+IwJxUue+ero0jOhtjTCVq9RIt9PDJT/0QtQ45HEz7FCuanIGwFJqTeyo Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dmurg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 15:56:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427FTYWV013857;
	Thu, 7 Mar 2024 15:56:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjb4uqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 15:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU2E7x2quFoQHh6pk9EOM/z3/MBj2Vi/b8/vjpKXTIe8LqWUGuQPeIatmTMICdyYPII3cxq0nUpZ4v7tKKwYqFfMWLD70emdF/whUdGqdYRYqjB2ks+K1L/4Nkt24Efswvk89jz/fQ0cTSHSKYpB8pFbzqYpeR2X1wOuwtBlR8FZ25B110FRvjkOTAit5oU2nn+CQfQDGiF87u9bH779gp6bCf5XB5HIV2MYaNPFA70l2Ala7rNhOa7+PlQaxnKGfSztJ6dJrGClox+lXshLo8DHaG9Iucht+zMlyfLLXrsIbcZL1qxP3BpBdv24jwK/Wlq8QzYp8H89zbhdWp2CNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eap9ufcztVe5wVErIJysUka7apr19lq1J1/rrEuAlrs=;
 b=G13+yZswWSmrbvF1ctt+W0SrDbdBo71mCr0KD1vCn68vC6/QxZ15fktbZSIHzr+0fTWLna2t1+Vaz1Q7UsE8nmfdgjS9zsh/rN5TAlMxn7WqwAx95ejBS6+WBavrLDlhNQ3uAgSq6TxXPyarkN4E3JFxRvgp/MyZUBGtFk6xL0nkhikRwKW+vK1InIRc+aCPnfA6HrBR31a+P9/fynBoigpvsibCqwXoMD70pPdtE5Mbtz+8uzkRGrXxWbJjX3zXgCdBY7JPVfzcJLoJBpRGCaFwKmRFqf1mIuwZ4KpFfLZzvmf472vYjLznTIeEag+sp3PiB0hkkeVe0DM9py7cpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eap9ufcztVe5wVErIJysUka7apr19lq1J1/rrEuAlrs=;
 b=iNO8ElHJY8/4QknhHaLgU31vvKG2G8MeUEWqLpTXBFb5xnS7lbQWEwMHBKqd6MvankzdanJM7JgjWZuqkL/GlN38ftUAsHPXJ/LQHwZjktiQyqDAAx1p46fnpw7enyzn47oXP2mmCupLEptqjnjGQi93VtR9hCrcSUTvWvumX1c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 15:56:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 15:56:02 +0000
Message-ID: <0e45df41-b1a1-4946-b1cf-3cf26a28f6c8@oracle.com>
Date: Thu, 7 Mar 2024 21:25:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] .gitignore: add src/fcntl_lock_corner_tests
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1709806478.git.anand.jain@oracle.com>
 <d81464d8af573126efcc0551f80bd9968a38ab40.1709806478.git.anand.jain@oracle.com>
 <20240307152603.7wclj65j6lfejicj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240307152603.7wclj65j6lfejicj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 173491cf-923e-4bef-ced6-08dc3ebf16db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k5QsqVzprd9EZxALyzH64ypwMTECbCzXBwLKaZQihIbnaHBsi3e8sAO/fW5u/6C/0g85Ed/8Q9EDXl5QUPeD2ZvkRJnJlaPNxourtT7n8XfrctRmGkc9MXFhp+RvvCpk7+zaPg06KcMf5/SqThWasCGLTkqFk5ZXwq7FKbSKiegtGh2kAXOiHOvXKybKvAyrCDpd9wRgaE6Qt/GV601fQFMIg5nImfHWQunc7HXe9Z9vLGi1Nr0Ecs/v0nb2DXJZ1oagm1HfIOZN2ZlGwUguMV2ZZlvNj2t6bBwHvm4gGXtF+Wsf6sBPg6OZ7xgFKtp/tdp2p/LrUtXN2kqbqxEDziZT7pESqNoH68g8PAz1gO2Soc2C2e5tQqKodIr7yT/8EGAcpOYlIJd64ILV14BepOR52ynaLOubwM3DL06JoLPd7wPcOE6hdmheygPDeDouJNywvU5ykU6yVm1p3xbpVqRf0WLPUcSHgStfHYhzag1GNrmpc8atqEct9hyQsMO7BFLsSQKaFjHrxeCoXBeSSp+BINUT0haSMaO6QtkKjWs2H1Tvkr/edzJ8Ugr1LZh49FdTyeOPcWYDtCi0cZAwxbkDTI5I4bLifbQbZaxHOV4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1I4UnQyMnlhbGtlRGtyKzgwZ2hIR00yRW1wQjlxV1MveUJXK2hXRUE3MnNl?=
 =?utf-8?B?RGlEa2t6dHJZdTROZGNsNzZOZWYvUDVTcDUvYSt0UERSRGpQbEg2WUtlZ0Zu?=
 =?utf-8?B?SDF6RzZjWEhnZS9HMGRtb245Z0QxKzRVQTgrOWUyZDljZGp5UXRURG9lRnVt?=
 =?utf-8?B?NVZENjFrYjRnL1RDcThtazZ2WlMzK1BSbzR0N3Q5Z01vM2dkVWFmbWc1UmVI?=
 =?utf-8?B?MlRpZFJqVzhSZ3RrT0wycXZ6S3p6R3dWZk50TlBlTlJ5RnRpSHUrKzh5U0cv?=
 =?utf-8?B?cUttcUg5Y0NpRFRwcytZSUdHNmxUVnR2cHorWm9PK1Fhdll0U1ZhRXoveGdK?=
 =?utf-8?B?dWxZaFRUb3BySGZid0VCTDVxdjNPMnVQSDgveW4xdjRPU2JtODU3R2tZeWNY?=
 =?utf-8?B?Q2hVRkszWHF5V2YxVTRRbXVSRFE0Q1NqRWpacVJkU0daTVFqOUtGT0xUc1Jy?=
 =?utf-8?B?T0FSUFZsTlJaZmtsRENEVXp4d241MkIvR0JUNGIxZmJqaVhNZlFIUEtjVTJ2?=
 =?utf-8?B?bVlPam9iZHVKSkt4dHpmbGFoeC9NNkpXcWRPdlhxVTFEZXF5S3dPOTdsclE0?=
 =?utf-8?B?M3lmK3BtbnJuNURSVHVQVktaZnBWU2wzY01SMHBNZm5BSVdxcGc5L1FPdnVX?=
 =?utf-8?B?R2czbTBGemRydHJMVDNLSEo5bFAydTBUdVNOcy92Y2NVbVlTTkZoU0hBQnVD?=
 =?utf-8?B?TjBsRXAxWkJBTDJ3SG02TTc0TTh3cGZyODBoR1htdy9IdXFhUUQwMkxYdEth?=
 =?utf-8?B?ZEdYOTBLRDRuRlNNTUxXVTA0T1p2L3VJMEx3Zlk2ZUVwWnFnS29OT3d1ZTdm?=
 =?utf-8?B?bDh3ZXRrUW5YNEdrOWtUNk50S1ErY2VxMytsS3U4R1hnczhQRExEajhwUllx?=
 =?utf-8?B?OExXc3VHRk5aM1FHNkRLWnVUa0dTUXZ4RWc4RjFkVDM0WG9yRm9ML0NWaVNn?=
 =?utf-8?B?RDlHdGliSjNmT0s4UGxHWG9GT2VIempxandRRFpKRnZMV214ZWczUTVoTmgz?=
 =?utf-8?B?WmxuWWR4NVdGNnlBUEpKcXJPNWIwb3hYUzA4akovNGNUMWgwM0daZG9TTC9n?=
 =?utf-8?B?K21CTC85SmZyNnRFbXpLRjRPV3dtSkJnNVZteVVPQ3NWQ1VXdW1BNE5sbjFN?=
 =?utf-8?B?a3Y5WEtpbkNpcHoyNWtKL2hOT0toNi9JQW9uVjRTaFFubXBvYUcrdTQ1eFZ3?=
 =?utf-8?B?US92STZxbmZ1d05BbjVQRE1BQmlUQjRRaDhON3E2T243bVZNZjZFNkpEeUhm?=
 =?utf-8?B?eGx3QVpvQXc0dzNOZmc2WkpobU1YTmFTUXFKQjgxUUQ5NGpYZnpRYmxyOWwx?=
 =?utf-8?B?UkFrOHZQc0JlUk5tV2hudnVSekF2OU4vVjNCTTlES2NvY1poR09TQUlJUGE2?=
 =?utf-8?B?d0VZdFJ1d3hDcHRQZWNlVFR3cnhuZHFWN1FXRVQ0NC9vc0E1OEM5OFprMElv?=
 =?utf-8?B?aWtZYUx4bnRCUmkzZXRocXcvRCtUUTBRZGk4UUdwdXF5ZHZoaWMxY2JCd1lU?=
 =?utf-8?B?UlJjczViTmtMNXdRclo3WVhHcHh5RHAxZGZONXFLei95Tk1nK013bDJTWHZ2?=
 =?utf-8?B?YjRXbkZqSEIvQkt5VllXMDBlNFFENFRtNnFmekQwcGVvY3piOVYwWEROOWM5?=
 =?utf-8?B?OExmT245cWJGaENTeEFLMmFJOGdnVE5PV0J2ajJHa3dHZUJBeEZVWTNoazZw?=
 =?utf-8?B?a0QrMHJjWUphRVpkdlFxbmY2UG5rL1hBRnY2WTVzSE5RNVNvb1JYa1I4OVBq?=
 =?utf-8?B?VU9sV0psN0FwTzZ1ODI0LzZuYWcxSngrMW9vQklTaGVkUmpiYzZkYVR5bUtX?=
 =?utf-8?B?dDVwUzlSMzVVWStJY1hnVkxIQ09XVUdyQjU4Mjk2d09BRVR4NTdTNG9mMXpt?=
 =?utf-8?B?TlUxY0pZRXZaek1BbGtBcXd3Y0VtRHN2ZlBnOVNnajNMd0dYRzV0ZjhJcHdo?=
 =?utf-8?B?V3NpZUlWOW83cGJleW13amVWZlBjdXIvVEMrMmNJR2RLdWFXbWxZZW41TkRj?=
 =?utf-8?B?RThrZi9TRG9KV2tDWUZVOVRNQnNWTXB3aGxNK0VPQldzZDQ2Q1cvL2I1UmJu?=
 =?utf-8?B?Z3lsZ21GUm1tSW4xV0doV1pFYzdXRFpaUkJOQXRuTmZrMUJQUGlGeFBhYytL?=
 =?utf-8?Q?/DWZktyFJDupYGLIPCx7KnAtI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pzU2Z+J6gX/0D2VsyLxmktK4g5Ss2i2u38sRnnjT+T3an3QycsJcHF78v2O8Fj5audOpVA8YS3ORgltDPhNVEiX/zKJZZh5xQUWk8lRH++8Th8V6Cs0jruscIYKKC7buOseqJjf1swt7HGymB3KZxbEMXINOflH94u1V+c7o1BBcWRedb/T1w0cUj8mpkA2Ibh2RAbxLSultbc1qNPIhTuTnsrtdTz7LVUsE0yUp7Lv0xWDzToqdbSdIGEikU0+b6EWiFbJDO7cEFozacjG4qjiYTFo14Osla8IYY7oO+mc+V22M8vmQDp1b+5CGT6vRAFkiXg3EYuDBiM3cdVhcoITTER1+zy7MbqzIVA2aunvidi0e8jtbqcdiWSVZSKpfAhc97St2uZTB9Jq7hy2ZF7PvS7dVSA3jjPS0Agg/NiOUaGTb0BBE2ps3c3QMWoKoGdWpeYy5n1RlZu2z1joPqGRoUY21/v3DFa6ffd2gOFUaLZ7n9pbOs01YxEhxGIYvg2j3OqyAhuHXok2aWYXABvm25TgKOR+jl2hXlqyigY8RzB8VG89qZBw1f0P5kneDKEUahMeloFlzw3jtQcKRqt+AhEIN7DemhOAUHZh0524=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173491cf-923e-4bef-ced6-08dc3ebf16db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:56:02.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Go7lFDUKUogGvV8ajgA20LLhT/IqBqzKppG31WaicQdpuybhVNn3lnxBVA4sdYqbLpCRf4eVrAeV6pZij3X9BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070087
X-Proofpoint-GUID: P-ShR5CTzsYH1dzooKqed48zupg2Cad_
X-Proofpoint-ORIG-GUID: P-ShR5CTzsYH1dzooKqed48zupg2Cad_



On 3/7/24 20:56, Zorro Lang wrote:
> On Thu, Mar 07, 2024 at 06:20:22PM +0530, Anand Jain wrote:
>> git status reports a stray src/fcntl_lock_corner_tests; bring it under the
>> ignore.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   .gitignore | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 3b160209ac03..574aa9e8c1d1 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -93,6 +93,7 @@ tags
>>   /src/fsync-err
>>   /src/fsync-tester
>>   /src/ftrunc
>> +/src/fcntl_lock_corner_tests
> 
> I haven't merged this test[1], the author is still looking into it,
> due to some issues on cifs side. So this's an invalid patch.
> 
> But you remind me that patch forgot to do this change :) You can
> reply to it as a review point :)
> 

If not integrated, this change can be folded into it no need of a
new patch.  Adding a review comment to remain the author.

Thanks, Anand

> Thanks,
> Zorro
> 
> [1]
> https://lore.kernel.org/fstests/20240303050853.f7wslqfkkgdfv37i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
>>   /src/genhashnames
>>   /src/getdevicesize
>>   /src/getpagesize
>> -- 
>> 2.39.3
>>
>>
> 

