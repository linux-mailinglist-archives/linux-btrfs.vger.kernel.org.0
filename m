Return-Path: <linux-btrfs+bounces-12477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5CAA6B813
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC4119C03C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7021F1319;
	Fri, 21 Mar 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="la0+w6wO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oYdp/Zze"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C81F03D9
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550593; cv=fail; b=CO72tnwdallYLoQNC/U8hS0KbpLnQyqv1DnDTaD28uoK3iaXD5Zs4BcZ+S8BboJF30ceiFCgEQ9jS3kdoK+MSElLiBEVh+8jeK2T1oEHPqnGzBRWtoUAHgr/JdB7i1ELGsm1JIR0mq2tttuYQVDJYPS/IVCWAnKdOnxBlbwprdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550593; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MS8tFuG1NESXPJbwgj99COZFyJTE3lCFNxUCucQWDmKwf8gRV0DDXyBjlLqYS7QxVHyD1oA8F4nYCwYg05dug2GrOOAPIKL9io0eJAW1xtNQYDbFzNfbxaJdZCCxqLghO3Z7BrysAlUMOwMoHS9Mb4MEpEaAx/9UNZkQk2egk40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=la0+w6wO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oYdp/Zze; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742550591; x=1774086591;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=la0+w6wODgNhsyOjBCCaN1/tKpqqO/cfNcrOif4un52+DeA6y5c9FDFs
   fbd667vrQMnnTyMu76y2WIqkBuIDoYRbnfvWPEQxXMyn4anBKl40DqzfN
   p9AXbSmg6XSyHBwRWUy07B+hwNEw0KXb8jJaNZolTPvebLzLPi5OURC+A
   SAELY78OGbv37gkmTGbpb5SJWZddMi5keH8GKcpcno4nUX5yL21Acu3Gd
   yVgd2+9jvdomntAu80MQ+zx8l8WBRopRyH6aZczQBv84Cz12dUfUjaceR
   v5IfXxa+OW6Zs7GvTJaEDuU8Asi50crCQ3sozLqwRos7CF9Y2shx1Q0AG
   Q==;
X-CSE-ConnectionGUID: h2+CKCGeRY+gPImBbStKTA==
X-CSE-MsgGUID: raMAgxSpRuqHDH7W/v73pw==
X-IronPort-AV: E=Sophos;i="6.14,264,1736784000"; 
   d="scan'208";a="55932506"
Received: from mail-westcentralusazlp17013076.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.76])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2025 17:49:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfKUhYB350/4URqg+N6lJGsYwIQIuRKEWVmUEe4/kVtnOChHMsEmHTByc3JvNGfgwMuVUKzo9H6S/nTGJUV0XI89opYqWKy7jd2dcW8Uq2AgqiPOETUFYLNETqCxLlM9AlzjNPa47HxXPGMJDgxwplCbTdygIjtmLgcYscltBJY16vJOPAJGF2JNDbtzNVCMXFeXoMXTxPZqol0WCVrwkQKdqSB0waMoxmsZ1LKrvzAfTWg+QbO7hS7jmT93/y1gzJjI/uDV7WFwwseObbZAfJyDR7jhsL2JTdW31oCzizqpv8nf1S8hCgcpNo5aadPuvr5zniC25rade8+asr3BBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=uRJy3HzokWw1r7RR9HbOBDSqVQDDtNQTYDAoJs+xyE3R6G6o1vMvjQyoQ5zAqInFAY6fGU2NDbZgto95o8MwBoHmzhHC9ld+DUt8kXLyisU3EwiQwBGqG8ijh+ZBNDwM4que8n73/sDviGe0mzQse+I4OKT8w8q5XqWoxsKZaqg38nlqeOhVV/REX8C1enn3RLBZhAgvio8RM1nDufQGfYTja/aZSDLjXAPWZ0jguGKDA+pc9Wspv3RnM0wJF8x4rf6fcEh+lDxTZ27dXozNG4QCT7Ld6qIrpxPk4R4Ew/Lz3EvnN2iV8IQm7JQhdxexMq+NnnM4XLLJPEuZ6hvpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oYdp/Zze6AreQi3Iu99zYGnSgehL7QaYnyZu1yI5i+4ti/RR6NsQyk81Uo5DTEkDbYdRJhoTmXkUpL+gn4ku+QKEat/gvp166wzK8/kz6+tYQDIYvYj3XB7r2x1wml1we92vVEU1PDpKYSvz7poLVG3TUUST14QeO0bcEZ5aiLI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 09:49:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 09:49:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: extract the space reservation code from
 btrfs_buffered_write()
Thread-Topic: [PATCH 3/4] btrfs: extract the space reservation code from
 btrfs_buffered_write()
Thread-Index: AQHbmVn3JkLIrXGBZEWcVP7OFLAv/rN9WneA
Date: Fri, 21 Mar 2025 09:49:49 +0000
Message-ID: <0108011d-298a-463f-9fa5-b51e9607edc8@wdc.com>
References: <cover.1742443383.git.wqu@suse.com>
 <522bfb923444f08b2c68c51a05cb5ca8b3ac7a77.1742443383.git.wqu@suse.com>
In-Reply-To:
 <522bfb923444f08b2c68c51a05cb5ca8b3ac7a77.1742443383.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7501:EE_
x-ms-office365-filtering-correlation-id: 287f0f2f-f4ed-4b34-e49c-08dd685db8ba
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0RWK2NQVVYrTDFab3ZWOEZzSkhQdXM5Zjg3c3lWbzJBbUhNWGhxWDlYOGJL?=
 =?utf-8?B?LzRBWnRBTDRCTUVaT2xXL1VxMmFZbUZNcm5TR1FlQUtXdmp4TG1jRWVDaGNj?=
 =?utf-8?B?aWtZSmVybzRvRWtKaFYyT1hKblpueU1OL2ZZcnNZcW9sQURoNS9qRk9MV0NL?=
 =?utf-8?B?YVl0Yk51TTRLTmRlRTdCaDAyNzVaYlR0UlhFN0MyL3hOT3NqRlMxd3F6TWJy?=
 =?utf-8?B?Znk2UEJrUHVMbjVQM3BTK3FmSVo4eERHaWFkT0J4MVcrS0pRemJva0dtUXZu?=
 =?utf-8?B?MTZBdEJveHRlNGFtNjVKTTV2YW5KUHl5aHpVNUFQSS8yK1haSnFGRkRMd0px?=
 =?utf-8?B?SFNyaW92Z3hDQld5NlJKaWxBVXA3d2pQWXh2VlVhV3BEWXk0dHc4ZU1aUDBF?=
 =?utf-8?B?dExpOFJpcW93aWE2b3dqaGYxZ1B5YmxqaWRyQi90RVhFZUx4cGY0Q2pNblJC?=
 =?utf-8?B?Q3lVYkNWVit0UlhJcFhmV0s3MHdqS01yN083bXNkMmRqc1dDd3h5NzRaTW9h?=
 =?utf-8?B?YVlYOWpDdVpFQ0ZnazlMVUN4eUlyWnlLMFUrV1crdmhMK2U2WE5rMHZPcGpv?=
 =?utf-8?B?MUhQWVRjbkpsMFUvTjJOOUV6dmdzSG9uQWxPRjh6OUtjTndPTWlERk1VWjgz?=
 =?utf-8?B?OFFEZmpKSlI5cFBDRjBxNzhPTkR3V3diS0ZRYjIzay9xZ0FTRnVBcXJaUzBT?=
 =?utf-8?B?ZlFoM3Y4TFNld08rNzM1STJ2NTVIajBlNE9XZWU0aURXTkg0T25nV0xOUDJp?=
 =?utf-8?B?QTMzTmdjTTNRRFB0N1JEWWJReWkzWDV2YTJxaWhPdkRJMUc1NHlTbjQ0dHY2?=
 =?utf-8?B?dDJlYUxxZHVlc1ZUWlFRMVByMThSSHYvK2s4b044Y0RBcm5YVzJtcitrWXdk?=
 =?utf-8?B?bS9Lb2dPM3lQemtFVmZlOGkzdmVSTHVHN3ZLZ0U2b2JRZC9LZlM3Z3BlMXQ5?=
 =?utf-8?B?THBQUlNLNkJ0NGVFanpQbXVQdk94eE9QZzdOTG52cTJMbk5uMEVpamNUN01m?=
 =?utf-8?B?VGxMTGxNRG9VRm9WSDhaSEVSUzJpaFVCVE96VW94VmhiaGx5T1NLL01hN2Vs?=
 =?utf-8?B?ckd6aEpTNmJoazg4elZnMzV4bzl0b0NpYzBpS3pLTDZFdWNZakJtY0FiQjhU?=
 =?utf-8?B?aXVpZFhpeXlaZmFQZ0ZzWGRCUWNBU3dzN1NldHAvdHVuSi82REJhcWVKWm1x?=
 =?utf-8?B?SzByTG1zczRXZlFSeGI3RVdla3pjelVGRDJIQnFxQ3dsamdKYjE5RjBQWEZ4?=
 =?utf-8?B?cyt5N1RlNHpkU1NqQjFoSDlkbFJYZHR4RFovZ1A5bTVnRk9KMStidEVPelVK?=
 =?utf-8?B?eUYrTFpjcG9BSUgzMHYwbGp4cko3eWRraW43RDdCckMyZkdnNHdSSGJxa3pK?=
 =?utf-8?B?MkNwL0puM3BScnVVR1ZyaUxXb0cvamE2RjlJTlR1OC9RVE9qMGtuR2lQeHJK?=
 =?utf-8?B?WkY2azNPYXFXLy9IQk02ci9aaHNnMlRoK213MDRlR3YvVS96eEdBYk1ua3ov?=
 =?utf-8?B?K0kzVEloMnl0MDEzRUUzeFRaV0tkSlFuN0tIL2hQbkZqeXB1eGVjR2JiazR4?=
 =?utf-8?B?WWVkRFBvbXp4VlhqZTdHdVNISzNtajluNGwyZHFXZURFMFJ6YlM2Ym1yaWxS?=
 =?utf-8?B?aHJYQUMwTC9lcDVwT0lHTnJ3N0p3WTM0RjVRam45QVR2WE5rWWdxT3ByeENy?=
 =?utf-8?B?M1Z5UEJhNnFYNURKZDh0Q0hSaVNCZ2Vub1hacnhJVFhuQUhDclJzSTlhMmRq?=
 =?utf-8?B?MUhISURPUU9jTVVFMEd6SGljTTc3UFpFVlgveThrQ0dDYU5JekVsamk4U0xL?=
 =?utf-8?B?cTlOOWhHLzJRQ2ZRRFBIV1FCRmRyMENVUWNwR08xL2IwcWV1KzNzQzhsTmJF?=
 =?utf-8?B?bmxxMzBhY09wVmowSE5TdzArNDhkSDdPWUl3RndHTGV4UGNpSFZ3anpsUVFL?=
 =?utf-8?Q?oXLrfKSCTcZs8wo0hZ2QPYE4zYey3hD3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGdMdjg3STVQTmFiaWthT2xTZnpuaU95dmtEbFc4bFhFK2xtTE1mUVNLNThJ?=
 =?utf-8?B?Z1VudVM5Y09KZmNHdHFGNS9ibmlpeTUxL0tyRmUyNndmVjdibEY5SUFhODE4?=
 =?utf-8?B?ZE9XakxWOURhRXBtbWEwVU9YUHBTWkhjS2loZVZLbFBlL2FkeWZlUjFGcTY1?=
 =?utf-8?B?d041bFZHeFBFTkNVMGtPeUJJV2xOZ2M5K2d2TUZXdUx1SndmT0FHbGhLTE9m?=
 =?utf-8?B?S2VETlJjYVNORlFUYVl6MHFYRGhpcm15a0FidmRTZjVjWmZnOGVobTVPMnd5?=
 =?utf-8?B?WFB5MEt4ejNIS3V2bGZ4ZTVUZnVUdUZaN0VTcUcyRFhMN21VSmZ1ZXhQMHVF?=
 =?utf-8?B?K1hVV3RsdWJ4eVZ0UzNxdVpmQW5FdFpNODdqaTFUeExIQTBxRGZ5czZqUmdk?=
 =?utf-8?B?enVhZldrVExaOStOUTgyZlJUZWRGSzIxU0tNR3pGWHRlbCtOR3JxdmVaOEt1?=
 =?utf-8?B?dzQyZnczTmxaeHJ6QXZIZ3FNVUlCT29SY3BLK2lDNTBRM2dqdnl0N3hjOFYx?=
 =?utf-8?B?SlpRKzNwSXgwVjE1VDBCTGh3Nmg1a3g3LzZGZVl1OW9remRyMGxBMStFVFhr?=
 =?utf-8?B?d1JPeWNNVThUM1JnVVpzclFsRWlscG1GWFIwd1dnZTI2MzExaHU3aHQvVmhp?=
 =?utf-8?B?MzhjOUNKMXVrdWE3N2NaUC82Sks4K3p3dHZ2b0xrNkZBQ0QrdmdKQ1h1Mnoz?=
 =?utf-8?B?amFXRkVLV1B0WVI2NE0rdXh2Vlh3bVhnRnZkV2M2Z2lYdWlhQWVlQnpqRjky?=
 =?utf-8?B?SE1VUXlDT1NhMWlhWlZvcWw4RmdhZlN2TFYzVkxsNEdnOFBRbml0U001MDNC?=
 =?utf-8?B?eE53V2xqempIUzVlSFlDS3VhS3AreDdnekhHTUd3UndwMVhoaUdaNXFpK0Nw?=
 =?utf-8?B?SHl4NjFCaE4wSzlvUXEzN1kwTlVaWjJuYkhMS1dwSXZJREROMEdqNklMcFZK?=
 =?utf-8?B?SGdtZEpydDJ5cmkycWt4MTlRTTJpamkwOXRvRzhxN09hMFJ2L1UwZ0pZaXdQ?=
 =?utf-8?B?QkdsaEtOb2xLLzBnNjYzTHNEZHhINHN4RzNCa012T3ZjTzFVWjhyNy9CRWpi?=
 =?utf-8?B?OXl4UVkvVGZzYTg2akhPZ2tOUGhOOTBOWExTYk9rMW4yS01sOHZ5ZGFpaS91?=
 =?utf-8?B?aTlQUHdtTHBoSE5VK2YyYkZsc0hTdWpJZFdFZGFnNWJSZk9DV3hjYXhDSlpY?=
 =?utf-8?B?anp5VDZmRGNSVUt1Q1l3aG1LRkZ5T2JZNG5WOFVBK1NYLy9BNjJTUHVWVFdJ?=
 =?utf-8?B?UmFiQit0TlA0alQrUnNQRW4wV3pkc3ZsMXQ2cXg5VndoeUpENk5kRFhiZWUy?=
 =?utf-8?B?TlhnZ2VZai9FUHo4ZzVVdy9JZmd3bTlkaE9KdzdZNWIzMzdsc3E0enBZZ3d3?=
 =?utf-8?B?MnBqSWR6OHZHUUEwbGthaGhRSW5wTTNkaEhEeFlpYmxNOC9HYVVCaVZjS2tE?=
 =?utf-8?B?K2Q4aE9LbkFHZ0FtYm9YTjVRZ1dSQlVIblJKQm5iZTV1NmFGV1JrZXZ1QnhG?=
 =?utf-8?B?eFI2WS9wZ3RDeEpxNmtsTEdjenZ0MUE2M3ZjV2tjMFluMnJvazJTL2trTmV4?=
 =?utf-8?B?RHNEbkZuNHdlcG9MTzZFQVlqYVhNRk51SVZ0ZEZXWDVaQzVmcE00dTJJK3l4?=
 =?utf-8?B?TmhKaHkwaldRS3pPbjFRY3pqK2dqLzNWRkRDZWJaT1VQaFEzVG16ajA3eWtU?=
 =?utf-8?B?MVUwMVd1dzE5WDBFZ1hIOXcvSmI3TTk1MFpya3hYdW1CMWoxTU9KSmxweldW?=
 =?utf-8?B?MnlCSnF0NnNpVUwyRTR2cW5zYUVJWDRGeVR4blhpUWdwR2g0dWVsLzAwUytV?=
 =?utf-8?B?ZHFZbWhnT1B5MEtxejBVa2lHYlVrUTNlelB6SlBvTlY2MGZubWhMdFBuSlln?=
 =?utf-8?B?OEJZZGNYcW03RlZnVHMxZExEY2l6djNwMk5hR09nS2tNR3BjS2RQTlFxdnNo?=
 =?utf-8?B?aXJ1Q1hyeXFxVEZmUXhybGd6WUtNais0dFlwQ1JmeFVETGM5QWNRK0J0Q0tQ?=
 =?utf-8?B?RUs0Z2x0UGZTVm5DUFlXV2t1aFdDa2RWMWRkTnlOdGIxN1pIa1ZPd2ozUm9z?=
 =?utf-8?B?SU1ZTWVvcnlHakNjZmpRbGxWYmNmOGxGbkFYek11UDZuaVpXT1Vva3ZwY0k1?=
 =?utf-8?B?cnNvcVN3RUxQMU5Ba3RZOTZtV3pUU1NRSWNDTk1ydG02cVp5cGlCeGF3dW1q?=
 =?utf-8?Q?zfkM4DVka0tAKFE6wre8qZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FAFF93E6AB95249AD354A3EE0497C40@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pFN7yxzlA4Uyde9IrU8cMdHBZTuOwC5a6BXQUY9S+tWhMH1BcICgldNpZl1WYfeKmI6zyEnd4OvrtFmJ0M5tOkdrpqDOCunGxDbapQ5QASP+fo/uqArXhQ2TTVbk81pvRvfZzLh88wGy28DbUjtppMqEXtFSOe5yFRuwTQsUz3xfucC4E3Y1U78E8G2l6MvDq1wkGrK/vsJdhImHpvYNIqaOVbQdPosoarFpM4wj/b6B0Lpz7Z312x5a/eWdK4iilPkM0qHbk11dhqjSx8Zv6pLw/wlAbVE5r3Dhh2xHFzubghH5JzGtrt8lKzl6walrNNSiVq2Wg871SLbwOWDdQulOjVx/tdM2Um0D0YXnqGnkp20SO9qJ/dylkOLNYiRlD11bol6wOY0QNtuDoVP9kol+VsG9srYd6x2awpfgeifgrDbZhiWU31Hdbq7077JLqV0UpK42lnyfNVdtsAW+nI/EFQQ4uIN4C8ZOi/RaiOl9W2HO/k3OsT/iR1hMUABYgXnfmj4aaa42+n2Ku9TiLyk988n0h6MFbvuJD+9UxVTIrAfHh5R4RJwEGqEwRBOfBzrUhPqkZ9ft1P/3CZpLLeNEkU8Vn3IvT2XZO42p/j3czbBHuZgbrXdauLsK3c2T
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287f0f2f-f4ed-4b34-e49c-08dd685db8ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 09:49:49.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRT30l/rfBvMgllDpPb/BvZ114VGEik47jpz3KjNMXTsIPjqchB5rPkdBOZCqwtBNaaaTxy3yYoLTh1A6q1Tf1OqvVoZh5QEr5Bu819kRhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

