Return-Path: <linux-btrfs+bounces-8545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DAA98FFDF
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17741F23B62
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B71487D6;
	Fri,  4 Oct 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GaYc+BLF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vh6Jbywp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A833146D6E;
	Fri,  4 Oct 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034747; cv=fail; b=rLVT146wCDzx1LPBHzoU1uHk6MlYPwnRUjbDTODCcTkGRizbgjyezRs1HVp2mdMd+sJacnhUnx6uUHBDAWmlP0prBRv9WroSLIx6gIuAo+xlABPfN8tgJFBfvaVQuNCR4Tw7KeJ2GI0pg/52sOXxjEs9PPzeTCrhzbBM1Eg4Yzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034747; c=relaxed/simple;
	bh=zKjPRT7TUWDkqkss7VlEDK3L2Vhk5sDoE13OMy1asTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DLjFMJW4MC+XqDpWQDx8uQSRGrqgxCDIv5ncJdJJQ72OH+sbOig1FqRRJDQPcv3zvRgkEpzFFDZXkf8o4ClvbDLdmlXBxzfluEuLiAKmxuel7x3AVFUGn+hcfuHdYgmfCIynFw8S9LG3+FUA47KoFu+XlQiaf9MKnB6jP2NLfYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GaYc+BLF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Vh6Jbywp; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728034745; x=1759570745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zKjPRT7TUWDkqkss7VlEDK3L2Vhk5sDoE13OMy1asTc=;
  b=GaYc+BLF5MNlJZsURahWrbWZ7WMoUfA9cyxzT0VYTurnrHHG0GVaipFx
   1v9MdGhxvJ/VwfnZPCz35ACmeBdh+WjzsP+V1gJKzWx/AgrJ4bmf6Wu8W
   Rwu4dV5tETFHqyUMgNwzL8N0zaRQTj1z1wytMc8OsBtSL7LPG2HZw4o5Q
   1T9dAFB94tjAyLZVwsTqBlB69xwDBP7UqM8ucvpjw+fNsNXgsC1W7jK/t
   +L9MVXK/aTCEE3++wOLPn75rP44Iamp9mMPtMnXXh5J8bT6oHNKAGqTR0
   EKcwNauThUZrfwWf4+JIgvKFgXC3Ufih5TVeTOCFA4L0BarzbprWv6Ohv
   Q==;
X-CSE-ConnectionGUID: TuUQgMpqRbO6PYDShNLnow==
X-CSE-MsgGUID: Pc4JH+VaQW6weytEw0rCnw==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="27618436"
Received: from mail-westusazlp17013076.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.76])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 17:38:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0cLOp6nrO8kKpGvy3dRT9xD1MIXTjuKWqL9Bib6R6n3I66TPEMd/vC+D2NB5O2wV6wS2ltGaHXibIzXRYjnycflcY98zrdkqQwUaqpbHzSmPBdCnGQMRhXkUHOCjIpaLUX3NkZBn6Jp0SGEE0Vx/E9HMv1YkL/nx965sQQv8xEs1eWE/qysLaWhLWWuTUgQL+HTFZj4gyqDzoJlfPS3qxRPuyRJt11R9ymk+TR7f1/PlLxuFMVnjLstVbWJUdGd3yl8HgXpGmNFMIBykTg0KU189k1sfXb0Vm1+vRDZb1LpT3MUIOmYB04Y7gXRPupnOH/75xxFsAdTn5gwaZnt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKjPRT7TUWDkqkss7VlEDK3L2Vhk5sDoE13OMy1asTc=;
 b=AxiYTGblNw5xfULLPYUbP97kpLAf2Eak/rDUuICQya6JCSjDjj499acCYnS7rutMNT6e4zmcIraCF7MPD775tLCyJxb+JDJxUw9HU/Scs+MjtYhAWC2dHYW/787MppeMkjmV1lyVdiGcJfH9ltgN6eJIuc/RvWcutEWWhBPgbqb7+1OgvVtRHOQ9RTXccwvfXP1QLotwUfggVJVhzdocICAsq/XzSWogRBxmD4BySTapy3wH7PeTzwqfCPay9t58WCW0+DP2Wbc3Nqrw2OophFAnLUMcLkVoWl4RbkD971qwU0vqHEuB/eBcSmkMkcTvGmBl82QmOJVtFHec0xcl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKjPRT7TUWDkqkss7VlEDK3L2Vhk5sDoE13OMy1asTc=;
 b=Vh6Jbywpqzy0pP41bBJwMQ9LIdaKH/qNGBomI5lbL1K6h4CAfBoh+x8nLs/ublRXrfTI6qi0BPyxtaMT8h046MFbz7F9Gpb00zursXpiidNI6KPTHe7JvIw9uILXm8unUONcyXb8GKNPBVgGMGRB5btbXJdHm8FqtcmnFnQLN44=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8857.namprd04.prod.outlook.com (2603:10b6:208:490::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:38:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 09:38:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: don't BUG_ON() NOCOW ordered-extents with checksum
 list
Thread-Topic: [PATCH] btrfs: don't BUG_ON() NOCOW ordered-extents with
 checksum list
Thread-Index: AQHbFj8rNVo+D/1bzUq2YjOkJDH9O7J2U9oAgAACGwA=
Date: Fri, 4 Oct 2024 09:38:55 +0000
Message-ID: <ea468051-bc9a-4b9e-adcf-ff108e145f6f@wdc.com>
References: <20241004092337.21486-1-jth@kernel.org>
 <2343fbbb-30f0-4802-8039-8b9e9de72aaa@gmx.com>
In-Reply-To: <2343fbbb-30f0-4802-8039-8b9e9de72aaa@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8857:EE_
x-ms-office365-filtering-correlation-id: 9adb817f-32a1-4c51-742e-08dce4585d50
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmxwcmZ2dnRUYUhNNmdadjU5V0lWM3NyUlM1cit3U0NnUTNmQnZrUDlBQWNO?=
 =?utf-8?B?VXY0cjJSVXRyOWl6MkZzWXpUYUxHK0ZSeUswbDJoNlgzcVpwN2FxaSsvMndN?=
 =?utf-8?B?ZU1HV2dnMm5JaWNnd0gyWTF1bzdnampwQmVmUFlJMWs1eU1Ub01WS0hsVmdO?=
 =?utf-8?B?Q3ZNNDFRakJ5OCtGaXZDWnp4ZjQ1RTRsbHRTb3RoTFZFcCtMWEE4N3RTa1N3?=
 =?utf-8?B?aHlmdStud25ZeGxIUThRdTVqWHRVbkNoQ2xmOWRWdi9Nd29RQ3F1OEI1UUZv?=
 =?utf-8?B?aDJDelNuOHJBWnllRktRL2gyRGlLenBFa3YxOXB6MU0zMjlsaUs1SFVLekcz?=
 =?utf-8?B?WFRIVjdzMVdpWFNSS0d4QWZpT1hwSEdma1FaWElVQTcrOWVtU3ZPRk9lVzdL?=
 =?utf-8?B?YlNwbThVQW1PdUhOS0wrMUt5RnBOTVRhMXNLZk44SmtpYm9SZzdNTEt6R2Qx?=
 =?utf-8?B?UWZoV2V6dCtwYXh0bjVubVhYUGdlOEZFRm5LTjJIRkNQSTIwRFp6RXh5UjRZ?=
 =?utf-8?B?UzI1YkZlaE01aFBqdE9YcHBZQitsWmJxY1UxbE01bXR1UmtCc05aZEtoRlNP?=
 =?utf-8?B?RjZ5VWd1TFlsVkJ4Z05NOTQ2UHFYckJmR2w0SGt2UnZxWlhtV3BJU1ZBbjRa?=
 =?utf-8?B?WHpoa2VualFtUHVjcE03MGFTUTVJQjQzV0JjZU55R2YvekthUlp5TlV1VDFR?=
 =?utf-8?B?MUowWGt3RXBhRzd5UTMya09VdlNGcVpzLzV5blhWVzg3citNTXVoQTYxRVh4?=
 =?utf-8?B?VjBYK2VXR1R4b1M1MmJXTElmcTVPK0VDTlI2aGQxQWwzbnFFTFdYYXo5UFh0?=
 =?utf-8?B?VlVHV0tsNHJzcWg3VittNWxkNkU2L05jdTNDV0hoK202RTRSUjRDUlJHTUVj?=
 =?utf-8?B?UWJvQVV6YzBkQktiUUlnL3ZLT3lSN1YvT3hYRFBsYVlyTVJ4Tkp5V3IxekZ0?=
 =?utf-8?B?UVJzTlRyeCthNHpaVGpBY09LdjV2Q2JJckpDQlEwcHJaczFBUFZDK3F6VTNi?=
 =?utf-8?B?SFFFMnlKMFd0a090OE9zVjBBTUdxbjRhTFJFVkRNbDA0dm8xSWc1U1FrNXVG?=
 =?utf-8?B?NEJ2MEJoQ3UyY0Z0ODFIemllZEFqOGthZi9ROGxtbmw3Y1Zua1hrY0Vwc3o3?=
 =?utf-8?B?STNJZ0lnZDdwMDQwTFA0RldldG5ScmdjRE16UnM0eGJ0dnpsRzZBWWtWOHpM?=
 =?utf-8?B?L2d4bmR0QUM5QVNiWVpJLzV1eHR5b2pnVlVhbDZmWUNacU84VVQza1BTRDA2?=
 =?utf-8?B?bTJTVTA1YXlucWpZZTJSeUZWdlBJdDlLTEw0VTFwaE9RTi9YT0hTMHRGZWEv?=
 =?utf-8?B?VFViWWU2dDJKM3VoTERrbmxVV2xzTDNpaFVORjl1Z1B3T3N6dWZURWVmbkpp?=
 =?utf-8?B?SDcxZVRwRXNobFlDaGJmV2hOeFM2T0xqWldtMkxBWTlWRXBWb0ExS2Z0T1Mw?=
 =?utf-8?B?WUZZZVZINXBLREl1clQ4OWZqRjBES2pEN2ovZTdBYVhyNVFkZjQ5MmszL0Ji?=
 =?utf-8?B?QXZvVHRlTGZrNHRuOFg3S0RUNnRkSUcyeGt2ekk2YzlkNkJMVUdPNWpNK1dw?=
 =?utf-8?B?QmUrandFNUJNUkUxcHhjNjNndW1wS0FYelFMVEpOaWRST3dCSHpWNGptYzZ3?=
 =?utf-8?B?cnk4K3htb25jVXlGUVJ3NXhBdHlhMkZlQWo4SEFaWjFIT1ZWaWZQcXNUekcv?=
 =?utf-8?B?Sll5WTVhRkVYVGFrSDllMkFZR2o4RXBqeWJadStUbHcvck9hVDJ5OHRSZHZs?=
 =?utf-8?B?RUVsaEhkUWpNYXQ5S281cjRiTHpON09sVGpONk5KLzVPL2M3T05LRmo5Yzg4?=
 =?utf-8?B?enFWS1FyTXNFNFVxQ01DQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHNwZnZSQXh6WEtrSitGMkpyNFdRSTIzM2ZmWEpkRkI5N1pUcDlLaXNldDRk?=
 =?utf-8?B?SkVzb2R4UjB0VzErS3ZxeFB1eVlsckNCUTM1SkZSQkhla0h3YnVUVW4vQ3RJ?=
 =?utf-8?B?NkNXUlRQMFVXVFhFWHgxVDRKbG9lOXZFRnhmNUlmWDhza2R3M1FaK2x4bmpo?=
 =?utf-8?B?dHVTYUt2NkhEaVFBL0htUStWZ25McGJ4b2s4YXJBUHcyeVNKTlI1ZzVYcGdT?=
 =?utf-8?B?VHBSMGNDd0FndU5lc25ITk9WNnVKRVczT21xVStFY2VaOEl0aHhaZGJyNkN2?=
 =?utf-8?B?VUR4VDFadGxPa09lVFNFdmFqemY2SWMxWW1jNVo3akJtcGtKLzFJUnZHWEk1?=
 =?utf-8?B?SVBOTG9Qc0VGQTI2Yy9tLzJENU55Q2FtVWp5MUYzejAwTko4cEQ3TUFkTTVK?=
 =?utf-8?B?Y1k4eWwzQWJaL0ppOXliNFRFUFVPNExSakhNMzBiVkJObFlqakVMa1hGUHNR?=
 =?utf-8?B?WjA3ZWx1RElFcGFXbHdwUmpYb1RxSUpzZ3NjaG4yOXVlV25rUUZlVjFEZk1O?=
 =?utf-8?B?eFBIYUF0bVlIekhkU3dpR1VlSG1qNVBLS0trM0RLeGg2VWIxL29rQytvenBB?=
 =?utf-8?B?UkxxS2Q4aGowd1o3VmlhYjZIYy8wY1BNOVFVSStFQkVicVZpWm9xOE5TTjdK?=
 =?utf-8?B?cE1ZZWNWRmZYdUpWTngrWWZJaHM2b0VISTRQalhtNmM4T2Y4REpiMlJRSHhK?=
 =?utf-8?B?VHlyQnhtcjZQN1p2cUNEM3dQdXFPWThmUVVjQXAwRm5WSnZ1ejZUWURCaGg1?=
 =?utf-8?B?bVl2YzFla2doZkhOY2JSaXp5WTZFQkJucGRkQUczb0swWUVMOVZ5ZkJxMHZV?=
 =?utf-8?B?UTRDOHVDTGt0L21BSVdXeTUyOFNHdkZURUVwc2Zla0RtWkozVEFhWWdxZEpl?=
 =?utf-8?B?dmhXdytmZUpnVFloeHdaLzdWczI3WDNNY1VoQ2RVeEY3UWxWcDBQdlpzb1B4?=
 =?utf-8?B?RER5a1NhNi9aaDlzQWtwb25sUno5UmR0dkVDeTdjZzJyeHU5NStTMjRMSmM0?=
 =?utf-8?B?OHlHbTNVa1NrZ2xLb240ektGUEh6WU51SFB0ZDQvKzhKMFJEc0tvWmg1V0ZQ?=
 =?utf-8?B?VGhPMllqS3Z1aTFpb3FwVWJZMTBaRUtRZFdvMDVXaEVEUFc3dzVnK1Q1Q1RG?=
 =?utf-8?B?OWRnVXhEQ0tuZGV6M2l4d05KcXFzSFVaNURvdGcwNlhGM1krT3lLdVhlb2VH?=
 =?utf-8?B?bmpxVVZFQVF2eFB3UHpPZG9ldEdlUmtuQ1VCWFJUczM1ZmVpVkpSOHlIMVhK?=
 =?utf-8?B?SVQyaUxyMENVQkIxN2VmL0JRenI0cnYraUN1VjJyTmZwWnkwTWtCblZsWWE0?=
 =?utf-8?B?QllPaVJPSyszR29wZU1EelJiMlM1OHgyeTJ5TVk1QkYrUXR5UDJ6KzNvOEVw?=
 =?utf-8?B?VDVEcTl1VDhreHJHMlZRbTFxM0E0YzBhUzd2eUNEWFJJd3dBN1B6aC93WUhH?=
 =?utf-8?B?SkFjdHpYK3lnSHZWY0NRb1owaGQxdjl5REpHY0R4d2ZrdWQ4eU52TUxNY0pM?=
 =?utf-8?B?OGtNSnhUNUpZK2ZlSy9DdmsyMVQxSm4rU3o4a1NPNkxVdjF4YVU2Z2l1eEkw?=
 =?utf-8?B?OTc5WDJmUmw5L1RWWUQ4SHVJZ29DRmMxa0VDWkxzWDZ6VDNnQTVqaDNkKzhP?=
 =?utf-8?B?a1hCRXI1VU0yMW93b1lXT2JpNDNjbkJiZ1NGcVlYa0lXazNUV1BtaFMreGZJ?=
 =?utf-8?B?dXNyY2xldGY3RksrSVRLY3pJVmV1NFYzZlF1Y04xWjcxeXAvblVQOGdmZXFS?=
 =?utf-8?B?a2ltd3Z2bGpEQk9kZnBYQS8xTzZIUnJvNTlzWFZjZU9YZlBidVFsY2ZLZkZC?=
 =?utf-8?B?cTRjVGpMS28zREFPNHY1VUJVUW40Y2tpTmJhN0JkeUhkUzMwNGxHRklHMzRm?=
 =?utf-8?B?anV4cTM1aEQ0ZGJHU3JVdGpKN3Jvc09OaE1udzNWRkJvOWtJOEtiUHorZ3Aw?=
 =?utf-8?B?aGlsQi93UzBDdi94bUw0Rk1JdXo3NzFIU3pnK3RiUnFEdlNlWVhlcy9VUVNw?=
 =?utf-8?B?UXY0OEZQNkZOUnNDY0oyVE5oWG9QaUkzaDlmWmVVTHhYNk15THRYd1RxVHFS?=
 =?utf-8?B?QUkwUXlrc0pqMzljc1MrcVQvYU15SmJoL0lFZTR5WHh3WG5GSzVwVWR2aUlp?=
 =?utf-8?B?dXludk1idjQ2TzdiUUxlRzJkdWpHQmJLZjdXTWgxK25VOVozeDdzN2JSaWR6?=
 =?utf-8?B?aEY2ODc3R1VDbmlpR25jaFlucG5kQksxZjhJVklabFpZWklNNVdveUt4Rmll?=
 =?utf-8?B?VEpPbFJWUFlIcWRFaGg3VDk0RkV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <414C0B1AC0CBE34F9654C7C5D1FC3B60@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ne8Kcqern8e2nhpHVIs4Du73+8tXjziEYBk4iRqEFjotMH1G6SZuQ6gJrkEkYs+DpgULQP+16RoKGg5ZuO5gmSHsIIx6GCgLUMa8uBED0G5KgMPljonICHJs6sOgE2BrxDLPry9TTwV+aL7Z4iMadLHF+TY3Nmrgx2ooLqDLUucN/gMzZ44c8xjEItwSs0jE+Tkur7TO3YWig+oiLSs7o5TyI0nD8aoyoNZbQJ48ZXzcl9wTHR3efzWXAeLRCfKhSPjRnRNj5ZJvP0rUzYH/n1HwnSeuTfBdKxWCeHf3WCfZdPWosgMfDlsDHNdHWvQlmjoA1XwW62ZAcnwnS6E0oErEup3imFhi9QC4P8eqol5NbKwHqhzEUZkjMq3WlMiJKHoOSCPI2cW+gPhXNepGZ+i76hNQH6PIzu/jBloh93l+JHkAclY6HhX/NOSKqiB0DvxTS8f5Dz3+X1x0yCFVSgWuTR2rTJhFV4MXprvYcaPqqoO0JN5yoYKAhruxTMYmZu8F1Iv6RprHDvm3pkjgeR10nq0yqBad+YozeElPgF9uMF3124V91ZLRdE5Wtoe/Lw3xxLYgPKOaOuctTUIo5z6U4fL4Bs4bHEueYdji229mI0yRujgixOErr3i6hitZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adb817f-32a1-4c51-742e-08dce4585d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 09:38:55.3038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOz4844j6ImdwqhhkHsgZOAitpdvpJ4ToMamjNBlq5qYoBGu6MN4VbV6et4IlvpQiOSeVQXMZ7riQz9RZbt8rWOqLf2a17ClAcyIVPxeeMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8857

T24gMDQuMTAuMjQgMTE6MzEsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC8x
MC80IDE4OjUzLCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4gRnJvbTogSm9oYW5uZXMg
VGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+DQo+PiBDdXJyZXRubHkg
d2UgQlVHX09OKCkgaW4gYnRyZnNfZmluaXNoX29uZV9vcmRlcmVkKCkgaWYgd2UgZmluaXNoaW5n
IGFuDQo+PiBvcmRlcmVkLWV4dGVudCB0aGF0IGlzIGZsYWdnZWQgYXMgTk9DT1csIGJ1dCBpdCdz
IGNoZWNzdW0gbGlzdCBpcyBub24tZW1wdHkuDQo+Pg0KPj4gVGhpcyBpcyBjbGVhcmx5IGEgbG9n
aWMgZXJyb3Igd2hpY2ggd2UgY2FuIHJlY292ZXIgZnJvbSBieSBhYm9ydGluZyB0aGUNCj4+IHRy
YW5zYWN0aW9uLg0KPj4NCj4+IEZvciBkZXZlbG9wZXIgYnVpbGRzIHdoaWNoIGVuYWJsZSBDT05G
SUdfQlRSRlNfQVNTRVJULCBhbHNvIEFTU0VSVCgpIHRoYXQgdGhlDQo+PiBsaXN0IGlzIGVtcHR5
Lg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogRmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPj4gLS0tDQo+PiAgICBmcy9idHJmcy9pbm9kZS5jIHwgNSArKysrLQ0KPj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9mcy9idHJmcy9pbm9kZS5jIGIvZnMvYnRyZnMvaW5vZGUuYw0KPj4gaW5k
ZXggMTAzZWM5MTdjYTlkLi4xOWJhMTAxZGMwOWMgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9p
bm9kZS5jDQo+PiArKysgYi9mcy9idHJmcy9pbm9kZS5jDQo+PiBAQCAtMzA4OCw3ICszMDg4LDEw
IEBAIGludCBidHJmc19maW5pc2hfb25lX29yZGVyZWQoc3RydWN0IGJ0cmZzX29yZGVyZWRfZXh0
ZW50ICpvcmRlcmVkX2V4dGVudCkNCj4+DQo+PiAgICAJaWYgKHRlc3RfYml0KEJUUkZTX09SREVS
RURfTk9DT1csICZvcmRlcmVkX2V4dGVudC0+ZmxhZ3MpKSB7DQo+PiAgICAJCS8qIExvZ2ljIGVy
cm9yICovDQo+PiAtCQlCVUdfT04oIWxpc3RfZW1wdHkoJm9yZGVyZWRfZXh0ZW50LT5saXN0KSk7
DQo+PiArCQlpZiAobGlzdF9lbXB0eSgmb3JkZXJlZF9leHRlbnQtPmxpc3QpKSB7DQo+PiArCQkJ
QVNTRVJUKGxpc3RfZW1wdHkoJm9yZGVyZWRfZXh0ZW50LT5saXN0KSk7DQo+IA0KPiBXaWxsIHRo
ZSBBU1NFUlQoKSByZWFsbHkgZ2V0IHRyaWdnZXJlZD8gV2UganVzdCBjaGVja2VkIHRoZSBzYW1l
DQo+IGxpc3RfZW1wdHkoKSBvbmUgbGluZSBiZWZvcmUuDQo+IA0KPiBJIGd1ZXNzIHlvdSBtZWFu
IEFTU0VSVCghbGlzdF9lbXB0eSgpKSBpbnN0ZWFkPw0KPiANCj4gT3RoZXJ3aXNlIGNoYW5naW5n
IGl0IHRvIEFTU0VSVCgpIGFuZCBidHJmc19hYm9ydF90cmFuc2FjdGlvbigpIGxvb2tzDQo+IGdv
b2QgdG8gbWUuDQoNCg0KT2YgY2F1c2UgeW91J3JlIHJpZ2h0ISBTZWVtcyBsaWtlIEkgbmVlZCBt
b3JlIGNvZmZlZS4NCg==

