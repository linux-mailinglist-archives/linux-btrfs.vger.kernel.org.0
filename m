Return-Path: <linux-btrfs+bounces-20651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C6FD38D79
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jan 2026 10:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 029F73008C84
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jan 2026 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186332FA37;
	Sat, 17 Jan 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bo1xBO0g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="smvxmOIc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC57260D
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Jan 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643221; cv=fail; b=utX1hUMf6fx3FMwIiQxYTU4r4NpJg/Be5ITIoVuNWiJRVIH3h0oavL35a1XVKmMSfpNTMt1nUhrYhXLd8o0J8KzyvW0ettb89IAPe7UHzPNIZjxzBLFRl2YV9JSYF2nmvtd5xdLenDy7WmEFMELb0wHOhCim7EvBr8UAa1PCagw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643221; c=relaxed/simple;
	bh=COqcnhtmfTxyWOscMseZNUV1Mbo2MIGGojWeaQvWQUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSMw3MyL2GLyGt85QWU/SxTmKmj3qJElGojB3BZwPYZ7HVKQv5h+vcR+amtaxa9SvSiG0zuJsbgr9E6m23WXGCsAAYGgml6zCgN+SqT0szfjmlYvn9HMaXefgRUngDmnCuZL9uHocXXmcVt5Ob9gcKyIzKlz17znHGW6I+Mqv28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Bo1xBO0g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=smvxmOIc; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768643219; x=1800179219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=COqcnhtmfTxyWOscMseZNUV1Mbo2MIGGojWeaQvWQUY=;
  b=Bo1xBO0gZsyBPidVnMsICQktA1CN6ujNAovTKYEyDCia4+ShAD0BU/DZ
   Q5igICJrlDvzdtv9PRNTO0quwdbuVfS2EKAqgD9g3XaPD/OYOc4N6JQTW
   wLfeYtq/8ctJibk882uMZ0Vg2JHHrE8iQrRcqXMQZ5XOA58br/s9p4D6S
   kmRr+lBBNyLKZy93ZNzYBT4z3PEDmlSrZYlGNaUyF1LI4HVKa9+c2p3si
   ghZ+6DmPsjgPqn8R30vYd5e3TyQEcAkWj0sEF/BNTn7bmGsXG8KJmShN6
   Uv2HSbVmhHi8hgZQ/PRe812m4fXWQxzFeJHWgWEq8R9RUinEuMCa7UxGz
   w==;
X-CSE-ConnectionGUID: 1as+CpwuTcq11oIw8N6ytw==
X-CSE-MsgGUID: hlnuyEiDTS6N46Bni5QMVA==
X-IronPort-AV: E=Sophos;i="6.21,233,1763395200"; 
   d="scan'208";a="138245633"
Received: from mail-eastus2azon11010026.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.26])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2026 17:46:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmBlhb6sHXkQNBYvc0ldCIeyIE6ckhNpszSSjsSZidOk6cUf4KkK7Q2FDRfiftHlhKcIv06zrHLCG+IHPhIAbEiE4rRLJeQdbFIp/9eYciEgJDWmVZotMsXVDJEe9TAy+M3ko389QO+nES/RHW3mWzcVG+J1fHf/LpCQHmg/iCH3ZoKelNlkgk/VU7zdF7Dkgnzzp9KOBO2rdXtUTOWYW1dv/OtFfRfL0gvjKqPf3dT8dUjR+fLp2PHRrUY7/hPJdVVFhNE5SlAnl+SUkcgsZTTWO5bp+LqoZODccjWnTCBSZKkZGqS39EnFMckZwH6YXdcp0WkeZNCG2vc3bQ+m7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COqcnhtmfTxyWOscMseZNUV1Mbo2MIGGojWeaQvWQUY=;
 b=DNFpvTgZhIz5BWwk9BMmzgV4S3iJ9U4F5WPsInE36s40iU+cdBePUlBnGniPIVhcW/8MmlXA/Ki2YOiRRhhX0aAzbYtJW08/mB1uU4IBjsnJ1Z64He6y4sIWUv7KUDTESvOIxVN27DQyeoUuqIffsMZ9fNC6n+CYxSe1UBUBCMrWa3mNelGW1MHEZjyFWougVrB9hy7zaHJD7NkoUhOnvUWOM410QSubvegzN2hHrV1QFZOdPuYy6LvpF4yUaMImlVLw3L0RsEYMOO9V8fx0kSNRmUr2lD1IjEdjtCQPWnjbjL7lRfjmi5QjX0yk77GBI3VCn53I1u52z7mp9vLdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COqcnhtmfTxyWOscMseZNUV1Mbo2MIGGojWeaQvWQUY=;
 b=smvxmOIcvgPM48umkp8q1yzhsa+22M4nQZCz5Us1NxkU9JjpBecY++0pwQu8iWq8NecR/0tg8if6/DbLdJbsb6nVSrrcmvCXJcQkkyszDOH+1yA6gBY9fQNJ5ZJDeJ0XMl2uImEQlnANA6L99diFFQu/VDkX69lfrndZjxk5TJg=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB7021.namprd04.prod.outlook.com (2603:10b6:208:1e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Sat, 17 Jan
 2026 09:46:49 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Sat, 17 Jan 2026
 09:46:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, David Sterba <dsterba@suse.com>, WenRuo Qu
	<wqu@suse.com>
Subject: Re: [PATCH RFC 0/1] btrfs: don't allocate data off of conventional
 zones
Thread-Topic: [PATCH RFC 0/1] btrfs: don't allocate data off of conventional
 zones
Thread-Index: AQHchs6WdTS/LlRXy0CW/Vom7BYol7VU4mGAgABA1ICAAPuTAA==
Date: Sat, 17 Jan 2026 09:46:49 +0000
Message-ID: <fadec915-cb8c-4b0a-96f6-5b278d5789fc@wdc.com>
References: <20260116095739.44201-1-johannes.thumshirn@wdc.com>
 <20260116145421.GC16842@lst.de>
 <9a37829c-cc94-4d4a-b732-834e1c68cc2c@wdc.com>
In-Reply-To: <9a37829c-cc94-4d4a-b732-834e1c68cc2c@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB7021:EE_
x-ms-office365-filtering-correlation-id: 26535c28-7524-4dea-84be-08de55ad55cd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDM2Vys0L3VNQnRoVHVRNjZTenhFSlpvMGNZanBTUDFrMktjRzR0dlBOZTBF?=
 =?utf-8?B?eldvYW1keWY1cXcybEI2TjFaNTh0RlExbFpRTituQWV6L0dVWVF1YUhNelNw?=
 =?utf-8?B?WjlIb1Zxa1NEdnpYWUt3U0pldmFZdlQwN09jMGtpdnc1V0tmc1BHZ1FuM0ZK?=
 =?utf-8?B?UTZFY3l4QUU3anZtVUVXNytTc001UmpZd3VqQU91SXc0aWdIUVgraU9pblJW?=
 =?utf-8?B?K1NaejI0NXp4ZEpPbGJ0ZkVZK0NRSkxNaFZ4ak9VSHpiRmQ3NzltNjFocXFB?=
 =?utf-8?B?ZjdzcjhaS25ranNZdTZWb2pTQWF2ZXhnU3FHaUlVbk52c2R6TEVQd28yVFFK?=
 =?utf-8?B?Z3pTRWRVYjhIUzk5T3dLeVpHQ3ZESFowdjIvendJd0cxdU8rTzN4MFlDeHFm?=
 =?utf-8?B?WlB2SjlrTEx5d2ZiMGpmeHdQVXk0aWRRQkpqd1V2QUxZekNUSWc0cEdxWHox?=
 =?utf-8?B?WGRNeWVzbk1MYUlOYWZBMU5kS1U4VzEyb2R3VnpTQXM5cUNyQ3MxQytXcElm?=
 =?utf-8?B?ODlUVWlQYk84NmlRdytaaGZabWJFVG45K3VDTXRaUldHRHBPNlRGbmVrQVVx?=
 =?utf-8?B?NXBvNEJ4N0ZYS3ZEVDVPbFlxWjBYMXZhZGhZMTlhL2xRYUZkdDBocWtxL3NB?=
 =?utf-8?B?c2d6Q29QclE0ejZWeHYyeHdmM0hLVFF4M3NZbGR3S1hRZGV5RVV5Z3ovRkxE?=
 =?utf-8?B?VWhtaTRDcXp5dkYzS1BXeUYrN2VScUFoUEJhNmRNVkd6eWpudVZyaU9zNExR?=
 =?utf-8?B?czl6bVVTRXQ3ZUdidVRzamVNR204dFpUbzNGOVdiWkJHWUpyQjd5dEZSUWxS?=
 =?utf-8?B?bkxaMi9nR3g3c2o5b3RhT3B0MC9jekR3WFY4cmVTSWZoanNGQ2JGSHFoOUht?=
 =?utf-8?B?bkFEbzFwbGIySnhYRHdzY2s0a0RYWlNnT0xVQkpyQndkb1BRSWZBdURrVDEz?=
 =?utf-8?B?ekcxZXFjWmpENmpCL21pSW9CQzJFWVFIU3BKaERyd20vejRzZy9LdnI3bzlT?=
 =?utf-8?B?eUc5MGd5bGhXc0Mzekp5c21HTCtRa0h2ZjJrNk5xdzRqeGlQN281YmRBQW0z?=
 =?utf-8?B?TThjWXVwNjd2M1l1eW9wc25oTTliK2dQSG8rYVNxZlNlc1VFUTVvRkdSMFpQ?=
 =?utf-8?B?THBHUFlrM1BlUkVCQkYvZmpGaVN6NGVLK3V4MGI3akpqUm9qN0FkVEVpQWV3?=
 =?utf-8?B?MDZvcG5EUWUyWnNLV0lvQU9WdktKRUZrSUczeTU2TTJueGhKeHBnQ2l6ZGxF?=
 =?utf-8?B?TXZPdko0RjIrT0xOVUFEbzRiTGZ2YzlNeXhHc1BFRTVkLzkzbUFmcEhpcFh4?=
 =?utf-8?B?SDhrZUpxeVAxdnpITjVqUjRWQ0Z5T3V4THErMkVsa3FXT2xZYnhtQUFKa2ww?=
 =?utf-8?B?WGIxcFdWQ0FqWXpQUjg3UUF4TXhxSEhHeG9SeWFkdHN2bjZDeWorY3ZQeVF5?=
 =?utf-8?B?TGFSall5WUxoWk5BU2xZY3JBZDUrdEwvZXRxWkF0SHVLWXNtMXduOG9FcTBW?=
 =?utf-8?B?dUVJamljd2d0RysrQkNRWVplS2IraVF1TXgrdEZkWlNIQ0FLUHpNd1FOb0w5?=
 =?utf-8?B?bVVJTTVLVmVKWXNacWt1UWxvektTZVRuSVFqOFNZM1R6eTltazg1Znk5SGI2?=
 =?utf-8?B?RkZ1T1VOTm1Wam4wdks0T1ZmWjJJY1Q2V1o1amhTQTN6ZERqOGJZMmJsbHVP?=
 =?utf-8?B?TWI4QWwvaFR6ZE5mNHdqQUxxanYyd3FPeDB0SnRDQWZ1djdMVllYSXV2NkVO?=
 =?utf-8?B?Q1MrMVMvVEJiNTlJUXJqaEQ2a2F5RXZaL1hLVjBtK09NMmNFOG5SKzBrVFky?=
 =?utf-8?B?VytqTWU0bXl4RkJSeWFOc05mSU5ja21oVDlZWmxrMXVwMC9weE8xMnc3eDB2?=
 =?utf-8?B?cXBIeUtGV3FoWVBVUFNXK1FKTWMzYjFZWWpHb1lUTjlGY1Y2R2ZIU3llNlM4?=
 =?utf-8?B?QklhYVFpVWs4enhabU1zRnVZQ1FLeHVsT1N2OHh2QnEvVnBUazJGbGs4aGpQ?=
 =?utf-8?B?RkFXV3E1N05PSDk0REozWXU0WTRRK3dQTHIwNnAwTWM1b0lXVHlRT1V5ZElo?=
 =?utf-8?B?UFNJdGxzNm1EeHlwNXhSTGkvaXFJbjhVWjNmcEcxODMxOWVrM3VCMUhaZHRV?=
 =?utf-8?B?aldCMml1Qk9TZTdoV3dpTVVYTEo1Z2RJNm1qZ1F6dng1MlpUaVFTMUFYMmZH?=
 =?utf-8?Q?eUoTsMm4u7AsNRD0+ECuJT0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UU5iY2NURFFUZ1ZDNElJRUoyNFpJTEtqS2dvQjdKLzUwRTNXbTlQWDZLaTdI?=
 =?utf-8?B?bWpLOFVOWm5uVVBQV0w4Ni9WRUtXZHAranFRWXNtN0g3ZUd2S20zZFU0alZy?=
 =?utf-8?B?UytPTUhBRHVhWWJRYUtXM0RUczVCa3RBNHljQjlLd09RV2YvOUpvMC9ZbzVD?=
 =?utf-8?B?ZURLbjZJbFpwMW5SSTJpcDJ5OS94Y2NqT2c4ZU9XZmt2MjNxekgweE82MFE5?=
 =?utf-8?B?RWJUdkpISTdIQnpSczFUeWxmdjcwbXV5SlpiMEE3QUYzcUo0amVhNnJEdGlq?=
 =?utf-8?B?ZlZSNndPaE5lcE0xbnV4RFc5YnIxSkYycU9wZWR0SCtLeWhYdjJhK1RqYmoy?=
 =?utf-8?B?Ui9DTzNWa1FvS0ZQcDYzVEZnTHhhbnpHbWcxWkJIQnRFTGoxVG9Zcyt0ZWpR?=
 =?utf-8?B?QTR3NkVRNVBpdWlCRU1yQ3F4SjFrVXRaTzlsK1hueXppdmwwOW9BRzhWVys5?=
 =?utf-8?B?dGdjSENJaDFrTU9IN2dyMC9MVjJRSXFoTUl5SWtIM0c1VTJSN2luNW1wQ0pk?=
 =?utf-8?B?VklmL1R5dUt6YmMrc3FqZ2JlSHQvZzZnVUdKUzZiVFpGMWtrZTZQMXBVYWVO?=
 =?utf-8?B?RGllZ2UvZnU3SU01bUhWS29QUjIwUXBXZ1pYc0QwTVF5TGE3Wm1STWt0eVZT?=
 =?utf-8?B?Y2ZXQ2ZlNWx2RGNHTFlPcUZYY2NEajJCc2JFeEM3MUM3b3o0RmtRUng5dlpY?=
 =?utf-8?B?UkYvRVZaZnJoR0Nvem9CQXNkRW0zQmpXaTg0akF5YytUNEpPeThPQ0JUMjlU?=
 =?utf-8?B?aDVTYk12cWpBeFp1VTlvL21yaG1TWTcwbTNmTEVxVnJtd09hd28wS3pQckxY?=
 =?utf-8?B?YmVnckJlUUxCMjdWdmR6d09nK3JFNUdqMWVNWXhpTjdsM3lXTzdqMGtEbzdH?=
 =?utf-8?B?QnlVdjZUQWc5ZnpqT0d5WTFkaUlQVTJERkdkTmxGQzJIUUdSMmZFY0tJZ2Vy?=
 =?utf-8?B?UEI4MzdCWDZBNnR0djdDWTE5R2pWYW96QmdnM1FSa051L2dSMjRTUGcvSVda?=
 =?utf-8?B?Ynl2L21NTEs3YkdDNVhWUjhjQytHQ3dNRTVJQ3BQWE5hay9IeUJJeEdiVGlC?=
 =?utf-8?B?UDZHZU4wQXNScmlmY2VISXJ6eFREVkRucmsyYmp2YWcwZnp5SkNjNkk0Mytj?=
 =?utf-8?B?NFZBNzV2WEtDZ3NJQWlTb3pkckhSaERYMVJVOGM3dTJRSktHTVB4THNEVitm?=
 =?utf-8?B?L1ZoQVJjWjVXclVCazB6bUhCKys2UnRFL2RVdFpTWXFMdE1uZ2RIVmxkTzdp?=
 =?utf-8?B?NUZLVk5nbnJWdGpEeTdqdUVJWWZURWdiS082MFRjVjFxLzZxQmlyKytkS2I2?=
 =?utf-8?B?TldmanFYZ2I3U1BTM3ZRaXJwYW9adFoxU1pvMVhEVWZtbzZzZGN0ZTdBMkFU?=
 =?utf-8?B?ZE81cEN4c3FMSk8wSU9JNkxWVWFDYTlCYzdNYTcyOFB0bTM5NzJsQlhXWno3?=
 =?utf-8?B?UVhEOWpVQUJPTnRwSGpZRkp5bWpiU3VqMDUybHhHTzNFbFcvR1VTRmduZzVT?=
 =?utf-8?B?ekxtdFNTSS9nK2F3SGR4VEYvb2Q5Y1p3dm1lWnJiWE5mNnNrOFlDLzdaMVll?=
 =?utf-8?B?UVRSa0lRRFZPekFKS0NqYkloWnZMemY5dVBMc1JTSi90NTRqV08zQllMdTlH?=
 =?utf-8?B?L0tBQWJERDNnTmNlQmpjbXp5cVM5RGZLblVGbDlSMWJESThqaHE0T1I3UTZQ?=
 =?utf-8?B?aERXeTRpbytWWnplbDk4bnhGRmN0NHY2cjZ2MGQ3RmswZmdLMWl5YTlIR1J4?=
 =?utf-8?B?TVFOSmlhWnNjMHpNU1FEd3JhM0FIaStqQWdvU3JlUTFUZFJTTy9VNUhkQjdU?=
 =?utf-8?B?MWlWdDc2NjFrSVBiK0dHYlFHQUJWVjd5SkdJdXNPeFpRSWQxM1BUeHZWcHE5?=
 =?utf-8?B?RDR3VlVUYk1nZ2lYMytHeElZSlQzWHZhWk5nL2xuWHNGR3llRGxKNWxLMkQ3?=
 =?utf-8?B?UVR0Yi9wT2VqQ0xGbGluUytrTkRmQWxibUxQMGhXQjRLNXZNYUtiL3d6YkR2?=
 =?utf-8?B?VEwrMjBBbWFCLzA2MlpKQlcrS2V4ekIzL0FiSWpqWmN0Y1Rwa3F6eFlNcXhD?=
 =?utf-8?B?QXl4NEdvMkVmVm5xMGhJUnU0WEYxK21qdEcyeitpeGhsRkRPYnhWaVNXejlU?=
 =?utf-8?B?TVNiYXpjM1JqZ201SlVzYTJaMDhnaXQ1ZXZTcXkzMmo2WjNIc3hMblRNNGF3?=
 =?utf-8?B?WlVEVmNoUC9JOEJjVjAxR0Y5RkJOYzRpOVVQWXgyOWZBVCs0RzJvTkVscUtJ?=
 =?utf-8?B?RitUZTdwa0pRREE1V0hnZ3RLUEZRditYZmxDS1c0UDh4NU5qQ3RHUThsZkkx?=
 =?utf-8?B?aVp6UHIrWUZJOXpvVGdYWGVjc1dmc3VaZlRqR3NHL3JrRVlkN2JxbktrY21N?=
 =?utf-8?Q?EyJRLmPrWihhVyilFzbU7z1FZPdRCJIvo15AkxfJmLPCh?=
x-ms-exchange-antispam-messagedata-1: gtti0DbbKs0XqqzFL2fno+z4mMGxsL2nHHU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC929A7DDA425E438B4AC84A4C64F128@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NaGuuBeNKfM1MtPvva36Tr+qx0cbDA/Le2NwhA/BsNZ4dkTPGQI6hxFnkDque+498SpgfI2RhOn6JoqroTdrfmtEDgOuGyxqPGt0Kg2a79bYxUEybnD2z7Fe/4tyc40ohRuMXX5OZnQVJbZqsRLrDejYZM0HVCzwI4Ixsr8Kz3lofaqwtoWWKkj1e6BMRLYR1B0ZMXzvqEmP8olDF+C/yJ5cBt7WJQw5baXJm1PJR7sLbI9OeehJTV038HftZYPfjqkbSuOPYGjHQ4nma43HpzngAEDOq4LQWIF0vKaIpvjwkHM5pjj+s+wLPGF2Y7QLvSqNvtV6GJhp2PRyPZVen2qiMHTZo5AL/JLXNAjpQkbxqFipUyCTVrQroO3EKYE/cmzuaFK/kdkHzSWF6gD69AMSbT06cmuQTXpB6WyeYbkb5jdiNpQQY/X6HDmtJJQa3A7SVA8i6muqnxjVTbyrYvqpHaUv5WD7vh9jGxjbzaOo2YScAJ4I/+BDsJpkMiNTWGkTjEHwIXTlAdyCP8TCGVbluhAf5/A9d2QMvLl1Z/kgta1eRCjH3hzAzhmZ9e/K8TRaMxQAWiQ68iHa5ko3OBk4yahPA07+SIdj1+Y6BhpT1jhJU8IZzy8K1cpBEi/w
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26535c28-7524-4dea-84be-08de55ad55cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2026 09:46:49.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyKsqpuMi4w8bbdk3gI3WJVHuK1HDzWMDCVXyXmwKGxNmt5/wmcOWTxP6xKyBDqfcvdwevfyu8va1GD9VHqnELvzDbwW9wIVpKJke8ATJvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7021

T24gMS8xNi8yNiA3OjQ2IFBNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IE9uIDEvMTYv
MjYgMzo1NCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBPbiBGcmksIEphbiAxNiwg
MjAyNiBhdCAxMDo1NzozNkFNICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+Pj4g
T24gYSB6b25lZCBmaWxlc3lzdGVtIGFsbG9jYXRlIGRhdGEgYmxvY2stZ3JvdXBzIG9ubHkgb2Zm
IG9mIHRoZQ0KPj4+IHNlcXVlbnRpYWwgem9uZXMgb2YgYSBkZXZpY2UuDQo+Pj4NCj4+PiBEb2lu
ZyBzbyB3aWxsIGZyZWUgdXAgdGhlIGNvbnZlbnRpb25hbCB6b25lcyBmb3IgdGhlIHN5c3RlbSBh
bmQgbWV0YWRhdGENCj4+PiBibG9jay1ncm91cHMsIGV2ZW50dWFsbHkgcmVtb3ZpbmcgdGhlIG5l
ZWQgZm9yIHVzaW5nIHRoZSB6b25lZCBhbGxvY2F0b3INCj4+PiBhbmQgYWxsIGl0J3MgcmVxdWly
ZWQgaW5mcmFzdHJ1Y3R1cmUsIHRoYXQgbmVlZHMgdG8gYmUgZW11bGF0ZWQsIGZvcg0KPj4+IGNv
bnZlbnRpb25hbCB6b25lcy4NCj4+Pg0KPj4+IFRPRE86IElmIHRoZSBkZXZpY2UgZG9lcyBub3Qg
aGF2ZSBhbnkgc2VxdWVudGlhbCB6b25lcyBsZWZ0LCBidXQNCj4+PiBjb252ZW50aW9uYWwsIGFs
bG9jYXRlIHRoZSBkYXRhIGJsb2NrLWdyb3VwIGZyb20gdGhlIGNvbnZlbnRpb25hbCB6b25lLA0K
Pj4+IG9yIGp1c3QgRU5PU1BDPw0KPj4gSG93IGxpa2VseSBpcyB0aGF0PyAgR2l2ZW4gdGhhdCBh
bW91bnQgb2YgbWV0YWRhdGEgYnRyZnMgaGFzIEknZCBiZQ0KPj4gbW9yZSB3b3JyaWVkIGFib3V0
IHRoZSBpbnZlcnNlOiBydW5uaW5nIG91dCBvZiBjb252ZW50aW9uYWwgem9uZXMgZm9yDQo+PiBt
ZXRhZGF0YS4gIERpZCB5b3Ugb3IgYW55b25lIGRvIGEgcm91Z2ggY2FsY3VsYXRpb24gb2YgaG93
IG11Y2gNCj4+IG1ldGFkYXRhIHlvdSBuZWVkIHJlbGF0aXZlIHRvIHRoZSBkYXRhIGZvciB2YXJp
b3VzIHNjZW5hcmlvcyAoc21hbGwNCj4+IGZpbGVzLCBsYXJnZSBmaWxlcywgbG90cyBvZiBzbmFw
c2hvdHMsIGV0Yyk/DQo+IFllcyBJIGRpZCBoYXZlIHRoZSBpbnZlcnNlIG9mIHRoaXMgcGF0Y2hz
ZXQgYXMgd2VsbCwgYnV0IEkgdGhpbmsgd2UNCj4gc2hvdWxkIHN0aWxsIGJlIGFibGUgdG8gYWxs
b2NhdGUgbWV0YWRhdGEgb24gc2VxdWVudGlhbCB6b25lcy4gV2hpY2ggaXMNCj4gbmVlZGVkIGZv
ciBaTlMgc3VwcG9ydCBhbnl3YXlzLg0KPg0KPj4gS2VlcGluZyB0aGUgcG9vbHMgZW50aXJlbHkg
c2VwYXJhdGUgaXMgb2YgY291cnNlIG11Y2ggZWFzaWVyLCBidXQgaXQNCj4+IGhhcyB0byB3b3Jr
IG91dCwgYW5kIGhhdmluZyBhbGxvd2VkIHRvIGNvbWJpbmVkIHRoZW0gYmVmb3JlIG1pZ2h0DQo+
PiBoYXZlIHNldCBleHBlY3RhdGlvbnMgYXMgd2VsbCB1bmZvcnR1bmF0ZWx5Lg0KPiBUaGUgbWFp
biBpbnRlbnRpb24gYmVoaW5kIHRoaXMgaXMsIHRoYXQgd2UgY2FuIGhhbmRsZSBtZXRhZGF0YSBs
aWtlDQo+IG1ldGFkYXRhIG9uIHJlZ3VsYXIgbm9uIHpvbmVkIGRldmljZXMsIGluY2x1ZGluZyB0
aGUgYWJpbGl0eSB0bw0KPiBvdmVyd3JpdGUgaXQuIEJ1dCBhZ3JlZWQgSSdkIG5lZWQgdG8gbWVh
c3VyZSBob3cgbXVjaCBzcGFjZSB3ZSBzYXZlIHRoaXMNCj4gd2F5LiBUaGUgc2Vjb25kIG1vdGl2
YXRpb24gaXMgdGhhdCB3ZSBjYW4gcmVtb3ZlIHRoZSBmYWtpbmcgb2YNCj4gc2VxdWVudGlhbCB6
b25lcyBvbiBjb252ZW50aW9uYWwgem9uZXMsIGFrYSB0aGUgd3JpdGUgcG9pbnRlciBlbXVsYXRp
b24NCj4gZXRjLi4NCk9uZSB0aGluZyB3ZSBjb3VsZCBkbyBoZXJlIChhbmQgaXQgc2hvdWxkbid0
IGJlIGVhc3kgYXMgd2VsbCkgaXMsIA0KKnByZWZlciogc2VxdWVudGlhbCB6b25lcyBmb3IgZGF0
YSBhbmQgY29udmVudGlvbmFsIHpvbmVzIGZvciBtZXRhZGF0YS4gDQpGb3Igc2VxdWVudGlhbCB6
b25lcyB3ZSBhbHJlYWR5IGhhdmUgYSBiaXRtYXAsIGZvciBjb252ZW50aW9uYWwgd2UgY2FuIA0K
dHJpdmlhbGx5IGNyZWF0ZSBvbmUgYW5kIHRoZW4gYXMgbG9uZyBhcyB0aGVyZSdzIHN0aWxsIGF2
YWlsYWJsZSB6b25lcyANCmluIGVhY2ggb2YgdGhlbSBkaXN0cmlidXRlIHRoZSBkYXRhIHRoYXQg
d2F5Lg0K

