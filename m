Return-Path: <linux-btrfs+bounces-18626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390FC2F3E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782DC3BEAD0
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4814F28541A;
	Tue,  4 Nov 2025 04:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R3a5CxZm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA41E3DED;
	Tue,  4 Nov 2025 04:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229114; cv=fail; b=JnQbEEqybNmEns1AM7WP33sp3TeL6gnTw9yaXn5EkCsfPwhRKmnooI7g77YJ2bv7Hl60VSODeDbzSjcZpiyZV9v/DpbSh7dH4w0uHzJeYT4hO5XfVJscV9YKhkXZWhNUn53W3fC9bGJlRuOLm12shPcyO8Lq+68T3Yv/r0C2cDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229114; c=relaxed/simple;
	bh=zGzrV19jIVV/0F9Qdfp7vyFw2NyWMjvDM+xFdwr744Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n7qjB8370CeUsU3p3m46yjpcuesl4+fq7FVU9ihfm2UFzQ10gXgqs8AfjLZYdBJNiDZ9OxEMCpzQ09uK+f9X158RdKqpk1k5RRZ5DNCzmzjQK5dVrQMbD+yb5NNs4zmz1Ab5vJodb/QTFMNMjD52KGb9vzO93JEvGYflD3SfvKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R3a5CxZm; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1BdhglbQbT3GbvIaEfbX3MkCRlsjQPi1YqdJ6w2118L8P8KPE+zOtiIput1VdwW08vhPDuwXbJq635zURrdlRfts7ShZpzTwJqhbzBSBguNPd+T241E4CerqE7bf78sAIWE+HuP9AQPBbHuAsKdwkgR5Hm2Oy4oOJl0Ncr+rJHOiLTFKWWZT+QnSKPircM9wvbkUMvWNBMhdjDz1sG9cIXL8zpraKVImId7JGeP+f3axyf6OKEMxCKU9cnPbJiXCX5ZfbjCjjgSRV/b3jmdKmDUro7yNjXomZ7FawfwwERQ7tnD7VS/TygaVk/wVMop6d0n9Dct1KlMaru4nS06nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGzrV19jIVV/0F9Qdfp7vyFw2NyWMjvDM+xFdwr744Y=;
 b=UJGaQ07UdQmaE3LpAKbapP2HdnSsuFikQyJ/Z+FL6WV3Ra5UMKCjf1oLMKj87ZmCJ/u+iqILB1khM2tVyLxqNnBpJjqBBvYmoGJcj6wmFoj6OsxUpFSsl2islzerQGHwbDEwV95EbHf8DY2EeG8ROQ/I/SV3kZGykyor5Fy32hnYaq8klOGpjjaMaQ9YXVabClYmsv+elm/wXyBUIdqvnnm0W3HXv1MF2wdnY9tLRX/JwRWzUg+9hxBYmis8ZezQq3CSF1PxsknTuobePa7CIL7RaGS5vSuEgVhuGm+XrAjER2SEkDR77ba+uIGrQKF7NRvHsC16JFsD1J1MxZZBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGzrV19jIVV/0F9Qdfp7vyFw2NyWMjvDM+xFdwr744Y=;
 b=R3a5CxZmoKLoWtaps2OYiigtq8EMMl+OisxkeiM8aE1lh5Duxp2TA5YPxeBFGp/u37msgFcja4rz24Oi23ah3fBx2Z3xHSS/JhAbSXWLBdx11dWt2gGW7ZvKVjV/2FPRzjWZRdmzZKlVshv4DgQ/dZCDUuzAswh6S9fJYG5DfeRF8Xg0dCdrrw/NaozMf4BIdQ42VsPmWVaLUDfcPJs5V/JsOfB8IqO+YBxzFDAD2K5W0PD0VZMtszOLVDoIkHJBkc/8piAvVn/Qv3zNOnV8Jc7Ya6o/W2/tVCrMjKKAi0AqNMZh5CCIZWjBIAlcQKGtBvxbKrk5tjk+uUvQK6hBRg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:05:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:05:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v3 04/15] block: introduce disk_report_zone()
Thread-Topic: [PATCH v3 04/15] block: introduce disk_report_zone()
Thread-Index: AQHcTStjrrxyogATq02xanHlxB3PzrTh5hYA
Date: Tue, 4 Nov 2025 04:05:10 +0000
Message-ID: <4549d007-d431-47f9-afe1-9ff2ac174cae@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-5-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-5-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6853:EE_
x-ms-office365-filtering-correlation-id: 0c9b9eda-8685-4489-f24b-08de1b57592b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?STJYalVnMHRiZzVVWTg2a3NWT2w0MVBNbXRKRC9BcS9YYS9wVWRPOGxiZk5M?=
 =?utf-8?B?RXpncUJQTVFpM1ZHc1czR21tdnV3RHdJc1pjbjdEWWgyT2xXbkN2QldCbExE?=
 =?utf-8?B?WDNHb3ZQYzAvbkl4TW45RDBySnJnbVNKWEpmZERrWm1pSi84Tks5b2FJZXcy?=
 =?utf-8?B?WHZSYjZqeTJqQ1lVWTZxNGdIdUNkUkZOcENrV2E5SDVHODM1Uk1xcUVsZXE5?=
 =?utf-8?B?WXBnNXZEY053QWJuaFpkT25ZeEFCcTRxOCtQTzNwcVBaZzUxZ240aFl2bVVM?=
 =?utf-8?B?LzVWR3UreURnMjBVS3I1SXRVSDRRN3NKVUppVWdLdzZ4N0RENDFaUlhWUFRU?=
 =?utf-8?B?QUZpOEE1OXdVaFBKL1BLSnhWZDgxRldOcEVuS3lqOHUwQlc3YjIrOXV5MW5E?=
 =?utf-8?B?SlhYeHVaRXZrWDBOTW92Q3lBZlUrOG9CdXE2RCtLSHRlSUJoTFM3aklySjdL?=
 =?utf-8?B?amx2Sk5YVkh2RHJkZ0hvQ3RiWXpFTkZUa0JGQm1qd0NkT0xXZE01TlNpWFlR?=
 =?utf-8?B?Zm13cDJoSUVOekduN1J3R01jT0R3eXZydWNrYzBWR0hvcnZzTlIwZlYxWUwz?=
 =?utf-8?B?cm9rQUIwQS92UCt6SXBQM2ZSeUwzbUkwbkVSRkppb3ZUVExtQ3lmWXdXUFRT?=
 =?utf-8?B?Vmxyc2NSOVEyd1V5UW5rVGNaLzN2d1JsdXFrNDhZU0ljeGJzb3FGdGpxczVy?=
 =?utf-8?B?T0MxQ3pJeTJ5eE9FeUpiaE1wTGFvYUJKN0xEUHlDWXhicWtMS2NDUXlSeTFL?=
 =?utf-8?B?N2pESEhyZlcraEJoRUVVMWd5Q2o2WDNEM25nMmphTHQ4NHdHSEprdUFkREEw?=
 =?utf-8?B?UzdZbXVYcnI3MGNQT2ZBTXc2eEg0dU5nam1HdjA0c014QXdoRWsweDBCeEMy?=
 =?utf-8?B?WGFNVkhtS0hXVUZtZGJPZWhFS2VGcG15VE1aMGxYNTVwL2ZSeis5NHVjMWh2?=
 =?utf-8?B?eGVUaFBtam9LdzFpbE12L1hQVTMvK1RFeEhGcGZtWFRiM0tqUFJ6MXViaG4w?=
 =?utf-8?B?MzY3OVBLWlFpYXBFR1llWjFlelpyRHV4cmNVdFkwZ3NSODlqcHJUcHJZUlVv?=
 =?utf-8?B?L0o2NmVjNENsem9jV3VsT3BWbEhqcUtLWUdrQjRySEVIcTAxWnEvVElUaGpv?=
 =?utf-8?B?K1N2azA0eWx3ZHdEa2FEemhDR2dWajFiQmR2emwzY21CZk9vU2p1RGw2M0M0?=
 =?utf-8?B?eG9sVnVyZld0K29NdGw1a2JMZ0J1QWR3Rit0MHI2YjM0VEQzMjFHc2thdkN1?=
 =?utf-8?B?YzREZklvaG94TXN4bHcxUXRMcGF4Y0tnbVJ1MlE1ZFNlSHpJeUVyeTl5RHgx?=
 =?utf-8?B?WENsaU5kM2tJRzFBRWp6c1c1MnptN0wxVmxDQk1KUU00UjZPcWFQRlRHSEp4?=
 =?utf-8?B?cTVvaFo0WXFvdjFjeFBnZnlPcGwrajBzd2lIeE9TMFg4aTh2M1dwZVNrTVli?=
 =?utf-8?B?T2VFM2QweXNnZmR2c2dZVzZWK2J0YnVCYkxKeStGbEFCUmNVdFBka0R5aGtI?=
 =?utf-8?B?NmhCSWpWSVVRdjZ4MDFpOC8rQnFCeTVYL1lUZzdacmZRN1dFS2pWblVjajVT?=
 =?utf-8?B?djZEWDNscFkyOFFUbExma0swaERUL21sYkR6cmVvcmVWK1BEc2ZSd0FXZDg5?=
 =?utf-8?B?UUNXNEs4cnl3aHk0MjllTlNncTFRd0dHR0lUYThlTWlURGpmY2wvNDNsYXlJ?=
 =?utf-8?B?SnJHSHNRTk4vU0dNS1VGL2MraXlWaE5kT1I0OXdIUnU1U0xQZkpBRGJiTG0r?=
 =?utf-8?B?UFJBNDUvQWdIV0x3MW9KR2lLaUFmd0R2UEg5b3o2QTgrbDJwY2NaNmVKbUFy?=
 =?utf-8?B?WW5TU1dmcnNoU0k1djAxdmhTK0JvdkNLRWJsand3SFEyV3lQUHFWOHJoVnJB?=
 =?utf-8?B?VHBNeENaK0tlVTJpZi8vbG0weHFGZkRKanBWOUYyTDdMeGtZTXIvdk1RR1E4?=
 =?utf-8?B?T04zU1ZTTUV0anBicmdxUmtWMVJ4b1FjYjRKQzEzR001Ly9KVEJpS0FzQUc4?=
 =?utf-8?B?eiszczMzWDM2d3htSG1CbGR0MkZlSUVsS3ovNWRLTS9GbVo1cWk2ZHdxWFht?=
 =?utf-8?Q?KjSTO4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEphTnltZkxCNTBhNjQ2RWVOMVR3QkQxSmd4akM0RTFtL3pQa2x6QzhYUGVZ?=
 =?utf-8?B?WnFHdURhNVRKaFg4MXM2eG51OVpaYk5pcHphdmgwMEYxMEEvVnBWTFFoNGJz?=
 =?utf-8?B?OVJ0c3F2NHV4Tnl2RHpyRDg2TjRlODJtcHFHU00xSWl0SXRqQmlBZjBValNL?=
 =?utf-8?B?YzZrQ09JRDdtQTFjZkRiMkVWeDlLTlVwTXYvVU5JRVVBR1NmeUcvQ2hJWkJq?=
 =?utf-8?B?VWpyYjAxRnU0Zm5GTy9Vbmw5bnUzRWlidm1NbkxIb2NkUE82VXc5RC9yd2dW?=
 =?utf-8?B?R0NMRUt0cC9qRDFZMmcxVWd6ZlNORmRHZTZnY3dsNFljR2ZqYWErU3RsVmc4?=
 =?utf-8?B?OHBYUjQxcGZpOTgzakRtMXFOWFRwd1RBVHRtcm9VclVmN3FzcnlFUFVvTjds?=
 =?utf-8?B?cHFWa0xWYzYxaTh0cHZSOFE1ajNWeHlGREg0T2dQeTkwSDRtNklVRUtvc1Qy?=
 =?utf-8?B?b1VvWmQyQjAvNjZKb1hnZXE3NVBrSExhZlgvRVpNK0toeUw0MUxoNkh4dVZz?=
 =?utf-8?B?Tm1HelRSazhTeGdVeVNmRGRCeUo1QlB5SHpTdmlJL2p4RUdQcVZHTnkydWov?=
 =?utf-8?B?bkZoVEFRVFlvdy9pTTNab0xNN2hxL3ZIWkRmS1dOdG5tOFdyQnZTWnNRaGhl?=
 =?utf-8?B?TkVrSVRPbUwvT1JHQ1lwSDhmWU9mTUEvcmd5dVNwZXBhalpPc3gxUjZyOERS?=
 =?utf-8?B?aTE1S1dnUUJ0SDAxMlJNVDBZdC84Yk54WUk4NjlIajFHVExwZUFjQU1DanJ2?=
 =?utf-8?B?MU1sSHRSVWROdDV3WmVabXU2bHNjZ1J1S2dYOFFYMHVXc0VkSU1vUHAweklX?=
 =?utf-8?B?U3RpMkJLS3RkWXNoMTZOd2QwZVkrSlRpUWFnL001TFFxN0pkTzV3dHB4YVZY?=
 =?utf-8?B?OVAzd1dtaUNwMVJ4ZUxSNDFxajdWTjRMMEpONFJsQ3RzKy9ncW9RNmxadXpB?=
 =?utf-8?B?Mk9nN2tWeXY2LzhWOVVNTHNVbkhkbHhtLzVOVnNTbFUxZEtBRDNoWWlWMHpE?=
 =?utf-8?B?OUxQV3FENDZaVWl6ZXJLaThwdERNSElPSVI4bFIzc1kvdjdVdHlUclUyNC9l?=
 =?utf-8?B?UWNDc1cyNkFRMyszMFhjcEZiRXZaZ1E0dFc0Zm0zWmdFU1dLcWEzNDZyL0pr?=
 =?utf-8?B?ejFoenJaM3hxUnZNOERLdUM1MjI5WkpCdE10QlN2S0tGMjlpRHRkTGhpd1NU?=
 =?utf-8?B?bkZvSnkyRmljSE01MU5TT2IrRno5VlY4L25FNGFPVEY0OXpaTVNvZmZockNK?=
 =?utf-8?B?bkhvS1FlR05YdXNkZFUvYW40RWU2R3ZrRFZOR0hKZCtTTGVlcGFaZlVIYWJW?=
 =?utf-8?B?aVZBWFAzQW5JOFJzYlZLMFV6QTNkcGdLM0dLZ3cyQ0NMSGMzR01aWmlJOXJE?=
 =?utf-8?B?OHdaSWpGQndhd1U3TU9BYXphMHlla3FZQXZqZGRKQjFnZGhWSDhTRjFYaWxv?=
 =?utf-8?B?T2hvSlg1Z0NxVzJKQzRrRUVENWVtaDJjd1hQa2JEUy9PRng3SlQwRWYvVXVL?=
 =?utf-8?B?d2ZZNTRhdjdlNXlzQzllZWtzYTU0QUhPRjU5aUN5Y2tmSWd2YXEvdDVrOXJk?=
 =?utf-8?B?TGtBOWtveG4rZm9Jd0NDQjU0ZDlla20ycVFad3FJUFBoNXA1bHBsWlBkNnRV?=
 =?utf-8?B?ZzJEei9maWJrQzZtR2dwNlZqQ0t2dkxuYkNoMGNVbGgydEtSUTFXL2NHYXh2?=
 =?utf-8?B?NURhSWRzT3RxajFkMTgySlR3QUxIaFYrM3FJR0pHUzc2VjFFMzdIRUYyN3hC?=
 =?utf-8?B?YnJnQ3FUS25DbW9ESU9QWGsxb1ZQSzIvZHZyTlJFeXYxVW1ZZ2NicVNmUWlp?=
 =?utf-8?B?REZVOTh1dVZWT1hZb3Jlei9abDJqZmVRSXY1b2JnMFJCVzd0MGhSRFZqTm9T?=
 =?utf-8?B?QThZOVc4QVY0K1poRExNeVNYRlI0ZjZEZVBBNFY5Q2tSR0loVmsvQXBhSE1z?=
 =?utf-8?B?cDQyRzRicWovdHpFN2xLaTZlQ0dObFJaL2F3ZWF1Z1JUaE1MK0ZWcXljWHlp?=
 =?utf-8?B?ZjloNW53YjViVFkxc0tKbktSTEl4TGxMNFFrb2x1VnByZlJOYXBBTHJSM01E?=
 =?utf-8?B?Z08rNnJlamw4VW5uUVNPRUZ6NDZpV0NKWXkvVWoxNXJsTUorTGFKR3psTlN6?=
 =?utf-8?B?Z2Z6L3M0WlNRWEpKajAyenNjcDIzc2RwQktSWlYwTVVMdVlWSk8yRUpPcHlk?=
 =?utf-8?Q?Y6/gW+TCvrEg4li5myukVQh6RjJbqLc2LOMitu0UNwpH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <709611ADACCFA642B7753BAA9430AADC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9b9eda-8685-4489-f24b-08de1b57592b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:05:10.4258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svrrsJMhx7N1zxEVhxV1qRg59ApIm0ZLH7Y5Nppxr0IkKRBQs7worX+W2a56tC9AGe/6GQ6lDsEhcsEQRpTOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IENvbW1pdCBiNzZiODQw
ZmQ5MzMgKCJkbTogRml4IGRtLXpvbmVkLXJlY2xhaW0gem9uZSB3cml0ZSBwb2ludGVyDQo+IGFs
aWdubWVudCIpIGludHJvZHVjZWQgYW4gaW5kaXJlY3QgY2FsbCBmb3IgdGhlIGNhbGxiYWNrIGZ1
bmN0aW9uIG9mIGENCj4gcmVwb3J0IHpvbmVzIGV4ZWN1dGVkIHdpdGggYmxrZGV2X3JlcG9ydF96
b25lcygpLiBUaGlzIGlzIG5lY2Vzc2FyeSBzbw0KPiB0aGF0IHRoZSBmdW5jdGlvbiBkaXNrX3pv
bmVfd3BsdWdfc3luY193cF9vZmZzZXQoKSBjYW4gYmUgY2FsbGVkIHRvDQo+IHJlZnJlc2ggYSB6
b25lIHdyaXRlIHBsdWcgem9uZSB3cml0ZSBwb2ludGVyIG9mZnNldCBhZnRlciBhIHdyaXRlIGVy
cm9yLg0KPiBIb3dldmVyLCB0aGlzIHNvbHV0aW9uIG1ha2VzIGZvbGxvd2luZyB0aGUgcGF0aCBv
ZiBhIHpvbmUgaW5mb3JtYXRpb24NCj4gaGFyZGVyIHRvIHVuZGVyc3RhbmQuDQo+DQo+IENsZWFu
IHRoaXMgdXAgYnkgaW50cm9kdWNpbmcgdGhlIG5ldyBibGtfcmVwb3J0X3pvbmVzX2FyZ3Mgc3Ry
dWN0dXJlIHRvDQo+IGRlZmluZSBhIHpvbmUgcmVwb3J0IGNhbGxiYWNrIGFuZCBpdHMgcHJpdmF0
ZSBkYXRhIGFuZCBpbnRyb2R1Y2UgdGhlDQo+IGhlbHBlciBmdW5jdGlvbiBkaXNrX3JlcG9ydF96
b25lKCkgd2hpY2ggY2FsbHMgYm90aA0KPiBkaXNrX3pvbmVfd3BsdWdfc3luY193cF9vZmZzZXQo
KSBhbmQgdGhlIHpvbmUgcmVwb3J0IHVzZXIgY2FsbGJhY2sNCj4gZnVuY3Rpb24gZm9yIGFsbCB6
b25lcyBvZiBhIHpvbmUgcmVwb3J0LiBUaGlzIGhlbHBlciBmdW5jdGlvbiBtdXN0IGJlDQo+IGNh
bGxlZCBieSBhbGwgYmxvY2sgZGV2aWNlIGRyaXZlcnMgdGhhdCBpbXBsZW1lbnQgdGhlIHJlcG9y
dCB6b25lcw0KPiBibG9jayBvcGVyYXRpb24gaW4gb3JkZXIgdG8gY29ycmVjdGx5IHJlcG9ydCBh
IHpvbmUgaW5mb3JtYXRpb24uDQo+DQo+IEFsbCBibG9jayBkZXZpY2UgZHJpdmVycyBzdXBwb3J0
aW5nIHRoZSByZXBvcnRfem9uZXMgYmxvY2sgb3BlcmF0aW9uIGFyZQ0KPiB1cGRhdGVkIHRvIHVz
ZSB0aGlzIG5ldyBzY2hlbWUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsPGRs
ZW1vYWxAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBs
c3QuZGU+DQo+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

