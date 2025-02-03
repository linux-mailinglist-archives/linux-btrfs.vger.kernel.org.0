Return-Path: <linux-btrfs+bounces-11253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308FA265FE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 22:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5307163B35
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 21:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4B1FF602;
	Mon,  3 Feb 2025 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bSTmkd/Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NBxMnTC4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5433CA
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619232; cv=fail; b=riHTWblatHeYjN5wAoKf7OmnEF4W5Y6gHBjp3VoGxfNNkv/sxaCA6NJt7RNf+qF+QjjRJpgGxlGEbJ6vHKc89ogDTmiCdWltjpc3ndxx24386fS28LOzbQMH5Mi1rjxm0zND+0AnxfaKMQWRjRON9TFQEmbUCu48YVUVAXzfQQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619232; c=relaxed/simple;
	bh=/edOT05HkhI5GGnd2sJ6bV5Fdwn0uBUa8Pr7/XbNQ3E=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HEpKWRbLLDtTKEne4tWCuvv6V4jnGcjODUFVm959LDDa6X/41JGnWqgQ+VCvdtygOpbDcbgMaqc333opdAoxQUANWOnfPS3xfcpYb7+ejlVQ8P6UnufwHwnbo95GTrI54rb7JCBAo7YqcvHVCgkd4zyLxLxWIO7n9R1KvP0tqX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bSTmkd/Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NBxMnTC4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMsN7000965;
	Mon, 3 Feb 2025 21:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LnIDwZ+Pgi7d+Xe+vURF9Pq8UDg5UFEErlqVBrPbG70=; b=
	bSTmkd/ZXm80lYeb9TpnBeRYoKOB/RXiL6UX9A2CnmexAzvnK4Mi10I1fwo4a2bh
	N2DefmEO25vR2yV22qHponns/r8w+GrenUePZEmSIdo3IJCfl/GeDGXex6SF6DWb
	MS7vtIPkIzW5RocqIB236n5CK08R3Myqai3gWvgW5t0yNswG1vYN+HyV3yM/1YPQ
	kfIczaltMZyLqIFiEyEBkLNsuZX6Aj44LNyA7JzX8NQdlByU91ZWmd8elqpfUVsV
	N611mlR9xNv1aQ89Lg+BnHd36z62GhNCwu6fmY6+2oZIHekPH4VBxm+ki68m1kyv
	Q7+YPa4gkHSZpOkob2KZxA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhjtumq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:47:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513JjOoG036366;
	Mon, 3 Feb 2025 21:47:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fkeapc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THNvyheJSIY+ULeaFu489ZqB/ycrBHo+yPQcRZ/P+qiM9BUFzyKoAuh9FWxgYczYerzMSVav++gmLfdJvK6/2j1jgamfEOC90VSmwibM4pcBFq61lGhRUPK1Nr10GllWZMWDWQgrQZhgF5tHE7fI93g82fBHDm28B8fzQPv42UposI6EtFQ5OryMRPz1xgrX7hqF5O059EVMKiD7gdQgKb5GYPhr7VXht3Mq+TqZNq0/9uWBInWKbsPPycWn1TU2rOcD7I6W6ssx2b0Y0g0/PpF6Fq7lbPeJlNcov6EcjMNyYMbzU4tLZEa/RlipWXcqbdFcXlqU+5h/rz5Y5WiNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnIDwZ+Pgi7d+Xe+vURF9Pq8UDg5UFEErlqVBrPbG70=;
 b=LurnOkiMo3RTiF5YEAe5Rrx80q6eDnWCOFBUmXQt1sH+yTHJYndj1zqAgHvOtPqpod9nTKl7Agq6H9wq11Q9YQJFL0qoE1UhSNLMXJXHegeV64CwG2jxxcGtgMwxs7XENwTjopUgEBjAXs3tnBuJvnTSJutJyNfdW+Y+PWgrmGdFMSHKs9bKwYOjEq/80pzFUkzXQJeOSe8phn6gV7e3VKZ7amwvUKeUs61G330+4w0j9lgj2mlPWetTf5lx1ApAqCSaODZiQ6wDHwFDlPy4GFOlR40Mme7L+t44sLUSfy6rjvZEwL2R2QPsQG9P789DCodROySlbx9UfeiIAt+wDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnIDwZ+Pgi7d+Xe+vURF9Pq8UDg5UFEErlqVBrPbG70=;
 b=NBxMnTC41ydqZpwEVbIdvlPewPIcy1TyVjuMrbrylhzm0AlxH45IO/PCRx24FfBhrvH3dFr0Vs6YWkVmWUx7LXHtbN4ns0gZ2k60knAkRN7XBVug6plsH7DkSvsdR2INIDq1VmJiQvgvC9F56XMmIu179NZKbUknMsEUW9eg9fE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5951.namprd10.prod.outlook.com (2603:10b6:8:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:47:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 21:47:05 +0000
Message-ID: <8cbf108a-1353-4855-bfc5-a872ef2998e9@oracle.com>
Date: Tue, 4 Feb 2025 05:47:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: resize: remove the misleading warning for
 the 'max' option
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <5c9857b5fbc5b71984594f2f7e6f666cc435118a.1736525474.git.anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <5c9857b5fbc5b71984594f2f7e6f666cc435118a.1736525474.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3a85ff-6d9a-4e27-4e21-08dd449c4cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW9CQllEbGkwQ1E4R0pIU1FwTTlzeDl5amNqOHdETlZPMW4vZ1phQTdLdFhV?=
 =?utf-8?B?M0xMaDU4RkxHcXgrOXpqcllwVGEwMTQ3MUVPbmhNcDdNTHJQRUtGT0kyRm9z?=
 =?utf-8?B?RGRlK1NiWDZkVUFOVFdkbHFzRzg5bmVPQXNxaXhZOXluVWFvbU11bUZkeW1Z?=
 =?utf-8?B?cmd4YW42emk5OTczNHA4TEdFcVZuT3c5NFJ5UnNGTmgzUFJ0Mk94ZXlvU0Mw?=
 =?utf-8?B?QzI1WDZqenUwa0l0c2g3cStObGZQYnIyU2VGbWVMc0xZTmRybm5zdnFWaE9Z?=
 =?utf-8?B?cUVVWlIzRmtXUWtoQldCRUdrdFJqemwvSHV4ZDNZdThKU1I1Uk5BcHNuOHla?=
 =?utf-8?B?ckhNZnZyMmRXODF6eGZNeU5jSGhiT1hGWnRKMHAyVlhjd3MvWExoQWRpcW5R?=
 =?utf-8?B?TitVNHd5UTNYUWdLMWpya0tJendiYitvZnk2T1BtQkltVHBDQ0hNdHRHcFVG?=
 =?utf-8?B?NitOeWMySlFYdmhoUkMydXBLNyttNDY5ekMrYWt4L002T0lremQ4S3hma3dD?=
 =?utf-8?B?bm5kemQydFFGbnJ4aE51dmdaN1ZsNTlCV2FQMUJCSmNSY0trZTlPWWJ5a204?=
 =?utf-8?B?TG5GVkFiSDc4Rytxd0JKYUF4WjMzMDJRbkVQMS8ra0NIWWF1SXNpRjBHWmYx?=
 =?utf-8?B?MlJjYXJzUXQzK0JySktDUjVKU3Evb2U5TCt1SkNnM0ZSZlFEbXJXcEo2bDV4?=
 =?utf-8?B?eFJGdFFrZVhIVHU1ZEs1Y1lObEorYVVieHJFTmIzeSt4N3orWnlhM3o3Tnh3?=
 =?utf-8?B?RDQyWHd6QW9HYVFDNjc1UjgyVHdvQnRqdFR6VG1JdTBuREpNV0tOSTA5VUQ4?=
 =?utf-8?B?RjNjZzZuL2plTzl6b2hnMkFubGpVVXJGUEVRcElmb1NMVnRXUEpNdVNnK20z?=
 =?utf-8?B?VmhWWldyU2ZXenVJSDlQelU3bTRsZFcydTQyS0RUMlZnZnBHUEUrYTNPUGNF?=
 =?utf-8?B?ekVySDhxTEUwREFWN1k0UGVVQmJwVGw4ZnFCdDMyKzZoenNGY3RUSTZGbnJv?=
 =?utf-8?B?TXZBeGVERVh6MzYrZ0lhRnBrcUg3dmVkaml1Z1Njb2c3QTNZdGFUNXlnRTdU?=
 =?utf-8?B?L0VucU1wZGFCVmVqbGdpRFM2S1I3cUpncVlJRGVVeml4d1psWUcySkdGTHlZ?=
 =?utf-8?B?N25VOW1idVU5VDZmZ2lwZm9XVjNhaXJTR2xDUE14VGhLSm03Qk5vNG93WEpK?=
 =?utf-8?B?QzJFM0FLQUNzUnZ1ZXN2SHZSZEZnSVhuVlU3dUNLVktHREJWOVNWaEtGRmlm?=
 =?utf-8?B?NzhTWU82ZmNITjd1M1hkdXNGYXlTZmJBN2pqWEZBMmcybTA2ejRJbUd1ZTdm?=
 =?utf-8?B?VHVUQWJPRi8rckpucmhBZTRYcWJWUUxVTzBhQjdxcWIwb3BKbVBRSWZVSXhz?=
 =?utf-8?B?QVZ6eGlFVGQ0S25JQWJRSzFYNmRrd2V5N1dZYmoxS3pkZlFGd0VXUnhlTHlB?=
 =?utf-8?B?Vzg0Q3Z4Q2VZa2oxUnhRVURYSFU1Z1RYckF0N1FsVHBGZncrVnhwUWQvN1Nu?=
 =?utf-8?B?QUo5K3Nyc2NpMENUUFZjeTBIbHMrRmtVczRYY0pRREZkTGJIblFvY0pRMEIx?=
 =?utf-8?B?clZqVkNkcmVXVzhKT2hBbFg2RS9oN1NpT0x3bW4xYkN4a3pGQXlPTGRjeTJi?=
 =?utf-8?B?RE1HeFgwSDNjeFpFT29rTmZQRWlDRm1PQk9taEFuZW5vNHRRQlEwUUFvNXhY?=
 =?utf-8?B?cUEzYnE5eTVvSWthcWpxYTlhV1N4Yk9VT09BRWlodGJwemtaK2ZKNjZyQXls?=
 =?utf-8?B?V0xoSm9la1lKOTdvdmJSeEFXck5SVExkdmRPN3hXZUlEZ1NKZWtXN1NxYUVF?=
 =?utf-8?B?YURtTktjMWtvSXp0dzIwWHRXS2krakxOazBjTURHcXo2U2VDc1lyTnVTajEr?=
 =?utf-8?Q?YkH0RU30oVp69?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUhMT1l3NnJvZldmdFh6VnQ0WUdVcUg0RTB0V0lRTDZUT09GOThsVDkwQlo3?=
 =?utf-8?B?MmpoOVhmbHFnTUcvc3RGdk5nSEVybzBVaGJwOFM2MGgxaUJLNWkySm1LTGwz?=
 =?utf-8?B?M05wcm9tTWJqbGIxdEwxdHlKcE9vL2xNZlFsVWl2QXBUOThvWWc1NTRhQWJ1?=
 =?utf-8?B?MUhqb1MzWkVTMlJOdGJBc1F2ZXZ5VGdkVmxwYzQydldnbStrK3RucG5PN0pO?=
 =?utf-8?B?LzNycGxRek1TMWVEeXJZQXY4dXhQMjZxWGdhYXRoeUl0S1hJUnU3MUtiZmNk?=
 =?utf-8?B?OWp0KzNidmFIYU95U1NQYVR6NEI1azE0aG55VGNTeHJuNW11aC9JZ01JcHpu?=
 =?utf-8?B?QUlVR0ErNHBxWnlFWUpIVFllbE5CTjQrYjlQc3hDNHpXc1ZaUHpZMi9uQ090?=
 =?utf-8?B?UzRxMFprcU14TWNCQmlDb05BSzlMWkRLelFXQXZxbmhRWW5LdlRPWmtkNWxG?=
 =?utf-8?B?K1BoNXZXd2tQL0RWb2xQc0ROV3REQ05oN3ppQmgya1dxYXA4aTRSUytaS0VD?=
 =?utf-8?B?aDFXZnJEaWhrWU5hZ2k2NFRDZldUK0puaGFreWZqYXdBODNqcC91bUliQTA1?=
 =?utf-8?B?TjdaVGJCbDdMWWFYdWlVTncvNjZDVDF2Q01kckN1cURwdUhVMnBuRk1uQXJY?=
 =?utf-8?B?citIWEt6ZjQrcWh4ZlJpRGVmY0MwZEo5VVhOaEVwVjJDZmszZno1QXF0Um9W?=
 =?utf-8?B?UDVTYjROU0ExNytKTE1iVlBxMTJ6SmYxWkhqS256eGdiQUZveGhzOUgrQmRu?=
 =?utf-8?B?WHQ2UG9WdUNOMk95dTJHenFJR0NjRHluZUQvd3NPSllDQTBzMDVVQXdLRTNV?=
 =?utf-8?B?R2NaT05YQzFmRGNUejl2UGU0dEp1K1U3TGlyR2RHcVhhK1IwcHVjTGZ2c1po?=
 =?utf-8?B?MkNPMzJhcU1FTzM4ZEo0NXhYUVFrK0VDREkwMWpUeUg5cTNCaDJGKzlxVTR2?=
 =?utf-8?B?OHduZCtxSFMySm5wVWRpbnVBWHB4T0gzRHJmZCtCdU5HdkxWRVVsMHZUclRw?=
 =?utf-8?B?Ky9PNkxUNjhFSEY2Nk9aNk9teUZqYWIxTkFlWFVVT3NHVzNWMnRlMEp2ZXZT?=
 =?utf-8?B?bkpmZ0l1NHVkZDM4ZHVzMUhmQ0c5Z29ZbmJqSVVzYll0cjE3UTFCb21KczNn?=
 =?utf-8?B?TzVGNzhuUkRudTFwbE9CT3NXQU12Rk4zMlNtb0FucVA4SjdJb2w3YjV5RUtK?=
 =?utf-8?B?VUNNRFY0ZzMrM3FkbmlXS2M0aysvUVlkcDVwUURtcXJ5V2NjWFF6c2pWODZk?=
 =?utf-8?B?cno0ZDZ6VlYrV0hJTDZBcWlSQWlBc3BSeEczcHhML1F1UXZvZTFwTk80SVlJ?=
 =?utf-8?B?OTZzRDhlY2QyQTQvMmRBOThyRE5Ja3ZjU2VyK1dCamRlZENiMGZVMWFnS09N?=
 =?utf-8?B?NDNaTkxYRjVyQzJlenIvS3lWa1lRNjAwd0FOMml6U0wwUGw2TjFySnJpSnFM?=
 =?utf-8?B?UDZCTVNlUEZxWXBTYm9tbkdVRDVqL21iWVp4NTlsb3Riamp6dFJxSmdnZnR2?=
 =?utf-8?B?V2JTdld3bzVZQmo0T3NQRTg0b0N5U280MEpSaEoyNXN1cys5VXRKeDlUbm41?=
 =?utf-8?B?eTJVb3VsY1FZTHFmWVRod3k5L0RYOUN0WEptYW9KamJkdjhHMXdWaE1Bc2ND?=
 =?utf-8?B?dGpITEJVQ1BFOFFXN1RJbWVRZG5Ec1BvWlFQK3NnWVNZM3JDUE1uMWlqMXZa?=
 =?utf-8?B?YUM4ZEhQcmNOZmpTdTluSTA0cVZibnYzMUpJKzlYOEFVa2sybXBxMGxLVllI?=
 =?utf-8?B?bjByL0lFNDFMOWdNY1hKQWloM0d6V2UyNlhJU3RhajFzZzMzd3ZyS1JWNUxS?=
 =?utf-8?B?N3pVL3doVHRvTStGWFhqblFlaEZ2SG9MR0VPNTkzQ2dmTWdsUUxVR1hHV3Na?=
 =?utf-8?B?SHVadU9wMXRMR1VuMWhrMUY4UzMwWDU3bnVkTWgxOHQxOVJNT1RBZlhRV3dp?=
 =?utf-8?B?VjUrVVU2TFpJN2IvbWF1aVdBMHVSR0l2ckVDR1FsSlJpVkh2VFpmYmRlVFp1?=
 =?utf-8?B?akhzWFV0NENlVFFQTURsVTN2WVNQaHdXUENKc3Eva29rWnJ3SERlcXE2R0dH?=
 =?utf-8?B?ajMyTHdhT1pPNlhqdnlkT0Y3R0ZCam85UmtzdVpnMWY0NTVnQ01DdmZ3R2VB?=
 =?utf-8?Q?mMJ8DpDwppjiNxt4geg5Aqwb3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GATc4j3lgSZAsPdWLvyr3DfzTvLDN/SZ0zU3prr1rq04WbSCX1SzJiXTWvhcaE7YV5KqU+Ip7fpMlgFqAgZb6O3qHWHRcmmqZHsygy2xCCfykLC8rY1hZxrNqDiMXdDkOPOGw2FwVNA+M4Ww1fgp5ycsJFFUfXCvLmsEYl4enl0qg7ZnGi+c1g1buuILl1tx8TIUDnTDVvRLHgjDi2edRPetdaXIsn4fRPGzAxRiJP9QyiRDzhHRX5tvGqpvMFGWa1HSomplspC5gD+CJ6N50HCmUF60jIne+rgvpyXxmrcYBVFyA4usaY11I6a1XWd41MZsvPT/iQFbk6XhWKyE395XCnEyqVEVlxbOByLcDB1K16MXdahXAvXW8u2td7rPrVfTgJwkRwrlN/vbrbk7dpOj0gzZqy6qSeuLps3QNTvoVoGUB6eKfjg0sKTrokxBLwLL58FX6P9jtjilf9YgtuSN9+1JJi1pmpc61Cg5z3N3zK8Q6sqs9lJx+36FEIG2xxYk/ObdAhBD40JAW6PUJVaaN42YVoI3dcd2AvQTbjS+dRFicQnpkwIF5PaxByZs8TVStWDXQTzINda8qLb5uTlv+6MCZBItS+E/iWpOPgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3a85ff-6d9a-4e27-4e21-08dd449c4cbb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:47:05.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dBUA6aNBKkb8HRVKKlh6EaUGzewFmTqvp9sYsy82/+VIxZilWiT6AqzbUCPFKjDCpAPrXpFZPJiz23M1KX4Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030158
X-Proofpoint-GUID: Lh-gaGffQw9EJSxuNw0DmUVVLriafwXc
X-Proofpoint-ORIG-GUID: Lh-gaGffQw9EJSxuNw0DmUVVLriafwXc


   Any rb? So that it can be pushed.

Thx, Anand


On 11/1/25 00:11, Anand Jain wrote:
> The disk max size cannot be 256MiB because Btrfs does not allow creating
> a filesystem on disks smaller than 256MiB.
> 
> Remove the incorrect warning for the 'max' option.`
> 
> $ btrfs fi resize max /btrfs
> Resize device id 1 (/dev/sda) from 3.00GiB to max
> WARNING: the new size 0 (0.00B) is < 256MiB, this may be rejected by kernel
> 
> Fixes: 158a25af0d61 ("btrfs-progs: fi resize: warn if new size is < 256M")
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   cmds/filesystem.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index d2605bda3640..1771ea5b99db 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1269,7 +1269,8 @@ static const char * const cmd_filesystem_resize_usage[] = {
>   	NULL
>   };
>   
> -static int check_resize_args(const char *amount, const char *path, u64 *devid_ret) {
> +static int check_resize_args(const char *amount, const char *path, u64 *devid_ret)
> +{
>   	struct btrfs_ioctl_fs_info_args fi_args;
>   	struct btrfs_ioctl_dev_info_args *di_args = NULL;
>   	int ret, i, dev_idx = -1;
> @@ -1402,15 +1403,16 @@ static int check_resize_args(const char *amount, const char *path, u64 *devid_re
>   		}
>   		new_size = round_down(new_size, fi_args.sectorsize);
>   		res_str = pretty_size_mode(new_size, UNITS_DEFAULT);
> +
> +		if (new_size < 256 * SZ_1M)
> +   warning("the new size %lld (%s) is < 256MiB, this may be rejected by kernel",
> +			new_size, pretty_size_mode(new_size, UNITS_DEFAULT));
>   	}
>   
>   	pr_verbose(LOG_DEFAULT, "Resize device id %lld (%s) from %s to %s\n", devid,
>   		di_args[dev_idx].path,
>   		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
>   		res_str);
> -	if (new_size < 256 * SZ_1M)
> -		warning("the new size %lld (%s) is < 256MiB, this may be rejected by kernel",
> -			new_size, pretty_size_mode(new_size, UNITS_DEFAULT));
>   
>   out:
>   	free(di_args);


