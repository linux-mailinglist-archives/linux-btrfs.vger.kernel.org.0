Return-Path: <linux-btrfs+bounces-10841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE262A075E6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 13:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66893A8665
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E06218596;
	Thu,  9 Jan 2025 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ils2GHvJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FiyIg5eu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0282185BD
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426434; cv=fail; b=UTt0tyv0pqfHRSJhHkKTwEaVU1Jm3IXiu+EUqRTIaauhqGxKQ7EKN0ZWiY+CJOoOSkW951TZh9dqBkqN9lFe6SZYv1OpMC8kNociBglU4XuS0y9IQKPr1q4LdlBcTXR3H87nE07yog/TWRytG9XJ+RGmmTSas70SF9pNkGHhPXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426434; c=relaxed/simple;
	bh=75KnLA6E0lm3WoV0OK8eLSsAk/enpW4i+FiPd+T8Yk0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJx+tjozljuTOsa9/Cr7W2Stq+DxN7M5asehGQzZ8m3+HtWwpB7c9M0+vJ6P1mAD8DfZdiEflCYmpMdSdY19l3kT0/w8J4SSXPPp5QXUwQ1+lBlx9B0e1TRIRbfCVawP+NjYWzYOylw+tCNQZA/mooX8zbNL9KME+UODW7pqjjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ils2GHvJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FiyIg5eu; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736426432; x=1767962432;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=75KnLA6E0lm3WoV0OK8eLSsAk/enpW4i+FiPd+T8Yk0=;
  b=ils2GHvJZIV+I1Ylf/x0MGtB+oxiKHN3L5657xZei/9QP/SODceo+Wu5
   2K0acXb495QP3c0G3qtxjCp862RpAaVZAcBpy6tv/HjWs/GCjnEAHkn+h
   XG7rmxR0KXU/cXRV9Y/xbt8fbZ6dlwCqABBLRXDZHsJEeXWQVnfxsQWXq
   DjCiBZZsskzpfIMguIU6ggjfhfRKURacLghTcXB6QMnezShzDJ6pGmy8j
   GqxKLpX7ieDDK2ajxTZqjalPr9XVvFG0rwH5x3SOvl2H12GD/rozQBFNl
   4cwAMsT956SZi3lwSLB6yEqsuQ2lREBZLxJV1SXp+t+vbnayG8XG7Z5BT
   Q==;
X-CSE-ConnectionGUID: IH/sf9IhSliR5oBUfy50rA==
X-CSE-MsgGUID: xMQxalyrRvyetDtxk8/7cA==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="36595754"
Received: from mail-centralusazlp17010000.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.0])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 20:40:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wESaL3smQDfW4RbeBzpPxmU1J5OfNAoz9BJ/n9H8WniPbUlqtX/eJKm+nyCQMERzn4cZCLiZxv6VS4ry0cGGJf41BzY45GR4SkvOgGC/eo0Oz6LGuYfbXGN/cXEwwLx6LNa/D/nppDy1LQ1S9Q9IyYOrNI6pP6bey6EFOTiE3fISrca70uvNGkz67PHhNqoYto3qwWHIFmevkkz+Cn5XAF9n1T53Po5Zs+aWrSPAED6rH5Cwj/7QzZSuzSOb+RgqQzBP55YCaEaYBDvJH6MsiZDQ7u5IlPWW5T4B6kZCI/R9cUBfE2fFf90a6KGvsv986fd2Cva5yX57pjkDWzbccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75KnLA6E0lm3WoV0OK8eLSsAk/enpW4i+FiPd+T8Yk0=;
 b=BJg+jBneGN5CxKv8Ygcxl0uYusHEY4dwgFbV5KVh/NFOf+Z6HAEBCZBR7hjREJHeSsuPZI8PJExW7ukSoGWoAnjsKa47GhUitz4Jayd1DoQ+omNsI4a4GEzozjkSfACJEduNf6Y1Kud9YDHueq7E/Woig0OHZVg9glE6U//OjRKngP7ryErwk8E+khmvj1YD8qm45oTAOavlrjqe+X5gsy1zeNxq3SzgIKIG2DPF0LXqY5ozJeER6+Igmz8G4vhkKnOlv0dR8DGXmI3JyO8kfKFu2nBCjHzXX0EbAkC52mzYWaKoBuSVeZx5w1WiEwlRQvizjyPiFRF2nK7NqlcXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75KnLA6E0lm3WoV0OK8eLSsAk/enpW4i+FiPd+T8Yk0=;
 b=FiyIg5eutdpXbUCgoJWtvLCdPfTZfQuvk/aHPAho00hGLCwqCZbYcn1hyh1RPo8fvm6wBek1OohwaV/hmIDBuAg01wS9AXVfstlVzBPrOZtwIniXdGWTgXOB6J+Cqp8VD48IWIt6FOPdzHI+M2znVOMbQPnNnPZIZsnzyf3lV5k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7852.namprd04.prod.outlook.com (2603:10b6:510:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 12:40:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 9 Jan 2025
 12:40:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/18] btrfs: switch grab_extent_buffer() to folios
Thread-Topic: [PATCH 12/18] btrfs: switch grab_extent_buffer() to folios
Thread-Index: AQHbYoEiy9He0ECEP0ix8t7+6sCkJ7MOYk+A
Date: Thu, 9 Jan 2025 12:40:27 +0000
Message-ID: <8b046e03-6660-484e-9659-b18bac7ac5eb@wdc.com>
References: <cover.1736418116.git.dsterba@suse.com>
 <cfc1126823c5690264d55a5186bd60381498bd8b.1736418116.git.dsterba@suse.com>
In-Reply-To:
 <cfc1126823c5690264d55a5186bd60381498bd8b.1736418116.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7852:EE_
x-ms-office365-filtering-correlation-id: ad298009-6571-4bff-3a2c-08dd30aacbae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUcvSG52Mk5ZMWxCRW0xeG5zQzFtQ0RwM2QzY3BXZjlhM0ZqZktSUytDbnRi?=
 =?utf-8?B?UWRISkxoUHlxTm5vZ0RZcGduTCtKQUFyZHZtY1lVSi94VjN3ODdWUjROZm9M?=
 =?utf-8?B?ODQzTVI0QVVYL3FReE9iYWZuQmtZS3BwNlZIaW9iQU5RY2h1WlZyVzBoQnlT?=
 =?utf-8?B?TjlHOWloWkRtSGxlMWcwOUdnQnNScWp5amN2dy9wc2cxOVdzQWlUMXlPdjJP?=
 =?utf-8?B?SWFUc3BoSDVzdnl1aWwwQWIzMUtXMTFHdzhDTHYxYVp1czZHY2YvOW5BS3dR?=
 =?utf-8?B?RDg2SVpnbG1WdlZCc05yeWdmT2tlc3NmbENNc3Z1VnVHVEdja2lxMEJ0dlRW?=
 =?utf-8?B?UWNzbVR3TDZ3bEpKdTNNVlc4RTdmRGh3M1FmeVBadFRzMitvVDRSUGwxT1h5?=
 =?utf-8?B?SnlOZjZTN1BsaDh6ZWJUbEZ0Wnp3NFF4NVMvWDBvNW14YU5zVUhKamdpbTFr?=
 =?utf-8?B?cjZSdzBpRHM3RVdWQkVVTTc2SHE0c2p0Ym95cHp5eTR3T2VueFFjZnZXSld1?=
 =?utf-8?B?UG1CWHJObGlrOHg1bDFMYTg2OHZWU1BKQkYzZnZjcFBvaGc5TnMrYlJYck4z?=
 =?utf-8?B?WFdXOUo4TUlqeXdkUmI1ckVYRnVqeG81c3BvTlI0ZThuaWJQRkVKV0c0MVJm?=
 =?utf-8?B?K0MrVEhTTlQvZm9lUG5jOG5oSEdLTTNONFJOOTA0Yko5OC9TTjk3Z2dQUXdR?=
 =?utf-8?B?eWF5eEViSWlGaUo4VlNyRWdSK0p6Um9JTEFoWHhQWGpzajZwOHBzSEhhMFAz?=
 =?utf-8?B?VEJZVmhkd2dWenR3UllIbnhHS1ZSdnJJcjVxQjdpQ0lxZHdab1h2N216MkJa?=
 =?utf-8?B?N3BVU3Q1cWJDVDQzeFA1ZFlJUnBKWGg4dnpPQ3VhYnNKK3d2QU01ZGcxdnBQ?=
 =?utf-8?B?bmpHZXlaK01RYXFxYXQ5Q0E4d3ZHR2NHR2pNaFM1Q1lSeEk2dDlKWVk3ZHJl?=
 =?utf-8?B?SmxtN0N0WkF4aXhxRTk2cWRidnpzZmk5SmE2R3Y5RE9ZNVA3cGtOVHc3M0JU?=
 =?utf-8?B?SWs5dVY5aFhYYW9EM0lFZWM2T3YwcGJ5Mm9UcVpuVWk0dkE4L2lDZWc4MjV6?=
 =?utf-8?B?VjU3aklhM0FsbmV1WFh5ZFdTazJ2Ni9ZaTRvVWpndkRpQXNyNHA2KzNkMjlJ?=
 =?utf-8?B?ejZYNGJYTE05NzhBdFVkcjFGaXhWZnUwZm44S2o4Ync0eWtCd09qSUlpRi9M?=
 =?utf-8?B?blVKR29Nc0d5ZlBBMk00L0FTSXFJNCs1dWliUHJPcVg2dkMxRkpuUEFmNW00?=
 =?utf-8?B?SlpSQTFaZDkwOW1DUm9IM3BDK3Y0OUJ0R1RhTUdkWm5pamVVS1pxN2RJQjVs?=
 =?utf-8?B?SnA3ZTVYVlJRdnAvNEhJbzlZQyt2WHNReWFWamloZU8vSi9qMzlSNGpURVZQ?=
 =?utf-8?B?czFLMHdTQ0diMFNtNC9WdlJNY1hyM1NROW9sck1IZFRXek43UEhzK1g1ZXdZ?=
 =?utf-8?B?a2J5QmlNUFRhT1JmWWNDR2hBYjl2eDFwZ3BtK3o2UThYSHU0NGdPUFEyUDg0?=
 =?utf-8?B?cTNJcWovdTlyUkErR0pvb24vejVubStrc2NVaVl0WFNYL0pCMnRBSGQrS0R3?=
 =?utf-8?B?R09BNjRBWWZXSlkyb3hrWGdpcGtZeEtqVWg2SUdCbXBhbDJlTGswVUxhUEZV?=
 =?utf-8?B?UHJIMjlGMGxDY29Pc1QvdWpydTJNeGVvZVhjb2U0MUVJOHhDUy96YmQ4QklW?=
 =?utf-8?B?bnQvZk1EaW9uTEdLQ1VVL0RkWGhldXJBOG5JT1NqSWZURzlCY0pzL0Nremc0?=
 =?utf-8?B?NXdiTUxHdTR6ekg1T0UvbFMxLzJxMEVDTGpXcUtBbGhwamZjK3h2SEp2L2lJ?=
 =?utf-8?B?SWtWcjBnb0E3ZEc1eURQeUgrd3E1WStGeXVWQmo0SC9jMXJ2bzR3ODA1UXhw?=
 =?utf-8?B?Zzc0SUxpVlhWYTluSTlvaHV6N2t0RHcrQk5QNjh5TWIvZ21BOHZ5cDdtZEIr?=
 =?utf-8?Q?BjXm5gUffu1kksWAeeDUUo1aSi5j8b2v?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUE5R09lWmxaN21BR2YvNCtvdEl6Q1N1OHYyTVY2dHByYkhrMkdBdXNkVjlv?=
 =?utf-8?B?MFVqRjFneEExdlVHSERHV2VrSk9aQ001Q3ozb2lzZ3NzQ1JoYXp2UEsvMFlM?=
 =?utf-8?B?bGhTTU0yVE02WGpTSG5qcVFpcm5zK2xYSVNqVDdmbTcralZSS3lRbTl5NHZO?=
 =?utf-8?B?WE95Vm1Xa2FJOFFnMHNodGYvMjJYTGVlOXZISEJoS0xZOVZwYkhYZCsxSTBj?=
 =?utf-8?B?bzlmUmduOWVjNjRlazl1TlRCYkNHSmxzc253aW9HZThnSWZuSlovL2FueVZs?=
 =?utf-8?B?MzM3Z0dCRWpOVjd2c2R5cGJvem1UNVlra2RTMWp6cVRyMG1aSUQrMGh2UXRt?=
 =?utf-8?B?Z0YwZUlFVDRPeFB4ZUUrN2NPM0lBeEF0dXVaMml1eXUySUZpTDBwS3RHcVZK?=
 =?utf-8?B?UDZCWGdCQUR5MExDdy9IOU10SGJqcHdqQ1NUWUdsbVByMlNNV0FvdldIRWpt?=
 =?utf-8?B?cEV2ZVhCZXFqSStKNG1mWTlOdVJyZi9qOE8zejhaNG0vSjRGc2Q0UHRWclZ5?=
 =?utf-8?B?L1lNRFNRaGdpcHlHajB0SkpkbVZYd2krRzczcEU0UkE2ODY3Z05yaHRDRk1r?=
 =?utf-8?B?UGRwdi9HK1hHUzlxNTBWRG5DbDRqSHV2SWVYa0FHN00rZ2JtWitqS05iWFdn?=
 =?utf-8?B?a1RvREZNOXFINGtZeUVXaWw3UUxtNlVuYUg0VkRKY2RmRDI2TlRjS2dXY05N?=
 =?utf-8?B?QXJ0bUhmWlBsc2s5bTFza0hjQVAxUGJrOWlMWWtqd1BXaW1veGE5WTlBZTcx?=
 =?utf-8?B?TUlZM1AvMHlzSHpoM0dLam82eVVodUhzbHd6OWVQZUlLalpwSFJROUZrWlU4?=
 =?utf-8?B?WUJsYmJFUnp3SjFPTWZFZ3ZFS1RZYnBlUWdFZTViMlBiOEF0NXN5NlovV3hX?=
 =?utf-8?B?ak93aFhpM2NZcWRSbnpiS1VTbE1HUHJMSExkWGUycFQ4R1lOOWpLOVJ1VXpL?=
 =?utf-8?B?eTI1TExESExTYUxlSWdXZ2xHV3BhNDZQbGhJRmExYTJtQTcxOHlxaWUyUkt3?=
 =?utf-8?B?ZGZqK01XYlZLUG02bEJJcWk0NUVjTE9zUUJPS1o0eTc3OGJQd1VyZHdYd3lB?=
 =?utf-8?B?eFBEalZBOSs2SmFOK3MvTUtzeHRRNnZBMVQ5UEFTUUZvMU96RGRodXZ2dm5J?=
 =?utf-8?B?OXM4NjlSeEFPdTIyVEt2ajRRb1BrcDdkbW5hMEswUklJOE9YMkMwUTdFQ21Z?=
 =?utf-8?B?d0FWT1k0ZVpXNGMxWStHQzRZYXdTRXRPb3VqdG85QUNFSDNvZCtsajM3VDhh?=
 =?utf-8?B?c3V4SDk5TnNrMTJGRDQ5MkUxUGtqNnV4aEl4Vmc5N0xzNWdwUmFrcG90Q0JL?=
 =?utf-8?B?OUlXTXFUMkN5VUJHSkFKSWZvaVNESGl3S1hQcUdnY3pVd0N2ODJ1eGJFc3VC?=
 =?utf-8?B?cmZrM28yRDJGa1UxQlpDUnBobGRHNnVITjJvOG0zdWdnenF0K1ZvbmVkUTZ5?=
 =?utf-8?B?bys3Yi9ZNThYaU1LVkVUeWJjbVRYaktCQnRJV3NLSTA4QVZkZkVjM2ZaLzVB?=
 =?utf-8?B?WUpoczRFeVg1WUhjdU55MXNCbTRSa0NtNE1WQWpmbEJyS3JSN2Z2NFhJQzAr?=
 =?utf-8?B?VFVIa2VzRGF0WkRYVzdMd0Vvd0pvc1M3Y3RGT05lbThVV3NTcUFTVXBMNWU5?=
 =?utf-8?B?VGFyZFVCMHQ4RlB6cWJLYXN5YzNRdHVIY0xYdjJkeU81YW40OCtLdUdyb1VL?=
 =?utf-8?B?aStxeE5INXhGZllqVnlvTXZPdDQ4dDVURytEZXI1ZmhXZ1lpRjNGTGRZNTRn?=
 =?utf-8?B?R2Yydk5iUVdxN2lUWk5ZdXVWR1N1SXdqYjB3VGpxdXhGaUszSVV3TmdRaGRV?=
 =?utf-8?B?MGlta1M5SlorbTJxbjFtVnk4QjRwOUREZGJscTI0c0hXeVR6aExwc0hzSWlv?=
 =?utf-8?B?TEY0eTRwRzMvTWM4bVd3dzQ1S2dQUlpnREZBOWlPS1RPNkhjeWVqWE10ZFpO?=
 =?utf-8?B?SmFUN1NrdmVNMi9naHI0cGJPMURTbGMyd1l0YW9jNTkwaSs3R2wvL0N6cnh3?=
 =?utf-8?B?ZkR6cXVLOVMrUTd3d0QwczhHaDdNUGUwY1RUclE0VXU1cVJSaWRkMjQycERv?=
 =?utf-8?B?K3MxbG5KOFVOUnN3WmkxY0M4eWlaSFlaVHRUSFZvR3EvU2pFWUg4ODY0dXM0?=
 =?utf-8?B?b2U4UzNiNTE0UmhidlJrcitWNHpCVUo4WGpuMFkrVWV4T2RqOEdWalZXVllO?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FB8FB316FE9C14687C8E0D75BE993A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kPjnD6jdnZCd7dTYTfdRvty1QViBetVopm1aMvlNXA6sHTFQKorzFabz9wxp+mii8Sh5hhSvrJs5+lXjw49XmrTkJaUujdMZbage6sFaIS1cIkKuu1GSTnsrcs6+ZtAXxDnTNH+Zraul5wRbWyl280XjvzyBrP9p55/QWCDwYK2R2sAPT9FpHMyuLOZG6zsj0RoJIwYjWg+x8JgBI5QnTeuL6ZuO5p25SVdvJYtTNIkvPYtzmaBqJZ1TFSbpC+tvj0rdugGSXD3iqTK7vF+2WaQyTFlFuaqIEf06tTdZPmLyBDJQ5I++AFY1Fp8I0OPPsslP4K0XEswbAgl5BDbF3Bu/J7OiVl0Qz9GThWQ10YDs7LkBLDKLnnz/XqxNhy5tNkpHnmtLJSZHTihFH0Wi+V6ciNB/oYudxATci7aUV/FOIpCS/ep9FQJzrc7waWtcBdQeNqkaBFchZXRvSMfvyNQ4ZiH20e8zmpr6+pWVVRiHnCZ6voGQjQburk/V/7L93g6KeIj/0krwgDKqFxPHXzbunHxd486ji5JlCwEOHLC1krakwoTH+AxG/LM4oHVxGFzRQbnpmYA4/c6J2+2KFQDkRcJXOgd4lKjYrmiXaOxySe0Lp/YebipFSIgrdJmA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad298009-6571-4bff-3a2c-08dd30aacbae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 12:40:27.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NB7ac5WbOiGSCBuIONPJ5IhAEpC720sac6+bfTo7xUKubok8Vsv2YypPrNK7m75kxhhs/cqHyOrBBWp/vyheWzY/NS+5RqB/DVt5NxPUDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7852

T24gMDkuMDEuMjUgMTE6MjcsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gLXN0YXRpYyBzdHJ1Y3Qg
ZXh0ZW50X2J1ZmZlciAqZ3JhYl9leHRlbnRfYnVmZmVyKA0KPiAtCQlzdHJ1Y3QgYnRyZnNfZnNf
aW5mbyAqZnNfaW5mbywgc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICtzdGF0aWMgc3RydWN0IGV4dGVu
dF9idWZmZXIgKmdyYWJfZXh0ZW50X2J1ZmZlcihzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bywgc3RydWN0IGZvbGlvICpmb2xpbykNCg0KSSdkIHBlcnNvbmFsbHkgYnJlYWsgdGhlIGxpbmUg
YWZ0ZXIgZnNfaW5mbyBzbyBpdCBmaXRzIG5pY2VseSBpbnRvIDgwIA0KY2hhcnMuIFRoZSA5OSB3
ZSBoYXZlIGFmdGVyIGZvbGlvIHNlZW1zIGV4Y2Vzc2l2ZSB0byBtZS4NCg0K

