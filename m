Return-Path: <linux-btrfs+bounces-16848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47D0B58E9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 08:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57DC7A1D42
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B792D7DF2;
	Tue, 16 Sep 2025 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H+qcTM34";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ccBokCeK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5028C864
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005316; cv=fail; b=ZQuGLYXdGInnne0HXE+WByUfiWJUhepa/NUoMRkupvV8pmBylMFEe4QQBm8ZZR4q5uk/9iXhkifeh7ux1z/MIhJp7KAebMwNhIku6axlR5HdQS8rv9sizoTLntE0myD4LeNCxeLjdKghcIQeuFqZGSfZ5k9g4/ip7LfATI/+tDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005316; c=relaxed/simple;
	bh=7MsTZqxtDuBMomayjBRMerisFOgw4sDoBJdlrnh/Bvg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GU9hRkWsVLBxD8klCrR2TD0XVdx50byAC41KuEzraMLnPeMh/FTsJgrMJF6QOcIXTrPS5jTlJ+RSBHrPxKlFnbX1EAzLOleJgBrANwHuMJyKsmTjar+rDIYl4+p6ZW4UMJslpIxuq4PlaGxhnQvBaP9QHhkCL6xD0/4ADl9u4Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H+qcTM34; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ccBokCeK; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758005316; x=1789541316;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=7MsTZqxtDuBMomayjBRMerisFOgw4sDoBJdlrnh/Bvg=;
  b=H+qcTM344HZbX+GJWiWCZ1HE733w21PVHlR+G+yF7YA1eXlV2FD5BMRU
   iDbIu/+VPGoukXgp5AU8sATLFdwAnOkJ0KGoPzCKJmP7P4IEG9R9vdmm3
   SDgebJaQVTR3UGY+C2u+BRSZWEp9HWNMjdlbVTAMq4u9b2EtNT9454sKU
   5SsehSBg7EFRXE3OY8DuUOMwn0qDyt7iw1R12mdiWDvkIxZGl0sZmnj/t
   SUI02WpqDTC/OxN7w2PpJ7bkAA84rKOv5xqXXL0gFLnuaV/2yR1qA4C0o
   h+31iebLZuCchhSiX7uMnwK4o4JrIQw3RrYM9V0gQI8GfGjPN71MFtIa+
   g==;
X-CSE-ConnectionGUID: LgL+GPqBTd6rv4rWV4Ghwg==
X-CSE-MsgGUID: y9jIixgpTIGw3tjgIHRLaQ==
X-IronPort-AV: E=Sophos;i="6.18,268,1751212800"; 
   d="scan'208";a="122206048"
Received: from mail-westus3azon11010061.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.61])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2025 14:48:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mP9h0lQxISPNjs7eNxUGBYxTpswhty3zGZP7yhFfBR6/kKKqtg6Wv5oqf6Jbr36bcEk6nZQu2wCakuCVo1PdaVL86veg7wQHHPCCd8IMDCDQj8zFb9CCgKEF8kgXa1zb9RJpZOeM9zFx0GsIhENaoGS0Y/iLtB6jOkG8eHsm2fLYSOrFB9c1icmzv3B7tCmE+Ouaa0onqCTFbNPYVJHaHmu6dMRJQ67bfg8BNfORWVSCyEJs8u5cYeIPFydrVP65vOUWXMqCytb2di24ClQgIRfYT7RKAcXNGGuOUv4ZWE8O8/RpsVelYTxV0kDNsjaUJ3lx9DSLwLHZp5Dtc3hKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MsTZqxtDuBMomayjBRMerisFOgw4sDoBJdlrnh/Bvg=;
 b=OL2RF1s+EljIpYaNR1+cUe2IhkMg0ldT8Yw2IewJBi0h9m9Er29WAtc/T0aZsokoszOYCgD1UhF0eS1JsGYkyTBEvdDkvAmJ0NGltNwkZQmUdyuI3HIAs3py7PBMmjkUllyqBypy+c+GQiO1DWVmuIxt1XFg7CKJj9isO1//arZnUyvHXAswvBNCNZH5aC9Kv9sc6iqePVyXCwCIgyvjcGDQsnVeuALQNW4A9LFErA9qZQfybo2OnhvhZN87mys+thMKNkW7GqGCenrQ7WhgPgnZ7PDuG7OiJesM3+x+yxET0DQ0ZmqaNJwvt0HrE8fvaIQEKVWDGV38REyq6FXQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MsTZqxtDuBMomayjBRMerisFOgw4sDoBJdlrnh/Bvg=;
 b=ccBokCeKVfaedNT84DSYCA2gLm70LRpxvhQoddXJM7Cdr5u+YqgRsoKzCvB+yohHHeKUBNEAQnsY4RIx5ufaQ251bhhtgJP29d3oT7vYsElJurW4QpNa1g75UFNKYp05TFWyp5OlQTgYDI/B+Q2QcnoWRcZIZlmyP6rZCF0VdUI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8171.namprd04.prod.outlook.com (2603:10b6:208:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Tue, 16 Sep
 2025 06:48:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 06:48:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: tree-checker: fix the incorrect inode ref size
 check
Thread-Topic: [PATCH] btrfs: tree-checker: fix the incorrect inode ref size
 check
Thread-Index: AQHcJo+L38AIfzTABkKRMmdR2XuGp7SVXq2A
Date: Tue, 16 Sep 2025 06:48:26 +0000
Message-ID: <a5de779f-e62a-4fa2-9aae-167d312f17bc@wdc.com>
References:
 <b01a9d93d21d7be986b45b84baffc3237e5ec3e5.1757975029.git.wqu@suse.com>
In-Reply-To:
 <b01a9d93d21d7be986b45b84baffc3237e5ec3e5.1757975029.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8171:EE_
x-ms-office365-filtering-correlation-id: 3f22f9a1-42fc-48fa-7e57-08ddf4ed0986
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qmd1L2JxOGJ4RGIybmxtUTByM3V3b3ptcmE4aGRGd1V0bk5uVVQ0ZHFXbzhE?=
 =?utf-8?B?ZjM2UTNBS2JCMWhFclVxaFpKbkN3dVM3OWJNNTBiOFArcjkvL1ZYd0N4Mk9V?=
 =?utf-8?B?aStaWXVkdWxCQ2xPS01SbWp5OXF5MzN1clhaOVFvU0xpeldQVUNHYjFjbis3?=
 =?utf-8?B?SzgyZys1Tks1YW41S24yT1BIalNxeUdLeFo0Q1hZdUkwVldhYUpwZmxvRG5Y?=
 =?utf-8?B?RXlCcVdZR2Mwdlk4SDJ5SWNXbHpPeURtWjMrVFNHUEkvMEl2MmFLK0ZRdE9U?=
 =?utf-8?B?RzVpMkdZZHdsbHZxUXlOUUkwNDRVMlY4azJiUXBiUlNIc3VjMTJJY2JtS3Z5?=
 =?utf-8?B?VW5vekJrWE1zOGNLQWw1Yk9RUzNPU0hSZ1dxVFlHLzBUMnArTmdncXkvWVRB?=
 =?utf-8?B?Qm5KRFRHeEdPdWdiZFdsTHdMM204ZnBtdXFyeWd4SzJPUGl4RmdKU0p5OGhh?=
 =?utf-8?B?amZJQ0RCMmI1Y3NQZUxLZTVDSlpvcnB0ZG52ZmtqRVFmdk9BZDhobnV6bCs0?=
 =?utf-8?B?QVY1TGczTndKcEJhdmVra2pTNTR5cXVYL0hodDk4NEFjVCtCS09WUzYwUzVU?=
 =?utf-8?B?MDJiOFg0UDRoWHJRb0NGZXRRWndURDVMMDIrMldZejljM2thdG5BcE54a2Rx?=
 =?utf-8?B?YlgySnFOVEpmU0VHNzNRbDJId3JZa2l3ZU5TMmdLeXkyQmJkY21tZUlZSjRu?=
 =?utf-8?B?RXBzb1JITGdxeWkxTXUwRlY2OVQ3QmVhOVJtUXQ5aHZNWXRYWnpUS2dtZEFE?=
 =?utf-8?B?S2d3MEE2ZW0xbWZSZXhuMmpZVzdrejllT3ZKRVliYk5NTE4yaldvcm9NcVEy?=
 =?utf-8?B?OWRhNzAzUFMvUTRtVFMrbGROMVkwNEc5T29IU05ET2UrRVFCRTdIKzdVcUc3?=
 =?utf-8?B?cW01ZzBXR2V0YVpxVVlQcEVlZUNTeXdTcDRSbTRCZkhZT3NWVDhGV0hGNG5U?=
 =?utf-8?B?cVhqWEJUdkNDbCt0QVlBUEtlY0k0YWxrVVlZRUNydjlYVTczSVRvd0lTa0pX?=
 =?utf-8?B?VUZJdDYyV0FQc3ZlNndHaWFTaHluVkdyUytFU1llai91V1hYSWtPWTZ6Z0x2?=
 =?utf-8?B?a29QRU1OK09tRmNEVlBJZ2pDeGpPRjBqcmx2K2N4ZTNmMjNIWmpSeWt4WXdI?=
 =?utf-8?B?U1F1L085OFJTNGsyeWRaU08wTDRFTnR6RjNIN04xeDF3V1I4dytxcW1ZZ2N2?=
 =?utf-8?B?a3RzZ3hZOVZHazhHWS82Z0ZteTBWUUZPb2hFR2UrYVYwdmVWQkJsRFlXTzgw?=
 =?utf-8?B?OHpVN0ZuMmJnVThvdHM1ZS9YYnBqcW5MNEF4Z2VOTjhJd1g1V0ZXWm5TUTBl?=
 =?utf-8?B?ejBZWm56R3Fja1NLUDdFY1lCZ3Q2M3JRSUsyNGdWdG1VRk16NGQwL2lmUGpi?=
 =?utf-8?B?TFFjT3RXOFJ2SkorZmlDNnlpQ2ExcVhJY1oxR0hXZHdQTVRYczNKVDRVOUZU?=
 =?utf-8?B?MVh1ZERJRnB0MzlGMGlhWG1wc05LWnRFV05jZWM4a05yWUg1R3pjcE9rYWNM?=
 =?utf-8?B?YjZlQ0Q2VVM5R2x1RTg0VGpFVERJUGptdU43aTN3ZEFDczZ2bWlkMk5yMytD?=
 =?utf-8?B?SjZaRVJTSlVwMElEejd0RjhoTWJhV1hYVTJsWEtsdVNxV0RYK0NKU1p1LzlF?=
 =?utf-8?B?VWk3YTdqL2MrWTJENVkzSGljY0hHcFdScDA1Um9oVVg1UlZ6VTVkcDF1MExM?=
 =?utf-8?B?RUFrbER5Q1FNc3Zqb0xXRW5SRlJ0ZzYwYkpSUFRRTkEzNVBnaWZla2dqZkZM?=
 =?utf-8?B?eExaTXpKUVowZ3V3bjRBaVpSTlZJaENpd21uWXFQWUQyM05GQjRPRmQzMm1t?=
 =?utf-8?B?SGRsL3FBd2xERHc1REc0d0grOTcvNXN3MkVEaDFpKzF4dzZmMnpXa0hpZ1RO?=
 =?utf-8?B?M3BHMWw4UDVYRE9hNlpPVzYxcWpRQ2ZtRitXNE5jYldkVm9ONzRIS0MvUnJo?=
 =?utf-8?B?N0x3anR0cDE0bFM2WTVFRlNPOFZRTnhBVWh1YThqWndTaU9uRlBvLzZKUWdR?=
 =?utf-8?Q?vnZSUcyMqlCvjeclA8hpE4rGPXbD7E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnFaTnlRR2RJUlNiem81cXBER2Fscm95MElnbXdkYmVPbXIzUEdUNTZNL2pv?=
 =?utf-8?B?bmd0NjFsNG9sVzVVZmphMzNqSUFwdmpYdnY1bUUrNHVQNktoVWR2TlVMSW5h?=
 =?utf-8?B?ck1FYnZzSlZ4Q1NZMzRNSWs1aFhEK3JycHh4Yy9wc09UdGpBM3BEVXVJTnlB?=
 =?utf-8?B?NU5Fd3lHMXdlZ1NkRzB4RGQ0ZWlzaWpuc2tSRHo4aWZnTExuL1hXY21RZkxJ?=
 =?utf-8?B?a2R4NGVzYU5CVGdVNDZKREVKZ09IZ1dGbGF0eGxZS2JST2NqejdRL2oxdHZx?=
 =?utf-8?B?Ym5yZlNBTHM3RmZYckg5MFl1MTVxdVovQzkvWEc3UHJ1bWRlUXRYTVRmWGow?=
 =?utf-8?B?V0w5VE1EbUdjZkpGeFY0MTY4dS94cEVmZklVMGF4VzZYZjNMVWlwcnB2Njh6?=
 =?utf-8?B?TlhUUkZ1OU92d085QlNhaEk2VjN2Uk0xTmVuSUtOR2JUR3l5M3BDVGVXK1Iz?=
 =?utf-8?B?SFFxbkJwQitNaEl3UUJqdUo2NFlNU0s0Q1kvUVdRY1JDSDJVQmNqM3hUUlB3?=
 =?utf-8?B?ajJKbHpBVWk2TWlwSG9uSEk3VHpVNWhSY1d3UUZCV0lMcHRHOCtLYW9wTHZa?=
 =?utf-8?B?TCtNWmNjbVY5TmRtcUF5MStmSzYxQ1NPWkJvT1FoSHRzUmxsU1ZTNmtkeUFj?=
 =?utf-8?B?ZGdvUHc3c0I5WEZ3TW5BREgwYjFJc1FxZmVmMmtjMWNRNEJXa2pwNVIxcU9S?=
 =?utf-8?B?VktQOGlHRTZ5NXFZbnZXU25IYVNjSVdOalc3WTlUQTU4eWtDcHhlSkhnU211?=
 =?utf-8?B?NlB4MDBacHc4OHBrT0RYaGdqVWdMVFNacVVWTTVPamVIVlVqS2FyVmpiQkxz?=
 =?utf-8?B?NnNTU05UUisxekhuYUJUUG1NZzB2cU9XN1ZDSVVlMmZFdEhLYVBNMlZsVEpP?=
 =?utf-8?B?TnZTYkFrNUp4QnZ4OGh3aDdHTUxRemlLR2R0Q3ptbktIN284YktKeVRmZ0ZO?=
 =?utf-8?B?bkZlR0VyRFlMK1g3elJYdjBock50UUJrK2VuMkZETm1OdkhFL0ZaSGp3YW0x?=
 =?utf-8?B?d0RKVmxlTGJqeWR1RUo1QzlmY0VwZTlqRWFDQVJhckxpclJVTjhmbGx5ekJn?=
 =?utf-8?B?d2M5WDV6K3JlL3JUa3I3bTFZUmdrVWVXcVlLbnBiSE4yV1Vuc2F0RVFJWklF?=
 =?utf-8?B?VjFoeUsrTUc4WHdHa1BTYmo5b0JGd0wvZjFWbEJRSnoySStDT1p0ZVZaa0M3?=
 =?utf-8?B?UXNTT0FFWE5ETWpjcCtCaEFMN0VTdGN1OFgrc093RHBLS1NGK25Tc2JNMTIy?=
 =?utf-8?B?TzdIZ1ExRXdaZ1BkV2JNK0RkamUzd3h0NHlhcGo3Q2RIM081M1lVSDJvVXRz?=
 =?utf-8?B?SFhSbndraDVodHZIeElKUUhTQUtBSWRpemRxK29zRHNZV0tDZ282dlo0eDUr?=
 =?utf-8?B?ZDFJMytjSXp2OHdQelRlZmpMVmZUY1I5NktVeUdUazJ0NDZSaldVblh2Z05u?=
 =?utf-8?B?ZUlZNkVuYUNyQ2ZGNVNtcFdYRjVYNERnZXBoZ0VNRzFwNnR4VzV5bEN6MzVu?=
 =?utf-8?B?YU8rSW9pQWJ1V0NNd3R2b016SEgvbU1WTUFLeHJGQzBJQ0RaOEpVQWk5aVFn?=
 =?utf-8?B?UWZBUW82TTd4ZTNZUzRqTHBtZ3QvYk5SR2pPNVA5cDhMQzdpM0tKSlF1aVpj?=
 =?utf-8?B?RWRTYTlvems2KzhpM3VEWmtrRDBtbmpKVm9SaTAvMFIwMjlFUXkyZkNENU4w?=
 =?utf-8?B?R2VhSXRNQk5qTW1aL282RkdwM09XM2Fqc29qOUw0WGphZmw2aUVxSDc0Y3ZE?=
 =?utf-8?B?Y1lmRUhnV1gwMzUveit6L3JMc1plVE0zRW9xTDllTExFdzVSQ0lUR0dZU1FM?=
 =?utf-8?B?NkNjdjg3VkQ2bXM3R1VmU0dRWDRiZndYaVY2a1ZJT0t3M1ArZGJUK0RkTlpL?=
 =?utf-8?B?TUFqcks1d1dLQXgwSUhXMWMzdWl3cEs1ZTlHZ3QzVTVwZGhoRW5VNjloOGpV?=
 =?utf-8?B?SGNsMDNmZXRuV212UkR4a3kwZjE5L1hmYlZTM3JzYU0zem5wYStBTGNqN2oz?=
 =?utf-8?B?dml0Q2NtVmhQd2xIY0RYaUJrVTdERmc4TElOdmdWUFFjVmZyeTV0VS9wMDJF?=
 =?utf-8?B?VHI1Nm04SGtjU3QxZU5DRnBYNGQrOGwvVURqY0dRelkwNTJNWnJ0UmE3aEsy?=
 =?utf-8?B?eTFIYVNoNG5JdC9vYkd1Y1BKVmhOM0NNZlNYMTI4L0p4aE1qdXJEY2Y2RWcr?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89C04A7D6E19234AB6C2FDA5FC2C1261@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LIRwFEze2Q27qf+Y2jlsC7WAJKBDGTaB6oRv55cqE2Fklimht0cU4Az7hfylAG9ZIubUeOv7PrPXVJ6xk8fsAwJXdKFEAhK3usrPqVERR3YCwds4jmLBVES9VINNis4fxJ0fE8xbMXkbsZGLA22qj9EWa9Aav9ABDdpAmX/vVXXzxllC0HDMVwnp7mETMqdYogDtXiHccarLAQRN9iAyey/EwOhlUFwBBbtZj6kK5gTmGhPHX1Pu5ZioF3TQVIGncUg7FjITaZslwblbv87dLb2mgCBfD2Z6Ht4QwBoY2/7F97P81oLWW1K10UHF0msuKy56wCMj9HK3cZHJClEqvyivnIcvLa0rJ57CYMJBvSa9XCjMfSVNvV3VRN/Y6KEeTsvyD5rASBX/DkZ+4xyjV24/BqF7Iw5U9kPWkHYC9IrzWf4770JNeYS0RQ/N5F9w6mNnUODc5ifkpyfhAh3jOtk9ZScgQIz/rzDmNGOmKDA4DarUvqoHW7lwfVpPxmMGxqgn+k4EI2hC2elIEBDb2cJUFBpOnwFeptcqsDiC9x2J/sXtQLi7GJy32OI2prVgVBPs2u10X+cH1rNOpdJT+LI+aqCbylFbjRIWv2/A80F7n143kBrC0EVLWVj4eZYy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f22f9a1-42fc-48fa-7e57-08ddf4ed0986
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 06:48:26.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJZRaB8ZkPQQSKsI8zQ4NlulAFk2qoXSbopqkTKyrb0UJK0lYY9VbhOO3gzXLLVOsfLGklpzyzrcMssNhHIrIGFUgiBPOqHwc/e0rwKUjcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8171

T24gOS8xNi8yNSAxMjoyNCBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPiBbQlVHXQ0KPiBJbnNpZGUg
Y2hlY2tfaW5vZGVfcmVmKCksIHdlIG5lZWQgdG8gbWFrZSBzdXJlIGV2ZXJ5IHN0cnVjdHVyZSwN
Cj4gaW5jbHVkaW5nIHRoZSBidHJmc19pbm9kZV9leHRyZWYgaGVhZGVyLCBpcyBjb3ZlcmVkIGJ5
IHRoZSBpdGVtLg0KPg0KPiBCdXQgb3VyIGNvZGUgaXMgaW5jb3JyZWN0bHkgdXNpbmcgInNpemVv
ZihpcmVmKSIsIHdoZXJlIEBpcmVmIGlzIGp1c3QgYQ0KPiBwb2ludGVyLg0KPg0KPiBUaGlzIG1l
YW5zICJzaXplb2YoaXJlZikiIHdpbGwgYWx3YXlzIGJlICJzaXplb2Yodm9pZCAqKSIsIHdoaWNo
IGlzIG11Y2gNCj4gc21hbGxlciB0aGFuICJzaXplb2Yoc3RydWN0IGJ0cmZzX2lub2RlX2V4dHJl
ZikiLg0KPg0KPiBUaGlzIHdpbGwgYWxsb3cgc29tZSBiYWQgaW5vZGUgZXh0cmVmcyB0byBzbmVh
ayBpbiwgZGVmZWF0aW5nDQo+IHRyZWUtY2hlY2tlci4NCj4NCj4gW0ZJWF0NCj4gRml4IHRoZSB0
eXBvIGJ5IGNhbGxpbmcgInNpemVvZigqaXJlZikiLCB3aGljaCBpcyB0aGUgc2FtZSBhcw0KPiAi
c2l6ZW9mKHN0cnVjdCBidHJmc19pbm9kZV9leHRyZWYpIiwgYW5kIHdpbGwgYmUgdGhlIGNvcnJl
Y3QgYmVoYXZpb3Igd2UNCj4gd2FudC4NCj4NCj4gRml4ZXM6IDcxYmY5MmE5Yjg3NyAoImJ0cmZz
OiB0cmVlLWNoZWNrZXI6IEFkZCBjaGVjayBmb3IgSU5PREVfUkVGIikNCj4gU2lnbmVkLW9mZi1i
eTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+IC0tLQ0KDQpUaGlzIGlzIHRoZSByZWFzb24g
SSBhbHdheXMgZ28gZm9yICJzaXplb2Yoc3RydWN0IFhYWCkiLg0KUmV2aWV3ZWQtYnk6IEpvaGFu
bmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

