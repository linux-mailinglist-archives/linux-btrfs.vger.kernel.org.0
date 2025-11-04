Return-Path: <linux-btrfs+bounces-18636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C4C2F4A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255003B784C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A52877D5;
	Tue,  4 Nov 2025 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RO1tSUXD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC4192D97;
	Tue,  4 Nov 2025 04:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229765; cv=fail; b=OaLDpNaogvR61JcDztMC6FslS/rbteg6Dw/GRAjytTsFKnVig365PuF3mRDxHhOZzBTOrUsSaMIi04xFq0APHY3D52EX+vaVOCYCWsWGsGAV0T1Jh7ALoqXgpAqZNuA8Sd7s4JbKuoXctsONl44j1iW/ttomdcgR+DQdMDxUpQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229765; c=relaxed/simple;
	bh=2gc127TZy6LzBlvfgRe0aRrGWbkprYIO+UsDyGu7ljw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jBA3/oRev+z7MDqnXPXiPnK49q5nzSf+PPYw4f/CNsSetlQeSJFTJQ7miKB+c8RekwgvjQLLugnAGPaUTpLy9PgkfR8gnS+jpg6PTSfbfeHxDoVRI2vgUtk+07MzYlM10l93rz8Fn+lc9ox2+RIyzlVLlkKTfK28xKV3CZ5sVFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RO1tSUXD; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOHTJ6H95mP2tiLQJFm2YFL5iQiUMDDUcB+73iCOGM7iw/3svoHK6YhRsdbKpuQltpKCQCZgi+CErjcBDpw01vJEZrou0ANrwDQ7b1nQALCA1ymqLBrfb9gvRNZcuqiDfoSEnWIA6l2n/fN24HlttBV74F+8mmdHA8X6Gp8pYN+bUV2QUzoXCowtD2gLV+I8ct9ruTcnOtuwxu5B+c1iL9UB58ybZaKicgE9I4LLx45d7DzypgNr/zx4cQ9daMeHRdU2j4eeSDjf3Dsm6CVzK71WQNR1QYffO46TlM11lwYboP70g/Qor5+7asZNmsOOFWOybMqKIR+1uwVciEOKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gc127TZy6LzBlvfgRe0aRrGWbkprYIO+UsDyGu7ljw=;
 b=tgfzFaTSt1S6j63Z3DAgtXxBb6D3aghGnnICWCwwGu+wURUEajdaVCB3V35YhheS91/0d7FsUjLtJ/QCyOUqjxtukJPFZ2dKIESt4JL54jVUAc/lvWQSK8tenYF6MwZRD2afovas2Mf3SlvEeK7Wd7lZNUGoEXaqUkKptkO5FEwDJ5+E1eyKsuSiBKaC36lVhMKZ0xNhEHp50Zhcgvyh01YPBWzFtgqmMrv8mtVQbfq42HQOanf+2XMb0s+D4IIuMczbARLSoDgvrFTrF5xxxQEkQgMwYgXMmcBZgn0+7Xfoua+1Y8pjp6ry8BFB1N186A2gttXfbYOMVjd9wRAn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gc127TZy6LzBlvfgRe0aRrGWbkprYIO+UsDyGu7ljw=;
 b=RO1tSUXDufSrlmNsMxyJwsV82HGt1wWGjuZXu4JGmyV8pXZZWxPXnQqM9ekdKGjATfA7lghqcBaW+c4FhTKb2gxxIRvXi00WMgS20+wWCrHJeLP049QQvrKuTZqFD269gWtvj6F4dObUR0mBdLbyFhVXKm9hxrG65OB5ZmAeafKZwAw8LN/Yj4V3FzMda+f2MboYNonEJFZ7Sq6EM6pzx7PYiDn6ufCfXN/+LdEZS2seEa7dHeY3USeNCoei5RvnIR0Kc3Ky4f8X2SUJ45NRUI4gxsvxUkaVYgIQbxOtHgVfpTfu5DcQwv2EndpNk4BgVcc4VLvzlA4nYB6zg9WEKg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 04:15:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:15:59 +0000
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
Subject: Re: [PATCH v3 15/15] xfs: use blkdev_report_zones_cached()
Thread-Topic: [PATCH v3 15/15] xfs: use blkdev_report_zones_cached()
Thread-Index: AQHcTSt0r4OESdxxoUiLeeAb+ihxprTh6RoA
Date: Tue, 4 Nov 2025 04:15:59 +0000
Message-ID: <bbd13325-b965-4787-afd3-e1959a146f56@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-16-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-16-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB8449:EE_
x-ms-office365-filtering-correlation-id: 38dc450c-330f-4b35-31de-08de1b58dbd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTNvaVQ5UCtxUFRXVFQxZUtrMVptdlNOaFVnN3kyTzdGRk96c2VYYzQ3VjlY?=
 =?utf-8?B?L3lENmN3NmtyYWRQT3VhdXZkd3VSdnJnZkRub2tMUVA1ZDhyalRtR1ErbkpS?=
 =?utf-8?B?VG5hd0F6MTl6SmJRUzZiQUJGRVl4MTIvdkZBSFB6TDJDN3VNTUliS1pvL01v?=
 =?utf-8?B?ajlUVCtpMFRkaGdMSTZxUERyVTl6Y2JYRDMrdUlEclpsKzg2RnFXTVJaTEdX?=
 =?utf-8?B?enJOa29pQkRGTC9nSndObCtLWG9NL3czcmhrTXVPQ3k5bjg2dk5zdzBQaGNI?=
 =?utf-8?B?UlJ1WTlEQWhHeFc0SlJqWkRaY2x1a3Q0WGV3cFlsdGltREFsaEw2ODlpZnZ5?=
 =?utf-8?B?dDArZWFkMFRoSDlBNHNsZURwNzM0THcyais0SE9MSGFzREljdVkwZjVHK2dF?=
 =?utf-8?B?VzhCQlZmY0UwZFJCMHpTc2pWTGNzdmY4MU93Z21SYmkxZWxzcEFXdU5iZGhv?=
 =?utf-8?B?Z1V2azMwZVRETjkvVzVoQWhqdXdhTTlka3dZMTFvY095cGhQRHpnblBNUUt0?=
 =?utf-8?B?VVhadkF0MnZyWmMzTU4rRzdVMWxoU0N4ZE4xbkl1MkpZL3pMQkx1YjZoV2Fo?=
 =?utf-8?B?VHZZSUlFSTg3MlJCR1VZaEZCdG9vRzlUelJRZUt3b05UbWVvTGU0aXVHZTJE?=
 =?utf-8?B?OHNNdWxHeVVhSmk3ZC9PdXYrMWMya09xZWR4K0IweENwUlpnOEM1SU4weUhU?=
 =?utf-8?B?S2toQXFqWFUrTjE4Q05UVktFWEZ0WE5NVHk3UGtiMzMzYTQ3eGtWS2tSdEkr?=
 =?utf-8?B?TkJMS3BlTjJXd3hyZEVZbkR6TVZFQkxWdEhFZExGenBGME5xZnl2c0cwZE0x?=
 =?utf-8?B?WWlnK1FXQnIyUTNnamdhNUR5RmQzN0FRSEhRWnk1Q2ZuaVcyVVhtR3VwaWNq?=
 =?utf-8?B?SkJRYkRqUUVHbitFZCthOW05RVhrMEQzeVJqanNCYVBkUzZ6N2ZWR3dTS2xD?=
 =?utf-8?B?M0VlTFlSZGI2UTdLanBQUXpFdVlWdnVjSnJUaXk4WmcwcFhkYXM0d3pHRU9E?=
 =?utf-8?B?d3J3Qy82a1V1YmlsWVkrVk1XZ3dxb3MrN2ZBbjdVUW1QM3VrMWV6WTdkT1Jp?=
 =?utf-8?B?YUc4dUI3R2lnbWVoQi83RzZ5RHlFdFlOMFQ4K1Q2NGxRZEV4UjQvb3ZWUUN1?=
 =?utf-8?B?T0YvT1JwOXFlcy9tclAzdml3VTFVTER6U0Z4SklUSldkYUlWbmVYT3ZCUzd3?=
 =?utf-8?B?MnRBMUVvYzQxT2xzWUdNTkFiOEJkL0tpUlZEUXRKaHVZV3Jza3p4RWdLT01S?=
 =?utf-8?B?TXJMMlBna1ZVeUVuSE16ZnlZSVZJenRiUEx3QU50cmlxSmJ2QjkzNUgwb3F3?=
 =?utf-8?B?K25IUVhKQnVMcG1XSkJ5N0tnVGdFeWdpWXJWT295WW9xYkZYQ2o5LzRXdEtR?=
 =?utf-8?B?SWpNTDh1aXcrZS9haVNlTDlJc0EyOEZScmJxUERkbWhXMnVxRkVwU2pGeXhY?=
 =?utf-8?B?QWExMTNlNXhBZlR1U2Q5NVlmZlpPdUJnRWVBNEsvSERBaTVmdFkwa0ZRTnps?=
 =?utf-8?B?SkxaS2IzWVR6OVdIWDB5WGtkc3VqQ3VwakpaOGltUFdSN0hYTFhoOVRsSDJD?=
 =?utf-8?B?VDFnaDRId3BnNTd6S0hGY0hEZ3I2U08yRzVxMENpMXNRWUtUSllSOCt3YWZ0?=
 =?utf-8?B?OHN3ZGF2a2lvcE1UZUc5VzRWUkRDRnJvSGdNbnpuYm9sbmJDTFE2NG9BWi9n?=
 =?utf-8?B?bm5XejVFcEFiSjMzelkxSCtKM2wrR210M1l5a1N3dUtNeUE0ajVnb3VoblJ5?=
 =?utf-8?B?VW1oUFhWcXltR2FRVHNML3ZLa2hFeDhZcTVzc2ZpRndsb1liMnowbDBEdGVs?=
 =?utf-8?B?WDBrVGZiTG0vWXczN3VXeWc5NmNrTFpENlF6Zy9QT1dwWTZ0bGkyRkZSbFBX?=
 =?utf-8?B?UUpyQXY5S01zdFZOV2tvZnJKUXlrYUVYR2hjaTlHZzhGcFY4bkZQSnBmblJr?=
 =?utf-8?B?M0V5SUVuNjJMeStGb3lJcWU3STRkZmN3YnpwUGFac2JYKzNUZno4NTFnbWNP?=
 =?utf-8?B?YzgwNnVHUjl1ZlFIMVl5ckovS2hqSmFhMFR2RWsrZXJjeXdTL3VGN3VIUERp?=
 =?utf-8?B?R0lRRDNCTmZYMTAvRlJqYWJWNXNwdFMxVHUzQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlNmZDZMbGFZRkdld1F5cHBzRnpkbXhTdEcvVzdGc0JIeVJmUDdSa1I2dUpS?=
 =?utf-8?B?T3U1dU1OSXQ5TWZRVU92Qi9yMytFS0Z1TDQySHVZV0VUZmZubDlOdE50Y2pl?=
 =?utf-8?B?YXdNTUNXUXJraVgvRFIxMXFvNUpJMU14M05FVFg1NTZsMHZLekpYR1VrTmUx?=
 =?utf-8?B?b0FzRVNqSDQxd3pvdCs3OG82OUFXajJTdDVzaVdpMjVJV1BDanh0OVdBc08w?=
 =?utf-8?B?SkNzZVQ1NGxRWm1RVnJsWGZjTWxHTndMazUraFZNK1duTVEyWk5ML0UyYXZW?=
 =?utf-8?B?WmZlRzRLNDZoakZEQSsvV2M5bFFIeXcrRDJIT0xyV29FeUFpMnpPVnI3MjFE?=
 =?utf-8?B?b252VWkzT1ZnVGZyWktHYmhEZmxmZmtOSlg1M2p0cHR0ckY0MC94Uy9qTEh2?=
 =?utf-8?B?VDNCMUZGUXMzaWxmQllub2gzMEhSZTlzd1lqNUlQMTB1bFQ1aDVDYkY4TEky?=
 =?utf-8?B?ejYzNjVITVJ1ZzNoSkowQmRYUTVwaENzTWh5VUdOUThYS3c0Z2xzSmZyUmNs?=
 =?utf-8?B?VXJocTBiV1U5UktYSUJvemdwc0NyZUlyRFFZVFZoYVVHdWR2NVQrbmwyVk9B?=
 =?utf-8?B?THRjMW9OZzhaVlgwU3Y4MnpHQXNUZlFNc1NTRlRYRWRoTFVaZXczVk9TT1kv?=
 =?utf-8?B?aC9OWGpubUlEK3QraFN3ZjJPbWZxNEhNamRycWtzbTdPNWZIQ09leUhua01C?=
 =?utf-8?B?Q1BNNFZRc3NqMnhWUjNlY1VIRGZpTE1id0VRY3Q4U2lQVzcwbWEzcW9BZjN3?=
 =?utf-8?B?VnlMalFtU2RnUXZEUTNqMENMaDlXZklDT1lTTGMwYTFYdW14L0VkaVZkMC9X?=
 =?utf-8?B?cWJjbStFK3FtelFtNHQydVE2MVRmaTZ3YmpJZldNWlFxTEIreU44YmRhZ0RY?=
 =?utf-8?B?TEppUUNmUHhRcWJGLzJleGpUVnJubm9FSUVCb1ViZGp6cFdUMUgrSE1ETVI3?=
 =?utf-8?B?Y3M1S3gvbXZ3SC9UMW01Y0VDaFM5Q2NUdXBsWXpoZ1pIQWF6Sjg5OXFsQjRF?=
 =?utf-8?B?RGJubjM1NG5NMWt4L3V2ckFPVnBpb0Jrd05zNC9hWXkxNzluRDJLMUF1cFFo?=
 =?utf-8?B?TTB2QlVnU3lJNTBYNTJaL096NHp0aDFkeURoa1VjUkM3R3E4d1lvNVgrQ2Vz?=
 =?utf-8?B?cXBlQ1BjVGhCeUp5WmVvZGlPektkOW02WGpvcTQxVUZTUVNvdlB4VEJDVGhl?=
 =?utf-8?B?cm1UV2xmcVkzQ1l0bnlmcXdpVlpsN2J5OFd5Q05mMUN2bGNWQ05TS1lDSHc0?=
 =?utf-8?B?ZlpmYWdPZVh0OGZmNTZ4MjZtTHVIVmVRQ29zR0tkbHd5cllNTzk5UEVKYU1M?=
 =?utf-8?B?aVJxQU43RzVUaVg1NjZPMmNHZ1JWaE5LUDloM1NsRkF6ZHNJOWlaVWJtQzJV?=
 =?utf-8?B?bGJxcHFxUnVNWUhKcGxpRllEczVqMVRRVUthazYxdUxuZUg1VEF0NURTaFBH?=
 =?utf-8?B?R1NzaHFyMjd5RmVKVjNiNnVXelh2T1hJdlpicmtQekhqM3VxWkJKelUzM1Vv?=
 =?utf-8?B?R3hzMU1kMk1DaWJVSForZ29IczQ3MVI0dUxCZTlQa1BEUGZSUmVDQms2VzhU?=
 =?utf-8?B?RldWQWE2RFpqcDRlQ3VOQ2FiMWZUeDRBU1M3eS9XSkhhR29hbm83dGxTbFZy?=
 =?utf-8?B?ajBNakhaSUxZd0tmVkNqS01tNzY1V043K3RHR2QvNmY4U2czS1o5ZTB1NWlm?=
 =?utf-8?B?UHFCY1lyUDlVMzdDV0pLNE1JWktxbEVkUU4vcW9IV0NONUd1VVJqYmxzZVdX?=
 =?utf-8?B?VkV2Tnd3UXU1ZUlISEZqM0ZURHpOYUg0RUN1YjNhSk9MeXpmUHZ3OTd5RWUx?=
 =?utf-8?B?QVlYLy9MZU5zQ2wzK202MkdsVWFDbVNVQUgzTmlVNUxoY0NRcEl1TVMvM1ZP?=
 =?utf-8?B?SCt4OUJIeHNxZDVLNUdBZGgwaVB5Um9Md3RHeFpDaTBsYTErRXNucmxldUlr?=
 =?utf-8?B?WXgxeEdSZTJmUDAySFhUNjYwTXAwdk1JeUJWYVBRT2l5NTFtaC91TENPSTIr?=
 =?utf-8?B?YmRLcExiWGc1YmhXVVZoc0NjdW1yekFrbmhnMFdrRjBNZnJuRmZpN1J5Uk1Z?=
 =?utf-8?B?TGorUS9hMks5Z3VKR09wTG15VXZlenVhanhDSlBhcXpjeGhmWnlNQ0Qvb1BX?=
 =?utf-8?B?d05IWmJVUXVxN0ppNXMzeXhZQk5BTEg2bUNrMDE5UnVIdHNyT1NjdG80cXpE?=
 =?utf-8?Q?6IH3VZcQstf74mPXyRWGPYSldL2AcHF5xIl4ohLsS8PN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <009A5CBDDCA73241B9F2E378888541AD@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dc450c-330f-4b35-31de-08de1b58dbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:15:59.2413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hq5tgHvjYFXApouTi4eLCMFtWyMxMPaY2QuAK8t+OKOBLdw08YZRt1OTbfDbeIyHBt57boWGNnnsA0dFJYh/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE1vZGlmeSB4ZnNfbW91
bnRfem9uZXMoKSB0byByZXBsYWNlIHRoZSBjYWxsIHRvIGJsa2Rldl9yZXBvcnRfem9uZXMoKQ0K
PiB3aXRoIGJsa2Rldl9yZXBvcnRfem9uZXNfY2FjaGVkKCkgdG8gc3BlZWQtdXAgbW91bnQgb3Bl
cmF0aW9ucy4NCj4NCj4gV2l0aCB0aGlzIGNoYW5nZSwgbW91bnRpbmcgYSBmcmVzaGx5IGZvcm1h
dHRlZCBsYXJnZSBjYXBhY2l0eSAoMzAgVEIpDQo+IFNNUiBIREQgY29tcGxldGVzIHVuZGVyIDJz
IGNvbXBhcmVkIHRvIG92ZXIgNC43cyBiZWZvcmUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbWll
biBMZSBNb2FsPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBI
ZWxsd2lnPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9o
YW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

