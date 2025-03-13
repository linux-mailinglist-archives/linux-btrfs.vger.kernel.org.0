Return-Path: <linux-btrfs+bounces-12258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C242FA5EF2D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 10:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313093B174C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12218260366;
	Thu, 13 Mar 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bCQcQ0QT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HRXuQKFD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634E263C9B
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857013; cv=fail; b=D65CDnM6gPZZ/GVTu5K1zWrdR669hGhZQmz4boa0DRnQQWKp1Hy4JPBH6AOi+1/oiVWoewayd512dVXR7qqynlX0TmueRGvGlebS/tK40OMT8jHNmdezLfVsMW1DVWah2Cf1coOnWSq0Vtqzl1b3betuXpTJ2kKbCzbOJhhus0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857013; c=relaxed/simple;
	bh=wUBBXyI2gJm5Dq4gHT7MOERIRlwODinmQXwDwpKpqPs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eeuswJdtBlCO9+FwdNZBTzusiYrnHXx0r9eauDSgRAjYVCH/hTYq/IrRpAcXEz5BSthVFUKTC01LvfRTcdc76RtoabXvEN0/cPFxITyl6OlpBNcIEzLjR/GNmX1m7Pc3rIL84H07+Kyq4ZuKO+d1uj5xQRwfqag62eDjxLr3E4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bCQcQ0QT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HRXuQKFD; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741857010; x=1773393010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wUBBXyI2gJm5Dq4gHT7MOERIRlwODinmQXwDwpKpqPs=;
  b=bCQcQ0QT7ko38tQRrD+YGy6YIru5nzrun9JCHL+r56oxQrWHZ8jpO+B6
   Yr04d3Nbi33Y6o3b75iiWb7uzH+9QFUzTKrZ4ghSS+TPs3E+B0aQAVVQn
   DhQrA4VahOnYeVQst1x5gbEmLcdsdl83szvQMmcJVu7X+HgL9spQszpen
   uLMmfDIMqaVyIjT4RqlUXRXf+LDUZg/3vbHanodbv3ezTKmaQPyi40/Se
   RAPSNEnTuUS4TLkwgnnqxF1q1vKcVkoSx0L7R+tUzwk5TBnm2enwMsMCc
   rgAAY9OIM5neZy2PeQnwB5RwbOad1Jauij/zzohmRBZ4MsV7NhTUbZZeT
   Q==;
X-CSE-ConnectionGUID: fypEJKCnTySFkxgwlbUOmA==
X-CSE-MsgGUID: 2wCNAO0HTgC4pqzp0TvHbA==
X-IronPort-AV: E=Sophos;i="6.14,244,1736784000"; 
   d="scan'208";a="47809639"
Received: from mail-bn1nam02lp2043.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.43])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2025 17:10:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMoZmdQOuatXHTbbXuDpmd8FptSWJnEX2npOs5SoScsZ+HtDijss5tG8XZBkYNm8E+9G+rVTPUak3bcQG93fZNOVVbN3vgiwHQxWY8IVH3VJfsfGEaaHKVMBmPnhuSdHSx77bQywNtf/N+kYL7PC8Pc4bDePyn/G2OueXhsjtkY/9E0oJSPvHXVBzUxlkQyeQAhBbVnLaZdf//jli6Ypr9/rLs4gVd7xlEjUK+IPV2NyYVtKD2xz1jfrelosgKDiP17MiIu/ELbf+V2U8dFyzhpPWI6Oc8xaql/4KG9b9Q6fRGdYcj0uyk8nTFALWEyQg/QOTfDd8Om5v7yd5I1yPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUBBXyI2gJm5Dq4gHT7MOERIRlwODinmQXwDwpKpqPs=;
 b=fsp0kWmb500KzeiHPmZSqyXy+J2BkVf3jQSjpXr5vMYxxVHTK4WKDvyN3S1f0c7q0dl1llTzGytbavePKYClOY/rMfbpoAympGg0edE6+s1GQbxwU3siZUxCdEAvuh7r/zHQPbpAACOFbrsUuXXc6luNezrzRqFI6bu1Yf0RF53wr4s687xEwseMycmEaQLbAerphAVCYFeM5PAC0AauT64igQ9EOuxBj35fow5dJ4Tj9UkAQ4SJPcLEI7NAzEsngFcJkvfFExMoERq9tQZJ7ym267db8Ajl1v9mjTXmtitQkdBtBluN4TyMXm6S648DvtUZ555dnSWaKk86UvRsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUBBXyI2gJm5Dq4gHT7MOERIRlwODinmQXwDwpKpqPs=;
 b=HRXuQKFDdIZX2C4FJU3dKt10YIMoAxC6UxkdUJxkte1FrRSDwjotikWfbDS+rI/8n8ZYJ0T/zCVwiTaRt73dbqtc1JjjfcWPj2sWyMG9cHFQvIzAKnPtFaiKabOuEeOo5DEj+bzksL9UqLc8/W5qWjhZBHClMl7q8h1BGZMI/Ow=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8568.namprd04.prod.outlook.com (2603:10b6:a03:4e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 09:10:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 09:10:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Topic: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Index:
 AQHbkWcHHm5kGZj2pUWXjQyYDI5QKLNshJIAgACkFoCAABbtAIAAl5aAgAArbgCAAUPEAIABWVEAgAAqWICAAAKRAA==
Date: Thu, 13 Mar 2025 09:10:01 +0000
Message-ID: <4b15f181-8e28-4c8c-b86a-780315d5cc7a@wdc.com>
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
In-Reply-To:
 <CAB_b4sBkBOMCpbsf4hmC+wnL9FiH3vk70mq+QrZEAbb8Jfw=jw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8568:EE_
x-ms-office365-filtering-correlation-id: 700a131e-a5bf-4fd0-cf10-08dd620ed5c5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjlSSEJ3QlczZ0x4ek5TdTFtRVZiTURnUkgrZTBwS3czcXEra0ZaeVdzTEVB?=
 =?utf-8?B?Q3BHR3JIbHB1Q2FwT216T3N0RXZWTndGRyt0VTNDOTFuQm5UYTN2WVpldUZX?=
 =?utf-8?B?SXVyaG1HNEp6MW1aRGtrWnkzUjhBZmduY2NlcjBnS3N2MVc5SFJNeGpPdGRT?=
 =?utf-8?B?VUlEZVdqTHFVT0VTelpzTzVoblhGcE5hbkJsc0wycVhITVpkTGxKM0lVejZr?=
 =?utf-8?B?Z2VyenQvV0JTS29rQjFJNVZ0SzNaeFh5dEtmT2ltR3p5bi9rSmNUQkRHUGt3?=
 =?utf-8?B?Yks5dTV4S3dDU01uQWQ4RVlSMmpVVGMzMWV5cFhCU2dPYkNyZXdpa1NNRDBy?=
 =?utf-8?B?ZStpUi82WnJjamFjM05oOVMvR0p0Nno0SW1Fa2F1bUNiZjFMOTJzWXJvcGwz?=
 =?utf-8?B?YWwvT3dvek10MFovVWM4RzlpRXRRUXlYQmltTEFuZWZGeGY2dEZIbDhSQzRR?=
 =?utf-8?B?bjNFeTR2VWFvN2VrWjRpZG9DUWRMV0lCa2h1WWJiS01zRGFnRW02YTNvMHRp?=
 =?utf-8?B?UlFEQm1aUEFXUUl2NHEveXk5U1ZCSjF2ZDBmcGxxL3NoRjNBbjhtUUNsRDZy?=
 =?utf-8?B?RE1BNmE0dkFUNXVnVzVsUTFPcElkalJ4VlZVSnp3RDgwWWk3UFp2TFBWUGVO?=
 =?utf-8?B?cTdwckRCMjByU1JOTk5DVVgrN05vU3RNNUVUNGkxMGJIRWxTRDcvSm5IWlpm?=
 =?utf-8?B?NDhrU1VtbE9lZCtoNVdwcS9jZkRZTTc4U2tIZ1NnQ3ovUWVQZUJHVytOK1FC?=
 =?utf-8?B?UXQvczlWMWVFM2Npa2YzUkVaSEdSOVZuNThUbS96THArM1BKYVIvZFNKbHZZ?=
 =?utf-8?B?clVBQzZuRXJxeVBnMGNWeW1KbjJ1YzhYMGJnQmR5Qm9GVG44emt4SWZwSndj?=
 =?utf-8?B?SjR1bXpoSFI1WU8wYVhBNjE5K2pjY1krZG9rcTU5TkpUcjdZSWFSd3BUcjEy?=
 =?utf-8?B?N2pzU3dTNHdTTS9zakN0ZWJYWDI5bjNHUlJFUDVEaHBSUlZQaytjT2ZiN2xu?=
 =?utf-8?B?ZkZVcW8xUlhFT24vRFRveENDNjNuUTl3bUt6M2kxTDM1ZnFQeDA3RmZnTm5K?=
 =?utf-8?B?WWJrYXRwV2FWRElqN0NOaTRKSmhqL0hOOGswR0JHTTRYWVU3em9GN2szcG0w?=
 =?utf-8?B?a1grWDVSZjhiQmhzWUU5YWN2dFB1UzQ5aDArNWkzU09sMkF3eWZwdVFtWG9B?=
 =?utf-8?B?MkFJQWpYS2JDRXRUUGJmMmxRWk1VVGp3aVJDeCttcndScHNYL1JNRGxKUE5U?=
 =?utf-8?B?enJ6YXdiek5uc2MxckxGUURRQzl0dDRPUTV4QkZROGJIYlJWQ0VWSjRVUXly?=
 =?utf-8?B?eGR2RmxFSHhmeENFK2ZHbnkvcjRwZVdWTVFzbE53L2ZGZnNrUTlJRmFWa0pZ?=
 =?utf-8?B?K3BiRFdlSVJLaGhCQ2NHVnVUWXd6SStuNDhaMTQ0MFVrRVkwM2x3ODZOOHps?=
 =?utf-8?B?V0pjQWs1TzhaOXZEdWVhdkxXQ01vNjhLQzZBb3A5Q0tOZFdzTXpRWHpxUW9I?=
 =?utf-8?B?c1pzclZVWExCQmpCbGdHSnN3SE45RWNDckQ3bGZ5L2pId3k3VFFic0M0QkZ5?=
 =?utf-8?B?ZWNTTFR1OS9yYmpJeGtVQmtEbnlSUW1vSjF6eWRwVm9pditsL28zZVFOZ0k1?=
 =?utf-8?B?NHVtZkFZS0ZEbXAwbWxmbVd1RjBsVHVoUU13UmovdTFBNEN2T1QzVFdjZG1B?=
 =?utf-8?B?MGhNNUdXTUI2b0c2M2t1RjZvOUw2VGp6a1hZQTJFVnF1S1orRlBHdlVxTXBX?=
 =?utf-8?B?VWNJOHU3clczY0xoeUtuMXFoNnZrWDEvcjVRNndZTGRZdk5zQ0dCVUE0aWZp?=
 =?utf-8?B?MW9ZdXJ5NVgzdHlJZkdWVk1tWkVENnJFb3NDNjVVdkNLaHI2T244WEMzb0NQ?=
 =?utf-8?B?Vm80M1o1M0NiQVI3UU5CS09pcjNIZmJYUlUramNNb1NxV25RMDV0ODBxTmpy?=
 =?utf-8?Q?JdUEn+/oKm7sk8hizUDvzslavIvWqI09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dU8raTBoSEhQU3VVY0o0R290MUdESjJlNlQ4S3g4N0tWYzlqbUNTVWlTZXV1?=
 =?utf-8?B?VUhJM01WQzBIdXFOUjMzL1FvUUJPcmFhMk0vcWxxN0pWUC85cWQxdXNhblBx?=
 =?utf-8?B?RE45MkVsWkRSaUpDZkxCa3FYY1ZwVHZubHcvK25oY1VpVDcwQVlPS3VvZGRC?=
 =?utf-8?B?Ymp3ekJDZSsrR01tdjVLYkpBTE5mRXQ0aUhoRU4vOHJCamF3VmF5c2hZRFRl?=
 =?utf-8?B?MGxGb0I3YUpnd2RGR2pQaEpSZ0lCcWRwUFNaRU5DTCtUUDJCUVFuaVJ1VDI2?=
 =?utf-8?B?TGdkRDFsVFQ3aHNzZlJCTmlTVER6bURDY0hFNGdreXVUTldhZE81OFNXTGRh?=
 =?utf-8?B?S3N5SzhYY3hUS1J6QUhIckZlVzNpcC9EWEpIWVhvdjBGaHpZRm5qNmFleHEz?=
 =?utf-8?B?Tm9HUjZ2Q1BKTEFWbWlWUEtpYmVzMGUxdEM1MXhmNFliRjlJTEJGLzBMWkF6?=
 =?utf-8?B?V2IyV05sWUlGNWI2aGIwM2QwTGVLRGkzRElFQzdXUlhmekpqTnpVUW4rWkx0?=
 =?utf-8?B?WDZVaWg3RGdDZGNsOC82QXNGejd4Y0ovNzh3SlliNUtpTzZpZnYxQ3h6UC8x?=
 =?utf-8?B?eVVjSzRWcTJ0RDJFenpTVDF1VlkyVXRodzZCeENQcW93bjM1OWRlTVBRRUZr?=
 =?utf-8?B?WlJYVVkwNDgyaEt1a3k3aTh0bXlLaDBLVDA2UnRLeXpQVHlmVWtUYnJFbFZa?=
 =?utf-8?B?Yk9lRGZuY3U0dnEvOU8wMG9tU0V3eE1CWGJwSW9VUW4vY3Jnei93MzVSK1dl?=
 =?utf-8?B?bVMzUHNzejUzZGdzM09rUGRpWi9IUkRoMUE5M2N2NDM1a21QblRvTjdMMVps?=
 =?utf-8?B?Y2NubHFObjIzSUdqMjE3Rk8wYzBYZ1F5RlBUcW1OenhobjFFM3ZaWkp0bk9S?=
 =?utf-8?B?YzRTMHhhTjg0cEpoK3cyYjY5Y2QrWFo3RysxZUhXRVhjOENyT21BSEd3cnNj?=
 =?utf-8?B?RVZpK1FoOThMOUtNcjBHRDU3N2hwS3FnbEZ4YXoxbE1EVjRzNytZaGh1NU9m?=
 =?utf-8?B?OFgyN1FGYkhzeC9qNm94SGRsSVRuUXhOV280QmkwTU9xOUcvMHFLRzFFZjlU?=
 =?utf-8?B?NlhtQXVCQmc0cWJGRWpDMmZJQ0Y5ZXJqbkdDNEdJTVo5ODgzTUs3RVFBVHI1?=
 =?utf-8?B?ZkExYkl1c2VKRnBSK2pwN1VRZ21aVkt6QVgyR3BTTFdwTzZzV1o1SjJFZk0r?=
 =?utf-8?B?RWdyQU8xeDZaVEJIRXhYR1V4dWZwYjBBYVF5OWExRGdQbjlLbUlJYm4weUNH?=
 =?utf-8?B?UVByTERsOU5hY1FERWJicGpYa1dwSWhmNi91cHcrWW5leG0yK0s0aXR3UUJ5?=
 =?utf-8?B?S2ZvQU5sUDdUenBUQ2hGTWFWRVRSOEtrVnMvTkI2MUdpenYwdytZOEJBUkEx?=
 =?utf-8?B?YU5YaENoMTZJdi9ZSjQzNDZsUXBkeDlwbURQclBYb0dJek9lNVczY1JoYVpa?=
 =?utf-8?B?V3FTYUpucVN4bi9NUjFLSnBsdnFjaDdTaktFWFpJWjh5bjhrbHdJZTV4cGlF?=
 =?utf-8?B?VE1RUjRZQUZhRXpRTmZhMlNGSmtUZUFZUE9NOWRoeDFvbDJEQXdGamRYVkpE?=
 =?utf-8?B?ak1NNDlUM2pKei9iWHVmeHZVdXQxVFhOQ3FyTGp6YmV3MjBqcHBCQUFkUExT?=
 =?utf-8?B?c2hjQVgwdXllSUI3ZmpDSVNORVNLbEV5TlYzSmRnUmhoM2JkdnB5a0ZuaW5t?=
 =?utf-8?B?SXNzVzd1NWNyNzA5dUh4VXhoSlJYUVdrZHJ0OUJoMnRWdTZyQ3JISzFuemVl?=
 =?utf-8?B?RmFrVXVKcVBqaEZXQ2l2TzBFdE91eVhlT2xyQTVXejQ0TnYxQzY2TEUvczN3?=
 =?utf-8?B?NVQxL1gwWWw5NXU3S3lMY0dLcEhBWHVSNnpCUkNqMDRJQ3RrbVZZM2QzZndM?=
 =?utf-8?B?WVZpckdibytNZUJ1aTM3YTI1M1RDaFBhK1VESWxXVEM0N1o4c1ZZMi8xaXMr?=
 =?utf-8?B?ck9kcHdPeXpnVlUwTk1pclRyOEpoUnAvUWtJS3Q5Smt2anBvWUxTZlAvdEI1?=
 =?utf-8?B?Tm8wdC8xeGFGTXJQcVlBNG9sOWRlemxOWi9SeTNtRFpzZkk3MnJPTEFmT21Z?=
 =?utf-8?B?UHdmZGgreUlSNWJqMXgyd1h5ZHF6U0wwdjBPTmRjLzhVbHpKcEdMbGdCZzhP?=
 =?utf-8?B?bHpSUUx1ZE1Nc29WZG92NG9NVDZ4WURidUI3RWc3UnFsNHhrV01FQWo4R3lW?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B0DB7B8B2D3E740B4E9A25EEE5502DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U5CGw9zIH7rDg1Lzj4sFhUKHlrNaYGDOMcLPWy1sx7d9FXoK0NOE6m08QNamwpRRxckzp/aY0+lSueR1sw5YNGvnuBwOJrQjLfG1ZNeGQRXMT/dVcXQ68hWaT9zj2AcFTp8qynrRxWqGxkKC6J9KLHq/vWCSGhKA53xZOdP2ocuZMOy2ii5x/5Nn8n3e8xBQKMO3kg/8qE0ZvyuK0Zm1VLVFUqiE49xSC3PdjYIJ3mi5h5wXQJey+E1UhCfGh3fhBEjCXCFuovlS0Jqk1enfRdgrWoYVA2mS1XEFfNa8FuQEYOsi+/WYJi6vZVyjCWSga7KAnUPnqVeMdZww79vUPVe6KLNmVLnm7G87vmdvy8cGxNDU1q07iKw7rfc2Ra3uuvI4awwJHG22Cmuh1kx5n7B7F8qdF6sjn3lqXB3sZMWoXXhYRLqX/Y9L7+g+p1AYrPb7GAUE6snJWC5AnOnin+VdvbDm3AJnjaJDcdOACfDVj3BkObS6gb2KUp4XbnXCEAkpe21QcpSy9HjYUoP8lNOWwwqbYl5b9CxVE04pGUN7c8qYNsOGAXHcNBguXdLMJxswuG74nnyDJjUNj3MA9OAy3ilTBKSQqgZybJOp4hFXaM8+urCKaKM4zwBETCAH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a131e-a5bf-4fd0-cf10-08dd620ed5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 09:10:01.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNhKDyuv1MesFw2bCe/VUZif6bZjk9i6PAl7M1cA726janhZ7Mcj9/IxRqfO8trn0e9AISBOwq0l8UjY1HrbemDqxhjhng8p51xGReS/sz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8568

T24gMTMuMDMuMjUgMTA6MDEsIOilv+acqOmHjue+sOWfuiB3cm90ZToNCj4+IEJlY2F1c2UgdGhp
cyBzaG91bGQgZW5kIHVwIGluIGluaXRpYWw9dHJ1ZSBhbmQgbm90IGhpdCB0aGUgaWYgKCFpbml0
aWFsKQ0KPj4gY29uZGl0aW9uLg0KPiANCj4+IFRoZSBxdWVzdGlvbiBub3cgaXMsIHdoeSBpdCBk
b2Vzbid0Lg0KPiANCj4gSSByZWFkIHRoZSBjb2RlIGFnYWluLCB3aGVuIGJ0cmZzX2xvYWRfYmxv
Y2tfZ3JvdXBfcmFpZDEgcmFpc2VzIHRoZQ0KPiB3YXJuaW5nLCBpdCB3aWxsIHJldHVybiBFSU8g
YW5kIGluIGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfem9uZV9pbmZvDQo+IHRoZSBFSU8gaXMgaGFu
ZGxlZCBieSBzZXR0aW5nIGNhY2hlLT5hbGxvY19vZmZzZXQgPQ0KPiBjYWNoZS0+em9uZV9jYXBh
Y2l0eTsNCj4gDQo+ICAgICAgaWYgKHJldCA9PSAtRUlPICYmIHByb2ZpbGUgIT0gMCAmJiBwcm9m
aWxlICE9IEJUUkZTX0JMT0NLX0dST1VQX1JBSUQwICYmDQo+ICAgICAgICAgIHByb2ZpbGUgIT0g
QlRSRlNfQkxPQ0tfR1JPVVBfUkFJRDEwKSB7DQo+ICAgICAgICAgIC8qDQo+ICAgICAgICAgICAq
IERldGVjdGVkIGJyb2tlbiB3cml0ZSBwb2ludGVyLiAgTWFrZSB0aGlzIGJsb2NrIGdyb3VwDQo+
ICAgICAgICAgICAqIHVuYWxsb2NhdGFibGUgYnkgc2V0dGluZyB0aGUgYWxsb2NhdGlvbiBwb2lu
dGVyIGF0IHRoZSBlbmQgb2YNCj4gICAgICAgICAgICogYWxsb2NhdGFibGUgcmVnaW9uLiBSZWxv
Y2F0aW5nIHRoaXMgYmxvY2sgZ3JvdXAgd2lsbCBmaXggdGhlDQo+ICAgICAgICAgICAqIG1pc21h
dGNoLg0KPiAgICAgICAgICAgKg0KPiAgICAgICAgICAgKiBDdXJyZW50bHksIHdlIGNhbm5vdCBo
YW5kbGUgUkFJRDAgb3IgUkFJRDEwIGNhc2UgbGlrZSB0aGlzDQo+ICAgICAgICAgICAqIGJlY2F1
c2Ugd2UgZG9uJ3QgaGF2ZSBhIHByb3BlciB6b25lX2NhcGFjaXR5IHZhbHVlLiBCdXQsDQo+ICAg
ICAgICAgICAqIHJlYWRpbmcgZnJvbSB0aGlzIGJsb2NrIGdyb3VwIHdvbid0IHdvcmsgYW55d2F5
IGJ5IGEgbWlzc2luZw0KPiAgICAgICAgICAgKiBzdHJpcGUuDQo+ICAgICAgICAgICAqLw0KPiAg
ICAgICAgICBjYWNoZS0+YWxsb2Nfb2Zmc2V0ID0gY2FjaGUtPnpvbmVfY2FwYWNpdHk7DQo+ICAg
ICAgICAgIHJldCA9IDA7DQo+ICAgICAgfQ0KPiANCj4gVGhlIHpvbmVfY2FwYWNpdHkgaXMgc2V0
IGluIGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfcmFpZDEgYmVmb3JlDQo+IHJhaXNpbmcgdGhlIHdh
cm5pbmcgKGFuZCByZXR1cm4gRUlPKSwgc28gc2hvdWxkIG5vdCBiZSAwLg0KPiANCj4gSW4gdGhp
cyBjYXNlLCB0byBteSB1bmRlcnN0YW5kaW5nLCBjYWNoZS0+YWxsb2Nfb2Zmc2V0ICE9MCwgYnV0
IGluDQo+IF9fYnRyZnNfYWRkX2ZyZWVfc3BhY2Vfem9uZWQgaW5pdGlhbCBpcyBkZWZpbmVkIGJ5
DQo+IA0KPiBpbml0aWFsID0gKChzaXplID09IGJsb2NrX2dyb3VwLT5sZW5ndGgpICYmIChibG9j
a19ncm91cC0+YWxsb2Nfb2Zmc2V0ID09IDApKTsNCj4gDQo+IHdoaWNoIHNob3VsZCBiZSBmYWxz
ZSwgdGhhdCB0cmlnZ2VyZWQgdGhlIG51bGwgZGVyZWY/DQo+IA0KPiBKb2hhbm5lcyBUaHVtc2hp
cm4gPEpvaGFubmVzLlRodW1zaGlybkB3ZGMuY29tPiDkuo4yMDI15bm0M+aciDEz5pel5ZGo5Zub
IDE0OjI55YaZ6YGT77yaDQo+PiBJcyB0aGVyZSBhIGNoYW5jZSB5b3UgY2FuIHRyeSB0byByZWNy
ZWF0ZSB0aGUgYnVnIHdpdGggdGhlIGZvbGxvd2luZw0KPj4ga3Byb2JlIGFwcGxpZWQ/DQo+IA0K
PiBXaWxsIHRyeSB0byBkbyBpZiBoYXZlIHRoZSB0aW1lLiBCdXQgY2FuJ3QgZ3VhcmFudGVlIHdp
bGwgcmVwcm9kdWNlDQo+IHRoZSBpc3N1ZSBzaW5jZSB0aGUgY29udGVudCBvbiB0aGUgZGlzayBo
YXMgY2hhbmdlZCBzaW5jZS4gQW5kIHNpbmNlIEkNCj4gYW0gb24gdHJpcCBzbyBmb2xsb3dpbmcg
aXMgb25seSBwb3NzaWJsZSB3aGVuIEkgZ2V0IGJhY2ssIHNvcnJ5Lg0KDQpTdXJlIG5vIHByb2Js
ZW0uIEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCBob3cgdGhlIFdQIG1pc21hdGNoIGhhcHBlbmVk
IA0KaW4gdGhlIGZpcnN0IHBsYWNlLiBDcmFzaGluZyBpcyBiYWQgZWl0aGVyIHdheSBzbyBpdCdz
IGF0IGxlYXN0IDIgYnVncyANCnlvdSdyZSB0cmlnZ2VyaW5nIGhlcmUuDQoNCg==

