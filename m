Return-Path: <linux-btrfs+bounces-10409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C49F342D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 16:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66CA1882232
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1831465BB;
	Mon, 16 Dec 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F8IpLrcY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xJIpbjHf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544F13B7BC
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362086; cv=fail; b=ew06GI+WiAtjR3z0ertB+Qf7i8bHwUfTQ4Yyj88jdq0foCd+c8fmngRNfn540c2V0KsvAflrdGSLjPjFNQZXxennM8fI+gQxUxLLnDr6xhG0qRVOVUPU3I6Kld9l+GGRxf165hI5GxPvb7MsLFxzASCJoI7kK8OyrNlQQepSxIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362086; c=relaxed/simple;
	bh=Bh8qlNmHU89GsJxQWu4r21fANlIEdNSvoRRu9yEQo+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P/SiTUBToZxFbwOXZBxv3tFZqD6mxnELcKs0It/dHKaPlGLRf4NuCfDZc82S7aMjQBxllkyMkmi0pHr5DxJ7r1tOmFx9GnwddebzKHla1AYNKyKgnxOaZLbWWVaDDAwjOYIZ6h13VRfSpB+yM+jeqTz+x2tbpGHEHoSR3kKaB9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F8IpLrcY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xJIpbjHf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEtrgh013988;
	Mon, 16 Dec 2024 15:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wcJ45t0oOld7D3SHDhzXkB6vY2hNEkW81bKG0oanvyY=; b=
	F8IpLrcYzbgvxh1eIkHcff19WDmu1DJXtwYCDJa22w0dtzoDlXbKkF9TmPLk2gRt
	dPUtcR8zkPdZHJykzI7Sape3hhFaXJt2J1cku2hwcx6IvETqSSjyJ5DEDIQEWlQO
	5i8B7JPLa01baTFAXuWOy/DR/VNqEvwNt8Z7Bh/2SJRgxafLNxS2LvWhjwEpyEQg
	qKrymiog3iIn5wn4rhAPAf0SOvbHYBua6yrrxpajd/Si4ANnj6L1wGOCfDFD7XU4
	VLIpm3P4OSWLAkrrmSdq8+1YDXBjm+PZoC87efA8kVzlx+MuhhxY4nseXk0pcGOB
	+LzolFW3psUXIuKzS02loQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj59ad7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 15:14:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEoskE032652;
	Mon, 16 Dec 2024 15:14:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fddphs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 15:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsBrcquFHk635g6i4ZYwYCjpXv/t0IVcLGl7mGJACyVoSpOnJ+PnqmLX5euqgL/7O0K5ZNrUwTi1lyCgI0lGz7MiEmI2SNgr8JQsZWgsOks5OXyXvxIDrfgvHV9cdTULIj1FuM+yTDKofH++uI7y1yCzx6m6nVoOTIioRfo4Om75no7KXeHKCIUkErbKXt2Dod9LQ6KtLTT78NCEc+Rx5ZBR4HiDE97/Gtte++AOz9jSGbV67pR1GCBIucDF9D3+c9DTuR282S1Rl05lzF15mWpzBa/NIQ3zh0/nljbSqzCZ0cN8gt1mw0DJVUM4TWI3lFcb92sJPVNs0AZ1+XLhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcJ45t0oOld7D3SHDhzXkB6vY2hNEkW81bKG0oanvyY=;
 b=TTmAEmBG8AdNzSnVbm7eN+5zxHHiTA9SybWFOIwv/YYS7PC6PSApoIT9Nn+Uauklizycc4AmaHDY52+b5NsadYZ64NxOhf/25FONaqvtRF1MmL3C6QB4x8WvRWBgdrbNrgkz2fFxwjyw4qQcvpyX/pp9O5atBLJ41xa0XFbDgvwxqSaHpg+88W6GrbgWxa91U+iE7aJ0zs4b2lRdq6zFtq9eKJjVbtPIEWuX2jVr5osNyZ+TBztOf7BJt5kSDb/Mt9FblYU27b7a9riBcN1OxYkLxTorQkWLxKRUubDvK4StCE/ot5zHG61XG/4seVUDk32kzsnur3D3W5Pk3ctQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcJ45t0oOld7D3SHDhzXkB6vY2hNEkW81bKG0oanvyY=;
 b=xJIpbjHfTvSMAa+jWYFI2IZsGI3fBvSAeJaz0W2eu7NkHDvuDa4ZObvbu7vFeKCZrNVAiKEVGm/wpFjZ+/cTCdCbpocu//q+e2gLvf67jae9UdnOR9jA4cFr2LDUdZ7uRPyJiTAUoiwBIsgLNsmCha+fyNyfEWIcWTsuLFO7ZkQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5713.namprd10.prod.outlook.com (2603:10b6:303:19a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 15:14:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:14:06 +0000
Message-ID: <9ad8dbb7-bb39-4a41-96d1-4b66e1c929e0@oracle.com>
Date: Mon, 16 Dec 2024 20:44:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] btrfs: pr CONFIG_BTRFS_EXPERIMENTAL status
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
References: <cover.1731076425.git.anand.jain@oracle.com>
 <a3749f20bc368ce20781f7a294d78a39386cd234.1731076425.git.anand.jain@oracle.com>
 <20241206171626.GI31418@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241206171626.GI31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc758b4-3613-4776-5d22-08dd1de4485b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXhPbEVIZnJHRGRDRGdKb3puQll5WXZDVHNjOTBCZUtZcmNLYm10RkNxWG5S?=
 =?utf-8?B?QWo4b0c0SFExNHhtNUlQOU9VSTU2K3hYNm94Yk5icEZUeTQwckF5aFpiUFBt?=
 =?utf-8?B?eHB2U0dndTU2eXc2VFp5cXAxc25FMkxrQTBRMUxIaE5DOHhzUU5CMCt4NSt0?=
 =?utf-8?B?MVhGZzY3VTRkUjVxT2VnVnYydmNJcUVwOHdnMS9mNG9XWVNyWk5Ed3BQOUdH?=
 =?utf-8?B?dU9nWnBqQTZXNGhIaUFOMnB6aWs1Vk1ha3FrYWRaV1RhMnVieWMxUHBOaCtQ?=
 =?utf-8?B?WlErMkU0K2s0ODdvaWNyNHA5MWpoQkNFd2t5Y3ByNHZyVlhZOEo3algwOFo5?=
 =?utf-8?B?K0RBQWtmaTQ0NTZ5aHVFWS9RWWhxUktGaS9yTk5tdWx6WmJaeEJ6NHFVZ3hn?=
 =?utf-8?B?N3lUamFyVE4vMU5PQ051OVpUOVJZaGtFL0J0ZmxLVmFjVUJtZEVjSVpKMXpN?=
 =?utf-8?B?MWo4eTA5QVVPUHFqZEhNTE9Da0VraVRSMU1uQ09ubkVNSDhPQTZLcERaRXlx?=
 =?utf-8?B?RER5UlBtVzBTcHlWbFhSR1AyNDB3SkY2TVkwZ2ZZN1RJNkVJMzUwSGlhdjgv?=
 =?utf-8?B?Z1o2ZmgrZUZMNTNCbG1wYnBFREZ0SmNPTUNDRnNMSG9iR2VVTll0UnFocDh0?=
 =?utf-8?B?ZVVHRzQydnp5dDNTVFM2Z0EzV0wzNXlReSs4d2x1bWYwdlFKVWxreVpZdDZw?=
 =?utf-8?B?YU9vYkdNSnU4RDVIenplSkgyM3UwTlBGNm84VXU4NkF4bkxmeXRieVdPd0Fl?=
 =?utf-8?B?dXp3d0dEVVRvTG1YK244dlhpcEdyV1V6SklKckMrendGQllIeDBHZzl0d09H?=
 =?utf-8?B?c0djdDZRZjlkZ202Rzhhc2xWbGI0THhDV1gwbXNuc1ExdlcyRE1FMFQ0ZFdN?=
 =?utf-8?B?SkxXY2hOVFFGZm9sK3MvL3g1WWpUZ2ViQ2FMeFZYU2hQcVMxQ3BPR09Ldm0y?=
 =?utf-8?B?bnZRZjRHSXBzRHRkOXlGK0FvYStDWkUrb3MrYm1wcmxHNnBLQTBNd3EvNHBF?=
 =?utf-8?B?VzR0K2xTTG9ZN0VhRGZGRkxYV2pLRGRqMjhLUm9XVmJjVkt0U3MwdVhXMStQ?=
 =?utf-8?B?SHo3eE83LzlZTTgyQXRxYTBsZGE2TFM3RitZeTk2ai9jQTJrNjMzSUg5bm1s?=
 =?utf-8?B?U0ZSWXNRNzdrSFYydnVlWTFpZlowSTFvOW51L1pBZ05scUplRU1kNUZhUlA5?=
 =?utf-8?B?bU9scklCQmc1T2M5QWZmL1FUU2RwT3lkQ2hzZHV4SlQ0cHU2MXpLRU0zcjdB?=
 =?utf-8?B?VldRV3JRMUEyWDV1ejFFbC9OVjBRSUcwT1oxd2p3ekpha1JxMHlPRDBWVnhZ?=
 =?utf-8?B?K3hiSDFxcjhBSGhVeFhadlgwVlJISkhuT1k2ZWwzcTlXQWt4VHhTOEJ5RXQy?=
 =?utf-8?B?dzc1Z3hwYjNQd25RaDRWd2Y4Y2s3aHUwQjZwUkg2R2VmazJYZ1dMMlFsQ2oy?=
 =?utf-8?B?ek5XbW95VkpuVzFkalVDVWdiMTFkemZZSXRxMExjS3BIUDFNcGRsKzhORndM?=
 =?utf-8?B?MmlRNHZUQS9TMnpDRWZBUnJIY2JPVE9pWEt5WGFUYUV6ZEdVR3VTSWtacndm?=
 =?utf-8?B?cklSaDVkak44cmRBY1RHdVpNdEc5SEd3dERVRHFXRTg3S3BKdVdOQ3hPWExW?=
 =?utf-8?B?VG1ia2hVMTNUdlYvWm9Rd1BoTlNRWk04cDhUUGJVRW8vUm9sbDYvNjJROFFi?=
 =?utf-8?B?WVFXUWxpbmtTNzQySkduZkRiS0M3RkFhVGxqQTZrZGF1V3VGMi9hb3hWY3Y3?=
 =?utf-8?B?cDA1VTRjRE0xMkV4REFPSG84TU10aXIvUWdGazVFWDdSWUpJT045YkRDOENC?=
 =?utf-8?B?UG1XWEIvUDc0aDlRS2hlZkxnK1lJNWF0TmdsT3RFckZMQXNkQWI4TnhOS2hZ?=
 =?utf-8?Q?JW26JC5TYF1jT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUZLUDU1M25UMmJtbmp3QTRzNFJUVll3VUVsQzQxcGdCQ014T0VwWUhhektQ?=
 =?utf-8?B?NXdQV1J2My93SGg3eHZsdmh0OEZ2RVlwU0wyTVEwaHZPMVZKMDdHaWppOHBz?=
 =?utf-8?B?VG1SM3lSczhpdWlkd3pxTEtPeXJLbkxJZHAvTFh2NUZhZnRlTGJtQXZOOEli?=
 =?utf-8?B?cHhQUEJLT041K3RZUXhoRWFXc0FHdGJKN3NPODgwWDF3RjNjNFhSYVFMeXhE?=
 =?utf-8?B?R2QwcmVOb09XVndNUzJ0b2xzTlU4ckMwSmVIdVo3dzJiZTZiL1FYNHFLVmZo?=
 =?utf-8?B?V1gzUXFWZHdSazJ4OXRncW9uandqV05adDRVZ3VWcnBVd0J2TUVuNDF2eFZE?=
 =?utf-8?B?Z09hUm5DWEZpRWo0dU5OV2dlM1A3cmVSMjc3bzJ3aHQrWXJ6dTVtcVRwbWZJ?=
 =?utf-8?B?ai9RSFZISEtzMm1HWjBqNWJKdkswcmpiMVcyYzd4OVZXZFJWNVVuSmYxSEJt?=
 =?utf-8?B?K2dSOEVuUUxQek0xeXlnc3EvKzFEMjBVck1WcEJIeHZFbkdhOElwVlpRZEFC?=
 =?utf-8?B?TzJGNkFzTmRGRFJnV2o3YkFIazdYVjJyaXc1d3N3L0tCQVc1WEdHQUlybXJy?=
 =?utf-8?B?UUMxZWJFR0VORkcrN0RUM0d0dU93T0VkNERSZTcxbm81a1FNN2oxTEdNMTlx?=
 =?utf-8?B?UUVyWDJmbUVOMTBVaUo4SzF4SjlwaWZ5VDJSZ05zczFwL0VVeWF1azZSYkxv?=
 =?utf-8?B?RGUvV2JsNjlnU0ZqZWIraDRDTjQ1eThXRVZpeFhhbkxyalo5bUxHRUJ6QlA5?=
 =?utf-8?B?STRxdTRBaUtabkJlTnlPSlg2MXZCOFQwNHl0bXovdUszYm5qQmtad056dlJw?=
 =?utf-8?B?UkI1Mnk5NGZKaE5YRWFsUTJRMnROUjZDeGFTc1BEc1lITXlSMDhqbFVNd3JT?=
 =?utf-8?B?alNOblMrSklFalZEQUE5TTBNWFdmOXRjOHFjOEtxbC9EQXg5ZGVxck1mQ1Vo?=
 =?utf-8?B?YWlWQkJrdndWM09QbWFkMVk1ZUlTaEUrT0RrNzNIaitPWFNPVHYxT3VrbnZV?=
 =?utf-8?B?ZklYbTlIbXJTYTcxWG9VYThRT3ZhZ284WmFFa1RHV3RhKzc0QndaQkxUaDQz?=
 =?utf-8?B?UUVvNVowNmlIckVRWDJXTVpCSklidGpVZjNBak1oVDgxN3dxV1pHQlRnZTZx?=
 =?utf-8?B?SzlDeGJLUlpsS2Z5VlMzYW9YYUY2akF2OVJVTDZiWVlQenVxRHZNcjFqQ3oz?=
 =?utf-8?B?RmVFQ3pNQVZ4MlZBSEpmK0JSOGNGSlRFUm9kbFVuenpZejdhVGVZaERrU1Vo?=
 =?utf-8?B?N0dwVFVFMG5IbFlpSW41VEJwVlJNY3E5c2l3TzhJZzdzbGxjVW8zMEFMM0l4?=
 =?utf-8?B?eVl4VUljSlZINXg4T3o2TEZ5alZkMDB1RGZNTkcxb25SUFF6Ly9iNnFBUEFz?=
 =?utf-8?B?RXdqYzJ4Q3FEakdrSDd0ZnV5L1lwdExsQXFLSUV6M0tJSTJEeENrQkRiS0d6?=
 =?utf-8?B?YmJCYzIyaDVuVloxQWNRanFJak1IZmtTQmVlcUFCWjQrd3dTTFZTVms5RmlP?=
 =?utf-8?B?YzlTK0lsTlJERkJvZE5QdUZXa1B3bndORTBwaGkyTFVINkVsQW1rSDF4N2dC?=
 =?utf-8?B?dVlsbS9aZ0NDM1VvSVZkWTRnbjNMa04xN28yUkRSbWp2WmxRbEdyV3RqaHlp?=
 =?utf-8?B?U0tYdFdlYmQvQWxxRG4vTS9VUElGZ1dWRWZMblJXWmNNeXZZdWdLZDVqMS9X?=
 =?utf-8?B?MTFQS2sra3MvRXNCVW8ybDhzV0hXUFBqSFlUS2YxU2M3Y2p1bHBjVjVkNW9t?=
 =?utf-8?B?VmRuWXA1WlBKKzV2cmVTYU03bkNCQXFIVWJiQ2lSWTNNakVFVzYvV3ZnTytw?=
 =?utf-8?B?WmNCc3Z6bFg3WDZLak5QS2VmZHFpM3FacnNzUkcrdFdhRTVBVkprSzNWWnFG?=
 =?utf-8?B?VnpRWmZlbDEwbGU2UTR5MFNKazg2ZlBuNlVzVzN6UHYxUkRvdCtpVFZSR0Jn?=
 =?utf-8?B?cWhETTRWNUZFRjZZb1dJZFlUdWdQYURmWTZUYjVQelhzeVRjenVwd0xjV01t?=
 =?utf-8?B?ckh4aVpWUTRSUzhaVllHbXNsaXBWZ20rQWpqblJmcDFwRkRqb3ZKWW5Rb2JD?=
 =?utf-8?B?c0s0RzJKcnlkV0dMYkRsN25lRGNTQStzdDNVZndvcFRDWG1BMEZwRHRDVGVC?=
 =?utf-8?B?Wit4Q2lpM3Exa05WOGc1WDYzN0ZMNDlaYWlZb0Y0VUQ0ck9vWEF5QjlVSFZL?=
 =?utf-8?Q?zzWX/y+qByLhdfdd2witYWJqWWP76fzIsZ+FP6KEJTKw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BElJvEtV7ZoMEW0X1ai9+zArcRI7ot4PTAHVEtzigdKdSpNPkqvOB7/4vW1S9Tx0Ft+2frivPqKQCgW17DUHMFKqTnkH8w3fZGtYX8EOQYXhvaf1d5XpEJ0UXkdjCEHqZH2gv8gxsauDOInS4QU512jsdNplFKrkJcUF9ICAADXFp1k8lGBscacUN5StJH9t0xNY6NcvdmWZk4eEDbaET3UmCL01Ev5r8Q/+YW4EuEGvgVoiiMC/Oyb2Ym4iq3wjdWgxe3FN1y+N6YHNtn+ugwcyAr0X1JCsI6AYbO0+jLojsjhz6c+Qv5Hf/Wip/R5uxwm28wKm3SIkmCDBTqiyQjKRp13B4O4rY7arHWUk8sm7iAvqpK/NYPt4PNqisyT2Dxd7e2AmVFEW/NV5qrurv+e/WN30RFkcB+kpvRMiWo4Euxq6FB56CnWwhc1m4lttxFBhZwJyhZrY7qPse2DL4ih/7tPvgtIQyFBALiAC9PIRFir8D3+uzIzDiTCJrq9YMeGB/cyOezrt8PafuRjihZQpp53vNLomMBAWK8ikN91rVlJaS6GK2AraRWyWHrye7NaW1NX8aMN9rVONb8E9VcHF9k0Qec0C/qDKGU9R59g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc758b4-3613-4776-5d22-08dd1de4485b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:14:06.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZxORBzo0JJJauOW89t/x4D+JtRGcdTYGoMjAMbRu9uDFC73FpBX4YQVYxzFdj8gMews430P6G9mu5IfuY6Wag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_06,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160128
X-Proofpoint-GUID: BS1rDbjmscRTTt-m-Dqv7NFk1LHwRBxC
X-Proofpoint-ORIG-GUID: BS1rDbjmscRTTt-m-Dqv7NFk1LHwRBxC

On 6/12/24 22:46, David Sterba wrote:
> On Fri, Nov 15, 2024 at 10:54:07PM +0800, Anand Jain wrote:
>> Commit c9c49e8f157e ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from
>> CONFIG_BTRFS_DEBUG") introduces a way to enable or disable experimental
>> features, print its status during module load, like so:
>>
>> Btrfs loaded, debug=on, assert=on, zoned=yes, fsverity=yes
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/super.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 6cc9291c4552..d52f7f6e2de7 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2487,6 +2487,11 @@ static int __init btrfs_print_mod_info(void)
>>   			", fsverity=yes"
>>   #else
>>   			", fsverity=no"
>> +#endif
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +			", experimental=yes"
>> +#else
>> +			", experimental=no"
> 
> I think this should be the first in the list so it's obvious.


> Also I'm
> not sure if we need to print it when it's disabled.

It should be fine. It matches with debug and asset; they aren't
printed when disabled.

So, currently:
    Btrfs loaded, debug=on, assert=on, zoned=yes, fsverity=yes, 
experimental=yes

Fixed to:
    Btrfs loaded, experimental=on, debug=on, assert=on, zoned=yes, 
fsverity=yes

And when disabled.
    Btrfs loaded, debug=on, assert=on, zoned=yes, fsverity=yes

Thx.


>>   #endif
>>   			;
>>   	pr_info("Btrfs loaded%s\n", options);
>> -- 
>> 2.46.1
>>


