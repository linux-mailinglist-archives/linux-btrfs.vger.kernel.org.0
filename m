Return-Path: <linux-btrfs+bounces-2677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E428618DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EE81F25A55
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59212B168;
	Fri, 23 Feb 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lsQMRbJc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x8RYzU8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439C128834;
	Fri, 23 Feb 2024 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708105; cv=fail; b=snAIwLlg56TO69rqAXtG2VoHdl3vH9LtC7oX92cyEfqDJ60l9irU64ccC9zK6wwtM8xRlfB1GIL6/HYwuSgkf3LEdN+P4+f8RsKRjRkz3L7wluKBf6NypxPsPV/1zdSDkDp2x7dUXKuoIDNv4c+wP63giEiHKwp4jVJwWNonVag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708105; c=relaxed/simple;
	bh=oHiziYgyHo62Zhi1QsNHP/FygFY1kHyZl0RdOHylyuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HwqTZa9aY5cQwvMsL4MVzFmNlaM3Rn8HDyGDtukQw9x6afqcrRR+VQxV75j6jxcteoCkpIfi3Kiv9wwBU5rYLWJBduNQ0HhzF4fKVsXwDT87BoqRaoUGDJ7v+nUF23TDKSjOZVt3RBpTObDx9QezU1ILpMz5KZAYfXRq43oalzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lsQMRbJc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x8RYzU8N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG3x9M002938;
	Fri, 23 Feb 2024 17:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2demkna0gvthCeoKjvGYWvjfCQjisR/wDETEpJsujgU=;
 b=lsQMRbJcE6LmH9vuW2qm6F9RLp5KJ7AdWHS+Zcv2zNHCLUlRjvaRud3PtWMS2D3rTjYl
 IRJcUSMrgD3Ej6Q2Z6B7YptjPTQM+QjKqdrcooqX9Dk437tH3K6dd2Gp6lNG+iS4L6Eo
 OXORqttC6kcB/54dQzXwA9ErEbyJJ5rud1+fBP53plGZgHfVifqe3Zg045NMqfWsHwV+
 0+zOpZ4Nx/PpSFHZIPZTRA/1iQVMU5jEKF5au/gtz8p3RmiUUP65ZCXI661Yj3Cz2LCJ
 /VLPZjQrpDKTVVvv/n4GCqjOn9mpr/XX+EgEQxK26necoAIZlLLuDIiLUM7k/z1L9WGE 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk4888k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:08:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NFucJ1027539;
	Fri, 23 Feb 2024 17:08:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8ce9xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:08:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRoPvSDBdMBXuSIETtSci1wzYk9BHFWmil6s8HTBScRH70HjMoWwPVlZ3ZorE+bEMMOH+XKtNrM3Ioa/Z5Sg7PnfzkVmIGmrRbOmc1+Owiu/Eiimjf+zU1gzfDP1l1HNX/l+NDPBs+isbJZM9GhmooAhMzsgtZr1aOIPt3ocbj0t0Uel/0+BRP9RIpSCimqug6sHuIjeMxRiH5oyB0+ApD3MNy/ic152fY6zfJ3OM2Pk5aaittyJv7+C1ZM78N1/ltlUdBNgk+hupi1/NZHwnk0uKlI6R3N4G141VE37113uiObNu+BrBt+EWGP8pbHa1XkfFVOfg4ho8ybGEol+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2demkna0gvthCeoKjvGYWvjfCQjisR/wDETEpJsujgU=;
 b=Netg8VJEnYORqDRF9SMGht+FXawvtX1s2Lu69h8D0F/SJkAwsId3Vb29daVtBhmwf+bt7Z+ettjn87JDkMwCBtJOpJChVRdTySgLivm4cyN307kVW6WTIRsxDJvLKAfx6TegSesKz5IXI8sB0h5eVbMY3Pq4v+nPaH3M/KxyHzIntoV3JdoGqB4R/4rNfVbYUtU2yw4hsrtDnUsJJkw56FisX3MNsMHZw1UqfyeJiyh8YIf3X5jxPD4LGwGjj/cY8fcqYRNIlr1wpr86d6aKFdd4VHaAiWFAIeNKesbUn1hY0hGqDzG0htq3T9PyIMSSM0vF0xA9d5Z6VnvQ7c6RDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2demkna0gvthCeoKjvGYWvjfCQjisR/wDETEpJsujgU=;
 b=x8RYzU8NhEfkFT1vok1HMg/xSIGydumCPr73QYmapWl8UDekXCMZXJXAclnTlQHR5JGrsA8Ls+o1i4KK+6zQehmlgzdfKQceDqLo3fsGqMk1sO2AQkYJeP8QXfQFJ0A1coOyAZww1r8mw39nOU4vvMTGX32RsnYYgo9ezLFXcGs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7135.namprd10.prod.outlook.com (2603:10b6:208:401::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 17:07:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 17:07:47 +0000
Message-ID: <12c20a26-5632-4c53-a011-7e74a781724b@oracle.com>
Date: Fri, 23 Feb 2024 22:37:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: add a test case to make sure
 inconsitent qgroup won't leak reserved data space
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
References: <20240223093547.150915-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240223093547.150915-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff1a81d-6768-43e4-e5a4-08dc3491f59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0xP7Q5FUVv3x3F12SUI+/1nisrNGfKNOJXkNMHvlvVKtTOSMt77/I25YH2m/TRNvhWnrHOly3TWfkWlwurdF0/lGVMOfypVrScZYzceuVfX3ttPscSpLm3bvp1fwCom+I6rpOBt82R5yvcQjinpJEQASme7JDWhMsreYmsvO9xyUDHZ2thVTF5Ep42ZrdlXE/gANdUVg0d+UE50dP9PwcUEcBGVBuTJrpdUZt7rx90JjgI9WaqUU6kKOQ409byk48qBdzB3xGAA47EHo/N/YATEcKNYeQ2DoZP8n4aiWWg6wAd1oadMRhZUmJRZMTOoLAOTu+Xehwhx62ArsWqI/ZOtlfg9MMpQ9dR3MS0tZmp4Va3I9Hqv2uKiu7d2Vv8b4bh9+qxB80Y3b3vq5UJ56JG1T6HxkwgejuQUfZHdQ627zUWIWvyYkol7YNWQC2MXYbwTku5qir0OVF2iarqeR2VRZH7s79+uUQELeeOw6GXqrcC4l+sK2H7IIeGolPDFBTeiwzyk1EhEavf014NLGPYC3vpmrhOhR7OahLp14K8ZowYtNm4RsjxhYSHjlLvEG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDlmSHdjTjU4NkVRdTNSVGx1TUJDR0hzSGJFd2VjaVRZV3k0REplMml3RHo5?=
 =?utf-8?B?ZzIwQkRabFRhQ2VjUnBjclFrdE9BbU9hV3lEN1A1S0I5ODJsYkc0bytqQ0Z3?=
 =?utf-8?B?ZzRreGlsY3FpOUZuVnpOU2dlQm5INHBFTEhQRXVCQStRcm1iNWZ2dEIrTTJp?=
 =?utf-8?B?Z1IwSEJGazNlVUV2Tlh1QlNxTWMxZDMwbE1qNkJjMkVvY2dMQnhhUjJvV1Nn?=
 =?utf-8?B?eERRUE0vWFVOVUpodjNPcHQ4QlFmZ1lIK0hFM1F3ZThCZ1psNjY1TVNpRVlU?=
 =?utf-8?B?ZUVJWUpSZVIrLzdMKzBoemJ2SnB2RDY2ZDlBN2VTOEJjVXhrcTJHZlN1dnNl?=
 =?utf-8?B?akttK29TSEdUZ1ViWThJTXp3ZnJvT01MOWx0b1YvVCtSLzhFTDk1NnZKUWJ2?=
 =?utf-8?B?dFFqclpnOUw0Q0JlQ1JlaFJNVXExcDh3dThqMytDWTFMaUt1Nk1DMjJNa2tw?=
 =?utf-8?B?VG1Nd3pQZC8yZllIQmZUemdSNmt6ZkZUZjVCeFlRWWF0bnpCakFwTDIyNXlr?=
 =?utf-8?B?V0dYMU56NGlURzJFdjRpdXRBVjdmVytybm1ZVjA0ZmVHSDNkODZSU2ZKQVNL?=
 =?utf-8?B?N0NYS3J5Y0QyRmY2eGlUWkNOZ0c0MDlYVnpYcEg5WkwvVWFnL0Nsd21CNkl6?=
 =?utf-8?B?S21XQlhiRU5IVEU4U1RDbjdEL1FhSGxpcCtaTHlhaWE1ZHRPelFvRUczaHJP?=
 =?utf-8?B?TEpXN1JjYlRDdE9Wd3B4bHpZSE5pbm1oVXNYeDFlai9xODhUTFc5aDZIL0Z5?=
 =?utf-8?B?OG03WEhoRG5lWlBoKzZ6dDNBUUJIbDZNTTVOYXhPMWQ4ZUVEQy9KQ2xTSzFZ?=
 =?utf-8?B?R0FqOGNTaDZzTnV5bjRNRnZXUURDZTg2YlJlNVY1SVk5bnhCTy9mQWVzRVcv?=
 =?utf-8?B?c0oySmhRR2NMa3FRTm5xdko2UXNsNVlKZ01hQTFiaDZzTDlxVTN0QytWMGJp?=
 =?utf-8?B?bE5QMW1GeThwNkV2Z1pPSE5oR2VCWE1EYkxQVmQzNEtia1JPR2hHU1gvNmFv?=
 =?utf-8?B?VHhvM3o1K3RrUmx1cEVIdS9vV1Evb1hFenV1V2JUS1dhSXRNZ0s3MVZncnZi?=
 =?utf-8?B?RUlUMDhwOCtXRC8yVTR6Y1JGSVhkVjBNeENwSERkSWJDOTUwNEhCWGRUWWdV?=
 =?utf-8?B?Rnl3K1Nrb1d0TjFVRnRTOTFrSnJ4YWlXWnZTVEEra1lTV1NXNUxKUDNDM3Rs?=
 =?utf-8?B?eDJ0bUo0Q3c1aks0OGNMY2t1K0s3ejRmU3FaWWF2SmJ6Q1dvVWNnSkc3TlBQ?=
 =?utf-8?B?Z2NVVVNXWmZ2bUJDVExHTDFHdTBUMVFqcFR2V2tjQysvWmNHNU5lZGZXbENU?=
 =?utf-8?B?Vk9pdmJvL1gwVFFQNTcyRElDMnVraEQrWVpER2FkazVHcmNKVmRoNk84MTRP?=
 =?utf-8?B?UkRIU0M5ZWRvbG1oZ1ZOdm9rWTUrWnV6d21TSGRGMEJGYm5xblRna3c3T201?=
 =?utf-8?B?N0llVStuQmN3RExnSnNTNjNBc2pQQ1ZsSjk1L0dnRSsrQzdpQ2RoTjRZWGFk?=
 =?utf-8?B?V2libFlKVU1iZ1FjYWJGemE4VWF6eDFzN1lwMFp6aGpRWHJoamM5elluQm1a?=
 =?utf-8?B?a0ZrVUpHcXFOTlA5b2lYc1lsRHJjR09oamZkMS9VVTVpRko0dkxBUWRXNHRj?=
 =?utf-8?B?bnArZkIwTmN1Y2JyVjJDdWVnL2QzMkJ6QThTR3hSQVNTS3p3bU9XWm1kWjJv?=
 =?utf-8?B?VnZ0d28yUkIwK05UcENhQ2kveGZnbUh5bThoT09kZTNkNTVZWGxXNE1xTkZC?=
 =?utf-8?B?dHYyNzl5elcrL1ZkTFJsbzdEUHlVQkU3VVBkN2JEYjJBY2FrQ0xENDIwTnJ0?=
 =?utf-8?B?dHJhekdWQ3F4MS9aVnY1UjR3YU9UNk50azlEYmhUNnpSZlJ0TEEyTXJlRjg1?=
 =?utf-8?B?YVJ4TDZQeXZkVGNzaTlFOTBHaDQ4NHJzait5akdzYlcwQU1vQUw0aEhFOURP?=
 =?utf-8?B?am05OEVUeXhmMlJoaExYNkdHNzVjd3N5NFhZOEUwUC9LZVBMeXlHQmorT3pH?=
 =?utf-8?B?VDV2TGVIMXF1cjJMbmtvREQ1ZGtTcVlueHl3Z2gxVXp1aVpDTi9CT3YxbG82?=
 =?utf-8?B?dm8wRUtTeXY5cEo5OThRejRoWUs1M09EOFZxaUliUll3ckFUeGZMcmdzeG9C?=
 =?utf-8?Q?2dxEqT5RjiyrKRT2EgVLtloYl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZVazFnmhD2dLUFvHMOr8av5bLUPfxUoNRzP6G+BQiRoz4Sk15ZHV93DlhnbJGk8LfgXkava2TIPVla/MDLjuffqUJqZKBjxbOynpG/4fuex8GZyKcKKg2/UurUrPHuv4pP8qXzqVXrgQaRsmEDCipySu/Je0h1csRH//LQRVcgab+jYEuc8YCinj+qBsWYCT3gTLJp3OOokRi+3dNeU1RkAhCexVbRJbS25qj399AGMnMhCta1pMxFRRO8s7fzlJpDoJa8brFLfa1LeYRuFxg2STuz6P6yl1XuRjsBcdN5y/jJ2sdB4ySeNqasozTFAq8mi0Zu7kJpuNhEmE4FlzVyPIKeCHcYvhz40/0iE4f3bBP87D2dyuoimAmhEOU6ytIcxpCvydr9GJ3Vor5tW0vXcafV4vnP0H2CvfrYAo4E/3tUO2peKJBLkBhZGd2u3EaLEUum1Tp9bwQfrnC8r5TeNWDtus7EjwwoszjHlisjE9JM34775zcK9Am5tBFNeeJAnNo47OhNuioeUvGsJvofPK5bK0I35U1Nb3aeD24cAM1NCx+eCJ5xdJIlVAtDADt8T5P4ToMHgqpwG4+wUthF7nH+NCXbGR/ct/MHSxZFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff1a81d-6768-43e4-e5a4-08dc3491f59e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 17:07:47.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WN/31Tvz64V8XPqIbddc7FNeP0tz6rtZWXJJs1FNz3EnEuKi2/S4FJZZ2sC3aHWDTgpI4wBlfvWkuUIhDHBWFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230125
X-Proofpoint-ORIG-GUID: 4vnsT__yIb73TMhSfUNavmb_KGjp5Klr
X-Proofpoint-GUID: 4vnsT__yIb73TMhSfUNavmb_KGjp5Klr

On 2/23/24 15:05, Qu Wenruo wrote:
> There is a kernel regression caused by commit e15e9f43c7ca ("btrfs:
> introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup
> accounting"), where if qgroup is inconsistent (not that hard to trigger)
> btrfs would leak its qgroup data reserved space, and cause a warning at
> unmount time.
> 
> The test case would verify the behavior by:
> 
> - Enable qgroup first
> 
> - Intentionally mark qgroup inconsistent
>    This is done by taking a snapshot and assign it to a higher level
>    qgroup, meanwhile the source has no higher level qgroup.
> 
> - Trigger a large enough write to cause qgroup data space leak
> 
> - Unmount and check the dmesg for the qgroup rsv leak warning
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Queued for the upcoming pull request.

Thanks, Anand

> ---
>   tests/btrfs/303     | 59 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/303.out |  2 ++
>   2 files changed, 61 insertions(+)
>   create mode 100755 tests/btrfs/303
>   create mode 100644 tests/btrfs/303.out
> ---
> Changelog:
> v2:
> - Fix various spelling errors
> 
> - Remove a copied _fixed_by_kernel_commit line
>    Which was used to align the number of 'x', but forgot to remove
> 
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> new file mode 100755
> index 00000000..9f7605ab
> --- /dev/null
> +++ b/tests/btrfs/303
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 303
> +#
> +# Make sure btrfs qgroup won't leak its reserved data space if qgroup is
> +# marked inconsistent.
> +#
> +# This exercises a regression introduced in v6.1 kernel by the following commit:
> +#
> +# e15e9f43c7ca ("btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +_supported_fs btrfs
> +_require_scratch
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: qgroup: always free reserved space for extent records"
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full
> +
> +# This would mark qgroup inconsistent, as the snapshot belongs to a different
> +# higher level qgroup, we have to do full rescan on both source and snapshot.
> +# This can be very slow for large subvolumes, so btrfs only marks qgroup
> +# inconsistent and let users to determine when to do a full rescan
> +$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/subv1 $SCRATCH_MNT/snap1 >> $seqres.full
> +
> +# This write would lead to a qgroup extent record holding the reserved 128K.
> +# And for unpatched kernels, the reserved space would not be freed properly
> +# due to qgroup is inconsistent.
> +_pwrite_byte 0xcd 0 128K $SCRATCH_MNT/foobar >> $seqres.full
> +
> +# The qgroup leak detection is only triggered at unmount time.
> +_scratch_unmount
> +
> +# Check the dmesg warning for data rsv leak.
> +#
> +# If CONFIG_BTRFS_DEBUG is enabled, we would have a kernel warning with
> +# backtrace, but for release builds, it's just a warning line.
> +# So here we manually check the warning message.
> +if _dmesg_since_test_start | grep -q "leak"; then
> +	_fail "qgroup data reserved space leaked"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> new file mode 100644
> index 00000000..d48808e6
> --- /dev/null
> +++ b/tests/btrfs/303.out
> @@ -0,0 +1,2 @@
> +QA output created by 303
> +Silence is golden


