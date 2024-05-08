Return-Path: <linux-btrfs+bounces-4831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D08BFCB4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 13:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83BEB23070
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB284A38;
	Wed,  8 May 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EcywsOEy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="biXtHNYY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBB84055;
	Wed,  8 May 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169222; cv=fail; b=biKVqtMEyCxgSvqoH8e69CqJuT9hOzz2/qO5VKEEJATifk3cliz3d+0VjYlCmEHk3bNYWDpQYeSaK+2b/q/yRQlYjU16p5E0Ln1G5LCxM9qhM9ayl3Fq5Ew8O4EdPzN4PtQo1XOq7TcZUinJIMQKtiDuHkHzZ2lI3wHm1R8qj7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169222; c=relaxed/simple;
	bh=9O8dLpwrDRVczs6GSNyOhzuask5mezu/skn3k3QCnv4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVY8mdJfHONUgNs9Dmh+vfYyEcbTmmyMPkbsz2740dgLL9k0qfZCzPi9ygdICueLHFPegkVxPN4GzGUMuhhirK1b+Qc7kDMPCSZftSwMVzs2eRYD9DP57+GLqyOyzrHZ8iBdRaDAQJWOazkC3Zcd+UJU6xBU51ckAIADjmhuiMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EcywsOEy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=biXtHNYY; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715169220; x=1746705220;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=9O8dLpwrDRVczs6GSNyOhzuask5mezu/skn3k3QCnv4=;
  b=EcywsOEy3o9+l/WgAEnVg9bkSF7knXLapKsYZL7eKZEb4ikSid/WBQMw
   HKemp1ani17avcUF7/n9qgzHBJyu/S4bh5pTTie8QeWfns7G7RkrdcJOX
   vT9IGRvBop/1K7r8k2O7USPnmqtwvFY4mPSwt3etwpxHNvxbl0N9MlbYJ
   P/pSSNL/+gZiVRH7KBDKO2SM/wGbfUw+RtDxymgpcTiZlbDGgOAvSQmkP
   JzeSU7nk1o0nVCMxAp12ngAVtLRX1dcl6tMmPGIGOHraJw7fSziG62+Vz
   cdIZiPZXEdeD0Zhd/xc7RTPIK8coG9rYM58uzM20hmyKgFiFVgwnWLrsB
   w==;
X-CSE-ConnectionGUID: QHrTvG+MSgiWJaHIoGQHcQ==
X-CSE-MsgGUID: eIB6LKMiT8ixB56guG0YSw==
X-IronPort-AV: E=Sophos;i="6.08,145,1712592000"; 
   d="scan'208";a="16100438"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2024 19:53:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2RrXDB8umX7kAPw65oHPcWB8jKdRKW0vxGSXuioRAoKpivHzzE/y4N1UjJYK0d9avRGDcv6OH3kLl3vae9KfigQJsTdq5961eGXv/yfEiFPd7+Y5Tu63XAcNrZnzS1OLzNsMDaaQN1L/U0pQE1VVGdDe1WlDaSg/pKXkv0yDYA5C2pPcDhPN78Kh9Tw3UH9Leo0KKqX5oFG2ktgjs3UwTKHUsleTvua2+XOEa6K4RVAt3cSOWIbaOEsHQr2/HRNYeNf1Pd4bj5UqzAzTnuekxypYOaf/gcAOUuTCiHOxpKnc61WOBjtRqC/CK5UuwF0lavDX22Z+Eo2XMPzVFSzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O8dLpwrDRVczs6GSNyOhzuask5mezu/skn3k3QCnv4=;
 b=Xjx/QJC4FgcHZR7miYV+oKLrrHn18EuGY/c9Fb1KfvoWHLDvi+UlP73Ft467bANAS5Yf289d1uZKrAqReRuuu++zWAFqy35M6v6TqvE/ez3ZcK0lnMecKPBLf3wgtNQpkxxeNaX65jGw9bX1Mlmuc0C9iGI/+RJ4jcKED1KyCBHcx8EIwowtfQNQKxfhmls1dnXBBZfNOHTNqocUd7U/xkiFEY+tfeRbpJfqsaboNNrZ36/XCvnDbMF/Urbz0FMxXBPISEc7TZe8G55jzLOvQNawpBXarIPDCjQabkW8ia46ClSUhGhJ10+gi1zAWXbtyzoSr84UtoR+LJS6Kkeadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O8dLpwrDRVczs6GSNyOhzuask5mezu/skn3k3QCnv4=;
 b=biXtHNYY5vto1/YDRRQYrTViAgg7iFsoTV7nS0FJb3M6v8LRcXii2t3mWEyLn8GHBoaJgBQxfIf1pmvvOF/fjPw7N1vHsPtfcbmHNEX7949BBIaiJRo01Rt70icJVDOBb5iASUOeTKiR7DHJ+s13AiYNVQbl6sf6fWY11GM/vYI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7611.namprd04.prod.outlook.com (2603:10b6:806:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 11:53:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 11:53:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] fstests: mkfs the scratch device if we have missing
 profiles
Thread-Topic: [PATCH] fstests: mkfs the scratch device if we have missing
 profiles
Thread-Index: AQHaoLqabv9qZ69XG0m+Zk8ZIDJDgbGNOzyA
Date: Wed, 8 May 2024 11:53:31 +0000
Message-ID: <06532e4a-6819-471f-ad4e-6caf897e8944@wdc.com>
References:
 <adcf935ecd3d44957ee244b91790ee7b73df134b.1715112528.git.josef@toxicpanda.com>
In-Reply-To:
 <adcf935ecd3d44957ee244b91790ee7b73df134b.1715112528.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7611:EE_
x-ms-office365-filtering-correlation-id: 01987ad7-32e4-45a9-980f-08dc6f557b95
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2w0K2VaamJXeEI1bjJmRkpLUHVOUFovQWY1bWJqdldjWU1NRVBIZmtSZTg0?=
 =?utf-8?B?bi82cHBHRk1HS2Z1Vmc1V0tLbUFIZTJiMzYwSEI5OW13aDVZYWtRdWJFWnYz?=
 =?utf-8?B?d2Flc1FnbnhxU25rUDI2bzM3eFlHT2xQQkl2bzl4eTMyNmpLNFQvWENVS1Bk?=
 =?utf-8?B?MDkzV3kwZk5ucFRvK3c0L1dSWmlQRkZjMjF0dlBEWVFvTzM0ZVQyYmxOR3BI?=
 =?utf-8?B?U29LdXAvL3ZqWWxxRUFobXNNOXZyNWZ1SnJ5VElSQzJoZW1GaUxybnRkOE5u?=
 =?utf-8?B?RnVhRWZPTWZjK25DMUdkeDFVV3RRcTIwOUg1cXBpcTRPSEpWWTdlYUR0c1da?=
 =?utf-8?B?aUVqelQzSVBUWGkxcHl2aW5zeGNRMkN0TXdOUHM2Z0FBK3IrclQzU3hQbU0x?=
 =?utf-8?B?d2tLTkxESkxFaWZZQnIwaUdIcFJHNXhDUk9rOEVncHcwS3NsbWRHUG54bDN6?=
 =?utf-8?B?ZGV5QjdtUWJwZkh6YzFlMkI1Wlh1NTI2WVVVV3h1M1p0Ti94TGJTa2Z3NDRh?=
 =?utf-8?B?Q2crczRiM2RTc1I1M3RJQUUzc2dqMlFIS0s0bmQySEdVMktmZFE5NlNnL1lx?=
 =?utf-8?B?T2gva0lpSUU2TFJyd08xenZMVXNIdUpBR2lCdUY0cFdUWlR3cWVHRE9wZE1X?=
 =?utf-8?B?MlY4b3JtK09iVXVSVmpWZWxtL3JQWGFZem02TnJjNHFhbzh5dFlIQjlkZWor?=
 =?utf-8?B?SXlMMm9nU3RYcU5JZmFXeFZCVUZObStLd2ZiT2pqQkw0aDV0bjM5eGI5Qng1?=
 =?utf-8?B?MVFsMEE0YnFvQ09ndHpJNXdyR1JxZndIYytiRUkrT0x6M0lZRWRjcDRKREhL?=
 =?utf-8?B?bTVNSXh2clowTlBqSSsyL1B0dldRd1EvODdQVFhtY2JXTElkMG9vREgrbUQ0?=
 =?utf-8?B?V1JYU2huU0FjOUQzNzJjelc5ejhjSElmUERBM2cwSXAxU0NEdGwzYzdEM1Ra?=
 =?utf-8?B?UmJDMHk3bmFRRjRTTUpUa0xDcjRGd09laWI3VU44WDF5bGt3VDUrU1ZKd0ly?=
 =?utf-8?B?eFIwcmo0NHJBb0ZOdGx5S2xlQTVXaU5NU0JzNkp3eU9wR1pDTnEzbnQ2eGtV?=
 =?utf-8?B?QXB3dmJTUFNLcVlDQ2NMT2k4ZCt2bFRMQ1pib01IM3pFWGVJNUpmVGp0dFND?=
 =?utf-8?B?T2lXVEhVZ1VBK241cVg5cGt6dHBFdlF2SWVZUXJveERIS1FHZER3UktQNkZa?=
 =?utf-8?B?SFI5WnlHZ0p0ZExGNUJTMVI3ZTlmenFsQ3J2K0NCTFpyRDB0VUx4WXhxOFdh?=
 =?utf-8?B?SStickF4aWVMUnhMSHdkMUVDYTRnbnd5TCtsYVJBUG5zS3Jkc0drSXJHdmI4?=
 =?utf-8?B?bmo2MU9kWXkvZGsrSmMyRVVlUWcyOVVjVm9zWC9RbUIxaVdBcnJzNGtxQWlG?=
 =?utf-8?B?c2szYjYxSnplcEdNL2w0eEhSVitUck9KYWM4K3ZtbENXdzdTVW95N0E1TzNP?=
 =?utf-8?B?dGhHTjluSFRmRkFWS3FJYTU2djJEOW9QTDE1RkhMMGhvcnNaOGpQMU9IcVBx?=
 =?utf-8?B?cFd3SnR1VExCZzZkd3dpdlpyVmJkcEp1cXh1Sk9QSFF1TExHSFkwVXpjUVp3?=
 =?utf-8?B?WFFGclNmdmY0OUlhQ3hYaXZuWVMwWmZrMU9PdUMwc2VxTnRwdGRVQTVBdHFr?=
 =?utf-8?B?UDVkVzVWYWlpQmF2bHhud0EwVVJpL092bHBWRG1pb0JFcUtVNHNIMzRPbk4x?=
 =?utf-8?B?NWVVZytRVENFUW9jWE84aHZ0WVNTS1JlaGE4RDRtbUI0anFxSktOZnM2M2JN?=
 =?utf-8?Q?2a7F3swZVNT0Cur8hMvRSRK9ZSMpJTCEgxxHbYI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3BndDRIeG5VUmN4WnB0bFRhaDNFSkI5S2UrYXp4MUl6SWFraFQrUnZxamZw?=
 =?utf-8?B?SlFuVFl6ZHkrNVZmeDRqK0xzalEzUi9sVmJ6YXBKN1MrcFAwN1RtWitvNllY?=
 =?utf-8?B?WldrOFVkL0tPMWFRalBGWWhaQTJVdmt5NnErQUtSWWZGL0d3WDZIR0gwSkpO?=
 =?utf-8?B?TFMvaEdCbi9VNkg0ZEc3V2YzYW1MNUU4OHBTRlVBUmJXWlYrSkpJTW9kbzdp?=
 =?utf-8?B?OUtVU0cya1RRMmpOZ2wrNGw1OW9oelp6a0NKQlZaMnhKZGZsbFZtdFZBclZZ?=
 =?utf-8?B?WnMvdlFLNVMwZ3FEU2FzK2lmT1EyOEpvbjNadk9UaHk4aGp0UytURDYzODN2?=
 =?utf-8?B?ZEZJVlV5ZllSNXNSTEptTGd5cTEzb2JwWm1sbVFId3lQc1FDNHFWZjlXQjhi?=
 =?utf-8?B?aE4wNy8va05JWG02N09CZGwwYWtwdWU5cENOWm85d1FZellyZ2tXY0JhVE5q?=
 =?utf-8?B?RC9hemNsSVZUM28vTkdzRU0vQkdXUEN3ZEM0NnJPMnV0c3NOSkh1SWpqSXNj?=
 =?utf-8?B?Tlo3aURJcUF6RG9xdDlRbjAxYXMvZWdaRldvZEl0Z1JzWVArUVZrb01UeUxD?=
 =?utf-8?B?ZHJ6YmVqMDJjVFliaWlOZjgyZytCQ2VJK1Vmck1HMVErUXZESEprNng5MGVN?=
 =?utf-8?B?UmZTa2ZFdWhOZXBsamI5NFZwd2JseFRoOHdvK2RBSDVHMUd5OThVVy9OTjBk?=
 =?utf-8?B?bkN1M1llQXEza2tHOUJHM0lIYVpLRXhoZmRsNjVzODNzQVpFcmNYV0NaZXhE?=
 =?utf-8?B?ZjhhbDdWaTkyRGltd1R3VklScUpsdlN2WnhMN3dEcEtNQ3JSbFFUV0FmaVQz?=
 =?utf-8?B?SjFIUklhR3dMZTZpUHVhK0dtai9HNEIvWkxUZlNBY0d0K0VMblVOWnFmR05o?=
 =?utf-8?B?b3A4Mi84Y2Uya05RVTY5NitEbmlKSEgySWxhOVpCZ0VmUFovZGxzWHBPVElE?=
 =?utf-8?B?MTNtMDBjcndGWkhoNU5ZTWRka1lJNTlKMTJyL0YwTEExUTVHZzIvZkg3SnFy?=
 =?utf-8?B?NElWNFFzTFUrcmtKaXRzL1FGZTFJOWI3Wk1yWFNVVmhXUlRZVlZuWWJiQWpD?=
 =?utf-8?B?bktVZDMxb0NaNW9pUU44UlI5UURFdDlUSkNKdjI0NEtQMFk0WkNsTktBZFN6?=
 =?utf-8?B?Wk54L1RiTlR3cVNpNGcwNnhleDE1S0NpM1JTdm5BV1A2VERmSWdnVnBMb2VC?=
 =?utf-8?B?UU40dCt1eUtGdWdaVFR1MW9uUTBxMklCVWl5dWVEVXRNc3BwY3pTWGZUUm40?=
 =?utf-8?B?OTBOQW40cit5Y3p2RmtqYjhPUm9DRWtnZS9lQlZ0UU4xUTlTbE9jOEN1d2lP?=
 =?utf-8?B?Y2RXYXovc0hOMlpsNDlyU3N2N3V4OGNCdDY5MlBMdnhwOXN4czNlZ2IvWjZ2?=
 =?utf-8?B?VWcwS3NML1V0bEFTanVuVTRFY3dieDJmN3RIWmlBcEhWVDR4YWd4TTRIdW45?=
 =?utf-8?B?R3BHaERTSngyamozT0cva0MzMmZFRDBNNUlzcEdqcHE4MXZPd3BpMy9mSHBO?=
 =?utf-8?B?cDhqcm9IVloraEJsU3AwWTY4aWsrSlVsNWNqYk12RWxQZkg2YmMvOGp1N2d4?=
 =?utf-8?B?bWNlWUd3c2x0elpRbmIwUzkzSnUvQ2t2WTNzZmpyRDJwcTdVeFVvUlN1UVM2?=
 =?utf-8?B?WXJkM3RvaFczU0pORllwSUQwbzNXMEgxV0FXeFFYend2UmZ1Z2hoNVNaTlpW?=
 =?utf-8?B?VkkrbzM5NUJSNUMwYmVOWTZQUzlkbXc3THZXQklnRHhERUZidSs1T3R6VzhN?=
 =?utf-8?B?ZDVBNUN1Rzk0N3dUdldlRlVabUVCSUZ6cUNjL1BiNHM0QUFyV2lVczVNN1FE?=
 =?utf-8?B?UXpGcktKaGlVeHZmQVdGQ3RtK1hrQS8zNkhxS2x4dEtjNkVNclJQVE14SVBP?=
 =?utf-8?B?TGkveExsNDMrVzNCeGQ3SG5aSzdiclh6eWVHODhsY3JCL1NiSnVNUnRXWVlK?=
 =?utf-8?B?OWQvaTFwR0VWbmJ3cUFhY2Zmb1RGbmF0MDFHUXVHaGE2UmFxTnNLMHluMEFP?=
 =?utf-8?B?SUYvWlFyTFdJc0p6eDlXZFdRZDJzRzZRa2t5Y1Nad1h4eTUrTS9IWWtWejJr?=
 =?utf-8?B?TDlxNU14Y285U1pObm5sUXhOQXpNVng3d09mekU5a05scWFUejB3YVQra0RT?=
 =?utf-8?B?eDVweVU5MitESnhhUnZYUFYyQkJFeTgrdzViek1NWUY4S1lSVkZCczYyVFBB?=
 =?utf-8?B?M1hrQlBsd1QxM08zeHJCb1dwZGo4VFlLT2VWclYwZjhJbVR0aEdDT1QrYVUx?=
 =?utf-8?B?TU00c3FaN1J0TU0yMzZuVkJDalF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D27D5BC26FE8247947457F15435D49D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RC0NVcSKdvWKRbjr1v4WbHu1IvkFQJG7aT5Xxzb0p4vcT0h/TJ/mCWenQxae1W5W0TYGsbitCOYp3mwojCYJ3+7YuGHSijAF0glQeiXsZMqNBD7lnHvzauU939IRvVfpjk6B2MUbPuGHCjP085/9dkiU4M48g7NYsmakVPHoswW009o/i02Ag/UsgBa9+kZQKadzc3Kccii8zTGTXBqFCz8Y3yvIr4VmQgab5+1Gnyskg6U8fwgOU5HGUa3p+7DzbNZGaZW5bmJMBpF0Ogtjju8uyQvtngulM6bO4cpsn/2xGfi4osnr6TQyrac8FjznngIxTONwnEHJ20jUb4aBmqpmsC4TdC4k7B7ozK1i9ZMRBU4ka9lg+x9vex2iGWoFsp2mWAUHZoZS8YxCsUDyfeHxkaSzdZysms3fvdOjP8fJo2txDzlDrfqg6o/lgIfwH4l6HhcmRl5Ba80UzOqrGLqu6SNJrHSslQF3FbZFB23mkyRS8SZMxhQz7/5XvaLdnSC4+1BwqPp9y26AdcqSkbvPYFTwV2J4iRSWKCmNPOY2q4CRgWnv2SLnh3amaCwn6o8z9x0ek02odWHiRwC36xZF1KneT+J9bsf/BNXPpbtjvHes/p4UrOfvsuDYCYIm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01987ad7-32e4-45a9-980f-08dc6f557b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 11:53:31.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFmucH5Z6OB+9/F9bMZI8asjr6JUj9dpu8T4d7UanT/GnILupOqaYs9tLSHh0B3SDrekIvR9oeKGUplF6DQEI0Uu3lqywJqoBS9iteRmi3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7611

T24gMDcuMDUuMjQgMjI6MTAsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBJIGhhdmUgYSBidHJmcyBj
b25maWcgd2hlcmUgSSBzcGVjaWZpY2FsbHkgZXhjbHVkZSByYWlkNTYgdGVzdGluZywgYW5kDQo+
IHRoaXMgcmVzdWx0ZWQgaW4gYnRyZnMvMDExIGZhaWxpbmcgd2l0aCBhbiBpbmNvbnNpc3RlbnQg
ZmlsZSBzeXN0ZW0uDQo+IFRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZSBsYXN0IHRlc3Qgd2UgcnVu
IGRvZXMgYSBidHJmcyBkZXZpY2UgcmVwbGFjZSBvZg0KPiB0aGUgJFNDUkFUQ0hfREVWLCBsZWF2
aW5nIGl0IHdpdGggbm8gdmFsaWQgZmlsZSBzeXN0ZW0uICBXZSB0aGVuIHNraXANCj4gdGhlIHJl
bWFpbmluZyBwcm9maWxlcyBhbmQgZXhpdCwgYnV0IHRoZW4gd2UgZ28gdG8gY2hlY2sgdGhlIGRl
dmljZSBvbg0KPiAkU0NSQVRDSF9ERVYgYW5kIGl0IGZhaWxzIGJlY2F1c2UgdGhlcmUgaXMgbm8g
ZmlsZSBzeXN0ZW0uDQo+IA0KPiBGaXggdGhpcyB0byByZS1tYWtlIHRoZSBzY3JhdGNoIGRldmlj
ZSBpZiB3ZSBza2lwIGFueSBvZiB0aGUgcmFpZA0KPiBwcm9maWxlcy4gIFRoaXMgb25seSBoYXBw
ZW5zIGluIHRoZSBjYXNlIG9mIHNvbWUgaWRpb3QgdXNlciBjb25maWd1cmluZw0KPiB0aGVpciB0
ZXN0aW5nIGluIGEgc3BlY2lhbCB3YXksIGluIG5vcm1hbCBydW5zIG9mIHRoaXMgdGVzdCB3ZSds
bCBuZXZlcg0KPiByZS1tYWtlIHRoZSBmcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvc2VmIEJh
Y2lrIDxqb3NlZkB0b3hpY3BhbmRhLmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvYnRyZnMvMDExIHwg
NiArKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvYnRyZnMvMDExIGIvdGVzdHMvYnRyZnMvMDExDQo+IGluZGV4IGQ4YjVh
OTc4Li5iOGMxNGYzYiAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvYnRyZnMvMDExDQo+ICsrKyBiL3Rl
c3RzL2J0cmZzLzAxMQ0KPiBAQCAtMjU3LDYgKzI1NywxMiBAQCBmb3IgdCBpbiAiLW0gc2luZ2xl
IC1kIHNpbmdsZToxIG5vIDY0IiBcDQo+ICAgCXdvcmtvdXRfb3B0aW9uPSR7dCMqOn0NCj4gICAJ
aWYgW1sgIiR7X2J0cmZzX3Byb2ZpbGVfY29uZmlnc1tAXX0iID1+ICIke21rZnNfb3B0aW9uLyAt
TX0iKCB8JCkgXV07IHRoZW4NCj4gICAJCXdvcmtvdXQgIiRta2ZzX29wdGlvbiIgJHdvcmtvdXRf
b3B0aW9uDQo+ICsJZWxzZQ0KPiArCQkjIElmIHdlIGhhdmUgbGltaXRlZCB0aGUgcHJvZmlsZSBj
b25maWdzIHdlIGNvdWxkIGxlYXZlDQo+ICsJCSMgJFNDUkFUQ0hfREVWIGluIGFuIGluY29uc2lz
dGVudCBzdGF0ZSAoYmVjYXVzZSBpdCB3YXMNCj4gKwkJIyByZXBsYWNlZCksIHNvIG1rZnMgdGhl
IHNjcmF0Y2ggZGV2aWNlIHRvIG1ha2Ugc3VyZSB3ZSBkb24ndA0KPiArCQkjIHRyaXAgdGhlIGZz
IGNoZWNrIGF0IHRoZSBlbmQuDQo+ICsJCV9zY3JhdGNoX21rZnMgPiAvZGV2L251bGwgMj4mMQ0K
PiAgIAlmaQ0KPiAgIGRvbmUNCj4gICANCg0KTG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hh
bm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpCdHcsIGxvb2tp
bmcgYXQgdGVzdCwgd2UnZCBhbHNvIG5lZWQgdG8gcmVtb3ZlIHRoZSAtTSBta2ZzIG9wdGlvbiBp
biANCmNhc2Ugb2Ygem9uZWQgZGV2aWNlcyBhcyBtaXhlZCBwcm9maWxlcyBhcmVuJ3Qgc3VwcG9y
dGVkIHRoZXJlLg0K

