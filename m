Return-Path: <linux-btrfs+bounces-18625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A1C2F3C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57CAD34C9C3
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223892C0282;
	Tue,  4 Nov 2025 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LppLeDjy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F61D5CEA;
	Tue,  4 Nov 2025 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229099; cv=fail; b=A/SPp7o9Y7UZdKntAKLFKwbgo0z6vcNRf+1/uHqHp3IEpM0ZNT0djfnvJA7XmFMNuytjHmpiUXlwGmonIrWov3X7qXtEKeE5G3xZ961GfmWmmmm/u1gSUMfpT94AE/GVr4z0KatwuRO0+3tIoOgtiLItZdkHkMzzogqPOu85AqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229099; c=relaxed/simple;
	bh=g9pnUsbrRLdeDF8lBnQO2Tsd99opuFIN0y2gxCBd/cw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HuK7v412qR0fbHQiXHbi/HcWT6RwlftYkoA1M0RgMe5Pf/DdGjv2kQULh/f1R9MiAxPUnmjqvJL3qNfkQDLjYvrgtIW/ihRIS1e8uA6/yZu2LHDJH0K9LG9wDanbX4t3xVr5MId/fPUsn9tUPuM6xa6lRf7AnhgDQrnKfQSkUKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LppLeDjy; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Khc5hYkThBU+0SwxT5RvJ7MpnYFAQKO5cCZodWIekJohDL7gGg/vp52trNUWGM3i2nwgLMhz6bqQ7ZMzfjBOIrDaYaJX5U+LBmU8tTf04flF83dtovgnAC2U1qEWO3Ni2pcHUNPx6QHFaGm9dB1RHU+HIPVSdGXHJzYnZqK0HiepAaIyRrulEVQLyQvIAwINAAv88bkdQ8sppnTLU6Yy10VqPKNVpbAE7TFm0TNyuua8lJ/XUUsG7LDlKt59ggCYf8kqWWbLewaGGBQGnd/4iL5at0PEBAJPXhJ6O6F6Gy4r6OcrO4cLeXMcmg4MGR2S5p12kGVKp0fSM66SFqzcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9pnUsbrRLdeDF8lBnQO2Tsd99opuFIN0y2gxCBd/cw=;
 b=q65XpA6FewrKdAeZXIp7Jz0I7YGr/MV/M/Aml9tjBIKmHmgj8q9lxLgTP4SWWB3KzmnjzABdWz7Rbp0a+839CgH7vBBh8H782aK5WfWmQK/27iyK/dKDB19dh7Y047bB3gzwpoFapjrumCqBS7VJcBInuypTpZ2Wrey20iIrPfq0ZuIBpAwS8qWhaRzL8ucaicMG2ntQpSR+vl69MYqesRa8sy5o9k5M5dZOWTFegOAorZOpdpQpK7bNkDchMUJbb4qd/+/9k74oCdKNSLErdBOD88OMcft7hYR96ZMnv1u1qiTvblT9iyhqz3ZKDKWXDp3/wJ+e9moDrrb1eUeQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9pnUsbrRLdeDF8lBnQO2Tsd99opuFIN0y2gxCBd/cw=;
 b=LppLeDjyROJUCp24excoDjEYRnGMnFVMEelxu/pw15Yif0+ihFoe8tExz6VGyDYpgF/9yTP+jVkP0s62EcLBudLq6K9MaZN7z8n9rxqjBOVYwXRHpotHrv8k0PKnfSIOqCmcz4hva70X9jGiZKWXwBWAOuOasF2JFdgMFy0cjReCtLNNRJjXXO4//VDTeT1RSCuJn5cZgU4MyvMhEEkJGDWaEGu+eSOlXX3M8jTZ7UVvS6EmBSlj1nhUM32qlKo47hqnMJ/K790UTbaRsfdyK3HXqh9YDDVVRNyxUnTvQJJJ4pCkvnmU/rw8vUEneIl7wwTc2xXDTX7XeslyN1SyzA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:04:55 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:04:55 +0000
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
Subject: Re: [PATCH v3 03/15] block: cleanup blkdev_report_zones()
Thread-Topic: [PATCH v3 03/15] block: cleanup blkdev_report_zones()
Thread-Index: AQHcTStgfA37UY9jck6MvwntKDZFELTh5gIA
Date: Tue, 4 Nov 2025 04:04:55 +0000
Message-ID: <e52ec848-3fdf-4832-81ef-0fa22a266841@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-4-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-4-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6853:EE_
x-ms-office365-filtering-correlation-id: a2beb006-4479-4e7f-5924-08de1b57500d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1ZyMlhZTmJ1dDd1OTVzV255b2ZZUVZvUWVHbzdTNmI0QWJJaVM1OG95aWs0?=
 =?utf-8?B?QlBUaW1CUG9zUTVsT1NBbHhvK201cXhwL25BMW1JNi9GRS80MkVSL0NYbzNv?=
 =?utf-8?B?SldqbU84U01GZUhBZnM4ZWJJQXd6dGYrcjB3THQzUVhiVktkNzZrRGZsOC91?=
 =?utf-8?B?QnBlRitnUkNVKzc4UmxIVmJoZDVFenVNeHdBdkJxa3ZxWkNFTXRBOUdvQkIy?=
 =?utf-8?B?aWsxOVlkNDZKWTk5WW1DSzZRUVdzc2t4YjRLVEtqNHBhYmc5OFlsbks4c2pu?=
 =?utf-8?B?M1gwQ1FWYzNtUGFQZWdVV0NXdktuV1ViZUpLZytZaWtXTGFYaC95ampWLzVN?=
 =?utf-8?B?eVlRT3h4bnJUN25mM3dkSXRYODJ1UDd0TW5sUjVMeUpxQS9iTUlzNXZieFdV?=
 =?utf-8?B?TGc0eXZWTmthUGxlY1ZPaFlBdlNSOTVtcDhpOGsrb2k4cllVdjdMcnNTYzA4?=
 =?utf-8?B?dEdCTEdYM0puUWJFaXZYdytVb3pvb2JXRlNVQjNBRXpRQ2d1cUhoa2RpN2FO?=
 =?utf-8?B?TjUvZUN4SE5WSFZmdVhZV2xNSDF0QUhnTWY1MjZFWnJicGtzNTBLTmZmZHdp?=
 =?utf-8?B?bWQyS0ZXTWZvRytYek40dFdwbC91OTFXekY3L3lVcUsyUTFUOUhKL0pPbk1w?=
 =?utf-8?B?SERJaGtQSW5uTlVVaTFkVitXMk5uazNaN0ROODhDNWF1dnhQSWd6cFJWdjNv?=
 =?utf-8?B?SVRoenlTVGNFYVVGWkhTVUxMNlhSdmkyeGtFNnFFQlZGWGZYRFIvbkRuMUJL?=
 =?utf-8?B?YXkrTVg0VjZnbW1oUlNwWko3M01oOUd3S29WQTE5QWd5TUNoWXJpK0JEbjNw?=
 =?utf-8?B?YUh3YTFKNHZHcWdvb3Qvc1VwWkJhZmp4Q1prb1lnQVFGUTZDeG51ZUZ0LzZU?=
 =?utf-8?B?dzJ6VGEyajZmODhSb2FlMEd0OVk5VlZ2K1QyRXJqWnZ0bytLSmlINnNSR1hC?=
 =?utf-8?B?YlNPUDNodXF3K2JUVmsxTTBXTDJIZUk3MXl4QXgrRnpUZFpZT1RodWtUTVY1?=
 =?utf-8?B?U1ZaanBlUWRhYXd5L3JTT05tWEg2c2d6UEZXWTV0bDRRM056cmw5dUpnTmVO?=
 =?utf-8?B?SW5Hc1YydlJwNTRNZVl6SllnL3JWUFdHZ1VYeHErRXBnK0VEZG5NT1NSNjdM?=
 =?utf-8?B?Q2NXSktrT0lpTmhFNXFkZTBncElOS2VEbTk0WVVQeGNvVFBiNGM3UFBsR3R1?=
 =?utf-8?B?b1U1aUNic3F5Ky90QlhqNlpuVVhZc2F0YjdnazRjV2pGZU42UzJwYUFNNi9Q?=
 =?utf-8?B?d04xQXBnV29waVRQWUtmV2tzS3pBbkt1c3VqZk4zQ3podzVrS2VNM0Jhakpm?=
 =?utf-8?B?TFNIQkdMbDNsSTIyUXNqdG4rTzl2aXFWL2xpYWJxYTEyVE82eWFicUQyWnI3?=
 =?utf-8?B?N0pUWlQ4b2IxbzloT2hVRWZoWU9BMmtkVEQwSUhBSVM2bGxMSy9Bb1FpbElY?=
 =?utf-8?B?MGFIVnJEZ0xXaVV2L0VaRGUzd0s1Y2pJZWMxY2dZbHpId0FrMWxMTHNNUEw1?=
 =?utf-8?B?R3ViWXdRdW43S1dGd3dMQnNLZHozRW02V003eVI3OWdyVHJrNVB5WkdsVXIw?=
 =?utf-8?B?SjMzQzdxakVpTGQ2WmxYOFdkU0xMcDVwNVpod0hQVEt0bnQzOGEzaWhOU2FJ?=
 =?utf-8?B?YjI0Z0pnVzdPL1pSVFBuVVZZOUlseWxQNGxiWFd3RWpoQzg2eDZnWjFnSEF1?=
 =?utf-8?B?TGdpenNNMTNiZWRQVFZnWGEzNUZDejc4dDVDcGRBelRNZ2RmdmJqdy8vUXVy?=
 =?utf-8?B?WVlmd2FyQkNhSTh2aGxqYlJodFBXQUE2WndXUFZBamxmcmtleUg2L0J4d1Zr?=
 =?utf-8?B?Q3JvTTY5S3c0NDA3SzVXZlFuU1JCNmJuSFVIMHNKd3VqRjZMS2lUUG9oWlNB?=
 =?utf-8?B?dG1MTndQL3dpSDMvdkt0bUk0MTA5UzJ2VXN0WnVsaVBJTVp0QWhvNm1sZ1FM?=
 =?utf-8?B?SEN5Y1Evbi9lemE4a2liRjFNS2hUL0dkbWxXL3B6M1F6ZDBNUmRDaVZnU0RW?=
 =?utf-8?B?VEdJQlhKY0h3K21Ubml4bFpQbC93VzRiRmFHMHh0eG5UUWhBcWR1eHlXMTBn?=
 =?utf-8?B?MFUzSmdFUEFhdVVqQWpEeDFneDJxVDV1TEF5UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MElIVTQxSTJjQXJQZUhUN0t0bVk5YUorWDBGdG9vZ1N0WFVEM3lRSEV1Z2Nm?=
 =?utf-8?B?dXptL2JudDZTRlhnZGJoM3R2ampxQW1GYmM1L1l6NnZxVEliWWV6cjFscTdK?=
 =?utf-8?B?NWQ1T2FIQW1OMElvTE1FZUJycmlqRmhvUDU3alNqOWRQc2hJODg4elFWLzZp?=
 =?utf-8?B?Y3FqOFp5dWRNVkF5Q0UwczA2c1A3ekV6RVdCbTFLZ3VyUVVnSUFJVDV2eGJn?=
 =?utf-8?B?QXgzNUY5emxPZ3ZxZUxCWnBXaW0yMzNaTmRST1U5ejJnQUpjeUtpOEtpTG9k?=
 =?utf-8?B?Wkd1Y1hPbi9wQVAyb1FpSEtQMnZzemR5a21VM3NjaDNqWFVVL3k5SVdXMkFT?=
 =?utf-8?B?VTA1ekpzSy9jaGhTQThGcXpaQ01ldUdKUEd6REdGTU81U0ZDdFJMbUEwcWdo?=
 =?utf-8?B?Wk8wWWJkVDJ2OGZXdW9UNWFmTFcxY0g0MGVRUzV1ZVNRUHdhTllicnJKU3Vr?=
 =?utf-8?B?U3M3WnRyRE1Nd3RIa041RldMRC9mQjJCcW4xZGFkYjJVM1BVb3lBTXRqQWt3?=
 =?utf-8?B?emJzN0JZMitLTldKOUliYTRWS3U5YlhEcFlXMU84b2luV1AxZ3VYNkpPYXBU?=
 =?utf-8?B?M3pZVVVuMnY3ckozVEd3cm14eTRENFovWXlCSWtNZWRPclNjRUhoM0JKdHA3?=
 =?utf-8?B?L0JFTHBBeGRwWDRycFVNSWNyZVpvMFUrZy9tWnlZTGxXaWo4bVozRkJvWkNx?=
 =?utf-8?B?ZUkvNkFHR3JINXM5cWpSQ05ha3I4bFhvcm9lSVY4ZWlVQ0lFYlB5YWZITkpv?=
 =?utf-8?B?QlQya1hFamdKR2hTeFpUNjhsTUt5UHBYaGJHSlJHMXRuNmFBVEdYQ2ZVVzc0?=
 =?utf-8?B?MlNFYXZSaWQ5T2dpMFZYOUxZR0hMeHgzbzduN0NMMzJNVTVZZkJha0J2Tlhs?=
 =?utf-8?B?QXRIZC9QSWRSSERMOHhMZzJiQTB1UUFTMXV5NC92K0JiY0EwSVErR0pMd0Yv?=
 =?utf-8?B?OXAyaitxN1Y1ZjJhYXI5VlF3czFnUUdXY083cWVOVXZoVUtZbVNaRzZ0Ulls?=
 =?utf-8?B?cWZqdnpFbHdYSE1kZ2tSbzJuZkxhL3c4OGNqQU5tdGlFcnU1ckJBMjNGUGRt?=
 =?utf-8?B?K2JyeVZJN1VlaUZ0RzJZbms3YzdXSjNhTk1BaDNPMThUV0M0TlN6MTZQNjB5?=
 =?utf-8?B?a3JQOTQ2c1UrRXZneEZFUE5rSDZCWG9zWXc4TmJkNnRmQVVsaU5aOG5DVGdJ?=
 =?utf-8?B?ZlFTWi9yVHgzWDlsQmtMU0tya0dadE5VclRaa2FSWldML211OThZRXZTUE05?=
 =?utf-8?B?RGpES1UvNG80bnNTcEJPcDhPVUZhWUdlTVFha3pHVkxIdWZLTm5KMlVGeGRn?=
 =?utf-8?B?ZU1pcGFBbzJqZVBoTTgyN3J2Q1dHcW1UdU92dU1YVnJFSzZCMS9ab3VWYmdo?=
 =?utf-8?B?NmxOT0YydkdQUzV2RVU1NDh2MUJ0QmRNRVVYVUtLVVIxdktMV0s4MzNYTjhh?=
 =?utf-8?B?dzlNcithaG1YTlN0VlJVMnlUeW5SKzFrRHFGaFRsOTdNTlZzaWxtcXFxTFZt?=
 =?utf-8?B?eVVOZXgyTmpZbXpOdEFpTzEzUjk2TjBneUNTQTI0N0kvZ0pOMmYwWEgxRERT?=
 =?utf-8?B?bExBbnl1eC9vVnlCdFN1SHRPaVVnRnRRTDNiREFndTNnVVd2QmE0UzFiTERD?=
 =?utf-8?B?RW1CdXdrenB5djNvVmYyOC9JKzYzNGRqQ3RkVStwZE1pMDh6dDlZd0x0RXFq?=
 =?utf-8?B?QWNxcWVJQXVPZmpJL2Z4Q1F1MjR4VjBVVUl6SXlqMkJ4Ny8wR1lpbTRrSGc2?=
 =?utf-8?B?Rzd3TmNReDRiZzVxcmV5YWRqbm82T2cwblJGNEQvckNocURESnV5NlE5OFdO?=
 =?utf-8?B?WEZ0V2V6ZEdUQ2xZeHdOVVFkUW1ldWtGNXJ2b2xOUkZzUTlRVkdkWGNpL3ds?=
 =?utf-8?B?eDRFeU5PKzIwY0VKdDIyVEwweENnZ1JhQ1VCcjlrUmNrb3l2ZitWRGpvQ01a?=
 =?utf-8?B?SDlUcGRlWmFEQW4zQ29aZE9jVEoySENCZVVON3Y4YmpwWDlaSFVhbWhOVUJP?=
 =?utf-8?B?NURiK0pRRWo2amZibXVBL1Z6ekJOY21LVVlsRkplNVVNZ1Fzb21rdmZuUVFQ?=
 =?utf-8?B?NFQ5UlZUNDIyK0dkZEVDTzNVK3pFOFZkWmtRYVZqUFJjVzF1YlZFUjNPNDJB?=
 =?utf-8?B?b2d2azlvZUZMU3d5KzQwc05zdk1kU2NxYUxzM0pwSmxJVXg0MERSYmlOUUps?=
 =?utf-8?Q?OI6TGa7n7xDnM4XoR3rxnIjgM2nC8+m0iL7iRmIQKNt3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D64DD5FF8C12B44A9BCE2BF3B41F934C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2beb006-4479-4e7f-5924-08de1b57500d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:04:55.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENaeeXbi8S8B2TfqG/1ImFPUqoK7CznBkQM8IVMzL59BcKD78NYe/JvrWuM2cvi/atMACi8I2UpssJE3u68GRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFRoZSB2YXJpYWJsZSBj
YXBhY2l0eSBpcyB1c2VkIG9ubHkgaW4gb25lIHBsYWNlIGFuZCBzbyBjYW4gYmUgcmVtb3ZlZA0K
PiBhbmQgZ2V0X2NhcGFjaXR5KGRpc2spIHVzZWQgZGlyZWN0bHkgaW5zdGVhZC4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWw8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdl
ZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEJhcnQg
VmFuIEFzc2NoZTxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVp
bmVja2U8aGFyZUBzdXNlLmRlPg0KPiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiAtLS0NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

