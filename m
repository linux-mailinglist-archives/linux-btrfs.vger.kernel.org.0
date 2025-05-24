Return-Path: <linux-btrfs+bounces-14220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC0AC2E32
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 09:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF1F4E2679
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F81A314F;
	Sat, 24 May 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mbz9yKz4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vpa4RQHr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1B1DF987;
	Sat, 24 May 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748073214; cv=fail; b=hp6qtFE+eXtOZd8U/lg0XZ+Fv3fde9/zMbZ4g/ilObSBVbUgZogB4/c3cPjlrlHDobE4e9rBF4w9aodl9yk7VqKExsgCnynKAv9juTEgJ9XRyE3h5X08FLF50N5olDpyP10o3+Pt0UKXPbzLoukKEw7SU9tVbVgBF1Biouh+wQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748073214; c=relaxed/simple;
	bh=xzJKy+vzb1z/amS+6MPLf+sLKFFwfZVku+LYbxGw/4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mt5axrA67+Ewz++sAmZ6IQZvNMVIi5RNt5d6DGJIgW1LdR8HKnFd3PO/JlHDpfWWNxcyPXYONd3BJxeP8eVPeDJ0AK5YwG7BAkWJSfsbxlMxFFCqvVx5sYkEQt16Eoj6uwTb4d9+26n9akt4BbVHQgXMUPc6GaE5TtR2IQs/78Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mbz9yKz4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vpa4RQHr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O7nqwF007351;
	Sat, 24 May 2025 07:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iLBWx8NdJZOfMtULzQB+aE9KCua5MtxR+edo45CvglQ=; b=
	Mbz9yKz4aMJKPthaM/cEHiKw9LMWQl41va+Mo7oEQ5ZXNvXe8zv9wD01nBmJfWPh
	LQ0gbcLNPbULGK0h6qTRTS6LJujuH972PFTAB3jy7Q6d42dRXByQYbYgdpScYEs9
	hNuQPUkelHfTcS6JOsaXUxnBq9nfkid1ha/uHU358wyehP7iHoiMcauKjKkJchWP
	FN4bloHDsoMcTzIYoYXuQecxR+w3hT/x5Vw2o8wcJp0P2jYtDjeZROg6dhj0r6Q3
	AYS7j9i+N6DQEsC+oqT8j5XorG1dfvmWIXC4f4sD3cDgfY/J3rZi6JsNfEvUs5cZ
	Gqa7XeZlaWYf1I9KCQjJdQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ua250030-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 07:53:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54O7C6kA027835;
	Sat, 24 May 2025 07:53:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j66rux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 07:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8RJQg7sUi4fPnBsxpz2sdcGfLrQhP8pr0ZGAOtOZIzpgSedTnjcNEOfDDtkGjSMNDcNCutg6Do6sGqj/cD+uWSeL6MMoK3anmkAQbmnp/xWPDbyhKiyn5Xexf8ALV7jqyFWXSrGmxN2wcBcCTzMcYQPYPQs9xBZH9JShysXwcl5MRxhPdfoUEoryX2kO/itec4xhdbpve1lOBLXmXXWy9K8nx+Cy56+wTdIOw400oqNDX4dJ4nN+z2INp5bm64EI3sUkC6SEZhybbEQ+OdHPqLHAUwAGA+/xPTSzhwSG4C7D8bP9IS7TwXSlYWoVgEnZ5vw/HVfV624u/IexPclNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLBWx8NdJZOfMtULzQB+aE9KCua5MtxR+edo45CvglQ=;
 b=yoQzfuIc9wBHdsQMOkbuZawEHm2u2OVgL0Q5ou3A+NnV+Qjl0cjSppwgodOJ0wzhht/bmbAR2UAdiGZzYG/evF6iZAjw0s3oJ0zVzm+9tPcNiE/v2YDp2fRp2xJk00iB4pMMX1PDyGrRMohWogiLFnetDen6aJdz7j9yObkSdAz4ZVZJ9LutVphledtXEYiKc9YTkq5bi8UpqD8rzlPUF/OIP/Meq4ftxuSraj/qRRD3vurEKINm5CPBMqEVBDXI6R4rOCaAmIiInKfoQG/d0PRHihAqavdiBYMnOnEOkLWenkVB7N6LrIoOYIqEF/FAaIETDijLSD2vKL+Xulm93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLBWx8NdJZOfMtULzQB+aE9KCua5MtxR+edo45CvglQ=;
 b=vpa4RQHrDNcd2IpvE+Rphc34qVRUh9DVj8DegdLBRpx+JtBrEFWJcqlQZEWEV5yLCGE+lvk2dsHi0rpHbSwxZHcx5kpBtLLErHdHTsccOjXC3aLh37L66pPr6PxDqn2AATAub1J4T3/aXK03SSVwZwOHgm768QR3qwGNTJNbYrk=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CH3PR10MB7713.namprd10.prod.outlook.com (2603:10b6:610:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Sat, 24 May
 2025 07:53:01 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Sat, 24 May 2025
 07:53:00 +0000
Message-ID: <f4c2b83f-cc13-45f3-9f16-03095b56e175@oracle.com>
Date: Sat, 24 May 2025 15:52:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
 <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CH3PR10MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 9007f018-4dc3-46a2-47eb-08dd9a9800da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkZlV2gwVlMxcTcrU2xGbUVVQ1lPa0FGVUFjTHJNYU1KYnBaZ0NwTmhXZUpO?=
 =?utf-8?B?Q2g3Uy9yT2EycE9TYUZYazVCSlZBL2JUTW1VbldReXdrWmFFS2ZwOFFsQVhY?=
 =?utf-8?B?aEFJc3FTa2ZLVWxudmxlWWZ3ak1wR2NnckwrV094dFhHQTl5Z2VvM2ZXMkk2?=
 =?utf-8?B?YmVKSGsyNzFCZkJCVjY4blFrczFEOGFEcHZTdGE3Nm9hSC9LSHFCeHppVHBF?=
 =?utf-8?B?TzRDNFdSaExRczEyYno1Rk1SMDRsemdZNTdkZlFDQ2M3MUwydElWcDNIWUhs?=
 =?utf-8?B?THN2RmNpalM2cG9SRGl1WkJJUStxU1ROV1VTYXZZRW9QT3ZrM2VNTzFGRytr?=
 =?utf-8?B?MThyanFFNjN2OE9KVnBUOHIvTkZoT2xURjNTVTd1SFpSYXNwWnlXQmZFMGMz?=
 =?utf-8?B?MitRRC9iUm5rNkM2QVl0RW45d2lDZGo5THlXT2w2WWhwbkMzM0wyMzVDYUcw?=
 =?utf-8?B?TUkxRHRZcXBzaksyK3ZBb2ZBMjhtckVtTWh5WCtNT0pJOGJFTWY5OGRiMTdx?=
 =?utf-8?B?bUMyTzFtbnRiWU5IcEJKenJHZmZ2WGZBa0ZTdmRjS2lKZXhXekRaTHY2SE5h?=
 =?utf-8?B?bXAzU3ZUN1hsUyt2dnJVTXFXUUc0dzFKZG9vM1g3Y2Rlc2pUYm54WFAyMHlz?=
 =?utf-8?B?d2ZqU3VrdUh0Vk1NbGl6VGM4NGZvUjM2bWVJeVdLQ0tmSWlWS0NGcnArcEFC?=
 =?utf-8?B?QjZCcXZQanBxZ1VrRmJzVGlGYy9BYTNTbTBBdm9OaTlMN0lTNEROeXkrMTRa?=
 =?utf-8?B?aUV1d2lCS1luZXNjMlBBeDV2TWNFeXF3RkFLcXJ0VkdLQVN4RWNYem9LUEg3?=
 =?utf-8?B?T2hmSzZiL09KUHlKOGtYR1orWmpCS2laS0pLTko1K0w3cGMvTzZUWDlHNWdT?=
 =?utf-8?B?d2k5YmpUSW5ENHZCMjJsNDFTSXRmSUh1aFJWTGxKa0JNYWU4SGkzMWkxQkVn?=
 =?utf-8?B?eU5mREVHT0dkbG9pU1pVODkvRjhPdkxuZHFCZmU3UDZVZFFDeUZDMFBlNmJK?=
 =?utf-8?B?eUNPWkRUY0RsN2l6SXgrbERtTFhGd2xwdmNrWWVTcGJ1eFQ5OW9kNFo5Lytu?=
 =?utf-8?B?c2dUa1IycEtmR09ISXdiUi91akRyWmhkZTFZVU9JaXlCOHA2TGFodFZ6TTFa?=
 =?utf-8?B?dXRPdHduOTlsVVpGVkxYQnEyL1VoUHpndGxsWmVCaFJuTzBXWEZNVWN3ODV6?=
 =?utf-8?B?WDY3bisvMHhPeVYxRTQydTNSUFB5NGh2RCtIa3B0WGZ2Vm02RTYyWVFiQzJ3?=
 =?utf-8?B?ZFpIZ1BudHpaMlZXcXJKL0pCMzFBLzJrYjdLS0JBdExpNVdZTzdHdlpGa1Y0?=
 =?utf-8?B?cDllaXNERnZZOFZ4S2x4a1JMQnUrbG9pbjlOYUxQRG1FMDUvMjRIUkEycmhH?=
 =?utf-8?B?R0xLUDNUQVZST0RTa2NneFpzRTk5NGVPazE3REhDOEI2aVFkVHl4YkltSTNN?=
 =?utf-8?B?SCtPTkxxUFlrZXg4TFh5K2JRZDB4Y0pNblRoakd6citoWGJHckZHRnAyN202?=
 =?utf-8?B?a1FkVTV1bk1FMU4zakgzSDF6djlMOWxzeE5ldDNrczJHQTFTbkl5czJPUC9v?=
 =?utf-8?B?UGttRnVNa01wMFVMZ0NxSnIrOHpLZGVzYXAweVNyS1NlOEVWejVWVDduRS9B?=
 =?utf-8?B?blRmMmkrUHlWbllEVHMwV2lFd3RjZnhGbFozcGJkQlREYXVnem13a0ZvVXhi?=
 =?utf-8?B?RTAxblNweXJOUWMvRjJwTjJwbnMrd21qelVyNmFxZENkdE8yTUdtV1Z5MDFh?=
 =?utf-8?B?anZsVFh2T0tiK1hWRXQxK00vS2huOEZYc2NVYThJNmNYQ1JrT2lIRWRvd3Ex?=
 =?utf-8?Q?bfQ0e422KuN3AOW/a23dj1N413EDdScBcxu8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFVITDl5a1V2b1YydjdoWGhqS3d5NW1sYlRtZlNKYW9vODlRQXg1NkdGQU5Q?=
 =?utf-8?B?UlFpTEt6b2JyY1o4WFE5cWxHNjd5b2MrOFpuVitkeUdTbk5UejcwOUhHZHFU?=
 =?utf-8?B?ZDFaUHdmaDBhUG5DSHdIa3FSTVo0ODR2aUNIbXFiem1pdHF3aXlKVUNySldv?=
 =?utf-8?B?ajZvQ0JVUjB5WW5RS0RFRnZ4QXVuNUFSVmJIamxwUEd6cGhTQnM1aUZiL0Fu?=
 =?utf-8?B?aXMzVnNPVVluZ0V4MUF1VUNMaGdQOWUwTmVTWVVkL1RtSDdmcng1NVgxYmp4?=
 =?utf-8?B?bjd0dmtLNnpTRmI4NHdPRUtwUDVIM2lCNFErcVZOZm1LTG5ReGwyaGtYWDk1?=
 =?utf-8?B?QU53WEtiUjVURnBzd1JDaUUrcjFoKzVwb1VYbnNTUE12YTg3VkUzRDNIMUt3?=
 =?utf-8?B?dGcxMWhSK3JNQzNuNTk2Q3JOTzFabHVnM1NrWWJBV2RLQW4xWnVXby9PNzAr?=
 =?utf-8?B?WUlSREpvSVdqcVRyY2taQ3NkYVhjSVg0cEJ2UVJHS3dnMWl5d3g4SHpjUmcw?=
 =?utf-8?B?SHVGcFZKYVkvaThXb1FSNDJYU0YxNll1ZHhCTjY3SHhxc2xmcUZ3SjQvTUtp?=
 =?utf-8?B?a0NtMnQvTlM4a3ZaalBPdmF6VEszUkNTTmVrVzNmRUw0RC95T29jSEswTVhO?=
 =?utf-8?B?ZzhwZGptNnY5UU80aU9udGh2Q3ZhS2pwOGFZdTU1STZ6bkJaeEtHSVMyNmtO?=
 =?utf-8?B?SjRPU0pRS055R1VJOSt2djJRT2VWMHA2ZXdQOEQxTDRzYmZTNVhXdzVWSVY4?=
 =?utf-8?B?UXpNdWRkTmt5enVQVEh4VjRKZnVLeWROMWJVejNoRnZ5VFM2T1hsSzdGME1w?=
 =?utf-8?B?MmJtYzRuOTZmQ0JSVXRUaFYvNm1yOEpDeVlwNVRrS2FjdEhkSjBWS1pYMVZw?=
 =?utf-8?B?UysrWnh0MW44YzNHK21KdU9GNU5MZU1wNFFMUjZHUXhkejA1VkpzdVRnektl?=
 =?utf-8?B?K28zKzBGSnNLNDh0eVdSaDVtUTRQQnZZNW53ZDgrRjlSRVBRb2tURXZWNWFa?=
 =?utf-8?B?dW5LekpzK2lQOFRsSFpJaTMvTEsxL3F5aFV4M0lsQ0wyQXhsLzNkWThrNnVZ?=
 =?utf-8?B?aVFpQkZaR1ZmWHd0QUE0Si9JK29NYy9tZzN5VUFRTklvU1Bnc2tjREVwcjBK?=
 =?utf-8?B?VUVTT2RMb1A0aDR6dTQ5WUdFeU81OUtLZ00rQnhYS2hpVmR1dXViTEZlbjBh?=
 =?utf-8?B?V3Qxb1NkTnZOWGdHeW1OYklEaXlSZnJxdUZUaXI3YW9xYnljUFJzcnBSeFFW?=
 =?utf-8?B?aFlBeGNJVktxT05pZjUyWVYvVS9qQ3pTWHFRMC8vQ3dpVFVvYlVsMlBMYzhE?=
 =?utf-8?B?UGVOR1puWjl6Qkp4MzlXcVlEaFpnL1JTN0J3MTc1K2doN3FlZyt4VUxuMFlp?=
 =?utf-8?B?NHRkWWZDL3ZOOFJkRVhrM1lDTzEzQVk5aUE1R0lCZHQ4eFp6RGpaZ3JWT2hI?=
 =?utf-8?B?OHVKZzNuS3VyaStHc0l0QXhyNzQ2TGNzbXJKZ1FHeUs1R1NZbElJL2hJMG1u?=
 =?utf-8?B?a0s2azY1MkZiUy9RTUFSdU10bmFiOVpaTnZzaWlmV09za3pWRFZYRVNjd29l?=
 =?utf-8?B?UldYUzd5dGRYTXZsRVcvVWxraGhlRzFSTkZZNFEzL3pncC9WSGNoMDNIQnBG?=
 =?utf-8?B?eTVqaTZNMGJsNUlzMzBsR2hKUUVaMTZBSnBoU25NVFFvdHNvRDArM09uek9X?=
 =?utf-8?B?WkJMc0dIRzhxVGxKUnhwVk8xWVNRRkNZTjk2Q1NXdmlwQngrMDhFMzlRY0xL?=
 =?utf-8?B?TlVKK3dtRzlQMmRWV1FDTzFGY29lS2RvOWF4YmtOdnVxUVJUVjVzU3g0SWVD?=
 =?utf-8?B?cTc3ODJtQUc3QjI2eTFKRktEZGJaNVZZTE5VZCt2TFFBZ25kU1dxVTRocW0z?=
 =?utf-8?B?S1hTQTVQM0tQQU1mandLNTZwSTJyMTFsYnR6b0tSL0wrRUZuNWN6Zk84OWs2?=
 =?utf-8?B?c3lZVXpMcVlqMXYvZklyYThCOU0vV011RGkwN0JTRXcvSUFUY25iSEMrMzNQ?=
 =?utf-8?B?b0VTSEZyZWRGMXVrOVZWbWI5QkRPaStOdkVzTG5mdnRSUHNvbG5mbDZrbkFa?=
 =?utf-8?B?c2ZORmFISG9ZckVweUpMZEd2dG0xTnJ4cWtzYWxWei9HWXJaeFFwSHJ2MFkv?=
 =?utf-8?Q?rkAjCWV70kPxQTcp0b5J3PmXS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t9L+c6L/RBRK9lBFgn4aU6E5R24sPvByX8iPlX2xWP7WOhW3JoAgywqdgcELrdJoh7oJvL3F6q3sqnyPqTUYheUrXnGdtaTKeUSeVtwMgpKRdf7+CqVm8TElq2+mu5MaoD332jaK5HoiWTdeMlW2N5i+W5DZi6jeJalfLBexTyYHrJ96cqRNo61HtjyQx4MU8KjjmLSHlaWSMwufrB2gK5k6pYAmQeu5Qs1ksVjsCYGcrRIEgZ1sWo7f1xbYfD7tNbGwHvLWMwl1hP7ibU+EqedvTOWZdW0mgz7clA1LPV1+EoswCs0QVY4DdNhpo4aH5aOabmfqK51M0bvArfhTP7MA98cBETTDgV94Hgb0fOuTZQ44k18yR9JsOb16rbpJw+CJGOO0m7tj17e9FfAOio1hD5DD9Oy8hmHgdUD/ntiFxsPrZ3fcy62VFMdOWNlrGD/vAfO3+axscZ291VhXqEnKpuy6boQE35SwIgfuoKUYsrNdTZ1pk4NzvIvmzd+zCVR1CDxJqEfrU8NCaQozqRQsINdQWU3MH/DTQCj0ATORTeQqii37oj3eMjdrQ/o6hX6zYRTQIGdS+EcjIbkJeHiaiwYauht7UEIQsKKxJL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9007f018-4dc3-46a2-47eb-08dd9a9800da
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 07:53:00.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvtbHKVyABA9Y51Bc5kC5cU55kGvOdUlMTlyxeVYCbZ8GSmpYkWWVzkFG5L3+QUXaP3+evLFUyW5xqcdsyIWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505240071
X-Proofpoint-ORIG-GUID: _kymSTbqF7evm7ZZKfM3OcLOLn9EI9lL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDA3MCBTYWx0ZWRfXzSY5PVHCrYJ2 Cfb9X3OX296WAOyTenmrurQMWCU9mid+k7EXksZRm5Fll8MLtHgBNjVAxbMygtZsJz4q/GPrxQG wzSPvDBvacgLHu8kptwZisRupxBanVEC//Nr8++4nzO7K0pTPsdTLxaYWwVhuQEdx6NhufNyWly
 xazvngAPlKlJW8KH9CFwl2E3oMmKXdOJ6ivR0zoHaZ1IN7PezGIkVmAgIRr4SWWizHdL68P0dqs 0EZeQ1ehi1/+yNRqPWkltE9ATqhvkqfYDTVo1WqiemHMrWPIi9Iwyc6GKJX63OEPjbhSD69u2aD /6VeRGKDMJ1whuD9S6PDQ81l/lUwQSpHtUgx8BJMua1IP1vqqHueCNq+B5cAHu5WZTNqi3yBsyL
 8gAtBDjd6Jf2EAV9S4p8a4o2cFUszsRGBHvxkoRK9mbm+o6+xzRlQb7XYT+g0jU8pGKDhOhS
X-Authority-Analysis: v=2.4 cv=LeE86ifi c=1 sm=1 tr=0 ts=68317af7 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=OLL_FvSJAAAA:8 a=twZ8MNqrPLyAiClJ2mgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e72awE5OOzsA:10 a=ubxQsdc_O_wA:10 a=zZCYzV9kfG8A:10
 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: _kymSTbqF7evm7ZZKfM3OcLOLn9EI9lL


>    3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=idatacsums

There’s an additional fix on top of this patch that doesn’t have
an R-b yet, so I haven’t included it.

https://www.spinics.net/lists/fstests/msg29195.html

Thanks, Anand

