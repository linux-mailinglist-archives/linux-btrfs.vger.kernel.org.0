Return-Path: <linux-btrfs+bounces-15539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A749BB08D9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DCA7BA94A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21F2D4B62;
	Thu, 17 Jul 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lhsycb6q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VRlHOKnd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0062D3219
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756924; cv=fail; b=iO57QgCeSgstCh0yjXb1pz9PXkrGwyl43wuho1RcW69bUrRkYtGjbO2BOvjS3ucKn4AIgHTaqjNzlz3EWSyqNZ9FzMR1ur1V7Zw/11q0gVz2e8say5uoGqFQsRMQu3vxRwv1/493K9HUA0sbSFSGpaqFPki4TGTnWJa/3Zuao/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756924; c=relaxed/simple;
	bh=qP/fiFiHJfC4QLiclpgP6WfeJMN/Ubn0uFPVpkkv1nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hnEPFPOVACv0qym3xg1lKpThFuCMJCXmzVm7xGkPWyDs21mwMPBRRfNbqB2DJvQTDPrlyRuwwJiZJ+Dt7EX07iG3nCcno7YcXRtOCjK529k49APkdTKoEvTvtJAI2M7QLuRqBp2q7e8FKwe65L81Q5Z1mFNA6uexRfURxxQIMY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Lhsycb6q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VRlHOKnd; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752756922; x=1784292922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qP/fiFiHJfC4QLiclpgP6WfeJMN/Ubn0uFPVpkkv1nU=;
  b=Lhsycb6qmTOPaJriYvvVg7k/eWAkIedbjrWAlsmcJt1rug3TBumnps23
   azZ91e01UIm/iCbFRq7zQI4kRz6lB/ypT/PWF4HVmtuck2AMo6OQ+w2EZ
   lWlawyssQcQ9Y5C/ynWOIWj1x9fqRNr8bTpyenam02VTe+B6sg620UOqD
   h1w7mYWfnThr20q2IVNxWNAFfrb1hrMouncuH/L6rADn6guruPbKx1izL
   0OGDDpF7S4D4uYYrowPmC+AopU1aYZEhy0OANEhB8YKNsN6jiEoHd8OHR
   Q0v/sIw/xAgP94S2ZY1VqIk2aBeEkBQK3J48L1wI+wj7nP65H/vc3k8r4
   w==;
X-CSE-ConnectionGUID: Q5gSQTwqQ/eAjj7Ppc701w==
X-CSE-MsgGUID: p3ZQwQIcRhaZ2RK2j86tWQ==
X-IronPort-AV: E=Sophos;i="6.16,318,1744041600"; 
   d="scan'208";a="89768485"
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.84])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2025 20:55:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQnDef6PILukLqLVQe7QAb+K375xblaMeXDWeyE9kuHTOKsyXbac0J8CHHgBIJgRcaGq+x0vMBngJy10/xBMmcGkZYv37cBwdwKfBm6aTomw3xyUZk/hd/2BHY2QX7dM5ZFL2nLZXtvBScOLlqB7Yi/W11H5jHO44TyHcF+On3iX/kyGEa2PfLRxUZsgREn5311FKCSfJCJ9LCfqgCeFKYLOlF+ftxy4L44lU7eDyhMaYp9gRdvK4HjtwHv52P4EQk93Uvwf2/XMfYK+dptc9jZKItpLIpDbAnx0bbTDErk1y0wpVjCwsMGCHqfF/viSFJvDcCTq8GzFeJI30e8S9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP/fiFiHJfC4QLiclpgP6WfeJMN/Ubn0uFPVpkkv1nU=;
 b=qkUfWaa94+e7ngs5dm48pFYe5FfZNzzaLHPpIhUlLXyV6qVCaCyBECQR8bP6YJEoILB/8+Gcnotx7witkO3lP/QD0/4akXSQ/k4LksF3kzSsDb8ybDjacn469ard5s2PLfRv7s6uJ5MFMYrqO9cZSEFbNX6B89lfoeCI9G0y09Ph+MqPWFimWYOtzXm4ud8lKz4PdoBub4Lb/2oiqd/A8P6irxr567cwklWJ8oZyIhlYWQ6AkKx3cmAEej6XtPOLzTf1QuX2yp5ml3TVNk/wmnI85wZga6xPn5Taq9sIVmqJRhaf+5qV2FiD46xaC8u96ku1W/1789VGQfup2hvMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP/fiFiHJfC4QLiclpgP6WfeJMN/Ubn0uFPVpkkv1nU=;
 b=VRlHOKndGX1lX4g8Khc7WckjrGw21V/XW+sTC5leHu4cbq6UoNAA6skCTV66CEG3DKQrW2yKFBcaForOix+4a0gKwq5J/KwyhRK5oGANSRo8g09WjRaWrWW0wa9HOtb6Fv0ClFsqn4961AtcZC4tCfPvq7b5KVsCQDhIayMYf6g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9271.namprd04.prod.outlook.com (2603:10b6:806:41d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Thu, 17 Jul
 2025 12:55:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:55:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Boris Burkov <boris@bur.io>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, hch <hch@lst.de>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Thread-Topic: [PATCH] btrfs: make periodic dynamic reclaim the default for
 data
Thread-Index: AQHb9bpLu5WQm2ct3Uq7fB9svGCtrLQ0SQCAgACf+gCAAV+hgA==
Date: Thu, 17 Jul 2025 12:55:11 +0000
Message-ID: <051be284-6fe7-4982-a834-e46ce9c124a9@wdc.com>
References:
 <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
 <df3f4610-cd32-4897-8172-5fe8b6a9b281@wdc.com>
 <20250716155640.GA2275999@zen.localdomain>
In-Reply-To: <20250716155640.GA2275999@zen.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9271:EE_
x-ms-office365-filtering-correlation-id: 44394c9b-203b-44ab-eaa4-08ddc5312ab9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjhyR3R6RS9xbWxCaUhoMGVmNFZyT3Ryei9mS2t2a1FCeUpLT3l2RGEzQ2po?=
 =?utf-8?B?bUZNa3hNc3RabFRJUUxlTzdBTmZVcFBOb0xkaHd3b0pNUy9DblpiOGVCbW9u?=
 =?utf-8?B?SjFBcGJtOHZ5OXJURFNxNTF1eUw2Yit6akJQc3ZBMmc0VmUvQzlNeG5UYlpz?=
 =?utf-8?B?M1paK0ZoNTNqejljYVMzaHBmUDdSSWFpNTFGblNaUlowNDVWTU1Md29QcXMy?=
 =?utf-8?B?TytJdlUxbWZ2bjZNdGNJZnlHM0d5L2dhYms5WGlHL1NhYmFYUGRaQXlTY1Nr?=
 =?utf-8?B?cS9oQVJQVkNlRUZpNzVkM3JvdkMvOC9qci94eFVBRzhSNDVTblJpaStETlZa?=
 =?utf-8?B?eXFqejVlVEt3QVdYalRQeW0rUjBocEIwbkhpYm9oYkpYek8rUzhrNW9FZ2Jr?=
 =?utf-8?B?MTlqcDVFQXg5dmNBZTNRUHpaM013ZjA3eFp4TVFmNWkwcUl0MThkMnRhMThM?=
 =?utf-8?B?Yk9jQkJ1YnhQc0o4TDM3eUcyMkswTXl3c1RrY250UFFYY1ZFWDlZZkxoMW5w?=
 =?utf-8?B?UFFFSFZVOUprVDdCbEJ6RnBsME5Qamp5K2VmeUlOcXJMK012KzMrQWtXei9K?=
 =?utf-8?B?M3R0bUl5Q1ZKbHMvK3JiQ21iTjBzLzIveW9Ca1YvSGNqcU5nMWU5MGVUdVpS?=
 =?utf-8?B?Q1l2aWlORTBMYlpNQ3FjVkRqVUNNQ2lkM3JyV1RUUmY2dVc2SzdPMjNKeVZH?=
 =?utf-8?B?ekIwMTA1NEMvMm9MeXl0QVhjaWl4MFFVQmFyTnB0c1RUMGdMZDBTbjBPajVD?=
 =?utf-8?B?ekZ0Qm94Ky9rblRSKzU2czhTQjZBVjFILzI2MXQ1dEFTYmRHdXJqQUtqdjFQ?=
 =?utf-8?B?YnlZd01SUVpoRW9BT1VaamQ4Q0QxR1ppb3ZkUXpySUw1UTJqQmpaSXFucElq?=
 =?utf-8?B?NDROa29xNGxWUlE2dHpHanlXYmxvMXJ3TmE3SDYyNVBrWEFMdjhVaG1QZ3NM?=
 =?utf-8?B?VjliS2JENkdFazE5dW8vV1QxdkhOWDBJVmRQVzZrSVE5TXhiV0lPUW5hSktp?=
 =?utf-8?B?bThMblEySTJGd3V6V0IyeDhPRktTREdJS290akVKVXg2aTZpSVdOYXdieWVX?=
 =?utf-8?B?cnE2NGNYUE9aTTVTQWp5NEl4YXRMeHRqdUVET1NqTDRvSXdLc3d5MWEyeVE4?=
 =?utf-8?B?enRsZnZPbGVJa2dpcCs5NlVNaE9ISDk3ay9wSXM5bmdnWjdUQVBOMnNTZkcv?=
 =?utf-8?B?b1RxSG8zVEE3L1pHOXRNVS90akJ3QkNDbC9ycXRTOU9abXdNUitJVzM3b1Ja?=
 =?utf-8?B?ZlJqZmF6eDJQTTNyTXZFNXZBWDFOQUpERGxzZVRWL1B1OTJpUzBUK2IxaS9X?=
 =?utf-8?B?ZC84YlBPdlZJcVVuU3ppTFB5L0o5RXp0dWdvVUlUZk9peVN0YWlSMVdMMXho?=
 =?utf-8?B?elhrM25ocFJtaWEzZWtBSmZDWUQwYS9QWk15NE4xUVViRVpkR0NTWHllblJz?=
 =?utf-8?B?TERBWVNXTk1lcmgrU3JoTWpnZmhDbUVKbDlSeVpiU1BHWmF4WjlyRDlxd214?=
 =?utf-8?B?SjBvMWJHU1AzQWlKdDFjUVlBaVpCOGR3TEdQRXpPeFE4M0UxZjgvdVlWWVdx?=
 =?utf-8?B?Y2ZnOCtRZW1XNWlXcEM0SXlNM1lZaW8xQ1R3THl2WlNJNEhORU5LaThGblNt?=
 =?utf-8?B?Nld2cjFMdjdmQjVYTkFaS2pUYUtiS2lDNzYyM0RBU2w3eXZXV3hCTEU0QXQy?=
 =?utf-8?B?YWVtU0hrTmRLcXRpUm5oZE92aktxa005NFQ3Vkdvbk1qZVAxZkhqV2Z2K3Fr?=
 =?utf-8?B?YTNyWXc5M0N5TVdVcnlHSWljOXJzbEtyZWxyRlhwQ0lxalRVNmd3NktoZG1i?=
 =?utf-8?B?K1hMZWc1YkRoNWVGZmZSNXp4SC9aWjVtMldzczdmSVE0ZmZBTStad2lOaisw?=
 =?utf-8?B?RmYrQ001ZndlSmpwRHFTaGY1L292cFFNTStaNjVHa3EyaDE0dDBPUjRrMCtr?=
 =?utf-8?B?Q0NFNEVORGZyd25zb2k2R25oM2F2NkhZdVZKUXF4R21TMWw5bCsvS01Rek1t?=
 =?utf-8?B?WUhSakZ1dWN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3JNTlNHdUtXcklvOHpyWlVmK0p3UGViVkxCYzRJQjhTc3BCdUdjc0FOUW5T?=
 =?utf-8?B?aWFRMVFJdnZ0TklWRXVHSWdvNGh4MzhsQng1dFRNTkp1b1hGa1dkdTVhcFRz?=
 =?utf-8?B?QjB0bHZMZU9QUW5DM3FHSitRcml1aUhldWgzSHgvS0NMTXFOK3N1Q3BMQnV4?=
 =?utf-8?B?SEQ0TTQyMXBwVE5SeHZPQUZuZWVWblM0aDVybGF3TXh1bVUydkdqMEhramxR?=
 =?utf-8?B?Ry9XaFpIRUVYTjcxb0RHVkczdE45RTY0TWoxNEpZNEptZzNMc1dZL3ZpZnd6?=
 =?utf-8?B?SVFPTm5EQVJia3R1alk1TzJ1WkV3ak45dVdxUGVXUVc0ZllRcFg1ckZKYUc0?=
 =?utf-8?B?TENRN2tmckxHUGpCVXJ0UGNRUmR6a29XUWl4YWFMQkYrSEg1QlAxYjlJSzQw?=
 =?utf-8?B?eTJOSjdvOXpaV0drQnJBNkhiSHJleGRYNkFLUEpIbWFMSDBHN21XZ2dmaE93?=
 =?utf-8?B?dFhBVUREUEFNYTZOYlM4ZUtCcjE4QnpCa0NvRGRlc242U1ZMUDRMd0tRTllM?=
 =?utf-8?B?bkNNSHdlck9ic2NLK1RiVmthc1RZU3RWSjFXQVpkN3drbGJSR0lXdFNCZHh4?=
 =?utf-8?B?YVJJckI4QWh3K1hXN0JNTmV2cUYvUm5pYysvMGhJZ1NHR2dDL3d1SzNjM2kv?=
 =?utf-8?B?Umw3MVBtTDZZWmpQemE2Qi9GaUpXSnFvS0UvU3lEdG9CdG51WGlLR0xiaE5l?=
 =?utf-8?B?b3dxUjUrZVpoeXVFYUs4VjR1UTRCNGdOTlVhdXZEVW1JTzJaMGVURzhHU0hm?=
 =?utf-8?B?N281bjdiczBxTXg2eTM2Y0txSEN6WWpQL1pzQzlYN0FBYnBpeW9YRU1nVC9T?=
 =?utf-8?B?QTI1YmVTWUMvVWJqMEhXV0dBRVNlMDZhdWhYZXUxMkpXWGt6WjJ3QmpaQ2NV?=
 =?utf-8?B?bVdXYjFpZ2o3aUZZa0psSHR6SVJPOE9hczhrVUxGRkhPdmExbUtoL092MFZn?=
 =?utf-8?B?VUkwZ2VPRnRkV1hCYzVVcUN2NXJUVzlJOTIvTnRNVkJTanRrQTVhZDJTNHJJ?=
 =?utf-8?B?Z2tYcG42elJybnRveGxuMGNmUUI4bnM1LzJnemZrYUd6cW5sVEh4Z0kzbGJO?=
 =?utf-8?B?TXNsRnN2akk2ZWVEcTZJcGhIVHVacExXVDB0VW11bmZoTnJ2cGNPZ21BbTdz?=
 =?utf-8?B?YVVjR2FsZTBZT1A3UEZTL1BJQi9xUG0zcUw3U25scjNlMDFENGo2YXV1RHVv?=
 =?utf-8?B?VnhHdjB3UDZFK09TblE3QmlmcmdEdk15SjFDdEpsYkJVK21SWEI2dWxoL2NG?=
 =?utf-8?B?cThZa2NQS0lGN0Y2YUlVTC92NW9BWmlUUFZLaTJpbXorTXlNUnBUa1VPSTh0?=
 =?utf-8?B?UHRGV3o2YUtVZGtxRXR5SkZUeFRoQVBoUng3czVKVkV2ckJqd09HNGxIM0Ez?=
 =?utf-8?B?Vm1RK1hCTFRUWGkzKzBleEdhSmMyL2t5ZjhkRVJjdFZMQ2R3VHBWZmpKSFRz?=
 =?utf-8?B?ay80by9UOFdQMDRITEJYTDdHS3J1VXphQ0VyMUloMU0wN2tRdkJlUUEyaldH?=
 =?utf-8?B?VXdSMmxNTUc0UmxJaUtGUURaOVVBaGlKNDYxdGovUlpXcXVjdHVpcVpiem5w?=
 =?utf-8?B?bmJMb1VVbGFCZ2lsRU5pOTU1NnhHQXVUUVlJUmRwV3BkOFA4eGk3YnoxOUgr?=
 =?utf-8?B?RkN1M21hRDRrR3ZQNUNra0lFR2Vob3VrTldPMkxBUlJKYXhvUUpzanAyMTVt?=
 =?utf-8?B?UmJSTHhiRjBIT0FvcW5FKzFJRlkwcXZOMzVCUjVnQ29UcXRITUYweWVpVWxp?=
 =?utf-8?B?Qm9mVEZDb1dGNHNSZnEvcVBqWVBYTktjbUJkRmowZlh6V1dYVnNBZFhxVkJ5?=
 =?utf-8?B?Zm5Bb1k5Z2ZNV2FHbnQxekdCekVCTCtJT0g3dHI0NzAreXlDT1I4Qzd4TDhX?=
 =?utf-8?B?WEw1STNIbVJYRk5rNXF1OUU2d1FwaDVWOURySDBHbGVCaDMyaWxvdEZPVmZj?=
 =?utf-8?B?dDlyUUh6OVozdG51bUttSmFkekhDWXlLcm9HVlF4ejdCTkVWU0dFR2FaclFS?=
 =?utf-8?B?L09kZ2hOenpPM2dxMHROM3RLSW8wdFYxRUVrOUUrQ1dsSjlPUUU4RUVqZVov?=
 =?utf-8?B?aGlhVUtlN1NxZkoxbndldllCNzY0MzdLb3FhRStobmw4aDhWWGdHZTJJSlhX?=
 =?utf-8?B?Y3Y1akQ2RElRRUJCaVp0eDdRS0hEWlNyT0s4OEMvcEZZTVE1M3NvakhnZmhu?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36ACE2016B6E9C4DA07EDD9B951A679E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hYI4ob8yENAXXJYnd3lqEvooFT7q/0EHcmCzBYDzDAl/aQC8lsfpMvvFIrb9ROSSuQRYufbJusLXmI+4KBr56JC3zE7f6TJyiomerdPveehJr1rWGvp8fetoqqD9Nw+LF4V8gZGZhSNPbXyUg+hiBxpsAdPrpIKekbgYaIzFu/pjSuOgVj8vrBG+t0tRhlSFzXuY/ZU6boaDhlXNuuXwfSEpIKOF2QoFkK+V7ObEzgNyTBQU+oyZwgoFbqfBJ2HgZPuQBD/eX1JwqaL2oovwYZVPVrBxmJDIHFONAuxuWgP0xfJcNwBHzMxXDHTRmzrQFNAqxHTUeHbitf75D7yREuSmC4rddwg3FndKS0KIYT29feYulTPvIPHfOopiJiucmaOwcnZaHCOHm+yl/5kA0lz4cROianzUsMH5JGViAiHCeWkyLA2Qd3Lx/L/nIayEbZdDOyN64Ne9m9ZNez0glEnv2OuJsPJfajpie6RWwLsP5zY3d72NpClwgQw1nJjqgqq7hr8PskR2mQDrQCA2rAPospI3o75piVTXwSxnNWKEKbBN6EDmEocZgwht8CmkoBbAV4YPdHZO2nPDhQP+FCgCndOo7k9bHn99Of+hRJ9LSIfCD2sM0+OlHb0ACXzJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44394c9b-203b-44ab-eaa4-08ddc5312ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 12:55:11.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UV4/2v/WKh87kmatQp8m7aCXFwkt6TU/RjuCU2BFWV3jDSzNdRDUjPeCNHDvG3TrGjjn8LeLdvOvJ0XJl2a4xq7yUO0kQWboG8r3zttGUn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9271

WytDYyBIYW5zIGFuZCBDaHJpc3RvcGggd2hvIGxvb2tlZCBhIGxvdCBvZiBHQyBvbiB6b25lZCBY
RlMgbGF0ZWx5XQ0KDQpPbiAxNi4wNy4yNSAxNzo1NSwgQm9yaXMgQnVya292IHdyb3RlOg0KPiBU
aGFuayB5b3UgZm9yIHJ1bm5pbmcgeW91ciBwZXJmIHRlc3Qgb24gaXQsIGV4Y2l0ZWQgdG8gaGVh
ciB0aGUgcmVzdWx0cyENCg0KTmV0IHJlc3VsdCBpcywgcmVjbGFpbSBraWNrcyBpbiBlYXJsaWVy
IGJ1dCB0aGUgb3ZlcndyaXRlIHBoYXNlIHN0aWxsIA0KaXNuJ3QgYXMgZ29vZCBhcyBJJ2QgbGlr
ZSBpdCB0byBiZSAoa2luZCBvZiBleHBlY3RlZCBhcyB5b3UgZGVzY3JpYmUgYmVsb3cpLg0KDQo+
IFRoZSByZWFzb24gSSBkaWRuJ3QgcHJvcG9zZSBlbmFibGluZyBpdCBmb3Igem9uZWQgaXMgdGhh
dCBJIGFzc3VtZWQgdGhlDQo+IHJlY2xhaW0gc3RyYXRlZ3kgd2FzIHRvbyBjb25zZXJ2YXRpdmUg
Zm9yIHpvbmVkIGZpbGVzeXN0ZW1zLiBJIGZpZ3VyZWQNCj4geW91IHdvdWxkIGJlIHJlY2xhaW1p
bmcgYmxvY2tfZ3JvdXBzIG1vcmUgcmVndWxhcmx5IGFuZCB0aGF0IHRoZSBoYXJkDQo+IGNvZGVk
IDEwRyBoZWFkcm9vbSB3b3VsZG4ndCB3b3JrIGluIHByYWN0aWNlLiBBbHNvLCBJJ20gbm90IHN1
cmUgaG93IHRoZQ0KPiBmbGlwcGVkIHRocmVzaG9sZCB3b3Jrcy4gQUZBSUssIGN1cnJlbnRseSB6
b25lZCBpbnZlcnRzIHRoZSBtZWFuaW5nIG9mDQo+IGJnX3JlY2xhaW1fdGhyZXNob2xkIGNvbXBh
cmVkIHRvIG5vbi16b25lZCBzbyBJIHdvbmRlciBpZiB3aWxsIHVzZSBhDQo+IHRocmVzaG9sZCBv
ZiA5MCBhdCA5IHVuYWxsb2MgZG93biB0byAxMCBhdCAxIHVuYWxsb2MgZm9yIGR5bmFtaWMuLi4N
Cg0KWWVzIG9uIGEgem9uZWQgRlMgd2UgKGF0IHRoZSBtb21lbnQpIGRvbid0IGxvb2sgYXQgdW4t
YWxsb2NhdGVkIHNwYWNlIA0KYnV0IHNwYWNlIHdlIGNhbid0IHVzZSAoem9uZV91bnVzYWJsZSkg
YmVjYXVzZSBpdCBpcyBlaXRoZXI6DQoNCmEpIGFuIG9sZCBnZW5lcmF0aW9uIG9mIHRoZSBkYXRh
LCBvcg0KYikgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB6b25lX3NpemUgYW5kIHpvbmVfY2FwYWNp
dHkgb24gWk5TIGRyaXZlcy4NCg0KQnV0IEkgaGF2ZSB0aGUgZmVlbGluZyB0aGF0IG1peGluZyB0
aGVzZSB0d28gaXMgYSBwcm9ibGVtIHdlIGRpZG4ndCANCmNvbnNpZGVyIGJhY2sgdGhlbiwgYXMg
Zm9yIGFuIGV4YW1wbGUgWk5TIGRyaXZlIHdpdGggYSB6b25lIHNpemUgb2YgMkcgDQphbmQgYSB6
b25lIGNhcGFjaXR5IG9mIDFHLCA1MCUgb2YgdGhlIGRyaXZlIGFyZSB6b25lX3VudXNhYmxlIHJp
Z2h0IA0KYWZ0ZXIgbWtmcy4NCg0KTm90IGxvb2tpbmcgYXQgdGhlIHVuYWxsb2NhdGVkIHNwYWNl
LCBidXQgdGhlIHVudXNhYmxlIHNwYWNlIG1pZ2h0IGJlIGEgDQptaXN0YWtlIGluIGhpbmRzaWdo
dC4gRXNwZWNpYWxseSBhcyBidHJmc196b25lZF9zaG91bGRfcmVjbGFpbSgpIGxvb2tzIA0KYXQg
YWxsIHRoZSBGUyB1c2VkIChkYXRhICsgdW51c2FibGUgKyBtZXRhZGF0YSkgdnMgdG90YWwgc2l6
ZS4NCg0KPiBXaGlsZSB3ZSdyZSBvbiB0aGUgdG9waWMsIHdoYXQgd291bGQgdGhlIGlkZWFsIGF1
dG8gcmVjbGFpbSBmb3Igem9uZWQNCj4gbG9vayBsaWtlPyANCg0KR29vZCBxdWVzdGlvbiwgdW5m
b3J0dW5hdGVseSBJJ20gdGhpbmtpbmcgb2YgdGhpcyBmb3Igc2V2ZXJhbCB3ZWVrcyBub3cgDQph
bmQgaGF2ZW4ndCBmb3VuZCBhbiBhbnN3ZXIgeWV0Lg0KDQo+IE1heWJlIHdlIGNvdWxkIHRyYWNr
ICJmaW5pc2hlZCIgYmxvY2tfZ3JvdXBzIGFuZCB0cmlnZ2VyDQo+IHJlY2xhaW0gb24gdGhlIHNt
YWxsZXN0IG9uZXMgKHBlcmhhcHMgd2l0aCB0aGUgZnVsbC1uZXNzIHRocmVzaG9sZCkgYXMNCj4g
dGhhdCBudW1iZXIgZ29lcyB1cD8NCg0KVGhhdCB3YXMgbW9yZSBvciBsZXNzIHRoZSBpZGVhIHdp
dGggdGhlIGN1cnJlbnQgem9uZWQgR0MgY29kZS4gSWYgNzUlIG9mIA0KdGhlIGRyaXZlIHVudXNh
YmxlLCBzdGFydCBjbGVhbmluZyBpdCB1cC4gQnV0IGl0J3MgZG9pbmcgaXQgaW4gb25lIA0KYmF0
Y2gsIGNhdXNpbmcgbGF0ZW5jeSBzcGlrZXMgYW5kL29yIHByZW1hdHVyZSBFTk9TUEMgYmVjYXVz
ZSBpdCdzIGRvbmUgDQppbiB0aGUgY2xlYW5lciBrdGhyZWFkIGFuZCB0aGUgdGlja2V0aW5nIGNv
ZGUgaXNuJ3QgYXdhcmUgKHNlZSBteSBSRkMgDQpwYXRjaGVzIHRoZSBsYXN0IDQtNiB3ZWVrcyBv
biB0aGUgbGlzdCwgdGhhdCBkb2N1bWVudCBteSBmYWlsZWQgYXR0ZW1wdHMpLg0KDQo+IEFub3Ro
ZXIgaWRlYSBmb3IgYW4gZXh0ZW5zaW9uIHRoYXQgSSB3YXMga2lja2luZyBhcm91bmQgdGhhdCBJ
IHRoaW5rDQo+IHdvdWxkIG1ha2Ugc2Vuc2UgZm9yIGJvdGggem9uZWQgYW5kIG5vbi16b25lZCB3
YXMgdG8ga2VlcCB0aGUgY3VycmVudA0KPiBsb2dpYyBmb3IgdGhlICJ3ZSdyZSBvdXQgb2YgdW5h
bGxvY2F0ZWQiIHNpZGUgb2YgdGhpbmdzIGJ1dCB0byBhZGQgYQ0KPiBzbG93IGJ1cm4gb2YgcmVj
bGFpbXMgbWV0ZXJlZCBieSByZWNsYWltX2J5dGVzIC8gcmVjbGFpbV9leHRlbnRzIGF0IHNvbWUN
Cj4gc2xvdyBwYWNlLiBUaGlzIHdvdWxkIHRyeSB0byByZWFzb25hYmx5IGtlZXAgdXAgd2l0aCBn
ZW5lcmFsDQo+IGZyYWdtZW50YXRpb24gaW4gdGhlIHN1Yi1jcml0aWNhbCBjb25kaXRpb24gd2l0
aG91dCBldmVyIGRvaW5nIGEgbGFyZ2UNCj4gYW1vdW50IG9mIHJlY2xhaW0uDQoNClRoaXMgb25l
IHNvdW5kcyBsaWtlIGFuIGludGVyZXN0aW5nIGlkZWEuIEdpdmUgbWUgc29tZSBtb3JlIHRpbWUg
dG8gDQpjb250ZW1wbGF0ZSBvbiBpdC4NCg==

