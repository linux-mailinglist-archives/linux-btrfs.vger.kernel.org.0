Return-Path: <linux-btrfs+bounces-12357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAFFA66B8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 08:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C887F3B19C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C21EB5F8;
	Tue, 18 Mar 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L62PuqE1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c8SuiHv/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454701991A9;
	Tue, 18 Mar 2025 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282721; cv=fail; b=iS1zxYg9dII3oPxMOmtTM69eiJjIXBpfxqCixyBEcx2+nbIxDcKrnpH9uJlRRvczNkdPCnA5yPl9y6/SMUOZX07pOAVtqFxEBp3F1PDSVgUHrBQcq4zHZnDeCr3MqW9uI5THRyvaFQnaFA9I5xP4cIKpupU/lI26kjMr7XxmX70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282721; c=relaxed/simple;
	bh=Cu9DfPNAmwd93ZFx+6WN+t8qCtrgXtJVpXJKZZEs92Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4QnkJ4Lzjjozj4hzh0DDxYnMwvOvaCIP+JahqpDoPvgmYZQwVp5UkwDG34bCELyNMxGGRjcyIa/pEKoxu2Evn1xg/aA7na1EO1zJwhFvMuIhFfRloUZEgsioH7IeUo0sYxfd34bP1r6tlxNG3KJrSAsuKpT6WAi18+MEXl/MBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L62PuqE1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=c8SuiHv/; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742282719; x=1773818719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cu9DfPNAmwd93ZFx+6WN+t8qCtrgXtJVpXJKZZEs92Y=;
  b=L62PuqE1BcqwKpRyVXNUqtxNskqizypBvFWNG++i1IN09cHNWVWXDC3r
   tu+K2w3jeBDgMLGJWR0slB2Zw8ZOlz12Vl9GY+iFO+FKg+Bb5A9OHs0gW
   P4tH6ebRFe3qRdL+q+c9oj7YlyfMHxOcEds3TiPudFTPmP0sqY9pimlNG
   FoNc08SnN2ASPx25Ee8UcjAxbGYAZ6zlvvpggpvFsRSIJkDb/X0Z5MuOB
   ouZEKmRQ/w7A9p5hoZKmW5401FNH1a36E5iMQeTZ9mbz69C4kXbQLxh8J
   3Z0M1sv0djDCojG6CzxYdmXBUFiXncdWeYVr7J8jjk3qrO8TLjzS8Fj5f
   g==;
X-CSE-ConnectionGUID: /0zYsi40SvWizEMK3srHkQ==
X-CSE-MsgGUID: goK+NRYvSa2yUzIAKSomaQ==
X-IronPort-AV: E=Sophos;i="6.14,256,1736784000"; 
   d="scan'208";a="54045281"
Received: from mail-southcentralusazlp17012011.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.11])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 15:25:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syjHZ3eUyji/oZoDf4+cIaekNIGk/W5mHTmtGN6Z9BGCo7JFq2i5AvehxV02ig+FJhQ/cUv1BQvWan634qB+OlIsMDxeBYBALrsTgt+4+dVBRjZvnNfbvVxyCU0JKwsAICrKXm2Luy2ZFtHN9PgqZG03tHHtCEYtRXo9Bqd8vI9KdyzWEfdnqZkoyhJnlxLOtfPaGYQctkPz9C+L/BJ8Asfw9ClK2XzILc0ob2RWvRNheeG2HDfuMimdkzwPkE+YrOn4XOtKi4iSaGhE3ArDQq0WDGitkFN5g4Kt6Yes69VfI5su8DOwrwWrDyeLzLm8LtclQDPnmZU5WSm0hGurDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu9DfPNAmwd93ZFx+6WN+t8qCtrgXtJVpXJKZZEs92Y=;
 b=lym8UKSD69l14tViZQmZKrRWkUCptTnaRoOaQw0SNygrxcH/bYODazTj1KJ5nT65a08KKZj2y07RIj7c+VJJISWPVBnn2vEXTsDQ31RGzfpluGHLGXqM2oAOOMcLj/cO6ztbV+1Z6v8b5A1r/uX/wWyPdOxbXCwwHWZtTgJJl18S8KslKAz2fsgBXpdZnP3Vf5pOO/gaHEcTt0s0Opz1iOxIEC2PCI7phFWJ0LilVz//nHK2mJ4+ezn/srr67CV9VjWoCW868FVUkwGIR/g7ppAz3ADHy/ssKslpCFPiu1rHayzTUEmJjpsEej722WugXHpTO7KMnok7kt+IpSUnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu9DfPNAmwd93ZFx+6WN+t8qCtrgXtJVpXJKZZEs92Y=;
 b=c8SuiHv/V0De2+ei6HDerNrAzgpg14GZUKPy/mdhyV6CWwSVMlgY3KzBR1Wg1F90ijIPbBwV4ryA+a0O6t8j8KenyRLnph4U29Ci+3LDgsG2rQB1iqcGLIRntixYQJSVs9CmqzkHB1ZfZ/InCmqvin6gLhLDFK0aFqOg/WouyKY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH3PR04MB8873.namprd04.prod.outlook.com (2603:10b6:610:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:25:10 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:25:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: skip reporting zone for new block
 group
Thread-Topic: [PATCH v2 2/2] btrfs: zoned: skip reporting zone for new block
 group
Thread-Index: AQHbl6Ei/VoeCnPrv0ySWEHcQw1PrrN4fn+A
Date: Tue, 18 Mar 2025 07:25:09 +0000
Message-ID: <84a5eab2-eb29-4a40-86d0-18db0547cf93@wdc.com>
References: <cover.1742259006.git.naohiro.aota@wdc.com>
 <36a2b5616d275feaae315d0c34ac07481bd77cab.1742259006.git.naohiro.aota@wdc.com>
In-Reply-To:
 <36a2b5616d275feaae315d0c34ac07481bd77cab.1742259006.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CH3PR04MB8873:EE_
x-ms-office365-filtering-correlation-id: ca903245-643a-4bce-12e8-08dd65ee03cf
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmY3V3E5ZlFXRmQ5dDR6c0k3WHA5ck9YTENYdVJIS1FzL243cGhGODNJcFVz?=
 =?utf-8?B?YnhWYXBqcjR3UEtjUEoyRVRXS2Z6bitHYVF3SmlydlVOcENGdFExeVd4UE5X?=
 =?utf-8?B?VHBwZXUxTmJlQUlxVDJBTnB0NDF3UjVLdHJ5cm1wSld5WVRiK2I0emJHR1J0?=
 =?utf-8?B?aWUvRXl6clY1dTJyeFJ1V2krM1VXNnFia0JLcWRib2o5NUJMWDBubHhuUEdG?=
 =?utf-8?B?b3NDK1N4RGpDSjJqMGNsNlFuZmVwTVhqQXA5YytaVUZKM1hkbTZOcUQ0aHNj?=
 =?utf-8?B?MG5OSG1lR0VyUnIvbkpZRWRIYll5S3VGdVBmR2tzdkg5NFlvb3FUcmFxSjVm?=
 =?utf-8?B?dzI3TjI2ZXF0emNrbDRoWWU2VlBCclBDM1poMzV2N0xxc2Y2ckExZDNkTlRx?=
 =?utf-8?B?eWJYdE9FQ2NwTS9tMGNSdUdZaStPcmtiQXFNV2UvSzVSQjVaTTFYVEFuZldF?=
 =?utf-8?B?eDRqd1Z4R2VuNitvOWgzT0xyNWpyMWY0c1E4bXRQVlhXQ0Q4NmRKTFZ3Y2tz?=
 =?utf-8?B?MFB3bHVuQlMwWDI2SEhUenJCSVdndzd3TFllQW9POWV3RDBjWGFNTThnYkxw?=
 =?utf-8?B?aFQzQXJjd05GMnNjK3lIU1hGNTNaLzkyTnc3TGtDK1BBa1ptWkhSSStHNjdB?=
 =?utf-8?B?Z2FpTlJuNjMwNndKZlM0RWNWOXR5U29mMHMxTmlmTWhWYng2MjNEaCtIU3pk?=
 =?utf-8?B?eFFJa2lGT21JVE9JWEJ4M1d4VHhqYnFQT2dWeW0ycFUyWlhZK0ozUytPM2xo?=
 =?utf-8?B?TEl5WGFHSkZlUWJiTGV2RExOTFpENUsvRTd5cTBaSG9BcHI5V2xUdzNKTTFq?=
 =?utf-8?B?Ykt3ODdlb0hLUWRGZ05MRmMrSkdSYjhyU0xmb29ueU9nK1F0MWJ6QUUvZUJt?=
 =?utf-8?B?TjJRQVFZd2xIeFE3aG13UmRLMUg3UWVxb3VKOStOSmxWS2hqcE1aZHliVzVK?=
 =?utf-8?B?WVdtblhQVVprNy9EbEVVa1RsWXpzelVWakVFdmFiL09FMnAzQ3VwK1liZm1D?=
 =?utf-8?B?NTliL1V4VmluYytlVld2Rk5nTkNWdE1oNGpEWkMxeSt6b3dRaEovNUJHSW84?=
 =?utf-8?B?Vk02S0ZVUFJmZjJPU0tTVHMzeURLVnZaUmRFVE9veVI1YlV6aWtYYkp0YkNB?=
 =?utf-8?B?d0NNSFFmWWd2UUgrcmIvVVErVXpsc2RXWFVtcU9nU2RNUFNuMW1zVVJ1TTFI?=
 =?utf-8?B?anF4ZSthTHZjTWZnRFZ5V0xDV1M4VnJ3QmJ6TlZYVktadTJHRkhSSjJER01H?=
 =?utf-8?B?cmxOUnBPbEIyWHN4NTJRS3BzWFk5azhUUFQwT1dZYjRiaWxCb1ZHb3Jtd00v?=
 =?utf-8?B?OXpxa2FQRG9lZXkvbWU2a2dsNGxWRW1nckE3cXpqa1NDb3JQTFJ6VGhXQndP?=
 =?utf-8?B?QzVKaS90NTJlSmlQdTNKZnNueHdXZnJ6NE1UTWtLM2xEU3I5ZFRxYkJYemVr?=
 =?utf-8?B?MVhpUGF6Q0t1TzNZOHJSeHF4OUprS3M5L1BiWC9lekVudCs2U3JPZDBFL09n?=
 =?utf-8?B?VnNtQldwdGNGbjJ0TG8rNC9hU1ZWb1pKNG9KVzlKSk50TG5qaENPRzVwTFBV?=
 =?utf-8?B?T25mYjhvNEZlQXFFWVA4TmRVbWtuQzYzRmU2Y1pxV2YrQU1nUlRHKzFUTHpR?=
 =?utf-8?B?aVFHM0ZPVVdacFBuN2dGeTZQUSs4bkNWT1VicDE1U0hFK0RtMjh3N1BtQk9B?=
 =?utf-8?B?b2VvN1c3M0orKzdnNW9LdEIwSjRINCs5WjdHcG8vTHlieVRDQmpSa0o3aUdU?=
 =?utf-8?B?N2w3Y2NnYjdFUmZqZGFHQXVHZUdndTNPUTkwd01MNFk4TFFlbVpWczlPRWxD?=
 =?utf-8?B?YUY4MC95aHpGM21kQlNlMnp3eDllZ3RucVBORHdGQWJRbWMwWkZyWlF6RUVC?=
 =?utf-8?B?L1V6Zno3b1VvMzIyMmRSOHJDVUl2aHJiM28wTTdETHdnMzVUMHJoOHNyS0Iy?=
 =?utf-8?Q?vuncxBXU2TGc7t1eusA/5iLmxhmWzTnx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVRGLy9FMk1hY3NSdm1aK0VTT0JCYk16WkxrU0RmWnJmYmg4bS8vSVowMVJI?=
 =?utf-8?B?bHgwanVBNjNWbWg0czJUMmYrSGtKNUpPcFFQR2pYSjlCY3NKUURWODlSR1FS?=
 =?utf-8?B?N2drOGZIQ0M1Wi9wczZvVmwxWFBrRjZMWkhNWWM2d3dHR1IvdkFlSFIwRkNO?=
 =?utf-8?B?SEVFd1VvZWFhMDA4TERja3V0UmxEdVFEQk0yR0hOL1VtNU1qL1hUN01YUHhF?=
 =?utf-8?B?UzdkL2l5NXdLeTUvb2NaUzV5ZVp4aEV5Zm9iM0tQWTAwNXB1TTFBTEYzWGMv?=
 =?utf-8?B?SkVUdmprUGt2eGp6YkkzeFZyNlgxUXVadEI4NjBKNmQ3Z2IweFV1NVVsUHVJ?=
 =?utf-8?B?N3hucWxSUkkwZVk3ODk3U21lZTNBUUQxY3Avb2pHS1J5YXlScHRtaTNOZ2Rw?=
 =?utf-8?B?eDI3UzJrSGMxeC9zSHcxblRJRXNMbkczaEticElYL0IxNnU2bnNpUzJib0th?=
 =?utf-8?B?U1VFbjlCRXRLQS9VQlVYYm9BcTB5ejVkYWJkV3FINkJWSW1WZVpWWHhxQmov?=
 =?utf-8?B?dWJzb2VMdzZWYUdFKzBLTlJlVklBaFhuaFU0anFuWi8rdUNLekVQUHdKWSt6?=
 =?utf-8?B?aWJNM2doV1RpOGVHVWM1cWtweHVtdlkxOVVmbFlEQm9TQ3RnS0lmNy9JYzRO?=
 =?utf-8?B?UGZzcVR4RFEwU2ZNMHlyMGJHZFV2UVlBWERVT0tPVVpEbG1USXJ4NGE0QUNE?=
 =?utf-8?B?ZkZGZ0VtRjF3NDJEeTdYNnJnem04Nmxxcm1SZndxcjdlSmNDZ3N0ckhtcDl3?=
 =?utf-8?B?dUFVc0FJR29VQU55azNzVndFZHkvMVZXa1lVSC9mV0NIczJCd0dmMnRqemJm?=
 =?utf-8?B?NEhsTEhEcXJhSUMvbWNkeWFjdDZFM3Vxcnc1OU9SeHpxWUlNM005TDJFT1FT?=
 =?utf-8?B?b1ZxVDY3OXFydXJHVm1CTlVGRXVBOGh0ZnNDWWxtRVE0a1g3c0lPeFpwUjM0?=
 =?utf-8?B?YWpmNkhrU3NrTFlVWXZ6TmFVSXA1L290ZitPdExhSDFnUlgxL1JVTGhLRVlz?=
 =?utf-8?B?QkJ1TllhckxnZzFVTTd2czNDc1NpUm1Tc2FVbjFQaEEvbE5UUkZFeHI2K1pz?=
 =?utf-8?B?U2VKbXppbEpOVHRuZzJWN0liMEg4YmRvSWU2aFZpNTJtbGZmN2hNVUxIUDll?=
 =?utf-8?B?OC9NcWRoSWsvUVd1T0VsSUFhWSt5d2xIYUZ4bThiNWRwQzluWEcrSmtjcVI0?=
 =?utf-8?B?RTdocGRqR0h2ZHBwYzJaRmR5bnBYOE91dEVzU2tuL3pRMWJmSjBzQzlaWkRK?=
 =?utf-8?B?Ynd5ZHRBcmI3TmhUZHhjemt4NTA5dnVHTWQ3Z3NORVIxSGZyQTFQQVdJV3V4?=
 =?utf-8?B?ZWZJaTBmQ2wyRmMyakEyNzFVSzMwVjFXTitKcS9oL05lWEFTTEI4eFdjRHE4?=
 =?utf-8?B?LzlNVlFVU1plM01NQ1kvS0dnUjhhNWorOGRHZEpWdFU0MFU0NFkycDdWeW9z?=
 =?utf-8?B?bXZOSTkxL2s1SnVrTVc1d3hsSXhZZ3lmY3ZSS1BSSVZNTXVGWTZpR1FiOFU2?=
 =?utf-8?B?MXRGb2Y3Z2VPTWNhODhXRjlsU3ExdUczVkhjWTNIZVFlTncyLzJiZEEzdDJo?=
 =?utf-8?B?d0pEQ2pFMTBSYkI3bWhNMVdJNFhvYnJxVnlmUmJXVXlncklaK1plMmIwWWFT?=
 =?utf-8?B?T0EyTnJ4NnFqeWc4VUpZeFlkY2NSTXFhckJGZEhPUzFUYVhQbXkyWjY5eXRv?=
 =?utf-8?B?di8xUFM4R1ZpZ1h6cFc4TklRQTZjaDJNNUE4eHArU3dlV0s0OFJSU1BDV09D?=
 =?utf-8?B?MkxCZ3QrdkpwQTFWQk5OdFV1WHdFTVpTSW9mRlE2b2RXalJ1YkFCZlEwSHNa?=
 =?utf-8?B?RkZscCtiSzBpUW92TVZxSkVUV2E4VjQzcWVac0xkcjBnLy93S1ErTzZnbERN?=
 =?utf-8?B?Rnh3L3hyRTZyUUZjaXNNWkRuYjhDRXdaMUFGZGhkNkRkTlVqRUlocU9TV1Av?=
 =?utf-8?B?Ym0wbCtXNENXY3VKNEdHNDRXRkpCUzA3YmF2OVVURkxRR0NXenNWaStLbERa?=
 =?utf-8?B?N1BSK21SbHMzZmRCbEk4eFZHcFNwcXlRUmcrSUdwakY4dmVEajZtL0g3a0VU?=
 =?utf-8?B?bVdORktyVzFVMytHUjJaNks3aDhvOVBTemtoc2hwVitMYlBoY2ZPZXdWYWQ2?=
 =?utf-8?B?dEQ3MU1hM2didmNGTkRWL1c2dU5ZdERmYVVLeksxSnZ1dDVONmFZeW13eitv?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57042107C1425E4ABD5E39F04F2F2178@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fMQE0M2Ou7R1PV1v0gT6FBELPGp/8LvnG3F8DtzJHHpOvzJVcNcWCyXyRgPNo1DBzzZiw87nd1nwQTO7WQdEyAuUguIAnr/r0kLL+teYPNdJCZaPwlJvSji6ZSi5uL3K5o1WK9xYMOL4gOIoBWLJv3roNjUNWhuQ6njw2d9v3vLaOtn2sn4Mgs+cV2J8MOvm9ccUG3hfKx13qEw/eP1ifSAnWcCGh3yt0J26wZBPKebnoHeb2stKHL/2rNK4IJFSnJ+tnxBZwXk3bSkuqI2Q0cNZOz6q6tUY1pnby1YB1XvhoqY0ywUKLf2REMjosXeNGlmsW9iFDknvIbjysVjwruwuXjIVM2sOym9w/3KXEbh+L7fZ9Ylc+71i6N4bKF48ER+z4oLP+dLxyGIfDiWdcU1eEz/thTDMh5nYuEMxgsTJqqEnUxOXFovl3SuRAwXGHe49l8T8qw+Ky0fdR58V5kRGhQdyWOUhTGi+AjrfzIghpxgVB4RIDOoLlp7cwcH24DvhtWOlpebxrKSpvpzqQiLz6E8lMjaWeJIQg0IGzV3Dxa5WZOEkSRQJxl6jjiPZRrfinkaYTwXMK9XgWFGseNZOFbkWaJOFhGLpgllxoFKymQAXUwuR1adOfOWkmvae
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca903245-643a-4bce-12e8-08dd65ee03cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 07:25:09.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJeBNfyAi28OkCSNKG3RHvUa2WQPYG9RTZkSnoNkUojVrK5TJj+RlyZ65M9c35vBsM/0JXkLFcWd2UTuP5JhsJMARWilBfu6k5yWSKvM+sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8873

T24gMTguMDMuMjUgMDI6MDAsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gVGhlcmUgaXMgYSBwb3Rl
bnRpYWwgZGVhZGxvY2sgaWYgd2UgZG8gcmVwb3J0IHpvbmVzIGluIGFuIElPIGNvbnRleHQsIGRl
dGFpbGVkDQo+IGluIGJlbG93IGxvY2tkZXAgcmVwb3J0LiBXaGVuIG9uZSBwcm9jZXNzIGRvIGEg
cmVwb3J0IHpvbmVzIGFuZCBhbm90aGVyIHByb2Nlc3MNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZG9lcyBeDQo+IGZyZWV6ZXMgdGhlIGJsb2NrIGRldmljZSwgdGhl
IHJlcG9ydCB6b25lcyBzaWRlIGNhbm5vdCBhbGxvY2F0ZSBhIHRhZyBiZWNhdXNlDQo+IHRoZSBm
cmVlemUgaXMgYWxyZWFkeSBzdGFydGVkLiBUaGlzIGNhbiB0aHVzIHJlc3VsdCBpbiBuZXcgYmxv
Y2sgZ3JvdXAgY3JlYXRpb24NCj4gdG8gaGFuZyBmb3JldmVyLCBibG9ja2luZyB0aGUgd3JpdGUg
cGF0aC4NCj4gDQoNCg0KDQo+ICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2
LzB4N2UNCj4gICBSSVA6IDAwMzM6MHg3ZjQzNjcxMmI2OGINCj4gICBDb2RlOiA3MyAwMSBjMyA0
OCA4YiAwZCA4ZCBhNyAwYyAwMCBmNyBkOCA2NCA4OSAwMSA0OCA4MyBjOCBmZiBjMyA2NiAyZSAw
ZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCA5MCBmMyAwZiAxZSBmYSBiOCBiMCAwMCAwMCAwMCAwZiAw
NSA8NDg+IDNkIDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IDhiIDBkIDVkIGE3IDBjIDAwIGY3IGQ4
IDY0IDg5IDAxIDQ4DQoNClRoZSBjb2RlIGxpbmUgaXNuJ3QgcmVhbGx5IG5lY2Vzc2FyeSBmb3Ig
dGhlIGJ1ZyByZXBvcnQgYW5kIG92ZXJseSBsb25nLCANCnNvIEkgdGhpbmsgeW91IGNhbiBqdXN0
IGRlbGV0ZSBpdC4NCk90aGVyIHRoYW4gdGhhdCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

