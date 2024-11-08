Return-Path: <linux-btrfs+bounces-9387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B189C16C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 08:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC751C21420
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 07:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306EA1D0E35;
	Fri,  8 Nov 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OouHHqkU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yqyJDLeK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554DDDA8;
	Fri,  8 Nov 2024 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049671; cv=fail; b=J5LQYAyifPkJYjy7GP0ECIdSUpXDvaEKkTcxXsvapm9h05++P9kguKEpPYkZ4gm6zUy/KEw2I/wiUb4In+4Rq5QgUvxerZEkxyl778IivWyYekV73B7OEaYmzNcut2mmvngJggJgBUz5K73kfZpGMm7WnGteP4e21kx6YugQWYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049671; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2FZdR929JxbaIOutdkMlctPM11w0QqjHSF5KCvz8sFx6kDesfloeoKi5bg5pVPZE+iJElKdCSNfi2ggcJplz45BlIjbgGAKrfjzuA+nnDyiDljosF1sgMTP7/YOiwNZFyeihMsSzT+Z8j+54ztGmtfOuZfK9wUlt+lgAkmaY6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OouHHqkU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yqyJDLeK; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731049668; x=1762585668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=OouHHqkU0/bxpsmZvxtpg69McZFiPm+2gWUluAA3Dwou/8TKqlTHIqR3
   KGie8c/rQPa3p2fnRm5NPk1e+Wyv9Hrp1jbLKpKEIbet+vfKfeHiU9SuS
   Y4o/kcSFirgKJiiWWtPfiqDeOdrcjW3EtynHst2K/rb4wkMgJ/rqBwoC0
   0hAhyK0imzjAZN75Z1hnR5+/W1En2qubE72+dBAgVPYUIXgiUxfuaYvk4
   HAnSM7dJYQagtZtpek/cWGXDE6KBwdo3GwxxPtS1KsS33AbzLAYTPmSBh
   Wgb+0xc4PYypQAdhO/lLopJdgpB/zKCinQYge8rZGbjy/21GbEpvAzzOZ
   A==;
X-CSE-ConnectionGUID: pDSQDe0OTraJZEouRm5g3w==
X-CSE-MsgGUID: UuvDEr/uS3C72lvmjVeotg==
X-IronPort-AV: E=Sophos;i="6.12,137,1728921600"; 
   d="scan'208";a="32061880"
Received: from mail-westcentralusazlp17013075.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.75])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2024 15:07:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iofd7KGa6RsRmuqEiH05sCZDGsyFj6g7jEIJb6zVFQrVJrulLuxDvqbtQ5t7oq8UtVNj3aWJvbOa0xJIYjUtnUKZxpbqnNLM4oPkBxtIb8OmSFrBgQXNDyHz0750cfhl0eSH+ZL0U5CSGsgLa6qnwDrEPu1NV4PlwLRRJd45MW9pXjJhmYikKR0kGE3e4nF9BBaOV8PxqfK58x6FlGkVx0y0h9ucmHWkpZ4izWn3DmvuJEdvUhgYloI4Z1kT5kC3mi+64GwgeUaButggaMPwptB4mcjGjlT3jQJtT8JwA4NfQ+q3Ut8MHYZCFDnKnyydzmYqJSuzhLCHlsfJj3Ah5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=o2LZCo36ss3ghKka7h/dsELXwbB9rq8kdda8ARKeKae7AQkvSv6FE7AgAhg0eB79Mi5Mdr7fNZUeGhHkQdk72E+BsluNgO5u78Y7Co3J0kKagad86CHLt+qKcYM7YGxzB9lNh5TWW4lJDGG9TVYMS0qioV1qSc9sxmOh9khkx8soqZnC4Qwgh1kdIMxCilWFgIYKnueEhW9jM1W1eVDmdFE+jtGYHpOKJtt+4x1lsf6/rqLBojdq0eloNx5Ygq+/oZpdjnt6rIceOzHPg0MR8IujWcO/qxUKs3ma4rqrW2pNVqz6ojHIgs9BMGkQRvLpR9AY39vM5KKXvZpGqTGVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=yqyJDLeKwCrZBNfR2wXq7o26MZYG5WyvSTbAeTM9lG3dLKAgrBPUNDuDsGXONJR5g2KGL5quXFwnyWat9Y85wSYUIEwaKFUunkmcEdlR71bLt3bRQxVB2CnaTAa4dy9SF/LWN0TrpWN2ndkawsMpSkm1sPX/LlICBnnwSzxtu5w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9537.namprd04.prod.outlook.com (2603:10b6:8:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 07:07:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 07:07:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] block: fix bio_split_rw_at to take
 zone_write_granularity into account
Thread-Topic: [PATCH 2/5] block: fix bio_split_rw_at to take
 zone_write_granularity into account
Thread-Index: AQHbLoKZb0mXgEZCTESQ1KjTNcn0LLKs/MsA
Date: Fri, 8 Nov 2024 07:07:45 +0000
Message-ID: <ba51c228-00c8-4995-a9da-edf13c39dd86@wdc.com>
References: <20241104062647.91160-1-hch@lst.de>
 <20241104062647.91160-3-hch@lst.de>
In-Reply-To: <20241104062647.91160-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9537:EE_
x-ms-office365-filtering-correlation-id: b38ef00e-ed5f-435f-535e-08dcffc40bc3
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3k5YWNCRUVvc2M5N1cvQm9RNS9iQ2gzS2FBeHpZSUpmNGs0bGlDM1gwV1hT?=
 =?utf-8?B?ejh6MVpidlJpQW03WFRqTHNrMk03OW9tRVN3RUtETWl2WEhjV2gwcjZ5d214?=
 =?utf-8?B?aUlIUUZHZHVMd0RxU0pOeTRPSVB3SHVMNXpjakgrT3BFZmUwRWNOb2JkQ3Fp?=
 =?utf-8?B?UjMrTDhqdzFtckNyZlgvVWRyRG1iQ2ZPS1hMTHVIeXhJUXFqNUxBeDFSMCtr?=
 =?utf-8?B?ZVVkd2tPVmljRDZRdXpTdC9HaVFPcnhDN1ZIQXNYZUZaeTVTVGFXQm9MaVNj?=
 =?utf-8?B?SDdxZ243TzZPcTBlT1VkU2VDWE9MQUN0QnVCeFozeW1oUFhvbEZ5T3gxcE9J?=
 =?utf-8?B?dmh0RENYcGtLME5NWE4xRnBrL1JNZ1ltTmZuSjZrdEhqb1N3VyttcUFKZWQw?=
 =?utf-8?B?aVNYV0FoSlEwcHRRUVN4dkN4ZGgwQ3pnZS95TUdsVU56TDFtR0Q4MlVQUWYy?=
 =?utf-8?B?eFoyL1BDMStJTGswQXduYklyUGZML1NxckpZVnZVUTV0d1RVdm9yVmhCeks3?=
 =?utf-8?B?My9jemx3dEdQdmsvL1dZSlU2K09pYVBkU1pnUFkvUkw4K2dwNWJDU0ZjYkI1?=
 =?utf-8?B?RUVUL3liNnljalJaQklFMytWWUZlZ1lTSjdBTHJ4VzUxTG5oOGd5QnFacFNW?=
 =?utf-8?B?YWZxbnl4V2hrZVorVnhlMWEyUG0rNWV4NlIrR0RPNjRRR0V1RGM5OUxvR1ky?=
 =?utf-8?B?aE1IWlluVjhtYWtVK085a2xOODRLcCtOWFFjeHltWS94dXdpUEtqSHZKbVUz?=
 =?utf-8?B?K1hIdXVCbXRiR3RHczB4ejBtbVNNWHpjQ3NPQzlyNmVuNlg4L2hOekdHbnpt?=
 =?utf-8?B?NkdrTGhLV29VbGVsSzdrd3ZkaFNBRmtoRkxSMlpqbkFhMDNZY3JhVjhTL2Y3?=
 =?utf-8?B?TmI3NnM0cVI4YTg5bUFuOXh1WnFDM0FJeVRQSUI5Q2RMdEhycXNzN0JkaGov?=
 =?utf-8?B?S05wSFlIVThQVUtLQU8xMkowSGFXYlNiN09mQ0FkQmY3Y0ZYWGdmb3BsNFlt?=
 =?utf-8?B?OHZGQVZRUmdpL3V3clhPdkpUTUhvQ3BtdmRtVTB4VjkxRFFOTlUwNWV6UjJv?=
 =?utf-8?B?ZUN4djZNL0wrdVQ1T0VmVjVWcUlJak5hemJUZFhmRDhpVHh2dWc5cWkybmY0?=
 =?utf-8?B?S1RZUEgvS3ZOaEtndllxNnN2RGo4aDRzZExVWXVPd29OZHlhbXFuY3VTMVdF?=
 =?utf-8?B?ZXoxNXFQUWhaWnJLN0cxVzBQS2cvWFR4dWtjaVdUVUhvaXNENEhDQk1WNG1L?=
 =?utf-8?B?bVJ3cnBIMTNDTzVkYUtweTJLcVczQU9JUHNQd2NjVS84aFU1MjZ2UnRxQ29Z?=
 =?utf-8?B?R2hBQWhNejA3ZGZtV2hmbHltUm9SUktsN0lhL0hoUEdibWxHV243aWw3SlFu?=
 =?utf-8?B?NEtodUU0MFlaZ2N4ZGg5T2k4ZVM5VCs3SUNrMlFDWTU2SzNVNFRnZ0UrTzhB?=
 =?utf-8?B?NUJvZUZpZG4wR0RqNmNhcjc3KzBjSWR0RENVazdodGxsTkd1MHN2OUpYbTRz?=
 =?utf-8?B?ZGFYeVhOOGFyamZ4OHViOVNZc1pmcGRka3A4ZW1rd2haQTY3L2J5bEJJcFJV?=
 =?utf-8?B?cFl1UXplb1Zsb1RCMXRSY0c4ckNmc3N5bmVFeXRUbUpCRFdwQUI0TUZ3M2Vk?=
 =?utf-8?B?OHpVSlZ6MUt6YzkrbndDTnlNLzFBbHR0bCt1WlVHOGoxZFJZNzNYZ0E1WTVo?=
 =?utf-8?B?NE1MQ3I0cE5CMG5KRzYySGNCS0FHTU9OL3J6SjZ1NVRSWHVVQmVpNVFLbnlx?=
 =?utf-8?B?TDVTQVJmYis0c2hZV29xVjJQd3lTZ0cyQ21Yai9JWFpyNEhxTVo0VTl3bitW?=
 =?utf-8?Q?fpjVcgdyenChPMTJmyRC4geN2kEZR4nwQn3K8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGtyWFd1WjU5MzRVNy8wSis5LzJobVNpN3BiMllLNjFHK29oTFNydzRkZ2tH?=
 =?utf-8?B?VDhybEhCeklwZU1DRGZBd2xmUVBwWjA5ZVVqNlBudnI2UTE5MWpYVlBNR0FZ?=
 =?utf-8?B?WXB2U3FkVWZ4QTcwOGZRRGlESGJUTkpZSHJ0NTgrdHZWSzk1RkpXZU50c0NH?=
 =?utf-8?B?a01jRm94cDgvOWRlVWdKT1pXT3VxUnJsRkpCeG1xRTY3OHpSTi9LZFZlRkhT?=
 =?utf-8?B?cTFaNThkajIvaHdib24wU28rTTNWbndDNlNoM3lRNmFuYkNOVkRveTJuLzQz?=
 =?utf-8?B?SGxEdGwzYmRGQnlFMmVQTXhLMk4wbTQwQVp4amxJZm9JVGtpWkk1MllMRjR1?=
 =?utf-8?B?TUlwanE2MGlFd243Z3k0S0crcUpXLzc5MU9OV1pOMUROQ05saWd4MGJ5ZHNy?=
 =?utf-8?B?VVFkSTVZY2lrWDd0WW9jR1RFSFRsNm1QK2FraFdrcTFUSXVGTTFLQncxK1Jp?=
 =?utf-8?B?ZGRtbXBNTEllT2NFc1A1VjB5eGVwcEh3UFBWUnRoeDNENmg5Uk45YnpBM1N3?=
 =?utf-8?B?K2hGNitmQjN4YWdUSzgvNnl3akl1dmNOOW8rWjM1TllaS2hFeUNMRGFUSlN5?=
 =?utf-8?B?Ty8vZnBkbEFlY2VBdTlhODZ1OFU0NjJzUnJKY29LMW9RNUlRSjk1bFhSTll4?=
 =?utf-8?B?Rm8xeEdMd3RGMk45K1dUZUdKelBWdlBrbXdmVnhLRlE2U0dCVHNYcGw4MTFq?=
 =?utf-8?B?SXFQb1U5MFJveEpiU09KM0ZyWUQ5dlN1WEFIYnkwKzg3SDYxR1U5NmpsVFB4?=
 =?utf-8?B?NUptNlErcVpzU0hiTkdGdHM4UFFkUWs4OHdWNEsyU2llajkwMHJ2NUp2bDJ3?=
 =?utf-8?B?N1p4SHZoWHB5dmw5Q1pFOVpENGJ1c2lkd0JkRFZUbGtFQnpsQzBpUVJqOGRL?=
 =?utf-8?B?L2NvV0Q5NGRVbFBjanZuL0dSZTQraU80UUlsa09iRlhSVjBCWHZZV0NTcTg4?=
 =?utf-8?B?MVVjVjdCOGdNS0FQNk1XN0ZpZTdRY21CcTdaU1U3SFFyak42cGxyMnV6OXhJ?=
 =?utf-8?B?K1BiRU5TRnNrMVRQN2FwY1k4Vmk4bGVYMVhGM01ST01nQitaaVJSL1BMQnFU?=
 =?utf-8?B?aEtsK1RaUVZ3b2VxcVhJaHlWTkw1WXVNeXdrVWxHMDZuOXBxK0FZMGhyVGFw?=
 =?utf-8?B?K1RXVGYvN3pKSXl5SlJDT0t5WTlLckErMHZDS09qRWprQ25JNG1zUUllcE4z?=
 =?utf-8?B?OEJoNTAxOVdRZEtVNTVMSXZSakF6SW5TSC84OC85VklraEk2eDdpQU5BSDJ5?=
 =?utf-8?B?bCtscnNoQnFSOFJKTGI4ZFZuTDg3eFJCakhIZ0NiaDdadjBadURrNUErREFP?=
 =?utf-8?B?QVBLell1em53a3BLMk9wd2w1SDJDbjh4SU5MTks5ODZzdFZhbUNBSXVyWWZh?=
 =?utf-8?B?Q3VkK1lKRjNvR0t3amhqVFdYUUR1bDhxRDlaNWYwV3VDRy9CTGRvaUVTM0NV?=
 =?utf-8?B?Q3BpZyt2QzFYQm1IZzZmQXFveUxJb29FR29XeklNOWR3Z04zMkdBTWNrMUI2?=
 =?utf-8?B?bXo4TlhmYUkxRmkvaFRTVThUeW5CVmpOc2gvTWtIUzFvTDVrL29GQUV5YmN0?=
 =?utf-8?B?aCt1dVJGYnBidkJsbVVzMFpHd2k0UE92YVBMZzhyaitLUG5DalJhTXRWSDNE?=
 =?utf-8?B?WlVTR0FFeUlob1BNak1QeTVyUkxBSXdhaE05MG4zWjJWTzd3a1ZLYjVJRU0x?=
 =?utf-8?B?UDZjWkxyRlRJaTNRMW0wUFVSWmdBQUtYNnlQUXp4bHVHTzduYVFIK0ViNm9w?=
 =?utf-8?B?eVpaUkdoSTFZb0hNM3M0NEJCMzlXRzlOWDRZL0cxeUk4VlF3c2RRRk5NQmd2?=
 =?utf-8?B?Rm1Ucm55eTRRTE1ZbVZDbGRVTllHeWpDeHZuTFZ5eUNGZTBiSDh0TnJjcktv?=
 =?utf-8?B?eTczbC9lNFdQdWNjTmhXMkJIY3VoZU1TTitXaEo3MjNvWWhkcityN1V0bldB?=
 =?utf-8?B?Q01UbmxEbmVmdzBmMmdhakpDK1BzUEpGOHM3cE1iK3JySlVtaytpa040YjVL?=
 =?utf-8?B?UnUzOFdYbFpUYWZTcHZ5M2xaSDh0ZTY2WGk3SEtKM0xUbnl0UkU3dlJLL2FS?=
 =?utf-8?B?WEpDSFl2UmVKNTFwdlVLWlZFMUFoRis4Yk1Xam5kNFdvNTRIM0tDY3QzV1li?=
 =?utf-8?B?TTVGRCt4eXNHUzJFZWNVQWxLSnNIWEhueU4zYm5uVzVQOXl1T3A4NmxVRmtD?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <310B1ACCF44C9D44B900943745C70986@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t6LhI+iUWfVKn70zbz1o7uh47/MBPHOwauLTnYbaB5HiUjCd8D1SGHndrzcDnTLa2RxCPsfMALI6gaGq82hDiZGEpCHvoDExIt6yDWFXbzBP0+PTnPFBoC4Y0vL/lYuVGn2+Udroc2ToxxEnhKEqfk1Oqd+Mx5j81hbe1be6Pd83yNNKFk2sZRd3Fm09GHaBdIDCGtXpFGfHdILGrkJmJPilkaSNvpjvL2zuNbO0KQTJ1alwvKAS7Mqy9pUO1UMZZcalrhMRi/KoWVtxzGeHvRXpBaCScu0ZKh55phanjVj3sVx3NvB/wd+IX7LwVttJX6RJhBHs4c2fzwHQLm9b7RX08mfmQe6uI2Sz9rC9L9hR07t8p3vUK6zQ4aPp6Lov2j5uSeNHvMiZ14tAUNUYOSL+uf7oLQEPIXE0VBtDpd/m4o3rXsAUwERoQYosGw2BQfkMFExQvIZ8x7k6ZeB23/m2RENZBiob74IaGKTKB1wsIwi8NeMnnmpgFhMQIqU2RRATNA40ZAKj3aAzXOXkar5DLbms1dPGFWtqicfmufWj4PwavWJHs0UzAlMGL7V9b430De1AtIq78HH+yxMJnnXS0b38lYRkNv50YJJxACMzC7u5+LeIaCgSlSHRQLO9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38ef00e-ed5f-435f-535e-08dcffc40bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 07:07:45.5224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: op9bCen2jY3ttyZSHJYx2Zb8jiykeVvl1jFeY12UPbIxF4CdUtXbQNEhNgjMeMU4cvqNQgWq8tj9sTsRE9kZqN+bWoGpCig3QwtEdraBpRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9537

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

