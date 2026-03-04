Return-Path: <linux-btrfs+bounces-22216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCbKKRfXp2kRkQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22216-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 07:54:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B01FB531
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 07:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B2723020983
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A091E37F012;
	Wed,  4 Mar 2026 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WhJ5VDTg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AhjnDmPy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E129B8D9
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607250; cv=fail; b=JRIHCknqo/FrmtRDk1Ay52aah4S+IZYpqLEMh8SJL8Sbna0D6q22uy6+8/ytjz94wNkDvnptPph9ElOyLSdF0K5YLQd3rlug2N/41gWpNFBhKfLMYtaaxK9ZlG1oqShxu7P70iyORuAqZ9B+9OdkojzklXksdHF3GykTsxx73Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607250; c=relaxed/simple;
	bh=PSZIQptiEMxQQvaEwuUAR9dOf/twKq3yDhX6YFNNUMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jcxud7g5NmPg+Cs13Zg/slz43NrsSfm19vHYkdNcZL4TKxQYTmZBOPADWEfF/daXnhinTjNMjtPHPodW07d+Qy1T975F4WvJJ7P6PIwVmuPSoRr1qHMN7q5ONZ5bDv3ZxW5zv4IYjtr315fTKHv0gYrX6AX01/7U7qt3eefLZTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WhJ5VDTg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AhjnDmPy; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772607248; x=1804143248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PSZIQptiEMxQQvaEwuUAR9dOf/twKq3yDhX6YFNNUMM=;
  b=WhJ5VDTg+kG2SYeYjT+IvWz6hkAC+xDLPx0w7W8FA4knq7Tpr4/v4Vr/
   mcS3FILjNOs5ObzatESQ0J5WaNgb6wyRsMB+P8aBzcUqomC9IG81UFpaS
   omHvL4RaBla4I/1O6P7rnX79DZj08IdpPBmBuct1NN5oVYAcYbvQgKdWU
   wkoAU9NnXF6/Dalfz2O1VKu02nxu6XB+KB1kT7bdzi+apRNifyvDvNG6F
   FJYFqDpjheRpTFfmAwqMyEkOxvZsPn4/XnRKdhkBIAfe/NzMIU/jkL+Qm
   nY/AnFhG6RqlkMRnLEd0EL9tWbr1niiIQcM2TePnT4JFITjUaCEu780Ti
   Q==;
X-CSE-ConnectionGUID: Ldkp1wi6Su2xKXZJjrtEVw==
X-CSE-MsgGUID: iA2zonpSQqaiI7EroLAT9A==
X-IronPort-AV: E=Sophos;i="6.21,323,1763395200"; 
   d="scan'208";a="142998359"
Received: from mail-centralusazon11010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2026 14:54:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOHsAO/gmjyMwfx0Fd5QEuWU00kHZ6VuxNUnRcS/Kx7s/fRL5n4W/8h63fyfskAeJB/opE/O10I8NoloUJvgsQ1S3IrszT9ZN4/NMOinQCX/KehSwx3KbPMnVAokfOT4wIqJ3EjakYmXwlxYHQb5Ueis1IxGv0mU0jPVs9HRHV1qzi/XgatiV05cQXMHGjlg2f+IePB78VsOyyonDyjO0oHgUtc/ElVNPetJvJ+7IuYJ4QKd1n4BpAtwsUFYsX7ApanAUfi6DMjNIWfPq2k4nplu6P9eTkS7ZXxAhHMVJSAgEUVDdsbvccCkPd4o//MipyCPX3Uq1W6ZYxeJ/LvkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSZIQptiEMxQQvaEwuUAR9dOf/twKq3yDhX6YFNNUMM=;
 b=x5KE9hwHzI2OKcyi1EQkt/jLZPeWzzg7/h5waSmm/ZrbwburLst0B20jrGBQQTxcYZWN516raHRGvkaLn9bwlnq/LO4cr6GsMaXll6xuXbt7s90690JmYYbv5bRsSIhmGh8fF1CCoz4TsL+xYUHR72vqCT1SEt0l205ywZlkdValohLDeJUw2azxxI5cDY9CYId8XgfOI6lxHNunvgz0U+zj2DQTkQk4YkgVkJf9Z0kSHph3l3WBNVzhJ/ynBUNVzbLXAti9i4nnIUPHIfsxkPBNOAk2R6gFXJ8erH6EhJweI+QCp9Yjn0nEec6Mx+o9HiRMhNFvmeDv4jIOG07WkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSZIQptiEMxQQvaEwuUAR9dOf/twKq3yDhX6YFNNUMM=;
 b=AhjnDmPy1iLLaHBvqLPksMxoKcS8z4aaQbaI6czboQaOvTJ8NqEdvJDJipRouPjxRBxf0x2cf3gJoBBNtUb94/y/vk96j+NGuu7gmLrh6m37Qio4LQ2EpQvnTxGjXv5YMVTzT0Y9Z35oRNN4Xn3QuiSa/8kxRejUnkvJrAZP0Bg=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7885.namprd04.prod.outlook.com (2603:10b6:a03:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.16; Wed, 4 Mar
 2026 06:54:06 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 06:54:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: don't take device_list_mutext when quering zone
 info
Thread-Topic: [PATCH] btrfs: don't take device_list_mutext when quering zone
 info
Thread-Index: AQHcqvwIxlw4Vig0Q0aLh3/Hy4muarWdkmUAgABfAwA=
Date: Wed, 4 Mar 2026 06:54:05 +0000
Message-ID: <aaaf5965-235d-4dbd-a854-b13be2a7a8ec@wdc.com>
References: <20260303105346.215439-1-johannes.thumshirn@wdc.com>
 <4586e122-f97b-4db8-940a-05dcf04fafaa@kernel.org>
In-Reply-To: <4586e122-f97b-4db8-940a-05dcf04fafaa@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7885:EE_
x-ms-office365-filtering-correlation-id: e9dc78f0-758d-455a-66dd-08de79bad397
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 HVMvlODEIALe1SIgSrB89Gor8a7731zCnzKSqMHOjBattRaMqJKYLmCIZIPs64gI+FR2QOLRkPxTszQsVTGqI0Y1GJfLWJ36+9vLwBQCJ6cUZ821UW9ZeJEP4hSy5BimYau2OHKyoVAjOskqfB5ISGDTusxx0Xr/BuwQR4wE5teVxkho2DNzjnQ/01i3WM2DDctHk5KfG04+NPb3fJfrtgVCrVNb/zD6DlDMgg39DH4f00vH3w2HOZdtMBr12V0rXEy/bZY9JAWrg9Iy2HvKXabH4/Hobz+DJ43qWnE67y4zMa8zCzGeYuDhSJb75WDf+FZZTzzFVooFITVb9y5HKegL7Z+s0RZqHCCalPCcsKTrY1NRE3Qt3QZPPEQRLNAbuNpt7Xy+zDDQ199Vvocbe/Tl5GwQg9ISzeKHOoVI3QQ1b81ZxnzzKn1qKxE2excIw5Pp9IUaOOrHmXskux+nfOiewkC/9ru3l9yquvtt1SwlJrVebCCup0WqFZK3o+t4AwnQeiY5cX99uHl3lupdpV5zh7TYhgv6cqJ0hRZvFwLdxde3xDa6wd3aR27dG7CzdBiNwMvVoxrcp1SykmIt6p9UdB+9+bMFper8AX42AHWtQIUtCKAFx+8sLHbWeKK3vm3uUjDijCMOVCu3LXcdpV6edRHiuD5vZbvhd67uCrzXDFYv2jhbQSbdJMDcKZNvRX1LQvq+uioIAYmJki4EVDdcTBcA5V25wFvBzSMMFLeLPKCPkAQlLlE3cI/QF5IIxE0tl4Q6G822uOgtCT+QmiF7tzupxLgI8ld7PcvWh6I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnMrR3RjQjFLeURoMkNibGJhSkZrWncyRlZ2NVcxS1Y2SEQva2tGbS9EOG1Y?=
 =?utf-8?B?YUkySjhFcTN2MXI2cWtqZW94TVdxb05GT04yMEtwQitHQ3czc0lsb0ZPNXVz?=
 =?utf-8?B?amNnbUJSMXI3T0RvV0ZzV1FXWU5xNDVkdWwwZmFUMnBVUDdXZUNURnBicldG?=
 =?utf-8?B?SnNBcnp3cG5Fd2dyR0xtbitZMDV2QUZNaklzWVJwb1B3eVJhREtCWjN3dVJJ?=
 =?utf-8?B?eHVMSHVPVUhRdVNpNW1WUEpiZ2I2dWdKVDE5MkZqSzBYd0lmVVhDdEZLblR5?=
 =?utf-8?B?cC9XNVU0bUJuMVd4ZHVhZHFRQlhjTUNXVGdaMXY2eFhyS1V6OU5YZVpXWmlw?=
 =?utf-8?B?SXluQjhHdXE0dzRieE40eGkzanQzdnNwTEhZQkFiVlp2VWFScHExR1dVUDJw?=
 =?utf-8?B?OENYVlpwaS9jbzYvWXpPYXRtemZmRW5LejhBaEpROFhsMTM2T2lyUGtoR0xj?=
 =?utf-8?B?a0pjZ3NRZlJ1MXFzYVRnTk16b0ZPOUxTL1FxOFRTMlN4ejFscFR4TFZyMVZZ?=
 =?utf-8?B?dWJJTi9UTFd3R1FyRDFyaHQwYTdlbEQzYXh6eUtXbHhiN3NDOTgwRXJGd25J?=
 =?utf-8?B?TFYwREpyMUdZY1pZMXdzKzVkb1pEa1lzM3lCU0lPb3RGVFRNU3kzcXlCd1Ny?=
 =?utf-8?B?T01Xb2YyUXRoUndWVGVhM1djU25zS3U3dUFINUVrYTRSRWZ2aGplWUZ4UERs?=
 =?utf-8?B?U2V3d0ZjM0xqei8valNJNDE3d1hsMExoVWdpNExzdE9RbHNzVHY0aFdkQ1VO?=
 =?utf-8?B?YkgzNEVZWi9iS0NFdXJDQ01QTkdYWmZRaFluVGNMZThuUUs4WUs2U1ZEdXNW?=
 =?utf-8?B?QmlXd2RmcHhNdFRHZ2FvVlpHTkE0cTUwQTBISGZpVDVDZGpoUGFVQlB6MGhw?=
 =?utf-8?B?RDFmdzdHZWRQUWN0T1hXR0xja3hqZExLTkZVREw0ZW5Od1M4ejRVUU50TXM5?=
 =?utf-8?B?dHZuTTlTSzl1U1lrd05BWDdqeERsMXNMSHZKSkQ1M2RmRFYxKzhTS016SHlG?=
 =?utf-8?B?elVPL3FPVXozaXhFNFIwWGJ5OXc2Mm9NZDY5Y0dMandwcFVoM0tzUjArdFdU?=
 =?utf-8?B?bVVUZHh5eHFtb1RtVG1qNHpFRHl5LzNZMEptdzdrUTI0aDZmZGNwbTFialpF?=
 =?utf-8?B?RzZGWUdGSEhyZ3V5MkRFOFhPTm1IYkw0NFFEUFVhZGsrZHIyNFpoQ2VpN0F6?=
 =?utf-8?B?eGlEdnhEWmo5TThMTFhic3ladFgzTkZlcEdlVjdhYURQa3FXYWRJUGxTVnV0?=
 =?utf-8?B?QTFmMEh3VWxJMFdsQTYvbU54OXRRQ3FHQlU0Y3lsMEIxK3JDN0YvRUpzeUdu?=
 =?utf-8?B?ak9DL2ZuSURaajRaZGZJUGFjYTh5MnJJMlpqZkpYNGUyYnVaTlpVOXB5VVlG?=
 =?utf-8?B?d2tLMksvZU16NGM5TytaVFM1VHBIc3VJb1N3QUlmeVgzTSswL0NwajNjKzR5?=
 =?utf-8?B?QnY4SFdJUXlsSm1ucnhVcHQ5NXBwaXd3ZUplQk5vSmJYMmlMV1VOTnFkbldP?=
 =?utf-8?B?bVNza1B4Z3NEV0NtamlhWGRYcnJXVFZqbHdOZmIrS09kcUswWHljZjJ0NVl5?=
 =?utf-8?B?S094aXNONmtRcno3YzMvaHRlTVFZb1NCUnM0NU5ndVhkYlh4bzZ0U2NZV2Fv?=
 =?utf-8?B?c251R3ZPQ2h1cGF6RVdNSUFVUUN0eVcrcEVCcmRXY1JYaVhuNWxCS2d2UlBB?=
 =?utf-8?B?VGp0TGxHQWlVUXFrM0FXTlN5S0RxQlNzU2NKNWJWZmhjSXhVeGViYmpMNkR1?=
 =?utf-8?B?b1dJM3Q3N09QK2Y2ekV0QlM1dTEyRlF1eDVXaXZlaXJDbEtSa0xuTS9MZTBo?=
 =?utf-8?B?cVp1RHI4MnhwNkE4aW54Slp1T3lxdGttODVSeVVqeTdCNUpRdEVucUtmRXl6?=
 =?utf-8?B?N1lUaWlNbndKd0lzckUzR0czSWxKZkZENVhkaWhMV2duTDA4S1NDc0V4enUz?=
 =?utf-8?B?WndCQXRHcGV2RzJTWm5DdFNUdU5jMm5YdWlSUlBETDl3RXQwN3YxZDF2WTdv?=
 =?utf-8?B?bUZQRG5wMVdhQWlmN2lMYVVTM0Z1R3FrRmVqZkxaWnNKZHhVOW5tbE5XUFFL?=
 =?utf-8?B?VjBNcTFYelFvQ3BURkp6US9IOFJNY21jNzF3bGNCOFVqTmQ2UGF4S2JyK0to?=
 =?utf-8?B?M3dJUVRZRHBITTIybUlNdHR5TzNpaTVVT3J0ZWlEa2tsdUMxdi9yMi91V1Rv?=
 =?utf-8?B?QzJrQTBKK3hoZGVmeFA4OVdxSHZYMnVGMjh5NkF4TmMzSEpqNWVhSUp2QVk1?=
 =?utf-8?B?VU9OMGtMMXNXUUlCMU5SQUhkMVc2SXZzTmNrc2Y3a1I0dmJYVmQzVFhsK0ZF?=
 =?utf-8?B?NndOdmhUa2tEL1JUNnE0TlE2ZnlZSzl0RzBGSFBraU1GZ0JIVXg3TzFoeTMx?=
 =?utf-8?Q?C2w8ZXcjEMelrL5/Rd4MhYdxF/xnkeaOnWnPhviF/AZG3?=
x-ms-exchange-antispam-messagedata-1: UbVqUT9mDEXkF4EimqgXGq/yIeOLCNU8wU8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81A449A15C3B534496B7566248A6C6EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LjqX9RRuIoDQ+Wzt6ipke6OT75q44+dlUx3ercckXxfxnNyJoMHD3EBqq6nfLqcgo3VTf8jMZwe87HXvx06pVTT5c1mldDiClWV6U/E9Dn2m2dgEo7l3Qi9YwaRq50H0sJWxpkiviq2HNMiyISO5mg69aeZSMkxypMRWrbHZtrqwFOrF2mqECSM0Gi8Xr3vHeiXdwJSUKRDZTc5oPmfp2D4elj3bB/DlaN5iBmqrMwI1/GrqDBQMthRl4+p+hKX7HqoMFPd3FIoFRNP1wWzK0WPsK3D2zZGkQoViW2NXMPVQShDeez5/F3l3WQcAL1a0S3Za67yUHUZJM3xUEiR5J9JsQaSEby8HwB29K34oZRopNVZ7nwymP/LoOUqNQVa7vvEfx2QvpNtQr+q1G7nieNZtGf/qwCQkoPgFoGkZfDCVx04dZLPtDJqKa1BjHmLwWS8/XaCSzohAk/0q+0Q8aV9rv76XTmXWshqwlqmbjBrAuf3Hw0+bCP3SwJu+cS0xgbSdsv7JR8Jq9jvJchN/me1RFY08ZGkhG/O7CWiITi+a5l1ep/6Y28cZofMn64NIgXLLo0isp4V1Gx0IE6RsYERXaswxW2Lwv5WPML5KEkEaY1YXp7vbL9KE5qqQzuyq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dc78f0-758d-455a-66dd-08de79bad397
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 06:54:05.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2z+jvCYvlcmpZRg4PNPaalB1RdutIZ+Lb4zDiN5kCdvMYLKhFVOsxgJ91WnGfz76jqrciyUquyP4Ydh/OQGCvK6OReopIq7drhThyZVP7WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7885
X-Rspamd-Queue-Id: B43B01FB531
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22216-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,wdc.com:dkim,wdc.com:mid,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Action: no action

T24gMy80LzI2IDI6MTQgQU0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBzL2FkZGVkIHRvIHJl
bW92ZWQgZnJvbS9hZGRlZCB0byBvciByZW1vdmVkIGZyb20NCj4NCj4NCkZpeGVkIGFuZCBwdXNo
ZWQgdG8gZm9yLW5leHQuDQoNCg==

