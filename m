Return-Path: <linux-btrfs+bounces-11594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C66A3C58D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 17:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E36167DFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85A214202;
	Wed, 19 Feb 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qxwlukyv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UZCc+6Me"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C4213E8E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984287; cv=fail; b=Vb7O3HWb4/Mfm59puqc4UN7LXx3lrSsVG3ChbbNU8mbusMVq+j5CwXWXiaItBsZN69P0+MvK4sroRH7ch4kLKNfBZJBnbHNFlops0friFT+Z6F6uFBJJK8aNoq/safpJd6YDh0sW/alzw1wsH3dCNznjlnKhaPvw6QROoIgtEx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984287; c=relaxed/simple;
	bh=fL+g2C/wARsjbaHpBvrP+haiIOSNJvb8lUxzFPAXal4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bTQSKjA7IZSjG97x9NNcxO/T5WmfcP5jTlIklXtepC/qPK0LqN6TYBucPmRsrTX5AmbwbGqB/ekHAZWcZoaGLqeevUXpwgVqvqnAZ4ZfZxQEttLQCmkqjFtdHlTMXpYlA4Dxp8a3JXu+ZHYOIbINFNVAvuQPZZEjIpwpMGU0gxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qxwlukyv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UZCc+6Me; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739984285; x=1771520285;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=fL+g2C/wARsjbaHpBvrP+haiIOSNJvb8lUxzFPAXal4=;
  b=qxwlukyvipXMqX6j7JRGBZ+S/Y7Kcg6GaELtCJ+BXjzjBEi8fuInDCzu
   8LSUYhgeGuhnljpD6DeHoxdcAEoHkmPDyZ8IxA+J0/Cd4Vbv8GGxqusqf
   aTUsGBwLMpXOu35K4kDAsyuTZWp4uE0nLg+u/KrutXOvGCxwkc/F4GBxf
   snQbtr5hzI7fONQ8iM5QDzhcwMlJMr+8FvxvQl4w4XIkV1M2hCf46vnQy
   yPexUCZ89VaCBK4kaRP1RojlRRvhoi5aMhZcpsAw6RHFJuaY8myvhk39K
   6WFWa1lFBc4tDhtCkrGbiQJ6mXb9UzvNIp3ohQVYOOPsyKclGg6fVLlV9
   Q==;
X-CSE-ConnectionGUID: FdUv++rTRAKwJWxrzuY0Lw==
X-CSE-MsgGUID: fwCfI8bjRXeJ6iw4VJ9Nzw==
X-IronPort-AV: E=Sophos;i="6.13,299,1732550400"; 
   d="scan'208";a="39907877"
Received: from mail-sn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2025 00:58:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIP7ze/OsKVXdJvSO8PLIYS6zrtmfSJtHltfY9PgaUu/33+6XaRHKWhP3PmgGcGW1Ds7PIYIfUXkgQBlGkPL1NtCrjgX+wBN1X+5HXHMGsdhdNiha89u9lyX5HtkIXVAJunszemYbq5efSsfsfvRYKjGEl761cEbdbkC5uPP07ScNcbo8Fkw1l4nvbd4l5SfXgup5RwJ6q6s+Tr4/wiZIadeGVZvO6zHZpbjU44J12pcT+3czw2kwFNvN+ECnftWAYZ84pOI6X31A4xLMoFF2TQtzZAdwtJY/xArxP/3UWoTmeeu2RKHcz/zfaFavAXz9eqYX2T63XFWL7d2PQqgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL+g2C/wARsjbaHpBvrP+haiIOSNJvb8lUxzFPAXal4=;
 b=ZoF9zDFXKn0rCN0+uolzgAMe/DHG+mSPJuIlTKhjjCa0gBgD/K3Z6zvgaobJF0t7a739pn95vaxJyy3SjORtl+86iKbLKUyvl5F1v+IReQ1rVIItm4rfhcSNX+6MEkpHfPE7LOtPePNZuovoOKhg7Nklzmv0z2hKxW3fJRz86RDF46VNlh7XDcQZMo+QTFkzHTv55bZ0R6wUgnnWkU7IpMj5CYJzXjLYCSSNkNdgNnKpKSjMAtKJ4vMbJkg5Nuh58mDiwcxZ6ivbzQEBsZfj2O9m9t0Fn/8CCoiEoODQAjMbb0tLOvR9AvIBMDBbYO7wUFqHEsjX5M2M8Q4XpF4Kgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL+g2C/wARsjbaHpBvrP+haiIOSNJvb8lUxzFPAXal4=;
 b=UZCc+6Me2ev7itMzR104ZIeO7eNldZc4n+k/psrdBHFhS4KCQIgkFqp13g1JhmUL4rZ3aY4O8Olh3ZNmyrGAQwkj2MykQdO2NjMmp3wOoIXi32aydZMT10mCLrEgnhWw7qNihajeo8UAOu7M+7toknMkRzMdmVLUUq6N9RO1ZlQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8372.namprd04.prod.outlook.com (2603:10b6:510:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:58:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 16:58:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 12/12] btrfs-progs: zoned: fix alloc_offset calculation
 for partly conventional block groups
Thread-Topic: [PATCH v2 12/12] btrfs-progs: zoned: fix alloc_offset
 calculation for partly conventional block groups
Thread-Index: AQHbgqRQiniXQz0kKkuR4xYDYFusobNO2ZWA
Date: Wed, 19 Feb 2025 16:58:02 +0000
Message-ID: <64e99dfc-e2d3-45a4-9216-ff9cd8aa7d7a@wdc.com>
References: <cover.1739951758.git.naohiro.aota@wdc.com>
 <c6a9d1c664cf8595ac6a2a8acf458cf46c7cce8d.1739951758.git.naohiro.aota@wdc.com>
In-Reply-To:
 <c6a9d1c664cf8595ac6a2a8acf458cf46c7cce8d.1739951758.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8372:EE_
x-ms-office365-filtering-correlation-id: f81e9f0e-3960-4ac2-a5bc-08dd5106924e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkVIcTZtdCtpZzIrVlNpdU9xa0kyU2hpT2taeVdHZFMwVmpMSSs4alNTZ28z?=
 =?utf-8?B?eWs0VjF5S0owTGMwN2tSQ1VwcFdna3NMZUdEZThOY1BLc1Z4amNucmZoR3Qz?=
 =?utf-8?B?c1E4VXhzMUVSamtvRVA0QjhXV0JteXBsQlpiK2dVaVZrdzRKWFZsWEp1bmlq?=
 =?utf-8?B?SGRCMVZrRXhrSlNBODVlaUtlNjBwZG95T1dJN0VQMG9rWFMzd1lqVW5oejdn?=
 =?utf-8?B?NFo2a21xdHBOQzcrUVp5YWRJaUdPN1hFY1ZuWmw4U1Q3TXZPVFgranhib2Qw?=
 =?utf-8?B?TTB1RlZLQURuNE01d3V4T1lUenlqeG82MmZFMU1KNXpyZlAwbHZhQ0FDVFU0?=
 =?utf-8?B?bmVLaWY5QnZNdE1CMkhjcThPd203MXZGK05YR1RkVm9QcTZ5SWl4U0gxSkd4?=
 =?utf-8?B?eVdkT0dSWFdTWG9IS2tsdFdDOS9pOS9UL1d1UmFmVTRCK1kvYjNHdXVvOHRL?=
 =?utf-8?B?T3B3dzRtVGkyWUYwS0VWb0VyNlBMU2NHS3JZNUZTMzcyWlhPdkRzN2g1ZEVT?=
 =?utf-8?B?R2JQc0xNM3I3NUVpcHEzRmlmUzVuaUM4bkZiOUxwWTVtdERKYUdHenZnSHI3?=
 =?utf-8?B?a3dkZzd6VkY1K3k0WlNOY3lFdUpCSE9Dbm42UUczT050OEVCdFJCY0tZSDRz?=
 =?utf-8?B?MWJUb1RTL3A5Rm8yemlpaENETTZ1R2FXRlNUV1dGWnJvZXNhaXFSTDE3Mmwr?=
 =?utf-8?B?WWVkUmRPU3o5K1p5SXBUcURKWkp1bzl1SVlMM0Z0Z2RqTW1HcFJQNGwySlVR?=
 =?utf-8?B?V2ZIVnVuTGVIU2wwM09mUGZWSGtJN0ppeVBDL1dlWHNUZGIydHhHNGw5MkNi?=
 =?utf-8?B?bHZEUFo1L05ZMzZkY1BOY3FUNmxQcU5NanBRaldxMHpISjE1ZnpkVzVQYjk3?=
 =?utf-8?B?MWQrTldoVG1Yd2dwT01iZjgrWEoxWTZleEpncmpPYTlFeklrS1EwcjZsajdn?=
 =?utf-8?B?c0Q1U2VwR2xRSldYUFJ3cXQ3aTdTNmYyTnFkdVRsSlJ4T21odnVVYU8wTk9R?=
 =?utf-8?B?UmtqcTF5Z0ZNSXc0QWNHblNFd3hSVkFEZzNNYmRkWWhMcWpSOXZYSmtrWXox?=
 =?utf-8?B?b0srV0hFZExIYnphdXcwS1JJOXVjT0dNamVjR2N3V282a2EzQ3lVVzVJQVVz?=
 =?utf-8?B?QUMxMkdsY1h4TURicHVENkMzaTBuVUZNcGVaclYrU1crWlZidzZGY0hwNFBz?=
 =?utf-8?B?YlRIZG1yRVR2Q1FVRndIdldpS0g4ZmlRWVhJNjhQamdGK1J0ZDlROHRIbXhU?=
 =?utf-8?B?dCsvY3lpQzBWUzQ4Ui9jellWZVVDdi9SNElaVEQxNDE0WXlnTWdQaVRteGNk?=
 =?utf-8?B?L1M0K3VDb2FSMytFNDNJSytLa1QxcVR3WW9hQ1NkRVZmR3ZPVTByZnNWdi93?=
 =?utf-8?B?bWxFeDVtT0lqSnFvaWc4STlycG9qR1lMWDZmRlgwdUlsSyt0bFlZY3ZNZnZp?=
 =?utf-8?B?OXlHb0g2ZHJyVFhBT1dyNnZtZjRCVXY2VmFVRk9LY04wdndNRnpBc2ZWbGdL?=
 =?utf-8?B?b3B1aGpwVkswOWZBZnduWHlWcmpKeVBCaGNpQ2FyYVloanNJcmh5NmViOGtW?=
 =?utf-8?B?bkt5cjZHRzhoRGs2VmsvS3paNFNOM0Rya1p4Mm8zWmNVYUU5WDBiQWtlM0NW?=
 =?utf-8?B?WjJmU2o2bjhLZ2g5MFl1UDg4Q2YxckpvYlU0VnRCcU82a2NGQmc5ZC9QN2pz?=
 =?utf-8?B?WllZZ21iRm5saWtldlp3RW1ZMzBLUkZRYTBnZEsrcVFCa3hzRXI3VG1mZzNT?=
 =?utf-8?B?MXA1eVFWZ2hHd3FhWVJ1ZkR0c3pkZXFySE1RT0VHUmRGZnpVVmpUbDJxdVdl?=
 =?utf-8?B?aUFiWlAzS0tjOGEwcHl2MmozYmtlZ2VURjhCYml2WHNSZExzd2NrOG5qZkpJ?=
 =?utf-8?B?RERteVRjUzBUYmRUdlhERDB1RTV3Z2JGMng3WDRaYllZWUFzLzVKcmVFZmVB?=
 =?utf-8?Q?4CRK+yB28Ppj+v9We3ZXJLU9G0MlZ0DW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTgyZjNGMDNaL0dpNFJkRGVsdUs3aS80R0IxZnV1MWE5VENJbjYvUFQyNmZR?=
 =?utf-8?B?MjhrbEs2UEQxcWVzSStZblc3Qi92RzlXcFVCL3pWMDJVTEgrSXpZY2srSllr?=
 =?utf-8?B?RDdEM2d4OVJPOUpScGJlY2oxZ1cwRW1RaW4wb0p0ZU9LeWN2NGZabEFCR2x5?=
 =?utf-8?B?enlWa2g0M0ZSR1JSbnV3eGdYWHJXNWNEUnlRTkcxcUQ0RFU1bzdheU0wUFJx?=
 =?utf-8?B?cmFCbHdOZVJFWXhnc0FCdUtwTmh3VDFsbDFPZktyWGpCUDBXZFpSOFlwT3hK?=
 =?utf-8?B?QmpKUXVNZDlmNVVlRnA3YzJ0NnlwaDhvb1BKZUZocFdYMEo4K3I1V2d3NjRr?=
 =?utf-8?B?ZnlQbWczQUZJc2VOK3RTUjhOeDFDaGFKeGRORHJnQ282WWdKaWkxMTZHWlFw?=
 =?utf-8?B?clJ6N2RwVXlCQnpXYnA5SXBYMG1DaUo2dFV1VExxUzJ6UXBSbDBiYVFZYnk0?=
 =?utf-8?B?WUdvSDRlZkZiYTMyNjlHWDVoUisvUGVBbVdmQ3gwY1Z1TWNzM2pFWGhLU2Fl?=
 =?utf-8?B?N0lpRXUvcUxHbTBQVi9VY3phREUrVFVGWXF0TGc3QnRvdlpkVHU3QTdaTk93?=
 =?utf-8?B?d1U5Wkxyb2M1TU9SQzVIR1hpVU1LdHd3T1l4SmgrS3ByRHNtdk45aXQzRkhz?=
 =?utf-8?B?eG01UFVYaFpRcVZLUVBhYmRVR28zWGNmbVl2OHRnSnliQVJJVC9lMnF1QS9Z?=
 =?utf-8?B?cm9QUEtNUDc0cXNSVTUxeEp1WFczakc2bnRyZ3dsRTRhYktDd0NZNW5XOGYv?=
 =?utf-8?B?a2pNQ2lsQitJUmxzcUxRdFd4Sll1M3N3K04yUEsyVmFHZXdCemRyalFhRXlu?=
 =?utf-8?B?SHlrU3hyVEtta3FGVVNoQXl2OUhJYUtTUm5kOU16c0Z6REJXUFFSWE56dXdw?=
 =?utf-8?B?WVhhVkdvVWpJdUpTVnlteWJQY285STg0MmlxdEVpd1FscnM4bHVKM1FSRUkw?=
 =?utf-8?B?QUJNaXlTdjhlMXhHNnNwY3N1R2JIck05TWNCWUF3ZkgxeVB0NlphM3VxdXlt?=
 =?utf-8?B?Qi8yZ2JaY2hQRUVNM0J2TUIxTEVhYTJxRGFQbndNQmMyYVZ2b3lyZFZucElS?=
 =?utf-8?B?eWxURnJrR3U2M0huNlcyazZMYytGZ3F0QTJsQTBQSStaM0VTd3A3Y1A2VTdz?=
 =?utf-8?B?SHVLaUhENXlvSGZxZnlZRHF1aGkyUG16UWhSMUM3d2lDbmwyTXlmVFlYNkFt?=
 =?utf-8?B?WEZCeXBRb2pqTFN2WGp2UUlTRVpTU3R4WVh5YkxjaXpuZTJwdCtvb2Ewb0gx?=
 =?utf-8?B?WXlhSXhwdVFXcVhyQmhORklnK2ZJckFYUkY4YjI1VWRCKzR4ODRjdXQ2L21O?=
 =?utf-8?B?dVEza2dIaHZpOGo5RXdIQSs3cWx2Mm54eUlLY2l0WE45b0hRckR3cjBhODNj?=
 =?utf-8?B?NzR2a1JzM2d2VzdQSjQvRmN2ZXU4OStwWUlPaEt3bEdkL0JwNjVXeTVqbWRm?=
 =?utf-8?B?YnBlbkh5eTZNNnBrWnlQQ3pRL0hJSDIvZ291YnJqUktIU0RBK3hQL3ByTGJB?=
 =?utf-8?B?NUhBTzVWN1BwSHFkd1hwVnExWldUUTBqTjg1ZHdYKzZzVkxDalhQT2FOQjB2?=
 =?utf-8?B?WmFYN3NyM1l2SG5QUEx5Sk9DVXM0V2FCMDVHR1ZJZGMweUlmak1TZVo0ZVNa?=
 =?utf-8?B?dTFjQnJUcTcvczVsbGJ4ZXU0NnNBME1iNG50bGdRTmtUZ1NQa2ZjcjUxWXo4?=
 =?utf-8?B?N3V4WmkzbFowaHN6RGVwSjVxL3AxODRKNmZwZFhoZWNNSDM1ajY5bDVLNWlu?=
 =?utf-8?B?ay9YSlh1U2V4SU5WUEk0V3g3dDBDbDRXa2Qra2ZWSk5EU3VmMFlHUm9TOTlZ?=
 =?utf-8?B?RnlOSXpNNk5NUTlDMUU4NnhoNjU0VHpSNDg5Zmt2RllNOGI3MG1xSmtHOFRK?=
 =?utf-8?B?SHE5Q3pwakE2VTdDNjB0YjZBNGJlbjJ1SFZNL3Fld2xOYk5lclMzMFRnUDRo?=
 =?utf-8?B?MTJEUE1sWFRabm13LzZsSnRZQkh0Y3hBK3N5aU83MW5HaGxMenNNZk8zNkxz?=
 =?utf-8?B?a1JHRnU4OGsxL21JYlJoa1RZYm1KdzZHUWx6R2t4VktOOWR4T1ZzUytvN296?=
 =?utf-8?B?WEpFa214OG9uUzRtbko0d092c1phWm40b2V1Zk9hNnNDNllkMXdKdWM1TnJp?=
 =?utf-8?B?Q3dyMzBhSTNPL1pQNEJlUFkyWnBFT1dLRDkrV080WDBUT21hZmtMZFlJRDdy?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <359B2339138034438121FF671ABE6880@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a0Ab9gA3NgKVtWCOqqZlCsal8LKx339bc5ZCIWwKmgVi0iXLbIyzk3PRVsV/I7vhZh/JBEq95VSOu1LLwNBLqLeIU0Jre3SoAfz/xpqDQYpel2iZTiYkhYRdJXlVsNeIItxthdexoiXm6zJvd8bktY0gkZWjgrabHMsN5iwHJOlLpgna30uEZoZKOGuZQGmGofLngF4X6LYGPwDn4njZ/3RZlZNNmuG7QcMwj1yL6xLoForbLBECWmUueN89E9NVA3T5H88Cn8Xsd3z2ZsmDSVtaxxibeRXCo+PZrpW5eqX97i4FOJNGuYEKiKthN3A/PwomRSH1YyOKODXNVNj/kG5WjuZQleLwHVMjWtn02HCz5TZJoFNAiQVG2IrY34B2MmPWEM/QV1oGtbpVpAnE9i3stJta3NiOQ3QuaGCv7Vw8lt626rBIkbE1X9Gr4QnC60rNYB/ED4MUHBQ33fL9cAN8kC/WOqaxfiQZc2ZVIJVo7lzStOHSFIXNftYju3f0XVDtl9m8bvpHA/YH3MLGoLNUmDCyTagrgP8eNYixlDU9eB7LmALK04znGJFekelQyTZrgpVWt0LeVf73v4e+7+C932kUl02bg5BCk6l97KfgnPCphJyxeubuGruXdC0/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81e9f0e-3960-4ac2-a5bc-08dd5106924e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 16:58:02.2140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uh4wLDAG8/ainaiN6HodzTeHupY1eb4Vf2nvpR9l1LWG97Uu9Wi9PdBTgAKh5BOozGm0I+UheejdYzzMfwRT7x8bpyhDCCSM8UgyRrD/xnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8372

T24gMTkuMDIuMjUgMDk6MDAsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gV2hlbiBvbmUgb2YgdHdv
IHpvbmVzIGNvbXBvc2luZyBhIERVUCBibG9jayBncm91cCBpcyBhIGNvbnZlbnRpb25hbCB6b25l
LCB3ZQ0KPiBoYXZlIHRoZSB6b25lX2luZm9baV0tPmFsbG9jX29mZnNldCA9IFdQX0NPTlZFTlRJ
T05BTC4gVGhhdCB3aWxsLCBvZiBjb3Vyc2UsDQo+IG5vdCBtYXRjaCB0aGUgd3JpdGUgcG9pbnRl
ciBvZiB0aGUgb3RoZXIgem9uZSwgYW5kIGZhaWxzIHRoYXQgYmxvY2sgZ3JvdXAuDQo+IA0KPiBU
aGlzIGNvbW1pdCBzb2x2ZXMgdGhhdCBpc3N1ZSBieSBwcm9wZXJseSByZWNvdmVyaW5nIHRoZSBl
bXVsYXRlZCB3cml0ZSBwb2ludGVyDQo+IGZyb20gdGhlIGxhc3QgYWxsb2NhdGVkIGV4dGVudC4g
VGhlIG9mZnNldCBmb3IgdGhlIFNJTkdMRSwgRFVQLCBhbmQgUkFJRDEgYXJlDQo+IHN0cmFpZ2h0
LWZvcndhcmQ6IGl0IGlzIHNhbWUgYXMgdGhlIGVuZCBvZiBsYXN0IGFsbG9jYXRlZCBleHRlbnQu
IFRoZSBSQUlEMCBhbmQNCj4gUkFJRDEwIGFyZSBhIGJpdCB0cmlja3kgdGhhdCB3ZSBuZWVkIHRv
IGRvIHRoZSBtYXRoIG9mIHN0cmlwaW5nLg0KDQpJIHdvbmRlciBpZiB3ZSBuZWVkIHRoaXMgcGF0
Y2ggb24gdGhlIGtlcm5lbCBzaWRlIGFzIHdlbGwuIENhbiBoYXBwZW4gDQp0aGVyZSB0b28uDQo=

