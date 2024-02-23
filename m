Return-Path: <linux-btrfs+bounces-2680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7EB861A7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 18:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83184288DD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BAF13DBB8;
	Fri, 23 Feb 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ccb1yCdS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JghPWJ12"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA071292DF;
	Fri, 23 Feb 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710281; cv=fail; b=S3iymwV0DQfPyVRaNGBf940CFJTcuFLnSSeda4dLZw1BkPdzhvWDTxhOXSHMa02L1ooswOhsn+hY/u3fFHEy83RQyuOQ06Vvc7M+8BpOgYxgxJ+0o/NUBx/Ibd8oT9ll7P2QNxcxbmLiR3NrqAj6aksKCvv/C7GPCULLOipYCg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710281; c=relaxed/simple;
	bh=rztxGEWDX+yd4qul6fgbRRfdQ1tURIE8IiiycEEw+fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yt5RXX5O6fv6EQcebWt8+IUdI0/7frb860IHcve9VzK8TASm0G+oJ2Na4zKMhJRCHgkqCbJ3DIb2rgcsCeA256eGIj05RD7MP11wLuTkDFOPnJlcm/aA8VlAJy628MSWYOqfEg7zst4R27SYErndYO/uYRgtRaUI1wmdhZqEpyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ccb1yCdS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JghPWJ12; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG40dv002958;
	Fri, 23 Feb 2024 17:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WL8H0pkBsiFIsST2zrwUSi3ZLUe/J+Mca8SNwYIycV4=;
 b=Ccb1yCdSQb0bfO/8vsaq0rofLx4XioPPyscbLc3qJKGWimYqZmpECZkyyqdNuPNkxHm5
 XUT7OdVLl1llGoqq7vR2LlPZpyqIaoPj9rPDOxxSFZqI61+71qSmBh0wTMFmHcAJg5g+
 fuyPpx34Te2TkgH2cQlHxULyB6ZdFZJDoduVnUiPQgCNpRSksaMzzKcY/3V7vUiOVT4f
 I1MjzUEOoClYA4gO1RgRaR9+WXzCWVbKwakRQBsKRI2YoIppxg7lMDecL5Nrh86ZfuVd
 62tMIbg9MNOMWr47YHKwHhEv3LSr7lsATu/hspvVn/d83bVtKSPm+IScnIlXDSp3G4jJ pA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk48b2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:44:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NH3kth030656;
	Fri, 23 Feb 2024 17:44:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8cdx3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUM2jiV6itMx5bNjWSwLKnpvzkbharOTMeiUpxcU+ldCwR/8kW3pj9itzr1gsyBHOWT9UGKBfX6B5ko1L7xhS9+1hk4vIsXPlsfZahKl2z1yRp0PYsGOjWI7zmutCqCUTC7QqLRSeMLlam/mJwkSoPENOIBmV296D89b2e1c0GPVVhb+Q6VZgV3pkf0mU4+WUwd9/wb+qYsGSGnIhDer59qRL2vDB0zXLq5Y7+3KmRT4X3M1Jziof/1UMjCilK8ZAaf30dwH8hOniAAjW8D5dMdttJtPtfyW4gqeHIRYPyrm8lWFM4geuLrYNxWUeehqFbG/y2YTsfdkt3YGIY9y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL8H0pkBsiFIsST2zrwUSi3ZLUe/J+Mca8SNwYIycV4=;
 b=MbJmesiX4bFe+TboD7OUpY3wn04Vg4BthyomZRov9wOXm5VbCmQh2dNWhZ7kXy+F8YRWMkGbmjYyFE4HxtfKpSm/OTkRqSmZUimDa2lNS10z5A1cQJRcqVxq4d7+U/b1cioX0P74/qW8Ob5dZrYmOkv30O2Uzg9MHcnhdH4vLK/GcxZfy8uGESxNFwE7KScxNCUKfYUeOOErRBdnE5pE7onD6VPwph0C4r3eUMR7rpc/ntPmgsb9+bBBXS5sJNUARv5k92wyUx5SPWC34MnoPO2bGy5zcTENKcktiKKpOx9exeo/rxeg3F24pHjXoNzHt4PHgEDnCWSZf6aLFR2piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL8H0pkBsiFIsST2zrwUSi3ZLUe/J+Mca8SNwYIycV4=;
 b=JghPWJ12CsCGrj9z37YTLpchGxJgt2uCjoPHJKyKzDPjiEzf+403CfUk6N8fNOEM9kt8NRiMNhL7N27htjLTisxwvQ6Clo9H+V2HWOrNoWP/dS9Jubr2sqONdMVHfenjzql4Nq3jF3GJ3lO2Uatp4X6jwwvEGxYwRcYKAhxmI1o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7402.namprd10.prod.outlook.com (2603:10b6:8:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 17:44:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 17:44:31 +0000
Message-ID: <a5a0042e-a8c8-4e29-a752-fb1b49db5584@oracle.com>
Date: Fri, 23 Feb 2024 23:14:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] btrfs: introduce helper for creating cloned
 devices with mkfs
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1708362842.git.anand.jain@oracle.com>
 <3b00cd9a28c6728ca2bf9c216fe67bf9c01cfc83.1708362842.git.anand.jain@oracle.com>
 <CAL3q7H4xx6Jnee2vnLqdKhiJier2EfcuidA2q9QhyTYPB2LAsw@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4xx6Jnee2vnLqdKhiJier2EfcuidA2q9QhyTYPB2LAsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bb0d5c-6e5e-479c-bb41-08dc349716a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4YVHd2GnjOywqqERRi4VTSyaO60daNS2J90mdtquobcvfYHX4aW/+ufDUec3kaWSlwuQyUOdF7sWjMHghKXyFpJ8NqAIznZjgJ8u938yT7DfPAMvdDb1IyINqcJ12NPQ/MYm7INXZByhAw/nZ8gDkxPQD0Knv7eMxghOAK6PADqHVwx+BwmS/Y4ro9WSckLRZlj4ykhiAkdgy7k0kbG8rT29ibI620xJ3L8DsrNacLUIGAjz2WbSlb5V/UU3gVvLb8RefhkDq17zUduya0cfV5ik7+XYWn2GtO95cojD70L7+nl9yKIOMLWTbMwAQIG8z0g3LwoX8HUUxdAA33yDc6/JsEGGcxsdYVGmmwcuofzIwRUYnp4okj8WLr2ywe9POiCrYlbit7gK0vZ4+jBc9nns2ps2SowEIBMT91B9X02ScqvcWAYeekhFXHGhg7lMXkSfhseom5df51uLlfmZOpncZPZpB5QOfPbMPDcZ4ri4e2J2rrMw+HtgT5v1F+QGR6ZylhcTsOXAhaGBEWW8ns8ndWnxuPUtmf6FAJcGwgY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eE1hYkdKNXJXcXpVc0J3N1Y2aTgzbmNRQVNKUVJJUDVRSGwrMFYzQlVXUW5R?=
 =?utf-8?B?aE5GYjlGTmhxR3B0Ynk3WmI3MDBOclNrVThkM1pDOUJKUHlxS0FRT0VDaVVI?=
 =?utf-8?B?bklhVHE3c2dLbjJRT1JkMnpoRndUNTlFYVVIb0prZEZablhEc1RoTGVtbnpq?=
 =?utf-8?B?dDgrdUY3TUdpaUhOWjNKa2tCOE02c2VkclZKRG1HaDJFR0FScElUSjVKL3pr?=
 =?utf-8?B?RlNkOUR2TWFVWmltNEY2cUVnRkxtNlp5L296L2NtVXZMa0FCYXF2QTRYOWlj?=
 =?utf-8?B?L2tzQVBPSll3OFplL0MyaXB0WW1YY3lpNU5ldkVqU1pKSDdzZkdDL3draHpK?=
 =?utf-8?B?U3p3WnNpTGVyTDdCaUROOURLekYyMHpFcDM5T0tuSGxYcFZMUnVYR1VZdVQ3?=
 =?utf-8?B?V0M0ZXRzdTJKdTR2a2FHVU5ocVFSaHhVZGxVaDkyOHFPLzAwdnNBYXJZcHV3?=
 =?utf-8?B?YmtLS2dycjl4UG1oZmY1akZlVGtCa3lpdjhYMVcwa29mOFlxYnMyOTJEUlFw?=
 =?utf-8?B?MmFDREZmT3Y1a1ZFdjExNnZwL1VHSDFYcDdsZFhDZ09hS0tBS2lQQlQwcHdx?=
 =?utf-8?B?cVBiM0FCNnorUmpwNWVEbTZJalJpWnNJRy9mbHpMbU1Lek4vclVOMjdxT0dZ?=
 =?utf-8?B?bUJRN3RoR2IxUklYMnhoSmQ2Vk00d0JHMFFQNmI1REFDakdGblIzMzJTQ21G?=
 =?utf-8?B?VHVITE5qR1pGRnNwYmdKTllDTGR2SUNnbmJEL3FjZWwwZDhTOVVoU2t5dC9O?=
 =?utf-8?B?SUh0b3dzNHdVb3Bsc0x5S1RVR25BZU15MCtIWDBGMGtHVis5YlZWSE5mZWQ2?=
 =?utf-8?B?NGZicFhpQUxTRXNoWEx4MTlDWk5vQVRFTVpMNWNpOUpzSzJKcnVwTDZTTFRz?=
 =?utf-8?B?NmpZL01INTFqRlYwMkxOeTJ3QlBxdnFyRjVnZG96UHJBYUErVXFkZVEvVnF0?=
 =?utf-8?B?NFVuOUo4WG9hTGE0a3dzK3diY3V0Qy8yd05vdWwwNVJkTDlIdlE4VU1DZWsx?=
 =?utf-8?B?ZU9NeWRiVmxZeEptVnZwN01iaGxsaEZMMUxRRzJTVUI5ME9EbjBJZ1A1amdE?=
 =?utf-8?B?bjQzS0NkVEptdTZKeC93MmtadkdmQkZQd2o4ZlJiWmt2TVBqaXBVMHZVUHBh?=
 =?utf-8?B?b2h4Zk9pTHd4QS9YbnFReGx4Q1U3cjhYMXg4RGdxVGRQejdnTFlhKzhYM2hI?=
 =?utf-8?B?am9nVkJHMXJWcGwydWJqYm84ZGwwQXVoRUhIbGF3MFI4YTBiUjRaOU9OWXpE?=
 =?utf-8?B?NTBtNDJUWWljVEJYN2l3MDJVYUpQZW1ia2M3SGh1TzNZUUtXait0cnFFZy9W?=
 =?utf-8?B?eEZKOGN0Y01XV3phaTM1Z3pIVU05eWNleFE1UjRyRUtMcnhOV2R0RmFHeWMw?=
 =?utf-8?B?RkZ3S0wvY0E4bVVHRjA4bXplKzRBT3RpY3FVWWo3d3NsSEtVMnFLRVQ5ODJq?=
 =?utf-8?B?WkRMd0g1QWtPcXlMYmxYUnVQYU5WV0I3czdpajlhYTJSdW9EaXl2eXJSdTQ5?=
 =?utf-8?B?TlFJZDJMZHcxaHNPSFhVeFJlc0tJQnNabjZBazN1OXYrTzlrTUJkTWtGblN4?=
 =?utf-8?B?UzhzNXNLQTBRSjRoNktWTnVpTlBXMEFLNmRZcHkzSURjeGV1SzBiNmFkcmpL?=
 =?utf-8?B?TThQNWJNTlh5VHpHaFBkQ25NS0NLOThFSGtpVms4cXp2ajVKM2RjeXg3RWVU?=
 =?utf-8?B?aVVvNXExSkovTmxGbmxvU1FqN3pDUEVoaGRmMWpScnhJRDMwR3c0RW9vTFFk?=
 =?utf-8?B?ajVZR3htcDRqSTkzcXFBRzgwaFNJTjFHN1kvQUJjWWVMS0NlMHVIbWg2N1Nw?=
 =?utf-8?B?ZWR0RCtWTk95UHF2c3hiOVo4K0lMNDZOZDNVWEE0MElHbCt4RXExcWZHNkx2?=
 =?utf-8?B?a0Z5REZpUXo0T3dKQ3IwSU5mSG9kZzZIckpVcWNWek1KcHFrbENtSXE5U1F2?=
 =?utf-8?B?U2xJbEJZK0k3YzlVRHlqTzEvQkxtczYwQ1hsTjBVYUNkdmNWR2k3cVNscU5H?=
 =?utf-8?B?Vlc3UHlZejdNc01UZEhNMWFoZEhJUmp3WVo1dDNCMTFlZmkxZFVZeHR5MTJn?=
 =?utf-8?B?ZFIxR1I4YXZENUNtUUZ3SjZqeER2aFFDcnV2QmNTekhiR3A1ZTRabjgvK2NX?=
 =?utf-8?Q?28GrcG8X9SSU8n4dGRTvfa1wG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	I6QKPuEF6acmj3AiUSxFO0xGQ2gCr5sPHd9Sog6V2G+SIOGaxJPCXNgV3N1SzGLAjCEjjmI4+L3oipJo3Td8imzl0acDACFTHHzAXYw0C2qCz4qwSG/NmCf6d5pgRvk3iqcnDbwgG1D99PhZ9y4PyMMpzPQqu5qwvTXlpiQQljQfjfZ6FE1W/F68wovUMAZBc2vA/qkz8g3FEdjc7ecxgIhmr6xZnbw/SY8bZyCmlEYzdjJZxwOryFedpvU2Y6wFulZw5AgCTGqmVdPEUYpIkqdk4bMyGlA/74NNCpXeWpNQhLX+ZtQFu0hQFfUrKmulXWudPeudrZ3NP+UkDkoa+ok6XReZiJrK95caxzu/RIjL//D6PUkBYwuG3c9bRdfQFNIr/OualnyVG3nt4XSsU10CzJFZaZYUgq9nV49zL8x1VuAZ8aI6CYSt3Ae/5A6kfMXnfCibY6vRVOPIS2ck28HCfu1O3Gj06XzhfMdu+pBUPsjewISWRtBFh/uPojwvCUG8ReiUvLhhq8tIyq5MTkX/5wdqPtiZrTCufvZsEjcyJUSAEbG+dkoeiUX4ik4UKqwQouYZpIjHGf92DspICR1N2FcStM8TLyTbny+4FR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bb0d5c-6e5e-479c-bb41-08dc349716a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 17:44:31.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDArzDtNtVqgn9Vsml+J7NWLcHzx+vfYXoIuA5q6+7kVnbREJHdS+d3QoXI8LtaBcdfHjH/mxbcCFiHwPen1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230130
X-Proofpoint-ORIG-GUID: iF4A-V0SzHRZX9Ek8VGM2_Mx5aroGZ8V
X-Proofpoint-GUID: iF4A-V0SzHRZX9Ek8VGM2_Mx5aroGZ8V

On 2/20/24 22:21, Filipe Manana wrote:
> On Mon, Feb 19, 2024 at 7:49 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Use newer mkfs.btrfs option to generate two cloned devices,
>> used in test cases.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>   Organize changes to its right patch.
>>   Fix _fail erorr message.
>>   Declare local variables for fsid and uuid.
>>
>>   common/btrfs | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index f694afac3d13..c3e5827562d6 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -838,3 +838,24 @@ check_fsid()
>>          echo -e -n "Tempfsid status:\t"
>>          cat /sys/fs/btrfs/$tempfsid/temp_fsid
>>   }
>> +
>> +mkfs_clone()
>> +{
>> +       local fsid
>> +       local uuid
>> +       local dev1=$1
>> +       local dev2=$2
>> +
>> +       [[ -z $dev1 || -z $dev2 ]] && \
>> +               _fail "mkfs_clone requires two devices as arguments"
>> +
>> +       _mkfs_dev -fq $dev1
>> +
>> +       fsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
>> +                                       grep -E ^fsid | $AWK_PROG '{print $2}')
>> +       uuid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
>> +                               grep -E ^dev_item.uuid | $AWK_PROG '{print $2}')
>> +
>> +       _mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2
> 
> So this function should call:
> 
> _require_btrfs_command inspect-internal dump-super
> _require_btrfs_mkfs_uuid_option
> 

  Added these two perreq to the helper function.


> Instead of having all the test cases that use it to do those calls, as
> mentioned in a previous patch.
> 
>> +}
>> +>>>>>>> e22bb3c816c1 (btrfs: introduce helper for creating cloned devices with mkfs)
> 
> This isn't supposed to be here...

Oops. Now removed.

Thanks for the review.

-Anand

> 
> Thanks.
> 
>> --
>> 2.39.3
>>


