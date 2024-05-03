Return-Path: <linux-btrfs+bounces-4728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23328BAD2D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11E2B20D0F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA997153595;
	Fri,  3 May 2024 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D/5Idqj0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="txfroqCI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED657CAF
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741799; cv=fail; b=Z6oQl9igilEZ8YxkZt5hL2j8ODrz+0XPkuzLb5PEM8PdcVr+FH1Q4U3w3pBs7vu6561Ln4ryrChHzb9KC+vxA9+8nsMf6geW8S5FffN4EkGq77xzVKsnMjVRj2uMlcmyoyhy2TtygTBrTAb59P8rp4IrBnEIxDWGmlxqbOjhC3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741799; c=relaxed/simple;
	bh=/rds8wnVilEb0VMrRr7N87mlGS3seULQv+6anBcR5Wg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7TmygUS6ahzjOuFYDBohd9yywHKYn7+w0Vx/CTW0CuAMLgc5kWNrshcOo+78xZKMY1nMyhqmXf3Nyljmjr888hg6gumkDo4lr8gsAL5KXrli/7F7KUmUsfXCE6je9Frtj9UT+l2iAj9Y9oB3YuhM+nX++FkUyHwbXb5vlcgFnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D/5Idqj0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=txfroqCI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443C2Zxq020764;
	Fri, 3 May 2024 13:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oYV5fToGoByT4Sbg2qRGTybvJIsuT6NrMbvdpS0Hbqk=;
 b=D/5Idqj0hmGe4zRWKfE9lpqwgd/rgsmGkkam9P62pz7G2x0zPNCfsM0F3e83aKkHXxHF
 dTFPQ9pOjqgHV6bNSnoR9qb3tDntZYVsMoIAX1k6fAk+wATFXp3G4C0Hb5KYeGzP7yhi
 JLKcvlW/9AA/oHXE8MVJhJpfTBDhPSp3AcgEb4OH7dm5GCYR+GiT6VBf8uiFt7ZA9fND
 CZCaojfnH7FpAtYjBU4sfeo6Iw0b9Ux68MzeVUgh8T16ySGOI8AsvPLFOlPsQml8K8Ly
 WzTv+v6uwljKOCIn59JCzKosjFUXmTqSA3wXYa1kObVaKLOAAy1Byrqjk90CAC1jg9fV 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9d0p2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 13:09:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443BI58R034848;
	Fri, 3 May 2024 13:09:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc3bv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 13:09:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj4rJbV5w9YUPST4myKrlpULZSbo5HycROfFYuxc3BYZOk7eAOhkNHgQMWHfbz2/o5xcIaA+8Lu9RZUezdlN7E0+FZY0QyrWv2kp+dJT3yIkaQvvO0pe2/tDI/q6gXjKsi9ex6Rvva7Pw15TjvBZw7/lwTbjj4SJ5qA0OHKzItec8+jocnad/LDIJp1XaAIaptfjn1RLRnnG1qGLlahwLAAD5QMiBhb6PjLPzVAmz/hpNmbT+eU5FSxPORnt2kN8XaZ+ptlQaKkfB2YzJZQVLE9pXrqohW4AswgQD1PhNRj35kBgRjZZgStF5QXdJfz/4eUhN07COJXN1L8hjy0JrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYV5fToGoByT4Sbg2qRGTybvJIsuT6NrMbvdpS0Hbqk=;
 b=QF3YxpNh6kjqfI/AHYwVtdmkToeIkCoEkzKx1xLazyrQrmGXWHYNRC2I/0yIEm3r00K9xbVmEmxeJ3tWuFOf9siaMuLccnfl4Bp9n4vZdhgQ4tuLZG7mX6K9yEMy8TLH3mxssaz8eOkONe+XCIyNbuBCG74zFc2MVLh0EdTAJYJJr1ISHn2pSakC/dZq7Cp2UsrSVkKIpT/XkWhktfa30avFiWJbr7fK6KESs/L7r1x+VKEWgW8F3KZnFgZCwq+0qrLB+mzhYsIGQ5SkDx1Yq/RsSaF+TUgMc0HA96rh9BqL8AP/RvIL0DTEmoGXMOr2ac9IIowqQn/L22rEPKRu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYV5fToGoByT4Sbg2qRGTybvJIsuT6NrMbvdpS0Hbqk=;
 b=txfroqCIyXv8frfw7IL8YVvozCQWAzMOMpEpI1j1+KSPG7dVQuYszyzGthiXYiVwzXAFr2nsCdUt1lwCWFj0gOwwvtpg3FPt/+bZ440nT1T0r7Rk3rpIFnWGIV5EENBb3M7uhxFT7v7+vXvHd0ehz+dUb0CVj9T3M8ca7+WkZCI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5046.namprd10.prod.outlook.com (2603:10b6:408:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 13:09:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 13:09:49 +0000
Message-ID: <1cd900a0-cad5-4afd-a8a6-41d3b998dc5b@oracle.com>
Date: Fri, 3 May 2024 21:09:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] btrfs-progs: convert: struct blk_iterate_data, add
 ext2-specific file inode pointers
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1714722726.git.anand.jain@oracle.com>
 <df071a4eaaf83d9474449f281ba8b1f905922744.1714722726.git.anand.jain@oracle.com>
 <20240503114930.GW2585@twin.jikos.cz>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240503114930.GW2585@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e43bf8-3bc2-409d-b1b5-08dc6b72500b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M3hKeXZFMSt5SjlNUENzMkt4aDJGNm9UcEx2akt0aDVKY0xzajl4VzZVUE1V?=
 =?utf-8?B?c2V4QTkwcTNGL0hSUEJBbGZTbXVGVWFiUE04NzRWVzM5MXBTRERkT0IzSnZI?=
 =?utf-8?B?OTJJSG1FaWJIQnU4S1phWTdCTjFzblZ6aGdWWGltdjlRNllldkFDNHAwb1Z0?=
 =?utf-8?B?ZUlqbG9jY0ljWmpWeWxsNFgrbURYNGgyUXA3eGozNkFTWXlncmVHNm5FbDhn?=
 =?utf-8?B?OWNoRXZuUU9BTVYyLy9MaGhhZXVxbFlFMmhqWGxkMERRMEpLYkphbHhxS1FF?=
 =?utf-8?B?K0huM0xRbVdNeDVDUGtHM1JWdzJWcjdUTDlvRm9pK3BIZkVWT095Vk9XNVZU?=
 =?utf-8?B?RjJhY1kwU2hCdmk0NDVLK25rNExPYWw0eitESVFUMjNBSEIyTXdRdlE5MEly?=
 =?utf-8?B?R1UvL2pRUWRnU1RJR1U4NGZrZTBXYVY3KytlUmxXaE1VaTcrRVdYTTQ2c0p3?=
 =?utf-8?B?L2tTZmpiRnJ6UkNMWkRJTWp3a0VBODMwSmwzdzcwbDZRaVZpYWlPbDBicHdq?=
 =?utf-8?B?S3g0cUhKdUFZQTQ1NVd5NUloZGZkbTBYL3M4Q2ZFM21ud1ZCUEVzbFE2aGty?=
 =?utf-8?B?ZHJ3L0E5VXE1aTlhWWQzWS9MZnVJdm91RElKM0diK0xweEczWlJvTGVQOVJR?=
 =?utf-8?B?R29jMnl4eitsdjlKZzBOZmRmWWYwQ2pmQXEwSWtxaVNybCt5cHlQRWMzZDF4?=
 =?utf-8?B?aUZNdEttR1BKUXZhWUQzRDY2TzdsazVuekxYMG95M1J2L2VpbC9GOXlEK1ZF?=
 =?utf-8?B?VnU1eERWUFdrK2IyVlZhQmsvSmhxelVKdWgxZVdMRTRQYUJGSHdVTHptcmU3?=
 =?utf-8?B?V2syblQ4RkVuMnVjNkc5RTJxNHVLMndPK29ObmJCRXE4cUdsaVJmbDhML0Fa?=
 =?utf-8?B?UVFUMmlVOFdlN3hBYnFtNlBqN2tXZFFud0dhdjNiMFgyTkFITnRQeVd4M3ZF?=
 =?utf-8?B?UStHWGs5b0hQaXhGanNrNmdJaGpjNWFxZm44MHA4eTRlQ2VER1NXcy9jcWFz?=
 =?utf-8?B?elVTdjEyTkczbGZQaGgvRVBHME40Q0c3akxmZVNSZlZGcXNvQU9YZVdwRnBm?=
 =?utf-8?B?NEQ3OW1tRUhvUmtycHorRGtObGJlRHVqMk9rM2duRE9zNzlFZTJGelZkZGNo?=
 =?utf-8?B?cVMwY2ZqZFdTL0VrL1VFczJLaUY1MzNXRWFud2k3THZwM1VuVEg3S0d5MUxV?=
 =?utf-8?B?eVJhR3RmL014S09TYXFLVFlGWW8vOHpDYUpjMlNKS3BQd0IwMkxPQU42cENw?=
 =?utf-8?B?THhEWndHTk1aRzBFSWdjQU9ud1V6WWZ6d0VVSGxBMGxRYk9Ra212bnozclVa?=
 =?utf-8?B?enJrOGU1RVFUOGo2TWZLMlhIZC9ZaGxUbjJoM2xFTHBpK3doeXEzOEFuWFg5?=
 =?utf-8?B?bWpEWXYxNVRRQ3ZXNUFhcEQ2WG5GVzNLZzUvVnlGLzNDZmgzSm8wY1Uwb0h2?=
 =?utf-8?B?TVpic2R6UVRjdndENDZlWEs0eEZ6ZFpvdENuTVkwTmtVZmtzU2l0amlEM3cv?=
 =?utf-8?B?NGdrOXc1OHA4Z2Job2xLR3BrOWlFN0xMcWwxRVZuaXVqd1FnNWRyTFNIQ3ht?=
 =?utf-8?B?Q05MUjdvWTMvUGd6UnljVlNaa2tWaFNtc1RzV1N3eFpRbjlpZFE2VUd4azY2?=
 =?utf-8?B?VjZ4UFdJaFc2QlZBQzJqSk83RG5xL3pOWkZOUXo1NytMU3RZZTlFTnRLdUNR?=
 =?utf-8?B?bXRxTTJDSWxZLy9FSmNOd0FaQ3B6WFhIbVM4bk1oa1I2NjE5Zm85UmJRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXpCQncraC9VZHM1WVNyb3hnOWdGalJQSGpyT1V2M2VpQ2ZHNTN1RFljTWxM?=
 =?utf-8?B?dXlsTU8yTG81M2dhaS9Sbksvb25LRmRZRFA2MFkwYmdja0c4S3FVY0FTYVQr?=
 =?utf-8?B?a2dKYk51UXUwbmhhZlppNVFxeHNyREtvSjNVU1VqOW5NR3RJSlJUeUVKYnM1?=
 =?utf-8?B?eWlxM1hIQkRsb0ZDY05zd3NhVXlDNnExc1pWQWE3UDFxTWVXKzRiZkpHVk5L?=
 =?utf-8?B?TE9FOXlwUStPMk9tYnVnMlpuclUxY0tFTnNPOFU3YXZWdHhUcm9FMkpRb1NS?=
 =?utf-8?B?R1V3Um5sOFlHTkpTbnBVUUIvU3hvM1l5RHlVMU9NN3BlUXFjVVRwQ2NMZmh4?=
 =?utf-8?B?elRiQTduVXY4ZUJZRGdRVHJJZ29pVExnQVhRTlc5cGVlZXdOMVFRWVR6VlJy?=
 =?utf-8?B?NjNKN21vdDEzVGNxNm03R0dzYmZ2TnRGL1NaalRBQU5PYkdhSGdUZFNSQ3Jp?=
 =?utf-8?B?RTRuL0VTMXpXeWtYTnpadWZSb1VMYXNwdlRzNGFVNU5sTVg1REJKRnF2eWVO?=
 =?utf-8?B?L0VzWERGaXNpb2NYV3NRNGJoTXppMFpSNHJrSXFBUXVnMTYxa0Zaekw2ckdW?=
 =?utf-8?B?TmI0SUZUa0lOT1gyMnlrUGp5cU55dGowMmx5anB2SmoweFlDeXJQWGpsamds?=
 =?utf-8?B?RnU3cUppbGNzamtUZUpQSnB4SFNqTlpRMXlOcUZnWFVrWXQ3U2tUb1o5dHBk?=
 =?utf-8?B?RDZQWWNTSCt2c2VMRTJ5WENYMkR0dkJEeUN5dDRvblQ1b09NWjR6dUdIZmo3?=
 =?utf-8?B?VlJKajVXeEN3UnQ2MnZnbGlURDJwZ3RTRk1uY1k0b2FlTW1rcUc5ajlXT0xY?=
 =?utf-8?B?bE54TloxWmorUVRWSGo3dzMzV0VYajMrYzZQT3pIbHFzd1gvU3ZkbXBiVWZI?=
 =?utf-8?B?MzUrdlNNZjJteFZxWTF4ZURoMElTU2RnLzlJN3JDaVRyUGp5MnRMT0RkNTU2?=
 =?utf-8?B?ekM3MmFJaUcwTzUxZHYvUFJBd3NpRkUyd2NFQ01VeTlIR2dzL055UkpCM0M0?=
 =?utf-8?B?WkhFbXdrUkk2Z1Z3NzRSeXdHVHl5eTJmelF1ZTFvZUwzVElMSG1jbXhVcm9H?=
 =?utf-8?B?WmVxVWhNVHFza2JsUy9pN3lMOGYxSEt6SjdMQ2xDbXU0cGdaM1luWHAzV3dn?=
 =?utf-8?B?Uk5NWjMvcUVEVG84bGZReUN6WDdBeFJtTWNjMVIvekF0ekVxMzZOMUdaYW5H?=
 =?utf-8?B?aTk5cDIwYkNKcWFnSTFzNmRsNURGVVdKT0NYM1BRaVd1cjNvdms5Y1F2aThn?=
 =?utf-8?B?R2c1anovWklQOUxZVjVkVUh4YUlXbVlQSXB2REdxQzRrWXRLV1RIZWRZZ1Mv?=
 =?utf-8?B?UGx5VXR1RlR5dHZ6ZVRURUVzeGtCeWVtVksxbVluWWs5MnFGbWtsaElUdnhQ?=
 =?utf-8?B?Z3lzT2pVVVNHRi9WRHNrZHFIcHE4YXJGQlk1T25KNjBRTjRObnBlVHZFN293?=
 =?utf-8?B?WEwzSEdYcUYzYU1QazNvRHhDNTJ4VTdZTmMzblRpaEIxYSsza2o4OW1TU01U?=
 =?utf-8?B?eU5COUVQSms2RzZ2UWxkN0l6UjZlb0l4aW1TVXNiNWN1TExPb2FjU2pVZDdF?=
 =?utf-8?B?RU5YMUhJNnE0OUUrOC9BSVJUaXJ5cFQ1ZzJ1NDJKUTZnV1k4OFVNV0JaTWw4?=
 =?utf-8?B?K29GS2pXcXdZK0k1OXlYTE9iaEpKZnhIVmpvUzR3dEMvTmZlY0E1cjZ4WFgw?=
 =?utf-8?B?dDVFQW1DbjY1WjRRS24wZkZ1UThIRGtBOXpxdExRR2Q4U1RxcFBpWTNPR2ps?=
 =?utf-8?B?eG1UejRNWDNLcWVOZlhNT2JFbnMzNlYzVHorSjdjMEdvcGZrNCtMTmd0QjFR?=
 =?utf-8?B?UW12em5YME0zMkxZNUd2OGpZRSs0VVpNZXFNS1ZRNHo3SWQzZS9IcXFRdDAz?=
 =?utf-8?B?M3ZDU2I4Tm1PUmFrc2lINklyZmZjUGJLemMyaC9MSTJBK3hQNU1wNE9hNndz?=
 =?utf-8?B?MEV4Rk5MeUE2d080WUFmcitpd3JJZTZiQUw4VGpvM2wrTzNCTTdreFZDamor?=
 =?utf-8?B?TUkzc0lkVGRVaWdyTDlWMWRjTWl1ZTkvd1BVT1IrODVrb0M1cHRRVE9ucnFI?=
 =?utf-8?B?NGRKZ2RXVDZXTWpPUUxZMkIyTW1MNEFRbUg5NmxsV0FTNmRHS3VYNTBneWtU?=
 =?utf-8?B?WUxNY1BxY0pOSk9hQ2ZWNjN6aFY2L1paREd0K0N3Zm9ITkNCcko5M3l2T0Vi?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FT8kdja9+6LCweZTRRTGKRRSrZjZSNXxXLFTynSFr57sCq9Dmxug0ABCSw96InSwBttRi0woruRid1185H5zfvRzehcr0i8fbAR5uUg1rRp3g6sA6xtv3VpIVbCHZhJOPysWCdRaQMaShyh+HtDLLvkdnj0ucR9GS5B22CKN0H5unYXs2yu9Di85DiQBk97A/z1V3VDHNdPq+t8foIMzQMnCQi4xZh2LdGQueDK0eCo2WDM6+eyfP/tpdPltH5waXRWz8XJKmCGF4GPM/qQDaGMKwZmJZLCqxNIwQxTKvT8u3dHKXxDHUU7rhNOOAScls7PrCHGpU8h6U+8Rtj21L3Me+ReX9ptjoS/gxaS6JtZ+/GbylagyOO7NXvhuKoIOSU8ZzPftjI0XamVaZtNKdlwBNP1N6d4YI99C3mY8tACTH+60sB2GQtS5RLZB7PHxp/AOvTl1ezfCSDiIwRvxjb2i4z7n4A7TzSzcYP3yQj1i+LD5BgXd58yM3I4VXVVjwd/0uIRNIGkTinV3zoLwiEP+GZf6nnOPrgZMyN+u4IqVVm4wccGXMVYpX2Qat9e69LBZOjhmN8jnKzUyeMw1B0AgMMwupzHMVHSp0xiB4nQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e43bf8-3bc2-409d-b1b5-08dc6b72500b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 13:09:49.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQ8koZVmQyp6gAoiOFKyDeXrUTjnuZH+HzUEZmgAp+kg7qQHqiPhFzhYyxcbHPVWH/389qrcBFd85s7/KQJdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_09,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030095
X-Proofpoint-GUID: tfbgkXAA-hNqrtBzjc4GnFbTVVtc4CJp
X-Proofpoint-ORIG-GUID: tfbgkXAA-hNqrtBzjc4GnFbTVVtc4CJp



On 5/3/24 19:49, David Sterba wrote:
> On Fri, May 03, 2024 at 05:08:53PM +0800, Anand Jain wrote:
>> To obtain the file data extent flags, we require the use of ext2 helper
>> functions, pass these pointer in the 'struct blk_iterate_data'. However,
>> this struct is a common function across both 'reiserfs' and 'ext4'
>> filesystems. Since there is no further development on 'convert-reiserfs',
>> this patch avoids creating a mess which won't be used.
> 
> Even though there will be no more reiserfs development you should not
> clutter the generic API for filesystems with ext2-specific members.
> 
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   convert/source-ext2.c | 4 ++++
>>   convert/source-fs.h   | 5 +++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/convert/source-ext2.c b/convert/source-ext2.c
>> index a3f61bb01171..625387e95857 100644
>> --- a/convert/source-ext2.c
>> +++ b/convert/source-ext2.c
>> @@ -324,6 +324,10 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
>>   	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
>>   			convert_flags & CONVERT_FLAG_DATACSUM);
>>   
>> +	data.ext2_fs = ext2_fs;
>> +	data.ext2_ino = ext2_ino;
>> +	data.ext2_inode = ext2_inode;
>> +
>>   	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
>>   				    NULL, ext2_block_iterate_proc, &data);
>>   	if (err)
>> diff --git a/convert/source-fs.h b/convert/source-fs.h
>> index b26e1842941d..0e71e79eddcc 100644
>> --- a/convert/source-fs.h
>> +++ b/convert/source-fs.h
>> @@ -20,6 +20,7 @@
>>   #include "kerncompat.h"
>>   #include <sys/types.h>
>>   #include <pthread.h>
>> +#include <ext2fs/ext2fs.h>
>>   #include "kernel-shared/uapi/btrfs_tree.h"
>>   #include "convert/common.h"
>>   
>> @@ -118,6 +119,10 @@ struct btrfs_convert_operations {
>>   };
>>   
>>   struct blk_iterate_data {
>> +	ext2_filsys ext2_fs;
>> +	struct ext2_inode *ext2_inode;
>> +	ext2_ino_t ext2_ino;
> 
> This should be a void pointer filled by the target filesystem
> implementation that fills it with anything it needs.
> 

Thanks for the suggestions.

I hope the following will be better.

struct blk_iterate_data {

+ void *source_fs_data;

::
}


struct ext2_source_fs_data {
	ext2_filsys ext2_fs;
	struct ext2_inode *ext2_inode;
	ext2_ino_t ext2_ino;
}

do malloc() and free() in ext2_create_file_extents().


Thx
Anand

>> +
>>   	struct btrfs_trans_handle *trans;
>>   	struct btrfs_root *root;
>>   	struct btrfs_root *convert_root;
>> -- 
>> 2.39.3
>>

