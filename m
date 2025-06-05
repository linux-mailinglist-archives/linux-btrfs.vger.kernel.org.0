Return-Path: <linux-btrfs+bounces-14475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87683ACEA31
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 08:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3313B3ABC5F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C61F1531;
	Thu,  5 Jun 2025 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oqOC6oEw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="krpwWtuV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D98462
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749105157; cv=fail; b=nl3iCLiWBAz6J99nh4x2Em0JxrGqiD1tqra6J0bvnWyXS0pBa2Pe+Tb2j2ILLRjzyFSg6RRwB90i6C5m0eKJHbl4P5ofzypxSrmwM4RbHpIdqhfUbbbqD+p7wLcYI5p3e9fbXE0ViZv+szbw0CZ7PcU1Lp365hCl06gFdzajmqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749105157; c=relaxed/simple;
	bh=5/Zh+1HSfGE2B+BsAkiFPXR40UycMF4vaG4Zo2mfYIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E9rNeLP4L+E0LPa4CGP1K8y8VlgO0aCYo72c7+sSwcuVpa+dAUygN1kjdFAU2wOv5r+S28YB7pEFfJDZsJ039jN2U2PmAsrhEhw5A/UHrXZSTGL4WJlv3XF3laSdYRixNQD6LhF6WesOURG1NBB5gwbnSau/Pkh3256QBeyzWec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oqOC6oEw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=krpwWtuV; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749105156; x=1780641156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5/Zh+1HSfGE2B+BsAkiFPXR40UycMF4vaG4Zo2mfYIo=;
  b=oqOC6oEw1wIwSw0tZZUB7ozy2DEHnqVbqe5YI9dmkxqfFTrsLi2sTuNd
   2w2JSxKWc22IeJ+ATTyaYTXDM7zI7CRvSuwxa4E6U8Gj0hnqrCOqdAUX3
   lp2LnEqbEoEiqReVBTkxI+NnigEmGZFb7bjOUjIOjyUxqqJ5IPf3qUjYI
   FHflcsRLHbz5QwuxLphWC7d/uaUkN2LVgv7ddi2ttqEt5lNwXEJYFj1Pc
   kGgkX7cAMZn5iomee7EcmINEtTofN+dP32Yr0bQaUnoaZjkNRenfeqDbq
   HUX6pihKYVsNu4lCkdoG2lFuo8+I068v/uAqKF7AUcZI8XFNUYcdEM1SO
   Q==;
X-CSE-ConnectionGUID: f4WRnr49TtySUTO4m66W6Q==
X-CSE-MsgGUID: 79jYt2MbSWaNDTX0bMJQQQ==
X-IronPort-AV: E=Sophos;i="6.16,211,1744041600"; 
   d="scan'208";a="86050529"
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.52])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2025 14:32:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4E0hH2gJ3iNJ+VBqJPlAyDk9ObwaA2j2z9uw+IAf0QBo5pSoOMqVc2778kRC/1UXPZthS1NQ5GTlCLTD4T0/H9xA8w43XJ3b3D4W74bD/rD46uHULn1SC4VsKKVfioNH3YKBP8ULe9x0v1FmG1lSGbzzZnl2F6QVVq0WzheMdcLVDaZwdh7cw7DQidqiKnutpYvRRTWDU0AXvn+4oCZ3cgjUZzYXulzbWkvHIXmSbxWsWdoXcGrmPyAr9v26Kwhwu7rsaWB6t6hmswN67d9Ui+ZlRWQ4I1dZRWeJctMYHYEHKXX+iADyFDnt4JPvK2fhi+45B8/bX0Cv0iBtPpBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/Zh+1HSfGE2B+BsAkiFPXR40UycMF4vaG4Zo2mfYIo=;
 b=Owb+6v7Wpka8pqcxzYEoODx6R7c+mLcIz42Hj02ydMOYUNW2Qv/fMzBqwq8RjzL3NZJLBVlownau1RZyUJHmDBKvdI78diUhDeuFyleWWk0kpwrr19igvfNPXGj9qfrIc9mxqOFPtLrUjv/3Galf76qV7VF6OFHRG/rEJ6Rhx5oneOvxcBrfq/4SLW6mKgIZSlw2cw8R9WOKiL9krnunrDFyL3A17HaeHok+ANJdQ7nlYIo6gvzgKa9VaT3e7J5EtEdLvLJDRhio96rysfljmTXEhEc1YGBkuXVUckxs48+JDpH2QFyVkn/WgVJU98/iA8EyJzBWkoqSiA2L6xlHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/Zh+1HSfGE2B+BsAkiFPXR40UycMF4vaG4Zo2mfYIo=;
 b=krpwWtuVnL+mmwADviOdwgHz1Mip/NRYaQidIVTxa3pbZcVly0RMoNzddKOs7MyRkQG0RqBfPA00CU/iA9tIOZSDoI8vC76u/tK5qr+g0fWUHIl4BNwFydALnwr5Lpk9n2x+PImmT/B8ZdWoFtWYZ/npRfYyZqs9r2fyxGhyZD4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6798.namprd04.prod.outlook.com (2603:10b6:208:1ee::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 06:32:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 06:32:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH v5] btrfs: zoned: reserve data_reloc block group on mount
Thread-Topic: [PATCH v5] btrfs: zoned: reserve data_reloc block group on mount
Thread-Index: AQHb1S0zCRfcWx7AwkOrn6QaCzA2U7PzLdKAgADvCYA=
Date: Thu, 5 Jun 2025 06:32:27 +0000
Message-ID: <d2f5db9e-f9c0-4e2c-a45c-3dbf52e65010@wdc.com>
References: <20250604084630.346863-1-jth@kernel.org>
 <CAL3q7H5eBQijxZXt8NN8xX=g114ZOv++-CLO5XkrbVOqzB0Y2g@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5eBQijxZXt8NN8xX=g114ZOv++-CLO5XkrbVOqzB0Y2g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6798:EE_
x-ms-office365-filtering-correlation-id: a31bf999-e7b3-4cec-8547-08dda3fabd7f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SE8zOWd5emFPczBXTUZ6bUpUc0t4a3BvNnJBWDdkK1F3ekNYVFN4YXpNY3lT?=
 =?utf-8?B?TVR4ano1ZGhEdS95SGpVaXdaaUErL1dLbVJSeHd1bXRpc1hubkNDYXE3R2dh?=
 =?utf-8?B?NmRramFmbFB3a096OU0reVkvc0V4STRlRnpocFBTS0RXcTRLME9VMHV2T3I1?=
 =?utf-8?B?SzQzWFZhNFVIOVBzWGhRc0lxVkNkbzJ6eTdQbUl2M2tGS0hpU2M2ZzRtT2Rp?=
 =?utf-8?B?SUlXdC8xWHB5QWt5Sy9mQVdVTmM5cXozZ1pVYyt5RnFyQ3BrYmdwNG9peTgx?=
 =?utf-8?B?cHBSLzh5N3BZb1E5UUpNRGh5QWhSR1grRld5V2ljN1FDaTBkQWJWMnJuYTZ1?=
 =?utf-8?B?QWloblFFTmo0RHN0SDhJZUFSN01nZUhvK3pZSGJabTZ5YVN3eStiRDVKaCtN?=
 =?utf-8?B?UWtUZFB3bkdHcjRZRW5Xc2c0K010dC8zaG9PTDVXcll5cHByUWZQd1dlUisr?=
 =?utf-8?B?UTVYQmlFM2oyanpielZmNW1tdXY5TG4xUzdZK01jM2xENTJhcENyZUdOZ1lO?=
 =?utf-8?B?RWpKM0ptclVnSVFvY3hQVEExMm4vcWd1RHVYK2lKU3ZjRkllNDlaMitRYW1L?=
 =?utf-8?B?c0JUK2EyeTNNVDF5eGVlWHhlUi8wL0w1cnFRZ2ZIMHlMa1p5ZEF6aDRRV3p4?=
 =?utf-8?B?NVlaVGpOUlNOczFzNDB2Zmx1a05BWk0waHVTdjZVVmM2eFN3QkIyS29QQi9I?=
 =?utf-8?B?eEtZTDFtK3ZkTHI0L050dlZnUWQ1QmlYNFB0VHhMb0ZlcWhmWG84aDYrbWNz?=
 =?utf-8?B?dzFBWTlCL0R0R0JEWlpqN3JYUEhoMU4xZnRLNUo1NklPVjNic0puc1NKc0h4?=
 =?utf-8?B?YjZkN0xLR2dNS0E1amMxK00rZEdJOEZvMXI0dkRRckpRUnN0NHRVVER5R3da?=
 =?utf-8?B?Sms1cWp6ZUlDL3IyTTZVSUFJQ1BVbWltWlF2T1VzVEwzRk9HVVRpRVJMMGJz?=
 =?utf-8?B?dVN2NXVBcEVlZWZibVJGTGUzd0t3MkxubC8vZUpSY01IRXR5SlIwSWp3dFZF?=
 =?utf-8?B?Y0JVVlJaNzhKVys4WWUxN3pRelJuQ0s2QlZ4cjFvTWdnM0ZZazB3cnFZVFg0?=
 =?utf-8?B?eTVqN2xSQTEvdEorVENMUTR3WVJVUWs1K3FVSGpJRFM4dmsxVzJzVG9WeXha?=
 =?utf-8?B?cFlFTGE2THdSdVFuRGhOMnBOQVVmOElmUEtOdXJGOHBxMjlWS2kyZWhCWUwz?=
 =?utf-8?B?eUlnMEEweS9vNGwwak95RzM1bVBuTlJWQTBpZVE1NjhFb1BFaVJKZWJxOUR3?=
 =?utf-8?B?UGRkakZDcEovWDlmNFdJeE9yMEJ3WjR4VmcrWHJ6NlpiQWRDS2luSnNPaERY?=
 =?utf-8?B?bHhoOUV6dS9EeXhFM2Z4K25ZSWtwN1U3T0tjVmRNSEYzdmd5bUdXK2xKZm5y?=
 =?utf-8?B?d0NFanFGZkFVU0FnUHBVQW5OUmNWUHBLeUozOFUyMXZJUGdyb1YrSUdnaTBB?=
 =?utf-8?B?ZzhGQldlMWM5TUZwUDZWRXJ3dHppcGczZEVwNXFWNEQxTGVYU3dOYzErVkVF?=
 =?utf-8?B?NXgzM1Znd3NHaDdOUkh1NmF3Y3RNeHFQYzNxbXVQRURnOCtQeVU5OTFMSHZH?=
 =?utf-8?B?aEFRVklYNVpQK1NMMmlYUEdhZ3J2dmRScXN1YTk3emJIeTdnVUVHWXY1NmtV?=
 =?utf-8?B?ZmRuOWJGSnpxZVBFY2oyUEJCaXpvM1hOVkhjYXBXMGRCRkNyZEl3bmxiSjdw?=
 =?utf-8?B?U0thWkNSMVNsWm1tcktIQzg5Y2ovY1dudCtiTkdMbk1nL0RidnZpdXFVdTVq?=
 =?utf-8?B?ck1ySXZOQ28wN0RIa3poUXV1a0s3VVVKZ1hJaVRQNGxmY0JwaWFQL3I0NHIw?=
 =?utf-8?B?QXpmaGp2NE8wVjVmdXhHT0ZpU1RSNjROQXVZMDlOT0RjcVRmOWxoblU4ZU5r?=
 =?utf-8?B?R09GN2Z1aEpxeHdjWEVhSGNVZzhTZ3htSkEwYW03NHFjc2hWZnB1UkhidEx4?=
 =?utf-8?B?RzZTQmV0cGtKNWR1TzlaTUVnaGpmMFJ1c1V3L0RrckV4THlxeUc4Q2RDQTUr?=
 =?utf-8?Q?uvyECbO802NZkumYQlP9u97yBq3ndE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDZUQTZuOGtvK2w3RVZFOWZUc0k5ejNQS3I4RnU3U2p2K2J0OGFLb2lneUNq?=
 =?utf-8?B?TDdnL0doTHVpamMwWnFacEswU3YzcVhQRFlQZDFDVUJ6OVFNakJQT2RTRks1?=
 =?utf-8?B?RWhhaC9qVmgzZWtTQWhpTy9wcUhUZ1Z4a0w5OEFKVTlpTnhCZlVIVkdhb0Z4?=
 =?utf-8?B?bFA2OXJJaTNRdlN3THNyUHExNlBIVkh6YzlsY2ZvNzAxaXV0RVV3MmhBVDJo?=
 =?utf-8?B?YU9vMWVxcU5SMVNOaW9xUEIzZmVUalZVUjUzTXVmTHk1am0wUEVqaVNxdWdT?=
 =?utf-8?B?R3BYR0pwYTBpVUlJSUJRakRQN0RidFl1NHhFRHpDcnZPSnY5QU5rcnJjdE0v?=
 =?utf-8?B?KzN0MVRtZHlHV200bG1WNCtMZEtnVHh1NWdZWlFlc3NPekNXc3JnRm40Q29R?=
 =?utf-8?B?WXEzdWp4QjlQRlZUd3FrNCtSSGxhYng4NGhTSzY0OC9BNExlRzVGajVUai9N?=
 =?utf-8?B?K0dmMmdVNngyWkV4UUVTc2toK0RIcDREUFVka0FaVHhWemFMN0dJTVI0djBR?=
 =?utf-8?B?NmlBeXA0cEZISkNyVy9LM01MTW5mSURZMnl6Snk4aW8xRGpUVGdGa3JSeWFL?=
 =?utf-8?B?U0NkQ2dqMmowTzh1K1pkRmxvQTJMMUNkbHpoSUhIbFpKeTJsTTk5SlJOYlhj?=
 =?utf-8?B?bWJZbTBmeDRCRThuREYrZHZ1WWMxQXQ2aGlUM3NjR3NxNUJPUW1Ua2c5ZTMy?=
 =?utf-8?B?Ui9LSzZWdDR5M3lMRjlldDhzbHFUSGgwQXk2Nmh6UmJUOGxnZS9nNXFINmcz?=
 =?utf-8?B?RXlXQlRGS0phb2xxbko2NGJ5bmswWG4xbXpuUTR5d1pTUkovUDNrUFQvQ3ZM?=
 =?utf-8?B?OUFSZ0xTQmw5RmcxSU1SWGVrSXI4ZkVwdXBpcmo0U0JBRHk1VUpWcDRwa2l4?=
 =?utf-8?B?dTQvSEUzN1NFM2IwNzdYaXErNEl5dlZSU0JwTkU5TUtlOVQycjNNM3FLbkNM?=
 =?utf-8?B?V0FLUDVNRzdra0piVHE2NjRtREZvcXNJdnlLSGVvLzN0OEFzZ2tKTmFNRjRC?=
 =?utf-8?B?QW1BcHo0NUlqZmwwVXhQdzdzZVhSSmk4UktpTTRRRGxiZXJNcWVQWnl1czRn?=
 =?utf-8?B?NnlGVGFFMVhCSDlwZjJ1aGFFTC9BdG9zN0tYY09CVy9UY1plYy9SdDdSV2VJ?=
 =?utf-8?B?OU5hYVVZbGwrKzZscVZCcGR2VXF6NzhUdDQ3ZWpnRUhIaFBWTTVnSjVpbGRn?=
 =?utf-8?B?czJIVXZ3K3Y5RXg5TXU3WlhVTDVneXg5c2hoNGF1WGNXZzVRK3lkMmx5Zk5W?=
 =?utf-8?B?WTM4MkNNNEY0WHZ4YkJUK2NFWWNNdU5LQ1ZHUU1ZS24vM0crRVV3RDdSWFl5?=
 =?utf-8?B?U0NJc1djdnNOTnlNcUw4Z3p4K1hiSkpMc3FFZXpmay9EalpHZkgwN3hvSDhw?=
 =?utf-8?B?MklSVGZLVWIwNDFXZmgxL1htYTJ2M1pyVEFqVE5hZUdDOHBPd0dubFFBTnVC?=
 =?utf-8?B?eFR4dnk5a0JoL3I2YXVRK2lrNGFCV2NXT2VXbEZQaVlaQm4vM2crcmdjT1Jh?=
 =?utf-8?B?WDc3ZU5nd0tzdmV6azVnTFRKQzJEQ05ucmI0RnpubTVUMVE0RVNuME1NYWxP?=
 =?utf-8?B?UHpwWHVkNUdZaWR1MHZTallTUFNtcEZxWDlkS3RWeVJoUUNrZkNPTVZkUWlq?=
 =?utf-8?B?ODVuN1c2cjVOZ21zZ3c1L2gyTE55V3I2SytpVzlnSFJra3VUTGxFTmpDbjRt?=
 =?utf-8?B?QkRuQUVjRUFodThKaEVmVVF0WkhwT2psM2djdmpzMEJHTUdoempWaTE3V00r?=
 =?utf-8?B?b0JYY3V2NENTelN2YjhLNFI4YTNFMlJna3dzL1RqdkZ3MHV3NTREejVMWFJB?=
 =?utf-8?B?bEV0RWw1R2lNUnpQMituNkh5OHg0N0hndEtXVUZ4OG4yclBRVVpJWGRham9w?=
 =?utf-8?B?TDVpa3c3ZGZPRmluMXZ1OHBscllZM0VTT2xZQmVNVzVmdlp3cEs0UE93QjFm?=
 =?utf-8?B?aU12MDNrODJIS3ZrOXpMc1kvcVd4TUZ3aTl2MEw1MG83aUppNDlBdm9rQjFS?=
 =?utf-8?B?NFJIZmp4REdYV3crUmRIeUtPVzFkY1RlWVFRc2JxczJjRTJMSVcwVnZpcjQ3?=
 =?utf-8?B?WDNjbm9GcUNlZ2hkZk83MDBERjBHUVNYUjRSeUVkK1hBM1VkcUFmK294SVNx?=
 =?utf-8?B?cExxVUYxeW5DTTgzbnI3YlQrWmNoTnMwUGRwU214WklDS216Q21KQWp4ZWt1?=
 =?utf-8?B?NTdpaEpuUk9IR3NZT253aWxuK2xBOURkeXRWZEQ3bG9FcUtCQ3JwOFcxWTB0?=
 =?utf-8?B?ODNRSnYwT1pVa255RkdiY3RKdkdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32B6CBF346E50145BDFDD09353485E54@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HrZi3DIlMa6Y/0HxIHB4/KB9PRPXygGibUJ4uGl9y+jwOxyNzAcwbHbcnEOmUyC2SrshCDMTUwgGGpAGsDXs0tSzdorFyAO4CrKi0mPxlIMuHH6iEX8vFfs5P3zbRm4nm4T5KfSWm8ydSwcv56f5fl0MbN3xvkdLutAJqkfecjciiEdB8d55mH8aHQlReADsGQICbfOiOtca25PqRigfQUHdPBOzTkYyqY2DKA2AEs2rvoMPLUJX3MFqFCiSw3jNHalg5hVa5Cg3HITDNwI1UUrxjXIR19deDui+6FO0jo07PiF6Vf2BboukKewXnNV8dcW4amWUJW3yRwmeZobAmKAQiqcB1saEfYLuGiiDxl9xTT4o9y92L6BpurdvEbaSjEitqL9XlIV7rnUj2Rfnz4vCJNpVejg3xnxl7w+cjcLSSYthUdDvrAbYtF5pBScRlJmvLuszTAF9zvoRdPStZwmPBdxl6V2nxaQF5I0pA3fLtYZ4jEeES/pDhesVrC5UiF7AD5oOxVQwPSyXYviWpfLaRWQicJgZWlAWMnywyxY35qAAmjmHOMC0QMZj5bKY+5htWmZH+Q5GiZmH3yycqVgIvCguGiLhSLzDgmCR65jItyIYwy4NhuC9LFjx+Jqk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31bf999-e7b3-4cec-8547-08dda3fabd7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 06:32:27.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54qeKhe+fEA+Y25592Ud95/Y1dCnCDG4zH3VgyuDEgDLkcGgT51UFFg4JsTswOrB0KxflJlPMtZJ3i6KZlwHV4/U41ViwFgpvVyvOXJ9CoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6798

T24gMDQuMDYuMjUgMTg6MTcsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+PiArICAgICAgIHJldCA9
IGJ0cmZzX2NodW5rX2FsbG9jKHRyYW5zLCBzcGFjZV9pbmZvLCBhbGxvY19mbGFncywgQ0hVTktf
QUxMT0NfRk9SQ0UpOw0KPj4gKyAgICAgICBidHJmc19jb21taXRfdHJhbnNhY3Rpb24odHJhbnMp
Ow0KPiANCj4gT2sgc28gdGhlIGNvbW1pdCBtYWtlcyBhIGRpZmZlcmVuY2UgYW5kIEkgc3VwcG9z
ZSBpdCBmaXhlcyB0aGUgem9uZWQNCj4gc3BlY2lmaWMgY29ycnVwdGlvbiB5b3UgbWVudGlvbmVk
IGJlZm9yZS4NCj4gDQo+IENhbiB3ZSBwbGVhc2UgZ2V0IGEgY29tbWVudCBoZXJlIHRoYXQgZXhw
bGFpbnMgd2h5IGl0J3MgbmVlZGVkPw0KPiBCZWNhdXNlIG5vcm1hbGx5IHdlIGRvbid0IG5lZWQg
dG8gZG8gaXQsIGl0J3MgZW5vdWdoIHRvIGNhbGwNCj4gYnRyZnNfZW5kX3RyYW5zYWN0aW9uKCkg
YW5kIGFueW9uZSBpcyBhYmxlIHRvIHVzZSB0aGUgbmV3IGJsb2NrIGdyb3VwLg0KDQpXaXRoIHBh
dGNoDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzIwMjUwNjA0MTAzNzMw
LjM1ODkwNy0xLWp0aEBrZXJuZWwub3JnLw0KDQphcHBsaWVkIGV2ZW4gdjQgd29ya3MgKHdpdGgg
YSBjbGVhbiB0ZXN0IGVudmlyb25tZW50KS4gU28gSSB0aGluayBJIGNhbg0KZ28gYmFjayB0byB2
NCBidXQgbmVlZCB0byBoYXZlIHRoZSBhYm92ZSBhcHBsaWVkIGZpcnN0IChhZnRlciBJJ3ZlIGZp
eGVkDQp0aGUga2J1aWxkIGVycm9yKS4NCg==

