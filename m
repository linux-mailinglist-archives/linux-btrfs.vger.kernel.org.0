Return-Path: <linux-btrfs+bounces-18569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FC4C2C4B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA6A3A9E4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01E304972;
	Mon,  3 Nov 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YNKa6Ygo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pRFPPgEm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E42737E1;
	Mon,  3 Nov 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177991; cv=fail; b=I7Qr+h+656p6EZFkhu68daox1N2Ry9Y+jB+D25qHJvBV9HgD13K/seGcfj9ysr0kS006mettTkJae7k2srQ6XU24KmVTYZl3s2dGGDoMNH78LUENF9oMek1jtugSt/4ZCI7fd0E03BoxyjucADD5yj2Q6W3EWV3BcWJ5SaGWkDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177991; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GKedgvUfXrLiHBTxDUB01SdbmpMfjMn9W/M/SMd/I1wwdZ97hCrf0ILTpkfO6e1x6i3ZJb0OnbavDIDVEmmVNd5hehsA2O+JNYb+gNTlJuXxFYYoJ2DfM3oWhXzN7o/SSvzM9rqUnfgtdAhzYAdu6JsVRrjK1Wo1y+AakItdc+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YNKa6Ygo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pRFPPgEm; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762177989; x=1793713989;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=YNKa6YgozigMI5ubqSBa09Zitgrv1xerp8N4LaFUC2IhyHaZPU0O1mBz
   XpKJ5kWCZP3IOjorfNvJiyGW1ob2bZkKRRgFMFmqsiEFW1+c6DRTLHKk3
   rmiHwqqDgpD8tOdEXsGKpc01ljKsGkG7zdle4IfMmznj4u+b9on/Ze52h
   XwhbDszBjVeoQZhOu0QTC15nN4Fd4CFFN1XOU1hfxqLtm/sXJEQ458Lyh
   R25NM1V/MDGMUssI+1LjycRofEtuQsjDYawln2HubFS7AjSppCd1BITlP
   +iDV+yyc0LEEjisIhBcj2uRmarZMgBDcLNQmlI3ShgJ0Tbj23VqxNTvDw
   A==;
X-CSE-ConnectionGUID: qRbVdCi1T+Gmv6PODYD6ow==
X-CSE-MsgGUID: T5n2YEjxTOqPbnezikGAoQ==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="134409600"
Received: from mail-centralusazon11010022.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.22])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 21:53:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=donu08AXBoPav+m5YkLsXQTmiCtJApHPo966ymHkH7fRlLr5TbZt61pQUVaZJ4COraAAzUKooeHXCg1jCc+kU+XE9xO1C0oDyW09MVnLAd00Y0Lmm2A3jkpL81NepFaYK122ai8sWAKcLXJu4hErcGTAx1kFe6GyG+hFNru/HVOlhS8Qq1KChXbYg42MJ57qQIMnlXv04CdXS01e+swrXUN9UHiGJSOgL3OkrKVUDamiqoR0czbaF4hDX+DMhbREXKp5PRCan6vbzpHa9Ed94JjHNPgj3F7e952sL0cGp1DxQJU9cbmZIcqZNIZQKcCxdK/tG4CbaObEq0h0j4Sqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Q453M1TpM+JUALZ/LlaLeXYk+BvpVTEI6WqxYKJu8tro8bMRsXzwZXTSh4O7WxG/XQIDMq5KYpmcW/y1N14rpY7Y8NThc0Ky4IGY0rxpFi1CFKUyrnaHGLdCQCSuuGoInXMGDC5dHxGM0i6W6x972IXwsCXZ+V4RFOsTi/CbZKTg8jp05U5r+gvcRyyJ8Kffa3sfTnYYwiH7OUdlwfma9uFVlj4bFs487+9w2gu4KfXSc2UQSQrnAXmMIMylcCsAUDTKmSSM8PKl2z+1yIvMm+nfTHcZfWmOGC4X1zOkwfnr3djVhNmXgIBrhaD7OAvOgdlV7WmDcVj/dtWCzvSzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=pRFPPgEmwIlbtOVsa8SUuVWaWLVjh1lngUMjI/HNRRh2jDfGxtR+577PBIP0dRiCRdZmOSLBW/1bcjAB5Cab8x7r2LYVpOWXQPvKhlf3r8S9UgEnxl6p4M2PwOhuMV6usnPALjg9wWHy/DYjKMkIustcrW4cdrQFP61y6PS8OD4=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7773.namprd04.prod.outlook.com (2603:10b6:a03:302::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:53:05 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 13:53:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v2 01/15] block: handle zone management operations
 completions
Thread-Topic: [PATCH v2 01/15] block: handle zone management operations
 completions
Thread-Index: AQHcTMbBcOuU+286BUiOL5gYcoKvV7Tg+MwA
Date: Mon, 3 Nov 2025 13:53:05 +0000
Message-ID: <79b32fa1-cfc5-4c17-b722-fdf57f8d9cca@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-2-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-2-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7773:EE_
x-ms-office365-filtering-correlation-id: d6a27cb5-78c0-4e66-2201-08de1ae05012
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?enlpcjhoTnB1NWR2RlFNV2tHNDVxbTNMNlZtSisyOG5DL3hwUFJVMzdkdTBL?=
 =?utf-8?B?WTlMZTFNbmhPWFhnOEJZRkVybzk4aG1vZmx5bm1LNEl6dytOZWhvUG1GcUcx?=
 =?utf-8?B?MFNZR0VVYjYyU1dhSHQ4V21jbExLY250blpJUkprbzBOZ2FCYnN4TGpGN1Rl?=
 =?utf-8?B?STdRT01pU0lCLzFyUkR4OXozVkF5RUhkalMxY0xqZjJQZlloTmo5SVRHc2dC?=
 =?utf-8?B?S1BmRzlxbFowMHFmV1NMSmFTREJGK2V0VE00UVg2aWZocFIxR29xanIxZW1j?=
 =?utf-8?B?bU8vMGxHUVkvUFRkWkJZMEkwamYzeitUWEJjSEdWeU9zYW4zTGNnZHFoZ0xG?=
 =?utf-8?B?MEdmU2Mwb3hJUmJiU2NJRTJZU3NPWU1yL2NUSWxrK0hEWFhjcDBaOExDT2FR?=
 =?utf-8?B?UWo2L0pHb3BWejdvUk1wNHh4aWN4VVphMGl0bkNISTFjS0tqek4rZndFREto?=
 =?utf-8?B?YTIremVqVk4ySXZwTjlRUGM5QmJjTGZCbFhUNmpHUmV3aVBOcGxLMmJaVjFq?=
 =?utf-8?B?dVR2VG9EUHVGYXNwb2pnNnFNV0ZxRTNrNTNraGRZYmdQUmhQVE1sWWpwaGhH?=
 =?utf-8?B?RkhQTExvc2pHWjdOOU51ZkQ3VUlJdDFaQmJUWFFqZTUxS0thMGFXSys2YWNz?=
 =?utf-8?B?Vm1HMG1kRTNxT08xRHZqNlBDNCtoWS9MVmlJR2doejF4b3RuK0R6ZGhkLzlZ?=
 =?utf-8?B?UTdWL1lwUmpGcUVkVGlQcXR0YVFRdzltWkI2UDFvSW1VVXlodmxzdWlGSW9x?=
 =?utf-8?B?WTkrK1FKV1RrQnhpVHRJclZXTFhzdkRLaVhKMUFiSWJZaWFiU2krUkY5aFk3?=
 =?utf-8?B?V2ttYnNSc0JCOVlrMG02VzIyeG1lVDZlaG9iT1lacW8yOUgyUHRTTTdyS2VE?=
 =?utf-8?B?c3gyYmM5ekw5dmVpOHZCU2hJTFpwaWdZeHM4bzRrN2NFam1veVc2ak1NZE9C?=
 =?utf-8?B?UXBCTlFPREdIMGhTc3Z6ak1EWGE4eS9tOHNZdmllK3RXbFljMklvK3J3Q1Nr?=
 =?utf-8?B?MWkrUzQ5UzNnOWNiVzhPWUFrUzhvWkhUSWc5RmgxTi9Yc0ZMMUNFVzRyTmVl?=
 =?utf-8?B?MFZFSlFuTGR1ODBtOW96NkhsWWN1WFRxWTdlcnhuQzQ5QS9OV3BDRndBTlEy?=
 =?utf-8?B?MFU5R3JTN3RWQWdXZVlNSU4rbEZRSkQ0eGViZitlTGkyZThBdmowVFFydEEw?=
 =?utf-8?B?aC83V2VvM3UzdnhpNExHbWxqcmxKRC9FajZueGxESUs2RTFvYVpsdTJKclRx?=
 =?utf-8?B?ZXFMaFpQZC9ZNkhZNDBlclUybk1VSDdMLzc1bnRReFJyQnhIUHpEdklBY3VP?=
 =?utf-8?B?YjhHUEkrSEhhWEkvY2xuVFlORmhtc1RJZ2xBZHZVSkkwc1Bnb29jNEhSYXRw?=
 =?utf-8?B?dkhnWm5lUVE4VjVzK20vcGczaWlqTi80V2V0SzY4V0JpdXBscGVDOEFDNHpU?=
 =?utf-8?B?OXJhQk9UMHpGcHE1bFJrajVFbUw4V2Q2c2lXSGpLTnlJZjVHbVF3aDdBemND?=
 =?utf-8?B?Z3hYSFBRWFU5NDdUZzZBbThxNXhZbjhHQzZFZHc1enl1eHhWcXc1SGlVREp4?=
 =?utf-8?B?U01iN0RmZmp2KzdYcDU5bzVrRXVEQzhYb251NytmNnFySHJRRGtDNHkrYlV6?=
 =?utf-8?B?NjVDL1NDMEdldCtBVE5lQndGaFhWTTlvdlBjVVVjQmNUVWRYaXlBWnFEdS9P?=
 =?utf-8?B?QlQ0TVgyVnRCVVYxSWpvcUxQWTFmOUs5VFZjam1MaVUvbktDRy9IaE9NOUFJ?=
 =?utf-8?B?QndDWVphR0Z3aXRQcXFFSWczVzdCTFRhUDY5TERZdmVKTWxSWXdMcHpjRXR1?=
 =?utf-8?B?NnhxM0VCczhxcXF5SHVmMUhMN0Z3bGUvdXFWMUY3MzVacndWMXVRNk1lOW53?=
 =?utf-8?B?b0Z4K1E2WFdWMlNialFrZVoyOXZObzUzQUtDM1ppbVBmRmVxa3FVdk0rMDdj?=
 =?utf-8?B?NjVLN3ExTW04RS8zWnlpWTNwbitYdnlGZWtabDYxN0lraG1xUmd1ZytwcENi?=
 =?utf-8?B?cXh1RHRXR056dHhZUzlkM05iZGhkK1JxbnA0QnBNaEU2WnhFT011R1VWT1BW?=
 =?utf-8?B?Z3FVUEJpSm5OekVscC9NazF4SVc0dUF0YjZXUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDFYRnllcWlaL0kyeTZXM2IxWkVWQUhRTU1XSXV2RjRMY3NvODJBKzZzMHBV?=
 =?utf-8?B?VzNQaFd5czFSNkN5YzhpOFh6d2pZZEsvMkNvbVdTK2UvbGl1ZlFDSGVlUWly?=
 =?utf-8?B?NmVuUStpeFNZb044Y1dHMlFUUGVPcWp2WlpsOFdOKzRnNXoyOUkrQ1NSR3Nm?=
 =?utf-8?B?YUVXRXhLWGZpOWRnV2ppeTlFVktuUHV1SWNjTkpkdTBlMGJWQ2Q4Vmw0aStK?=
 =?utf-8?B?WHNpNngzRjhmSytyWWR5aXdEYzgvLzN6bVpjZUlQR3JNYWN3aUx5SXU0cGxs?=
 =?utf-8?B?RDFyTk1LaHFScCtGNGt0RUlybVNQdWVQd2l5Q25NenRoZlo5U3d0czhNVEU4?=
 =?utf-8?B?RWVUNUIyQTVNV0tYdXExYktNNWNJamJ6RDJGYWM5SjVUSFROb1BrMm1IRytR?=
 =?utf-8?B?eFIycHdFcGVlaHJWNy9TMEt4anlPOUxJT1lMeUxPbDlTMHV5dml0VTZSSCtm?=
 =?utf-8?B?eHBtb1daRkVWbm9YekhoREhlcVlFWVZuSC9sWTZDRVYrSjl6VWNTSzJqVWhy?=
 =?utf-8?B?a2xURXIyNE5hR1Z2M0NWYldUNVpRVFFvYXlLbXJSTnlqdC83TjNFT1gxL0hC?=
 =?utf-8?B?WEE0TTZMN2tCZTdMVDZnK0RxcFg5b2VaSEZLMWlqUjM0R0ZwdldlRDhSTDll?=
 =?utf-8?B?SWNCM1BCTHc5d1JXRlV4cUoyZGoyOXdBdS8ycGg3dzVmcHFIZHhvdnhZWGdw?=
 =?utf-8?B?b0hIMW40UmJTdGFEYTROdmh3M0gxcG1PM1lFYTc5dExwM3BqUmZuaVRhRU5L?=
 =?utf-8?B?UFY5cDg2Q2tYK0lrektGbUxKTjZldFhVenVrQXBIbUEwYlczdm40Q3E2MDJL?=
 =?utf-8?B?NmJGSTVrajNSTm1yVllvZEtqZlhXUzhxQjgwTllxam1WUjNuYUpHWjdsNUE0?=
 =?utf-8?B?Rmk0RFI0MmtucFFVajBhS1BaN09CY21FV01ZYldjVG81WnltcXEwMUNjN2pW?=
 =?utf-8?B?UlJQdzRvTVFPUHFDc1BnRnBFT2l0MEVIeldjR0RxcVYwb0w5SFJuRU5lcXhs?=
 =?utf-8?B?STVJb3VPdVdndnFMN29VQkdkaWhRL0FCWkhtZFRSQkE0emJpSlkrSHlpb1U4?=
 =?utf-8?B?WU4zNHdOZklkT3pXZHlFejZTTDVCa3VHYUNVcjhCalN6VXRvbTBDZTlvSXFC?=
 =?utf-8?B?QUw2c3V6S3pYQXd6ZmpzNEJNQVhNN3l3UDBYaEVBVWt0dWVxOHljVC9HQjV6?=
 =?utf-8?B?VXg1czcrUVJDWS96V3UxbXZybWQzM1FoV242Vy9NSVJFVVpDT25heW56bGc3?=
 =?utf-8?B?T09ySlFnaThQcytBKzk5TlhNRzI5R2tycjl4MGRNNHk5OEI2dzF0MEprN1d2?=
 =?utf-8?B?S1VrNGJtYzhNRHRmbGY5eHhzbVZXY1c4aStTdk05THJxRVhJMzY2NlJMbWdw?=
 =?utf-8?B?dWlBcVhJa2t4amtjenYrcG5GYytrMEc2Uk8xeVUxRDg0ckNYc2tBVlRQbDBn?=
 =?utf-8?B?cGVmMHVnMVo3NkQ2djg4SEgxV25HSnlqbDlvTm9SeFhrKzU4TzNjWU9XeEg3?=
 =?utf-8?B?U1RwV21YMzI1djVxVVMxTDFpRG9CTWVKSXRPNFllVUhOUWh3d08yZUx6TG54?=
 =?utf-8?B?NkcxYTVRVHRWdWo0V21KOFpLVTdnRXg5RTVIR09KaE0rcVVmSlBHeGpRYkw5?=
 =?utf-8?B?VjJEMnU1L284c1N3Vlp6bVVDTEZudGNSb2lTNFJUcHJRSUcrZllmbHZNbVpZ?=
 =?utf-8?B?V05PdnIzY2tKWk1iMHhET2ZKNXBUZDM4QVc3Wk8zZytTa2FkUWJ4a0ZFeVA1?=
 =?utf-8?B?MDdQdzVOb2o4WXRCTTN2MTAvZWJDdzdCWUFDRldOV1BrOUtGeHhKVVhad01F?=
 =?utf-8?B?ZGp6aWVUc25ReWJHR1RnS0FxYlRBa3UzeXpkK2VSTXA2WkxMZ1V1TytEMUlv?=
 =?utf-8?B?bE1ST3pKTDNEcjI3bDZ1Mk1KWFZZcmpremdkRnR3eEkyZXN2Ui9ld0d0MkxV?=
 =?utf-8?B?Z3lhOFhFTEZxK0g3RVVLSHRpdzZPQkZBalhPOGpsUk5SK1k2dXYwOHJkNlA5?=
 =?utf-8?B?SlcyWlBtL1M1eFJuc1R5NGZKUXcrRlJIUDQ0eEpudUpmZlZnakRuc1UyQjMr?=
 =?utf-8?B?Qjc2bFNscGdZZWtEaUZDbFNiMHFSQ1MrVGxQQ0cxeTZQclJRVVhDUElsNVBt?=
 =?utf-8?B?NWJ0dEVnSEpqV0tMSGc0dHVGMHNzNGNwRWR5STN5S0RNdUVMVGwwRnBrYzVW?=
 =?utf-8?B?emtsQ3doOFJ2UFVhTWhaUEVyL3Z3VWJsL0ZZSlU4dTdwTmF4YzljczF2a3hX?=
 =?utf-8?B?MGJYUEVyT3RQK0YxNlFVUXA0QzJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE870D055E5B13468ADA28C1E1548F7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	97SUYQYcQucipvqKxSyOffhLu9JOWeFg/jMVt2oo64qdhUXCeGei2NdhKSsfiLlJoyAjlCXaPsmQ9KkZcWQOxulPnUFXtpPIZkXIP8cI9iOTfBiaPB5u960WcBEVGHaSZFjTI6QU5GVTJBiARL2+KYsYSRmQWRR9w3azqhZ27Vs315BpHCWBB+D8AWdDICylhSIuZkXd3t7A0MU+yk/rPlcyD6CKTP13+PR2pNH1aX46x14UA+OpwK5U7l9Alr73bKWyExfw70HgDaGarXPt1urY/qaqZR2brwABrt9C5fb+rJXmtF4SilyNbYX0zIm9Xz7EtNHglH+QWzcYcNLff7edk5D49tLl+lerWtDW2PNZBQ5J7R3pSJgvsqAxToesTee3K/alUCIXsIL+iCq2F5k3yTHN5IVq3L6sr8DKZs9ITJHkVUFh2bJFsDHxCZ5eiQBZm2DP2pzkftjHZejxKOj1TX/tEBA9PNqUQJ+neQ+7ES1PA7132OsdohVCWmLwypTwnkhzflLEjiWhn0f4zsyFTZpmbEEb9Omg/l1mcHAxif3kHGWbqEUIjfl7R5Lr1bKckSon1VRrBHZBzDVH6sa4FDVI7PHjZRCvWar3fHo/XP9BSHW8Tr65jLQh+t2p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a27cb5-78c0-4e66-2201-08de1ae05012
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 13:53:05.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuLyZmP7lT7w0vndFEtmZ3xTvCkjt32Ed/stbs86Ax90dkoctG4/vQAA4YVQUPl/j+SjAesSmoWyN0m4XgHZTG9eDek3RzkDYhcS1ofJrfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7773

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

