Return-Path: <linux-btrfs+bounces-6357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5B92DFEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 08:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EDACB22250
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCD583CA3;
	Thu, 11 Jul 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gE/ML/Bv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U6ffE534"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78B2904
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678462; cv=fail; b=PjRNYln9tNHSOLC1mRQ/ncVvxJhnNGazVTlpZUZQcDHN5+2Kyb54Em1kv6c4YN5QQj20blf3dP4otYteKlifiKjM4uHwy9wiwDPrL3ZoLhIAtRcrvp8Dh0ICD8ao4yAwF+7GKFXRKgfYggVjwE/drCMQ0sd/UD+KZOdl76L8Peo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678462; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BNNKskS1n2x1g3u/zS2aHGchWrdpaZ/gmIYBx4i7HuyhwOiFkOHhg6tOVK8evb1Rr3L456AaQer9ZCc4h7YLYO+5LeROuzizKYsA/BDp94oju3/rmZvHrOzQKvnAvonhMTrCtYd++KhwfOezdXEaOlj4qYiXOcL49B99UhYiVGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gE/ML/Bv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=U6ffE534; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720678460; x=1752214460;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gE/ML/Bv9S8Gjuv73ThJ9Ge01hafIPZ7nw+BYU/omke9HJjj8Igs9Qlt
   Nh2L2zlkX1bUhZ/LIJ6dOLzskgETkep+SOnAmkCtrbHMiz6gYb41ZqdcZ
   pG5reOOBBUcVTqeFcRFjotDPp4iJkQVMPFDPj2QoRwedGf2iSX9m0jUeN
   jKITKppt3gLYA/uABvhHiGHY29X94jinWTEsunICMJ1BoofLFqF3fGZwV
   yb4KfiWeTkvLUpwoQpylI7DPpNWVb+Sq20fMgu2zJBv2vkCJVTPTeCN3A
   V5i+0NZuWxxTMEEmnjlnQb91x1/u70tPytVfrIjxDGqa7rKPqQRPiva5N
   w==;
X-CSE-ConnectionGUID: xvNfRzBfR6S1edfCJ2FfFg==
X-CSE-MsgGUID: kDtEozjgRKmcudmPaYUeUw==
X-IronPort-AV: E=Sophos;i="6.09,199,1716220800"; 
   d="scan'208";a="21445535"
Received: from mail-centralusazlp17010007.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.7])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2024 14:14:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCRVf4jAAm6Q54tf7zzAtqQ6raF3zEaoS8D/1YbYgi8TM0z06TCJJjRdSv34zMWaTqrU0HwiMWGKvtcoLCJE4o3NwA1kKWonopDq2wtrsmrJc6b1MpD4g0Z7kO560Mjwg2taYDzwNRNUntXjXqMx0/yNFcsH/b2hDczVDLvM62hWGDZZcRSHeEd4XHAaLxP1yhGEhqVfV9Dt7CGrzVKCP2eFr3LG2XGIpP42iLPtbh7EX9gCKVrRkp+ikDhck+Zs59nup4VIHGHVkDH58vkqk6OTg/KbjZhMzrg05iVC2rGh5YAeEd8beAELic6t5GSo4m3RJADzQP7FXLEO6u5VWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NBxhwGfB2E+tigHTYX0o7JoZ1zz5NZFon8VZhWeyvlboMpCqKilMQHP9CZ5Sam5i7b9nYDixl7NDtkmKFWjtn5RK1avtaapCvTwVYENoguHNl6QPc7eM7pEQWUe29Ws3mwCbvT0RXfF1bKU32JuOOO54x46pzV4hwvx4l3k3b5sZoNNFmXQj8T79fYz3Mqdxe+x51ro4nelt1HbNRK8mrKsZ/NQ9+m3BK5C49IycU4Dq/rBQt22HkGSpol61gb8y+mLLB9ONgg30hPixQZpwURl8Y/Lq+fZl9LZQYMbHU5soF1pHndw7nahEdxBn1HjoZCzrTs95GnZp0RPHPb6MOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=U6ffE5345DkSZKtgt9gbUfZ4G0Ir8UgoosiVhxmgEakH7dfy2gWV0zfczeGifsm8PNIYwr9OqIh8v8JZsClkj4nKO8623SFwpHaWk7+n5HVk9dD/5/bj+/+m2Ji2iJof5Ezv9wAn+e9oeRSLgPDm7kUOIfv1D2OakBrYjoJfIWM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7893.namprd04.prod.outlook.com (2603:10b6:8:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 06:14:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 06:14:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix zone_unusable accounting on making BG
 RW again
Thread-Topic: [PATCH] btrfs: zoned: fix zone_unusable accounting on making BG
 RW again
Thread-Index: AQHa0t08HpDDNh0F40GOfu4f2h1yo7HxDWIA
Date: Thu, 11 Jul 2024 06:14:16 +0000
Message-ID: <b9e66490-440d-45e5-83b0-242177b7c650@wdc.com>
References:
 <1626ef0d42713eaa6e050a6a64be8a811446ad5a.1720624977.git.naohiro.aota@wdc.com>
In-Reply-To:
 <1626ef0d42713eaa6e050a6a64be8a811446ad5a.1720624977.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7893:EE_
x-ms-office365-filtering-correlation-id: 5cd785a9-32c0-4fe4-ef5b-08dca170b1a0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVNNQjh4cGJWSk1xNTNDYWl5eWZ6T0dTOElGeHV0eFN6bzk2TzVqRFp1b21T?=
 =?utf-8?B?VHdRcUpBY2pheU1IVVp6WUVpdlhFeWRTSjkzZ2RrcVF4Z0FVUXFaMWRCdXRp?=
 =?utf-8?B?T1FuZlhDMXY4Z3VVQ0c2L3lnUWRLQTgyWU45b1hWakRwbGtOTmxOSXNyNXlH?=
 =?utf-8?B?RnM1cGc3blNMUTJkSDk1VjhLUUZJSlNKV1FVSG9GYWZvbWxCTmx4OVl2eUdM?=
 =?utf-8?B?bGRqV1BwdnJCZUZzRmtxZTBmMGpaM0kyTHBtL2JmWitWRUNCekE3SzZlUzVU?=
 =?utf-8?B?YTJzQkFaekNWWjlCb3RwTDBmaERzOXhLZVhrV2hEOHNHQWhNczh4RDVZcXBi?=
 =?utf-8?B?UFZLOUQ5WXRBdjBudlBQOGxWR1NwOEFlZ2draFZNMStvdkQzWW5YUGtsZnVi?=
 =?utf-8?B?bDR2d1Z1dDdMUkhRRmN3UGY5K3ZkekUvK3lVZ1owclJERTZTSkMrcytva095?=
 =?utf-8?B?ZGV6RStTRHoxWDFxaDJUVXFGWEhhY3BsSFJrSjV6SzNZZURkdmxadHFXcjN0?=
 =?utf-8?B?c29zbjZ4dDR0Y0lXUTVnZ3dOc0JrNEd2OSsyelgveC9MaUttSXhPUTBaZE5O?=
 =?utf-8?B?UG1FVXRpVG85aDAzR05TWnM5dlk3YXVJclJGbG9vU0tSOU5EWUV3T2tMTUZ3?=
 =?utf-8?B?UmRmOHo1UXFZOUJ0OWtYbWRraVFnMVB3QkdGZjZGTy9pcnJuZFJiLzBsWDdi?=
 =?utf-8?B?TnEvbG1GRVB1WERxLzYxMk5MVUc2aCtmTFc2ZFZ2YmhHMEJrTy9YV3lxZ0VM?=
 =?utf-8?B?U1FGQStuZEhlZThOQ0o4NzN2eDVvR0lxdDdScE9WQnpkYTlaWktxWW4xdStC?=
 =?utf-8?B?VTVaQklLc0ZINkV0ZWdiUlZ2S29Xc0xMK29OeDllUkNXdGNVWUEwNVRvejZ1?=
 =?utf-8?B?bkVVVnI0MnR4SUdmNmJxVi91akpXM3hjSWN5czFiQjgzaGtJUGhHcVp1VFhW?=
 =?utf-8?B?TktoZVA0VWtrM01ObFd0VnJHbDdrNXYyU1pqTDdta0c0bG13bXR6dXJ0a05S?=
 =?utf-8?B?a3c5K29RNmw5ZHBXZ3A0V3ZmNHp1aXkxVUZZT3FnUG9DdDhETE1lek9wMlB4?=
 =?utf-8?B?bDg2N3U3aFVud3pOSHljMHNvSzhlMmsveVl4eHlVSDZvK2ZOVVB4ZjZIcUxi?=
 =?utf-8?B?YzdQSDZ5MmorejFheTEzL1FqTFJ2djFmTms4bHZQZEQwUjNTbGlFODRheVQy?=
 =?utf-8?B?RnhPMG5ab1JBdVp2bmROV1V2cU9iMG96alR5U1Y3aFNWejZuNml1eCtUekdO?=
 =?utf-8?B?SXJ2QkR4REFoYkU1Ynl2N3ZHaE1lUHRmc1QxQWNvTVFJYVYzcVBCWWRjZ1lH?=
 =?utf-8?B?a2E3TEdqSS85YWVOVGxhSEgwTHloU0g5ZE9xV3pMVDFxZjJ6R3dsajdVVEkw?=
 =?utf-8?B?UmVMaHhXYVhaMDd2SnB1V0RiYlI0a2t3eEN3dWVUNStMc2lkZjh1K25oa2VL?=
 =?utf-8?B?ZCs1aml1ZHIxTllMdGZIUFY2enREbzZBWncyd0dCZXBrb3pPM1IveDJSUzNl?=
 =?utf-8?B?OGZoUU9QRGw2NGQwbmMxNkNYbjdPVnJPZ2d1WXFkQlVvY1NLaVRTOWFLS1Fl?=
 =?utf-8?B?L0RnUU9iUHNuU1UzRlcrWG43TG5oK21SMkJwZ2JKZmtkbmJUTDY4OS9lM1Q4?=
 =?utf-8?B?eTV2STM2R1hpZFM5NWQ4U1l3WURpbUI1UkEvTVBRa1lhN1czRXRYTGpza0lY?=
 =?utf-8?B?dTNqczBQZm13VkoxeWF6eG5ZT3pTdWJtbG85Qk9iMUVqRFNMcmN1YzNGcGQ1?=
 =?utf-8?B?YjZJczQ3WmdzdTBPSnhaa1B1QVFuQmI2VUp6d285NTQxT3lDakxBU01MamI5?=
 =?utf-8?B?SzVDcWxtdFF2M1hYV0xaRXZyVFdiUE1EV2g2MzNvOXpUMXlkL0VkWi9OWDhy?=
 =?utf-8?B?Kzc2U3lpcU1EeGlxZGxpLy9hRGtIcEFGSi9BbkloR2hmRUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDJ6M25oQVZzZTJpaUZsYmNucDMrNmVTRDh6KzRObWlENVY5amlJaGF3NUw1?=
 =?utf-8?B?SE1RQTJYQjlGWTRJQnFuVVM5Q2xjS0hDdUNGOHM1cWhaUlJXazNESnYzNVFQ?=
 =?utf-8?B?QllmWnNDdHpCUW01N3pVampGbEpCdTVYSW5YOEVkTGZ4S0F5TjNsQ1gxcG9D?=
 =?utf-8?B?Y2NpYTVaSGxkOWJXL245Y1FUckpIVjJiZ2xXR0U3YjB2V2J3aE0raitqQURo?=
 =?utf-8?B?dmVCRzlMKzZtRDJsUENQc2lkK3hGR2w5M2ZGSkFhT2VFVHdDRHUrN0h1ckJF?=
 =?utf-8?B?SU40ejQyamdCU3FDSmViaE1KZnRacHlNWG9DYUNvN3E0bkpWWkJubjRSTEti?=
 =?utf-8?B?dzYrOU5ESHhQbU9NUmZhM0lzUG9tMzFZQ1pPZWlRNVpCajZDcWcwaW9MRCtU?=
 =?utf-8?B?bkQ5WVlERXFVWmRJT054RCswOGRlS1dJZVlPVm1BK0V6QTBxZzF3SU5TelFu?=
 =?utf-8?B?ZS9idk1FbGZVUEh1R3ZaT3owY3YxMUdpVmZHanErTllKNGYzMWY2OHN6RDdz?=
 =?utf-8?B?ckJubFpMdXB3T21CUzZPUzMrS3FmREVuQ1VFU0ZnUlY4M2NzZytQeVNWVFlY?=
 =?utf-8?B?MUhwbmhEOUxBV1ozRVJ4bXI0UGV2aGdHYWJUVG1hOTdRQW0xdC92disrWVRD?=
 =?utf-8?B?UnZyUUM0K1FWVjk5c1FKVElRckFBbDUwRWVGL1kzOHpYR0FTcGEzUW5HYU1W?=
 =?utf-8?B?MkJvRUs2RVhZekRzbDczWXRLOU9VR3o2RkRWVGlXaUNmUjNOdTVMUE5aZ3hu?=
 =?utf-8?B?engzcHd6WmVpdkEvS1laUDBTODd6WW1qQ2ZxeExLazRld3owVnkyNmlTY3Jy?=
 =?utf-8?B?b1lJcFJLTWNYdE0xeVVDSWtLM1phcmgvcEZibGU0MUhGOFpNTURUaXRFVyta?=
 =?utf-8?B?VDJ0WExQa284blVFRUNFUHE5UTlhQ0FpWVNPWFpicHFidk1wR2Q4SFYxNnBl?=
 =?utf-8?B?WEYxVW83VTYxREFqdS9QTDcxV1B3Q0VJNzdhYzVJMUhTRVByZE9pNDQvRHR3?=
 =?utf-8?B?MXg3c1NrWFVZZDVzK1BSNmkyUCtjNmh2bzR1UFVjcThYMFVDSHVXQ1JDNUJP?=
 =?utf-8?B?NHlFZFBodWxjT3M1N3UySUwxdUVvQUF5RVNrZHA3bW1XZ0FQWGlueGx6QlRW?=
 =?utf-8?B?WlRISHNnRmV5ZzBDOWlLS3pQRkhLeVF3dXdCeVZ0WXVscGk4TFlCYWNJVUd6?=
 =?utf-8?B?Q2drdEkvaTBLSi9GUWxieHJoWll1MWlpOWtMd0J4cTJFNUZVdXpNMHozOWxz?=
 =?utf-8?B?M2RsWE9zQThtcWxhZ0NMMVZNbGkwR1ZnVGpTSnA2TXY3MUZNZ1BYZ0pFSi8z?=
 =?utf-8?B?YUZ6eXlsQWsyUTEzN2VqQVJuNHRZUkZLS1lQbkExMGlvdjRxY0gwc3k5eHpm?=
 =?utf-8?B?bnNEQW9UNVdiOVcrUGRRUnBxVk9JaVZ0bm1OS0pkM05SanVGNVlnQ2VaQVFK?=
 =?utf-8?B?RDl3bjQwUlhhMzR3aGRnWDFrMTh5RVlsUm5lRVBrZ0IraG9JRXMyZmxrN3po?=
 =?utf-8?B?OVc4QnNIK1ZEYWxQMTBlc1pTclRiREMyanV4Tkp4Q0EzK3ZFaSsxOTFiRVh4?=
 =?utf-8?B?TzZnU2FpUjZHZ1dRaHcvY3JnUThwSzNSQXBuc2VkWlZQWDhqOTFmYm54bUxi?=
 =?utf-8?B?aVVRdElQWmtpTDRRY3duM2lBcUtWL3RXeW1yOWwzTElTNG1mbG9WWUw1Y1VD?=
 =?utf-8?B?TGNaM2RTNCtLNmcxM0xzT0pEWVZzc09CZ3dSRFdFVlFQZys5eUpKdE9JdXpD?=
 =?utf-8?B?YThwOVZNZ0VYMmIxSTlNTG9nRndKalE3QWdTQ3c2RlZVQnRFOEhnV0ZVUHZQ?=
 =?utf-8?B?alZJR3BmM0RZT2tRa0VYeTZ5NWt6K08xWEVuRlkxbDduVHNBMkVkRk5MUUNS?=
 =?utf-8?B?eTNaUk1FeTdtYkhzU1lEVU13MHdvYm4ydmtXdGUyWkUyY0ozSXhEektUWjNP?=
 =?utf-8?B?cjdiazZZeTNRUXVjSlhINkxWYUF2Z2pCaTNWZldVcHgyQ0I1TUFDelM4cmdU?=
 =?utf-8?B?bWFYSnhKVmNVVllNMUZDUWdya25PSXg3Q0FoOEhtR3BRcS9mc0lSYVNnRm1W?=
 =?utf-8?B?cHN6OXoxUmc2bG1JQVRrNExLOHFSRUYxM2xnT1pSUjVXS2RINzFEMUxRRE1v?=
 =?utf-8?B?RUhib2haWlBkT01VUWtFSndnRmJtOTBHNmpwOGhLR20vc1FldStJOE1jc29S?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CCF7931129CA246A5884B6C9BEA9BBA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a3+/lSFcNj63PDlmM24nTgTOzNw/Cwtun/Rw4i3/7rO/DfVhKXfGa3McZNPgonVgn+yjgfDjr+trfnIZMyVB08fPYrxSN2hlPrHI4z7scOIrDRre3IP6NTHfVNyO9iED3vSzVRUfo3/wWpSuKMwXURy8Qrvk5va3NqSiZDriYbIWfN3zxpY69sk3XwJ1+Hdog45nzjRthVoBsfpvYNoxhnBojzVP7eQ2GgEB6T2rckdb1AE8iI7WlGqsEP6FssBEjVmLiE7Nd8OIiRVY008X1NdEFgwhJa22q/pmtFmuzjCy3+VASd6RxdPBbyqNe4ZNiaYkghC1Hu3UjSL25LCpi5lOv/QaCVThZQqzAAjmAs2W5CWoSoRb3jrz9OHP3zBNBdmFemSRj56RMb/SzbxgtQnrQdlEmktoclBPNiOLGKYCpgxRc3vsbH9wvmFxhSf1jBciSIm3nqq4y5SlC0QOv4wElJQvBarb5xgQYQtCKLhK9FP8cY/6gvQvL9k0rF04uR9AaEYahThH7Iy3nYtbXBXX2gVnwSETe+qyiiKojfktTlZ9qvaNB9E3jrS+iGPfuRsKmrLKlVVHRJGmp5TWpOpmIvqeYmNhhHULbcN34FXaJ8tlHcQeeT6uZk10hQlp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd785a9-32c0-4fe4-ef5b-08dca170b1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 06:14:16.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsO6bmSiccXXiHKBsBuIvadR0FHLeTgaoirzlWa9DwsLQpUgfPZsQa7rP2Kcdi1zwHbbKmQJ9KQtQGdQux088LMtrXIrz0qrLoF9zjLfBLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7893

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

