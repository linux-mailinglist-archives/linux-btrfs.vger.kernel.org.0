Return-Path: <linux-btrfs+bounces-8381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECBA98BAFE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 13:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021A6B20C55
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047441BF805;
	Tue,  1 Oct 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FuNHKDXX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="df7wI5dY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C091BF81D
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782027; cv=fail; b=PHWZrUnIcKaUTBptcbnTfdFkdcUo0Eee0SGs6OwvhZ14ofVsz3LQggBiRC0T9ybds3xUYsqZL5OikihNwuVUHxHG6kEKUYOXwwpsvqB2hTZ2n6kD4qjbuhx+kPu/Mf1Du1CobuPX8q8QJZVu+yj5TaPjf9RDXxPCfTjoTgrnwWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782027; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sex7J6Lbzt3c/Z9LRG4d977M2fPRvEnibLKm1LRVhWvLXWEglto/4f0hUx7zBSN1uGkHqTLyhpn3zWnwZoMj9ckwmrO78aumOGaFDAX0F3Fo3Q6vfUAjFQ3EZ+1vmx1Qv9Kp//r28lH4228nnFJxcBzh6dYI/Q4dkqJX2Pq6QAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FuNHKDXX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=df7wI5dY; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727782025; x=1759318025;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=FuNHKDXX4JuV6id+olOMwFV1NTNxc88lT6i6sb3kbL34VcRf7AuN9Ko/
   fbLC7RcG1dLggEsIcO5I2gyor9lHbZrXDdl3lLyuzbHszOlIqn0QI/ZZ9
   mPd2LlnExApS3aSXZEk4RRg6ZiJpIEfBQLakua7B+ti1GI5rCdoF8LLjm
   rz701wRVjAqACeKTOYDcYO6QRa75TN/PYEFgtxQuKG98a6wLMcFtSJqvp
   /agkvgsNUSk6NrdbbcTyiO3vsjEb9T3NVCWWiNzcsF0AXumtee8Oa0M2+
   LR+lA8xeKMrOwP+JO8rOdWf3YPGKbmFyNr/24tmVpYOQLOLjt3AW9xD/5
   g==;
X-CSE-ConnectionGUID: 3AaRgIw8RfCTNoeWjEsmCA==
X-CSE-MsgGUID: Z9sHW0ooRrSBhxfzvLCqXg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725292800"; 
   d="scan'208";a="28057498"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2024 19:27:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVbR91vv8llzY+1tIyNrS8U7iWUKTsDBFw7NxI+Wh1WFB2+S1On6xI5ZqhjTZ+IyDXHfIBGPPESczcqKkgB4X7b9stF2T8+SvKP4vK1cdRuMI0X9c0D6k4MDivl+WgoKe2jYB4LHSgPvNwEGCeviVJxZx6uu8Q7os3CDta4Iz+GpoWsK+WedBg1cAagUVGTIYSfgwNDKtSeBbdAYGiGGL2ZXDam77Zsi9nglz8OX1hHvFkSeeypHkbJZSoHntGP41Qse7QK2ONy9fyoJ0jygvwUhlg1NVks5R+bP4QaoCapZCdhyGC67T5a1eBX08qE3JbA4PkRC3Q+83vLpsoOaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MhFXsycULSV56EmxuR04fnsKnLk/I8YL5fjNTyk45nfPUGuE7tKhZEUfo/ZNo3lEWlQoErcVKQhg2T1SSIhUo7cjlPl1+HJd6S/jDHwyJjAq4dpRH8uuwEVcCK3KvqeLoGE/Xb4oy5XYj4jk1K9lgZxy9CoGwb85wtEn1pby/DyU3rNE2v9oFro6DqUc7YYcQ41mwqR1WxnCNqM4J4ikiRGNULA8B+oGPtup0UwhFRM7xeA0oyXor890GooidJcGHP2MJf12KBRKNpR1mwPIHni0KfpfeZayNgVWDSyeQ1zXdh+6Lh8YU1EdwdQTiqDY/I9T00PRzHHCDjEm2xdtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=df7wI5dYVLjyTXsDLyyxE5yNiSH3WPrupxIGcCLMAlo0Js/eK1Mum+ES5W1dk4C1HMsRnva8VeZMZM32Lmw+PiCscq1ByVbixeQPx+jb3N9gs7cHTxPEXkI64dxK4nk4Tf0VQxAyOwj00s4GB7OS0GXkNBKdmp85KCwx9K+wEPQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7788.namprd04.prod.outlook.com (2603:10b6:510:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 11:27:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8005.028; Tue, 1 Oct 2024
 11:27:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: wait for fixup workers before stopping cleaner
 kthread during umount
Thread-Topic: [PATCH] btrfs: wait for fixup workers before stopping cleaner
 kthread during umount
Thread-Index: AQHbE+vK+IIw7bC5J0OtlpxNgrpkprJxwdOA
Date: Tue, 1 Oct 2024 11:27:01 +0000
Message-ID: <1528c4a5-948f-4514-a8a7-52eab378801a@wdc.com>
References:
 <91b0cff4e87fbc01a7a6fd7d068c6e54ea7296ea.1727777967.git.fdmanana@suse.com>
In-Reply-To:
 <91b0cff4e87fbc01a7a6fd7d068c6e54ea7296ea.1727777967.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7788:EE_
x-ms-office365-filtering-correlation-id: b119e024-77ab-45bd-0de9-08dce20bf832
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTlqUEdobnpCQnRoMmx0cjhUYlJvcVB3eVJaUVMzQU9ra0JmWldUYStqclAw?=
 =?utf-8?B?dVN0UmFUQnR2QTRmcmZnN1QrVlRET2paSUkrN1ZzOVZ3N29VUUJzMjhuaHZ3?=
 =?utf-8?B?UjNtNm8zZFIxU2V5WXNZUnBETGVFOEp6ZW5vUUIxclFNUnlwaUN5SnNhTzBQ?=
 =?utf-8?B?U1d2Y3dHNEZTZXJBdWpVUXFFRWV3Y0NJc0FXWVBtK0dmMXdoV3lhdS84NkxO?=
 =?utf-8?B?Z0ZVcFYxZ1VOM1RnTlJYajJLcklESWtqV0o1MmJHTTFJYWwvWVR3LzdBbzYz?=
 =?utf-8?B?bEtaODVxZk80Q25EWmFzSVdHU1krTmRSRTNEVWNvTEE5UHFwY0tscE10ZHV4?=
 =?utf-8?B?RXkycVQyYXdsT2h5Mlc5RUd2dU15T3cvK1duQWltaElFQmlKZGtGekoyZzJN?=
 =?utf-8?B?Nmc3L0tHRnFVYUNiUlZPRlFGVEFyKzVBYUZPOVZhb0hyOHJBb0lJYnRkTDNw?=
 =?utf-8?B?ZkFNVWpvTitzakJGeWhQU3YrZ3YyWE4zbVZaU1VlUURmRzRDemNTd25SaFZI?=
 =?utf-8?B?RmY5aTdTZWR5RU4vUXN3MVl2YUEwaTZ3MXJQbEpwUDhYK1J6OTJ1YVNFL1Zh?=
 =?utf-8?B?djVsOXFZU0tYSktuYTlQc1NtYXFJZnd3RW8vUkRaYzZFamNjMXU3a01OczhH?=
 =?utf-8?B?SjFYUCs1NHM3S1NPWXh0TDFaMXVyc3FXcVVWL1ZJdHM4U05XNytVNVRDM0dl?=
 =?utf-8?B?ZVMwbVlnb0pHTmU4Tmw4MExsSXc5R1habHJGVElGRC9XTzU4Q1h1QzhJRXB2?=
 =?utf-8?B?YzlmbURSazZIS0MwL3ZGUGlzR0xHYUJyWXMxK1V1Rm83UG5wc095TFdtUE9L?=
 =?utf-8?B?RVBVUUdNQ0Z1amNVRTRlRURCUmNKaWRzaHE4VlhoTG5yQXNXNHlxaUcxN2w1?=
 =?utf-8?B?YXNBOG9RRjNudHkzK0pDTVFGOWhsbWRGUFZucW5HNStRWDFLeDNNbUZVQXBV?=
 =?utf-8?B?Y2lybi9vaFBtZ0NSR2VrWHVZMzRJWEY0eUswc2dKMzRoVkdpMUxEbjI1VmtY?=
 =?utf-8?B?RjRuWFY1STlGMHlJSlI5Q2xkTElnYVB4V2tqN0lBellPQ1BHd3RtQTRDaE16?=
 =?utf-8?B?WXpLOUhOOE5USlhWcGxJdFQyWnVOOVBUTkNSckpibjRzZFhJd0IrdU9UdjFi?=
 =?utf-8?B?ZkVWVFhVQ3p5VDZyT3pxZ3FvRFB1Rks4S1d2UkJQTkVHSFg2TEIranE0OHlu?=
 =?utf-8?B?WGFmVXlNMjZxZnlkaHpnZWlMZnQvMDBISnJmTHRTTW5HWVdPcW9wWkZHb0pv?=
 =?utf-8?B?OWdyVkNUdHI3dmlLQm1mRFdEanRtOGptOHhleXB5aUdhQWU5Qis4STRpUnZs?=
 =?utf-8?B?VlIrdlhGL1hTTC95dEpxUWpxV3AvK1ZoWTJjQmZsQkN6WUZSVVRqeDk2bnl0?=
 =?utf-8?B?bjZ6M0ozbVo5SzNXWEpWVDU2ZExTK0QvMlpkUXM1bmJIUVl5emJjcjRySnFM?=
 =?utf-8?B?NU9qVU52M011bHQweFJTaFRzWlNaOE4rUXdWZzlFWEJ3QlFPUURlTGdhbnJr?=
 =?utf-8?B?am9zc2NpTm5SWlRkWk9HN1RNV2l6OFFuQzFLUHFBb1dUdDdsL2s3WTcrR25J?=
 =?utf-8?B?dFl5VWlCeTlGcndTUDd4TFcrNmVRYlpsQlBqWjRwSjFoTmRUd2pMM2VMSHVL?=
 =?utf-8?B?QlBWWmNwbEdkYXBrNXFmUDJDWUY0Sk5yY3FycXV6amg2MmlJbmdDSVkzQzVF?=
 =?utf-8?B?dmM1eHV5ckMwKzhWU3NMcVN4V3ZTeWJFdThtYnVKOEFKV2ljQmRKaDBkTllW?=
 =?utf-8?B?UTFWZTR1aUVBZkdDYUtNM1JhSWxZVFEvSXRLbWNRcGs0clZFWDMxL0JLUWkz?=
 =?utf-8?B?QzVvcG5XeUFyRS84eVVOSjBSNlRTYWpYT2tpRUUzVURGTkR2ZERYb3dJV3lY?=
 =?utf-8?B?NFBENEwrZ2FOcHU5QjExTktKWXV6NXV2QUw4NnNnUSsxZFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVlraXRiblZjeXFZZ25VcmV2b25nc2w5TVpEL1h2T0RuNVBzTHk2amNJaGE0?=
 =?utf-8?B?RHp0dXBFakp0a09PV2FSSXhtTlZhVDZlMnV0MTlCYjJFS05tQzI1SGlSc1RT?=
 =?utf-8?B?SDFsOStVRUhWR0IrVTJwbU9nVlhlOTcvenpyVWtiQ25QUGtjM1A0VGtoM3ZZ?=
 =?utf-8?B?WENkcFd3OE9ucVVRNVZKNkNjd2FBUW05V3pqaFZIZ0swUSsxVFFRYk5HQnZm?=
 =?utf-8?B?cnorRWpMUEg5VHZDalF1YzBTandrRW1Jay8vYU9EY3BnMUdDLzlJV2ZTRVJu?=
 =?utf-8?B?TjRpeUgzRlhUR0ZCY21LZEFmcVp2ZWN6UUxqUGc2dzVMd1RBZWFITWZnOURX?=
 =?utf-8?B?Q2ZzcUFTYS9MYXJUL3JXQkIxWTc2T2N5Ui84STZyTzZpdk9GSysrbSs3c28y?=
 =?utf-8?B?ZUxhWFgrTG9RZDZTREI4czZFYlo3ZDhzbFhvMW5JU29POTczeW5XTmdWMElN?=
 =?utf-8?B?OEhuVmI2ZGo2ekZjckNEMkt3dDFxdk1FVi8zR0Q0OTlmSTc0VmtDcHhwZ0hM?=
 =?utf-8?B?WFlicVBEYXZrVTNwd2owRVg0bk9RQ1ZBaW9Ecit0UFhuVEU4cXMxWjZKa3ho?=
 =?utf-8?B?WHVWSU5KejY5RzhuekRPMUxZN08zRTdiRGl1amZKbnJ6L1B1SXFZK0dzUXda?=
 =?utf-8?B?bmVDRXZtUWwrd2N5bEpEdDUyRzdXN2ZhbDJURk5nSSs1bzRUNEl2bUFwOUcz?=
 =?utf-8?B?MnpLR2dBOEFPc3F2Y1VKZ3B1SkUvZ3Jadi9QRkl0cG9LNEdkUDBLa1prbzBB?=
 =?utf-8?B?dHNkSTA2dDJUY2JRbXZYTjVydUJzVTk5RDd2VHY5czBUeGwwMjBwU0pQVHBq?=
 =?utf-8?B?aXFmWWQzODZIOWNhdnNKdHdLZHFVM1lVQkQxM1JuMlFYOEpmcjR4bURnTmZq?=
 =?utf-8?B?Sm5HM1IvbVJQQktZV0dFVFNWSVFTZGdtaTRRRmtPMjgraHVSQXh1cThYYThV?=
 =?utf-8?B?ZFltQ3Jsb1hCdkpzSUlIRVpUL2hvbXEzOTgyVStraC9wTkdicWdWTXVocmx1?=
 =?utf-8?B?T3B6dExVcE0yWTRYRUt1TnpweXBDSm43S1lVb2Yra3M5NTk3MGRxUllSVHZ5?=
 =?utf-8?B?R3RyUEkzSTdnaVNyVW5PUVZ3V1FRTFRKRmxHclcrdndCa3huTnNaZUVORlRG?=
 =?utf-8?B?bngrVVpqZEYyK2kvaGpoSGhYamQvQ0JwUFBNMTlpb0tCc1d3dkxTR0I3L3Aw?=
 =?utf-8?B?WTNrZXJzT3dZRlQxQnJoRnhoa0RqeVV0QnRwU0E3anR6R2pkdW54QUwzaDcz?=
 =?utf-8?B?R2VSSXltRDBZVDRrWEtzeldKUVp3M3BKTUhEWElwOUZtSWo1Uys0UTJoblZV?=
 =?utf-8?B?UGN1NzI4UnR6bU1mVGFsUitFQml3VlNTUjhvd2lKczhQby9EbjVpTkxnc1RT?=
 =?utf-8?B?TWFPbHRWVmJ5VVRCMTV0YzhLUitCVFc0WGYzbjl4VzhXSml2OFA5RE5zUHBt?=
 =?utf-8?B?VVZ6ZXB5Ui9YdzhmRE1aZS93SURCTC9kT09yZW5FSGlySGllWFZSeVAxeUpP?=
 =?utf-8?B?K1pWY3hpUVR2K0lReEs2L0kwVnRZSWFRcXRaVG01cDR0aUxTL0EvQ25jUFlS?=
 =?utf-8?B?dXYwU0hQeWRxQU93S253Q29PZ0hYa0lWVlg4cXlLZXdxbUZxRHZzOVhsNzdB?=
 =?utf-8?B?aWtvSnRjSDdqVzltV2xid1ZrcWZFaXk3QTVoTnNoV1FWWWtDdnpQb2xyS05N?=
 =?utf-8?B?S0Q4TExNUCtkWGRvZGZjVlBwcnB1TTBERm1jVXJPb2FiM3hGdEthSlR1a1R6?=
 =?utf-8?B?NjZrS011U05xTWJNWnp1ajZIckdtZGJlMnRCdHprTWFzQm5hZHZRU1o3UjlN?=
 =?utf-8?B?RTRnb1NjTVAxcFNjaFUzOHh3dXNnVDlmQUF0a25vUUUyV1R3M045akY0UDB2?=
 =?utf-8?B?RDZnNTJXeXNPbUgyUjNZMXNGVmNhTHNnaVdJUSsyYngrV2pZY3lCUzJQT29Q?=
 =?utf-8?B?TVBJU0hKZFdpRGRnSkRRTHNNZmdlNkNXMERtK244NEFJcE5ocTF2eUQvSDJr?=
 =?utf-8?B?Q1h0NFFHejNvbHJqM0VLMGcrVkY4MkpKU1N2bStDV1pUbkJRZUZKemFhRCtx?=
 =?utf-8?B?WE9Pai9DcHRWZkZNcksrdTVNSGdDVm5yMk1rbzFkTXdEa3ozUmJvOTludXhQ?=
 =?utf-8?B?aXN6bGFHTHBMZ1BtS29EMnpnak9aRHhqYlJmOGdLRk1lWWtCNktDYm85L1ZC?=
 =?utf-8?B?VFNwRWJRQWVZMHFrTEd2RE16QkNZditHOHNveEZ2eEVWczl0dWt2RlRGMVgz?=
 =?utf-8?B?bXJDSWkrc21VbmxJTEtBbDl4cGpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24F3B51AD3C3EC43B28F2CC572949BA5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5UaZb1Y0ZON4ES9RyaaA+qU8p19GRQwMA2ZHzsIi+EsEE3NgDzBqDg7CehiEis7Svns30ehmEr6HH7385o1VGz5DTJRz776NUmsuVPPPAVzG7MOp32xDL3zZzA7wrNsiw3s6gucf+VKzb7+uijhcFcTpQ0VmWO7fBpEuMNAIPfn7v5V9uGEsezcBJho+CVXzCO/eXXD2509pWhfexZo40v7pcELr7MkBtMpGz3UKpExJTdkxDjRQpMgu1DqS7jeT8uDchssHRjQjnKXSiQtbvzRaD/GaOTF8reZMfvpkCDkgbkwAb1Aq/RGGdVliDsPNjRfEZsjZUk8sSdxaltCSDBeGkmKbkdNVCOpq4W4z0FjvSosBj0XeI02VKsEqKAK61DWiyU1nrq22vLrCWDYBn0Yr7XqbxZjk88BxDib22PuMaGGbEZReJWr05Ir2D7WdPzb97/gdvf+KeI0nmVHhm24yDspcw5kPXMXL3YRYFKMzAP4srjTPTCTJ2gtpAbVD4C4lv7ljZYLnn805tYKkF4X1i1rscfLW+omXUQyxzw7IPSyrDOTVDKXedzk+AbhKz7GlG0dNhhElBGx+wT7CqWEhVDReGooCWGttH8MJ2hHVdMD+s/UIc75IAHbEu73S
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b119e024-77ab-45bd-0de9-08dce20bf832
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 11:27:01.5960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nG5MV8f16/Q1eWLjuWgASVUWRGqAlOK2WL7jyhYIsMFHh+ZJnhwrBgqV5aVrjk/loHDbAfx4hXnqQlivvMRD7Xcl+Rd2DlBYcjpvZpNevLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7788

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

