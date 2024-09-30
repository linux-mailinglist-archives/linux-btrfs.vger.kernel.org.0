Return-Path: <linux-btrfs+bounces-8327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F7398A368
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 14:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5BEB29E30
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC71917F3;
	Mon, 30 Sep 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wl3dS6Xg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pk5IWfLJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A731917E8
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700041; cv=fail; b=L9ATvkA34r84xquRDSmIoZ+plAGJjYhaIJU2XeGy0TFIJqSSpmbpiG72sO+7oYY+OfSJ8heYAs3S1tbYBBI+83whe0pIGUJNCDxG6Cq+0Oj6GFp4YRuxrNtz9/tBzq9TEAocQZNMkV+Gyi0Yf/zOnPHPIMtyRBTBfnq0Or6DXw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700041; c=relaxed/simple;
	bh=m80JP++mtxo/mimyn0RlHLwUTtpU/y7LC14A+L5cwAs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K2aUrv8Gtp9F93jzIcoNM4Ss+r+ZYwXnUGUOMKmZKwOl3lzkeSe1VkXDVdSeHJgCIBc/RCd6PeWIxFXKjICgqG/IKhiSYClTTW1X3RxrKwR5TdENooTWaXoBQGtAbr0O2lAkWDn7WRmZ+L0YRpwJcKZ3jJ1JVPrXKeg4wobwmG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wl3dS6Xg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pk5IWfLJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCTdlT019500;
	Mon, 30 Sep 2024 12:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=RqTwevaD5X0ctAf2DAKQsjHneUe0qxqICwjcWN21/ic=; b=
	Wl3dS6XgtVfRhrz91ab6DFQPf+1Fx9OX+cwKnEbIW4XAsEJHNZNLS/wGA9nQ/Hfk
	vjUGrfqeeQrG3TeoyE1wObV01GswC1OYQ7N37FzmHNrSVOIw37vkJ/Zq2EizOb9I
	5mHo0n1ffDnyQMijU6rD/KZImjyWCLZsZ/o9xQpadh6nBM/9FCggr4u4LfUfalfE
	Pvb260icqWAhPin6V6Ku5++xZXpNAd9Lm+edb43by73UpO6Rtwe8HHVp4AF7bDob
	KzHtVBRG6pweDvyvu3QKFwvILzgQ/AtqKBmK0+8ZTC6DLoiql6awkemhJapbZiuj
	XQyplfKw42QAKNtBJAcAYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dsu5kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:40:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCa5S8029452;
	Mon, 30 Sep 2024 12:40:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8867r1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8Qi78f2MLguzQpcAGx9aDa9UQvsP6O+oDDOV5fxQctpg1dkaPk+bCs5xjAGbdp8bCvALJjc7C/bz4D26RYApHHYzTwiYXtWP5P9HI/5oJt7eQr4if0mzmUlGIDiQuHd+UY7r6KpT9jJX9ejMQoBuSPFUb0k+h+Wo9Ak10jgFLEbVOjR2cONvVM5O0M3hX77NIL+GGW9LkAAVH9LiO44fmCmy5GpKAeo0eKraXaAfN5fzvcGnECy4PRDEgD6wMkv0ai2L0CZJHnRlkdK5/bB0LvOMZf+gaQkdApWkJJWc53OUhIzS08GiJimj9Y6/zwTME7e75CFS3kZtTNhK22bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqTwevaD5X0ctAf2DAKQsjHneUe0qxqICwjcWN21/ic=;
 b=e8ViMeGbJj6Az6cNheDkBCzj/htY+1cSUX9CtBq3DgGcB03nTyYNldSRmOkMVjgNxSMxzyhssN8zbBSrvkofCuvB4d5aM/xaTfJi4y/xI/UE8/O79t1gtRx/T/LAvhpAXHu6xYhaIwx094ZrtqpiBsVRFjHpIRNgdZrKulC98tfUuAIhsuqGrYuFfWEZIyA4lMfMXlYHViinvJAJbTBj8bBsOyUhOxbXmzsYqjoC56HoLJDCYlJK/kkoLmDKOq81weD5UQ8u93XwEaDhOnqHYwWSvNJMkhP/K1ATam8iwR1lX66goxP0pmfmyS98GV2QOqircgqIwhmygcA5LboeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqTwevaD5X0ctAf2DAKQsjHneUe0qxqICwjcWN21/ic=;
 b=pk5IWfLJvGegiRtNgHqks8S7UsgpYSs6faNn2B8D2kPCb+S4YqPYM3ZVxgmTAKYQumF5N9UtlxXYyWK2E5l9keDNQ80+lglMm+yCp1tW9vP3H6qo+2N8olHq2dc1BFVAewoXJZAekErLxFd/sampiNJg+0kzZGRtn5pGIaqqo80=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7327.namprd10.prod.outlook.com (2603:10b6:208:40e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:40:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8026.009; Mon, 30 Sep 2024
 12:40:31 +0000
Message-ID: <d9f1189d-b51d-4b0b-a3c8-cc7141fa9584@oracle.com>
Date: Mon, 30 Sep 2024 18:10:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: canonicalize the device path before adding
 it
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Fabian Vogt <fvogt@suse.com>
References: <cover.1727222308.git.wqu@suse.com>
 <3b0eb4cd4b55ae567abfc849935b4a72cea88efb.1727222308.git.wqu@suse.com>
 <af8014ff-d4c2-4f43-8602-49d11d4977fa@oracle.com>
 <97e23756-2740-45ea-a1d6-7cf95a115e8b@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <97e23756-2740-45ea-a1d6-7cf95a115e8b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fd1081-68f1-4cae-b277-08dce14d1244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTI5b0dFVFhVKzdzZGNGd2lvcWFvY2xaN2pMTm1oL051MDMzK05aZG9SK3cr?=
 =?utf-8?B?enZlMDc4Rjk0ZC9LVkFrZGl5QmEzSlVzTUFVemNYQTV4Zm1FRkx2RWVoUjd6?=
 =?utf-8?B?R2NpK3oxL2FZUlVHeVNKS1k1SC8rVFhkRVA5WlhyMHJSVTlwcXpjbWwzSjIx?=
 =?utf-8?B?bm9YaDZpWnFjNkFsM2VTd0l1L1M5MFFVTW5POURsbUdQL2VPVUd5QkYxR0Zl?=
 =?utf-8?B?ZURyMlBxWWlYRFAza2lVYm4wemVXRGVCOWU1bUV5aVBUZ0FlUCtoQ2xWdVFx?=
 =?utf-8?B?OEMxaHVnd2ZDN2Rva2Q1VCtYdjF4R0k0YTQ5NjJZNVBEeXBTTHBjWlFieFJy?=
 =?utf-8?B?NDk4NFVKYTcrYTNLakJ2Um1xRnprdDhBOG9oYjdNc0Y4emZzdndPYVJxWUpj?=
 =?utf-8?B?ZCtaMWx0akNKU2NXY3k2MmhQZmdkNFhKQUxrRm9HRG5ma2dSWW1zV2Zrd2Jz?=
 =?utf-8?B?dUZnaHQyT05kUUdNRkRrT0tRTndOeGMweXlHSmxSTjNjd2IzSm9jL2pmRU9H?=
 =?utf-8?B?Q2tDSzFnWVFWdWlPcllwYlQ0KzRwMExXcm5VRnVGa0IxUUNPZmI0R3ZkY1hm?=
 =?utf-8?B?azEyMEZVVStKY0dmL0k4YlAwV0RlSThzeU1yN1J5VjlKT05RckhTekdVamRt?=
 =?utf-8?B?cTlaTEEyRWxxYTV1dmxRQWY5allXVld2dzJDaUpla2hFNHlqV0dEcjJHWHNm?=
 =?utf-8?B?WWV4dzYxMWpzY1Jhdm5KRWlKUUp4TVlZZlZkalEwLzQzeDlDUmIzRm8xSmFI?=
 =?utf-8?B?eVJ4Wnk1S1lHL1IwaGMvd1NnWGg3d3VWQjVEeUpoUnVrTSswYk5Wa1RKaFJH?=
 =?utf-8?B?M0hWV1NEYjZ1M00yclB2cCtkcExCSi9EYjAxZURTY1Z2eW9KTk5OMUE2aG80?=
 =?utf-8?B?eFprc012OGtTTU5nb0k2MVp3cExDSUJTV1h6TEtheWp2TGpUTjRHYlpOaWZo?=
 =?utf-8?B?MGduSTJFNmczazY3QjdhZDZkcUh5T04vWXNtQndmd05QOXhaRHkrZ01sMXh0?=
 =?utf-8?B?b1BDZ1dEWjRQNU1LK3V2NC9CQitncWVmZ2FRUFI2ZlkzeXVueDl5UmZNS094?=
 =?utf-8?B?WXAxT3NuVUpPTjQwb2R4enV4S1FSWjhSaVZyUVk4YU92RnRmb1h1bEJHeENr?=
 =?utf-8?B?dXBRZlZHYlhQR09ZTTNrTVdXOU9BaDQxZFBIUUY4bW1YTFNEZlNFQVlNb2dm?=
 =?utf-8?B?MFViVmU4QWlHcG9EbWlwWjlxR0RseXlRcTllUkZZeHhrMGRYekZ6SVM1NTZH?=
 =?utf-8?B?NkIxd3hya0VtallhNUFHN25CM2R0ODk3S2FQVm5lNjZGRS9BSVk3Vi9vaFVa?=
 =?utf-8?B?UGpJVDFJMDJhaXNMR0VhS0tpS0E1NWVFcVJDWk5yZXIxLzJyUmJ6OFd3WjVt?=
 =?utf-8?B?enJ0UHVLZVo4SXp6NjJOazJNQlBnMXBTWm1JRG1tYkltRmVyNWtWczh1dmdt?=
 =?utf-8?B?VTczVXVWLzl5TnRocmZjTDhmWTVRRnptdUJxcWcrL2Z0cHNFeklvVDFMbmoy?=
 =?utf-8?B?TGhjWEllR0tNM3EreU5qaVRRNC9jWTlpSXNRS2hGc0VQbkRrWWFjOXZMWjZK?=
 =?utf-8?B?N3NSSzU4d1dSdis4WTdBcVUrcFNwWjFvbVMwV3BFZmVYZVhJbXU5R3l6U0o5?=
 =?utf-8?B?K3JEQzZuSlcrVHZTdFFhMlNGejljSU56MVloTFk3S3JldTVjMGFtQTlra3k3?=
 =?utf-8?B?bTJUK2FHRjFCaU9KRXBCVytIRGt0TnFycnlEWTFvMDExS0dpSFh2Ri9YSXo5?=
 =?utf-8?B?cXF6akNHWk9TSVdlNWNpZ0N2QXlQNmFOSnVaa2JkaWRrajBOeFlCU05MbmtQ?=
 =?utf-8?Q?zJW6zwRosJmv4L37dLVHOFZFn8gWWith5K2nE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a29WZkgxR2g0RmZDbFlxcDNyU0RWY1dQUzhzZnBiU3c3aFNZWjBnRitublpj?=
 =?utf-8?B?dE82aWlHMVAwMjBKcjlHbk5yU2RuWXF1dFJ4T3NacGJrU1BTUjZycC91cW5E?=
 =?utf-8?B?QllNWGZQZHFPN2tHZ1ozQmxnQWV0NUExM1VzeEhwM1JUc3NnNTZFNkQ0MUlT?=
 =?utf-8?B?b2JheUFZT0tYbkhQUXIzME85bFlvU1FLdis3cmExWWg3OVhFNE9CeG5jVFF6?=
 =?utf-8?B?Tks1czlNY2V1QzJadm1YNzFmWm1PVVZvMjZhYlZsbTBUa09YU21haTVKWTA1?=
 =?utf-8?B?cDRhOUhZR2dnbng5UWVmdDJ4YXhrSVpyUE0xQS9mam0wamozUFUvV3FqdVJI?=
 =?utf-8?B?NHFvdk9vbVhxbXNxNFZBK1FxekVOMERmWFEwWnVzYUd4NjYxN3NET2E2UFk3?=
 =?utf-8?B?cnA4ak1rbmJKWTJJNXlEdHRtTkRWLzJiWmp4WHJjQm80cnNPY2ZNdVhmdkpD?=
 =?utf-8?B?NVlHejdRU1haVFJrNW84MHBlOGkyR2krRTk4aDJ5NWtSZTAvbTVNTjYrMndO?=
 =?utf-8?B?NkRKWXg3OVN1R2RldlRhc0l1OC9wdVJYZWdYL2pVUFQ0SE9sNDFSWGhxcXlV?=
 =?utf-8?B?L09rdlBQdmpuVW5uSkcxNUFpclphSW8zemczSkpQdG9KN2lTVGI4cnRtSnJ4?=
 =?utf-8?B?R09yb1l0MlJWazNiMm1rSEtBMmRHMjBFVjZ5dDVNWHkrSm4rZFhUQUZvTlMr?=
 =?utf-8?B?OEhqL0IyTDBITjlHNDZEakRIQjVVNlZuN1FXMGpLelpYTnlsR3NsbC9mcXd6?=
 =?utf-8?B?VEwyRW9lYUdubEF6T0pheVlLWUF0M2dNVlNYMXMxUVdwaldNRE42YllqTXJQ?=
 =?utf-8?B?RzJMRnllV0V3ZGdGUExWUW9FS3hPZGpPaURGK2ZrR0VzVGMrbmJVLzA5VjVG?=
 =?utf-8?B?Y3BFZ3hZNW1rSXdKWVJaSGJYN3pXL290ZUJzeU04UnFLV3F0bmhLcVZXZStR?=
 =?utf-8?B?Rk1vWjhETFN3eXpvdklPQjFIWnV6OTY3RWkvRzdMQVAzcDRUUHJxc3hFWTRR?=
 =?utf-8?B?NGc2Tk9jQ0NVN1BUQXVWZWFDOVlsbWxtaDFxQlZGTWxaczFnT0xPSUtRTlFD?=
 =?utf-8?B?ZjBUb3FwRCtsL2FhV05xMFk5OEdxUlp5dTYxSlJ0MUJFRk5PRDNlenNWemJr?=
 =?utf-8?B?ZEVLT1c5a0JCd1VZMzE3YWgySFJTTkp0TVFXNlVTMGE5bHFNRHFMQXAwRzk3?=
 =?utf-8?B?S1k3dU0zU1RwOUlHK1ZiaGVRNmlCS3dkRi9mZmJ2ajRNS1NENldHSy9Xb2JO?=
 =?utf-8?B?ZDJ1RCtTdjE2b2wzY01jcXkzTFJtalNqZGZRUUtCVFJacHphdEdNdnlxaVRl?=
 =?utf-8?B?Q1BhcUhWMnd3U2hRL0phZ3FQaUFxT3ZjcDNia0tFa21peDhXT3FxQVZCSTZ5?=
 =?utf-8?B?SG1TV29BZDVqV2ZVZ3pNb2FqZFNmZDE4RXJqODNLYXV4UzZQQWtQRXhWSW5y?=
 =?utf-8?B?eXBFK2tiRnJGRVVKTUN1LzJheHZEZkZ3NXk0aTAyZEJYRUxjSU9na0hxc0pX?=
 =?utf-8?B?UVNhdWt1TkxtWUVaRXhQKzNLZlUveTdZdjFKaGEvTXBWQm55YzhSZXF2MkYv?=
 =?utf-8?B?aWlDWFo5WElOTjZzQUZrSHU1L1o2RUxicURWTVNTbDF3bXc2VHZ5VVN1Zkoz?=
 =?utf-8?B?RXgrVEdNMG85eGcxOUtjV0xuYTFJVGlFVHY2ZkJRY1d3RW9DMHVlL3l6Wkc3?=
 =?utf-8?B?ekN6NW4wQjZKNzNEVmhFcDU1NUxjRnFOSVJzRW9lalg5V2dNWHpWREVITlM4?=
 =?utf-8?B?dGZaNStOeEF5bmJOWWZ5UmxRY1kzdzc2SFE2VkxpcjFLK1VJUUNwR3A4QUtK?=
 =?utf-8?B?NEZFV3AraFBkcXYyMjY3NFhqR1JwREIxMzRyQmdMQVB4Z2JuNEpNWmdveXpE?=
 =?utf-8?B?WXN0N2llaE5Wd093YU1IOWFKd055WlJHYVJQa2MycENXckFGbElnb2tFb2FN?=
 =?utf-8?B?eE1MTkhuUm5VK3V6RzR5WVVKU3drMlo0b0VNOWRabVlnTlBEQXcxY2Fyd2c0?=
 =?utf-8?B?NHQ5c0QvSVlCcXVPbUg4T2RuM0RyRHVYdVBlbCt5M3d0dDY2S3Yzd0tSMFoz?=
 =?utf-8?B?MGRkalJiK00xbjJ6K0FaeUN1WThjbVJKREZ2M3F4Z0pyN3NvRWRzaHBIMGF4?=
 =?utf-8?B?UHlzMWxlQmhjQ21WWUMwYnRiTVI2bEZ1TGNJZmNDUjZacGE2T3cySm95S1R0?=
 =?utf-8?Q?A28ggp4sThv4TepoDIGpsSOgoK2lIGwmjzFPhjYUSgnJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R0RPRbF70MWag3iZ5NfXlkwhZyfvKjfQmYW1rllVXB6J9H4FNXIZFW11mWQFw5pl+rJu3BMczdzrW6+O8lOJZHh5YWj0JQn/GbGCXEdmNXH6IKF+uh3nEZUFn2lLk1Ijsx9UjHd9ulSCoEhMtCyvrLm5iV9l0hbS5Rt5UzUHX/SxzOod284vXKo2CXT6gpxJZ5ebJVZgZ4M3piQhWB+UlGKu8ReipiKGaswyi0kjT7Oi9yVc43XM04yoehPfVxMaZe+qQcjHSucLD72uXJsrNJeJxIgjVwHcS/YeaguiI/Z2m5YvezNMdo72jSyPc2wn+p4h7ww+Uiy5ISvNzviau4FE5avOU809Xvdnmif/RvaH2qKHoIaK4pKS86tobEFfiQxGdO2EjQzS/OoQoyTWTHLZujiK1VMY7aHCj4VAC4ExsPclDvy0lsMZGBRC+1SgWXbEMhdhf0MBah5g+yZ5lTzdbaDcqWp+ruil8CjTD5q4M7a3csPC9TB6yRIuS9vpyum5G7/erZ9LvxJRtoqQdc1swMs8kX7mzDUnbBBmIfWdGgb7lZ+Orc42LOj6yzodQKlkIBkxuW1eym9HsyRSorPXLLWoJS3TYLz9+nnxK2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fd1081-68f1-4cae-b277-08dce14d1244
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:40:31.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tru825ATzME3i7Clts6OjCRo0/Ik+LZJSvFAgMi5qSRH8xsajYwHL2OFHmDQRm3BKAeA8/wJtQe9BROlOmEzoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300092
X-Proofpoint-GUID: WMRLNRJ5fcgVG2zXniHlICoudQ5Kn6Kq
X-Proofpoint-ORIG-GUID: WMRLNRJ5fcgVG2zXniHlICoudQ5Kn6Kq



On 30/9/24 11:01 am, Qu Wenruo wrote:
> 
> 
> 在 2024/9/30 14:56, Anand Jain 写道:
>> On 25/9/24 5:36 am, Qu Wenruo wrote:
>>> [PROBLEM]
>>> Currently btrfs accepts any file path for its device, resulting some
>>> weird situation:
>>>
>>
>>
>>>   # ./mount_by_fd /dev/test/scratch1  /mnt/btrfs/
>>>
>>> The program has the following source code:
>>>
>>>   #include <fcntl.h>
>>>   #include <stdio.h>
>>>   #include <sys/mount.h>
>>>
>>>   int main(int argc, char *argv[]) {
>>>     int fd = open(argv[1], O_RDWR);
>>>     char path[256];
>>>     snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
>>>     return mount(path, argv[2], "btrfs", 0, NULL);
>>>   }
>>>
>>
>> Sorry for the late comments. Patches look good.
>>

>> Quick question: both XFS and ext4 fail this test case—any idea why?
> 
> Because they are single device filesystems (except the log device), thus 
> they do not need to nor are able to update their device path halfway.
> 

How is a single or multi-device filesystem relevant here?

>> Can a generic/btrfs specific testcase be added to fstests?
> 
> I can add it as a btrfs specific one, but I guess not a generic one?
> 

Yes, you can make it a Btrfs-specific test case, as XFS and EXT4
currently fail on this test.

Thanks, Anand

> Thanks,
> Qu
> 
>>
>> Thanks, Anand
>>
>>> Then we can have the following weird device path:
>>>
>>>   BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 
>>> transid 7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (18440)
>>>
>>> Normally it's not a big deal, and later udev can trigger a device path
>>> rename. But if udev didn't trigger, the device path "/proc/self/fd/3"
>>> will show up in mtab.
>>>
>>> [CAUSE]
>>> For filename "/proc/self/fd/3", it means the opened file descriptor 3.
>>> In above case, it's exactly the device we want to open, aka points to
>>> "/dev/test/scratch1" which is another softlink pointing to "/dev/dm-2".
>>>
>>> Inside kernel we solve the mount source using LOOKUP_FOLLOW, which
>>> follows the symbolic link and grab the proper block device.
>>>
>>> But inside btrfs we also save the filename into btrfs_device::name, and
>>> utilize that member to report our mount source, which leads to the above
>>> situation.
>>>
>>> [FIX]
>>> Instead of unconditionally trust the path, check if the original file
>>> (not following the symbolic link) is inside "/dev/", if not, then
>>> manually lookup the path to its final destination, and use that as our
>>> device path.
>>>
>>> This allows us to still use symbolic links, like
>>> "/dev/mapper/test-scratch" from LVM2, which is required for fstests runs
>>> with LVM2 setup.
>>>
>>> And for really weird names, like the above case, we solve it to
>>> "/dev/dm-2" instead.
>>>
>>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1230641
>>> Reported-by: Fabian Vogt <fvogt@suse.com>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/volumes.c | 79 +++++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 78 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index b713e4ebb362..668138451f7c 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -732,6 +732,70 @@ const u8 *btrfs_sb_fsid_ptr(const struct 
>>> btrfs_super_block *sb)
>>>       return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>>>   }
>>> +/*
>>> + * We can have very weird soft links passed in.
>>> + * One example is "/proc/self/fd/<fd>", which can be a soft link to
>>> + * a block device.
>>> + *
>>> + * But it's never a good idea to use those weird names.
>>> + * Here we check if the path (not following symlinks) is a good one 
>>> inside
>>> + * "/dev/".
>>> + */
>>> +static bool is_good_dev_path(const char *dev_path)
>>> +{
>>> +    struct path path = { .mnt = NULL, .dentry = NULL };
>>> +    char *path_buf = NULL;
>>> +    char *resolved_path;
>>> +    bool is_good = false;
>>> +    int ret;
>>> +
>>> +    path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>> +    if (!path_buf)
>>> +        goto out;
>>> +
>>> +    /*
>>> +     * Do not follow soft link, just check if the original path is 
>>> inside
>>> +     * "/dev/".
>>> +     */
>>> +    ret = kern_path(dev_path, 0, &path);
>>> +    if (ret)
>>> +        goto out;
>>> +    resolved_path = d_path(&path, path_buf, PATH_MAX);
>>> +    if (IS_ERR(resolved_path))
>>> +        goto out;
>>> +    if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
>>> +        goto out;
>>> +    is_good = true;
>>> +out:
>>> +    kfree(path_buf);
>>> +    path_put(&path);
>>> +    return is_good;
>>> +}
>>> +
>>> +static int get_canonical_dev_path(const char *dev_path, char 
>>> *canonical)
>>> +{
>>> +    struct path path = { .mnt = NULL, .dentry = NULL };
>>> +    char *path_buf = NULL;
>>> +    char *resolved_path;
>>> +    int ret;
>>> +
>>> +    path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>> +    if (!path_buf) {
>>> +        ret = -ENOMEM;
>>> +        goto out;
>>> +    }
>>> +
>>> +    ret = kern_path(dev_path, LOOKUP_FOLLOW, &path);
>>> +    if (ret)
>>> +        goto out;
>>> +    resolved_path = d_path(&path, path_buf, PATH_MAX);
>>> +    ret = strscpy(canonical, resolved_path, PATH_MAX);
>>> +out:
>>> +    kfree(path_buf);
>>> +    path_put(&path);
>>> +    return ret;
>>> +}
>>> +
>>>   static bool is_same_device(struct btrfs_device *device, const char 
>>> *new_path)
>>>   {
>>>       struct path old = { .mnt = NULL, .dentry = NULL };
>>> @@ -1408,12 +1472,23 @@ struct btrfs_device 
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>       bool new_device_added = false;
>>>       struct btrfs_device *device = NULL;
>>>       struct file *bdev_file;
>>> +    char *canonical_path = NULL;
>>>       u64 bytenr;
>>>       dev_t devt;
>>>       int ret;
>>>       lockdep_assert_held(&uuid_mutex);
>>> +    if (!is_good_dev_path(path)) {
>>> +        canonical_path = kmalloc(PATH_MAX, GFP_KERNEL);
>>> +        if (canonical_path) {
>>> +            ret = get_canonical_dev_path(path, canonical_path);
>>> +            if (ret < 0) {
>>> +                kfree(canonical_path);
>>> +                canonical_path = NULL;
>>> +            }
>>> +        }
>>> +    }
>>>       /*
>>>        * Avoid an exclusive open here, as the systemd-udev may 
>>> initiate the
>>>        * device scan which may race with the user's mount or mkfs 
>>> command,
>>> @@ -1458,7 +1533,8 @@ struct btrfs_device 
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>           goto free_disk_super;
>>>       }
>>> -    device = device_list_add(path, disk_super, &new_device_added);
>>> +    device = device_list_add(canonical_path ? : path, disk_super,
>>> +                 &new_device_added);
>>>       if (!IS_ERR(device) && new_device_added)
>>>           btrfs_free_stale_devices(device->devt, device);
>>> @@ -1467,6 +1543,7 @@ struct btrfs_device 
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>   error_bdev_put:
>>>       fput(bdev_file);
>>> +    kfree(canonical_path);
>>>       return device;
>>>   }
>>
> 


