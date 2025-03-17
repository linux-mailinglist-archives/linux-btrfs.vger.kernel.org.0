Return-Path: <linux-btrfs+bounces-12322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F2A64396
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB903A9DB3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052F84D34;
	Mon, 17 Mar 2025 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jllPBX5s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dpyWQuWZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335926ADD
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196520; cv=fail; b=lRHJ5V+OPQ9rWFI5cLopw5VrjwV1FZjUyr54PAHUbBfzUhBTPavoY+Q7Zv7PMPPvOVU+P1eEUSBkVhrILICLzyoy9uX+jEj+8WTJeYyLjTx0XjJz4KnzJ/OHIY4vypBhMon0EH0xwuFKgXn7m955Sh8R+Ft/jtyLCVmK/x22pRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196520; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lws9zOBzra2t85+QJ28lscgCvClqGKc5uPcMzVLJFbpi3Nb4nJddAwSyNUe51XGJSWR+bjhR2BrudAscSd1GWfmYiTgBFUcp6q2DUk+tBZWNQly9JYWZyliehCkrDHMnmfgSRdjEeo5jZv6WRSrkMep29/Mws7spXTQEOcNrHss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jllPBX5s; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dpyWQuWZ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742196517; x=1773732517;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=jllPBX5sO/XX9zdYxauYEbHe6azaS2vSEitIPFvRIFrrryw2nF+vSqq8
   xjuuKLmEVxkz8TT63aLS6DVTArRGd6YVdrcn3W3HSenNziM878DcVIClY
   wG1vTmNizFwB9bPeC0wUwkLp6dRADNH5oiHgRrwqSXDwR2N1nhNkIJyrE
   heR30FQKxrb5NF1HvtYcG+yMyMQf9NkDBnDnwikg3nK+C2KA4lBV+BaBq
   xxJhmrNKYWFIGGtAEdK9iVeVrdNVE3HYjWzUbf85zinxcGXPeaL4wDE+O
   UzjQsdMP00hoRCuWLYnuicfoFeS5AImiU2abHWi1Qbc+fJ0wBWSnUTBgl
   A==;
X-CSE-ConnectionGUID: QymUJFydS3+deQaUK3PFBA==
X-CSE-MsgGUID: jaDKNTBnRja2MRGj+r/8Tw==
X-IronPort-AV: E=Sophos;i="6.14,253,1736784000"; 
   d="scan'208";a="51402754"
Received: from mail-northcentralusazlp17012050.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.50])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2025 15:27:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpPZ0fR5M43gtOaEwJX8EUUr/g7Pjby9+ICaeNJmwGFzZyLB1YtZW5giYwlX//ZfEyDoEn+tJHRu9k9ubcvgtmHSXYmreSeiBell5VvkP6oo7BMovx63QROkqtHBCHzEpODWopo+BcPtFO9CS/xMozXfAfITqxCu5lHpyKmFtxCUWceZM7E5DR4gkhYlJHY9PcTpttRL05hu7pOP7nBYDEG5PIRHLxqnXuyCJM+UOijfAfAd7Vn4DCXwQkHCse8H05DqJemzAyVrB6MFE3oA5YEYvB9HqoJQgrCjv2jvCC+0/+UwgyoTFSU1ipAvUxxHZpV1bB1kZ0j89/pQquSVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=D6J2hrPIsRhzEz3v3NQsLkPiohUG6KAn1lyUNt33UnJfi42LvC9Htb6RxVuA1wMaeugrJ5w/8IQ4GN1+JimOAa7WXESW+JsV3lWDc2dJKcdOw3+CYAXS4/OYN99e5/1BwPtsDpxpnuy+Sc5tEJkzdlMIWcY9FvL42F1M7kJQolL2OkW6tlp+uWAqAU8ccOvU4Ttm+eRCfXQypK9gnM47hZh2cy/XVtdhCmXFIXCQS52GqXO8zfOnAHCjgf2+JFk4ZPIELWuN3N+Fdyd7Vz+dne2r+O+mo+ZKoER3WkmUaSo7A1n5XCO73DsPTRyyij7sXWHS1MRcy1hC9Vt8Hp3JWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dpyWQuWZPWRK+iBm7pnv9lSEn91rLJCgv9P+gj/6hct2bH3O6EpmRUha8tm+esFPaCHPqnJCfCphVcQZ/kQ5DLZivc2B8l8XekC0Id56pK7Xh6chP2zPxDXvBw3D9rp+4qESthZtBvt7E61FAzujmebq4q9NJXx2L07b3TLsEpE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN6PR04MB9429.namprd04.prod.outlook.com (2603:10b6:208:4ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:27:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:27:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: move block perfect compression out of experimental
 features
Thread-Topic: [PATCH] btrfs: move block perfect compression out of
 experimental features
Thread-Index: AQHblYdB7b7jTFlhzEW9tSPAuXmybLN28QQA
Date: Mon, 17 Mar 2025 07:27:28 +0000
Message-ID: <f90f53e0-3619-4265-aa62-1049c62e7b1d@wdc.com>
References:
 <d79b3627f9b2aed116c930bad3048da3aabcb2bd.1742028548.git.wqu@suse.com>
In-Reply-To:
 <d79b3627f9b2aed116c930bad3048da3aabcb2bd.1742028548.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN6PR04MB9429:EE_
x-ms-office365-filtering-correlation-id: ca0f6fcf-8c50-4d0e-d278-08dd65252c16
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TndzdlBHZzdEelFzRFhMQTExV0dRL1JBdTYzeFBBd0RRL0ZvZkVOd3BJQjBG?=
 =?utf-8?B?WFVPK1lHUFlFR0xIaEpsdzcvdlpIL0tBQWV5dzkxZjhOZ05YRTBnUmZQbGNH?=
 =?utf-8?B?Rm5RS1Z6YUNCcjNzMEhCWTJHelR5Rnp6b2VkdVFVOThQVFltN1ZJVExKUWtP?=
 =?utf-8?B?M1F0TDVPL0Y3cFlla20wZk5mZU9wZXUrbHFWRUpkaG91a0NZRGFLa1ltYXpi?=
 =?utf-8?B?ZTgrRTFyNC85MGlNVnZJbEhqcEtTNFE1aitJNVRSZnRRTHgzR255ODhRdHdR?=
 =?utf-8?B?OFh5RXo3d1ZhWkhBWElIT3hqSWo5Q0JUbEQrZHpLRVFZeURVQVh4YVd3Mjgv?=
 =?utf-8?B?QThoNlY3VUZXQU90N0N6bGFQekMvZklUNFMxakZyVDRDbTRucE5RQUlMSHEv?=
 =?utf-8?B?bXpoemFLWjhQTGdhazI1R0NMVjYwYmJlVlBiKzlqenU0aS9LWXViaFNGOWpz?=
 =?utf-8?B?bkt5Yks5Q3pFR2JKTXlpNVhIK2NPa3VPSlZ6d3REa1FjWjlDYmU4WmIzWStr?=
 =?utf-8?B?akZobWJpd1NjVjlISmRMM1E4Q3hFbUx3YjhVSytxSC9ZS0F2QXdybCtUTGQz?=
 =?utf-8?B?M1FwQVVoNjR5L2tTd2FEby9nNlNlWXh5SUwzOE5PR3Nab2syeDhJL0J5SjhQ?=
 =?utf-8?B?MUs1MU5IZjhmTWw4TEJtK1VFRGp0SlNIaFJoL3dRVjhJenh0YUVZcnJFS2Rk?=
 =?utf-8?B?cGZMS3JWRDVtQmM5aFlvV1JTVStSRUxPaklIUGF6ckR2QnFIZHUvMG84NjRT?=
 =?utf-8?B?eUNTdmhGRzhwdE1LY3JBQW5sSUZ6L2lxb2x3VEcxN3RDejFMZ29KK0FZK2dR?=
 =?utf-8?B?cVFSN0dubVErNHdkZTdCVC9KdC9hd3Nod3A5RGVxUyszTXVwaWpZazgwQm1Q?=
 =?utf-8?B?YVo3aU43YXFmVUNxcUUwZVUyYnZkbWRIbEpISjV6M0VMTTBUOFhZSmszOU9B?=
 =?utf-8?B?Vkhsc1N5MERkQm4zK2d3SERWSEZHMWdTSDhUdHNreVNGVWx5ZFdQWWo3aGJx?=
 =?utf-8?B?ODhydHBmaGpaK0xWY3N3Mlk2L1VkbGhMMFdqMjR6Q0RiMU1IMTFUazFlc1g4?=
 =?utf-8?B?dSsvSzdiT3ErTTExdTFyenRzVmlVYlJCMWNhc1FkSkFITlJna0RTZDIrbERW?=
 =?utf-8?B?MDJaWHVwOWJHTkM3TzhmRzMxcGFJQU1FR21Ndi9qMnBLWTIvcVE2WG9Mc2Jk?=
 =?utf-8?B?UHhCQklMYXlqWVVWeldWTFBYR0RPUjFuZGhMeDd2a1Z0T2FpSUk4Mzg1dFV6?=
 =?utf-8?B?MzMrT2NRbkxWTG1aTTUxaG4zSFRVc0hQZ0lsWG1XRDZueGNpU0lPK2JoQlBD?=
 =?utf-8?B?TkY2N09oTkpNcHVoZkRxdkZELzhjRVRFc3JhUm1KUURkblpPYk5OQStPSDFQ?=
 =?utf-8?B?VnZpcU81SVYrVVo1UXpNSnMyRklqK0s4RWY5MlR5dDJWMFg2N3daNkFsdmJ3?=
 =?utf-8?B?U054SGZabGlHSlU3WGllRFdnYTZ2RVdYcFAxUk1vWENsWDZzSDd5ZUZFQWdM?=
 =?utf-8?B?cDFoRGxCMWw2M3BuTzE5cVZMZnFvWW9mZnlIelRHdUxkengvWDJaVTVXVWxZ?=
 =?utf-8?B?T0d1RjlQTE45K2tESCtxMUZqSERaVlhEbTNRN1FRbFg3emtTaE5jZlUvamsz?=
 =?utf-8?B?bzM2dEk5VVVQMityT3lzbVlNSlV1OXlrNXVUMkZwRXQ1dHRTb1RNRUg0WEdY?=
 =?utf-8?B?UGhwazdoUWJMVVIzWGVXbHNPU2k4MGQ0V3dIanNLaHNYQlFmOThzN3lyL1ZE?=
 =?utf-8?B?bE9vKzMrVVBtSjY1RjlhV1I4ZU1EUVVXZ0lCTUR4VUJrbFZnelRVQlkvWmVS?=
 =?utf-8?B?ekVHazFxcUY1TXlaaFVhQWk1cFhwbWNLQmcvbUlyZTR2U0V3V21ETzVFQWFi?=
 =?utf-8?B?QmtxQU9LdVp0WXVSRi93eHM1NEV5QmdFbHgrNDB5YWIxUmdEZ29WRDQ2TXZy?=
 =?utf-8?Q?ADRMspey6U8DIoUByYF92fiBMSkMWKf9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SE1NWER2N2hvRTBLRlByRWEvUlRiaCtHcjE1c2lRSHk4YWhnUTI2bmxTa1Vs?=
 =?utf-8?B?aTZsWVJNK2s5SXdMeldOWVFFem5GQlJJaUdmcm11Unl3a3BDd2RQQ29vUlR3?=
 =?utf-8?B?bWMySXRGUlZEcFErNTZZbEJCa0EvcSs0SWs0RVdCMm0zVlZUZ2c1Q0pmOVRZ?=
 =?utf-8?B?dHByRHltSzNockZ5VGFmblN4T2UyV1NzREo1RUdUN05vdkFCSnBnN2E0cjVm?=
 =?utf-8?B?a3F1UVYzaDZkemMrNTRydHBrM1dFdUtVYytIVTZXWGhxTWdsMzh0MjFhQlBz?=
 =?utf-8?B?QU9vb2szTmY1bGMrV0h0UlpkeEpHQ21YRnVISlVQeVNmSkVSbnlYRSs1VlBH?=
 =?utf-8?B?ZUpkc0xBNWJoa3dqY2ROWjcxNnFyQXlDZTM1MzI1Wkg1RzFTTDl1M2VQM21i?=
 =?utf-8?B?UXdlUmVkR3ZqTzcvV3lyTkFiNFUyNVltODhxYS9xUUpJQjZ4KzdvZDlzcGlq?=
 =?utf-8?B?ZlRNcFBYaXB3OGdldmtibkx1L1dWWXpQR2xkazBNSVdyYktscU8yeHFiZGE4?=
 =?utf-8?B?ZDVIMU91d3RVckdzbjQzWG45aDhsZXk1c3JVRmxnbW4rcE83V1ZXeERYaUhE?=
 =?utf-8?B?NWtISDV3QlhuNkNBdVBEM05TTGgrdUlPTlVoOEZueHYwOGE4R2dONG5FQzRk?=
 =?utf-8?B?YkpFWHpKYUdTbitEZmZIdGxrWXlmMm5sREF0bXRvWXRmS1BPdHY2MENob1lO?=
 =?utf-8?B?T0Vqd0NmVHljQ0swdGVmYkZtUHpYcDhOeDhuMU1vQmMwMUZzVFFMQlBEVm9i?=
 =?utf-8?B?T21HNzVYSE54VkhTblFvbzFFam9UVFYyRmhabStySWF3UURVWU1SWmM3enR1?=
 =?utf-8?B?MHh2cVE1SFV1NnlDa3JPL1RwL0ttTlJ2REdtbVZFWEFGVDhDRE1RaG9jeEM4?=
 =?utf-8?B?MEFzbXhSa3lBTW5wTzVlWGlLUXFjdDJaZlNEaFN2U0YxN1NvYkQraVhTd1lN?=
 =?utf-8?B?QjlqMGR5NFlsVmJxUDNJMkh6bFVqc3hQemloSFk0cHM3VVp0UGZTNk04UG1H?=
 =?utf-8?B?RXpqVXBUeW1ETTdSbW53YjdtcUs4dkVVR1lkK0lkbkc5TG5XdE5wd0oxdmEy?=
 =?utf-8?B?Y3JZUzhoQ2JxVG9vSE9sWmpsNWZOR2lZeVpidVVkVGJBU1ExMEJ1bVhWdVNN?=
 =?utf-8?B?NHBEZW44Mjk3dFpjM2VXcFpmR3V6VEpGeXBKaTh4ZmMwUWJ3MktIRzg2MXd5?=
 =?utf-8?B?TFgzVUliVWJJOCtoL3JVYnVBUVZRaGNFamZDTTRSODRQZUJsU0ZmaTUxVC9o?=
 =?utf-8?B?SnA3MlFtbWFqSm0zemhCcmgxd3Y1RlRwenRWY0h1TGFCSjd3SlNIOHhkZDI0?=
 =?utf-8?B?M3lUMTF2TnZlUjg5VEpkdzRxUERrMjJRMGROZGZVN3lhS3NhQzhNRHREWmYv?=
 =?utf-8?B?bXRKNDhUMmhuSXlDY3NtdWpKMEdBcjU3aDVUV1B6aUZrR3NPSUZZNkZBb1lZ?=
 =?utf-8?B?ejJqNmdmL2hSWWVCYi9ydlFvamhDOHN1cFpWVm44UElWbThKd0JDMkxjNUVj?=
 =?utf-8?B?bWpCanR1MHhvMGFrSXNkc1ZBUTZrTEFlSGZoQWRPc25GUGZBdHhxNkkrcXNm?=
 =?utf-8?B?UXFsc0U0eFFUeDV4alp0WTBicmp0bTBDa1RWV0FOOHVXOWtuNEw3Y3pBSm1T?=
 =?utf-8?B?dDE1VHFuakY3ZmFYUzlGTy9BdTkxaTdmR3lKU2ZzNDRzRDBMWkgwaGgvclVI?=
 =?utf-8?B?UTlnNlhSVFlNNVNuZ2IwSFBnNUN6cElLTWdEVUVOZURqSkJJZjlSL2lSenZ0?=
 =?utf-8?B?allGZyt2Mm1oYVNteUczRlIvY3REMExGYVFiaWhGZlJmUzdrNklSdk8zakM5?=
 =?utf-8?B?L2tVTFFEWHBuSkdCQ1pEWFFzMUVLd1NsWDBEbGdyUHFlZGRhTFhhNlBGQnVw?=
 =?utf-8?B?dkNQR1dzeHkwQmgzQk1zUGowWFBwaEovV0ZoQUtETHNXajBBa3JiTWQyY1hO?=
 =?utf-8?B?ZHJyTVNPMEFISTkrbWtOM01yU21VYXVoTEk2Z2dXTFhLbjhKSEdON0hZVStx?=
 =?utf-8?B?Y1lDdnBPV3FuVU1kcEtBdVlHVUFSc0gzanJ3d1R2SjUrcVUwalg3c0UzME1G?=
 =?utf-8?B?emVSRXFzK1JKcXMyQS91QVVITjlpckFLN2pBRkFxdmpxcFZYNXdqMGtqUWlU?=
 =?utf-8?B?UllqR2JFMTdIQmhKL3dySUlPWllwMG13YkVRSEgvYUxVOFNrdDRqek5Odzh0?=
 =?utf-8?B?TDNuVXBzeDBDY2wvVks2YzVxLytPZzdzTkNHVWR1TFBvWld6SzhUVFNjSjFN?=
 =?utf-8?B?SnVsOUVkbko1QmFOeXMxUjlJYWR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E6FDE9D5997654EA7577F5674442E3A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JsCGCYGWtuKamSK9vgpgZvKgpNf6Dj1qAgSUnDKYAcjUK+doyFH7HeTE9g6vjNT4oCkwGXVvCjOBM4qF7vfiryA72Z3ETjDe0HclFjQGhXpWIs9is5BnTaKTEGYmhI8Lo2YnZL7ymYb07RvACJPW8oT66l4Hbnou46XhH4InoNn8keKCXa5yiuwIIl45I6vfXq6+/F/DgWr0xlO7zbbopW1Z2BoZ04tlEARxRU1LK/7uLs093meHC/qevooxmLpvVNSLjYBX0JXkkjRFIUNOBpH/rv5FD/19afRo5Kl/Fd+SgMUsmcmXO9Dn142WXSIT1FX9Y8Dguzs+yV9hfMQSeapZw9y3CERpFn9a1KF3rBtVZkR4RBE+Ce2nqCNC4ESsbLr/brBvmOV9NFFXE0jVV79al9YsRI4jqRPBZKj8d5gbkEn2PzXyXows1akSjEinxW/wdpgkWpef9wz/l3Uxg96Skd0zu8Md7HWa3yjVSdfXBk5XTWID5yNWFbq2tUB479tGmxpbgzZULdCo7mHMQwOpdmQMwvDia84jUoO96Z3bQVBzWuCWH7auOxIYt5dHEEYGErV0u9Fvk6c26gIPjHl/jdxEdY1KFTWCiLnC4Fzt6vvhx/W/sUPoxK5Pm16+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0f6fcf-8c50-4d0e-d278-08dd65252c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 07:27:28.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9WghWhJ7uJ1njr2nrlBOIP6RrHL81ec2shjK6ZQ/Xglopo7NFaH2CuzErP3Pl9iCKL4ssnzod/PbbU9hD6cchrGUpbpftADlgy3IqDSFBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9429

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

