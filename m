Return-Path: <linux-btrfs+bounces-6278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B063D929B88
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 07:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655E228139E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 05:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1D110A3D;
	Mon,  8 Jul 2024 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hwK+PsYT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="J+1avfL8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381698BF3;
	Mon,  8 Jul 2024 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720416352; cv=fail; b=M/37wPQvZiwSIINOaRgtxBerdXVqBRPrsKTvoOLQQ/BPHNSgodJc3CMLM46pcCgHjOYMTXJPqV5d3SFpEDuNARyzQhgMt8j71Tjid53yENdGDkF1HNGwNi0dXMQYz99bCAhNB6sd9p6yhLu5g23EpOcQH4gFE48uorE7gukMmp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720416352; c=relaxed/simple;
	bh=av/SSFmLOwHxPPHl9QTfN/v9ThmKniMAKaUzMuCwlDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rsZwMtE+66LxBsi2K6htMrcHVRY/vRtt7niGKKUVaDkq+ea5+r9Uy8fsyKA4NVLesaDqoi36q75zxJUzdocWjGVQci8zWV14oyOe33TtqnzfRcSbuA1dGzdEdQX6IUTpTkT40XNHop0JDjoRIo0sCZqjYg/ikt4EaXB4yWyC55g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hwK+PsYT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=J+1avfL8; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720416350; x=1751952350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=av/SSFmLOwHxPPHl9QTfN/v9ThmKniMAKaUzMuCwlDI=;
  b=hwK+PsYTdrFtbHAQKGc0jJdCm/Iv0sajlSJQl7XhGvuMJXbNMR/y74WR
   JxBZA7gkMhHnGs6w75JejVfSX9VEjF8hetgJPHMeYtKAn12PgpI3NMmsI
   rJ8ATxhN9zaKYVaZlYxgheCt/gw1AviyIr/hPiaGsane3j6eW+4eDBdf3
   KDPjddTgc2wu3u6ovt0iT+DDn/+hftGAWHmC8XRycq6o5xMfZqTFZmsU9
   3OdIJs370AlEEN4W60qxALVFRdaTdMUjSIR0KUulxTI+TA3j2tw03z4UD
   I8XbstOZPvteQo3fmdJToHzrO0GtFcUMRujq0rcaTwIN8sLYwFwmqBJa+
   g==;
X-CSE-ConnectionGUID: b/pUdboTS5e9dq4xoVlJyg==
X-CSE-MsgGUID: uhEWvC9RRt6MCc4z92qsuw==
X-IronPort-AV: E=Sophos;i="6.09,191,1716220800"; 
   d="scan'208";a="20303802"
Received: from mail-bn7nam10lp2044.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.44])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2024 13:25:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSv2Zfld9c5SJQzEymFXkNYiD90rlxocJMNauWW075MlP2eI/A5TGr9V7srsuI3RzPCL1bJQ/YcgWlfLvcuZVaKiJ+X+dvhNP4foJxTiB9zgthLvYdD//3NtiFxD7fgMZu0pZxXnxzk3MLaazxfRYT09+Ixr8gF4nWUb+l6ZRPMceUMwRqDoq1Yl31zcK13NmzMVj0JOhSc/gr1E3czYdGE+32M9QTbPfM3xATR25CnEG9p8NZy6z8hfVEJe6E/JwzmVrEleyUxF+r3R9WRZYC2MtifenJkUJPqSd65SWfTHA8kpdRk0SirJecVBGGYO79UrpcvyEsq89f2f+bxq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av/SSFmLOwHxPPHl9QTfN/v9ThmKniMAKaUzMuCwlDI=;
 b=Z490+t1aGszmrxW72baf6tkRwQl1+PyI/5jzdCNfFAj2Ot+UjisaDbuWSuqqWO/kO0TmUVh+O1yyXYjXpDXsZcqUDD4fT61ITP87aAB8yooa6vdKPkEvznQ+EUPeCXW6fqeCq1/jFo+6KHjSFVPnpdJq434ZjVwNG6IFGuqH8TrYAa4ZhgM2bWUBv3SNqDBd83MG0t+Z4SXMu4zUVb2j03tpZqi5CNuyQOPTEvYvEwRgfNEwdYgSWnsvysFZU7IZM3ZsS/JR3IRntXj9VWsXLDtIQiPVK9kDtBUBrMkTyiSzC5rHq60eRQs8J/Hh1ZsZ8IiDrUSMyYoxoHP10ZI2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av/SSFmLOwHxPPHl9QTfN/v9ThmKniMAKaUzMuCwlDI=;
 b=J+1avfL8zSB8QGPkgpiVrMbfNVJ+BmPFIPTjZ8RQnFqcOn3hcFynsLnEYhScrMAh4w9w24sPbyiPpyMCrzUd6goQ9tiOFQRuCPL949+bc8UB684BzKbUCnLB+tr/KNltxp8HYBoYAUhsi34fOQGwykP0SPKmKKQuG/adWobrb38=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7936.namprd04.prod.outlook.com (2603:10b6:408:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 05:25:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 05:25:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Thread-Topic: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Thread-Index: AQHazu35+gWM7QXR/kW5py9pDxK19rHox7kAgAOA7YCAAAZ7gIAAAY0A
Date: Mon, 8 Jul 2024 05:25:40 +0000
Message-ID: <d0c28a38-23d4-44f3-9438-e374be1c33d0@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
 <e0041c2d-f888-41cb-adb8-52c82ca0d03f@gmx.com>
 <e3927e86-d85e-4003-9ce5-e9e88741afa3@wdc.com>
 <ecd368a8-2582-4d23-a89d-549abb8c4902@gmx.com>
In-Reply-To: <ecd368a8-2582-4d23-a89d-549abb8c4902@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB7936:EE_
x-ms-office365-filtering-correlation-id: 3862defc-7be0-497c-77cc-08dc9f0e6802
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2s5U2I5eVJaR0pEVjNaRmY4eDNxK3FpMUZmQVBaeE5IV3FKTDNnYWZna2h2?=
 =?utf-8?B?MEVtdTd2OFFzamEzeVVEL3RSdGxXaHBmYk1SYnE3RGFkUkp2NFdXdkdMc3dy?=
 =?utf-8?B?NmlrYUdINDRjelRrWEVSaFc2VUpVZ21pUjFvT1pjaFA4KzEvbXFwUnRJWXFv?=
 =?utf-8?B?YVEzcVg1UkZvT3Q2Q3h4QWx6L1crdkFRWlExbHRpUWxRVDVaRFRlbUFJT2p0?=
 =?utf-8?B?Qm55RWpXUm1DK0duVXF5SEF5SWNqZW9ZS1NhVDI3SFR2bmU3bmhOdno0bUZk?=
 =?utf-8?B?eFU5UFhmYy9vRCszR3JyTVhCbXpuSVg0QndDeDgzT052TnBlaTRFSkQvdXBT?=
 =?utf-8?B?VE82bHYrMVIrQXFqaVFleDBhVU9FUXgrTk1lYkQ1bWtOZ1V6NzlJVnhJenVF?=
 =?utf-8?B?V1FVZ1BWTmxMd2NaYlM4Q25xUUxKTkJLZXFVZ3k2RmpxSU5uNE9ycXpZTlk5?=
 =?utf-8?B?aEVCWFVIRnBOcEVEeFFqYVYrQlYwL2tjS3oxQ3BPem5JNnBIQVlMWnNUQ2xu?=
 =?utf-8?B?V3NiY1h4d29YbFJHdlFBN1g4bUFEN3ZCZ1doNGtJbWdRNWtUd0hrb0NLOThU?=
 =?utf-8?B?ZVVkYTlhRnZ2bmo5K0tnVFRNQm1VMmFYSDBYbS9BYnBUcCtsamU4aUFTM1Y1?=
 =?utf-8?B?TlVlVmRVQlRvTWFBbVVsblpKUS9FajhBQUlhNUlQbHdoQkVWL0pSemZZdCtz?=
 =?utf-8?B?eEFhWC9ISW16SU1oZGRBTUlQTjQwU21mUTlrTS9rZTBJaFF0VU81dnhJdkh2?=
 =?utf-8?B?bUxZZVhDQmVoeTV5SWVHVWNscFpjTkpIeFFsQnRXTVNUanJhWGt6ZU1nWUx5?=
 =?utf-8?B?MkZsYnpuM2dibjIxblRqdCtsYXhPY2NIcFp1c0NTVDliaTBFUDF6Yzdmbkwr?=
 =?utf-8?B?YmFmQmlwVFFmS0dkYnRjckNaSURGNDFvNzZlMFN5dm9uQVlUWWVyUExVbFZx?=
 =?utf-8?B?emU0SXBCNGVNbGUrYXI1eGEzTVgwRkszZSttMnJrbjZOWUE5OWdqUDh5ZFVu?=
 =?utf-8?B?Z0xFeDl5S0wrZ3RCRHlodGJqQjE0cnBsSGRoWDkrbGNraXAzVDdyckNmVGpL?=
 =?utf-8?B?MEdGUy9mM2hHempXK1ZVSENBMW1UT2NvdnBET0psZDVlQ0JhVUxiTy9BcDcr?=
 =?utf-8?B?Mm43b1psQXc0dXZVYkg5Wm5FQ0lkd3pDcWxpVUtLNy9LVGpPMnJSRDlWYlpr?=
 =?utf-8?B?VWtFVmVXV1p3c0RGcUNqcEs0MnBFanhPMlZuakg0Y01YQ01aZCtxVXZXalk0?=
 =?utf-8?B?V28veG9PckdzTktramtrKzdZVXcwZjBzK1JtSWZtK2NyckNqKzJXV0lUUG50?=
 =?utf-8?B?TmVlbVpWNVgrWWZUYkRReGZNamJIMkdWeWU5NVhScy9xMGhXOWF5QUhucmdm?=
 =?utf-8?B?eThUVG9wLzhSdk5yZENIZVExWm1BVHhTelNhVHJTQjBQSFFQWGpGK2dkYndH?=
 =?utf-8?B?MFNObTBuaGY5VWRSRjFZWUwxTytWcWRQZDZHSGhLK0tYYloxU0FKeW9xMEJQ?=
 =?utf-8?B?R1ZobC9NVXpjbFVSSVlZa1c3UndBbXg5MWM1NHI2VElRRjB1c0lCRUFNSSsz?=
 =?utf-8?B?T0lKT3VUc0tZMTlJRDZkdHBBWGkzenZ4R0ZjY3NZbEJIYzhBdTNwZjhFaEUr?=
 =?utf-8?B?ZXI1ckEvY21iU09sazkrL0tHYlpiNWM0SldpUHFaWGpBTEF3R1lWdGR2WGlV?=
 =?utf-8?B?VmdTTVJKVUZ5cVJ6OTlBYkF3dEdia290WkZWaU4zak4yV29QeVdpSzJ2aGhj?=
 =?utf-8?B?enBBUzhBUXVRb0RkQnA2dnJUWFk2QnJUNlpySUdTbG5zZ3ZBQXNGR1JRS0Vh?=
 =?utf-8?B?MjdRS1pacys4cStHTHBvenpieEd5VEg5VkZyTlgvWFlNbit0bzNnM3Y0MkUy?=
 =?utf-8?B?c3ZTVCtBc056d0gzR0FmQW1PTzFZV1ZtdkJVU0RRQlUzQ0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTRZYWVUR3ByTURhZGJxSXA0MThqbGxDYjNGK0UvWGZUcmlDN1NMdStwbjF2?=
 =?utf-8?B?V0c0ZUJsand0WkVOWVlxdFh5T0NCVUx2NGZZSGMveEVVSllYMVRsejNUUXhE?=
 =?utf-8?B?MEpBd2lVR3dqTTJtTlFKTDVndXpzaXBLYi9VRjZWck9uZXJRVDV6Q0R2UzN4?=
 =?utf-8?B?ekRRR1hwMHlkUW1SVUswVTIxL2M4VkFucXBSaFBNOFJWczF1bmZocXNRclRU?=
 =?utf-8?B?YkxSa3J1eFlML2pUaGdpMk5BcUdQR0pYbG1pSEZRb2VTV2ZLUVJTZXVGZjBR?=
 =?utf-8?B?cjkrdmQ1ZkhHcXI5SVdPNHpwczBwbGlFejlNVWVjZjBNc3JuVXUrS25HeUox?=
 =?utf-8?B?YzhHeUJvOU1VcFY4bmFTdWVPbTZCcnIxamFWaThLandndGlkN3ZuKzQ2U1A5?=
 =?utf-8?B?MFR5Ynl4RzVkRUM2czdFZWxNRzJBM0drclhwRjRUZnIxbE5ZcFVYZE5yeEpG?=
 =?utf-8?B?ZDNDakw5ekpyYkpObTZJRGkvOTg4MDJpY3BZZmJwdmdnS05nZ2E1M05USGdy?=
 =?utf-8?B?alNuRnU4dUVjZnZ3WGxSODhrajZaazUyRXp5RDhidk1IMExQdDZyd05OOUFj?=
 =?utf-8?B?QkhNSlBxY1RPNWhza1VPV2NjMHE5U3BLR2QveUVodmRHMkcxbUErdktmWjZa?=
 =?utf-8?B?RVFJdTZUTERCZm8waTN6NW1CTlphejBCM1psTkZiV0tCRndDU3IwaEh1ZEpr?=
 =?utf-8?B?S1FnaXNDZmNNN25FbHRrcmJTcXN1WnU1dHlNUVBHTDBYQVF5SzhOTFB5U25i?=
 =?utf-8?B?QXAvMW1ZQjV6cXdCR0tCVCs3TUVkWXJvTHoyWUJZZFVkdVhSdURqVmJMQXEz?=
 =?utf-8?B?d2toSS8rcXZFUGYzYUZTNjdxU055Qno2RU14dlZ5TmlEbFlrVDZqeG05ckQ5?=
 =?utf-8?B?WnpNditNM0UzOGZRLzROdDFua0ZSV1JZZ0huN0xQVExJQ2MzaW8xV1dtSHRM?=
 =?utf-8?B?Vi9WSkhxTjR6UWpLc1p5YUsxbzUvYUdTdWtPbFRmWFBiRFpzekhrdVgxZWUv?=
 =?utf-8?B?VDN1bng4ZThnaEZWelVuRGtZU0RXN202UGVDekk5Mlh0alFwQVpZMTFDYStn?=
 =?utf-8?B?NmNkZFJ5bjNxRGtrSFdzaVZnY01GRE5pTGk2WnMwUE5uOTBFbFk1K0d3MkFK?=
 =?utf-8?B?WWh6c2F2RlkwMnpYWGExVmtTT2FDeDQzd25JM3cxY0Q1dHNRUnFGcm9QU3ow?=
 =?utf-8?B?d2t1NDR3Ym5ydHpoeS9SUGlLQ0NwOFMwa0pwbFNZQU9yY3lHK0l2c28zNHpW?=
 =?utf-8?B?d2NiMHZsclRyR0ZRWitudmpPQWFmR2RrR2Q5aUFxb3RVSE0rVDJnd0xGUEYr?=
 =?utf-8?B?S1BtMVFRWE1ZQzN2SFc1K1Y4UWdHOUtZa1ZRaEIrbC9WalBKSmVNL29EMzQz?=
 =?utf-8?B?bnJrZnVVWU8rbXN4UlRSLzlGd3NsNG02ZXk4MHZNQlRTUTBQYll3MmtRVUNM?=
 =?utf-8?B?UDgrVmExUWRPcmhHbjNweHdrU0pqV29qT2YyOE0ybnppYndtL3NBMjdxTFpq?=
 =?utf-8?B?SlQ0NzlVOXA3NkMxSjdYNXc4UVlDTExLdCtiZHhrbTNRaVJ0cGNIVGtwMHkx?=
 =?utf-8?B?akxGWmt3Y3hMczJWbm1UTG5Sc0FMUndIbTBrNUhMZ3FtWkNmNXN5T1lEOGhy?=
 =?utf-8?B?RjlzMkxWbU41cjRGMHRYdDhqbUZ4L282YlRKQS9HTzJGUW9UbWZBd2tZejF6?=
 =?utf-8?B?MGJmQnM3emFWbEhFbXRkVEZXNmIrUnNRTmhreFI5NkNLUS84Q3NsNlBBUzM4?=
 =?utf-8?B?MU9lUmFFT2R4VUNpcytNeTBIQzBaaUgyNUxWOXd4bDZma1pmTWtjTFJDTVJ1?=
 =?utf-8?B?dlg3M1F2c1l6YlBpTjNNUTJhTTB6a1NnZFVKUjdMWHpmNkFKZnBkblRxZzlX?=
 =?utf-8?B?RmtFblNDTmF4ejBnd0dwVktNeklCZ1FhdnM4bzlERnVPTDNNTnBCTlM1cHY0?=
 =?utf-8?B?MCtSSGxGUGhCcytuVTVpcHdMeFl5MmkxZDJzWURhcjBneVBOSU4xSHpUZHhQ?=
 =?utf-8?B?MVMrb1FPNTM5K2d6M3VHOEgrTEczVmF0cCttaU9JbXNqbWNsOWNwc3RxVDRq?=
 =?utf-8?B?VmpJMWk3OGVHbC9FMXNVV3Y4MzdoZ3NHSEo3QklGajA2Qnk1aWJTaXkrN2tH?=
 =?utf-8?B?UnBLbE1vMEFWZVZnOCs0dXpaeWs3RW11bFFxcUVXeTl6b1dMaXZzRG1EWVZX?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B9112EC83C9FA4990FCA85650E1D748@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tvyu9W1Rt5PoVy5VibKlkcqdlX9hR6w8QzsSq37iop8v4sttYI3ayv5KAlN2x4usOSz/vLDQPxL3Hrb8IQ03Ozw/sEljWkM5wzod5NRzd1rbZPKVfB0VSFP/119wukKjF1fBeIi4i0IGspu71rHzoWrJ+muVGPXuqdBEoVzl0h8wPAt5BxdoyuTiqF65XiLsB3mFAIT2uNt6Yf0SmRQdg/5ziNuTk3gBgT7BmsJ1ia4Cb7xanuP1Uk87LfE3jlUryoEQGrICzqydro+397TA7D8pcV8RGSRmbSnUQHSEx2L+PwFhgMG5Rm4kl7MkivFjorfJjaTGpWtkvr021PZYsClkk1HdX+gzRoy/roxLJ02iFlK4Av7Ff80yHdzCgdjdnY5U1rLWhXBtwYAsEVktN/C55+OaYNodg+EeKg3Hb7NypRS64HOfdwlRC09fjdI/Uop0ZosUiFyYmud4u11bwqPuw6xX2fbryValsQ3aQuaq+9Cwd7SPMS7ztIlSFjrkXJiHP3NBFKkcQoVygVj3Oqo8q22xhNb+I1BYj3XN8SFFgv5zBCsEiP074I/1s3F4dCBl0HEkOxHQ9sFGw9GURJ52knfE95fcCRWbKoRT2DZeiRnSNj1edrkYsWW9AuTY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3862defc-7be0-497c-77cc-08dc9f0e6802
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 05:25:40.2641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbjSE3yMAW2/JI7UIBzJS09nAMvusU4coH00++GIfRH18ipXzm4TRPPX3A6znUKZHjT4R6fBtechPEHOhRkiMcP8KR2MPtX+oBoKFNAFymQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7936

T24gMDguMDcuMjQgMDc6MjAsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IENhbiB0aGUgQVNTRVJU
KCkgYmUgcmVwcm9kdWNlZCB3aXRob3V0IGEgem9uZWQgZGV2aWNlPyAoSSdtIHJlYWxseSBub3Qg
YQ0KPiBmYW4gb2YgdGhlIGV4aXN0aW5nIHRjbXUgZW11bGF0ZWQgc29sdXRpb24sIG1lYW53aGls
ZSBsaWJ2aXJ0IHN0aWxsDQo+IGRvZXNuJ3Qgc3VwcG9ydCBaTlMgZGV2aWNlcykNCj4gDQo+IElm
IGl0IGNhbiBiZSByZXByb2R1Y2VkIGp1c3Qgd2l0aCBSU1QgZmVhdHVyZSwgSSBtYXkgcHJvdmlk
ZSBzb21lIGhlbHANCj4gZGlnZ2luZyBpbnRvIHRoZSBBU1NFUlQoKS4NCg0KTGV0IG1lIGNoZWNr
LiBJdCdzIHZlcnkgc3BvcmFkaWMgYXMgd2VsbCB1bmZvcnR1bmF0ZWx5Lg0KDQo=

