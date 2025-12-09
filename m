Return-Path: <linux-btrfs+bounces-19590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAD6CAEBFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 03:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E8D73027E33
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 02:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650462DD60E;
	Tue,  9 Dec 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d6tdcpV/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R/o8prp+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33019DF62
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765248189; cv=fail; b=Vv5Ekrb+3HSkhmxdXy+gu4EhNPR+BWX8RjI39dIsI/6e6vE90e7lYDdWzk/orOAoc4KVZQA7MWPr8He2+mrCI67ghQFH7RBTFexVjXOp2rSjk7s/UDbCsKgNOxPaOiMMiwaN4CCaEEL9pY/01Flzt1ME7AWt6MjTMm4GtYIppvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765248189; c=relaxed/simple;
	bh=OrzdW7oJv9YbMm8DGrDU7S6lCdDM9UTLzpzapAb35h8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1e6HAOVLH6leAiF4+Kgpyk1CO57pAFP6bkWoNEUV6aKn0nYn5FDTg1WHQ6zbJHL+5vJBXaFjA4P0s8sHd78SJ0tTzVTdR0Wha3BZx85t0h6FujIjx8dkNSWbbkD1ZRPVDa3hOo5u3XntBRANP6e1n3DdizpmTiLp3W7nreXbLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d6tdcpV/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=R/o8prp+; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765248187; x=1796784187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OrzdW7oJv9YbMm8DGrDU7S6lCdDM9UTLzpzapAb35h8=;
  b=d6tdcpV/aRCwYJ3fBOjHxdnPwzPuPEKl1/Z7nGMBjG5uQLuvW5KP5/CF
   4nnOSQej2qRJxU56o9Ba7+FPvi8nK+UIj1HpQqz5lsBIIXMSLkPo55yyn
   N7OpstSCVHXYab7SDcVAv+1N7Nki/i/NNpeYJbH9DRhjTofUFBjXLtzxe
   TbPK5+7u/3ExFaL0GhZmNHC7RAQ5oH7bqkJGjNTK5eg32Q8bTSM1f+G67
   Ly8beghr7TMzs2ld1ubr1nCyOr4cNkxtOZ9hKp8smgoE8T6ekfiNd+7x7
   EcmvuE0/kMjqA184ciCMkx874CMJqmz/FE06sKnM59YZ+eIJ3kLt/+1xb
   Q==;
X-CSE-ConnectionGUID: GvFLzGqfSqKBm+uWPk1yQg==
X-CSE-MsgGUID: PhbBFx8JR6aZe/E4SULm8Q==
X-IronPort-AV: E=Sophos;i="6.20,260,1758556800"; 
   d="scan'208";a="136681146"
Received: from mail-westus3azon11010046.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.46])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2025 10:43:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgR02XwlpusbG89hOX/CN8xbEqwH87JbeUegmc6PKG9+A/YE+uLuRnx06LlakhovuuT9j7glrxJix5JAkh7x/lk3tjgXVOviY6x8RPgahS5SUG2fNAtOe/B4oZgn1RY/SBmOWxV/ithv/LgP9mKjCRMNFo7fJmzsJ7FkIikx9LBsh5+zOYs3kQJNJINAfmlpuMlECaXBNufJhGiJidtmmssvdhkOn2ptNW6B2jPURPOB5iio1OYEODOUWTWewH5IYHGIo7Yi2Q+2CdByoHgxkheU2ScrTSOsZ6cDpfuj1fZpDnn1inB4vFHAyv5/bd8b3IhHqLxt1bX9fMqIjfsD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrzdW7oJv9YbMm8DGrDU7S6lCdDM9UTLzpzapAb35h8=;
 b=zOAqwvN8niW09JFB/HvG5h+0hKkA9/TWkfKug0zCtAQS8/wvcBRoxv4FnyoJhAoPxy7vU0eQqHegoJH8UENxUdGuD3yEFJLZx4raoM3PQZ0IrMKD7PKEfYS65LEj9Ax/Vvc0hXYuQiQtNLPoHZc7Rn+zSXyI2JOxQBYBzVSjdMNbfXnI5VEPhO0q50a9hhIUq0Olqphk00JV5H0hrOsGzXhxX0kqokfSj9a8v+ks4BYlSDH9mps0by7CbPjVdFWkCx+ouwFGKaZSn4oU8YUjtPeGUNTB2JSYeoZzeYumCSPlB26PmCCUzeGZKEg7WtBDIqlpI5AlL1uCv1YeSz4O6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrzdW7oJv9YbMm8DGrDU7S6lCdDM9UTLzpzapAb35h8=;
 b=R/o8prp+Qq1cJs1vdQX1iDL+42GlizGsKDxvZovttBFJEFIuJL255YKUyAQb5wnpNXaE09UW0CSGgIc/zcQS74VDz+b6M6N6iUdJqvKMbAte30sxFHZo1YcVSVneMTEmGPPHpjV0z1s+AYb3TdXyi/J5++hxxAma12kJlfEae50=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by BL3PR04MB7993.namprd04.prod.outlook.com (2603:10b6:208:344::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 02:42:59 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::1f92:3bb1:1300:b325]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::1f92:3bb1:1300:b325%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:42:59 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, WenRuo Qu
	<wqu@suse.com>
Subject: Re: [PATCH v3 1/5] btrfs: zoned: don't zone append to conventional
 zone
Thread-Topic: [PATCH v3 1/5] btrfs: zoned: don't zone append to conventional
 zone
Thread-Index: AQHcZRt78xFDN+G+PkmjGjzPZftLd7UYoNaA
Date: Tue, 9 Dec 2025 02:42:58 +0000
Message-ID: <DETC95LLHSER.3SZU4ZNMKH1YX@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
 <20251204124227.431678-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20251204124227.431678-2-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|BL3PR04MB7993:EE_
x-ms-office365-filtering-correlation-id: 220f21b2-ba4f-4263-7bad-08de36ccaa31
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFdaZHBkRHdmYW5OaXAzK3pvNGVUV1liZUhwcTRRTWpqcXU0MUU1bXNkK0R3?=
 =?utf-8?B?bHJVakg4dUc0M01lUHg0R09lSVVuKzVaTGFEd0x4alNaMDcyUGd0dUJJRVVE?=
 =?utf-8?B?MTk3VnN2YnNQSFJQOUpxMEtlQkdMbnNFMGNvbm5IWHlDaGErcjJGZ1hQdkdo?=
 =?utf-8?B?VEJ5Y2lnR1VCemZSNndlWkZ5bmdJaDFXelR4R2NEUVZFNGptdU1rNFlRUlNP?=
 =?utf-8?B?RldiSjF1VGdGbEFGUzNlL1I5LzdBSnB3dXBjWDZka0ljWVQ3RmcvSUdmdld6?=
 =?utf-8?B?S2ZpMkFVM3VBc2tkU0hSTW1Tc3FFTFpRbzRIM20rWG1ueldBWU9EMHdEc2Nm?=
 =?utf-8?B?RlBjc0tsUlFubEQyaGlDdklBeVNxVlNsdFpVdHA3bFVSYmhsZTQ4R29SbWMx?=
 =?utf-8?B?aXljYU9oRUpDR1NWVExIVzV2WFl0SmYvbDlpSGtSeWxJK094TWJiTGJtUmNC?=
 =?utf-8?B?TlBDMDh1UG01RGs5MGltTHArQ0ZVWXNycENvdFdRWjZZNjA5K0theHN0bWxB?=
 =?utf-8?B?d0ZyRWJXNEpaZkg5OEVwRkJZVWl5VFo2aFJQVExyOGo4c3RpTXRmSy9IVEJ0?=
 =?utf-8?B?TUJhR2lNSU1sTmQ2SHRzYmtubFNXV0luUFlBU0N6UjZ3QlZXU3NiZVBkNmts?=
 =?utf-8?B?QjlVNXVFVFVPRkN5WDU5eGpzYXJEZSt5Z1piQVdjYmJITHdlK0VZR2lrTExI?=
 =?utf-8?B?NUdPUlhMb0dJMjBoaVp4N2dsM1lxS0xiVWhBUFBBMXpJVzNRRGU1c0Y3ZlV5?=
 =?utf-8?B?N0JhYVV4bkJwck9FT2hialVJbHc5elJSUlFPWDg2b1BDek1vaS9HQ2VzdFlv?=
 =?utf-8?B?dU1CeTJEU2F4LzhmRWc4YXhVajF1YjQ2aFMvNXRPV1N6RDFKbm9neUROdDF6?=
 =?utf-8?B?NUFRaENFZDU1bnVWRkxkL1g2RG9yMW1tTWdWKzE1SDBBR1V1dVV2bXR0bnp5?=
 =?utf-8?B?UW03WkRqUUtHTE44WHg3THltQnlXM0RCb1ZYc0FyTU0xQ05wV0RxcUh0YUNJ?=
 =?utf-8?B?cE5CSmFMWnJpNmlnNFBwSVZiRTRsazNCRHFFUFM2MGllSmFUQ0J1NTU4dFFU?=
 =?utf-8?B?SWRuc1NzMVBGWUpENTVBVitjdDhqM3pNRXpwTzVrWVZYOExxbnZIVEFJdVJj?=
 =?utf-8?B?Y2RQTVZUSTk2d0g0NmFjN3FEYVlidGhnMENLd0VidGYxRDkyazJVYXZhT1Rl?=
 =?utf-8?B?MG1Ud2Fpbng1cERkQ0ZmcHQxaklvYmxnYlc4SmxQNkVlNmtoTnJZYTRHTjQ0?=
 =?utf-8?B?NTN0ZkdDUXkzc1J1bGlPZDkyOUJhSEQxQjlydE5nQlQ0clk3ZWR1Q09UdlFI?=
 =?utf-8?B?SWhLU1RCV0tRekpnNEVkWHM2dVRjZFlUSitiazV4K05ZS1Z5ajJ2S0VudUtz?=
 =?utf-8?B?YVZXUnV2RFVmM0syR0tXeEN3dit5eE5hRjB4bWlML1VsbVFsWHR5bG5vKzVv?=
 =?utf-8?B?djB5aGdpck90Q3Z6VUhmd1VlZ2JyWHdHOWx3UFV5ejVESlFISldEWEEya2tD?=
 =?utf-8?B?eGN0SHpITCtXWFE5eWlueUJKM0xsamVQWHVtSmwrSXBYM2NqRUk3NkR4TFc2?=
 =?utf-8?B?WjZueTJnNkFTQkpjaDZUYXZaOENUVHZuZHgzMTE2UHQ1dnhBVmFzRW5QK2Rj?=
 =?utf-8?B?UW1BMmxtSEMvUjU1NlMwaVp0UjFjR28zZ2FCdXNML2hVWVhrT3FXSmhBVmE5?=
 =?utf-8?B?UlZVc3NrOHhPWm1LbWphVWNKSldkQlhDcUVaREpPcW9ERkN3Q293VzgwbjJE?=
 =?utf-8?B?RHdSNExSdCtQaEFtbE5Fek02V2RZZ2VTOHRPb1BLYWhsbXp4Q1N6SnQ1Z2oz?=
 =?utf-8?B?ellwd21kL1UwUlYxclhZL1ozOVplVmcyZnZKTjArVzVkVkN2a3FiclBhN1FW?=
 =?utf-8?B?TTRObm9FbVNXL1lZVHZUNG92aHZiVjZaZllhNkQ5WlRxdU9TOGkxQ2swZXg1?=
 =?utf-8?B?SC9ka1dvb2IrU1ZpelEydlUzMU10N2kvUFc2TDQ0NkhFS0R0WFlTTDV1NHhk?=
 =?utf-8?B?Y2haVWM3T2xNUTUzZXVxTDVPNiszZnNsbDBNU3VaaGJyc01yempUYW9MTHRG?=
 =?utf-8?Q?IFh4oA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1h5VjcrOFU2ZFBUVWNLZkk1OWdoRmlSUWsrSjVKekdMZ082cTdqSmhma1Fz?=
 =?utf-8?B?aENZV3VDT1BxVmtrak1ueVAybVVYZ2JyYkVuRlhKeFhFbkRSS25zU1JpVDJt?=
 =?utf-8?B?b2dxd1lYSVpFeDJncnhyUEFDaDkzQWtreEg3bHgwRGRJNXBtc0hOdXZGN3ll?=
 =?utf-8?B?ZXJXdThqdThCNE5vWHdqYkVZclpWTTJUL3JhWTBWdVlJajdvM3hoTlNZMXdq?=
 =?utf-8?B?QXlUeE5KcnpiQnN1MVNiOWNhUEFlMEVWSlNLSGwxREo3R1M5TWpWZVcxYXAz?=
 =?utf-8?B?WnhqNDcwUC96aDd1am9XSUIrTlA1YnpEVzVrS1hSTGlURERoUExjaHhSY3hk?=
 =?utf-8?B?S2hERjYrRGpva0I3V2xvcnVUR01WM1lhbjBxU1FRdWRRQzIzcS81UWROWVRF?=
 =?utf-8?B?ZDRESVR5WmRXUmJwUWV0OG1kN1J6eTR2ekpxSXRMOGNudG1oR0thKzRWdnc4?=
 =?utf-8?B?N2hKWWVBN2FEVUswYUhVMDNjL1hVdzR3bEErMFFLU0JmOUVndFVmaHlxUjJY?=
 =?utf-8?B?eUZrMDR2dU13cmJqaU4xMDV1T09XcVJtTVJuRERFVVR4OENUMXVZaFBnL1p4?=
 =?utf-8?B?ZGJWYmR6OCtaL3lDd1R5b3RXRlI5b3RTSkpOZ3ZKdWJFVktMeEhFbTZweHdt?=
 =?utf-8?B?UzhHRWFnWlhSWGZwM2tZNFh2VmVxbkhKaG4vUnhUd0J5VlBkeHdJQ1dSOGNr?=
 =?utf-8?B?bmRwdmJXRHozQ21ESytHQmJWZ3Zydk1PRitUTlJRUEZjQjhCRmxjMkRrQUZD?=
 =?utf-8?B?eDBhL3dzZjh3SmloOHovYlR4QjVZb2c5RmFCSTAxbmdTcXdIYWhwUWp2NVh3?=
 =?utf-8?B?TldFUTA2aWw4dTlIYXlvL1BPUUkwTi9ZMjFJR2M4YU9KbnFlbnZiY1EveTRY?=
 =?utf-8?B?RW1qMmQ4VWxRamhLQ3ROaU41OFVGQ3g4Um5ydDZRbUhOSjhTby93OWFEZ1ZH?=
 =?utf-8?B?R0xaRERRZE8zL1k2YjEyUDYwZmUwRVcvQWFlUkR5WlI3cnhGNHZiRnBHQi9U?=
 =?utf-8?B?KzN2Y0FhT1dXaEY3QlhXVWRQMFVtL09mYXdUd0RnT24xK0dxcmJXLzJTRndh?=
 =?utf-8?B?UDJGcExZQy9TeUt5dERRRk1wczVSUHgwYm9Sc1dIS09SbTZGemtDY01qVzRD?=
 =?utf-8?B?aTZBQnZLM29NQUVNY3RpQjhWTVVKTmRDZnBqMjBoTmNhUnZ4QjM5NVpoK0hk?=
 =?utf-8?B?VzhuTnUwWlE0REd4QU1rOUROQWR2R0g1R2NzWjY4dmM5TXdwT2U1VnZwaXRV?=
 =?utf-8?B?T1hmU3p4MlVYcEp3eFMrQWJZUXNLaU82RmtXOU5WUVdrRGZBTmNWQVBUbkN5?=
 =?utf-8?B?RFl3WWFtd2t3TkwwaHZJTDJuVkNTbmIvQzBMRmJBK3NiNFlWZW1NVDJxNXBZ?=
 =?utf-8?B?UWxhelN3dytMTkR6UWtyY3Z3YUNmRzlsRHU4NGFPMVdqZ1ZrUk5jYkREbHpD?=
 =?utf-8?B?UCszbkJ3THRPL1JsV283NTJkUVYrN0wyc08vREVwTDQ0YngwdjlOL2J1Y3o2?=
 =?utf-8?B?NStIWjhxSitFYzBNMGJORDJWcmJEcktqQ2NBb0NiN3h6MTRyS05qZWkxampH?=
 =?utf-8?B?TCtWSHoxeUU0aEY5eUlRSHc0Yzl3ZzVhUGN4SmxQY2VxMjV6SitZZ05OcVVq?=
 =?utf-8?B?aGR4Q0Q5NU1mRFFYYU5ZcCtTZVc1RTZ5QTJDek5pNXVyWkx0Wmx0b1pRQzlw?=
 =?utf-8?B?bFZlcHFFaDcyVmU5clRyTUs1VTI3YjRWb0twQXZqOEFGYnNzTnkrYWk0amNS?=
 =?utf-8?B?WHlITzFaZ1dML0M4TVdVVmtPMDJPU0pJemZRKzlLY2V0Q0VtaDZZMy8rZ0Y1?=
 =?utf-8?B?Y1ljV2RkWmFac2ZtNW5DbFU5MjYrT01TTHcrRDg3ZDlyQ3ordG03eVliRUVt?=
 =?utf-8?B?NVZPa0hObzRiOHcya2syTk4zeE1nUEI5TW10dG1pT2xjR3MvSXNaUXNuWXpH?=
 =?utf-8?B?cHd2NFVNVzdDeW9VdElEOGd3dnh2VjNCRGFLcmRMS1cvQVJtdXppbm54Zy9N?=
 =?utf-8?B?UHkyM1Vld1UxZW9oTzdnSnhxWllJUjB2N1lBVHFkRmhpdVgyU2VkdGdFdEI1?=
 =?utf-8?B?bllFa1lpYU1LUmhHVFhlbElBaStCaXRWQ3h2STRqOTN2Q1FRNzg0QThRM2Yx?=
 =?utf-8?B?bG9iZHpsL1g2M2FTd01YV2pYSXY2cjhubTZQZ28xWnRSc2VWazYrd3puRjdJ?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8349835043E6454986CA7DE3C48C531C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RdRGLsWPhd8a9NLTSzBF8TQ7PctLHsX/qBGaj4weDlmv/1IT/EFPuuobOwbIrHBzbPtF8WdyVJQ2Box4KKlTD3t2Y4zwHaV8cwpeCPTovXmgwLRshKX1gMrSLf47SB6IWVykmNopyYBPSAVbNzQm0ZupiqxDfxEUPiTOyyj0k4I4oTTJmt2GB0FA7Y2S/CWUMwr8ubUSS15nKdjykaa4Oaa+Wb+PbLuprXwAultedTq6ZYAP2luAPoBmgQiYe6IEbqCI4QnVs/kgKTo/Ui3wNoXxzZOFSYTU8z31i75MyZgNZ4n+dnECZaN+rxxufnaaXo+sX0oIdJs7paGTQK8h2CCoKTHvr+M+jYFvSiu6kFCLjZzQ9fxgschvxxo34pUhRzK5NigfTg6sY4d/cJvdiwr0IP+vPf4oY6dEXygcAL0DuqWuNuvACgPpceHqi/11f/m4k57tGNzcbdewyjZdyaHLRPj91WscWrXwdaLuweokoY4V48tQQOtHih5tizULtcSBm7x4RB/ZpHk5N8hIePjRWZBnYbSVgw9msvJNmEP/cpBiuAPC8o5+EZRxpa0TIXoztaWR2GVaGbZaN0odXbQPPwWYcse4UuPTqnRc6rD+p8C7RL8YUd7TiurrDMQh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220f21b2-ba4f-4263-7bad-08de36ccaa31
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 02:42:58.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQ27pnTJeuLNUydX/SBrFvtoMjJThtGlD1tqpOCRvRz4Crf4PZvrn6dh/cYsB+q0NbytHkKxEOnWMw9Jo7clAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7993

T24gVGh1IERlYyA0LCAyMDI1IGF0IDk6NDIgUE0gSlNULCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IEluIGNhc2Ugb2YgYSB6b25lZCBSQUlELCBpdCBjYW4gaGFwcGVuIHRoYXQgYSBkYXRh
IHdyaXRlIGlzIHRhcmdldGluZyBhDQo+IHNlcXVlbnRpYWwgd3JpdGUgcmVxdWlyZWQgem9uZSBh
bmQgYSBjb252ZW50aW9uYWwgem9uZS4gSW4gdGhpcyBjYXNlIHRoZQ0KPiBiaW8gd2lsbCBiZSBt
YXJrZWQgYXMgUkVRX09QX1pPTkVfQVBQRU5EIGJ1dCBmb3IgdGhlIGNvbnZlbnRpb25hbCB6b25l
LA0KPiB0aGlzIG5lZWRzIHRvIGJlIFJFUV9PUF9XUklURS4NCj4NCj4gVGhlIHNldHRpbmcgb2Yg
UkVRX09QX1pPTkVfQVBQRU5EIGlzIGRlZmVycmVkIHRvIHRoZSBsYXN0IHBvc3NpYmxlIHRpbWUg
aW4NCj4gYnRyZnNfc3VibWl0X2Rldl9iaW8oKSwgYnV0IHRoZSBkZWNpc2lvbiBpZiB3ZSBjYW4g
dXNlIHpvbmUgYXBwZW5kIGlzDQo+IGNhY2hlZCBpbiBidHJmc19iaW8uDQo+DQo+IENjOiBOYW9o
aXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+DQo+IEZpeGVzOiBlOWI5YjkxMWUwM2MgKCJidHJmczogYWRkIHJhaWQgc3Ry
aXBlIHRyZWUgdG8gZmVhdHVyZXMgZW5hYmxlZCB3aXRoIGRlYnVnIGNvbmZpZyIpDQo+IFNpZ25l
ZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+
DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90
YUB3ZGMuY29tPg==

