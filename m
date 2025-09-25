Return-Path: <linux-btrfs+bounces-17169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B361B9D7E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 07:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F62119C7353
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170CD2E88AE;
	Thu, 25 Sep 2025 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="geAwpK+3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p60VuB13"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68002DF13B
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779683; cv=fail; b=RrGUrDIazJ6tVeznRQTnUTU2mcrsegB6RoaNaQT/3kR4z2HNCjwdGL+MW0wbubMO4UovfKKop7sWlCn/Lz4Ovo2UlrmxAccZu4nTO4wYrEKh02WOjP8VZsKx0KHJAoTsSH52eC04PiH0QPAzF283wY9M+YJdG4Anr+CJXOwH7Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779683; c=relaxed/simple;
	bh=VeKRaZNxHxQuVglsS4a1gBG7/XZ0XeJiXfSEZ1mE570=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T/F7CJG7T05wDVfi4Wi4ld25WRKDWc4EZ/lVeGn6UBUpPpABXDK7/9gSaGtxDgTpDx99yBih+Zpi+MHlSRKkTwmJROB9QfcI83lqBt4+++NP04IbW4pvLWT13C86hdm/sDiJ4b8Rny9OPaooZGIsHqujdK5fWYRg6zF6pIYhLJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=geAwpK+3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=p60VuB13; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758779681; x=1790315681;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VeKRaZNxHxQuVglsS4a1gBG7/XZ0XeJiXfSEZ1mE570=;
  b=geAwpK+33yMzIhUz923WKcvMa2DK1nOPWwG+NPqnYD2eyxezUTf7+bMO
   /dEE7d1EZTr15kLkRUayj+e98m7fbCa6FrJdtZ4I5/itD++SQHVtCH3bn
   VPAQdlbIN/ioEPqWU+5ZQK/qqzSxuzTchia4wcb7XbrzgTN+UNjopcd9d
   ZLdhBbuRLXA2BiOkO3Jb+qQGBNFJEjKDPDUYpSrAb1IRDt0mXKRiCYN2f
   TUkEksiDyiCLbHK+rl/MDuP9pAxwLAgBZt5gskBKzyBeh0Vnl/AwzQtvN
   YyZEwsFq07V5DT0P5AMRJ73tD8QyAaMq026QgnK7EWjdgMBfDm1aArufn
   Q==;
X-CSE-ConnectionGUID: UNZn6A1/SYKlqusKU7OOTg==
X-CSE-MsgGUID: Tgfiqf2MRdazF5O1CCvBWg==
X-IronPort-AV: E=Sophos;i="6.18,291,1751212800"; 
   d="scan'208";a="130987770"
Received: from mail-westus3azon11011023.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.23])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 13:54:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaOsUVz2bxK3/tEQ5lGuZ4Yp3rX3skdZPEdGagniRgG3P8vIbtjtaicrPttjpXoVCN4og3v8L7KUNqiAx/CnJhtKnXyCDHJI27Ovccgbw9Ppv09oo+8aN//tPAhP8BYGjwHXYCg1uxAkt5V2lC2jEgAlJJ/TojHDia+ieKndO3aJuPARTruFBCWbDllP4WQ6HUsgD2et7pnmBf0Rq3+O4I6HQ3CXxXVdS2bMdI45FqIKMwkicniNaza2s4S2tcs/N997nLYqUSB0yea+N4XvULBdk/YclN7jzyhMMbtkNBiSBLoPjgO9qpes7K0qQpw9hbjZU0mU+B2pT8rgAUJrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeKRaZNxHxQuVglsS4a1gBG7/XZ0XeJiXfSEZ1mE570=;
 b=BVU7mGVnHjSuz3BJwc1uSdwEvLWCwAWeGbXJyDOu+NPEygVDFdiqqXgedjLxx/A+6L2uyMcf/dDQ/yhxx5QpU7ashHYdRDzMTRxShb2mMhZE6gLcmuHZac/PoiFYFar/PHOT3fJFnnk5RoavXVXraIRdRIlA7W5pBASwl15cVyawPilUHTSDTCyW3PEvIkE/VaxYrMOdF9bIPdZkrQ/UlzpCROLsV+/9+EHMXI+AhbvwL29dnOo7wLmnB0QSFoL3f1Uoo6+yu0o6BbRLzQ9ffEbxVxasl6V6eLpxx0IVW3zpn2lrvYhGubzjqEFlrDUy6nrR/gGfU+EftJQdi+2iBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeKRaZNxHxQuVglsS4a1gBG7/XZ0XeJiXfSEZ1mE570=;
 b=p60VuB13SQzvwmGs6h40wtOmAx7gVbtqpvoJpCZrImYQy4QB14LgIsPCf0fgAMWqoWn2VkPw8CMx7tgjgzeFTx3p2MEYT3becsuBd27b6XxejhP0yFwJUvPqh95vjl73RuGVK0OlcyiUfNlI2cAJUcO4alyrhF3IuSwyofvgowg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7754.namprd04.prod.outlook.com (2603:10b6:510:e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 05:54:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 05:54:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if
 relocation already running
Thread-Topic: [PATCH 1/2] btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if
 relocation already running
Thread-Index: AQHcLXP/QL+9YgPFWk+v7bnR1C76/rSjZtiA
Date: Thu, 25 Sep 2025 05:54:37 +0000
Message-ID: <eeed482d-6290-4877-992a-2abe1f9a0e35@wdc.com>
References: <cover.1758732655.git.fdmanana@suse.com>
 <ae43088c97c0423deee961c58e9eca4c4aff2e88.1758732655.git.fdmanana@suse.com>
In-Reply-To:
 <ae43088c97c0423deee961c58e9eca4c4aff2e88.1758732655.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7754:EE_
x-ms-office365-filtering-correlation-id: 401be180-a682-4af1-9a71-08ddfbf802e3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?bndibzhTT0JnNkNmN29mWkE3MFcza3VjRVlGa3NxVU1YNDExV01PcFVycG5G?=
 =?utf-8?B?aWJFWVJXcmM5dWhLQzVUUDlDd0RoRHNaVjl3bUE2bnhEMFpEd0hNOEFsTHBk?=
 =?utf-8?B?Y2pMM0ZOVkVIOUtTVVpYREVqN2RnYldJUWhoUnhJK2dENnNvL2RGNVR3T2FY?=
 =?utf-8?B?SWtGVEhkRFpXZ2JGNG1rbXNjQmhURXM1cG1YNHh3aUtlOXgwR1FLbjNJZjBF?=
 =?utf-8?B?citRUUt3NGJBbmM3UDYyMlhNeVpxK2VGV0JWWkE4RDRlajVTZGVtTkRoc3Er?=
 =?utf-8?B?L0JvbXVzUVZFb1NzS2dxVHdXRk8vNWtka1o1dlRrWUQwc1U4ekJxeW9ydmx6?=
 =?utf-8?B?eE9oeStzTkNxMUFGV2JpTmdBamxKejR5T1pSUEtBWXE1N242TDNmTVBvcVlj?=
 =?utf-8?B?bkdFbDVnWWxZTEtYOGZLYjZXNUxPZzhLUmNYbTJEcGZYUGZ0bkF6UzU1M3l5?=
 =?utf-8?B?MUp6TnlnNENhSElHemZ2b3hvaG55ZzJDZ2JlbkNFUENEMFNEaWcwN3Azdmdo?=
 =?utf-8?B?RlFUOWJNUVJhTHdIbE05cUhVMk9jc1JNVHkrcFd5d2xTVHBJWnJlVVJETG10?=
 =?utf-8?B?eE90cXlBOUxKbFI5NElKcDJ0WGhNZkJMSGlJSU9WSnV2QmJiYmIzM0lXam9W?=
 =?utf-8?B?aGJSQXRFaVVaV3llUXpUa3lETm9LK2ZtRzQzRmN3eG40d29PV2UzRXhvd0lR?=
 =?utf-8?B?bTdaM1JQV2dNRi9YcGRWSjQyb3JEMi9vRCtLWlZIbTBHSEcyN2ZOZTk0cnZp?=
 =?utf-8?B?RGpULzVHWDlVd2JMekFMc0VaKzI0WVg5MTRHMUprMHFJUWt2aS80TVYxeVZE?=
 =?utf-8?B?b04xOEVLV2JFWDU2SWV1SXoyYkRnV0hFUldZdnhvV2tjSGxvV2IySURrSUxm?=
 =?utf-8?B?azl5NGRTVTU1bjdwdGVibW0ya3VtRjh3UHR3N3poaHFlVy9iNHFFTHBITm01?=
 =?utf-8?B?UWJEc050dGtoa0xKb2hxaWd0ZHkwVzFQSFBDSU54SjA0dW5BaWJSUlhTWmJi?=
 =?utf-8?B?RzJXK1RYYnljMGFwU3g0TEpvd2FGaDE5ZFdOMDNUQzJ5OXFRNlpDWWVLOHZ6?=
 =?utf-8?B?TmJpRDMzNEdHSXNYT1JSeCtyM2lyL1ZnMUtPMGpHT29CRlhGWERrTFJ0bUpN?=
 =?utf-8?B?SjR1YkNLVnZKNUdXUVNiQ0FBVW5pRGVGZXo5cjMwTkNaRVp6Yko1NGttbGRv?=
 =?utf-8?B?VEZRa0QxTGRPVFpsV2hTVXlIQzhWeVY1Tm9uVHc0WVNYVTlXNXJqd2hOZmx5?=
 =?utf-8?B?RFZVeHBBa0JmYTA4c1BUaDM1ZzJqWmxTQ0ZDZTRFL0p5eXg0a1h4aVduOTdz?=
 =?utf-8?B?UFhBbXRSSUFXRnNUTEJFYmVSZkRpOTNKL2s0eXltc2JMSmZlb01SMVhvUmwy?=
 =?utf-8?B?dVBXMHVYUitSc245K05uZHlkaUx3ZWNOSENJWUNtZjUzdFNwL05ueXlFbHdB?=
 =?utf-8?B?dmdwZ21TWFY1ZzR0TkdaNXM3TFZRWVBaeDJxMHFCRUdlWGt1dGk1citUa0Rh?=
 =?utf-8?B?V2NMVGhBb2ZHQjl5cDdnSisvT01mSExIRlFCREtWeFFkM3Bxb29YUy9OcGpa?=
 =?utf-8?B?SWdjU3dlQ09XZUZ1TU9WZ3VxdGM3cWE5TUdZdEM4QmRZQXlla2IrNzRjNTI3?=
 =?utf-8?B?WGJ2Y0pmNVd1MFErNW94S3ovcUxrMlRMcTQ0VDB2MlNzREhuNy9RaTF3eXJC?=
 =?utf-8?B?RzBJUjNKZjAzMmJoUFhzaWtsQStiTCtuQWRWNzhBRmMwd010QTc2c3p1bHg1?=
 =?utf-8?B?OVFobmlRT2xwZlp4dmlXZmY3alVYNG5zd1g5WUNSQWNKbUJVczRud3ZPMHh5?=
 =?utf-8?B?bnJQNkZDR3p3YXB5VDRHMVdqei9YSXN1ZTJkZ2s2WlNPeUhUQk9yTVBZM2RF?=
 =?utf-8?B?N0tEdVo2aS9HNVlhY2VDTC9PMjlTQ3Npcm5TeFNySTBsQy9HcTdIczJ5M2pP?=
 =?utf-8?B?V0t6VWdNRGdhUmFiSkpSS0VlVjZtUU9vRmdEQld2dDlCUkFyaEJhdDNMZGR0?=
 =?utf-8?B?aVBnZ0VXK213PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVRRUHc2Vkx5K3BVVGQwTDcyK1lmSnVIeWRxS2hQNGFaYkRud2YxdW5OS3BJ?=
 =?utf-8?B?MGI1QUNBSEpzZ2t1ZWsrdGR4YXdORjJGeitHWTl6UXVUeFZCTCs2bUppUlNr?=
 =?utf-8?B?d0pWZlpxb1ZCcXVVS2xMNDJJcE5uKzNFS2VOS1dLVHlBSUZ2TTMwUjVSbWJF?=
 =?utf-8?B?MmdwWk81cHQ0akF3TWxLNnJYaUo3OFdUV2x6dmVadGdMMUM5ay9ESSs0cjlD?=
 =?utf-8?B?ZG5YZ2pOWnZPMWE5bm84anZrWkNjRXlOdk1tWHgvdVlyaWVEc05iTnNEVkl1?=
 =?utf-8?B?UHVzbVVJcHAyUGV5elM0N1BMcWloOWVqM0tlazdLZ0RDWGRrOHVNejVvMVNU?=
 =?utf-8?B?Qmp3bjJzOUtwQWpNTWM0ejBvU1orQ29jSXE0MVRvNmJ0eThKYm5paHpRMmZj?=
 =?utf-8?B?Z2JYalVobFZ6L2ozVU5la2F2MGNoMkpYS01KYjN3R2RiclM1SWpCVE5WV2xv?=
 =?utf-8?B?L2daTzlyWE9wUjlJSnhnV2pVaStPSmt5azZENjNHNHVxUENOTFNYNW13MHEv?=
 =?utf-8?B?a3lmVnNoeHEraFo0ZUNYc3hjbkt0ckpZVmZRQXh4QllSSnBYWjJ1MndiZnlS?=
 =?utf-8?B?UUxoYVhvNVZjSWh2dldEbDV5Uy9NTm51aVB6dGg2dGtGdzBCSWo1dElER1hE?=
 =?utf-8?B?Ym1ldEpCdkpGOWNOWklHNkd6M1FhVTc4SytEQnc4a21GTFZRSEJSMTRzZDdW?=
 =?utf-8?B?RXdnNWNFbFQxNXdtTFlkRFY3SExsNTEySmtoaGEyQ0hnRjRTZ3g4Sy9jR2JN?=
 =?utf-8?B?bWFPaWZYVW80TmtFRFdJUWlCOW1WNWptYnRadHYweDg3QjJBdUVTZmlSaFly?=
 =?utf-8?B?d3ZjbmlSOE1SMEc1R1ZWWlVWQ3VQNFY0bkZiRkRVd2lSVFQ2OEhXckgvVEVM?=
 =?utf-8?B?Vm5seW10b1ZnTUNMZjhrZUF4Y3JOVTFNQ2JmNjVqWHpNby9JbWlXUTZ1VDNn?=
 =?utf-8?B?RnhpUTVHa0RKK2VGQlNENnNBcnhHNzY2MXZaNEJMald6TEJhV2hacG4vQ1Vx?=
 =?utf-8?B?bWd5QlpqeEZNa1hNVGc2ejB6ekZvcHNDMUpSRDVCMUwxQ3BzaVZ2Mko2ZG45?=
 =?utf-8?B?alArdzdiK0tPdzVTV09jQm9jaXNVblZvOVpoc0VmVEpOdzZHUzN6bzFidGRK?=
 =?utf-8?B?cDd1Qmg4aklHM2FydGFJd1g1SWxKMHMzejJDcFZrV29jNm9TSnZWbzM1aHY5?=
 =?utf-8?B?RGtWV0R0TmlsU2NPNE5SNXY3KzNnUGVEaVBaemRCTlRGSWtNdzZrTi9tNGJS?=
 =?utf-8?B?bzJ2cHBsUTA4Yk82cE5KMGNTVWNFTGk3cHl0OWt0OUMrb3U1anFXdjBKVzlI?=
 =?utf-8?B?ZEJ5QUJXUEdIMmUrekdKTU9yZTdia1ByTExRcTRDaFVDaklJQURkVXBnTXhy?=
 =?utf-8?B?bjRObTM1bFVWdGJMRVJST0FMbFQ1SlUwNkVGeEpTbzY5WnlyRGkxL2NSR2NJ?=
 =?utf-8?B?dmx3eHJiYksvVGdTTEtPWlBTYm1lTlBxVkFMdDVscjNSWjZrVFdQMXcxNmg4?=
 =?utf-8?B?b1I5Nzl3YS9TdTJKcExqakpwQmV1NmRRVnpXTk8vSUZDd0t4T3QybzRYK21Y?=
 =?utf-8?B?aGI1UFdrSGxFbHdtdDcvWTJhU0h2cWJQMEtodnk0Q2ppOGY2UW9pdVNNTFhj?=
 =?utf-8?B?UUkwdU1heHNVSThyOUFGNTFVOGNOclMzQnVyR3c2VzFvbitQQk5ZLzRUTndF?=
 =?utf-8?B?WHpqOWxOcDh2aldVVktmVmxRQ3dXcGttYW4rT05kS3FqTnlGMVdqaEJiRlJH?=
 =?utf-8?B?bXRzUFZNR2FCdE9sSHkzWnJCVnlZOHVrWktYU255aExTYTRady9EblRpN1lz?=
 =?utf-8?B?TnMzSmN0VS9FVzFoN0NnVDZZWEplY1NWbXdscHptci9iaDhtb2gvbWZIMUtO?=
 =?utf-8?B?RzljUEk2b0M2V3BhcTBlcDBFZTUyRG1JdUVIYnh1c2tUQmwwWG9Xa09MaWE1?=
 =?utf-8?B?WXpkUk9EWjYrcXliN01BR3FiTjhhSjM3enlMMHN0YjVzeTQ3cENkWm9WSGJy?=
 =?utf-8?B?SGV6Y2pqRVVIWGRTMWtsaVhHd1V6allYRTdZLytvZDZHNDFCdzlJbU1NbXdW?=
 =?utf-8?B?RitQVUJDREhENlByR0VsVzdXZ3crWUkxYUl3Y1BZVlRmUGV1RmVRV2pHSTcr?=
 =?utf-8?B?eXVnQXBxNkdxaVExZk44ODZTYktlZnpNOW5aY280K1g1d1BaRlRxeldZM2cw?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <478D32E86A12D64C8ABD348E7EF7E5CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oPTwNHCVzHBXIAJfYZKejWIlYn9uUO0x2FlCQegjiI6z9BKR0SazM+Gw3Grdrzq+fTY0EdwBvSqUa4aSyV3Uqf6yOBwlsdbnvdCJeTTxxFalrQyqojEzxEwdtEORW0nndEz3gyfJXBcs1Nx0iUY37S7NYGEB9f1KZUqBG2OIGP4LhATN0rJwuMdZQkE1OYUY8GPdjEpE7bDwdnpl6nwt24bWPi5hjFAFPrTXGwwhw5r8JPxErNHzFeKInZ1yI5+STL3zQzOjHQ1sSEjh6X0N8Miterbj8FUurz9nwksZcUJjED2v9RIecfJ0sgQucd7IWgNN0zNv8riwdC/fQ6YydLBWMwZfAGMAl54/jOufGpTbgmml+YslvGXlDko9oDOhfQQK0oF2COrsJyY9sIxKOSaAEAFxZ1K76lJ6cPTNK1vjrxsEcBLva3ageX1bDP7CDP4TTdS4mbc499bsdiqiBLU1nzjnr9NWshCqGLP1mnImvW+ko+s9aLL3EJ4oT7dr7jw3cHVIwD9oTJpIJ17TaxogMsiwlloCinczkzkf+FrxwdKeB4xZN8GuJZ8anbZjBD4azfycCLpbusJ9NIk1rAU89zTBicJUFSKn5iPDDmpOAKE/vNzQcDEgttawjsas
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401be180-a682-4af1-9a71-08ddfbf802e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 05:54:37.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3fltmgRjHa0LstKpa+U/vjNV5uycZdNzCGFXPu/ISzq3AnEyxwBaHBd3GLfGL5XOA1HlrVap7/r9lcijA1YcD7UdwzOH8UfVbnTg0BDijlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7754

T24gOS8yNC8yNSA2OjU1IFBNLCBmZG1hbmFuYUBrZXJuZWwub3JnIHdyb3RlOg0KPiBkaWZmIC0t
Z2l0IGEvZnMvYnRyZnMvcmVsb2NhdGlvbi5jIGIvZnMvYnRyZnMvcmVsb2NhdGlvbi5jDQo+IGlu
ZGV4IDhkZDhkZTZiOWZiOC4uYWNjZTRkODEzMTUzIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9y
ZWxvY2F0aW9uLmMNCj4gKysrIGIvZnMvYnRyZnMvcmVsb2NhdGlvbi5jDQo+IEBAIC0zNzgwLDYg
KzM3ODAsNyBAQCBzdGF0aWMgbm9pbmxpbmVfZm9yX3N0YWNrIHN0cnVjdCBpbm9kZSAqY3JlYXRl
X3JlbG9jX2lub2RlKA0KPiAgIC8qDQo+ICAgICogTWFyayBzdGFydCBvZiBjaHVuayByZWxvY2F0
aW9uIHRoYXQgaXMgY2FuY2VsbGFibGUuIENoZWNrIGlmIHRoZSBjYW5jZWxsYXRpb24NCj4gICAg
KiBoYXMgYmVlbiByZXF1ZXN0ZWQgbWVhbndoaWxlIGFuZCBkb24ndCBzdGFydCBpbiB0aGF0IGNh
c2UuDQo+ICsgKiBOT1RFOiBpZiB0aGlzIHJldHVybnMgYW4gZXJyb3IsIHJlbG9jX2NodW5rX2Vu
ZCgpIG11c3Qgbm90IGJlIGNhbGxlZC4NCj4gICAgKg0KPiAgICAqIFJldHVybjoNCj4gICAgKiAg
IDAgICAgICAgICAgICAgc3VjY2Vzcw0KPiBAQCAtMzc5NiwxMCArMzc5Nyw4IEBAIHN0YXRpYyBp
bnQgcmVsb2NfY2h1bmtfc3RhcnQoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pDQo+ICAg
DQo+ICAgCWlmIChhdG9taWNfcmVhZCgmZnNfaW5mby0+cmVsb2NfY2FuY2VsX3JlcSkgPiAwKSB7
DQo+ICAgCQlidHJmc19pbmZvKGZzX2luZm8sICJjaHVuayByZWxvY2F0aW9uIGNhbmNlbGVkIG9u
IHN0YXJ0Iik7DQo+IC0JCS8qDQo+IC0JCSAqIE9uIGNhbmNlbCwgY2xlYXIgYWxsIHJlcXVlc3Rz
IGJ1dCBsZXQgdGhlIGNhbGxlciBtYXJrDQo+IC0JCSAqIHRoZSBlbmQgYWZ0ZXIgY2xlYW51cCBv
cGVyYXRpb25zLg0KPiAtCQkgKi8NCj4gKwkJLyogT24gY2FuY2VsLCBjbGVhciBhbGwgcmVxdWVz
dHMuICovDQo+ICsJCWNsZWFyX2FuZF93YWtlX3VwX2JpdChCVFJGU19GU19SRUxPQ19SVU5OSU5H
LCAmZnNfaW5mby0+ZmxhZ3MpOw0KPiAgIAkJYXRvbWljX3NldCgmZnNfaW5mby0+cmVsb2NfY2Fu
Y2VsX3JlcSwgMCk7DQo+ICAgCQlyZXR1cm4gLUVDQU5DRUxFRDsNCg0KV291bGQgaXQgbWFrZSBz
ZW5zZSB0byBhZGQgYW4gQVNTRVJUKHRlc3RfYml0KEJSVEZTX0ZTX1JFTE9DX1JVTk5JTkcsIA0K
JmZzX2luZm8tPmZsYWdzKSk7IGluIHJlbG9jX2NodW5rX2VuZCgpPw0K

