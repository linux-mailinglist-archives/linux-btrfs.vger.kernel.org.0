Return-Path: <linux-btrfs+bounces-17665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2DBD1B6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 08:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E107F3484E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 06:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003AC2E6CBB;
	Mon, 13 Oct 2025 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mYGGjAu7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LfXKe9TD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91498EADC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760338453; cv=fail; b=u29bhsiiJDuK8uqXKgJrKZKdYL5B6VT5eTDBw5O6v6pLwwFiSmGDKx/FMzy5apQmvERHZvHCFjapNs0ge0N5fwcX7D/kv1FWeVVT+5nfaOtBX0Vny35O9PVqt0l0NbmjA8lVY7p7rb3kbhX1bUypI8AbifPYlKysCa5e8D6kKfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760338453; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DvOfFPvba9DaSTa5+oRUs0kjUiTOT6jRXYBmJkfZ6C97nuoYRPPUbrAWpENKd4AGEOG6ASxni6UTeq9HGanCz4PTYDidybrZwtCp6cselMPI3hd/DuK6HfVaSIXPVMtsxd09UmrIxzYnWuWV33XArPWgsYdwScV3ZM1Uhg2hOPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mYGGjAu7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LfXKe9TD; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760338451; x=1791874451;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=mYGGjAu7Jx5nVBmdpOMjJnlT+OdAErGRFx4vvIYStpoz0KGU3J6LPG7u
   cQgXzbYqZTdiCgJLOyj6Qie/iDJJY6OJ3T4bc8hAqmDUL6rtQWIDEHYdZ
   RK+Ykhx6Ylguekw8CpDJ9ufP5LuSnIkdwf0vqos1ppoAjASLbqDQZ+hQA
   U5zYti+NeATud/0rG04g0YTjtTGsFqEee47v4ulNs9LCAH1gKt8E4iTl/
   R1BGk9hiigN3yEtDhRxlPmYKPD8bRCEHQA7UbztaMR48zewNUhSS4dyJn
   tBNK4bqxJ9DlPEwvfnuXQ6GkTKNnBsPMvAo70YCeKx+S0lTLqFc5ZQA9N
   Q==;
X-CSE-ConnectionGUID: 5oQd30ImSOSvdUo83kQWYg==
X-CSE-MsgGUID: TBxb/A4URaaIeqTIOb9mBg==
X-IronPort-AV: E=Sophos;i="6.19,224,1754928000"; 
   d="scan'208";a="130102391"
Received: from mail-westus3azon11012047.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.47])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 14:54:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMwW7+X+AEyApzTuuaonKphCeRWxDTyD2gmnusgIdcAr7N0Yc5kFMNgAbGrBQgwWxzz9Ke2uXVQBdIp729qvzpshkheybcgX1KTk64zo6TiK1xT9vrQ2v5+TxhVZIjC+oa3KfvsULPJBroEwUNoDizK7hAM+2D76KWNRrf769c3aZC9x9zNko0iP6DEjG+mSSOA+YB2CiiElprj0GGSQhrtD0cqeChFBwyozbUHtbGzNxP4O4QW0PbmdBfJ11OcLQQ/FakdL78ZEdT2IersLsVBfnFs52r2fzSbTVcr2Sxx6PYLlc7YwvIzlPRVdasMaRsXNL5yt0d+Ccyx0G3W7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=YoPCJzNgrIgNhkrrJ/EVfQVySUT5m+Moe3h4I9kAEhAUcqikaxqGjkHBKCc9FhQJ0vQO6Hrc2Of+1ViDvGQcwVzr0CPe76fsknz3pIrC5Lp2gsY+vaTVlYMXG/q5ONGlheJUcVO8xlb2jDsHhqwoaRSGJPOUESd6yDVL80l3cxn82N7Q9caWST+RH8YKS++YZy44Sh9ZflBBSDDujwneH1yB4UgTgsTVG2Ypm7r5LemsjgYN2/5wIylMrtIJmPvu0Om8w+mYBVFRbm0UforGRt84m9jW0kdqlsUIi85maKR/q5KLtvY8RumLRynHqIndJoEq/kOgQy/Do/bpifUHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=LfXKe9TDonboKTOw/K5QBybLE/rgy8K4Doy+U+hj30ZptX+wuXKjbM5FGUFehHg80PXWCr1y3LqGzW++tOgXIpcMLNsTEtlumoATBcdH20dloLI/Gro6FnaWQae/zYwsCKg65TsX0FurvIGUOwlm319Rbb/GasYvAmU6p/6+RIA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6646.namprd04.prod.outlook.com (2603:10b6:610:90::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 06:54:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:54:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] btrfs: implement remove_bdev and shutdown super
 operation callbacks
Thread-Topic: [PATCH v7 3/3] btrfs: implement remove_bdev and shutdown super
 operation callbacks
Thread-Index: AQHcO9NSVhnWw0RU5EOkUBSb7n+NnLS/pKmA
Date: Mon, 13 Oct 2025 06:54:01 +0000
Message-ID: <17d91055-ec8b-4c2b-ba7b-9901e9749b26@wdc.com>
References: <cover.1760312845.git.wqu@suse.com>
 <ff8b34ef24508e6bed6f7a5b4cbf052c3e33749b.1760312845.git.wqu@suse.com>
In-Reply-To:
 <ff8b34ef24508e6bed6f7a5b4cbf052c3e33749b.1760312845.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6646:EE_
x-ms-office365-filtering-correlation-id: 57723e07-4d5b-40c3-b049-08de0a254adf
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWRtdUNRREcwVTNqOVF3RTQrdWhzQ3RFRHBaVG1NNzlIRGFNcHhFcTduZGpN?=
 =?utf-8?B?YTFQZkVQRHZwNlh3TzFYMDd2WDR0S3doWXVIZnhnQUV2R2d6dG9QcTFtTXE4?=
 =?utf-8?B?NWh5c0dWbUh6SHlyNG01T3FNV3ZCWStQK1ZqcG5hWGs5L1BVSEVFRy9LenN0?=
 =?utf-8?B?NmFweXRpVzNRQ3o3U2ozeURYME5YaFlCbU1NYXVWZXcrQ1JKZUlidjNYOGRK?=
 =?utf-8?B?Q1lFYzcvVFh4Y2NweTFQSyt5UDJ0UWRuS0dFU09tTDcwTWxoQmduMG4vYlly?=
 =?utf-8?B?TGk5cFJwd0wxL002UWI0dThJaUtGc0luWS9wVzhQQzVHRTlxMjJveHd1dmlM?=
 =?utf-8?B?U1RzNitiZDBUQTE0OHQ1Y1l3bWFhZ0hhVGpCUWhSUE9rdDNqU1ZxVW9QakFm?=
 =?utf-8?B?bVI4UzdRSFFrdzl5MFI3elJUcFkrUFRWRDRlcHYybERBdzlEdWdjeTZaR0Yy?=
 =?utf-8?B?QWFLSWlFZ3Y5MkVlS2xGMVIreWI0RnRoTEt6OEdiYXMwRVBtOFZPdkFHWm5m?=
 =?utf-8?B?b1pGQ0FaNlNjenhyeURzcWwxOW1PWjlKQ1g2bXplNVRQVVI3VDJuUDU1WkRH?=
 =?utf-8?B?QTNaVFJNdnhrZ2JpcE5Hc3NKRjAzQnJHdS91QkV6VXF5WktHa2lrcXE5VkZ6?=
 =?utf-8?B?dWRndDF5YW9OcldadEx4ak9jQTlqSnR4RXVhcXhaWTFoUW4waXdpcVdmWnhu?=
 =?utf-8?B?ZmFEUWFkbm9NYjJGL1dLV0RGaFZhek8wdCtFbEd5RWYwd0ZXQVN3UlIzVkh1?=
 =?utf-8?B?Skc2eHVDTG5lSG05eXVLbjhrcjVMUER3OW0ycGJqNDNJUTZCek9Jc1JJM1BM?=
 =?utf-8?B?V0cvOWZyWnRndS95WVlBSHhzdWFBQWtyaWsxWmJnVjVoY1pmU0F2QzNXS2tr?=
 =?utf-8?B?L0g0b2N3Y1hOdmhBMWVHQ2lMM1RyQlUzUThXd003cUlXVmZhQ3EweFM0MTBV?=
 =?utf-8?B?c3lrTTIxamswRXAxSW5wTFJXaXY1ZUlIN1ZXVDB4d0RDRFFGZ2VnbjYyNUJF?=
 =?utf-8?B?WENQdVJpb29lNE9US1A0NjdQcEJ1N0tuSTVhQVkvTGtlU1R0b1hyYnFZcGFN?=
 =?utf-8?B?N3Rtd3NMUktIOGxDM1FuTDdLTnJJLzZjeTFROTVhekRqSFh2QnhibHhwdXRK?=
 =?utf-8?B?UTBqK3cyMEp4VG9jemJLUjE4cTRKMnAvNmxVKy9ncFR4ZUNmVVJ1bHZRWm5T?=
 =?utf-8?B?Y241TVRPalpRQUZHOXhpODFqcittY09rWEF0TThmbjVuM1hrNHB4emNCaTEv?=
 =?utf-8?B?OU9tNW1GZVNZSlJYUDNySHNXVGU1SzZheGxzYklNdUhGK2Vidjlhd09KM0Zj?=
 =?utf-8?B?MjY0NW5BYTRWRmx2YVo2R1lJTVhJZGQ5ZWw3MlFpNkJQVUVsdzBFWHk1NGZi?=
 =?utf-8?B?ZDA4Q2piMTJCcGdreTkyQU9SS3VLbU5WaXAzcloxcVFhOGZtUmswelBUNU9w?=
 =?utf-8?B?bk9JNHZ2cjgxMjlncTRBZndCYUZHLytCL3Qyemswd0tqOHRzTUFtODd5cW9D?=
 =?utf-8?B?VU0ralhSL0p6M2RyNVlFbitRcmxOVStvbFJuL1Q2Y2dwNWdGZ3hEdEs4bnph?=
 =?utf-8?B?dDNLazRSZUdwVFJTOGVBVnhwdXM2aCtleEdZY2h4MlVWcndBbHZvZjk5RE55?=
 =?utf-8?B?T1FsV0tzcCs3NVArL0pLK1RnYUVYZDdWNnZMRExLejBMNmtiUnlXaW9wMG54?=
 =?utf-8?B?K1FBMjJqZjFieUtzSnJQa2N0c2h4YjRuTm9uZ3hOVUVueUJjSU5Fb1REalZN?=
 =?utf-8?B?KzN2OXExbXFqdWcxemlQQTBuOExvU2ZQYTlRRUloNllpd2hiZWZwQ0ZTWW1M?=
 =?utf-8?B?amdVYVM3b3pVVGEwbkNmWENGNkcxVWdpeHFETVBWdDNYZ3lLb1FaNVlsbTVB?=
 =?utf-8?B?c1RBbVo2QzBOUTFGbFE0V1BnV3JIeTd5KzlrRnREMzdNbnpWU01QeU9FUHBW?=
 =?utf-8?B?VVVuWmY4WnFMcGtvRWJHZDRGWEx3bXdJVHdLN0dmZWx0TEtKb01YS0NrdFdR?=
 =?utf-8?B?VWRKRlZlRThwaDc1cnkvQVRWelZPUlBCNjN3NmxFRUlKdlhlajY3bTJsOUpv?=
 =?utf-8?Q?PMz4+w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3ZCRW9vWSs3YW5SenlWSU9tZmZXZU80cGcyWWFhMTNQWEVNcHlwcXdiYTds?=
 =?utf-8?B?ZkdhZEttQUZzVkZKbHoyS3plamEyb0hEaGMza01GMDFTZmhvOEE5akFKbGM3?=
 =?utf-8?B?TjlLcmU0aGluVDNRZ3NGOVEwaUx4ZEZYbXd1YVIxZ09paWNsTlJaKytQUjhZ?=
 =?utf-8?B?QlpSWWgvRkZKMWRNYzdFdlgvU3BYb1o1S2t3cWo1bzF1WjNWWFZsNkxLcW1Z?=
 =?utf-8?B?OGM4SXNIRGZ0L1BXZWRnTkJjci8yRkRHMEhYcWZLdC9neUtrR1NNK21yTG93?=
 =?utf-8?B?UnhINWphYlA5RDZvVFRUNFZQTC81dUZ2ZmRJK1R5Qkc0bnRCVFVNS0hWeXVq?=
 =?utf-8?B?VWR0ZEQ3RlF4aWlRY3NGMVBadkhpckRyRjU3MnFDYXppSnZkUnUzLzhNWjRJ?=
 =?utf-8?B?dHd1Y0c0cFNOV3J6cVhvamNORzg5cGxzUWY3RzdXMGN0b3I5STJsQ2NtWnNm?=
 =?utf-8?B?ZEx1dE5PUENoWGdKbG81dlB6S21TK0FwSzJNUDZqcjhibjc4Nno2ZURvRGQz?=
 =?utf-8?B?Uk82RWpKdFVyU1RxZVNrYm44c2ppbnpISldmODdwZjRGcGViQUpRRjNGZ1Qz?=
 =?utf-8?B?RzFNSUVUYXg5eS93TUQ2VWI2dFgreUFVTnpDK3Ixd3h5MEQ4b0ZjbTZhRTZu?=
 =?utf-8?B?aEV0MFgrVWRRWHAxaTlLYmxFQWZOdlBwd3MwVW1ZNWFlbTdFWHZRK3dRdnE2?=
 =?utf-8?B?Z2NJK2JuVFNZbTErc0VPOFY1cWNaQzNZbDRCSGw3cjRoNUpyL25SS0tHNmpO?=
 =?utf-8?B?K3E2Uk40QjlzT3JxYWRhb2hmeHo1Z3FwM25oRjQvYlFTZjJYRFpaYmF3eHhL?=
 =?utf-8?B?M0NEbFc5bkVhVUs2TVZ0SXFZcWlTSmNUaGN0MG5RdlU4aXRvWTEwaXdzWlBE?=
 =?utf-8?B?UEZZSGlhTWlyaURtZG1zR01FU3pobGVVcEp6UjRBN1UzQm1KenlDZGN2WTVM?=
 =?utf-8?B?Q2pPUmhETVJ6ekU3QTROd08zcjU3SU5RMFdoME8vNjFjYm5Da0l5YzcvdXlG?=
 =?utf-8?B?UmVlVm1PMm5PRkgvcjM4ZkdwVUovL3RaakRtdWFYU3JQUGNOYWNZOGRENGsv?=
 =?utf-8?B?U01xVFprY2xhbWtHQXM5SXRLdzVJV1AzV3VNN0w0Tit0Y0w3b0ljaktBRFl4?=
 =?utf-8?B?OXFQSmlSWlRRVHN4RVk0NnRUaXkwM1g3QnFxQXp2aVNSb2xyN09DdVRKQjNZ?=
 =?utf-8?B?eE9FV216L2EvSHFtclIweDFQbkxkMlMvNlU1Tis4VzFINlllbG85a3lqc0Vq?=
 =?utf-8?B?N0F4QWpKQ3ZpVEVVMU1RWmg5RjRxa0pTb1FUQUh3Y1hRbFd3bkVLS1N6d00z?=
 =?utf-8?B?UlFaV1VPRitEWFlUampxditJMWRuSWd5eDhLTE1HUm9nTTBtMDVUU3RaT2E1?=
 =?utf-8?B?Q2FLYWRxTXhROTl3MzRoSW5GSHg3Vy9oMzRwT0plVHpqNGVvMkRoR0x6WFdj?=
 =?utf-8?B?bTJ5MkVuNkliRHRCWXQ3OWY0Sy9uTnNZZm12SkZ0R1EzNW1YYThjSXpldmdF?=
 =?utf-8?B?aDBsQUdEa0RuWGdRY1FUZEJmY3dmUDhiTmdRVEFyQUdRTlNqYVk3YUhvMUlK?=
 =?utf-8?B?T25VTi9uWkZEekN0WVc1c1dBRjNBOWhOdndKSXh5RmRBMWYvSDBRRDVQUjYz?=
 =?utf-8?B?bjJtNWpSczFuc0ZiaXptVjQ5UlNwb2ZnUnhGSlV5M1dGUDNCbUpEU1pyS1Ew?=
 =?utf-8?B?UzVGMlRmakZlM3NRdEExNWtsdDJBdWk2YTJ5VkdwWGNwS2U1L0ljcEl5bk81?=
 =?utf-8?B?YklQeTNyNlRaaFZ4UGp5dmt2WVFKUnJ6RGp0d0NNRS9BSGhrRFQwaWxVNC9R?=
 =?utf-8?B?VnA5WkVXSmppTTh1SkExV3FNb293Q3l1WDJBVEppNVQxRU53V3BPUnBxR0c3?=
 =?utf-8?B?K2ZWelJpY0hoKytCUkdjM0U5aktLd2xxSS8vNkcxd0t5RnhGRjZMdmMvdG5E?=
 =?utf-8?B?NmVUSXdmNWd5UGVSR3NDR29uUHZ2bzIzRmZFQnRDN0RaL0dKdENzSVFtYWVJ?=
 =?utf-8?B?dnVGYWVSVjhaWm5ma1RtZTBYL2Uva0dJU2tVYzcwN2VoeEo1ZGRmMUJkak9x?=
 =?utf-8?B?ZWMwWDdzRUFOVDRtaGNldEN4eVhPUHBYbnhUbEtSbFR1VWMwUFRpQkZwY2RG?=
 =?utf-8?B?cUp1RFFaaUxqTEs3SHA5M3ZEWUpNNW5jaHFDVTZsTUNJZkJrODJQT1FuSVRL?=
 =?utf-8?B?RzVrY3liaUR0SGo1S0l5dTd0ekxYOTlsN29SdWFaelZXaFpUamFtZGxlb1da?=
 =?utf-8?B?R2lUOWhmdndSUml2cEV1cEFBRklBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89567E11C77F92478E4580A26D76A251@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	maYBhu/I1tKK+l2VrIO57eVnpsuSOAvHtWD7oMzIkUwh0aKiX+xRUZjKHhLV+Q2FvVQ/aiqGfsZ4etrBmYyZMicpc0hIgWpsG4+toSfwQerV9Sxj11ht9IYSglwwQg17FfG3TwwW1bWRhfXsJqZcxU8ChXGLCPFGuhQACPxs9tcoGPdYbV9Y7U/HIP0Z2IxBde7uvzydJjBHfyhn7mdwDX81sxzLMnHAgLswmF7I0/iBcyhnPYoeGtQypGWe/g7bdinlMwQiGYtqS4QUnuyNCXwRLQNYlkgyOCsqItQJAsZDKzFZpgC3w6qpEnuuiJbEkHLlIfoA/HcfZhGzFosVausVCzse63AV94y2sNDUqGEPCIvkLWF0eEuBLThAX8BAVBoBRIhRxp2aTZqhT8ZUfBYoXUFGyEe8SKtroY1xqajh4y264uvaHM/h5N7QG1wS0W5piwLri/UZBuYbx/Gwu8ZtA3Ur5G2bh2ivPm/JFEeiZHWOO89gXw9GmvILwmn7988rYBs91t9MZq773XAs3OSuLerQP0qdV5KzwHMbEq12MJ3P/Qg40Gk7fV7AzYOAgLwfOAMOjoRyI6kJf/DWRTOUOurNQDv1rEUZU35G9ZL4xcVLmKKdYnOoLvxKU/YJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57723e07-4d5b-40c3-b049-08de0a254adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 06:54:01.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S93qVAQDUnuCXWTH2hGM23CQWTymFRKJUYZQbhvccs1mFWLYNyGt6Ovg0rm3aT4ByQcFUpMmP3fGPqJC+5XWnoltgF4Rw3FX2BwKlnA5ng0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6646

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

