Return-Path: <linux-btrfs+bounces-12463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75897A6AACD
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501FC982E09
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5420A5C2;
	Thu, 20 Mar 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="erynjPwl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ouGpkVi+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5761E32C3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487098; cv=fail; b=Q3lvSdSNLjdcH3OLzrGSPjVl8HjdLcgiy11338AxBiERE2/+gFWKj/XkIwXkuqZVq1e7LGRJ2skqjYxhutyySHrQMifm2v3cyx+QHAEsznl3VgPIq+EfUR/Pysdf/ZX2Qp30d//z8mDRePSwbgXmsz48eGrcr3Vzfvp6fL+0Xks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487098; c=relaxed/simple;
	bh=3uB0EwTPfRyofkgTOM8orCWABvdlqRtefI2f2pgPQ9E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbeJF0tGusTNyg3VAZq+SW1iSf8i5whJgZLtm0ssXkktAH1BkKDfRBIPkMpliGsHdg7sNRKPrjlwmGuya9IpkVHKZe01eewmbDhuKWwsTeutEx4tKmElc+fdMBJQ/Jcq9/ubCpl5VEcC1ToIHsTYTG/IwnYVjxsJWgnGgTWiuww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=erynjPwl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ouGpkVi+; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742487096; x=1774023096;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3uB0EwTPfRyofkgTOM8orCWABvdlqRtefI2f2pgPQ9E=;
  b=erynjPwlcoVKdL4b3AoxoY8DwCSRguJIy6PwUeQv5KWb7QgEJEM2N0KS
   2XXkKbZ8LMYjafldSEC41WeD32GVKjBKzWcyOiv1rAwjuL2izRGKcMmsp
   o/nJ3CnCthrNz+tngrx4C9umJ2lwQOJmYFk6UPnyxCb23W8O+AhTuRAI6
   80YLqL/cVospVdmqEywwxJGUYac9u7xMyuqa5msPJrolQgLcYu7GHDZ8l
   bsALQt6I8i7cTPwW1WltScaeC572He0tRn0dRiikz87OySTxpFOz3V+PC
   z0g20kuIF5ar6+syxK5CDhSQgicV+eduy66eBBfWYRKhdlxE1B8DKC05P
   w==;
X-CSE-ConnectionGUID: QoGHZCf0T325mctKxrDcJw==
X-CSE-MsgGUID: 3czPJG5CRd669vUU8c5j0A==
X-IronPort-AV: E=Sophos;i="6.14,262,1736784000"; 
   d="scan'208";a="54847098"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2025 00:11:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBMRiE3CZbA4wGINH4idFJIAjY3a4Y+7xrqatCeQjTpW18oz31nvhb4yLe2YiYIjQK3CSIJcXD1kET0sWGETm2lxbP5fj8+5yG656+hd5MLWzCbZS9To28DJcEGrnxNlNn77pOL2kQ28iGrxLbdE6TAM41Bn0pfLt+6W7huH7y8SCKbYAlX8TJGdVuPllgY/qcIl74cZDqsetk+x4w6yMm+nZ+g06u6LAU8s2IDGPD58DjnodGPnOEYnDNsb0kMIH5qaee+N3nswe0YXY7FRl3aD7Rj573S3j7+hEQaOZavQi7Ge5+3qnCYTbj21wvNhXCdlWcoa8hIebxF8ErCbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uB0EwTPfRyofkgTOM8orCWABvdlqRtefI2f2pgPQ9E=;
 b=QAJl+CgKy4HW2Ntjg5hy2XkWG1FLYoNCuPM5pWe4aa5fJzXQe1miK34VQqgJH2qqaB9aUQ0miG4emtSAyxtzHX50Wp45zgHiG77UW1oJx+10WYxkoPmt26fJZGpgrLwFwfsxNxJJ++CrqaZhv0VN2efwW5zOGWRd0tKJ9yJt9VpWj4HdW4I6W1f6HCEUz/GIdPFuRgA/dx4yR+Zk0AbCTqChu+mXRH5SgebqnL3QmgoI7Ai7U/Do7vPe3JwB8AyzSj2vP+EGkT8XysXAcZeHGcKlNtkx9LLllRPkwLi2U3A0NE5N0YUYbNHROKzvVT53sgV4WgWtqMJdGKcf7hk/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uB0EwTPfRyofkgTOM8orCWABvdlqRtefI2f2pgPQ9E=;
 b=ouGpkVi+B3iShwaq0XfQV4dEdaaYtVczxGAjvRDIIHUrCwh1s341MB60B6rp1mTXXqV7Dbb2sUxMTPy6irUaax2alSGAtG9mFdMTI+XDHXXdIKeDRAE2slCdNJHqXhjC+KFD66vO2MO9vpIOAdk9F1e3TuInDpOx7XlnTynZu/c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7076.namprd04.prod.outlook.com (2603:10b6:a03:222::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:11:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:11:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] btrfs: introduce btrfs_space_info sub-group
Thread-Topic: [PATCH v2 08/13] btrfs: introduce btrfs_space_info sub-group
Thread-Index: AQHbmJaSwVK2hix8ZEKuAMwQFCpHk7N8NEqA
Date: Thu, 20 Mar 2025 16:11:27 +0000
Message-ID: <a97c2dc4-f83a-4db3-9655-db353bd44864@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <355f307dca7ea6da7db20038d46b3ef7a2cedd4f.1742364593.git.naohiro.aota@wdc.com>
In-Reply-To:
 <355f307dca7ea6da7db20038d46b3ef7a2cedd4f.1742364593.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7076:EE_
x-ms-office365-filtering-correlation-id: 11c0f254-a2cf-43ec-a048-08dd67c9de93
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXBuSEJSZmVUV0pOTktPeVd1N1U0eUF6YjNDbWtUY3krck5uclZza2crR0ZS?=
 =?utf-8?B?OG1TZkU1MS8rSFQ0c0p5RzFLWm94cExKUTNHeTdBbmI2UEpCMmgwUzRDbnVo?=
 =?utf-8?B?bXJEcHJHekRiWVdFbWZwWXV3MVNkVU9WMTFhR0kzWmxtZllzM0wxODNSVDdL?=
 =?utf-8?B?ejJwNzJIN09hVjNjY3hyMThrSTJwakw1T056blNJV3ZUV3hCUi9yYURVcnVz?=
 =?utf-8?B?b2RqbGxWVzFZSnJjbnE4aCs2UkgxNjc0OFZLajlpQnpwK2E3dGx5dWN0eFJz?=
 =?utf-8?B?YVZMQVJ3d3Zoa3VtM2hPdmlwQy9XZjliRXdFZWcyL2RGRmFsTDNpRGNPYjdq?=
 =?utf-8?B?OXNRRzJ4L1BydFpOL0E1ZEhYTVFWeUJyQmd5alc0YTNVY0w2eGJRbmUyOC82?=
 =?utf-8?B?Tm43MVFuZzdhc1YxbVptWVBGWCtodExYUytpSFFWb25CRHdoU2svM3JPUFNB?=
 =?utf-8?B?M0FWRC85T1RucVNHWkZPTllBemphVC9IR3Z6c2RFUWE0a2lqYjVNUVA4dGhY?=
 =?utf-8?B?aytmeFBFbEJQM0FlY2VTN3ZNTDg5eDkwU2ZCNnQ3c3NGRE1QQWwzL2doL1Bt?=
 =?utf-8?B?bWhaWW5qL3dtbzZtczdmMERFbFFtdlpCSmIwRlB5NnJscTNKVHpyeDE3MDZ1?=
 =?utf-8?B?bE8rV25aWWE0L3l6WXkwMy9INStoYkpUY2hEZXdYemtYVU50YiszemZRYWtw?=
 =?utf-8?B?SWtWMmt1WmZOdTBZMUwvUlhrek8vc0dpSDlITDFSYjV4MWlXY0ZxQVJMaWdl?=
 =?utf-8?B?ZWZwR3dwOWRhckY3YWcvOG04OExITzYzRnhuQVFmQWExeCs1ZndIajd3b1Zl?=
 =?utf-8?B?QWpiWEZ6NW9wRSszaE85TzE5MHBCVDgxOWtQaUZ0d2pDVFFLR0ducFI0M3lP?=
 =?utf-8?B?L05xNGhvOHl1KzRaa2RWbGFJUGpkdzl1dEJ6WlNVTmpmRzdMellERHRGR3RD?=
 =?utf-8?B?bjRuLzRrZ1ZXQ0NuSTFxWVdzaHBoNXgrWEY0SUNqZ0Ewd1ZRejlHT0w0eklS?=
 =?utf-8?B?N3JoYStZTnpZMDJTYzN5ZjNLYlFTNzBkWHZjZDZHdVRLMGN1YitQajBSaGp1?=
 =?utf-8?B?dStSeEhudXNXYU5KSzBXZkE0aWhWNThDa1RzM1RjTDhmbWdLb1o2SGxEQXB0?=
 =?utf-8?B?dWZRdHB1akt2ckhESWgwQXFwd1I1bEZmT0ZlSTNEbndUMFh2djVtS0JadTZ6?=
 =?utf-8?B?d2x2dUJnckJwVXFUelFOZ3JiTGZ6Rm5aSlYwT0pIampkSTZWZTd2VWJQc0dn?=
 =?utf-8?B?N05KWVFCUUFFSFdKTFdXblBoZThZamtuOXRJWWhFWnNIS044d05zSkMySTNB?=
 =?utf-8?B?OUFqd2RWdm9qVWYyZjBzOXNFMEZSTWpUNkJ1d1hCbEkyRXdFcHIwV2l5NzZC?=
 =?utf-8?B?K3lDQnVTOGJnNG5JUlRJRGpyVnpxVktSR3ZGWlVYd0ZSWWhHQlNzckRITVE4?=
 =?utf-8?B?VURrWGJCWk5sMmw4UjZLeFh3RGt1dlRCeVpnUi80bWNHaTVGQU1YWmorMGRC?=
 =?utf-8?B?Rm14aWE0eFV6amxZQkJQTmlWUWJ3YXI2T0FxNXZGYWRVVjQ5Ym83Y1FmWXUx?=
 =?utf-8?B?VFhoSzd0cTRYRTk1MGhlMUdNNGFSSGd3QmRaSHlQS1BOYnVVZUhyL2dKaWIv?=
 =?utf-8?B?ZW4yQVdjTUdiRkZVM2JITlBNMmpHT2hGSEx2N1BtTFlaSERiZDNRc0x2VWhZ?=
 =?utf-8?B?NVVUa1RneGNKd1ZYSE1RL2JmeC9BVlZTenh1VWJ4R1lITnQ5eVdFZHZSYXRO?=
 =?utf-8?B?SWZScmJrOUZJVTczWWZVREMvQlM0SktvWTJVeEt6emJZdXYxY3FSditWaTdk?=
 =?utf-8?B?blJ3Y0k3OWkwQm43QjlUZG85R28xR2tVdFhYRWdweUI4MUtHOUltUi9LOUdy?=
 =?utf-8?B?bUlVZ2VIVnRONWhWeDlXS3pyeHVRWEJueHhaQVZOWERNV1VVSXp2cXo0b1F1?=
 =?utf-8?Q?oio6lYUHJwM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGJ1bzJLV0xRdTI2ZGRnUVY2czBpTkpVdXZyM1Zka2FBTDlISERvakQ3QXBM?=
 =?utf-8?B?RDl5Z00wL25kTGE1VUNsR2phUDUreXVTaVdvc3IxWURWeHpDUS9Qelk0b1I2?=
 =?utf-8?B?SDBUYWRCRjhyYm1IMEFUNjhVYThadG51aHlLV0FocVhwblE5MGk2TnNYSDhU?=
 =?utf-8?B?bW5mdGRTVHV3RWJyWU9DSWZRRUdzRjM5NGMwMkVWdzZxWC9YeUZ2QlZTOGtP?=
 =?utf-8?B?V2F3OUQyc1NYazFwOHo5RTRoVUUvTWx6OGh0V0RjcE1za1RiVkIwUGRudlk2?=
 =?utf-8?B?VnhnSnhWYXdIenR2WDhDREtTRWp1cUlTNVM5MVV0d2RxTThvSHJaTEF6TGV2?=
 =?utf-8?B?bnAveWRlSnZxQUpPRHhscXIwR1huMnhRM0I5TjdtcnlUUklOMHZTZTkwb3lN?=
 =?utf-8?B?V1d0Zzd0b1dDaDNoMG95UytBc3R1bW5NbUVXTXB2YlZQdXZ6Z29LaFI1V1B2?=
 =?utf-8?B?eFFONGl6MDhqRW83aEpkblhiM3dPR3R0UjlNRVJldGhGS1ovcTZ2Y2wva0Vt?=
 =?utf-8?B?QjRacGZ4WGZtNThIMnh6NVJqWmZDNHYwcUM2aHZBdDBta0g3bHpjNFJ4NDcz?=
 =?utf-8?B?WFc0ZkN2QnBCRGhnK3czMExkS1lsVEFoejNISmNDUnVCdVlUQ3QvbFBOazNU?=
 =?utf-8?B?UDMvcDNFNCsyaUt1ejc0QzZDNHc2Nzdud01HaFlGSlJTY001OGVDeHU1aXgy?=
 =?utf-8?B?UHF1WW9NZVZtcXd0ekFYeGdvSEphcW83WitDc0xmU0h5Qk11SnRwbnY5YXZq?=
 =?utf-8?B?UERvQXNUMnRzdmJRMXRtQ3QxM1dmVnE1aUdvNGpyYkR3QVpJL3V1TWFDMHZu?=
 =?utf-8?B?cExJZUs0azduQ1lrWnlHS21OUXFxV2Q3SitQeG5QTURyKzRLKzd2T2FUR2Nr?=
 =?utf-8?B?eUVvNDByakR1a1l3aE04SitwQS9PSWVoVDlUdDNNWjQ2SnA5akRmWkI5bXor?=
 =?utf-8?B?TmZMK0dPNTBQR0diQ3BGVzVrRllobWVBaFZjMW10OFRnME9Yanp3WkpBL2Nn?=
 =?utf-8?B?M1BFT1FJV0xRZDQ0V0h4d1ZhanM3MExZc21FSlVyRk85RS85MjdlZy8xaVR4?=
 =?utf-8?B?dXNYeEZlVDZXS2VqT05sMEh2eUFDMEdldmI5OWlUa0NLbmlseWpWUWdWbXhx?=
 =?utf-8?B?eFRHQ1Y1VGZqdVFIWFVtRFdzZTJxY1JvNWJkQlAzSkRYc1NQdCtmRXJPQm1n?=
 =?utf-8?B?WmlCbmFpK3pINk1JdUh0bjRjcEhqRlpWeFYrenZmQTlYRjRFaUtYa3VQdHoy?=
 =?utf-8?B?aHBUcGJMOE9ZZUlSQzNOdytobUNabVArWFFNZWt4TndOdUR1WTcwL1E0NUlu?=
 =?utf-8?B?Q2M2NHJFTmUvWC9uakFPWTJzdFZSK0s2b0QvUytlSWZua2pBRnRVTEtvUzI0?=
 =?utf-8?B?SkluY1lkamdsNVpCQzRMTFM5ZG9iK3hHZVBRRGk2Tlc5dkJsQVRJV2hoM0xQ?=
 =?utf-8?B?VEdJVmpXdjZ5WWhxbXpuSlR1dnBsVlZmdStuNWQ5Smg3czI0UE5ZTVVBdHlu?=
 =?utf-8?B?dVBrckdKcmhsbE5XTERmZTRBcFQyTTdQKzFsdjRmeDl0M0F4Z0lmSTNMUkdu?=
 =?utf-8?B?TDVsUGMwMkNpK1VTRlBXYXRtQXM5bVhlc29mYUdTS2RkS2dqQ29Rb3JBRXhv?=
 =?utf-8?B?OUo1a3hnMXNwbm9NdDdoUzA1ckl3R0Q4cnp2TEtFL01wSVhHWkxuODFScXl0?=
 =?utf-8?B?L2dNYnFjOWNYVDZMRnBhU0t3aWQ4NFgxVkJCN0FrckQ1cmdVZE1HRWg1aFJh?=
 =?utf-8?B?VkloOEtoTElVZlRkcWRUMTIwNFFYdzFsaDJ0TWhIUlM1ME5EQ1hlVkxNWWlM?=
 =?utf-8?B?b2Y5VHB3UmtvMVQxR0F6WVgvTUhqc2JIYnZkRXN5S1FMOFhBdUxPVkFwbkxy?=
 =?utf-8?B?UnhTTjN3UVRrL0Z1N3FycXBHT2N4enYwYXprQ2JMVWJtd2NFdHkvdlNBNC9C?=
 =?utf-8?B?UHh2aDNsWUkvTGZQbnhnNzdhRk5ubjNyVkhocnc0VzV6Q3RNM2VIWDcvVlk5?=
 =?utf-8?B?UlVRYzR2Q1Y1MGpQQy9FbEVpcFVZTEo1SUJhM0JEWTM2ai9CLzlMYTBVQnQw?=
 =?utf-8?B?Wm9JcTA4bkVRclNOVm0vNTVkdS9Xa0NKMlo2ajZFT3dLaHJxL1AwazVKRmtD?=
 =?utf-8?B?OUFKMjdnK1hpQUZkcFhxUWJoUDVYOGw4bkh1aDdWYnpLL0dSNXlnUXFROUNj?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1EC238C75523A4EA1404AD44152E2E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	96zG+YrA2K+gI1JKpv4Qq64GRn835a8BrrN9RNG3dh3L/lOAEbePLp2z6c3s/XwXgf0rDlhzFwQw760LYPOxMGI9tpuPJJHWCKs1J9vRyaXWUPJVxkDssS3HWw6IvFfIij5byILcNgtsnt2eg8DqnnMVSpvLOeG5jbnNMgFgONJ1a5vwg2D+TFDhlsyUjRbc6GONv9sjgOTLjR4VU3hwJn+pKKyg1rFF779mjecB7PCgbEhMwuoFxh31qHgrMxuK7n9s+kJ0jtAGwMFwzRsmSQ6uhehc9ZO+wQP+NREZ0paD/lJeEgvTSfPSNNN1u3GbqM9UG1+EPPQEbnDdvoizZlLrk0txrNvarHRj0UgTqDPuX4EZE29H3MaisWWuTcR+8xjgollO7HxBM22f4Y/2UWdiB7KRwAyCRs+xk9vv93tCSD0swOQEgcpU2CNSOrZiAPN5utli2ZcHlr2qFGNipm/PL+jqXufSrlR/Mst+YU19yubtLpE5lZN4mkqXBgjz0eIEeDJuHtkeVmS47zaQzt9sgjiymb5HxOJGDDAaMcRBXMsv8i0J8mlBsJdLi4+sgMhzL+ID9+iH6m1rXdEYNEi0NevgbcObJ0dwhjVZmH6rj6dmf0sPMBMUvnCpxBHl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c0f254-a2cf-43ec-a048-08dd67c9de93
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 16:11:27.6375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fm1CpV4bicyKl5aTVQpSsnWHg94UPtwkwwMhfXvfjnN66OcMyi045366luM0h2VLQQdMVbKnjDnmkuugnej3TB8mgYCKtMfddZChy5eR3P0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7076

T24gMTkuMDMuMjUgMDc6MTcsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL2Jsb2NrLWdyb3VwLmMgYi9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+IGluZGV4IDU2
YzNhYTBlN2ZlMi4uZjVmMDQ4NWQzN2I2IDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy9ibG9jay1n
cm91cC5jDQo+ICsrKyBiL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4gQEAgLTQ1MzcsNiArNDUz
NywxMiBAQCBpbnQgYnRyZnNfZnJlZV9ibG9ja19ncm91cHMoc3RydWN0IGJ0cmZzX2ZzX2luZm8g
KmluZm8pDQo+ICAgCQkJCQlzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbywNCj4gICAJCQkJCWxpc3Qp
Ow0KPiAgIA0KPiArCQlmb3IgKGludCBpID0gMDsgaSA8IEJUUkZTX1NQQUNFX0lORk9fU1VCX0dS
T1VQX01BWDsgaSsrKSB7DQo+ICsJCQlpZiAoc3BhY2VfaW5mby0+c3ViX2dyb3VwW2ldKSB7DQo+
ICsJCQkJY2hlY2tfcmVtb3Zpbmdfc3BhY2VfaW5mbyhzcGFjZV9pbmZvLT5zdWJfZ3JvdXBbaV0p
Ow0KPiArCQkJCWtmcmVlKHNwYWNlX2luZm8tPnN1Yl9ncm91cFtpXSk7DQo+ICsJCQl9DQo+ICsJ
CX0NCj4gICAJCWNoZWNrX3JlbW92aW5nX3NwYWNlX2luZm8oc3BhY2VfaW5mbyk7DQoNCnlvdSBj
b3VsZCBtb3ZlIHRoZSBsb29wIGludG8gY2hlY2tfcmVtb3Zpbmdfc3BhY2VfaW5mbygpLiBBcyBs
b25nIGFzIA0Kc3ViX2dyb3VwcyBkb24ndCBoYXZlIHN1Yl9ncm91cHMgdGhlIHJlY3Vyc2lvbiB3
b24ndCBiZSB0b28gYmFkIGZvciB0aGUgDQprZXJuZWwncyBzdGFjayBjb25zdHJhaW50cy4NCg0K
PiAgIAkJbGlzdF9kZWwoJnNwYWNlX2luZm8tPmxpc3QpOw0KPiAgIAkJYnRyZnNfc3lzZnNfcmVt
b3ZlX3NwYWNlX2luZm8oc3BhY2VfaW5mbyk7DQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9zcGFj
ZS1pbmZvLmMgYi9mcy9idHJmcy9zcGFjZS1pbmZvLmMNCj4gaW5kZXggYzQyMTE2MWY0MjM3Li41
M2VlYTNjZDJiZjMgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uYw0KPiArKysg
Yi9mcy9idHJmcy9zcGFjZS1pbmZvLmMNCj4gQEAgLTI0OSw2ICsyNDksNyBAQCBzdGF0aWMgdm9p
ZCBpbml0X3NwYWNlX2luZm8oc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmluZm8sDQo+ICAgCUlOSVRf
TElTVF9IRUFEKCZzcGFjZV9pbmZvLT5wcmlvcml0eV90aWNrZXRzKTsNCj4gICAJc3BhY2VfaW5m
by0+Y2xhbXAgPSAxOw0KPiAgIAlidHJmc191cGRhdGVfc3BhY2VfaW5mb19jaHVua19zaXplKHNw
YWNlX2luZm8sIGNhbGNfY2h1bmtfc2l6ZShpbmZvLCBmbGFncykpOw0KPiArCXNwYWNlX2luZm8t
PnN1Ymdyb3VwX2lkID0gU1VCX0dST1VQX1BSSU1BUlk7DQo+ICAgDQo+ICAgCWlmIChidHJmc19p
c196b25lZChpbmZvKSkNCj4gICAJCXNwYWNlX2luZm8tPmJnX3JlY2xhaW1fdGhyZXNob2xkID0g
QlRSRlNfREVGQVVMVF9aT05FRF9SRUNMQUlNX1RIUkVTSDsNCj4gQEAgLTI2Niw2ICsyNjcsMjIg
QEAgc3RhdGljIGludCBjcmVhdGVfc3BhY2VfaW5mbyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqaW5m
bywgdTY0IGZsYWdzKQ0KPiAgIA0KPiAgIAlpbml0X3NwYWNlX2luZm8oaW5mbywgc3BhY2VfaW5m
bywgZmxhZ3MpOw0KPiAgIA0KPiArCWlmIChidHJmc19pc196b25lZChpbmZvKSkgew0KPiArCQlp
ZiAoZmxhZ3MgJiBCVFJGU19CTE9DS19HUk9VUF9EQVRBKSB7DQo+ICsJCQlzdHJ1Y3QgYnRyZnNf
c3BhY2VfaW5mbyAqcmVsb2MgPSBremFsbG9jKHNpemVvZigqcmVsb2MpLCBHRlBfTk9GUyk7DQo+
ICsNCj4gKwkJCWlmICghcmVsb2MpDQo+ICsJCQkJcmV0dXJuIC1FTk9NRU07DQoNCkknZCBwcmVm
ZXI6DQoNCgkJCXN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpyZWxvYzsNCg0KCQkJcmVsb2MgPSBr
emFsbG9jKHNpemVvZigqcmVsb2MpLCBHRlBfTk9GUyk7DQoJCQlpZiAoIXJlbG9jKQ0KCQkJCXJl
dHVybiAtRU5PTUVNOw0KDQpBbHNvIG1heWJlIGFkZCBhcyB0aGUgbmV4dCBwYXRjaCBhbHNvIGFk
ZHMgYSBjYXNlIGZvciBNRVRBREFUQSwgbWF5YmUgDQpmYWN0b3IgdGhhdCBvdXQgaW50bzoNCg0K
CWlmIChidHJmc19pc196b25lZChpbmZvKSkgew0KCQlyZXQgPSBidHJmc19jcmVhdGVfem9uZV9z
dWJfc3BhY2VfaW5mbyhpbmZvKTsNCgkJLyogb3IgY3JlYXRlX3N1Yl9pbmZvX2Zvcl96b25lZD8g
Ki8NCgkJaWYgKHJldCkNCgkJCXJldHVybiByZXQ7DQoJfQ0KDQo+ICsJCQlpbml0X3NwYWNlX2lu
Zm8oaW5mbywgcmVsb2MsIGZsYWdzKTsNCj4gKwkJCXNwYWNlX2luZm8tPnN1Yl9ncm91cFtTVUJf
R1JPVVBfREFUQV9SRUxPQ10gPSByZWxvYzsNCj4gKwkJCXJlbG9jLT5wYXJlbnQgPSBzcGFjZV9p
bmZvOw0KPiArCQkJcmVsb2MtPnN1Ymdyb3VwX2lkID0gU1VCX0dST1VQX0RBVEFfUkVMT0M7DQo+
ICsNCj4gKwkJCXJldCA9IGJ0cmZzX3N5c2ZzX2FkZF9zcGFjZV9pbmZvX3R5cGUoaW5mbywgcmVs
b2MpOw0KPiArCQkJQVNTRVJUKCFyZXQpOw0KPiArCQl9DQo+ICsJfQ0KPiArDQoNCg0K

