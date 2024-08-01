Return-Path: <linux-btrfs+bounces-6948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A329448A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 11:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D33E281B8D
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4FE17276D;
	Thu,  1 Aug 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bmh/EL4k";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WTy5QJu2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C0170A2E
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505387; cv=fail; b=MQ81o/FDnA94H0iSiN8VWxPBNfAAck5pZguf6pmGMPUuMYCGqC3CslcBF8PIcH5Bqjwi52hbNPDoqgKnZ23QiT9hELiIaC8i9XU2hhQWRxlTbdokn5x+sbZm4tafGhhk29GlI5IiL8c0aD0rNlYDoI1YbZPLPXpQBNpSRaRqtDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505387; c=relaxed/simple;
	bh=YEjdvZtYsuiOzvE18S0DI1mQCARMLwNZADCKX+2/Gx0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PP9I12rorgpG5/OFJ/iKs/R6j6CSLuenB5LtE4Hhn8bG2IfeexjEyQSSr1cs5jaL7Vgccxut7EfdHsqoB0BuAxiMiu3WTod29JnzWFbtjaCOFwDXon2aQERbif0ZbmUtSI0lXPZYmEfZHFv7P5FvoaJ/D+Tx4FV1PKo8XorBji4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bmh/EL4k; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WTy5QJu2; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722505386; x=1754041386;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=YEjdvZtYsuiOzvE18S0DI1mQCARMLwNZADCKX+2/Gx0=;
  b=bmh/EL4kt0zBvt4ebViXB663CytqCe2FZi+JrvwpZTxysRfHjRiaPnL9
   Qw2lMz4OaNiYvMoPYW8kmIWuWAMOhjL8UeiDckq9NubSsxO7tUZBU4iJw
   7YURRtIdawb9syFqD9YIPtRZJ0Oki4reCc2xZv1l8IQYQEEZZ3hHr1UyW
   j45Balbm4votTq5lI1U4CM6TXWaYWOxltKgQhc8LfydRe3OdpUE2EFuJd
   8f0S9M86NOb9E3tJDseRlbhgcKyfEb+U/ESYtlgYJ8n9u2C/WVjaWnN42
   kITeQRDDv9MTCZz2NM1fqnDx8TqXST/X28Bc7lyx3k7XNKTynVA6E6RL5
   A==;
X-CSE-ConnectionGUID: 5zcX8WoySoyWeAGPgWnjXw==
X-CSE-MsgGUID: Mbx8+rBSRLeMu52W6J1oaA==
X-IronPort-AV: E=Sophos;i="6.09,254,1716220800"; 
   d="scan'208";a="23186408"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2024 17:42:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwNW/WXG3ftgqyckEya27HsvFJ2LP30e5hMrWlIPIVM/Z+rQYqwVIw3K9VptvcgzZP844p+BcFbZv8BZdwx1IKedDUnwtD/XaJ1uOel7gr3T4HQNevJP1co2EAb+mvAbUTrdjOBMIy7t/z2sCo7G5rpP3X3qZ1BhAs49bwOBfYzWff4DEjcMUb7LJW3aEYLyQxCdyH2xCHyb3I95MJ0nhMZFB/yx4Az5wXvhyn+DGWTZLyhVkZUoFXqtrS8EZ/ynfy8q+l/jVSS7X48RgVKAgQIDvCI91/ehIZZRuGmGlAGVYFOsce152Li+7xB/oaabhT5vmkvUNVx3oZ9uy9zLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEjdvZtYsuiOzvE18S0DI1mQCARMLwNZADCKX+2/Gx0=;
 b=HIRkqTT/te6m+rpqIgvpOBHuH1MemJQQRYl7Q+2g11iuHeIWQ/NidCZweej3wpi8K1C6/HL9pGZU4UvU0htwP/RPQ0qmbmm6sTY1Bws893Y9NFvVzZ9wa8K+ros3Nz16R7sIkwVVvQK9Zna8NTnXruZmPGEFvfY5m4Ie93KgiY/9nTDRzLuA4DXltwc1LEC8me6j1h1ozC1yW8vdmn3MCt4qwLbRn0LePIpzrCAgsaimnd8G7jRRg1Ld/hovwNZsqPknqNODKPyR1TZIJkMgLoHpiCdJNbJ3w3YOA6fg+Eh2dM+XN8Te/HSitwhneS8ABim2ZXt3ZNGD5okQC2wiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEjdvZtYsuiOzvE18S0DI1mQCARMLwNZADCKX+2/Gx0=;
 b=WTy5QJu2SbsxLfZFhiNuhxzt/rOOOngcmFABI0KHXehyRdBUa1JgNIEOfJbpKM7lVmeS9fsOazIla9bnWdg0+pYveuBsLXXGrnIEYaEPQ9VwUdTv2j1SjggniHlf6ZGsemQne3jM5F0JO9BkdSz4ahFdLCwa9w6KornpafhF/Gg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7222.namprd04.prod.outlook.com (2603:10b6:510:1b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 09:42:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 09:42:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Thread-Topic: [PATCH v2] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Thread-Index: AQHa4+cpK0UdkPT+402i4Dsh/exMbrISJpEA
Date: Thu, 1 Aug 2024 09:42:56 +0000
Message-ID: <535aa9f0-df1e-4a7b-ab37-1ed7d8e62bb9@wdc.com>
References:
 <a3bc8f26a7c7ffff883c319464cf9b07edb10548.1722480197.git.naohiro.aota@wdc.com>
In-Reply-To:
 <a3bc8f26a7c7ffff883c319464cf9b07edb10548.1722480197.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7222:EE_
x-ms-office365-filtering-correlation-id: 9eeb80e5-1e64-4b71-7586-08dcb20e52cf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVJUNUpMVC9sNGRWL3lvUnJpOUFDMFMxVEtyWlh4S1JQNzcwVC9tZHhocUt0?=
 =?utf-8?B?eDhicUZ0OEs5eWhPMlZxR3ZSYWZDcW1YRENrNGlRV21nNEVVbVRUL1pPVmcz?=
 =?utf-8?B?MzdtRFFGR2JoSDA1a1lKQ25HRUY2VjI3TzFrVW9yRWhtTDRhcERUQWU1K0pS?=
 =?utf-8?B?N1poanE4L2xONkoybkRkR2NTL0ZZOCtrOTV5R0FHZ0ltZFNKSStPc01UKzJT?=
 =?utf-8?B?cEdZS2FIQ210RWNnYXB3eHJyeCtRclRZV2hkcTd3Q3RMZjBOOFNoZ0VSYXZH?=
 =?utf-8?B?MnRBV2ZBSVorOXA0N2c0RlRWazArWFFuaXZ3K2UwbDlCTVdQbVhvc01sK2xp?=
 =?utf-8?B?azJwb0ZyQXBHWDZna1JsZDMyUHRsL2lMWXJVbVlKd0JhQmFNeFJxaFRUbzhF?=
 =?utf-8?B?YTNzM3VjbUFOVVNhZXVnakJ5bkZaWjZWcFVDRDdldXpPK290ZG01c0hEeVhv?=
 =?utf-8?B?MXBrSVNVdTQ5SklnQXBLNk54a1dzOElMNERSZ0owWjcyRE5DSS9zL1p2elZp?=
 =?utf-8?B?aFVsbnZoMmRaOS95Z0MwSGN0Z0tnMWIvQVdVcmlLcXhvWUJNdWhLRFY5MW4w?=
 =?utf-8?B?Y2ZWTExrclVPSFZVdGdIZlpLSGN3eUh1Mk1lTzR6UkhSclJmOEJncTJBVVYx?=
 =?utf-8?B?RU1XOFUyQkREa3I3UmlXdE8rSjhZeWQ3dFUxVDRSS1JtYjZSTW5kN3B1cXNp?=
 =?utf-8?B?UitZRURTMUJPd2NWeVpwTnN1YWhMMXJPd043THh1KzB1OFZaQ2xmbzE5UnJl?=
 =?utf-8?B?c2R6b0VGbTJkcGZwZG9Dc1Bid284UEkzOVhjdGhpeDdnVXV5TEZOZXhWVFpq?=
 =?utf-8?B?TmdRZjUybG5qY2xTYVMxVWMwS2NuWHBUaFlGQ0RsWitqVlRUam0wOEpPMnZ2?=
 =?utf-8?B?Z0dpdXoza2h2OEVZSzlNNFBpNm9BWlpIMGIzNVpNVXBtMEMzektFTExvQXZi?=
 =?utf-8?B?b2h3akUxRmVBeXJqUzZCeDlnOE91QjFGckdaQTYyN3dzS3ZzRmR1MW9lVGRR?=
 =?utf-8?B?WkR2WU1aUEZhaEdNaENKU3VEbmc2Z0RxS3BYaDQxandUeUVORlNyaWNYNnRo?=
 =?utf-8?B?VnYzTlZvMDJmWjVkdXQ2dVY3N2dVOTlvSTJZRmpMNjFRc3pTcURtVnhVMkdr?=
 =?utf-8?B?T2UwVXRvTUpLdU1MWUs1RS9TcWlZSzk1ZjZ5NDQ4ODVzc1NhVS9SQk9uYU5n?=
 =?utf-8?B?UVBlMjgxeVUrVHVjeVdLVzJrYnZJOVlySnFSVkNBQW1Oa0hTWit5clNsb0U1?=
 =?utf-8?B?dkpaWlFTVjhObUVxd1lNV1o2dXcrdjU5dnNkcm9xd1NUeGp0cFg4NlFHQmpz?=
 =?utf-8?B?TElqTFhmNXJPQjVYbXpxenFtRytZN21PTXRwckdFdUhKZ2FVemlrWHFDM1JH?=
 =?utf-8?B?eWdodm1iVlhQK0pRS0lzMlhjYytrazVJWE1MTzhDMjRBYVM3bEZIRHlCQTlH?=
 =?utf-8?B?dC9lMGFab0JaaEdQcGdoTm5taEJJZFhoeFh1dzVBVjZGS01MS2JOQXpObTBy?=
 =?utf-8?B?TEJtcHNiU203emd2SUoxcUtsVXQ2bWxTYk4wRGk0VnBzT2xQT2E0UWE2Z1FV?=
 =?utf-8?B?dzJwQXYzcWl6cndYNEFqNkJxSG9PWE1ud0duRzlXUStzT0I2RkducGVtYmN1?=
 =?utf-8?B?cnhTUzE5ZHAvK1hEa0tHalU4UHNyVE44cjQ2K3BaaFlvTzFrUkJQOHNvWDlN?=
 =?utf-8?B?M1lUSVhTRklkZDM3Z01zbmlKb0NkUEhidVhmdEdWMDhFUHd6NlEwdEE1Ui9p?=
 =?utf-8?B?WWZ3bE1MV2tUZk43OVkrUC9iSUI3emlDUDVZOGFGdmxpUnFVcytIbFRmTUY0?=
 =?utf-8?B?NVlJOG5WZGQ5UEsxZEJiOFU0cFRudW9OczBUcTdQblorb2NkeVN1NXp0NS9a?=
 =?utf-8?B?WU9NZEY3NjA2bUhtT2x3UWRiLzJyRGRCZ3djSzFHTXVCbXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVN3TXpQK1ZRQVNnN0JkaHpCZittV0dlUzl3aGMvTnVXTzNlanQvSzNjSXAr?=
 =?utf-8?B?OFgzTWNrNktsT29aMUdxbHh6enJIblpYN2d5QjJCK0JUa0tDQWd3bTdGREdE?=
 =?utf-8?B?akhTTnQvaXNUOVhJa2JiU3BZYXNVMGIrMEJzWU9zNDZ2ZUh4eXZnRnJZWWlt?=
 =?utf-8?B?NGFKL29YaklGd1I3MVN6MXUxVjdhYUZxNndlSzNXKzVFdXcwRVpsQ0ZoSkd0?=
 =?utf-8?B?K3NMbTRWR2xvOThvK093UDNmeUdZSzFHWUhXUkIwbHduQlJVZXVoQTJmN1Q4?=
 =?utf-8?B?TkZ3WHhnVWJseEFmc3krT3NwYmpQSVd1UVdXM1N4WTNTMUFMeXpkSjFISDVR?=
 =?utf-8?B?NlZkWGRrQ3ZjNTZyNTlNWFYzSVZ4cUhNcmdmdFVsY2tjdXBpdjN3MG5zWXJL?=
 =?utf-8?B?KzA1cEpORnVseW04Zm15MWtBbFJ0TkRyeXVzYlh0WTU0NWZDcnJyaEdXQ1VR?=
 =?utf-8?B?QytYSEloRzB1MWFRQ1FLa094ZklUaHEvdm4rWFVMeEg0VlczVHQ1K1FiZzdw?=
 =?utf-8?B?cHRRQ0M4ZjM2UVoyVzRnaGl3MkxJUmgxRXYxNlVpYnBnSFZMNExrd2lVMGFp?=
 =?utf-8?B?bzdMeGMxRE5XWkdLYnhXRFA5VFNiZU8yT3NZRDlORUcxZitTeXQwL3B3Q2s3?=
 =?utf-8?B?cGRQclVGT1pOZVRKYVo2M1NKcVVOa1NBLzVjallzNzh1b3JuZXFYcHNtWjI2?=
 =?utf-8?B?SjRSOXZucXJMZ3hhKy81SnNqSDlUdUl3VWZxdmhEeE1SQ1RhNnZMRXJvbXhI?=
 =?utf-8?B?YkVVTWw5VWJvcnlzaTlNemhRZGtWckY3RWFsNFBvSjlxSm1STFVud2FjU29v?=
 =?utf-8?B?bFVSK0lWTCttaVE0aXRrZ2NrWWZndy8xdlh4SnpOb01iclVoNFo1V0crUjJN?=
 =?utf-8?B?N3RESXd0ZlpYZ2hYRkFXOElCSjFIYmY3SUgvTDN5R1J1RTd4a293MURVUEJT?=
 =?utf-8?B?dXpDYU5GR3I3eUFpUEExWTF4WjdUdUhPV203OTZmOEMvZkRVZHJtS3JsR3dZ?=
 =?utf-8?B?TkFsNFIwV2VwcmhEdzh0REVoRjU4VWI4emJKUTdhU2NZZTYzZXZremY2NytB?=
 =?utf-8?B?ZW1TRzZFRGl0S1UyaGk1ZEgrQ1RoY0NhMVIyUGJLaGEyMU5sMWc5ek9aVXRS?=
 =?utf-8?B?dW5KSXFNZXBwVFdxYVVmbWFlaVVpV3Zkd0JjU2JnTmhEeC9CMmJJOWkwcFJu?=
 =?utf-8?B?cExSM1pBbVByY1JDK29mbEVFVTJtL1MyOW1vamFwbkFQUjA3Qm9pOXZua0Fa?=
 =?utf-8?B?UGRnTmJVejlmeitUNGdweU1iUkRhd1RIVW9sdndwaGhFMC85bGk1a0xCRHoy?=
 =?utf-8?B?YmkvL0RGZXZLRS8yUnkvVExvS0g0N04zL3VSNm44MGQzd2NlcitTVlltYWk1?=
 =?utf-8?B?aG1kbzhuVUx1SGpYUjFCaEZ2dDVyRklpc3l4K05QNU4rSEJqS3ZSSXBEcldn?=
 =?utf-8?B?bHkzVCt5alJSMC9CWWQxWFZOK0QxbVdrbElSTjd3YmRndmlHbWpvdkN1em5i?=
 =?utf-8?B?QjVmaXRrU29LQ05XVTFua0x1NGxoSXVKQ0Q0Q2Q0bU9xNFhrRExsblplZU14?=
 =?utf-8?B?dUlIcTZydmhjNXNWUVMzcWkwRDhKbjlmR1pncDFGT3VmbmpGL0tiTlg4SHdt?=
 =?utf-8?B?b25oR2pIV3I3Qm9PbVFYMmVsWC8wbTErVS8ydUN1WThZZ3F2b0l4MDdKYlVE?=
 =?utf-8?B?UzFURHd1cUJRY08zWkc1cU5QbWxkVW5RSXVmVTQ5dkFoallLbTd0OGVmTXly?=
 =?utf-8?B?Q2ZWSTlpNFIzcnZzVHZFOFd2QUFKVGVKaGlhM014anoxeHlMQjVHZkY2RXZO?=
 =?utf-8?B?QVlLL3NtUm42a1pJY3Q2MjBIby9RVXBtQW5wRFBBU01kQ2o5a1cxUjhRUkZL?=
 =?utf-8?B?dnBVTzAyQjBJcXc4WFVpV2YxaDMzMThpSlJzLzJ0emJhTHRxOWp3ZFJhRkxO?=
 =?utf-8?B?aVdPL3RGT3Bxa3pTVExMVW5WM0hJNER4cW1PYSsrMDFOWWxCRDNsdXpSTk9h?=
 =?utf-8?B?Sm9ESUU1ZnZMb2VFc0tsQWduZHJIYktUNSs5V1l4Ym9pem9aN0c5MjJMdjFr?=
 =?utf-8?B?WklDeEZsN0lDTDVFMUtHZDk0VkxvUkY2Tnk5bWpsdWNhV2JEZUNzY2NLY1Qy?=
 =?utf-8?B?NlFaS2liR0VsUFVNOGZrY1A3dzBITVl6Rkt2ZGtudW1VdkJRK0hGTDE2Y0pj?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBEC502465BC7B42821BCD0BD4DC5381@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JRR3l3UKQGvWaziMdi33g2YNpc83/ZAgFYpm/U5yt7alqnW3rxANhp27buLwkbaOmxsF64glF30XN0bHzNPK0YqDRNTqel2ka2tcakHEkbVn+2C9rohDjvJ8psJ8vZ2zjH4/f0H4OMHLKXOnMBoGafEeElpTNY4Ztl7KiJ3gnMXstiC5RkUurfieoYADCteOaAoa8Gg7jW3KfiunCthIvTflr/1Q6VDAQhLRq17n3bej7Et8olKD4ka1nPArenAQEmkQMBropB/mWa236LrzDTNy6g7BEpTA2/J6GOYBw0A4p3rvVdar2DCMgrORQoH7kSuRzddyZrlhQFDUlc7YYDME0yqZ1dqN+FGXe1AriZibhQNr3KC132VUV7m1L6nU+piHHULWizjUOqLO4C39dqFNwQYVc3BCmxT7jmhiF0SJwwsp8A8BIssXSSWqE+cERoLWsR1m2AWyI2kmVP+pLioYU3HFlD8efxgJRXgwwsytYFF1B5iJqCkiC6q8s8gY0SfHh+Wn6OsIWICWmpGJ0ByPDKlHJm3fB/i+BF2s6CNS3R03ftrdWwXChzfUmkv165ge6HOzzWvojUWQjJUn9ZRnV+Fa9cjfRGKNxjQ0qpCtrCI4BfGDPAdahhyrx+2B
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeb80e5-1e64-4b71-7586-08dcb20e52cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 09:42:56.8116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMapf91m/2GgWa/9vFZYqHhyDGipU6u3oLwb9zs/E7VWIkPxZOkZdNWS1xfFsrXinAI8hcEP5ly8ZmccnNFeUbCggxD5iqQgrjwUNH8IFmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7222

T24gMDEuMDguMjQgMDk6NDgsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gKwlpbml0aWFsID0gKChz
aXplID09IGJsb2NrX2dyb3VwLT5sZW5ndGgpICYmIChibG9ja19ncm91cC0+YWxsb2Nfb2Zmc2V0
ID09IDApKTsNCg0KTml0OiBvdmVybHkgbG9uZyBsaW5lDQoNCk90aGVyd2lzZSwNClJldmlld2Vk
LWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

