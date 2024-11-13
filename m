Return-Path: <linux-btrfs+bounces-9576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E042B9C6A7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 09:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F960B2485B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA99178CE4;
	Wed, 13 Nov 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mq0yBcvZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Qm9356qB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D3170A03
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486109; cv=fail; b=lVaPYKVukAcBtL7uT6NM40jFzLP++z51ND2bZEmRu6sztiapGz2a1W9sFUh444Cw/0HNj4eT3ZH9mvFkerXj4ySLYVaGKaW/UMy+QLncNE/cl8wkV67AQhwH/SojKwMutR6yAz+WRSj7cOJhZeIvnqkhD/5vHlIXhFBIZIXN05I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486109; c=relaxed/simple;
	bh=Walj4CRFcpG4j2qlr1wLnvaXaRskkKU/eZrhezCoOPw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=doXDXIq5ZimFFFkIIPw8rzpxcRpQfypLHc90nCfJAY753h7tU5p0pYrvGs1QfBn/MapbUl4M8lWU7VhTguZp1seNrx7f1VygME8cgagGoteeb+VCdl88ZHBJ/5MT2PmhA/myDbABGAs0NWTekYyK+6t1pR0LxDSIRYETptNKqeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mq0yBcvZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Qm9356qB; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731486107; x=1763022107;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Walj4CRFcpG4j2qlr1wLnvaXaRskkKU/eZrhezCoOPw=;
  b=mq0yBcvZj4p8TxRpSSdRNw1+fba8a7phV8I8FXjtUWpVRuL7BVXpf8rD
   bExXm7kihkPtIUMRt2S+2bidxnYUfr3eItyYgdksiwWigCPG10MFViVnJ
   UsVZzkKftSwfrYM4ZeSFzHUSoIW/1qOtLJr9dPqkbuHkyj01Mb87/j3s7
   Qu+IV7WsbZTg7ikt/9oaBPDhu+pY9CW7LZGu4R3shp7PgBgJw3AoIfuWN
   aOc3M6Fk2xicjps4pxrpSQt/ZmK9ta+sfonpQEGfNjtAyWtqKcM1K9K1u
   6Feo8DOEdee+/K/Ascfjnt7H5f3xkcunuU+gOYTfk/zxqyyJcHvI0ZcLv
   Q==;
X-CSE-ConnectionGUID: QWmzehL2Qy6KeYskBQSxIA==
X-CSE-MsgGUID: vewvZZojS3iQjAHo5R5KYA==
X-IronPort-AV: E=Sophos;i="6.12,150,1728921600"; 
   d="scan'208";a="31448367"
Received: from mail-westcentralusazlp17012034.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.34])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2024 16:21:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L91VhTd7w8i62seovjyAQKlRGdUCN0vi7F9hwii5yHILrs/1L3u0z3Y4FZCb8Decvpt0PgMXj/SxhiJ9B4pRnHk7MKqbD4XeAm92BUzHgZQ/X84phgYWMvrDZNsumbyKPMWNhLhbNk12XWi4uBdGtYpCTZjXNZEo21QTEMjnRN4i/r1s9LBWdLlmMr8XjUG3xqr3VB3lZwDvVKbMYeMTlrtnB0/LXtyaXwTSAjYZhvFdFcJYoQ/DYPvvLyZ5GNf2dEkhWSLzlJ2Fd5R/jSKErpc/rbVFbOw4Ybw+x4vMHREpfIrhjokZzA4hAltd1guXyGkPJhIdW/i9zeO4rDlwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Walj4CRFcpG4j2qlr1wLnvaXaRskkKU/eZrhezCoOPw=;
 b=AqWubC7FbRnmeXhk6DNwf472j388f69jKZToWYuUL8uWaa4I4L2S5zrmcw43nlNk6VLubVFzQwtc4ZenKbj6BfOIC0y7SF2USDVkCOzmawEepl4TOOkNmxiMAWk6Bh72n7+TiR30yh/MfHn48w8RMdTGTAQJBqVzbyUDpEKDPmUDMs+x/TfqA+0sUWvK2xRJRC6YNOAZUGzYal4cZp7cN5trjFfaqJgbMKlj7SAKCS6voS1ihJOmIBu5eOoMeO1rcD3eZQGnWH4xzv5Bgk4ZuAyrnrRzbr8L48dfuvKkoyCL5SO2R0QhlaDE9mfD3tRqGo40xYQ5za0D9e6xbktc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Walj4CRFcpG4j2qlr1wLnvaXaRskkKU/eZrhezCoOPw=;
 b=Qm9356qB+kTsDuipELSlDatuITHFsxoqOQZWaaV3EstmN3el6hg+UzebMfMmuj7pLTE2GwLy7JgxbPZfPMLRq24JtlDPYu/GcLIZEal1MVFf7qsh9q9na33RnofsbjYhePQniMHhYlJV/b5DpcFF7D2XRG8k7SptAJ9wQ9uHpdc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9120.namprd04.prod.outlook.com (2603:10b6:806:40f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 08:21:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 08:21:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@fb.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Thread-Topic: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Thread-Index: AQHbNRwgBYJ0fl0B00KKEqkmyR8yWrK03+mA
Date: Wed, 13 Nov 2024 08:21:42 +0000
Message-ID: <1c919f94-83c4-421c-8ad0-e0c8da305cff@wdc.com>
References: <20241112160055.1829361-1-maharmstone@fb.com>
In-Reply-To: <20241112160055.1829361-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9120:EE_
x-ms-office365-filtering-correlation-id: e836440f-cec3-41e1-dfe5-08dd03bc3462
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlgxN1RpTmNYS0xWc1JFUFZKdTEvZnNnRXd3UDNlREJIbzNXbVJtVks1em94?=
 =?utf-8?B?bWJlOTlQYkp1LzY3MGg5WTR3SW02WG1PUnBSTFRrMjVzRDJTL1p4VnFlMi9E?=
 =?utf-8?B?NGRYVEIvMGJUbHZZS1FjWHRjeUd5ZU1MYm9qT3dTa0FzUU9HVTVsRTk5R2c2?=
 =?utf-8?B?amtva3p3NmpJeEVjelI2ekxybk9lbTgrNVh3MGtKbGVRUXZ0OGdzNmlWc0pY?=
 =?utf-8?B?emRUU0cwN2tmcVd4eFU3bDVvQ3g2eUpwNGZPaVJUWHNwakVEWWJsaXhnWGVW?=
 =?utf-8?B?NzA5VE9DVHJIRUZ3WmZmNEdsMURMVEhnNGRHcGdNRjBJN0MyVDFaYm9sN3JU?=
 =?utf-8?B?RldaSjUrdEJsQlNGYWhFMmtkUDBrYTd6TUQxN2hxTGIvc2p3SXV2Z3NqVG9L?=
 =?utf-8?B?RFpRWHRscUFQTjQwQVJlZ2p2Tks5WXpqZ29QNnlNdVczYUwwdVJvcGdtNmtG?=
 =?utf-8?B?ZDl4WVhKLytTdGlKUHRtaHF0eUV6dmJUY0RVOENrTjZVU3J6OEdtMWRWTVRX?=
 =?utf-8?B?TmZETjZ6T3hyM3FabjBFTFVPSjRuTmJILzJReUg0aDV3V2VTZDNIUU91d0dV?=
 =?utf-8?B?dEs4ZGNhTFozN3NrcVdKQ2ZwRmRSR0drc2locmJkdmFwaHV1SVY2MFMyT2Rz?=
 =?utf-8?B?dkRJZ2JDS2FRZmVWV3B3dXpaWWhsVlA2c0NWSEpZRnJOR1BNa3JPd2FvNjl5?=
 =?utf-8?B?YUhPajZpZWx1dVM2RTBzbmtOdTM3eWJNUEpjNjVVSEUwS0g2YlZFdVhrWGdX?=
 =?utf-8?B?Z01EeFAxS2dzOU10K2dJTGR3K2I1Qjh2Q1RIdDZJZ1Y1a1hOUHh5SFRPMXNi?=
 =?utf-8?B?dGpuQmhTdU02SDdyR1c4QjBWRUMranhTMk40Vms1SDdXTG84RWdKQ1Z3WlJi?=
 =?utf-8?B?UEVRTFgxV29ocUU3aWltUlRENXpHRkwxNEcrM1NwdHZQQlgrdTh4MVlnUmpz?=
 =?utf-8?B?UVIwNHliNk9PRHNhUDVLREJHMHV1aXAzL2dPL251dDhOcitsMHhKVUlDR1VC?=
 =?utf-8?B?YytpR2o4RmhXbTQ3TDF4eWRIRm1SQTczaThFMjdlYStMcmlpY3BtZnljUUEw?=
 =?utf-8?B?aUgybTBXb1hscjk5UkkvODduNG5BMEk4cm1LQWUveGFSTHZFajZhNkNyWDZr?=
 =?utf-8?B?UEZZZG1ydXZ5M3drS0UrNWRmRDNObXpsUWdQZXVHVTFGWVlDYnVxSFZJN08z?=
 =?utf-8?B?Y2pPdGtjT1k3c2w2L05uanlLVFVnZkhwa3llY04wMnpoeE5HY1RCUDAyQ1Fa?=
 =?utf-8?B?ZUo3cG9oQVN6emRnbDREa1g2aVVFN0QxRTVlVU8xdWQ4K1lMVS9pVG96RElY?=
 =?utf-8?B?MW1scEJMTnpDSVVYT2djbEU1dTZrNUczZ2FsdWJTQlg5SzEyNi8zSnk0akN3?=
 =?utf-8?B?cDZWL1pJZld4dFJyM2tSYzdPek9BZWk2Q0V6THoxMlY4WTNEd2kzT01PZTlB?=
 =?utf-8?B?cWFnQVhmNm1JeW4xbG5pVlYzUjhBRFhFSHZCN0x5bXgvQXloamdJSmhuMkZm?=
 =?utf-8?B?UmNJaDJIVlZiMDhYVUxSODJObDBqdUcwSXNnWEQzUklPWjRjTG05VlFvVjJp?=
 =?utf-8?B?QUhhcEZoS0RVNEdPZmJoQTlBWHhoR0NabVVZcHpBbmhMTWhmN1JqdUcrVGN6?=
 =?utf-8?B?bFZuWThaYVhLcUVqZnJPVjZQTGdvRWZwa2g1RC9lUm9aQ2hLTHVpSFZSL3pM?=
 =?utf-8?B?U1JhSVVZeTFTZHUzOXJONDVMeGU3RnZBRkpSRVVzek5WQlV1WW91ZU1SRlBN?=
 =?utf-8?B?NHhYVW9ra0FabzJMOUZ5MktPdzJ1eUtMeWUyM25uOXllSE0vYjl3cTZvaHVM?=
 =?utf-8?Q?Fq5HdBUE2pRYdEuItJxUfz4mbnm5Ebrfwg4MI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YW1JZTlHUFBkRzZKMnF1Q0w0VVpLdTBaUnRONjZLNElsSUVVdTlZM0NUQjZx?=
 =?utf-8?B?cDZ6VUVUREdwNlpKbTVkS1JadlBIL21ja25oNUhiKzhEWWJNVUV5WVB3eXVO?=
 =?utf-8?B?bStmYnJDV21wK0pXVlh3WXNwb2FSYlJIL09RQkFZRFhrdHdWQytnQ2tMT2tG?=
 =?utf-8?B?MVVFR1g0VUlrZm8rczBrUU0xRjY2Mk5MRG1VVDlaWWNzTzZzR0R5NjRlUzE1?=
 =?utf-8?B?YkdSYUpidDRJN3VWZEpVeW1SOFEzZ04wWWgyTG94RVJVZHd3Z0NOdTN5MUNJ?=
 =?utf-8?B?OElpb0VmancxWVYrWXFUV3JOZXV4YytpUlozVDVsT3pOc2gvZU90Q1BWYjNW?=
 =?utf-8?B?SndVMlVMSzJaeWx4dnhBN0U1WGk1eEtpTUlKRWtGdEllWDJ3SzN1c1ZpeWlT?=
 =?utf-8?B?b2RmVVNUdnh5V3BJRisvN1hHaWgwYm1lRDVqTzBkK0FNWVpIcFVySTFWUUt4?=
 =?utf-8?B?c09yWGFDSHFUWmx4azZCK1BCQ3hMODZBamIrdUdXTnRPSTN0NVJ0dzNXenQ4?=
 =?utf-8?B?ZmJqbWRackN1OFdiMWVmbDBYUldpWEJtM3ZIRU9YWUxKQm9EekVOSCtZbUFV?=
 =?utf-8?B?RXJ1SmNQamo3cGdzNXJIbTREWUVLaXBXQ1VBUUtFS0VRVGV4TnZwN1BsK3VT?=
 =?utf-8?B?bmd5Tno0SkxDTUNZZEM0ZVVmQ1pjWGNaTnpNVzRqbG9hQXJ1WWozYjd6OU94?=
 =?utf-8?B?WHYwclg1SEVSSGJqSjV4dngyKzlEYS9BMTBMa3NieTBUcjZRaWtXdmw3UlBk?=
 =?utf-8?B?RW1kc2s3ZERURzFEMDYvNjVOd2dzM2dHZENwK2pFbFlrK3V1NUhFNWtYRE1R?=
 =?utf-8?B?QUxqRTNXNksrZXFlU2NUeUJPNnNMVUw1ZWdYdW9vNTRKQ1l5ZkNiTU9Ra24r?=
 =?utf-8?B?VURydGt1VFV4TXVCVmdPbVM3dWhzamNSWitqdDFReW5oaG1mYWJSNEFuc1lX?=
 =?utf-8?B?b3czbjVxWTVPanJnS05tSjZBaVZZK0Mzb20wWkJZSHRpVFBOK3VZbkx2MEhF?=
 =?utf-8?B?WVh1MERPN1dRYjdKVXBrWVJwNkt1VU0rcXFOTFExM1o1TE5mVml2TGp0bTVQ?=
 =?utf-8?B?Nzd0RlQ1Q010N1hJZnVUTGR5WDN4dHoxbFI0QlN4L0dkbytmN3R1eDlYYUt6?=
 =?utf-8?B?d2ZWdEVoSDVKQzZRZUcrTmVoM24vdFV6R3ZaYmQ1YzlaMHd2RGJaM3NOTmFL?=
 =?utf-8?B?MjJ5NTQxVzYvZENxTDRySkk2dkxpbkxnZmJMR3dpOTgwWlArSEZSYlRhTkpw?=
 =?utf-8?B?QnR3cVlSU3UzWklOMnExRjVwVXJvQ0t3NG9PeDFCaUFnMFR5WmdjYzVlYWZQ?=
 =?utf-8?B?Z1o3MXBhMDdWM2dSbnhXbkJpNVc0bjJPK1pRcUh0Z0tsRGpYajFjSEl6aDlK?=
 =?utf-8?B?TDdGeHZ4N0NPaVVpV25xK0duQW0xdHN6cEFzelExU1RkbEY3UHJwZ3F3V21m?=
 =?utf-8?B?OVQwN3VvWmViOHFMVGVFN3dMMlQ0d2JhS1NrbGl2WWVnSmFGRm1jZExCUzBE?=
 =?utf-8?B?RUU3UzNCdTlVd2V3Tkd1WmZQSVNjQ3BSVEhuS014cVhYSmNUWUxCY0c0cktv?=
 =?utf-8?B?U2xCNVF5MHdlVmpwZTlCNjhXMWJJTzJ4NWdpRzZRSUcyZmFmQXJZTVVuc3Bt?=
 =?utf-8?B?SldBNWVJNUdONzVZcnBXdGZyWndNZE9SaVE2OE5PSUl3VUQ2TmRMdElvZjRz?=
 =?utf-8?B?QWZtNlJ4dy90blhHU3JNdHNTV3pCbjNlazJOUWZYYTE4K1MxRit6K09wbmNy?=
 =?utf-8?B?OEM5M0hKcEVtbEFnK3hjM3dTanFMbjBKRWlrUUE4YWliUVgxQm9Pc3ZYbkZr?=
 =?utf-8?B?cDFoUk4rSlZIWDVINm1QLzRpQ0I5L3gwTEp2Y3pBbVdiQVAxK0FLbHgzSmoz?=
 =?utf-8?B?SXFKUkdWb0lCSTBLVXZEYktPUlJQb2RRb0dCZ2llWkxUZnZjMnVEM2pxSTR1?=
 =?utf-8?B?Sk1MZmhkZlBEQzRYMlFISXFTd1VFelMyYzR1RGdXTmpYWmNleFFqUXRLVklp?=
 =?utf-8?B?bW5BNTM1THozajVrU1QvZ284cW1yN0NCOFNYaXhLZkZOZzRZUFhFU1hWQWhT?=
 =?utf-8?B?d2REdEJFZDB3RlFDUmw4NGNMWG10QWI3eTl5cjlCclpyL1l0UXlIR2JOdlBk?=
 =?utf-8?B?dzUvNnRPbDdabHFSRnhKZm5UV1FJZjVueC8wakgvdjdRMVdCZGY2MmFibkF0?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC5788891B8E3B4D976BD7780CC2E1AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WBK0dN9lWquEqWnW/qm67z/cQiRx41ygmwmGiXc1XIgvaJs7mLiXBFClJmk8nsS7iOvcyQnZ81FRGB5Z5jI9U+OJ04EN82DxsKwMKPnjHESANTJ3TPFVNBdOMtM9+KBepcrRw5chyZiqgFyr5rnkvI4hLGeyOOBSKG3lgxd4G6hO72jeCcb70Uqr/CpDnQGNIcXMmKptwajAQVf6B16sKeuIIAs7+eE+dbtH6H3HJFhMguQlzw5qVclgThDrrn83IcS20fygE4lnjJ+f7jiOwueYhjb2ifZiE44872AcYzltE510C2dNgYwjD802uKM6ABzk3eaxmBHUwkft1gm5ZBkZHLJ9fa4wMS5oPt2QOrz2YxxuDoRFr8xzOdwNRcj2AMCTaFGerphXhtgp+tXMrYPl/wU8Fi53jYQF4u7RzzW85wxMUu+h5a676QX0Bq6LnkeVBmkMgc6HQvz6XqwY14rlboXuLaUoQvu9KwfbXtQqGvYl0h8WS7zBAbRudPwP62+d0WLH7HgB9cxXFEzGVWg1e6Dz5qwsMOtgTf5MRxsWje/qWXETogeuIJiZYdgEzpSf7JAZTc/dpL/jIE8t+N8Wq6bWK91rs1boxKR0biM5up2QPRyLf68lBNsnsZ1t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e836440f-cec3-41e1-dfe5-08dd03bc3462
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:21:42.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbOMXJFiagEL8fVT9MJUr36Nj1Z06EDD61Sz+6G8jyJr6iTjB+VjNDp6ZzW4sjACHrboGPD1DiVh0adDdmzOQjojhMpg1QI4M71vvRFV2Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9120

T24gMTIuMTEuMjQgMTc6MDEsIE1hcmsgSGFybXN0b25lIHdyb3RlOg0KPiBMb2NrZGVwIGRvZXNu
J3QgbGlrZSB0aGUgZmFjdCB0aGF0IGJ0cmZzX3VyaW5nX3JlYWRfZXh0ZW50KCkgcmV0dXJucyB0
bw0KPiB1c2Vyc3BhY2Ugc3RpbGwgaG9sZGluZyB0aGUgaW5vZGUgbG9jaywgZXZlbiB0aG91Z2gg
d2UgcmVsZWFzZSBpdCBvbmNlDQo+IHRoZSBJL08gZmluaXNoZXMuIEFkZCBjYWxscyB0byByd3Nl
bV9yZWxlYXNlKCkgYW5kIHJ3c2VtX2FjcXVpcmVfcmVhZCgpIHRvDQo+IHdvcmsgcm91bmQgdGhp
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgSGFybXN0b25lIDxtYWhhcm1zdG9uZUBmYi5j
b20+DQo+IFJlcG9ydGVkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPiAtLS0NCj4gICBmcy9idHJmcy9pb2N0bC5jIHwgMTQgKysrKysrKysrKysr
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2ZzL2J0cmZzL2lvY3RsLmMgYi9mcy9idHJmcy9pb2N0bC5jDQo+IGluZGV4IDFmZGViMjE2
YmY2Yy4uNmVhMDFlNGY5NDBlIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9pb2N0bC5jDQo+ICsr
KyBiL2ZzL2J0cmZzL2lvY3RsLmMNCj4gQEAgLTQ3NTIsNiArNDc1MiwxMSBAQCBzdGF0aWMgdm9p
ZCBidHJmc191cmluZ19yZWFkX2ZpbmlzaGVkKHN0cnVjdCBpb191cmluZ19jbWQgKmNtZCwgdW5z
aWduZWQgaW50IGlzcw0KPiAgIAlzaXplX3QgcGFnZV9vZmZzZXQ7DQo+ICAgCXNzaXplX3QgcmV0
Ow0KPiAgIA0KPiArI2lmZGVmIENPTkZJR19ERUJVR19MT0NLX0FMTE9DDQo+ICsJLyogVGhlIGlu
b2RlIGxvY2sgaGFzIGFscmVhZHkgYmVlbiBhY3F1aXJlZCBpbiBidHJmc191cmluZ19yZWFkX2V4
dGVudC4gICovDQo+ICsJcndzZW1fYWNxdWlyZV9yZWFkKCZpbm9kZS0+dmZzX2lub2RlLmlfcndz
ZW0uZGVwX21hcCwgMCwgMCwgX1RISVNfSVBfKTsNCj4gKyNlbmRpZg0KPiArDQo+ICAgCWlmIChw
cml2LT5lcnIpIHsNCj4gICAJCXJldCA9IHByaXYtPmVycjsNCj4gICAJCWdvdG8gb3V0Ow0KPiBA
QCAtNDg2MCw2ICs0ODY1LDE1IEBAIHN0YXRpYyBpbnQgYnRyZnNfdXJpbmdfcmVhZF9leHRlbnQo
c3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsDQo+ICAgCSAqIGFuZCBp
bm9kZSBhbmQgZnJlZWluZyB0aGUgYWxsb2NhdGlvbnMuDQo+ICAgCSAqLw0KPiAgIA0KPiArI2lm
ZGVmIENPTkZJR19ERUJVR19MT0NLX0FMTE9DDQo+ICsJLyoNCj4gKwkgKiBXZSdyZSByZXR1cm5p
bmcgdG8gdXNlcnNwYWNlIHdpdGggdGhlIGlub2RlIGxvY2sgaGVsZCwgYW5kIHRoYXQncw0KPiAr
CSAqIG9rYXkgLSBpdCdsbCBnZXQgdW5sb2NrZWQgaW4gYSBrdGhyZWFkLiAgQ2FsbCByd3NlbV9y
ZWxlYXNlIHRvDQo+ICsJICogYXZvaWQgY29uZnVzaW5nIGxvY2tkZXAuDQo+ICsJICovDQo+ICsJ
cndzZW1fcmVsZWFzZSgmaW5vZGUtPnZmc19pbm9kZS5pX3J3c2VtLmRlcF9tYXAsIF9USElTX0lQ
Xyk7DQo+ICsjZW5kaWYNCj4gKw0KPiAgIAlyZXR1cm4gLUVJT0NCUVVFVUVEOw0KPiAgIA0KPiAg
IG91dF9mYWlsOg0KDQpDYW4ndCBzYXkgYW55dGhpbmcgYWJvdXQgdGhlIGNvcnJlY3RuZXNzIChh
cyBJIGhhdmUgbm8gY2x1ZSksIGJ1dCB3ZSANCmhhdmUgd3JhcHBlcnMgYXJvdW5kIHJ3c2VtX3Jl
bGVhc2UgKGJ0cmZzX2xvY2tkZXBfcmVsZWFzZSgpKSBhbmQgDQpyd3NlbV9hY3F1aXJlX3JlYWQg
KGJ0cmZzX2xvY2tkZXBfYWNxdWlyZSgpKSB0aGF0IEkgdGhpbmsgc2VydmUgdGhlIA0KZG9jdW1l
bnRhdGlvbiBwdXJwb3NlLg0K

