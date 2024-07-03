Return-Path: <linux-btrfs+bounces-6173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 406CD9264DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 17:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBF8B23FB1
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11B17CA1D;
	Wed,  3 Jul 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nxe77RmI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qaM9peNi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2113A86D
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020752; cv=fail; b=TG8gHUr/tt+j3ctpJc3Yz7cTaZZNG2ytdW7ZadVle0euNlzhme3zvYgSiHX8vNmwBMYmu5dOSmyV7X1BeuOv/OqViSsQeZVrCgeoyQRXtRZTWWiSCeaokULEQLzw2h5CIo7g5UgyafLrhvEXDtKrACS4RFc+DZVgBAUD+8PK6QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020752; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jpHGeBrBSErW2Ui3txAs23zj+Zjp2x5AIXWLFn9Pm2VHuqp6Qdn7REJOzR/1FQm3KTffJhtH9AEhSapkbW2do0oAaWmu5RXNCagU/spzznW2T5Y9jEe1pliO15MCmLFuqtOnIvqDPNS6YBvmgNzwkeCLgbobHTr1FRu6UsRPuk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nxe77RmI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qaM9peNi; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720020750; x=1751556750;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=nxe77RmILCmH7xg8Z6wqSy/CHRMmuLZQd3SQ8PdIiNf4f9SJjtHZGQlF
   GVclceqrJd/lZR/G8foMwo+OgVVXgNCAzMkg7gvphycPYBw78/z+zeJZM
   cgsSdi899RP0uYO88+1EPd70dBh7Izm2X66x0MoZbwRtZpgbDzmxptcvS
   lYT3UdqQojFTVxhkxRW/MdotI/hB8NkBVG6K5QP80xYngp/0ssvbAu8b0
   yl0c8hOjMj0Fp7tTQ9Wqo2AXVozID1IqEsuaciUBc/G0vMkqYe7W3OTPG
   wNKozjm7+K7CVZYsfScGjzwBiGgIUlUE8K6HpN5Y7PSNBHuBpHchfqSvV
   w==;
X-CSE-ConnectionGUID: GIaLPan/Qg6bmmG1U26A8g==
X-CSE-MsgGUID: fgOVMz/NRj6pxAjWl1nlmQ==
X-IronPort-AV: E=Sophos;i="6.09,182,1716220800"; 
   d="scan'208";a="20824009"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 23:32:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM3auPiVlxcmW7URByzyqjV3np4ULxjTI52ae4vyeBIBtYSHJySfAA+RxU82ebdDz5NWitUtA7NuOfjPgOsYTVNgySVXcBIqo3VfqfoFsQVWPPtT+cC2PUndBRBk2oGyduUpGa2XuNqmXzEB02GqnjZ64SmlT1lTcDa2B/R+VSKhlX6zLScgmYJKqbn2ha88lUasXN2Db7pNjYzBnCwsbiLD0DgAHB8ZHRkm4L55BXN1ZF5QjHZ8sWXBxLQFmgLn+gPiB9jQ5bmr2qPxyv+RnhGFSOP4PgrGbcVfveFSH84wl9Ae4LC1W1t8P57WV/0eKZTyuHrpE1U5xm0pW6CKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fwPcrDoC8/bkU0pQUXcl8/YZeiaBSteEXnIPvIcV2H3zLj+FdIiTfGueDgI9rbDztc6S6aiVJPNBrfdQWeG8UIyQPH3O2+9OkN4+Blh+xHDI713OBson76qKxykcFEP+hxOdDteaSL6YM7cgw1nl7ucEV9fcSXdIn73SA9G81Jt8mnTD1jVxUu22/ZoCEDIuDOrqLjePPFW/9uTcpTEiYVWDrNNk9olrZrx2+Yeq/ii6ZF6tWkLZVH34VWNBcX4xMoccKswvu/KiWMlYxmwIyyvs5VIQsv+La8lWf8WhFkHRJL5iYzN/XygjpX4QThO5/92bwGoAo69iHhxO7HaBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=qaM9peNi4ZP6yO50fpGMycDuu/5NuEeR4XSYfxPXQqgjs+8ot5qhli7zzlum2Kz+uXFrXLfOjp2ZCAXK+bvejq/6pYY28VE8AGdDc664m5FgT5kOT0MVmvjOw2fO7R0m2nMJ9AQrmiiAuG2L7dS6ohIGrItIDfBbP6TwcV5mOH0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8189.namprd04.prod.outlook.com (2603:10b6:408:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 15:32:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 15:32:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix bitmap leak when loading free space cache on
 duplicate entry
Thread-Topic: [PATCH] btrfs: fix bitmap leak when loading free space cache on
 duplicate entry
Thread-Index: AQHazVfAf9uE67iQPkuaA40cl9qM+LHlIaiA
Date: Wed, 3 Jul 2024 15:32:11 +0000
Message-ID: <1800c642-e0f1-4574-8c9c-4de77f3a56de@wdc.com>
References:
 <548b562c2432cbc591b50fad1ea24ae87dd50627.1720017904.git.fdmanana@suse.com>
In-Reply-To:
 <548b562c2432cbc591b50fad1ea24ae87dd50627.1720017904.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8189:EE_
x-ms-office365-filtering-correlation-id: 0843e8cc-62ea-4e4b-3a9b-08dc9b754eca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTJqUExxcFVLWnlUTTZIY3BBaldMSk5hWmJkUExYV3d5L2lYUTQvOUZodHlW?=
 =?utf-8?B?cmRQajJRemQrS1RBVkVBUm1MSDdVMVFkM1lQaFVUNEMrZWFibWtpMjQyT2Ju?=
 =?utf-8?B?QjJDdXJPNkdHbGZ1SVZnNGNmcXVraGNEdFFZZzlCTFNxUUowR0xLUnhxOTRX?=
 =?utf-8?B?UjZ4VWVtZXVMTS91VHdZWlNCaWRCaHErUGxXb1hmTmlhM2MxTTJmNHAvWHJC?=
 =?utf-8?B?YnhtRU01K1NCd1JjRWNjUzJyM3dCVHZXelRvc2VvVHhRSDBva2liYk5oWVRG?=
 =?utf-8?B?aERSTW81ZG9iaTNxYjVHZ0N5dG1KRnpOOVlwRkxobUJxbjI4ZGx1aHFGL052?=
 =?utf-8?B?R0JSRXVMc0VadXdXNGxhWkVac0VYdnZ4ekFaL002T1lWVWlIZ0JzUkx6QzFX?=
 =?utf-8?B?ZmFqTzlHaE1zQkpVNEZWVXMxbUJvd3hTOU1DL0dzc2F5UDErL0xkMkhlWXpP?=
 =?utf-8?B?c1V3aGtJN3lIc2pIem9Cd3ZPa1lFeFQ3WkFFcGN1dFZvN2pndW02blJHS3ZF?=
 =?utf-8?B?S2RYbUlWNVJPK25SYjE4TVdHT05BMk1ic2ZHWEU5ZEpPbTJPRGxGL2dpYWV2?=
 =?utf-8?B?a0NZRVNTZmtWMFZ0eUg3WkdkcDAxd1NWM0QzRVdrWDZiVVpnZWdQK1VsZzF2?=
 =?utf-8?B?UC9ULzRiakhvWktBcVVNVFBEZzczQnNEOWpNVWNCT20rbzB3bDRUUGo2Tm5I?=
 =?utf-8?B?Vks2cjg0U0xQYjRBUVprVldxa0FJTlVxdVBMcndlellySkNzK3YzbW5zYjZk?=
 =?utf-8?B?eGJvQmVPY1ljWTdaS3lWQlBZQ29CZW9STWg1a1kyUkFsYzFCa2xVSUd6VTFO?=
 =?utf-8?B?QlNyaU5GdHI0MUF0cGNzcnZJQ2J1UjAwcThCc1FEZWNJZUcyL1VwVGU3SERW?=
 =?utf-8?B?M1FKQlVlUzJwcGlnbnlTMXNReWd1RGJ0c0oxeXd6WnBMVHFvZW1Vak1McnBC?=
 =?utf-8?B?TTFqSHJ5NWlvU2hpL3pOUnZZV2kwY3NUQXdJZmhsNUMvTzNEVCs0MngwM0NW?=
 =?utf-8?B?TWRkb2NpaGlLcURsR2U1cm5Ca0tMRUhKUEpRKzBISUd6c0FyYjQ1cnpXZU5L?=
 =?utf-8?B?Sm1NV0lycWR0NkRBNTc5QnNYVmJ4VGhMekFtWGk1SThHUmZFYk9LcFNuaElu?=
 =?utf-8?B?dnp5b3FZM2xnR0hsMkRzbGJsMDlTcGFLUkJpT2R5VDZWc3N4clNtVkZZcVRh?=
 =?utf-8?B?TWtCbjlhMGQ3RU9jL29OZmhVL3ZUdUc2aTRHbjZNWUdiQ1pJb09GZDdQVThV?=
 =?utf-8?B?d0RCWE51L2JDMkpXbEFtMzhocFhzY2ozTVg1WWRYN3N4RFdaRUdvc0h1MURN?=
 =?utf-8?B?RjZ2YVBEMG40TjFKQWl0d2dUUU9id09JL2lOaWxId2FoQnNISnA2K0hmUHZy?=
 =?utf-8?B?OGNDR09tMFgwNE9mM3NEM2E2T0ZzU1ZYSEYveTNRZzZXRy9YNlkwcWNiUGh3?=
 =?utf-8?B?MnFrbUxiaUJIcVRMYmdrb3F6QzhYVjZLVkErcHNmQmJmSlJEeWxsRWNHNzZJ?=
 =?utf-8?B?WE42cWVNVmFIZ25hQnVOMk9iZmhJTlBZLzYrTXJySjc0TktUZDAzSTVHZDU2?=
 =?utf-8?B?cmRDcWdTRmdmYXZ2YWlOSlc5MU1BZWNqcGFldURTMmRiZkllL2hDejdVMTkx?=
 =?utf-8?B?N1V2QnV4aGFoZXE0N0lQWFJ4MkdPR3ZpdG9xa1FJbWlaNXpIcXlZN3lsZUs0?=
 =?utf-8?B?c0hIMmt2TlY3Q3VVSUZiYkR1QVA3SXVudURuVitmaXI2ejdTTG5yN25sa09I?=
 =?utf-8?B?K25JQ1daUCtLTE1sbUtSVHVWVUhtWDZRTVZEdFBsdkFGQmRBc0xJeUxyVHBO?=
 =?utf-8?B?OWhrdG5kZTlRa1BQb0hnR1JQRUs5N0w4YnkzNHJqekRHeVJua0JKWjlWcGNz?=
 =?utf-8?B?M2xMYUI4TVNkKzUxNmlKZENUMWhwQ3ZSTDAyRmFIYzlEWVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFlTOWN3ZzRFTVZaT1drL1dvOGZaZytJQ0F2eTdjRGhMUG1tdGZwdHBpTEMw?=
 =?utf-8?B?SHBRWUMzWk5mdC9DNDYvNCtRV2VkU0Q5a2NZQ1ZaNllMSEx6Y1dJNEllbnBU?=
 =?utf-8?B?RVBzL3UzK2xsbjdhbHRZcEU4eDFLQnpNbXc5MHEvbi9MNzFwVkJ4RkhTUXNM?=
 =?utf-8?B?S1d2bm8rOE9pODBwWTc3UGNYR3psU2RUYnhVWDg5b3VVN054YWRrd0ZCS1hQ?=
 =?utf-8?B?OFhadzNDVjdXRTlrOHZHVVVicVdkL3lBakNiaGRVVnVUVXE3YlpUc2ZJNmZX?=
 =?utf-8?B?MDJTQ1ROcERvNlcyQWJ3NTNPQSt6eU5uYVpuT0F4bHI3WWZ4WTRqYkRrTzN0?=
 =?utf-8?B?RlhET1doTEFWVFlkUHNPNmxHbHBqaFFRZ2lHazJDWTF5WmZJL2hKR2t5b25B?=
 =?utf-8?B?LzV1cWlVRFlrLy9MTE9NN0FtNWdNMjF6Qit3d0tBUG5LdGhFamwwRmluTWVD?=
 =?utf-8?B?elRaMGJwZE1nMTRVT1RBNWJkZTByRTVDaXlWaXNMOEJlVkpuOVRTc0NtbHJn?=
 =?utf-8?B?NGN6UksrMVdhMEozelU0U1hkR3N6eXJ3aG02QTF0OFVHbWdieXRMdTUvTmxj?=
 =?utf-8?B?YXlOT0hFZjRsNzZvSkpyUlc4SUMwNXpsazZ4MURFOWRKazdVbU9ZWnQ4WXZz?=
 =?utf-8?B?RXVZejFaeGJsMDRic2Nlbm5Gbm9vUXRJQ0kyQTh5MTZ3WU1WRENkeW84TEpz?=
 =?utf-8?B?Sndkc0hLT2RqV3E4Sy9mdVhFbjFrcFJjTjdhSVBRYnVzSHY0YUozUnVHZmVE?=
 =?utf-8?B?NUpMb3Y4SDV4R3YyWWtqYnpweVY0V1dQT05zVFVjNWxwRmdTRlc5T3JmU2c4?=
 =?utf-8?B?SGROOEtzSUkwcW9rdDFlWmRyMHBtQ1Q1SzJLMDBFTWpZb0VuU3ZNVkNrMVJ3?=
 =?utf-8?B?LytnUy9XOFFUQzlWdzF4MERWQnNFL0tIUFpIYUljTlhQUGJmTFhERmgyQkxO?=
 =?utf-8?B?NHM3eW9GVE5DdWlncVc1cE9WMUV5d0dQNGJ6aFVQNDFSWUNZeEpQRVBUU1Ir?=
 =?utf-8?B?c3RrTDhHK2lIZllnbXRwM3F6R3FvdkdtMjlJYlJpY0hCQWh2OXpJcTdhNTZD?=
 =?utf-8?B?WXBUWmxhc2lpZnNITWdEa3NycG96L1p3ZTNXRy9SZ0d4RzBVMURCOGxsTU1H?=
 =?utf-8?B?SFF6a2VGZlhWTzErUlcxNW5zRkZIQXlueG1yZ2IrQWZnWEQxZkFsZmd6Q25P?=
 =?utf-8?B?Qm1yTkNTQldFVGl1eFArcVAyQThMc1hUeHJMS3dzTFVnTDE4THFSNFVnVzdF?=
 =?utf-8?B?ZGZOMmE4U0hVOFpxcGhSZ09Ranc1VkduTEdhakZXblBvSFBPQkVLNUV5R3U4?=
 =?utf-8?B?SmJ3LzQxUkt5cHlXTDBqN085UEdDUVdpa1hQMWNBaVlFajh3dy8vQ1FQczBi?=
 =?utf-8?B?aWRxTlIveDVPL3lDU2V4WTl1ck1iMWJXZU4xK2hFeGxSOVgwVDhXckFWR2lU?=
 =?utf-8?B?NFplbmhEV1NObmtTNnM1L2kzQTErcjlYeE5nT1Z4OFh4TlNoSkRCeEl1VHd3?=
 =?utf-8?B?UCtDRUx1TGFsNGZTTGFVSHF2c1F1R21pMTNaMXpFLzJBaTcvRlkvVVVZY2Ns?=
 =?utf-8?B?czhqditSR1hNVmRLcWpnOXFxMWlvaUhjV1cyeVJTRHphMHh2bjZkV1g4M1N5?=
 =?utf-8?B?VDEyREN5YVg5R003Rm0vTWJZQXVXS0krY2ZmNnhUMHMxY2pRYnJOWkdtbHlY?=
 =?utf-8?B?N3ROczN5WTE0U0s0dFVPMExBeE5ETmlUM3hXK1R6emZaV2lid1pCbmpjSnZl?=
 =?utf-8?B?RWxXSnF6YlN3RmFmUy85cnNLZlZlT2hsU0l2U0s3Y0xvc09RZW54QkhXV3kv?=
 =?utf-8?B?ZGJLQlBjeVlYSm5FSUdpM0kzQ3E1MUxzZWc5akJHWTdyL1gxTXJHNE9peTBC?=
 =?utf-8?B?dGVWVGpWVXNPNVl0dTZsYTFUdDROWGplWVdzVzQzNFNOSzByL0RlK1VYZ1Ix?=
 =?utf-8?B?aHJtZTJiZEhvcDZGRWZ4S1Z4TUhhT2EvcjBZVThpQ25XRmJYU2pwU3ZQbEt6?=
 =?utf-8?B?UUhSNUxYVWRNSTF2bVBqakxOZGJ4Y3Y3VDJTbHN0M3pGZHJaUjhlbmdrZGYr?=
 =?utf-8?B?YzZVZVFST0daM1FUWW1ZbjBGM3paN3dXS1F3K2VLejZlb28wRnpaekNIOVJv?=
 =?utf-8?B?QzRiLzFFQ05nNStyZTZzdjhMQTdhMk5MdDRhTStoMUdELzRFMkk3SzJpV0V4?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0228ECC23276D4DAA88CCF533E481E0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CrEwMlw4CiFQV50+8/g6q1eSJpV4pKl36jd6Sb+sjpA6PLyga7Q8O0t/MpRBtMnQr2tkiQ8cVoqz8gjUMD8Vtdij1Coho/7S2sjt1Zpl3ofOHlHIqxYbqTMmyiYSMsN4Jb6dEquV1PWscCefDo+R9uCYj1XI+44Y/517wvzmrmg0hvCU6sAT1pccBvJiHKHi0bj7a4r6dVzX9N2q+hGu2ILbC5CXjzvesWt0Rn3uUz4gk3zpiapDm6rf2nvl9GNguM5zGuYU79iGYheftHe0IL+XLHJEvFJ42B1Kt4suL58Cimmpyaa7550yRFzpFDVaZb5LSCHt7ULB2bWXAo9wBY2nJGQwbZWshiM5t57Kht7jEgKXgDDeIgko9wpwTi4PA45UFM5XI/P5k7b7fJGrKGTtTGjW+aGmRGc+Yj3cMoBVj4Pb7SATbrwJ+Xq90Y2Vuq9rQiZ6GDS9Vjz6RQ7Oa9l7iR+PI8L0/jCPv2dzyi3TTb517KbwpT0+GHDsn9G5GE7KruDVMHqxRLtWR6NW8RJFlAgINJveoRheNF9zeE6PrCKjGArLijZjMv71UoCaXZZyPYWtTql0AZcdhj6iRiR1bITuuuOA3i+48gSBqvZsDevLSGR1jtxvgmP6xvrX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0843e8cc-62ea-4e4b-3a9b-08dc9b754eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 15:32:11.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxyJ3xF78fhWZSeRxiT/oEfb3BYAD4H37VJz/MGrrd2Bnzu9JymsZJvD2OOJ28hrAKZCbG22rPKT7DHgWt8HIytZfKNMpWKaujz+HOabRBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8189

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

