Return-Path: <linux-btrfs+bounces-18624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5777DC2F3B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AD554E5EDC
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE732836B1;
	Tue,  4 Nov 2025 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YH5kKxRw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F318EFD1;
	Tue,  4 Nov 2025 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229083; cv=fail; b=dELZKWEA/eDgeqdden/acORraOFCbm0o8olmqH+67viVTnfsBE5XS8fVbl63cbtPDbmGP/V030XG0HtiIYDa0oyw4870P1ItnY+HMo/gONgWJtMhKsr8QCe4UvOmjo5Rbu4hJHUiWBOWj9+FWamSwLBjz9UUYed/07DNQveuCgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229083; c=relaxed/simple;
	bh=pROO7GBkcvD/kg4xkTqF5FA0fJzZmyKmfEMAzs4EsnE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LDNIzJrgtlzvjv/3HEEBeOGRhvsmTTz7C9JIxYM07xDadrRdOxrwWEhjW9dyL+96vpCrU0jS63mNDHAupxV+xC3b5B8qhEBewlbbguSrjk16AasyCUn6JXsJ7BkQMo5dFIYo8LNpw2EYeqYtI2FgbSX6w7CnneyC8mp3PEryAuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YH5kKxRw; arc=fail smtp.client-ip=40.107.208.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikEGUJI6NgYz+nspJcZNpxPTcGT/OcYQhrxu9EjDL9zI2HjsARP0ZSvbI7+lrBRnBSl0ao00sqhgqbTTsl7JqYQ0J3yupSrPJOCVoiDsQnA6oz9EnM7R4JAa3NZgvvMHOAUZYfmv9jvjE9VlOZm+5GtbWGYPRHCWih0o2/HMRylKCo8XEV/1rLEJkJN76Bhp6FiHW9j2iIZGBPoHvxi/IloSDas/nyvgrdVGhvssC2KqV9Ad1ALyhvWpOlz1guNzbe9whExoiLTcFkVPVdKBGTp+HIQufqeSIiUAkAZSmbDWdt7/IRAVzFoh8msr1JHRGihgQv9a3K0IBwp6+T0gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pROO7GBkcvD/kg4xkTqF5FA0fJzZmyKmfEMAzs4EsnE=;
 b=YkuQRrovYG7q9U38Czo1BSZBaouX9HQZ5T54Zz0yjytBRKRkVwfCDhIXCL7rSvJ/6Fj/3u3Rk/jbpn6VBa6eJbxc0d15UdOUQGePMm6t88P5KJdi2TagPXaT4QdLqk2GOWzPkMyertwrelvC6YztK7DxHb/7hYUvmHwKa9kdoDiSma3FXnzsn3Z1nInrhdVD65w4PbkrsWMiowwt1nGm2QA4Nis5h0h/22KLob7ivSpK3GoaQUBhjoxmFnYm3WKGQtrVvM2xfQYG0swpE2ME/8XdOy/UvkOE4/H1ufvschxvGAScRMGBd7a+prz2alMfV5ahkxKyGXUxMg9ae7/uBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pROO7GBkcvD/kg4xkTqF5FA0fJzZmyKmfEMAzs4EsnE=;
 b=YH5kKxRw06o1IA4ua6+DyJFvHKOla5DZKp/OlRyAj/YXUmj2woK5K8qYK5N3bllmh/IYBEWK4vAlNAa48047IlmXHVPFQEnzl0r390Z7KM1eCwS39yBuw1Y4Yi4FsiGZSzle3xVkvt0G+3OXKYJnyP8Hc2SSARLytsCBjn0lfKNV4okXADrNDOJZkK7UcNRGn+glTyeTMWHtsM05vbHZ6lFrAXRFDJdJJDXPRcLCisSxiVMeeatrRZZy4r0Lr+Ke2kk3hMS3B/eta1Wgo+SQlS946X/Pf0om75UGDmy9Zk3xzCQQoR+hB6UP1Qbk8/yDcgWcPRwnCcbZQMXK3Hkhyw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:04:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:04:39 +0000
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
Subject: Re: [PATCH v3 02/15] block: freeze queue when updating zone resources
Thread-Topic: [PATCH v3 02/15] block: freeze queue when updating zone
 resources
Thread-Index: AQHcTSti7EzmYDzy7kaB3KQ+AHaqVLTh5e8A
Date: Tue, 4 Nov 2025 04:04:39 +0000
Message-ID: <d9578cfb-747a-4148-921a-cad496161944@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-3-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6853:EE_
x-ms-office365-filtering-correlation-id: 9c09c4dc-6308-46cd-e435-08de1b574683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1NIaXJGakhQT0E2UWd6RWN5ZHpaTWo2cGhLQnVNTEFnQjhka1JyVk9VNjVv?=
 =?utf-8?B?YU5BMWU5WDBGZm1aR2JMRFh6d1VWdGRXNjJONkJpVlRmWXAxMGQrVEExYk9i?=
 =?utf-8?B?S2MrUGl2K3RqQkNoWGh0UmRBKyt6QU9nSllVaERYSVlTVEtyQ01JZCs5NWRa?=
 =?utf-8?B?dU1UK0kvQUNlZXV3U01CWEU5cU05M3pSSE01a3dDWmJ2SG9nV056VG1EWXRy?=
 =?utf-8?B?L2MyQ0lpVTJpc1lqSWNrZlVBTFh3YkI0Slpia2JiYWU1WjNVb0RpaHRkTXlO?=
 =?utf-8?B?bWw3RmdkSDJBeWErZ3RheGF0aXdIUVRTY1NmbVU3VHpYZG9mSkR0ZnROYVJS?=
 =?utf-8?B?aGdCTkRYcEYreFR2Yit5TjVtVDd1cHBWdkFRcGJpeFJEUGpsb3FRdnZlZ1RV?=
 =?utf-8?B?WGt2MzVtRWpOQmV5enp6SERTMzJNV3pCbGEvNHJ6ZkxHUWcwUVFyUUttZ08v?=
 =?utf-8?B?MW00OGl4cWthWHhoeEtVTEtlMWwwQlg0L0RnQkREVnUvVzJGQm1ZRnppeWRP?=
 =?utf-8?B?Rkp3RlN3dzQraWNGTUhpSksyUy9PRStnZDBwUkdyVmJBN0kxMXpYK29HL013?=
 =?utf-8?B?Y3ROK2xnQnFSWVkxT2JsanhBR29uNllGd3pGVkZNMGFHbjRTNnJGQ2VjL3Jt?=
 =?utf-8?B?dmJmNVprbE8reEhBVVUwYSt4MVp5Mks5TUJNUE11cmFsZnRkT1AzeHpBQU5G?=
 =?utf-8?B?b1R1Mm5mWUhOckg5cXZBZ0RzdUphN1hndXdJQjdCc2NLcU1tb3k1NFhuSG50?=
 =?utf-8?B?TUloVnc3WmlrSk8rc0YvVldUTThieVhYelZOYmlUMzRycHhaRk5iSTBmekJ4?=
 =?utf-8?B?bVpUL1JQUE9RbklxQTVrWW50YU4rVEllQ3ptTENVSUNBRFNoTjZUSTV5c1BO?=
 =?utf-8?B?YW9qWktYNnNORHV1SlFUNXpzNTdtRHoxdGxyMGh4cForOHY1c1FGUFZsakFU?=
 =?utf-8?B?S3BEWEZ5MUQ4NjRhdHFsWnlHUzJmVjk2VG9NaW5NdHNWOWpCOXZRZzFUWEdW?=
 =?utf-8?B?VTlqWGp2bjVweEhqZWg0ZERlOTc1R1FER2RtTVBVbVYxQkxlSVpQYjF2eFA5?=
 =?utf-8?B?SjdNQkJYdWNFbnlWS0Y3b2ZHK3hlSmNlZldMSzJEUjA4Wkx0NmxWTTk3aHhD?=
 =?utf-8?B?ZndyVHFnaVNrdUZkQWpwSEJuSWtPYzVDeXVWZllvc2p2czQ5S1c5cTl1SnZk?=
 =?utf-8?B?WU5WYk1mU3h1ajBnRDh4a2Yvc1ZDcTNFaDhuMEs5UTFBS1JLT3g0QmtJNjhK?=
 =?utf-8?B?akhoNU13WmYzRm9wb2dONDhqLzhWSDkvQ2dOU2R0T0dzMy9xVlQ2cmQ5cFY5?=
 =?utf-8?B?TlQ2ZEVjRUJOUXBUWEc0NTFmVGpvUktpMVVLcllhTnlpeWZKVW4vQm8zcGhC?=
 =?utf-8?B?MkdxM0FlN05VdCtHdHlPRXh6ZTJXQmFjTzhnMDZzbkxmdXFpQ28zMnZkR3dv?=
 =?utf-8?B?Qndwc2pzTVNjOEtZbEhDNW5wM243Vk01djRWTUZaeGxQQlNKcFdDREdhM2JW?=
 =?utf-8?B?eWNZWWxybGYySm41Q1lMOFB3dFBKaWFzczhBdHM3dXNJQTJ4eTYrZHlmTUlr?=
 =?utf-8?B?SGc2WTA3UE4ycHROSkdiM1dZTmpyRkJQd3QyN1FqWm9ZWUp5Q1ZKenRseWs5?=
 =?utf-8?B?NjYwbDJrL3NHSVdNQ05kMlJ4NU0wYTVQWFJEU2dpR1FmdjdvZTZvODZaZUJF?=
 =?utf-8?B?eVBYUkk1L3NMSkdYS2FVQUVlay9TS2RMcmVyWEdnMEdUMEhkWm9VcnBRK2Ev?=
 =?utf-8?B?bW9xQmR5UU15RUF1Tlhkdlo0WHc1QkpFUno5SEtYYlBHZDBrL2x1S2dPejdQ?=
 =?utf-8?B?ZUJHbyt1dU1VWFhKT0NSeGJBUmMvendnMlJESVR1R1FQWGF1ZkNaRXdXWGVX?=
 =?utf-8?B?TTN2Y2NXaXhqVkJhcitDWVQ5eVdmNWtZVWRYdHhtakZJeEQrdmY3WHl1VVpv?=
 =?utf-8?B?WU5FRDFvUFJwdjFSNk9ZQkZJbVVPbzFZRW5xN3FDaEdkeDZJM0NEdkFocGlD?=
 =?utf-8?B?ajIzWFl2RXlhUzNpRGJndnBvY2syV3kvbWttb2xuWUxicSsrazV5TU5RRG1a?=
 =?utf-8?B?QThPd0tuRUxpUFhmbjZuR2oyWVNHTEJvYlFXZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eERoaHdkSyszaFhNeit1RmpuRW9QS2RPZ2hKNGd5VW5JR3hOQ2M2b2xUd1lD?=
 =?utf-8?B?V1BFV09mVU1zL2NkYUhrS01lMzNEakI1NEJYWmdkcC9tY1E3THNXcllLdFF2?=
 =?utf-8?B?NGVRY1ZoeTB5RmJDNjNyM2ptdHhrbnM1Z1lJQnYvSFJIS3o4ZHluZHcvbUpE?=
 =?utf-8?B?eUZYWlhkUm9nRkQyY2liK0ZrSmp6MTh1ZXZ2Tm1IODkxdkNEb2NqTE96WEEz?=
 =?utf-8?B?Z3JaOHYwK3BOUDVmbGhtSktHSE1XQ0RURittcXZYZGZvMW9XOVhyb1NsOUpj?=
 =?utf-8?B?OGJ2WVlpT0IxK2xEWVh6U1lrVDI0OFM2UXJ3VXEwd3p3SWNUVDBPOXFFdHBr?=
 =?utf-8?B?THd2NmxmNkFIMnRCZUtud3JhWWE1amUwNjRWNnlxWWJOY1MzZzFJMmdUSGNt?=
 =?utf-8?B?K2FOczFXSGZreXFpaHV5dXE5N3ZUQTZ3cTJlR1FjamFNdjlhN0dIcTU5dFZz?=
 =?utf-8?B?UDNvdnZneEJrVWt3K3krSkJ2NnB2QnoyVUpLWXlmY3h5OWhDTzhNNlZaMkN2?=
 =?utf-8?B?TlFXeGNuL0JjZGgzL2FtS3B5QUc2dktnRDJnZWJuVGNQbGRvOEkxUVJBbVJE?=
 =?utf-8?B?eUxickp4MDVjQmtlUEhWMGdNdU5FbWhKNllpR2dkZ2VPRGJud2JWcEtFbC9s?=
 =?utf-8?B?VHVtYzNOOTUrSVJkN0tIZW0rVDlYVnVMNm1PUmFYVVZpZWRvTkoxTkJWR3lO?=
 =?utf-8?B?d041TVRPdFV1TkVoTlRQMmRpM2p5QVNOTWtzZ2dUOSsyRC9ZTEJXKzhYUlZ0?=
 =?utf-8?B?aGFvdUJHYndJbENYM1Z6aVoxYjZudXpNNUY2bW8vd2RTaDVxTmtvelZOSk8r?=
 =?utf-8?B?MU5nbWd3VW1YYzdwUTc3TVE0UW9LTGZTeEU1alg1Mm1zN2dnVHlFTjl6WlNR?=
 =?utf-8?B?bDg0WTlUanFUTVU1UFkxZzNsV0d5MFRzbnZFSVRSRUVtNko4dXRDTkJyTDNG?=
 =?utf-8?B?MjRublBSYzJpQll6c3BjZDlJc3VzaU8wUytMVmtkbFBYUDExaGZGN0ZXRVRm?=
 =?utf-8?B?MXl1UnhpM0RJR252NFBCNDJwS3lGUjZxZDNTTStvU0daTm0wUUtRSkwwWVV3?=
 =?utf-8?B?elFicW92Q0ducE1XMFlTZXhmMHlQS0FMUmhTVTVnV1pUK1FIYWtxc3Jld1NZ?=
 =?utf-8?B?aWJaN0RoUVlUS2VxSnFuUUlDSE1VL3J6YUlZQUl5cGY2UkVvamxxbDFLTCtE?=
 =?utf-8?B?RU5hcnZPSU1QVXM0Ly8wTENkdFhwZEFZZ0FFaEdNMjNyaHhUU3RPQlpyUVJF?=
 =?utf-8?B?WkJDUWhpRkU4WUVKTmhkRWl5T05XQzFJaEh1SWZ4VGdsMnM5b1dyV2UvVnM4?=
 =?utf-8?B?cWJHT3lGbGtCNWc2TWUrNmZyWDhiN3lMSWMxU0g2T2svOFJ6Q1ZySmtwUzQr?=
 =?utf-8?B?MDQycXRtNkt3cFdoSXdiSlVyYXY5d2g3SUtPTi9wQnAzUXBCclZVQXN2OHBa?=
 =?utf-8?B?NzhhbWVHeUN1WC9HSjVFdmhzblVoZElGbUFFeG4wS3hyMjQzaVZtL3VtZ1Rj?=
 =?utf-8?B?MjlUdEdweDMyb3JpVDhRNWI3Nm5lRmJJWGkyMWdGUEVSMXVabzd0LzBEODNL?=
 =?utf-8?B?VHEzRmQ3Y1ZBbnAyT1JzSlE2VDNjZnlnaUY5TWNvN29uVC95V1QxUUFrdGlL?=
 =?utf-8?B?Qkw1dEtmNzZsOFlhclRRZ2VjUGVraFE4WGdLQy9BekpUL3dieFNvc2t2dW1v?=
 =?utf-8?B?b2xZdDFtL3FvdE92Z2llRVZnOVp0VnFRNU1Zamkvd1Q2aGdET0FnK01CMFpi?=
 =?utf-8?B?WVBQRE8zWjZVSGhKaVNDcUhiKzBPbktnSFJMZ1pYeVk1R1lOMUlscGNDQWM4?=
 =?utf-8?B?Y3FIanFGVjlsUXVCNG1OdWtkL1lRZkJCUnBqWnQ2ZHZ6VUM1WTdpbWpJM1NT?=
 =?utf-8?B?Umc1K3Z4ZUR6dHcvdnNpcDFYaVBCRzFiVWQ4cUZ4amRNdVQwTVRidmpNZUw2?=
 =?utf-8?B?elZIQXBibitWTFd1NGs2Z1FWQkV6U1ovTllBMExtUXlidEsrTktRTEhUd1dx?=
 =?utf-8?B?S3pja3Q4cHFIUEgzVlBHZk5WRjV5eldBU1BYR3dVK3ZYUVEwSGZib2NZSytk?=
 =?utf-8?B?T0t1MUhYTVFXZC9MRU5BTWx5c0RjV1lWbG9SV1c2aHo3R25nVjFDY0tnUzJ2?=
 =?utf-8?B?UXpjMU5pdkhQRWpOcldkb0lhTFNaYUhocEpuYkpkMXRQbkN1bHhyWU8weGhE?=
 =?utf-8?Q?hKS3qUNByINmULz5gU5PVXqj2bw2z6eX0F0GnfrgX0go?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5A56F5118D31A4A84F125A0401716E0@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c09c4dc-6308-46cd-e435-08de1b574683
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:04:39.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vm9qV4z4A/kLBDLEocwC+LSR+ySF+51ka6PxcjXxfNm7w56ZMIZ+kzHEBpBHR+vcNB6dMLeDykxGU5+H9enhug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE1vZGlmeSBkaXNrX3Vw
ZGF0ZV96b25lX3Jlc291cmNlcygpIHRvIGZyZWV6ZSB0aGUgZGV2aWNlIHF1ZXVlIGJlZm9yZQ0K
PiB1cGRhdGluZyB0aGUgbnVtYmVyIG9mIHpvbmVzLCB6b25lIGNhcGFjaXR5IGFuZCBvdGhlciB6
b25lIHJlbGF0ZWQNCj4gcmVzb3VyY2VzLiBUaGUgbG9ja2luZyBvcmRlciByZXN1bHRpbmcgZnJv
bSB0aGUgY2FsbCB0bw0KPiBxdWV1ZV9saW1pdHNfY29tbWl0X3VwZGF0ZV9mcm96ZW4oKSBpcyBw
cmVzZXJ2ZWQsIHRoYXQgaXMsIHRoZSBxdWV1ZQ0KPiBsaW1pdHMgbG9jayBpcyBmaXJzdCB0YWtl
biBieSBjYWxsaW5nIHF1ZXVlX2xpbWl0c19zdGFydF91cGRhdGUoKSBiZWZvcmUNCj4gZnJlZXpp
bmcgdGhlIHF1ZXVlLCBhbmQgdGhlIHF1ZXVlIGlzIHVuZnJvemVuIGFmdGVyIGV4ZWN1dGluZw0K
PiBxdWV1ZV9saW1pdHNfY29tbWl0X3VwZGF0ZSgpLCB3aGljaCByZXBsYWNlcyB0aGUgY2FsbCB0
bw0KPiBxdWV1ZV9saW1pdHNfY29tbWl0X3VwZGF0ZV9mcm96ZW4oKS4NCj4NCj4gVGhpcyBjaGFu
Z2UgZW5zdXJlcyB0aGF0IHRoZXJlIGFyZSBubyBpbi1mbGlnaHRzIEkvT3Mgd2hlbiB0aGUgem9u
ZQ0KPiByZXNvdXJjZXMgYXJlIHVwZGF0ZWQgZHVlIHRvIGEgem9uZSByZXZhbGlkYXRpb24uIElu
IGNhc2Ugb2YgZXJyb3Igd2hlbg0KPiB0aGUgbGltaXRzIGFyZSBhcHBsaWVkLCBkaXJlY3RseSBj
YWxsIGRpc2tfZnJlZV96b25lX3Jlc291cmNlcygpIGZyb20NCj4gZGlza191cGRhdGVfem9uZV9y
ZXNvdXJjZXMoKSB3aGlsZSB0aGUgZGlzayBxdWV1ZSBpcyBzdGlsbCBmcm96ZW4gdG8NCj4gYXZv
aWQgbmVlZGluZyB0byBmcmVlemUgJiB1bmZyZWV6ZSB0aGUgcXVldWUgYWdhaW4gaW4NCj4gYmxr
X3JldmFsaWRhdGVfZGlza196b25lcygpLCB0aHVzIHNpbXBsaWZ5aW5nIHRoYXQgZnVuY3Rpb24g
Y29kZSBhDQo+IGxpdHRsZS4NCj4NCj4gRml4ZXM6IDBiODNjODZiNDQ0YSAoImJsb2NrOiBQcmV2
ZW50IHBvdGVudGlhbCBkZWFkbG9jayBpbiBibGtfcmV2YWxpZGF0ZV9kaXNrX3pvbmVzKCkiKQ0K
PiBDYzpzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBN
b2FsPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2ln
PGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

