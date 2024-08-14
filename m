Return-Path: <linux-btrfs+bounces-7192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC40951CD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B3CB24B70
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1211B32B7;
	Wed, 14 Aug 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a2lJsJn+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BHn2Gyx2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B111DA23;
	Wed, 14 Aug 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644965; cv=fail; b=NPjrPZNhks3HmvP+JSAApf7qcSwsHwN59BpqFf1gNTBq7e4DZo3qkKIG8krZAIQKkrQeZ+I7R3RH0qrjzuBMXdsYyvmt7kcuSk0fUPtNOX7Zy/Wd7WPM3ZGt4b8HgUAEywe+zZoEmpK8UjxJs5tIjxTtuRU+6NHRiR47KoxyCJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644965; c=relaxed/simple;
	bh=ikXza6ssAe41E5rdXFUQyqUbnn6PQ1dY6q79w0LNbr4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QflcLciYO+qXzYaZ1cSfZLzuUyKlawUD3ivKBDklhCNm4F1Ds+GFgf1ZGEiAUEYvQxR+/QZ6Mzq1sxEQjocWkk0SvjRgIN6pCsfzvDUAWCkEI+ecxW//VsNICtqgO0dHr2dm1IvJTqJjEblqWdn/zWw97Doiug6vt4KFZmYWUGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a2lJsJn+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BHn2Gyx2; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723644963; x=1755180963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ikXza6ssAe41E5rdXFUQyqUbnn6PQ1dY6q79w0LNbr4=;
  b=a2lJsJn+6I7KvWX35Z8GcywuQ0TqODN3pvPSt4o5l5Nqz6vEpih1uBEa
   jfMG+YaedRBodgrJ25MBgOJStzy/a1WopPa65KnziY/7Twoh6G0mHzt09
   n+ye0/Kizo3THsH+CFVdeEJAbzjuHbHnUBnvlDWEWm+HCYfhd2l4Kw0Au
   WgLazRi7ynfCsU7zjAlX0g7uo5GoS8xeu/KR245xckga2YCTA2yhbbg5Z
   4Kqetb0vOdJaA9n92PiqX5Dlbt+BJWmLewIc6g+Jd9SYcnoxgJoybYo8j
   nkLkBX62i9HH2qlMtdjxA27KkyW4AT06CTNg8s7kWbu4pacsHVXMZEtio
   Q==;
X-CSE-ConnectionGUID: X2tnJSDJS4O0YaamlicT2w==
X-CSE-MsgGUID: 5Ppyv+2/TKimjBzEo8gRYQ==
X-IronPort-AV: E=Sophos;i="6.10,146,1719849600"; 
   d="scan'208";a="24245860"
Received: from mail-westusazlp17010006.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.6])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 22:16:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOyiYJepyjpja5Z4vboWDhJvUmF5HLo76FWYc7HkZl8gng5Fx5m1akRcRwsnfe7+VKCeoVZDZlV7mkyj2vXMtJW7aV+ZC28awWp1qqf4fzqO9dAiIG1fmYTWALGgFr6WOod9NBFk44JcjOIgx/vrC2L5Ctv5lgKLfPYoP59TQf2RqpZ3ymu/clA09tyiqhqS0i1XcmIWwY/rDBmPRQC9k2a3MpnXexdNTqniJ4/YrXDS2700VT+TAW+Ts81iJLIdouCKTYaFdBPmQdDD2pXKTKjuwCVwFdzjWl8KBcu6dVuQhymrsDiWQn7e7lGDQXLYU0Ju71CpQ0rjbzktMZ8GNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikXza6ssAe41E5rdXFUQyqUbnn6PQ1dY6q79w0LNbr4=;
 b=h2YQ6xD7EvOVdZcWnMPcIIMLOGyAYDFMIh9a+8QN6/QtBQbEs8/xeUAm1KISXpkbR6w+hujyPZsfeSlLNxQffOSNZjnPSsuelTy0Dn7ivYp1BRcSsakBEIYER7B9aOrA+bGHlu5mFSleswVMFWndG3kqRSqNT26JDiJrO8jF4sPkPALPZNf1NQZWPdHSqUSEKcAOBWrM58Ju4MFRdasU3ndME+tSf/PoQ3qUxRIvCrJao9jyzTuzUzNsTyTkDVZuOwoduYYanzIGh7HWJtCqaz1Xk7L03ll780JSyQ4VOXZJvy7FtkPRm4SH5iOJNK8RNEl9mHRjpmj+hpk6iOodCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikXza6ssAe41E5rdXFUQyqUbnn6PQ1dY6q79w0LNbr4=;
 b=BHn2Gyx23a825B042yHjg9ix+Zfw1CP3xUK8NG/6bjaVNznu2HSOomyUbe0uqBsyDA0W6QzRHNN/rqQYWDKv7CHrOsYEyB8cn0D9ThuaQyFy6MCBuQ+QdWJJI5FGOjA52kb1hAPT2qShm++UzUFXcFOPlebCsY62+ans2hffdpk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7448.namprd04.prod.outlook.com (2603:10b6:510:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 14:15:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 14:15:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
Thread-Topic: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
Thread-Index: AQHa7kfrHnST/6cpJ0yQOSc010shd7Imv9cAgAALrICAAADegA==
Date: Wed, 14 Aug 2024 14:15:53 +0000
Message-ID: <24db4553-3d0f-41e3-beaf-4b325e9f8418@wdc.com>
References: <20240814-dev_replace_rwsem-new-v1-1-c42120994ce6@kernel.org>
 <CAL3q7H45Ym_QHPYaregfVvUDzaVpm5i62G8==yNQ3Bfd63Ffmw@mail.gmail.com>
 <CAL3q7H5L-j6Pe2zBmd07K1MyRXbEOO6C=-SB93PdoOQ+4spSOA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5L-j6Pe2zBmd07K1MyRXbEOO6C=-SB93PdoOQ+4spSOA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7448:EE_
x-ms-office365-filtering-correlation-id: 400c802c-f67d-46a4-4693-08dcbc6b9b9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RzcxeHhhWjlMa1gzTkZFdjdoY2VRUkVyN1ZsbjNjcTh6ajA2RVdZUndkRTR4?=
 =?utf-8?B?b0toYnNSSEhXbFBUUDlnTnZxZHAzMXlpMXpWdGF6M0ZJSFd6SVRGc0ltQThV?=
 =?utf-8?B?Ti9FSlpSU2xQbzIwNEdpSjJoRW9BVlo2dXVJNFJWaFU1dnVIT1RuZEVhQ3Zn?=
 =?utf-8?B?OVl5TFBaZFZXUjh4QTZDSnF6aHJIZGJGOFg1cUUxRUdFQjRMN0VabkVTbGRQ?=
 =?utf-8?B?Q0MvVFdlR1NWd1FmUWt0NmxRV3l6QnBpR3ZJdVkzaXhGSnhwNkRESUdvT3hS?=
 =?utf-8?B?VklyQXJaVzg0d0pRazJCZXBPbGV6Umo3YjQxci9kYkk2c0lFWmpxbzFCVndU?=
 =?utf-8?B?YnJzcFdJaDZIVTNKMzJRYnp1Kys4QWU4ZjVHcjk3RHRJaEtnNWJ5b0FZQzF0?=
 =?utf-8?B?VWZHK3JuOGh1V3V5eWREc0wyTEN0dUtOWTMxZ1p3RFpJV0xTTUhkUWM1Z3Z0?=
 =?utf-8?B?YmgvWElQb3U3UVcvbndVVkFSNjBYSW8yQVFUeHdxQzZSbXp2S1RRdHE5MW02?=
 =?utf-8?B?RGhPMnBSelRObWZEc28vWkVmQUdabjRzcW5UMk1wY0FOQ2VKY3FnRmpGSFEw?=
 =?utf-8?B?NjdZODIzbURwUERuL0lLUXltRFdkLzBLbXdwZTV2ZGRYWFYwMllicXUvdThl?=
 =?utf-8?B?d2U4RDVPMFFrT0FrWG42WC9NM2NxNVlHRy9xZkVPcEtLNmRaV3dubkdhM3E2?=
 =?utf-8?B?R2NTQUVqUTBoTjZxZzk2ZWVzOW5jV3crY2I1YVdPdmQxVk9VNmIvcVBUektr?=
 =?utf-8?B?TUdOWkFuRGhlYS9Odmc5d2t0WlhyU1lDTEx0V2lTSXl5RTRIa2ZGc0xYbUZM?=
 =?utf-8?B?Q2xTM0NSakZrWnAxN2dYemgySU5kaHlPZnFCcytiQzJ3RXhXRmFGUVRQUkdE?=
 =?utf-8?B?YmwrTkh2elM5cnFuOTZTZWNpZm5DRmlNTnB4NUtQemJrc0lYWXV3aU1LalNx?=
 =?utf-8?B?QWUxYjBFcUg3VTRIdmErbWc5Rk84T2pGcWZzdllRU0N5YjlhODBadHJvcmll?=
 =?utf-8?B?MVJhRmtQSGxLb05Zb25xRzhSL0U5WjdoN3dEU0RHakR1dkFrVm9Tc04vMHJB?=
 =?utf-8?B?TTd2cFVKanVsOWNyaGRxUXZrYWFBSnRndXVicFMzMXZaWmRVQldqQml2U2U4?=
 =?utf-8?B?NUlEdU5mdDhtcXJBaWJOd3lxME50RjVUeXYrK0VpVzE5Zkh2Sk84NXJiWlA0?=
 =?utf-8?B?YzByVDNhbG1OTDh5RnkrbWpHYkpDOWt0dWVBR20xWDBIUnZSVHJmbGhmS2o3?=
 =?utf-8?B?RjBkdlhqemVVWjFHbG1lNzJsVitQcWtlWXIyMFU5UWlscGM2SXc1TGRTczd4?=
 =?utf-8?B?czh2dGszcDJvK0ovSFBBOU44YnpuK21lckN4Qlk4Qm0wZ2tkazJpYlVBdncx?=
 =?utf-8?B?L0V5eHN3UXlwaUJ0U3NzM3JuMTNjcXBqTk5SWm1ZaGRyNGZXSStDc08xcGRF?=
 =?utf-8?B?Vkljc09HVnBGbmVpQ3dYV1k4WnFtUFR1WXN0ZWxCTG9HenpSQjE3QVdVQjZR?=
 =?utf-8?B?RkJHMmVaMzlWR2NReFRFaXRKempmVjhubE5raFB4VW1tb2ZaaXlEVHRWKzI5?=
 =?utf-8?B?NzYyL0JqTTBJajVtWG9MR2pxLzB3Sy9IanBvQmZsNXIyMTVkcFRFQUZnZ3dP?=
 =?utf-8?B?SkdHcDUvTkhoN0VmYTdMaWJDcytwWnROcjh5UFU4VllaVEhnUkJLY2JmbURn?=
 =?utf-8?B?WXBlWEdoZWJqTGR1cjBaM1RHc2JFTDkyckJOMlhsL0lUUWxNY0orRjd4czlT?=
 =?utf-8?B?d2RvZkd1QVQvZ3hWZkR4VUJ5S3o0MklXTzZuUllndTRYZUkxY1BWQkpVeWFm?=
 =?utf-8?B?RTNTYmlQZFhGdld1bUlVRHVCN3dTM3NsYnNMeStjMjN2VnRSblg5cFlDSHYv?=
 =?utf-8?B?Q2swUkt2cmFGcnh4TGNtTHZ0c3orZktqd0NoWXpxbWIvTWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnVJUURva1FUODFsS2lsMSt1WkUrNXZnZ3c3MDVjMVdGT0k1VW5ycm90TEhO?=
 =?utf-8?B?b3p4MXVnaUtIWnh6VXFUZm5kWkVVV1BCa2RSZkQxWUk1WC9QQU5Od3kxNTdi?=
 =?utf-8?B?bW9ETk1udHkyanNDVjRndnU1Z0cwenovcm5EdzVkSUpvUHJvUElzNUw2QXds?=
 =?utf-8?B?cGg5UzB0VDMwTVJGa2h5cjVTSnVtQWxBYWVJSHBETDdISVg2Z1ovaStKTlU5?=
 =?utf-8?B?NUZPdXJlVmhYT01GRHhUU3NCNkd0Qk9KNkx5VDJ5cWx6TFI2dzNvZDJpUFNz?=
 =?utf-8?B?NFBiZFl0M1oyajRkQlhkQWRNcDhUVnNUYWlmaDNXZ0xHUVlNZVR6d2o1VUYw?=
 =?utf-8?B?QnlQRGhVaU1nc2pWMmVsN3lDWjhWMkxRVzlJckx0T3Y5dmFmVTNPU2dISW5z?=
 =?utf-8?B?ekhIZVl2UDF2a2x6RjVRR3hRT05waHJmcEl2RDVndkcxeXZKZG9xdkpvcVk0?=
 =?utf-8?B?VmxOSkhTQTVLYU1nZ0RiMXc5cUMxMm9iNld6NUFORUQrTUs4eDJObUJlSnVj?=
 =?utf-8?B?Z0s2OWx2Z0Q5THJJWldpTHJianRHL2NUeGxLWnp5UlBnMjhpdDUwL3Z5QlB0?=
 =?utf-8?B?NmJiTmgyOWJXMFNYbzN0N3E0N1hvOWlGS0tjb0hjNmdQVHpDekpUQU1vdFBK?=
 =?utf-8?B?UEFMTVdVOUErYm5vblFIajF4dWl2TmRQOS9EM0NrczlTckRPeUk2T3VDV1lR?=
 =?utf-8?B?OXJpMVJzUTB2WFRxc0VFcWFvWXQrQUV6QkhFc3RnMXptTThRV3BTZWVVeW9N?=
 =?utf-8?B?bDZncU9EK2ptT2tpT2lQT29xeGh0RmtCcXYxQjhJUjZiYTBXdEUrdEtqZnp1?=
 =?utf-8?B?alZGVkdwaW5TblAvTGxlSjFQYzR6aGx3T0pyQmFuUW56OWZIT0s4N3EyWXdV?=
 =?utf-8?B?TGh3MXNEalYrQkRGUlAwL3l0M3hUODdhekxLdW1uY1R3QWRFUTNsT0hYZk93?=
 =?utf-8?B?MlZMYTIvYnNTbTUyZmxVMGZxb2JnTzVOTXhZckxyZjVCZjlla0xUa252MFlE?=
 =?utf-8?B?bFdnT2R4akdna2F4am9ZdnBTeEJZdHdzTkVOUnh0YUs5TldldFZkMkVUQkFu?=
 =?utf-8?B?YUJ5RWtQWTdPcEF4MVk5b292NU1BbjBHQWFtTEhyTnZWVTJFVmsyZHpTZUVu?=
 =?utf-8?B?VTJJaFRzZHlGVkcxOVBaZE1yVGFOb1M2dThzdlJuR3gzK1pIbnNrTHZvNXcy?=
 =?utf-8?B?TjlkTjhOZjJmMS9JaUhYN0VrRHJtYjV5RzFWejNpeGkwSnV4Vm0xb3VzUHVr?=
 =?utf-8?B?dDB3VDZEazk3WmJ0Wk5abk5yWlUyQWJyVTZvL0ZUZjNkem5pdDZkVWpvbzlG?=
 =?utf-8?B?NElJSEJNS0pHWFlNOXpwQk94dkRiVmhHRFlSZTFDbE02Ty9jZlEydVdpZkl1?=
 =?utf-8?B?MEVPR2I2RU1LcGxCeGVjZUhzQm91enBIY2d5ZVo3QVdMR1o4QnZhckk2R2U1?=
 =?utf-8?B?VXlZWXNCK3Rad3RFOU1sQzJWVXRZSzgxcTFrakxUa3I4Mi82bktQNkRsTENo?=
 =?utf-8?B?KzZCYTJXeWdGVEZacnBHWmhQTVlNM3F2N2Z4OHZvekdsVVRtNVJ5SGV1RCtz?=
 =?utf-8?B?a0xEYnV0T0JPS0NaajZGZjF0Wm96VFR6bXhSSCsxczYxa2RoWTU5VUduNFpN?=
 =?utf-8?B?bisvT3pQZ0ZmNzg4bnpnVncwK2VPOUxEclBQSFJzRyszZlpLQkd5d0l0UVRs?=
 =?utf-8?B?Z2ZmbTVrMmRraDB2dk96SUlZeklUWFBhTmcxblI0eVZQZDdVSjNWa1FsTEZP?=
 =?utf-8?B?YW1ubkE2S2dFY2FuK2tXNXkxczNTVldIRWdBV2libVl0RGo3TmJXR1FZTG5q?=
 =?utf-8?B?cVRxV3ZBOXdLbzJDMUZXQUlndjhGNFZSYkROYzV1RDdMdS9QWE1odW1kenY5?=
 =?utf-8?B?NFVIKzZ4RGNJczdsdHNKaGF6UEU1MXIycGRMMDVJUnBjRjBzWC9ZTWZmM0ti?=
 =?utf-8?B?TmZ6VFBsZU1VSFkyMDVqMGdmUmVaSnU4ZUpBTDRVdEhyVnRJOWhFdVNFdTZt?=
 =?utf-8?B?YnhpY2xucCtpVGxPNW1ub1diZjcraDE2VmFJTE9nS1ROYUVoUHRvM2pNTU9N?=
 =?utf-8?B?N0ovY25HV3V3cHArMlk4STVkUGxMN0dZMC9BRDJybE1UcFZTblFZNmdtWDAr?=
 =?utf-8?B?RTVpOXVxY2t4S3JVSlpWZGUyV1hybjNkdW9Hejl6b2o2SUJWN0Ewd2hJaEcv?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <434B479EA6709B4F926ACCE478CEEF54@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gzQ+hZcp3/BDnJ1pHiM0cgK7SAG77p0zXmyceBtPuqqsGfPsg5e4VqC0eIWJ0CwemqU8ZTxr3a/BcImq4OrmaOR4tph4qQMyl6zmV6t9tlD8PmLGbfvkG5JfHyXAWqSplpogtUhPxLfqpeouRkPFQuOpYGrjSo53r1jBHT1UiP48/VXQAyATmcvILjJ8hU8gHo4C4SqP/Zz2XHW8G49J+uNYARlcgub9NhlaB9rGOvwH5Wi6qJiu5hKpdF/B2v7lke0mmtlzOhvj1oh2gYgoSzKuQP8fm71fA/o1ykuTL9JkGOzKkLMz1UGeMw9Uhpulanbe0Xowa9KQGwgTOSN/999IX4DFujAUYqKJJscstiIblAyG2AXbjHZtOZ9qeNJGRe2pgGY+O1HZvhtrCFfaynzgLT6xrVxfcbEGS0EJ1Y/WsRI9mcOWGipfDOfNAdH+p90NBgFMu2kTAnU7t4NGSkeOiDfj9IZyKQMArHlX8YEB19VAM5x73hCOVuDzcQqRQdZOSfIhwoOKcZDGGTc7XCBscT+3EHrhClQD12/LyEOpYm18IfIfAy/e7rNOxy4bsXARFtQhSZAXutaeb64aOcJv+kosCY5pVAFG5qMZS03evRwCmUMawk8HWFgwYl2M
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400c802c-f67d-46a4-4693-08dcbc6b9b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 14:15:53.7889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+d/WS4iR3ICEodtQs/1qBYAkNGtNI85rA1P2baItSxtUaoQzt/eBV4UOG+xDMTkFoJoAlEN9Mi3ovfYk8NAnQ63YHA72TPFuBeOC9ox3T4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7448

T24gMTQuMDguMjQgMTY6MTQsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IEkgd291bGQgc3VnZ2Vz
dCBhIGRpZmZlcmVudCBmaXg6DQo+IA0KPiBNYWtlIHRoZSBkZXZpY2UgcmVwbGFjZSBjb2RlIHN0
b3JlIGEgcG9pbnRlciAob3IgcGlkKSBvZiB0byB0aGUgdGFzaw0KPiBydW5uaW5nIGRldmljZSBy
ZXBsYWNlLCBhbmQgYXQgYnRyZnNfbWFwX2Jsb2NrKCkgZG9uJ3QgdGFrZSB0aGUNCj4gc2VtYXBo
b3JlIGlmICJjdXJyZW50IiBtYXRjaGVzIHRoYXQgcG9pbnRlci9waWQuDQo+IA0KPiBXb3VsZG4n
dCB0aGF0IHdvcms/IFNlZW1zIHNhZmUgYW5kIHNpbXBsZSB0byBtZS4NCj4gDQoNCg0KSG1tIHRo
YXQgY291bGQgd29yaywgbGV0IG1lIHNlZS4NCg==

