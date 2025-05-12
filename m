Return-Path: <linux-btrfs+bounces-13877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559B9AB3171
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 10:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84211893209
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A795E2580F8;
	Mon, 12 May 2025 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lea55/I/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QNEiVGYR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777A1E32B9
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038072; cv=fail; b=Ea6e/GWwCL6UtIrhWjgoBQSU0hr4FFlTNJ/8bAO75HBqnVv7W6WgTwh/CFXSKuomgyznYDajX6XcomDOP1NFz6Eq1lnrgXsDa1TRCDTY1mvL+v2lBXeUd/U/va1tbvcu0tqTazGjpqJ+d1hYvQR560mJSkMUJXChhlofLinlLB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038072; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RXivVEsJkK+xzewgOORAz+uNhfH0Zb7pTof7IVSAPHKTG51kbTacUHm34fIZWBSZRHDvvRra1n1zMOGmF7zxch8K16pSVt1bpIhhR0vrw6k/0MNhu5fGNUPyY6qRJZ88KeMZDPPUXLSTvQJ1YhiNgE7hSbQnsvzInvQp4Xlg0Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lea55/I/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QNEiVGYR; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747038071; x=1778574071;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=lea55/I/lwV/my0sWmKcjyJCi+6p0/vpJupLpCAUQ8ab4xfg1/3rvNMy
   do8VQxt1tlvpcxlXJhCQvfASGI0HudhAyYUFsfbYCS8R8OX4aVcOgIzwy
   Jq3lrdIm2BVNnKkzIacIpjWDtURHS3U7q2Q9KwRCLM437SRbZC0LC5sMF
   oFNEu0NPgu81fGUoZuqXjWe/tMSbFrg4TakLaypfa0pPIyHaflt5IpENT
   vqGIgwIi6SoMGD9Jlci64R60/1ztSNk+z6Y4qRemUy1KZyiKWrRdVPjBy
   pf6kzwx8v5/ezq40LD0T5pk64e47tD6WTO+plwhee2LEmSpgW7e++GqnJ
   g==;
X-CSE-ConnectionGUID: 5KomYuUtQdieaz1uVuhLvg==
X-CSE-MsgGUID: 3AkOHwUcS1WdUiPkwwtrxw==
X-IronPort-AV: E=Sophos;i="6.15,281,1739808000"; 
   d="scan'208";a="85010044"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2025 16:21:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx4rB3hOH1u7xqyMnwIrJbI+WBli0b6Bdg1YVG2y68MEIda3zGo7fmwEC5elKQBypkNXddRAP7rnl2SWPbZd+/pifOfEXo2fbbUXgRfyu5ZFA/AH1e4VmRb8KFUJ/Td/JgYiHq/mLBE1e9XEn+E8JQnLFhkKubWrCjbdtNo+L/ixQVwhyiWDjnnQi8wCvZVdFfZfh5BaIIQmXVKrCXmdsYhy9xbK26uL34XP8SwQGlwWG0lQ3Z3voSPy+rNzYRgHSlq6RBz8Zzfa7yjimlABl8Y1IeGffNjToka8lPm7RbiaQ3DtR8hqqA856Q7PnPTWVWbEsn9JwHve5i8/IBFTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wn1CNr0RYclEWibPEWTxZwtE7pc1ZozkD3a6JKH97s1Y+og5q+d9ClyJpeP+L9KbP3nbyigCvkqv75CHEypJnEcAaxhBr0T1UARE3WnE9xtOej4hiTXMMtjXGEdqZJLvOdAaown38zgHApw9PjILDdhDGOKcI3KouAd6hc7SiHyRvARZVs8MQb26zTpcwvNi5b4hghA4B6DKCv0Ai4HBOEOkrEzXq+hj+K0WdUjnzIoVqdz4C/dVZ2/PaXum6rCHCme/Qo59kEwka4u8/MDfAnRaiP8BCaXS9O/bVG3NgNPchJsE/4YKaMGFfoMSE2xmQV36ctcSkyFVkN/FWDgZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=QNEiVGYRyLYK0aPuAgvfKrGnL9bcg3VmHKjpxAwr/PklHEDEJ/EySpeofevB3HIY4AhZ7tq28WMv69NuoKH4eZLPCqxNGlzmQdeyU5HWqpcznaKPLKLqyjILuheEof3ku/M401q5XTQNLXN8yxLiz/d4lHF73PL9jlnwSlNE1dM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8202.namprd04.prod.outlook.com (2603:10b6:208:349::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 08:21:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 12 May 2025
 08:21:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: simplify error return logic when getting folio at
 prepare_one_folio()
Thread-Topic: [PATCH] btrfs: simplify error return logic when getting folio at
 prepare_one_folio()
Thread-Index: AQHbwxI9j22CBnLeiEqVWiUaGE7QrLPOp3eA
Date: Mon, 12 May 2025 08:21:05 +0000
Message-ID: <f5401ae6-bbe7-450c-a327-d90b69283c7e@wdc.com>
References:
 <0ef572363b52c57d95cc1a8912430187f868a7d5.1747035909.git.fdmanana@suse.com>
In-Reply-To:
 <0ef572363b52c57d95cc1a8912430187f868a7d5.1747035909.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8202:EE_
x-ms-office365-filtering-correlation-id: b36d6fa0-6c67-4b69-445a-08dd912df0ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NW1jRWhKNFBVYlZwOVlySTF4OEZEajJZZnU5WlQwcFArWlo3d2VtZmRabitQ?=
 =?utf-8?B?MU5CdUM2TzVSMkhKTi9SVTErMUlLZ1dTRDNnejlBeWljZ3BRSWxtQ1hNS2xj?=
 =?utf-8?B?WVRPQVdCTEJ3SkpTZGZwd2NlOE13ekdNejZEMmhSRTIyUG12M2pnZ25LWnlk?=
 =?utf-8?B?NU81cTJBK2d4WmNlR2pnVHEzYkVuQVJsdVRlRDE2OGorZjBEUUdmZEtCQU4w?=
 =?utf-8?B?ZE85VmdHTkxabk9GbE83RkY0QVJoWVkrTGVGdnQ2VWxsblZmVnJxalJjVGxZ?=
 =?utf-8?B?V2ZUOS9yTWdBWHRNazhzSWZnYXpjcHM3ZU9hVHZFVjJlNlhxVGk4d1Vib2hJ?=
 =?utf-8?B?UXE1cGhycjlsMmkvc0lXaTBmVFZEclY0SlFzWDc3SWkzVUNCc2RaOW1WYWJv?=
 =?utf-8?B?cTd1eG00aGlsMnN6SDJtSUY3VVB4WnRINXlKemVCb01OWlFDL2NVOENJR3JI?=
 =?utf-8?B?UTByRDhvT1Q1dk9ocTdVcE5MMTgySk5yTnJHc09TUkM2S1N6bnVNN0RCQlU5?=
 =?utf-8?B?TkVPSnNxTmdRUUhQY3VHaVJyd3NaVElZRXFtY1RJQ3RQSjNCdmhHRVVmNmd6?=
 =?utf-8?B?cmszR2hkK1lkaTI1aVVvS3RVdlVsVGI0MzE3bFRoWTMwSE83WDZibWhqUjlx?=
 =?utf-8?B?MGFLZkVqUDdMOHlLYzVpeDZvNWRnNlA3c20waHBNUVM3dnBuUExLd1VSaG5T?=
 =?utf-8?B?ZDRiK0FnSHROSnFDUXhhdUlSMSttdHVJZDBNeDE1VEZmSGJhM2Z4LzRqOWxE?=
 =?utf-8?B?NmlZbmZBY0UyYTIwRHdGRWJGVTBWYmk0aFpka1JCZGxYSExPOFVYcUdhN0Qr?=
 =?utf-8?B?elpZaFo2MThjaVpobFI1OTg5YUViTEcxSVpuRnVkWUxLOTNaMkRmYzBEbHhC?=
 =?utf-8?B?Y1prZFRCL1JJKzh1Vzd6RDRDV1N0MEFzWGdVNmpualp2VUlDdlRWWDkwSU5I?=
 =?utf-8?B?ZExiS3hRL1d2Z3dXcXFWUVZ0T1ZONkJ0bzd6V0UzYmlOMzV0cjBHcFQzcWFH?=
 =?utf-8?B?YzgvOGZGTGs4dkdOdUR6cjdtbUttYWRaNVRjdjU4OWxuZDhYd2FOUXc3MlpF?=
 =?utf-8?B?bVVtdjNZRXZZMTFUTS83TUdEUFJhVnBWcmk2ZFUrOWthVWgya2tVZG9RbjZT?=
 =?utf-8?B?aGtzTU9QVjYyVS8yL0lPRFdvMUc4cnRvRkdaV3lNQ0pzcXRHeHB1b2gwb0ox?=
 =?utf-8?B?Zkw4cjd0RFpOMUNacXhLVmZMZHlmNjZQTy9tWE5aREt0K0F3ZVhRWGZzZ0FM?=
 =?utf-8?B?RWxsWjNoY2h6OTY4QVFPbjVYL0Urb0NEemd0ci9IYzNPL0V3bytWS0xnK29s?=
 =?utf-8?B?Uyt5MUltbndDcnUyWGtPeGtqdEZVQ2Y4d3FPTjQxVFRCb0JSY3ZxOXg3U3dU?=
 =?utf-8?B?QTFEYkoxa3RjTkZoWWppT2dVTmtSdGJsRUh6cW1UVVUxMnFnNW1OT2srNC9P?=
 =?utf-8?B?bFJaa0daa2poV2NBbDgrZXRTdVJINlFyUDd2ZDlVMEczanNrM1FYNVNvdlhr?=
 =?utf-8?B?UVpBV3hxRnRTMUZTTVpxOFh3UXRva3lBMGVDWTRCTFhKVk83L3JJdE1QdEY0?=
 =?utf-8?B?Ym5qZ2tLV0kxVnJVNStjUkRHdXhKRU5iNEdKMVVVQ1NWdHhTeGRnK3NWTmxD?=
 =?utf-8?B?MkEzTzlQd3ZObkExT25WdWRlbzJjaUtuN3dSeDUwVGhmVG5iRzlTZ0ZyL0Fz?=
 =?utf-8?B?ci9Rc2RoRi92UU45WG5GVmRDMlhKbEJ0c0ZmYWJqK0ZOUXp4aW4vZlhQMlRB?=
 =?utf-8?B?aGdZQS85YWkxcmNBWjdMejA0bmZJWEtpSG93cjlFMHhuN3Rhc1pqQmFiZDBk?=
 =?utf-8?B?b1M1Q1c4RmQvUk5SUGFMRjhMaEJiM0ROZU8vVXlGTXViU0dMTys2eXk3a25S?=
 =?utf-8?B?MXE5QXZPYXJGSThKYmZvczcyKzY0NXdHQmVYMVc0dE9ERGVCdmhINnFvTGZV?=
 =?utf-8?B?VkVHeHVtQ0I2Z0JXQWoxS0lVOFZMZlo4dlV4NFJhbkEvVGJkZXphRjIzbTFt?=
 =?utf-8?Q?mU/Bvm+6czvxXETwE+/QD2R0+YqeZI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXJzMDRvSi9QUkZtc1ExODN5cXpCSmd2emRTam04Ym4xK0ZhMnZYcW82ZEFa?=
 =?utf-8?B?UlZvQ04yNk5EOTEyczg5OWtkLzFYZmpPM3ltTEpkNHdwcmFKckk5V2ZXUDYx?=
 =?utf-8?B?Y1lHOFYrVm1Wa2Q0NGJSejBZa1JBajU4V3I4OGt4aE0xM3FvQkUyOE9xWnNO?=
 =?utf-8?B?QkNsQXVMWUtsWTZaek94b2ppZVQvSjRrejZIdVVaZHpPMWhJTlByU2M1clZR?=
 =?utf-8?B?N0VoMmtESlNkbXI5M2ZIWGtJUWtuQ0tqdGdLcW1qNDlwZ0RUQ0tLbTdFbVBp?=
 =?utf-8?B?eklvaCtBSVI5azJPdW5MbHl6ZkFsL0I0YzNEWkliYlZmbitSTE94REIxd24r?=
 =?utf-8?B?bVplTzFZc2JZRHV0cmFSNjh2QlE5eWVUeW1EL0l2M1hSd3pzdmIxMjZ4NEZX?=
 =?utf-8?B?SkxvTGVhL2wwR1JWNnNaTnJXT0tNRnlYSXl3elFKUHRHaytGaHdKejVEMlIw?=
 =?utf-8?B?UkV4Y2o1RUwvd0M2SHFyWUdqMW5TNllqWXVvYWhxaGQ5ZDBzRFVPMTVObTNR?=
 =?utf-8?B?L2ZVRUJXNFJ3WFRENVM3L1pFMXR3Wm9GaGtHdy9HWVB6T2cxRzd0RWFHSUZ2?=
 =?utf-8?B?cG1SVExGNlhIYWlyWGxjY1ZxWUgzVTUzakZtam9pZ2trKzVEdERGUnloRzNU?=
 =?utf-8?B?TVh1aGxwb2N3cmtUVERSN0toZEwzK3k0ZEV3SXVoa0NJYU9YWEluZGJNeTgx?=
 =?utf-8?B?b0E3Uy9FZ1NWWE00eVRCdjNGb1pPc0w5WURhdkJaSG0yQzZhWU9tSVM0bXg4?=
 =?utf-8?B?ZmY2Z0hPU3NFT2tpMTMwQ2V6WUZQUFVYVFBkdnFqT0s2NUhSMWErT0hjcy9s?=
 =?utf-8?B?dm9WL1ROU2NDRFZRWHF4ZTdtdTAyRkl4T2hiL2F2RmQyT1dMZEQ3YUpEKzhv?=
 =?utf-8?B?MVlhemh3WUl2WWowODZNaEFCMFpRNFExWUk5dzhqRndldW9iMG5FQVZiNk95?=
 =?utf-8?B?aFRGak8rMjdySS9hRmx3aDl4SGZCaGJkOU5nTHE3ZVRiMHdNU04vNXlpRzVr?=
 =?utf-8?B?bmJZcHI2SEtGbjFONUVqckhSUnVSV3gvREFnMHBDQlU5OGxXZzB6L2pSZWls?=
 =?utf-8?B?ZVVTcHU5L2swNWgvMEFxQ2dNVzVHcEtiSlNUMGpGdU5Ob2RtYTNVOUo4MUI1?=
 =?utf-8?B?cnhTMVVrTUpFbGRBd0crZ2NDckFVY0xyYUZnbjBXUWk0VE1HNHVWL0x2YkRx?=
 =?utf-8?B?bnFlWjQzQjE1bGhaYVZRbVVzbXJveVlzV1lxRloyOXkwRGQ1a1RmcXA0eFgv?=
 =?utf-8?B?cXp3b3JFMGpkUFdpRlN5UDRFU1VjQ3FSZ0pvQ1VOeWRBdHMvdjhpQmY2bzYz?=
 =?utf-8?B?blFKdlBHc01yYXBXQUtYZzU0QThuZElPdUZkdGJPUmdLMW0zWHB5a1dOM0ZX?=
 =?utf-8?B?TmVMOTltNGhlMnc0MTE5aDF1SFpHOUtUaVYwOGRlYXIvdy93K3BacDIzOXF0?=
 =?utf-8?B?bS85YjROOFlVYkJnTmg4ZXRIRkdobnlzaFVwdjc5T2ozTC9RMjZ6RGhwOXdz?=
 =?utf-8?B?MG5IVks2OEJIRHRhVWpkM092WXJqZEFUYkhDcUtxMXpZMG0zblAreFh6QUhp?=
 =?utf-8?B?VHJoSWhSYTBITWt0NHBxL2Nvc0JDTEtSTFIxS3R2UWdaRGpFcnVHV3BGbVI4?=
 =?utf-8?B?SENKUW1xa1YyTTJkMVY4K2V6cFhVaFdEYVA2a1Q0emtacmc5RnRsTW1RWExi?=
 =?utf-8?B?T1VKYzVRc3FMSjFlK0t6UUgxcGlwaGhLU1MvU2ZXWitGS0RkZkxPTDUzMDF6?=
 =?utf-8?B?eEk0Vk11OFlJQWZpYzFVdzYxaXpCaThnWXhMNzFmdWpYeHJOeEFTZndSK0Jo?=
 =?utf-8?B?MU1qa1VNa0N6c25pTTBsSzZZd3k2L3hYT3dVK0x1aXRKSW5HeXMya2hpMWpC?=
 =?utf-8?B?RDRkZnNCZjhTK3dXVnJUZHlyVHJjN1VZd2hhU0JQajJOK204YmZjT3dYdnBx?=
 =?utf-8?B?SkE0ZlBzbXpReVg5K3FCcTNwZTZVaDVqTExoWkVSZExDb2JDNEQxM2FSbFk0?=
 =?utf-8?B?a1ZSQ0hoQjlERzRQZkI1SUphV1JpOGFubkJiSkRROEJPZ0NWSU1nTElNWkEr?=
 =?utf-8?B?bElqTGs3T2hDRW45RGpVekROaUVOL29JVGcyYnQ2dmZnS3puMWtxOHFqR20v?=
 =?utf-8?B?UkRDZ2V2RVkwdUVSK3RMcnhKSSs2emJ1QktHNThtak9hTXBWMkpGcFdXUWVY?=
 =?utf-8?B?eitFMFJxeDhORDFJK1krNnkxWUQzMlRZSUtzekNWVVlJak1EQlZmL1Rub0tj?=
 =?utf-8?B?QnVTeEpVUW9YNmZBYXZwVlYzdHpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16CBD679E857C9498459AD665CAA0FB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jonBkvd9DTIO3jaGBWnGfRF0sZLHqZPj7V/+zBtSGVyEs48l53ab3+Sn5HNlzSPsS0tPaTYFw4keYib5gZq2pGfyyH6wtGSSSunu9ucXMu00ar0ItdMKxw3CxzS8LY7iRuQbHEhWXBjgWf6TcFPAQU4Np7oK0Ksk/kZNB9ViddHKLogh4czv016oS+ckTvSuxkaKqYqTyKSnA52x6HE4XLZ1rROvt1JlRPSzebKQAyEAOvEfNXvBEegqD8iW5ROA5mSObEBOCU0sFLvWsnhcJ4Ew647VZaDUT9ip+bGiTHqpYvOi+W4GmzqxF/MgaQIb3Jo+WoZYjlelmsG/lY6kR19gIF6ciCuKKtxwVyorGfKiRmtqO0vfTtfwK5cGRRIqyteHHy87+IxDiEEHI7eQUdVebvJMBJisaNpLxQI2CPBAYT5ojzSt6Mry7IlIp0pUdiiRNQkAVMH5NkyeEIvESbnSpl3X99+k3J396mCjFaKSZjhHsDUWVZ326R47EtfR1YrvaOKHbRqJp2uAzQ2VRk2v3GNejEIWGyeg4q7aaScGRfyN88HUPzNQirGivg8kI1UviSBHPhFuNoJto7nlo2EMVb9ZU8RYNEridYYpSuTaTCjl7l9fuXj2hXmHvrE3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36d6fa0-6c67-4b69-445a-08dd912df0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 08:21:05.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BG6vb4T/eMZ2cB+F9825aVcZAl7PaaV121Og6BctGl8NPuxPdsviYt22C6P8FQKE0FsHuX1XxNu9pgkYzmZydc2kU5BBD0R2+VZSv454Ips=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8202

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

