Return-Path: <linux-btrfs+bounces-5199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3378CBB9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72122829B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E9779B8E;
	Wed, 22 May 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="guN8bggc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n7QlkZI5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D374E3D
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360836; cv=fail; b=L2GX3tszhxFrR9CyeeY1sBhEmB7s5rvPq44g4pmPjJWnMdqjRe2HMt5dF0/W7XTdmewvrvcxlHGjK114rqo1+0N7vs6yLLJk3QleYLK4sgBMytkzqIlLnMzfgHnM+QNRJJqo8ThqyCQ5tcMQDwalEqKLG0zwcRU5uuxZV80Z3uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360836; c=relaxed/simple;
	bh=xAuV9IOXpCb9nJQlE5ffYhLJMzKFQmrPZwUQAqLh2No=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xf2YQBhmf/9Mgn1S0weQW37ogutOeDpr4u0SlTRKrZCNYkA8SMqrZ5lQJyeebV2H1fN7xujUdxHiOw+ESX41ih9goPJtXC/GAkvHVe9eznxA5vkcKuScKEX8h+iIQQfPtFd+eTesIRV4cLdNiu2AHsMSExqn0veXiQW8BtmqFPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=guN8bggc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=n7QlkZI5; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716360834; x=1747896834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xAuV9IOXpCb9nJQlE5ffYhLJMzKFQmrPZwUQAqLh2No=;
  b=guN8bggcRpPCyytjVBRAKbR1RA1u2y4GbV5j+4zuTZ8/E3xHrj+gvMG9
   h2fE6ltsGeReTAVTjWlc53znpkqhiqqtPZXLsgsrcb8FV6IYEUDyZOBQ8
   rg0Gvc3XcqkHwmmvhh1ySxKBHIglwcEZNZW+AUzaMnf6L6TjinUZcHT+u
   ddryy2MTQ3eNdrdM9JZhHuwxF6JACcYERxPaQAhQpmM4BN3jqLO1ZDDud
   oI8lWZFWQK+1FQM7zoOUbzXRHUu4hBx/KaVCGtEM0kC5WCLUs3f4CF3ZM
   JcRQ5hCQj3KMhDhU5BNjRwE0fC90QoIKDB5o3UF8rOWsaawFzTrl1WOwl
   g==;
X-CSE-ConnectionGUID: FIxra4tARoOauRDWAhq4aw==
X-CSE-MsgGUID: IrJ7AFw+ToO398y3gMrTLQ==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16259580"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:53:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVgUF9oSn6CD3TEPkJG5DyUA5rj9MTp/34VrJ4ypTG5V9NMJ5DJewjBSdf1hnir6EQfBvPqzDFCMfkejenTjjFeBcmuNMRts8JoQykhuErYKp2/DmLLy4l6a/4RvrXCoxwiUkvZrfamKCPbnNZvzvBFKQDGTlwAZZE/mPi/ckBiKkLAgOEjPqzIcxb2ly844TdEC9QnsSEUXHVKckWSu1fcjGmhacZ+kdkemmtp0Z9qzl6yPemX0QubOqTvL6tBerC5AOMjXWF1Jf4rKwuUmUDpoHmHnqSvREo7FC2Vk/mG5Hx5yN7RWlNcJivsO1RlwEFEb5ahXmZKLxW1tJQdESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAuV9IOXpCb9nJQlE5ffYhLJMzKFQmrPZwUQAqLh2No=;
 b=WJVdgVgnd72QD7Pg8lqJMKmLQ7Mk3m1LejKZGIgUpf406ShtNDGxxDmI5J4wR9v8WTBhOgS4JZGt3L0p4HuoXH1BlqBW2JW1M8oRKVzQ8ySgi7zCj5DxIVeUflbf7JTedyxkA6PRtCodvc7rNKKEfxYAJ0fRoTlVNMnwRwvN2Tezkkm6r/5xEiYls8wYcNWxpZ/uQIcp3D5GAN3gsnckn0zCD2lbtdaTsDvaIB+4IzzzXht+Bs/BhgXuKwTt4FWb7AeZmqOarMJ9fOFjLYi6t8+hY0yZdEhjAqxcaiL92Q+87HBy0KmZ53JvZiuA4ltU8QVZ2sdoPBLiXHt9Rt1whQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAuV9IOXpCb9nJQlE5ffYhLJMzKFQmrPZwUQAqLh2No=;
 b=n7QlkZI5gqqB1qL33eY3gkHwNLJ7DCbZs2KKzetuHoxxk7dBkqdu9zGc2y7qADTELWTGfm1XYlP8sNnW82AHwVZb1SCiFhL78PKMmHdFXBzNYizaY/TjiRfxjmE2kSq8bucNcUH6qNplvDzH5BdP93P6/AQ6rxv7S7Gz3jTx2EQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB7113.namprd04.prod.outlook.com (2603:10b6:5:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 06:53:44 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 06:53:44 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] btrfs-progs: mkfs: align byte_count with
 sectorsize and zone size
Thread-Topic: [PATCH v3 05/10] btrfs-progs: mkfs: align byte_count with
 sectorsize and zone size
Thread-Index: AQHarA3OVyCLtEbdpk6dZ1SNvKiIPLGizqAAgAAC1wA=
Date: Wed, 22 May 2024 06:53:44 +0000
Message-ID: <qxt22d23dea6fb3kipftgoa7v3lxegh3ynxpgz3iutnfxpxqba@chnvkin2on6k>
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
 <20240522060232.3569226-6-naohiro.aota@wdc.com>
 <d959127a-d0f0-4444-a69a-0ffa1002d5f1@gmx.com>
In-Reply-To: <d959127a-d0f0-4444-a69a-0ffa1002d5f1@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB7113:EE_
x-ms-office365-filtering-correlation-id: c5fc6804-c5f7-4d09-4ff8-08dc7a2bec53
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?czdheGs4bzBENWlXYng4Vy8zaTBsRGJwbnAzSStKUUU2NkRENmR6aG1ldEVy?=
 =?utf-8?B?RDRPZUNsZXpObWI2TzBtcmd4djZEbExydGZ3UXdzK0V5RnV6TUNici9kSmpa?=
 =?utf-8?B?eEJ6dlh2Mm8xVitneENFanoyZ3RraFJwdlpnM2JkMU9hYkowQ2NzL3ByQUlU?=
 =?utf-8?B?MFBRU1h6RjZ3SmtINEd1Z0xVMzNJNXVqenFVV0lWL2N3TzBsSTExTy8wZXBj?=
 =?utf-8?B?ZXBoNzlXSzY3Y1ZFS0FQYk5ReUZOSmkwMEMzWFNhWXpZTTJNc1luUjcxdjBi?=
 =?utf-8?B?eU54WHhwQW1XWXg5ejdPaFI1ZEhobWFmbnp6V3VXd082SW9iYWt2cXJxTzlp?=
 =?utf-8?B?b21OeEM2K3lHWlN6T01BZklrNE8xdEgrZ2NvZEJnUGk2a0pxdGtCMHg4cHF6?=
 =?utf-8?B?N1o4YVJxQ2hrT09abjRTTG80ek8zNC9VUll5MUhpZmtRaUREM1ZtK24yVXJF?=
 =?utf-8?B?U0ZkWlE5Y2xxRXNFVWxUNjJTeENmd0J5YngwSzJ4ZXNkWWs0SHVjNFgxb2JK?=
 =?utf-8?B?Mmg3ZitCQVJMdGZJbzlrNGlGNVg0SXV2NWdsZUdrTnJWNkFQMFlzc2ZySU5p?=
 =?utf-8?B?L0dycEl6RGgxTnRwL2VoRjBheEp6UnRNamJMeEZrL1lvaWxxQ0IxdXhvOWpO?=
 =?utf-8?B?Um5NaHdtOTZYdTRzRUdqZDVtWGVvbFBuSHNxQ2RtRVdaWE1DUmhIMTZKL0hV?=
 =?utf-8?B?QVlZUXpUMWhWbTdreVNXbU5iZk9DdDFhMXZYYnFIWkxZQlEyVEFkQTM2bkNL?=
 =?utf-8?B?WUV4bGl3cjViVStzM0hScEIxa0I5bFcrRHJNdnZoKzVqcXJCVWtNVENmbkQ2?=
 =?utf-8?B?Y05aSndQYVVRdWZodzVrdnBpN0JGbHoxaFQ5MHk5c0JZYm51VG9ROFBFRHA5?=
 =?utf-8?B?QTBoaURYN1k5OE1RZ2EwK3JuSHVISUZWL3Qyb1pQeTZ5YS9DZ28yRlpzcC9P?=
 =?utf-8?B?Vzd4VUg1YUEvUVprQWtFL3pnZFpXVm5QUTBCS1o0dDFNZGFJZjEwbzR0YnN3?=
 =?utf-8?B?VG9IR0xDV0YzTXpSNFJvZlVodVRhWGtoWGtnV1FmeGVUSGRKR1J2K2ZkcmRB?=
 =?utf-8?B?YUZvZGxHUTdPdjMxQ0JYRVBuZVdSV1o2LzI2Z1R1RUY0VUx0UzZ6SzFlMmFr?=
 =?utf-8?B?V3dlYVl4eW5DdGx4cS9XM0ZlcnVMOXBkRkx4eXVXR2JTN2MrS2NqZHVoTWN2?=
 =?utf-8?B?S3ZremdvYld5Um9kZVpKUVEwVnh5cWhXRjVVQXVRQ0lmSFdhZ1VkZmp3Njcw?=
 =?utf-8?B?cnVqcUo2cHM1QldvZHlad0IwdUtXS1ZyazRnaGhZdmorZGwrNlBsdjVaK3Zq?=
 =?utf-8?B?cXpKUzh0cENreGhZaENTYUoyYUl3SlBReGFGc1dpZ2J3TVRxL2VvWkEwMzFv?=
 =?utf-8?B?SkE3emtmY0NwTUg3dXVCZ2pYNDRNR1VWQzdUNGtHMFAxd3BsbFVldkhWb3Rt?=
 =?utf-8?B?QXZHdThsbG1hOTZPaWlSSDZIVkxvdnFpTDl6bWN4RTMrOHk3R0puV0RUZDhJ?=
 =?utf-8?B?dzVhdGRwYjkvMjN1MEZFWXF5Tk55N0V6N0ZOeHJLUy9GejdWWjVFYWtxdE9S?=
 =?utf-8?B?OXNFQ2c1SjIxTnVpTVZBL1RYejdJK1ppajd1OWgvNUR3aHd3M2N4Z3BqQ3hW?=
 =?utf-8?B?SmViaGx2OWxMbkZJeXNVelJHSHhhRFNYaE9pWEJ6V1NRU2wzWE9yZnNUc3dD?=
 =?utf-8?B?YnlpRHE0SWFnNHNHbjV6WjFMN20vNW1BUXJRcWNpbnkraUhGWkVNYi9ld3p3?=
 =?utf-8?B?ZDZtVjZMVTRNdGFXcDRtTGJLK2U5ZEdJN0FqRVdrUGhWNGJONG9SME9obGJB?=
 =?utf-8?B?bmZybFVGcU4rWlVJb1V2Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mmoya1k2eDE2dGNkOUNJcnllbDhHaEtaMk1hclhiUDNlNXVGV3dYZGxhaVYw?=
 =?utf-8?B?Zzd3S0pJL1hEOG5JWHRKdEdoZzZOc3ZVQnlzODlaR3ZlV1lDRVZ4ejJCMXlN?=
 =?utf-8?B?UlBlNjFYRXozbUI3bkIrMXduajhwTWdCZlNXK3A0aFdwOXNSV2VEMFpmTjVi?=
 =?utf-8?B?bzhjenV0aTYxZmorK2RpUHlHMmJna2hxNTgwUkhCTnRZZTN0MktRWWFLdEcy?=
 =?utf-8?B?Vm5iWHZod3NmUVdNaHhLazJLdHhIekxFYnl5ZlZ0dDlpSXdOZDhhZngxcVlr?=
 =?utf-8?B?NFN5cFZSMldOdnArR2Z4U1liSjdvUFNHREM3dm1aQkQ5a05qYTJGRU5FSEVN?=
 =?utf-8?B?WWpFOW5td2g3VHZ0OXNTTmJQNmZPM3c5Z0FwdWFmejJid3NxYW8rUDB2SUVO?=
 =?utf-8?B?RFE0aWREWU0weElDRlNQWi9EL1lpeXpBRU1wemFYRVhZUUJvazlFS3R5Sy9S?=
 =?utf-8?B?Y1pGR21jQ1prMXVJZ0wzSkFSbm1rczZzV3E3a0gwL0xMTVRBTUFNYm81Q3Iw?=
 =?utf-8?B?UG1xVktTckxScCtjWXYyTUhYWHJEQm45YmNOR0RXTWc0QjlSUlRnamF6U3A4?=
 =?utf-8?B?RjBNUXMxbE04N21paFBES3BsYS9rd2VGaEt1WjUzdlpaSUxrS25OZkRad1Br?=
 =?utf-8?B?TlhHa2hYVWJqQXJ3MkdEam1ReHhkWXhKM2w3RWhuQklvbGlnU0tEZzRSRzl2?=
 =?utf-8?B?S3hMK3Z1Y0h4NW1YVHJtVDcvbTBIWEoxU1dSZGd5WVRTYlNsZ2pmTnNGTXEw?=
 =?utf-8?B?cDB5eXlGRExRN2tqV2dVeDMyOVVROGFTeHcrV3pWMS9XaUNDQTEzaW1XVkRp?=
 =?utf-8?B?Q3RuL0luVEZkM21jOHRrczdxWm1UYUYwNE9zcnhFamRGUm1lV2xESHVQcVQx?=
 =?utf-8?B?bWdoQ3ZJY3h1dTdjSnYxSTlITnRwZWxzQ2QxMGR1SUxBcUhXMG1EaDZOWHRJ?=
 =?utf-8?B?aDZPUVg1cFJoUkdDMURXczJNSFIycTFuZTQ1alh3eU5za0d3NzkrR3hGOHY4?=
 =?utf-8?B?bkltRG9aa1FhU2JPZ0FPWng3RjVzY2dzRC9MNy9ZWE1iVDhNMEY2TGNxQVZQ?=
 =?utf-8?B?Myt5eDBBQ3dPdnlMdXl4OTNMWEtic1BDanJkVWErVUhpaVZPYmVtMDlwOEU2?=
 =?utf-8?B?cVlkVHQ5S0t3VUdsa3BCc0V3akJmTzdrNGp2VHhjNlpXaE1NWjdOMTQ4WjBu?=
 =?utf-8?B?Z0c4ejl4dWRxaWpQdEtnbm5ZUk9TWUJwYmZiRjBmcUhvYVVxTTdGYjNPcm9M?=
 =?utf-8?B?TGJqdWZtMFBjUkVWcFRXNDc1RlJpemh6bDNsOUdTT0FDQ0dwZUFGclN6L2dO?=
 =?utf-8?B?Skx4ZWpmRTdCRTdndnI2aWlHOGVmTlRnWk5GSkNsNVdwRkljMlNzR2hnNUU3?=
 =?utf-8?B?OER0UFk1alZYRk1saFhEeHZ6eGhNL00zOXJSWlBiTU93RFpOT09rQkg2T1Vt?=
 =?utf-8?B?ZjFWVnd6WW0rbnJpY1NaZjh1RTU5aU4zN3B4dUF5Y2hKUWFldUJxcWQ2SndN?=
 =?utf-8?B?cVBvMmJHZ2FwcEtBS1pQM3Fyd2VYQ1RkVkw3QXdNK0dXMTlFVlJOTzR6VXdK?=
 =?utf-8?B?SkM1OXhXSGlWWFc4REJ0Y0ozSXUydTlJMjNaRE1ZRW45QzAxUEpRU1pQSTdt?=
 =?utf-8?B?OHBPSTNoUzl3WGhvMWRVaHU4aHVSa1VGOEt2czNESzlVcGpvbmkraVZjSTQ0?=
 =?utf-8?B?OENVbXhFeGJTYm5SRHNsU0RacGRXbm1nOHUzcnY4NCszbStqMm5icXluOWk5?=
 =?utf-8?B?Wlp2cDBIeUtDOUc1U29vYVgvcEp0NFFNd3FjbEpXMC8rT3BrMWY5Y3R6eHZM?=
 =?utf-8?B?MjMvWXVKMXorUnZUSyttem5TanBmcmRUQ01lcGgrbVJtV2s1S1p0YW1mQ0x2?=
 =?utf-8?B?SS9mRmtzUWhORFA5NXBrMG1tNElwUXlzMUNRdXNuNllKL0tad1J1QW4wSVRr?=
 =?utf-8?B?aDEwNUZ3OGFld3EyU2d5d05RV08rSThXZ3JKWkg0dXZtUlpjVDdxRFlHS0w0?=
 =?utf-8?B?dkc5RkowbkdpVHB3VWVaRlFKNkFKeEJrRmFaajJUakhuNGFHRTZ5SisxaEk2?=
 =?utf-8?B?N3B4c3VoOWJabEIwTmdwTytDTi9USUNVRGVUdExUZnY3THdxRmZRbjl0aVRJ?=
 =?utf-8?B?bEoxaHJmWUNvZ0VwY1BkTzNkN2JvSkJEZXEzajdadmczZXNQeXJSbkpDMjJ5?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F116D439C02514E8541B8C3BF2E2A9E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2eM2Cgi5gGEa9Zs1WGpqvDkX1TFbbhmwtOhBlK7rNIjlIJJaT1v8KoQvxYCFekvY3XhVtX3MaidOABC/b+uda3wqx2V9tzCzviEBRXPIdw5Cj57LtjK1SeA2S7AlbbgkOKgbgGC6XMjYmFC4RsIBud9eaphAtbRXpuwqKkuBjcxgl2BKZfFZqFmTnAkwJUodzmjwVs3WNDbUPWN5x+kgaGSvJpUb4GV6tVFWnOy4TgkDMkOv1VXCOmAdvhnkXjR0q6G7L5GwIJMshct3xo7kzB4MJZm3waMd+EuWr5iJvS377p6CtQfKVWVgGFdxSwh8fZuL1hL2gZNdceghf3zxDIu/IJ5IFAzCqTdS5ey/+1edZopx9k6ZL0u9tbhU7lAgEUznSzD/xUEEtQpv2RQiaplgZhHxQBm6rHRjCK9B8IVk1WirBwoFWxs4YF22bpmknc0uhNzb4jYSoIDzeBCFFeAi77EkqOLxWcHk7byKBxdpVnTUus0rSdDUju//S/7X0jSbz3MgajXZMCd1rvszsyqTz1gN0g8z+QwT1tjbAP4EEQTmNHwxVvRd2jbPZoSyF1GvxXAeRxSDVmz2y41KROYRJ90NDxYhRlV8zjoUc98v/j7652j7awbQIoy8orPz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fc6804-c5f7-4d09-4ff8-08dc7a2bec53
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 06:53:44.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBMxMqJuuJIl8t/D45hPWgHhZPoRP0V2/B8pJlhXNc0xhV3qD8hFEim1UOhUOS6M2tXlSn9Dq6SdvMy7dOPWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7113

T24gV2VkLCBNYXkgMjIsIDIwMjQgYXQgMDQ6MTM6MzRQTSBHTVQsIFF1IFdlbnJ1byB3cm90ZToN
Cj4gDQo+IA0KPiDlnKggMjAyNC81LzIyIDE1OjMyLCBOYW9oaXJvIEFvdGEg5YaZ6YGTOg0KPiA+
IFdoaWxlICJieXRlX2NvdW50IiBpcyBldmVudHVhbGx5IHJvdW5kZWQgZG93biB0byBzZWN0b3Jz
aXplIGF0IG1ha2VfYnRyZnMoKQ0KPiA+IG9yIGJ0cmZzX2FkZF90b19mc19pZCgpLCBpdCB3b3Vs
ZCBiZSBiZXR0ZXIgcm91bmQgaXQgZG93biBmaXJzdCBhbmQgZG8gdGhlDQo+ID4gc2l6ZSBjaGVj
a3Mgbm90IHRvIGNvbmZ1c2UgdGhlIHRoaW5ncy4NCj4gPiANCj4gPiBBbHNvLCBvbiBhIHpvbmVk
IGRldmljZSwgY3JlYXRpbmcgYSBidHJmcyB3aG9zZSBzaXplIGlzIG5vdCBhbGlnbmVkIHRvIHRo
ZQ0KPiA+IHpvbmUgYm91bmRhcnkgY2FuIGJlIGNvbmZ1c2luZy4gUm91bmQgaXQgZG93biBmdXJ0
aGVyIHRvIHRoZSB6b25lIGJvdW5kYXJ5Lg0KPiA+IA0KPiA+IFRoZSBzaXplIGNhbGN1bGF0aW9u
IHdpdGggYSBzb3VyY2UgZGlyZWN0b3J5IGlzIGFsc28gdHdlYWtlZCB0byBiZSBhbGlnbmVkLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5j
b20+DQo+ID4gLS0tDQo+ID4gICBta2ZzL21haW4uYyB8IDExICsrKysrKysrKy0tDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9ta2ZzL21haW4uYyBiL21rZnMvbWFpbi5jDQo+ID4gaW5kZXggYTQzN2Vj
YzQwYzdmLi5iYWY4ODk4NzNiNDEgMTAwNjQ0DQo+ID4gLS0tIGEvbWtmcy9tYWluLmMNCj4gPiAr
KysgYi9ta2ZzL21haW4uYw0KPiA+IEBAIC0xNTkxLDYgKzE1OTEsMTIgQEAgaW50IEJPWF9NQUlO
KG1rZnMpKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gPiAgIAltaW5fZGV2X3NpemUgPSBidHJm
c19taW5fZGV2X3NpemUobm9kZXNpemUsIG1peGVkLA0KPiA+ICAgCQkJCQkgIG9wdF96b25lZCA/
IHpvbmVfc2l6ZShmaWxlKSA6IDAsDQo+ID4gICAJCQkJCSAgbWV0YWRhdGFfcHJvZmlsZSwgZGF0
YV9wcm9maWxlKTsNCj4gPiArCWlmIChieXRlX2NvdW50KSB7DQo+ID4gKwkJYnl0ZV9jb3VudCA9
IHJvdW5kX2Rvd24oYnl0ZV9jb3VudCwgc2VjdG9yc2l6ZSk7DQo+ID4gKwkJaWYgKG9wdF96b25l
ZCkNCj4gPiArCQkJYnl0ZV9jb3VudCA9IHJvdW5kX2Rvd24oYnl0ZV9jb3VudCwgIHpvbmVfc2l6
ZShmaWxlKSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCS8qDQo+ID4gICAJICogRW5sYXJnZSB0
aGUgZGVzdGluYXRpb24gZmlsZSBvciBjcmVhdGUgYSBuZXcgb25lLCB1c2luZyB0aGUgc2l6ZQ0K
PiA+ICAgCSAqIGNhbGN1bGF0ZWQgZnJvbSBzb3VyY2UgZGlyLg0KPiA+IEBAIC0xNjI0LDEyICsx
NjMwLDEzIEBAIGludCBCT1hfTUFJTihta2ZzKShpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ID4g
ICAJCSAqIE9yIHdlIHdpbGwgYWx3YXlzIHVzZSBzb3VyY2VfZGlyX3NpemUgY2FsY3VsYXRlZCBm
b3IgbWtmcy4NCj4gPiAgIAkJICovDQo+ID4gICAJCWlmICghYnl0ZV9jb3VudCkNCj4gPiAtCQkJ
Ynl0ZV9jb3VudCA9IGRldmljZV9nZXRfcGFydGl0aW9uX3NpemVfZmRfc3RhdChmZCwgJnN0YXRi
dWYpOw0KPiA+ICsJCQlieXRlX2NvdW50ID0gcm91bmRfdXAoZGV2aWNlX2dldF9wYXJ0aXRpb25f
c2l6ZV9mZF9zdGF0KGZkLCAmc3RhdGJ1ZiksDQo+ID4gKwkJCQkJICAgICAgc2VjdG9yc2l6ZSk7
DQo+ID4gICAJCXNvdXJjZV9kaXJfc2l6ZSA9IGJ0cmZzX21rZnNfc2l6ZV9kaXIoc291cmNlX2Rp
ciwgc2VjdG9yc2l6ZSwNCj4gPiAgIAkJCQltaW5fZGV2X3NpemUsIG1ldGFkYXRhX3Byb2ZpbGUs
IGRhdGFfcHJvZmlsZSk7DQo+ID4gICAJCWlmIChieXRlX2NvdW50IDwgc291cmNlX2Rpcl9zaXpl
KSB7DQo+ID4gICAJCQlpZiAoU19JU1JFRyhzdGF0YnVmLnN0X21vZGUpKSB7DQo+ID4gLQkJCQli
eXRlX2NvdW50ID0gc291cmNlX2Rpcl9zaXplOw0KPiA+ICsJCQkJYnl0ZV9jb3VudCA9IHJvdW5k
X3VwKHNvdXJjZV9kaXJfc2l6ZSwgc2VjdG9yc2l6ZSk7DQo+IA0KPiBJIGJlbGlldmUgd2Ugc2hv
dWxkIHJvdW5kIHVwIG5vdCByb3VuZCBkb3duLCBpZiB3ZSdyZSB1c2luZyAtLXJvb3RkaXINCj4g
b3B0aW9uLg0KPiANCj4gQXMgc21hbGxlciBzaXplIHdvdWxkIG9ubHkgYmUgbW9yZSBwb3NzaWJs
ZSB0byBoaXQgRU5PU1BDLg0KPiANCj4gT3RoZXJ3aXNlIGxvb2tzIGdvb2QgdG8gbWUuDQoNClRo
ZSBjb21taXQgbG9nIHdhcyB2YWd1ZSBhYm91dCB0aGF0LCBidXQgYWN0dWFsbHkgdGhlIHNvdXJj
ZSBkaXINCmNhbGN1bGF0aW9ucyBhcmUgcm91bmRlZCB1cCBpbiB0aGUgY29kZS4gU29ycnkgZm9y
IHRoZSBjb25mdXNpb24uDQoNClJlZ2FyZHMsDQoNCj4gDQo+IFRoYW5rcywNCj4gUXUNCj4gPiAg
IAkJCX0gZWxzZSB7DQo+ID4gICAJCQkJd2FybmluZygNCj4gPiAgICJ0aGUgdGFyZ2V0IGRldmlj
ZSAlbGx1ICglcykgaXMgc21hbGxlciB0aGFuIHRoZSBjYWxjdWxhdGVkIHNvdXJjZSBkaXJlY3Rv
cnkgc2l6ZSAlbGx1ICglcyksIG1rZnMgbWF5IGZhaWwiLA==

