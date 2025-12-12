Return-Path: <linux-btrfs+bounces-19680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224BCB78A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 02:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DD93028DBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 01:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0151E23EA95;
	Fri, 12 Dec 2025 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WBL89QiN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TB709vHq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D61F1D47B4
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765502839; cv=fail; b=llYJrKu8BwLnREGUGqFzwnYv9JbcFW0ptB7DxrU+rBGa2rOVruZZlwtZxvclWZFNjc4iaEZlZ61F6qIkaCQHzpQFVmA2r9pNmvs25HtKSbN13mXlyzY6TZv1fP5N1pAsMwWMXYWo+YyjoTWFZxvEhpfzlVrcQm5FphgvBO1w/Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765502839; c=relaxed/simple;
	bh=sxuThIf/FKxBGYjPHNoIw+WVjHqMytco7KIIS0IbYGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uc9gvuyjDbj14Uk6qytfLnIeecYBgjQaq8/Jl06XeFqR5n91i5ag05JjcnhhY6TK11gA08cHI2JMaZ8VsgfngydEJRF6+jMJFzneQfQMPtJUah0jPzupKFNFvwKnUsQyDiGfxXHAc0q6obmtK3vekr6xDgEh+itgl5Fqlpt7TWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WBL89QiN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TB709vHq; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765502837; x=1797038837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sxuThIf/FKxBGYjPHNoIw+WVjHqMytco7KIIS0IbYGA=;
  b=WBL89QiNHbbeUh/l09Spsciv+V7F3A5mv8kRqgGvgzUGNkK0WR6VHf6I
   t14GkKM3J3w6tTP+/z2oPksWk6zpbUGpoVOY8APsV/Rffy35OyF/RdjS7
   aEh+wTThdvBa9c3A2BH2kRVNuw4peBxORpIUAp/UDKNRtBeu4ysxt4XdP
   GP/il5q7EC3lAO2fGRjbOd7OshT0+h0zyHU+zkTS6nG2YvH1jnlNdU/8v
   1t/GeQgSvILKYoIcDwFK6nOMI1ut9Aacea69w/VHS9fQpAxTAn1J9YdHf
   LZByyNbEadcAYKLHTArcxnif4BeHDDJj560SA+TApK1kzFXhZaInTW+IF
   w==;
X-CSE-ConnectionGUID: wAjTlsDNQrajmFnmutMguA==
X-CSE-MsgGUID: h+8aqiHWSCmJU+3haC04mw==
X-IronPort-AV: E=Sophos;i="6.21,141,1763395200"; 
   d="scan'208";a="137736387"
Received: from mail-southcentralusazon11011062.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2025 09:27:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQobNBawMBSfGT5slMzP6aBlD1Ut15z6lScaSbqf09dV4sCZjLxXCe6j9KDWnUa3U1NldtggsQ+hyIAY6FoUhnUZ3UePcD+EN0aeHeB1al9f3rky3ZjrDJtxYaB8zhQp2SO2XCPX/3M/BWfrsLCoRnWPp84D4YcQoD3+1hMPAJNsHQQriFviKGpmxP7GEYURO/EoTIL1pq0hRqGwny/CEYKpN9NMKAYm6nQ95kZB3TIpVBKkyIQmavSDN4ZTlykd/VaImemnP5owVpbjfnoJmnwtaQH6NS0LHsJLNiP93YyxnOrfXCMIsN+fxMgLXtzXmCfWNTqcJPofEn045omUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxuThIf/FKxBGYjPHNoIw+WVjHqMytco7KIIS0IbYGA=;
 b=C0rwf2NV6jVSvxdjAerKPXWISP0ajXx51Wt1lIEkkv2BnSohb9GDOR5exiB0z07k4ob9UJpJTXPnR81atjteM7PyKUTmt9LULzdPN7E/lNF/SpezTM9EF5RQrLqG/77DmamdPVA02oL1U6eoclui90joG+G57QUslNtUHye4gxEG88rJ7awTNP4E02okZk/aVmbG7helJ7xDNWteK/9FE7lmmkjsVuHkunGUYbjBJyRn8SE7BxNyt+6t9JXlvGA3zTo4MPlOEJjhsl/qsk7J4dp7iPcfvHyEWCr+vE1bJNuBi88kfUDGcHbu5dVo4Ivi2yGXEyg8NgnopEsjm3XKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxuThIf/FKxBGYjPHNoIw+WVjHqMytco7KIIS0IbYGA=;
 b=TB709vHqCvWMDhh0GYoH9NHU2gHAQpcz7aTkAZryXrGbKO0bgS1uRjmzweU0nkiZ6AZKD6CxYXvzTrON5jIrw/ay9hKWcRtVY60iwVP8CZhfUDTS5+1FrvXG6aHeQEouVwKE6C2MFdkCGG1hhD2cEwfI4V2WKVXLAyofVgwrDKA=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7406.namprd04.prod.outlook.com (2603:10b6:a03:298::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 01:27:08 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 01:27:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs: Rename space_info_flag_to_str() to
 btrfs_bg_type_to_str()
Thread-Topic: [PATCH v2 1/2] btrfs: Rename space_info_flag_to_str() to
 btrfs_bg_type_to_str()
Thread-Index: AQHcanhNEGV/DLOOZ0yNe6vNuKrW1rUcS1qAgADskIA=
Date: Fri, 12 Dec 2025 01:27:08 +0000
Message-ID: <859da8a8-ee90-4342-ae07-156640d60912@wdc.com>
References: <20251211082926.36989-1-johannes.thumshirn@wdc.com>
 <20251211082926.36989-2-johannes.thumshirn@wdc.com>
 <CAL3q7H7yki0Fw+1CLVzqWMo4UdNxnRvRRz9NPaGNUkFO79uZ6w@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7yki0Fw+1CLVzqWMo4UdNxnRvRRz9NPaGNUkFO79uZ6w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7406:EE_
x-ms-office365-filtering-correlation-id: f0028b33-3d8b-437e-3d4a-08de391d914d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVBTSnIvUjBMVTZqbG0wZDBoa2wyWUdlK1ZjNTVIV2dmbWQ0akxoT295bG4y?=
 =?utf-8?B?ZDBDajJaOTV2clVmNUdCUEh4K1RjSGluK3BEajgrWk91L21sa0NSQWdlNVg2?=
 =?utf-8?B?STJEWmhhZ3JRVStaNUFpdGx4RzNOeWlaUlM1dTNVSVpENEl3bC9Tdm56WklO?=
 =?utf-8?B?SDRzeDhjQm1nTVhoamhtY3lBOGxJaUp6NkVUVC9GSUZUZjE2YUd0TExVakVB?=
 =?utf-8?B?eDZpZnd2ZEYyUkUvM1dkL2dsajhZQllpem9KQkdGcVBDanRXNkRzTW9jZHFm?=
 =?utf-8?B?T0JYeThQV3hNTktETmJoOWljSzhBUEVIQzdzamROMkxINEZaRmw2d1Bmd3Rl?=
 =?utf-8?B?UytiWTZ3TjhIRHZ4S0poQ1JBUDE0U1FlTnpBV0hxWllCSTZwVXlBMnkrc1Vr?=
 =?utf-8?B?NTlyYmdpRnc1OHBIQUZCNU4zcS9qbzNLMXpPb2FhRkw0MjBuTktWbFFFa0ZX?=
 =?utf-8?B?SSttN0JVYXlaSmhVL1puSzQ4N0RFbU8wWG15L2R0SXN4aWUrV0R5MG9oZzRh?=
 =?utf-8?B?VGE3Yy9iQzFPcVFFM0FJSTBnRTBPMWpEeGltWHJJeUVWRlFPTDRSYThMUzVC?=
 =?utf-8?B?VGo3QlIxVWJmOEZrbTdUSlBEU1RmWG03UWNydkU0b1VlMnBEWDIxZS9yTWNP?=
 =?utf-8?B?ZkRseFhxTkxyckZFTGFCaE9PSDFCS01QZTZjcllacjFETVFYY205b2Q3ZFlX?=
 =?utf-8?B?ZW9pYWFnYXhuSkFqa29yL2lSWE1taFJRZzUwVTlGUDZoQnVHVmpGbzVOblJK?=
 =?utf-8?B?K2ViM3Y4WFpsTW1FY2JIYVFjclh5MWtUd0Q5ZFE1b3hwYkhCRmxxcHU1YVQy?=
 =?utf-8?B?bkdJNFp4YlpWMi84K3hpZ0JkZFd3ekcra2QzUE4wZ21MRWl1YldwT3QrS0FY?=
 =?utf-8?B?ckdpNFlHUFRGY2w0d2JqRHpOdXZWaytVd1d0d0pnM2JQWGs1d25lTkRQR3U1?=
 =?utf-8?B?TnZ4dExqOXMwcG5iTXYxVWNaaXR5TS83VEFURmIwQzd3T25PdDNnUkJnSHgy?=
 =?utf-8?B?NlZqbDFhbDUvci9DczByQ0NaQ0lpVlBIZmw1V3ZLeG43RUFZTkxaemV2ZzY5?=
 =?utf-8?B?ZDl2cHorVUowS0JjYXFvWjZieXBpOERKd2E1ZlZQaWUvenFvK2xJMjh1Nnlh?=
 =?utf-8?B?RHJXM1UvTDBRYUVWWXFYVUUyTHBRWGg5elFwalVTU0VnNE03ZDU2TFVvbE5w?=
 =?utf-8?B?TnNCYUFLeEI2S1BZbW9QN0VvUVF1aXNQZEF3Nll2K0ltQ25USTJtUWdZQzZK?=
 =?utf-8?B?VmlIUW5sdHZNU3hvbFNVcWpOaUYyN0gxdkNLTHBRUHZ2eThSTFZIZkQxT3d4?=
 =?utf-8?B?SGV6eTIybDBlY3krbDhxZWNMeU9uSVBkUC84SDM2Y0hFMFJ6VEdab01jUHcv?=
 =?utf-8?B?RXNtNlcyTmFMTlhzRyt4VzdueXFMTGN2dlZqcU0zdVdTS0xlQ3l6d1E3dUgv?=
 =?utf-8?B?NHpNMHEweW9jcnpzM2pob3RJWmVyZjR3WmlMUHhWaFYxdDJQeG1EK2l3SGVq?=
 =?utf-8?B?cVBBM3BRRnNQMnhaaUcwdjRweE1iaDhtajZPRFhtRDV0cWE5Tmp3bHZhVWdU?=
 =?utf-8?B?dTZXaC9RSXRXY25RNGk5S0hDcnpNL0FhZ1hNSjcrUy9UbDF5NUJBSWxTd0o0?=
 =?utf-8?B?QkU5Qm5DNEs1SlRsUTFWLy8xb05lQm1oY1phVEVSNHpFK3gxaTZ2R2x3NXdr?=
 =?utf-8?B?Wm1aS205NnZaU0pLTThOWDFWcmxva290Yk1EVk9QMDRRL0NabEorWTZ5TU5l?=
 =?utf-8?B?ckJnbXJnSFliYUZOMS84NGtEcGxGRTRUNXJiQjVoS3hyQzVqdGdibW5kK0pZ?=
 =?utf-8?B?WG56cHNlV3VjMUtSV09wVVNQc1ZxK0NxZXJjaUJKeGE4TGU2bllsbkhNb3Jp?=
 =?utf-8?B?c3ZERWdScFE4ZVFZMjZPMkVEc3VBeGh5OUhBc1pXcVcyblp5eHlxMjBsZ3Nu?=
 =?utf-8?B?cWNKQ01GbFQxZ29oVVBjaE9zdWZYMUJVN2RCblR5NTcxNEY1UWtkZTZiWXE1?=
 =?utf-8?B?SEl4dzBjdmtxMmhyWUhuS05GWmw0WjVKdjU2ZGFCdk0vSFZFWHlSY1ZTL1Iz?=
 =?utf-8?Q?uVZXAN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjlKRFdpeHpWM1FiVytQR3dHVzE3bTV4UjFrOStQekk2TkxQZHZEOWg2aFI3?=
 =?utf-8?B?Y1E1NTUvU0Rmc2NWeElFdmF3VDhDa09Vc3RWd3I1VHZ0TTdQMmsvRys2N2pN?=
 =?utf-8?B?YjVTTzNieGZDUmpzYVRud0ZDTUgydWlDTTc3dVZSa3FDK2NhWjdTTnhIdWFm?=
 =?utf-8?B?RC9XL0hiaHZrSEZSQTZHODdPUGJTL1RhWnBzNVVGdENpVVh1TTlrdzdkc21G?=
 =?utf-8?B?ZzVZckNmNEhvU01PekRtUTF0V0FHRW9QMmZIVjZpb3hKTzZBL1krSzhDWXpw?=
 =?utf-8?B?THdmN0k2Rk1MZ1hsTU0xcjR4S29VVW5qTklKekRJYktiTDVVeldPQXBwdHNT?=
 =?utf-8?B?UzdobkJwWFJid3FKd1pETTdDQnloV094VU1pVlNSL0l3MnIwUzJDdDk2RnBt?=
 =?utf-8?B?ckcxNENoUXJIYlVWbjUzYkVZeHFkbFVWZTQ2bkloY0RsZm9yd0JPWnI3UkVs?=
 =?utf-8?B?RGQyQXZTVkVZNDBaQ1VkRzJGb1BXWnpNOW05b2ZKUGY0V24zRmlHQmh5aXJP?=
 =?utf-8?B?QmEwM29yZVJvdW1QdkQ5Z3dsRVV5aTBOZ2FBVGdDeUpIbGRQTTdWaGR6cDM1?=
 =?utf-8?B?M211TU1kQVJEV0lCZ0Y2bjZLWU8rTmtTWndTWG9heVV1NUVMc0FUUVI4enFC?=
 =?utf-8?B?OUZNNlFaejBwbFRNMjdTTDZSU3lndTc5VE1wUlY2VS9waDViVmQ4MzVqVGQ0?=
 =?utf-8?B?clhzdkRzTmoydERYbkdzQzlVUWpjZ1dEYlpPdmVKeXBOSnRpQ3FPZ1puN1RT?=
 =?utf-8?B?TTRBYk9oSnRGd1RuNEpUcWFMTFlRbi9RYnhKb0xadElpa3AvbE9LL29yU1VX?=
 =?utf-8?B?Wnc3Z243T1Jueml1T1VQdUx2RFRBaXlBQlhvbDB1TTNiYlIvOWZOdmN1d0tp?=
 =?utf-8?B?bUo2Rm05enV2ZGxGNnFaYmsyWU5jRERxSHJSR0FQUGNwSUN2emZETEZSMDZW?=
 =?utf-8?B?VHI1Y25NRUEzN0ZmclE5QnZWNTRGV2NodldVeTBHMHZKdEtTT3pacGFLYnJI?=
 =?utf-8?B?elR4ZjhETVhrMWt5Wk1MRHc0Qk5uRlNTd0JsTUtXbVRFZ2pZV2ZjSlY1STJq?=
 =?utf-8?B?QXVVRW94QU9uT01nbEhGRXNKcmpaZzM0bDArWk5Ha3RPMHhPRlZjcWMxY0tm?=
 =?utf-8?B?TW1EUXFMSGp6TStFYTg5b1RyT3BaN1RXZmtHSWZQdUZRTFQ3SGhZcCtpYjlU?=
 =?utf-8?B?VGF6TjladlJRK1lhMmwzTThsa0ExRUNNMkxoRlNxR2Irc3NjZzVKSG03RGR5?=
 =?utf-8?B?dE5XOG0rMmdjNkxRSXRnc1AzSGxKcldQc0VTVkhNcVV5c2VEQnc3a25aSXh4?=
 =?utf-8?B?Tzl6bE1hcDlxbXkzNzUvYVNYUGl3K3Urb01oYzNuZ2Q4NTVGcG4vVmtybjkw?=
 =?utf-8?B?R2Q0SFF4N1NMc3NRdzh3YWtVbHpWbGdpdWpvUXJOZmtDdkFibENCWGRDVm8x?=
 =?utf-8?B?T2Q0bTFEdTFUU1VvL2hvSTVacG9IbzFIcll4dWt1ZkpONXpXRlVNcWoxaVJh?=
 =?utf-8?B?OUkvRU82OWNLa2NHOFNBalVsdWFVT3hQNldmdHZvRGlBRzNWRThzUXpUOU9j?=
 =?utf-8?B?WnZicXArTW8yMlRtZ2k3cjJLUU1SZFh5RXVPc1NadlBaMHhsb3NVaUxDQ1BR?=
 =?utf-8?B?YlFYSmk2SHJHM2xqS0p4UmYzK21uT1BNUmFudFdEQnBsdGdLOUhiVVJqcVVq?=
 =?utf-8?B?OFJ5RnZCcituZERIbCtEZjMyN2xneEtoWDJENit2T0FzN29QaVVnTnFpaHBY?=
 =?utf-8?B?UXJqSXk0d3c5eVFGOWNnUHFoUkVOaHowRUcyKzlkc0VPb0hIK1MvR1dhdHVE?=
 =?utf-8?B?SDBOdWJocXNJcW5OUDY2ZkpaNGdHL2trSTlBNnRTcklqZXNNeENuVzVKRWpS?=
 =?utf-8?B?cmhtL0swdmxGaWZUSGhJQ0IybG1WempJU1VuVDZEdkpBL3FxMUdlUm1DWWFs?=
 =?utf-8?B?S3lna21KdG5UNlhoZU0xSXNBUE1nWjFFeFUyekVUbDlCeXViMjJGY2htdk5k?=
 =?utf-8?B?dzBFMUpjRjYzbE9yZHowOGpCeGZKenZlbW81QnUyTHVvai93VmFpdDNSVkk2?=
 =?utf-8?B?V09jZjE5ZHVSTENkZEVxL2drRXIzN1NDT1ZBNDluNnpVamZpdk0vRHlvaHl0?=
 =?utf-8?B?QXhJb0htMVgvN0JpbGdHZ0I2UTlFOW5uY1pDWUVxZ3h2bGh2amlUc1NGNWlo?=
 =?utf-8?Q?pkXp1aTPeMYM9Tz2uak8elU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <899E160A6E8BEC4B80747D82EA798838@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rXJxvqwLIhS3I0bhEdYN48l/rsDUYJD3razh8JYi0/u7ACB+klf1Vtg6DvmbPqWKeQ8kAhcHBxaQkfAnkh6ebhRZ3pdzwhYfw1dqh1E0lROWSmEQwVZBhMgkyErx8297hngZRqPzp4AIbLYRbkiRnqEb5Yyr0/ukgBuXr6qmmNzibvtgH3XsOUXAjqueGAbV7tp1cRfX240po9VLnu4RtBvcl2LuupATqiaxGwxFMd4ftBvDIdNHCDF6NGJuPI/wPByT0+PgbvhfN5iQfZZXJqW6w+qZzEBHOGl2p8ngj93G2u7QZelzTp8KBwzdurOc+SiU0+ZDDzc4xnXxNMtmj9KFVLMFcdyMHNJhMZKv7rY+U718ulGUwoNxe5J93lOPkggQrV62BhAsC2RpcE4mh6550nGc1c4mAySY+OpXWbj8ky8NvhH7fJUDt5pcd3Qg/CTRzhyNSTGtQmCpV2i7ZL3cdPcdU6YgAsqjtQquj3LlidlTpyMx/y+K0loV6A5IbsyCuhSRrjf0ea6zt76GrCr5V+pHu134pVhnsUlrF6vbsmcXardI3zSva+EFBuUSW3pOaBi9zrmY/4312nGC9S/7Xh8jCxGWLPkzYsSzV3a7isf2sA3biqu50RSIb/Uv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0028b33-3d8b-437e-3d4a-08de391d914d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 01:27:08.7170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V2HZ4sph7eDJkiPg5xNnuY7vKM1cgvXsOFU5taiPfQGc8ksLBqaN7T5AVs3TU8XboBWGK1Cn/dYu6FDEf5PYRpGrFMW+NmnLlpqM+Z4n2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7406

T24gMTIvMTEvMjUgMTI6MjEgUE0sIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IDEpIEluc3RlYWQg
b2YgcGFzc2luZyBhIHU2NCB0eXBlIGFyZ3VtZW50LCBwYXNzIGEgY29uc3Qgc3RydWN0IGJ0cmZz
X2ZzX2luZm8gKg0KDQpJIHRoaW5rIHlvdSBtZWFudCB0byBzcGFjZV9pbmZvDQoNCj4gMikgUmVu
YW1lIHRoZSBmdW5jdGlvbiB0byBidHJmc19zcGFjZV9pbmZvX3R5cGVfc3RyKCkgYW5kIG1vdmUg
aXQgdG8NCj4gc3BhY2VfaW5mby5oDQo+IDMpIFRoZSBleGlzdGluZyBjYWxsZXIganVzdCBwYXNz
ZXMgdGhlIHNwYWNlX2luZm8gdG8gaXQNCj4gNCkgVGhlIG5ldyBjYWxsZXIsIGluIHRoZSBzZWNv
bmQgcGF0Y2gsIGp1c3QgcGFzc2VzIGJnLT5zcGFjZV9pbmZvDQo+IChldmVyeSBibG9jayBncm91
cCBoYXMgYSBwb2ludGVyIHRvIHRoZSBzcGFjZV9pbmZvIGl0IGJlbG9uZ3MgdG8pLg0KDQpkb25l
Lg0KDQo=

