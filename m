Return-Path: <linux-btrfs+bounces-9258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12C9B7785
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 10:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382931F2372C
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF8519580B;
	Thu, 31 Oct 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ETUISeuA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kFvRTE2o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9C131BDD;
	Thu, 31 Oct 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367030; cv=fail; b=bl+srf/WCEiPIk2RZ6wM/LNIFm7ToId7yB4wCWdY/IH0ZLRvU5gsIRx3Yh/uo9HmwOZqRBSsNM9EFxF618lDhG0hT4jjd5CCgr88JX5c+WIT/xnks1HaBBCnd9jbNGR5jRPxPN8yKx7oC+qB0wxiaosx0Uuon4H8Gj6deVVbrOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367030; c=relaxed/simple;
	bh=GcU38RC47eFmHrk26X/hBDMBlELP/guVadIUSmRAW3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNOsfF5OMRSk2XaHRyuhfbvExhIxztbPKLkQ6BnhjSS2TvxCAyIWGUu+teRWFx9OMGFo0Gg7UY1MNZcrlMKqNUyjzmqTnoHglnKSkk64LkD0fijOXVx3pBu2YgpH5kKJcyR/W03VHhBPPKjjb5gXgLYXDUtn2/IjGjpoT9zU+00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ETUISeuA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kFvRTE2o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V8u0vL028811;
	Thu, 31 Oct 2024 09:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bw/fwW9qyCRDBQT2ZqhOoqr/AW/Wt2Zt07Lv2amXAnQ=; b=
	ETUISeuAisHMrDOpGcUkiluGipOxW2APT5E1K5ACmBh+vh+RS7uFlVP5aoQg4Avp
	5UOWXeIeSG+8CnIfmoE/Q1NQL86Dv2+Dj9v1Shv0cdR646DiCF94IeFMBhlHH33f
	emhz1bQRrZ1yskrzJqekpsJwAJiK208EBwu/qcXoquh+JpotoPj8vUadKWU4Ja/i
	zoRepdtPwp2XhXHils15XHlYm5uZ+6a/XbNcCy3MofSzuLL+QikJIH86dRoDWpn4
	h8hLdoPZEY5ZUAr8ZePxgg8wwsghCZq1Qk1X15RX3fjtasSDfRATtsuJH19DdiFV
	rCy+M4bqhJqKvJO+zV/zyQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys9x5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 09:30:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49V96Sn7008545;
	Thu, 31 Oct 2024 09:30:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnec5t3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 09:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiXimzoCooUYaQVUvYIwT0wxhES01jju6a6kELgOPusCyn9oHAfV0eOKTBCpqEN/hwgtpaNdkfPCBN4nhR8PeZ5NnEj8Vu3SvF9gHNYnbbRyW+ZNmrl1HbKTBVEo2t5nOzS947/+0Tef2QXkoo2nuMKsY2z3HyR01yEKDsLVSgzeqPeuOs3UmQ7rXd2UXA680Sc2pvV9TV+9/4nx3/yiZhCkESbYFMeQqhfTRNUzoaX7n31XPXH+E2cztnVJ7kkOZutQUaezaI7dPdCUv3nW2u2DxcyhOnpNPtCWlfY7vk1amPbQ5XWsiYbYczsTj0QTniz3T/o/ks55EBrwZA5fgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw/fwW9qyCRDBQT2ZqhOoqr/AW/Wt2Zt07Lv2amXAnQ=;
 b=Zw6qdPfi7SKmsgor6W/KrUWqCTE+gpL2MvMcGJrBmV4JlAlS4js/G1wvGOgVyVbW/9yCxkYzQpUjNcyfCpYtnQ6u1FPz8uw007KBhxk1oNTAkyA/EJHoQp6eS9VBp9/H5bhVCr9zDQqZMdmm/yox9fodaJpGVEE9qYHI/cyV5Ij3j2FmTblhaGi/lSDF4LDB1E9hCTPGcch1eTZOZP26S/V5LvkjWcgJ4JpY88944gFWq1jz3pIkk8nTIcLbFLQXcxsdgcWRvScCVshQc9HKzHwlNg1IgZfFlBtc8yIr+eQ0iYExz++V9xmxSOEQ+kyGyNMWITStWsNrB10CrGL8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw/fwW9qyCRDBQT2ZqhOoqr/AW/Wt2Zt07Lv2amXAnQ=;
 b=kFvRTE2osWJmQcAlK6uwz3Unq7A7r8YKPPyUxArpdrAyk055Oy9MHnt3BHUxk22UWRUt2k7COgrDLk/KgP/yG5gKnyfSzrpLHHUSrxFYCcb2MqLKPuhl+FbzF/3JSEjwcDyokDMJ16/+MsO4p4hTg+hD4G0xQp5fJ2Kn9CmI2FA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4339.namprd10.prod.outlook.com (2603:10b6:a03:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 09:30:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 09:30:02 +0000
Message-ID: <a4181e94-6bd2-4580-b277-aade713452dd@oracle.com>
Date: Thu, 31 Oct 2024 09:29:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle bio_split() error
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
        Johannes Thumshirn <jth@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, axboe@kernel.dk, song@kernel.org,
        yukuai3@huawei.com, hch@lst.de, martin.petersen@oracle.com,
        hare@suse.de, Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <1cab6d9b-8493-4baf-8a44-602dc035ded6@stanley.mountain>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1cab6d9b-8493-4baf-8a44-602dc035ded6@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 914d35f5-3cb7-4160-24fc-08dcf98e98a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0IwZ0xZTmJ5dWY4ZWhSQk9jZklZOXFzOGlWQlRjY05MQVI1cFZrZTNnTTYy?=
 =?utf-8?B?aUtqTjlyODFpVk9taFg1UVJVYTNyWko2VlgyNWtTYWNRYi9YNHVJczNabm1q?=
 =?utf-8?B?cWl4cC94VDdEdFVMQmZ3T3FoTDN0ZFMxbWVHVVV1dXRYMzJOZDRncmoyZktM?=
 =?utf-8?B?aFJkS1hqb2ZPdnU0d0hPcmU3SUxHb0o2UVJheUY5dXRDS3ZqYTdvRFpyTDFY?=
 =?utf-8?B?ckJ0blRNOHlGbG1ZSnVIV09Pb3Y5NHI2d2ptVnBXWHdia2d2Rmt0QlZPM0Ra?=
 =?utf-8?B?ZnVNeFAwdElGanpzUVNtR1ZYQ1BZaGs0VXRoai9WWndETnJ0bHpmWmpHdjQx?=
 =?utf-8?B?UUFEelpPVDdIODZKaGJONURaYm4wS1l6YXhxTXJlOWxkT0ttZnZjR2E4cUlK?=
 =?utf-8?B?S3dDdzl5NUk2UEF1dlRab0tvbUlaaFZoeDE5MWRIRWJrai9Ba1lKWm9GMHIv?=
 =?utf-8?B?MjF6KzZqZG5hZENjK2pEVTNBTElrblRJSnpUQkY1VzdlZDhCaHZueXNxT3c1?=
 =?utf-8?B?UHFISis4SWE4dmpwb3daNWlBMHdjbHVFOFdHYnRONGdlKzFGTVNjVmhIUkVm?=
 =?utf-8?B?Y1Q5QVA4VndVcmQzeWE5WE0rOTNqd24vNXhlS1hPdEZCbjJTUm5LZ2p6cEpZ?=
 =?utf-8?B?K3JPZFM5N3REMXFyQUI4SnJjbFBXYkZxdXMxWWZqZDU1MElNTUpjbTAzK24r?=
 =?utf-8?B?bitQM09ldWNoNzBpVWVCU0h0bHB4UldBOHBSeDlaYktvL3VJQjBzL2o3ckhn?=
 =?utf-8?B?MnVMTlczVWdQcWJNWUlOMitxdFFsV0Y3RGJQWUdnSXBaNDllN29ZODdqZHQ4?=
 =?utf-8?B?T3hCZVNFNEp1WU9rWmdZbnpzSWw1N3drMnBpWTB1S0o5eEdsUHhYMzBkVnNy?=
 =?utf-8?B?bjJUMjFZYzdjRWZuQzZocTFla0dFRjlaZ2tRMGRrajNKYzdkSlhlUk5tTnF5?=
 =?utf-8?B?QlFXMmhNVDVtM3BSVUZxU1FBYmVqaS9mVlJaV2tPMTBXaG1oZFpYbldwamRH?=
 =?utf-8?B?dU1HMmduelV1MWR1SFZUMkFMYlViYUVqODJDTEpOOWNoU2dkNzFXSGNtVkFi?=
 =?utf-8?B?eUE2eDJvQjhRUjZKWXozNUtVSVFTbjczRzI4allqRFJTTWtnOXk3b0t5TEhi?=
 =?utf-8?B?LzU5TXVVS2JYV2luV1JOK2o2bE5nRDFQSy9QWGpZakw2MG5XVjFhOGdSeXE1?=
 =?utf-8?B?NFRLNXU2Z3lIOVhEUUdqYVNxL3FZTlZuT0VzMG02c3pJUjcyZDRHbEVkUU13?=
 =?utf-8?B?M2xteU1FNjNnRGdUS2ZPMkR2OEs2Z2t0RE9UTmlKR1IxNWc4MkVhNk5kYTgy?=
 =?utf-8?B?N0prQzE5MFlYcGNYQVp0WUZBZVRMNmxLaDRsSWIxSWR4WEpOVExYdEt1R0U0?=
 =?utf-8?B?NURHM3NCS2lTVTNCOXFJb0ZwQm4yRU5RVjFBMFYwV3JWQWEvaUNSL3NPcURR?=
 =?utf-8?B?bHp3dEwvanRqWmVUTW5icXo1QmJRdjYrbms1Zi90ZmxnenlUcitYLzBXY0hU?=
 =?utf-8?B?b3NDZXUwbm1TSUxEcUt4b0MrcHdkdmpoUDMzbDdxSHdISjRzMUZ3ZGlaN2Vu?=
 =?utf-8?B?SmRDWmpiaDA2UUxRc2IxK1RMTEN4SlFQQy9CNnljTVJSd09BTXBKTWxaSlow?=
 =?utf-8?B?MDU3V0NQVVJIdFVyYmZxRTFRTThKTENBSERSZGVCM1E2bDNFNXlkeWowalNm?=
 =?utf-8?B?RStCcmpwTlc3WDhRWm1jVFcrU2NvdTY4aVF3YmFzeE5NYjVTV2FYUlNKYmFQ?=
 =?utf-8?Q?CTW+YybZrLCnEJAIMSbMks+uVZ8oKkaAesTqFEX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGwvN1pXZGdwS1JwRFJxNHhzOTN4OGVzKzVrTmNqZy82cUVkQ3IySThrS3pQ?=
 =?utf-8?B?UzRHTDlPQStBR09xZ0h2aENHTzBjQ0dhNFZkS3ozYW5UUE5iSEh0alo1bnl0?=
 =?utf-8?B?azBKcVE2V2xLOVpFTjgrcFZsdG5nRWhLYmZCbXA3b1lWVjdyRTdPKytDUERI?=
 =?utf-8?B?cXM4TnJRNVFDSkZGZTZlWW9UaFRJNjhvcjkyL1h4RTVtaHNLdXU2N3ZlMlVo?=
 =?utf-8?B?aW12ckVwTlJkMDY2UEJRUm95aXBDSGFZY01IS1ZHYWZQQXI5aG52UDc2MTBN?=
 =?utf-8?B?aFhCMlFXOVZ2ajk2UTdPZTlpNTV3MjNjcTkxdHh6cmlEVlU1RU5OV2xhanM4?=
 =?utf-8?B?ckFuS2pIOEd4M2ozWTN2M0JmamF2bi9ZcWhuRnhwUEJrM09kbXh5eHNGRVN3?=
 =?utf-8?B?d0YrM2xtVWdFdEVFb1Y0MXcwQ2dCQzVPR1F4VGJzZnkxSWtBNHR6bG84ZDdm?=
 =?utf-8?B?N3ZIQVBFTE5nT1g1RmN2UjNzVURKbXhHWGNzK0kxWW1na01PNnljREoySVZW?=
 =?utf-8?B?bUxQd1d2RTB2aFB5bGFTTnVEV1p4YmR5cFh1MkJZeW8xRVA5NEduREY1bU9a?=
 =?utf-8?B?ZjdKbGNINGNHcWkwOTNOblpMRmJvcG1weUw4cGhVTmdVK1VlK015NUJTRjJs?=
 =?utf-8?B?VUxTemlGSGtJOHVCcjVnc2hxYjBCT01nbyszc0NCbEdZVGl3dFRxMkFvU0Vz?=
 =?utf-8?B?eEhDZjh1ck1iLzNzU05selg2ZTlsVXpNUHVsamNmSHBLYlhkVjJaMkhnQ3pN?=
 =?utf-8?B?QTM2cmdOTkNuVkVYWnVJWWNCRDBlZWR0QUhJN3BBT29SOU10YmZ4UVdzY2RX?=
 =?utf-8?B?cSswVks4eVVhdlM3alBjL0FmUGMzbEkvWmF0SmFpdzRpVGVRMFVxcm9WQTJs?=
 =?utf-8?B?L28vQk1aMlh4cmlRL2hCM2pvNFhKekZVME1MRTBucmtOWUpPUURCQU1vOExu?=
 =?utf-8?B?R29tcWdEMmlJWmU2K1hpTmpjNExnbGFhcHJJRzQ2TDgyT2NKcFpnZnhHZnFh?=
 =?utf-8?B?QlJ5RlhrckpOc1hiMEdrQUJVTnk3NWpBMDdiMkpySUNzYTF1STZnbllpUS9K?=
 =?utf-8?B?M3JLS21xZXVOR002UktvbEdjUEdkaDJGWHRyZHBneW1oaitUb0hmZDYwak13?=
 =?utf-8?B?OTh5TDM3UlVBYWVPd2gveFFwSVA4eWVwYkJjUHBPbVFjSzdNOHdJRkI2MFlN?=
 =?utf-8?B?eis5Z2dhZmN5Ry9jbUhSd1FYa0FDZ3ZQSDZCTitwSk5vRThZcFdUNUVvZm1k?=
 =?utf-8?B?aWQrZXhNdXhoZ0N1YkpFUGF6ZWp4ZUNvYjJxVGtwWE5RbllyR01LQ3o0OTRr?=
 =?utf-8?B?RVBSVk5lK0l2clQrTU5QSlEvMEYxL2ovV0RZTktFRDFUUUJZODZYdzdsSmRW?=
 =?utf-8?B?QzlzdE1GY2pLRjFsM0lpeUJWdWhrS0ZvaGNXWGpjTFVhSGZGc0ZpTEtGSnNv?=
 =?utf-8?B?ckVyRE44bVE3dk91UUwrNXZLTnJEKzltUlNpQk1LL091NzQ5cXlxck41cWVH?=
 =?utf-8?B?MUVuUW5ycVhlQXNEL0Nvb0V3MlhvVmxGaGtWdllkblp0T3B2blR4c3A5RFVq?=
 =?utf-8?B?ekNvSVdaOERGRDdodS85dWlxdW1vQUlWcm8xeWk0a1hFT0k1b3o2aFp2STdQ?=
 =?utf-8?B?bUE3Qzl3MEp0cVVzWTNSRU5KTUZJV3NtbmExeHBFR1Q5RFFKeTRFWTRkUWxq?=
 =?utf-8?B?ODkwNmI4S0pzRjdsaVpiQ1ZyNWdvcElwNVZFT2NlcWEzRU1uMHQzN1ZSUytT?=
 =?utf-8?B?cEo3NmpNZnlONzgzei9HbmhQL3FDeDZmSElsWFp1Rm4vcDc2Q0RkcjlMaWgy?=
 =?utf-8?B?cHQ5b0U5WDVFeHBReG9nc2ZqV1EvYjhFTVczaVNIcEhSQWdJa0tMWmtjaExK?=
 =?utf-8?B?MjlnZWQ4Q1pLOGxoYnFEeExTSEREU3dQMlgyNDRqSUZWWFBTb1VzZ0szRDhC?=
 =?utf-8?B?WVZxR2NzRUhoT2JYTVlYaHhNUVFCVjNDa0RpOU41VSs5Nm5ma05KejlBeGNO?=
 =?utf-8?B?NDUzQWwzSGppVnJ1a1pEaTFlZy90aVRudFpFNEZpZlJ5VWE4RDc5cGF1aDJu?=
 =?utf-8?B?MCt2WTM3UEp3NzV0STNOdmlBZTJ5Y2kxdWp6azdsRnRDT0J0Sm1tWWR6N1pT?=
 =?utf-8?Q?e+bMDRB2Pt0lHkDryvLKjPLM5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eg9WhI9Rz0AeCw8xYFs5W15TBbebf2Jsu6Upngmi+Wht2TXiRX/ad1qpbh8gELWdI133dmmUEnqAUfyJuvUnYoalXb4/1Tzfvsm2p16k6MMzGcaBWN14PtD9I+ZClC0Loks+tc0Wf3MjA4BVxu6c7bJiW3t0EsxWoxOSYg1Gd2yNH/y+nvFkk+zTOwqyqenUsAcSKW7Plqo4wzrfrdGYUgCtndMixXcIcFpf19TYawNbob7Speo1FAxmNZQhbub5vZ6m+elwkqH9Rop/e1mgaZdvikDQI/5puwPGLb1BkWkZpAf065VokGjdz8uQu949lpUqlmN7pAnubLB4pqRTs0DbzK2aqwKfUq14fvQBrdiMvRnt4QAJiLzHZ8TuFur9TLOrQPNxA4Jo80GlJ+aRdrBjkiapC9un/R4IfAf27wODMEmNZx3c4lvok6MwUBDC38CxFaWeZmuQXS7/fGjmQojXtkgnY4wxYVrFzNrE0prs8KGICFVp+/yf8Zk221lQqXjsQZcg/R9WpkiEr2aCH+lZtv68gW9Yies6PQDrN70usaUdcrvO0/oVkOC41CjfVH+47AgwYONSGVuidykV8ZXidtKSgWO8cQQkIRNTnCM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914d35f5-3cb7-4160-24fc-08dcf98e98a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:30:02.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twkwjv521+rUM6uFvlfr4MdPWNrAmEU0Gj37SAQL439JRS68nsqcBYEeu426AP+/bKkA0ogRF1NJ9v8qHuvwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310071
X-Proofpoint-ORIG-GUID: 6uHCMYHKWpfbBqSe7aEqWkHHn0Xk4A7l
X-Proofpoint-GUID: 6uHCMYHKWpfbBqSe7aEqWkHHn0Xk4A7l


> 852eee62d31abd Christoph Hellwig  2023-01-21  687  	map_length = min(map_length, length);
> d5e4377d505189 Christoph Hellwig  2023-01-21  688  	if (use_append)
> b35243a447b9fe Christoph Hellwig  2024-08-26  689  		map_length = btrfs_append_map_length(bbio, map_length);
> d5e4377d505189 Christoph Hellwig  2023-01-21  690
> 103c19723c80bf Christoph Hellwig  2022-11-15  691  	if (map_length < length) {
> b35243a447b9fe Christoph Hellwig  2024-08-26  692  		bbio = btrfs_split_bio(fs_info, bbio, map_length);
> 28c02a018d50ae Johannes Thumshirn 2024-10-29  693  		if (IS_ERR(bbio)) {
> 28c02a018d50ae Johannes Thumshirn 2024-10-29  694  			ret = PTR_ERR(bbio);
> 28c02a018d50ae Johannes Thumshirn 2024-10-29  695  			goto fail;
> 
> We hit this goto.  We know from the if statement that map_length < length.
> 
> 28c02a018d50ae Johannes Thumshirn 2024-10-29  696  		}
> 2cef0c79bb81d8 Christoph Hellwig  2023-03-07  697  		bio = &bbio->bio;
> 103c19723c80bf Christoph Hellwig  2022-11-15  698  	}
> 103c19723c80bf Christoph Hellwig  2022-11-15  699

...

> 852eee62d31abd Christoph Hellwig  2023-01-21  753  done:
> 852eee62d31abd Christoph Hellwig  2023-01-21  754  	return map_length == length;
> 9ba0004bd95e05 Christoph Hellwig  2023-01-21  755
> 9ba0004bd95e05 Christoph Hellwig  2023-01-21  756  fail:
> 9ba0004bd95e05 Christoph Hellwig  2023-01-21  757  	btrfs_bio_counter_dec(fs_info);
> 10d9d8c3512f16 Qu Wenruo          2024-08-17  758  	/*
> 10d9d8c3512f16 Qu Wenruo          2024-08-17  759  	 * We have split the original bbio, now we have to end both the current
> 10d9d8c3512f16 Qu Wenruo          2024-08-17  760  	 * @bbio and remaining one, as the remaining one will never be submitted.
> 10d9d8c3512f16 Qu Wenruo          2024-08-17  761  	 */
> 10d9d8c3512f16 Qu Wenruo          2024-08-17  762  	if (map_length < length) {
> 10d9d8c3512f16 Qu Wenruo          2024-08-17 @763  		struct btrfs_bio *remaining = bbio->private;
>                                                                                                ^^^^^^^^^^^^^
> Error pointer dereference

This analysis looks correct.

I want to send a new version of the bio_split() rework series this 
morning, so I will not pick up this change for now.

John

