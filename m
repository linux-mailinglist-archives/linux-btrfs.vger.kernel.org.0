Return-Path: <linux-btrfs+bounces-9321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B849BB176
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 11:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F106283F59
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421EF1B2EEB;
	Mon,  4 Nov 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DU/q7WJO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RvBCXE6+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F251AF0B9;
	Mon,  4 Nov 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717161; cv=fail; b=iZH/hGkicwCHbcNMoglZs7kTLsROh/eQyTrTXjuFzsz/f1CGSUmHP2+wcjzhp0KwHo398PRRVdGtEhZlwyfigpNp8D9eSbyniV3QyBz4V0aqpE5Cvkw9aInKMgBUXDmCeDWE2nBk9zN7GY20/Rpy8Cf3OduhyJRFUVw03RUabyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717161; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JM2TdGxNFu5Mn4CDfg+l5G3DxzaR+T43MLg446BMmZHH2BZok5yC1NLFeA74zC8bxmQsnrrHqRSHHw5N1uV/39fwgQGCBqnn7yjT/P+krA/jV8pt7EqbmfyYWGM9wxIHCD449Hs8R1Vm9XzbrHdP1GoZqewMqe3I1wUkIu2/c7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DU/q7WJO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RvBCXE6+; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730717159; x=1762253159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=DU/q7WJOWCYshsOI8IARiHQbgYp5vQ9G4eJhGdN0t7IiPRK6niptgN9j
   3Ipb/dW1wsT23+4fCwqRgDDLfEg4xQEUbgG2Wr0JS2yZ67Kb5SFJ2dwOU
   NVRN8cLy6NSJhnEDT0wwHgMaXYVv1Q5JFpmLObwKg84QnyV3avNyNhGfI
   7PNZ1Nq7mYL6sxqINcm14V09qKFkDKRj1QWx+0nC5lxmyT77vBiFpno1U
   tTavdwfRV0pG25g0fYkxOX8ZrG7TDzSaEYiM0uqc5ath1PqYCSD/uqFJD
   Dau6i36vgwAAqrdkkXJi19z4JL2bHbzxTBxIE06M6Koeryibx9mj7pyQp
   Q==;
X-CSE-ConnectionGUID: yZuYFUfURxSPxdc3MMPGpg==
X-CSE-MsgGUID: nJVNbm0YTdaFBQDdyDZsEg==
X-IronPort-AV: E=Sophos;i="6.11,256,1725292800"; 
   d="scan'208";a="31081438"
Received: from mail-northcentralusazlp17010006.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.6])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2024 18:45:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWvrCG8emDopKLrHzqRvjRjM0S7xcmwKG4IShawpcehZ12FeWrAuIEpydHbeFdlTgTLSXwxJN89413Oc23+UFwspOAxq/alh0UwTGIqdAdIh38LyWE62btfZNmAevqFQHCQeDnqd/QABHFh2uuhHixirKMxkh8DhVZqSddND+G2MQfgQ4XH0sitPCg33+RL+mdMSuVbaN5/Gdu4PJbCmaRFBk7aVL7tLPBbv8PruHa7R0pIwutJUctS5bK9oOV+pi06k898AmWL/QI6xLEbUw+ReYgpHRXj8UPsncTDeepQdKc8jzyqncdO5esL5m4ApNpIgh8ENAId9aLS9lSqziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=pmQ8OofQy5SIp+HYslAGtHTEiIPpCjqbq7TCKcLJp/y10CwOj8R61E07KWzi9IS9A/xSu0usJCHq6y96LLpjN8fCzyQdIegzPSEdZDbLycSF8nBw1t5sWTgb1bxfHaKyf6ekCZI/jpH59vQVZOtqXJExgP/7nfKMyNFHCyaINIQCkSVl7b5sPbTK2g/IcmdsZgchxka8qp/Jd+K/GsmtLQhbG6xbznmi4ghVNETm8anSO334Q85S3qESaEACUbTfyLgnnFrZKL7YxiFJykCwI/uBg4RMa6cf2qQhg1eSdS2V1Z31eLuGKQmRUyQ0QwA4kuJtaGLMec/z4ebs2mKXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RvBCXE6+KtbVptNLDu20HCWoO3qxFZ/0iWRiGNnk2TqW5jpW632AAJFpv083ymhKbuAX9+i1qR6k335D+bESMw7X1jChtXIgS04dv7dVt48hpYYVQJKbBk1avliJtF5w9HqcbI4kMVIS/1vCF13r+nxx8qlCKQlASfugwtkT/Nk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7690.namprd04.prod.outlook.com (2603:10b6:806:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:45:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 10:45:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: split bios to the fs sector size boundary
Thread-Topic: [PATCH 4/4] btrfs: split bios to the fs sector size boundary
Thread-Index: AQHbLB4Y43NkqB4360KDKayC7WgWjbKm9TUA
Date: Mon, 4 Nov 2024 10:45:54 +0000
Message-ID: <835fe042-4770-480b-a3bf-5c6a9851ee70@wdc.com>
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-5-hch@lst.de>
In-Reply-To: <20241101052206.437530-5-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7690:EE_
x-ms-office365-filtering-correlation-id: 298f5a4d-6770-450c-d276-08dcfcbddbd9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXdOZmJXa3hTRlp3aUpycjE3WnZTdVJyOEs5bGRYclE1TExlRDk2TTBXb21l?=
 =?utf-8?B?WDVqMmxBamNRZUl1dXgvYTlaTGx6QmxSRUJEalhWUGU2dWRuLzhqOGVPVnBT?=
 =?utf-8?B?b3YrVDVmRjA3SGZ6ODIrQzMrb1NZbXlzMTZhZVJ4T2l3Z0hFaEFPNGRmSEdp?=
 =?utf-8?B?YVlzYVRVRkxWVjRBaEJEMzRSY2xibTE3T1R3UGZtUWJQU1EyUkptYWhJa3lL?=
 =?utf-8?B?NmhmTzBxS1V2NkFoVVhGQ056RnpEelRPcnFnZ2l4QVdiT0J2Y3hYSlk0RXkx?=
 =?utf-8?B?VzFsQlFldzRtS0VVcVFaWDdnV25MTjhlWXRtVXAzL29RWWRxTko5aTQ1dDlz?=
 =?utf-8?B?b002S1dOcEpqdS9UdXo5UnFzbXlzOG5Ib3h2d0ZySVdNcGpaZ3dJZ2V3RmtZ?=
 =?utf-8?B?YWZ5Z0JTNnk4QWFqTjR1a2pGTjVld3pPSWR2NXJ4L3IvYlFOalpqZEVNbWo0?=
 =?utf-8?B?NWE5eUNMZWRhUFdDQXNIZ0Fidlg5SU52QTV1bzJxVUFkdFEwR0EwZEVKNWJy?=
 =?utf-8?B?S1R4U0huWDU5cm1qQ20xak5kWkhybnFzNHpOcXFUZWd1cXdyM0NSVE01RlV5?=
 =?utf-8?B?cWc5QzRyOWlJSHkrdkpKdzArWTRuZkRxNjhhTUdOSEZYelZVdVV1N2NUemdQ?=
 =?utf-8?B?dk9HcEpJbUxPSEkxRnVHbWEzWW5xMm50WlQ3aDBIbEY0SGZHbzVrUUJ2MEZC?=
 =?utf-8?B?SGNtRVNaa1dFL0tGUVVIK2pIdGxySVdiVjZ3M21zWUFpVGVKRVB5emtDTlcx?=
 =?utf-8?B?d3Z2akJHaFhURWMyUXdkM0l0dVQvOXplUXoxRFg0RUY3OEluLzhvc1Vzeklk?=
 =?utf-8?B?b2tRZndvaFRYc2U3S3M5dEJUcVVNbXY3RFI4TDJiR1dONlg3em9xUGFsV3dk?=
 =?utf-8?B?WEwrWXBpcVd3RTFvRXB3ai9TZThzRFpoTEZpM0ZiYUxSQURveFJOdTdCUm9s?=
 =?utf-8?B?MnR5Ykt5K2MrQUFYMFpvWDJONklrSzNhbG9uWnVJTXkraHFnTlNPSkpLaGZG?=
 =?utf-8?B?bEVVOWFBRXAwczVkNnRNb3Nva1RBd1RMQjM4WnJQMUNaUXRDLzlQR3lEdE02?=
 =?utf-8?B?WHdDZi9BVE85eVZDdnY1eFl3SlNlekI4ZDhRb2wzYjRqWFFQb05qMThoSk1l?=
 =?utf-8?B?SnlGK1hTN2ZOWTNCQ1F1ZjNuOStpSzB2YTdtWTUvV1dTVFZDTklUWm1UOU1M?=
 =?utf-8?B?OUhYK256dUtCZk4xSURuVnp0Nm05UUdhK0srQysvcHZaVU5EQ2tCNjd2ZTNT?=
 =?utf-8?B?OUFPWExLc3Z5aDV4V2RDMVJLMjRhT2l1TE1USFNmckNVay9RaTlsRmhPNlFV?=
 =?utf-8?B?cFVyODhJMHpJdHU1aThYbHdyM3RnaEZuSDdGNWV1azFONG14anJDWFhzUmRM?=
 =?utf-8?B?Y0RPTHBEMU1lZ2UwNERMQ2Z3K1BOKzlRWVRycFMwL0pxQkxhL2d0Z052VVh5?=
 =?utf-8?B?R0hTQ0V4MUJiblNVV0VWdU1wRjJ1UHY5KzA1YkJJM1VXbEhHV2Z5OTN2MExQ?=
 =?utf-8?B?VDNTanZBaXRuWnJ3cjBtTnhFOVNLK0VBa0QvRlJjUHl3YzVncjBkRzduZC95?=
 =?utf-8?B?MVAxaHdJbUoxRmkyS0VoK1NmVkVKT0doUVl0dmc5dmhEdDlzb0o4RkVuQnRW?=
 =?utf-8?B?VnJCU3NTSXFTbkY3YjVZbVkzSXp4V0Q4OGIzSU9EemZrWGlhbHRyVzdNZWZG?=
 =?utf-8?B?aVhvR0czVDNBNGZXQ1pFS3Irc0dYTWhuR05nTHByZ1RuRjZKWHlhcWk2ZUxK?=
 =?utf-8?B?elNuVnVVR09QT2JvdU1tQ1J4Q09UdlU5OUVDMWZWSmtHM0RXZk5IdlpKdXha?=
 =?utf-8?Q?KV0omSs3gDQCvJ9JeUXnS2g6bF3UGqw+e3BmU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFM4WlR6dThkRkhnMU1QL3ZLTENOZFF4aUpXZFRvTlc4bnZSK0JzNVdYYmkv?=
 =?utf-8?B?bmtJbHJZQm9nQXk2ZDZpYi9lajY2bFJJUkxITUxLS1JDVVRtWmx5akdpRXF6?=
 =?utf-8?B?dW1SWk9TdlJZdmxLREtjWmdsMFRmYWtJTUNCY3RXUmlaMHFRWDNVeFFOVGRU?=
 =?utf-8?B?MGZqYmhCb3UxcU4wMGdiQ2p5enhnV1grT2x4MHNJb09rVWVGM2tHU1Zjay9v?=
 =?utf-8?B?VmErcU91dlUySHh5d2pzeUN3d0FaeGNrL1d3bmNNanIrc1dtMk9wajM4cDhI?=
 =?utf-8?B?c0RaekdLK1ZrRGh3RXZGR096empyZUlrdlFnbFJVTFUvKzFEUHNuZmFzVDN3?=
 =?utf-8?B?NnEzamkvbithaUk1R0xRZmhuL0hWRmRwU1llN04xZWZvQjJrNnhqRmFDeXRy?=
 =?utf-8?B?V0hTUElxMVI2eVUyYVRQSWUrSlQ4eFVOLzg3NGxhamdVV2d0RXBKNjUxdEdJ?=
 =?utf-8?B?UVM4Q0Ftall2ZEFXWHp1TWtMbWZ5Ujd3N21jNkNaN3o2RkpTTUhsc29rNEp4?=
 =?utf-8?B?cnUyelI3dm1WdUtTM0lRTHV2akFha2NVUjQ4TUZueVcwOE5HMWtVMUk0QVhp?=
 =?utf-8?B?TEgxRzNxVHg5SVFWYWdHQVZndnViWnFqaE8zc1Q1UDBGTVpwMnQxOXdjZVJs?=
 =?utf-8?B?Y2VONFhaMW5JS20vNW1RYzgwek1QNHBpQldtNk4zcDRaMFcwWnJTaTJFQmlJ?=
 =?utf-8?B?ZE02SnlqY2RlY3NxZzVBbFQwRGtxd0x1QitCeWdtVGdPaUN4RHRaSTlFN2Z6?=
 =?utf-8?B?QWhCdERCZDdFNUxwbGt1OUpGclFHQ1VaaCtyOUZTUFFXVUNZNFc2ekRpczFC?=
 =?utf-8?B?Zmt4MjNBdnJVd3RkWGZJMUhvSElOV0dIU3BMTEVXTHM0ZlpLTkxTRlhZNGoz?=
 =?utf-8?B?c1BkdUg1Y05na2xXWXlTMFpTRDdYSElkYXYza0ZHbmZqbVM1N294NGFWYndx?=
 =?utf-8?B?WE9wMnB1YituU2NWWGZVYXRaVGpLTk1hVS9nQ2RubkJBQkJ6TlRuQnNvM08y?=
 =?utf-8?B?VXB6S2FxTUdHY2tuSSt0RlFnVUZTVElwUGpUelVUZ2dyOGdaNm92ZDBlNGor?=
 =?utf-8?B?KzRZZVNIRG51d0JvYlprNjYxdEhsVDJObUprakM2Tm1tc1MzZ0I2ZFowWkFH?=
 =?utf-8?B?KzdaNEdiRHhSVXhTQ2UrcU1vblZ0VkY5dHJlNTFpT3dJMkNMak9IdnJQOW4w?=
 =?utf-8?B?TDNtaE0zMGVESW94UW9UTmtTb0oyWkc0S2xKK2pBUmlFcmduWnMwemFBam1T?=
 =?utf-8?B?bUtCREtlQyt1OHFPSjdwQldBd0k4WFlzTFEwbitWVFNXaFVlZkswUlp5dDBt?=
 =?utf-8?B?YlA4Zm9mSDBsQytXams0eFBCTTlXUU9uN3lPbHJQTzJSZ3pOMTcvaTBNNEdL?=
 =?utf-8?B?dTdnaUxLcitHRGU3SnlrMGxZRlVLZit3OGJqSnQyalRWajNlaDJRd0Y4S3da?=
 =?utf-8?B?S2FNZU1QQWYyWUc4c3pYRWtOTkR4cmprWnl4MU9INktMVW0rUnNsZ2ZFWnFW?=
 =?utf-8?B?alpiUllDYUFDbmtLUzRhbGROV1pJR082bGNDaEdReHBUT2dJSS82b0JjV29o?=
 =?utf-8?B?M3lLWWtUNnJlRGpvRUkvQ244bWRQZTNBVFJNTldMY1dVYkE0Z0Z1OTcyekl3?=
 =?utf-8?B?ai94OVM5RU9nb1pWYXhuRUxzOTE1bE1YRWJKbUdzMytQMUV1eUcvMmQvRTZY?=
 =?utf-8?B?VUduOS9EOFZHRUtzWXpGTHQxTVEvZ0xQZ00wRGtzRjd4K1dJYWN0cHl5K3lF?=
 =?utf-8?B?Szh5QStaVjBYalhBU01sNGJlYmcxM1hKWlpGNkY3SjNRMG16WXkzVzZpcUxU?=
 =?utf-8?B?bC9UMTVUWTVRTG5mZHNOeXdRRmQwcWJoSmFiZnVBUjQxNm05RnZPakkrTWRK?=
 =?utf-8?B?eFBiMkN5dnp2Y0dVK1djdXFiYlUyOVljQ1crdVlZaUVHZ0ljOFBRdTVPUFNy?=
 =?utf-8?B?Rm5xcHdoWWNjK2Q0aG5xOFNKdGYrbWUxekFuaGJLY0tSQWlCaDk1eTA2c2FI?=
 =?utf-8?B?MWk0LzZkTHdFLzF0ZlNVQTFHT01MZ0pmdVhWcWFqSEFHNkdFZWFvZ1F2emhw?=
 =?utf-8?B?NGZ3TEhuZXFMUld1SHA3dHNIVTNzN1RMaW9weVBNQldKSmhnN01yczZnZy9l?=
 =?utf-8?B?TWFYeUxPSStNcVdrLzF0L2FZenRUdVhSQWVKd05zdzNYOHMzMWppZnF4TmJP?=
 =?utf-8?B?T1p6ZEdMcEt6TGtCMG54OTlwRVFMdXAvK3MzdHlpbWFsckdpLy9naEpmYmpK?=
 =?utf-8?B?ZTVpclN1OTR0dkZCMTFFM1hmbE1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <375A9DDCF77ECE4385ECEAB011B4BE61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MqqeHalNlztqCG+5gGVJ+pOWQXIKVGBhdaqy8kCpsHevrd65H8aOGZuMzka21eLKWDyToLj6XsMGMtz+KCMUQntIWV+b66v4sr3NDLBJWfehWYtfMSC7bfloloEcHh80ZPnja/SuZ098e0VJdSP+7WCah0ocyMb9n7XfXEAK2/nRfMoC2QzPbnrspAoLhEE0opl5swYOLyQKIw4zQ72KfcJzh1zn9ZSlh/HEUmoibQevM1XAVwi0eICATXynm9ktKXVC6V7fLESrJ/QqAQnW//nO/oxiWQkwxyLAP0CHc14sCE6b0ixsRSagkiBQtK1bnKIF1Yl+h+g8foUm5Hkcc/PYLX4pK7qrt4J4Bqzwx7ZVE08g8UFl9O82cIUTkt/eEcO4ZmDaf8x0iynqYZNMImyCTEXx0aNk2hVqb5zPjSUKOi9zU2vpyR8FV4f5Hv3GOzM10w5XL6Rjq9l+dgyduNj051N3JDbzjwxbBVq8Xev3rIVxV2HAS2BMhym/PP3rmQawN/rF0TLqs+AJkJWImyQT3ewBdodYgqEqmqtiZRN6/PdN4NKQwtOKjsU98+GYfaSRUiwE35xweOnJ/AuNnSRnBoTv/8Z6YmllYOZbLpAOrRXy13r+Kyl31ww6TU+4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298f5a4d-6770-450c-d276-08dcfcbddbd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 10:45:54.6982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBo++MnkoAQmTOfPdn3PjGoWpjN89ppgBo9wa+DTzeK2nCO7g2SWZHcalGwlVysUqVEfmgLiFebPnHTDhRSiRGMaeqCrd3Ti5dF0zHrGFOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7690

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

