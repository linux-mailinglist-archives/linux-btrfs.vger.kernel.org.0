Return-Path: <linux-btrfs+bounces-20631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBECD3059C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 12:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D41E1301D32A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B636C5BA;
	Fri, 16 Jan 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nvKVXGG/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P0VtuAu7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38136166C
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562740; cv=fail; b=fOHX1BxhTkHnNNArmHKcphKjqe07EIOZUmhK7C94DcamXAvJuAAmZw39VaSaZ1PF5ikP1aBvgqhjwiAKhCX3NaPxy46DZE0hPUxsGItD4tCax9oR5kZaJ3CugscwxY1fuIXev4t5pCDiokIW6/ypaD+/vjaU+S4/r/A1wGyaiAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562740; c=relaxed/simple;
	bh=mDZDQYMhAQAvutOGJN9dShSf9YjC2A0M1FKauf4lMPg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gs6jDJmXsgebKlMbY7Mk0ESjQNwJF45cyTtIYPlBVn/6EjH2WOMeHOUcu4bXAvPI4lZTfruVR3FdoZhR/jBbQuqHhbl7pepYG91l1hq8QQCmkv01lW9shm+z7nWTQ2d4SwGrlNELFu7Kr0uAJb1zAF4EYDDYLIJblZ7fSA2qg1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nvKVXGG/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P0VtuAu7; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768562737; x=1800098737;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mDZDQYMhAQAvutOGJN9dShSf9YjC2A0M1FKauf4lMPg=;
  b=nvKVXGG/juU2QnQHSVPaMIG81TZ3HIjOzNIuMDHdAM81DF+Czh+O9lFT
   9bpnOPANZY8L3FXNV72bOMbvlgoaZ8zuHu9vEmNsD4NB9XCCJwTiwuKPP
   NbGdoggmqxVeVfR9/q1IoHziFKgf04U4M1ABQqSkHZhVd/YlkVAUHj8qa
   uv1/9WHQMdcPaR3naLOgSWnN+cDjSZNCVnscAfwQMI1ZcOrr4FnNbcoy6
   H9SRencaNSaSu+jGzzw8buvtDu9fQGKdOHa9RX25+QnEC2A78Bty9eahN
   pxf4nMpMYDbqRtenRKDhDS4fxV90hOPoUm41s/yINq7EER0mX0fi9WBz+
   A==;
X-CSE-ConnectionGUID: urCXlS/EQwG++N4CaK5WKA==
X-CSE-MsgGUID: vlp+lvaETWq0nG7B+mbUwA==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="138197328"
Received: from mail-eastusazon11011006.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 19:25:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCbe/8uh0+5EcGF46NqaQn9BuEX4WX1LAsMFW3vkFdf8qwj6AfC7oT9nN1LI2GvFX08MnYK2HaxhUNH6nAmcNC6Mma2YmE0ApeEccszwz7Cge1WwTAkAY7nEBI+/nZqsw38tFOqY2VoysjWx1aJsWU2REv5PzMsH17+H43eLjOhP3zSgs+MVZPDQGJCMeNez2AC9IZk9nRqIpEgAkaFTUQBT+RZhpx7BeQSiv1jZiQ3YRqH6ZKnM1Ruf4axqFVOpweeUIHnPqQCDu1KiouhDRuGFtIjkYrZr9FQ/sxGA6nRKPHdH3mkedClXImcBxspPSkgnobHLvG6tZvq1CFYDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDZDQYMhAQAvutOGJN9dShSf9YjC2A0M1FKauf4lMPg=;
 b=k+D3dWOxKo619C8Fd+sWRIO62X71DLpIcYpeQfFmQhSy85Roo1zEZWx75mBidVQ7d8K9aVOnLnbKj3azjbHCqBrCE1BBjWdw2UCYiKOc3EEd5nJ4S37So0XDqnyrOIAzKMqyuhTXy8W+CEad8frj7sAYnj107O5AwOi00LFhXmbCBwk+fPmmnOxA6evkhTWcDJbJA4toMbbiU0z5qeT1rhVQ7BBOQvABnSA7utZOZeQD3vRtKHUDQZ2Sos/MttqND4sYfC7kvWpANWdGxE7eK31fzCctBrfI1sUMMx+pbIbx4QvUtRtfCuuZMY2qlqFjflBJy9JeeY943vVPMUmFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDZDQYMhAQAvutOGJN9dShSf9YjC2A0M1FKauf4lMPg=;
 b=P0VtuAu7zhlnWmPAaDUfn/qkreEEgfJ7cLabQLs0u6Ws0cJhn8dzIjpeD07C0zhArCwEEVsILPNqVNogHdulV0/inYx6tZtv9/7SO/Oe5UHiEkChW3dHytDfDXCFYn9Gehd8dJEpHNOEE1/b5+TXNqCsuWDNPBEojxTXPL3jRR0=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ2PR04MB9009.namprd04.prod.outlook.com (2603:10b6:a03:558::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Fri, 16 Jan
 2026 11:25:30 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Fri, 16 Jan 2026
 11:25:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use the btrfs_extent_map_end() helper everywhere
Thread-Topic: [PATCH] btrfs: use the btrfs_extent_map_end() helper everywhere
Thread-Index: AQHchtgFEBKcnQQVtEaVwD0b5icjBLVUp/KA
Date: Fri, 16 Jan 2026 11:25:30 +0000
Message-ID: <d5688380-78ce-457e-b5ac-f174dbc3b401@wdc.com>
References:
 <69ddaceff63e94c5c1b94f12c52a83a798a9f037.1768561288.git.fdmanana@suse.com>
In-Reply-To:
 <69ddaceff63e94c5c1b94f12c52a83a798a9f037.1768561288.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ2PR04MB9009:EE_
x-ms-office365-filtering-correlation-id: e16478ca-88ed-4c46-6064-08de54f1f4ac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDlzNk5qak56WXR6WnIybGlxMmlQRndpVUxJYlBiZjNKb3JvdXRNakhTT1p5?=
 =?utf-8?B?OWh4czRtWU5wQjJNVmI0Zksrc0VwUnZ0RjdXUEJEMEt0UWUxa0xtMFpOQU9r?=
 =?utf-8?B?bm5aSFd4ak80Y0NXeEU3OXIxVDZZMnhLbXZJSjJKWkgxdWpXbnQ5cXhTaTQx?=
 =?utf-8?B?VGV5WG9LUXFhRWJJcFR4VnBqdXQ1V1lLRlpmOTltMVc5bGF4VEp1SVdIenFv?=
 =?utf-8?B?Q1lPVytUdVc1cmtsZit4ZTBZbVhKQUJmSkptcWpBVHQySGpPc241SlFndlBw?=
 =?utf-8?B?TFZUNWxPaW9wWjRBRFVrN1h2VEp6aHZLOHAxRHVIZnRHTVhrNUhzYWhCb09C?=
 =?utf-8?B?YnhvYis5T3FQa05wRmpyQVhRc3pWdHpZMmVuWEViZnVmMzd3eTVnckVsOVdU?=
 =?utf-8?B?Q2kzdy9sWUVWazcrZVBteXVwdS9LLzZOY2NKSVZkTmcwbTRDTVV3VlF0NGRP?=
 =?utf-8?B?WWhEeXFWeTNVZ3NzWVR6aTlFcDk1R1M5TTdaSlVoYXYrNWIzMkc2SEg1SjFs?=
 =?utf-8?B?eGE0Wk43ZUZna0pTSGN1ck8rdnBoNmsxOGt0YTdFaDhSS0daekhTbzI1WXkz?=
 =?utf-8?B?RjZSVzRVU2hsV1Jzb3BBOEU5VmhYWDZTWVpOb3JVNTlNOXlNNVQ1UVU3czZo?=
 =?utf-8?B?b2F1RGx1djJadHY2Z0Y2V2tWSUhiNjJ0VEpCc3MyYkVoQVNxKzZwZm4rSXo4?=
 =?utf-8?B?SE9sZ21sY0daOTVnQkxEZkdrQkpvcnU3M0dVMnAxQXhScG45Si9HbUhFdG1J?=
 =?utf-8?B?dlJRSlRndDE2ZE1WQ1ZQR1p2TktVZlRINW9nOUlwUnhDZ29LaUdJWGRoYWxB?=
 =?utf-8?B?ajg2dVBLQVltcXNuVXdVSEk5QStiU2VTYXo0RHVtQi81dUJ3SEdrZk5NTUxq?=
 =?utf-8?B?cmRKT2JBZ29KQVpKcUxWSGRpV2E1bEc4WmNiQmxIN2tCSW54OUpleHV4RjNk?=
 =?utf-8?B?ZTNtblRzQVVIZzhHWVUxeVpiWGE2YmVQMW5YSkZoTmZCTmdTMVpPYmFuYnVy?=
 =?utf-8?B?aHE5b2xyV0tuczIrTG5JdEZTUTFEQUd1eGpQMVRiM0VQWlBPOHNyTUI4TmNu?=
 =?utf-8?B?TWdwQ0dNREcySDl0THFGNEVGR3dtOVBSVUdTMDlEeWt2UitwZm42Q21UU1Qr?=
 =?utf-8?B?eDdOVm16NHpYTFlYS2tiOVIxV0ZlYlJwUHg1V1dpS3A1dFI5NHRyNmFtVjlZ?=
 =?utf-8?B?OVhVOUQ3MGNZUk1PM01ELzZEbFEzQmswK0lSb1R0b2h5RFI2SStzMHIvNUVK?=
 =?utf-8?B?QU1UNEtQTWdUWVVTWW1ncU9ZU1gvdUZ2OVQ5bEZWZ2d3bmYzWHd1MldxM2lG?=
 =?utf-8?B?My93RitsN2FLTkhiK2hTbU5tcW9iNGFIWlhBNG0ybmxHMTk2eGpLdjBKZU03?=
 =?utf-8?B?cGhRbG1ZVVNHYUJBM1psS3Vidm12cW9FRWMzSmdGZllwRnRiOTBxa2pySlc2?=
 =?utf-8?B?akFvNDNpOEh5OTc3YXh5TE9aWTVNaWVVUzZpNEpSQ2lVM2NDaTJMMytDU01i?=
 =?utf-8?B?T0thUFE0aWUybGcwTlVZelVlVXVtR2lwczV1dnZaMWpDQmtKWElZZk5mam9F?=
 =?utf-8?B?U3ZWdzlZYkxBaURZVmNhY0FqQWoxU3hSYkk3UGhmQ254WXh1TDZPR1dJcjh4?=
 =?utf-8?B?M3phckxpWDlYM3plbUxKbHk2N1BLU1JsekZkSG9rUHdCcURuQ0FrRS9MMTFB?=
 =?utf-8?B?NUg2UzRCU2c2NnM0MjYzS0dvZ2dqQW45cDdrdGVmVGtUL0NvRXBCSk5nQ01D?=
 =?utf-8?B?VFhTVmZMNFdiNnYydUNEdVdMZ0F0cW0rZDVvVzZERFNKbUtReDlFZ3U0bXFV?=
 =?utf-8?B?Y1FjZjBmUFBIUW9LWkRjOXY2R0x5RWh6MXNvVlpuYUdkODVwRXRIVWwxZW4y?=
 =?utf-8?B?NmdXY0FVRWx5WVcxMUtQS09zTTUvcTNqRVNnQlk4bHU1TzVxNWRhYkdlZVI2?=
 =?utf-8?B?ZmRoNVd4bSs0TUVBaDlDRkN6OEE3NWFHKzNkNXZva3RZZmdGTktGcTM5V1Jl?=
 =?utf-8?B?RlRiUjVOaUVtbGNnb0NLSHkvL3ZFbHhVMnNSNU9vWTV3bXBwTWM2UWhIU3ZN?=
 =?utf-8?B?QVZTSDk1WnEwbno4RUR6NCtHT0lhaVRGS0k3MU9UNExRTjVkMll5cmdSY0x5?=
 =?utf-8?B?OW9JTGtTS1h4KzJrWHFMRnUrS3VUT1VGVXlDWmdVZk9BS2lZWG1LeURkNWxk?=
 =?utf-8?Q?2gpbJTDlJoQOk2dUu1KhM0w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blcraWV4MWl3aXE0OUJtWi9SdW81eU1MbzVmZ09mZzJudG1Yek9INEorb1VQ?=
 =?utf-8?B?NjdCS2RWN1NEVVdrOEZmd0gxQWhIVnpBSXRuV2U4Skx5bi9BalhnSmxrc0dr?=
 =?utf-8?B?bmpkTkdoWlhuMzdzNHBPZTRKTUtoK3gwcGpvRVVMN0tlYkRHZ3VDOSs5N2lI?=
 =?utf-8?B?aVVDMUdWVDY1dCttM3R0cHE2VkdRLzdJdGxVWStMZ2dUU2phTDF5UWcvQzU1?=
 =?utf-8?B?NEdNRkN2VlR1U1NxMHBQdHVGbEZBYkVzTHNNbDZMcEg4eGQ1YTZtRUhRK05V?=
 =?utf-8?B?cUVib0hETG9nWEhTaUs5akhrZFdvVmJEVkxTUi9hdjU4UUhIWmNLNGx5SXdJ?=
 =?utf-8?B?Wlg2ZnJpai9TWmxNMXVDeDlQellUY21IN3pFckJFOWV2YzRoL1hRS2hUTXVa?=
 =?utf-8?B?NG1tT3VvaGhiRWhlMi9NVWtrM1hEbW9kaW5VZWlQK1lPelpLNFkvYVE2bUEw?=
 =?utf-8?B?Vm05UDRjQ2szK1phWlhTRWRxcVgwUUFvODRJZnh2Y0JsYTJiWmJObmQ5WlFR?=
 =?utf-8?B?Tk5POXlpU0VDSTFoTVlvM2FkcnBGZ2FJTCtySTZvYTN6dEVva3VmME9rYWcy?=
 =?utf-8?B?UHJ0YkNVaUN4T1c3djNPVStrWWxVR0tPQ0o4Rm9VOXRtN0tzc09aamJ3U0Fo?=
 =?utf-8?B?MEFwY0FZTEowaHJSTzcwempIbFpINHo2MHZEZm9YRUdKRGpBS3kvb1VWTVBN?=
 =?utf-8?B?cWNOTG5aM3p3MU52T0FrdjlhSFJkUW1kSm5hcEwrL29KbDBzNVBrY0RMeUZx?=
 =?utf-8?B?Z0lRa0ZLbmVjRU90MDM4MGtUMzJuOFdkOTlxeWttbVVXeEx6bmFwQ21Qck16?=
 =?utf-8?B?YmtwOCtOSmpzcVpPMWxtWndreDIrSlJ4Ykw4MWtKRlR1Qm9Ud3k4NWdEdWNw?=
 =?utf-8?B?TDd4WnNUTVlRV24zZWFWcnpod3JXQVJBMnZFZ0pPUmx5bWpycjBSaEFTSmdL?=
 =?utf-8?B?dlRsUjhvU1hUWVJ4VFIxUlNMSnA1Yk5SSytVS3pGTnNXNWhtL2o0cUJCRXd6?=
 =?utf-8?B?WXMyenZaQUpDdFlWS01qVm1lRnZNUnhRQlNORkp5bzNJcG84dm9hN1d5R3F0?=
 =?utf-8?B?aEMzbEJ4cmNma2tORHEwVVAxNGduTnllWUphejlJL1ZVVUFCWlNiRnJzVDdn?=
 =?utf-8?B?RlIzK2Z5UzZsYTFZeUZXWWFuUEgwQmg1dVFZL1o3WDJBaE0xL0tTaE5mWUp2?=
 =?utf-8?B?dGx5cHhVWGdFYWpIa3ZTaDJCWDVBU3NZczE0Vm9CRS9ydXY2VWV0UmYyNnF5?=
 =?utf-8?B?Uy9YNjBhcm9QdUk1ZTUxOGpCVW5HcDF4S3c0N2plZU1tUXlXcGt2Y2lvMlBt?=
 =?utf-8?B?YVY2dk1nNDh0S3RNL2lEUEhwRmppSXY0aC92bzNJK1pLOWUxYWNCeFFjeG5t?=
 =?utf-8?B?U3FhdFlKVTRCbHlMTzRyWHk4ZzlQbm5iR0pvTk02czVVK01ONWJsZHlZcjFu?=
 =?utf-8?B?UlVZK0xtaE1ZVEE2clNjckEwYVYzNHo2dFF5OFRNcEhicTVCak1YcEc3K3Ux?=
 =?utf-8?B?ckdMSlZzR1Q1dEtyaTJldUFWbXdrbFUraEZMVHVFNnZaYjlQbUhzVThQYkxU?=
 =?utf-8?B?clZVR24vQjN6S0hGQXpaV3puT3hJWlNpWXAyNDVWS2hCWDVtMUo2SGhYQUdy?=
 =?utf-8?B?a2VUaFhhV0phdmVzRU10TTJ5amNMYS9xWlpKczJYS295YzNlRlVERGhvZVp5?=
 =?utf-8?B?WkVkWkZyblRaWXNZN1FXS2V5Z0hyQktjQ3RlcjcrajlKR0dFYVRicmVxT3Fw?=
 =?utf-8?B?V2MvRWVVQWQyT1VWNTJEMkNkM2UxVlJmSmx2WXQ0RUVJVlBQY2NiMnRnQkVl?=
 =?utf-8?B?R2NvM1ZPNWFSa1hVWHpsR1RRV1IyVVp5eFhma0NpQjN0YlFWUzQyY1ZIMWk5?=
 =?utf-8?B?TGtkc28wa3VyVGZGaEphblVxUHB5ZVdRdVA1WUtUK2s0anpnSzJlM1lybDlh?=
 =?utf-8?B?alo3UG96UVlDMkJBdTFSY3hXRUhaSHhMTkZMT2t5bE5qOHNHeHY5a3lvaDN2?=
 =?utf-8?B?VVo5dVV0K2o4aDRmMFV4MWJMREU5ejIyanF6MTR6dDdBV1Bad0FsZHdLelcw?=
 =?utf-8?B?OTJNbnpScHlValBlK2ZiV0VmRjJQd2RJcm1xZ2NUUnB1c3NMMUgyQ29HVzNL?=
 =?utf-8?B?OUNYNkR4TTM2ZmYyeFNJSkNyU3QrQmt2cWF5TGRrWHNlWlMyTFVhNHI2WGF6?=
 =?utf-8?B?V1d0UG1ncWVLdURHa1M2bzc1eFpMZzYycC9sQ0tGamNlN2Y1QWxvdHBJN1I4?=
 =?utf-8?B?RWhQcjc2UGJXNHpGSVVNaVI5OStWT0pNQTJCQXpYZmFJT3pRQklNSFFGNmtz?=
 =?utf-8?B?Qyt2cW1lalgzMzduYVdFakI5RG96Mkx4N25WdDlOZVpRV0ZEQ3RYR1UyY3lM?=
 =?utf-8?Q?NabfuxxmlGZeaeNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B72F1895610FD4CAC9B60E7FEB2794D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w+hm5AVwDkpvUGilbjjQ6IhM1CTKZ/cZ5dHSSMSCsu5PlEw5KHL/CdEa0hr8GX75+Wqq5I65jJNmf/Vxrg56M2fs+ks0gxVAXvg0vbIaQejf0U3BnlH6htgbqeNBXcVT2cekMFl3UZwpVgIrR0FHBaR2OAzSkBCgD/RsgRHhxjociAoos8LQ6E3D4kXQaafNLGV9FRvn5/9ERvugV7IgvSjeNDaQrxw8bC4wiXAmTuD8v3UuNA4v6UZ8ixD6sNCHc+FHsUYDkEsBvj7AJR7tyBkNyaB2hVIBty6Y7tJYdNTdUlN34TytI8CHOoerjkDz0jrgaKl1BqvSOUGoLKsXbOli4SmuZ4RtbeDT3oomBFlj1xp4fk5H54ttE0n6o1C8JAF2rF2bVtHsQ9TmRD5HEsuSIIBXnbBGskWRu38gA/CdeKH2bXEgGo8aJ/elqnxEiYIIz1a6O45oc8RXT1qCo6ow2dWYs5wfnaY65p6yrNH4hlV2KdgCXtlR1YA2ISw13MLB5rBIGCIKzf62y88YUdr9YXD8i0uNVT0vEaeJz9yKoawEf0M6R4lObWUvUO959K8/8RWGMkWRnYq8hpqurB28g6GSjpe3WhKCFZCHx2w9lrQcE5Y6NxMAm9GhEQf7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16478ca-88ed-4c46-6064-08de54f1f4ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 11:25:30.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cIBxUTjKkVg5sYQFmV7ylz8BWmRKdh2fg0YzTx+VFi1ODGjYMfnpxmNjpJljq0HHIc7LMSqZpzU4Jf3w0fK//iRBZVuAQE14AMNz81Bh74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB9009

T2ggbmljZSBvbmUsIHdhc24ndCBhd2FyZSBvZiB0aGUgaGVscGVyIDopDQoNClJldmlld2VkLWJ5
OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQo=

