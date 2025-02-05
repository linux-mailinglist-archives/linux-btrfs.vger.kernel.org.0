Return-Path: <linux-btrfs+bounces-11284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51631A288D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCA51888DED
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF522AE45;
	Wed,  5 Feb 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e2ggMaSv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nTn4ShU7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795D1519BB;
	Wed,  5 Feb 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753595; cv=fail; b=ar/gkjRYmv9H+dhpbMggR9W6PUhqOlS3Ivdr5ry79CHVyCfyZVbrWFYMSfNAIHzCiAE76rASeBf3RkEbG/UMn932f2RFsRIFV4Tn/CAXly/eFd8wMJyPJrxdjrR/93ba3PXf673npot107Kwe4d7v6XgG+dg3GvzakJ+N1xOEpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753595; c=relaxed/simple;
	bh=JCawaQYxpbnZcLNFITE+E3UQiJYFg8dcI/52QR/8sfk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDjjUvpLK5RxUlTtYPB/TVM0eJ50YVFEY4cbthMOeuzqnztcZv0InfteYQemkso9LjXaGoBQHYhLGbIpNKcOAcpoV9haPXVWVt66k0KTKgsP0cWFfepdUSA7DgtGjnrIGoMHN0HcMxtlg4U2N1eJCz7ubOgMhEKTEM/2m+qIOec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e2ggMaSv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nTn4ShU7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51592okV027841;
	Wed, 5 Feb 2025 11:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BHt4mN/QbH5w6XbF2wyQVLFZlgz2l72bYsBysHC4d5c=; b=
	e2ggMaSvOby5Gh73qYYuSlTzVjAQqcu17o5+dGOCN8nf/13JYooYdoGHOGlwV3cV
	hgDIptmzGiUk6jM4QEwj4cUwo4ef+YAsz3DPOzCIcEL+JSeNE1ytXHOa7BgIaqGk
	oqogAWdnNN/XXLyjmSGmyWOpjqmVAOSvAD9bLlQyjV6LXJ8oD6AdrwBKYGQ+uRZw
	v0W0xUeobW0aGPYqUuG7WqzFn6CHoFN4I12WL07edXg/JLAQkJZ9HkDMbFWpz/QI
	ND0+xF9pqVgMUYXZZuGdIIDidpIxG2g4uagUbp8mCvHNhVYup4olBwsrCAyibCgY
	vUKtGXdCvaXqD/EHy4b0nw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50u889a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:06:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515AFIC3037644;
	Wed, 5 Feb 2025 11:06:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gj6x3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjPjdsOlJHj00bI4NK748+qHVhVhaesCeYP1o2462y8ukm7Z7sg/KOpMlxRJz6S+Cd+NenJsPwwfSO1kw2YPCK/WrdpE5QGCCbBIwkirr3YaLc1FoAiAc8ZLkq4OtcV0D6k5atBppoemOTBKIeTqxOXI3+BPV+7Z/DVcgK0bG8e9feqA/MSmIfnfQA6SmxNG2AVrDr6kTTt4n0XjapeZ9N1PnHB2BQI6XUaFc9oXavlEpK4v3eByeSDUF6GrJl2tuC7g8hE1s8DhZ2aEWAfgGYUyiZTRNGrFSZ6/eznhcOux96Km9qwzLUoJ3rhc69l8vbeuRwjT76JQD2nxp0zzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHt4mN/QbH5w6XbF2wyQVLFZlgz2l72bYsBysHC4d5c=;
 b=axA9+gNKwqSGiIhbp0g2KyhHOhi3+0CcmQrmfX2AiZHjd4yCmBmcfQAFAp0qOKz+ZaNEwK4/66IlsdVqY+KkdKuIGV0ZeStu/yonNe19xcwR3O8zKoSCsG77NExgjx7xcKI8UXVP8gEo/05yOZVuGfzQCHKE973OUv4KsBgmvfSPOEAwHRcJ0d0U5ZtQF09xVwLkAQs7XQY+yX6kqHUaDANpDntQEnWcgdDq3lWxxZDwHu7J+kNLCYRYnUGd4Yc+CB5vYt3QFEhCwg0mYwmEVTZJ4g0iPrrvSX/nAWTQd75zcx4+TRBEQMK8LybpcC5TolLwdRuYNZuXIgiB0KNgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHt4mN/QbH5w6XbF2wyQVLFZlgz2l72bYsBysHC4d5c=;
 b=nTn4ShU7GhMeec2N71AsRxs9/UFLG63WBcCZhuf7f9xGP5NtIEifYmy7Z+1FLru6ip4hhzFCL1jRiTVxt86FfXbFgeyNzDt+ZZh1cENqAcM9c9ANenp+jFgcL5wdvCh9lrLbym76V9n2gvVVCTb+MB4oCKDeFWeCX/J7tzotW5M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6439.namprd10.prod.outlook.com (2603:10b6:303:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Wed, 5 Feb
 2025 11:06:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:06:28 +0000
Message-ID: <e5213cd1-cc32-4da0-ab5e-4b7e92627611@oracle.com>
Date: Wed, 5 Feb 2025 19:06:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fstests: btrfs: testcase for sysfs policy syntax
 verification
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1738161075.git.anand.jain@oracle.com>
 <3aecf19197d07ff18ed1c0dda9e63fcaa49b69d1.1738161075.git.anand.jain@oracle.com>
 <Z5vmAzAEtzK_EuXO@dread.disaster.area>
 <fa76f7ed-06e3-4f16-a762-fa444226bcdf@oracle.com>
 <Z6FcxffA-v4-01lI@dread.disaster.area>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <Z6FcxffA-v4-01lI@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 45db88a7-0d53-4721-be0d-08dd45d5231d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmJNbDVJYkpSeHdSd0lqY0FGSloxS1lBZG5CNHc5enA1YlVMSFV3Zys4cUw2?=
 =?utf-8?B?NHJQSzRFTXIrYWdmYzRGMUNDdFQ3N3NJSkgzYmZuUEUxejN0UXpRd05SRThj?=
 =?utf-8?B?RjI5VWxvR0t0RFpzQjJGSWROd3RxSGNWZUM3Tm95RXNucm82eitPRkkyWEFn?=
 =?utf-8?B?ZGUzL2o0aXIxWE4zU05BbXg4ZkUybTR0Tm55WXhVSTAxdDd0bzZ1ays0MFdi?=
 =?utf-8?B?eU9XU0dWZGg4Vy9kdkI4WnVzVE9hVXQyajRYQlNHL1RhcjVlMU85eW5McStN?=
 =?utf-8?B?RzEzU1p6TGtLREpyaS8zV2pQYkl2emVjTCtyS0dPdHU4dE12NE5IV1M1cnF6?=
 =?utf-8?B?TGdIUVg1aWthZ05JZ2lZRXl6bm4rRGUxTDJZYjk4dlRwdmZGTjljT3AycEEw?=
 =?utf-8?B?MEJIcEZSVExZd29aMEpiK1JMOVlyeldscHdZS2EzK2tYWlNFVVRvNHhxTUdG?=
 =?utf-8?B?WFhHcFZIMXVOMnVhejVYTmxYdEV5YThML3U2MHduUnFXYlFRYUxjL1NLRHpO?=
 =?utf-8?B?QmhyK0U2RG9YOTd0V09PeDlMYStzVERSN1pJMzEvUDFNbWhrZWJyUGhPVUtY?=
 =?utf-8?B?K01ZWTJQeFBNbmpKbDdQckEzWklOWXpFUlZieDFVcnQ5N28zTS9HNFUybVV1?=
 =?utf-8?B?NW5VYTJrTFVvTE9TL2U4VlVBT2h0b1RjbVlLSFByNVUwdTZZVHhIM3MzS0pm?=
 =?utf-8?B?bitjekNjVXhDcXc1Y2VuZWtuNjFUSTdSQzA5ZDFGc3F2WWIyUWlpN2xVSkZn?=
 =?utf-8?B?ckl3Yy9CVGpGcmtaSTd6OWtMTEdUTkNlNW1UeHBlekJ6VkVjODNBendWQlNS?=
 =?utf-8?B?OWZYd3FiYzZFTDFxeDF6ejN1MWFJSWRVZVkxZXgxQlZLdGIvMGR5S1RvUmF3?=
 =?utf-8?B?bEtvTEVqUTJjT3ErRlZYa1lYRU1DN2k1NW85U3NJY0FOT2JET29USkd1QllW?=
 =?utf-8?B?ZkxGN0xOU1RnWVBZVGJQUEhEa3FVL3VrMG5DY3pnMUU4TjZONEVSQzhjQTVq?=
 =?utf-8?B?QjhQdG5GWXU4ZkZzU2xuNGVqaU4vTklzQkgyaHBoQ3RUc1psQUZDQ1dBYnNw?=
 =?utf-8?B?dGMxR1ltQVF1S0R4STRRL2VjUnEwdXFHSVVESzFLVFFleXdsYlZpU2hCUDd2?=
 =?utf-8?B?REpldmdIUFJIQ3JHbE9QQnFVWTRaQlNOMWhMc2UxR28ySVRjajZ0QVUvcTBH?=
 =?utf-8?B?anJMMHJYVE9sWGV0VjY1NEZxRlhqQ1V5YzMwRXdsN0paQXBhaDNISUp3RDhB?=
 =?utf-8?B?bkNYdDFvS1dtampLbFFTcG9MdCtLT2V6R2p0K2VyV2VRMjRXc3FNQjdUanJr?=
 =?utf-8?B?SzZiUTB1M1ZLNC92dHg1c2s5QlQ0NjRubVZXbWlQKzBQZ2k3cTk3MzBvQlpW?=
 =?utf-8?B?ZEV3VDdLZWQ5a3pQMEowMnBsTzZrUjhsTzlNb1pWYm1ycHVIOWhrVVUySnUy?=
 =?utf-8?B?ekxXTWQ2WHdpMFAveVprZHFTd2MyeXMrY2o5eXRRTmNhVXhrZElEYUh1dEtE?=
 =?utf-8?B?MVc0QXh6L0V0ZURBRERqZTBnYkdtdit1cUJtZ2JhbnBtUmJ0ZllidlZvNW1x?=
 =?utf-8?B?dkFsT1ByMU9wV1VsQ3MxQTF5cHQrUjU2ZThZNWdwWWtHdjhHMDJUVlB6LzVi?=
 =?utf-8?B?UmxWZkEzaFBCZER0RGQ0YlVDR3JHVkFuVkFXcXh4eGExVVY1ZG9wdGJNYkdn?=
 =?utf-8?B?SlBiT3cyNWdRakVRK256dmVvcDRsMHhweCtXY3dsWHNINXJRK2FkTDJXbmU2?=
 =?utf-8?B?RkJZSG5XT3dxZ0pyOWdPZnRIL0NjTXhOQ3g5TG43TldMbithUFJGSStQeEVn?=
 =?utf-8?B?VEQ0VWVybnhTS1ZuT2RVVXZHSGxyZm1oOUFnTzJxWm5yWCtFUktDLy9xWUJm?=
 =?utf-8?Q?+sjxuVmcFHyR0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmxxcnZGV1ZVQUhEWjc5eHVVM09RMy9LUVZhVGRQd2hqazBWT0FEQ2w1VS9z?=
 =?utf-8?B?UnV6dXFISWpHbHgveDVaTUQrWTlJRHNFYTAra3hvSXROZGZJa0dVOTRHOWV3?=
 =?utf-8?B?TTd2VWw3enlQRjNkUjJNSmF2cnN5UkUzOWJtT0FENE5wOTRxSmJ6VFdteTlV?=
 =?utf-8?B?alVjV1ZlN0NKNWV3R3MyV0xMWEMzdXIxejJEL05IRWdHSDhnNEkwZnRCa0lM?=
 =?utf-8?B?N2xKd1B3bVE2UExkdGoxYkxZRzkxbWc1d0s2TzhIRmVxRjhGNFpkNC9keXhx?=
 =?utf-8?B?YlpHbUE3Vk1vSVVPNmZOT09KUUU0UmlyYVFVUUZhWjRzMlBjZ0p2VWgra05j?=
 =?utf-8?B?dFlTc1plMnJsVUd5OHorQVVwTDB5ck9JcUUwSzEwYVJRWUxRSmhxZ2tFZmtL?=
 =?utf-8?B?cGdiZVNjM0dFbGE1OHdEZnZHem9qNml3UjZLSk90LzNzZ1FRNktpaUVmd05z?=
 =?utf-8?B?OXJNTVpvVnBFYnNlTDREL05aWUdGOEh6aERaWXRlVzlpdy8rQndnSG1nc1Bo?=
 =?utf-8?B?UlEzSDBFRlVEbWxtdFUwb1dZTDZrUXNKZ1ExaGdxdEp0bVlEaFdLdEt2bm1h?=
 =?utf-8?B?RHpsQlhIZlEzNm5lZ0tTMHhHZ3NqakxDZHRKWU1HZ0N1ZVY3SGZSTzh5UVNw?=
 =?utf-8?B?eUNQZ0dDWEYrdkFlODU3YzJLcmFHZ0dwd0ZXM21tNUFOYWJyVTNsY24wNVIz?=
 =?utf-8?B?czdYUHFsTnJKN1pMNHN1elVaWVJiUGh2dWxueFJsNDZudDh3bUoyYkdBYStB?=
 =?utf-8?B?RVMya3dYa0VJaFkrbkszYXRMWmhoakFnNUdyVjZhT1Z6MDIzWHg2emxGVnVz?=
 =?utf-8?B?OFZveTU5VitwSUNja3hWMEpXN0JRSXJ6VUZSVlhETThBYnpJK1crQkEySzdl?=
 =?utf-8?B?dHFyeTZac3J2Y1dIWktUNjZBbVkyVnZDa2J6enA2UjZKRFhsWk5DMXBhOFZX?=
 =?utf-8?B?YmRhNzJxZmdQNC9VbHV5cHZPZTN1S3lyT3p6anFYTGRxNy83dWxrTlJLY2h2?=
 =?utf-8?B?ZFN6S3dxaFdkYTBJQ1pVOEplRzlNeTZTUEU5VGJmeFRpRmRQMzVNa2d6Q3p3?=
 =?utf-8?B?WmF0WUd1TTVTKzBKS1BFYXB5eHo5S2xQQ1NxOGkyakMrZmZEUXNpVkVUQzRR?=
 =?utf-8?B?eDFuR3JBTklqc3pMNHJiOTNqalZNdlRoeEtkVksvKytrM0pLQkNJUEl3dk93?=
 =?utf-8?B?UDZvLzc4RWxlWmxoTHJDYkJocnJwWmt4Mmg5ZU1ndFJSMjR2OFBQZnBJUDA1?=
 =?utf-8?B?cERlN1JhVmhISW1rclhJK0tJUFAwUjdMUUdXRDlMMEZzT08rYVF2bHRiaTBl?=
 =?utf-8?B?c2lXM0dPR0habjY2eUJ4TXBCNGZDNEV2clk4NFJPMUcvWk9jb3orTFcxdUpv?=
 =?utf-8?B?K2lKZGh0Mzd5bmtuMlBpUXZCenpZalprR25tZCt3ZW8xTlVMa3ZkcXJURDdX?=
 =?utf-8?B?WG9PSFYrWlZCdWVtL01aRUhlcUpXUTFITnNabmxOY01BNW1aWWVzVHNDbzE2?=
 =?utf-8?B?Z2JFNWdZWVJsclM2bFdlc2VBbXBielY5SGVVVlRnMWhLT29FdEh0cFl4NzVB?=
 =?utf-8?B?S2hHanM5dnJ3emRDN3lWMVdtd1JXcndLTWJuSllwQnVTWk40Mnh6SnBlKzEx?=
 =?utf-8?B?RFdVUkFBbGNLSkxPQnR1QzFrc005TkFkamlZSmJ2LzUxYXIvbm80YXpYTUlN?=
 =?utf-8?B?YmN2VnRhUTZLaTlmYVlQTTh6WDU1aWU2UEpyTFBJNjZhNklIaHZPZEdQN2VN?=
 =?utf-8?B?TllrbFdSOHVVNjk2bVlOMHVSUHJPdEc3aUhMZUJrU3haOFpqODdZckFqb1lL?=
 =?utf-8?B?OG1oSStGbmJpV0RwRFVvcnZ2MFFhb2d5ODR1V2ZDaEwrQmk5eGRXcXpnWWdU?=
 =?utf-8?B?MnVxdFVtZGJzMDRZcE0rTTZ3dElGd0NRb25TYkhrcDduaVJaa2QvbXBZWWVm?=
 =?utf-8?B?Ynp5NEg5SDUzSDFtWUVaZUhZMGt6cTFRL1haY3lVM1kxQmYvc0xwcGJqZzlM?=
 =?utf-8?B?TmduQ3hLNWxla1NLbGFmK0ZtS05XNkJjM1lhVUoyeHI4eGlUS1M4WkJUdlBX?=
 =?utf-8?B?RjZkeXdrMjZrVUw4ZEh3VVpXRkZaMGF2T1RSUWIzUm0xSC85c0VPV2dJUm1p?=
 =?utf-8?Q?IwJat2S7vGnbewx+SP7zfeaAB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P4iKMDhWucdnDpE6pxRYSGxyeNQ/i1TbsRuNe1H3UBETQbRUSghU4Vrhaf2ypcelilThRlUeTwReIwrePSexKaVUUbuqcdhUU+PVY76DkMbf6fK4TGRXOydqlB4aTxNaAVWbpVTG3JxaLY6zI+CnFMNVC0dwnjHmiFexcwnDTkzMXQLtR/todmv7AORqC3I5qOIfl2Ij0LnnRW+m5adCeOm1cT/La1emcSt2E5FZJe0zK/3BRSNP5HryhT+k5wOa5ebV+47461bsu8ZowGfaBHt7sfWXDqM9eg71/fvzENJpM956oV2hH4qMltbwWYegcubRHvchhGCz5lIeg1pgQ0PM4nPgj4vDNELNdl1c30MPoX5lcb+Z8ukaAR6snnqgVN66UF5NnkRdCycR6spM0UVMeIBqNUEtc2YAFCGzCRLpAnr+VQP0qK0CRiH8DIQoJPn6kP/jXL0u3V0zUdtbW1SgHnHnc/tt+R6T9B/lEPNAcW5M1EEvv71Y7xyFZ9rDL8+stEjXilF7UsFYW3j1QwrHSN5RjyCd26G+beqBNqiYZ+50Yx9asP28LOEJHuzWJVNveGLCvy4wWtWfC/hrcqVfBS41y/QsoHIrNk7F/iI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45db88a7-0d53-4721-be0d-08dd45d5231d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:06:28.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRaiDkWy7eNqIiz/3Vg2F5A3+p6ahhMwGQ3Gx3KSRbsJHOGV5V+IY22SvxZFbst2VSRTKSHfJlYT028PiFsrdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_05,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050089
X-Proofpoint-GUID: DSSNO007s-TgNP2su8XZ98ezYGo8Bm1k
X-Proofpoint-ORIG-GUID: DSSNO007s-TgNP2su8XZ98ezYGo8Bm1k

On 4/2/25 08:18, Dave Chinner wrote:
> On Fri, Jan 31, 2025 at 02:43:03PM +0800, Anand Jain wrote:
>>
>>>> +set_sysfs_policy_must_fail()
>>>> +{
>>>> +	local attr=$1
>>>> +	shift
>>>> +	local policy=$@
>>>> +
>>>> +	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy} | _filter_sysfs_error \
>>>> +			| _expect_error_invalid_argument | tee -a $seqres.full
>>>
>>> This "catch an exact error or output a different error then use
>>> golden image match failure on secondary error to mark the test as
>>> failed" semantic is .... overly complex.
>>>
>>> The output on failure of _filter_sysfs_error will be "Invalid
>>> input". If there's some other failure or it succeeds, the output
>>> will indicate the failure that occurred (i.e. missing line means no
>>> error, different error will output directly by the filter). The
>>> golden image matching will still fail the test.
>>>
>>> IOWs, _expect_error_invalid_argument and the output to seqres.full
>>> can go away if the test.out file has a matching error for each
>>> call to set_sysfs_policy_must_fail(). i.e it looks like:
>>>
>>> QA output created by 329
>>> Invalid input
>>> Invalid input
>>> Invalid input
>>> Invalid input
>>> Invalid input
>>> Invalid input
>>> .....
>>> Invalid input
>>
>> Thanks for the review.
>>
>> This test case verifies the sysfs interface syntax in general.
>> Relying on golden output can cause false negatives on older
>> kernels lacking support for newer sysfs policies.
>> Creating individual test cases for each sysfs interface is
>> unnecessary overhead.
>>
>> With this approach, when needed, we use:
>>
>> if _has_fs_sysfs_attr $dev <sysfs-interface>; then
>>      verify_sysfs_syntax <sysfs-interface> <value>
>> fi
> 
> One test instance per sysfs attribute, please.
> 
> i.e. move verify_sysfs_syntax() gets moved to common/ somewhere,
> then the test for any given sysfs attr is a simple 10 liner with a
> fixed golden output.
> 
> We can then do the same sort of input testing for sysfs attrs that
> belong to other filesystems, too, not just a handful of btrfs
> specific ones this test touches. I'd much prefer such tests are
> largely generic like so:
> 
> ....
> _require_fs_sysfs_attr $TEST_DEV <sysfs-attr>
> _verify_sysfs_syntax $TEST_DEV <sysfs-attr>
> exit
> 
> If the sysfs-attr doesn't exist, then the test is _not_run and
> this emits a log file note that can be captured. If it does exist
> and doesn't behave correctly, the test then fails.
> 

> Note that things like "test not run because sysfs attr does not
> exist" notes in the log files can be important for QE
> people trying to track whether backports for older/stable kernels
> work correctly.

It can also be useful for backup code testing.
I’ve addressed that in V2 and sent the fix.

Thanks, Anand


> The proposed test is completely silent on whether
> any specific sysfs attr was tested or not, and that's not really
> helpful in identifying whether something works correctly or not...
> 
> -Dave.


