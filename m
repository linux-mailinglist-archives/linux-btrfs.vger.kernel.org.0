Return-Path: <linux-btrfs+bounces-5636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A3903284
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 08:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1F12871BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 06:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1443171E47;
	Tue, 11 Jun 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m+KcRnXS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ix0dNoac"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBD17165F
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087179; cv=fail; b=Q8IBqdMzT/lvIO1eEGkHkTrj1Uug2KF1Yf8YV6NEKIgNzq+mk0Ns+Bqw0iy/pMESSMKpg6stnhgdlpHyPEuC1vrEkGs9Rmn835ceWsYowqJE2leAJPfmd4R2/4guA6ug9F4Ex/hHa1pPYDs+lRxSLH7XJzbMaYzo3KhNJU/KPLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087179; c=relaxed/simple;
	bh=EY5KyqTMzNaUghxG58IHmkGTZWuYnzl1ZfyKlPpMTN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RVaXWj6ka2zmjNfaIaOr6Cv1HD9KYzWEfw1Ls3dfxiUlryxcEzpn8Um7Oo5eJ3ngA/IhMKV3FEmvnHIusW1VxSTG9JyUb/xjbnCcStjVPYGfyouscrcACrh9ulcNhWs9zBuX9gWXy1E2pJqSuK3vx7cHDO28G8fSL6XqZsAXK9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m+KcRnXS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ix0dNoac; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718087178; x=1749623178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EY5KyqTMzNaUghxG58IHmkGTZWuYnzl1ZfyKlPpMTN0=;
  b=m+KcRnXSiNRvW5g5FRxG0X2ke/w0itkmvEfiuDBXxq7bfncZYRj6SV0t
   8ZBEFxW7iCiFKY58CY9kA4AreUU6RZkP5iIfgWq7sO4OE579kfLYRJTx9
   s3mnyxnseH1nHv+0T5Pr92uL0JJs2eud/IN+U2cFVhRHPO3VsAwspid7Q
   un0VKsVnEjNskoZZJy6i62+9S9J8mBWGemBzENfHuy6LIWferN2hcPbOA
   9J/tLnn0XGnMh6OqAVjtfVbjpjloDj4OI7F7iJ17CFsVQPAH6SJGZSFYe
   Kz4tFSQrxKHKHvx9eGmZwx4eWfTxB8HBMWFNQBtXUaqijwJIA0WTufBlK
   g==;
X-CSE-ConnectionGUID: GZbflKImR0KuiVW+AHR5UQ==
X-CSE-MsgGUID: xpUQQxL9Sc+qCWMmSFT+qg==
X-IronPort-AV: E=Sophos;i="6.08,229,1712592000"; 
   d="scan'208";a="18490707"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2024 14:26:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyU6joNT8BQG6RSkVQwHhQvdhp3OOkt+o7bXwCxydDPU1QaaCo2SVx8aP7Q3r3u3rM2J7hDe5CORB7d7mG4jFRyeSIm+VqiSwt4zlIxtDSTaMY96251SBKsHsDSeCwgh7Mg3jBpwLvXvjpGpPVOAS0KDL1ElRboUs54A25g8F3xf6CK6igIZ76KHb7AtWy4pL/Trakj8numA3QPVWg3DPzBi2wMgBTlewZo3g2ABdv+6yWyq7mhr7Fyl9WJU79ZyctSeMJ0jb4hQD/8Jb9WcCKFBW8uW/R0S2707z1ekplunIkAjwnEwPD8foRxDlHwMCMZFlzOIPiB0MQt7X69ysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY5KyqTMzNaUghxG58IHmkGTZWuYnzl1ZfyKlPpMTN0=;
 b=LJ5v2tckzaWb6pyx9Nf6czmntgJIcy8DKioc9h31s1vMUinOG6nUXSwX3NUZKKyYZJb/sNG8Et41xYOY0hNCn0sSlrzb1j9XBZAw62r+cJmu2urqQwuNAUy2sW/kXBbLMhDurVYcvpzYoxtJfSr76ifFpFEWJmf1hsKvFiQoU6UxBmOPqPGfX9zf9dypgqPSTYFLISiVKE9Gkssl9cujtU2IPm+MraKbdFsOtjb/XeQRBsqTr/BWFlwc4drfVQjrVuzUypH7JZYuxCa28TXCXvMaRirJw6EPGpVW24H393SyGUHB+o7lSWxoxdfn3LfEZR+/gQe9mXVSrV5diFrUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY5KyqTMzNaUghxG58IHmkGTZWuYnzl1ZfyKlPpMTN0=;
 b=Ix0dNoacgrW+3iCYlcIdqc6kCdWBRxsvusgqYFGTx6nyasMAWwjia0NbVngA1K2Hcf5vp2txX4YkMPrinM/0dvX1knSW0u27kntAyy9paGQSjuBLBYK0v1aWJZqPVP6sI2AZqdYG4xpvatoyVNFbIEKvFuK6J8GDQmBUwgIFT2g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6746.namprd04.prod.outlook.com (2603:10b6:5:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:26:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 06:26:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC PATCH] btrfs: scrub: don't call calc_sector_number on failed
 bios
Thread-Topic: [RFC PATCH] btrfs: scrub: don't call calc_sector_number on
 failed bios
Thread-Index: AQHau0R4fBJV44yx/UycYlTjEKAy7rHBgqsAgACXSQA=
Date: Tue, 11 Jun 2024 06:26:09 +0000
Message-ID: <a04c6fb6-bd77-400e-a80b-178dd2e6c582@wdc.com>
References: <20240610144229.26373-1-jth@kernel.org>
 <16516c00-845c-4cb8-9bb5-6e5e38bc71c3@suse.com>
In-Reply-To: <16516c00-845c-4cb8-9bb5-6e5e38bc71c3@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6746:EE_
x-ms-office365-filtering-correlation-id: 337ddaef-0e31-485d-d7c9-08dc89df6213
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDgya2tRKzAvM0FVenJpaHBDSFBldndTTE5RMTFFb0hrYS9ubW9KTnhqSVdL?=
 =?utf-8?B?M0xJMXBaNHJkK2tIVnBIOXlxVW4xS0huc3NYUFFEa1hsb0dzYnBna2JSR2JQ?=
 =?utf-8?B?bUtvRk5wZ2w5ejVad09OdU40WnArZEJ4ckFCcXpnYXBmU1VON0JudS9rZTFC?=
 =?utf-8?B?MERvallwdXV2T2hyNzcyR0JaQjZnUENrcXZTanpuRUFZc2dWdk1OWFhuKzFt?=
 =?utf-8?B?UGMxVEk4dUFib2szV3lscVN2VmFBUVJ6N0NaVXA0QlNRSEgrakVEa3U0MnBI?=
 =?utf-8?B?OUpqU0RiOEFOdzFpZEJ0WUJhZU5PUFBmc0tOb2ZoZjYvT2pZRVRZbmQyOXpT?=
 =?utf-8?B?UXl3a0I1d2JEU0M1SVFMM0tWRUExelRLS2ZVbzZ6S2lGUEd4T3hxREVJU0hl?=
 =?utf-8?B?OUJqVlRqQVJRS3owK0RmbnNRYXpyT0xGZUl0TDMwMzhDNlJKNWwxaGNnZVFZ?=
 =?utf-8?B?R2RuNnVrZGhjdVFRSS9KaWJVMnhPcXdxMWJjSmdLZ1V0bGFuSS9xckhQZXBO?=
 =?utf-8?B?UEc1c0l3a3ZSblp6alRkVlZyZ2p1eXpDV0lrL1pYR094eE9MUmE4a1B6MS9w?=
 =?utf-8?B?OFlGaGRQelFMTmh6cFdGSmxoeGtTWWxxcnNtQzgwM081SUd6YWw0bnpTZEU3?=
 =?utf-8?B?eHd4eEh3cDZsNm56dXVFemFpZXFkT3JubW53bGcvZFJ4SzFKS1p3b1B6QWZ1?=
 =?utf-8?B?YTUwbTlsS3phTThmaTVkd0tMTEhKV0MrcXd6QVhmbFVFRzB2eXlHb29EYTVw?=
 =?utf-8?B?emRHbngwRTNxckxmMmtqTlExSkJBRHZuREN3cnVlMHhwb2Q3MTB2UjVsK2dk?=
 =?utf-8?B?UTFyNkhzdXQ5a0xqNmEvZ1AzMkhmUXRKZW5GaVd1WFhCczgra2NVQndvcTJz?=
 =?utf-8?B?eTJveWFWaGxtdWVLeHRQdjRvWXdqanB3eGFZQ2RGM1RhUzdBMTlSWCtTRmFH?=
 =?utf-8?B?S1JpSkVwSGZPUnVneXJoSDFYbEtCandFK2RBQzJiUndTczNBVG8xRlJSdExw?=
 =?utf-8?B?cDduMms2UmpoWUlTcnBBQ0c2TVRqZ25CcmFKQmhibVY5a0RIYlNzaStXUytD?=
 =?utf-8?B?QmxiSFUvTm9JV0pxN3dtdC8rVHVGREgwSjZ5NHBVSVZYWFFFOHRMY2l5NmVn?=
 =?utf-8?B?MVRXN082OWU4R2lLN1R3Y1RzNVdiSmdyaEMyYjFRSTYyRnlGQ2o4cE9xU2xo?=
 =?utf-8?B?dVZ2RVd1SGxwWEQ1OXJuR2hsS2FPWnpvUUZPVGR1RzhpcHpWQjA3Smc3T1gr?=
 =?utf-8?B?Rm1IZUVyOVBxNndudWxSTFIwbWVGb2Q2OTVraEc1cGEzWmFWd3E0eDYxOXdB?=
 =?utf-8?B?ZHRQREViSmlaQktFNWpmeGE4NjQramg3OTNhaFNuVWMxd0lZYzRNYXpsYzhJ?=
 =?utf-8?B?MEl0d1lUMnRwYXdmL1NWRkoycEdwbmZnS2RwRVBtTjk4UXJySlNVSDNmNFUv?=
 =?utf-8?B?MUFBT0lxdGFjb296ZUhPekFHSTJDSmJ0RDNlS2tpV2VFcTJiVE8xNmd0ZlRx?=
 =?utf-8?B?K3NCYXdiUHdNemFqdHFtUVFRbVAzS0dWQi9tNjR6bmlIMU1yWTlDUVFQL0lP?=
 =?utf-8?B?OEh5TTRhNGI0Z0hqT1RKUkMxRFR2M3ZMNUVCSmlZSGNGY3F6V25zUmJyUGFB?=
 =?utf-8?B?c2RXVS9WU0RwQTRjcytGRVU5U2czVVRia0tsc01yWHdsN1piaWQ0MUVZNlZx?=
 =?utf-8?B?QTZYNkF3M1hzaXNuTTV0cFc2clYySUo3MW56SnloUWJOWjZrMGVITUc3MzRX?=
 =?utf-8?B?aWVMeDZvOWxLaFFyK0hSMDV5K2FhdGdERE4vanRaNHZIbmFVSFBIQ3hBYVdE?=
 =?utf-8?Q?RjX5YeEFZhlhJmpZufwVn9AWGysEfQIhiTLL0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3RXTjNVQkNlLzY3WUFOdGpMcFJwUHJQSHI1RFhwZ2JOSkhBL2VsbDhJWHdu?=
 =?utf-8?B?YW9qT05qSnM5OXVBUEhWdURDV1QxS0ZuSGwxRHNydVlMcTFEZ1dEa25xUHpr?=
 =?utf-8?B?c1dZU1p5SzFMaWF2VFhrSEVPdm5xMjJjZGtxNE5HUGVhTHkwWWNsUHgzMkln?=
 =?utf-8?B?ZndzWmdxQW1BRUF5KzRSaFFYRWV3N3hEYUl5WkhUQ3UwR2loR2V3VXJzR0VZ?=
 =?utf-8?B?YWEwUEEzdER2TmwwRWYxRTJVWjRSM3lvL0x6dk9VWlZFQUd1amZkeWJjbmJk?=
 =?utf-8?B?dHNIL2Z5VjRSTmRzd3lSMk9BUnF1c2NhQXRDOFRpT1ZjejlvbWJuaVErMmFJ?=
 =?utf-8?B?eW1YUzIxeko5UnZKYk1OcTNPcVNDaHB0Y3VHQ1A4cEVVT3ExdzNEazJ1cmpX?=
 =?utf-8?B?ZWdnM1lJWDlGYU1ySGl0bGEvajRTT3krcGpCVHpWaEZ6SHo5Mi92c3RyVlgx?=
 =?utf-8?B?U0VyNVR5U3ducEIxR0hhSUZjVEZ0MkZJZ09QaU9Xb1M2OXVxVnBBWXZwREU4?=
 =?utf-8?B?a1NMaWV5T09pSmdWaDBCUXVlWlROSGdDME0wRzZrMHQ3K3AxOU8wN1lrcURv?=
 =?utf-8?B?eUxpTkFVd1piNGF2YUpkNXZxVE1mcXhURFUxTDcwelBEZ2k5NE5UdHlyQ28v?=
 =?utf-8?B?K0toNVhDRm5WSWpBdmlxMnhJc3ozZjhlenZRMHhjMDNGakFCRzl5YXJPSVVP?=
 =?utf-8?B?VUZZaUJadmo2cHNJR24xVVgyOXM5aXVUTHRtSkxYdEhROE9hVnF4T0ViYnlV?=
 =?utf-8?B?R05qWWlVZE9BaEpaWVI0b2VrYkh4UkI4SjQ4NDJJK3NRT1N2TVBoVXdlMm1I?=
 =?utf-8?B?eXl2RkdmclY3SHNiVUh2TDZTRTZyWmxuL2YzMXBLRk54SC81RFFIakRieGpR?=
 =?utf-8?B?K1d1U2xWU2xxUWNZZmFzMFVnUm50V3NNMVBWWWNxSGVORFF0Z0JpOW1Vc3pM?=
 =?utf-8?B?NkFHNEp4NGFtUVFjTDFGQ3NmUXFhdUxkbVMwMmlNUXJmNktWSXJXMXZtMmZo?=
 =?utf-8?B?Mmd1Vk1rcVNLaGZlN25EMnV4R3Bad2hDNmJXR1BTVEcrMGhad0NDNEFLYnQ4?=
 =?utf-8?B?RG5sSE5paEhXRlZxekphQzVhdGR4dFRKUmxZOFRsN2d3d2kzQk9iZ01qM0I4?=
 =?utf-8?B?b2xHV2pybGZCVEFrd1k2c3NnL1ozY2NXUERKYmV3VjBWd09zWC9ndEpEeitq?=
 =?utf-8?B?SEFKWi9pQnpDbDZPZ2VxaTVHS1RBT0prakI5VHlINVpTdGZwbGFTdHpYQjFl?=
 =?utf-8?B?RGhhaHdtVlhVd3VUTitmUWtsOXUvMm50eW14NTF1blFBbFo1N1M5R3JhZEdE?=
 =?utf-8?B?U3BuZ2JqeGk3OFNNaVJCam41NDJvdlc1eWlIWVV5akVXT095TnBmRElYOUp5?=
 =?utf-8?B?a2xDRmVZK01JZGQrYzZrajY0d0N3V0NoYzZUV3BBSHh3SkpBV283L3kzK1JM?=
 =?utf-8?B?aUZIaFBpdkpNd2ZQT2F1bVgwTERtNXpKZ0xSaHBNckdNY3NEQkRjSHQ5SUF3?=
 =?utf-8?B?Zmx5cmJxbjNadDEvSHJveWFHNjVYK2o3WEhBZGRnbW1iTWVDN0sxWFU0Rkgx?=
 =?utf-8?B?NkZqVnkvYTMyV24xREdzSVZTeURBazB2WnZybnpPU0JBLzMzR3ZxWVg3MW9Z?=
 =?utf-8?B?UjlUYmtPVTB2RTJkUlhielRIQ0VVYWNpRmNMODdLaTRJSkJVYVpGdHhweE1G?=
 =?utf-8?B?RGdpa2cyL05hL3hXUnhmWkc0eW1HTUpyM3N6WTI5Rmx4b1VGRXd4YnNidlV6?=
 =?utf-8?B?MUdLeWZDckNxZW5NbnYvSVhnbEd5YW9zaUE5aTF3QXFxWHpsUXN2VkNzakZn?=
 =?utf-8?B?SW4yMkNHM2ZzY0EyY2pHZzdtVk1VcHRmMlVSdlBKNnNMRFBlTDVQSkRrdkl0?=
 =?utf-8?B?THFxbXB0NHdTdjlyOHZJclpjaWJtbGZVZVJpcjlFam0rOVV5U1k4ZzRsa25w?=
 =?utf-8?B?MEtTcmNSYmdSWkZWN1hUK0lhS2RTYTk3bWVDY0FWaDY5Q0MyU1ZSNW5reG4y?=
 =?utf-8?B?cEVVSEkvY3V3ZnBmbU9zYlM1Q0lOUFpBenpvQW90TGZ2ZGdHZ042cSt5RXJP?=
 =?utf-8?B?U3FmcHRXb2hBYWZzTWtuOSsrbFRmbUhqNGE4c0N5cmwzUzFCb0ZmQWIwUDQw?=
 =?utf-8?B?bXY1R1EwMytSQ2NSZUFhYVN4amwyZ3Rvbi9uWE5PQzNDYldnRHpPRmdQUW9x?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14041F6A5E94384EB1C835A16D408FBE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SwDzJyJ/FfNmKj1q54mgX1iRVN2fZUTNXAKTQYaizgMxFWgrq5Mob/R7WJVwrQIf9F4xWkDgRdWj9fDPKGRJnYR+t+BlkVwWdCm5z4rHsQwFPHKQKRQM41lIUmOpugbf+yLLHpdstkSj9W9kSSaGAJKRd0cychM4K9d3cq010l8PJxsF7XQ/COcQibaWq50G39n5t9EX7cyHb7ZxTqIljEbEt/FZK999eZNI7x95iJr6BW4fRq/RdFpL1ODjpx7GTuwsnCXHktp8HaMQqfF1ZBYBwSMll8HAH01ahlxd/OoMuKi1ylpyhS4xfTrBD0aFbgq+wgLIrulxRZ9IlL+gjdxPqG6WoAzFmP8/ATK72o1TVdsl6cWX5sM5hatge+IAD3DwpYL4Onh6x6GxDvtLXmKrOX+EURezhEIkOdLmQkWDTSobfsKKzwkPNn0YFhfCrHyBlGCWlGQQxy/8NS6gXHcMS+gfMP2EcijvVZKWfigDLN6e0M70UXgqiQSlai8kizQpJ+8sM+ySY8uwRDZsDbTX+++LSC59YxQc305RqYAM2FAMAGbPM55UFPXAOjSbMf2UcMXngYDimGmi+3FRvh4m8mM1ADtr6x3Lvb9hZkN8VFc5iTGJxbAIVSvNamMw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337ddaef-0e31-485d-d7c9-08dc89df6213
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 06:26:09.5371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqft6Ddf0RcNz1jMXRKSS6G6pMe0L2D2H/7apnCmlFFsyORzxt2ee6A54ETlVQ58bhV413HoaZ3r7b0b6x1Q0CxAw7RLaRzGa3EnpohPu8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6746

T24gMTAuMDYuMjQgMjM6MjQsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IOWcqCAyMDI0LzYvMTEg
MDA6MTIsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBXaGVuIHJ1bm5pbmcgZnN0ZXN0
cycgdGVzdC1jYXNlIGJ0cmZzLzA2MCB3aXRoIE1LRlNfT1BUSU9OUz0iLU8gcnN0Ig0KPj4gdG8g
Zm9yY2UgdGhlIGNyZWF0aW9uIG9mIGEgUkFJRCBzdHJpcGUgdHJlZSBldmVuIG9uIHJlZ3VsYXIg
ZGV2aWNlcyBJDQo+PiBoaXQgdGhlIGZvbGx3b2luZyBBU1NFUlQoKSBpbiBjYWxjX3NlY3Rvcl9u
dW1iZXIoKToNCj4+DQo+PiAgICAgICBBU1NFUlQoaSA8IHN0cmlwZS0+bnJfc2VjdG9ycyk7DQo+
Pg0KPj4gVGhpcyBBU1NFUlQoKSBpcyB0cmlnZ2VyZWQsIGJlY2F1c2Ugd2UgY2Fubm90IGZpbmQg
dGhlIHBhZ2UgaW4gdGhlDQo+PiBwYXNzZWQgaW4gYmlvX3ZlYyBpbiB0aGUgc2NydWJfc3RyaXBl
J3MgcGFnZXNbXSBhcnJheS4NCj4+DQo+PiBXaGVuIGhhdmluZyBhIGNsb3NlciBsb29rIGF0IHRo
ZSBzdHJpcGUgdXNpbmcgZHJnbiBvbiB0aGUgdm1jb3JlIGR1bXANCj4+IGFuZCBjb21wYXJpbmcg
dGhlIHN0cmlwZSdzIHBhZ2VzIHRvIHRoZSBiaW9fdmVjJ3MgcGFnZXMgaXQgaXMgZXZpZGVudA0K
Pj4gdGhhdCB3ZSBjYW5ub3QgZmluZCBpdCBhcyBmaXJzdF9idmVjJ3MgYnZfcGFnZSBpcyBOVUxM
Og0KPj4NCj4+ICAgICAgID4+PiBzdHJpcGUgPSB0LnN0YWNrX3RyYWNlKClbMTNdWydzdHJpcGUn
XQ0KPj4gICAgICAgPj4+IHByaW50KHN0cmlwZS5wYWdlcykNCj4+ICAgICAgIChzdHJ1Y3QgcGFn
ZSAqWzE2XSl7IDB4ZmZmZmVhMDAwNDE4YjI4MCwgMHhmZmZmZWEwMDA0MzA1MWMwLA0KPj4gICAg
ICAgMHhmZmZmZWEwMDA0MzBlZDAwLCAweGZmZmZlYTAwMDQwZmNjMDAsIDB4ZmZmZmVhMDAwNDQx
ZmM4MCwNCj4+ICAgICAgIDB4ZmZmZmVhMDAwNDBmYzk4MCwgMHhmZmZmZWEwMDA0MGZjOWMwLCAw
eGZmZmZlYTAwMDQwZmM5NDAsDQo+PiAgICAgICAweGZmZmZlYTAwMDQyMjMwNDAsIDB4ZmZmZmVh
MDAwNDNhMTk0MCwgMHhmZmZmZWEwMDA0MGZlYTgwLA0KPj4gICAgICAgMHhmZmZmZWEwMDA0MGE1
NzQwLCAweGZmZmZlYTAwMDQ0OTBmNDAsIDB4ZmZmZmVhMDAwNDBmN2RjMCwNCj4+ICAgICAgIDB4
ZmZmZmVhMDAwNDQ5ODVjMCwgMHhmZmZmZWEwMDA0MGY3ZDgwIH0NCj4+ICAgICAgID4+PiBiaW8g
PSB0LnN0YWNrX3RyYWNlKClbMTJdWydiYmlvJ10uYmlvDQo+PiAgICAgICA+Pj4gcHJpbnQoYmlv
LmJpX2lvX3ZlYykNCj4+ICAgICAgICooc3RydWN0IGJpb192ZWMgKikweGZmZmY4ODgxMDYzMmJj
MDAgPSB7DQo+PiAgICAgICAgICAgICAgIC5idl9wYWdlID0gKHN0cnVjdCBwYWdlICopMHgwLA0K
Pj4gICAgICAgICAgICAgICAuYnZfbGVuID0gKHVuc2lnbmVkIGludCkwLA0KPj4gICAgICAgICAg
ICAgICAuYnZfb2Zmc2V0ID0gKHVuc2lnbmVkIGludCkwLA0KPj4gICAgICAgfQ0KPiBJJ20gbW9y
ZSBpbnRlcmVzdGVkIGluIHdoeSB3ZSBnb3QgYSBiaV92ZWMgd2l0aCBhbGwgemVyb3MuDQoNClll
cyBtZSB0b28sIGhlbmNlIHRoZSBSRkMuIFRCSCBJIHdhcyBob3BpbmcgeW91IGhhZCBhbiBpZGVh
IDpEDQoNCj4gRXNwZWNpYWxseSBpZiB0aGUgYnZfbGVuIGlzIDAsIHdlIHdvbid0IHVwZGF0ZSB0
aGUgZXJyb3IgYml0bWFwIGF0IGFsbC4NCj4gDQo+IFNvIGl0J3Mgbm90IHNpbXBseSBpZ25vcmUg
aXQgaWYgdGhlIElPIGZhaWxlZC4NCj4gDQo+IFRvIG1lIGl0IGxvb2tzIG1vcmUgbGlrZSBhdCBz
b21lIHN0YWdlIChSU1QgbGF5ZXI/KSB0aGUgYmlvIGlzDQo+IHJlc2V0ZWQvbW9kaWZpZWQgdW5l
eHBlY3RlZD8NCg0KTW9zdCBwcm9iYWJseS4gQnV0IGJ0cmZzX3N1Ym1pdF9iaW8oKSB3aWxsIG9u
bHkgc3BsaXQgYSBiaW8gaWYgaXQncyANCm5lZWRlZCAoZHVlIHRvIGkuZS4gUlNUIHN0cmlwZSBj
cm9zc2luZywgZXRjKS4NCg0KDQo=

