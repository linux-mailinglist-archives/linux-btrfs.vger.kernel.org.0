Return-Path: <linux-btrfs+bounces-12418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4CA68A92
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 12:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C441B881941
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A77253F17;
	Wed, 19 Mar 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kCj4tRdF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WQtCxuoe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18D3010C;
	Wed, 19 Mar 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382204; cv=fail; b=k3VRHTYCdENfPQheKY0ba8zE9G8fG/KNoEBxEWUBOaWa2n6Ni9F6o9eWBGZ4DTqZWousU/T4JgeaOhOuXSjBRgh4EjAEkQrJDKfC3IBYQIrdZf4v5XVSnilG2bnq5ClbbOwgRioWjX18b4pMSB+k9taAljyNLTOScsoH50nsbt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382204; c=relaxed/simple;
	bh=RHIg+zefLvh/8v+eqDawiVPgDULLodjer1heLLL4LKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hB1w7jb2Vhhc61s7ndf9doRK6XCnODnxrZKZU2BCyXbPO+mg2DNQp72ziu9+JzmYvUCqkh/MsMmLL/2T95kX451tnU73oG/aDWc+/EPgqP8wo/v9V06isU0ZMDSqTMD9Jt0PtE1jUHwwKgcm+1vJ03ar4QY47V+2r6k0Vs4TC+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kCj4tRdF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WQtCxuoe; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742382202; x=1773918202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RHIg+zefLvh/8v+eqDawiVPgDULLodjer1heLLL4LKo=;
  b=kCj4tRdF4z5DZJvw8hUFEditkRI6T64JKVj4OnqG6E57Jz+D+5VL9N3E
   ToB4T6NIKiNtAeCmxlTadDQWjVdurnDh2JXW8rE5NelGOz+Ut/08udVQW
   FYalZzJK7gvzCR50RibynJrRbcCakhHRpCv4zg1WyDGGunUzR/S8aAkr6
   Q9yoKWY8+owGpXpVwzoXwsciRTcQdmI0SNscnaDkMmHugg0G6kmGSC9/E
   yIq8DeU/Sv9QysEroNrtVP5xCCbZV2aohqamaIsrpZQwVkoEKKQs5uCEC
   ydgnjgcUYls93h/0qFNfRLVth0VhWQq+YmnSuwsHdJ8g36JJODXhhBHaC
   A==;
X-CSE-ConnectionGUID: 6FWgfcTYTdy3b9TFFlxogg==
X-CSE-MsgGUID: cl4eGjqpSGWmmY3P/wYU7A==
X-IronPort-AV: E=Sophos;i="6.14,259,1736784000"; 
   d="scan'208";a="53723291"
Received: from mail-westcentralusazlp17012035.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.35])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 19:03:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpkB9KUuhMIOQYwFzyvB4tLB6GYZ1M0mEyiXaiFsdQmoT1bMR6xZxw0xCSKLTcvQmzdIy7+dCu4En1tJhnMy7XJ3Pk6yZ8dD2Slp8IhiWI+eM0n2pDG+w2NKRVzAMp9sIq4pFFByCTJ4fU8mVl684/R7O898v+P/9thwB4sHhgo6iyAFpdOS9fg+8p3calNrl8+aCJU/HKhEPXyNSraDGmH6AB3QBi9wsemyom5BSBZdE7Aj5ckyPS5Tesz53kXlRM7kP4WKj9P9cg08oXclRKQnqpsgLX9Eb568DC8opFpX1zMHlSf9+mkhj4Ui5tIMD81tamYyyZ4d5IbRdlti4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHIg+zefLvh/8v+eqDawiVPgDULLodjer1heLLL4LKo=;
 b=iNGm09gyFOqNjx0m5sxLLsXVgR+22oKCX+cp+R/D/DQAR4z47rpJ34AlHr+6MWbtlWZ8l3Fiirqmdp8jKG8FW654duNodU4hJe2Ih3UWMfheGenACY5ETujgtCeUYx1LGT+LjBiUmVS7H71JVPTOW767YeuiCw8JVHqc0F93kd+flqek6KBkj/+wBsZ+W0G9AS7op23HI1GEszSP6+JCtWy+A9A0FEIDSfS6P7iJqM/JeAA21MUzZhc/RP24ue80Bcxj6nKUt1cENoj+/ylfmhSYrNBjULUgDW1W8HxINyv1lfQN6NS8LC31ekFC559elBApjjhHo37G1sJhgxaS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHIg+zefLvh/8v+eqDawiVPgDULLodjer1heLLL4LKo=;
 b=WQtCxuoeKXohfP0+9Yg2zoGlmLkewaefgO5oggarXuo4cDbSG/s7c+0QdsY5TU1q0eSw7TotdJ+O/hHyjY5TwZRpnmbe5qo216xAo7OgyTK6/rBcXK5cOgTuyIb3a1I1pK0uABdk3ia4KBOdXtfhySJmSsxWBjGC+0i+m83dLOI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8238.namprd04.prod.outlook.com (2603:10b6:806:1e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 11:03:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 11:03:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
	Zorro Lang <zlang@redhat.com>, Anand Jain <anand.jain@oracle.com>, Filipe
 Manana <fdmanana@suse.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
Thread-Topic: [PATCH v3] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
Thread-Index: AQHbmAgkF44tncnfpUqz2szRnlxM7bN5qbIAgACjQYA=
Date: Wed, 19 Mar 2025 11:03:13 +0000
Message-ID: <f923efc8-055b-490e-98ed-280e9485454e@wdc.com>
References:
 <05f928908a7949fb1787680176840b5ab23fde0b.1742303818.git.jth@kernel.org>
 <D8JUIEYCDPGF.2OM4BFFRXRUAF@wdc.com>
In-Reply-To: <D8JUIEYCDPGF.2OM4BFFRXRUAF@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8238:EE_
x-ms-office365-filtering-correlation-id: dc053e70-5037-4cb1-1968-08dd66d5a4d4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0o3Zmh0L2FZWG02aW5MMDE2TzlWeWQwdnAvVnBnUkRaQWZQKzFYbXA1dWww?=
 =?utf-8?B?bk9ieUpKRDVyVkJuYWdnYTl6SE1wYmF4V2Q3WFRXME1EcTB5Q1ZycnVWR0NI?=
 =?utf-8?B?ektWU3Rnd21lVnRRYW1DVEtuTGxFNnNNZGlma2pGVithd05YZTF4NmJBeXJm?=
 =?utf-8?B?ZGhKNTJnOFR1alhtUm5YSzg1NFJlNlJ4Zmh0YkJsK1djZlB4VDJSd3g4YTFq?=
 =?utf-8?B?bVArVDVsS251T1lpamROK3pCckhHdzEybDhMQWtiU0doeHlzc1VPVmhWZjJU?=
 =?utf-8?B?L2IyTzJRdFdKTXpTQWoycXMzdytoekVCbGNodk9xWUd4RnhzRlMzRmk1ZHZJ?=
 =?utf-8?B?cHF2TXZCU25sZi93enJvOGtzR2NMUUJuNldmbG05VkdFZEVoTGlvTjVVTUFh?=
 =?utf-8?B?K0ljRGhlVHFkYVBaRHdLTmlJQzVnRlBYVFdRdkxLZ0pYd25WRG9uYnRXVVVy?=
 =?utf-8?B?S3ZrZDh1aWpRa2V1SSs1T0k1RmZuWDBNNjRZdWFKUnJySVBydzJnL1ZicEhn?=
 =?utf-8?B?bWoyUWR5MjkyK2FiUkZEazQzUjg4REQvTWJzUlhhbUNmQWovYlh3V3BFclRK?=
 =?utf-8?B?am1rT0RyOEVlYWJna1MzUU1JaDhsZHFlV2w0VUxwNnlYSE1SNUVkWlEvK0s1?=
 =?utf-8?B?Q2hKdGVpankvWENlMUhBbmplMmZNYVowSHpxY2xhVFAxQzc1T3p4OXUrUUpJ?=
 =?utf-8?B?YWxmVDBHVllyaXpOUTJHbEIwakl2OWtFYk42NW40MGNucktvcUNtSUlhT05o?=
 =?utf-8?B?VzBpdUlPbVZ2Nno2d0x2YWNzWk9xK0tTQ1ZVdnUvUytJYTFxR1JyMXpXamp0?=
 =?utf-8?B?WWhid29odUNic1l4UjBrY1pPa1ZnTVZFZVJHa010Y3hxeENMS2ltN3luK09W?=
 =?utf-8?B?V1diQnlTVE9GSEhhOE1SbjN5S3ZYVlJmcjJoTFp1ck9YVmdPRXE3UHFlVWZ4?=
 =?utf-8?B?WlRVampmaVZTMk5xbzRGN2pzQkFwYkNKT3VaYjdjanAyWXBqUHhSU2VlcDBs?=
 =?utf-8?B?azIvQVY4YjhYajRyS1pkeTZXUDN6QkRKNkJMMGxTbXNEU1M2aWVqZitIRUxh?=
 =?utf-8?B?cVc3RU1Wd21qeDdOTXRvcXhJTFFucFZycGtvc2pFVDBHVkp0Ni9BZjQwcDVk?=
 =?utf-8?B?RXJwbERDWjkzbWtNZG9adStsTWhHQ2dUZjlOb3FTM1VjZHNET3RJbVNJYkYz?=
 =?utf-8?B?RzRSdG5TckZzeVJPTDZLMkYvbmtpSlNFem02WEpXOVVKdlNEdm5mWnBWOFNz?=
 =?utf-8?B?SmlmU1pNbFBuL2dVUW1Jam9JeXVaRWg0a0xLWUtuZHpqSGNIZEVBdXppTm1m?=
 =?utf-8?B?TE1iVnR6b3lJTzkrSFd2SlE0aTB0YTAxdW1pME84QXh1YzRhaXlwWHljd0J2?=
 =?utf-8?B?T2hXVG9WUlZCZXFrcHk3aVMzSjVpZkYvRE9Nb2ppcE1ES08rZU4xcllNbGlp?=
 =?utf-8?B?ZlYwSm9uaTBEb3czVFI0Q1gwNW1VOW5MVU0wdlVTTUowL3lHN3NPQ2hydDQ3?=
 =?utf-8?B?Tjh4cGZ2VnQrcElrVEZDS0JUQ1hNaktPbTBCQjIvZ0lCWWlYbTFMa1FqMStz?=
 =?utf-8?B?Njc1cVMxT0VSUzhiaUxDeDBEcEF5QXYrTVgzNTNjN1I3bmlWWkI0cEhINFQ1?=
 =?utf-8?B?T0E2V0F2NGtka0ErSWR5SldFVk55MlNLbytZM3N4c0JNb2YvbTFZRmtlU2N2?=
 =?utf-8?B?NTltVHNNSFZtWDZ4cTJQQmZDTnUwT09VWGJramp0WWJwSHR6ZW1KcS9zZXpm?=
 =?utf-8?B?ZEo3SjBzRGNYTmJYbjJjR2ZGek1OeVVSMG9OaUtka25jTXc0U253RFFEaGxQ?=
 =?utf-8?B?Q2xiUUtOU2krYWJOUnlFc2NkRXlCTCtIVDdDd09Fc1hYc1JNL29qcXM2SFZY?=
 =?utf-8?B?LytFWm01eE1Ya2YzbXBZdHYyNitsTlFick53Q05qM0xlMGMvTktGY3J0Zmxr?=
 =?utf-8?Q?LaETHsjjohfvDyeO8zw5ID9aAe3VC4Ge?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WklNcUFMVDE5azBCaERQdENNcEVGQ0ZtclZ3TWFVUGRwNEY1clBrVGFUQktE?=
 =?utf-8?B?ZWpzV3FIREhILzdwUzQ1ZjZZOEdReHBnbXR1ZU9seG1pMWtid0I3ZytvMGY2?=
 =?utf-8?B?cHRZSDJOcmRBeWIvbzNKRXVSekFPejBBRzBsVHlPZ2RnQ0lHU0htSUZ3NG5U?=
 =?utf-8?B?MGxNR2RYSW1yV2h3K2JzV3VYWlZXOTR1MUZQcjNkU2ZZYkJ3YTBGTVAyQ2Zx?=
 =?utf-8?B?MFZiYkxPZTcxVVFVK29INWJXSWtBcGlacWZxeVVXMFgrWDlHcUJOOVFvdkJY?=
 =?utf-8?B?RXB0dnNUb29Ib2NqS0Jjb2NPZTdLTmtBTk5mQmZLVDRKdTdkSnMwMjNubWFP?=
 =?utf-8?B?YUc1R0hNZnRwL05QaU5uREZrT0pJVFpTNCtIQ2RkSk01TUZXVUh1THNrcGM0?=
 =?utf-8?B?d1RCYm1zeFd4RU9LZmxDYWVaK09ISnVYWjRDczhscWo5b2xSSnhwUy9qRUxN?=
 =?utf-8?B?eTloT0dwMmpNV1ZJL3pBcktvNVlFWkpwOTk5WjhIWStLbTFzTEFRekNod3Jo?=
 =?utf-8?B?RzJEVndVM0MzZWdmb01xbUQrYmdmc05mTE5qRWJmM3dPNGVmNEVwZWtWejdU?=
 =?utf-8?B?enNzczFaT002THJOc2NYVnUxd0NBNVhteExjbmwxY0lGRTEwL2QxYVVMemNj?=
 =?utf-8?B?Zm9jUU5CZ3NQNnFPQ3Z3VVNTUTVTdzUzOEJDdGk0VE9VRHlEYVlXa3ZOODFG?=
 =?utf-8?B?dkhEOXhXRXpXeXJnMHp2TVNvdFJaV2UyNW0yVnRYeGhkeGhDMnJsdjA3TzVl?=
 =?utf-8?B?WitDUXpCT0tzTUMzYnJwZ21Td0FDOUlQckRZMGo5QlpSamJGVDZOdFVOTDRh?=
 =?utf-8?B?dHBXbE9GOWxCVndOTFdDOFJobFY3ejNUaWFtbDJpREY1OTdsWjF6QTdWWmNU?=
 =?utf-8?B?bHVHbE43bmhtSkFOc3IrY2UyZDZPR2ZyNXZ3bC9VSitsWmV2WHFFUWE3UHlj?=
 =?utf-8?B?bWlvWVFUa1hvRi9POUlhNERaTFpnZzA0cVpqS0tZQUtIZnlNL1hYYkpyZ3lF?=
 =?utf-8?B?WW8zU1NEU0lVeENkcjllQ1RTS2NsM092V2NMM2VIdHFETHJhMzJrWHd0cmJE?=
 =?utf-8?B?NzhUUGtQS0NGdlU0Y1lvMGNuam9aREQ3ZkU2cTRJUDV6a1l5UjUwS0UwWVdi?=
 =?utf-8?B?OVl6S2c3TjlocHVZZFB3YkxpMnBwTDBpMjdSS3NMOWJVMEJkTThvdlBBYUZY?=
 =?utf-8?B?bkl3NFFhTS9vVFcvTm1kekYxcGpIWEt4c3czSEU0TFhCWjJqRGNveExRNm1x?=
 =?utf-8?B?QlVXZUN2ZTBES1A5MStZMkpSUlltMnZxcEp2QlBFRzZlUFl3SWgwL0VRcC9l?=
 =?utf-8?B?WksreVpPeG9Sd0FFc3YzSUFQMnNQdVpRaWJmRnhsbjF3WXI1cERTNHJaakNL?=
 =?utf-8?B?cWRHSHhLVkp6bkdKbmdJTGYzTlFtc09aTllTSW1Id1JjMmtpYUlUTEg1SjlF?=
 =?utf-8?B?TG9UYlZTdjN1MUM1VWs1OVRMc0ZENmVJS01BMjlweTRMZytPVzJaeElqdTZF?=
 =?utf-8?B?dXRLWmI1OENXLyt6UTZORWJhd2lMOXE1WGFFdmtINUVNNE51cnBtU3NjTy9B?=
 =?utf-8?B?d1lRc2VhQnNpTFJQL3NmRlhPWkZlTVpMNjFkUm1HWmcrVVMyYW5uekZDTXZ2?=
 =?utf-8?B?M2RxUlh4aVMwUzN0NG1hZWNoZUdnOGF4UU5zdjVuYkFYOU1XMVFDZDkvdDhy?=
 =?utf-8?B?VVBUeFptcHVHQ01PcWJxZElzZy8xRXVrUi84MXVRK2hDMGxseTFNMEM3WjlR?=
 =?utf-8?B?YUlGYURyR3Yzd3BxVlBEdlg2dXUwMmZVYVk5RGViS3JnTjF3b3h2UTZ4Y3dN?=
 =?utf-8?B?T2ZsY2l2aldFL2wzT3NBdTg4VUdPZlVLcld3bzRsVFhNamg0bElzM1JORnI4?=
 =?utf-8?B?NjdCL3NQYU9WNitXYzZWc2lDemUvaXRaR0N6aGl3OTNYaUVPeVRDRHhDQWdE?=
 =?utf-8?B?a2JVeTdyQXlFMi9taDk2ZDl2QnpCMHpHZFZxUDdCb0l3QmJqcGlqQlVDL0li?=
 =?utf-8?B?bTNtNmdPYUZzb2h6MXExV2dJY0o2MjRLZHV4MkxQWHdpWS9CMTd3dXZxVUpN?=
 =?utf-8?B?TFhDWklYSEdQM2hpaEZXb09MV2Y1VU13MnlBMGhJMWZvRTZQdWJoQ0FtL0th?=
 =?utf-8?B?QS9UalhsM3ZCVGhsME9GSjY1K1hHQWs4aEluOUQxRVY5ZFhldjd1ZS9manJx?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5ECEEF063FDB0499C12A597D244DC3D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oz0Fc6zoyvRw7HNUXLZD+dWsMOYk2O2Srxa9thcuwRqnJbu5shNy8sLuLm3pf9SZoscwVbomNHnRFjI5WQ+HjplUQzHPfeUXGejdXpZETn4fRg/89gqi8Uv4JxT8IB1RtbkRQWq9S6EvDil4QaEzfs3hvBtAojjq22DycgZ491ADnmVo0UgQzTPphmBFBVdgAQxZAmV0K1RyR1E+FRypisrZi9uIp7117Q9hR4QE+ROLzOcJHT2kuvLTUUQ/pYV85hcRfkkQXaWBeQDNtcMh5aI44olSTzt89Kwn/03QqtHTVKY1FfCriHk3prRo8+juQR52cyYatvxbdd0xbFMjEOziGEteEHQ35IRjNMMQbg1u8RufNCvrqC9mu2zRDX2Ef2w8vhCP0Q6dCeT8V1/l8v/PsY8Nfnc/Zh7whfV/JhHXGmV6IoUjvHE7T7LxS7pJ9OABr6wMdtipi48pyrdh6jCaisW+kh+krIiji46F1+IljK7AhPUFCQ7TyPzSHXPSlGlKvp24GZZDvQDA5yJF2pAkx29g3W5bxlqFU+oLkPu274qZYlv+MPk9lMEdDeNEo7wu5GhJCUeG41CHHqoURz0j0Q9N4ll6rTK9trdZhNk8uYYTRUK/SMQJANlHoN18
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc053e70-5037-4cb1-1968-08dd66d5a4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 11:03:13.5482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McWqZkf2mz+ejiMQwqGgrAHRg+ZraQpx5kMpCpabMiMsEyCqIRoAlHvtc/6yW6mXVobpbwpug681OXRhiYfiWLX/q6pmdiN2+VB6RYlTzjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8238

T24gMTkuMDMuMjUgMDI6MTgsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gT24gVHVlIE1hciAxOCwg
MjAyNSBhdCAxMDoxNyBQTSBKU1QsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEZyb206
IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+Pg0KPj4g
UmVjZW50bHkgd2UgaGFkIGEgYnVnIHJlcG9ydCBhYm91dCBhIGtlcm5lbCBjcmFzaCB0aGF0IGhh
cHBlbmVkIHdoZW4gdGhlDQo+PiB1c2VyIHdhcyBjb252ZXJ0aW5nIGEgZmlsZXN5c3RlbSB0byB1
c2UgUkFJRDEgZm9yIG1ldGFkYXRhLCBidXQgZm9yIHNvbWUNCj4+IHJlYXNvbiB0aGUgZGV2aWNl
J3Mgd3JpdGUgcG9pbnRlcnMgZ290IG91dCBvZiBzeW5jLg0KPj4NCj4+IFRlc3QgdGhpcyBzY2Vu
YXJpbyBieSBtYW51YWxseSBpbmplY3RpbmcgZGUtc3luY2hyb25pemVkIHdyaXRlIHBvaW50ZXIN
Cj4+IHBvc2l0aW9ucyBhbmQgdGhlbiBydW5uaW5nIGNvbnZlcnNpb24gdG8gYSBtZXRhZGF0YSBS
QUlEMSBmaWxlc3lzdGVtLg0KPj4NCj4+IEluIHRoZSB0ZXN0Y2FzZSBhbHNvIHJlcGFpciB0aGUg
YnJva2VuIGZpbGVzeXN0ZW0gYW5kIGNoZWNrIGlmIGJvdGggc3lzdGVtDQo+PiBhbmQgbWV0YWRh
dGEgYmxvY2sgZ3JvdXBzIGFyZSBiYWNrIHRvIHRoZSBkZWZhdWx0ICdEVVAnIHByb2ZpbGUNCj4+
IGFmdGVyd2FyZHMuDQo+Pg0KPj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
YnRyZnMvQ0FCX2I0c0JoRGUzdHNjej1kdVZ5aGM5aE5FK2d1PUI4Q3JnTE8xNTJ1TXlhblI4QkVB
QG1haWwuZ21haWwuY29tLw0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+DQo+PiAtLS0NCj4+IENoYW5nZXMgdG8gdjI6
DQo+PiAtIEZpbHRlciBTQ1JBVENIX01OVCBpbiBnb2xkZW4gb3V0cHV0DQo+PiBDaGFuZ2VzIHRv
IHYxOg0KPj4gLSBBZGQgdGVzdCBkZXNjcmlwdGlvbg0KPj4gLSBEb24ndCByZWRpcmVjdCBzdGRl
cnIgdG8gJHNlcXJlcy5mdWxsDQo+PiAtIFVzZSB4ZnNfaW8gaW5zdGVhZCBvZiBkZA0KPj4gLSBV
c2UgJFNDUkFUQ0hfTU5UIGluc3RlYWQgb2YgaGFyZGNvZGVkIG1vdW50IHBhdGgNCj4+IC0gQ2hl
Y2sgdGhhdCAxc3QgYmFsYW5jZSBjb21tYW5kIGFjdHVhbGx5IGZhaWxzIGFzIGl0J3Mgc3VwcG9z
ZWQgdG8NCj4+IC0tLQ0KPj4gICB0ZXN0cy9idHJmcy8zMjkgICAgIHwgNjIgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIHRlc3RzL2J0cmZzLzMyOS5v
dXQgfCAgNyArKysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2J0cmZzLzMyOQ0KPj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdHMvYnRyZnMvMzI5Lm91dA0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9idHJm
cy8zMjkgYi90ZXN0cy9idHJmcy8zMjkNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+PiBpbmRl
eCAwMDAwMDAwMDAwMDAuLjU0OTY4NjZhYzMyNQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIv
dGVzdHMvYnRyZnMvMzI5DQo+PiBAQCAtMCwwICsxLDYyIEBADQo+PiArIyEgL2Jpbi9iYXNoDQo+
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gKyMgQ29weXJpZ2h0IChj
KSAyMDI1IFdlc3Rlcm4gRGlnaXRhbCBDb3Jwb3JhdGlvbi4gIEFsbCBSaWdodHMgUmVzZXJ2ZWQu
DQo+PiArIw0KPj4gKyMgRlMgUUEgVGVzdCAzMjkNCj4+ICsjDQo+PiArIyBSZWdyZXNzaW9uIHRl
c3QgZm9yIGEga2VybmVsIGNyYXNoIHdoZW4gY29udmVydGluZyBhIHpvbmVkIEJUUkZTIGZyb20N
Cj4+ICsjIG1ldGFkYXRhIERVUCB0byBSQUlEMSBhbmQgb25lIG9mIHRoZSBkZXZpY2VzIGhhcyBh
IG5vbiAwIHdyaXRlIHBvaW50ZXINCj4+ICsjIHBvc2l0aW9uIGluIHRoZSB0YXJnZXQgem9uZS4N
Cj4+ICsjDQo+PiArLiAuL2NvbW1vbi9wcmVhbWJsZQ0KPj4gK19iZWdpbl9mc3Rlc3Qgem9uZSBx
dWljayB2b2x1bWUNCj4+ICsNCj4+ICsuIC4vY29tbW9uL2ZpbHRlcg0KPj4gKw0KPj4gK19maXhl
ZF9ieV9rZXJuZWxfY29tbWl0IFhYWFhYWFhYWFhYWCBcDQo+PiArCSJidHJmczogem9uZWQ6IHJl
dHVybiBFSU8gb24gUkFJRDEgYmxvY2sgZ3JvdXAgd3JpdGUgcG9pbnRlciBtaXNtYXRjaCINCj4+
ICsNCj4+ICtfcmVxdWlyZV9zY3JhdGNoX2Rldl9wb29sIDINCj4+ICtkZWNsYXJlIC1hIGRldnM9
IiggJFNDUkFUQ0hfREVWX1BPT0wgKSINCj4+ICtfcmVxdWlyZV96b25lZF9kZXZpY2UgJHtkZXZz
WzBdfQ0KPj4gK19yZXF1aXJlX3pvbmVkX2RldmljZSAke2RldnNbMV19DQo+PiArX3JlcXVpcmVf
Y29tbWFuZCAiJEJMS1pPTkVfUFJPRyIgYmxrem9uZQ0KPj4gKw0KPj4gK19zY3JhdGNoX21rZnMg
Pj4gJHNlcXJlcy5mdWxsIDI+JjEgfHwgX2ZhaWwgIm1rZnMgZmFpbGVkIg0KPj4gK19zY3JhdGNo
X21vdW50DQo+PiArDQo+PiArIyBXcml0ZSBzb21lIGRhdGEgdG8gdGhlIEZTIHRvIGRpcnR5IGl0
DQo+PiArJFhGU19JT19QUk9HIC1mYyAicHdyaXRlIDAgMTI4TSIgJFNDUkFUQ0hfTU5UL3Rlc3Qg
fCBfZmlsdGVyX3hmc19pbw0KPj4gKw0KPj4gKyMgQWRkIGRldmljZSB0d28gdG8gdGhlIEZTDQo+
PiArJEJUUkZTX1VUSUxfUFJPRyBkZXZpY2UgYWRkICR7ZGV2c1sxXX0gJFNDUkFUQ0hfTU5UID4+
ICRzZXFyZXMuZnVsbA0KPj4gKw0KPj4gKyMgTW92ZSB3cml0ZSBwb2ludGVycyBvZiBhbGwgZW1w
dHkgem9uZXMgYnkgNGsgdG8gc2ltdWxhdGUgd3JpdGUgcG9pbnRlcg0KPj4gKyMgbWlzbWF0Y2gu
DQo+PiArem9uZXM9JCgkQkxLWk9ORV9QUk9HIHJlcG9ydCAke2RldnNbMV19IHwgJEFXS19QUk9H
ICcvZW0vIHsgcHJpbnQgJDIgfScgfFwNCj4+ICsJc2VkICdzLywvLycpDQo+IA0KPiBDYW4gd2Ug
bGltaXQgdGhlIG51bWJlciBvZiB6b25lcyB0byB3b3JrIHdpdGgsIGluIGNhc2Ugd2UgcnVuIHRo
aXMgdGVzdA0KPiBvbiBhIGh1Z2UgZGV2aWNlPyBJIGd1ZXNzIDIqKDEyOE0vNE0pPTY0IHdvdWxk
IGJlIGVub3VnaC4NCj4gDQoNCkkuZS4gc29tZXRoaW5nIGxpa2UgdGhlIGZvbGxvd2luZzoNCg0K
ZGlmZiAtLWdpdCBhL3Rlc3RzL2J0cmZzLzMyOSBiL3Rlc3RzL2J0cmZzLzMyOQ0KaW5kZXggNTQ5
Njg2NmFjMzI1Li4yNGQzNDg1MmRiMWYgMTAwNzU1DQotLS0gYS90ZXN0cy9idHJmcy8zMjkNCisr
KyBiL3Rlc3RzL2J0cmZzLzMyOQ0KQEAgLTMzLDggKzMzLDE0IEBAICRCVFJGU19VVElMX1BST0cg
ZGV2aWNlIGFkZCAke2RldnNbMV19ICRTQ1JBVENIX01OVCA+PiAkc2VxcmVzLmZ1bGwNCg0KICAj
IE1vdmUgd3JpdGUgcG9pbnRlcnMgb2YgYWxsIGVtcHR5IHpvbmVzIGJ5IDRrIHRvIHNpbXVsYXRl
IHdyaXRlIHBvaW50ZXINCiAgIyBtaXNtYXRjaC4NCisNCituem9uZXM9JCgkQkxLWk9ORV9QUk9H
IHJlcG9ydCAke2RldnNbMV19IHwgd2MgLWwpDQoraWYgWyAkbnpvbmVzIC1ndCA2NCBdOyB0aGVu
DQorICAgICAgIG56b25lcz02NA0KK2ZpDQorDQogIHpvbmVzPSQoJEJMS1pPTkVfUFJPRyByZXBv
cnQgJHtkZXZzWzFdfSB8ICRBV0tfUFJPRyAnL2VtLyB7IHByaW50ICQyIH0nIHxcDQotICAgICAg
IHNlZCAncy8sLy8nKQ0KKyAgICAgICBzZWQgJ3MvLC8vJyB8IGhlYWQgLW4gJG56b25lcykNCiAg
Zm9yIHpvbmUgaW4gJHpvbmVzOw0KICBkbw0KDQpZdXAgdGhpcyBzdGlsbCB0cmlnZ2VycyB0aGUg
YnVnIG9uIGFuIHVucGF0Y2hlZCBrZXJuZWwgaW4gbXkgY2FzZSBhbmQgdGhlDQpmaXggYWxzbyBm
aXhlcyBpdC4NCg0KU28geWVzIEknbGwgdXBkYXRlIHRoZSB0ZXN0Y2FzZSAoSSBndWVzcyBGaWxp
cGUncyBSLWIgcmVtYWlucyB3aXRoIHRoaXMgY2hhbmdlKS4NCg0K

