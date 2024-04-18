Return-Path: <linux-btrfs+bounces-4408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522CF8A93E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85240B22309
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C156462;
	Thu, 18 Apr 2024 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tn1rzyBE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s4EKyNzu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A03B1AE
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424743; cv=fail; b=YMmEWasyO787RLGw0n71PkkEq95rkGoQBZQoI/YlClKWtEhhKuh2unO+eRDpAFKXIRr46jPAnD10XRXT8NdXNlnUGtNhdvoG+UdBxYq3CzMJG+PaTSP298od82pCuR/TLp5gLuqLmlOBEOm+qFy3a1x62ucv7dVdh1eZOIIIRBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424743; c=relaxed/simple;
	bh=9bYz7ZQ+dXLINfbgkePPBjZ/mVpXsFPPSAYXI9wU71k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QlsvY+DhtGn0Dukx28jHCveVW3t+2/QHZzQADUQLMV+XGKCDOxJdabIxjwnyDwxUXvQ/mY8DWMRjx17tTr4HUAtPiYeqpVKET4j4tjbb58711zAgOgyHD23ssRqjfe8IV15jxmshdTNMvi5aZjuPSNAPwr5JCP7xk58Q3UvDjWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tn1rzyBE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s4EKyNzu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3x0Eb010140;
	Thu, 18 Apr 2024 07:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=nNiIkp1t+O5js+QKAgI5OrwCsGFLNEQUo1DKH7kb8FQ=;
 b=Tn1rzyBElIOwXB/8YHQ9u4oaZePON6AjYMhs9wUGlW7Hw1Nl/FBnzYJMt0Khx96qZmCc
 8XxsroiTWthxQAIECBLIglodF9IEmfQudiPWTozDZ+Ja41XgpIFrSfDaHkNFUYwbnuKt
 Nm30lJTwnGrG0HiwfIcdFsoIN0hA+eBsfov3Ofmvc6lMAAuxBn/207nEtGMc7shzwTNS
 SD5QAJWZb3ToZq0LBphoycrZ2Iz9fjnkgDufWovvumibPrn86sA3Kb5yyn4Gn0uXNu/f
 BsTaZKamxpPp+/6VO2UsK/1dLJrA/JoNro7AqDc7mtBy0I0BVas+vp8K1d7OmJySjiCe Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e9u6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 07:18:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I5WtEP004330;
	Thu, 18 Apr 2024 07:18:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggg8je1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 07:18:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7HlMZ5ad+5+UQ/dHXTlmzKOZc75zUK2E1/O4BkyS5fejcCwOoHy57nqyuTBIalPq1mJsDYkf3zFSwkkOhGHTGmaUqYwMht0Z2lMOgaWfVr/sf/mozzTL/py7Bzpww48hhEdzyP52LkmUpKu2GuVzeChQg4aufqYS5z90wgQR6jui9bq7JcW1p4oX7pJYnXu6x9pgrTEeaZdpYKsdawlXwliooL0Rkzi2VIWyx2jmVy0SQay2o04mqPejyIM4va7JyWWVF5zI5fG5tBhrkvkTE/E2f4M0zRxHnFe2F6RaXOWlU4MuCmfae5LD1QdYxJUyasNKHSFA9xK2/xbv5bhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNiIkp1t+O5js+QKAgI5OrwCsGFLNEQUo1DKH7kb8FQ=;
 b=g0VbEUk+OpImVWs0l1ofwfcmikMsWSg3r9fkXf3S/DCyIHcSXJUshLyD84w6UACMy0oI+Wd9aoxk8Qf0eMnHe34DZAWYHXOEhMavgbZ1grfQzS3o6zLTpJpk3yMt9K4Q3rPXRFwFgT5v5cj3CxthHKbZ1XYYchNxKYhQpm25/0rPbeemEMUnoZA0WvWcD3yyVzOz4m4RnQiTs8yQCSEH/HN8YusJnzeWfIs/ZackvBiVxnVmITKHJKeAs0h9WQfwIn6Wh8z1x2SOtok5mLAXXVtX0SCyHVtjW6AhR5i1hESDN+JuOkUB3tckzTNJbElFvSAV31lY4gwAibC14aBfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNiIkp1t+O5js+QKAgI5OrwCsGFLNEQUo1DKH7kb8FQ=;
 b=s4EKyNzu7R9hgCBkSmPGTbrV8DqDkZW2TpASZNVnMFiIdliMIMYCbSC/0JaWEP6Ujq4QuFmpavuu6nYrpIUbX6k2DpOF9j65XXvaks/psux2cIX6iL7cQmeDl6A5cohU+SPv2M36GpfnhLPQ0Jw1QM/wSt2DP2BJdPNXsADzpRM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4404.namprd10.prod.outlook.com (2603:10b6:303:90::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 07:18:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:18:55 +0000
Message-ID: <d3a646ed-ce67-4380-82f9-920fcbec5300@oracle.com>
Date: Thu, 18 Apr 2024 15:18:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: report filemap_fdata<write|wait>_range error
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <80c3c9ccb6e7ea366d88f0e5b2798f5bbd3b381c.1713234880.git.anand.jain@oracle.com>
 <1556267cd2fd5f2d560a50b4b169ec4d58c95221.1713334462.git.anand.jain@oracle.com>
 <041bef79-743b-4726-adee-9c0ddf332e6b@gmx.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <041bef79-743b-4726-adee-9c0ddf332e6b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: c11166fd-d44a-44fe-83a2-08dc5f77ceb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WSlnZCrbaPnVaToxj8rlbPk+AblYYCbenz4lyzFb0SHnZeF8MsacPvYz7Vl+mAPUreekSYe2Fmf5O5/6L+vRwgfmMz11rhasXqH5cewXZtgJMIpi9r5L453eveYDCIzDI5UjY3RQipnfNx8dNUm09UF215E5Pk47kCQaFcR31h2vw2CzIbmdOJJqzc2nZ4ILeqo2JX3ikFfHsd7a1xzenWIEKt7K570iwvx+e2PFQgbeyGoUTiKai2UID7kCpVt13hXbMB9o/vuO/8H82wv8dQoUCCmCdnPIkoyISQKzQemRDiB6cmkI7yVSaRJstCSdAmHbya4gR+WGZvjCaG/RfvNjBv74+wI0lAzN/wafNOJ7HeREZ/B67qqUwPfpKNv0HJT53PZnxXhhWDjRgJOAOeOMRfeMrkXkccndEpSj/NGhziNsFc0foeP5QcAaUfD2/ukg6LO/mL+jDKGa/gNKVxUOteFNN4PFqiGkgJLD++I5mFr0yIlchtyg0GJiGqi63BJX1SLirs6E1QnGP8IPT8/P7fj55dN8UaCjfHng6OYle1NQunHyX+xhRiPVKClHggyIR3GWKA4t+ou2X0fHVE7UHw/nAxpxXDD1jvwpGxoZ6FWKbgnjtliF8Yfy3cu0wMpY4WoW3kIAMGykRqjY4CuuZTXtVce1MNs7FKYeWzQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjJPdUVnNEx5ZjBUT0RXZGlEd3Z3ZkljZXVkWHZwaEExL01YRlFBUllzemdk?=
 =?utf-8?B?VnJ3OTFOQ0RXNlVvdFdiOE8rTythYnhRV1NPUlpod0x4WCsyL3VzcTlEOXVC?=
 =?utf-8?B?VE1sOENNVnJQQTdOY0p5dU1Oc3JOMEwzbnpYS2xDblhvTWFXNExvdDdQSUg5?=
 =?utf-8?B?N1dnc2llVmFLRWJ5Rk9Rb2U1bWtsQzJSNDZ6elRVRGFrRC9tVnAxU3doeklX?=
 =?utf-8?B?UUc4c0hkZ1NZS2h4S3dySFZBL2pnZDJOWmVPOWFya3JHWnFnZ1BYQkhtQ0pM?=
 =?utf-8?B?aWFGWktSUnJUc3A4dU5oN3BBK3YvWFlsYmhiRWxlM1c5VmVLdEFMYytJMDFT?=
 =?utf-8?B?T3dUcHZZRmFSMmJZbXRVM2dEUjFQUXMxRTlHYm1vK3k5d2xZT2tCQmZhbWgx?=
 =?utf-8?B?dXZqaG0xVy9hbGNwaEdCSmxnYnBmOHQyN01oVGdkeU5QQUg0NmNyNWRMeXdt?=
 =?utf-8?B?T0dtbWRFUS82ZVRyVDJnWVZFdlFGSkJHM0ZYL3J1SWd6a1JJY3lnUHRhaHh5?=
 =?utf-8?B?Y3hWWlp6T2VvTnpaN0JjVFQwMFF6d0ZZNUJIMDJza1JISFQwaEV4S3ZRRGVk?=
 =?utf-8?B?RklQN1pRbjVHQUJiNG5neUNQdGc3a1FNSktkbzh2T01salEyQ21TWEp3MjI3?=
 =?utf-8?B?Syt4UEFpTGM5LzlLd3VPWkpTa0tpYlgzUFgyUkh4VFB6bFhud1I5VGRsQnY5?=
 =?utf-8?B?SFVvWUNDUVgzRHJzUTJGeFV6eUx2U3d4R2J1T3V6S3ljK2x1WGlzeHpldTYv?=
 =?utf-8?B?WFFZR3Z3a3R3MVFIdFh0ZmR6bEJKcXVxUG05TlU0a2lCRzEyd1o0YXZleXQ4?=
 =?utf-8?B?T0FjZmlwUGJiSmM4WS9EZ3MwR2ZPT2hDMXhEV3F3c1Nmd1VBVE1HVXRnTkt4?=
 =?utf-8?B?cU9EdGFBTVhnaW44ZjBVTkNiWW55R0V3OVp2Rk91Qll2ZE1TTitFT2lVSEhq?=
 =?utf-8?B?QzFYanBiYmFNTytNVjdmRDhhck9SNk90S0I0RndNSWxqSmxsSVhwUURFem9v?=
 =?utf-8?B?b0ZFdFJBNForVmZrZzVuRkhjZXF0L2Ywa1MzK3dQb0pOWHZqWTZJREJEYXRu?=
 =?utf-8?B?VnZCNVZ1YVhwTWRBUzFHcThXWFVjVUpsclpRQ0ZiYXRkWFZjdEpMOHFmY0tJ?=
 =?utf-8?B?NGg5TU5hWlFrL256L2I1WG1ldlZVSytwdEo4NWZGRVFaWThpNk80Y0VoRXBC?=
 =?utf-8?B?Ny8xQldPUXEwQjl0RUYrMFdSV1Zad05jUjZmci9Hc1pldWUwOFB3M01lUjN4?=
 =?utf-8?B?TUVDcEJ4TkNxUVRoZWovV0RHV2FWR3phZFQxczF5SGpTYnpyTG54WW5hejdW?=
 =?utf-8?B?M08vWHFJNFhQb1VsZVpJYzA0UktrcGhCMzdzUzMyL1h4T2dqQjJsdU02c0No?=
 =?utf-8?B?dFRtNEZDSDJJTTlJek1jeG9wZDJOV0FwbUs0VGpoZ05uVmxVUUtwZDYwQ2pX?=
 =?utf-8?B?bE1IcGFTQ2pyM2hteWVQeU9tc2RCWDhqdll4TmVBb2xEbVB2VGI2OFZBS2x6?=
 =?utf-8?B?NDdBNFRwYjRBbVo3RTVzSkpYTHc3M2F4YU5xT3liY3ZSd29maGNGYTV2M0lt?=
 =?utf-8?B?LzNBbjR3ZnB0K2FaRCtVc0dreUhIM0dScHkzb0VBbk5rdkpwemVWbkgwOGs2?=
 =?utf-8?B?MnBCMXRtcE41cnpzdDVDRXM5QnpCN2lOckVmcklUV2RvYnpFcS9FRi9xbDVW?=
 =?utf-8?B?OW1GTXBUVUVrb2FWaTBRSHVBSVRIWjlMSlQ3alBwSTZNUmx3ZnF5OVhTRU5h?=
 =?utf-8?B?ak5SQ2tkdU4wTC9ldHlTSnVnK3VKNmVqZ01sTktHVHRUM2wvT3NTYUtBWTNQ?=
 =?utf-8?B?TFFIRFFVTUkzTmNiRCtEZTRVSTUwSFVqbFdJWkVlNGZsZkVTOHJ6OUtRRy9r?=
 =?utf-8?B?RytWbEtuZFIzM3VrdVFyL2MzdFJNbittUlRmZFU4VGpZbFBlQjFTYW81TDNK?=
 =?utf-8?B?N2k1clJOM2VuN1NtaW0wdWlXbG8zNGpORWpacmJUdGJzUDFIQk5hVW02Z1NB?=
 =?utf-8?B?UDkvRURCL1VIbWEyTk9ESDZ6cGNyRnZYaGpaMEd6VlNLQkNBTmFpR0tleDly?=
 =?utf-8?B?MEM0bEhaYW9DVy8yYkExTkdFL2RUOVFwRDdLN3hoNjN1cnBJQ09HYXFrWG5s?=
 =?utf-8?Q?1xCfWX1YsrPRpwz7fOp9v8prY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	acXonoTRwApNd92LwMz5IsnDGr+j+3vj+fAzHTKxWz7GfXf5iqOYIMO6bAZOuX4GD4BFlFPE3J1Rbjo40xBnT+aY7UQgS/lxzMHIcddBwRPkKT08X1WRMDGr3W/Xn7frF5a57fp23IkAJGaYy4XJVEiT1aRj9wL42wh6FV6EVduZbaRb42Q3v+mGNpWRgyQgguIOV9Zz9cGg3425GxAN7j8rg/0kEFpGf2tuO3GtLR/uLjicnwXjthnNGFbECvVFmqxnCJEZVgX90GlGPqfPjjLcDk3f9ERuhTM5bGXthrTL63SEfwXD7iiTP4vLTu9VpNywse6WteaEKCOFHZ9s9LXf3SOvhNv+7uehFW6dStdDRehHA8EpjKSfhZK+3BJqFcpJpd5TQmHVFgbmg8Mek/MnnEu1ye8PBcblSa7hg7bBeaHhOgVSv3lEhli54yirPB0REblzpQ9eCVXFXLr95PP0V5aOg5GR0n8m6YeOVGnehh/fjDClFkyTg42ywcK3tiJdLE1xKEZnobfSSbTq62SRQ1q3nfBixJ2RADQ1HifNeZJCUy4mn2nkNbVZ0JHYF39pFIaoVbjXseU1YKnbGb8eaI78HTRQYZa3ctc1ej8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11166fd-d44a-44fe-83a2-08dc5f77ceb7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:18:55.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efu0WEnvwxIoBy+MtPXwmZ4wGrEoVuzHhgKcdoIuuWjAlBPnpOzZqzOsGN4uUR/vGqB6jCxC4OhZ75USmij7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180050
X-Proofpoint-GUID: oWCD_u4T2sdSCPQnACf4sKZIrx0NpkB4
X-Proofpoint-ORIG-GUID: oWCD_u4T2sdSCPQnACf4sKZIrx0NpkB4



On 4/18/24 14:30, Qu Wenruo wrote:
> 
> 
> 在 2024/4/18 15:44, Anand Jain 写道:
>> In the function btrfs_write_marked_extents() and in 
>> __btrfs_wait_marked_extents()
>> return the actual error if when filemap_fdata<write|wait>_range() fails.
>>
>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Looks fine for the patch, although I have a small question.
> 
> If we failed to write some metadata extents, we break out, meaning there
> would be dirty metadata still hanging there.
> 
> Would it be a problem?
> 

I had the exact same question, but what I discovered is that the
error originated here will lead to our handle errors and to readonly
state. So it should be fine. Further, if submit layer write/wait is
failing there is nothing much we can do as of now. However, in the
long run we probably should provide an option to fail-safe.

Thanks, Anand

> Thanks,
> Qu
>> ---
>> v2: add __btrfs_wait_marked_extents() as well.
>>
>>   fs/btrfs/transaction.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 3e3bcc5f64c6..8c3b3cda1390 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -1156,6 +1156,8 @@ int btrfs_write_marked_extents(struct 
>> btrfs_fs_info *fs_info,
>>           else if (wait_writeback)
>>               werr = filemap_fdatawait_range(mapping, start, end);
>>           free_extent_state(cached_state);
>> +        if (werr)
>> +            break;
>>           cached_state = NULL;
>>           cond_resched();
>>           start = end + 1;
>> @@ -1198,6 +1200,8 @@ static int __btrfs_wait_marked_extents(struct 
>> btrfs_fs_info *fs_info,
>>           if (err)
>>               werr = err;
>>           free_extent_state(cached_state);
>> +        if (werr)
>> +            break;
>>           cached_state = NULL;
>>           cond_resched();
>>           start = end + 1;

