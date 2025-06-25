Return-Path: <linux-btrfs+bounces-14938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03CBAE7FB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB021889CFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA929E0EB;
	Wed, 25 Jun 2025 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QYj9/AzQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rmtrdsE3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7B23AD
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847954; cv=fail; b=rrQ19MuOtJc4XirJ4WWIT7Fi3PDF9WJkVeGxKvkKVJVG9j1pEZBXV5Al2ePzbyGTllSc+Mi7TH6IDKFL1knD5cRC2YSupyMdDSf175xWoG2XF8CREHR8HC7ViUAsn5zytjUSyYg0pVPUglKSmTyVY4L80dcqG1WkUZcqlbrrUBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847954; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I+QM5KDwai9Ntbo1rcq0mIk9LbZnFjZGfReufbU9Ny9kOxs0Bb2FYzJTZPIgXlbQJ8zTR187PZRZvvYW3/9rBVAwjFW9pDyxUXsn4AGcmxL542lKlM+Nb2QK3tXh8AOfHOhCAiRXeehAeczTLkZRhIDSLXInnkyMkH4FDhGr7wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QYj9/AzQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rmtrdsE3; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750847951; x=1782383951;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=QYj9/AzQjmgwVt4BluIPBHpTZsUHPmZK4EyGoFNt3MbC3MPRGRa7jqFg
   qDdbxLVfLchCVSwTCP0q+9w5VV4KdZmtKDOsvTgsEHEJdDvz6QmRTVvsG
   2opgfIjpNyX2qjpMGfKBKLfpmDP2hB+yUjR/HTbwSI2M5TIO2RqrkTJbe
   zQ+vhAfQiJBR95MiYo3Y8ydwlRkW7LfYi1qFNh+NoYd3m/GWnjPZO/jRd
   rfvjXANLU4I8O+BLTW73kFzX2+g89gm6ldQongrO6Adp2chN10cOUkeVg
   b3T12fdFChcHLgwnshRW+5xe22GBv1n6B/RLroeY6RLQ6uPa86Vr6N9U2
   A==;
X-CSE-ConnectionGUID: 8IQIAqPfS226uDLUzxVyIw==
X-CSE-MsgGUID: ZzYO6F4jTKSmddvdLWWccQ==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85204524"
Received: from mail-dm3nam02on2078.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.78])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 18:39:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD8WSD8PESbTOKjmyEbeQNT6R6ucbglHbgTtskdGsYZNM+JGpG83l4AqWcoVIa0CFtGoC5p3MYhHbXfZfjEZKbCQi/xIQx0q+jSlWaHa7UKnD1x7ZPjj0vNkRrbq6DN9q1dGnW5INTyUeylkVccAncyBGn/I8PFK1c2436wL3HydMMikU4PtalLQnKOxa0PBjWLC649xowqEaEahWe2fmh1J9IDdP5SwL/07R5karnn+iDve2VziTxvor2j7VE4IN70/AYTYv1zkQHRMpky+TUih8ExMYS1gHsVwwL8GLHV5exB57yTjqEvVMIw59pO4Qv3Tj1NvHoKwOC92VEvbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=FKGToODjyCVHxq9m6rG/1utBwrP5EIYo4hkJx6AGTCpmH0RmXY/kAYyQmnsdtxRa9n89FAvjEBziyEG8KcfmtELtmKNzdM7bbTmyUL01IX5R/eoVi8Qnwef22wUz+QVQzg/+Jv7S7mccLDGtseoHHY3SAoc5aD8S5KneOdLaYf2wGZHW5Zm0Zy7w4tzhOkcRQmEzMP0c/MIv2s0GFtEZVjVltPrXHEvvVP570rECXAIDLGaDMQWqJRrhMbilzrXl946a4nBKzyk21RFyZocQ2z8xhfNmTeYhE/dJ2xNEvc7CH6ILEDa2YB5PtQm6PGhHTtY6dPGj7J4/SCzzM73cGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=rmtrdsE3sLN0CCBJ3D8jtbj4GpOz3WIJFBXr//NihlQGM6lM25Zq7sUCV9+d/fGN+wHXYDyLB3OXuQ083ULK3Qlje9hREaKqoGooGUyS5jh8dAfZSZ00T/SVGPIOxBS7zaKJt6qFO5kbTeA+qTqjUPpuEwjThxl/hF/uGthLJXk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9132.namprd04.prod.outlook.com (2603:10b6:610:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 10:39:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:39:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/12] btrfs: record new subvolume in parent dir earlier
 to avoid dir logging races
Thread-Topic: [PATCH 04/12] btrfs: record new subvolume in parent dir earlier
 to avoid dir logging races
Thread-Index: AQHb5Rglz7zJPMrwFEqW55XiioeosbQTsJIA
Date: Wed, 25 Jun 2025 10:39:09 +0000
Message-ID: <9625c7cb-f466-48b2-8f82-b53b182c68e2@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <5d51d6c1f411655e67c7af87c9336ccaf5ccd6a2.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <5d51d6c1f411655e67c7af87c9336ccaf5ccd6a2.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9132:EE_
x-ms-office365-filtering-correlation-id: 4b5fe410-3fd8-4d3e-f322-08ddb3d48450
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzN0SXV3c1VoK2tDaFdHTHFjM25LeVptK2RGTjAyK0g5YjRKL2VxalFDSklI?=
 =?utf-8?B?dXdDamFZTDFBNWc2UXhOZ2dMWlVKZ1NERnlJc0N1UDFta0w1QTAxSSsrdHdJ?=
 =?utf-8?B?MjlybCthWWVQbks5SVluaWk3ZWlzVzRBVC9vMTY0bUFsR0JqdTdEWDdTVTZU?=
 =?utf-8?B?K0RqeEh3MzJxZUQ1S3NZVlJTV0JLUHNoaGNLMzVUNmdkWDg2ZFJYTEhHc0l1?=
 =?utf-8?B?c2hhYTFnemtXd0Yrc1dPOHI2dVVEaHJwVGcyblUvcXQ0THhmaVBUUmhOOWVP?=
 =?utf-8?B?aHZjemhMemFtZVNxalQ1OUREaGlSQldJWkF6bUxVbGdCNE1WRE9seTkwWEdu?=
 =?utf-8?B?dEltL2tXODVSNDJSdjEvSVA5ZXNJVVZYNnVVQk11M3VwNFY4aHZZMXd3a1Y3?=
 =?utf-8?B?V24wZmdGZUFhRG9qekhzYWl6TGxXd1liOVFVaFZxTU9wWmd6eU9QU2c5cXpy?=
 =?utf-8?B?NlRQM2w4QVQvMXA2RWZFVlNnTm5FOFBLUVBDdlpLVG1QcUgrdStKVVpVeEpq?=
 =?utf-8?B?SnE2RHBUS1dHb3BtNXlmanMyd0E1cWFmWllqdWliQTVjeTdYNzBzZlUvWUZn?=
 =?utf-8?B?RjY1YU5nNmlMS2I0VFgxY0F2MWJGYWN0dE96M2ZBZ0VWcW9uNzd6VU15akpt?=
 =?utf-8?B?QWFydXNrb1ZjOVpJOWJUbnluMTRPcUFpeTE3UVJmaHRjZ0VUYTRTalQ5eTdz?=
 =?utf-8?B?d3ZveUpWS2tWUVd3UU5ZK09EY0hQQkltWWF6RHVQU1VGTWpSTU4zZlAyTE55?=
 =?utf-8?B?UytXdWVZZTZrZEtGZE1pb3BuSzEwREpyRTVSeExTeWV6L1NmcFhxWGh4b1VS?=
 =?utf-8?B?WUx2Q1U2a3h2ckFRZ05vWmJhaC8vcERja0xmWTNEN1hCdGZkVXk3dDRCWkdn?=
 =?utf-8?B?ME93UHBhYmxZVnU3ODYzTVBpK1FnNG55cjJmQUJqbW5KTFV2dzFzWFk2RVNz?=
 =?utf-8?B?ZDIrS0RTa1VjL01BeFprNXd1SDM3WTdrdFZhU2JFMjd2VWdkZmt4d2JNMmIx?=
 =?utf-8?B?Y2NRLzZ5NkVQSFRINVpJMFBmc0tvTzI4NlYxRWRvN3RoUitiUUd1aW1PUnlD?=
 =?utf-8?B?bUNQUFJYNmVlUTN0VzhoNUQ4bXFHZXo3S3JpQlZOQXc4eHJ4Snl2d0prSUJJ?=
 =?utf-8?B?Y1JxdERJVXB4c05aOGV2d0RZMWdIZkY3OEdTbFM1ckQ4UkJ6R3hhZDlEZUtH?=
 =?utf-8?B?MmY3S2NRTkNIbTRSWlhORkhsb3dlNVIzdTZzS3p0ampiQ3VkR0pFNVlaV1BE?=
 =?utf-8?B?b2NoazJBQzZuWlI0T3BqOVVGK3dZbGxjS2FpNWxIc2x5NThsdFkvMGtsc21j?=
 =?utf-8?B?RTlPT1JJK2xTNTlReE5SWStCVVBacEZEUFFkMVFtMFppZ25mNVdsaXU4QitC?=
 =?utf-8?B?OVJXdHlYdjRGQnRlNG9WRmVOSTVIVWRyLzJPc0pYd1R6cXpnOHhIWWlyeXJB?=
 =?utf-8?B?ZVYzbWc2MC9mRjI2Tyt0aEI3UVVjYUhsajdIU1UzNlZKbGR5N0s4cnh1akZH?=
 =?utf-8?B?elBsZThqL3NGaVRTRy9lWFFsdEczRVJwcG1paHM5eDUyMmc5RmNXS2psSnN3?=
 =?utf-8?B?Y3M3eHp6ZHBPL3R3elBPSG1UOUdZZmJiOGJEbXpTRTREaWdoTFJhMG5Od1p6?=
 =?utf-8?B?R3ZZQWxEdkcxbVlrRjRqeEtRSVlhYjJHczNYbmszblFTZUNTT1hCNlM5YzB1?=
 =?utf-8?B?NVR3aG9IYVBxajJLeW5QNzkzaXRPakdrZE9wVnY5Vko5RXpCSHFxRkhvZWpF?=
 =?utf-8?B?UHpuY2ZTN1lFZmRnV1JRcm5ScjJyT2JQRTcxZ2VYQStPSTF3a1l5RG5UWmMv?=
 =?utf-8?B?UWFtYWp5aWZ2VVpOaDVva2QxZURQNThCdXpWbW1nMzRTVi9nNHdNSnJ0NWdi?=
 =?utf-8?B?TzNiYUVEVFdYL3dvejFRdDcyMkV1Z1ZWeEhCZEc2c0UvajE3Q09TQk5ndlhS?=
 =?utf-8?B?UncxTHhmMm5ZSkExc3hyUm1FdnVuVGtKT1BxSG5qUjBTU0RNWnlCYWpzSFNr?=
 =?utf-8?Q?6Kby9A9Bju8wO6MZR0qnuOfcNzTe4s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MW9ocmxYK3BxVGRlU0YvQklveDVEMkliRHJNNEQwdnYrUFF2SE94TUFhYmIx?=
 =?utf-8?B?S0NWcGdyNytja3AyK2NjanVjS1NvZEhWWDhzRnlyYlFqQzR5eGs4L3lpR3JW?=
 =?utf-8?B?eTBFWnU2U2xzVTZoUGNrOTRHYy9aT25NTlhzTksvRU1QWUR2WXlXVEZyOXc5?=
 =?utf-8?B?ckdZdjk0WFJuS0szRTRsbmpPZmM1RXliSmdPRThxaUtYeEh1TXI0WE14ZFB4?=
 =?utf-8?B?WXEyTmlKWForMWQrMFFFVVpuNnl2UnZsL1prNnVZcEJDU3JDdU1Id0NPRFhT?=
 =?utf-8?B?WlUxOVhiaEFJRmxUZ1RtM3VjV09QQ3VHMitmeURTL3RQdmRONFk1S2pGcHpy?=
 =?utf-8?B?aHJya0RMN1hHRzg3VWVwZDJkMkxYVzlUZERiZTdYbFR2bzQwWEVRN0kwamxP?=
 =?utf-8?B?dHBzTTd3cWVhK1FTYXRjcHBycHJ4Q1Y0cVBnQ05WZ0NhUEM1YjYvZVV6OEZp?=
 =?utf-8?B?QmRLb25UaW9qbks4SmszTlMzV1oyZmxDR1B3SEdWT0pXUHpYckRqSlJubS93?=
 =?utf-8?B?Q2lINk1sNGVzK3BWTVVQUlZNRFFjTjBMQ1lqdXZuR1Z3VXg5NlNtQ2xFZk5l?=
 =?utf-8?B?VjQ0Q3c1c0dMWVRRTkg1T0dwYUthc2RPR2FsdDVPMUZ4aU4zRjR3SDhab2Q2?=
 =?utf-8?B?MGErMmJhUnhML29DMnErWDcyd2RDRzQyV29NZTdxcWY2OFhtUnBwY2lQbFpi?=
 =?utf-8?B?akY2UmhxQ1EzeUVWUm12a1RpUUoxTTN5OHlTVHUyajcvNjh4SjFIaGpYaUtk?=
 =?utf-8?B?MGFDbzJJcml5czBnNzk2SDRyaVBnOVJIeEMxR0FrVHVoUDRqYldFeHlBTlJV?=
 =?utf-8?B?TmtZNGV1YWhuZTlpclA0Ykx3QzgwWkN1ZXNmeW1QV2YzbCs3M2V4Y3J4ck5Y?=
 =?utf-8?B?SWNBWkdZSm5vUVlGZmFWRGZYSEhGaTFiZUgxdkpHdVJoa1NabzVXWTNQaTRZ?=
 =?utf-8?B?VGYzM1R1S0xIRklXQlNHb1BNZXlPSlZyTy9NUEQ2UHhOaThEWGZ4YWRZWW9X?=
 =?utf-8?B?aFpHZEdEQmZFZ0RZUzdSODhpNHpYOVpaMUs3VzMrcUQzSVBVWHBTWlhIOXFN?=
 =?utf-8?B?S281UkVMUzJyR3hyd1ZKakxPc3huQlRTY3BGclJLaVhOQnNMK3htN3U1c1Bi?=
 =?utf-8?B?SHg3UUlOZDFWU0J5QWd5QTBnWnpHZFhacTRnNmdoeVAvTEMvUnhSZVBZNWVT?=
 =?utf-8?B?Q252cCtNMERBZFdtUmFKUUVRTC9VSmJvS0RXL08wTXZ6cUJDTEE3cUgvcVMw?=
 =?utf-8?B?YUFhYXVwL1JmdXZkc25vd2doVmcveWRUMWxqWFBDTFUyaStmamoydkpjc2pF?=
 =?utf-8?B?ejFUblF4QVpXZmlNSDJxdkdydVRpZUV5TkRDdHV2NGpWanJXVUZTSURlbkpH?=
 =?utf-8?B?aEU5RE85bWZHRXJFM3lyMUhqK0ZJNXhzS1FTMU1HNVk1MnFnMlp3YjhRQTdP?=
 =?utf-8?B?N2RHenAycGw2NWEyVlRvVGc0KzRyOXN2azQxVnhxMDkxWnltbTlqK3dHWGMw?=
 =?utf-8?B?ZHZiTjNlSDJsV21JVDNKYVhXTUdOZExPYjFjYTY5NlpzckFCaXkwUUppSEpS?=
 =?utf-8?B?RUlhUy9TT0RXeHpHL1FQN3c4dnkzMnpGTS9abjVadzdrMk1VV2VNSXZyallU?=
 =?utf-8?B?SG9qeG0vQ0dIQWt5VGxiSmNBdElOcXlDd3JMZ3FWN1pFMU95dXk1Z1N1elFk?=
 =?utf-8?B?U2V5bTNINURXUzhzMWg2eTdYemVYN3VqRmZaZXJNam45RVlkUWhWcVNFb0Vh?=
 =?utf-8?B?SE9KZnhpeUcvb2lRKzMxM3ZPemRWQXJGR3ZReWo0Y01DMnFESzUwNTlEV0xk?=
 =?utf-8?B?OE5EdHNZK0M0a21oZHdEdGo2SS9SZFJ4RjJJRjNSTHI4aFJmdXFjQU11eWJZ?=
 =?utf-8?B?U0xnS3VWUXhXR2tQandrSjVneTU3SC9HS3JsWXZEZ0x3M1V4dC96OU1uSmYz?=
 =?utf-8?B?Rlgvc3ovdTUrOTFpMlBmT2xLOEIveEs0NzNSTWhWNHgzeEcrOGtLSHUrYU1N?=
 =?utf-8?B?ZGhQNWhSVSt3Y0tYZkVwbXFYL3lzQUI4aU0yTk1MNkpiSlBSclk4am45ZVpw?=
 =?utf-8?B?Wi9hdVNxQTBXM0NRNDd2WURQZDBPYWFTSmVEZmhVSVN3VHZleERYcitUZjFH?=
 =?utf-8?B?ZzNhVXlrNUhkUWUwZVVrZGVrZXh2SG5Hb1lyZWM3OFF1cW9jWGIyUExxeWg5?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F4CD2DB8A40214480CC24D3B7C0EA24@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Go7z8LRbKIef/+IV2EIbJNXMuIaN+e+fdEWa1ef/Z30Eix5803hZAKFv/7SgEbcM9VCOvgOO2n6M0/xL5lF7zkXQHQuvife9P34s7xm1rAWEeZBSmZrVD0dWN/VVOpztnQjuuMvSYMZJKx/unrgeAa7qWKJ2Av2c6sFWgPHgY9ssmMyN78cAN3t2j/SJIl8dK1YemPKuauxp+cDPqITxp/4laUg+cHZabKClhI02SWa0XGctb4GAlmX6bymICPPEEy3FLdyf2LiaaVHJKW+or3dVD27Of6fcv7TrLAbkoaLGj9FIv3xcXSiFaBYJBFyC9PmE6JgtsdKsQ/ArNr6HCQ6ulce21jpvwkfNChV/Dj612utjbSI8igZOW3LYT+OKlmo1UC7hApqYdDicDtOlBmpQ1pez86DCx4PM/OGy/vkNqZn1rLAlaVB8WaAGQO5KIYVncv/MmoUZ69vs4FE+j4ARl9y/3QkMiL6TfsjwuM3QXL6lupFhC2iXPW3TZ/Y5T8Q/OLSFrAA6SN9ueKxrb8ZKT5RuogbVv1l5TK2NXQqyrv3DL7kHd0UmCurHTCuZpzwA3nIZO2lqyToRF4gziDcWqFBd1eWDvI0ayHQgWnseulzPNlbx20FvW1Qy3Vl2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5fe410-3fd8-4d3e-f322-08ddb3d48450
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:39:09.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1552fH/Kkd8Z3VM8pLFNZ9oJgCDLCKnN1t3K2X0foJ5KhHw4pGJs3jwE+IsZpSHFUEUwXfBV7ipO0XTkdJfPLF36oYu/09KAQjDpS5reag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9132

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

