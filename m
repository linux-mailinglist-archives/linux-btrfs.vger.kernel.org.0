Return-Path: <linux-btrfs+bounces-10312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8499EE262
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 10:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F47F281DA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2520E712;
	Thu, 12 Dec 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HLxcAbEH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gMouRyey"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E420B808;
	Thu, 12 Dec 2024 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994846; cv=fail; b=Ox1jvJyjo2ADsraqvN5VCjXLfuDuqbQtSezs3XqjK0xBkCczaio0CBHihCtqW30J6O6h5LoFf1CF/kjXaRuY/FTHYWUfeHnMIDqIAuEf0gxANw1D5gjfi59BnzipK3FK6p51kZWvyLgq03D1lPWNpJ3dJ6XbMGrL1KzFSnp0Xns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994846; c=relaxed/simple;
	bh=5zYa9Y+vtpp7c7OUkBKAlDa4jY/NhqXgQFrfP9QvqDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eo++bFZC7p517ygma5L0t/b8yG2SsOFscEV2X1v/U1eF1ProxiW8IMlqEbSMOi50XX9uP+m49mVYZJr9Tt/qD7UkPuO168k8ANBvWinu7cRBC9yRG6+Mr7zS3Epa4CFCu0sERoieH4Z9qPZGEHIB0SSX1Cok14Vzrm2Nzv5C6Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HLxcAbEH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gMouRyey; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733994844; x=1765530844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5zYa9Y+vtpp7c7OUkBKAlDa4jY/NhqXgQFrfP9QvqDo=;
  b=HLxcAbEHceQgQCQwzWB+vpZ00WZ7NwEFwAcUGNMc/XRfkq6VXOJP6+rz
   znNEscJndzip3xqrjDBU3LUK2iQz+k5O05eFLoOkWZkSWgeaePlyoIGSL
   cwLJ4lODhkkUTOcpsWlhMfSv3eTd1ZfIN5v3Da8wkmZl2p9VMGeDaNYwC
   Tiqc8DbHtgukZeF0CkMqJkx9ZQ564fFuKkux0VLnIbE70AEm+xnVOnbpl
   f279cpKn9yVp2t66UXfr6KQXlTid9A2Zwow73zkzRsuu1ww7RlXBGPDFw
   DbwKwpFcQOAZioAun7v5ZqVOEZp/4f/cEC8f2CwS7KVmXdsLb1m0EJHfC
   w==;
X-CSE-ConnectionGUID: Ibf08wfTTUKR3UtkNE4SuA==
X-CSE-MsgGUID: p54LMFHcQ6CKzxMHPuOQFw==
X-IronPort-AV: E=Sophos;i="6.12,228,1728921600"; 
   d="scan'208";a="34177332"
Received: from mail-westcentralusazlp17012039.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.39])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2024 17:13:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu5MIMGkjEeSgqEdEhaZVvFMF8e6qbMZUHIlgO16PGoPQ5KnYkMDOSWpE0IXThhKisRGYSeoZkGESPvF3X1hXudB2KosmMtTPyyiwNTMA2Kp4x1gTLpff1E/2Wu9ouSl/c3SRpDGGIYnbgw+WK3nWsxHUdomTWEeZ5mIytO6O7hkiUmtgR0VQ1OUnFUQWCib2iX4JJomVHYcGtxlBNOz/vlcTeMjaODTHUVJfln7flBHcHmtesdMUwx1HLt3ChpzaMGkoYMfNFxsYVeOo6FLrEyFmI4+/EgXPqCD7HSqfnrToTMsMqTd/NJpUE8PW+9nLL6Ro+TGPHsxzB8uJkJ2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zYa9Y+vtpp7c7OUkBKAlDa4jY/NhqXgQFrfP9QvqDo=;
 b=eB2ZMKWumqRCdaLXDYJCLxpPrWIQdT/zIqgvgpVZS74OL3MYYZg+XEYYJLrnO6iShgBVWZl7FxeaM8dV1yd9hy/0qZ+4subAKyc1cwqYoA8iZsQacJ9AMaQpY933Plqsa9MCQ4F43KADYl8bWxbyW3BZJ7xvNnLzdgQCwZKOLDgfajJKmQvYm3euECVjEihandpLKyjm43w+MM1ZVQNqEBG2v9lW+LajLpXAkY/uYwE8IKJiKR5U5+NIYaniGg4O/BlNIDu1B+5WA7eFmFfgQj9MfN9Yd+C1WHV1q+E4LU12Xz+PcJXRqCrYlp+jWFAqdPRIAQ0GgjMk/tm48cna5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zYa9Y+vtpp7c7OUkBKAlDa4jY/NhqXgQFrfP9QvqDo=;
 b=gMouRyeys5yQ4F83fNj9DDWc0wfMVGQrnQXOMgCSQJqJ6iF6/bnbFbrK1FOF59jYbRqT4NNE3ftRd9rI4pGgBM/jt4FUtLkUDT7YK9AvN1BQXvdP0rJdWSm4rZj6bq9PddKnM/guutacYfd+yAHVGnG5hlaKaExp7zx8MrO8gQ0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9448.namprd04.prod.outlook.com (2603:10b6:806:441::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 09:13:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 09:13:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Omar
 Sandoval <osandov@fb.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
Thread-Topic: [PATCH] btrfs: fix a race in encoded read
Thread-Index: AQHbTGsKZcn7mGCkaEKERxWN6qbNxrLiPuOAgAAO24CAAAJwAIAAAbCAgAABooA=
Date: Thu, 12 Dec 2024 09:13:55 +0000
Message-ID: <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
References: <20241212075303.2538880-1-neelx@suse.com>
 <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
 <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
 <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
In-Reply-To:
 <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9448:EE_
x-ms-office365-filtering-correlation-id: 443c1fa0-d03c-4fee-43a0-08dd1a8d4e25
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vm1ITm9JajhRMExHZm9NTlNVOGJibHBvR0xWWjA2Sk5ncHJ5U2R1bE0yamRE?=
 =?utf-8?B?OWNhUFoyRXdsVjYvc0NUMXJyTFVoc0w4OHVveWNKNFlzSGFIZWxQd3pZTWpn?=
 =?utf-8?B?UGNCMDJDelVDNW9VZTFHcTFxMWx6QVM2R3N6Nmx3UWV3YnVhRGdsbWdqMS9H?=
 =?utf-8?B?Y0phSlpyMXFnS0wzaDExSmw0a1NDa2RaYStaa3JGK055MTRiWS9nNWM1VXc3?=
 =?utf-8?B?czJZd3pCYVozK3JGdm53T0VVVjljOFNwdGZUVmZlRmwzMC9DN21NTU5Ic3Z5?=
 =?utf-8?B?QmtZaDVQQlVZc041Tk1OZXVvUHhWTFJHK1RONE90cXB1VXFXS2Nsc09pdjIr?=
 =?utf-8?B?c3piR1I0SWdkRTlRMURQQm5IUDVyRUVoakozM1dkdE9RVkNSSGVNZjZlU2Fs?=
 =?utf-8?B?dU12YkVPaE83MEd1Mm9TazZMME1GOG52SXFJRk4yUkZwNFBScmliOXprR1Rm?=
 =?utf-8?B?bTBkaW1vM0xYYm5jZFRjUEpISGtZQU44aFEwaVo1cUlFMVM5SVFpc1dGNEND?=
 =?utf-8?B?c1JocHFIUXlDbGM3TXdOUTMwelo2d2FlTkJ6cmpLMjNLVEtWOGJjTzFjWVY1?=
 =?utf-8?B?c2xXTDFpNk04RTZ4UEk0TUdqaUFlS3hxQ0txbFpFaitNNlp3dUkzVkJQUzVk?=
 =?utf-8?B?VnY5bllhUi81SEtoL3ZHV1gwWm0weGtPWGYvRWw1aSsvRTNuWjh2QU5pOFM1?=
 =?utf-8?B?YlE5RENPNVgrbDFHcUgyMGgySVpqM09PMEtXa0FqR1VrVHN6QVZtdlZaYWFR?=
 =?utf-8?B?V1c4ME1xaDB6THNyN1lGamtJWEZ0QUxkNVhWczZaanBZNHBRY1V0Kzl2Ylhi?=
 =?utf-8?B?a2NXODVDeklzdGs0d252STFtdEJRR0ZVQnd6bG51TDd3MTkvbThWRlVDTVZn?=
 =?utf-8?B?THZzbTg5WUxobUYxcW45ZmJrV3RrR3Z4OGNvd2Y0N0JVOUs0cXpKUk1XNmxk?=
 =?utf-8?B?cXdGZmJOREZIN3lCMVNqVk96cHBIK1h1bDExdjJlRXlFMFFuKzNmYWIwVm1m?=
 =?utf-8?B?eExBanA4RU84MUhkdmUyR0tmeE01N3hIamRnVWt1S1M5TFhUaXNPS3RMWmFE?=
 =?utf-8?B?OUdVamFFNjl2YldndVR5MkRpY096eHl3WE1aVTRzMlByUEJoSVZnMnVzVkRa?=
 =?utf-8?B?bHNUVzdoV010SDRFRVB6NVNRdzV2OTU0MFdjYnhHQXRmWU5sOHE5eHRqUDR3?=
 =?utf-8?B?V2haN2VIY1k1THJIeXlpUjR3WVFHSkZkTzg1dDQ5TlpkOG5BeFZmWVBVb3px?=
 =?utf-8?B?ajNzNG5IYTZyMTFjMThxV3RINWRIdk5vQnhlOEp2S3RoY3NoaUJBcVVJSUxr?=
 =?utf-8?B?Y1lsQ25BbXJkS0c2dWxDaHMwLzlwck5zL0M2RExQbGVyaFlFSXJMNmc1WHo1?=
 =?utf-8?B?TFVGK3ZtdkNkZkFXRWhFK3AyaFd0d2Z2dHN0b3pxcWFQWkprak1JTnNZTWRk?=
 =?utf-8?B?NUJPckhnYUZWL1pWZ3pxUENyQkh3dHkxSWFvT2xDRzBXeGU1NVM4VUdObzRI?=
 =?utf-8?B?UnRtMDNBRVZ5ZHc5UE9XdERvaVlHeVBPWWJIS2FNUk91c3dXY1lhM01zSysv?=
 =?utf-8?B?UFd1bnRmRXB3UFQyT3kzMTZWVnVIVURwSTJOc3pPKzdDdkczMkRnY0tnREc5?=
 =?utf-8?B?clJ2RlQ0cjdOazNBeVlPTnVNak84Mmtwa0N0M3JuZTcvQUM1ejR0czBZWjdo?=
 =?utf-8?B?K0hPQUlYSFdnZnhxdXRKUE4vL1FKYVByL3FjcnJYT2ZwOG1aUG1iWVB6dnZ4?=
 =?utf-8?B?cjJxck1VNXJFN3ZwY0dUSDJvUDdHMVdkcXg1bGZjTDAxeitsNnoyNlhsRE9D?=
 =?utf-8?B?OWZMVnBUa3NHbndMQW1uMVc2WlRXY1lUc3RHbjVjNVBHREZlL0gyd2NQQW9u?=
 =?utf-8?B?NnpGVmhRNDNsKzRrU0luLzBnbjFobzVranAyNEtZMEhTQ3NaREgwclZMZkgy?=
 =?utf-8?Q?P2LcbfwgkD4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T08yZUdyd1VvdndIaU9MYStoRUtEUENNYW1PbnZFY1hCcnl3REpSTmd3a21x?=
 =?utf-8?B?OXZSTm9IY0FiKzNnem5GdEVSSGJWeEZTOHBHZmVpR2ZQTXFGL25OQjI2VlI5?=
 =?utf-8?B?dGhjeXphTHYrOE5VZlBRMW5jRXRRY1FMSGdBdXhIbTMxM041MGtncEFvNlAz?=
 =?utf-8?B?SldWbVNEWXVXU04rYWxTcVRCeEQzU2dTcGxuQzBTTkcrd012RTNaRmlaQWpZ?=
 =?utf-8?B?VG8xeW1VNCtMWml2RzRuVmR6dHVOVlgzNWwrSGNjTG4wNGJ3NTlYQkg4em1G?=
 =?utf-8?B?TE8vbnNGWmdkTUU1SW5hME9tZFFQRVZOZGsrUjQ1aEhVTnc3K2FRbWJLT1Rz?=
 =?utf-8?B?THplZHZnZmliL3VJZjJQR0VQeHNJYVJPSXlVbWpiR1F2MjFDdDNhRkFjNERq?=
 =?utf-8?B?UVNNVjV6V1BPMFdoVmxmNnpDdFBnOHovamo4SGdhM3VrWk10NitxaGl5V0l3?=
 =?utf-8?B?SFNXTmdseU9VSGlJN2xBOGpEcW5xdDdwZW1qeGlhM05mS0VDWjVsbG9NMmJp?=
 =?utf-8?B?aEFLZCsyMWgyVVYvelpzMytnRVJLVk9TdDFsUFozQ0ZXd3o0MEZwNUFKODMr?=
 =?utf-8?B?aUJpRGdwZUpLQzc0Uld2VDhlZlg5L2N4cmNtN1E3c0pLKzcybFQ0VFJmR2o5?=
 =?utf-8?B?bnRlc0cvMG05UFlnY1cvRGFtQjJWSzRSR2FlOHRZRlllUFh6OCtLdUVRZDVZ?=
 =?utf-8?B?a01vOVpPKzNBTjVocWhiODBFZkNDQTlVaGtVbWlsWmRXU1FXQzljd28yK0xl?=
 =?utf-8?B?SGJJWElxcDgrcjhnTE5Vc1puRTNhdVhBOUJrMHhhbHVUK0o2ZlpPM0lvei9I?=
 =?utf-8?B?NzdTRmN2WWl6c0RxMXl2YVp0ZVMvYld5TFFnUlhGdkt1VEF4M1ZnMmFKa05q?=
 =?utf-8?B?WEx5OTRHcVhsN1dJVS9BdzdPb05nSHBITUVpaTFNQVJJaHBiWGt4MXBudlM0?=
 =?utf-8?B?U3I0c3ovYXZvV05FcloxT0IyL0N6M0pBSjBvdVYwanhtSStzY1ZDOHdzdnRS?=
 =?utf-8?B?TncrQjF5THkwaW1oNThwdzQ4K05VWEN6RW9FUTY5UHZ4Uk1wUVNYYkJ0Rm5z?=
 =?utf-8?B?M2ZSUWxVQWYwWWpCUVh2dkJJNnRWQnZZbE1NME1DS1NQbEFUb1lhZDNMemZV?=
 =?utf-8?B?RG9Hc1o5TEhOb1ViaC9qTkg0OG5TbHNzUzVtLy94YXhXSWlTMS9JSTB5dUth?=
 =?utf-8?B?a1U2M25yc1ZnNU5DTHFnV0NSUXBZNnlod282UVZBTXFOK3JhTmhuU3lxTGZE?=
 =?utf-8?B?cnMvRmx3eXJJbVVINEFSWkxXbW5JOEJ2aTJ6eHFRNmV3c0l6NDJmV1I3NnZt?=
 =?utf-8?B?S1BERWJQdUY2SWxRRGw1MExPbnNOVTd3UnVpV2EyaThzZnF6SXkrVTNTYitS?=
 =?utf-8?B?UnAvNGZ0Y0hScW00QkwvNFBCMmQxaExYWCtBeHlIM3VQS2RqdlpJZGNoLzVI?=
 =?utf-8?B?NXFnb1dnNElJTjNIaG8yVlFrK3ljdC9XK241eUJ4SUtkc2pBUnl1YVF0c1pi?=
 =?utf-8?B?NjRrOVJpa2dXY1laUmp0WTF2TnkxNW5LTWV5RkpPQVV4eExyS3lNMm9sZStB?=
 =?utf-8?B?dHZxTU0zRDNVZ1dwQlpHU1BYTXpuYjJQQmZwZ1RIWFRtUktOckM0TEI2N21F?=
 =?utf-8?B?VllwRTloSnBuUzZBRThlclpaWVVCRi9rUGFZdzRiTTlUWUdVVEFKbDJaZTZI?=
 =?utf-8?B?c2ZqNS8wVEhSYTBFbGI2V082a0Q0alIwTzRydTNocTlRWU1jMFU0WW1RQm1B?=
 =?utf-8?B?Zm1qdVFXY1ZOYVBzcWpVdC93MTFvYkIwd3V1Ym9ITHFmWEEzK2JVM29sVzNi?=
 =?utf-8?B?c3NxazdoeVRRUHRjeWJ6aC94OVVMcGU5ZEJkSmQ4MmZLNVZ2OVRPVW1RY3JB?=
 =?utf-8?B?cmVrYk01Z1ZDYXU0L3gxTSs3c3krNlFyTWcvRFkyVjA4YStGSWFseUdYaWVY?=
 =?utf-8?B?TzgrUDhIY25SdzM1R0FsZHpJeXJFYWxsemxtYWpjY0Y0SGFoeHBVN05VZUo1?=
 =?utf-8?B?Yzh4eUt3a0lVTkZZekdtb0dscWZPMmFITmJvb0hKYS9wUnAwVFVvbEdPNkVS?=
 =?utf-8?B?MUVDdHBQekt1WVZPYzRURjdvY1JnUVhLUEZ4bmxYNGdqSjRFZXo4bHh5TU1X?=
 =?utf-8?B?VmwwZk5EKyt0TXkwZnFBdzMwKzg1M0YwYjExZjQ1QTFndVdXNVhCMndqSHJp?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82E7E1CA11EDE74CA6B9AD9CBF939DDB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UhlYMHWdMb+eUrGtfn2uVEfyrI2cgKYtvqTqeRH6ACW0jMk/5ISBHvjAHui10bT+I0tCLSV8XFraMvL56+Lr1b5ca1T1FrIEfgrzW3p6ET1SfHjcwxaf4xePnEKPCsWJKNNDo/LENXcWjD8XwrxGIJwZi4dhkdwyZzsZ9F9itEsqrKExorvMcVuDM/OdAAO0YYanUeDlfqocIhJ+hZvz44XlfoI1FsPQj9siiaANGKvXtrDK6jBTtazqch0Jy4At4cKV/55NL+rQj+lBFsUplLo2L4DEFEdlbpDbNA0BAzgjGmzfpp6r5ckpPAXM++i3rJNnQsGVIPkPajdM+YBo4NOQZnW7oyPpaD8ivUSEIAC2gNtGgc667DsXevzf8HFWFi9PKXBRpvSssS8CH4XfONKDOePi+lTEfcz9nyaNqrJDcqdI1NtUh9QY4ad8vQzNKnUyqEwJpYuDUDVJaTye80X6FWNlJdehQGiUhZqKzBkpHbY8SImq0od/aYNkoO98C/+cedg272py/vMBIRp9PYfjcZpJ0pn95DxhQsU2ZRsYenUK1JY6HuDRHqSQNmL83dB25jQINaqHfdidKQvMZ+Zt8g/KKC6sdDFYaOaMVaDTX3Zhwrt7WvQhm+mKh2F5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443c1fa0-d03c-4fee-43a0-08dd1a8d4e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 09:13:55.9925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2hybiBOzRtpPYkW3fVQbW7lyD66RI0FetkI7iYWFdVrGMhFMY4Qhrg/ymjkZ7CiTWlDsqI7gLZTvPC8hjn11E9DRcOe8AbivmrVNd8WIkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9448

T24gMTIuMTIuMjQgMTA6MDgsIERhbmllbCBWYWNlayB3cm90ZToNCj4gT24gVGh1LCBEZWMgMTIs
IDIwMjQgYXQgMTA6MDLigK9BTSBKb2hhbm5lcyBUaHVtc2hpcm4NCj4gPEpvaGFubmVzLlRodW1z
aGlybkB3ZGMuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAxMi4xMi4yNCAwOTo1MywgRGFuaWVsIFZh
Y2VrIHdyb3RlOg0KPj4+IE9uIFRodSwgRGVjIDEyLCAyMDI0IGF0IDk6MzXigK9BTSBKb2hhbm5l
cyBUaHVtc2hpcm4NCj4+PiA8Sm9oYW5uZXMuVGh1bXNoaXJuQHdkYy5jb20+IHdyb3RlOg0KPj4+
Pg0KPj4+PiBPbiAxMi4xMi4yNCAwOTowOSwgRGFuaWVsIFZhY2VrIHdyb3RlOg0KPj4+Pj4gSGkg
Sm9oYW5uZXMsDQo+Pj4+Pg0KPj4+Pj4gT24gVGh1LCBEZWMgMTIsIDIwMjQgYXQgOTowMOKAr0FN
IEpvaGFubmVzIFRodW1zaGlybg0KPj4+Pj4gPEpvaGFubmVzLlRodW1zaGlybkB3ZGMuY29tPiB3
cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+IE9uIDEyLjEyLjI0IDA4OjU0LCBEYW5pZWwgVmFjZWsgd3Jv
dGU6DQo+Pj4+Pj4+IFdoaWxlIHRlc3RpbmcgdGhlIGVuY29kZWQgcmVhZCBmZWF0dXJlIHRoZSBm
b2xsb3dpbmcgY3Jhc2ggd2FzIG9ic2VydmVkDQo+Pj4+Pj4+IGFuZCBpdCBjYW4gYmUgcmVsaWFi
bHkgcmVwcm9kdWNlZDoNCj4+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gSGkgRGFuaWVs
LA0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBzdXNwaWNpb3VzbHkgbG9va3MgbGlrZSAnMDViMzZiMDRk
NzRhICgiYnRyZnM6IGZpeCB1c2UtYWZ0ZXItZnJlZQ0KPj4+Pj4+IGluIGJ0cmZzX2VuY29kZWRf
cmVhZF9lbmRpbygpIiknLiBEbyB5b3UgaGF2ZSB0aGlzIHBhdGNoIGFwcGxpZWQgdG8geW91cg0K
Pj4+Pj4+IGtlcm5lbD8gSUlSQyBpdCB3ZW50IHVwc3RyZWFtIHdpdGggNi4xMy1yYzIuDQo+Pj4+
Pg0KPj4+Pj4gWWVzLCBJIGRvLiBUaGlzIG9uZSBpcyBvbiB0b3Agb2YgaXQuIFRoZSBjcmFzaCBo
YXBwZW5zIHdpdGgNCj4+Pj4+IGAwNWIzNmIwNGQ3NGFgIGFwcGxpZWQuIEFsbCB0aGUgY3Jhc2hl
cyB3ZXJlIHJlcHJvZHVjZWQgd2l0aA0KPj4+Pj4gYGZlZmZkZTY4NGFjMmAuDQo+Pj4+Pg0KPj4+
Pj4gSG9uZXN0bHksIGAwNWIzNmIwNGQ3NGFgIGxvb2tzIGEgYml0IHN1c3BpY2lvdXMgdG8gbWUg
YXMgaXQgcmVhbGx5DQo+Pj4+PiBkb2VzIG5vdCBsb29rIHRvIGRlYWwgY29ycmVjdGx5IHdpdGgg
dGhlIGlzc3VlIHRvIG1lLiBJIHdhcyBhIGJpdA0KPj4+Pj4gc3VycHJpc2VkL3B1enpsZWQuDQo+
Pj4+DQo+Pj4+IENhbiB5b3UgZWxhYm9yYXRlIHdoeT8NCj4+Pg0KPj4+IEFzIGl0IG9ubHkgdG91
Y2hlcyBvbmUgb2YgdGhvc2UgZm91ciBhdG9taWNfZGVjXy4uLiBsaW5lcy4gSW4gdGhlb3J5DQo+
Pj4gdGhlIGlzc3VlIGNhbiBoYXBwZW4gYWxzbyBvbiB0aGUgdHdvIGFzeW5jIHBsYWNlcywgSUlV
Qy4gSXQncyBvbmx5IGENCj4+PiBtYXR0ZXIgb2YgcmFjZSBwcm9iYWJpbGl0eS4NCj4+Pg0KPj4+
Pj4gQW55d2F5cywgSSBjb3VsZCByZXByb2R1Y2UgdGhlIGNyYXNoIGluIGEgbWF0dGVyIG9mIGhh
bGYgYW4gaG91ci4gV2l0aA0KPj4+Pj4gdGhpcyBmaXggdGhlIHRvcnR1cmUgaXMgc3Vydml2aW5n
IGZvciAyMiBob3VycyBhdG0uDQo+Pj4+DQo+Pj4+IERvIHlvdSBhbHNvIGhhdmUgJzNmZjg2Nzgy
OGU5MyAoImJ0cmZzOiBzaW1wbGlmeSB3YWl0aW5nIGZvciBlbmNvZGVkDQo+Pj4+IHJlYWQgZW5k
aW9zIiknPyBMb29raW5nIGF0IHRoZSBkaWZmIGl0IGRvZXNuJ3Qgc2VlbXMgc28uDQo+Pj4NCj4+
PiBJIGNhbm5vdCBmaW5kIHRoYXQgb25lLiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPyBXaGljaCBy
ZXBvIGFyZSB5b3UgdXNpbmc/DQo+Pg0KPj4gVGhlIGZvci1uZXh0IGJyYW5jaCBmb3IgYnRyZnMg
WzFdLCB3aGljaCBpcyB3aGF0IHBwbCBkZXZlbG9waW5nIGFnYWluc3QNCj4+IGJ0cmZzIHNob3Vs
ZCB1c2UuIENhbiB5b3UgcGxlYXNlIHJlLXRlc3Qgd2l0aCBpdCBhbmQgaWYgbmVlZGVkIHJlLWJh
c2UNCj4+IHlvdXIgcGF0Y2ggb24gdG9wIG9mIGl0Pw0KPj4NCj4+IFsxXSBodHRwczovL2dpdGh1
Yi5jb20vYnRyZnMvbGludXggZm9yLW5leHQNCj4gDQo+IEkgZGlkIGNoZWNrIGhlcmUgYW5kIEkg
ZG9uJ3QgcmVhbGx5IHNlZSB0aGUgY29tbWl0Lg0KPiANCj4gJCBnaXQgcmVtb3RlIC12DQo+IG9y
aWdpbiAgICBodHRwczovL2dpdGh1Yi5jb20vYnRyZnMvbGludXguZ2l0IChmZXRjaCkNCj4gb3Jp
Z2luICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9idHJmcy9saW51eC5naXQgKHB1c2gpDQo+ICQgZ2l0
IGZldGNoDQo+ICQgZ2l0IHNob3cgM2ZmODY3ODI4ZTkzIC0tDQo+IGZhdGFsOiBiYWQgcmV2aXNp
b24gJzNmZjg2NzgyOGU5MycNCj4gDQo+IE5vdGUsIEkgd2FzIHRlc3RpbmcgdjYuMTMtcmMxLiBU
aGlzIGlzIGEgZml4IG5vdCBhIGZlYXR1cmUgZGV2ZWxvcG1lbnQuDQoNCkl0IGdvdCByZWNlbnRs
eSBmb3JjZSBwdXNoZWQsIDM0NzI1MDI4ZWM1NTAwMDE4ZjFjYjViZmQ1NWM2NjljN2JiZjEzNDYg
DQppdCBpcyBub3csIHNvcnJ5Lg0KDQoNCg==

