Return-Path: <linux-btrfs+bounces-21926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qILZDwQUn2nhYwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21926-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 16:23:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8301F1998B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22D8325D03B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CF73D6663;
	Wed, 25 Feb 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ieyZzeVS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gj/v78Dk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AA3B5309
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032450; cv=fail; b=df6ZCL7ty9VbyOL0ure7JqgMbRl2tjH27NRGnzV/g7lc41Rp+9Zak8RpHLF3hn2XohtmAVZ4EL/AYzcTP/DalnYqiM6NLY6ijmg7Egd+WhPt2gwfPuvU3pyE3QBVkr7UJBYLWIbFV7DjrAjApMgQDUr2FqohSzW3u2wgh5Z49FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032450; c=relaxed/simple;
	bh=NTy4W8rPjHL2NGmcQtm00kQdcxx9T4ArYjrepV1udKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mncAqyM0uirAKdTZNy0kUINQZ3Eg1/5A+Y+SyrSRwzj9Rb2UO9iDT3kW5pUtnU4V2xWs0tSVcKqGBXA9NRoXOphXWTyox83VzJDzBjkoKAM5Cd1mCAXQMneinH7b/IYtGofmz868cpP7jB8Tf9i1g95pAcpOYuLPBTtqHCKLrdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ieyZzeVS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Gj/v78Dk; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772032448; x=1803568448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NTy4W8rPjHL2NGmcQtm00kQdcxx9T4ArYjrepV1udKw=;
  b=ieyZzeVSkU/QipvdhVIxfM6ScnAg3N02A7RfAhdqbhUsmCN2GVviEGaH
   t3miMHW7isOK0yHUhJnI1+fWnfrrqxL1qjlKx3njBchiGDKNGt4W9IMk9
   H8nKEpHqp93BqlUtiYDcbUzCxx+g+Dj3GNVGmK9mFPGR1cuKtZj5RH/R0
   tHDD82qr5uJfFeyHLncAuNJZ/Vy0XWEfe6NWj+k5V9af9mj/5kKJgSqmL
   Nc91uYALbN82dh9ztEV6hmCm8Uo9qGjv5bzNVOOBV+EFm3L6MSiJHNLVD
   LI0LWJ0R5WHKuzW7Q7VI4oW98WIA7iPPq8C2+Ybz/Oar4P3NFSLRYFua6
   Q==;
X-CSE-ConnectionGUID: JYx7+jUCSOaZofkDcvGvLA==
X-CSE-MsgGUID: NQ57FX6HRDmzMC62Mup1bA==
X-IronPort-AV: E=Sophos;i="6.21,310,1763395200"; 
   d="scan'208";a="137856836"
Received: from mail-eastusazon11011053.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.53])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 23:14:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuJOdLyudFLy/7VDAY8YKwGk0bh0xXHcD85YZizO/ypeCl+/ekGHZ4Dn6QMWjqhDZ3HOSuCgSuOy6MzIPbH3+DE/dpOm4Za4APA2get2J/wWw3wPCpyxXaze3JTXpBmYaeso3PCMn9JMtNIo73+BguX2tnTjvhZzqbZa7Bld4u4ysdRmtUt1bT+UgWSXxv8J7FAsrX8xJ2M6LVsakFLecyRkWZVTIoj+S4yx74dX7jRX6ghpAkh7+wLgt7ebN0/xHSkwrgVYEI7jFHPQx5lcmDFqlOgtyekRlGf8wOzmEmOOWeVeJ/wh0xPiafrEgRYA2jOMy+MNwaf0/AAgB61oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTy4W8rPjHL2NGmcQtm00kQdcxx9T4ArYjrepV1udKw=;
 b=Dci/T02pxKt4nd8aCUKCIqzCTJfy2iqUUzpGEGJY1kxf1aEdhgytVXd0syGBEWq8z1ZKCNXPEA8f5xeZGbisqMCXs+S78xl55kyoo4HrgbzzI8cb85+v8hfzkvUydN22zopZyDj0CGUsUzsFWz4AZ5CE+yJzVPN5ZfvtemmVzTu5gq7wKDg/KYrMdBIzoBRGwzPG9IVYFYvVCDth9R8bKdMjwAUFCrdcOILSqbD//kg8LU2RH97Bd7RNaSSZ+NtvnP87u9UpxvFS3vBq+gA3uknbGMRHAdpUE7ZENnvYQCX4uZC3BqXeMi5/f9F30b0cus7aeB9HGo2FGaL1w0gZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTy4W8rPjHL2NGmcQtm00kQdcxx9T4ArYjrepV1udKw=;
 b=Gj/v78DkO68B1eA3SPCpQsyTrwyjvxnxws/wMcZDfIeYumCjx4J3PECEATNtpqWlHF2xINazyq5Y19Jl4ZQjjxcZ6exjxKFzsZ/cQ+KZKPaZRhu9WNsdbRYb99MtQPGMzONYdK/QjFlsqWlIZFy2BYAlYBIDCjsghIHzvJrBYp8=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6480.namprd04.prod.outlook.com (2603:10b6:208:1ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 15:14:05 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 15:14:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Mark Harmstone <mark@harmstone.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: fix potential segfault in balance_remap_chunks()
Thread-Topic: [PATCH] btrfs: fix potential segfault in balance_remap_chunks()
Thread-Index: AQHcpkKRHAyOZxUqbU6oVMSZ7MNGF7WThLSAgAABiAA=
Date: Wed, 25 Feb 2026 15:14:05 +0000
Message-ID: <72de8bea-ef69-41ea-8aac-f4b8e98ad5c2@wdc.com>
References: <20260225103535.18430-1-mark@harmstone.com>
 <20260225150835.GF26902@twin.jikos.cz>
In-Reply-To: <20260225150835.GF26902@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6480:EE_
x-ms-office365-filtering-correlation-id: 53522017-21ef-474c-4c05-08de74808404
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 atwccASUfqhCfze3BD/NdNxX/7QLp/unbj7rtB4SEvOSK2O++kBGuzQQWk9Ms8lRSpBFziyc8suPZV5p0Ivq+VNnwKhdrQU4/H4sP+rwO1BJpo9ILZgS1AhyP0mDzZopCbD+f/eRJNXz5MgWkZZmmn2nzz1QvHMFhyn5wOpETC+E8b8UNEoR7KwKDoc0OnhP35h77f8ApKFJLtHeHQEv0ojxd9TlvMwGX8PZpsiljP7Fgwc+XOwxJR2j71IKyeuDA5rj8AexDII4z5y8eoDpivVrPB7yJNsHumacvvsXL7nCLL4rnUnwwJcEAVH3DpoHscI2nW0ls+q2MXSVfqmw0CyzIsbF5suDIILrCLwKAxaADgR666LiKVk8ugS+o8lgzc1j2WloHjeQmTBS2gHhrzdiB9Ncabm9euq/ok53UJSl5SF+W0vGTJ/P9WYV0Xr/It5pL/tbHzNwZHijyG1DPKnzZm08bi2bOzLr7RLbbrYYruAnIzDMqPdk+n2By194JBgiDuwCn3O8rQCKVvxc3GnBJZGUoTNeUOVLsDQHoFUZOtcjTvh/bAiQqbynIYIsWRaGwSB4z3LXDW0hLrtLpS6jwGK6gQ2JlGoUgGhR6Lac2LMcAfpv1YhHv/k+jjm5XoHNqYQrWzK/61MDJBvtmqWaom/lTse5XMu7mzsoVU+Ig+kdz15O7RDjzpUxTrpdBR0qNL8PU6oFIl/ifNXQDmGEGaQVit994tYeKaj0EWHAwikoJuX4k0qCa4hBCKbppRR3Y3++yGM0TMuPrOrQOcwmWQeP6yB4cUxuNBL1NI8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnBLSTM5SlN1akp2WDZ1aEE3Wk00Q1BNUFpPcGZzSVZTT3dqTUt4elhwcVJC?=
 =?utf-8?B?ekRBTndITzZNV0ZYTm41aVJ6bE9ITkJpSE4vVFUwWHkxeFNLZjdiVDBnYUIv?=
 =?utf-8?B?VzdNRDdLUHVGWm9CTUJ5T1J1cWI2WnZGazVGa1JBUi9sS1lwazdZak1hRTd5?=
 =?utf-8?B?L0FyOGIyUkFuWEJhdlFkTWp5U01FMnRabEcrT2Z3UnhMVlBld1ZCV2dhZ2Np?=
 =?utf-8?B?UURtMjlhbzJtSFJ5cHhBV1M5a2dHRUFnWCsxZG00c3VGT3Z0VnUyZ2RwdFhD?=
 =?utf-8?B?TGUwb3BmcVROR1I1RDM1VG1jTDVFTVJnSkRpRDRDTTdjYkpwU0hVSjlzQWNY?=
 =?utf-8?B?TE5YMlpTWXZWMm5YbUFhRDVuYTRwZ3dwU0g0eUQwUUJsYko2QVZDdEhJd2hN?=
 =?utf-8?B?bnJmZ0IzL2V3MjBNNkROR05IclZBZkxhS3E1ZkZBZlpQZThaRkJWMEI4ZWtZ?=
 =?utf-8?B?RHBPejBhWVl5dUtmbnhheDNJQjFMNEpDc0l4KzBJMUEwVDVwdUVxRmdlMVlT?=
 =?utf-8?B?N0dJajNQcVh5KzRFMS95ZTJraEtIRThIN0JobEVxV0ltK3Mvaksva20yVVFF?=
 =?utf-8?B?by9EQzNNdHR1dVN5dmhQdTRuL1kwSjVjTFRzd1h4QVhrYjFpTHRTeERhSWxS?=
 =?utf-8?B?eWVpYXNyZUw2R0hlOGczckpYYjhrejg1RTh6RlljekxCSmZQTHlSb053WU5y?=
 =?utf-8?B?SzJmb3VXTVlmNk1ieXFtSFVFTnREVllSTkZEay8vR3RObUE1SUZIV21JN3ZF?=
 =?utf-8?B?dVJsRFd1Qk84QVF0MVpXTTJTbWY0U1ZJQW9vRlRneFVCVm1sdFNYZDVlWWl0?=
 =?utf-8?B?OHRHdlRwWm5UbXFnUDc4S2lyWGcvR0Z1NHBjZTc0c1RIdlEzNUxOcmY4aXkx?=
 =?utf-8?B?eEJhMFhPTGlPWVpvei9xQ3Y2aFBBL0hOVWFacE5UTXd4b3NVRU4rSXZIZnlB?=
 =?utf-8?B?R3NsOVNtTWxXNHRPd25ZbmJtM2hVaWcweFVQZmFwd1BnajFsT0RlQTRvajdV?=
 =?utf-8?B?NVVYaXNjSHpqNVUyVE1aRmdkbWpzdGQ5SDJ0RWVSU1VhZHkyUFk4WUkzbHcx?=
 =?utf-8?B?ai8ybi9HZlg0a3NZUVNST1BMMW43VlJ4NWgwWkRXM28wM0VnTTJIU2FqbVhp?=
 =?utf-8?B?SlBXUWZ4ZGJTeE1ueUo5a2FmTWx6MU5adnJDS2hLZjJsNjdYVWtYaUNXRHJ4?=
 =?utf-8?B?ZURHcUUyNktGVDFBTUZJUEM2VjVwRUxVVmpMYXdLK0t0UldvbWFSR2o2RFln?=
 =?utf-8?B?QTVHYXdxMCtISGFTVXdXSTJnMERwUTlIRjV6RkJYUDBtcGNWNUhrdVZ2NldJ?=
 =?utf-8?B?WW11UHp6TVQvQ2k1Q0hndzFqNklNL1FPbE5oSENmYmphYmswRWJxYjlKNkZN?=
 =?utf-8?B?SFRTb3VNeHdrSHZzdGtuWnRBbUxuUlFJUFB3WndzUUxJT0JFMlZ2eHVFMDdi?=
 =?utf-8?B?Q0tLS0JHSkVsNHo1UzR2K211cGhacFBTbk4wM2ZMUmJtd0VvaWdFb0doV0ZW?=
 =?utf-8?B?OGxRQlVmTDZVM0V0NG54OFh4S1dPUS9DZWpMSVBVVGZURm1kaGFiK1NLTXQ0?=
 =?utf-8?B?TVo5VTJCZTFHMFB1cHFJU1RUc214SThrOUFGVzR1bHdGM3RHYzRDb3RBekEz?=
 =?utf-8?B?MTRvcXdJUUFuVVN6MmJKSGhFT1hDSU9nQi9vVDRFSzhQNVpnbTlJV0Fwa2cv?=
 =?utf-8?B?TVdaYnFuZ1htM2t0MTNub1JSL1lSVlI5MFZGQlFHZmpKMTQ0aVF0dHZXUlpN?=
 =?utf-8?B?UVptUzdjWTNHOVVDc0FNUnArZk02bXBaMEk1VHlIY1E4N3VjazlKUkYraE5C?=
 =?utf-8?B?enZzSzNvUWdiTTBCRElWT1VPOXE4VHR6d0kvTDlNeDJZUW5iUlJtZ2I4dk9M?=
 =?utf-8?B?RFpxOXhQK2FyaUlxR3pxbVA5MFVvTVBqZzdPMDE5ZUxHamorUng2c0RiMi85?=
 =?utf-8?B?WjNoSUcvSEdNNW5XY2wxM0lFejZOMU9KUEdoaExWOEZsUmxBcENzNEl4NzVp?=
 =?utf-8?B?NmM3cTF0citEbTAvZlFZZk9nbDY2bExndnB3T1pobHRJNVFKMWpoSlhxc3Nl?=
 =?utf-8?B?UnJqcnplY3RiOWtHa3V2bXlqV1VyV1NLOTYwQnhUcXFNOEs5MGMzVVJWTW8r?=
 =?utf-8?B?UU9XTFhja0pOdGRmYmIzNEd1WEVmQnVuN3Y2UWQyRE0yK0tEUTRpVmU1c3lZ?=
 =?utf-8?B?ZUVSWFgxSWJockc2bENFcFc0aVlRY3AzNzg3U1JjblpZVWF6c0s4eE42bk1U?=
 =?utf-8?B?Y2hVVjNsRmtPaHRIRG9HVDF3MHBvKzdSOVNVZUZZazlKRWN0QWlxR0FRb2VG?=
 =?utf-8?B?Qk52ME0yZzNzY2VVUkV0QnpPb0pXYVhzNkNJdGxRQlJLYzNSeHg4R0VibzZm?=
 =?utf-8?Q?MhYcs/AuDH5xGc4pKRiadzCLRmrzvXd7gs6maaE0ZQf5C?=
x-ms-exchange-antispam-messagedata-1: 3wcrXwFmZNUWKOBmJHClcwJMWUnqbqErY6U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1A1F5C0210F0D468D4B3B2596460D5C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jdBLo6CeqpT2V4Y5UUnSwrEVI1HGp7TMPBFGujaRiSrlYpk+quE6acvwmh/QFP1Jn45bYLXX4gcj2CaEbbeRs6ci3IlRLiiwT6pc+J9J81eaGTdepyxIxyyLasEjYD36HxvrAZbUUsgWJUQMyWf+dM1Uo1tjfi2b9xGxz0uI3gOfmp4lTsfgMNidHJP7lmU+/EIZxyqLs2m1uZBrqgk60ofPpgb03EUdDoOKCVNj9HIO0NqkP1OwQF1kQgucyioqgccgOneWBtQ0lsLf/s78K5SzNp1zNQGBoGRPvg6I0Ap5Vbq9QDdVtiQRg/f10On2YCHCbwUMcjB8WYPKtQ2GCOg/XfrhcPN+BoDxznqxbNzOmeI4JG+LB7qmMDRoFG/1lKQPqAIUOxhCDwBIq9cDKOPHM2p8Juw+S9Kf3K4cxoFRLwE8VTbW87MIzDMjpjobgXssp3KW5+AhbOHnisxAf/47UK43p4InQBDFhan09l1OBTezz/NZv4XvpmZWJqmuUPlSBFSitRn7mzbeEgwHrABSWZ9W7OG57jzFAMpOXfxzohXHZta1s3mpPjllgXyey3JXddAmg66PaIqTxX9HLNAnZtKj+AlJwh3upIjEHaxnZBE3zEhD30Dp8rbQH8RS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53522017-21ef-474c-4c05-08de74808404
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 15:14:05.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJ5g9GSTe9kYLQesCc9l0mZVAYq2hdyLznkC8ewcCZIKFSZMZe7tEgxTYBnAdFR2jEK0MsnDOjdQAyDlkbWuSfg2ZtBf+Osw3mtyh2GvfiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6480
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21926-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,harmstone.com:email,fb.com:email]
X-Rspamd-Queue-Id: 8301F1998B0
X-Rspamd-Action: no action

T24gMi8yNS8yNiA0OjEwIFBNLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIFdlZCwgRmViIDI1
LCAyMDI2IGF0IDEwOjM1OjMxQU0gKzAwMDAsIE1hcmsgSGFybXN0b25lIHdyb3RlOg0KPj4gRml4
IGEgcG90ZW50aWFsIHNlZ2ZhdWx0IGluIGJhbGFuY2VfcmVtYXBfY2h1bmtzKCk6IGlmIHdlIHF1
aXQgZWFybHkNCj4+IGJlY2F1c2UgYnRyZnNfaW5jX2Jsb2NrX2dyb3VwX3JvKCkgZmFpbHMsIGFs
bCB0aGUgcmVtYWluaW5nIGl0ZW1zIGluIHRoZQ0KPj4gY2h1bmtzIGxpc3Qgd2lsbCBzdGlsbCBo
YXZlIHRoZWlyIGJnIHZhbHVlIHNldCB0byBOVUxMLiBJdCdzIHRodXMgbm90DQo+PiBzYWZlIHRv
IGRlcmVmZXJlbmNlIHRoaXMgcG9pbnRlciB3aXRob3V0IGNoZWNraW5nIGZpcnN0Lg0KPj4NCj4+
IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzIwMjYwMTI1MTIwNzE3
LjE1Nzg4MjgtMS1jbG1AbWV0YS5jb20vDQo+PiBSZXBvcnRlZC1ieTogQ2hyaXMgTWFzb24gPGNs
bUBmYi5jb20+DQo+PiBGaXhlczogODFlNWE0NTUxYzMyICgiYnRyZnM6IGFsbG93IGJhbGFuY2lu
ZyByZW1hcCB0cmVlIikNCj4+IFNpZ25lZC1vZmYtYnk6IE1hcmsgSGFybXN0b25lIDxtYXJrQGhh
cm1zdG9uZS5jb20+DQo+PiAtLS0NCj4+ICAgZnMvYnRyZnMvdm9sdW1lcy5jIHwgMTggKysrKysr
KysrKy0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy92b2x1bWVzLmMgYi9mcy9i
dHJmcy92b2x1bWVzLmMNCj4+IGluZGV4IGUxNWUxMzhjNTE1Yi4uMTg5MTFjZGQyODk1IDEwMDY0
NA0KPj4gLS0tIGEvZnMvYnRyZnMvdm9sdW1lcy5jDQo+PiArKysgYi9mcy9idHJmcy92b2x1bWVz
LmMNCj4+IEBAIC00Mjg4LDE3ICs0Mjg4LDE5IEBAIHN0YXRpYyBpbnQgYmFsYW5jZV9yZW1hcF9j
aHVua3Moc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHN0cnVjdCBidHJmc19wYXRoDQo+
PiAgIA0KPj4gICAJCXJjaSA9IGxpc3RfZmlyc3RfZW50cnkoY2h1bmtzLCBzdHJ1Y3QgcmVtYXBf
Y2h1bmtfaW5mbywgbGlzdCk7DQo+PiAgIA0KPj4gLQkJc3Bpbl9sb2NrKCZyY2ktPmJnLT5sb2Nr
KTsNCj4+IC0JCWlzX3VudXNlZCA9ICFidHJmc19pc19ibG9ja19ncm91cF91c2VkKHJjaS0+Ymcp
Ow0KPj4gLQkJc3Bpbl91bmxvY2soJnJjaS0+YmctPmxvY2spOw0KPj4gKwkJaWYgKHJjaS0+Ymcp
IHsNCj4+ICsJCQlzcGluX2xvY2soJnJjaS0+YmctPmxvY2spOw0KPj4gKwkJCWlzX3VudXNlZCA9
ICFidHJmc19pc19ibG9ja19ncm91cF91c2VkKHJjaS0+YmcpOw0KPj4gKwkJCXNwaW5fdW5sb2Nr
KCZyY2ktPmJnLT5sb2NrKTsNCj4+ICAgDQo+PiAtCQlpZiAoaXNfdW51c2VkKQ0KPj4gLQkJCWJ0
cmZzX21hcmtfYmdfdW51c2VkKHJjaS0+YmcpOw0KPiBOb3QgcmVsYXRlZCB0byB0aGUgcGF0Y2gg
YnV0IGlzbid0IHRoaXMgcGF0dGVybiBpbmhlcmVudGx5IHJhY3k/DQo+DQo+IFRoZSAidXNlZCIg
aXMgcmVhZCB1bmRlciBsb2NrIGJ1dCB0aGVuIGJ0cmZzX21hcmtfYmdfdW51c2VkKCkgaXMgb3V0
c2lkZQ0KPiBvZiB0aGUgbG9jayBzbyB0aGUgc3RhdHVzIGNhbiBjaGFuZ2UuIFRoaXMgY2FuIGJl
IHNlZW4gaXQgbW9yZSBwbGFjZXMsDQo+IGJ1dCB0aGV5IHNlZW0gdG8gYmUgcmVsYXRlZCB0byB0
aGUgcmVtYXAgdHJlZSBmZWF0dXJlLg0KDQpHb29kIGNhdGNoLCBpdCBpcyEgQnV0IEkgL3RoaW5r
LyBpdCdzIG5vdCBzb21ldGhpbmcgdG8gd29ycnkgYWJvdXQgKHRvbyANCm11Y2gpLCBiZWNhdXNl
IGJ0cmZzX2RlbGV0ZV91bnVzZWRfYmdzKCkgd2lsbCBkbyBjaGVja3Mgb24gaXQncyBvd24gYXMg
DQp3ZWxsLCBzbyBpZiB0aGUgInVudXNlZCIgc3RhdGUgY2hhbmdlcywgbm90aGluZyBiYWQgd2ls
bCBoYXBwZW4uDQoNCg==

