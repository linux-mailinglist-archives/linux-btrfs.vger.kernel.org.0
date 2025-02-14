Return-Path: <linux-btrfs+bounces-11462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398F1A35A5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738677A1505
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E123F439;
	Fri, 14 Feb 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TUbfrMda";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c9OHH7H9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297B21CA1A;
	Fri, 14 Feb 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525366; cv=fail; b=EnnLebpssIDFsDWtb6KC1aWxiRFoQP9Nbry7dGhraVcvxiiTn1E8/pafz1PK3HAGPaU+iyTKTRHyjC/kxM6pmRRW8bokKapeOAL0LehmR08GafEsieZ6JRqpWLctqbc8bxnGkAbEwtJnk0LmT7jToLP4KlN/UYXrpuHyu+TkiWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525366; c=relaxed/simple;
	bh=qa7FpSUk5Pe9674jyZRf40xsDRTfFmvj0pKNG61+I3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CM97fppiZOail7xB1GOc1Q20SkJtZxYaZ8hG9t+xTsfLmmuD1w2yyIpePr8STJvoR63ASvGQACCaL8a0eaP5kWrUBD0FYQegpN2dMIFqGl7lNAxcmF5+5fDcKozss0YbXLx6z9xjktSm7tKhlvqQdDRD2t9yT6F2DEytIyZU9cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TUbfrMda; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c9OHH7H9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E7gmjk027790;
	Fri, 14 Feb 2025 09:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DbN0ALv2w4tCXB1/J5hcm91MBZzqaaQXc8jlqXLj40E=; b=
	TUbfrMdaBThIFQMub/xk5MFLnFhStoTsQEC3tFkFb0SOO/h9ypCGY9JauubKDWwz
	F9ORVYvI1FtBJp4zRoV7xPHrBXC+L40hzqpmDC5QQQDhhUC7jJmAfn8LqO9UiMUb
	jwWsz1dqUFmz68t1n9LwOXYFvH1wF4v7A/G6SDx7+Ct7h8c8TM/naDmG6anNxIh1
	XfLkLjecaQTz66cIHRtHGIuSi2BspaREGua1uPnXxAMsbUyqeyG4DUiWdw0N4vmT
	cxaLQwQ6I9NV+RjUHlntg9LbY1PqKFX0Ihz3UXcJmDQBVqbyhye7mteSaloNYWZM
	hkIQSh38BL+wTuaCnCz4FA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tgbdu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 09:29:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51E7Rn6A012407;
	Fri, 14 Feb 2025 09:29:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqcxk8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 09:29:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkaF/OTnimI6XrUO1G5CrIEnaTWFxzti0FKHrJyAcY//pgCRuarMqH/U+Kbk8YIW2KN4DAOaMi5ka0IAuO3BaZpVWQXUDln2IQemNHJAwbifXurWkDsDqQW2XXO809YNhX2Y4Zi3zto9rpaE/Mn/olEY+gBMEzWhbXb+Txtbnfl6mDr7aEusnwpajlMn8VQsFQcAfjvBvuYA6b9Lt5zBiyBumwoPo9dsii7bWmm43pPVR7FNG5gUHd4+W65Ws6NkKHzV5LVJn53YSmR2nXHCk/s1J8CFBKFNXvCesSNz83t2KykRcnV+rb7oUzjnBSbLaYk/C5VLqNYqt1Rla+zv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbN0ALv2w4tCXB1/J5hcm91MBZzqaaQXc8jlqXLj40E=;
 b=VRfne7TjBBMYCIndpKGxaInD325ioSIQWF810lQslBatL7HdrbIupehThk66Lr8q2R2ytkKdCP55P0U32w0rZmFnL4ggKVt747eJ5MgHdct9hWW9yfNc9VHmfC+BKOoewVIpImZiqFeqleGzZlLCRLgg2N3xLSaXuWO06GdcFkBcSm0WyiJ5PvtlEwmnkpIObS05Euj3vaUnWPXHyonLpFRnMdIwX+Cgw13fC9A4KNpHU5DLYbkPDd6ZkeQA6VYD4E2Sq2Obcdc6RapyXOcLZG1y1EjyBGICqBHaJpHHiCjURrzD3DpwaHWo69Cc3QtWLhCiHOnKZnKm8Pmq0g8org==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbN0ALv2w4tCXB1/J5hcm91MBZzqaaQXc8jlqXLj40E=;
 b=c9OHH7H9GsUGWFrV4rcbvVAZfXFGGTWWg997fgc0ecJhzmVX83wwTF5+j2NWZEaYhuKg76YuUGNkOV2Gug+1OwnsZ2u/bOm3WmtbAXcNqvT8eBiflNawWACxpGJeikfEuXizm6ToNW5DtY2je0t9L9uDQskdNgFWV18ZF91WxS4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA3PR10MB7993.namprd10.prod.outlook.com (2603:10b6:208:504::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 09:29:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 09:29:17 +0000
Message-ID: <d9e2d806-dbf4-439e-9866-1c20de80a915@oracle.com>
Date: Fri, 14 Feb 2025 17:29:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] fstests: btrfs: fix test failures when running
 with compression or nodatasum
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1739379182.git.fdmanana@suse.com>
 <cover.1739403114.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1739403114.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA3PR10MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e572c5-fbfa-4873-9ac3-08dd4cda0d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEtESko0Zjhid0tjZk5iVnpaSThobFdhcGZrUkZxc1FYTkhBeHZTRHQ0b0RQ?=
 =?utf-8?B?eUhmNkwvYjJYT0h1YmpETUJpL0J4dXNjZ0I4dmZyYyswRG0wdDV2ZDVCV3d5?=
 =?utf-8?B?dEpDVjUvYjRVMEpXSVNBUmZUTXBRcHdwWHA2OGlNelRFWjZvT1RVRTcyTFF2?=
 =?utf-8?B?U29JR2J2L0swakZIOGFwMGFYZi9ldkd2RjFaS1h5OFJaRStha0JLR3VVSXdX?=
 =?utf-8?B?MG5JMDBKWXN0WTFEMlNEWjBsRUkyOUU2ZW9YMHhWenVPeUJZRVRhejd6Q2F2?=
 =?utf-8?B?ZzRwRXFLT2hkVllYYlk0b09tUnI0TGVkaytmOGFLNkJYUnpId3FxT2lNNkI0?=
 =?utf-8?B?VVVia2tSWmdERUVrQm50bUxibVo3dGwwdEgyNUpkdTJXak43UzB3ckExcXpX?=
 =?utf-8?B?TmZKOVU0Wm1vdW5zSXc3NU5tZzFsT1BRZlpSTS81b29PdDh4a1NvVmxiNXg3?=
 =?utf-8?B?ZHhJcWRVbFFQM2pnVHdWVWlWTDZJdzhzUmdVTFYzUlhYK0U4UEQvY2VaZ0c4?=
 =?utf-8?B?TVZqTlB5TDYycHZUejJyRGV2aXdqMU1ZSVFvVjhSc2JhWkN1cXRxL1RQbnUz?=
 =?utf-8?B?bnE1SmRoNERvb1E5UEd6QWtiSlJmeEozQW94Vld3UFFHbWYrcEJJMmdwSWcv?=
 =?utf-8?B?MFpTMzFuNFZ2cmNZRVlPK1I3VkVJTzc1S0NjNkJrTVRQbi9WRXNvNjlmUit1?=
 =?utf-8?B?ZXA2M1dYRm0wR0JXeG1FWUpPZk1YNjVNUy9rQmVoSFFvVk1yZmJFS09SSFFT?=
 =?utf-8?B?QjhDNzY5NVRnTWpLeUZYMVVWbnFHSXdFN2IwMFZ6UkhtdHQycmh4YnI3VzY1?=
 =?utf-8?B?L1VLYkhySTlTMEdZRktzc1NQYzR4SXNsaEVkL3VjOW1ZV0xqSmovbC80QWpj?=
 =?utf-8?B?U2wyOUlYQzNUdUVTbUwxSEp1bDdqMHdXbjg0TndBaFJrTkNXMzdZRDdkUnhQ?=
 =?utf-8?B?Y2xRcWNOM3pUME54cUpUdEk3czFtTk95YlJ0N2dQYmxxeU1lbUdkN1RuZkF1?=
 =?utf-8?B?T1M2S2V6RFBVM0pobXVXcnNzck9iT1lOSVdpb0xEOHZsUDBTZXhuS09ZVkFi?=
 =?utf-8?B?cHVaeXBUUlB2ckNsVDdSVlNnQ0NUY3Z4VlNxQ3NNL0hweWVENUZLQkpqZzV5?=
 =?utf-8?B?bTJjZTdKbGtIbTdrYzdyTENSaXYvblp5UU9LRGtaMDJMR3RDU0pIK0R6ajYw?=
 =?utf-8?B?cjVJTXAvbDgxVnRsZ0V0WjdjTkp5L0N5SW4yMUQxZVdTRklpWkovM3BOYlBL?=
 =?utf-8?B?K25YKzJINld6dU0wUkF4Ly82cmVZZ0pNK294SWhuVnBBNEpySmVmeVU4RTZ2?=
 =?utf-8?B?UzY2RFk0djl3RnczODdWU3I3Vm9RZnlUK0tENFd1ZnEvdUhWTDFaUW80T0th?=
 =?utf-8?B?Z2RkemVDY2NVdTZHZ2Q3eWVMZE9zOEpTOWZpa01mS00xTWFhVHo1MUVWNU5l?=
 =?utf-8?B?YWY4TG84aXg1ZTBBeWlxZlRhOVdVSXd5S1lkc0NReGVhNS93YytvMVdLT2p5?=
 =?utf-8?B?U0luTU0yQ3VZamdOSWY4V0ViNjJXdWpqU2pFdExQTlFjTkF1REswWWlVRDlP?=
 =?utf-8?B?V3kxR0hqR2t3UkhVUXVWVndZdGpRL3JRZ05PT0YxVWtBZm5YejljL2UrVUtI?=
 =?utf-8?B?MXl4QjQ5UXRXRkY5ck95YWpDU1BHWDU0OHV1QUd5aDBHVmVYbUxmR2FkallY?=
 =?utf-8?B?YjZFTTVuWmt3RU8vT2R0VjlweVQ2WTdtdmRHR3FnQUZSZmlLWDFZV3BpZ2s0?=
 =?utf-8?B?Tzk0dHVMODh4OEhLYzFNTzBOdEZXYzF0NXFiZXV6MFM0ZWhGSWZXb1RuUElY?=
 =?utf-8?B?TTBCMEUyN1JnTHh2Z0VUQ1JXaytxZm1PQWdFanhOVFc4QTgwS1d0dTJFM0xI?=
 =?utf-8?Q?3imhY8t16EFDA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M05mcU5tN3BHb08xMVArTkJhWU9aTzVJSUpyNUVhQ0pJNDFtVFJIVmhiNkdB?=
 =?utf-8?B?a051RnM1c0pYSkNRN1N0ZHovcWRkMytYT0xwVDI1RXlYOVJ1Unp2UGNOY2hX?=
 =?utf-8?B?Sm9vNGtabVE0Qi80WGpzdFBHRElDTkdqbjhNeXlicmlvcy92UkZtKzY1S0I1?=
 =?utf-8?B?YlNPc0dtcFFadFhiSFlrQ293clVXTFJ0UUZiNGtpd0JpOFpZbElzQUl6S2I4?=
 =?utf-8?B?WHdVYlZRWEF1cVRsczVyNlZTRTRrT1J1WWRiMER3cXg0MkcyU0NRdFl5VHVQ?=
 =?utf-8?B?ZVJRaU5VMTV6SFFhWkZ4RGU1MnA5WVJVZXZTY3NONHd0OXpkRGZlMTd5QmhK?=
 =?utf-8?B?ZXdRMHQwRklORmU4S0xMYkV2YTlvaHZ0dkJrdm94eWpRTnkrY2l6SEpDeFVV?=
 =?utf-8?B?OVV5QW9aTDMxWUtZV1NOaGJ5RnZXc2ZrUHptQ3NuRTIyalA5Z1pOam5Sb3c5?=
 =?utf-8?B?QldaUytGYVF0czJQNjZnclloN1VhVDRUMTZrK1BXNHNhN0QvYTBwV0JGQkRQ?=
 =?utf-8?B?dXRIeHZMYjAzNGs1a2s2SDNTSzY1aE9YVHBjOTdlSXF2SjRQK3JMNTduRjlS?=
 =?utf-8?B?L292Rkc3ZWp2VlJTbEE0WWJrTW9ZcFRIenQwMEptckZ0SWx6bjJMbk1tcHIr?=
 =?utf-8?B?ZnA3MlhBUG4yc1BvWmZRMUczd3lFbHlkSThnNzlRb0tYNzN5Vk1pVTVFLzgz?=
 =?utf-8?B?WFdCZVpqZVJlMktMdC9YMXVPbXcxUzlBOUFUYjZsa0Q2UVU3a3NjamJFbXZX?=
 =?utf-8?B?aW90OWlkZFh2Uis0ZmtJR3VVcXZrWXVJV0RGZ0RnZ21Qb3prRHM3cUhsMjFm?=
 =?utf-8?B?RU9jUXo2M1A4akViSWJ1TnBDWm9SRm1McGF0cElmNFZZUlZsenQyNHM5YXho?=
 =?utf-8?B?OWlOakRsdHFPTGFlVzh5MzRxTHJrYVM0dHprVzRhdTA0V0l6NU1Cc0lyRlRo?=
 =?utf-8?B?aUJRaFhMbldvOVl2L3A1OG91WG5ObERNRTNPaXNsdDlFVy9oTnhwRDRoODE3?=
 =?utf-8?B?Y2lXYUZ5MUJaVVphdy9reDUvdkwrR01NVGlJYlJFTHA4Q2I4L2RLTHZ5ZXV2?=
 =?utf-8?B?RFM2RkhxQWhibG1KeG4rVTRrZTNhMWhPbGVNWFFRN0kzZDhIK2RUYlpobEZn?=
 =?utf-8?B?QzF3clNRRzdoeWxWS2FydTVKOTdza1M1VXcvdS9xeUFGaUsycU9TbUZDbXFn?=
 =?utf-8?B?NVR5em1Ja2pkNUtzemVPUUZQci9SN3IvMFpMNDRiamdqd0drVlhieWRYdjUv?=
 =?utf-8?B?MzF5bTI3N1l6UWJkaDIxdG9CalNBUVd2VjdIQ1h6VUlpeTh3Umc1YTJsTzV1?=
 =?utf-8?B?S2FrS2wzeFBheTJaN0xHdnlRZ2c1L2J1WDcrZnJjYmczUGVxTDJEY3JIUXNX?=
 =?utf-8?B?RVJHWUZTSmhsRFB4c0tCc1FCWEx3OURGTXpUYXo0cERHd3BER0hQVGtjazlw?=
 =?utf-8?B?bUlJSGw2VlJPZU56S2R6enhnUDFzOUJqQ3ZBV1gxRTRVZU5qNnY3eTRwYWhV?=
 =?utf-8?B?aVFnM0hCVG9xV29WakVXZTMxQWszMHlYbDhoTTZ0TDM1ZmFxcnRuNlVOUStX?=
 =?utf-8?B?ZFkvMTdyb0piSWJ5TExFcXVnM1lVc2haL1dCanRFdmEyby9pUkRzL3B2bVN3?=
 =?utf-8?B?ZVdOZ2dLMDBDbEFtNEpEeHpSd3ZZN1Q1V1NUSFhEU21FUjBqS3JUbkI3YkZ5?=
 =?utf-8?B?UGpMc1hQUVBMcnpGbmp4Q3ZTc3pFS09RTGJSUzZ5MXZ0a0RyQU0xYS9DdzFX?=
 =?utf-8?B?czI0VzJMR0t3VTlzUGlPdHJ5ZC9DVWhkSThZMlpZZDhOejA5VE5MOTRiRDlC?=
 =?utf-8?B?QnFIbHRSMGwyb3RaY0NjY3RGRHNzTUlrL1lic3RBZFNxbWU4aGtPaDhIN091?=
 =?utf-8?B?ejRkN08vT0ZjbVRZVWtNa1FreiswRkFOZE9CZXBRL0R2UnJVeDV1Vytqczcv?=
 =?utf-8?B?dk16TmdQdW9wL1k0R1lkTDBjZmk5MmVycEMxOE9kUktGZXoxUmw0WEwwZlB6?=
 =?utf-8?B?UUF2b2VzM2FiWEZ6QXNFMHhvZVB1M3JkeGVUTVNEeisvRXpsL0RUd0ZzMEpQ?=
 =?utf-8?B?eTdjYU0xbHVnMjhxNW5aSU42Mm1uVW40bUs4WXU3anc5eFNaZXVhK3FOOCs5?=
 =?utf-8?Q?xbnoXjdsjwXsraAPyAPt65RsB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	67QV3HJAolOb+JeLGWOUEydxAAVUOEbs/a71LMG1QF/8reKrk5LLa169GrTpBD7CCjVBwooW1hYwJbdTAGCKxjlip36+piO0zWL1kpIJN/7hbEsdXFhyft3XUdqglJrBJF5ihjVNNe2o3n6hwFQ6dZ4r/dK5P13T3jOf8Bipo3lR6BPHtvHejs1qaRoEQ+bx9eUY1HF1rUTxV+VRf+grs/n1OvCq5OlglaGvfxxZp/r9fOGGvnJMml6w8xfC2nSCpxLXS3/SYCnt4W794oMrlOXC0HGDP1VPad1RDXzrdQQu7rjVfbwnu5oFz2UMdYFEFUW5/3xAZXGuoyfxeHbbq3SEDtSUOrlgDqsCarGLGyUoSnbZub+/Gev4X7PLjZwfFAgk2SqNWOHZ3YTto11xWNnP+GUmcUmbqUpIxHP6VukRY+fyseLMoRGv7x67Ksg4miHuMiPOfDKZ8Vvh0BSMgUH3gHEnvTFwWO/4G41bPqbB9qLFKMRjSUGdwm5sNSqbq/5bxEuSMzrOTRhPcNrEgR/xvqmYKNk1h7I82fph2ZToQ2NM1L/fxkbOFgvNfL22oxBO3qdB/x6uIyP2tCxSfYaMzR5mJRkOYnhYfDcYCiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e572c5-fbfa-4873-9ac3-08dd4cda0d66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 09:29:17.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnzI1D74/9AUYmWKdlka8mZijCm5Z2SBnz+gsFXAd1s4YeQkDdKZ4n3jM4tMU++TmfG7e/9ZSOiSuuu9IY/Bag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140067
X-Proofpoint-GUID: 8fRqN2HuqIrrynGxZQhV1kWDvNNt-ri9
X-Proofpoint-ORIG-GUID: 8fRqN2HuqIrrynGxZQhV1kWDvNNt-ri9

On 13/2/25 07:34, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Several tests fail when running with the compression or nodatasum mount
> options. This patchset fixes that by either skipping the tests when those
> mount options are present or adapting the tests to able to run.
> Details in the changelogs.
> 
> V2: Updated patch 5/8, the chattr must stay as we really want to create
>      an inline compressed extent, otherwise it wouldn't be exercising
>      cloning of an inline extent. So skip the test instead of nodatasum
>      is present and add a comment about it.
> 
>      Added some collect review tags.
> 


Looks good. Thx.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Merged.

-Anand

> Filipe Manana (8):
>    btrfs: skip tests incompatible with compression when compression is enabled
>    btrfs/290: skip test if we are running with nodatacow mount option
>    common/btrfs: add a _require_btrfs_no_nodatasum helper
>    btrfs/333: skip the test when running with nodatacow or nodatasum
>    btrfs/205: skip test when running with nodatasum mount option
>    btrfs: skip tests exercising data corruption and repair when using nodatasum
>    btrfs/281: skip test when running with nodatasum mount option
>    btrfs: skip tests that exercise compression property when using nodatasum
> 
>   common/btrfs    |  7 +++++++
>   tests/btrfs/048 |  3 +++
>   tests/btrfs/059 |  3 +++
>   tests/btrfs/140 |  4 +++-
>   tests/btrfs/141 |  4 +++-
>   tests/btrfs/157 |  4 +++-
>   tests/btrfs/158 |  4 +++-
>   tests/btrfs/205 |  5 +++++
>   tests/btrfs/215 |  8 +++++++-
>   tests/btrfs/265 |  7 ++++++-
>   tests/btrfs/266 |  7 ++++++-
>   tests/btrfs/267 |  7 ++++++-
>   tests/btrfs/268 |  7 ++++++-
>   tests/btrfs/269 |  7 ++++++-
>   tests/btrfs/281 |  2 ++
>   tests/btrfs/289 |  8 ++++++--
>   tests/btrfs/290 | 12 ++++++++++++
>   tests/btrfs/297 |  4 ++++
>   tests/btrfs/333 |  5 +++++
>   19 files changed, 96 insertions(+), 12 deletions(-)
> 


