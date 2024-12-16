Return-Path: <linux-btrfs+bounces-10403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62D89F2CE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 10:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CE9166D2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377D01FFC6E;
	Mon, 16 Dec 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bddhko94";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rpc0HN4x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C139200BB8;
	Mon, 16 Dec 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340989; cv=fail; b=QbtWrTYZaXDWx8rcLW+xjfL8WVU19VR59vIuhdWm0yczV/IBUNctvKoGXvJK4CtdxzS1F+E7iGQwCid3VV+fq9+QW/QN3NeIhnGXWXQTl8G9qkAG6XP6fOQiOSDDwtF1WcVYNafd9Ul7TyRbTAv6cJIBxAcO57E5Hs3J9+gCaA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340989; c=relaxed/simple;
	bh=BWIyLxq2ygkrdwA0WgCZ7pCWuA4a5rHm3m12P0S7SIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tMFVT/OExP870Zn8RNgKU33XJ0HAY4DsCgniQiv8vIVEfGj+B4Q4JxtbnMO/v4mlyEAsbR/KDiUFKiNCVSK/0xceY6Pdv9pqoYrRN2/0g1P+DGJE4VADdwZzxqdzmC0Cze5WioysG53mN+xWo+G5AS39KNfZjJSvv5S3DXb9FpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bddhko94; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rpc0HN4x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9Ms0E020634;
	Mon, 16 Dec 2024 09:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xiUwXAdbSFQYJcKrYsFqMyjy2RtfIqNLWrbQLG7mRyw=; b=
	bddhko94dMhdlQiV2oBUNxz2hvsbZZukv3P7MUYUMemBqnpbcKBagvzZd+GdRAKo
	0PiftzOn9VwmD9lSitz8mgfPmH3iy+FdqFM/8hWtT1pou8YPPCL2gICmtb2lV6Tk
	TvMqFo2Ujsmp4Tk+ZPgQLK7MyhUV+LCUYFs/y7ZyFn8QpfC4AJeeIx/nWTZt/xr6
	d5uGlchvj1CKngF3+z8hPfFcEqNJGN6wwG/JBzGnnb9SndaUmAC1xxR0uhyLbkxZ
	EMwIoAdU3OPA/QcwHFmZNA67/hPVM8WDx3HVrpM5mIrf2XHrWFweYLyNRsD3b20F
	gHoIYrP8pNYSY3y/GxaGtA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xatsjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:22:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG7tBFT010966;
	Mon, 16 Dec 2024 09:22:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f6rvx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFhV0HXbW1ZV/TCTDcW+dZ7rsaFRinxJ38TCp/IJknhG95ae2d4PMLN9RNLYjscL07L5z4njaia35PE2GO2gzgIHx55Ul8g0NbIz25z8upkMNmSUksPwR5r1ggyLkisgs0+V4UFeah5ZMMFbxR1gGF7cOEiuc/WnRB5cKOlXLdi84YgaNcbwkC1GX3ZFX0F94Zof1WZq/wF8EQ28YnEL2lhbXEjMYf48uh4Wzn74BHIDC6q6kd1M4HheFK5gNxN7dn5Yt+vf9jhiCdF3w9y+euvQGmov3vsCt4NbuzQrx98Z2WvfeLC03WY2WrgqmD5nEDo14a414sd+a4mELp823A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiUwXAdbSFQYJcKrYsFqMyjy2RtfIqNLWrbQLG7mRyw=;
 b=KbfSBXMTyL0tM1pSheE3EFMyUBi6bNng1zeFVwqt6MlXBdNvPUJh4kLukokN6lC5DFHPsjS/Cv5QOUlxv9SS1lD+rXdnBjiJpY9fcK8rHHN6jJ/IxdSFIyXzNpFBXj1rHEoQZPh6QvS9++gIXBNRUF7XRVI7EcoXTFm2/qLFMYaqm/PJ0782kGQvgO8aq/S/OVdMB8bP6w6nWGk6IFXKpYataGpko4UvOq1cYNOL0Vt9/p8A/Dgp/Oa6bG98H8fqc1f9BPWFxlJKLn4D7+DomeQyNYMFRe4aXD18sNFlMCbiO4ijEI1ryzB6wy5E2ZhYi/3vV/yUyqb7pnHk7AGMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiUwXAdbSFQYJcKrYsFqMyjy2RtfIqNLWrbQLG7mRyw=;
 b=rpc0HN4x8GO5Pog2YOrJlbkniD3oqExGwLPh7z0wFtC8yKfkJvWPf4ephtgAcH4cC5QXim7CvJPOC4xPFyVZW9uQzUhyuFopEJ6KSmANykGLqCvb270PnWExkQtbqokKaNK447bQakXIk4Wym3kr8RdoZMCUVAV2x9q+VVpnrAo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6047.namprd10.prod.outlook.com (2603:10b6:930:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:22:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:22:42 +0000
Message-ID: <859ef104-2665-4de3-8d28-7652035d7fbc@oracle.com>
Date: Mon, 16 Dec 2024 14:52:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid opencoded 64-bit div/mod operation
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Arnd Bergmann <arnd@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Boris Burkov
 <boris@bur.io>, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241216083248.1816638-1-arnd@kernel.org>
 <b46ad433-04a5-47d4-9cd0-84f4ab3b86e5@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b46ad433-04a5-47d4-9cd0-84f4ab3b86e5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: df1fcb43-cb54-4a84-e5ed-08dd1db33164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGxURlpUWWhsQVJDU3VidjQ1RDdzQm5zaTgrMGl3ekVtMlE2OG84bUpVWi90?=
 =?utf-8?B?dXM3ZjQzVFBsTFp6WW0xSjZBMWh2SDl0NG9QbUg1cktLemlVVm85RHJWUDBr?=
 =?utf-8?B?SStCSFpkMGFxYnMvQzVtbCtndy9pY3poODBJeHNuVW0xMy9BemMrU1VIREk4?=
 =?utf-8?B?b1p0c2t6N2dwOHlENmZaUWMxNTFnK0M0a29zak1VTUtvUnY1RW1jRzlrOFNZ?=
 =?utf-8?B?UW16bE91VEpEVWorUVZQczNIc0tzTHlCQ1pWTDh5alQ4SDFDMEltd0tKVHdI?=
 =?utf-8?B?TkVoOUsra2lyM1o4bHg5alVHYjF0d3M0WDI3UzZTZ2R5NUtYMzAxb2Jwc1I5?=
 =?utf-8?B?Lzc5MmVEUGU1VmY5RGhGQnBkMVpoZUtxN2xQVTNlNE9SVTRzQU1oNTY2b0Fs?=
 =?utf-8?B?MVdpZllrR201Ky9zM3NjUFBZVGVpSCtJWk9MRDhHcEtWLzJ4VDBvNWM2NGpS?=
 =?utf-8?B?NWp5dDFieFo5MmZPbGgwT0ljbjdRL2twYTdkRUhxMlBUVndKM0ZaeUZFck1Z?=
 =?utf-8?B?TWd0QTYrZmxnVCswVXYzQzg1b0daQVZiY0ZIcjRaM0ZQZmdFN0lDWHBXRjZh?=
 =?utf-8?B?MTV3TUVoTXVYNm5PVFRsODdUSjJ4enl6QXhIeG0rNk5XRTYwV3FVWUo0aHpn?=
 =?utf-8?B?K2NRbExaaEIrRkpMN2UydDM2ZTNPaTZPRnhIY0Y0WEQ5bW5GVlh4WWtnUXlR?=
 =?utf-8?B?YVZtTGxFaHdsUExReUl4MHgyQng0WUY3amNwdnd2VmRqcWpMYlpiMGM0YU9o?=
 =?utf-8?B?a2F2SkNGaUQ3RTdJajd6Vlc1VlpYcERiKzRybjd1Ti9ibHg3RmlYUEdzZlR6?=
 =?utf-8?B?N0pkalUrc1ZCTE9xL0EyS2diZVNtZk1xRmtDUnNEOUNsbXhWSW5sNmJEZzFK?=
 =?utf-8?B?aVh0MHNZay9hL2NNSU51QTZhR05pc3RyWjRFN2RTUVUzekN2eEV5NEUvdE42?=
 =?utf-8?B?Zjd2OXpyM2F4SEg5VXBlelA4ZDB1eHRvck9WMW5YVEt2SXI5QjNKSmF6Vzhk?=
 =?utf-8?B?V1RrNnlVV3Joc2tNay9wMzR4aEdweVpMalQvY2NCQTRDWjZGdUNDQnMxYTlu?=
 =?utf-8?B?Vkp1VlduNlVTa2p0cVVtNldBa3p0SDJ4eE9ndFZxWlV3WGxJTFRqRG12RDZU?=
 =?utf-8?B?YlBwMnZyc0NVY1E5MUZMN1d1bUt1dU4wWklvR0hNcXdZZ2Y3VHhmS2F3ZTIr?=
 =?utf-8?B?OTRXRGZtRHlkWjdkZVJjQXhvekVIeFJ6YkcydDl2RGlIUWtEM1hqbUNDZ0Z0?=
 =?utf-8?B?WEtkNUFqdHE5QURSMWI2U3I1S0Npb2owRzBmOUE3TUVlb1RwNElPclZ2SVk3?=
 =?utf-8?B?TWpVU3p1dGhva0hPY1hkVGR5VytsQW9jNHFKSEZ2eVErUXFuUk9MeHU0L2o2?=
 =?utf-8?B?TnJJY1dzYUc5L1k1S2IvR3pja1h6d2ZwSkRVekg0MFl0dFRQM2tHVm5TODQ0?=
 =?utf-8?B?RmVrRktYeVhZSHN5OFBPbmtKNEFLdDNLWVUxdU5OT2FRMFQ3T1lSTjlzS1Ir?=
 =?utf-8?B?bXdnSDVDNjA3VEhjaExScm5Ga1A3ZzZDTC92ZkdoT0ZjS0JuVy8vVXM5TlVJ?=
 =?utf-8?B?S0NqaUdCTnFlZUY0VDAraWtVTlNUa0dFVnFVYmxrdWc5Q1YvRlZwYVZZbEpX?=
 =?utf-8?B?NHorT1IxQ013WlpFaVVtL2I1bjJzYmNIcnRFbkZsZG13ckthM3A4dVZFREtI?=
 =?utf-8?B?R3Q5Y3U0ZFdiTU1yamRic2dqNmZ1Y25DUHFtNklSV0N1RE1Jb0gyenFyYy9C?=
 =?utf-8?B?a2E0N2s5bTc4NlFoV0VzWDduMmhJNzdteStUcU9Wemo5U0pkeDIvcWg0V1dk?=
 =?utf-8?B?Q0hwUzlFRTVoU010MyttcHg3Njh4bEMwSnFVTlJLbWNiVHJsbHkzNkZLT2U0?=
 =?utf-8?Q?LJQzc0qtD3+uU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXloRnBVOHNEZjRLaThZUk1tVTZ6MzlnWEwvUStRa0dzVjlLUzc2d043R1hu?=
 =?utf-8?B?MXVydzQxcmlxdm5ncUVPRDZ3cWdoUEJhUmF4bGxoRFdLbXIzNUZpMzhRWkYx?=
 =?utf-8?B?NmNIN2lGZmt1SmRPZVJpYkwwdEtMSEhUM3R3RjBYKzlCQ2ZvWEVUZjlmeFVI?=
 =?utf-8?B?RHEvdHhPdFBJdUEzNWVraU91VExDWVREdktFUU5uWStJSUNVRmY4VGFHanAy?=
 =?utf-8?B?ZHRxWGdraTZ1NFYzZlk1d1lYM0V1U1pKS2RaYVU2RmVRTkV6RStiTkMzc3A1?=
 =?utf-8?B?UXd3RUxXaERYQmppa09vN21qbWlMWEFoNGlsSzQ1cjk5V0FtK3NqWjVjZWRy?=
 =?utf-8?B?K1liV3owdkpzTXEzSlVMUGgxak5KUXZlWGt6SnAxYnhVenVVWmV3YlRCS0Vy?=
 =?utf-8?B?eHVsK2I4bWNpS1FZQXVGY2kxbzNWeXRFZm9pTndHblJ6Yk1QakI0ZGR4Wllu?=
 =?utf-8?B?S1lnZ1lUcDd3ZWhkTTBwUGo3K2NYYW95OFIrYWRmTEZ6cWp4K1FrMkxZbWJF?=
 =?utf-8?B?QXFjd2E4ZkpuWUZiTVVLSzM0Z09XcVVtcllKSUJUa2RPUWhrR0daSndGand3?=
 =?utf-8?B?NW9xWUthaEpQQ2dvc0l6VmRZVk5LU2NqRk9LeFYveWN5N2xrSitqaGdkQzE3?=
 =?utf-8?B?NzlmUkExK01GdzhkNG9GU3ZMWkZDbHNUWWx3dGhqVzZ2Z1hsZStvWWk3ekxy?=
 =?utf-8?B?b2VXU3dFNTZyOEw0K3dmY0JWRU9EUFcvcTlvWFRmQUM5VGlITmxIV21pMFlt?=
 =?utf-8?B?cE8yS0JzM00xQXdxckVQRjZxUS9SOFBXb3RYeVkvMWUwQ2pOV0Q4cTJYWmhQ?=
 =?utf-8?B?Q1BZTmxmNUhMMlVOMUhPRjRPbzN3cmh0TFBuNTBVU3dtZkRzbFNwTzRFZytx?=
 =?utf-8?B?Z2lPbGYza0dNZ0JuOE9KUXFmdFIvdjN5ZVpuK3piRUFFaW1iTEdvazlJbVhQ?=
 =?utf-8?B?dTY4Rlh3Qy9WaUJ5bDRlaktMU0VUTzFPaERVMlJLUjlQVkhzNGxXekJrK2x0?=
 =?utf-8?B?LzZjbVc1eXVtQ2NDZExucUQwWmhMRDVtcFBMcFc5MDhRQjcwbFBLUGxOcXB6?=
 =?utf-8?B?bXpmY3ZsdldGV05UQWhscldOV1g2M3REQTY2ZGFjRTJDNWJ4UTZDK1h5OTNr?=
 =?utf-8?B?Z1FyaDVpNGNQcTZqRUozVVNQTHFIUVFtSzhnRS9jZDRkNXBSeDVrY2RFZGdN?=
 =?utf-8?B?ZWFVQjNrWE9CdCtEcW5TOHZuYTl1U05yV2xGUnNZbGNZMW5GbFdpOGluYzhJ?=
 =?utf-8?B?QnVXT3krekJRMktoVFhINnh2bFBhd3RET2lVdjdBNm5sR1N5TVBsNDhHdlBR?=
 =?utf-8?B?TXhSb05MWXRDSGF5KzJ4a2lsUmF6eE44N2xMamplTDZkVEhTVlMzRFdQS0d6?=
 =?utf-8?B?Z2hwbWh6UWI1ZXJub253S3kwRUE2V2tWOU1zdGdQWDN6NWpEMFZSWEd2bTZ0?=
 =?utf-8?B?ZmdUeFp4R0dSbzZsM2Mwdm5qamlRSHZJZThJdFpsazZMTitnU3JjNkQzQ1Ru?=
 =?utf-8?B?aXdoVXpDb3oxNkc2NlVZS1NFRDRTeDBzcSsveTVFSjBDNXY3V3JIR00wM1Mr?=
 =?utf-8?B?T09nREpkT2pCemY5NjVhUkJYUVh1ZjJXUXVyaWZKNlh0UlJTeWlrU2JhTmxR?=
 =?utf-8?B?czVuZThaa1Z4M0VRSlpQTTczWXFJWmpydUFyR2tPZEk3b1lZVzdIYzd4K2ll?=
 =?utf-8?B?cWNzZ1FsS3crblhTOEY3REllNmRkQWlaNUhzeGNYY1dBNmVhRmg3aE9Xd29v?=
 =?utf-8?B?SEU0ZWlKQ0lhNDA1cU1WU0dVNUFCUFBuT1hzY05xU3doSGwrSENIL3ZNU1lP?=
 =?utf-8?B?L0gyMDBoT0JHRE10dktYR3d3WXpjaVNkazBVcG5GRjkvRllzQXhzdVRrUG5h?=
 =?utf-8?B?MFcvSnFiSVRKTU1iTzV0T093UVA3a2dld1JnZ1l1K04vTk4rc2hKbVFDSlg0?=
 =?utf-8?B?ckVrdm05MGFRR1E1RW82dmNza3VXNHlKTWpBcnNCVlJnYllLbjdGQmk4ZkJC?=
 =?utf-8?B?b3lsRFVCMzJacWZ5V2hRaGlqNDlKTVdRbzhwTUZWQ2FNcmdocTl5WW9KYnNv?=
 =?utf-8?B?WjhpRnQvbTUvTFpGSEMvWkFnZ3dXK3JMSUcxWVV1akFEMXpkM3pweHdSZmtj?=
 =?utf-8?B?b2lSWWRsbFFOc2xsaGxzS3RmTFFVOFZwbUFsVjYyai9HQmFhNGFSeGZQRWlL?=
 =?utf-8?Q?jDc4tYgybmaNr8kZGDVFkqaXV5Yf6sfjA1es9iHmVrcG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yqJqCRLB/tzsTWWfhDuygdvNpWzLgZf/uFbks5dar1pPnp6EkECu287XNWRQgadCBg8/1qe6JAX/ar6JNFakTENGiqH57DTV6jEV90+H6NZftStDTAS4tAwDrEmjnQtznaoT9XHgqsL7wq5PL8lqVDTfL0xqIyLrOhuNwVSvNVwsIJuUeNv91gSDxQRsiX90DfzVAbtUzjp/C+5/EE73Hlj/fE8chFUUoFfb5QF0J5j1GrWlsQztPkMAG+bosLyAx/lLQvwM8UHMFUTLcXGMuXIAgBJTIJWawZOL9K2Lz+I+hEHz25IeWoikuRxNUuNQnwFqn9y87D71TKUV4d7iY1aR2Pn/GQCzBwUAfrS+r7sqkTiy2gTIZtNtY9JkFaRVWIr3dpiKZgYRCADvX4zGz/M++i15T+6EguBc+IS16oPPt5k6wNpyo0QyBPXcxg46MffOxRtqOLrw6uFgrarKuOiqccqmAJBRo65aXk6XNl5Ls7BUWdiv0e1bquXhUWDDDwE5ChBGaLE7F16lrQl3e6Hgdg4tLJ7f42e1j9inpAdnaB5CUah5oowCtnT5tUkdBvkKKWp/in/KrrklZMecxCpLhjyt5ZDs3fVtB7KORzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1fcb43-cb54-4a84-e5ed-08dd1db33164
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:22:42.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YYH6wfIcy/EhiMUfFb3+62ztSr5xyk5/TG9oQ6z7lTZ4JUMsM2amAuppjWiXGVKzdMxPswBXfW3hOinsHQPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_03,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160077
X-Proofpoint-GUID: BBkR1SDmYFRMQSvbbu32chSw0UDbCaqw
X-Proofpoint-ORIG-GUID: BBkR1SDmYFRMQSvbbu32chSw0UDbCaqw




>> @@ -1433,7 +1433,9 @@ static ssize_t btrfs_read_policy_store(struct 
>> kobject *kobj,
>>   #ifdef CONFIG_BTRFS_EXPERIMENTAL
>>       if (index == BTRFS_READ_POLICY_RR) {
>>           if (value != -1) {
>> -            if ((value % fs_devices->fs_info->sectorsize) != 0) {
>> +            u32 rem;
>> +            div_u64_rem(value, fs_devices->fs_info->sectorsize, &rem);
> 
> The original check is already bad, it's just a IS_ALIGNED().
> 
> So a much simpler solution is:
> 
> +            if (!IS_ALIGNED(value, fs_info->sectorsize)) {

Right, this was also in the review comment by David, and the change
is already in the local work-space. I will be sending v4 out.
Currently dealing with some rebase issues.

Thanks,   Anand


