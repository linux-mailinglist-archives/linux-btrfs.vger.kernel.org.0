Return-Path: <linux-btrfs+bounces-21610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P5qCb5Ji2l1TwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21610-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 16:07:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9502311C438
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 16:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15F92303748E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7537FF50;
	Tue, 10 Feb 2026 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EdZW6VJR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RFeA2al/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC8366DDA
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736048; cv=fail; b=ZHnzdL7RRd23LFN3hZQirpCOG+swjgh33Nq+lLvn5UZDHddq9VME9ss4KBbdHrO9ktm9jLTpaYcdKnYphooBF1MWHZYq1j1zdJe3qfx+wYt/qtHLkgRbWpC0TUpWLc5V2BX1n4j5o+rKLcjqXJGii5UEzlv6A/p45E2YSxFYyew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736048; c=relaxed/simple;
	bh=YqLbwk52rgU6y6va3t1FA7Bj58xrlE4yKxjrN6cp78c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hAvBy0BWBL5CgC6i59jewWZmtQZhIB19hTZ7HzcYqAtKo9Rc3c6HTgRe4GJAp6GlGciyRQ8P5x0djU1NfL0SRKzxsqDoA3/WR/fMTB0x9lODr7J3dxNRELR8RV7/u/X75UBF19uevvLT7QmH1fiirNNuOkRC95ZXmI+AfCYqtg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EdZW6VJR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RFeA2al/; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770736047; x=1802272047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YqLbwk52rgU6y6va3t1FA7Bj58xrlE4yKxjrN6cp78c=;
  b=EdZW6VJRn09tTSXVjQiHa0MtstYLYjDOkIHVZLa/VrTZNhZdrRjOXsry
   uvlLjw8V6NlaURtlgaPpmYG4A3FhabVPnebjPQpFuSoyVz5WB4pwj0PyB
   UcVNZ1Yzjbdx7AnGv3ohSyuvQ+9Ow1nh+r61CeBG/rbbzNxIadd9WQkA/
   GDhBLPNVeGbJzZTbyKJAYzRN2W2+D4XVsLzm08JC6XeaedjVG5jyKbi/i
   IUzl8wlkqEGNLkdReDazB8vnGC9H5DOTBbVCSu6wXeEEVtKwSiEEPDFnR
   GBeiFwGV7pYBJnRWYyVCUTOYcdR/96TkuyPzHFLRPc/Qt95XcQdi/ebH3
   A==;
X-CSE-ConnectionGUID: wRQF1iRXR2yetd7wzCEw6w==
X-CSE-MsgGUID: H26o4M1RQxmtwN4pETzVXQ==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="136962511"
Received: from mail-northcentralusazon11010050.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.50])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 23:07:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOtZkMj9iIu1c1xRDoB5oGQz6xouwprry0vkkmbl3VgtY9h4cnWs/Ae6lmmPSZGZzkDuVzOmkMoM15Kb4ggyIhNiqc33Tv22gcfcw3dT8r+GKOtmCYcVFy3yVJs+cacR2Hs1auOvuK3jnb8HO+kbkvWCqfD8iBoCJ/eICWVXPcmq2On7ZvR10lhqDGaAYQNSKObwkoosnQcm4lVt/z9IWV9cc8wPwywbfTyXvM9AS6osAZA9hqidqVRpHVyHRPw9AAxAxKCH6j5jt/sbLxFTH4FEqVPjjzVi74TT9MPhryL8oe6Nqoh2Y3+ZSKoAqpZXXOdgN1M/LeN4Ojo/xhwDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqLbwk52rgU6y6va3t1FA7Bj58xrlE4yKxjrN6cp78c=;
 b=eOeyaw2bVUOjejuwPASlv9CA1x4g/AxwJ+blznzfGGQJbWCQ+WmStJF6vXooW301xBxNQkdIIH/52c6Nc9hh36PDq/xs5owLewPw48ix/x7bRFUCP2HkhZoImHSVm2qXcg5BYxk24f2SzmBCZDg7y8Kqq5Xt/iq5sb8JgRJAzCGmLF2Men3EpgOKD6ZSdShXP8eYQsT7SeRJXBvPTXG0RG59YPiiQBkPOdmXodbNggPg4NZtEmtWqoyPUtKdixKJUNaFhgW7qNTgYPGZCWVjCovwsNAh3P1GOWkcp9D1t7+JQgnAt6QhwhX2nR9YNohLpbJ3sQHOzxTn75gf6eVtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqLbwk52rgU6y6va3t1FA7Bj58xrlE4yKxjrN6cp78c=;
 b=RFeA2al/hZHhp9noosONyFE8g16IdEWXQa7kDLtndQoigp1otLkzevH7OsRtd594F5PsJfLstAFvlKqJccemNXPwMbOajjEFDQma1xuE1AploKARrx/G2DohkfFcJFpsGkXJQgYhiJ5zGhOK4kWQYoY79TR8+FdBcRJamCGtLJs=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BY5PR04MB6946.namprd04.prod.outlook.com (2603:10b6:a03:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 15:07:22 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 15:07:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: change return type of cache_save_setup to void
Thread-Topic: [PATCH] btrfs: change return type of cache_save_setup to void
Thread-Index: AQHcmo/x20vAQS9iokmcvPzO1iST1bV796QAgAARJgA=
Date: Tue, 10 Feb 2026 15:07:22 +0000
Message-ID: <dbd13d56-2b5c-465b-bae6-846274716879@wdc.com>
References: <20260210131946.286557-1-johannes.thumshirn@wdc.com>
 <CAL3q7H7ZLe9gE4rYsPQr47-3rg5ozA29nXEN4CQ0q5D+WyY3Aw@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7ZLe9gE4rYsPQr47-3rg5ozA29nXEN4CQ0q5D+WyY3Aw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BY5PR04MB6946:EE_
x-ms-office365-filtering-correlation-id: 0dab9c21-be48-4976-0dc9-08de68b617d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|19092799006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZC9OVzU0Unc4SDhraWZQV0krRHkzM3JlazQ2ZG8zUFloM0RIRUwwR3U3UFgy?=
 =?utf-8?B?RXJJSCtBNWJWS1ExOHJLbVovYnNyS0RKejQrK21lKzF1MGxmcWZSOU9RSlBq?=
 =?utf-8?B?d1hJOTZYNHlKdVN0VWdxcTQzUm1Bb1creCtGZXRTdUZIMFE3eHlQTk8yOVRP?=
 =?utf-8?B?bjhnK3F4VmdwUjFTM0h2MmRUUVIvQUlvQVM2T0dvV1k3R2o3QThpN0gzbUl2?=
 =?utf-8?B?WVBSdWFiU0FEdXpJcG5ZZFhOTEFrQ1BScmZWU3pxWWZ3YU5KZFJibXlQdE5Q?=
 =?utf-8?B?dkJnMU1iL3VNTENuNVJxNHNqOFQyaDI5YTg4MnpPc2lhQ2xCQ2JPQXNKU1Rj?=
 =?utf-8?B?RGN5a0lzN1JOWENzS3VlTDJnOWFhd05qL1NCcWdiMzZyL0IrbXhmcGpEakRk?=
 =?utf-8?B?M01pbDlJZE9NU1pmbTQ4SWpFVTR2UTFpdkswMlFDbTJkZkNXMWs2QkZGQk5j?=
 =?utf-8?B?OG1FQ2RFc3c0MWNmOXI5ZkEzRTZmVlBsNFJsTnFSeENmcWdWdU81WWRFQXNN?=
 =?utf-8?B?ekcwY2t3cGxaaEszUXZxU0U2UEFSVzltRXIyOVB4cTg2YWRSNUlWaE1NVXpR?=
 =?utf-8?B?WmtPN1pOZE05TGJHMzVQeTBUK3AvaThRejRqeVNRcjA2OUV1emR5dXhXaG02?=
 =?utf-8?B?M0QrRDVZcG1SU215UFN4U3FJRERJY293dngwY1JWd1VJd1NsL0VkWlltUVhT?=
 =?utf-8?B?NVNycU9HWVlNenhkV0pXWi9nMUpBblRqUWc4bUpTdXFtZGNLSENSSDJ0NElO?=
 =?utf-8?B?U0UvR3JlV255QWpuZ2R6RzdXcFVIVVZqb2VCZll2Y3NjdkY3U1dwMW5RM1kw?=
 =?utf-8?B?S1h5a0xURjBlREFHU1VCRDRZUmVrMWYwMVNhblRBSUdrWW96UFEvcEszN09L?=
 =?utf-8?B?MEo1R21LYzk0QlVVS3ROdlovZkpubm04cmViVDFnWi9kd0dFWEpaZ1Bmb3VO?=
 =?utf-8?B?b1hhcmRZaWdCRnhURmswd3JMMDFJZlRPOWsvZkU5K2NWUXQyaHUzU004c0NF?=
 =?utf-8?B?aEZEUDRYWVVNekVMTlVsVUVIY0RXYzVLczE5R2N4MVU2OHRSOHFkb1d3WERK?=
 =?utf-8?B?SEZoZGQ0TmdXQ0J0STRVVTVLTXpDUVdUNGx0eVUrL0hKQzZ6VFRzaXZiVWpJ?=
 =?utf-8?B?R29PUTl0K2ltQTkrNDZnTGZ3ZWV1d1VUelNwRkROclBDbk9WVlFBRksvSG5P?=
 =?utf-8?B?YkNabkJPMUpyK2x6UGRjeFZIS3RLWG03Vm95eUNvVU9iZjJVYVBvVHpRdmpQ?=
 =?utf-8?B?eHNjWkowSzRaemRDbWhvZ2hlZHZmR0x6bVUvY3NZRFB3M3hIME9FSFFGM205?=
 =?utf-8?B?Z0RWbVcyd09BSGRKV3Nid3Y0eFJSWGZNdy8vcTlCVUNML3JJc296Unh4V3c4?=
 =?utf-8?B?cEFjRlJDL1MxaVIyempPV2pKVjBrTzJJZWlRd0N5bXN6WVZzOE40ZnQxRkxQ?=
 =?utf-8?B?dWFXbzlyc3phZ3AvUW84UWRDSkhqUXQ1M1pNTDNBMzRUK2hkK0JaNEFzdWJl?=
 =?utf-8?B?Y1J4dkd6OWZtbm9hZ3ZFNzcvMXlYYnVXb05kakNMaTQrcUx2aVZseE9EeUJu?=
 =?utf-8?B?K2tENGxxdit1UHVMNFNvRjA3bkVwUWdrVmVhZHZvSE02Sk1yRi9ML3dQeldz?=
 =?utf-8?B?Z243MnZsOGhGemNuUzJCekNXc1NxNHZXc1dRYjJlbGVGOVZQYmR5amk5K2JX?=
 =?utf-8?B?ZUF2N0JSakJzZ1dtb1FJU3hGWmtiNDluaUdwRklmelNpWmpraTJxcHB1bElw?=
 =?utf-8?B?T0NXNkNGTVA1QlplZGJsbWRON3Bjb1IzYnVFd2xWSXgrWWtHQ3FZTFcwWjhs?=
 =?utf-8?B?R1ZETlJ6Smc1OW53aGZCREpOK01OT2lVa05yZWdWSGxyVStoMVFmTnNGRnBv?=
 =?utf-8?B?Um1qSjBKRFRnRlh0Tm1xcWZwSW44QzAwbWx5UzFWWlZBcXFqR3pXK1lYVW5T?=
 =?utf-8?B?THhaRThQZU95Q0REdk40cDQ1KzZWTjlYaktWSGRGQTFIdUMxaHRUS2dEVFdI?=
 =?utf-8?B?YkFUeGU2QmRHMVpFYXB6YUl4Z2hQOG9KckFsSU1DQ09DbUhjRTFGYTF3VHhm?=
 =?utf-8?B?K1F4eTkvNzhMM1BUeGpOY2lDczFORTdnWllGU2JYc3hBaUdHUExBdytxT0Ft?=
 =?utf-8?B?Mlo2K0RGYWMvQTd6aUEwUktCQkRXMVdGUW52L3pCeXhSS1dETEs1cUloVTRq?=
 =?utf-8?Q?qJ1N9acFgbEAbzRZbufgE5o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WCtOQ2p5d2tpcDZYaS91cUp5KytrSHhpYkR2RXg3QXdoWEhKSUJIaFJhUWZh?=
 =?utf-8?B?d0Y2dkNINFFMd2FZTXkzK3hHR0owU1lWaTBqZ21vUTFXTWJSWmdvZ28zNmsv?=
 =?utf-8?B?aW1abG82MEJ1MlpLTG9PSGV3NHBFR1JlcEhOaXJpZEUrT2pJQzRtQmd1dCtX?=
 =?utf-8?B?bUpxbWNVdFY3U1VQcmR2SnBnVnNUaCs3ZjdlTk5MK3RZWUM1VU1Qa1Vleml4?=
 =?utf-8?B?OW1xRlZibVNxQWxSejA5cnlyQU1MR2pmSHp0cTduS1VkSElkbmswcXN1Vy85?=
 =?utf-8?B?T3FLeFFQdVkyaWtjQ0RNMy9zZUp2dnh2dElLcjZRcjViVUthOFdrTngrOEJL?=
 =?utf-8?B?UDJBY2Y4OElMcmxrbWNLclFsZDFUdXJSakdTTWVRT1BiQmJxSXdvYkFhcnlZ?=
 =?utf-8?B?a1BTRGpjL3RlaklkVEpQdkY4NWFMYjFtUzdJbXAwNXdFZFBRMm8raG1ZMTA0?=
 =?utf-8?B?VHU1WEhnNHk2SkJ0QTZFWWRNRkZ5bTY1WEIvNzJ2bzZXbTlXbnRocWNjbmdh?=
 =?utf-8?B?MkxjUXpzZ1NmV1Q5cUZLYlFxaEtpMTR2K2RDQzJWYVhtdXZjRjhDL2Jlc0o4?=
 =?utf-8?B?OEhpb0cwTmM2ZUs0dDY3a254MUt0Z2ZOaHVRdXpGeTlwaUlPck9qbnJSV3p5?=
 =?utf-8?B?bmtZL2IvTzRpUVUrR2U0K3o2NkZVd0VwNWl5Q24zYkFsb1oxdkJ4K1IvS3dG?=
 =?utf-8?B?OFFWd1E0eVVkK3V1OC9IUEFacFNTMGRTQVp5L3RnSkp0Y25ncmI2czE2ZUJG?=
 =?utf-8?B?eDU3STZ3ZzV0dXJRNWhDdWxKZWxPK0dSUUlIZGg0VGxKWmYyT3lCd0l0aXRP?=
 =?utf-8?B?bGV3MTNvYTQ2VTNOVzNpalVzUGtiMC9pclJ6YXRLYUNOL2ErREJ2bmxhZmhU?=
 =?utf-8?B?c2ZxQmdIVUlRZnZITE4yanVoa1FCMUdJUXl2OTY1RDVtb2FRcEJ1SEVVMWcz?=
 =?utf-8?B?bEE3ei90S24zRVVsc2pCSGpFMjBianUrMUZBV2Vqek1RVDlhelVPMG9VMXh1?=
 =?utf-8?B?dkMxcXJ6Q1lvWTdwTzJnanZrWkJNN0RKcWFrTVVXTFprUVBqcGFEbDhVblA2?=
 =?utf-8?B?d2JXQnNtZXgyM2JPWU9MYTE0WTVzN0UrQVQxMk5CSytFay9FOWwrVFh5bDlp?=
 =?utf-8?B?S2dzUTIrRWFlTm5Xai9lN2ZOK0R5Q2Y3SmNrRXhJT2lSUUE3YWtnSXZ5dHJu?=
 =?utf-8?B?OENHL3JQSDVuSHpuRFZ6dWd3bHFIK1VKVE5rM1FpOFFydDQ4ZjZLUEFVTk1n?=
 =?utf-8?B?eHVoVUEzcExlZFdJR3FmRlo4NHBZNFhmUkFVV3N6OGt5NWZnTWRWNjQ0Z3Fy?=
 =?utf-8?B?Q0E1SWtPUFJ1ZlFCbUpnSVRFSVd6bkxUc0YyVjMvS2VNRHdCcXJhYWVCK0g4?=
 =?utf-8?B?YnFjUWhNVTFDbkRPN1gvYTV5b292VnVIdzZuRzBaQTJ2UzRUaVpqbnlQNUJi?=
 =?utf-8?B?NjlVRVB2MWROQW82YlBzWjNYaGxndU9sY0Q1TUFsM05Ub1V2NUJ5UnYwbVoy?=
 =?utf-8?B?NG1PWm9GMVBGeTRIT20xMXNySU5qa0U2KzhEMDh0YzRYSXhkUGRoWjFzWWZR?=
 =?utf-8?B?U3VYck55ZkYwZml2aVhzeEp0NEkwRGNtdmdmVWROczVQajJhT2FVU3VQOHU1?=
 =?utf-8?B?UHdydWpOUmU4SGh1c3J1Y09WRnRtTCttYkJsZll6QzBUSHVZUXhDOEtBaGR2?=
 =?utf-8?B?UFNYSEhhVVRpQi9wK2pVdGZPZHppUkNoTHdyUDdFdTNMSUY1aGpReG54QmlD?=
 =?utf-8?B?WFZGMWN2TjlXVmVHVzY1SkZCcm5CWEE3RXB0WGF0Q1VZS3NzblZQTmRMQzZ1?=
 =?utf-8?B?VUgwcGowOWtjbXhFWDh5L0FJLzFMN1pQTlpOZ0JrYTh5YWRCbkZucmtJbFgv?=
 =?utf-8?B?d1NLTElTYTZXZmpYK0RZL3BIQzVFNG9DNzFaUkRRMGd1Z25oa3JtWjZ4V1hj?=
 =?utf-8?B?QXJtREI3MFhHNjFaSENIL3g3RlBneEM0NE1XamtaRzIzSDRlYzF0MStTMlFF?=
 =?utf-8?B?L3UwSnhOTEdjQ1cveGZCaXEvdHVOL09ORW02L0RVMzhIMllxUzlkRVZjeE5y?=
 =?utf-8?B?Q3RHWXdqRWdZbjU5VmdHbzBRL1cyQzNtY1pTS0dLVUJoNWlSNnhkaTc3M3ZY?=
 =?utf-8?B?R3RzQjZqckNIQ3JVRVY2Y2kwY005VS96OElGYk0rZzVqM1ZtajdON1c3bUdK?=
 =?utf-8?B?VkFDSSs3ZldzOVZIdDZTenNyREFYdVYwajBpRXZsVmNMQndSTGJwSU91dVQ2?=
 =?utf-8?B?Qktoc1l0ajdzRDNybWZqTTZXS1lMV2VWZWtGK2I3M29uSTdlNmNwdkhNdE1s?=
 =?utf-8?B?d2xCdW90TEUwdTVoRUk2S3l3ZXIyT3ZhTTNCWldLbDVnMGhSVGl2bUhjcUty?=
 =?utf-8?Q?DKzdTqGtpk/AMjLWBqnFLFQieLUCJhOl4dsaIsDdN9xTT?=
x-ms-exchange-antispam-messagedata-1: b/0h5frluuHzUhK1lR3RCu/2vx2/jDnRjNg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <780490025C74A442BB2DBD9DCDDF4828@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+k+aF0+vIBnEhBZ/yS7lQDpmyeBfwy/Y/lddxnWMjbIFHjfBqOGV4NyOl90Iksg+ehkayMcuqYMxFVWJinEnl7688x15A+lHwJ5XtufCCryBCe5Q14ZC0cXVj7EzoG2iUrpBV6RPqJ42qL11dbZLm4BsG+R56LwoqN6Z7G0jVVznrM7tIR/WbOPtxpeZ161MlhJIZ+hdgtSkBimdQvt3tnP+xblyD7yjoBJ6TV35Qo/rlkpZKNCeTMlFzznOqvejLSvybfsd4063fEj5PGphEonUM2+ARbcmrSqmodJxCzLWFReh6Njt7UEHPlPAuLIiDKwpoVn6uYWxb5lDdRaPge94hNFxl+Bp13r++RsvdP8p0C8ovfkxMdOdcLOVtNklWbZSa0s1a3mZetikNFaSczqrHBmSb62htU3fv+ots3DbaZejhA0SoB9+PvXJpdcokoJFg10k9kLv7v9Y/7aErnBhRVLCMlMmogVHMP2jvIOh5WSshOOLOc6wdnGtg9uADFHrE8ZPksQfrLPs8TyUYwEcP/85sxCDp1KA73/gcTQ6vaq1LcaTEBqdrtkQiZSdZiZleDl6orFJKojQ7Jr8WOnP5GRFoj9S8ibY49a/OikwVcXIn4F5SjHUP7spPzWE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dab9c21-be48-4976-0dc9-08de68b617d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:07:22.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Cck6Z34gJzKAROqk9oFtmnRrBW3vgqnCMvom6YvF79LaXLy3FgqMUoh63rxma1b6ILJqBgzMsLlCH+hmc0Fpq5ZhQUt/KXHoWfEzXu+Lt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6946
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21610-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:mid,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 9502311C438
X-Rspamd-Action: no action

T24gMi8xMC8yNiAzOjA2IFBNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPj4gQEAgLTM0NDksNyAr
MzQ0Nyw3IEBAIHN0YXRpYyBpbnQgY2FjaGVfc2F2ZV9zZXR1cChzdHJ1Y3QgYnRyZnNfYmxvY2tf
Z3JvdXAgKmJsb2NrX2dyb3VwLA0KPj4gICAgICAgICAgc3Bpbl91bmxvY2soJmJsb2NrX2dyb3Vw
LT5sb2NrKTsNCj4+DQo+PiAgICAgICAgICBleHRlbnRfY2hhbmdlc2V0X2ZyZWUoZGF0YV9yZXNl
cnZlZCk7DQo+PiAtICAgICAgIHJldHVybiByZXQ7DQo+PiArICAgICAgIHJldHVybjsNCj4gVGhp
cyByZXR1cm4gaXMgcG9pbnRsZXNzLCBhcyBpdCdzIGEgdm9pZCBmdW5jdGlvbi4NCg0KRml4ZWQg
aW4gZm9yLW5leHQuDQoNClRoYW5rcw0KDQo=

