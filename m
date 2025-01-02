Return-Path: <linux-btrfs+bounces-10679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D79FF65B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 06:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA203A247C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 05:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E118C907;
	Thu,  2 Jan 2025 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SRX+VNmi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mcdma7qy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D91BC3C
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735796833; cv=fail; b=u7NrLmIBGOPSNR1WjWCf2ajn53smrHSdqI774P1iLWr1/cjceoGWlHM3wN6ZVUX/2OB352IZGY4K2Zp6IWwRNnx4ekH1oBjkhaIB8Ox5+ybw3PhQkeIj7TkWNVlEJKqRaD918FFrrwCmDOog5VvU30yRBsqhtXDz4FxBqCmO4kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735796833; c=relaxed/simple;
	bh=e1BVhWHtBBKCXbZAvV6X/IUhjTFcxEH3d3Nt5rYlqn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lyAxCCSrdAqjbm3zjlwK6AVH+E7dch70Pqsko4BIk1ZaxYcbKuPBqrahnPq4dbBdm/WiuNYB+y+lRd5M65HIki4HLZch4rY9diLSHXY/E64jG2Zma8ShQ89Vs9q5ynYdtSapI9cLjXUm++mnyuiBWtLhlXOWyrhfhrYpboz8hJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SRX+VNmi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mcdma7qy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501Ngkjo008402;
	Thu, 2 Jan 2025 05:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Yz4LPtjkyA/sPd3fBHztm7/xG48053Sx/aNyvSEvLi4=; b=
	SRX+VNmiJdtXLpj8L/koyaSdu465NTqgTdBkeX4A0NOL0phabajz2Q2TnxAlGm7k
	P+5GI2tJVkLrSzMwwRld+535PZ0+c+RHFcQ+ZRupymE6ydRJfCUsHgBhVHa5zelB
	L7eeyzYnNQ4R2wnpHKgfyhdfAnNx+ReE90gk7JvQSxmqMCzZ41zBJPJk9/jvKjxM
	Gl1LCTGNTxh5KnzdzfPqPcxXKynaLoc8g3P60Wsx/0eFlHA3PnCyGHzPRzwXQu7j
	59P+c6RSVuVmu3ZgDYKq/NR1inzM9+a+e+n7EKVnBZqSmnsEg4VkfB7l1TOzEJMj
	jcpcSeyDhWIxJiXt2Qe4Vg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978ms5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 05:47:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5022hXW1009322;
	Thu, 2 Jan 2025 05:47:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8f5m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 05:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJ5eCoEw2BSP8FHxw60M6p9G+5awEnErHfC7Q12uoDiF4cDBmp8+Mntm/PXEMjsezERJhwWgnxG6sR4mPl1+thlrlGWjKPT3aGlL+CkemPX9HHFucHm4QeoP0EnirC4yQVzABnz+gPZ2pk3VYOMKNVjZXuZL8bj47wLe6QnkmAokz1B6k4v4MpqGSjqUANk8mkrBDHoroGIim7d2pScU5XqJQcTW7DSTcCFvhe97GnQqzImdkwgVCxH0Rv2xqdoGVgFIVAbNAVN69OXya+nIia8C9oK3z00zqWG9J8gOef8ZT3gFM3pEwM9zRYEztEus3gEkDbyxxGMfZFfMsUWVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz4LPtjkyA/sPd3fBHztm7/xG48053Sx/aNyvSEvLi4=;
 b=JM0Bq3PcpSOA0f+ZtXZhh31LKt2hJrxApU8lb+rHy8Xh/RMB4trHHCIX575yjnS8u8rBVeX34iyV7oHJLHwZZ9qsX8YWve+lno9E429cpNBCr7FnyctyUesqtTjPbN029wc5lpxRRB0QHh1ljeZAeaQqUBDI/1kuAzer36+h8ViS2Ea5RgySSr424bXZHmHKQ1W9+ms2krdelK6jKxQvbDFhnDbgL3nmTBSCd+yrJMe3J8HAqH8W5JU0Jcv3p4TvODSkRfQe5rwiMWkW9upRwOVsMvqcB1Fr6/W8XBmnwKwnSzrcdSK9adx/0q/0Y3mi3IdPtHv/kVAdfRHwaDuIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz4LPtjkyA/sPd3fBHztm7/xG48053Sx/aNyvSEvLi4=;
 b=Mcdma7qyOVvEdtNB0SHZ5gqLC5sOu6Xw9m4g22mKVSnb5CrMUl/uCHL0HXPLLpkCa0ToZiI+/naRBSe0GcX+9EGbplTKS1uzMrIQFEXvGb6yujK815XcOqPAIp5yBZ0jCKwyqJFPk77c2cVftzVs+hEvTMrrhv+ig04yJTW6Nz8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Thu, 2 Jan
 2025 05:47:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 05:47:01 +0000
Message-ID: <48406910-f69f-4b8e-9327-8e291d9c502f@oracle.com>
Date: Thu, 2 Jan 2025 11:16:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid NULL pointer dereference if no valid extent
 tree
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
References: <80137af65712e7c2a8ac301b7b9a3901e8bdb44d.1735792000.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <80137af65712e7c2a8ac301b7b9a3901e8bdb44d.1735792000.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: c35eeb90-d9da-4fde-7171-08dd2af0e0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHlaTnJmQ1ZvTTZIZ2NOQ3lNNHU5SFVFQXVPYytnbllheUdnQ2pQNHhONDVl?=
 =?utf-8?B?eHRXTDl2emw1UFMvdGFTNjVXcEdtaGNsMVBQZ1RlSEpLRStKQ00vVGFGNm5V?=
 =?utf-8?B?QmxGNTFSLzBYTDZrYXMyMkJ4ZzhxMTJmUHRoUlVDQjR4dDlxTlMyc0QrcVVl?=
 =?utf-8?B?MG5pUGhXdjJIS0lmZU1HZkJ5Z3M4ZmNQN0pyWVVFMlBtUlVkcmVjSUEyd0tG?=
 =?utf-8?B?cGhUNDQ5SXgzYmM1OTJnNDNMR0VLa29MajVyUmsvQk96RVlic0tvWkJWWDJY?=
 =?utf-8?B?SDdoVGE0bjFQQ1VWd0F0R3VKNXUwU3piazJSUGduUFR1RWdxbFBuRDduRTNT?=
 =?utf-8?B?L243dDByREdEL1k4Rk93Y0JUY2M5S242TndaL1VpbFNJSFNBdVlNeWh2c2pp?=
 =?utf-8?B?Wkk0WTN5SXRwSSsyUjVNdGlUaktIS0xpcms5T2hJMkl2UEU5cVA3emM5KzB0?=
 =?utf-8?B?MTFNdmp5M1ZmbWRMeHNYNzRrelRUVUdJNHFxS2pGUHhCQ2Mxb1hQaVQ2ejQv?=
 =?utf-8?B?YnV0TG9lQmxhNUpsc3gvSkp6YlRDMTdGVVBxT2pERVFzV3l1UXMwRllMdlY2?=
 =?utf-8?B?YnkvekxxcjcvUjEvTzhRVm45SkEwQUJBWmhFQzZlY2NBK0dhbmowN1Y3aUU2?=
 =?utf-8?B?NHdhMFpBSlVRWTVSRnJBdnRhN2JPcGYwc3B4YUJsRFR0SCtsWTJrQjJwV1lC?=
 =?utf-8?B?UlRqTERsa2drcVRCamwxQkhaNER2bWNZRzRIZCs1TUJmcFRib1RtQ3ZDeDl4?=
 =?utf-8?B?VHpDWjUzNnJLcjJZdExoSTVIQXQ5cmkvMjhUNm52ZTVwbTZjZTJGWFdWNWZK?=
 =?utf-8?B?a2hya0puZDBaMU1lZXBldy9nMWdNTHk3cmFWVFVxcjQ3dFg4eEJjUHIrdW1E?=
 =?utf-8?B?QXdoZVdxNU9keHo5UWJ3VmtaTzFHb0VtaDhOSmVmYWt2M3U0UktwWS9RZTFa?=
 =?utf-8?B?dXl1ejhoV0ZaVDE4UFUrVHZkcUFTUlJWT29IRlZpVGZsOHdKdTU1b0xQa2Yy?=
 =?utf-8?B?TVh5ZEpTZzg1MVAzY3dpZ0k2eFN0aTFyNTgzdWxOT21IQkJuZ1o3L3RLUS9i?=
 =?utf-8?B?aTQyU2dkQTlTY01BeDg0akk1cXBHMnlyblowcUtHUDc1UlNkbkdscmd3SDJH?=
 =?utf-8?B?cDFSd3g2Q05FdDdHcGRnSDlBS2I4bGJhaXpnQlcxK2JmcjBtK0ZPYkxrOXlU?=
 =?utf-8?B?THZMaFpGUlhsTjJoV0ZDOGRNdVZZYzF2clJWa1czSm9ITFpDMnFmZllZVGNY?=
 =?utf-8?B?MGthQ0RrRzM3VGRnQ0UwOWN2bE9QdGVrQUFiTm4yd2F6bUJGbHpWbzYvRzJr?=
 =?utf-8?B?SzZzNExVNDdGYXYxcHVoU0ltNnRaQ3RqcUY3RUhlU3RuM05PdW5Vem0vbUdL?=
 =?utf-8?B?REhZWXhJQnlOUWNPKzBZWThjaGRmR1BLY3BlOWhWcXlzNTNNTHRGbkNyM2Jn?=
 =?utf-8?B?YVJMOVJjRFQ5VFlNNkdFTDVETEwrUkgxcVhvY1FsMEpFZVI0bUNLL3U4WlJY?=
 =?utf-8?B?UEpRdjZ5VUFHdFZXOVFmMFIvT1Y5YXR5bVVzT0w4clBBeUxOdjFSMmZaK05p?=
 =?utf-8?B?cEZqRWhHdmR0TjVQOW85ei9PenpKdmdVSjlDcFIwWFFZOW9CWDVNdGZaTk1C?=
 =?utf-8?B?U0NhRW9mVmcyOWxCYy9OS0Vld1lWVnJHT0xWbExLNSsycU52T0MwWGdtV0dL?=
 =?utf-8?B?OHNaUS83UE9jQU1lL2ZTbTlxN1BiS1RLaHZmYWJGZGZpNXplT0Y3d2s5RnZx?=
 =?utf-8?B?eXVReEQvM0lIdFhGNWVPNDk3RmZQL3BmWFMvd3JDME9KSVRoYldDa3NMNzlK?=
 =?utf-8?B?bjY0S1lTZkFxSFU5MzdybDEvbi9nVldiTWEyemN4aGV1NzQyLzlrTHhRSDdT?=
 =?utf-8?Q?7kJ0W3wI1zOxV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEJPKzV2UFYvZGFSSExlMGZua05mTlFNSFFLL2FpVlpFTlhZOGFoVDVqR0xW?=
 =?utf-8?B?Y2NhSld2VXR0NW1aWmdsb01zUnRtUG0wdE5Sa1ErS29NRlJMekZHUUNYTllN?=
 =?utf-8?B?RzYxcCtMU0M3bG0wVXZiVXJYdnVTdDhCSUlnck8rRVA5VWtrMEZoOS9TanpY?=
 =?utf-8?B?NTJZOXU1cnlINE9uR3pTaThyRkhVcE5ZSDV3cXExaXFNQzZmVUppbXc1YXlq?=
 =?utf-8?B?MlJPRDl6VVZQS055N01UNGZzd1pkUG8wY1JRdUY4cDFQc2RRL1RQa3h5aE9x?=
 =?utf-8?B?TkZSdlFUa2g4S0N2bCtrSVBDSFRnYlhnZkxvajBCVVViZ0FMdXBzTEJRQ1F6?=
 =?utf-8?B?T3hKNUVCa2xtYWlzaW51L0NQZFVha1FBZ0VMZXFqcGJENTFZTUhQR1graEpr?=
 =?utf-8?B?YWpCTHJRUU0rUXBuaEtWQmNNelpXbHJuZTRLejUwSWE0M3BIdXVuc2dlak1K?=
 =?utf-8?B?b3BsbEgycnViSERqL1dqQzJDRi9VbDR0L1M3ZVVBTXdCaThwNXRheHNPYlRZ?=
 =?utf-8?B?WEhFaU1tSk5TRTBhSUFVQTVYV2dSellmc1dNRXZCRjhCVFBqYmdzbDBUK09Y?=
 =?utf-8?B?TXFSWjZOZXZORnVlLzhSYjBhb2J4RnpSeHBpMzRXd0hXT3Q0bU1VUzJ4NllG?=
 =?utf-8?B?UlhzVld0QkxsOTBEVlRDKzRDNjBkT1RUQkY3aGJhT2Jpb3U5U01WdEZVQ1d5?=
 =?utf-8?B?YXVqa29sdDZ6MUNlUGhBMUhGZG56TnNkL1JmZmxWaWdUcFNUSGZmNStML2I3?=
 =?utf-8?B?Tk5NQUxYRDZOV2VWYlRLbzRwSGg3Qll2R0ZwN1ZGQUpDN01NMWNTS0JSS2FD?=
 =?utf-8?B?MW44LzA2cnRtTEJhTFM3NkQxMklhUXl5QWQyZWVMa0ZDZVkwVTFiN0VYZUcr?=
 =?utf-8?B?STI2K1BsWGVVdnlRRGdaWVVOZ0JWN25udzNhLzRjelk0RUZ2SjBqMFFrNVFP?=
 =?utf-8?B?NDRGSXlHQ2hoSFFOQVUvWC80ZDhLYlB4RWJ2QnVsK2lPQmZKdVk3RG5LVE9w?=
 =?utf-8?B?K084MS9kZERCWTJrb0dSRGMwaHlzSlVObk16VUJJa1pIR08xUTE4YUUvcTFo?=
 =?utf-8?B?OEg3a3RzV2o5RWpiNEZlNWpZUzh0c3V0aEVBNjkwUnJsRmd3ckxvdndocW55?=
 =?utf-8?B?TGRvRGk3ZmNVUFNpSitDMmlSZ09aNmFQR3Q1Vk5qdm96czVpTUREdFVWbjhz?=
 =?utf-8?B?eWVodkl0M3B3RjdUVGZtTnBtUlRaay84eWpqeEUzVHZXVCtpK1lXdE1hNWoz?=
 =?utf-8?B?ZDcwUjNUVHp3VHduWUNodGxaYzBleGNGeGdYUmh1dndqN2FXZEhvSjFLNWRW?=
 =?utf-8?B?cllVTXhMbEpsNy9ST0lHY0x5OHJXL2N4Nm42NVFLRW9RaGxpTVlGZDMzYlpF?=
 =?utf-8?B?L25OMEYxMUxycy9qdzZ3M3JiRTUvKy95RTFrWWJNcFlReGp3L0ZFSDV1dGtH?=
 =?utf-8?B?b2dsN2dHN1hEVGU4SzBBR0FqYThsMUpYcjYrM243WUlnb0FDZEtaREFSZlh3?=
 =?utf-8?B?QjFtbmdKM1JrYUwzNVR1Nmw3aW1qZ29zZitHb3FWbjVxdHgxVEhUNGw4amFI?=
 =?utf-8?B?SHhZSmlHTlFSNHJTZnRKN1Y4N0pkN0psVjRCTmZja1l5Z0FQbXRRbFdJMEc0?=
 =?utf-8?B?eTY4SEM4RTcxVERVVUlac01tQ0g5YjRQbHBNNU90eEx3RW5ZcTUxM0FKTldN?=
 =?utf-8?B?Y0dtbHNZOFV4NWc3MnZlRnUvRk5BWDIyNHh1VUxiRUxmc1N5NDBuMWVGTzBp?=
 =?utf-8?B?SkgyZ2NUZ1Rqbm5YUXozU3QvV3hKMEpHdUtGMlR3MHJrOWluekNub294WVNG?=
 =?utf-8?B?bTB3S0w5L1gyK2Ixck5jeFZjVUt0ZGR1OFhqYmtlMjMwNG1BRXl3M0czdWt4?=
 =?utf-8?B?VVNINGZraW41bGtZTlFIVjBUZm51eEZHMXRYOTVNSlA2aXZ3a0w5OVJBakU1?=
 =?utf-8?B?RlkvRThvbG5lV3VzVW1zMlBkVmd4UHVhakJETmllZlY3aFFCd1gvZnZmVWJE?=
 =?utf-8?B?bnd1OHBpY08yWXNRNGEybzJuU3h1c0Ircjg5VS9Mdk5IUjNndmxvNUsrS1VZ?=
 =?utf-8?B?SFovZHVwR1dMa2Z3cUwrbXFKRGg3WjVEWG5jeFhLRERORXAyMzdlU0dIbU5U?=
 =?utf-8?B?cmhWOGVnTzhiS1BzUmFtaHE4cDY3bWhvMit5WEEvRFdPY1VaMGpKS09nSk1N?=
 =?utf-8?Q?Bf/sqbH/2USjK8TD1Vkf5RGomc5CxNxM2yJa6RebgoW5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UraD9o4j1FSrRWGREcHzl2McNNwDLGtkiq0MmlGq0+g6zgvtWJwr2FkF5UzLqG+doXGfWwrUEV6AA9EmPItCNNFlpM8x+jjOocLasNMhzRumnWZfnYiwy8HBSjwAmco7TktYmBgwMOqmJBgUOcoA0TQ1U8qEr7jksIjkNh6t+X+mroI1eX8YD2BAxpihCtJ2UY5UYjWWJhfhE/wYO6mgmgcmlODxknG2MvgPIg/iwJKPt7fX0PzqgM3JcRgNwny22TjlrhhfsthpbZz2yK4ILfbPG4/CoW3lVi23cSw4nCdfVAVlq+i4wdOs1sN2FhmT3qAPgHtQIf1/j+0AfOueIJ4bGpRQgtQoXXr7OTCyEk02QLn1X+03fYKUO3LiedkmOv8P6kTGXFQuAhazbSDADlshf6Y/LbkWRbubo48Mm28Zoq4KnxgW89RtYtiZgnmhoF54RBbiDV/r8kYZmDWBx4P33nj4zFotA6K1dj0YJTisZlbRrty0mCsiFERJTEHJ5mWlYX+7TxUXbj74441MU1y5aAFZet0/A99tStzYnbbbXSvh4ceoQiuwxFY2zZTrr2MPYEIUcIBAu4aUKl2kd75xXhHa0JyGcbSXZnl/jfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35eeb90-d9da-4fde-7171-08dd2af0e0e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 05:47:01.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAZODCjqbiy3wf9cQtxc41vwIwpVwNAkDXFdXks7CuNScCJPc1ktacGQWT/8BuFPOZYzfUXkmGPV/2ht6UgfbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_02,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020048
X-Proofpoint-ORIG-GUID: TqwvxkNKD7L1T9pKaRL1rdcq010ntU1w
X-Proofpoint-GUID: TqwvxkNKD7L1T9pKaRL1rdcq010ntU1w

On 2/1/25 09:57, Qu Wenruo wrote:
> [BUG]
> Syzbot reported a crash with the following call trace:
> 
>   BTRFS info (device loop0): scrub: started on devid 1
>   BUG: kernel NULL pointer dereference, address: 0000000000000208
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 106e70067 P4D 106e70067 PUD 107143067 PMD 0
>   Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 1 UID: 0 PID: 689 Comm: repro Kdump: loaded Tainted: G           O       6.13.0-rc4-custom+ #206
>   Tainted: [O]=OOT_MODULE
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
>   RIP: 0010:find_first_extent_item+0x26/0x1f0 [btrfs]
>   Call Trace:
>    <TASK>
>    scrub_find_fill_first_stripe+0x13d/0x3b0 [btrfs]
>    scrub_simple_mirror+0x175/0x260 [btrfs]
>    scrub_stripe+0x5d4/0x6c0 [btrfs]
>    scrub_chunk+0xbb/0x170 [btrfs]
>    scrub_enumerate_chunks+0x2f4/0x5f0 [btrfs]
>    btrfs_scrub_dev+0x240/0x600 [btrfs]
>    btrfs_ioctl+0x1dc8/0x2fa0 [btrfs]
>    ? do_sys_openat2+0xa5/0xf0
>    __x64_sys_ioctl+0x97/0xc0
>    do_syscall_64+0x4f/0x120
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
> 
> [CAUSE]
> The reproducer is using a corrupted image where extent tree root is
> corrupted, thus forcing to use "rescue=all,ro" mount option to mount the
> image.
> 
> Then it triggered a scrub, but since scrub relies on extent tree to find
> where the data/metadata extents are, scrub_find_fill_first_stripe()
> relies on an non-empty extent root.
> 
> But unfortunately scrub_find_fill_first_stripe() doesn't really expect
> an NULL pointer for extent root, it use extent_root to grab fs_info and
> triggered a NULL pointer dereference.
> 
> [FIX]
> Add an extra check for a valid extent root at the beginning of
> scrub_find_fill_first_stripe().
> 
> The new error path is introduced by 42437a6386ff ("btrfs: introduce
> mount option rescue=ignorebadroots"), but that's pretty old, and later
> commit b979547513ff ("btrfs: scrub: introduce helper to find and fill
> sector info for a scrub_stripe") changed how we do scrub.
> 
> So for kernels older than 6.6, the fix will need manual backport.
> 
> Reported-by: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/67756935.050a0220.25abdd.0a12.GAE@google.com/
> Fixes: 42437a6386ff ("btrfs: introduce mount option rescue=ignorebadroots")
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thx, Anand

> ---
>   fs/btrfs/scrub.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 204c928beaf9..531312efee8d 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1541,6 +1541,10 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
>   	u64 extent_gen;
>   	int ret;
>   
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info, "no valid extent root for scrub");
> +		return -EUCLEAN;
> +	}
>   	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
>   				   stripe->nr_sectors);
>   	scrub_stripe_reset_bitmaps(stripe);


