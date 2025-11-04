Return-Path: <linux-btrfs+bounces-18628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA42C2F401
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AC3189CA5C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40F1D7E5C;
	Tue,  4 Nov 2025 04:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F3boLj86"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEDE27990C;
	Tue,  4 Nov 2025 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229162; cv=fail; b=ZORHnhVf/RCaxzjMJPzZT4DxOkeIGOINT9irhboBFCiy2baymvuwtSfAlZzaprQL+tdQvs3lFtYfFi7MeSRC18ht0BnDTIL//IvjakpViLyB2ghn+UmrisKpShyKikFTlFKVhYonVjWd7HzPgChW6QZfjIWdTQje21v6IkcKz6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229162; c=relaxed/simple;
	bh=V+2q2uqYLY5OXX1PyXpIHAZANANVwkUQXP/cdo9HQpQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0CMXN3UDPvwXviH7QEjAPyoJ7jPpFE6W6z6gLfVEnEHxqVIihsEh1cCBvAAY4RsKoqd03wUHQFx/CM1mknOtFfH9ibYkQxkHiWkPm/rGVDcJrP4PhEXV6GdHiY4ek4M0KKyAn9TF9a4vv1LOCVYMiIQ6eYbR2BDsmMffRu27Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F3boLj86; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQUFIztxhThu1e9bK5p2kA+9VsN5ggyT3jub7ey408+g11+FTcpJoTD2EgvSPPCPrlfkDTXm1E+kZHH+p9kB5IuQzVf+OLFPbOmpYYmEwgJIVdVfe/D7DhAQXNc2McDnI+aPlDFfy3tcpZB2FJI3YgWRNcMaYuFkP5U4muvEsBsl8x74ocTSZAFL34PpB0ZrCcCjBesFAPiTXyHHXRjMtDuhpHQkslR2K2J21yEZpa8xOTjSMh5saRnYcmTjn4fbO+8B3zHk2Hq/uh1UHHbITUgBkm9mqEuZwJp/q+iu989d3XVcJiJNFob4IZejokOARgAYLNQ0p+zzW9/v3xp7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+2q2uqYLY5OXX1PyXpIHAZANANVwkUQXP/cdo9HQpQ=;
 b=hfptLeaOYVw+b20vxwQfOlVrlZs9+gnYQkV6+9tDNYKWhroyE0tdIdfuQ2FcIyuz6N9keXl54+Q5NUbL5hdABFj6ZoQasrJ1z8/KaG71mYEqwmhAB4OcFLS9i3iCtJRjOorHZuAzPwhC88AvMIddwTJweSdrP3HB1Mvrcxt7SNwtdOdMRvGfsVwcl3suNqZYTX6AXC3pnpShR2QQ/th86/qv1UDPqRC749mx4g6mDzQNsJUhcbfWdJBXw6vWCrLvXxSSoxeVmTPEDQDyI2+HaUbcBXOYIBTx2uVLI9hUTiS97eQMLXtC+3zSbyx4ZfYIBlM0YTizDHXfrnPn+v1fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+2q2uqYLY5OXX1PyXpIHAZANANVwkUQXP/cdo9HQpQ=;
 b=F3boLj86KCHWE61vxy2wd9C4WdwMKeYnWQ3Gu9kv3yxfnFXxIUy/mmXCUqKqf5xkpNqcyhHVo1aX637jtvJjouZEHs2EDwcMAoZGsojc8lV9p0cPbuNhXbOiHMYaSJk6PlJ+Z2LTQsA4SXvlwL65Yhfncs8re3Ez/PoC3/Yfg7v2gWW1gOFGSvw6mTgNrSUwrv7lLdSR9zr+70qzE+PORxqbeIa25AbH8WBkmGl/a9LuxyP0tJVoBfRGDq+TuuwC3QJq635cD/w5bnZNMwwyMwtugHkRiX4tB9y9ugq5zXuTe+kr/8hWfb4TO+5RHPco5EtSV3lvRnVM65hSg0foZg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:05:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:05:58 +0000
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
Subject: Re: [PATCH v3 06/15] block: use zone condition to determine
 conventional zones
Thread-Topic: [PATCH v3 06/15] block: use zone condition to determine
 conventional zones
Thread-Index: AQHcTStlB5Tn0FFcD0CWetXHwGgRUrTh5k6A
Date: Tue, 4 Nov 2025 04:05:57 +0000
Message-ID: <7bcfce9c-a2bf-4b8b-8a56-e0f518d87170@nvidia.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-7-dlemoal@kernel.org>
In-Reply-To: <20251104013147.913802-7-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: cb95383f-fe35-4bf1-cb95-08de1b57754d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUdzSzkybU5aNXlUMnNUUVFiSlhwMTY4QUt2MmYydUpCTi8rYzZIaEw0ekp0?=
 =?utf-8?B?ekkrUXhaMTJhbTQzVXBlMHRMRlZrM0FibU9YRVl0emplayt1OCtZSWtnUHll?=
 =?utf-8?B?N0p6Ung4dERpSmpaWmJxZTI4WEdGcVAzSjJnbXlNWUVzRmlJOFR0UWtoRjFL?=
 =?utf-8?B?dEhNV1oxSE1aSVpqYTQvQ21kSGhqeUo4OSt0SmJZZ002Y0FkWGMxTUJaUGZK?=
 =?utf-8?B?SW84eUlDU1A3T3huVFZiZW83bDlWZ0I0YWNYaDd5dm9za2tYby9XQ05HdWhH?=
 =?utf-8?B?Q3FjUnppZ1Q5OGxQam1MUXQ4ZTlDalpSb3RRL0k0OFpJMnZyZkczSytnWC9q?=
 =?utf-8?B?Nit5Q1I5OTVRNkU0YjZOUWlpQnhMaE5QY2c0TCtmMXJyTVEwRDRscExZU0Ja?=
 =?utf-8?B?aGpKZHBHWC9qUUxyemRVaTdBMWhaL0kvTlFhUEZZcXUrczdnRWlXV0hGcjdI?=
 =?utf-8?B?eW9IeEg4dHljTFBjUkNSQllBOFFnMG5TUzJGeGFPWk02QTVYdmJGSk03Z1Bq?=
 =?utf-8?B?WFVRVndwV3NyUjBjMFZTMHJRZXpNZ2Fyck0vbUo1VW5tcWg2a2dQbnk0RWhY?=
 =?utf-8?B?elBNd2ozTEg3SnRsUG4vV24ra1MyaDdURkRFQlBld1RYZWFwNjJWUjVLL3gr?=
 =?utf-8?B?SzFBR3k0VVhrZTZ1ZTY1QkJaQ0QwWTE4dzBrcnVPSGFFKzcrS2lIV2NROS9q?=
 =?utf-8?B?QlZIcjJYcloxWXdrQytYN3FoTVNnU1FyUGpXK3dhU0FDcUJZSUhtdHdVNVJ6?=
 =?utf-8?B?Nlh2dmVoYVBlam1TZ1gyTUN3QXN4NmZNVXdtcmVYa0ZWd1VvMHZaTGhDN3Zw?=
 =?utf-8?B?azFpQ0U5c2NCcEdkOG9GTkdCYmZsRlA1UnpFdUdGaVppSW9sWnVaRDlVN1Vh?=
 =?utf-8?B?d1FlNFdLaHd0cXM2ejlBY25hdTZIVjRlc2E3VDFHeHNqcFRRQjVDcUQwekZ5?=
 =?utf-8?B?bjFBbGszeE1OWkZwdWt6eGRhNHd3MHpzMyt3eU9PT2x2VkxqVGxhaGIxMFZk?=
 =?utf-8?B?VTdibVc0bXNVUDVEY05XVUxScXVBd3huWEtZY3JjR25naG1aZnFCWnhKR2ht?=
 =?utf-8?B?U05UVWNUMzRPOHRWRElNa1VHb2VVMlZGMk10d1BvWHpKMXZjUEtqbUhac3NF?=
 =?utf-8?B?R2xHREs3UXpNeFpvY3hrNXpUbkFVS3pIQ21lRjJTVkwzRUVsYm9QcStjREZ5?=
 =?utf-8?B?ZkNpUE0yaC9OWXZkeUpzRGJ1N0lKLzgwUkxTcmRqd1Y0QkR5WWFCVUJzcldE?=
 =?utf-8?B?RUo0WG1VdkJIenZObEdtNFd1T3hXaHcwZmJ0bGlPK0dGNzREZ0xqcWx3ZnE0?=
 =?utf-8?B?Mkc1N1dpZFlQU2JRYjJJYzYyRXFlcElST2V0bWZFZ1QwOVBMN1REWjdMVU9z?=
 =?utf-8?B?K3R0ZzhIU2JDYnNaQkJUbXdLN0NFK1JSZ04rZmxNVE03TmlDaFRsYzlFckdJ?=
 =?utf-8?B?dFJmcmtNNkp0dG9VWnNIUUdUa09NdGVmRmo4NGhyZzE1cjJSbGRXcGs0Y1l3?=
 =?utf-8?B?QVo1NUdVRi9pUU03RUVNYldFeFMxemJZL3llZEtpMy81eWhJMGhZb1hCM1VW?=
 =?utf-8?B?N1JkZytzR081bnZ3Tk9LRE9vR3FQdGYyUE5NNG5Qemt3dzdxeUc2ZzgzZmts?=
 =?utf-8?B?UEtGdGVLQ3JyOGc3RzE1L3dRL09KeHdzNkdZTWhhM21Pc0tCeW9kQ29HUU4r?=
 =?utf-8?B?d1dPb1pWdHc1eXQxMG1CUHAwTXNTSUxJMG1jUHlxbFBXOUFQZ1VLVWt0S0Mw?=
 =?utf-8?B?MmpJZnVLNENIY01PSkhtdWVmZ0t4dTFINHJ2NkFtK0NJbjFROFpCKzkyMlNX?=
 =?utf-8?B?bWJpTFp6VzRXSmhHOEQ2MDNrQTF2YW14TUF5Yjh4ZGRzbzN4ZlN4dVI4alZS?=
 =?utf-8?B?YmZNVDFQdEpGck05b01JMDg0MXhWbWVsbTdoVDJZdVZmaWRQVTBSQ1VMYlhY?=
 =?utf-8?B?UURkQk0ySmpENjFMd2FLaFdhbld0MGVsKzhKenlhclpSZEMvN3ZwWGV6ek5K?=
 =?utf-8?B?MkdpaHlxL2hXYUhEeTZENnk4OVdCWFV3N1U4MUtHT0JOOHcvOXUvbXVKQnBJ?=
 =?utf-8?B?RlhiSFpLM1B3RW0vOFB5K1pZWVBoVGc3alVHUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3RJWGZKTXNXQjhZOXNkVFl6cHdkWjhldmo3WkNGa1pJOWlXOHIya1QwWmxz?=
 =?utf-8?B?cGxBTEVmR1NPUXo4OFh5TUFYMktNakZvS1BSN04vQ1JlTkJ2dkUydnR1Ulp2?=
 =?utf-8?B?YUxlYlAwUjZQVFI2OVRFTnhraHZIb1BVWVVldDRsNnhVS21DaUFWRUE1Mmt1?=
 =?utf-8?B?WG94YW9lMkdHdXAvWi9Mazd4K0QySTQ1cUtIRWVzUUtvNnAzN3FKMCszR1Z3?=
 =?utf-8?B?cTRNMzBCNmx3WmZMQ2Q3b3lUZUxiV0VoWjVyRWprNjdqaFdIYXg3dk5PbHMw?=
 =?utf-8?B?azZSM2R6TUlKbkt3a1BKQ3VZckJ2L2g1cTltakk4djkzcjVwdFVSWEMzV0di?=
 =?utf-8?B?NHp5M3lTckcwalhISUM5b1N5cmcvcVdmdjd1MjhheTBGdWJHVVJpeU01M0tp?=
 =?utf-8?B?alJZUS9KUmR6R0cweS81QTdNMWxVbHJaaGZNdVBwQXZSUHREVjRMMFIzUTZI?=
 =?utf-8?B?eU9GUXV1Wks5T1V0Yk1uVUhhQkJaR2lMQTlOTlFINXNOQXNTMFpjeDJiUWhx?=
 =?utf-8?B?SkNlTEcvd2hBbnc2VG9CNEhsRm9vMytqb0M3MkNSOU0xbXNWZHRuZTk1Nmlj?=
 =?utf-8?B?Vk9EVEthQUd1S2FGR3duSkNneWZFcFc2TXhaNzBDVXlYdVdwVjJTbDY0bFZ6?=
 =?utf-8?B?MEZuOTJocW1BcGU0YjZFTEFKd2JxQ3o5RTVGRHQrc0J2bTB2cHIxbFFKOFJz?=
 =?utf-8?B?cFVIYk1TL3NsUkM1ZkJwNGlEaGhyU0NLUHFjdHk0bGFKdHdXOHY2ZGpVeGIw?=
 =?utf-8?B?dStvNmFxeUFwNnVTd2R6bS9KZzVjai9XRnBmemc0aXRzZVFOcS85ejhrZGFy?=
 =?utf-8?B?c1VVcHIzcEk5MnFkUFRKbkgvdkZaOVQvNzdCWEptUW1kSjZ1MWFTSEhOOW1R?=
 =?utf-8?B?bGgrRW9rQjRrUlhVWktCQ3gweklvZWVITVFyeE5VUEg1ZWl3MmZ6YWNCc1Ru?=
 =?utf-8?B?RTBlbUF5OHpaYTdFTHFNZjJ4SXkyK1VkY21PNjlYUnB4Z0IxclJyOFBCTzd0?=
 =?utf-8?B?Z0ZSL3RmcGtlV3NzKzRndmZiMm01L0cyMnN1Tk9TdUVWUm5CbEh2aUliay9n?=
 =?utf-8?B?dW44QjVGS1Z0MW1qVHY0bmF0NkZ6U1lkM1I1NkQ5Z2IzbnA2S1hDVm0zYjA4?=
 =?utf-8?B?dkhBQldlSjRZM0JKOEVCSy9tZGlxMU9lN0lSRUNZZ1lwK1FQazEvZUdFMVc2?=
 =?utf-8?B?bHh0c3cxcGVraFBBQzdMdk1IQ20wWGpSRUMweXBpN3A3OUY1TzI5cXNla1R4?=
 =?utf-8?B?QlJObjRKYjB0VzNWYTc1SitXZ1FuQ1hVMlBxdUhqbXhTanZIdmVrSVYxSHUz?=
 =?utf-8?B?eUhwL0pCY2dabnZ6NzZMWS9EblFpY3krbzhtck93NlE0ZjBuOXdueHFPRWk2?=
 =?utf-8?B?ajhXK3o0YjZNSHZnVmZxcjZZenpDSlZEcVNPdThMWlk2bnZVNnJycU9GT2I0?=
 =?utf-8?B?aXlVa0FCUDhzTW4wQnl0Ni9FVDBIbkIvNzZ0Z09PbHk3bU05SWNaTTJYTXFT?=
 =?utf-8?B?MVdNV1ZIMHNySlExcERWTUU1dWZSdE5SUnpVT3BPZkJsemFXQXd0REJDQmww?=
 =?utf-8?B?SEtKMUVnRm8yRXpkS1FvYmw2U3NrRFFteFgrZGl4dmNDMXZpQzVBekJzRU1X?=
 =?utf-8?B?ZVVrUlpUbUxGbTF4MEhkSmQvYVJDeU9WcTA2TVAzTklydXY5amhnMHhqQjBO?=
 =?utf-8?B?NlY5aVRVM3J3K00yOWcrQmMxNnNVdDdjMXM4MitYelNCbjZCWEd6YVZ5elZL?=
 =?utf-8?B?ZUF2a2tEZFJJSnBrdzA5WThmc1hlMEVKMmNpVGsrYzF0U252Nnl0dlBRMzVo?=
 =?utf-8?B?bjVIZG4wOW1uamdxdGJ0TE5WcVVzc2ZTMExnUnV6aFlCYUo2THJjaElHSElH?=
 =?utf-8?B?NldWUmkwMlNSSE55bjcyQzY3VWgzQ2JGVEpBMmliZXkrKzArUnVSQXhHMzF0?=
 =?utf-8?B?akdkOUNvcEpoREhrRlpvcHB3SFRZamdSM0hJNTNlbi84akVhQ1E4Q1JpZ0xj?=
 =?utf-8?B?Qlo3QXIyWTNjajVWRDMzN2lncDRFcTZKQ0IyZVBVTGlZQUdFdzlrOW4vTEVw?=
 =?utf-8?B?RlAvdXBQei9pdzd5bGhoMUs1T3R0cVZtS2o2UnQwNVBlVm12VEFzS3RwQ2Vu?=
 =?utf-8?B?YVNFVXRBV05NOFNOS2VHYUtISG9STTJlenF5eEtLa2pNakxGdGVQSDZvNmhm?=
 =?utf-8?Q?uDLxIxNNI6CXo0f1/BoWXnMsrk004YC/nPKGADnP+b6q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <963F4494D02E0548A9379775343BA8E0@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95383f-fe35-4bf1-cb95-08de1b57754d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:05:57.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fh7qYiZeKr/mwvatTiOOFPzSlyZ1Y6xYMeg4znKAfICfIFC6L03us29/a34IaRJfIXGk7qABN5jHnx1mUP6sbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

T24gMTEvMy8yNSAxNzozMSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFRoZSBjb252X3pvbmVz
X2JpdG1hcCBmaWVsZCBvZiBzdHJ1Y3QgZ2VuZGlzayBpcyB1c2VkIHRvIGRlZmluZSBhIGJpdG1h
cA0KPiB0byBpZGVudGlmeSB0aGUgY29udmVudGlvbmFsIHpvbmVzIG9mIGEgem9uZWQgYmxvY2sg
ZGV2aWNlLiBUaGUgYml0IGZvcg0KPiBhIHpvbmUgaXMgc2V0IGluIHRoaXMgYml0bWFwIGlmIHRo
ZSB6b25lIGlzIGEgY29udmVudGlvbmFsIG9uZSwgdGhhdCBpcywNCj4gaWYgdGhlIHpvbmUgdHlw
ZSBpcyBCTEtfWk9ORV9UWVBFX0NPTlZFTlRJT05BTC4gRm9yIHN1Y2ggem9uZSwgdGhpcw0KPiBh
bHdheXMgY29ycmVzcG9uZHMgdG8gdGhlIHpvbmUgY29uZGl0aW9uIEJMS19aT05FX0NPTkRfTk9U
X1dQLg0KPiBJbiBvdGhlciB3b3JkcywgY29udl96b25lc19iaXRtYXAgdHJhY2tzIGEgc2luZ2xl
IGNvbmRpdGlvbiBvZiB0aGUNCj4gem9uZXMgb2YgYSB6b25lZCBibG9jayBkZXZpY2UuDQo+DQo+
IEluIHByZXBhcmF0aW9uIGZvciB0cmFja2luZyBtb3JlIHpvbmUgY29uZGl0aW9ucywgY2hhbmdl
DQo+IGNvbnZfem9uZXNfYml0bWFwIGludG8gYW4gYXJyYXkgb2Ygem9uZSBjb25kaXRpb25zLCB1
c2luZyAxIGJ5dGUgcGVyDQo+IHpvbmUuIFRoaXMgaW5jcmVhc2VzIHRoZSBtZW1vcnkgdXNhZ2Ug
ZnJvbSAxIGJpdCBwZXIgem9uZSB0byAxIGJ5dGUgcGVyDQo+IHpvbmUsIHRoYXQgaXMsIGZyb20g
MTYgS2lCIHRvIGFib3V0IDEwMCBLaUIgZm9yIGEgMzAgVEIgU01SIEhERCB3aXRoIDI1Ng0KPiBN
aUIgem9uZXMuIFRoaXMgaXMgYSB0cmFkZS1vZmYgdG8gYWxsb3cgZmFzdCBjYWNoZWQgcmVwb3J0
IHpvbmVzIGxhdGVyDQo+IG9uIHRvcCBvZiB0aGlzIGNoYW5nZS4NCj4NCj4gUmVuYW1lIHRoZSBj
b252X3pvbmVzX2JpdG1hcCBmaWVsZCBvZiBzdHJ1Y3QgZ2VuZGlzayB0byB6b25lc19jb25kLiBB
ZGQNCj4gYSBibGtfcmV2YWxpZGF0ZV96b25lX2NvbmQoKSBmdW5jdGlvbiB0byBpbml0aWFsaXpl
IHRoZSB6b25lc19jb25kIGFycmF5DQo+IG9mIGEgZGlzayBkdXJpbmcgZGV2aWNlIHNjYW4gYW5k
IHRvIHVwZGF0ZSBpdCBvbiBkZXZpY2UgcmV2YWxpZGF0aW9uLg0KPiBNb3ZlIHRoZSBhbGxvY2F0
aW9uIG9mIHRoZSB6b25lc19jb25kIGFycmF5IHRvDQo+IGRpc2tfcmV2YWxpZGF0ZV96b25lX3Jl
c291cmNlcygpLCBtYWtpbmcgc3VyZSB0aGF0IHRoaXMgYXJyYXkgaXMgYWx3YXlzDQo+IGFsbG9j
YXRlZCwgZXZlbiBmb3IgZGV2aWNlcyB0aGF0IGRvIG5vdCBuZWVkIHpvbmUgd3JpdGUgcGx1Z3Mg
KHpvbmUNCj4gcmVzb3VyY2VzKSwgdG8gZW5zdXJlIHRoYXQgYmRldl96b25lX2lzX3NlcSgpIGNh
biBiZSByZS1pbXBsZW1lbnRlZCB0bw0KPiB1c2UgdGhlIHpvbmUgY29uZGl0aW9uIGFycmF5IGlu
IHBsYWNlIG9mIHRoZSBjb252IHpvbmVzIGJpdG1hcC4NCj4NCj4gRmluYWxseSwgdGhlIGZ1bmN0
aW9uIGJkZXZfem9uZV9pc19zZXEoKSBpcyByZXdyaXR0ZW4gdG8gdXNlIGEgdGVzdCBvbg0KPiB0
aGUgY29uZGl0aW9uIG9mIHRoZSB0YXJnZXQgem9uZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFt
aWVuIExlIE1vYWw8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3Bo
IEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybjxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

