Return-Path: <linux-btrfs+bounces-9320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BC9BB174
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B70284A3C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D27E4C6C;
	Mon,  4 Nov 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o/wzPJ7j";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Xf8uAgIM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C511ABECF;
	Mon,  4 Nov 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717159; cv=fail; b=ipMnGPg+wQvHyaNJUQTd94bZRh6eXWIs9URhZ0avzGXFncTaNcBNLLVdOrJ6lhB44AbEAMsegCijp2mK2OcntSl//eCkGhRSyE2QT1FV5+q65YmJwikBWjWTexEEjgIansV/8w4UeS1F+ZoADXXGs9b70+PSNxZ6/6dblGnapP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717159; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Am+zhuwJdxqyK2BuI69MjKcih6r77OA3fb+50I8Sf+CzpQIoCQkHqw23/F/fByKLRC1+A9J22gfLDWdG1vNZ878rcIikEloHDRHSkn5HQPbsQCP/fcEp41IR8eH1KxaUv73l4tDpgm8nxnuL3kGrZz7gGMQwb6LJRhaBiRKLFo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o/wzPJ7j; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Xf8uAgIM; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730717157; x=1762253157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=o/wzPJ7jJz8CRXxMC53n8Bhiaie5n+nUAocDqtSDR9Oua4WjvtJbdSHl
   iheIs0qvwmoicE9qoZZMI/VwL3efBW7GaQnubA/geGh+5OiirjeNX70VC
   GpMyuiVwKiKIEQWn2vRNjwjPESPTtbYHwmTCyP6jhxQSntuSv/W+HZz2T
   3Bg5jU6R5nY4rYKUv9b0HLoW9SKHnRISJcqB8L2PoNQr/i9p0O11Cqm9x
   w8eJC8pgq9XtYvadHfJ1mKLLL46fKe20E1eQVbqQGHFXzUHCditdvSIGC
   rn97JH0q4oi4WKOynQXuNh3xLwsVAcxzdl3vX9sRJl0psZUFyyDyMKH8Q
   A==;
X-CSE-ConnectionGUID: DUjxAmfpT6GJGZKvgnRLgA==
X-CSE-MsgGUID: ock8jempTASs8CWrjNEYgQ==
X-IronPort-AV: E=Sophos;i="6.11,256,1725292800"; 
   d="scan'208";a="31081370"
Received: from mail-northcentralusazlp17010002.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.2])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2024 18:44:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUEZ91debhcLgzt7yYZorEYWYIB8HySLobHTj6Yo/HhT7CJusOMFOCDFIIhdoo85ljQfB1x0atcZqsD4efYIiuiqXTTHaYVZTGxSJRnVkEoDm/Lb/lsEOFOawRf9RDPJp29qqn1qsVBCcnzkK9dSKIWkEaJopY7skgX+OunzcYjreZaWgVoHtbP6vWZP2J210FKu6xOnNh8ehh/Wsevq6WPOsQadPPEcT2Y4cKAO1fLp1KTh9yIBgG7Qb4vo2QQ/QJe6eZHvMJPs/7gZXqwpWA9eaE4MFfvsxEBr66ekkaC6TTpBWmlVo/hIikayg5MrEWDReWpqL99o7KPj5NMVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=X/6KLL4bZEG9L0DhL8NI+6Vp8zI8JRNW/cZMh82+4MArvw3UFS2rz9m2jpYZAl7bchE69xif260G4uszr8Hf7LVAef67l4unTwKl4H6VIIkS8FpbWn061X1L+egTVXNrE3tnjiSmQWdzSFDpqWHok5Yvq6npz+XSTq56QLgEbTNiUuFTM0ImfxKaEGO7MzfJ/K4oX2MOg2ipghfzsnbUA6f+RMgbt120pHHGQujlteU9+ddnK5DGikU2+8z/JY+Bpf2SjFvh9SwifNX+bcH349EscbRtJGtVqdlKYdsclOB/KHq+OfGAm/mnMUkN56LO12YKPHU3CjKMicHBLL6oVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Xf8uAgIMdd+MYbVDK0gDiDk2+krgFtUa5W1C03AlR1ajqAIB4aJE3ulW4b95pEU5uVezDF+3X4QgZT/yG3JMkZ2j5ghVRDUvn/LRRhBM4k0yO9DKxuJk2KFv2jH7tEYK90zfYuwa9r7w92Q1PIWVql1C+dVUvRavJM1jFQYkJm4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7690.namprd04.prod.outlook.com (2603:10b6:806:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:44:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 10:44:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] block: lift bio_is_zone_append to bio.h
Thread-Topic: [PATCH 2/4] block: lift bio_is_zone_append to bio.h
Thread-Index: AQHbLB4QKqKJLIUjFUu2WeDbB0178LKm9OQA
Date: Mon, 4 Nov 2024 10:44:46 +0000
Message-ID: <2f31f558-37f4-4e5b-9ba3-45a81b0783f8@wdc.com>
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-3-hch@lst.de>
In-Reply-To: <20241101052206.437530-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7690:EE_
x-ms-office365-filtering-correlation-id: 0d70f26c-110d-4d8f-d185-08dcfcbdb355
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGhWSG41enhMUDQySDZ0bDA3dUllS3hPbTlHNmFWYzZ6WGx0ODZTc0h3aStx?=
 =?utf-8?B?ZFFlMnZZbSsvTm5EVUMxMDZHbTVpUk1BU2QxWitHci9JVWpkbzgwOUZUVUdl?=
 =?utf-8?B?eUNpWitHWXltcXh6OWRlNXJpSHpyQ2pFSTBEWGl3MFdSTzU0ZDh6YUVTWTU0?=
 =?utf-8?B?NXNsMkR6dWVuNklaZkMyZWVkczRkd3p6Z2hIamR3L2ljY2szZkpseURPd3hP?=
 =?utf-8?B?NzN3cEorTVZnRlM2WncvNVNhOWhiekVJakV1L1JMMGJEendHRDY1YnY2MVRP?=
 =?utf-8?B?NWo3ckw5dDdSN1NsaEJUZlpEdU12Qi9zZUpOZ2daQ0xsVWFtOEI4YlFnT2xQ?=
 =?utf-8?B?TS93MDFuYlNqNkVHTCtzeFJoWUJXQkI0enVzY09ZUDVhMUdReTRNbUpwai81?=
 =?utf-8?B?T0pjUnEzVldTZmlVTDM4TFNVb3kvbEtLTXV6cmZxU3VWREVPUXdoZTRjdlNJ?=
 =?utf-8?B?RHVlQkoxTGFjdFY3WFJPNzZVNU9nSVo5cDZUcTVsSENrK0JPbWRYQ1U0NVpX?=
 =?utf-8?B?THF1cXVNV3FDTVozYURyQlVyMldBOHBoY0xRaEh1ekhBQXpMSG9WRTRWcGZV?=
 =?utf-8?B?NUFHZGtMZGNHTEhJSTZzMEdueUZzWXlJWXBhMnBYc0xqUXJVcVZZNEx2OUtF?=
 =?utf-8?B?VjF5T0VlSHVqRjRmdnJYNGQrVEsyai9ZSXFhbkJHVW1oNkVCTjBvZFZrUVpy?=
 =?utf-8?B?VC94QmUrV0F1cUUyTjIrd1MwTGxrSWY1NFNYcjFuanUyY1B2MzZSVVgydkI3?=
 =?utf-8?B?OHRTWTEvUzNVcmRLTHFJU01rT3U3NVpEOTF4RytkVGk5V1ViVUxRQmF3YzVJ?=
 =?utf-8?B?ZU96dFBIUlFlczRHajgrY1crVmhjVXZMeUdGYnVvcGpyZURYalNVWUdBbzY1?=
 =?utf-8?B?NDRCOFNDYldaWEpDb3N0NFg2bUJQZ0FkR3o3eFJhNVZCSGd5c2R3YzQwV3Zn?=
 =?utf-8?B?cUVLUFVIdEZDT2lycDEwVzVRMEVRUGczdlJxREpmOUUxNCtSbDV5Wkw1SUkx?=
 =?utf-8?B?U0lQeWhUMTFybWU1dUJxNTNrMU5qQUxrMHRYekZwdXZhUkY3eU1pakYyZVdt?=
 =?utf-8?B?NDFOOEJWM3BzcGM0N2dtYnNnUzM5K0pkWksreDAxU2hQRm02aWxVYWxXNjVP?=
 =?utf-8?B?QTdROXBBMHhKL0hvUXhZZDdCRXFmOEhkRzBTWGRsdnAyeVJRSW55MmJsbERs?=
 =?utf-8?B?NnExL3h4ZmRVWU1pdkZRVkdaSlljNXhjQzNyK0xQN3doMVFSNTVKOE1iM014?=
 =?utf-8?B?WFNEdFNLRG5rN1RhWUVOVkUwNDFpRlNUaWpUcFBsL1RacE1MTkJDNCtqSGp6?=
 =?utf-8?B?c0ZYdEt0VXAvUjlXem9DQW9lbzVDQWxqaXRLTUtZQUU4RmUzSEFWOTQvZy9F?=
 =?utf-8?B?UDJ4bi9mQWJzbjdjQkU2SmVteDJRNHdHYTJLSmh6aFpXWnZuNlNjNkJZMW5r?=
 =?utf-8?B?elF4eVl2eUJLU2lTRVNQc0p1UWtncVI0elgrSTJYK2hhUjRja2M3SXp3clVB?=
 =?utf-8?B?RUkra3QyeEdaSGR0ODhBbEl0dkdSSjMyTml1Mzl0Ui9meThONmRNcUVpdU11?=
 =?utf-8?B?YkxCUDgyRzJVVzMwbjdXQWE4Qis1aWtRNlhGYmZUM05XYWlIdzhncFgvYklN?=
 =?utf-8?B?NUZyRExIUFRLYThLSTh5RW80N1lMS1dLRVAwczZsSkI3N21xRjBZK2lQZjNn?=
 =?utf-8?B?aENBUXFqY0ZaT1J6am83R1NSbGgrZmxRcUh4T1UvQ0RaRXBNeWxjUmJBTGEw?=
 =?utf-8?B?VzR0SXZHTlpNZ0Yrekk0LzZ1UDArWmJCMy9ndWIzOFUxYnFRL1NNWmtkWFZt?=
 =?utf-8?Q?h8zhQkMi4fKzzLAy71wPpSnqLIc/XA64bARi8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWNaUUExTDNOdEJMNng2VEEyY1RMbk1LZldwWVBkdktLaEF3WEoydkM4b3JI?=
 =?utf-8?B?MEY0d0ltSUluN3BOYWpsTWlHamlrd3liVmFzZ29TRXNKZ2VkSkhDU0hTUGQx?=
 =?utf-8?B?RURYRmNBaU9zWnVuRUxtOEM0YTBxcUEzaDgzTWp2WC83NFEyY0ZPdExMTVAr?=
 =?utf-8?B?cEFManRYa2xCRjJlQW5VdkI4TERPU1ZuSzVncTdoaHRsNWRiUXlVS1puRXhL?=
 =?utf-8?B?K3FNSXNWdy83cVByTDhUUm5hSVMzYnpLVkdBWHZBdzVTSUw2R3ljZ0trY2VG?=
 =?utf-8?B?WDdZVVIyZ0hoMnJ0SEdJTmhoek5Nc09Bc2hwaThIdXBaMkFmVzU5WStDRmZB?=
 =?utf-8?B?RHRaaUxMcUZNWXE0YXkrMEpyVTJiQUo1alJCZ085WjhaaFQ3alJmWFBUUlBy?=
 =?utf-8?B?cE51eWpRT21iaVJEWHNLcGxQTllESVEvRkZqcnkvY01QWm44NjdaSi9DSm5K?=
 =?utf-8?B?eThPanZqNC84dERNTks0WlJ2Tm9kaFRyVnVsVjlRbEZwOElVWEd4dmZmVUw5?=
 =?utf-8?B?ZWtRdDlGOVhGZjVTUjJPVWovVkJsTTNSZHhIVytxK0hpMU5tMEZaNWdWUmwz?=
 =?utf-8?B?YnZrd0ZXTHNKYy9RRGU2YUtYK0tRVG5hQTlGeXR4UWlVcjZieUI2QUlYc0dD?=
 =?utf-8?B?NDFkNmN4UHJmUkNHeFFuck1GeXNuaHNFc3lyY2tJcHNtYkNZZUQ2alpjWmpo?=
 =?utf-8?B?V0ZndTVyMFM3ejEyRWI4VFlKOERBNHhuZVJnNHFoWVpBTlI0N1FFcnpHbDkz?=
 =?utf-8?B?QTE2M243RkRwYmRuL1ZyMTJSY0MzOUVuRmVvNjhmak9WSXVFTjBManpDT3lR?=
 =?utf-8?B?MFZUTi8xWkRjM283RDRFWXZGWWxGVHREL1ZPWEtTUVRFalYxSGRONzlob2dl?=
 =?utf-8?B?V3gyNldSOXUvNkc0aUEwUFppZFN6cDFJQUk3akhqalR6Y0Y4QWpHSEhSQ3Nj?=
 =?utf-8?B?Mno4Mm43MVU1bkoraU5meVpYZVgxZGdkaHJHeVlNamh2OVpNMFdlOVBPT09X?=
 =?utf-8?B?SVFnVEFSQ2RWUm05Tk1NRnFwL1kvbjRFbUIwZk9HRHkzMFRET3ZPQmtFRlYw?=
 =?utf-8?B?Z2FCRlg3T2VYMUh2a0J6WXlzK1JoWVFYcjV6M1FRQjAvUlpxMDV3Rmc1QVlq?=
 =?utf-8?B?cG42RGhPclhlMTBESXh2clBYWEdmQ1gzWi9lNnRIcFBKVCtjb29yNk5jVWNt?=
 =?utf-8?B?amlVKzZwUXNXOGJNaTlDcW1pQXBGL24rK0krRTZqNHVsbHN1TFV6Ti8wbkhi?=
 =?utf-8?B?L2ZFR3ZvMk0vNnhQaUU2SnNtWVUyWHJLb2E5WHgxN1VPci9aWmxMNGRaN0FF?=
 =?utf-8?B?RkJuUTd0bm1TNU9CN2pNVGlsMmpCejhwaWpXa2l6VUVrVzMyOUtKWjJ2YVZ1?=
 =?utf-8?B?Tm5uM2M1Y1RaZU0yZnN5TE5GdTM2TTg3YWR4VTl3ZDIwRVo5Q2dpTFYwbC9R?=
 =?utf-8?B?NXluUVZFQkVqU1ZyMDRETHlaK2VhbzFYWVFidStISWRtekVsWjRKdHorTmFD?=
 =?utf-8?B?RzZ3bjQ0UytMRWc4SWEzajRFYkdlVWcrZmFnZVB2L3htc2U4RzMxVHZYcWdL?=
 =?utf-8?B?UHZ3a281eXoxaldjN3JvRTF3OTV6WmNuRWY1UW9tN2NsazdyRmlYd0o3WTlt?=
 =?utf-8?B?WUpHMlh6ZFhlQzZ3aE5oSGJBMWZpS1oybkViaEtYV0wzZHYzMHNhNFlHQlIv?=
 =?utf-8?B?Z0NaQnR6TmtTL21nRGE2bEV3RzFwMFZUOTA3OUpsQ1JmSkFCcGt2RDNRN3NF?=
 =?utf-8?B?amFRUHB0ZU4yWlZxWGo0R0d2S2RJOFJGbGowSDBiSjdaMFQwYzZza29USTRn?=
 =?utf-8?B?YW5kWmNvZ0M3MjZhVnQyRVkvZ3ZjbnpjSWNkZzF2Rk42SGdYTUFDK0RnbkY5?=
 =?utf-8?B?cDYwdjhQZVB3YzlTbHp1QnhJZWhERFllZGNrc0hCU0hEVndJUFJETWxMK0RK?=
 =?utf-8?B?V2lxRGpib3o2VURpK3RXZzdzRWRDZUtUOFJISnIySW5CbHVjMWZkQkU1V2hN?=
 =?utf-8?B?Z04zQU9Od3Y1OTAzekU1K2JLVFhDcmQ2NFdFaTVIY1JjUHZsM2czYjRqdXhX?=
 =?utf-8?B?WGNvalYrUmFwblh3V1h1aTRZUkM3NlExR3E3Z1RBWkpJM2k1cGRScDZOeXY5?=
 =?utf-8?B?OWRoQkgwZVhSMHRra0ZJNHdiS1RYN1B6anVRN0pMTm5sdzNLd0VLc1pWTldh?=
 =?utf-8?B?U1ZnaWx2Qm42L0E0SlRTRFFpdU1JdWU0aGp3bVlOTnNLQmZESE9nSnpETVpp?=
 =?utf-8?B?WU9sSENzQzdMODJybFFEd2xVRDZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <099D21FE7F466343B03D6632BF83B1CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dRqKyVtJDbxsschL7p9Ql3YfjkC0t2da1gN1rkSNVa7Lx+sN+TuGeJjLossRkDch8glNkjnCYEzXeYKh7icURm8ol/CaoVR2AF6c9TRPbOFWL1xr9HQ8Cp5wOWE3feeY8AQZIo/XhK3RV+eRMmoujL4qkTp46CSmBe84Fs489K/IRedIf31+MeWca/yzR6urSfEX72ah8N/OInzjnFcaZwLbKnRSv8oing2qAg65rYSXtKmLq9Ox+iJ4A5ePcs4tr7E+f0eEehYOezEmGhNo3u22eyaq9OmkkFirhRXzdyhEUEV+4RQK6ULNQ3GCaBJuF2CIcRXWVEBZKD5WLN/fxmQxsk+yAoQy3cC9jEhjxWh87tlBW6u3hdK6rH7jaxosdiu//6t3hunjJ4QrC03+rEVFky9526BFQa+pbgNleSmkSYVIqAtKiRZX421uAzgfVM6FVUGVns9QSDkm0cCZIWOluOFhoklDBX+qRtSzuzyqVPEEPl4q8AQ9Z2My+/zfGMhwXXMOKTDUv68WU0f7XBLz+467F1tFfRUUAM1RKbSJGcjBy3pkQDsiYYGPG/JMaOGKjzXTvAMc9T24BX7FSzan0y7BVT4i0QO+SWu5B0+4dwzwQemKi+dnHlUE89RX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d70f26c-110d-4d8f-d185-08dcfcbdb355
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 10:44:46.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EG3rcwGnKbbj65+uW4Mjb6gPH5MCAbJaEY+YMMrq0Hkq6l4w1RB17pfCfukY+BLZ07e0buB+Nh7udIbb+AFtFw6sMEnpHykJ/IVxVqCxKqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7690

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

