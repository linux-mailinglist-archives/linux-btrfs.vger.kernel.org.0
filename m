Return-Path: <linux-btrfs+bounces-22173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHVmGPekpmkTSQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22173-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 10:08:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F51EBA2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 10:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A0FF3013DD7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EE326952;
	Tue,  3 Mar 2026 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bT351xVb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pimxcIr7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979D45948
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528882; cv=fail; b=YrQiNVgPJbTaptK/Z8IOHllNAQwaNZRiZqJm64rT6BY1A8pFNLLg0k9LYNOWwiz0kHR1E0UWknw4rXOeoOlph8CT/MUBr+LOKOZTgI4Ens8gIF2fb2lUDSAoH7tl8QyQdEvAPYIif51S/orbZ5ex3N1KaiMV0pIswyjUSaU6ge0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528882; c=relaxed/simple;
	bh=r7fIC2xcjxqpbKKsPGhAJUC8qzfpyeU3iKX2GO4GvYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UdQGUvHDS+uwjH1JICQvqPGBoEWkAdBoeprUNIjinDQKO8eXsn8g34Kbdw5b0EHdp3/zVuWdsFasNL8xClJMvUUSd9ttx6rqZ/wR8o16+S2LlullEDAGKQ6bgj5N7bZaXZ+GPSTEWoxIKfldjpINzQfdbFza7IEjkzo4EtQhA2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bT351xVb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pimxcIr7; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772528880; x=1804064880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r7fIC2xcjxqpbKKsPGhAJUC8qzfpyeU3iKX2GO4GvYM=;
  b=bT351xVbOY8eS9833Evn0Ygz9cAsMbIwzfh7fUvy9kvmYodiNoNj2U91
   locobVYqdfYSiGE4Jj6yj4DAgYEXXaDP32WwnwJpP+2zWbnKCfWAqZBLW
   WuKIzBrIF4jR9xkvvZ6R/lqARnrcJyLhOjRcZRTOlcC4BMO3EE0HKueZf
   lajD/o1PEJF8U3bI+PbTT6Ehc2QEw/YrTMMJtogEXF6EwNkLqHcwQMxSD
   cTDt6vDICtEWKWU69gIMC2464NrYqv5AYR7yAhVv63MGnojunhAteo+ia
   qdaN5iM5tdP2XqVx7RQYza8KazS7hc5UT/9ETNCs9VpreFNPVIOQGWO2z
   Q==;
X-CSE-ConnectionGUID: AK6rlfTLSQuqSx+lXBiP9g==
X-CSE-MsgGUID: 2GC8Z7tKQ+60C2ACJiei3A==
X-IronPort-AV: E=Sophos;i="6.21,321,1763395200"; 
   d="scan'208";a="138192374"
Received: from mail-westusazon11012065.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.65])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 17:07:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcQsdc2EPJmP0t3zWWoNl4Kl/FLKbwjx5c5LQ4c+Hyl2NYikKj2TJhTSICRtnp9abLHfxoe83HVlcFFQWA5P2zoSF7H5R5XH/xQVP270TSOrndlQEII9cggi43xQUrwBv7kQc1GQvksbePfofD/oA63VrjbpD3h/ZGOfDyB8yw2OvixlEOaJjslJwO4F1vZ9HWciwbxCZTnzKozIbRHlrhrbMEfvQ6L+xWLR1Afhkx49iMMA0IxIdx8IGqlvBnDJPHyD3bXb6n2cMn5XgaHYMpNEvBoIn6R6WdhvotNRsvEVg9eaj/6hxorQNDmuHtzzuoko+4IvwqirtkRojsmslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7fIC2xcjxqpbKKsPGhAJUC8qzfpyeU3iKX2GO4GvYM=;
 b=k7zKPBXAWWuAGCcdxhRUmMCdZC9VMrxTvmTovTRy+FPpYVLenfRqO4nxx/Gx2sjJKbwG9IV3xDX1E3CNg/t+bNFJhCa7BLLhVX6nMMhma6+SXe19069oTQEOCO9UtQPp0lKoMq7tHeG8qgW/Yt85O7yG4zUfvbEKAmOatg7ogwC3zp4B3r0+15KpORW65fKCfZqM7UVm3KojUW7q/+v74yEp6+JK1La2XDB51FwZibCzaKied6I1BXo4AwdJCnRDL3Vc7sGAHjAmwpSzJhi52Ps/XnjBjHntM69S2VcemK3a5K1jHNzFMckaQ3UG31GnvRi7xRk/6UnNtK8Lb6eqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7fIC2xcjxqpbKKsPGhAJUC8qzfpyeU3iKX2GO4GvYM=;
 b=pimxcIr7J8fQP/vglMp1U7BOrp7iWZVSeuhRS72+sswjvciM6T+w6GwvPtJT26uErH+xTeeCtAT3wxJWqtSjeMA9RWrsNszXtVLrzDy9i0GemZxTvf6J9iAoqX7lq9EBpfE+M9o+ZNHIjoQWerg7pDDAZWCQXjKnZg2FPY3aIAQ=
Received: from SJ2PR04MB8987.namprd04.prod.outlook.com (2603:10b6:a03:557::20)
 by MN2PR04MB7120.namprd04.prod.outlook.com (2603:10b6:208:1e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Tue, 3 Mar
 2026 09:07:52 +0000
Received: from SJ2PR04MB8987.namprd04.prod.outlook.com
 ([fe80::cfc5:d779:604d:ece2]) by SJ2PR04MB8987.namprd04.prod.outlook.com
 ([fe80::cfc5:d779:604d:ece2%6]) with mapi id 15.20.9678.014; Tue, 3 Mar 2026
 09:07:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 3/3] btrfs: zoned: limit number of zones reclaimed in
 flush_space
Thread-Topic: [PATCH 3/3] btrfs: zoned: limit number of zones reclaimed in
 flush_space
Thread-Index: AQHcqlJynUPf3l0z2ECE6AuBukYHs7WcbZOAgAAYNIA=
Date: Tue, 3 Mar 2026 09:07:51 +0000
Message-ID: <6739b7b6-ec15-4276-9e37-a0d1701240aa@wdc.com>
References: <20260302143942.115619-1-johannes.thumshirn@wdc.com>
 <20260302143942.115619-4-johannes.thumshirn@wdc.com>
 <75b7fcfe-f8d5-47ae-abbb-871e418cbda0@kernel.org>
In-Reply-To: <75b7fcfe-f8d5-47ae-abbb-871e418cbda0@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8987:EE_|MN2PR04MB7120:EE_
x-ms-office365-filtering-correlation-id: 5b8f7491-0f11-4244-8c92-08de790459a5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 zO5OdVnXTJ/5iFidhAGow2DCjRu5EaTpUS727LtqO89letjxg/crwmrXgmpL6r8i6j59/so9sb9FvJBCqRBtU9Cy1G3uPTjWxwhPDqN+M14qywO7eiKq8KlZkeK1yeex3ok29W2WN43y8f8QCnSPPMoT9FWS9D2U+VP70oVEl3b6eaO0kxTSZKymYRD3gfNCWyQWzo0GMZka3mkwYOKzM/R4sUss/WqKUVVm+lL6SWz79YBzJQCFjhDJFWY7eke06W7kZU3NeAdSywq3JQXuYSN85a+wesg+rNK4yRVMZVoEP5KsYQkQafxmUXynekr7p/GXjZXH74CX//7kI+rcqE78bXx1WFf6L39jLKQjej7UyENVP7SRcRl0OVF7JhPnt1jlf+ccgr0V0qypo74HD2m8J0UXQ+tVKEhjN5DtVyo6wtyDNzT+EwPNcX5nPmDqlXgcxYzSfTqXTxRnzlmQ+4xHNThZVlW9PkYgyIKYZIKD2xq9p3HhH+EKZL1epsgQrBXPB7iCBOGOHf9ZtvtqFWWjG1COPkMkIpGwhdhgUWpJgZCTTdPO5/j5gBptXd3lnwphwNahVbtYs2MOsninTKgjEtvy7CqagLqn2mWB24robvnYehIkTMFGZJBeTtAdb+lVAKhhM+++K41icXZwaUZ37XqoZfhphak1trSLwvUwpDJbOtIgjAG1rsr+b5hNcP8t3QcbniesjeudmLPMFQOtwojgayP+4Gbkj02Kdww6RvRIT3OGARnJ0t9dVXm5rXEdfMtOmJ67DYIOvogVLbWbXU76ltYg2uR9IjzlIos=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8987.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0F3ckFNSFFDZmhtejlRZXlFbWJSbFpTTGlGbUQ4MXlaYUlwVXVFRXFIYm9H?=
 =?utf-8?B?MlRMVHhRcm9Wc09FWERKWHkzMXMvUjZUZmNvVDRCWHBDT3R1amtqdDVnTU5x?=
 =?utf-8?B?TUg3bTZJSXR2QXp2OEFGL2ZCamhqdHc4ZXQ0bFEvZmRvNnhXLzNzMVNJMnRq?=
 =?utf-8?B?SDdjY1BEQkxIT21Kd0Q2SlFIc2wxQ1JYYWxDL3RLZERSeXpURk1qWUpDTVJv?=
 =?utf-8?B?ZmpYaHpzREZhQmRCQWFxTmhsak8rS0RiSDBaR1poa3dKbWNQam5KVjhSeTZV?=
 =?utf-8?B?ek9PTnY3L0p1SHhpeFRmT2EzdWFrRUhDYWdVOUd6MzNCNVl4dWhPYVdvZmRQ?=
 =?utf-8?B?cWQ3SlVacyswS29QV05vaFU5eVl0VnZQTVY1c3lIMmtZYzIrRUJucjB5eHhL?=
 =?utf-8?B?NG5VeE1rUElac2pVWHl1Umlrc2lvenNTRkRxZnFzM3B1OUdPT0RBbVpJMHIx?=
 =?utf-8?B?aUR0dzQ2bHkxODNOMWhYUzZrbW9yTVNubm1GS0VwUXk4WDNjc0dmRFpCWWVW?=
 =?utf-8?B?WG01QWFQQmNYQjQ0Yml1YlhXbjc5ODlySGxUL202M2xOQVhUeFNHLy9PcTdp?=
 =?utf-8?B?QWNLMk93S00xMVplWWIwR3R6SkU4Ny9QZytyYWd0a3N5WTVXd3pEeUU1djVk?=
 =?utf-8?B?ZmExK1dIZWVtNXNoYkx0ckJadWFBOEVIS2ZGTkE0SHJSclZMUVBOZ2xMSFY3?=
 =?utf-8?B?UFB3Ykd2RENKQlJmQWt0WVJlZXBNRTRyNnRLczgzZXJuTFBxR1pyNGo3aVgw?=
 =?utf-8?B?a0VaS0QyKy9GS2ZBQTZ4S0t2OUFLTndoSDE5N29OOTV2STRKc3N3eEpmQnJv?=
 =?utf-8?B?Z015Y0NCSnAxZm5FM2lFc1QrY1czOU9QUzJTaFVqdUFwa25BNHN5NWEwOGtX?=
 =?utf-8?B?dldxZ2xGUGNSRkhjNlo4MVYxaDdxM1pMS2ZoTk83SWc1WDBZamdJc2d5R2tt?=
 =?utf-8?B?U040Sll3dW1GR3RJeEczRnRuT1pZR2tHZmNQamZxZ2FoMmFXZTdDQVZ1ak4z?=
 =?utf-8?B?TnlDNFJCSjg4OTNoWVg0ZDJ5WEJRcXUxUHhyR0l3RTl3SE01SVBldWZndUUv?=
 =?utf-8?B?c1lXK2s1Y3dGZWM4L2YzdHBYc1l2OU02QzBxMTNscFZEU1djTW1wYW1kN00y?=
 =?utf-8?B?Y0Q5ZUFSV0JTMk5TdlNCb1I0SWhxYldJa2dBVzRpbG9QWWhXTnpkeWRHamhw?=
 =?utf-8?B?QVhiMFFWSU43cVlLbS8wa0NVWi83NUhBbGoxNks5N244RGU3ek14eHJqbUll?=
 =?utf-8?B?TGNXWUlpd3NFNEViUkpwWGFnQml6MkNodnRMQkdzeHM3Y0pSWXRnZlRKbE9i?=
 =?utf-8?B?M1hRMDJ3TWRZcnZERW96bHJIRGRWRG5hYmZ2MTdLR3IrdjhXcmxpcVNlanlK?=
 =?utf-8?B?QkduRU1USHEva0lQNUs5bkJrWlpwRG84bkljdzFVWFVrc25QTWY3REZpZ2FO?=
 =?utf-8?B?RzQ3SlVYTTQ3UnZGTS8rRERsZVpWbk4zdjMwclI4Ni9RNzhkeXpqRmZLK0N6?=
 =?utf-8?B?UEJLK0xQWDVySzZEOGdKNGh2c1R4SHB2c0RoYVVNK2FFZUovU09kRXlvNjRO?=
 =?utf-8?B?YjZyRWtUTFNnUzdlMS9TSjlmMGQwMm1yaHF0YVJ5eXhkWFBUNGV5RE5wQlBG?=
 =?utf-8?B?QWViNmNZL3BjMkYvYmlxS0haMnE3eXZ1U2NNWXozajRMU3QvS3Jjd2hlZjU1?=
 =?utf-8?B?TDAvS2tnYkFkelV3Y1Q0WUZIWVhQaU9XbEg0aGxOaUEyZjlsckh3QVhPRnpB?=
 =?utf-8?B?RTZmemhFWUliYTlWVDhqcTl2ZjRmUFlvQWxLZEZCWWwwZ1dsZzRDUDQ1VzdO?=
 =?utf-8?B?OTBkM0xjTkZIUHBjbDF3cis0Z3gwR2JmekdDTU9zdEFUTGx2MGJCN3JtZysy?=
 =?utf-8?B?VVVTTFZkUWJicUJIem9ncUJJK08za0VWS21YdTh4WktRSWFWRkVoRTBnSXY1?=
 =?utf-8?B?U1dZaUx3YXJqUG1CUit0cVZncHRmNDNJaUVEM0s2Nkt0dkt2Ymx4eFVtMHlv?=
 =?utf-8?B?cVlDWFBvRmVvQXU5dmhrd29nUUFzeGhuQTBLZkRZUUxZaFViWTdzQzIralJL?=
 =?utf-8?B?RndCUmF4K1lmSkg0VlU3eVBzMkpUaCszTnUxSThSWlRFK0kxamI2N2w1c2dS?=
 =?utf-8?B?ZGliWUtjOUUwZU8vczBVZ1pLQVhOb2t5c0VWaWlBSTFjbXlEQmFxMlA4ZXMw?=
 =?utf-8?B?ZG1RNlBadzNLMnNtYmZTVmFCejJnWEFVRGVaNldKdWt0Qk1oallCSVkvUEwx?=
 =?utf-8?B?TnYzUDdLc2drUVg2N2V4cTZnTEZFWlFiTWpia28vSDFNdVNPaE5XcVBEaFdQ?=
 =?utf-8?B?WmZOcGdaZU5odnE3RDBkcUlTU25sbjI0TDdWcXAxbmFrSHZ3NUVpQ3dodXk4?=
 =?utf-8?Q?FtmYKNUsCRI9FlNmC3J3l7U2Kd3gBNe76loOlbyo/eGNr?=
x-ms-exchange-antispam-messagedata-1: tNhwNInhF6NdL3xhSMNyNyQcGkOTqLU1FsI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE8C13D0C0C97947A2225B9B1574B384@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e+6N6qWo8POAf5NdhZH9Lm1aC5/Up5MZRuZXLFkDoZhyIgKJi1f49ezBfot38fZlyASdLc7BRi4J3+A0JZ+pcbdLUhhhqW6sIngEaTdy4r0eDVMPFQdEO0vHwYjS23FxxwDfADoPgbKw7co6Kbre50VX26yhizjlcPqvolo4UZFeeDnjp/s4rUr7Ttqt1ZR06tJ+P0xNgiERp2Pj3opyNkaj+bGsRKHtf8IBVaqux1oCP0gK7XraRmUnZka8b4P3N+nka0Lnc4ob4WkXALtJS3gODjWAuBmaHew7fnHJnEMBPbpzxZ/WGKL49Zz5tDFoscZ5T56jVJQrvBSuFY4pCzLNnmKZRMG0UqKQX7GmrtuiVsOzci9x2UrVhisZ80ZrcP/qrPgjk1qfx5b4oMdm4ESAv1aQTxQ8EH/IHV7nKiPvf47vY6EjfOOlHOVpRgOXF5oTy0zdaHvpWVa/4M+GrCGqEGeBdJpe1BVFXDrUtmzrjwHeLXhV90LR1H2cTHeQkXljW3z4FI0I+RACbYq6u8Dr8UgtQBHRv84Fq84qcj+sG44fp6k9CG4HJhS+McJLLmRuo6/EplGnyyJJPdrTbD4sh+u7Ys730eoyUeD9ZYxCt9zXC9xPNIGEn4i3X2T8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8987.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8f7491-0f11-4244-8c92-08de790459a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 09:07:52.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDJEsSCW55gCcWXRPvm1bsxKudcC+Y7jYIrNuYra2PkJdaBDQqGuA0O7YFsim+OP4QS3PM6q8J5n1ii1fy+GTEhg/Eqc9D3Z0l+HdoOAlxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7120
X-Rspamd-Queue-Id: 033F51EBA2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22173-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,wdc.com:dkim,wdc.com:email,wdc.com:mid]
X-Rspamd-Action: no action

T24gMy8zLzI2IDg6NDEgQU0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiAzLzIvMjYgMjM6
MzksIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IExpbWl0IHRoZSBudW1iZXIgb2Ygem9u
ZXMgcmVjbGFpbWVkIGluIGZsdXNoX3NwYWNlKCkncyBSRUNMQUlNX1pPTkVTDQo+PiBzdGF0ZS4N
Cj4+DQo+PiBUaGlzIHByZXZlbnRzIHBvc3NpYmx5IGxvbmcgcnVubmluZyByZWNsYWltIHN3ZWVw
cyB0byBibG9jayBvdGhlciB0YXNrcyBpbg0KPj4gdGhlIHN5c3RlbSwgd2hpbGUgdGhlIHN5c3Rl
bSBpcyB1bmRlciBwcmVhc3N1cmUgYW55d2F5cywgY2F1c2luZyB0aGUNCj4gcy9wcmVhc3N1cmUv
cHJlc3N1cmUNCg0KT29wcy4gTS14IGZseXNwZWxsIHdvdWxkJ3ZlIGhlbHBlZCA6KA0KDQoNCj4N
Cj4+IHRhc2tzIHRvIGhhbmcuDQo+Pg0KPiBbLi4uXQ0KPj4gVG8gcHJldmVudCB0aGVzZSBsb25n
IHJ1bm5pbmcgcmVjbGFpbXMgZnJvbSBibG9ja2luZyB0aGUgc3lzdGVtLCBvbmx5DQo+PiByZWNs
YWltIDUgYmxvY2tfZ3JvdXBzIGluIHRoZSBSRUNMQUlNX1pPTkVTIHN0YXRlIG9mIGZsdXNoX3Nw
YWNlKCkuIEFsc28NCj4gNSBzZWVtcyB2ZXJ5IGFyYml0cmFyeS4gRm9yIGEgZGV2aWNlIHdpdGgg
dmVyeSBsYXJnZSB6b25lcywgdGhpcyBjb3VsZCBzdGlsbA0KPiB0YWtlIHNvbWUgdGltZSBhbmQg
Y2F1c2UgdGhlIHByb2JsZW0gYWdhaW4uIFdoeSBub3QgaXRlcmF0ZSB0aGUgYmxvY2sgZ3JvdXBz
IG9uZQ0KPiBieSBvbmUgPyBJcyB0aGVyZSBhbnkgYmVuZWZpdCB0byBiYXRjaGluZyBsaWtlIHRo
aXMgPw0KDQpJIHRob3VnaHQgYWJvdXQgbGltaXRpbmcgdG8gdGhlIHJlY2xhaW0gdG8gYSBzaW5n
bGUgYmxvY2stZ3JvdXAgYXMgd2VsbCwgDQpidXQgdGhpcyBwb3RlbnRpYWxseSBsZWFkcyB1cyB0
byBhIHNpdHVhdGlvbiB3aGVyZSB3ZSB0cnkgdG8gYWxsb2NhdGUsIA0KcnVuIG91dCBvZiBzcGFj
ZSwgcmVjbGFpbSBhIGJsb2NrLWdyb3VwLCB0cnkgdG8gYWxsb2NhdGUsIHJ1biBvdXQgb2YgDQpz
cGFjZSwgcmVjbGFpbSBhIGJsb2NrLWdyb3VwLCB5YWRhIHlhZGEgdG90YWxseSB0YW5raW5nIHBl
cmZvcm1hbmNlLg0KDQpTbyBpZiB3ZSBiYXRjaCBhIGZldyBibG9jay1ncm91cHMsIHdlIG5lZWQg
dG8gcmVjbGFpbSBhIGZldyBibG9jay1ncm91cHMgDQoobGltaXRpbmcgdG8gbWF4IDUpIGFuZCB0
aGVuIHdlIGF0IGxlYXN0IGhhdmUgYSBiaXQgb2Ygcm9vbSB0byBhbGxvY2F0ZSANCmFnYWluLiBQ
b3RlbnRpYWxseSBoYXZpbmcgdGltZSBmb3IgYSB0cmFuc2FjdGlvbiBjb21taXQgY29taW5nIGlu
IGFuZCANCnRyaWdnZXJpbmcgdGhlIHJlYWwgKG5vbiBlbWVyZ2VuY3kpIGdhcmJhZ2UgY29sbGVj
dGlvbi4NCg0KDQo+PiBhcyB0aGVzZSByZWNsYWltcyBhcmUgbm93IGNvbnN0cmFpbmVkLCBpdCBv
cGVucyB1cCB0aGUgdXNlIGZvciBhDQo+PiBzeW5jaHJvbm91cyBjYWxsIHRvIGJydGZzX3JlY2xh
aW1fYmxvY2tfZ3JvdXBzKCksIGVsaW1pbmF0aW5nIHRoZSBuZWVkDQo+PiB0byBwbGFjZSB0aGUg
cmVjbGFpbSB0YXNrIG9uIGEgd29ya3F1ZXVlIGFuZCB0aGVuIGZsdXNoaW5nIHRoZSB3b3JrcXVl
dWUNCj4+IGFnYWluLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+DQo+PiAtc3RhdGljIGludCBidHJmc19yZWNs
YWltX2Jsb2NrX2dyb3VwKHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqYmcpDQo+PiArc3RhdGlj
IGludCBidHJmc19yZWNsYWltX2Jsb2NrX2dyb3VwKHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAq
YmcsIGludCAqcmVjbGFpbWVkKQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbyA9IGJnLT5mc19pbmZvOw0KPj4gICAJc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNw
YWNlX2luZm8gPSBiZy0+c3BhY2VfaW5mbzsNCj4+IEBAIC0yMDM2LDE1ICsyMDM2LDE3IEBAIHN0
YXRpYyBpbnQgYnRyZnNfcmVjbGFpbV9ibG9ja19ncm91cChzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3Jv
dXAgKmJnKQ0KPj4gICAJaWYgKHNwYWNlX2luZm8tPnRvdGFsX2J5dGVzIDwgb2xkX3RvdGFsKQ0K
Pj4gICAJCWJ0cmZzX3NldF9wZXJpb2RpY19yZWNsYWltX3JlYWR5KHNwYWNlX2luZm8sIHRydWUp
Ow0KPj4gICAJc3Bpbl91bmxvY2soJnNwYWNlX2luZm8tPmxvY2spOw0KPj4gKwkoKnJlY2xhaW1l
ZCkrKzsNCj4gSWYgcmV0ICE9IDAsIGl0IG1lYW5zIHRoYXQgYnRyZnNfcmVsb2NhdGVfY2h1bmso
KSBmYWlsZWQuIFNvIGluIHRoYXQgY2FzZSwNCj4gc2hvdWxkbid0IHlvdSBza2lwIGluY3JlbWVu
dGluZyB0aGUgcmVjbGFpbWVkIGNvdW50ZXIgPw0KDQpUcnVlLiBXZSBhbHNvIGluY3JlbWVudCB0
aGUgc3RhdGlzdGljcyBpZiByZWNsYWltIGZhaWxlZC4gQm9yaXM/DQoNCg0KPj4gICANCj4+ICAg
CXJldHVybiByZXQ7DQo+PiAgIH0NCj4NCj4NCg0K

