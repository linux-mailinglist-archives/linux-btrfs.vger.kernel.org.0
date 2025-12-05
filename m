Return-Path: <linux-btrfs+bounces-19536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22149CA63FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 07:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA3703064797
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807B26E179;
	Fri,  5 Dec 2025 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p0hdImGR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lPCQr/FF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB526560A
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916784; cv=fail; b=o2WxwAwNcWrrWqNYOUUV2FxLDiSWgdO0h7boLV3vGijverpgy3AALtLMauMso6vSzx/dzKjmoels6AccjBMHIBGDc+P8h4HPKXvq1YMTZaL8+9n/IMbDAIMUR+eslkfiA18tikLN4Hs58VkniGA/YPVT700U+9G4KfMANJVkT20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916784; c=relaxed/simple;
	bh=M8gEqNCNi0LWzlYabMc2A06c1FQk78H2rcIetX4RXD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T9+TBMGig74hEkYwFWlk7uDWoPPBHOC74VPNoI5qZrVLp/rqb6pXrjpwVXm8N+AqsxwqwiD9esM4OT7qc+qICb4FfI93jXME4JEwZSHRhmXk7CbhH1DwoZrcPcTZtKEUgVH7Lq2/V0m6AkJWBiR/9SBGlEUokwplF5ntXBYejvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p0hdImGR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lPCQr/FF; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764916782; x=1796452782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M8gEqNCNi0LWzlYabMc2A06c1FQk78H2rcIetX4RXD0=;
  b=p0hdImGR2TWTratJx91Y7xEKh1MuftvT3NtrzYkD9O/y0UGKBqh2jJJH
   +PZkt+95il/5hHABx7lkzZr16Fq99Ui2ZWFXxHYLV4KRki5LL/mXlvDrx
   Jv/1ndszJihCE6mFvon0ztaNFFhYtZZHrjfKjH9B7RoY2jNluj/mOH7FR
   nsXzYMvEQSBRk/KLxOPiaaGHN+cgE0enuCInghDR4pt9iJRQNJEf6871G
   ferO2A1651+hmo2rFy/pNTavT+ezErIBWBtFrLqr8/xTyHBwEH5mJzXxg
   PNvgGzAm3vkn9vfFbZ5gy6x8uF8c03LeS7bhDjeqjOrIDtwQL9qGAXXll
   A==;
X-CSE-ConnectionGUID: P/8RdPwAR5GKZtDS1bnwsQ==
X-CSE-MsgGUID: n0uaq7hLQ/qQH0iXul6iRg==
X-IronPort-AV: E=Sophos;i="6.20,251,1758556800"; 
   d="scan'208";a="136456889"
Received: from mail-westus3azon11010047.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2025 14:39:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxkuaojKjjmTuOkACKq6uLK1ptcvhEXrkVE9VqiaMLRzgCFmiDeYiY4HO+MmMJn+2TxR2bebZ1qmqL4rl5TCXvFxCZHFKLV/E/6L9GfV4s0C0DdEzOGIQC5jvZuMO1Khq6roKjiH0jgJehIy0+Z9Qf800Y/6UryBzNeDIfUG1GLQf02+dw1Ya4QuvZgYlK76olIqv7Pt/G2QfNbXp4E07UcETot/8b/Whqwt74MOXeEwcrHm+ip0xpK3UVDZZLocP04eZBhRHU+SfPsXQV8XFQGrEov35MY+IsUL7kMs8VEQ1B+F3kd4TTl5wjCVSWGCyk2XDMU7zN2XEdKImW78Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8gEqNCNi0LWzlYabMc2A06c1FQk78H2rcIetX4RXD0=;
 b=w6euaLeGKz0FHPCKT3QtITD72EZFKVvhVOFRiHYfZfhCp2wrEaaCj33WmcGW2lLZ3/TSDJoYcz5AURwehwhQtQPok3kucZ+DN2DhDFzM8LCr8I+Vmmh3tlnXfYO7dm3RLQV3Q4M7eO/OnriAF9UNMqJYo2z6cvmSZn2mxot8RlO29TwIHEtBNUSZ4hcvQFxAAkxiUSS2e/rStztLcASdQ7cZb5dkzLvVRFv3mZe25BYSgS1K6wDPN0uT8VbGdh0rKiQyWZzdgkJx7Xe9cRoc5amP3RD8uo5ygwZqEh9/hNvZaiw4gbFas7hb0b2oAgXLbWkNhm/KXrkhnKrFNxh8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8gEqNCNi0LWzlYabMc2A06c1FQk78H2rcIetX4RXD0=;
 b=lPCQr/FFi0SxcMUN1HOBZTVGyHN4w1BZDc3+Or5cW1xZexJ2ipESb1iqyrGRDcNVKjdNa6xgSFqxlXQZiGANbTiche2zTawcjkPofGxqjmtqxrpL27j00jOc16OXsw1k13QAAYmt+cKHj0efX0hsfIP1tWgqZoQRpLSGPEYGmdw=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SN7PR04MB8530.namprd04.prod.outlook.com (2603:10b6:806:322::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:39:33 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 06:39:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
Thread-Topic: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
Thread-Index: AQHcZRt6NJ0sNq33702Fpi2BYGH0b7USC7+AgACN3QA=
Date: Fri, 5 Dec 2025 06:39:32 +0000
Message-ID: <02f6380c-39d1-4634-b21c-78b81aaacc52@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
 <20251204124227.431678-3-johannes.thumshirn@wdc.com>
 <35a62029-142b-4882-a238-81baf00f5f1f@suse.com>
In-Reply-To: <35a62029-142b-4882-a238-81baf00f5f1f@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SN7PR04MB8530:EE_
x-ms-office365-filtering-correlation-id: b169b85b-2950-4dd1-e98b-08de33c90ce3
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEg1dXZ3U2UwUVc5bFhteFl2Q1dGUC9MNU4zSkx3enE0VW1zVzFTejI3V3RR?=
 =?utf-8?B?dW9XVnRqTVAwTmtHbU5KWFM3cVpUVUhpTlJxRjJHWUdxd2RFTTFqVFZrWCtj?=
 =?utf-8?B?NjJPd29ubERodUxYcE5ZOUZNL2t4b0N6cjdzcVR4NjNjcVBuWnZsUkFvcWJx?=
 =?utf-8?B?QlBicXkwRTljalJYUGMyTG1kM1Q1WWNKK2c2OEVrV2Y4Z0taakZVelVwaGpY?=
 =?utf-8?B?bHI3c3hNblFzUmpjdGF3a2JyQ0JNRzRVRDNkeVhrTkhJOVFDZjVLcWRKdXJm?=
 =?utf-8?B?NUJCQjA0THR1a0hraVJkcFVZanpmZGFTNWQ3ZVBqN3ZWZkhUZVZnMHhBMmxZ?=
 =?utf-8?B?OWtXeVBJeGNZcEFNZk1xYWtSK3V0VUVJZytrN25pY0M1VWpPZ1h6ZEZmdUM0?=
 =?utf-8?B?OC9xY1QvcTJRUVczTUk5TUc3WDVITDJldHlEdFJ3WGJVakpqWHJCK2lnQnlX?=
 =?utf-8?B?VmRoZEpWQi9NdzRjWjJmNXI3ckhYN1hTV01JVm5KNzdZWWxiZ2dsMjhYM29l?=
 =?utf-8?B?TUs2L054enNZZEZudUhqc05QYmFaUkNtcUFHbkZFcERtK3o0UXFIZnY3QmM3?=
 =?utf-8?B?WFVzR3cwZTJlSFZwMmlxenhjenhLQzVZQStSVGpHbDBHQjR6bVJUaHFIRzNW?=
 =?utf-8?B?TFZHZm1IS3hBSm1QZG5SNnlUWVlZbFZ0WGVqZUxwZ1ErVkV1SkZ1dERsQ1ZN?=
 =?utf-8?B?eVpVNTJKVXZjR1FQUHkxbWtEblhCbEkwdlFIczlHTldxQkxNZXkrYzZEbWVp?=
 =?utf-8?B?amlvVjBDdU80cUdNMWx0dXA4NjFzZmdZaFdzM2RNY3ZBT2xndXZoTGxDR25N?=
 =?utf-8?B?dlIwNjdzdzlIWFpaMmNzTHRFWEJsTUdCazJLSTMyaHIrYW1NOURSS2g5WHh4?=
 =?utf-8?B?SDNaTW9wZk42UnNROUFjQlJEWXppL0JmRkFOWERLVytrYmtnOUpGVXEvQXpw?=
 =?utf-8?B?bUJWN0R6S0ltbmJYeExkM2REWmNvelZHK0dSQTZUbmVtdFpXdzZyTWhKbSsz?=
 =?utf-8?B?dkhTNFVZSjg4THVNS0h6Z3hnUHFaekR2UENJZk9kMXlWS0JpZFRlQnl1WDRV?=
 =?utf-8?B?ZkZwUXZtcGo1V1ZpRnh2RmswQ1V2M0VhSG83eS8vbFRrT1Q2ay9NRnc0WG9B?=
 =?utf-8?B?Ky9WVjY0RzVaVFZSUXNzMmhzM2k5SW5xbjdnZEloUTZaVkxwRG9XL2kyMmtw?=
 =?utf-8?B?Qzk5dEdZVk9wb2w5Y2w0eTF6QTEyYTVCMGZVdGJhNm9ldWZEaFBwSk9tR3dh?=
 =?utf-8?B?d05oME5WMXVPYWxJWUdaMGhORUVPdWtkVmg2dFpudTdMR25GZXloazBpbCs2?=
 =?utf-8?B?RE96K20wWXNkbWp2Z0xBRWRTSWFibnFrNWgvMU9UMDcrRlpoaDZyc1lDdTZE?=
 =?utf-8?B?elc0WkdBaFlKMEkyc0xGYnIvenprL2V3SWJKRHc3eGxZL3JEUUN2L0ZSL1VM?=
 =?utf-8?B?UmdzeXNleXB0M1JEYUVQQVFSMlJSa0RCcjFvTHBCRE5hNXhwQnZsZ2hNdy9C?=
 =?utf-8?B?cWIxLzZ2K2I0Q3llL2FqTTBHQ0d2Q3ZTNjhPZXdzZWRBUG16ZWdsRTV3MkZh?=
 =?utf-8?B?eW1MRUhkTkNCNjVXWk5iNHQyRFB2MTNVUmJLWldSRmk3ZzdBTjVnNlRwT2FY?=
 =?utf-8?B?VFpFdlMvWnprMEl0a3kyZTdDVmxLc3VrSG5KQUM3MU91cGEwTmt2bzgzVllP?=
 =?utf-8?B?TFh0SzVHcDZpWUxqUEp5cGJHRG1VMkRRSGJYTFowOEZjOVl6b2xsM3dFdGtF?=
 =?utf-8?B?am9YY0s2WTdQbjE0YWlEWFJtZmlUT3BHVWkxWWZJVDRCT3VMb2ZsSjFBTW1G?=
 =?utf-8?B?c2JYWEczRDdZV0g3VDUxb2ZFa29lUEorTHZNNnZxTnYyVm1hSUdzY3hJRXM5?=
 =?utf-8?B?ck1tNmZ3ajhqUWs1VlowNEFVaUVvODZGZERZcDdCUVN1emtKUXRxM0hYMjdL?=
 =?utf-8?B?bGsvT1g4UjFjbVhjQlVEQjQyQVlzUHV5Q2Rsb0d3QTJYL2ZKUGx0eW5FMTU4?=
 =?utf-8?B?eWU1cVkzWjlFLzZQMlZlaGJGM2xla0pYWnY5Q1RVb3dyQjZweG5maFVSaDFj?=
 =?utf-8?Q?ZYG8MJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWxBM3AyUmJORFA2U2NOOW5ZMFB0bVZIeEM1K0pMTFZQRnpNLy9EM2ozK0Ix?=
 =?utf-8?B?bGMvOXZGVW93MTluV0JodDU4dmFtR0lXU09QQVpUWTJEa052eUlCSDBVRUdl?=
 =?utf-8?B?eEJZUExqak8wWlk3TXpCK1QxQ2NXUUorcW9RbGdodHQxdEtYNEQrSFVBT3FI?=
 =?utf-8?B?SVAxMUZTZThlV013UStHZlpFbGl1NmxIeDVFb0cwVURIc2VBdTBWL21QMURr?=
 =?utf-8?B?VjdDN1BqM3NvcFIzREhPcjdjWFpaSUlUYjJBOGxxSysyTlZIdnVtcERtZEg0?=
 =?utf-8?B?b0p1eXNBd0REV0d5c1BGb2RpU0hvUUJRdE8xd2NYdVdPL0puZ3N4S0tNdkhx?=
 =?utf-8?B?UHd0RWwvUGxGQTdXRUpUd1NUK3AwYTVHRTIydXBJYkc2SnpjenFNc1BnaDFq?=
 =?utf-8?B?WXR6U3gvYUE2MktKalNoL05LVWRQc29PZVhXMzhwTUlXT2lnYkpyYUk2cUNm?=
 =?utf-8?B?MmtOakxXYXBJTHBzMXA2S3NzWFZhcmIyQzRaMXRSK3NYSmdyZDJFd0o0RDVW?=
 =?utf-8?B?MGMwSnV6Q1ZzeDRBOGYvY2pZNnhMZWQ0U2tFNWJXZ0FFWkw5WFVNSFBpdll5?=
 =?utf-8?B?VDBmdEVGdTZ0N1FxS2h5V2ZMcS9iOERxMGFQSTNqbk9nTytzaEk4ZEZOdFhU?=
 =?utf-8?B?ZnpIYnJyUCt2VExObysyamMwcmZiTCsyYWx0QmowMGhGVTAzK1BsV1Y3R0Ry?=
 =?utf-8?B?MHpKQlY2cDJXWU1zaVhtVVI5S2xtTWNxRVRqRWpjSUZBWE12NFBUdVRDck1B?=
 =?utf-8?B?cVFSMnhQcHB6UEtyQmk3ZHoxL0dKNHNHSDdRRDcraDYwNnY1MC9BWHM3ZXFx?=
 =?utf-8?B?YjhsVGhPTFNlcTZrRDZ6Zk1iL0xVenNZb0c3MGtZUXduU043MmRLaStnSjZM?=
 =?utf-8?B?em1YYksvK0pFQWMrZVM5YkEwQ1FFNk9pOEozWmpYT2ZXWXBBb3V5eVR0MGFV?=
 =?utf-8?B?cEN0L29hNVQ1elFvWitaVVhMRUlnaFA3S3ZGUXA5MDU5MjREV3cwWXpIZm9F?=
 =?utf-8?B?UnBYSTc1NFNtQThKL01lNFJKM2I4SVZkMFQ1K0RnZXIwWVlUT24vbDdjdnVo?=
 =?utf-8?B?N0lWNTUwNGo0THVhL0xINDJZRW9RQ0I2TXAxRXhjL1A5RW1TUFVHV3FkTUZM?=
 =?utf-8?B?T3RaRVNMN1VmMUFvaFZaMVJJR3JkeFpZSnIrbHVmL2YzVVJGK1lyclErQVgv?=
 =?utf-8?B?ZkcrT1g3T1EvMGI3OEpySCswdytrMnZvelcvSGlEQkpTdjRaMTY2bC94V0FK?=
 =?utf-8?B?VS9iQ3oyT1M2ay9PUzZZM2Yyb3dlUEJ6azVTdFptb2daQUMwYnkrZ1dvQ3Rq?=
 =?utf-8?B?UTAybGI2TEJuU0p4anc2RldsUFpRMnFzT1V6TTl4WWVOUXI3aFFsUHFVYyt0?=
 =?utf-8?B?WElNZm84Q1lnTWdoRWRUQ1NKMHZ2Z25OWHNic1RTYTBQL2JZenI2ZXlOd0pr?=
 =?utf-8?B?cEhWZEMzN2ZqUXY5ZHFPZ1ZLMVl0MU5VWHpUbzZVQ3Y1dlBvanBNWll6RFI4?=
 =?utf-8?B?blZ6Ulg1K2lIOSt4eGV5Z2xLNkdSL2U3bmEzOFNCNDFUTEJhY1Vka2tid3h3?=
 =?utf-8?B?TnFYRG5Oc0FlcnNiYkRSUUtOR2ppRGNVR2xiTDlhNXU4eHlsK2pSd2VlbUJu?=
 =?utf-8?B?d1Nnd21KMkx4Q1BHUjE1UmR4MFE2Tkh4cXdkWnZ4dUJraFl5TzNGTFJKZGo2?=
 =?utf-8?B?aHA1aW1oUTk4UEk2cUdPVVFiYnJRc1pSdzVGK1ByWlRPYzhRK09xck9WR1Rl?=
 =?utf-8?B?YlMyVDB2NlFNVWM5dkpUNnlNeUJ3c0tYUE0yb0RRVThKQ2F6V0IvS1JrOWtq?=
 =?utf-8?B?T3gyR1ZkQXZNckkzaWpOeVZaSVZoSVcxS3EvUWRKZE9uMlNkMjQ0TExST1dB?=
 =?utf-8?B?UzhDSThOZ3laVFM4OHpGa3llZkVKeFFOU3VTa3NUbUc3ajdlTUV3dkwyalhR?=
 =?utf-8?B?U3ZQUUdYYlJLcWdScm9qbERNOXE3NEwwa2NFMDV2bE9iOHFKc01jVWpHQXVo?=
 =?utf-8?B?eGNMK2I0aHR4bXRYbDA0ZkpnVzMwdFJSbXA2clpiK2ozYURkTDNkVFNOTmhP?=
 =?utf-8?B?V0ZWMlZkMTFSYTJleEsxamI3bzU2UW12dXlhMzg0NUpGdzBRQzUwYkUyVzBx?=
 =?utf-8?B?ZmFFN0lycFJwK2U2cE1wd252QksxYWhTVFdtL1hISFNFM1g5ZFpzNmo5dSth?=
 =?utf-8?B?bWlTdkpURHVmMnV5NjVPOTBDUFZlNlkrV3dmaVZYQmQvcDNQaXovY3UwMTNx?=
 =?utf-8?B?bzA3dHo4UW9tWE5xbTBMMi9tVXdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AD7D4E62174A24986BBF753F39E5931@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/b2pbvOM2a1+iJA3SlGaGjiHNcGoPthrn9l2n8757r3an/xej/UYjGQjywzQSR3/ax0vY8+PNdWS//W/O0zHFtL4YHtBFQNrYOJzDJuVFzXy++MGFCle4gHxobwa8lM+dRb9gaRGDxWk5qDk6R6S6P+VUv5ieKXvWRVW22+PJ8fXxrIaEHJaNVhd0/YKjUtnITmnLGNU01Od/JTuBSseuj79JNn+yLwxOXj8TcCeM84y52Yd8eZU/SS+0pp+LXPl9E62OvbXwPKCJdYz63k6BPjkGDioK1WdLYma5YaEA+JkWDgfKzade+0WJz73PPh3N/8hElFDpiWgEip3YkfYltn5OKpfijsYp9HnqgxnY6riCE5yTeaIx50Nbmec0H0g7JSVWixZx6U+oe9Ir+2YyvuIzvJBM/c7G0dHr5Qbs7tSBCsL/aoCD9/iXUIg3NtxVSeB6jJuYKWi8W8QK0aIjh9VM1EbHeBRFQGa5EYiGZtjBNq+zlm0+KvY+TKa3g1kL2ejOapu6J7OalvPGosNX2Q0o8+xyDmAMpmp2dlMyR+8IbT0MFWaVa27YQaNhj2W3U/9cASehBoSEdv+84MOQzDKLLyBthTcgK0bEAvPZsOuqytu8Q/U0m1WSS4Qv1qU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b169b85b-2950-4dd1-e98b-08de33c90ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 06:39:33.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKfLTRc4nXSO58lJc7ORd6WyZatKZmXrVUs/v211reKzxrPbR93oyzcEjedMUU3Ie+ohMVHM3QVHgENlLUTHXZr1+RjiWNfJv+kT/ycjbXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8530

T24gMTIvNC8yNSAxMToxMiBQTSwgUXUgV2VucnVvIHdyb3RlOg0KPiBVbnNpZ25lZCBpbnQgaXMg
YSBsaXR0bGUgb3ZlcmtpbGxlZCBpbiB0aGlzIGNhc2UuDQo+IFdlIGhhdmUgYXQgbW9zdCA0IGJp
dHMgc28gZmFyLCBidXQgdW5zaWduZWQgaW50IGlzIHUzMi4NCj4NCj4gSSB0aGluayB1c2luZyBi
b29sIGJpdGZpZWxkcyBpcyBtb3JlIHNwYWNlIGVmZmljaWVudCwgYW5kIHRoZSBiaXRmaWVsZHMN
Cj4gbWVtYmVycyBhcmUgYWxsIHNldCB3aXRob3V0IHJhY2UsIGl0IHNob3VsZCBiZSBzYWZlLg0K
Pg0KPiBGdXJ0aGVybW9yZSBJIGFsc28gdHJpZWQgdG8gcmVkdWNlIHRoZSB3aWR0aCBvZiBtaXJy
b3JfbnVtLCB3aXRoIGFsbA0KPiB0aG9zZSB3b3JrIGFuZCBwcm9wZXJseSByZS1vcmRlciB0aGUg
bWVtYmVycywgSSBjYW4gcmVkdWNlIDggYnl0ZXMgZnJvbQ0KPiBidHJmc19iaW86DQo+DQo+ICAg
ICAgICAgICB9IF9fYXR0cmlidXRlX18oKF9fYWxpZ25lZF9fKDgpKSk7ICAgICAgICAgICAgICAg
LyogICAgMTYgICAxMjAgKi8NCj4gICAgICAgICAgIC8qIC0tLSBjYWNoZWxpbmUgMiBib3VuZGFy
eSAoMTI4IGJ5dGVzKSB3YXMgOCBieXRlcyBhZ28gLS0tICovDQo+ICAgICAgICAgICBidHJmc19i
aW9fZW5kX2lvX3QgICAgICAgICBlbmRfaW87ICAgICAgICAgICAgICAgLyogICAxMzYgICAgIDgg
Ki8NCj4gICAgICAgICAgIHZvaWQgKiAgICAgICAgICAgICAgICAgICAgIHByaXZhdGU7ICAgICAg
ICAgICAgICAvKiAgIDE0NCAgICAgOCAqLw0KPiAgICAgICAgICAgYXRvbWljX3QgICAgICAgICAg
ICAgICAgICAgcGVuZGluZ19pb3M7ICAgICAgICAgIC8qICAgMTUyICAgICA0ICovDQo+ICAgICAg
ICAgICB1OCAgICAgICAgICAgICAgICAgICAgICAgICBtaXJyb3JfbnVtOyAgICAgICAgICAgLyog
ICAxNTYgICAgIDEgKi8NCj4gICAgICAgICAgIGJsa19zdGF0dXNfdCAgICAgICAgICAgICAgIHN0
YXR1czsgICAgICAgICAgICAgICAvKiAgIDE1NyAgICAgMSAqLw0KPiAgICAgICAgICAgYm9vbCAg
ICAgICAgICAgICAgICAgICAgICAgY3N1bV9zZWFyY2hfY29tbWl0X3Jvb3Q6MTsgLyogICAxNTg6
DQo+IDAgIDEgKi8NCj4gICAgICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAgIGlzX3Nj
cnViOjE7ICAgICAgICAgICAvKiAgIDE1ODogMSAgMSAqLw0KPiAgICAgICAgICAgYm9vbCAgICAg
ICAgICAgICAgICAgICAgICAgYXN5bmNfY3N1bToxOyAgICAgICAgIC8qICAgMTU4OiAyICAxICov
DQo+DQo+ICAgICAgICAgICAvKiBYWFggNSBiaXRzIGhvbGUsIHRyeSB0byBwYWNrICovDQo+ICAg
ICAgICAgICAvKiBYWFggMSBieXRlIGhvbGUsIHRyeSB0byBwYWNrICovDQo+DQo+ICAgICAgICAg
ICBzdHJ1Y3Qgd29ya19zdHJ1Y3QgICAgICAgICBlbmRfaW9fd29yazsgICAgICAgICAgLyogICAx
NjAgICAgMzIgKi8NCj4gICAgICAgICAgIC8qIC0tLSBjYWNoZWxpbmUgMyBib3VuZGFyeSAoMTky
IGJ5dGVzKSAtLS0gKi8NCj4gICAgICAgICAgIHN0cnVjdCBiaW8gICAgICAgICAgICAgICAgIGJp
byBfX2F0dHJpYnV0ZV9fKChfX2FsaWduZWRfXyg4KSkpOw0KPiAvKiAgIDE5MiAgIDExMiAqLw0K
Pg0KPiAgICAgICAgICAgLyogWFhYIGxhc3Qgc3RydWN0IGhhcyAxIGhvbGUgKi8NCj4NCj4gICAg
ICAgICAgIC8qIHNpemU6IDMwNCwgY2FjaGVsaW5lczogNSwgbWVtYmVyczogMTMgKi8NCj4NCj4g
VGhlIG9sZCBzaXplIGlzIDMxMiwgc28gYSA4IGJ5dGVzIGltcHJvdmVtZW50IG9uIHRoZSBzaXpl
IG9mIGJ0cmZzX2Jpby4NCg0KVGhhdCdzIGRlZmluaXRlbHkgbW9yZSB0aGUga2luZCBvZiBpbXBy
b3ZlbWVudCBleHBlY3RlZCwgY2FuIHlvdSBzZW5kIGEgDQpwYXRjaCBmb3IgaXQ/IE1lYW53aGls
ZSBJJ3ZlIHB1c2hlZCAxLzUgdG8gZm9yLW5leHQuDQoNCg==

