Return-Path: <linux-btrfs+bounces-4017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2926889B6FB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 06:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1EFB1C20DC1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 04:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA96FBF;
	Mon,  8 Apr 2024 04:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UBrwHGvk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WSwr9zCZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395882564;
	Mon,  8 Apr 2024 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712551592; cv=fail; b=gWvUo8su9mdBJ9C5w/ZyONCWKAiq7o77RgFJxdkiQ0CjJeKKk7mlzpTVRQkMRpJWNUhieLTLsmjt3WPfixxi5kQ8uNuljG9m+NGHD6mB+yg3k4l/Ehy8gOeOPjFKIELi7opUA/McvBlLUZlJ7tYxLFMjxlAg1VFoXcCnfdxydW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712551592; c=relaxed/simple;
	bh=TviVnWC4NZALE6uL4GGBwwq7jkF9nb0g1sgMk8LZxRY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dWDLoIX0XB5OT62xal+OU/lO+dTDy3V04nGF1IFXNa5CGHCw6SRBCqOT+0mJi0hwXki/r4+Tghwd6D4xgqkn3h6h/fhQvv4SOw4zRfxtMY/DTSAvhhj5jrH5lRDnrbYBtMEht1iP3bwpGGsvBTQrLA9NjSGuwXYJw7SWg7d3jsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UBrwHGvk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WSwr9zCZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4380hskB029488;
	Mon, 8 Apr 2024 04:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iqVG2bvcDphkmlP29wXovTw3DWGZPod8VlnD/4/OMuI=;
 b=UBrwHGvkNSXIZZDpySN6Vzb8C32ea1MfFQ5yflM4VQx4bZQm2d/a/4BHH9gJFsmxDwzE
 cTvsqagFRptYldY4eVvC/epAHK7Ba6Q3gwYZoVT3cgLtgh62GaNSkQLm7n5fCp4J+wEO
 0m8zuCp3glij9BGov8mr68exXjMwKDu/LTsejgojYuLCBmaHbX/YK2F7eyTtV+IchW3K
 Ti4XggwIvCt+4TydAvqiF0uY5Od2p3pStHarxpIztv02V1FKRZfBnKrQExRkvpnmeOXp
 EJjkDycoFS/N4tpl0EhktD6sS/hg+Z1AnxxNpb7s1PdcP0Fbs+P/dgTzzny3aNG3Ptc7 aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedhpkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 04:46:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43835YT0017907;
	Mon, 8 Apr 2024 04:46:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuay4rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 04:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoElkO2t/kI1dCS0cyFIAMx60MKS+AT1uJ6jnIjZNP59gIiAXql8i3jSiM8vpcxZFH0eYoG8ZNFIvUpMIZlFITUWBlp6UR4NimwDBcEnLZnRPJa/7sds2MNBsKRdqmNmPsxg8yzXMAnHtXLUP3LGOvMsXhmTr47KoD8BUBT23FM9c5KCA7W+HKqSNjWXiuN6xDasR+XCEn/y+VLFj2vYzHdsZNAR0FtFaVX1GK4uaGTj1ZqSAu9n8hgkVUg1qRgaUQJAQBI1sNvVE2mmYpKRXkmrwe9Nhbz4Div718/GMxbXi9ash2dDtwtckhlBPpKuP3Xcq5k0ndoL1p7sZ3jREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqVG2bvcDphkmlP29wXovTw3DWGZPod8VlnD/4/OMuI=;
 b=ZQIOxdXKEeZyQuiKwmoS21REA3k9A6jxDu5NUn6rRR//LMew6jJ8I3Yenxq2tgqz8+TKJ2I21cWDwng25VYZoMhUcGtzOxSpvac2AtmyY4i82j+66oAh3Pn0j4OueQwcWlRWtyNywOkuatsIpEtHPaip4/8ra+IyR7X6GuG4dqR5FC+1wDyDo0yfmfj+zknuoOq385CRv72+Xv1z3N20gOKgVFtzcVu1ZHVoIWt+753vtryoDcMQ02Rnd49WtbZYZ5HmNbkckoA2Kr7zuBtVViFHG9nAAl93Fh7EMaJuyhFB4B0NqhE4bOMrDPCFGh4cqXvJl/a5wfkXu9q43Pk4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqVG2bvcDphkmlP29wXovTw3DWGZPod8VlnD/4/OMuI=;
 b=WSwr9zCZkj/KKnFlIDbPe8iJgHtArgIvS0a7L/kLNnRtgmddCLIE40dhnUulFQPhE4MoAVP3FjurnBseQ2t3ZF61ME9sbx8zJpQPXLL2yDA6LrWoMK+zlCVcHqfubxaPi0ByajsnWpPrmsD0TA+SthMWXeflJzF8yK71IjGmieo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5705.namprd10.prod.outlook.com (2603:10b6:510:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 04:46:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 04:46:24 +0000
Message-ID: <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
Date: Mon, 8 Apr 2024 12:46:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20240406051847.75347-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240406051847.75347-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5705:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Dpcdfu2mWOU+8iPgkw9SITds2FkADta0Ml3xsP/IAEaRbY/qgjrAwOd2Q8PrycyYzC6jAtzRI1GERI6dfCsjFKZF87YkQcJmB7p2M7dJ/bkqoQlztNGUDunmGO+x32s5MLJze5GuYeKzGnFXfogxsavOfW1ESTw/ZUZjDnbfM0Z3b4tJqDVPRW62eMlLfe2TYiok0i7QzMQphQFSeU9ud36iqJ/tcvg19/5ASeZPfFAfQV6YgrVuWAhegB1XLX1cjsUkKYyNnDVE6jbAjyezA0QVtWvHtb/9rKwGnAE/tF80+ToTiPe9Ur6J03JMrS4Gi4TUE0ZJebW40lYMEMb4uWXpWySXQ3XGnKbZlTUPko4yY25cpYf1IsW4cLE79hKO98DYI/+ZcBsxrIRrnEcjlCwn0O1so1br2QFlwbhYodeKsMnmnv6gOhWcA+phNCSiSgNFEnYBG515PrOYmf0B+CJ63pS6HorVhTYtOsL7bAFo7Pbio/7swS+98pUj9gw9UsuXvlOzm6AgMNtBCiAy+Bi5UV26zsVuPmnlth10bdkmSx8uGCB30u5wWVv413n6S3ohPNuz2r6S1biNk1EmZv4JdFW/d5Cz6KxYojwZ2xeTO2Zh2QzC7ygj0z4nts2/WH64z0lklqHtDjhM2Kj0Y1y9HEwbeJjFNmBSEEaog7k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzlMVkxaTU5iRjdCRDhONmNmYkpsNTZtZC9qZ0c4dDNKVlFjYUZlZ0pkVU82?=
 =?utf-8?B?anBRU0RBVXZ6dEZWalE5YlNoRng0UTVCcVJQTEw5Uko0cHBGeS9aWjhQckl4?=
 =?utf-8?B?OFQzWE1WRTM2UmVrSk5nWm9vcU51b2Vzb3kzdk1KUEJkdzNUb0pmc0R4RnZu?=
 =?utf-8?B?NlZTdkxuU05jUDNhaW82RDg4elFpNjR4L1Z3Q3BSTTIzRFdYOTNqQkR2eERX?=
 =?utf-8?B?SWhTdXhGeHZPSnIyVUY0dkQ4bFhWQnpWUVpXczh4VjYxWDMzcHJCeUp6YjRC?=
 =?utf-8?B?OWJFemI4bjFtTC84Q0kvMXBEOGt1d2JhVzlOdzFGZDQxTFFIU3JBOHFTNmdw?=
 =?utf-8?B?OGQ0UTQ4T0E4c045RHVTSlQzdzcxaXl3eXlGVUV5V3ozUDRJSlFiL25PUkpk?=
 =?utf-8?B?cHMrZ2c5ZCtoV3pjVmFOU09waC80eVlVVWNITkxrWEYrY05qWjV3bmtMV01L?=
 =?utf-8?B?bXBKcUlOZ1dHTlBzQUt5TktGd3N4aFpYOGJSUkhCeEg1dGwrQlF0dHhGbm90?=
 =?utf-8?B?ZTRWSG52UzFVaGlnNXEzNWNGZkNYMVhIKy9ZY2JUQUp1RTNGR2kvcHVNbjlt?=
 =?utf-8?B?TUFwQnBpR1lMdjlGQXprUjBtWGNqZHArQVMvdkprbVl0V2ZvU2w0TUdDSkJZ?=
 =?utf-8?B?Y1JWUStLT3h5d1pZalcyTXNKS1AyQ0dOUHNsMzA1OFNraUtoR1FSN2lieTFQ?=
 =?utf-8?B?MlYrUTJVSFV5Z3hPQUZuMVNhK1dWVnY3V3FidzN1S1dMZ3crbE51NUpUZk14?=
 =?utf-8?B?QmFFcStnNy9rQWRpK0s3alhVaXd3S2trNGM3dUZnUWNEUWk5OXVsVi8yZURs?=
 =?utf-8?B?YWJHc2dqTjVHSlZpejZGakVEeG5vc2oxaHRqUEdMU3hDRk5rUWU5Nlpid3FV?=
 =?utf-8?B?OCs5dGh3WCs5bm1vZk9PbzFabEZycmtUOFRQUitHcWQ2aHpvaTROTUoydlA5?=
 =?utf-8?B?N1p5MGNNaEJkZUN4K1ZXdGdqNmxyR0oyWlBPa3F1TnRiaWZmWWpZTGV3NUtY?=
 =?utf-8?B?ZGJickh2UTF5SnV6dUZ5MzF5Nnh3YTZWWEtEdTdWdUhBRmtGd2xLc01vYTVC?=
 =?utf-8?B?S3VFSnpBcUprUEVZSmJaOVNoT3R3MGdXMGFnL2JnREFIaTBKdkl6aXdwaHM2?=
 =?utf-8?B?RVdwbkZ0L2dyY3ZqZkJMc1cyNzN6bEloNkpHQUpuQlczK0k4YU9uR1M2VlZO?=
 =?utf-8?B?MkFVRTNkb3pRZUNwWWw0aG5TMkhlOUdLK3JydTE0V2VvS1p0ZW1hdW5rWkJj?=
 =?utf-8?B?TDB0Q0tzV1Q0YUNVK3NsdHNyODR6RWNybFh2SFNpTkcvZUUvaUo1VHhXbTJ0?=
 =?utf-8?B?V0RJVTRwbGV0VTVpTlNJNXVYajh6Y3VIbVNXSmlSemVOVDNwVmFsRkRlRXdK?=
 =?utf-8?B?Skp0aCtPYlhDMklPUHFrQk5YRjFjZ2JSeDFyZ09QRm1uNS9nWVJyYUlRSUg5?=
 =?utf-8?B?ZmJVeXZEc3VVbGt2YitJd0J5RWJKYUZuNTBTdkx5N0J6QStWUGQ1ZlM3ejA3?=
 =?utf-8?B?U05RSmxCZ1hxdXdmenJvTGxHZjBYUUU2R095a1JFenFjZW9ucjRYSlhpaURT?=
 =?utf-8?B?cmQwTHp4NWxsYURHZUVhc29iQnhJK2cvNjZhdklLK0lXL3BsdnBrcityMnNh?=
 =?utf-8?B?SzZPWEdtYjhKS2pOZ2xTYzZjdE8zZW0rVlhrN0RPNG5ic3ovMEZjVjVDNFlK?=
 =?utf-8?B?aGVjcFJXbDhJYzNRVnl3ZDk5S21BNWRLYnJGNUN5QmZabGhvZCs3eDZoSHZC?=
 =?utf-8?B?RURINjRvaks5L3dPQzdCZXpDUzZTS3pwQjhVcDhGd2V2WlFHUjVaSzVIcTZ2?=
 =?utf-8?B?T09FdGpNc1pyVkVQaytZajNHSlN2VHJkZTBMT2tpNm85R3pZNEdVSUdvOFVL?=
 =?utf-8?B?U09jMStBMm16SWZLYW85TU13bmoxUStnR1BrWFRocW1WQ2prNFlETnJueGhn?=
 =?utf-8?B?cU9EZVp5T2FVUUZHOE9pQkZQajhBMldPR2ZyQTJNRXROWUpEaHA1ZmlwRklG?=
 =?utf-8?B?TkdCcThaalpMa2Z1Q0tDK0IyZ2xRVTZqVXg1THZrTkp0V2JublhFbmNIZDRL?=
 =?utf-8?B?SnpjNERtSWdsR2hPNWFhK2Nudzg0K3lOdE04MmxVSXFrQ2Z4UWl0VTRjTlFr?=
 =?utf-8?Q?kAW+He/kssB8s+Vjz0zvaJUje?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MBOGBr1Sr1h5fGc0cDG1MG+9oFjuTgQ4ZvXvlauAGewXHTNO92MuA3I6vWx6/9duIW+RnEmK+CTWCkR4Up/7QjlpjNEibzsFjcFJYs+cfA5LIQgGsoC0roJG94XseNIhRcoU96ze3RuXkGxYqXafSjH9piB69Tiiq6VvXl8aMKPz1ZcaPpzf4SlGSoHHkQVTRXYg0TGrfn44QXp7TnRuGjN6Fhty0zFV2ZEq6UuCW8oiLZ0cejOBw3lUtImbr/GpHYS25YPXDpcyqoHX15mNdsEkLC/JFv5nL21zZAqJs3Gro4WZOZXSaYMLQtJNAGoUaUd+ANt3ynkzhl1wKUN+1OhXvjShYmetYcjRS++eoqb8w4izbAnzkCUrM/cVGImSNg51mxrzxw4PlDjQ2BZ9YLfZExwz2Uaijgo6LmMZrS17XWLPPCsZblmnugHDzdoNwzmYpGFwGpnQCbBF6Is+kOs1bsNRt5Rwaz1gV9DJrZQh/3G2ayA73D28qSmmtQcqIko4qpTXdDYKKmNDTMdtUJfYrMrPxCI6W9L261AjKCf4u+9ndtsqqgJJnI/kifrf5GZ7kW32y86XeFanCuNtbWHkhkKvepaEJapBNlOc2XM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898615b9-8c99-4b30-2daa-08dc5786d7c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 04:46:23.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQNEdjFkjrqBm00lyskuElf0IimyHnwnUP44YIZ2uhV6jvPkCIpFFhVjizU3EICKoYje7FbQ+JnNiL9v4Kduew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_03,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080035
X-Proofpoint-GUID: HGw3g_6ZltZzmpZNCOfGdVxp8AOcuFt8
X-Proofpoint-ORIG-GUID: HGw3g_6ZltZzmpZNCOfGdVxp8AOcuFt8

On 4/6/24 13:18, Qu Wenruo wrote:
> [BUG]
> All the touched test cases would fail after btrfs-progs commit
> 5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when
> the ioctl succeeded") due to golden output mismatch.
> 
> [CAUSE]
> Although the patch I sent to the mail list doesn't change the output at
> all but only a timing change, David uses this patch to unify the output
> of "btrfs subvolume create" and "btrfs subvolume snapshot".
> 
> Unfortunately this changes the output and causes mismatch with
> golden output.
> 
> [FIX]
> Just redirect stdout of "btrfs subvolume snapshot" to $seqres.full.
> Any error from "btrfs subvolume" subgroup would lead to error messages
> into stderr, and cause golden output mismatch.
> 
> This can be comprehensively greped by
> 'grep -IR "Create a" tests/btrfs/*.out' command.
> 
> In fact, we have around 274 "btrfs subvolume snapshot|create" calls in the
> existing test cases, meanwhile only around 61 calls are populating
> golden output (22 for subvolume creation, and 39 for snapshot creation).
> 
> Thus majority of the snapshot/subvolume creation is not populating
> golden output already.
> 

While golden output is better verification method in terms of
accuracy, but, it falls short in verifying command exit codes.
I personally think the run_btrfs_progs approach is better for
'btrfs subvolume snapshot'. It allows us to verify the command
status without relying on the stdout.
But, past discussions favored the golden output verification
method instead of run_btrfs_progs.

Thanks, Anand


> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This is just a quick fix for the test failures, if accepted, further
> cleanup would be done for unnecessary golden output for "btrfs
> subvolume" subgroup.
> 
> v2:
> - Revert the change of btrfs/208.out
>    That was part of the later cleanup, wrongly included in the fix.
> ---


>   tests/btrfs/001     | 2 +-
>   tests/btrfs/001.out | 1 -
>   tests/btrfs/152     | 6 +++---
>   tests/btrfs/152.out | 2 --
>   tests/btrfs/168     | 4 ++--
>   tests/btrfs/168.out | 2 --
>   tests/btrfs/169     | 6 +++---
>   tests/btrfs/169.out | 2 --
>   tests/btrfs/170     | 3 +--
>   tests/btrfs/170.out | 1 -
>   tests/btrfs/187     | 5 +++--
>   tests/btrfs/187.out | 3 +--
>   tests/btrfs/188     | 6 +++---
>   tests/btrfs/188.out | 2 --
>   tests/btrfs/189     | 9 +++++----
>   tests/btrfs/189.out | 2 --
>   tests/btrfs/191     | 4 ++--
>   tests/btrfs/191.out | 2 --
>   tests/btrfs/200     | 8 ++++----
>   tests/btrfs/200.out | 2 --
>   tests/btrfs/202     | 2 +-
>   tests/btrfs/202.out | 1 -
>   tests/btrfs/203     | 8 ++++----
>   tests/btrfs/203.out | 2 --
>   tests/btrfs/226     | 2 +-
>   tests/btrfs/226.out | 1 -
>   tests/btrfs/276     | 2 +-
>   tests/btrfs/276.out | 1 -
>   tests/btrfs/280     | 3 ++-
>   tests/btrfs/280.out | 1 -
>   tests/btrfs/281     | 2 +-
>   tests/btrfs/281.out | 1 -
>   tests/btrfs/283     | 2 +-
>   tests/btrfs/283.out | 1 -
>   tests/btrfs/287     | 4 ++--
>   tests/btrfs/287.out | 2 --
>   tests/btrfs/293     | 6 ++++--
>   tests/btrfs/293.out | 2 --
>   tests/btrfs/300     | 2 +-
>   tests/btrfs/300.out | 1 -
>   tests/btrfs/302     | 2 +-
>   tests/btrfs/302.out | 1 -
>   tests/btrfs/314     | 2 +-
>   tests/btrfs/314.out | 2 --
>   44 files changed, 48 insertions(+), 77 deletions(-)
> 
> diff --git a/tests/btrfs/001 b/tests/btrfs/001
> index 6c263999..7d79c454 100755
> --- a/tests/btrfs/001
> +++ b/tests/btrfs/001
> @@ -26,7 +26,7 @@ dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 &> /dev/null
>   echo "List root dir"
>   ls $SCRATCH_MNT
>   echo "Creating snapshot of root dir"
> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap >> $seqres.full
>   echo "List root dir after snapshot"
>   ls $SCRATCH_MNT
>   echo "List snapshot dir"
> diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
> index c782bde9..9b493fab 100644
> --- a/tests/btrfs/001.out
> +++ b/tests/btrfs/001.out
> @@ -3,7 +3,6 @@ Creating file foo in root dir
>   List root dir
>   foo
>   Creating snapshot of root dir
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   List root dir after snapshot
>   foo
>   snap
> diff --git a/tests/btrfs/152 b/tests/btrfs/152
> index 75f576c3..d26cd77a 100755
> --- a/tests/btrfs/152
> +++ b/tests/btrfs/152
> @@ -32,12 +32,12 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
>   
>   # Create base snapshots and send them
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
> -	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
> +	$SCRATCH_MNT/subvol1/.snapshots/1 >> $seqres.full
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
> -	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
> +	$SCRATCH_MNT/subvol2/.snapshots/1 >> $seqres.full
>   for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
>   	$BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> /dev/null | \
> -		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
> +		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} >> $seqres.full
>   done
>   
>   # Now do 10 loops of concurrent incremental send/receives
> diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
> index a95bb579..33dd36e8 100644
> --- a/tests/btrfs/152.out
> +++ b/tests/btrfs/152.out
> @@ -5,8 +5,6 @@ Create subvolume 'SCRATCH_MNT/recv1_1'
>   Create subvolume 'SCRATCH_MNT/recv1_2'
>   Create subvolume 'SCRATCH_MNT/recv2_1'
>   Create subvolume 'SCRATCH_MNT/recv2_2'
> -Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/subvol1/.snapshots/1'
> -Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/subvol2/.snapshots/1'
>   At subvol 1
>   At subvol 1
>   At subvol 1
> diff --git a/tests/btrfs/168 b/tests/btrfs/168
> index acc58b51..97d00ba9 100755
> --- a/tests/btrfs/168
> +++ b/tests/btrfs/168
> @@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro false
>   # Create a snapshot of the subvolume, to be used later as the parent snapshot
>   # for an incremental send operation.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap1 \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   # First do a full send of this snapshot.
>   $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
> @@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" $SCRATCH_MNT/sv1/baz >>$seqres.full
>   # Create a second snapshot of the subvolume, to be used later as the send
>   # snapshot of an incremental send operation.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap2 \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   # Temporarily turn the second snapshot to read-write mode and then open a file
>   # descriptor on its foo file.
> diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
> index 6cfce8cd..f7eca2d7 100644
> --- a/tests/btrfs/168.out
> +++ b/tests/btrfs/168.out
> @@ -1,9 +1,7 @@
>   QA output created by 168
>   Create subvolume 'SCRATCH_MNT/sv1'
>   At subvol SCRATCH_MNT/sv1
> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
>   At subvol SCRATCH_MNT/snap1
> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
>   At subvol SCRATCH_MNT/snap2
>   At subvol sv1
>   OK
> diff --git a/tests/btrfs/169 b/tests/btrfs/169
> index 009fdaee..c215f281 100755
> --- a/tests/btrfs/169
> +++ b/tests/btrfs/169
> @@ -43,8 +43,8 @@ $XFS_IO_PROG -f -c "falloc -k 0 4M" \
>   	     -c "pwrite -S 0xea 0 1M" \
>   	     $SCRATCH_MNT/foobar | _filter_xfs_io
>   
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
> +	>> $seqres.full
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
>       | _filter_scratch
>   
> @@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
>   $XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
>   
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 2>&1 \
> -	| _filter_scratch
> +	>> $seqres.full
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
>   		 $SCRATCH_MNT/snap2 2>&1 | _filter_scratch
>   
> diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
> index ba77bf0a..a6df713a 100644
> --- a/tests/btrfs/169.out
> +++ b/tests/btrfs/169.out
> @@ -1,9 +1,7 @@
>   QA output created by 169
>   wrote 1048576/1048576 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>   At subvol SCRATCH_MNT/snap1
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>   At subvol SCRATCH_MNT/snap2
>   File digest in the original filesystem:
>   d31659e82e87798acd4669a1e0a19d4f  SCRATCH_MNT/snap2/foobar
> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> index ab105d36..29a15162 100755
> --- a/tests/btrfs/170
> +++ b/tests/btrfs/170
> @@ -45,8 +45,7 @@ echo "File digest after write:"
>   md5sum $SCRATCH_MNT/foobar | _filter_scratch
>   
>   # Create a snapshot of the subvolume where our file is.
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap 2>&1 >> $seqres.full
>   
>   # Cleanly unmount the filesystem.
>   _scratch_unmount
> diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
> index 4c5fd87a..8ad959f3 100644
> --- a/tests/btrfs/170.out
> +++ b/tests/btrfs/170.out
> @@ -3,6 +3,5 @@ wrote 131072/131072 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   File digest after write:
>   85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   File digest after mounting the filesystem again:
>   85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
> diff --git a/tests/btrfs/187 b/tests/btrfs/187
> index d3cf05a1..86c411b6 100755
> --- a/tests/btrfs/187
> +++ b/tests/btrfs/187
> @@ -152,7 +152,7 @@ done
>   wait ${create_pids[@]}
>   
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   # Add some more files, so that that are substantial differences between the
>   # two test snapshots used for an incremental send later.
> @@ -184,7 +184,7 @@ done
>   wait ${setxattr_pids[@]}
>   
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   full_send_loop 5 &
>   full_send_pid=$!
> @@ -221,5 +221,6 @@ wait $balance_pid
>   #
>   _dmesg_since_test_start | grep -E -e '\bBTRFS error \(device .*?\):'
>   
> +echo "Silence is golden"
>   status=0
>   exit
> diff --git a/tests/btrfs/187.out b/tests/btrfs/187.out
> index ab522cfe..331a07c6 100644
> --- a/tests/btrfs/187.out
> +++ b/tests/btrfs/187.out
> @@ -1,3 +1,2 @@
>   QA output created by 187
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
> +Silence is golden
> diff --git a/tests/btrfs/188 b/tests/btrfs/188
> index fcaf84b1..1578095a 100755
> --- a/tests/btrfs/188
> +++ b/tests/btrfs/188
> @@ -44,8 +44,8 @@ _scratch_mount
>   $XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K" $SCRATCH_MNT/foobar | _filter_xfs_io
>   $XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
>   
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base \
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>   	| _filter_scratch
> @@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>   $XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
>   
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>   	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
> index 260988e6..99eb3133 100644
> --- a/tests/btrfs/188.out
> +++ b/tests/btrfs/188.out
> @@ -1,9 +1,7 @@
>   QA output created by 188
>   wrote 512000/512000 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>   At subvol SCRATCH_MNT/base
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>   At subvol SCRATCH_MNT/incr
>   File digest in the original filesystem:
>   816df6f64deba63b029ca19d880ee10a  SCRATCH_MNT/incr/foobar
> diff --git a/tests/btrfs/189 b/tests/btrfs/189
> index ec6e56fa..618de266 100755
> --- a/tests/btrfs/189
> +++ b/tests/btrfs/189
> @@ -45,8 +45,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0xc7 0 2M" $SCRATCH_MNT/bar | _filter_xfs_io
>   $XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M" $SCRATCH_MNT/baz | _filter_xfs_io
>   $XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo | _filter_xfs_io
>   
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base \
> +	>> $seqres.full
> +
>   
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>   	| _filter_scratch
> @@ -70,8 +71,8 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1600K 0 128K" $SCRATCH_MNT/zoo \
>   # operations.
>   $XFS_IO_PROG -c "truncate 710K" $SCRATCH_MNT/bar
>   
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr \
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>   	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
> index 79c70b03..b4984d37 100644
> --- a/tests/btrfs/189.out
> +++ b/tests/btrfs/189.out
> @@ -7,13 +7,11 @@ wrote 2097152/2097152 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 2097152/2097152 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>   At subvol SCRATCH_MNT/base
>   linked 131072/131072 bytes at offset 655360
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   linked 131072/131072 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>   At subvol SCRATCH_MNT/incr
>   At subvol base
>   At snapshot incr
> diff --git a/tests/btrfs/191 b/tests/btrfs/191
> index 3c565d0a..c01abb5a 100755
> --- a/tests/btrfs/191
> +++ b/tests/btrfs/191
> @@ -44,7 +44,7 @@ $XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K" $SCRATCH_MNT/foo | _filter_xfs_io
>   
>   # Create the base snapshot and the parent send stream from it.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1 \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1 2>&1 \
>   	| _filter_scratch
> @@ -55,7 +55,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M" $SCRATCH_MNT/bar | _filter_xfs_io
>   # Create the second snapshot, used for the incremental send, before doing the
>   # file deduplication.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2 \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   # Now before creating the incremental send stream:
>   #
> diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
> index 4269803c..471c05da 100644
> --- a/tests/btrfs/191.out
> +++ b/tests/btrfs/191.out
> @@ -3,11 +3,9 @@ wrote 524288/524288 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 524288/524288 bytes at offset 524288
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
>   At subvol SCRATCH_MNT/mysnap1
>   wrote 1048576/1048576 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
>   deduped 524288/524288 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   deduped 524288/524288 bytes at offset 524288
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> index 5ce3775f..520e7f21 100755
> --- a/tests/btrfs/200
> +++ b/tests/btrfs/200
> @@ -51,8 +51,8 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
>   $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
>   	| _filter_xfs_io
>   
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base \
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>   	| _filter_scratch
> @@ -63,8 +63,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>   $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
>   	| _filter_xfs_io
>   
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr \
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>   	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> index 3eec567e..306d9b24 100644
> --- a/tests/btrfs/200.out
> +++ b/tests/btrfs/200.out
> @@ -5,11 +5,9 @@ linked 65536/65536 bytes at offset 65536
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>   At subvol SCRATCH_MNT/base
>   linked 65536/65536 bytes at offset 65536
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>   At subvol SCRATCH_MNT/incr
>   At subvol base
>   At snapshot incr
> diff --git a/tests/btrfs/202 b/tests/btrfs/202
> index 5f0429f1..1c8c5647 100755
> --- a/tests/btrfs/202
> +++ b/tests/btrfs/202
> @@ -28,7 +28,7 @@ _scratch_mount
>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
>   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   # Need the dummy entry created so that we get the invalid removal when we rmdir
>   ls $SCRATCH_MNT/c/b
> diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
> index 7f33d49f..28d52e3f 100644
> --- a/tests/btrfs/202.out
> +++ b/tests/btrfs/202.out
> @@ -1,4 +1,3 @@
>   QA output created by 202
>   Create subvolume 'SCRATCH_MNT/a'
>   Create subvolume 'SCRATCH_MNT/a/b'
> -Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
> diff --git a/tests/btrfs/203 b/tests/btrfs/203
> index e506118e..e4ec533f 100755
> --- a/tests/btrfs/203
> +++ b/tests/btrfs/203
> @@ -43,8 +43,8 @@ _scratch_mount
>   # file in the parent snapshot.
>   $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar | _filter_xfs_io
>   
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base \
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>   	| _filter_scratch
> @@ -69,8 +69,8 @@ $XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
>   	     -c "reflink $SCRATCH_MNT/foobar 448K 192K 192K" \
>   	     $SCRATCH_MNT/foobar | _filter_xfs_io
>   
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
> -	| _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr \
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
>   		 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
> index 58739a98..67ec1bd7 100644
> --- a/tests/btrfs/203.out
> +++ b/tests/btrfs/203.out
> @@ -1,7 +1,6 @@
>   QA output created by 203
>   wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>   At subvol SCRATCH_MNT/base
>   wrote 65536/65536 bytes at offset 524288
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -15,7 +14,6 @@ wrote 65536/65536 bytes at offset 786432
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   linked 196608/196608 bytes at offset 196608
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>   At subvol SCRATCH_MNT/incr
>   File foobar digest in the original filesystem:
>   2b76b23b62fdbbbcae1ee37eec84fd7d
> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> index 7034fcc7..017ff479 100755
> --- a/tests/btrfs/226
> +++ b/tests/btrfs/226
> @@ -51,7 +51,7 @@ $XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
>   	     $SCRATCH_MNT/f2 | _filter_xfs_io
>   
>   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
> -    | _filter_scratch
> +	>> $seqres.full
>   
>   # Write into the range of the first extent so that that range no longer has a
>   # shared extent.
> diff --git a/tests/btrfs/226.out b/tests/btrfs/226.out
> index c63982b0..815217ac 100644
> --- a/tests/btrfs/226.out
> +++ b/tests/btrfs/226.out
> @@ -13,7 +13,6 @@ wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 65536
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   pwrite: Resource temporarily unavailable
> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> index f15f2082..b484d20e 100755
> --- a/tests/btrfs/276
> +++ b/tests/btrfs/276
> @@ -105,7 +105,7 @@ sync
>   echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
>   
>   # Creating a snapshot.
> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap >> $seqres.full
>   
>   # We have a snapshot, so now all extents should be reported as shared.
>   echo "Number of shared extents in the whole file: $(count_shared_extents)"
> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
> index 352e06b4..e30ca188 100644
> --- a/tests/btrfs/276.out
> +++ b/tests/btrfs/276.out
> @@ -1,6 +1,5 @@
>   QA output created by 276
>   Number of non-shared extents in the whole file: 2000
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   Number of shared extents in the whole file: 2000
>   wrote 65536/65536 bytes at offset 524288
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/280 b/tests/btrfs/280
> index fc049adb..41d3caa7 100755
> --- a/tests/btrfs/280
> +++ b/tests/btrfs/280
> @@ -37,7 +37,8 @@ _scratch_mount -o compress
>   $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
>   
>   # Create a RW snapshot of the default subvolume.
> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
> +	>> $seqres.full
>   
>   echo
>   echo "File foo fiemap before COWing extent:"
> diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
> index 5371f3b0..c5ecf688 100644
> --- a/tests/btrfs/280.out
> +++ b/tests/btrfs/280.out
> @@ -1,7 +1,6 @@
>   QA output created by 280
>   wrote 134217728/134217728 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   
>   File foo fiemap before COWing extent:
>   
> diff --git a/tests/btrfs/281 b/tests/btrfs/281
> index ddc7d9e8..c9efeb67 100755
> --- a/tests/btrfs/281
> +++ b/tests/btrfs/281
> @@ -53,7 +53,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K" $SCRATCH_MNT/foo \
>   
>   echo "Creating snapshot and a send stream for it..."
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
> -	| _filter_scratch
> +	>> $seqres.full
>   $BTRFS_UTIL_PROG send --compressed-data -f $send_stream $SCRATCH_MNT/snap 2>&1 \
>   	| _filter_scratch
>   
> diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
> index 2585e3e5..0b775689 100644
> --- a/tests/btrfs/281.out
> +++ b/tests/btrfs/281.out
> @@ -6,7 +6,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   linked 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Creating snapshot and a send stream for it...
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   At subvol SCRATCH_MNT/snap
>   Creating a new filesystem to receive the send stream...
>   At subvol snap
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> index 118df08b..2ddd95bc 100755
> --- a/tests/btrfs/283
> +++ b/tests/btrfs/283
> @@ -58,7 +58,7 @@ $XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K" $SCRATCH_MNT/foo | _filter_xfs_i
>   
>   echo "Creating snapshot and a send stream for it..."
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   $BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 | _filter_scratch
>   
> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> index 286dae33..7c7d9f73 100644
> --- a/tests/btrfs/283.out
> +++ b/tests/btrfs/283.out
> @@ -4,7 +4,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 65536
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Creating snapshot and a send stream for it...
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>   At subvol SCRATCH_MNT/snap
>   Creating a new filesystem to receive the send stream...
>   At subvol snap
> diff --git a/tests/btrfs/287 b/tests/btrfs/287
> index 64e6ef35..33f4a341 100755
> --- a/tests/btrfs/287
> +++ b/tests/btrfs/287
> @@ -112,9 +112,9 @@ query_logical_ino -o $bytenr
>   
>   # Now create two snapshots and then do some queries.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
> -	| _filter_scratch
> +	>> $seqres.full
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
> -	| _filter_scratch
> +	>> $seqres.full
>   
>   snap1_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
>   snap2_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
> diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
> index 30eac8fa..4814594f 100644
> --- a/tests/btrfs/287.out
> +++ b/tests/btrfs/287.out
> @@ -41,8 +41,6 @@ resolve first extent +3M offset with ignore offset option:
>   inode 257 offset 16777216 root 5
>   inode 257 offset 8388608 root 5
>   inode 257 offset 2097152 root 5
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>   resolve first extent:
>   inode 257 offset 16777216 snap2
>   inode 257 offset 8388608 snap2
> diff --git a/tests/btrfs/293 b/tests/btrfs/293
> index 06f96dc4..a6bd68e6 100755
> --- a/tests/btrfs/293
> +++ b/tests/btrfs/293
> @@ -32,9 +32,11 @@ swap_file="$SCRATCH_MNT/swapfile"
>   _format_swapfile $swap_file $(($(_get_page_size) * 64)) >> $seqres.full
>   
>   echo "Creating first snapshot..."
> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
> +	>> $seqres.full
>   echo "Creating second snapshot..."
> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | _filter_scratch
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 \
> +	>> $seqres.full
>   
>   echo "Activating swap file... (should fail due to snapshots)"
>   _swapon_file $swap_file 2>&1 | _filter_scratch
> diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
> index fd04ac91..5da7accc 100644
> --- a/tests/btrfs/293.out
> +++ b/tests/btrfs/293.out
> @@ -1,8 +1,6 @@
>   QA output created by 293
>   Creating first snapshot...
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>   Creating second snapshot...
> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>   Activating swap file... (should fail due to snapshots)
>   swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
>   Deleting first snapshot...
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> index 8a0eaecf..4ea22a01 100755
> --- a/tests/btrfs/300
> +++ b/tests/btrfs/300
> @@ -43,7 +43,7 @@ $BTRFS_UTIL_PROG subvolume create subvol;
>   touch subvol/{1,2,3};
>   $BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
>   touch subvol/subsubvol/{4,5,6};
> -$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot > /dev/null;
>   "
>   
>   find $test_dir/. -printf "%M %u %g ./%P\n"
> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
> index 6e94447e..8611f606 100644
> --- a/tests/btrfs/300.out
> +++ b/tests/btrfs/300.out
> @@ -1,7 +1,6 @@
>   QA output created by 300
>   Create subvolume './subvol'
>   Create subvolume 'subvol/subsubvol'
> -Create a snapshot of 'subvol' in './snapshot'
>   drwxr-xr-x fsgqa fsgqa ./
>   drwxr-xr-x fsgqa fsgqa ./subvol
>   -rw-r--r-- fsgqa fsgqa ./subvol/1
> diff --git a/tests/btrfs/302 b/tests/btrfs/302
> index f3e6044b..5dcd5295 100755
> --- a/tests/btrfs/302
> +++ b/tests/btrfs/302
> @@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
>   # Now create a snapshot of the subvolume and make it accessible from within the
>   # subvolume.
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
> -		 $SCRATCH_MNT/subvol/snap | _filter_scratch
> +		 $SCRATCH_MNT/subvol/snap >> $seqres.full
>   
>   # Now unmount and mount again the fs. We want to verify we are able to read all
>   # metadata for the snapshot from disk (no IO failures, etc).
> diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
> index 8770aefc..e89d1297 100644
> --- a/tests/btrfs/302.out
> +++ b/tests/btrfs/302.out
> @@ -1,4 +1,3 @@
>   QA output created by 302
>   Create subvolume 'SCRATCH_MNT/subvol'
> -Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
>   OK
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 887cb69e..719a930a 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -43,7 +43,7 @@ send_receive_tempfsid()
>   
>   	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>   	$BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
> -						_filter_testdir_and_scratch
> +		>> $seqres.full
>   
>   	echo Send ${src} | _filter_testdir_and_scratch
>   	$BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
> diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
> index 21963899..8a311671 100644
> --- a/tests/btrfs/314.out
> +++ b/tests/btrfs/314.out
> @@ -3,7 +3,6 @@ QA output created by 314
>   From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
>   wrote 9000/9000 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>   Send SCRATCH_MNT
>   At subvol SCRATCH_MNT/snap1
>   Receive TEST_DIR/314/tempfsid_mnt
> @@ -14,7 +13,6 @@ Recv:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/snap1/foo
>   From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
>   wrote 9000/9000 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/314/tempfsid_mnt/snap1'
>   Send TEST_DIR/314/tempfsid_mnt
>   At subvol TEST_DIR/314/tempfsid_mnt/snap1
>   Receive SCRATCH_MNT


