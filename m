Return-Path: <linux-btrfs+bounces-14639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB798AD854D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 10:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7160D1E06F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 08:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C722424C;
	Fri, 13 Jun 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I3sQoa6N";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wMcHT1AU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B922DA752
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749802478; cv=fail; b=Q039aiwxI/oz6RtM7sFgr9PeJP2UgxqTgBUCEYTJKJGjmomYoAxlXC+upchfjLiHtbg0l5s1mF4CkHIkeOVrZhsYQjjeDzWgK/qc01KBKQFOgLVJYCL1pqq5WjexTggtzCFMQ8vxaVgbVusHGgOM2HyZoe8uG+8uvcfHZpPEjrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749802478; c=relaxed/simple;
	bh=uWlDggxw4/4EXKAXQBuMS958OszmtFR94XiyrsUBG6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iNLf7td7k67h92EfllyvzLpHS4NPPV0e++ZDNDrjv3/Z2x156Em5rNmTngyWXe1fOOW+/ChP2fyzZqBZtPva6Ebb6auOBumN+XWpz9CYHWON7QUcKuZIMLfx+yUQNJjY3+sXNNdEO5/S1zOfUCN4VdaVsoApcRsfJGUuF3vyyk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I3sQoa6N; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wMcHT1AU; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749802476; x=1781338476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uWlDggxw4/4EXKAXQBuMS958OszmtFR94XiyrsUBG6M=;
  b=I3sQoa6NxaMdH7ZwJAdHokLyWO5smIQKzOZWDlDkaYMKacdgW/3nu4mD
   UD4/vWhB+DD3VuVTSoOQ+AF+h/7fc0P7z4JugJusmpoKQgcK0NDoef3d+
   9HdRxeBSkGQk4Kh/cfUwU6It9Rb4gPuHnOSHtZlhde2c/Pv+k0S8wbjlD
   xyXtAHmB6ax9P+6cfRxUtlaC5SCuyfmEQSncNo4ij8q1xYx1sO0eIAMxy
   hts+TJmJipW4wXQ3OCXRUX70eV8ItKebF58kync68/QWv5EqSxyqXDpLS
   ksmUJyeai6wwvkwll9j75i3yy+xXCaMjK5nbHfmiu7X85L/BiOn/YQJva
   A==;
X-CSE-ConnectionGUID: cGv1K5Q0QE+jaHO3cStzlQ==
X-CSE-MsgGUID: aHrJdtUQSz+X/9Gtj8oxeg==
X-IronPort-AV: E=Sophos;i="6.16,233,1744041600"; 
   d="scan'208";a="89431288"
Received: from mail-dm3nam02on2083.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.83])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 16:14:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auiW0GFaAxWjmIPEg3NObqr/agOZ1vOAJdaKQ2qwmN1OhFuAHeRShHEb+83dYDwMJMEMGfSTleFnXe7AjFlH1Qytti5CY8p4T0wI4zu7QBNzsdcDQR0vxoFwOAHzN3n5tnTssL9JRQO/PJUYb1fsSH68aLnKUV0rpJR4X+Gh1LDe4IYjyQq24uW2edocnRRHlufZIoVFh5gM6sZA77ir72T+xJlY9dNoybcELACgrZJsLrqy93gAbe0Nwb1FpoihxvfRmxPmVMDYHOQuExhwSaj8bddfWf11lPJshih7BdRVI7vtf2jZ96Rp3L6kohze2Y9kHlRzfPl1sDWV6UmQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWlDggxw4/4EXKAXQBuMS958OszmtFR94XiyrsUBG6M=;
 b=n8ubYlsV7jC8yA3BO9gzAOYONi8x71mGMIQzdocl364drz27bxgrzrNfYF9dxMMsb2sGtb+P7emlOWPNxroA4OMWvPhOOsZ/xRXx1NZ4GgGoLIE6rWipR1Ufb9LIzRSGl5KU/pT2P36cSbFOYg9nHD2ailGiWaS6+Pc4I0oVe+onpiRzHJSfqL7aIQWRtPaz5Dr9n7xYzRyofO+Iwl2lTDpldnV1KFxZselFyUvGN0vE8DU0KGT8pnUbX+T1sWB126pA4TchGpxojOLijVvlznLB1bGhWI/YYofx0kYpbZqxPc+mb5anb5H2hy/Iqt2GRhHhGRsgPZBm2SQZUEY9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWlDggxw4/4EXKAXQBuMS958OszmtFR94XiyrsUBG6M=;
 b=wMcHT1AUpCg2HLj4ngBjMZm7HEHIr/pox6DBUT8Cq51T1wU7ZMBosgZrMG87s+/+8vFYw5b6+kqDXtrtn28v+Ha17KbxCgqkDS1mLZck0+i38JBXn8JufSnnNj1mgVh8h9SeyZqskYjO+6adVs+z8+q2Nh7UyaURb60QuPh2NG8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB8620.namprd04.prod.outlook.com (2603:10b6:8:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Fri, 13 Jun
 2025 08:14:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 08:14:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, hch <hch@lst.de>, Qu Wenruo
	<quwenruo.btrfs@gmx.com>
CC: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Boris Burkov <boris@bur.io>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
Thread-Topic: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
Thread-Index:
 AQHb2rgQj+GAUrOINUqOaqTVAHdL07P+f/yAgAAEx4CAAO0pgIAAqU6AgAB/8QCAACIVgIAAA6mA
Date: Fri, 13 Jun 2025 08:14:26 +0000
Message-ID: <87cd340c-64a6-4eaa-8011-f50aeebfce9a@wdc.com>
References: <20250611100303.110311-1-jth@kernel.org>
 <9093e0d6-d33e-4c4b-814f-9134d568f395@suse.com>
 <69982e5e-96d3-4e60-891c-ade4474253cc@suse.com>
 <1618ecb3-2bc5-4c48-89d5-ba1c9ec788b3@wdc.com>
 <01b0f70f-c131-4b79-a997-7317176d6269@gmx.com> <20250613055920.GA9176@lst.de>
 <862c5dbb-b8ad-4f79-9d0d-901bbedac977@suse.com>
In-Reply-To: <862c5dbb-b8ad-4f79-9d0d-901bbedac977@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB8620:EE_
x-ms-office365-filtering-correlation-id: 25f514ee-28c2-49ed-52fe-08ddaa525001
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnFlNzlEM0Yzald1bk9Sb2J5K253YzNaMWc1U2N6TVR2Q0tVSjhJR09VTVND?=
 =?utf-8?B?SkVKWjJrakxEeFBEbENaZGhVc1c4cmpza1MrYm1uRS83b1N6ekttUGo5ZWdI?=
 =?utf-8?B?SXY2TTYvdFNIRmVxcXZub2w0dmlDS1ZYcnNVUHRYSlJnZk9uNTJWQitXL3Y3?=
 =?utf-8?B?TzBEem1oRWt4elU3eTFZTm5GWjV3SXA1N3U4TkJIUENRV3dySTh2TVB1VUxO?=
 =?utf-8?B?NTMyY0lPY0hveWZ6WXZsV0RWYndPanNpNE51T3E0MlVtaCtYa1U2NFVlVlk4?=
 =?utf-8?B?ejF0SHo2TmFPU3VQb2xBOWF0bEw4YXFpSUpMeHE0SUlJcW9zT3NaaU1QeVJu?=
 =?utf-8?B?U2FjWndKaDlxRnYrVHRISlBQYkxJbzYwRWZHdEVDbWhROUVpVndoMjdZTE5I?=
 =?utf-8?B?c0Y5YmorRUFwQlZocU1jMjFZRCtyWUFVUGFpMDhvbWUzUUpqaEJNTEIrWFhQ?=
 =?utf-8?B?NGRZNFVOMEhNbVZDTjV5UE1BYysxZTVaVnNHNW40TWFjQjBzR08yVXJ0NkxP?=
 =?utf-8?B?ampyZS9wd3grQTk2djJlSnAycEtKN3V1WlZPU3A1d2NnUFZvMGN2Vm1uTG9n?=
 =?utf-8?B?dW9Pd1B1enVrblA2eEI1WHVwaXNRTG1FTm0rTmpBQTVrS2U4RElSMVpEdEJo?=
 =?utf-8?B?WG1PdXNyN0FaODNRM2tETEZCakpqSHdqT2l1OVNGUDRHdi9WdHlGaGhQZVg5?=
 =?utf-8?B?S0tCTnYwejJpRThGaGJKaWdjL0RaemFNYkUyZW8vVlpKenFPRXFkMnR1aG5T?=
 =?utf-8?B?TTZkQmp3Y2lZS0E2Z2VTZXJhWVZIeXBjdGdxVDJYeVA0MmdaM2p0WSt5VXF1?=
 =?utf-8?B?c0ZTU3JZVjFLQ044VmpHRmpudmVkb2dZMDE2N2JjZUhXUlQyenNrV2dQT3pt?=
 =?utf-8?B?TTBpRjEzRGp3aWgrYUR5Z0F5MFV4Qjduc3RnNldSUldINVcyWlVFNzM5eXhu?=
 =?utf-8?B?dlVDd0ZBbklERFBXakRnc2dTSFZkcDlxcHB2VmJmUU5QSFl4NnhZYTNRRUVV?=
 =?utf-8?B?KzZTNUZHRXlqdUpSQUFFa0htRFoyZUxLWElUbGhKRlBsSVp0NXJqeWJ4RjNq?=
 =?utf-8?B?aHh6QS9uYkFYRjg5N0w2T2FvSDF5OWkzS2hyUy90Qy9ibXR6U0MyTzBFOG8v?=
 =?utf-8?B?RFYrVDdNcmRUbzZNNVlJU3ZkT0NjaWZMTEVqZDZudGhxVWJ6MnBYSXdjNHlM?=
 =?utf-8?B?eW40Q3ZmdkUwVFhpbVlYMFFEN2srNytsRUUrbHVIMS9KdUd2Wk9TemhSZ3Nn?=
 =?utf-8?B?ZFYvSXJOQTlNTVZkU0YxeVNsRFlWQkZIQy9xR0crdHVrZEk0T1Q1OGxvNGVW?=
 =?utf-8?B?MjZhb1BSZjZ2YkViWGNDQUZEYnVMMWh4MFgwTlppZmRqbmVkeDJMeHpQYnNG?=
 =?utf-8?B?cGE3cVVXdm9nZ1VLdUFTTmU1L2pvZ1laY0l0RURJK0FLMG9neG5rMDhzendt?=
 =?utf-8?B?d2lGSzJSZU5UaU1Tc3ZUcVp6Q0hsV3JjNTZDRkFTYjN0MVk3UVp4eVJFNkxH?=
 =?utf-8?B?U0loSndMQVFHZzJ5ak8rUDZtbCswaEVCN084MHc2cHZSbEF4bXYzMUY3YTZE?=
 =?utf-8?B?VVV0cEVTa0FkSGlSVkVVVG93UGNGMTRkaFMwYThNckhFUlI1ZDVGMi9WWUtH?=
 =?utf-8?B?b0RSQ01lQ0FsYm5LM2paV3hCRXNqQVk2TURGd2tMQTdWUGJtdnc0bnBlZ0NR?=
 =?utf-8?B?c01XMitLKzRvcXBBVkxRRU1nSzdkb0F6WmRFL3JMWEJFdTR1RzAySitoTlpL?=
 =?utf-8?B?Zld6Yzc2d09FWDJYcFlsMzVxUUhmWitkWVhkRXBwbm9IdlBaWW41RVA1Z21p?=
 =?utf-8?B?REdwOU9nSGVpQ2U5TXRnc3B2UlZTS0RVeUJDTlJVUTVZVUZpYzJnbnUrTFVa?=
 =?utf-8?B?cjd2WktIVkJGVVc0dkhyUm5wbDVXOEM5dENZbXluek44NHR2RkJWWnprdUlq?=
 =?utf-8?B?UG5UUmRxa1JFV0picElkdlFNdm9hTzFBT1grNXVGR2s5ZnZRUndwY2VyNFBm?=
 =?utf-8?Q?SX6oCZM8RJI2FxOmg21yiKu2qa47PA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0d6RlVJc3pySFNHSUxKVjhmUk1mMlp3b2tYSVFmWDRldlpuVmVWWFlURkpn?=
 =?utf-8?B?WVE5YmJlQXhTSU82ak40V1BrSmpKenBFWWs2R29GeVNYUERQcHZsWjZkY210?=
 =?utf-8?B?d2tNWXR5NXBTUFQ3Qy9nT3BLb1hCaVpuWk45T1EvNTBNRTRnZU9SYjMxOGF5?=
 =?utf-8?B?cXd2L2FDQTBoUGJMbjVLN3lscjNiclRIQlh3VGcrSW44U1NtQzAyQXhPcnVR?=
 =?utf-8?B?VXRuaUtaOE5mVlptRTBKa3JEa1BGVmpVekhBeHJoRlkxbUVDVm5oUk1VSTZw?=
 =?utf-8?B?anRhb0xjRGtMYWtXUk55QU5EcFVaSTRPaHJLaW5uSWZFRTVlRkErcnB3Rk1O?=
 =?utf-8?B?RjNtZnhMeFRBOW93V242aFE2amlyaTAvdHd3VkVZdmpNNHFsVnlJOWFpVkp6?=
 =?utf-8?B?NldTUXhmSFNCUGl1cUQzYkZxVHFYMmZaV2NyWGdDOEoxc0pmMkx6elliYXdi?=
 =?utf-8?B?dUswSWVhTWVHeHF5T0ZQNWtNbGQ5bnI0SU1oWXB5SXFMNTEyR0hUWVByVWpI?=
 =?utf-8?B?UCtQVU5FNHJXZEtza0NjdmVkWU1tdHFINlhoK0t0M1BXaC8vUE9PS2RKNmVy?=
 =?utf-8?B?M0VBdXVRU3MrR3l6ZVBUMkNCTDlMSXBlNG5kMGNMMURHampjNGpNZ2g1RG00?=
 =?utf-8?B?OENDK3g0OTBza25CSnB3MGNET2F2L25SQ0w1M3piLzdtNy9uSS9ESGU4VllZ?=
 =?utf-8?B?ajRqWFlLVTZ0NGV1Ty9xdk5TRW40M040aXpOTDdvR0lKb0tkNnE2Q0ZxSHFa?=
 =?utf-8?B?L0JyOTJ3YlhITDFEM3ZVdExqNDU4MFpCblJ4Q1JUbFQwNitjcGlaQm1MQTFC?=
 =?utf-8?B?S0YvcEh2M04wTmVOVyttZjN5aEJRWG1JU0p4enJZbWNpQUFnTnZSN0VRQ3E2?=
 =?utf-8?B?Z21UYkI3c00yYjRkOEpYaXlqMGp6cEJhL2JMbGs4VkpuK1htYys1VXJ2dXVo?=
 =?utf-8?B?b2xOUXNLMU0veEFhMkpGbTV6WTRhdDBnTzJ4ZGhZbHArSFdyRUZNandUaWVi?=
 =?utf-8?B?YmdkWUgvMnVGZHoyUWE0azVTNGtheE5yV0hyTGwrTnFWNWRMWEo3S3k5UFFD?=
 =?utf-8?B?bnNBYjZmSUZxSW5maC9rMGYrNjdsZFRSL1BXN05makdDTVNLYWx3Ui9jZGhR?=
 =?utf-8?B?MVBKTGlxRnJGWWhWV3lQVDNlVkVmZVJ6ZndLRDNubyt4ZVZTQXRBVGIyVFcy?=
 =?utf-8?B?MmRDRjRlNWVJRVQ5WXlnQjc2aDQyclZTM0FUZVhtUlZYWWwyVHgrdnI1elpo?=
 =?utf-8?B?dDRhTmxLanRuNWw1ZmNKdnIzOUZrOGFhS0tORU13L3pPNEJYWFlMd09La0hS?=
 =?utf-8?B?bzZ5bGk5L3hvWk9pUk5xSDRtdnBRY0pmazIzWXdSMnEwTzBHR0pNMHFDaEpn?=
 =?utf-8?B?NjBYSHJsWDFYdHZ3U0REYm5QcVYvYWhaeXVzb3pUVStSOWE2QmZEVWRhZGVJ?=
 =?utf-8?B?M29KM3IzV1AvYlplMDBKZ2xRRVUrbWpqR1VMMkhSd2tuQU4zMUtLYTNNTVhP?=
 =?utf-8?B?QWtpelVzYjZ2N0o3V1orTzgzZG9sMTF1bjNvNGs5VWo1NFg0K0JUMVFxei9j?=
 =?utf-8?B?SEJ6MExEVGh6Uk9CODRwK3hiUTlUYi94OVFuT2hoWEhLblF4NkZ3amRlQUR2?=
 =?utf-8?B?enpGbG56cE5IZURyU3pWbUIzK3dOb1BtS0M4bkJ6Q1dBRitxamV3NURFeTF2?=
 =?utf-8?B?aG1yWUtiazBNekY5NTdhUmFJbjhVZTdSYkV1L1dtRC9XOGRkM01wRHVOS1p2?=
 =?utf-8?B?QVNMZ2ltTDVyMlBTSTYzb3pQYU8vdVplYXZ2K0RiUW12ZUpSZWMvbjJSTlNQ?=
 =?utf-8?B?QTlvUGV6MDlOcGNuSmo2QU45V0t2MGhTdHpXMi9laTYxQXdubEEvNjJrSDUy?=
 =?utf-8?B?MUFLemRqTitSYnJ0UFduNnpLb3NueDlScVhDSTk4ekhzQkVESHNvU2pBN3dQ?=
 =?utf-8?B?MFA0c1dzaXJ1TmtqSHlTaTYwVnY5NXJFNGZsd2wvZjNoLzVnOVROdnFFOGsw?=
 =?utf-8?B?NzE0ak8xVDZKcWZXdEp3Wmo2SDFEaG04Z3FnN2x5aFgrZmtzWmRJeHFjZUp2?=
 =?utf-8?B?L3dBUHBSWFdRd2dzSUdVZ2VWNEdhaml1VDJpSkJ5Um1JSGlSZE1pQ2sycW81?=
 =?utf-8?B?U1JSRFZ6VkIvRUttUE94bHlIdlRDZTc1allLRCtqMExKMTJtSVluSSt3dlF4?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39065FBD0F1A2D4E8198E0A1B21E61A4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uKKeaivZhHy1324TPmdz1wUWpbb1+w7bCE1NbfYilBLk7KxFq06wzjbLJd2pk3vJeBKndi3/o81Wj39azZ7i2B8SWBjmXl8KHhPHFDUOaZ5+mjKfy7WuLmwWNam+UhAbqh58l8jaTvWhKMfS1FcJvtuc6gh7qAvCpfCOm9LlEffHpNkFGfTqpHrauiPzlklwtatx2rqt5GSV2YuO1l5EwWanCGhCakOHGfEsvU9JDM/ZMxS0a4SV0WK1Y44pMIRQBDe5li+lKbaG1AxH6ckn9nXnclH0/mdC6D9WRuXyHCShT5Zwl42y1YBbAaCl4dm6krAtyFhjS5karr72s99u9Jby+qjpKFvXA+VjE9TTBXQCaONTvPusqWYuFuvFdx3n6D3+mTS3QLMAjfCaPPTrI/5R+CGjwSlLa2M7FtQtR0+KH6bqZvBnj9rMroXI3zk8MMcq9WuUnM8pYTpKw1RkIXmJVyaOrVIAZ+wyQj3dcVgNugApIckmWxcQQFYsvhdyb3T7TusDnnJDTs1K2VXLVp7+yg2uLiTsr2ObXNmX2Y3cXbgaAyVX9bTwU0HtRptcPf6RWBGLoobdOZcO3JJy9FE9550Jl12TX+OPzyeH5qcVzAFv2Upk2GOligFgscBu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f514ee-28c2-49ed-52fe-08ddaa525001
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 08:14:26.2703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YVAqUYQydYuYx5pdZpiHAXc9luv+0FdXulRU11ZGL3swAdOjH91DQR7OlnHEs3XaFWsgI/N0ArhxUWEw45wrikBlG9Lz2eXlnUZdPudxpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8620

T24gMTMuMDYuMjUgMTA6MDEsIFF1IFdlbnJ1byB3cm90ZToNCj4gVGhhdCdzIHRvdGFsbHkgZmlu
ZS4NCj4gDQo+IEFuZCBzaW5jZSBJJ20gYWxyZWFkeSB3b3JraW5nIG9uIHRoZSBzdXJyb3VuZGlu
ZyBjb2RlLCBJJ2xsIGRlZmluaXRlbHkNCj4gbWFrZSB0aGUgaW52b2x2ZWQgY29kZSBlYXNpZXIg
dG8gcmVhZC4NCj4gDQo+Pg0KPj4gSSB0aGluayB0aGUgcGFydHMgb2YgdGhlIHNlcmllcyB0aGF0
IGFyZSB2YWx1ZWFibGUgYXMgaXMgYXJlIHRoZQ0KPj4gIm9wZW4gcmVhZC1vbmx5IGZvciBzY2Fu
bmluZyIgYW5kIHNwbGl0IHRoZSBpbnVzZSBjb3VudGVyIGJpdHMsDQo+PiB3aGljaCBhcmUgcHJl
dHR5IG9idmlvdXMuICBFdmVyeXRoaW5nIGVsc2UgbWlnaHQgbmVlZCBhIG1vcmUgb3IgbGVzcw0K
Pj4gYmlnIHJlZG8gd2l0aCBhbGwgdGhlIHN1cnJvdW5kaW5nIGNoYW5nZXMuDQo+Pg0KPiANCj4g
QW5kIHRoZSAib3BlbiBibG9jayBkZXZpY2VzIGFmdGVyIHN1cGVyIGJsb2NrIGNyZWF0aW9uIiBw
YXRjaC4NCj4gDQo+IEl0J3MgdGhlIGV4aXN0aW5nIGNvZGUgbWFraW5nIHRoZSBzYiBjcmVhdGlv
biB3YXkgaGFyZGVyIHRvIGdyYXNwLg0KPiANCj4gV2l0aCB0aGF0IGltcHJvdmVkLCB0aGUgYmVu
ZWZpdCBvZiBkZWxheWluZyBkZXZpY2Ugb3BlbiBzaG91bGQgYmUgdmVyeQ0KPiBvYnZpb3VzLg0K
PiANCj4gSWYgSm9oYW5uZXMgaXMgZmluZSwgSSBjYW4gaW50ZWdyYXRlIHRob3NlIHBhdGNoZXMg
aW50byBteSB1cGNvbWluZw0KPiBnZXRfdHJlZSBjbGVhbnVwLg0KDQpTdXJlLCBnbyBmb3IgaXQu
DQo=

