Return-Path: <linux-btrfs+bounces-20502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C4D1E5F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 12:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8497303371C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27084393DF6;
	Wed, 14 Jan 2026 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d7/tQ3sR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AMAWApPZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030D38171F;
	Wed, 14 Jan 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389888; cv=fail; b=QZsztwj728BLS8HVBsXAkr5yI2UAo8rHhFY3NAeNuILXE6jmOwEFhGXna93u1Wh3wIS1L7DRD8i8gzDNBp9cCN0KkovLUdppH4P9UlJTn15SCd6Q/rJgJWkv373U2H9TgyxToZzOcMyBlM7OJsftEJnH8mh6ZYFEIUs7VwW6F5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389888; c=relaxed/simple;
	bh=lKqiYbA1qNjwA2ouvmNyNnViB86dJwlnunfpNk/vdLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfjRy8ZbHX5qVDQ6DfWHaYEWJlEuyQR64cdWayW8DvhdRDrXBMYvwsLT42qkIbZsYTq5z2ugdxwE1RJXZytiZARLjJZudcwYG0stQPsiFnewhNHKCpnhfzxKAagmvYUGJwCoJcQiTvTKIKt002UvI6DPLlhDfyi8JNpGIAn7K2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d7/tQ3sR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AMAWApPZ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768389885; x=1799925885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lKqiYbA1qNjwA2ouvmNyNnViB86dJwlnunfpNk/vdLE=;
  b=d7/tQ3sRktiPCOjA4b5jeytF7lsj/o3PqA36NAdFvUwGRGf8+9WlrIMw
   E6G+e0hIhxOGTR0hp2H1nrwcFy8qDV2HqyHiNwwQU6E6dyfa1TofGqaC7
   lxVhpg6Agj3rTRigqMhPXnJ3/yeIjD++sv3SGYR6rNmEGBCFKcRtqDWdg
   PRN0CtBhuy4ct8plHQI7Ug3mm5OVjOVVGRJzORlsw2P0SN7zL0y1WaaAb
   jrvGOWS6gHnJLIEN9/ujg7vXoYPvnaXicWV6oZO4scC8pc7S7ck590PG2
   NY9VMWcuWcvlHBajRQESdubSI+8rr/ExBNjbNidWH3Z1Z8lmfNRDcjFBa
   A==;
X-CSE-ConnectionGUID: jBfA1S5DQpywxetTOl/4Ew==
X-CSE-MsgGUID: RvORcfvlTam/H/qaeK9SnA==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="139469706"
Received: from mail-northcentralusazon11012026.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.26])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 19:24:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CegiYVYIrH4i3qVSU6oRIQZYWrColbE4BjphlODpRan6Vs+tvXZJpetJph5XFuEv8iET84/Tu8SNzWqtDdB6i5RvHT5Mzfux5vdO4Y4j/sUBN9rTGNGiTq9uTCb4SYUdL956S3A3BjBH1eyFVYugF17U+ZGkWruvcYkiiWCkwN9oVpaYCB1QKA/2Vlca2LBRYejOjJaXvRR8l/ZQ5P1YCrfXr2xpAM23Tjs55/QFhqDD2e+cgn68AGWe4pJVYMfEZ0LJW2XifdlWoesSHPZvinvYm0Ie2m7ww7+Uj2c+vENkOxTJcr4pXNdhj+g+duEtg/5WSrAE2f7RT/hRxsFwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKqiYbA1qNjwA2ouvmNyNnViB86dJwlnunfpNk/vdLE=;
 b=hG3bHrd3SW1yLRKo8YCIcZv0nRO4Rpp/aHvhoXyDgImciPgqpWUDehapHu4WyqsBJgfiQsKrP3udWBs+ot6NRphgFkIlR5rYlg+HRO9tJgq2iplJdJJzZERJ1zjwq4Z2SNfSZGkIQot3ezWElgKG4jIu24ShhsVrDqNhQRrEJqzAgivIll3ZWDjZMlO1EI0EdmvjTSDcFLFUGZThIVG9CBS3ysWi9tjxiWou5KX3jl4KO9K1dlmUlYF5YQ02Z0El6wGqjOtNK1YoJr0RrUoNF7gVoZhayiowvC8/nXDGfy3X2JJXwJpgUdna4mcc4L8TKr/n34ifibxhUOY47gaQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKqiYbA1qNjwA2ouvmNyNnViB86dJwlnunfpNk/vdLE=;
 b=AMAWApPZS0yB2yu/wlsbBaP9lyj/pPWDBz7/2ome6WsLWQGwhQUu/D4gPgWWf71gZIsfiGbMvOjapZpJhoJCvVy59CzLbp+9IZAELoq6DHZ0Q6n2nrMCA0m5nHJMJcKl+SLIy285PKrrlIxr8tWoXVanQUPcRFsJXCJPb3qDdec=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB8227.namprd04.prod.outlook.com (2603:10b6:510:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 11:24:34 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Wed, 14 Jan 2026
 11:24:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, "boris@bur.io"
	<boris@bur.io>
CC: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: zoned: remove redundant space_info lock and
 variable in do_allocation_zoned
Thread-Topic: [PATCH v2] btrfs: zoned: remove redundant space_info lock and
 variable in do_allocation_zoned
Thread-Index: AQHchAEzTc5Lg/z1XUOvihtpdim2UbVRiLUA
Date: Wed, 14 Jan 2026 11:24:34 +0000
Message-ID: <46bfc3b0-db39-407d-b114-d79b145440a6@wdc.com>
References: <20260112185637.GB450687@zen.localdomain>
 <20260112202227.37626-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20260112202227.37626-1-jiashengjiangcool@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB8227:EE_
x-ms-office365-filtering-correlation-id: 32c284da-8477-48de-19cc-08de535f7eb8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SGJCUG11dTVmTm9XQnNSYkN3QlFtRkNVT1Z1ZCtVT3pjNUZtaG13cmM2bnYy?=
 =?utf-8?B?K0xKdUdVTHF3U3FGdXkrZjNWRXNwRThTTWN3eGloQzJTTWRRMzBTaGE4d3hS?=
 =?utf-8?B?Y3lwZU5yV2xYakd6OXIyVU84dkpvMzlHZVo5ODVIZ0dpN2VFTElpYmZ1S1lZ?=
 =?utf-8?B?QXNHa1ZNR2ZIQ2xweGwvZTZJeDRvWk9UV1BSaDBrelluREZwMkd1SWVudDBw?=
 =?utf-8?B?VnRuNkYrakp0em94T05pWDB1dXBKNEZlNGRPbUlrMEU3T3ROODdVcVNwSElm?=
 =?utf-8?B?UTVrVEg5QXk2cFFRNG5XdU1SV2tYblpMSnNDRDBTa2lyQjYvTjFVUnFnS1lB?=
 =?utf-8?B?N2tGdXNkdUdPa1I1d1ljYUVWZ1VJakdiWW51YzBoSDdndjB6cHhYblBjUEY1?=
 =?utf-8?B?S2lLbGlleVcvUTJYcm1VT3NJUjVYT2loejErc28zeDZrSFZUaDczVCswazVV?=
 =?utf-8?B?aEN6T09oanhsZjVCcDdWa1JBS2JSNWFCdVg5WUp3TFphckNRaWF0NTh4VHZE?=
 =?utf-8?B?cTJsTVdMYWY2TzNNdE1XR3kwSkhmZGdwd2pUeFNUampGRDRWMDBnUFd1clor?=
 =?utf-8?B?dE1FSG81UElIZ1VwVWRNdEZqUmtrSUlmK08xd1F6ZE9ncm9YeEpPeFh4Vmpm?=
 =?utf-8?B?M1p0bXEzYXhlVU14amJYNG40MmRwSHdBa2hUZFFpTFB4bEFnYUw2S3poWXhN?=
 =?utf-8?B?N21lejhFeSt3bzRUWDJyZ3ZpSTVhbSt6cXY3UVBidWdhazZTTEF5eEdFN2N6?=
 =?utf-8?B?S3VkNXlxdC9SUUdFVEt4ekR4dEVockx6MHVSUnlhVk1SM2VwRmRTbkZLcWh5?=
 =?utf-8?B?cnBlNk9saFNLZDBhSTdNTXRjdjRURFNyUklWV1ZmUHpqZldkNHhHclZMaEk0?=
 =?utf-8?B?b2hUek5YNHU5Snc0djNsMVFzd2JkM2pEOFJ0VCs0K2IycjJaSjNJQW9KcERW?=
 =?utf-8?B?YXMxUGZXM25KSUZjaGlDeGhlUm9pZ1U5Y2FPOUJVTW1NaTd0bHlEYkV3Mndp?=
 =?utf-8?B?dmNIaG1pdkZKWkE2dm5TQ2o4T0NUbjF5Z2lycXpQU0lmUEM1VjhHQ3pzZW9w?=
 =?utf-8?B?cmJyQ3R3RzRyOW01ZUhBRXh6Yk1FckdkMktvRDRVVlFlM3BnTnpJcHR0WG1V?=
 =?utf-8?B?UlUzUjY4MHdvVUVFS1dnZG0vUk9xZFh0MW1KNUFGQnVScFUwemtxZlIzK0Z6?=
 =?utf-8?B?eVlmVXNxRzhrY1o5U05KZC9nYzNxaGxwQzdvYzE2K1czSlpIVmw5ekM0VlN6?=
 =?utf-8?B?QnlrZC9xUmxMMm9NQXhzZ0ZLMGlXWTVDY2ZjamFVaTBJYUtoU2Q1TUgwSzlZ?=
 =?utf-8?B?MWRiRkcxOTkvdHg5RWpRakp3TWpPNm1rQUNtSThHaHJTOWFza1FtQUxIb1Fa?=
 =?utf-8?B?SytaOUFjRkdnekd1emNPMHp3WTBvK2hyQVlGTlRRYStUWWJDSDhJZVA1Uytu?=
 =?utf-8?B?RHNtQ2EzWnRVTU5SaFA3T0I3Q2NwVElReHpUT2RYc2dlaTBSTXZESGZNbFlN?=
 =?utf-8?B?MW5YS3F4THZ1OGlzOXlJT2ZQNzM5L1NpRzR0YmhaeFk4TDVkL2lBYXhoRi9m?=
 =?utf-8?B?d0J3OHA5YUplQXo5TVA2QVdWYXd2Vm4wNnpOZExmUW5DUjNOb01SaDBzUnJI?=
 =?utf-8?B?cXluTEZXUkVvTDFhc0pyZzk2QUpROWpITHY2ZmdxRGdyL0RpNHdOS3o5bDRE?=
 =?utf-8?B?RzFXMDk4dDE3alZnMmZiWVg1TElwcnA1dG5uQlJpZUM2SDh6OWJMQm9VTURG?=
 =?utf-8?B?OVJMdkM5d2tSVGJnS3ZBeTNRaVVleTVGdlE4eEpUYTVieVhwRko4Y2FiSlFx?=
 =?utf-8?B?SUJMQW92Wi85ZDJLRXp5ZnZ5aUcva1VENG1OS2tUSkZlbTJMeGU2KzQ5MjNs?=
 =?utf-8?B?cGg4K1lzcFhrc3Q4Vmg3d0xISGdVZTBrWVN2ejMxWDFVRXdWZ2QrT1JkTGVo?=
 =?utf-8?B?MU1zKzJ2bzV0YXBKUU9OQlB0WEJWQ1VGWXpEZHc1ZnJqSGJGc25lVEpUOFl2?=
 =?utf-8?B?Ym1qU2lyUFBWeDlxclRjTVpQTDg2UUJBblB1dkR0WndTdDVsa1RZcjZTZ0p6?=
 =?utf-8?B?ZXJ0VmlXclJCbVFSVUtvMzJRa1NCQndlMHpUblNxYmJHcWdEUE1kWkRtREV6?=
 =?utf-8?B?UFF5RlZ4L1V5Zy9mVjd0bTYrRGpibFpOWk1uTXh3YmZYeVFGV05KMGxqdUUz?=
 =?utf-8?Q?o1gg490Dy92HloS3WDUgNks=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2J1TVN6eHU2MTNKNTFyb1RTaWIzQkpNWjh5YlVLU2VSWkZLUWk5bjVOOGVt?=
 =?utf-8?B?Wk9yVTJJY3VIVnE3QUp2dHlrdkU1VUwxb2Y5eHBlK2dya05zVUtPUkVjRFpU?=
 =?utf-8?B?WmxPanNJb2xyZFBha1diaWh4dThCNmRmK2ZScC9rTmhRUVRXNW1oZHJHRldK?=
 =?utf-8?B?K0RlVll5dlFWMzhIcmxEek1MYUtNRmo4UDVOUVc1UzJlSHlZeDQyZW9UckJ0?=
 =?utf-8?B?Rk9MM2ZyVEcwMDhjSDYzRVVLaEVweVk2by9qaGNTNFpxaFN0Ync1RG5SYTNT?=
 =?utf-8?B?RGI1YmI3TzNWWDFLMXdJTkg5MGdCOW8zSlp6V3JXcFByT3VlNEdyY1FYOU1p?=
 =?utf-8?B?YVViUVRjV2NXYjR2ekU4ZWRBVnhxMlF3UWJRZzhEYjZ6ZytVQm1HVnBrS3Za?=
 =?utf-8?B?dDR1K3RMRmpmY1c0a2x1OCtwUk5jUVFBY3VVRm5DekRGQTdmUmhldDFHUGdE?=
 =?utf-8?B?cGd0dkpQQ21XRFFwK0F5UVVGVVlpK3VOV2hRQTZBeWRTVzF2bXRFc3l4K1lr?=
 =?utf-8?B?OW5ZYmtWYkFTaEUybDNYZDVZR1pXdzNpd1duWVhtdHBwaWI4WktSeDRtZmxB?=
 =?utf-8?B?aHVmYzViY1Y0ZU9ZSUIvb2c1VHJ0NEhxbUR0QTdBL1RYS1lVemxMT284b3hK?=
 =?utf-8?B?d25xVDN1TTNlNVdiNHVkYlVMQWVrc3hCd2xCb2Q1Y0Nic0JjblptU0xRYzlq?=
 =?utf-8?B?cG4zWUMvOHlpMnFmTjdvVjFoODJNeHRudGR4QS9yUk0wVkpSb3hOSXBQOG9H?=
 =?utf-8?B?V09SZzlKYVBMRUQ1ak9MMEwyaGVqUVZEMnEwenFDcWk2V0VYTStNV01XcUFh?=
 =?utf-8?B?UDlnRy83TktCTHFwSEpYdUk5eGp5Yk9EOXdETnBoS05LWE81WEhDL1puWk5p?=
 =?utf-8?B?TUoyUEVCakV1VDlhMlJNbFFKTU0zdUNvNkRFRHRiZTRBeXl0TVRlVUhybW83?=
 =?utf-8?B?MEJWbVVpbEE1UmVZRk5NVGcwdDNqRFZKS1E1a3NQQlJXVE5FNjhBc0x5aHpX?=
 =?utf-8?B?Q3R1OFpEd2RHdlRJSmdSVWZSZ29vV0lPVXRKUS9mUjg1NDcxQWtDcHRvRW1I?=
 =?utf-8?B?WXhFMThFRlVxbWlqWXJsL2lPbGI5YVBUNTRxa2ZZVTVuZndUK09GZXA2Sk9O?=
 =?utf-8?B?OStZYWVBQ0pId0JDa1ZiL1g4UnFJcDV3RFlFbjA4cWJHdWFQRXhuRk5Oelcx?=
 =?utf-8?B?MkhSNjcwTUFNZ21yWU9EampaSEhZTXZ4RVJhMzhPdUw5ekxWWUVzWklWWmMr?=
 =?utf-8?B?M3VuVmVlMzB6THpCQ2EzWjAyNGh1d1I3UDB4WlNtUjhHR1VOT3lhdDU5YTA2?=
 =?utf-8?B?SHJ3OEkvMVY0OEdVRjdvTFJobExGbXI2NjdFdmhTaDliSDlRNzMvYjV2a2hx?=
 =?utf-8?B?RHpRY2o1QWo1bWpmL3c1TGVNUDQxeUdUV3pZYXl6ZzNJSkV5RC84UUFQaDV5?=
 =?utf-8?B?eVJzRks4WVJ2VTdzMmtLWGorb2tvM3hZU0I3c1duT25hWmFQMklJWk1vNk5i?=
 =?utf-8?B?bDRldGFrQnZKelBlUDJaTUhhaFY2VXdzQ3JQR2R4L0RHSkl1UlUxVHJYOGpi?=
 =?utf-8?B?U0JFWGZEdmYxTkFxV2l3MnhjeEFCa0NkMzFFYXNHbnhjamZwbE1rMjNkYUFz?=
 =?utf-8?B?aFlqWXN0Y1JkK2tSMklGZFlIaVJFblIvRmRJK2xTUVczL2FqeE9OaFZ6ZVJC?=
 =?utf-8?B?U2FBQ1RUN3BQT3dRRjR3dWM1a2JtdWpqSmZya0pobjYyeDhiUERTZlFSYUZ0?=
 =?utf-8?B?NExQV0V4aWRjL0tJaWJLZjMwVDBFdU9TMDUyUUQ3K0hPL2Y4TFQxMVNPdG5G?=
 =?utf-8?B?Z2NOQTRReHE0bUxmTWxyYyt0Y0dZWFFmckJ4SXFwdEhLUE83a3ZqMEh2ZmlC?=
 =?utf-8?B?Z25wMVE3LytLV2J0U2RpaHVMYTViWUVPTTZvWVhtVVVPQXJUcTNIanlJMThY?=
 =?utf-8?B?RG9EOEJVdE8yT0gwY3VBOFg0dkM2bGhOUm5uT29hcmJTM2JTU0lvL051RHhJ?=
 =?utf-8?B?VzFQUm9vNlRDcUpRNTkxSmN0dXVZN2xkdmNkbDU3ZG4wZVZyVGREMU9lM3Rp?=
 =?utf-8?B?RTcyRXY1Ti9yMHhxMGptdFZQODdVaUxZUmZYYlg3SFVuSEl3ODNJUUVGMDdO?=
 =?utf-8?B?REhQUGpTRnpLOUgxVjlac1BUY2kxck5zK0V3MW1HNENaUTl4MVdtcUdiMzN5?=
 =?utf-8?B?K1NaNlNGSnFrTFhBelNvVk9ackl0Mk5NUGFpSk1pSzRGa1dGbUR2M3hDK3Iz?=
 =?utf-8?B?bjRZN1N0dFQ4c2FPWnY1MnhhRVFqNmxWb0ZtcVI4YXkxT1E5d2k4ZnQwaXl5?=
 =?utf-8?B?WDlxelpObTB5a0d4Q1JpWlhzR2tGMm9xWnk2T3dRaVE2bW5mdmhoVzZFOE5v?=
 =?utf-8?Q?C/EDdK5CfcVclHA2mJe8Uxk296nFeJ3mBd3BaBY0Wh1fm?=
x-ms-exchange-antispam-messagedata-1: aBXivHsYfXdUe2fRXoW4PUxkzzJ2kQ3QXIo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <039B3FC671AC68418349C68F9F04BBC7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/vOyyKAg6P++t2FIlDy2hAyaxkQt7OCBpLEICWUw/L5x+bBZeKeRD0BhHF7nIFV8kC6VUWY6qfxBHzUAmtsrXOIEDWKhTT4QlLQNJfAmd6QXZ5N2tdnfzboP4Y6MXvm5Q+GAHyuhwiIz2WArRAXGlUcgN17ws5fy4hJbuOW9LwFMyMb7T6Vgc1q1etYdMPBX0AK8+GJZIv9KgvNtyvzrjNtx2KkUhdmnqF0xdrTPOQfJVMLDEDN5bL8e1851Qgmrjcu3BpFYQzNuC+m6y7CD7da4Pc20IkJUl/B/M9HiHiGvZJz3PKbNWWSbdDCk8iOG+8pgsJlKWSHznhrbvCPn7T1RwU2issSHVzxyKb1ReW/TqiE9hNXAw+MbXm63heGq8Yj++2vw7bFcKj3QiFYnyCpWwBqtp/3/jhF6hEsWCoS95LrbsQWel2xfGMYtZDbge+bXXcp72Isy3c6gmDLn3kYjRaxa3Uy3t6XdV4YbYCtKMY48gyAmK1Kf3Fz3jNmAUleq7Jnmstp5ySqWzA6tonEbPAEgXIlhPEMzxx4mduMLrqJ1rovmS8iAdwLP3GSa0jUn+J34FPgWBIqyIGZSLkdK0kKpwZBY6yzsPsKTIn27fdntba4YmUnjuSoGdyq0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c284da-8477-48de-19cc-08de535f7eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 11:24:34.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: So/6Jw0TDw/tG+J1NJMfbQM9HmlaRRCQD/MzFYUqI743lEk1jYF4bZ+WVwO7Zy3nZaCNRzldD5jQCb2FnTU0Ur11TIvGHq1igy/XOCqdHeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8227

QWJvdmUgZG9fYWxsb2NhdGlvbl96b25lZCgpIGlzIGEgY29tbWVudCBibG9jayBkZXNjcmliaW5n
IHRoZSBsb2NraW5nIA0Kb3JkZXIsIHdoaWNoIGV2ZW4gYWZ0ZXIgdGhpcyBwYXRjaCBzdGlsbCBz
dGF0ZXMgdGhhdCBzcGFjZV9pbmZvLT5sb2NrIA0KaGFzIHRvIGJlIHRha2VuIGJlZm9yZSBibG9j
a19ncm91cC0+bG9jay4gUGxlYXNlIHJlbW92ZSBpdCBhcyB3ZWxsLg0KDQoNCldpdGggdGhhdCBm
aXhlZDoNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+DQoNCg==

