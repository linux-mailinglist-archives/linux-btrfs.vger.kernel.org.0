Return-Path: <linux-btrfs+bounces-6598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0C937801
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798D62821CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32013C689;
	Fri, 19 Jul 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c/Z6zwkU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sxeog/EL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488D13B587
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721393481; cv=fail; b=I+cXVhXuJm94HnodOYxIq63UZFQ66y3GsBnoHt4G8AecwfiPe1ovCPNUW2XLD1Bnqx7T62gR6p6EVGO85qoFF/gSqq3ALe2w9aH4WkwzGLlLxFeK8fr5InJDzSQ94nmiMirWEPAUNNk9MXc4vKyE8TNLmFm3AyTGjs8M9wBuaXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721393481; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PiLAsmBFrR5WxFF2qM7gq13PC70SN4UExo1ckdMajZmea1dTQSmaCVAQRiTNSIfRXhicwDltEsDisIJfcDoGKJndWOEjCyt7qPRyCOpccoswJ4Vtk514h0fcjGdqSSSc1+xWshd3PIQ6ckkWdcw520Jq5Wv2YV48SSZgEb1d2Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c/Z6zwkU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sxeog/EL; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721393479; x=1752929479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=c/Z6zwkUbw6XSSd3/ZHoqxeFaIRmvEVKe0GWMWXj4oCNvapiXTa6uYgl
   OtaegVIn2pt9chBJL4b+H2nJyZUsDgW+5OyvOxHiYwIOwPmAksh4GsVK/
   WYLJOJi2xMvk+H6NjqXRnfkhZylB9kCnzFqNEKsHZGCs64/nanWEjJcbp
   7o3gbCSTGt6CUEXLxUDHAkNfVa2mJrEZvyYmDuXl+SLyVDbubwJosrBDw
   V4xgGz5cqstu873Gi3Ft4JtXSnSwFNfEumn2u8hIqXwZ1z5DcE600tv5q
   5fwSEbyt8grIGKqQeUR9ZDKIsXxM8U6bISIGJ9Ql9oDG7a9DJ2fVuWmV4
   A==;
X-CSE-ConnectionGUID: 8oERryR6QP+GA6WiV5na7A==
X-CSE-MsgGUID: lB6VR7hZT+SOxcNTz9Jmjg==
X-IronPort-AV: E=Sophos;i="6.09,220,1716220800"; 
   d="scan'208";a="23229453"
Received: from mail-eastus2azlp17010005.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.5])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2024 20:51:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDKeSNxMo4WMu29gb8KG5r8CXKFTkeFW4dii+y6ldzQLxpdjpCb3ZVUPRgq5Co2fKeCLjSIOUlQysq8Sq0Y6ziQ/YKCU+GZCpVKjDuMXt2ktINgn2IM2ur37N3fbelWPZOn91l0oNCqIrIcC3faAxgZ9J4An+HUeRm8JwUrJmtFXzCx0pv0pnWD7KaDG6losVvcwi7fjh1l9zTZkjrijh5GksqynT5uFgNlrzDY2REiSV+q9Xr3WFTjuBvvraTMqjEklx+UUzs2BRAcr/0J5OSXOP1QaCr+eM5mB2OU+4svhOuzie3Z1jLe5D3i0HjXA7Xzajsg32VI6S6zxOwnPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=tyFOMmHbnCLksll0FbBnajSKkDflp5fezMDLgvnLsnARJROL/iohuHRTc7F9sehjw1Jdj2x2d/wlqNfePKlgNPb07YesemJjXPMAMDB+gOndRX0loY1Q3SmmLkkiDewZU1pYcMQS8LMtXQe9T6YQK6Vc5OeqpipRswOIZL7P3s1hv68yL/mc07DnYmNFM6tHaDfRZDi+qIXqEjLVLkKuD4WvsWxXisHMLjXImTi0kYBFOukAYpComU0BUkP0KAbf8r3P6/druhwydpOOHH2oUEFtmhkbbVA620vmYi+D058l7FE0G2xaQGOoEwhRCGdlO7X41QA5PRHGmQXJz/Q9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=sxeog/ELlvU8eObP4XJozUz8L7SOCsQeTalxgDBF6COXiT2IdX57ldeFt4TMrUVLWir3Ys1QkFClUc3lcLeaj74JfjX3b1b4E+HIik74mqaupF5EluAHG3C5FYRCqgHs6FNdqob29Ahec/FKlQc/q54IRA2dRq2YGaT8Tg5gh2s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8706.namprd04.prod.outlook.com (2603:10b6:510:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Fri, 19 Jul
 2024 12:51:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7784.015; Fri, 19 Jul 2024
 12:51:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Sam James <sam@gentoo.org>, Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH v2] btrfs: avoid using fixed char array size for tree
 names
Thread-Topic: [PATCH v2] btrfs: avoid using fixed char array size for tree
 names
Thread-Index: AQHa2b3iuVpKRfo8fkyIcDJTUEUIjLH+ASwA
Date: Fri, 19 Jul 2024 12:51:10 +0000
Message-ID: <5cf2687c-9570-4512-944e-943b8ff99572@wdc.com>
References:
 <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>
In-Reply-To:
 <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8706:EE_
x-ms-office365-filtering-correlation-id: a342c74b-f428-4bce-511d-08dca7f17722
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFhOYlNpc2lsODFmb3A0ak9XQjhzNDUxSis5MVdKNW1qK2J2UEx6VFUxNFZa?=
 =?utf-8?B?NE9hMU5DT05ZZ1hja3ZPMVFCdzhVM3FDMFc0WGlIV2owblp4dHM0NS92M0x4?=
 =?utf-8?B?Mlc3S1NvUFNRRTk3T0gzV01YQ0Rhd0JsbW1JbGl1eCtPSXJrczhaeHpRVHVp?=
 =?utf-8?B?TUMwSmd6b3p4NzVZMFdRR3lXR2VyenJ2K0V6dTlPNVh6eDlZTllGYWpKeUxF?=
 =?utf-8?B?R0ltd3dQY0lZenZoWkJ3RFluL0QrUnRTNUJuK1hmY29IaXpobE9CWC9kRTFq?=
 =?utf-8?B?WEJIMW9VVW1wQnVmYVhvNzQzbkFqTjI5TzBKZUFwQ2duM0NNSkxjTk96d3dV?=
 =?utf-8?B?aElRWnE5K1NhZ0o0cWJ5c1hFTDFHSHVuVTlrMmNmcUVNTkZoVE45YVE2TTBR?=
 =?utf-8?B?MHZ6ZWszVGhOUFpPM2d3SG1FUmw4L3hEZWdxSGgwVTl6NzMwM09oL09MMWVl?=
 =?utf-8?B?ZmMvVFJEY3dzRC9jWGFVRCs5Nm0zZzdHaDI3RlNiQmFZcXF4VElIbnBubGZM?=
 =?utf-8?B?SU9rbUxlcUNMSUlJQlp1ZXkzWVlQSHlnZHJWYzQwV3V5a2dEMXR2VEh2eEFy?=
 =?utf-8?B?OFNBRzloQll5Q3hYSms2dGlMcHVNOEdPellEWVliMk5ROUN0OGlsQkJITlN2?=
 =?utf-8?B?NVVFYXhtQVFpNzk4OE52Mk9QazBCTG1PcmpjOGgyQmozMnd2eEh1VDd3QTdN?=
 =?utf-8?B?cVorVThYOW1ZOXI4dERKTVhzTlVrRjdZYU5xaXp0emtRZVNLWkNhbG5Pb3k1?=
 =?utf-8?B?Qnp0MnR1SFdPdk9vZ2U3WXlCV29UOHBIVW9pUk10emRzZGp3UWc1TzNodGw5?=
 =?utf-8?B?VEMrSDRmcGtXN2o4V2o5QUJIQ1g1UCszZEhVd3lLTGFzVHVaLzNMemdkcHFU?=
 =?utf-8?B?MmY1NVlZUHY0WDdhUk9nZ3h4Qjg0SFk3ZWtYKzY5UXVFNGp1OFdkQ0w5cENs?=
 =?utf-8?B?QWZpK04wUkFRWkpFUGU0V3BraGVRUHA0ZHNHNkw0SWhmdEdmTHE2NFdrRE1B?=
 =?utf-8?B?K2NMaTJlTDI1dGVRb0M4dElWQUg5bTVVb01PK2VBUTJJaUFyR3VjRW5Fb3A5?=
 =?utf-8?B?Rys0T0pKOEJ6ZkU2cERsMUEzaXdTNWdvUDl4UHY4YWQvaXNMVzBIaFMveXFv?=
 =?utf-8?B?d1cxYkJua2RYVVFNKzNUcEp4UlNvNXBVWmtNKzEzTFVYOTNYV2pXTjhydU50?=
 =?utf-8?B?aldydUZBdzdJSlZrQkp3aDRmbVJRbVY0K09HbUNQK25yMi8wbWhKMmFzUXdm?=
 =?utf-8?B?Q05TT21ZUzNsOXh6Sms5a3JoVFhRRXFyWUwwQm42Y1RQSUEwdTRNaUhNc1k5?=
 =?utf-8?B?emR2QmpzS1VveHJSNFE0QzFyU29rRzVvUTR4a2QwYzdsMzJTUW9LbStCVDQv?=
 =?utf-8?B?QUQ0Ukk2K2xqUnpjOVRPSUZoWmdnQXA4UGRkNk9xYU04UVhVTEVPck1qNUhl?=
 =?utf-8?B?UjZ1WklqZDBBV0N0Ui9PYnJiZm5QclNuZVpZbFI2NHJlbDJ5dnh1WHAxbk5V?=
 =?utf-8?B?ZzVEeHpDQ05mMlhhbWt4S2FVSGZ4WHV1SEdjMDB3ekVIdUhFWHNOYkZKNGxK?=
 =?utf-8?B?ZzczV2txZXpXN2F4T3puRVFiUjVYN3h1T0V4TGlDRzI4MDh5Qmh5bFZ4dkN0?=
 =?utf-8?B?SlNjRUlFYWd1V0U1Y0tXanBLMUdGdDJBQVc0ZDYzU3ZTOGF5d2plVjRKQVcx?=
 =?utf-8?B?MzFvbUp5RER0RTdtQjZnblF6dmJWOUxFeGYrY2xWZzZ0Y2p0NGpGOU8vVy9Q?=
 =?utf-8?B?K051THdlMlpvMkdvQ1F0QndOSDUxc0JVd3NLZjhaZGRjejliNkM2c3FkdEVB?=
 =?utf-8?B?OGtkcUVGZzlYUkZQVlBJQmZKNzdKSmFBSXpqb0hHUDZCQnZMZGc4Qld3UjQw?=
 =?utf-8?B?T0tWQzBNNEY5UG9kMkE5dWpreUR4NWx1NXIvSGQydUU4QlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjQxNGxTVVFIMkx4UktyN2w3WjJScS9iQzl1SVNyQ3h5WEMrVFpOaWFjMmNw?=
 =?utf-8?B?V0ZKQVVOMktmaFE5QlRBNmhRY0ZoMG03blBRNUhJc1dZYnRWSWhCalZvU0FK?=
 =?utf-8?B?TWRRaVpidmhBNDl5NU43QTFwdTBhcG00YmFJUlBqMTFCWDhlMHh4MVVUWW5F?=
 =?utf-8?B?dEVYWWFYQVp2QlJWU1hFVXdWUitQVFZWYTZwY21DRklVRFh1Y0VYYytvUXYy?=
 =?utf-8?B?RUZMMTNneGIvYVJLZmlUY2lIRWlKVlJwT0pxQ0ZTbnpPeWRNTlBkcmI3bWxZ?=
 =?utf-8?B?U2NLR2VMdmo3Z0tNVXU1Qk5WUDdldGlFeFNaVTQrTkpUaUxSZGk0c3B6U0Q4?=
 =?utf-8?B?QmFtTUZNcDRqVkxTa0VlODNVa0xncWlIQVJjaWZyZytLOTFka00rY0NodzE0?=
 =?utf-8?B?Z1dyc3crNG5BWFhWTGtGeWI0WGF2aFdIWk5HL3NObysvcDhNMFJOTGdWbEJY?=
 =?utf-8?B?WDdZNUluTVFNbjJOSi8wVzNzY1duSFY3dlYwOFZFVEhZOS9rL2JBMk15dFhp?=
 =?utf-8?B?bWxoS2RvQ3lwZEFXakl1eWdYNm9rMm5yMiswemxiY1J3b2pERWw1ZmgzNzRn?=
 =?utf-8?B?RXlqTUxkTEpncFFUWW9VeXdaa3FoaFBPOVA3eGZLZm96V2hZazVsSjg1b3hX?=
 =?utf-8?B?d0ljSXpqcnRhUU5PYkpmMnRoY204ZFAvbTd4V1VjNm03SFhvUUZvNlIyWi91?=
 =?utf-8?B?WVR2VCtuYTN3bFJZT083ellmM0RMU3VsVE1QT1dyVHY0N3hGNW1qMERBcDJr?=
 =?utf-8?B?OEprN1RheHFhTkZVOXcyRVhwbVRDa2tRanZDbjFad2hUMXJ0VkJOTXArYXlP?=
 =?utf-8?B?bithSU5rdy9Wa09WY0FZb1NSV05LUlpJR1FyRUlvNGVYeTVzSjAyeWN4ZGkz?=
 =?utf-8?B?N0MxUGhtbndPcWsrU2ZsRHUwdk55VVJ6bHRiNGVBZEJ5UnQwQ0JLaGlmakI2?=
 =?utf-8?B?QlFPZmgrYlZPQ3VuTnh5U3JVeGJpN2pzSmVxcVZ6ZWNTbDU0TlhncTBBYVlU?=
 =?utf-8?B?SC9hNkh2cTNzT3R4R09MYVJ5TlVFVmQvckpJMEhMVXhMNTc0b1NNbDd5OFJz?=
 =?utf-8?B?Smdnd0lLZzVsTTE2dnVOaklyclptcGZkNUZHSVRwNHo2QVUwT2VFSEppWi80?=
 =?utf-8?B?RDRyY2FXVnNObHFrMSt4cDcxZWVZUDNZaS9rcUpSV2wrSkVUOGxraTFkUVg3?=
 =?utf-8?B?OGU0Vy9GNC95MUJ1MUZ6Y1ltTWVoWHZ0Z1hmVVZaWG41djVKZHNidGVQamNB?=
 =?utf-8?B?aW1IS2kzWDM5NCswc0Y3dWxET3RzNmlHNlVYTHVIeGxIZERTNHRGOUdrd2pi?=
 =?utf-8?B?Z0ZaN0NvUTM3ZURQRHNrQnJmNHYvdFVZZXlUVTgvWEloWEJmMkk4bHBDSG1V?=
 =?utf-8?B?TGM0VURHdXRBZmRoZ3ZvbHhoeHRtUmQ3REdKRDREbGpXdmp0QkFHVkhmb3lW?=
 =?utf-8?B?ajNBNzBWRmFXcWNiQ2lQRlVEdTBHZktUMVYydnpyTEM0Mm1BRjZCc1FSQUdt?=
 =?utf-8?B?RzNZS3BMcFN0Tk11dnpkZlR3eFBJNS9aZkwzUmhZZWs5Wm5NTjVDSTg1bE5z?=
 =?utf-8?B?MXZXNWNlVzFJMVpvTVIvajlkTWJpOFhpL0p0WElTS3NzTkI5US81QlM0TnRV?=
 =?utf-8?B?Vnlxem9lczRXTS96OG1yalg3UDI4MUtBbUlheTAxMnRhYU0wVExDRExaNGhx?=
 =?utf-8?B?Rm1ycXAzNWM2ZWc4cklMTVBPVktQWTlXaXpSaWZwb0djTHJIOHltQlBvNFBI?=
 =?utf-8?B?K3hHc1Q0N0lYdHkrY21MMjI5WEJlbEhhOElHTTk3c2hZQjBwcG9QeEJvaFgz?=
 =?utf-8?B?TkpGOEpZVEpWUUEzL2VUbFpSMmdnZzkxNGxUU1hBazlMMGoyWm1ydk5vMXlh?=
 =?utf-8?B?VXNoR2QyZWR2MGxVZVNVZEowUGUxSk1PaG1DRUNJMWNMZ0tER1RWcWNienpJ?=
 =?utf-8?B?TGtIREx0bW13K28reGRnNjNMaGFFR2NmOExvSlgwL3BDVVVmRmE1ak44OUgy?=
 =?utf-8?B?S3huMTJLd2RQZHVZY0U5TWFaRHY4VG1DODRZQUFwWXRvQVdMVklDdVZ5eWRB?=
 =?utf-8?B?alU2b25pSXUvZEZDTVYyUWtWL2xPZTJBaVM1R3NZTFFvbVVacU1DYnhaMmFJ?=
 =?utf-8?B?K2lPUnJ6SUE0STQ5SytVV0RkQjAwTjJyOUJxUWFRcXduQmcwWWg5emc3RjZG?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40E1F60DE1EDDC44B4D50B5683717A57@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JGBgLxXKMIuagTg6ui0AVQKUxMo/hWQWPYkjV2nysnsD3NwezyfzHs2sDIq3jlimuFiFdBMOt44vjokcM5Lq87MtbscWgdvm+jJ335G/A0817gkT4KDmFDJAH4zKfteWosRG3SULCr09jotXTky/0XQcjzeIT4gWikLuM//CPf1xiT9VLulYExY2S/JmStK1Oc/rgvogZeC91QTwEtlxCVWY1z4Lh2/Kunhpp56QlJcfn/nHqJCyI2bnZzZGXVxmqlW1PRgvefYRnsCsMeTNYLB+xAeVAsrHMku+QP1Tn0hKc37ocuJhskluzxCB6bKLs5SV47dZSGaIwyELtFfJ82adVpAhfrhA3z3OGMleUHqnWPgUbVR3pCzRwPjz/l6vLsxFsBdayzDrf/AJQadslx4laHndTt0e52Fu+6DvZiBROuE/T9KO9B/64PaTo99CL/TGLpxwFY6Kf+fx7uYRsxtOXTCo7AzCef5yGMH3SM6p7IkdejOKpnJXmFwnEHuBNF1d/BLt2m94ZrFLghfG9WC7e21E8HXRd+3eYbwj46vDTHotUn7D0XHTnAxckNswOYEYu2bKuD/xn4dSBkIXodokWH9tM9jRZZkuQbjSd+MOvkmtFwPc9knsW8mEjOWq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a342c74b-f428-4bce-511d-08dca7f17722
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 12:51:10.7110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTPhhaEFMz8mHdK6Aaes9VKtWKepWPxposO2dYAw6gP4eZX11YHzwWWy3hcupC9C1MD3Ftcn6GaYCjUdURMwBlEjNefaIa3Tr/DQBkT/pq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8706

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

