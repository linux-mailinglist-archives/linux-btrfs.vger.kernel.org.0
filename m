Return-Path: <linux-btrfs+bounces-11525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB6A3935B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 07:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B20A188C72C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 06:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84311ACEB0;
	Tue, 18 Feb 2025 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D2gKiWi4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rwQjw458"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0022753FC
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739859494; cv=fail; b=iLhaZp5yTH65tUjzHjygLht27Aik6Ls3RuzE5JzW5HDyl0gWsqUr30fy+nh35RMt/UrrfHW4OlSqP1dA0P2/XRxpAsZIPIdij0ssoTReJZeCYmg4BcbFycqHykBHcFEByjqDiZ6LB051JTYsk5bl+QI1EuF0IexPpWvZadLCArE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739859494; c=relaxed/simple;
	bh=zVk5TEVEgtC8KZIP7juHd1GJ9WqaKpjR1wTa6wBK6Ro=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NfO5VFQiCzRzqHI19LxzyenNMAIOYsVinZyn5G4hMQCnYOsaqJtWGGFFWZeMMlbDwW2sZk7VFbX4N9e44iUTQ6hfr3ZHmcfFzuJ7agsz5wTiFv3NwDtEVz90xj6+vKPMNL0WPLBDItTd9wmvbQfhzMCkvjZRCB2cm7JumLDdMJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D2gKiWi4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rwQjw458; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739859493; x=1771395493;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=zVk5TEVEgtC8KZIP7juHd1GJ9WqaKpjR1wTa6wBK6Ro=;
  b=D2gKiWi4STVDXRO7UbF/dm0378+Q6qMo/KNEPzPPti7DkZkbHeuS8KRc
   0F1ynoGagdXaucW8WOx/+kJfuHizc+e5pnIMaYvJLC/N8UtW2KexBMj7t
   IN4/Uw4f0tcOr3wLF5oXQNyHEpqQEWreAUiAJM0ih+j4I9BWuH9Lqlotg
   o86Je1kKAyp7fE3jSmf4U5rCoA/BzQ39Qj4mG0Sla2/y7S2U1Oti15lyu
   kjGiqf2VCwBZQCM+66s8GzINnlWEBI0C3LK2nMhvqkjrTURhPeia1fdc3
   jQZucTR0ymmnVSw2GTi+cIL+7xS4KqwAOakLSBmf97p+JCf1b+go/t6kq
   g==;
X-CSE-ConnectionGUID: eksMJtcuR9Oa38/aUpakfA==
X-CSE-MsgGUID: IrHtlIbhQjWIw15OcawR+A==
X-IronPort-AV: E=Sophos;i="6.13,295,1732550400"; 
   d="scan'208";a="39741105"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.11])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2025 14:18:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5DtIhFfeByB5O4LncGwgE0EO93E/KB5953FWqN1hzYdVxTrsaVh8h8GvgWvhGSQUGup/VtUiDsaEJIJOT7JuEkQ1fltp1O8fw9fi8fRpzkclGnFl4xaZU7i/3LkLzP+3jGFwpI5sHaWV3PSkCYQbBhZ1zWPEk6koa+GCNebPO8+qMtUd+sh1Muotd0043oqV+ecxAN5+9hBi/mY32VVk1gmlmvNsj1dk23qFSKa2JggI202R8k17DEXciyBTMfloA1t/Eo5yAw6f3RkWvlzWXsYmvMNDCbQz1wRFVc6sf5UariOAbiCAPkbjjpIgRZPSOxDClV5AGHrcwBDMIirvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVk5TEVEgtC8KZIP7juHd1GJ9WqaKpjR1wTa6wBK6Ro=;
 b=f8cgNT9d5y2YQ7RasAsYBdVyLxvB7pbAj96TMc2z7tFAlRzgsmRcyvNjZ0rN/fj526aMUqiguPAa6oOtM5pRxBIzEh1Xd4DLRIWETK35riJAsASQC52Hyt3DcpWAhYiAlBvEB961Ja0gHxQfwvAtpW1YqqPVqtns7Y/xy6VXJFzQhngo00/QKKmbs1OcOKNQljMK2Pj270gnn0FvuDsq5QS6wLTHztqlCjJwGeKin2K5fOXvbD623fnBGLRdzEzCrzg85xuZtEYcV7bzdgZZKj7sGIiVyerppTBfoo6Wh/7GVgIgWw3drl+CY7ovngqRr0cH05Wcsn4KmpYKDhu2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVk5TEVEgtC8KZIP7juHd1GJ9WqaKpjR1wTa6wBK6Ro=;
 b=rwQjw458vw+FUT3a1tcsnyp7Vf2Om4eiGorCOE7Xt6BqBf4ka+J8uB3AMwG4Gzbz3VGGjbx5h3u2D2rYF+tOg2fi1uGf2rRp+OC457wAmD89Nd4vDrr7L8CiPm3K44EXvE+bc+AboloDggF3JOUge1w/AV3tQHrFBXVy07y8LRI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7137.namprd04.prod.outlook.com (2603:10b6:303:66::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 06:18:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 06:18:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: skip inodes without loaded extent maps when
 shrinking extent maps
Thread-Topic: [PATCH 2/3] btrfs: skip inodes without loaded extent maps when
 shrinking extent maps
Thread-Index: AQHbgHT6YN2mcOvWx0C4soXvh/GoW7NMmNGA
Date: Tue, 18 Feb 2025 06:18:03 +0000
Message-ID: <3ce8e257-3822-48f1-9c09-f7e774475435@wdc.com>
References: <cover.1739710434.git.fdmanana@suse.com>
 <663658b73e3cd9dd5e34e8eee34f4959f6ccb5ec.1739710434.git.fdmanana@suse.com>
In-Reply-To:
 <663658b73e3cd9dd5e34e8eee34f4959f6ccb5ec.1739710434.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7137:EE_
x-ms-office365-filtering-correlation-id: 44a97699-e788-4c48-6739-08dd4fe40062
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3ZWTmxXRS9DTEtaN003ZzJCMjFXcWlFWk9YTEVjNjVNVVVHYjJtTUhkSWh2?=
 =?utf-8?B?cHVVZEVBK1VnQmM1cFdXL3VsUnRqTktmVGpNT1lNSXFXMkVOQkZxNVkrZFFK?=
 =?utf-8?B?MVZuK1FPRE0yWGtNWndzWERrdVZoNGhiZVR4NTRzQzZkNHprWklQOWVQRXVZ?=
 =?utf-8?B?dmpyODlVM0xaQ2NLRDR0REJaUURMOVI3TFhueDZiMVc3emZ0dGM3UWovaWVs?=
 =?utf-8?B?UGdHcTNGZTZhb2Fid3JDWFFya2NaTDdXSmhvaHE1UHdlOXpwN3ZTYm44NFZZ?=
 =?utf-8?B?aEtVMzYxN2MvblN6NVBBaHpjVi93RVFtRWl5R0wvanlvUDlVL2dTeldPNEo1?=
 =?utf-8?B?NHl2djBSeUdROWJoZVMwM0dRYkoyMDA1UTFVdHBTQlVic0VEc0Iwa25qU3Mw?=
 =?utf-8?B?SXp0VGdGdzljMVZtaWc2QVRnNXRDYXYzdWRjTDYxd3oyR2JvNDcvWVNieDdE?=
 =?utf-8?B?VFhYSUtZaENmOFZTMWFjLzUvWUJQL3NtQndhUE5oanNVYWZITXlHT2lic3Bu?=
 =?utf-8?B?aklsRUFDWm9TM2pVV2RMcUkrTWtBZDdWQjY0Wm9yMVkxSGRoSjZWRDhEdUov?=
 =?utf-8?B?azBPcmY3dnlBRjczK1A5ZTlDd2JHRmVuTHlzMHR6MGhsOFloWGdyb1BJN1Zt?=
 =?utf-8?B?b09weEZ2OEZzNmVWWXMyeExRMDR0S0lZT1lOdEJhdlA0aUlaN2N4MEIrTm92?=
 =?utf-8?B?L2RxNjBaTDhSR3JiUUZKd001RTFLYmlsTkNzRlVzb3F3UVhUdnNRYkpMa3JB?=
 =?utf-8?B?NmhLdGFkaFo3U2dIdHVlU0djbmhkSDZuSHRJSW1PM2MyL0ZPMXIxTER1U2tY?=
 =?utf-8?B?V1ZQVXluSVVvRURyUExEVDl6bFpjdnBDTkI0aWpqR3NMaWJxWnF0WG5icXRn?=
 =?utf-8?B?TUJadklPZHhoUGE1L1pQamE1aHVKLzlWU29KQUI2QnBDZmJoWlRrblVZd1Fs?=
 =?utf-8?B?WU1SeENDeHZIclJsZ0lWdnVvVEhTODFYUjNQeHRteWVrM01WMDlZejVoRkZ1?=
 =?utf-8?B?a3JlSUg2ay82ZWV0bmIwaUhrTXFWWWg1OUtSdmZRTXQ5VDQyK0RKZFJGS2pZ?=
 =?utf-8?B?TDZ1bTRjNkloZkFBWW1SVlJnR01zL1djMTl3cUN3MGVNRmlJQUxVZDY4ckRS?=
 =?utf-8?B?N1hnbzZaTjVRdWIrc0hndGxVVWZRNjQyaGR5OVVJcVk2ZG1Fa3Q0bHphTXZ2?=
 =?utf-8?B?MHo2OVUrRFpLdERBMHBlbXF4TU5nRDVoaCtFTDltd0dMS3pEa0pQSUR4Vmgx?=
 =?utf-8?B?Q2tIdnlYUHBEcnN1RDJqLzRkdVU5K0xKMUFwSkF1WnovN082bmxiR0VvYjB3?=
 =?utf-8?B?OHJiRGREOVd5YTlIcUFzTEdtWHlLQmxxMnJaQVlnT2FGd2YrK2NVZ1FIV2dP?=
 =?utf-8?B?TENJOXovbngrUkxRMFh0eDdqbUZWTGYvTFB6cWpJTXRHd1haeWFQbk9vWDN3?=
 =?utf-8?B?dE1jcE5JdS8vU1F0VnV6REo1YkUyb1p0NGhNY1c0Ti95MEtxVlFGbnBNbEFh?=
 =?utf-8?B?THhuWUNEdWl6ZllRTFVWbndvRnI4RU43Q29HUVJVWEVYTlMrTUlENG4vbkdv?=
 =?utf-8?B?Z1JKdXpNNlhUMHMxZXRJU2dwYjJvN1pkT1dvekpBbXZSQ2VFZzBDcXRlTXNY?=
 =?utf-8?B?b1JIYzFkVHZEcTZFYVJVeW5Ba0hENUdQd1Q5Tk03U24ybUl0Y3JQRS81Smdx?=
 =?utf-8?B?VXU3Y0JzM0hQVXhYdnNpT3hmTlBGeEVwZ3lHUEcvY3F5L1JOZEs1Q21BSEQr?=
 =?utf-8?B?M25CMXU0OFA0NVh1bXQ3bml1Skx1VXQ0ZFdqZXR5cDAzQzlweWJoa2orS2RP?=
 =?utf-8?B?M2Y1MlUzbmN0V0UrRklYU0hsTU4vTzNTM3NJcUlqT3BpR2pBRjJXRFk0TlBp?=
 =?utf-8?B?Um9INDRnYmR1RXZsSTYzM1l4bGtxVUpUdkNPTGxIc1Vod2FBaWgrSEtWSnRD?=
 =?utf-8?Q?Iqd4xaLf+xa2FKqrgATJ2sNLvh1wt+KJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHB4b29ZdUU0bDZVSUtURXNzRjZFKy9iWFBCTGhuVkYvdk5JbnJIRHJYTXdo?=
 =?utf-8?B?dlNGV2tXT3Z1V293RG1vQkgxcEw4bjllbHIxZkdHbWtjc3Z1TFBrMVRXYnVu?=
 =?utf-8?B?bWNZUVMrN0JXTkZsQ3pyQnArUS9MaHdQYVNsUTZMQ2JDbUNJOThuWWRHa3c0?=
 =?utf-8?B?ejdzQTYwcm9od1BDdHJ5TGlyMGZldWtLWnlWY0VlZW5oOE5nVlJFNlFYSitr?=
 =?utf-8?B?Z3NIemxoVlY5L0J1dGUwZjhraU95VWRMVkdXVHlBOVpqYngvZWx4eTV2Q2Zs?=
 =?utf-8?B?Nk1zMWJROVBrN1RpRUJwWmt4c214ZlFUV0FzSWJ3MHNOUGg2cmNRNVpsejFK?=
 =?utf-8?B?eGp6OHNicWNVc0VjUytBeUVGcVNkY2xsdUwraStrY3FFcXI3dTVhTFdQRmZt?=
 =?utf-8?B?U0V6TVl4Z3B4VVUvTkRjM01GVTJlNjBZVFdCZWtPQ0tuRHg4R2UzYWFzRzV6?=
 =?utf-8?B?RFkwQzNScmFlM3ZiS3Z1c0FUVjY1eERNSjluWUtiOFYvWElYVDJ6a3FiNEtW?=
 =?utf-8?B?NEVhZEl3clJoZ1dkdko3Z1JMWWEzQ3prZC9LUHhxSnZvbkVaV01FeXlQcEUr?=
 =?utf-8?B?bGhXYktNN29NNUFLVFlIdXpNUUZQY1pTcTFRYnNETWQycGJBSnVKQklnQUZr?=
 =?utf-8?B?dXB5Y05tRk9ocU9TZmRXRU1oK3g2Z2xSR1BKdGFwRHV5ZVFpVFBoZjFTeEpT?=
 =?utf-8?B?bGpWTVVKVWVydTYyZE1USzhtT0dzblhKQ2IzcVI5RnMyM2NELzhYTFRRclI0?=
 =?utf-8?B?aEtpQjFLeFFjV2xDYi9uL2lGcjFyNXJxL3drNXg2T1U0T0p2MnVEOVR5c3V4?=
 =?utf-8?B?ZWtRZjF0VG0wZzF6WlFjdklBeHNmRjI0ekpOa2x3Y1hUMlQ0Z21kM1U0Z0l0?=
 =?utf-8?B?eWtKSHZIT1FFSllhWGFrMUFPVEFreTFVMythTk12d1M4NzlBNG9xb0xMbjNG?=
 =?utf-8?B?Ris2Zmw1SWhIN2U2MTIxU0p6MTVSd21ZVStCR0JVaUNpQnpXd3RCQ3R6V01N?=
 =?utf-8?B?MUc5cjRsRlh1STNWK3UrRW1aZ2JmMnVxN2VEcDZyRnVtZ2FORXJTRlp5RERK?=
 =?utf-8?B?MDE1MVN1SjlkamRraU52UVBGV0pKOHFvZnNmQlgveURYOGdmTWdmZkgyOTRJ?=
 =?utf-8?B?dk5sZ2VKdW15K0tLaFA5NGJRa3BwOXpwc3pOeEpSakhrR0FtY0JTMnhZdmtY?=
 =?utf-8?B?R1JoM3ZCMVpvZ2YvZTlEejJTNEcvcVBLcW53NVp0bkVrcjJ0ZVFnOXBsR0k1?=
 =?utf-8?B?VTBQNE5xWTVoOWJtd1FkNG5FV2tTakk2WTE3Qi8xMTdrNFNVSGw0NmdCVGpq?=
 =?utf-8?B?eEdTU3A5aWJzUXMxeTVFZmMxQklkcFJNbUEzNmIyMFdUSjlwNWJKRFZ3VHZX?=
 =?utf-8?B?U3Y1a1dtTHJtL21LK3pLQlJzYW5LMVFZSThUZjZQc2NJcUo2VUJNMkZkL2Ew?=
 =?utf-8?B?SVlIcnZoU2VKcHQrN0lQcEM1ZEkwTDYvOTRoWHZkcDVScUI1NjFYWnhaclUv?=
 =?utf-8?B?bVg3cDZzQU12UU5na1owaFdNejBLbEM2UTBBZTVpSmlMaE45QTZwMm0yZyt3?=
 =?utf-8?B?b3lheURiVjdNK1dOc01haG5VaWFuUkN5T1IxZmNDbGJkeDZzeVZCakVrLy8w?=
 =?utf-8?B?aEt6K2tpdmZKaFQ0RUZWY01sWW16cHdKSU5rb0hoY2krcEw1N2NkcUlJZklv?=
 =?utf-8?B?NzliZUNEREs4ZXFGWW5Wa1AvZy81cGxYRnliZW1mVVRrbzM4OGRVSEdhVHQy?=
 =?utf-8?B?T0FUT3lhWExsZ2RrQTdHQ0o1WVpLNWtCVTNKSzczSy9TaU85QkloZzRid1BP?=
 =?utf-8?B?WXBUdmo1UjYyWm94V1RnZjRtNUVKM3psZGtQeWxoU053R0tJYlVBL1lndk5o?=
 =?utf-8?B?YldVQjQ2eXYyWmpCMFRWWVNKWktMSTZ5cTFxc0hVY0I1Y1FybVozYlJOTmtV?=
 =?utf-8?B?UHFuSFlSNmxuR040aWxORlpjMjRUNTNoZ3lYZS9MN0FyMFZOWnIzY3Mwb1Bo?=
 =?utf-8?B?a2pDYTRvZVovYUo2OW9SY2lNblZRS05SNExqSThRVTdxR2h5TUx4QkFRbCts?=
 =?utf-8?B?aFR6aG9JTFFQRnRKOUFPMXJER0NLaWRaZml4b3RiOG00dmVJaEN4ZGl2L3ZP?=
 =?utf-8?B?Z3IzaTZ4a0laakpHT3JEamJ1bE1iTE5yN3I5YWcwY2REcXk0WGlSV3R6Wk56?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46D3BDCFEED96841997638D18DE62184@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JPZ3faCvRrazjJaFDFLNCvgRUyu3gcOx4DNmNkGqCvSkx5VPnGDZYGZEzG/WgyyOrbzM+TmD49kf3q5NmICDKbdA+KoJvX45nMMsVXGq9p76Re1gFWjJ/ccK0w7FO4Q4n4oxTA5xPdw6qp+DFVde2UCUsakQzZaFTQKEmI6gW3k/FM1MnFIN2un4M8K63VsCkL9malM8gWfgANyXJTFEMoZYdb2N5tTe7/bvmxl1Pj4TqMyWp0e/jQ+hOZWXSyc3jqRp5hn+6/nZc08th0e/iUMIB6YILreoIqQ2sm5YIc59iwd+KFVlbRJ+1rInZDgbVuZxtTt9Kd2xemVVlEi6Kp1jGNPG+eodSs0ZlbrgQ1e0BZHO5gfCnfRAHnpriM3beH0sPWS4iznzlGtZk0gu9wVeb40nCbwwWQcJtdbIFSIPRZFtpFWDGizmKCX3CUmh3yJNwjbcjlhqWSjUp+dY+pC4bG5XCrE1L7hXQqWdZ/WF7xLK724fmpoJfdVeHwVNE8+C+ieDsoJyfC3ldkJESLE52rlUaxgHPDIaKqzU4+L/pVhBCY9FMLmM5GxdHfTvjqPxRyZkRKdpnu9zFQ2kcAo570pUbrMP7R6f/MbVqjF+HttKvNPV8Lg3P4L3h5IZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a97699-e788-4c48-6739-08dd4fe40062
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 06:18:03.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UD925edPID1AwILWcfDEWvMgcHlhkwoeO/kB02mzMnM9IfWuE5xb3eH0E86S5mNC4v0vGme7erekQTbSTKOetxTLB7kpgsh6jNbKMkLCmbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7137

T24gMTYuMDIuMjUgMTQ6MTYsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+ICtzdGF0aWMg
c3RydWN0IGJ0cmZzX2lub2RlICpmaW5kX2ZpcnN0X2lub2RlKHN0cnVjdCBidHJmc19yb290ICpy
b290LCB1NjQgbWluX2lubykNCg0KQ2FuIHdlIGNhbGwgaXQgc29tZXRoaW5nIGxpa2UgZmluZF9m
aXJzdF9pbm9kZV9mb3Jfc2hyaW5rZXIoKSBvciBzdGggDQpsaWtlIHRoYXQ/DQoNCkl0IGlzIHZl
cnkgc2ltaWxhciB0byBidHJmc19maW5kX2ZpcnN0X2lub2RlKCkgYnV0IG5vdCB0aGUgc2ltaWxh
ciANCmVub3VnaCB0byBiZSB0aGUgc3Vic2V0IG9mIGl0IGFuZCBJIGZpbmQgdGhhdCBxdWl0ZSBj
b25mdXNpbmcuDQoNCk90aGVyd2lzZQ0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

