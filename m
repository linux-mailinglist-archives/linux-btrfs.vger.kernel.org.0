Return-Path: <linux-btrfs+bounces-13485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4237AA0297
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 08:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A3317F9D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 06:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFDC2741CF;
	Tue, 29 Apr 2025 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pbcS1Xd4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wKUOfysN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC12741C6
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907010; cv=fail; b=KR0E/QizH26RwzPejS02GtveySsIcOxvziO9+7pHca4pQNjx5Ir14CIdCqJxt+AijFE5yJczlWCIMCae5yMw/TobhSV+lrNq0LLJ1fK3lziIAEPmGjtjX9zNQJznDu3klt1rAOkXv1Vb5f03UuKlKZwapQOqRtLnf0qorSfnKM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907010; c=relaxed/simple;
	bh=eAGgHFpzmBOY/RcLFjdpxap7ffX5moc3fxaVLXT0T4M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cg1M9spvuksbU0OGyEym0BTvN5KvSsUJnt/qajn20Z8DSul25dnp6PjePU9SneCWUnaC20yNc6335xZ/PFIF9dhR+ZJhFVTOOsiMkl3jXW1MNhlvOSz5g+W/Inq277pc8VE6nGMmrQtURx+Mp1al+T/b0xLXIoXxUKiMhnGk0Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pbcS1Xd4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wKUOfysN; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745907008; x=1777443008;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=eAGgHFpzmBOY/RcLFjdpxap7ffX5moc3fxaVLXT0T4M=;
  b=pbcS1Xd4sr78lD0vuxoIhGqLwq3AA+Sn8f6YBzIVq9wGikYG0SPZyR47
   2Sm3GiayUbieJEOrTntCY88t8wx3oSSgp19KgATcb2leyKt2gyczSiJM9
   zOib9bIaM3+PE649j844XF5BaLerGj3niQ1kCC5+zoB5tV+0yaiTVAOQQ
   LyIw5JJRaprzD4iqz3nT7A/C8dneyshfe4ykqdnzTao96fnCQ7k++MoJ/
   IXJqy8vfjwkhJS8ewLH9Mp8Rb31t52xAhPw9IuiT3mf3lpWuvmSAAMuBU
   RaX2YFSFQz/aig7em1f5bjf+EyJB5txLOn3TDcwDBBQW6JjSp8Rs1TOxY
   Q==;
X-CSE-ConnectionGUID: LR68Q1ofQ6eAcDw8qAsXcg==
X-CSE-MsgGUID: x7yWeO10RyqyfObpSaS3xQ==
X-IronPort-AV: E=Sophos;i="6.15,248,1739808000"; 
   d="scan'208";a="78079783"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 14:10:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bv4ZQ0vXvdB/iYdcFO69VTq4lA7xKUZgNNiJVM6ebebYmlkZ1MSNElgJHoEIEZpWlYH14caxltPQtszowTWCSwOOq6HUOmGMD44cL1aD2xa2kiW8tMIA500Jh9ULfZHi9CVHWd96yFWgcP1f+aqVsIPEwGFuaqFnTTvsQli+yO4aTTdEFSZZi/Wsmt8+EmDYWvWkWYfZXd5t5HSr/YC4rnlJnyiBBf33kJkRfmp+Tt6iQoSKMGDgRWP3YEkjKhCEQt2ovwCShJk/Rzcgt5S/QPGFDAz0D5s63xvQQOq/mNI1Uwerzm6FlI6r7/sufXRMvPYYdWd1oCQvCVpBwdIPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAGgHFpzmBOY/RcLFjdpxap7ffX5moc3fxaVLXT0T4M=;
 b=I4CvtC2S8S4xOkWCIknh3hYFoLYoOR/R/J1yHUUkOjpdlyiiQKHvlrwGQv2Px90DUA2CpfCab4nYnMK3Cn3rV89knWKFndqBmVJCSWsmfRHEMd6irYBzMSf4jDcA0LWMaXqFh4G4kdx3ckNbfw8EvWFOHEAF/YFBl3Pqe/lS3d5a+vtVwXWdto1LbanvcFHCowGLAmqHepzn8w+kT+KJe8kh52ExjREaxXQ6zGy9hDcTBtUgCLXUrKqHZLnmDZZ2e/zPMhuosyOrchkJryFfoUu5BysrOrFGHeT9KZhmrIOTjwrzWiPdpsQ7FSUDqMrjoUJnSDCpZHZ4dj9bSDEt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAGgHFpzmBOY/RcLFjdpxap7ffX5moc3fxaVLXT0T4M=;
 b=wKUOfysNUMHXif0rJBe9csK6aaF0cautg/NAJ0bmo5+nIIab/7ZVXX+oKwsYGEMqGREzCYEZocS13zk+kFgijR9Em8UfQznQL9Iia9e9hAxKLIYcOHosDYF16Fl4bXqFNV+zbIXL/mgDA2BnGadkGR/ag8KGWO9OsaKiM0EKLOA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8434.namprd04.prod.outlook.com (2603:10b6:510:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 06:10:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 06:10:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid NULL pointer dereference if no valid csum
 tree
Thread-Topic: [PATCH] btrfs: avoid NULL pointer dereference if no valid csum
 tree
Thread-Index: AQHbuMtYsE8Fpb/VpESuygLCvkxElLO6KRsA
Date: Tue, 29 Apr 2025 06:10:04 +0000
Message-ID: <f4adad2c-3aca-4122-bd89-c1213387b58e@wdc.com>
References:
 <94df43cea8d2ea0cac8152d0996a64bda30758ae.1745906085.git.wqu@suse.com>
In-Reply-To:
 <94df43cea8d2ea0cac8152d0996a64bda30758ae.1745906085.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8434:EE_
x-ms-office365-filtering-correlation-id: 5edb29cd-9aad-494f-efc0-08dd86e47c24
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YytrSkNuMXZvNkJiVksvaFkxYUpwTmZ5dEplMzJYZW1OWmtCRDVHd1lGL21S?=
 =?utf-8?B?cENMMGhzbDg0dkg3V0psOUhDUU1JbmRmWXYyL1NrZUlublFSMjBGTHFFR3VF?=
 =?utf-8?B?TmhBM3FUVWdNcmlsRVZGODFaTlVveXNwTjJGbXUwNmRqcGhON3I2YzIyRXM5?=
 =?utf-8?B?Mnc4T1VEVjVRVDlKbGN0UDhGZk51cmM0THp0R1ltVTZ4OXJCdk1IeXRSZk9B?=
 =?utf-8?B?bnNnZXFkQmFVeFlWYmhteFpBbGtRWlZsVFQ2Z0ZJSE9Db1JLY3kxQ2ZKeUds?=
 =?utf-8?B?TUgzM1NMaUpGSjcrbGZSTUxiNXZLTUZyREtYT1Q5NUFCL0M3VTZsc1Bzdyth?=
 =?utf-8?B?THJUcDZFTGRLNEQrSDllZm4zSXhtcTVtdlNvQWtETXllZ0lLcnlwdm1rcmQv?=
 =?utf-8?B?VDhhcDlYSTRKYmgzMXN2WTBpK0hmbnFYQlRHb2FVT3g2TnFtajVDMndJWmtu?=
 =?utf-8?B?OE9WaE96UFBhVXhGb1lWQkx1emJ3N3dZL3FaQmN3VnlnSGgrckFuV0NONXhI?=
 =?utf-8?B?dWlTbFlXbm81T0JWVzVFQklDemZ2aWx2cVgrNXg0ZXdIQjdOeTN4RnhmdklV?=
 =?utf-8?B?dkNQMXBRQmNXWVpyM2tRdWI1ZERQYTB0UTNIOWFER3kxSGVGOGxobHJnVEMx?=
 =?utf-8?B?dlZWb3JzWUoxeXJrQnJZKy80Q3lmbHhkZnBqRVd1eWVBbVM5Zk9ON0tVMTJU?=
 =?utf-8?B?SWhOVlQ5K0tTanFjUEgxRm56Y2diUzB1MkwvWno0WUV0WGxWTXZ1M3FuK2lh?=
 =?utf-8?B?ME1aVERBQ3lxOXdYRUV5SkNqVGpIV011bWh0cG5rejBaY3VsTjFwbzJrM1dn?=
 =?utf-8?B?MmRtVmNpVktia3FWSHI3ZXVZTExEUUhKSk1iV2xCcmJsaWdtaVVEZXFsV05k?=
 =?utf-8?B?anJxRjhDL0ZJNXJ4enVOZVB3Y2taTllsSjRjY3NqRDVlSUd5WTNFdGxPRjlk?=
 =?utf-8?B?RW5VaUViM1N0ekprM3FneTJxTFgvd1VOTng5QWxNZjVlQWQxS2s3QmpkN3hv?=
 =?utf-8?B?THk5THRvSWZDV2NlNGVUN0RNT1JTWk9YdyticHd3Mk5pL2QybUlraWJDeFpO?=
 =?utf-8?B?eVF2Q24zRUk4YjJWbGdxY3dGYkdPeTdYNGFUWGh4S0o2TlNZdTU4dkVDYkRV?=
 =?utf-8?B?MEVNQ1JDQVR5azVDYlhkL2Uvc216Wit1bEJodlZaUDlldW11Q1JnV2twdUk3?=
 =?utf-8?B?enFqN1hwckcrcDIvbVJXMjJRbG0zbDVMdjNlR3lsQTNlU1N0eHZsMnY0QUxJ?=
 =?utf-8?B?VU5OSXQwdnNDemlMamRRSFQ3R1V1OG1uUFUyRjArV2cvLzhKWTBZL0hGNzEv?=
 =?utf-8?B?UHkydm1vUk5KUituMDU5VzMvRUlwSE45aDd0REI1cTlNcDFORElOZ2xYYjF6?=
 =?utf-8?B?NnVsZmhINEpWUnMxYkN0UVJXTzJEZVhVaWZyL3h2Z0tQbGlwdTZMazMvc1Jp?=
 =?utf-8?B?Q3NteHp1STFuaXVnY2lNUHQrcnM0dU55U1ozTGFPek9jaDUxMWtxVldkU2Zl?=
 =?utf-8?B?K1dLT3AvS0V6ektXMFVjNlFFUDBUVjBlVW5IWjZuNExSaW1EU2ozMGt5VzRs?=
 =?utf-8?B?bTNKWjNiU1FWQWlHTzROOWcrNXd4cWc0cnlkbXRGMDBqSmc0bTloZVJrdVNZ?=
 =?utf-8?B?ak84QkNtZTVvYW1hS1o4SW1TbVRVSFh2RFBLTG9NTkcxT2ZzalFNcVZBL2ZG?=
 =?utf-8?B?UFlLMVJ5ZHdXNXZJaTliS29FZXJ5MVhocTZyenZLRkF3aVBYU25PekZtUU92?=
 =?utf-8?B?OEZ5cGdqNEVJeVVESHUvTXZrNFFFMkRuUEVjMWZPWTdCSHRVS2ZyelJjTHox?=
 =?utf-8?B?OGlSbjhMOURyMlJyc2pIQUJuOGlkamNSUWl6KzlWUHRsOGhoQWx1YjZNN0hm?=
 =?utf-8?B?NDdYY0F4NnN3MVU3QUZBVW55THc5by95Z1Y3UHJ2bm1BZUdTVzQzT3JLc0k1?=
 =?utf-8?B?RktvbytibjkxUGwyRmpMZXRoNTFYUDkwVklSd2NVckdPS0ROR0ZnYmdaZW9U?=
 =?utf-8?B?WDBSQlFkUHpRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFBDMWowd1A4eTdkaGFNQm0wTkVyU3ZMcmhXbTVRaGR3TUZucWJUYmdNR3dk?=
 =?utf-8?B?WUxpY21ja3FQSDFmSitxOFJCTXFUZ01yYm9rTGpmcDBOaEY4dm11NlUzaUFm?=
 =?utf-8?B?RCtRdkNYL2puQkVqdUdBYjJEcWpFdUp4dGs2NHpkb1NUUUNYOU1mMVkzWHJp?=
 =?utf-8?B?OEJOTmFHZlcwRitOYjJvaE96TVVzYkgwOTFhUjcvWld5T0ZwbVNMb3JRVTlO?=
 =?utf-8?B?cm1QSW1xUWVZenNVM2E3ZVRXRDhDdWhKTnZQTTUxRGtHNVM1RStoWnpMTnJJ?=
 =?utf-8?B?R210OUxHdGhTMnVaS1VGYlY4QkNPbjhsT0VhN1RLNUpVWHkzdHNzL1ExRjg0?=
 =?utf-8?B?TE1kUy9iMGFaODRlNElxZmk3US9YMjloNGxLQmhEeVNicmx1emRmYStwWWov?=
 =?utf-8?B?NHQ0QXk2M2liZ1Y4RXE5bXJvbFVUckRnSWhKTytKOENGRFpRWkZCbUJhNG04?=
 =?utf-8?B?UTI0WU1hRTRGeXFEanh3eis1S0QwQ1EvWElTcjQ1S2Izb1piM29VL3d6ZmFP?=
 =?utf-8?B?Y1JDd0F6bklCMjZySGtsZzRGbzVTbkNaRGNBaWFFK3lNTU1aajErMWpXc3Vo?=
 =?utf-8?B?RnZHdmdxWHAzczdIbHozb0dYTFlBRHFsTDNSV29EdGIzTUFIY3F2bVZ0VFF3?=
 =?utf-8?B?UVJJNHhOMEcvNm9VRWtxMEcrVHF0QzMwbmNaWXVBS0IydndyWlpMOUI1cHR1?=
 =?utf-8?B?cDBDSmZiVmlTVTM4S2Z1aE1zWU9wWnBhc0V6TS81UHdwZTRlbzNTRWNYWnVB?=
 =?utf-8?B?aE1hOWlidDJ3Syt1NVl2SmNhOUR6RHZqL1ZmUHdsSGdvcXZtZTc3YmdBWENW?=
 =?utf-8?B?TzU2TWhEV0p5Nzc2bmhLNlQ2SFluUDJ3cy9kL1BUWnlpRFJLUEd3bVRCdk1X?=
 =?utf-8?B?bjhUV1lMdEZ3ZFhJN2RTN0Z1VUNVNncvdUljUnlFKzA5dzNEa3oyM0w4NGYx?=
 =?utf-8?B?NXpiMUFOS1Nja01uK2RXM3NXTXpDL05PcXR1Uk9mVko0dGRzUXl3TlVPcVhB?=
 =?utf-8?B?Zm1HWDl3VmZKZDN0NlNWdDB4VE9KK2dPb05JRDViTjJTL2EzVnozcVF4K3pw?=
 =?utf-8?B?am1EaW92VzBnNitXdEpZU2Jvd2ZFbmU5S2NOWFQ4a0JGeDdnQ3hlbVBSTDFD?=
 =?utf-8?B?RkdmMWo2TUZRSitCZHprU0JZSSt0ZlgvT0x6NlhPaSt4czBYWVZ6WS8rRnBy?=
 =?utf-8?B?YW1FWDVtTkdhU0M2SDR0U3hhRkRvajhBOVJ4QWx0RVVqVVhUd0VLczBQbWF3?=
 =?utf-8?B?cDJmblcrTnRVMXNVdExkN24zL1VINHh6ZFcwU2hrRkhhSUZBejBDOENwVU5G?=
 =?utf-8?B?RFp1MWVVWllGSGRDejIyclRKbEhpTWRycnhlcjZuU2poUkI3eG1oZ2xFM05w?=
 =?utf-8?B?WDRrOWJDNlk2YWxKWU1hT2hwbmR3RFZuVjBra1BPRGNNZHM4WHZCaHBkbko1?=
 =?utf-8?B?YysvdllsalZFT2lQK1EvcGZYWkJwRlkvNGtEajZlNXk3WHJ4YTRia00wd0hT?=
 =?utf-8?B?Vk50dnRvVmZSdFFyU091WDBCaisweVZiVlhXK2dhUHpYSFg5U1R1Q3czdkx6?=
 =?utf-8?B?Q1A3OUx2UHM3c1BwUncyYVE1OUg3d1ZDN3hmcFo2UjRtU21GWWVDQytPZXI4?=
 =?utf-8?B?UkVZbUJEbE9wK2IvNzg4NTZpdDl6YzVmdVdMdkM2b0xadEtnZjhPY2xFWkRI?=
 =?utf-8?B?c3MvWEllQzdUWEFTTjhqMzEremRnd3pKK0hvaTNtVEp6VjBIS2FqSXBkL2dx?=
 =?utf-8?B?eTgrUEh6TWNKVTdwUytsM1R1ckh5Z3luc0ErWUlaRmFqODZ0NUJjWXRIeS9Y?=
 =?utf-8?B?c2p6SEZRVGs3dTd6YS8yaGxVbXBVV3padkhDVlhhbjcwc0hiOE5aNFpsZjRC?=
 =?utf-8?B?dVBYNGtudUliZjNQMFdkYWpDVkFtQ3dnNVhwTk12eXZ0UW16cCswOUxtR0JQ?=
 =?utf-8?B?QjlPdENpMlFaY3lCMDVqdHlaUCt4Q3hVRjVINm9pVEM2eXhvMzR0eDBPZkll?=
 =?utf-8?B?OGlISGsrUnMySGszZjYxM25IQlZzRi9hNXFkU0MzNDhGa3FMektmUFh1dE50?=
 =?utf-8?B?MlhDMkVhdEUrUTBGK0FQTHYvNFJKVmtTQ1pjVHBrRXR0TTYyMjRyS3NXaThB?=
 =?utf-8?B?MldQb1IweW5HbzdaSUl3S3E3Qy9RMnNycW9qaE4wRWJRM0Y2ZXRXTU40U1RH?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB4ED56BA24AD94F946676CFFBB5A156@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EkTQiASXveLRjN7DVu3LU+QghXBIVWKG671RUnWSmpU00cI4rVtg+JgDOj5j1ZcaYErd1TLqeUwvQZSq2EFYTfSZKyfLCWvE6e3WAXUFlYEdRWr0EUn/sG2Ee8ANJ8sULaXziZWTYd7kMp4cCzE1JTGWtYXsEymEoylaP3iM9iVgoeYpJY3md7/qND4njCRIZTk4JX+eMwsOjS7LM5q3n6F5VP5hJ6cbR+yBf+JxE/AN6UBK3nk1VQPqlVpj72R9F+6V0rrWCqVbSIWLzcdRRmPyDNja17BBmyoksYSWu0ATDJVM7CszCeXSx9jg0ywpkHu+gRDcvTqGtdYxrfglJ0mKiSjlYL9jPFQOPK9+2UI0qdHdgjeSgVvEFYCyysP95bvmu7yr/e2s/kXWz0gts4E0OCh315eamAAUXz2YxZVx6dod0W0q+Jf7OOpE2hBR6bGpXEqHWKDogcA2EwvofAWrDKHGhKoZLMS5HNqGNRKHS0YWr8oFczPVZq0xFb/B3rL0fv12jD3EQyhzQ9BdHDr6+Fc1NzribUQog1bRJe59RIZhRKhzCEI3bwSH6UL7jU1juI3644/QAcUetgVNXV3k5mPzYuKny6AoLzSwbpvrL0znYrjhzeObPqOMsCwa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edb29cd-9aad-494f-efc0-08dd86e47c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 06:10:04.9432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2MAKuz2QkfjxRh0d17MmmWEQ1SXZ+fa1ixLdd6k589YKF1fWOh2ngWeyDsBHCnDPaLaCTtbnoDQ8kavXZ8C/rzx8T4eTyGRfPPV2Wk2RKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8434

T24gMjkuMDQuMjUgMDc6NTUsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IE5vcm1hbGx5IGNhbGwg
c2l0ZXMgdXRpbGl6aW5nIGNzdW0gdHJlZSB3aWxsIGNoZWNrIHRoZSBmcyBzdGF0ZSBmbGFnDQo+
IE5PX0RBVEFfQ1NVTVMgYml0LCBidXQgdW5mb3J0dW5hdGVseSBzY3J1YiBpcyBub3QgY2hlY2sg
dGhhdCBiaXQgYXQgYWxsLg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzL2lz
L2RvZXMvIF4NCg0KPiANCj4gVGhpcyByZXN1bHRzIG1ha2Ugc2NydWIgdG8gY2FsbCBidHJmc19z
ZWFyY2hfc2xvdCgpIG9uIGEgTlVMTCBwb2ludGVyDQogICAgICAgcy9tYWtlL2luIF4NCg0KDQoN
Ck90aGVyIHRoYW4gdGhhdCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

