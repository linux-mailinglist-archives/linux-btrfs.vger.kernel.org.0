Return-Path: <linux-btrfs+bounces-8558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A01B99020E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 13:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12373B2184F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C388157481;
	Fri,  4 Oct 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="io9Jalc2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TOoJydX5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F21537B9
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041357; cv=fail; b=S93K/UCWzIh1u+avoCmuwGM1nwGKvDsdDuE0fJnnXTeY0q0ZB204UPB9zlbudGkpcS6ZrDgDkWLB+FbTb8M5HVQU1171imOWQ4KGwxJXUdBF9iZYJpw4BB401prnGXCVLUX2KysUqH7mXgIdeDJ1QqRPKWVtvxGomxMjmNKhlx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041357; c=relaxed/simple;
	bh=iX2D8ieqVx2nj8JTQ5qEDzfHq5z5lb1xbn1oN93j8NE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=coOgpGlTLzDkTJV/wLky/ixRZ0yFn7zEEb+aLbR/XH8pOyqQ2L8Q0ft9c5IR2E9EOm56pC46j5TYTJuwjQRPHwCqFSMBMQg5GXnjZb3CsQtb6Lq9hxh6mZVGCNUkViLSynkG98V8eSP3q1HpFt4WTRDUYeUID1jjDPvNrwMu/OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=io9Jalc2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TOoJydX5; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728041355; x=1759577355;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=iX2D8ieqVx2nj8JTQ5qEDzfHq5z5lb1xbn1oN93j8NE=;
  b=io9Jalc2gnKEqR/IeRf23Ogu5Cf1fC1DA+aYFjlSNdhJvUr84dFPtbIt
   bvuAmTMypU8WCe/DOHJHad+RplwurgyrU0kzgVktxtGKkClo1pLLRnxNm
   LsDPv1rDjPrCtmQIw4wvGtbNVIhkTLLr+SoWxrR6ih+ZfJEMBoVENHFLm
   tHrjQSPvVc9w+9B+0ymmzR51xpiHiEAt6px7QrTsVL+W81osykcn0+pFF
   Ez3WZtu15GBQPhCWwFlbBJIlGQvM1X9UL/qx2QzhlsG7MxPIoxri1XEL6
   A7761P7/zBLqXUJrE6Kx1Y9hPlGRKT6f2fsekdGKxqQQ5bI3uQXP+MMbm
   w==;
X-CSE-ConnectionGUID: VcI7Qn/mQeS4LOrOk7qL5g==
X-CSE-MsgGUID: XESQbEbyT1qGr4QQ/tBsrQ==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="28252938"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 19:29:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWL0Hcdg+aV+8FyXHFydNTkbxGvYt8N50lRQ5WPA13AlGqPqQQ5EsqvF7+Y1iTB6w+Fi7XFtbV/fNDEhSuKX89qP0PlwYCG5LZx0fuK0YLtsyfYC3/4A68ylDHHh/6ZwXa/cDjGKDhxE++L+8JOEhG9TPLY/bJPwoTxs/w5jkpKnOLwS4DgAWQkfXek4K/fDrL+O3UUiWVfVbirNMatOMRa9YuAzD1pVuoanctTCyXRWCFbaIx/SAKURiD+c9pmqRg91s0pEJuHXtYxsxnTeVIgV4IMVhcvosv2Y/PVtYiOyR1zsghxYfBeX5rpSwyS674C0/0+r9Mu/qYXILQ5IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX2D8ieqVx2nj8JTQ5qEDzfHq5z5lb1xbn1oN93j8NE=;
 b=deAE1trC0TJXOrZav72UzQYacj2qlH+dSjHPqxp8fskMnD0P9BAYhi1X7yG/Q9SP3kifbcJ3Ul7EeLGW/Ep4OG4B0cggO9rSFZvXmP5x+tuYWT6MV2O0S09xKzSwH9YIooFMRxfdbtJDnqnGiWAkf5FXVswDEEKu1OmISCo5ayuZbSDPljOUH1Z6O3jjbRpu7pKEGzv49Wuq9Fzp/ZRGQ4imUmqF9WJ+chwKxFxcAC7/W7xEAuPBZ89rbsD0APc9r+LGPYgRQ2ZC1ILzxFtGkGKW/XW7pmr/k9Cvz7KsPaGxd1OEayPiR1zJdFCus95fGPGPyEYDCC8dzbNzdotyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX2D8ieqVx2nj8JTQ5qEDzfHq5z5lb1xbn1oN93j8NE=;
 b=TOoJydX59Jtbfp7kY0kUGO/P+lswe30UBrK9tvSGW7XL9bSJEPiwYNxgfjgtpcIc8mnKTbet/dN7qTBVSE9NccR1qgoI//Z3fnbt8Upkqa4SVmq3m3pcc0RPQIixihkIPaYMUI3USSNuoVR0yo2CIkrRFjyoINWkjvO9tM38T2s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8433.namprd04.prod.outlook.com (2603:10b6:510:f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 11:29:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 11:29:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix the sleep inside RCU lock bug of
 is_same_device()
Thread-Topic: [PATCH] btrfs: fix the sleep inside RCU lock bug of
 is_same_device()
Thread-Index: AQHbFkdQ7oyJHPHknk+jxOsKLZnmQ7J2dLWA
Date: Fri, 4 Oct 2024 11:29:11 +0000
Message-ID: <27742b06-8b48-413c-ba36-d63c15c7fa40@wdc.com>
References:
 <0acb0e85c483ea5ee6d761583fcaa6efa3e92f01.1728037316.git.wqu@suse.com>
In-Reply-To:
 <0acb0e85c483ea5ee6d761583fcaa6efa3e92f01.1728037316.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8433:EE_
x-ms-office365-filtering-correlation-id: bb302375-544d-45e6-c94b-08dce467c4e3
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHFoNC9oMU1WL3dNQVQvelp0MEFlcmZJWVlYbm1EQ1JtRTlkd1F2dlR6VzYw?=
 =?utf-8?B?dk90Y2hoc2g4TzVBUkhsVmV4bkpSdCtHTWxOU1RpZTQ4aUpnckFnSlY3M1lk?=
 =?utf-8?B?aGswZ245elJJY1hBamlrWUxRUDJObG1ucGpOcGNML2ZOcGlJMlVVMTk1VFBS?=
 =?utf-8?B?Q1ZyRUFrUERCSEdvM09nR0NvOWlMTjBOaVUrSXF5UElkVytIYlcvUHAzM0Qr?=
 =?utf-8?B?QkwzVHhSUHFHUGsvcTN6eHN1eVg4Ylgra1BLTnhTVFc3bWtzWXlZMVdNaldw?=
 =?utf-8?B?Z2MzV3R4cnI5dkRscG5xR3MyQUV1TlhnSzBXMXR1WWVVM0pYT2oxeTBzQXVJ?=
 =?utf-8?B?TUJpOU4rRGtmNDJ4d1JiVDlPc3ZNR1FMYTRhWi96REJRdEd6aWJJM2lBd25k?=
 =?utf-8?B?V3VTV1lNSnhxVTNwcWc0WFBZUVQwMzNXMDV5eWhxREMvb2RHQkw2N3ZhMWNq?=
 =?utf-8?B?R256RUJ2NTR2d01pc1BlbzdKMGtzUzFMSnZmL1FaTlNKMHhTQTV3Snl3WWFw?=
 =?utf-8?B?b0JpalRxSzIwSkkwM2FtazV3SVlTOUJ1MXlpeTZlbFpsTUh1Uk9vZldHcEVV?=
 =?utf-8?B?NWdCbEdFanVWdlpCVHpHNGxaaTFTM1lYZ0E1Wk8rSytXVmt4WmVyWmE5bWhX?=
 =?utf-8?B?aVFFcUM1M3ZtSXFQTGJ2N1hDRUdPZ2tsTVpzUWVySXRJNDZ2M2RJQUtRaU1B?=
 =?utf-8?B?WG1oNEFzOXMyZkp3azFwNittK2dBdVVyekI0ZUJ0QW5qNnFkdVc5aW00RE0y?=
 =?utf-8?B?bmxJN3R6Nk1QOEh4Rk1lNU9ROE81cFNWcGkwWlJQTmNFQ1FjUVk0Z0IrM2Zl?=
 =?utf-8?B?YUEzcHFWaXBoYzFyTGYrS0VyWkt3NnY5OUlhOXpvcnphTGpRcUVLK1VNSG04?=
 =?utf-8?B?MUZuNnV1U0t5R2xEWjhPN0ZkdnFUZ2sxa3ZkczM0WkZaYjZveTZhamNnYk4y?=
 =?utf-8?B?R1kyanBROEhQeTlCOTQ0YnE4emZnMjdNTmlXYXA1ZFdRN1ZXNVdZMVh5Ym9Y?=
 =?utf-8?B?WDM4RVdQc3owM2N1WlFreEdFOTltWjlkK0VoNjdwV1JHa3lKaXFNOGg0Nm1W?=
 =?utf-8?B?V2xTNmkyb2VOUERFc2FZL04wNkNDSjhxMXZneWdJaGJqV0J1UkdVcSt2aXI2?=
 =?utf-8?B?MkpEWW5zNHRpbmozV0c1bnpXWFlVSDNCM0V0elZDT2RoQk9yMlk3QlFYemdx?=
 =?utf-8?B?WDBHcFZ5U2ZTcDJYRnNvY2lKRXhhZWhERTRrL202RGlNazBieGhBZFo1RkM5?=
 =?utf-8?B?elZ4U0dYQjZja2hWZDdQZTl5UmF6N3N4VDRpZXJWeCszbUhNMzdzdVJqUmVU?=
 =?utf-8?B?VU0zMURjOWJ2aGNyaEtLQ1ZES0VxT1Z0TW1zdlpUQmhCcE5QaHQvZ1V4bUVp?=
 =?utf-8?B?dmowak56VmVkdjdQYzh0TGRPNjVSR2RxVkFGZEtqNUNQanJUakgvUExKMDRu?=
 =?utf-8?B?aVJqM3VYYTJTdE12QXVVeXZiYWUrSTJoYmphMXdyYlF1Rm9LNDRLa2k2YWVW?=
 =?utf-8?B?SmFvZ24ya2Q3WGtaQ2swK3NaZXVabEQycTB1Q1I1NGJGKzBab0JRZ21IZStj?=
 =?utf-8?B?L3hCNGJTdTZMc2p4VHIyWkVFQ0wzK3NLUkcvVE5yUFhKdFJrREtyVzFqdjRT?=
 =?utf-8?B?a1N6RGYySHZIWFdEayt0dEtrWWlTWE9mRm5QSUJja3drbWkySUJKWFhlRE5u?=
 =?utf-8?B?WUUyWm1zUTN6N1dnQjRjRXc0OHdVdi82cG0xOWpMUjZVZE4wQ09yTmVUM2JV?=
 =?utf-8?B?VXlEVmxqV0szVmlrNGJxYmpLVnJ6V0s1d3NQSHlpNEJEd0wxT0NmbXpkTlhx?=
 =?utf-8?B?dk1zOUpVbTBRUFdmaHAzQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3B2NW8xcDlqd1NlR2tHb2x2NVpzVyt4c0EzZ3RYU3BVeGMrdkZFbWFTcUlU?=
 =?utf-8?B?aWkyY0xwazlwOHdZRTJabUg0NjRkT05lTExjaDBSb2RFUlFiN291eXg1Tit3?=
 =?utf-8?B?NVlLTm9SYlh3MCtMaTFWb3hZSzZBUUxzYTZObGRXdWJqVlF3WkRuTWYrVm5a?=
 =?utf-8?B?a1QzcGFaSC9vUTNoWXNVeCtYTW1LUHFsYkdyQVhqQVNrcUVXcFN1WjRlTy92?=
 =?utf-8?B?VXJwOXZ5eHhOQ0hUWWtKaTJmbUR2dFRobVN0Tm9xRlNWNnE4ald3dGVNNmlw?=
 =?utf-8?B?L3lYei9ETklKcTVqUFJ0MDVuY2xEeFVmZWkxUzNBc0RoS2pCSGZBVThRZVFM?=
 =?utf-8?B?L3IvalprT0NlV0tGcng2a1YrR2FqenoyZlFWMWZINjM3Z3RBcWU2eGhQdDlD?=
 =?utf-8?B?MnZxTHFJV09WeUN3OThPSDFJR0VmYWdFK2hjU1ZHMDlBc2hKS3VrQWtvMWV4?=
 =?utf-8?B?SEQwdGNLRW5rcDFCV0pzbGR5Q0NYRnd1bEtSOVRlOEVmUGJ3TVVqSkEvZWhE?=
 =?utf-8?B?NEpncUlmVWRRd3RjaXZGekFoYjV6WHdCV3VMaVM3cHZhSFlLcG9ZUm1BRmNE?=
 =?utf-8?B?Skpvak12bDBOSWx0eFpsUnd2NGViaGpiMEhvWkR4NUdydE1CUnV0WW9xSXBm?=
 =?utf-8?B?RmZBLzdMRnVJeVZpSGc2Z3lreHAzSWxkZU9pN0VGUURoS25xa2ZqOTAwZ0Nv?=
 =?utf-8?B?QzRPSU5USER3V1RWRms2d2FsRTdOSC9mRGJSS0pzaFdwTDQvL09YOVQzZVZX?=
 =?utf-8?B?NE5NdmlPeUZGcVo1NXM3K2czZyttTkx6SDl3QmE2VkhGWGJVSjFUY0Q1Rk9Q?=
 =?utf-8?B?OU8wZWpxYkwwZGw5NkxUNnhCZ3ZTeWJ5K2tRRVhNTkdWK3NVM1RIUDZxcHkx?=
 =?utf-8?B?dDVsWTVzNU1ZTkZHSVJheThCNkUzMGJDVy94OUNDZW9aZlBYb1dBN1prZmdh?=
 =?utf-8?B?MXBBNGVZNGErWCtOcGVBZjAxcVFKKzAwd21yN2Q1NnhOM0tvRVZub2k0bzNa?=
 =?utf-8?B?R0dZNmM0cTlJaGxhcDk0aHRPNWxPNTlZM0VGckRlVUZ3TnJaMFR5RHhsb2Fu?=
 =?utf-8?B?MzVacnBNS3dFaUJPYmc4T0V3Ty94T1BnSFo3MysxYTJMQmZJRU9oSFlaMkd1?=
 =?utf-8?B?eDNiU3Q3UXN4SkZnNVRGTFZRd2M3OWQ1YXZrNktGZU4zZTA1SmpxR29NSk5Y?=
 =?utf-8?B?c0EreWJUQ0Q5NFBFMjNYZ0dlendGQ016ODBiUENreTdnVFhpOUU1NkNpK3dE?=
 =?utf-8?B?MlNvUmlsWWg2R0tkb2Jhc01rOExiaE1xMlc1dmh0NCtKb0J6K2hlYnlyZVpX?=
 =?utf-8?B?bllORFVRdkphUWF3aTYyN3ljYWxrdUFsTjRGV2VkRzJ3Vk1EUE9rVTNBZXNo?=
 =?utf-8?B?MXF2SXBxaEVXcUhQLzRBQm9YQ2dFRzNoRTREYjk0TG9FZkpycVJ0dGhpcEJH?=
 =?utf-8?B?N1lLd0tySlhYWFg5QXZLazdrbmcxRDdvUkQ0dVRlRndKdkVWSzlvMUVpQVBR?=
 =?utf-8?B?MHViKzdFb1dFcmNWMWp3Z3AzL3FYWWxKZHdkdzNQL2VlWDdZS1kxdkgyNVlV?=
 =?utf-8?B?WDNrdS9nMitIY1JQVHR6SWsvTk16amFuZ2kyMFcvM0hBcmhobmttV1lQTkts?=
 =?utf-8?B?MWJyVityYzRQeHdHZm50ejdERFVwOCtFQmRVWlh0OStaanA5amVSL0FQUktR?=
 =?utf-8?B?Z3EzMkJKaGhoZ3hwdGQ2bVlGZ3JxSUExbWZNUlFHL0ZMYmtad2FEVTY4K1BO?=
 =?utf-8?B?S0xETklnaWRsOERzZkZoQWlwYUpBU0pJQ1VNSDVnZnhTWWZHeWJqV3pHVDlK?=
 =?utf-8?B?ZkF3d1dUZDBDWlhGUnIzd2V5OWorWVZ0c1BPSDRPZllGNFNLOXlQSVljNG1K?=
 =?utf-8?B?c0RBMll3NGRFSXlWU2ErRjdRZkVmNFJFLzlLN2JjQ2MrWDlLc0hoQm90ZnQ3?=
 =?utf-8?B?YVBZY1IybjZVMk9OaERCVEhXeWxzTytPbElZeFFlcDh6SzNRSWZ6d01XdWo3?=
 =?utf-8?B?MHlaV3pKNDlZZFllekpscjBzakRHa0ZPRG51WEtMMXplWTFlSm1rK2Vac1ls?=
 =?utf-8?B?c2kydXN6NytoS1NtTlBvYnBudEZtTXBXa3R1aStVRDNHYWJ1MGJjcUlqQU9O?=
 =?utf-8?B?cjdMeXRQcXpSeUFWZFVoQjVxNG5rYzlqU3pwSUtRTUxFY3BrZVg5dmxtZ2xO?=
 =?utf-8?B?YzU2NU1kampzeWxhRGNyUnJxYzNoMTNvRG1XV3JSK2tyM3Y2Qkl2Ym91dTNm?=
 =?utf-8?B?RnJuMmJURGJQRm5HeUxkMnlhVVpBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AB622F4CF85EF41B7C96EC61E80F0F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8gc2t9Rfs+kzzZr7OLAgQeizIhb/e4yhx3hxcdgARF/DMI8JxJvbwAtewHMgapOSOD4hetImtF1y7ZXlsFiUbwDyxaJrDNZ6zq5MyqmscKc0yFtr8VPy2lEsn/2MWyzA/VsPwWOJp1+Yd6fXbGcCF8Gnm4ao9nB4gS6aOvSDWCyak6TxMR9pmuQdi7EkMLSEtjBuB6T2yIcxVKlYAWAXS44zTBkt3ZgbRJCAzVs53Yr+Gc5rZez2Vzp4RLwhScBUiQXcEXvyoGMKIJes9j0AdtcxxL8rXIm/1LsCDdNIqNNPpUo4bQ1KGcMmx5Wa6Y/PW8Orpb9JZAfZ+CNmCYZCDxkjyLjF99/NxWTuI/TxI4h9Cz50zabC6PNcSVITkwxv/grbYTC8b6V/oY31LqD0EVanITuPNTLqRyyMlb/troHNVPUxi+JnzrXJCF/Uw9uZJDaM59Db81Gwc7NLNa6ZnxyY6oq/ErXcOHD32K70Ums838Wrk6XRJuMfZEOE6zXvB7nZ6cadjIT4cf3ahMXSzWXuTJL01lVNRCj37UIxDtJDBXme/KG0jsdyivcwNGWfetMyq+PziH7TIRHINKuywQDdKu+2Yqpz32TWbIbucOpTyy65oHi0hBbNUlBkvb2x
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb302375-544d-45e6-c94b-08dce467c4e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 11:29:11.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiBxFu/kW2qtv3vLX0FCVwFpCmjS4rgtitIdZvbUW+s9dB3IGDsKjdjJiGvtiZim6jH95MH9BVeveDLXyj5oPhBkKf9EvjzrqB9vhGPFdII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8433

VGhhbmtzIGEgbG90LA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQo=

