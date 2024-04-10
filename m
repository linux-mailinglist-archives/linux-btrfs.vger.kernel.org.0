Return-Path: <linux-btrfs+bounces-4083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E789E8BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 06:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052921C22932
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 04:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B910C8E2;
	Wed, 10 Apr 2024 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UwLVL1u3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VJVb4h/E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CA8F44;
	Wed, 10 Apr 2024 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722580; cv=fail; b=d1A8dMsfBPbpZFg5S/74d++vVe7ea5ayZyAXV1LKtDGpuwczqsVs84Wb7zyzalhLi+xXRFYsdwSr5lCFI0ej4UimvbYQ8Tg0/TUAinl5iK6pmcpEL8cyttlv6mUjLuumgQA0j+rIiUF2KSSElx8rHCtDisnLEunjQjGExg03bdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722580; c=relaxed/simple;
	bh=0dOZB6FNnQmPJJj/83wCMRcal1+3wD5Ir+UWWuC+U0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sVctUH8FZJLPgrb6EUPAtKBTNRpFaCYxFQ5lntyhtkYGBFZpqOU3CKP4qE1MUqG5+SWhMH12mRC6Snq02obZNIbd9+gFzq2qKLjMwMTK5tn+9EQeSbJ/HYX/YP9vCVCHMP1fBF2i47j3ctvpO5psep4OrwZY8Fh+5ij2K2aEYJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UwLVL1u3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VJVb4h/E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43A2GOtw003739;
	Wed, 10 Apr 2024 04:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SdzGTEY3zTo5iYJ/KdU3bUKVGMoHmVNZpXVmqFLPZ+M=;
 b=UwLVL1u3b/uwlF7G1ON0Lj2vZlR1vfsdOijVdyx1bnNDA28jREHixxY0fRpH6MKBr6K6
 MqLvDr9kgvD/RQ/vrIbvWnRjQGhqeYzu1syb5JKg4DIbLmpcuVilyeB8yuzVdVMCM3s1
 OYzdqNglyYuIHIrYsoROVtvQhfgW0pyyA65LtIWMbPG24A0mSMSXJ0LV6vuNa/crdKgE
 3+EWxmGEMzuhLinB5Bej3iZyG5VXMVutXuy0RyX9R353EHjKVg5TsS28TdwJSjEATKO+
 fgJcU/xL0O3nYiuEaGB1SPucSgucdC3BsGvx+31KHyg7V11aGSR93slgl2c4XEE9734Z mQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b6ca8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 04:16:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43A2hrZt019467;
	Wed, 10 Apr 2024 04:16:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavudmrce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 04:16:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij/eC3wi5EWmZ1j53G55YgWUnAEHe7gEtiQ/XHBoJr2eyy+oLAxuK20TGd/b/yskrM1wWqf4IDwQc2n/yLVEhnyVdsJ24Vvdnl6e3ND4p5JtpobKMVAuzfbhAKF47UJqtpZcwLbE9/fUpRPnNOwwrvRs+S0aFW9j3xPQV6DdM+7QljNLX+z8EXvYYDQLNEOH1xurNgbaypIcqYt/KxAkxxnSl89+ZosVbBfHiocP+qijPUo9VhuVY9haZNq1QJYWRuH5eXZAWfjfrv8/qmnM5BLzQn1nxHivZRlahENrGRkdO14M5nVeghhKUoqiN3dPzd8R3Ql8dB1YfMpEMw4Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdzGTEY3zTo5iYJ/KdU3bUKVGMoHmVNZpXVmqFLPZ+M=;
 b=Yujy9QoAcE+Wgne5S/ZHhOwLhx44ELI3tu8xH6O9B0BhtkM00cSHCXc+puXo/n+p3pMiZvbxdgtWX5vfjFFV2AirhuTDQmyFhddTMKvK+vvFAkKFqQDT4MShEpssxwdwoXZ74nyEIU3k1/RFxZeQ+m/k1jd56eVJO+iLawUbyApzZW0a6Y/f5hZT70gH1+5roFmNeWErEdFteTLGKtCgzRt4ck5eyD+NAeF5cYeI5joi6+oY8I2xXExiDelTc9RVw9x64vyw/fAi3PFjctUyo7NQvQu9+KZwbpAtRlEQKXY34Bejd0z691rwNfCudfZ78mT5ThYbxa20UcWYr+rwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdzGTEY3zTo5iYJ/KdU3bUKVGMoHmVNZpXVmqFLPZ+M=;
 b=VJVb4h/EjBubVJnsT1SGrCUcB04fMOKTgPzupUYbRcH+Okik6alcgOzeyQ26EC8WDwYlCSjPah2Gyu/T0AGTjAwVsy93YwKLBPb+FBKvSV//ZFUlV/1IygKf34AROfJhKMDSAm9U5FC/Vo4PZO4xb3jWwxly6zWTXPF4AoMm6JI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7811.namprd10.prod.outlook.com (2603:10b6:a03:56e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 04:16:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 04:16:08 +0000
Message-ID: <f113ab1f-58b4-453b-a6eb-7b4cce765287@oracle.com>
Date: Wed, 10 Apr 2024 12:16:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240406051847.75347-1-wqu@suse.com>
 <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
 <20240409111319.GA3492@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240409111319.GA3492@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7811:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M+njnbWRAT6GqpvR/rWWDbzA/Td7GtL6uFweBWE7+5HyBC3sobbDkGAAxchmYTC6walg7LITfJEizzI4gA+biUtSjuJlGQMm2B00m1joVeistdIsDavRNsUbb9YIQcaL7HkYR5Ea1o2Re4nqPXmp4cj/e3nU14fmSs98WD16eK0xacmfpV5D+nkM3sEvuaf4KlnORhFZsjJzgN5L1E/2tJcRtdc5RiHWb4VA23Iczs+6aReu2IksyThau1axyHPpUEQEz/FqSDe6pCtlpv0H/wRNI72zOdZsw/PSN2SilmULXRvoPOYbFND0BGrLKqe1cG7i31A/ZTWiITJuAWt89Og/U08RfCpFM0x8GgVKYM/z64Ztw+VTxSiPYEDYkjTj99J3g09HU+7qRAClLseKNMFOVm0SyL0s5e9g5gc7wxJbcXV3ZhVE0PYyuE6pv0e++Ee4ep55ui7jEWWPSaLetnMqLgc2fBcfnTDkGrVQTd/Uf+FnWwpnyhHz2Hbw/J3th1BnDUENd8hy91zLra04iMws481NhKzy3iGMsHVhJOeK0V51ilEJg6aAHW7/Q/Zv1b3k4NROfhAjPaniCwsUXRZsDwM3BObwH714xcgh3mqnudacpQH2a1IMQIsWHqP2r/U9CFx2J4AyGryrz37YfMK7lr+1aafbrcVhqZnEw/g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WG9vODRnSnZmSlNCbkticHFxWUJBdVdORzFOSm5RQ2IrSXptWlhKZ1VZbExY?=
 =?utf-8?B?R1g2ZGU3aTNrcmZadG1QUnFKcHNGd2NVSmFUc0xyaEZkUjBqOTF5anFXU1pj?=
 =?utf-8?B?RUs1OVJMZ3R4cER6TFR1OW5wdU40RDRjRmtER1JIblRVc3R1dU9oZDl0RjFJ?=
 =?utf-8?B?bUxjQ2F6NHJmc1VoYzd4bUJZOGoyeVBiQ202TUNkdVVXbjhiY0V6VXRadHlk?=
 =?utf-8?B?USt3dVFVRk5pOUMzdU8wRXFGaXZiWFFFNGYxSXJWaURTRFcxaXVCSEx2d24y?=
 =?utf-8?B?MlM2emJvQytlZjBIQlZMTW9uVTBYRTh3cUVIaGRqc2FHUWxBNDlFalpGbkpn?=
 =?utf-8?B?dC8xUnorN0VRcWwzZE9YVTFNd2RoR0UzUndDRFRZYWNNc2ZySGZQaSt3N051?=
 =?utf-8?B?K2g4cHQ5MWsvUG9uTHVTYWJTTFl5NGErRXo0Q2tSdmZTMnNMWHhkTnZ5UHE0?=
 =?utf-8?B?RlFLOXpJeFRZZVlNU2Z4d0RvMEZhdnZuTVJucy9KSmw2Q3Z4Y0svMFM2SHJ3?=
 =?utf-8?B?ejcvNkgzMlYwRlA1Ty95ZGdGT2xYelg3clRBMHJBenlLR01BazNZcFNFNlR2?=
 =?utf-8?B?UWdPd3ViYi9mZGJuQ2VJaExuaWVmUkJmYjJVdjFXRHJSZHhPUFZMOVQyeFc1?=
 =?utf-8?B?RTdwUmJwVkFaRG9sbXVQdVpqbWFXL3psSnN4dXRHc0cvOWZFOWQ4ZkthVkM0?=
 =?utf-8?B?bzQrV25UaUIxUlYvTWt0bVBROEdlY0doYUV5UXRQREd3akkydlpGWEZZS0p4?=
 =?utf-8?B?RHhDaHhXYnV3UXB3Qld4VTJQMHQ2dlJveXZFSDVoRGF4MnoxM0FTUENNYk8z?=
 =?utf-8?B?dkNqeDMraVNhaEM3KzBpZm5YcC9PUytJWDFrWEQvTFpnZ2NZa3RkOWc1cTVF?=
 =?utf-8?B?bWRqWWNrUExoTjMxUlpXUk5JWkNtQ3NBdWlWM09qdFV6M2F0aDk3NzE3RXoy?=
 =?utf-8?B?NUVrVHAveXdvZEVEMXNYV0JRQ1ZySDd5aktkaFhQUk9lRlhxaFNxTlR0Slhk?=
 =?utf-8?B?V3JGdjNCZUVwTDdYNXFKcFROdVhuVktJMEZ6L3J2YkZJWFVWam50N3h6b1l4?=
 =?utf-8?B?Z2hCYjFLdnY0ZHpwd0tETWxhbGg5NmFSZ3g3eko5ZzR0QzVjL3JOdjlJcUt6?=
 =?utf-8?B?ZytuOG9ROVJ5bnFpaENOSjYwOFkzVHNZbW40VWNTZ2ZxbWJ2R2pGeUQrVm43?=
 =?utf-8?B?S2t4Z0xkVk04YVdlWkk4OWQyY0pIajhxY3ZnRTZFdmZpL1ZSaW9rdmlvTk5k?=
 =?utf-8?B?d1JtRUlGQUVwbFY2UFFtVG1ObFpyOE1LQzNtMWlCeDhtTUJyS213cVZuRFJm?=
 =?utf-8?B?ZmJXUFBzSWpVRWxpbm1WMmEzUkp6V0VDL2ppdmMrSjBSTDQ2K1RVTHNkei9Z?=
 =?utf-8?B?TXMvMFVjcVI1cVJzZWJydlczOURpY3R2M1E4bmtkNGhWWitZdG96Rmt6RW4x?=
 =?utf-8?B?cEczK2NNZ3Z2RHJNalNGbVF3bHViZXp5d0JhQjdmOEtDOWJsQjZLVWRITmRU?=
 =?utf-8?B?d1dpaTk0eEZlbVVMMDlMcnZIS21VTzVYdjRnazAzM3I1ZWVHTm5SOFJ3bFlk?=
 =?utf-8?B?QlFWSlRTRkgxanhGKzlsYmJMU2JSMDBPNkF2enA1eXhHaktFWmczWHBTdHpj?=
 =?utf-8?B?ekNpZy91ejdFbERIYTRKdk0vcWViblhicW9ERWcwVjVNd1pIejNrMkRGWGhH?=
 =?utf-8?B?cUtBS29uVm1nVTk3WUVITE5tVktQMUl5SjErMUt1anU0bklFRjA0VVRjSENG?=
 =?utf-8?B?bWF3QisvWnhGOSsvVXJsMkU2bld0UTNYVVpza2IzaTdIMnlVdGdQc0dXZWp3?=
 =?utf-8?B?eXZXRFBTWlc0dEdyRmlPUkxIQmUzWUJZby8vWlRnclc4T2pyRWhnTEV3Mngx?=
 =?utf-8?B?SHVSSEkwbmQrTlppSkVYT1ZNNjY2NGdLdW5PSFQyR0gvSzA1bTU0cHpVNVd0?=
 =?utf-8?B?V1drSkJncDlET0RyUU5uUVhWdExtdHhZVlNIS1FrNC9TVWNiNk1ITGdwWW5J?=
 =?utf-8?B?c1Raa2RwQWFIamg4YkRrYm1OS01kZlMyby8vN0liamU1R0tsYk5oQnFhY0pR?=
 =?utf-8?B?QTVmQUc3MGd4K0JDc3o2cHVsMlVyYTM1bHo4SUtLRERRbEx3L0JhMVEzbndG?=
 =?utf-8?B?aHFVYXUvZ3BlWDFheCtuSldzcElmVHhwSHRGdXBkU0krT1lNV2VIS285M2pt?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	upw5v/AtSpqfkTvenrKh8NZRbFABpPOOBV3R7kiajyA4dO1y/XwYbt4hhlhlOoaK7uSNSKJuzWj7NYJDOVbcDzrCnzi08rIQ8+RPHRFDiE68LupOwAIUc0iJJK0xjN6bBmAwlzlww1eeo7y3GJRZvoVGF4p0yIynA+kLExBSLgsXNg4uW7bEjwaMFNZlXBkip/74NzzQ9RhQwmGY3xc2uvS6KtXknFMKcFXgzMznrzTs4cWbl0LLFHjsne8+HUnx0LxJd/2Xmfwxnd5wIbA2rDXH7Q5FiB8bLR8ecQw+EZq1gNkfgPQdXj4YZscJ4sanQqUaSKdfIUwD1P4x0gQJz3bhYPpJ8KCIzb9v+XUHdZVi2xIyO3c2wDEcDxdSi9Is/QBy7rjxfHyhQVE7LkJCCNfT3YeZyM3Cv4VWlD62wIo+21Yfq/k7w5p6MF6//N91MUsIe9PUGMr97oMNsxlwrfTBO2eXWupk1V2Upxf4dexVqQwqXV6G3D6JAvrSAbco5YSy9Rcwu/C9kvRhH+6iL4ICKBXBRDm0pMqZfltGBYhtAES5xcvoLs1RuGx4Y6dW1kdvsQZgywl+5jSIhEdcKKfe7zt2jxImoNvw9+w20Co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed0c053-4ee9-40cd-bbc9-08dc5914f28c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 04:16:08.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKUGygZWFQKNwWmLIh48D/+sibzhnpsJpzQob6AA503fT6R3JXQRUFJeUieXV8qdtC1MMESv2Ouj7a9tHL4Tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404100028
X-Proofpoint-GUID: UAFWJ_MNspXb3Uvx6TBvRZLXgX0pWPt_
X-Proofpoint-ORIG-GUID: UAFWJ_MNspXb3Uvx6TBvRZLXgX0pWPt_



On 4/9/24 19:13, David Sterba wrote:
> On Mon, Apr 08, 2024 at 12:46:18PM +0800, Anand Jain wrote:
>> On 4/6/24 13:18, Qu Wenruo wrote:
>>> [BUG]
>>> All the touched test cases would fail after btrfs-progs commit
>>> 5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when
>>> the ioctl succeeded") due to golden output mismatch.
>>>
>>> [CAUSE]
>>> Although the patch I sent to the mail list doesn't change the output at
>>> all but only a timing change, David uses this patch to unify the output
>>> of "btrfs subvolume create" and "btrfs subvolume snapshot".
>>>
>>> Unfortunately this changes the output and causes mismatch with
>>> golden output.
>>>
>>> [FIX]
>>> Just redirect stdout of "btrfs subvolume snapshot" to $seqres.full.
>>> Any error from "btrfs subvolume" subgroup would lead to error messages
>>> into stderr, and cause golden output mismatch.
>>>
>>> This can be comprehensively greped by
>>> 'grep -IR "Create a" tests/btrfs/*.out' command.
>>>
>>> In fact, we have around 274 "btrfs subvolume snapshot|create" calls in the
>>> existing test cases, meanwhile only around 61 calls are populating
>>> golden output (22 for subvolume creation, and 39 for snapshot creation).
>>>
>>> Thus majority of the snapshot/subvolume creation is not populating
>>> golden output already.
>>>
>>
>> While golden output is better verification method in terms of
>> accuracy, but, it falls short in verifying command exit codes.
>> I personally think the run_btrfs_progs approach is better for
>> 'btrfs subvolume snapshot'. It allows us to verify the command
>> status without relying on the stdout.
>> But, past discussions favored the golden output verification
>> method instead of run_btrfs_progs.
> 
> I thought the whole point here was to depart from the golden output, at
> least in selected cases, and only in btrfs/ subdirectory so it does not
> accidentally break other filesystems' testing.
> 
> What past discussions favored does not seem to satisfy our needs and as
> btrfs-progs are evolving we're hitting random test breakage just because
> some message has changed. The testsuite should verify what matters, ie.
> return code, state of the filesystem etc, not exact command output.
> There's high correlation between output and correctness, yes, but this
> is too fragile.

Agreed. So, why don't we use `_run_btrfs_util_prog subvolume
snapshot`, which makes it consistent with the rest of the test cases,
and also remove the golden output for this command?

Thanks, Anand

