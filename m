Return-Path: <linux-btrfs+bounces-9203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20979B46F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3BA283EDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D858204F70;
	Tue, 29 Oct 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QqroQIm4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dXrcFYsv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CC1E102D;
	Tue, 29 Oct 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198050; cv=fail; b=BVv+hN6QkG7rDqRr4emVZEuzxSSma/4mVQp+jwU0mdaSFpYZ9m/4r3VIlhk9H5qBOU2GBIw2SgnXrzZlpvoPShUh8TLUN1Vo41ai5LxPPjIlJ/tfm5+g0Uzsxqp7O8+iIFfMxRyRP3gSYmOLBICWhFwCfOxPZIbp/PFJ4UYFGME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198050; c=relaxed/simple;
	bh=9+320+F414cnX0KTvMq7iVLo4r1F1hnWANqKnDMwiug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PFCiD72TFXjeV0QcTBe+waVJK8Qe8/W2GrOOogtxwd6rZqBx4gDuti6vf1BEdbf+1VeJWWeMPapfu/9+8cFc3EfBFqkq87foifMZLlDxzuEiAHESH60qFyr0jcUvVpnrsErmJtmUulTH4b1VB2k7mRtCyBMBHnOlp6EVEsaf+hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QqroQIm4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dXrcFYsv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7tfFw021219;
	Tue, 29 Oct 2024 10:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A2GFmrH71zTUYbldYypbn6BhDURvYYfQlzYaimnt91w=; b=
	QqroQIm4NkFWfAwYL+X7Q6AAqZQgcdxHqcjsF6GSfv9k/3u4mysJBwhjeRlcxhqi
	6BSI/wF2gBfN4DhAvFm6FF1ufhy3fU7ok8/frhKrrsVlgbEVN7dF2w5lVVDhgSzG
	N0ctXoSi9tthreCoQKaPAtCOJNmDB0by/y3KeWLa9qVEmDEcLgIIO4lS5WsLosyQ
	b/h98/ANguaIaes7Jz6+L90otsVwXwuYZnwLUePq3ypaMDl51BFJ94GyL+qe03wE
	laaRom12pD0Kx+7EWfvYeqiN1D9LhLPfHykm5D+2csNVDLMoPUQaeP92fUk6GEV1
	OdsMA5FiHigFOX/kV4pcNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys51rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 10:33:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49T92nLq034839;
	Tue, 29 Oct 2024 10:33:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd7f7e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 10:33:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwmnyxrgEsUBRSgLyg85IRMm8sjfoj1bVkVu5ix+159rlK8DvKWvgEmyTIyYCFxwUsWEJdOYhqkIFBUBPc4qRXrt1cTLe3j4YFjhjscqo7cE8Q43O/92t0jDteD7qjlukgxmnkukCYUZqEql/9Ji3y855R6djeVfPCcNKR+UUtsDXB+f82Wp3B7C6xIW7rUDTRJLb+g5fz+Nz7b3vEizeS/zb9eY6eHB5HBBoqvEJEBdrX1MV4qnGM4Hy8qtSUFkgHLBI1tfDquF/9RFSzr9XTjyVRGgs0hwfrxc6fatQ8uTJHiUFhRVEisI4exNYCdtRUXnDTv5HKpCYEuZSMQ/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2GFmrH71zTUYbldYypbn6BhDURvYYfQlzYaimnt91w=;
 b=q0mjPZ2nC+y6dv+GjigqwR9UweqN/q/iC23prnaFbj/wyD7xx9M3iCa3Qojqx8lYnrslS6vfU3j2hx1fY6ici+6lS9VK0s6mY0KzMNoFTvPe77pXQDwE9WJ27QyvlfvvdwBgQYfw4qf+zgoE/r0GxnKlMtHZtyLdyH8F/tuGJp6RS1yt5bjmcVYMSNcQOuR9pPmaZcYyzBsrUpK/yHCbCXtaX3HaU37udiRlo+2xBqLzn/qaWQIHVc/9TUk2NveEZgiJgy8yfCnajzMkRgDTm8GyjLciSZbIBnTzlG6rCtro5N9TxmPcpCVwBYMOZlvOWGNT9sff2geDLJ3f+fHzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2GFmrH71zTUYbldYypbn6BhDURvYYfQlzYaimnt91w=;
 b=dXrcFYsvyivoCPQbUEEyddQFJ+1A+mNgBznZgJ4O8QQ2NF9ATrVkDCp8jLdN4MhyVD1OtHWHFLGEdux1o22KfU21ww7vwYY3tGh3SFN0MwucCMyI1GuRbDw3Lfyx/HMjerz/puFRV0+X+FOoYTJfOvb7D7C5x8zXRbr3lqYlou0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4316.namprd10.prod.outlook.com (2603:10b6:5:21d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 10:33:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 10:33:42 +0000
Message-ID: <45d406c3-e837-4de9-8311-7f7f4a84b95c@oracle.com>
Date: Tue, 29 Oct 2024 10:33:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle bio_split() error
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com, hch@lst.de,
        martin.petersen@oracle.com, hare@suse.de,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20241028152730.3377030-1-john.g.garry@oracle.com>
 <20241029091121.16281-1-jth@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241029091121.16281-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0035.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d556880-31bf-4bc8-0aac-08dcf80528de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enVLOExYazFPQlFoT3UySkt4V0pPdmE4c2R2eGxySERRaU11d3haNzIvSURU?=
 =?utf-8?B?NFY0eDExQkRKZVQrNTFLQkJTRVJDSk1CWSsrRGgrOGZFWlk1K3IxelhZS3NV?=
 =?utf-8?B?N1hpWFpIZzgxKzFYSk50Y3NZYTc1SEpUTEpvdHU0Y0RnUUtHL1J1TC8zVGFo?=
 =?utf-8?B?cSs0S3R5TXJ5MXRhUVl5WHFFcjYwa2p3RExSQ3p0U25RWGpmL1NZUXE5S1U0?=
 =?utf-8?B?V0pFVGl6QVZ6Wnl0d2xwejVScXZxZitZcWhGbFpsNHdhZXQ1dVJIeTdJU3Yx?=
 =?utf-8?B?cm8vS3g1dXM3d3hSZkR4YktZb3RxcWNEd3RlblVmTnZRQnY1c3hqcEtkUjVC?=
 =?utf-8?B?VUQrcXFqOVRhVEo0SkwvZjAvZXRFdWlmYWJhT0J5ZVU0d2lLdk41L01IL2Z6?=
 =?utf-8?B?WjdYSERjWTIwa28yQ04raEJtU0lvVjhKTkNmY01wbmUwUU04aEo0ZkVxRk5O?=
 =?utf-8?B?ODdVNlRUb2l1U3dqdXZWS2U2cy84VmE2S1ZBalhJSVcxZ1NtSlNrNHNFV3JX?=
 =?utf-8?B?YjcvY1JVSEtKblIxQmRsamJyUXZpVGFrZTdXS1ZGRXhoYW5KT0FMdWc5K1VM?=
 =?utf-8?B?MzRWTkpRNWFlK2RlK3psanFmY2ZoWk1zMEpvLzlqbzZCSXRZZlFWU2pHaTFi?=
 =?utf-8?B?NnNTMDJGR2FsWUViSEtCTGJacnJSdmNSNnVOK2dUK1B6Y2lNdW4xcXZlUy9w?=
 =?utf-8?B?OHhNdXM0NGtrMThieEFnK3pXcVY5MkxwMk5FVXB3RDdzalh2MjVmS0IwZjg1?=
 =?utf-8?B?L2h4Lzk1NGMwaGh6dG1QUVMxU3lrdTZ4bkFGZXZDc2NtdlRlMTBxRjNmUzFF?=
 =?utf-8?B?cTNzT1dFZjIzU3hKWEE5TnFPYU1xZHozNUZYOGM5bXVNeXhMbXRIYkg2TzNT?=
 =?utf-8?B?T3BvVE1MRlQ5RldZb2lYalpTTTdEMzZsWXYwVVFMRTZGY1BpcEFTbWRTNFo4?=
 =?utf-8?B?MENnazhacEZ1eVdsWmgxbkxzdE5uNEw3WVNIenBPTmZxSXVHN0xQL3ZBVGg2?=
 =?utf-8?B?SUpyb0FBMHdpeTNYVisvM0Z3TXNjWE01aVNEK0YxV2g4bHZJcmRhbkQ0TlBo?=
 =?utf-8?B?RHUvSVlDY2FkWStNYU9YemhnQ0VLbzVLNnRGa0J0NXkvS0V5T2RoVmR1WE9B?=
 =?utf-8?B?bDZ4VzYrMTltbmQ4TStab3dzdE1JaHFLU2V1R2h5dmtlKzJaZWNwQnRFUS90?=
 =?utf-8?B?TXNIQjcvcFdaRloxUStmcGV5aG9PZ3N3Rys3aS9NRzRxdUNUa2R5QndMVkFW?=
 =?utf-8?B?WXI4cGxUNHVBdXZnZmVZSmhNZVdSY0NCdzNiUDhOaDMxZ1RLUmlvSFl0QUxw?=
 =?utf-8?B?c3M5WXhYT21PTzNJUDliVkhBdUNOeHVTc0pWVjBzTUk5TTdvZXdveUJPeDJH?=
 =?utf-8?B?R25EQkZ6OGttYWlKZ1BDRkZ6aGNodFVTVkdTYy82enZObDVNUXdTcFdOVFFl?=
 =?utf-8?B?Z1lKZDZPSmNaVkFkdm5DZEV4dDdiekxDR0xyYWtvZmJhSGRoV1RKMTU2L3Vo?=
 =?utf-8?B?YWRpRXQyQ2o5dnZ2YTg2bnlBcGcyTFJkMzRTcXh3a2tPRHdtTDV5aURuZXBD?=
 =?utf-8?B?U2F6WHRFaFJZVE5uWVlZNDF4ejYyVFBKVjI4RVhHOG9CV0FHcm1zRHVHRjBj?=
 =?utf-8?B?TDBmUWY4bE0xYjNINW1USGhld20ySE5QbjV3Uk5jbmNZTHhSMk1zRU1ITElL?=
 =?utf-8?B?NXlTV1I2OGlvenJ0VG15QkFOckRGUUZpTHVkdVZqeFo1STU5djBhWXQwOWda?=
 =?utf-8?Q?iF10JxdD1QW2vHKylA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnJpaWwwZnVxaGMxdzhSMnQxOXhBQzRoTkpzWUpiTFR4RStRMUVlR0tYSy9w?=
 =?utf-8?B?RUI3NjZ6bERzbTVNYXMwamw3ZE54UXVHQlluRTkxNHZrS09uUTZMTDRSTjFz?=
 =?utf-8?B?M2h2OHkrclg4ZTFjRVJtbTV2Q2tFaFJiektUcTd6QldSSjBIOUI0NlFGNzhY?=
 =?utf-8?B?NU5yNkhDZGxteUQxcVRRNXBha05kMU1UaFpEZzMzMU9LeVhkMTYrWDhzbW5Z?=
 =?utf-8?B?MUc2Y0tGU2lHWnd2ZHVyNHgyWnJZclQ0bjZoakJIajVRdDBxaURyVVZCakxQ?=
 =?utf-8?B?RXp6VDU1MDlsTFV6OW1OQWk0MlA4WklDTW1ISUpMMjFVUWZITmdvdW5aM3Ba?=
 =?utf-8?B?ZUYybWFUcmVUVDdWRFRoL3RzR0VJU2ZFT3hYajkwS040cVM3UzhCRGFLNGdH?=
 =?utf-8?B?OUlQUW83bWxodTBndUVvZzBJNys0bUpnUEdtNzZwcHNic0VLSjRwK2pKZkZ0?=
 =?utf-8?B?NHYxQzd6SVRMTXFmdGg5NWNDckxVRFJxZCszdDYrYnB4Y1FxWFhCTXhDU0xH?=
 =?utf-8?B?cENWYkt4UXgxcDdVUDMxQWp5MitUeGlnRGJCUXdYVHRKSUxtUnJ2RytyejNj?=
 =?utf-8?B?YWgvQXZLTk40OXdRTjlZWTU3UHg4MnNqTWRHd1NrcGt1V3lUelR0YkUzQmlP?=
 =?utf-8?B?THhyVmhKaHo2Q1FkOE5RdTVHS3BiVXdHZGFzYnJOU2JJZ21wMjFEYTJ5QSt0?=
 =?utf-8?B?UFV0ZWNPUFZVZzdUVUwyOUhFaXkvTEFvcHZWelpQOUJlNEtrNUlpMXltczRi?=
 =?utf-8?B?am5uS0tESnNwckFRU01CblVaQTVjTlpmZWtkaEtnT1pxenhoYnRURFlKQjdm?=
 =?utf-8?B?UlArdXp0cEdIem9VUFhZVm1HODNKemwwQzN3bG1vd3J6aXYvenZhWk93eldJ?=
 =?utf-8?B?bXJ0ODVlbWMrMndSK1dRdkdjZFFhcm9KTXcyaG9PRWozMzBkWit6dm55RTlt?=
 =?utf-8?B?dFRCS214Um1SbW9mNGFkOVNxc0xrS1YwVk1oV2xPcnNFVWpFbFZFREFkbDc1?=
 =?utf-8?B?REdIYTh3aExWRmtQSURqbDhrRVcra3dNeEpCckdRVUV0Uzh2dTFwaUZpRGFr?=
 =?utf-8?B?cmFqamFhTXo1b0N1cTVUcHorMXM0L294empWa1FqSXI4T3BjU1Qya1J4Z0Vm?=
 =?utf-8?B?OFJGeHJUSFpaM1QzemE2WnFjOFh2TmxEalluK1VmbjVFWk1wVk50Mk9ZenpV?=
 =?utf-8?B?Y2NMeTJrcTFUOVViY2l0dktvbm5hMzNIeFEzSVV3V3pRY0tyZi95L0t6MDUz?=
 =?utf-8?B?cWlGZVl2ejA2bWdtZ2ZXSmEwMDcxZG9RWDhuTU1JYjFhVkNydnJsOFVlOUVi?=
 =?utf-8?B?cC9QNlprYitWcGVJcXhjYnJWUlBGNStkMSswRU9xc1F0TVlrOTdnSE5ZM09q?=
 =?utf-8?B?MzFHZkUrN0JRZUpvbU5aa3BSV0RrT2tvT3BycHVHcVJIWCt4NzZBU3p3L3BT?=
 =?utf-8?B?SVhSbElnSHZXYlZsNWF0UDA3bFBLWXpZaVBDalFkWmtSMlU1b2x3UzI2TDBG?=
 =?utf-8?B?Y3p6VEtCUnd0cHVzWExqU3p5RzJGdEkyL20rcHAxeld0eno0UmxIdnQ4dGVB?=
 =?utf-8?B?QURsR05peXhVdVBhQlg1QkZMT09ONytkSk5sMmhWLzlTZWhjeE54Q2MxNVFQ?=
 =?utf-8?B?SkxWN2NBYndxSUVhVHg3dHpDbGUxQnA0ODVWaXJxbzBtRTNheEVaN2xwYXUy?=
 =?utf-8?B?aFpQdktqQ3JSbjhuWnYzV0NGVTcySmx6ZzdsU0N0OEJJTlp5RU92anM1RUZm?=
 =?utf-8?B?UEZDN3dnekhIZWR5bHkrRUZ1alR3VDJ6WE00WlhWZk1UM0loUjdOQnk2Yld6?=
 =?utf-8?B?ZVZJMHprUGlNQm81NjlrdHgrSXEvcmVya1lBN2hHZmYrS0RPOHVWT3VOWHdw?=
 =?utf-8?B?VnFDQzhPS0FjUi8yTiszTUh2YzdxYmNDRWV1NGFMb1M3VTM5Mlk3dUVTVlRV?=
 =?utf-8?B?b3MyT1YyUWxCR21jamhKb0crQWhLc2tweXZTRFhiUEk0dGpKUHdpZUxxTzJD?=
 =?utf-8?B?QlhpZWdPNUZGMXFUNzNER2hUak1PaGVyMUdTUFpvZnZZb0pxckFqQ2hTejNL?=
 =?utf-8?B?UytZWk9USGFVS2M0VjltSTVvcWxBaURHUlg2eUJ0SzU5OEtYVVNiN0tpYU1u?=
 =?utf-8?B?MTVtTExsWWhtN2dvUFMzR2ZsLzBqLytCQlg4RUZkRXFONVdLbnU2ekVtb0N5?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v2MJI7M0L0PoJDg64a9uc6jCXcdoGwGuJFLSqGZTTIkauJgDvDDL8djr9BvUgKVK0jRDnXRRrWoH6HCNtOVlhD2Gy6n7FRAYQ7bg1Yu/lSsPgffXQ1egPddoA6Jo6YYSDveqC2Nv+U3Zhh+mJ0H6+a0ew64GQSP5+Nhw0xtln+X7jCkpO6ixAuCcV0Vq+xpaXstfXI5JLzTw2Was9udjuiKalLBd0lN//BM+aTVjiaplxgc+L8KJgkeCIACKX245eEjuA90n/B5vNdHu6k2ztf4E3PnkJCBBEJW44byegN4IL8tfDlHxtbFDCUmVHgGETrXk+o5y8KhvRpMVG2rYnAFmEluET6SJpNcaI6IpPg7uGZAqwDPsskcknCTTjVbRq+ThVBMtS+bsnilL6PwK5xrvL8SAu7tolaTPgzSTZOOQr/tr00lfaqOTSZUU6rhLK8bCVF3qe/0w6rsExiCsSWlgUy4ypE3W9PVyoxnPGZnzLJWCWVeq313HBCHTDjaJRjhwGIGXwKmbHiBrO7N/3MKXSvEa0/rEKWcFDDhoRWUV8MFrF7sYXbPYX1acjoKiTf7Wj94wLm9LibwzQCQB1UQ6HU5E0VU7OGjNxZ8VYKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d556880-31bf-4bc8-0aac-08dcf80528de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 10:33:42.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrNmodjmIyA1LP/kmxq68H+D4nD+UuCdds+I0IMAiRLHqlf7xEaDStPDbAzJ4skH/y2NL8y3eLYADyikCmyQfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_06,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290082
X-Proofpoint-ORIG-GUID: tkXf1lUW-9lHSvfu8vcqcHrX1M_cLTiu
X-Proofpoint-GUID: tkXf1lUW-9lHSvfu8vcqcHrX1M_cLTiu

On 29/10/2024 09:11, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Now that bio_split() can return errors, add error handling for it in
> btrfs_split_bio() and ultimately btrfs_submit_chunk().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 
> John,
> in case you have to send a v3, can you please include this one in your series?

sure, and I think that I will be sending a v3

Cheers

> 
>   fs/btrfs/bio.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 1f216d07eff6..96cacd5c03a5 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>   
>   	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
>   			&btrfs_clone_bioset);
> +	if (IS_ERR(bio))
> +		return ERR_CAST(bio);
> +
>   	bbio = btrfs_bio(bio);
>   	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
>   	bbio->inode = orig_bbio->inode;
> @@ -687,6 +690,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   
>   	if (map_length < length) {
>   		bbio = btrfs_split_bio(fs_info, bbio, map_length);
> +		if (IS_ERR(bbio)) {
> +			ret = PTR_ERR(bbio);
> +			goto fail;
> +		}
>   		bio = &bbio->bio;
>   	}
>   


