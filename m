Return-Path: <linux-btrfs+bounces-18623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E65C2F3A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2964E30BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A473C2836B1;
	Tue,  4 Nov 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U1MVkSbF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C141A5BB4;
	Tue,  4 Nov 2025 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229067; cv=fail; b=kTp6hIpR8W0UMteapIokGWGfBt00hPETEmPAnGfAkhMBjRsVCY4G1Oxd4Ipawq8+ws2eREHU+kpKWlnNSiwQL+9be7a7xsOkqUbfRlNPWQ+1CDiTjLWKw/upLYr64RShIgPSemGPebFK0VLGRtzPI+rTfzoOKGBJMZYTcPyskRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229067; c=relaxed/simple;
	bh=Aq/KIepzwJXdfud669Ea8Mut+rNZ2T25SO0u+28zWBA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5kKLhkWOsUj4MWaSBbA74jUm/PLMMdEtglR+h4JMxDSARonhFYsugH62bBGjVUCBJeAxtLrbw6QjnsaJe4Jxknt6uClEcbbC+KqzEeAqhwTa5STVvqUSJj/5dm3dlD0qFhRL3ftMv3YPxiKe2iU7CkcCUIL/c7/1nhNgg68W1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U1MVkSbF; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4+7rR6e0XLWsyzfHLPJKznQBORug1umVTMAowR3zaDd7RePLNnx3EnSE7FXjR1dsRpbA7Sxd8KmVNwV4lyN3FVfwfUb8RgF+SVgXAl/ecXFK6XGF4bQNharwjoG/tPeCbZoKmkXzo8yhESD0AhfnPEaGqCnyd2xFV51Dj5yNi4SYuXLGkNq+VZbW0MXAqA1d7+SOVxSpshAt7zh6Exj7HrIZrkXHzhaQ1O+gzosp+34Akn3kw8F+dirusbcIv61SeWKiBx42vEu6eFKvuxF3+v3j2UXdKedHceUOFLgGItW/burG0Hpa8Qswr407Lb7KgzeaO9dr5pd6Pdq72ZsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq/KIepzwJXdfud669Ea8Mut+rNZ2T25SO0u+28zWBA=;
 b=v8FFwJc4k/ri6HOrWhE7bTf5UFWG+Ju/pe3UEL3S+cFd/8axHOh19FuQTNEV4kfBik+lTD9LlqJETmvPrvbGwNLn25+Mi9XBewZRf5bJg7w2c9dMsKwvM3TkjP0iMunYhPqt5r0LACYTZgOh5pOruF8xmke9XRF+UoH19vTVDuWLBm2/pJixBvRG45HwVS7Zx7gY1UqE4EUm5DUNQDxzMQ+ye2lHew93MPs0Tk0D/76amMINDaE7nmhnju/jTmT11uuVg0CtpoijfFXZyWdqs77SZdoyeqr2wbMXb4iMXrwph2X6QvYT+c3bb0EnPrveah9VEfSHTDM6RsPi/TrcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq/KIepzwJXdfud669Ea8Mut+rNZ2T25SO0u+28zWBA=;
 b=U1MVkSbFkzbEUYkddUTRpYY9lXQszvXwZlXcn0skY/T/QXInZOZA5suNxFjr6jwMb0UWdsYEiiCS3PIbymSfdhWhgU6aessdkOJfEzTUQA5uDN9NOf5mfzV40C7K3wnYCRvCX42OQ3d3A41CBgjyOaIXsYnkTDCUul5EZQ3FvP75VFcxSaxG4HlEQ3/n/iX9PAgHwCZffF05ja2tR0JuWAMoEu9UGXzQhFZ5iDy2Otj93HkKQEanHifHvxWZEjSyUlYO1Xv0+m7ScVBve3XagNMQiOtckADm0QpxIH8pgi1ldDbB3kXVkYop3cIGkTAQ2NvM1xGYPR68bmToEvEJYQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:04:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:04:16 +0000
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
Subject: Re: [PATCH v3 01/15] block: handle zone management operations
 completions
Thread-Topic: [PATCH v3 01/15] block: handle zone management operations
 completions
Thread-Index: AQHcTStfR1h12lv1x0up5mvCvsMKzLTh5dUA
Date: Tue, 4 Nov 2025 04:04:16 +0000
Message-ID: <8896d03b-cd37-428f-b72c-e61507e20bd4@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-2-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6853:EE_
x-ms-office365-filtering-correlation-id: 11d3b196-2c2b-420d-bd9d-08de1b573928
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmZ1Y0lRUmNZTkdXNzY1WEVtN05zSmtJQmVyRzdqYlhHcDdNMXNKdXlzTUk5?=
 =?utf-8?B?RTBmU2c5TFpwQldqRlN4bWg3aHhQOHZIRDF4T2dzRXRhRXRhcUI0NzVncm9N?=
 =?utf-8?B?OUlNMjdXWHY3ZUJvWWFSRlhIQTlxc2RKWmVuVzlUNWxRUXlidStibktmblJZ?=
 =?utf-8?B?RUxwZDdwNEdZNDc2N2FUYjhNY3lBMUtNOVpHeVBjTzZ1RUtPaFgzMGNEME9t?=
 =?utf-8?B?czdMSEM1ZGNwekZKQ1ZnakFzYnRRaGlpNG4wMXZqdE5Yd1VvUyszazRaM2VO?=
 =?utf-8?B?eG5NWmdhbGM3OUJvTzBBMmh4WFNLSkRYNkh4aWtnUnk0c1d3dDVIQjlwRjZ4?=
 =?utf-8?B?ZnlFcmpoK3hMTG9INmRGdVRJUkRyQ3FUNzVVMzNjRnQrRyttYUpzeGRyUVZV?=
 =?utf-8?B?ZFh2c05kVWUwNGNWcnBqT2tERW9wdzFOcHc2S2JBZ2FHczhXZmpyeGZKYkpV?=
 =?utf-8?B?bCthNWxTUml4TEFlUDQ3U2syMDh0eStTQmloMGhRWU1JOVNDdmFiOUN6dlR5?=
 =?utf-8?B?Y2FtQkN6bk5LcGpMWFJ2OUhoZlRoZlZWeWU3Mjd6TDBiczNPRERyQTl1Zy9i?=
 =?utf-8?B?S2JCcDZXV3lrRGxEWiszRWFOaTlMVnlsUEVTclc5aFV6dDlXdGZwTStoeGxI?=
 =?utf-8?B?SFZEZTVodm5SeFdhMjBzY2dFZnJqTW11UFg0M1RnZEh5TUFHUUI2aDUweS9C?=
 =?utf-8?B?UDNlTk9WR25pNkJyR0xKZFh3eEZhMTdUcnBLaWZQUWlmbTl6bi9TdHoxWU9t?=
 =?utf-8?B?YUNQdkJFd1U5VG94LzRDdkFMYnpuUlRUbTZwTW9FdEFnTWJFUzV0ekZJL3RR?=
 =?utf-8?B?WFphTlFUU2ZVME4vTmdhRDllSE52cW1IenpReEI0b0FsbldJeDlyMlNFOHNm?=
 =?utf-8?B?LzdlcFBYRXllb1ludnRsMHlLYTFWNWNZWFQwcTB3dFB6RXl2dUZ5MW9yY2gy?=
 =?utf-8?B?R3hHZ3c3dTQ1KzR2QS9YNkFObXlrM3NSbFprNFV5N0JqV1ExTFA1STlzV3Aw?=
 =?utf-8?B?NWlKRmt6cmlWREdqaHdyUWtNam1jY0dXc2Q1dEF4UWpzZVVyeEdaUzJPSEl6?=
 =?utf-8?B?eTN3RVdFaWFqNnFucDZnbHI3TGtmdkpXQWRaWFljait0THl2ZnhLRXU0MEY3?=
 =?utf-8?B?TSsxcWUwWkJyWkRwZ051alNJUEpEbmgvRklraUJiaHRYNmduREdLdjVnUy9r?=
 =?utf-8?B?UkNNald3ZkVlaWdLZWprYTNtdlVnZmJ3NWZlSHBsakRORWk5dCtSWkNhQjBq?=
 =?utf-8?B?dE9BenNmSzNycEFDbHdTL3hFNHF5SkdiMTFrZ1A4M1lEdjJDSEFEMUhPc05E?=
 =?utf-8?B?VFAraU1iOW9lNDE3QWMya3pQcWNLd09zT3o3WkdNS3ZreVlUblJWdi9LMTJh?=
 =?utf-8?B?djZvQzdqWFhQS3ZuaGxnM3kwU2M2NXBVMVZCZndJQ25ucTBZOEJqMjVIbzg4?=
 =?utf-8?B?L0FZTzBjMFNiaDNScEVHeGZ3bkNzdzVleWdqbWs0cXhZb1RsVElBWWx5NEo4?=
 =?utf-8?B?K2FxYml2T214c2ZINVo0ckxzZGRWTjhzUEh0SExEalFOcGNkVlBwZldoNEQy?=
 =?utf-8?B?MENVTWdGckM4TFdTQzMrUDk1QnRaVHFMZithTzhxL095RXY5aW56elpxNk9O?=
 =?utf-8?B?ZS9EM0JRdnlyL1ZhVjhlOG83UzZhWG8xdWxYMVhzNDVuQ01ESXYyUHNQRWJV?=
 =?utf-8?B?ZzZNbXIvMS9xZWhXZEttaUVUckk3RWV5NVVMUXBjT1praGNPNkVSSFZWS2lY?=
 =?utf-8?B?bHEyRzc5Umtwc1AvTGRnQ0VmU0hmOVJhVHpCS3VUTFdOWkRPUzNHNVNKd3FH?=
 =?utf-8?B?UjR2VDRCeWFiSHBneG11Rmw1UmtUT2VkL1VKekRNSHdDVVQxZEg0SDhRWGJh?=
 =?utf-8?B?R3hDem1mbWlrbXFsMG9KRnVLYjk0Y21tYk4xVit6QW5DNXg4ZFdVMnprT2Jp?=
 =?utf-8?B?R2d0MFFXVEtuOS9wc1pZdVdmNndudUIxdzZydmk2QVVWZFo1U3RMMFFNZ0Rh?=
 =?utf-8?B?ZGpwaWp6eS90a1lFYkFqMEVGOURIT3pFQ2NRN0h0NjdYdEJKamhTRVZWMXVx?=
 =?utf-8?B?b0t2eGV3c1R6R2FoYU81VVltWUhiSkJ4WFpFQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STBRa3ZVbkI4WGJ5Y1ZBNGh4MFdCU3J3WTRLdUhBUHpZRmdqeUVWUU9kNWpN?=
 =?utf-8?B?R25hRjBORXphcTNtQzdpRlFUZ0dqUHU2K05Wa05TRllFRmF3NHFPdzNqZlhq?=
 =?utf-8?B?R3ZMNjhjcXpDWUwwdGdTdHFsbTRGR2RTT0dzYmlBWVRDTmJmbmJzYlAzdG9D?=
 =?utf-8?B?VGJudUhIemFzTWNBRVhPTmZFblZYcTBENlM1YktzNTdKcDJ3Y0pxWmJmR3VD?=
 =?utf-8?B?ZEMrOWVPMDUvOXNud1NwcG5WZGhRd2Jkd0ZZbWo1T1FwbWM2MjRtaGQ0RHlq?=
 =?utf-8?B?TDBFVXVrMmViTjh5bTgybWJObVpZcUhaVE0rYnc0MGV6cVFZUEpzajN2dWR0?=
 =?utf-8?B?TUp6czBCWldKWTBzTWE1MzA1dENpOUc4MDdPVHVrNERzL0ZHcWZJekdyYjMz?=
 =?utf-8?B?QWVzN3dKZnFLN09CbEx0VUttKzd5bGJWZ3dBTnB2dzlLRlpyckhpSWFsSXVh?=
 =?utf-8?B?NndyR3ZXWU92cDRCemdBZmRUMHVwMytOcUFxRzIra1FyaTNodWdOei9oNmdR?=
 =?utf-8?B?ZEZrNVhYZVRzb0hOTUFHSFgydUpvSUg5eTQ0UVBFMEFVREx3cnkxTEl0Q2FU?=
 =?utf-8?B?VUhRY0QrVTZvekJUemJyc2pLdmdHUGVsL2ZBSXNqd2lnY3dWRElKcGszMXo2?=
 =?utf-8?B?bnVFK3VYU2xjTU90WVdjdWJVbmdzdmhCWDNxMlFLcE9ack03bDlaVHdtSTA3?=
 =?utf-8?B?RFNaUUppMzVWNVlMcWIwVXlBcHVlR3ZzdjVBQy90SmVjK1Z2ZXh4ZUZsWXMr?=
 =?utf-8?B?VEhlTUpXNjJuSCs5aFA5L1ZiT2cxeDVJMEVuU2FNN0FRcmlzcmpaaWtXd3ZF?=
 =?utf-8?B?Wmh0YUhtK1p0ODVBVWx3SFEzWHJnbFRZZzhxZXBtMXJYUHQ3NnJzUkltR1Z0?=
 =?utf-8?B?MlE1SFQ4aEJsNDNSRjVteElNaDZLL2RBbmMxbDE3cDA3K0tPd1J0L2F4VnNn?=
 =?utf-8?B?K1lOYkU5b0JwK2x4R1hZWHFLQjVBQkpqaUhGMlNZYjBEK0p3bU42d3hGM05X?=
 =?utf-8?B?bVh3MUxmSVJ2ZUtXVTBCUlVjUTZNZHFOSWx3Wi9wdGtnQzVMY0pRb1dydmxU?=
 =?utf-8?B?ZVNReVFxeUlZcjVMUmNjeGdwSmh1VGFkNWVrcHlOdmkxd1VzTHQrUFZ2UU9F?=
 =?utf-8?B?SEZGcnpGam1nQ21YN2kwS3FpQ3hHeTJKbm8wU0laQWJla2VnSE1FNWJaMUgx?=
 =?utf-8?B?bGxMbi9iWW5nS1RGM0JiL09qRElVYUZ1allqeG0vSGx5eDNtVGwvWkhhU0ky?=
 =?utf-8?B?NURKS2hMS2Z1WnRZS0VnTE5RUlQyRHFZbVpJMGdndlIxYWZ0YVVYbEdCNTVv?=
 =?utf-8?B?NU93MThYMFBueXM0QS9sd0Jsa21BVjlYYldjTHJKS29sNU5Pb3RXMG5jODIz?=
 =?utf-8?B?QjF4dGZRL2NMMDcrYk5DUVFVMkloTG93Rk1Rald3bThBUWgxNjh1Wk1NbnZs?=
 =?utf-8?B?a2lkZXd5NTh4Rmc5anZGZGpFRFgwTVVZcEp3M0VLcVpvbXNZTVc1UFZQK3Vh?=
 =?utf-8?B?YUNTK3ljbkdGdE02QldhRnRrVHFhUkdmYWFCa0lJVDdKNVJHTlN4RkVnYzNT?=
 =?utf-8?B?WlBrTWREaFIwVDdVcDhhWHVTUkpjenNhczBCeFNDUDVQVytTRUhidVZDdFZs?=
 =?utf-8?B?bCtYQk92TjdOUVpySFFpNTFybVQ3QVlhRHcyQkVCVTFJZlBWbStjYkoxUHJG?=
 =?utf-8?B?WUJkWVlIZUdTY1JXYmllRUNoaHRmZDN6L3IzQjZKSkIwNWVaeWcwVkg1M2Fh?=
 =?utf-8?B?dWxFMkdmdUcweGJndDhCWjRxMVFZeXdGNWxacllaZVIxZDFkbXVsTk9YZXVX?=
 =?utf-8?B?YU5XS05HUzFPOEdOWGo0OU9uRGhtWW1IbzUwWVFYMTBmZEQxWDBXYTVobW9I?=
 =?utf-8?B?biswNjlaakNrRDFreFU2emNRVlNBRGpyZ0FqVlBERjY4THgydjlxTS9sVTc5?=
 =?utf-8?B?YkxLMzgvQXE2SVU2K2ZKZXpJeWZ1ZjJXNlAyNVl2TXFuWHp2VHlOZEhaTDlv?=
 =?utf-8?B?dlF1U05ZRHZpMWYxdFN1aG53K3I0bUMyZGFsZFoxV3lTYlJDUW8xZzJtazJD?=
 =?utf-8?B?N1pKSDFwejNxbE5HMGdzZGJqUVdxNVFuZjVKa2pmUjZzZXdCdXpTS0psbFRN?=
 =?utf-8?B?QnRMc0pDT2liRXE2UzdzWFVaZEh4TEs3SlBVYkpJMm5QQWFPM21nQlNXZnl4?=
 =?utf-8?Q?Jthb7nMMuF+odIN6HyazdelO8N6BWvqH2dFzVHV6cuu0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D82610B8C8A92643924CA74931C66983@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d3b196-2c2b-420d-bd9d-08de1b573928
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:04:16.7645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9j3eqIVW2bzr8ydZpeYJft59ybbw3Hi8Nc6X55pean/XZUawDIBFY2Ily0Rr5BuPW9wtpZ+WT6movZZKqvVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFRoZSBmdW5jdGlvbnMg
YmxrX3pvbmVfd3BsdWdfaGFuZGxlX3Jlc2V0X29yX2ZpbmlzaCgpIGFuZA0KPiBibGtfem9uZV93
cGx1Z19oYW5kbGVfcmVzZXRfYWxsKCkgYm90aCBtb2RpZnkgdGhlIHpvbmUgd3JpdGUgcG9pbnRl
cg0KPiBvZmZzZXQgb2Ygem9uZSB3cml0ZSBwbHVncyB0aGF0IGFyZSB0aGUgdGFyZ2V0IG9mIGEg
cmVzZXQsIHJlc2V0IGFsbCBvcg0KPiBmaW5pc2ggem9uZSBtYW5hZ2VtZW50IG9wZXJhdGlvbi4g
SG93ZXZlciwgdGhlc2UgZnVuY3Rpb25zIGRvIHRoaXMNCj4gbW9kaWZpY2F0aW9uIGJlZm9yZSB0
aGUgQklPIGlzIGV4ZWN1dGVkLiBTbyBpZiB0aGUgem9uZSBvcGVyYXRpb24gZmFpbHMsDQo+IHRo
ZSBtb2RpZmllZCB6b25lIHdyaXRlIHBvaW50ZXIgb2Zmc2V0cyBiZWNvbWUgaW52YWxpZC4NCj4N
Cj4gQXZvaWQgdGhpcyBieSBtb2RpZnlpbmcgdGhlIHpvbmUgd3JpdGUgcG9pbnRlciBvZmZzZXQg
b2YgYSB6b25lIHdyaXRlDQo+IHBsdWcgdGhhdCBpcyB0aGUgdGFyZ2V0IG9mIGEgem9uZSBtYW5h
Z2VtZW50IG9wZXJhdGlvbiB3aGVuIHRoZQ0KPiBvcGVyYXRpb24gY29tcGxldGVzLiBUbyBkbyBz
bywgbW9kaWZ5IGJsa196b25lX2Jpb19lbmRpbygpIHRvIGNhbGwgdGhlDQo+IG5ldyBmdW5jdGlv
biBibGtfem9uZV9tZ210X2Jpb19lbmRpbygpIHdoaWNoIGluIHR1cm4gY2FsbHMgdGhlIGZ1bmN0
aW9ucw0KPiBibGtfem9uZV9yZXNldF9hbGxfYmlvX2VuZGlvKCksIGJsa196b25lX3Jlc2V0X2Jp
b19lbmRpbygpIG9yDQo+IGJsa196b25lX2ZpbmlzaF9iaW9fZW5kaW8oKSBkZXBlbmRpbmcgb24g
dGhlIG9wZXJhdGlvbiBvZiB0aGUgY29tcGxldGVkDQo+IEJJTywgdG8gbW9kaWZ5IGEgem9uZSB3
cml0ZSBwbHVnIHdyaXRlIHBvaW50ZXIgb2Zmc2V0IGFjY29yZGluZ2x5Lg0KPiBUaGVzZSBmdW5j
dGlvbnMgYXJlIGNhbGxlZCBvbmx5IGlmIHRoZSBCSU8gZXhlY3V0aW9uIHdhcyBzdWNjZXNzZnVs
Lg0KPg0KPiBGaXhlczogZGQyOTFkNzdjYzkwICgiYmxvY2s6IEludHJvZHVjZSB6b25lIHdyaXRl
IHBsdWdnaW5nIikNCj4gQ2M6c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNo
aXJuPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiAtLS0NCg0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K

