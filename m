Return-Path: <linux-btrfs+bounces-16617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4AB42FF6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 04:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE4A7C1882
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA041F869E;
	Thu,  4 Sep 2025 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fg5LYMZt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HF2+klZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19CE2BAF7;
	Thu,  4 Sep 2025 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953940; cv=fail; b=ed/4t1gaRRo+SXhmxewEMivkWv4s0+f7QSzq9ioIw+sVSziOvxBB/diKIsTppdOSTNmi+oAzQbg8XWnNgC0SVw8GKVdqvWTOteWv7e/pDJxKzL63skvZsXdVBf27145ZAJC5pKa4ok+Zxo15fOPFZMjZVOfQ6oHpIMdmq2kF2Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953940; c=relaxed/simple;
	bh=oNFwopmFhDSwBuaxwEUgYaCfH6afKmMBNH6bTxDWvEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSR+ceSo0IK296CQtjF7vm1bV4gioDiHUw68bQQ4pMgNV+GwqWhA0b3PXQlD0VCsH57UDzXrdLpjGRNSVo8HqXysEmrM0vDZueIfdEOwYI9ZsA+xdVoEkazu7v2hsClOFpf4go23QmKUeXbBh0NOrwQzchEnpcjV34kv1pxq230=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Fg5LYMZt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HF2+klZA; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756953939; x=1788489939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oNFwopmFhDSwBuaxwEUgYaCfH6afKmMBNH6bTxDWvEA=;
  b=Fg5LYMZtF4Xj01TMffWYyuOnntImqW5ea7hT5DQhdtAM85AKer8jfWN3
   7DJ24cXG3JZdYREJ33tEZnqPFcYOq9T32pV3lRsLcCTh2t2YPY7LyJc54
   mWOAWJhw0awfepLpfzYV0hp+5dq9NP+aWpyvZwtijGFJJJ9CIYPZWJpr1
   ZrYroGvn5X2f8KKebLqj0x6dp9noyIiOUWQajqF/oAuKefD96pseQWOGW
   CoGi1QBiZ5YFm8XZQz0tXXjHP/qCAcSM0sjK4ALnS5uHMJo+ezX/FkLdh
   GePjlhWGNRe6Nc/aImLUr5NiQ2GR65+Mwc4RMO4qzrc9Ne6rOlz/hd7nn
   A==;
X-CSE-ConnectionGUID: 7WHuIAIdSAuxQgWRJV//XQ==
X-CSE-MsgGUID: 8hA4FB3XSTmdybZ7tJOHZA==
X-IronPort-AV: E=Sophos;i="6.18,237,1751212800"; 
   d="scan'208";a="108093550"
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.48])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2025 10:45:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOLBoJrBE6TfeebLrYSilRR0/pbbyAy1QJBhnnJNz26q9W8JRcXMM7Fv6B4+BvMUc7H43wIPJbWZnQgHzyZ9T1lZNQ0WIEE2+jUl7wpoFhGeB29iETi20aI9+UemBnwBqPdq3/Cf4JjHxETdoAADkzXRaFEB6E7knokF9vwxPAhzrnU2Iene3K+f9IvjlMN1d13JhKv691NgqX0Rrh84u85f+qjz8iuyH4QWaAWur8v/evFup1wPTg47Kq6uM50mv/5X5Yx368rZIXynoMTyGBZ2UN9aiVra5z0nMPPitYlsr3W2L6osrcWacPhka0HFv4970rU7VQjfzHSv/y7XlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNFwopmFhDSwBuaxwEUgYaCfH6afKmMBNH6bTxDWvEA=;
 b=hKhyen1ETGyDIRvDsS+qcaN8cHQPXto8xacu96krjseDQ9UkIda5vFciHPw00sjC2I08uL8oPy4hhR+s7kQAjWmcVFQwpGh9TEdyWQFV4ahK5R79fvUzLs+CCi0q3ZGuAXY2GIt9bJhd2DfHvk1Ycv3tzmPlgauIq1sM8v0WiJeR6pLfC+BS8Q+QSTNozbbKZ4SryTDIesn0N+S6ZM60S1W/pHq6Y2PF935TCdfEixubAvB4k5KmLZVQetkUpa4s+Uq1giaxNIQZRg5A5/sZcdguHzshPZihknQoeKrqgnVhx7pCvo8EyPoWgcBRks/pJM8XzWtugqEcudD0iCqYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNFwopmFhDSwBuaxwEUgYaCfH6afKmMBNH6bTxDWvEA=;
 b=HF2+klZAwcY7HwseZoVLTGVVt9zz1ByTdjKuTAcNCymnSUp1/DB4IFWx/aKiqPuK/6rzHJHTpnCH8eHn6BycQnjgmGw0uMPppIVQeoimJOBvCky3VRdAzziTW5J3R8CTJki9nJ4JJy3mcQsictEZ6vsxyXIRjuT+rAramplWvEg=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 PH7PR04MB8579.namprd04.prod.outlook.com (2603:10b6:510:2b4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Thu, 4 Sep 2025 02:45:29 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::44cb:1bf9:cfdd:4f0a]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::44cb:1bf9:cfdd:4f0a%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 02:45:29 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Yi Zhang
	<yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report]kernel BUG at fs/btrfs/zoned.c:2587! triggered by
 blktests zbd/009
Thread-Topic: [bug report]kernel BUG at fs/btrfs/zoned.c:2587! triggered by
 blktests zbd/009
Thread-Index: AQHcHK3hkL0cKyelZUihJJBif5Y+sLSBRQ0AgAENa4A=
Date: Thu, 4 Sep 2025 02:45:29 +0000
Message-ID: <DCJO6GJ7H90Z.3SYDHIMR3XAZH@wdc.com>
References:
 <CAHj4cs8-cS2E+-xQ-d2Bj6vMJZ+CwT_cbdWBTju4BV35LsvEYw@mail.gmail.com>
 <44be7089-cd6c-40db-95c7-b31497afd5a0@wdc.com>
In-Reply-To: <44be7089-cd6c-40db-95c7-b31497afd5a0@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB7765:EE_|PH7PR04MB8579:EE_
x-ms-office365-filtering-correlation-id: 040745a9-f3f9-428d-bce9-08ddeb5d1c0d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZCtvN1RMVEtjaVA0aXpBUGJPWHh6ZytXckp5akRHNytwQUwrbHRsRkdvWEd4?=
 =?utf-8?B?aHJBSnVBM1lFNEJMNGh1Z3M1UkRKVUx4djlwbkpQUXNJWGhtQTFFdGRnbTRu?=
 =?utf-8?B?ODhiNmpGZjAvL3haK3JSRXcwa01FYUFYb3lqeUUvZWdjSk12NlROS2ppbTZj?=
 =?utf-8?B?UXd6elJDeVJkOEdWd0xvOGRwYXQrNVpzeDZlajFjZUIybDBYK0VYT25sbHdn?=
 =?utf-8?B?aEdua2crQUVhaTRBUXFkRyt4NVRSQkI3N2RYbGxVRjBsN2MwM21EZm43UEJQ?=
 =?utf-8?B?Q0l3YVhnRFlldStlcG9vTzEyWjBJNHA4VWhvY2NKN1plTUVJMnU1ZTY5cnRV?=
 =?utf-8?B?VmJSNjFDOHFGS2xkS21najFaVzhOTStmREY5VzBCSDFQSjVXeGZwaVc0QkFV?=
 =?utf-8?B?aFBVQ1lBNGtFSUJhKzZwTG9CRmV5TnBFY3AxT1o5c2NDci9QSXZId0JLTVZK?=
 =?utf-8?B?YlFVU20rTVh3Z21IQWlpUU9RVitzdjh3S0dWVHNQZXJHL1pCUlBBZUhXRnpM?=
 =?utf-8?B?aUJqNkV3TnVQVjl1eU5MUUZHMzdteVhnK0doL09kZ2N1RlI1YnpQKzV5SkhW?=
 =?utf-8?B?V0hGcHRGbGppWjV2ZzZpMjRZcEcrNGkvT0JvT1RqQ2YwUFNjZEhiTlhSWUdG?=
 =?utf-8?B?QVYyVjYraUF5SmZmOEoxNjJyUXRUSGNxZnZLeXFhdGo3SEpjN0VOOXYxeFdx?=
 =?utf-8?B?eVlzT2ZYVStOR1doNENRb2hhV2xncU5UbDg2M3FPK0JJL28wUDB3R2VMRjJR?=
 =?utf-8?B?NEt2NnFuTDJFT0duR3NDQUpBY1ZMUFh4WnBhS1hmRTRoVmY5UFNxM2d5Vm9V?=
 =?utf-8?B?TjFaV0hucVd0bWRhYU0zekhhT1pyN1NvenZ0ZVk1Z0tRYlhNM2hNZ3JxajhD?=
 =?utf-8?B?K056L3lSRnJ1eXdhMDBzSTBkOXlRYmZQRWtjbjg5ajdxWDJTWlM3NXNmbndq?=
 =?utf-8?B?RzFGSnJKM3M3MStZYk5KWS9zMmtDZGhsS3MzVUhCdUJaSityU0QyT01rVXZk?=
 =?utf-8?B?TzhBNUlGY3NHdm0vbFRQbzFhS0FkWUMyYTR1TmpFUHF1QU00SW5wcE1lMzUz?=
 =?utf-8?B?TkVlbU51bmd2cjdIZDJKWDMvRU9TQmFaRlNPVXdtZTZsbW1mYmh5cHpabjhR?=
 =?utf-8?B?dGVRUDZtOXhSeWt4M0hJYi9jSTAwcnJ6OE9oYjd4RVJQNm5uOFd4R3RhTGhh?=
 =?utf-8?B?L0EwdnJjRWJOWmYxOU80WnhJUEtpWE85a3hIN1V4bE10R29zSEF0clphMXo2?=
 =?utf-8?B?ckVXdFNHVjlJMWpLN3pRUkZLelV0bzZEeTZ3YXVZREsyNlBhaGtGRzZ3VUtq?=
 =?utf-8?B?VzhmR09qOENEVlRTcE5mY2pJQkkwYlRRczMzRVdkdHFNZGJYVVdHK1BOZWd0?=
 =?utf-8?B?dGJ1MHY4TmloUFdrWCsyRzBHSk0rMUM4dzZGTGtkWjQ1bW1qYVpPM1NHMEFV?=
 =?utf-8?B?QmFHSDdxL0ZGRzJTWXBMZnJBY2Q0V0tFUk90cGJ3bmdPdzE4VG1Xak1JMjF3?=
 =?utf-8?B?ZlFZeDRXM3YrZ0dDbU8zYmRxVmpSVU9JRHc3VHJhM0xRZlYyblZoRGp5blZp?=
 =?utf-8?B?NU9EWTcweHl5dkd2ZGExay9aVEZmSlh5YW1xZnZKcm4zS3pmNDVlMUhQZVlR?=
 =?utf-8?B?S3dUTkQ5TTJBaEI3Vlh4bmEwWGlFbm5DeHBhOWVvOVBkcnAyRWVwLzlIZ3ZV?=
 =?utf-8?B?UUtmU1pic0Vyd1JGVjFTclJyL1pRWStwRlFKSEQyc0ZzYXVEUDZYRDdQZHov?=
 =?utf-8?B?V1Z2cW1aWTVqSVg4T1VmVmM3SUpUM2poRHFPYmNaakg5UWUzRXZZdUh6eWJD?=
 =?utf-8?B?WWVmN2V1WUZXUGRHT2JMNExQTHJYeGVhdkdYSGhRRVlMN2srb215bDF1UkVR?=
 =?utf-8?B?WEdzZ3dqQ3BsazVvU3R4VWltYlRNb0R0TTcvTXBzSG5kOHlJL0V1dVRoaHk0?=
 =?utf-8?B?Nk5jZHRFejZUSG1MbE9yb2ROU2FCc2dJNVNFR0dlUW1GejZUeW5pQUhJQity?=
 =?utf-8?B?TlZPbXAzdEtnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1Q1a0FzS3B3Y3JNNHBDZmRJcUJxaitwVGo1eGlTNzRiUS9kQVdzZ2xvNjRE?=
 =?utf-8?B?MElRTXYyU2tVc012ZmJuK0VXQmN6UWxrWm9peE1GTmlGZzRmZ2VxcjhjKzJ6?=
 =?utf-8?B?d2dWMldIeHIxUndlRmpmM0h2REIzQXBlaUFpQkNzTFNvTDlLQ2lkdlI0M3Yw?=
 =?utf-8?B?U1MyMDFDd1FYVldxK3U1YU9Ea1ZHNVFmUWVIZHFDQnZ2RFp4MDZRbjZWWEhv?=
 =?utf-8?B?MFpmWXkyTUgvaGYrUHRSVWZXWVlnYVhFSFk5Vnh4RUtjN0VWdUw2SURpbEpG?=
 =?utf-8?B?MjhVVUZEYXlBWFpDWjZZSGVPUFZCbFY2OTk5ZEIyTFczT2dHVGQ5b3ltYncz?=
 =?utf-8?B?c0UvOTd6VDFHUGM1RU9ZUDlBYnJTWXdaZTF1bzAxTEV0Yk9lTTVMUW05S2Y2?=
 =?utf-8?B?QkVjTWdmaDU3MHJESnhpMlg0emxEY3ZnWE1wRjMxWHVsbGlTTGp4WTFTSE0x?=
 =?utf-8?B?KytKTFF5UEM4VFZQb0pJMk42SW1aZll4RlJQVzJUMlBlSGhRNmNXTkZpWXg3?=
 =?utf-8?B?SDUwajFzd2JNMHh5T3d4UllsYVZtYVpWTjJoNC9mZWFwT3pBL1lWV3VpTWdk?=
 =?utf-8?B?WHBESlBHTVJjNllsTVFRT2JOeERDZ2Y4QTRVUmIyeU1oZEZoMFBzN2djcWtX?=
 =?utf-8?B?R3JqZmMvM3E0ZzFxL0hNdm4xZENVVlJvelI0ZUVCY1JoMEN1T3FPMDEzd1NU?=
 =?utf-8?B?bWNrOURzd0VoSmkxWGp1VmwrSnJqS21HZXArM2lTdXR0SENMY3FwSGxZdWRp?=
 =?utf-8?B?dmNiYmRYdTlzWmNtU0ZpUkw1NjNRbWIwRDdTNTdBWUxJQTdvcnVqWlN2MHdM?=
 =?utf-8?B?bzhRR2xrbGRRUkE4RmRBMnUxRXY4MnpLbjNvOUc2MzRlUG5NTFpneHBFYW9X?=
 =?utf-8?B?Z1I4RlJLMVJ6b2FyS3hQR0F5cnNRR0w5dldyekFYL1VLdVMxajlmTmh5dEd0?=
 =?utf-8?B?NmVMM3dBekhkaWJGYVRVYmJQVGEvU0p2NjRqMW00djVLNmVjUUdvaStldXV2?=
 =?utf-8?B?dHRiVVhpNnVZcjFVMmNmRHFoOWVKNzNvWHFvWW1aNnZjY0NmTmZxbEhIUDh5?=
 =?utf-8?B?NGlRdWIyNlprU3V5T3JiYmgxUUhoQnZMa1ZQUi9wdXQxZm9FdHU0cUlac3hx?=
 =?utf-8?B?VmIyWVJFVTZ4NCtRR0RMN2VOVWI0WlpwbTFITW52VHdWTDU5c3NXV01NcDA3?=
 =?utf-8?B?enVkWVVmYkxoWHg2SFpRQ05mWHdiQXpGMkZUZzNYMjdtRlBUVWs2Ni94bGs3?=
 =?utf-8?B?NTMxRk5zeG4zMWdjaVh1MWVoWEVYOW9oWDd0OFREbzdpUXNqblpTTWxYbkFj?=
 =?utf-8?B?Z1JGMy83UzVYNmJuR3BRemc4TmhCampTMVAwNG9sR2U4ZklYc3JURTQvVnM2?=
 =?utf-8?B?SXg1eVV5N1k3S3dwZVRUamN6M05nb2IrWHRDM2pTRWxZY2EwMWJnd2RpUTNp?=
 =?utf-8?B?WDRQM1RYbzRIcUZ3NDBtd0lKNHFoR3Nac0VRTGthOU5PK1ljTEJ3YWZTL2t3?=
 =?utf-8?B?TlNXc2ZOV0QvS0cvM1EzL2J4MTVvNGpzZGZqT1NzbjBBTmFaVkFQZWZlQWNl?=
 =?utf-8?B?Z01nTTZ2b0VLUkEvb3FKRUljM3RLaEVxcFcrWWxjMEUyMDFncWRxblFkVXRt?=
 =?utf-8?B?dWZPVmdrRTZCaUpNVlNjM0E3QUhBUlg5UEhQQ3V3aTdCb2h1VUlXcmJLUWlR?=
 =?utf-8?B?Ymt5ZEdnZTdneUF6ZTVnY1d5dm0rMlBqYU5kR1B2ck5DS0NwRm5BOUJjSVJh?=
 =?utf-8?B?WEVwNXAzcDIwUW1TeHpTUjg1aVlpVElpM09pTy9HVmRWMlBvdUxZZDlLZ2o1?=
 =?utf-8?B?eWpZZmNCc0VRWmhqc1Z6S2hpaG5jenhPaDk3dFZuTENlS3VBb2o2UkJJV3F2?=
 =?utf-8?B?dXZBTGsyWm1rZStVa3JweWxSSTVRZ3BDUVVtRnRiRUgzLzg3RFJzbkViajZG?=
 =?utf-8?B?ZmZVcThrSDhZdHc0OHg4Q3R0K1RUdkRpeEpJdVZyZmNNRHp0RzlGSERxR2sw?=
 =?utf-8?B?dk56OS9YL1JCZ3FFdGZzTVZpbTRpa2dtbEpCR1h2TzJtZ3RGbEwzb0dPOHVa?=
 =?utf-8?B?NXh0WnRXSFVlSEV0bEFNQy9xMUVvQlVJZDIycU9uTWRlM0VjNm1ycW1xeXlE?=
 =?utf-8?B?RDNoeHJ6U3BaYWhPbkliQ0oxL3VrZHRIMzVWcjhjc2Jrci9ocE5yL0hkWVpa?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C26705B75CE2E346BC1723DE4237E41C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DpEXFdsoEszsGokMwW4YkohLQ/ukcKykJfY6pg6secXQJ/ml1zrwc5mym5Vd477VwODQTn0P0m5vq5/ENcIx9hfafds662eL+aaBtijZTYVVuJgtYknpocmUBU045cFpXbg8HgVvdTUG3L6suIAcEGe39fQd75bub1ZrP3I7yo7s9SGmlRay4IYFer4uQMP5/wew3M6zvC4ALOlKhnklr1vtTdgFK9hzZPexxjV9cHU4dHEvId7Q1MaEX5RMythZE/QTn6ntcfJ2reYTTw0GwpgTmNNObb7gv4OYCmXmkUPK1NbPqj+3AbgpOvObSst5CwVvK2dthK3fZhwOKmMYmdTvU+Q0FBkqwf/NcpvGhKzYttwqviuXVch8UxcCeT1GvPrSyNqMlrc0i+mf8pkFDWJ4Y66qJ09oTIcHRoo7R9+W2ohRHfwkVXHkHrbhFQnfcN8ZUcQlWQPlAhtmVUd1u/v6I4Q0M2uDCHA05gzTgCtSo94LreBJPoK+5GfLO0xsEyFNjwinCKh5mGn9JUC4wrVk5HAe7bppt+uZ8B4+Gw5Y+eM4ZaO2OVVXXVzhixWW63qvP5hnDg5QFosHwBgRwdaB83DxdNKqJ5XQUikCx8TMkz0YqrTGzo4+n4IkSvqS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040745a9-f3f9-428d-bce9-08ddeb5d1c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 02:45:29.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xly/rFyu4x+hgZOCziAkPyY+pqBgJ1Q/TxgAIdrLmFIPDk4HcWRzwI2xW3N+nU8TVkFXWlBhjUUDH8vtLs3KcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8579

T24gV2VkIFNlcCAzLCAyMDI1IGF0IDc6NDAgUE0gSlNULCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIDkvMy8yNSAxMDozNiBBTSwgWWkgWmhhbmcgd3JvdGU6DQo+PiBUaGUga2VybmVs
IEJVRyB3YXMgdHJpZ2dlcmVkIGJ5IGJsa3Rlc3RzIHpiZC8wMDkgb24gdjYuMTctcmMzLCBwbGVh
c2UNCj4+IGhlbHAgY2hlY2sgaXQgYW5kIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBpbmZv
ci90ZXN0IGZvciBpdCwNCj4+IHRoYW5rcy4NCj4gWy4uLl0NCj4+IFsgIDMxOS44MTk4MjFdIGFz
c2VydGlvbiBmYWlsZWQ6IGJnLT56b25lX3VudXNhYmxlID09IDAgOjogMCwgaW4NCj4+IGZzL2J0
cmZzL3pvbmVkLmM6MjU4Nw0KPj4gWyAgMzE5LjgyODQ0OV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVy
ZSBdLS0tLS0tLS0tLS0tDQo+PiBbICAzMTkuODMzNjE4XSBrZXJuZWwgQlVHIGF0IGZzL2J0cmZz
L3pvbmVkLmM6MjU4NyENCj4+IFsgIDMxOS44Mzg3OTNdIE9vcHM6IGludmFsaWQgb3Bjb2RlOiAw
MDAwIFsjMV0gU01QIEtBU0FOIFBUSQ0KPj4gWyAgMzE5Ljg0NDgyOV0gQ1BVOiAzIFVJRDogMCBQ
SUQ6IDEzNzAgQ29tbTogbW91bnQgVGFpbnRlZDogRyAgICAgICAgVw0KPj4gICAgICAgICAgIC0t
LS0tLSAgLS0tDQo+PiA2LjE3LjAtMC5yYzMuMjUwODI2Z2ZhYjFiZWRhNzU5Ny4zMi5mYzQ0Lng4
Nl82NCtkZWJ1ZyAjMSBQUkVFTVBUKGxhenkpDQo+PiBbICAzMTkuODYwOTQ4XSBUYWludGVkOiBb
V109V0FSTg0KPj4gWyAgMzE5Ljg2NDI1OV0gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuIFBvd2Vy
RWRnZSBSNzMwLzBXQ0pOVCwgQklPUw0KPj4gMi4xOS4wIDEyLzEyLzIwMjMNCj4+IFsgIDMxOS44
NzI3MDRdIFJJUDogMDAxMDpidHJmc196b25lZF9yZXNlcnZlX2RhdGFfcmVsb2NfYmcuY29sZCsw
eGIyLzB4YjQNCj4+IFsgIDMxOS44ODAwMTRdIENvZGU6IGFiIGU4IDdlIGFiIGY3IGZmIDBmIDBi
IDQxIGI4IDFiIDBhIDAwIDAwIDQ4IGM3DQo+PiBjMSA4MCA5ZiA1OSBhYiAzMSBkMiA0OCBjNyBj
NiAyMCBiOCA1OSBhYiA0OCBjNyBjNyAyMCBhMCA1OSBhYiBlOCA1YQ0KPj4gYWIgZjcgZmYgPDBm
PiAwYiA0MSBiOCA1ZiAwYSAwMCAwMCA0OCBjNyBjMSA4MCA5ZiA1OSBhYiAzMSBkMiA0OCBjNyBj
Ng0KPj4gMDAgYjkNCj4+IFsgIDMxOS45MDA5NzddIFJTUDogMDAxODpmZmZmYzkwMDBjMjFmOTMw
IEVGTEFHUzogMDAwMTAyODINCj4+IFsgIDMxOS45MDY4MTZdIFJBWDogMDAwMDAwMDAwMDAwMDA0
NyBSQlg6IGZmZmY4ODg4ZDFhNTQwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+PiBbICAzMTku
OTE0NzgzXSBSRFg6IDAwMDAwMDAwMDAwMDAwNDcgUlNJOiAxZmZmZmZmZmY2MjljYzg0IFJESTog
ZmZmZmY1MjAwMTg0M2YxOA0KPj4gWyAgMzE5LjkyMjc0Ml0gUkJQOiBmZmZmODg4MTIxYjdjMDAw
IFIwODogZmZmZmZmZmZhODAyY2JiNSBSMDk6IGZmZmZmNTIwMDE4NDNlZGMNCj4+IFsgIDMxOS45
MzA3MDldIFIxMDogMDAwMDAwMDAwMDAwMDAwMyBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiAw
MDAwMDAwMDAwMDAwMDAwDQo+PiBbICAzMTkuOTM4NjY2XSBSMTM6IDAwMDAwMDAwMDAwMDAwMDEg
UjE0OiBmZmZmODg4MTIxYjdjMTI4IFIxNTogZmZmZjg4ODEwZjM3OTgwMA0KPj4gWyAgMzE5Ljk0
NjYyNV0gRlM6ICAwMDAwN2ZiZDg5ZTk4ODQwKDAwMDApIEdTOmZmZmY4ODkwYWY4ZTgwMDAoMDAw
MCkNCj4+IGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4+IFsgIDMxOS45NTU2NjFdIENTOiAgMDAx
MCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4+IFsgIDMxOS45NjIw
NzddIENSMjogMDAwMDU1OWUwYWQ0YjU0MCBDUjM6IDAwMDAwMDA4ZTE0Y2UwMDMgQ1I0OiAwMDAw
MDAwMDAwMzcyNmYwDQo+PiBbICAzMTkuOTcwMDQ2XSBDYWxsIFRyYWNlOg0KPj4gWyAgMzE5Ljk3
Mjc2N10gIDxUQVNLPg0KPj4gWyAgMzE5Ljk3NTEwMl0gID8gY3JlYXRlX3NwYWNlX2luZm8rMHgx
NTUvMHgzOTANCj4+IFsgIDMxOS45Nzk4ODBdICBvcGVuX2N0cmVlKzB4MTg3NC8weDIyMDMNCj4+
IFsgIDMxOS45ODM5NzddICBidHJmc19maWxsX3N1cGVyLmNvbGQrMHgyYy8weDE2ZA0KPj4gWyAg
MzE5Ljk4ODg1MF0gIGJ0cmZzX2dldF90cmVlX3N1cGVyKzB4OTM2LzB4ZDYwDQo+PiBbICAzMTku
OTkzNzI1XSAgYnRyZnNfZ2V0X3RyZWVfc3Vidm9sKzB4MjMwLzB4NWYwDQo+Pg0KPg0KPiBPSyB0
aGUgcHJvYmxlbSBpcywgd2UncmUgQVNTRVJUaW5nIGlmIHpvbmVfdW51c2FibGUgaXMgMCBhbmQg
dGhhdCANCj4gb2J2aW91c2x5IGZhaWxzLCBiZWNhdXNlIHpiZC8wMDkgY29uZmlndXJlcyBzY3Np
X2RlYnVnIHdpdGggYSB6b25lX3NpemUgDQo+IG9mIDRNQiBhbmQgYSB6b25lX2NhcGFjaXR5IG9m
IDNNQi4gVGhpcyBhdXRvbWF0aWNhbGx5IGxlYWRzIHRvIGFuIA0KPiBhc3NlcnRpb24gZmFpbHVy
ZSBhcyBiZy0+em9uZV91bnVzYWJsZSBpcyAxTUIuDQo+DQo+IFRoZSB0ZXN0IGluIHRoZXJlIGlz
IHRvIGNoZWNrIGlmIHdlIGhhdmUgYW4gZW1wdHkgYmxvY2stZ3JvdXAuDQo+IEBOYW9oaXJvIHdo
YXQgZG8geW91IHRoaW5rIG9mIHRoZSBmb2xsb3dpbmc6DQo+DQo+IGRpZmYgLS1naXQgYS9mcy9i
dHJmcy96b25lZC5jIGIvZnMvYnRyZnMvem9uZWQuYw0KPiBpbmRleCA2ZTY2ZWM0OTExODEuLmY4
OTdmOTE0Yjc4ZSAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvem9uZWQuYw0KPiArKysgYi9mcy9i
dHJmcy96b25lZC5jDQo+IEBAIC0yNTkwLDcgKzI1OTAsOCBAQCB2b2lkIGJ0cmZzX3pvbmVkX3Jl
c2VydmVfZGF0YV9yZWxvY19iZyhzdHJ1Y3QgDQo+IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pDQo+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwYWNlX2lu
Zm8tPmRpc2tfdG90YWwgLT0gYmctPmxlbmd0aCAqIGZhY3RvcjsNCj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogVGhlcmUgaXMgbm8gYWxsb2NhdGlv
biBldmVyIGhhcHBlbmVkLiAqLw0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBBU1NFUlQoYmctPnVzZWQgPT0gMCk7DQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBU1NFUlQoYmctPnpvbmVfdW51c2FibGUgPT0g
MCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBU1NF
UlQoYmctPnpvbmVfdW51c2FibGUgPT0gMCB8fA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiZy0+bGVuZ3RoIC0gYmctPnpvbmVf
dW51c2FibGUgPT0gDQo+IGJnLT56b25lX2NhcGFjaXR5KTsNCg0KTmFoLCB0aGVuLCB3ZSBtdXN0
IGhhbmRsZSB0aGUgc3BhY2VfaW5mby0+Ynl0ZXNfem9uZV91bnNhYmxlIHByb3Blcmx5Lg0KV2Ug
bmVlZCB0byBkbyAic3BhY2VfaW5mby0+ZGlza190b3RhbCAtPSBiZy0+em9uZV91bnVzYWJsZTsi
IGFuZCB3ZSBjYW4NCmp1c3QgZHJvcCB0aGUgQVNTRVJULg0KDQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE5vIHN1cGVyIGJsb2NrIGluIGEgYmxv
Y2sgZ3JvdXAgb24gdGhlIHpvbmVkIA0KPiBzZXR1cC4gKi8NCj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVNTRVJUKGJnLT5ieXRlc19zdXBlciA9PSAw
KTsNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bp
bl91bmxvY2soJnNwYWNlX2luZm8tPmxvY2spOw0K

