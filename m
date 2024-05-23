Return-Path: <linux-btrfs+bounces-5247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545598CD058
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 12:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7875BB227C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FA71411C0;
	Thu, 23 May 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ctyhl6Mn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n4raIDn9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8D13D521
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459960; cv=fail; b=iTS6x4MKXtnGAobF54oju+O/bKY7spaYjYh/kykMYv190q8kmhd73qDuAxX8piC3WVg2U/IcErtyLOLumbMWUmVy/PRds1f8EO3BbOLlxKo3rbXuBnoFJmLb72XbLMMZ49MPG/zr1LinLCm/zgqP8OfVNmh9T9ATwxPhbZ7GSTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459960; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gp7v1WaPvryLSXlxPBZlf494XoLtcr6o5QS0Spll77gKbWa5kAU+c8bmPsq2/O5fw8TrZnkgg62FoPcR2tel0KGj6Ph7XGXvDw41YxX1uBDiS3cAGrUZ9lxZnqpXt/4oMliNV1j1RhSrwGPiPZfskDlEAUsF+lhpWBsPzRcjQjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ctyhl6Mn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=n4raIDn9; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716459958; x=1747995958;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Ctyhl6MngnGLkdWf7/OCWzNsI/u0hXu+RjotL+Y/qQc1Sv4xURvaoezG
   wqCDoJ7PFZ2VmWUhIY9WeB6rU+fXk6P56EJoy2HgUeezSioeMaU206mfi
   HHVZ3s+EkmegWVomxRJWHNrYascIbqHaofovksT9CmAo72LAYezOBzJGA
   TDRSOkDUxUnhdRyKO0jIQQ2YAkDz03XXOsWiT93dDUv/m9ws8ajJgBj3g
   /4d7Xz4DDP6ivSxicPxQEKuYj8HQ4oDrNfByXD6GVfKVHN9GDEBryqUuU
   ngh+Dj2AL4zuUO9NsWOT1xF9aJ4cGrWMSV/P9nFL10QU3gvZEIRXXM/sC
   A==;
X-CSE-ConnectionGUID: hMBv4GQuSQW5DehldP+80w==
X-CSE-MsgGUID: 3nZnJR26Tqa4C+AINhsLHQ==
X-IronPort-AV: E=Sophos;i="6.08,182,1712592000"; 
   d="scan'208";a="17053701"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 18:25:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChzBayGtqMXdNQWMqtmO3iKmGePx0gxUWnBeEOUSTxAZ2kfcBrg39Sm6M1M8yaaSRWitiqlzAcZ4J0z58+TIDtJc/4333MqTwDHKEChDzARe2s+pNLzHC3PsIpo5lhc1x2KOWDwkBznMNwGUabEt2EZZYjFckhysOw4kIWfTFhG10t+NUZ9kAnSgOdjUsjaKJ5M6sHt10BjlQrtfT8Ccnik0EWKW5qE170r29eTRIpZOBWg75ysBdjPdG6+G9lwnJNjI/jO9qgu0JpMFw4qCOuaA3i2a3ffYyD2emfu4OgYV7+b5fBthhqBNw3zcTiuY+yJa0brK1UkB9IxAytflPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VhqVNrHkYoFvF+XKHUFhksWMFP5sghKImDp5jLO/4qTljHLLp1NIAUFor+8sDMBRfvMzcSdqxislaN7cliFtKzLJGlnyw3G7PwfPkV4ewWtvxzSbu+m/O1C9fSpOEzjulh9ZGP6WznMkRHemRWNojmZeqh6q1KLJ2yc5GUDeBFgkwSYcfPo2UcQQqCyS37mYmlOcGBkhd7aTQXukfMtIHYn6NG48yqayQPandlVuqkTz6UlpXHyLmSlXR4T3CC4lzC2x60JI83e4N/N6YN/Lm2X1K4v7X+7lLrX1sJe3Huj2FHQ1aAIEXQjOr4ZPlUi88oX90f3w1FnJiSoym2B5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=n4raIDn9DtfbamakVs/knTOyydd7afwZKLz9K5HuhRQ0HFXJNM77tVSAH2M8tPUf5BD+2Zt+wgSh45hxl6r4h1oZs4/4+trtdLF1wJbnd8H6LskDCmGFOQSdYKGxAWPa9NA2bsurjuxJKYtPJ/uZS2UANe7PBY/XfsxE6c76ln0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8612.namprd04.prod.outlook.com (2603:10b6:510:245::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 10:25:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:25:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: move fiemap code into its own file
Thread-Topic: [PATCH] btrfs: move fiemap code into its own file
Thread-Index: AQHarITmwAahEfrkWkahuWwt9ZV4WLGkniaA
Date: Thu, 23 May 2024 10:25:55 +0000
Message-ID: <e63a7136-5a3d-427d-a1c8-cd2f86bc75a7@wdc.com>
References:
 <d7579e89a2926ae126ba42794de3e7c39726f6eb.1716408773.git.fdmanana@suse.com>
In-Reply-To:
 <d7579e89a2926ae126ba42794de3e7c39726f6eb.1716408773.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8612:EE_
x-ms-office365-filtering-correlation-id: b5f6fb7a-f0e0-4e1d-9bbd-08dc7b12bacd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?YW40L2dtZ0dzSVZ5Sk05STFQOTRmN1A1TWlqRXFLdTJ2NS9ZcXV6SEdDb0NU?=
 =?utf-8?B?enhTWHVvRFFyZDkxK0dZZ3NNOWpkcE5YRGJwNVp2REZQRmVocjduNmMrUHVD?=
 =?utf-8?B?dEhKUFVET25WallGSXJFdU14bEFmeERHblBHUk95MU5WbEdjMmI3V2JjU3dz?=
 =?utf-8?B?aXV5djI4LzVKWFB4QzRtS2JHcXdxcEVuUVV4L0ZPSUZ2QS9JVDBGYnFybllX?=
 =?utf-8?B?eGU5ckxtOFNZM0luSjVBMWx3ODBzd1hGNDgwVlRiTERzaW8rUVRPMjRDUE1U?=
 =?utf-8?B?UXd6OEU1Z2JSQWg4SVF3Q1VFR0FaMWVpQVFyalc2RjNoWDY4Zm1tM1dJZ1ph?=
 =?utf-8?B?RUczZitDOXA4SzNZbzUyVy9nZUJmY1RVaHZYMzdUVW9QaGpXU3JhRmk3Qjhp?=
 =?utf-8?B?amozdGpDbW5OVGpuYnkwNlphMHJkYStNOUpoa3FGSDV4akpqOFBBKzNMSG5w?=
 =?utf-8?B?NkZ4SkQ5S0hWcmczS3FlZzJuT2VubDBVVDgwMnB3M29BSVFwb3FMbGcrYlBx?=
 =?utf-8?B?d25QY0pTYXpiT1BlZ3ZTUVVlNUswUmZnY3ZLeWZWUkc1TWVJazh6ZjZjYTUx?=
 =?utf-8?B?MEN6ekFBNEw5NHF1OU1QTVdaRzJKTWlwL2xKRFJJZlo2TkZwODZMVGZubXJR?=
 =?utf-8?B?b2VzNHpOdVA3ckhjaWZNYi9QU1doM3BCRTJEV0xPb3o2a1JVRktTR3dOc29O?=
 =?utf-8?B?NjlxVFNXV1MxRUY3c1R5TlZmck04a3RDNmI2NjlNSkFGZHpwSWttazdDT3Vp?=
 =?utf-8?B?YytrM3FlWG1kU3g2eEt5TTJ3ODJsbkk0aFcrcmljUnlmK3RNZ1RyM0I2MTIr?=
 =?utf-8?B?Yk9FZUNtN3crNkE5c0M4NW9TK2xEdXBBcExSUGpSMFdERG9sZHVZTlVkcHRj?=
 =?utf-8?B?aUdLUUQ1UTR5WlliU2hFd1h5bHZxNFhyZmRBajcrWjlhTm5vWjNzd3lGZzFV?=
 =?utf-8?B?b0Yvb1l2ZHlmKzRlRmkvZDdValNSd0dwZk9wM0l4U0Urbm5nUTBOMUVGb2ts?=
 =?utf-8?B?OXEzbDlCUHUyd3pyWDMrODZ2cysyMndPU09Ha1dsQllONkducDYvL3EzZWUw?=
 =?utf-8?B?cDgxbnBnV1Z3a0MzcnVzWU1sSkV3NjJpNXd5NWxiWGJJUysyOHVFYlZ4RjhT?=
 =?utf-8?B?UmlxT0tnTG9NUG5ITUcrY1Rpd2JCMFR4RlZER2hReUVobVlzVnFROGl6aEhY?=
 =?utf-8?B?cDZSTGtaaHZXT2tPWlUwK2tmNHdDc1VpMGZSK2pjcjBmZFl3NGNKNjk3SHla?=
 =?utf-8?B?M0k0NFdrT0FPN0J2aE5kMTVQWDRkZjk5SVdRelUrMElaYzhoQTdMMVRZNWxB?=
 =?utf-8?B?SnU0K2Z4ZTQxaHhuSDdVRC8xWXczZU1ZdnFmWTdrc1lsTUVDbzRBQ3Vicklv?=
 =?utf-8?B?Myt4RllPbmQxWk9DQWg0d0lteUQyQnV1NjU2UHJDSEVjOFdhanlkTW12UkhU?=
 =?utf-8?B?Z2lYMXk4cEFQd1ZNWW5CZHlJdjVSNEIvTVBTSkZNNnFHZ3hmOG81ek9Hd3By?=
 =?utf-8?B?UWNQeEIyczM0eFVSdWg2VUlWM0ZNTkZmdjhFTFl2b0xEY1JYdkZFeVJ3UDdW?=
 =?utf-8?B?M3hIMlRqVnhZbGZjbXBaYVV6QS9yaVp0bmoyRUM3OWliTzZGV1FkV081UGMz?=
 =?utf-8?B?NElBMTgvVWQ0anZDWit3amI2ZngyeVF6em44ZWEzdkVFODd0OFV5eDdwcTRj?=
 =?utf-8?B?a2NwRnhUT2daVFIvcVY2Tld1MnBnWXcvcjJDS2FaY3lwazY5UzFQZ0R1TEhh?=
 =?utf-8?B?MnU5d3Rvczc1RnNzdUJ4MkRDb0tHS0lMaEpNNkVRV09tTTJ6SXU3SnZqaUVm?=
 =?utf-8?B?eFJBQ3BpeW5hZFVaUGU3UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG5UbU12L0t6Tmt1bFcrNDEyZEJETjZXUVBScmhvRW9GNnFuY2kxU2JjT2xT?=
 =?utf-8?B?cHlzZXhtNzRxT3Q0U2E5MGw4ZnVzdkNaeEIvMmlNMFBnY3lXUGRQODhDOU9K?=
 =?utf-8?B?YnhDNlAvM3djLzdVZDJOWTA4SFhCbWU4WXVGMkV1blFLeU5vaHB1cjh6RzFB?=
 =?utf-8?B?aWpHd2VCbUF3QnlQNDAwbU9qRktucWhFU2l1SGRFaTdHTXloamtFRFRtNU1j?=
 =?utf-8?B?QzJxZEt4K0lFY2RhZ1FLVGNaUGxBTnN4UkxyL24vRXowRUR2NUpGaXBZa2Vp?=
 =?utf-8?B?S3daTUpTakNENWdyWXZmT3B2OHBSNURSaTAxV05YMzd1NTdFQW14aEEzK0gv?=
 =?utf-8?B?d2NmWGJ1VTNZcHFYM3JvQnJiWnlVeS9DQUNKYmw0c3FkNFc0cGpKTlBpdXhz?=
 =?utf-8?B?SS9IVHJWdnoxaExPTG9mVWVlTjVBakd2bGVYZDFGMEJEcUZtRFNPUTh3YkxB?=
 =?utf-8?B?Nklrc090TlVGM0VhU05jUFl6VTJndUk0K0tIYVFXaXI1NWt0cGRJdTFFTTNo?=
 =?utf-8?B?KzM4T29ldDc0TFdESlRYa0JBb3NLMHRNUXYrZHpIVTBQWFZJbjBXaG9XRmY3?=
 =?utf-8?B?SFZ2T1o0RkVnOXlKQzNqT1lWcEhteGtwZE9Kd2N4b3UydWhWMnUraEoxOHhQ?=
 =?utf-8?B?VUs1QnB4NmMxU2JoanFnY01UMzZIRnRoVkhTZzhuMG9xdFAvQzUvUVJSSy9y?=
 =?utf-8?B?Q0sxQnhPMUZLOFRDallzZUFvVFRZcCs1bVR1dnFlNlFpeXFYM1FTOWVpVUFR?=
 =?utf-8?B?N0J0a3grSVRXb1hBU1V3Q09odHpJd2l6bDdYTExLOE1nWE5OZ0IzUHh1STh3?=
 =?utf-8?B?bFRNeHZwQml2NFNxN2ZTYUZKK2dkVmJOWFNrL0dsRUNua09ESWRkQytrTitv?=
 =?utf-8?B?UE0yQmtJSy9QdCtWNmpyRS9MUUFnZ2cvR0hnQ1JNc1lRcEpTR3RKOEdZS2sv?=
 =?utf-8?B?a25TMW4vd1VzaHFpUDNJSS9iOFU2emFjRlpuN2YrN2k1TXFGMW1iNHc3VzJF?=
 =?utf-8?B?M0tXdlhaQjJGMCthVXk4dDJXdlE5eUZ5eC9teGJmRmtSd2xTRUxQV3R4bG92?=
 =?utf-8?B?YzFwTjc0cmhhOS8xcmtrM2lSODNUMGJpeHJqTnQwdE5yNkQxdGtBTXFkbWFD?=
 =?utf-8?B?Z3J0d0c3byt0QXBLUXd6OTYzcVM1TE1wSHpjTkpXV2hKbWZTYWdCR1NrYU0r?=
 =?utf-8?B?bjhrMUlJN3BsTTRrUVlLTXhkYkFJOTNUK1Z1cGlpRWt1SHZZR2JseGl5SUNz?=
 =?utf-8?B?RWN0S2gwTTE2cElKa3V3bVhtVmNrK3BkYzVCSWhiZVd4SCt0U0poNndiaWJF?=
 =?utf-8?B?cnMzMG9UR1R5OTNmbHVSelJyNU9xd3dGSnpaMmlaNGRkcWZySnVWckhjK01U?=
 =?utf-8?B?anhkajBJU3V1NmgwZ3U2dStpR1VsNHFPb2xpbC8wT0hlV2I2U0dNWEZOZElD?=
 =?utf-8?B?MFhDNlhXWFZIeVR1OGErUWJiNEdOSlVYM3BrRElTOG13V25RcFg2Sk9QdE8r?=
 =?utf-8?B?aTVZYlA5ajh4TEFyWWkrM1lmR3A3RkFzWVRMclhVckZ0NmtxcmRma0tGSjNW?=
 =?utf-8?B?VGR1NjRZcnpjbnFPcnI0blBMVVRjZ1d6OTEwREgzMEJBMHU5SUgrcjBrekZ4?=
 =?utf-8?B?UGQ0Z2ZLYlVydnZtWHA1V1RBODBUeDd4NUVrOVFIMnZpRW1ERzF6SGhjT0V4?=
 =?utf-8?B?MW1rMEdzeXRabXpTVGdTVFBqcTdmamdoNE05UkpxTkRDR3lhTUJPYkhVR3dl?=
 =?utf-8?B?YzliQ2ZQbTFUblBpdkZobjVOQ25MaDFqamlGWkk3Rzdhc25seTdjMlZ1cEdP?=
 =?utf-8?B?d0d0R29aNjNybjNqNEdzK05hVjJmU3NLQ1FNS2xLblprRGs0L3hXdm9LaE1a?=
 =?utf-8?B?NlhyTG1NdklMT2UzNnc2OGgrb09pL2NEVEw0NGd6UW9ISytOWndET1dzaUpN?=
 =?utf-8?B?VG82Z2dnU0ovVGIwV2VHWlNZVndqNW9tTkY3aDN5MGRuamswL29seEt1bW0w?=
 =?utf-8?B?UHlkRWMzSFVNcTlsaUJ4R2RZZGd5R1h2bG0rNkd1KzlDZmgrVXV0WnJGY1J6?=
 =?utf-8?B?QXorRFk0VlRmSkV3UkdvdWpTYk5RbVBjc1JtVHR4a0I5T202bzIvY2xhT1dP?=
 =?utf-8?B?RHRCS3czaWtFSTdZYzVkeWR4cDc1S0gvME1xb0JvSmo4QWRkaGxOdldQZzJi?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AB73A81C92C8A4E97995F3A63C666ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M91R8Obw9VcusOxoXJJCkB2fYdPp4UFji49U/Y6TO8QRFcpxQNV3S4gO1bQuZ2OVM/U5i2UW6XGmvvBu+dYRA4n8cQMvKVJuQImdsEb7WLK7f4Yvbwg8Qlz0NhPtl+Twue3iRu2ZPlWcESSIYFfFqRHraE7jyLZZcr3GJ4yrxSNus/aOsCtdQvr8ZDjCme6/SAnf74Rvxr903lrVvZmpSK4blCxINLk9Q5udKxXUS19p9iwHQCXdMffPeaoRsIWKcT25dCDkQAPZ70qRUfFZEdkawq+SogEWZfV3iwOWyrWtQQgAMznlWrUMO3a2xvzYaWXM9qoE2NH1EcJg5AHWC07kfopheDwktVd9Rda3ij18u3hfsoKQHfq4ioBg6CLtlEnF7i8BEGhA5oAzsIE3qP+M0y5AvvYpmeuvGTKpfQm4hjCF9tTz3y8Y75xQmoJSW7oXjvDhaKDm2jNmbDvIpO2ajbLfHUCVomig77rJncBpRTdh2lo42uyRVCCQKJjiGMNOQs38gHsbVmeXov/stju0hFYOb77WC51oQ4/arBxUK5NGGGkiHEYrrc4So3hsiuuiJuQYKpLJcyTMRM9EmIWEsteI2ZgtDY/oglvIl7fsyMcJAvmxvx3brJvFNfrU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f6fb7a-f0e0-4e1d-9bbd-08dc7b12bacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 10:25:55.2920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w26m/2otYc9Nrlv8TrmBbND1ds+0A7kJnMi8RU+QoPEdXDUFk7QQ565klRYLT6OpqMZZo3e13BNgsD5izI2+Y+mWym1yQByF7i/PSZ6452c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8612

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

