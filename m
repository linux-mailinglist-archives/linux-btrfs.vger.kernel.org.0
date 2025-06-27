Return-Path: <linux-btrfs+bounces-15036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47254AEB3F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8481891332
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9287329824B;
	Fri, 27 Jun 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YgXlStTv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RdiVgGV3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F45296169
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019094; cv=fail; b=fkr5/NoLNOvXRWuJRMUHc9ciJn/0FhZfIyHtx1MjlK7mHrpLyStaMtvN9nuHJlcrylRKJw4AG8YNpEEKVeDTzgJfRtDES/d5nDQHpgVa5KzsOyzF3jVmOPsaxPoYAOgd/4I7Q8GJtY2exxuCYKIa/yzK8miUSDd+cCNJ9tHVnco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019094; c=relaxed/simple;
	bh=zxqoINpo1NnPfYj3x976rBjQorILtIVUG15LYHhsVfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lNsM73JzyhEs6xsSpiWvzTuEJjTaArJpbmt6dNa9kp+sfqc5+mRGcnh/cyMpBMvgKtT3fFL0CVSQSdzH8rZhIE+S4lWymiYLw6/0gzdVjFNkdHyI3PN23wFaWj/J+AWVQjdXGO8k0hNxmqEjoFQ02iO4f9N1zVbG3zUg9GRUF+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YgXlStTv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RdiVgGV3; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751019093; x=1782555093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zxqoINpo1NnPfYj3x976rBjQorILtIVUG15LYHhsVfM=;
  b=YgXlStTv1qD6mbMHFZds9OAU+prczxuMpNKv2TyCNp+UI10Xhl/oAkFE
   bd2yB+6hlWsQISUePORErq4oHi57heBpGdHlqToFm5NKbkCwydHx4B6X3
   BHPPr1JfrqJVNQvZL2onJQagYV32/GIduxkzLN0HfnYK4BWM0cacpkvjX
   86z+i3KD/krjppuEmDTOLZFDpk5vjwE5kP8DOBhEa9pXcIQPyd7CDq0SO
   +qrotwH67aQFrySwikUIazSdbVwlhZsBvh+7UO3caiKo7ug0VAED7bPLp
   sba9Uf5DVoaKOPtR/zsz0ZfN0r+AzKeWEIc6xDTlomlJEO+6HJcX0xDUO
   A==;
X-CSE-ConnectionGUID: NRK1HrB2SRuUeLRgRSOd7w==
X-CSE-MsgGUID: vU9g9pZJQr6tAv/+KF/bcA==
X-IronPort-AV: E=Sophos;i="6.16,270,1744041600"; 
   d="scan'208";a="86089700"
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.80])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2025 18:11:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCHAeJ/eyxiwfnXI7ww3nkyM+Xl958/hKPZQG0f+PCrqRqywMKv7KyIwl9x08fVEbjZ//grWNNSw42EoCToWGHO9ZZwSJmfxt+gfTClzG+r2qZw86M1CohUwwwpeL04eK69ZDe6Qe4iNPT5I49vI3UZGZ0eRtJPmBU64LRL8aEWSGp4ErZoPl9gtnULFRd84TqwNcy4kQYpTTMJUZmzZ3aLD4BZUQOi4U+aT2u4n/jB/CUjsVFB0rd562t52VBqxl6YbpGH1JhZlzrJQVMthgGDCErUaHRPwAhIPo6QE1IP80ZGbLZPVfZM/6K89MiI9erYPV5WgPiyiNI3N/SdECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxqoINpo1NnPfYj3x976rBjQorILtIVUG15LYHhsVfM=;
 b=EfDTx3ZDpX7m3otWcBoXOrVkOBoPL15OSEoXvy9kOLOwv9bjkBhsT/6eeNlsV7rJjFP0JHZZRCUSLEFuLBh6lnJEEbpCrzTj8d2dYwqolCuZyVaPqtRHEihyogzX/A3dJ0SqFWUx8j1MRTtfVD0tvkNzdz/Y8t2LFZImuko6qjRy94a2xD4kyAFlIDcW7wdw/I/eEUXPrEL9scD6x7fLftPwSczHrKTbD4UDqRzHh/QdIFhnHXexLMxaCQ6m4AD1BVy0R3zeXW8f77KrujJsFtxb/mPmzIGYlK6N6DtfgQeeKZUkf9ToCoas8bj49vqoxm7vjeE8Bq2vSZFlffAfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxqoINpo1NnPfYj3x976rBjQorILtIVUG15LYHhsVfM=;
 b=RdiVgGV3lVDtaa4OkN3Ms1lYQ4a8Q7zY0o28kzSHFq/1E7gO+nGyi5ypINPArGuwCF4yS9rZtd6228jqkOQ1pctQgovTU2xykL5U8v58jMBjm0Nk7kjuykO89+h3/tA+mUjD9nIaEe6E6oJoikGNJ1mbatqd8ecmVxZGml77otk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6654.namprd04.prod.outlook.com (2603:10b6:208:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 10:11:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 10:11:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/12] btrfs: use btrfs_record_snapshot_destroy() during
 rmdir
Thread-Topic: [PATCH 06/12] btrfs: use btrfs_record_snapshot_destroy() during
 rmdir
Thread-Index: AQHb5RgmD/Fh/8dsGEayYD9FIy29kbQTswAAgAACIYCAAxhiAA==
Date: Fri, 27 Jun 2025 10:11:30 +0000
Message-ID: <ec85ff57-35e8-459e-9244-bdcb9c0f4a26@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <cfd83c633ff032b9eabe4e71ec829151461bf168.1750709411.git.fdmanana@suse.com>
 <0b60dd37-40e1-460a-839f-6b2d96002e41@wdc.com>
 <CAL3q7H4MDVZp+ie_vW_5CXwgRev4X5T0NVFu3-DypSZ_H6msmw@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4MDVZp+ie_vW_5CXwgRev4X5T0NVFu3-DypSZ_H6msmw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6654:EE_
x-ms-office365-filtering-correlation-id: de29f055-38ba-47cc-8a6e-08ddb562fcc8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajNTcS8vMXV4NUlxajIyNEZpdFgzRTJJNlU3VG1VNlFOZGhRcml5T0lhNGxl?=
 =?utf-8?B?TkNjZEF4cE1VSXM4eDQvdllCcSs0b0RnMFlEbHBBbVY1YU94VjZ5S2NvRDRQ?=
 =?utf-8?B?M1RoQkRQRTdXMnNTOFc5WUIzdlNZb0k4TTdCaUk0eWgwa2ZxNlNPMUFITTRC?=
 =?utf-8?B?ZVZCZHZEWWxRVEZsVGFLZFJkMCtwOWt1RnhPRXVDdHJQb0VYcU9FRVBQZWtu?=
 =?utf-8?B?QkE1UGV5NDhOT3FITHJFZXk0ZXE2VzNkTEJsazY4S0FXa1A1cDgxSmpPNW1n?=
 =?utf-8?B?Z1F5TzN0Wnd6N2Nzb3dOUFNHSktOVmFrelJERXprVFlZb1c3K1NYU0M4VUx1?=
 =?utf-8?B?TW83MVVlaE9CU25WT0xBekJFM3NFS1dJa0ZZa1FDemdEeEpzMVVOUSs1LzNL?=
 =?utf-8?B?TnoxOTVDdzROSU9CK05nUXJlL3M5MFNRanorZzdwL2xPL1FOUVM2SXRLVnhs?=
 =?utf-8?B?WDlqSVQyZ2Z5REcxaDZDdTB5ZHh6N01MYjM0RnpiRENCVTFWdlNPVkVYTnVN?=
 =?utf-8?B?bFRJb2F1RkUyaWY1ZzVLR3dRdmJLMmRWZ1pUM0VPejBMVVY4LzFvUjVCRkkw?=
 =?utf-8?B?T2FsL1lycXVoNS9TVHo2aXNOekNGNFE3UkFzN3FWaVc4VnpBcjhaZlJrcXN6?=
 =?utf-8?B?N3hqa0tzenN0SWpJeUExZUdTTWtjSkFyQ2M5Ti95YisrZjM0VUdvTkRhNkRM?=
 =?utf-8?B?Zk4xRFc1TGJXeE9vY3ZlVnJSQnNjMmtGQU9rTUhvOVBQaVU4ZUpOQVdjM0Ry?=
 =?utf-8?B?eXR6aTMwcVZKZ0ZBRVdqMW1jeXdGUWN4ck40emFJMnNvOXpBNFJML0RVb2FJ?=
 =?utf-8?B?STFoT1pHdjRKMlh1MmVmNmVVbUdXL1J6S1hiVmVFN2dTUTNZaW8rVU90Wll3?=
 =?utf-8?B?aWVTNVAzdDhxdy9nMlNyQkpVYTFZTlZaUW1yblpWM1NYSlArTVdCRFlsSlh2?=
 =?utf-8?B?N3RCUUtnb0NjUGljQXJlOHp0OEJMN1cxZ1JjQ1VkUDRQUGhYaGRTTVI2Rmt3?=
 =?utf-8?B?Tjc1UkRlTkdJK0NEUmtTcFhMQmZaOHhiYmtXUDB0eGpPWkczNnBWMmh3N2pK?=
 =?utf-8?B?dWhSRTlCQzNuVDVvYWVTNjhNTTFRTGY3dTlHTlN1SXkwUnd4WmtQMm1TdlB2?=
 =?utf-8?B?ODhGWlh0NjdYRTdxbEZCQ3lBMEpna21CRk8zUkZZMjlCdEl2clJJa3BmdmtD?=
 =?utf-8?B?dEhTWkZNeXNVTmpRRkI0U2FHVzVZOUZidWM0L01pRU42U2twUnd5VDBTcVVz?=
 =?utf-8?B?THpLbUZ5V1JZbjBKRVcwTFFMVC8xTXFUcmFwOHNSbXJwRnhBM3lIdnR2TVJC?=
 =?utf-8?B?RzFsYUtkT0NpM2lQRHhkUi94MUhoT3k4QWhwc1lobndxYW1Wd2VzbDRMMFVS?=
 =?utf-8?B?L3dHa1dBS09ERFZNa1ZObXMrK3dneXlaMmlyNCs1ZW1yekFGbzVQRVJ1RFJN?=
 =?utf-8?B?OWgxQmhmcFNxQ01YQ1RPRytPSUxsbThucFl4S2loWS9QbmJYSXhsTGdRMVRy?=
 =?utf-8?B?N0xTb1NoM0JKblR1dWJkU1VrN1JsRHF2RlJodDdWRlNUVFJnVVcwV2JLZVBT?=
 =?utf-8?B?U2ZFSXQ3SGpxVDJENWZITlIrbkVNYmIzTStzUWsySlFMQVRTaWkyNDdjZnc5?=
 =?utf-8?B?blFkQWtCRmhSMnR3YnNEYkJKYUVJMkVNZVhyaFR5UkMxT1g5S0RYSU1qNklu?=
 =?utf-8?B?bVhEMU1ZQ0x0dUl2M1BUMFoyS1FqZE1KMzhOWHIrdzBnT0lLSHQ3aHM2RE01?=
 =?utf-8?B?WVNBU0VHYVlDOW92ZTNYc05GSTNUbUpkcVhnaFBXUXV2UUhzaG1GK0pwNkZR?=
 =?utf-8?B?dmd1YmxDTmxMU0s0ME5GbTdzTWtWelBSWEN5YUtwMWVWdkZQYlRnVEUzSG8z?=
 =?utf-8?B?N0tFcVl0OS9sTzFkK3MxL3Zwc2cyTE1ocjUwYzhnSFJlVmgzTlNaM0o3QjA0?=
 =?utf-8?B?WmFVN3ozdnQvWUdudTVicm5nTkI5QTluNGV6K3RsWVZhcS9IVFBTNXFRZTRV?=
 =?utf-8?B?bnh5R09TQ25RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UE8rcWhWTFNoanZpbmJKbGVqbGd5OE1XL3FmVG1VUzI2U1BqaERqZndxZnRs?=
 =?utf-8?B?eWR3NURZYVN3ZnJjaE96S2ltYVRQazN4WHpESXYyaFp2VEp3aW9zZ1MwUGZv?=
 =?utf-8?B?UWdKTk84Vjd6THNyS05mdkMyU0ZOMGpJS2FEUDhKZ2RhZXdlaXVYcTROdXVZ?=
 =?utf-8?B?OGNDSEhmcC9zSHBMTDg5eVdub1EzV2hsT21FbFloaFBXVUdLMVdIREpRQ01r?=
 =?utf-8?B?bFBnUzJJazdsamJWMzd1c2RLVkNvNnF1T0pOTkwzRkZib245dWFERE9Vanp0?=
 =?utf-8?B?bWlhSFFzcC9KUllMYUJUd3BGMllaTmllYWhUcTVDbDdPTVcxRDgybjFpNkdz?=
 =?utf-8?B?b0FSdUlRWkVFTGF4VVJsSGRTMXdaLzJFUW9mZk9paHVTTDk4VTZaWksvSGMv?=
 =?utf-8?B?OTJ1dDQ0MURmaUpQVDBJTWtXaHduTFhuc0s1UkFZUXVacUVoVmVTNG9KZmc3?=
 =?utf-8?B?b3pDMURQVyt6bjhJRzE5bWh5ZkEzOE1URnYyVHhONFZkdXVDdWowSmgwNFIy?=
 =?utf-8?B?ajlWTGZNSHNoTW41SWswWk4yZ0NZMEdiSm91TW5ZZHVSNGZLejdxZXZFWjcr?=
 =?utf-8?B?d1ZmV1J1dmhiUDkzQnJaR0w1a2diQWQwbnU4Ni9sUjVuWGU4azVzU1BkU3dp?=
 =?utf-8?B?OXVTWDZITlRvS0dCYlIzSElQZ1R2QWExeDRPWUMrMHRxeFpTQ2Q3aTFTRnhM?=
 =?utf-8?B?eHZmTXYxREJ4YW1kNyt2alh1dlpIeno0a3lwUWw1TThlZVEyU01qRHhzOG5s?=
 =?utf-8?B?aGVCVkMyYVovRS9zbTg2c3pLRW1zdW05Qk5pWDkxMzBSM1A2bTd4cDB6NXFq?=
 =?utf-8?B?VHcwbTNqTDF2VFpyWmZSclowTnVkN1BkQjZoSTkyQXE2NG5JaklVY0pNNVNt?=
 =?utf-8?B?b3lraVhPaWZMYmRSU0tnYlQ3aW1qUVpRTXN5RTdzZlNTSWtxTUwvY0VKUG5y?=
 =?utf-8?B?SnBlRnVTSFlrQ0ZwNk5KTHJ3VVljNUdNb0Z2MEVNVndaWEtNSjF5cjNncFJ1?=
 =?utf-8?B?L1FuejRIejFabi8zcE9iTXlSbWRhRUY0MW9nRVpKaDA4dVdQMHY2eGNuMlll?=
 =?utf-8?B?N1FJOUZ5aWxvQm4rMDVQZ1YrYW5Xci90SmMwZVV1WTRMZEdlZUxzNUlJTGR2?=
 =?utf-8?B?N1o1T09aVHFaanhmQ2J5cUsxTFhCRm5PNGRYckZhUzJTZHkvYW1SdlpBdlNX?=
 =?utf-8?B?ZDVJMll4T1pHS1R4Sys5OGtrb2dHVVVEL2N3WjdIK2dHRitrZTZMemZYMXE2?=
 =?utf-8?B?TnU2S1V4UFNRU0ZmOG9Tc3M3aE5HYnNkU0lZVE9BRDAybmpmOGNCeDVTOUxJ?=
 =?utf-8?B?Yk13c3I0RjhHak1kcTlmb0lyMlA2dHZDZ1JxekRWbnNRTTNha2YraVVrNnM0?=
 =?utf-8?B?TUIwNHpUVjdtcnZSOXBYVHFZdldGOU1hV2xBNlFqVzNuejJ5SThXV0srSjVm?=
 =?utf-8?B?RVEyS2hSQW03RDdZYTZBdXRtUCtBWEtqTkIwNnozbGRVRW5VcFlCd1hsdS9n?=
 =?utf-8?B?KzBxWnppUnFybnowMWlNd3hrc3NaYk4rZHZGL3hHcEF1UTgzbUk0VU4yOE5j?=
 =?utf-8?B?ZVJvdjRsL0pBcGJLRmVnUC83cmc3ek1tcjF6WmtheTdUbVRjRlVwQ2FWMFhH?=
 =?utf-8?B?YkdseG1OY3ROQTVWRkJCNkJpWGFjZW05Wmt5QU5CNEYwNkxOMHpQaGpOSUh5?=
 =?utf-8?B?dDRhcHZBMm5TQ0QzUW5lN2Z4NGZrMkEreEYyczgwNUk1blJGTGFZZEVNS1Q3?=
 =?utf-8?B?cTJqb2tHNit4THh1aUlrRWhVSzRrOGVYUjhlMHBJWmtraHdHbnc2UXFOS21q?=
 =?utf-8?B?K3RiT04vUm9NMUhQdksyTi81S1I4RE1xWG9tZUpoN1BJcHl0SjcrNk8wdzda?=
 =?utf-8?B?VGlZcElpYXJiaGNxaWUwTmMzZUs0bmZFNEMweEZqWmtQcVBkWXViMzlsNHBo?=
 =?utf-8?B?eXhlREhRaDdaSlluQmZWNnNxcEJaV0dLdFhHdXNnSFZBUW5kdHQwMFk3bm1P?=
 =?utf-8?B?ZTVFNFNEcmVzUURTUU9mL2JSREt0MVBjR0d0WjU0WVE5em55UkZJK3NVYTZt?=
 =?utf-8?B?WTVSbTExblAvcTB2RkxGbGtraEZBZDk4WEtveXdhd1g5R1NLbzJXcmFzaUR6?=
 =?utf-8?B?amx0NGtzdVR1LzEzMmhKN20xNGdGQ1h3TjdVVFVLOEpsaVV5alE5VExkakFW?=
 =?utf-8?B?aUYyS1Q4ajl4L0t3UFU1NHUzaFVXRFNaYXVxQk04dWVRV3grUEF5YTI3bWVV?=
 =?utf-8?B?SGlQdVdIaXo3dHBwTGhZbXdZL3ZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AF2BD5A73E79B45AFAC4EB2D3E21538@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fmdb/3GE8ZiuEeF8l69/lF7Zk4tw/Tpd9arNJ+4KpSnTH5cvQqz43ZAKxE4xnAr7pTX8lIz02AveLYwirCTHeLbhvcLfY28iGtifV/Wz4WzRsbihmz+3QlWBT4D7Ydj6uGf0BmEVA5RyAJJDG+VQQ/hRGTJa8xlfyG17vJDPu9FVJakqIEDzzGtGdn6erbFVGlFVigDW1TAMtpUg/CnSaT1beFzAx06/ZTWwS4ZPIEoXq+GVLAyIKlREYI5MIE97b8TnjrzvHistRouTRo6dkBErOmfs5CDJMwPOfZDqYW/jQaurPB5yzoqhTGwRxSaGP+Ugiofj4fB0oCNpeVp3WuUVsu86JeI+YVIZGbYeJgpP1xkEDzcomV1pj51ljcZUWti+IoN2X9wcJvhV8RzC9sSEfQT0r5Pa0pAQalBXjCNCzTMnco8ktF6Hzo1CDS/89Sw3+T+GM3NZNrAQ8Y1MTKY9OfEmmqn/3bd4LEAiXNlE/SNoKR9ppANBZ4YHaGyUf09gKfTdx92eSPioIB5Gx75+829MMGfmDYPkFgCS0vMlZKuXi3orkHqg4LrajxKwCELIYYlwxNn3ACVa8vIm3qr+9TAn4ECcc4/jidXcZY/qTrYZ8KPPU/zh0sfMNZGV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de29f055-38ba-47cc-8a6e-08ddb562fcc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 10:11:30.8764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/bZ1WdR+aiCary4nNzTBSo55TKfgcVLYCvJauT7m0keLJmUMD0EOLcnFX1O+inlzBUDieDAnXAz+gbGPo4xFaxvlL7GpYsgTtuTGzWz4Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6654

T24gMjUuMDYuMjUgMTI6NTYsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFdlZCwgSnVuIDI1
LCAyMDI1IGF0IDExOjQ44oCvQU0gSm9oYW5uZXMgVGh1bXNoaXJuDQo+IDxKb2hhbm5lcy5UaHVt
c2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+Pg0KPj4gU2hvdWxkbid0IHRoaXMgYmUgbWVyZ2VkIGlu
dG8gNS8xMj8NCj4gDQo+IFRoZXNlIGFyZSB0d28gZGlmZmVyZW50IGJlaGF2aW91cmFsIGNoYW5n
ZXMsIHNvIEkgcHJlZmVyIHRvIGtlZXAgdGhlbQ0KPiBzZXBhcmF0ZSBhbmQgd2l0aCBkZWRpY2F0
ZSBjaGFuZ2UgbG9ncy4NCj4gDQoNCk9LIGZpbmUgd2l0aCBtZSB0aGVuLA0KUmV2aWV3ZWQtYnk6
IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

