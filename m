Return-Path: <linux-btrfs+bounces-10898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D5A08F78
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 12:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34083A3724
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD720B809;
	Fri, 10 Jan 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h2NAyWu6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sGwCLiMj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4E20B1FB;
	Fri, 10 Jan 2025 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508562; cv=fail; b=flyh3St5xeWkjggk5/vpNjTxzp2P6Qsmzx+1y+RIe7jF8LmnkFfKfKiKLDzyYKXDetotKwyj28Bd34xysSK9JLuLdc27Vjgj8ghn4pQVZv8ndDthf3nfrHxRFjk09c9Nb3Nn7OjwYORd4/iBY7gClHR3IOygo10vaEP1jGC9+Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508562; c=relaxed/simple;
	bh=VDR5i2PTklNOf+SVZZY7633x2ku/yYJ2Rpc3ab9yh3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FR4FOqOz7Z0TDop2HF2hi6O6R4yrHDU16CutBeEnufqfrM76uNrShmz8rFL+xtEFO3lSA7xXtuV1rRm8lFXiYeDkcF2sWS7mOR7lxjhbjA6h3lrQh8TEgUt+NmCSTYWJWcWvzgpBoAaZj9E65YdApnICFCBumq4OZljU2G8DtaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h2NAyWu6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sGwCLiMj; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736508560; x=1768044560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VDR5i2PTklNOf+SVZZY7633x2ku/yYJ2Rpc3ab9yh3g=;
  b=h2NAyWu6Jq7DHOxqt7A/jrV2lqwvm9RtRj1CsHUa1IPSC6S/K9Vqpm8t
   RYJm/j4Bcexh+06kWRej+XH16YQMtUiggi3jjO6Po1o/T0oXoJxj8kpI0
   k2a+uE1xE/tNjanPIGd8zEAR13R3Kl4awWaEK3738izKhpDwSIOhwIgQg
   ZVvgF2pG+0UAPd9HPC0paWaivdR6YLqFcjIP0HHkgvydtelZ5diFj7vFD
   J4OvUcf4gTRJVNOy4S4rq0SvfdJeAxPTYcG+6dDIhdte2g4cQM/+XiYSa
   ucK2WaBqoiWw+5gU7wVpEdMp3oPyNQlRTvN7lmEdb27V6hWS0aXpQ+tRV
   Q==;
X-CSE-ConnectionGUID: 45Foxpf/TtC+HFAnyZB0Sw==
X-CSE-MsgGUID: NPGRdZ63RpqN7lnbrBzl/w==
X-IronPort-AV: E=Sophos;i="6.12,303,1728921600"; 
   d="scan'208";a="36839411"
Received: from mail-southcentralusazlp17012011.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.11])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2025 19:29:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofqGqxp0N+81L+O2DHUr2GprOeEqEH2GTXdl1w5fHUYSGNtjF07rNDaIngbm1LmvaHauiGQr9LjUA50pUstUKEZshJM9hA9RX5p0aMJV4BKFU67Srczxo/yzUup4KSSiM82q3wOf8A223u/BghsxkWMJBTCC1kyaUHIBaNTdo8P2znnD2h73oL9j43DuBhIE7ZZ4YuTP2pckbp6FQ6V0RhefZh+zkFAZSn9m1j+7fS6HiMFlAUZdT75Ckz6Zw3BlQj1TWdSVsy58aCn3YqNI4szkKcYCkpRkxLA31z3w9vvop5KvPcn8OaMRoVm0rg6ybhVchaUk4PR7kg7wNhlPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDR5i2PTklNOf+SVZZY7633x2ku/yYJ2Rpc3ab9yh3g=;
 b=bBYslsBYo+DEIujbfxcVWhGzkOMP1jV/xul54dOBZirKd8YDw1HOKwyV7yIGSttwHKNm0oe088mX38LDkeVTc/VBk60tl4VHf+NErDX18DOhZodTqv59vqW0WVQzhD7RUEzqV4QmLusDPzXVA7WA0YNEUPQrBXDENORA/HdMjLT/nHvkYCg5SxG0FUXthe8kASlEY+6TyqPki0n0Y/rNiMUadGT9atNESAPKk/8mxKPcPpmsJDwSr9Q9/YGOLWTY18DxD58q1EdflQQgXFSA/T/SENC1cXtqwzeZFsTWYf89F00iNM8VzXL4PHOTHDxkhgDmYp5bKhEFSA4QsO0c4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDR5i2PTklNOf+SVZZY7633x2ku/yYJ2Rpc3ab9yh3g=;
 b=sGwCLiMjgK4rKECuZliS7227gYQ4gyKYmH4LyxCTHe/UqBsFdwbXhXxghfnIWraH952Y+pKPv5AV/UaQo+102rrsfHGRNg7FJ9W2t0rrxY8943ppKMyIKlIp8hQrQoMSW1oaTlsXnOaYwOh2Hkk8mKwmLVMN0m2o/MI37QOX4TY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9284.namprd04.prod.outlook.com (2603:10b6:610:22b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 11:29:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Fri, 10 Jan 2025
 11:29:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
Thread-Topic: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
Thread-Index: AQHbYQJflUTtOhP83EGPi0Ll42eqgrMOY84AgAAiyICAAAm5gIAAA5aAgAFP1gA=
Date: Fri, 10 Jan 2025 11:29:15 +0000
Message-ID: <59a203c8-617e-467e-a63f-d3ba648116f3@wdc.com>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org>
 <CAL3q7H58qoA1MjDG4aFbaGE5ddAJRgyNZ0rAyb+XhEqP20xKcA@mail.gmail.com>
 <ca324436-f214-468d-a769-fd4f236313c0@wdc.com>
 <CAL3q7H6cMsTn2ZksQTKuZYKW-g668i=o564sGMKGb1h2i06ohA@mail.gmail.com>
 <ea37cf5a-242b-48f1-8b8b-f8d751ede70b@wdc.com>
In-Reply-To: <ea37cf5a-242b-48f1-8b8b-f8d751ede70b@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9284:EE_
x-ms-office365-filtering-correlation-id: ece7e53f-f12c-4c60-70a8-08dd316a0386
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHJybHZQSGRmdXNWcVMyNUk0NitTUG81T2lSeUVQSEVQelFMdksyQTdKUXI4?=
 =?utf-8?B?aFJRYkd4cWV5SVJUYTBHalY4K01aYmd1emJiamRJeWMwcVUyZ2JPWVk0dW1T?=
 =?utf-8?B?R3RsbkJDNm1iblN3Zzh0b25od0djeWxhMmp0Slp1UTVVQm9EYzROaWxjQ282?=
 =?utf-8?B?Z3RtM0JDRURNYzFuZ0QzRlZFRDBXQStZWlpuY1ZFa24rTkYyVDlJVVNKc1k5?=
 =?utf-8?B?bUx2cHk3L1RJQ2FxWkh2MHFaSjdnVmE2dnk5ZXNKaFBlRkR0UTZmRDZ1eVdl?=
 =?utf-8?B?MUtLWkw2dEZvbllTY0Y1QUpsYk9sK2V2dmd5NmRaVERmMWxzOUNrbzVCeXFT?=
 =?utf-8?B?WUFlMG02QTRGMHVZRXRGMlkwY014UWs5WE5sMGp3eFlzdXBlbzR4b2I0OGF4?=
 =?utf-8?B?aUZDcXJZaDUwUE1JcEtOODg4TEl6dVQ1b25Cd1ByRm0xamZ3bmtRMjVDTlB2?=
 =?utf-8?B?QkQrUjNZS01YS2UzTUt2Q2JTN2NlTHFDVjRFWnludHMrZHNGUU1HRzI0OTBK?=
 =?utf-8?B?UnFmNEl5SThzQk9vZ244UC9uVHVrZUphTElOa3haNUhNWVZJaTRCamRFQm5E?=
 =?utf-8?B?bzVFUGFSQi84S3lpaFBwZlhFcXNZb0pEbHE0M25GUWp6Z2lQdXpvYi9TSUh4?=
 =?utf-8?B?QlYvNUN3cUkrZ2xUekF2OFJxcmVmMVQyNFIxR3JvUnV2ZG51bjZuVE9MeUxO?=
 =?utf-8?B?djVCdXRjVjNxSnJlNks4WHMvcTI2UncyeTErV05Wazdla1hkSVhtVlkzM3pw?=
 =?utf-8?B?bnJjcVRFRTJVY1NPNFNRZVZNSDJhOVB4Zm92UmN2dXd0NVVwYkQvUjhWYTd1?=
 =?utf-8?B?alhRczVkdUZTRkNybFlOQmJnalZkYVRYVWplUjFoYXlBcFdzS2Q2Tm9zWElX?=
 =?utf-8?B?THZpYmlOdTNvV2N3czZ3Nmw1bmpjSTk0M0ZETFpBQlFza2d5MFFpWi9jcGt6?=
 =?utf-8?B?amxUVXpQU01DeHJ0ejl6TlNaUEFEc2VlT1pNTXNQS1dycTZwekw4SVdXcGxE?=
 =?utf-8?B?bGJZWGZVblZtMlQzeFF1NUE2Wm5SMFlhSlRVY3BHa290NjJWNHhpVWJHU3Bi?=
 =?utf-8?B?NTBzK0dnZG5HRjlNd0FRelFKejZOaVRhVHE4dURkTEZiTGlualNpNFZrZllM?=
 =?utf-8?B?MzAra1ZBQnEwcDhxUzZESC8xVW5oc2pFTWk0bTA3TE0zSVdpaTRuTGVyOFd0?=
 =?utf-8?B?YkQ1dEtwdnhqVHZHRUtnTTVlWVE1ZFZTeW5QelpRTXNKMWZ3WUhSS05ycnVX?=
 =?utf-8?B?bnZMNlpnVFJEanVNeElzaStiV1JRT3pxMTJna0F6Vyt6VUdFeGpXYUZRWGlt?=
 =?utf-8?B?dDdSYVpjajJsQ2o2OHNLTEg5dWVLMXJCWThHTGpFOTJWNU9DY29qelZFUERp?=
 =?utf-8?B?WFBPOVIyNWswR2xhNWlMM29hRVNxTUVuRUZkdmJkY3VzL1h4NFU5NklmSlh2?=
 =?utf-8?B?QVRiS2xyQlI3cFhCaVlTUUkzMnJXRmFPaGZVWmh0TnlRdWp6ZDc4Y21kQXNj?=
 =?utf-8?B?dHBJcFlDZncyM0RBM3llcno5Yy8rV25VellzYVg0ZjBwM2c3MWprZEdIZGFs?=
 =?utf-8?B?TXV2NkRQUWkyay90VXoyQm9SOWtCUGtTMUl1ZFpqeFZMdHZxdE96OHlyamxm?=
 =?utf-8?B?dmhHWHovWjNPM1NJVlZRc3U5dzZiSUU4dDdyZWQwWEJGMjZuSURTSXV1NHJE?=
 =?utf-8?B?cHZoRFZSckZvbDFNMklvRnM4WldSQ1RhNWZNaG94VHZXZngrT1RZNXZlTWN5?=
 =?utf-8?B?YlQ3Y1Y5SEdiSXMyNlUxZzUzMFNsMGIydFl4SFR3cW1aOHFwTkE3amhpTWVW?=
 =?utf-8?B?NTRrUnIweHdSM1A5UTZ3aTZndVdDUGJEalZSNHJ0Y2hHeEp4bjBDd1dDNmJG?=
 =?utf-8?B?ZE9nNk5KTGJubGVzbGxnL0hRM2d5SEtLd0t5L3d4UThUcWJCNjJsNVZqa0t1?=
 =?utf-8?Q?05gOIKB+IEPl56zLCWdRCerYJqOCD775?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SG1tMEJjdmNmN2RKU3FYbEt6WmNHcGxKWjZPVE0wN1pPcjZkUTIwN1ptTDgy?=
 =?utf-8?B?USszVGJjb0pkcjVrdUdYaXlhTzgweVphK2VGUU10QzQvUkFRenQvL291aTJj?=
 =?utf-8?B?MUp6cWd5YVZVV0p2MGdGSCtZSEJZYVVMbGxzQVRTSC9hYUx1bEpQNStKNHhj?=
 =?utf-8?B?MHpYcmJQRzM3R0wxOFpPRGZPOU1kOHBMOHVWTGpIdzMyWGx6bWxkUmZ5RTZY?=
 =?utf-8?B?QStkZm81N2lKeExMb05aMlMwNXhHTFdEMDRpRGNZNi9CK0FWcmZjWUUxU2V3?=
 =?utf-8?B?bGtjeStka0tsbGdxazBwUGJFK2pQbmhvdVBDNUJFSXJZSmE0UUVBTWFtYzQw?=
 =?utf-8?B?bno4ZGczcHhXMk5reXozTjJnVU9TQ2Q5alpSdFhYRTBNQ1V2WGdCRy9uNloy?=
 =?utf-8?B?dWZ2M3hsSHM0WHg1K1QxeDlUZ1dYczNmMEJRNjkvelNvNVV1cytiUGIvREZR?=
 =?utf-8?B?MzZ3aWIrSUx5NkVLQnVQWVRPWFRDMnBtV2tvMjZMVkRyZW1JejlQbURiV2Yv?=
 =?utf-8?B?ZGdYbktZdU5zV3Jpc1VvRUR3aUtvdXJ4VktBNThvUStqaDdUWWF4b2hxQzRK?=
 =?utf-8?B?NzZxeHMwcVljTUY0ODQyNEx1Y3NXclFuRXdSNGQ0SUh2amRqRVlSdGsyTnFG?=
 =?utf-8?B?LytHbk1keFVjc3p1aW05QjZkTDZDTjFObEFhcmp4cG9CbnhlUmMzR3E3amNw?=
 =?utf-8?B?Y3FPeGxZTm9XRkFjc05WWVFNQWdXeUk4ckVtdXAxOG44dmpsSVMzdWFGZDRk?=
 =?utf-8?B?ZVVhNm1TUHpKVWpVd3JNa3Q2dEJVQ2ZoRzNSWVo3dTYvYk4rTFQwQU1Falls?=
 =?utf-8?B?ZStXRk45aXR2bEU3Tm5iUElPZnZVWjY4MndDUUJyOHVkMjZKNnVxM1lMMFBm?=
 =?utf-8?B?WXZGLzFGSVJaVC82dko3RnVrU2FkeHo3eTRNR3NBd2oyd2oxYWJqazAzWC9m?=
 =?utf-8?B?a21DSUhNZWRkampIcUt1K0hJRHVMUzFjdENXUGdLUElMdFlXSjlFall1WTZK?=
 =?utf-8?B?OEE4ckRRdVBySFgwYjhIeHh0SzkyeTlRS3UwcGd6RWtOVldyQXlNK0Y2RzNv?=
 =?utf-8?B?VWYwR2Y5VmZiTXpzZlZUMUs3NFZSaU9MUXpxMXNKd05xZkwyTHY0Qm1aSUN6?=
 =?utf-8?B?RFAvbFJmVG5oNWxYVlByekM0bEFEbUFwdjVLQ3ZXVnNQT0VuYU1iMnRHcUdB?=
 =?utf-8?B?NFFvWjZwM3JhcTY5Q3BqTy8vcW9McFcxajlTVU0vZFdqdkdQVlNJK2k3Kzhr?=
 =?utf-8?B?TVQvWkIvU3ptY0YvaWgwOFVKTW0yVktaeXFpZ2ZKMkNmWkt6TDhvV0hVVVJs?=
 =?utf-8?B?aXhZNml2dzB3dzBjbjJEbzhwakZFaXdVMzBSNnU1bjJLVU5vYlhxeEVVUFB6?=
 =?utf-8?B?NEk2M2NCN09keDlrSUNpYVI5YkZRd21rc2c5RXhkMVArLzR1NitDZXpEVjBa?=
 =?utf-8?B?RlI4YkxMYVhlNXJUQ3N3a3pCTE9Mek9aYTdwbE0rUDlQSXcxYk9tRkFBalZ0?=
 =?utf-8?B?NzNkVVg5Z1FqcUZOM3B4T0J4MjFvZ0x5VVVuZkExSEtWK25pWlFrVlY3U3Bm?=
 =?utf-8?B?ZDF0SDdKWVlEYVpPWWpEWTdFZXlLeXZrMWVLUmZTeHlSK2hlclM0TkN3YjVa?=
 =?utf-8?B?SVUreGZzUEd1UFBVZ0piOHVsT2xCT0gyYVkvcFJiOHFMaXpMRXVHZGhuYlBD?=
 =?utf-8?B?OHZCcW1raGxhMmxRWmdWMjV3d1ZxMnZWd3V5SWgwNHAyRVFmeFEyRHdlMFVF?=
 =?utf-8?B?bWY5M2FOM0RmYkp1SGVuQlVGWGljL2FYQWpKa09KV2lJU3JWQlNDTWx4WVkv?=
 =?utf-8?B?TlFiL0JOcXlWZlNvZzFqMTl2dlJ1QTIvSUxYT1FYVE1WaWUxUWgxamZ0RUVQ?=
 =?utf-8?B?S2Z0R0hkZ2ZiNkNuNTZMcG1mL0NaRkpSblNPVU0vMjc3R21PUG5WajAvRUVU?=
 =?utf-8?B?OFkvek1MZWVtZnZzcmlERndxZyswbWRuRk1ZQUluZHNJMVJUWEVzbHc3VS90?=
 =?utf-8?B?eEZIT3ZId3RTRHBxZVRHQ1VhWE1rdlArTzlCYW1OV3BZeVlsS0MwbVFZcXBW?=
 =?utf-8?B?ck1RZVhKNWIvb2l1TlEwb1lSS3FnZHlnWjBpYmZGNXh0Mm1PTkxPNHE2dkZz?=
 =?utf-8?B?VjZPWE1uZ1pFTGdYaVgwZzZIRUJOTDNzMXRPVW1scm0vMjhaN2hyNm5FZ29j?=
 =?utf-8?B?VDJ2T0UzVUcyL3FuTnFqelk2SVk5QnNjU3hLMXJYV0FGSVU2NlE4OG5FSDVJ?=
 =?utf-8?B?RUNNL1pyNWNOR1VBV1Qydkh6TUJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29DE9FE6FE15A548B0725376F949AFE9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FHcdAy7IhgOOlmT820urEqv8NuOwsUlM/EncAmo/D8yLEzFOBP+TOsmYkufCXnmzVwdDtkPeEWWd81GCoimeuBb4gTdbCWoiX812JaEnHx/gqz1Vqg1xxp4tRF/NjxpJIgrtBE8HFyZdlQpCaY/PtFr4ywyWMtNn8wMd9kPKS0YkFLMRrbeSOCKlhsTljjoJumeg3Plxxy+VdlHWhKfs6szyTw+GK6hkl8wNZWjBawf0Oqb5vqDnoFgnkrDhCPNktylCIbtkyD3gJulGPygDiEHerhcCdcN0iRHdC4ayI9UxW8QBUcM2q+J0RxUWtHn+ZMz9waXLINB2B4HE0PLjHwLKka/D44OWXYNpxsWwbQngCxMDpmWSaDS9utjER0CF14zhES2Uxvk8Mo57NyZ+EjwpofQEhp5OPOFex+1BjXn3LG+zVz+NYYIrs3dBLkYK9mZShe5rrGJ0W1O0uV5sgtFpsfgdgRHYhdgg9b80G2G0h/mOd+u9rqrb347U5DgZZVpi4CxUTNcA5P6In4Q17xs3Y36eFcYKHZTFbIBHG7PxE5f5/Q1Vb84oknqPtKZdgTqrZ/XuPK6xL0d2UGiJKBr5t1MUNY4ea0QRPN61HVOPvhgpBeN8p9/kfItxHyB5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece7e53f-f12c-4c60-70a8-08dd316a0386
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 11:29:15.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4Gi/7WLNxiqaByHBgFRQmV6AHxfhTbS/wfmHmAMvs7h1IP7T83bW+ncjDpkECCS219CHh4VVDvIgotxJVln4DV/SWXmfOoM32p8CYx7kS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9284

T24gMDkuMDEuMjUgMTY6MjcsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMDkuMDEu
MjUgMTY6MTUsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+PiBPbiBUaHUsIEphbiA5LCAyMDI1IGF0
IDI6MznigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4NCj4+IDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2Rj
LmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBPbiAwOS4wMS4yNSAxMzozNSwgRmlsaXBlIE1hbmFuYSB3
cm90ZToNCj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy90ZXN0cy9yYWlkLXN0cmlwZS10cmVl
LXRlc3RzLmMgYi9mcy9idHJmcy90ZXN0cy9yYWlkLXN0cmlwZS10cmVlLXRlc3RzLmMNCj4+Pj4+
IGluZGV4IDMwZjE3ZWI3YjZhOGExZGZhOWY2NmVkNTUwOGRhNDJhNzBkYjFmYTMuLmYwNjBjMDRj
N2Y3NjM1N2U2ZDJjNmJhNzhhOGJhOTgxZTM1NjQ1YmQgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9mcy9i
dHJmcy90ZXN0cy9yYWlkLXN0cmlwZS10cmVlLXRlc3RzLmMNCj4+Pj4+ICsrKyBiL2ZzL2J0cmZz
L3Rlc3RzL3JhaWQtc3RyaXBlLXRyZWUtdGVzdHMuYw0KPj4+Pj4gQEAgLTQ3OCw4ICs0NzgsOSBA
QCBzdGF0aWMgaW50IHJ1bl90ZXN0KHRlc3RfZnVuY190IHRlc3QsIHUzMiBzZWN0b3JzaXplLCB1
MzIgbm9kZXNpemUpDQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihyb290
KTsNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+Pj4+ICAgICAgICAgICAg
fQ0KPj4+Pj4gLSAgICAgICBidHJmc19zZXRfc3VwZXJfY29tcGF0X3JvX2ZsYWdzKHJvb3QtPmZz
X2luZm8tPnN1cGVyX2NvcHksDQo+Pj4+PiArICAgICAgIGJ0cmZzX3NldF9zdXBlcl9pbmNvbXBh
dF9mbGFncyhyb290LT5mc19pbmZvLT5zdXBlcl9jb3B5LA0KPj4+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJUUkZTX0ZFQVRVUkVfSU5DT01QQVRfUkFJRF9T
VFJJUEVfVFJFRSk7DQo+Pj4+IFRoaXMgaHVuayBzZWVtcyB1bnJlbGF0ZWQgdG8gdGhlIHJlc3Qg
b2YgdGhlIHBhdGNoLCBjb3VsZCBiZSBmaXhlZCBpbg0KPj4+PiBhIGRpZmZlcmVudCBwYXRjaCBp
biBjYXNlIGl0IGFjdHVhbGx5IHNvbHZlcyBhbnkgcHJvYmxlbSAocHJvYmFibHkNCj4+Pj4gbm90
LCBidXQgaXQncyBhbiBpbmNvbXBhdCBmZWF0dXJlIHNvIGl0IHNob3VsZCBiZSBjaGFuZ2VkIGFu
eXdheSkuDQo+Pj4NCj4+PiBJJ2xsIG1ha2UgaXQgYSBzZXBhcmF0ZSBwYXRjaC4gUlNUIGlzIGFu
IGluY29tcGF0IGZlYXR1cmUgbm90IGEgY29tcGF0IG9uZS4NCj4+Pg0KPj4+IFdpdGggdGhpcyBw
YXRjaCBidHJmc19kZWxldGVfcmFpZF9leHRlbnQoKSBzdGFydHMgY2hlY2tpbmcgdGhlIGluY29t
cGF0DQo+Pj4gYml0IHNvIGl0IGlzIGZpeGluZyBhICdwcm9ibGVtJy4NCj4+DQo+PiBZZXMsIGJ1
dCBmb3IgdGhhdCBhbGwgdGhhdCdzIG5lZWRlZCBpcyB0aGlzIGNhbGw6DQo+Pg0KPj4gYnRyZnNf
c2V0X2ZzX2luY29tcGF0KHJvb3QtPmZzX2luZm8sIFJBSURfU1RSSVBFX1RSRUUpOw0KPj4NCj4+
IFJpZ2h0Pw0KPj4NCj4+IFJlcGxhY2luZyB0aGUgYnRyZnNfc2V0X3N1cGVyX2NvbXBhdF9yb19m
bGFncygpIGNhbGwgd2l0aCBhIGNhbGwgdG8NCj4+IGJ0cmZzX3NldF9zdXBlcl9pbmNvbXBhdF9m
bGFncygpIHNob3VsZG4ndCBiZSBuZWVkZWQgZm9yIHRoaXMgcGF0Y2guDQo+PiBUaGF0J3Mgd2hh
dCBJIHdhcyByZWZlcnJpbmcgdG8uDQo+Pg0KPiANCj4gQWggbm93IEkgc2VlIHRoZSBwcm9ibGVt
LiBJIHVzZWQgYnRyZnNfc2V0X3N1cGVyX2luY29tcGF0X2ZsYWdzKCkNCj4gaW5zdGVhZCBvZiBi
dHJmc19zZXRfZnNfaW5jb21wYXQoKSAqZmFjZXBhbG0qDQo+IA0KDQpCdXQgd2hlbiB1c2luZyBi
dHJmc19zZXRfZnNfaW5jb21wYXQoKSB3ZSBnZXQgdGhlIGFubm95aW5nIGJ0cmZzX2luZm8oKSAN
CmNhbGwgYWJvdXQgc2V0dGluZyB0aGUgZmxhZy4gV2hpY2ggaW4gY2FzZSBvZiBhIHNlbGZ0ZXN0
IGlzIHBvaW50bGVzcy4NCg0KQWxzbyBidHJmc19zZXRfZnNfaW5jb21wYXQoKSBjYWxscyBidHJm
c19zZXRfc3VwZXJfaW5jb21wYXRfZmxhZ3MoKSANCmludGVybmFsbHksIHNvIEkgdGhpbmsgdXNp
bmcgYnRyZnNfc2V0X3N1cGVyX2luY29tcGF0X2ZsYWdzKCkgaGVyZSBpcyANCnRoZSB3YXkgdG8g
Z28uDQo=

