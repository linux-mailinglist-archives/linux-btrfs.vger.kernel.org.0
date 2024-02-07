Return-Path: <linux-btrfs+bounces-2215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B26584D0EA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDEC1C25301
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC983CC6;
	Wed,  7 Feb 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MlFLt2yC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m5HKIPXJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402B12A167
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329299; cv=fail; b=pw2Axa40TVG5mWz1anJIkHws9jVJuoPueifHFrb+yPVbD3XyKX0MLmm1Oz2FEC//ku4h7MzOIBb1iqvWmXlsNYkkTJnAWJvadkqoJxwPhdS5YeeO0PYpr2oMut0qcOxqjq/AAwz3rIYs+xLQmVSD/0mfWfijVyjklWRkQEGnFbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329299; c=relaxed/simple;
	bh=Bj9M3Noy3IguOtlXgKEj6qXgCsraAdIyoOddSdgyMvI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mcW5VkjwajoGpXsl8osBIwJ8U0Om/f6QehX/5wfOj+oPidVdqbc72ZhssvZ0EUfd6lzBnF8Of+YwTnyfW4CxiiZ34RcaZRg8/gG91+ojwI6R+f+AMg/PXzz6QsjzI75+GnT0gU5siJib4i8/zZHMLD//IkDL5yfK6QhHwOtIAMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MlFLt2yC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m5HKIPXJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417I55jB018031;
	Wed, 7 Feb 2024 18:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GgV1eIucEWezx5aotHY8dtFtM1iGegWQrD1rVKAy23U=;
 b=MlFLt2yCdLPT3KRp3qvgjm3xj/85eluVUajyBBasDBosNwBTESDxGYE7Gmpz5HvgWf3c
 I66mkNbpSZBHc1JY4uhcJrnCQuvGPzntybw9BUOx5i4V0H3BAN61vCFzJe1p7Z8hVdkN
 WMg9maUclCUNdzeNDPbjq29lqDdyH4SSJ69qTwTM355m0gZ3iraqGCMYJF0QCNc0R82v
 EhFoHrXnt+HQiCA/aXaOS68aeEu6zo5Yjxw+NVxuf9exYH2OGRwTGQdWETjCG8519Fs1
 V856aoz1yo+/Rp6Ass8UEKm4o1i+s3SRFB95bA6wOC1K5ZxFXvBVfZVwyx5t/e5vfjoB qA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ujhtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 18:08:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417I0FFu038406;
	Wed, 7 Feb 2024 18:08:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9db0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 18:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OD3TKZh1mL6Aulg4tZb2qV460dFv7qlTdvgM7my77tvDtkFSUVZjtYHNilRKEbH5QPUqRdd2VZF7HRugI/LCy3f2e1BEU3fuUyUe1C3FFqzTQeGwboS4wHcHoySURFkgSCcXY64sDlrjw1hex3Yrd8WEYQYNLBVXYdVJHZXG+T6WfcAyqai8VvdRwsGsa9M/LO7yiMTXYSW5f0k6SQDLFDNvLp3uesbUG/FDh//IR4dff6v8gNEENgt0YKt3adCo9M6lGVAoERbqeQxeWzQiESGg2zF1NckrAdBdV3cOKSNiNoAovFAajELopeqh+ZFV1NLwSIGQ0NXk03Rl36ZxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgV1eIucEWezx5aotHY8dtFtM1iGegWQrD1rVKAy23U=;
 b=aagJN/XTZEr1OB8XjNm1xnyqEucsLDII46VfSd+AvUs9cbpwtWzN5T2/E6HDhGhXFhyRlAd5Srk/3W9zFxBLCQ9S46jLGRTs8p3jUF+Qhx1mhPBNRVEjXlzIuV3Fa+yIrCrFrSIwuzXp+2eyaWWm+Uqz8eU/vl+EhLo9LUshVnB2J/lx6P6NHy6OYc8+sOVBJ66mUIk0DOlXlnk9VhyTQKolCAJPZMSfjYATa379cYALomvTbZv4eH8z5XFvbNTg0UDRh0c2HSdncGCnnC5OarRvyaNRM6wRqYGctywBEp2ZmjL59IPp/IqPXXPSx4cKvS5/YqjgPV+3Jq5vBu2sPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgV1eIucEWezx5aotHY8dtFtM1iGegWQrD1rVKAy23U=;
 b=m5HKIPXJod+qhaMu94UlrCazAdWB/ql8iZeZA1GKKxMgkqqB34yDSKyhmSO0QADc1ECAm7IwspwhyK6B7Qc+T+9XSo/wJByrPZvF4IOPx/YZ2D12nRRDDfwbAeCXfDU7ZJ38OtLtfJP1FyX/NAUtJgK3HTsJw08YWX4juCpIdvk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Wed, 7 Feb
 2024 18:08:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 18:08:08 +0000
Message-ID: <8c326f81-e351-4e71-b724-872701f015ff@oracle.com>
Date: Wed, 7 Feb 2024 23:38:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
        bernd.feige@gmx.net
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
 <20240205125704.GD355@twin.jikos.cz>
 <e718b759-e597-440f-9fd0-351686bd6b5e@oracle.com>
In-Reply-To: <e718b759-e597-440f-9fd0-351686bd6b5e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: a08adc70-4602-491f-fc20-08dc2807bcfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	K66bRWZmOPBClFCVlt8BczWX2rwblndlhJ8Cfo1yxPSImQ7chOILd1YaocJ/0gQdjQjMI7PE2/Dj5zPf7/WU/Jeo8qrLO5pzwtIUfWoA1SW+kccb/PBwVGjtRLEC7x2deUajAHTx8mC8e6H614AeRgEwagtWpYcR8YtpAbc3VZwg3zvxrcUeZeV6/uqJxB/aC90cToo+J3VpiK+dJHAmyxe9iVT+vsfihVGWZIEa37YkxmaPm+UamEGJfDnkz/2vmpaIID/9kdB1cFrHnuqv2vnJS4ZFx8yUz0/0Z78sUZGskMMseJgf4jRHXYNlozAcwXrvDP0Q/swQ1X/Vz36rD8sN5BA/KCzMraLr348fGgcWlRna9nz/IU3qPXDtmR0eDkUhthX22DcEJ5hSjXJ7XnjwLYRFZwSHqa83q+nIysj+fGEEht+Gnc0sK7Hd4vtlGwUNITCaQXEesXY9IxA+EFGuLqyPhNw7Z9Z5tF9zX8vZzNHQUULdVxTwhl/lzS0tdNAriAl9cbGi7DnQ11I6D0kBk7VvDr2QXRr0UjNcQC3/c7BuAjEIJryV1iQZVhz21KAzFcA72fyf3nv5faD1JjAgbw/p1/c1WtmDYfs0FaYX0GnU3NzaeckT3TzimxM+Im3lE8kfyGZb1HtMwfs99w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(4326008)(44832011)(86362001)(8676002)(31696002)(8936002)(6916009)(5660300002)(36756003)(6486002)(478600001)(53546011)(2616005)(6512007)(6666004)(6506007)(26005)(66476007)(66556008)(316002)(66946007)(83380400001)(31686004)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHorWlBocTdHeGZHSER5dEp0ZXYzdURsQStsNG5BQVkwUVM4L1JGcDYvalZD?=
 =?utf-8?B?QUNqVy9ETmZZRy9STS8yMngrRGNkd0FUeDl1YThxSGxIeWpNRTNXTkE1cmdS?=
 =?utf-8?B?VGlqcmRWbDlYVTd2VUVRVHRkRm1WSWJIdVhTZUtxODFkTzI5cXNPMlNwYjhC?=
 =?utf-8?B?cXFGSHBYM2Z2TDAxTnVxc1QzSWl6NWE3bndmdU1UTjdhd3JYWGN0L2RkdG1S?=
 =?utf-8?B?OHdZN2dDWEVFdWk5ajlLNHdibXU3RHMvZjduQ1FadWhiMjY0NVJoREFTNmRI?=
 =?utf-8?B?Q2pRc0diVWVyeDNXekdFWnB1UlpScERna3o3aDNhSldSSEZDYXRkbEVxOGtp?=
 =?utf-8?B?N0cyZUtTcUU1bCthQklJM05RNXhTQ1N2TWhTT2ZWWjg3Z1l1alJVak5HZU1B?=
 =?utf-8?B?Mm96dCtOc0ZralZsSmFkdGlTdnI2K1hralNGdW84d0NCeE1DWS8xWVZoaDl0?=
 =?utf-8?B?SkIxemRPUW9BSTkyM1o4M1V6N0VGOFAzVkorNDBCZVlpeGMzOC96cjhZdjVL?=
 =?utf-8?B?akF6TTkxV2M0dFpXd3d1SllPcGRXL1kxczhuS0RzTEYyaW0xSHVxaXRZQUpt?=
 =?utf-8?B?WkI1eGRyelRTZU1xbUpGZzgyYWhreis1WVdveTlrZ3doSGpENS9XcWIzUVRM?=
 =?utf-8?B?U2loSThSUVBWNnVZb21za25YR05hbDUxNDRDWGw4NUNyckdNR3RYampDVmI0?=
 =?utf-8?B?djRod3pNR3EvM3hzZHBoYVR5YU92Yi9jeDljYndMRDIwdUJ5dGpPb292cmdR?=
 =?utf-8?B?WHorbTZMbEFhOGNoWE0zSkZaSlJYT1BZWnpmTzQzMTV1NDBHMHJGWUQwY2R0?=
 =?utf-8?B?bWVUOVVDbUZWWjhhVFlHU28zQ0xwYnFNODZoemRyV3N3Q0p1V3c4R0czT2tO?=
 =?utf-8?B?aEx4eHU4YTlMNEIzS1NDZmRWclJVWW1YNFhuUTgxR3YvVW1yd3dpNWlHTC9Q?=
 =?utf-8?B?ZHVmTzhzZm5WTXh2TXRBTUtsNE84MW9yTW1TODkwK2tlM1lpeUcrNnlzY21O?=
 =?utf-8?B?bm52ZkQxU1BrVTFtNFZpNHVFYXFrd1ExM0hrS1BlbFRuanc5MFpxU1FFUTNp?=
 =?utf-8?B?YndVN1B2Z2FNeE8vbVVDOFErSTUzNEkzaEVvbWVDa2U0Y2p6bkMyaEkvTkZF?=
 =?utf-8?B?YUh2eTZOdXhjTGlTM3NRZDNONVpjZDFESGszY1c4QlVoc2I1V1kzOWZST1lM?=
 =?utf-8?B?Y0lVVjRsbFBWRzlpRFJKQkk5bW44UkZpZTdzU214a1dxWE1NcEk4dUN4a1Fk?=
 =?utf-8?B?V1pnQXRDUUJLaVFDY0xHdDlyNEhmSjJMd1NJZmtlT3ZZTEVvb0pUN1pXamRu?=
 =?utf-8?B?cUs1NWhSS0FUMzJEK1RybEhIall4V2Q1MXMwTVluS1V0NVpsMTBXSTEvL0ky?=
 =?utf-8?B?Q2dLNDZFaGs0eVRJSW5jMTlhRTBkT0loT09MOGZxNjlsOVhNNHYrcGM3S21H?=
 =?utf-8?B?Tm5xMWhpeFUyRkVKQlNuK1JJeU45MXVMSDBLTkV0ekRXemlhZGIvQ1B3cjc2?=
 =?utf-8?B?RTEzNGNScmNVOTdSaFRCandZN3pKK0VvbU9veGlvQUswY1JPY0N6K1V1clJi?=
 =?utf-8?B?SmlUSkYvQkx0MTZUQ1FiaW9BZitIQU1uVzV3NXBKSU1zVk5LNTRKckVndXhh?=
 =?utf-8?B?Z2hMdFJzdDdneEdLbTJ3MVFRZitzQXdobGZLSUs4RHA4MTMyU1kvTGxlNFBJ?=
 =?utf-8?B?eGozY3pBMEovL1Vac1IwdkVVZnR1elJaTS9pWVM5SE45eklNZjc4V21FcVZR?=
 =?utf-8?B?eFVEUUhJNlYzcG1hbExMdCtsT3QrQWRsOVYrVUorZDdsN1dIMHdLdm16QnJq?=
 =?utf-8?B?VzdOcWFPT3FzeU5SeVF3cVNQNS93WTNOb1FaT1BGK1d6WVBpUjB6dzhmTnFX?=
 =?utf-8?B?N2VEV1FHWDRyTnpJb01NdUJpeFdZOUZXZWk3aWVvWkdsRXVEOWRXYkE1ZzdE?=
 =?utf-8?B?aitBM21pVVBHWlBENjRGY09aSGJQRXdaQ1gxUEg0SUhIRWFYUis2cGtVMURB?=
 =?utf-8?B?UmJmS0ZTdWMxNjduVy9jYzBPQ2hKVXIvb2lBVGcxYkVsNDNUMUF5YjJ2dzM5?=
 =?utf-8?B?V2xQVHRRQkRpS3A1Qm5rU2ZnWlF4b3dSelhiaHFXUzNxT2x1Y2VjOTRlM3VE?=
 =?utf-8?Q?2WbQwRRcAkIG3wtccIjepwGON?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CpQ8veVRcNKep7A+axL1T1dMdfhEFEAQgtIrOd4rii4JJPMKH5M17QNxE5Q+61WHboaTnyzflq0Oy1QpL/4iOaC+H3D1VVJLCWKX5YKrAKqwnRovVKRvxZyKuoUOY6vk+K3qW+1BJsv5a9rEwVQpRiuLKevaD00R242KIervpJh5f2cEOx5GOlRVc6J4Be82zkgngQW9jeH9Wr9E3Gyrr4p+Ub/fXNMcNxteUMamfa9dcQJc9FsBfNcJAvSR/fN4eUMqgT0KcEybbrHDi4uD/cAUL0mIpswgrqgGymSgNjdkAkoXX1X12FMYhseipbPdVi4JQt53nme9S3uBkAqtRXHwseGPiSFADbZBEpycqdneBSHq6ZA+S6oanX2+Te8ky5KOax2M/lxmKCX6/wprW9y9OHmRXYQGE9IrfMgGtspYFobEOwGf4Seuwbkca7/zG/sKzLFdmJJbTdH6AAxaZS4WP50L7JgGXTAlUZ1xA1dExqdiZXcjGAf31aTmCM7yrQ61i7l/Ah6E4iDYKSOov1pwtu1bWwQgNvW1wmsz96LQ7iaTi237fzY+PK9mGakkQ4b6OZgD5fzpozLChBD0EQqNubkxtvfCQNd7hI8ClBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08adc70-4602-491f-fc20-08dc2807bcfe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 18:08:08.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuv0dTMA88Dw1Z3RlMm2FH57MFU8eDy08zIjrxeI68cKPmPoQLGNo2LOX4kyE83AO6bRKDs4uhE2dObnbNNTuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070134
X-Proofpoint-ORIG-GUID: zEETfP5jWvwFSUuB6sDE3eT_kbgvdpII
X-Proofpoint-GUID: zEETfP5jWvwFSUuB6sDE3eT_kbgvdpII



On 2/7/24 08:08, Anand Jain wrote:
> 
> 
> 
> On 2/5/24 18:27, David Sterba wrote:
>> On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
>>> We skip device registration for a single device. However, we do not do
>>> that if the device is already mounted, as it might be coming in again
>>> for scanning a different path.
>>>
>>> This patch is lightly tested; for verification if it fixes.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> I still have some unknowns about the problem. Pls test if this fixes
>>> the problem.

Successfully tested with fstests (-g volume) and temp-fsid test cases.

Can someone verify if this patch fixes the problem? Also, when problem
occurs please provide kernel messages with Btrfs debugging support
option compiled in.

Thanks, Anand


>>>
>>>   fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++----------
>>>   fs/btrfs/volumes.h |  1 -
>>>   2 files changed, 34 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 474ab7ed65ea..192c540a650c 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
>>>       return ret;
>>>   }
>>> +static bool btrfs_skip_registration(struct btrfs_super_block 
>>> *disk_super,
>>> +                    dev_t devt, bool mount_arg_dev)
>>> +{
>>> +    struct btrfs_fs_devices *fs_devices;
>>> +
>>> +    list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>>> +        struct btrfs_device *device;
>>> +
>>> +        mutex_lock(&fs_devices->device_list_mutex);
>>> +        list_for_each_entry(device, &fs_devices->devices, dev_list) {
>>> +            if (device->devt == devt) {
>>> +                mutex_unlock(&fs_devices->device_list_mutex);
>>> +                return false;
>>> +            }
>>> +        }
>>> +        mutex_unlock(&fs_devices->device_list_mutex);
>>
>> This is locking and unlocking again before going to device_list_add, so
>> if something changes regarding the registered device then it's not up to
>> date.
>>
> 

We are in the uuid_mutex, a potentially racing thread will have to
acquire this mutex to delete from the list. So there can't a race.



> Right. A race might happen, but it is not an issue. At worst, there
> will be a stale device in the cache, which gets removed or re-used
> in the next mkfs or mount of the same device.
> 
> However, this is a rough cut that we need to fix. I am reviewing
> your approach as well. I'm fine with any fix.
> 
> 
>>
>>> +    }
>>> +
>>> +    if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>> +        !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
>>> +        return true;
>>
>> The way I implemented it is to check the above conditions as a
>> prerequisite but leave the heavy work for device_list_add that does all
>> the uuid and device list locking and we are quite sure it survives all
>> the races between scanning and mounts.
>>
> 
> Hm. But isn't that the bug we need to fix? That we skipped the device
> scan thread that wanted to replace the device path from /dev/root to
> /dev/sdx?
> 
> And we skipped, because it was not a mount thread
> (%mount_arg_dev=false), and the device is already mounted and the
> devt will match?
> 
> So my fix also checked if devt is a match, then allow it to scan
> (so that the device path can be updated, such as /dev/root to /dev/sdx).
> 
> To confirm the bug, I asked for the debug kernel messages, I don't
> this we got it. Also, the existing kernel log shows no such issue.
> 
> 
>>> +
>>> +    return false;
>>> +}
>>> +
>>>   /*
>>>    * Look for a btrfs signature on a device. This may be called out 
>>> of the mount path
>>>    * and we are not allowed to call set_blocksize during the scan. 
>>> The superblock
>>> @@ -1316,6 +1341,7 @@ struct btrfs_device 
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>       struct btrfs_device *device = NULL;
>>>       struct bdev_handle *bdev_handle;
>>>       u64 bytenr, bytenr_orig;
>>> +    dev_t devt = 0;
>>>       int ret;
>>>       lockdep_assert_held(&uuid_mutex);
>>> @@ -1355,18 +1381,16 @@ struct btrfs_device 
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>           goto error_bdev_put;
>>>       }
>>> -    if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>> -        !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>>> -        dev_t devt;
>>> +    ret = lookup_bdev(path, &devt);
>>> +    if (ret)
>>> +        btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>> +               path, ret);
>>> -        ret = lookup_bdev(path, &devt);
>>
>> Do we actually need this check? It was added with the patch skipping the
>> registration, so it's validating the block device but how can we pass
>> something that is not a valid block device?
>>
> 
> Do you mean to check if the lookup_bdev() is successful? Hm. It should
> be okay not to check, but we do that consistently in other places.
> 
>> Besides there's a call to bdev_open_by_path() that in turn does the
>> lookup_bdev so checking it here is redundant. It's not related to the
>> fix itself but I deleted it in my fix.
>>
> 
> Oh no. We need %devt to be set because:
> 
> It will match if that device is already mounted/scanned.
> It will also free stale entries.
> 
> Thx, Anand
> 
>>> -        if (ret)
>>> -            btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>> -                   path, ret);
>>> -        else
>>> +    if (btrfs_skip_registration(disk_super, devt, mount_arg_dev)) {
>>> +        pr_debug("BTRFS: skip registering single non-seed device %s\n",
>>> +              path);
>>> +        if (devt)
>>>               btrfs_free_stale_devices(devt, NULL);
>>> -
>>> -        pr_debug("BTRFS: skip registering single non-seed device 
>>> %s\n", path);
>>>           device = NULL;
>>>           goto free_disk_super;
>>>       }

