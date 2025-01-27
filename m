Return-Path: <linux-btrfs+bounces-11085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8F8A1DBDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 19:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B728A164C95
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 18:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840B18C03B;
	Mon, 27 Jan 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nypdoZ1C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431BD1607A4
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001181; cv=fail; b=rF1fqvABLT3dpEJWDCzbwJeJiPPVnN2kQusZOabQ7vHNTr1nBj1R37BUyKsWHSmgjvm3ryMzOPnkX6Esam3m33zaMrsyTLBFfrDMib84lkDeRRMf0CrnAFP9QR6h9KcNs8hx2nqaso2CQ1a6VUKJSw6X2TnMP3iJWaN++Kff7vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001181; c=relaxed/simple;
	bh=kLqvavGfuJf8NaISnrv8h5N1Z14Il2dj6EB0HwoWiQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKHnu2VN64XdvHll6YjW99hztntPWorUBr7PlBjb9KvA+a4LmW9x6bUbXUPTnrHiKYyrHHByh2RRJ9fYD+G0Fxz4ORm4zjMXluaE8kUMMjsgsIcsICXKyC5aNcTRUwz5+LpxsjCyz4QTysxIcwTKvecUYj3a3jaQnOq7A20+9zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nypdoZ1C; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RHovtu031300
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 10:06:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=kLqvavGfuJf8NaISnrv8h5N1Z14Il2dj6EB0HwoWiQI=; b=
	nypdoZ1CHruV5mnfxXZUkNoVPgbdCmO9b+/jTovzQZXiuHxS8D1cfJlhDvoTV6Yw
	Up+81sGBr7TjiBgUP1P7xPX7mv8GleD/e6dfRzSnEXAkepvLp+ZFoYgq+wcw1VhI
	N5W0vvMo/Oi43H7vwzbLGl4gI/E/RhhFikt2VoIlLan/VQw/K0bvE4+08E4ALMZC
	Bsqn8Zu6e/I513zc5VNymElXjypLiBarmP8/JomrQpCqrdEP//aW0x50RLy0Tv88
	xTIIItPk1zf4+6JdZ+1Vxg1CwTQ1Lx/DHk8T+KC+tb6WR2jOJU1kUUmKop8IRdL/
	aRZ5PRfw3DSWDW/Dk335Kw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44ec94he2b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 10:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcVfMm6Tj6MQ+7ksXE/sAPaFtbfwXBFdXEi6CAP5VudumKa1lKBvQM9p3nZJF6mLab1trVE8qiOINQtrhRHCgxCJh3EpyzZedKjO8HSeWDqA/qMo8cix3ESWj6wwtCAyr+bccyu6ouL4XyLDnDj8iBFtGzy6g0idG36hKX5Z6Nh6AYDs+N1Rlx5nbpivY81wlb29ObgSd2asvIfaHR/QkfTz0gPh1OTGw6P2iBUIXPkXx6NRkeeatPWStrDUIgurTob91k9ZvwcoKAnaqZQz4UXRvSTW/Lq28+dIjIRTpnWZpkOBNjQNw7LOmnK5/RIgjrJjUB7AUpThXnNlYObGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLqvavGfuJf8NaISnrv8h5N1Z14Il2dj6EB0HwoWiQI=;
 b=sOiecqWgGUhtdwg9yObQsGm4NC6nTsMcec6J3gD50loccZ52aKcav++z4wxKCmUqylxSJ4JXoGXcwcz3AEaxvSvTndF6Vxcb+V/umTT1jdQT3JVzcxc0Y3NMLzHDxSlLpO+2V+jSq1kpD1drPMGZurW4k9K7JXJLdqqpfv+tx/RIKcdmCwQHegX45zHmA58oDylug4UjlOLzFB1ppkcYRw2m26DQyb2p6VEvnYxqWUptHXiPEeSYzU+UyQWcDGyX1zPanwRsuqxk9MkgZrk6dQhPuf/hROdDei7nJI9zO74a7M7TTCM7Rd3g3Zz/kEUqXPZlk7QwESOdgvpAL+fy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MW3PR15MB3881.namprd15.prod.outlook.com (2603:10b6:303:4a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 18:06:14 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 18:06:14 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
Thread-Topic: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
Thread-Index: AQHbbDOYW1HaLbrXA0imAWnyJlpfc7Mi6ryAgAgJKoA=
Date: Mon, 27 Jan 2025 18:06:14 +0000
Message-ID: <7bb04e63-c0b5-4492-b2d4-2a10238dd59f@meta.com>
References: <20250121183751.201556-1-maharmstone@fb.com>
 <20250122152321.GI5777@twin.jikos.cz>
In-Reply-To: <20250122152321.GI5777@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MW3PR15MB3881:EE_
x-ms-office365-filtering-correlation-id: ae4b2f20-94bd-433a-91ab-08dd3efd4a04
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmdWcDZsZ3FTTE1Od0g2dGJSVkZndVFZQXJJeWJLY3hsUEFCOTRJeUFFZUgz?=
 =?utf-8?B?TUloWU1KSXRpTHN1OFZ3MGFpUTQ1bWVvV0hPVld6bXlxVlZLTHAxbVJRTlBU?=
 =?utf-8?B?dzhYbVNuczhhdWR2M3hTMTkrVVQ2eWw0ZUZxWXRxTnduU3pQQVBCQWRqekNP?=
 =?utf-8?B?SVF2eE01UjFYeER0WkVWRmpRQ3BUNTFCOWJJczk4V2F1ZWJTcXNDSUxscjRq?=
 =?utf-8?B?TWNHNXIrQzBWY1dsblM3UnYyMm1LaXpLWmhLanRrNFArUklWTXZERHkrcEFy?=
 =?utf-8?B?Y2xMemo5NDhhNEtmTFF5a25tK1ZTU3lUYS9VUWk2TSt3bFIrSVcydG9oaDRD?=
 =?utf-8?B?aGM2Zk9aWTZ3WHFmaEtyb0FnYVMzcWZmSE5aY0s5a3JySE5sTHRrT2o0WXQr?=
 =?utf-8?B?NmxZSXltUVRYMVFCMStxTTFSaU5QZVBKS0FOUEpUZU9HUEl4VThRc3pDUHRM?=
 =?utf-8?B?S05naEpCVzZxRktRRktPN2FNTHV0TjJ1Z0JGcU81Y3hoU2FUMUExcjBQWldv?=
 =?utf-8?B?NXpqZGVvazRmVDFzM1Y3UzN5QWNncU4xL0Rldzl5SU5KZUN3T2wwNGowSVIv?=
 =?utf-8?B?Y0N3aVhBK1dhM2h6Sk13akJqcnB0YmxwZ1pvR2RZTGhGYW4zUzBWVVJjY3BV?=
 =?utf-8?B?eUovWjhycjBLcG1aK05mcG81c3ArT1Brd203enNVZEZaUGw3OGRVN0JmZWM1?=
 =?utf-8?B?OFFlQkl4OGFOUUEzRXU5UWRLT2NFMEduS29xTHYrR3RlZTk1eXJSTElFWURx?=
 =?utf-8?B?bHhpTWVIVUtVbTIvbm12a1hwY2JxanFYL0YrZXhNaEhYL1pCNHVkV2lVbDNr?=
 =?utf-8?B?U0Z5cnJEK3Rqb2lzakNCbStSTEJ6UGJGVU5nOWFNUFJxRjB0U0VzK3k1VVZL?=
 =?utf-8?B?VkYzRXgvSiswNkZPbTg3eUh4ampwbVZvaXFObDdadjlzZDVXbmZEUW8raitN?=
 =?utf-8?B?U0JQUmlFUmo0T3NqVDd4ZmwwRGp4MVhvbHBIQ1dYaXY1R3I4MS82czlxMFVS?=
 =?utf-8?B?OUxCT2pESzRnSy8zZ1duWFFFNHF6VmtSUlN5Yjlrem8yQ0Y4WXJHQ09RM0tV?=
 =?utf-8?B?dFVVc3QzY1Z5aGgvYlp5NmdRUCtmcmFGQmFNSDFwb25GK0luWWVpd2o5VDBp?=
 =?utf-8?B?QTJ6ZU1iYnV4cjlpM1Qrc1F6OTdIRnp1TWdOS2t1am90SmR6SGpCQTV5QTZM?=
 =?utf-8?B?cmcxU3ZXQ09SVWw1dTFUK1JTL28zUnM1L3UyZkx0UFJMUjNwUWlObEZhY0xB?=
 =?utf-8?B?S29qUGdOdjFsOEJCWTAycndCVzRXOEVYT1ZkcFdmcWpWZmtmV2RqZkpXYVJH?=
 =?utf-8?B?OXBIOGpjSkg0b1RqNWlYRW1IYUhzWUcwSThEWUgxQnJaSUt5L3RaZUZWeU5I?=
 =?utf-8?B?anlibE5ucUV1OXBGQk1WcjdtK2hkdll6NW8zTXVkS1piSEl2cEsrc0lQZFQ1?=
 =?utf-8?B?L0NaU0VmSHQ4cUtrTjNoS3N6eU85VXdSaUU1cURzSTljUDhBc3BmYlIvU0xU?=
 =?utf-8?B?TTlldEZUUG45WXlETGpIVkpQbUVnaWwzZkZHK2hWN3hxc21BVUtMWkhUS3dE?=
 =?utf-8?B?bUp0NENOdWM2aXFWbWZYVXpVekU1RjVOeVc4eXNEVDlMZFY0V2oveUdtTGtR?=
 =?utf-8?B?UXIwSzBtY2xyVTZPcDBWcUs3S0ZmNnNrckU0S3FhQ2JoRVlyWktrUjFKdjh1?=
 =?utf-8?B?amoyQTREdWpsQklUejVFd1JRMC9uYk1qTVpaRUtYN2xRbUJtNGtKSk5FdTNZ?=
 =?utf-8?B?YnltTjRXb085bEpWMnpsRnkzMUtsNGExUVkzRDc4b1FHWmxFSEdGZG5aOGR6?=
 =?utf-8?B?NFN0WG1IUkJCdWMzeFlmRkl4bHhYVzFSYk41RDA2N0oxU215NkZsVFZKZTB6?=
 =?utf-8?B?ajNXWW1kR1RZUUxjVkVDWXAzQVMwR1JncnNaQlhNeHkzSjlrcXNYS2FIbUtB?=
 =?utf-8?Q?6mZyF5t7mFzQjrRI1/ko9QjVleZgia3m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1BwYSs5UTRpYit4blVqLzNjaDFBMXZPb2NyRWQ4N1JpOW5wUjllS1BWTnJi?=
 =?utf-8?B?VmNidks5ZFlIdE1jbEh1Y0FqVW00cWp2TTFJRUVvYXN1VnZVc0NOZjhBK1hL?=
 =?utf-8?B?clJUc1lEaG00cXB4S0NwVTRuT0E3Tlo2SVlEREFmZUZRYTBoUnJJRUFDN3Iy?=
 =?utf-8?B?Mlh3aTlVcnBRcHBlUmhtbWlmOENDZWswL2pzaUREem9kTHRkc3QvS0p6UHcw?=
 =?utf-8?B?UmRZS1B3dTN1YWFSa2NuTjRyRVlxWktKNmUvMXlDSVByQWx0UVlVN1ZvREV5?=
 =?utf-8?B?TlZTOE9kMG5weVo5NzZnYjU1dnZJL25pQytaWjJtWXVIRmw0R1c0Y2RHUnY2?=
 =?utf-8?B?d0tQSHRwR0tSM2R5cGN4ODFDeFlrUWIyYTVGWS9pNFVjTHRhQStsQXQwdHJ5?=
 =?utf-8?B?ODFCZHR4NTRTQlhic0tBQkVaM0I4aVZtVUpEQXl0ZlBPS0poQlgxNURBanlq?=
 =?utf-8?B?cVQyUlBaRUY5ZFl4TitrZkphY29xVDFOZUNpVCszMytQT2JqK1NIVTlsYzJK?=
 =?utf-8?B?NkhHWjRidENET05lSXFPVSs5UTlQNVJkSHVlL1RRd0ZNblM2bzNLc05ERVdt?=
 =?utf-8?B?UXJ1MDJscHhVaXpQZ1NnV1ZtWVVtT0xIb2EzZjhjNW9nNE9KZWhnVmpSblV1?=
 =?utf-8?B?NWlleHBkaHNUajBFWkkvK0RlcGtDTmMrUmdORHV6UDVVVCtKYjQwTFk0QlNF?=
 =?utf-8?B?YmsvZ1Blc0ttSnpkdkhiYXB4a3BSSk9xbitNMU13OEVRdW14RE80eDhKazBm?=
 =?utf-8?B?YWhNQVpHTitlUDZlazNMZkpBbFh2K2dKQlBPR1FMQ3ZVdGhtZFkyU3hFeXhF?=
 =?utf-8?B?TFBWNUkrZko2ZlBsdWtHQVRGZG9Eb0xqQkdnbFpLdUR6cXdOckRHM25JN2Ni?=
 =?utf-8?B?Mi9sQWFQNlVhK1pmZW5ISEVxdDRGRzhaMGxmcXZmazNEOFpzeU5KZ1lUc3dm?=
 =?utf-8?B?RVVmakRDYXZONkdZcWU0YWs5S0Znd1d3QkxkcHduOWgxMjZCVVJQREhQK1I0?=
 =?utf-8?B?YVRkVStXTjB2dytEb0JnTVJVbUJyTW9iemRZVUhxalRTT0h0bS84WmVPUGNq?=
 =?utf-8?B?V1pyRDlmQlArMGJ2NDNSQ3l4L1UrQmdtNEFhRmk0QU9BTjBuRWJMbHMzN0I2?=
 =?utf-8?B?N2poM2lIMzEwa3g2QlpCVjd0ZXZZSSszVmkxWEJZb1VFRmRQL2laSDh1NDd6?=
 =?utf-8?B?R0o3M1NzcWE4bFBqaHlNRDBsaURSNWl1dHJhUFZ1TDNpQkVDM3dIMEdsSDJX?=
 =?utf-8?B?cThEdTI3cTN2TXJUWHBqZWRsSWUyU2N1eGI2ellTRmt6NkhRSFI5NHhNVXl4?=
 =?utf-8?B?WDM0ZzFkd3B5UGp1QmRqK1ZZN3pEOSt3bkp6TjNlM20vUVk3R1doVkJ2UmFL?=
 =?utf-8?B?ZXRLZnQ4dFBFd0ZuMVRtbGhXRml6SWNja09sMXA4U1NxN0hOZWwwTy9HaU5z?=
 =?utf-8?B?OTg2YlJySGRsQWpKN2h2Znpic255WVN3a0h6clVRVU5Db1dTNDU0MTdyWEp5?=
 =?utf-8?B?RU9XZFFRV2MvNzdZZUhvWHVDWkRDejVISHRKMjkvWEtYVnZVWFlYRWtZT3V0?=
 =?utf-8?B?eW80UVA1TjNBNW1GdjIyWUhnQTBZM0ZVMjdqWFMwVGV5QzJJeDlwVTdwMG9S?=
 =?utf-8?B?c0hPVUFRVWFTOVJPcWlDU2QrS2dHbU1QeGg3cEFVd3F3T1U1LzNxd0NBNDl5?=
 =?utf-8?B?N0NZK3N4d0Z4ZVNTTXF3bjlqZUZ3VjdBOGhNRi9qOE5WSkhuM1ZhSWpJRUdW?=
 =?utf-8?B?aXM2R2R6a2V2cHBPZjYzUEJzUUVmQzIzdDJHWFd1MWI3SC9vWnNFbG5zZzNJ?=
 =?utf-8?B?MEd4T0xOMUhpOWYvYml6Smx6QzAvM2JJRDRRTmxyNXRpNXpYaUNENUZCUGIr?=
 =?utf-8?B?aVBvNVJIaHZROFdteVpiYlUrcnRwRGxNVWR5SDNhR3RwT0RXdVVUanVJQ3pk?=
 =?utf-8?B?ZzI3bWhjaFl6M1B1cEVIZUtCUXFaMkMvMi9vSEFGWE1HZXlvU1RxYzl0UlNS?=
 =?utf-8?B?b2pqcFpwOXVxK1ZPRkVOS25hM0hkRVRLemg1ZHlueVFKRDFsZnZJWjhRUk5x?=
 =?utf-8?B?TjQzSjNycGE2SEJhYU4zdVRvTnd3amR3MHM4VkpXZUVXQkJSMWt1aWJuRDNY?=
 =?utf-8?B?RzdYWnNNN2ZVOTg0ZkRjakFSdkUvcWxGZlpiaXlKaFRpQnkySjZ2VU1MSUdK?=
 =?utf-8?Q?4KDGIxesy9XQ8cCEIncJxzA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5DF32C759F5B34D8146E25EBD9FC22F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4b2f20-94bd-433a-91ab-08dd3efd4a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 18:06:14.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uiTVnOwyY/z9nGlluHlVvfkupE1H0bPS7pJehJPItjes/lvUKsmDG+P6UL0YqOtRz11lwdeso7glhuyyl4xcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3881
X-Proofpoint-GUID: IZDaLoVxC1sQwf90IYM6l7vLSoFUz2OS
X-Proofpoint-ORIG-GUID: IZDaLoVxC1sQwf90IYM6l7vLSoFUz2OS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01

T24gMjIvMS8yNSAxNToyMywgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAyMSwg
MjAyNSBhdCAwNjozNjo1M1BNICswMDAwLCBNYXJrIEhhcm1zdG9uZSB3cm90ZToNCj4+IEZvciBP
X0RJUkVDVCByZWFkcyBhbmQgd3JpdGVzLCBib3RoIHRoZSBidWZmZXIgYWRkcmVzcyBhbmQgdGhl
IGZpbGUgb2Zmc2V0DQo+PiBuZWVkIHRvIGJlIGFsaWduZWQgdG8gdGhlIGJsb2NrIHNpemUuIE90
aGVyd2lzZSwgYnRyZnMgZmFsbHMgYmFjayB0bw0KPj4gZG9pbmcgYnVmZmVyZWQgSS9PLCB3aGlj
aCBpcyBwcm9iYWJseSBub3Qgd2hhdCB5b3Ugd2FudC4gSXQgYWxzbyBjcmVhdGVzDQo+PiBwb3J0
YWJpbGl0eSBpc3N1ZXMsIGFzIG5vdCBhbGwgZmlsZXN5c3RlbXMgZG8gdGhpcy4NCj4gDQo+IE9u
ZSB0aGluZyBpcyB0byB0cmFjayBpbyBzdGF0cywgd2UgY2FuIHByb2JhYmx5IGRvIHRoYXQgaW4g
Z2VuZXJhbC4gVGhlDQo+IGJ1ZmZlcmVkIGZhbGxiYWNrIG9mIG1pc2FsaWduZWQgZGlyZWN0IGlv
IGhhcyBiZWVuIHdpdGggdXMgZm9yIGFnZXMuDQo+IFRoYXQgdGhlIGZhbGxiYWNrIGlzIHNpbGVu
dCAoYW5kIHdoYXQgd2Ugd2FudCkgaXMgaW50ZW50aW9uYWwgYXMgaXQNCj4gbWFrZXMgZGlyZWN0
IGlvIHdvcmsgb24gY29tcHJlc3NlZCBmaWxlcy4NCj4gDQo+IFNvIHlvdSBtYXkgYmUgc3BlY2lm
aWNhbGx5IGludGVyZXN0ZWQgaW4gY2F0Y2hpbmcgdGhlIG1pc2FsaWduZWQgZGlvDQo+IHJlcXVl
c3RzLg0KPiANCj4+IEFkZCBhIG5ldyBzeXNmcyBlbnRyeSBpb19zdGF0cywgdG8gcmVjb3JkIGhv
dyBtYW55IHRpbWVzIERJTyBmYWxscyBiYWNrDQo+PiB0byBkb2luZyBidWZmZXJlZCBJL08uIFRo
ZSBpbnRlbnRpb24gaXMgdGhhdCBvbmNlIHRoaXMgaXMgcmVjb3JkZWQsIHdlDQo+PiBjYW4gaW52
ZXN0aWdhdGUgdGhlIHByb2dyYW1zIHJ1bm5pbmcgb24gYW55IG1hY2hpbmUgd2hlcmUgdGhpcyBp
c24ndCAwLg0KPiANCj4gVHJhY2tpbmcganVzdCBvbmUgbnVtYmVyIHBlciB3aG9sZSBmaWxlc3lz
dGVtIHNlZW1zIHF1aXRlIGxpbWl0ZWQgaW4NCj4gbmFycm93aW5nIGRvd24gdGhlIHByb2JsZW0g
dG8gYW4gYXBwbGljYXRpb24uIFdpdGggY29tcHJlc3Npb24gZW5hYmxlZCwNCj4gYW55d2hlcmUg
aW4gdGhlIGZpbGVzeXN0ZW0gYW5kIHRoZW4gZG9pbmcgYSBkaXJlY3QgaW8gd2lsbCBtYWtlIGl0
IGhhcmQuDQo+IEkgdGhpbmsgeW91J2xsIGdldCBtb3JlIGV4YWN0IHJlc3VsdHMgYnkgYSB0YXJn
ZXRlZCB0b29sLCBCUEYgYmFzZWQgb3INCj4gc3VjaC4NCg0KVGhhbmtzLiBGcm9tIGEgTWV0YSB2
aWV3cG9pbnQsIG15IHRoaW5raW5nIHdhcyB0byBhZGQgdGhpcyBzeXNmcyBlbnRyeSANCnNvIHRo
YXQgd2UgY2FuIGdldCBhIGJyb2FkIHZpZXcgb2YgdGhlIHByb2JsZW0gdXNpbmcgb3VyIGludGVy
bmFsIA0KbW9uaXRvcmluZyB0b29scywgdGhlbiBkbyBzb21ldGhpbmcgQlBGLXJlbGF0ZWQgdG8g
aWRlbnRpZnkgdGhlIHdvcnN0IA0Kb2ZmZW5kZXJzLg0K

