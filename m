Return-Path: <linux-btrfs+bounces-10123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36319E834A
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 04:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC34165830
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095DA1EF1D;
	Sun,  8 Dec 2024 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFn3w3t5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oG+yOlTK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A1EED8;
	Sun,  8 Dec 2024 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733627649; cv=fail; b=LJRqrs2Api5DfC3GmiwyOgVF7pWr/oxcK0pGWyHQYywB605ZbmcgT3ng+lv1y3n/3ysYoEL4RI1TjEM+GvgkTmacMs+2FuRGDMi+AjDUj+cPYhcYxrWIMZ7sODgGH+htR62l7PyvGPbiuzr5/al31bNUTK9p4ptsAilfPka1QnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733627649; c=relaxed/simple;
	bh=Jx+m/7WERU6UQzSp6Vn7ipl+NWCR+GOL7Wv/oi6XNg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SHAOfMezFB8FumkvUqs6FIgOOSXmL6GJjLT4pTxVhHuk308D4G29ZoImlFbAg3FaSvNf/+0Ca+swGd8sYjBvsrKT534TJbcOwP8XTriP8cbeITT6BE3XEiRnUc+CzwzhR7Nu6HAhIOjF7J+7MROQDXSn4Dde59P6BXF/rsykGac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MFn3w3t5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oG+yOlTK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B81kvXY024201;
	Sun, 8 Dec 2024 03:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rbF2GY+8j4R3qajM7Xkx67QdN7kRNfyo1W3IloPAV2E=; b=
	MFn3w3t5Q3hABpogmahaFYzOxzYLl/hN9elfVTzx5cdDTfjvaBQXPsJ22Ga5Hzry
	phWnoGE68INYMc0QXX/TuR+gLtPmqSAd7Jud9tpI8m60aYlrs2ZQTglZGavB3hut
	+S4WrZW2ReXVyPH0oMiWGv0yh0Qg83dVFIRzxYL+Pp5LoEBfxvx9Wgk0qsq6kqM0
	tt7TW9R+q5Q37RNSW3NlvU/x67sS4khZ3HvLEC7pgfKuqdy+CFuCoxejXIf1WGLC
	StAdjIv51KxmwVupFLfw6crisV/yc+1RhZInurlS4X9sy/1oqxySGm9STdbJqajw
	5PEGV2/AYVmTan3XmjIjtA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt14sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 03:14:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B837TBL020563;
	Sun, 8 Dec 2024 03:14:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct5p06r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 03:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imGPNlhJ7oiXBz4/rux0knpcw7jCTJaT8BzLepIYcTTHlBBm1u/6Dz5eyezImYpxUVbjSysUlOS8nICI5bhrss9hIHbskiG7YHGujIZBQEnL8/HCdGCj6wCMOW9mDvN/wfLVRV5X/+UhuxXA2C1AFfxY55M9AtKi0g1SWAOp/UoH1Yk9tmX10nEUf0fvzdznNDcLgNyhWJA7glWrFo01xrZYkD7QdNcCz4bWFNFWVCGz9rCEP1QVOIlAuMQUZGQ3r33/XciXC6rzzd9rEa21oRrjDPfSSJ2xoLFmDGE38yHWGZnJ3SSAm0MR/wKFALnk60BcdY0RWMPsIs6msn6hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbF2GY+8j4R3qajM7Xkx67QdN7kRNfyo1W3IloPAV2E=;
 b=uC/8VcqSF3MgEuh2mva9MXWF1Hq7ennvZ2BSJm8oPL5QXB6W9Ow7ZluFdT5JSWVhMBWIMURedo6f5UyQrYPTzkBFOAi0nie8PZA5SYoBCM2e/yEpZN1roTqNjPWvgj0yf9+t/9n/j0O48179UoA1UFk9cDW0ajiiwCwRxb01m66HRNooB+XHAkkWZ5IpJW4qiUsuk+DRkgiRPwlwgx+VWyZwGsXGE70+9mdZztw1m/Poozlx/mztPgFe4Y8l3rNMrdcTs/v7s5aZL0uZq0XURwctXkgI6VMq/96JW+tqmeYaQsWzlGASyDdoJshTKIxZdGyRmwjryrV2OmEdaT0q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbF2GY+8j4R3qajM7Xkx67QdN7kRNfyo1W3IloPAV2E=;
 b=oG+yOlTKA1wDDWrZ0xiHJSQTSGf5Z0qiLZWIi59ypiukJBEba3Arl92FMBYkoS/XhjGx3PAUNRYL5wS7WETfNFerXE4QM6AhdFIfm09AZyawy1tQJFkgzo6TVgeexEOERaoIhSBnXrc18LgkHBNNraALCwtLF+9yMXHGf6Yksug=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7633.namprd10.prod.outlook.com (2603:10b6:806:375::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sun, 8 Dec
 2024 03:13:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8230.010; Sun, 8 Dec 2024
 03:13:59 +0000
Message-ID: <2db76e13-443f-44fd-b3a2-3e1076606228@oracle.com>
Date: Sun, 8 Dec 2024 08:43:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/327: add a test case to verify inline extent data
 read
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20241115091926.101742-1-wqu@suse.com>
 <20241129030231.shgqx4ot4vbnht7w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241129030231.shgqx4ot4vbnht7w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eaff6ec-0e3f-4475-e958-08dd17365bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkdhZ1hTd2Y3Uk1RVU9zSlQ0aGVVbXpsNmN1RmVKcC9hZ25LVnVzeUxGeEla?=
 =?utf-8?B?d3JjdmZ0SGtHVVF2UDhHYjZJcmkxRDFyWkR0T0gvVldYOVUrZkhaVVRxSDZq?=
 =?utf-8?B?czlIUllnVVlMQnlzWWlDUWU1dXd1MTgzR3hoRU5NWnhJYStyQm11SkFJK0pP?=
 =?utf-8?B?NXJxc1doN3lmQTY3aGJtRDZFTnBaakkwbzlZdTJNaWMybVBsZ2FYOXMzZHdj?=
 =?utf-8?B?VG9xeGJvb3hHOEdpWXZmWHliZ0c2Z0kwdjB5RGZBbDI4bHJ5aTZKTFh5R3pn?=
 =?utf-8?B?OVpUakNWT2tuNytzVkFGWWpJSUgzR2FKbzIrNUluN0FGbHZuZExEVXBRVk9B?=
 =?utf-8?B?bjdjaDB4blg3ZW90ZG5CTnEwS0JMK1JSS1AvdGc3WnpsZnVLNE5Vc2dvaFo3?=
 =?utf-8?B?cDFMZ1o0VnR3YUNmRTZnVEpzNGpnamJmZGZ3eGpwRldpUWFGeDN6T3g2a0Fa?=
 =?utf-8?B?SzJXejJGQnRPSEFsMEpHYWU4WEpIa1pzQi9aM1hqK1hWU1JyMm5aUDdVbzU4?=
 =?utf-8?B?ZkNvVGY2by9BQUtaWGlBcWRhb0lBbUpCbFlvNDA3QllrcERvNUovZ3U1eDEx?=
 =?utf-8?B?aXBiV1lHMmthREl3MG9CUytOK1dyc0NFRUIxTTYva2hFZW9tejhnM1RIUXkw?=
 =?utf-8?B?UkZmVHB0YTlncWw3ZFFSY2xpN0s5c0RTNllUQS92QnR5NUlJaDNpNlNJTzNQ?=
 =?utf-8?B?cVJtUXVUNmZhUjN0VDFmVDdCcUVyL2JlYnBTQi8zb0k1WCtrcEZ1M09zK3lj?=
 =?utf-8?B?Vm1FRE8vWlFLUDdIS1k4blVJOEZOZVJTRU93UGMrajd0VngwS2ptV0lkNlhu?=
 =?utf-8?B?WlpRNWpMNDVGNUlLcmVRWGk0NmVxVGtoaGlrNUdxbVdpOGY4MnBFOUUySENp?=
 =?utf-8?B?MHh2M256REtMQU9YbEF2NWk0R1Nva0IzTmYvZVA0bUU4V3BNank2S0l1NDlz?=
 =?utf-8?B?dHBneVFhUHcvbis1VEFoa1NwbVJZMThzeU13N0lRclhZSTB4UkNSVlM4TElE?=
 =?utf-8?B?UGF3OHJ4STAxMHVQakowNUM4U1E0RytoYU5UM1NoMkJkYVdJU3doUisyV1po?=
 =?utf-8?B?d3NjSWxmNmdldVdQR004VFIzNVJENkJwZzFRSkVVL2VkbUN1T0VsNUVBZmxR?=
 =?utf-8?B?WDNPOEZ1VUlldndWSmJZeW1ITkZOcDZxQXpIS3JSMW1XNWllY0dUbENpS1R6?=
 =?utf-8?B?b050LzNWTDNKaWloOFlyb2VUeXpHMzAyQ2Z5eDcrdGVady9pbFlOTXF1b0ty?=
 =?utf-8?B?cWlxRnphVEpuNWpJMXBYaVVmUXo3NGhEVmUwZE9jT3AvL1lyYXl1UnpmTlI2?=
 =?utf-8?B?NlN5YVBzZUVpN1Y2VE1MU1dTdW1DWXRNL3VhM1VmK1YxaktWMnBiR1h2cFBS?=
 =?utf-8?B?MWxMdWN1OFJUQTdLMm03Q1Y5VmVoSlhZem9ISlc0c3FZK29lSmdnNVJXT2ps?=
 =?utf-8?B?V1U4MFFyNzFSYzJLUUtsVlJ2MCt2OG5LeU9yVkFmTXhsdndMUjRoTXFrUWlN?=
 =?utf-8?B?dVVHZnljclpyUS9BSEpobDdNRExrSElvUEdnOU04MVA0U3pYNkxmQzJsbFV1?=
 =?utf-8?B?NHlrNmNadGUzbGVXaWc0TXIyM1U0cHllajFjOTdrcWRyZmh5eVRaQnNXVzBJ?=
 =?utf-8?B?cVBkQ1AwazEydTBBT0daNFkxQzRkTXVFSi9jL0lQS3MyLzhnY0F5YlRNK042?=
 =?utf-8?B?UWNxcDN2M3hkekhmbWI2S1VBQjNucktrOE52VGs0bUVuajhJR1hyUjI3RDVo?=
 =?utf-8?B?RW1NS3IzeUlFbnhSQTZYWTRyNTBKYkdVbmlGdGZSZzFGNWQ5enRtbXk5dlky?=
 =?utf-8?Q?4eeTnJ9uT5LInoqX9j5eQRz4i5aXwSeV6Fnv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2UwN2lyMjB3MFk5VW5LajNaclNEZ0NCRDU4OEU1Qnk3WFlJTDdSVU1HVEV4?=
 =?utf-8?B?bWpYZWtjSGdyUko5QytBNURlN2xqVUR2RUo4aHoreXl4UFdUTGFaczZpNmM0?=
 =?utf-8?B?UDRaZUFCZ2lvVGxQdUkySnY4czhqeTdNdUpnU2FpbjJMZGZBV09PaHpUZW9p?=
 =?utf-8?B?aFM5NDUyWCtVQ0syNWNDT3R1amI4R2p6eUNic2MvZVN0eVRpanI5SWdEMUFm?=
 =?utf-8?B?TnpSSUszVVlscHZmNmdMYTBzVWFTR1hxV3pSYXpwR2lCTG0rUmVNcGtSd1Vt?=
 =?utf-8?B?eGZOMWdleU52ejN2UG9yR1IvUU04WW96VHNPNmhhVEpaTjZUMm15MlBxNlZT?=
 =?utf-8?B?Qi9hTzloVjAzbVd4R3dHeTBiSysyTnVXazZjMDczeDhNeUQ1R1VSYlNMcHlu?=
 =?utf-8?B?ZzIwWlV6dW1aSkFpeXYwTWFhc2czd0ZodlR6aGdmdnE4MkdsOThiNnkyN3FB?=
 =?utf-8?B?ZDNWY1RxVXVFRE5oUGExeXZCaGw1YWpZUU5MRHBGaC9mMytHWDhMS09PaTk2?=
 =?utf-8?B?T3FYY3hNTHM4bi82c0JIRENtR2d0U3lScUNjWTd3WlZqU3EwMUoyVjJiaVIz?=
 =?utf-8?B?bEJ0WmJRK2t1MXBMUkp0TnliQjIwTUQxNXpGTDVOa2FOOWVSUE96UUpLbjds?=
 =?utf-8?B?Vy9BSmpMOXVBalhsWWFNcDI1cWNabGttK2tpSk5EQTJDam9WamM2cTBWM3d2?=
 =?utf-8?B?blhCSUphYmdnSllXNGd0M1prdmlUd2REZUFiNGc5aHZRQ3ZJdzNYMm04OGN2?=
 =?utf-8?B?VGRHRjBBbERvNW42MVJETjgraC94NkNpSitaMHhMMnUvSTdxSkdoZ09VenJO?=
 =?utf-8?B?RG8wQUhLd0N5NHdWQXJwNzFvUmpVVVRYUGhvVDg1bTNTQ3Z1bUlBQkxrYzgz?=
 =?utf-8?B?NU1Ic041aTFYelArQmV4MnI5RWZLeGVTOHNJOHg2ZTcyQWV2VXpuYlNGZVo0?=
 =?utf-8?B?cVpod3UzUElWTmZIUXlSdFYzTHp1UXNyYzgybkZjZmRVN1FmYzJtc3Z5OXh3?=
 =?utf-8?B?UWtza29zMm90cnBNN0lzenFSN0pSR2hqWE5EdWtBa2dIeFoxY1RBdGFKUHZy?=
 =?utf-8?B?cHM5YXk0N0RYcTYvTGMweTVNQmE2N2ZpdFBuUWNXeHF3b0xTZFBnaU1Ecmpt?=
 =?utf-8?B?MjY4anlYQnNidUwzVGpLS0lTL3NPSnlObU1MUWxIM3g2bHNUVlNTWkNPYWZn?=
 =?utf-8?B?T2FLR250SFIweHpMY0p2S1cyUy9kRzIyZi91OGRic2NBVzEyaUZaWkxkM3JI?=
 =?utf-8?B?b3RickdBdTAzTXdzamZTTVFLNTlXeFNmMW9nNy9TUmMrb2JpWVhPc2tyYSsw?=
 =?utf-8?B?UkhRc29iaGo5UTdmNWlkYVRvMFRUcnBHbitTUlEvK0lIdnhkSDNSSHpJSHBC?=
 =?utf-8?B?QWg4L1pvM2dldkJONDNiTllVcTRneGgzN3VUVitxUE5EN3IvSnI2dG9BcW9p?=
 =?utf-8?B?bEZZM1hkdStXQ05wNHh0VnkrdkFVQ0N1cmJrTVVjWUd3L3d2TVUzYkE0TDJx?=
 =?utf-8?B?WExsQmtTVHRSdGFya2E5eTlkL3hZb3IvR1ZGT1ZDTFpheGZqV1U0dUQ2dU5R?=
 =?utf-8?B?N3JQL1p6UXJ5UVNFMVBvRHpYampuMlBWQTJjZ0FTRVJHVmlLTzBhNTFqREZD?=
 =?utf-8?B?L0hSSGVCcThNdnlaNWhwblY5S2dwOWJBa2RuM1lVSlJQbGVHVUs4dWhJSWhs?=
 =?utf-8?B?eVdveExBNjJCeWNScXFVc1Y1Q0R1L20wNWhYZ0dxblFvd0FQbTVYSEpVdDEv?=
 =?utf-8?B?a2pZYXR0R3JjbDZ3VGRZZVZpemZQRkt5RjVobU9TZCt6QnBjaW56ZXNDQmEv?=
 =?utf-8?B?dFZPeGRWZjdxK25XQi9wTVY4QWhOOEFCZXFCdWJMWWpuVDU0UWhqRGJSL1pG?=
 =?utf-8?B?K0llZWFjRGJUaGx3SDZpaHhJV0ZyRkplSmtlbUZpOW1hK050cW4wUDhrRkhs?=
 =?utf-8?B?TzJLdnhtaEpzV1g4cEtReXFzU0V2aFBEZlJvSU14YzBLSy94QSthSWNQN0li?=
 =?utf-8?B?K0k1TzZyS1ZoMHZaSXc0UzYxL1hKbnZRdWR2RlQwYzUzUnpiRTBXa05xYitF?=
 =?utf-8?B?ck44QTlCenJBZE54YjB2Q1gvUlpRQXkxRDBweFMwaTNyWW1rcElUblNYVC9i?=
 =?utf-8?Q?Kgq6mlBG3YeUKzN4jgAFZSxKw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9rNpBxDbJ6WA7OF19cbdRcbsk8FGAxENedFO8W9DWzafRxD7YEM71Oe7azrpfzbYibeO+zWHLCe5JzykyoGqDdVi/Jbst4v/THKzsRsjm3WrpaBUYV+hyGqboZIwSU70cZ1R7Lg+nD8Go0V+Osd+N3GfG3uV/yJ3Zy/6SLW1CTJLpwipbcuQybPEC63shvmY5efr9dBjLg91k3vgz3Rxw8sQPRharszI35B0nSGjmAgRYhpLwIwF+zJRNh8hGPcRZjo1AEaw/l9aP910I3RItRDP7ZQtA6+5tsURWHe+DdaHI/ajrvx5JdC+rxOkaT2LmjJTBQ4V7xgqkSx5SIu+EFw2jhku06EwQFPPkZzdFKEzzbEsjs1k1kN0O+xuhKU/sOvLSddpnouvIJ500nkIgH6vCbqGxJ/7Baqg9oI3kHSvnpNnJ0Y5TaMSxkpsVDUsD0+s8Hw3YBWx7VJoOPT37gqQrJ7LkPt5xzSOqtvn/Fg0xR/ZiaDeO/NVl0x1vdX8sEUVnSj+bG46C7CdD9UvCBc6kuQdoyUmF+v6rI57E0fYSTfkLoY8Laxqy/krqbPaF6ZpO0SXsYBEk569XHwHFg0a6llmHCgGK68ZYGO5xrE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaff6ec-0e3f-4475-e958-08dd17365bbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 03:13:59.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7S+Jq0MXOdN9U0TDKgFi0fxwL8hphQ3DhTgdgRK681gFqQ0tJfvngRNys+6CEU3ZxQ5MSkR+fVjN0i0JHPyyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-07_07,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412080023
X-Proofpoint-ORIG-GUID: zVbi6bm68DNgDP3thdHR7Se8y_i8Q6Y_
X-Proofpoint-GUID: zVbi6bm68DNgDP3thdHR7Se8y_i8Q6Y_

On 29/11/24 08:32, Zorro Lang wrote:
> On Fri, Nov 15, 2024 at 07:49:26PM +1030, Qu Wenruo wrote:
>> [BUG]
>> When developing sector size < page size handling for btrfs, I'm hitting
>> a data corruption, which is only possible with the following out-of-tree
>> patches:
>>
>>    btrfs: allow inline data extents creation if sector size < page size
>>    btrfs: allow buffered write to skip full page if it's sector aligned
>>
>> [CAUSE]
>> Thankfully no upstream kernels are affected, even if some one is
>> mounting a btrfs created by x86_64 with inlined data extents, they won't
>> hit the corruption.
>>
>> The root cause is that when reading inline extents, we zero out the
>> whole remaining range until folio end.
>>
>> This means such zeroing out can cover ranges that is dirtied but not yet
>> written back, thus lead to data corruption.
>>
>> This needs all the following conditions to be met:
>>
>> - Sector size < page size
>>    So no x86_64 is affected. The most common users should be Asahi Linux.
>>    But they are safe due to the next two conditions.
>>
>> - Inline data extents are present
>>    For sector size < page size cases, we do not allow creating new inline
>>    data extents but only reading it.
>>
>>    But even all above cases are met by using a x86_64 created btrfs with
>>    inlined data extents, the next point will still save us.
>>
>> - Partial uptodate folios are allowed
>>    This requires the out-of-tree patch "btrfs: allow buffered write to skip
>>    full page if it's sector aligned", or buffered write will read out the
>>    whole folio before dirting any range.
>>
>> So end users are completely safe.
>>
>> [TEST CASE]
>> The test case itself is pretty straightforward:
>>
>> - Buffered write [0, 4k)
>> - Drop all page cache
>> - Buffered write [8k, 12k)
>> - Verify the file content
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> For anyone who wants to verify the failure, please fetch the following
>> branch, and reset to commit 4df35fbb829dfbcf64a914e5c8f652d9a3ad5227
>> ("btrfs: allow inline data extents creation if sector size < page
>> size").
>>
>>   https://github.com/adam900710/linux.git subpage
>>
>> The top commit e7338d321bdf48e3b503c40e8eca7d7592709c83
>> ("btrfs: fix inline data extent reads which zero out the remaining part") is the fix.
>> ---
>>   tests/btrfs/327     | 58 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/327.out |  2 ++
>>   2 files changed, 60 insertions(+)
>>   create mode 100755 tests/btrfs/327
>>   create mode 100644 tests/btrfs/327.out
>>
>> diff --git a/tests/btrfs/327 b/tests/btrfs/327
>> new file mode 100755
>> index 00000000..72269fc7
>> --- /dev/null
>> +++ b/tests/btrfs/327
>> @@ -0,0 +1,58 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 327
>> +#
>> +# Make sure reading inlined extents doesn't cause any corruption.
>> +#
>> +# This is a preventive test case inspired by btrfs/149, which can cause
>> +# data corruption when the following out-of-tree patches are applied and
>> +# the sector size is smaller than page size:
>> +#
>> +#  btrfs: allow inline data extents creation if sector size < page size
>> +#  btrfs: allow buffered write to skip full page if it's sector aligned
>> +#
>> +# Thankfully no upstream kernel is affected.
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick compress
>> +
>> +_require_scratch
>> +
>> +# We need 4K sector size support, especially this case can only be triggered
>> +# with sector size < page size for now.
>> +#
>> +# We do not check the page size and not_run so far, as in the long term btrfs
>> +# will support larger folios, then in that future 4K page size should be enough
>> +# to trigger the bug.
>> +_require_btrfs_support_sectorsize 4096
>> +
>> +_scratch_mkfs >>$seqres.full 2>&1
>> +_scratch_mount "-o compress,max_inline=4095"

Also, can you please add a comment explaining why max_inline is set to 
pagesize - 1?

Thanks, Anand


>> +
>> +# Create one inlined data extent, only when using compression we can
>> +# create an inlined data extent up to sectorsize.
>> +# And for sector size < page size cases, we need the out-of-tree patch
>> +# "btrfs: allow inline data extents creation if sector size < page size" to
>> +# create such extent.
>> +xfs_io -f -c "pwrite 0 4k" "$SCRATCH_MNT/foobar" > /dev/null
> 
> $XFS_IO_PROG
> 
>> +
>> +# Drop the cache, we need to read out the above inlined data extent.
>> +echo 3 > /proc/sys/vm/drop_caches
>> +
>> +# Write into range [8k, 12k), with the out-of-tree patch "btrfs: allow
>> +# buffered write to skip full page if it's sector aligned", such write will not
>> +# trigger the read on the folio.
>> +xfs_io -f -c "pwrite 8k 4k" "$SCRATCH_MNT/foobar" > /dev/null
> 
> $XFS_IO_PROG
> 
>> +
>> +# Verify the checksum, for the affected devel branch, the read of inline extent
>> +# will zero out all the remaining range of the folio, screwing up the content
>> +# at [8K, 12k).
>> +_md5_checksum "$SCRATCH_MNT/foobar"
>> +
>> +_scratch_unmount
> 
> This's not needed if it's not a necessary test step.
> 
> Others look good to me, if no more review points from btrfs list, I'll merge
> this patch with above changes.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/327.out b/tests/btrfs/327.out
>> new file mode 100644
>> index 00000000..aebf8c72
>> --- /dev/null
>> +++ b/tests/btrfs/327.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 327
>> +277f3840b275c74d01e979ea9d75ac19
>> -- 
>> 2.46.0
>>
>>
> 


