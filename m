Return-Path: <linux-btrfs+bounces-14594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC8AD4D75
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 09:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330DC162486
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1C0227E84;
	Wed, 11 Jun 2025 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y+HL+q3B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CRiE45A8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD82D541D
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628359; cv=fail; b=VGavHd7CWkuRRTAYCVktJHXu04Qy/CguBZylg0gGDcUOn40X5aqThRQREtsPTBHag5KIjCKOlf/x4bwyc3Hmd+U9+WnFH1BpM4fWMQMP3hcNQwJMLWDY7K0sM5nkvL5SjoeiTN83cluZtQK6ZmqffGKq/VpE5YR0YTarsV7aXuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628359; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocYbrJ2Tf71xj0+NIt0J8czbqbdHeNU0ojQ45p1e5V1ZkugrjsDDO9B74CxrxRQv4/qb25lptQV7QyQcP/5zhH7N0EyMY3sAv93M6NTJl+PcxknW7laukLksO2UlGDwC0tcUEmDT1FyLMJQbEkpPMLvvdzpJ6Z05uxmVfixgBUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y+HL+q3B; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CRiE45A8; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749628357; x=1781164357;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Y+HL+q3BxyANTX2yYRrfu1zIwWKFFJyXdJuTzmck10KNOUx+lH5ydvWb
   WPoNRzwnimkIhjrcnU4qwuv3f0IoiILgJUKTc6qNZhFXL4eI/++fwuWdh
   bfwbprhaWncsCkRsEb1kVeDqUBPCRPtV51yyQrlMEUEMq3/ipGZ7+yfvN
   0j+5atzGNu7wIDlMmCs+CIjl7f3yL7dj0ZbiXJse1pS6bS/9HrxjI3oo6
   jrcfJ7XOA7HGLVw1UXsvmInPfuAF6hWfXCpgR7qUSyWII8REK5YlPpZgB
   vm8qRR8vvsNrKVUlasfMLzYgMTkHYRsYH8s2SPHdcWncsdbYCPBz5CZLK
   A==;
X-CSE-ConnectionGUID: jFjvm1RcRhyMMgFPo50fjQ==
X-CSE-MsgGUID: H0qygA+oTUeToh5FCmIM7A==
X-IronPort-AV: E=Sophos;i="6.16,227,1744041600"; 
   d="scan'208";a="90368702"
Received: from mail-co1nam11on2068.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.68])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2025 15:52:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPfzIQFDAJIrWxZYhAcTt1ujB6SpUmOjXU8cUJy7XxNU/2fA1H4v8xzDSOsYDirM3Q1neh5KJ/yAsso9THFL5PqHaMlmcoYt7+dojGEKxp7NFZdPron5X2aXCLvu+z29tx22b0cgAro4H7ypuyrEbxXzQRWGx5NVtBN6Fdnqp+1JHO5E3RDmTCqwnsV9BQJE/dEt7OSuWZlnFJA8ywuBMciEb5OdFrBv5fjqukVXQnes1ycOeNz9ze9PzZOKTZ1GdUE2lHP04R1Ww14hzdv5EoNTd6KmM79Z6R079fJqx3Xt1OwH4+AqXcY78PnHh9F0sARwLtftrF+qzvepCp20FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KydBe3+mdvJ2FWDBLcbsBI+onSOTAiBNBb3ife8SvrSAKCuNWnyOKGV/ChJeKbhuCuZyR0l5ZP8DgGOmao3M+tpXLa/w8bo8/8EzTqKRqhQKyKOg6Ka5mF61bcYLE89QSFWWMtK6rJ7aYZQtfI2wlLwhL1RN7xvEU4gXbGAoBAsX2wOkKQzp153XW9zjYnhQN5aMwawreg3nrT6TtlcZgOdZfuzuktBh8MCxm5hUYSUTOeFgcz8pDoDq427kgNPC8kChcL1B6hUBLA3UwtTsuLPFyYOkFFhDkuaTHhveedc66guGcHK9WJ3KqMVUxCmja/y0ZNtrmDIaGcLfv3jpGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CRiE45A81uPTltxOYe0GP+N3zsP6VOW/5fto+SmLCAe6wQFHc+mfHm4QWBlM3il79+/OeCzv/Isdlrdv21YEuWUI0ERTqBoaDs8qmQ2kORDdTigWj5bZc9JPCZoRe4QXrEkmxiqvYIs5wD8P/uxvmBLoNBeNzAwivCHKxIreuVw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8445.namprd04.prod.outlook.com (2603:10b6:806:334::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 11 Jun
 2025 07:52:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.039; Wed, 11 Jun 2025
 07:52:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use btrfs_is_data_reloc_root() where not done yet
Thread-Topic: [PATCH] btrfs: use btrfs_is_data_reloc_root() where not done yet
Thread-Index: AQHb1wt4c4UBtxw8tUGl76qRcrdFGbP9nW6A
Date: Wed, 11 Jun 2025 07:52:21 +0000
Message-ID: <56bdf3d1-3985-47d7-843f-9af44d949cf5@wdc.com>
References: <20250606175001.3561736-1-dsterba@suse.com>
In-Reply-To: <20250606175001.3561736-1-dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8445:EE_
x-ms-office365-filtering-correlation-id: 7c701f87-a8f1-412a-243f-08dda8bce5a1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnVQSUxqOHVyWS9yMHVaaFRvaW1TY2VGQlhLRTIyWXFaQjEyRW16S3o3U01q?=
 =?utf-8?B?M3VIUVNEVEdPaFBBQlJIUTZDVENKOG5UQ29tNWdUR3JxYklsS1pmMTBzdngz?=
 =?utf-8?B?SUNFejFuQlZMbmtNSUIyZndENWVVK0NXNTEyZnREajdYeGtVNW9tS2JMVDNx?=
 =?utf-8?B?UWpRVmg5dXBVVzRJT1BCQnhOT0ZzblJpeXk3aTJSbmJxOWJ1QWdlUkEwRHdl?=
 =?utf-8?B?MFFucUV4cHIzLzcyUmZMRDFTS2tHZkh1NkQ2RnN1NkxzTnV2dWJZYlllellJ?=
 =?utf-8?B?dUxnTlZtdkZtbERMUUdaWmtrV2MvSWR1Qi9kVUlvdzI5QVdJWWpTY2pGcEN2?=
 =?utf-8?B?eitEU1N2VVRGL05BcUlnMjBVMEthOFBrV1FQdHJ3TXBWYmFidlpCdjZ4bkIz?=
 =?utf-8?B?MGkwM3BvMUhNQlU1VUxtbEVKQnpiRklVRGJkNEZJVVVLamNxT2hYc0wyYTlq?=
 =?utf-8?B?eW1uSEdDSll5eDJHUFI3R1ovbDlPTENZLzBtcitYcG5BOXh4OWZ4c0N0ZHEv?=
 =?utf-8?B?U01ZcGhJQWwyT09VMjNPRDhQTDNndGg1TDlnNFVScjl4cDZQeC9NV0dBU2hx?=
 =?utf-8?B?Rmd2NkVDaHpHemlHeDc4ei9nYXhHdldGNzZxUUVZZlRtYVFoQ2tvYzNqNmJN?=
 =?utf-8?B?dEtjMDVESDZ6TjNhczBDRlJyMGw4RzNpUlFVWGJyOEpRQVdwZUhkMnhMcGRW?=
 =?utf-8?B?UTRseDU4Zk9adFBuWVJscWNjL05tb3I4dnRJcjhqVkNGSUg3dldhMWU5K1Iv?=
 =?utf-8?B?andYUE94eXRHc0xKVDIySHNvcEFESkRHdGQxNFFLM0tQQll5UEJtY05POC81?=
 =?utf-8?B?QWhPYmwzc1NycDNua1ZuTjVNS1pJeks3N2UvL2ZxWSttc0VnQk1DL2M2WVRM?=
 =?utf-8?B?amd1QU13bzI1Wjk4Qm0xdWVhclVtTTNqWjRvQ1BVUXZobjdjVU8wOFhoZmht?=
 =?utf-8?B?eG44UmViVFBmRW9CQkNhN0xoOXlnU0dyQ0hKS3lDbEtoSUdzTTlzRUp3cGZE?=
 =?utf-8?B?WnNYVTc1ZXFUVzdEK2NuT0EvOEREM3NVWlpEWCtpTzA5RzlEa3JhMHkyMjFO?=
 =?utf-8?B?Q2NzZys3Z0xOajB4aTFwaVY3elJ2NldGVzlkSktwMUtyNU52NlBnemc5U3lu?=
 =?utf-8?B?ajhEZEx0WkhERStKRE11UzdueS9oWXpsT1ZpYjk4aTJKRGhoZ1BDUUZqSUpJ?=
 =?utf-8?B?di9oMFl4eE5udkpXbWxjSjBLZ1Y5b1RxaitqSVF3eFk3alFybHhjQ3hBL01i?=
 =?utf-8?B?WVpiY3Fid2VqQTZFY1lkWjBjTTU5SkVadWRQUWJqTTFIb3VLbEpySTJGZjdp?=
 =?utf-8?B?LzhRNVRnMU1jdFk3b2VndVorWXBSRXlMem1qVmNLUFhqSmNoNGN3ZXlCYU1u?=
 =?utf-8?B?dXE0RmF0OGNzNmlOMmY0K0VnM2wyN1cxZVRsYzZNTWFVYytCQ1Q5RzQ4YUNl?=
 =?utf-8?B?T2tFWkFucmJ3dlQ0d1pvQUtZSmpveVVaTEF5N2lFNUVRMU5kRXhjc0UxL09w?=
 =?utf-8?B?OGU1cW05RnZNeDM1WXE2RldqVGRTMXVyaEdCTm16UlRuRlNhSkh4dU0yQVZv?=
 =?utf-8?B?UlgxbklYak5LSC9nU1cxajNJRStESFU3REZ4R2UyZmt1N1lBUFlEN2RrVGdH?=
 =?utf-8?B?cVNwZ3BuUkpML0wwbGVWQ3FNZ3ZXQjBDUis0Wm5GN1NnM3JPWk1CbE1TZGdx?=
 =?utf-8?B?STZRb3Q1Y3JBY1ZOeW5CUStTbUdTd1plNGlTL1RweTN3ck16bFFsY3g1bk1M?=
 =?utf-8?B?dm5NUVljWXFVOWRVUGVUaVlmWk1yZzE4S3RJbVVZVTFqNmJtTThkclFqWnFw?=
 =?utf-8?B?a1Q3d3h3L0VoRWdIdTlDS05rS1FnR1NrbHdrYUxxQUFnUW9TYWFOTFJFMG5C?=
 =?utf-8?B?L2F3aUxzcFRoeW90YkdoQ3p0VGdTeFB2OXBEL3hsejc5YXk0SkE4dWkzOEpy?=
 =?utf-8?B?ai9BSG15b3lUOElrbzEyaVE0LzNlUkdnT1BmQ3BXUlVKTUFhUVJLV2FVYzEw?=
 =?utf-8?Q?6qOsk5Ok00nI228S00tvw1QSYiT1CE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3V1SHlSZnRMd3ZaM2RtUjlVSnFGWkZYTkFlSHN1WDg1WFJaVk5pdWQ4VTJm?=
 =?utf-8?B?eHAveFJHeDdpWWxIcmh6TG9Yd24rYk1zZUJmVW83ZW91bUM1UmZqVEVreXVY?=
 =?utf-8?B?anlyVC9JclV2VitacUYrbnVWV3BNamgxMUdZZ2NCR0s3VDFVK0daNXNZWFcr?=
 =?utf-8?B?a1RobWpwSUZHUmlJNjVkYkRDdi9kNzFJdHJJd0pPMW9wMWRwM0ZtdzNIdllx?=
 =?utf-8?B?WjdPcXRrS3NQQmZnUVExL0JHMXA3TWg0WlkraCtHME4rTlZCUU9nWE9BMWNK?=
 =?utf-8?B?Y25jV3JoVGhXOWlTbFUwUmhESUtyMFhuUHlCckx6cGtObzJjOXVNMTRvTlN2?=
 =?utf-8?B?a3RmeGdFVHJua2NDNS9oUFA3S2oyeVl1N21JeDR5bTRmWnBTMC9xNE1vb2l1?=
 =?utf-8?B?MFAzMk9vRTBZSnNGVlRXTS9lb2Y1MkdDaTFEY1JaVTVhYm45cmdmSXFIWUtI?=
 =?utf-8?B?N3lYb3d6UjVuR2VEUG84NVluamVhNGFUWE5ONUFISVFWbFFBa0lRK05Yb0lQ?=
 =?utf-8?B?S3VCOE9tUDd1RkVXWXRvQkxWSCtTOTlHbHlVNTBubHRrWXR3eW8yVmo2cjNq?=
 =?utf-8?B?T2JUZGlKRldhVHlRWTZUYmlSb2NpdSsyWXR6SU9TemJnQU45RTd5SEZPMmdl?=
 =?utf-8?B?clgrbEdVR0lyRFN3TUxjR3l2T2Z3empPaVpRSk56SVBHOW8xeE9aK1cvK1lE?=
 =?utf-8?B?QitEbEFVVmdDVDV0NE05MUdndXh1ZnZ4YlgrdGJTYVV4VmdXRExuRUMwRy9z?=
 =?utf-8?B?bHAraDYrWWh3dVlNN2xDM2VTT0V0Mkd5bHFRbDhmeUtzdkRaVmF5dFpTYjNp?=
 =?utf-8?B?MGZvUDlKL1hvZHJkbSt3RlJzZzh2Z0FTSE9vUlJKNFNmeVhJa3pOS0dDWE5h?=
 =?utf-8?B?OHN2NUwxZzROZ2lmMm94S0tYelcrYjc0WjdtTlFwd0ZMVHhTSVFzOTZ5WDVl?=
 =?utf-8?B?dm5JMk4wVEhGZkVrZnI3UG1IWFhRVjVJcStObFVWQy9yMEZrZUh0L1BZOG1n?=
 =?utf-8?B?dmlNNC9FSlpqaVhnd2ZKRVR4WDRxQWdybFVYYjJGc2NDSXY4OXhCSU1YWCsr?=
 =?utf-8?B?eTMxL2dOZXBZREtCSkFYMGRsR3Fzcjc1aFF1aThCS25ldVBXYTZ5WVJ2SlFz?=
 =?utf-8?B?TnNLeWx2ZW9iZmlzRWVpQW5NMkVUMllvZzF4MEJxM2NlSXk5d0tGRWMxUHVU?=
 =?utf-8?B?Q1ZUd2I1UmM5V0dVbTFZWk43S1k2S1J4ZnpQenExSnZ0NEpYZ3hXREt1UkdC?=
 =?utf-8?B?cU9TSDdKc3FTVUNqS3VmMk9FaWZxd0krU1EzS1ZwOThENmtGUlhoWGliMnVE?=
 =?utf-8?B?ZnV4N2RQZ0hhZ0pyVlduZmtML3FnUDZNMmNuUVJEOVBIMUNKWCtsOGpiWXg4?=
 =?utf-8?B?dk9Sd3FHN3pSUWI0ZDg2OC9MNzFwOUkxQk43cUMyaDJpZzUyTE04WVk3V0th?=
 =?utf-8?B?aytCUU5JR285dStyUUNpanp2ekRrZzQxNThqSGRNaTkxMllGdy8yM1ZCTENF?=
 =?utf-8?B?NzgvQVVjMDFQL09NN0VQZFloYUdrT3YxUHlvbXBlb0VxWEFHZGNFTGJGdUlU?=
 =?utf-8?B?Vm1PVEVRT3pBR3pxd1g5WFBpSVRtM2pzb1RRajY0WTJabUZTK3ZLbzB5WEVh?=
 =?utf-8?B?cGlleE5hYUEzKzNialU4anY5bkR1QitrN3JBL25sb2ZtZ3g2RU40WUxFc2dn?=
 =?utf-8?B?bm4xdzBqSFUvbTBGejNpc1R5QWdzNUh2bUVMWnJ5VTlaWnpvZHEwclNodGNt?=
 =?utf-8?B?Vzl6MVI3blp5MmpENnZ2UjJTVU5ZeStZL1p3U2VITGk5OTR4MU5UQmZ6Z1RL?=
 =?utf-8?B?VlV0Z2YyWGs5TVN3bXNLWjVVaDZEWkhDSmU5NStmYnZ0Sld1cGdoTkdydG04?=
 =?utf-8?B?MlpQSEFINVAybjJqeW5Bb0o2WG95MEowYVVCMnBhN25kalV3NmtyOHNTRXln?=
 =?utf-8?B?RENnR3BJK1p0L0c2NTZrbys0a01FTEErdFlCZnFrWXg2SkVFNWEzZGxUS3JG?=
 =?utf-8?B?eWowUGFQSnMwbyt6QjkyUjRHbGF1MThPaFVRM1FEZzBic2FZN0JTdmRQRGla?=
 =?utf-8?B?N3RSZGhCenRHU1o5eEZIWEh4cGNzL3hqaGVkTEV4YjlaQmo3S0Z5OTZHSUd3?=
 =?utf-8?B?bHh3dGZ6Nmw4RHlzcWdBNE9kOEZmWVlmdmUwUHBTUnJuV1grazdKWmZyU3NP?=
 =?utf-8?B?ekI3dHYvYlRCbWQwa3FMVWlmVzNnZ0FqUlR4cmFJbk1JNHM5TDN1WG9ubmFF?=
 =?utf-8?B?NkxhQWZBZUF4amhhcUp1bmM5QUJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4ECA21D9031A45AE76071A4FEE5F2F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xR6G9a0oj3xF8GToDH562KELR2wUBf1bMPsf8r22Mh3b91I8GmWY5blYBNtDZkomOjl8W+sX9iX4hDCc9YNL4I+KnKRl2ATbNXeE9OBroql0Ur95WX57eBGlX+L/G/ohIS0cE+L1kiw1vAV1B0LvSvGY9w+JX1CXfZCWDQcvOGF86OA1HWL/3bG2gD7V0TFKElDR3N002z2i265NPMzC9SZXcPc5pOomfXkZpd+gExUsMak34Ej6oydt2Wq5JczpGjHapnpx2Xnaes3NZaGKMSW0B1ISFmGqvgmFyPP5XWc/etCUDb3s45JnqlSn+pBGusSmPPQh+9gB3l35Tlo4ziASPWq5tr0rO/1AbPCpJSK4rrPyPtF15cYKkWpFb0NiUMgluPvPSr02LJSdH2RYx3U0fnxDMBce18jQrJusfznAuz1mGWDqMTMUYQXWhsqL/qD/an7MyYtaDlG/NhvKFMFMjnDZ42MNmNK0RM+t2T/li/GZ3t4zRELIsX6dg/Ti8kniXCTkMoPTMEdnpcGdHL6j9SVJdHQ+4g6qbBG0vwbcsR9oU5ZyQGjtwsbT20lCV4yRDj3SEGIRhazzvw9Gcf9NX/6qKS7uxQFj8+4Mxfhb8O+iX7ph5oiAVbNMXlDD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c701f87-a8f1-412a-243f-08dda8bce5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 07:52:21.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHmXvVzlw/g1QQ+fMmKJBKsN4qgyTslU810pc2A9CmUTBxtTIbeUqp38SoV9qN0Lx5fDXu9paD+yvhmpsPonEVboqxRTWW7nBHGkHANx5DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8445

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

