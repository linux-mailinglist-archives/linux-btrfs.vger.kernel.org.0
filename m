Return-Path: <linux-btrfs+bounces-19896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9ACCFEBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 13:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72114303B434
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4926ED33;
	Fri, 19 Dec 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MHezQ+tz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Md5fcXKs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289818DB37
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149011; cv=fail; b=qGWeAj2QUiATGXzAcPRatxtKH3zD+YeUpPsjLzTOF4e1BEiqRnx/nbmV9buwtLVrk2Dbn3Fe+80I54BlOSSLilceLCuZefwCwu08osEkR4qC+x6/SEcisOyTcfSB4uyqyj5Prr8dNMNmlcOpGDf+Yoh8aBeYTJVABSBpIShc7PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149011; c=relaxed/simple;
	bh=NO9Xww9C4mh5+r3As19lzdCjWwK4CC2PyAigTkCiH3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ouLHq9iuWWD8AaA2Qmk2jYLGU1ty0iCf+mwZI7YEscqc/M44YbEnaPPesmrR/Iq7vFOkBMnvb37dxTSBaRjNJnn+v2njPZbYq46RgcgejDCXaqWNzSyQkAmW56DjSDEMkPXfcS9qnJ5+3aU2LSxLAq9fw95FqlEBtjECUq8MJFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MHezQ+tz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Md5fcXKs; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766149005; x=1797685005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NO9Xww9C4mh5+r3As19lzdCjWwK4CC2PyAigTkCiH3o=;
  b=MHezQ+tz631YAAvphLOAoyKkVGKjDocaFGUnga+VpAc1R+hncTj5mXWe
   HLgBBdOv8oE1tER6h7KqxJbzqf0ieLd2d5H24+Rr8fc7DyoPldfsllr64
   Pfr06bxY2PdTgann4WhL/IJOrvoJ6cFdMKkg1GeuC+73qJ6X/93YPW1xM
   n1lDbQ47C/RlCLlKDk/AdfaZe/yDCXRZ48Ctt48ZPgTjcZgzQwv9Nq+SH
   2vnlIw2ARvr3GYmKTOseUy50LzF79yBN8zjo3MdwWOOtXmO1Zq1xeFd4Q
   Hkqz41CFRFhGFoyTmJ5+On1Fezdmkh2CBo0GA7T6GYjTevUPQ2iSmEWjG
   g==;
X-CSE-ConnectionGUID: PMbjECI2Ttyq3H9K9dB/Mw==
X-CSE-MsgGUID: 2zjcVOnCQSisV7EB4K5ubQ==
X-IronPort-AV: E=Sophos;i="6.21,161,1763395200"; 
   d="scan'208";a="137276833"
Received: from mail-southcentralusazon11011052.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.52])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2025 20:56:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiUp9fAxWEfQq8/DaJheeRBOV18Ew8KggBX/Tx6rIcM3GQiiAp96n/0WxpT/mrNIzq0bJP8pPNQXCmTcj7BbGHcpwv4NNTYm0b4dNto0vK08LvusPvq8yGzUxC4gE1ZvaJv46GYUS0e9Vb9gqAKtVEax09layHyMVu94b1RxXA34y3rpCCEEL1Icsm0dJsVi1r0O8RUetw1qg5YLjXf7tyRdSxEM15PtPsVY6NcIH+HxdE0glqUs9wMhLRCU57mFnnJ5HAHIuMU09gvpq9tVGEVafSlFzEex8JPAX63OF/n0IheCECBChnp99lupMA8a9LcgZTg0OnsjudypY14Zgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO9Xww9C4mh5+r3As19lzdCjWwK4CC2PyAigTkCiH3o=;
 b=THfOwSyQ+C8UautQqqbxxGn8dTg4IAuEo3vtNXsn3Dh07EmevyGI/tLHo3stl3rG6mgWR27pmFos/3ZKX0gkXP3FsO07vwc5QXE53DIUwWOSVirabxCJeAp/JoQS90SC5ZDH2yKYdLFRcj0Vk2ha+jh0IhwuF2SgApmLicwIFL8qA01lFoc10mvZoYESpBvdCWJCtCJiwO74P4CjQndpL1NPTWqTOy8VdSPmHjvSnys929lnwb6LxSAljeES5Zf2+zwpAENHUxZGhsU9PfyIhQ2jnJKL0gWulApsQ4aOhJ11Dl2hkvi/ZV4nSGR1NLVd+2Fa8o8vD+P521A1zQxMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO9Xww9C4mh5+r3As19lzdCjWwK4CC2PyAigTkCiH3o=;
 b=Md5fcXKs5Way9qqkh/QudsNaEOlvB6Lk30VmEtpc9pujyUQBYVYQyqmKuXEtt+YN4SEOxRx2/VKlyXNCaTGzyzZq39hmXStnAvvbtydBAXvRycSI88HgdS7RZLOUq2bLoHdIURUURzbspvbXdLSZQj+kX6AUGwuOS7egeNXMVNM=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CO1PR04MB8297.namprd04.prod.outlook.com (2603:10b6:303:154::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 12:56:36 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 12:56:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Zhen Ni <zhen.ni@easystack.cn>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove redundant inode NULL check in
 is_data_bbio()
Thread-Topic: [PATCH] btrfs: remove redundant inode NULL check in
 is_data_bbio()
Thread-Index: AQHccMOYdCxjXkdj+0Of2LY5p7DfMrUo7EiA
Date: Fri, 19 Dec 2025 12:56:35 +0000
Message-ID: <0d6b1fe4-00d1-4fac-a1ed-e4a545a94adf@wdc.com>
References: <20251219084316.1164580-1-zhen.ni@easystack.cn>
In-Reply-To: <20251219084316.1164580-1-zhen.ni@easystack.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CO1PR04MB8297:EE_
x-ms-office365-filtering-correlation-id: 76e19207-aaf5-448c-a704-08de3efe0b2f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a251dE4vRDA2S0ZweEdIaEg2bllMTlJJWnRFL21WQkswTGpwR0c5eW5hWXFz?=
 =?utf-8?B?bmNVRWFoUmM1RlZsR2Y5dEQzOXl2b1praHY5eDJmaXlPQkZ1RGdIdm5jV2Rt?=
 =?utf-8?B?V2hFdUpBSUdWK0czeEhSOTNhUzc5d1FyeTdFenJqSFZjWDdDL3ordVFkYnhq?=
 =?utf-8?B?SGNkMTZSYlBSWmh0S296d3dlL1Z3b2NsM1crZkwzZk84dlZyU0EzdTlFUHVq?=
 =?utf-8?B?K1oxZXpialJUdThicEJ5RVg5RzZaRWVXL2ViMmdFRHIyKy8rOVh5dWNrUklS?=
 =?utf-8?B?ZjVFbEkraGh6TlRWOGxVd3FYSm5lQmN2V1FhckFLY1FrNHA0cStxb2xEUkI2?=
 =?utf-8?B?a1lHQWFTa3NWNDUrc3R0bGtQZVhWbHNEMDFYVC9ybndyVjlvT2djUzlNcUQ4?=
 =?utf-8?B?VjRmdEhlTkRHRVF2RElJajUvY2M3RXlTZldKUDRaZE1BN3E1UHk3NHY2aDdE?=
 =?utf-8?B?RGN3bGJrRFpBcHhDMlJYKytOZVIwWUQ0di9QSk0xbTU4VGYvcTBTYXBMa0Fz?=
 =?utf-8?B?ZWs0ZmtlbWFndjU5MGRiTHhnZ3ZnNEpsWmU1b3pkVGlGWlVZTVkyRU9uMlRt?=
 =?utf-8?B?azFNOXhaUXpkb0FaK2NqNGJrb1B4Y1JUVWdSbitFbmFQOE9Ca0VvZUV6SWtt?=
 =?utf-8?B?cTg4Z2ZDVGVDOVlPL2JHaFNucUJzQ3lpUm5pY2RLcVdUT0tqYVZFVjFuejZr?=
 =?utf-8?B?TnlReTl2enJuZ3FPTHNPRXl6NTlmVEVlMVhxUm5sekpxeVphL0dSUVhMbjV3?=
 =?utf-8?B?dy9YQWYzK21ZTS9SU3ZLS2JLUXc1Zjg5RC9nM0FCc0RFa0pPcWVJNnJQclVs?=
 =?utf-8?B?V3BweHVvVUM1ZlVXd1Jndk0rMDk5bDJUOWFnQzgrMmFXS0t6VUVlZDZ2dmlI?=
 =?utf-8?B?VHRqUldBVmw4bXBMOWpITGJGWXBPRFExakFjZ09CYmJxcWl6cGZTSlVKWGpV?=
 =?utf-8?B?U1lMWVZKWEd1Mk14QlMyQkhsRmdabjdKTDhLSXVUQU85Zy9OZkpubjViQ29P?=
 =?utf-8?B?L0hReENvNnhOVURYM1Z4R0NvVGNFT0w1MjB5bUZnUzNaOXcyOVc2S1kyVy95?=
 =?utf-8?B?Y1A1ZHo2SldOak1tWEtuZUZ3L25KWEtrdjJ6MS9lYzlxM0wrNnh3dFovVTJm?=
 =?utf-8?B?TUJCbWNPZ0x1LzFpbzIvdEVDUjBWRTBPY2FGSDZ3b1gwam1JMkNrbFluamV0?=
 =?utf-8?B?dnVYeXpHOTNueTVGbHRPMXZsRFh5OW50SUIrTndaa0NBRWlPYnVkSlA0ZjU1?=
 =?utf-8?B?M3N0Y3JNRkpMNmlkbmR6aEg0Zm95L0lONENqYjIyTmE3Sk5EQTJKdWpuZzNK?=
 =?utf-8?B?R1AzQ1djOXRZSll1TzhtUHhxZGZsRmtmL1JJcFNWMU81eDM2ZUp5R1plVkpa?=
 =?utf-8?B?d2NPZ2VVS1BpZzNrbmJIQytBbG5wdzEzYmkyMmZtMnRRZXFqODI5M3o5RGlN?=
 =?utf-8?B?dis2c2RuVDZodjRiRHoycEluOUxxdWNvWnBTZ2hOaHd3ZytKdkFUUTd5YXM0?=
 =?utf-8?B?UXRWNXVEZmQvMzNJUlNDdmt1TlExOGhCY1NLNlFERkZycExNRUs5ZjlzRi9q?=
 =?utf-8?B?bnoyZzNFUkh4VHNlK3BXazVXaFJpUWw1UVVkeWYvMCtuWkMxTDBrbHpteW5C?=
 =?utf-8?B?MjBkT2plcnlqbzBVU2wyaXd0UytoSXdVdU9tTFFiTElRZTc3VTlsQkNMUFhl?=
 =?utf-8?B?ZkZQRXpsTVpkOHhHNDNBY0dDQURaWGRlZjI0dVNaR0JsU09xTUtnSzVPQmlr?=
 =?utf-8?B?UnpuVkQ2NnpkVm1DNmtMYzQrSmwwOUVTMFlyT3FPVit2a1o1ZkdadEE0SlEx?=
 =?utf-8?B?bEpBckRKc29VeHV6dTNEaGlBamV2VlRQWkVPQlV4QXF1UVFWZFdaUmJnVDB0?=
 =?utf-8?B?Vk5wM2JEQWl6QkxEcjBhL0l5UldENFpFZ3M5eW5sMmltbDhUWTFvL3l6Tnl4?=
 =?utf-8?B?bjIzWjRiWEMySVVnV0NENFByY3JadzJ2a1BRVWZjWmVkd3k5d2NFNVMxRUdz?=
 =?utf-8?B?dnFMeEk1b2k1b2xOUUJGTnZKeDFzajVUSnJyY3lkNkpHMVU3SUptK1ljV2Mw?=
 =?utf-8?Q?2mCfEW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZU1wZ0hqTFBwMkhsMXF0enUwMitMOTBJdzIwLzZ1YXJ2TXpJVVhNZmlPTHg1?=
 =?utf-8?B?V09JZG1vdCtmU0FaY3RjaHZMWFcxSVUzZDlHdkNFN1B6ODRvZnJCZnArL0NC?=
 =?utf-8?B?Vi9BdW5EWXNHeGhrOTluSXJTTTlLcGtFaVYzMkU5NlZsRTl0N2FJMHB0Z2V6?=
 =?utf-8?B?SHFHbW1IRkVWQXJYMFRDL0t4NTJqR2VDemxjeUZ3UmVONkpDSElmaHZnTEFj?=
 =?utf-8?B?S3ZFN0lkNzBiWldlRmh5OHZoUWlFOEdIZVpuZmJJTWZHYlArVjFYM0VmZzZN?=
 =?utf-8?B?SjlrRHBVM1BrY1ZhQ2dtMVZ1WHRINDhVQ05rTEJtKzdqbWMvSHZBOW9UNDdj?=
 =?utf-8?B?alRMK2xnVlJtNlRyMjZUenhnMmtXYS9nZXZZUy9nNGpIcEk4WmgyYUxzZU1W?=
 =?utf-8?B?NGtFcVJFY3F1Ylo1Zm1KZm04UlR0WHl6Q2g5M3AzQW03V0IwSStBSkNlNTc3?=
 =?utf-8?B?VjhQK3ZrMkM3Z3hRMGNta0p5SDczR2NMTG1ib295SlNEdnJxbmlHUzQ4OVhH?=
 =?utf-8?B?T2xPNUJuSEdZT2U1UGJhd2V6U0xIdTZ4YXUzeWkraXJxWHFGaDdVNzZrNTN0?=
 =?utf-8?B?R0hHQnFtV2FVWnpJRlNMd1lTaTZ4eUE2aHdnclVvYy9sYndlcGtDYWoxdE1p?=
 =?utf-8?B?aytkdEVhL2toeEFhczhqUVkzRkIwVC94MjFublpMQk9pQUlkRC83S24xRitO?=
 =?utf-8?B?eE1MblU3WTdEWWFSSkc3YTA0Z3JKVDlWQ2ViWkdPZEpNUFZPdnE5V29xMnpC?=
 =?utf-8?B?K2tCYzJtMUlzWncrTEZ1SUMvOGEraXhTbHZNMjdKYkZKeThEaCsyakdtT2hD?=
 =?utf-8?B?RGN2MVVzNzJkZlZGRFlzNkl6b0liQThtdklFMjBTTG5YNkVRZTFQMFRWaUZ1?=
 =?utf-8?B?SGVwQ1owRGxJbnRDMkJHMnRyWldDajhYNGd5ODYzY3FLc25GWk1qczZURDRK?=
 =?utf-8?B?ZCsyMDZ4L0xtNTNNVlQxdFV6WGM4Q0FHT29pcXVCMFF6dnVGay94dUlEZkhD?=
 =?utf-8?B?TEZ0aFpMVjg5UXBPYjBmaUJvaXJJelZUVWc2T2d2dlV3TW1UUU5wMUovbTEz?=
 =?utf-8?B?NGVPZjBra1FpTlpRZHdkMTJ0WEZIdXplTnp1ZXArdlo4OWplSDYxUWFlRzl5?=
 =?utf-8?B?UTV5bGoxSGZMNmJZSVZKSUhYMG5jdmZDZ3RxZXRiSzg3NU1qTjQrc3U1ckQ4?=
 =?utf-8?B?TEtCcXJLRUFPK2xPS2hvWktaZmRzOHJqL1ZCYVF3cEFzY04xQlI3WmFWUkw1?=
 =?utf-8?B?enR0U2dOa3V6eTBkMmdaMGh0T1ZsblM3bTZSRUcvb1pJajRvVmdLWjl1a0hY?=
 =?utf-8?B?T1Y4dDA1cXV3UUdLcHhnWGcrNjNSS2ZGK2IwUkYvYzk5a3MvYWNERTh3Wi9N?=
 =?utf-8?B?eXFkbS9OT0NvQWllOW5Fb3p6ZWQ3c1I1T2dTcE1pbmNDM1E2QTF3VTQ0ZkFR?=
 =?utf-8?B?R0E4b0M0MWNxbTNaMmVjeUNjSFpjVDVLVjlPNXpMUTNtNTFYYXhUREFsaVlZ?=
 =?utf-8?B?ZnhiTWowdzdHdTZRR3U5VzZCMUw4Ly9kTWQ0YmgzS1k0bTU3bWo4c3poRkxk?=
 =?utf-8?B?MWpYN3F3b1ZCUy9qdUwwdXRpUTNXSWRvNEJIUkhuZzdaSlBodllGREdlRWlv?=
 =?utf-8?B?bk1pRUgyclBmVTVJczBvL1doK3FSbE9RWHY0Y1JqNWNjbHpzaVRHMGk3TUh0?=
 =?utf-8?B?RWRpZzkwNE1ldFB4dWhLaEpBZkFLSUhrNFNoMXZVcThRcS9oZyszK0lDTFFy?=
 =?utf-8?B?N09qZWpBTzNKRi9HUFllK05FaC9GeWtCQ0JWaXN3MVdWZmdwNUVkKzZiUWVl?=
 =?utf-8?B?c3JzSXQ2NWM2VnI4ZjIwSCtkQVFKRXJMcFFqWURRNlZ2OGJMTzJXSlZhT0I4?=
 =?utf-8?B?WVArUnlzM3EwSmtySGFvaHlVWU5Eam5vMWpmR0NzdWsvQ251Vk9rM3ltQWpF?=
 =?utf-8?B?dGVvMDFZQkxsVlRpdHV3S3dVazFHWGQwU3lFaXB3VitiZTFSb2JCWDcxSmVN?=
 =?utf-8?B?SGVwQkRVM3JDeVV4bXpPTklPTnBoWnVDdXJGUFdnRHNPRElSSXNqK2tPRW8v?=
 =?utf-8?B?M3Zlb21saGJZY1NGcWtVSU1pVERvdXdHVWtod1IxN0Z4SHFnVHU1ZzRweE1w?=
 =?utf-8?B?OHZZYzRDV01kN1RkWVBtUVdsOHU0eVFZZGQ2akFGSnZVMnU5WlprbTVOZGg0?=
 =?utf-8?B?dFpTUTZvUjJZUEtpT25Vbm8xRzdxZUJLbWVPa2V6d241NnZiaElzMTlvOWNi?=
 =?utf-8?B?d1JNWFJBRFdmZTlOdk1yRzBwY0NBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D5F5948AA03B43A1DDB74C0E1FE8CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xkyDc9RtMP15ELQoIjDuH1HsF/6tDtiiHDNpOwG6aMnav297zsKazcFhD23Y4qqyiMKIGA1CrT0FqscdbCOvjdvO2XTLjdW/PjKSfzMjkA4W/7TNKpMq/2zJIyb6F7r5GrUH6yhEqbqgxyVsvyRYW7hUB/JEHPGgxU8cNyTfnvtf77DVyGtDcpbzdtx/sVlbATAwB7jdVsGzLRDJjesKH7YJYP8f4BFduzGRDZHyJv9Nj+2oQI4XpfPLdmWXz8Pl56fqqAHyXFQEPLLRwbw1VprL+Bfb60C1CLWnsadeeJTCd2sSSkhn/m/1HR3uBI828H3CZ7+9OJy0Tn5smm3DQ2BAARrAYnmXLV2JofJQNWNdUdTdr1ZMReFJrq/f/bgRpTA37oTMQ9o/4xyMm/u+zj5a8eeHkDVh2lAFFQWuELNyEXL5LP3gKpH+vSJrcrEBV7smiaqZn8+zun1nKRhuDYKCkFJxq0dfgcFn6sWULS+B1jm6gvszl5Yf8oVU+09iBCEDpd6y7m4x42TXqyfysTn+NOaceq6EQZ/XcfXYz4NonKdUuPWK7+xptaNbQm8YcSyAJFgt6j+ErTQw3xAVYOQMauNI17kF3Z5f+tVYwuDJvfCY0kmJgu++jYqGFCCL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e19207-aaf5-448c-a704-08de3efe0b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 12:56:36.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFHSiDu96QmfWLxbimmInHoApLeMltCQmHGCOSzRnE7LzdLcDDD6vWiuzD3HI+6U1I0ccQThzXtipM9WVTrvvAf6zMKCzE7yZZiSTewF17g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8297

T24gMTIvMTkvMjUgOTo0MyBBTSwgWmhlbiBOaSB3cm90ZToNCj4gQWZ0ZXIgY29tbWl0IDgxY2Vh
NmNkNzA0MSAoImJ0cmZzOiByZW1vdmUgYnRyZnNfYmlvOjpmc19pbmZvIGJ5DQo+IGV4dHJhY3Rp
bmcgaXQgZnJvbSBidHJmc19iaW86Omlub2RlIiksIHRoZSBidHJmc19iaW86Omlub2RlIGZpZWxk
IGlzDQo+IG1hbmRhdG9yeSBmb3IgYWxsIGJ0cmZzX2JpbyBhbGxvY2F0aW9ucy4gVGhlIE5VTEwg
Y2hlY2sgaXMgcmVkdW5kYW50IGFuZA0KPiBjYW4gYmUgcmVtb3ZlZC4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogWmhlbiBOaSA8emhlbi5uaUBlYXN5c3RhY2suY24+DQo+IC0tLQ0KPiAgIGZzL2J0cmZz
L2Jpby5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvYmlvLmMgYi9mcy9idHJmcy9iaW8u
Yw0KPiBpbmRleCBmYTFkMzIxYTJmYjguLmNlNjQ5ZTI2NWI3NSAxMDA2NDQNCj4gLS0tIGEvZnMv
YnRyZnMvYmlvLmMNCj4gKysrIGIvZnMvYnRyZnMvYmlvLmMNCj4gQEAgLTI5LDcgKzI5LDcgQEAg
c3RydWN0IGJ0cmZzX2ZhaWxlZF9iaW8gew0KPiAgIC8qIElzIHRoaXMgYSBkYXRhIHBhdGggSS9P
IHRoYXQgbmVlZHMgc3RvcmFnZSBsYXllciBjaGVja3N1bSBhbmQgcmVwYWlyPyAqLw0KPiAgIHN0
YXRpYyBpbmxpbmUgYm9vbCBpc19kYXRhaXNfZGF0YV9iYmlvDQo+IF9iYmlvKGNvbnN0IHN0cnVj
dCBidHJmc19iaW8gKmJiaW8pDQo+ICAgew0KPiAtCXJldHVybiBiYmlvLT5pbm9kZSAmJiBpc19k
YXRhX2lub2RlKGJiaW8tPmlub2RlKTsNCj4gKwlyZXR1cm4gaXNfZGF0YV9pbm9kZShiYmlvLT5p
bm9kZSk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBib29sIGJiaW9faGFzX29yZGVyZWRfZXh0
ZW50KGNvbnN0IHN0cnVjdCBidHJmc19iaW8gKmJiaW8pDQoNCkJ1dCB0aGVuIGlzX2RhdGFfYmJp
bygpIGJlY29tZXMgYSBzaW1wbGUgd3JhcHBlciBhcm91bmQgaXNfZGF0YV9pbm9kZSgpIA0Kbm90
IGFkZGluZyBhbnkgZnVuY3Rpb25hbGl0eSBvciBkb2N1bWVudGF0aW9uLiBJJ2QgdGhpbmsgeW91
IHNjYW4ganVzdCANCnJlcGxhY2UgaXNfZGF0YV9iYmlvKGJiaW8pIHdpdGggaXNfZGF0YV9pbm9k
ZShiYmlvLT5pbm9kZSkgaW4gYWxsIG9mIGJpby5jDQoNCg0K

