Return-Path: <linux-btrfs+bounces-19771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B2CC13E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB27A3002884
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F12933C1AB;
	Tue, 16 Dec 2025 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rCOU6MZW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ypbPQz6M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44D337BA2
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868930; cv=fail; b=WO+RvvFrryR5LznJVpktNypeCRcV/7sBFK+tfCkOq11Oe/oauVRUHAzjM3h/kUatlEM4zHCEVUKLmRpk1AOpJLxlq+ZXbaoanwdouegJcfJUnl6D5Wn0xCEOnqEhMEKchPXNs17b0crWxZ81bhO7Cjgcwf9q6uTK+FeoCM3hCFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868930; c=relaxed/simple;
	bh=JDF+MD65666LDFIm7akDUjgx5uYs54WkGWhBp+dCtBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vCUcSFhyGOgdHnEB0M77mJXcPnVg+tmrennDv9d3q6r81T9ZDYLkoLq/LQk8S66v78uCCbVmeodKpMoy3uD5BthNAmJ4OvZz8AGVfNYVSxeYYeaOc2c7khkRUdvB7fLcgIMckUJVvVblVD3y+QtkxEaqUlsCLDQWP9+Xok3X0PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rCOU6MZW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ypbPQz6M; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765868926; x=1797404926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JDF+MD65666LDFIm7akDUjgx5uYs54WkGWhBp+dCtBg=;
  b=rCOU6MZWlrg3vnijmpZJxbB6N4E6iTGISLijgt0tcjCONUzuSgZuyfAr
   xL1DJap1J57SiMQI/tXvvF/i3R3p86ZnIFcXlzGybnshMUEon16SWgLb4
   o2mBKmUmVTYrPv8L3N+b+rofDVkaEIjodtFhxHaF8nzfxzIFkiqaSYwfm
   XTtfXb/5h2NNX7YN91mGw+itWjEqRo+yhZAwLzdCs/hssURJVHicJJoyw
   mZ7c4l59401bYHd8WBQSOoP0oTVWNxVcAcr8cLLQg2YwwNIetMoGsCyvS
   qwGdwtSDYqGnnZkbsYLIDkRf339t/w+NRHAMXgkJMqh+wEeekDHt+ezDh
   g==;
X-CSE-ConnectionGUID: lfY39+RcT22D1jYUkCldbw==
X-CSE-MsgGUID: GQIMB6q3RMGHBl0WxL5xkA==
X-IronPort-AV: E=Sophos;i="6.21,152,1763395200"; 
   d="scan'208";a="133939932"
Received: from mail-eastus2azon11010056.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2025 15:08:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPDIz72eAcHMBxJTu5v6KHwbplzRNqlQFkwTW8L6FAb/Xy1CZbYtRVJyL0HMsJH7kya9rSgF8zaZaX1S/PiUx2/gxEqjJE5ulKZ6EquVYcEDApfdLaM/E2DvAx8oUcM69P/i7knVIPHd/feYhlAjeja6qbL3Nxt3TLtdsIN6NuriW61ethBZIosTGQeMx0aFps+JEeG061IsRekfh/f3x2sl11duPmkjnEus5awsyFt9RHP615OrMZAY2bIiliLp8BAQqQxGYlJDUusmVxzcRQsWV6G0TF1o37lV55dQvYfpeBY0aUczhmASvSTJXXTzJlT0BRTfODBPMAyug0Y9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDF+MD65666LDFIm7akDUjgx5uYs54WkGWhBp+dCtBg=;
 b=HLsrJbDsfo9vQICA4XNnhbbAKlZxr0UqZmDMO77RV1wY4QFSZIx8OWu64H0xu4ei55qtxKplZTohehogkT/Lm67+c9/S0AGHZIt0Uouicl1cB3DJ2Re8lz2kFbLiedhk5HepNdWFEqiOtqOShDq1usXDMewmoVJicSZvdfuTEknJx9keYSqIyBiTetdl+7CIXNQk2VBhXGOK1u9x4BH2spxDlC9WY0t2ET1Vom92mV2yhb7WyGZFhQjT91LlIMDC7MAUdsLTTFgdZAul7A3ml7koijiJjY+T2G+tHLsbFw7aMJLdZi4RH59fheCn3nhJx9BA2f1UNAt5994J8RL62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDF+MD65666LDFIm7akDUjgx5uYs54WkGWhBp+dCtBg=;
 b=ypbPQz6Mf7WUe0my96LynIoB09Jdf2bqMYQve8CYQy6PEeulWgbFJNEkDzrfoxNre+47q4wUq5+3PhmkY3h7uJRgtSOAkUV3gZ7JEbGacDh65Dv11Xa81x2f+6d9vYKBNsFxR3qo9rXpU+Tju1LuHwKF9ISsWXuEywd8pb/+qaw=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BL0PR04MB6500.namprd04.prod.outlook.com (2603:10b6:208:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 07:08:41 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 07:08:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH v4 1/3] btrfs: zoned: move zoned stats to mountstats
Thread-Topic: [PATCH v4 1/3] btrfs: zoned: move zoned stats to mountstats
Thread-Index: AQHcbd9RmPOSbTAP306EGXwDloPa5LUjDpgAgADLRoA=
Date: Tue, 16 Dec 2025 07:08:41 +0000
Message-ID: <4ab2ae1f-8af9-4240-a027-01368e2788aa@wdc.com>
References: <20251215162420.238275-1-johannes.thumshirn@wdc.com>
 <20251215162420.238275-2-johannes.thumshirn@wdc.com>
 <20251215190108.GF3195@twin.jikos.cz>
In-Reply-To: <20251215190108.GF3195@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BL0PR04MB6500:EE_
x-ms-office365-filtering-correlation-id: b89c1f30-9e2d-44f0-cfb9-08de3c71f195
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWZ3YTFWQVRveEpHQndkbkpSWTNaeW9YcjZiOVNMSXNoM3JoVE5LeUNWWFNu?=
 =?utf-8?B?cVU2N2RGcFhkK1BmVGlGaWRtTk92aWs3SUxlK29TRjNGNU1MSEs4Skd2M0R3?=
 =?utf-8?B?bFFnbHRmYlFYVUlPR0ZCemdGQlhpdTZUY0pUOFQ2aWV3OU82Ry90MGZXdFFo?=
 =?utf-8?B?WU11Ly9Ncnd2bVdmcGtyZTZVazZmUnVDUURGY0dzdWlsVmVnaDJsTDBxZzcv?=
 =?utf-8?B?MVg2Q0YrVGtVTWE1OWEvc2M2cDNSZnF3cUhLYWZmSEVYTkw1OWRDV2Q5Mld5?=
 =?utf-8?B?M2VRS25JdDloRlpvakxtNjROZkRkckt6OUZhYUNsSzQ5VkY1czRlZUFLUUdu?=
 =?utf-8?B?MjJDUW8yek5RMjVSWTJnVk5QQ0VrQ1FaTWtwa3ZsREtVVjBoTWp5VHA3ZVBU?=
 =?utf-8?B?eHBhQUszS0xmUzVPNHF2Z0ZtNlI5NHJsZ3I4d0lYMUgzZXE3ZUdiRGhYanpz?=
 =?utf-8?B?YXNKYjNxeFB4ZTVDNGFIUGQ1cjdJenFBc0NvRjM3dG9YK2NJMm1QaFlSQkFP?=
 =?utf-8?B?Nnh3Z3g4eXFJc245ZksyVTg5NXB1YnptWWxsaE1kR25WM3dVQXpsR3crNnJl?=
 =?utf-8?B?Um9Ua2V6Sld6WmthSys2dEVIaXJubnd2b29wblRRNUo3UzQrVGlJZGpmR3Bq?=
 =?utf-8?B?ODl3UHppYjkyRjdnSUF1ZU9FL284MG5Da2NHRzhmWVpCUFNvdHhpMVBQUUdJ?=
 =?utf-8?B?K2hQYW96MXkxVDJCdmptcmJ5Qkowa3lBVjZGZ3RseEgxSnBmTXIrZHUrUjR3?=
 =?utf-8?B?aGdaQWhFWE42Vi9xa2lib2FZQmxUZXpBdlg5T1hJVkQrckhzZGJ3SkphOERo?=
 =?utf-8?B?eFVxQkYzMTVCV0xnSkg1WFRCQnJQcHUwU2VFTkhSc0lXZDlVdlAxdXNkQ2Za?=
 =?utf-8?B?SU1mS0VlZ2d2NzVhRVdxVVUrV3JMVW1LZHRGTitqMzJEdDJuTHB5aFJjUlA5?=
 =?utf-8?B?M085bXJTTzdNNS9qMGJLSDFlajhmK1VaWVVlUTNhSTkzeVZ5U1BVRExIeGc4?=
 =?utf-8?B?dWF6NWpJM3l2Q0xrNnd6ZHdkSHplc21pWXVrc0JtaGNWdlY0UzhhVUtsWFF0?=
 =?utf-8?B?Z3NMOXFUVzRSQmh2Q0VQdXplYXVjUkVuTFpoQndDaWZpbzkyMzVkeUwxSEg5?=
 =?utf-8?B?M1ZzYmJIK0dneURBU1lCRlhzU1JSUC92QWdEck02N0xOTlNyaXRwa1h3b0RD?=
 =?utf-8?B?dHdWdzNML3h2WkFhTjNPU1hXMklNR0tqN3dST1g0S3lONE1nQnlMSTZhSjBl?=
 =?utf-8?B?dit2MWhTcU9jRWRYWFdvQ2ZtMWhjQXErNkRyTDRMYTgzazU2QkN3TTJtdm1U?=
 =?utf-8?B?TmFuc1VnbkdnUk43VkxiM0w5bnU2eXFEaVVDR3NqUWVVMG9tMk5CWGVJTGMy?=
 =?utf-8?B?ci9iSXZBKzN1eXdtWHZWYm9mMHFDaXM1NlZXOHRpczhtaU1tdTVabUxYRThk?=
 =?utf-8?B?VkJDbFZZd2swajZFVW9zS01xcnRqYWU5djNZQk1FWVBFS2llQ01yVU42eThE?=
 =?utf-8?B?TWNTaXhZOW9GcWw4dVpvSVoyelZYYXRXWHkxdG1kbDdBUS9TZGtSRkcwdXBK?=
 =?utf-8?B?YitRVjMybTZuS2pBMnlEUFpQR0J1bjNHR0hNRU9idXhTM3g2WHdnd2VlZm9P?=
 =?utf-8?B?Y25DcldGTzBmRXJBOE9VNndYUHRoUGNFaThCdEd3QWhZeXJCZVR3T3BGVXlW?=
 =?utf-8?B?T3FENUR2amZoZTMrcFIrZjdvMnA0NWdoTEsrUUNOSXRQdUpNTlY4M1J4UXpP?=
 =?utf-8?B?OE5XcCtzT0xIOUN2RDF5NThtbWloTUFNVmNTWkpuamY0REdjYXFaclQ5YUVp?=
 =?utf-8?B?OHlJZHJpUGdnWGdUVEdVaFJWRGpVcXJMTDEvVUlDaHl2emxibjhIRnRqUnFz?=
 =?utf-8?B?T0lJMXRYajRQc1VDaGw3ZVFjWldWZVA3S1h2YzBkL0tqeTZ0ZEJ0RjQvQVFF?=
 =?utf-8?B?dlZiU0ZmNGJEVTFGYUIydEJFRFduWGRvbStaRHJHSjRIMUlrUlBqclc4emlx?=
 =?utf-8?B?V0oxZ2IxamEvRExxMEpOZTFZTVBYWlNCUzVCb0pyU3VWcHBZajBVVGlVYnVT?=
 =?utf-8?Q?0xIEUx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWxzUzF0cU1iUlBHZmJrcVVZT2IvUlVYVHBRM3NyWjUvQUxMS1JHWHpqYUZo?=
 =?utf-8?B?NjZKSGF3TXFLM0lzWlVBWnBZNXdwTDIxMGdVbU5TeHpzeTF2VWFvNW8rRjRI?=
 =?utf-8?B?ZDUzZGxLb1NIZFp6Si90K1pCeUJiVTBhR2I3TXZGejhXQkE0S3cwSEtJR1d4?=
 =?utf-8?B?dCtyd3ZXTDA4SjJvOFpvZ1FCSjhUSXNuS29YdG10Y0NQOXoySWxlZ3E4cjdp?=
 =?utf-8?B?RUZnSkpidjhDR2w1MnREWi8yS2tsSysvNmdpQ3hXL2pGd3VmR2hXN0VtdjY2?=
 =?utf-8?B?REZzd1VPamdreUYrNnlaUThXOXFWMEM2N1d1ZnlGbEhOaHQ2d09OcTFuNUV6?=
 =?utf-8?B?T1E4eUZMU1RxTE1iaUtvTXlZMXpjTk5HNXplcStSQWdQbzZHa1B4ZHV2WXlL?=
 =?utf-8?B?TUxNcjFRVWZ1ME1TMlFNcURVeUdPR3JNb1dGRHp0UFFkMngySTBFUTJIZGJC?=
 =?utf-8?B?K3pMUnhFeW1GRjd1SlI2QitSbWlHZHdxQklLZDFCY2IramxjQTFPcEJTTW1L?=
 =?utf-8?B?VjFMUHo5WWFKTjNJS2hyd0VmRnFKWDZ1dmpTWTF4bysxN1VYZWxtd0hINjFt?=
 =?utf-8?B?T0dwUkxQOWlWeVlSMVhRNGNaRUU5Q1VuSGhaTFVyRXA0MWhSMVdjRkJGK3Jk?=
 =?utf-8?B?Z0ZSRHgzdEZTMmRwWTNUaHNiTDdMYTcyOHpsTU9HT2hVTDFtamh5SlBZSFY3?=
 =?utf-8?B?MFZNSW5QRHFTZGNkQ3lBMXBmdmErNU1qODhtRG9ZbWpFblNkVTZxVVBZaWZk?=
 =?utf-8?B?WGxtVXB0Q2l1RHVIVU0wdEJGZDR3UTRPWnNYb3VXNUU1Y1dFbWExSmw0NWRz?=
 =?utf-8?B?TTRPb1c1MCtZUzU2VnNMTmYrU2tsaUlzdmdLc3BXcldQSjNNdlBqTG11VGlQ?=
 =?utf-8?B?Y0k0blBRQURVb1o1cmw1RldqZUNKT051bi8ra0pxam1yenVvMUVlaDdrc2d4?=
 =?utf-8?B?WC8zQmNHb2VGRW9ubCtCZUtpNnBtR0ZDalRtcWZQOXJ3Q1l1OGI2RzNEZHRZ?=
 =?utf-8?B?S3lPK2xJVTJYSW1jZHJLRGtNZm84RXFUNlVrVnMyaDFEOCtHVmNLSFh0M29k?=
 =?utf-8?B?S1FjWHRpUGRQNS9NVzQwSVhtK3htdHRESUt0MFhFaStGK1RiaUVaQytnS0NY?=
 =?utf-8?B?UlhLbGNTcVFRdnZxUjBFMmxHLy91ZnBKeE5HdlVWSmFpWmtsZnJqVklFNHFs?=
 =?utf-8?B?dEt2b3ZGQW11QXhEZHpQNmI5cDJyYTU4VlhHSHk3SGtpRkxqMERMcE5wcE83?=
 =?utf-8?B?ZzZneVBHNUFENnFIOUpPR0pnam0wZCtQRW5OM1lFblh3YWZVTUp2RmFsZFgv?=
 =?utf-8?B?SlQvblRaOXhJYnhFNHVSSEgvamwwQjJnaEtvMEVLYWEzRjJYWTA2SUVyL0NR?=
 =?utf-8?B?MDdjcEtFRFFYQm1Eblg4SitIYUl2VHpZblZYczlvc1NQd1N2Uk9LazhYZkd4?=
 =?utf-8?B?MWFWdXVxbUgxK2Q4czEzNVpIY25mMSs4UVRSOGZLeHNGd09qa2M4N0RnbHcx?=
 =?utf-8?B?aUVkSElyc2JqV0RBaVQ4Yk1RRnJwMThpdFd5YXJyY29SNEgxZWNpSmsxS0Vi?=
 =?utf-8?B?TnJwbDZYZ1EvYUtjZHkxZTZ5K2pDK2RwQlFSWVZla0U0N1VwR1N1M0kvL1Ax?=
 =?utf-8?B?aFdhMXBYTklwRzEzd1FMUzRMUS95ajRVSG5TVGpUeGpLN2c2NE15TnN2QTBL?=
 =?utf-8?B?eURuejQ5djZCUHlBMTFGRy8yMFp3dnZkeVBjUE9Eamg5OXA5RzdqdENsbTBn?=
 =?utf-8?B?QjRQSGZBUHo5MHZ5S3Q4dDR1RytOV0QrbkpqNTVDbngxMWUyQWRlOHlESm1Q?=
 =?utf-8?B?aVJDQkhUTlJyWXNRNzVtdmMvMjRlREQzMzFhZ2pYZ2l0TmdrL0J0NFdVSEdx?=
 =?utf-8?B?WDZ2K29ndWduZjVpc2ZLdEpRZk9LN2tDMFpONk81MVhSQ3RILzBaZHdoZjFS?=
 =?utf-8?B?Mmpyczl1cjNVekxqNk1sTk95Vk5MNUVienFlOXpKKzNJZHFMN2dpMTFITnVB?=
 =?utf-8?B?bExGRU5ERnJ4emtPb2ErM0lFWTRiUkF3RFV0d1AveG95Y0pHSkJhUlZLWDRY?=
 =?utf-8?B?VzZZcmhzaGEyL0w4RC8yVmdBNnpYMnAvb29rdlB5Y3F6bThraGZ6ZVhacHJE?=
 =?utf-8?B?b1VJVGZlZUZCdms5WlJ4QVdVU0RhSWNXVXkzUXdBSFpZWUNlbWl3Wi9Nd1ZC?=
 =?utf-8?B?bWJObVp2VzludWtDbWZ3MVBsUDlxNDRBRXZkREdVWHFBNzQvdG9mNEQ0QU15?=
 =?utf-8?B?R1AvMVRLR0JJK3RuamRCaXpUaGlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <612DB99CDAB8024CB646151BB8E9FDCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A7mSA8S9sR8/HAwY3o7k1swxs56ZbK+n8fWMqYSDxMYCg5sYZD5f3Zw+dABtEfl0dpJy101e1wqHBGSAcZyUowpgsMRcopiBprR7YnIv+6hH8lVaZEb2Q0NDsLToFCQjwMOuAz9dH1FhFRl3sNqmbmen0NqLYA4veCMPfVoCvC3ntPHCjM8yg5FHgZDKYrIp3mGjeFk7lhHuH7K2svB7alux2fboaLq+USf7hhQ2Xd/Y5sKWPENEMTVCDJeRHxVi7WmoXxeeWi/C9UJDW1G+9JAJgz4E9hketGjav88EzL43FKuLoJQH4WwRSi6GaoyYMnSWkvaJSr7AqZcC5m2PYYPEigCSQpFavK/FnKSyeJb0xx7Z6NIzfBBOwWb1mthevMycQcqp0SgcabotOEAuLx534lkTllPBEk9GbBHeCk+56OZk1p93UxKP+xRCwxCftF2XBkL8N83MNXClkCApL+742SZLyrSuyJbBLwNgjO5bXCMe+vNHU7Ru0PuolJvJx/V0YJEpS2SCqfRB8qR/nGHUFRsMtGoglwEOlvaOAONeqPaE6ouH26w5G0KSTgwQ1elzxhjx56MKYfZ6dFAJX+Oan4hCbBgvMnilusFvyhql8AGz5hI1Pt4md32svPbc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89c1f30-9e2d-44f0-cfb9-08de3c71f195
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 07:08:41.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7/+AFofC/2khB51uLcjpgypB0uOhQhc5BJc8ZtmJ7b1dW+LDBhyBIu8NXTJJyZEG4+wviIM7cNQ8i7pekCT6UiIUMO6l8rhGIGSCqmzHZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6500

T24gMTIvMTUvMjUgODowMSBQTSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBNb24sIERlYyAx
NSwgMjAyNSBhdCAwNToyNDoxOFBNICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+
PiBNb3ZlIHpvbmVkIHN0YXRpc3RpY3MgdG8gL3Byb2MvPHBpZD4vbW91bnRzdGF0cyBqdXN0IGxp
a2UgaXQgaXMgZm9yIFhGUywNCj4+IGJlY2F1c2Ugc3lzZnMgaXMgbGltaXRlZCB0byBhIHNpbmds
ZSBwYWdlLCB3aGljaCBjYXVzZXMgdGhlIG91dHB1dCB0byBiZQ0KPj4gdHJ1bmNhdGVkLg0KPiBB
cyB3ZSd2ZSBkaXNjdXNzZWQgb24gc2xhY2ssIG1vdW50c3RhdHMgaXMgcHJvYmFibHkgYSBnb29k
IHBsYWNlIGZvcg0KPiB0aGF0IGFsdGhvdWdoIGl0J3MgeWV0IGFub3RoZXIgcGxhY2UgZm9yIGZz
IHJlbGF0ZWQgaW5mb3JtYXRpb24uIFRoZQ0KPiBmb3JtYXQgb2YgdGhlIGZpbGUgaXMgbm90IHRo
YXQgY29udmVuaWVudCBhcyBpdCBsaXN0cyBhbGwgZmlsZXN5c3RlbXMNCj4gYW5kIHRoZSBjb21t
YW5kICdtb3VudHN0YXRzJyBkb2VzIG5vdCB3YW50IHRvIHByaW50IGFueXRoaW5nIGJ1ZyBORlMu
DQoNCk5vdCBhcmd1aW5nIHdpdGggdGhhdCwgYnV0IEkndmUgbWFkZSBhIHRyaXZpYWwgYXdrIHNj
cmlwdCB0byBmaWx0ZXIgbWUgDQp0aGUgc3RhdHMgZm9yIGJvdGggYnRyZnMgYW5kIHhmczoNCg0K
IyEvdXNyL2Jpbi9hd2sNCg0KL3dpdGggZnN0eXBlICh4ZnN8YnRyZnMpLywvXiQvIHsNCiDCoCDC
oCDCoCDCoCBpZiAoL2RldmljZXxeXHMvKQ0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50
DQp9DQoNCkkndmUgYWxzbyB1c2VkIGl0IHRvIGV4dHJhY3QgdGhlIGluZm8gZnJvbSBtb3VudHN0
YXRzIGZvciB0aGlzIGNoYW5nZWxvZy4NCg0KSnVzdCB3YW50ZWQgdG8gYWRkIHRoYXQgaGVyZSB0
byBzaG93IGl0J3MgdHJpdmlhbCB0byBleHRyYWN0IHRoZSANCmluZm9ybWF0aW9uIGZyb20gcHJv
Y2ZzLg0KDQo+DQo+IEFsdGVybmF0aXZlbHkgd2UgYWRkIGFuIGlvY3RsIGZvciB0aGF0IGJ1dCB0
aGlzIGlzIHN0aWxsIG5vdCBjb252ZW5pZW50DQo+IGZvciBzY3JpcHRpbmcgYW5kIHNwbGl0dGlu
ZyB0aGUgaW5mb3JtYXRpb24gdG8gbXVsdGlwbGUgZmlsZXMgaW4gc3lzZnMNCj4gbWFrZXMgcmVh
ZGluZyB0aGUgc3RhdHMgYXQgb25lIHRpbWUgYWxzbyBsZXNzIGFwcGVhbGluZy4NCj4NCj4+IFRo
ZSBvdXRwdXQgZm9yIC9wcm9jLzxwaWQ+L21vdW50c3RhdHMgb24gYW4gZXhhbXBsZSBmaWxlc3lz
dGVtIHdpbGwgYmUgYXMNCj4+IGZvbGxvd3M6DQo+Pg0KPj4gICAgZGV2aWNlIC9kZXYvdmRhIG1v
dW50ZWQgb24gL21udCB3aXRoIGZzdHlwZSBidHJmcw0KPiBNYXliZSBhZGQgc2VjdGlvbiBsYWJl
bCBhYm9yZSB0aGUgem9uZWQtcmVsYXRlZCBzdGF0cywgd2UgbWF5IHdhbnQgdG8gYWRkDQo+IG1v
cmUgZmlsZXN5c3RlbSBzdGF0cyBpbiB0aGUgZnV0dXJlIHNvIGl0IHdvdWxkIGhlbHAgcGFyc2lu
Zy4NCj4NCj4+ICAgICAgICAgICAgYWN0aXZlIGJsb2NrLWdyb3VwczogNw0KPj4gICAgICAgICAg
ICAgIHJlY2xhaW1hYmxlOiAwDQo+PiAgICAgICAgICAgICAgdW51c2VkOiA1DQo+PiAgICAgICAg
ICAgICAgbmVlZCByZWNsYWltOiBmYWxzZQ0KPj4gICAgICAgICAgICBkYXRhIHJlbG9jYXRpb24g
YmxvY2stZ3JvdXA6IDEzNDIxNzcyODANCj4+ICAgICAgICAgICAgYWN0aXZlIHpvbmVzOg0KPj4g
ICAgICAgICAgICAgIHN0YXJ0OiAxMDczNzQxODI0LCB3cDogMjY4NDE5MDcyIHVzZWQ6IDAsIHJl
c2VydmVkOiAyNjg0MTkwNzIsIHVudXNhYmxlOiAwDQo+PiAgICAgICAgICAgICAgc3RhcnQ6IDEz
NDIxNzcyODAsIHdwOiAwIHVzZWQ6IDAsIHJlc2VydmVkOiAwLCB1bnVzYWJsZTogMA0KPj4gICAg
ICAgICAgICAgIHN0YXJ0OiAxNjEwNjEyNzM2LCB3cDogNDkxNTIgdXNlZDogMTYzODQsIHJlc2Vy
dmVkOiAxNjM4NCwgdW51c2FibGU6IDE2Mzg0DQo+PiAgICAgICAgICAgICAgc3RhcnQ6IDE4Nzkw
NDgxOTIsIHdwOiA5NTAyNzIgdXNlZDogMTMxMDcyLCByZXNlcnZlZDogNjIyNTkyLCB1bnVzYWJs
ZTogMTk2NjA4DQo+PiAgICAgICAgICAgICAgc3RhcnQ6IDIxNDc0ODM2NDgsIHdwOiAyMTIyMzgz
MzYgdXNlZDogMCwgcmVzZXJ2ZWQ6IDIxMjIzODMzNiwgdW51c2FibGU6IDANCj4+ICAgICAgICAg
ICAgICBzdGFydDogMjQxNTkxOTEwNCwgd3A6IDAgdXNlZDogMCwgcmVzZXJ2ZWQ6IDAsIHVudXNh
YmxlOiAwDQo+PiAgICAgICAgICAgICAgc3RhcnQ6IDI2ODQzNTQ1NjAsIHdwOiAwIHVzZWQ6IDAs
IHJlc2VydmVkOiAwLCB1bnVzYWJsZTogMA0KPj4NCj4+IFJldmlld2VkLWJ5OiBOYW9oaXJvIEFv
dGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1
bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+ICAgc3RhdGljIHNzaXplX3Qg
YnRyZnNfY2xvbmVfYWxpZ25tZW50X3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosDQo+PiAgIAkJ
CQlzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmEsIGNoYXIgKmJ1ZikNCj4+ICAgew0KPj4gQEAgLTE2
NDksNyArMTU5OCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlICpidHJmc19hdHRy
c1tdID0gew0KPj4gICAJQlRSRlNfQVRUUl9QVFIoLCBiZ19yZWNsYWltX3RocmVzaG9sZCksDQo+
PiAgIAlCVFJGU19BVFRSX1BUUigsIGNvbW1pdF9zdGF0cyksDQo+PiAgIAlCVFJGU19BVFRSX1BU
UigsIHRlbXBfZnNpZCksDQo+PiAtCUJUUkZTX0FUVFJfUFRSKCwgem9uZWRfc3RhdHMpLA0KPiBU
aGUgZmlsZSBpcyBvbmx5IHByZXNlbnQgaW4gNi4xOSBzbyB3ZSdsbCBuZWVkIHRvIHJlbW92ZSBp
dCBzZXBhcmF0ZWx5DQo+IGJlZm9yZSByZWxlYXNlLCB0aGUgcmVzdCBvZiB0aGUgem9uZWQgc3Rh
dHMgaXMgZGV2ZWxvcG1lbnQgc28gaXQncyBmb3INCj4gNi4yMC4NCj4NClN1cmUuDQoNCg==

