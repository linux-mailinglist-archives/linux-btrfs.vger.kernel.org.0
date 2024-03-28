Return-Path: <linux-btrfs+bounces-3709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB1488FB18
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FE529213F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A227E105;
	Thu, 28 Mar 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YfBbUnND";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GEOWMKL5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3937C0AA;
	Thu, 28 Mar 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617548; cv=fail; b=ErMvqbZlFb2sfKOlUV5AJGWau55gzocU+OxZN4IgQl4dlg4deEDow78w4wCNhOtBn+vMj7bIsAHImcOkTfOPTdt8vg2InkpN2cGPNKrXGXT4vdTMOd5GP+UHqtsJ4q5mP0z4chmBO3u1fu1XEacdCrvM6Bgwi9WYMZOx7c057Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617548; c=relaxed/simple;
	bh=6h+oDtOENAFbrrJt4rBDNO5TVjFa9MZ1bbU1yZVsyw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SJZYHr7sLzDfCian8QUofga81LdzwwQP29XtLQP72WtvWWMyok91g9otGak9/YlD0Tud/gy424ugjTNRojcyQWYpMWwlnHJeOlXHdQXYQcptW1CYMA60EpqP7lKch825fxvobHQF0/38mfCEbawlKcbfRWiGXKn4ELQgOYWf12Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YfBbUnND; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GEOWMKL5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8x1nY023188;
	Thu, 28 Mar 2024 09:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0A8C28Jsb1hwQtpUz5IgOQeFnEj9OZQeJFncI4ihTlg=;
 b=YfBbUnNDE2shWXTMAnyR8UV46OEklGMDMkVLGHS8xVpJuvwlZlxjIA3/uZEcKlE7o0/9
 6gaaL/ze5ykuKFLbMHhWT0KmCx4ZZNBIcCX5nX9xM5N/MKaGGnVrzp+Xn/rYZUOM9xl5
 4XcsKp4sugF5J83vv9DOJ6fjSe3wvgGPJusvlBDDyUzm7sybjuibnGQqZz+S0TJnr6AV
 AQj6ErpcGLSV/NqKYLnXEiFu0m1TEiSRqCmozfFiLUHiNy0c+A2gvlQTa7IaFMwbfYD6
 Nhuor8E/KE70BB9GuHkhCM70h0hRZJZiAnJUX11qtZxQKAj1Eh4Bu51ok1M4cOQiU4Bf LQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1nv4988n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:19:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S8lXOc014451;
	Thu, 28 Mar 2024 09:19:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9re2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:19:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQI+sP84Xz8d2NVPXJ5Rvh5THakn31gROL5lPE8y0i2MpVm4pTKt09zvInY1z6NC7JxLqCHSox1bnJLVDYA7C9vlmM6C/2D8pHdaSelwgY3aFEdSTbdP7kBOsoWWBwzoq1Qt9OMiMR6rh7obtLnhCSuhs3nqXdkK7OG+TxMi9X+kXAfeioK6wBogqtZPpG+9j2tMHJSKuu3q4UNZTnXJUEJLG4mKjOxch0nbLp9lzS6cQbQjfeFFufyio41ewMLPSXgTChQTFbpxYXpEhMtFWmy1u1LRU6fjC3KdO0ftAdTD2LC3ymEBH/ZXrdfSOpwrC4DaVBF86GSL55hevsdKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A8C28Jsb1hwQtpUz5IgOQeFnEj9OZQeJFncI4ihTlg=;
 b=GKzRm2QMajFm49aEovxiJyi4AX0RUbpjCpDFjOyeIj2Lf6PAPtP3mIKN3uTOgZMnFCdujeH6cM3GsPqpeuHvavXgfuSmZr53SVBYoNNtE6jPms16RN+nPrF4AAT5LLi2Xl1yXRuEhA1gEQbstlNHWkWThZ3jvHlFcXlGbWQdqBHNy6zn7cv5p+u0KC/9E+va443yZlT2hgiXigVgzNZc4U3VtGsTglC8ZfdX4hZ+EObNHGR+sdbw23C5wbm2YegrDAhS0osfemf38vgv5d2CIthLEbP1EUtsRewysKh7RI3mBKtbVPjx9xhb6Nx74+M4JiMKV877BY7OHT8tGdv2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A8C28Jsb1hwQtpUz5IgOQeFnEj9OZQeJFncI4ihTlg=;
 b=GEOWMKL5IfvRiA0S6uiRuIMsJJ5IGLvvWPPqaC54qdqZuuQaJoNbx0XY8/fBBgP4nm6ulh25K/NN5045yczPc0t4gRJMxf//1kyB3E5nRh48RDppCN2TV35WuNqqoMdBfQFUkxXp87bLvQiBJxLS7G/kFtHcyF3WzHJihgombzo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6375.namprd10.prod.outlook.com (2603:10b6:a03:484::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:18:58 +0000
Message-ID: <2ac567ab-b3a5-438f-afcb-f57a97379681@oracle.com>
Date: Thu, 28 Mar 2024 17:18:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] btrfs: add helper to kill background process
 running _btrfs_stress_defrag
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <247bde0d4f7d943337e228dded8ad03753b0e3c9.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <247bde0d4f7d943337e228dded8ad03753b0e3c9.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: d2712409-9948-4547-6cb2-08dc4f08191d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gmkuDAG9V53bCgVyD1JJ7ETU5ae+3OhhajBoZj0F8l7r+oc84y7PkfC5KzkPKcA5QgN68WO7BLC6ITzYDHSCUgXtgdQoVIonJ0UUcShP/cENcUriTJyakKC6STWa8O3aFKw+CpV9zuWfZaFQkagfHuVUlRs3VJmKFd+fLBEp8boSeq5WUhrTM5BBBnnF1qJBkOLa7OVqeGx9cJvl+sGerEJk/lrVjA6QEhvdcMeXwEF8951uRkoeUZnA10I6CVLComYUT8C1wKkPBEsVwS7dyBayRciS1515z8rE00t031kHTCh8estk1i1MsKnZ/mfv4TvqPLWc7m08eJxR/4Wvj8NRB70qQoZdwk492Cror3zzMryG2QjVCv9pzJQiM6Kq4KLm6fkGz/+X6rAc/xg3NKSzsqIVlJmVkic9I+Sgodm9U1D6tAXskh3ESUPAMdP6A/lMU1GNrYr0iTlVnissonD7fGGk18vcGHFWk1Cgx69yBykkk1mmxA2cnGJIbceXFPSMgEKSTu2BCm275+JaKFMtrO58a3xE94XUq7EdifMKzK3oJT8TZRs81dVS8RHFygNH5TOSMq5W2klJHQAMG9YPjbVdOmLh6SiX/OMpJt5qM28EH+rPRUQNlD/Jb/5sgLQfpmayKGzWwGUZbVJkR4pS6l2rp7ZsMHHP/AFVSVw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWNhM0RONjh4aVdqWjl4cFhJKzduVmhvM0JIamUvM1BMR2dyYTNubGtMV2hB?=
 =?utf-8?B?ZWVVNzhYU0ozb3pYQ3RxejE4WUUzUWc3UStKZEtvK1JCQ09MeFhoN2hCWm9r?=
 =?utf-8?B?a3lKSEZxZFhyTEJpTHB0Q0RJQmh0K0tBTnBxVWE5dFd0YXZMemtITDNBTVJp?=
 =?utf-8?B?Qlp5NHY2SCt6enVYanR6Z1ZLckduekdDMGdkQW00ZngzaTBCaVZ6NG4rWGRN?=
 =?utf-8?B?VW5KWXJQSWduTEN4RmYvSHR2VTllUFlTaFBxZHBTdURqWEpCcWpuK1VKeTNy?=
 =?utf-8?B?a1hEeUE5b2M1dDUzb212d2V6em5CSlZ3QWZQTGVldHFYbDNDeHZOSEJqVSt0?=
 =?utf-8?B?cWtBTTJiTFZpVnk0eFN0WlliT1Z2azlhMExVRDBHdG5VUHdBRXI2dVNRRFV2?=
 =?utf-8?B?clR1U0JUZDkwOE01ZXVDVkFjZXRKQVdvWmw3U01WanJzZjlua2NsL0dqYjhG?=
 =?utf-8?B?cERwaU80eUZaemVIVkhGM0xRdCtMRDVjWEJxOUpFWndyL1VBQlZwaFBMRVNs?=
 =?utf-8?B?WFZ1UUtIdm54bzZhQ0FyaVIvZEpjK1RZQUh3bWZkUExlNGQ5L2Jtd1JFNzhE?=
 =?utf-8?B?aDlITms1bUV5WHV6dTF1YlhoeTRHUUQ3SlVBYTdzSGR5cVdaWGVHcEZNOHNo?=
 =?utf-8?B?d1VnL3l2cHRkMFBaSUZUS0o4dWF3QkhwTklDd3Jkb1NWa2VndXRwV0p4NkQ1?=
 =?utf-8?B?WFFEUXpiK2ZSYmhUZUx3aFQ1a3pNUkprWnpvZDYrV1o4TUpxTm5wa0p2UDRy?=
 =?utf-8?B?bVZTdzZvd0pvUVAyaU5DM1lySmp5Z3BacmFRTzkrT0l0NjcwbkNSZnBmb2dU?=
 =?utf-8?B?aUtVeUE2TENSV0dPQ05pazdGbmlFQlA3SDA0MUNuZzZ3aW9FRkE1Vk4vYVhG?=
 =?utf-8?B?OGpVTzhYSXIwdzBpRkRDaXBmVHF3MHM2Tm5VUDZYYkZBajlHOFZEcW5IUWp3?=
 =?utf-8?B?WVUvL3E2SVFSSk1kalJObFVVSWl1VFg5YXh4T29xSXh2VHNKU1hXT1JUVFo3?=
 =?utf-8?B?SWN6MVpqMlg0SnhST0RWeC9yaWtJOWlaUkE1NlNHNVo0K1JQK1lsM09KWDIr?=
 =?utf-8?B?bUQrck1QKzI0Q09jWVhkUFZIQzlKSDQ1Y1d0NHRWRFA0Z2N5bnhkM2hlRUFz?=
 =?utf-8?B?aUdmMWRlZzJCTkhpbXcvd2g2RkxFNlVzM1FKY1RhQTdKL29wL01BU1UzOUZE?=
 =?utf-8?B?VENkQU5CY2JEYmpGNU9tYnp6NnVac2ZubEp5VWRhbzV1Z2ttZEdlTndnQTRi?=
 =?utf-8?B?TGl0bTcwRWxPeEVKVWgvS0kxVlVKWjZ5Sy9pLzBQc2JsUjg5aXJBcjRUSzVC?=
 =?utf-8?B?ZHR4U08vRWlqSThibjNFeU9vRUgrRjRZSEZjbGR1Nld1RE0zYi9HNEV2QVlW?=
 =?utf-8?B?Um1CN1l6NVE4c1BXdGhUMUo3RlZKaTJRZ2hFM0RWOVBnUkNXdFVnMWpDM1ZB?=
 =?utf-8?B?ZTZuK2lvSTc4Vm9wVWRJQlZKUWUxZTRPbm5aL0FNVDdidTFFQ1dqYTY4V0JS?=
 =?utf-8?B?RFdHNHNBK255dkVVOUJGcFYvOXNVdWEvcDdpS0pEMUN1anMvbkgyNGpuUGNh?=
 =?utf-8?B?eTRXQnJDN3ZGTUdQNUJSU3pBT0hmd3FFYlRCejdGaEszZXhHVUVvTjFyMDFa?=
 =?utf-8?B?aEpOZXp3OC9Sb0JiTWVmbmlvYTdVMU1qcERVYURBbG9nUjZnRnFrajZOZFZq?=
 =?utf-8?B?SVBhTmNvR29UY0ZJK1ZibVdZdVN1eHZxU1BjLzJlY3hoeG1DaGdXWVkyY3ZT?=
 =?utf-8?B?YittR2RoN3grZzIzSWxuNkNyUUpIMTBveWVmU01wc0hxeFVUSUdFekFkRUhC?=
 =?utf-8?B?OFg5ek1MWDBsWDcrVWZVcVJNcUJDdnFoVmkwa0xoaGJGc01aYUMzYnpMWWRH?=
 =?utf-8?B?SnBWazB5Nk5ycTNrT211Z3hEZmFFVGRJU1dKa0p1eWhXem13Vy91Q3BUVW1O?=
 =?utf-8?B?cklnU0ZudXBnbFYrUTU3VUQra2IwM3hjcmM2VlAwU05JWWNtUnphc0Z3cXh6?=
 =?utf-8?B?L3Q0dzZZZS9mS0toa012dVFHQnphdWQ4K1JUMGJPT3pONHVmaXhpa3Zhamcr?=
 =?utf-8?B?aThhTUlIRmdZbmhIODU2TkpHRXR4dzlJSExXM0xFRlA4RTFtcmNtVzBwaGl1?=
 =?utf-8?B?K1IxQm8xdWRGWWVXcXFlVXJpNTdDQjlxWnVKMlZLWmx4WUF2TEl0d2Fsdy8z?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Lflwl713F4+UpzjEXLIyAImuPGbaAxwSH9lIwuxBRt/Lp6sqAIt+fd8ZKRjWmHwBtQ0/hWuCxjtE6AgTLPqvaZO/Zt+K72QVpsgd52yeQanYs0TJe5YXMqVCSHyspnd4882vPUlqXkU70EzOmyD5/NShgdf8wEKo9naBXcDm/0xlRcww3uKNQgPLGgpDKXDFIJpIY/Y4hugkE89n0ZdYzWzRMJR/DPcJA/C+WZwMrvKgI2a8bYgWaQ7BmPnmP1lfwiSrc2UBkyvHNSGUkRpe6R4xuCzymxXno5fK52VRbc2MwgKr+Ul4oBOBGaDwZaO8cv9xFVBxKN32GukTJL4LOgHVg3vk02oWTUgYJjBXPpMyWiWwIylxeahTwA97qF91+IUtxMeochOGfD2wGEB1VkV5fUooXQic0AZyBi8kRAVkNn7uXvmEadarNaQrLCyErwZ2UgJQShUayhYKxNOXuN2Uqth4tCtwXh3KDND8L1tdmjUUUbDvYqBEs/wF3Im/rrUF50vE4CzNTzHvezcZa7CvGUVPGK+a1vLvknpXfG9yaEZe6owyROF6HWW9UQx70JEYSw/zK+2+HCdQyHiRV+YsiejWZVf9i4thKGqKcKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2712409-9948-4547-6cb2-08dc4f08191d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:58.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUaObVFVXwtVza0RykrnlZW8LE4WneR9IF6leYoxtj9ai+FuQoNDohn7napkuRVqGAB6I8A/AojaMQ9H+69a8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280062
X-Proofpoint-ORIG-GUID: Oa9Gp7ojNUZiEogpZVDfLPicxkWQ_2RY
X-Proofpoint-GUID: Oa9Gp7ojNUZiEogpZVDfLPicxkWQ_2RY

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Killing a background process running _btrfs_stress_defrag() is not as
> simple as sending a signal to the process and waiting for it to die.
> Therefore we have the following logic to terminate such process:
> 
>         kill $pid
>         wait $pid
>         while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
>             sleep 1
>         done
> 
> Since this is repeated in several test cases, move this logic to a common
> helper and use it in all affected test cases. This will help to avoid
> repeating the same code again several times in upcoming changes.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   common/btrfs    | 14 ++++++++++++++
>   tests/btrfs/062 |  7 +------
>   tests/btrfs/067 |  8 ++------
>   tests/btrfs/070 | 11 +++++------
>   tests/btrfs/072 |  7 +------
>   tests/btrfs/074 | 11 +++++------
>   6 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index d0adeea1..46056d4a 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -383,6 +383,20 @@ _btrfs_stress_defrag()
>   	done
>   }
>   
> +# Kill a background process running _btrfs_stress_defrag()
> +_btrfs_kill_stress_defrag_pid()
> +{
> +       local defrag_pid=$1
> +
> +       # Ignore if process already died.
> +       kill $defrag_pid &> /dev/null
> +       wait $defrag_pid &> /dev/null
> +       # Wait for the defrag operation to finish.
> +       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do

The same comments apply here regarding the use of pgrep.

Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> +               sleep 1
> +       done
> +}
> +
>   # stress btrfs by remounting it with different compression algorithms in a loop
>   # run this with fsstress running at background could exercise the compression
>   # code path and ensure no race when switching compression algorithm with constant
> diff --git a/tests/btrfs/062 b/tests/btrfs/062
> index a2639d6c..59d581be 100755
> --- a/tests/btrfs/062
> +++ b/tests/btrfs/062
> @@ -53,12 +53,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> -	kill $defrag_pid
> -	wait $defrag_pid
> -	# wait for the defrag operation to finish
> -	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> -		sleep 1
> -	done
> +	_btrfs_kill_stress_defrag_pid $defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/067 b/tests/btrfs/067
> index 709db155..2bb00b87 100755
> --- a/tests/btrfs/067
> +++ b/tests/btrfs/067
> @@ -58,12 +58,8 @@ run_test()
>   	wait $fsstress_pid
>   
>   	touch $stop_file
> -	kill $defrag_pid
> -	wait
> -	# wait for btrfs defrag process to exit, otherwise it will block umount
> -	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> -		sleep 1
> -	done
> +	wait $subvol_pid
> +	_btrfs_kill_stress_defrag_pid $defrag_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/070 b/tests/btrfs/070
> index 54aa275c..cefa5723 100755
> --- a/tests/btrfs/070
> +++ b/tests/btrfs/070
> @@ -60,17 +60,16 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $replace_pid $defrag_pid
> -	wait
> +	kill $replace_pid
> +	wait $replace_pid
>   
> -	# wait for the defrag and replace operations to finish
> -	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> -		sleep 1
> -	done
> +	# wait for the replace operation to finish
>   	while ps aux | grep "replace start" | grep -qv grep; do
>   		sleep 1
>   	done
>   
> +	_btrfs_kill_stress_defrag_pid $defrag_pid
> +
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
>   	if [ $? -ne 0 ]; then
> diff --git a/tests/btrfs/072 b/tests/btrfs/072
> index 6c15b51f..505d0b57 100755
> --- a/tests/btrfs/072
> +++ b/tests/btrfs/072
> @@ -52,13 +52,8 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $defrag_pid
> -	wait $defrag_pid
> -	# wait for the defrag operation to finish
> -	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> -		sleep 1
> -	done
>   
> +	_btrfs_kill_stress_defrag_pid $defrag_pid
>   	_btrfs_kill_stress_scrub_pid $scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
> diff --git a/tests/btrfs/074 b/tests/btrfs/074
> index 9b22c620..d51922d0 100755
> --- a/tests/btrfs/074
> +++ b/tests/btrfs/074
> @@ -52,16 +52,15 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $defrag_pid $remount_pid
> -	wait
> -	# wait for the defrag and remount operations to finish
> -	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
> -		sleep 1
> -	done
> +	kill $remount_pid
> +	wait $remount_pid
> +	# wait for the remount operation to finish
>   	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
>   		sleep 1
>   	done
>   
> +	_btrfs_kill_stress_defrag_pid $defrag_pid
> +
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
>   	if [ $? -ne 0 ]; then


