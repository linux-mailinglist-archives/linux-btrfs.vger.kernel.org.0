Return-Path: <linux-btrfs+bounces-20912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMRQBJkYcmksawAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20912-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 13:31:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA0966A88
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 13:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FF434CBE40
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336D33F8A1;
	Thu, 22 Jan 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J9rjr0wM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xCkFTKrf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A6337BA0
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081705; cv=fail; b=PQOg9cTfsX9tcskbwYPLl89ezeUpP1fu3glB1+bV7SR9rc/Tv2tJun6gWXWc775WQioeZnikha5GE4nnI3GSTe7bVEAdFn6lH8uU4tnmRSZfDe2L9pVPNzalBBlrdtjMdQgM8DgQgWtAZCod4VRkf2110ozKO5UalVKdJ2u/MqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081705; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BFeILiH3x8ajir6Hnf7U19MVD58PRk3FSmJYklFaUIA7vZ542NoOJb1XYD3t9QppniCcETUAMDbJyGrrcP3IFabQvtrU7YtN/sOhUAReCy/Zwlhyrfs96xdGuO9/WZq8jAaF/7Hwzig5x594nwlY5Mb1OiDggNamofscCYGtoLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J9rjr0wM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xCkFTKrf; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769081703; x=1800617703;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=J9rjr0wMYETexdaXdJI0aeTQen8Hz+bScmOH69thZNNsQLz8tFprFXrx
   YmrYYli9MSMhr9foZT2vnwcfXED3+7Amqrl+KSNVPkb2eINgabJic7hKE
   KXCikf4oXBitjq+RKT0len4FnwXLtagtzzeKRfHu2rsscAhEXkFYYx7lD
   PjAEEZ5+M6eTYg7/rCL8MqvtDnDgIJ+Is0rrnjAxnSjMIYcNAx2WSfzy3
   jPswmtPFW4VusgpBs2rwSrRNbaCJX9f3Z7TtAp+sai8EsWRRZLS4cZ14C
   Un5SXeLZ8B26OyVoa8NoT/gqLnPUFZJId7Ae2t3tSKGKOEutpcN+zmQxY
   w==;
X-CSE-ConnectionGUID: ET2ePQuARZaEuAGEafuu/A==
X-CSE-MsgGUID: axg2pAlaRuqtzqThZ1bZHg==
X-IronPort-AV: E=Sophos;i="6.21,246,1763395200"; 
   d="scan'208";a="139272277"
Received: from mail-centralusazon11011033.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2026 19:35:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydaIU63qmEjhCrtCZVYA03g90BocGLgf9jIDA7CiFyrrBPSv04EuStDk1fvPs2omt5GWuevPVqsEJSPYmjKGFxhN9lzoeZzi8TA+ufS3aSGMBqjL6Yoz68DRhJcYlX2RaK+V0qKwolHLPO2naVdOquyRqGkecpC2WQlEIE48rSWNMD6XgIkgjC18RBxCBWJuOG5LBotYrAa/GtV/XC4nNXq/cW1Fh519qg3XoNFkdY2XjS8SwG7ks67SIu9ZoOVQ6xCPV0yFLCIeh+ZN3Fz2kBoOwo9ezH3TSM57YgXPEtGhWFvRtmklcOW0pIaoRllV12Gqqa5cEbzJ1FelyIOs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=BiQKoSByk/lT5yHBvcJaij8QEjlBGqpzHQZKrtSOoJGsUhM+2aXd1BSrJCUHLhEmGAH0n0gZKUEfRwNz2xmZRv0GqF16VM3tIIj7WxbFUJKCUHPTqnN5giXIwuWTddKHuRZw5S0PkSS6QJ+7f5DeWpv/6v8U3ftH2Bke+hIXtrcK1CpdBpzKX9fVuekO1BR4R1cEPKaL7Gs17Tr80rWekAFSiPl1Zr1fTNU31z37AOSw4Y5t6I2Mx3cxWashRIcdiejT0dvfMEMahwUq2RsF6mBgULF1WC4B4JtQ+4vZ0HYCvYLIholPfoJgrjmjixtg620gQib6HHrJ4ur7wXCyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=xCkFTKrff44tIkm6ps6TvCdrZdEUxNmejl9M9Hk4MHr5/GRDAefMZQyp0H3S+IcndEgdQaBsHv2b2J6do6i+8P5HKtmbdpjinQeZ7qz48kh2OwWcauBfVCjBSPOjmNj9UXCc+rjeyciJ8QV2aRpQr5AyAWljkMZBFAB4LZcJd5E=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA2PR04MB7547.namprd04.prod.outlook.com (2603:10b6:806:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Thu, 22 Jan
 2026 11:35:00 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Thu, 22 Jan 2026
 11:34:59 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: unfold transaction aborts in
 btrfs_finish_one_ordered()
Thread-Topic: [PATCH] btrfs: unfold transaction aborts in
 btrfs_finish_one_ordered()
Thread-Index: AQHciwf8FW869c4luUC5SSnAbFR4+7VeEDeA
Date: Thu, 22 Jan 2026 11:34:59 +0000
Message-ID: <692e14a7-0fec-4598-ab58-ea25f7df2baa@wdc.com>
References:
 <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
In-Reply-To:
 <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA2PR04MB7547:EE_
x-ms-office365-filtering-correlation-id: 6f9609c6-ec1d-4dcf-ea15-08de59aa46b6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWlmdTdOcVVXZ2lqbUwrTDBrbUxHTmZsejJxbVg3VzhXTEk2cHNSTy9QWlhm?=
 =?utf-8?B?dVI1bjNGVG9jR2NZcmczQnQyUUJETis4eW84ZGJLSUdTeFNILytzRHJwNExW?=
 =?utf-8?B?TkRoREt0VWE0U1MrS3pZQ1ErZTR6M0FpQ0dOc0FySjgzWVZaNEwrbCtYUGxI?=
 =?utf-8?B?WkpSSkVmM09aRmVZNU84dU9zOUd4dExFbnFaY0dKeDNac3p5bEdUbzdwdVd5?=
 =?utf-8?B?Tm92eEhGaUV2eE9SQXZGRWphWU1zZUZtZ3dWdUNoSVdmK0MwaDlIV3VYc0pE?=
 =?utf-8?B?NVZsK2RkMTR6VXlXUGZnMUtjZ1plemVGRFNCYlI0bDJwUldUeXp0WmFzYmZJ?=
 =?utf-8?B?VEhQZTNzWXgxTTNZTnN1RWFFd0ljSDZPWVBQUG0xTURFNmJlT0RTdGNHQ01K?=
 =?utf-8?B?UThBNndxL3cxOW93Ymp1UG5yQXAxcDYrNitjRkZWUE1peElWMUZXUnFkT2RX?=
 =?utf-8?B?QmdMMUhOcHVyc3VIMEV1bGl2TlBZZzUvVVlGUHY3bHhMMVhuc1BpNTY4WjZw?=
 =?utf-8?B?Y0w4QjgveWtTZVYxckVFTG1Nbnk0K0NvcmpUMnFVK3pCRHEwS2g3bmR5Z2kz?=
 =?utf-8?B?TkhGaWd1ZVBJMHFmTFF4eEV1QXF2TkVaNFhxZm1xVXJ0c0Y4cmVSN25NRWY3?=
 =?utf-8?B?UmNsTW1MSmFVRUZKYnhkdDF4T0lNOUlwTEhwcC96ZlhqM2p6ZS9senNoRVdv?=
 =?utf-8?B?Rk5ZdldFUzZXNmxZWnA2Z0doaXFWWWt1SHliMjJMVHN2RHg2QytqM1cySFFj?=
 =?utf-8?B?QmIwcG5XZjh4V0lxYlJ4YUQ0MThKb29zWG5WVk43eXdHUFVFS0xrZk5GRis1?=
 =?utf-8?B?dVVRZ2g2RURIUmxSUTlQU1VFYTlXNlF6aHMwRmxmeVhPKytCWldaQUZjRC9x?=
 =?utf-8?B?NDh1cXRSTUoweExLYTRucFluMERaZVRuSlp4TnJNMEZrbitZaHd1TlRiWnRE?=
 =?utf-8?B?Y3VGMDFjcFhTTFRIUThLNFU1ZzJlSUpoOVY4Y3JDSSs4Y0ZwSXRuY09LbnRr?=
 =?utf-8?B?L3YyVnpOWlRac0tOVlM5YnpJdHZEWUxhZXZvTHRTeTBUNUZWVUxiVmhzM0dL?=
 =?utf-8?B?UUFZdElQVjlHTGpBVVhmSEVQNGpsMkpoa1FSVmFqNUZ6TGpjejhQb3BrMDVy?=
 =?utf-8?B?ZEZZZUFsbS8wTkhSWHZIdUU2MFJKL2NOaXFpR2RsZUlJTi9vR201RUZraFQ5?=
 =?utf-8?B?TWxyd0s0TVovc1FhR2R3U1NxSUdjUXVVVk54QjNjWDlCMmhJRGN5dkJhNHBy?=
 =?utf-8?B?VmU1eUdmNmxPN2ZyR1FvUy9KbCtTTStkaCt5bEdjdjZyV3g0UDFCWFNhbzBp?=
 =?utf-8?B?dm5icmNyeGxxT0JSNUVsSWhDVWQ2anN2UnlOR2ViSkthZ1dBVUlQNVA5YXdS?=
 =?utf-8?B?VzFmYlpkcUNjQmtaUHRNdjhrOEJUbDc4OEtDY3l4dHJzWU5NczZISExRQ2tl?=
 =?utf-8?B?aTkxNEhKREkrRHcvR01RVzM3NHBPaVpTdFk3WjExMnJVdzRla2hDdEdqSVVr?=
 =?utf-8?B?TEtpVWFPMjVtWndmSG9XSGF6N3BVenZpZXRSclhaaUMwTWV3TlN4WUxGaFhK?=
 =?utf-8?B?OWo0SjBoN1pESC9aR1lCamluREVRUmo0anU2YnZWNzBhcnZlTkQzWWYveUx0?=
 =?utf-8?B?cEdvVHpNbjdWdXJIVFVQMVE4UGQyenlJdnRqQ0Q3RldKZFNkYUtkZlZ2anRO?=
 =?utf-8?B?NElWZUFPRGh3SlRhUnJraUNhM3htZVpTNWdmTHBRc3JVdVppL3JJSHNvT1hF?=
 =?utf-8?B?RjFKQmFqclJmcXpJRDVJQTBGZFBjMWt6My9TdkVoaisxT1dWelpXLzg2K2d4?=
 =?utf-8?B?V0NRaWxMVGV2YXp0Ulo5UnBoclJSQkF3OVorUWNiK2RTdU80c3prYWdzanJy?=
 =?utf-8?B?R2pSRTFiZDJVdUdTNnRMU0FKUjhVcFpONEg4SnpUeStPYUYyY0hXd3c5dHdL?=
 =?utf-8?B?VVFLZUVibmFab0YrTGR6NlVNeFB1K1hnNU5GRXUzWWRrOUdlUFdmRUJqbmFF?=
 =?utf-8?B?bWpSWkVlbHg1MS9QRzc5VXc5d3FWRGI3SkkyMEQ4bDJra2VraDRXdFY5Q2hI?=
 =?utf-8?B?ZDFyczlUbUdFYVBxSTloTWJSUUJUTXBNdGlmUTA4V1BDVUJSUGxmeDlDajBX?=
 =?utf-8?B?dFBYU0ZVUzhFNWk2bTE3c3FmS1oreEYyTjRiQ3RCQmZQQWFKSGhRZU1CZTZH?=
 =?utf-8?Q?dCrYhkDOySGqfSIvOpY3lvQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjBML2FtV1FOKzhNbnNwYXVmSk5PMlNHbi9XcWN2TmlRcThlVDgzZHQ5QThY?=
 =?utf-8?B?VG9XQVBOSUlSK09qc2ZXY2IvdHJkVmxkLzNCdWg3ZllISXZQM2duWGE5a0Vw?=
 =?utf-8?B?RWNNbWNNTENNbUpxZGx0S3BlTHg4clZucU9hSU9hVmUvVnB3WndmRFBhWkZX?=
 =?utf-8?B?NWJJVkhGeGlBTkRqUDJMdit0ZzQxeHBwOWxEc1RubVRyY1k5YXUrZzMrUVU5?=
 =?utf-8?B?dG9zSVhvTTVXUThTck1MQldMaXRMTjlxUXQ0dTBNUStnVXNzWmpYNGhPNlVk?=
 =?utf-8?B?eVBBM1NzU2RPOEh4RFVZdnp3dUhUUThUSUpPd09SYWZsVDBpcTk0ZllzSFdl?=
 =?utf-8?B?blhXY3dSU2FoZU9GOTRyZlNZaUcwRTZ0eTRQTHpMa21mZ2VkSGlaay9XN2R1?=
 =?utf-8?B?dEdqZVQzY2VMbWhyejlCZXRMbElYUWd6RHVSOWNLZGp2YklxQmg1S1JoNm9K?=
 =?utf-8?B?MDlXdGcrU054MVJpSlo1NEhHNkhaWVBQNUp3NUdNY1JhNGFaSVZQalhTQzNa?=
 =?utf-8?B?dGZCU0k4QnBKL1VoNGJCVGpvL0dXM1dZcWh5WTh5cFhvVXZ0NllMR1UwU3g4?=
 =?utf-8?B?MkdVMGc4Y29hU2kxYTVvUU9pWjYwRnBmMnBzYzNOTG5ORUkyQld4T3NsdUhW?=
 =?utf-8?B?bkRGeG8yN2RlZmdPeElpeUMxMmNvRERZK3BrUTJhT1laelNXekVUVHNqRlhC?=
 =?utf-8?B?enNadkNjUG0zdUFKRG4vRVBEbGE0cE5xeWhWMGhkWlpGVmx6akxIV1BhdHpI?=
 =?utf-8?B?YzIwTG5rTnM4byt5d1VBSmk4U0FUMjBaUzVYeGpLU1dTakpleEVjZGR3ZG1E?=
 =?utf-8?B?WDlIb1NTYzFkNEN3NEZVamFQZkR4TWgrQkVQZWFwVWxydE5qeXB4TUlOWUh6?=
 =?utf-8?B?ZXkyZ3BZWXVpbGxFMlc5M1h6d3lwNXdlamVxdEh0OUd6b2V2aEQyVUR0SCsz?=
 =?utf-8?B?TzZtR0t3SFp6azNPQW5CQkxSOThndmRCdlZGU3lJR1cwWHhTQ1pOUnNPZWU0?=
 =?utf-8?B?RFdQU0kxNkZMR1pMRU5qbEVWc3B6OU9kVVFSaW9GdDBRcmFMdEwvUHFwQno2?=
 =?utf-8?B?dlI2elpGVkJsY2NNazNVQkp5ZFBvUFovT3FWT1A2YVUrUUJnaGNod21RenJX?=
 =?utf-8?B?UktNN0ZWUkdRYzhjWGlaZERSdTB6T2V3RjRuR1pNYnNaSlpyOFJydml6ZjYw?=
 =?utf-8?B?dkhhL1FnNjJoNXpwUHZnVmZDOTBENStEblBReTJnU0tRcWFhY2IxcTkyM0dJ?=
 =?utf-8?B?QmRweDdtQ3VraTUvOVppL2oxQkxEM1lpZklQYlUxT3V4TE5XMHJrT0l2Rm1G?=
 =?utf-8?B?eVN2Tm1oWGRGc21xbGk5RTMycWZWdVRtSFlUWVBuNmxqdXE2QS90STk2by9q?=
 =?utf-8?B?RzlBYTkwWWNNQ3N4ZkZwOGFaWmwza05ZSysxTXpKVVpqc0pCS25seUVaR09t?=
 =?utf-8?B?U2xZTVk2cU1sTmtaSEJjNmRrMStQM0lEYlVkeTBsM0M4SnJxRXhieS9ic212?=
 =?utf-8?B?R3RRRzlaa25xVmVrbFc4Yk9HcW83Um0zSEl0ektOa2ZCUzNlYTNTUUxPelNo?=
 =?utf-8?B?U2JCQk1lcGF6UE9JdEVlRnExa0V4MGh3aFN2SmZQZG9BUFlScldLZCtaZytv?=
 =?utf-8?B?UitCWVhwbXF5cWUzb09seUJqaGM2dG5hVlZJR1d4Z3p3NDEyd2xwMTRxU3RV?=
 =?utf-8?B?MFpoODNUdkdCY3ExNTZSNE9QTEZwQ3BtbCtrbENxb0R0Qk9oZFRYUWphWWx6?=
 =?utf-8?B?S2QrOFF0R2p2bWQ4ZUpra0k0Z0JJazR6ZXpQSWMyT2tKOElRUTZQb3loV2hk?=
 =?utf-8?B?a3dvcUpvWUJXbWNNMjQyZWdJQWthK1ZnMXovUjQzeHRNbys3YmNCVzNpQmNG?=
 =?utf-8?B?TU11WHJUT0lueUFCMkZtVWg1ZlcyT3VQTUF4ZWdxU0dabXZ6L0pTQ0dnR3A1?=
 =?utf-8?B?VWZyakhPWFlGTDhSSkE0RDBncjNFNUVSOEdXaDRMTFBBUUpYOE5RTjFvMzdh?=
 =?utf-8?B?LzJWNVpDZkVwZEkyWlkyNHl3RUlYMUdmNU1XeGJucGFWNW1wcTRibHpQUCtU?=
 =?utf-8?B?YVRRNlBGVDFtei9Fc1lDWjR3c3ptS09CcFRQNDErTTFHa1l3KzlSY2swbEpP?=
 =?utf-8?B?UzU4YXY5WFpXYmx6Qk9xR0xXSkVvT2plY2VEcUNrY2pyYWwzWFdiL0NtbFhy?=
 =?utf-8?B?MlVRRm50S09NTzh2b05yUG5uSkZyYVdHcHBDUTRZbU5pSWZJL0RUMkEzTUJU?=
 =?utf-8?B?K1BkSWt6Z2hoUlR1TVUzWHJreG91eDllTzNWZThGaUNDTlkyaUcvQTZnL2kw?=
 =?utf-8?B?Qkc1aWU4NXI0Nm5CUkNMVEhVamVrVE5CUVhsNzhXcWE2WUs4NitJSUpUQ0JU?=
 =?utf-8?Q?t8wOlKyyNk0Ktp3QWkw0w5W3gj852sUoEhykVOKc3LVWB?=
x-ms-exchange-antispam-messagedata-1: ocvZjvA6rAF+mfKPxVyKKQKRRWQqRKrP/6E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8357E8E2777B114786ACD38F292D4D79@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YCzZyF4OumcYDQlMBLNyMJPXIwXwg3wbzizXHREx3NkwiXvND5H2S0E0cXWus2Fb4WbLuh2oWZuxliYMPMttnI/R78ZbhBaK+YDNdtCn7pBjvpARke2ZoqpK2SqTbNdtEZfXsJoqrODuLlchB9AY8MbZ/T7+LoFBYmsXgKsndd0sGFgtaHj3gMB7FvliBreBWZyfYoibKFeZGTyyy4M5fGKtdGhF/qYFzYcmWJSVZeB7941KfU0KqDRbY8T9hzD0riGBlYAj8KPt/fyN+G3ZE103QvjgOrOAH5ISNeW7n+JS00rVQLiDJCje8c/XlKYpjbfDsFHAN1tVN35C8qPcz5ADC56qN7R9K93rM9t1N7XXQOTINNy7c3d7OW+Wj7GkfeGUAHIqPIng6nuSVeLOeXVfzdmAp22bqcy6gVCsNV3K6YZiIDG57E/kR/XLFp9Pvf117Gdy/kQg/dQjXZLp5LW4ypV8xGMkYX7iRnLuIo5ylDnSe8msDu48SitP8J1mBjtTPae+WVKOnfDR0uPAJYEdBo+jg5NndVvjBWwYRHrXXdySmKa9J4O7TI8ruuHGMPVFP36pC+vt8KRjjLRexyZtBe+S+JIwJRgUkHRAF/koUJa2SXQVVRmLg7C6FFUW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9609c6-ec1d-4dcf-ea15-08de59aa46b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:34:59.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhMPm3LAWgt/eFer+PdlRqC1SWqzVmQxl/ZHmHwxtKMfUdDyb0jCiVE5DO4YolZsME2iF9jlNCRufeXfpraSufRpSMaeRy3X+zO4uzyBIok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7547
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.74 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[wdc.com : No valid SPF, DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20912-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	DKIM_MIXED(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim,wdc.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: ADA0966A88
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

