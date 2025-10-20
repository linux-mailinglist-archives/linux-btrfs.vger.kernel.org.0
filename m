Return-Path: <linux-btrfs+bounces-18027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D4BEF889
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D74B189B49C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB862D9497;
	Mon, 20 Oct 2025 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PjFcA6V9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TNX/9UyU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2DB2DA775
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943357; cv=fail; b=q2hy7aLoaB0Rdap/+KUEOe8BMCrYpGE9RURh1dVCjVn4h2i+TdYOC/1rhtmf3R+lK3iOxLiIPkGMU8VVUCR/WUveb2U9zyubIwicUF4CZENR3brZEC8xQLnxjlaFC0lRNKQMIXfv/ZqCJnc5aPnW2oetfri+eotfw/9gv4SXqag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943357; c=relaxed/simple;
	bh=iv97oUKWQGhkRp4SIL89r10YmPtK2EJcUTRdbhiJMd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhdSH96gevUFJiWM/1GsvYSN6rF7MeHicojf0sum+dYXfSYHJmYc8aQIdpWNN7m0EYhxR4QGWYZ6mrqKvH3XwzVkxvv9qMHSx3oHVS+uhIrUQoxDAJTf0SaQ3fjxppTqDJidIEwm1a5ZgygqTpMgSRUqSAE9t0oB4mlq/ADqyds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PjFcA6V9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TNX/9UyU; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760943355; x=1792479355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iv97oUKWQGhkRp4SIL89r10YmPtK2EJcUTRdbhiJMd4=;
  b=PjFcA6V9f+G8S90+jR7CZISzRAscMZqrt8Cdhsi9S6rshmkyyS2OKA+e
   fbqI1caXVxISYa2pd2g0FUzTPtmbXWIjaEXxD61whIV21tuIhtV4vKSJn
   EH1DzqF9mPVmYcGgrWo+ZHayCVqvsv8V7EndCyk+nV89RSwn/HN4ouI/P
   eNOYrA4t6xqlwJyx4MDmxfqL2Dw9v759fjeYzl28+H0aP6EwNMlJgoVSS
   GSj4uQ+zBmBt2kiQFxAlyFGaOlRlGlDVFi7vuy5dfB2kArjFU8nIuMlSF
   EFKgBFMFnWKCZbjGHRxtiQuly9QK8SqsprXyPVt3pWB5mAb6KVPQAvqxi
   g==;
X-CSE-ConnectionGUID: 8MsagU2qTP+eQoOdX4nm2A==
X-CSE-MsgGUID: n3Jrp4pWQOyfV7iylN1qLA==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="130557792"
Received: from mail-northcentralusazon11012063.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.63])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 14:55:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7+gytBv5XpzhN9JLtxQKJlU7iIxFfjBLh+j5YcqHg3GIHTZIlb6b9nWSCU817ZyQ5pvxDIt48bJ97fUzQlSWqSVy52ym4BkNnS7fjjTJDpor6f7LPLAzd7HtaJFr+ntfofT4O2bC2MNsegHfWDnvqoV6ewvtWOqm3o6XmQE5J7ZlJnC7NblzQRoFRlGT7aL7WaNnuAK3vXGZEGa0ERxjFYlrBd2VHUWfhhVW4NeXYzptByMM3dJPanfIByDFY44VMXEY+62TvykwT5hrKHBBJE7ekokQMLLSPltm3Ai99YPa+WZX6o+2Y+Tb2g7R234HrhPcPFIwkLQDT+7ogHmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv97oUKWQGhkRp4SIL89r10YmPtK2EJcUTRdbhiJMd4=;
 b=Z6jPohv5batZ7GLTnYzErgjaZBTkZIyx4dDO4FCxgftyVeDETBpZ7q9ytamJut16NK6/q4yNeTp7oa8ZpE6cJjhwvYzKGb3IqgKeQTwTqht8NPvGldNhd/+3iiLqQG5iSkyqTwqsd3EEJG0Vus51TLYJ3HOgDNOU09Ne0bm9rCN86wi1edUFzbNOi1J+2Myz7Fy8v6Ith/uBAewV+V6944btfMTFBcsKTVb+j0m+9lXFvJVsAWy+DO3o6Hnsb0AJRnJP50t7xWX4PsoR7tpOdTKpqfOsv+/UGqCxnDrIWsb1v3ljB/JLLpyxACpY9tmBapTsCksDtjEGY5TwWj2HJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv97oUKWQGhkRp4SIL89r10YmPtK2EJcUTRdbhiJMd4=;
 b=TNX/9UyUK1QsQB7B8dgVKKPk1Hs5zzMWHIHouzI3V2qxjacZFDwwwhdCedzkv3VOlCmw+nGvjgzQIYYp7z9Ftoydrph/ISrBMuw2J8n6PZVT4yCjU9hNJOZ12ApLGP7J9DXPc5mkNvLufLihIerJIqdgnusBxroGgMmvcsCXT9I=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7360.namprd04.prod.outlook.com (2603:10b6:a03:293::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 06:55:46 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 06:55:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Topic: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Index:
 AQHcN1KuGCX0HNOhIkayN1jmYD5sCrS2iOkAgAE6w4CAAAEogIAAhrYAgAwao4CAAgBTAIAERZsAgAABVQCAAABcgIAAAK0A
Date: Mon, 20 Oct 2025 06:55:46 +0000
Message-ID: <0f067fa8-acaf-400f-a36c-e124ae95e337@wdc.com>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
 <aPCXz7ktsyE8BLeG@infradead.org>
 <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
 <aPXa9gR4l3WnI8kh@infradead.org>
 <506e7292-d795-4a78-9c0d-8442cb3b7a15@wdc.com>
 <aPXcYQPPYtA98MBM@infradead.org>
In-Reply-To: <aPXcYQPPYtA98MBM@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7360:EE_
x-ms-office365-filtering-correlation-id: 7ebe2c2f-3baf-41ff-2cb2-08de0fa5b218
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|19092799006|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ek05dFdIekNZK0NCMDVZck5TUmJ0UVVUOFJwSzlFZzNRcis5K3Z0alpwRm9Y?=
 =?utf-8?B?cEt3SEJSdVQ2bGpJTG1uVEx6cnJOcml4eE8xU3BRcFpCcWRzQzQwOTlGWGpm?=
 =?utf-8?B?d042OFB3eG5WT2Y2MkVuTFNhdzVzT29FMW55YjkrL3VkaXNqZjU2OW4vdUZ2?=
 =?utf-8?B?SEFLRWVDUVF6OVBwblZ0bi9QV0JpQ2hQVEhxSGN5SGZUd1V1dXlnWFlnTmQw?=
 =?utf-8?B?OTFVMktIZXdWWVdWaTkvQWFkT3FNLzhkTzkydHJhT0I1Y1NyNDBkdVEvUStp?=
 =?utf-8?B?UUgzNWVpRVc1ZWVHZ0YwS0tYeitRbUZFeGd5ZityUGVYamwvSUpENk43WXZU?=
 =?utf-8?B?cmxhRFBPUVBWV1U5K2l6dTFtMUxoZTdsNWJ6VURFMU9Kc2tBVjFmTUhpWk5R?=
 =?utf-8?B?OGFXK2xCQ0Rpd1Y1V1RuT1RMckdJNk53a3JWd0lGcDlqMGF1bCt3MmZDby9q?=
 =?utf-8?B?ZEhkR3dnMFNJS2lCTVE5K0ZtWmdPRHdvV0VlWW1rMU9wSnY2TnVxbnpoZTNI?=
 =?utf-8?B?Z0xTS3ZWZnZnL0h6Ri9OQkczY25TbndOZ3k0U0cycnR3V2tydDd1bzJTb3Jp?=
 =?utf-8?B?VkVpNi9Xek5nOTcrbFZEbm5WSzU5Y1NIYzd0Z0lFNmxINk9FRWtoQ0lXdzJm?=
 =?utf-8?B?OFRKS2VuTXN6WDh4OHE0Ykt1aHFjdzJTL0VHVGk3bWt0TG5xaWt6aHhiWHMx?=
 =?utf-8?B?Sm9HaHB1cWZIRTNWN0pCRTNZak5TVGU1TkR5amh0RTFjSDh2YTY3M3ZaT2pD?=
 =?utf-8?B?Tmt0WnM3TGpva2kxZmRCOTFYSkNraFFQcHRIZlBXOW1BN0JHcmRvbjZOcFBn?=
 =?utf-8?B?QlN3bU5xUE1XdHpFZUx1Q1VDVUVYc3NTVFNZZ0xoanU5T3VyZEx4SUFxYldP?=
 =?utf-8?B?MldHU1ppTC9POW1EZDdybGVxUkFTRFJCTTl1amlIU1VZMWpZK0JaS3JBTW5h?=
 =?utf-8?B?dnZxaWk5OHEvakxEY2JtaFZrSGVOcDUwSVE5aTcwRldqYnYvZGRhc29SVlFU?=
 =?utf-8?B?V1F1OFM4QW1vN096WTRsdlZBU0ZBZUJsTlRhdmZYbWZPQ1d0RGp0VUVWS1R3?=
 =?utf-8?B?QjAvNjhLSCtnVEhHUTB5SVRFbURnbTBPYVRhWlkyZG0vT1piOCtTQTF5YXNq?=
 =?utf-8?B?L2NEcnArc1h5ZVVmZ0ZhbDVMOHdDUEhZaDJXamIzVXUvYU1nYVRqTmY4UU02?=
 =?utf-8?B?aHh3SFBxZCtRa281ZitycEs0MmdHRzFRUlVvV0lCK3E4S25sTWxWb2FyRWtN?=
 =?utf-8?B?eDZrZGt0cnJsbkh3Ulk0L09ZbGVxTVVRaHV3UFRYUnFFTk5uQ2dWV0dIdGJS?=
 =?utf-8?B?K0JqQngrcnpyL0lZdGs2QjBqL3hNdzlPcjk4Vk1SajlFWkdnU2s3RjN6TDA3?=
 =?utf-8?B?Q3FuK1Bxa2tZVmFOVkJvNmFkTWh3bkJXcGRqZmdnVndJeU52ZEkyd29zNzl6?=
 =?utf-8?B?Ymh6dzJBMTZJeWhHbFY4SWNBZmJpZDRUUWUvT1A4R0MwZG56S0tkMklERGU2?=
 =?utf-8?B?UG93MFVPQnpHOFdjVkdNc0UwVmdBV1BKR3J4SThLUm1UQVBteDV0UFRkZzhl?=
 =?utf-8?B?WDQ5bmszNFZNNFJScTI3VXJCSTQzV2Y1cXJZanRwMG9Ud1RmRnhZUGpNaFVI?=
 =?utf-8?B?QUNJS0JHcU9rNmtuN0N5QmtEanFGZUFUeFUxWFliRllkbHVtVjc3Z3Y4K2M5?=
 =?utf-8?B?cjNJbjFwTzF6dmZ4RldJS3hveVBoUHU3M1J3YVVFdDI2aUY3bnY1bm56cHJq?=
 =?utf-8?B?MmF6Q1dTZGVjQVZFbzBpZlFLS1BYaldUYzVWOUpjbjFkYWFkazYwQXhsaE40?=
 =?utf-8?B?N1UwZExySS9CMkp6VlBVZUlKMGpPTGR0ZzRUd2Z6TElmMzUzc0pPS09BbHFo?=
 =?utf-8?B?UHMrT3E1M3VDV2dKa3luamZrcXdwQ0tpVWw0dDJDb1NYMTk5Uk5LNnhaRXdi?=
 =?utf-8?B?dGxYSFRFeVljbzRQTXozRk1JL0o1Vjd3T3hWUm42WEZwMXdJTUZaaWllODBm?=
 =?utf-8?B?ZGlWNHpPYk12NmlsWFVtWHo3L3lmY2s3dmw0TVFQNlZDcmVhY0QzS3BXNHZY?=
 =?utf-8?Q?1CH7NR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(19092799006)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUxXdkduMFhzbzAvelZpaDZxL0dXUU1sMHBJdDdic05WWDFPaEw3V1UwOEVa?=
 =?utf-8?B?c1RxM1Zad2QzR0EvZjhRT1pTWFBiV204Z01PMWVrUytRTWJ5YjgrZUJLazly?=
 =?utf-8?B?NjFEM3NFZHFRTHBDa3FlSE5rc2F3ZHplc3FyM0JrVE1JUWJCL3RnaWxIVTZi?=
 =?utf-8?B?eDRQRVUvV21vSTl6Z3NPa0wxSEFpMUNRTHhlWjhoYnAra0p6M2ZnZTlzWnFD?=
 =?utf-8?B?UGlhQlpxOHA3UjFVa2NlcmRhUk5WM3dpNVZkS1dXdnpYdDMvT2tST2V6UkV5?=
 =?utf-8?B?VWpmT1hpdGlyV3lBTmQ3WUJZOWJpMUFYSUFNVk4wb1ZGOFU0ODR5SzQ0eFBm?=
 =?utf-8?B?ellrVkgyaEdpbGVubTlRYit3ZmhnSUMrUGhjWmx4UEt6cklINDFvSDJob1JC?=
 =?utf-8?B?OXVXN0EwV3k3TmQvenlOY0RJeGRvZFdMa1BUL295OFVESGhOWXQ5UnY4bS9k?=
 =?utf-8?B?dmJFdnF0STJsN3h3YVVNL09wazZlb3RCZ1k1aEtibWRKSVUwU2MzdWphYVhY?=
 =?utf-8?B?RnZyT2UxV2xFVzE5YUlWaS91TFRsZnBOOVM1b0FZOUdYZkVjcUwyYlNSN3Rh?=
 =?utf-8?B?NEY3N29YcnRIK08vSkpBM1daUlMzbzhSNlArd09JV1Y1RzJHTlFDaEdQZjMx?=
 =?utf-8?B?NDBiWHZsa0svbm85dHhKcUZLVERkRWVzZWs1Ny9PeHVNSGRSQzg3dWhJT2Jw?=
 =?utf-8?B?eFNHQjIyY3hucE0yZS9WQ0MyVUw5aGdKdUw0aUZXVE5aT2h2S2R3UUpJeTNk?=
 =?utf-8?B?S2VLUjV2TnkwWnNRbHRlcS9hMW9NeVdMQkpNRmg5R0RKL09iMEgxWHNxWWRv?=
 =?utf-8?B?OGdSdlpzcGZYTjZPbmJKUElhOTE1MW5KeHlSRHM4RUtwd3RlRzJBZFlOODd5?=
 =?utf-8?B?N2tOLzExK25MbG1uU0dqaUhCcEtOSXlLZFdKT1dvZHJOTE1iRVJJWEJSZ2t1?=
 =?utf-8?B?VStvSmZ1VU9sN2J2cjBwQXhDbWs2SHp5U1dGdkFGL29SYW1waEVMNFBUQ3NZ?=
 =?utf-8?B?a1gwOW43cm5lTCtubHhvODUveXVXMVp4TXp1TXZlczc5MmJGWGlJcE11eDVt?=
 =?utf-8?B?MWd0dnVqNHZpL3BOQWNlbGZKM2UyYTFob2VaTkVhZW5MZzltSlY2TXJSM0R6?=
 =?utf-8?B?bnZZZGtyQ3JTMi8vdm5OcUJyV25aVkp6UjczVy9OTFBJS0MrS3pZRk5pMm85?=
 =?utf-8?B?UzRRTXFodjA2SUorY1FYc1UyUk9qa09SaHdEWW53bFByaVYyVzM1NmtWMmxZ?=
 =?utf-8?B?ek1DRmlTSWZ5Y1VqSFBOelNDL0o4RWczZ2ZWbDVPb2YyVXJlZzBTVU5rK3d5?=
 =?utf-8?B?bFN1YmNjT1RrY0l0VWVHb0YxeVUrMWFYVWxFa0pUQU9QRzRmVElMdFAvbmY5?=
 =?utf-8?B?SEF4UHNRN05Pd2FXMzRTS2NKeTE3eEFsWHl3emg5eENnclV5dFVuU1BjMEp4?=
 =?utf-8?B?Z1BJOTY1aUVQdlR4bmoyV3lTYkZVMkxIeDc1NHpRalVGbHRPMTdlR1IzSXdx?=
 =?utf-8?B?M3RzOXU5Wit6b2FDTkxDTlBHb3NKUHB5N1NLbVZMRHdvYlNUenpFaFBVRisw?=
 =?utf-8?B?YUdnWlZWZURSbVBQYlRWeHMvakgvOEhOK3JyUDFWTnBORlUzUGk2dnROa0hl?=
 =?utf-8?B?WjJvd01JUHBBUDIvQ0hXQ0sxNnJLMzJyUkRieFB3YUtrc1RZV24xd3VEVGFx?=
 =?utf-8?B?RW1HaEhEc3c4VXNRT2xCN0NLdXM0dW1UdEoxbEpsTjNIclVyb3N0d3hucEho?=
 =?utf-8?B?UXBKdThVL3BncmhsTEhPa2xnL1RjSjlJVjRIVWFRK3FUeUZacGtDTVVRM2Ry?=
 =?utf-8?B?SlJXOGlOUVhoYUdibVZMSC9FdHhSTGhDQkpNallSMFB6ckw3SjJkNW9VVmd6?=
 =?utf-8?B?MDNTU0xMRmJQclpDQkQrVDRycUszTUcwUWhrOHMrMFlPK3dRbjJHempVNlN4?=
 =?utf-8?B?b3dFWFpVOXFaYWcxUEFocnp6WkJ4eXlDN3Q3SXgzZ2dhbDFUWlJpc3JXVUdh?=
 =?utf-8?B?OVMzb0NoMnA4YU1uWk5TRDJBWG95d0VNK3FpNFMxOXdhNEYzUXVpVDNmKzBD?=
 =?utf-8?B?d0ZzZ1BVcTJlbkxtOWU5RlZNaUw2TUVjRnBVS3lRTFE5UXc0bGhpTUhIQzkz?=
 =?utf-8?B?NXRJam56QW5PdGxDWElEa0hyb05FanlJYk96WlZrYmpUampzWjVwTUF0ZmJJ?=
 =?utf-8?B?cmFOTDA0aXA4RkVyTmMrV0lKMVRxWEI1T2VPYyt0YVZTaHlCeHQwVDVVMXdu?=
 =?utf-8?B?dXQvZkUyM2dLNlo4YU0rWnROdDdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99A2ACFBD460E0419CEB0D517B25F4E6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G58FTumaYmQkzrTKZHCNhg49QL00CK2AXNM2rlWwaHmVLPrPED7yzUH4KwvcGDU6pTvxkUuIudiqobEiXWHIhq0AyNgGyPgtBnoYWG+xH00FJ5YlqGzUnbZs37UjDEKEASb9cBPphOax/fzgCUelxxC7jL117DW1yBLD+L0nfok+skmSepGQ9zxAx7btczyyU/17xlIinGZIHa5WTA6gzG/qz3zL2Kl9D9Tmbau0uz99apiOwm76v6Bwkw88W4El4XRDzVRIao/xlkB0LPDWpZbW3L0AZy0xOY2pFjxPjGl4PEpcxIoH/na7W64Bw09aZmXFvr285GYYMPrWA4dpow6hjTf3q6w0Cq9vzdVEJisKL84W6ldOPV8QNWlNNKIhqpEAg/3nEWe4xljdozU0IOwmpI3KPHNYEWnt2PTrTAztbIlgm3ayeWXdIwpop0xZN6lULb6zfwp7cOk43P1co4fky2MzDqd4s/+lksUoP57b0JeYxnzpMr2EtZb1+ixjZIROaVvO4rukk0mwU8R2ECFKEkbDw0DeCFB7rPwUTwQShWhjbQsbHTnP/+W29Xhuk0uvPUzUEZLxUE6+uP5F/H6gZ44NgDapbJNwTCVwogsfmZcmWBeeXbxdNK/H8zhL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebe2c2f-3baf-41ff-2cb2-08de0fa5b218
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 06:55:46.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1OVvYEIEu6rk2yQprDu+BDObjc2H4uR4H2ZuEbWE1vuKZcic9J8XAJRmyBrkBb+jTfrsoAyVDIjmsSwOpqst1okbcp7jDhkOJd/LsHWOg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7360

T24gMTAvMjAvMjUgODo1MyBBTSwgaGNoQGluZnJhZGVhZC5vcmcgd3JvdGU6DQo+IE9uIE1vbiwg
T2N0IDIwLCAyMDI1IGF0IDA2OjUyOjA0QU0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90
ZToNCj4+IE9LLCBtYXliZSBJIHRlc3RlZCB3cm9uZy4gRG9lcyBpdCBhbHNvIGhhbmcgaWYgeW91
IG9ubHkgcnVuIHpiZC8wMDkgb3INCj4+IGRvIHlvdSBuZWVkIHRvIHJ1biB0aGUgb3RoZXIgemJk
IHRlc3RzIGJlZm9yZT8NCj4gSnVzdCBydW5uaW5nIHpiZC8wMDkgaXMgZmluZS4NCj4NCj4gQWxz
byBtYWtlIHN1cmUgdG8gdHJ5IHRvIHVzZSBteSBrdm0gc2NyaXB0IGFzLWlzIGFzIGl0IGdldHMs
IGdpdmVuDQo+IHRoZSBiaXNlY3RlZCBjb21taXQgSSBtaWdodCBiZSBzZW5zaXRpdmUgdG8gdGhl
IG9wZW4gem9uZSBsaW1pdHMgb3INCj4gem9uZSBhcHBlbmQgc2l6ZSBvciBzb21ldGhpbmcgbGlr
ZSB0aGF0Lg0KDQpZZWFoIHRoZSBpc3N1ZSBvbiBteSBzaWRlIGNvdWxkIGJlIHRoYXQgSSBkb24n
dCBoYXZlIHZpcnRpby1ibGsgZGV2aWNlcyANCmF0dGFjaGVkIHRvIHRoZSBWTSBhcyBJIGRvbid0
IGhhdmUgZGViaWFuIGltYWdlcyBseWluZyBhcm91ZG4gZm9yIHRoZSANCnJvb3RmcyAoSSdtIHVz
aW5nIG15IGhvc3RzJyByb290IGFzIGEgUk8gdmlydGlvZnMgbW91bnQpLg0KDQoNCkkgdHJ5IHRv
IGZpbmQgc29tZXRoaW5nLg0KDQo=

