Return-Path: <linux-btrfs+bounces-18641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EBEC2F97A
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 08:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841F23BBB58
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537B30649A;
	Tue,  4 Nov 2025 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FhIt9YuU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ynoPipfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3F5305076;
	Tue,  4 Nov 2025 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240991; cv=fail; b=QBCpVElKKEaIzXPT4vuu1ntKLMis0PhfjELBZ3E2RCOr72AwYlApeyXY3IEpElajh7hTu+xl9taiCr6/OsSVZaP6WPWvHU5t/PGuQ6mMfFhQH0a8la8trZip1V5S2jn+v0HZxRRxahFYqW4cVsjOr4xiX4ON29e3C2DZJsoC14k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240991; c=relaxed/simple;
	bh=uqHE/1y6f3rfjtkRgoXpcsSFI73myky0ySq/6A2/79s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HS2Ir63Bj7kR/qp/XeP3ivYJoZ8Pf48cf4XfTDNKlhman3adux5fazNAOPqJRje2P+pjZVt78DiIivEBASiLvRnWEGyZJbTDPmei+jdW6wqmL9sSO0/p5zPkLI97MFQnWPiZXfi0NhP+ZUcfiwYmZzGCroDFb5UU1xW6gCXHCDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FhIt9YuU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ynoPipfR; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762240990; x=1793776990;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=uqHE/1y6f3rfjtkRgoXpcsSFI73myky0ySq/6A2/79s=;
  b=FhIt9YuUWh+pp/LPIF8a2YTjVTQ7TJQhaYWNYpQQKqe83CtmW0kmU/gp
   PmeOPYK53v5qa0KAoWZRPR+BltVktJfpCMjgUil/Guj1ANbtdn5Voupb+
   WUOXywJYTK5y/BYlzaS8HXy6fBTlZSrs2/7Fiu0VdvvbHnLOagYEVWTkP
   Ldy/gC0nBBRBUnJEfNu8K1oD44JFKhdgMp1G5BXBplJBQvLwz/SIrLSHd
   lSekhQ4Ee/DlerFBsFfQ4Bu0zg1yQxVUpL/Qvbo8hHn8p3RCwXFOOxgIV
   XWid1/Gc6WcMHE2fBFm4zbEcKHlgCY5n3p69gdZSR9jhFM3Eqe6rlhTx7
   w==;
X-CSE-ConnectionGUID: eAPiVIbtSiCDSR/B5CY4JQ==
X-CSE-MsgGUID: F96VTprtTGKQHT7wxwxXYQ==
X-IronPort-AV: E=Sophos;i="6.19,278,1754928000"; 
   d="scan'208";a="131442178"
Received: from mail-southcentralusazon11012068.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.68])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2025 15:23:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHW3BuvVi7rPyf3AthFteeLQi+XFOFPqNxij6HoTLzum6YBA6mc8G/GAo3tywHVX35zFVVvyW3WC/bUaxXPoOoQ8Vgk7nVlXs6++VeK0QUibzbUii1/qFUd071rlOmMw6nsM/k5P70YNgwm//KLlgDv9/UVaecs3E1kBI99dwxcGSUj6GiMVHR2NTR2Krfd3ZIDrx2HuxminVXqk7ENKrBmAKGPUb9NA3t7xL/0O7gdP0KqkgAjNcEP9WF8qeSHsmxWtCf6EyrC0Yp84Bwyd6Q+xpGPkX94ugYhg6r223DppQfg21rm2Sc1gs1zAeqKCDieXlfi0XoH9nCim/Hh8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqHE/1y6f3rfjtkRgoXpcsSFI73myky0ySq/6A2/79s=;
 b=K9hWpNu4K5aU5F6LbcCDyB0W2US7DVh2jQEtYFnNxTZvOwXp6J71o9bjkNmqvPJ6bCqYzimqnCnCPLkU8aPE11ijqtONC99A3cquqJn8DKfzb9D3kZ6VyAjeGlS4+dUA1nB5gfexdWbUP7K4AlLS8D1QCL5RAQkkEli13XgTFYh7tbeAacJHAGA+B6jOl0DWo1/8zvULIbLF/edxX8lAxIMvLp8mzz7CEl9IxvWg8jXIchFJgAb9UCpvTcMC85CsCF51XN8+7MT8QOEZYq8FzSnXzFg9w+uth/5ut6tXKB8m/J7F1UCmVXUXIIGJFi+qxq38BUzJNkawUr98RtmK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqHE/1y6f3rfjtkRgoXpcsSFI73myky0ySq/6A2/79s=;
 b=ynoPipfRzqjmKIhQ+XUWbY/ZJSgyFWiQwAOObk1WXd6nJVa1lwDfPwYjYLgD6ZBVD9nKBFbyjkJRKemqS29uYPb9je097AkiMEnjuJOfBrj0eyvOSOp4MAQGOw4s2EDpIJXxWZZcXzFtv+61rB5jQkxb3rtQUB93X+/ELMe3hkE=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CY3PR04MB9720.namprd04.prod.outlook.com (2603:10b6:930:100::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 07:23:06 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 07:23:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
Thread-Topic: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
Thread-Index: AQHcTMcxviMgxsdh+kOUBgn3533ol7ThEFCAgACWXgCAAHd8gA==
Date: Tue, 4 Nov 2025 07:23:05 +0000
Message-ID: <f7025e4f-3205-4bae-93c0-68e02dd11ca9@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
 <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
In-Reply-To: <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CY3PR04MB9720:EE_
x-ms-office365-filtering-correlation-id: 7a416fac-8486-4469-0c31-08de1b72ff69
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|366016|7416014|376014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFlhWU9qMG9pVG1RQkovS1pwYmFJVjRkNFNDRUhORjViSmVyakNQb25HdXVO?=
 =?utf-8?B?V2NMeUlpcEJ4RmlwR00zc0xTSEhnRFJsVEtWM0FnUWVpVmZwOHJiUmg0QUo0?=
 =?utf-8?B?dno5NkZQZjVra29QOGlPeTFQcW9uSGlYZHNUWDdjZ0Y0VVF1Y0lFR0lUWk4x?=
 =?utf-8?B?d3I0N1g5TUg1a2crdkM0WGx0cmM3NmxmbmZFQW1DSktVTGxzSzhBLyt5eDlh?=
 =?utf-8?B?R3I0czFvSXFaaW4wNDJjTytRakFBWUZvYjd5MEMrZ2xEZjJwUFd2T3c0NnQx?=
 =?utf-8?B?SHo5MGpsb3VBZEZ0TlhmNkZMblNPM1lXeTRGTVpmNGhOdmV0T0lSMUx6Q0NT?=
 =?utf-8?B?cjZ0R0FEMnIyQllIeUdacHRpMDIxaDRJSFRFN3B0azFHU3VFbjFKcUM4Ymdl?=
 =?utf-8?B?cGdHMUFaWmZ5bGk3TDVBb0ZxVXdKSzVvZWNKM3d0NXlQTmVnVVlnSS9aWUov?=
 =?utf-8?B?R0M2Y2VKb3hnbzluSnpCbEd4Z0hUVCs2OHNIQmdTVnVKUlVvTENFNy9WaFFI?=
 =?utf-8?B?ZG04d29uOXQzT0xsbDR6c1l2QStjTU1yNmRndS82OEs5VUZ0R2ZUZmNFSnUw?=
 =?utf-8?B?bGllOTExNlJ6d1JrSzMxa0dUT3pDcUVmblUwS2dLVWI4UmhTR3lCU0U1V0lq?=
 =?utf-8?B?RGZFR3FweUhNSWhrQkQrRnZ3YjNDZHpibVNsT1JuUHJ2QzJqOGhIZmZFa3FT?=
 =?utf-8?B?aGtjS0RUanlVcHhHVFY3YzBCOGNuUlhsUkg4RkFHUnpFYlorbWNFVmllVWV1?=
 =?utf-8?B?QmZXcVgrU0F4UFJacVRlWFhuTFB0Z2JtOEVwbFVzKzYyTXJLaGhCRmRHTVZp?=
 =?utf-8?B?OUd2WWtrTTdEL2NKM0E0dWJVdnBhTDgzb2JNVC9KaVlIVHphMk9iUkpieWdX?=
 =?utf-8?B?TGE4UHM4M1NBWUZUSE1BQU1lUk9KcmI1cGs3S2ZiZ2RoTDhINS9BWnpWMndV?=
 =?utf-8?B?R1BXbHdBNlNBdzd3V2doaGRQdlJTZkQrSFhqZVJWSUtJa3Z1dmsvWXRldW1X?=
 =?utf-8?B?ZEI2MmVtYzl3c0EvQ0NmN1R1b3lVbUw3cWJkTE1sZXNqUllhSjdDRnlESCt5?=
 =?utf-8?B?OWFJeWNGOW9FSEY1VnBNbytCYlRKRGxJVG1FdDlHaE9FMFpLQklqenZLT0FR?=
 =?utf-8?B?TjVIbWNVVXpsd3RndllMQWtJMjd0N0FWV3Y5cEtqYlEvRDZYQ1VibzdRUy9T?=
 =?utf-8?B?d3IwcytDQTNvUVcrTmxmM1M1a1gxeXFUWmVzdEZWdVJiRklpNHJPKzJrR0pi?=
 =?utf-8?B?MXd5L1NCb0hKRmxvdzFTNEtXT3E5NGVzbkIyTTJYNmRnL3dNUWsrUEVucXpY?=
 =?utf-8?B?MUdoRlRJTE42OUdVa1ZXcEFXanYxSXJFWmZ0QUF3WkJiVGJDVVlHQzUwR3Bw?=
 =?utf-8?B?YXg1YXNkQ2RkTW1ZTzBZcnFPWDg4b1JyVXJ6Q0ZWaEcwWVBmVWdtc2NOQXRB?=
 =?utf-8?B?ODdkWWlzMGZJd0FuSDFVZk9KYlcvRnh0T0hzamsrT2UvckxJRDJXa1hieGRv?=
 =?utf-8?B?am1BMUtnZWRIZmFCSmVyOFBlWnh1c0ZreFpSQWtjUzJIdFdnbVVCSHVja3J1?=
 =?utf-8?B?VFRYUjlwNTlpenRYUXNaamFINFBxbHhqWFFDWkQ5N1cxdFRJNlpMYzZ4aXJY?=
 =?utf-8?B?WkNEMzlVaEx2L2dpUitQTjk5RlBMaG9QS0t4WlhoZjMyNTZlMEFMWk00d1J2?=
 =?utf-8?B?NmZDR0cvVzN6dnlyM0pYY0ZnQUtXd3I4ZGNDSGlMUm14TjNEc0NEOHVYNzly?=
 =?utf-8?B?Q2U3WEhaZGdTbElOb2pkZlVRUlgrQTZCbm5NRkVPTmQ3VERBM1NSbzk2WVdP?=
 =?utf-8?B?WStmeEprMnRjdnRhalNEWHJHMUJuV24yU3kxdlRiTUxOeSswd3hSbGNSdnlO?=
 =?utf-8?B?TVVuWTZnZ25yNHg4V011dlI1YTFlSjFZelZ6a1BuM1U4N1ZyV25icURsNS9u?=
 =?utf-8?B?bjVPejFlVlNjTk1MTzRuK3J2bzF3ZWtQamNneERtOUl0SklPcWNpcVE5Mk5y?=
 =?utf-8?B?T0hZazlMM05VbWhmL0RQdHdDVGJTTGZuaWN1Q2tUTEc1Sk1kS3dEblcwTUlT?=
 =?utf-8?B?RFlrNWZuTSsvRG1POUJRc0FhbFVVcnp2Mmo0UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlVkRVVhbU9rSWx2V0htOEVOS0h5dkk1U0dIenYvbGhZZWtZR2dncVRPQ21Z?=
 =?utf-8?B?K0tkR0ZGanR4VVJzSEtkdllJWXpnWmw3dndlTDhoUndaZnAyMTRvaDRHY1JV?=
 =?utf-8?B?NHRsNzQyVnZuN25JSmMySnV2dnlLa1NVbXQrd3RZMmZUZzBYM2Z1emo4TVlY?=
 =?utf-8?B?VG8yOWU5YTl4UnFsSHhKd2NQY1M3ZXZEYXhFeU9uSUJ3TkdlaE9lUEVTcUsx?=
 =?utf-8?B?UlIzZGxTemwzOVJOUU0xbXVyd2Z3Yis4T3BTTU4zekJXUk9rZThRL2RPRk5x?=
 =?utf-8?B?MTVzUDM4T0JPQy9kTHRiRzdCT2s1UlVSUW8xSkh6TUxqWGliYVpjbVQraGw0?=
 =?utf-8?B?enZoSGRKL0pCOTdLU09ROXpidmRkbUx0VW1KcTlPZWJvY2xDQ1ZsWGtTeDJj?=
 =?utf-8?B?eU9yVDNQYllaa2JEU3NJZmpkdmpMajBMa1dBQU9uSk4yR1pXbDlsQVBxZTB1?=
 =?utf-8?B?N1pidmV0MDRHd2NCV2NJSVg0ZEo2djdMWTFLRmc3Z0pab2t6d2RwSDloaU1p?=
 =?utf-8?B?Zm5PV1RzcThxOElwTXRFUFc2TGdpM3BGbXdhbzhFbTg0NUtzdmV3cyt1a08v?=
 =?utf-8?B?bFdTOG13d2sra3M1OU9mVWRkY3dydGV4YTZkWUh2ZTc0ZDRjQy92bXB3QXhB?=
 =?utf-8?B?MkhvaXNOL3BKRnNtWmJpK3BGMERya2lHcXg4U2dtbUtUVExZYWVrVWowYlVl?=
 =?utf-8?B?Nk9Nb2Z5Q1FrcGcvUk1sNHp5enhDZjNHWlJaZEYrdW5ZWXdVSjFDQnVUc2R4?=
 =?utf-8?B?Z0V3T2h5bDBGNTVwV0RuOXZycU4xRFFmU0xDdmgrbW15YlVXbmRLZ2t5Z3dn?=
 =?utf-8?B?MG1VUm1YVnd5RGc4d1B6cGpsSVFwRUVUdVB3SXplU2dNVXNXRksvOUNqWng0?=
 =?utf-8?B?cjZLYmxSU0pvY00wa3dKMWlOTk85QTFXTWhjaSt3ZDBkdnIzUUlVSyt4b2Zy?=
 =?utf-8?B?OWRlV1NobGtsVG4yb24vWW1pZ20wTVJhN3QrYnVmdkl1MFpQeStBdkFCRDlD?=
 =?utf-8?B?NWJ2WUlmTzBQNmhyQUx2YXVjaWIwckg2eDBBdElWTFJQbTNLeTk0VXNFK2xQ?=
 =?utf-8?B?eFhtZ0hoS2YvcTg2YWFaMGJoNzdjMkE4WDgxYVVJc3FLSkxDSHErUHlOYUFu?=
 =?utf-8?B?aFIxNXVDNHVQME5zQUc1b3FWdFFNM3IrUmtrejhKcUtnditYTmtDc01lMER2?=
 =?utf-8?B?djNMN1NmdVo2dnQ0TUpmcW9KWFpJZ3ErNmdRYys1WllQNWFjSHpSUGZnK3V3?=
 =?utf-8?B?UU91aXBsMm9NZksvbVVKS0lsWHBma05aWGVCblVsTktUQ0RqR1FIWmNaY0xE?=
 =?utf-8?B?ZGcyQ3pTa1VwcGZkY0RsRGsvcG5VOFdMQjE4YmNNWGxRcCt5WFp4Nlc1OVF2?=
 =?utf-8?B?V3ViY21yMURRSzc0WnRkeDJ2TlF4SjU2MVk3Z2VuRXlhamJzVHlBS3llTkhB?=
 =?utf-8?B?czJNc1laSzU3S0JxaldTL0xDUUtHYTBhdEEySlRabDJGYnVEZENmSytxbW5T?=
 =?utf-8?B?OEVFWVo4aUNtUkhTTGp5cVU3Um1Hc0EzWERBd3BMYzdTMWU3dWVsVUQyZjNu?=
 =?utf-8?B?T2xuZE11RHJPRWVyMnFGYmVxeTlXc2ppQ2gvNm9KbWFXcU9CdGkwcmF0Y2Vq?=
 =?utf-8?B?QkswbDIvN0NEQUtySTFycFhEQ09rZjk4aWFVNkFoRUxONytDbkxaaGdKYy9q?=
 =?utf-8?B?d01nY1Njdzdlc2RTSEEwSDcyNkZmemdTK0JMVGl0SDhvcUwzalA0dnFoL29D?=
 =?utf-8?B?L1Z2SU5jK2pHRzN1VWNETjRlV0VqdjRuZDQvT1VTaGs2dk5aVnJieUhCbE5J?=
 =?utf-8?B?MFBJeksrZkZwNGZFeHhVMm1neWt2aVlrZjNvSldQeU1FVTJNVFlmazA0a0pu?=
 =?utf-8?B?UnZ1TEtVTHFaOVllTGMyaXNqcXErbHpOV2NqcEFtdkNNQ1dkQ1VnYmVQa3ZK?=
 =?utf-8?B?d2ZHWXRZUDdGcUVuNWw2QnltUi9yS0pTYU5GSVdKNzhIUEtIc2crc1NQT1dt?=
 =?utf-8?B?bzhhdU5XT0hGMCtBL2paNDY0MkFTZW0rQ1NFSWpSWlRPM0o2UkJibmtwSFI5?=
 =?utf-8?B?RXhRTEtrVlo3RFFYQmM1eHJSVUhQdEtWVnJORkViZjJrQ3pTUElxVUFaMDF6?=
 =?utf-8?B?VDF3V1lmUkFVeFp1M3BCSGlTMzVuLy92RFhRWHNjYk5INFhLV2NnamxCR2Ry?=
 =?utf-8?B?dEdPbTc4YlVYSmZiSnBqUTUwekR5bTBJcSsvUXBLcGcvVTVYNWhrWVlMTEZM?=
 =?utf-8?B?bnZlcjlsVHpqTTkzRW5nR3JROENBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73080716453213408B36981D29C6D81C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BcXP2e0y8C5tlAj0PwKHORmHwOLWY6pTDAxKlpCrgn+cRalsLK2Oh2HBI/1ZDRNFBR5meGhcy0YfTcivmlVMATsB4ktdi/Y4PsoDftV+tRFYYu943R3yYS96ztFSyh3B1GwRF8RglnC8sxLfJYnE/X9qtOd2CN2C/1TqwQiErRoizHmEEYJ/IBFlgE2Z7NptDdQzF3uog6iU7spUu5YuQnXCJLe3nZhrQXYDG9w37flLamc9nLL9/hikdBmALdfihByLnLjNm7r9Rdq0g+TjeqmOwby9ThNGDwKnwsMAKQsTlo6fq/PrBNSt9H6TWn+ZFW/9ju0S7VjWmzQcHjBfnjHivfCnHl3vw6zXOkyZE37BmPc4TiqQJVxAeuhROH1SCZ/3cja9ljDQ3SFpxT1jSHA6QFwwKVQjNiJ7wfGXxDMzxPGycyqqQAD/Mri7Lm3qFQpe/00gIDiBV6zrGBsy63FEGmMLK80rkNWEeKiblJ+YMF3D8KyTdlTBR1n4GMNeWJsGyKgyVpTqXaO/sao2SBWm1sPaRbvo3FqwrePeeBkDApZ39K7VUaIlwVNYaHSgjXceTgRylG+e7N3Lb2FM1YiEHAg1X16nUxUVLBOHxVYobLMdEGpNDaNu5hHaznSs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a416fac-8486-4469-0c31-08de1b72ff69
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 07:23:05.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+IbskGyvRIxF1acejrp296jw0SiM8Er4nGCN/BXnyXyFCw+h4iKek4zNK5j+IhhqyfMMmnAZPGzDc55WHfPPI65C5gAQ4rqIGD6BdQFqn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR04MB9720

T24gMTEvNC8yNSAxOjE1IEFNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gT24gMTEvNC8yNSAw
MDoxNywgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMTEvMy8yNSAyOjM4IFBNLCBE
YW1pZW4gTGUgTW9hbCB3cm90ZToNCj4+PiBJbnRyb2R1Y2UgdGhlIG5ldyBCTEtSRVBPUlRaT05F
U1YyIGlvY3RsIGNvbW1hbmQgdG8gYWxsb3cgdXNlcg0KPj4+IGFwcGxpY2F0aW9ucyBhY2Nlc3Mg
dG8gdGhlIGZhc3Qgem9uZSByZXBvcnQgaW1wbGVtZW50ZWQgYnkNCj4+PiBibGtkZXZfcmVwb3J0
X3pvbmVzX2NhY2hlZCgpLiBUaGlzIG5ldyBpb2N0bCBpcyBkZWZpbmVkIGFzIG51bWJlciAxNDIN
Cj4+PiBhbmQgaXMgZG9jdW1lbnRlZCBpbiBpbmNsdWRlL3VhcGkvbGludXgvZnMuaC4NCj4+Pg0K
Pj4+IFVubGlrZSB0aGUgZXhpc3RpbmcgQkxLUkVQT1JUWk9ORVMgaW9jdGwsIHRoaXMgbmV3IGlv
Y3RsIHVzZXMgdGhlIGZsYWdzDQo+Pj4gZmllbGQgb2Ygc3RydWN0IGJsa196b25lX3JlcG9ydCBh
bHNvIGFzIGFuIGlucHV0LiBJZiB0aGUgdXNlciBzZXRzIHRoZQ0KPj4+IEJMS19aT05FX1JFUF9D
QUNIRUQgZmxhZyBhcyBhbiBpbnB1dCwgdGhlbiBibGtkZXZfcmVwb3J0X3pvbmVzX2NhY2hlZCgp
DQo+Pj4gaXMgdXNlZCB0byBnZW5lcmF0ZSB0aGUgem9uZSByZXBvcnQgdXNpbmcgY2FjaGVkIHpv
bmUgaW5mb3JtYXRpb24uIElmDQo+Pj4gdGhpcyBmbGFnIGlzIG5vdCBzZXQsIHRoZW4gQkxLUkVQ
T1JUWk9ORVNWMiBiZWhhdmVzIGluIHRoZSBzYW1lIG1hbm5lcg0KPj4+IGFzIEJMS1JFUE9SVFpP
TkVTIGFuZCB0aGUgem9uZSByZXBvcnQgaXMgZ2VuZXJhdGVkIGJ5IGFjY2Vzc2luZyB0aGUNCj4+
PiB6b25lZCBkZXZpY2UuDQo+Pg0KPj4gSXMgdGhlcmUgYSBkb3duc2lkZSB0byBhbHdheXMgZG8g
dGhlIGNhY2hpbmc/IEEuay5hIGRvIHdlIG5lZWQgdGhlIG5ldw0KPj4gaW9jdGwgb3IgY2FuIHdl
IGtlZXAgdXNpbmcgdGhlIG9sZCBvbmUgYW5kIGNhY2hlIHRoZSByZXBvcnQgem9uZXMgcmVwbHk/
DQo+IFRoZSBvbGQgb25lIGlzIG5lZWRlZCB0byBhbGxvdyBnZXR0aW5nIHRoZSBwcmVjaXNlIGlt
cCBvcGVuLCBleHAgb3BlbiwgY2xvc2VkDQo+IGNvbmRpdGlvbnMsIGlmIHRoZSB1c2VyIGNhcmVz
IGFib3V0IHRoZXNlLiBFLmcuIFpvbmVmcyBkb2VzIGJlY2F1c2Ugb2YgdGhlDQo+IChvcHRpb25h
bCkgZXhwbGljaXQgem9uZSBvcGVuIGRvbmUgb24gZmlsZSBvcGVuLg0KPg0KPiBBbmQgd2UgY2Fu
bm90IGJyZWFrIGV4aXN0aW5nIHVzZXIgc3BhY2UgYW55d2F5IChlLmcuIHN5c3V0aWxzIGJsa3pv
bmUpLCBzbyB3ZQ0KPiBtdXN0IHJldHVybiB0aGUgImxlZ2FjeSIgcmVwb3J0IHVubGVzcyBhc2tl
ZCBvdGhlcndpc2UuDQoNCg0KT0ssIGxldCBtZSByZWFkIHRoZSBwYXRjaGVzIGFnYWluLCBidXQg
d2h5IGNhbid0IHdlIGRvIGEgIndyaXRlLXRocm91Z2giIA0Kc3R5bGUgY2FjaGluZz8gSS5lLiBz
b21ldGhpbmcgaW4gdGhlIHN5c3RlbSBpcyBleGVjdXRpbmcNCg0KYmxrZGV2X3JlcG9ydF96b25l
cygpLCB0aGUgY2FjaGUgd2lsbCBiZSBwb3B1bGF0ZWQgYXMgd2VsbC4NCg0K

