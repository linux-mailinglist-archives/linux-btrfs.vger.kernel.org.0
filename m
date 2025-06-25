Return-Path: <linux-btrfs+bounces-14949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF8AAE819A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 13:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1393B3C7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374F26058E;
	Wed, 25 Jun 2025 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q+ZBsO2C";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jvgxlHZG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB30260576
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851350; cv=fail; b=S2VuDjv8ShC7Xihmhsny7DznyQnLvY/dwJr2yWUvyu9xEg5xuJlC3WaG/VHwl99VBcx/Fta/zcGp9YFfKhK4NXXkqUoO3vOICr7iQ+WkRLfnexq8AYNs4TCgtlels2uDLGytUg5p/F2ZtygZNDJ1yLDlvl1OIIyDxTpxn03Ef4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851350; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiRYUE9ZxUK/FKxRemDNqqALUmN811bukWYkHJ9rTWtaU1H+h58ngrWhLY9FWqFb0Tw8xnT7UOco6A/BA0kxVoNskq+QULFQIwtwgTG8Lt46PTRT/Q5vGwGsdSKdQ0VplZSdZgLZurUA/kx9KpOcnLvqDQ/XRwni7wCbHVgUrY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Q+ZBsO2C; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jvgxlHZG; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851347; x=1782387347;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Q+ZBsO2CV3ntZ7uuNUkcPYNzOKuHF2fwsC996kdZs+nVV1HJGK+caJOd
   i4vz/WB7Oj8gzGNTi5Ni4rpOVfRi3u6tQv6tgRyd/i/e0GrlZBbh6LwE5
   2ZcAhse6etUYuhPEPaHDfwHPu82AOsnUYEZr2IvHJsJEdCHik5PGjy3hC
   3hw7h2j/QYTaGtihe/rbD6esQv1pu1bBpP0yV6L+/cjAIhwn+hRS179uu
   5oFjIDrCgpa95DM5ufFyZzNixcv/Gb+Vt7VCDoELVYmFIFM0nfox8qlUW
   pfH2yC/WhaUZdOV0C8C5N2mdgf2TiFFuTGUnDfPBSGFmqCuSOQZFprKG9
   Q==;
X-CSE-ConnectionGUID: hlE+nLzpQLKH4F3MYSR0KA==
X-CSE-MsgGUID: bzsScgIoSve/vqBCqWj1FQ==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="91249347"
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.74])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:35:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynQeaMYnxYvixD+T4ayjRiAYMx3gsm1ok6yVuo/VLJWAh1rKILB6iwcwzU+LoIi/Rl980wzixzmbGTF/BY2Z9FXK6qdTL5sHD+DXco6OfX/Vg0/zhhLhmqPbOdgcipyCqgcJfLcBzl/rSNCwdB00OirD8C5UGjFIOjCDgzsks5b0+f+x1jc2fjaQ5HSp0zzUUyoLVH7SSJTM0TziHuLEcc+KWk8y5ATp9HwBZYxzVB1gZOurf7nNNptYG1bnjUFG3fqVHlkhBhhYZ3mJT7o6J6nQZV5fAg8IUbVBnvWmLSkd/7WbaQFZiVH2H2wgiBocSqoAyvY2uW27xZDgGaGYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ShLGRnCx7wpeKXcU5YR+52fSxXBrooeDoGUGKsaLfopVls0KrKzqfHV6+HwgDZmTHgW3G0r829gCnps1x61RksE7vvF+htTDSOcrCDUX/gbKAW7UIGZESDscfugWcVynrWwtdo+vb4QSRTqzkdOeM0/Xkx7qRkb4l6kH//rW0JYpFb94SJuDWic0OnehgQcumNcHA3LG7lxie+erCp52su6N4nubJZWlqlpU2qOmfZQhpg6slLRROFtoijYUJ0Wnu4PxOnsxokPsYYZzdD1AR3FSOu4VYECCSn1WnPtY2W2Csz3WjHRaOSO9zR/PgG838PkBeyNINkByB1HQTGb2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jvgxlHZG38N7xuCkhXqlbR8eRfAhBvsGBWvjRZjJo3Sx3yqXY22d4Hp8eqKODpaoNyHQN1zBn+1OH+EKS89hMibEvx6OwiAW/VNyXe3Vwnrd1VVl0mxC5z3FvgYIvQv/Ut4k3Nd/J4i/lIMKm+qG4SoBaOyJYfzQrEmp4WHmq54=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6857.namprd04.prod.outlook.com (2603:10b6:5:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 11:35:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:35:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/12] btrfs: add btrfs prefix to is_fsstree() and make it
 return bool
Thread-Topic: [PATCH 11/12] btrfs: add btrfs prefix to is_fsstree() and make
 it return bool
Thread-Index: AQHb5Rgjeh0nfDXII0CCytKYOdcLs7QTwGIA
Date: Wed, 25 Jun 2025 11:35:45 +0000
Message-ID: <7a410e62-45c1-4af4-ad7b-454a1213b153@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <a209c328621538b027a9c68e473303eea3f30ccc.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <a209c328621538b027a9c68e473303eea3f30ccc.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6857:EE_
x-ms-office365-filtering-correlation-id: 3f855dca-b40a-4de3-2b87-08ddb3dc6c9b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVkrbXBzQkQwekFHdnZ1aVZkcE9qSnlrMXgvUmJad1NVdjFZaEhSMUJmQWpK?=
 =?utf-8?B?OWxVczN5RmpOR2tXYkFkQzM1MEN5WHZqZlJaVnp1ZU5Wbzh4ZWdNSFNUM3c5?=
 =?utf-8?B?cStHaStkcTJTWTJxcDhsRm1QZG5EZi9MNmFhanJ4M3g3VmhTMHBVNVM3Y25U?=
 =?utf-8?B?RzV0OWRUamtrZGF0RHVNNnIySmVhWURZUHhraitlZUsxdnh4dDNYdWhmSVg0?=
 =?utf-8?B?N3NUb1Jtc1NLQ0Fid2xoRFFkdzBjbXVrZVorZnFUaFlhSEo1MWRsSDNPSSsz?=
 =?utf-8?B?WnZIOXU0MUVmNUlTenNCYzNDTXdPNlZvZUtkZFd6b0lUVGFlekNZVGRVTUhN?=
 =?utf-8?B?QWFhM3RlWnpiMy9PdVVTTWJIQ3lrZWc2bkZ1R0p5cUtXWkVOUCtCQVFveDFJ?=
 =?utf-8?B?UXptVFFaMDhRWC9Ld2praEkrMmIxZWh0QW9YaFI0WVV2eHdVcVBncjU2bldp?=
 =?utf-8?B?RkVPMDhrVC9LWE5vd1V5MmZjVDd2REpNQllMMStHVHFzY3pITXNqZjlpbmtt?=
 =?utf-8?B?aFZWaGVjNDFucHRRb3UwcDhuQ2c3UHpJdmJ4VEpNYmVhaTg3MHl4dHJPSi9H?=
 =?utf-8?B?SUhhUEFSdVZXd0dDbWcwWTlyYU4yYWJMZldZL0VReXo0aGZESFQzM1BuWEpy?=
 =?utf-8?B?QlVFSUlRNmJ1anVFNkxIRjRhWWp3Z3lSd2Q1S3Uxak5QQ1BVd3RHMGtZdFY1?=
 =?utf-8?B?aU1CSGl3SzhVd2thcmM4Z0N2aEdENEVkWURjdTIyaWpLWHpTQUpzNVFaaWpM?=
 =?utf-8?B?RHZFMGQ4eU10RzRRT2hNV3Rmd2lyNzBMcFR6RE9uZFpjVXp0TFdqMFpTd2w4?=
 =?utf-8?B?allWYVU5WFd6UCtGdHRmQjI4VDZkMTY5bHFWYVYyazlrSDhxSHk1dk9obkIx?=
 =?utf-8?B?SjQ2eVcwNUIyOEs4MDJyTGpQT0l5N2gvbFZvTlNOZ3BtU25ycXVPYXZhUnA2?=
 =?utf-8?B?SGJURHVjQTY5Nzd5VFpUN2NtcGF4TjRVZE8rVjQ1NmZCMGxEay9sWnlpdURs?=
 =?utf-8?B?ZXJ2OGQ4dDlqVVk1WE9RVVoyOG51bkRqcmRlQllqWG9GQXVraE9sOEJWK0Jm?=
 =?utf-8?B?WmZjK002NnlOTFhuekoyU2NJRXpLTnR4Q2tKZHdXSmhTU0VJL1ZSbGFSRHRQ?=
 =?utf-8?B?bW55N1RSQksxNzBQQWhzTEZIOXdOb1UxUERqVkNkcmZteURaTXhEeERxQWNH?=
 =?utf-8?B?TVdYQW9NUWpOS0ZBRVR2NVI3SlNQdE1wcEFEdERyT2owMzJqbnlzT3phcEdo?=
 =?utf-8?B?ZTdpemtzMVJXYlJIS3U5aTR2YkUvMVl0KzhuOFZVWFJFSzczSlRnMlFEUHJI?=
 =?utf-8?B?K29SWmpsbmJ3SUpOdHJ6c0lGRUNCTGt1aGlWTjJTejhkZmdRZWhEVW05MEht?=
 =?utf-8?B?Q2tpU1B5ZS9YN3FrY1pwV1NuU3BVcWxzaUlMNFRRVXZTK3BNWTVpdVRrOXYr?=
 =?utf-8?B?S1BvYnZRTlRVd25WY01EVFZpWFUyd2diVEJKK3o1eWRSZHVQTnlLRUFpZ3k1?=
 =?utf-8?B?bkJqSW9aMHg1RlNpam8yMUxCWVp6MXpJN3lEa0VzUll5Y1pxS3MvR2J6bXhv?=
 =?utf-8?B?U0l5RHFoWTlRT3F1NGlBZGFQTXZYQmQzdThyUGN3N3VJVVN2SXlUemZZVlRG?=
 =?utf-8?B?K2psNmJNU0dNUGpBeXRYNzhvV09uREZwWml3MXhINzZrSXYybkduV1FQM1Vs?=
 =?utf-8?B?Q0ZFTk4xZnp5bDJCOTNkMDgxSnZOdTFLTTdXZWNmaEhLRVplUXRjZVZiSGlo?=
 =?utf-8?B?MkZZRXFxdEQvT2pZOXhNREtWQVVRdld0L2ZUbzZXdksrdEpoVGhHUm1lYkVU?=
 =?utf-8?B?d1JINEJycnFiTm9zenBHQ3RFL0JKRUFBRzlVMTAwanEyYXV6aDZtMHJSNU9k?=
 =?utf-8?B?OHFFOE1TamhWTjZ3MFBNKzEvOS9yZjEvdGEzMFB2Smp5THZDVTNzRm9vNHBC?=
 =?utf-8?B?clE1NSsvNktQem5xM1ZpQlcwSkl5NkQwMExMMWpWRnRKODNHWnBYakkyaTdo?=
 =?utf-8?Q?klQK67eUivbc2+QkhQhHldUU8YzCvA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUFPVzRaZXl4WEN2OHhjcm5EYTlENS9aaHZHMk9oZkoranpQcGQvZXIrK0x6?=
 =?utf-8?B?d0lEc3VzZTc3NDVjTDJCTDBIbTdZYjlabzhrNThRbXpkVlVYc1owTklRTU9J?=
 =?utf-8?B?UTg4WmxQNDhqVFI1WEhNSlgyQUpZQ0JQZkVWdVBzcjNMZGhYdVYrSmpmeDRO?=
 =?utf-8?B?eHUrVitZZEZPMnNYN1kxWWNaOXltV3N6SmVqam5pNjkxcmdQbmh6ZlYzZ3BJ?=
 =?utf-8?B?WXNYbnBIRzVQSTExMGkxRzBRbWp6VGh6Tnpoc0FCRUorYWIyZWR6Q0grSFhz?=
 =?utf-8?B?K29pdGFRSTd6aGNmNmc5ZE5iVjZQazBmZkRZUDArcHRqSWhSdW83MWZkNCs4?=
 =?utf-8?B?Z25pSE5UMkVuaUU2d1JLSkxIejh4U0U3R1RtK0lwYUhVbk8xTEZhbE5MTS9W?=
 =?utf-8?B?OElmdFJiRVNXK0ZqMVJUbTZWMFY4RksvMmJrRnlKRjcrNUV4N1FyczVRUU03?=
 =?utf-8?B?dksrTmdUd2N1eWdiSVpRcWtRRFVwRnZFUW5rVzM1dTlsbG9kMTNWU0dhaWpx?=
 =?utf-8?B?c3UxTnVZbndMdjVZWCtCNFlxeG1MMVNXRDFnVmJUY3R2cmw2dUp4M0E4bFJr?=
 =?utf-8?B?VUNpSFdjYktkWlJOQUs5OGErWFpkUDRBdzRYTjhrTThOM2RIb0ZsZ3NSRTg0?=
 =?utf-8?B?MHkrckJCU2pjdmk5OGFldDlwR1YxN0RLT3NRN2V4WHRnRW1weHlIQzl5cTFa?=
 =?utf-8?B?VW52emYxVVVxWDVSTFRHb0pSZS84bTIwaUVkWUxpTzNUL2J2dmx0S1VNOFVq?=
 =?utf-8?B?djhnZFpLbnRaWWREZVE2cmx1OUE2UE1qWE1kY1hpclE5NENmY0JmQ3NhYTBz?=
 =?utf-8?B?bTdvaUdBejJiWFpvNlZKUThZMFIvL0p2KzA0dmtYMlAvYlhidFNaUjFsaVh0?=
 =?utf-8?B?cVVuWVU1OTE0ZE8wbmNFcXJFRlcrUTF2cFBZQ0Z0K1I0TlJsbGFDdVhWMG1q?=
 =?utf-8?B?cDIyanRZMnZ0K0ZQWTJmbFpuYjdwNGVwTGNBTDZSblJ1N3lXaGJYSnlaV2Ey?=
 =?utf-8?B?aUxlSkFMWWh4WG03MWlhbEQ5elo3K203TEN1SmNoK0UvZmE2MHJ6aGs2Mm1F?=
 =?utf-8?B?MHBPYmxvWSs5RXBUVlNFbnNxM0t6Rk9BcUZ3c3lzRTNLWEZrZGlBcENCSE1G?=
 =?utf-8?B?Qkl1dGF1M09QdnYxa0NhRTRLbDhmdDhibTBqMlJCNXlhSFV0TER1b0NlVmJI?=
 =?utf-8?B?QnFuSTB4ZGQxdDVaU3lJenh3bUJ1ZWQ5Q2EzMUJ5WGNnTnI1VVY4V2E2VE1W?=
 =?utf-8?B?WmVzZlZmRlF2S0dCM0YzcVRCYi9ualB0QmsxQTBzdHlSYnRHeExmOWpLK3VJ?=
 =?utf-8?B?ejk2bUpZb0JyNy9IdUhXdlJUenhnakdWVXJTTXkwa1gzTTZ5Q0ZwWlU0TWtx?=
 =?utf-8?B?dmlXNWpHdnRCckpncExHazkwYnBqcE1mWnJkZTBlbFJPL1hlaEVOWnFIU1BZ?=
 =?utf-8?B?SjFHRUU1NTBuNkFNSTVSVEoxRU45VEtSeFpIQVdGdnU0YzNsaXFBajc2S2hZ?=
 =?utf-8?B?Z1hxU21sYW9oYStnb1VRbTQwazdvVVU5bG4xTm04dis1d2NHNGVtWnhIUEFk?=
 =?utf-8?B?WHd4bUpYbmZyZC9LWlNYa2NYSXZLUUhicGxjN1gyRDJwNENaMGtXVnlvbzJW?=
 =?utf-8?B?U0pqSlZSVWlPK01FdUg2ZExKRFNOSVhyWFg0eEgybVhjRWd5N2l0SmtnNC90?=
 =?utf-8?B?S0ZtcVRBVEhIczVuNnZQdTVSSjdWekFxcGRUdWRDcURQYzF0Vk1KVWs5SUFw?=
 =?utf-8?B?eTBURU1XR0gyUE5FY3VXWVdHOHQ5T2MyUmJlM1ZZZFRKaHdMU0F4RE1oV0dq?=
 =?utf-8?B?ODFjWDRjRGl2K3N0NDFpV0cyNkI3QkJwM0pYZ0xyN1ljSUZVT0ZoZktMWjZa?=
 =?utf-8?B?aFdHQVRXcWxsSUZ1RnJRM2tLNkVpRHdLd1hpSnJJcUYvSW94VEVLc3pWeFlt?=
 =?utf-8?B?TGdLY2duK0R3Zi9kVXY1dkNOaVpRWU9lS002SXNNWlhIckk3d0JPVEZOUkJU?=
 =?utf-8?B?N2pJS2EwdU5Xeksvck1CVTFQVmhNM2xTV1V0V2wyS0VKZlNuc1BydlkzQ2hK?=
 =?utf-8?B?STRCZkdIK1hQRzlkQ0tZMDVRcUFGL2lLVU5TanpXTGVDWE8zemdrRkRHTFp5?=
 =?utf-8?B?Z2NEVVhSbCtnSkJRRWZEMktuQlhVeFRUdERmbGluc25HL21xZEwxaWpsbDFj?=
 =?utf-8?Q?VE5z3S91SylDzsAZHMmSYxk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7FBEDFEBCEF5143BE800D887F4A781A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LKcZ7sBHPrfAnveNPmbOTsHHQNQbbfx8095T8ebZQnLPUR17WXZ/F6lQHeDwGM3O9xibyzu2pPsvYjzn5IaUnldCb2JP2o9U+Q/Zk8ylkGO2hTlu+2p3xw/S3vYx7qDcqab6fBdJsLc2Zpz27pWs2/1bWC3oov/7dKfaKtUMZZg8LRu+EJchrHL6uV/l231rtQWPMUcDazB3EvLVSn0j56Vx0gyCzYrETLAIpU383G7AjgX5FMtyN/7GV83ljSQhzyRtdiyLkf8/bc1atDjGBmfxh1bynpFL9d3Bu8/L/Hrh0dmgvi6Hgm5as8+YZ/kXQB2BCzo8tksliO/fTyoALIXLX1s5jyaMSBuyrYrcq3F69bXNmNzhvszbDnHac5rj3AQJnAtMWaixAbgwI5p762AolhR6kIP5bFQUsqtzPIgmOuyQCVtNr/9cL4YiAujL8SSc+6SkH8z1rCR+vfI+s+9FP+D32h204vb5Kti12VE/4PWcBOillJKL372ZaE5LeC8tY6HB6LtwGrMxAVlnlRbgQUsbfe14ycnKrcmoaknw/Pah6tNFQN6PFlFudG2tj2aGn4AI0gUvTvYio4yswWeHH/TrH2CzLWgUZEH66vAqwOGCVCWoRxhjSPbw+dAp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f855dca-b40a-4de3-2b87-08ddb3dc6c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:35:45.2153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRTG7KTXqTDe2HQuUZ1g+VcejTr7uQovCV+bzEL8aoGF7hCzTp9qC1GHo/lQP35ERsJsIMhFvCc9AbMcsGolOk2fEtO9faXCfc6mZ/TCmJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6857

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

