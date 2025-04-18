Return-Path: <linux-btrfs+bounces-13152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818FAA92F01
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 03:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D294F8E1FF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853116F2F2;
	Fri, 18 Apr 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TM8usd/J";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ozn3zUVj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA6224F6
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938002; cv=fail; b=HJZZTT/g1zYHW26skvwF8wqQwHnaKy3Lmezwx3eMMIUA9zETmFDXuX680O1XxXhALuQusIlXyuaojdGYdBd5uMBFAKiaOnO2VY9fhoC9cjIfI2WNQoOk2n7bJU06y1athWDg8G1iR0USdjL/+lbRxwYqo0MggOxkAO62hDeFWV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938002; c=relaxed/simple;
	bh=HsDOuZJFFYAFPO6HI9QtlvhTJtg0A/E7OXJauQxHOQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMkL1COdr16X36vi1JhyuSPw/laQWp7KPiXu7juqr+YPsjkc6zNxDo8AuM5Si4nL/k8rSubn/RhJp1S1J9zVDx4OUg753eVNqbCsaHtyM4m6Y9aUgKd73L4VEOVkgdrpIw5z8WNMH61IFKhZAIKPfoUAgOifrzW9UbLlbuJ2b6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TM8usd/J; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ozn3zUVj; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744938000; x=1776474000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HsDOuZJFFYAFPO6HI9QtlvhTJtg0A/E7OXJauQxHOQ0=;
  b=TM8usd/JmsOnCEv5B15Qe9PKA3QT+nEzwenMtcHRw4oD7miACedE2C5k
   PesEIt59PhXU4ezrXQ7FjU1qZUqemXwi1cwN8sji58xyQiKfgPIIqfksh
   YE42aicry09TtLLSmRyvcISq+Nzhnnq19scQXfR1DdPbWH2zniKO4z4lW
   1LXvdirjNszyrLlYhAthkYZDEsBupUCLXLOizo/Hd/d77OTID9mUIbd7u
   jQU8+yXlIn13Bk5zj+cSRZduvkBPNpq0xZAhbaNx4tGEE6B5fdHAk57Wm
   h4VJ1AJgOWTvR/jQKXS6oS0FGqnaoEVSp2FF8IHLQ7eggBorkqyErcJ0u
   Q==;
X-CSE-ConnectionGUID: 5Fz6XRkAQ5KOQi2nBHw4sg==
X-CSE-MsgGUID: 4+d+J8hMQJKS/6qS8Wv4fA==
X-IronPort-AV: E=Sophos;i="6.15,220,1739808000"; 
   d="scan'208";a="81657473"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2025 08:59:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkAEJz0I7G/yKrEZgYAzR3XCUbVveYFVfvR9fhrt0T20K7bkX8YgWhi22MTh54jl6rFVB+KeTE9w34rzgJJTMIcvmLtnu2L/gd7SNdPmEvHt+3ajoANA97mWzPPuVEESHfn0jQOnZplUYkmqUiwTl1kC8HOmDs/c3klH7IMmnaDTKaJjY8WVGWAfwkt+0QdIa+3yhKdiWNQOfbuK/8fNXiuBRYubO8Evt373LP0HRvrPB+IVCDxbdiijSsBWmCBqhjBgYB+Pi6Y+vOw+KheZyw+wWBAlIGZDwxRuGMg9at1MZznyVKHdtp5xPV309sJKAitOhs9RN7NDJmP9GnpGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsDOuZJFFYAFPO6HI9QtlvhTJtg0A/E7OXJauQxHOQ0=;
 b=HGl54U3WwyI8jzc0aGZ+LyGor3gTXQcQOLpFH/6tgKb+01IrwpDmo60PBdu6C1Cmli33ExAv1sMGnsW1juhyw/tTxs1upI+9tHRI00exDn2gRLY0W34fZv8U77N1oF6s7Oy7/Mwd6WhKEIium+fY6eUO2I4ceJ/flJA+vuMU6O5x7JrKyocMZ/axa7o7WYkZrK2FQxV4LQpMwHPsNr17Z1Q2vHEy/zH4rv3VCyQcJaeoSRycq+TiCfSi5g8/hILpo1aF+gRdayD34Wi90v/gXgMqZrlr2pgfPcZ0w6JE8nUxN8Yar4RYT/H1j0pEEhnFZAsMKD94iaX0UuxY65EfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsDOuZJFFYAFPO6HI9QtlvhTJtg0A/E7OXJauQxHOQ0=;
 b=Ozn3zUVjOJNocS8yMlfQdLZlGNRPig9RUBF3DzNe2mY0PymwWHvbRBvC1rpppX+3O7EcJJZjadVQK6GpVCubnsPwNir7eVQkrUEUplPLXaj9pS0LY7cemk1cYE9KtKIeiBGnEyGS8PZMev3VLrguf9MtRD1r/8xoYzXiASN0ySo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB8394.namprd04.prod.outlook.com (2603:10b6:303:141::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 18 Apr
 2025 00:59:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 00:59:52 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3 06/13] btrfs: introduce space_info argument to
 btrfs_chunk_alloc
Thread-Topic: [PATCH v3 06/13] btrfs: introduce space_info argument to
 btrfs_chunk_alloc
Thread-Index: AQHbrtvX55JbS9kVPUWFTYa11G5JurOnzZ6AgADPCQA=
Date: Fri, 18 Apr 2025 00:59:51 +0000
Message-ID: <D99CW6EIE4SN.3458I4ZPP796B@wdc.com>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <bf7314dc720dbeb1de64b95512cc796fdaba7ef3.1744813603.git.naohiro.aota@wdc.com>
 <20250417123849.GA3574107@perftesting>
In-Reply-To: <20250417123849.GA3574107@perftesting>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB8394:EE_
x-ms-office365-filtering-correlation-id: 820d2b30-2777-4eb3-8b3c-08dd7e145366
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDJpdWFBOGJiYWJsbkVUakdmSk9FQjhYNUd5enNXMnk1SitjWXAwNWNvTXZS?=
 =?utf-8?B?cXRsNzlFMnBQYjUxVFZFYnY2d0s3cU5HSndWV3B6OXA3dHlYRURzZTJTN21l?=
 =?utf-8?B?MlJRamo0U25nbGlxMkVNRnRLcTg3akNKK2g4aUdzMVNQdUNzaVdVajBxcDVs?=
 =?utf-8?B?UHBCR01ES2VJK1p0dk91OHQ4NFhOMysrbndpQmlndWdVM2tCQWxWWE9RR0JU?=
 =?utf-8?B?MkxpTDgxT0VDZzVqYnRIZWsxYTVxQ1FQNnFPeTNCOG00Y3poZC9MSXkrY0wz?=
 =?utf-8?B?Z0VuaDdmMkRxM1BuVU15Q0pjUHUzeTBJelZzOGRrNUZGaDNEcXR4MFVVZkNX?=
 =?utf-8?B?bjd1alJUaVBNeVN1ZWE1SFZWbU1TM1RMWmRlNEdnRTZucFhJdjFFWjlEazQ1?=
 =?utf-8?B?SWRKTFVIdHFjMkoyRGp1eFByQVdGT0Vra0QvUDREbWVZOWZTOVB5a2lza0pQ?=
 =?utf-8?B?VHRqcGwrL3lmd0U0RDJYMEp5QlJiWnA2U1RmMEF4WjkreHFDWTZXT2Evemdv?=
 =?utf-8?B?aHRWSEFSakp2U2tTbHhwZUFyaGZHVGc1WVhzdWdsQ1F5T2VvdEpMMzg3L290?=
 =?utf-8?B?dUtZRlZscVVLU1pPdkJlZGJEM1BaWG5obU40aUN0VXQvd2F0WE5IS29UdTJa?=
 =?utf-8?B?Tko2bGtTS1JneTh3aEVmTXJmL2ZNM0hrT1JvZ1oyVFBUUXhLeStXZHB3RUFY?=
 =?utf-8?B?VW9nUmFpbWxqdEsveUtSVFBVanowYlo1aEFZRnRPdXpINUw5MURwTk1jZEZS?=
 =?utf-8?B?K1UybkZpdTFsTzhyWWE1ZlNNUk9xRE1Hem56VDl2UDhRbDNGS1hTZ0M1V1o5?=
 =?utf-8?B?VTM2TzBpYldzSzVIaVVUTnRRMXlGbmNwaE1sY3JTNXNFc0NWWEtMSFQ1bmJz?=
 =?utf-8?B?Q2c0N09wYVF1Z1VyNENxMnU1RmJkWGFjTzBOemhvYW1Eb2FIZ1Z2UVBBaU5u?=
 =?utf-8?B?RktvYUZLTmx0OXZHRzd6WXg4MWsxaHhqZHpTN0V2N01qTnZ2cVBRQkVpUkxY?=
 =?utf-8?B?T3phdHJmM1d1b1ExUEwvd0l5Umtua1ZXbjJwNWhoY2dXWi9vYzNCNU5BMkxq?=
 =?utf-8?B?T2lvRnczK2sxYjYzVDRIY0t1Y0RhTktSMnc1UmdoYzhZQ0xLOHM5TlpKT2dT?=
 =?utf-8?B?UlpOMDB0REdWb0NLSFlCTCs1RjNCN2JscjBvM05mMExZeDRpMlpvd01nODZn?=
 =?utf-8?B?U2pTVzQxWmlmRWgzT1lUUHJkd0l5RXh3K0RqNENnUWthSDNyb0RSdUpYMkVJ?=
 =?utf-8?B?RGxkZ25xTVRFQjVWVXZIQmp6US9tcWlaSlRZLzdQRDBtdC85VVNPNHdwTmU3?=
 =?utf-8?B?Q3NMZEVVTGpHVHV3Sm5NOUR5eGllTG9Na2g3UVlndnVEMnJPUWFOM1VyQ2lE?=
 =?utf-8?B?OWVpbmhLOEt3dnlRa3hSL1RMY0MxekVtL0dUTU8veHh4MW5reENnenI2V0ZZ?=
 =?utf-8?B?NVc3cjc4YUJvL1ZaOFZPVmNGL29Mbmg2Sm1ONTBCK01qOW9OeEc2cUZTZlZB?=
 =?utf-8?B?dzBDWFZoQ2NrK1JXQTU5T08rRzVaRC9MQi9LNUlwMTFUNFhZMXdlSnY0S0NQ?=
 =?utf-8?B?d2dyNjJmNUhmc3ptWUN1dnVROUJUUUpWMlF1blBKOHZhOE9nZDMyZnhuMk5O?=
 =?utf-8?B?OGRtekp5L0M0WDRwa0ExMk5hcGZrNVNvSDJZQ0V6UElmazZEQTFZZmlpbVdj?=
 =?utf-8?B?ODBHWWYxMTAvTzArTGdFTThVU0NXUnpxWjZ2OWw5WUlVNUd2VWY5dnhmc0Rx?=
 =?utf-8?B?YVlDa3BlRllqM2pRYWxIaVg1ZExPRStITFJpOVdBaEJ2UE9vanZDNHdqZW51?=
 =?utf-8?B?Y1hpRmFYaktSQWFSZStxcFMvbWE0ZnUxTEdOcitBbmhBOTBkSHVCN0orOU1q?=
 =?utf-8?B?bHhJMFQ0Y1dZaTdyUFdKY0U3eUo1UWtwaFJwRU5FcVRwM3pJVEEvaUp4aGpL?=
 =?utf-8?B?aEFlWjZ1TStxRHpKNXB6MlpqS2FDVGQ4eVFiWE94Tlpia2Vpbm53cFNyeU8v?=
 =?utf-8?Q?MYKTrsZnRanvRG1RdaHKeWXl5Xcvag=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWxMTC9aZEJLcU5zM3FJeGo3ZG4zVkp4OWVGU3gybTNQSHB1dUxlb0Y4M2tD?=
 =?utf-8?B?eFBLTjNmZ2tjQW0yR0JJTG8yTTFJazAvZkNEOE01djZVbEdibWs2Ti9qNTk3?=
 =?utf-8?B?c3pNV3U0Z04zelhxNjl0OUVyZVg0UGs2YnphR2l0V1lVWGtUSTB4UW83eVZP?=
 =?utf-8?B?OVpwRHpzc3Zza1hidmxVTHIrYlU5MnlqbVVzb0tkci9JOEIyNWJzVlUxbS82?=
 =?utf-8?B?VDlLb0s1QlpTNU1kR202cEZnOTdNcDNDRnZ1eDhLZWxCVU5xVkpheXN5b1hm?=
 =?utf-8?B?M0N1ZzZseFNRQTlnYW1EOG9IVGFmQVUrYmo2RW1zdjAxdTh2ZTVUQnF6VDRq?=
 =?utf-8?B?c2ZVblBrY1FtN3o5WjJsbHFuSlZuUHpKdlpvUC85YVFwak45d2xUYjR6MFRJ?=
 =?utf-8?B?bkhFS0ZZb05PL0lYR0Z1R0NwOTF4VWMyMzZjK0xkTUxHazNPNWczRjhzalRC?=
 =?utf-8?B?VVEvdmJEbUdtQ1g5MVcwcDZYZUpuNHd6Nis0YXdiWmR5bkE1NWVNSkhhRjZq?=
 =?utf-8?B?UUpDVG9jcjlnRk96ODJ5Ymh2TjE3cGcvREsyYU1waFRtVkdlUzlCYVk1OU1Z?=
 =?utf-8?B?NkxRbUJmSXhzZ3dXNTQ2c1NhRmcrb3BIYTVoTUxqNnphekxFcXpHaitSZlRt?=
 =?utf-8?B?ZTZMYUV6dTJYS0tFV21mMG15Y2tSdnp6UG5FQXMrUHJuYkpGUlErcTdXdE5T?=
 =?utf-8?B?cTNMRUl6ODRZdHB1alJpWEVBTktXNU16cHhuUGJFemhBdlQxWk91N0o3OHBD?=
 =?utf-8?B?dVpWd2NDeTg1VG5UcCtWaWVWdTRVbFhlS0Q3WFFBLzY0Y3UzTHVYYnFuaVp2?=
 =?utf-8?B?Z0tXZUg0OS9wbjh5ajFLNDhYT0k0ckFLS2g2cldWZGk1Ym8vOERzbXljZXQ3?=
 =?utf-8?B?QVhxS1BmcnVtdWgrd2xPRHZubHpuU2VVU0xzQUxQZE5ja3RYekt0QjB6SWpI?=
 =?utf-8?B?ZFZEdDVHUTR3MDB0ZVlqdnNRL0o2VUdhZFdqWG13WlJPSGJYU3dsdklaWHJK?=
 =?utf-8?B?bnlTc0g4TG5pNlIyeUswZFlwUTRldjJsMVdBdkhSK0ZvL2FxS3lvU1NURVVZ?=
 =?utf-8?B?ZFhBRXQvY3JTOGx5dXI5VmJQYStreVpvOWxYdHpJc1ZHT3g5c1ZaekZGZlN4?=
 =?utf-8?B?UXFPMTJaWkdJZ1k3T1RFWU5GNzJMYXFZbTNoS3FEVC9PZU1qc0JZTHcyd2FH?=
 =?utf-8?B?VUIvNHZ1NVVNd2swd2k5N0kyMkQwSkRkcVpjRWFUWEUwZXFaaTRsT2dZd0gx?=
 =?utf-8?B?TWprOTVPOGRyaUJwUDJwVjJqVEFYUzhwblJFcUVhbzk4enQyckV6bmJEaG1Q?=
 =?utf-8?B?dzJoWnYreXZFdG9FMWNlMXBuaEgvMllpNUxvT3VEMFFHN241cmJabENGM0hX?=
 =?utf-8?B?WnArdE1mZ3pDK3N5UG5mY0NodWVkUVdGNWN6dTdMMjROTHQ4ZGRQUTRVclZ4?=
 =?utf-8?B?dmRUU08vbzNRSHBIRDdGaW9nOEc1Y3hhMHNFcDN6bXhTK3F0SWt5dDFab3Vq?=
 =?utf-8?B?cHA2NnhoOE40SDY3WmZPQUgvN2dtQVBNMzRrcGZNdEVtdmt6byszT3VlL3d0?=
 =?utf-8?B?VXR4QUJXWXFkaXo0Q1dLUDZIQTZPd2UxY1JtaU80bk9SbEhvY2pwSUZiZHA3?=
 =?utf-8?B?bXp0VjFidGxUaXFHSkdMYnN2bTk2Z0U0dS9EaFY0UWlPbEdaZFplSjlodUtr?=
 =?utf-8?B?Z1hhVnlQanI2WFFsREdlcll5T21wU0kySFNoTnoyY05Ec3NKV0tyYlp3TXRq?=
 =?utf-8?B?RVNLdjR4K29HWUpKWXFRVEhmbDBJeVFha3pGZ0VJYVl1cDdCSmgyMlFCZ3c5?=
 =?utf-8?B?dGVIbkhsQnRjVDl2NExqNXl2SWxuMDlva2VKSENNTWw3UkFhVG1zelRWclUz?=
 =?utf-8?B?Mlk0aVNBcThHTGJyN0YrRi9WbEd1aFd5dlI3WW9qZWkwekFTYzZHZlMrOU81?=
 =?utf-8?B?Z3gybzhwTThHRFM3NGFKYXA0UVVvU0UydlUzVGxjL2ZNaTJoclRIeHdORDRM?=
 =?utf-8?B?aVNSbjZHWkwrN1dqclVDelNveG8zUjlCY3NNbWdPZ1BpaDQ1elM4Q0Q3Wngy?=
 =?utf-8?B?Q09jRnZVU3RDYmpXZkg2UDBEbTI3VzQva1MzMWhyVDh6bHM0MERjODlYMVhM?=
 =?utf-8?B?ZGxZTHQ2bGVONlo1U2w4M1hQU2pleEUxQitBb0pYMXZ4NnBXUGhIMnRmdTdi?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <434431FF58FDEE4EAE6DBAB2DCD54286@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	95Blw1AJlx4MU/PuE8ZLN5YkSTp+OGpKRdfhpAhlWj4oTPk+J3RbZL23NKNHTO6mSPALYK+Ibb4qkKlnBPnWHprUDW09zrtpkMzeOdRmIIjEEepTAo3bF233tDrqntExwq4mQqTqR1j8e+7jjgqkNwodgJAhKj7V8OXOhK/orbko00Rf88f/1BE8p7FEL58YCvzNgCp8UkQeUuRrxfjs16v5P/o85vzMWIeKDTSjtSrARXAYxAdJSeTgVv9mN/PwkFRYSwHj7IbRR/jw8geELQiaZJLo5SqJqtWnlctxpNjHeNSlcAoEpc1X+IHFWKTDC+FrYILmxPWXrfa9a/t0dFUsK37H0MXhl3Or2Qhcw9M+uXJEVqsfcm82tFChWdXz5gWU7uirBvaxPsu9lKIhvXYbYQjFwqBmdu4HN4Y2pMsir+LAPqHQtdPNw4/wY2RpZZn3uZvvJ/EQDKK5YJD+FHYtDQqIs4T2OQvVzhv028Dw089xbDhUGnwvUJhQAbwwHZU6qMICRoA3LrRT5ndZlqp8DOobhbPzGt8C+qMEUeVmlph2Leuh2eaEgB2JeAxxVJz32ceRFH4ZGeknR8e0Ne55yF6tkXA6Nm945lj4XQRXKmWqskwGY+UZkhJf+MMU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820d2b30-2777-4eb3-8b3c-08dd7e145366
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 00:59:51.9754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GgHu+YsKzfWr2OUb+Q6dzS9sa4amcLTm3X14azYSnlGW5GnkFlKtcKoPi7K4U5sF518Ddh+sLe/pFsOrV3yP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8394

T24gVGh1IEFwciAxNywgMjAyNSBhdCA5OjM4IFBNIEpTVCwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+
IE9uIFdlZCwgQXByIDE2LCAyMDI1IGF0IDExOjI4OjExUE0gKzA5MDAsIE5hb2hpcm8gQW90YSB3
cm90ZToNCj4+IFRha2UgYW4gb3B0aW9uYWwgYnRyZnNfc3BhY2VfaW5mbyBhcmd1bWVudCBpbiBi
dHJmc19jaHVua19hbGxvYygpLiBJZg0KPj4gc3BlY2lmaWVkLCBidHJmc19jaHVua19hbGxvYygp
IHdvcmtzIG9uIHRoZSBzcGFjZV9pbmZvLiBJZiBub3QsIHRoZSBkZWZhdWx0DQo+PiBzcGFjZV9p
bmZvIGlzIHVzZWQgYXMgdGhlIHNhbWUgYXMgYmVmb3JlLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5
OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEpv
aGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+DQo+IEZvciBj
b25zaXN0ZW5jeSBzYWtlIEknZCBwcmVmZXIgaWYgeW91J2QganVzdCB1cGRhdGUgdGhlIGNhbGxl
cnMgdG8gbG9va3VwIHRoZQ0KPiBzcGFjZV9pbmZvIGFuZCBwYXNzIHRoYXQgaW4gYXMgYXBwcm9w
cmlhdGUuICBJbiBmYWN0IGEgbG90IG9mIHRoZXNlIGNhbGxlcnMNCj4gYWxyZWFkeSBoYXZlIHRo
ZSBibG9jayBncm91cCBvciBzcGFjZV9pbmZvIGF2YWlsYWJsZSwgc28gd2UgY291bGQgYXZvaWQg
dGhlDQo+IGV4dHJhIG92ZXJoZWFkIG9mIGRvaW5nIGEgbG9va3VwDQoNClN1cmUuIEknbGwgcmV2
aXNlIHRoaXMgcGF0Y2ggYW5kIG5leHQgb25lIGluIHRoYXQgd2F5Lg==

