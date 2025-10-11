Return-Path: <linux-btrfs+bounces-17636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B10BCF30A
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Oct 2025 11:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4E218961CD
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Oct 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8DB23C8CD;
	Sat, 11 Oct 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gUIR0m/D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AeEUkGDO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857884594A;
	Sat, 11 Oct 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175285; cv=fail; b=VRjz31ORUafhKHDM+57ED40U0PeAISIMMbb82vuQQzsWxEQlyjwVH5KCpOHKsaHVhTOSiLv/QkPy3dNuwkQfMHHptVCleHG/fihTBLzMAqEXaoDxjA19kqyMlnVKExTHWum6ntKYR6UOdNUx0/II3uMDB27bd7IaX2tD6gn2UR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175285; c=relaxed/simple;
	bh=fgBfjx40VTc+ZEsea9kfQoeioP5at9pKcTd7NYnY4hk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ae3FNA+WNee7jUDFHiIYnwJegXIjLj64QxPoG7aTFFjHNouU+j5MdamudjKnd7XXd2LWvUsUjgtH9C9qAv12Cffr9VmPHmwX2WyDM3FA53gKQjIZDEnu3FzXrHGBhs3EcHTXGNa2n7STDGtQiBfbVtcXIBzgYUQnXeAQeu8JxIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gUIR0m/D; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AeEUkGDO; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760175279; x=1791711279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fgBfjx40VTc+ZEsea9kfQoeioP5at9pKcTd7NYnY4hk=;
  b=gUIR0m/DQr5Zjsd6yjl6PBftwSEroKEvdm8W/KabCg0/xIl+JwhhH1Sd
   drmiUvAJCi16jfRTAkVD1Ro7QLHOgty/cskew686g/J2/ZEi85+7abdm8
   9jaGhkHk1odC8d67yKCnIbZPM95t3xG5N8ga3lDkJJnuDJg7G7oJNMjt3
   xM54exWfiyP3qQqiaeVLsy/sgwRJVwGlOScdoJg8wAcDo3lOaGgR0ZLKX
   LRjdsylDmIsMH/phO5VnU6roOLaoGyo7bSUlwdJQZR6dq/VCvSHt0C8Iw
   eM8yJGQKPIcUDGEY9pkSAPAqAnFWU3uuXl/fpMz881cvwreSsyEs/kVqf
   Q==;
X-CSE-ConnectionGUID: p4gkPcYtTb6whJQE28PmOw==
X-CSE-MsgGUID: O1Pb2kU8SbuFM+dAgVQx7Q==
X-IronPort-AV: E=Sophos;i="6.19,220,1754928000"; 
   d="scan'208";a="132708744"
Received: from mail-northcentralusazon11012015.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2025 17:34:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUZfOrYky52JzTEtdKnBSfa98MTPhM8KMkR5YJjez9rtFeJq/kMkMIGEQmLf9KLCGCMjY/ZfaJjRCUj9GxDDq/vsZdFaNcKgVzYVjcMBA1DBk6xM7vXfSqbcYcDF7VO/vdDZd62BVFrRZEQzitUYmt6kg1cHy66gQF6ylq8lDntjk3lzj6CPJT76fsnN/7Y663IcawSgybm9Mn86u0srwg0brcVb46glYhTr+wyzV/yMqVn5bqbAZgUj+mGqXwLXPeblHtTgWzV5QyDK4IxZ/YUWYLaBGu6PitwEhsh4MAOk2BM8DuzWvA6tOocOo8yIFspt9Xh+Mkf6KoLXSOdz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgBfjx40VTc+ZEsea9kfQoeioP5at9pKcTd7NYnY4hk=;
 b=lfT1bG5MsgSiNlqdjFTR7S5NwnpBnQ2RVS1mjDbpIoroJsj4w3sY+wL5IlTIvKUFrs0lsywZ4QJH3WWELkms1HinvFCaZYK9wqZDxftsK5PJ0ZZ12WmGrBgRhu/kId44zc51giEqpP2mI4oltp0scYkeDWJciD3jyp1aKtUuDGP2e3tSnoCeqBtspbywUauLbMRYw3wNZDgc4py7FbiPIYKI3LETwDMj3CaHR0Jo4mOPT6SLam8qS37U5v5VtTXKBNENQDhEZ4B1+oFanbsRNjHwOSymKQMF3Y6O4G4/+uuN3r1Nhq+Z63qrn7X3ZbRu0lVsHysLEa5OkY2jhKu24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgBfjx40VTc+ZEsea9kfQoeioP5at9pKcTd7NYnY4hk=;
 b=AeEUkGDOVwunnJl3uqWpOA7YBwdQO77RUIz+4Cm2u+qWomwYBBSTvThdQqfH4GAiEiKQrnjtOdtM4iKZ4xgsz4DRqhasSaBNvtrZah7RQJ/TwF9IpTMNiJmp9df+UTJVg6lJQ0ZDnsjqha6IlIJ/hqDMxo086xS1e/DoSGaVFuY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN6PR04MB9480.namprd04.prod.outlook.com (2603:10b6:208:4f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:34:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 09:34:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
CC: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] common/zoned: add _create_zloop
Thread-Topic: [PATCH v2 2/3] common/zoned: add _create_zloop
Thread-Index: AQHcN4oM4muMXjqpnEST+IIw1k0JMrS4U0kAgAAIVgCABFnIgA==
Date: Sat, 11 Oct 2025 09:34:30 +0000
Message-ID: <f0713993-cebf-4e42-9c1a-26706a52be4d@wdc.com>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
 <VGGoqK-5ZWJTAAy5zOK2QgRfnghNzWtGFoBwL6Sw9bqE7moL7lyTr43XUUgtMM54gKwCKIpC1Jz9u5ZcnpNATg==@protonmail.internalid>
 <20251007125803.55797-3-johannes.thumshirn@wdc.com>
 <hrht5llavtcgd5bb6sgsluy3vs2m6ddzzshkhwqb4fjgujgrli@6px7vpsk7ek3>
 <20251008150806.GA6188@frogsfrogsfrogs>
In-Reply-To: <20251008150806.GA6188@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN6PR04MB9480:EE_
x-ms-office365-filtering-correlation-id: aaacdbde-8492-4bd5-aefb-08de08a960fb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFp3THlYaUpJOW1VMy9qZXRvM3hBVVE5VVJPeTdabnk4UVJNL29WYWY4SGp5?=
 =?utf-8?B?TVZJcitNYWpkZVZ6azYvVndseEFNZVFTUlJzS2RGV21Nby9DSzBhWWRIdCtJ?=
 =?utf-8?B?QjNldTZSekJaVTdoVk0xa1Zjb2M3emxNbFdqYzFFOVZSb1RVamNNKzQvaEVw?=
 =?utf-8?B?S0p4ZjJRZllnZmNHdjBkbmY1M0hjcFN3WW9ib2NoWGN0eXpYNWFtaDNRT3da?=
 =?utf-8?B?NlFPcVluUWQ1cklhL2NaaEdKMyt4ZUNMMGE5RVBDbkpMamhVWmN6aDRoLytW?=
 =?utf-8?B?R3QvRnU3Tm9FUHJ2Q3F2aGlYbHYxN2pYQ0szeVk2SkNLTFVZc2ptSnlxVnMv?=
 =?utf-8?B?dkZnT2h2K0JQTnc5ellicnRPTHhTaDBYZk5FTVhTaHM3WVIxTWRIcUt0Q2Vk?=
 =?utf-8?B?RVkzdDFLejFseU5XcFJ1REsvZUtTd0NIeW12ZlRKWklqRzBEenZJS1Z6aFNT?=
 =?utf-8?B?OEhWQlN4eC9BQ016eUpaai8zRWEvRkl2UFBKM0RHWXpnc0QxcXhlY2VxNDZx?=
 =?utf-8?B?RnIvZDFKMzIxcVNJL212bHBnVm10MHlWZVRCNjhVZUMxa0VLL1RLdjBDNnB6?=
 =?utf-8?B?YTdnUzVVK2JPZHh2cUt2RDRraHB3NzJweVU5bmhPR3VLb3puOHZMYnZ3MUdN?=
 =?utf-8?B?eE9ubTVhS3VnWnMzZzJNZHQxUWt1ZnNGc2pxdTFTcEt4OG5Wdzl2UWNrY0Rt?=
 =?utf-8?B?Yk1sZTM2UmZJQ0xVOXRwNFFUNHVmdFdER2RKWlgxaDZTaHYxZWYzL2xHQW1Z?=
 =?utf-8?B?ZDlTQTBaYWFtazVHRFl0OFJpbFFzQWsrS2VmbnFhODNXaVk4TnBneWlIZi9D?=
 =?utf-8?B?Rk5oL1RYKzJ1SG4zbDVISlpMWjBPQjJVa1pzQWlwdXhmN0VTclQrT2RSQUdn?=
 =?utf-8?B?VTBwZ2dRMGlHRVpIbVkrVmtweklSdkZaRkd4aVc2dndVUFNlZlI0elVrQnVR?=
 =?utf-8?B?enlwQ0tXSkcwLzl3dzQwVFhVNkRZVXFoR0Z0ek10NENzV3htbVJDVml6NWpM?=
 =?utf-8?B?Zlo4MjRBWFdzckpMSGsvTi9Fcit3UllxU0pLcXVnNkZQTFYrRXk0V0pOS2tW?=
 =?utf-8?B?OVlZbTQ4V0s2Z1Q3MUhaSVZXV0Ftam41cngySHQxSGhwTUdmeEZDS2F1dE5D?=
 =?utf-8?B?RWZpNGY2U0ozU2kydHB3Z1VDRUx3SmNlWnVGNFl3c2FaNllnSW16dlZqa1Qv?=
 =?utf-8?B?TVBvU3h3U3FZaGNpTmdmeDY5RkMvR29GN0paS1A3NU1WeURUWFJ2OStmVUox?=
 =?utf-8?B?cHcrc0NIcHR2Y3A3dzNyT1lBVm53TFZwT3RhODZsSVRaTnJoTHdhRVV6TkJQ?=
 =?utf-8?B?enRiZ0E4bTJmRzRjRWlWbEY1SUhwVWVRWDcxbkZHUzc2OGgxM0NTQ0ZHWkJi?=
 =?utf-8?B?S2pNVlRVeEgwODNhL0p2SWRjM1M3TFNhVThVL0dBRnozZ1d0cnA4NFV3dVcr?=
 =?utf-8?B?VXlzdXpGbzNBNlJRdlJIejdiNmN0VjhpRnZVQ0hPVXZjaTcrYnRYYWZkWkF0?=
 =?utf-8?B?bVBPY0VSZ1ZVNFJMNzAzcVpjWHdDZ1RNZWRFbU4zNkI0TFdZMmZvZzBUUGdO?=
 =?utf-8?B?RjR6RVhZbXdnaGh6ejZzUWFUTVlKRmZJaDZiVkhhV2ZaYWJqWm5wZkxOOGlm?=
 =?utf-8?B?L1JURURRYUtFUFh4VStreDNTT3M0ZEN2L1dUbDVtYmQxSzFKK0xZMlJuTGtk?=
 =?utf-8?B?N3dIMEpXRk5kNDl0ZFBJOWdURi9jazF2SVhTY3hGWStBdXNYYVJmVHJGbnFJ?=
 =?utf-8?B?VGFLMHhsZW53cjU3RzAvNUx4U1VnL0tjNUpFNXBBd29LRmZRdjBlaTFHNzZK?=
 =?utf-8?B?dW5PS0JoR3QrbXVqeU9WR05BcWlSWjQyc0Q2N2w5cUZvTk16YUlrTUZkYXA0?=
 =?utf-8?B?WFNmR1F0ejBJUERtUzV3ay9MandLWi9qSXpIUHBWdC9qQmt3OWJGNGxPUTdq?=
 =?utf-8?B?YzUvR2dwRkFxM0xEVFJKbGR6eFU3cFNrSG1FVkVwWFVRQnNmWklxeVVjYkl4?=
 =?utf-8?B?STBPai91VWZ6RFhOcHZ6aStwL0ljSElVSTZ0NmIxcUlmUzY5NWxwUzhraDhN?=
 =?utf-8?Q?Z/lkmc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djlVTTA5c0s2Zm9FVlc1UTE3YlZ1N0tUZnRrOTB2N3VqOVpJMm1vSjNmWTFt?=
 =?utf-8?B?VUhUTXkyWkVtbnZjeE1zcnR6WjhMc2VrOUVHTmZEWHMwa0h4NURDd29VdTdD?=
 =?utf-8?B?d1VQK0l3U3BwWlA3M3htays5bDVmZU9JdXNWTDRiNm1uNWxRZUxndzFSdzFK?=
 =?utf-8?B?czMyUnpsZVFCYmhCZnlObUtwejZHOG1JcG5SY0JyY1k1YmtCb01icUQ4bFlh?=
 =?utf-8?B?RDZ1Z21pV1hBRGZpY1RDTFRwcitqR25iZmhXeE1sdXVraHpQdFdFM2FmL29W?=
 =?utf-8?B?SStrYVgxS1ZFbVdZZ09IdXI0Ny9DQjg1TW5GeUsxS2RwZ0MxQmxsV2g1VHpQ?=
 =?utf-8?B?MGxmRWdNQS9zSittTytMMGJDY1J0NkNEZ2R6NUZxM0xwNGdKUG1LVEl0QTIy?=
 =?utf-8?B?VVJ3WWlsYkVXdXZScHc4SzJFS3hJSDhsY0tZWmVJUGdSNUZ1WkY1a2lLT1Vy?=
 =?utf-8?B?di91bExxS1pRVDk1NW9KRmNJS0RaN0JXeERGdkZ3cnVxUGw4SXIrcEVxQWVV?=
 =?utf-8?B?amNXMjBrb0J0cVRyaTZWK05qNUV2dnQrS0ZRVTU5YnpJNXNla09wOU1SeVF0?=
 =?utf-8?B?WWxncHdoeWs5enc1S1Z5eDBwV3ZKZGRZeko2Lzk0dUhXTkg5VXRtSThHMFZt?=
 =?utf-8?B?QmduWExIZUV3WkpkU3NBUGxxNFBxSXhnVGEzOTZMZXd5T2d1cGhtS3dJVklG?=
 =?utf-8?B?N242ZkRpbGkxNTh5d2JNZDA3ZnZsaUV2dzhsejRnUTBEYTBZYnlRNklDbTV2?=
 =?utf-8?B?azVERlFZNEh2M09TOGZVMktidllZcFJVZWVaOS9EZU04OTNRZ2NLLzdPamdO?=
 =?utf-8?B?dm5ESkQ0NHdDT1hUOTlBcmZaaEdkbTdGUzdPWTlGb0hJT0VOSGwyQ2ZQazUw?=
 =?utf-8?B?ZVJNSGF6ZGFQamZTNDVVSTBDOStHalUwOHJSL3h1OUJaWVZVc3ZOTEhHQ1lB?=
 =?utf-8?B?bTJadHV1WXN0UWpUQzU2V3pjR1Y1RnV6NlBiODdXellWTmc2WmlkNXhRYmVi?=
 =?utf-8?B?TDBNYVdCczRodm1taXErNEsvaXpRZTcwbFc2MkFvVjdVcFlyN0ZzL3ppTEEv?=
 =?utf-8?B?MTlUOHlDQmlNR2pCQUZiYzhWU09sY1NZOTNqcGRlRHZGVElCKy8zb1RTOXBk?=
 =?utf-8?B?UEFob3pSMnpHQWg0elltN2t5aVlwcDlmUUY1Q0Qxa2tMalk5RGxkVmFnVXJG?=
 =?utf-8?B?RVRRQk1GbS93Qmc4bjBLUVpTM0xEOHJyM1hJaFp0Yi9vbjg4NGxidEFTL2hK?=
 =?utf-8?B?VUNodXpmL2NEVVYwUytNV3J2NEdCR096QzFVSXZuQ1NKdjVaNHV5NWpUTHRt?=
 =?utf-8?B?S0psM1lua1NBaFNMWklYV2dFV2xTdEZSTnpzYnRESUxmZlVNYW5aOUJuVHdp?=
 =?utf-8?B?WnlycW4xRHJUK2h4cEE3UVJvTTNoMEk0OGhIUW1RUHpjcVRtWnE2bndjWkJr?=
 =?utf-8?B?MzE1UUprOGtaWm9rSTdDanRJQjV1aFQ5WmgxZmZvUWJOeGJBNkF3bkhQUzVI?=
 =?utf-8?B?c0toYk5hczBva09MMis2SWFmcENaamNVZkl4ZmMwN0pzQ013d3pIUEVrRFdN?=
 =?utf-8?B?RDJwK1ViNjlmd0MrNnNBUmJWeVVGaWx3WFlYcEpZVVgrQ01HemxSTmVIMDdG?=
 =?utf-8?B?STFrTUFKc3VCZ1VJOTdDcUNqdlphZlJ2OVBBMzRRUnlwaUQvMVVkbFJPS0ww?=
 =?utf-8?B?aE5uc3FKSGFXODBIQ3hyQkxhNEwyL1g0K1FRVncyTUo1UkwwdUk5SE5VemJr?=
 =?utf-8?B?cTROcGhpVkdtUVRRMlJ5RHgrVWhpOUsramxoeWxvUGRhbWp4MjV3SnZHcytG?=
 =?utf-8?B?K2lUVGczVDBQWEhqYXg4L2FsZkxSN011UzRLMjlGUnFzRjdFSGZBTEZKWWhQ?=
 =?utf-8?B?bjdaOElKYTZwdm1vajN6RG5vdHFhcDVmbWt6L2M1TlBCOGFQQTlCcy9Md2dz?=
 =?utf-8?B?aWphczNKOENqZXpGaVRBcksvakJnZlVvWTdWRDJvRkZpZmRZT01ZZGxCbmhk?=
 =?utf-8?B?c1dNVCtlR0FLeTdsSktUTkVIT2tIMTJkMnJaVnEwcGc2dXIxNmdXbkFYRFdr?=
 =?utf-8?B?NXlaNFVhaldscU5BWG16ZnFrR1V4ZnliZm1INmFLWkhWVG04UEgvTzFabkZJ?=
 =?utf-8?B?Nm1hbFdPWXRJaWt5QWNDTWNkRjR2Y3ZQTGdtVXBDazd6VGFzOXFkN3FGdWVO?=
 =?utf-8?B?NGxTYXJxVVYrUTgrckdqamRkdGYreklwbVQ3dlYyRXVVYTFMT1BVRlNXWE1T?=
 =?utf-8?B?d09VbnhmMTFDNUFVY3d5TGtDcm1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DB7FEB122CE0F4C8AC505AD6C36B949@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5gF/G/hc6pQe4DYpvr++kDC6tWijmBus18TS9iWnrq6YbYY7NMAlr8YQbTvlJYqidOwSIblEjtmFFphui70WmBYS8u077Y1lRcs31NwRCL/OiFTjlezbS+yfiKC4tLRMJxoiG9VvutRoFO85wIV37QPvoJWGH4JxPWEyDih2uocdss36lHvBw9L+FkeF0Crp8RetJQjIXUs/avnYf4rh5wliInF9FqN/Hkis8ciQg9oFv4eO87bucmYY48Ib1UpdKjF6jN/fWLS79StNSJXpS/RCVkK2I1q9TrSC0QeDLWoSln/icQH6l0eqmuZU+X7BuBi420p+nhEK1s0GBNNjXxWcwiRYBhb1R6HeamCveI3cljShen+MSmwPe86y7l/0IMK8OTD3SiyFAt7NyKPeMJU2wNdte/bzlj1HNxiL+DEKWGeDfh3ztXMC3vAH37LuWw78wKG908LJUaCY1rjAljkgq0QZypQw6/XUou37UR2aE2O+DILg8mn4AFT/+65C8oIYrtiaGqWnv11e2r/H8ZJWYy1Ngx2hhcM7pZTqrKyV30N/62W9ugnCSnOV8xGgrUW8FqBbyH7C6VOdJfsInnsUA+2DVJDf13wnH5m7NFUOtHuWevMn+h6RVI3w7xFb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaacdbde-8492-4bd5-aefb-08de08a960fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2025 09:34:30.2479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrJOFI8Ca41mo6ZwnMHtZbwsYm0Q3s8CyO78pXIy8dE/VcTxa/5HcVcFXQHGktvfwFm4xQPLhVvfatJGyKrYeYwRddVdPxlyVbVNoDEERsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9480

T24gMTAvOC8yNSA1OjA4IFBNLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6DQo+IE9uIFdlZCwgT2N0
IDA4LCAyMDI1IGF0IDA0OjM4OjE2UE0gKzAyMDAsIENhcmxvcyBNYWlvbGlubyB3cm90ZToNCj4+
IE9uIFR1ZSwgT2N0IDA3LCAyMDI1IGF0IDAyOjU4OjAyUE0gKzAyMDAsIEpvaGFubmVzIFRodW1z
aGlybiB3cm90ZToNCj4+PiBBZGQgX2NyZWF0ZV96bG9vcCBhIGhlbHBlciBmdW5jdGlvbiBmb3Ig
Y3JlYXRpbmcgYSB6bG9vcCBkZXZpY2UuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5l
cyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4+IC0tLQ0KPj4+ICAg
Y29tbW9uL3pvbmVkIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvY29tbW9uL3pv
bmVkIGIvY29tbW9uL3pvbmVkDQo+Pj4gaW5kZXggNDE2OTdiMDguLjMzZDM1NDNiIDEwMDY0NA0K
Pj4+IC0tLSBhL2NvbW1vbi96b25lZA0KPj4+ICsrKyBiL2NvbW1vbi96b25lZA0KPj4+IEBAIC00
NSwzICs0NSwyNiBAQCBfcmVxdWlyZV96bG9vcCgpDQo+Pj4gICAJICAgIF9ub3RydW4gIlRoaXMg
dGVzdCByZXF1aXJlcyB6b25lZCBsb29wYmFjayBkZXZpY2Ugc3VwcG9ydCINCj4+PiAgICAgICBm
aQ0KPj4+ICAgfQ0KPj4+ICsNCj4+PiArIyBDcmVhdGUgYSB6bG9vcCBkZXZpY2UNCj4+PiArIyB1
c2VhZ2U6IF9jcmVhdGVfemxvb3AgW2lkXSA8YmFzZV9kaXI+IDx6b25lX3NpemU+IDxucl9jb252
X3pvbmVzPg0KPj4+ICtfY3JlYXRlX3psb29wKCkNCj4+PiArew0KPj4+ICsgICAgbG9jYWwgaWQ9
JDENCj4+PiArDQo+Pj4gKyAgICBpZiBbIC1uICIkMiIgXTsgdGhlbg0KPj4+ICsgICAgICAgIGxv
Y2FsIGJhc2VfZGlyPSIsYmFzZV9kaXI9JDIiDQo+Pj4gKyAgICBmaQ0KPj4+ICsNCj4+PiArICAg
IGlmIFsgLW4gIiQzIiBdOyB0aGVuDQo+Pj4gKyAgICAgICAgbG9jYWwgem9uZV9zaXplPSIsem9u
ZV9zaXplX21iPSQzIg0KPj4+ICsgICAgZmkNCj4+PiArDQo+Pj4gKyAgICBpZiBbIC1uICIkNCIg
XTsgdGhlbg0KPj4+ICsgICAgICAgIGxvY2FsIGNvbnZfem9uZXM9Iixjb252X3pvbmVzPSQ0Ig0K
Pj4+ICsgICAgZmkNCj4+PiArDQo+Pj4gKyAgICBsb2NhbCB6bG9vcF9hcmdzPSJhZGQgaWQ9JGlk
JGJhc2VfZGlyJHpvbmVfc2l6ZSRjb252X3pvbmVzIg0KPj4+ICsNCj4+PiArICAgIGVjaG8gIiR6
bG9vcF9hcmdzIiA+IC9kZXYvemxvb3AtY29udHJvbA0KPiBIbW0sIHNvIHRoZSBjYWxsZXIgZmln
dXJlcyBvdXQgaXRzIG93biAvZGV2L3psb29wTk5OIG51bWJlciwgcGFzc2VzIE5OTg0KPiBpbnRv
IHRoZSB6bG9vcC1jb250cm9sIGRldmljZXMsIGFuZCB0aGVuIG1heWJlIGEgbmV3IGJkZXYgaXMg
Y3JlYXRlZD8NCj4gRG9lcyBOTk4gaGF2ZSB0byBiZSBvbmUgbW9yZSB0aGFuIHRoZSBjdXJyZW50
IGhpZ2hlc3Qgemxvb3AgZGV2aWNlLCBvcg0KPiBjYW4gaXQgYmUgYW55IG51bWJlcj8NCj4NCj4g
U291cmNlIGNvZGUgc2F5cyB0aGF0IGlmIE5OTiA+PSAwIHRoZW4gaXQgdHJpZXMgdG8gY3JlYXRl
IGEgbmV3DQo+IHpsb29wTk5OIG9yIGZhaWxzIHdpdGggRUVYSVNUOyBvdGhlcndpc2UgaXQgZ2l2
ZXMgeW91IHRoZSBsb3dlc3QgdW51c2VkDQo+IGlkLiAgSXQnZCBiZSBuaWNlIGluIHRoZSBzZWNv
bmQgY2FzZSBpZiB0aGVyZSB3ZXJlIGEgd2F5IGZvciB0aGUgZHJpdmVyDQo+IHRvIHRlbGwgeW91
IHdoYXQgdGhlIE5OTiBpcy4NCj4NCj4gVGhlIF9jcmVhdGVfemxvb3AgdXNlcnMgc2VlbSB0byBk
byBhbiBscyB0byBzZWxlY3QgYW4gTk5OLiAgQXQgYSBtaW5pbXVtDQo+IHRoYXQgY29kZSBwcm9i
YWJseSBvdWdodCB0byBnZXQgaG9pc3RlZCB0byBoZXJlIGFzIGEgY29tbW9uIGZ1bmN0aW9uIChv
cg0KPiBtYXliZSBqdXN0IHB1dCBpbiBfY3JlYXRlX3psb29wIGl0c2VsZikuDQo+DQo+IE9yIG1h
eWJlIHR1cm5lZCBpbnRvIGEgbG9vcCBsaWtlOg0KPg0KPiAJd2hpbGUgdHJ1ZTsgZG8NCj4gCQls
b2NhbCBpZD0kKF9uZXh0X3psb29wX2lkKQ0KPiAJCWVycj0iJChlY2hvICJhZGQgaWQ9JGlkJGJh
c2VfZGlyLi4uIiAyPiYxID4gL2Rldi96bG9vcC1jb250cm9sKSINCj4gCQlpZiBbIC16ICIkZXJy
IiBdOyB0aGVuDQo+IAkJCWVjaG8gIi9kZXYvemxvb3AkaWQiDQo+IAkJCXJldHVybiAwDQo+IAkJ
ZmkNCj4gCQlpZiBlY2hvICIkZXJyIiB8ICEgZ3JlcCAtcSAiRmlsZSBleGlzdHMiOyB0aGVuDQo+
IAkJCWVjaG8gIiRlcnIiIDE+JjINCj4gCQkJcmV0dXJuIDE7DQo+IAkJZmkNCj4gCWRvbmUNCj4N
Cj4gVGhhdCB3YXkgdGVzdCBjYXNlcyBkb24ndCBoYXZlIHRvIGRvIGFsbCB0aGF0IHNldHVwIHRo
ZW1zZWx2ZXM/DQo+DQpVbmZvcnR1bmF0ZWx5IHRoZSB1c2VyIGhhcyB0byBjcmVhdGUgdGhlIHps
b29wIGRpcmVjdG9yeSAoZS5nLiANCkJBU0VfRElSLzAgZm9yIHpsb29wMCkgYmVmb3JlaGFuZCAo
bWlnaHQgYmUgYSBidWcgdGhvdWdoKS4NCg0KV2hhdCBJIGNvdWxkIGRvIGlzwqAgZW5jYXBzdWxh
dGUgdGhlIGZpbmQgdGhlIG5leHQgemxvb3AgYW5kIG1rZGlyIC1wIGZvciANCnRoZSB1c2VyIChh
bmQgY2FsbCBpbiBfY3JlYXRlX3psb29wIGlmIG5vIGlkIGlzIHN1cHBsaWVkPykNCg0KDQpUaG91
Z2h0cz8NCg0K

