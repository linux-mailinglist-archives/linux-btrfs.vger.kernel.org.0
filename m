Return-Path: <linux-btrfs+bounces-19283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C38C7F23C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 08:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7526345CEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105D2D0605;
	Mon, 24 Nov 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jsS/fQlH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OlmHQW7r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2326ACB
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967703; cv=fail; b=SBv8WD+T6laBF4tglqSpVkcehuleyom6Ss8gbr0f4iDYs/tLSo6Y/ey12Wzw1wW1laGEBNonuVkqj6qn9eOc1h/WDVEVBKIkJenS6fehMsQ7AuaFxQpPKOc3BxajSaY4em2pHDWQotKf/W62djObiCmczanwTxxLX8q15D34rEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967703; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mLJ0QR4CE5KDmIdTV1ITYrKE1jUGYcpHUrYcZRvNxWGduxT0cCE+K/6QVXMePSdjEyV1Jl5qmtvpUzI6svXKnoMSlVd0eVy3eEvVsyG34c9HRQ6xdVf9Je9ZaD380Pw0Kb48Oz+WXeyF6dMfRehc83/SQIDlisBRMA1Wiqw8uIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jsS/fQlH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OlmHQW7r; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763967701; x=1795503701;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=jsS/fQlHoTG961V2JXTVyMa63rItiX8Bli3PvqyEkNRU2lWQGhSdbQmI
   j89T1lhrUovWBKMfPcJvC9f9iHb3P0vA6JkChTDH4Nqs8q27NfI2r1Ome
   3rgdaYnfdXh0+rn7B9JN4ZV5Z57hihMJF9MUH2b+v2qAu5HCVb84bGmOF
   c3eSjQWpGgMqQq7trXkSrPXIqWeRYw/rrNj3d/bkRIM4qEq2az6DFdDdq
   fC4mPQz3+PckBigTjHfifHQXPffpPjBThTqFL6jTXw5CzWVn8Tdit9793
   uzPp8CdzC0fu9Wo/TDEeUmIquCmWMUW/Vh+MTv/7u16l3DXd8lya8T+oP
   Q==;
X-CSE-ConnectionGUID: jgVJSqmvS3eQKdxPaBuJPg==
X-CSE-MsgGUID: gy5I3KHeSsa0X3LF4qnv9Q==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="135667281"
Received: from mail-northcentralusazon11010020.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.20])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 15:01:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sxf4rNEcTWWsZHkQbOg5rS880TRD8nbgsfxEDhbB+LtGJG8G6bYDRG+ztXA4Q6vBQH8SSbH33v6EzOgZDhF+4HQYrmA9LK3tyr3aSYjjbuhu0vbWljVoXvlLKEPcImQkS3wrfYGg/gJDvU7/UafFlML5B3Dwovt3kDROIW05BO+hViofX/XhXu31KYy7E3fMasfaV5rEC3GRt+hPMV9Z4+PEHv57z6waZ2PDbIEP5GbGns0fP00lpvqWLdYelsRbiZWdLN5+vv2cFSuJ2aU0ebT5wmdJCHRj7u70N/ZU80OTQ+ekvuK5IZ0IWYq3kVrW/FkgkZ8qi+Yr5jD/GmN+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=KjvgdkDxIrqBwp9lKZyQGqPr12X4cIFTMFDx+/rWxPTXTRuRklWHJSJWiO7h8MLmMP4uJLpd1fNz55yHhuo8mHis0s4u9DMcd5sYAAeFRKVAEoWo1Qbf+cIjqUq/vdphHM1kYteMMoUZ0V4iJnrxeCxRvtD7MUHu8tf20pzlxuognbkXeXI2mXANgmzM6mYG/51udVwKtZV7/5id14FQGovSsfTMwRJgF65ot2JnUkWDyLBdZGG7PW4WOZt+aFeUvPxVqWHe7r2XNUvy+BZsTQWwu0I1I71fwWNC6hd9ZQbG2LSLgyh604kx2S3vW+MQxFGZFQPTnrZbVlxZqoL7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=OlmHQW7ruqCHorZasi/6dD5t44VaGeizm8g3kMUhOsx3Ux4TJ6rrYWQpzS2OwFcf6gR1Mn5S1/vC2JDH6s+CsPwVdKKilCpIXATUVnqpLPHzrJsnxtN3LUobRz7dktrbeuUKh9ND+tucQiBEukGUYn9T7K22JkxavHWkx+EElUc=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB8513.namprd04.prod.outlook.com (2603:10b6:a03:4e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 07:01:32 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 07:01:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove unnecessary inode key in
 btrfs_log_all_parents()
Thread-Topic: [PATCH] btrfs: remove unnecessary inode key in
 btrfs_log_all_parents()
Thread-Index: AQHcWwu42iT8u11ylEG7APOfHU4odrUBajwA
Date: Mon, 24 Nov 2025 07:01:32 +0000
Message-ID: <a5ec3a72-66e5-4c7d-82f5-dc167b209a12@wdc.com>
References:
 <d52f0087209f98c146645cea0fd3f1ab29d29a3b.1763745035.git.fdmanana@suse.com>
In-Reply-To:
 <d52f0087209f98c146645cea0fd3f1ab29d29a3b.1763745035.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB8513:EE_
x-ms-office365-filtering-correlation-id: 22a71049-ed5c-4f1a-692a-08de2b274ce7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXgzZUFtYzMweVFJTmIwbi91VldLWWNaS1VnMzJUNmZiTDFaY29ITlJ3WFZ2?=
 =?utf-8?B?ZXpTU0JRLzY4NkY3TDA1QWNqblh3ME50elpOTUJuYXEwSEVKU0dtSnJCK3hI?=
 =?utf-8?B?VlkyUlo1ejZyV1BEOVNqV1R3YzNMSkJSK0NTSGgvcGowWnRuaXFIWGllaW85?=
 =?utf-8?B?T0xuc1ppWUlHQ080Tjc2SzFmNUM3Rlh1TW1HQjl5Y0tnalpQck9zY3lGV2tl?=
 =?utf-8?B?dWRMZVYwWERNNk9BOFJZMHlaQmRkUFlaYlpuZjF0NUhZU3E0bE92ajlMZnBy?=
 =?utf-8?B?L1ptMHkzcHoyRGFBRjZxak9SQ3NsSEFQNXRPNlpuMnQwRjF5M3Y1ajJmZUdE?=
 =?utf-8?B?cmJZM2FleE9CeG8xbE5LdmtjUE1lU2dyMEJOT0l0dHB2ckNBU1RwR0QrRjJq?=
 =?utf-8?B?b0tTSW9PbVpjZHRTRlNMcUNIY1dkUVV0NkFWcVRmc2p6YVBSS2VZNzZReU1k?=
 =?utf-8?B?WFBuZ2FGY3ZRQlhBV3NsZUZrby9UZ0xmbSs4dzhSMU1NU01QYXBuYWo4T0lm?=
 =?utf-8?B?U0xPQkVMTDF0VUc5b3djb3pJZThQMnVzUTk0SVRiK04zL0liR2lHRlcwYkh1?=
 =?utf-8?B?a3BRbWpFVEhpOVFVangvMmgxaDhIckc5cnRoUGZWc0FBK1dXei9RbW5xalpZ?=
 =?utf-8?B?U2dacHBydzNFNVR3aUMrQmh1c0R1SFhTSmdieWNEZFBEVkxCeXVDK2t2OFQ4?=
 =?utf-8?B?bWZHQ0JhMTBiWFhuSEtiSVBuVlBkZkVEV2xHbWFRZEVEK2pBdUZvc25lQ2JC?=
 =?utf-8?B?bnkrdWh2dGNuYVhadXcvZmhLOWh6eXJrak5iWGhpRHJZdTJqRTZYdUs0N0hk?=
 =?utf-8?B?T2JxMTF2V210L0hhcUhhTnYvZWRabVNxeVZnY1ZMZCtoMXRlbldxVU1oZUFN?=
 =?utf-8?B?cnlxTmtnSUk5T1VZODUwQk5mTmdVWURkVEFVMVdITzNEK01PNVVzYllVQkto?=
 =?utf-8?B?a3Fub25STUdEanUyVlBxUTE4S0djMlFYZGJ3U21IVTRpT051dElJWStWNGg3?=
 =?utf-8?B?cGZCdEdDUFpIMFVJOW1WSE5VKzJRS0FEMDV1Qi9ZbG8rRXNITTIxZlFDbC96?=
 =?utf-8?B?d20ycTVqVmtiLzBjeUFIMmlSQmhac1kwYlMweTNpcnFabExNY3NFRk5ZYXF3?=
 =?utf-8?B?T2VWQnBGV2VtbU5mVDVHc2cyYUUzNC9wNmdUZzk1bTFORk0vZHQ3R2NIKzV1?=
 =?utf-8?B?Nm04akVGTFNTYmo2N0xpa3V5Wmt0RE9rVkpZaWN3bC8wQ2dWL3JZQzRRYW9H?=
 =?utf-8?B?TGtoZTl5bHJpVUVrcTdWME9aM2FyZGxSTWsxUjFDMG1QQnlIYUx0Z1FIeWNH?=
 =?utf-8?B?SVRnREM1WVlFK0REb2xYUFZ5RE1UcExwZWg0NTJRVnl0Tm5vbUs3bmRRTmhm?=
 =?utf-8?B?UVJ4TDc1MGRNVGl6T0JCUGFNeEpxMDFVUnU5QXI5aUFWdWozVmZMK0ZIc3dM?=
 =?utf-8?B?WkdNU3duVEluM1ZxOXNVOERWSGZ2dFc0a3U3enU4MDJEdGowNGZpMVpsU2hZ?=
 =?utf-8?B?L1g3RXU1cDFGY3FJU2JRdkxIZ2lQUUd0eGJjaDJYeWFDS2kyMTdPTEhrbDc5?=
 =?utf-8?B?QzQ2dm9GTy81ZTNGWmtkMXhCblpsUXhSR1NTR0w3QjYrU1VJeWlnTGpCa2l5?=
 =?utf-8?B?Rk5lSjFSLzBFNjhkamcweTRQMEp3UGUyKzRTcTc3dDdJeUpoaWQzazJOc1Y5?=
 =?utf-8?B?WFBrazZUOUhZTXVZL1JjeHhSRkNoTnROeDh0ekNPL0VMTnVLMTdrcWpocEtW?=
 =?utf-8?B?Um8zVzRlVHhiZ2ROd1U3elBFYll4ZFJIcDE2QythVmdKdHBRK3VQRmpYOTBv?=
 =?utf-8?B?VHFrTXlNWG9QWkpXTWw5SkhOMmZ0QkhPUVRxN2gzQklZZjlWa0NoaXVpMkhk?=
 =?utf-8?B?dUVPU3JBVUNoblBPTzR4R3czSDN3YUFMUFFuK0ZwQk9oK0hLK1FlZTNndDh0?=
 =?utf-8?B?RGFWV2d4ek8rNmlCZ0FSRlF3N3RPSlFFOTdEWVN6YUo5UUovaFBzNHAwOHhU?=
 =?utf-8?B?dHUrMWpjNngwaktLU2ZLQmhxMFVRL2luRUd5SnJuMUpRd0dPbzRwK3VrTDB2?=
 =?utf-8?Q?78ZlxV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmpROURQQjhneEFNcWh6MGhYVHRoSGVUbG5TNmJmWitaZVJlaGNuTTVFTzlj?=
 =?utf-8?B?Nm1idEtwSzBiamhlT2pISmpIYVAyOG1OOVNUM1lMTkpQbzdYaXhlVjNhNWdq?=
 =?utf-8?B?WUpzTnNFRXNrTy8wbTBRZytVN1ZHdWw2ZHliN2RVVzM3NVdhdmtyUGVoTzEz?=
 =?utf-8?B?NE5idWUzaWtaaitTTWNsVUJoOFBXYTUvemYrbmEzd2VYSjZhTXVURzlNTDBW?=
 =?utf-8?B?NE5pZ2x0UE1kaHJqZDB6UVA3dVR2ajdvbGM2b1FwMWZrQURIVkErZkdyZlcy?=
 =?utf-8?B?UnpXb2V5TWZPVXR6MElyeXIyY1l6L2RMRWw5Y09ENC92RGZYeGVGU0JrVmxL?=
 =?utf-8?B?aEI3b0s3Unl5bGJoSkU2Q1NFbSt4T055UHZjM1dTVGlIVVMvcldEbXZubEp2?=
 =?utf-8?B?bHlhekR5MVFvb2ZlZ0ZKNExRdXVvNHVETCtIVTVNYlVrR3Nuem1udE1DUGww?=
 =?utf-8?B?YkFqVndiK0J4S0JoZ1c1UGJoS3AxcWZtUlRaR3BJWjV5bDk2UXloV0p2Q2FR?=
 =?utf-8?B?cHMvZ2FYRHdtYVEvNzVKNmF5alJsRDNnY0dZdTRaaHQ2L3doaDdKMGhiVkRr?=
 =?utf-8?B?STJ6V04rMzhUL3dnTkczS28zTnh4WFpBSjRZenBxRVZlaE16QVNnRUg5eHRk?=
 =?utf-8?B?NE1DR1Y5ZkQ3S0lHOEJ3UTFUY2dzQnk5dVdtN08vK1NsOTA2ZmVGVU5GWVRS?=
 =?utf-8?B?Wm13dWNpL3hRS2FFYXdvZjgzM01RSmRjY0pjQzJ2dG9ab1RzcWgxSnNvcW9X?=
 =?utf-8?B?QlhWVkFPZWZIcWI2TWc3ZXJ4VXIrN0ZpdFhKeHNKOEF5YlhFY2FES1pyMGx2?=
 =?utf-8?B?ZkdrcjlrZTdqa2pzNVFiWm9hQjYvK1dLWU1tZW82VUhvSUhRM3ZtWCtSamdz?=
 =?utf-8?B?MUE3Qzk3TmpMYkpVM25iZlRlOHMzZnl1NFFIV1EweVh0bE52S1JtK21HMW94?=
 =?utf-8?B?QngxV2hKdVRPVmJ6c3NJTUxwRUZPMmlPRU5MT3hOK0FDR0NmeW9xUDVKM2NX?=
 =?utf-8?B?WC9EODRkRWpOY01hYnE3cEVwSXljTnFTQVQ5NnpnQ2R6QWNJMjVYYnlUTCsw?=
 =?utf-8?B?YWhoZHZsUUZINUxxRllLcEdSSXVwZyt1NUtnVTJZUFhDdnBiM1BKYklPNXJB?=
 =?utf-8?B?bDVKMitodmlSZ0RyUUZJUnNKZitBcWJaZFJPbHdCelExR0VsektoTWw4dmNT?=
 =?utf-8?B?Y0tUQi9mdU1SbklMTTRzay9QY2NodTVLcXhsWWhrOUpmVWxGclFmbk44VUNQ?=
 =?utf-8?B?SnVHTDM4RUZlTXJMV3lyZ3ZCYUhaK0NMc1hNQ1llSDBUK2E3NEtiQVMvdHhZ?=
 =?utf-8?B?cUV5c2hsWVpRaGd3NEJ4ZEQzWVh4Ull3aWhLSjFQaHZYQUIrYXFxeXRYSG5J?=
 =?utf-8?B?c0xja3NPM1JSMzZrT20vYzk2R0FFTVZTZ1BUOXNQTTNva0ZHMDZTMXU1cGo5?=
 =?utf-8?B?djg5NTk3eEVtcjZzUW9tSXlXYnNZWXlaNWFnVC9jS0xaUGVXd285eFBPOGpw?=
 =?utf-8?B?eWVheUtJS2lqMXFRS1djTDlFRXo0V1JzWklyQzVlbUgwMDJkanBtT3lia2xr?=
 =?utf-8?B?YStNOGg4RnVnbTFqYTNHNy80RG9IUVlDMDlwTndseXRyVkF0UkVlTHRVQU9z?=
 =?utf-8?B?dXNLWG9WdlI4RWQvdnFLbFRxSUFBUHkwWVNwOFd5YjNRYUd3aHlrQXpwbFl4?=
 =?utf-8?B?UzhHM05XWGFuSjFGVGtDbDB1MEtkWStsTGhQUWx3ZTYzOVVpLzlXMm9Jd04x?=
 =?utf-8?B?aERZRXNMdXVNbWlYdTFpWlpxSnhyV05OYzJEd0JZenkrY2RxekRHMzRzUWMv?=
 =?utf-8?B?VzhHazRDb0h2KytKQUs4c1JRV2NLc3FrZ2MvTzhKbHY5OCtFeFR5T2NLQm9x?=
 =?utf-8?B?RVhXM0NGajZmL3FIQTBweUFXOWxNa2RHYTlmNDF6azI4R1l6Qk1XTUxvRUZk?=
 =?utf-8?B?MkF6OWlIUDBmL29pVEs4RmJ6TnZheWRJaGFlY21qKytzb09aZ0NtbEFpQ3FP?=
 =?utf-8?B?dGVLU2VoaWZVcm9vN3JHMEE2Mm9RdGRZY2RKZzJKZG5GSEdVU0NjYXdDb0NK?=
 =?utf-8?B?YW1ucGlXUUhVQjNZa0VyaWdCaGZ2ckEyTzdMOW1XeUNvaTRxQ2dqQW1FNFJi?=
 =?utf-8?B?YnorTW5MREJoS0svQXFZdHBodDlzWXgzWkl3WUcvM3U5R21YYjlvY1J4NGFY?=
 =?utf-8?B?QjJ5L3RyZTZtZVNvNjA0RlVyQThaZ3Ztb3RBei9jUUcxeWNYQnFqcVEyRlFC?=
 =?utf-8?B?a3BXUFJ6Z29CWUswQkl2a2lqOEdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FD344748D8CDB4FBB18DE32E22C1C76@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u8R35z3v+zQUKWawJBC5ZWVpzBmj8tHP9qVWPozgWWLWRwOO7qNPP1NNWRG3uT5YxkiIgwF9XDyu500LhmfcMCYnfGHF4ASCPbc7PpoVWjIt8rCcLXnpMonw10GCw3NaijTAW06HeJwvxHTYzP6Eu72k5a/JYnnbvRabFQO4VdaycX2oOSek3GsLSRW2CX+C7jsMjAXrD7jlxR9hG6L1F1W2auhC9luG3Q0F6zZtyQUepmPmCy5HRE/Uce3nC3ZKVJmlTgPPMpuuPx2SHavg7glJbTtG2fcvU4YV9lc3O265sQni8wNzmgS6f59Kmfp6ZYyctPsJkGQhuQXwi8ep941gy/F8Z7D1KItaVQeooDin6clwGPwR4ZFMCISySDJgHhf8oM7WIPH0gLkD99GEwaCeZcjcXDPFLyJmBFHG+7Gc9XGyTYFyV8TnFQuB8iMyRkgLAd+ugMEGbO/a0/KbUUD+FpDRswX9VlQsEL8cb8NbcB7tPEDnHUJDLHt06h/AL9thn1imV4Pp7cx8M0MURbtVT0s+GvVbCcFxOe2V0ugVt5hIkvqOpKN6Rpa2EltL9g1WAAk41mrTY1c55eGRytkiFqHAayKM67HXCKFO+0hlzNb8wzYp+dFPC2AfX5I5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a71049-ed5c-4f1a-692a-08de2b274ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 07:01:32.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSQ6ppIuC93skfQBN/alZmqlOsIB4P8UgUFkK2nO1U9c+Iawntm3ZBa0aLzAgoxKboIbYi7bxEtrRykm4VONFgywSqWgjdx/m5tdUxYeKYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8513

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

