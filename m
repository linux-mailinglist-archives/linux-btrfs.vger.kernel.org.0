Return-Path: <linux-btrfs+bounces-8160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0B97E6C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 09:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A871A1F21B30
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99B649649;
	Mon, 23 Sep 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JQk18Qmx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hmf6IzgC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6608EAF6;
	Mon, 23 Sep 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077268; cv=fail; b=UcCdTxT2og+Di2/L3hKwWePCZGR3NdPFreFM/7Kt5yRhkpwdGxT5dYsdtGghfvviHza89aJiMZZ5ouGeol7wDOs+B96eF924IIGP8Vvb6Af5r/vVIvu+BeMttS7Jp1FnKQ+Ds+4oarZfBy6BdWIXbgGfshLR3YBgdcez6hQ2xD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077268; c=relaxed/simple;
	bh=+52sw1UstluTb/8PIjNZah/v0F617F+6KlVk72IesGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdHMA+CAcDnBd2l49J8/5ZUo81muPvfIGAfLE0UhNNdoLMCHikMGznJoM5x1VJM/JB/x6W7UjFAcqlwwfzL2kEAxgUkx/b4WvwUPEKLwGcwwrThq8NY5/pMkBsb8XVARGjfGtIG3TqD8HFHQ6mpsqte9UHjY+7z20C0g5SASub4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JQk18Qmx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hmf6IzgC; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727077266; x=1758613266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+52sw1UstluTb/8PIjNZah/v0F617F+6KlVk72IesGw=;
  b=JQk18QmxqFSNsDmDsQyx0X3PmIV+YzjcscDFnOJGSHqFkjBrc+sqSS7u
   eNu0AeZSSNqUO9U6f4mVrWvg1oIeDBmd2w1LCTpQOG5FXVlpe25y2CM6A
   5vZtfSC/Ebwe9+7O6KUNQ9ybFdjDkFxU5cM8w41SByg9h/1LovPiZdEC7
   m04UcHyngbtb1ZVXiDRnd0kUsPhqyqT00QbG4bnvw5QqOVXsklqg8ZufX
   6QZywALgWOBr4eeQRcw4yVz/Ab6sjMs8qk7kCwbJvL9XVIw2Ad1a2JSzr
   YDfKm+Z71yJF9wIz1csA4JZ8jAc8TTKbX6QJjpcssnXjFiDTOkmJOeyoQ
   g==;
X-CSE-ConnectionGUID: G1wTeXgtSb+EGCdSP0unjQ==
X-CSE-MsgGUID: kZSyqDeLRiCxU/32LMFG3g==
X-IronPort-AV: E=Sophos;i="6.10,250,1719849600"; 
   d="scan'208";a="28320615"
Received: from mail-eastusazlp17010007.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.7])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2024 15:40:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sf2g8plZpBwHAcioYuhrs6fIEGfCPUgooe1t1YNMVtFdQiP4dD+/B9Zx/PkEbGr3aKsHTRBdDI/hfDCjtwoYn/UCdfC9dLAgJpFU/RWZVZ1eMsMzvOcR5KoLBcCJekOLIB6bfQYG5kVezcTyiCjVYWKnfiEDfwpO4a2c4d3fzZwEE6sGvYXHa0rWBjDAYHhjhGMh51kmITyFAUXELn7I8adf90eF0f2j3UzJCyA0zxJqzri5GJ8X8n0N4cDGJFEjrHJ8nbE9cUTtLNMjUESPYXl8xkVxOK4UrJbWwiCHllOkNJvFxIJuZr2h7xtna9P2fDl6tUKvJEZ9S5/ogi1nLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+52sw1UstluTb/8PIjNZah/v0F617F+6KlVk72IesGw=;
 b=tWc/NliRNwqwmh/T7QUScYTo+zDWEE5el3VH6SxdIhNtnYlh442Iz3iDcWGvkju1N4r517upMO5uqdy+xJ736jR70VnsDQ7TIHEOuj0SfK6BvKhPGhkLqlUcyuFKEweSvBaXoVAPk691WA8r5sL+zoeL7yJ7f/PjkpsNLoXWR6vxMFX6boUsVDnH8J+ChIbxiXoqkX1i9PjHj45YxFicDoiaGFkZ0aJc9D8zd6WXztqa/c32ealYAdKYSyR8ng2cYNFZK3fgXh8H1fov2wV69h2G4W/uoaZo8MofcTaphIbZRs9Nrgq4qsUBInLNK5gO8sIZ1fMPAUMXjNRqfQBaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+52sw1UstluTb/8PIjNZah/v0F617F+6KlVk72IesGw=;
 b=hmf6IzgCE4Htb3x+H5ClO3M/U+OKbCCs8hNkcKHy2pZQrnmIEqxPTA2zvGPewT1VbAsmh0NWJe1OM0rkTkkuylJnO+YPaAOBUExnSdRUql+iYwPi96ZmGxGcqDuU/9EZyKqqLTNCXVFlL5BTpMZ4f2Y99WpgjXAHz/sNpQvQVf4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7594.namprd04.prod.outlook.com (2603:10b6:806:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 07:40:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 07:40:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
Thread-Topic: [PATCH] btrfs: also add stripe entries for NOCOW writes
Thread-Index: AQHbDYRHbR6Y52Md7kCz87BUoKnMl7Jk+VwAgAADdAA=
Date: Mon, 23 Sep 2024 07:40:56 +0000
Message-ID: <3c0c8517-a642-4e7b-bbcd-ef0022c49c3f@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
In-Reply-To: <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7594:EE_
x-ms-office365-filtering-correlation-id: 2e900e0d-75b1-4db6-0767-08dcdba30fae
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXJHVEczdVBrK2Q3Ui96NGdoOTFHd0QrSHRuZTJFTWUvWVEyVlBUL3Q5azFq?=
 =?utf-8?B?WTBPU1VqWEVFYjRScm5UeDREWDU0UHVUTU9HaGVVclRxWTVidUlkQjJmYjJz?=
 =?utf-8?B?dDFaY0hUR0UvV2NMcmdNRVMrNjc2NjhHbmpSMFBhRGR4elF2QWVDa21yUGNi?=
 =?utf-8?B?aXlXR0x3N3ZEK0N0RFpCRmpnckwxS09FbWVmSTBpTE9ZV1l5NXRPSzBRL3FO?=
 =?utf-8?B?MXB2REo2UVZjaFpYUUsvdFFDaXMxY205WExZeTdZRXJ6WENUUUQ0VXo5VXVU?=
 =?utf-8?B?MURuaWRRNDRrNUF4SHZwRG1vMS9PZFFwa0xvZnJaK3lZbHBLUkJ3Y29lR0U2?=
 =?utf-8?B?VDNwOHQ3RUpxSlFkT2tteUplaThRRU5jSmQvbEc5Tys1UXM3T2dobVRuMnV2?=
 =?utf-8?B?aEpYSHVxaWttaFg5dzJ0V0llSHVvbHBFa3QxcnZ3M0ptQWpaekx2dWRlbFVt?=
 =?utf-8?B?akpmSExRcng3blE4MUR2LzNxNlBQSldlVjVQNGZMZE93T3RYeWs0TkVyMjQ0?=
 =?utf-8?B?L2tmVm54Vmx0NmRTSlZpZmNoUzRTdEhYQXZuUUN4c1Y5ZUQ3cDFaNWNob2x0?=
 =?utf-8?B?dVpScEdpeFNZWkpVeWd6dzFnUU9YYzZsbkUzTG10N3A3dGtGOFV2WVBBaUF6?=
 =?utf-8?B?L0VzS0hDVlJIOUlaTGh5Wjg3QXRWZmJDK3FHTkNUVHJIcndVbVVyTlZPZkJi?=
 =?utf-8?B?em0wdDhDd2NndTNTVkVERTB0WUU1cVljcnVNT0ZJRXRtVUczUTQvRUxtOWhO?=
 =?utf-8?B?ZjBPQjAxRTRVak5rUzU3TDhITHl6b2t5VHc5a1ZwWVp4aE1HODBLNStEOElx?=
 =?utf-8?B?cGpYa2pISk5GZ0taYjVnaTFpNEhaOW5abFY5cW40Nmh4WjlBUDhqWkMxRUE4?=
 =?utf-8?B?KzF3WlVDMmhDdlN5TzNscXpsdzdBQjBINWllZnA0T0t6ejY0M0pwWWFOWmZ6?=
 =?utf-8?B?NXZiV2xrNUFWdk4vWWd1SHpVSjhPcjZCVGtsSmVzcHR6QTRjMFFiNE04MDVG?=
 =?utf-8?B?VUxJeGd1YVM3QkhLazhWc0k2SWFrNVlzbzR6U3ZSZ2xaTnJJNnovdGgzSUdi?=
 =?utf-8?B?eWdDS0RRUG9JQXJvcGxCVkk2cGliT2VoZ21mTnUvdFI5eHlNUnZycjRqZkdG?=
 =?utf-8?B?Z2FhU2pyK3U0TDIwOTNEN20wNGxYMHJqaWloNVZwU0NnSTcwRVU5T1RramVm?=
 =?utf-8?B?cUo2eWd3bXNaTEdWNExNNnUvTlN4ZHJ2SHNXREl5ZGVrTDV2UWxlZXVxWCt2?=
 =?utf-8?B?SzlkcXZJTTVXdUp4dWNqMUJiT3M0MjZKQkFBYXZWM3BIbmp3K1p5RzdLVXZG?=
 =?utf-8?B?WVplejgxeHBycWRpdE03OVBOdXlybjJGbWRjTVp3UkppWWg5SWNscFIvazhi?=
 =?utf-8?B?eXJ5NzMzOFFxSW0rUjF4aWUvUDMwbVlwaUJ5eUhqaXQvMmVqN3dqNGNGR0Jk?=
 =?utf-8?B?bm10NW1rU2gvYUp0RkdSeENnakNlNzdUUTQ2ei80MjBvWENrUzVBNTR6RktQ?=
 =?utf-8?B?M2F1VHNlNjd0N3pPa0xGemo4VmVINnZlTGlHUmRyS3Vod1NteUlwRGlLekYz?=
 =?utf-8?B?ejFFeW9kTi9QZHVnSXJPeG5KKzNISlpiWmZ2NWRLZEVzYmcxUCtVK0grN2Rp?=
 =?utf-8?B?Mlo5bWJFc0tmeE1KN041emdxcFpKa09rR2hBQ2dvZEV3YmM5U0hNVW82RytD?=
 =?utf-8?B?cEtuU1NKelZzWE8vaUJLSjNaZ1VGU2o5amJuci9ZcUc3NWZ4K05BaENtNHV5?=
 =?utf-8?B?S1R4K09EdVZIdThFVUtEcWxNR3RraWd5aE5XTXgrOEV5V3JmMmRhc2MyL0Nn?=
 =?utf-8?B?VkdEbk53MjNUeTFod3cwaDRxa3YraUJMUUtrYTZUcWtwbXZITUZvZnpXR1NV?=
 =?utf-8?B?U3BwaTBYY013QktOR3JQSFIveWVWVmpHMHJDdmh2L0pIaEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTJuTXBNclpJcXNkWHpSSUlWZFVwODV2NnhCZFJyczZoZDB6SUZoVFhjQndD?=
 =?utf-8?B?MGZFVS9wVmcxbG9RbE9PNnlJU3hUZmE0WjNaT0s0SnBUbVg0MkFiYitGRHhD?=
 =?utf-8?B?YUlubVNzeGYzZHVwa054amV5YjdOTEtYQ01uOExmT3FYWVN3WEQzZGg1aWdL?=
 =?utf-8?B?akZzRCtJWFA0b3FmeitvUitxTCtKVG1ZWHp3RnN4bDUvYy9IU2JpczA5WGY5?=
 =?utf-8?B?d1o5TnJrYmJLcG9veTd0WEFzdHQ0RlJxL2xoaCt6cHJGTVpxK1BMSEF2QWdy?=
 =?utf-8?B?RGpqMHc0R2ZwbmJQUk5qY3hpY0t5czU3K0pmZDMwY0dWaEZFVnVKbUdLQkNM?=
 =?utf-8?B?MlpoV3gwVHBGZzhMclBYNklyRHFUU2hsdEUxNFJRWTczeGFGM0oyWlVqWHM2?=
 =?utf-8?B?SWgzT1U5eDRLcktERnhMUTVHSWQyZ2xzcEtqSlU3djk1OWIxYUpqRUtEWkhy?=
 =?utf-8?B?NGlMZkVKMUpkaWNtREJDZ0Fib04vVVl2S25XQjFlOHVXdzJVb1pMYjZBZnlt?=
 =?utf-8?B?ZXJ5Y3JPbUlXSFdHTzdmZWpWNW4yemo2NmtuK3RoK0o5bGtuN21CdEdqdlUw?=
 =?utf-8?B?bGhVNDkrblR0YU1jaUNKUVErN0t2Zm9tRkphTzNxanJ4KythQnozTlc2eVI4?=
 =?utf-8?B?QXd6WC9aajFUMDZ2N3d4dElCWUFCQ29MRWVvZHZMd0FKdklCbnVveTNVMzc0?=
 =?utf-8?B?NzRrYW5mVjNuUjFMWCtuck1uU2ExVTJVWFVVRHhxaW12bytJUTRLS1VhbUdC?=
 =?utf-8?B?aWx0ZU1vMkU2eFBEMSs4K3NCdFBRMXQ5b3ptRmg0UnVyNUFXMUxXYzNLb2dK?=
 =?utf-8?B?azk5d3pTS1ZxKzZjY0ViMlZNWVZuNnVoU01CME5JdnBUa01DNE55UmR6WkhH?=
 =?utf-8?B?QkJpM3VKaXpOdzVpRGpuQTdxcXVSYTlSb1JHc0JaS0hsSE8waVhlbzZ2WWlK?=
 =?utf-8?B?Y09TMG1rR0JsNUd3aGpSWVNTOFRQTVJVdHdCbEs1cEVkb1pRSURER09KRWdE?=
 =?utf-8?B?MkdsVkMxenpqMGlZQi9OZUxwSGhRK2l2czczdWRBN1F0WHI0clZpb2F6anZl?=
 =?utf-8?B?b0RGZzcyamhoL1Z2eGZJQjBPZWNvN1VObzgvWUNLN1pwS3BCRjNtcmhENXRM?=
 =?utf-8?B?d0NKSDl0OGtwb0JwUFdwWi9KN24xTVBKMTZUUkRIdDFNa3BMUU9lSThSZlRn?=
 =?utf-8?B?V2lwMFFSOHV5M1c4TU56U3JYV0hXRE1HQXQ0ekJXOEpuUG96bU83UEdXUFQ0?=
 =?utf-8?B?bGd2QzRJejQwMnRaMWtLSFhUSExtWDRvMVVxZE1kbGdOYWtyM3pjNW5qNlZC?=
 =?utf-8?B?OGtOVkdmdVBpSHp5TGZjZk5TVHUxdXJ3OUlva2lBYVhwTndpbHAySjNqd3Zn?=
 =?utf-8?B?S3JVSUlDVlJSTFhrM25DUUI4T3cxZmlESnM5Rll1MkdjYXFnSTdtZ3hLNWxO?=
 =?utf-8?B?alRkVGFzWkhMOGZvcW5sVUYxR2hwWllJL3Z6QU9WdHJQUmZnRHp3YlpVNStF?=
 =?utf-8?B?TXlIWUNiZi9GK1lRMFFZL091THFqQTFkZVpRekc5MzNSS24xQi9VWm1vQi9U?=
 =?utf-8?B?c1E3QzRyQXZHMEx4RldUNWFFeW5BVmdQakN3MjgrRUtJYVEvRlZqMW9KOUVG?=
 =?utf-8?B?K2hmalFQcDJSMisyQ2dVeUtjZmdVS2V5VkJJNEZySWxONnBZRitPQUpid3A2?=
 =?utf-8?B?UUZibXl5VFdjL3IwUXBsSU81aGYrbVBnRkJLZDNDVTNSbW1kWFV6UUI4U3JK?=
 =?utf-8?B?cHBzUzNOaEVQRDB0WDhCNldEdmF2SlcrTGpaZ0Jtb2hGa0R1dVV0RktGQmRs?=
 =?utf-8?B?WjA4UjlKNEk0MUk1Q2ZOcSthM05lY29VUlBmRURnQ002Wk9ycFdZYXlmWit5?=
 =?utf-8?B?Rjl0U2hXOXFUT0ErdVZ1UkRpU1VBa3JSc1NHUGNLOWxSVHAxOGN1K3JGdEVq?=
 =?utf-8?B?aFlscCtjVE5DSlFNelBWQytTQzc2TXlOdEZleXlIS3k3RU56S0NKd1hnQVRx?=
 =?utf-8?B?VkQzYlFTNFlLQmlmaDk5cDYzeURvcU9IVy92Z3MwK1p6V09IQkc4WmMrbEpi?=
 =?utf-8?B?MUplZVJaTkFZOEEySHlXeTBacHcxYVF0d1NpSTJvdDNtM0FQc2kvT01WNGpn?=
 =?utf-8?B?Y0RZeUVyUUZjK2tWM1N4LzVXQUZMeVBaU2JqenhhRklFdW1INmo4V2dDc1lR?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92E492AFD98DCA4D9048613175B9E3E6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fgGwJqt4thSg8Pb9PkKR1H5En6/wqSbJw/mGwtqKaFdJPoKy2UrrB6/5BV0AQcs7czJxKvYmR8v5bna6TTCKj+osVY2nn3fAMmgi0Mf5rsmLgph97UWtRgwvR95IQ3Grgj7ON3nao2n5U2LDkvDJxX6t9ogPM3fzFiz8XdQzBlHEYR5DBPpgcy4vwist5BtQCZsZyEDLxBY55HAZt3JiE7OVF+cbjs6Z3/jLN59Gbk4bN8K/Svu3PfVhcM0DiaCIchCcFjDKJ96zDjEqZAqiU+pTCP8auGOudTF5tf7vjfKA5V/qI3uxNcRyy+9T+UQAahXpG3NooH4cok8khomUsdZ40vLU/fJgpYfjsHZgijpq3AQBkCJww0myIU+kyEtUuIibOMZBdE57PWC6tCN2eJdz5YWRxLDdZB/Sjfc6IvUuet09V+nHtSzV53toQtBvznWyv+7DqceMNKl5GKzH+BtyJ9uGFXgQnSqCnicUOHxWxkAE7wHX+QQMxR6mdVdPBhZIFSFz2LSfcPLH3fybDZGysAfb0nRhXX2j4Gk+59e3bo9jtbcIxePdwToGBi4062O6bND0Z4MZPHR9p7tNKBXM7XM8UugFIRwU+Zp/AHDOr8zR/lM4dtZhYO8LHeFi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e900e0d-75b1-4db6-0767-08dcdba30fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 07:40:56.8566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oaJlel/WkNtNaRhNJqEPp7CVW7CMZPbdlrcFVC084rJ3+XDPEKgbS326w+HQa9Ll61mTUa7zZpg4WPhuADZA0c7DqbYu5S2/eD5oq38I/xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7594

T24gMjMuMDkuMjQgMDk6MjgsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC85
LzIzIDE2OjE1LCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4gRnJvbTogSm9oYW5uZXMg
VGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+DQo+PiBOT0NPVyB3cml0
ZXMgZG8gbm90IGdlbmVyYXRlIHN0cmlwZV9leHRlbnQgZW50cmllcyBpbiB0aGUgUkFJRCBzdHJp
cGUNCj4+IHRyZWUsIGFzIHRoZSBSQUlEIHN0cmlwZS10cmVlIGZlYXR1cmUgaW5pdGlhbGx5IHdh
cyBkZXNpZ25lZCB3aXRoIGENCj4+IHpvbmVkIGZpbGVzeXN0ZW0gaW4gbWluZCBhbmQgb24gYSB6
b25lZCBmaWxlc3lzdGVtLCB3ZSBkbyBub3QgYWxsb3cgTk9DT1cNCj4+IHdyaXRlcy4gQnV0IHRo
ZSBSQUlEIHN0cmlwZS10cmVlIGZlYXR1cmUgaXMgaW5kZXBlbmRlbnQgZnJvbSB0aGUgem9uZWQN
Cj4+IGZlYXR1cmUsIHNvIHdlIG11c3QgYWxzbyBhbGxvdyBOT0NPVyB3cml0ZXMgZm9yIHpvbmVk
IGZpbGVzeXN0ZW1zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IA0KPiBTb3JyeSBJJ20gZ29pbmcgdG8gcmVw
ZWF0IG15c2VsZiBhZ2FpbiwgSSBzdGlsbCBiZWxpZXZlIGlmIHdlIGluc2VydCBhbg0KPiBSU1Qg
ZW50cnkgYXQgZmFsbG9jKCkgdGltZSwgaXQgd2lsbCBiZSBtb3JlIGNvbnNpc3RlbnQgd2l0aCB0
aGUgbm9uLVJTVA0KPiBjb2RlLg0KPiANCj4gWWVzLCBJIGtub3duIHByZWFsbG9jYXRlZCBzcGFj
ZSB3aWxsIG5vdCBuZWVkIGFueSByZWFkIG5vciBzZWFyY2ggUlNUDQo+IGVudHJ5LCBhbmQgd2Ug
anVzdCBmaWxsIHRoZSBwYWdlIGNhY2hlIHdpdGggemVybyBhdCByZWFkIHRpbWUuDQo+IA0KPiBC
dXQgdGhlIHBvaW50IG9mIHByb3BlciAobm90IGp1c3QgZHVtbXkpIFJTVCBlbnRyeSBmb3IgdGhl
IHdob2xlDQo+IHByZWFsbG9jYXRlZCBzcGFjZSBpcywgd2UgZG8gbm90IG5lZWQgdG8gdG91Y2gg
dGhlIFJTVCBlbnRyeSBhbnltb3JlIGZvcg0KPiBOT0NPVy9QUkVBTExPQ0FURUQgd3JpdGUgYXQg
YWxsLg0KPiANCj4gVGhpcyBtYWtlcyB0aGUgUlNUIE5PQ09XL1BSRUFMTE9DIHdyaXRlcyBiZWhh
dmlvciB0byBhbGlnbiB3aXRoIHRoZQ0KPiBub24tUlNUIGNvZGUsIHdoaWNoIGRvZXNuJ3QgdXBk
YXRlIGFueSBleHRlbnQgaXRlbSwgYnV0IG9ubHkgbW9kaWZ5IHRoZQ0KPiBmaWxlIGV4dGVudCBm
b3IgUFJFQUxMT0Mgd3JpdGVzLg0KDQpQbGVhc2UgcmUtcmVhZCB0aGUgcGF0Y2guIFRoaXMgaXMg
bm90IGEgZHVtbXkgUlNUIGVudHJ5IGJ1dCBhIHJlYWwgUlNUIA0KZW50cnkgZm9yIE5PQ09XIHdy
aXRlcy4NCg0K

