Return-Path: <linux-btrfs+bounces-17715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C37BD4E46
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 18:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49D695810B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927AF3148A0;
	Mon, 13 Oct 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ACtLCtTA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SVMoNQRP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273E3081D5;
	Mon, 13 Oct 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370107; cv=fail; b=SgEJtHLPveSjLkCzpWoHGxEbUC/7IwoZTWrzFdJc248M9Xi2W3g18AtoX5CqJhRla8yfQJoVi2km/ZwdWiSr1dMsAWZzEomPwa1riir1REqmNNWHMDQwM/Gwb81VauuoYw6nfuedo6kO1dyJU51HBYwAJ+MpY+Lpu/LCnunPem8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370107; c=relaxed/simple;
	bh=IqBHQEdOEHgx5LQvLOB03uaQHOrS5Jxv3JejSTB1+/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HzyOTtAdlot5d5owxYLKf/VPGbTWgGZcouQTn5bbKchZAmBJMn//dfp6GKbZEw/qgMnBTkQTLXYerEtCE+SI+NPXjgpfOD/2ZIHw28sADd1PbAHuV2wdzumd6epIFx3cze9kPyOJWZNsaD1qSlLaWEeP0u8ovZeaFMkUP1TcNx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ACtLCtTA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SVMoNQRP; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760370106; x=1791906106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IqBHQEdOEHgx5LQvLOB03uaQHOrS5Jxv3JejSTB1+/4=;
  b=ACtLCtTAWUxc/09n/3unQeANdymSeg5R/lgxW42XKgT6eiIGu+kl1V55
   hFdLRupoaXiZ9uEZTTXVEoyyz3WfqOWAp0sgzh5zDesU+s//r7gu/RWJb
   tU/yU8HsO8b80V89lOnbRjmXte1bqPAoi1feMHzRKkHM9+t7iSJk6mZ6u
   S+kjx3qTbSySpSVQhkRFX1q0y//KIxxLrNiY8qX9SuOyN2ghJg++zeZQK
   QvpUOZ62I9gZL8+QElEV65twuWSHzcPassQ+bGhQ0+bb3o0HWuX2LB1js
   02+p5eQ3l7YBtf3YkSvdUdd0a39OeRPmMdmJfQ9V4bjMGTFZrZ147rJZV
   A==;
X-CSE-ConnectionGUID: 0yGlaGCMQgGFpA7iFC+BDw==
X-CSE-MsgGUID: 05C272xlSde+7jqvPXKXdQ==
X-IronPort-AV: E=Sophos;i="6.19,225,1754928000"; 
   d="scan'208";a="134054320"
Received: from mail-southcentralusazon11013041.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 23:41:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAD7vzgl8i9hzBPPwGcMEap7GP6GLzSJ2ERkupO52+T16hG8zUcpzo+eHukErugRDQsDpQyzY3jNBJAbVMRqXHA5IZswnhKS/Hf1eY0R88OTR9bYchqVTEDqkf5dCHnv7wpGtY7EMxuq6Rf+SH2ivNU+SfZ9rBK+AWBBmPc1VP+zhDQRuoVSbMuJywd0sZpeyWAlchWsvkVYpjNt4ONfAovbfRlL0lj6u9EYcLYE+y5gbRSN8cNk0Z0vA5lJomtsoANDPu560fzUcTXgZSJaJ+AgGAZ6YrOum6gkOJbuGgWAyXeecy/idqLySon6YQ7Y+tXzkuG0Z7fRypX35xworg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqBHQEdOEHgx5LQvLOB03uaQHOrS5Jxv3JejSTB1+/4=;
 b=F2/+VdXxHIlaGXzAWORdMbLLJy1zfQS7BhTDWFiFPoIc7S4yTqgPoHkQ06NaHvPDUFi3S89AREkEgMKKA15AOJgyzzTtoJ3Izc9nM/ZjVsTtwwJMQJOL34Ua/i+EXB6d7fsAfJfBjGjC376Ov+xUfVa0N8cj0FIT5lley7eFH5rBA7Mak3mPmzAIXtdrO3v1ulCeCleXqsIb6UhXpJXJUXmzY5/tWeb2UFzysv7AgxCQHSwR3HPpr5INyb7LY+hbpx1ZRYCLV1UjhEm3hn5gC7rNDweFYcciXBBMTVOwjY2xo1lj9osaLBNNEKxQEgg4i7aYojz9NEkXd5fVqVTVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqBHQEdOEHgx5LQvLOB03uaQHOrS5Jxv3JejSTB1+/4=;
 b=SVMoNQRPa1QARyGeE/9yMM/X971EytgqQVE5Ch6pUZk7KNWF9h9dtt+RFrp/BACDsOqfmWeV1cJEOilqHB1dQKYQ1dH2VIbYJY+b11kngV3/snCdRE1vN3EMi5uOWHD6LXeMPVA3A3xdq/ruAwFri+k3RSpB1mi8S0AIeNA+IpU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA3PR04MB9452.namprd04.prod.outlook.com (2603:10b6:208:515::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 15:41:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 15:41:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
CC: Carlos Maiolino <cem@kernel.org>, Zorro Lang <zlang@redhat.com>, hch
	<hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] common/zoned: add _create_zloop
Thread-Topic: [PATCH v2 2/3] common/zoned: add _create_zloop
Thread-Index:
 AQHcN4oM4muMXjqpnEST+IIw1k0JMrS4U0kAgAAIVgCABFnIgIAA+/cAgAKF6ICAAAliAA==
Date: Mon, 13 Oct 2025 15:41:41 +0000
Message-ID: <2bdc8d4e-4ec0-4f41-88cd-c903284ec0db@wdc.com>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
 <VGGoqK-5ZWJTAAy5zOK2QgRfnghNzWtGFoBwL6Sw9bqE7moL7lyTr43XUUgtMM54gKwCKIpC1Jz9u5ZcnpNATg==@protonmail.internalid>
 <20251007125803.55797-3-johannes.thumshirn@wdc.com>
 <hrht5llavtcgd5bb6sgsluy3vs2m6ddzzshkhwqb4fjgujgrli@6px7vpsk7ek3>
 <20251008150806.GA6188@frogsfrogsfrogs>
 <f0713993-cebf-4e42-9c1a-26706a52be4d@wdc.com>
 <14046f78-e1e9-4188-8405-16055520513f@kernel.org>
 <20251013150805.GK6188@frogsfrogsfrogs>
In-Reply-To: <20251013150805.GK6188@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA3PR04MB9452:EE_
x-ms-office365-filtering-correlation-id: cd6703e5-9a2c-4d0a-67b0-08de0a6f0154
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3kzY0hXQlpqYmZ6WEkrY3IxZzNBR01yTmFtNjMrU29aTWVwUUtKejdPOERy?=
 =?utf-8?B?dHNwOTRPdDhEWHA3OVJJVEsxV08yU0hFSU5ZVm5CbkdScWFkcTF0NjJJNzY3?=
 =?utf-8?B?WDhhdlR1VllMLzFvYnFBVlJHNnlKRE5sSHkxbHNrREEvWkpWbGFDMk9oTzRR?=
 =?utf-8?B?NFgvQWFVS0R5SUFYZ001RlVxcHdoSVlYbXk4cjI4ZlpIOHBWOGlFMHhva1Rh?=
 =?utf-8?B?R0pvR3dlSjZkanN6VDRGKzhBNjNrd0VEczhZQVcyVlhWMkh1TW5Oa1NqWTZO?=
 =?utf-8?B?U2tPVTZGMm5rZkV2Ynh6V21JSThhMVRGZWtnZ3ByUm1DSlR2QWI1dXBrUTB2?=
 =?utf-8?B?N0JFWGtmK2habU9wQWJXQllEcUNiYndjTitaS3k5YkdYZnhBekpheDhmRk02?=
 =?utf-8?B?M3Ivclp3QmtqTVBvNmJZU3MzWW1pWlowd3lIcmtFMm9PQVJITkMwc1g2c2pF?=
 =?utf-8?B?bU92cUZIT25CTEVVbENIdFVIdjlFMFFFM28xWXZYbmJXb1Boek5IYVRaQUxy?=
 =?utf-8?B?aDdHNGNtNHhlU0wxRXdiNjc3eU9TMTFGSk9kZENmM2wzY3R6SjRZR3lTVFQ4?=
 =?utf-8?B?aXlscW9RY0xXNXBzNTBvQng0UTFWVFBsU2E1RkhsY1hrVklxOFdIQlhTTVNu?=
 =?utf-8?B?c1p6YTA1ZEoxUGNnSXhXeTluZm4wb1VDVnJCNVdvWkFlczdwdXluS01uR210?=
 =?utf-8?B?R29YRTNqMnBUdm9UaUVQbGszSFYvNmZIaDZIdnpYVnNFYWl2ZzJSaGV3bUt4?=
 =?utf-8?B?em5nQXl0bDViOGVnRmFiMFlGME5YYldwdXBBdCtlci9CQzlYaWVQRUJGYnJv?=
 =?utf-8?B?RlgvbnNqT2FQQW8vY05FQUk3YzVxWVk5aDZHY2p6MUtDUUIzaGxybTY3Vm1r?=
 =?utf-8?B?R2h4VjVML29vM05mLzcxS2xOdXB0QkpoSElTKytTUWg4VSsyNlgvZzhJNC9F?=
 =?utf-8?B?YXlVcE0zKzdrS1pCc1NYN2pYUDA0NzhaTkhOMnlLcUhRY1hqa3p1WHB5Rm1Z?=
 =?utf-8?B?T05aUzRUdjlLQXhBKzhpaDYzZVVoYllheGVuTWw2RkdTR0RIQkMvSjNiUWVT?=
 =?utf-8?B?S3M4ckpmelhPTmNjWGExdUFTTTBhVEZZc2pYMHhHaHUwLzd5WXhSTkJyRDBa?=
 =?utf-8?B?bmVlMlBVOVBvanJQMThrUDFmMkN6VzR5MHBpcnJ2RzVDOEFNOHhUMDVHbldS?=
 =?utf-8?B?SklRWlJPaU5Oczc5QlFhTllZc3FLeXZPN01MOFlrS3hBcEdXL1NBeHl3WDhw?=
 =?utf-8?B?QWFNdFV6eDZVanN2UGVVL2xzTGloMHEvZ3pUeThpYzhsTnRTdG9nTTh5Vk5Q?=
 =?utf-8?B?VDRkenk0SjFDQTlZUmtqTzJaN1F4eGlld3pvdktoZDFlZWpIT2xSWHltR2Rp?=
 =?utf-8?B?NDZ4MDIxL3JJeHJyTlhTSWI3SnBJNFlCUWhaNzhXa0k5Y0dIeHFUY1BFRi9D?=
 =?utf-8?B?Q1Z2VFA0d2pyTUM4WmRZOGlMQXh0RUxBSXo1SVpCNThNV0pSRjVveUJqSkNE?=
 =?utf-8?B?TUNoZWtONSt4UUwxYzBiaU8zS2plQ2EyVHgvbHMwOTNFKzVsTndZdFkzTzdq?=
 =?utf-8?B?ck9PS2V4cXRORlc0VFE0Sld0Rlg3NktNS2hvbmVSSkxWbjl0eWFTeGtBM2JV?=
 =?utf-8?B?dFFZWGljdHVsK0J4QzM1aE1pVmlabkMwQUt2WWFGZ1FIYnFKb05lTG1CdkxY?=
 =?utf-8?B?WllzRDMwNFhNWXlVbHl6Y0Y0Z0ViQkpBNE9oemsxRXNWMEc0K05ITGZVMzFx?=
 =?utf-8?B?cVFMMFprd1BRQUFIc2dCenpzb3J5SHY1VGgrMjJoNXpBQlFSeUFyeVVEeTlV?=
 =?utf-8?B?Y3pBREFqSUp6ZmE0c3hCT0p3RTZTNjcvVVlzVGxXaGpoTjM1VkUzMEVxZHB4?=
 =?utf-8?B?S0x4V2NTZHdhbXhrQTJwL3NIc1lQN3VnbkM3OTh1S0ZpWmVUMTVVcXIzSjF6?=
 =?utf-8?B?eXZ6M0tYemxYdjF6MzNHejhqZEF3UWtZV0RydWpVQjU3YUJsWlROWC9FTGUx?=
 =?utf-8?B?OWszdnk0T1d4OWlTU2F0czB5VGgyZCtQSzR2S1ROUWNaOUZqeWlCRjV4c2Zw?=
 =?utf-8?Q?FMe7X1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QS9KNERMcTQyL3JuMDI1MENuZ0paT2dGd0xGZFpXQW8rbEpMbSswdnppTU12?=
 =?utf-8?B?N2FIbW8zS0xKcWRNNFN1QUY2KzVkVVR4T0dPTWkzS1B4b2FwQ0pZN0ZZR2gw?=
 =?utf-8?B?RjM2cWozZDQyb2oxUERlUkVrL3ZFZ1IvNXUxcHp3MWo2T2Rmc2VEWFVveDA2?=
 =?utf-8?B?cVJyZHF2ZTVGai9RNzI3N2g1ekFzR015WUlFMU42RXJrN25XUjBoOTloK0d5?=
 =?utf-8?B?SmZJZnk1UklidUFVU2pGaUgrTlpCS0N1S05uM1ltQS9wazFMcmFxM3lsL1BS?=
 =?utf-8?B?eGNTbUI4T25DQWNaTUpuekJEaXZuS3M3RWJ2WTFXRDZlcnZ6MU1UQll1NXFL?=
 =?utf-8?B?SzgwbUF3cEVsU2dmOUJuRVYrS0tyQnpSQit0RGtvRklHSHZhdzRIaUNPcC9P?=
 =?utf-8?B?cndudTNsaUZwNGxXVkJ4N0J2b2xrQm1KRVltQlFXdFVaQWFMQVJEVnIxbTUx?=
 =?utf-8?B?b3lFbGMzU0R0VU93M1ZKTnpzMWJENnpWUDBnYWdYdjkrT0xDZjlkb21vTkww?=
 =?utf-8?B?TUtEZ2lCNEh5QisyNDJ0VE5hV2hya2oxV1RNb2RQb1EzcEpOVUpQbXZ4SUFl?=
 =?utf-8?B?MEhzSGF3SGhVK0RrQXRVakRxd1RHcUQyM096OFFZeVVrdDVsZmlYT1Z2ejlz?=
 =?utf-8?B?N29VSCtWNGpVNDdweXFzK0pLS1RPTW1uNVE2YzJGc29COFVpakJpT1hqNk9G?=
 =?utf-8?B?ek1VOHQwdHNBRmV5OGtlTEFxTHFSZHI2bU5nYVg2ZjduV2Q1MFhJSlpLaU0x?=
 =?utf-8?B?RUJlLzBhaEJ3OFBqOVZmOStkdmxLSDJlalpZTjhldE92azVCZElYZ215Ny91?=
 =?utf-8?B?S3k5TGhzcHl2alRvUnJYWFFORnc5OXB0Wi9PNDNvZW1SY25yQW1Eb3FhUW5N?=
 =?utf-8?B?TWsraWZSSTBTU1BjQVlRZnJxWmpGTm5CLzlYYTFlVHhGdXU4cjkyeXJya1BO?=
 =?utf-8?B?N2hTa3RUNEp3L3QvOEsvTE1SVUg5SWJwTW9kck4xMTlnbEQ4ZWEwZC8xTEpE?=
 =?utf-8?B?dmNSN0tvS0dPWUM4cWNWUGwrZHFPMjc3MGQxWjJtUGk5WllQYURBUHlock01?=
 =?utf-8?B?MUN5VjdrV3lPcnc1L1lBYlMxTGhHVC93UUdpK0Y0Yk1LUmpsbFQ2bFFEdjdj?=
 =?utf-8?B?OTZ2WjhqOHV3NmgzeW9lTThIc1crcGgvTDVGVVpxQk0wT1MxWUF2SXBKaEtB?=
 =?utf-8?B?K1k3bk5iUkYvLzJKWWZIK2Y4b0s5Tjh6bjFIMjcvV2g2VkRCb050L2F4RFE0?=
 =?utf-8?B?NU5pZitGZExPMlppUVR5NTd4Nys4MjNHcm0yZStQZjFyU1B4OUdlTVpuRVl2?=
 =?utf-8?B?NmE1WE94cTBXL3VvL3RyZG1rR012c3hlNjI5Y01VNVAyV2tpd1krZ0wwejBi?=
 =?utf-8?B?YlVudmdlKzB4ZlFqTC9aalhFTnZ5N0dHcXJ6NnRkTjFSRVBvRU1XaEtQY3NF?=
 =?utf-8?B?YXdKS3dUblNXMHJLZ3pTZjdCTFVmMEFKMVp6dGptMVhXdEdoRER6TkRCczRQ?=
 =?utf-8?B?ZGhSZjF1L0NNbXdZZ05kQVBRWmNuVUJTTnlGZnNvL1JXV0x6Z1ZCdUptd1d4?=
 =?utf-8?B?c1lRaElmd1NTTmlWS00rWTMyU2sxWFVKWDg1NHZ2WGlIaUZhbER2eU0wVzN3?=
 =?utf-8?B?OG5oZElUdXVlVVFYenIrS2hKRWVYb3JZYUJmb0FyN3VZZjdQNzBiaUZGZXVU?=
 =?utf-8?B?U3doUHVCWXVUY2RJSjVSd2xWbkhlYm9kR2ttZFoyeG1xdnMrbmVMWVNKWjlU?=
 =?utf-8?B?dm9pMmRHa0JJZEZTYVRuSDJNMW1UcXcvazdaTk5BcTBuWGdqY3MwVnZMOWhK?=
 =?utf-8?B?S2QrZ3ZaZ1czNE1UMnY4ZGVEOWhjLzhIY3ZXM3Q1NXI4VXJZVU5kU08reDFt?=
 =?utf-8?B?UE5WSTFRbEU5M1IvM0NnaENVQzFKUHl6QStyQ0RMdG13czc2VTB0eDZtZEhp?=
 =?utf-8?B?VTBham1JMUlTb0gxVVY5dDV5VmdEMEQ4OW81UzJiZ1N4SlpTOEJ6ZUlqQ0ZL?=
 =?utf-8?B?TnE4UFkvWTdQN3oyT2N1ZjAyVGNtL2x2TFNpMDYyMnBrd1JqaTlrUTZIMCtn?=
 =?utf-8?B?ME54NnhTQUVic3ZGZ1hsdDIvOVFoNTlmRzhUYlVNNzE5WVZFd1huTHp6dHM0?=
 =?utf-8?B?VU5oU2RCcno2c0RnNHF0bSszaE1Pejh0dHNzZ1gxTFV4Qld0NVA4MjQxc0Nh?=
 =?utf-8?B?YUl6SlZJcklJRkFoZmlKZUdyRk8xc29TdjFNOEl4R20yM25CbnJGMDQvMVJJ?=
 =?utf-8?B?RzJCdWhLMVdoalhkTGVKRFE3Um5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D6BF286C2AA364692ACBFA950D78D1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hH1a9iUs27r/HV7IVshYb252CP/SaaWkXDZwF1cY4Kdg9e2F3EJJAqHm0BzVjknjM0n+sJ6r7RQ6lQ/nFczTjWPV0mAr+YbKfkLsStR0NIUB9VG7CAcdGcZPpQ6icQd87GY8fv2heUj4nDVeLgmsHoo6/vB4qUJPsVrZ0vII5ahuDxDlAWlNYSDpgzl1wr8tXfKNke71PWKR0IB/tInM2haoAZYYC/EjtHu8eec/vWcskeLvOMU7/076qiuZf8f9grcL88uuplBT9vnxfdXSmfXHnr6b3SF+eqMsx2H15YCRPgU08vc4eLTLHcchdIOGmvgf925I0EJhWMVLVbQS/t9o7jsP1tNtIYlPiBNTpkLsB8Bgc/5eG74yg3ttMe1rNasVJA/i7yI2PhObiMmgNKgB/rsPJyL6EKmPYUde0Bm63p3jcy6rAczIjX3X70VVquGaVm4S6lh1fJ0Cz4zDUrt96NgyGyGWtprFfnZYRM+W9Ssn212zCOYLaiAOXIHM/uQUnph2EG3nGj6R4ArGrqY2pEhH4uJQN2dGyKg1epipEVyMhfdny/3ayyFCJxaX5svWWX+Antqd88OTc5Y4Q9VOvFmz91j5Et5oADmCNB6BIaUID4mzWz8NnphBWbjn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6703e5-9a2c-4d0a-67b0-08de0a6f0154
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 15:41:41.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gpGV80q+dg8QtgNYANxf1WQFtvs4+0FMtfdGkwdR2h269TILfUty1jn2L/RvffxPc4ztTcCm3B09brZz2d3mDo3TaJo7OKmL7ZI+FtVgRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9452

T24gMTAvMTMvMjUgNTowOCBQTSwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBPbiBTdW4sIE9j
dCAxMiwgMjAyNSBhdCAwOTozNjoxOEFNICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4+
IE9uIDIwMjUvMTAvMTEgMTg6MzQsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+PiBPbiAx
MC84LzI1IDU6MDggUE0sIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4+Pj4gT24gV2VkLCBPY3Qg
MDgsIDIwMjUgYXQgMDQ6Mzg6MTZQTSArMDIwMCwgQ2FybG9zIE1haW9saW5vIHdyb3RlOg0KPj4+
Pj4gT24gVHVlLCBPY3QgMDcsIDIwMjUgYXQgMDI6NTg6MDJQTSArMDIwMCwgSm9oYW5uZXMgVGh1
bXNoaXJuIHdyb3RlOg0KPj4+Pj4+IEFkZCBfY3JlYXRlX3psb29wIGEgaGVscGVyIGZ1bmN0aW9u
IGZvciBjcmVhdGluZyBhIHpsb29wIGRldmljZS4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+Pj4+
Pj4gLS0tDQo+Pj4+Pj4gICAgY29tbW9uL3pvbmVkIHwgMjMgKysrKysrKysrKysrKysrKysrKysr
KysNCj4+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+DQo+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2NvbW1vbi96b25lZCBiL2NvbW1vbi96b25lZA0KPj4+Pj4+IGlu
ZGV4IDQxNjk3YjA4Li4zM2QzNTQzYiAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9jb21tb24vem9uZWQN
Cj4+Pj4+PiArKysgYi9jb21tb24vem9uZWQNCj4+Pj4+PiBAQCAtNDUsMyArNDUsMjYgQEAgX3Jl
cXVpcmVfemxvb3AoKQ0KPj4+Pj4+ICAgIAkgICAgX25vdHJ1biAiVGhpcyB0ZXN0IHJlcXVpcmVz
IHpvbmVkIGxvb3BiYWNrIGRldmljZSBzdXBwb3J0Ig0KPj4+Pj4+ICAgICAgICBmaQ0KPj4+Pj4+
ICAgIH0NCj4+Pj4+PiArDQo+Pj4+Pj4gKyMgQ3JlYXRlIGEgemxvb3AgZGV2aWNlDQo+Pj4+Pj4g
KyMgdXNlYWdlOiBfY3JlYXRlX3psb29wIFtpZF0gPGJhc2VfZGlyPiA8em9uZV9zaXplPiA8bnJf
Y29udl96b25lcz4NCj4+Pj4+PiArX2NyZWF0ZV96bG9vcCgpDQo+Pj4+Pj4gK3sNCj4+Pj4+PiAr
ICAgIGxvY2FsIGlkPSQxDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgaWYgWyAtbiAiJDIiIF07IHRo
ZW4NCj4+Pj4+PiArICAgICAgICBsb2NhbCBiYXNlX2Rpcj0iLGJhc2VfZGlyPSQyIg0KPj4+Pj4+
ICsgICAgZmkNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBpZiBbIC1uICIkMyIgXTsgdGhlbg0KPj4+
Pj4+ICsgICAgICAgIGxvY2FsIHpvbmVfc2l6ZT0iLHpvbmVfc2l6ZV9tYj0kMyINCj4+Pj4+PiAr
ICAgIGZpDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgaWYgWyAtbiAiJDQiIF07IHRoZW4NCj4+Pj4+
PiArICAgICAgICBsb2NhbCBjb252X3pvbmVzPSIsY29udl96b25lcz0kNCINCj4+Pj4+PiArICAg
IGZpDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgbG9jYWwgemxvb3BfYXJncz0iYWRkIGlkPSRpZCRi
YXNlX2RpciR6b25lX3NpemUkY29udl96b25lcyINCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBlY2hv
ICIkemxvb3BfYXJncyIgPiAvZGV2L3psb29wLWNvbnRyb2wNCj4+Pj4gSG1tLCBzbyB0aGUgY2Fs
bGVyIGZpZ3VyZXMgb3V0IGl0cyBvd24gL2Rldi96bG9vcE5OTiBudW1iZXIsIHBhc3NlcyBOTk4N
Cj4+Pj4gaW50byB0aGUgemxvb3AtY29udHJvbCBkZXZpY2VzLCBhbmQgdGhlbiBtYXliZSBhIG5l
dyBiZGV2IGlzIGNyZWF0ZWQ/DQo+Pj4+IERvZXMgTk5OIGhhdmUgdG8gYmUgb25lIG1vcmUgdGhh
biB0aGUgY3VycmVudCBoaWdoZXN0IHpsb29wIGRldmljZSwgb3INCj4+Pj4gY2FuIGl0IGJlIGFu
eSBudW1iZXI/DQo+Pj4+DQo+Pj4+IFNvdXJjZSBjb2RlIHNheXMgdGhhdCBpZiBOTk4gPj0gMCB0
aGVuIGl0IHRyaWVzIHRvIGNyZWF0ZSBhIG5ldw0KPj4+PiB6bG9vcE5OTiBvciBmYWlscyB3aXRo
IEVFWElTVDsgb3RoZXJ3aXNlIGl0IGdpdmVzIHlvdSB0aGUgbG93ZXN0IHVudXNlZA0KPj4+PiBp
ZC4gIEl0J2QgYmUgbmljZSBpbiB0aGUgc2Vjb25kIGNhc2UgaWYgdGhlcmUgd2VyZSBhIHdheSBm
b3IgdGhlIGRyaXZlcg0KPj4+PiB0byB0ZWxsIHlvdSB3aGF0IHRoZSBOTk4gaXMuDQo+Pj4+DQo+
Pj4+IFRoZSBfY3JlYXRlX3psb29wIHVzZXJzIHNlZW0gdG8gZG8gYW4gbHMgdG8gc2VsZWN0IGFu
IE5OTi4gIEF0IGEgbWluaW11bQ0KPj4+PiB0aGF0IGNvZGUgcHJvYmFibHkgb3VnaHQgdG8gZ2V0
IGhvaXN0ZWQgdG8gaGVyZSBhcyBhIGNvbW1vbiBmdW5jdGlvbiAob3INCj4+Pj4gbWF5YmUganVz
dCBwdXQgaW4gX2NyZWF0ZV96bG9vcCBpdHNlbGYpLg0KPj4+Pg0KPj4+PiBPciBtYXliZSB0dXJu
ZWQgaW50byBhIGxvb3AgbGlrZToNCj4+Pj4NCj4+Pj4gCXdoaWxlIHRydWU7IGRvDQo+Pj4+IAkJ
bG9jYWwgaWQ9JChfbmV4dF96bG9vcF9pZCkNCj4+Pj4gCQllcnI9IiQoZWNobyAiYWRkIGlkPSRp
ZCRiYXNlX2Rpci4uLiIgMj4mMSA+IC9kZXYvemxvb3AtY29udHJvbCkiDQo+Pj4+IAkJaWYgWyAt
eiAiJGVyciIgXTsgdGhlbg0KPj4+PiAJCQllY2hvICIvZGV2L3psb29wJGlkIg0KPj4+PiAJCQly
ZXR1cm4gMA0KPj4+PiAJCWZpDQo+Pj4+IAkJaWYgZWNobyAiJGVyciIgfCAhIGdyZXAgLXEgIkZp
bGUgZXhpc3RzIjsgdGhlbg0KPj4+PiAJCQllY2hvICIkZXJyIiAxPiYyDQo+Pj4+IAkJCXJldHVy
biAxOw0KPj4+PiAJCWZpDQo+Pj4+IAlkb25lDQo+Pj4+DQo+Pj4+IFRoYXQgd2F5IHRlc3QgY2Fz
ZXMgZG9uJ3QgaGF2ZSB0byBkbyBhbGwgdGhhdCBzZXR1cCB0aGVtc2VsdmVzPw0KPj4+Pg0KPj4+
IFVuZm9ydHVuYXRlbHkgdGhlIHVzZXIgaGFzIHRvIGNyZWF0ZSB0aGUgemxvb3AgZGlyZWN0b3J5
IChlLmcuDQo+Pj4gQkFTRV9ESVIvMCBmb3Igemxvb3AwKSBiZWZvcmVoYW5kIChtaWdodCBiZSBh
IGJ1ZyB0aG91Z2gpLg0KPj4gTm90IGEgYnVnLiBJdCBpcyBieSBkZXNpZ24gc2luY2UgdGhlIHVz
ZXIgY2FuIHNwZWNpZnkgdGhlIElEIG9mIHRoZSB6bG9vcCBkcml2ZQ0KPj4gdG8gY3JlYXRlLiBB
bmQgdGhlcmUgaXMgbm8gZml4ZWQgYXNzb2NpYXRpb24gYmV0d2VlbiBkZXZpY2UgSUQgYW5kIGRp
cmVjdG9yeQ0KPj4gcGF0aCB0byBrZWVwIHRoaW5ncyBmbGV4aWJsZSBmb3IgdGhlIHVzZXIvZGlz
dHJvLg0KPiBIcm1tbSwgZWFjaCB6bG9vcCBkZXZpY2UgZ2V0cyBpdHMgb3duIG5vdGlvbiBvZiB0
aGUgYmFzZSBkaXIsIHJpZ2h0Pw0KVGhlcmUgaXMgdGhlIGJhc2UgZGlyIGFuZCB1bmRlcm5lYXRo
IHRoZXJlIGlzICRCQVNFX0RJUi8kSUQgYW5kIHRoaXMgDQpkaXJlY3RvcnkgaGFzIHRvIGV4aXN0
IGF0IHRoZSB0aW1lIG9mIGFkZGluZyB0aGUgZGV2aWNlLg0K

