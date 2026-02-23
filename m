Return-Path: <linux-btrfs+bounces-21844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAWNOANynGmcGAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21844-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:28:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62BE178B59
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBA483030D0E
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCCC29BD9A;
	Mon, 23 Feb 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rp+QRm7t";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VvotfHzg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED029ACF7
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860476; cv=fail; b=E+OOBW/w6jsx3l1cdEHLzMj5SNHcMcZ5/FZ1sLtNwZzBgtaJCJYxmfWGlZwUoGs5W11kUNkWnr3rRq3JD/bQ64pvuE25Fz6iaAKcztH5Mx/uge5w//ueEDydYM93tJ4vxhiLl5rBek3OTZwh4sH35j0APB6PZQIfFctU6deiJyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860476; c=relaxed/simple;
	bh=7H/N2G5irTuROVBbba08X7EFrseyqnD5dttrUH1NNK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ndo+/84S/5c5DGnvHxHoiCSo8uAZstIGk8+e8qp8kjtn6hFk/X0O3sZBVjvuWnW+L0nGmwKzaddrMCmuymXGAG+tTIrtG9Pc2nxbcyPAg3cl7XfBzMhsVldKo0JNeQjOYEpFZFPga3S0qz4B88KOnOqHxF59AHR3006X9/fF1WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Rp+QRm7t; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VvotfHzg; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771860472; x=1803396472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7H/N2G5irTuROVBbba08X7EFrseyqnD5dttrUH1NNK4=;
  b=Rp+QRm7t2vW8SpCOxysJW+VBejJFxym41uM6mhumJ94oOn+63sQNTE9O
   /Vpn2XqDkEODrBShuHhlstZsSOF6EHhDzDV4jq3kZ6IbQz/xfPJLkOjzt
   ZmjiGP3B0A6gPN6Fp3HaR+ojKOgQ8plOn1O+W72WOBK6HRUA0vlM8APyL
   n43CcK5j0nDUIW+sJ/8GpeZi0yZe7bYet9Jphpa7hpV3zj7u1YmusNkqx
   z5BLmRBSXC250iJffbuy2CQb7R0bZcp1iIe6CpfnMS155CCx7bVeyYqDy
   +saZW7I8OyNQ+HWW07ETUaydgCNfz8SKHk6GvENre8FNIVcwceXFLCrsw
   w==;
X-CSE-ConnectionGUID: 4aAEY2kcSx2uvQmNWytv7w==
X-CSE-MsgGUID: 0fuVT4VvTN2O+2oab5pjow==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="140868141"
Received: from mail-westus2azon11012061.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.61])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2026 23:27:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5A2N/27RrICUk1KQjquTMHugNQQ0wYRNYWGoT9+Sp2OMoTViuiNgehXeKtDvmeMtl3b9nOeOvzW042lpIfsQJ8v8CTu8Maij49iHd3p9S+hnJ36fcUZdh2xI9rZ2amTwwqsCQrzoQA0G+9qhHWi97nSxTbZAP6GAVeaAejMnr/hLaWPBmBYN+O86DSLSUi7Ue3908bKxizGx8S6tXYK5177XE7lQN3fuqFP/X3iIocteaom0ChOK8+ks7mMQOz3shBfPr8fpHR5yZMxLKMUZqBK7N8vYC5HL7XxaWR+Zq9AbeW7E3MWnVCkJw9cgTS1MFMyvrDsTPMio50RkEQWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H/N2G5irTuROVBbba08X7EFrseyqnD5dttrUH1NNK4=;
 b=D9t9B2acQRCBgYkC4nw8Fw1A70fYRmz0ORql/QFEI5QiItVSeMpHYUp50vdauJGLEKK4LPIndxduHsXEnk2vlBm2yE0B5X7fhDdKfEBEKafFC+kluMpiYF6omQS3HmqtZvC6PK/WBegcLG1Fgctrhl7Xyxhd0Q5tH7TLlRLeiF933fiIkLzlpe4aWPwLE/cClKo2YTrC2eo6l+uJFycjfoBFnySSn/I6SHz03q7TWmK4XDGZz7S/oHWdolemcTj27mrwclhCgJYV7GiW3ckad0V/seh146/C68j/MxTss4wr9YG2UsFM+BLg0loyqIxz6d+c9anbmi9lcFdMuL5/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H/N2G5irTuROVBbba08X7EFrseyqnD5dttrUH1NNK4=;
 b=VvotfHzgTsK8D7Znfy08iXk+k1lduGiNf9LmhxZF4ClC/yWSwIkMMV7nQVtIYF3R7Q4qX/3l83y7l8b0emVwbd4O/uO98d0OHriFkdGpP8mXrY2IFz/xZPDjG01Rs3p5HC67l0kI89AkEbexCHkRCWsqR7qv7NI/5LmlJzlVh2c=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7528.namprd04.prod.outlook.com (2603:10b6:510:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 15:27:48 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Mon, 23 Feb 2026
 15:27:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: catch aborted trans in
 btrfs_zoned_reserve_data_reloc_bg
Thread-Topic: [PATCH] btrfs: zoned: catch aborted trans in
 btrfs_zoned_reserve_data_reloc_bg
Thread-Index: AQHcpNIUrSAp5TPml0e1T09sJw4807WQZF2AgAAD64A=
Date: Mon, 23 Feb 2026 15:27:48 +0000
Message-ID: <8727ee44-8eab-4fcd-8b6d-2bc85271772a@wdc.com>
References: <20260223143820.89931-1-johannes.thumshirn@wdc.com>
 <CAL3q7H5fg12yM+RUsDsKbEsr7-Fdk_Fs2gr6=qG-E1uR0YU-Kw@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5fg12yM+RUsDsKbEsr7-Fdk_Fs2gr6=qG-E1uR0YU-Kw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7528:EE_
x-ms-office365-filtering-correlation-id: 33eed1f5-64e9-46a4-abf0-08de72f019b6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|19092799006|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXA3MVp5MGtSSmtnOHpTbkVtZndYZW9pYTZkSHBRMEtlbzJrZDRMcmxPWEdT?=
 =?utf-8?B?L3BxL2tJN2MyL0RXVnFOMGV1ZC9penZWdnhnTmtKdWN0TU8vVEpvdGs2aEZ5?=
 =?utf-8?B?YWFlZFJjWnpRUlgyck9YYkc2R2NPejZZTElyalBkSUY3YVZhUDNoZjVIdEMr?=
 =?utf-8?B?bWYwRWMzSzh6cWhpWnFjNHdsamU4UUg2dUhaeExxN0loWHhPNXVYNy8wbkda?=
 =?utf-8?B?S2grdFR5ditTaCtvdkpTUUo0aFBxa3lzQ0dlVmlJZitCeUduVUorbkRtK1RR?=
 =?utf-8?B?dmk5NzhkM29RMlVzN1JpQ3RZSVV5dUZxSDB2R3hDOGR1bU5HU2VMdEloWDA2?=
 =?utf-8?B?QW5ZL1ZXMC80djlTclRSZjRBWG9sVVd6eXlkQk1qd1pGN2o5QmtmRVA0OU5R?=
 =?utf-8?B?R3p5dlBCd2VpMlJkdUpwN3NtdVB1UHlDRC9vWlpweEtzM0RqUWhmTm1md1dZ?=
 =?utf-8?B?a1pmTHVCQ1hrUWhUczFCeGtQTHB2NlNvOFA1Q2pCWGgvZ0VJdUsyWDRkVDZl?=
 =?utf-8?B?cFljWXVVbUpYeG5OOHdkVXIrZFdlK3czL2pCcFJNbzE5Ym05eDJnSHVnaEN6?=
 =?utf-8?B?VXNqRG9mdVloR0N3Mm5NS1BNeTN4VGZUZFdKUGZBM2thTGQrOFN6bGlGcE41?=
 =?utf-8?B?eVNhamxZU1FNOU80RXFpcyt3VzJiWnMvNEdjRlh2bGFMVzFVeHRneEJKSEJJ?=
 =?utf-8?B?dG5YZUlZd1docVhYVzJ4TXY0Q1FGc013UE1rbGpCQjc2V3VvUTZrZ0F3K3ox?=
 =?utf-8?B?MjRyR3p1YmpxOURRbXNHVTVNV0V0dVljNXB4eXZXSityd1ozSDM0SFVFNFJq?=
 =?utf-8?B?UE1Md3FTcDZUSFhWd3dKZnI0bUdQRXBUdmRicjE4YndSTlA5V0EwZXBKTGNv?=
 =?utf-8?B?ekprNzNJSEVCZnh2emRHOVlzZFZ6SzZsR3RFbHZJMXlIZU0weUlzbXhmRjdN?=
 =?utf-8?B?eEM2V0dwREdvL1pEMXdGWjNldVZxZmxZeXRqNkU1ZzNHNm5ZSnNtMHU4Nzkv?=
 =?utf-8?B?aVJ5MFh0TkxBR09XMXdxK2U2Z203Rm5Gc21iM2QveUFncjVQYzBZUFdWMFdo?=
 =?utf-8?B?SlJHMmh4S0RzWnRkWVZkazcwUm1EdDNqWVc0VUQ1L3VIWURnMkQ1dkRNLzNH?=
 =?utf-8?B?RFAwaVl0RHdjRnIwOGlBZWs4aHVqZWFycjFmOVNaVGhQRVloK2hPYXYwMmFO?=
 =?utf-8?B?RXQ2TlBIREJVNVlwRGtlMnVnVHIxMnppVEFHaFd1Z2FUakYrcG5sb3MvNnBY?=
 =?utf-8?B?ZGlEV200alpMVlVKY20wSkNxVkQ3aWxPYXFsSTFUbWpRY2RxWVJ0QzFzbm1t?=
 =?utf-8?B?WTV2aGh6TEN2SEp1eisvR3lxbzZQMitJZ2ZjOUNIZ3BMelVzTDkrcnFEOG1r?=
 =?utf-8?B?ZGxnMGNnQnNESGh3ZllicVlvSjZEWlR4N2NSb3RySTBUVEIvbUhMdVlMRXBZ?=
 =?utf-8?B?MlR3eVB2Q1RVcm9OQWJ4cnZGWlh3VzQvc2dhbi9iMG8zdC8rYUV2Ykg2M2RM?=
 =?utf-8?B?amFhYmZvSWNQQTFpT3ZaS3Ixdmkwb1NNa09JOEx6cXRPQ29jUS9CRFNzY0k3?=
 =?utf-8?B?TUVuc2pWTmJjZThBQ1J3VUtKZStwUkdlb0dzWHBKbVU5YVJrNGZDSVBucXpZ?=
 =?utf-8?B?THNRTTloalhyN0tuMlV2ZUw0cllCcWI1T0g3U0JGMEVVa09zT2xjYUlSUGd6?=
 =?utf-8?B?Y1M5eFJIUE8xVERWaStRV0dZR2NvbkdFcU5hRTRZVVpUVFIzZktsajRTV2FR?=
 =?utf-8?B?NWIvdXpzdm1Jd1VxNXlLc2F0L1A1cEpNZW84VVJ0YkRZbCtDdk1wbmhvYnNh?=
 =?utf-8?B?anVhU245WG1sQVhpZWM2RlptTzlWZUtGMU5LckdId092MXRrL1FUaE9DeDF2?=
 =?utf-8?B?bFBpQkY5N21yYkNMTmVmeG9LUU1jZVZKSG40QTBWMWJmSWNpb0ovcHhkTThR?=
 =?utf-8?B?dWtKN0phclBnSnNWOWJQc3RySkhpTThiZENXS0RzbXc1R0d5NkJTUXR1TDNO?=
 =?utf-8?B?M0kzYWkyYWJJalRYVTJueFdoNkNJLzlNMEQwclpMTE13UUd1OG90dVJyandD?=
 =?utf-8?B?UmlGaW4wa29BRmoxb1JzSmR0ZGkzSnA2Z2VUSnZwK2k1RGJCcWIzRWdMVTZh?=
 =?utf-8?Q?eZfs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(19092799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWlOWXdZQkErQ00wa3VKVVM4WUJqR2pVZlIzaW9Jb1JaWTgvYXp3YTA0dEQ5?=
 =?utf-8?B?WCswM1hxQm9Nc3B5MHdpWnJHSS9nWDBTTC95cUNwTjVtL0o5ajNNZUtHQXVJ?=
 =?utf-8?B?bVlmZmNQYlhJLzdwNUhWZCt1UWJYTHBpVUd6T0NyRmVLNW1iQnAwVjR6QXUv?=
 =?utf-8?B?MVUyNGtsa2xiNVd3cnVIalJBUkFhQU1GSEtadnlyaGVaWDBwcW41QUpmZzlO?=
 =?utf-8?B?am1KQ2wzYnpEc2xWVFBjUzlQZzA2OExBV2gwVEdSZG1PcXkycEVycUF5R2V3?=
 =?utf-8?B?UVVsaEVTekRuUklDaFNBdDVEK1VGTUhXRWhwOTNtcTMwb0p0eVlKNWpMUG5y?=
 =?utf-8?B?a0lDN1R1R2hTYW1ZTGRDbHNmd1p0TU1Yb3A4aUlUSFhGYzZLS0MrSzliQXE2?=
 =?utf-8?B?eTJPc0ZtckpXcGp5cG5iTkFnaGlRaThKZ2grc1BxYi9lTHZwSmhPNGd3TTJS?=
 =?utf-8?B?SEhpR2pBekhxZkJaSW4xR2xVYjhvdUlxNm44VnhrQWZtVXN4cDE0SCt6Sjkw?=
 =?utf-8?B?ejd3QjRPQTNzU0c4Z2FRQkRhVWpjNGpPRzZ6dDlKWHFoVS81VnRIV0tjaUVW?=
 =?utf-8?B?R3hYVWNuVll3ZnBGMm1NUEZKVUpDcDU5Wk8rWHo2ZGQxTnlYNVUzdks0NFNa?=
 =?utf-8?B?Q2NzbW1JTDFQUW1sdzBNSnBTR0RQbDBMcHVBMitzNVJ4Q0ZNWnFjUGR4QXE5?=
 =?utf-8?B?MGFTSlM3M3BVNEkyNzMyTEZQWkRJdWtNODVKQkFVOHdFVUd3T1ZhZHNLOEVO?=
 =?utf-8?B?dDd0YzhwSmtwM2J5Ym5HK0JIOG5YNTBUSzNMVW45cHdVTGxPdVg0N2JFaDJB?=
 =?utf-8?B?MzdhRVRsVkVxbkswTTRSUDdDZjRoL0dnWHBUL3R4ZzBCa25Uc3NHQzUvUk1o?=
 =?utf-8?B?MTBwbWI0ekZ1N0xKTkRvd3JMMUdYWTlWOHZSTk1DYVNEVUpZaEJjOGJXZ3pM?=
 =?utf-8?B?WWJ2NnpjU1VlRitpL2hLQ2xqMnpSbGwvZGQ0eFpZNHVpU3kvUGJEOTlQUlM4?=
 =?utf-8?B?ajhlZUZabjM0ekpuQlZsc1hrUjdadjl2NEJveW5ZRi9JZFNxZnF2Tm1BU21x?=
 =?utf-8?B?eUplWGxwMlZaaTFsNkJvVU9iTXRaSFFpWG81ejNLR3FWY3VmOERTR05oNUgy?=
 =?utf-8?B?NkcrZlNJSDBtNHlXY3Z6YmY0N0hQVEtXYzBxeGlNSW92c1hReGk3cmd2bkpN?=
 =?utf-8?B?TFVHMm1WNWNFL3Y5bzI0RHgramlWanVqOVdDZ0thR05jaStKUnhaeWpKdGhZ?=
 =?utf-8?B?SjRiTDZ6c29SMHdXb0lLOWRiQ3N5YytMUzRBTWFwa3VHS0RkNGFzMmJQQXZE?=
 =?utf-8?B?clZJcG90dUZna3lvWFpBZ1JzMEJaQjJwQjdIZDVWNEhqNDVFQ0dBWHNEc2U4?=
 =?utf-8?B?R0NVTWhaYUEwRzJ6b0lNdDJCelpZa25HREhoNE04UmxGN2RRMmM5a3RtaVRs?=
 =?utf-8?B?UTZ1S3llMFNoNmcvd2dUYm5LbXVMbmY1amZTMk1NTFI5SWx0dVlhamliOU54?=
 =?utf-8?B?aDJnbDZhSEdhbnZvU1FxVkFZZ0dWVzVnSGZRcG12elByL2drcmhLdmViNWNJ?=
 =?utf-8?B?RE5RSGZZQUs4WW54RXBqMGhKZ1pmdnhQYnFRc3RjOEpLK3ZYNGgydDFFUU9S?=
 =?utf-8?B?UVcyVHRwQ2R3NzU3SDhXVkNxVUhSNC9wUHV6clpZYUlzanNuSE85SmY1Uitt?=
 =?utf-8?B?OFZGVWJONEduZXBHZDhmdEpjSC9uODV6NWpxem1MUDdjUVVsZ1MyaHNuQUo2?=
 =?utf-8?B?end5ZjZUVzNhZVYyV0JQc1F3WFFWOExCV0hXRUdHMWtma3QwQmJ4ZEd6OEdh?=
 =?utf-8?B?eko3T3A4WEE2MW11cGVIUDYrUGE3WVFTOWkvMWUrVVdJQnNLajNGNWx5UmR3?=
 =?utf-8?B?TUZtYVN3QmZzMC9oU1hXWmlsZTJhRDlWc3RDdW9GaWRPRk5OclJEOW5MQW9n?=
 =?utf-8?B?dk9Tb0d6YUdkYkVTS3M3L24vbmM4aWlCZGY3MXRndExUL0VIeWFOem5IaFZD?=
 =?utf-8?B?U292dFd4RGdoQWZtdk5jSDBlc1lIT0I3STdhR3ZIUFhuRXJQeCtDcHpHTzBK?=
 =?utf-8?B?aWNuYVduY3dISEI1YWpvSCtURk8wMEZZREhYYWpxMnQ1K0xkc2pjUklmZ3VV?=
 =?utf-8?B?aTN4ZU5QSHUyeGRFalhXN3BuTUFkR1B2elN0c1RsQWdLdFZrWTdQTDIvcWMw?=
 =?utf-8?B?NzFCZ0hzVEh1V25RU3Y4Y2ZUTnlvVXQwZmwxWHIxQjlKM01WVm1PajhNWFRv?=
 =?utf-8?B?RGFla2twdWw2dHBxK2czczNjNHBkNkR1cXowS2xheXpVNHE5K1RIWFlkZkRY?=
 =?utf-8?B?L3RaY3dDWDluOXEyaWFORmM0N2Q0czVhbHUzTEM0cEZtcVNVU21iemRvMDlJ?=
 =?utf-8?Q?kr/qaAYeGPqyo3byv/KMNoM6Rhyhp0JnQn95aYb5eK1KE?=
x-ms-exchange-antispam-messagedata-1: Oy9/21yldiDYqhoci/jmVyB6oxQtBV174XU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D49547C5AB72C742A27F0A3C3ED85406@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZKq8JNnPa+uL6Nx7vdF75TxmGAGOY4yq/VsaT0RJQHiK3Jkml3gAzOTNcPHc/OAmdsHIUJxF36Xi8r0XX9gMPlVnPUi3iyJ8tVGrGvAexJn7wBlI1/65yI8B6bVUN52SVIwTq2SwVApnplVlQe/oxvrqd7uAH0wYBvgq7OJdnhp1nmm/LtxGtysVrihE47AFkyrnTBX67eddW023ElQ+wwTfcwpc1I9Pz8RijfHZcYgNt1sK1Z80zxJoOPOZNZynJOqIq9373jY7byJiG8IhWCyu5xWKRd1VQBPPUo7MsvMKkT326fGGHTAnos/aHLp5sG2ry7QZyn3xJb81sidmmuGuv9n2Eqzrmp5i9zxTiEeINc7Ws8224tpWY0bKpnpfXkLQEbbgX+P9ZXsTfkLLRykV5R10mt4Z+jxNlpisd9i7SMhjnRHnihvvrCW2+NS6ht9o5SRk3lWrD6R0ndhISaiMqKmGlYHKWb860tOujjWPUjnfhqXuUMCG9Ab9QCP2HdO49KCCMwSG5OzssCDZiHCMAt8SAkZNypkeCV9t/MVDk0x5/WJaNsMVc+5WBgOhlVDYqc7euaiUnua10QNZNQ74kvtEDfvkrk/bRGX6JjCGIRQRRAdfJd2TmU0dZSlm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33eed1f5-64e9-46a4-abf0-08de72f019b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 15:27:48.1290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWVpn562f50W1gnPJpwluV5Ed1RzITRr/HUSTOgqoECHojKhU1MbVGwA/EdHguymnmFvDatt1jaR7W5tVjxkJtWV6hPVMpGnoYBvwF9iJxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7528
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21844-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_MIXED(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim,wdc.com:mid,wdc.com:email,termbin.com:url]
X-Rspamd-Queue-Id: A62BE178B59
X-Rspamd-Action: no action

T24gMi8yMy8yNiA0OjE0IFBNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBPbiBNb24sIEZlYiAy
MywgMjAyNiBhdCAyOjM54oCvUE0gSm9oYW5uZXMgVGh1bXNoaXJuDQo+IDxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+PiBidHJmc196b25lZF9yZXNlcnZlX2RhdGFfcmVsb2Nf
YmcoKSBpcyBjYWxsZWQgb24gZWFjaCBtb3VudCBvZiBhIGZpbGUNCj4+IHN5c3RlbSBhbmQgYWxs
b2NhdGVzIGEgbmV3IGJsb2NrLWdyb3VwLCB0byBhc3NpZ24gaXQgdG8gYmUgdGhlIGRlZGljYXRl
ZA0KPj4gcmVsb2NhdGlvbiB0YXJnZXQsIGlmIG5vIHByZS1leGlzdGluZyB1c2FibGUgYmxvY2st
Z3JvdXAgZm9yIHRoaXMgdGFzayBpcw0KPj4gZm91bmQuDQo+Pg0KPj4gSWYgZm9yIHNvbWUgcmVh
c29uIHRoZSB0cmFuc2FjdGlvbiB3YXMgYWJvcnRlZCBkdXJpbmcgdGhlIGNhbGwgdG8NCj4+IGJ0
cmZzX2NodW5rX2FsbG9jKCkgYW5kIGJ0cmZzX2VuZF90cmFuc2FjdGlvbigpIGlzIGV4ZWN1dGVk
LCBhDQo+PiBOVUxMLXBvaW50ZXIgZGVyZWZlcmVuY2UgaGFwcGVucyBpbiBidHJmc19lbmRfdHJh
bnNhY3Rpb24oKS4NCj4gSG93IGRvZXMgdGhhdCBoYXBwZW4/DQo+IERvIHlvdSBoYXZlIHRoZSBz
dGFjayB0cmFjZT8NCj4NCj4gV2UgYXJlIHN1cHBvc2VkIHRvIGJlIGFibGUgdG8gY2FsbCBidHJm
c19lbmRfdHJhbnNhY3Rpb24oKSBldmVuIGlmIHRoZQ0KPiB0cmFuc2FjdGlvbiB3YXMgYWJvcnRl
ZC4NCj4gSW4gZmFjdCB3ZSBoYXZlIHRvLCBvdGhlcndpc2Ugd2UgbGVhayBtZW1vcnkuIFdlIGRv
IHRoaXMgZXZlcnl3aGVyZSBpbg0KPiB0aGUgY29kZSBiYXNlIGluIGZhY3QuDQo+DQpZZXAgSSBk
bywgaGVyZSdzIHRoZSBtb3N0IGltcG9ydGFudCBwYXJ0Og0KDQpbICA5NDQuNDQ4NzY1XSBCVUc6
IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDA3
M2MNClsgIDk0NC40NDkwNjBdICNQRjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVs
IG1vZGUNClsgIDk0NC40NDkyNzBdICNQRjogZXJyb3JfY29kZSgweDAwMDIpIC0gbm90LXByZXNl
bnQgcGFnZQ0KWyAgOTQ0LjQ0OTQ3Nl0gUEdEIDAgUDREIDANClsgIDk0NC40NDk1OTBdIE9vcHM6
IE9vcHM6IDAwMDIgWyMxXSBTTVAgTk9QVEkNClsgIDk0NC40NDk3NjJdIENQVTogMyBVSUQ6IDAg
UElEOiAxOTIzMyBDb21tOiBtb3VudCBUYWludGVkOiBHICAgICAgICBXICAgICAgICAgICA2LjE5
LjAtcmM4KyAjMzMwIFBSRUVNUFQobm9uZSkNClsgIDk0NC40NTAxNzRdIFRhaW50ZWQ6IFtXXT1X
QVJODQpbICA5NDQuNDUwMzAxXSBIYXJkd2FyZSBuYW1lOiBCb2NocyBCb2NocywgQklPUyBCb2No
cyAwMS8wMS8yMDExDQpbICA5NDQuNDUwNTM2XSBSSVA6IDAwMTA6X3Jhd19zcGluX2xvY2tfaXJx
c2F2ZSsweDIyLzB4NTANClsgIDk0NC40NTA3NTVdIENvZGU6IDkwIDkwIDkwIDkwIDkwIDkwIDkw
IDkwIGYzIDBmIDFlIGZhIDBmIDFmIDQ0IDAwIDAwIDU1IDUzIDQ4IDg5IGZiIDljIDVkIGZhIGJm
IDAxIDAwIDAwIDAwIGU4IDY1IDA3IDVkIGZmIDMxIGMwIGJhIDAxIDAwIDAwIDAwIDxmMD4gMGYg
YjEgMTMgNzUgMGEgNDggODkgZTggNWIgNWQgYzMgY2MgY2MgY2MgY2MgODkgYzYgNDggODkgZGYg
ZTgNClsgIDk0NC40NTE1MDVdIFJTUDogMDAxODpmZmZmYzkwMDBjNjE3Yzk4IEVGTEFHUzogMDAw
MTAwNDYNClsgIDk0NC40NTE3MjZdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAw
MDAwMDA3M2MgUkNYOiAwMDAwMDAwMDAwMDAwMDAyDQpbICA5NDQuNDUyMDIwXSBSRFg6IDAwMDAw
MDAwMDAwMDAwMDEgUlNJOiAwMDAwMDAwMDAwMDAwMDAzIFJESTogMDAwMDAwMDAwMDAwMDAwMQ0K
WyAgOTQ0LjQ1MjMxM10gUkJQOiAwMDAwMDAwMDAwMDAwMjA3IFIwODogZmZmZmZmZmY4MjIzYzcx
ZCBSMDk6IDAwMDAwMDAwMDAwMDA2MzUNClsgIDk0NC40NTI2MTJdIFIxMDogZmZmZjg4ODEwODU4
ODAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDMgUjEyOiAwMDAwMDAwMDAwMDAwMDAzDQpbICA5NDQu
NDUyOTEwXSBSMTM6IDAwMDAwMDAwMDAwMDA3M2MgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTog
ZmZmZjg4ODExNGRkNjAwMA0KWyAgOTQ0LjQ1MzIwOF0gRlM6ICAwMDAwN2YyOTkzNzQ1ODQwKDAw
MDApIEdTOmZmZmY4ODgyYjUwOGQwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KWyAg
OTQ0LjQ1MzUzNF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMw0KWyAgOTQ0LjQ1Mzc3N10gQ1IyOiAwMDAwMDAwMDAwMDAwNzNjIENSMzogMDAwMDAwMDEy
MWE4MjAwNiBDUjQ6IDAwMDAwMDAwMDA3NzBlYjANClsgIDk0NC40NTQwNzJdIFBLUlU6IDU1NTU1
NTU0DQpbICA5NDQuNDU0MTg3XSBDYWxsIFRyYWNlOg0KWyAgOTQ0LjQ1NDI5M10gIDxUQVNLPg0K
WyAgOTQ0LjQ1NDM4N10gIHRyeV90b193YWtlX3VwKzB4NWIvMHg2NDANClsgIDk0NC40NTQ1NTZd
ICBfX2J0cmZzX2VuZF90cmFuc2FjdGlvbisweDEzNy8weDIzMA0KWyAgOTQ0LjQ1NDc1NF0gIGJ0
cmZzX3pvbmVkX3Jlc2VydmVfZGF0YV9yZWxvY19iZysweDMwMC8weDNkMA0KWyAgOTQ0LjQ1NDk4
OV0gIG9wZW5fY3RyZWUrMHhlZGYvMHgxNjg4DQpbICA5NDQuNDU1MTQ2XSAgYnRyZnNfZ2V0X3Ry
ZWUuY29sZCsweGJmLzB4MjAwDQpbICA5NDQuNDU1MzI3XSAgdmZzX2dldF90cmVlKzB4MjEvMHhh
MA0KWyAgOTQ0LjQ1NTQ4MF0gIF9fZG9fc3lzX2ZzY29uZmlnKzB4NGM4LzB4NjkwDQpbICA5NDQu
NDU1NjYwXSAgZG9fc3lzY2FsbF82NCsweDU5LzB4MmIwDQpbICA5NDQuNDU1ODIyXSAgZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQ0KDQpBbmQgZGVjb2RlZDoNCg0KWyAg
OTQ0LjQ1MTUwNV0gUlNQOiAwMDE4OmZmZmZjOTAwMGM2MTdjOTggRUZMQUdTOiAwMDAxMDA0Ng0K
WyAgOTQ0LjQ1MTcyNl0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDcz
YyBSQ1g6IDAwMDAwMDAwMDAwMDAwMDINClsgIDk0NC40NTIwMjBdIFJEWDogMDAwMDAwMDAwMDAw
MDAwMSBSU0k6IDAwMDAwMDAwMDAwMDAwMDMgUkRJOiAwMDAwMDAwMDAwMDAwMDAxDQpbICA5NDQu
NDUyMzEzXSBSQlA6IDAwMDAwMDAwMDAwMDAyMDcgUjA4OiBmZmZmZmZmZjgyMjNjNzFkIFIwOTog
MDAwMDAwMDAwMDAwMDYzNQ0KWyAgOTQ0LjQ1MjYxMl0gUjEwOiBmZmZmODg4MTA4NTg4MDAwIFIx
MTogMDAwMDAwMDAwMDAwMDAwMyBSMTI6IDAwMDAwMDAwMDAwMDAwMDMNClsgIDk0NC40NTI5MTBd
IFIxMzogMDAwMDAwMDAwMDAwMDczYyBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiBmZmZmODg4
MTE0ZGQ2MDAwDQpbICA5NDQuNDUzMjA4XSBGUzogIDAwMDA3ZjI5OTM3NDU4NDAoMDAwMCkgR1M6
ZmZmZjg4ODJiNTA4ZDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQpbICA5NDQuNDUz
NTM0XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpb
ICA5NDQuNDUzNzc3XSBDUjI6IDAwMDAwMDAwMDAwMDA3M2MgQ1IzOiAwMDAwMDAwMTIxYTgyMDA2
IENSNDogMDAwMDAwMDAwMDc3MGViMA0KWyAgOTQ0LjQ1NDA3Ml0gUEtSVTogNTU1NTU1NTQNClsg
IDk0NC40NTQxODddIENhbGwgVHJhY2U6DQpbICA5NDQuNDU0MjkzXSAgPFRBU0s+DQpbICA5NDQu
NDU0Mzg3XSAgdHJ5X3RvX3dha2VfdXAgKC4vaW5jbHVkZS9saW51eC9zcGlubG9jay5oOjU1NyBr
ZXJuZWwvc2NoZWQvY29yZS5jOjQxMDYpDQpbICA5NDQuNDU0NTU2XSAgX19idHJmc19lbmRfdHJh
bnNhY3Rpb24gKGZzL2J0cmZzL3RyYW5zYWN0aW9uLmM6MTExNSAoZGlzY3JpbWluYXRvciAyKSkN
ClsgIDk0NC40NTQ3NTRdICBidHJmc196b25lZF9yZXNlcnZlX2RhdGFfcmVsb2NfYmcgKGZzL2J0
cmZzL3pvbmVkLmM6Mjg0MCkNClsgIDk0NC40NTQ5ODldICBvcGVuX2N0cmVlIChmcy9idHJmcy9k
aXNrLWlvLmM6MzU4OCkNClsgIDk0NC40NTUxNDZdICBidHJmc19nZXRfdHJlZS5jb2xkIChmcy9i
dHJmcy9zdXBlci5jOjk4MiBmcy9idHJmcy9zdXBlci5jOjE5NDQgZnMvYnRyZnMvc3VwZXIuYzoy
MDg3IGZzL2J0cmZzL3N1cGVyLmM6MjEyMSkNClsgIDk0NC40NTUzMjddICB2ZnNfZ2V0X3RyZWUg
KGZzL3N1cGVyLmM6MTc1MikNClsgIDk0NC40NTU0ODBdICBfX2RvX3N5c19mc2NvbmZpZyAoZnMv
ZnNvcGVuLmM6MjMxIGZzL2Zzb3Blbi5jOjI5NSBmcy9mc29wZW4uYzo0NzMpDQpbICA5NDQuNDU1
NjYwXSAgZG9fc3lzY2FsbF82NCAoYXJjaC94ODYvZW50cnkvc3lzY2FsbF82NC5jOjYzIChkaXNj
cmltaW5hdG9yIDEpIGFyY2gveDg2L2VudHJ5L3N5c2NhbGxfNjQuYzo5NCAoZGlzY3JpbWluYXRv
ciAxKSkNClsgIDk0NC40NTU4MjJdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUgKGFy
Y2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MTMxKQ0KWyAgOTQ0LjQ1NjA0MV0gUklQOiAwMDMzOjB4
N2YyOTkzOTI3NDBlDQoNCg0KDQpmdWxsIGxvZyBvZiBteSBkZWJ1ZyBzZXNzaW9uIHNvIGZhciwg
aW5jbHVkaW5nIGR1bXBzIG9mIGZzX2luZm8sIA0Kc3BhY2VfaW5mbyBhbmQgdHJhbnM6IGh0dHBz
Oi8vdGVybWJpbi5jb20vbTNteg0KDQo=

