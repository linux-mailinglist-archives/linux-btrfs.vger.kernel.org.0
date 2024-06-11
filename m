Return-Path: <linux-btrfs+bounces-5657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734C904167
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 18:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F6B2826D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530043AC5;
	Tue, 11 Jun 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hNZCzhn6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n4WrfgRa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995542067;
	Tue, 11 Jun 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123667; cv=fail; b=VC6nzv2Xy4motCNOizRJyWok2WMSbed5i9mqc1sQm9EYXJmXV+6gOq3lVvihQR5vwMeF6X9rQeOsk5y7xQ0CFivslBFHp3IVZ+tCjZSjw4+M0yT/jMklztoSaNJbWEvw5ac1BSuwr8Pzyj48w+2t7Qs3wnTYU2jq7Z/7+Q36uJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123667; c=relaxed/simple;
	bh=0G3hQgadODL1U6MrKeTUjZWg0eDvOUo2FTczh3XWRyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqmS9/U5T+ehrrtGIctEZkJTKul/79yV4W7y6HhNNgLQkkewDwgLDfPwANSdfBZLD0CLGSe7EQXwztzqoEuq1skgd+RqppoeN6defGTwuzDjMRmdiai7mFl0CAslFlZjMbTbZHyNAJ6yFAtLB2g5gPJb2CLmdRyHXjyfn8TBu3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hNZCzhn6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=n4WrfgRa; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718123665; x=1749659665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0G3hQgadODL1U6MrKeTUjZWg0eDvOUo2FTczh3XWRyE=;
  b=hNZCzhn6sghtAvg8M0IfbpiAFUAiPDHLyEZav0FC3Tl3r9zKfw5StlgV
   57mJM48Z3x6iHJduV8iohAydrLy6OFAsJ5sSQHAX+EaCY7XaC2gV+ayf7
   5cjWbuzlaNDzz3AvfnDjigo4EcjxU3I2omlpDd2CQfXAaj+CyxcNrb83v
   +BoCeL9Y7C4gukB2fAXcmmrIwQjvs+8vKZvsa+5ZwZRG5xIYnfw04qlJj
   mJJTXb1gqfBjZCcP+5VZZKsILU1sFAnAW60XUo/Wvn0O603y+Qbg2VBwn
   0k8O6cfuBeeDYV0AKstc20X1w/qi669cVmjlM/BTFa219AM4XywVsvNFw
   w==;
X-CSE-ConnectionGUID: rhWXpy4NQQGUAydh6d+uRA==
X-CSE-MsgGUID: GEkHAABrQWOfVTSogwTEAg==
X-IronPort-AV: E=Sophos;i="6.08,230,1712592000"; 
   d="scan'208";a="19639449"
Received: from mail-bn7nam10lp2042.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.42])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2024 00:33:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjcP5MTA2eFQfgSPpNuDlwQJ06Bv1v2hXlviCGGzXl5aGhdLKtaMb3Ze7EsD/WUqy/lAffWaiaszVZ9Jq7oR67oSZJhCpLcvR1Jvsm10oL/ljEwLX36sclm1Gwg7G3Tw8mPJkGsMuSIi8UslRWgAUE0b2mktxmIHTxZJfDTdXArzQNPfQNHkH8e28cyORiRhHvAHEEhnFkBsAJO11kIy6ZzvF+V7gNvqDfsP342VLBBoKbqhAMDSENoHG6mBvLeBh9jppczInvfzStJKodXnfYA2g/v+o4It6Z7BAyYZjGeKSUx19YiywdLeAv4/vALKH6jFvTW8su5sryii9Zk9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G3hQgadODL1U6MrKeTUjZWg0eDvOUo2FTczh3XWRyE=;
 b=j7yCHeSUpkjXPgcc1+ltJriHt70QPHBSSE366fg0v4czknn5PJO3vt/tg3AI7VmB3pkorhktNSU//xRgM5Rn6fXWE48HFIlvPxsCZvIxaj4/D6EQW5iw7wrfW5pDZrWRkgZost93GGtr09YT9ThT5GUJl9mAN7hozbz3ypHh86y8xSa4Z3eH1Vr1jWqXRtSRnp3u7Be1Q3jWGenCg41pTZoXpgsYp5Uj9XVHeMEw2Ul9j8DaOMYBiJmbTuzaMbNergzDB7f1yPEY8Av/3DSUgNhDjZACz5moFuNJBjikVKkXL3ftgtU1s+kvjCSsvOChpjFiV9mcsKX9mzJ0k5Oseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G3hQgadODL1U6MrKeTUjZWg0eDvOUo2FTczh3XWRyE=;
 b=n4WrfgRab7KdnCgzFQO5olrM8JQbjtIsYb9g3QhmCDhipJuWV+mytsUJeXtxO+/mNDBJVA3qaihVb9TbmHYrz0BY+0XTFMhO8kEQayTv7VpRdeRAl+ptXPFwOEiXJ+MO5oM+zhkZjcO9y/s8WQaUKEnCiT58FNUgfbflnpXWcVU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7893.namprd04.prod.outlook.com (2603:10b6:8:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:33:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 16:33:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
Thread-Topic: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
Thread-Index: AQHauxHeASfDcWxbXUu31/wvl5H+ObHCo3SAgAAgioA=
Date: Tue, 11 Jun 2024 16:33:19 +0000
Message-ID: <c7246728-aadb-4699-8fdf-060502c1092a@wdc.com>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
 <20240611143651.GH18508@suse.cz>
In-Reply-To: <20240611143651.GH18508@suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7893:EE_
x-ms-office365-filtering-correlation-id: f964bffe-882a-4ba4-bee6-08dc8a3433ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzVlbGRmN1NMSFNWbndkNTg5OVFrL0pmdUk1L21RK2VrZFB3RXRhWGlUMDUw?=
 =?utf-8?B?QVR4bjI4QVZqOXIvY1hzeDFSUjlGR0lZMkV6NUE1RE5NS29RdWlIejgvVGI0?=
 =?utf-8?B?YmxxaGVZa25jTy9aTUlDek11TmRGbHJmUXZ0RlhJeFRXMmdRMExhdHZPY0sy?=
 =?utf-8?B?amR2bW5JblloSjluTCtlQnBtQ3BjL0R2R0pZd1FFT21tRGY2bER6cGNxNFlQ?=
 =?utf-8?B?Yzk5ZHFBYzJ3TXJUNXMzT242ZmdHRVJtNVBPRzc3aW9mR1JLUFFwN1YvYld5?=
 =?utf-8?B?b3grVWx4SXRsVnVNY3FlWHcrVVVsKzNSaFFqMjAzUWU1cmhPdTRaTkc4VjFm?=
 =?utf-8?B?UkpTUXVsTEF5eHNYNHUxaWJDd3lLUEhXOU1HT3lLVjFuZUlCcUpPMzRxeW4x?=
 =?utf-8?B?MkIxSUZvM3hkcGRVS0xaYTNCR29pbnpUUDM4NzBtTHZSR0xvcmRzODhYQkFN?=
 =?utf-8?B?WEl6RHh3dllvY2duNEZiRGRiUmw3OGp4dlhFcVJHMjlVLzR4V0EzNTRyVTBF?=
 =?utf-8?B?TkZ2ZU80MjFaK1VjUU1xNHJMb1RUSXYxVlo4YVhBam8velZ2SGlISVhtZk9r?=
 =?utf-8?B?eGtzNXVWMzI2TUxscWttQmtFcHhQdDlFa0tRdko0RDRoekVzVlU0T2VrMktt?=
 =?utf-8?B?UjJrdWZLTE9qOUFwVHlHbng4dzVGcWl0WWF4NlJrYkNJS0FIc3V2QnlPSmN2?=
 =?utf-8?B?TDg2T3JNVXVCTENrNlF6cm5ldFJuUWVUUEJ5bThROFN6UDVTZC9hOVhzWCtv?=
 =?utf-8?B?dk9Kc2xwc3FLSzc0RG93VnAwRExoTDJqUDdNem5MekZGb2UvZUg0TXE5YnZ6?=
 =?utf-8?B?SW51TWtPOXpIL3hMUThZdlBYQjVPNlU1MzJoR0ZnS0dKUm1QYytHM1RGY3FB?=
 =?utf-8?B?bkovUFRPK1JWUlR5bHF6ZkVDL2Y1S1dVdFlVUXc4dC9rNmtuVFNCV0dZNXpQ?=
 =?utf-8?B?eGF6NTJudHhaQTBQM0lNSzVrckdtVEFpQUNUU1cySElaWFN0cndmbWZEUjBx?=
 =?utf-8?B?VThxdnQ5Z09GOTdVb0VMTnY2UkwzRVcrUCtudWcrMXZEMlVjRGMyYUVQeFo0?=
 =?utf-8?B?aW8vSmFLOFFHeDZ3VUFqZDNTWTBMRzBuaTlDYXY2K0ZsWTYyZGc0RGw0OVZw?=
 =?utf-8?B?UzNuUXh4TjQ3VjN1ZFpWeDlCVklTRFBsQkZEUjR2T09ZWHVTR2xlUy8xVWdP?=
 =?utf-8?B?bTcwcGxDTzZvc295VXVBYkdkdVpjSm00cEFGSWQzMkh1czVPd0EvQTZQdHZ6?=
 =?utf-8?B?NnNvQVNpc2NYV1M1ZDBSRFViR0NvZ1R6Q3YwOGhNRGdlcXN2cEZEY2RjZjhW?=
 =?utf-8?B?bCs1cm43OFA0bGVGS1lDQUpMSDZnUFltaVFUWENVc3ZtSVltOWtOVkN4cUxD?=
 =?utf-8?B?MWpGNkdVdWZRRHFHamRFSWpocDd4U2lyTXNqZFZjcVZDV2ZNTEZRS0x6b1Ji?=
 =?utf-8?B?YjhTVkxoWmJBNFdjdUpuTSs2OVBKMmJtakROZlRnV1lOMWxhbkRDeExUM1du?=
 =?utf-8?B?T1lsZFB5TXZBMmF1MkpnSitnR3lOcENuUDFORDZ6alJUUHE5NjhjM0VEN3ZR?=
 =?utf-8?B?UWpWcEk3K3ZrZDl0MGxEeXJXbXdZZFNZTmZ2UElrSXdDelRkVXVxYWpIS3l2?=
 =?utf-8?B?SVlJRkw5NnpZQjA4QWVRK0NCL0RCc3NUWGd5S3RjeG4wb1lSUlEzQmM2WGxm?=
 =?utf-8?B?RThDR0JRV3dRaVpkZXNTYTZHZW8zMWNReGdCNEZRam9TQXlMUDQ5cUFWb1Fm?=
 =?utf-8?B?cE1pTEJrQ0lCYld0S2dSU081U2RmMFhJYnZEYWltZHdmT0pyTitEWlZxa01k?=
 =?utf-8?Q?zCxT3gcg9u4x+iRQa88KrLW1ZJBoHQ+VU+SkI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGQxZHBPVmJLSEJ3VUYvV2lYd0xISDlsaFVtbDZtbUdneUUvWVhaTk14eVcy?=
 =?utf-8?B?NkZkQzlCTDUrbXNRdFBxdEJRUWgxQmxlTlprcVN5NWIwR3ZaclYxRThSelNB?=
 =?utf-8?B?c2Jmc1BnZ2R2QzJkL2NQZzVPanpsK251N3R1TUZOM1hxQ3d6NXo0YTlTZS9S?=
 =?utf-8?B?cU9RaDY4TldLdlBERno0RjlrbktLWkNRK201dHJsa2toYWJSRGQzK3RLeGF3?=
 =?utf-8?B?L1dsM2QzNVFlYmRQU3JWaFFJYmFvWnZYeXZZbnAzRnpjcjNhNlJyNU80R29i?=
 =?utf-8?B?d3hiZUkvNDdUQmVJdUNCcUFJZnp2bFRYMVRVcXNZZjlPQXF2Z0JxUTJ0SjVL?=
 =?utf-8?B?TWV5UFhKaWljVmlreVNZK2tGRFRIdTBXOXBPQlVWQzY1Sk4yUHhJcURHZmxC?=
 =?utf-8?B?OWN1MExML1hqazZieFRzZjRYdk0wS1liNkFIN3E3bjlXSkhpc29BSUVlOGd6?=
 =?utf-8?B?ZlNNTDNMalNlWGVpNXBOclA4RXl0RzVpTE9GUkNFa0Z5VndrN1BQcHF6bjZC?=
 =?utf-8?B?OFBIL00xRG1UVjdVbEFzNDlYdkpCNW9tWGovaWtjQmg5OGZEQ1haWmwvY0No?=
 =?utf-8?B?WEtlL2JiMGhoU3RqVlJUT2VRQ21sT2MySGkwUWJpRUs2a2thNkhvLzZxNEsx?=
 =?utf-8?B?eStEc001ZFhWTFFnSGhndWRvQVVYS2llQlhmM0oyaStnSERjbXAvTXg2MVov?=
 =?utf-8?B?TSt5U2ordUNSUmlmRjZRazNDcWRHSXl3ektvTzhBa0p5WWwvS1BGNXhoeTRS?=
 =?utf-8?B?V0tNSkRmbytJTGdtOU80WmlaT3U0VUR5dFh0VE1lZVM2N1BsOWlzeGNjRTc5?=
 =?utf-8?B?UTc5eUI4ODFGYXdYYlluSXoyMDFHb1RFT1JZQXhpOWFNd3U4eVdZbmRzaWU4?=
 =?utf-8?B?OWJkaFpyZVVtVVdDaHdVRmo0cHZhRzQ1aXYvbUVnN2FBdjZ5NnMzTUxoNjBw?=
 =?utf-8?B?R285RkYyaVk4ZGdiVUdSNUYrZFptTzNKQnE5YW1BOVhQZkVpeEpYZndQUjZ1?=
 =?utf-8?B?ZGRHaDRHMUdzVUd0c2V3cmZPamQ3N1RqQzVBTjRsd0F6WjJyU3FOMGpMT1hR?=
 =?utf-8?B?WFVlZE9HVmpyY2VCN3ZJS2RVVDR0aGQ3SDZYaHF2Nng1dUsvNm1QVlArWGc3?=
 =?utf-8?B?QUM4VTRjd0ZQeHBQdVovRlZERjMwNE4zTzRkYVN3V0ZqemRTK3VQblV3aHpu?=
 =?utf-8?B?Q0wzRUo2SXZwUzFlTTI3cnROelRnWEpMbjZhTlhobUk5Vk01L1R2U2JTbGJB?=
 =?utf-8?B?SlJDcWlvdnBPTEJWaWlRYWZYdkVGd3VHRWpHVFBTM0pEWkRWWFVLQ2tuMnNY?=
 =?utf-8?B?eWw2d2hSY2x2Smt6aHp0YlN3dllndTlycm9KYlNPclFMdUUrQS9XWUFUa0JF?=
 =?utf-8?B?alJoc0VDL0tIenhTVS9sd1BSc1pDK1JwUEpENkIzMmw4UGF4ekRyejBlTG9N?=
 =?utf-8?B?WVFIQy9odUJkT0ZDMnlRTmp3YU1IQ0hvakZzRUpRcTNVa2pkYlJYS2p4OHNV?=
 =?utf-8?B?alhWTmZ1WmNtS1pQVWpwbUNxbUsrNnI0a2JuOHlmTC9TWVRVM1dIT3AvNXBk?=
 =?utf-8?B?WW9BaEZZemZXT0FDMHhYQVNTb3VUUTUwdGo2bXYwY0dkY2Nwb25BbE1UbU5m?=
 =?utf-8?B?Q21RWDJvZHk4LzJqTVQ1Q1dkVUNHZ3AxZkJEcTRkNG9zQWJhZG03Q3lVMTla?=
 =?utf-8?B?RzlGd3k0eHc4aDBtOGdDRmF4UFRhd1VEbUpXRzhVbWdxQ0UvMnpDTzIyVERu?=
 =?utf-8?B?QlJwcWxxUzFySmRKTGJPOElCRkUrT0paNHhvTSt3L25oM1NLZTZMcDBYVnMz?=
 =?utf-8?B?TFNnZnVqSHJOVzV1aTRWWlVPZnFidmlieHFkbkVkeFluc2piOG1xMVJheWFR?=
 =?utf-8?B?T0lPNUZFME5jU1gzMTlyMGl5S2o0RjhySHdoRWhreVRvdVRyUEpycjZWS1N0?=
 =?utf-8?B?cjBQZXcwbllYTmE4YzE5enJsc042WDFYeDMxSTZhOG9MVU5mTWtDU3o4N1Fl?=
 =?utf-8?B?YkFkNURuQzhaL2hZVVUyNEx6aTJnQ3dXQVo5Zy9xRWZOZU9QbllhdkNoRDZv?=
 =?utf-8?B?bHV6SVRqWGdRZE4zSXVwNXZxYzhLSFpZZHlzU09KUkpTRDB5MDA1VzI5TlB4?=
 =?utf-8?B?Z0w1TDd0cHhTMlZnbnQ4bmRReDk5RWF1SUI1cVJvM0ZLYXpKbmxHc2JySS9t?=
 =?utf-8?Q?lVxrsjJvM3V7gcR5ZEIgUp0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5CC4A1C3397CB449A1AD63394BC6A18@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jHNoVqybjXKAzYjxdUmcVh3Wt81cZ3MoeKvTLe+HlQ/+u9lYkbpzTqIboKB43AnjE955RRn0cf0c/woMCwbMF9gzYM8cJY1GUcLF6m7nO330KrnWm7OiFAZAc10O4BPK4UGd/vemKZB/sd7gq18LQP+8V6Z2FCcD/tsFkD8pc4lzGN8kG1cifqPxGW2EOelUSre1caKwSAdPxyOsJRn1twYtc+s6gYJkDqbDLP2itHnb3kO4I665V7kAvsQCecPAf2ysNNZOY75LHIY7fsa3q7dwTgIHBT4OK2Lngbvu8mx6To2zyrngWxFGW51h7BSSaDr8HInSlsC96JOUIHc7Hz0cES6DeKqi1XGGAyGizTW9gtUw7YGU2V88A4+tt/tmibl+1bV7sV28/djBTk3fmoKCctnliN1ue1gr9DdiPyGGETkh3zX1VGV5cX1VpoPs4ThXLxBENx6xQKY/Usrl1W5VigYhvnwhDDNFhZB+NJMGM/1WjJJO3kABvga8hfbmmUM5oxERtbGy3BmE0YQysY9QvkruO6wL0YSXLA28emDa8P5UMwJEIZGarVzBB7P1u9R0paAhBDfsr8WGSfl+CeOxK1jx58wW0Y5I3SjU3lzCnYCfCaw7msVOr8hAf866
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f964bffe-882a-4ba4-bee6-08dc8a3433ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 16:33:19.3684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zD27Z0DpBvnVgb8nDeMHL4z+n7OaS4hEDyG3FDU/9GG9e8LbVBR6ZtsRQ1NjMCJytcqIlCL1ZUoxtJkfpKDGB49kucLW0PiUSiaVtLqL1jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7893

T24gMTEuMDYuMjQgMTY6MzcsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gTW9uLCBKdW4gMTAs
IDIwMjQgYXQgMTA6NDA6MjVBTSArMDIwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
LSNkZWZpbmUgQlRSRlNfU1RSSVBFX1JBSUQ1CTUNCj4+IC0jZGVmaW5lIEJUUkZTX1NUUklQRV9S
QUlENgk2DQo+PiAtI2RlZmluZSBCVFJGU19TVFJJUEVfUkFJRDFDMwk3DQo+PiAtI2RlZmluZSBC
VFJGU19TVFJJUEVfUkFJRDFDNAk4DQo+PiAtDQo+PiAgIHN0cnVjdCBidHJmc19zdHJpcGVfZXh0
ZW50IHsNCj4+IC0JX191OCBlbmNvZGluZzsNCj4+IC0JX191OCByZXNlcnZlZFs3XTsNCj4+ICAg
CS8qIEFuIGFycmF5IG9mIHJhaWQgc3RyaWRlcyB0aGlzIHN0cmlwZSBpcyBjb21wb3NlZCBvZi4g
Ki8NCj4+IC0Jc3RydWN0IGJ0cmZzX3JhaWRfc3RyaWRlIHN0cmlkZXNbXTsNCj4+ICsJX19ERUNM
QVJFX0ZMRVhfQVJSQVkoc3RydWN0IGJ0cmZzX3JhaWRfc3RyaWRlLCBzdHJpZGVzKTsNCj4gDQo+
IElzIHRoZXJlIGEgcmVhc29uIHRvIHVzZSB0aGUgX18gdW5kZXJzY29yZSBtYWNybz8gSSBzZWUg
bm8gZGlmZmVyZW5jZQ0KPiBiZXR3ZWVuIHRoYXQgYW5kIERFQ0xBUkVfRkxFWF9BUlJBWSBhbmQg
dW5kZXJzY29yZSB1c3VhbGx5IG1lYW5zIHRoYXQNCj4gaXQncyBzcGVjaWFsIGluIHNvbWUgd2F5
Lg0KPiANCg0KWWVzLCB0aGUgX18gdmVyc2lvbiBpcyBmb3IgVUFQSSwgbGlrZSBfX3U4IG9yIF9f
bGUzMiBhbmQgc28gb24uDQo=

