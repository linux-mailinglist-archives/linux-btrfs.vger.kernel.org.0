Return-Path: <linux-btrfs+bounces-19725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE5CBC991
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 07:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD24F30080E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 06:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A78326957;
	Mon, 15 Dec 2025 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rmvgMOss";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="plFbQXDk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E226F2BD
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778608; cv=fail; b=nn2z0fxxPaLAdvHM1YsssRyUwdLcU56JZFhvEcQkmhnfTgbWzKFyxrbh868qCgUwI/s4uaZeaXAoh/wo6gdlNccbid+HH4cEh4nOikOGLI+uyCrjJQPokqAg6n6kUiPUSYawwf/w7vYo34CLtokuBoILcpVO8n5ORux/UN2RGcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778608; c=relaxed/simple;
	bh=BTh4vZVIepC+attPH/o/sRBE22cRZ9bn5FhPQ5SpD5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oODFa8DTH53mIyIkIZmtLY9mXLXOv8coih6G57WrO4/9ALyN5ThTZJbv1ZSQD9FTTAFp8dMe+hfUxnKUN2T4IxcBf2nCeTS1TSatcrmvihwVTYr6IfXUwE/saW/6RlQwMD4JH2Na/g4mtmZSE4Q9HmYSNa4NKFigMw/rBtHC2wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rmvgMOss; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=plFbQXDk; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765778606; x=1797314606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BTh4vZVIepC+attPH/o/sRBE22cRZ9bn5FhPQ5SpD5E=;
  b=rmvgMOssIG+MY0y9p6MQcvhkcvxCZovYaiTJ1IULrxZeqr5UlyIPRhww
   r8ePR5TF8fpYj7Ktt4KIgWXMU0uQAHwp28KJ8oub2mhLIZhIOBcbIA8x8
   eQtxNKWmB8C9iD/4E9DJfe++Ez+C/PUNcrIqpBzLUta893gVW+PNPg5uF
   TzV8w3BtS9Zbvz2Beoc5umzJZyQ7W0hHEF8NlIGYTixmgpgSe74kY9Xd1
   PVYkoG+Z7HQ6gcThyy1bGOhYJZZbN7i9r2eXnELI0F3aWq2iMdWnAkf+g
   CcKOL9DNEp0IMz1Ln7k7SpPdXQLDwOYh7izFIJ3sbVSgiNGcatws/e3W2
   A==;
X-CSE-ConnectionGUID: Dhcsg6iETx2NQUhZDvqvqQ==
X-CSE-MsgGUID: wrdqufv6TeibMTfQD8fApw==
X-IronPort-AV: E=Sophos;i="6.21,150,1763395200"; 
   d="scan'208";a="133862650"
Received: from mail-eastus2azon11010057.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.57])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2025 14:03:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1neMzgGhmPKFrohHNcWvuVckh84Cdb0TYk3FHcKtslSgpi7MRcY/Kzi/LQ2T9dLapIrqd+WzUrzAA1ZEtco+HBGaeqNB4/8kDKHQdlTCPP4xGLLSsHPG87/FR4bbSwa/G44HdM3jXlJafM+2Vdnld9CuS1A/+OwSlMy5sQK5yhR02MoIuNhv1FsYs0VjcwY2BnXq3nblVQgWg5FRfKtAsqpIFJdYM9LhpKYc6ja/hRTt/9UjH/NBiQ58cRxzC8UvJkfA5ZvrdJdvmaJTH2He49pFlRzzUawenL5QmLqXdlIQDfKke/263Xy7nnbWD8t7FbMoGNH91dJstT+QItWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTh4vZVIepC+attPH/o/sRBE22cRZ9bn5FhPQ5SpD5E=;
 b=KI68TN/er8RwnYb0Wuphzwnw1DH1GkcMzAiHFBu6mlKGk2y/V6dhgBNAO/6VOrMV0Co2eS3OnQmNTMG4ZpBdawleojFzNcjRW9EyTMRO9+gyMUUDn+z5kKRIlXOUgbed69oBU5kYHM0uGk42Nf7QBbFjF5s6vhRexR26D5r/jmX2djuosno9GPs49PedV6AMKJyuCyQdxufdQOVTtkS+C6xLt598vBpLqWo9MWKg6eOFkIK9WUR1WpFbMJ8G+LxbK1COI5M988+UC6nZ2T/4l0GBWmbpsnVDN+Ti8COs6rcJ9Ag5wIqsJU4CWOqhb159zmtWq5LZOYJRi7RKmllCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTh4vZVIepC+attPH/o/sRBE22cRZ9bn5FhPQ5SpD5E=;
 b=plFbQXDkgawG6PRkvxt6lsm4TC0b88RMZDuHmRQgGjVoujnhWF8BZlX9t0A0DjCH2PeubqnOm47YPC1RRBg2VOtRBj52dlZcmhrYrV6y/Hlc34enp1rBMD9CS4WEGclzAP0LvojdzOj7mZbBhCzZ91wtmEVobtwUD1eAfyGWqcM=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by BY5PR04MB6374.namprd04.prod.outlook.com (2603:10b6:a03:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:03:17 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::1f92:3bb1:1300:b325]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::1f92:3bb1:1300:b325%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 06:03:17 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 1/4] btrfs: zoned: move zoned stats to mountstats
Thread-Topic: [PATCH v4 1/4] btrfs: zoned: move zoned stats to mountstats
Thread-Index: AQHca+3PGFj1Dt4I7EGeIxIA2SV9SLUiOSYA
Date: Mon, 15 Dec 2025 06:03:16 +0000
Message-ID: <DEYK9SK1I2A3.278C273M6V06L@wdc.com>
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com>
 <20251213050305.10790-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20251213050305.10790-2-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|BY5PR04MB6374:EE_
x-ms-office365-filtering-correlation-id: 580e52ae-cc9d-434e-7cf2-08de3b9fa3fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2lRWEdEbUdJbUlWa0I3YzMwVStwNHhuZzZIcWFBQ1ZucFhBcVpQSlhGc0pX?=
 =?utf-8?B?NmFkK2JPc3MvdVRRK1JWM2c1VGJzaVczSUt0RmVWb2pUMHBKVm9QWXE0WEM0?=
 =?utf-8?B?cDQ0UHB1OFZ3VVRCRFVqMVl5emtmR3dPV0g4RVM4Q1ZYditOU0h5dENhQ0pO?=
 =?utf-8?B?Tnk1dUxMWGZ5azVYOHdJSHhqRWFidkRtWDN1Q2I1Y0s4Q09LQmMwT1Y3S1ZZ?=
 =?utf-8?B?ZnZzZHZybU8zQ2gwTGVLd0YySm1oNzBqNVJZK2oxOGhLbmhHRnU0M2JTeDZl?=
 =?utf-8?B?TUp5RjYrS1NWT3l1TFR4Qmg1Y1ZWcS9XSytxNTBpYjdjdHhpUGNSU0hTMFFn?=
 =?utf-8?B?RG5mN2VBUUd0K0pjMURaZkJSV2M0TVZXNGw3U1NRbGxKTExJaHJnUXpMVktS?=
 =?utf-8?B?RDBCdmMzQUxJYkJOK0lpNXBicDJKblk5cUJiejRIQU9wSXlRZXBrVnNTYmlD?=
 =?utf-8?B?RnNCRnVnTmpkTWNOME5xK2kxdkpBaWFoTlFTekhPRUhQeE5QRXJtZGlraFNj?=
 =?utf-8?B?ZC8zOVlMdGNLek91NkVZTm5DMUJVZGdjd1o3WUl2Y3FZeXBQd1JyWFJadDF6?=
 =?utf-8?B?V1dPeXo3clFxR1lkK0M3YVhoMlJUMThENjY0RWNkaXczeXVBdmRHTTMyVy9T?=
 =?utf-8?B?M09hMXZMK3YwbzJoMXpEdVpMWlhmcEppUGx3eXZtYy9pZ0xGZnpFQ3BPVXVU?=
 =?utf-8?B?N2JKbzQ5WDlmT1RhT0hGYmxQeXByL2pzSzIrUEFDTGJTQXI4N2Y0Tk5tczcw?=
 =?utf-8?B?MFNTUjFRc3g5TE1MZkxVWFVwOElFL2gzM1VzY0duM28zOUdOK1ZiL1lWQ1dN?=
 =?utf-8?B?V1pIVVgyL3ZvRXM4MXBabDhvdVZVMmdqZHk1UUVVWmhOdmVKR2lvTmhtN2hq?=
 =?utf-8?B?NlF5Qno2S2lidkIwYlVGeHdlSk5jWjdSQ05hU2lZRGc4cVU2dXpvTitwdTJi?=
 =?utf-8?B?VE5JM2Rrcko3TE5RbUhBWWlHOEd6Z2NmNURmeTRNMW5xS0V6R0h2Tnp6N2x0?=
 =?utf-8?B?UmlSM2Nsb25RVm9PSGcxOHd3c2dsc0YzeUlpbDFoUk9SOG5SUUNYUGtHYTd1?=
 =?utf-8?B?dU9YdlFNZVZDMHhYcTkvVFdTeXlPTmtBb05MdnU5TmZWUkZZV1RjeUppdVdq?=
 =?utf-8?B?MU1Cd3JIR08ydzE4TXo4NndGaVZwcDZBdDNUQ0M5QWdyclEvNTAvNDFjVU1W?=
 =?utf-8?B?dmlLblZPR1I3QmFvbkVnbU9vS0pRWk1NZlRLVHZwdmNsaUU5QkJ4VUFQTGJC?=
 =?utf-8?B?SkhkQm0vd3BoczEwMXpWYlBIOUIyeTZSRC9hNmFvR3h5dmFIZEVDWU9wVllC?=
 =?utf-8?B?bVBESlphcTdSdE1Zd3FZdEFiTkY5MllWMURaZ0FJUGJTaHU0ZHpwREhXSm04?=
 =?utf-8?B?UEFMVSt1UDVDZXZXNDVmRmgzcUd3OS9JV0N0aHlaT1ZWcGRUVzlkZFhESTZt?=
 =?utf-8?B?c3lZRUgxNHpHRkhOSnlqSDZVaUVCN1p0d2ZBdUJOL3JlYUlyMTdLTkZMTkJv?=
 =?utf-8?B?YzdJNXFqQ1l0SEZPTXZBcEd5aDE2TVBCWE5BQ0UxT2N1d2V5MGNmc1BWenFY?=
 =?utf-8?B?UjRhQ05DQnFKQWtwQm1HTWhPRmFkVkUzaHJacE1Gelg2YnJnM1ZBWHQvVzBN?=
 =?utf-8?B?ZW11aFJ6MGQwTTY2dnVHdkk1K0dBbC8rK3FUaCtqNXhWVEdnaDVzeVFqV0Nt?=
 =?utf-8?B?Z3pTVmRjRjc3YVEwRHM3TlNCMW9EMG4vY1FjN0k5Vm4zTVFNS09QUk5Rd1li?=
 =?utf-8?B?Z01KNVlLZ2ExOUlxd3ZHNC9pdXlCUzgveVNoUW9LQ1lpd09KZGo1N0kyQlpO?=
 =?utf-8?B?UUVNZ041NVprOW9GQ3FJYXpMMFVJNktCZ25kZU8zQ2MrNjdxVW1EbWtMUncv?=
 =?utf-8?B?ZVl6TWVJWTVJT2ZKQVg5eHIwVWNwdFdvWVBmYzRQSEFIVm9rdFFSM3lFOGV3?=
 =?utf-8?B?RFdrZmZJTlpHcXcvbC96UUtnSHRTTVVwYy9MajdLR2xETTdESkdKeTludnd6?=
 =?utf-8?B?VTYrT3BxNDkyY3loVEFZVldLazAxa29YU2VUR2RQcGtSeXMreTVFZ1Z6bU5z?=
 =?utf-8?Q?tZhhM+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEVrTUVwaDVOMy9xWWNwckMyTzJja3VONFVnVXYxb2NjNjVWV3hFNXBrMXlU?=
 =?utf-8?B?KzRFemtsL2JONFl6VFBmekdIanNDOXA0VWMyNms3QnJrUU1Mak55V0RLV01N?=
 =?utf-8?B?SXVVT1JoTVZaTFVIbnZFWDQ2YkhxSnd3dHVTRTVkQ2FlQUlCZ2J4ZkFIOXc3?=
 =?utf-8?B?bzFScDdsNFZ5c1lGM3orTFh5T0oxZ1dHcGJJSEVJOXQzUWdrakhsa3lZRWNu?=
 =?utf-8?B?dDg1RjdFemFlckd6OXRVUmNMbW16TjZ3TDc5T1lqajYyZ25iZ3ZLaEdsOVVP?=
 =?utf-8?B?K2xPMmE3S09VaVphSFM1SE13Q1J1LzFuNVRpT1UwZ05zaFMwL3FTdVVVWTBN?=
 =?utf-8?B?WUZ2QlM3WW4wOWhkUzNVWGZqc2F3WVRsdmdvM0UxNWZUYmVhRU1PRXdOY20w?=
 =?utf-8?B?a1RCTzkzdldXQWJtYUprRVpKWndzTWFsQW1pK2tGZ2wyRlZBS1h3LzV4ajY0?=
 =?utf-8?B?R2NhdERFT1RVQm9CWVZoVmh6bjR0NEl1QS9kUndXdmdGSnBTcHRoK1dIWHJw?=
 =?utf-8?B?dGlRdG9BaTYrSEVSaXZma3lQQnozb2VTdVN6QzVKajVHc2ExSzdvaVhXSmU2?=
 =?utf-8?B?VDZzbDVxbWhQSlNzUDhldzhxZGIrOU9nWEdDeVdZRURDelZRS3N6a21JQTZN?=
 =?utf-8?B?WXh3a28ydGhmWTNkd09mamk4M2kyZnJyeHRBOU5GWnB1VUtSbUZxZVd2TG50?=
 =?utf-8?B?czVCbXlEZlJ1OXI4YWZNZDd0YnZGVzZreXFTd0xRYVd3YTdReWp0REdkY2tD?=
 =?utf-8?B?Z1Ruc1pnaXR5MndxVlJCNktXK2JINjdVU1ZaekNEbG1iTk4xZmFQVG5tUENV?=
 =?utf-8?B?R2E2RnBINmgyYThaeGZydmVRcGVFTmN4OWNneEdQd2gxZ2dRRFAxUGtmV0dK?=
 =?utf-8?B?RENrM1VuQkdIVFZzY1FKZ2tyUnZJbDBVTlBlSTlqd0lRR2VHcGZhaEVGZGZV?=
 =?utf-8?B?QVExNXQ3QzFqZVBzM2pmbzB3aER0V3VGQjI1RUJpbVhoekpMczlEUSttc1dV?=
 =?utf-8?B?ZGZKSVU1czhiWDFIQytuNU4yRGQ5UjgwbitlT2V3bkJ4ZHJtYzIwSXAvdlZy?=
 =?utf-8?B?bHZBRGRVQUZHVUE3OUJEc2R6emQrOCtVaVJhZDZyS2ZMK0dlVkJHKzhyUWRI?=
 =?utf-8?B?MzZvWDF4aHB2aVZXcUU1Qm1rcXlOOWsrR09VNmgwM3pWREJNeTVieFNsYzZo?=
 =?utf-8?B?OE82Z2drRXJxdHJIU1dyRkx5eENWc3NsTy93YVFvM2tBT2tZcWFXdTJORE4w?=
 =?utf-8?B?NVNtcDloSlZxRFF2NlF5d0FYVkZDSUF6dzBydEJGWFBqaFdiUXJ2UE0zM0Ux?=
 =?utf-8?B?NXkwYko5Ny9PcmxVaDZZVFRxdmREUEl1UWNLRmE5a0VYbW5TTmdPSFhVdWVt?=
 =?utf-8?B?UUczWnJrV0NTQVFlY2Vva3hlTUtrQlRVYnFrcFhXSWxqbk9sa2xWeEJzNjR6?=
 =?utf-8?B?K2V4VW5FYmlnTUNLcGx0d0tLejJZNkV0U1FlcDFCNng4bHR5YStTWFpQbFRr?=
 =?utf-8?B?NytheVNRdHdkVFNpUTJXQUx6ck9GeVUvSlh5UlVNMTFoWS9jWnZzQWRLOUxa?=
 =?utf-8?B?ejBwUElKeGFSKzB4dHlDWnhKZUxVdG1OeTE2YzVGZWZQZnB1MGtsUlJYbDV5?=
 =?utf-8?B?VUVkQzk5ZkVPd2UvV1FheDd1ZkNFei9hRjM5emdtOTFFSGdRa1l0clpRTDVE?=
 =?utf-8?B?MnNUNENOSTFrNjFldng2TDd5UVEvT2NlMGhCN2VHUmF4azJMOEQvcUxVbDcr?=
 =?utf-8?B?KzRGYlp4Vk9MdU1iVi9JSWRYMmhPVE8yQ0lQNzV4RFZCa1loTllyb3R0S2NH?=
 =?utf-8?B?anNMY2MvNXdmVHloelRHcnFsam5TVWQ0Qk5QcVd2WHFwOEIzemtTWFZZVmI1?=
 =?utf-8?B?alI5VG1wMDYvMFN0MCtWV0ZVSm9GRHltelZ6VG5SYXVjcHluSVRZRjVJeGIw?=
 =?utf-8?B?WER1WGJpdkhyaVc4R2VqRHJQcERGS1R1dVUvQXp4Rk1Iemp2TUNpRmtYUWlY?=
 =?utf-8?B?SncxYnB0RE1MNVhBV0JucVB4SFluR2pYdEREdFk0bXc0cUd2WktWK256cy9K?=
 =?utf-8?B?WDlDU3ZxSVA3SVpFV09VblVwL1RwRjErK0hvT0p6cWRqT2NCcldHRnBUd3R3?=
 =?utf-8?B?b3M2KzNnWUFhUWJQb0Q2WXV1MWEyTEc5bHRWSEo3YlgzU2kwV0NwRkQyUitB?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0915508839EDCD47B44CA86F724246A2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dA5kgxgYSXFUMK/HWS4BRbuLgGbBzXMeJfEQ6ng5RUx5A/lu03GuIdMs2nccGcYaloBjvf0T7ZBoxgNmXAkUI8Wux9325UaPS7FJ8Cvano6tKTPW+mGusxosQJK3NI/yI22CZwJk19TY9I2QKtM0s46K0s/KmZTqIuHxaeaC1hqfw4/qDxlo86UyQSO5XFRf3SjBR1rGJ3J/pN9ymnllavkE+W5KfVyTxWmlbRS6fuxQJ8D9p5AeOSgitSOI7C19LBkfLqaNzGXmYS0VYcfxsVbFq06wiQlt/UjLqRhqIluDTryorGSaab9Mo2p6o6yQehJqOfAmoHz++3tGarjQkd3x2BgQvcgPOmyoLD992KUl+ruP23tuySeesT9308YdUCnFAtC5HoqD4fJ3Zn0wuGWICoxQAp6sMYouWS77CRLLSNuwO25ZJDpnJ2PWOsKrR6UXpAD1G+HENIeow/c2DL+vWruZeSaS5m45bt/01yiTsB98OiiOCsuyGW00OLD41CN3EHAFkhxXiY5mOtru/rXo//IyzC/k3bHbjvgbGSoge3Dl2NI4RRKp/8eB/VL0Zmt6fyspoo5Q5KuNQSJia3o+F1JR+k4CUKfrxVux5gq4LWMrpZxGM0PWCZ5bjoxz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580e52ae-cc9d-434e-7cf2-08de3b9fa3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 06:03:17.0087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHbhGiZgTn8/rqD09ioB/VItUUap5+Wxz86yJoPucChZ/VEW9Sg0IbxJC2HAJjI9+S7s3B8Dw13Ws8UnZGBsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6374

T24gU2F0IERlYyAxMywgMjAyNSBhdCAyOjAzIFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBNb3ZlIHpvbmVkIHN0YXRpc3RpY3MgdG8gL3Byb2MvPHBpZD4vbW91bnRzdGF0cyBq
dXN0IGxpa2UgaXQgaXMgZm9yIFhGUywNCj4gYmVjYXVzZSBzeXNmcyBpcyBsaW1pdGVkIHRvIGEg
c2luZ2xlIHBhZ2UsIHdoaWNoIGNhdXNlcyB0aGUgb3V0cHV0IHRvIGJlDQo+IHRydW5jYXRlZC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hp
cm5Ad2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IE5hb2hpcm8gQW90YSA8
bmFvaGlyby5hb3RhQHdkYy5jb20+

