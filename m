Return-Path: <linux-btrfs+bounces-19897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38FCCFF10
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 14:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE286301459C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B41C5D57;
	Fri, 19 Dec 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XtzHaQRM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SqWqdyGj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716A259CB6
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149049; cv=fail; b=h89Ubg+nmZ2sdsU1NYM8NPYULoCLIA4pf9NKzlWALWMtABoFukCjlZ04OAjV5Ew8ciSo3/k3GNW9npHj27EofIEVXWeZvrWbM1GMpw5XoCb1CPVng7TcJEkFNAiL3IPnktMjcuCv1KZBZcAAkhNeo0wE/CQi+6+GNXaMRp2XwP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149049; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXHqaGVBbhEKI5HYn5a+WpXHFHEGbViFqoD0Lzw/sv+u1rm2LMhwIxr4bOps4ubZ6OECncyeeItlr6IvGHrJgYFbGbasfgJp/6lqpsFFkAYbKM9N8UizJncH4wnyy9YCZ0SzFglIvn2bDqfPrUcWXtQEFYofeKQzpcvo3B/Sgqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XtzHaQRM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SqWqdyGj; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766149048; x=1797685048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=XtzHaQRML6oU2PKSMLA9YM+LeAdRPgzqgdgnpat98QERXBKVABopA4fM
   2f0l8GNdzc+Gv7JAdhTnhRqh7jvlJ/74fVBRzY4UGBDlQL8tvfAdap3GZ
   nKI/5vlBrRvJbR0nJVJSgr2fNTYnOPvQfhvDvCj9v20v8GXP7dbmBgisz
   18qy/lhU1BwVRfUqTko1HAW3AGok9AlmDavks95lQ4xgsiJoAGZtVZnBk
   NVr3hwlCSaT/l6wYEARJZI9wPhnvxq9qv7M221UxUQBajVZSEEPsqX3LQ
   U+Yy/LiHupC1Bu6i9Dhrml/Uh21ndcZDVQQm3/i8Yo12rxTxbKSZjSSMO
   Q==;
X-CSE-ConnectionGUID: +QnW2BzMSuejFayWp5mDBw==
X-CSE-MsgGUID: YUeG9uOSS4msfE2UVzKLxw==
X-IronPort-AV: E=Sophos;i="6.21,161,1763395200"; 
   d="scan'208";a="134182936"
Received: from mail-westcentralusazon11013039.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2025 20:57:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKyoB4nlXEhco25Bl5SxAYIzC8stmheAj3Lq6q4RD9lMrN1GCBP7CUvC+Ehd5zNVqnWkLFbEKHbn9JB7U8KiUcSl5grfJJELXjhYFn3CXGXJrDcXc4lu48GDW1QHjoMrRl8pLtMsiJrvGqzg9B51VhHxz42wtCokmT0nYgVq1gdstm4380zhOw5+L78DrVR1t564QKIf7wr1rTQSNezIg9LHtdH5uBOF8XhDYK9eSJPm9O80+n8lfuv/ZO0gm1k9U1eRyb0ULIV4l8FwTlzNEAIdE1A3B4/Z2xWQ5/GL1kr+yD9TmzNGHlHXkuvvbp0noM1yXQ9HKC+zR1Pn6zHHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=JAEdhp9O5GGgm+A/sqAmFKjOsYiaSpXw2fWdxR/IFjG6rjGhGC4E5/FhjtsjokBr9ulyvnfs+aSyLSX8jsEVaPsCShDlbnTSTZ+1HMFU8w3jQTELprBocarCiX7qw0UJD2VCV/kKJgZqCOOjhAvpV/CmbT5nZosU/JAYGE4D4dhcvDmEm5Vk7/1gDRfS8bWTN/Y/0UjI8nZdaINrPWPeH15rPTOxaMKGvSadYA8tFDCJsqxgRRZsZoUMI4cudbsXSQkJ9SBiZmYHPt/m2HXVzUF0XEjXAdv58aHVQ4F0hEgRQUNG/cSfZSlhEVIOL7dlvEvzdt4mqVqwKoJ+C8SLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=SqWqdyGjZZINqRQpV3QY6/JeIZSbBS2+cqlmnx4nql9MChEDmFtCmyK/3Yc8HyNU4NzPynjF9PE2yBfGqRbJeU4+HDIZ7Wpnw7o/+fsKVwFkUKeVFIUpfHVfavfQlrsQmpMctqRpIC6uC9THVg5Cm763NekxzEILtAG6wccOKlM=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CO1PR04MB8297.namprd04.prod.outlook.com (2603:10b6:303:154::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 12:57:19 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 12:57:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Zhen Ni <zhen.ni@easystack.cn>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: simplify check for zoned NODATASUM writes in
 btrfs_submit_chunk()
Thread-Topic: [PATCH] btrfs: simplify check for zoned NODATASUM writes in
 btrfs_submit_chunk()
Thread-Index: AQHccLsUHP9KVU0GFUSoTF0yqI8t5LUo7I6A
Date: Fri, 19 Dec 2025 12:57:19 +0000
Message-ID: <50ac55a3-f3d2-47a6-8e98-6e6c76a1d240@wdc.com>
References: <20251219073649.1157563-1-zhen.ni@easystack.cn>
In-Reply-To: <20251219073649.1157563-1-zhen.ni@easystack.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CO1PR04MB8297:EE_
x-ms-office365-filtering-correlation-id: 1870b2c2-503c-4665-ad3d-08de3efe2500
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEVIZDFGb2tOT0gwZm5YdHo1QkIwb09vTTIwU3JkMDVpQnVpbjVRcnc2d0VJ?=
 =?utf-8?B?dGh0NStzOThyQmp6YmdRU3pPMHBoSnZ1Q3lzT2lqRU9xUmtEemNlWVR0bHlN?=
 =?utf-8?B?R2NDeWRKQ1R4RkVRSGRxdDlmSzZ3bTJ6UWZOcDRleHVpNjNEcDY4ZmxYbDND?=
 =?utf-8?B?MlFES3VKQ3BLT2ZLbGUzUkZocXFqTDdZSlhPQ2pzenpoS3RHV3BweVZjRGVB?=
 =?utf-8?B?TXdTOXRtT09XT1hvSG90QmhJdVVSTjBGOXQwR2pCNHVvZm94TjVXUDBXMlJJ?=
 =?utf-8?B?VnpKMUJsTGhpeWl3UURyeWVsZlVveHFsdmhHcXF5cXZMR3lUN1ptems3Z2Ey?=
 =?utf-8?B?T1lUV1N6TlhRL3EzTnJ1SmNVOTNQQjZpM25XMkpYeW9pU0l3R296NGZxUE9r?=
 =?utf-8?B?ZjhyQmJRV2ZkdE1qTVNMaHIyRDFNeGEyU3dNL0FuS0ZqSlRDb2MydGhTSVAw?=
 =?utf-8?B?YldITE5sZTlWR1lSWmY0Mit5MDkyU3VWbmZ0Yk5pcDNmZHNiQ3ZwUVBFamRY?=
 =?utf-8?B?a1N6V0p4UVBldENxZG00VmNXckYzc0xwOVlUQldwSnhzY1ZteHZOaXhJRmpz?=
 =?utf-8?B?c3Zyd0lxNXZadjhpajlXWTVZckhCRGhNbHNuS3Jha3hESmx1Sjg4aXIwWFky?=
 =?utf-8?B?NzhjRjN3TG9RN3pFVi96b2dBM1FlSkwrVnRkS08vZHFLZmxadVlJS2JvSDlk?=
 =?utf-8?B?cFk0Zk54NUlLSUJIdG9LUXRpWUppTGxjRm9CRmNRdWhPWkR1T3ljWkhYd0pC?=
 =?utf-8?B?MTNPUFVsb2FzY2UwRUhRaEwybUlvQmpDVTZvZ1gzWWJFZWJ1MmMwSTRSSm9y?=
 =?utf-8?B?eGdVYnhudnBqbGNieW02N216WnN5TGJDUVhCa2k1T0ZVaUpnZmx5b0t1S3JH?=
 =?utf-8?B?VzYyd2dTTUcxV21taXhmZ0YwdkdwdzdnS29OYkpFNlNJOGJ5dXp6ODRjbVc2?=
 =?utf-8?B?Y3lWR3A3MHhuSU1RNmt1eVozenVFa29UQXRMbG5tcGN2UnRUMDM3dWZZK2dk?=
 =?utf-8?B?bVJVVVExODNMTmgvejNHcEp0ankrSjVIRG5RNXZlWGEzOEd0YlA4RUJMRU8w?=
 =?utf-8?B?eHNnWkdrYVFPRk1jVXRMcWhEWlJ6VDNEdk1TTGZXeTZiMUM5eEhZdGx4NUhP?=
 =?utf-8?B?RW9QRGpqMlJUSHhlYnF4dnZIOGtiV1cvcXF6SVhaeFNPN25sZUhJQWdaZmI2?=
 =?utf-8?B?ZDQ4L0FJc2M4NVZDSVQ5djZBZEdMRFJ2c0ttVUcxOUZ2UTl6bWRiQnRTN2Qz?=
 =?utf-8?B?aWZEWVdSUGd4TVg3Ri9DTk8vRi9hMTBEMTJybFZ6VmJ4TFMzdkRZbEJNZ0px?=
 =?utf-8?B?c01lVUxvVDh2YWlvdVJqMmpYdm0vM2kwaVRJQkVCZldjaXFySURNT3VQaUhR?=
 =?utf-8?B?ZWJRRzhzcXBUcFBCcDNSRFVaUGFMZzVIcHJhdnM0UTBKVXRHUGlsY1lvOTdG?=
 =?utf-8?B?NSt3TjF6MThmMFRKYlpwd3hQSCs4Rk85SDl5NVZuMnBiZkJJRHIvZTVTZUlv?=
 =?utf-8?B?QThaVTEzSTNsT1ZYWkN0WG9tbFI4RGtzbTNLdzdxV2hJUEJkN3RFQzFEaGJo?=
 =?utf-8?B?djhWZVRiejVhak15OGtCazh1SjQ0V3dmRDJIUjc4SkF2VXk3NloyL1N6M256?=
 =?utf-8?B?bVIxQThHV0FleHFDTmVBRzZhWlpuWnpsQnZaU1ozL1pEcmVvMElLRWZRYm9y?=
 =?utf-8?B?VVpBNjJqQXRDbldzVlpXOFJFZDlhQ0RtL3ozelJrVi9wbVA1S0dUZ2NkS1pI?=
 =?utf-8?B?NzEwYk9KaHFKcGFzV0VJazg3K0JtbHJ2QkpaRjE5Q25KNFgxTGRnQktMOUY1?=
 =?utf-8?B?RDBseE1jSm42WG4vMU5KbXI1VTI4Yzd1VWZtK2pMZG1jbkl5OUhXek1FZzRr?=
 =?utf-8?B?U2tFdGZxeG1EaGtwY2VrRTYrTEFDdTlpdHROQ1ROZjMvdkJJS05tazVKaUts?=
 =?utf-8?B?TEI0Q0lpYjRwZ1NONGZWempFVm4wcGlxdjVOZXBnNmpiajVLMnU5c0g0aXl0?=
 =?utf-8?B?U2dhY3k5QjladUxYTS9JQlQrQ3E2ZDgxb0h1VHlNRndsRlNjdGpFQ0huYlRr?=
 =?utf-8?Q?nyCcsR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blFYOFh2ZG83M01OM2JRVnI3SGxSZE9BZm9VK1JDRmNHNDE0dzFoT1Q1czU2?=
 =?utf-8?B?WE9nOGw3Y0N1N0haR05idXpTaEtJMDJ6UmthcUlZUUhDZnBhd1lISWRXN0dp?=
 =?utf-8?B?bC91RjhtS1lhRk1rYXY1UWRpQmwxL3Q5OXFhWmNNTldsR0hYam9YcVNQNEZS?=
 =?utf-8?B?UGpLR09MbWhCSE03Q3dCa1hsRU16VExtSStBNWsrWVROQ2hRa1V4cEg0N3Uw?=
 =?utf-8?B?NHVobUREUlhhUXE1U1kwdEFkQitUV1F1YkNtdUw2SlBGYUd5UHhhMWs4clNP?=
 =?utf-8?B?Qnc3Rm0wYmRNelhqSSs3eWs1Rk12SWhQajU5bmVob1VLSy8rcTBzV1RSdWRw?=
 =?utf-8?B?SS81WFVqUEJHclhyWFVFODU1cVU3S1FrbEpZMjhkQUZzSzBiL3ZwYVdGQ2RC?=
 =?utf-8?B?bzJGZEZkZVdRcm13NWVsMlQ0V0Q5czEzN2hEbzJ0THd3RWxaRC9WWm00Yy9J?=
 =?utf-8?B?R3l5eU5mZk0xWDhXWllIWll0NTJOUitsbG00VXIyL3U1RXh0MXVrbTRKQlZW?=
 =?utf-8?B?RmVscjNCeEVrSHNJcmpjandES2RGeFRLWE93TnhYU3FOakpNWDlTNTJKbGR2?=
 =?utf-8?B?aU9WUkp3ODB2a2FmdjB6dUlrcGRpbjR4L2Z5SmRDWWl2ZzZSVHhpUTFVMzZE?=
 =?utf-8?B?N0dnRllWTnk0bUpvNDdWaE5KMjE5TDdFWEp4K1JyVUVTcklYRVpVb2tRbWxV?=
 =?utf-8?B?RHliaEZkWmRQcFVVeHlNVjlLQTB6MlU4V3h0OVBBOXJkRUxuNzJjajZudVBq?=
 =?utf-8?B?dEVaWVBHQzBTTndzOVMxZUtLcWNYRDc2SHNGaDU5akt5TnJTMSsvSEhwOFBn?=
 =?utf-8?B?bVVzNmZyQ3BCL2MwUWFGWVdwNjJMMGlFYW85VVpGZlVScW03ZmZyTyt0Um5H?=
 =?utf-8?B?QXJSS2JueVQwb2U2VjFtSGNLUjByVnRzYnlpMEorS3dWbTcxM3VuaTFHdlRh?=
 =?utf-8?B?dmtrZGdiRlgxRElqWHlkTERvbW4wVm5rKzZsK0oxdnNYQXlRdGhJalpjL2lG?=
 =?utf-8?B?cWlkbTdOQTVWQ010WSsxRHdEUytNNlhud2lUWFNzL3NQVm45NU5acmxaYkFC?=
 =?utf-8?B?bHNscVo3RlA3Nk1Cc0tFMnVRejMzaVNzUytkNnM1a2thQnViRWhlZGVYSTNi?=
 =?utf-8?B?Y0RkSlYwZllqRk1iaEpkQW9wYVN3aWhwUjV1QitqdENFTFMwRkpLTDlLb3hG?=
 =?utf-8?B?M1pHWEp4ZVJJdTNMb2JGU1RablRHeVM2REJvZVhzWDlKRGl2OVMxbElQV2cy?=
 =?utf-8?B?ZFdCM2F6VEs4dks1UlorSG1QRzd1eXdYK1VqTWdGL1JpVk9Wd2g1QXdzZngz?=
 =?utf-8?B?b2dLcFVjejc4SHJjN2ljUExnTEM5eTJZVkNlYVZ2bm5CODdYdkprMC9HL1lC?=
 =?utf-8?B?Qk9UZzFhKzFVb2Vab1hwUFZBa3lvVnYvTmpJelNzc00ycnovYnNnMTd6K1ZX?=
 =?utf-8?B?dGpSdkZTckZoTG8rZXBacUV1aVE5TkM2TmhabmpzQXFJUVpBZmplbWhZS1Y2?=
 =?utf-8?B?akplMjU0N2VRZDVaYmpMb1pyelFEenJVTnEvUE5rZkV3Uk9wTkZDc0NaWVBy?=
 =?utf-8?B?akZMQmU1cHdTVS83Qzh6SGhKU1ByY2xVeXFEeUtMbFJ2Q0ZiMHorMVRjY21J?=
 =?utf-8?B?dDd1cktUOGRhRG1vc3MwZXZwdWhDUm9ac014blhvcjk3UEdmOXJtckJYck0x?=
 =?utf-8?B?UjI4ckVQSElsUE5QTzh5am1hMWFYTmM4YXp4Y2xuSndjQWpKTUNxWWhoTGhC?=
 =?utf-8?B?TnJIU2t3WE8wM0lUYVpIb1lYOTJ2clB6aVA2Ni9Sc1o0R1pmL2MvU3ZyeXNF?=
 =?utf-8?B?VUFlYm9kaUUxdnhwWTVVZHU4RzJJUnA4SmE3M3BGSmtyMFZvdktqMFlaNlht?=
 =?utf-8?B?NlhuaW9RdDJXdGo3aS9QQWMwdHhObGxMWEZ5RHBGQ1Y2NTg4R1hON1hjYy9H?=
 =?utf-8?B?ZDh1cWw3UkdPQ0hZRGFhWnF0MVNobWJnalh0OE5VYXFCV0lOU05acFo5aC9j?=
 =?utf-8?B?VUVHdTFLQ28yeUtsZElPOFY1WkU2OStrY2p5YnFRTVVYb2htMTJYT29TM0Jy?=
 =?utf-8?B?TTNhUG9PbkI0Q2hBMS9jR1hGbEdFdFArUmJnMjM1QWpSSU0yanRvQmNBTjJP?=
 =?utf-8?B?M1dqRExUa3lxM0hHa29mWFVQU1lIcXRIVmd2UEIrZWtzdm1qK0N4Q2dXV3JU?=
 =?utf-8?B?UWFqamhISFpBUGwvU2F0RVBwcnhxZ1kwK0Y2UXYvejQyV0xXQjhscEMzQlNp?=
 =?utf-8?B?dVdjOXdhV3ZueVFQQzFaZ3hzaUZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <510C4AD084B8A8409EC2D35E32D7CB56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Cmmta+lryiDOmlOXZWF3xGzLN+dpSTokCrDCWIHO9nb6l3S/2h70F+Q54w0KsAtfebboknvzjMFmKPgeHCX/lHNnWMIobwqs4RJyWnhAASqazMrONaVevWuJRDkEEwW1mzbi+QeIXZToInfPhdh8+OIpIsfI0aSn8YwtiaOmRPSg45LDPYjnShCsaqH1jnBd5skKsk6sY5/KWXVGcx0uyG7Kp0TxZmaCflRtNh1ySVmbynPfft6g1uKvNtghfIHXBTOPM+/c0iAm3x4ybne3+VwhZmfgYUolh78u5Ct/MUY4ZrYqSmJBkE94p47Ssw8Jrp0Q/QgB+6sDl0C9SgY4OtCZoRzlWe+nsPTQkDuoPakbxDkzmhLNCANBq0t6IVbGX+6APPgOlj0oQTXeaJ6Rcb6beRp0mmOtVP+/fYXmWw85yu7N+XF6DK1bMofyVho3U9tqLhrewXuA/iiEZ9gw8g6Rn8Yut56g5riuiu9QFyi2ivweHXcCtkm+Cjrk5rfsCx8123w3J795u//VYkpf9Yhu+GwXb65LIElDgjcTvW+L30ZeJSH/Gi5g9jX3P+VEL7pfzM8sikoQW7dB2g8gxCKGuoweQ98kxw0CGvt0exyJI7pmJvf+Eqf30Qy6dbh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1870b2c2-503c-4665-ad3d-08de3efe2500
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 12:57:19.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNL5QLcVNinEUrx/AacImgncR8JB9//0pi+D7DOXeeTiEFjGhB4uDH1pVx9PA7Jy0HwKIgO8Xu7al1MSzJ/5z6sq/RFqY2mLjZRj6vApmig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8297

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

