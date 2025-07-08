Return-Path: <linux-btrfs+bounces-15307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB180AFC1DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 07:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F39E16F5A4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 05:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E90E1EF39F;
	Tue,  8 Jul 2025 05:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RUqGCcU8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QCPWBmuq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7C5383
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951086; cv=fail; b=CY7JxivDrf/LbXty+F5r1qj/93gQP2ieTzg8IqpvioA3Iq67LlRUfCdzryq4CQnntSLzannV257ZCaVbfL4caNZ6cVpdolWms1hGVZ0yktfHNRabXl97Y/+ISnltVJrV/ucBX2+k36l/J0S6nvrn6RXdtrByWCKjFfAryBACHIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951086; c=relaxed/simple;
	bh=KNJWUTROx2leGjVx0q9m6fBonuiPvqrOuNg/rCgzLg0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=imZt3hIFsFGbNLMZP19+J+v3XLFfxKkFjbXPIflMAU3hNY3DbAhqBZTW4/A07hv1oN3p+cj1RNQiKqeUHwDnqE7khIyYkjBJkV+ssm/1JVU2BarqB7VDIq8y2wl5nJDaVnCwP0KPREnZ2mhPAPzFJ3/GcV3q4v9yFx2YFd2PBJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RUqGCcU8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QCPWBmuq; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751951084; x=1783487084;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KNJWUTROx2leGjVx0q9m6fBonuiPvqrOuNg/rCgzLg0=;
  b=RUqGCcU8BP87BpgrCeAYM3A5hoMp2kREZQ50TTZ3RZcaikSKNpC+9jN8
   j0jh8SL7BGckXwGeTNOchgOZqRJTG+SNk3VBaVOJNuf5NAQNZA2EAYmBE
   FC64f/5ueo8IVAU3/+CyZnXq5jbsaVyvV9yuSspudSgq0hCoVKE5jyksh
   AUQq9YGtE6dq4fWM/FjuBw7iCQ2T6DutP6vfqeOGvocbzvN5DQR1K7aXE
   TtLB9VgEU29A3O7RT5R7Zfw2RF1nAjoBok2PO5mESSUgTReSW6zyhy4m9
   wsWwZFrIrl4t1Kkh6O5FaU0JS4IE+afpZ+iIDLtWJ4OEiFSiNcolh+oQk
   A==;
X-CSE-ConnectionGUID: +937InwESi2q6FTPy5IjsA==
X-CSE-MsgGUID: EE1wqDKnR+ultT5NSkSMOQ==
X-IronPort-AV: E=Sophos;i="6.16,296,1744041600"; 
   d="scan'208";a="90886947"
Received: from mail-northcentralusazon11013034.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.34])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2025 13:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMdjLbb/f9uLXFClDIracEQ9l6kFVvBSZtKtwh4zckqU9lLQIJOy9Do8RqrHOqEuThwt9YGH7aOWrnNr4MJ/hK8lKaq1cM17bc16R8E6xWqxAyB+6pqVdtq5AOiayKBMJHMXFsnJSvvfT8GlD3EnFTgn99yMeOYCFTJ6lUFWUJLg7Bf9z0xB/ht14GL50EJpmfWYmqRPJ55fwn2hvvAkTm1u+ohvyuneLTQHaqYKOGYHrJHfiILHGqVTTtnVmpfF28jtCJ2Sefs5GH0vcbI0D62/gXlBVRMNp0i6iizGcemBTUxJtfiyBVHzNJVILEPzWmW9W3FaBT9QqM6uOvZr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNJWUTROx2leGjVx0q9m6fBonuiPvqrOuNg/rCgzLg0=;
 b=gyAnLSxg1wwWobYKhqsEUhRwSGulI3m2St8DBVQI31iTGtN5lSggd+XzSbTRQ0Ta1DcKUHq51Vj4DYKxWxAl7KLBkVlda6YiiGkdV9t+6Cga+gAXRHQLbKFrQ3QSW/K6Hl0hOygG1m3TNh6yEm7x7VqU1Uj631O+tgKVti842hPs992Fmmf4AFeDKcjpp/Vdo1EGNuvGSYKEG/VcnYpS8Ha1gS52n+Qw0M4fI1t21ctjIU9Rzo9mCBeCQadao3ZAWA9qkinxhdBTQuYmO0Fb80E/eBn76F0VxWKtalx7q6Duqh9WFatkAhfxfZwDT/bYaxf2ft7xChwrZxo+2FOhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNJWUTROx2leGjVx0q9m6fBonuiPvqrOuNg/rCgzLg0=;
 b=QCPWBmuqcIIj1Irebo3dIvhWu4Yajr6Zyy/Mr7yjVpfy52QRHyJ6ufMrkSU/Smm5TvYtQF71if3IM+4j2VAh5J+/Ep5O1dgSp+9qE4B7ddUi3ewgBadEPh+2cWCKftKgWeRmWys8uzJYpoBdk41onVhHk4/KTq9EGLDPugvWTQo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA3PR04MB9002.namprd04.prod.outlook.com (2603:10b6:806:39c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 05:04:35 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 05:04:35 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: zoned: fix write time activation failure for
 metadata block group
Thread-Topic: [PATCH 2/3] btrfs: zoned: fix write time activation failure for
 metadata block group
Thread-Index: AQHb7ukbfKtwDJ9heUebAnx7UXwA6bQmAgMAgAGqiwA=
Date: Tue, 8 Jul 2025 05:04:35 +0000
Message-ID: <DB6EQDA4RP4A.2KNYOLWFW6HYR@wdc.com>
References: <cover.1751611657.git.naohiro.aota@wdc.com>
 <bb200206ae65453c68c2f3e316378838797e2502.1751611657.git.naohiro.aota@wdc.com>
 <980ce4d7-fa7e-4320-8816-ab22d8021415@kernel.org>
In-Reply-To: <980ce4d7-fa7e-4320-8816-ab22d8021415@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA3PR04MB9002:EE_
x-ms-office365-filtering-correlation-id: 9c272987-c9d1-49d7-372d-08ddbddceefd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFJlWnd1eUY2SkFmVzUwSHhyREJGbG1RNFBRK2orUDQ0MXJXUHVuOWVoUUpn?=
 =?utf-8?B?T2dvTS9FZFZqekZTWS8xRDdQanpRUUF0NHZncWlBaGZDL0JIbWFqa3RjQVdL?=
 =?utf-8?B?VW9kRzdSdDJRUUZTblFWbGE5M3ZFbE1SVGNXcXhNN2NkUGZwV24rcys4OWJU?=
 =?utf-8?B?aHVhZkNMdW1OcDI5VXpheVFFMVlibXRtajJOQ3Rwd0RjTFoxc1hpNHo0Wjlj?=
 =?utf-8?B?ZS9YMC81QXg1Q3VzcUwxZGJSeldnbzNybGl0eVNscXlTNkxOMGlUNHNCZ1ov?=
 =?utf-8?B?bHVjM0FLQTRTeTl2RnVWTnNEU2tTaW1rUitKRXVqL2NvZm5hNXBJQkVNL29h?=
 =?utf-8?B?VEpxcTdlZWJuV2lLZUhianoyL3JlWUhOb29XVkVNajJ1S3VqMjVMRGVPeUxw?=
 =?utf-8?B?Uzk3aE4wUlBWaEMxa3dsVGdvSDRSZGFSaGVwQlIvZ0ZFMU95Lzl4VTVpM1Fw?=
 =?utf-8?B?dDNXMEVrdjdjM2xhNWI3Ymx5cHNOWkZ5RDljZnM4THR4WUhHTytzVnN0T0gv?=
 =?utf-8?B?MGo1M2tUeFhBNmJadEFSQ2MvT2VPVkpzVlNNbU81bFZEYzhxSEMzVHhMMEtU?=
 =?utf-8?B?aXZqR0dmQW5obWZ5bzFJWTRCcGlIZ0hraWpEbWxRRGJjWEFsS2RxRnc2NUdW?=
 =?utf-8?B?RGNlWE51Z091MVRhelFpd3pFb3NoQ043S3U3eG84aW16dDNQYTZXM01PV1Bu?=
 =?utf-8?B?dytSZmtFKzNwc0dIb1ZzWlczM0lYa3hVZjc5NnRyeUxPcy9ReTlEN3BWVTZL?=
 =?utf-8?B?OUVsSllCdndRUzUvakRLM1N3QmpDOUw2MTBMdXRyeHRaR2pwODZRb1A4N1ox?=
 =?utf-8?B?K1JOc3ZWaXU3K2hjOHZpYUFBb3ltdkk3TTNwNFdtNW14UHM5SnJLOEFHSEJE?=
 =?utf-8?B?eFBudTY3QUpVaHdJb1poRW1KRE1FNzJYbUgzajVKYjlrODJxTVNpL0Rxemt1?=
 =?utf-8?B?SVBzZ0VMTzdkTGxJVWgzMkVhdEtXQXBXcmtyZHRaRXVSdXlLSHhrL1FNNE5S?=
 =?utf-8?B?dCtxSEgrbTRpZW9UU3NvekxuUHh6dk1FTmx4SFk4M1pzMGZIeUsxcHZOUTRj?=
 =?utf-8?B?VkxDOUlTbUxBazFKbms5SGh6RmtkTEs3RDVBeGxtMzJnMWFNekF2TUhFNHh1?=
 =?utf-8?B?TER6ejRzSnVJcDhYTURzZFhveXljRVNXWGxXNG1HaENOWjd3c0k2cm5WUXVt?=
 =?utf-8?B?OGx3amhWMjlrOVZOMlRCWi9UTmhnZW5zWXUxekhnRGFDcnR2ZGFNaGRoZ1Jz?=
 =?utf-8?B?Mk5rQk1tSlBiRGFXM2ZOY21GWVM3b0JaTHBLS2NHZmlLQnc0cG9hQjRkSGNY?=
 =?utf-8?B?Rlh6RnJFQ2lLd3BUQzBETk1rcjZqd0NZT09XeWYxaWVwanU2SmxsdlFtUU5W?=
 =?utf-8?B?Q3RiWjZ3ZXc2cE96bTR6QmJzb1kvdm9EK013K2NsUnNtSW9zVHZYclhPcmto?=
 =?utf-8?B?d0NTaU9DVzVLeHNRd2Z1ejRpaHdOWFJsUStiNXA4L2dObVAwVWw1dXd2c1p3?=
 =?utf-8?B?KzZHYVorb1FlWjAzN3dUcWlnanBpVHZDUlB4Tm9aWHozOS9zSUk3MlNzTHJY?=
 =?utf-8?B?R2IwRWlmZ2E5QTZaZnZ2TGhUUUVPQkZiUUx1cy9hWk5KeEFnaHpUZVYzMmpN?=
 =?utf-8?B?aUVsMmVrdXRlbUluQnE3cFQ4K2Z0QkVpOXFBcWIyVkJUREUvcDlodHU0a0h2?=
 =?utf-8?B?Q3pqQ2dRdlZYVEh3K040Ny8wS2FDaW1rVkRkTFMvUi9nR2JQYzI2U2VnbTBz?=
 =?utf-8?B?elYxbnZGdG9qejZFYjJkelA3MjdSL3gxaHRETGpWcEg4aWI0SnIxVTAvalBh?=
 =?utf-8?B?NnRuRFBDYTMzcWpYV0dMT3hZNG5BMGtyUktYWVM0dFNPMUk5K1JXWG1XMmJm?=
 =?utf-8?B?K2ltUkFnSEJZdk5Wa2M4cEVCeGlqRW5ZNllCVFlxUDNDRVF1YkhCbFJNZlhW?=
 =?utf-8?B?aW1aRldZQldZNy85c3F2OFFKbHNrR2Qvc29wRlpaa2tzckNubUhRNk1jU0ho?=
 =?utf-8?B?aXJ0YW9Ja2tBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVdNRHN5R1ZSY0lnS1dWb0xPQS9JcCtXQllGaytRaFIwQ3d6VmhkS0o0NWNT?=
 =?utf-8?B?Y0x6dFNkblRtTTRzdGlZYmRJa0poanB1aFJMS1Ztb0FCMkRab3YzdnZ3SXkx?=
 =?utf-8?B?RGdTbHErakJ2YWcrMkl4NTdQY3JOZHh5andDK2N0bjRpWXFveVFTOUdJdHNy?=
 =?utf-8?B?TGZCck1GMHJGR3FYa2hJRUZBbXMxRjBpQ2ZkbWd5RDhFN1pXc0pONzR6YXVN?=
 =?utf-8?B?SjE3SEFOTGY1N2VuM3M4RkRZUXBLZlJ4eVRyaVV4cHZjbkN0VXJ1ZmdWelRS?=
 =?utf-8?B?TTJaR3Q1OHhSRTZhSmJCTUdUL2tEcmFoMnQ4ZGN6ckxUZFZacVFuWEZ3S2NH?=
 =?utf-8?B?c1dOMlk2V0wzNm43SDZjQkc0cHJoZGowZ2syV2t0blM2dVB3bjFkQlJxeDlE?=
 =?utf-8?B?dGxhNkJ5d001NVlLN3JPUmRBUnBtTlduWnlwV2JMWnF1VkFOMUxjaWNZdkRU?=
 =?utf-8?B?L0M3dmZIaWcvUHdQaUlaSm41S2FtQnlNcTBtQWJ2TWxLejVZd3JVVlJ6MERK?=
 =?utf-8?B?V1ZjUWpTYUtERit1UWJRdGNuWHcrMDVsdERjTnlFS3NBM0tMUTRZUzUxMTIr?=
 =?utf-8?B?Y2ZMa29wUjcrWGg1RGVVdWtWdll6K016NHBTYnJQOXk4OFd6SlAxOU1ka213?=
 =?utf-8?B?NS9uM3RPOEpoMUFjNHhhQUk1Rmo1YnduNy9kRFMyR3Zab1lXa1VZd0J2d2tR?=
 =?utf-8?B?QVhDU0twNHBZclF4aGJGd3M3YnRrczdJdCtHcHBUZFdsa2tTRHkxckVGUEJ4?=
 =?utf-8?B?cTJua054bmg0ci9OS2Q3SzlWS3hrRTVGTTJKajBDZFZEeFk0NnhGb09OWDBo?=
 =?utf-8?B?WmxKeWt3aUdwdVF3WjJ6VTZqUU9lNklwS3NmQnlFWWNWWmNwRldQS2hrT05o?=
 =?utf-8?B?QXhMVkdIQ09LUFJ5V0FIUU5oK2grRnZZblZIYmxEZEhsSkxVQUQrbXRUMGhz?=
 =?utf-8?B?MjRrOEVHUlU2ZUpLcHRkdGlJNWhhckdNOHZETjNKVmE0ZUlZNlAvWU84aXNi?=
 =?utf-8?B?SFVyVTZUTkVwelR5TVFJUmIwOGZmSDQzLzNzMUhGamZYSFovL0ZUQkp5R1V6?=
 =?utf-8?B?Y0ZzY3FsMGFma1FBcGpGUDNydXFVM3NITTZ5S1BjdTNTa0FUMVFSVnhBZmZ1?=
 =?utf-8?B?WXZ0NFZjZWFYZ2JDMGlyRkpVY0NlWVBXUGxQN2Rmei9teFJFemZHT3dJMnhN?=
 =?utf-8?B?SGY4akxQREpYdk9hSDJwWklxNWoxL28vODduL2JocVlpWWZVMWc1RENSRE5r?=
 =?utf-8?B?eTkvckkrYm83a1hBOSsxYkdDenFrWStxekhmd3ZLTHNmT0VsY0JUNGhkT29m?=
 =?utf-8?B?LzVaVVBKc2FDVE5vcUhUWlNFbHFaRy9oTEMxczJoNkhYSndselpxZmpWWkVE?=
 =?utf-8?B?YTBVZUcya1Z6cG5Eb0IrYldhSllySWZmaFlWVkFjV2Y3eHdXQjBuZjJXZUtV?=
 =?utf-8?B?aTdIdEplbmdvZ2IxWDFTSEY3d0ljVnlMYXdtcDJmdkdlRERja2tmUFRFK0Vp?=
 =?utf-8?B?SmRzKzhjNkRXOWxNVWU4bVhUWUlhUyt4cFF6Sk4yaGZHN0JzOVBBcnpjWE5h?=
 =?utf-8?B?WW5taEFkODZvK21weDVRRFhMU05QV0VDOFpmZ082cWVRdmlJekdoYjFtTHlp?=
 =?utf-8?B?S3JZTUYrNzA3VHY1c3UxdWpGNkxaSjBxVUplb1Y0OUhuck95L0FMWTdNR2VK?=
 =?utf-8?B?VW1jVldzNGxuM2kvVDVUeEFXeHNMTm9lWmtoSitjTlBHVHhMT1Vrei9SZHor?=
 =?utf-8?B?b2s4U0FQNHdHYnhVRjBxQ1VWNmJOUnJIYnhEbEhOQVZsdnUzK2YxbDk5WW9r?=
 =?utf-8?B?c3k4c01yWUl2NGdleW5vMzZ1S2gyUndHMW1zcnNaUFdEOStXQUg2S09HNFNC?=
 =?utf-8?B?OTRjK2NVcDhValBncTh1SjNQNmRUY2tvRitUZGI0WktaaEFPWTBiL0pmNlhL?=
 =?utf-8?B?QmticXJwK2tDQ1hGaUpVV0xmdE1zd09FeWRHcCtQcWRxQWJMWTFpU2RYM0M0?=
 =?utf-8?B?YlN0NCtPWVZVL1lXOFpiMUJrQmVhcy9PZ3lQN24rMDFydGtQUDJPMzFvbkM4?=
 =?utf-8?B?UnNKZit1dnRjL3lqZzREWmVJcWdIS01sMUFFdnBsdmxua3FTNlhmRE50LzVN?=
 =?utf-8?B?U1lRdGV3cXkyc3NxNi9zRXdQb0ZsU1EyMkZWUGpDQTFmY09OZk1hZHdmREIw?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82C4917AD596FD49AE3BCB052E2F9D0C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uJ60GeM2wbM9gCL3N6vD7Oh9fpdotUX/umBXfMJBsjqOCArGjhBy8eObH1vcT2M2L7OAPwDCS/DufNuf2kHca1l1R+eWA2ip5rTTgu8HxFbzxAxLS42hxB9g3YAefE1JRvokmhGk7dkncG3OZgOjTfJgo2Ix/hBbDiFpfdwqsmwM3ZAbKaZT2F21zhZSAToaU/sVuYCUonJJbOfd6u6xFmHXZ2vvarw6taIzJv0i+VtLia+ktIaO4SlVU+7xYlq5CAHgvNtQgBZ832T+u1uxYzAC4wfLAY45nILPnk5yGg8o9uTl/w06Drvw3p2pUk5eynWDQW05xjuxUmVfTa7qFHw5XBhKotrFUG13e6T9VZmtGi3OXhDr2tnh7Kb/VctWpIgGL2CYtLWeEgFAa5rARVEh6uCnBcUeRAgt4jlXu9Wb48VHBUTFnig/m8Sp8d+QKNIbb9pEWsI+fD3erfANFbaGbPYs04fSCM9/J2/FIknOVc7t83iB23/ElgvikJtQd5LH5w1nfRd6EOmFtDTy0bptlOkoyuEp54eMaGFVT5rr3z+lq/gKUxAQn7DNLBl4IWg8F4H7xSWm1M3k+9XYiIsMT1kB8v5oLMkDAwHkcZsbhnX5TqRKZgMNyMl4XTSF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c272987-c9d1-49d7-372d-08ddbddceefd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 05:04:35.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7u/5lWZSeikpM/JSdw33AqvmnYRpXmXHQEbTiNR+vyYN+BWmunuWgDAXfXaFtSdANFHii1BcgXHaY3kdjfDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB9002

T24gTW9uIEp1bCA3LCAyMDI1IGF0IDEyOjMzIFBNIEpTVCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6
DQo+IE9uIDcvNy8yNSAxMTo0NCBBTSwgTmFvaGlybyBBb3RhIHdyb3RlOg0KPj4gU2luY2UgY29t
bWl0IDEzYmI0ODNkMzJhYiAoImJ0cmZzOiB6b25lZDogYWN0aXZhdGUgbWV0YWRhdGEgYmxvY2sg
Z3JvdXAgb24NCj4+IHdyaXRlIHRpbWUiKSwgd2UgYWN0aXZhdGUgYSBtZXRhZGF0YSBibG9jayBn
cm91cCBvbiB0aGUgd3JpdGUgdGltZS4gSWYgdGhlDQo+DQo+IG9uIHRoZSB3cml0ZSB0aW1lIC0+
IGF0IHdyaXRlIHRpbWUNCj4NCj4+IHpvbmUgY2FwYWNpdHkgaXMgc21hbGwgZW5vdWdoLCB3ZSBj
YW4gYWxsb2NhdGUgdGhlIGVudGlyZSByZWdpb24gYmVmb3JlIHRoZQ0KPj4gZmlyc3Qgd3JpdGUu
IFRoZW4sIHdlIGhpdCB0aGUgYnRyZnNfem9uZWRfYmdfaXNfZnVsbCgpIGluDQo+PiBidHJmc196
b25lX2FjdGl2YXRlKCkgYW5kIHRoZSBhY3RpdmF0aW9uIGZhaWxzLg0KPj4gDQo+PiBGb3IgYSBk
YXRhIGJsb2NrIGdyb3VwLCB3ZSBhbHJlYWR5IGNoZWNrIHRoZSBmdWxsbmVzcyBjb25kaXRpb24g
aW4gdGhlDQo+PiBjYWxsZXIgc2lkZS4gQW5kLCB0aGUgZnVsbG5lc3MgY2hlY2sgaXMgbm90IG5l
Y2Vzc2FyeSBmb3IgbWV0YWRhdGEncw0KPj4gd3JpdGUtdGltZSBhY3RpdmF0aW9uLiBSZXBsYWNl
IGl0IHdpdGggYSBwcm9wZXIgV0FSTi4NCj4NCj4gSSBhbSB2ZXJ5IGNvbmZ1c2VkIGJ5IHRoaXMg
ZXhwbGFuYXRpb24uIElmIHRoZSBCRyBpcyBmdWxseSBhbGxvY2F0ZWQgYmVmb3JlIHdlDQo+IGlz
c3VlIHRoZSBmaXJzdCB3cml0ZSwgd2Ugc3RpbGwgbmVlZCB0byBhY3RpdmF0ZSB0aGF0IEJHLCBu
byA/IFNvIHdoeSB0aGUNCj4gV0FSTigpID8gVGhhdCBzZWVtcyB3cm9uZyB0byBtZS4gQnV0IEkg
bWF5IG5vdCBiZSB1bmRlcnN0YW5kaW5nIHlvdXINCj4gZXhwbGFuYXRpb24sIHdoaWNoIG1lYW5z
IHlvdSBuZWVkIHRvIGNsYXJpZnkgaXQgOikNCg0KV2UgYWN0aXZhdGUgYSBkYXRhIGJsb2NrIGdy
b3VwIGJlZm9yZSB0aGUgYWxsb2NhdGlvbiB0byBzaW1wbGlmeSB0aGUNCndyaXRlIHN0YWdlLiBT
bywgYWN0aXZhdGluZyBhIGZ1bGwgYmxvY2sgZ3JvdXAgc2hvdWxkIGFyaXNlIFdBUk4uDQoNCk9U
T0gsIG1ldGFkYXRhIGJsb2NrIGdyb3VwIGlzIGFjdGl2YXRlZCBvbiB0aGUgd3JpdGUgc3RhZ2Uu
IFNvLCBpdCBpcyBPSw0KdG8gaGF2ZSBhIGZ1bGwgYmxvY2sgZ3JvdXAgdG8gYmUgYWN0aXZhdGVk
LiBJbnN0ZWFkLCBpdCBpcyBXQVJOIHdoZW4gd2UNCnRyeSB0byBhY3RpdmF0ZSBhIHBhcnRpYWxs
eSB3cml0dGVuIChtZXRhX3dyaXRlX3BvaW50ZXIgIT0gYmctPnN0YXJ0KQ0KYmxvY2sgZ3JvdXAu
DQoNCj4NCj4+IA0KPj4gRml4ZXM6IDEzYmI0ODNkMzJhYiAoImJ0cmZzOiB6b25lZDogYWN0aXZh
dGUgbWV0YWRhdGEgYmxvY2sgZ3JvdXAgb24gd3JpdGUgdGltZSIpDQo+PiBDQzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZyAjIDYuNisNCj4+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFv
aGlyby5hb3RhQHdkYy5jb20+DQo+PiAtLS0NCj4+ICBmcy9idHJmcy96b25lZC5jIHwgMTEgKysr
KysrKy0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvem9uZWQuYyBiL2ZzL2J0cmZzL3pv
bmVkLmMNCj4+IGluZGV4IDZmYjRkOTU0MTJkNi4uOWMzNTRlODRhYjA3IDEwMDY0NA0KPj4gLS0t
IGEvZnMvYnRyZnMvem9uZWQuYw0KPj4gKysrIGIvZnMvYnRyZnMvem9uZWQuYw0KPj4gQEAgLTIx
NjksMTAgKzIxNjksMTMgQEAgYm9vbCBidHJmc196b25lX2FjdGl2YXRlKHN0cnVjdCBidHJmc19i
bG9ja19ncm91cCAqYmxvY2tfZ3JvdXApDQo+PiAgCQlnb3RvIG91dF91bmxvY2s7DQo+PiAgCX0N
Cj4+ICANCj4+IC0JLyogTm8gc3BhY2UgbGVmdCAqLw0KPj4gLQlpZiAoYnRyZnNfem9uZWRfYmdf
aXNfZnVsbChibG9ja19ncm91cCkpIHsNCj4+IC0JCXJldCA9IGZhbHNlOw0KPj4gLQkJZ290byBv
dXRfdW5sb2NrOw0KPj4gKwlpZiAoYmxvY2tfZ3JvdXAtPmZsYWdzICYgQlRSRlNfQkxPQ0tfR1JP
VVBfREFUQSkgew0KPj4gKwkJaWYgKFdBUk5fT05fT05DRShidHJmc196b25lZF9iZ19pc19mdWxs
KGJsb2NrX2dyb3VwKSkpIHsNCj4+ICsJCQlyZXQgPSBmYWxzZTsNCj4+ICsJCQlnb3RvIG91dF91
bmxvY2s7DQo+PiArCQl9DQo+PiArCX0gZWxzZSB7DQo+PiArCQlXQVJOX09OX09OQ0UoYmxvY2tf
Z3JvdXAtPm1ldGFfd3JpdGVfcG9pbnRlciAhPSBibG9ja19ncm91cC0+c3RhcnQpOw0KPj4gIAl9
DQo+PiAgDQo+PiAgCWZvciAoaSA9IDA7IGkgPCBtYXAtPm51bV9zdHJpcGVzOyBpKyspIHsNCg==

