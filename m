Return-Path: <linux-btrfs+bounces-12262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F4BA5F5C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 14:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E4416CF0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C789267711;
	Thu, 13 Mar 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BpKMKuUW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NP6pIyo0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F946265610
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871927; cv=fail; b=bziE7BnQBfQxfCcfiMLmB/TrZmzvDTMCJ4ZbSTX2Ji6EZK8iL5OqZmNzggLS8EH8GSg5asvglapwAo0ob8dKSkV2pH+Dv1PWNofF359XvWwvay45odG4s0x5aZB2ny97B1kK1GrT/A0RrJIrLAEzYWeWySTbWqhNy2BXxxSj7SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871927; c=relaxed/simple;
	bh=JuXuj+lW0bmGLnJTRP/uY/o7BRLEqrs8WLQ8p/ogEuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KyoI2LBo0rmKD8WdiGeVEpo5ItN0rsSc7kMzNeZeJuto8laTjf8gwueblcdv+UNGdGQ2xcMSzXt6i5X4CTf690hVQ5JiH30eplSYhCNU0gxClccryNF1wwUTOPaKDm5CaWjHzjg46Me8hQeWZ+49MQZZrnlorOscD7WU9Y7Wkys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BpKMKuUW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NP6pIyo0; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741871925; x=1773407925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JuXuj+lW0bmGLnJTRP/uY/o7BRLEqrs8WLQ8p/ogEuw=;
  b=BpKMKuUW2o14YMnhYGMLfAdR/B+Fk8URBUNDJYd/wquBK20xXrmt4HwN
   Ay2h0XGmNM7so4GE9PppGefeAQuPPXvl7Rq1R2HHXLHFRriwYwboj46dN
   vFGUud0vEtb16UvU1paQ+Eq2rzwlW5Xkj9SnRf1PHvK2FLF8M4TI2BxAc
   t7+Mwm+0g2hsDVlVLePDBNpPFSE75dq6vJpk+fCHERj6dGrWft/sA98s3
   PM7igMrSQLxBrfT0dUX0MxH61GOGLZZNMpGUdPaFAu5GsfMkE4r+JpoNS
   0X37ahi4HGS5a7Licm4IBNH92Flk+A7OmXgL+2//C7/zA5r+bNjgRDXgs
   A==;
X-CSE-ConnectionGUID: TnJ2bBcQSYizFXtIXQe50w==
X-CSE-MsgGUID: awYiezeURmqIoCq1cxygJg==
X-IronPort-AV: E=Sophos;i="6.14,244,1736784000"; 
   d="scan'208";a="49753479"
Received: from mail-mw2nam10lp2047.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.47])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2025 21:18:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWwTcB6SUR4V7Buj9CdQq1dfPjbJ+Opg6xtV099jEcRc8I/aaXbMnCTDjRwSoLAyJNmfiNvx5NA6/RlXX2+ORo2uFZOyvImRAxrl9gNi2yiQndMqFQ6UzCoIL15JTUOkjYz8qVSv8AMZFG4pmULblkbewcuixCUZG75i7EFqgtNAasJfM+lvtcbOL/i67O7glRz9OV4VOZ+e8/5NRSYOFKAo34YT5l0+sHd2X0AEUOHouP1AwkaxIpAEv0CysCiRCT/cSgaD35wlatSYpbIzX7ps4DgLuUJFVkKG8W5Y3i5B+y9zMKdJRZ6Tcg9m+OpPFX1C5m6UPv6L1q7oCTvC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuXuj+lW0bmGLnJTRP/uY/o7BRLEqrs8WLQ8p/ogEuw=;
 b=i5B0+3n8Cj6zmxgZSN5vB4tF1CLgfV6TklUD7Bv3DitgzYIPEU7Z98x4IC/W3K47CKveeCpNyQLHnSzEo2Z0AeH80JzRBqOYlqsRMJkXF0RUceWu1/R3+phYM8aXKObueGEMWosgOUXHc7tLJW1DIAHUCdcqmykqLGUfvQEBME+1i1IXw2hkUKWSeMHPjo7DGQEE91XoQdnRB5GxwbKNWO2lVQ98wKmrfaidHTfDetZxO4yK1+aboxSHtQ7dV8VojyQFM1fmjpnXX5o70D+6LQggnGn1ztigwx/CRRmqo9diIdxBP2Yg6Ncu6hekkVYjSKCWZHLL9u2gX3fDii5FtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuXuj+lW0bmGLnJTRP/uY/o7BRLEqrs8WLQ8p/ogEuw=;
 b=NP6pIyo0y81nRAZZlLDDzoSAODcrOkV5VrxxEm9ni/H7YtG4Tq1vDnPYInhxyJFTDdgBUO/4y0cLfkKvGaz6Mj16GlzdXoaddKW4ipqxSb5P+bYmeD2h+/pEJls7l7Pbdpq/HLcxoESyw6wwfFEI8Dl9Oav1U5+F5N6nF9yHGeI=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA6PR04MB9237.namprd04.prod.outlook.com (2603:10b6:806:417::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 13:18:41 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 13:18:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Topic: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Index:
 AQHbkWcHHm5kGZj2pUWXjQyYDI5QKLNshJIAgACkFoCAABbtAIAAl5aAgAArbgCAAUPEAIABWVEAgAAqWICAAAKRAIAARXuA
Date: Thu, 13 Mar 2025 13:18:41 +0000
Message-ID: <4463e487-b260-47f4-a7b7-285ebf987967@wdc.com>
References:
 <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
 <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
 <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com>
 <CAB_b4sAgb370vOS3OVp2Vx6W+9iLUrCUvfRwVx9WtWbFOXPQsg@mail.gmail.com>
 <6ab5accb-de28-4d79-92c4-1d3b085fbb08@wdc.com>
 <76e81f2c-17fb-4c11-b1c4-0b4c18b080b5@wdc.com>
 <CAB_b4sBkBOMCpbsf4hmC+wnL9FiH3vk70mq+QrZEAbb8Jfw=jw@mail.gmail.com>
 <4b15f181-8e28-4c8c-b86a-780315d5cc7a@wdc.com>
In-Reply-To: <4b15f181-8e28-4c8c-b86a-780315d5cc7a@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA6PR04MB9237:EE_
x-ms-office365-filtering-correlation-id: 53205423-20ee-4e64-66a7-08dd623192ef
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rlo3REZtODhmVWVhUG9NMktWTDBUSmtBSFU2bGdoNEw4ck1BemtQV05jZENE?=
 =?utf-8?B?K0pyY0FObzFCSytyN2lZdmQrakpHT0ZnNzlWa2NGRG8zeEFhelZSd0xKcENZ?=
 =?utf-8?B?Z3lUWVo2TlZjOVgwNEl5bmx4QWJKUmpWMDJ0Wm13SlhDWWxyQXRYYnBBNFBY?=
 =?utf-8?B?aUROWVY5UnFIOWF0RmUyZTdvWkg3RUxuZ1lIUStnVjhQeU9GZ3dFUFpBVUlq?=
 =?utf-8?B?VzhjaSs1enZyVjNzTFhZYmpHZVY2OGRKR24rZ1RTemFtdXFobHpMZm1Mamph?=
 =?utf-8?B?L0ZjeXJIV2JNeUVPR1VYa3dWczR5ejJUQXV0S0NMRU1VR3RIeWIxQXdVbE1a?=
 =?utf-8?B?NjBidm5aNzdHaUdFNFk0RHNYaVZqNXcxNWpGQXBENXVqeG1LN2RzWVRnbmd1?=
 =?utf-8?B?SVhLOEhMZGNTOGVweFVwc1FucEJsby9IdFg3S3pJQ2F1L25jQ0swYXU5ZjRi?=
 =?utf-8?B?ZStRenBRSW5ta0tjOU1jNHFZamVYZGdJdkV1akNRTzhTbjFtZVpndWl2RHpT?=
 =?utf-8?B?TEdIQ2xxcHQrSms3eEsvS0RHKzlhU2xkTEhNOVVVY1d4SUx6Z3dxbmhwcFNF?=
 =?utf-8?B?ZXdUcjhyTjJISGdvdGREUGZONGQ0Y1BxdTdrb0dxdXZwK280UFdQWVBLQUVV?=
 =?utf-8?B?alNzditiS0s2dG1HNjhxOUdjVzlpdjY2aUFiRVgyaXFRQitXREYrbE1CeFQ5?=
 =?utf-8?B?b0d4dm1YWU0vcFpYamVkTzdBa0J4QloxQ1NIS1lORVd4TVg1OUxxTkYrK2d1?=
 =?utf-8?B?akpFNWMvcWpPSEs1Q2JmOUZlbWV1cFREdHJ3MWxmeFBEdHcwamhnUU5QWnhB?=
 =?utf-8?B?S2lLTzQ3dVY3M1Jhb05zbGdOMDl2eWVtTkZCaWdaTG1lQm9ObHFPdUJ6bG9m?=
 =?utf-8?B?N21FM3NhWFNNcjRwcWlSai9TN2VNVWFVRG5zMVkyYVkzWGlYZ1pMS2Jlb0dq?=
 =?utf-8?B?Ump4WnFURU9kSi9IZUxoZ0pwcWNkS3c3cmwycDZCNWZvZ0VTOHYxamNRTHpm?=
 =?utf-8?B?OXhSSEJVODljRk1PcWhFM3QzYi9GdFZDY01sSkNuZXBnZVFla1RkUzZzNnBs?=
 =?utf-8?B?UWpKUWp2a1BVeC9NcXhNb0poZFkrOGdKbEVQSGdTL0ZoTWpKenRjMlozWWtY?=
 =?utf-8?B?ejErakJIQTdMQ0Uzd25RYUZTQjVzRVBka3ZQb3UvWWR6RUo2V1JkSkM2TlFE?=
 =?utf-8?B?MmhKREhnaFp5Sys0dG16TW9LNXFOVFY1STNOVnk0aFBRdlNpRXNNNXJlekZZ?=
 =?utf-8?B?cmJSQTF4VEJoV0NxbjBlRGlmaCs2L3NSTUtKY3psNlZ2OUl0Z0FTOTF4S2hp?=
 =?utf-8?B?Y3hadTF5Sklaak1pNEpBaGRhZEFYVGNaNXJRS3k2cnZJOWNmQTVyN3pFOSto?=
 =?utf-8?B?dmhJbkRtdW1hQXhzWTNIcDJYK216aHlyTndoeWpEckJYRkR0bWZWaHN6aVVK?=
 =?utf-8?B?aG9ZeGVHNFFwR3FDUXJITml1OXQxZnRpb3l3d01PdGF2am13RlhCMVhFb2FM?=
 =?utf-8?B?bmtSOXFDYXBzL1lrbEx3ZlBEZkcvdGdBV3FTZGZubWdtT2M1OGMxSnVwcUZS?=
 =?utf-8?B?dFVTVS9TSHBpdHFKcHB4S1AwdkUzRlEwVHR3djlFZVhneTJJUUU5MmRHNCtE?=
 =?utf-8?B?bFhpMFpEbUdzRjY4K3h1NVlPdXNPMXZFOTg3WGFvbTF6eTBsbjcxVGdvTU5a?=
 =?utf-8?B?cDI4dnNRVkQ4WDBsVld5NlNRM3prYjRtT2JWUlNpSGQ5b1FMOWxjL0FpR2Y2?=
 =?utf-8?B?aUIzUytmMXpNK3A4ZU9HMWpPRm9LbGowc0Q0S2FiWVB3Wi94eEZMZkRLVXdV?=
 =?utf-8?B?VnVmWkwybDd4YlNwZXNIWGVEaGxCc04xOVViYzJ6MVpYVm1ybVdzOUhsNWg5?=
 =?utf-8?B?RkpDNTloR3drMTliNGtTMWQ1OHJzdWpEL0JDNk5vc2VmdkdUeVBLSDc5SWJU?=
 =?utf-8?Q?Muq4GPehxebN/GOaxMSXgBizCzq9s95B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmgxYmlhRkV5VHVBSmZ3WnVaUmtldWtKZHJSNEVNVE82VXNFbXdHSWNZTnV3?=
 =?utf-8?B?eldlWEh3d0s5TVlnQllTeDUyb0Z3dVNrRkFEOHdmM3FDcDdDY2h0TmI5OVdL?=
 =?utf-8?B?NmhXQUNuU0dRWEgvZkEzZDVDOU5ud2FtM01SRUkxYm1IRnJmeWNaME01R2Mw?=
 =?utf-8?B?Q2t1eExtNUFyUjBMVDFmY2JiYzlzOXJNNlJqbHo1YkhiR28reUZXZGpEdGhZ?=
 =?utf-8?B?NEN1Y1dXL0FzWkQyN1VxaGQ5bTlPamJMZENpdVJEamFkTXNkRFRJc0ZOTkx5?=
 =?utf-8?B?SEY4ZXpQU3NiRHFSTTFEaUxRUU9OZkxjTzZDYXlrV3pxMlg0RWNQc09LY0xO?=
 =?utf-8?B?c2UwRENoU3JqY2dqZi81dTJ4S2FaMGFhTkVaMnIwTmhVaTBrMWYvdDFmOVZt?=
 =?utf-8?B?MTR3V0xQL0hkNDU5TEVjYy9mSFgvVzR0NUVHbkQ1YnBPVW85Q0N5SE44ZWxt?=
 =?utf-8?B?dXo0eEhWcDIwdlJXTUN3SnpHaHBjeEFWNWFmSEJPVWVBcFpkRCtBUU5MM3pr?=
 =?utf-8?B?SzVOZTR6K21YandGUGtSbkNpN2Rpb3lkT2N0YjgrRTErbkgzNStyZ3QwTTd6?=
 =?utf-8?B?SFdsTDhyYlJDcDRibCtuZ0hGTUM0anpyd0lveFNTREI3V0Npa1BoM3lkYVBo?=
 =?utf-8?B?UGJseGw5ZzlyYnA2RjdWSkR2SUJDZzBnbDlDU3NXT25xUFYraHdmSXJzL0I5?=
 =?utf-8?B?bVJVREc3ZWU0T1pyUVZ5NERxL09ucU5LR3YvOURlRmwxN3lqWXByS25EMHFM?=
 =?utf-8?B?cFI3eTV2VjRGMW9saDVxQm5sZDNwT2gwSnI3eDArLzBtNk1NNzlXQVJuTy83?=
 =?utf-8?B?V2lLdlFWd051MExTTWp4RXZsUTB5czNFTmd2UUlhQXZld0VCWmlKaXppL3Vp?=
 =?utf-8?B?Q0ZXOGw0TGI4MlJ5b3QzQzRGZVkwZzRVM3Y0SVRCT1kvUEVpVHRRRGVod21y?=
 =?utf-8?B?MlY2Y1pDb3Bkb1kzaTNPQkpvd0VMVEVjb1JYRXNhWmF0REw4Y2RTRDRSQ1J3?=
 =?utf-8?B?ZitCR0dNRWp3dTJLSEZoMC92MnAwZ3NpRTg0d1VndjJJclU1Z3pVUk1sVkhD?=
 =?utf-8?B?cGRjVzlmNjkxUGcxU1FNSldmaytmbkhJT1hhNHByUVFUQVRLYXRuM1FmZFl3?=
 =?utf-8?B?Qm5PS3owejk1MU1wMkFzY2RoVXRRUVpienlXQjhnMVNPclAxendsZHpubCtx?=
 =?utf-8?B?K0R4bjUrZTNreDh3aGdoM0FJT3cvN1JLUTJUUVU2b2xweG53WnVNMnVwS1pF?=
 =?utf-8?B?TklZV1JXTHV0SUZkbFRzNFZrWXJ3ODYzcTJSTy9IenY2RGxmdmxiYmZIcE41?=
 =?utf-8?B?N1BhRHEwYTBSZ3d3OUFYZTg2bjhacUhVVTR2TVU4bTV0SWRpYlJBOWsvN3RX?=
 =?utf-8?B?Nit3RXo3cXFBYjN1dUZQdHdEZ09XTXArYmpJUW4zMCtEQ0I2Mzg0czdmdnhG?=
 =?utf-8?B?NWc1dmE5NXhnd3ZQWWZPSGVVVXhSQjFxNkR3TWN3M3V3Zy9ya2cxL2xTNXd3?=
 =?utf-8?B?ODUxTzhhNTAxUWcrQXczc2dOU2pWK3JBTVpLWFdoNnNJeDBxUmxneVNYbVM3?=
 =?utf-8?B?TVdrdER2Qk5RcTR0U3drRUV0NTZuZTcxRUhaejRNcGJqMTVoS2w3V29YdDBB?=
 =?utf-8?B?RU9VRzZFNUFuOGNQODlZNFdBS01DRFhtcE5vcGRSb0FEcWdkSGpoTlNkWjZT?=
 =?utf-8?B?dG9jR2Z2eUJoeHQ3U3IwNE5rUDBoMEN4bDN1Sm92UDU0RGVtZmNOc3RicmVB?=
 =?utf-8?B?SlZIbHlEZWhWcFlRM0xwTmJsT3FoZUF3d3J0SUpqd3E2dHRzMU5qeE9rWEU1?=
 =?utf-8?B?OWNleC9oR3owS2VCSHlIb0dTSWYyU0pITVlUZjVaM0VvMEtNalRaSElvZ3lG?=
 =?utf-8?B?aWx6MkVibEpFdyt2UDVaZmZIc1IvUTFvYk9iYStYd05zSzQ0M0xHZSt2WmR3?=
 =?utf-8?B?b0pKcTg3TG9nMmJGTUZKQkRjbkhiZTdBQ3d1enJrNldBclh4MnJzZTBEbWhE?=
 =?utf-8?B?RkUxOFBaMk1JQkg3Nkl2SWJmMy9Zb09BS2ZsZFFvcngvaVRralJSWWU4VEJ1?=
 =?utf-8?B?TmRKcmhrMDBLMGdnU2NSNk8zMXphT2xLQzEzeHFvdTFxc3JWSXhoZGxLWXR6?=
 =?utf-8?B?SkpzWjU2Y3BycVc2eGZSR0lldXY4bmtiTU1jeC9MVGpXRk5uVDE0VXB1c09Y?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8920F0593DEDD40ACA72B3D1BF7DFEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tG02FeOdUPDGwcBhUabQJwWczRfCkOvShKzNYPUJzSJ20V85VB0aV3DpNBA+eNAtw6qxMBmO+C6ZNEFeOfnqT4/UktUyFb6PDPYBSzyvB+6L2NVsE0tO8EJFt+N9wh1B9SsBeho/9JoMZd8FUsCGUawdmuwWRkJNaQud0zGCuBfUDp1gf+0YGSKzSD7P+jiglRwWwQ6SuGBVQs1aLet8RghVBFNtK3QxNUeskpa4MG6O6Qsg8iQbMOCwuswXEMjRh/62+ZOEnUa0unb4nWGNZLZO42n99+U0UIdyrcBRurhIHAJpsZaNFcMTaBNiQbZx7khFht8eRHe2m3asbYPGb46kH0fGQQbEoUbUAJU2X4OtL1jTuDmQUA15U1SFnEbqli0rWb4XrmrdwPlh4rql5oBBbST0ks2rlXfaXECFicZVxbPdov5v2Y9zRGDmZXVfpQoJzahsdIxfUmWd53E821Zii+eLOR7WwORI2d5xictEBomcnYxdOARjVw5NYZvxacNGoDlmFzM+diwVcq1pRRTxU3cWcIEwXbeQnNpP1dglwC/+BoabNQS+xiDh03CEglT2Yj0R+U+TUTwZbx06xaX02Tx00RY3E4U90qKCq9RcTjqJFPS+fXZaWklkWEAd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53205423-20ee-4e64-66a7-08dd623192ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 13:18:41.4386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZQ2jygAR8Y+RPQo7yWUA3+BJC5dBrdUgfQQTBP/ch5VfJd3W5cIhGjVJGPun41bVR0bpeIlUoMG7pc/+CRp/9LL056C4cfG1vcrc3fefQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9237

T24gMTMuMDMuMjUgMTA6MTEsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMTMuMDMu
MjUgMTA6MDEsIOilv+acqOmHjue+sOWfuiB3cm90ZToNCj4+IFdpbGwgdHJ5IHRvIGRvIGlmIGhh
dmUgdGhlIHRpbWUuIEJ1dCBjYW4ndCBndWFyYW50ZWUgd2lsbCByZXByb2R1Y2UNCj4+IHRoZSBp
c3N1ZSBzaW5jZSB0aGUgY29udGVudCBvbiB0aGUgZGlzayBoYXMgY2hhbmdlZCBzaW5jZS4gQW5k
IHNpbmNlIEkNCj4+IGFtIG9uIHRyaXAgc28gZm9sbG93aW5nIGlzIG9ubHkgcG9zc2libGUgd2hl
biBJIGdldCBiYWNrLCBzb3JyeS4NCj4gDQo+IFN1cmUgbm8gcHJvYmxlbS4gSSBzdGlsbCBkb24n
dCB1bmRlcnN0YW5kIGhvdyB0aGUgV1AgbWlzbWF0Y2ggaGFwcGVuZWQNCj4gaW4gdGhlIGZpcnN0
IHBsYWNlLiBDcmFzaGluZyBpcyBiYWQgZWl0aGVyIHdheSBzbyBpdCdzIGF0IGxlYXN0IDIgYnVn
cw0KPiB5b3UncmUgdHJpZ2dlcmluZyBoZXJlLg0KDQpHb29kIG5ld3MsIEkgY291bGQgcmVjcmVh
dGUgdGhlIGJ1ZyBieSBtYW51YWxseSBtb3ZpbmcgdGhlIFdQcyBvZiBhIA0KbnVsbF9ibGsgZGV2
aWNlIGJldHdlZW4gYWRkaW5nIGl0IHRvIHRoZSBGUyBhbmQgYmFsYW5jaW5nLg0KDQpGb3IgdGhl
IHJlY29yZCwgaGVyZSdzIHRoZSByZXByb2R1Y2VyIHRoYXQgd29ya3MgZm9yIG1lOg0KDQojIS9i
aW4vc2gNCg0Kc2V0IC1lDQoNCkNGUz0kKGZpbmRtbnQgLXQgY29uZmlnZnMgLWYgfCBhd2sgJy9e
XC8vIHsgcHJpbnQgJDEgfScpDQoNCiMgQ3JlYXRlIDIgem9uZWQgbnVsbF9ibG9jayBkZXZpY2Vz
DQpwdXNoZCAkQ0ZTL251bGxiLw0KZm9yIGRldiBpbiBudWxsYjEgbnVsbGIyOyBkbw0KICAgICAg
ICAgbWtkaXIgJGRldg0KICAgICAgICAgcHVzaGQgJGRldg0KICAgICAgICAgZWNobyAxMjggPiB6
b25lX2NhcGFjaXR5DQogICAgICAgICBlY2hvIDEyOCA+IHpvbmVfc2l6ZQ0KICAgICAgICAgZWNo
byAxID4gbWVtb3J5X2JhY2tlZA0KICAgICAgICAgZWNobyAxID4gem9uZWQNCiAgICAgICAgIGVj
aG8gMTAyNDAgPiBzaXplDQogICAgICAgICBlY2hvIDEgPiBwb3dlcg0KICAgICAgICAgcG9wZA0K
ZG9uZQ0KcG9wZA0KDQpERVYxPS9kZXYvbnVsbGIxDQpERVYyPS9kZXYvbnVsbGIyDQoNCiMgQ3Jl
YXRlIGEgRlMgb24gbnVsbGIxIGFuZCBtb3VudCBpdA0KbWtmcyAtdCBidHJmcyAkREVWMQ0KbW91
bnQgJERFVjEgL21udA0KDQojIFdyaXRlIGRhdGEgdG8gaXQNCmRkIGlmPS9kZXYvemVybyBvZj0v
bW50L3Rlc3QgYnM9MTI4ayBjb3VudD0xMDI0IHN0YXR1cz1wcm9ncmVzcw0KDQojIEFkZCBkZXZp
Y2UgdHdvIHRvIHRoZSBGUw0KYnRyZnMgZGV2aWNlIGFkZCAkREVWMiAvbW50DQoNCiMgTW92ZSB3
cml0ZSBwb2ludGVycyBvZiBhbGwgZW1wdHkgem9uZXMgYnkgNGsgdG8gc2ltdWxhdGUgd3JpdGUg
cG9pbnRlcg0KIyBtaXNtYXRjaC4NCiMgJ2Jsa3pvbmUgcmVwb3J0JyByZXBvcnRzIHRoZSB6b25l
IG51bWJlcnMgaW4gc2VjdG9ycyBzbyB3ZSBuZWVkIHRvIGNvbnZlcnQNCiMgaXQgdG8gYnl0ZXMg
Zmlyc3QuIEFmdGVyd2FyZHMgd2UgbmVlZCB0byBjb252ZXJ0IGl0IHRvIDRrIGJsb2NrcyBmb3Ig
ZGQuDQpmb3Igem9uZSBpbiAkKGJsa3pvbmUgcmVwb3J0ICRERVYyIHwgYXdrICcvZW0vIHsgcHJp
bnQgJDIgfScgfCBzZWQgJ3MvLC8vJyk7DQpkbw0KICAgICAgICAgem9uZT0kKCgkem9uZSAvIDgp
KQ0KICAgICAgICAgZGQgaWY9L2Rldi96ZXJvIG9mPSRERVYyIHNlZWs9JHpvbmUgYnM9NGsgc3Rh
dHVzPXByb2dyZXNzIFwNCiAgICAgICAgICAgICAgICAgb2ZsYWc9ZGlyZWN0IGNvdW50PTENCmRv
bmUNCg0KYnRyZnMgYmFsYW5jZSBzdGFydCAtbWNvbnZlcnQ9cmFpZDEgL21udA0KDQo=

