Return-Path: <linux-btrfs+bounces-21917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ7vObTenml9XgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21917-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:36:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD5196963
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EA9D3109B13
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E946135BDBC;
	Wed, 25 Feb 2026 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UXGOutZQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mp14b77O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3735B137
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019131; cv=fail; b=suKsC5CGFqxPS5QLuZLCdYSf5SHKyXsKWtInWOG+LI+meI0JWWk1uT0BdqoNosYShM6cpEEVamI3Y3nXIZz8ShmJxZSFtoaqloFepiBKPJEbTSnapokE15OXvfp8Rx6YDMN6/sKHz/gtuAEKfiDWRZgJiABle6Jm/rfyNlXE1Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019131; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/NDQKCyuuBaHSF5t/HrgEgPjrhGWyoX2E1f3RdIRNA1dHGHQSinjXKxHXmO/WXuTxlS73/rxvNJthMGFCkUmAQ6P9ImTffM74GPUmEeQvv09n+iWtIm2xCjP1DY/9JdFZgyKWR54YNpSJl+Zruy9oobJZREvUmAArl9LhSUHFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UXGOutZQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mp14b77O; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772019127; x=1803555127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=UXGOutZQPSYnM+XqYsB6eKpR/sSZAVjjfcQFsLqVLQ8qEckE2499TCOz
   z5JOoF71NJVIFaJNzGjmw7DI8XhYSpleLNfQOOf9azQES8e5fWU37JA8B
   dzPm6Mc+/cCtBd88T/0vm04UepWfJy3AS+27FX2XF2NVZaL8azULLgPKT
   fiAktLLhnnwaozQ3uFu3ZCTJXIuACYYsCOFGDRB2PYIi4B6cjhULxqQRc
   lUn9GOZaonb4IJgu7qqgNcpf5yKEaPk589fEWerh/Gbc1flwXONPgWzPU
   mir1S4Sg9Lky+/Oem1nTiWUozkbT2wyeDm/+rKt7+nIq9AnlvsknpG0LA
   g==;
X-CSE-ConnectionGUID: dPIL1+BZSI+qmFp/YrbpdQ==
X-CSE-MsgGUID: i1Zd+su4RF+WAbIc5dqL7A==
X-IronPort-AV: E=Sophos;i="6.21,310,1763395200"; 
   d="scan'208";a="140488069"
Received: from mail-centralusazon11011019.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.19])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 19:32:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhEALqgm0JUu3ieG4crzvziRr1lEYhpU4Kv71ZUaMZXHE5P3EbxUMTuxQQVb9kxW86JQeXda1itMpRj4KGbNc4SozYEa0104OF6ZYp74DFI6f7lKGnx9SMngfsxdPCAd5SAvYMCwkNK3jup2u5qpOJ+Vm6Y3kZqdUt/vILOhiFG7B57arbpRaRR2Up4S3G6WKMBWjoZiiDvFwSir1rwJviKm1FRxwRG+ZcM3xY+OZ/ZRr5F7eWG4KM2jgiDb/2Zcamci4m2/A7MYf1WTsfhRISarB+yQ7CKTW4H80dyRzCoeYtYQWRKQPDyCxmJKVBOvmQ1w5EJMK9Nufqd8Mwj31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=HTPIl9gAMEzEL6KPNx/CutP4Cx2MlD/sxsjV4LdmEMl3x8JfpfLMl4bPWSE3uZB2DFXWUhsNpo8qYk3pz4dAcnAdRvi6nbaofAk1UU0EAu9WD8MMUfgiSvBXzlYIi1uYpDtAHWadOX1z6PADG05P6DtYo8sXElnfl5+ulBgtpeKyE+DVslKiN0RnZ0WPAGWroxzuIRoLvhAfNY1Bf3EcE8mRs7yY5b9UxAFicrQqCEjjCnVcrT2E7vaY4YmnzUV77ffnCHOdew1MUhyBHETizUbjsTnAQVXz4h84tFkmF9OY9IICqmuE/K3K/P4LAMDo+Z07CvW/kQEKt/odFtcUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=mp14b77O8N/vP7AxIKs25Xn9hEqSdM+nIT2Nm8TBag35Pe8UigOBD+HhQyim7sZMM+vOnlYakluc+DBGDQyxiFSqFQ/nljO4moeJBpL+I1ME1zFExtQ1mVIDxlRx5OgF0YXUx7nZTQ1n/sq5QSdcBwG0JQxrjoK8FSi/0U0P2oA=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7471.namprd04.prod.outlook.com (2603:10b6:a03:293::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 11:32:00 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 11:32:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <mark@harmstone.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "boris@bur.io" <boris@bur.io>
CC: Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: read key again after incrementing slot in
 move_existing_remaps()
Thread-Topic: [PATCH] btrfs: read key again after incrementing slot in
 move_existing_remaps()
Thread-Index: AQHcpkMXRLQoPf8T70+apn9GJOLnY7WTSC8A
Date: Wed, 25 Feb 2026 11:32:00 +0000
Message-ID: <73231e55-9854-41e2-a871-3d3447e1fee7@wdc.com>
References: <20260225103610.18494-1-mark@harmstone.com>
In-Reply-To: <20260225103610.18494-1-mark@harmstone.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7471:EE_
x-ms-office365-filtering-correlation-id: 5dae2033-c5fa-4468-c0c5-08de74617e01
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 RD/BBDETRDNy/1XtMcKCRJTR+odn0MA9g+hkdnDHxyaPNk/RF4t7DbcLoOB7fFcqUR8dugyEK9XRsoIkbGuvkJBgK+62tCoq9yOF1POeB04/BqHKJ/ujAQs+B+qhkB5AJQ+FS2UQmEyEHXuqGvqOb+E8BKJB3XROVLnM8EYcKtZzWIf9nmce6Xrba1lCSJ5u/NPhQECV7Rn99Hx86ExB0jm3EL2QPDcCDt2cxYlYInUYZ2csZxju3qoH2cDCHwNAqvv67XDritnnstNNAzAGavnjx7nKjRNb0NElXdcrpCCWsor/ZBiQp2f8vTdF3LThS3CIjlVcfMvxrY15vXlHumPCUIpZHGLds2md4PZTwF1SgpANN7dg+sImXyb0/lq+YcQ0r87xVE3lmHHIkFfUzn5b8H7IYc7Ohd7UpzxZkNIqXluNYwOfBt6twrq+Eukw3N0P3AIL4qf+T5jB+vHdWmLH8mUaFkLqoLVmV/CuMAaIm94OqJm2AWmxdhgaV07SqWnzvu5+EBFboNLmu0y/pFi0sAR3+ryZJT5n3rh8ww9kLicC/QqHRZkI5ZYGyBKyfFi0SSjpppNtc37XM97f2/611/YJsInD77lyEXkl/0hygzX3yt6oT2RucmI0h/MPYRFNJD2GnyylB7GlkDiFeeJM4Z5skiWYjN1Wl8aTMyHMDC0dog1xHC8dRKeiz63nxiChDiAgJft97HoQj1XMTspx4f+t38WTKmGumrD64mmcjE3LP9PbTA7bscyaJ+puKkVOd+5B1WZIVDOrJhKwa7WG5qqh42NDKWOzurWWIOg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlJEaEF6bStFRzYwby9FR0V3REwwbDBYMGlXY0JTYitCY2g1SGV3MS9nQ2ZB?=
 =?utf-8?B?Q0w5dnRrSDFDbC9Pd05CUjQ1Y0JrdEN4QThUREprUnVSWFpNUUpQVzB2V3JR?=
 =?utf-8?B?V01LK1JoU2hNQW42RU9FZW03ZHMrL2JTM2ZTTkw4QkJVclNzOHRmT2ZOczZr?=
 =?utf-8?B?WE9hclVKc2c4NTE4VWVDRHdnczBkU3JKSWRGRHBtYm82ZlJWYWt4WEVlVDg5?=
 =?utf-8?B?YWk1RmpDdjlVc210dHNSY2hJNGtEZytsMElPMmhlb3NBQkJPVTBWcStoTVY2?=
 =?utf-8?B?T2pVaUFlS2sxZXVyd25ROUljYlRRM1Y1d0w1OFM2cERFQ3JYNzc5NmdDRUlx?=
 =?utf-8?B?M1diN0Ezd0FYdWJWeWE1QTJhOHBqT3hIYVdVSXBQdG1mODRXUkkwZ28wSmVR?=
 =?utf-8?B?ZDYzVzNVSHJwS3hlbWJ6S0RnOVBBdGxSTE4xK1BDejdtT1dWNEJPOVJ5bG5t?=
 =?utf-8?B?dG9YZGxhalRlODFBbnVrZWZTNGQ3eGRIemdLSEVDRWxtMzdqOHJBV1YyL21T?=
 =?utf-8?B?ZzF0THY4ZWdtZW93RUNUelpHS2lyd2VTeVIwbng4MGRZUjNVOS95TnYzY21Z?=
 =?utf-8?B?bFBuRzY2enVsYmxvY3pyMGJWMEVjdlBBWDlTZGZENGk0V1FnU3NsMUJCUzVn?=
 =?utf-8?B?S29YZ0FwYW9naVVNbHpTc3lBaTN4dEdGc3hCclZqcU8zcG51Znk1QnpGdHU5?=
 =?utf-8?B?VFM0NFJDSFdRbTZ6bzczN2VMWVZFUXhQc3FOUkZ5dmpVWDNPaDNqWXczb1Ft?=
 =?utf-8?B?VllFN2c4Vi9Nd3YxSytjWm1iUFZpU2JETFlHb2JpRmExTVNFQm9QWTRCUzU1?=
 =?utf-8?B?Y0FMazdwSjdXcGVkQXZFeEtwYlQxYnM0UE1HOUZhbXM2WVd0ZnhEVFY0SE9w?=
 =?utf-8?B?VHpveFlEdmtiUnQ4a2tOZ1RpK3d6amFWKzhLb1BZSktHelJJWkRHWXZ4K0Iy?=
 =?utf-8?B?K1lIOGdQUzNJS0NWZm5pVHl2YmRoT2pkZU0wdDllOFZwb0VDMktlME9INExk?=
 =?utf-8?B?SGZzdVRIMm5ES08zdUFmNkxKUFdXRWgzbWcwNHNicjZCb2twWVhaUWh4YTY2?=
 =?utf-8?B?WDltUkExd3NjcEc1NEZpeEl2Vzc1ZDQvWTd3Q2NRSUZVaEx3UkVVNDNGbGdF?=
 =?utf-8?B?aDVQdnJNRE96OEhoUHdwSTlnZmlnblNjbkZUOFNxczBrSjVEWG5wMDdqMFp2?=
 =?utf-8?B?cXZXQmQrNjUreEo2MzR3K2xsUDY0dWh2STk1cTJTOUk0b25vN1ByZitLYm9L?=
 =?utf-8?B?SzU5QVIvV0JaMkd6Ui9OVEQ3bWZDcEwveS9CNjZQTW5Yd0NaMzlqd09ZZTFS?=
 =?utf-8?B?eTQrVFYxeFZjRWtiQTRLSW5BcmJPY3JScHdMdmtYZlo1bWw3WkEvQy80SkUy?=
 =?utf-8?B?dy9zc25iUU9wZ25ud2JBOVJRTUxOajhJK092blB6d2hoWGRvcS93eG1qRGFY?=
 =?utf-8?B?a2NCd1BxMWtLVDNlWlhVQ01TRlJVVTVzdjBkNU5NUzE2WGlOY3M3bzJKYXly?=
 =?utf-8?B?WlpKOVowZTlmUGl4aUZyN1FBNnR2TS9YYjlGNERrTUxvRFF1ZjN4aElMb0FE?=
 =?utf-8?B?ZnA3b2tJT2lYOXRXVXN6Q25JQjdGUW5SK2Y4TUJjY1l0cXRJaHZ0blNIYVll?=
 =?utf-8?B?YWY5dkh6cHk4RkNHc2NZREV5S3ZVNjFYQXJYWnRETFhmYU0yUzE1UGd3Rkxz?=
 =?utf-8?B?alpkdnNqVXpoUVY3RFFxOXZkMDZCSVZJSy9sRFpaMDltWWJ2V1dxbjM3SEVw?=
 =?utf-8?B?VnZGSE1FWG9RZjYzYlVTdFNpaUpYNHF1V1BHdjFMaUVURTFidnFXMGNkYnhK?=
 =?utf-8?B?QS8vYWdRQmhtbDBRMk50cFNLeGZYSmNCdGt6K0hlOXA5b1ltcG9mblFaRzZL?=
 =?utf-8?B?cTVTTU01NUZTRlV2ZjZjaXVwb1ltTm96QUU0T3pVR0RZa0dENWtic3BxVVJ1?=
 =?utf-8?B?NjROR2JCZW5sQTFHVWtSOEpzVENxMFlsb1ZTZi9TZStvMzArSVpuY1VHQzRL?=
 =?utf-8?B?cUh2Y2VqY2dobDhDT0t3SFliR1Q3aVp4SmxLa0lCRlE2bmtSRG5GUFZ5R2pT?=
 =?utf-8?B?MmZDWURTbE1aeEtpc3lwMnoxTTlJZEtDTU1XR1pLMGNmTU4yUTdadFZ0TlNl?=
 =?utf-8?B?YjZzd1hrL3dmYWVLMm50aTdWLzV6TmNEdHU2SXRJaFRTWFlXemswbGNnNndv?=
 =?utf-8?B?bkdsRTByU2NYSDFEUFhjUUtYT2hrQVUxNEZJSWRvTDNidSt3VzZQUVFTU2NY?=
 =?utf-8?B?WkxmamQ0RStHU05EeDJhNnpPZGdtdEJldHkvMlp1bWdnUU5YZUpEQTFuUEcz?=
 =?utf-8?B?NGpyZHlCL29zaE4wMkU0Qk5qY2xHNXJESVp1dnlwclYzVVlyazVTUkMrL0du?=
 =?utf-8?Q?y/XiD2AMX37nmyytc+yAYpll+NAU0aKjMZXBG0FOzZjnw?=
x-ms-exchange-antispam-messagedata-1: +duOIQT5xzE3cYdXeBN8g1hlB6m0hBqN5i0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCB4B9720BF50248BA2149947813554A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xn2OK9TFAJmp1FZjWBwLKHP9PX+zEzCr+KtKQK71OfSpGBKzILTfqZod1U0M1bNSUjBIcySStqeazIc5g9sDOqdCdMndT9bNkt5TPqcOxZ3om5qXpkcT6+MxFTzsnUZHUzIgQxPBOe+3cq/4xDjn5xsDjzGs0MCFaJpYMI/HSERg8fgR+b/LRBsyx6VZZ1nst/k2h/Qr2oj3SQETt0KHO5RGr1t7ABm27FYIZ3mVDc1Z1SPRlDxUXjwlbnODc/oob4U0tdBLPH+WZ1aJ0MIkznuObY/vmr1LL5R/MbTPV4Ut8R/ER39MHeesFJgyiabhSgMjkD2MKhKeqsuK2z6IeBwNC8ciHVO+0p4PevbxonNfMzWdfG3mphOm7n0y1nhp+duREDkgrCPn9UVO5yL1hA0jqjck+iotjqUvvA/bZ3Z7Yz9DLfTSR5QnS05VXhzCiYkaS2fy+8WOYO5gclHiGffEXo6osPAFG8mvLmHE/7WJ3EuF10Hdsrk8N8fA0Im4X4ZXRI7gdczQZuNO0/8mWpFA2gcmfVsh1ZjLR9WGtQlZ+hrzqWO0Sh9oYRhHCVplmRkMLDElVqMWAaHsIRlkHdXjf/pC77tUDp74vtNRn5yG21ALUs3VIrYGubWOuuxm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dae2033-c5fa-4468-c0c5-08de74617e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 11:32:00.7578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37XHv2fx+XSUcaOLrSvJMCRSMD1A1KAiByh+ePUSKZcsyTV6UZsFsZd66/TEE+e0pFr/datWzoBOC0bvSkgBDah63UD4fyN5TPObJJ+1yts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7471
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21917-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,wdc.com:email,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 65DD5196963
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

