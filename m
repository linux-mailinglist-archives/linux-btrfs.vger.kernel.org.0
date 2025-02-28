Return-Path: <linux-btrfs+bounces-11930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258CAA49152
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 07:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8707A6ACE
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2291C3C0F;
	Fri, 28 Feb 2025 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SBZsx7eX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kE0KSmb6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F17849C;
	Fri, 28 Feb 2025 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723050; cv=fail; b=m7Z0G0lNPOwarv07Jm0ddJUBCsR1BnY/8iuho140ISqTpxyfAW+UpXdf65ijhp4D3Nl4YsLL+fZwFTZXDJTQhCkuVQTWcj+E3yTmxXgq3e88s4NX/fzXgAe8JTsTiNkbgZ+VCa7C4OBmO50JUS4AabDFvM/W2Cbz4OV55IYUR6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723050; c=relaxed/simple;
	bh=qtpBXoB38OtR8clPsFy5jftx1nd8VzS0YVdC+v7aCsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YCrXaL8haog7BelEgpg0z3qLD31/dFhC0jN6XxXG3xG/s71d/Vx6RGVSMiSTI3vA7iDXj6SjJTQrJfKq0wFPgnHFMJXxNIkS96Fct/fitRatyHsBL9Yst+7A87muq1a2fFeQjbXISmpGzWtONklG+uGdIX/lTTd0X2XF/233HN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SBZsx7eX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kE0KSmb6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1Bou4002202;
	Fri, 28 Feb 2025 06:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5yC9fI6aP+1OOc0rH49trnlH6xzclRDAoSZX6xQXqRQ=; b=
	SBZsx7eXX1Y6j2iV8qk8ldugIPw/0PCgEKpfVzbemyPGaWkFcGZaTf88fxjOTFEG
	KzamC8ItCzMvXj5AKGCrRr3kD09Wu+1Y4pfc17qmK+jdekru8XbD2rTm552eB6lj
	C76aR+XaUXjO/aBz7UCOZjzQXD1/fKVgnwinN64eJewzgH97xcF9EwE3Lg+yiqV0
	7L4KaTOieCc/NtpT6+6cm8yugFtHY7Y7REkhrzhMZma4gZSVSz1ugXRHppBwFsav
	/DL5RUlWbrRrzOV1yowJIqTbtlAZmENgObkLARfP+17bnWcAuP5j7/AxMO4m9A/w
	yj0NoPdVEWDpzORph9w8nw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse4wxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:10:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S52DnD002759;
	Fri, 28 Feb 2025 06:10:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51de9yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnZBRBNtfhlKwu/YrCJLPi8ViwtKaCvdYiZDcKOTKH+WaXBSAqnj8BM9ky4PDaCxhsV9OEMnWRFoL4ev31gkroLA2S30npyGIprgvAjh2GFAU68L1t9uIoOdsoYZx3rjjV3gKY8l5hNhn2SM/cjx/GOaJyeVk7/jUnPf+C1Eh/ExZNE3TiKoFkacNM4/QeQ+ftddnOUdBkDEUPNDlHkMnIB9d+8X0Gwd/Id2gcK/gj0Q3R6ggzMXIpoJs64EtXL3xbb5k61M6iawhXwHhFVPxoAQRr2wt/rCrxVpLQk1CHZnmxTShFvWhkYFwKs5cu1zOoUDmNDN6lxGsetvM3oW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yC9fI6aP+1OOc0rH49trnlH6xzclRDAoSZX6xQXqRQ=;
 b=WWgpcunZVS5e7pyFdpMN+0He3MXVm7ykeKB3ZTzDgs4pHrZyw8S3TrPeYbnwR+1e9skWZGI4pqNHVvSkrSdQfW31XskqI74P1IblxIhSDPpc41Njw21U2kiGgqgc/Phk2fZ3P+ENj79beR6dP0vrImpCndimCjH8kFJgFoPQVkBOYFqgOY1CQAK3utoNDJjJ29uxN2kYK5JlfBPTZrafhhsqkHDIAGXjFYkRaKW/0of+nTpekQmni1Fzpj0Br096mD80/nbagIE1fsVlcy6BglBJYDTDZpEjUaWWn9p+T92H3tOKf5peLwN8i0NZDxssKTCJ9f2a9OpuXrd0JCDRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yC9fI6aP+1OOc0rH49trnlH6xzclRDAoSZX6xQXqRQ=;
 b=kE0KSmb6AG3VcWaWOWs7v4JII+AzJo2DchskV0MJqXfz4Pz1LNHVE62Qp1cPw6xOPW41JjbxAkApyGpvUJZKiXvKCwr43Ms1uj2DCHdHqHExnDjEqTfTHiIAwwSS9wcVkvBuGoOIjBTeLq722LL+PAgnZiD0JI5U2SDEY2xPsW4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5196.namprd10.prod.outlook.com (2603:10b6:610:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Fri, 28 Feb
 2025 06:10:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 06:10:40 +0000
Message-ID: <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
Date: Fri, 28 Feb 2025 14:10:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is
 enabled
To: Daniel Vacek <neelx@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <20250224111014.2276072-1-neelx@suse.com>
 <CAPjX3FeKPR78zfUYGW+8Ytn-Yz+7i7k+1vmxjO6wjDcobqtocg@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAPjX3FeKPR78zfUYGW+8Ytn-Yz+7i7k+1vmxjO6wjDcobqtocg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: a1de1fb5-79c2-41dc-7bed-08dd57bea038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHl2UjJkYUxLMnkrMlEvRmo5VjZ3YnVMWEhuQzBDb2RmNk43SVZobXBHNm0r?=
 =?utf-8?B?VWhxbWxvazcveFdRNmVuNURHYU94V3hxK1kxem9WWTFRbHcwclFMcEpDbm4r?=
 =?utf-8?B?OTJKU29VSUU3N2FXOHlISEd0SzREQWFuc3AycXIwYTBDLzlNbis1SmlQSFRT?=
 =?utf-8?B?dXh0Y0F0a2hkMC9MNTIxajA4V3MzbWRYdWJRWDc5TU9ZQTZpRTJPSmxuMlcy?=
 =?utf-8?B?VDVlU1pNdGYxNFdNb0hhQ0lrWS9nd1JkYkVRaTJIN2ZlbWxXUEl2QXlWSjFZ?=
 =?utf-8?B?YTB0WStHTXVmdFNqd1FpVXoyTy8ySFVrQytna1NveW15QkkvMi9GSmtnMDBl?=
 =?utf-8?B?WWZIZXZFWnoyajE0OUVmM0VNVnpUQ2UrbEFLeDFFSTIyLzRVOEtzNUViK1VW?=
 =?utf-8?B?NEtiL2JkVUkzRFdKeDc1WVNsMTRxQXB4N0pIU3hNVlMwUG8vWk9FMlgrazEr?=
 =?utf-8?B?VktBRGo2ZzJWMGV0a2hQYzlHVjZOZ0l3NUJCdkc0cWJ1WlAvMDZrLzFNNXp5?=
 =?utf-8?B?NU12cy85TG9DWGpsd2diSjBiOTJZOGRkc0E5NlJicS95c1orN3RiajdLbFdv?=
 =?utf-8?B?OHQzeklWZ2s4Y2RIalJjVmVPUGVZWGd5V3BMQktPOWJiNmJTb2VENVEwd25Y?=
 =?utf-8?B?TFRnY0hUUTJreit5VjVGcERSUTViVTFyQ0ZYU2dvK0h4RHlsT3g2TnZzNTRK?=
 =?utf-8?B?MG1yZEZVT29UY3UxY1dXdEFRVmNDU3cvbEl5TEVuYWVMaHNuOGl3NkExUUxo?=
 =?utf-8?B?MzNhOUdtQm9EOUtzcGtjd2Z2N281MkZHQ2JDdHl3K2Nkd3FGREg2aFBBOUFR?=
 =?utf-8?B?ZVVTUzNoajBRdk50RDhuNFpzY0Vjay9vVXpmNXcxMGRWbnJKZTJaWmtoTEly?=
 =?utf-8?B?K0FPV0xEQzB3Y2hwZEEzV1lvR1FlUFVteFdpQnE4cnoyTTdlWm4waU5mV1Vm?=
 =?utf-8?B?TEpSS1JsempVa1l0T01sL2tueHFQMkVpYUZXMjJtak5vRFpyUVJ1R0tqbGgy?=
 =?utf-8?B?NUNhUkN1aGN2Ry9kd2wzRXk0eDB0ZXJVUGR0YTdicHBrNkRKcUtlbUd2c1Nk?=
 =?utf-8?B?MkZiTWIxdGNQdG54RllyOUYxWno1K0tlOGlEcmwvdUlFQVdzNXdJZ1EybVYz?=
 =?utf-8?B?VlBtVHROaGhwWEZHdVJ1WEg0VGlROTlhR2o3dS8vZFJCYW4yY1psNlMxWThE?=
 =?utf-8?B?anRHbENicXFTaEhIV3dtMk9MUWZFNFVzb09vNG1admdaZDl0aFE4SC83ZDRS?=
 =?utf-8?B?QUhtbVhmRDVMc1Q1UVNRS3NBWVRqREtHRU5iWm51MTAxVVd0cm5HU2x6TzF6?=
 =?utf-8?B?OWVFS0N4dUplWWMzNTdQSHNvQ3c4dCt3ZUF5Ym5IdW1FcTI1eDg4cnpOdE5V?=
 =?utf-8?B?SzNJS3R5ZWMyRCtrTkVlZlRXZ0s5bU1QK1NFZnhFdXErSkpuVXh5SE5mYzhM?=
 =?utf-8?B?Y3lnejNGcGpTUGlYSzFZWGpFZTJIdkVvcEQ4RjI0WkZtbVk2aEtLTHh3RE9a?=
 =?utf-8?B?bUJRRUJmTGFvL2lhNUQzM3B3WXVvWmpaUGtxbzJHR3JNUksrSjhJY0NWL2Ez?=
 =?utf-8?B?Q1Y1UUxlVEdZa0lVdUFYbzM3L0w3UWhtcHYraHJIbzRiRXVQVWZSN21VTlll?=
 =?utf-8?B?RUo5aDFNQWh1MzFuMFVLc2gyOFpzZ0pVVng1b21CTDI2a0k3Q3djV0JnNlNC?=
 =?utf-8?B?QU0yWlVxYVRoQUcrbjZNeldsUGZKcHNHTTE2WUxWcU1QMXBGVThiMDF2SUw5?=
 =?utf-8?B?U3YyV3h4cFN0VXRFMTdrUnRSbXRucmkzSHRBNnlxUlFaUjl5TEY3WUlxRmVF?=
 =?utf-8?B?N3p4dzhpMUhVTVpSUFRQQlI2dHRxV1BlRGNkajljbTBDWERjTUdNSk1hNWRL?=
 =?utf-8?Q?ltjMpqj9Z/mQs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRDV1pOUDRoeWJ0b1ZpdUJZV0xwb3Z2dWZMNVlaT0JBS3JHbHNKeFBvVVdn?=
 =?utf-8?B?bEtERTd6Z3ZsaklCU1BSeWRUYXNOS0xwbEdDbHhKSXkyRjhiYXExNHN4cVho?=
 =?utf-8?B?RW10YUxLUFZRUXVLMzl5RGpOZ292RS9xdHpoWW1Wd3N6M1pLS29Wc0pHYUJP?=
 =?utf-8?B?NGlqbEVZbWxuelJ4RW9nMFJVbzVIa3libDZzaHdXbUdpUEpXaDd6ZFVXNEJz?=
 =?utf-8?B?bmdTclN0OGdyTHVsZTZoRlJLdWpaUXRtTnF4QkZ4VGxNSEFhaXdjQ1BCZkVz?=
 =?utf-8?B?d0lTV1NuTlFXR3ZsSlhCdDRuQ3pwR3JrazkxT0NWTkhpT1JCYXN2NzlkbEQ1?=
 =?utf-8?B?T2dydUdhL1FEOFBmc1pZRXlCeGE1NUZnWWpWMTFBTkg5UVR5OWtCSEFFb1hG?=
 =?utf-8?B?Q0JUcklBb04xWFJBdHBuSm4xZElKaGJQWmlOUnZ6cHJOZkVWLzFWR1lUMUoy?=
 =?utf-8?B?VWd6b1M4T2l4ZDd4MTllL0JsTnkzMnY2RGlqZ0xqeU1xYUd5Z2tuc2hsMHFV?=
 =?utf-8?B?dDNuTHMvL1NsNjFONGlMd004ZjNvclpwdysvR0hMclF2bHBaVGZsVUV5WXA3?=
 =?utf-8?B?NU1hcHJBZFRSRmE3ZmNMR0dJYVNHOFZnMFBwV2pjTUpEQklqaStKbGJUUXp2?=
 =?utf-8?B?OU9hUlFGUUNndG03Q2JoMWZPRUtKK25UVmxBbU9jZkxqU2VxQnpNczdUVTNi?=
 =?utf-8?B?UHhoYlZHNjE3Q2V1QWlhSFd6Z1lYaHZLRTI0dVk2NFBkMUVucFpSN2NvdnlR?=
 =?utf-8?B?UDVSeGpTNnI3TmVsZVQ2RFlMRzllbWV1cy96aGdiSkF5bXlKSVNTQy84bDJn?=
 =?utf-8?B?UHFSVWVhK0xnNjdRbGRlN3ZSRWM4emFRbmNOMlNiVVNHb2QrOTU4V0lwMjZ5?=
 =?utf-8?B?Yk1jdzBqTjBuVFhLSDRMWDd6UnpYcmNXYW1oS3cyQjRxVUU4cHI1UkdSZWc2?=
 =?utf-8?B?eHZZb3crR3B4SXVyMVpGT2x3c3hjeUQrYUl2T1psaG1JL0Q1WXVpeDlaRlh4?=
 =?utf-8?B?VnptWmFoZnRLWVFlRHlYYStveDRJbE15N0NPTjI4Z1RINHpTNnhPMlR2Z0VV?=
 =?utf-8?B?MVo3RmtENktBREZkWm5xVG1oVno0dThGbGI4bzBUWmI1OGZJOUxrMnphV2x6?=
 =?utf-8?B?clZjRGh6Um9JS2pLaUw4bVhjVSsrSTgrV25aL0d4Wlh1dnBvUlE3RGxNU2xR?=
 =?utf-8?B?cm5ZZmgzbExySmhaTHFsU2RIN2J1c2ZiTTk5ODBSZW5sZTQybVdTRnlHbVVW?=
 =?utf-8?B?RnM5aTZzcG16Q2NvcmxxaWFrbVY2dUhzZXgzQ0Zrb2xtTnpTM3JYL1A0M1ZN?=
 =?utf-8?B?MndWMVNXanBBNGFlcDdNU1Q4aWZTNzNKRVNkM2cwMmcyRkxEbHpjUmRKV1VT?=
 =?utf-8?B?aXo0Q0RWWnVNbzNFdzZKVFJsQ1FEc2pWZmczVkJBMVlXb3FPRzFVb05HZk9s?=
 =?utf-8?B?VWp2NUE3blhhdGxFTk9XbURKbEZyMzZvNGJjdDJTUXNUR2VMUGpUMGJQZnoz?=
 =?utf-8?B?TjBPdFlJTUw4dXZvSTBRU3RjSUxCK2VMV1N2VzMzVXk3T3U1Q091Z2dzTDZh?=
 =?utf-8?B?YklIdzRmU0NjZThpSXY3cjZ0UGxaSElLcC9ManZJMEhzeExxeURlQmJPa05u?=
 =?utf-8?B?R0FIMEVveC95UGc2NHE5OGZKVS9Vajd4amRZRnBQRWo0OFBIbDdoQUFmUmVD?=
 =?utf-8?B?UklrOGtGblcyWlJueWF1V0NoeXVZV1VsRFowc0s0RlphNmUxNGoxUllvOVJr?=
 =?utf-8?B?SzNuSytDdENMaUd1UlRuck5Ya3UyQzVja3k5UzlRb1ZHVUNNNWMyT0dGSWow?=
 =?utf-8?B?ZTMxbEVUeHZ1WXZwcU45S1ZENmhSQkpKNHVVR20xMVBDclZCTVdHdmhETkhD?=
 =?utf-8?B?VHRVRXByZmlqVEpmdlBEKzVrcU5pbTV3M3piemluc0xWdEd1OTI3dGhWOWE5?=
 =?utf-8?B?cWdhZlRIMDV5LzVjWExjN3ZFK2xyWmxydnJTRlB6QzBRblRIZWFocW94RXlX?=
 =?utf-8?B?NnQ5R3MyQ3U1blE3UzF3a3VpU0NUcmxCU2pUbjJJSk43cThKVzVqbnp3VDhZ?=
 =?utf-8?B?dGdUdVkva2JUcVVNSnk2d1c0bExTWWIrLzFIQ1FPek5Ccmp3RUlBekc5QnB0?=
 =?utf-8?Q?Iv/khAfvgpe949aNWVRqR+18Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G23/DCu/dsLpzdwA0VCBmR/8oxYHdFtuxGzIOsvcERdxiUFl9hmdC0x26Ggi9ZDb+lUgJWNMT6MjNtILC3/JBBl94KL4ofzLBbXZMH5UCwghQywMkqqwRdmYX+/TG3u4/f7kc9iHKwahcdvLQkW7FIaY7cvNiSoy5t1mown8xOCNVUnhdef7pvxW9Bq/Wg0KrjKh9P2MUIJ5mR5uhnA3qs9AZH6xHRxrsQRoVZT0i7hMd75PH2uf38o/2H/tHb4J4E9bwqUAxsyFEy+CIr55JOZGsM1PZGxhDo9nIF9tgqR9e+2XTm3E1Xq6aBy4dwyGbsYkLBhnRh4+t8ZMEz72eXciYcBjt977ExBDpSloffQ239IJ9XpouoYT+iIk2sgQfvHtr3dDZfssq/ppB1RXBER5BZ3DPP+mQNgOAIomc9n7JiiCX7kiS2rVxGjU3K0hVCiP+KGIUhH/gdRYbHZAcO7YZSOHuz3HeMYk3Qp7lKGX46/1uGRmBdFgumC962qzeW+S9f/q7xTCr86WtrjSN5jX9AXCGa4lOkE8X2Td7TSmkP436EvURgspm6D7bTy6It0lwKDmY2B9GbF5tUvocvjB0Il8hGhS/Faj9b7+3qE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1de1fb5-79c2-41dc-7bed-08dd57bea038
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 06:10:40.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR1LPoX3h76TFDfPgE9uwrNNfoAQ8VpLj0oF/TzDd2EARymif9jOQM4baowx3QtSXU6w7Y502lsmm4O+IRzKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_01,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280042
X-Proofpoint-GUID: Tl7HdyxgWMBGh1wEx1wk6LD-VYv_lPDm
X-Proofpoint-ORIG-GUID: Tl7HdyxgWMBGh1wEx1wk6LD-VYv_lPDm

On 24/2/25 19:35, Daniel Vacek wrote:
> On Mon, 24 Feb 2025 at 12:10, Daniel Vacek <neelx@suse.com> wrote:
>>
>> When SELinux is enabled this test fails unable to receive a file with
>> security label attribute:
>>
>>      --- tests/btrfs/314.out
>>      +++ results//btrfs/314.out.bad
>>      @@ -17,5 +17,6 @@
>>       At subvol TEST_DIR/314/tempfsid_mnt/snap1
>>       Receive SCRATCH_MNT
>>       At subvol snap1
>>      +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
>>       Send:      42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
>>      -Recv:      42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>>      +Recv:      d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
>>      ...
>>

It’s actually good that the Btrfs receive failed because the send had
an unlabeled security context—kind of a validation, even though it
wasn’t intentional. The fix here fits the objective of the test case.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

>> Setting the security label file attribute fails due to the default mount
>> option implied by fstests:
>>
>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
>>
>> See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
>>
>> fstests by default mount test and scratch devices with forced SELinux
>> context to get rid of the additional file attributes when SELinux is
>> enabled. When a test mounts additional devices from the pool, it may need
>> to honor this option to keep on par. Otherwise failures may be expected.
>>
>> Moreover this test is perfectly fine labeling the files so let's just
>> disable the forced context for this one.
> 
> And of course I forgot to remove this sentence. Please, remove it if
> you decide to merge this fix.

Fixed the changelog and pushed it (for-next).

Thanks, Anand



> 
>> Signed-off-by: Daniel Vacek <neelx@suse.com>
>> ---
>>   tests/btrfs/314 | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>> index 76dccc41..29111ece 100755
>> --- a/tests/btrfs/314
>> +++ b/tests/btrfs/314
>> @@ -38,7 +38,7 @@ send_receive_tempfsid()
>>          # Use first 2 devices from the SCRATCH_DEV_POOL
>>          mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>          _scratch_mount
>> -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>> +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>>
>>          $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>>          _btrfs subvolume snapshot -r ${src} ${src}/snap1
>> --
>> 2.48.1
>>


